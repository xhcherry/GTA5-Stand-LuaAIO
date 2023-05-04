

-----保镖直升机
function addRelationshipGroup(name)
    local ptr = memory.alloc_int()
    PED.ADD_RELATIONSHIP_GROUP(name, ptr)
    local rel = memory.read_int(ptr)
    return rel
end
relationship = {}
function relationship:friendly(ped)
    if not PED.DOES_RELATIONSHIP_GROUP_EXIST(self.friendly_group) then
        self.friendly_group = addRelationshipGroup("friendly_group")
        PED.SET_RELATIONSHIP_BETWEEN_GROUPS(0, self.friendly_group, self.friendly_group)
    end
    PED.SET_PED_RELATIONSHIP_GROUP_HASH(ped, self.friendly_group)
end
function Bodyguard_helicopter(value)
    bodyguard_heli.name = sel_heli_model_list[value]
end
function Bodyguard_helicopter_invincible(toggle)
    bodyguard_heli.heli_godmode = toggle
end
function Spawn_bodyguard_helicopter()
    local heli_hash = util.joaat(bodyguard_heli.name)
    local ped_hash = util.joaat("s_m_y_blackops_01")
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    pos.x = pos.x + math.random(-10, 10)
    pos.y = pos.y + math.random(-10, 10)
    pos.z = pos.z + 30
    requestModels(ped_hash, heli_hash)
    relationship:friendly(players.user_ped())
    local heli = entities.create_vehicle(heli_hash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
    if not ENTITY.DOES_ENTITY_EXIST(heli) then
        util.toast("Failed to create vehicle. Please try again")
        return
    else
        local heliNetId = NETWORK.VEH_TO_NET(heli)
        if NETWORK.NETWORK_GET_ENTITY_IS_NETWORKED(NETWORK.NET_TO_PED(heliNetId)) then
            NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(heliNetId, true)
        end
        NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(heliNetId, players.user(), true)
        VEHICLE.SET_VEHICLE_ENGINE_ON(heli, true, true, true)
        VEHICLE.SET_HELI_BLADES_FULL_SPEED(heli)
        VEHICLE.SET_VEHICLE_SEARCHLIGHT(heli, true, true)
        addBlipForEntity(heli, 422, 26)
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
    --health
    PED.SET_PED_MAX_HEALTH(pilot, 1000)
    ENTITY.SET_ENTITY_HEALTH(pilot, 1000)
    ENTITY.SET_ENTITY_INVINCIBLE(pilot, bodyguard_heli.ped_godmode)
    table.insert(heli_ped_list, pilot)
    --local seats = VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(heli)
    for seat = 0, 2 do
        local ped = entities.create_ped(29, ped_hash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
        local pedNetId = NETWORK.PED_TO_NET(ped)
        if NETWORK.NETWORK_GET_ENTITY_IS_NETWORKED(ped) then
            NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(pedNetId, true)
        end
        NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(pedNetId, players.user(), true)
        PED.SET_PED_INTO_VEHICLE(ped, heli, seat)
        --fight
        WEAPON.GIVE_WEAPON_TO_PED(ped, util.joaat("weapon_mg"), -1, false, true)
        WEAPON.SET_PED_INFINITE_AMMO_CLIP(ped, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 3, false)
        PED.SET_PED_COMBAT_MOVEMENT(ped, 2)
        PED.SET_PED_COMBAT_ABILITY(ped, 2)
        PED.SET_PED_COMBAT_RANGE(ped, 2)
        PED.SET_PED_SEEING_RANGE(ped, 500.0)
        PED.SET_PED_HEARING_RANGE(ped, 500.0)
        PED.SET_PED_TARGET_LOSS_RESPONSE(ped, 1)
        PED.SET_PED_HIGHLY_PERCEPTIVE(ped, true)
        PED.SET_PED_VISUAL_FIELD_PERIPHERAL_RANGE(ped, 500.0)
        PED.SET_COMBAT_FLOAT(ped, 10, 500.0)
        PED.SET_PED_SHOOT_RATE(ped, 1000.0)
        PED.SET_PED_ACCURACY(ped, 100.0)
        PED.SET_PED_CAN_BE_SHOT_IN_VEHICLE(ped, true)
        --health
        PED.SET_PED_MAX_HEALTH(ped, 1000)
        ENTITY.SET_ENTITY_HEALTH(ped, 1000)
        ENTITY.SET_ENTITY_INVINCIBLE(ped, bodyguard_heli.ped_godmode)
        relationship:friendly(ped)
        table.insert(heli_ped_list, ped)
    end
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(heli_hash)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(ped_hash)
end
function delete_bodyguard_helicopter()
    for k, ent in pairs(heli_ped_list) do
        entities.delete_by_handle(ent)
    end
    for k, ent in pairs(heli_list) do
        entities.delete_by_handle(ent)
    end
end









----炸鱼
function fried_fish(pid)
    local Ptools_PanTable = {}
    local Ptools_PanCount = 1
    local targetped = PLAYER.GET_PLAYER_PED(pid)
    local targetcoords = ENTITY.GET_ENTITY_COORDS(targetped)
    local hash = util.joaat("tug")
    STREAMING.REQUEST_MODEL(hash)
    for i = 1, 20 do
        Ptools_PanTable[Ptools_PanCount] = VEHICLE.CREATE_VEHICLE(hash, targetcoords.x, targetcoords.y, targetcoords.z, 0, true, true, true)
        local netID = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(Ptools_PanTable[Ptools_PanCount])
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(Ptools_PanTable[Ptools_PanCount])
        NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(netID)
        NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(netID)
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netID, false)
        NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(netID, pid, true)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Ptools_PanTable[Ptools_PanCount], true, false)
        ENTITY.SET_ENTITY_VISIBLE(Ptools_PanTable[Ptools_PanCount], false, 0)
        Ptools_PanCount = Ptools_PanCount + 1
    end
end
----泰坦号轰炸
function Titan_bombing(pid)
    while not STREAMING.HAS_MODEL_LOADED(447548909) do
        STREAMING.REQUEST_MODEL(447548909)
        util.yield(10)
    end
    local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
    spam_amount = 300
    while spam_amount >= 1 do
        entities.create_vehicle(447548909, PlayerPedCoords, 0)
        spam_amount = spam_amount - 1
        util.yield(10)
    end
end
----渲染粒子
function Render_particles(pid)
    local player_pos = players.get_position(pid)
    request_ptfx_asset("scr_rcbarry2")
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_rcbarry2")
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
        "scr_clown_death", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
    request_ptfx_asset("scr_rcbarry2")
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_rcbarry2")
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
        "scr_exp_clown", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
    request_ptfx_asset("scr_ch_finale")
   GRAPHICS.USE_PARTICLE_FX_ASSET("scr_ch_finale")
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
        "scr_ch_finale_drill_sparks", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
    request_ptfx_asset("scr_ch_finale")
    while not STREAMING.HAS_MODEL_LOADED(447548909) do
        STREAMING.REQUEST_MODEL(447548909)
        end
    local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
    spam_amount = 1000
    while spam_amount >= 2 do
        entities.create_vehicle(447548909, PlayerPedCoords, 0)
        spam_amount = spam_amount - 2
    end
    util.yield(100)
end


--传送所有PED给玩家
function tpTableToPlayer(tbl, pid)
    if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) then
        local c = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
        for _, v in pairs(tbl) do
            if (not PED.IS_PED_A_PLAYER(v)) then
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(v, c.x, c.y, c.z, false, false, false)
            end
        end
    end
end
function TpAllPeds(pid)
    local pedHandles = entities.get_all_peds_as_handles()
    tpTableToPlayer(pedHandles, pid)
end
--传送所有载具给玩家
function TpAllVehs(pid)
    local vehHandles = entities.get_all_vehicles_as_handles()
    tpTableToPlayer(vehHandles, pid)
end
--传送所有物体给玩家
function TpAllObjects(pid)
    local objHandles = entities.get_all_objects_as_handles()
    tpTableToPlayer(objHandles, pid)
end

----镭射炮
local Laserhash = util.joaat("VEHICLE_WEAPON_PLAYER_LAZER")
local lastShot = newTimer()
local Lasersound = Sound_new("Fire_Loop", "DLC_IE_VV_Gun_Player_Sounds")
function DisableControlActions()
    PAD.DISABLE_CONTROL_ACTION(0, 106, true)
    PAD.DISABLE_CONTROL_ACTION(0, 122, true)
    PAD.DISABLE_CONTROL_ACTION(0, 135, true)
    PAD.DISABLE_CONTROL_ACTION(0, 140, true)
    PAD.DISABLE_CONTROL_ACTION(0, 141, true)
    PAD.DISABLE_CONTROL_ACTION(0, 142, true)
    PAD.DISABLE_CONTROL_ACTION(0, 263, true)
    PAD.DISABLE_CONTROL_ACTION(0, 264, true)
end
function Lasersound:hasFinished()
	return AUDIO.HAS_SOUND_FINISHED(self.Id)
end
function Lasersound:stop()
	if self.Id ~= -1 then
        AUDIO.STOP_SOUND(self.Id)
        AUDIO.RELEASE_SOUND_ID(self.Id)
        self.Id = -1
    end
end
function Lasersound:playFromEntity(entity)
	if self.Id == -1 then
		self.Id = AUDIO.GET_SOUND_ID()
		AUDIO.PLAY_SOUND_FROM_ENTITY(self.Id, self.name, entity, self.reference, true, 0)
	end
end
function Laser_cannon()
    --显示按键
    show_button()
    sf.SET_DATA_SLOT(0,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 46, true), '镭射炮')
    show_button2()
    --
    HUD.DISPLAY_SNIPER_SCOPE_THIS_FRAME()
    DisableControlActions()
    if not WEAPON.HAS_WEAPON_ASSET_LOADED(Laserhash) then
        WEAPON.REQUEST_WEAPON_ASSET(Laserhash, 31, 26)
    end
    if not PAD.IS_DISABLED_CONTROL_PRESSED(51, 51) then
        if not Lasersound:hasFinished() then
            Lasersound:stop()
        end
    elseif lastShot.elapsed() > 100 then
        local pos = PED.GET_PED_BONE_COORDS(players.user_ped(), 0x322C, 0.0, 0.0, 0.0)
        local offset = get_offset_from_cam(80)
        if  Lasersound:hasFinished() then
            Lasersound:playFromEntity(players.user_ped())
            AUDIO.SET_VARIABLE_ON_SOUND(Lasersound.Id, "fireRate", 10.0)
        end
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(
            pos.x, pos.y, pos.z,
            offset.x, offset.y, offset.z,
            200,
            true,
            Laserhash, players.user_ped(), true, true, -1.0
        )
        lastShot.reset()
    end
end




----RPG自动瞄准器
function GetClosestPlayerWithRange_Whitelist(range, inair)
    local pedPointers = entities.get_all_peds_as_pointers()
    local rangesq = range * range
    local ourCoords = ENTITY.GET_ENTITY_COORDS(GetLocalPed())
    local tbl = {}
    local closest_player = 0
    for i = 1, #pedPointers do
        local tarcoords = entities.get_position(pedPointers[i])
        local vdist = SYSTEM.VDIST2(ourCoords.x, ourCoords.y, ourCoords.z, tarcoords.x, tarcoords.y, tarcoords.z)
        if vdist <= rangesq then
            local handle = entities.pointer_to_handle(pedPointers[i])
            if (inair and (ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(handle) >= 9)) or (not inair) then --air check
                local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(handle)
                if not AIM_WHITELIST[pid] then --this is the whitelist check.
                    tbl[#tbl+1] = handle
                end
            end
        end
    end
    if tbl ~= nil then
        local dist = 999999
        for i = 1, #tbl do
            if tbl[i] ~= GetLocalPed() then
                if PED.IS_PED_A_PLAYER(tbl[i]) then
                    local tarcoords = ENTITY.GET_ENTITY_COORDS(tbl[i])
                    local e = SYSTEM.VDIST2(ourCoords.x, ourCoords.y, ourCoords.z, tarcoords.x, tarcoords.y, tarcoords.z)
                    if e < dist then
                        dist = e
                        closest_player = tbl[i]
                    end
                end
            end
        end
    end
    if closest_player ~= 0 then
        return closest_player
    else
        return nil
    end
end
function RPG_Automatic_sight(on)
    if on then
        local Chosen_Rocket_Hash = "-1707997257"
        while true do
            local localped = GetLocalPed()
            local localcoords = ENTITY.GET_ENTITY_COORDS(GetLocalPed())
            local forOffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(localped, 0, 5, 0)
            RRocket = OBJECT.GET_CLOSEST_OBJECT_OF_TYPE(forOffset.x, forOffset.y, forOffset.z, 10, Chosen_Rocket_Hash, false, true, true, true)
            local p
            if missile_settings.multitarget then
                if missile_settings.air_target then
                    p = GetClosestPlayerWithRange_Whitelist_DisallowEntities(missile_settings.radius, MISSILE_ENTITY_TABLE, true)
                else
                    p = GetClosestPlayerWithRange_Whitelist_DisallowEntities(missile_settings.radius, MISSILE_ENTITY_TABLE, false)
                end
            elseif missile_settings.multiped then
                if missile_settings.air_target then
                    p = GetClosestNonPlayerPedWithRange_DisallowedEntities(missile_settings.radius, MISSILE_ENTITY_TABLE, true)
                else
                    p = GetClosestNonPlayerPedWithRange_DisallowedEntities(missile_settings.radius, MISSILE_ENTITY_TABLE, false)
                end
            elseif not missile_settings.multitarget then
                if missile_settings.air_target then
                    p = GetClosestPlayerWithRange_Whitelist(missile_settings.radius, true)
                else
                    p = GetClosestPlayerWithRange_Whitelist(missile_settings.radius, false)
                end
            end
            local ppcoords = ENTITY.GET_ENTITY_COORDS(p)
            if (RRocket ~= 0) and (p ~= nil) and (not PED.IS_PED_DEAD_OR_DYING(p)) and (not AIM_WHITELIST[NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(p)]) and (PED.IS_PED_SHOOTING(localped)) and (not players.is_in_interior(NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(p))) and (ppcoords.z > 1) then
                util.create_thread(function ()
                    local plocalized = p
                    local msl = RRocket
                    if missile_settings.multitarget then
                        MISSILE_ENTITY_TABLE[#MISSILE_ENTITY_TABLE+1] = plocalized
                    end
                    if (ENTITY.HAS_ENTITY_CLEAR_LOS_TO_ENTITY(localped, plocalized, 17) and missile_settings.los) or not missile_settings.los or MISL_AIR then
                        if SE_Notifications then
                            util.toast("前兆完成！")
                        end
                        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(msl)
                        if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(msl) then
                            for i = 1, 10 do
                                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(msl)
                            end
                        else
                            if SE_Notifications then
                                util.toast("有控制权")
                            end
                        end
                        local aircount = 1
                        Missile_Camera = 0
                        STREAMING.REQUEST_NAMED_PTFX_ASSET(missile_particles.dictionary)
                        while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(missile_particles.dictionary) do
                            STREAMING.REQUEST_NAMED_PTFX_ASSET(missile_particles.dictionary)
                            util.yield()
                        end
                        GRAPHICS.USE_PARTICLE_FX_ASSET(missile_particles.dictionary)
                        while ENTITY.DOES_ENTITY_EXIST(msl) do
                            if SE_Notifications then
                                util.toast("rocket exists")
                            end
                            local pcoords2 = ENTITY.GET_ENTITY_COORDS(plocalized)
                            local pcoords = GetTableFromV3Instance(pcoords2)
                            local lc2 = ENTITY.GET_ENTITY_COORDS(msl)
                            local lc = GetTableFromV3Instance(lc2)
                            local look2 = v3.lookAt(lc2, pcoords2)
                            local look = GetTableFromV3Instance(look2)
                            local dir2 = v3.toDir(look2)
                            local dir = GetTableFromV3Instance(dir2)
                            if missile_settings.ptfx then
                                STREAMING.REQUEST_NAMED_PTFX_ASSET(missile_particles.dictionary)
                                while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(missile_particles.dictionary) do
                                    STREAMING.REQUEST_NAMED_PTFX_ASSET(missile_particles.dictionary)
                                    util.yield()
                                end
                                GRAPHICS.USE_PARTICLE_FX_ASSET(missile_particles.dictionary)
                                GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(missile_particles.name, lc.x, lc.y, lc.z, 0, 0, 0, 0.4 * missile_settings.ptfx_scale, false, false, false, true)
                            end
                            if aircount < 2 and MISL_AIR then
                                if ENTITY.DOES_ENTITY_EXIST(msl) then
                                    ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(msl, 1, 0, 0, 2700, true, false, true, true)
                                    aircount = aircount + 1
                                    util.yield(1100)
                                end
                            end
                            local lookCountD = 0
                            if MISL_AIR then
                                if missile_settings.cam then
                                    if not CAM.DOES_CAM_EXIST(Missile_Camera) then
                                        if SE_Notifications then
                                            util.toast("相机设置")
                                        end
                                        CAM.DESTROY_ALL_CAMS(true)
                                        Missile_Camera = CAM.CREATE_CAM("DEFAULT_SCRIPTED_CAMERA", true)
                                        CAM.SET_CAM_ACTIVE(Missile_Camera, true)
                                        CAM.RENDER_SCRIPT_CAMS(true, false, 0, true, true, 0)
                                    end
                                end
                                local distx = math.abs(lc.x - pcoords.x)
                                local disty = math.abs(lc.y - pcoords.y)
                                local distz = math.abs(lc.z - pcoords.z)
                                if missile_settings.cam then
                                    local ddisst = GENERIC_SYSTEM.VDIST(pcoords.x, pcoords.y, pcoords.z, lc.x, lc.y, lc.z)
                                    if ddisst > 50 then
                                        local camcoordv3 = CAM.GET_CAM_COORD(Missile_Camera)
                                        local look3 = v3.lookAt(camcoordv3, lc2)
                                        local look4 = GetTableFromV3Instance(look3)
                                        local backoffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(msl, 10, 10, -2)
                                        CAM.SET_CAM_COORD(Missile_Camera, backoffset.x, backoffset.y, backoffset.z)
                                        if lookCountD < 1 then
                                            CAM.SET_CAM_ROT(Missile_Camera, look4.x, look4.y, look4.z, 2)
                                            lookCountD = lookCountD + 1
                                        end
                                    else
                                        local camcoordv3 = CAM.GET_CAM_COORD(Missile_Camera)
                                        local look3 = v3.lookAt(camcoordv3, lc2)
                                        local look4 = GetTableFromV3Instance(look3)
                                        CAM.SET_CAM_ROT(Missile_Camera, look4.x, look4.y, look4.z, 2)
                                    end
                                end
                                ENTITY.SET_ENTITY_ROTATION(msl, look.x, look.y, look.z, 2, true)
                                ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(msl, 1, dir.x * missile_settings.speed * distx, dir.y * missile_settings.speed * disty, dir.z * missile_settings.speed * distz, true, false, true, true)
                                util.yield()
                            else
                                ENTITY.SET_ENTITY_ROTATION(msl, look.x, look.y, look.z, 2, true)
                                ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(msl, 1, dir.x * missile_settings.speed, dir.y * missile_settings.speed, dir.z * missile_settings.speed, true, false, true, true)
                                util.yield()
                            end
                        end
                        if missile_settings.cam then
                            util.yield(2000)
                            if SE_Notifications then
                                util.toast("相机删除")
                            end
                            CAM.RENDER_SCRIPT_CAMS(false, false, 0, true, true, 0)
                            if CAM.IS_CAM_ACTIVE(Missile_Camera) then
                                CAM.SET_CAM_ACTIVE(Missile_Camera, false)
                            end
                            CAM.DESTROY_CAM(Missile_Camera, true)
                        end
                    end
                    if missile_settings.multitarget then
                        table.remove(MISSILE_ENTITY_TABLE, GetValueIndexFromTable(MISSILE_ENTITY_TABLE, plocalized))
                        util.toast("已删除的值" .. tostring(plocalized) .. " at index " .. tostring(GetValueIndexFromTable(MISSILE_ENTITY_TABLE, p)))
                    end
                end)
            end
            util.yield()
        end
    end
end




------自动驾驶
local drivestyle = 786603
local drivespeed = 20.00
function drivestylee(index)
    drivestyle = drivestyletables[index]
end
function drivespeedd(value)
    drivespeed = value / 100
end
function Auto_driving(toggle)
    toggled = toggle
    local pos = players.get_position(players.user())
    local vehicle = entities.get_user_vehicle_as_handle()
    jesus = util.joaat("u_m_m_jesus_01")
    RequestModel(jesus)
    if toggled then
        if not PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then 
			util.toast(lang.get_localised(-474174214))
            menu.set_value(jesus_toggle, false)
        util.stop_thread() end
        
        jesus_ped = entities.create_ped(26, jesus, pos, 0)
        ENTITY.SET_ENTITY_INVINCIBLE(jesus_ped, true)
        PED.SET_PED_INTO_VEHICLE(players.user_ped(), vehicle, -2)
        PED.SET_PED_INTO_VEHICLE(jesus_ped, vehicle, -1)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(jesus_ped, true)
        PED.SET_PED_KEEP_TASK(jesus_ped, true)

        if HUD.IS_WAYPOINT_ACTIVE() then
            local waypoint = HUD.GET_BLIP_COORDS(HUD.GET_FIRST_BLIP_INFO_ID(8))
            TASK1.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE(jesus_ped, vehicle, waypoint, drivespeed, drivestyle, 0.0)
                while toggled do
                    if not HUD.IS_WAYPOINT_ACTIVE() then
                        util.toast("自动驾驶结束")
                        menu.set_value(jesus_toggle, false)
                    end
                    util.yield()
                end
        else
            util.toast("请先设置一个导航点. :)")
            menu.set_value(jesus_toggle, false)
        end
        util.yield()
    else
        if jesus_ped ~= nil then 
            entities.delete_by_handle(jesus_ped)
            PED.SET_PED_INTO_VEHICLE(players.user_ped(), vehicle, -1)
        end
    end
    while toggled do
        local height = ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(vehicle)
        local upright_value = ENTITY.GET_ENTITY_UPRIGHT_VALUE(vehicle)
        if height < 5.0 and upright_value < 0.0 then
            VEHICLE.SET_VEHICLE_ON_GROUND_PROPERLY(vehicle)
        end
        util.yield()
    end
end

-----特斯拉自动驾驶
function Tesla_Autopilot(toggled)
    local player = players.user_ped()
    local playerpos = ENTITY.GET_ENTITY_COORDS(player, false)
    local tesla_ai = util.joaat("u_m_y_baygor")
    local tesla = util.joaat("raiden")
    request_model(tesla_ai)
    request_model(tesla)
    if toggled then     
        if PED.IS_PED_IN_ANY_VEHICLE(player, true) then
            menu.trigger_commands("deletevehicle")
        end
        tesla_ai_ped = entities.create_ped(26, tesla_ai, playerpos, 0)
        tesla_vehicle = entities.create_vehicle(tesla, playerpos, 0)
        ENTITY.SET_ENTITY_INVINCIBLE(tesla_ai_ped, true)
        ENTITY.SET_ENTITY_VISIBLE(tesla_ai_ped, false)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(tesla_ai_ped, true)
        PED.SET_PED_INTO_VEHICLE(player, tesla_vehicle, -2)
        PED.SET_PED_INTO_VEHICLE(tesla_ai_ped, tesla_vehicle, -1)
        PED.SET_PED_KEEP_TASK(tesla_ai_ped, true)
        VEHICLE.SET_VEHICLE_COLOURS(tesla_vehicle, 111, 111)
        VEHICLE.SET_VEHICLE_MOD(tesla_vehicle, 23, 8, false)
        VEHICLE.SET_VEHICLE_MOD(tesla_vehicle, 15, 1, false)
        VEHICLE.SET_VEHICLE_EXTRA_COLOURS(tesla_vehicle, 111, 147)
        if HUD.IS_WAYPOINT_ACTIVE() then
            local pos = HUD.GET_BLIP_COORDS(HUD.GET_FIRST_BLIP_INFO_ID(8))
            TASK.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE(tesla_ai_ped, tesla_vehicle, pos.x, pos.y, pos.z, 20, 786603, 0)
        else
            TASK.TASK_VEHICLE_DRIVE_WANDER(tesla_ai_ped, tesla_vehicle, 20, 786603)
        end
    else
        if tesla_ai_ped ~= nil then 
            entities.delete_by_handle(tesla_ai_ped)
        end
        if tesla_vehicle ~= nil then 
            entities.delete_by_handle(tesla_vehicle)
        end
    end
end


-----载具效果
local selectedOpt = 1
local lastEffect = newTimer()
function selectedOptt(index)
    selectedOpt = index 
end
function vehicle_effectt()
    local effect = veffects[selectedOpt]
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)
    if ENTITY.DOES_ENTITY_EXIST(vehicle) and not ENTITY.IS_ENTITY_DEAD(vehicle, false) and
        VEHICLE.IS_VEHICLE_DRIVEABLE(vehicle, false) and lastEffect.elapsed() > effect[4] then
            request_fx_asset(effect[1])
        for _, boneName in pairs({"wheel_lf", "wheel_lr", "wheel_rf", "wheel_rr"}) do
            local bone = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(vehicle, boneName)
            GRAPHICS.USE_PARTICLE_FX_ASSET(effect[1])
            GRAPHICS.START_PARTICLE_FX_NON_LOOPED_ON_ENTITY_BONE(
                effect[2],
                vehicle,
                0.0, 0.0, 0.0,
                0.0, 0.0, 0.0,
                bone,
                effect[3],
                false, false, false
            )
        end
        lastEffect.reset()
    end
end


------生成坡道/分离载具零件
function control_vehicle1(pid, output_toast, callback, opts)
    local vehicle = get_player_vehicle_in_control(pid, opts)
    if vehicle ~= 0 then
        callback(vehicle)
        return true
    else
        if output_toast then
            otil.toast("玩家不在车内")
        end
        return false
    end
end


------天基炮
function get_offset_from_gameplay_camera(distance)
	local cam_rot = CAM.GET_GAMEPLAY_CAM_ROT(0)
	local cam_pos = CAM.GET_GAMEPLAY_CAM_COORD()
	local direction = v3.toDir(cam_rot)
	local destination = {
	  x = cam_pos.x + direction.x * distance,
	  y = cam_pos.y + direction.y * distance,
	  z = cam_pos.z + direction.z * distance
	}
	return destination
end
function use_fx_asset(asset)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
		STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
		util.yield(0)
	end
    GRAPHICS.USE_PARTICLE_FX_ASSET(asset)
end
function nuclear_weapon1()
    local last_hit_coords = v3.new()
	if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(players.user_ped(), last_hit_coords) then
        use_fx_asset("scr_xm_orbital")
        GRAPHICS.USE_PARTICLE_FX_ASSET("scr_xm_orbital")
        FIRE.ADD_EXPLOSION(last_hit_coords.x, last_hit_coords.y, last_hit_coords.z, 59, 1, true, false, 1.0, false)
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_xm_orbital_blast", last_hit_coords.x, last_hit_coords.y, last_hit_coords.z, 0, 180, 0, 1.0, true, true, true)
        for i = 1, 4 do
            AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "DLC_XM_Explosions_Orbital_Cannon", players.user_ped(), 0, true, false)
        end
	end
end
-----核弹
function get_distance_between(pos1, pos2)
	if math.type(pos1) == "integer" then
		pos1 = ENTITY.GET_ENTITY_COORDS(pos1)
	end
	if math.type(pos2) == "integer" then 
		pos2 = ENTITY.GET_ENTITY_COORDS(pos2)
	end
	return pos1:distance(pos2)
end
function nuke_expl1(Position)
    local offsets = {
        {10, 0, 0}, {0, 10, 0}, {10, 10, 0}, {-10, 0, 0}, {0, -10, 0}, {-10, -10, 0}, {10, -10, 0}, {-10, 10, 0},
        {20, 0, 0}, {0, 20, 0}, {20, 20, 0}, {-20, 0, 0}, {0, -20, 0}, {-20, -20, 0}, {20, -20, 0}, {-20, 10, 0},
        {30, 0, 0}, {0, 30, 0}, {30, 30, 0}, {-30, 0, 0}, {0, -30, 0}, {-30, -30, 0}, {30, -30, 0}, {-30, 10, 0},
        {10, 30, 0}, {30, 10, 0}, {-30, -10, 0}, {-10, -30, 0}, {-10, 30, 0}, {-30, 10, 0}, {30, -10, 0}, {10, -30, 0},
        {0, 0, 10}, {0, 0, -10}, {0, 0, 20}, {0, 0, -20}
    }
    for _, offset in ipairs(offsets) do
        FIRE.ADD_EXPLOSION(Position.x + offset[1], Position.y + offset[2], Position.z + offset[3], 59, 1.0, true, false, 1.0, false)
    end
end
function nuke_expl2(Position)
    local offsets = {{0,0,-10}, {10,0,-10}, {0,10,-10}, {10,10,-10}, {-10,0,-10}, {0,-10,-10}, {-10,-10,-10}, {10,-10,-10}, {-10,10,-10}}
    for _, offset in ipairs(offsets) do
        FIRE.ADD_EXPLOSION(Position.x + offset[1], Position.y + offset[2], Position.z + offset[3], 59, 1.0, true, false, 1.0, false)
    end
end
function nuke_expl3(Position)
    local offsets = {{10,0,0}, {0,10,0}, {10,10,0}, {-10,0,0}, {0,-10,0}, {-10,-10,0}, {10,-10,0}, {-10,10,0}, {0,0,0}}
    for _, offset in ipairs(offsets) do
        FIRE.ADD_EXPLOSION(Position.x + offset[1], Position.y + offset[2], Position.z + offset[3], 59, 1.0, true, false, 1.0, false)
    end
end
function create_nuke_explosion(Position)
    for count = 1, 17 do
        if count == 1 then
	        FIRE.ADD_EXPLOSION(Position.x, Position.y, Position.z, 59, 1, true, false, 5.0, false)
        elseif count == 2 then
            FIRE.ADD_EXPLOSION(Position.x, Position.y, Position.z, 59, 1, true, false, 1.0, false)
        end
		use_fx_asset("scr_xm_orbital")
	    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_xm_orbital_blast", Position.x, Position.y, Position.z, 0, 180, 0, 4.5, true, true, true)
    end
    nuke_expl1(Position)
	for i = 1, 4 do
		AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "DLC_XM_Explosions_Orbital_Cannon", players.user_ped(), 0, true, false)
	end
    for count = 1, 2 do
        if count == 1 then
	        FIRE.ADD_EXPLOSION(Position.x, Position.y, Position.z-10, 59, 1, true, false, 5.0, false)
        end
		use_fx_asset("scr_xm_orbital")
	    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_xm_orbital_blast", Position.x, Position.y, Position.z-10, 0, 180, 0, 4.5, true, true, true)
    end
    nuke_expl2(Position)
    local size = 1.5
    local positionsZ = {1, 3, 5, 7, 10, 12, 15, 17, 20, 22, 25, 27, 30, 32, 35, 37, 40, 42, 45, 47, 50, 52, 55, 57, 59, 61, 63, 65, 70, 75, 75, 75, 75, 80, 80}
    for i, pos in ipairs(positionsZ) do
        if i == 3 or i == 5 or i == 7 or i == 9 or i == 11 or i == 13 or i == 15 or i == 17 or i == 19 or i == 21 or i == 23 or i == 25 or i == 29 or i == 30 then
        FIRE.ADD_EXPLOSION(Position.x, Position.y, Position.z+pos, 59, 1.0, true, false, 1.0, false)
        end
        use_fx_asset("scr_xm_orbital")
	    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD("scr_xm_orbital_blast", Position.x, Position.y, Position.z+pos, 0, 180, 0, size, true, true, true)

        if i >= 30 and i <= 33 then size = 3.5
        elseif i >= 34 and i <= 35 then size = 3.0
        else size = 1.5 end
        util.yield(10)
    end
    nuke_expl3(Position)
	for _, pid in pairs(players.list(false, true, true)) do
        local distance = get_distance_between(players.get_position(pid), Position)
		if distance < 200 then
			local pid_pos = players.get_position(pid)
			FIRE.ADD_EXPLOSION(pid_pos.x, pid_pos.y, pid_pos.z, 59, 1.0, true, false, 1.0, false)
		end
	end
	local peds = entities.get_all_peds_as_handles()
	for _, ped in pairs(peds) do
		if get_distance_between(ped, Position) > 200 and get_distance_between(ped, Position) < 400 and ped ~= players.user_ped() then
			local ped_pos = ENTITY.GET_ENTITY_COORDS(ped)
			FIRE.ADD_EXPLOSION(ped_pos.x, ped_pos.y, ped_pos.z, 3, 1.0, true, true, 0.1, false)
		end
	end
	local vehicles = entities.get_all_vehicles_as_handles()
    for _, vehicle in pairs(vehicles) do
		if get_distance_between(vehicle, Position) < 400 then
			VEHICLE.EXPLODE_VEHICLE(vehicle, true, false)
		elseif get_distance_between(vehicle, Position) > 200 and get_distance_between(vehicle, Position) < 400 then
			VEHICLE.EXPLODE_VEHICLE(vehicle, true, false)
		end
	end
end
function nuclear_weapon2()
    if PED.IS_PED_SHOOTING(players.user_ped()) then
		local hash = util.joaat("prop_military_pickup_01")
		request_model(hash)
		local player_pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0.0, 5.0, 3.0)
		local dir = {}
		local c2 = {}
		c2 = get_offset_from_gameplay_camera(1000)
		dir.x = (c2.x - player_pos.x) * 1000
		dir.y = (c2.y - player_pos.y) * 1000
		dir.z = (c2.z - player_pos.z) * 1000
		local nuke = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, player_pos.x, player_pos.y, player_pos.z, true, false, false)
		ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(nuke, players.user_ped(), false)
		ENTITY.APPLY_FORCE_TO_ENTITY(nuke, 0, dir.x, dir.y, dir.z, 0.0, 0.0, 0.0, 0, true, false, true, false, true)
		ENTITY.SET_ENTITY_HAS_GRAVITY(nuke, true)
		while not ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(nuke) and not ENTITY.IS_ENTITY_IN_WATER(nuke) do
			util.yield(0)
		end
		local nukePos = ENTITY.GET_ENTITY_COORDS(nuke, true)
		entities.delete_by_handle(nuke)
        create_nuke_explosion(nukePos)
	end
end


-----推进载具
function get_entity_player_is_aiming_at(player)
	if not PLAYER.IS_PLAYER_FREE_AIMING(player) then
		return 0
	end
	local entity = false
    local aimed_entity = memory.alloc_int()
	if PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(player, aimed_entity) then
		entity = memory.read_int(aimed_entity)
	end
	if entity ~= false and ENTITY.IS_ENTITY_A_PED(entity) and PED.IS_PED_IN_ANY_VEHICLE(entity, false) then
		entity = PED.GET_VEHICLE_PED_IS_IN(entity, false)
	end
	return entity
end



------前滚翻
function has_anim_dict_loaded(dict)
    while not STREAMING.HAS_ANIM_DICT_LOADED(dict) do
        STREAMING.REQUEST_ANIM_DICT(dict)
        util.yield(0)
    end
end
local i_forward = 360
function forward_roll()
    has_anim_dict_loaded("misschinese2_crystalmaze")
    TASK.TASK_PLAY_ANIM(players.user_ped(), "misschinese2_crystalmaze", "2int_loop_a_taotranslator", 8.0, 8.0, -1, 0, 0.0, 0, 0, 0)
    local cam_rot = CAM.GET_GAMEPLAY_CAM_ROT(0)
    local user_rot = ENTITY.GET_ENTITY_ROTATION(players.user_ped(), 0)
    local fwd_vect = ENTITY.GET_ENTITY_FORWARD_VECTOR(players.user_ped())
    local speed = ENTITY.GET_ENTITY_SPEED(players.user_ped()) * 2.236936
    PED.SET_PED_CAN_RAGDOLL(players.user_ped(), false)
    ENTITY.SET_ENTITY_ROTATION(players.user_ped(), i_forward, user_rot.y, cam_rot.z, 2, true)
    if speed <= 70 then
        ENTITY.APPLY_FORCE_TO_ENTITY(players.user_ped(), 3, fwd_vect.x, fwd_vect.y, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, true, false, false)
    end
    if i_forward <= 0 then i_forward = 360 else i_forward = i_forward - 6 end 
end
function end_forward_roll()
    util.yield(100)
    PED.SET_PED_CAN_RAGDOLL(players.user_ped(), true)
    TASK.STOP_ANIM_TASK(players.user_ped(), "misschinese2_crystalmaze", "2int_loop_a_taotranslator", 1)
end
----街舞
local rotation = 0
local loop_count = 0
local dict, name
function breakdance()
    if loop_count <= 200 then
        dict = "missfbi5ig_20b"
        name = "hands_up_scientist"
    elseif loop_count <= 400 then
        dict = "nm@hands"
        name = "hands_up"
    elseif loop_count <= 600 then
        dict = "missheist_agency2ahands_up"
        name = "handsup_anxious"
    elseif loop_count <= 800 then
        dict = "missheist_agency2ahands_up"
        name = "handsup_loop"
    end
    ENTITY.SET_ENTITY_ROTATION(players.user_ped(), 180, 0, rotation, 1, true)
    has_anim_dict_loaded(dict)
    TASK.TASK_PLAY_ANIM(players.user_ped(), dict, name, 8.0, 0, -1, 0, 0.0, 0, 0, 0)
    rotation = rotation + 5
    if loop_count < 1000 then
        loop_count = loop_count + 1
    else
        loop_count = 0
    end
end
function end_breakdance()
    util.yield(100)
    TASK.STOP_ANIM_TASK(players.user_ped(), dict, name, 1)
end




------传送到最近载具
function get_closest_vehicle(entity)
    local coords = ENTITY.GET_ENTITY_COORDS(entity, true)
    local vehicles = entities.get_all_vehicles_as_handles()
    local closestdist = 1000000
    local closestveh = 0
    for k, veh in pairs(vehicles) do
        if veh ~= PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false) and ENTITY.GET_ENTITY_HEALTH(veh) ~= 0 then
            local vehcoord = ENTITY.GET_ENTITY_COORDS(veh, true)
            local dist = MISC.GET_DISTANCE_BETWEEN_COORDS(coords['x'], coords['y'], coords['z'], vehcoord['x'], vehcoord['y'], vehcoord['z'], true)
            if dist < closestdist then
                closestdist = dist
                closestveh = veh
            end
        end
    end
    return closestveh
end
function tp_closest_vehicle()
    local closestveh = get_closest_vehicle(players.user_ped())
    local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(closestveh, -1)
    if VEHICLE.IS_VEHICLE_SEAT_FREE(closestveh, -1) then
        PED.SET_PED_INTO_VEHICLE(players.user_ped(), closestveh, -1)
    else
        if not PED.IS_PED_A_PLAYER(driver) then
            entities.delete_by_handle(driver)
            PED.SET_PED_INTO_VEHICLE(players.user_ped(), closestveh, -1)
        elseif VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(closestveh) then
            for i=0, 10 do
                if VEHICLE.IS_VEHICLE_SEAT_FREE(closestveh, i) then
                    PED.SET_PED_INTO_VEHICLE(players.user_ped(), closestveh, i)
                end
            end
        else
            util.toast("传送到最近车辆错误")
        end
    end
end



-----金色翅膀
function Golden_wings(on)
    if on then	
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




--火翅膀
local fireWingr = 25
local fireWingg = 0
local fireWingb = 50
local ptfxEgg
function loadModel(hash)
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do util.yield() end
end
function fireWing_v1(toggle)
    if toggle then
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
            fireWings[i].ptfx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY('muz_xs_turret_flamethrower_looping', ptfxEgg, 0, 0, 0.1, fireWings[i].pos[1], 0, fireWings[i].pos[2], 1, false, false, false)
            util.create_tick_handler(function()
                local rot = ENTITY.GET_ENTITY_ROTATION(players.user_ped(), 2)
                ENTITY.ATTACH_ENTITY_TO_ENTITY(ptfxEgg, players.user_ped(), -1, 0, 0, 0, rot.x, rot.y, rot.z, false, false, false, false, 0, false)
                ENTITY.SET_ENTITY_ROTATION(ptfxEgg, rot.x, rot.y, rot.z, 2, true)
                    for i = 1, #fireWings do
                        GRAPHICS.SET_PARTICLE_FX_LOOPED_SCALE(fireWings[i].ptfx, 0.3)
                        GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fireWings[i].ptfx,fireWingr, fireWingg, fireWingb)
                        fireWingr = fireWingr + 0.145
                        if fireWingr > 0.96 then
                            fireWingg = fireWingg + 5
                            fireWingb = fireWingb +6
                            fireWingr = 0.001
                        end
                    end
                ENTITY.SET_ENTITY_VISIBLE(ptfxEgg, false)
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

--------彩色翅膀
function fireWingv2_color(newColour)
    fireWing_v2color = newColour
end
function fireWing_v2(toggle)
    if toggle then
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
            fireWings[i].ptfx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY('muz_xs_turret_flamethrower_looping', ptfxEgg, 0, 0, 0.1, fireWings[i].pos[1], 0, fireWings[i].pos[2], 1, false, false, false)
            util.create_tick_handler(function()
                local rot = ENTITY.GET_ENTITY_ROTATION(players.user_ped(), 2)
                ENTITY.ATTACH_ENTITY_TO_ENTITY(ptfxEgg, players.user_ped(), -1, 0, 0, 0, rot.x, rot.y, rot.z, false, false, false, false, 0, false)
                ENTITY.SET_ENTITY_ROTATION(ptfxEgg, rot.x, rot.y, rot.z, 2, true)
                    for i = 1, #fireWings do
                        GRAPHICS.SET_PARTICLE_FX_LOOPED_SCALE(fireWings[i].ptfx, 0.3)
                        GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fireWings[i].ptfx, fireWing_v2color.r, fireWing_v2color.g, fireWing_v2color.b, fireWing_v2color.a)
                    end
                ENTITY.SET_ENTITY_VISIBLE(ptfxEgg, false)
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



-------任务选项
INT_MIN = -2147483648
INT_MAX = 2147483647
function MP_INDEX()
    return "MP" .. util.get_char_slot() .. "_"
end
function IS_MPPLY(Stat)
    local Stats = {
        "MP_PLAYING_TIME",
    }
    for i = 1, #Stats do
        if Stat == Stats[i] then
            return true
        end
    end
    if string.find(Stat, "MPPLY_") then
        return true
    else
        return false
    end
end
function ADD_MP_INDEX(Stat)
    if not IS_MPPLY(Stat) then
        Stat = MP_INDEX() .. Stat
    end
    return Stat
end
function STAT_SET_INT(Stat, Value)
    STATS.STAT_SET_INT(util.joaat(ADD_MP_INDEX(Stat)), Value, true)
end
function STAT_SET_FLOAT(Stat, Value)
    STATS.STAT_SET_FLOAT(util.joaat(ADD_MP_INDEX(Stat)), Value, true)
end
function STAT_SET_BOOL(Stat, Value)
    STATS.STAT_SET_BOOL(util.joaat(ADD_MP_INDEX(Stat)), Value, true)
end
function STAT_SET_STRING(Stat, Value)
    STATS.STAT_SET_STRING(util.joaat(ADD_MP_INDEX(Stat)), Value, true)
end
function STAT_SET_DATE(Stat, Year, Month, Day, Hour, Min)
    local DatePTR = memory.alloc(7*8) -- Thanks to help memory stuffs, aaronlink127#0127
    memory.write_int(DatePTR, Year)
    memory.write_int(DatePTR+8, Month)
    memory.write_int(DatePTR+16, Day)
    memory.write_int(DatePTR+24, Hour)
    memory.write_int(DatePTR+32, Min)
    memory.write_int(DatePTR+40, 0) -- Second
    memory.write_int(DatePTR+48, 0) -- Millisecond
    STATS.STAT_SET_DATE(util.joaat(ADD_MP_INDEX(Stat)), DatePTR, 7, true)
end
function STAT_SET_PACKED_BOOL(Stat, Value)
    STATS._SET_PACKED_STAT_BOOL(Stat, Value, util.get_char_slot())
end
function STAT_SET_INCREMENT(Stat, Value)
    STATS.STAT_INCREMENT(util.joaat(ADD_MP_INDEX(Stat)), Value, true)
end
function STAT_GET_INT(Stat)
    local IntPTR = memory.alloc_int()
    STATS.STAT_GET_INT(util.joaat(ADD_MP_INDEX(Stat)), IntPTR, -1)
    return memory.read_int(IntPTR)
end
function STAT_GET_FLOAT(Stat)
    local FloatPTR = memory.alloc_int()
    STATS.STAT_GET_FLOAT(util.joaat(ADD_MP_INDEX(Stat)), FloatPTR, -1)
    return tonumber(string.format("%.3f", memory.read_float(FloatPTR)))
end
function STAT_GET_BOOL(Stat)
    if STAT_GET_INT(Stat) == 0 then
        return "false"
    elseif STAT_GET_INT(Stat) == 1 then
        return "true"
    else
        return "STAT_UNKNOWN"
    end 
end
function STAT_GET_STRING(Stat)
    return STATS.STAT_GET_STRING(util.joaat(ADD_MP_INDEX(Stat)), -1)
end
function STAT_GET_DATE(Stat, Sort)
    local DatePTR = memory.alloc(7*8)
    STATS.STAT_GET_DATE(util.joaat(ADD_MP_INDEX(Stat)), DatePTR, 7, true)
    local Add = 0
    if Sort == "Year" then
        Add = 0
    elseif Sort == "Month" then
        Add = 8
    elseif Sort == "Day" then
        Add = 16
    elseif Sort == "Hour" then
        Add = 24
    elseif Sort == "Min" then
        Add = 32
    end
    return memory.read_int(DatePTR+Add)
end
function SET_INT_GLOBAL(Global, Value)
    memory.write_int(memory.script_global(Global), Value)
end
function SET_FLOAT_GLOBAL(Global, Value)
    memory.write_float(memory.script_global(Global), Value)
end
function GET_INT_GLOBAL(Global)
    return memory.read_int(memory.script_global(Global))
end
function SET_PACKED_INT_GLOBAL(StartGlobal, EndGlobal, Value)
    for i = StartGlobal, EndGlobal do
        SET_INT_GLOBAL(262145 + i, Value)
    end
end
function SET_INT_LOCAL(Script, Local, Value)
    if memory.script_local(Script, Local) ~= 0 then
        memory.write_int(memory.script_local(Script, Local), Value)
    end
end
function SET_FLOAT_LOCAL(Script, Local, Value)
    if memory.script_local(Script, Local) ~= 0 then
        memory.write_float(memory.script_local(Script, Local), Value)
    end
end
function GET_INT_LOCAL(Script, Local)
    if memory.script_local(Script, Local) ~= 0 then
        local Value = memory.read_int(memory.script_local(Script, Local))
        if Value ~= nil then
            return Value
        end
    end
end
function TELEPORT(X, Y, Z)
    PED.SET_PED_COORDS_KEEP_VEHICLE(players.user_ped(), X, Y, Z)
end
function SET_HEADING(Heading)
    ENTITY.SET_ENTITY_HEADING(players.user_ped(), Heading)
end
function IsWorking(IsAddNewLine)
    local State = "" -- If global and local variables have been changed due to the GTAO update then 
    if util.is_session_started() then
        if GET_INT_LOCAL("freemode", 3504) ~= util.joaat("lr_prop_carkey_fob") then -- freemode.c, joaat("lr_prop_carkey_fob")
            State = "[NOT WORKING]"
            if IsAddNewLine then
                State = State .. "\n\n"
            end
        end
    end
    return State
end
function RGB(R, G, B, A) -- Credit goes to LanceScript
    local Color = {}
    Color.r = R
    Color.g = G
    Color.b = B
    Color.a = A
    return Color
end
function HelpMsgBeingDisplayed(Label) -- Credit goes to jerry123#4508
    HUD.BEGIN_TEXT_COMMAND_IS_THIS_HELP_MESSAGE_BEING_DISPLAYED(Label) -- Labels List: https://gist.githubusercontent.com/aaronlink127/afc889be7d52146a76bab72ede0512c7/raw
    return HUD.END_TEXT_COMMAND_IS_THIS_HELP_MESSAGE_BEING_DISPLAYED(0)
end
function IS_PED_PLAYER(Ped)
    if PED.GET_PED_TYPE(Ped) >= 4 then
        return false
    else
        return true
    end
end
function FORCE_CLOUD_SAVE()
    STATS.STAT_SAVE(0, 0, 3, 0) -- Same as menu.trigger_commands("forcecloudsave"), Credit goes to https://github.com/jonaaa20/RecoverySuite
    util.yield(1500)
    util.arspinner_enable()
    util.yield(4500)
    util.arspinner_disable()
end
function IA_MENU_OPEN()
    PAD._SET_CONTROL_NORMAL(0, 244, 1)
    util.yield(200)
end
function IA_MENU_UP(Num)
    for i = 1, Num do
        PAD._SET_CONTROL_NORMAL(0, 172, 1)
        util.yield(200)
    end
end
function IA_MENU_DOWN(Num)
    for i = 1, Num do
        PAD._SET_CONTROL_NORMAL(0, 173, 1)
        util.yield(200)
    end
end
function IA_MENU_ENTER(Num)
    for i = 1, Num do
        PAD._SET_CONTROL_NORMAL(0, 176, 1)
        util.yield(200)
    end
end



-----钢铁侠
local startViewMode
local scope_scaleform
local gaveHelmet = false
function Iron_Man()
    local JSkey = require 'lib.daidailib.JSkeyLib'
    local scaleForm = require'lib.daidailib.ScaleformLib'
    local SFasd = scaleForm('instructional_buttons')

    menu.trigger_commands("levitate on")
    if not PED.IS_PED_WEARING_HELMET(players.user_ped()) then
        PED.GIVE_PED_HELMET(players.user_ped(), true, 4096, -1)
        gaveHelmet = true
    end
    local context = CAM1._GET_CAM_ACTIVE_VIEW_MODE_CONTEXT()
    if startViewMode == nil then
        startViewMode = CAM.GET_CAM_VIEW_MODE_FOR_CONTEXT(context)
    end
    if CAM.GET_CAM_VIEW_MODE_FOR_CONTEXT(context) != 4 then
        CAM.SET_CAM_VIEW_MODE_FOR_CONTEXT(context, 4)
    end
    scope_scaleform = GRAPHICS.REQUEST_SCALEFORM_MOVIE('REMOTE_SNIPER_HUD')
    GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scope_scaleform, 'REMOTE_SNIPER_HUD')
    GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(scope_scaleform, 255, 255, 255, 255, 0)
    GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
    local barrageInput = 'INPUT_PICKUP'
    if not PAD.IS_USING_KEYBOARD_AND_MOUSE(0) then
        barrageInput = 'INPUT_COVER'
    end
    memory.write_int(memory.script_global(1649593 + 1163), 1)
    SFasd.CLEAR_ALL()
    SFasd.TOGGLE_MOUSE_BUTTONS(false)
    SFasd.SET_DATA_SLOT(2, JSkey.get_control_instructional_button(0, 'INPUT_ATTACK'), '机炮')
    SFasd.SET_DATA_SLOT(1, JSkey.get_control_instructional_button(0, 'INPUT_AIM'), '原子枪')
    SFasd.SET_DATA_SLOT(0, JSkey.get_control_instructional_button(0, barrageInput), '火箭弹')
    SFasd.DRAW_INSTRUCTIONAL_BUTTONS()
    JSkey.disable_control_action(2, 'INPUT_VEH_MOUSE_CONTROL_OVERRIDE')
    JSkey.disable_control_action(2, 'INPUT_VEH_FLY_MOUSE_CONTROL_OVERRIDE')
    JSkey.disable_control_action(2, 'INPUT_VEH_SUB_MOUSE_CONTROL_OVERRIDE')
    JSkey.disable_control_action(0, 'INPUT_ATTACK')
    JSkey.disable_control_action(0, 'INPUT_AIM')
    if not (JSkey.is_disabled_control_pressed(0, 'INPUT_ATTACK') or JSkey.is_disabled_control_pressed(0, 'INPUT_AIM') or JSkey.is_disabled_control_pressed(0, barrageInput)) then return end
    local a = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    local b = getOffsetFromCam(80)
    local hash
    if JSkey.is_disabled_control_pressed(0, 'INPUT_ATTACK') then
        hash = util.joaat('VEHICLE_WEAPON_PLAYER_LAZER')
        if not WEAPON.HAS_WEAPON_ASSET_LOADED(hash) then
            WEAPON.REQUEST_WEAPON_ASSET(hash, 31, 26)
            while not WEAPON.HAS_WEAPON_ASSET_LOADED(hash) do
                util.yield()
            end
        end
    elseif JSkey.is_disabled_control_pressed(0, 'INPUT_AIM') then
        hash = util.joaat('WEAPON_RAYPISTOL')
        if not WEAPON.HAS_PED_GOT_WEAPON(players.user_ped(), hash, false) then
            WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), hash, 9999, false, false)
        end
    else
        hash = util.joaat('WEAPON_RPG')
        if not WEAPON.HAS_PED_GOT_WEAPON(players.user_ped(), hash, false) then
            WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), hash, 9999, false, false)
        end
        a.x += math.random(0, 100) / 100
        a.y += math.random(0, 100) / 100
        a.z += math.random(0, 100) / 100
    end
    WEAPON.SET_CURRENT_PED_WEAPON(players.user_ped(), util.joaat('WEAPON_UNARMED'), true)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(
        a.x, a.y, a.z,
        b.x, b.y, b.z,
        200,
        true,
        hash,
        PLAYER.PLAYER_PED_ID(),
        true, true, -1.0
    )
end
function Iron_Man_stop()
    if gaveHelmet then
        PED.REMOVE_PED_HELMET(players.user_ped(), true)
        gaveHelmet = false
    end
    HUD1._HUD_WEAPON_WHEEL_IGNORE_CONTROL_INPUT(false)
    local pScaleform = memory.alloc_int()
    memory.write_int(pScaleform, scope_scaleform)
    GRAPHICS.SET_SCALEFORM_MOVIE_AS_NO_LONGER_NEEDED(pScaleform)
    menu.trigger_commands("levitate off")
    util.yield()
    CAM.SET_CAM_VIEW_MODE_FOR_CONTEXT(CAM1._GET_CAM_ACTIVE_VIEW_MODE_CONTEXT(), startViewMode)
    startViewMode = nil
end







-------聊天翻译
colorselec = 1
allchatlabel = util.get_label_text("MP_CHAT_ALL")
teamchatlabel = util.get_label_text("MP_CHAT_TEAM")     
Languages = {
    { Name = "简体中文", Key = "zh-CN" },
    { Name = "繁体中文", Key = "zh-TW" },
    { Name = "英语", Key = "en" },
}
LangKeys = {}
LangName = {}
LangIndexes = {}
LangLookupByName = {}
LangLookupByKey = {}
PlayerSpooflist = {}
PlayerSpoof = {}
    for i=1,#Languages do
        Language = Languages[i]
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
function decode(text)
    return string.gsub(text, "%+", "")
end
function translate_toggle(on)
    traduct = on	
end
local Tradloca = 1
function translate_pos(s)
    Tradloca = s
end
local traductself = true
function translate_myself(on)
    traductself = on	
end
function translate_cc(on)
    traductsamelang = on	
end
local targetlang = "zh-CN"
function translate_target(s)
    targetlang = LangLookupByName[LangKeys[s]]
end
local botsend = false
chat.on_message(function(packet_sender, message_sender, text, team_chat)
    sfchat = require("lib.daidailib.ScaleformLib")("multiplayer_chat")
    sfchat:draw_fullscreen()
    if not botsend then
        if not traductself and (packet_sender == players.user()) then
        else
            if traduct then
                async_http.init("translate.googleapis.com", "/translate_a/single?client=gtx&sl=auto&tl="..targetlang.."&dt=t&q="..encode(text), function(Sucess)
                    if Sucess ~= "" then
                        translation, original, sourceLang = Sucess:match("^%[%[%[\"(.-)\",\"(.-)\",.-,.-,.-]],.-,\"(.-)\"")
                        if not traductsamelang and (sourceLang == targetlang) then
                        else
                            local sender = players.get_name(packet_sender)
                            translationtext = decode(translation)
                            colorfinal = colorselec

                            if (Tradloca == 1) then
                                botsend = true
                                chat.send_message(sender.." : "..decode(translation), true, false, true)
                                sfchat.ADD_MESSAGE(sender, translationtext, teamchatlabel, false, colorfinal)
                            end 
                            if (Tradloca == 2) then
                                botsend = true
                                chat.send_message(sender.." : "..decode(translation), false, false, true)
                                sfchat.ADD_MESSAGE(sender, translationtext, allchatlabel, false, colorfinal)
                            end 
                            if (Tradloca == 3) then
                                util.toast(players.get_name(packet_sender).." : "..decode(translation))
                            end
                        end
                    end
                end)
                async_http.dispatch()
            end
        end
    end
    botsend = false
end)





-----绘制控制台
local log_dir = filesystem.stand_dir() .. '\\Log.txt'
local full_stdout = ""
local disp_stdout = ""
local max_chars = 200
local max_lines = 25
local font_size = 0.45
function console_max_chars(s)
    max_chars = s
end
function console_max_lines(s)
    max_lines = s
end
function console_font_size(s)
    font_size = s*0.01
end
function get_stand_stdout(tbl, n)
    local all_lines = {}
    local disp_lines = {}
    local size = #tbl
    local index = 1
    if size >= n then 
        index = #tbl - n
    end
    for i=index, size do 
        local line = tbl[i]
        local line_copy = line
        if line ~= "" and line ~= '\n' then
            all_lines[#all_lines + 1] = line
            if string.len(line) > max_chars then
                disp_lines[#disp_lines + 1] = line:sub(1, max_chars) .. ' ...'
            else
                disp_lines[#disp_lines + 1] = line
            end
        end
    end
    full_stdout = table.concat(all_lines, '\n')
    disp_stdout = table.concat(disp_lines, '\n')
end
function get_last_lines(file)
    local f = io.open(file, "r")
    local len = f:seek("end")
    f:seek("set", len - max_lines*1000)
    local text = f:read("*a")
    lines = string.split(text, '\n')
    f:close()
    get_stand_stdout(lines, max_lines)
end
console_bg_color = {r = 0, g = 0, b = 0, a = 0.5}
console_text_color = {r = 0.28, g = 1, b = 1, a = 1}
function Draw_console()
    local text = get_last_lines(log_dir)
    local size_x, size_y = directx.get_text_size(disp_stdout, font_size)
    size_x += 0.01
    size_y += 0.01
    directx.draw_rect(0.0, 0.05, size_x, size_y, console_bg_color)
    directx.draw_text(0.0, 0.05, disp_stdout, 0, font_size, console_text_color, true)
end




--------添加水印
local icon = directx.create_texture(filesystem.resources_dir() .. 'daidai-img\\watermark\\icon.jpg')
function watermark_x(x_)
    watermark_pos.x = x_ / 10000
end
function watermark_y(y_)
    watermark_pos.y = y_ / 10000
end
function watermark_bgx(x_)
    watermark_settings.add_x = x_ / 10000
end
function watermark_bgy(y_)
    watermark_settings.add_y = y_ / 10000
end
function watermark_bgc(col)
    watermark_settings.bg_color = col
end
function watermark_txtc(col)
    watermark_settings.tx_color = col
end
function watermark_lable(val)
    watermark_settings.show_firstl = val
end
function watermark_name(val)
    watermark_settings.show_name = val
end
function watermark_players(val)
    watermark_settings.show_players = val
end
function watermark_time(val)
    watermark_settings.show_date = val
end
function watermark_toggle()
    local wm_text = (
        watermark_settings.show_firstl == 2 and '呆呆' 
        or watermark_settings.show_firstl == 5 and '^_-' 
        or watermark_settings.show_firstl == 6 and 'OwO' 
        or watermark_settings.show_firstl == 4 and 'Stand' 
        or watermark_settings.show_firstl == 3 and stand_version.editions[stand_version.edition+1] 
        or '') .. (watermark_settings.show_name and ' | '.. players.get_name(players.user()) 
        or '') .. (watermark_settings.show_players and NETWORK.NETWORK_IS_SESSION_STARTED() and ' | Players: '..#players.list(true, true, true) 
        or '') .. (watermark_settings.show_date and os.date(' | %H:%M:%S ') 
        or '')

    local tx_size = directx.get_text_size(wm_text, 0.5)

    directx.draw_rect(
        watermark_pos.x + watermark_settings.add_x * 0.5, 
        watermark_pos.y, 
        -(tx_size + 0.0105 + watermark_settings.add_x),  -- add watermark size
        0.025 + watermark_settings.add_y, 
        watermark_settings.bg_color
    )
    directx.draw_texture(icon, 
        0.0055, 
        0.0055, 
        0.5, 
        0.5, 
        watermark_pos.x - tx_size - 0.0055, 
        watermark_pos.y + 0.013, 
        0, 
        {["r"] = 1.0,["g"] = 1.0,["b"] = 1.0,["a"] = 1.0}
    )
    directx.draw_text(
        watermark_pos.x, 
        watermark_pos.y + 0.004, 
        wm_text, 
        ALIGN_TOP_RIGHT, 
        0.5, 
        watermark_settings.tx_color, 
        false
    )
end





------胡桃
function SET_OUTFIT_VALUE(ValueName, Value, variation)
    local commandName = ValueName
    if variation == true then
        commandName = commandName.."var"
    end
    menu.trigger_commands(commandName.." "..Value)
end
function become_walnuts()
    menu.trigger_commands("mpmale")
    SET_OUTFIT_VALUE("head", 32)
    SET_OUTFIT_VALUE("head", 0, true)
    SET_OUTFIT_VALUE("mask", 215)
    SET_OUTFIT_VALUE("mask", 0, true)
    SET_OUTFIT_VALUE("hair", 0)
    SET_OUTFIT_VALUE("hair", 58, true)
    SET_OUTFIT_VALUE("top", 446)
    SET_OUTFIT_VALUE("top", 0, true)
    SET_OUTFIT_VALUE("gloves", 0)
    SET_OUTFIT_VALUE("gloves", 0, true)
    SET_OUTFIT_VALUE("top2", -1)
    SET_OUTFIT_VALUE("top2", 0, true)
    SET_OUTFIT_VALUE("top3", -1)
    SET_OUTFIT_VALUE("top3", 0, true)
    SET_OUTFIT_VALUE("parachute", 0)
    SET_OUTFIT_VALUE("parachute", 0, true)
    SET_OUTFIT_VALUE("pants", 160)
    SET_OUTFIT_VALUE("pants", 0, true)
    SET_OUTFIT_VALUE("shoes", 119)
    menu.trigger_commands("feetvar 0")
    SET_OUTFIT_VALUE("accessories", -1)
    SET_OUTFIT_VALUE("accessories", 0, true)
    SET_OUTFIT_VALUE("decals", -1)
    SET_OUTFIT_VALUE("decals", 0, true)
    SET_OUTFIT_VALUE("hat", 193)
    SET_OUTFIT_VALUE("hat", 0, true)
    SET_OUTFIT_VALUE("glasses", -1)
    SET_OUTFIT_VALUE("glasses", -1, true)
    SET_OUTFIT_VALUE("ears", -1)
    SET_OUTFIT_VALUE("ears", -1, true)
    SET_OUTFIT_VALUE("watch", -1)
    SET_OUTFIT_VALUE("watch", -1, true)
    SET_OUTFIT_VALUE("bracelet", -1)
    SET_OUTFIT_VALUE("bracelet", -1, true)
end


-------核弹枪
function toDirection(rotation) 
	local adjusted_rotation = { 
		x = (math.pi / 180) * rotation.x, 
		y = (math.pi / 180) * rotation.y, 
		z = (math.pi / 180) * rotation.z 
	}
	local direction = {
		x = - math.sin(adjusted_rotation.z) * math.abs(math.cos(adjusted_rotation.x)), 
		y =   math.cos(adjusted_rotation.z) * math.abs(math.cos(adjusted_rotation.x)), 
		z =   math.sin(adjusted_rotation.x)
	}
	return direction
end
function raycast_gameplay_cam(flag, distance)
    local ptr1, ptr2, ptr3, ptr4 = memory.alloc(), memory.alloc(), memory.alloc(), memory.alloc()
    local cam_rot = CAM.GET_GAMEPLAY_CAM_ROT(2)
    local cam_pos = CAM.GET_GAMEPLAY_CAM_COORD()
    local direction = toDirection(CAM.GET_GAMEPLAY_CAM_ROT(0))
    local destination =
    {
        x = cam_pos.x + direction.x * distance,
        y = cam_pos.y + direction.y * distance,
        z = cam_pos.z + direction.z * distance
    }
    SHAPETEST.GET_SHAPE_TEST_RESULT(
        SHAPETEST.START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE(
            cam_pos.x,
            cam_pos.y,
            cam_pos.z,
            destination.x,
            destination.y,
            destination.z,
            flag,
            -1,
            1
        ), ptr1, ptr2, ptr3, ptr4)
    local p1 = memory.read_int(ptr1)
    local p2 = memory.read_vector3(ptr2)
    local p3 = memory.read_vector3(ptr3)
    local p4 = memory.read_int(ptr4)
    return {p1, p2, p3, p4}
end
function direction()
    local c1 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0, 5, 0)
    local res = raycast_gameplay_cam(-1, 1000)
    local c2
    if res[1] != 0 then
        c2 = res[2]
    else
        c2 = get_offset_from_gameplay_camera(1000)
    end
    c2.x = (c2.x - c1.x) * 1000
    c2.y = (c2.y - c1.y) * 1000
    c2.z = (c2.z - c1.z) * 1000
    return c2, c1
end
function disableProjectileLoop(projectile)
    WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(projectile, false)
end
mutually_exclusive_weapons  = {}
function nukegunmode()
        if WEAPON.GET_SELECTED_PED_WEAPON(players.user_ped()) == -1312131151 then --if holding homing launcher
            if PED.IS_PED_SHOOTING(players.user_ped()) then
                disableProjectileLoop(-1312131151)
                
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
            end
        end
end





-------水上空中驾驶
function on_user_change_vehicle(vehicle)
    if vehicle ~= 0 then
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
local last_car = 0
function all_drive_style()
    player_cur_car = entities.get_user_vehicle_as_handle()
    if last_car ~= player_cur_car and player_cur_car ~= 0 then 
        on_user_change_vehicle(player_cur_car)
        last_car = player_cur_car
    end
    if renderscorched then
        if player_cur_car ~= 0 then
            ENTITY.SET_ENTITY_RENDER_SCORCHED(player_cur_car, true)
        end
    end

    if walkonwater or driveonwater or driveonair then
        if dow_block == 0 or not ENTITY.DOES_ENTITY_EXIST(dow_block) then
            local hash = util.joaat("stt_prop_stunt_bblock_mdm3")
            request_model_load(hash)
            local c = {}
            c.x = 0.0
            c.y = 0.0
            c.z = 0.0
            dow_block = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, c['x'], c['y'], c['z'], true, false, false)
            ENTITY.SET_ENTITY_ALPHA(dow_block, 0)
            ENTITY.SET_ENTITY_VISIBLE(dow_block, false, 0)
        end
    end
    if dow_block ~= 0 and not walkonwater and not driveonwater and not driveonair then
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, 0, 0, 0, false, false, false)
    end
    if walkonwater then
        vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)
        local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0.0, 2.0, 0.0)
        -- we need to offset this because otherwise the player keeps diving off the thing, like a fucking dumbass
        -- ht isnt actually used here, but im allocating some memory anyways to prevent a possible crash, probably. idk im no computer engineer
        local ht = memory.alloc(4)
        -- this is better than ENTITY.IS_ENTITY_IN_WATER because it can detect if a player is actually above water without them even being "in" it
        if WATER.GET_WATER_HEIGHT(pos['x'], pos['y'], pos['z'], ht) then
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, pos['x'], pos['y'], memory.read_float(ht), false, false, false)
            ENTITY.SET_ENTITY_HEADING(dow_block, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
        end
    end
    if driveonwater then
        if player_cur_car ~= 0 then
            local pos = ENTITY.GET_ENTITY_COORDS(player_cur_car, true)
            -- ht isnt actually used here, but im allocating some memory anyways to prevent a possible crash, probably. idk im no computer engineer
            local ht = memory.alloc(4)
            -- this is better than ENTITY.IS_ENTITY_IN_WATER because it can detect if a player is actually above water without them even being "in" it
            if WATER.GET_WATER_HEIGHT(pos['x'], pos['y'], pos['z'], ht) then
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, pos['x'], pos['y'], memory.read_float(ht), false, false, false)
                ENTITY.SET_ENTITY_HEADING(dow_block, ENTITY.GET_ENTITY_HEADING(player_cur_car))
            end
        else
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, 0, 0, 0, false, false, false)
        end
    end
    if driveonair then
        if player_cur_car ~= 0 then
            local pos = ENTITY.GET_ENTITY_COORDS(player_cur_car, true)
            local boxpos = ENTITY.GET_ENTITY_COORDS(dow_block, true)
            if MISC.GET_DISTANCE_BETWEEN_COORDS(pos['x'], pos['y'], pos['z'], boxpos['x'], boxpos['y'], boxpos['z'], true) >= 5 then
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, pos['x'], pos['y'], doa_ht, false, false, false)
                ENTITY.SET_ENTITY_HEADING(dow_block, ENTITY.GET_ENTITY_HEADING(player_cur_car))
            end
            if PAD.IS_CONTROL_PRESSED(22, 22) then
                doa_ht = doa_ht + 0.1
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, pos['x'], pos['y'], doa_ht, false, false, false)
            end
            if PAD.IS_CONTROL_PRESSED(36, 36) then
                doa_ht = doa_ht - 0.1
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(dow_block, pos['x'], pos['y'], doa_ht, false, false, false)
            end
        end
    end  
end





-------先进追踪导弹
function memoryScan(name, pattern, callback)
	local address = memory.scan(pattern)
	assert(address ~= NULL, "内存扫描失败： " .. name)
	callback(address)
end
memoryScan("GetNetGamePlayer", "48 83 EC ? 33 C0 38 05 ? ? ? ? 74 ? 83 F9", function (address)
	GetNetGamePlayer_addr = address
end)
function GetNetGamePlayer(player)
	return util.call_foreign_function(GetNetGamePlayer_addr, player)
end


--------载具武器
local get_vehicle_cam_relative_heading = function(vehicle)
	local camDir = CAM.GET_GAMEPLAY_CAM_ROT(0):toDir()
	local fwdVector = ENTITY.GET_ENTITY_FORWARD_VECTOR(vehicle)
	camDir.z, fwdVector.z = 0.0, 0.0
	local angle = math.acos(fwdVector:dot(camDir) / (#camDir * #fwdVector))
	return math.deg(angle)
end

local shoot_from_vehicle = function (vehicle, damage, weaponHash, ownerPed, isAudible, isVisible, speed, target, position)
	local min, max = v3.new(), v3.new()
	local offset
	MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(vehicle), min, max)
	if position == 0 then
		offset = v3.new(min.x, max.y + 0.25, 0.3)
	elseif position == 1 then
		offset = v3.new(min.x, min.y, 0.3)
	elseif position == 2 then
		offset = v3.new(max.x, max.y + 0.25, 0.3)
	elseif position == 3 then
		offset = v3.new(max.x, min.y, 0.3)
	else
		error("得到了意想不到的位置")
	end
	local a = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, offset.x, offset.y, offset.z)
	local direction = ENTITY.GET_ENTITY_ROTATION(vehicle, 2):toDir()
	if get_vehicle_cam_relative_heading(vehicle) > 95.0 then
		direction:mul(-1)
	end
	local b = v3.new(direction)
	b:mul(300.0); b:add(a)

	MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY_NEW(
		a.x, a.y, a.z,
		b.x, b.y, b.z,
		damage,
		true,
		weaponHash,
		ownerPed,
		isAudible,
		not isVisible,
		speed,
		vehicle,
		false, false, target, false, 0, 0, 0
	)
end
function vehlaser()
    if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
		local vehicle = get_vehicle_player_is_in(players.user())
		local min, max = v3.new(), v3.new()
		MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(vehicle), min, max)
		local startLeft = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle,  min.x, max.y, 0.0)
		local endLeft = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, min.x, max.y + 25.0, 0.0)
		GRAPHICS.DRAW_LINE(startLeft.x, startLeft.y, startLeft.z, endLeft.x, endLeft.y, endLeft.z, 255, 0, 0, 150)

		local startRight = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, max.x, max.y, 0.0)
		local endRight = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, max.x, max.y + 25.0, 0)
		GRAPHICS.DRAW_LINE(startRight.x, startRight.y, startRight.z, endRight.x, endRight.y, endRight.z, 255, 0, 0, 150)
	end
end
VehicleWeapon = {modelName = "", timeBetweenShots = 0}
VehicleWeapon.__index = VehicleWeapon
function VehicleWeapon.new(modelName, timeBetweenShots)
	local instance = setmetatable({}, VehicleWeapon)
	instance.modelName = modelName
	instance.timeBetweenShots = timeBetweenShots
	return instance
end
vehicleWeaponList = {
	VehicleWeapon.new("weapon_vehicle_rocket", 220),
	VehicleWeapon.new("weapon_raypistol", 50),
	VehicleWeapon.new("weapon_firework", 220),
	VehicleWeapon.new("vehicle_weapon_tank", 220),
	VehicleWeapon.new("vehicle_weapon_player_lazer", 30)
}
Imputs_vehweapon = {
	INPUT_JUMP = {"Spacebar; X", 22},
	INPUT_VEH_ATTACK = {"Mouse L; RB", 69},
	INPUT_VEH_AIM = {"Mouse R; LB", 68},
	INPUT_VEH_DUCK = {"X; A", 73},
	INPUT_VEH_HORN = {"E; L3", 86},
	INPUT_VEH_CINEMATIC_UP_ONLY = {"Numpad +; none", 96},
	INPUT_VEH_CINEMATIC_DOWN_ONLY = {"Numpad -; none", 97}
}
trans_plane = {
	AirstrikeAircraft = "按 ~%s~ 以使用空袭飞机",
	Keyboard = "键盘",
	Controller = "手柄",
	VehicleWeapons = "按 ~%s~ 使用载具武器"
}

Vw_state = 0
local timer = newTimer()
local msg = "按 ~%s~ 使用载具武器"
function vehweapon_veh()
    local control = Config.controls.vehicleweapons
	if Vw_state == 0 or timer.elapsed() > 120000 then
		local controlName = table.find_if(Imputs_vehweapon, function(k, tbl)
			return tbl[2] == control
		end)
		assert(controlName, "未找到控件名称")
		util.show_corner_help(msg:format(controlName))
		Vw_state = 1
		timer.reset()
	end
	local selectedWeapon = vehicleWeaponList[selectedOpt]
	local vehicle = get_vehicle_player_is_in(players.user())
	local weaponHash = util.joaat(selectedWeapon.modelName)
	request_weapon_asset(weaponHash)
	if not ENTITY.DOES_ENTITY_EXIST(vehicle) or not PAD.IS_CONTROL_PRESSED(0, control) or
	timer.elapsed() < selectedWeapon.timeBetweenShots then
		return
	elseif get_vehicle_cam_relative_heading(vehicle) < 95.0 then
		shoot_from_vehicle(vehicle, 200, weaponHash, players.user_ped(), true, true, 2000.0, 0, 0)
		shoot_from_vehicle(vehicle, 200, weaponHash, players.user_ped(), true, true, 2000.0, 0, 2)
		timer.reset()
	else
		shoot_from_vehicle(vehicle, 200, weaponHash, players.user_ped(), true, true, 2000.0, 0, 1)
		shoot_from_vehicle(vehicle, 200, weaponHash, players.user_ped(), true, true, 2000.0, 0, 3)
		timer.reset()
	end
end
function setvehweapon(index)
    selectedOpt = index 
end





------------可视化速度表
--默认车速表 POS
local sp_posX = 0.865
local sp_posY = 0.86
local sp_bg_tex = directx.create_texture(filesystem.resources_dir().."\\daidai-img\\carspeed\\nfs_spc.png") 
local sp_pin_tex = directx.create_texture(filesystem.resources_dir().."\\daidai-img\\carspeed\\nfs_pin_spc.png")
function spp_colour(colour)
    sp_colour = colour
end
function txtt_colour(colour)
    cartxt_colour = colour
end
function spp_posX(x)
    sp_posX = x/1000
end
function spp_posY(y)
    sp_posY = y/1000
end 
function Visual_speedometer()
    local veh = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
    if veh > 0 then
        local speed = ENTITY.GET_ENTITY_SPEED(veh);
        local kmh = math.floor((speed * 3.6));
        local rotation = 0.0
    
        if kmh <= 240 and rotation <= 0.75 then
            rotation = kmh/320
        end
    
        directx.draw_texture(		---------------------------- speedometer bg texture
        sp_bg_tex,				-- id
        0.066,				-- sizeX
        0.066,				-- sizeY
        0.5,				-- centerX
        0.5,				-- centerY
        sp_posX,				-- posX 
        sp_posY,		 		-- posY 
        0.0,				-- rotation
        sp_colour			--colour
    )
        directx.draw_texture(		---------------------------- speedometer pin texture
        sp_pin_tex,				-- id
        0.066,				-- sizeX
        0.066,				-- sizeY
        0.5,				-- centerX
        0.5,				-- centerY
        sp_posX,				-- posX  
        sp_posY,		 		-- posY 
        rotation,			-- rotation
        sp_colour 			--colour
    )
        directx.draw_text(	-------------------  small text top
        sp_posX-0.022,				-- x 
        sp_posY+0.068,				-- y 
        kmh .." KMPH",		-- text
        ALIGN_TOP_LEFT,		-- alignment
        0.6,				-- scale
        cartxt_colour,		-- colour
        false				
    )	
    end
end




---------魔幻激光战马
lsdweap = {'邪恶冥王','原子能枪',}
lsdh = {'weapon_raycarbine','weapon_raypistol',}
lsd = {weap = 'WEAPON_RAYCARBINE', hash = util.joaat('dune2')}
function get_vehicle_cam_relative_heading(vehicle)
	local camDir = CAM.GET_GAMEPLAY_CAM_ROT(0):toDir()
	local fwdVector = ENTITY.GET_ENTITY_FORWARD_VECTOR(vehicle)
	camDir.z, fwdVector.z = 0.0, 0.0
	local angle = math.acos(fwdVector:dot(camDir) / (#camDir * #fwdVector))
	return math.deg(angle)
end
function SFlsd()
    local scaleform = require('daidailib.ScaleformLib')
    local sf = scaleform('instructional_buttons')
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(6)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(7)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(8)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(9)
    memory.write_int(memory.script_global(1645739+1121), 1)
    sf.CLEAR_ALL()
    sf.TOGGLE_MOUSE_BUTTONS(false)
    sf.SET_DATA_SLOT(0,PAD.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING(0, 86, true), '镭射')
    sf.DRAW_INSTRUCTIONAL_BUTTONS()
    sf:draw_fullscreen()
end
function Vmod(vmod, plate)
    VEHICLE.SET_VEHICLE_FIXED(vmod)
    for M=0, 49 do
        local modn =  VEHICLE.GET_NUM_VEHICLE_MODS(vmod, M)
        VEHICLE.SET_VEHICLE_MOD(vmod, M, modn -1, false)
        VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vmod, plate)
        VEHICLE.GET_VEHICLE_MOD_KIT(vmod, 0)
        VEHICLE.SET_VEHICLE_MOD_KIT(vmod, 0)
        VEHICLE.SET_VEHICLE_MOD(vmod, 14, 0)
        VEHICLE.TOGGLE_VEHICLE_MOD(vmod, 22, true)
        VEHICLE.TOGGLE_VEHICLE_MOD(vmod, 18, true)
        VEHICLE.TOGGLE_VEHICLE_MOD(vmod, 20, true)
        VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vmod, 0, 0, 0)
        VEHICLE.SET_VEHICLE_MAX_SPEED(vmod, 100)
        VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vmod, 40)
        VEHICLE.SET_VEHICLE_BURNOUT(vmod, false)
    end
end

function Magic_Warhorse_W(vweap)
    lsd.weap = lsdh[vweap]
end
function SDcreate(pCoor, pedSi)
    Lsdcar = VEHICLE.CREATE_VEHICLE(lsd.hash, pCoor.x, pCoor.y, pCoor.z, 0, true, true, false)
    PED.SET_PED_INTO_VEHICLE(pedSi, Lsdcar, -1)
    Vmod(Lsdcar, '镭射')
    local CV = CAM.GET_GAMEPLAY_CAM_RELATIVE_HEADING()
    ENTITY.SET_ENTITY_HEADING(Lsdcar, CV)

    util.create_tick_handler(function ()
        if PED.IS_PED_IN_VEHICLE(players.user_ped(), Lsdcar, false) ==true then
        VEHICLE.SET_VEHICLE_DIRT_LEVEL(Lsdcar, 0)
        ENTITY.SET_ENTITY_INVINCIBLE(Lsdcar, true)
        VEHICLE.SET_VEHICLE_CAN_BE_VISIBLY_DAMAGED(Lsdcar, false)
        SFlsd()
        end
    end)
end

local shoot_from_vehicle_Lazer_Space_Car = function (vehicle, damage, weaponHash, ownerPed, isAudible, isVisible, speed, target, position)
    local min, max = v3.new(), v3.new()
    local offset
    MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(vehicle), min, max)
    if position == 0 then
        offset = v3.new(min.x + 0.3, max.y + 0.25, 0.5)
    elseif position == 1 then
        offset = v3.new(min.x + 0.3, min.y + 4, 0.5)
    elseif position == 2 then
        offset = v3.new(max.x - 0.3, max.y + 0.25, 0.5)
    elseif position == 3 then
        offset = v3.new(max.x - 0.3, min.y + 4, 0.5)
    else
        error("got unexpected position")offset = v3.new(min.x + 0.25, max.y, 0.5)
    end
    local a = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, offset.x, offset.y - 3.15, offset.z + 1.05)
    local direction = ENTITY.GET_ENTITY_ROTATION(vehicle, 2):toDir()
    if get_vehicle_cam_relative_heading(vehicle) > 95.0 then
        direction:mul(-1)
    end
    local b = v3.new(direction)
    b:mul(300.0); b:add(a)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY_NEW(
        a.x, a.y, a.z,
        b.x, b.y, b.z - 15,
        damage,
        true,
        weaponHash,
        ownerPed,
        isAudible,
        not isVisible,
        speed,
        vehicle,
        false, false, target, false, 0, 0, 0
    )
end
function Lazer_Space_Car()
    Streament(lsd.hash)
    local pedSi = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
    local pCoor = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    local pH = ENTITY.GET_ENTITY_HEADING(pCoor)

    if players.is_in_interior(players.user()) == true then
        util.toast('无法在室内生成战马')
        menu.set_value(SDspawn, false)
        return
    end
    if PED.IS_PED_IN_VEHICLE(players.user_ped(), Lsdcar, true) == false and PED.IS_PED_IN_ANY_VEHICLE(players.user_ped()) == true then
        local curcar = entities.get_user_vehicle_as_handle()
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(curcar)
        entities.delete_by_handle(curcar)
        util.toast('已为您更换新的战马')
            for i = 1, 1 do
                SDcreate(pCoor, pedSi)
            end
    elseif PED.IS_PED_IN_VEHICLE(players.user_ped(), Lsdcar, true) == true then
        local weap = util.joaat(lsd.weap)
        WEAPON.REQUEST_WEAPON_ASSET(weap)
            if not ENTITY.DOES_ENTITY_EXIST(Lsdcar) or not PAD.IS_CONTROL_PRESSED(0, 86) then
                return
            elseif get_vehicle_cam_relative_heading(Lsdcar) < 95.0 then
                shoot_from_vehicle_Lazer_Space_Car(Lsdcar, 200, weap, players.user_ped(), true, true, 2000.0, 0, 0)
                shoot_from_vehicle_Lazer_Space_Car(Lsdcar, 200, weap, players.user_ped(), true, true, 2000.0, 0, 2)
            else
                shoot_from_vehicle_Lazer_Space_Car(Lsdcar, 200, weap, players.user_ped(), true, true, 2000.0, 0, 1)
                shoot_from_vehicle_Lazer_Space_Car(Lsdcar, 200, weap, players.user_ped(), true, true, 2000.0, 0, 3)
            end
    elseif PED.IS_PED_IN_ANY_VEHICLE(players.user_ped()) == false and not ENTITY.DOES_ENTITY_EXIST(Lsdcar) then
        SDcreate(pCoor, pedSi)
    end
    if PED.IS_PED_GETTING_INTO_A_VEHICLE(players.user_ped()) == false and PED.IS_PED_IN_VEHICLE(players.user_ped(), Lsdcar , false) == false then
        util.toast('已离开战马，战马已被删除')
        menu.set_value(SDspawn, false)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(lsd.hash)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Lsdcar)
        entities.delete_by_handle(Lsdcar)
        util.stop_thread()
    end
end
function stop_Magic_w_w()
    entities.delete_by_handle(Lsdcar)
end




----道奇战马
function Streament(hash)
    STREAMING.REQUEST_MODEL(hash)
    while STREAMING.HAS_MODEL_LOADED(hash) ==false do
    util.yield()
    end
end
function SF_ff9()
    local scaleform = require('lib.daidailib.ScaleformLib')
    local sf = scaleform('instructional_buttons')
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(6)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(7)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(8)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(9)
    memory.write_int(memory.script_global(1645739+1121), 1)
    sf.CLEAR_ALL()
    sf.TOGGLE_MOUSE_BUTTONS(false)
    sf.SET_DATA_SLOT(0,PAD2.GET_CONTROL_INSTRUCTIONAL_BUTTON(0, 86, true), '爆炸 或 推开按')
    sf.DRAW_INSTRUCTIONAL_BUTTONS()
    sf:draw_fullscreen()
end

magtf = {true, false}
maglist = {'推开', '爆炸'}
magval_style = true
function daoqizhanma_style(magint)
    magval_style = magtf[magint]
end
charger = {charg = util.joaat('dukes2'),emp = util.joaat('hei_prop_heist_emp')}
function Ccreate(pCoor, pedSi)
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
            VEHICLE.SET_VEHICLE_MAX_SPEED(FFchar, 100)
            VEHICLE.MODIFY_VEHICLE_TOP_SPEED(FFchar, 40)
            VEHICLE.SET_VEHICLE_BURNOUT(FFchar, false)
        end
        util.yield(150)
    local ccoor = ENTITY.GET_ENTITY_COORDS(FFchar)
        Empa = OBJECT.CREATE_OBJECT(charger.emp, ccoor.x, ccoor.y -1, ccoor.z -1, true, true, true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(Empa, FFchar, 0, 0.0, -2.0, 0.5, 0.0, 0.0, 0.0, false, true, false, false, 0, true)
        local CV = CAM.GET_GAMEPLAY_CAM_RELATIVE_HEADING()
        ENTITY.SET_ENTITY_HEADING(FFchar, CV)
        util.yield()
    function Magout()
        if  PAD.IS_CONTROL_PRESSED(0, 86) then
            local car = ENTITY.GET_ENTITY_COORDS(players.user_ped())
            FIRE.ADD_EXPLOSION(car.x, car.y, car.z, 81, 5000.0, false, true, 0.0, magval_style)
        end
        util.yield()
    end
        util.create_tick_handler(function ()
            if PED.IS_PED_IN_VEHICLE(players.user_ped(), FFchar, false) ==true then
                VEHICLE.SET_VEHICLE_DIRT_LEVEL(FFchar, 0)
                ENTITY.SET_ENTITY_INVINCIBLE(FFchar, true)
                VEHICLE.SET_VEHICLE_CAN_BE_VISIBLY_DAMAGED(FFchar, false)
                SF_ff9()
            end
        end)
end
function daoqizhanma()
    Streament(charger.charg)
    Streament(charger.emp)
    local pedSi = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
    local pCoor = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    local pH = ENTITY.GET_ENTITY_HEADING(pCoor)

    if players.is_in_interior(players.user()) ==true then
        util.toast('无法在室内生成道奇战马')
        menu.set_value(Spawn, false)
        return
    end
    if PED.IS_PED_IN_VEHICLE(players.user_ped(), FFchar, true) ==false and PED.IS_PED_IN_ANY_VEHICLE(players.user_ped()) ==true then
        local curcar = entities.get_user_vehicle_as_handle()
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(curcar)
        entities.delete_by_handle(curcar)
        util.toast('已为您更换新的')
        Ccreate(pCoor, pedSi)
    elseif PED.IS_PED_IN_VEHICLE(players.user_ped(), FFchar, true) ==true then
        Magout()
    elseif PED.IS_PED_IN_ANY_VEHICLE(players.user_ped()) ==false then
        Ccreate(pCoor, pedSi)
    end
    if PED.IS_PED_GETTING_INTO_A_VEHICLE(players.user_ped()) ==false and PED.IS_PED_IN_VEHICLE(players.user_ped(), FFchar , false) ==false then
        util.toast('已离开战马,战马已被删除')
        menu.set_value(Spawn, false)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(FFchar)
        entities.delete_by_handle(FFchar)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Empa)
        entities.delete_by_handle(Empa)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(charger.charg)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(charger.emp)
        util.stop_thread()
    end
end
function stop_daoqizhanma()
    if FFchar or Empa then
        entities.delete_by_handle(FFchar)
        entities.delete_by_handle(Empa)
    end
end
--------------------------------------











------------射击馆
shoot_text_colour = {
    r = 1.0,
    g = 1.0,
    b = 1.0,
    a = 1.0
}
shoot_bg_colour = {
    r = 0.75,
    g = 0.82,
    b = 0.94,
    a = 1
}
shoot_pos = {
    x = -2983.3865,
    y = -5147.500,
    z = 437.15488
}
time_selector ={
    display_options = {"无限制", "30s", "60s", "90s", "120s", "180s", "300s"},
    value = { 0, 30000, 60000, 90000, 120000, 180000, 300000}
}
local max_height = 5
simple3d_target_max_height = {
    display_options = {"地面", "低", "中", "高", "巅峰"},
    height_value = {0, 3, 5, 7, 9}
}
local ped_health = 200
ped_health_selector = {
    display_options = {"NPC", "Player", "一枪击杀", "仅爆头[狙击手MKII]"},
    healh_values = {200, 328, 105, 100000}
}
function clear_all_peds()
    for _, ped in ipairs(entities.get_all_peds_as_handles()) do
        if ped ~= players.user_ped() and not PED.IS_PED_A_PLAYER(ped) then
            entities.delete_by_handle(ped)
            util.yield()
        end
    end
end
function clear_dead_peds()
    for _, ped in ipairs(entities.get_all_peds_as_handles()) do
        if ped ~= players.user_ped() and not PED.IS_PED_A_PLAYER(ped) and ENTITY.IS_ENTITY_DEAD(ped) then
            entities.delete_by_handle(ped)
        end               
    end
end
function create_ped_simple_3d(max_height, health)
    if max_height ~= 0 then
        zrandom = math.random(0, max_height)
    else
        zrandom = 0
    end
    xrandom, yrandom = math.random(0, 63), math.random(0, 82)
    target_ped = PED.CREATE_RANDOM_PED(-2951.51345-xrandom, -5188.895345+yrandom, 437.353345+zrandom)
    ENTITY.SET_ENTITY_HEALTH(target_ped, health, 0)
    ENTITY.FREEZE_ENTITY_POSITION(target_ped, true)
    return target_ped
end
function create_ped_simple_2d(health)
    xrandom, yrandom, zrandom = math.random(0, 63), 0, math.random(0, 10)
    target_ped = PED.CREATE_RANDOM_PED(-2951.51345-xrandom, -5188.895345+yrandom, 437.353345+zrandom)
    ENTITY.SET_ENTITY_HEALTH(target_ped, health, 0)
    ENTITY.FREEZE_ENTITY_POSITION(target_ped, true)
    return target_ped
end
function teleport_to_lab()
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), shoot_pos.x, shoot_pos.y+20, shoot_pos.z + 2, 0, 0, 1)
end
function toint(n)
    local s = tostring(n)
    local i, j = s:find('%.')
    if i then
        return tonumber(s:sub(1, i-1))
    else
        return n
    end
end
function end_minigame(minigame)
    minigame:trigger(false)
    util.yield(1000)
    clear_all_peds() 
end
---------创建训练场
objects = {}
function load_lab()
    objects = {}
    prop_hash = util.joaat("stt_prop_stunt_bblock_huge_03")
    ped_shoot_pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), true)
    STREAMING.REQUEST_MODEL(prop_hash)
	
    local object = OBJECT.CREATE_OBJECT_NO_OFFSET(prop_hash, shoot_pos.x, shoot_pos.y, shoot_pos.z, true, true, false)
    objects[#objects + 1] = object
    local object = OBJECT.CREATE_OBJECT_NO_OFFSET(prop_hash, shoot_pos.x, shoot_pos.y, shoot_pos.z+ 15, true, true, false)
    objects[#objects + 1] = object
    local object = OBJECT.CREATE_OBJECT_NO_OFFSET(prop_hash, shoot_pos.x, shoot_pos.y+42, shoot_pos.z-2.6, true, true, false)
    objects[#objects + 1] = object
    local object = OBJECT.CREATE_OBJECT_NO_OFFSET(prop_hash, shoot_pos.x, shoot_pos.y-42, shoot_pos.z-2.6, true, true, false)
    objects[#objects + 1] = object
    local object = OBJECT.CREATE_OBJECT_NO_OFFSET(prop_hash, shoot_pos.x -32.5, shoot_pos.y, shoot_pos.z, true, true, false)
    objects[#objects + 1] = object
    local object = OBJECT.CREATE_OBJECT_NO_OFFSET(prop_hash, shoot_pos.x +32.5, shoot_pos.y, shoot_pos.z, true, true, false)
    objects[#objects + 1] = object
    util.yield(50)
    rot = ENTITY.GET_ENTITY_ROTATION(objects[3])
    rot.x = 90
	ENTITY.SET_ENTITY_ROTATION(objects[3], rot.x,rot.y,rot.z,1,true)
    rot = ENTITY.GET_ENTITY_ROTATION(objects[4])
    rot.x = 90
	ENTITY.SET_ENTITY_ROTATION(objects[4], rot.x,rot.y,rot.z,1,true)
    rot = ENTITY.GET_ENTITY_ROTATION(objects[5])
    rot.y = 90
	ENTITY.SET_ENTITY_ROTATION(objects[5], rot.x,rot.y,rot.z,1,true)
    rot = ENTITY.GET_ENTITY_ROTATION(objects[6])
    rot.y = -90
	ENTITY.SET_ENTITY_ROTATION(objects[6], rot.x,rot.y,rot.z,1,true)
    util.yield(500)
    teleport_to_lab()
    clear_all_peds()
end
----结束
function Clean_training_ground()
    TELEPORT(-1314, -3057, 13)
    util.yield(500)
        for _, ped in ipairs(entities.get_all_peds_as_handles()) do
            if ped ~= players.user_ped() and not PED.IS_PED_A_PLAYER(ped) then
                entities.delete_by_handle(ped)
            end
        end
        for key, value in pairs(objects) do
            entities.delete_by_handle(value)
        end
end
--------3D射击
ped_health_3d = ped_health
local time_3d = 0
function Shooting_simulation_3D(toggle)
    on = toggle
    ped_health_3d = ped_health_3d
    simple_3d_started = true
    simple_2d_toggle:trigger(false)
    time = time_3d
    menu.trigger_commands("time 11; locktime on")
    util.yield(1000)
    clear_all_peds()
    util.yield(100)
    local target_ped = create_ped_simple_3d(max_height, ped_health_3d)
    HUD.ADD_BLIP_FOR_ENTITY(target_ped)
    local kills = 0
    local end_time = util.current_time_millis() + time
    while on do 
        TASK.TASK_STAND_STILL(target_ped, 1000000)
        -----DRAW INFO BOX
        local cur_time = util.current_time_millis()
        local timer = ((end_time - cur_time)/1000)
        if time > 0 then
            txt = ("得分: "..kills.." | 时间: "..toint(timer))
        else
            txt = ("得分: "..kills.." | 时间: ∞")
        end
        local size_x, size_y = directx.get_text_size((txt), 0.7)
        local shoot_pos_x = (0.5 - size_x/2)
        local shoot_pos_y = 0.015
        directx.draw_rect(shoot_pos_x - 0.01, shoot_pos_y - 0.01, size_x + 0.02, size_y + 0.02, shoot_bg_colour)
        directx.draw_text(shoot_pos_x, shoot_pos_y, txt, 0, 0.70, shoot_text_colour, true ) 
        if timer <= 0 and time > 0 then
            util.toast("3D射击已经结束 | 得分: "..kills.." | 时间: "..toint(time/1000).."s.")
            simple_3d_started = false
            end_minigame(simple_3d_toggle)
        end
        ------TARGET HANDLER
        if ENTITY.IS_ENTITY_DEAD(target_ped) then
            clear_dead_peds()
            if timer > 0 or time == 0 then
                kills = kills + 1
                target_ped = create_ped_simple_3d(max_height, ped_health_3d)
                HUD.ADD_BLIP_FOR_ENTITY(target_ped)
            end
        end
        util.yield()
    end
    if not on then 
        clear_all_peds()
        simple_3d_started = false
    end
end
function Set_condition_3D(index)
    ped_health_3d = ped_health_selector.healh_values[index]
    if simple_3d_started then
        util.toast("将设定状况修改为>"..ped_health_selector.display_options[index].."< 更改将应用于下一场比赛")
    else
        util.toast("将设定状况修改为>"..ped_health_selector.display_options[index].."<")
    end
end
function Set_shoot_time_3D(index)
    time_3d = time_selector.value[index]
    if simple_3d_started then
        util.toast("修改游戏时间至>"..time_selector.display_options[index].."< 更改将应用于下一场比赛")
    else
        util.toast("修改游戏时间至>"..time_selector.display_options[index].."<")
    end
end
function Target_build_height_3D(index)
    max_height = simple3d_target_max_height.height_value[index]
    if simple_3d_started then
        util.toast("将简单3D生成高度修改为 >"..simple3d_target_max_height.display_options[index].."< 更改将应用于下一场比赛")
    else
        util.toast("将简单3D生成高度修改为 >"..simple3d_target_max_height.display_options[index].."<")
    end
end
--------2D射击
ped_health_2d = ped_health
local time_2d = 0
function Shooting_simulation_2D(toggle)
    on = toggle
    simple_2d_started = true
    simple_3d_toggle:trigger(false)
    time = time_2d
    menu.trigger_commands("time 11; locktime on")
    util.yield(1000)
    clear_all_peds()
    util.yield(100)
    local target_ped = create_ped_simple_2d(ped_health_2d)
    HUD.ADD_BLIP_FOR_ENTITY(target_ped)
    local kills = 0
    local end_time = util.current_time_millis() + time
    while on do 
        TASK.TASK_STAND_STILL(target_ped, 1000000)
        -----DRAW INFO BOX
        local cur_time = util.current_time_millis()
        local timer = ((end_time - cur_time)/1000)
        if time > 0 then
            txt = ("得分: "..kills.." | 时间: "..toint(timer))
        else
            txt = ("得分: "..kills.." | 时间: ∞")
        end
        local size_x, size_y = directx.get_text_size((txt), 0.7)
        local shoot_pos_x = (0.5 - size_x/2)
        local shoot_pos_y = 0.015
        directx.draw_rect(shoot_pos_x - 0.01, shoot_pos_y - 0.01, size_x + 0.02, size_y + 0.02, shoot_bg_colour)
        directx.draw_text(shoot_pos_x, shoot_pos_y, txt, 0, 0.70, shoot_text_colour, true ) 
        if timer <= 0 and time > 0 then
            util.toast("2D射击已经结束 | 得分: "..kills.." | 时间: "..toint(time/1000).."s.")
            simple_2d_started = false
            end_minigame(simple_2d_toggle)
        end
        ------TARGET HANDLER
        if ENTITY.IS_ENTITY_DEAD(target_ped) then
            clear_dead_peds()
            if timer > 0 or time == 0 then
                kills = kills + 1
                target_ped = create_ped_simple_2d(ped_health_2d)
                HUD.ADD_BLIP_FOR_ENTITY(target_ped)
            end
        end
        util.yield()
    end
    if not on then 
        simple_2d_started = false
        clear_all_peds()
    end
end
function Set_condition_2D(index)
    ped_health_2d = ped_health_selector.healh_values[index]
    if simple_2d_started then
        util.toast("将设定状况修改为>"..ped_health_selector.display_options[index].."<更改将在下一场比赛中应用")
    else
        util.toast("将设定状况修改为>"..ped_health_selector.display_options[index].."<")
    end
end
function Set_shoot_time_2D(index)
    time_2d = time_selector.value[index]
    if simple_2d_started then
        util.toast("修改游戏时间至>"..time_selector.display_options[index].."< 更改将在下一场比赛中应用。")
    else
        util.toast("修改游戏时间至>"..time_selector.display_options[index].."<")
    end
end





-----自我载具随机升级
function randomupdatcar_self()
    control_vehicle(players.user(), function(vehicle)
        VEHICLE.SET_VEHICLE_MOD_KIT(vehicle, 0)
        for x = 0, 49 do
            local max = VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, x)
            VEHICLE.SET_VEHICLE_MOD(vehicle, x, math.random(-1, max))
        end
        VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, math.random(-1,5))
        for x = 17, 22 do
            VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, x, math.random() > 0.5)
        end
        VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, math.random(0, 255), math.random(0, 255), math.random(0, 255))
        VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, math.random(0, 255), math.random(0, 255), math.random(0, 255))
    end)
end


--------载具喇叭音乐
pitch_map = {
    rest = 0,
    C = 16,
    D = 17,
    E = 18,
    F = 19,
    G = 20,
    A = 21,
    B = 22,
    C2 = 23,
}
local rest = 0
local quarter = 0.25
local MOD_HORN = 14
local horn_on = false
local status, json = pcall(require, "json")

function join_path(parent, child)
    local sub = parent:sub(-1)
    if sub == "/" or sub == "\\" then
        return parent .. child
    else
        return parent .. "/" .. child
    end
end
function get_note(note)
    if type(note) ~= "table" then
        note = {pitch=note}
    end
    if type(note.pitch) ~= "number" then
        note.pitch = pitch_map[note.pitch]
    end
    if note.length == nil then
        note.length = quarter
    end
    return note
end
function play_note(vehicle, song, note, index)
    note = get_note(note)
    local note_playtime = math.floor(song.beat_length * note.length)
    if note.pitch ~= rest then
        horn_on = true
    end
    util.yield(note_playtime)
    horn_on = false
    if song.notes[index+1] ~= nil then
        local next_note = get_note(song.notes[index+1])
        if next_note.pitch ~= rest then
            VEHICLE.SET_VEHICLE_MOD(vehicle, MOD_HORN, next_note.pitch)
        end
    end
    util.yield(song.beat_length - note_playtime)
end
function play_song(song)
    song.beat_length = math.floor(60000 / song.bpm)
    if not PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), true) then
        util.toast("你必须在车内,否则无法开启喇叭音乐.")
        return
    end
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
    if vehicle then
        local original_horn = VEHICLE.GET_VEHICLE_MOD(vehicle, MOD_HORN)
        play_note(vehicle, song, rest, 0)
        for index, note in pairs(song.notes) do
            play_note(vehicle, song, note, index)
        end
        VEHICLE.SET_VEHICLE_MOD(vehicle, MOD_HORN, original_horn)
    end
end
function load_song_from_file(filepath)
    local file = io.open(filepath, "r")
    if file then
        local data = json.decode(file:read("*a"))
        if not data.target_version then
            util.toast("无效的喇叭文件格式.\n缺少了目标版本.")
            return nil
        end
        file:close()
        return data
    else
        error("无法读取文件" .. filepath .. "'")
    end
end
function load_songs(directory)
    local loaded_songs = {}
    for _, filepath in ipairs(filesystem.list_files(directory)) do
        local _, filename, ext = string.match(filepath, "(.-)([^\\/]-%.?([^%.\\/]*))$")
        if not filesystem.is_dir(filepath) and ext == "horn" then
            table.insert(loaded_songs, load_song_from_file(filepath))
        end
    end
    return loaded_songs
end
util.create_tick_handler(function()
    if horn_on then
        PAD2._SET_CONTROL_NORMAL(0, 86, 1)
    end
    return true
end)




-----清理实体
function Clean_up_entities(on_change)
    if on_change == 1 then
        local count = 0
        for k,ent in pairs(entities.get_all_peds_as_handles()) do
            if not PED.IS_PED_A_PLAYER(ent) then
                ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
                entities.delete_by_handle(ent)
                util.yield()
                count = count + 1
            end
        end
            util.toast("NPC清除完成")
        end
        if on_change == 2 then
            local count = 0
            for k, ent in pairs(entities.get_all_vehicles_as_handles()) do
                local PedInSeat = VEHICLE.GET_PED_IN_VEHICLE_SEAT(ent, -1, false)
                if not PED.IS_PED_A_PLAYER(PedInSeat) then
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
                    entities.delete_by_handle(ent)
                    util.yield()
                    count = count + 1
                end
            end
            util.toast("载具清除完成")
            return
        end
        if on_change == 3 then
            local count = 0
            for k,ent in pairs(entities.get_all_objects_as_handles()) do
                ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
                entities.delete_by_handle(ent)
                count = count + 1
                util.yield()
            end
            util.toast("实体已清除")
            return
        end
        if on_change == 4 then
            local count = 0
            for k,ent in pairs(entities.get_all_pickups_as_handles()) do
                ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
                entities.delete_by_handle(ent)
                count = count + 1
                util.yield()
            end
            util.toast("拾取物已清除")
            return
        end
        if on_change == 5 then
            local count = 0
            for k,ent in pairs(entities.get_all_peds_as_handles()) do
                if not PED.IS_PED_A_PLAYER(ent) then
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
                    entities.delete_by_handle(ent)
                    util.yield()
                    count = count + 1
                end
            end
            for k, ent in pairs(entities.get_all_vehicles_as_handles()) do
                local PedInSeat = VEHICLE.GET_PED_IN_VEHICLE_SEAT(ent, -1, false)
                if not PED.IS_PED_A_PLAYER(PedInSeat) then
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
                    entities.delete_by_handle(ent)
                    util.yield()
                    count = count + 1
                end
            end
            for k,ent in pairs(entities.get_all_objects_as_handles()) do
                ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
                entities.delete_by_handle(ent)
                count = count + 1
                util.yield()
            end
            for k,ent in pairs(entities.get_all_pickups_as_handles()) do
                ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
                entities.delete_by_handle(ent)
                count = count + 1
                util.yield()
            end
            util.toast("清理完成")
            return
        end
end
------普通清除
function Normal_clearance()
    local ct = 0
    for k,ent in pairs(entities.get_all_vehicles_as_handles()) do
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
        entities.delete_by_handle(ent)
        ct = ct + 1
    end
    for k,ent in pairs(entities.get_all_peds_as_handles()) do
        if not PED.IS_PED_A_PLAYER(ent) then
            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
            entities.delete_by_handle(ent)
        end
            ct = ct + 1
        end
end
-----超级清除
function chaojiqingchu()
    local cleanse_entitycount = 0
    for _, ped in pairs(entities.get_all_peds_as_handles()) do
        if ped ~= players.user_ped() and not PED.IS_PED_A_PLAYER(ped) and NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ped) and (not NETWORK.NETWORK_IS_ACTIVITY_SESSION() or NETWORK.NETWORK_IS_ACTIVITY_SESSION() and not ENTITY.IS_ENTITY_A_MISSION_ENTITY(ped)) then
            entities.delete_by_handle(ped)
            cleanse_entitycount += 1
            util.yield_once()
        end
    end
    util.toast("已清除 " .. cleanse_entitycount .. " Peds")
    cleanse_entitycount = 0
    for _, vehicle in ipairs(entities.get_all_vehicles_as_handles()) do
        if vehicle ~= PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false) and DECORATOR.DECOR_GET_INT(vehicle, "Player_Vehicle") == 0 and NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vehicle) then
            entities.delete_by_handle(vehicle)
            cleanse_entitycount += 1
            util.yield_once()
        end
    end
    util.toast("已清除 ".. cleanse_entitycount .." 载具")
    cleanse_entitycount = 0
    for _, object in pairs(entities.get_all_objects_as_handles()) do
        entities.delete_by_handle(object)
        cleanse_entitycount += 1
        util.yield_once()
    end
    util.toast("已清除 " .. cleanse_entitycount .. " 物体")
    cleanse_entitycount = 0
    for _, pickup in pairs(entities.get_all_pickups_as_handles()) do
        entities.delete_by_handle(pickup)
        cleanse_entitycount += 1
        util.yield_once()
    end
    util.toast("已清除 " .. cleanse_entitycount .. " 可拾取物体")
    local temp = memory.alloc(4)
    for i = 0, 100 do
        memory.write_int(temp, i)
        PHYSICS.DELETE_ROPE(temp)
    end
    util.toast("已清除所有绳索")
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    MISC.CLEAR_AREA_OF_PROJECTILES(pos.x, pos.y, pos.z, 400, 0)
    util.toast("已清除所有投掷物")
end


-----在玩家身上下雨
function Delcar(vic)
    if PED.IS_PED_IN_ANY_VEHICLE(vic) ==true then
        local tarcar = PED.GET_VEHICLE_PED_IS_IN(vic, true)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(tarcar)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(tarcar)
        entities.delete_by_handle(tarcar)
    end
end
local mir = {weap = 'WEAPON_SNOWBALL'}
function Rain_on_players(pid)
local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
        local weap = util.joaat(mir.weap)
        Delcar(targets)
        WEAPON.REQUEST_WEAPON_ASSET(weap)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x, tar1.y, tar1.z, tar1.x , tar1.y, tar1.z - 2.0, 200, 0, weap, 0, true, false, 1000)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x, tar1.y, tar1.z + 1.0, tar1.x , tar1.y, tar1.z, 200, 0, weap, 0, true, false, 1000)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x, tar1.y + 1.0, tar1.z, tar1.x , tar1.y, tar1.z, 200, 0, weap, 0, true, false, 1000)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x + 1.0, tar1.y , tar1.z, tar1.x , tar1.y, tar1.z, 200, 0, weap, 0, true, false, 1000)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x + 1.0, tar1.y + 1.0, tar1.z, tar1.x , tar1.y, tar1.z, 200, 0, weap, 0, true, false, 1000)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x - 1.0, tar1.y, tar1.z, tar1.x , tar1.y, tar1.z, 200, 0, weap, 0, true, false, 1000)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x, tar1.y - 1.0, tar1.z, tar1.x , tar1.y, tar1.z, 200, 0, weap, 0, true, false, 1000)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(tar1.x - 1.0, tar1.y - 1.0, tar1.z, tar1.x , tar1.y, tar1.z, 200, 0, weap, 0, true, false, 1000)
end
function Rain_on_players_type(weapsel, text)
    mir.weap = Weap[weapsel]
    menu.set_menu_name(mirloop, '在玩家身上下雨 ' ..': '.. text)
end


-----垂直堆叠
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
    return size
end
function setstacky(s)
    if player_cur_car ~= 0 then
        old_veh = player_cur_car
        for i=1, s do
            local c = ENTITY.GET_ENTITY_COORDS(old_veh, false)
            local mdl = ENTITY.GET_ENTITY_MODEL(player_cur_car)
            local size = get_model_size(mdl)
            local r = ENTITY.GET_ENTITY_ROTATION(old_veh, 0)
            new_veh = entities.create_vehicle(mdl, players.get_position(players.user()), ENTITY.GET_ENTITY_HEADING(old_veh))
            ENTITY.ATTACH_ENTITY_TO_ENTITY(new_veh, old_veh, 0, 0.0, 0.0, size.z, 0.0, 0.0, 0.0, true, false, falsmy_e, false, 0, true)
            old_veh = new_veh
        end
    end
end
----水平堆叠
function setstackx(s)
    if player_cur_car ~= 0 then
        for i=1, s do
            main_veh = player_cur_car
            local c = ENTITY.GET_ENTITY_COORDS(main_veh, false)
            local mdl = ENTITY.GET_ENTITY_MODEL(main_veh)
            local size = get_model_size(mdl)
            local r = ENTITY.GET_ENTITY_ROTATION(main_veh, 0)
            left_new = entities.create_vehicle(mdl, players.get_position(players.user()), ENTITY.GET_ENTITY_HEADING(main_veh))
            ENTITY.ATTACH_ENTITY_TO_ENTITY(left_new, main_veh, 0, -size.x*i, 0.0, 0.0, 0.0, 0.0, 0.0, true, false, false, false, 0, true)
            right_new = entities.create_vehicle(mdl, players.get_position(players.user()), ENTITY.GET_ENTITY_HEADING(main_veh))
            ENTITY.ATTACH_ENTITY_TO_ENTITY(right_new, main_veh, 0, size.x*i, 0.0, 0.0, 0.0, 0.0, 0.0, true, false, false, false, 0, true)
        end
    end
end

--------抛掷载具
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
function request_control_of_entity_once(ent)
    if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) and util.is_session_started() then
        local netid = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(ent)
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netid, true)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ent)
    end
end
local entity_held = 0
local are_hands_up = false
local ped_held = 0
function throwvehs()
    if PAD.IS_CONTROL_JUST_RELEASED(38, 38) and not PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true)  then
        if entity_held == 0 then
            if not are_hands_up then 
                local closest = get_closest_veh(ENTITY.GET_ENTITY_COORDS(players.user_ped()))
                local veh = closest[1]
                if veh ~= nil then 
                    local dist = closest[2]
                    if dist <= 5 then 
                        request_anim_dict("missminuteman_1ig_2")
                        TASK.TASK_PLAY_ANIM(players.user_ped(), "missminuteman_1ig_2", "handsup_enter", 8.0, 0.0, -1, 50, 0, false, false, false)
                        util.yield(500)
                        are_hands_up = true
                        ENTITY.SET_ENTITY_ALPHA(veh, 100)
                        ENTITY.SET_ENTITY_HEADING(veh, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
                        ENTITY.SET_ENTITY_INVINCIBLE(veh, true)
                        request_control_of_entity_once(veh)
                        ENTITY.ATTACH_ENTITY_TO_ENTITY(veh, players.user_ped(), 0, 0, 0, get_model_size(ENTITY.GET_ENTITY_MODEL(veh)).z / 2, 180, 180, -180, true, false, true, false, 0, true)
                        entity_held = veh
                    end 
                end
            else
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
                are_hands_up = false
            end
        else
            if ENTITY.IS_ENTITY_A_VEHICLE(entity_held) then
                ENTITY.DETACH_ENTITY(entity_held)
                VEHICLE.SET_VEHICLE_FORWARD_SPEED(entity_held, 100.0)
                VEHICLE.SET_VEHICLE_OUT_OF_CONTROL(entity_held, true, true)
                ENTITY.SET_ENTITY_ALPHA(entity_held, 255)
                ENTITY.SET_ENTITY_INVINCIBLE(veh, false)
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
                ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(), true)
                ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(entity_held, players.user_ped(), false)
                request_anim_dict("melee@unarmed@streamed_core")
                TASK.TASK_PLAY_ANIM(players.user_ped(), "melee@unarmed@streamed_core", "heavy_punch_a", 8.0, 8.0, -1, 0, 0.3, false, false, false)
                util.yield(500)
                ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(), false)
                entity_held = 0
                are_hands_up = false
            end
        end
    end
end
------抛掷NPC
function get_closest_ped_new(coords)
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
function throwpeds()
    if PAD.IS_CONTROL_JUST_RELEASED(38, 38) and not PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) then
        if entity_held == 0 then
            if not are_hands_up then 
                local closest = get_closest_ped_new(ENTITY.GET_ENTITY_COORDS(players.user_ped()))
                if closest ~= nil then
                    local ped = closest[1]
                    if ped ~= nil then
                        local dist = closest[2]
                        if dist <= 5 then 
                            request_anim_dict("missminuteman_1ig_2")
                            TASK.TASK_PLAY_ANIM(players.user_ped(), "missminuteman_1ig_2", "handsup_enter", 8.0, 0.0, -1, 50, 0, false, false, false)
                            util.yield(500)
                            are_hands_up = true
                            ENTITY.SET_ENTITY_ALPHA(ped, 100)
                            ENTITY.SET_ENTITY_HEADING(ped, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
                            request_control_of_entity_once(ped)
                            ENTITY.ATTACH_ENTITY_TO_ENTITY(ped, players.user_ped(), 0, 0, 0, 1.3, 180, 180, -180, true, false, true, true, 0, true)
                            entity_held = ped
                        end 
                    end
                end
            else
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
                are_hands_up = false
            end
        else
            if ENTITY.IS_ENTITY_A_PED(entity_held) then
                ENTITY.DETACH_ENTITY(entity_held)
                ENTITY.SET_ENTITY_ALPHA(entity_held, 255)
                PED.SET_PED_TO_RAGDOLL(entity_held, 10, 10, 0, false, false, false)
                --ENTITY.SET_ENTITY_VELOCITY(entity_held, 0, 100, 0)
                ENTITY.SET_ENTITY_MAX_SPEED(entity_held, 100.0)
                ENTITY.APPLY_FORCE_TO_ENTITY(entity_held, 1, 0, 100, 0, 0, 0, 0, 0, true, false, true, false, false)
                AUDIO.PLAY_PAIN(entity_held, 7, 0, 0)
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
                ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(), true)
                ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(entity_held, players.user_ped(), false)
                request_anim_dict("melee@unarmed@streamed_core")
                TASK.TASK_PLAY_ANIM(players.user_ped(), "melee@unarmed@streamed_core", "heavy_punch_a", 8.0, 8.0, -1, 0, 0.3, false, false, false)
                util.yield(500)
                ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(), false)
                entity_held = 0
                are_hands_up = false
            end
        end
    end
end


-------司机服务
local taxi_ped = 0
local taxi_veh = 0
local taxi_blip = -1
function max_out_car(veh)
    for i=0, 49 do
        num = VEHICLE.GET_NUM_VEHICLE_MODS(veh, i)
        VEHICLE.SET_VEHICLE_MOD(veh, i, num -1, true)
    end
end
function summ_car(index, value)
    local vhash = util.joaat(value)
    local phash = util.joaat("s_m_y_casino_01")
    if taxi_veh ~= 0 then
        entities.delete_by_handle(taxi_veh)
    end
    if taxi_ped ~= 0 then
        util.remove_blip(taxi_blip)
        entities.delete_by_handle(taxi_ped)
    end 
    local plyr = players.user_ped()
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(plyr, 0.0, 5.0, 0.0)
    request_model_load(vhash)
    request_model_load(phash)
    taxi_veh = entities.create_vehicle(vhash, coords, ENTITY.GET_ENTITY_HEADING(plyr))
    max_out_car(taxi_veh)
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(taxi_veh, "LANCE")
    VEHICLE.SET_VEHICLE_COLOURS(taxi_veh, 145, 145)
    ENTITY.SET_ENTITY_INVINCIBLE(taxi_veh, true)
    taxi_ped = entities.create_ped(32, phash, coords, ENTITY.GET_ENTITY_HEADING(plyr))
    PED.SET_PED_RELATIONSHIP_GROUP_HASH(taxi_ped, util.joaat("rgFM_AiLike"))
    taxi_blip = HUD.ADD_BLIP_FOR_ENTITY(taxi_ped)
    HUD.SET_BLIP_COLOUR(taxi_blip, 7)
    ENTITY.SET_ENTITY_INVINCIBLE(taxi_ped, true)
    PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(taxi_ped, true)
    PED.SET_PED_FLEE_ATTRIBUTES(taxi_ped, 0, false)
    PED.SET_PED_CAN_BE_DRAGGED_OUT(taxi_ped, false)
    VEHICLE.SET_VEHICLE_EXCLUSIVE_DRIVER(taxi_veh, taxi_ped, -1)
    PED.SET_PED_INTO_VEHICLE(taxi_ped, taxi_veh, -1)
    ENTITY.SET_ENTITY_INVINCIBLE(taxi_ped, true)
    PED.SET_PED_INTO_VEHICLE(players.user_ped(), taxi_veh, 0)
    util.toast("您的司机已创建！")
end
function summ_car_topoint()
    if taxi_ped == 0 then
        util.toast("你没有生成司机")
    else
        local goto_coords = get_waypoint_coords()
        if goto_coords ~= nil then
            TASK.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE(taxi_ped, taxi_veh, goto_coords['x'], goto_coords['y'], goto_coords['z'], 300.0, 786996, 5)
        end
    end
end
function summ_car_tp()
    if taxi_ped == 0 then
        util.toast("你没有生成司机.")
    else
        PED.SET_PED_INTO_VEHICLE(players.user_ped(), taxi_veh, 0)
    end
end
function summ_car_bmob()
    if taxi_ped == 0 then
        util.toast("你没有生成司机.")
    else
        local ped_copy = taxi_ped
        local veh_copy = taxi_veh
        taxi_ped = 0
        taxi_veh = 0
        local coords = ENTITY.GET_ENTITY_COORDS(veh_copy)
        ENTITY.SET_ENTITY_INVINCIBLE(veh_copy, false)
        FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 7, 100.0, true, false, 1.0)
        ENTITY.SET_ENTITY_HEALTH(veh_copy, 0)
        ENTITY.SET_ENTITY_INVINCIBLE(ped_copy, false)
        ENTITY.SET_ENTITY_HEALTH(ped_copy, 0)
        if math.random(5) == 3 then
            util.toast("他有老婆孩子...")
        end
        util.yield(3000)
        entities.delete_by_handle(ped_copy)
        entities.delete_by_handle(veh_copy)
    end
end


--载具快速定制转弯
function FastTurnVehicleWithKeys(scale)
    local veh = PED.GET_VEHICLE_PED_IS_IN(GetLocalPed(), false)
    local vv = ENTITY.GET_ENTITY_ROTATION(veh, 2)
    local velocity = ENTITY.GET_ENTITY_SPEED_VECTOR(veh, true).y
    --Pitch: X || Roll: y || Yaw: z
    local vvPitch = v3.getX(vv)
    local vvRoll = v3.getY(vv)
    local vvYaw = v3.getZ(vv)
    if PAD.IS_CONTROL_PRESSED(0, 63) then --63 || INPUT_VEH_MOVE_LEFT_ONLY || A
        --OLD LOGIC || if velocity > 0 then --if velocity is greater than 0, we do usual turning logic.
        if PAD.IS_CONTROL_PRESSED(0, 71) or velocity > -0.1 then
            local yawAfterPress = vvYaw + scale
            if yawAfterPress > 180 then -- check for overflow
                local overFlowNeg = math.abs(vvYaw)*-1 --negative bypass overflow
                local toSetYaw = overFlowNeg + scale
                ENTITY.SET_ENTITY_ROTATION(veh, vvPitch, vvRoll, toSetYaw, 2, true)
            else --if not overflow
                ENTITY.SET_ENTITY_ROTATION(veh, vvPitch, vvRoll, yawAfterPress, 2, true)
            end
        elseif PAD.IS_CONTROL_PRESSED(0, 72) or velocity < -0.1 then --if not, then we do opposite turning logic.
            local yawAfterPress = vvYaw - scale
            if yawAfterPress < -180 then -- check for overflow
                local overFlowNeg = math.abs(vvYaw) --positive bypass overflow
                local toSetYaw = overFlowNeg - scale
                ENTITY.SET_ENTITY_ROTATION(veh, vvPitch, vvRoll, toSetYaw, 2, true)
            else --if not overflow
                ENTITY.SET_ENTITY_ROTATION(veh, vvPitch, vvRoll, yawAfterPress, 2, true)
            end
        end
    end
    if PAD.IS_CONTROL_PRESSED(0, 64) then --64 ||INPUT_VEH_MOVE_RIGHT_ONLY || D
        --OLD LOGIC || if velocity > 0 then --if velocity is greater than 0, we do usual turning logic.
        if PAD.IS_CONTROL_PRESSED(0, 71) or velocity > -0.1 then
        local yawAfterPress = vvYaw - scale
        if yawAfterPress < -180 then -- check for overflow
            local overFlowNeg = math.abs(vvYaw) --positive bypass overflow
            local toSetYaw = overFlowNeg - scale
            ENTITY.SET_ENTITY_ROTATION(veh, vvPitch, vvRoll, toSetYaw, 2, true)
        else --if not overflow
            ENTITY.SET_ENTITY_ROTATION(veh, vvPitch, vvRoll, yawAfterPress, 2, true)
        end
        elseif PAD.IS_CONTROL_PRESSED(0, 72) or velocity < -0.1 then --if not, then we do opposite turning logic.

            local yawAfterPress = vvYaw + scale
            if yawAfterPress > 180 then -- check for overflow
                local overFlowNeg = math.abs(vvYaw)*-1 --negative bypass overflow
                local toSetYaw = overFlowNeg + scale
                ENTITY.SET_ENTITY_ROTATION(veh, vvPitch, vvRoll, toSetYaw, 2, true)
            else --if not overflow
                ENTITY.SET_ENTITY_ROTATION(veh, vvPitch, vvRoll, yawAfterPress, 2, true)
            end
        end

    end
    v3.free(vv)
end


function version()
    game_version = 1.66
    online_v = tonumber(NETWORK1._GET_ONLINE_VERSION())
    if online_v > game_version then
        util.stop_script()
    end
end


-----电击笼子
function Shock_cage(pid)
    local number_of_cages = 6
    local elec_box = util.joaat("prop_elecbox_12")
    local pos = players.get_position(pid)
    pos.z -= 0.5
    RequestModel(elec_box)
    local temp_v3 = v3.new(0, 0, 0)
    for i = 1, number_of_cages do
        local angle = (i / number_of_cages) * 360
        temp_v3.z = angle
        local obj_pos = temp_v3:toDir()
        obj_pos:mul(2.5)
        obj_pos:add(pos)
        for offs_z = 1, 5 do
            local electric_cage = entities.create_object(elec_box, obj_pos)
            spawned_objects[#spawned_objects + 1] = electric_cage
            ENTITY.SET_ENTITY_ROTATION(electric_cage, 90.0, 0.0, angle, 2, 0)
            obj_pos.z += 0.75
            ENTITY.FREEZE_ENTITY_POSITION(electric_cage, true)
        end
    end
end
--------集装箱笼子
function Container_cage(pid)
    local container_hash = util.joaat("prop_container_ld_pu")
    local pos = players.get_position(pid)
    RequestModel(container_hash)
    pos.z -= 1
    local container = entities.create_object(container_hash, pos, 0)
    spawned_objects[#spawned_objects + 1] = container
    ENTITY.FREEZE_ENTITY_POSITION(container, true)
end
-----载具笼子
function Vehicle_cage(pid)
    local container_hash = util.joaat("boxville3")
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = players.get_position(pid)
    RequestModel(container_hash)
    local container = entities.create_vehicle(container_hash, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 2.0, 0.0), ENTITY.GET_ENTITY_HEADING(ped))
    spawned_objects[#spawned_objects + 1] = container
    ENTITY.SET_ENTITY_VISIBLE(container, false)
    ENTITY.FREEZE_ENTITY_POSITION(container, true)
end
-----关门放狗
function Close_dog(pid)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
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
    util.yield(100)
    for i = 1, 20 do
        send_attacker(-1788665315, pid, false)
        util.yield(1)
    end
end
----恐怖之牢
function Terror_Prison(pid)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
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
    util.yield(100)
    for i = 1, 20 do
        send_attacker(util.joaat("CS_BradCadaver"), pid, false)
        util.yield(1)
    end
end
------小的竞技管
function Small_athletics(pid)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
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
-----竖向货机笼子
function Vertical_freighter_cage(pid)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 0.0, 5.0)
    --local hash = util.joaat("prop_ld_crate_01")
    local hash = util.joaat('titan')
    request_model_load(hash)
    local cage = entities.create_vehicle(hash, coords, 0)
    ENTITY.SET_ENTITY_ROTATION(cage, 90, 0, 0, 0)
    --ENTITY.FREEZE_ENTITY_POSITION(cage, true)
    ENTITY.SET_ENTITY_INVINCIBLE(cage, true)
    ENTITY.FREEZE_ENTITY_POSITION(cage, true)
end
-------横行货机笼子
function Rampage_plane_cage(pid)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 0.0, 0.0)
    local hash = util.joaat("cargoplane")
    request_model_load(hash)
    local cargo = entities.create_vehicle(hash, coords, ENTITY.GET_ENTITY_HEADING(ped))
    ENTITY.FREEZE_ENTITY_POSITION(cargo, true)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(cargo, coords.x, coords.y, coords.z-0.1, true, false, false)
    ENTITY.SET_ENTITY_INVINCIBLE(cargo, true)
    for i=1, 5 do
        VEHICLE.SET_VEHICLE_DOOR_LATCHED(cargo, i, true, true, true)
    end
end

------天煞战斗机
function Celestial_Fighter(pid)
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(target_ped, 1.0, 0.0, 500.0)
    coords.x = coords['x']
    coords.y = coords['y']
    coords.z = coords['z']
    local hash = util.joaat("lazer")
    request_model_load(hash)
    request_model_load(-163714847)
    for i=1, num_attackers do
        coords.x = coords.x + i*2
        coords.y = coords.y + i*2
        local jet = entities.create_vehicle(hash, coords, 0.0)
        VEHICLE.CONTROL_LANDING_GEAR(jet, 3)
        VEHICLE.SET_HELI_BLADES_FULL_SPEED(jet)
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(jet, VEHICLE.GET_VEHICLE_ESTIMATED_MAX_SPEED(jet))
        if godmodeatk then
            ENTITY.SET_ENTITY_INVINCIBLE(jet, true)
        end
        local pilot = entities.create_ped(28, -163714847, coords, 30.0)
        PED.SET_PED_COMBAT_ATTRIBUTES(pilot, 5, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(pilot, 46, true)
        PED.SET_PED_INTO_VEHICLE(pilot, jet, -1)
        TASK.TASK_PLANE_MISSION(pilot, jet, 0, target_ped, 0, 0, 0, 6, 0.0, 0, 0.0, 50.0, 40.0)
        TASK.TASK_COMBAT_PED(pilot, target_ped, 0, 16)
        PED.SET_PED_ACCURACY(pilot, 100.0)
        PED.SET_PED_COMBAT_ABILITY(pilot, 2)
    end
end

--------命中效果
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
hitEffects = {
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


------绿汽水
spawned_objects = {}
random_spawn_vehicles = {}

for _, sprunk_vehicle in pairs(sprunk_vehicles) do
    if sprunk_vehicle.is_random_spawn ~= false then
        table.insert(random_spawn_vehicles, sprunk_vehicle)
    end
end

function load_hash(hash)
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do
        util.yield()
    end
end
function spawn_object_at_pos(pos, model, ttl)
    local pickup_hash = util.joaat(model)
    load_hash(pickup_hash)
    local pickup_pos = v3.new(pos.x, pos.y, pos.z)
    local pickup = entities.create_object(pickup_hash, pickup_pos)
    ENTITY.SET_ENTITY_COLLISION(pickup, true, true)
    ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(
        pickup, 5, 0, 0, 1,
        true, false, true, true
    )
    table.insert(spawned_objects, { handle=pickup, spawn_time=util.current_time_millis(), ttl=ttl})
end
function nearby_position(pos, range)
    if range == nil then
        range = {
            x_max=1, y_max=1, z_max=1,
            x_min=-1, y_min=-1, z_min=0,
        }
    end
    return {
        x=pos.x + math.random(range.x_min, range.x_max),
        y=pos.y + math.random(range.y_min, range.y_max),
        z=pos.z + math.random(range.z_min, range.z_max),
    }
end
function sprunk_can_drop(position, range, model, ttl)
    local spawn_position = position
    if range then
        spawn_position = nearby_position(position, range)
    end
    if model == nil then
        model = "ng_proc_sodacan_01b"
    end
    spawn_object_at_pos(spawn_position, model, ttl)
end
function get_rain_range()
    return {
        x_max=3, y_max=3, z_max=4,
        x_min=3 * -1, y_min=3 * -1, z_min=4,
    }
end
function sprunk_drop_player(pid, range)
    sprunk_can_drop(players.get_position(pid), range)
end
function sprunk_raindrop_player(pid)
    sprunk_drop_player(pid, get_rain_range())
end
function spawn_vehicle_for_player(pid, model_name)
    local model = util.joaat(model_name)
    if not STREAMING.IS_MODEL_VALID(model) or not STREAMING.IS_MODEL_A_VEHICLE(model) then
        -- util.toast("Error: Invalid vehicle name")
        return
    else
        load_hash(model)
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(target_ped, 0.0, 4.0, 0.5)
        local heading = ENTITY.GET_ENTITY_HEADING(target_ped)
        local vehicle = entities.create_vehicle(model, pos, heading)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(model)
        return vehicle
    end
end
function vehicle_set_mod_max_value(vehicle, vehicle_mod)
    local max = VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, vehicle_mod) - 1
    VEHICLE.SET_VEHICLE_MOD(vehicle, vehicle_mod, max)
end
function vehicle_mods_set_max_performance(vehicle)
    vehicle_set_mod_max_value(vehicle, 11)
    vehicle_set_mod_max_value(vehicle, 13)
    vehicle_set_mod_max_value(vehicle, 12)
    vehicle_set_mod_max_value(vehicle, 16)
    VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 18, true)
end
function sprunkify_vehicle(vehicle)
    vehicle_mods_set_max_performance(vehicle)
    local color = {r=0, g=255, b=0}
    VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, color.r, color.g, color.b)
    VEHICLE.SET_VEHICLE_MOD_COLOR_1(vehicle, 0, 0, 0)
    VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, color.r, color.g, color.b)
    VEHICLE.SET_VEHICLE_MOD_COLOR_2(vehicle, 0, 0, 0)
    VEHICLE1._SET_VEHICLE_INTERIOR_COLOR(vehicle, 55)
    VEHICLE1._SET_VEHICLE_DASHBOARD_COLOR(vehicle, 55)
    VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 22, true)
    VEHICLE1._SET_VEHICLE_XENON_LIGHTS_COLOR(vehicle, 4)
    VEHICLE1._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 0, true)
    VEHICLE1._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 1, true)
    VEHICLE1._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 2, true)
    VEHICLE1._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 3, true)
    VEHICLE1._SET_VEHICLE_NEON_LIGHTS_COLOUR(vehicle, color.r, color.g, color.b)
    VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicle, 0, 55)
    VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 20, true)
    VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, 0, 255, 0)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(vehicle, true, true)
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "SPRUNK")
    local target_livery = -1
    local model_hash = entities.get_model_hash(entities.handle_to_pointer(vehicle))
    for _, sprunk_vehicle in pairs(sprunk_vehicles) do
        if sprunk_vehicle.model_hash == model_hash then
            target_livery = sprunk_vehicle.livery
        end
    end
    VEHICLE.SET_VEHICLE_LIVERY(vehicle, target_livery)
    VEHICLE.SET_VEHICLE_MOD(vehicle, 48, target_livery)
end
function sprunk_drop_vehicle(vehicle, range)
    sprunk_can_drop(ENTITY.GET_ENTITY_COORDS(vehicle), range)
end
function sprunk_raindrop_vehicle(vehicle)
    sprunk_drop_vehicle(vehicle, get_rain_range())
end
----绿气传染
local currently_dumping = false
function trash_dump_player(pid)
    if currently_dumping then
        -- Only allow one dump at a time to avoid overloading models
        return
    end
    currently_dumping = true
    local NUM_CANS_TO_DROP = 100
    local num_cans_dropped = 0
    repeat
        local can_models = {
            -- "ng_proc_sodacan_01b",
            "ng_proc_sodacan_02b",
            "ng_proc_sodacan_02d",
            "ng_proc_sodacan_03b"
        }
        sprunk_can_drop(
                players.get_position(pid),
                {
                    x_max=1, y_max=1, z_max=4,
                    x_min=-1, y_min=-1, z_min=2,
                },
                can_models[math.random(1, #can_models)],
                15000
        )
        num_cans_dropped = num_cans_dropped + 1
        util.yield(10)
    until num_cans_dropped >= NUM_CANS_TO_DROP
    currently_dumping = false
end
------飞艇
function spawn_sprunk_blimp(pid)
    if not happy_blimps_toggle then
        return
    end

    local vehicle_hash = util.joaat('blimp3')
    local ped_hash = util.joaat("s_m_m_pilot_01")
    load_hash(vehicle_hash)
    load_hash(ped_hash)

    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(
        target_ped,
        math.random(-500, 500),
        math.random(-500, 500),
        math.random(350, 500)
    )

    local aircraft = entities.create_vehicle(vehicle_hash, pos, math.random(0, 360))
    sprunkify_vehicle(aircraft)
    VEHICLE.SET_VEHICLE_ENGINE_ON(aircraft, true, true, false)
    VEHICLE.SET_HELI_BLADES_FULL_SPEED(aircraft)
    VEHICLE.SET_VEHICLE_FORWARD_SPEED(aircraft, VEHICLE.GET_VEHICLE_ESTIMATED_MAX_SPEED(aircraft)/4)

    local pilot = entities.create_ped(1, ped_hash, pos, 0.0)
    PED.SET_PED_INTO_VEHICLE(pilot, aircraft, -1)
    PED.SET_PED_KEEP_TASK(pilot, true)
    local blip = HUD.ADD_BLIP_FOR_ENTITY(aircraft)
    HUD.SET_BLIP_SPRITE(blip, 638)
    HUD.SET_BLIP_COLOUR(blip, 69)

    local ttl = 300000 + math.random(-1000, 1000)
    local blimp_object = {
        handle=aircraft,
        type="blimp",
        spawn_time=util.current_time_millis(),
        ttl=ttl,
        respawn_function=spawn_sprunk_blimp,
        pid=pid,
        pilot_handle=pilot,
    }
    table.insert(spawned_objects, blimp_object)

end
function array_remove(t, fnKeep)
    local j, n = 1, #t;

    for i=1,n do
        if (fnKeep(t, i, j)) then
            -- Move i's kept value to j's position, if it's not already there.
            if (i ~= j) then
                t[j] = t[i];
                t[i] = nil;
            end
            j = j + 1; -- Increment position of where we'll place the next kept value.
        else
            t[i] = nil;
        end
    end

    return t;
end
function delete_spawned_object(spawned_object)
    if spawned_object.pilot_handle then
        entities.delete_by_handle(spawned_object.pilot_handle)
    end
    entities.delete_by_handle(spawned_object.handle)
end
function clear_blimps()
    array_remove(spawned_objects, function(t, i, j)
        local spawned_object = t[i]
        if spawned_object.type == "blimp" then
            delete_spawned_object(spawned_object)
            return false
        end
        return true
    end)
end

------绿气传染
function Green_contagion()
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
    local pos = ENTITY.GET_ENTITY_COORDS(ped, 1)
    local range = 100
    local nearby_vehicles = entities.get_all_vehicles_as_handles()
    local count = 0
    for _, vehicle in ipairs(nearby_vehicles) do
        local vehicle_pos = ENTITY.GET_ENTITY_COORDS(vehicle, 1)
        local distance = SYSTEM.VDIST(pos.x, pos.y, pos.z, vehicle_pos.x, vehicle_pos.y, vehicle_pos.z)
        if distance <= range then
            sprunkify_vehicle(vehicle)
            count = count + 1
        end
    end
    util.toast(count.." 载具染色!")
end







--------无效载具崩溃
function clone(vehicle)
    local vehicleHeading<const> = ENTITY.GET_ENTITY_HEADING(vehicle)
    local vehicleHash<const> = ENTITY.GET_ENTITY_MODEL(vehicle)
    local coords = ENTITY.GET_ENTITY_COORDS(vehicle)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(vehicle)
    local rot = v3.toDir(ENTITY.GET_ENTITY_ROTATION(vehicle, 2))
    v3.mul(rot, -getDimensions(vehicle).x - 2)
    v3.add(coords, rot)
    local cloneVehicle<const> = entities.create_vehicle(vehicleHash, coords, vehicleHeading)
    copyVehicleData(vehicle, cloneVehicle)
    return cloneVehicle
end
local minimum<const> = memory.alloc()
local maximum<const> = memory.alloc()
function getDimensions(entity)
    MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(entity), minimum, maximum)
    local minimum_vec<const> = v3.new(minimum)
    local maximum_vec<const> = v3.new(maximum)
    local dimensions<const> = {
        x = maximum_vec.y - minimum_vec.y,
        y = maximum_vec.x - minimum_vec.x,
        z = maximum_vec.z - minimum_vec.z
    }
    return dimensions
end
local colorR, colorG, colorB = memory.alloc(1), memory.alloc(1), memory.alloc(1)
function copyVehicleData(vehicle, cloneVehicle)
    VEHICLE.SET_VEHICLE_MOD_KIT(cloneVehicle, 0)
    for i = 17, 22 do
        VEHICLE.TOGGLE_VEHICLE_MOD(cloneVehicle, i, VEHICLE.IS_TOGGLE_MOD_ON(vehicle, i))
    end
    for i = 0, 49 do
        local modValue<const> = VEHICLE.GET_VEHICLE_MOD(vehicle, i)
        VEHICLE.SET_VEHICLE_MOD(cloneVehicle, i, modValue)
    end
    if VEHICLE.GET_IS_VEHICLE_PRIMARY_COLOUR_CUSTOM(vehicle) then
        VEHICLE.GET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, colorR, colorG, colorB)
        VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG), memory.read_ubyte(colorB))
    else
        VEHICLE.GET_VEHICLE_MOD_COLOR_1(vehicle, colorR, colorG, colorB)
        VEHICLE.SET_VEHICLE_MOD_COLOR_1(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG), memory.read_ubyte(colorB))
    end
    if VEHICLE.GET_IS_VEHICLE_SECONDARY_COLOUR_CUSTOM(vehicle) then
        VEHICLE.GET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, colorR, colorG, colorB)
        VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG), memory.read_ubyte(colorB))
    else
        VEHICLE.GET_VEHICLE_MOD_COLOR_2(vehicle, colorR, colorG)
        VEHICLE.SET_VEHICLE_MOD_COLOR_2(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG))
    end
    VEHICLE.GET_VEHICLE_COLOURS(vehicle, colorR, colorG)
    VEHICLE.SET_VEHICLE_COLOURS(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG))
    VEHICLE.GET_VEHICLE_EXTRA_COLOURS(vehicle, colorR, colorG)
    VEHICLE.SET_VEHICLE_EXTRA_COLOURS(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG))
    VEHICLE.GET_VEHICLE_EXTRA_COLOUR_5(vehicle, colorR) -- interior
    VEHICLE.GET_VEHICLE_EXTRA_COLOUR_6(vehicle, colorG)
    VEHICLE.SET_VEHICLE_EXTRA_COLOUR_5(cloneVehicle, memory.read_ubyte(colorR)) -- dashboard
    VEHICLE.SET_VEHICLE_EXTRA_COLOUR_6(cloneVehicle, memory.read_ubyte(colorG)) -- interior
    VEHICLE.GET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, colorR, colorG, colorB)
    VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG), memory.read_ubyte(colorB))
    VEHICLE.GET_VEHICLE_NEON_COLOUR(vehicle, colorR, colorG, colorB)
    VEHICLE.SET_VEHICLE_NEON_COLOUR(cloneVehicle, memory.read_ubyte(colorR), memory.read_ubyte(colorG), memory.read_ubyte(colorB))
    for i = 0, 3 do
        VEHICLE.SET_VEHICLE_NEON_ENABLED(cloneVehicle, i, VEHICLE.GET_VEHICLE_NEON_ENABLED(vehicle, i))
    end
    local windowTint<const> = VEHICLE.GET_VEHICLE_WINDOW_TINT(vehicle)
    VEHICLE.SET_VEHICLE_WINDOW_TINT(cloneVehicle, windowTint)
    local lightsColor<const> = VEHICLE.GET_VEHICLE_XENON_LIGHT_COLOR_INDEX(vehicle)
    VEHICLE.SET_VEHICLE_XENON_LIGHT_COLOR_INDEX(cloneVehicle, lightsColor)
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(cloneVehicle, VEHICLE.GET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle))
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(cloneVehicle, VEHICLE.GET_VEHICLE_NUMBER_PLATE_TEXT(vehicle))
    VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(cloneVehicle, VEHICLE.GET_VEHICLE_TYRES_CAN_BURST(vehicle))
    VEHICLE.SET_VEHICLE_DIRT_LEVEL(cloneVehicle, VEHICLE.GET_VEHICLE_DIRT_LEVEL(vehicle))
    for i = 1, 14 do
        VEHICLE.SET_VEHICLE_EXTRA(cloneVehicle, i, not VEHICLE.IS_VEHICLE_EXTRA_TURNED_ON(vehicle, i))
    end
    local roofState<const> = VEHICLE.GET_CONVERTIBLE_ROOF_STATE(vehicle)
    if roofState == 1 or roofState == 2 then
        VEHICLE.LOWER_CONVERTIBLE_ROOF(cloneVehicle, true)
    end
    VEHICLE.SET_VEHICLE_ENGINE_ON(cloneVehicle, VEHICLE.GET_IS_VEHICLE_ENGINE_RUNNING(vehicle), true, true)
end
function Invalid_vehicle_crashes(pid)
    local pCoords<const> = players.get_position(pid)
    local trafficLights = {}
    util.request_model(-655644382) -- traffic lights
    for i = 1, 20 do
        local object<const> = entities.create_object(-655644382, v3.new(pCoords.x + math.random(-5, 5), pCoords.y + math.random(-5, 5), pCoords.z + math.random(-1, 0)))
        ENTITY.SET_ENTITY_ROTATION(object, 0, 0, math.random(0, 360), 1, true)
        trafficLights[#trafficLights + 1] = object
    end
    local stopLights = false
    util.create_tick_handler(function()
        if stopLights then
            return false
        end
        ENTITY.SET_ENTITY_TRAFFICLIGHT_OVERRIDE(trafficLights[math.random(1, #trafficLights)], math.random(0, 3))
    end)
    util.request_model(3253274834) -- buffalo
    local vehicles = {}
    local crashVehicle<const> = entities.create_vehicle(3253274834, pCoords, 0)
    vehicles[#vehicles + 1] = crashVehicle
    VEHICLE.SET_VEHICLE_MOD_KIT(crashVehicle, 0)
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(crashVehicle, "ICRASHU")
    VEHICLE.SET_VEHICLE_MOD(crashVehicle, 34, 3)
    for i = 1, 10 do
        vehicles[#vehicles + 1] = clone(crashVehicle)
    end
    util.yield(500)
    for i = 1, #vehicles do
        entities.delete_by_handle(vehicles[i])
    end
    util.yield(500)
    stopLights = true
    util.yield(500)
    for i = 1, #trafficLights do
        entities.delete_by_handle(trafficLights[i])
    end
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(3253274834)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(-655644382)
end



-----无效降落伞崩溃
TTPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
TTPos = ENTITY.GET_ENTITY_COORDS(TTPed, true)
function rotatePoint(x, y, center, degrees)
    local radians = math.rad(degrees)
    local new_x = (x - center.x) * math.cos(radians) - (y - center.y) * math.sin(radians)
    local new_y = (x - center.x) * math.sin(radians) + (y - center.y) * math.cos(radians)
    return center.x + new_x, center.y + new_y * 1920 / 1080
end
function Invalid_parachute()
    local SelfPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
    local PreviousPlayerPos = ENTITY.GET_ENTITY_COORDS(SelfPlayerPed, true)
    local user = players.user()
    local user_ped = players.user_ped()
    local pos = players.get_position(user)
    local spped = PLAYER.PLAYER_PED_ID()
    local ppos = ENTITY.GET_ENTITY_COORDS(spped, true)
    for i = 1, 5 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 200, false, true, true)
        util.yield(100)
        VEHICLE1._SET_VEHICLE_PARACHUTE_MODEL(Ruiner2, 	3235319999)
        VEHICLE1._SET_VEHICLE_PARACHUTE_ACTIVE(Ruiner2, true)
        util.yield(100)
        entities.delete_by_handle(Ruiner2)
    end
    for i = 1, 10 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 2000, false, true, true)
        util.yield(120)
        VEHICLE1._SET_VEHICLE_PARACHUTE_MODEL(Ruiner2, 	260873931)
        VEHICLE1._SET_VEHICLE_PARACHUTE_ACTIVE(Ruiner2, true)
        util.yield(120)
        entities.delete_by_handle(Ruiner2)
    end
    for i = 1, 10 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 1000, false, true, true)
        util.yield(100)
        VEHICLE1._SET_VEHICLE_PARACHUTE_MODEL(Ruiner2, 	546252211)
        VEHICLE1._SET_VEHICLE_PARACHUTE_ACTIVE(Ruiner2, true)
        util.yield(100)
        entities.delete_by_handle(Ruiner2)
    end
    for i = 1, 8 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 800, false, true, true)
        util.yield(200)
        VEHICLE1._SET_VEHICLE_PARACHUTE_MODEL(Ruiner2, 	148511758)
        VEHICLE1._SET_VEHICLE_PARACHUTE_ACTIVE(Ruiner2, true)
        util.yield(200)
        entities.delete_by_handle(Ruiner2)
    end
    for i = 1, 10 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 500, false, true, true)
        util.yield(100)
        VEHICLE1._SET_VEHICLE_PARACHUTE_MODEL(Ruiner2, 	260873931)
        VEHICLE1._SET_VEHICLE_PARACHUTE_ACTIVE(Ruiner2, true)
        util.yield(100)
        entities.delete_by_handle(Ruiner2)
    end
    util.yield(200)
    for i = 1, 5 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 300, false, true, true)
        util.yield(500)
        VEHICLE1._SET_VEHICLE_PARACHUTE_MODEL(Ruiner2, 1381105889)
        VEHICLE1._SET_VEHICLE_PARACHUTE_ACTIVE(Ruiner2, true)
        util.yield(500)
        entities.delete_by_handle(Ruiner2)
    end
    for i = 1, 25 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 200, false, true, true)
        util.yield(150)
        VEHICLE1._SET_VEHICLE_PARACHUTE_MODEL(Ruiner2, 	1500925016)
        VEHICLE1._SET_VEHICLE_PARACHUTE_ACTIVE(Ruiner2, true)
        util.yield(150)
        entities.delete_by_handle(Ruiner2)
    end
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(spped, ppos.x, ppos.y, ppos.z, false, true, true)
    for n = 0 , 2 do
        local object_hash = util.joaat("prop_logpile_06b")
        STREAMING.REQUEST_MODEL(object_hash)
          while not STREAMING.HAS_MODEL_LOADED(object_hash) do
           util.yield()
        end
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, 0,0,100, false, true, true)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(SelfPlayerPed, 0xFBAB5776, 100, false)
        util.yield(800)
        for i = 0 , 1 do
            PED.FORCE_PED_TO_OPEN_PARACHUTE(SelfPlayerPed)
        end
        util.yield(800)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)

        local object_hash2 = util.joaat("prop_beach_parasol_03")
        STREAMING.REQUEST_MODEL(object_hash2)
          while not STREAMING.HAS_MODEL_LOADED(object_hash2) do
           util.yield()
        end
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash2)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, 0,0,100, 0, 0, 1)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(SelfPlayerPed, 0xFBAB5776, 100, false)
        util.yield(800)
        for i = 0 , 1 do
            PED.FORCE_PED_TO_OPEN_PARACHUTE(SelfPlayerPed)
        end
        util.yield(800)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)
    end
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)
    PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(players.user(), 0xFBF7D21F)
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user_ped, 0xFBAB5776, 100, false)
    TASK.TASK_PARACHUTE_TO_TARGET(user_ped, pos.x, pos.y, pos.z)
    util.yield()
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(user_ped)
    util.yield(300)
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user_ped, 0xFBAB5776, 100, false)
    PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
    util.yield(1000)
    for i = 1, 10 do
        util.spoof_script("freemode", SYSTEM.WAIT)
    end
    ENTITY.SET_ENTITY_HEALTH(user_ped, 0)
    NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(pos.x,pos.y,pos.z, 0, false, false, 0)
    for i = 1, 2 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 150, false, true, true)
        util.yield(200)
        VEHICLE1._SET_VEHICLE_PARACHUTE_MODEL(Ruiner2, 	1500925016)
        VEHICLE1._SET_VEHICLE_PARACHUTE_ACTIVE(Ruiner2, true)
        util.yield(200)
        entities.delete_by_handle(Ruiner2)
    end
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(spped, ppos.x, ppos.y, ppos.z, false, true, true)
    for i = 1, 2 do
    PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(players.user(), 0xFBF7D21F)
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user_ped, 0xFBAB5776, 100, false)
    TASK.TASK_PARACHUTE_TO_TARGET(user_ped, pos.x, pos.y, pos.z)
    util.yield()
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(user_ped)
    util.yield(200)
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user_ped, 0xFBAB5776, 100, false)
    PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
    util.yield(4500)
    for i = 1, 2 do
        util.spoof_script("freemode", SYSTEM.WAIT)
    end
    ENTITY.SET_ENTITY_HEALTH(user_ped, 0)
    NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(pos.x,pos.y,pos.z, 0, false, false, 0)
    end
end


-----踢出室内
function Kick_room(pid)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
    local glitch_hash = util.joaat("p_spinning_anus_s")
    local poopy_butt = util.joaat("brickade2")
    request_model(glitch_hash)
    request_model(poopy_butt)
    for i = 1, 5 do
        local stupid_object = entities.create_object(glitch_hash, pos)
        local glitch_vehicle = entities.create_vehicle(poopy_butt, pos, 0)
        ENTITY.SET_ENTITY_VISIBLE(stupid_object, false)
        ENTITY.SET_ENTITY_VISIBLE(glitch_vehicle, false)
        ENTITY.SET_ENTITY_INVINCIBLE(glitch_vehicle, true)
        ENTITY.SET_ENTITY_COLLISION(stupid_object, true, true)
        ENTITY.APPLY_FORCE_TO_ENTITY(glitch_vehicle, 1, 0.0, 10, 10, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        util.yield(500)
        entities.delete_by_handle(stupid_object)
        entities.delete_by_handle(glitch_vehicle)
        util.yield(500)     
    end
end

-----核弹
function nuclear_bomb_player(pid)
    local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
    local Object_pizza1 = CreateVehicle(1131912276,TargetPlayerPos,0)
    local Object_pizza2 =CreateObject(253279588,TargetPlayerPos)
        TargetPlayerPos.y = TargetPlayerPos.y + 2
        TargetPlayerPos.z = TargetPlayerPos.z + 70 
        ENTITY.SET_ENTITY_ALPHA(Object_pizza1, 255)
        ENTITY.SET_ENTITY_VISIBLE(Object_pizza1, false, 0)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza1, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(Object_pizza2,Object_pizza1, 0,  0.0, 0.00, 0.00, 1.0, 1.0,1, true, false, true, false, 0, true)
    util.yield(5000)
    do
        orbital(pid)
        entities.delete_by_handle(Object_pizza1)
        entities.delete_by_handle(Object_pizza2)
    end
end


-----鬼畜玩家
function RequestModel(hash, timeout)
    timeout = timeout or 3
    STREAMING.REQUEST_MODEL(hash)
    local end_time = os.time() + timeout
    repeat
        util.yield()
    until STREAMING.HAS_MODEL_LOADED(hash) or os.time() >= end_time
    return STREAMING.HAS_MODEL_LOADED(hash)
end
local object_hash = util.joaat("prop_ld_ferris_wheel")
function obj_creat(index)
    object_hash = util.joaat(object_stuff.objects[index])
end
local delay = 150
function obj_creat_speed(amount)
    delay = amount
end
function Ghost_Beast_Player(pid)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = players.get_position(pid)
    local glitch_hash = object_hash
    local mdl = util.joaat("rallytruck")
        RequestModel(glitch_hash)
        RequestModel(mdl)
    local obj = entities.create_object(glitch_hash, pos)
    local veh = entities.create_vehicle(mdl, pos, 0)
    ENTITY.SET_ENTITY_VISIBLE(obj, false)
    ENTITY.SET_ENTITY_VISIBLE(veh, false)
    ENTITY.SET_ENTITY_INVINCIBLE(obj, true)
    ENTITY.SET_ENTITY_COLLISION(obj, true, true)
    ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, 10.0, 10.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
    util.yield(delay)
    entities.delete_by_handle(obj)
    entities.delete_by_handle(veh)
end

-----死亡屏障击杀
function Death_barrier(pid)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = players.get_position(pid)                            
    local hash = util.joaat("prop_windmill_01")
    local mdl = util.joaat("rallytruck")
    RequestModel(hash)
    RequestModel(mdl)
    for i = 0, 5 do
        if TASK.IS_PED_WALKING(ped) then
            spawn_pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 0.5, 0.0)
        elseif TASK.IS_PED_WALKING(ped) then
            spawn_pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 1.3, 0.0)
        else
            spawn_pos = players.get_position(pid)
        end
        local obj = entities.create_object(hash, spawn_pos)
        local veh = entities.create_vehicle(mdl, spawn_pos, 0)
        ENTITY.SET_ENTITY_VISIBLE(obj, false)
        ENTITY.SET_ENTITY_VISIBLE(veh, false)
        ENTITY.SET_ENTITY_INVINCIBLE(obj, true)
        ENTITY.SET_ENTITY_COLLISION(obj, true, true)
        ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, 10, 10, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        util.yield(150)
        entities.delete_by_handle(obj)
        entities.delete_by_handle(veh)
    end
end

-----强制击杀
function Force_kill(index, veh, pid)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(ped)
    local vehicle = util.joaat(veh)
    request_model(vehicle)
    switch veh do
        case "Khanjali":
        height = 2.8
        offset = 0
        break
        case "APC":
        height = 3.4
        offset = -1.5
        break
end
    if TASK.IS_PED_STILL(ped) then
        distance = 0
    elseif not TASK.IS_PED_STILL(ped) then
        distance = 3
end
    local vehicle1 = entities.create_vehicle(vehicle, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, offset, distance, height), ENTITY.GET_ENTITY_HEADING(ped))
    local vehicle2 = entities.create_vehicle(vehicle, pos, 0)
    local vehicle3 = entities.create_vehicle(vehicle, pos, 0)
    local vehicle4 = entities.create_vehicle(vehicle, pos, 0)
    local spawned_vehs = {vehicle4, vehicle3, vehicle2, vehicle1}
    ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle2, vehicle1, 0, 0, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle3, vehicle1, 0, 3, 3, 0, 0, 0, -180, 0, false, true, false, 0, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle4, vehicle1, 0, 3, 0, 0, 0, 0, 0, 0, false, true, false, 0, true)
    ENTITY.SET_ENTITY_VISIBLE(vehicle1, false)
    util.yield(5000)
    for i = 1, #spawned_vehs do
        entities.delete_by_handle(spawned_vehs[i])
    end
end



----大烟花
function big_fireworks()
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
    local hash = util.joaat("weapon_firework")
    request_weapon_asset(hash)
    WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), hash, 120, true, false)

    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-70, pos.y-90, pos.z, pos.x-70, pos.y-90, pos.z+20, 200, false, hash, 0, true, false, 150)
    util.yield(500)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-90, pos.y-90, pos.z, pos.x-90, pos.y-90, pos.z+20, 200, false, hash, 0, true, false, 150)
    util.yield(500)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-60, pos.y-90, pos.z, pos.x-60, pos.y-90, pos.z+20, 200, false, hash, 0, true, false, 150)
    util.yield(500)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-80, pos.y-90, pos.z, pos.x-80, pos.y-90, pos.z+20, 200, false, hash, 0, true, false, 150)
    util.yield(500)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x-50, pos.y-90, pos.z, pos.x-50, pos.y-90, pos.z+20, 200, false, hash, 0, true, false, 150)
    util.yield(500)
end

------愤怒的飞机
numPlanes = 0
lastSpawn = newTimer()
function Angry_plane()
    if numPlanes < 15 and lastSpawn.elapsed() > 300 then
        local pedHash <const> = util.joaat("s_m_y_blackops_01")
        local planeModel <const> = planes[math.random(#planes)]
        local planeHash <const> = util.joaat(planeModel)
        request_model(planeHash); request_model(pedHash)
        local pos = players.get_position(players.user())
        local plane = VEHICLE.CREATE_VEHICLE(planeHash, pos.x, pos.y, pos.z, CAM.GET_GAMEPLAY_CAM_ROT(0).z, true, false, false)
        set_decor_flag(plane, DecorFlag_isAngryPlane)
        if ENTITY.DOES_ENTITY_EXIST(plane) then
            NETWORK.SET_NETWORK_ID_CAN_MIGRATE(NETWORK.VEH_TO_NET(plane), false)
            local pilot = entities.create_ped(26, pedHash, pos, 0)
            PED.SET_PED_INTO_VEHICLE(pilot, plane, -1)
            pos = get_random_offset_from_entity(players.user_ped(), 50.0, 150.0)
            pos.z = pos.z + 75.0
            ENTITY.SET_ENTITY_COORDS(plane, pos.x, pos.y, pos.z, false, false, false, false)
            local theta = random_float(0, 2 * math.pi)
            ENTITY.SET_ENTITY_HEADING(plane, math.deg(theta))
            VEHICLE.SET_VEHICLE_FORWARD_SPEED(plane, 60.0)
            VEHICLE.SET_HELI_BLADES_FULL_SPEED(plane)
            VEHICLE.CONTROL_LANDING_GEAR(plane, 3)
            VEHICLE.SET_VEHICLE_FORCE_AFTERBURNER(plane, true)
            TASK.TASK_PLANE_MISSION(pilot, plane, 0, players.user_ped(), 0.0, 0.0, 0.0, 6, 100.0, 0.0, 0.0, 80.0, 50.0, false)
            numPlanes = numPlanes + 1
            lastSpawn.reset()
        end
    end
end
function clear_Angry_plane()
    for _, vehicle in ipairs(entities.get_all_vehicles_as_handles()) do
        entities.delete_by_handle(VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1, false))
        entities.delete_by_handle(vehicle)
        numPlanes = numPlanes - 1
    end
end

-----绘制血量条
drawoptions = {
    {"玩家"},
    {"行人"},
    {"玩家和行人"},
    {"主动瞄准时"},
}
ttselectedOpt = 1
selfaimedPed = 0
function PedHealthBarmainLoop()
    if ttselectedOpt == 4 then
        if not PLAYER.IS_PLAYER_FREE_AIMING(players.user()) then
            selfaimedPed = 0 return
        end
        local pEntity <const> = memory.alloc_int()
        if PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(players.user(), pEntity) then
            local entity = memory.read_int(pEntity)
            if ENTITY.IS_ENTITY_A_PED(entity) then selfaimedPed = entity end
        end
        draw_health_bar(selfaimedPed, 1000.0)
    else
        for _, ped in ipairs(get_peds_in_player_range(players.user(), 500.0)) do
            if not ENTITY.IS_ENTITY_ON_SCREEN(ped) or
            not ENTITY.HAS_ENTITY_CLEAR_LOS_TO_ENTITY(players.user_ped(), ped, TraceFlag.world) then
                goto LABEL_CONTINUE
            end
            if (ttselectedOpt == 1 and not PED.IS_PED_A_PLAYER(ped)) or
            (PED.IS_PED_A_PLAYER(ped) and ttselectedOpt == 2) then
                goto LABEL_CONTINUE
            end
            draw_health_bar(ped, 350.0)
        ::LABEL_CONTINUE::
        end
    end
end

------弹吉他
function Play_guitar(on)
    while not STREAMING.HAS_ANIM_DICT_LOADED("amb@world_human_musician@guitar@male@idle_a") do 
        STREAMING.REQUEST_ANIM_DICT("amb@world_human_musician@guitar@male@idle_a")
        util.yield()
    end
    if on then
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(),true)
    guitar = OBJECT.CREATE_OBJECT(util.joaat("prop_acc_guitar_01"), pos.x, pos.y, pos.z, true, true, false)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(players.user_ped())
    TASK.TASK_PLAY_ANIM(players.user_ped(), "amb@world_human_musician@guitar@male@idle_a", "idle_b", 3, 3, -1, 51, 0, false, false, false) --play anim 
    ENTITY.ATTACH_ENTITY_TO_ENTITY(guitar, players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), 24818), -0.1,0.31,0.1,0.0,20.0,150.0, false, true, false, true, 1, true)
    PED.SET_ENABLE_HANDCUFFS(players.user_ped(),on)
    else
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
        PED.SET_ENABLE_HANDCUFFS(players.user_ped(),off)
        entities.delete_by_handle(guitar)
    end
end
-----掌旋球
function Palm_spin_ball(on)
    while not STREAMING.HAS_ANIM_DICT_LOADED("anim@mp_player_intincarfreakoutstd@ps@") do 
        STREAMING.REQUEST_ANIM_DICT("anim@mp_player_intincarfreakoutstd@ps@")
        util.yield()
    end
    if on then
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(),true)
    guitar = OBJECT.CREATE_OBJECT(util.joaat("prop_bowling_ball"), pos.x, pos.y, pos.z, true, true, false)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(players.user_ped())
    TASK.TASK_PLAY_ANIM(players.user_ped(), "anim@mp_player_intincarfreakoutstd@ps@", "idle_a_fp", 10, 3, -1, 51, 5, false, false, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(guitar, players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), 24818), 0.30,0.53,0,0.2,70,340, false, true, false, true, 1, true)
    PED.SET_ENABLE_HANDCUFFS(players.user_ped(),on)
    else
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
        PED.SET_ENABLE_HANDCUFFS(players.user_ped(),off)
        entities.delete_by_handle(guitar)
    end
end
-----求助
function seek_help(on)
    while not STREAMING.HAS_ANIM_DICT_LOADED("amb@world_human_bum_freeway@male@base") do 
        STREAMING.REQUEST_ANIM_DICT("amb@world_human_bum_freeway@male@base")
        util.yield()
    end
    if on then
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(),true)
    beggers = OBJECT.CREATE_OBJECT(util.joaat("prop_beggers_sign_03"), pos.x, pos.y, pos.z, true, true, false)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(players.user_ped())
    TASK.TASK_PLAY_ANIM(players.user_ped(), "amb@world_human_bum_freeway@male@base", "base", 3, 3, -1, 51, 0, false, false, false) --play anim 
    ENTITY.ATTACH_ENTITY_TO_ENTITY(beggers, players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), 58868), 0.19,0.18,0.0,5.0,0.0,40.0, false, true, false, true, 1, true)
    PED.SET_ENABLE_HANDCUFFS(players.user_ped(),on)
    else
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
        PED.SET_ENABLE_HANDCUFFS(players.user_ped(),off)
        entities.delete_by_handle(beggers)
    end
end
-----献花
function offer_flower(on)
    while not STREAMING.HAS_ANIM_DICT_LOADED("anim@heists@humane_labs@finale@keycards") do 
        STREAMING.REQUEST_ANIM_DICT("anim@heists@humane_labs@finale@keycards")
        util.yield()
    end
    if on then
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(),true)
    rose = OBJECT.CREATE_OBJECT(util.joaat("prop_single_rose"), pos.x, pos.y, pos.z, true, true, false)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(players.user_ped())
    TASK.TASK_PLAY_ANIM(players.user_ped(), "anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", 3, 3, -1, 51, 0, false, false, false) --play anim 
    ENTITY.ATTACH_ENTITY_TO_ENTITY(rose, players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), 18905), 0.13,0.15,0.0,-100.0,0.0,-20.0, false, true, false, true, 1, true)
    PED.SET_ENABLE_HANDCUFFS(players.user_ped(),on)
    else
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
        PED.SET_ENABLE_HANDCUFFS(players.user_ped(),off)
        entities.delete_by_handle(rose)
    end
end



vehicle_uses = 0
ped_uses = 0
pickup_uses = 0
player_uses = 0
object_uses = 0
robustmode = false
function mod_uses(type, incr)
    if incr < 0 and is_loading then
        --"不增加使用类型的 var " .. type .. " by " .. incr .. "- script is loading"
        return
    end
    --"递增使用 var 类型 " .. type .. " by " .. incr
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
-----灵魂出窍
function Out_body(toggle)
    if toggle then
        all_peds = entities.get_all_peds_as_handles()
        user_ped = players.user_ped()
        clone = PED.CLONE_PED(user_ped,true, true, true)
        pos = ENTITY.GET_ENTITY_COORDS(clone, false)
        ENTITY.SET_ENTITY_COORDS(user_ped, pos.x-2, pos.y, pos.z)
        ENTITY.SET_ENTITY_ALPHA(players.user_ped(), 87, false)
        ENTITY.SET_ENTITY_INVINCIBLE(clone,true)
        menu.trigger_commands("invisibility remote")
        util.create_tick_handler(function()
        STREAMING.REQUEST_ANIM_DICT("move_crawl")
        PED.SET_PED_MOVEMENT_CLIPSET(clone, "move_crawl", -1)
        mod_uses("ped", if on then 1 else -1)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(clone, true)
        TASK.TASK_SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(clone, true)
        return ghost
        end)
        else
            clonepedpos = ENTITY.GET_ENTITY_COORDS(clone, false)
            ENTITY.SET_ENTITY_COORDS(user_ped, clonepedpos.x,clonepedpos.y,clonepedpos.z, false, false)
            entities.delete_by_handle(clone)
            ENTITY.SET_ENTITY_ALPHA(user_ped, 255, false)
            menu.trigger_commands("invisibility off")
        end
end


-----附加国旗
function first_to_upper(str)
    return (str:gsub("^%l", string.upper))
end
for _, flag in pairs(country_flags) do 
    table.insert(flags_fmt, first_to_upper(flag:gsub('apa_prop_flag_', ''):gsub('_yt', '')))
end


-----homer粒子
suijijianqi = function(x)
    local r = math.random(1,5)
    return x[r]
end

------崩溃,踢出,转魂
ent_types = {"没有", "行人", "载具", "实体"}
function get_aim_info()
    local outptr = memory.alloc(4)
    local success = PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(players.user(), outptr)
    local info = {}
    if success then
        local ent = memory.read_int(outptr)
        if not ENTITY.DOES_ENTITY_EXIST(ent) then
            info["ent"] = 0
        else
            info["ent"] = ent
        end
        if ENTITY.GET_ENTITY_TYPE(ent) == 1 then
            local veh = PED.GET_VEHICLE_PED_IS_IN(ent, false)
            if veh ~= 0 then
                if VEHICLE.GET_PED_IN_VEHICLE_SEAT(veh, -1) then
                    ent = veh
                    info['ent'] = ent
                end
            end
        end
        info["hash"] = ENTITY.GET_ENTITY_MODEL(ent)
        info["health"] = ENTITY.GET_ENTITY_HEALTH(ent)
        info["type"] = ent_types[ENTITY.GET_ENTITY_TYPE(ent)+1]
        info["speed"] = math.floor(ENTITY.GET_ENTITY_SPEED(ent))
    else
        info['ent'] = 0
    end
    return info
end
---转魂
function Soul_Gun()
    local ent = get_aim_info()['ent']
    if PED.IS_PED_SHOOTING(players.user_ped()) then
        if ENTITY.IS_ENTITY_A_PED(ent) then
            pos = ENTITY.GET_ENTITY_COORDS(ent, false)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), pos.x, pos.y, pos.z, false, false, false)
            if PED.IS_PED_A_PLAYER(ent) then
                local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(ent)
                menu.trigger_commands("copyoutfit " .. players.get_name(pid))
            else
            local soul = ENTITY.GET_ENTITY_MODEL(ent)
            STREAMING.REQUEST_MODEL(soul)
            while(not STREAMING.HAS_MODEL_LOADED(soul))
            do
            util.yield(10)
                end
            PLAYER.SET_PLAYER_MODEL(players.user(),soul)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(soul)
            if not PED.IS_PED_A_PLAYER(ent) then
                entities.delete_by_handle(ent)
            end
            util.yield(10)
            menu.trigger_commands("allguns")
        end
    end
        if ENTITY.IS_ENTITY_A_VEHICLE(ent) then
            local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(ent, -1)
        if VEHICLE.GET_VEHICLE_NUMBER_OF_PASSENGERS(ent,true,false) >= 1 then
            local soulveh = ENTITY.GET_ENTITY_MODEL(driver)
            if not PED.IS_PED_A_PLAYER(driver) then
                entities.delete_by_handle(driver)
                end
                STREAMING.REQUEST_MODEL(soulveh)
                while(not STREAMING.HAS_MODEL_LOADED(soulveh))
                do
                util.yield(10)
                    end
            PLAYER.SET_PLAYER_MODEL(players.user(),soulveh)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(soulveh)
            util.yield(10)
            PED.SET_PED_INTO_VEHICLE(players.user_ped(), ent, -1)
            menu.trigger_commands("allguns")
            end
        end
    end
end

-----Blacklist
require "lib.daidailib.Config.blacklist"
function Black_list()
    for pid = 0, 31 do
        Blacklist_player = players.get_name(pid)
            for i = 1, #blacklistplayers do
                    if blacklistplayers[i] == Blacklist_player and Blacklist_player ~= players.get_name(players.get_host()) and Blacklist_player ~= players.get_name(players.user()) then
                        util.toast("检测到黑名单玩家: "..Blacklist_player.."\n已执行踢出")
                        menu.trigger_commands("breakup " .. Blacklist_player)
                    end
            end
    end
end
function Black_self()
    Blacklist_self = players.get_name(players.user())
    for i = 0, #blacklistplayers do
        if blacklistplayers[i] == Blacklist_self then
            os.exit() 
        end
    end
end


-----实体枪2
local impactCords = v3.new()
local blocks = {}
function xxxminecraftgun()
    if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(players.user_ped(), impactCords) then
        local hash = util.joaat('prop_mb_sandblock_01')
        loadModel(hash)
        blocks[#blocks + 1] = entities.create_object(hash, impactCords)
    end
end


-----在线玩家
playerslist = {}
function join_blacklist2(pid)
    local selected_blacklist_path = filesystem.scripts_dir() .. 'lib/daidailib/Config/blacklist.lua'
    local black_txt = players.get_name(pid)
--删除文本最后一行
    local file = io.open(selected_blacklist_path, "r+")
    local content = file:read("*all")
    local t = string.gmatch(content, "([^\n]+)[\n]*$")()
    local content_len = string.len(content)
    local t_len = string.len(t)
    file:close()
    local str = string.sub(content, 0, content_len-t_len-1)
    file = io.open(selected_blacklist_path, 'w')
    file:write(str)
    file:close()
--添加内容
    file = io.open(selected_blacklist_path, 'a')
    file:write(',\n    "'..black_txt..'"')
    file:write("\n}")
    file:close()
end
function join_blacklist(pid)
    local result = 0
    local blackplayer = players.get_name(pid)
        for i = 1, #blacklistplayers do
            if blacklistplayers[i] == blackplayer then
                util.toast("玩家已存在")
                result = 1
            end
        end
    if result ~= 1 and blackplayer ~= "UndiscoveredPlayer" then
        util.toast("添加成功")
        join_blacklist2(pid)
        table.insert(blacklistplayers, players.get_name(pid))
    end
end

function player_list(pid)
    if NETWORK.NETWORK_IS_SESSION_ACTIVE()then 
        playerslist[pid] = menu.list(players_list, players.get_name_with_tags(pid), {}, "")
    end
    if playerslist[pid] then
        menu.divider(playerslist[pid],"玩家信息")
        menu.readonly(playerslist[pid], "玩家昵称: ", players.get_name(pid))
        menu.readonly(playerslist[pid], "玩家rid: ", players.get_rockstar_id(pid))
        menu.readonly(playerslist[pid], "玩家金钱: ", players.get_money(pid))
        menu.readonly(playerslist[pid], "玩家kd: ", string.format("%.2f", players.get_kd(pid)))
        menu.divider(playerslist[pid],"其他选项")
        menu.action(playerslist[pid],"踢出玩家",{},"",function()
            menu.trigger_commands("breakup " .. players.get_name(pid))
        end)
        menu.action(playerslist[pid],"加入黑名单",{},"",function()
            join_blacklist(pid)
        end)
    else
        menu.divider(players_list,"不可用")
    end
end
function handle_player_list(pid)
    local ref = playerslist[pid]
    if not players.exists(pid) then
        if ref then
            menu.delete(ref)
            playerslist[pid] = nil
        end
    end
end




----允许当前车辆进入车库
function BitTest(value, bit)
    return value & (1 << bit) ~= 0
end
function BitSet(value, bit)
    return value | (1 << bit)
end
function BitClear(value, bit)
    return value & ~(1 << bit)
end
function carinto()
    local ped = players.user_ped()
    local hash = NETWORK.NETWORK_HASH_FROM_PLAYER_HANDLE(players.user())
    if PED.IS_PED_IN_ANY_VEHICLE(ped) then
        local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false)
        local start = os.time() + 15
        if veh ~= 0 then
            local spawned_model = util.reverse_joaat(ENTITY.GET_ENTITY_MODEL(veh))
            if hash ~= 0 then
                memory.write_int(memory.script_global(78558), 0)
                local bitset = DECORATOR.DECOR_GET_INT(veh, "MPBitset")
                bitset = BitClear(bitset, 3)
                bitset = BitSet(bitset, 24)
                DECORATOR.DECOR_SET_INT(veh, "MPBitset", bitset)
                DECORATOR.DECOR_SET_INT(veh, "Previous_Owner", 0)
                DECORATOR.DECOR_SET_INT(veh, "PV_Slot", 0)
                DECORATOR.DECOR_SET_INT(veh, "Player_Vehicle", hash)
                DECORATOR.DECOR_SET_INT(veh, "Veh_Modded_By_Player", hash)
                local interior = INTERIOR.GET_INTERIOR_FROM_ENTITY(ped)
                local pos = ENTITY.GET_ENTITY_COORDS(ped, true)
                util.toast("完成")
                
                while interior == 0 do
                    interior = INTERIOR.GET_INTERIOR_FROM_ENTITY(ped)
                    util.yield_once()
                end
                memory.write_int(memory.script_global(78558), 1)
                while interior ~= 0 do
                    interior = INTERIOR.GET_INTERIOR_FROM_ENTITY(ped)
                    util.yield_once()
                end
                for i, veh in pairs(entities.get_all_vehicles_as_handles()) do
                    local model = util.reverse_joaat(ENTITY.GET_ENTITY_MODEL(veh))
                    if model:find(spawned_model) then
                        local veh_pos = ENTITY.GET_ENTITY_COORDS(veh, true)
                        if MISC.GET_DISTANCE_BETWEEN_COORDS(pos.x, pos.y, pos.z, veh_pos.x, veh_pos.y, veh_pos.z, true) < 5.0 then
                            entities.delete_by_handle(veh)
                            break
                        end
                    end
                end
            end
        end
    else
        util.toast("你还没进载具呢")
    end
end


-----UFO勇闯洛城
local ufo = util.joaat("sum_prop_dufocore_01a")
local dufo = util.joaat("imp_prop_ship_01a")
function UFO_Los_Angeles(toggle)
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    local r = ufonum[math.random(#ufonum)]
    c.x = math.random(0.0,1.0) >= 0.5 and c.x + r + 5 or c.x - r - 5 --set x coords
    c.y = math.random(0.0,1.0) >= 0.5 and c.y + r + 5 or c.y - r - 5 --set y coords
    c.z = c.z + r + 8 --set z coords
    STREAMING.REQUEST_MODEL(ufo)
    while not STREAMING.HAS_MODEL_LOADED(ufo) do
        STREAMING.REQUEST_MODEL(ufo)
        util.yield()
    end
    util.yield(2500)
    local spawnedufo = entities.create_object(ufo, c) --spawn ufo
    util.yield(500)
    local ufoc = ENTITY.GET_ENTITY_COORDS(spawnedufo) --get ufo pos
    local success, floorcoords
    repeat
        success, floorcoords = util.get_ground_z(ufoc.x, ufoc.y) --get floor pos
        util.yield()
    until success
    FIRE.ADD_EXPLOSION(ufoc.x, ufoc.y, floorcoords, exp, 100.0, true, false, 1.0, false) --explode at floor
    util.yield(1500)
    entities.delete_by_handle(spawnedufo) --delete ufo

    if not STREAMING.HAS_MODEL_LOADED(ufo) then
        util.toast("无法加载模型")
    end
end


-----攻击嘲讽作者
author = "\n--------¦daidai"
-----作者
F = "Author-呆呆"

------音乐
function music(on)
	if on then
        menu.trigger_commands("ipod on")
        AUDIO.SET_RADIO_TO_STATION_NAME("RADIO_19_USER")
----AUDIO.SET_RADIO_TO_STATION_NAME(AUDIO.GET_RADIO_STATION_NAME("16"))
        menu.trigger_commands("closeradio off")
        util.yield(500)
		menu.trigger_commands("lockradio on")
    else
        menu.trigger_commands("ipod off")
        AUDIO.SET_RADIO_TO_STATION_NAME("OFF")
		menu.trigger_commands("lockradio off")
    end
end

----爆炸圈
local explosion_circle_angle = 0
function explosion_circle(ped, angle, radius)
    local ped_coords = ENTITY.GET_ENTITY_COORDS(ped)

    local offset_x = ped_coords.x
    local offset_y = ped_coords.y

    local x = offset_x + radius * math.cos(angle)
    local y = offset_y + radius * math.sin(angle)

    FIRE.ADD_EXPLOSION(x, y, ped_coords.z, 4, 1, true, false, 0)
end



-----主机序列
function draw_string(s, x, y, scale, font)
	HUD.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("STRING")
	HUD.SET_TEXT_FONT(font or 0)
	HUD.SET_TEXT_SCALE(scale, scale)
	HUD.SET_TEXT_DROP_SHADOW()
	HUD.SET_TEXT_WRAP(0.0, 1.0)
	HUD.SET_TEXT_DROPSHADOW(1, 0, 0, 0, 0)
	HUD.SET_TEXT_OUTLINE()
	HUD.SET_TEXT_EDGE(1, 0, 0, 0, 0)
	HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(s)
	HUD.END_TEXT_COMMAND_DISPLAY_TEXT(x, y)
end
--fps帧数
local fpstoggle = 0
function fps(on)
    if on then
        if menu.get_value(host_sequence) == true then
            fpstoggle = 1
        else
            util.toast("请先开启主机序列")
            menu.set_value(numfps,false)
        end
    else
        fpstoggle = 0
    end
end

local fps = 0
util.create_thread(function()
    while true do
        fps = math.ceil(1/SYSTEM.TIMESTEP())
        util.yield(500)
    end
end)

local replayInterface = memory.read_long(memory.rip(memory.scan("48 8D 0D ? ? ? ? 48 8B D7 E8 ? ? ? ? 48 8D 0D ? ? ? ? 8A D8 E8 ? ? ? ? 84 DB 75 13 48 8D 0D") + 3))
local pedInterface = memory.read_long(replayInterface + 0x0018)
local vehInterface = memory.read_long(replayInterface + 0x0010)
local objectInterface = memory.read_long(replayInterface + 0x0028)
local pickupInterface = memory.read_long(replayInterface + 0x0020)

local zhujixvlie_posx = config_active1_x / 1000
local zhujixvlie_posy = config_active1_y / 1000
function zhujixvlie_x(x_)
    zhujixvlie_posx = x_ / 1000
end
function zhujixvlie_y(y_)
    zhujixvlie_posy = y_ / 1000
end
function zhujixvlie()
    --下位主机
    for pid = 0, 31 do
        nexthostxulie = players.get_host_queue_position(pid)
            if #players.list() > 1 then
                if nexthostxulie == 1 then
                    if players.get_name(pid) ~= "UndiscoveredPlayer" then
                        nexthost_name = players.get_name(pid)
                    end
                end
            else
                nexthost_name = "不可用"
            end
    end

    inviciamountint = 0
        for pid = 0, 31 do
            if players.exists(pid) and pid ~= players.user() then
                local pped = players.user_ped(pid)
                if pped ~= 0 then
                    if players.is_marked_as_modder(pid) then --is_marked_as_modder
                        inviciamountint = inviciamountint + 1
                    end
                end
            end
    local ente
            local ent1e = players.user_ped()
            local ent2e = PED.GET_VEHICLE_PED_IS_USING(players.user_ped())
                if PED.IS_PED_IN_ANY_VEHICLE(ent1e,true) then
                    ente = ent2e
                else
                    ente = ent1e
                end
            local speede = ENTITY.GET_ENTITY_SPEED(ente)
            local speedcalce = speede * 3.6
            myspeed1e = math.ceil(speedcalce)
        end
    inviciamountintt = inviciamountint

--~italic~ 斜体
--~bold~ 加粗
--~?~ color
    if fpstoggle == 1 then
        draw_string(string.format("~bold~~o~FPS: ~b~"..fps), zhujixvlie_posx, zhujixvlie_posy, 0.3,1)
    end

	draw_string(string.format("~bold~~b~"..myspeed1e.." ~g~KM/H"), zhujixvlie_posx,zhujixvlie_posy + 0.03, 0.3,1)-----速度
	draw_string(string.format("~bold~~y~"..os.date("%X")), zhujixvlie_posx, zhujixvlie_posy + 0.06, 0.3,1)    -----------------时间
	draw_string(string.format("~bold~战局人数: ~g~"..#players.list()), zhujixvlie_posx, zhujixvlie_posy + 0.09, 0.3,1) 
	draw_string(string.format("~bold~作弊人数: ~r~"..inviciamountintt), zhujixvlie_posx, zhujixvlie_posy + 0.12, 0.3,1)

    if PLAYER.GET_PLAYER_NAME(players.get_host()) == "**Invalid**" then
        draw_string(string.format("~bold~战局主机: ~y~不可用", ALIGN_TOP_LEFT), zhujixvlie_posx, zhujixvlie_posy + 0.15, 0.3,1)
    else
        draw_string(string.format("~bold~战局主机: ~y~"..players.get_name(players.get_host())), zhujixvlie_posx, zhujixvlie_posy + 0.15, 0.3,1)
    end

    if PLAYER.GET_PLAYER_NAME(players.get_script_host()) == "**Invalid**" then
        draw_string(string.format("~bold~脚本主机: ~b~不可用", ALIGN_TOP_LEFT), zhujixvlie_posx, zhujixvlie_posy + 0.18, 0.3,1) 
    else
        draw_string(string.format("~bold~脚本主机: ~b~"..players.get_name(players.get_script_host())), zhujixvlie_posx, zhujixvlie_posy + 0.18, 0.3,1)
    end

    draw_string(string.format("~bold~~g~下一位主机: ~p~"..nexthost_name), zhujixvlie_posx, zhujixvlie_posy + 0.21, 0.3,1) 

    local hostxvlie = players.get_host_queue_position(players.user())
        if hostxvlie == 0 then
            draw_string(string.format("~bold~~o~你现在是战局主机"), zhujixvlie_posx, zhujixvlie_posy + 0.24, 0.3,1) 
        else
            draw_string(string.format("~bold~~q~你的主机优先度:~q~ "..hostxvlie), zhujixvlie_posx, zhujixvlie_posy + 0.24, 0.3,1) 
        end

end




----实体池信息
function entityinfo()
draw_string(string.format("~h~~f~实体池Info~"..memory.read_int(pedInterface ).."/"..memory.read_int(pedInterface)), 0,0, 0.32,1)
            draw_string(string.format("~h~PED: ~g~"..memory.read_int(pedInterface + 0x0110).."/"..memory.read_int(pedInterface + 0x0108)), 0,0.03, 0.3,1)
            draw_string(string.format("~h~载具: ~y~"..memory.read_int(vehInterface + 0x0190).."/"..memory.read_int(vehInterface + 0x0188)), 0,0.06, 0.3,1)
            draw_string(string.format("~h~实体: ~r~"..memory.read_int(objectInterface + 0x0168).."/"..memory.read_int(objectInterface + 0x0160)), 0,0.09, 0.3,1)
            draw_string(string.format("~h~拾取物: ~q~ "..memory.read_int(pickupInterface + 0x0110).."/"..memory.read_int(pickupInterface + 0x0108)), 0,0.12, 0.3,1)
end


----脚本昵称
mcxh=1
mcr=255
mcg=0
mcb=0
function daidaijiaoben(state)
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
    draw_string(string.format("~italic~¦~bold~呆呆 Lua Script v7.8"), 0.38,0.1, 0.6,5)
    util.yield()
    end
end

----粉色独角兽
function daidaiunicorn(on)
    if on then
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15, false, true)
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
        dachui = OBJECT.CREATE_OBJECT(util.joaat("ba_prop_battle_cameradrone"), pos.x, pos.y, pos.z, true, true, false)
        ENTITY.SET_ENTITY_VISIBLE(dachui, false, 0)
        tongzi = OBJECT.CREATE_OBJECT(util.joaat("ba_prop_battle_hobby_horse"), pos.x, pos.y, pos.z, true, true, false)
        menu.trigger_commands("damagemultiplier 1000")
        menu.trigger_commands("rangemultiplier 1.5")
        ENTITY.ATTACH_ENTITY_TO_ENTITY(dachui, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.165, 0.9, 0.205, 105, 30, 1, true, true, false, false, 0, true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(tongzi,dachui, 0, 0, 0, 0.74, -1.9, 184, 233, true, true, false, false, 0, true)
        util.yield(1000)
    else
        menu.trigger_commands("damagemultiplier 1")
        menu.trigger_commands("rangemultiplier 1")
        entities.delete_by_handle(dachui)
        entities.delete_by_handle(tongzi)
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),-1810795771)
    end
end


----呆呆大锤
function daidaihammer(on)
    if on then
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
        dachui = OBJECT.CREATE_OBJECT(util.joaat("ba_prop_battle_cameradrone"), pos.x, pos.y, pos.z, true, true, false)
        tongzi = OBJECT.CREATE_OBJECT(util.joaat("prop_mr_raspberry_01"), pos.x, pos.y, pos.z, true, true, false)
        menu.trigger_commands("damagemultiplier 1000")
        menu.trigger_commands("rangemultiplier 1.5")
        ENTITY.ATTACH_ENTITY_TO_ENTITY(dachui, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.2, 0.95, 0.2, 105, 30.0, 0, true, true, false, false, 0, true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(tongzi,dachui, 0,  0, 0, 0.15, 0, 180,180, true, true, false, false, 0, true)
        util.yield(1000)
        bigbarrelqq = on
    else
        menu.trigger_commands("damagemultiplier 1")
        menu.trigger_commands("rangemultiplier 1")
        entities.delete_by_handle(dachui)
        entities.delete_by_handle(tongzi)
        bigbarrelqq = off
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),-1810795771)
    end
end

--baibai大锤
function baibaihammer(on)
    if on then
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
        dachui = OBJECT.CREATE_OBJECT(util.joaat("prop_glass_stack_03"), pos.x, pos.y, pos.z, true, true, false)--prop_gate_farm_post
        tongzi = OBJECT.CREATE_OBJECT(util.joaat("prop_barrel_pile_03"), pos.x, pos.y, pos.z, true, true, false)--h4_prop_h4_barrel_01a
        menu.trigger_commands("damagemultiplier 1000")
        menu.trigger_commands("rangemultiplier 1.5")
        ENTITY.ATTACH_ENTITY_TO_ENTITY(dachui, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.2, 0.95, 0.2, 105, 30.0, 0, true, true, false, false, 0, true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(tongzi,dachui, 0,  0, 0, -0.2, -35.0, 100.0,0, true, true, false, false, 0, true)
        util.yield(1000)
        bigbarrelqq = on
    else
        menu.trigger_commands("damagemultiplier 1")
        menu.trigger_commands("rangemultiplier 1")
        entities.delete_by_handle(dachui)
        entities.delete_by_handle(tongzi)
        bigbarrelqq = off
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),-1810795771)
    end
end
----GT大锤
function gthammer(on)
    if on then
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
        dachui = OBJECT.CREATE_OBJECT(util.joaat("prop_bollard_04"), pos.x, pos.y, pos.z, true, true, false)
        tongzi = OBJECT.CREATE_OBJECT(util.joaat("prop_barrel_03d"), pos.x, pos.y, pos.z, true, true, false)
        menu.trigger_commands("damagemultiplier 1000")
        menu.trigger_commands("rangemultiplier 1.5")
        ENTITY.ATTACH_ENTITY_TO_ENTITY(dachui, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.2, 0.95, 0.2, 105, 30.0, 0, true, true, false, false, 0, true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(tongzi,dachui, 0,  0, 0, -0.2, -35.0, 100.0,0, true, true, false, false, 0, true)
        util.yield(1000)
        bigbigbig = on
    else
        menu.trigger_commands("damagemultiplier 1")
        menu.trigger_commands("rangemultiplier 1")
        entities.delete_by_handle(dachui)
        entities.delete_by_handle(tongzi)
        bigbigbig = off
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),-1810795771)
    end
end

--太刀
function knife(on)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    local taidao = OBJECT.CREATE_OBJECT(util.joaat("prop_cs_katana_01"), pos.x, pos.y, pos.z, true, true, false)
    if on then
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),1317494643,15,true,true)
        WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(PLAYER.PLAYER_PED_ID(), not on, false, false, false)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(taidao, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.07, 0, 0, -100, 0.0, 0, true, true, true, true, 0, true)
    else
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),1317494643)
        local count = 0
			for k,ent in pairs(entities.get_all_objects_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				count = count + 1
				util.yield()
			end
    end
end

---小挂件
main_icon = filesystem.resources_dir() .. "daidai-img\\"
local ImgFolderDir = main_icon .. "Img\\"
function dd_showpng()
    function SHOW_IMG(ImgName, MaxPassedTime)
        if filesystem.exists(ImgFolderDir .. ImgName) then
            local Img = directx.create_texture(ImgFolderDir .. ImgName)
            local ImgAlpha = 0---初始时间
            local IncreasedImgAlpha = 0.01----增加的时间
            local StartedTime = os.clock()

                util.create_tick_handler(function()
                    ImgAlpha = ImgAlpha + IncreasedImgAlpha
                    if ImgAlpha > 1 then
                        ImgAlpha = 1
                    elseif ImgAlpha < 0 then 
                        ImgAlpha = 0
                        return false
                    end
                end)
    
                util.create_tick_handler(function()
                directx.draw_texture(Img, 0.1, 0.1, 1.3, -1.1, 0.5, 0.5, 0, 1, 1, 1, ImgAlpha)
                local PassedTime = os.clock() - StartedTime
                    if PassedTime > MaxPassedTime then
                        IncreasedImgAlpha = -0.01
                    end
                    if ImgAlpha == 0 then
                        return false
                    end
                end)
        end
    end
	    SHOW_IMG("1.png", 4)
        util.yield(3000)
end

----锤子
function hammer(on)
    if on then
        WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)
        local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
        dachui = OBJECT.CREATE_OBJECT(util.joaat("prop_bollard_02a"), pos.x, pos.y, pos.z, true, true, false)
        tongzi = OBJECT.CREATE_OBJECT(util.joaat("prop_barrel_02a"), pos.x, pos.y, pos.z, true, true, false)
        menu.trigger_commands("damagemultiplier 1000")
        menu.trigger_commands("rangemultiplier 1.5")
        ENTITY.ATTACH_ENTITY_TO_ENTITY(dachui, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.2, 0.95, 0.2, 105, 30.0, 0, true, true, false, false, 0, true)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(tongzi,dachui, 0,  0, 0, -0.2, -35.0, 100.0,0, true, true, false, false, 0, true)
        util.yield(1000)
        bigbigbig = on
    else
        menu.trigger_commands("damagemultiplier 1")
        menu.trigger_commands("rangemultiplier 1")
        entities.delete_by_handle(dachui)
        entities.delete_by_handle(tongzi)
        bigbigbig = off
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),-1810795771)
     end
end

-------喷火器
flamemildOrangeFire = new_colour( 255, 127, 80 )
flameThrower = {
    colour = flamemildOrangeFire
}
function flamegun()
    local JSkey = require 'lib.daidailib.JSkeyLib'
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



--双拳
local bones = {
    26612,
    58868,
}
function Fire_Fist(on)
    if on then
        for _, boneId in ipairs(bones) do
        request_ptfx_asset("core")
        GRAPHICS.USE_PARTICLE_FX_ASSET("core")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("fire_wrecked_plane_cockpit", players.user_ped(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(players.user_ped(), boneId), 0.35, false, false, false, 0, 0, 0, 0)
        end
    else
        GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
    end
end
function Blood_Fist(on)
    if on then
        for _, boneId in ipairs(bones) do
        request_ptfx_asset("core")
        GRAPHICS.USE_PARTICLE_FX_ASSET("core")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("scrape_blood_car", players.user_ped(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(players.user_ped(), boneId), 0.35, false, false, false, 0, 0, 0, 0)
        end
    else
        GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
    end
end
function Raiden_Fist(on)
    if on then
        for _, boneId in ipairs(bones) do
        request_ptfx_asset("scr_reconstructionaccident")
        GRAPHICS.USE_PARTICLE_FX_ASSET("scr_reconstructionaccident")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("scr_sparking_generator", players.user_ped(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(players.user_ped(), boneId), 2, false, false, false, 0, 0, 0, 0)
        end
    else
        GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
    end
end



-----实体池限制
function entity_limit()
    local ped_count = 0
    for _, ped in pairs(entities.get_all_peds_as_handles()) do
        if ped ~= players.user_ped() then
            ped_count += 1
        end
        if ped_count >= ped_limit then
            for _, ped in pairs(entities.get_all_peds_as_handles()) do
                entities.delete_by_handle(ped)
            end
            util.toast("Ped池达到上限,正在清理...")
        end
    end
    local veh__count = 0
    for _, veh in ipairs(entities.get_all_vehicles_as_handles()) do
        veh__count += 1
        if veh__count >= veh_limit then
            for _, veh in ipairs(entities.get_all_vehicles_as_handles()) do 
                entities.delete_by_handle(veh)   
            end    
            util.toast("载具池达到上限,正在清理...")    
        end    
    end   
    local obj_count = 0    
    for _, obj in pairs(entities.get_all_objects_as_handles()) do    
        obj_count += 1   
        if obj_count >= obj_limit then 
            for _, obj in pairs(entities.get_all_objects_as_handles()) do
                entities.delete_by_handle(obj)
            end
            util.toast("物体池达到上限,正在清理...")
        end
    end 
end


----实体枪v1
function raycast_gameplay_cam(flag, distance)
    local ptr1, ptr2, ptr3, ptr4 = memory.alloc(), memory.alloc(), memory.alloc(), memory.alloc()
    local cam_rot = CAM.GET_GAMEPLAY_CAM_ROT(0)
    local cam_pos = CAM.GET_GAMEPLAY_CAM_COORD()
    local direction = v3.toDir(cam_rot)
    local destination = 
    { 
        x = cam_pos.x + direction.x * distance, 
        y = cam_pos.y + direction.y * distance, 
        z = cam_pos.z + direction.z * distance 
    }
    SHAPETEST.GET_SHAPE_TEST_RESULT(
        SHAPETEST.START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE(
            cam_pos.x, 
            cam_pos.y, 
            cam_pos.z, 
            destination.x, 
            destination.y, 
            destination.z, 
            flag, 
            players.user_ped(), 
            1
        ), ptr1, ptr2, ptr3, ptr4)
    local p1 = memory.read_int(ptr1)
    local p2 = memory.read_vector3(ptr2)
    local p3 = memory.read_vector3(ptr3)
    local p4 = memory.read_int(ptr4)
    return {p1, p2, p3, p4}
end
function get_offset_from_gameplay_camera(distance)
    local cam_rot = CAM.GET_GAMEPLAY_CAM_ROT(0)
    local cam_pos = CAM.GET_GAMEPLAY_CAM_COORD()
    local direction = v3.toDir(cam_rot)
    local destination = 
    { 
        x = cam_pos.x + direction.x * distance, 
        y = cam_pos.y + direction.y * distance, 
        z = cam_pos.z + direction.z * distance 
    }
    return destination
end

shootent = -422877666
function eentity_gun()
    if PED.IS_PED_SHOOTING(players.user_ped()) then
        local hash = shootent
        request_model_load(hash)
        local c1 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0.0, 5.0, 0.0)
        local res = raycast_gameplay_cam(-1, 1000.0)
        local dir = {}
        local c2 = {}
        if res[1] ~= 0 then
            c2 = res[2]
            dir['x'] = (c2['x'] - c1['x'])*1000
            dir['y'] = (c2['y'] - c1['y'])*1000
            dir['z'] = (c2['z'] - c1['z'])*1000
        else 
            c2 = get_offset_from_gameplay_camera(1000)
            dir['x'] = (c2['x'] - c1['x'])*1000
            dir['y'] = (c2['y'] - c1['y'])*1000
            dir['z'] = (c2['z'] - c1['z'])*1000
        end
        local ent = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, c1['x'], c1['y'], c1['z'], true, false, false)
        ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(ent, players.user_ped(), false)
        ENTITY.APPLY_FORCE_TO_ENTITY(ent, 0, dir['x'], dir['y'], dir['z'], 0.0, 0.0, 0.0, 0, true, false, true, false, true)
    end
end
-------------

----车祸模拟
function car_crash()
    veh = entities.get_user_vehicle_as_handle()
    if veh == 0 then return end
    CAutomobile = entities.handle_to_pointer(veh)
    CHandlingData = memory.read_long(CAutomobile + 0x0918)
    if util.is_key_down(0x57) and util.is_key_down(0x11) then 
       memory.write_float(CHandlingData + 0x00EC, -0.25)
    else
       memory.write_float(CHandlingData + 0x00EC, 0.5)
    end
end

--氮气加速
local nitro_duration = 5000
local nitro_power = 2000
function nnitrogen_acceleration()
    if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) and player_cur_car ~= 0 then
        if PAD.IS_CONTROL_JUST_PRESSED(357, 357) then 
            request_ptfx_asset('veh_xs_vehicle_mods')
            VEHICLE1.SET_OVERRIDE_NITROUS_LEVEL(player_cur_car, true, 100, nitro_power, 99999999999, false)
            ENTITY.SET_ENTITY_MAX_SPEED(player_cur_car, 2000)
            VEHICLE1.SET_VEHICLE_MAX_SPEED(player_cur_car, 2000)
            util.yield(nitro_duration)
            VEHICLE1.SET_OVERRIDE_NITROUS_LEVEL(player_cur_car, false, 0, 0, 0, false)
            VEHICLE1.SET_VEHICLE_MAX_SPEED(player_cur_car, 0.0)
        end
    end
end
function nnitro_duration(val)
    nitro_duration = val * 1000
end
function nnitro_power(val)
    nitro_power = val
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
initial_d_mode = false
initial_d_score = false
function on_user_change_vehicle(vehicle)
    if vehicle ~= 0 then
        if initial_d_mode then 
            set_vehicle_into_drift_mode(vehicle)
        end

        local deez_nuts = {}
        local num_seats = VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(ENTITY.GET_ENTITY_MODEL(vehicle))
        for i=1, num_seats do
            if num_seats >= 2 then
                deez_nuts[#deez_nuts + 1] = tostring(i - 2)
            else
                deez_nuts[#deez_nuts + 1] = tostring(i)
            end
        end
        if true then 
            native_invoker.begin_call()
            native_invoker.push_arg_int(vehicle)
            native_invoker.end_call("76D26A22750E849E")
        end
    end
end

-------拉车
function update_attachment_position(attachment)
    if attachment.offset == nil then
        attachment.offset = {x=0,y=0,z=0}
    end
    if attachment.rotation == nil then
        attachment.rotation = {x=0,y=0,z=0}
    end
    if attachment.collision == nil then
        attachment.collision = true
    end
    ENTITY.ATTACH_ENTITY_TO_ENTITY(
        attachment.handle, attachment.root, attachment.bone_index or 0,
        attachment.offset.x or 0, attachment.offset.y or 0, attachment.offset.z or 0,
        attachment.rotation.x or 0, attachment.rotation.y or 0, attachment.rotation.z or 0,
        false, true, attachment.collision, false, 2, true
    )
end
function get_vehicle_dimension(vehicle)
    local minimum = memory.alloc()
    local maximum = memory.alloc()
    MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(vehicle), minimum, maximum)
    local minimum_vec = v3.new(minimum)
    local maximum_vec = v3.new(maximum)
    return {x = maximum_vec.y - minimum_vec.y, y = maximum_vec.x - minimum_vec.x, z = maximum_vec.z - minimum_vec.z}
end
function set_attachment_offset_for_root(attachment)
    local root_model = util.reverse_joaat(ENTITY.GET_ENTITY_MODEL(attachment.root))
    local dimensions = get_vehicle_dimension(attachment.handle)
    if root_model == "wastelander" then
        attachment.offset = {
            x=0,
            y=(dimensions.y / 2) - 2,
            z=(dimensions.z / 2) + 0.8
        }
    end
    if root_model == "slamtruck" then
        attachment.offset = {
            x=0,
            y=(dimensions.y / 2) - 3,
            z=(dimensions.z / 2) + 0.3
        }
        attachment.rotation = {
            x=8,
            y=0,
            z=0,
        }
    end
end
function attach(attachment)
    attachment.position = ENTITY.GET_ENTITY_COORDS(attachment.root)
    ENTITY.SET_ENTITY_HAS_GRAVITY(attachment.handle, false)
    set_attachment_offset_for_root(attachment)
    update_attachment_position(attachment)
    ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(attachment.root, attachment.handle)
    return attachment
end
statecar = {}
function detach_attached_vehicle()
    if statecar.attached_vehicle ~= nil then
        util.toast("已分离 "..statecar.attached_vehicle.name)
        ENTITY.DETACH_ENTITY(statecar.attached_vehicle.handle, true, true)
        statecar.attached_vehicle = nil
    end
end
function attach_nearest_vehicle()
    local player_vehicle = entities.get_user_vehicle_as_handle()
    if not player_vehicle then
        util.toast("您必须在车辆中才能附加")
        return
    end
    local pos = ENTITY.GET_ENTITY_COORDS(player_vehicle, 1)
    local range = 20
    local nearby_vehicles = entities.get_all_vehicles_as_handles()
    local count = 0
    for _, vehicle_handle in ipairs(nearby_vehicles) do
        if vehicle_handle ~= player_vehicle then
            local attachment = {handle=vehicle_handle, root=player_vehicle}
            attachment.position = ENTITY.GET_ENTITY_COORDS(attachment.handle, 1)
            attachment.distance = SYSTEM.VDIST(pos.x, pos.y, pos.z, attachment.position.x, attachment.position.y, attachment.position.z)
            if attachment.distance <= range then
                detach_attached_vehicle()
                attachment.name = VEHICLE.GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(ENTITY.GET_ENTITY_MODEL(attachment.handle))
                util.toast("已附加 "..attachment.name)
                attach(attachment)
                statecar.attached_vehicle = attachment
                return
            end
        end
    end
end

--烟雾掉帧
function fumes(pid)
local freeze_toggle = menu.ref_by_rel_path(menu.player_root(pid), "Trolling>Freeze")
local player_pos = players.get_position(pid)
menu.set_value(freeze_toggle, true)
request_ptfx_asset("core")
GRAPHICS.USE_PARTICLE_FX_ASSET("core")
GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
    "exp_extinguisher", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
menu.set_value(freeze_toggle, false)
end

----按键显示
function newColor(R, G, B, A)
    return {r = R, g = G, b = B, a = A}
end
size = 0.03
boxMargin = size / 7
overlay_x = 0.0400
overlay_y = 0.1850
local x, y = directx.get_client_size()
local ratio = x/y
local spaceBarLength = 3
local spaceBarSlim = 1
local altSpaceBar = 0
local key_text_color = newColor(1, 1, 1, 1)
local background_colour = newColor(0, 0, 0, 0.2)
local pressed_background_colour = newColor(2.55/255, 2.55/255, 2.55/255, 0.5490196078431373)
local wasd = {
    [1]  = { keys = {44, 52, 85, 138, 141, 152, 205, 264},                                               pressed = false, key = 'Q',     show = true },
    [2]  = { keys = {32, 71, 77, 87, 129, 136, 150, 232},                                                pressed = false, key = 'W',     show = true },
    [3]  = { keys = {38, 46, 51, 54, 86, 103, 119, 153, 184, 206, 350, 351, 355, 356},                   pressed = false, key = 'E',     show = true },
    [4]  = { keys = {45, 80, 140, 250, 263, 310},                                                        pressed = false, key = 'R',     show = true },
    [5]  = { keys = {34 ,63, 89, 133, 147, 234, 338},                                                    pressed = false, key = 'A',     show = true },
    [6]  = { keys = {8, 31, 33, 72, 78, 88, 130, 139, 149, 151, 196, 219, 233, 268, 269, 302},           pressed = false, key = 'S',     show = true },
    [7]  = { keys = {9, 30, 35, 59, 64, 90, 134, 146, 148, 195, 218, 235, 266, 267, 278, 279, 339, 342}, pressed = false, key = 'D',     show = true },
    [8]  = { keys = {23, 49, 75, 145, 185, 251},                                                         pressed = false, key = 'F',     show = true },
    [9]  = { keys = {21, 61, 131, 155, 209, 254, 340, 352},                                              pressed = false, key = 'Shift', show = true },
    [10] = { keys = {36, 60, 62, 132, 224, 280, 281, 326, 341, 343},                                     pressed = false, key = 'Ctrl',  show = true },
    [11] = { keys = {18, 22, 55, 76, 102, 143, 179, 203, 216, 255, 298, 321, 328, 353},                  pressed = false, key = 'Space', show = true },
}
function key_display()
    for i = 1, #wasd do
        wasd[i].pressed = false
        for j = 1, #wasd[i].keys do
            if PAD.IS_CONTROL_PRESSED(2, wasd[i].keys[j]) then
                wasd[i].pressed = true
            end
        end
    end
    for i = 1, #wasd - 3 do
        if wasd[i].show then
            directx.draw_rect(overlay_x + (boxMargin + size) * (i > 4 and i - 5 or i - 1), overlay_y + (i > 4 and (boxMargin + size * ratio) or 0)* 1.05, size, size * ratio, wasd[i].pressed and pressed_background_colour or background_colour)
            if not hideKey then
                directx.draw_text(overlay_x + (boxMargin + size) * (i > 4 and i - 5 or i - 1)+ size * 0.45,(i > 4 and  overlay_y + (boxMargin + size * ratio)* 1.2 or  overlay_y*1.07) , wasd[i].key, 1, size *20, key_text_color, false)
            end
        end
    end
    if altShiftCtrl then
        if wasd[#wasd - 2].show then
            directx.draw_rect(overlay_x, overlay_y + (boxMargin + size)* ratio * 2,(boxMargin + size) - boxMargin, size * ratio / 2, wasd[#wasd - 2].pressed and pressed_background_colour or background_colour)
        end
        if wasd[#wasd - 1].show then
            directx.draw_rect(overlay_x, overlay_y + (boxMargin + size)* ratio * 2.5,(boxMargin + size) - boxMargin, size * ratio / 2, wasd[#wasd - 1].pressed and pressed_background_colour or background_colour)
        end
    else
        for i = 9, 10 do
            if wasd[i].show then
            directx.draw_rect(overlay_x - (boxMargin + size), overlay_y + (boxMargin + size * ratio) * (i - 8) * 1.05, size, size * ratio, wasd[i].pressed and pressed_background_colour or background_colour)
            if not hideKey then
                directx.draw_text(overlay_x - (boxMargin + size)+ size * 0.45,(i > 4 and  overlay_y + (boxMargin + size * ratio) * (i - 8)* 1.2 or  overlay_y*1.07) , wasd[i].key, 1, size *20, key_text_color, false)

            end
            end
        end
    end
    if wasd[#wasd].show then
        directx.draw_rect(overlay_x + (boxMargin + size) * altSpaceBar, overlay_y + (boxMargin + size)* ratio * 2,(boxMargin + size) * spaceBarLength - boxMargin, size * ratio / spaceBarSlim, wasd[#wasd].pressed and pressed_background_colour or background_colour)
    end
end


-----绘制血量条
function draw_rect(x, y, width, height, colour)
	GRAPHICS.DRAW_RECT(x, y, width, height, colour.r, colour.g, colour.b, colour.a, false)
end
function draw_health_bar(ped, maxDistance)
	local myPos = players.get_position(players.user())
	local pedPos = ENTITY.GET_ENTITY_COORDS(ped, true)
	local distance = myPos:distance(pedPos)
	if distance >= maxDistance then return end
	local distPerc = 1.0 - distance / maxDistance

	local healthPerc = 0.0
	local armourPerc = 0.0
	if not PED.IS_PED_FATALLY_INJURED(ped) then
		local armour = PED.GET_PED_ARMOUR(ped)
		armourPerc = armour / 100.0
		if armourPerc > 1.0 then armourPerc = 1.0 end
		local health = ENTITY.GET_ENTITY_HEALTH(ped) - 100.0
		local maxHealth = PED.GET_PED_MAX_HEALTH(ped) - 100.0
		healthPerc = health / maxHealth
		if healthPerc > 1.0 then healthPerc = 1.0 end
	end

	local maxLength = 0.05 * distPerc ^3
	local height = 0.008 * distPerc ^1.5
	local pos = PED.GET_PED_BONE_COORDS(ped, 0x322C --[[head]], 0.35, 0.0, 0.0)
	local pScreenX, pScreenY = memory.alloc(4), memory.alloc(4)
	if not GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(pos.x, pos.y, pos.z, pScreenX, pScreenY) then
		return
	end
	local screenX = memory.read_float(pScreenX)
	local screenY = memory.read_float(pScreenY)

	local barLength = interpolate(0.0, maxLength, healthPerc)
	local colour = get_blended_colour(healthPerc)
	draw_rect(screenX, screenY, maxLength + 0.002, height + 0.002, {r = 0, g = 0, b = 0, a = 120})
	draw_rect(screenX - maxLength/2 + barLength/2, screenY, barLength, height, colour)

	local barLength = interpolate(0.0, maxLength, armourPerc)
	local colour = get_hud_colour(HudColour.radarArmour)
	draw_rect(screenX, screenY + 1.5 * height, maxLength + 0.002, height + 0.002, {r = 0, g = 0, b = 0, a = 120})
	draw_rect(screenX - maxLength/2 + barLength/2, screenY + 1.5 * height, barLength, height, colour)
end


----------GPS导航/////lib
b_common_funcs = {}
b_common_funcs.new = function ()
    local self = {}
    self.address_from_pointer_chain = function (basePtr, offsets)
        local addr = memory.read_long(basePtr)
        for k = 1, (#offsets - 1) do
            addr = memory.read_long(addr + offsets[k])
            if addr == 0 then
                return 0
            end
        end
        addr = addr + offsets[#offsets]
        return addr
    end
    self.get_player_vehicle_class = function ()
        local veh = entities.get_user_vehicle_as_handle()
        return VEHICLE.GET_VEHICLE_CLASS(veh)
    end
    self.get_ascpect_ratio = function()
        local screen_x, screen_y = directx.get_client_size()
    
        return screen_x / screen_y
    end
    self.to_bits = function(num)
        local t={}
        while num>0 do
            rest=math.fmod(num,2)
            t[#t+1]=rest
            num=(num-rest)/2
        end
        return t
    end
    self.split = function (input, sep)
        local t={}
        for str in string.gmatch(input, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
    end
    local minimum = memory.alloc()
    local maximum = memory.alloc()
    self.get_pos_above_entity = function (entity)
        MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(entity), minimum, maximum)
        local maximum_vec = memory.read_vector3(maximum)
        return ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, 0, 0, maximum_vec.z)
    end
    self.copy_File = function(old_path, new_path)
        local old_file = io.open(old_path, "rb")
        local new_file = io.open(new_path, "wb")
        local old_file_sz, new_file_sz = 0, 0
        if not old_file or not new_file then
          return false
        end
        while true do
          local block = old_file:read(2^13)
          if not block then 
            old_file_sz = old_file:seek( "end" )
            break
          end
          new_file:write(block)
        end
        old_file:close()
        new_file_sz = new_file:seek( "end" )
        new_file:close()
        return new_file_sz == old_file_sz
      end
    return self
end
b_math_funcs = {}
b_math_funcs.new = function ()
    local self = {}
    self.lerp = function(a, b, t)
        return a + (b - a) * t
    end
    local EPSILON = 0.0000001
    self.RayIntersectsTriangle = function(rayOrigin, rayDirection, vertex1, vertex2, vertex3)
        local edge1, edge2, h, s, q, a, f, u, v
        edge1 = {x = vertex2.x - vertex1.x, y = vertex2.y - vertex1.y, z = vertex2.z - vertex1.z}
        edge2 = {x = vertex3.x - vertex1.x, y = vertex3.y - vertex1.y, z = vertex3.z - vertex1.z}
        h = {
            x =    edge2.y * rayDirection.z - edge2.z * rayDirection.y,
            y =    edge2.z * rayDirection.x - edge2.x * rayDirection.z,
            z =    edge2.x * rayDirection.y - edge2.y * rayDirection.x
        }
        a = h.x * edge1.x + h.y * edge1.y + h.z * edge1.z

        if a > -EPSILON and a < EPSILON then return false end

        f = 1.0/a
        s = {x = rayOrigin.x - vertex1.x, y = rayOrigin.y - vertex1.y, z = rayOrigin.z - vertex1.z}
        u = f * (h.x * s.x + h.y * s.y + h.z * s.z)
        if u < 0.0 or u > 1.0 then return false end
        q = {
            x =    edge1.y * s.z - edge1.z * s.y,
            y =    edge1.z * s.x - edge1.x * s.z,
            z =    edge1.x * s.y - edge1.y * s.x
        }
        v = f * (rayDirection.x * q.x + rayDirection.y * q.y + rayDirection.z * q.z)
        if v < 0.0 or u + v > 1.0 then return false end
        t = f *  (edge2.x * q.x + edge2.y * q.y + edge2.z * q.z)
        if t > EPSILON then
            return true, {
                x = rayOrigin.x + rayDirection.x * t,
                y = rayOrigin.y + rayDirection.y * t,
                z = rayOrigin.z + rayDirection.z * t
            }
        else
            return false
        end
    end
    return self
end
b_vectors = {}
b_vectors.new = function ()
    local self = {}

    self.vector2 = {}
    self.vector2.new = function (x, y)
        return {x = x, y = y}
    end
    self.vector2.dot = function(vector_a, vector_b)
        return (vector_a.x * vector_b.x) + (vector_a.y * vector_b.y)
    end
    self.vector2.magnitude = function(vector)
        return math.sqrt((vector.x * vector.x) + (vector.y * vector.y))
    end
    self.vector2.get_angle = function(vector_a, vector_b)
        return math.acos(self.vector2.dot(vector_a, vector_b) / self.vector2.magnitude(vector_a) / self.vector2.magnitude(vector_b))
    end
    self.vector3 = {}
    self.vector3.new = function (x, y, z)
        return {x = x, y = y, z = z}
    end
    self.vector3.add = function(a, b)
        return self.vector3.new(a.x + b.x, a.y + b.y, a.z + b.z)
    end
    self.vector3.sub = function(a, b)
        return self.vector3.new(a.x - b.x, a.y - b.y, a.z - b.z)
    end
    self.vector3.multiply = function (vec, num)
        return {x = vec.x * num, y = vec.y * num, z = vec.z * num}
    end
    return self
end
function get_waypoint_coords()
    return HUD.GET_BLIP_INFO_ID_COORD(HUD.GET_FIRST_BLIP_INFO_ID(HUD.GET_WAYPOINT_BLIP_ENUM_ID()))
end

-----GPS导航
local player_ped_id
local delta_time
local player_pos
util.create_tick_handler(function ()
    player_ped_id = PLAYER.PLAYER_PED_ID()
    delta_time = MISC.GET_FRAME_TIME()
    player_pos = ENTITY.GET_ENTITY_COORDS(player_ped_id)
    return true
end)

local math_funcs = b_math_funcs.new()
local shitty_gps_colour_a = {r = 255,g = 0,b = 255,a = 255}
local shitty_gps_colour_b = {r = 255,g = 255,b = 255,a = 255}
local shitty_gps_run = false

function GPS_navigation(value)
    local p_direction = memory.alloc(1) --bool
    local p_5 = memory.alloc(4) --float
    local p_distToNxJunction = memory.alloc(4) --float
    local p_screenX = memory.alloc(4) --float
    local p_screenY = memory.alloc(4) --float

    local turn_dir = 0
    shitty_gps_run = value

    if value then
    util.create_tick_handler(function ()
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)

    local waypoint_pos = get_waypoint_coords()
    local total = waypoint_pos.x + waypoint_pos.y + waypoint_pos.z

    if total ~= 0 and ENTITY.IS_ENTITY_A_VEHICLE(vehicle) then
        local height = ENTITY.GET_ENTITY_HEIGHT(vehicle, player_pos.x, player_pos.y, player_pos.z, true, false)

        PATHFIND.GENERATE_DIRECTIONS_TO_COORD(
            waypoint_pos.x,
            waypoint_pos.y,
            waypoint_pos.z,
            0,
            p_direction,
            p_5,
            p_distToNxJunction
        )

        local direction = memory.read_byte(p_direction)
        local distToNxJunction = memory.read_float(p_distToNxJunction) - 18



        GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(
            player_pos.x,
            player_pos.y,
            player_pos.z + 1.5 + height,
            p_screenX,
            p_screenY
        )
        local screen_x = memory.read_float(p_screenX)
        local screen_y = memory.read_float(p_screenY)

       if direction == 1 then
            turn_dir = math_funcs.lerp(turn_dir, 180, 5 * delta_time)
            directx.draw_text(screen_x, screen_y, "请在前方路口调头", ALIGN_CENTRE, 1, shitty_gps_colour_a)
        elseif direction == 3 then      
            turn_dir =  math_funcs.lerp(turn_dir, -90, 5 * delta_time)
            if math.floor(distToNxJunction) > -1 then
                directx.draw_text(screen_x,screen_y,"请在前方路口" .. math.floor(distToNxJunction) .. " 米后左转 ",ALIGN_CENTRE,1,shitty_gps_colour_a)
            end
        elseif direction == 6 then
            turn_dir =  math_funcs.lerp(turn_dir, -145, 5 * delta_time)
            if math.floor(distToNxJunction) > -1 then
                directx.draw_text(screen_x,screen_y, math.floor(distToNxJunction) .. " 米后向左急转弯 ",ALIGN_CENTRE,1,shitty_gps_colour_a)
            end
        elseif direction == 4 then          
            turn_dir =  math_funcs.lerp(turn_dir, 90, 5 * delta_time)
            if math.floor(distToNxJunction) > -1 then
                directx.draw_text(screen_x,screen_y,"请在前方路口 " .. math.floor(distToNxJunction) .. " 米后右转",ALIGN_CENTRE,1,shitty_gps_colour_a)
            end
        elseif direction == 7 then
            turn_dir =  math_funcs.lerp(turn_dir, 145, 5 * delta_time)
            if math.floor(distToNxJunction) > -1 then
                directx.draw_text(screen_x,screen_y,math.floor(distToNxJunction) .. " 米后向右急转弯 " ,ALIGN_CENTRE,1,shitty_gps_colour_a)
            end
        elseif direction == 8 then
            turn_dir =  math_funcs.lerp(turn_dir, 0, 5 * delta_time)
            directx.draw_text(screen_x, screen_y, "正在重新规划路线    ", ALIGN_CENTRE, 1, shitty_gps_colour_a)
        else
            turn_dir =  math_funcs.lerp(turn_dir, 0, 5 * delta_time)
        end
        local direction = ENTITY.GET_ENTITY_FORWARD_VECTOR(player_ped_id)
        local angle = b_vectors.new().vector2.get_angle(direction, {x = 0, y = 1})
        if b_vectors.new().vector2.dot({x = direction.x, y = direction.y}, {x = 1, y = 0}) > 0 then
            angle = -angle
        end
        local draw_pos = b_common_funcs.new().get_pos_above_entity(vehicle)
        draw_pos.z = draw_pos.z + 0.4
        drawing_funcs.draw_arrow(draw_pos, angle - math.rad(turn_dir), 1, shitty_gps_colour_a, shitty_gps_colour_b)
    end

    return shitty_gps_run
    end)
    end
end



------给予所有玩家MK-2
function upgrade_vehicle(vehicle)
    for i = 0, 49 do
        local num = VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, i)
        VEHICLE.SET_VEHICLE_MOD(vehicle, i, num - 1, true)
    end
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



--------崩溃XP
function CreateVehicle(Hash, Pos, Heading, Invincible)
    STREAMING.REQUEST_MODEL(Hash)
    while not STREAMING.HAS_MODEL_LOADED(Hash) do util.yield() end
    local SpawnedVehicle = entities.create_vehicle(Hash, Pos, Heading)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(Hash)
    if Invincible then
        ENTITY.SET_ENTITY_INVINCIBLE(SpawnedVehicle, true)
    end
    return SpawnedVehicle
end
function CreateObject(Hash, Pos, static)
    STREAMING.REQUEST_MODEL(Hash)
    while not STREAMING.HAS_MODEL_LOADED(Hash) do util.yield() end
    local SpawnedVehicle = entities.create_object(Hash, Pos)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(Hash)
    if static then
        ENTITY.FREEZE_ENTITY_POSITION(SpawnedVehicle, true)
    end
    return SpawnedVehicle
end
function CreatePed(index, Hash, Pos, Heading)
    STREAMING.REQUEST_MODEL(Hash)
    while not STREAMING.HAS_MODEL_LOADED(Hash) do util.yield() end
    local SpawnedVehicle = entities.create_ped(index, Hash, Pos, Heading)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(Hash)
    return SpawnedVehicle
end
function xp_over(pid)
local model_array = {util.joaat("boattrailer"),util.joaat("trailersmall"),util.joaat("raketrailer"),}
        local BAD_attach = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
        local fuck_ped = CreatePed(26 , util.joaat("ig_kaylee"), BAD_attach, 0)
        ENTITY.SET_ENTITY_VISIBLE(fuck_ped, false)
        for i = 1, 3, 1 do
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(fuck_ped, BAD_attach.x, BAD_attach.y, BAD_attach.z)
            for spawn, value in pairs(model_array) do
                local vels = {}
                vels[spawn] = CreateVehicle(value, BAD_attach, 0)
                for attach, value in pairs(vels) do
                    ENTITY1.ATTACH_ENTITY_BONE_TO_ENTITY_BONE_Y_FORWARD(value, fuck_ped, 0, 0, true, true)
                end
            end
            util.yield(500)
            menu.trigger_commands("explode" ..  players.get_name(pid))
        end
end
-------------------------

------飞机模型崩溃
local planes = {'microlight', 'cuban800', 'tula', 'alphaz1', 'velum2', 'nimbus', 'seabreeze'} -- 'buzzard', 'savage', 'seasparrow', 'frogger2', 'bulldozer', 'flatbed', 'proptrailer', 'tr4'
    local coords = {
        {-1718.5878, -982.02405, 322.83115},
        {-2671.5007, 3404.2637, 455.1972},
        {9.977266, 6621.406, 306.46536 },
        {3529.1458, 3754.5452, 109.96472},
        {252, 2815, 120},
    }
    local to_ply = 1

    function RqModel(hash)
        STREAMING.REQUEST_MODEL(hash)
        local count = 0
        util.toast("请求模型...")
        while not STREAMING.HAS_MODEL_LOADED(hash) and count < 100 do
            STREAMING.REQUEST_MODEL(hash)
            count = count + 1
            util.yield(10)
        end
        if not STREAMING.HAS_MODEL_LOADED(hash) then
            util.toast("尝试了1秒，无法加载此指定模型!")
        end
    end

    function GetLocalPed()
        return PLAYER.PLAYER_PED_ID()
    end

    G_GeneratedList = false

    function AddEntityToList(listName, handle, generatedCheck)
        if ((not G_GeneratedList) and generatedCheck) or (not generatedCheck) then
            G_GeneratedList = true
            local lis = menu.list(menu.my_root(), listName .. " handle " .. handle, {}, "")
            menu.action(lis, "删除", {}, "", function()
                entities.delete_by_handle(handle)
                menu.delete(lis)
                G_GeneratedList = false
            end)
            menu.action(lis, "传送到实体", {}, "", function()
                local pos = ENTITY.GET_ENTITY_COORDS(handle)
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(GetLocalPed(), pos.x, pos.y, pos.z + 1, false, false, false)
            end)
            menu.action(lis, "驾驶实体", {}, "", function()
                PED.SET_PED_INTO_VEHICLE(GetLocalPed(), handle, -1)
            end)
            menu.action(lis, "传送到我", {}, "", function()
                local pos = ENTITY.GET_ENTITY_COORDS(GetLocalPed())
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(handle, pos.x, pos.y, pos.z + 1, false, false, false)
            end)
        end
    end
function airplane_collapsed1()
    menu.trigger_commands("anticrashcamera on")
    if PED.IS_PED_IN_ANY_VEHICLE(GetLocalPed(), false) then
        local jet = PED.GET_VEHICLE_PED_IS_IN(GetLocalPed(), false)
        ENTITY.SET_ENTITY_PROOFS(jet, true, true, true, true, true, true, true, true)
        if players.exists(to_ply) then 
            local asda = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(to_ply)) 
            util.toast('Player ID: '..to_ply..' | asda.x: '.. asda.x.. 'asda.y: '.. asda.y..'asda.z: '.. asda.z)
            ENTITY.SET_ENTITY_COORDS(jet, asda.x, asda.y, asda.z + 50, false, false, false, true) 
            to_ply = to_ply +1
        else 
            if to_ply >= 32 then to_ply = 0 end
            to_ply = to_ply +1 
            local let_coords = coords[math.random(1, #coords)]
            ENTITY.SET_ENTITY_COORDS(jet, let_coords[1], let_coords[2], let_coords[3], false, false, false, true) 
        end
            
        ENTITY.SET_ENTITY_VELOCITY(jet, 0, 0, 0) -- velocity sync fuck
        ENTITY.SET_ENTITY_ROTATION(jet, 0, 0, 0, 2, true) -- rotation sync fuck
        local pedpos = ENTITY.GET_ENTITY_COORDS(GetLocalPed())
        pedpos.z = pedpos.z + 10
        for i = 1, 2 do
            local s_plane = planes[math.random(1, #planes)]
            RqModel(util.joaat(s_plane))
            local veha1 = entities.create_vehicle(util.joaat(s_plane), pedpos, 0)

            ENTITY.ATTACH_ENTITY_TO_ENTITY_PHYSICALLY(veha1, jet, 0, 0, 0, 0, 5 + (2 * i), 0, 0, 0, 0, 0, 0, 1000, true,
                true, true, true, 2)
        end
        AddEntityToList("Plane: ", jet, true)
        util.toast("等待同步5秒...")
        util.yield(100) -- 5k is original
        for i = 1, 25 do -- 50 is original
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(jet, math.random(0, 2555), math.random(0, 2815), math.random(1, 1232), false, false, false) 
            util.yield()
        end
    else
        RqModel(util.joaat('hydra'))
        local spawn_in = entities.create_vehicle(util.joaat('hydra'), ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID()), 0.0)
        PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), spawn_in, -1)
    end
end


----索赔载具
function reclaimVehicles()
	for k, v in menu.get_children(menu.ref_by_path("Vehicle>Personal Vehicles")) do
        for k1, v1 in v.command_names do
            if v1 ~= "findpv" then
                util.toast("完成")
                if v1 == "pv2" then
                    menu.trigger_commands(v1.."request")
                end
            end
        end
	end
end

----飞天扫把
function flying_broom(on)
    if on then 
        local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
        local broomstick = util.joaat("prop_tool_broom")
        local oppressor = util.joaat("oppressor2")
        request_model(broomstick)
        request_model(oppressor)
        obj = entities.create_object(broomstick, pos)
        veh = entities.create_vehicle(oppressor, pos, 0)
        ENTITY.SET_ENTITY_VISIBLE(veh, false, false)
        PED.SET_PED_INTO_VEHICLE(players.user_ped(), veh, -1)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(obj, veh, 0, 0, 0, 0.3, -80.0, 0, 0, true, false, false, false, 0, true) -- thanks to chaos mod for doing the annoying rotation work for me :P
    else
        entities.delete_by_handle(obj)
        entities.delete_by_handle(veh)
    end
end

----分离元素
function detach_all_entities()
    local vehs = entities.get_all_vehicles_as_handles()
    local objs = entities.get_all_objects_as_handles()
    local peds = entities.get_all_peds_as_handles()
    for k,v in pairs(vehs) do
        if ENTITY.IS_ENTITY_ATTACHED_TO_ANY_PED(v) then
            request_control_of_entity(v)
            ENTITY.DETACH_ENTITY(v, false, false)
        end
    end
    for k,v in pairs(objs) do
        if ENTITY.IS_ENTITY_ATTACHED_TO_ANY_PED(v) then
            request_control_of_entity(v)
            ENTITY.DETACH_ENTITY(v, false, false)
        end
    end
    for k,v in pairs(peds) do
        if ENTITY.IS_ENTITY_ATTACHED_TO_ANY_PED(v) then
            request_control_of_entity(v)
            ENTITY.DETACH_ENTITY(v, false, false)
        end
    end
end


----热成像枪
local thermal_command = menu.ref_by_path('Game>Rendering>Thermal Vision')
function thermalgun()
    local aiming = PLAYER.IS_PLAYER_FREE_AIMING(players.user())
    if GRAPHICS.GET_USINGSEETHROUGH() and not aiming then
        menu.trigger_command(thermal_command,'off')
        GRAPHICS1._SEETHROUGH_SET_MAX_THICKNESS(1)
    elseif PAD.IS_CONTROL_JUST_PRESSED(38,38) then
        if menu.get_value(thermal_command) or not aiming then
            menu.trigger_command(thermal_command,"off")
            GRAPHICS1._SEETHROUGH_SET_MAX_THICKNESS(1)
        else
            menu.trigger_command(thermal_command,"on")
            GRAPHICS1._SEETHROUGH_SET_MAX_THICKNESS(50)
        end
    end
end


--恶灵骑士
function request_ptfx_asset_firemen(asset)
    local request_time = os.time()
    STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
        if os.time() - request_time >= 10 then
            break
        end
        util.yield()
    end
end
looped_ptfxs = {}
burning_man_ptfx_asset = "core"
burning_man_ptfx_effect = "fire_wrecked_plane_cockpit"
function elqss(on)
    if on then 
        vehicleelqs = CreateVehicle (1491277511,ENTITY.GET_ENTITY_COORDS(players.user_ped(),false),0,true)
        ENTITY.SET_ENTITY_RENDER_SCORCHED(vehicleelqs,true)
        VEHICLE.SET_VEHICLE_COLOURS(vehicleelqs,147,147)
        VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicleelqs,30,15)
        PED.SET_PED_INTO_VEHICLE(players.user_ped(),vehicleelqs,-1)
        util.yield(500)
        request_ptfx_asset_firemen(burning_man_ptfx_asset)
        for _, boneName in pairs({"wheel_lf", "wheel_lr"}) do
            GRAPHICS.USE_PARTICLE_FX_ASSET(burning_man_ptfx_asset)
            local bone_id = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(vehicleelqs, boneName)
            fx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE(burning_man_ptfx_effect, vehicleelqs, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, bone_id, 0.9, false, false, false, 0, 0, 0, 0)
            looped_ptfxs[#looped_ptfxs+1] = fx
            GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fx, 100, 100, 100, false)
        end
    else
        entities.delete_by_handle(vehicleelqs)
    end
end

----光环
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
function personllight()
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

----拦截劫匪
function sendmugger_npc(pid)
    if NETWORK.NETWORK_IS_SCRIPT_ACTIVE("am_gang_call", 0, true, 0) then
        util.toast("当前劫匪活动还未结束哦")
    else
        local bits_addr = memory.script_global(1853910 + (players.user() * 862 + 1) + 140)
            memory.write_int(bits_addr, SetBit(memory.read_int(bits_addr), 0))
            write_global.int(1853910 + (players.user() * 862 + 1) + 141, pid)
        util.toast("劫匪已出动")
    end
end


----拉便便
local agroup = "missfbi3ig_0"
local mshit = util.joaat("prop_big_shit_02")
local agroup2 = "switch@trevor@jerking_off"
local cum = util.joaat("p_oil_slick_01")
local anim2 = "trev_jerking_off_loop"
local anim = "shit_loop_trev"
function personlshit() 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    c.z = c.z - 1
    while not STREAMING.HAS_ANIM_DICT_LOADED(agroup) do 
        STREAMING.REQUEST_ANIM_DICT(agroup)
        util.yield()
    end
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(players.user_ped())
    TASK.TASK_PLAY_ANIM(players.user_ped(), agroup, anim, 8.0, 8.0, 3000, 0, 0, true, true, true) --play anim
    util.yield(1000)
    local shit = entities.create_object(mshit, c) --spawn shit
    util.yield(60000)
    entities.delete_by_handle(shit) --delete shit
end


--打飞机
function personlhitplane() 
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    c.z = c.z - 1
    while not STREAMING.HAS_ANIM_DICT_LOADED(agroup2) do
        STREAMING.REQUEST_ANIM_DICT(agroup2)
        util.yield()
    end
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(players.user_ped())
    TASK.TASK_PLAY_ANIM(players.user_ped(), agroup2, anim2, 8.0, 8.0, 5000, 1, 0, true, true, true) --play anim
    util.yield(4500)
    local cum = entities.create_object(cum, c) --spawn cum
    util.yield(60000)
    entities.delete_by_handle(cum) --delete cum
end

--粘弹爆炸
local detonate_radius = 2
function autoExplodeStickys(ped)
    local pos = ENTITY.GET_ENTITY_COORDS(ped, true)
    if MISC.IS_PROJECTILE_TYPE_WITHIN_DISTANCE(pos.x, pos.y, pos.z, util.joaat('weapon_stickybomb'), detonate_radius, true) then
        WEAPON.EXPLODE_PROJECTILES(players.user_ped(), util.joaat('weapon_stickybomb'))
    end
end
function proxyStickys()
    if detonate_players then
        local specificWhitelistGroup = {user = false,  friends = whitelistGroups.friends, strangers = whitelistGroups.strangers}
        local playerList = getNonWhitelistedPlayers(whitelistListTable, specificWhitelistGroup, whitelistedName)
        for _, pid in pairs(playerList) do
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            autoExplodeStickys(ped)
        end
    end
    if detonate_npcs then
        local pedHandles = entities.get_all_peds_as_handles()
        for _, ped in pairs(pedHandles) do
            if not PED.IS_PED_A_PLAYER(ped) then
                autoExplodeStickys(ped)
            end
        end
    end
end


--速度表
function vehicle_speedometer(state)
    speedm = state  
    while speedm do
        local ent
            local ent1 = players.user_ped()
            local ent2 = PED.GET_VEHICLE_PED_IS_USING(players.user_ped())
            if PED.IS_PED_IN_ANY_VEHICLE(ent1,true) then
                ent = ent2
            else
                ent = ent1
            end
            local speed = ENTITY.GET_ENTITY_SPEED(ent)
            local speedcalc = speed * 3.6
            myspeed1 = math.ceil(speedcalc)
        util.yield()
        draw_string(string.format("~bold~~italic~~o~"..myspeed1 .. "  ~w~KM/H"), 0.76,0.8, 1,6)
    end
end

--摔倒
local fallTimeout = false
    function tripped1(toggle)
        if toggle then
            local vector = ENTITY.GET_ENTITY_FORWARD_VECTOR(players.user_ped())
            PED.SET_PED_TO_RAGDOLL_WITH_FALL(players.user_ped(), 1500, 2000, 2, vector.x, -vector.y, vector.z, 1, 0, 0, 0, 0, 0, 0)
        end
        fallTimeout = toggle
        while fallTimeout do
            PED.RESET_PED_RAGDOLL_TIMER(players.user_ped())
            util.yield_once()
        end
    end
function tripped2()
    PED.SET_PED_TO_RAGDOLL(players.user_ped(), 2000, 2000, 0, true, true, true)
end