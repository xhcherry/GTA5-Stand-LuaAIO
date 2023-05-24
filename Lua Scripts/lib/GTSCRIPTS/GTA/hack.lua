--GT团队原创功能，CV我直接操你母
vehmanager = off
GTTG(entitymanagerlist, "激活载具管理", {"vehmanager"}, "", function(on)
	vehmanager = on
end)
pedmanager = off
GTTG(entitymanagerlist, "激活NPC管理", {"pedmanager"}, "", function(on)
	pedmanager = on
end)
objectmanager = off
toggleobjmanager = GTTG(entitymanagerlist, "激活物体管理", {"objmanager"}, "", function(on)
	if not objectmanager then
		menu.trigger_commands("objmanager off")
			objectmanager = true
			menu.trigger_commands("objmanager on")
	else
		objectmanager = on
	end
end)
vehmanagerlist = GT(entitymanagerlist, "载具管理面板", {}, "")
vehiclelist = {}
vehhandle = {}
pedmanagerlist = GT(entitymanagerlist, "NPC管理面板", {}, "")
pedlist = {}
pedhandle = {}
objectmanagerlist = GT(entitymanagerlist, "物体管理面板", {}, "")
objectlist = {}
objecthandle = {}
util.create_tick_handler(function()
	vehmanagerhandle = {}
	if (INTERIOR.GET_INTERIOR_FROM_ENTITY(plyped()) == 0) and vehmanager then
		vehmanagerhandle = entities.get_all_vehicles_as_handles()
	end
	pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
	for _, vehicule in ipairs(vehmanagerhandle) do
		if ENTITY.DOES_ENTITY_EXIST(vehicule) and (vehiclelist[vehicule] == nil) and vehmanager and (INTERIOR.GET_INTERIOR_FROM_ENTITY(plyped()) == 0) then
			vehhandle[vehicule] = vehicule
			manufacturer = WIRI_HUD.GET_FILENAME_FOR_AUDIO_CONVERSATION(VEHICLE.GET_MAKE_NAME_FROM_VEHICLE_MODEL(ENTITY.GET_ENTITY_MODEL(vehicule)))
			if (manufacturer == "NULL") then
				manufacturer = ""
			end
			carname = WIRI_HUD.GET_FILENAME_FOR_AUDIO_CONVERSATION(util.reverse_joaat(ENTITY.GET_ENTITY_MODEL(vehicule)))
			if (carname == "NULL") then
				carname = ""
			end
			espace = " "
			if (manufacturer == "") then
				espace = ""
			end
			posnameveh = ENTITY.GET_ENTITY_COORDS(vehicule)
			posnameveh = v3.distance(pos, posnameveh)
			finalvehname = manufacturer..espace..carname.." ["..math.floor(posnameveh).."m]"
			if (finalvehname == "") then 
				finalvehname = util.reverse_joaat(ENTITY.GET_ENTITY_MODEL(vehicule))
			end
			vehlist = menu.list(vehmanagerlist, finalvehname, {}, "")
			vehiclelist[vehicule] = vehlist
			GTAC(vehiclelist[vehicule], "爆炸", {""}, "", function()
				requestControlLoop(vehhandle[vehicule])
				NETWORK.NETWORK_EXPLODE_VEHICLE(vehhandle[vehicule], true, true, false)
			end)
			GTAC(vehiclelist[vehicule], "传送到我", {""}, "", function()
				requestControlLoop(vehhandle[vehicule])
				ENTITY.SET_ENTITY_COORDS_NO_OFFSET(vehhandle[vehicule], pos.x, pos.y, pos.z, false, false, false)
			end)
			GTAC(vehiclelist[vehicule], "传送至", {""}, "", function()
				requestControlLoop(vehhandle[vehicule])
				posnameobjectfunc = ENTITY.GET_ENTITY_COORDS(vehhandle[vehicule])
				ENTITY.SET_ENTITY_COORDS_NO_OFFSET(plyped(), posnameobjectfunc.x, posnameobjectfunc.y, posnameobjectfunc.z+2, false, false, false)
			end)
			menu.click_slider(vehiclelist[vehicule], "送走", {""}, "", -1000, 1000, 100, 100, function(s)
				requestControlLoop(vehhandle[vehicule])
				VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehhandle[vehicule], s)
			end)
            GTAC(vehiclelist[vehicule], "分离", {""}, "", function ()
                requestControlLoop(vehhandle[vehicule])
                local doors = VEHICLE.GET_NUMBER_OF_VEHICLE_DOORS(vehhandle[vehicule])
                VEHICLE.POP_OUT_VEHICLE_WINDSCREEN(vehhandle[vehicule])
                for i= 0, doors do
                VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehhandle[vehicule], i, false)
                end
            end)
			GTAC(vehiclelist[vehicule], "修复", {""}, "", function()
				requestControlLoop(vehhandle[vehicule])
				fixveh(vehhandle[vehicule])
			end)
			GTAC(vehiclelist[vehicule], "驾驶", {""}, "", function()
				requestControlLoop(vehhandle[vehicule])
				if not (VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehhandle[vehicule], -1) == 0) then
					pedinseat = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehhandle[vehicule], -1)
					TASK.CLEAR_PED_TASKS_IMMEDIATELY(pedinseat)
				end
				PED.SET_PED_INTO_VEHICLE(plyped(), vehhandle[vehicule], -1)
			end)
			GTAC(vehiclelist[vehicule], "删除", {""}, "", function()
				requestControlLoop(vehhandle[vehicule])
				entities.delete_by_handle(vehhandle[vehicule])
			end)
		end
	end
	for key, value in pairs(vehiclelist) do
		if ENTITY.DOES_ENTITY_EXIST(key) and vehmanager and (INTERIOR.GET_INTERIOR_FROM_ENTITY(plyped()) == 0) then
			manufacturer = WIRI_HUD.GET_FILENAME_FOR_AUDIO_CONVERSATION(VEHICLE.GET_MAKE_NAME_FROM_VEHICLE_MODEL(ENTITY.GET_ENTITY_MODEL(key)))
			if (manufacturer == "NULL") then
				manufacturer = ""
			end
			carname = WIRI_HUD.GET_FILENAME_FOR_AUDIO_CONVERSATION(util.reverse_joaat(ENTITY.GET_ENTITY_MODEL(key)))
			if (carname == "NULL") then
				carname = ""
			end
			espace = " "
			if (manufacturer == "") then
				espace = ""
			end
			posnameveh = ENTITY.GET_ENTITY_COORDS(key)
			posnameveh = v3.distance(pos, posnameveh)
			finalvehname = manufacturer..espace..carname.." ["..math.floor(posnameveh).."m]"
			if (manufacturer..espace..carname == "") then 
				finalvehname = util.reverse_joaat(ENTITY.GET_ENTITY_MODEL(key)).." ["..math.floor(posnameveh).."m]"
			end
			menu.set_menu_name(value, finalvehname)
		end
	end
	for key, value in pairs(vehiclelist) do
		if not ENTITY.DOES_ENTITY_EXIST(key) and not (vehiclelist[key] == nil) then
			pcall(menu.delete, value)
			vehiclelist[key] = nil
		end
	end
	util.yield()
end)
--
util.create_tick_handler(function()
	pedmanagerhandle = {}
	if (INTERIOR.GET_INTERIOR_FROM_ENTITY(plyped()) == 0) and pedmanager then
		pedmanagerhandle = entities.get_all_peds_as_handles()
	end
	pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
	for _, ped in ipairs(pedmanagerhandle) do
		if ENTITY.DOES_ENTITY_EXIST(ped) and (pedlist[ped] == nil) and pedmanager and (INTERIOR.GET_INTERIOR_FROM_ENTITY(plyped()) == 0) then
			pedhandle[ped] = ped
			pedname = util.reverse_joaat(ENTITY.GET_ENTITY_MODEL(ped))
			posnameped = ENTITY.GET_ENTITY_COORDS(ped)
			posnameped = v3.distance(pos, posnameped)
			finalpedname = pedname.." ["..math.floor(posnameped).."m]"
			pedlistnumber = menu.list(pedmanagerlist, finalpedname, {}, "")
			pedlist[ped] = pedlistnumber
			GTAC(pedlist[ped], "爆炸", {""}, "", function()
				requestControlLoop(pedhandle[ped])
				posped = ENTITY.GET_ENTITY_COORDS(ped)
				FIRE.ADD_EXPLOSION(posped.x, posped.y, posped.z, 0, 1, true, false, 1, false)
			end)
			GTAC(pedlist[ped], "传送到我", {""}, "", function()
				requestControlLoop(pedhandle[ped])
				ENTITY.SET_ENTITY_COORDS_NO_OFFSET(pedhandle[ped], pos.x, pos.y, pos.z, false, false, false)
			end)
			GTAC(pedlist[ped], "传送至", {""}, "", function()
				requestControlLoop(pedhandle[ped])
				posnameobjectfunc = ENTITY.GET_ENTITY_COORDS(pedhandle[ped])
				ENTITY.SET_ENTITY_COORDS_NO_OFFSET(plyped(), posnameobjectfunc.x, posnameobjectfunc.y, posnameobjectfunc.z+2, false, false, false)
			end)
            GTAC(pedlist[ped], "摔倒", {""}, "", function ()
                requestControlLoop(pedhandle[ped])
                PED.SET_PED_TO_RAGDOLL(pedhandle[ped], 2000, 2000, 0, true, true, true)
            end)
			GTAC(pedlist[ped], "清理", {""}, "", function()
				requestControlLoop(pedhandle[ped])
				TASK.CLEAR_PED_TASKS_IMMEDIATELY(pedhandle[ped])
			end)
			GTAC(pedlist[ped], "删除", {""}, "", function()
				requestControlLoop(pedhandle[ped])
				entities.delete_by_handle(pedhandle[ped])
			end)
		end
	end
	for key, value in pairs(pedlist) do
		if ENTITY.DOES_ENTITY_EXIST(key) and pedmanager and (INTERIOR.GET_INTERIOR_FROM_ENTITY(plyped()) == 0) then
			pedname = util.reverse_joaat(ENTITY.GET_ENTITY_MODEL(key))
			posnameped = ENTITY.GET_ENTITY_COORDS(key)
			posnameped = v3.distance(pos, posnameped)
			finalpedname = pedname.." ["..math.floor(posnameped).."m]"
			menu.set_menu_name(value, finalpedname)
		end
	end
	for key, value in pairs(pedlist) do
		if not ENTITY.DOES_ENTITY_EXIST(key) and not (pedlist[key] == nil) then
			pcall(menu.delete, value)
			pedlist[key] = nil
		end
	end
	util.yield()
end)
--
util.create_tick_handler(function()
	objectmanagerhandle = {}
	if (INTERIOR.GET_INTERIOR_FROM_ENTITY(plyped()) == 0) and objectmanager then
		objectmanagerhandle = entities.get_all_objects_as_handles()
	end
	pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
	for _, object in ipairs(objectmanagerhandle) do
		if ENTITY.DOES_ENTITY_EXIST(object) and (objectlist[object] == nil) and not (util.reverse_joaat(ENTITY.GET_ENTITY_MODEL(object)) == "") and objectmanager and (INTERIOR.GET_INTERIOR_FROM_ENTITY(plyped()) == 0) then
			objecthandle[object] = object
			objectname = util.reverse_joaat(ENTITY.GET_ENTITY_MODEL(object))
			posnameobject1 = ENTITY.GET_ENTITY_COORDS(object)
			posnameobject1 = v3.distance(pos, posnameobject1)
			finalobjectname = objectname
			objectlistnumber = menu.list(objectmanagerlist, finalobjectname, {}, "")
			objectlist[object] = objectlistnumber
			GTAC(objectlist[object], "爆炸", {""}, "", function()
				requestControlLoop(objecthandle[object])
				posobject = ENTITY.GET_ENTITY_COORDS(object)
				FIRE.ADD_EXPLOSION(posobject.x, posobject.y, posobject.z, 0, 1, true, false, 1, false)
			end)
			GTAC(objectlist[object], "传送到我", {""}, "", function()
				requestControlLoop(objecthandle[object])
				ENTITY.SET_ENTITY_COORDS_NO_OFFSET(objecthandle[object], pos.x, pos.y, pos.z, false, false, false)
			end)
			GTAC(objectlist[object], "传送至", {""}, "", function()
				requestControlLoop(objecthandle[object])
				posnameobjectfunc = ENTITY.GET_ENTITY_COORDS(objecthandle[object])
				ENTITY.SET_ENTITY_COORDS_NO_OFFSET(plyped(), posnameobjectfunc.x, posnameobjectfunc.y, posnameobjectfunc.z+2, false, false, false)
			end)
			GTAC(objectlist[object], "删除", {""}, "", function()
				requestControlLoop(objecthandle[object])
				entities.delete_by_handle(objecthandle[object])
			end)
		end
		util.yield(10)
	end
end)
util.create_tick_handler(function()
for key, value in pairs(objectlist) do
		if not ENTITY.DOES_ENTITY_EXIST(key) and not (objectlist[key] == nil) then
			pcall(menu.delete, value)
			objectlist[key] = nil
		end
	end
end)