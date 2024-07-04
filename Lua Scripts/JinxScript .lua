local nativeFetchStartTime = util.current_time_millis()
util.require_natives("3095a", "g")
local nativeFetchEndTime = util.current_time_millis() - nativeFetchStartTime
util.log($"[JinxScript.pluto] 本地函数 {nativeFetchEndTime}ms")
pluto_use "0.9.1"
native_invoker.accept_bools_as_ints(true)

local isDebugMode = false
local joaat, toast, yield, draw_debug_text, reverse_joaat = util.joaat, util.toast, util.yield, util.draw_debug_text, util.reverse_joaat

local supported_game_version <const> = "1.69-3258"
if (game_version := menu.get_version().game) != supported_game_version then
	util.toast($"脚本版本 {supported_game_version}. 游戏版本 {game_version}.\n⚠可能无法按预期工作")
end

local sigscanStartTime = util.current_time_millis()
local CWeaponDamageEventTrigger = memory.rip(memory.scan("E8 ? ? ? ? 44 8B 7D 80") + 1)
local ppCNetworkObjectMgr__sm_Instance = memory.rip(memory.scan("48 8B 0D ? ? ? ? 45 33 C0 E8 ? ? ? ? 48 8B F8") + 3) -- credit to sapphire
local allowDuckingAddr = memory.read_long(memory.read_long(memory.rip(memory.scan("01 48 8B 05 ? ? ? ? 48 8B 48 18") + 4)) + 0x18) -- this too lol
local sigscanEndTime = util.current_time_millis() - sigscanStartTime
util.log($"[JinxScript.pluto] 签名扫描 {sigscanEndTime}ms")

local invisibility = menu.ref_by_path("Self>Appearance>Invisibility")
local levitation = menu.ref_by_path("Self>Movement>Levitation>Levitation")
local vehInvisibility = menu.ref_by_path("Vehicle>Invisibility")
local positonSpoofing = menu.ref_by_path("Online>Spoofing>Position Spoofing>Position Spoofing")
local spoofedPos = menu.ref_by_path("Online>Spoofing>Position Spoofing>Spoofed Position")
local superJump = menu.ref_by_path("Self>Movement>Super Jump")
local gracefulLanding = menu.ref_by_path("Self>Movement>Graceful Landing")

local GlobalplayerBD = 2657971
local GlobalplayerBD_FM = 1845281
local GlobalplayerBD_FM_3 = 1887305

enum Labels begin
	CMDOTH = -1974706693,
	BLIPNFND = -1331937481,
	DT_T = -766393174,
	PLYNVEH = 1067523721,
	STNDUSR = 1729001290,
	TOOFAST = 1669138996
end

enum DRIVINGMODE begin
	DF_StopForCars					= 1,
	DF_StopForPeds					= 2,
	DF_SwerveAroundAllCars			= 4,
	DF_SteerAroundStationaryCars	= 8,
	DF_SteerAroundPeds				= 16,
	DF_SteerAroundObjects			= 32,
	DF_DontSteerAroundPlayerPed		= 64,
	DF_StopAtLights					= 128,
	DF_GoOffRoadWhenAvoiding		= 256,
	DF_DriveIntoOncomingTraffic		= 512,
	DF_DriveInReverse				= 1024,
	DF_UseWanderFallbackInsteadOfStraightLine = 2048,
	DF_AvoidRestrictedAreas			= 4096,
	DF_PreventBackgroundPathfinding		= 8192,
	DF_AdjustCruiseSpeedBasedOnRoadSpeed = 16384,
	DF_UseShortCutLinks				=  262144,
	DF_ChangeLanesAroundObstructions = 524288,
	DF_UseSwitchedOffNodes			=  2097152,
	DF_PreferNavmeshRoute			=  4194304,
	DF_PlaneTaxiMode				=  8388608,
	DF_ForceStraightLine			= 16777216,
	DF_UseStringPullingAtJunctions	= 33554432,
	DF_AvoidHighways				= 536870912,
	DF_ForceJoinInRoadDirection		= 1073741824
end

enum ENTER_EXIT_VEHICLE_FLAGS begin
	ECF_RESUME_IF_INTERRUPTED = 1,
	ECF_WARP_ENTRY_POINT = 2,
	ECF_JACK_ANYONE = 8,
	ECF_WARP_PED = 16,
	ECF_DONT_WAIT_FOR_VEHICLE_TO_STOP = 64,
	ECF_DONT_CLOSE_DOOR = 256,
	ECF_WARP_IF_DOOR_IS_BLOCKED = 512,
	ECF_JUMP_OUT = 4096,
	ECF_DONT_DEFAULT_WARP_IF_DOOR_BLOCKED = 65536,
	ECF_USE_LEFT_ENTRY = 131072,
	ECF_USE_RIGHT_ENTRY = 262144,
	ECF_JUST_PULL_PED_OUT = 524288,
	ECF_BLOCK_SEAT_SHUFFLING = 1048576,
	ECF_WARP_IF_SHUFFLE_LINK_IS_BLOCKED = 4194304,
	ECF_DONT_JACK_ANYONE = 8388608,
	ECF_WAIT_FOR_ENTRY_POINT_TO_BE_CLEAR = 16777216
end

enum eDamageFlags begin
	DF_None								= 0,
	DF_IsAccurate						= 1,
	DF_MeleeDamage						= 2,
	DF_SelfDamage						= 4,
	DF_ForceMeleeDamage					= 8,
	DF_IgnorePedFlags					= 16,
	DF_ForceInstantKill					= 32,
	DF_IgnoreArmor						= 64,
	DF_IgnoreStatModifiers				= 128,
	DF_FatalMeleeDamage					= 256,
	DF_AllowHeadShot					= 512,
	DF_AllowDriverKill					= 1024,
	DF_KillPriorToClearedWantedLevel	= 2048,
	DF_SuppressImpactAudio				= 4096,
	DF_ExpectedPlayerKill				= 8192,
	DF_DontReportCrimes					= 16384,
	DF_PtFxOnly							= 32768,
	DF_UsePlayerPendingDamage			= 65536,
	DF_AllowCloneMeleeDamage			= 131072,
	DF_NoAnimatedMeleeReaction			= 262144,
	DF_IgnoreRemoteDistCheck			= 524288,
	DF_VehicleMeleeHit					= 1048576,
	DF_EnduranceDamageOnly				= 2097152,
	DF_HealthDamageOnly					= 4194304,
	DF_DamageFromBentBullet				= 8388608
end

enum VEHICLE_CLASS begin
	VC_COMPACT = 0,
	VC_SEDAN,
	VC_SUV,
	VC_COUPE,
	VC_MUSCLE,
	VC_SPORT_CLASSIC,
	VC_SPORT,
	VC_SUPER,
	VC_MOTORCYCLE,
	VC_OFF_ROAD,
	VC_INDUSTRIAL,
	VC_UTILITY,
	VC_VAN,
	VC_CYCLE,
	VC_BOAT,
	VC_HELICOPTER,
	VC_PLANE,
	VC_SERVICE,
	VC_EMERGENCY,
	VC_MILITARY,
	VC_COMMERCIAL,
	VC_RAIL,
	VC_OPEN_WHEEL
end

enum TransitionState begin
	TRANSITION_STATE_EMPTY = 0,
	TRANSITION_STATE_SP_SWOOP_UP = 1,
	TRANSITION_STATE_MP_SWOOP_UP = 2,
	TRANSITION_STATE_CREATOR_SWOOP_UP = 3,
	TRANSITION_STATE_PRE_HUD_CHECKS = 4,
	TRANSITION_STATE_WAIT_HUD_EXIT = 5,
	TRANSITION_STATE_WAIT_FOR_SUMMON = 6,
	TRANSITION_STATE_SP_SWOOP_DOWN = 7,
	TRANSITION_STATE_MP_SWOOP_DOWN = 8,
	TRANSITION_STATE_CANCEL_JOINING = 9,
	TRANSITION_STATE_RETRY_LOADING = 10,
	TRANSITION_STATE_RETRY_LOADING_SLOT_1 = 11,
	TRANSITION_STATE_RETRY_LOADING_SLOT_2 = 12,
	TRANSITION_STATE_RETRY_LOADING_SLOT_3 = 13,
	TRANSITION_STATE_RETRY_LOADING_SLOT_4 = 14,
	TRANSITION_STATE_WAIT_ON_INVITE = 15,
	TRANSITION_STATE_PREJOINING_FM_SESSION_CHECKS = 16,
	TRANSITION_STATE_LOOK_FOR_FRESH_JOIN_FM = 17,
	TRANSITION_STATE_LOOK_TO_JOIN_ANOTHER_SESSION_FM = 18,
	TRANSITION_STATE_CONFIRM_FM_SESSION_JOINING = 19,
	TRANSITION_STATE_WAIT_JOIN_FM_SESSION = 20,
	TRANSITION_STATE_CREATION_ENTER_SESSION = 21,
	TRANSITION_STATE_PRE_FM_LAUNCH_SCRIPT = 22,
	TRANSITION_STATE_FM_TEAMFULL_CHECK = 23,
	TRANSITION_STATE_START_FM_LAUNCH_SCRIPT = 24,
	TRANSITION_STATE_FM_TRANSITION_CREATE_PLAYER = 25,
	TRANSITION_STATE_IS_FM_AND_TRANSITION_READY = 26,
	TRANSITION_STATE_FM_SWOOP_DOWN = 27,
	TRANSITION_STATE_POST_BINK_VIDEO_WARP = 28,
	TRANSITION_STATE_FM_FINAL_SETUP_PLAYER = 29,
	TRANSITION_STATE_MOVE_FM_TO_RUNNING_STATE = 30,
	TRANSITION_STATE_FM_HOW_TO_TERMINATE = 31,
	TRANSITION_STATE_START_CREATOR_PRE_LAUNCH_SCRIPT_CHECK = 32,
	TRANSITION_STATE_START_CREATOR_LAUNCH_SCRIPT = 33,
	TRANSITION_STATE_CREATOR_TRANSITION_CREATE_PLAYER = 34,
	TRANSITION_STATE_IS_CREATOR_AND_TRANSITION_READY = 35,
	TRANSITION_STATE_CREATOR_SWOOP_DOWN = 36,
	TRANSITION_STATE_CREATOR_FINAL_SETUP_PLAYER = 37,
	TRANSITION_STATE_MOVE_CREATOR_TO_RUNNING_STATE = 38,
	TRANSITION_STATE_PREJOINING_TESTBED_SESSION_CHECKS = 39,
	TRANSITION_STATE_LOOK_FOR_FRESH_JOIN_TESTBED = 40,
	TRANSITION_STATE_LOOK_FOR_FRESH_HOST_TESTBED = 41,
	TRANSITION_STATE_LOOK_TO_JOIN_ANOTHER_SESSION_TESTBED = 42,
	TRANSITION_STATE_LOOK_TO_HOST_SESSION_TESTBED = 43,
	TRANSITION_STATE_CONFIRM_TESTBED_SESSION_JOINING = 44,
	TRANSITION_STATE_WAIT_JOIN_TESTBED_SESSION = 45,
	TRANSITION_STATE_START_TESTBED_LAUNCH_SCRIPT = 46,
	TRANSITION_STATE_TESTBED_TRANSITION_CREATE_PLAYER = 47,
	TRANSITION_STATE_IS_TESTBED_AND_TRANSITION_READY = 48,
	TRANSITION_STATE_TESTBED_SWOOP_DOWN = 49,
	TRANSITION_STATE_TESTBED_FINAL_SETUP_PLAYER = 50,
	TRANSITION_STATE_MOVE_TESTBED_TO_RUNNING_STATE = 51,
	TRANSITION_STATE_TESTBED_HOW_TO_TERMINATE = 52,
	TRANSITION_STATE_QUIT_CURRENT_SESSION_PROMPT = 53,
	TRANSITION_STATE_WAIT_FOR_TRANSITION_SESSION_TO_SETUP = 54,
	TRANSITION_STATE_TERMINATE_SP = 55,
	TRANSITION_STATE_WAIT_TERMINATE_SP = 56,
	TRANSITION_STATE_KICK_TERMINATE_SESSION = 57,
	TRANSITION_STATE_TERMINATE_SESSION = 58,
	TRANSITION_STATE_WAIT_TERMINATE_SESSION = 59,
	TRANSITION_STATE_TERMINATE_SESSION_AND_HOLD = 60,
	TRANSITION_STATE_TERMINATE_SESSION_AND_MOVE_INTO_HOLDING_STATE = 61,
	TRANSITION_STATE_TEAM_SWAPPING_CHECKS = 62,
	TRANSITION_STATE_RETURN_TO_SINGLEPLAYER = 63,
	TRANSITION_STATE_WAIT_FOR_SINGLEPLAYER_TO_START = 64,
	TRANSITION_STATE_WAITING_FOR_EXTERNAL_TERMINATION_CALL = 65,
	TRANSITION_STATE_TERMINATE_MAINTRANSITION = 66,
	TRANSITION_STATE_WAIT_FOR_DIRTY_LOAD_CONFIRM = 67,
	TRANSITION_STATE_DLC_INTRO_BINK = 68,
	TRANSITION_STATE_SPAWN_INTO_PERSONAL_VEHICLE = 69
end

enum DUCK_TOGGLE begin
    TOGGLE_DUCK_AUTO = -1,
    TOGGLE_DUCK_OFF,
    TOGGLE_DUCK_ON
end

function isNetPlayerOk(playerID, assert_playing = false, assert_done_transition = true) -- credit to sapphire *sighs* yet again
	if not NETWORK_IS_PLAYER_ACTIVE(playerID) then return false end
	if assert_playing and not IS_PLAYER_PLAYING(playerID) then return false end
	if assert_done_transition then
		if playerID == memory.read_int(memory.script_global(2672855 + 3)) then -- Global_2672855.f_3
			return memory.read_int(memory.script_global(2672855 + 2)) != 0 -- -- Global_2672855.f_2
		elseif memory.read_int(memory.script_global(GlobalplayerBD + 1 + (playerID * 465))) != 4 then -- Global_2657971[iVar0 /*465*/] != 4
			return false
		end
	end
	return true
end

local function callVirtualFunction(pObject: int, iPosition: int, ...args) -- credit to sapphire for these 3 functions too 
	for i, arg in args do
		if type(arg) == "boolean" then
			args[i] = arg ? 1 : 0
		end
	end
	return util.call_foreign_function(memory.read_long(memory.read_long(pObject) + 8 * iPosition), pObject, table.unpack(args))
end

local function unregisterNetworkedEntity(pEntity: int): void
	callVirtualFunction(memory.read_long(ppCNetworkObjectMgr__sm_Instance), 6, memory.read_long(pEntity + 0xD0), 15)
end

local m = memory.alloc_int()
function deleteEntityLocally(entity: int): void 
	local pEntity = entities.handle_to_pointer(entity)
	if pEntity == 0 then
		return
	end
	unregisterNetworkedEntity(pEntity)
	m:writeInt(entity)
	DELETE_ENTITY(m)
end

function bitTest(bits, place)
	return (bits & (1 << place)) != 0
end

function setBit(addr: number, bit: number)
	memory.write_int(addr, memory.read_int(addr) | 1 << bit)
end

function clearBit(addr: number, bit: number)
	memory.write_int(addr, memory.read_int(addr) ~ 1 << bit)
end

function isPlayerSpectating(playerID)
	return bitTest(memory.read_int(memory.script_global(GlobalplayerBD + 1 + (playerID * 465) + 200)), 2) -- BitTest(Global_2657971[bParam0 /*465*/].f_200, 2)
end

function getPlayerJobPoints(playerID)
	return memory.read_int(memory.script_global(GlobalplayerBD_FM + 1 + (playerID * 883) + 9))  -- Global_1845281[PLAYER::PLAYER_ID() /*883*/].f_9
end

function isPlayerUsingOrbitalCannon(playerID)
	return bitTest(memory.read_int(memory.script_global(GlobalplayerBD + 1 + (playerID * 465) + 426)), 0) -- Global_2657971[PLAYER::PLAYER_ID() /*465*/].f_426
end

function isPlayerRidingRollerCoaster(playerID)
	return bitTest(memory.read_int(memory.script_global(GlobalplayerBD_FM + 1 + (playerID * 883) + 879)), 15) -- Global_1845281[PLAYER::PLAYER_ID() /*883*/].f_879
end

function isPlayerSolicitingProstitute(playerID)
	return memory.read_int(memory.script_global(GlobalplayerBD + 1 + (playerID * 465) + 430)) != 0 -- Global_2657921[PLAYER::PLAYER_ID() /*465*/].f_430
end

function isPlayerUsingBallisticEquipment(playerID)
	return memory.script_global(GlobalplayerBD_FM_3 + 1 + (playerID * 610) + 587) -- Global_1887305[PLAYER::PLAYER_ID() /*610*/].f_587
end

function getPlayerCurrentInterior(playerID)
	if not isNetPlayerOk(playerID) then return end -- to prevent random access violations
	return memory.read_int(memory.script_global(GlobalplayerBD + 1 + (playerID * 465) + 246)) -- Global_2657971[bVar0 /*465*/].f_246)
end

function getPlayerCurrentShop(playerID)
	if not isNetPlayerOk(playerID) then return end
	return memory.read_int(memory.script_global(GlobalplayerBD + 1 + (playerID * 465) + 247)) -- Global_2657921[bVar0 /*465*/].f_247
end

function getPlayerProperty(playerID)
	return memory.script_global(GlobalplayerBD_FM + 1 + (playerID * 883) + 268 + 35)  -- Global_1845281[PLAYER::PLAYER_ID() /*883*/].f_268.f_35)
end

function blipInteriorID(playerID)
	return memory.script_global(GlobalplayerBD + 1 + (playerID * 465) + 74 + 6) -- Global_2657971[bParam0 /*465*/].f_74.f_6
end

function blipInteriorPos(playerID)
	return memory.script_global(GlobalplayerBD + 1 + (playerID * 465) + 74 + 7) -- Global_2657971[bParam0 /*465*/].f_74.f_7
end

function isFreemodeActive(playerID)
	return NETWORK_IS_PLAYER_A_PARTICIPANT_ON_SCRIPT(playerID, "freemode", -1)
end

function getTransitionState()
	return memory.read_int(memory.script_global(1575011))  
end

function manhattanDistance(v1, v2)
    return math.abs(v1.x - v2.x) + math.abs(v1.y - v2.y) + math.abs(v1.z - v2.z)
end

local getTransitionStateName
do
	local names <const> = TransitionState:vkmap()
	function getTransitionStateName(transitionState) -- credit to sapphire for this function
		return names[transitionState]:sub(18)
	end
end

function isPlayerInPassiveMode(playerID)
	return memory.read_int(memory.script_global(GlobalplayerBD_FM_3 + 1 + (playerID * 610) + 8)) == 1 -- Global_1887305[PLAYER::PLAYER_ID() /*610*/].f_8
end

function isPlayerInInterior(playerID)
	if not isNetPlayerOk(playerID) then return end
    return GET_INTERIOR_GROUP_ID(getPlayerCurrentInterior(playerID)) == 0 and getPlayerCurrentInterior(playerID) != 0 or players.is_in_interior(playerID)
end

function isPlayerInCutscene(playerID)
	return NETWORK_IS_PLAYER_IN_MP_CUTSCENE(playerID) or IS_PLAYER_IN_CUTSCENE(playerID)
end

function isPlayerGodmode(playerID)
	local pos = players.get_position(playerID)
	local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
	if isNetPlayerOk(playerID) and (players.is_godmode(playerID) or entities.is_invulnerable(ped)) and not isPlayerInInterior(playerID) and not isPlayerInCutscene(playerID) 
	and isFreemodeActive(playerID) and not players.is_using_rc_vehicle(playerID) and not isPlayerRidingRollerCoaster(playerID) and pos.z > 0.0 then
		return true
	end
	return false
end

function getSeatPedIsIn(ped)
	local vehicle = GET_VEHICLE_PED_IS_USING(ped)
	if vehicle == 0 then
		return nil
	end
	local num_of_seats = GET_VEHICLE_MODEL_NUMBER_OF_SEATS(GET_ENTITY_MODEL(vehicle))
	for i = -1, num_of_seats - 1 do
		local ped_in_seat = GET_PED_IN_VEHICLE_SEAT(vehicle, i)
		if ped_in_seat == ped then
			return i
		end
	end
end

function isPlayerInAnyVehicle(playerID)
	local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
	return IS_PED_IN_ANY_VEHICLE(ped) and not IS_REMOTE_PLAYER_IN_NON_CLONED_VEHICLE(playerID)
end

function isDetectionPresent(playerID, detection)
	if players.exists(playerID) and menu.player_root(playerID):isValid() then
		for menu.player_root(playerID):getChildren() as cmd do
			if cmd:getType() == COMMAND_LIST_CUSTOM_SPECIAL_MEANING and cmd:refByRelPath(detection):isValid() and players.exists(playerID) then
				return true
			end
		end
	end
	return false
end

function loadPtfxAsset(assetName)
	while not HAS_NAMED_PTFX_ASSET_LOADED(assetName) do
		REQUEST_NAMED_PTFX_ASSET(assetName)
		yield()
	end
end

function requestAnimDict(animDict)
	while not HAS_ANIM_DICT_LOADED(animDict) do
		REQUEST_ANIM_DICT(animDict)
		yield()
	end
end

function requestClipset(clipset)
	while not HAS_CLIP_SET_LOADED(clipset) do
		REQUEST_CLIP_SET(clipset)
		yield()
	end
end

function getTeamID(playerID)
	if not isNetPlayerOk(playerID) then return end
	local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
	local pPed = entities.handle_to_pointer(ped)
	local net_obj = memory.read_long(pPed + 0xD0)
	if net_obj == 0 then return end
	local teamID = memory.read_byte(net_obj + 0x469)
	if net_obj != 0 and teamID != 6 then
		return teamID
	end
end

function getInstanceID(playerID)
	if not isNetPlayerOk(playerID) then return end 
	local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
	local pPed = entities.handle_to_pointer(ped)
	local net_obj = memory.read_long(pPed + 0xD0)
	if net_obj == 0 then return end
	local instanceID = memory.read_byte(net_obj + 0x46A)
	if net_obj != 0 and instanceID != 64 then
		return instanceID
	end
end

local randomPeds = {
	joaat("a_f_y_topless_01"),
	joaat("s_m_m_movalien_01"),
	joaat("s_m_y_mime"), 
	joaat("u_m_y_militarybum"),
	joaat("a_m_y_indian_01"),
	joaat("s_m_y_clown_01"),
	joaat("u_m_y_burgerdrug_01"),
	joaat("u_m_m_yulemonster")
}

function createRandomPed(pos)
	local mdlHash = randomPeds[math.random(#randomPeds)]
	util.request_model(mdlHash)
	return entities.create_ped(26, mdlHash, pos, 0)
end


function godKill(playerID)
	local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
	local ping = ROUND(NETWORK_GET_AVERAGE_PING(playerID))
	local timer = (ping > 300) ? (util.current_time_millis() + 5000) : (util.current_time_millis() + 3000)
	local pPed =  entities.handle_to_pointer(ped)
	local pedPtr = entities.handle_to_pointer(players.user_ped())
	yield()
	yield()
	repeat
		util.trigger_script_event(1 << playerID, {800157557, players.user(), 225624744, math.random(0, 9999)})
		util.call_foreign_function(CWeaponDamageEventTrigger, pedPtr, pPed, pPed + 0x90, 0, 1, joaat("weapon_pistol"), 500.0, 0, 0, DF_IsAccurate | DF_IgnorePedFlags | DF_SuppressImpactAudio | DF_IgnoreRemoteDistCheck, 0, 0, 0, 0, 0, 0, 0, 0.0)
		if util.current_time_millis() > timer then
			toast($"{players.get_name(playerID)} 无法删除无敌 :/")
			timer = util.current_time_millis() + 3000
			return
		end
		yield()
	until IS_PED_DEAD_OR_DYING(ped)
	yield()
	yield()
	timer = util.current_time_millis() + 3000
end

function triggerDistanceBasedTeleport(playerID, scriptEvent)
	local joinOrg = menu.ref_by_rel_path(menu.player_root(playerID), "Join CEO/MC")
	local timer = util.current_time_millis() + 1000
	joinOrg.value = true
	repeat
		if util.current_time_millis() > timer then
			joinOrg.value = false
			return
		end
		yield()
	until players.get_boss(players.user()) != -1
	timer = util.current_time_millis() + 1000
	local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
	local pos = players.get_position(players.user())
	local pPos = players.get_position(playerID)
	pPos.z -= 10
	invisibility:setState("Locally Visible")
	SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), pPos, false, false, false)
	repeat
		if util.current_time_millis() > timer then
			joinOrg.value = false
			invisibility:setState("Disabled")
			SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), pos, false, false, false)
			return
		end
		yield()
	until DOES_ENTITY_EXIST(ped)
	yield(500)
	util.trigger_script_event( 1 << playerID, scriptEvent)
	SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), pos, false, false, false)
	invisibility:setState("Disabled")
	joinOrg.value = false
end

function doesVehicleHaveImaniTech(vehicle_model)
	switch vehicle_model do
	case joaat("deity"):
	case joaat("granger2"):
	case joaat("buffalo4"):
	case joaat("jubilee"):
	case joaat("patriot3"):
	case joaat("champion"):
	case joaat("greenwood"):
	case joaat("omnisegt"):
	case joaat("virtue"):
	case joaat("r300"):
	case joaat("stingertt"):
	case joaat("buffalo5"):
	case joaat("coureur"):
	case joaat("monstrociti"):
	case joaat("ruiner2"):
		return true
	end
	return false
end

local weapon_stuff = {
	{"烟花", "weapon_firework"}, 
	{"原子能枪", "weapon_raypistol"},
	{"邪恶冥王", "weapon_raycarbine"},
	{"天基炮", "weapon_railgun"},
	{"红色激光", "vehicle_weapon_enemy_laser"},
	{"绿色激光", "vehicle_weapon_player_laser"},
	{"天煞机炮", "vehicle_weapon_player_lazer"},
	{"火箭炮", "weapon_rpg"},
	{"制导火箭炮", "weapon_hominglauncher"},
	{"脉冲发射器", "weapon_emplauncher"},
	{"信号枪", "weapon_flaregun"},
	{"霰弹枪", "weapon_bullpupshotgun"},
	{"电击枪", "weapon_stungun"},
	{"烟雾弹", "weapon_smokegrenade"},
}

local proofs = {
	bullet = {name="子弹",on=false},
	fire = {name="着火",on=false},
	explosion = {name="爆炸",on=false},
	collision = {name="碰撞",on=false},
	melee = {name="近战",on=false},
	steam = {name="蒸汽",on=false},
	water = {name="溺水",on=false},
}

local doors = {
	"v_ilev_ml_door1",
	"v_ilev_ta_door",
	"v_ilev_247door",
	"v_ilev_247door_r",
	"v_ilev_lostdoor",
	"v_ilev_bs_door",
	"v_ilev_cs_door01",
	"v_ilev_cs_door01_r",
	"v_ilev_gc_door03",
	"v_ilev_gc_door04",
	"v_ilev_clothmiddoor",
	"v_ilev_clothmiddoor",
	"prop_shop_front_door_l",
	"prop_shop_front_door_r",
	"prop_com_ls_door_01",
	"v_ilev_carmod3door",
}

local object_stuff = {
	{util.joaat("prop_ld_ferris_wheel"), "摩天轮"},
	{util.joaat("p_spinning_anus_s"), "飞碟"},
	{util.joaat("prop_windmill_01"), "风力发电机"},
	{util.joaat("prop_staticmixer_01"), "水泥搅拌机"},
	{util.joaat("prop_towercrane_02a"), "塔式起重机"},
	{util.joaat("des_scaffolding_root"), "手脚架"},
	{util.joaat("stt_prop_stunt_bowling_ball"), "大保龄球"},
	{util.joaat("stt_prop_stunt_soccer_ball"), "大足球"},
	{util.joaat("prop_juicestand"), "大橙球"},
	{util.joaat("stt_prop_stunt_jump_l"), "特技坡道"},
}

local deezBalls = {
	{util.joaat("stt_prop_stunt_soccer_sball"), "小足球"},
	{util.joaat("stt_prop_stunt_soccer_ball"), "中足球"},
	{util.joaat("stt_prop_stunt_soccer_lball"), "大足球"},
	{util.joaat("v_res_mexball"), "瑜伽球"},
	{util.joaat("stt_prop_stunt_bowling_ball"), "保龄球"},
	{util.joaat("imp_prop_bomb_ball"), "炸弹球"},
	{util.joaat("prop_bskball_01"), "篮球"},
}

local vehicle_classes = {
  "小轿车",
  "轿车",
  "SUV",
  "轿跑",
  "肌肉",
  "经典",
  "跑车",
  "超跑",
  "摩托",
  "越野",
  "工业",
  "公用",
  "货车",
  "电动",
  "船",
  "直升机",
  "飞机",
  "服务",
  "紧急",
  "军队",
  "商业",
  "火车",
  "开轮"
}

local locations = {
  {"安全空间[挂机房]", {x=-158.71494, y=-982.75885, z=149.13135}},
  {"外星人实验室", {x=-1869.5039, y=3749.7612, z=-99.84549}},
  {"酷刑室", {x=147.170, y=-2201.804, z=4.688}},
  {"采矿隧道", {x=-595.48505, y=2086.4502, z=131.38136}},
  {"欧米茄车库", {x=2330.2573, y=2572.3005, z=46.679367}},
  {"50载具车库", {x=520.0, y=-2625.0, z=-50.0}},
  {"服务器群", {x=2474.0847, y=-332.58887, z=92.9927}},
  {"角色创建", {x=402.91586, y=-998.5701, z=-99.004074}},
  {"生命侵略者大楼", {x=-1082.8595, y=-254.774, z=37.763317}},
  {"竞速结束动画的车库", {x=405.9228, y=-954.1149, z=-99.6627}},
  {"被摧毁的医院", {x=304.03894, y=-590.3037, z=43.291893}},
  {"竞技场内部", {x=-256.92334, y=-2024.9717, z=30.145584}},
  {"喜剧俱乐部", {x=-430.00974, y=261.3437, z=83.00648}},
  {"录音A工作室", {x=-1010.6883, y=-49.127754, z=-99.40313}},
  {"不夜城", {x=-1394.8816, y=-599.7526, z=30.319544}},
  {"赌场看门人的房子", {x=-110.20285, y=-8.6156025, z=70.51957}},
  {"心理医生的房子", {x=-1913.8342, y=-574.5799, z=11.435149}},
  {"杜根的房子", {x=1395.2512, y=1141.6833, z=114.63437}},
  {"弗洛伊德的公寓", {x=-1156.5099, y=-1519.0894, z=10.632717}},
  {"麦克的房子", {x=-813.8814, y=179.07889, z=72.15914}},
  {"小富的房子(旧)", {x=-14.239959, y=-1439.6913, z=31.101551}},
  {"小富的房子(新)", {x=7.3125067, y=537.3615, z=176.02803}},
  {"老崔的房车", {x=1974.1617, y=3819.032, z=33.436287}},
  {"莱斯特的房子", {x=1273.898, y=-1719.304, z=54.771}},
  {"莱斯特的纺织厂", {x=713.5684, y=-963.64795, z=30.39534}},
  {"莱斯特的办公室", {x=707.2138, y=-965.5549, z=30.412853}},
  {"冰毒实验室", {x=1391.773, y=3608.716, z=38.942}},
  {"致幻剂实验室", {x=484.69, y=-2625.36, z=-49.0}},
  {"停尸房实验室", {x=495.0, y=-2560.0, z=-50.0}},
  {"人道实验室", {x=3625.743, y=3743.653, z=28.69009}},
  {"汽车旅馆", {x=152.2605, y=-1004.471, z=-99.024}},
  {"警察局", {x=443.4068, y=-983.256, z=30.689589}},
  {"银行金库", {x=263.39627, y=214.39891, z=101.68336}},
  {"布莱恩县银行", {x=-109.77874, y=6464.8945, z=31.626724}}, -- credit to fluidware for telling me about this one
  {"龙舌兰酒吧", {x=-564.4645, y=275.5777, z=83.074585}},
  {"废弃修理厂", {x=485.46396, y=-1315.0614, z=29.2141}},
  {"失落摩托帮", {x=980.8098, y=-101.96038, z=74.84504}},
  {"万杰利科珠宝店", {x=-629.9367, y=-236.41296, z=38.057056}},
  {"机场休息室", {x=-913.8656, y=-2527.106, z=36.331566}},
  {"停尸房", {x=240.94368, y=-1379.0645, z=33.74177}},
  {"联合储蓄", {x=1.298771, y=-700.96967, z=16.131021}},
  {"桑库多堡垒瞭望塔", {x=-2357.9187, y=3249.689, z=101.45073}},
  {"事务所大楼", {x=-1118.0181, y=-77.93254, z=-98.99977}},
  {"事务所车库", {x=-1071.0494, y=-71.898506, z=-94.59982}},
  {"恐霸内部", {x=-1421.015, y=-3012.587, z=-80.000}},
  {"地堡内部", {x=899.5518,y=-3246.038, z=-98.04907}},
  {"IAA办公室", {x=128.20, y=-617.39, z=206.04}},
  {"FIB顶楼", {x=135.94359, y=-749.4102, z=258.152}},
  {"FIB47楼", {x=134.5835, y=-766.486, z=234.152}},
  {"FIB49楼", {x=134.635, y=-765.831, z=242.152}},
  {"肥鸡机顶", {x=-31.007448, y=6317.047, z=40.04039}},
  {"脱衣舞俱乐部DJ位", {x=121.398254, y=-1281.0024, z=29.480522}},
}

local lscCoords = {
	v3(-356.09048, -134.77142, 40.012955),
	v3(723.11597, -1088.8312, 23.232006),
	v3(-1145.8977, -1991.1444, 14.18357),
	v3(1182.3055, 2645.2324, 38.63961),
	v3(108.85017, 6617.877, 32.673054),
}

local missionEndTeleports = {
  [4] = "沙滩海岸",
  [7] = "龙舌兰酒吧",
  [8] = "机场一层",
  [9] = "黄色杰克酒吧",
  [10] = "牛肉屋",
  [11] = "汉堡店",
  [13] = "水果市场",
  [25] = "莱斯特仓库",
  [28] = "本尼店",
  [31] = "沙滩海岸船屋",
  [42] = "高速美食餐厅",
  [56] = "佩立托湾",
  [58] = "葡萄籽机场",
  [59] = "佩立托湾武器店",
  [60] = "机场二层",
  [66] = "天文台",
  [68] = "赌场",
  [72] = "赌场屋顶",
  [87] = "玛德拉索",
  [90] = "天堂岛码头",
  [91] = "佩罗码头",
  [97] = "乡村俱乐部",
  [114] = "乞力耶德山"
}

local interiorTpList = {
	[70] = "地堡", -- 70 thru 80 are bunkers
	[81] = "机动作战中心",
	[83] = "机库", -- 83 thru 87 are hangars
	[88] = "复仇者",
	[89] = "设施", -- 89 thru 97 are facilities
	[102] = "夜总会车库",-- 102 thru 111 are garages
	[117] = "恐霸",
	[122] = "竞技场",
	[123] = "赌场",
	[124] = "顶层公寓",
	[128] = "街机铺", -- 128 thru 133 are garages
	[146] = "夜总会",
	[147] = "虎鲸",
	[149] = "改装铺", -- 149 thru 153 are auto shops
	[155] = "事务所",
	[159] = "迷幻剂",
	[160] = "怪胎店",
	[161] = "日蚀大道车库",
	[164] = "回收场",
}

local freemodeMissionWarps = {
	[267] = "拉机能量高空跳伞",
	[292] = "自行车服务",
	[296] = "合约",
	[304] = "致幻剂实验室",
	[308] = "藏身处",
	[309] = "出租车任务",
	[318] = "计时赛",
	[324] = "拖车服务"
}

local colors = {
	{-1, "默认"},
	{1, "白"},
	{28, "浅红"},
	{57, "柔浅红"},
	{27, "红"},
	{48, "浅蓝"},
	{26, "蓝"},
	{116, "深蓝"},
	{211, "蓝绿"},
	{18, "绿"},
	{21, "紫"},
	{49, "粉紫"},
	{24, "洋红"},
	{30, "粉红"},
	{45, "淡粉"},
	{46, "青绿"},
	{12, "黄"},
	{109, "金"},
	{31, "浅橙"},
	{15, "橙"},
}

local warnings = {
	joaat("NT_INV"),
	joaat("NT_INV_FREE"),
	joaat("NT_INV_PARTY_INVITE"),
	joaat("NT_INV_PARTY_INVITE_MP"),
	joaat("NT_INV_PARTY_INVITE_MP_SAVE"),
	joaat("NT_INV_PARTY_INVITE_SAVE"),
	joaat("NT_INV_MP_SAVE"),
	joaat("NT_INV_SP_SAVE"),
}

local transactionWarnings = {
	joaat("CTALERT_F"),
	joaat("CTALERT_F_1"),
	joaat("CTALERT_F_2"),
	joaat("CTALERT_F_3"),
	joaat("CTALERT_F_4"),
}

local scripts = {
	"valentineRpReward2",
	"main_persistent",
	"cellphone_controller",
	"shop_controller",
	"stats_controller",
	"timershud",
	"am_npc_invites",
	"fm_maintain_cloud_header_data"
}

local shopScripts = {
	{"服装店", "clothes_shop_mp"},
	{"理发店", "hairdo_shop_mp"},
	{"纹身店", "tattoo_shop"},
	{"武器店", "gunclub_shop"},
	{"便利店", "am_hold_up"},
	{"修车店", "carmod_shop"}
}

local featureCreateStartTime = util.current_time_millis()
local my_root = menu.my_root()
local self = my_root:list("自我选项")
local audio = my_root:list("音效选项")
local online = my_root:list("在线选项")
local players_list = my_root:list("玩家选项")
local lobby = my_root:list("战局选项")
local missions = my_root:list("任务选项")
local vehicles = my_root:list("载具选项")
local weapons = my_root:list("武器选项")
local world = my_root:list("世界选项")
local detections = my_root:list("检测选项", {}, "⚠启用所有检测可能会掉帧")
local modder_detections = detections:list("作弊检测")
local normal_detections = detections:list("正常检测")
local protections = my_root:list("保护选项")
local funfeatures = my_root:list("趣味选项")
local misc = my_root:list("其他选项")

local menus = {}
local hasLink = {}
function player_list(playerID)
    if NETWORK_IS_SESSION_ACTIVE() and not menus[playerID] then
		local playerRoot = menu.player_root(playerID)
        menus[playerID] = players_list:list(players.get_name(playerID), {}, "", function()
			if not hasLink[playerID] then
		 		menus[playerID]:link(menu.ref_by_rel_path(playerRoot, "JinxScript>友好"))
				menus[playerID]:link(menu.ref_by_rel_path(playerRoot, "JinxScript>恶搞"))
				menus[playerID]:link(menu.ref_by_rel_path(playerRoot, "JinxScript>无敌"))
				menus[playerID]:link(menu.ref_by_rel_path(playerRoot, "JinxScript>传送"))
				menus[playerID]:link(menu.ref_by_rel_path(playerRoot, "JinxScript>其他"))
				hasLink[playerID] = true
			end
        end)
    end
end

function handle_player_list(playerID)
    local ref = menus[playerID]
    if not players.exists(playerID) then
        if ref then
            menu.delete(ref)
            menus[playerID] = nil
        end
    end
end

players.on_join(player_list)
players.on_leave(handle_player_list)
players.dispatch_on_join()


playerHealth = self:slider("血量", {"playerhealth"}, "", 160, 2147483647, 328, 1, function(health)
	SET_PED_MAX_HEALTH(players.user_ped(), health)
	SET_ENTITY_HEALTH(players.user_ped(), health, players.user_ped(), 0)
end)  
menu.add_value_replacement(playerHealth, 328, "默认")

local proofsList = self:list("无敌", {}, "")
for proofs as data do
    proofsList:toggle(data.name, {data.name:lower().."proof"}, "让你刀枪不入 "..data.name:lower()..".", function(toggled)
        data.on = toggled
    end)
end

util.create_tick_handler(function()
    local local_player = players.user_ped()
    if not menu.get_value(menu.ref_by_path("Self>Immortality")) and not isPlayerInInterior(players.user()) then
        SET_ENTITY_PROOFS(local_player, proofs.bullet.on, proofs.fire.on, proofs.explosion.on, proofs.collision.on, proofs.melee.on, proofs.steam.on, false, proofs.steam.on)
    end
end)

local stealthLevitation
stealthLevitation = self:toggle_loop("隐形", {"stealthlevitation"}, "使用悬浮隐藏你的地图坐标和角色 其他玩家看不见", function()
	if levitation.value then
		vehInvisibility:setState("Locally Visible")
		invisibility:setState("Locally Visible")
		repeat
			yield()
			yield()
		until not levitation.value
		invisibility:setState("Disabled")
		vehInvisibility:setState("Disabled")
	else
		return
	end
end, function()
	invisibility:setState("Disabled") -- so invisibility doesnt stay on if the script or feature is toggled off while levitating
	vehInvisibility:setState("Disabled")
end)

local thrust = self:list("推伞")
local thrustSpeed = 0.0
thrustSlider = thrust:slider_float("推力值", {"thrust"}, "", 0, 500, 0, 10, function(value)
	thrustSpeed = value/100
end)
menu.add_value_replacement(thrustSlider, 0, "默认")

thrust:toggle_loop("启用", {"parachutethrust"}, "改变跳伞时的推力速度", function()
	SET_PARACHUTE_TASK_THRUST(players.user_ped(), thrustSpeed)
end)

self:toggle("挪座", {}, "防止在驾驶座空闲时自动移到驾驶座上 配合Stand换座", function(toggled)
	SET_PED_CONFIG_FLAG(players.user_ped(), 184, toggled)
end)

self:toggle_loop("起身", {}, "立即起身", function()
	SET_PED_CONFIG_FLAG(players.user_ped(), 227, IS_PLAYER_PLAYING(players.user()))
end)

self:toggle("雷达", {"noradar"}, "开关雷达", function(toggled)
	DISPLAY_RADAR(not toggled)
end)

self:toggle("睾酮", {"bstmode"}, "没有画效和音效的牛鲨睾酮", function(toggled)
	SET_PLAYER_WEAPON_DAMAGE_MODIFIER(players.user(), toggled ? 1.44 : 0.72)
	SET_PLAYER_MELEE_WEAPON_DAMAGE_MODIFIER(players.user(), toggled ? 2.0 : 1.0)
	SET_PLAYER_MELEE_WEAPON_DEFENSE_MODIFIER(players.user(), toggled ? 0.5 : 1.0)
end)

self:toggle("翻滚", {"fastroll"}, "", function(toggled)
	menu.ref_by_path("Self>No Combat Roll Cooldown").value = toggled
end)

self:toggle_loop("蹲下", {}, "按Ctrl键", function()
	memory.write_int(allowDuckingAddr + 0x4DC, 1)
	if GET_PED_STEALTH_MOVEMENT(players.user_ped()) then
		TASK_TOGGLE_DUCK(players.user_ped(), IS_PED_DUCKING(players.user_ped()) ? TOGGLE_DUCK_OFF : TOGGLE_DUCK_ON)
		SET_PED_STEALTH_MOVEMENT(players.user_ped(), false, 0)
	end
end, function()
	TASK_TOGGLE_DUCK(players.user_ped(), TOGGLE_DUCK_OFF)
	memory.write_int(allowDuckingAddr + 0x4DC, 0)
end)

self:action("清除", {"clearpedtasks", "cleartasks"}, "清除玩家当前动作", function()
	CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
end)

local copPerception = world:list("警察感知")
local copSeeingRange = 60.0
local copSeeingRangeSlider = copPerception:slider_float("扫描范围", {"copseeingrange"}, "警察扫描范围", 0, 10000, 6000, 100, function(value)
	copSeeingRange = value/100
end)
menu.add_value_replacement(copSeeingRangeSlider, 6000, "默认")

local copHearingRange = 60.0
local copHearingRangeSlider = copPerception:slider_float("听力范围", {"cophearingrange"}, "警察听声音范围", 0, 10000, 6000, 100, function(value)
	copHearingRange = value/100
end)
menu.add_value_replacement(copHearingRangeSlider, 6000, "默认")

copPerception:toggle_loop("启用", {}, "", function()
	SET_COP_PERCEPTION_OVERRIDES(copSeeingRange, 5.0, copHearingRange, -90.0, 90.0, 60.0, -1.0)
end)

world:toggle_loop("友好路人", {"friendlyai"}, "使NPC无法瞄准你", function()
	SET_PED_RESET_FLAG(players.user_ped(), 124, true)
end)

world:toggle("暴动模式", {}, "", function(toggled)
	SET_RIOT_MODE_ENABLED(toggled)
end)

world:toggle_loop("禁用画效", {"disablepostfx"}, "", function() 
	ANIMPOSTFX_STOP_ALL()
end)

local gravityThings = {
	[0] = "正常",
	"月球",
	"低重力",
	"无重力"
}
gravityLevel = world:slider("设置重力", {"gravity"}, "改变车辆和玩家的重力", 0, 3, 0, 1, function(index)
	SET_VEHICLE_GRAVITY(entities.get_user_vehicle_as_handle(), true)
	SET_PED_GRAVITY(players.user_ped(), true)
	SET_GRAVITY_LEVEL(index)
end)
for index, name in gravityThings do
	menu.add_value_replacement(gravityLevel, index, name)
end

local activeTrain = false
world:slider_float("火车速度", {"trainspeed"}, "", 100, 8000, 1000, 100, function(speed)
	for entities.get_all_vehicles_as_handles() as vehicle do
		if IS_THIS_MODEL_A_TRAIN(GET_ENTITY_MODEL(vehicle)) then 
			activeTrain = true
			SET_TRAIN_CRUISE_SPEED(vehicle, speed/100)
		end
	end
	if not activeTrain then 
		toast("无火车 :/")
		return
	end
end)

local weather = world:list("天气类型")
weather:toggle_loop("电闪雷鸣", {"forcelightning"}, "", function()
	FORCE_LIGHTNING_FLASH()
	yield(math.random(1000, 5000))
end)

local rainIntensity = weather:slider_float("降雨强度", {"rainintensity"}, "", -1, 100, -1, 1, function(value)
	SET_RAIN(value / 100)
end)
menu.add_value_replacement(rainIntensity, -1, "默认")
menu.add_value_replacement(rainIntensity, 0, "无雨")

local snowIntensity = weather:slider_float("降雪强度", {"snowintensity"}, "这仅在当前天气类型为下雪时有效", -1, 100, -1, 1, function(value)
	SET_SNOW(value / 100)
end)
menu.add_value_replacement(snowIntensity, -1, "默认")
menu.add_value_replacement(snowIntensity, 0, "无雪")

local windSpeed = weather:slider_float("风力强度", {"windspeed"}, "这会产生水坑等东西", -1, 100, -1, 1, function(value)
	SET_WIND(value / 100)
end)
menu.add_value_replacement(windSpeed, -1, "默认")
menu.add_value_replacement(windSpeed, 0, "无风")


world:action("差事传送", {"smoothtp"}, "", function()
	if not IS_WAYPOINT_ACTIVE() then
		toast(lang.get_localised(BLIPNFND))
		return
	end

	local waypoint = GET_BLIP_INFO_ID_COORD(GET_FIRST_BLIP_INFO_ID(GET_WAYPOINT_BLIP_ENUM_ID()))
	local vehicle = GET_VEHICLE_PED_IS_USING(players.user_ped())

	local ground = false
	repeat
		ground, waypoint.z = util.get_ground_z(waypoint.x, waypoint.y)
		yield()
	until ground

	invisibility:setState("Enabled")

	if vehicle != 0 then
		SET_ENTITY_VISIBLE(vehicle, false)
	end

	SWITCH_TO_MULTI_FIRSTPART(players.user_ped(), 8, 1)
	BEGIN_TEXT_COMMAND_BUSYSPINNER_ON("PM_WAIT")
	END_TEXT_COMMAND_BUSYSPINNER_ON(4)

	repeat
		yield()
	until IS_SWITCH_TO_MULTI_FIRSTPART_FINISHED()

	if vehicle == 0 then
		SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), waypoint, false, false, false)
	else
		SET_ENTITY_VISIBLE(vehicle, false)
		SET_ENTITY_COORDS_NO_OFFSET(vehicle, waypoint, false, false, false)
	end

	SWITCH_TO_MULTI_SECONDPART(players.user_ped())
	ALLOW_PLAYER_SWITCH_OUTRO() 

	repeat
		yield()
	until not IS_PLAYER_SWITCH_IN_PROGRESS()
	
	if vehicle == 0 then
		NETWORK_FADE_IN_ENTITY(players.user_ped(), true, true)
	else
		NETWORK_FADE_IN_ENTITY(vehicle, true, 1)
		NETWORK_FADE_IN_ENTITY(players.user_ped(), true, true)
		SET_ENTITY_VISIBLE(vehicle, true)
	end
	
	invisibility:setState("Disabled")
	BUSYSPINNER_OFF()
end)

local teleport = world:list("传送位置")
for locations as data do
    local location_name = data[1]
    local location_coords = data[2]
    teleport:action(location_name, {}, "", function()
        local vehicle = GET_VEHICLE_PED_IS_USING(players.user_ped())
        menu.trigger_commands("doors on")
        menu.trigger_commands("nodeathbarriers on")
        local entity = (vehicle != 0) and vehicle or players.user_ped()
        SET_ENTITY_COORDS_NO_OFFSET(entity, v3(location_coords), false, false, false)
    end)
end

world:textslider("清除区域", {}, "", {"NPC", "载具", "物体", "拾取物", "投掷物", "声音"}, function(index, name)
    local counter = 0
    switch index do
        case 1:
            for entities.get_all_peds_as_handles() as ped do
                if ped != players.user_ped() and not IS_PED_A_PLAYER(ped) then
                    entities.delete_by_handle(ped)
                    counter += 1
                    util.yield()
                end
            end
            break
        case 2:
            for entities.get_all_vehicles_as_handles() as vehicle do
				local owner = entities.get_owner(vehicle)
                if vehicle != GET_VEHICLE_PED_IS_IN(players.user_ped(), false) and DECOR_GET_INT(vehicle, "Player_Vehicle") == 0 and (owner == players.user() or owner == -1) then
                    entities.delete_by_handle(vehicle)
                    counter += 1
                end
                util.yield()
            end
            break
        case 3:
            for entities.get_all_objects_as_handles() as object do
                entities.delete_by_handle(object)
                counter += 1
                util.yield()
            end
            break
        case 4:
            for entities.get_all_pickups_as_handles() as pickup do
                entities.delete_by_handle(pickup)
                counter += 1
                util.yield()
            end
            break
        case 5:
				    CLEAR_AREA_OF_PROJECTILES(players.get_position(players.user()), 1000.0, 0)
            counter = "全部"
            break
        case 6:
            for i = 0, 99 do
                STOP_SOUND(i)
                util.yield()
            end
        break
    end
    util.toast($"已清除 {tostring(counter)} {name:lower()}.")
end)

audio:toggle_loop("禁用脚步", {"disablefootsteps"}, "禁用脚步声", function()
	SET_PED_CLOTH_EVENTS_ENABLED(players.user_ped(), false)
	SET_PED_FOOTSTEPS_EVENTS_ENABLED(players.user_ped(), false)
end, function()
	SET_PED_CLOTH_EVENTS_ENABLED(players.user_ped(), true)
	SET_PED_FOOTSTEPS_EVENTS_ENABLED(players.user_ped(), true)
end)

audio:toggle_loop("禁用警告", {"disablewastedsound"}, "", function() 
	if memory.read_int(memory.script_global(2707679)) == 0 then -- AUDIO::PLAY_SOUND_FRONTEND(-1, "Wasted", "POWER_PLAY_General_Soundset", true);
		memory.write_int(memory.script_global(2707679), 1)
	end
end, function()
	memory.write_int(memory.script_global(2707679), 0)
end)

audio:toggle_loop("禁用扫描", {"disablepolicescanner"}, "禁用警用扫描接收机", function()
	SET_AUDIO_FLAG("PoliceScannerDisabled", true)
end, function()
	SET_AUDIO_FLAG("PoliceScannerDisabled", false)
end)

audio:toggle_loop("禁用尖叫", {"disablepedscreams"}, "禁用尖叫声", function()	
for entities.get_all_peds_as_handles() as ped do
		if ped != players.user_ped() then
			DISABLE_PED_PAIN_AUDIO(ped, true)
		end
		yield(100)
	end
end)

audio:toggle_loop("禁用对话", {"disablepedspeech"}, "禁用讲话声", function()
	if getPlayerCurrentShop(players.user()) != -1 then return end
    for entities.get_all_peds_as_handles() as ped do
        if IS_ANY_SPEECH_PLAYING(ped) then
            STOP_CURRENT_PLAYING_SPEECH(ped)
        end
		yield(100)
    end
end)

local shopkeeperList = audio:list("禁用对话", {}, "禁用店主讲话声")
for shopScripts as data do
    local shopName = data[1]
    local shopScript = data[2]
	shopkeeperList:toggle_loop(shopName, {}, "", function()
		if getPlayerCurrentShop(players.user()) == -1 then return end
		for entities.get_all_peds_as_handles() as ped do
			local script = GET_ENTITY_SCRIPT(ped, 0)
			if script == shopScript then
				BLOCK_ALL_SPEECH_FROM_PED(ped, true, true)
			end
			yield(100)
		end
	end)
end

audio:toggle_loop("禁用提示", {"disablefreemodemusic"}, "禁用由任务或帮派攻击等引起的音效", function()
	if AUDIO_IS_MUSIC_PLAYING() and not NETWORK_IS_ACTIVITY_SESSION() then
		TRIGGER_MUSIC_EVENT("GLOBAL_KILL_MUSIC")
	end
end)

audio:toggle_loop("禁用背景", {"disableambientsounds"}, "禁用背景噪音 例如警报器 远处的喇叭声 手提钻 鸟类 蟋蟀等", function()
	if util.is_session_transition_active() then STOP_AUDIO_SCENE("CHARACTER_CHANGE_IN_SKY_SCENE") return end
	if not IS_AUDIO_SCENE_ACTIVE("CHARACTER_CHANGE_IN_SKY_SCENE") then
		START_AUDIO_SCENE("CHARACTER_CHANGE_IN_SKY_SCENE")
	end
end, function()
  STOP_AUDIO_SCENE("CHARACTER_CHANGE_IN_SKY_SCENE")
end)

audio:toggle_loop("禁用过渡", {"disabletransitionsounds"}, "禁用切战局声音", function()
	while IS_PLAYER_SWITCH_IN_PROGRESS() do
		util.spoof_script("maintransition", function()
			START_AUDIO_SCENE("MP_LOBBY_SCENE")
			START_AUDIO_SCENE("MP_CCTV_SCENE")
		end)
		yield()
	end
	if (IS_AUDIO_SCENE_ACTIVE("MP_LOBBY_SCENE") or IS_AUDIO_SCENE_ACTIVE("MP_CCTV_SCENE")) and (isNetPlayerOk(players.user(), false, true) or not IS_PLAYER_SWITCH_IN_PROGRESS()) then
		STOP_AUDIO_SCENE("MP_LOBBY_SCENE")
		STOP_AUDIO_SCENE("MP_CCTV_SCENE")
	end
end, function()
	util.spoof_script("maintransition", function()
		STOP_AUDIO_SCENE("MP_LOBBY_SCENE")
		START_AUDIO_SCENE("MP_CCTV_SCENE")
	end)
end)

local disableRadioEmittersList = audio:list("禁用音乐", {}, "禁用从音箱 室内 载具等发出的音乐")
disableRadioEmittersList:toggle_loop("室内", {"disableradioemitters"}, "仅在室内时禁用音乐", function()
	if util.is_session_transition_active() then STOP_AUDIO_SCENE("DLC_MPHEIST_TRANSITION_TO_APT_FADE_IN_RADIO_SCENE") return end
	if getPlayerCurrentInterior(players.user()) != 0 then 
		if not IS_AUDIO_SCENE_ACTIVE("DLC_MPHEIST_TRANSITION_TO_APT_FADE_IN_RADIO_SCENE") then
			START_AUDIO_SCENE("DLC_MPHEIST_TRANSITION_TO_APT_FADE_IN_RADIO_SCENE") -- MP_POSITIONED_RADIO_MUTE_SCENE didnt want to work in story mode
		end
	end
end, function()
	STOP_AUDIO_SCENE("DLC_MPHEIST_TRANSITION_TO_APT_FADE_IN_RADIO_SCENE")
end)

disableRadioEmittersList:toggle_loop("户外", {"disableradioemitters"}, "仅在室外时禁用音乐", function()
	if util.is_session_transition_active() then STOP_AUDIO_SCENE("DLC_MPHEIST_TRANSITION_TO_APT_FADE_IN_RADIO_SCENE") return end
	if getPlayerCurrentInterior(players.user()) == 0 then 
		if not IS_AUDIO_SCENE_ACTIVE("DLC_MPHEIST_TRANSITION_TO_APT_FADE_IN_RADIO_SCENE") then
			START_AUDIO_SCENE("DLC_MPHEIST_TRANSITION_TO_APT_FADE_IN_RADIO_SCENE")
		end
	end
end, function()
	STOP_AUDIO_SCENE("DLC_MPHEIST_TRANSITION_TO_APT_FADE_IN_RADIO_SCENE")
end)

audio:toggle("禁用警笛", {"disablesirens"}, "禁用自由模式下听到的远处警笛声", function(toggled)
	DISTANT_COP_CAR_SIRENS(not toggled)
end)

audio:toggle_loop("禁用载具", {"disablevehicleaudio"}, "静音除自己之外的所有载具的声音", function()
	if util.is_session_transition_active() or getPlayerCurrentShop(players.user()) != -1 then STOP_AUDIO_SCENE("MP_CAR_MOD_SHOP") return end
	if not IS_AUDIO_SCENE_ACTIVE("MP_CAR_MOD_SHOP") then
		START_AUDIO_SCENE("MP_CAR_MOD_SHOP")
	end
end, function()
	STOP_AUDIO_SCENE("MP_CAR_MOD_SHOP")
end)

audio:toggle_loop("禁用电台", {"disablenearbyvehicleradios"}, "禁用附近电台", function()
	if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped()) then
		AUDIO.START_AUDIO_SCENE("MIC1_RADIO_DISABLE")
	else
		AUDIO.STOP_AUDIO_SCENE("MIC1_RADIO_DISABLE")
	end
end, function()
	STOP_AUDIO_SCENE("MIC1_RADIO_DISABLE")
end)

audio:toggle_loop("禁用电台", {"disableradio"}, "禁用电台", function()
	if not IS_AUDIO_SCENE_ACTIVE("CAR_MOD_RADIO_MUTE_SCENE") then
		START_AUDIO_SCENE("CAR_MOD_RADIO_MUTE_SCENE")
	end
end, function()
	STOP_AUDIO_SCENE("CAR_MOD_RADIO_MUTE_SCENE")
end)


audio:toggle_loop("禁用警报", {"disablevehiclealarms"}, "禁用偷车时发出的警报", function()
	local vehicle = GET_VEHICLE_PED_IS_TRYING_TO_ENTER(players.user_ped())
	if IS_VEHICLE_ALARM_ACTIVATED(vehicle) then
		SET_VEHICLE_ALARM(vehicle, false)
	end
end)	

audio:toggle_loop("禁用鸣笛", {"disablehornondeath"}, "禁用NPC在车内死亡时的鸣笛", function()
	for entities.get_all_peds_as_handles() as ped do 
		SET_PED_CONFIG_FLAG(ped, 46, true)
		yield(100)
	end
end, function()
	for entities.get_all_peds_as_handles() as ped do 
		SET_PED_CONFIG_FLAG(ped, 46, false)
	end
end)


local disableWeatherNoiseList = audio:list("禁用噪音", {}, "禁用不同类型的天气噪音")
disableWeatherNoiseList:toggle_loop("禁用风噪", {"disablewind"}, "", function()
	if util.is_session_transition_active() then STOP_AUDIO_SCENE("PROLOGUE_MUTE_SPRINKLERS") return end
	if GET_RAIN_LEVEL() > 0.0 then return end
	if not IS_AUDIO_SCENE_ACTIVE("PROLOGUE_MUTE_SPRINKLERS") then
		START_AUDIO_SCENE("PROLOGUE_MUTE_SPRINKLERS")
	end
end, function()
	STOP_AUDIO_SCENES()
end)

disableWeatherNoiseList:toggle_loop("禁用雨声", {"disablerain"}, "", function()
	if util.is_session_transition_active() then STOP_AUDIO_SCENE("PROLOGUE_MUTE_SPRINKLERS") return end
	if GET_PREV_WEATHER_TYPE_HASH_NAME() != joaat("thunder") and GET_RAIN_LEVEL() > 0.0 then
		if not IS_AUDIO_SCENE_ACTIVE("PROLOGUE_MUTE_SPRINKLERS") then
			START_AUDIO_SCENE("PROLOGUE_MUTE_SPRINKLERS")
		end
	end
end, function()
	STOP_AUDIO_SCENES()
end)

disableWeatherNoiseList:toggle_loop("禁用雷声", {"disablethunder"}, "", function()
	if util.is_session_transition_active() then STOP_AUDIO_SCENE("PROLOGUE_MUTE_SPRINKLERS") return end
	if GET_PREV_WEATHER_TYPE_HASH_NAME() == joaat("thunder") then
		if not IS_AUDIO_SCENE_ACTIVE("PROLOGUE_MUTE_SPRINKLERS") then
			START_AUDIO_SCENE("PROLOGUE_MUTE_SPRINKLERS")
		end
	end
end, function()
	STOP_AUDIO_SCENES()
end)

audio:toggle_loop("禁用通知", {"disablefrontendaudio"}, '禁用自由模式事件开始时的通知声音或是手机等 如果想听到菜单声音 请按O并选择状态关联', function()
	GET_SOUND_ID()
end, function()
	for i = 0, 99 do
		RELEASE_SOUND_ID(i)
	end
end)

local enhancements = online:list("增强功能")
enhancements:toggle_loop("禁用扣押", {}, "重要提示会影响修车店使用", function() -- extremely dumb way to go about it but forcing a job broke stuff
	local vehicle = entities.get_user_vehicle_as_handle()
	local personalVehicle = DECOR_GET_INT(vehicle, "Player_Vehicle")
	if IS_PLAYER_DEAD(players.user()) and vehicle != 0 and personalVehicle != 0 then
		local randomPed = createRandomPed(GET_ENTITY_COORDS(vehicle))
		SET_PED_INTO_VEHICLE(randomPed, vehicle, -1)
		SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(randomPed, true)
		repeat
			yield()
		until not IS_PLAYER_DEAD(players.user())
		yield(2500)
		entities.delete(randomPed)
	end
end)

enhancements:toggle_loop("禁用动画", {"disableclothesanimations"}, "禁用试穿衣服时播放动画", function()
	if getPlayerCurrentShop(players.user()) != -1 then
		for entities.get_all_peds_as_handles() as ped do
			if GET_ENTITY_SCRIPT(ped, 0) == "clothes_shop_mp" and (GET_ENTITY_MODEL(ped) == joaat("mp_m_freemode_01") or GET_ENTITY_MODEL(ped) == joaat("mp_f_freemode_01")) then
				CLEAR_PED_TASKS(ped)
			end
		end
	end
end)

enhancements:toggle_loop("禁用文本", {}, "禁用帮助文本 例如在买衣服时 走近互动不会提示按E", function() 
	HIDE_HELP_TEXT_THIS_FRAME()
end)

enhancements:toggle_loop("禁用拖出", {}, "防止被愤怒的行人拉出车外", function()
	if not IS_PED_IN_ANY_VEHICLE(players.user_ped()) then return end
	for entities.get_all_peds_as_handles() as ped do
		SET_PED_CONFIG_FLAG(ped, 342, true)
	end
end)

enhancements:toggle_loop("安全购物", {"safeshopping"}, "让你在购物时进入锁定战局 以确保安全的购物体验 其他玩家将无法看到你在商店中", function()
	if getPlayerCurrentShop(players.user()) != -1 then
		NETWORK_START_SOLO_TUTORIAL_SESSION()
		while getPlayerCurrentShop(players.user()) != -1 do
			yield()
		end
	    NETWORK_END_TUTORIAL_SESSION()
	end	
end, function()
    NETWORK_END_TUTORIAL_SESSION()
end)

local spoofing = online:list("虚假功能")
spoofing:toggle_loop("虚假重装", {"juggernaut"}, "将你的光点变成骷髅 其他玩家也会看到这一点 这会阻止某些东西工作 我已尽力将问题最小化", function()
	local minigunHash = joaat("weapon_minigun")
	local vehicle = GET_VEHICLE_PED_IS_USING(players.user_ped())
	if not isNetPlayerOk(players.user()) then return end
	if NETWORK_IS_ACTIVITY_SESSION() or isPlayerInCutscene(players.user()) or isPlayerInInterior(players.user()) then 
		memory.write_int(isPlayerUsingBallisticEquipment(players.user()), 0)
		return 
	end
	
	for lscCoords as lscDoorCoords do
		if v3.distance(players.get_position(players.user()), lscDoorCoords) < 15.0 and vehicle != 0 then
			memory.write_int(isPlayerUsingBallisticEquipment(players.user()), 0)
			return
		end
	end

	if memory.read_int(isPlayerUsingBallisticEquipment(players.user())) == 0 then
		memory.write_int(isPlayerUsingBallisticEquipment(players.user()), minigunHash)
	end
end, function()
	memory.write_int(isPlayerUsingBallisticEquipment(players.user()), 0)
end)

local spoofBlip = spoofing:list("虚假位置")
local blipX = 0.00
spoofBlip:slider_float("X", {"spoofedx"}, "", 0, 1000000, 0, 1, function(x_pos)
	blipX = x_pos/100
end)

local blipY = 0.00
spoofBlip:slider_float("Y", {"spoofedy"}, "", 0, 1000000, 0, 1, function(y_pos)
	blipY = y_pos/100
end)

local blipZ = 0.00
spoofBlip:slider_float("Z", {"spoofedz"}, "", -20000, 270000, 0, 1, function(z_pos)
	blipZ = z_pos/100
end)

spoofBlip:toggle_loop("启用", {}, "注意 这将导致小地图不显示你当前位置", function()
	memory.write_int(blipInteriorID(players.user()), 1)
	v3.set(blipInteriorPos(players.user()), blipX, blipY, blipZ)
end, function()
	memory.write_int(blipInteriorID(players.user()), -1)
	v3.set(blipInteriorPos(players.user()), players.get_position(players.user()))
end)


local spoofApartment = spoofing:list("虚假公寓", {}, "注意 这可能会导致公寓邀请无效 具体取决于值")
local apartmentID = -1
spoofApartmentID = spoofApartment:slider("公寓值", {"apartmentid"}, "", -2147483647, 2147483647, -1, 1, function(value)
	apartmentID = value
end)
menu.add_value_replacement(spoofApartmentID, -1, "默认")

spoofApartment:toggle_loop("启用", {}, "", function()
	if not isNetPlayerOk(players.user(), true, true) then return end
	memory.write_int(getPlayerProperty(players.user()), isNetPlayerOk(players.user(), true, true) ? apartmentID : -1)
end, function() 
	memory.write_int(getPlayerProperty(players.user()), -1) -- this will be improved at a later date, its fine for now.
end)

local spoofBitset = spoofing:list("虚假位集", {}, "")
local vehBitset = 0
spoofBitset:slider("位集值", {"bitset"}, "", -2147483647, 2147483647, 0, 1, function(value)
	vehBitset = value
end)

spoofBitset:toggle_loop("启用", {}, "", function()
	DECOR_SET_INT(entities.get_user_vehicle_as_handle(), "MPBitset", vehBitset)
end)

local moneySpoofing = spoofing:list("虚假现金", {}, "")
local walletBalance = 0
moneySpoofing:slider("现金", {"walletbalance"}, "设置别人看见的现金", -2147483647, 2147483647, 0, 1, function(value)
	walletBalance = value
end)

local totalBalance = 0
moneySpoofing:slider("总额", {"totalbalance"}, "设置别人看见的总额", -2147483647, 2147483647, 0, 1, function(value)
	totalBalance = value
end)

moneySpoofing:toggle_loop("启用", {}, "", function()
	local iTotalCash = memory.script_global(GlobalplayerBD_FM + 1 + (players.user() * 883) + 206 + 3) -- Global_1845281[PLAYER::PLAYER_ID() /*883*/].f_206.f_3
	if memory.read_int(iTotalCash) != walletBalance then
		memory.write_int(iTotalCash, walletBalance)
		return
	end
end)

moneySpoofing:toggle_loop("启用", {}, "", function()
	local iEarnings = memory.script_global(GlobalplayerBD_FM + 1 + (players.user() * 883) + 205 + 56) -- Global_1845281[PLAYER::PLAYER_ID() /*883*/].f_205.f_56
	if memory.read_int(iEarnings) != totalBalance then
		memory.write_int(iEarnings, totalBalance)
		return
	end
end)

local overrideChatColor = online:list("更改颜色", {}, "更改聊天中自己ID颜色 本地可见")
local chatColor = 57
overrideChatColor:list_select("颜色", {}, "", colors, chatColor, function(color)
	chatColor = color
end)

overrideChatColor:toggle_loop("更改", {}, "", function()
	OVERRIDE_MP_TEXT_CHAT_COLOR(1, chatColor)
end, function()
	OVERRIDE_MP_TEXT_CHAT_COLOR(0, chatColor)
end)


local overrideHudColor = online:list("更改颜色", {}, "改变武器轮和其他一些东西的颜色")
local hudColor = 57
overrideHudColor:list_select("颜色", {}, "", colors, chatColor, function(color)
	hudColor = color
end)

overrideHudColor:toggle_loop("更改", {}, "", function()
	SET_CUSTOM_MP_HUD_COLOR(hudColor)
end)

online:toggle_loop("过渡状态", {}, "在右下角显示当前的过渡状态", function()
	if util.is_session_transition_active() then
		BEGIN_TEXT_COMMAND_BUSYSPINNER_ON("STRING")
		ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(getTransitionStateName(getTransitionState()))
		END_TEXT_COMMAND_BUSYSPINNER_ON(5)
	else
		BUSYSPINNER_OFF()
	end
end, function()
	BUSYSPINNER_OFF()
end)

online:toggle_loop("显示NAT", {}, "", function()
	local natTypes = {"开放", "中等", "严格"}
    local getNatType = util.stat_get_int64("_NatType")
    for nat, natType in natTypes do
        if getNatType == nat then
            draw_debug_text($"NAT类型: {natType}")
        end
    end
end)

local auto_accept = online:list("自动接受")
auto_accept:toggle_loop("自动加入", {}, "", function() 
	local msgHash = GET_WARNING_SCREEN_MESSAGE_HASH()
	for warnings as hash do
		if msgHash == hash then
			SET_CONTROL_VALUE_NEXT_FRAME(2, 201, 1.0)
			yield()
			yield()
		end
	end
end)

auto_accept:toggle_loop("交易错误", {}, "", function() 
	local msgHash = GET_WARNING_SCREEN_MESSAGE_HASH()
	for transactionWarnings as hash do
		if msgHash == hash then
			SET_CONTROL_VALUE_NEXT_FRAME(2, 201, 1.0)
			yield()
			yield()
		end
	end
end)

online:toggle("阻止自瞄", {}, "阻止玩家用拳头或瞄准辅助等锁定你", function(toggled)
	SET_PED_CAN_BE_TARGETTED(players.user_ped(), not toggled)
end)

online:toggle_loop("领取悬赏", {"autoclaimbounties"}, "自动领取自己的赏金", function()
	local bounty = players.get_bounty(players.user())
	if bounty != nil then
		repeat
			menu.trigger_commands("removebounty")
			yield(1000)
			bounty = players.get_bounty(players.user())
		until bounty == nil
		toast("已领取自己的赏金 :D")
	end
end)

online:toggle_loop("载具权限", {"accesslockedvehicles"}, "设置为载具使用权没有任何人", function()
	local vehicle = GET_VEHICLE_PED_IS_TRYING_TO_ENTER(players.user_ped())
	local personalVehicle = (DECOR_GET_INT(vehicle, "Player_Vehicle") != 0)
	local driver = GET_PED_IN_VEHICLE_SEAT(vehicle, -1)
	if isPlayerInInterior(players.user()) or vehicle == 0 then return end
	if driver == 0 then
		SET_VEHICLE_EXCLUSIVE_DRIVER(vehicle, 0, 0)
	end 
	SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(vehicle, players.user(), false)
end)

local tutorial_session_list = lobby:list("指导战局", {}, "在你的战局中创建一个战局 互相不同步 某些Stand功能可能无法使用")
local lockedTutorialSession
lockedTutorialSession = tutorial_session_list:toggle("创建", {}, "创建其他人无法加入的指导战局", function(toggled)
	(toggled ? NETWORK_START_SOLO_TUTORIAL_SESSION : NETWORK_END_TUTORIAL_SESSION)()
end)

playerTutorialSessionList = tutorial_session_list:list("列表")
local playerTutorialSession = playerTutorialSessionList:list_action("玩家", {}, "列出大厅中正在进行指导战局的所有玩家", {}, function(playerID)
	if not NETWORK_ARE_PLAYERS_IN_SAME_TUTORIAL_SESSION(players.user(), playerID) then
		NETWORK_ALLOW_GANG_TO_JOIN_TUTORIAL_SESSION(getTeamID(playerID), getInstanceID(playerID))
	repeat
		yield()
	until getTeamID(playerID) == nil or getInstanceID(playerID) == nil
	NETWORK_END_TUTORIAL_SESSION()
end
end)

util.create_tick_handler(function()
	if not isNetPlayerOk(players.user(), true, true) then return end
	local tutorialPlayers = {}
	for players.list_except() as playerID do
		if getTeamID(playerID) != nil and getInstanceID(playerID) != nil then
			tutorialPlayers[#tutorialPlayers + 1] = {playerID, players.get_name(playerID)}
		end
	end
	menu.set_list_action_options(playerTutorialSession, tutorialPlayers)
	yield(1000)
end)

playerTutorialSessionList:action("退出", {"exittutorialsession"}, "退出当前指导战局", function()
	if not NETWORK_IS_IN_TUTORIAL_SESSION() then
		toast("无指导战局 :/")
		return
	end
	NETWORK_END_TUTORIAL_SESSION()
end)

tutorial_session = tutorial_session_list:list("创建")
local team = 0
tutorial_session:slider("团队", {"teamid"}, "", 0, 2, 0, 1, function(value)
	team = value
end)
local instance_id = 0
tutorial_session:slider("实例ID", {"instanceid"}, "", 0, 63, 0, 1, function(value)
	instance_id = value
end)

local tutorialSession
tutorialSession = tutorial_session:toggle_loop("进入", {}, "", function()
	if lockedTutorialSession.value then 
		toast("不能同时启用 :/") 
		tutorialSession.value = false
		return 
	end
	local teamID = team
	NETWORK_ALLOW_GANG_TO_JOIN_TUTORIAL_SESSION(teamID, instance_id)
	while teamID == team do
		yield()
	end
end, function()
	NETWORK_END_TUTORIAL_SESSION()
end)

local orbital = lobby:list("反天基炮")
local spoofOrbital = orbital:list("虚假位置")
local spoofOrbPly = spoofOrbital:list("虚假他人位置")

local playerList = {}
playerList[players.user()] = {players.user(), players.get_name(players.user())}
local selectedPlayer = players.user()
local spoofOrb = spoofOrbPly:list_select("位置", {}, "选择一名玩家", playerList, players.user(), function(playerID)
	selectedPlayer = playerID
end)

util.create_tick_handler(function()
	playerList = {}
	for players.list_except() as playerID do
		playerList[#playerList + 1] = {playerID, players.get_name(playerID)}
	end
	menu.set_list_action_options(spoofOrb, playerList)
	yield(1000)
end)

spoofOrbPly:toggle_loop("启用", {}, "", function()
	for players.list_except(true) as playerID do
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local pos = players.get_position(selectedPlayer)
		if isPlayerUsingOrbitalCannon(playerID) then
			invisibility:setState("Locally Visible")
			positonSpoofing.value = true
			repeat
				pos.z -= 190
				spoofedPos:trigger(pos:toString())
				pos = players.get_position(selectedPlayer)
				yield()
			until not isPlayerUsingOrbitalCannon(playerID) or not players.exists(playerID)
			invisibility:setState("Disabled")
			positonSpoofing.value = false
		end
	end
end, function()
	invisibility:setState("Disabled")
	positonSpoofing.value = false
end)

local spoofedX = 0.00
spoofOrbital:slider_float("X", {"spoofedxaxis"}, "", 0, 1000000, 0, 1, function(x_pos)
	spoofedX = x_pos/100
end)

local spoofedY = 0.00
spoofOrbital:slider_float("Y", {"spoofedyaxis"}, "", 0, 1000000, 0, 1, function(y_pos)
	spoofedY = y_pos/100
end)

local spoofedZ = 0.00
spoofOrbital:slider_float("Z", {"spoofedzaxis"}, "", -20000, 270000, 0, 1, function(z_pos)
	spoofedZ = z_pos/100
end)

spoofOrbital:toggle_loop("启用", {}, "", function()
	for players.list_except(true) as playerID do
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		if isPlayerUsingOrbitalCannon(playerID) and GET_IS_TASK_ACTIVE(ped, 135) then
			positonSpoofing.value = true
			spoofedPos:trigger(tostring(spoofedX .. "," .. spoofedY .. "," .. spoofedZ))
			repeat
				yield()
			until not isPlayerUsingOrbitalCannon(playerID) or not players.exists(playerID)
			positonSpoofing.value = false
		end
	end
end)

orbital:toggle_loop("封闭室门", {"blockorb"}, "生成物体阻挡对方进入天基炮室", function()
	local blockOrbMdl = joaat("h4_prop_h4_garage_door_01a")
	local blockOrbMdlSign = joaat("xm_prop_x17_screens_02a_07")
	util.request_model(blockOrbMdl)
	util.request_model(blockOrbMdlSign)
	if orbObj == nil or not DOES_ENTITY_EXIST(orbObj) then
		orbObj = entities.create_object(blockOrbMdl, v3(335.9, 4833.9, -59.0))
		orbSign = entities.create_object(blockOrbMdlSign, v3(335.9, 4834, -57.0))
		entities.set_can_migrate(orbObj, false)
		entities.set_can_migrate(orbSign, false)
		SET_ENTITY_HEADING(orbObj, 125.0)
		SET_ENTITY_HEADING(orbSign, 125.0)
		FREEZE_ENTITY_POSITION(orbObj, true)
		SET_ENTITY_NO_COLLISION_ENTITY(players.user_ped(), orbObj, false)
		SET_ENTITY_ROTATION(orbSign, -25.0, 0.0, 125.0, 2, true)
	end
	yield(50)
end, function()
	if orbObj != nil then
		entities.delete(orbObj)
	end
	if orbSign != nil then
		entities.delete(orbSign)
	end
end)

local annoy = orbital:list("闪烁延迟", {}, "快速闪烁你的名称并将其从目标玩家列表中删除")
local orbDelay = 1000
annoy:list_select("延迟", {}, "天基炮使用者看你名字的闪烁速度", {{1000, "慢"}, {500, "中"}, {100, "快"}}, orbDelay, function(value)
	orbDelay = value
end)

local annoy_tgl
annoy_tgl = annoy:toggle_loop("启用", {}, "", function()
	for players.list_except(true) as playerID do
	   if isPlayerUsingOrbitalCannon(playerID) then
			repeat
				SET_REMOTE_PLAYER_AS_GHOST(playerID, true)
				yield(orbDelay)
				SET_REMOTE_PLAYER_AS_GHOST(playerID, false)
				yield(orbDelay)
			until not isPlayerUsingOrbitalCannon(playerID) or not players.exists(playerID)
			SET_REMOTE_PLAYER_AS_GHOST(playerID, false)
		end
	end
end)

local ghostOrb = orbital:list("幽灵模式")
ghostOrb:toggle_loop("总是", {"ghostorb"}, "自动幽灵化使用天基炮的玩家", function()
	for players.list_except() as playerID do
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local camDistance = v3.distance(players.get_position(players.user()), players.get_cam_pos(playerID))
		if isPlayerUsingOrbitalCannon(playerID) and GET_IS_TASK_ACTIVE(ped, 135) then
			SET_REMOTE_PLAYER_AS_GHOST(playerID, true)
			repeat
				yield()
			until not isPlayerUsingOrbitalCannon(playerID)
			SET_REMOTE_PLAYER_AS_GHOST(playerID, false)
		end
	end
end, function()
	for players.list_except(true) as playerID do
		SET_REMOTE_PLAYER_AS_GHOST(playerID, false)
	end
end)

ghostOrb:toggle_loop("瞄准时", {}, "被瞄准时自动幽灵使用天基炮瞄准你的玩家", function()
	for players.list_except(true) as playerID do
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local pos = players.get_position(players.user())
		local distance = v3.distance(pos, v3.setZ(players.get_cam_pos(playerID), pos.z))
		if isPlayerUsingOrbitalCannon(playerID) and distance < 25.0 and not isPlayerInInterior(players.user()) then
			SET_REMOTE_PLAYER_AS_GHOST(playerID, true)
			repeat
				yield()
			until not isPlayerUsingOrbitalCannon(playerID)
			SET_REMOTE_PLAYER_AS_GHOST(playerID, false)
		end
	end
end, function()
	for players.list_except(true) as playerID do
		SET_REMOTE_PLAYER_AS_GHOST(playerID, false)
	end
end)

orbital:toggle_loop("自动幽灵", {"ghostmoddedorbs"}, "反击作弊天基炮 自动幽灵使用天基炮瞄准你的玩家", function()
	for players.list_except() as playerID do
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local camDistance = v3.distance(players.get_position(players.user()), players.get_cam_pos(playerID))
		if isPlayerUsingOrbitalCannon(playerID) and not GET_IS_TASK_ACTIVE(ped, 135) then
			SET_REMOTE_PLAYER_AS_GHOST(playerID, true)
			repeat
				yield()
			until not isPlayerUsingOrbitalCannon(playerID)
			SET_REMOTE_PLAYER_AS_GHOST(playerID, false)
		end
	end
end, function()
	for players.list_except(true) as playerID do
		SET_REMOTE_PLAYER_AS_GHOST(playerID, false)
	end
end)

local drawOrbitalCannon = orbital:list("显示天基")
local orbColor = {r = 255/255, g = 0, b = 255/255, a = 0}
drawOrbitalCannon:colour("颜色", {"markercolor"}, "单击以选择一种颜色", orbColor, true, function(value)
	orbColor = value 
end)

drawOrbitalCannon:toggle_loop("位置", {}, "", function()
for players.list_except() as playerID do
		if isPlayerUsingOrbitalCannon(playerID) then
			local cam = players.get_cam_pos(playerID)
			local rot, dir =  v3(), v3()
			local ground
			ground, cam.z = util.get_ground_z(cam.x, cam.y)
			if not ground then continue end
			local camDistance = v3.distance(cam, players.get_cam_pos(playerID))
			DRAW_MARKER(28, cam, rot, dir, 1.0, 1.0, camDistance, math.floor(orbColor.r * 255), math.floor(orbColor.g * 255), math.floor(orbColor.b * 255), 105, false, false, 0, false, 0, 0, false)
		end
	end
end)

local rp_loop = lobby:list("经验循环", {}, "对战局每个人循环经验")
local level = 120
rp_loop:slider("目标值", {"maxlevellobby"}, "", 1, 8000, 120, 1, function(val)
	level = val
end)

local delay = 5
rpLoopAll = rp_loop:slider("延迟", {"loopdelaylobby"}, '人多的战局不要设置成最快 可能有问题', 0, 2500, 5, 5, function(val)
	delay = val
end)
menu.add_value_replacement(rpLoopAll, 0, "最快（阅读说明）")
menu.add_value_replacement(rpLoopAll, 5, "默认")

function triggerCollectibleLoop(playerID, i)
	if players.get_rank(playerID) >= level then return end
	util.trigger_script_event(1 << playerID, {968269233, players.user(), 4, i, 1, 1, 1})
	util.trigger_script_event(1 << playerID, {968269233, players.user(), 8, -1, 1, 1, 1})
end

local lobbyRPLoop
lobbyRPLoop = rp_loop:toggle_loop("启用", {"rplooplobby"}, "对战局中的每个人启用经验循环", function()
	if not isNetPlayerOk(players.user(), true, true) then
		lobbyRPLoop.value = false
		return
	end
	for players.list_except(true) as playerID do
		if not menu.player_root(playerID):isValid() then return end
		local giveRP = menu.ref_by_rel_path(menu.player_root(playerID), "Friendly>Give RP")
		if players.is_marked_as_modder(playerID) or players.get_weapon_damage_modifier(playerID) == 1 or not isNetPlayerOk(playerID) or players.get_rank(playerID) >= level then continue end
		if delay == 0 then
			for i = 21, 24 do
				triggerCollectibleLoop(playerID, i)
				giveRP:trigger()
			end
		elseif delay == 5 then
			triggerCollectibleLoop(playerID, math.random(21, 24)) -- limiting the amount of script events sent to prevent a fatal error
		else
			for i = 21, 24 do
				triggerCollectibleLoop(playerID, i)
			end
			yield(delay)
		end
	end	
end)

lobby:action("劫持所有", {"hijackall"}, "劫持全部载具", function()
	for players.list_except(true) as playerID do
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local pos = players.get_position(playerID)
		if DOES_ENTITY_EXIST(ped) and IS_PED_IN_ANY_VEHICLE(ped) then
			menu.trigger_commands($"hijack {players.get_name(playerID)}")
		end
	end
end)

lobby:toggle_loop("锁定所有", {"lockall"}, "锁定所有载具", function()
	for players.list_except(true) as playerID do
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local vehicle = GET_VEHICLE_PED_IS_TRYING_TO_ENTER(ped)
		if not GET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(vehicle, playerID) then
			SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(vehicle, playerID, true)
		end
	end
end)

lobby:toggle_loop("干扰导弹", {"annoy"}, "", function()
	for _, playerID in players.list_except() do
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local vehicle = GET_VEHICLE_PED_IS_USING(ped)
		if GET_IS_TASK_ACTIVE(ped, 199) then
			SET_VEHICLE_HOMING_LOCKEDONTO_STATE(vehicle, 1)
		end
	end
end)

local horny = lobby:list("击杀招妓")
local horny_counter = 0
horny:toggle_loop("惩治", {}, "杀死试图招妓的好色玩家", function()
	local timer = util.current_time_millis() + 2500
	for players.list_except() as playerID do
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local pPed =  entities.handle_to_pointer(ped)
		local pedPtr = entities.handle_to_pointer(players.user_ped())
		local vehicle = GET_VEHICLE_PED_IS_USING(ped)
		if isPlayerSolicitingProstitute(playerID) and GET_IS_TASK_ACTIVE(ped, 135) then
			repeat
				if util.current_time_millis() > timer then
					timer = util.current_time_millis() + 2500
					return
				end
				util.call_foreign_function(CWeaponDamageEventTrigger, pedPtr, pPed, pPed + 0x90, 0, 1, joaat("weapon_stungun_mp"), 1000.0, 0, 0, DF_IsAccurate | DF_IgnoreRemoteDistCheck, 0, 0, 0, 0, 0, 0, 0, 0.0)
				yield()
			until IS_PLAYER_DEAD(ped)
			toast($"击杀 {players.get_name(playerID)} 因为太饥渴了")
			timer = util.current_time_millis() + 2500
		end
	end
end)

horny:toggle_loop("羞辱", {}, "在聊天中取笑对方来羞辱试图招妓的好色玩家", function()
	for players.list_except() as playerID do
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local vehicle = GET_VEHICLE_PED_IS_USING(ped)
		if isPlayerSolicitingProstitute(playerID) and GET_IS_TASK_ACTIVE(ped, 135) then
			chat.send_message($"Horny person detected! {players.get_name(playerID)} is having sex with a prostitute. HAHA, loser!", false, true, true)
			repeat
				yield()
			until not isPlayerSolicitingProstitute(playerID)
		end
	end
end)

local reversed_messages = {}
local reverse_msg = false
chat.on_message(function(packet_sender, message_sender, text, team_chat)
	if reverse_msg and message_sender != players.user() and not reversed_messages[text] then -- prevent message spam
		chat.send_message(string.reverse(text), false, true, true)
		reversed_messages[text] = {timestamp = os.time()}
	end
end)

lobby:toggle("镜像复述", {}, "镜像复述聊天文字", function(toggled)
	reverse_msg = toggled
end)

local messageTimeout = 5
util.create_tick_handler(function()
	for msg, messageData in reversed_messages do
		if os.time() - messageData.timestamp > messageTimeout then
			reversed_messages[msg] = nil
		end
	end
end)

missions:action("杀死所有", {}, "", function()
	local counter = 0
	for entities.get_all_peds_as_handles() as ped do
		if GET_BLIP_COLOUR(GET_BLIP_FROM_ENTITY(ped)) == 1 or GET_IS_TASK_ACTIVE(ped, 352) then -- shitty way to go about it but hey, it works (most of the time).
			SET_ENTITY_HEALTH(ped, 0, 0, 0)
			counter += 1
			yield()
		end
	end
	toast(counter == 0 ? "无敌人 :/" : $"击杀 {tostring(counter)} 敌人")
end)

missions:action("传拾取物", {}, "", function()
	local counter = 0
	local pos = players.get_position(players.user())
	for entities.get_all_pickups_as_handles() as pickup do
		SET_ENTITY_COORDS(pickup, pos, false, false, false, false)
		counter += 1
		yield()
	end
	toast(counter == 0 ? "无拾取物 :/" : $"传送 {tostring(counter)} 拾取物")
end)

local pedSeeingRange = missions:list("视野范围")
local pedHearingRange = missions:list("听觉范围")
local pedIdRange = missions:list("识别范围")

local seeingRange = 60.0
local seeingRangeSlider = pedSeeingRange:slider_float("范围", {"seeingrange"}, "行人可以看到你的范围", 0, 10000, 6000, 100, function(value)
	seeingRange = value/100
end)
menu.add_value_replacement(seeingRangeSlider, 6000, "默认")

pedSeeingRange:toggle_loop("启用", {}, "", function()
	for entities.get_all_peds_as_handles() as ped do
		SET_PED_SEEING_RANGE(ped, seeingRange)
	end
end, function()
	for entities.get_all_peds_as_handles() as ped do
		SET_PED_SEEING_RANGE(ped, 60.0)
	end
end)

local hearingRange = 60.0
local hearingRangeSlider = pedHearingRange:slider_float("范围", {"hearingrange"}, "", 0, 10000, 6000, 100, function(value)
	hearingRange = value/100
end)
menu.add_value_replacement(hearingRangeSlider, 6000, "默认")

pedHearingRange:toggle_loop("启用", {}, "", function()
	for entities.get_all_peds_as_handles() as ped do
		SET_PED_HEARING_RANGE(ped, hearingRange)
	end
end, function()
	for entities.get_all_peds_as_handles() as ped do
		SET_PED_HEARING_RANGE(ped, 60.0)
	end
end)

local idRange = 20.0
local idRangeSlider = pedIdRange:slider_float("范围", {"idrange"}, "行人可以识别你的范围", 0, 10000, 2000, 100, function(value)
	idRange = value/100
end)
menu.add_value_replacement(idRangeSlider, 2000, "默认")

pedIdRange:toggle_loop("启动", {}, "", function()
	for entities.get_all_peds_as_handles() as ped do
		SET_PED_ID_RANGE(ped, idRange)
	end
end, function()
	for entities.get_all_peds_as_handles() as ped do
		SET_PED_ID_RANGE(ped, 20.0)
	end
end)

missions:toggle("任务跳过", {}, "在故事模式中死亡后 就可以选择跳过任务", function(toggled)
	memory.write_int(memory.script_global(95689), toggled ? 1 : 0)
	memory.write_int(memory.script_global(95691), toggled ? 1 : 0)
end)

missions:toggle("死亡跳过", {}, "死亡时自动跳过当前任务", function(toggled)
	memory.write_int(memory.script_global(95690), toggled ? 1 : 0)
end)

weapons:toggle_loop("武器双发", {"doubletap"}, "一枪射两发子弹", function()
	if IS_PED_SHOOTING(players.user_ped()) then
		FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
	end
end)

weapons:toggle_loop("武器换弹", {"instantreload"}, "跳过重新装填 不会导致武器快速射击", function()
	if IS_PED_RELOADING(players.user_ped()) then
		REFILL_AMMO_INSTANTLY(players.user_ped())
	end
end)

weapons:toggle_loop("武器自瞄", {"aimbotall"}, "", function()
	for players.list_except() as playerID do
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local pPed =  entities.handle_to_pointer(ped)
		local pedPtr = entities.handle_to_pointer(players.user_ped())
		local wpn = GET_SELECTED_PED_WEAPON(players.user_ped())
		local dmg = GET_WEAPON_DAMAGE(wpn, 0)
    local bones = {31086, 24816, 40269, 45509, 0, 51826, 58271}
		if IS_PLAYER_FREE_AIMING_AT_ENTITY(players.user(), ped) and IS_PED_SHOOTING(players.user_ped()) and not IS_ENTITY_A_GHOST(ped) then
			boneIndex = bones[math.random(#bones)]
			local boneCoords = GET_PED_BONE_COORDS(ped, boneIndex, 0.0, 0.0, 0.0)
			util.call_foreign_function(CWeaponDamageEventTrigger, pedPtr, pPed, boneCoords, 0, 1, wpn, dmg, 0, 0, DF_IsAccurate | DF_AllowHeadShot | DF_IgnoreRemoteDistCheck, 0, 0, 0, 0, 0, 0, 0, v3())
		end
	end
end)

local modifier = 1.00
weapons:slider_float("武器伤害", {"meleedamage"}, "", 100, 1000, 100, 10, function(value)
	modifier = value / 100
	SET_PLAYER_MELEE_WEAPON_DAMAGE_MODIFIER(players.user(), modifier)
end)

weapons:toggle_loop("武器锁定", {}, "导弹锁定范围和自动瞄准设置为最大", function()
	SET_PLAYER_LOCKON_RANGE_OVERRIDE(players.user(), 99999999.0)
end)

weapons:toggle_loop("武器射程", {}, "将武器射程扩展到250米", function()
	SET_PED_RESET_FLAG(players.user_ped(), 95, GET_MAX_RANGE_OF_CURRENT_PED_WEAPON(players.user_ped()) < 250.0)
end)

local overrideBulletProjectile = false
local changeBulletProjectile = weapons:list("武器子弹", {}, "")
for id, data in weapon_stuff do
	local name = data[1]
	local weaponName = data[2]
	local bulletProjectile
	bulletProjectile = changeBulletProjectile:toggle_loop(name, {}, "", function()
		overrideBulletProjectile = true
		local wpn = GET_SELECTED_PED_WEAPON(players.user_ped())
		local shotDelay = GET_WEAPON_TIME_BETWEEN_SHOTS(wpn)
		local inst = v3.new()
		if IS_CONTROL_PRESSED(0, 92) and IS_PLAYER_FREE_AIMING(players.user()) then
			local finalCoords = GET_FINAL_RENDERED_CAM_ROT(2):toDir():mul(1000):add(players.get_cam_pos(players.user()))
			local wpEnt = GET_CURRENT_PED_WEAPON_ENTITY_INDEX(players.user_ped(), 0)
			local wpCoords = GET_ENTITY_BONE_POSTION(wpEnt, GET_ENTITY_BONE_INDEX_BY_NAME(wpEnt, "gun_muzzle"))
			SHOOT_SINGLE_BULLET_BETWEEN_COORDS(wpCoords, finalCoords, 1, true, joaat(weaponName), players.user_ped(), true, false, 1000.0)
			yield(shotDelay * 1000)
		end
	end, function()
		local pos = players.get_position(players.user())
		CLEAR_AREA_OF_PROJECTILES(pos, 999999.0, 0)
	    overrideBulletProjectile = false
	end)
end

util.create_tick_handler(function()
	while true do
		if overrideBulletProjectile then
			DISABLE_PLAYER_FIRING(players.user(), false)
		end
		yield()
	end
end)

weapons:toggle_loop("武器快切", {"fasthands"}, "", function()
	if GET_IS_TASK_ACTIVE(players.user_ped(), 56) then
		FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
	end
end)

weapons:toggle_loop("武器制导", {}, "允许使用制导发射器锁定玩家", function()
	for players.list_except(true) as playerID do
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		ADD_PLAYER_TARGETABLE_ENTITY(players.user(), ped)
		SET_ENTITY_IS_TARGET_PRIORITY(ped, false, 400.0)    
	end
end, function()
	for players.list_except(true) as playerID do
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		REMOVE_PLAYER_TARGETABLE_ENTITY(players.user(), ped)
	end
end)

local nitrous = vehicles:list("载具氮气", {}, "注意 可能其他玩家也可以看到这一点")
local durationMod = 1.0
nitrous:slider_float("持续值", {"duration"}, "氮持续的秒数", 100, 1000, 300, 50, function(value)
	durationMod = value/300 -- this seems to be the exact conversion for converting the float to seconds
	--toast(value/300)
end)

local powerMod = 1.5
nitrous:slider_float("功率值", {"multiplier"}, "", 100, 1000, 150, 50, function(value)
	powerMod = value/100
end)

local rechargeMod = 2.0
nitrous:slider_float("加载值", {"rechargetime"}, "可能会根据持续时间而变化", 100, 1000, 200, 50, function(value)
	rechargeMod = value/100
end)

nitrous:toggle("喇叭氮气", {}, "", function(toggled)
	_SET_VEHICLE_USE_HORN_BUTTON_FOR_NITROUS(toggled)
end)

nitrous:toggle_loop("禁用氮气", {}, "松开W键时禁用氮气", function(toggled)
	local vehicle = entities.get_user_vehicle_as_handle()
	if IS_CONTROL_JUST_RELEASED(0, 71) and IS_NITROUS_ACTIVE(vehicle) then
		SET_OVERRIDE_NITROUS_LEVEL(vehicle, false, durationMod, powerMod, rechargeMod, false) -- SET_NITROUS_IS_ACTIVE didnt wanna work here cus gay
	end
end)

nitrous:toggle_loop("禁用空中", {}, "在空中禁用", function(toggled)
	local vehicle = entities.get_user_vehicle_as_handle()
	if IS_ENTITY_IN_AIR(vehicle) then
		SET_OVERRIDE_NITROUS_LEVEL(vehicle, false, durationMod, powerMod, rechargeMod, false) -- SET_NITROUS_IS_ACTIVE didnt wanna work here cus gay
	end
end)


local nitrousPtfxActive = false
nitrous:action("加载画效", {"loadnitrousptfx"}, "为附近的玩家加载氮气画效 以便他们也能看到火焰", function() 
	local vehicle = entities.get_user_vehicle_as_handle()
	loadPtfxAsset("veh_xs_vehicle_mods")
	USE_PARTICLE_FX_ASSET("veh_xs_vehicle_mods")
	if nitrousPtfxActive then
		toast("已启动 请稍等")
		return
	end
	ptfx = START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY("veh_nitrous", vehicle, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, false, false, false, 0, 0, 0, 255)
	nitrousPtfxActive = true
	toast("加载图效")
	yield(5000)
	REMOVE_PARTICLE_FX(ptfx)
	toast("成功 :D")
	nitrousPtfxActive = false
end)


local clearedNitrous = false
local nitrousTgl
nitrousTgl = nitrous:toggle_loop("启用", {"nitrous"}, "默认按钮是X", function()
	if GET_HAS_ROCKET_BOOST(entities.get_user_vehicle_as_handle()) then return end
	if not clearedNitrous then
		CLEAR_NITROUS(entities.get_user_vehicle_as_handle()) -- clearing nitrous on feature startup because the bar doesn't go down if enabled while full.
		clearedNitrous = true
		return
	else
		loadPtfxAsset("veh_xs_vehicle_mods")
		local vehicle = entities.get_user_vehicle_as_handle()
		SET_OVERRIDE_NITROUS_LEVEL(vehicle, true, durationMod, powerMod, rechargeMod, false)
		if not IS_NITROUS_ACTIVE(vehicle) then
			SET_NITROUS_IS_ACTIVE(vehicle, false) -- disable the nitrous ptfx when not active, removing the ptfx still left the lights from the ptfx behind
			return
		end
	end
end, function()
	SET_OVERRIDE_NITROUS_LEVEL(entities.get_user_vehicle_as_handle(), false, 0.0, 0.0, 0.0, false)
	clearedNitrous = false
end)

local flamethrowerTune = vehicles:list("载具尾焰", {}, "")
local redline
redline = flamethrowerTune:toggle_loop("启动时", {}, "", function()
	if not nitrousTgl.value then 
		toast("请先启用氮气 :/")
		redline.value = false
		return
	end
	loadPtfxAsset("veh_xs_vehicle_mods")
	local vehPtr = entities.get_user_vehicle_as_pointer()
	local vehHandle = entities.get_user_vehicle_as_handle()
	if vehPtr == 0 then return end
	SET_NITROUS_IS_ACTIVE(vehHandle, entities.get_rpm(vehPtr) == 1.0 and entities.get_current_gear(vehPtr) == 1)
end)

local downshift
downshift = flamethrowerTune:toggle_loop("降档时", {}, "", function()
	if not nitrousTgl.value then 
		toast("请先启用氮气 :/")
		downshift.value = false
		return
	end
	loadPtfxAsset("veh_xs_vehicle_mods")
	local vehPtr = entities.get_user_vehicle_as_pointer()
	local vehHandle = entities.get_user_vehicle_as_handle()
	if vehPtr == 0 then return end
	local prevGear = entities.get_current_gear(vehPtr)
	yield()
	yield()
	local curGear = entities.get_current_gear(vehPtr)
	if curGear < prevGear then
		for i = 1, 25 do
			SET_NITROUS_IS_ACTIVE(vehHandle, true)
			yield()
		end
	end
end)

local upshift
upshift = flamethrowerTune:toggle_loop("升档时", {}, "", function()
	if not nitrousTgl.value then 
		toast("请先启用氮气 :/")
		upshift.value = false
		return
	end
	loadPtfxAsset("veh_xs_vehicle_mods")
	local vehPtr = entities.get_user_vehicle_as_pointer()
	local vehHandle = entities.get_user_vehicle_as_handle()
	if vehPtr == 0 then return end
	local prevGear = entities.get_current_gear(vehPtr)
	yield()
	yield()
	local curGear = entities.get_current_gear(vehPtr)
	if curGear > prevGear then
		for i = 1, 25 do
			SET_NITROUS_IS_ACTIVE(vehHandle, true)
			yield()
		end
	end
end)

local accelerating
accelrating = flamethrowerTune:toggle_loop("加速时", {}, "", function()
	if not nitrousTgl.value then 
		toast("请先启用氮气 :/")
		accelrating.value = false
		return
	end
	loadPtfxAsset("veh_xs_vehicle_mods")
	local vehicle = entities.get_user_vehicle_as_handle()
	SET_NITROUS_IS_ACTIVE(vehicle, IS_CONTROL_PRESSED(0, 71))
end)

local alwaysOn
alwaysOn = flamethrowerTune:toggle_loop("总是", {}, "", function()
	if not nitrousTgl.value then 
		toast("请先启用氮气 :/")
		alwaysOn.value = false
		return
	end
	loadPtfxAsset("veh_xs_vehicle_mods")
	local vehicle = entities.get_user_vehicle_as_handle()
	SET_NITROUS_IS_ACTIVE(vehicle, true)
end)

flamethrowerTune:action("加载画效", {}, "", function() 
	menu.trigger_commands("loadnitrous")
end)

local antilag = vehicles:list("载具音爆", {}, "")
local antilagDelay = 100
antilag:slider("间隔", {"antilagdelay"}, "排气管音爆的时间间隔", 0, 1000, 100, 10, function(amount)
	antilagDelay = amount
end)

local random = false
antilag:toggle("随机", {}, "随机排气管音爆的时间间隔", function(toggled)
	random = toggled
end)

antilag:toggle_loop("启用", {"antilag"}, "启动你的引擎来使用 仅在载具静止时有效 本地可见", function()
	local veh = entities.get_user_vehicle_as_pointer()
	if veh == 0 then return end
	local gear = entities.get_current_gear(veh)
	local rpm = entities.get_rpm(veh)
	if IS_CONTROL_PRESSED(0, 22) and IS_CONTROL_PRESSED(0, 71) then
		entities.set_rpm(veh, 0.9)
		yield(random ? math.random(100, antilagDelay) : antilagDelay)
		entities.set_rpm(veh, 0.1)
	end
end)

local wheelie = vehicles:list("载具前轮")
local wheelie_val = 0.3
wheelie:slider_float("翘起值", {"wheeliepower"}, "", 10, 100, 30, 5, function(value)
	wheelie_val = value / 100
end)

wheelie:toggle_loop("启用", {}, "按Ctrl和W", function()
	local CAutomobile = entities.get_user_vehicle_as_pointer()
	if CAutomobile == 0 then return end
	local vehicleModel = GET_ENTITY_MODEL(entities.get_user_vehicle_as_handle())
	if not IS_THIS_MODEL_A_CAR(vehicleModel) and not IS_THIS_MODEL_AN_AMPHIBIOUS_CAR(vehicleModel) then 
		return 
	end
	local CHandlingData = entities.vehicle_get_handling(CAutomobile)
	memory.write_float(CHandlingData + 0x00EC, IS_CONTROL_PRESSED(0, 71) and IS_CONTROL_PRESSED(0, 280) ? -wheelie_val : 0.5)
end)

local clumsiness = vehicles:list("载具翻滚", {}, "使载具轻松翻滚")
local clumsy_val = 0.3
clumsiness:slider_float("翻滚值", {"clumsinessvalue"}, "", 10, 100, 30, 5, function(value)
	clumsy_val = value / 100
end)

clumsiness:toggle_loop("启用", {"vehicleclumsiness"}, "", function()
	local CAutomobile = entities.get_user_vehicle_as_pointer()
	if CAutomobile == 0 then return end
	local vehicleModel = GET_ENTITY_MODEL(entities.get_user_vehicle_as_handle())
	if not IS_THIS_MODEL_A_CAR(vehicleModel) and not IS_THIS_MODEL_AN_AMPHIBIOUS_CAR(vehicleModel) then 
		return 
	end
	local CHandlingData = entities.vehicle_get_handling(CAutomobile)
		memory.write_float(CHandlingData + 0x00EC, IS_CONTROL_PRESSED(0, 266) or IS_CONTROL_PRESSED(0, 267) ? -clumsy_val : 0.5)
end, function()
	local CAutomobile = entities.get_user_vehicle_as_pointer()
	if CAutomobile == 0 then return end
	local CHandlingData = entities.vehicle_get_handling(CAutomobile)
	memory.write_float(CHandlingData + 0x00EC, 0.5)
end)


local engineSound = vehicles:list("载具声音", {}, "注意 某些发动机声音可能会影响你的载具加速")
local vehicleClass = {}
local ignore_duplicates = {} 
for util.get_vehicles() as vehicle do
	local name = util.get_label_text(vehicle.name)
	local hash = joaat(vehicle.name)
	local vehClassName = GET_VEHICLE_CLASS_FROM_NAME(hash)

	if ignore_class or name == "NULL" or ignore_duplicates[name] or (not IS_THIS_MODEL_A_CAR(hash) and not IS_THIS_MODEL_A_BIKE(hash) and not IS_THIS_MODEL_A_QUADBIKE(hash)) then 
		continue 
	end
	if not vehicleClass[vehClassName] then
		vehicleClass[vehClassName] = engineSound:list(util.get_label_text($"VEH_CLASS_{vehClassName}"))
	end
	ignore_duplicates[name] = true
	engineSound.action(vehicleClass[vehClassName], name, {$"engine {name}"}, "", function()
		PRELOAD_VEHICLE_AUDIO_BANK(hash)
		SET_RADIO_TO_STATION_NAME("OFF") -- the radio kept changing for some reason so this should fix that
		FORCE_USE_AUDIO_GAME_OBJECT(entities.get_user_vehicle_as_handle(), vehicle.name)
		yield(100)
		SET_RADIO_TO_STATION_NAME("OFF") -- sometimes it doesn't turn off
	end)
end

vehicles:toggle_loop("载具电台", {}, "", function()
	local vehicle = GET_VEHICLE_PED_IS_USING(players.user_ped())
	if GET_PLAYER_RADIO_STATION_NAME() != "OFF" and GET_IS_VEHICLE_ENGINE_RUNNING(vehicle) then
		yield(150)
		SET_RADIO_TO_STATION_NAME("OFF")
		repeat
			local curVehicle = GET_VEHICLE_PED_IS_USING(players.user_ped())
			yield()
		until not IS_PED_IN_ANY_VEHICLE(players.user_ped()) or curVehicle != vehicle
	end
end)

vehicles:toggle_loop("载具火箭", {"vehiclerockets"}, "按鼠标左键开火", function()
	local wpn = joaat("vehicle_weapon_tank")
	local vehicle = entities.get_user_vehicle_as_handle()
	local offset = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
	local leftStart = offset(vehicle, -1.25, 0.5, 0.35)
	local leftEnd = offset(vehicle, -1.25, 100.0, 0.35)
	local rightStart = offset(vehicle, 1.25, 0.5, 0.35)
	local rightEnd = offset(vehicle, 1.25, 100.0, 0.35)
	if IS_PED_IN_ANY_VEHICLE(players.user_ped()) and not GET_IS_TASK_ACTIVE(players.user_ped(), 199) and IS_CONTROL_JUST_RELEASED(0, 69) and not IS_CONTROL_PRESSED(0, 68) then
		SHOOT_SINGLE_BULLET_BETWEEN_COORDS(leftStart, leftEnd, 0, true, wpn, players.user_ped(), true, false, 5.0)
		SHOOT_SINGLE_BULLET_BETWEEN_COORDS(rightStart, rightEnd, 0, true, wpn, players.user_ped(), true, false, 5.0)
	end
end)

vehicles:toggle_loop("载具车门", {}, "当上车权限设置为无人时 模仿灭世2000的车门把手电击锁", function()
	for players.list_except(true) as playerID do
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local pPed =  entities.handle_to_pointer(ped)
		local pedPtr = entities.handle_to_pointer(players.user_ped())
		local vehicle = entities.get_user_vehicle_as_handle()
		local PersonalVehicle = DECOR_GET_INT(vehicle, "Player_Vehicle") != 0
		local boneCoords = GET_PED_BONE_COORDS(ped, 0xFCD9, v3())
		if GET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(vehicle, playerID) and GET_VEHICLE_PED_IS_TRYING_TO_ENTER(ped) == vehicle and PersonalVehicle and IS_THIS_MODEL_A_CAR(GET_ENTITY_MODEL(vehicle)) then
			if HAS_ANIM_EVENT_FIRED(ped, -1526509349) then
				util.call_foreign_function(CWeaponDamageEventTrigger, pedPtr, pPed, boneCoords, 0, 1, joaat("weapon_stungun_mp"), 1.0, 0, 0, DF_IsAccurate | DF_IgnoreRemoteDistCheck, 0, 0, 0, 0, 0, 0, 0, 0.0)
				yield(1000)
			end
		end
	end
end)

local veh_jump = vehicles:list("载具跳跃")
local jumpForce = 25.00
veh_jump:slider_float("跳跃值", {"jumpiness"}, "", 0, 10000, 2500, 100, function(value)
	jumpForce = value / 100
end)

veh_jump:toggle_loop("启用", {"vehiclejump"}, "按空格键跳跃", function()
	local vehicle = entities.get_user_vehicle_as_handle()
	if vehicle != 0 and DOES_ENTITY_EXIST(vehicle) and IS_CONTROL_JUST_RELEASED(0, 102) then
		APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, jumpForce/1.5, jumpForce, 0.0, 0.0, 0.0, 0, true, true, true, false, true)
		repeat
			yield()
		until not IS_ENTITY_IN_AIR(vehicle)
	end
end)

vehicles:toggle("载具室灯", {}, "", function(toggled)
	SET_VEHICLE_FORCE_INTERIORLIGHT(entities.get_user_vehicle_as_handle(), toggled)
end)

local deformation = 1.00
vehicles:slider_float("载具变形", {"deformation"}, "", -1000000, 1000000, 100, 100, function(value)
	deformation = value / 100
	menu.trigger_commands($"vhdeformationmult {deformation}")
end)

vehicles:toggle_loop("载具车门", {}, "自动解锁车门", function()
	local vehicle = GET_VEHICLE_PED_IS_TRYING_TO_ENTER(players.user_ped())
	SET_VEHICLE_DOORS_LOCKED(vehicle,  1)
end)

vehicles:toggle_loop("载具引擎", {}, "自动启动引擎", function()
	local vehicle = GET_VEHICLE_PED_IS_TRYING_TO_ENTER(players.user_ped())
	SET_VEHICLE_NEEDS_TO_BE_HOTWIRED(vehicle, false)
end)

vehicles:toggle_loop("载具进出", {"fastvehicleenter"}, "加快进出载具速度", function()
	if (GET_IS_TASK_ACTIVE(players.user_ped(), 160) or GET_IS_TASK_ACTIVE(players.user_ped(), 167) or GET_IS_TASK_ACTIVE(players.user_ped(), 165)) and not GET_IS_TASK_ACTIVE(players.user_ped(), 195) then
		FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
	end
end)

vehicles:toggle_loop("载具无敌", {}, "下载具自动关闭载具无敌", function()
	local vehicle = entities.get_user_vehicle_as_handle()
	if entities.is_invulnerable(vehicle) then
		if not IS_PED_IN_ANY_VEHICLE(players.user_ped()) then
			SET_ENTITY_CAN_BE_DAMAGED(vehicle, true)
		end
	end
end)

vehicles:toggle_loop("载具自瞄", {"vehicleaimbotall"}, "载具导弹瞄准玩家", function()
	for players.list_except(true) as playerID do
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local pedDistance = v3.distance(players.get_position(players.user()), players.get_position(playerID))
		if not IS_PLAYER_DEAD(ped) and IS_CONTROL_PRESSED(0, 70) and pedDistance < 250.0 and not players.is_in_interior(playerID) and GET_VEHICLE_HOMING_LOCKON_STATE(entities.get_user_vehicle_as_handle()) == 0 then
			SET_VEHICLE_SHOOT_AT_TARGET(players.user_ped(), ped, players.get_position(playerID))
		end
	end
end)

local godmode_detection = false
modder_detections:toggle("检测无敌", {}, "", function(toggled)
	godmode_detection = toggled
end)

local time_since_last_move = 0
util.create_tick_handler(function()
	if godmode_detection then
		local timer = util.current_time_millis() + 10000
		for players.list_except(true) as playerID do
			local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
			local pos = players.get_position(playerID)
			local vehicle = GET_VEHICLE_PED_IS_USING(ped)
			local zoneID = GET_ZONE_AT_COORDS(players.get_position(playerID))
			local isPlayerMoving = #NETWORK_GET_LAST_VEL_RECEIVED_OVER_NETWORK(GET_PLAYER_PED_SCRIPT_INDEX(playerID)) > 1.5
			if (zoneID == 1321 and (IS_ENTITY_IN_WATER(vehicle) or IS_ENTITY_IN_WATER(ped))) or players.is_using_rc_vehicle(playerID) or not isNetPlayerOk(players.user()) then 
				continue 
			end
			if isPlayerGodmode(playerID) and not isDetectionPresent(playerID, "无敌") then
				repeat
					if not isPlayerMoving and time_since_last_move >= 8 or not players.exists(playerID) or not isPlayerGodmode(playerID) or not isFreemodeActive(playerID) or isPlayerInInterior(playerID) or pos.z < 0.0 then
						time_since_last_move = 0
						timer = util.current_time_millis() + 10000
						break
					end
					yield(1000)
					time_since_last_move = not isPlayerMoving ? time_since_last_move + 1 : 0
				until util.current_time_millis() > timer
				if util.current_time_millis() > timer and players.exists(playerID) and isFreemodeActive(playerID) then
					players.add_detection(playerID, "无敌", TOAST_ALL, 100)
					timer = util.current_time_millis() + 10000
					break
				end
			end    
		end
	end
end)

util.create_tick_handler(function()
	if godmode_detection then
		for players.list_except(true) as playerID do
			local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
			local vehicle = GET_VEHICLE_PED_IS_IN(ped)
			if isPlayerGodmode(playerID) and players.is_visible(playerID) then
				draw_debug_text($"{players.get_name(playerID)} 无敌")
			end
		end
	end
end)

modder_detections:toggle_loop("检测载具", {}, "检测载具无敌", function()
	if NETWORK_IS_ACTIVITY_SESSION() then return end
	for players.list_except(true) as playerID do
		if not isPlayerInAnyVehicle(playerID) then continue end
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local pos = players.get_position(playerID)
		local vehicle = GET_VEHICLE_PED_IS_USING(ped)
		local driver = NETWORK_GET_PLAYER_INDEX_FROM_PED(GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
		if not isPlayerInCutscene(playerID) and not isPlayerInInterior(playerID) and entities.is_invulnerable(vehicle) and not NETWORK_IS_PLAYER_FADING(playerID) and IS_ENTITY_VISIBLE(vehicle) and playerID == driver and pos.z > 0.0 then
			draw_debug_text($"{players.get_name(driver)} 载具无敌")
		end
	end 
end)

local lastMoveShit = {}
local playerVisibility = {}
modder_detections:toggle_loop("检测隐形", {}, "", function()
	if not isNetPlayerOk(players.user()) then return end
	local timer = util.current_time_millis() + 10000
	for players.list_except(true) as playerID do
		lastMoveShit[playerID] = 0
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local pos = players.get_position(playerID)
		local blipType = GET_BLIP_INFO_ID_TYPE(GET_BLIP_FROM_ENTITY(ped))
		local vehicle = GET_VEHICLE_PED_IS_IN(ped)
		local isPlayerMoving = #NETWORK_GET_LAST_VEL_RECEIVED_OVER_NETWORK(ped) > 1.5 or #NETWORK_GET_LAST_VEL_RECEIVED_OVER_NETWORK(vehicle) > 1.5
		if not isDetectionPresent(playerID, "隐形") then
			if not players.is_otr(playerID) and blipType == 0 and isNetPlayerOk(playerID, true, true) and not isPlayerInInterior(playerID) and not players.is_visible(playerID) and isPlayerMoving and pos.z > 0.0 then
				repeat
					lastMoveShit[playerID] = lastMoveShit[playerID] == nil ? 0 : lastMoveShit[playerID]
					if not isPlayerMoving and lastMoveShit[playerID] >= 8 or not isNetPlayerOk(playerID, true, true) or players.is_visible(playerID) or not isFreemodeActive(playerID) or isPlayerInInterior(playerID) or isPlayerInCutscene(playerID) or pos.z < 0.0 then
						lastMoveShit[playerID] = 0
						timer = util.current_time_millis() + 10000
						playerVisibility[playerID] = true
						break
					end
					if isDebugMode then
						toast($"检测 {players.get_name(playerID)} 隐形")
					end
					yield(1000)
					lastMoveShit[playerID] = not isPlayerMoving ? lastMoveShit[playerID] + 1 : 0
				until util.current_time_millis() > timer
				if not playerVisibility[playerID] then
					players.add_detection(playerID, "隐形", TOAST_ALL, 100)
					lastMoveShit[playerID] = 0
					timer = util.current_time_millis() + 10000
				end
			end
		end
	end
	yield()
end)

modder_detections:toggle_loop("检测加速", {}, "", function()
if NETWORK_IS_ACTIVITY_SESSION() then return end
for players.list_except(true) as playerID do
	local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
	local vehicle = GET_VEHICLE_PED_IS_USING(ped)
	local vehSpeed = (GET_ENTITY_SPEED(vehicle)* 2.236936)
	local vehClass = GET_VEHICLE_CLASS(vehicle)
	local driver = NETWORK_GET_PLAYER_INDEX_FROM_PED(GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
	local owner = entities.get_owner(vehicle)

	if vehClass != 15 and vehClass != 16 and vehSpeed >= 200 and playerID == driver and not GET_HAS_ROCKET_BOOST(vehicle) then
		if owner != driver then 
			repeat
				vehSpeed = (GET_ENTITY_SPEED(vehicle)* 2.236936)
				yield() -- cooldown incase they are launched by a modder
			until vehSpeed < 50
			return
		end
		if not isDetectionPresent(driver, "加速") then
			players.add_detection(driver, "加速", TOAST_ALL, 75)
			break
		end
	end
end
yield(250)
end)

modder_detections:toggle_loop("检测天基", {}, "检测作弊天基炮", function()
	for players.list_except(true) as playerID do
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		if isPlayerUsingOrbitalCannon(playerID) and getPlayerCurrentInterior(playerID) != 269313 and not isDetectionPresent(playerID, "Modded Orbital Cannon") and isNetPlayerOk(playerID) then
			players.add_detection(playerID, "作弊天基炮", TOAST_ALL, 100)
			break
		end
	end
  yield(250)
end)

modder_detections:toggle_loop("检测生成", {}, "检测驾驶生成载具", function()
	if NETWORK_IS_ACTIVITY_SESSION() then return end
	for players.list_except(true) as playerID do
		if not isPlayerInAnyVehicle(playerID) then continue end
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local vehicle = GET_VEHICLE_PED_IS_USING(ped)
		local plateText = GET_VEHICLE_NUMBER_PLATE_TEXT(vehicle)
		local personalVehicle = DECOR_GET_INT(vehicle, "Player_Vehicle") != 0
		local pegasusveh = DECOR_GET_BOOL(vehicle, "CreatedByPegasus")
		local script = GET_ENTITY_SCRIPT(vehicle, 0)
		if not table.contains(scripts, script) and plateText != "46EEK572" then continue end

		if players.get_vehicle_model(playerID) != 0 and not GET_IS_TASK_ACTIVE(ped, 160) and isNetPlayerOk(players.user()) and players.exists(playerID) then
			local driver = NETWORK_GET_PLAYER_INDEX_FROM_PED(GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
			if players.exists(driver) and not pegasusveh and playerID == driver and not personalVehicle then
				if isDebugMode and script != nil then
					draw_debug_text($"{players.get_name(driver)} 载具[模型: {reverse_joaat(players.get_vehicle_model(playerID))}] 脚本： {script}")
				else
					draw_debug_text($"{players.get_name(driver)} 载具[模型: {reverse_joaat(players.get_vehicle_model(playerID))}]")
				end
			end
		end
	end
end)

modder_detections:toggle_loop("检测锁定", {}, "检测使用防锁定的玩家", function()
	local timer = util.current_time_millis() + 10000 -- compensating for player latency and vehicle chaff
	if NETWORK_IS_ACTIVITY_SESSION() then return end
	for players.list_except(true) as playerID do
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local vehicle = GET_VEHICLE_PED_IS_USING(ped)
		if vehicle == 0 then return end
		local driver = NETWORK_GET_PLAYER_INDEX_FROM_PED(GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
		local bitset = DECOR_GET_INT(vehicle, "MPBitset")
		local vehicleMdl = reverse_joaat(players.get_vehicle_model(playerID))
		local legitBitsets = {2048, 3072, 10240, 11264, 11272, 33792} -- the game sets some vehicles not targetable that are parts of fm activities
		for legitBitsets as bitsets do
			if bitset == bitsets then
				return
			end
		end

		if not IS_PED_IN_ANY_VEHICLE(ped) or (not doesVehicleHaveImaniTech(vehicle) and GET_VEHICLE_MOD(vehicle, 44) == 1) then 
			continue 
		end

		local bAllowHomingMissileLockon = memory.read_byte(entities.handle_to_pointer(vehicle) + 0xAEE)
		if bAllowHomingMissileLockon == 0 and not isDetectionPresent(playerID, "防锁定") and playerID == driver then
			repeat
				if bAllowHomingMissileLockon == 1 then
					timer = util.current_time_millis() + 10000
					return
				end
				yield()
			until util.current_time_millis() > timer
			if bAllowHomingMissileLockon == 0 then
				players.add_detection(playerID, "防锁定", TOAST_ALL, 75)
				timer = util.current_time_millis() + 10000
				break
			end
		else
			timer = util.current_time_millis() + 10000
		end
	end
	yield(250)
end)

modder_detections:toggle_loop("检测2T", {}, "检测使用2Take1生成的载具并且驾驶", function()
	for players.list_except() as playerID do
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local vehicle = GET_VEHICLE_PED_IS_USING(ped)
		local bitset = DECOR_GET_INT(vehicle, "MPBitset")
		local pegasusveh = DECOR_GET_BOOL(vehicle, "CreatedByPegasus")
		if isNetPlayerOk(playerID) and bitset == 1024 and players.get_weapon_damage_modifier(playerID) == 1 and not entities.is_invulnerable(ped) and not pegasusveh and getPlayerJobPoints(playerID) == 0 then
			if not isDetectionPresent(playerID, "2Take1") then
				players.add_detection(playerID, "2Take1", TOAST_ALL, 100)
				menu.trigger_commands($"historynote {players.get_name(playerID)} 2Take1")
				return
			end
		end
	end
  yield(250)
end)

modder_detections:toggle_loop("检测Yim", {}, "检测使用YimMenu默认主机令牌", function()
	for players.list() as playerID do
		local hostToken = tonumber(players.get_host_token(playerID))
		if (hostToken == 41 or (hostToken > 255 and hostToken <= 10000)) and players.get_weapon_damage_modifier(playerID) != 1 then -- -- tbh, idc about detecting them, its just funny to see some people get annoyed. Note to Yim contributers: just randomize token 1-255
			if not isDetectionPresent(playerID, "YimMenu") then
				players.add_detection(playerID, "YimMenu", TOAST_ALL, 100)
				menu.trigger_commands($"historynote {players.get_name(playerID)} YimMenu")
				return
			end
		end
	end
  yield(250)
end)

modder_detections:toggle_loop("检测观看", {}, "检测是否有人正在使用菜单观看你", function()
	for players.list() as playerID do
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local vehicle = GET_VEHICLE_PED_IS_USING(ped)
		local spectateTarget = players.get_spectate_target(playerID)
		local driver = NETWORK_GET_PLAYER_INDEX_FROM_PED(GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
		if isNetPlayerOk(playerID, true, true) and not isPlayerInInterior(playerID) then
			local camDistance = v3.distance(players.get_position(players.user()), players.get_cam_pos(playerID))
			local pedDistance = v3.distance(players.get_position(players.user()), players.get_position(playerID))
			if IS_PED_IN_ANY_VEHICLE(ped) and driver == playerID then -- ignore players driving by quickly
				return
			end
			if camDistance < 15.0 and pedDistance > 50.0 and not isPlayerSpectating(playerID) and spectateTarget == -1 and not isPlayerInCutscene(playerID) or spectateTarget == players.user()  then
				toast($"{players.get_name(playerID)} 作弊看你")
				break
			end
		end
	end
end)

normal_detections:toggle_loop("检测放置", {}, "检测是否有人在你身上放置路径点", function()
	local getEntitySpeed = GET_ENTITY_SPEED(players.user_ped()) * 2.236936
	local multiplyDistance = (getEntitySpeed - 20) / 20 * 0.1
	local entitySpeed = math.max(1.1 + multiplyDistance, 1.1)
	for players.list_except(true) as playerID do
        local x, y = players.get_waypoint(playerID)
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local pos = players.get_position(players.user())
        if x == 0 and y == 0 then continue end
		local distance = (pos.x - x)^2 + (pos.y - y)^2
		local assumedDistance = (GET_ENTITY_SPEED(players.user_ped()) + 1)^entitySpeed
		if distance < assumedDistance then
			toast($"{players.get_name(playerID)} 放置路径点")
		end
	end
end)

normal_detections:toggle_loop("检测观看", {}, "检测是否有人通过电视直播观看你", function()
	for players.list() as playerID do
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		if isPlayerSpectating(playerID) and players.get_spectate_target(playerID) == players.user() then
			toast($"{players.get_name(playerID)} 电视看你")
			break
		end
	end
end)

normal_detections:toggle_loop("检测天基", {}, "检测是否有人正在使用轨道炮", function()
	for players.list_except(true) as playerID do
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local pos = players.get_position(players.user())
		local distance = v3.distance(pos, v3.setZ(players.get_cam_pos(playerID), pos.z))
		if isPlayerUsingOrbitalCannon(playerID) and GET_IS_TASK_ACTIVE(ped, 135) and getPlayerCurrentInterior(playerID) == 269313 then
			draw_debug_text($"{players.get_name(playerID)} 轨道炮")
		end
		if isPlayerUsingOrbitalCannon(playerID) and GET_IS_TASK_ACTIVE(ped, 135) and distance < 25.0 and not isPlayerInInterior(players.user()) and getPlayerCurrentInterior(playerID) == 269313 then
			toast($"{players.get_name(playerID)} 轨道炮瞄准你")
		end
	end
end)

normal_detections:toggle_loop("检测语音", {}, "检测谁在游戏聊天中说话", function()
	for players.list_except() as playerID do
		if NETWORK_IS_PLAYER_TALKING(playerID) then
			draw_debug_text($"{players.get_name(playerID)} 在说话")
		end
	end 
end)

normal_detections:toggle_loop("检测睾酮", {}, "如果玩家使用牛鲨睾酮 则会在小地图上方发出通知", function()
	local data = memory.alloc(56 * 8)
	for queue = 0, 2 do
		for index = 0, GET_NUMBER_OF_EVENTS(queue) - 1 do
			local event = GET_EVENT_AT_INDEX(queue, index)
			if event == 174 then
				if not GET_EVENT_DATA(queue, index, data, 54) then 
					break 
				end
				if memory.read_int(data) == -584633745 then
					local playerID = memory.read_int(data + 1 * 8)
					toast($"{players.get_name(playerID)} 牛鲨睾酮")
				end
			end
		end
	end
end)

local antibeast = protections:list("阻止野兽", {}, "防止为自己和他人进行狩猎野兽活动")
antibeast:toggle("自己", {}, "防止你变成野兽", function(toggled)
	menu.ref_by_path("Online>Protections>Disable Turning Into Beast").value = toggled
end)

antibeast:toggle_loop("他人", {}, "防止其他玩家变成野兽", function()
	if GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(joaat("am_hunt_the_Beast")) > 0 then
		local beast = memory.read_int(memory.script_local("am_hunt_the_Beast", 604 + 1 + 7))
		local gameState = memory.script_local("am_hunt_the_Beast", 604 + 1)
		local amLauncherHost = NETWORK_GET_HOST_OF_SCRIPT("am_launcher", -1, 0)
		local huntTheBeastHost = NETWORK_GET_HOST_OF_SCRIPT("am_hunt_the_Beast", -1, 0)
		local timer = util.current_time_millis() + 5000
		if beast != players.user() and beast != -1 and memory.read_int(gameState) != 3 then
			toast($"阻止野兽目标 {players.get_name(beast)} 可能发起于 {players.get_name(amLauncherHost)}")
			if huntTheBeastHost != players.user() then
				memory.write_int(gameState, 3)
			end
		end
	end
end)

protections:toggle_loop("阻止古奇", {}, "阻止古奇事件", function()
	if GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(joaat("fm_content_xmas_mugger")) > 0 then
		local amLauncherHost = NETWORK_GET_HOST_OF_SCRIPT("am_launcher", -1, 0)
		TERMINATE_ALL_SCRIPTS_WITH_THIS_NAME("fm_content_xmas_mugger")
		toast($"阻止自由模式脚本 (fm_content_xmas_mugger). :D")
	end
end)

local anticage = protections:list("阻止笼子", {}, "阻挡99%的笼子而不破坏游戏")
local cleanupType = 2
cleanupTypeSlider = anticage:slider("删除", {"cleanuptype"}, "", 1, 3, 2, 1, function(index)
	cleanupType = index
end)
menu.add_value_replacement(cleanupTypeSlider, 1, "本地删除")
menu.add_value_replacement(cleanupTypeSlider, 2, "强制删除")
menu.add_value_replacement(cleanupTypeSlider, 3, "使透明化")

local blockingRadius = 5.00
anticage:slider_float("半径值", {"blockingradius"}, "检测笼子半径", 100, 2500, 500, 100, function(value)
	blockingRadius = value/100
end)

anticage:toggle_loop("启用", {"anticage"}, "", function()
	if not isNetPlayerOk(players.user()) then return end
	local my_ents = {players.user_ped(), entities.get_user_vehicle_as_handle()}
	local interior = memory.read_int(memory.script_global(GlobalplayerBD + 1 + (players.user() * 465) + 246))
	if interior == 275201 or interior == 274689 or interior == 281089 then
		return
	end
	for entities.get_all_objects_as_pointers() as objPtr do
		local obj = entities.pointer_to_handle(objPtr)
		local script = GET_ENTITY_SCRIPT(obj, 0)
		local owner = entities.get_owner(obj)
		if owner == -1 or owner == players.user() then
			RELEASE_SCRIPT_GUID_FROM_ENTITY(obj)
			continue
		end
		SET_GAMEPLAY_CAM_IGNORE_ENTITY_COLLISION_THIS_UPDATE(obj)
		for doors as door do
			if GET_ENTITY_MODEL(obj) == joaat(door) then
				continue
			end
		end
		if owner != -1 and owner != players.user() and GET_ENTITY_MODEL(obj) != 0 and (manhattanDistance(players.get_position(players.user()), GET_ENTITY_COORDS(obj)) / 1.1) < blockingRadius then
			SET_ENTITY_NO_COLLISION_ENTITY(obj, players.user_ped(), false) 
			SET_ENTITY_NO_COLLISION_ENTITY(obj, entities.get_user_vehicle_as_handle(), false) 
			SET_ENTITY_ALPHA(obj, 0, false)
			switch cleanupType do
				case 1:
					SET_ENTITY_ALPHA(obj, 0, false)
					deleteEntityLocally(obj)
					toast($"[反笼] 删除中 \n模型: {reverse_joaat(GET_ENTITY_MODEL(obj))}", TOAST_ALL)
					break
				case 2:
					SET_ENTITY_ALPHA(obj, 0, false)
					entities.delete(obj)
					toast($"[反笼] 删除中 \n模型: {reverse_joaat(GET_ENTITY_MODEL(obj))}", TOAST_ALL)
					break
				case 3:
					SET_ENTITY_ALPHA(obj, 50, false)
					toast($"[反笼] 删除中 \n模型: {reverse_joaat(GET_ENTITY_MODEL(obj))}", TOAST_ALL)
					break
			end
			if IS_ENTITY_TOUCHING_ENTITY(players.user_ped(), obj) then
				toast($"[反笼] 阻止笼子 {players.get_name(owner)}")
			end
		end
		RELEASE_SCRIPT_GUID_FROM_ENTITY(obj)
	end
end)

local anti_mugger = protections:list("阻止劫匪", {}, "为自己和他人预防抢劫")
anti_mugger:toggle_loop("自己", {}, "防止自己被抢", function()
	if NETWORK_IS_SCRIPT_ACTIVE("am_gang_call", 0, true, 0) then
		local pedNetId = memory.read_int(memory.script_local("am_gang_call", 62 + 10 + 1))
		local sender = memory.read_int(memory.script_local("am_gang_call", 286))
		local target = memory.read_int(memory.script_local("am_gang_call", 287))

		util.spoof_script("am_gang_call", function()
			if sender != players.user() and target == players.user() 
			and NETWORK_DOES_NETWORK_ID_EXIST(pedNetId) 
			and NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(pedNetId) then
				local mugger = NET_TO_PED(pedNetId)
				entities.delete(mugger)
				toast($"阻止抢劫 {players.get_name(sender)}")
			end
		end)
	end
end)

anti_mugger:toggle_loop("其他人", {}, "防止他人被抢", function()
	if NETWORK_IS_SCRIPT_ACTIVE("am_gang_call", 0, true, 0) then
		local pedNetId = memory.script_local("am_gang_call", 63 + 10 + 1)
		local sender = memory.script_local("am_gang_call", 286)
		local target = memory.script_local("am_gang_call", 287)
		
		util.spoof_script("am_gang_call", function()
			if memory.read_int(target) != players.user() and memory.read_int(sender) != players.user()
			and NETWORK_DOES_NETWORK_ID_EXIST(memory.read_int(pedNetId)) 
			and NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(memory.read_int(pedNetId)) then
				local mugger = NET_TO_PED(memory.read_int(pedNetId))
				entities.delete(mugger)
				toast($"阻止抢劫 {players.get_name(memory.read_int(sender))} 到 {players.get_name(memory.read_int(target))}")
			end
		end)
	end
end)

protections:toggle_loop("阻止劫持", {}, "阻止试图劫持你载具", function()
	local vehicle = entities.get_user_vehicle_as_handle()
	if not IS_PED_IN_VEHICLE(players.user_ped(), vehicle, false) then return end
	for entities.get_all_peds_as_handles() as ped do
		local targetVehicle = GET_VEHICLE_PED_IS_TRYING_TO_ENTER(ped)
		local targetSeat = GET_SEAT_PED_IS_TRYING_TO_ENTER(ped)
		local owner = entities.get_owner(ped)
		if targetVehicle == vehicle and targetSeat == (seat := getSeatPedIsIn(players.user_ped())) and not IS_PED_A_PLAYER(ped) and owner != players.user() then
			entities.delete(ped)
			repeat
				SET_PED_INTO_VEHICLE(players.user_ped(), vehicle, seat)
				yield()
			until getSeatPedIsIn(players.user_ped()) == seat
			toast($"阻止劫持 {players.get_name(owner)}")
			if not isDetectionPresent(owner, "载具劫持") then
				players.add_detection(owner, "载具劫持", TOAST_ALL, 75)
				break
			end
		end
	end
end)

protections:toggle_loop("阻止电击", {}, "阻止电击​​伤害", function()
	SET_PED_CONFIG_FLAG(players.user_ped(), 461, true)
end, function()
	SET_PED_CONFIG_FLAG(players.user_ped(), 461, false)
end)

protections:toggle_loop("阻止行人", {"blockmoddedpeds"}, "阻止不正常生成的行人 这将保护你免受许多问题的影响 例如崩溃和恶意攻击功能", function()
	if not isNetPlayerOk(players.user()) or isPlayerInInterior(players.user()) then return end
	for entities.get_all_peds_as_handles() as ped do
		local script = GET_ENTITY_SCRIPT(ped, 0)
		local owner = entities.get_owner(ped)
		if table.contains(scripts, script) and owner != players.user() and owner != -1 and ped != randomPed and ped != glitchPed then
			deleteEntityLocally(ped)
			if isDebugMode then
				if GET_ENTITY_MODEL(ped) != 0 then
					toast($"[调试信息] 已删除\n创建: {script}\n模型: {reverse_joaat(GET_ENTITY_MODEL(ped))}\n所有者: {players.get_name(owner)}")
				end
			end
		end
	end
end)

protections:toggle_loop("阻止载具", {"blockmoddedvehicles"}, "阻止不正常生成的载具 这将保护你免受诸如恶搞功能之类的很多东西的侵害", function()
	if not isNetPlayerOk(players.user()) then return end
	for entities.get_all_vehicles_as_handles() as vehicle do
		local script = GET_ENTITY_SCRIPT(vehicle, 0)
		local owner = entities.get_owner(vehicle)
		local bitset = DECOR_GET_INT(vehicle, "MPBitset")
		local driver = GET_PED_IN_VEHICLE_SEAT(vehicle, -1)
		local driverPlayerID = NETWORK_GET_PLAYER_INDEX_FROM_PED(driver)
		if IS_REMOTE_PLAYER_IN_NON_CLONED_VEHICLE(driverPlayerID) then 
			continue
		end
		if table.contains(scripts, script) and (driver == 0 or not IS_PED_A_PLAYER(driver)) and owner != players.user() and owner != -1 then
			deleteEntityLocally(vehicle)
			if isDebugMode then
				if GET_ENTITY_MODEL(vehicle) != 0 then
					toast($"[调试信息] 已删除\n创建: {script}\n模型: {reverse_joaat(GET_ENTITY_MODEL(vehicle))}\n所有者: {players.get_name(owner)}")
				end
			end
		end
		yield()
	end
end)

local epicBall = funfeatures:list("球化")

local settings = {
    ballSpeed = 0.5,
    ballSprintMult = 2.5,
    inAirBallSprintMult = 5.0,
    minDistance = 10.0,
    bounceStrength = 3.0,
    dropVelocity = 1.5,
    snappingForce = 0.5,
    ballFov = 70,
    ballHash = joaat("stt_prop_stunt_soccer_sball"),
    ballVisibility = 0,
    pedVisibility = 0
}

local setFov = menu.ref_by_path("Game>Camera>Field of View>Third-Person, On Foot"),
local cachedFov = menu.get_value(setFov)

local ballToggle
ballToggle = epicBall:toggle_loop("变形", {"ball"}, "注意 这将导致传送无法工作 请切换悬浮以使用传送", function(toggled)
	local ballMdl = settings.ballHash
	util.request_model(ballMdl)

	if IS_PED_IN_ANY_VEHICLE(players.user_ped()) then
		if ballObj != nil then
			entities.delete(ballObj)
		end
		ballToggle.value = false
		util.stop_thread()
	end
	
	if ballObj == nil or not DOES_ENTITY_EXIST(ballObj) and not levitation.value then
		ballObj = entities.create_object(ballMdl, players.get_position(players.user()))
		pedRot = GET_ENTITY_ROTATION(players.user_ped(), 2)
		ATTACH_ENTITY_TO_ENTITY(players.user_ped(), ballObj, 0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true, false)
	end

	if settings.ballVisibility == 1 and settings.pedVisibility == 0 and not players.is_visible(players.user()) then -- to prevent player ped from going invisible when toggling ball visibility to invisible
		SET_ENTITY_VISIBLE(players.user_ped(), true)
	end

	if not isNetPlayerOk(players.user(), true, true) or GET_ENTITY_MODEL(ballObj) != settings.ballHash or not IS_ENTITY_ATTACHED_TO_ENTITY(players.user_ped(), ballObj) or (levitation.value and ballObj != nil) then
		entities.delete(ballObj)
		return
	end

	CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
	SET_GAMEPLAY_CAM_IGNORE_ENTITY_COLLISION_THIS_UPDATE(ballObj)
	SET_ENTITY_VISIBLE(ballObj, settings.ballVisibility == 0 ? true : false)
	setFov:trigger(settings.ballFov)
	invisibility:setState(settings.pedVisibility == 1 ? (not levitation.value ? "Enabled" : (levitation.value and stealthLevitation ? "Locally Visible" : "Disabled")) : "Disabled")

    local inputDirection = -GET_CONTROL_NORMAL(2, 31)
    local inputSide = GET_CONTROL_NORMAL(2, 30)
    
    local camRot = GET_GAMEPLAY_CAM_ROT(2)
    local camHeadingDirection = -camRot.z / 180 * math.pi
    local camHeadingSide = camHeadingDirection + math.pi / 2

    local moveDirection = v3(math.sin(camHeadingDirection), math.cos(camHeadingDirection), 0) -- thanks to aaron for doing all this god awful math for me <3
    local moveSide = v3(math.sin(camHeadingSide), math.cos(camHeadingSide), 0)
	local moveAltitude = IS_CONTROL_PRESSED(0, 102) ? settings.bounceStrength : (IS_CONTROL_PRESSED(0, 36) ? -settings.dropVelocity : 0.0)
	local height = GET_ENTITY_HEIGHT_ABOVE_GROUND(ballObj)
	local force = height < settings.minDistance and IS_CONTROL_PRESSED(0, 21) ? (settings.ballSpeed * settings.ballSprintMult) : height > settings.minDistance and IS_CONTROL_PRESSED(0, 21) ? (settings.ballSpeed * settings.inAirBallSprintMult) : inputDirection

	moveDirection:mul(force)
	moveSide:mul(inputSide)
	moveDirection:add(moveSide)
	moveDirection:mul(settings.ballSpeed)
	
	if height > 3.0 then
		moveDirection.z = -settings.snappingForce
		APPLY_FORCE_TO_ENTITY(ballObj, 3, moveDirection, 0, 0, 0, 0, false, false, true, false, true)
	end

	moveDirection.z = moveAltitude
	APPLY_FORCE_TO_ENTITY(ballObj, 3, moveDirection, 0, 0, 0, 0, false, false, true, false, true)
end, function()
if ballObj != nil then
	entities.delete(ballObj)
end
if pedRot != nil then
	SET_ENTITY_ROTATION(players.user_ped(), pedRot, 2)
end
CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
SET_ENTITY_VISIBLE(players.user_ped(), true)
setFov:trigger(cachedFov)
invisibility:setState("Disabled")
end)

epicBall:list_select("模型", {"ballmodel"}, "", deezBalls, deezBalls[1][1], function(mdlHash)
	settings.ballHash = mdlHash
end)

epicBall:divider("地面运动")
epicBall:slider_float("速度值", {"movementspeed"}, "", 10, 1000, 50, 10, function(value)
	settings.ballSpeed = value/100
end)

epicBall:slider_float("冲刺值", {"sprintmultiplier"}, "", 100, 10000, 250, 10, function(value)
	settings.ballSprintMult = value/100
end)

epicBall:divider("空中运动")
epicBall:slider_float("跳跃值", {"mindistance"}, "将激活冲刺倍增器的距地面的最小距离。", 100, 10000, 1000, 10, function(value)
	settings.minDistance = value/100
end)

epicBall:slider_float("冲刺值", {"airsprintmultiplier"}, "键盘上的左Shift或手柄上的A", 100, 10000, 500, 10, function(value)
	settings.inAirBallSprintMult = value/100
end)

epicBall:divider("助力")
epicBall:slider_float("弹起值", {"upwardforce"}, "控制球弹跳的高度\n键盘上的空格键或手柄上的RB", 100, 1000, 300, 10, function(value)
	settings.bounceStrength = value/100
end)

epicBall:slider_float("落下值", {"downwardforce"}, "控制球下落的速度\n键盘上的左控制键和手柄上的左摇杆", 100, 1000, 150, 10, function(value)
	settings.dropVelocity = value/100
end)


epicBall:slider_float("控制值", {"snappingforce"}, "", 0, 250, 50, 10, function(value)
	settings.snappingForce = value/100
end)


epicBall:divider("透明度")
epicBall:slider("视野值", {"ballfov"}, "", 50, 130, 70, 1, function(value)
	settings.ballFov = value
end)

epicBall:toggle_loop("禁抖动", {}, "", function()
	STOP_GAMEPLAY_CAM_SHAKING(true)
end)

ballVisibilitySlider = epicBall:slider("透明度", {"ballinvisibility"}, "球透明度", 0, 1, 0, 1, function(value) -- I dont like list selects for stuff like this, cry about it.
	settings.ballVisibility = value
end)
menu.add_value_replacement(ballVisibilitySlider, 0, "可见")
menu.add_value_replacement(ballVisibilitySlider, 1, "隐形")

pedVisibilitySlider = epicBall:slider("透明度", {"pedinvisibility"}, "人物透明度 这将使你在其他人的雷达上隐形", 0, 1, 0, 1, function(value) -- cry about it more
	settings.pedVisibility = value
end)
menu.add_value_replacement(pedVisibilitySlider, 0, "可见")
menu.add_value_replacement(pedVisibilitySlider, 1, "隐形")


local ninjaJump = funfeatures:list("翻腾")
local flipsPerSecond = 1.0
flipsPerSecondSlider = ninjaJump:slider_float("速度", {"flipspeed"}, "", 0, 10000, 100, 10, function(value)
	flipsPerSecond = value/100
end)

local direction = 1
ninjaJumpSlider = ninjaJump:slider("方向", {"flipdirection"}, "", 1, 2, 1, 2, function(value) -- boo hoo
	direction = value
end)
menu.add_value_replacement(ninjaJumpSlider, 1, "前空翻")
menu.add_value_replacement(ninjaJumpSlider, 2, "后空翻")

local flips = 2
numberOfFlipsSlider = ninjaJump:slider("次数", {"flipamount"}, "", 0, 1000, 2, 1, function(value)
	flips = value
end)
menu.add_value_replacement(numberOfFlipsSlider, 0, "无限")

local clearTasks = false
ninjaJump:toggle("清除", {}, "如果从高处跳下 完成翻转后 可以自由落体或跳伞", function(toggled)
	clearTasks = toggled
end)

local airControl = false
ninjaJump:toggle("转体", {"ninjacontrol"}, "在跳跃时转体", function(toggled)
	airControl = toggled
end)


ninjaJumpTgl = ninjaJump:toggle_loop("启用", {"ninjajump"}, "本地显示", function()
	if not superJump.value then
		superJump.value = true
	end
	if IS_PED_JUMPING(players.user_ped()) and GET_ENTITY_HEIGHT_ABOVE_GROUND(players.user_ped()) > 2.0 then
		local cachedGracefulLanding = gracefulLanding.value
		local heading = GET_ENTITY_HEADING(players.user_ped())
		local pitch = 0
		local numOfFlips = (flips == 0) ? math.huge : flips
		local countedFlips = 0
		repeat
			if airControl then
				heading = GET_ENTITY_HEADING(players.user_ped())
			end
			pitch += 360 * TIMESTEP() * flipsPerSecond
			while pitch > 360 do
				pitch -= 360
				countedFlips += 1
			end
			SET_ENTITY_ROTATION(players.user_ped(), pitch * (direction == 1 ? -1 : 1), 0.0, heading, 2, true)
			yield()
		until not IS_PED_JUMPING(players.user_ped()) or countedFlips >= numOfFlips or levitation.value or not ninjaJumpTgl.value
		if levitation.value then
			CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
		end
		if clearTasks then
			if not cachedGracefulLanding then
				gracefulLanding.value = true
			end
			GIVE_DELAYED_WEAPON_TO_PED(players.user_ped(), joaat("gadget_parachute"), 1, false)
			CLEAR_PED_TASKS(players.user_ped())
			yield()
			yield()
			while GET_IS_TASK_ACTIVE(players.user_ped(), 6) or IS_ENTITY_IN_AIR(players.user_ped()) do
				yield()
			end
			gracefulLanding.value = cachedGracefulLanding
		else
			repeat
				yield()
			until not IS_PED_JUMPING(players.user_ped())
		end
	end
end, function()
	SET_ENTITY_ROTATION(players.user_ped(), 0.0, 0.0, GET_ENTITY_HEADING(players.user_ped()), 2, true)
	superJump.value = false
end)


local movementType = funfeatures:list("姿势")
movementType:toggle_loop("爬行", {"crawl"}, "注意 进入第一人称视角会让你移动得更快 这相当有趣", function(toggled)
	requestAnimDict("missfbi3_sniping")
	local dict = "move_crawl"
	local forwards = "onfront_fwd"
	local backwards = "onfront_bwd"
	requestAnimDict(dict)
	if IS_CONTROL_PRESSED(0, 32) and not IS_ENTITY_PLAYING_ANIM(players.user_ped(), dict, forwards, 3) then
		TASK_PLAY_ANIM(players.user_ped(), dict, forwards, 2.5, 2.5, -1, 1|32, 1.0, false, false, false)
	elseif IS_CONTROL_PRESSED(0, 33) and not IS_ENTITY_PLAYING_ANIM(players.user_ped(), dict, backwards, 3) then
		TASK_PLAY_ANIM(players.user_ped(), dict, backwards, 2.5, 2.5, -1, 1|32, 1.0, false, false, false)
	elseif IS_PED_ARMED(players.user_ped(), 6) and not IS_ENTITY_PLAYING_ANIM(players.user_ped(), "missfbi3_sniping", "prone_michael", 3) and not IS_CONTROL_PRESSED(0, 32) and not IS_CONTROL_PRESSED(0, 33) then
		TASK_PLAY_ANIM(players.user_ped(), "missfbi3_sniping", "prone_michael", 2.5, 2.5, -1, 1|32, 1.0, false, false, false)
	end
end, function()
	CLEAR_PED_TASKS(players.user_ped())
end)

movementType:toggle_loop("忍者", {"naruto"}, "", function()
	local dict = "swimming@scuba"
	local name = "dive_glide"
	requestAnimDict(dict)
	if IS_PED_SPRINTING(players.user_ped()) and not IS_ENTITY_PLAYING_ANIM(players.user_ped(), dict, name, 3) and not GET_IS_TASK_ACTIVE(players.user_ped(), 56) and not GET_IS_TASK_ACTIVE(players.user_ped(), 290) then
		TASK_PLAY_ANIM(players.user_ped(), dict, name, 5.0, 2.5, -1, 1|16|32, 1.0, false, false, false)
	elseif IS_ENTITY_PLAYING_ANIM(players.user_ped(), dict, name, 3) and (IS_PED_WALKING(players.user_ped()) or IS_PED_STILL(players.user_ped()) or IS_PED_FALLING(players.user_ped())
	or IS_PED_SWITCHING_WEAPON(players.user_ped()) or IS_PLAYER_FREE_AIMING(players.user()) or IS_PED_RELOADING(players.user_ped()) or IS_PED_JUMPING(players.user_ped())) then
		STOP_ANIM_TASK(players.user_ped(), dict, name, -3.0)
	end
end, function()
	CLEAR_PED_TASKS(players.user_ped())
end)

local animClipsets = {
    {"大脚", "move_characters@orleans@core@"},
    {"外星人", "move_m@alien"},
    {"犀牛重甲", "ANIM_GROUP_MOVE_BALLISTIC"},
}

for animClipsets as data do
    local animName = data[1]
    local clipset = data[2]
    movementType:toggle(animName, {}, "", function(toggled)
        if toggled then
            requestClipset(clipset)
            SET_PED_MOVEMENT_CLIPSET(players.user_ped(), clipset, 0.5)
        else
            REMOVE_CLIP_SET(clipset)
            RESET_PED_MOVEMENT_CLIPSET(players.user_ped(), 0.5)
        end
    end)
end

local superHit = funfeatures:list("喷火")
local strength = 1000.0
superHit:slider_float("强度", {"hitstrength"}, "", 1000, 10000000, 100000, 1000, function(value)
	strength = value/100
end)

superHit:toggle_loop("启用", {}, "", function(toggled)
    SET_PLAYER_MELEE_WEAPON_DAMAGE_MODIFIER(players.user(), strength, true)
end, function()
	SET_PLAYER_MELEE_WEAPON_DAMAGE_MODIFIER(players.user(), 1.0, true)
end)

local fireBreath = funfeatures:list("火息")
local faceOffset = 0.15
fireBreath:slider_float("远近", {"offsetface"}, "", 0, 50, 15, 1, function(value)
	faceOffset = value/100
end)

local fireScale = 0.5
fireBreath:slider_float("长度", {"offsetfire"}, "", 0, 100, 50, 1, function(value)
	fireScale = value/100
end)

fireBreath:toggle_loop("启用", {}, "键盘按E 手柄RB", function() 
	local ped = GET_PLAYER_PED_SCRIPT_INDEX(players.user())
	REQUEST_NAMED_PTFX_ASSET("veh_xs_vehicle_mods")
	USE_PARTICLE_FX_ASSET("veh_xs_vehicle_mods")
	if IS_PED_IN_ANY_VEHICLE(players.user_ped()) then return end
	if IS_CONTROL_PRESSED(0, 206) then
		if ptfx == nil or not DOES_PARTICLE_FX_LOOPED_EXIST(ptfx) then
			ptfx = START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("veh_nitrous", ped, -0.01, faceOffset, 0.0, 0.0, 0.0, 180.0, GET_PED_BONE_INDEX(ped, 31086), fireScale, false, false, false, 0, 0, 0, 255)
		end
	else
		if ptfx != nil then
			REMOVE_PARTICLE_FX(ptfx)
		end
	end
end, function()
	if ptfx != nil then
		REMOVE_PARTICLE_FX(ptfx)
		REMOVE_NAMED_PTFX_ASSET("veh_xs_vehicle_mods")
	end
end)

funfeatures:action("水怪", {}, "", function()
	local oppressor = joaat("oppressor2")
	local monster = joaat("h4_prop_h4_loch_monster")
	local pos = players.get_position(players.user())
	util.request_model(monster)
	util.request_model(oppressor)
	obj = entities.create_object(monster, pos)
	veh = entities.create_vehicle(oppressor, pos, 0)
	entities.set_can_migrate(obj, false)
	SET_ENTITY_COLLISION(obj, false, false)
	SET_PED_INTO_VEHICLE(players.user_ped(), veh, -1)
	ATTACH_ENTITY_TO_ENTITY(obj, veh, 0, -0.25, -1.0, 1.0, 0.0, 0.0, -90.0, true, false, false, false, 0, true, false)
end)


funfeatures:action("扫帚", {}, "本地可见", function()
	local revealInvisiblePlayers = menu.ref_by_path("Online>Reveal Invisible Players")
	local oppressor = joaat("oppressor2")
	local broomstick = joaat("prop_tool_broom")
	if revealInvisiblePlayers.value then
		toast("请禁用显示不可见玩家")
		return 
	end
	local pos = players.get_position(players.user())
	util.request_model(broomstick)
	util.request_model(oppressor)
	obj = entities.create_object(broomstick, pos)
	veh = entities.create_vehicle(oppressor, pos, 0)
	SET_ENTITY_VISIBLE(veh, false)
	SET_PED_INTO_VEHICLE(players.user_ped(), veh, -1)
	ATTACH_ENTITY_TO_ENTITY(obj, veh, 0, 0.0, 0.0, 0.3, -80.0, 0.0, 0.0, false, false, false, false, 0, true, false) -- thanks to chaos mod for doing the annoying rotation work for me :P
end)

local headlamp = funfeatures:list("头灯", {}, "本地可见")
local headlampDistance = 25.0
headlamp:slider_float("光距", {"distance"}, "", 100, 100000, 1500, 100, function(value)
	headlampDistance = value / 100
end)

local brightness = 10.0
headlamp:slider_float("亮度", {"brightness"}, "", 100, 10000, 1000, 100, function(value)
	brightness = value / 100
end)

local light_radius = 15.0
headlamp:slider_float("范围", {"radius"}, "", 100, 5000, 2000, 100, function(value)
	light_radius = value / 100
end)

local headlampColor = {r = 1, g = 235/255, b = 190/255, a = 0}
headlamp:colour("颜色", {"headlampcolor"}, "", headlampColor, true, function(value)
	headlampColor = value 
end)

headlamp:toggle_loop("打开", {"headlamp"}, "", function()
	local head_pos = GET_PED_BONE_COORDS(players.user_ped(), 31086, 0.0, 1.0, 0.0)
	local camRot = players.get_cam_rot(players.user())
	if not IS_PED_IN_ANY_VEHICLE(players.user_ped()) then
		DRAW_SHADOWED_SPOT_LIGHT(head_pos, camRot:toDir(), math.floor(headlampColor.r * 255), math.floor(headlampColor.g * 255), math.floor(headlampColor.b * 255), headlampDistance * 1.5, brightness, 0.0, light_radius, headlampDistance, 0)
	end
end)

funfeatures:toggle("停电", {"poweroutage"}, "", function(toggled)
	SET_ARTIFICIAL_LIGHTS_STATE(toggled)
end)

funfeatures:toggle("断电", {"enableblackout"}, "", function(toggled)
	menu.trigger_commands(toggled ? "time 0" : "syncclock")
	SET_ARTIFICIAL_LIGHTS_STATE(toggled)
	SET_TIMECYCLE_MODIFIER(toggled ? "dlc_island_vault" : "DEFAULT")
end)

local fingerGun = funfeatures:list("指枪", {}, "按B射击 无伤害")
for id, data in weapon_stuff do
	local name = data[1]
	local weaponName = data[2]
	fingerGun:toggle_loop(name, {}, "", function( )
		if memory.read_int(memory.script_global(4521801 + 932)) == 3 then
			memory.write_int(memory.script_global(4521801 + 937), GET_NETWORK_TIME())
			local finalCoords = GET_FINAL_RENDERED_CAM_ROT(2):toDir():mul(1000):add(players.get_cam_pos(players.user()))
			local fingerPos = GET_PED_BONE_COORDS(players.user_ped(), 4089, 0.4, 0.0, -0.15)
			SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(fingerPos, finalCoords, 1, true, joaat(weaponName), 0, true, false, 500.0, players.user_ped(), 0)
			yield(100)
		end
	end, function()
		local pos = players.get_position(players.user())
		CLEAR_AREA_OF_PROJECTILES(pos, 999999.0, 0)
	end)
end

local petJinx = funfeatures:list("宠物")
petJinx:toggle("宠物", {}, "Jinx", function(toggled)
	if toggled then
		local jinx = joaat("a_c_cat_01")
		util.request_model(jinx)
		local pos = players.get_position(players.user())
		jinxPed = entities.create_ped(28, jinx, pos, 0)
		entities.set_can_migrate(jinxPed, false)
		SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(jinxPed, true)
		SET_PED_COMPONENT_VARIATION(jinxPed, 0, 0, 1, 0)
		SET_ENTITY_INVINCIBLE(jinxPed, true)
		TASK_FOLLOW_TO_OFFSET_OF_ENTITY(jinxPed, players.user_ped(), 0, -0.3, 0, 10.0, -1, 100.0, true)
	else
		entities.delete(jinxPed)
	end
end)

petJinx:action("寻找", {}, "Jinx", function()
	local pos = players.get_position(players.user())
	if jinxPed != nil then 
		SET_ENTITY_COORDS_NO_OFFSET(jinxPed, pos, false, false, false)
	else
		toast("Jinx没有找到 :(")
	end
end)


misc:toggle("调试", {"debugmode"}, "启用有关功能为何未按预期工作或调试通知的额外信息", function(toggled)
	isDebugMode = toggled
end)
menu.apply_command_states()

local function player(playerID) 
	local name = players.get_name(playerID)
	if playerID != players.user() and (name == "Prizuhm" or name == "Iinustechtips" or name == "nullsub") then
		players.add_detection(playerID, "JinxScript Developer", TOAST_ALL, 1)
	end

	if not menu.player_root(playerID):isValid() then return end
	local main = menu.list(menu.player_root(playerID), "JinxScript", {"JinxScript"}, "")

	friendly = main:list("友好", {}, "")
	griefing = main:list("恶搞", {}, "")
	antigodmode = main:list("无敌", {}, "")
	tpPlayer = main:list("传送")
	miscPlayer = main:list("其他")
	trollingRoot = menu.ref_by_rel_path(menu.player_root(playerID), "Trolling")
	trollingRoot:getChildren()[1]:attachBefore(trollingRoot:link(main):detach())

	friendly:toggle_loop("宠物小猫", {}, "Jinx", function()
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		if not petJinxPlyr or not DOES_ENTITY_EXIST(petJinxPlyr) then
			local jinx = joaat("a_c_cat_01")
			util.request_model(jinx)
			local pos = players.get_position(playerID)
			petJinxPlyr = entities.create_ped(28, jinx, pos, 0)
			entities.set_can_migrate(petJinxPlyr, false)
      SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(petJinxPlyr, true)
			SET_PED_COMPONENT_VARIATION(petJinxPlyr, 0, 0, 1, 0)
			SET_ENTITY_INVINCIBLE(petJinxPlyr, true)
      TASK_FOLLOW_TO_OFFSET_OF_ENTITY(petJinxPlyr, ped, 0, -0.3, 0, 7.0, -1, 1.5, true)
		end
	end, function()
		entities.delete(petJinxPlyr)
	end)
  
	friendly:toggle_loop("载具火箭", {}, "按喇叭发射火箭", function()
		local wpn = joaat("vehicle_weapon_tank")
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local vehicle = GET_VEHICLE_PED_IS_USING(ped)

		local leftStart = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, -1.25, 0.5, 0.35)
		local leftEnd = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, -1.25, 100.0, 0.35)
		local rightStart = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, 1.25, 0.5, 0.35)
		local rightEnd = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, 1.25, 100.0, 0.35)
		if not GET_IS_TASK_ACTIVE(ped, 199) and IS_PLAYER_PRESSING_HORN(playerID) then
			SHOOT_SINGLE_BULLET_BETWEEN_COORDS(leftStart, leftEnd, 0, true, wpn, 0, true, false, 5.0)
			SHOOT_SINGLE_BULLET_BETWEEN_COORDS(rightStart, rightEnd, 0, true, wpn, 0, true, false, 5.0)
			repeat
				yield()
			until not IS_PLAYER_PRESSING_HORN(playerID)
		end
	end)

	friendly:action("载具漂移", {"drifttires"}, "", function()
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local vehicle = GET_VEHICLE_PED_IS_USING(ped)
		entities.request_control(vehicle, 2500)
		SET_DRIFT_TYRES(vehicle, true)
	end)

	friendly:toggle_loop("载具填充", {}, "", function()
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local vehicle = GET_VEHICLE_PED_IS_USING(ped)
		if IS_ROCKET_BOOST_ACTIVE(vehicle) then
			repeat
				yield()
			until not IS_ROCKET_BOOST_ACTIVE(vehicle)
			NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle)
			SET_ROCKET_BOOST_FILL(vehicle, 100.0)
		end
	end)

	local boostVehFriendly
	boostVehFriendly = friendly:toggle_loop("载具加速", {"hornboost"}, "", function() -- the only functional method that works everytime, applying force doesnt sync well since it requires entity control
		local speedUpMdl = joaat("stt_prop_track_speedup")
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local vehicle = GET_VEHICLE_PED_IS_USING(ped)

		if not IS_PED_IN_ANY_VEHICLE(ped) then
			toast(lang.get_localised(PLYNVEH):gsub("{}", players.get_name(playerID)))
			boostVehFriendly.value = false
			util.stop_thread()
		end

		util.request_model(speedUpMdl)
		if IS_PLAYER_PRESSING_HORN(playerID) then
			local boostpad = entities.create_object(speedUpMdl, GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, 0.0, GET_ENTITY_SPEED(vehicle)/2, -3.0), false, false, false)
			SET_ENTITY_VISIBLE(boostpad, false)
			SET_OBJECT_SPEED_BOOST_AMOUNT(boostpad, 100)
			entities.set_can_migrate(boostpad, false)
			yield(500)
			entities.delete(boostpad)
		end
	end)

	local rp_loop_ply = friendly:list("经验循环")
	local levelPly = 120
	rp_loop_ply:slider("目标等级", {"maxlevel"}, "", 1, 8000, 120, 1, function(val)
		levelPly = val
	end)

	local delayPly = 0
	rp_loop_ply:slider("循环延迟", {"loopdelay"}, "", 0, 2500, 0, 10, function(val)
		delayPly = val
	end)

	local rpLoopPlyr
	rpLoopPlyr = rp_loop_ply:toggle_loop("启用", {"rploop"}, $"启用经验循环 {players.get_name(playerID)}", function()
		if not menu.player_root(playerID):isValid() then return end
		local giveRP = menu.ref_by_rel_path(menu.player_root(playerID), "Friendly>Give RP")
		if players.get_rank(playerID) >= levelPly then 
			toast($"{players.get_name(playerID)} 已达到或高于目标等级 {levelPly}. :)")
			rpLoopPlyr.value = false
			return 
		end
		repeat
			for i = 21, 24 do
				if players.get_rank(playerID) >= levelPly then break end
				util.trigger_script_event(1 << playerID, {968269233, players.user(), 4, i, 1, 1, 1})
				util.trigger_script_event(1 << playerID, {968269233, players.user(), 8, -1, 1, 1, 1})
				giveRP:trigger()
				if delayPly > 0 then
					yield(delayPly)
				end
			end
			yield()
		until players.get_rank(playerID) >= levelPly or not rpLoopPlyr.value
		if players.get_rank(playerID) >= levelPly then 
			toast($"{players.get_name(playerID)} 现在处于目标等级 {levelPly}. :)")
			rpLoopPlyr.value = false
			yield()
			yield()
			return 
		end
	end)

	local glitchPlyrRoot = griefing:list("鬼畜玩家")
	local glitchObjMdl = joaat("prop_ld_ferris_wheel")
	glitchPlyrRoot:list_select("物体", {"glitchplayerobj"}, "", object_stuff, object_stuff[1][1], function(mdlHash)
		glitchObjMdl = mdlHash
	end)

	local spawnDelay = 150
	glitchPlyrRoot:slider("重生延迟", {"spawndelay"}, "可能会被标记为作弊者", 50, 3000, 100, 10, function(amount)
		spawnDelay = amount
	end)

	local glitchplayer
	glitchplayer = glitchPlyrRoot:toggle_loop("启用", {"glitchplayer"}, "被带有实体防护的菜单阻止", function()
		local rallytruck = joaat("rallytruck")
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local pos = players.get_position(playerID)

		if not DOES_ENTITY_EXIST(ped) then
			toast($"{players.get_name(playerID)} 太远 :/")
			glitchvalue = false
			util.stop_thread()
		end

		util.request_model(glitchObjMdl)
		util.request_model(rallytruck)
		local obj = entities.create_object(glitchObjMdl, pos)
		local vehicle = entities.create_vehicle(rallytruck, pos, 0)
		SET_ENTITY_VISIBLE(obj, false)
		SET_ENTITY_VISIBLE(vehicle, false)
		SET_ENTITY_INVINCIBLE(obj, true)
		SET_ENTITY_COLLISION(obj, true, true)
		yield(delay)
		entities.delete(obj)
		entities.delete(vehicle)
		yield(delay)
	end)

	local glitchVehRoot = griefing:list("鬼畜载具")
	local glitchVehMdl = joaat("prop_ld_ferris_wheel")
	glitchVehRoot:list_select("物体", {"glitchvehobj"}, "", object_stuff, object_stuff[1][1], function(mdlHash)
		glitchVehMdl = mdlHash
	end)
	
	local glitchveh
	glitchveh = glitchVehRoot:toggle_loop("启用", {"glitchvehicle"}, "适用于所有菜单 并且不会被任何菜单检测到", function() -- credits to soul reaper for base concept
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local pos = GET_ENTITY_COORDS(ped, false)
		local vehicle = GET_VEHICLE_PED_IS_USING(ped)
		local veh_model = players.get_vehicle_model(playerID)
		local seat_count = GET_VEHICLE_MODEL_NUMBER_OF_SEATS(veh_model)
		util.request_model(glitchVehMdl)
		if IS_REMOTE_PLAYER_IN_NON_CLONED_VEHICLE(playerID) then
			toast($"{players.get_name(playerID)} 载具尚未被克隆 :/")
			return
		end

		if not IS_PED_IN_ANY_VEHICLE(ped) then
			toast(lang.get_localised(PLYNVEH):gsub("{}", players.get_name(playerID)))
			glitchveh.value = false
			util.stop_thread() 
		end

		if not ARE_ANY_VEHICLE_SEATS_FREE(vehicle) then
			toast("无座 :/")
			glitchveh.value = false
			util.stop_thread() 
		end

		glitchPed = createRandomPed(pos)
		glitchObj = entities.create_object(glitchVehMdl, pos)
		local things = {glitchPed, glitchObj}
		entities.set_can_migrate(glitchPed, false)
		entities.set_can_migrate(glitchObj, false)
		SET_ENTITY_VISIBLE(glitchObj, false)
		SET_ENTITY_INVINCIBLE(glitchPed, true)
		for i = 0, seat_count -1 do
			if ARE_ANY_VEHICLE_SEATS_FREE(vehicle) then
				local emptyseat = i
				for l = 1, 25 do
					SET_PED_INTO_VEHICLE(glitchPed, vehicle, emptyseat)
					ATTACH_ENTITY_TO_ENTITY(glitchObj, glitchPed, 0, v3(), v3(), false, false, false, false, 0, true, false)
					SET_ENTITY_COLLISION(glitchObj, true, true)
					yield()
				end
			end
		end
		if glitchPed != nil then
			entities.delete(glitchPed) 
		end
		if glitchObj != nil then 
			entities.delete(glitchObj)
		end
	end, function()
		if glitchPed != nil then
			entities.delete(glitchPed) 
		end
		if glitchObj != nil then 
			entities.delete(glitchObj)
		end
	end)

	local glitchforcefield
	glitchforcefield = griefing:toggle_loop("鬼畜立场", {"forcefield"}, "对有实体保护的菜单无效", function()
		local glitchedForcefieldMdl = joaat("p_spinning_anus_s")
		util.request_model(glitchedForcefieldMdl)

		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local pos = players.get_position(playerID)
		
		if not DOES_ENTITY_EXIST(ped) then
			toast($"{players.get_name(playerID)} 太远 :/")
			glitchforcefield.value = false
			util.stop_thread()
		end

		if IS_PED_IN_ANY_VEHICLE(ped) then
			toast($"{players.get_name(playerID)} 在载具里 :/")
			glitchforcefield.value = false
			util.stop_thread()
		end

		local obj = entities.create_object(glitchedForcefieldMdl, pos)
		SET_ENTITY_VISIBLE(obj, false)
		SET_ENTITY_COLLISION(obj, true, true)
		yield(100)
		entities.delete(obj) 
	end)
	
	local veh_kick = griefing:list("载具劫持")
	veh_kick:action("拖出", {"dragkick"}, "产生一个NPC将他们强行拖出车外", function()
		if playerID == players.user() then 
			toast(lang.get_localised(CMDOTH))
			return
		end
		local timer = util.current_time_millis() + 2500
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)

		if IS_REMOTE_PLAYER_IN_NON_CLONED_VEHICLE(playerID) then
			toast($"{players.get_name(playerID)} 载具尚未被克隆 :/")
			return
		end
		
		if not IS_PED_IN_ANY_VEHICLE(ped) then
			toast(lang.get_localised(PLYNVEH):gsub("{}", players.get_name(playerID)))
			return 
		end
		
		local pos = players.get_position(playerID)
		local vehicle = GET_VEHICLE_PED_IS_USING(ped)
		local driver = NETWORK_GET_PLAYER_INDEX_FROM_PED(GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
		local passenger = NETWORK_GET_PLAYER_INDEX_FROM_PED(GET_PED_IN_VEHICLE_SEAT(vehicle, -2))
		local seat = getSeatPedIsIn(ped)
		local ping = ROUND(NETWORK_GET_AVERAGE_PING(playerID))
		pos.z -= 50

		randomPed = createRandomPed(pos)
		entities.set_can_migrate(randomPed, false)
		SET_ENTITY_INVINCIBLE(randomPed, true)
		SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(randomPed, true)
		SET_PED_CONFIG_FLAG(randomPed, 366, true)
		while not GET_IS_TASK_ACTIVE(randomPed, 160) do
			if util.current_time_millis() > timer then
				if isDebugMode then
					toast("无法将任务指派给行人 :/")
				else
					toast($"踢出失败 {players.get_name(playerID)} 从载具上 :/")
				end
				entities.delete(randomPed)
				return
			end
			yield()
		end
		repeat
			if GET_IS_TASK_ACTIVE(ped, 2) and getSeatPedIsIn(randomPed) == seat then
				repeat
					yield()
				until not GET_IS_TASK_ACTIVE(ped, 2)
			end
			if util.current_time_millis() > timer and getSeatPedIsIn(randomPed) != seat then
				if ping > 80 then
					toast($"踢出失败 {players.get_name(playerID)} 高延迟 ({ping}ms) :/")
				else
					toast($"踢出失败 {players.get_name(playerID)} 从载具上 :/")
				end
				entities.delete(randomPed)
				timer = util.current_time_millis() + 2500
				break 
			end
			yield()
		until not IS_PED_IN_ANY_VEHICLE(ped)
		entities.delete(randomPed)
		timer = util.current_time_millis() + 2500
	end)

	veh_kick:action("推出", {"shufflekick"}, '在副驾生成NPC推出玩家 每次都有效 除非目标使用无法拖出', function()
		if playerID == players.user() then 
			toast(lang.get_localised(CMDOTH))
			return
		end

		local timer = util.current_time_millis() + 2500
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local pos = players.get_position(playerID)
		local vehicle = GET_VEHICLE_PED_IS_USING(ped)
		if IS_REMOTE_PLAYER_IN_NON_CLONED_VEHICLE(playerID) then
			toast($"{players.get_name(playerID)} 载具尚未被克隆 :/")
			return
		end

		if vehicle == 0 then
			util.toast(lang.get_localised(1067523721):gsub("{}", players.get_name(playerID)))
			return 
		end

		if GET_VEHICLE_MODEL_NUMBER_OF_SEATS(GET_ENTITY_MODEL(vehicle)) == 1 then
			util.toast("载具有权限 失败 :/")
			return
		end

		if not IS_VEHICLE_SEAT_FREE(vehicle, -2) then
			util.toast("无座 :/")
			return
		end

		if not CAN_SHUFFLE_SEAT(vehicle, -1) then 
			util.toast("不可换座 :/")
			return
		end

		local randomPed = createRandomPed(pos)
		entities.set_can_migrate(randomPed, false)
		SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(randomPed, true)
		SET_PED_INTO_VEHICLE(randomPed, vehicle, -2)
		TASK_SHUFFLE_TO_NEXT_VEHICLE_SEAT(randomPed, vehicle)
		if IS_PED_IN_ANY_VEHICLE(ped) then
			repeat
				if GET_IS_TASK_ACTIVE(ped, 2) then
					timer = util.current_time_millis() + 2500
				end
				if util.current_time_millis() > timer then
					entities.delete(randomPed)
					util.toast("未能坐到驾驶座上 :/")                
					timer = util.current_time_millis() + 2500
					break
				end
				util.yield()
			until not IS_PED_IN_ANY_VEHICLE(ped)
		end
		entities.delete(randomPed)
		SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(vehicle, playerID, true)
	end)
	
	veh_kick:action("脚本", {"scriptkick"}, "使用脚本事件将他们踢出载具", function()
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local vehicle = GET_VEHICLE_PED_IS_USING(ped)
		SET_VEHICLE_EXCLUSIVE_DRIVER(vehicle, players.user_ped(), 0)
	end)

	griefing:action("载具劫持", {"hijack"}, "发送NPC劫持对方载具 高延迟玩家可能不起作用", function()
		if playerID == players.user() then 
			toast(lang.get_localised(CMDOTH))
			return
		end

		local timer = util.current_time_millis() + 2500
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local pos = players.get_position(playerID)
		local vehicle = GET_VEHICLE_PED_IS_USING(ped)
		local driver = NETWORK_GET_PLAYER_INDEX_FROM_PED(GET_PED_IN_VEHICLE_SEAT(vehicle, -1))
		local passenger = NETWORK_GET_PLAYER_INDEX_FROM_PED(GET_PED_IN_VEHICLE_SEAT(vehicle, -2))
		local drivingStyle = DF_SwerveAroundAllCars | DF_AvoidRestrictedAreas | DF_GoOffRoadWhenAvoiding | DF_SteerAroundObjects | DF_UseShortCutLinks | DF_ChangeLanesAroundObstructions
		local ping = ROUND(NETWORK_GET_AVERAGE_PING(playerID))
		if IS_REMOTE_PLAYER_IN_NON_CLONED_VEHICLE(playerID) then
			toast($"{players.get_name(playerID)} 载具尚未被克隆 :/")
			return
		end

		if vehicle == 0 then
			toast(lang.get_localised(PLYNVEH):gsub("{}", players.get_name(playerID)))
			return 
		end

		pos.z -= 30
		if not IS_PED_A_PLAYER(GET_PED_IN_VEHICLE_SEAT(vehicle, -1)) then
			toast("劫持成功 :D")
			return 
		end
		randomPed = createRandomPed(pos)
		SET_ENTITY_INVINCIBLE(randomPed, true)
		SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(randomPed, true)
		entities.set_can_migrate(randomPed, false)
		TASK_ENTER_VEHICLE(randomPed, vehicle, 1000, -1, 1.0, ECF_WARP_ENTRY_POINT | ECF_DONT_WAIT_FOR_VEHICLE_TO_STOP | ECF_JACK_ANYONE | ECF_WARP_PED | ECF_WARP_IF_DOOR_IS_BLOCKED, 0, false)
		while not GET_IS_TASK_ACTIVE(randomPed, 160) do
			if util.current_time_millis() > timer then
				if isDebugMode then
					toast("无法将任务指派给行人 :/")
				else
					toast("劫持失败 :/")
				end
				entities.delete(randomPed)
				return
			end
			yield()
		end
		repeat
			if GET_IS_TASK_ACTIVE(ped, 2) then
				timer = util.current_time_millis() + 2500
			end
			if util.current_time_millis() > timer and IS_PED_IN_ANY_VEHICLE(ped) then
				if ping > 80 then -- this is high enough to interfere with the hijack process
					toast($"高延迟 ({ping}ms) :/")
				else
					toast("劫持失败 :/")
				end
				entities.delete(randomPed)
				timer = util.current_time_millis() + 2500
				return 
			end
			yield()
		until not IS_PED_IN_ANY_VEHICLE(ped)
		if getSeatPedIsIn(randomPed) == -1 then
			entities.request_control(vehicle, 2500)
			TASK_VEHICLE_DRIVE_WANDER(randomPed, vehicle, 9999.0, drivingStyle) 
			toast("劫持成功 :D")
			if not GET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(vehicle, playerID) then
				SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(vehicle, playerID, true)
			end
		end
		yield(1000)
		if not GET_IS_TASK_ACTIVE(randomPed, 151) then
			if not IS_PED_IN_ANY_VEHICLE(randomPed) then
				repeat
					if util.current_time_millis() > timer then
						if isDebugMode then
							toast("无法将任务指派给行人 :/")
						else
							toast("劫持失败 :/")
						end
						entities.delete(randomPed)
						return
					end
					SET_PED_INTO_VEHICLE(randomPed, vehicle, -1)
					yield()
				until GET_VEHICLE_PED_IS_USING(randomPed) == vehicle
				entities.request_control(randomPed, 2500)
				TASK_VEHICLE_DRIVE_WANDER(randomPed, vehicle, 9999.0, drivingStyle)
			end

		end
		yield(5000)
		if randomPed != nil and not IS_PED_IN_ANY_VEHICLE(randomPed, false) then -- 2nd check cus sometimes doesnt delete the first time
			entities.delete(randomPed)
		end
	end)

	local tp = false
	griefing:action("载具接管", {"takeover"}, "产生NPC抢车 然后接管 网络不好可能无效", function()
		local otr = menu.ref_by_path("Online>Off The Radar")
		if playerID == players.user() then 
			toast(lang.get_localised(CMDOTH))
			return
		end

		local timer = util.current_time_millis() + 2500
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local local_pos = players.get_position(players.user())
		local pos = players.get_position(playerID)
		local vehicle = GET_VEHICLE_PED_IS_USING(ped)
		local cam_pos = players.get_cam_pos(playerID)
		local pedDistance = v3.distance(players.get_position(players.user()), players.get_position(playerID))
		local ping = ROUND(NETWORK_GET_AVERAGE_PING(playerID))
		if IS_REMOTE_PLAYER_IN_NON_CLONED_VEHICLE(playerID) then
			toast($"{players.get_name(playerID)} 载具尚未被克隆 :/")
			return
		end

		if vehicle == 0 then
			toast(lang.get_localised(PLYNVEH):gsub("{}", players.get_name(playerID)))
			return 
		end

		pos.z -= 50	
		if pedDistance > 100.0 then
			otr.value = true
			FREEZE_ENTITY_POSITION(players.user_ped(), true)
			invisibility:setState("Enabled")
			SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), cam_pos, false, false, false)
			tp = true
		end
		randomPed = createRandomPed(pos)
		entities.set_can_migrate(randomPed, false)
		SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(randomPed, true)
		TASK_ENTER_VEHICLE(randomPed, vehicle, 1000, -1, 1.0, ECF_WARP_ENTRY_POINT | ECF_DONT_WAIT_FOR_VEHICLE_TO_STOP | ECF_JACK_ANYONE | ECF_WARP_PED | ECF_WARP_IF_DOOR_IS_BLOCKED, 0, false)
		if getSeatPedIsIn(randomPed) != -1 then
			repeat
				cam_pos = players.get_cam_pos(playerID)
				SET_PED_INTO_VEHICLE(randomPed, vehicle, -1)
				if tp then
					SET_ENTITY_COLLISION(players.user_ped(), false, false)
					invisibility:setState("Enabled")
					SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), cam_pos, false, false, false)
				end
				if GET_IS_TASK_ACTIVE(ped, 2) then
					timer = util.current_time_millis() + 5000
				end
				if util.current_time_millis() > timer then
					if tp then
						FREEZE_ENTITY_POSITION(players.user_ped(), false)
						SET_ENTITY_COLLISION(players.user_ped(), true, true)
						invisibility:setState("Disabled")
						SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), local_pos, false, false, false)
						tp = false
					end
					if util.current_time_millis() > timer then
						if ping > 80 then
							toast($"高延迟 ({ping}ms) :/")
							invisibility:setState("Disabled")
						else
							toast("接管失败 :/")
							invisibility:setState("Disabled")
						end
					end
					otr.value = false
					entities.delete(randomPed)
					timer = util.current_time_millis() + 2500
					return
				end
				yield()
			until getSeatPedIsIn(ped) != -1
			entities.delete(randomPed)
		end
		timer = util.current_time_millis() + 2500
		SET_PED_INTO_VEHICLE(players.user_ped(), vehicle, -1)
		repeat
			if not IS_PED_IN_ANY_VEHICLE(ped) and getSeatPedIsIn(ped) != -1 then
				if tp then
					invisibility:setState("Enabled")
				end
				if util.current_time_millis() > timer then
					if DECOR_GET_INT(vehicle, "Player_Vehicle") != 0 then
						toast("载具有权限 失败 :/")
					else 
						toast("接管失败 :/")
					end
					if tp then
						SET_ENTITY_COLLISION(players.user_ped(), true, true)
						FREEZE_ENTITY_POSITION(players.user_ped(), false)
						SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), local_pos, false, false, false)
						invisibility:setState("Disabled")
						tp = false
					end
					otr.value = false
					entities.delete(randomPed)
					timer = util.current_time_millis() + 2500
					return
				end
				SET_PED_INTO_VEHICLE(players.user_ped(), vehicle, -1)
			end
			yield()
		until GET_VEHICLE_PED_IS_USING(players.user_ped()) == vehicle
		SET_ENTITY_COLLISION(players.user_ped(), true, true)
		FREEZE_ENTITY_POSITION(players.user_ped(), false)
		invisibility:setState("Disabled")
		otr.value = false
		toast("接管成功 :D")
		timer = util.current_time_millis() + 2500
	end)

	local lockon
	lockon = griefing:toggle_loop("载具声音", {"lockon"}, "仅适用于特定载具 例如武装载具", function()
		if playerID == players.user() then 
			toast(lang.get_localised(CMDOTH))
			lockon.value = false
			return
		end

		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local vehicle = GET_VEHICLE_PED_IS_USING(ped)
		if not IS_PED_IN_ANY_VEHICLE(ped) then
			toast(lang.get_localised(PLYNVEH):gsub("{}", players.get_name(playerID)))
			lockon.value = false
			return 
		end

		SET_VEHICLE_HOMING_LOCKEDONTO_STATE(vehicle, 1)
	end)
	
	griefing:action("载具拖车", {"tow"}, "", function()
		local towtruckMdl = joaat("towtruck3")
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local vehicle = GET_VEHICLE_PED_IS_USING(ped)
		if not IS_PED_IN_ANY_VEHICLE(ped) then
			toast(lang.get_localised(PLYNVEH):gsub("{}", players.get_name(playerID)))
			return
		end
		local pos = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, 0.0, 7.0, 0.0)
		util.request_model(towtruckMdl)
		entities.request_control(vehicle, 2500)
		local randomPed = createRandomPed(pos)
		local towtruck = entities.create_vehicle(towtruckMdl, pos, GET_ENTITY_HEADING(vehicle))
		SET_ENTITY_INVINCIBLE(randomPed, true)
		SET_PED_INTO_VEHICLE(randomPed, towtruck, -1)
		ATTACH_VEHICLE_TO_TOW_TRUCK(towtruck, vehicle, false, 90.0, 90.0, -180.0)
		SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(randomPed, true)
		TASK_VEHICLE_DRIVE_WANDER(randomPed, towtruck, 9999.0, DF_SwerveAroundAllCars | DF_AvoidRestrictedAreas | DF_GoOffRoadWhenAvoiding | DF_SteerAroundObjects | DF_UseShortCutLinks | DF_ChangeLanesAroundObstructions) 
	end)
	
	griefing:action("载具钉条", {"spike"}, "在载具前方生成尖刺带", function()
		local spikeStripMdl = joaat("xs_prop_arena_spikes_02a")
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		if not IS_PED_IN_ANY_VEHICLE(ped) then
			toast(lang.get_localised(PLYNVEH):gsub("{}", players.get_name(playerID)))
			return 
		end
		local vehicle = GET_VEHICLE_PED_IS_USING(ped)
		local height = GET_ENTITY_HEIGHT_ABOVE_GROUND(vehicle)
		if height > 1.0 then 
			toast("载具离地面太高 :/")
			return
		end
		util.request_model(spikeStripMdl)
		local pos = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, 0.0, GET_ENTITY_SPEED(vehicle)/2, -0.55)
		spikes = entities.create_object(spikeStripMdl, pos)
		SET_ENTITY_HEADING(spikes, GET_ENTITY_HEADING(vehicle) - 180)
		yield(2500)
		entities.delete(spikes)
	end)

	local boostVeh
	boostVeh = griefing:toggle_loop("载具助推", {"boost"}, "利用牛顿物理定律推动载具前进", function()
		local speedUpMdl = joaat("stt_prop_track_speedup")
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		util.request_model(speedUpMdl)
		if IS_REMOTE_PLAYER_IN_NON_CLONED_VEHICLE(playerID) then
			toast($"{players.get_name(playerID)} 载具尚未被克隆 :/")
			return
		end

		if not IS_PED_IN_ANY_VEHICLE(ped) then
			toast(lang.get_localised(PLYNVEH):gsub("{}", players.get_name(playerID)))
			boostVeh.value = false
			return 
		end

		local vehicle = GET_VEHICLE_PED_IS_USING(ped)
		local pos = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, 0.0, GET_ENTITY_SPEED(vehicle)/1.5, -3.0)
		if boostpad == nil or not DOES_ENTITY_EXIST(boostpad) then
			boostpad = entities.create_object(speedUpMdl, pos)
			SET_OBJECT_SPEED_BOOST_AMOUNT(boostpad, 100)
			entities.set_can_migrate(boostpad, false)
		end
		yield(500)
		SET_ENTITY_COORDS_NO_OFFSET(boostpad, pos, false, false, false)
		SET_ENTITY_HEADING(boostpad, GET_ENTITY_HEADING(vehicle) - 90)
	end, function()
		if boostpad != nil then
			entities.delete(boostpad)
		end
	end)
	
	local slowdownVeh
	slowdownVeh = griefing:toggle_loop("载具减速", {"slowdown"}, "绕过牛顿物理定律 让载具以蜗牛般的速度停下来", function()
		local slowDownMdl = joaat("stt_prop_track_slowdown")
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		util.request_model(slowDownMdl)

		if IS_REMOTE_PLAYER_IN_NON_CLONED_VEHICLE(playerID) then
			toast($"{players.get_name(playerID)} 载具尚未被克隆 :/")
			return
		end

		if not IS_PED_IN_ANY_VEHICLE(ped) then
			toast(lang.get_localised(PLYNVEH):gsub("{}", players.get_name(playerID)))
			slowdownVeh.value = false
			return 
		end

		local vehicle = GET_VEHICLE_PED_IS_USING(ped)
		local pos = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, 0.0, GET_ENTITY_SPEED(vehicle)/1.5, -3.0)
		if brakepad == nil or not DOES_ENTITY_EXIST(brakepad) then
			brakepad = entities.create_object(slowDownMdl, pos)
			entities.set_can_migrate(brakepad, false)
		end
		yield(500)
		SET_ENTITY_COORDS_NO_OFFSET(brakepad, pos, false, false, false)
		SET_ENTITY_HEADING(brakepad, GET_ENTITY_HEADING(vehicle) - 90)
	end, function()
		if brakepad != nil then
			entities.delete(brakepad)
		end
	end)
	
	griefing:action("被动玩家", {"removepassive"}, "删除玩家被动模式", function()
		if not isPlayerInPassiveMode(playerID) then
            toast($"{players.get_name(playerID)} 不处于被动模式 :/")
			return
		end
		local int = memory.read_int(memory.script_global(GlobalplayerBD_FM_3 + 1 + (playerID * 610) + 512)) --  Global_1887305[PLAYER::PLAYER_ID() /*610*/].f_512
		util.trigger_script_event(1 << playerID, {-366707054, players.user(), 49, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
		util.trigger_script_event(1 << playerID, {1757622014, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
	 end)

	griefing:action("送院玩家", {"hospitalize"}, "", function()
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local ping = ROUND(NETWORK_GET_AVERAGE_PING(playerID))
		local timer = (ping > 300) ? (util.current_time_millis() + 5000) : (util.current_time_millis() + 3000)
		local pPed =  entities.handle_to_pointer(ped)
		local pedPtr = entities.handle_to_pointer(players.user_ped())
		if IS_PLAYER_DEAD(playerID) then return end
		if IS_REMOTE_PLAYER_IN_NON_CLONED_VEHICLE(playerID)then
            toast($"{players.get_name(playerID)} 人物尚未被克隆 :/")
            return
        end
		setBit(memory.script_global(GlobalplayerBD + 1 + (players.user() * 465) + 426), 0)
		yield(1000)
		repeat
			util.call_foreign_function(CWeaponDamageEventTrigger, pedPtr, pPed, pPed + 0x90, 0, 1, joaat("weapon_pistol"), 500.0, 0, 0, DF_IsAccurate | DF_IgnorePedFlags | DF_SuppressImpactAudio | DF_IgnoreRemoteDistCheck, 0, 0, 0, 0, 0, 0, 0, 0.0)
			if util.current_time_millis() > timer then
				toast($"击杀失败 {players.get_name(playerID)}. :/")
				clearBit(memory.script_global(GlobalplayerBD + 1 + (players.user() * 465) + 426), 0)
				timer = util.current_time_millis() + 3000
				return
			end
			yield()
		until IS_PED_DEAD_OR_DYING(ped)
		yield(1000)
		timer = util.current_time_millis() + 3000
		clearBit(memory.script_global(GlobalplayerBD + 1 + (players.user() * 465) + 426), 0)
    end)

	local isOrbActive = false
	griefing:action("打击玩家", {"orb"}, "天基炮打击目标", function()
		local timer = util.current_time_millis() + 3000
		if playerID == players.user() then 
			toast(lang.get_localised(CMDOTH))
			return
		end
		if isOrbActive then 
			toast(lang.get_localised(TOOFAST))
			return 
		end
		if IS_PLAYER_DEAD(playerID) or not isNetPlayerOk(playerID) then 
			return 
		end
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		isOrbActive = true
        setBit(memory.script_global(GlobalplayerBD + 1 + (players.user() * 465) + 426), 0)
		yield(1000) -- yielding a second because its a bit iffy on high(ish) ping players (150ms+)
		local pos = players.get_position(playerID)
		ADD_OWNED_EXPLOSION(players.user_ped(), pos, 59, 1.0, true, false, 1.0)
		USE_PARTICLE_FX_ASSET("scr_xm_orbital")
		START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_xm_orbital_blast", pos, v3(), 1.0, false, false, false, true)
		PLAY_SOUND_FROM_COORD(0, "DLC_XM_Explosions_Orbital_Cannon", pos, 0, true, 0, false) -- hardcoding sound id because GET_SOUND_ID doesnt work sometimes
		yield(1000)
		clearBit(memory.script_global(GlobalplayerBD + 1 + (players.user() * 465) + 426), 0)
		repeat
			if util.current_time_millis() > timer and not IS_PED_DEAD_OR_DYING(ped) then
				toast($"Failed to orbital strike {players.get_name(playerID)}. :/")
				isOrbActive = false
				timer = util.current_time_millis() + 3000
				return
			end
			yield()
		until not IS_PED_DEAD_OR_DYING(ped)
		STOP_SOUND(0)
		isOrbActive = false
		timer = util.current_time_millis() + 3000
    end)

	griefing:toggle_loop("发射玩家", {"launch"}, "适用于大多数菜单", function()
		local muleMdl = joaat("mule5")
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local pos = players.get_position(playerID)
		util.request_model(muleMdl)
					
		veh = entities.create_vehicle(muleMdl, GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 1.0, -3.0), GET_ENTITY_HEADING(ped))
		entities.set_can_migrate(veh, false)
		SET_ENTITY_VISIBLE(veh, false)
		yield(500)
		APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, 0.0, 1000.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
		yield(2500)
		entities.delete(veh)
		repeat
			yield()
		until GET_ENTITY_SPEED(ped) < 30.0
	end, function()
		if veh != 0 and DOES_ENTITY_EXIST(veh) then 
			entities.delete(veh)
		end
	end)
	
	local vent = {}
	griefing:toggle_loop("摔倒玩家", {"stumble"}, "", function()
		local mdl = joaat("prop_roofvent_06a")
		local pos = players.get_position(playerID)
		pos.z -= 2.4
		util.request_model(mdl)
		local temp_v3 = v3.new(0, 0, 0)
		local middleVent = entities.create_object(mdl, v3(pos.x, pos.y, pos.z))
		SET_ENTITY_VISIBLE(middleVent, false)
		for i = 1, 4 do
			local angle = (i / 4) * 360
			temp_v3.z = angle
			local obj_pos = temp_v3:toDir()
			obj_pos:mul(1.25)
			obj_pos:add(pos)
			vent[i] = entities.create_object(mdl, obj_pos)
			SET_ENTITY_VISIBLE(vent[i], false)
		end
		yield(500)
		entities.delete(middleVent)
		for vent as obj do
			entities.delete(obj)
		end
	end)

	griefing:action("击杀玩家", {"interiorkill"}, "击杀室内玩家", function()
		if memory.read_int(getPlayerProperty(playerID)) != -1 then 
			toast("不适用于公寓 :/")
			return
		end 
		if isPlayerInInterior(playerID) then
			local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
			local pPed =  entities.handle_to_pointer(ped)
			local pedPtr = entities.handle_to_pointer(players.user_ped())
			util.call_foreign_function(CWeaponDamageEventTrigger, pedPtr, pPed, pPed + 0x90, 0, 1, joaat("weapon_snowball"), 500.0, 0, 0, DF_IsAccurate | DF_IgnorePedFlags | DF_SuppressImpactAudio | DF_IgnoreRemoteDistCheck, 0, 0, 0, 0, 0, 0, 0, 0.0)
		end
	end)

	local smokescreen = griefing:list("烟幕玩家")
	local smokeColor = {r = 1, g = 0, b = 1, a = 0}
	smokescreen:colour("烟色", {"smokescreencolor"}, "单击以选择一种颜色", smokeColor, true, function(value)
		smokeColor = value 
	end)

	local smokeSize = 5.00
	smokescreen:slider_float("大小", {"smokesize"}, "", 0, 1000, 500, 10, function(value)
		smokeSize = value / 100
	end)

	local playerPtfx = {}
	smokescreen:toggle_loop("启用", {"smoke"}, "对方视野乌烟瘴气", function() 
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		REQUEST_NAMED_PTFX_ASSET("scr_as_trans")
		USE_PARTICLE_FX_ASSET("scr_as_trans")
		if playerPtfx[playerID] == nil or not DOES_PARTICLE_FX_LOOPED_EXIST(playerPtfx[playerID]) then
			playerPtfx[playerID] = START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY("scr_as_trans_smoke", ped, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, smokeSize, false, false, false, smokeColor.r, smokeColor.g, smokeColor.b, 1)
		end
		yield(100)
		local cachedRed = smokeColor.r
		local cachedGreen = smokeColor.g
		local cachedBlue = smokeColor.b
		local cachedSize = smokeSize
		repeat
			yield()
		until cachedRed != smokeColor.r or cachedGreen != smokeColor.g or cachedBlue != smokeColor.b or cachedSize != smokeSize
		if DOES_PARTICLE_FX_LOOPED_EXIST(playerPtfx[playerID]) then
			REMOVE_PARTICLE_FX(playerPtfx[playerID], false)
			playerPtfx[playerID] = nil
		end
		REMOVE_NAMED_PTFX_ASSET("scr_as_trans")
	end, function()
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		REMOVE_PARTICLE_FX(playerPtfx[playerID])
		REMOVE_NAMED_PTFX_ASSET("scr_as_trans")
	end)

	local gravity = griefing:list("引力玩家", {}, "适用于所有菜单 会被检测到 对无敌玩家无效")
	local gravitateForce = 1.00
	menu.slider_float(gravity, "引力值", {"force"}, "", 0, 100, 100, 10, function(value)
		gravitateForce = value / 100
	end)
 
	gravity:toggle_loop("启用", {"gravitate"}, "", function()
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local vehicle = GET_VEHICLE_PED_IS_USING(ped)

		if isPlayerGodmode(playerID) and (not NETWORK_IS_PLAYER_FADING(playerID) and IS_ENTITY_VISIBLE(ped)) and isNetPlayerOk(playerID) and not isPlayerInCutscene(playerID) and not players.is_using_rc_vehicle(playerID) then
			toast($"{players.get_name(playerID)} 无敌 :/")
			gravitate.value = false
			util.stop_thread()
		end
		
		ADD_EXPLOSION(players.get_position(playerID), 29, gravitateForce, false, true, 0.0, true)
		yield(1000)
	end)
	
	griefing:toggle_loop("随机火箭", {}, "会在地图下产生随机信号弹 使制导火箭弹朝随机方向发射", function()
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local pos = players.get_position(playerID)
		local groundPos = players.get_position(playerID)

		local ground
		ground, groundPos.z = util.get_ground_z(groundPos.x, groundPos.y)
		if not ground then return end

		groundPos.x += math.random(-50, 50)
		groundPos.y += math.random(-50, 50)
		groundPos.z -= 10

		if IS_PED_SHOOTING(ped) and IS_PED_ARMED(ped, 2) then
			SHOOT_SINGLE_BULLET_BETWEEN_COORDS(groundPos, pos, 0, true, joaat("weapon_flaregun"), players.user_ped(), true, false, 0.0)
		end
	end)
	
	griefing:toggle_loop("自杀火箭", {}, "火箭弹掉头瞄准自己", function()
		local things = {-0.1, 0.1}
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local pos = players.get_position(playerID)
		local pos1 = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, things[math.random(#things)], -15.0, -2.0)
		local pos2 = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 0.0, 0.0)
		if IS_PED_SHOOTING(ped) and IS_PED_ARMED(ped, 2) then
			SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos1, pos2, 0, true, util.joaat("weapon_flaregun"), players.user_ped(), true, false, 0.0)
			yield(2500)
			CLEAR_AREA_OF_PROJECTILES(pos, 25.0, 0)
		end
	end)

	griefing:textslider("无限加载", {}, "玩家在接受邀请后将陷入无限加载屏幕", {"游艇", "办公室", "夜总会", "办公室车库", "改装铺", "公寓"}, function(index)
		util.trigger_script_event(1 << playerID, {996099702, playerID, index})
	end)

	griefing:toggle_loop("黑屏加载", {}, "", function()
		local handle = NETWORK_HASH_FROM_PLAYER_HANDLE(playerID)
		util.trigger_script_event(1 << playerID, {-1604421397, players.user(), 1, 4, handle, handle, handle, handle, 1, 1})
		yield(10000)
	end)
	 
	griefing:toggle_loop("循环动画", {}, "", function()
		local handle = NETWORK_HASH_FROM_PLAYER_HANDLE(playerID)
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		util.trigger_script_event(1 << playerID, {-1604421397, players.user(), math.random(0, 114), 4, handle, handle, handle, handle, 1, 1})
		repeat
			yield()
		until IS_ENTITY_VISIBLE(ped)
	end)

	griefing:action("发送动画", {"intro"}, "发送到在线模式新手动画", function()
		local int = memory.read_int(memory.script_global(GlobalplayerBD_FM_3 + 1 + (playerID * 610) + 512))
		util.trigger_script_event(1 << playerID, {-366707054, players.user(), 20, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
		util.trigger_script_event(1 << playerID, {1757622014, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
	 end)
	
	local jobs = griefing:list("发送活动")
	local activities = {
		[211] = "飞镖",
		[212] = "高尔夫",
		[215] = "驾校"
	}
	
	for id, activity in activities do
		jobs:action(activity, {activity}, "强迫活动", function()
			local int = memory.read_int(memory.script_global(GlobalplayerBD_FM_3 + 1 + (playerID * 609) + 511))
			util.trigger_script_event(1 << playerID, {-366707054, players.user(), id, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
			util.trigger_script_event(1 << playerID, {1757622014, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
		end)
	end

	local sendToArcade = griefing:list("发送街机")
	local arcadeGames = {
		[229] = "街头狂飙",
		[230] = "荒地复仇",
		[231] = "断袖诅咒",
		[235] = "太空猴",
		[236] = "QUB3D",
		[237] = "猎头",
	}
	
	for id, gameName in arcadeGames do
		sendToArcade:action(gameName, {}, "", function()
			local int = memory.read_int(memory.script_global(GlobalplayerBD_FM_3 + 1 + (playerID * 610) + 512))
			util.trigger_script_event(1 << playerID, {-366707054, players.user(), id, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
			util.trigger_script_event(1 << playerID, {1757622014, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
		end)
	end
	griefing:toggle_loop("载具上锁", {"vehiclelock"}, "", function()
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local vehicle = GET_VEHICLE_PED_IS_TRYING_TO_ENTER(ped)
		if not GET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(vehicle, playerID) then
			SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(vehicle, playerID, true)
		end
	end)

	local disableAcceleration
	disableAcceleration = griefing:toggle_loop("禁用加速", {}, "", function()
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		if not IS_PED_IN_ANY_VEHICLE(ped) then
			toast(lang.get_localised(PLYNVEH):gsub("{}", players.get_name(playerID)))
			disableAcceleration.value = false
			return 
		end
		local vehicle = GET_VEHICLE_PED_IS_USING(ped)
		local top_speed = GET_VEHICLE_MODEL_ESTIMATED_MAX_SPEED(vehicle)
		entities.request_control(vehicle, 2500)
		SET_VEHICLE_MAX_SPEED(vehicle, 0.1)
	end)

	griefing:action("载具倒置", {"flip"}, "", function()
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local pos = players.get_position(playerID)
		local vehicle = GET_VEHICLE_PED_IS_USING(ped)
		local rot = GET_ENTITY_ROTATION(vehicle, 2)
		rot.x = 180

		if not IS_PED_IN_ANY_VEHICLE(ped) then
			toast(lang.get_localised(PLYNVEH):gsub("{}", players.get_name(playerID)))
			return 
		end
		entities.request_control(vehicle, 2500)
		SET_ENTITY_ROTATION(vehicle, rot, 2, false)
	end)

	griefing:toggle_loop("击晕玩家", {"stun"}, "", function()
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local pPed =  entities.handle_to_pointer(ped)
		local pedPtr = entities.handle_to_pointer(players.user_ped())
		util.call_foreign_function(CWeaponDamageEventTrigger, pedPtr, pPed, pPed + 0x90, 0, 1, joaat("weapon_stungun_mp"), 0.0, 0, 0, DF_IsAccurate | DF_IgnoreRemoteDistCheck, 0, 0, 0, 0, 0, 0, 0, 0.0)
	end)

	griefing:toggle("套汉堡车", {"pattywagon"}, "", function(toggled)
		local hamburgerMdl = joaat("xs_prop_hamburgher_wl")
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		if not IS_PED_IN_ANY_VEHICLE(ped) then
			toast(lang.get_localised(PLYNVEH):gsub("{}", players.get_name(playerID)))
			glitchveh.value = false
			util.stop_thread() 
		end
		local pos = players.get_position(playerID)
		pos.z -= 0.50
		local vehicle = GET_VEHICLE_PED_IS_USING(ped)
		util.request_model(hamburgerMdl)
		if toggled then
			if IS_PED_IN_ANY_VEHICLE(ped) then
				hamburger = entities.create_object(hamburgerMdl, pos)
				SET_ENTITY_COLLISION(hamburger, false, true)
				entities.set_can_migrate(hamburger, false)
				ATTACH_ENTITY_TO_ENTITY(hamburger, vehicle, 0, 0.0, 0.0, -0.50, v3(), false, false, true, false, 0, false, false)
			end
		else
			if hamburger == nil or not DOES_ENTITY_EXIST(hamburger) then
				toast("汉堡包消失 :/")
				return
			end
			entities.delete(hamburger)
		end
	end)
	
	griefing:action("套汉堡包", {"hamburger"}, "汉堡王", function()
		local hamburgerMdl = joaat("xs_prop_hamburgher_wl")
		local pos = players.get_position(playerID)
		pos.z -= 0.50
		util.request_model(hamburgerMdl)
		local hamburger = entities.create_object(hamburgerMdl, pos)
		entities.set_can_migrate(hamburger, false)
		yield(60000)
		entities.delete(hamburger)
	end)

	antigodmode:toggle_loop("移除无敌", {}, lang.get_localised(-748077967), function()
		util.trigger_script_event(1 << playerID, {800157557, players.user(), 225624744, math.random(0, 9999)})
	end)

	antigodmode:action("击杀无敌", {"killgod", "modkill"}, lang.get_localised(-748077967), function()
		if IS_PLAYER_DEAD(playerID) then return end
		if IS_REMOTE_PLAYER_IN_NON_CLONED_VEHICLE(playerID)then
            toast($"{players.get_name(playerID)} 人物尚未被克隆 :/")
            return
        end

        if not isPlayerGodmode(playerID) then 
            toast($"{players.get_name(playerID)} 不是无敌或正在使用反检测 :/")
            return 
        end
		godKill(playerID)
    end)

	local isGodmodeRemovable = {}
	antigodmode:action("打击玩家", {"orbgod"}, lang.get_localised(-748077967), function()
		local timer = util.current_time_millis() + 3500
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local vehicle = GET_VEHICLE_PED_IS_USING(ped)
		if IS_PLAYER_DEAD(playerID) then return end
		if IS_REMOTE_PLAYER_IN_NON_CLONED_VEHICLE(playerID)then
            toast($"{players.get_name(playerID)} 人物尚未被克隆 :/")
            return
        end

        if not isPlayerGodmode(playerID) then 
            toast($"{players.get_name(playerID)} 不是无敌或正在使用反检测 :/")
            return 
        end
		
		repeat
			toast("删除无敌...")
			if util.current_time_millis() > timer then
				toast($"删除失败 {players.get_name(playerID)} 无敌 :/")
				return
			end
			util.trigger_script_event(1 << playerID, {800157557, players.user(), 225624744, math.random(0, 9999)})
			yield()
		until not players.is_godmode(playerID)
		isGodmodeRemovable[playerID] = true

		if isGodmodeRemovable[playerID] then
			toast("天基打击...")
			if isPlayerInAnyVehicle(playerID) and entities.is_invulnerable(vehicle) then
				entities.request_control(vehicle, 2500)
				SET_ENTITY_CAN_BE_DAMAGED(vehicle, true)
				SET_ENTITY_INVINCIBLE(vehicle, false)
				SET_ENTITY_PROOFS(vehicle, false, false, false, false, false, false, false, false)
			end

			setBit(memory.script_global(GlobalplayerBD + 1 + (players.user() * 465) + 426), 0)
			yield(500) -- yielding so their game realizes I'm using the orb
			local pos = players.get_position(playerID)
			ADD_OWNED_EXPLOSION(players.user_ped(), pos, 59, 1.0, true, false, 1.0)
			USE_PARTICLE_FX_ASSET("scr_xm_orbital")
			START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_xm_orbital_blast", pos, v3(), 1.0, false, false, false, true)
			PLAY_SOUND_FROM_COORD(0, "DLC_XM_Explosions_Orbital_Cannon", pos, 0, true, 0, false) -- hardcoding sound id because GET_SOUND_ID doesnt work sometimes
			godKill(playerID)
			yield(1000) -- yielding here isnt needed but it gives yourself the notification that you orbed them
			clearBit(memory.script_global(GlobalplayerBD + 1 + (players.user() * 465) + 426), 0)
			yield(3000)
			STOP_SOUND(0)
			isGodmodeRemovable[playerID] = false
		end
    end)

	antigodmode:action("送医玩家", {"hospitalizegod"}, $"假装是天基炮并将他们传送到医院 {lang.get_localised(-748077967)}", function()
        local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		if IS_PLAYER_DEAD(playerID) then return end

        if not isPlayerGodmode(playerID) then 
            toast($"{players.get_name(playerID)} 不是无敌或正在使用反检测 :/")
            return 
        end
        
		setBit(memory.script_global(GlobalplayerBD + 1 + (players.user() * 465) + 426), 0)
		godKill(playerID)
		clearBit(memory.script_global(GlobalplayerBD + 1 + (players.user() * 465) + 426), 0)
    end)

	antigodmode:action("压扁杀", {"squish"}, "对部分菜单有效且没开启不可摔倒", function()
		local khanjali = joaat("khanjali")
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local heading =  GET_ENTITY_HEADING(ped)
		local pos = players.get_position(playerID)
		util.request_model(khanjali)
		distance = IS_PED_STILL(ped) ? 0.0 : 2.5

		local vehicle1 = entities.create_vehicle(khanjali, GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, distance, 2.8), heading)
		local vehicle2 = entities.create_vehicle(khanjali, pos, 0)
		local vehicle3 = entities.create_vehicle(khanjali, pos, 0)
		local vehicle4 = entities.create_vehicle(khanjali, pos, 0)
		local spawned_vehs = {vehicle1, vehicle2, vehicle3, vehicle4}
		for spawned_vehs as vehicle do
			entities.set_can_migrate(vehicle, false)
			SET_ENTITY_VISIBLE(vehicle, false)
		end
		ATTACH_ENTITY_TO_ENTITY(vehicle2, vehicle1, 0.0, 0.0, 3.0, v3(), -180.0, 0, false, true, false, 0, true, false)
		ATTACH_ENTITY_TO_ENTITY(vehicle3, vehicle1, 0.0, 3.0, 3.0, v3(), -180.0, 0, false, true, false, 0, true, false)
		ATTACH_ENTITY_TO_ENTITY(vehicle4, vehicle1, 0.0, 3.0, 0.0, v3(), 0.0, 0, false, true, false, 0, true, false)
		yield(6000)
		for spawned_vehs as vehicle do
			entities.delete(vehicle)
		end
	end) 

	antigodmode:action("地图杀", {"barrierkill"}, "对开启防止地图杀和高延迟的玩家无效", function()
		local windmill = joaat("prop_windmill_01")
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local pos = players.get_position(playerID)                            
		util.request_model(windmill)
		for i = 1, 5 do
			if IS_PED_WALKING(ped) then
				spawnPos = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 0.5, 0.0)
			elseif not IS_PED_WALKING(ped) then
				spawnPos = GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 1.3, 0.0)
			else
				spawnPos = players.get_position(playerID)
			end
			local obj = entities.create_object(windmill, spawnPos)
			SET_ENTITY_VISIBLE(obj, false)
			SET_ENTITY_INVINCIBLE(obj, true)
			SET_ENTITY_COLLISION(obj, true, true)
			yield(150)
			entities.delete(obj)
		end
	end)

	antigodmode:action("传送杀", {}, "", function()
		players.teleport_3d(playerID, -1141.5363, -2164.0615, 26.823051)
	end)

	antigodmode:toggle_loop("移除载具无敌", {}, lang.get_localised(-748077967), function()
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		if not IS_PED_IN_ANY_VEHICLE(ped) then
			toast(lang.get_localised(PLYNVEH):gsub("{}", players.get_name(playerID)))
			glitchveh.value = false
			util.stop_thread() 
		end
		local vehicle = GET_VEHICLE_PED_IS_USING(ped)
		entities.request_control(vehicle, 2500)
		if IS_PED_IN_ANY_VEHICLE(ped) and not IS_PLAYER_DEAD(ped) then
			SET_ENTITY_CAN_BE_DAMAGED(vehicle, true)
			SET_ENTITY_INVINCIBLE(vehicle, false)
			SET_ENTITY_PROOFS(vehicle, false, false, false, false, false, false, false, false)
		end
	end)

	local missionWarp = tpPlayer:list("任务传送", {}, lang.get_localised(-748077967))
	for missionType, warpName in freemodeMissionWarps do
		missionWarp:action(warpName, {}, "", function()
			util.trigger_script_event(1 << playerID, {1450115979, players.user(), missionType, -1})
		end)
	end

	local interiorTP = tpPlayer:list("室内传送", {}, lang.get_localised(-748077967))
	for id, interior in interiorTpList do
		interiorTP:action(interior, {}, "", function()
			util.trigger_script_event(1 << playerID, {-1638522928, players.user(), id, 1, 0, 1, 1130429716, -1001012850, 1106067788, 0, 0, 1, 2123789977, 1, -1})
		end)
	end

	local missionEndTP = tpPlayer:list("地点传送", {}, lang.get_localised(-748077967))
	for id, location in missionEndTeleports do
		missionEndTP:action(location, {}, "", function()
			local handle = NETWORK_HASH_FROM_PLAYER_HANDLE(playerID)
			util.trigger_script_event(1 << playerID, {-1604421397, players.user(), id, 4, handle, 0, 0, 0, 1, 1})
		end)
	end

	tpPlayer:action("赌场动画", {}, "", function()
		triggerDistanceBasedTeleport(playerID, {-1951335381, 0, 0})
	end)
 
	tpPlayer:action("佩罗海滩", {}, "", function()
		triggerDistanceBasedTeleport(playerID, {1669592503, players.user(), 0, 0, 4, 0})
	end)
	
	tpPlayer:action("佩里科岛", {}, "", function()
		triggerDistanceBasedTeleport(playerID, {1669592503, players.user(), 0, 0, 3, 1})
	end)
	
	tpPlayer:action("佩里科岛", {}, "上岛动画", function()
		triggerDistanceBasedTeleport(playerID, {1669592503, players.user(), 0, 0, 5, 1})
	end)
	
	local aimbor
	aimbor = miscPlayer:toggle_loop("自瞄射击", {"aimbot"}, "", function()
		if playerID == players.user() then 
			toast(lang.get_localised(CMDOTH))
			aimbor.value = false
			return
		end

		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local pPed =  entities.handle_to_pointer(ped)
		local pedPtr = entities.handle_to_pointer(players.user_ped())
		local wpn = GET_SELECTED_PED_WEAPON(players.user_ped())
		local dmg = GET_WEAPON_DAMAGE(wpn, 0)
		local bones = {31086, 24816, 40269, 45509, 0, 51826, 58271}
		if IS_PLAYER_FREE_AIMING_AT_ENTITY(players.user(), ped) and IS_PED_SHOOTING(players.user_ped()) and not IS_ENTITY_A_GHOST(ped) then
			boneIndex = bones[math.random(#bones)]
			local boneCoords = GET_PED_BONE_COORDS(ped, boneIndex, 0.0, 0.0, 0.0)
			util.call_foreign_function(CWeaponDamageEventTrigger, pedPtr, pPed, boneCoords, 0, 1, wpn, dmg, 0, 0, DF_IsAccurate | DF_AllowHeadShot | DF_IgnoreRemoteDistCheck, 0, 0, 0, 0, 0, 0, 0, 0.0)
		end
	end)

	local triggerbor
	triggerbor = miscPlayer:toggle_loop("自动射击", {"triggerbot"}, "", function() -- this is not using CWeaponDamageEventTrigger because we want it to also miss every now and then
		if playerID == players.user() then 
			toast(lang.get_localised(CMDOTH))
			triggerbor.value = false
		end
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local wpn = GET_SELECTED_PED_WEAPON(players.user_ped())
		local dmg = ROUND(GET_WEAPON_DAMAGE(wpn, 0))
		local shotDelay = GET_WEAPON_TIME_BETWEEN_SHOTS(wpn)
		local wpnEnt = GET_CURRENT_PED_WEAPON_ENTITY_INDEX(players.user_ped(), false)
		local wpnCoords = GET_ENTITY_BONE_POSTION(wpnEnt, GET_ENTITY_BONE_INDEX_BY_NAME(wpnEnt, "gun_muzzle"))
		local bones = {31086, 24816, 40269, 45509, 0, 51826, 58271}
		if GET_ENTITY_ALPHA(ped) < 255 then return end
		if IS_PLAYER_FREE_AIMING_AT_ENTITY(players.user(), ped) and not IS_PED_RELOADING(players.user_ped()) then
			boneIndex = bones[math.random(#bones)]
			local pos = GET_PED_BONE_COORDS(ped, boneIndex, 0.0, 0.0, 0.0)
			SHOOT_SINGLE_BULLET_BETWEEN_COORDS(wpnCoords, pos, dmg, true, wpn, players.user_ped(), true, false, 10000.0)
			SET_CONTROL_VALUE_NEXT_FRAME(0, 24, 1.0) -- shooting manually after so it has the effect of you shooting to seem more legit despite there being nothing legit about this
			yield(shotDelay * 1000)
		end
	end)

	local vehAimbor
	vehAimbor = miscPlayer:toggle_loop("载具自瞄", {"vehicleaimbot"}, "载具导弹瞄准玩家", function()
		if playerID == players.user() then 
			toast(lang.get_localised(CMDOTH))
			vehAimbor.value = false
			return
		end
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		if not IS_PLAYER_DEAD(ped) and IS_CONTROL_PRESSED(0, 70) and GET_VEHICLE_HOMING_LOCKON_STATE(entities.get_user_vehicle_as_handle()) == 0 then
			SET_VEHICLE_SHOOT_AT_TARGET(players.user_ped(), ped, players.get_position(playerID))
		end
	end)

	local miscTutorialSession
	miscTutorialSession = miscPlayer:toggle_loop("指导战局", {"entertutorialsession"}, "如果玩家指导战局处于活动状态 则进入玩家指导战局", function()
		if playerID == players.user() then 
			toast(lang.get_localised(CMDOTH))
			miscTutorialSession.value = false
			return
		end

		if getTeamID(playerID) == nil or getInstanceID(playerID) == nil then 
			NETWORK_END_TUTORIAL_SESSION()
			toast($"{players.get_name(playerID)} 不在任何指导战局 :/")
			miscTutorialSession.value = false
			return 
		end
		
		if not NETWORK_ARE_PLAYERS_IN_SAME_TUTORIAL_SESSION(players.user(), playerID) then
			NETWORK_ALLOW_GANG_TO_JOIN_TUTORIAL_SESSION(getTeamID(playerID), getInstanceID(playerID))
			repeat
				yield()
			until getTeamID(playerID) == nil or getInstanceID(playerID) == nil
		end
		
	end, function()
		if NETWORK_IS_IN_TUTORIAL_SESSION() then
			NETWORK_END_TUTORIAL_SESSION()
		end
	end)

	local ghostPlayer
	ghostPlayer = miscPlayer:toggle_loop("幽灵玩家", {"ghost"}, "", function()
		if playerID == players.user() then 
			toast(lang.get_localised(CMDOTH))
			ghostPlayer.value = false
			return
		end
		if not players.exists(playerID) then
			ghostPlayer.value = false
			return
		end
		SET_REMOTE_PLAYER_AS_GHOST(playerID, true)
	end, function()
		SET_REMOTE_PLAYER_AS_GHOST(playerID, false)
	end)

	miscPlayer:toggle_loop("显示准线", {"aimlines"}, "", function()
		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local weapon_ent = GET_CURRENT_PED_WEAPON_ENTITY_INDEX(ped, false)
		local weapon_coords = GET_ENTITY_BONE_POSTION(weapon_ent, GET_ENTITY_BONE_INDEX_BY_NAME(weapon_ent, "gun_muzzle"))
		local inst = v3.new()
		v3.set(inst, players.get_cam_rot(playerID))
		local tmp = v3.toDir(inst)
		v3.set(inst, v3.get(tmp))
		v3.mul(inst, 1000)
		v3.set(tmp, players.get_cam_pos(playerID))
		v3.add(inst, tmp)
		if IS_PLAYER_FREE_AIMING(playerID) then
			DRAW_LINE(weapon_coords, inst, 255, 255, 255, 255)
		end
	end)

	local autoVehTP
	autoVehTP = miscPlayer:toggle_loop("传送驾驶", {"autovehtp"}, "自动传送到玩家载具里", function()
		if playerID == players.user() then 
			toast(lang.get_localised(CMDOTH))
			autoVehTP.value = false
			return
		end

		local ped = GET_PLAYER_PED_SCRIPT_INDEX(playerID)
		local vehicle = GET_VEHICLE_PED_IS_USING(ped)
		local veh_model = players.get_vehicle_model(playerID)
		local seat_count = GET_VEHICLE_MODEL_NUMBER_OF_SEATS(veh_model)
		if not ARE_ANY_VEHICLE_SEATS_FREE(vehicle) then return end
		if GET_VEHICLE_PED_IS_USING(players.user_ped()) != vehicle then
			for i = 0, seat_count -1 do
				local emptyseat = i
				for l = 1, 25 do
					SET_PED_INTO_VEHICLE(players.user_ped(), vehicle, emptyseat)
				end
			end
		end
	end)
end
local featureCreateEndTime = util.current_time_millis() - featureCreateStartTime
util.log($"[JinxScript.pluto] 创建功能 {featureCreateEndTime}ms")
players.add_command_hook(player)
util.log($"[JinxScript.pluto] 脚本加载 {(nativeFetchEndTime + sigscanEndTime + featureCreateEndTime)}ms")
