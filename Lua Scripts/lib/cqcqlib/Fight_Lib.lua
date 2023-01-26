local menuroot = menu.my_root()
local menuAction = menu.action
local menuToggle = menu.toggle
local menuToggleLoop = menu.toggle_loop
local joaat = util.joaat
local wait = util.yield

local createPed = PED.CREATE_PED
local getEntityCoords = ENTITY.GET_ENTITY_COORDS
local getPlayerPed = PLAYER.GET_PLAYER_PED
local requestModel = STREAMING.REQUEST_MODEL
local hasModelLoaded = STREAMING.HAS_MODEL_LOADED
local noNeedModel = STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED
local setPedCombatAttr = PED.SET_PED_COMBAT_ATTRIBUTES
local giveWeaponToPed = WEAPON.GIVE_WEAPON_TO_PED

WhiteText = {r = 1.0, g = 1.0, b = 1.0, a = 1.0}

---- >> ---- ---- >> ---- ---- >> ---- ---- >> ---- MISC FUNCTIONS START ---- >> ---- ---- >> ---- ---- >> ---- ---- >> ----

function GetLocalPed()
    return PLAYER.PLAYER_PED_ID()
end

function ToastCoordinates(v3coords)
    util.toast(v3coords.x .. " || " .. v3coords.y .. " || " .. v3coords.z)
end

function SE_add_explosion(x, y, z, exptype, dmgscale, isheard, isinvis, camshake, nodmg)
    FIRE.ADD_EXPLOSION(x, y, z, exptype, dmgscale, isheard, isinvis, camshake, nodmg)
end
function SE_add_owned_explosion(ped, x, y, z, exptype, dmgscale, isheard, isinvis, camshake)
    FIRE.ADD_OWNED_EXPLOSION(ped, x, y, z, exptype, dmgscale, isheard, isinvis, camshake)
end

function DistanceBetweenTwoCoords(v3_1, v3_2)
    local distance = math.sqrt(((v3_2.x - v3_1.x)^2) + ((v3_2.y - v3_1.y)^2) + ((v3_2.z - v3_1.z)^2))
    return distance
end

function GetPlayerName_ped(ped)
    local playerID = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(ped)
    local playerName = NETWORK.NETWORK_PLAYER_GET_NAME(playerID)
    return playerName
end
function GetPlayerName_pid(pid)
    local playerName = NETWORK.NETWORK_PLAYER_GET_NAME(pid)
    return playerName
end

function GetEntityTypeString(handle)
    local t = ENTITY.GET_ENTITY_TYPE(handle)
    if (t == 1) then return "Ped" elseif (t == 2) then return "载具" elseif (t == 3) then return "物体" else return nil end
end

--thank you to: https://easings.net for the functions!
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

---- >> ---- ---- >> ---- ---- >> ---- ---- >> ---- MISC FUNCTIONS END ---- >> ---- ---- >> ---- ---- >> ---- ---- >> ----


---- >> ---- ---- >> ---- ---- >> ---- ---- >> ---- CAM FUNCTIONS START ---- >> ---- ---- >> ---- ---- >> ---- ---- >> ----

function SmoothTeleportToCord(v3coords, teleportFrame)
    local wppos = v3coords
    local localped = getPlayerPed(players.user())
    if wppos ~= nil then --cam setup here
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
                    if not PED.IS_PED_IN_ANY_VEHICLE(localped, true) then --if they not in a vehicle
                        ENTITY.SET_ENTITY_COORDS(localped, tickCamCoord.x, tickCamCoord.y, tickCamCoord.z, false, false, false, false) --teleport the player
                    else
                        local veh = PED.GET_VEHICLE_PED_IS_IN(localped, false)
                        ENTITY.SET_ENTITY_COORDS(veh, tickCamCoord.x, tickCamCoord.y, tickCamCoord.z, false, false, false, false) --teleport the vehicle
                    end
                else
                    return false
                end
            end)
        end
        --
        local pc = getEntityCoords(getPlayerPed(players.user()))
        --
        for i = 0, 1, STP_SPEED_MODIFIER do --make the cam move up here
            CAM.SET_CAM_COORD(CCAM, pc.x, pc.y, pc.z + EaseOutCubic(i) * STP_COORD_HEIGHT)
            directx.draw_text(0.5, 0.5, tostring(EaseOutCubic(i) * STP_COORD_HEIGHT), 1, 0.6, WhiteText, false)
            local look = util.v3_look_at(CAM.GET_CAM_COORD(CCAM), pc)
            CAM.SET_CAM_ROT(CCAM, look.x, look.y, look.z, 2)
            wait()
        end
        --CAM.DO_SCREEN_FADE_OUT(1000) --fade out the screen
        ------------
        local currentZ = CAM.GET_CAM_COORD(CCAM).z
        local coordDiffx = wppos.x - pc.x
        local coordDiffxy = wppos.y - pc.y
        for i = 0, 1, STP_SPEED_MODIFIER / 2 do --make the camera on x/y plane
            CAM.SET_CAM_COORD(CCAM, pc.x + (EaseInOutCubic(i) * coordDiffx), pc.y + (EaseInOutCubic(i) * coordDiffxy), currentZ)
            wait()
        end
        -- local groundZ = PATHFIND.GET_APPROX_HEIGHT_FOR_POINT(wppos.x, wppos.y)
        -- ENTITY.SET_ENTITY_COORDS(localped, wppos.x, wppos.y, groundZ, false, false, false, false)
        local success, ground_z
        repeat
            STREAMING.REQUEST_COLLISION_AT_COORD(wppos.x, wppos.y, wppos.z)
            success, ground_z = util.get_ground_z(wppos.x, wppos.y)
            util.yield()
        until success
        if not PED.IS_PED_IN_ANY_VEHICLE(localped, true) then --if they not in a vehicle
            ENTITY.SET_ENTITY_COORDS(localped, wppos.x, wppos.y, ground_z, false, false, false, false) --teleport the player
        else
            local veh = PED.GET_VEHICLE_PED_IS_IN(localped, false)
            local v3Out = memory.alloc()
            local headOut = memory.alloc()
            PATHFIND.GET_CLOSEST_VEHICLE_NODE_WITH_HEADING(wppos.x, wppos.y, ground_z, v3Out, headOut, 1, 3.0, 0)
            local head = memory.read_float(headOut)
            memory.free(headOut)
            memory.free(v3Out)
            ENTITY.SET_ENTITY_COORDS(veh, wppos.x, wppos.y, ground_z, false, false, false, false) --teleport the vehicle
            ENTITY.SET_ENTITY_HEADING(veh, head)
        end
        wait()
        local pc2 = getEntityCoords(getPlayerPed(players.user()))
        local coordDiffz = CAM.GET_CAM_COORD(CCAM).z - ground_z -2
        local camcoordz = CAM.GET_CAM_COORD(CCAM).z
        --CAM.DO_SCREEN_FADE_IN(2000) --fade in the screen
        for i = 0, 1, STP_SPEED_MODIFIER / 2 do --move the camera down
            local pc23 = getEntityCoords(getPlayerPed(players.user()))-- extra for x/y
            CAM.SET_CAM_COORD(CCAM, pc23.x, pc23.y, camcoordz - (EaseOutCubic(i) * coordDiffz))
            wait()
        end
        -------------
        ----
        wait()
        --camera deletion here
        CAM.RENDER_SCRIPT_CAMS(false, false, 0, true, true, 0)
        if CAM.IS_CAM_ACTIVE(CCAM) then
            CAM.SET_CAM_ACTIVE(CCAM, false)
        end
        CAM.DESTROY_CAM(CCAM, true)
    else
        util.toast("没有设定标记点!")
    end
end

function SmoothTeleportToVehicle(pedInVehicle)
    local wppos = getEntityCoords(pedInVehicle)
    local localped = getPlayerPed(players.user())
    --check for emtpy seats
    local maxPassengers = VEHICLE.GET_VEHICLE_MAX_NUMBER_OF_PASSENGERS(veh)
    local seatFree = false
    local continueQ
    local veh = PED.GET_VEHICLE_PED_IS_IN(pedInVehicle, false)
    for i = -1, maxPassengers do --check for empty seats
        seatFree = VEHICLE.IS_VEHICLE_SEAT_FREE(veh, i, false)
        if seatFree then
            continueQ = true
        end
    end
    if seatFree == false then
        util.toast("所述车辆中没有座位.")
        continueQ = false
    end
    -- > --
    if wppos ~= nil then --cam setup here
        if not CAM.DOES_CAM_EXIST(CCAM) then
            CAM.DESTROY_ALL_CAMS(true)
            CCAM = CAM.CREATE_CAM("DEFAULT_SCRIPTED_CAMERA", true)
            CAM.SET_CAM_ACTIVE(CCAM, true)
            CAM.RENDER_SCRIPT_CAMS(true, false, 0, true, true, 0)
        end
        --
        local pc = getEntityCoords(getPlayerPed(players.user()))
        --
        for i = 0, 1, STP_SPEED_MODIFIER do --make the cam move up here
            CAM.SET_CAM_COORD(CCAM, pc.x, pc.y, pc.z + EaseOutCubic(i) * STP_COORD_HEIGHT)
            directx.draw_text(0.5, 0.5, tostring(EaseOutCubic(i) * STP_COORD_HEIGHT), 1, 0.6, WhiteText, false)
            local look = util.v3_look_at(CAM.GET_CAM_COORD(CCAM), pc)
            CAM.SET_CAM_ROT(CCAM, look.x, look.y, look.z, 2)
            wait()
        end
        --CAM.DO_SCREEN_FADE_OUT(1000) --fade out the screen
        ------------
        local currentZ = CAM.GET_CAM_COORD(CCAM).z
        local coordDiffx = wppos.x - pc.x
        local coordDiffxy = wppos.y - pc.y
        for i = 0, 1, STP_SPEED_MODIFIER / 2 do --make the camera on x/y plane
            CAM.SET_CAM_COORD(CCAM, pc.x + (EaseInOutCubic(i) * coordDiffx), pc.y + (EaseInOutCubic(i) * coordDiffxy), currentZ)
            wait()
        end
        PED.SET_PED_INTO_VEHICLE(localped, veh, i)
        if continueQ then
            wait()
            local pc2 = getEntityCoords(getPlayerPed(players.user()))
            local coordDiffz = CAM.GET_CAM_COORD(CCAM).z - pc2.z
            local camcoordz = CAM.GET_CAM_COORD(CCAM).z
            --CAM.DO_SCREEN_FADE_IN(2000) --fade in the screen
            for i = 0, 1, STP_SPEED_MODIFIER / 2 do --move the camera down
                local pc23 = getEntityCoords(pedInVehicle)-- extra for x/y
                CAM.SET_CAM_COORD(CCAM, pc23.x, pc23.y, camcoordz - (EaseOutCubic(i) * coordDiffz))
                wait()
            end
        end
        wait()
        --camera deletion here
        CAM.RENDER_SCRIPT_CAMS(false, false, 0, true, true, 0)
        if CAM.IS_CAM_ACTIVE(CCAM) then
            CAM.SET_CAM_ACTIVE(CCAM, false)
        end
        CAM.DESTROY_CAM(CCAM, true)
    else
        util.toast("没有设定标记点!")
    end
end

---- >> ---- ---- >> ---- ---- >> ---- ---- >> ---- CAM FUNCTIONS END ---- >> ---- ---- >> ---- ---- >> ---- ---- >> ----


---- >> ---- ---- >> ---- ---- >> ---- ---- >> ---- NETWORK FUNCTIONS START ---- >> ---- ---- >> ---- ---- >> ---- ---- >> ----

function FastNet(entity, playerID)
    local netID = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(entity)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
    if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) then
        for i = 1, 30 do
            if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) then
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
                wait(10)
            else
                goto continue
            end    
        end
    end
    ::continue::
    if SE_Notifications then
        util.toast("拥有控制权.")
    end
    NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(netID)
    wait(10)
    NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(netID)
    wait(10)
    NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netID, false)
    wait(10)
    NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(netID, playerID, true)
    wait(10)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(entity, true, false)
    wait(10)
    ENTITY._SET_ENTITY_CLEANUP_BY_ENGINE(entity, false)
    wait(10)
    if ENTITY.IS_ENTITY_AN_OBJECT(entity) then
        NETWORK.OBJ_TO_NET(entity)
    end
    wait(10)
    if BA_visible then
        ENTITY.SET_ENTITY_VISIBLE(entity, true, 0)
    else
        ENTITY.SET_ENTITY_VISIBLE(entity, false, 0)
        wait()
        ENTITY.SET_ENTITY_VISIBLE(entity, false, 0)
        wait()
        ENTITY.SET_ENTITY_VISIBLE(entity, false, 0)
    end
end

function NetIt(entity, playerID)
    local netID = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(entity)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
    if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) then
        for i = 1, 100 do
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
        wait(50)
        end
    else
        if SE_Notifications then
            util.toast("拥有控制权.")
        end
    end
    wait(10)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(netID)
    wait(10)
    NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(netID)
    wait(10)
    NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netID, false)
    wait(10)
    NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(netID, playerID, true)
    wait(10)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(entity, true, false)
    wait(10)
    ENTITY._SET_ENTITY_CLEANUP_BY_ENGINE(entity, false)
    wait(10)
    if ENTITY.IS_ENTITY_AN_OBJECT(entity) then
        NETWORK.OBJ_TO_NET(entity)
    end
    wait(10)
    if BA_visible then
        ENTITY.SET_ENTITY_VISIBLE(entity, true, 0)
    else
        ENTITY.SET_ENTITY_VISIBLE(entity, false, 0)
        wait()
        ENTITY.SET_ENTITY_VISIBLE(entity, false, 0)
        wait()
        ENTITY.SET_ENTITY_VISIBLE(entity, false, 0)
    end
end

function GetGamerHandleFromPlayer(playerID)
    local gmr_hndl = memory.alloc(104)
    NETWORK.NETWORK_HANDLE_FROM_PLAYER(playerID, gmr_hndl, 13)
    if NETWORK.NETWORK_IS_HANDLE_VALID(gmr_hndl, 13) then
        local gamerHandle = gmr_hndl
        memory.free(gmr_hndl)
        return gamerHandle
    else
        memory.free(gmr_hndl)
        util.toast("玩家移动失败!")
        return nil
    end
end

---- >> ---- ---- >> ---- ---- >> ---- ---- >> ---- NETWORK FUNCTIONS END ---- >> ---- ---- >> ---- ---- >> ---- ---- >> ----


---- >> ---- ---- >> ---- ---- >> ---- ---- >> ---- POSITION FUNCTIONS START ---- >> ---- ---- >> ---- ---- >> ---- ---- >> ----

function Get_Waypoint_Pos2()
    if HUD.IS_WAYPOINT_ACTIVE() then
        local blip = HUD.GET_FIRST_BLIP_INFO_ID(8)
        local waypoint_pos = HUD.GET_BLIP_COORDS(blip)
        return waypoint_pos
    else
        util.toast("没有设定标记点")
    end
end

function GetClosestPlayerWithRange(range)
    local pedPointers = entities.get_all_peds_as_pointers()
    local rangesq = range * range
    local ourCoords = getEntityCoords(GetLocalPed())
    local tbl = {}
    local closest_player = 0
    for i = 1, #pedPointers do
        local tarcoords = entities.get_position(pedPointers[i])
        local vdist = SYSTEM.VDIST2(ourCoords.x, ourCoords.y, ourCoords.z, tarcoords.x, tarcoords.y, tarcoords.z)
        if vdist <= rangesq then
            tbl[#tbl+1] = entities.pointer_to_handle(pedPointers[i])
        end
    end
    if tbl ~= nil then
        local dist = 999999
        for i = 1, #tbl do
            if tbl[i] ~= GetLocalPed() then
                if PED.IS_PED_A_PLAYER(tbl[i]) then
                    local tarcoords = getEntityCoords(tbl[i])
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

function GetClosestPlayerWithRange_Whitelist(range, inair) --variation of getClosestPlayerWithinRange to work with my whitelisting feature for silent aimbot
    local pedPointers = entities.get_all_peds_as_pointers()
    local rangesq = range * range
    local ourCoords = getEntityCoords(GetLocalPed())
    local tbl = {}
    local closest_player = 0
    for i = 1, #pedPointers do
        local tarcoords = entities.get_position(pedPointers[i])
        local vdist = SYSTEM.VDIST2(ourCoords.x, ourCoords.y, ourCoords.z, tarcoords.x, tarcoords.y, tarcoords.z)
        if vdist <= rangesq then
            local handle = entities.pointer_to_handle(pedPointers[i])
            if (inair and (ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(handle) >= 9)) or (not inair) then --air check
                local playerID = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(handle)
                if not AIM_WHITELIST[playerID] then --this is the whitelist check.
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
                    local tarcoords = getEntityCoords(tbl[i])
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

function GetSuitableAimbotTarget(fov, fovcheck, dist, loscheck)
    local ourped = GetLocalPed()
    local distsq = dist * dist
    local ourc = getEntityCoords(ourped)
    local entTable = entities.get_all_peds_as_pointers()
    local inRange = {}
    for _, entity in pairs(entTable) do

        local entpos = entities.get_position(entity)

            if SYSTEM.VDIST2(ourc.x, ourc.y, ourc.z, entpos.x, entpos.y, entpos.z) <= distsq then --distance check

                local handle = entities.pointer_to_handle(entity)
                if (handle ~= ourped) then
                    if (not PED.IS_PED_DEAD_OR_DYING(handle)) and (INTERIOR.GET_INTERIOR_FROM_ENTITY(handle) == 0) then --dead/interior check

                        if (fovcheck and PED.IS_PED_FACING_PED(ourped, handle, fov)) or (not fovcheck) then --fov check

                            if (PED.IS_PED_A_PLAYER(handle)) and (not AIM_WHITELIST[NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(handle)]) then --whitelist, player check

                                if (loscheck and ENTITY.HAS_ENTITY_CLEAR_LOS_TO_ENTITY(ourped, handle, 17)) or (not loscheck) then --line-of-sight check
                                    inRange[#inRange+1] = handle
                                end
                            end
                        end
                    end
                end
            end

    end
    local retplayer
    local d = 99999999999
    if #inRange ~= 0 then
        for _, ped in pairs(inRange) do
            local tc = getEntityCoords(ped)
            local vidsti = SYSTEM.VDIST2(ourc.x, ourc.y, ourc.z, tc.x, tc.y, tc.z)
            if vidsti < d then
                retplayer = ped
                d = vidsti
            end
        end
        return retplayer
    end
    return nil
end

function ShootSingleBulletBetweenCoords(coords1, coords2, dmg, weaponhash, ownerped, audible, invisible, speed)
    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(
        coords1.x, coords1.y, coords1.z,
        coords2.x, coords2.y, coords2.z,
        dmg, true, weaponhash, ownerped, audible, invisible, speed)
end

function ShootBulletAtPedBone(ped, boneID, dmg, weaponHash, speed)
    local bonecoords = PED.GET_PED_BONE_COORDS(ped, boneID, 0, 0, 0)
    local ourped = GetLocalPed()

    local ourhead = PED.GET_PED_BONE_COORDS(ourped, 12844, 0, 0, 0); local ourfront = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ourped, 0, 1, 0)
    ourfront.z = ourhead.z --to shoot out of infront of our head
    ShootSingleBulletBetweenCoords(ourfront, bonecoords, dmg, weaponHash, ourped, true, false, speed)
end

function GetClosestPlayerWithRange_Whitelist_DisallowEntities(range, disallowedEntities, inair) --variation of GetClosestPlayerWithRange_Whitelist, that makes entities not returned if they are in the table.
    local pedPointers = entities.get_all_peds_as_pointers()
    local rangesq = range * range
    local ourCoords = getEntityCoords(GetLocalPed())
    local tbl = {}
    local closest_player = 0
    for i = 1, #pedPointers do
        local tarcoords = entities.get_position(pedPointers[i])
        local vdist = SYSTEM.VDIST2(ourCoords.x, ourCoords.y, ourCoords.z, tarcoords.x, tarcoords.y, tarcoords.z)
        if vdist <= rangesq then
            local handle = entities.pointer_to_handle(pedPointers[i])
            local playerID = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(handle)
            if (inair and (ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(handle) >= 9)) or (not inair) then --air check
                if not AIM_WHITELIST[playerID] then --this is the whitelist check.
                    if not DoesTableContainValue(disallowedEntities, handle) then --this is the disallowed entities table check
                        tbl[#tbl+1] = handle
                    end
                end
            end
        end
    end
    if tbl ~= nil then
        local dist = 999999
        for i = 1, #tbl do
            if tbl[i] ~= GetLocalPed() then
                if PED.IS_PED_A_PLAYER(tbl[i]) then
                    local tarcoords = getEntityCoords(tbl[i])
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

function GetClosestNonPlayerPedWithRange(range)
    local pedPointers = entities.get_all_peds_as_pointers()
    local rangesq = range * range
    local ourCoords = getEntityCoords(GetLocalPed())
    local tbl = {}
    local closest_ped = 0
    for i = 1, #pedPointers do
        local tarcoords = entities.get_position(pedPointers[i])
        local vdist = SYSTEM.VDIST2(ourCoords.x, ourCoords.y, ourCoords.z, tarcoords.x, tarcoords.y, tarcoords.z)
        if vdist <= rangesq then
            tbl[#tbl+1] = entities.pointer_to_handle(pedPointers[i])
        end
    end
    if tbl ~= nil then
        local dist = 999999
        for i = 1, #tbl do
            if tbl[i] ~= GetLocalPed() then
                if not PED.IS_PED_A_PLAYER(tbl[i]) then
                    local tarcoords = getEntityCoords(tbl[i])
                    local e = SYSTEM.VDIST2(ourCoords.x, ourCoords.y, ourCoords.z, tarcoords.x, tarcoords.y, tarcoords.z)
                    if e < dist then
                        dist = e
                        closest_ped = tbl[i]
                    end
                end
            end
        end
    end
    if closest_ped ~= 0 then
        return closest_ped
    else
        return nil
    end
end

function GetClosestNonPlayerPedWithRange_DisallowedEntities(range, disallowedEntities, inair) --modified version of GetClosestNonPlayerPedWithRange that takes a table of disallowed entities (blacklisted peds)
    local pedPointers = entities.get_all_peds_as_pointers()
    local rangesq = range * range
    local ourCoords = getEntityCoords(GetLocalPed())
    local tbl = {}
    local closest_ped = 0
    for i = 1, #pedPointers do
        local tarcoords = entities.get_position(pedPointers[i])
        local vdist = SYSTEM.VDIST2(ourCoords.x, ourCoords.y, ourCoords.z, tarcoords.x, tarcoords.y, tarcoords.z)
        if vdist <= rangesq then
            local handle = entities.pointer_to_handle(pedPointers[i])
            if (inair and (ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(handle) >= 9)) or (not inair) then
                if not DoesTableContainValue(disallowedEntities, handle) then
                    tbl[#tbl+1] = handle
                end
            end
        end
    end
    if tbl ~= nil then
        local dist = 999999
        for i = 1, #tbl do
            if tbl[i] ~= GetLocalPed() then
                if not PED.IS_PED_A_PLAYER(tbl[i]) then
                    local tarcoords = getEntityCoords(tbl[i])
                    local e = SYSTEM.VDIST2(ourCoords.x, ourCoords.y, ourCoords.z, tarcoords.x, tarcoords.y, tarcoords.z)
                    if e < dist then
                        dist = e
                        closest_ped = tbl[i]
                    end
                end
            end
        end
    end
    if closest_ped ~= 0 then
        return closest_ped
    else
        return nil
    end
end

---- >> ---- ---- >> ---- ---- >> ---- ---- >> ---- POSITION FUNCTIONS START ---- >> ---- ---- >> ---- ---- >> ---- ---- >> ----

---- >> ---- ---- >> ---- ---- >> ---- ---- >> ---- MODEL FUNCTIONS START ---- >> ---- ---- >> ---- ---- >> ---- ---- >> ----

function RqModel (hash)
    STREAMING.REQUEST_MODEL(hash)
    local count = 0
    util.toast("请求模型中...")
    while not STREAMING.HAS_MODEL_LOADED(hash) and count < 100 do
        STREAMING.REQUEST_MODEL(hash)
        count = count + 1
        wait(10)
    end
    if not STREAMING.HAS_MODEL_LOADED(hash) then
        util.toast("已尝试1秒，无法加载此指定模型!")
    end
end

function SpawnObjectAtCoords(hash, v3Coords)
    RqModel(hash)
    local object = entities.create_object(hash, v3Coords)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
    return object
end

function SpawnPedOnPlayer(hash, pid)
    RqModel(hash)
    local lc = getEntityCoords(getPlayerPed(pid))
    local pe = entities.create_ped(26, hash, lc, 0)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
    return pe
end

function SpawnObjectOnPlayer(hash, pid)
    RqModel(hash)
    local lc = getEntityCoords(getPlayerPed(pid))
    local ob = entities.create_object(hash, lc)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
    return ob
end

function SpawnPickupOnPlayer(pickuphash, modelhash, value, pid)
    RqModel(modelhash)
    local pc = getEntityCoords(getPlayerPed(pid))
    OBJECT.CREATE_PICKUP(pickuphash, pc.x, pc.y, pc.z, 99999, value, true, modelhash)
end

---- >> ---- ---- >> ---- ---- >> ---- ---- >> ---- MODEL FUNCTIONS END ---- >> ---- ---- >> ---- ---- >> ---- ---- >> ----


---- >> ---- ---- >> ---- ---- >> ---- ---- >> ---- SUICIDE FUNCTIONS START ---- >> ---- ---- >> ---- ---- >> ---- ---- >> ----

function MakePlayerExplodeSuicide(pid)
    local playerPed = getPlayerPed(pid)
    local playerCoords = getEntityCoords(playerPed)
    -- checks for interior, godmode, and vehicle all in one if / elseif statement...
    if players.is_godmode(pid) and not players.is_in_interior(pid) then
        util.toast("玩家处于无敌,停止爆炸...")
    elseif players.is_in_interior(pid) then
        util.toast("玩家处于室内,停止爆炸...")
    elseif PED.IS_PED_IN_ANY_VEHICLE(playerPed, true) then
        for i = 0, 50, 1 do --50 explosions to account for armored vehicles, using type 5, as a tank shell as well xD
            SE_add_owned_explosion(playerPed, playerCoords.x, playerCoords.y, playerCoords.z, 5, 10, SEisExploAudible, SEisExploInvis, 0)
            wait(10)
        end
    else
        SE_add_owned_explosion(playerPed, playerCoords.x, playerCoords.y, playerCoords.z, 1, 10, SEisExploAudible, SEisExploInvis, 0)
    end
end

function MakePlayerMolotovSuicide(pid)
    local playerPed = getPlayerPed(pid)
    local playerCoords = getEntityCoords(playerPed)
    --checks for godmode and interior
    if players.is_godmode(pid) and not players.is_in_interior(pid) then
        util.toast("玩家处于无敌,停止爆炸...")
    elseif players.is_in_interior(pid) then
        util.toast("玩家处于室内,停止爆炸...")
    else
        SE_add_owned_explosion(playerPed, playerCoords.x, playerCoords.y, playerCoords.z, 3, 10, SEisExploAudible, SEisExploInvis, 0)
    end
end

---- >> ---- ---- >> ---- ---- >> ---- ---- >> ---- SUICIDE FUNCTIONS START ---- >> ---- ---- >> ---- ---- >> ---- ---- >> ----


---- >> ---- ---- >> ---- ---- >> ---- ---- >> ---- TOXIC FUNCTIONS START ---- >> ---- ---- >> ---- ---- >> ---- ---- >> ----

function EveryoneExplodeSuicides()
    for i = 0, 31, 1 do
        if players.exists(i) then --checks for if the PID exists in session
            local playerPed = getPlayerPed(i)
            local playerCoords = getEntityCoords(playerPed)
            if PED.IS_PED_IN_ANY_VEHICLE(playerPed, true) then
                for a = 0, 50, 1 do --50 explosions to account for armored vehicles, using type 5, as a tank shell as well xD
                    SE_add_owned_explosion(playerPed, playerCoords.x, playerCoords.y, playerCoords.z, 5, 10, SEisExploAudible, SEisExploInvis, 0)
                    wait(10)
                end
            else
                SE_add_owned_explosion(playerPed, playerCoords.x, playerCoords.y, playerCoords.z, 1, 10, SEisExploAudible, SEisExploInvis, 0)
            end
        end
    end
end

function PizzaCAll()
    for p = 0, 31, 1 do
        if p ~= players.user() and ENTITY.DOES_ENTITY_EXIST(getPlayerPed(p)) then
            for i = 1, 10 do
                local cord = getEntityCoords(getPlayerPed(p))
                requestModel(-930879665)
                wait(10)
                requestModel(3613262246)
                wait(10)
                requestModel(452618762)
                wait(10)
                while not hasModelLoaded(-930879665) do wait() end
                while not hasModelLoaded(3613262246) do wait() end
                while not hasModelLoaded(452618762) do wait() end
                local a1 = entities.create_object(-930879665, cord)
                wait(10)
                local a2 = entities.create_object(3613262246, cord)
                wait(10)
                local b1 = entities.create_object(452618762, cord)
                wait(10)
                local b2 = entities.create_object(3613262246, cord)
                wait(300)
                entities.delete_by_handle(a1)
                entities.delete_by_handle(a2)
                entities.delete_by_handle(b1)
                entities.delete_by_handle(b2)
                noNeedModel(452618762)
                wait(10)
                noNeedModel(3613262246)
                wait(10)
                noNeedModel(-930879665)
                wait(10)
            end
            if SE_Notifications then
                util.toast("玩家已完成 // " .. tostring(PLAYER.GET_PLAYER_NAME(p)) .. " // 的索引 " .. p)
            end
        end
    end
end

function FreemodeDeathAll()
    for p = 0, 31 do
        if p ~= players.user() and NETWORK.NETWORK_IS_PLAYER_CONNECTED(p) then
            for i = -1, 1 do
                for n = -1, 1 do
                    util.trigger_script_event(1 << p, {-65587051, 28, i, n})
                end
            end
            for i = -1, 1 do
                for n = -1, 1 do
                    util.trigger_script_event(1 << p, {1445703181, 28, i, n})
                end
            end
            wait(100)
            util.trigger_script_event(1 << p, {-290218924, -32190, -71399, 19031, 85474, 4468, -2112})
            util.trigger_script_event(1 << p, {-227800145, -1000000, -10000000, -100000000, -100000000, -100000000})
            util.trigger_script_event(1 << p, {2002459655, -1000000, -10000, -100000000})
            util.trigger_script_event(1 << p, {911179316, -38, -30, -75, -59, 85, 82})
        end
        for i = -1, 1 do
            for a = -1, 1 do
                util.trigger_script_event(1 << p, {916721383, i, a, 0, 26})
            end
        end
    end
end

TXC_SLOW = false
function AIOKickAll()
    menu.trigger_commands("scripthost")
    NETWORK.NETWORK_REQUEST_TO_BE_HOST_OF_THIS_SCRIPT()
    for i = 0, 31 do
        if i ~= players.user() and NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) then
            util.toast("玩家已连接 " .. tostring(PLAYER.GET_PLAYER_NAME(i) .. ", 开始 AIO."))
            util.trigger_script_event(1 << i, {0x37437C28, 1, 15, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {-1308840134, 1, 15, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {0x4E0350C6, 1, 15, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {-0x114C63AC, 1, 15, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {-0x15F5B1D4, 1, 15, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {-0x249FE11B, 1, 15, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {-0x76B11968, 1, 15, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {0x9C050EC, 1, 15, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {0x3B873479, 1, 15, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {0x23F74138, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
            wait(10) 
            --[[
            util.trigger_script_event(1 << i, {0xAD63290E, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
            wait(10) 
            ]]
            --[[
            util.trigger_script_event(1 << i, {0x39624029, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
            wait(10) 
            ]]
            util.trigger_script_event(1 << i, {-0x529CD6F2, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {-0x756DBC8A, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {-0x69532BA0, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {0x68C5399F, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {0x7DE8CAC0, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {0x285DDF33, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {-0x177132B8, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
            wait(10)
            --util.toast("主程序块完成. // AIO")
            util.trigger_script_event(1 << i, {memory.script_global(1893548 + (1 + (i * 600) + 511)), i})
            for a = -1, 1 do
                for n = -1, 1 do
                    util.trigger_script_event(1 << i, {-65587051, 28, a, n})
                    wait(10)
                end
            end
            --util.toast("第二块完成. // AIO")
            for a = -1, 1 do
                for n = -1, 1 do
                    util.trigger_script_event(1 << i, {1445703181, 28, a, n})
                    wait(10)
                end
            end
            --util.toast("第三块完成. // AIO")
            if TXC_SLOW then
                wait(10)
                util.trigger_script_event(1 << i, {-290218924, -32190, -71399, 19031, 85474, 4468, -2112})
                wait(10)
                util.trigger_script_event(1 << i, {-227800145, -1000000, -10000000, -100000000, -100000000, -100000000})
                wait(10)
                util.trigger_script_event(1 << i, {2002459655, -1000000, -10000, -100000000})
                wait(10)
                util.trigger_script_event(1 << i, {911179316, -38, -30, -75, -59, 85, 82})
                wait(10)
                --[[
                for n = -10, -7 do
                    for a = -60, 60 do
                        util.trigger_script_event(1 << i, {0x39624029, n, 623656, a, 73473741, -7, 856844, -51251, 856844})
                        wait(10)
                    end
                end
                ]]
                util.trigger_script_event(1 << i, {-290218924, -32190, -71399, 19031, 85474, 4468, -2112})
                wait(10)
                util.trigger_script_event(1 << i, {-1386010354, 91645, -99683, 1788, 60877, 55085, 72028})
                wait(10)
                util.trigger_script_event(1 << i, {-227800145, -1000000, -10000000, -100000000, -100000000, -100000000})
                wait(10)
                for g = -28, 0 do
                    for n = -1, 1 do
                        for a = -1, 1 do
                            util.trigger_script_event(1 << i, {1445703181, i, n, a})
                        end
                    end
                    wait(10)
                end
                --[[for a = -28, 20 do
                    for n = -10, 2 do
                        for b = -100, 100 do
                            util.trigger_script_event(1 << i, {-1782442696, b, n, a})
                            util.log("第六块,加载 " .. b)
                        end
                        util.log("第七块,加载 " .. n)
                    end
                    util.log("第八块,加载 " .. a)
                    wait(10)
                end]]
                for a = -11, 11 do
                    util.trigger_script_event(1 << i, {2002459655, -1000000, a, -100000000})
                end
                for a = -10, 10 do
                    for n = 30, -30 do
                        util.trigger_script_event(1 << i, {911179316, a, n, -75, -59, 85, 82})
                    end
                end
                for a = -10, 10 do
                    util.trigger_script_event(1 << i, {-65587051, a, -1, -1})
                end
                util.trigger_script_event(1 << i, {951147709, i, 1000000, nil, nil}) 
                for a = -10, 10 do
                    util.trigger_script_event(1 << i, {-1949011582, a, 1518380048})
                end
                for a = -10, 4 do
                    for n = -10, 5 do
                        util.trigger_script_event(1 << i, {1445703181, 28, a, n})
                    end
                end
            end
            util.toast("第四块完成. // AIO")
            util.toast("循环 " .. i .. " 完成AIO踢出.")
            util.toast("玩家 " .. PLAYER.GET_PLAYER_NAME(i) .. " 已完成.")
        end
    end
    wait(100)
end

function FreemodeDeathPlayer(pid)
    for i = -1, 1 do
        for n = -1, 1 do
            util.trigger_script_event(1 << pid, {-65587051, 28, i, n})
        end
    end
    for i = -1, 1 do
        for n = -1, 1 do
            util.trigger_script_event(1 << pid, {1445703181, 28, i, n})
        end
    end
    wait(100)
    util.trigger_script_event(1 << pid, {-290218924, -32190, -71399, 19031, 85474, 4468, -2112})
    util.trigger_script_event(1 << pid, {-227800145, -1000000, -10000000, -100000000, -100000000, -100000000})
    util.trigger_script_event(1 << pid, {2002459655, -1000000, -10000, -100000000})
    util.trigger_script_event(1 << pid, {911179316, -38, -30, -75, -59, 85, 82})
    for i = -1, 1 do
        for a = -1, 1 do
            util.trigger_script_event(1 << pid, {916721383, i, a, 0, 26})
        end
    end
end

function AIOKickPlayer(pid)
    if SE_Notifications then
        util.toast("玩家已连接 " .. tostring(PLAYER.GET_PLAYER_NAME(pid) .. ", 开始AIO."))
    end
    util.trigger_script_event(1 << pid, {0x37437C28, 1, 15, math.random(-2147483647, 2147483647)})
    wait(10) 
    util.trigger_script_event(1 << pid, {-1308840134, 1, 15, math.random(-2147483647, 2147483647)})
    wait(10) 
    util.trigger_script_event(1 << pid, {0x4E0350C6, 1, 15, math.random(-2147483647, 2147483647)})
    wait(10) 
    util.trigger_script_event(1 << pid, {-0x114C63AC, 1, 15, math.random(-2147483647, 2147483647)})
    wait(10) 
    util.trigger_script_event(1 << pid, {-0x15F5B1D4, 1, 15, math.random(-2147483647, 2147483647)})
    wait(10) 
    util.trigger_script_event(1 << pid, {-0x249FE11B, 1, 15, math.random(-2147483647, 2147483647)})
    wait(10) 
    util.trigger_script_event(1 << pid, {-0x76B11968, 1, 15, math.random(-2147483647, 2147483647)})
    wait(10) 
    util.trigger_script_event(1 << pid, {0x9C050EC, 1, 15, math.random(-2147483647, 2147483647)})
    wait(10) 
    util.trigger_script_event(1 << pid, {0x3B873479, 1, 15, math.random(-2147483647, 2147483647)})
    wait(10) 
    util.trigger_script_event(1 << pid, {0x23F74138, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
    wait(10) 
    --[[
    util.trigger_script_event(1 << pid, {0xAD63290E, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
    wait(10)
    ]]
    --[[ 
    util.trigger_script_event(1 << pid, {0x39624029, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
    wait(10) 
    ]]
    util.trigger_script_event(1 << pid, {-0x529CD6F2, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
    wait(10) 
    util.trigger_script_event(1 << pid, {-0x756DBC8A, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
    wait(10) 
    util.trigger_script_event(1 << pid, {-0x69532BA0, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
    wait(10) 
    util.trigger_script_event(1 << pid, {0x68C5399F, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
    wait(10) 
    util.trigger_script_event(1 << pid, {0x7DE8CAC0, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
    wait(10) 
    util.trigger_script_event(1 << pid, {0x285DDF33, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
    wait(10) 
    util.trigger_script_event(1 << pid, {-0x177132B8, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
    wait(10)
    --util.toast("主程序块完成. // AIO")
    util.trigger_script_event(1 << pid, {memory.script_global(1893548 + (1 + (pid * 600) + 511)), pid})
    for a = -1, 1 do
        for n = -1, 1 do
            util.trigger_script_event(1 << pid, {-65587051, 28, a, n})
            wait(10)
        end
    end
    --util.toast("第二块完成. // AIO")
    for a = -1, 1 do
        for n = -1, 1 do
            util.trigger_script_event(1 << pid, {1445703181, 28, a, n})
            wait(10)
        end
    end
    --util.toast("第三块完成. // AIO")
    if TXC_SLOW then
        wait(10)
        util.trigger_script_event(1 << pid, {-290218924, -32190, -71399, 19031, 85474, 4468, -2112})
        wait(10)
        util.trigger_script_event(1 << pid, {-227800145, -1000000, -10000000, -100000000, -100000000, -100000000})
        wait(10)
        util.trigger_script_event(1 << pid, {2002459655, -1000000, -10000, -100000000})
        wait(10)
        util.trigger_script_event(1 << pid, {911179316, -38, -30, -75, -59, 85, 82})
        wait(10)
        --[[
        for n = -10, -7 do
            for a = -60, 60 do
                util.trigger_script_event(1 << pid, {0x39624029, n, 623656, a, 73473741, -7, 856844, -51251, 856844})
                wait(10)
            end
        end]]
        util.trigger_script_event(1 << pid, {-290218924, -32190, -71399, 19031, 85474, 4468, -2112})
        wait(10)
        util.trigger_script_event(1 << pid, {-1386010354, 91645, -99683, 1788, 60877, 55085, 72028})
        wait(10)
        util.trigger_script_event(1 << pid, {-227800145, -1000000, -10000000, -100000000, -100000000, -100000000})
        wait(10)
        for g = -28, 0 do
            for n = -1, 1 do
                for a = -1, 1 do
                    util.trigger_script_event(1 << pid, {1445703181, g, n, a})
                end
            end
            wait(10)
        end
        --[[for a = -28, 20 do
            for n = -10, 2 do
                for b = -100, 100 do
                    util.trigger_script_event(1 << pid, {-1782442696, b, n, a})
                    util.log("第六块,加载 " .. b)
                end
                util.log("第七块,加载 " .. n)
            end
            util.log("第八块,加载 " .. a)
            wait(10)
        end]]
        for a = -11, 11 do
            util.trigger_script_event(1 << pid, {2002459655, -1000000, a, -100000000})
        end
        for a = -10, 10 do
            for n = 30, -30 do
                util.trigger_script_event(1 << pid, {911179316, a, n, -75, -59, 85, 82})
            end
        end
        for a = -10, 10 do
            util.trigger_script_event(1 << pid, {-65587051, a, -1, -1})
        end
        util.trigger_script_event(1 << pid, {951147709, pid, 1000000, nil, nil}) 
        for a = -10, 10 do
            util.trigger_script_event(1 << pid, {-1949011582, a, 1518380048})
        end
        for a = -10, 4 do
            for n = -10, 5 do
                util.trigger_script_event(1 << pid, {1445703181, 28, a, n})
            end
        end
    end
    if SE_Notifications then
        util.toast("第四块已完成. // AIO")
        util.toast("循环 " .. pid .. " 完成AIO踢出.")
        util.toast("玩家 " .. PLAYER.GET_PLAYER_NAME(pid) .. " 已完成.")
    end
end

function PlagueCrashPlayer(pid)
    for i = 1, 10 do
        local cord = getEntityCoords(getPlayerPed(pid))
        requestModel(-930879665)
        wait(10)
        requestModel(3613262246)
        wait(10)
        requestModel(452618762)
        wait(10)
        while not hasModelLoaded(-930879665) do wait() end
        while not hasModelLoaded(3613262246) do wait() end
        while not hasModelLoaded(452618762) do wait() end
        local a1 = entities.create_object(-930879665, cord)
        wait(10)
        local a2 = entities.create_object(3613262246, cord)
        wait(10)
        local b1 = entities.create_object(452618762, cord)
        wait(10)
        local b2 = entities.create_object(3613262246, cord)
        wait(300)
        entities.delete_by_handle(a1)
        entities.delete_by_handle(a2)
        entities.delete_by_handle(b1)
        entities.delete_by_handle(b2)
        noNeedModel(452618762)
        wait(10)
        noNeedModel(3613262246)
        wait(10)
        noNeedModel(-930879665)
        wait(10)
        end
        if SE_Notifications then
            util.toast("已完成.")
        end
end

function BadOutfitCrash(pid)
    RqModel(0x705E61F2)
    local pc = getEntityCoords(getPlayerPed(pid))
    local ped = PED.CREATE_PED(26, 0x705E61F2, pc.x, pc.y, pc.z, 0, true, false)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ped)
    PED.SET_PED_COMPONENT_VARIATION(ped, 0, 45, 0, 0)
    PED.SET_PED_COMPONENT_VARIATION(ped, 1, 197, 0, 0)
    PED.SET_PED_COMPONENT_VARIATION(ped, 2, 76, 0, 0)
    PED.SET_PED_COMPONENT_VARIATION(ped, 3, 196, 0, 0)
    PED.SET_PED_COMPONENT_VARIATION(ped, 4, 144, 0, 0)
    PED.SET_PED_COMPONENT_VARIATION(ped, 5, 99, 0, 0)
    PED.SET_PED_COMPONENT_VARIATION(ped, 6, 102, 0, 0)
    PED.SET_PED_COMPONENT_VARIATION(ped, 7, 151, 0, 0)
    PED.SET_PED_COMPONENT_VARIATION(ped, 8, 189, 0, 0)
    PED.SET_PED_COMPONENT_VARIATION(ped, 9, 56, 0, 0)
    PED.SET_PED_COMPONENT_VARIATION(ped, 10, 132, 0, 0)
    PED.SET_PED_COMPONENT_VARIATION(ped, 11, 393, 0, 0)
    wait(2000)
    entities.delete_by_handle(ped)
end
function BadNetVehicleCrash(pid)
    local hashes = {1492612435, 3517794615, 3889340782, 3253274834}
    local vehicles = {}
    for i = 1, 4 do
        util.create_thread(function()
            RqModel(hashes[i])
            local pcoords = getEntityCoords(getPlayerPed(pid))
            local veh =  VEHICLE.CREATE_VEHICLE(hashes[i], pcoords.x, pcoords.y, pcoords.z, math.random(0, 360), true, true, false)
            for a = 1, 20 do NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh) end
            VEHICLE.SET_VEHICLE_MOD_KIT(veh, 0)
            for j = 0, 49 do
                local mod = VEHICLE.GET_NUM_VEHICLE_MODS(veh, j) - 1
                VEHICLE.SET_VEHICLE_MOD(veh, j, mod, true)
                VEHICLE.TOGGLE_VEHICLE_MOD(veh, mod, true)
            end
            for j = 0, 20 do
                if VEHICLE.DOES_EXTRA_EXIST(veh, j) then VEHICLE.SET_VEHICLE_EXTRA(veh, j, true) end
            end
            VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(veh, false)
            VEHICLE.SET_VEHICLE_WINDOW_TINT(veh, 1)
            VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(veh, 1)
            VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(veh, " ")
            for ai = 1, 50 do
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
                pcoords = getEntityCoords(getPlayerPed(pid))
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, pcoords.x, pcoords.y, pcoords.z, false, false, false)
                util.yield()
            end
            vehicles[#vehicles+1] = veh
        end)
    end
    wait(2000)
    util.toast("已完成.")
    for _, v in pairs(vehicles) do
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(v)
        entities.delete_by_handle(v)
    end
end
function RopeCrashLobby(pid)
    PHYSICS.ROPE_LOAD_TEXTURES()
    local hashes = {2132890591, 2727244247}
    local pc = getEntityCoords(getPlayerPed(pid))
    local veh = VEHICLE.CREATE_VEHICLE(hashes[i], pc.x + 5, pc.y, pc.z, 0, true, true, false)
    local ped = PED.CREATE_PED(26, hashes[2], pc.x, pc.y, pc.z + 1, 0, true, false)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh); NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ped)
    ENTITY.SET_ENTITY_INVINCIBLE(ped, true)
    ENTITY.SET_ENTITY_VISIBLE(ped, false, 0)
    ENTITY.SET_ENTITY_VISIBLE(veh, false, 0)
    local rope = PHYSICS.ADD_ROPE(pc.x + 5, pc.y, pc.z, 0, 0, 0, 1, 1, 0.0000000000000000000000000000000000001, 1, 1, true, true, true, 1, true, 0)
    local vehc = getEntityCoords(veh); local pedc = getEntityCoords(ped)
    PHYSICS.ATTACH_ENTITIES_TO_ROPE(rope, veh, ped, vehc.x, vehc.y, vehc.z, pedc.x, pedc.y, pedc.z, 2, 0, 0, "Center", "Center")
    wait(1000)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh); NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ped)
    entities.delete_by_handle(veh); entities.delete_by_handle(ped)
    PHYSICS.DELETE_CHILD_ROPE(rope)
    PHYSICS.ROPE_UNLOAD_TEXTURES()
end

---- >> ---- ---- >> ---- ---- >> ---- ---- >> ---- TOXIC FUNCTIONS END ---- >> ---- ---- >> ---- ---- >> ---- ---- >> ----


---- >> ---- ---- >> ---- ---- >> ---- ---- >> ---- OTHER LOBBY FEATURES START ---- >> ---- ---- >> ---- ---- >> ---- ---- >> ----

function RemoveVehicleGodmodeForAll()
    for i = 0, 31 do
        if NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) then
            local ped = getPlayerPed(i)
            if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
                local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false)
                ENTITY.SET_ENTITY_CAN_BE_DAMAGED(veh, true)
                ENTITY.SET_ENTITY_INVINCIBLE(veh, false)
            end
        end
    end
end

VehTeleportLoadIterations = 20
function TeleportEveryonesVehicleToOcean()
    local oldcoords = getEntityCoords(GetLocalPed())
    for i = 0, 31 do
        if NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) then
            local ped = getPlayerPed(i)
            local pedCoords = getEntityCoords(ped)
            for c = 0, VehTeleportLoadIterations do --teleports us to them so we load their veh
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(GetLocalPed(), pedCoords.x, pedCoords.y, pedCoords.z + 10, false, false, false)
                wait(100)
            end
            if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
                local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false)
                for a = 0, 10 do
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
                    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, 4500, -4400, 4, false, false, false)
                    wait(100)
                end
                for b = 0, 10 do
                    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, 4500, -4400, 4, false, false, false)
                end
            end
        end
    end
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(GetLocalPed(), oldcoords.x, oldcoords.y, oldcoords.z, false, false, false)
end

function TeleportEveryonesVehicleToMazeBank()
    local oldcoords = getEntityCoords(GetLocalPed())
    for i = 0, 31 do
        if NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) then
            local pped = getPlayerPed(i)
            local pedCoords = getEntityCoords(pped)
            for c = 0, VehTeleportLoadIterations do --teleports us to them so we load their veh
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(GetLocalPed(), pedCoords.x, pedCoords.y, pedCoords.z + 10, false, false, false)
                wait(100)
            end
            if PED.IS_PED_IN_ANY_VEHICLE(pped, false) then
                local veh = PED.GET_VEHICLE_PED_IS_IN(pped, false)
                for a = 0, 10 do
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
                    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, -76, -819, 327, false, false, false)
                    wait(100)
                end
                for b = 0, 10 do
                    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, -76, -819, 327, false, false, false)
                end
            end
        end
    end
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(GetLocalPed(), oldcoords.x, oldcoords.y, oldcoords.z, false, false, false)
end

function CheckLobbyForGodmode()
    local godcount = 0
    for i = 0, 31 do
        if NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) then
            local pcoords = getEntityCoords(getPlayerPed(i))
            if INTERIOR.GET_INTERIOR_AT_COORDS(pcoords.x, pcoords.y, pcoords.z) == 0 then --check for non-interior. Using native for less false flags.
                if (not PLAYER.IS_PLAYER_READY_FOR_CUTSCENE(i)) and (not NETWORK.IS_PLAYER_IN_CUTSCENE(i)) then --check for cutscenes
                    if players.is_godmode(i) then --check the actual god
                        local pName = GetPlayerName_pid(i)
                        util.toast(pName .. " 处于无敌!")
                        godcount = godcount + 1
                        wait(100)
                    end
                end
            end
        end
    end
    util.toast(godcount .. " 处于无敌!")
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

---- >> ---- ---- >> ---- ---- >> ---- ---- >> ---- OTHER LOBBY FEATURES END ---- >> ---- ---- >> ---- ---- >> ---- ---- >> ----

---- >> ---- ---- >> ---- ---- >> ---- ---- >> ---- MISSILE SPEED FEATURES START ---- >> ---- ---- >> ---- ---- >> ---- ---- >> ----

function SetVehicleMissileSpeed(value)
    local offsets = {0x10D8, 0x70, 0x60, 0x58}
    local addr = entities.handle_to_pointer(PLAYER.PLAYER_PED_ID())
    for i = 1, (#offsets - 1) do
        -- make sure not to read from/write to a null pointer
        if addr == 0 then
            -- got a null pointer at some point
            return -1.0
        end
        addr = memory.read_long(addr + offsets[i])
    end
    addr = addr + offsets[#offsets]
    
    if addr == 0 then
        return -1.0
    else
        memory.write_float(addr, value)
        --memory.read_float(addr)
    end
end

function GetVehicleMissileSpeed()
    local offsets = {0x10D8, 0x70, 0x60, 0x58}
    local addr = entities.handle_to_pointer(PLAYER.PLAYER_PED_ID())
    for i = 1, (#offsets - 1) do
        -- make sure not to read from/write to a null pointer
        if addr == 0 then
            -- got a null pointer at some point
            return -1.0
        end
        addr = memory.read_long(addr + offsets[i])
    end
    addr = addr + offsets[#offsets]
    
    if addr == 0 then
        return -1.0
    else
        return memory.read_float(addr)
    end
end

---- >> ---- ---- >> ---- ---- >> ---- ---- >> ---- MISSILE SPEED FEATURES END ---- >> ---- ---- >> ---- ---- >> ---- ---- >> ----

---- >> ---- ---- >> ---- ---- >> ---- ---- >> ---- VEHICLE FEATURES START ---- >> ---- ---- >> ---- ---- >> ---- ---- >> ----

function GetClosestVehicleNodeWithHeading(x, y, z, nodeType)
    local outpos = v3.new()
    local outHeading = memory.alloc()
    PATHFIND.GET_CLOSEST_VEHICLE_NODE_WITH_HEADING(x, y, z, outpos, outHeading, nodeType, 3.0, 0)
    local pos = GetTableFromV3Instance(outpos); local heading = memory.read_float(outHeading)
    memory.free(outHeading); v3.free(outpos); return pos, heading
end

function UpsideDownVehicleRotationWithKeys()
    local veh = PED.GET_VEHICLE_PED_IS_IN(GetLocalPed(), false)
    local vv = ENTITY.GET_ENTITY_ROTATION(veh, 2)
    --Pitch: X || Roll: y || Yaw: z
    local vvPitch = v3.getX(vv)
    local vvRoll = v3.getY(vv)
    local vvYaw = v3.getZ(vv)
    ENTITY.SET_ENTITY_ROTATION(veh, 10, 179.5, vvYaw, 2, true)
    --rotation logic (left-right || YAW)
    if PAD.IS_CONTROL_PRESSED(0, 63) then --63 || INPUT_VEH_MOVE_LEFT_ONLY || A
            local yawAfterPress = vvYaw + 3
            if yawAfterPress > 180 then -- check for overflow
                local overFlowNeg = math.abs(vvYaw)*-1 --negative bypass overflow
                local toSetYaw = overFlowNeg + 3
                ENTITY.SET_ENTITY_ROTATION(veh, 10 --[[10]], 179.5, toSetYaw, 2, true)
            else --if not overflow
                ENTITY.SET_ENTITY_ROTATION(veh, 10 --[[10]], 179.5, yawAfterPress, 2, true)
            end
    end
    if PAD.IS_CONTROL_PRESSED(0, 64) then --64 ||INPUT_VEH_MOVE_RIGHT_ONLY || D
            local yawAfterPress = vvYaw - 3
            if yawAfterPress < -180 then -- check for overflow
                local overFlowNeg = math.abs(vvYaw) --positive bypass overflow
                local toSetYaw = overFlowNeg - 3
                ENTITY.SET_ENTITY_ROTATION(veh, 10 --[[10]], 179.5, toSetYaw, 2, true)
            else --if not overflow
                ENTITY.SET_ENTITY_ROTATION(veh, 10 --[[10]], 179.5, yawAfterPress, 2, true)
            end
    end
    if PAD.IS_CONTROL_PRESSED(0, 62) then --62 || INPUT_VEH_MOVE_DOWN_ONLY || LEFT CTRL / NUM5 (NOSE UP)
        local pitchAfterPress = vvPitch + 5
        if pitchAfterPress > 90 then --check for overflow
            --if pitch = 89, we add 3, we will get 88 for pitch. Distance to 90, then sub the rest.
            local pitchToSub = 90 - (3 - math.abs(90 - vvPitch))
            ENTITY.SET_ENTITY_ROTATION(veh, pitchToSub, 179.9, vvYaw)
        else
            --if not overflowed, then we just add.
            ENTITY.SET_ENTITY_ROTATION(veh, pitchAfterPress, 179.9, vvYaw)
        end
    end
    v3.free(vv)
end

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

function UnlockVehicleShoot()
    ::start::
    local localPed = GetLocalPed()
    if PED.IS_PED_SHOOTING(localPed) then
        local pointer = memory.alloc(4)
        local isEntFound = PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(players.user(), pointer)
        if isEntFound then
            local entity = memory.read_int(pointer)
            if ENTITY.IS_ENTITY_A_PED(entity) and PED.IS_PED_IN_ANY_VEHICLE(entity) then
                local vehicle = PED.GET_VEHICLE_PED_IS_IN(entity)
                ---------------------------------------------
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle)
                if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vehicle) then
                    for i = 1, 20 do
                        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vehicle)
                        wait(100)
                    end
                end
                if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vehicle) then
                    util.toast("Waited 2 secs, couldn't get control!")
                    goto start
                else
                    util.toast("拥有控制权.")
                end
                VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, 1)
                VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(vehicle, true)
                VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(vehicle, players.user(), false)
            elseif ENTITY.IS_ENTITY_A_VEHICLE(entity) then
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
                if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) then
                    for i = 1, 20 do
                        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
                        wait(100)
                    end
                end
                if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) then
                    util.toast("等待2秒,无法控制!")
                    memory.free(pointer)
                    goto start
                else
                    if SE_Notifications then
                        util.toast("拥有控制权.")
                    end
                end
                VEHICLE.SET_VEHICLE_DOORS_LOCKED(entity, 1)
                VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(entity, false)
                VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(entity, players.user(), false)
                VEHICLE.SET_VEHICLE_HAS_BEEN_OWNED_BY_PLAYER(veh, false)
            end
        end
        memory.free(pointer)
    end
end

function UnlockVehicleGetIn()
    ::start::
    local localPed = GetLocalPed()
    local veh = PED.GET_VEHICLE_PED_IS_TRYING_TO_ENTER(localPed)
    if PED.IS_PED_IN_ANY_VEHICLE(localPed, false) then
        local v = PED.GET_VEHICLE_PED_IS_IN(localPed, false)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED(v, 1)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(v, false)
        VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(v, players.user(), false)
        wait()
    else
        if veh ~= 0 then
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
            if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(veh) then
                for i = 1, 20 do
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
                    wait(100)
                end
            end
            if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(veh) then
                util.toast("等待2秒,无法控制!")
                goto start
            else
                if SE_Notifications then
                    util.toast("拥有控制权.")
                end
            end
            VEHICLE.SET_VEHICLE_DOORS_LOCKED(veh, 1)
            VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(veh, false)
            VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(veh, players.user(), false)
            VEHICLE.SET_VEHICLE_HAS_BEEN_OWNED_BY_PLAYER(veh, false)
        end
    end
end

function TurnCarOnInstantly()
    local localped = GetLocalPed()
    if PED.IS_PED_GETTING_INTO_A_VEHICLE(localped) then
        local veh = PED.GET_VEHICLE_PED_IS_ENTERING(localped)
        if not VEHICLE.GET_IS_VEHICLE_ENGINE_RUNNING(veh) then
            VEHICLE.SET_VEHICLE_FIXED(veh)
            VEHICLE.SET_VEHICLE_ENGINE_HEALTH(veh, 1000)
            VEHICLE.SET_VEHICLE_ENGINE_ON(veh, true, true, false)
        end
        if VEHICLE.GET_VEHICLE_CLASS(veh) == 15 then --15 is heli
            VEHICLE.SET_HELI_BLADES_FULL_SPEED(veh)
        end
    end
end

function PlaceWallInFrontOfPlayer(pid)
    local ped = getPlayerPed(pid)
    local forwardOffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0, 4, 0)
    local pheading = ENTITY.GET_ENTITY_HEADING(ped)
    local hash = 309416120
    requestModel(hash)
    while not hasModelLoaded(hash) do wait() end
    local a1 = OBJECT.CREATE_OBJECT(hash, forwardOffset.x, forwardOffset.y, forwardOffset.z - 1, true, true, true)
    ENTITY.SET_ENTITY_HEADING(a1, pheading + 90)
    FastNet(a1, pid)
    local b1 = OBJECT.CREATE_OBJECT(hash, forwardOffset.x, forwardOffset.y, forwardOffset.z + 1, true, true, true)
    ENTITY.SET_ENTITY_HEADING(b1, pheading + 90)
    FastNet(b1, pid)
    wait(500)
    entities.delete_by_handle(a1)
    entities.delete_by_handle(b1)
end

function DropVehicleOnPlayer(pid, name, invis)
    local ped = getPlayerPed(pid)
    local pc = getEntityCoords(ped)
    local hash = joaat(name)
    requestModel(hash)
    while not hasModelLoaded(hash) do wait() end
    local ourveh = VEHICLE.CREATE_VEHICLE(hash, pc.x, pc.y, pc.z + 5, 0, true, true, false)
    if invis then
        ENTITY.SET_ENTITY_VISIBLE(ourveh, false, 0)
    end
    noNeedModel(hash)
    wait(1200)
    entities.delete_by_handle(ourveh)
end

function TeleportPlayersVehicleToOcean(pid)
    local ped = getPlayerPed(pid)
    local pc = getEntityCoords(ped)
    local oldcoords = getEntityCoords(GetLocalPed())
    for o = 0, 10 do
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(GetLocalPed(), pc.x, pc.y, pc.z + 10, false, false, false)
        wait(50)
    end
    if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
        local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false)
        for a = 0, 10 do
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, 4500, -4400, 4, false, false, false)
            wait(100)
        end
        if SE_Notifications then
            util.toast("传送 " .. GetPlayerName_pid(pid) .. " 进入最遥远的海洋!")
        end
    else
        util.toast("玩家 " .. GetPlayerName_pid(pid) .. " 不在载具内!")
    end
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(GetLocalPed(), oldcoords.x, oldcoords.y, oldcoords.z, false, false, false)
end

function TeleportPlayersVehicleToMazeBank(pid)
    local ped = getPlayerPed(pid)
    local pc = getEntityCoords(ped)
    local oldcoords = getEntityCoords(GetLocalPed())
    for o = 0, 10 do
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(GetLocalPed(), pc.x, pc.y, pc.z + 10, false, false, false)
        wait(50)
    end
    if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
        local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false) 
        for a = 0, 10 do
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, -76, -819, 327, false, false, false)
            wait(100)
        end
        if SE_Notifications then
            util.toast("传送 " .. GetPlayerName_pid(pid) .. " 到花园银行楼顶!")
        end
    else
        util.toast("玩家 " .. GetPlayerName_pid(pid) .. " 不在载具内!")
    end
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(GetLocalPed(), oldcoords.x, oldcoords.y, oldcoords.z, false, false, false)
end

function FakeLagPlayerVehicle(pid)
    local ped = getPlayerPed(pid)
    if PED.IS_PED_IN_ANY_VEHICLE(ped) then
        local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false)
        local velocity = ENTITY.GET_ENTITY_VELOCITY(veh)
        local oldcoords = getEntityCoords(ped)
        wait(500)
        local nowcoords = getEntityCoords(ped)
        for a = 1, 10 do
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
            wait()
        end
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, oldcoords.x, oldcoords.y, oldcoords.z, false, false, false)
        wait(200)
        for b = 1, 10 do
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
            wait()
        end
        ENTITY.SET_ENTITY_VELOCITY(veh, velocity.x, velocity.y, velocity.z)
        for c = 1, 10 do
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
            wait()
        end
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, nowcoords.x, nowcoords.y, nowcoords.z, false, false, false)
        for d = 1, 10 do
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
            wait()
        end
        ENTITY.SET_ENTITY_VELOCITY(veh, velocity.x, velocity.y, velocity.z)
        wait(500)
    else
        util.toast("玩家 " .. GetPlayerName_pid(pid) .. " 不在载具内!")
    end
end

---- >> ---- ---- >> ---- ---- >> ---- ---- >> ---- VEHICLE FEATURES END ---- >> ---- ---- >> ---- ---- >> ---- ---- >> ----

---- >> ---- ---- >> ---- ---- >> ---- ---- >> ---- TOOL FEATURES START ---- >> ---- ---- >> ---- ---- >> ---- ---- >> ----

local function tpTableToPlayer(tbl, pid)
    if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) then
        local c = getEntityCoords(getPlayerPed(pid))
        for _, v in pairs(tbl) do
            if (not PED.IS_PED_A_PLAYER(v)) then
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(v, c.x, c.y, c.z, false, false, false)
            end
        end
    end
end
function TpAllPeds(player)
    local pedHandles = entities.get_all_peds_as_handles()
    tpTableToPlayer(pedHandles, player)
end
function TpAllVehs(player)
    local vehHandles = entities.get_all_vehicles_as_handles()
    tpTableToPlayer(vehHandles, player)
end
function TpAllObjects(player)
    local objHandles = entities.get_all_objects_as_handles()
    tpTableToPlayer(objHandles, player)
end
function TpAllPickups(player)
    local pickupHandles = entities.get_all_pickups_as_handles()
    tpTableToPlayer(pickupHandles, player)
end