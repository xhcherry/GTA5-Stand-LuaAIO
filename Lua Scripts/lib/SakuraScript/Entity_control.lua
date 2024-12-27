------- 实体控制枪 -------
function entity_control_all(menu_parent, ent)
    menu.action(menu_parent, "检测该实体是否存在", {}, "", function()
        if ENTITY.DOES_ENTITY_EXIST(ent) then
            util.toast("实体存在")
        else
            util.toast("该实体已经不存在，已为你删除此纪录！")
            menu.delete(menu_parent)
            clearTableValue(control_ent_menu_list, menu_parent)
            clearTableValue(control_ent_list, ent)
        end
    end)
    menu.action(menu_parent, "删除此实体", {}, "", function()
        delete_entity(ent)
    end)
    local module_hash = ENTITY.GET_ENTITY_MODEL(ent)
    menu.readonly(menu_parent, "实体hash: ", module_hash)
    menu.readonly(menu_parent, "实体名称: ", util.reverse_joaat(module_hash))
    menu.readonly(menu_parent, "武器hash: ", WEAPON.GET_SELECTED_PED_WEAPON(PLAYER.PLAYER_PED_ID()))
    menu.action(menu_parent, "删除此条实体记录", {}, "", function()
        menu.delete(menu_parent)
        clearTableValue(control_ent_menu_list, menu_parent)
        clearTableValue(control_ent_list, ent)
    end)

    ----默认部分
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
    menu.slider(menu_parent, "血量数值", {"control_ent_health"}, "", 0, 30000, 1000, 100, function(value)
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
    menu.action(menu_parent, "传送到我的载具", {}, "", function()
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)
        if vehicle then
            if VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(vehicle) then
                PED.SET_PED_INTO_VEHICLE(ped, vehicle, -2)
            end
        end
    end)
    menu.action(menu_parent, "离我的距离", {}, "", function()
        local my_pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
        local ent_pos = ENTITY.GET_ENTITY_COORDS(ent)
        distance = math.ceil(MISC.GET_DISTANCE_BETWEEN_COORDS(my_pos.x, my_pos.y, my_pos.z, ent_pos.x, ent_pos.y,
            ent_pos.z))
        util.toast(distance)
    end)
    menu.click_slider(menu_parent, "最大速度", {"control_ent_max_speed"}, "", 0.0, 1000.0, 30.0, 10.0,function(value)
        ENTITY.SET_ENTITY_MAX_SPEED(ent, value)
    end)

end

--- PED entity type functions ---
function entity_control_ped(menu_parent, ped)
    menu.divider(menu_parent, "Ped")

    local ped_type = PED.GET_PED_TYPE(ped)
    menu.readonly(menu_parent, "PED类型: ", ped_type)

    menu.action(menu_parent, "移除全部武器", {}, "", function()
        WEAPON.REMOVE_ALL_PED_WEAPONS(ped)
    end)

    local weapon_list = {"微型冲锋枪", "特质卡宾步枪", "突击霰弹枪", "火神机枪", "火箭筒", "电磁步枪"}
    local weapon_list_model = {"WEAPON_MICROSMG", "WEAPON_SPECIALCARBINE", "WEAPON_ASSAULTSHOTGUN", "WEAPON_MINIGUN", "WEAPON_RPG", "WEAPON_RAILGUN"}
    menu.textslider(menu_parent, "给予武器", {}, "", weapon_list, function(value)
        local weaponHash = util.joaat(weapon_list_model[value])
        WEAPON.GIVE_WEAPON_TO_PED(ped, weaponHash, -1, false, true)
        WEAPON.SET_CURRENT_PED_WEAPON(ped, weaponHash, false)
    end)

    menu.action(menu_parent, "杀死", {}, "杀死NPC", function()
        ENTITY.SET_ENTITY_HEALTH(ped, 0, 0)
    end)
    menu.action(menu_parent, "复活", {}, "复活NPC", function()
        resurrect_ped(ped)
    end)
    menu.action(menu_parent, "一键无敌强化NPC", {}, "适用于友方NPC", function()
        increase_npc(ped)
    end)

    menu.toggle(menu_parent, "NPC视角", {}, "", function(toggled)
        NETWORK.NETWORK_SET_IN_SPECTATOR_MODE(toggled, ped)
        HUD.SET_MINIMAP_IN_SPECTATOR_MODE(toggled, ped)
    end)

    menu.action(menu_parent, "复制PED服饰", {}, "", function()
        local model = ENTITY.GET_ENTITY_MODEL(ped)
        local outfit = get_outfit(ped)
        if model ~= ENTITY.GET_ENTITY_MODEL(PLAYER.PLAYER_PED_ID()) then
            change_model(PLAYER.PLAYER_ID(), model)
            PED1._SET_PED_EYE_COLOR(PLAYER.PLAYER_ID(), PED1._GET_PED_EYE_COLOR(ped))
            for i = 0, 12 do
                PED.SET_PED_HEAD_OVERLAY(PLAYER.PLAYER_PED_ID(), i, PED1._GET_PED_HEAD_OVERLAY_VALUE(ped, i), 1)
            end
            apply_outfit(outfit.components, outfit.props)
        else
            apply_outfit(outfit.components, outfit.props)
        end
    end)

end

--- VEHICLE entity type functions ---
function entity_control_vehicle(menu_parent, vehicle)
    menu.divider(menu_parent, "Vehicle")

    menu.action(menu_parent, "驾驶载具", {}, "", function()
        drive_vehicle(vehicle)
    end)

    menu.action(menu_parent, "切换引擎", {}, "", function(toggle)
        local is_running = VEHICLE.GET_IS_VEHICLE_ENGINE_RUNNING(vehicle)
        if request_control(vehicle, 3) then
            VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, not is_running, true, true)
        end
    end)
    menu.toggle_loop(menu_parent, "保持引擎启动", {}, "", function()
        VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, true)
        VEHICLE.SET_VEHICLE_LIGHTS(vehicle, 0)
        VEHICLE.SET_VEHICLE_HEADLIGHT_SHADOWS(vehicle, 2)
    end)

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

    menu.click_slider(menu_parent, "向前的速度", {"control_veh_forward_speed"}, "", 0.0, 1000.0, 30.0, 10.0,
        function(value)
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
-- 返回瞄准的实体
function GetEntity_PlayerIsAimingAt(p)
    local ent = NULL
    if PLAYER.IS_PLAYER_FREE_AIMING(p) then
        local ptr = memory.alloc_int()
        if PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(p, ptr) then
            ent = memory.read_int(ptr)
            if ENTITY.IS_ENTITY_A_PED(ent) and PED.IS_PED_IN_ANY_VEHICLE(ent) then
                local vehicle = PED.GET_VEHICLE_PED_IS_IN(ent, false)
                ent = vehicle
            end
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
    -- 绘制准心
    HUD.DISPLAY_SNIPER_SCOPE_THIS_FRAME()
    local ent = GetEntity_PlayerIsAimingAt(players.user())
    if ent ~= NULL and ENTITY.DOES_ENTITY_EXIST(ent) then
        if not isInTable(control_ent_list, ent) then
            table.insert(control_ent_list, ent)
            ---
            local modelHash = ENTITY.GET_ENTITY_MODEL(ent)
            local entity_types = {"No entity", "Ped", "Vehicle", "Object"}
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

            ----选中抖动光标
            local Draw_pos_markers = 0
            menu.on_focus(menu_control_entity, function(direction)
                Draw_pos_markers = 0
                while Draw_pos_markers == 0 and direction ~= 0 do
                    draw_ent_markers(ent)
                    util.yield()
                end
            end)
            menu.on_blur(menu_control_entity, function(direction)
                if direction ~= 0 then
                    Draw_pos_markers = 1
                end
            end)

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

----menu
menu.toggle_loop(entity_control, "开启", {}, "", function()
    entitycontrol()
end)
menu.action(entity_control, "输出武器hash", {}, "", function()
    util.log(WEAPON.GET_SELECTED_PED_WEAPON(PLAYER.PLAYER_PED_ID()))
end)
menu.action(entity_control, "清除记录的实体", {}, "", function()
    clearcontrollog()
end)
menu.divider(entity_control, "实体列表")
