util.require_natives(1651208000)
require "lib.cqcqlib.natives"
require "lib.cqcqlib.cqcqlib"
require "lib.cqcqlib.menu"
require "lib.cqcqlib.natives1622613546"
util.require_natives(1627063482)
util.require_natives(1640181023)
util.require_natives(1660775568)
--------- Functions ---------





Group = {}
function Group:getSize(ID)
    local unkPtr, sizePtr = memory.alloc(1), memory.alloc(1)
    PED.GET_GROUP_SIZE(ID, unkPtr, sizePtr)
    return memory.read_int(sizePtr)
end

function Group:pushMember(ped)
    local groupID = PLAYER.GET_PLAYER_GROUP(players.user())
    local RelationGroupHash = util.joaat("rgFM_AiLike_HateAiHate")

    if not PED.IS_PED_IN_GROUP(ped) then
        PED.SET_PED_AS_GROUP_MEMBER(ped, groupID)
        PED.SET_PED_NEVER_LEAVES_GROUP(ped, true)
    end
    PED.SET_PED_RELATIONSHIP_GROUP_HASH(ped, RelationGroupHash)
    PED.SET_GROUP_SEPARATION_RANGE(groupID, 9999.0)
    --PED.SET_GROUP_FORMATION_SPACING(groupID, v3(1.0, 0.9, 3.0))
    --PED.SET_GROUP_FORMATION(groupID, self.formation)
end
local Bodyguard_options = menu.list(online, "保镖选项", {}, "")
function request_model(model)
	if STREAMING.IS_MODEL_VALID(model) and not STREAMING.HAS_MODEL_LOADED(model) then
		STREAMING.REQUEST_MODEL(model)
		while not STREAMING.HAS_MODEL_LOADED(model) do
			util.yield()
		end
	end
end
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
------------------
----- 保镖NPC -----
------------------
local Bodyguard_NPC_options = menu.list(Bodyguard_options, "保镖NPC", {}, "")

local npc_name_list_select = {
    { "富兰克林", {}, "" },
    { "麦克", {}, "" },
    { "崔佛", {}, "" },
    { "莱斯特", {}, "" },
    { "埃万保安", {}, "" },
    { "埃万重甲兵", {}, "" },
    { "越狱光头", {}, "" },
    { "吉米", {}, "麦克儿子" },
    { "崔西", {}, "麦克女儿" },
    { "阿曼达", {}, "麦克妻子" },
}
local npc_model_list_select = {
    "player_one",
    "player_zero",
    "player_two",
    "ig_lestercrest",
    "mp_m_avongoon",
    "u_m_y_juggernaut_01",
    "ig_rashcosvki",
    "ig_jimmydisanto",
    "ig_tracydisanto",
    "ig_amandatownley",
}
--生成保镖的默认设置
local bodyguard_npc_set = {
    model = "player_one",
    godmode = false,
    health = 1000,
    no_ragdoll = false,
    weapon = "WEAPON_MICROSMG",
    no_clip = false,
    see_hear_range = 500,
    accuracy = 100,
    shoot_rate = 1000,
    combat_ability = 2,
    combat_range = 2,
    combat_movement = 1,
    target_loss_response = 1,
    BF_PerfectAccuracy = false,
    BF_AlwaysEquipBestWeapon = false,
}
--生成的保镖
local bodyguard_npc_list = {}

menu.list_select(Bodyguard_NPC_options, "选择模型", {}, "", npc_name_list_select, 1, function(value)
    bodyguard_npc_set.model = npc_model_list_select[value]
end)

local Bodyguard_NPC_default_setting = menu.list(Bodyguard_NPC_options, "默认生成设置", {}, "")
menu.toggle(Bodyguard_NPC_default_setting, "无敌", {}, "", function(toggle)
    bodyguard_npc_set.godmode = toggle
end)
menu.slider(Bodyguard_NPC_default_setting, "生命", { "bodyguard_npc_health" }, "", 100, 30000, 1000, 100,
    function(value)
        bodyguard_npc_set.health = value
    end)
menu.toggle(Bodyguard_NPC_default_setting, "不会摔倒", {}, "", function(toggle)
    bodyguard_npc_set.no_ragdoll = toggle
end)
menu.list_select(Bodyguard_NPC_default_setting, "武器", {}, "", WeaponName_ListItem, 4, function(value)
    bodyguard_npc_set.weapon = WeaponModel_List[value]
end)
menu.toggle(Bodyguard_NPC_default_setting, "不换弹夹", {}, "", function(toggle)
    bodyguard_npc_set.no_clip = toggle
end)
menu.divider(Bodyguard_NPC_default_setting, "作战能力")
menu.slider(Bodyguard_NPC_default_setting, "视力听觉范围", { "bodyguard_npc_see_hear_range" }, "", 10, 1000, 500,
    100,
    function(value)
        bodyguard_npc_set.see_hear_range = value
    end)
menu.slider(Bodyguard_NPC_default_setting, "精确度", { "bodyguard_npc_accuracy" }, "", 0, 100, 100, 10,
    function(value)
        bodyguard_npc_set.accuracy = value
    end)
menu.slider(Bodyguard_NPC_default_setting, "射击频率", { "bodyguard_npc_shoot_rate" }, "", 0, 1000, 1000, 100,
    function(value)
        bodyguard_npc_set.shoot_rate = value
    end)
menu.list_select(Bodyguard_NPC_default_setting, "作战技能", {}, "", { { "弱" }, { "普通" }, { "专业" } }, 3,
    function(value)
        bodyguard_npc_set.combat_ability = value - 1
    end)
menu.list_select(Bodyguard_NPC_default_setting, "作战范围", {}, "", { { "近" }, { "中等" }, { "远" }, { "非常远" } }
    , 3, function(value)
    bodyguard_npc_set.combat_range = value - 1
end)
menu.list_select(Bodyguard_NPC_default_setting, "作战走位", {}, "", { { "站立" }, { "防卫" }, { "会前进" },
    { "会后退" } }, 2, function(value)
    bodyguard_npc_set.combat_movement = value - 1
end)
menu.list_select(Bodyguard_NPC_default_setting, "失去目标时反应", {}, "", { { "退出战斗" }, { "从不失去目标" },
    { "寻找目标" } }, 2, function(value)
    bodyguard_npc_set.target_loss_response = value - 1
end)
menu.divider(Bodyguard_NPC_default_setting, "作战属性")
menu.toggle(Bodyguard_NPC_default_setting, "完美精准度", {}, "", function(toggle)
    bodyguard_npc_set.BF_PerfectAccuracy = toggle
end)
menu.toggle(Bodyguard_NPC_default_setting, "总是装备最好的武器", {}, "", function(toggle)
    bodyguard_npc_set.BF_AlwaysEquipBestWeapon = toggle
end)
------
menu.action(Bodyguard_NPC_options, "生成保镖", {}, "", function()
    local groupID = PLAYER.GET_PLAYER_GROUP(players.user())
    if Group:getSize(groupID) >= 7 then
        notification("保镖人数已达到上限")
    else
        local modelHash = util.joaat(bodyguard_npc_set.model)
        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0.0, 2.0, 0.0)
        local heading = ENTITY.GET_ENTITY_HEADING(players.user_ped()) + 180
        local ped = Create_Network_Ped(26, modelHash, coords.x, coords.y, coords.z, heading)
        --BLIP
        local blip = HUD.ADD_BLIP_FOR_ENTITY(ped)
        HUD.SET_BLIP_SPRITE(blip, 271)
        HUD.SET_BLIP_COLOUR(blip, 3)
        HUD.SET_BLIP_SCALE(blip, 0.5)
        --INVINCIBLE
        ENTITY.SET_ENTITY_INVINCIBLE(ped, bodyguard_npc_set.godmode)
        ENTITY.SET_ENTITY_PROOFS(ped, bodyguard_npc_set.godmode, bodyguard_npc_set.godmode, bodyguard_npc_set.godmode,
            bodyguard_npc_set.godmode, bodyguard_npc_set.godmode, bodyguard_npc_set.godmode, bodyguard_npc_set.godmode,
            bodyguard_npc_set.godmode)
        --HEALTH
        ENTITY.SET_ENTITY_MAX_HEALTH(ped, bodyguard_npc_set.health)
        ENTITY.SET_ENTITY_HEALTH(ped, bodyguard_npc_set.health)
        --RAGDOLL
        PED.SET_PED_CAN_RAGDOLL(ped, not bodyguard_npc_set.no_ragdoll)
        C_PED.DISABLE_PED_INJURED_ON_GROUND_BEHAVIOUR(ped)
        PED.SET_PED_CAN_PLAY_AMBIENT_ANIMS(ped, false)
        PED.SET_PED_CAN_PLAY_AMBIENT_BASE_ANIMS(ped, false)
        --WEAPON
        local weapon_smoke = util.joaat("WEAPON_SMOKEGRENADE")
        WEAPON.GIVE_WEAPON_TO_PED(ped, weapon_smoke, -1, false, false)
        local weaponHash = util.joaat(bodyguard_npc_set.weapon)
        WEAPON.GIVE_WEAPON_TO_PED(ped, weaponHash, -1, false, true)
        WEAPON.SET_CURRENT_PED_WEAPON(ped, weaponHash, false)
        WEAPON.SET_PED_DROPS_WEAPONS_WHEN_DEAD(ped, false)
        PED.SET_PED_CAN_SWITCH_WEAPON(ped, true)
        WEAPON.SET_PED_INFINITE_AMMO_CLIP(ped, bodyguard_npc_set.no_clip)
        --PERCEPTIVE
        PED.SET_PED_SEEING_RANGE(ped, bodyguard_npc_set.see_hear_range)
        PED.SET_PED_HEARING_RANGE(ped, bodyguard_npc_set.see_hear_range)
        PED.SET_PED_ID_RANGE(ped, bodyguard_npc_set.see_hear_range)
        --PED.SET_PED_VISUAL_FIELD_PERIPHERAL_RANGE(bodyguard_npc_set.see_hear_range)
        PED.SET_PED_HIGHLY_PERCEPTIVE(ped, true)
        PED.SET_PED_VISUAL_FIELD_MIN_ANGLE(ped, 90.0)
        PED.SET_PED_VISUAL_FIELD_MAX_ANGLE(ped, 90.0)
        PED.SET_PED_VISUAL_FIELD_MIN_ELEVATION_ANGLE(ped, 90.0)
        PED.SET_PED_VISUAL_FIELD_MAX_ELEVATION_ANGLE(ped, 90.0)
        PED.SET_PED_VISUAL_FIELD_CENTER_ANGLE(ped, 90.0)
        --COMBAT
        PED.SET_PED_COMBAT_ABILITY(ped, bodyguard_npc_set.combat_ability)
        PED.SET_PED_COMBAT_RANGE(ped, bodyguard_npc_set.combat_range)
        PED.SET_PED_COMBAT_MOVEMENT(ped, bodyguard_npc_set.combat_movement)
        PED.SET_PED_TARGET_LOSS_RESPONSE(ped, bodyguard_npc_set.target_loss_response)
        --COMBAT ATTRIBUTES
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 0, true) --Use Cover
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 1, true) --Use Vehicle
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 4, true) --Can Use Dynamic Strafe Decisions
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true) --Always Fight
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 13, true) --Aggressive
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 17, false) --Always Flee
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 20, true) --Can Taunt In Vehicle
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 21, true) --Can Chase Target On Foot
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 24, true) --Use Proximity Firing Rate
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 39, true) --Can Bust
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 41, true) --Can Commandeer Vehicles
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 42, true) --Can Flank
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true) --Can Fight Armed Peds When Not Armed
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 49, false) --Use Enemy Accuracy Scaling
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 52, true) --Use Vehicle Attack
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 53, true) --Use Vehicle Attack If Vehicle Has Mounted Guns
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 55, true) --Can See Underwater Peds
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 58, true) --Disable Flee From Combat
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 60, true) --Can Throw Smoke Grenade
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 78, true) --Disable All Randoms Flee

        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 27, bodyguard_npc_set.BF_PerfectAccuracy) --Perfect Accuracy
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 54, bodyguard_npc_set.BF_AlwaysEquipBestWeapon) --Always Equip Best Weapon
        --TASK
        TASK.SET_PED_PATH_CAN_USE_CLIMBOVERS(ped, true)
        TASK.SET_PED_PATH_CAN_USE_LADDERS(ped, true)
        TASK.SET_PED_PATH_CAN_DROP_FROM_HEIGHT(ped, true)
        TASK.SET_PED_PATH_AVOID_FIRE(ped, false)
        TASK.SET_PED_PATH_MAY_ENTER_WATER(ped, true)

        ----
        Group:pushMember(ped)
        table.insert(bodyguard_npc_list, ped)
    end
end)

menu.divider(Bodyguard_NPC_options, "管理保镖")
menu.toggle(Bodyguard_NPC_options, "所有保镖无敌", {}, "", function(toggle)
    for k, ent in pairs(bodyguard_npc_list) do
        if ENTITY.DOES_ENTITY_EXIST(ent) then
            ENTITY.SET_ENTITY_INVINCIBLE(ent, toggle)
            ENTITY.SET_ENTITY_PROOFS(ent, toggle, toggle, toggle, toggle, toggle, toggle, toggle, toggle)
        end
    end
end)
menu.list_action(Bodyguard_NPC_options, "给予所有保镖武器", {}, "", WeaponName_ListItem, function(value)
    for k, ent in pairs(bodyguard_npc_list) do
        if ENTITY.DOES_ENTITY_EXIST(ent) then
            local weaponHash = util.joaat(WeaponModel_List[value])
            WEAPON.GIVE_WEAPON_TO_PED(ent, weaponHash, -1, false, true)
            WEAPON.SET_CURRENT_PED_WEAPON(ent, weaponHash, false)
        end
    end
end)
menu.action(Bodyguard_NPC_options, "所有保镖传送到我", {}, "", function()
    local y = 2.0
    for k, ent in pairs(bodyguard_npc_list) do
        if ENTITY.DOES_ENTITY_EXIST(ent) then
            TP_TO_ME(ent, 0.0, y, 0.0)
            SET_ENTITY_HEAD_TO_ENTITY(ent, players.user_ped(), 180.0)
            y = y + 1.0
        end
    end
end)
menu.action(Bodyguard_NPC_options, "删除已死亡保镖", {}, "", function()
    for k, ent in pairs(bodyguard_npc_list) do
        if ENTITY.DOES_ENTITY_EXIST(ent) then
            if ENTITY.IS_ENTITY_DEAD(ent) then
                entities.delete_by_handle(ent)
                table.remove(bodyguard_npc_list, k)
            end
        end
    end
end)
menu.action(Bodyguard_NPC_options, "删除所有保镖", {}, "", function()
    for k, ent in pairs(bodyguard_npc_list) do
        if ENTITY.DOES_ENTITY_EXIST(ent) then
            entities.delete_by_handle(ent)
        end
    end
    bodyguard_npc_list = {} --生成的保镖
end)


--------------------
----- 保镖直升机 -----
--------------------
local Bodyguard_Heli_options = menu.list(Bodyguard_options, "保镖直升机", {}, "")

local heli_list = {} --生成的直升机
local heli_ped_list = {} --直升机内的保镖

local bodyguard_heli = {
    name = "valkyrie",
    heli_godmode = false,
    ped_godmode = false
}

local heli_name_list_select = {
    { "女武神" },
    { "秃鹰" },
    { "猎杀者" },
    { "警用小蛮牛" },
}
local heli_model_list_select = {
    "valkyrie", "buzzard", "hunter", "polmav"
}
menu.list_select(Bodyguard_Heli_options, "直升机类型", {}, "", heli_name_list_select, 1,
    function(value)
        bodyguard_heli.name = heli_model_list_select[value]
    end)

menu.toggle(Bodyguard_Heli_options, "直升机无敌", {}, "", function(toggle)
    bodyguard_heli.heli_godmode = toggle
end)
function Create_Network_Ped(pedType, modelHash, x, y, z, heading)
    request_model(modelHash)
    local ped = PED.CREATE_PED(pedType, modelHash, x, y, z, heading, true, true)

    ENTITY.SET_ENTITY_LOAD_COLLISION_FLAG(ped, true, 1)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ped, true, false)
    C_CCENTITY.SET_ENTITY_SHOULD_FREEZE_WAITING_ON_COLLISION(ped, true)

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

menu.action(Bodyguard_Heli_options, "生成保镖直升机", {}, "", function()
    local heli_hash = util.joaat(bodyguard_heli.name)
    local ped_hash = util.joaat("s_m_y_blackops_01")
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    pos.x = pos.x + math.random(-10, 10)
    pos.y = pos.y + math.random(-10, 10)
    pos.z = pos.z + 30

    request_model(ped_hash)
    request_model(heli_hash)
    Relationship:friendly(players.user_ped())
    local heli = entities.create_vehicle(heli_hash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)

    if not ENTITY.DOES_ENTITY_EXIST(heli) then
        notification("Failed to create vehicle. Please try again")
        return
    else
        local heliNetId = NETWORK.VEH_TO_NET(heli)
        if NETWORK.NETWORK_GET_ENTITY_IS_NETWORKED(NETWORK.NET_TO_PED(heliNetId)) then
            NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(heliNetId, true)
            NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(heliNetId, players.user(), true)
        end
        VEHICLE.SET_VEHICLE_ENGINE_ON(heli, true, true, true)
        VEHICLE.SET_HELI_BLADES_FULL_SPEED(heli)
        VEHICLE.SET_VEHICLE_SEARCHLIGHT(heli, true, true)
        add_blip_for_entity(heli, 422, 26)
        --health
        ENTITY.SET_ENTITY_INVINCIBLE(heli, bodyguard_heli.heli_godmode)
        ENTITY.SET_ENTITY_MAX_HEALTH(heli, 10000)
        ENTITY.SET_ENTITY_HEALTH(heli, 10000)

        table.insert(heli_list, heli)
    end

    local pilot = entities.create_ped(29, ped_hash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
    PED.SET_PED_INTO_VEHICLE(pilot, heli, -1)
    PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(pilot, true)
    TASK.TASK_HELI_MISSION(pilot, heli, 0, players.user_ped(), 0.0, 0.0, 0.0, 23, 80.0, 50.0, -1.0, 0, 10, -1.0, 0)
    PED.SET_PED_KEEP_TASK(pilot, true)

    PED.SET_PED_HIGHLY_PERCEPTIVE(pilot, true)
    PED.SET_PED_VISUAL_FIELD_PERIPHERAL_RANGE(pilot, 500.0)
    PED.SET_PED_SEEING_RANGE(pilot, 500.0)
    PED.SET_PED_HEARING_RANGE(pilot, 500.0)
    PED.SET_PED_ID_RANGE(pilot, 500.0)

    PED.SET_PED_COMBAT_MOVEMENT(pilot, 1) --Defensive
    PED.SET_PED_COMBAT_ABILITY(pilot, 2) --Professional
    PED.SET_PED_COMBAT_RANGE(pilot, 1) --Medium
    PED.SET_PED_TARGET_LOSS_RESPONSE(pilot, 1) --NeverLoseTarget

    PED.SET_COMBAT_FLOAT(pilot, 10, 500.0)
    PED.SET_PED_CAN_BE_SHOT_IN_VEHICLE(pilot, false)
    --health
    PED.SET_PED_MAX_HEALTH(pilot, 10000)
    ENTITY.SET_ENTITY_HEALTH(pilot, 10000)
    ENTITY.SET_ENTITY_INVINCIBLE(pilot, bodyguard_heli.ped_godmode)

    Relationship:friendly(pilot)
    table.insert(heli_ped_list, pilot)

    local seats = VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(heli_hash) - 2
    for seat = 0, seats do
        local ped = entities.create_ped(29, ped_hash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
        local pedNetId = NETWORK.PED_TO_NET(ped)
        if NETWORK.NETWORK_GET_ENTITY_IS_NETWORKED(ped) then
            NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(pedNetId, true)
            NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(pedNetId, players.user(), true)
        end
        PED.SET_PED_INTO_VEHICLE(ped, heli, seat)
        --fight
        WEAPON.GIVE_WEAPON_TO_PED(ped, util.joaat("weapon_mg"), -1, false, true)
        WEAPON.SET_PED_INFINITE_AMMO_CLIP(ped, true)
        PED.SET_PED_SHOOT_RATE(ped, 1000)
        PED.SET_PED_ACCURACY(ped, 100)

        PED.SET_PED_HIGHLY_PERCEPTIVE(ped, true)
        PED.SET_PED_VISUAL_FIELD_PERIPHERAL_RANGE(ped, 500.0)
        PED.SET_PED_SEEING_RANGE(ped, 500.0)
        PED.SET_PED_HEARING_RANGE(ped, 500.0)
        PED.SET_PED_VISUAL_FIELD_MIN_ANGLE(ped, 90.0)
        PED.SET_PED_VISUAL_FIELD_MAX_ANGLE(ped, 90.0)
        PED.SET_PED_VISUAL_FIELD_MIN_ELEVATION_ANGLE(ped, 90.0)
        PED.SET_PED_VISUAL_FIELD_MAX_ELEVATION_ANGLE(ped, 90.0)
        PED.SET_PED_VISUAL_FIELD_CENTER_ANGLE(ped, 90.0)

        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 0, true) --CanUseCover
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 1, true) --CanUseVehicles
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 2, true) --CanDoDrivebys
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 3, false) --CanLeaveVehicle
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true) --AlwaysFight
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 12, true) --BlindFireWhenInCover
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 13, true) --Aggressive
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 20, true) --CanTauntInVehicle
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 21, true) --CanChaseTargetOnFoot
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 27, true) --PerfectAccuracy
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 41, true) --CanCommandeerVehicles
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true) --CanFightArmedPedsWhenNotArmed
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 55, true) --CanSeeUnderwaterPeds
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 58, true) --DisableFleeFromCombat

        PED.SET_PED_COMBAT_MOVEMENT(ped, 1) --Defensive
        PED.SET_PED_COMBAT_ABILITY(ped, 2) --Professional
        PED.SET_PED_COMBAT_RANGE(ped, 2) --Far
        PED.SET_PED_TARGET_LOSS_RESPONSE(ped, 1) --NeverLoseTarget

        PED.SET_COMBAT_FLOAT(ped, 10, 500.0)
        PED.SET_PED_CAN_BE_SHOT_IN_VEHICLE(ped, false)
        --health
        PED.SET_PED_MAX_HEALTH(ped, 1000)
        ENTITY.SET_ENTITY_HEALTH(ped, 1000)
        ENTITY.SET_ENTITY_INVINCIBLE(ped, bodyguard_heli.ped_godmode)

        Relationship:friendly(ped)
        table.insert(heli_ped_list, ped)
    end

    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(heli_hash)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(ped_hash)
end)

menu.divider(Bodyguard_Heli_options, "管理保镖直升机")
menu.toggle(Bodyguard_Heli_options, "所有保镖直升机无敌", {}, "", function(toggle)
    for k, ent in pairs(heli_ped_list) do
        if ENTITY.DOES_ENTITY_EXIST(ent) then
            ENTITY.SET_ENTITY_INVINCIBLE(ent, toggle)
        end
    end
    for k, ent in pairs(heli_list) do
        if ENTITY.DOES_ENTITY_EXIST(ent) then
            ENTITY.SET_ENTITY_INVINCIBLE(ent, toggle)
        end
    end
end)
menu.action(Bodyguard_Heli_options, "所有保镖直升机传送到我", {}, "", function()
    for k, ent in pairs(heli_list) do
        if ENTITY.DOES_ENTITY_EXIST(ent) then
            TP_TO_ME(ent, math.random(-10, 10), math.random(-10, 10), 30)
        end
    end
end)
menu.action(Bodyguard_Heli_options, "删除所有保镖直升机", {}, "", function()
    for k, ent in pairs(heli_ped_list) do
        if ENTITY.DOES_ENTITY_EXIST(ent) then
            entities.delete_by_handle(ent)
        end
    end
    for k, ent in pairs(heli_list) do
        if ENTITY.DOES_ENTITY_EXIST(ent) then
            entities.delete_by_handle(ent)
        end
    end
    heli_list = {} --生成的直升机
    heli_ped_list = {} --直升机内的保镖
end)