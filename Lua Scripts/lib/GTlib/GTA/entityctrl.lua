RS_T = {

    CommonWeapons = {
        { util.joaat("WEAPON_KNIFE"), "小刀" },
        { util.joaat("WEAPON_APPISTOL"), "穿甲手枪" },
        { util.joaat("WEAPON_STUNGUN"), "电击枪" },
        { util.joaat("WEAPON_MICROSMG"), "微型冲锋枪" },
        { util.joaat("WEAPON_SPECIALCARBINE"), "特质卡宾步枪" },
        { util.joaat("WEAPON_ASSAULTSHOTGUN"), "突击霰弹枪" },
        { util.joaat("WEAPON_MINIGUN"), "火神机枪" },
        { util.joaat("WEAPON_RPG"), "火箭筒" },
        { util.joaat("WEAPON_RAILGUN"), "电磁步枪" },
    }
}

Vehicle_T = {

    DoorLockStatus = {
        [0] = "None",
        [1] = "Unlocked",
        [2] = "Locked",
        [3] = "Lockout Player Only",
        [4] = "Locked Player Inside",
        [5] = "Locked Initially",
        [6] = "Force Shut Doors",
        [7] = "Locked But Can Be Damaged",
        [8] = "Locked But Boot Unlocked",
        [9] = "Locked No Passengers",
        [10] = "Cannot Enter",
    }
}
Misc_T = {

    EntityTypeAll = {
        { 1, "All", {}, "全部类型实体" },
        { 2, "Ped", {}, "NPC" },
        { 3, "Vehicle", {}, "载具" },
        { 4, "Object", {}, "物体" },
        { 5, "Pickup", {}, "拾取物" }
    },

    ExplosionType = {
        { -1, "Dont Care" },
        { 0,  "Grenade" },
        { 1,  "Grenade Launcher" },
        { 2,  "Sticky Bomb" },
        { 3,  "Molotov" },
        { 4,  "Rocket" },
        { 5,  "Tank Shell" },
        { 6,  "Hi Octane" },
        { 7,  "Car" },
        { 8,  "Plane" },
        { 9,  "Petrol Pump" },
        { 10, "Bike" },
        { 11, "Steam" },
        { 12, "Flame" },
        { 13, "Water Hydrant" },
        { 14, "Gas Canister Flame" },
        { 15, "Boat" },
        { 16, "Ship" },
        { 17, "Truck" },
        { 18, "Bullet" },
        { 19, "Smoke Grenade Launcher" },
        { 20, "Smoke Grenade" },
        { 21, "BZ Gas" },
        { 22, "Flare" },
        { 23, "Gas Canister" },
        { 24, "Extinguisher" },
        { 25, "Programmable AR" },
        { 26, "Train" },
        { 27, "Barrel (Blue)" },
        { 28, "Propane" },
        { 29, "Blimp" },
        { 30, "Flame Explode" },
        { 31, "Tanker" },
        { 32, "Plane Rocket" },
        { 33, "Vehicle Bullet" },
        { 34, "Gas Tank" },
        { 35, "Bird Crap" },
        { 36, "Railgun" },
        { 37, "Blimp (Red & Cyan)" },
        { 38, "Firework" },
        { 39, "Snowball" },
        { 40, "Proximity Mine" },
        { 41, "Valkyrie Cannon" },
        { 42, "Air Defence" },
        { 43, "Pipe Bomb" },
        { 44, "Vehicle Mine" },
        { 45, "Explosive Ammo" },
        { 46, "APC Shell" },
        { 47, "Cluster Bomb" },
        { 48, "Gas Bomb" },
        { 49, "Incendiary Bomb" },
        { 50, "Standard Bomb" },
        { 51, "Torpedo" },
        { 52, "Torpedo (Underwater)" },
        { 53, "Bombushka Cannon" },
        { 54, "Cluster Bomb 2" },
        { 55, "Hunter Barrage" },
        { 56, "Hunter Cannon" },
        { 57, "Rogue Cannon" },
        { 58, "Underwater Mine" },
        { 59, "Orbital Cannon" },
        { 60, "Standard Bomb (Wide)" },
        { 61, "Explosive Ammo (Shotgun)" },
        { 62, "Oppressor Mk2 Cannon" },
        { 63, "Kinetic Mortar" },
        { 64, "Kinetic Vehicle Mine" },
        { 65, "Emp Vehicle Mine" },
        { 66, "Spike Vehicle Mine" },
        { 67, "Slick Vehicle Mine" },
        { 68, "Tar Vehicle Mine" },
        { 69, "Script Drone" },
        { 70, "Raygun" },
        { 71, "Buried Mine" },
        { 72, "Script Missile" },
        { 73, "RC Tank Rocket" },
        { 74, "Water Bomb" },
        { 75, "Water Bomb 2" },
        { 76, "Cnc Spike Mine" },
        { 77, "BZ Gas Mk2" },
        { 78, "Flash Grenade" },
        { 79, "Stun Grenade" },
        { 80, "Cnc Kinetic Ram" },
        { 81, "Large Missile" },
        { 82, "Big Submarine" },
        { 83, "Emp Launcher" },
        { 84, "Railgun XM3" },
        { 85, "Balanced Cannons" }
    }

}

Loop_Handler = {
    Main = {},
    Self = {},
    Tunables = {
        Cooldown = {},
        SpecialCargo = {},
        VehicleCargo = {},
        Bunker = {},
        AirFreight = {},
        Biker = {},
        AcidLab = {},
        Payphone = {},
    },
    Entity = {
        show_info = {},
        draw_line = {},
        draw_bounding_box = {},
        preview_ent = {
            ent = 0,
            clone_ent = 0,
            has_cloned_ent = 0,
            camera_distance = 2.0,
        },
        lock_tp = {},
    },
}
--
tEntityControl = {
    entityType = "All",
}

function tEntityControl.GenerateMenuHead(menu_parent, entity)
    menu.action(menu_parent, "检测该实体是否存在", {}, "", function()
        if ENTITY.DOES_ENTITY_EXIST(entity) then
            util.toast("实体存在")
        else
            util.toast("该实体已经不存在，请删除此条实体记录！")
        end
    end)

    menu.action(menu_parent, "删除此条实体记录", {}, "", function()
        tEntityControl.entity_menu_list[entity] = nil
        tEntityControl.entity_list[entity] = nil

        tEntityControl.entity_count = tEntityControl.entity_count - 1
        if tEntityControl.entity_count <= 0 then
            tEntityControl.ClearListData()
        else
            menu.set_menu_name(tEntityControl.count_divider,
                "实体列表 (" .. tEntityControl.entity_count .. ")")
        end

        menu.delete(menu_parent)
    end)
end


function tEntityControl.InitListData()

    tEntityControl.entity_list = {}

    tEntityControl.entity_menu_list = {}

    tEntityControl.entity_index = 1

    tEntityControl.entity_count = 0
end

tEntityControl.InitListData()


function tEntityControl.ClearListData()

    for k, v in pairs(tEntityControl.entity_menu_list) do
        if v ~= nil and menu.is_ref_valid(v) then
            menu.delete(v)
        end
    end

    tEntityControl.InitListData()
    menu.set_menu_name(tEntityControl.count_divider, "实体列表")
end
function Loop_Handler.Entity.ClearToggles()
    Loop_Handler.Entity.draw_line.toggle = false
    Loop_Handler.Entity.show_info.toggle = false
    Loop_Handler.Entity.draw_bounding_box.toggle = false
    Loop_Handler.Entity.lock_tp.toggle = false
    Loop_Handler.Entity.preview_ent.toggle = false
end

function get_entity_type(entity, text_type)
    local entity_type = "No Entity"
    if ENTITY.DOES_ENTITY_EXIST(entity) and ENTITY.IS_AN_ENTITY(entity) then
        if ENTITY.IS_ENTITY_A_PED(entity) then
            entity_type = "Ped"
        elseif ENTITY.IS_ENTITY_A_VEHICLE(entity) then
            entity_type = "Vehicle"
        elseif ENTITY.IS_ENTITY_AN_OBJECT(entity) then
            entity_type = "Object"
            if OBJECT.IS_OBJECT_A_PICKUP(entity) or OBJECT.IS_OBJECT_A_PORTABLE_PICKUP(entity) then
                entity_type = "Pickup"
            end
        end
    end

    if text_type == 1 then
        return string.lower(entity_type)
    end
    if text_type == 3 then
        return string.upper(entity_type)
    end
    return entity_type
end

menu.toggle_loop(Entity_Control_Options, "控制目标实体[E键]", {}, "", function()
    --Loop_Handler.draw_centred_point(true)

    local result = get_raycast_result(1500, -1)
    if result.didHit then
        local player_pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
        local draw_line_colour = { r = 255, g = 0, b = 255, a = 255 }

        local ent = result.hitEntity
        local ent_type = get_entity_type(ent)
        if ent_type ~= "No Entity" then
            draw_line_colour = { r = 0, g = 255, b = 0, a = 255 }
        end
        DRAW_LINE(player_pos, result.endCoords, draw_line_colour)


        if PAD.IS_CONTROL_PRESSED(0, 51) then
            if ent_type ~= "No Entity" then
                if tEntityControl.entityType ~= "All" and tEntityControl.entityType ~= ent_type then
                    return
                end

                if tEntityControl.entity_list[ent] == nil then
               
                    tEntityControl.entity_list[ent] = ent

                    local menu_name, help_text = Entity_Control.GetMenuInfo(ent, tEntityControl.entity_index)
                    util.toast(menu_name .. "\n" .. help_text)

                
                    local menu_list = menu.list(Entity_Control_Options, menu_name, {}, help_text)
                    tEntityControl.entity_menu_list[ent] = menu_list

                 
                    tEntityControl.GenerateMenuHead(menu_list, ent)
                    Entity_Control.GenerateMenu(menu_list, ent, tEntityControl.entity_index)

                    tEntityControl.entity_index = tEntityControl.entity_index + 1 

                 
                    tEntityControl.entity_count = tEntityControl.entity_count + 1
                    if tEntityControl.entity_count == 0 then
                        menu.set_menu_name(tEntityControl.count_divider, "实体列表")
                    else
                        menu.set_menu_name(tEntityControl.count_divider,
                            "实体列表 (" .. tEntityControl.entity_count .. ")")
                    end
                end
            end
        end
    end
end, function()
    --Loop_Handler.draw_centred_point(false)
end)

menu.list_select(Entity_Control_Options, "实体类型", {}, "", Misc_T.EntityTypeAll, 1, function(index, name)
    tEntityControl.entityType = name
end)

menu.action(Entity_Control_Options, "清空列表", {}, "", function()
    tEntityControl.ClearListData()
    Loop_Handler.Entity.ClearToggles()
end)

tEntityControl.count_divider = menu.divider(Entity_Control_Options, "实体列表")

--func

ALL_BLIPS_NUMBER = 866
function user_heading(heading)
    local ent = entities.get_user_vehicle_as_handle(false)
    if ent == INVALID_GUID then
        ent = players.user_ped()
    end

    if heading ~= nil then
        ENTITY.SET_ENTITY_HEADING(ent, heading)
        return heading
    end
    return ENTITY.GET_ENTITY_HEADING(ent)
end
function get_vehicle_peds(vehicle)
    local num = 0
    local peds = {}
    if ENTITY.IS_ENTITY_A_VEHICLE(vehicle) then
        local seats = VEHICLE.GET_VEHICLE_MAX_NUMBER_OF_PASSENGERS(vehicle)
        for i = -1, seats - 1 do
            if not VEHICLE.IS_VEHICLE_SEAT_FREE(vehicle, i, false) then
                local ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, i)

                num = num + 1
                table.insert(peds, ped)
            end
        end
    end
    return num, peds
end
function upgrade_vehicle(vehicle)
    if not ENTITY.IS_ENTITY_A_VEHICLE(vehicle) then
        return
    end

    VEHICLE.SET_VEHICLE_MOD_KIT(vehicle, 0)
    for i = 0, 50 do
        if i ~= 48 and i ~= 23 and i ~= 24 then
            local mod_num = VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, i)
            if mod_num > 0 then
                VEHICLE.SET_VEHICLE_MOD(vehicle, i, mod_num - 1, false)
            end
        end
    end

    VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, false)
    VEHICLE.SET_VEHICLE_WHEELS_CAN_BREAK(vehicle, false)
    VEHICLE.SET_VEHICLE_HAS_UNBREAKABLE_LIGHTS(vehicle, true)
    VEHICLE.SET_VEHICLE_CAN_ENGINE_MISSFIRE(vehicle, false)
    VEHICLE.SET_VEHICLE_CAN_LEAK_OIL(vehicle, false)
    VEHICLE.SET_VEHICLE_CAN_LEAK_PETROL(vehicle, false)

    VEHICLE.SET_DISABLE_VEHICLE_ENGINE_FIRES(vehicle, true)
    VEHICLE.SET_DISABLE_VEHICLE_PETROL_TANK_FIRES(vehicle, true)
    VEHICLE.SET_DISABLE_VEHICLE_PETROL_TANK_DAMAGE(vehicle, true)

    for i = 0, 3 do
        VEHICLE.SET_DOOR_ALLOWED_TO_BE_BROKEN_OFF(vehicle, i, false)
    end
    VEHICLE.SET_HELI_TAIL_BOOM_CAN_BREAK_OFF(vehicle, false)
end

function strong_vehicle(vehicle)
    if not ENTITY.IS_ENTITY_A_VEHICLE(vehicle) then
        return
    end

    VEHICLE.SET_VEHICLE_CAN_BREAK(vehicle, false)
    VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, false)
    VEHICLE.SET_VEHICLE_WHEELS_CAN_BREAK(vehicle, false)
    for i = 0, 5 do
        if VEHICLE.GET_IS_DOOR_VALID(vehicle, i) then
            VEHICLE.SET_DOOR_ALLOWED_TO_BE_BROKEN_OFF(vehicle, i, false)
        end
    end
    VEHICLE.SET_VEHICLE_HAS_UNBREAKABLE_LIGHTS(vehicle, true)

    VEHICLE.SET_VEHICLE_CAN_ENGINE_MISSFIRE(vehicle, false)
    VEHICLE.SET_VEHICLE_CAN_LEAK_OIL(vehicle, false)
    VEHICLE.SET_VEHICLE_CAN_LEAK_PETROL(vehicle, false)

    VEHICLE.SET_DISABLE_VEHICLE_ENGINE_FIRES(vehicle, true)
    VEHICLE.SET_DISABLE_VEHICLE_PETROL_TANK_FIRES(vehicle, true)
    VEHICLE.SET_DISABLE_VEHICLE_PETROL_TANK_DAMAGE(vehicle, true)

    VEHICLE.SET_VEHICLE_STRONG(vehicle, true)
    VEHICLE.SET_VEHICLE_HAS_STRONG_AXLES(vehicle, true)


    VEHICLE.VEHICLE_SET_RAMP_AND_RAMMING_CARS_TAKE_DAMAGE(vehicle, false)
    VEHICLE.SET_INCREASE_WHEEL_CRUSH_DAMAGE(vehicle, false)
    VEHICLE.SET_DISABLE_DAMAGE_WITH_PICKED_UP_ENTITY(vehicle, 1)
    VEHICLE.SET_VEHICLE_USES_MP_PLAYER_DAMAGE_MULTIPLIER(vehicle, 1)
    VEHICLE.SET_FORCE_VEHICLE_ENGINE_DAMAGE_BY_BULLET(vehicle, false)


    VEHICLE.SET_VEHICLE_NO_EXPLOSION_DAMAGE_FROM_DRIVER(vehicle, true)
    VEHICLE.SET_DISABLE_EXPLODE_FROM_BODY_DAMAGE_ON_COLLISION(vehicle, 1)
    VEHICLE.SET_VEHICLE_EXPLODES_ON_HIGH_EXPLOSION_DAMAGE(vehicle, false)
    VEHICLE.SET_VEHICLE_EXPLODES_ON_EXPLOSION_DAMAGE_AT_ZERO_BODY_HEALTH(vehicle, false)
    VEHICLE.SET_ALLOW_VEHICLE_EXPLODES_ON_CONTACT(vehicle, false)


    VEHICLE.SET_HELI_TAIL_BOOM_CAN_BREAK_OFF(vehicle, false)
    VEHICLE.SET_DISABLE_HELI_EXPLODE_FROM_BODY_DAMAGE(vehicle, 1)


    VEHICLE.SET_PLANE_RESIST_TO_EXPLOSION(vehicle, true)
    VEHICLE.SET_HELI_RESIST_TO_EXPLOSION(vehicle, true)


    VEHICLE.REMOVE_VEHICLE_UPSIDEDOWN_CHECK(vehicle)
    VEHICLE.REMOVE_VEHICLE_STUCK_CHECK(vehicle)
end

function ENTITY_HEADING(entity, heading)
    if heading ~= nil then
        ENTITY.SET_ENTITY_HEADING(entity, heading)
        return heading
    end
    return ENTITY.GET_ENTITY_HEADING(entity)
end

function set_entity_move(entity, offsetX, offsetY, offsetZ)
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, offsetX, offsetY, offsetZ)
    TP_ENTITY(entity, coords)
end
function set_entity_networked(entity, can_migrate)
    if not ENTITY.DOES_ENTITY_EXIST(entity) then
        return false
    end

    if can_migrate == nil then can_migrate = true end

    NETWORK.NETWORK_REGISTER_ENTITY_AS_NETWORKED(entity)

    local net_id = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(entity)
    NETWORK.SET_NETWORK_ID_CAN_MIGRATE(net_id, can_migrate)
    NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(net_id, true)
    for _, pid in pairs(players.list()) do
        NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(net_id, pid, true)
    end

    return NETWORK.NETWORK_GET_ENTITY_IS_NETWORKED(entity)
end
function set_entity_godmode(entity, toggle)
    if not ENTITY.DOES_ENTITY_EXIST(entity) then
        return false
    end

    ENTITY.SET_ENTITY_INVINCIBLE(entity, toggle)
    ENTITY.SET_ENTITY_PROOFS(entity, toggle, toggle, toggle, toggle, toggle, toggle, toggle, toggle)
    ENTITY.SET_ENTITY_CAN_BE_DAMAGED(entity, not toggle)
end
function bool_to_string(bool, true_text, false_text)
    if bool then
        return true_text or "是"
    end
    return false_text or "否"
end
function GET_ENTITY_SCRIPT(entity)
    local entity_script = ENTITY.GET_ENTITY_SCRIPT(entity, 0)
    if entity_script == nil then return nil end
    return string.lower(entity_script)
end

rs_memory = {}
Entity_Info={}
--- @param addr pointer
--- @return boolean
function rs_memory.is_entity_froze(addr)
    return memory.read_byte(addr + 0x2E) == 3
end

function IS_ENTITY_A_PICKUP(entity)
    if ENTITY.IS_ENTITY_AN_OBJECT(entity) then
        if OBJECT.IS_OBJECT_A_PICKUP(entity) or OBJECT.IS_OBJECT_A_PORTABLE_PICKUP(entity) then
            return true
        end
    end
    return false
end

function TP_ENTITY(entity, coords, heading)
    if heading ~= nil then
        ENTITY.SET_ENTITY_HEADING(entity, heading)
    end
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(entity, coords.x, coords.y, coords.z, true, false, false)
end

function teleport(coords, heading)
    local ent = entities.get_user_vehicle_as_handle(false)
    if ent == INVALID_GUID then
        ent = players.user_ped()
    end

    TP_ENTITY(ent, coords, heading)
end

function tp_to_entity(entity, offsetX, offsetY, offsetZ)
    offsetX = offsetX or 0.0
    offsetY = offsetY or 0.0
    offsetZ = offsetZ or 0.0
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, offsetX, offsetY, offsetZ)
    teleport(coords)
end

function tp_entity_to_me(entity, offsetX, offsetY, offsetZ)
    offsetX = offsetX or 0.0
    offsetY = offsetY or 0.0
    offsetZ = offsetZ or 0.0
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), offsetX, offsetY, offsetZ)
    TP_ENTITY(entity, coords)
end

function Entity_Info.GetBaseInfo(entity)
    if not ENTITY.DOES_ENTITY_EXIST(entity) then
        return nil
    end

    local base_info = {
        entity = {}
    }

    local t = ""
    local info = {} -- { name, value }


    local model_hash = ENTITY.GET_ENTITY_MODEL(entity)

    -- Model Name
    local model_name = util.reverse_joaat(model_hash)
    if model_name ~= "" then
        info = { "名称", model_name }
        table.insert(base_info.entity, info)
    end

    info = { "哈希", model_hash }
    table.insert(base_info.entity, info)


    local entity_type = get_entity_type(entity)
    info = { "类型", entity_type }
    table.insert(base_info.entity, info)


    t = bool_to_string(ENTITY.IS_ENTITY_A_MISSION_ENTITY(entity), "True", "False")
    info = { "任务实体", t }
    table.insert(base_info.entity, info)


    t = ENTITY.GET_ENTITY_HEALTH(entity) .. "/" .. ENTITY.GET_ENTITY_MAX_HEALTH(entity)
    info = { "血量", t }
    table.insert(base_info.entity, info)


    if ENTITY.IS_ENTITY_DEAD(entity) then
        info = { "存活", "True" }
        table.insert(base_info.entity, info)
    end

    local ent_pos = ENTITY.GET_ENTITY_COORDS(entity)
    t = round(ent_pos.x, 4) .. ", " ..
        round(ent_pos.y, 4) .. ", " ..
        round(ent_pos.z, 4)
    info = { "坐标", t }
    table.insert(base_info.entity, info)

    local my_pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())


    t = round(ENTITY.GET_ENTITY_HEADING(entity), 4)
    info = { "标题", t }
    table.insert(base_info.entity, info)

    t = round(ENTITY.GET_ENTITY_HEADING(players.user_ped()), 4)
    info = { "标题", t }
    table.insert(base_info.entity, info)


    local distance = Vector.dist(my_pos, ent_pos)
    info = { "距离", round(distance, 4) }
    table.insert(base_info.entity, info)

    local pos_sub = Vector.subtract(my_pos, ent_pos)
    t = round(pos_sub.x, 2) .. ", " ..
        round(pos_sub.y, 2) .. ", " ..
        round(pos_sub.z, 2)
    info = { "实际坐标", t }
    table.insert(base_info.entity, info)


    local speed = ENTITY.GET_ENTITY_SPEED(entity)
    info = { "速度", round(speed, 2) }
    table.insert(base_info.entity, info)


    t = bool_to_string(NETWORK.NETWORK_GET_ENTITY_IS_NETWORKED(entity), "Networked", "Local")
    info = { "任务实体", t }
    table.insert(base_info.entity, info)


    local owner = entities.get_owner(entity)
    info = { "所有者", players.get_name(owner) }
    table.insert(base_info.entity, info)


    local entity_script = GET_ENTITY_SCRIPT(entity)
    if entity_script ~= nil then
        info = { "脚本主机实体", entity_script }
        table.insert(base_info.entity, info)
    end


    --------    Blip    --------

    local blip = HUD.GET_BLIP_FROM_ENTITY(entity)
    if HUD.DOES_BLIP_EXIST(blip) then

        local blip_sprite = HUD.GET_BLIP_SPRITE(blip)
        info = { "Blip Sprite", blip_sprite }
        table.insert(base_info.entity, info)

    
        local blip_colour = HUD.GET_BLIP_COLOUR(blip)
        info = { "Blip Colour", blip_colour }
        table.insert(base_info.entity, info)

    
        local blip_hud_colour = HUD.GET_BLIP_HUD_COLOUR(blip)
        info = { "Blip HUD Colour", blip_hud_colour }
        table.insert(base_info.entity, info)
    end


    if ENTITY.IS_ENTITY_ATTACHED(entity) then
        local attached_entity = ENTITY.GET_ENTITY_ATTACHED_TO(entity)
        local attached_hash = ENTITY.GET_ENTITY_MODEL(attached_entity)

  
        local attached_model_name = util.reverse_joaat(attached_hash)
        if attached_model_name ~= "" then
            info = { "附加模型名称", attached_model_name }
            table.insert(base_info.entity, info)
        end


        info = { "附加模型哈希", attached_hash }
        table.insert(base_info.entity, info)


        info = { "附加模型类型", get_entity_type(attached_entity) }
        table.insert(base_info.entity, info)
    end


    --------    Ped    --------

    if ENTITY.IS_ENTITY_A_PED(entity) then
        base_info.ped = {}

  
        local director_name = Ped_T.DirectorName[model_hash]
        if director_name ~= nil then
            director_name = util.get_label_text(director_name)
            if director_name ~= "NULL" then
                info = { "名称", director_name }
                table.insert(base_info.ped, info)
            end
        end


        local ped_type = PED.GET_PED_TYPE(entity)
        info = { "类型", Ped_T.Type[ped_type] }
        table.insert(base_info.ped, info)

 
        if PED.IS_PED_IN_ANY_VEHICLE(entity, false) then
            local vehicle = PED.GET_VEHICLE_PED_IS_IN(entity, false)
            info = { "载具", get_vehicle_display_name(vehicle) }
            table.insert(base_info.ped, info)
        end
    end


    --------    Vehicle    --------

    if ENTITY.IS_ENTITY_A_VEHICLE(entity) then
        base_info.vehicle = {}


        local display_name = util.get_label_text(VEHICLE.GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(model_hash))
        if display_name ~= "NULL" then
            info = { "名称", display_name }
            table.insert(base_info.vehicle, info)
        end

 
        local vehicle_class = util.get_label_text("VEH_CLASS_" .. VEHICLE.GET_VEHICLE_CLASS(entity))
        info = { "DLC类型", vehicle_class }
        table.insert(base_info.vehicle, info)

        local door_lock_status = VEHICLE.GET_VEHICLE_DOOR_LOCK_STATUS(entity)
        info = { "门", Vehicle_T.DoorLockStatus[door_lock_status] }
        table.insert(base_info.vehicle, info)


        info = { "引擎血量", VEHICLE.GET_VEHICLE_ENGINE_HEALTH(entity) }
        table.insert(base_info.vehicle, info)

      
        info = { "车身血量", VEHICLE.GET_VEHICLE_BODY_HEALTH(entity) }
        table.insert(base_info.vehicle, info)

      
        local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(entity, -1, false)
        if driver ~= 0 then
            local driver_hash = ENTITY.GET_ENTITY_MODEL(driver)
            local driver_model = util.reverse_joaat(driver_hash)

            info = { "驾驶员", driver_hash }
            if driver_model ~= "" then
                info = { "驾驶员", driver_model }
            end
            table.insert(base_info.vehicle, info)
        end
    end

    return base_info
end
function Entity_Info.GetBaseInfoText(entity)
    local ent_info = Entity_Info.GetBaseInfo(entity)
    if ent_info == nil then
        return ""
    end

    local text = ""

    for key, item in pairs(ent_info.entity) do
        local line = item[1] .. ": " .. tostring(item[2])
        text = text .. line .. "\n"
    end

    if ent_info.ped then
        text = text .. "\n--------   Ped   --------\n"

        for key, item in pairs(ent_info.ped) do
            local line = item[1] .. ": " .. tostring(item[2])
            text = text .. line .. "\n"
        end
    end

    if ent_info.vehicle then
        text = text .. "\n--------   Vehicle   --------\n"

        for key, item in pairs(ent_info.vehicle) do
            local line = item[1] .. ": " .. tostring(item[2])
            text = text .. line .. "\n"
        end
    end

    return text
end

Entity_Control = {
    menu_parent = 0,
    ctrl_entity = 0,
    index = 0,

    entity_list = {},
}

Entity_Control.__index = Entity_Control

function Entity_Control.GetMenuInfo(entity, index)
    local modelHash = ENTITY.GET_ENTITY_MODEL(entity)

    local menu_name = ""
    local help_text = ""

    local modelName = util.reverse_joaat(modelHash)
    if modelName ~= "" then
        menu_name = modelName
    else
        menu_name = modelHash
    end

    if ENTITY.IS_ENTITY_A_VEHICLE(entity) then
        local display_name = util.get_label_text(VEHICLE.GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(modelHash))
        if display_name ~= "NULL" then
            menu_name = display_name
        end

        if entity == entities.get_user_vehicle_as_handle() then
            if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
                menu_name = menu_name .. " [当前载具]"
            else
                menu_name = menu_name .. " [上一辆载具]"
            end
        elseif entity == entities.get_user_personal_vehicle_as_handle() then
            menu_name = menu_name .. " [个人载具]"
        elseif not VEHICLE.IS_VEHICLE_SEAT_FREE(entity, -1, false) then
            local driver_player = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(
                VEHICLE.GET_PED_IN_VEHICLE_SEAT(entity, -1, false))
            if players.exists(driver_player) then
                menu_name = menu_name .. " [" .. players.get_name(driver_player) .. "]"
            end
        end

        help_text = "模型：" .. modelName .. "\n"
    end

    local owner = entities.get_owner(entity)
    owner = players.get_name(owner)

    menu_name = index .. "\n名称：" .. menu_name
    help_text = help_text .. "哈希：" .. modelHash .. "\n所有者： " .. owner

    if ENTITY.IS_ENTITY_A_MISSION_ENTITY(entity) then
        local entity_script = GET_ENTITY_SCRIPT(entity)
        if entity_script ~= nil then
            help_text = help_text .. "\nScript: " .. entity_script
        end
    end

    return menu_name, help_text
end


function Entity_Control.GenerateMenu(menu_parent, entity, index)
    local self = setmetatable({}, Entity_Control)
    self.menu_parent = menu_parent
    self.ctrl_entity = entity
    self.index = index

    self:Base()
    self:Entity()

    if ENTITY.IS_ENTITY_A_PED(entity) then
        self:Ped()
    end

    if ENTITY.IS_ENTITY_A_VEHICLE(entity) then
        self:Vehicle()
    end

    if IS_ENTITY_A_PICKUP(entity) then
        self:Pickup()
    end
end

------------------------
-- Entity
------------------------

function Entity_Control:Base()
    local menu_parent = self.menu_parent
    local entity = self.ctrl_entity
    local index = self.index

    menu.divider(menu_parent, menu.get_menu_name(menu_parent))


    local ent_info = menu.list(menu_parent, "实体信息", {}, "")

    menu.textslider_stateful(ent_info, "实体信息", {}, "", {
        "复制", "输出到日志"
    }, function(value)
        local text = Entity_Info.GetBaseInfoText(entity)
        util.copy_to_clipboard(text, false)
        if value == 2 then
            util.log(text)
        end
        util.toast("完成")
    end)


    menu.click_slider(menu_parent, "请求控制实体", { "request_ctrl_ent" .. index }, "超时时间\n单位: ms",
        1, 5000, 2000, 500, function(value)
            if request_control(entity, value) then
                util.toast("请求控制成功！")
            else
                util.toast("请求控制失败")
            end
        end)
end

function Entity_Control:Entity()
    local menu_parent = self.menu_parent
    local entity = self.ctrl_entity
    local index = self.index

    local entity_options = menu.list(menu_parent, "实体选项", {}, "")

    menu.toggle(entity_options, "无敌", {}, "", function(toggle)
        set_entity_godmode(entity, toggle)
    end)

    menu.toggle(entity_options, "冻结", {}, "", function(toggle)
        ENTITY.FREEZE_ENTITY_POSITION(entity, toggle)
    end, rs_memory.is_entity_froze(entities.handle_to_pointer(entity)))

    local explosion_type = 4
    menu.list_select(entity_options, "选择爆炸类型", {}, "", Misc_T.ExplosionType, explosion_type, function(value)
        explosion_type = value
    end)
    menu.toggle_loop(entity_options, "爆炸", {}, "", function()
        local pos = ENTITY.GET_ENTITY_COORDS(entity)
        add_explosion(pos, explosion_type)

        util.yield(500)
    end)

    menu.toggle(entity_options, "无碰撞", {}, "可以直接穿过实体", function(toggle)
        ENTITY.SET_ENTITY_COLLISION(entity, not toggle, true)
    end, ENTITY.GET_ENTITY_COLLISION_DISABLED(entity))

    menu.toggle(entity_options, "隐形", {}, "将实体隐形", function(toggle)
        ENTITY.SET_ENTITY_VISIBLE(entity, not toggle, 0)
    end, not ENTITY.IS_ENTITY_VISIBLE(entity))

    menu.click_slider(entity_options, "透明度", { "ctrl_ent" .. index .. "_alpha" },
        "",
        0, 255, ENTITY.GET_ENTITY_ALPHA(entity), 5, function(value)
            ENTITY.SET_ENTITY_ALPHA(entity, value, false)
        end)

    menu.click_slider(entity_options, "最大速度", { "ctrl_ent" .. index .. "_max_speed" }, "",
        0, 1000, 0, 10, function(value)
            ENTITY.SET_ENTITY_MAX_SPEED(entity, value)
        end)

    menu.action(entity_options, "设置为任务实体", {}, "避免实体被自动清理", function()
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(entity, true, true)
        ENTITY.SET_ENTITY_SHOULD_FREEZE_WAITING_ON_COLLISION(entity, true)
        if ENTITY.IS_ENTITY_A_VEHICLE(entity) then
            VEHICLE.SET_VEHICLE_STAYS_FROZEN_WHEN_CLEANED_UP(entity, true)
            VEHICLE.SET_CLEAR_FREEZE_WAITING_ON_COLLISION_ONCE_PLAYER_ENTERS(entity, false)
        end
        util.toast("完成")
    end)

    menu.action(entity_options, "删除", {}, "", function()
        entities.delete(entity)
    end)

    if ENTITY.IS_ENTITY_ATTACHED(entity) then
        menu.action(entity_options, "Detach Entity", {}, "", function()
            ENTITY.DETACH_ENTITY(entity, true, true)
        end)
    end

    self:EntityHealth()
    self:Teleport()
    self:Movement()
    self:Blip()
end

function Entity_Control:EntityHealth()
    local menu_parent = self.menu_parent
    local entity = self.ctrl_entity
    local index = self.index

    local health_options = menu.list(menu_parent, "实体血量", {}, "")

    local readonly_ent_health = menu.readonly(health_options, "血量")
    menu.on_tick_in_viewport(readonly_ent_health, function()
        local health = ENTITY.GET_ENTITY_HEALTH(entity)
        local max_health = ENTITY.GET_ENTITY_MAX_HEALTH(entity)
        menu.set_value(readonly_ent_health, health .. "/" .. max_health)
    end)

    menu.divider(health_options, "设置血量")

    local ctrl_ent_health = 1000
    menu.slider(health_options, "血量", { "ctrl_ent" .. index .. "_health" }, "",
        0, 100000, 1000, 100, function(value)
            ctrl_ent_health = value
        end)
    menu.action(health_options, "当前血量", {}, "", function()
        SET_ENTITY_HEALTH(entity, ctrl_ent_health)
    end)
    menu.action(health_options, "最大血量", {}, "", function()
        ENTITY.SET_ENTITY_MAX_HEALTH(entity, ctrl_ent_health)
    end)
end

function Entity_Control:Teleport()
    local menu_parent = self.menu_parent
    local entity = self.ctrl_entity
    local index = self.index

    local teleport_options = menu.list(menu_parent, "传送选项", {}, "")

    local tp = {
        x = 0.0,
        y = 2.0,
        z = 0.0,
    }

    menu.action(teleport_options, "传送到我", {}, "", function()
        tp_entity_to_me(entity, tp.x, tp.y, tp.z)
    end)

    --[[menu.action(teleport_options, "传送到实体", {}, "", function()
        tp_to_entity(entity, tp.x, tp.y, tp.z)
    end)]]

    menu.divider(teleport_options, "偏移")
    menu.slider_float(teleport_options, "前/后", { "ctrl_ent" .. index .. "_tp_x" }, "",
        -10000, 10000, 200, 50, function(value)
            tp.y = value * 0.01
        end)
    menu.slider_float(teleport_options, "上/下", { "ctrl_ent" .. index .. "_tp_y" }, "",
        -10000, 10000, 0, 50, function(value)
            tp.z = value * 0.01
        end)
    menu.slider_float(teleport_options, "左/右", { "ctrl_ent" .. index .. "_tp_z" }, "",
        -10000, 10000, 0, 50, function(value)
            tp.x = value * 0.01
        end)

    menu.divider(teleport_options, "锁定传送")
    local lock_tp = 1
    menu.list_select(teleport_options, "方式", {}, "", {
        { 1, "实体传送到我" }, { 2, "我传送到实体" }
    }, 1, function(value)
        lock_tp = value
    end)
    menu.toggle(teleport_options, "锁定传送", {}, "如果更改了偏移，需要重新开关此选项",
        function(toggle)
            if toggle then
                if Loop_Handler.Entity.lock_tp.toggle then
                    util.toast("正在锁定传送其它实体")
                else
                    Loop_Handler.Entity.lock_tp.entity = entity
                    Loop_Handler.Entity.lock_tp.method = lock_tp
                    Loop_Handler.Entity.lock_tp.x = tp.x
                    Loop_Handler.Entity.lock_tp.y = tp.y
                    Loop_Handler.Entity.lock_tp.z = tp.z
                    Loop_Handler.Entity.lock_tp.toggle = true
                end
            else
                if Loop_Handler.Entity.lock_tp.entity == entity then
                    Loop_Handler.Entity.lock_tp.toggle = false
                end
            end
        end)
end

function Entity_Control:Movement()
    local menu_parent = self.menu_parent
    local entity = self.ctrl_entity
    local index = self.index

    local movement_options = menu.list(menu_parent, "移动选项", {}, "")

    menu.click_slider_float(movement_options, "前/后 移动", { "ctrl_ent" .. index .. "_move_y" }, "",
        -10000, 10000, 0, 50, function(value)
            set_entity_move(entity, 0.0, value * 0.01, 0.0)
        end)
    menu.click_slider_float(movement_options, "左/右 移动", { "ctrl_ent" .. index .. "_move_x" }, "",
        -10000, 10000, 0, 50, function(value)
            set_entity_move(entity, value * 0.01, 0.0, 0.0)
        end)
    menu.click_slider_float(movement_options, "上/下 移动", { "ctrl_ent" .. index .. "_move_z" }, "",
        -10000, 10000, 0, 50, function(value)
            set_entity_move(entity, 0.0, 0.0, value * 0.01)
        end)
    menu.click_slider_float(movement_options, "朝向(加减)", { "ctrl_ent" .. index .. "_heading" }, "",
        -36000, 36000, 0, 500,
        function(value)
            ENTITY_HEADING(entity, ENTITY_HEADING(entity) + value * 0.01)
        end)
    menu.click_slider_float(movement_options, "朝向(设置)", { "ctrl_ent" .. index .. "set_heading" }, "",
        -36000, 36000, 0, 500,
        function(value)
            ENTITY_HEADING(entity, value * 0.01)
        end)

    menu.divider(movement_options, "坐标")
    local coord_menu = {}
    menu.action(movement_options, "刷新坐标", {}, "", function()
        local coords = ENTITY.GET_ENTITY_COORDS(entity)
        local pos = {}
        pos.x = round(coords.x, 2) * 100
        pos.y = round(coords.y, 2) * 100
        pos.z = round(coords.z, 2) * 100
        menu.set_value(coord_menu.x, math.ceil(pos.x))
        menu.set_value(coord_menu.y, math.ceil(pos.y))
        menu.set_value(coord_menu.z, math.ceil(pos.z))
    end)

    local ent_coords = ENTITY.GET_ENTITY_COORDS(entity)
    local pos = {}
    pos.x = round(ent_coords.x, 2) * 100
    pos.y = round(ent_coords.y, 2) * 100
    pos.z = round(ent_coords.z, 2) * 100
    coord_menu.x = menu.slider_float(movement_options, "X:", { "ctrl_ent" .. index .. "_x" }, "",
        -1000000, 1000000, math.ceil(pos.x), 50, function(value, prev_value, click_type)
            if click_type ~= CLICK_SCRIPTED then
                local coords = ENTITY.GET_ENTITY_COORDS(entity)
                coords.x = value * 0.01
                TP_ENTITY(entity, coords)
            end
        end)
    coord_menu.y = menu.slider_float(movement_options, "Y:", { "ctrl_ent" .. index .. "_y" }, "",
        -1000000, 1000000, math.ceil(pos.y), 50, function(value, prev_value, click_type)
            if click_type ~= CLICK_SCRIPTED then
                local coords = ENTITY.GET_ENTITY_COORDS(entity)
                coords.y = value * 0.01
                TP_ENTITY(entity, coords)
            end
        end)
    coord_menu.z = menu.slider_float(movement_options, "Z:", { "ctrl_ent" .. index .. "_z" }, "",
        -1000000, 1000000, math.ceil(pos.z), 50, function(value, prev_value, click_type)
            if click_type ~= CLICK_SCRIPTED then
                local coords = ENTITY.GET_ENTITY_COORDS(entity)
                coords.z = value * 0.01
                TP_ENTITY(entity, coords)
            end
        end)
end

function Entity_Control:Blip()
    local menu_parent = self.menu_parent
    local entity = self.ctrl_entity
    local index = self.index

    local blip = HUD.GET_BLIP_FROM_ENTITY(entity)
    if not HUD.DOES_BLIP_EXIST(blip) then
        return
    end

    local blip_options = menu.list(menu_parent, "地图标记点选项", {}, "")

    menu.slider(blip_options, "Blip Sprite", { "ctrl_ent" .. index .. "_blip_sprite" }, "",
        0, ALL_BLIPS_NUMBER, HUD.GET_BLIP_SPRITE(blip), 1, function(value)
            HUD.SET_BLIP_SPRITE(blip, value)
        end)

    menu.slider(blip_options, "Blip Colour", { "ctrl_ent" .. index .. "_blip_colour" }, "",
        0, 85, HUD.GET_BLIP_COLOUR(blip), 1, function(value)
            HUD.SET_BLIP_COLOUR(blip, value)
        end)

    menu.slider_float(blip_options, "Blip Scale", { "ctrl_ent" .. index .. "_blip_scale" }, "",
        0, 1000, 100, 10, function(value)
            HUD.SET_BLIP_SCALE(blip, value * 0.01)
        end)

    menu.toggle(blip_options, "Flashs", {}, "", function(toggle)
        HUD.SET_BLIP_FLASHES(blip, toggle)
    end, HUD.IS_BLIP_FLASHING(blip))

    menu.toggle(blip_options, "Short Range", {}, "", function(toggle)
        HUD.SET_BLIP_AS_SHORT_RANGE(blip, toggle)
    end, HUD.IS_BLIP_SHORT_RANGE(blip))

    menu.list_select(blip_options, "Blip Display", {}, "", Blip_T.DisplayId,
        HUD.GET_BLIP_INFO_ID_DISPLAY(blip), function(value)
            HUD.SET_BLIP_DISPLAY(blip, value)
        end)
end

------------------------
-- Ped
------------------------

function Entity_Control:Ped()
    local menu_parent = self.menu_parent
    local ped = self.ctrl_entity
    local index = self.index

    local ped_options = menu.list(menu_parent, "Ped选项", {}, "")

    menu.toggle(ped_options, "燃烧", {}, "", function(toggle)
        if toggle then
            FIRE.START_ENTITY_FIRE(ped)
        else
            FIRE.STOP_ENTITY_FIRE(ped)
        end
    end)
    menu.action(ped_options, "传送到我的载具", {}, "", function()
        local vehicle = entities.get_user_vehicle_as_handle(false)
        if vehicle ~= INVALID_GUID then
            if VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(vehicle) then
                PED.SET_PED_INTO_VEHICLE(ped, vehicle, -2)
            end
        end
    end)
    menu.list_action(ped_options, "给予武器", {}, "", RS_T.CommonWeapons, function(value)
        local weaponHash = value
        WEAPON.GIVE_WEAPON_TO_PED(ped, weaponHash, -1, false, true)
        WEAPON.SET_CURRENT_PED_WEAPON(ped, weaponHash, false)
    end)
    menu.action(ped_options, "移除全部武器", {}, "", function()
        WEAPON.REMOVE_ALL_PED_WEAPONS(ped)
    end)
    menu.action(ped_options, "克隆", {}, "", function()
        local model = ENTITY.GET_ENTITY_MODEL(ped)
        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 0.0, 2.0)
        local ped_type = PED.GET_PED_TYPE(ped)
        local heading = ENTITY.GET_ENTITY_HEADING(ped)
        local clone_ped = create_ped(ped_type, model, coords, heading)
        PED.CLONE_PED_TO_TARGET(ped, clone_ped)
    end)
    menu.action(ped_options, "随机变装", {}, "", function()
        PED.SET_PED_RANDOM_COMPONENT_VARIATION(ped, 0)
        PED.SET_PED_RANDOM_PROPS(ped)
    end)
    menu.action(ped_options, "与玩家友好", {}, "", function()
        local player_rel_hash = PED.GET_PED_RELATIONSHIP_GROUP_HASH(players.user_ped())
        PED.SET_RELATIONSHIP_BETWEEN_GROUPS(0, player_rel_hash, player_rel_hash)
        PED.SET_PED_RELATIONSHIP_GROUP_HASH(ped, player_rel_hash)
    end)
    menu.action(ped_options, "清理外观", {}, "", function()
        clear_ped_body(ped)
    end)
    menu.action(ped_options, "复活", {}, "", function()
        PED.RESURRECT_PED(ped)
    end)
    menu.action(ped_options, "清除PED现有动作与任务", {}, "", function()
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
    end)




    ----------
end

------------------------
-- Vehicle
------------------------

function Entity_Control:Vehicle()
    local menu_parent = self.menu_parent
    local vehicle = self.ctrl_entity
    local index = self.index

    local vehicle_options = menu.list(menu_parent, "载具选项", {}, "")

    menu.textslider_stateful(vehicle_options, "载具传送到我", {}, "会将原座位的NPC传送出去",
        { "驾驶位", "空座位" }, function(value)
            ENTITY_HEADING(vehicle, user_heading())
            tp_entity_to_me(vehicle)
            if value == 1 then
                local ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1, false)
                if ped ~= 0 then
                    set_entity_move(ped, 0.0, 0.0, 3.0)
                end
                PED.SET_PED_INTO_VEHICLE(players.user_ped(), vehicle, -1)
            elseif value == 2 then
                PED.SET_PED_INTO_VEHICLE(players.user_ped(), vehicle, -2)
            end
        end)

    menu.textslider_stateful(vehicle_options, "传送到载具内", {}, "会将原座位的NPC传送出去",
        { "空座位", "驾驶位", "副驾驶位" }, function(value)
            if value == 1 then
                if VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(vehicle) then
                    PED.SET_PED_INTO_VEHICLE(players.user_ped(), vehicle, -2)
                else
                    util.toast("载具已无空座位")
                end
            elseif value == 2 then
                if VEHICLE.IS_VEHICLE_SEAT_FREE(vehicle, -1, false) then
                    PED.SET_PED_INTO_VEHICLE(players.user_ped(), vehicle, -1)
                else
                    local ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1)
                    if ped ~= 0 then
                        set_entity_move(ped, 0.0, 0.0, 3.0)
                        PED.SET_PED_INTO_VEHICLE(players.user_ped(), vehicle, -1)
                    end
                end
            elseif value == 3 then
                if VEHICLE.GET_VEHICLE_MAX_NUMBER_OF_PASSENGERS(vehicle) > 0 then
                    if VEHICLE.IS_VEHICLE_SEAT_FREE(vehicle, 0, false) then
                        PED.SET_PED_INTO_VEHICLE(players.user_ped(), vehicle, 0)
                    else
                        local ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, 0)
                        if ped ~= 0 then
                            set_entity_move(ped, 0.0, 0.0, 3.0)
                            PED.SET_PED_INTO_VEHICLE(players.user_ped(), vehicle, 0)
                        end
                    end
                else
                    util.toast("载具无副驾驶位")
                end
            end
        end)

    menu.action(vehicle_options, "清空载具", {}, "将NPC全部传送出去", function()
        local num, peds = get_vehicle_peds(vehicle)
        if num > 0 then
            for k, ped in pairs(peds) do
                set_entity_move(ped, 0.0, 0.0, 3.0)
            end
        end
    end)

    menu.click_slider(vehicle_options, "向前加速", { "ctrl_veh" .. index .. "_forward_speed" },
        "", 0, 1000, 30, 10, function(value)
            VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehicle, value)
        end)
    menu.click_slider(vehicle_options, "向前加速XY", { "ctrl_veh" .. index .. "_forward_speed_xy" },
        "", 0, 1000, 30, 10, function(value)
            VEHICLE.SET_VEHICLE_FORWARD_SPEED_XY(vehicle, value)
        end)

    menu.action(vehicle_options, "修复载具", {}, "", function()
        fix_vehicle(vehicle)
    end)
    menu.action(vehicle_options, "升级载具", {}, "", function()
        upgrade_vehicle(vehicle)
    end)
    menu.action(vehicle_options, "强化载具", {}, "", function()
        strong_vehicle(vehicle)
    end)

    menu.list_action(vehicle_options, "车窗", {}, "", {
        { 1, "删除车窗" },
        { 2, "摇下车窗" },
        { 3, "摇上车窗" },
        { 4, "粉碎车窗" },
        { 6, "修复车窗" },
    }, function(value)
        if value == 1 then
            for i = 0, 7 do
                VEHICLE.REMOVE_VEHICLE_WINDOW(vehicle, i)
            end
        elseif value == 2 then
            for i = 0, 7 do
                VEHICLE.ROLL_DOWN_WINDOW(vehicle, i)
            end
        elseif value == 3 then
            for i = 0, 7 do
                VEHICLE.ROLL_UP_WINDOW(vehicle, i)
            end
        elseif value == 4 then
            for i = 0, 7 do
                VEHICLE.SMASH_VEHICLE_WINDOW(vehicle, i)
            end
        elseif value == 5 then
            for i = 0, 7 do
                VEHICLE.FIX_VEHICLE_WINDOW(vehicle, i)
            end
        end
    end)
    menu.list_action(vehicle_options, "车门", {}, "", {
        { 1, "打开车门" },
        { 2, "关闭车门" },
        { 3, "拆下车门" },
        { 4, "删除车门" },
    }, function(value)
        if value == 1 then
            for i = 0, 3 do
                VEHICLE.SET_VEHICLE_DOOR_OPEN(vehicle, i, false, false)
            end
        elseif value == 2 then
            VEHICLE.SET_VEHICLE_DOORS_SHUT(vehicle, false)
        elseif value == 3 then
            for i = 0, 3 do
                VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, i, false)
            end
        elseif value == 4 then
            for i = 0, 3 do
                VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, i, true)
            end
        end
    end)

    menu.textslider_stateful(vehicle_options, "引擎", {}, "", { "打开", "关闭" }, function(value)
        if value == 1 then
            VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, false)
        elseif value == 2 then
            VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, false, true, false)
        end
    end)
    menu.textslider_stateful(vehicle_options, "车门锁", {}, "", { "解锁", "上锁" }, function(value)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, value)
    end)
    menu.textslider_stateful(vehicle_options, "车胎", {}, "", { "爆胎", "修复" }, function(value)
        if value == 1 then
            for i = 0, 7 do
                VEHICLE.SET_VEHICLE_TYRE_BURST(vehicle, i, true, 1000.0)
            end
        elseif value == 2 then
            for i = 0, 7 do
                VEHICLE.SET_VEHICLE_TYRE_FIXED(vehicle, i)
            end
        end
    end)
    menu.action(vehicle_options, "分离车轮", {}, "", function(value)
        for i = 0, 7 do
            entities.detach_wheel(vehicle, i)
        end
    end)

    menu.click_slider(vehicle_options, "改变最大速度 (%)", { "" },
        "", -100, 100, 0, 10, function(value)
            VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vehicle, value)
        end)
    menu.click_slider(vehicle_options, "设置最大速度", { "" },
        "", 0, 10000, 500, 50, function(value)
            VEHICLE.SET_VEHICLE_MAX_SPEED(vehicle, value)
        end)

    self:VehicleHealth()
end

function Entity_Control:VehicleHealth()
    local menu_parent = self.menu_parent
    local vehicle = self.ctrl_entity
    local index = self.index

    local vehicle_health_options = menu.list(menu_parent, "载具血量选项", {}, "")

    local hash = ENTITY.GET_ENTITY_MODEL(vehicle)

    menu.click_slider(vehicle_health_options, "引擎血量", { "ctrl_veh" .. index .. "_engine_health" },
        "", -1000, 10000,
        1000, 500, function(value)
            VEHICLE.SET_VEHICLE_ENGINE_HEALTH(vehicle, value)
        end)
    menu.click_slider(vehicle_health_options, "油箱血量", { "ctrl_veh" .. index .. "_petrol_tank_health" },
        "", -1000, 10000,
        1000, 500, function(value)
            VEHICLE.SET_VEHICLE_PETROL_TANK_HEALTH(vehicle, value)
        end)
    menu.click_slider(vehicle_health_options, "外观血量", { "ctrl_veh" .. index .. "_body_health" },
        "", -1000, 10000,
        1000, 500, function(value)
            VEHICLE.SET_VEHICLE_BODY_HEALTH(vehicle, value)
        end)


    if VEHICLE.IS_THIS_MODEL_A_PLANE(hash) then
        menu.click_slider(vehicle_health_options, "飞机引擎血量", { "ctrl_veh" .. index .. "_plane_engine_health" },
            "",
            -1000, 10000, 1000, 500, function(value)
                VEHICLE.SET_PLANE_ENGINE_HEALTH(vehicle, value)
            end)
    end


    if VEHICLE.IS_THIS_MODEL_A_HELI(hash) then
        menu.click_slider(vehicle_health_options, "直升机主旋翼血量",
            { "ctrl_veh" .. index .. "_main_rotor_health" }, "",
            -1000, 10000, 1000, 500, function(value)
                VEHICLE.SET_HELI_MAIN_ROTOR_HEALTH(vehicle, value)
            end)
        menu.click_slider(vehicle_health_options, "直升机尾旋翼血量",
            { "ctrl_veh" .. index .. "_tail_rotor_health" }, "",
            -1000, 10000, 1000, 500, function(value)
                VEHICLE.SET_HELI_TAIL_ROTOR_HEALTH(vehicle, value)
            end)
    end
end

------------------------
-- Pickup
------------------------

function Entity_Control:Pickup()
    local menu_parent = self.menu_parent
    local pickup = self.ctrl_entity
    local index = self.index

    local pickup_options = menu.list(menu_parent, "掉落物选项", {}, "")

    menu.action(pickup_options, "附加到自己", {}, "", function()
        OBJECT.ATTACH_PORTABLE_PICKUP_TO_PED(pickup, players.user_ped())
    end)
    menu.action(pickup_options, "取消附加", {}, "", function()
        OBJECT.DETACH_PORTABLE_PICKUP_FROM_PED(pickup)
    end)
    menu.toggle(pickup_options, "当取消附加时隐藏实体", {}, "", function(toggle)
        OBJECT.HIDE_PORTABLE_PICKUP_WHEN_DETACHED(pickup, toggle)
    end)
    menu.toggle(pickup_options, "无声", {}, "", function(toggle)
        OBJECT.SUPPRESS_PICKUP_SOUND_FOR_PICKUP(pickup, toggle and 1 or 0)
    end)
    menu.toggle(pickup_options, "无法收集时发光", {}, "", function(toggle)
        OBJECT.SET_PICKUP_OBJECT_GLOW_WHEN_UNCOLLECTABLE(pickup, toggle)
    end)
    menu.toggle(pickup_options, "标记实体", {}, "", function(toggle)
        OBJECT.SET_PICKUP_OBJECT_ARROW_MARKER(pickup, toggle)
    end)
    menu.toggle(pickup_options, "无法收集时标记", {}, "", function(toggle)
        OBJECT.ALLOW_PICKUP_ARROW_MARKER_WHEN_UNCOLLECTABLE(pickup, toggle)
    end)
    menu.toggle(pickup_options, "无法收集时隐藏", {}, "", function(toggle)
        OBJECT.SET_PICKUP_OBJECT_TRANSPARENT_WHEN_UNCOLLECTABLE(pickup, toggle)
    end)

    menu.action(pickup_options, "收集到载具", {}, "", function()
        OBJECT.SET_PICKUP_OBJECT_COLLECTABLE_IN_VEHICLE(pickup)
    end)
    menu.list_action(pickup_options, "阻止收集", {}, "", {
        { 1, "阻止" },
        { 2, "阻止(仅本地)" },
        { 3, "不阻止" },
        { 4, "不阻止(仅本地)" }
    }, function(value)
        local bPrevent, bLocalOnly = true, false
        if value == 2 then
            bPrevent, bLocalOnly = true, true
        elseif value == 3 then
            bPrevent, bLocalOnly = false, false
        elseif value == 4 then
            bPrevent, bLocalOnly = false, true
        end

        OBJECT.PREVENT_COLLECTION_OF_PORTABLE_PICKUP(pickup, bPrevent, bLocalOnly)
    end)

    menu.divider(pickup_options, "模型哈希")

    local hash = ENTITY.GET_ENTITY_MODEL(pickup)
    menu.click_slider(pickup_options, "最大携带数量", {}, "", 1, 20, 8, 1, function(value)
        OBJECT.SET_MAX_NUM_PORTABLE_PICKUPS_CARRIED_BY_PLAYER(hash, value)
    end)
    menu.toggle(pickup_options, "允许收集(本地)", {}, "", function(toggle)
        OBJECT.SET_LOCAL_PLAYER_PERMITTED_TO_COLLECT_PICKUPS_WITH_MODEL(hash, toggle)
    end)
end

------------------------
-- All
------------------------

function Entity_Control.Entities(menu_parent, entity_list)
    local self = setmetatable({}, Entity_Control)
    self.menu_parent = menu_parent
    self.entity_list = entity_list

    menu.click_slider(menu_parent, "请求控制实体", { "request_ctrl_ents" }, "超时时间\n单位: ms",
        1, 5000, 2000, 500, function(value)
            local success_num = 0
            local fail_num = 0
            for k, entity in pairs(entity_list) do
                if ENTITY.DOES_ENTITY_EXIST(entity) then
                    if request_control(entity, value) then
                        success_num = success_num + 1
                    else
                        fail_num = fail_num + 1
                    end
                end
            end
            util.toast("完成！\n成功: " .. success_num .. "\n失败: " .. fail_num)
        end)

    menu.toggle(menu_parent, "无敌", {}, "", function(toggle)
        for k, entity in pairs(entity_list) do
            if ENTITY.DOES_ENTITY_EXIST(entity) then
                set_entity_godmode(entity, toggle)
            end
        end
        util.toast("完成！")
    end)
    menu.toggle(menu_parent, "冻结", {}, "", function(toggle)
        for k, entity in pairs(entity_list) do
            if ENTITY.DOES_ENTITY_EXIST(entity) then
                ENTITY.FREEZE_ENTITY_POSITION(entity, toggle)
            end
        end
        util.toast("完成！")
    end)
    menu.toggle(menu_parent, "燃烧", {}, "", function(toggle)
        for k, entity in pairs(entity_list) do
            if ENTITY.DOES_ENTITY_EXIST(entity) then
                if toggle then
                    FIRE.START_ENTITY_FIRE(entity)
                else
                    FIRE.STOP_ENTITY_FIRE(entity)
                end
            end
        end
        util.toast("完成！")
    end)

    local explosion_type = 4
    menu.list_select(menu_parent, "选择爆炸类型", {}, "", Misc_T.ExplosionType, explosion_type, function(value)
        explosion_type = value
    end)
    menu.toggle_loop(menu_parent, "爆炸", {}, "", function()
        for k, entity in pairs(entity_list) do
            if ENTITY.DOES_ENTITY_EXIST(entity) then
                local pos = ENTITY.GET_ENTITY_COORDS(entity)
                add_explosion(pos, explosion_type)
            end
        end
        util.yield(500)
    end)

    menu.click_slider(menu_parent, "设置实体血量", { "ctrl_ents_health" }, "",
        0, 100000, 100, 100, function(value)
            for k, entity in pairs(entity_list) do
                if ENTITY.DOES_ENTITY_EXIST(entity) then
                    SET_ENTITY_HEALTH(entity, value)
                end
            end
            util.toast("完成！")
        end)
    menu.click_slider(menu_parent, "设置最大速度", { "ctrl_ents_max_speed" }, "",
        0, 1000, 0, 10, function(value)
            for k, entity in pairs(entity_list) do
                if ENTITY.DOES_ENTITY_EXIST(entity) then
                    ENTITY.SET_ENTITY_MAX_SPEED(entity, value)
                end
            end
            util.toast("完成！")
        end)
    menu.action(menu_parent, "删除", {}, "", function()
        for k, entity in pairs(entity_list) do
            if ENTITY.DOES_ENTITY_EXIST(entity) then
                entities.delete(entity)
            end
        end
        util.toast("完成！")
    end)


    ----------
    self:EntitiesTeleport()
    self:EntitiesMovement()
end

function Entity_Control:EntitiesTeleport()
    local menu_parent = self.menu_parent
    local entity_list = self.entity_list


    local teleport_options = menu.list(menu_parent, "传送选项", {}, "")

    local tp = {
        x = 0.0,
        y = 2.0,
        z = 0.0,
    }
    local tp_delay = 1000

    menu.slider_float(teleport_options, "前/后", { "ctrl_ents_tp_y" }, "",
        -5000, 5000, 200, 50, function(value)
            tp.y = value * 0.01
        end)
    menu.slider_float(teleport_options, "上/下", { "ctrl_ents_tp_z" }, "",
        -5000, 5000, 0, 50, function(value)
            tp.z = value * 0.01
        end)
    menu.slider_float(teleport_options, "左/右", { "ctrl_ents_tp_x" }, "",
        -5000, 5000, 0, 50, function(value)
            tp.x = value * 0.01
        end)
    menu.slider(teleport_options, "传送延时", { "ctrl_ents_tp_delay" }, "单位: ms",
        0, 5000, 1000, 100, function(value)
            tp_delay = value
        end)

    menu.action(teleport_options, "传送到我", {}, "", function()
        for _, entity in pairs(entity_list) do
            if ENTITY.DOES_ENTITY_EXIST(entity) then
                tp_entity_to_me(entity, tp.x, tp.y, tp.z)

                util.yield(tp_delay)
            end
        end
        util.toast("完成！")
    end)
end

function Entity_Control:EntitiesMovement()
    local menu_parent = self.menu_parent
    local entity_list = self.entity_list


    local movement_options = menu.list(menu_parent, "移动选项", {}, "")

    menu.click_slider_float(movement_options, "前/后 移动", { "ctrl_ents_move_y" }, "",
        -10000, 10000, 0, 50, function(value)
            value = value * 0.01
            for _, entity in pairs(entity_list) do
                if ENTITY.DOES_ENTITY_EXIST(entity) then
                    set_entity_move(entity, 0.0, value, 0.0)
                end
            end
            util.toast("完成！")
        end)
    menu.click_slider_float(movement_options, "左/右 移动", { "ctrl_ents_move_x" }, "",
        -10000, 10000, 0, 50, function(value)
            value = value * 0.01
            for _, entity in pairs(entity_list) do
                if ENTITY.DOES_ENTITY_EXIST(entity) then
                    set_entity_move(entity, value, 0.0, 0.0)
                end
            end
            util.toast("完成！")
        end)
    menu.click_slider_float(movement_options, "上/下 移动", { "ctrl_ents_move_z" }, "",
        -10000, 10000, 0, 50, function(value)
            value = value * 0.01
            for _, entity in pairs(entity_list) do
                if ENTITY.DOES_ENTITY_EXIST(entity) then
                    set_entity_move(entity, 0.0, 0.0, value)
                end
            end
            util.toast("完成！")
        end)
    menu.click_slider_float(movement_options, "朝向(加减)", { "ctrl_ents_heading" }, "",
        -36000, 36000, 0, 500, function(value)
            value = value * 0.01
            for _, entity in pairs(entity_list) do
                if ENTITY.DOES_ENTITY_EXIST(entity) then
                    ENTITY_HEADING(entity, ENTITY_HEADING(entity) + value)
                end
            end
            util.toast("完成！")
        end)
    menu.click_slider_float(movement_options, "朝向(设置)", { "ctrl_ents_set_heading" }, "",
        -36000, 36000, 0, 500, function(value)
            value = value * 0.01
            for _, entity in pairs(entity_list) do
                if ENTITY.DOES_ENTITY_EXIST(entity) then
                    ENTITY_HEADING(entity, value)
                end
            end
            util.toast("完成！")
        end)
end
