util.require_natives("1640181023")
local num_for_torque = 500 
menu.slider(VehicleSpeed, "载具速度", {"torquespeed"}, "", 1, 2147483647, 500, 1, function(s)
	num_for_torque = s
end)

menu.toggle_loop(VehicleSpeed, "开启/关闭", {"torquetoggle"}, "", function()
    local veh = entities.get_user_vehicle_as_handle()
    if veh ~= nil then
        if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(veh) then
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
        end
        VEHICLE.MODIFY_VEHICLE_TOP_SPEED(veh, num_for_torque)
        ENTITY.SET_ENTITY_MAX_SPEED(veh, num_for_torque)
    end
end)
