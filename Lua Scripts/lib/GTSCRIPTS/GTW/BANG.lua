local function request_control_of_entity_once(ent)
    if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) and util.is_session_started() then
        local netid = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(ent)
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netid, true)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ent)
    end
end

local cur_state = 1
menu.toggle_loop(funfeatures, "行人甩头", {"pedheadbang"}, "", function(on)
    local all_peds = entities.get_all_peds_as_handles()
    for k,ped in pairs(all_peds) do 
        if not PED.IS_PED_A_PLAYER(ped) then
            request_control_of_entity_once(ped)
            TASK.CLEAR_PED_TASKS(ped)
            local c
            if cur_state == 1 then 
                c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 1.0, 10.0)
            else
                c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 1.0, -10.0)
            end
            TASK.TASK_LOOK_AT_COORD(ped, c.x, c.y, c.z, -1, 0, 2)
        end
    end
    if cur_state == 1 then 
        cur_state = 2 
    else
        cur_state = 1
    end
    util.yield(200)
end)

util.keep_running()