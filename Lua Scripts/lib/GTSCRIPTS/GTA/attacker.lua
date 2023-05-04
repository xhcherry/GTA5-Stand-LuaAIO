--GRANDTOURINGVIP
local gunner_weapon_lists = {
{"Heavy Sniper Mk II", "WEAPON_HEAVYSNIPER_MK2"},
{"Unholy Hellbringer", "WEAPON_RAYCARBINE"},
{"Combat MG", "weapon_combatmg"},
{"RPG", "weapon_rpg"}
}

lazer_entities = {}

function spawn_lazer(pid, gunner_weapon, collision)
    local player_peds =  PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(player_peds)
    pos.x = pos.x + math.random(-20, 20)
    pos.y = pos.y + math.random(-20, 20)
    pos.z = pos.z + math.random(20, 40)

    PED.SET_PED_RELATIONSHIP_GROUP_HASH(player_peds, util.joaat("PLAYER"))

    local lazer_hash = util.joaat("lazer")
    local ped_hash = util.joaat("S_M_Y_ArmyMech_01")
    STREAMING.REQUEST_MODEL(ped_hash)
    STREAMING.REQUEST_MODEL(lazer_hash)
    while not STREAMING.HAS_MODEL_LOADED(ped_hash) or not STREAMING.HAS_MODEL_LOADED(lazer_hash) do
        util.yield()
    end
    local lazer = entities.create_vehicle(lazer_hash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
    lazer_entities[#lazer_entities + 1] = lazer
    
    ENTITY.SET_ENTITY_INVINCIBLE(lazer, true)
    ENTITY.SET_ENTITY_VISIBLE(lazer, lazer_visible, 0)	
    VEHICLE.SET_VEHICLE_ENGINE_ON(lazer, true, true, true)
    VEHICLE.SET_HELI_BLADES_FULL_SPEED(lazer)
    VEHICLE.CONTROL_LANDING_GEAR(lazer, 3)    
    local pilots = entities.create_ped(5, ped_hash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
    lazer_entities[#lazer_entities + 1] = pilots
    
    PED.SET_PED_RELATIONSHIP_GROUP_HASH(pilots, util.joaat("ARMY"))
    ENTITY.SET_ENTITY_VISIBLE(pilots, lazer_visible, 0)
    PED.SET_PED_INTO_VEHICLE(pilots, lazer, -1)
    PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(pilots, true)

    PED.SET_PED_MAX_HEALTH(pilots, 500)
    ENTITY.SET_ENTITY_HEALTH(pilots, 500)
    ENTITY.SET_ENTITY_INVINCIBLE(pilots, true)
    TASK.TASK_COMBAT_HATED_TARGETS_AROUND_PED(pilots, 500, 0)

    local gunners = {}
    for i  = 1, 45 do
        gunners[i] = entities.create_ped(29, ped_hash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
        lazer_entities[#lazer_entities + 1] = gunners[i]
        PED.SET_PED_INTO_VEHICLE(gunners[i], lazer, i)
        WEAPON.GIVE_WEAPON_TO_PED(gunners[i], util.joaat(gunner_weapon) , 9999, false, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(gunners[i], 20, true)
        --PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(gunner[i], true)
        PED.SET_PED_MAX_HEALTH(gunners[i], 500)
        ENTITY.SET_ENTITY_HEALTH(gunners[i], 500)
        ENTITY.SET_ENTITY_INVINCIBLE(gunners[i], true)
        ENTITY.SET_ENTITY_VISIBLE(gunners[i], lazer_visible, 0)
        PED.SET_PED_SHOOT_RATE(gunners[i], 1000)
        PED.SET_PED_RELATIONSHIP_GROUP_HASH(gunners[i], util.joaat("ARMY"))
        TASK.TASK_COMBAT_HATED_TARGETS_AROUND_PED(gunners[i], 1000, 0)
    end

    util.create_tick_handler(function()
        PED.SET_RELATIONSHIP_BETWEEN_GROUPS(5, util.joaat("ARMY"), util.joaat("PLAYER"))
        PED.SET_RELATIONSHIP_BETWEEN_GROUPS(5, util.joaat("PLAYER"), util.joaat("ARMY"))
        PED.SET_RELATIONSHIP_BETWEEN_GROUPS(0, util.joaat("ARMY"), util.joaat("ARMY"))
    end)

    return pilot, lazer
    end