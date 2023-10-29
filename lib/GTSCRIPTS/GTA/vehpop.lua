------------------
-- 载具碰撞反应
------------------
local vehicle_collision_reaction = {
    hit_vehicle = 0,
    exclude_mission = true,
    -- reaction --
    kill_engine = false,
    burst_tyre = false,
    push_away = false,
    push_away_strength = 50,
    launch = false,
    launch_height = 30,
}

menu.toggle_loop(Vehicle_Collision_Reaction, "启用", {}, "", function()
    if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
        local player_veh = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)

        if ENTITY.HAS_ENTITY_BEEN_DAMAGED_BY_ANY_VEHICLE(player_veh) then
            local vehicle = ENTITY._GET_LAST_ENTITY_HIT_BY_ENTITY(player_veh)
            if ENTITY.IS_ENTITY_A_VEHICLE(vehicle) then
                if not IS_PLAYER_VEHICLE(vehicle) then
                    if vehicle_collision_reaction.exclude_mission and ENTITY.IS_ENTITY_A_MISSION_ENTITY(vehicle) then
                    else
                        --请求控制
                        RequestControl(vehicle)
                        --破坏引擎
                        if vehicle_collision_reaction.kill_engine then
                            VEHICLE.SET_VEHICLE_ENGINE_HEALTH(vehicle, -4000)
                        end
                        --爆胎
                        if vehicle_collision_reaction.burst_tyre then
                            for i = 0, 5 do
                                if not VEHICLE.IS_VEHICLE_TYRE_BURST(vehicle, i, true) then
                                    VEHICLE.SET_VEHICLE_TYRE_BURST(vehicle, i, true, 1000.0)
                                end
                            end
                        end
                        --推开
                        if vehicle_collision_reaction.push_away then
                            local force = ENTITY.GET_ENTITY_COORDS(vehicle)
                            v3.sub(force, ENTITY.GET_ENTITY_COORDS(player_veh))
                            v3.normalise(force)
                            v3.mul(force, vehicle_collision_reaction.push_away_strength)
                            ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 3, force.x, force.y, force.z,
                                0, 0, 0.5, 0,
                                false, false, true, false, false)
                        end
                        --发射上天
                        if vehicle_collision_reaction.launch then
                            ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0.0, 0.0, vehicle_collision_reaction.launch_height,
                                0.0, 0.0, 0.0, 0,
                                false, false, true, false, false)
                        end
                    end
                end
            end
        end
    end
end)

menu.toggle(Vehicle_Collision_Reaction, "排除任务载具", {}, "", function(toggle)
    vehicle_collision_reaction.exclude_mission = toggle
end, true)

menu.divider(Vehicle_Collision_Reaction, "反应")
menu.toggle(Vehicle_Collision_Reaction, "破坏引擎", {}, "", function(toggle)
    vehicle_collision_reaction.kill_engine = toggle
end)
menu.toggle(Vehicle_Collision_Reaction, "爆胎", {}, "", function(toggle)
    vehicle_collision_reaction.burst_tyre = toggle
end)
menu.slider(Vehicle_Collision_Reaction, "推开强度", { "veh_collision_reaction_push_away" }, "",
    0, 1000, 50, 10, function(value)
    vehicle_collision_reaction.push_away_strength = value
end)
menu.toggle(Vehicle_Collision_Reaction, "推开", {}, "", function(toggle)
    vehicle_collision_reaction.push_away = toggle
end)
menu.slider(Vehicle_Collision_Reaction, "上天高度", { "veh_collision_reaction_launch" }, "",
    0, 1000, 10, 10, function(value)
    vehicle_collision_reaction.launch_height = value
end)
menu.toggle(Vehicle_Collision_Reaction, "发射上天", {}, "", function(toggle)
    vehicle_collision_reaction.launch = toggle
end)
menu.action(Vehicle_Collision_Reaction, "在动画中摧毁载具", { "explode_veh_cutscence" }, "当前载具或上一辆载具",
    function()
        local vehicle = entities.get_user_vehicle_as_handle()
        if vehicle ~= 0 then
            RequestControl(vehicle)
            VEHICLE.EXPLODE_VEHICLE_IN_CUTSCENE(vehicle)
        end
    end)
menu.action(Vehicle_Collision_Reaction, "在动画中摧毁所有载具", { "explode_all_veh_cutscence" }, "排除个人载具",
    function()
        for _, vehicle in pairs(entities.get_all_vehicles_as_handles()) do
            if vehicle ~= entities.get_user_personal_vehicle_as_handle() then
                RequestControl(vehicle)
                VEHICLE.EXPLODE_VEHICLE_IN_CUTSCENE(vehicle)
            end
        end
    end)