--[[
--------------------------------
THIS FILE IS PART OF WIRISCRIPT
         Nowiry#2663
--------------------------------
]]

require "lib.GTSCRIPTS.O"

local self = {}
local version = 29
local UfoState <const> =
{
    nonExistent = -1,
    beingCreated = 0,
    onFlight = 1,
    beingDestroyed = 2,
    fadingIn = 3,
}
local state = UfoState.nonExistent
local vehicleHash <const> = util.joaat("hydra")
local objHash = util.joaat("imp_prop_ship_01a")
local jet = 0
local object = 0
local cam = 0
local targetVehicles = {}
local isCannonActive = false
local scaleform = 0
local sound <const> = {
    zoomOut = Sound.new("zoom_out_loop", "dlc_xm_orbital_cannon_sounds"),
    fireLoop = Sound.new("cannon_charge_fire_loop", "dlc_xm_orbital_cannon_sounds"),
    backgroundLoop = Sound.new("background_loop", "dlc_xm_orbital_cannon_sounds"),
    panLoop = Sound.new("pan_loop", "dlc_xm_orbital_cannon_sounds"),
    ufoAmbience = Sound.new("UFO_Ambience", "Sight_Seeing_Sounds"),
    abducted = Sound.new("Abducted", "Sight_Seeing_Sounds")
}
local sphereColour = {r = 0, g = 255, b = 255, a = 255}
local backholePos
local NULL <const> = 0
local zoomTimer <const> = newTimer()
local maxFov <const> = 110.0
local minFov <const> = 25.0
local lastZoom
local zoom = 0.0
local camFov = maxFov
local charge = 0.0
local countdown = 3 -- `seconds`
local isCounting = false
local lastShot <const> = newTimer()
local lastCountdown <const> = newTimer()
local rechargeDuration <const> = 2000 -- `ms`
local cameraRot = v3.new(-89.0, 0.0, 0.0)
local fadingTimer <const> = newTimer()
local effect = Effect.new("scr_xm_orbital", "scr_xm_orbital_blast")


self.exists = function ()
    return state ~= UfoState.nonExistent
end

self.create = function ()
    state = UfoState.beingCreated
end

---@param model string
self.setObjModel = function (model)
    objHash = util.joaat(model)
end

self.getVersion = function ()
    return version
end


---Returns the positive equivalent of a negative angle.
---@param value number #angle in `degrees`
---@return number
local makeAngPositive = function (value)
    if value < 0 then value = value + 360 end
    return value
end


local drawInstructionalButtons = function ()
    if  Instructional:begin() then
        Instructional.add_control(75, "BB_LC_EXIT")
        if isCannonActive then
            Instructional.add_control(69, "ORB_CAN_FIRE")
            Instructional.add_control(80, "Disable Cannon")
            if PAD.IS_USING_KEYBOARD_AND_MOUSE(0) then
                Instructional.add_control_group(29, "ORB_CAN_ZOOM")
            end
            Instructional.add_control_group(21, "HUD_INPUT101")
        else
            Instructional.add_control(119, "Vertical flight")
            Instructional.add_control(80, "Cannon")
            if #targetVehicles > 0 then
                Instructional.add_control(22, "Release vehicles")
            end
            if #targetVehicles < 15 then
                Instructional.add_control(73, "Tractor beam")
            end
        end
        Instructional:set_background_colour(0, 0, 0, 80)
        Instructional:draw()
    end
end


---@param address integer
---@return integer CPed*
local getVehicleDriver = function (address)
    if address == 0 then return 0 end
    return  memory.read_long(address + 0x0C48)
end


---@param address integer
---@return boolean
local isPedPlayer = function (address)
    return address ~= 0 and memory.read_long(address + 0x10A8) ~= 0
end


local setTractorBeamVehicles = function ()
    if #targetVehicles >= 16 then return end
    for _, vehicle in ipairs(entities.get_all_vehicles_as_handles()) do
        if #targetVehicles >= 16 then break end
        local distance = ENTITY.GET_ENTITY_COORDS(vehicle, false):distance(backholePos)

        if ENTITY.DOES_ENTITY_EXIST(vehicle) and vehicle ~= jet and distance < 80.0 and
        ENTITY.HAS_ENTITY_CLEAR_LOS_TO_ENTITY(object, vehicle, 17) then
            if Config.ufo.targetplayer then
                local pVehicle = entities.handle_to_pointer(vehicle)
                local pDriver = getVehicleDriver(pVehicle)
                if isPedPlayer(pDriver) and not table.find(targetVehicles, vehicle) then
                    table.insert(targetVehicles, vehicle)
                end
            elseif not table.find(targetVehicles, vehicle) then
                table.insert(targetVehicles, vehicle)
            end
        end
    end
end


---@param x number
local easeOutExpo = function (x)
    return x >= 1.0 and 1.0 or 1 - 2^(-10 * x)
end


local tractorBeam = function ()
    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(jet, 0.0, 0.0, -8.0)
    backholePos = pos
    if not isCannonActive then
        draw_marker(28, pos, 1.0, sphereColour)
        rainbow_colour(sphereColour)
    end

    if PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, 73) then
        setTractorBeamVehicles()
    elseif PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, 22) then
        targetVehicles = {}
    end

    for i = #targetVehicles, 1, -1 do
        local vehicle = targetVehicles[i]
        local vehiclePos = ENTITY.GET_ENTITY_COORDS(vehicle, false)
        local distance = vehiclePos:distance(pos)

        if ENTITY.DOES_ENTITY_EXIST(vehicle) and distance < 200 then
            request_control_once(vehicle)
            local delta = v3.new(pos)
            delta:sub(vehiclePos)
            local multiplier = easeOutExpo(distance / 50.0) * 2.5
            delta:mul(multiplier)
            local vel = ENTITY.GET_ENTITY_VELOCITY(jet)
            vel:add(delta)
            ENTITY.SET_ENTITY_VELOCITY(vehicle, vel.x, vel.y, vel.z)
            ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(vehicle, jet, true)
        else table.remove(targetVehicles, i) end
    end
end


---@param pos Vector3
---@param hudColour integer
local drawLockonSprite = function (pos, hudColour, alpha)
    local colour = get_hud_colour(hudColour)
    local txdSizeX = 0.013
    local txdSizeY = 0.013 * WIRI.GET_ASPECT_RATIO(false)
    GRAPHICS.SET_DRAW_ORIGIN(pos.x, pos.y, pos.z, 0)
    size = 0.015
    GRAPHICS.DRAW_SPRITE("helicopterhud", "hud_corner", -size * 0.5, -size, txdSizeX, txdSizeY, 0.0, colour.r, colour.g, colour.b, alpha, true, 0)
    GRAPHICS.DRAW_SPRITE("helicopterhud", "hud_corner",  size * 0.5, -size, txdSizeX, txdSizeY, 90.0, colour.r, colour.g, colour.b, alpha, true, 0)
    GRAPHICS.DRAW_SPRITE("helicopterhud", "hud_corner", -size * 0.5,  size, txdSizeX, txdSizeY, 270., colour.r, colour.g, colour.b, alpha, true, 0)
    GRAPHICS.DRAW_SPRITE("helicopterhud", "hud_corner",  size * 0.5,  size, txdSizeX, txdSizeY, 180., colour.r, colour.g, colour.b, alpha, true, 0)
    GRAPHICS.CLEAR_DRAW_ORIGIN()
end


---@param distance number
---@return integer
local getAlphaFromDistance = function (distance, min, max)
    local alpha = 255
    if distance > max then
        alpha = 0
    elseif distance < min then
        alpha = 255
    else
        local perc = 1.0 - (distance - min) / (max - min)
        alpha = math.ceil(alpha * perc)
    end
    return alpha
end


---Function from heli_gun script
---@param entity Entity
---@param hudColour HudColour
local drawDirectionalArrowForEntity = function (entity, hudColour)
    local entPos = ENTITY.GET_ENTITY_COORDS(entity, false)
    local ptr = memory.alloc(4)
    if not GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(entPos.x, entPos.y, entPos.z, ptr, ptr) then
        local colour = get_hud_colour(hudColour)
        local cam = CAM.GET_RENDERING_CAM()
        local camPos = CAM.GET_CAM_COORD(cam)
        local camRot = CAM.GET_CAM_ROT(cam, 2)
        camRot:mul(math.pi / 180)
        local deltaXY = v3.new(entPos.x, entPos.y, 0.0)
        deltaXY:sub(v3.new(camPos.x, camPos.y, 0.0))
        local distanceXY = deltaXY:magnitude()
        local distanceZ = entPos.z - camPos.z

        local elevation
        if distanceZ > 0.0 then
            elevation = math.atan(distanceZ / distanceXY)
        else
            elevation = 0.0
        end

        local azimuth
        if deltaXY.y ~= 0.0 then
            azimuth = math.atan(deltaXY.x, deltaXY.y)
        elseif deltaXY.x < 0.0 then
            azimuth = -math.pi / 2
        else
            azimuth = math.pi / 2
        end

        local angle = math.atan(
            math.cos(camRot.x) * math.sin(elevation) - math.sin(camRot.x) * math.cos(elevation) * math.cos(-azimuth - camRot.z),
            math.sin(-azimuth - camRot.z) * math.cos(elevation)
        )
        local screenX = 0.5 - math.cos(angle) * 0.29
        local screenY = 0.5 - math.sin(angle) * 0.29
        local alpha = getAlphaFromDistance(distanceXY, 500, 1000)
        GRAPHICS.DRAW_SPRITE("helicopterhud", "hudArrow", screenX, screenY, 0.02, 0.04, math.deg(angle) - 90.0, colour.r, colour.g, colour.b, alpha, false, 0)
    end
end


local drawSpriteOnPlayers = function ()
    if Config.ufo.disableboxes or
    not GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED("helicopterhud") then
        return
    end
    for _, player in pairs(players.list(false)) do
        local playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player)
        if is_player_active(player, true, true) and not is_player_in_any_interior(player) and
        not ENTITY.IS_ENTITY_DEAD(playerPed, false) and get_distance_between_entities(playerPed, players.user_ped()) < 1000 then
            local playerPos = players.get_position(player)
            local myPos = players.get_position(players.user())
            local distance = myPos:distance(playerPos)
            local hudColour = is_player_friend(player) and HudColour.friendly or HudColour.green
            drawLockonSprite(playerPos, hudColour, getAlphaFromDistance(distance, 500, 1000))
            if isCannonActive then drawDirectionalArrowForEntity(playerPed, hudColour) end
        end
    end
end


local setCannonCamZoom = function ()
    if not PAD.IS_USING_KEYBOARD_AND_MOUSE(0) then
        return
    end
    if PAD.IS_CONTROL_JUST_PRESSED(0, 241) and zoom < 1.0 then
        zoom = zoom + 0.25
        zoomTimer.reset()
    end
    if PAD.IS_CONTROL_JUST_PRESSED(0, 242) and zoom > 0.0 then
        zoom = zoom - 0.25
        zoomTimer.reset()
    end
    if zoom ~= lastZoom then
        sound.zoomOut:play()
        GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "SET_ZOOM_LEVEL")
        GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_FLOAT(zoom)
        GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
        lastZoom = zoom
    end
    local fovTarget = interpolate(maxFov, minFov, zoom)
	local fov = CAM.GET_CAM_FOV(CAM.GET_RENDERING_CAM())
    if fovTarget ~= fov and zoomTimer.elapsed() <= 300 then
        camFov = interpolate(fov, fovTarget, zoomTimer.elapsed() / 300)
        CAM.SET_CAM_FOV(CAM.GET_RENDERING_CAM(), camFov)
    else
        sound.zoomOut:stop()
    end
end


local function setCannonCamRot()
    local mult = 1.0
    local axisX = PAD.GET_CONTROL_UNBOUND_NORMAL(0, 220)
    local axisY = PAD.GET_CONTROL_UNBOUND_NORMAL(0, 221)
    local pitch
    local heading
    local frameTime <const> = 30 * MISC.GET_FRAME_TIME()
    local maxRotX <const> = -25.0
    local minRotX <const> = -89.0

    if PAD.IS_USING_KEYBOARD_AND_MOUSE(0) then
		mult = 3.0
		axisX = axisX * mult
		axisY = axisY * mult
	end

    if PAD.IS_LOOK_INVERTED() then
        axisY = -axisY
    end

    if axisX ~= 0 or axisY ~= 0 then
        heading = -(axisX * 0.05) * frameTime * 25
        pitch = -(axisY * 0.05) * frameTime * 25
        cameraRot:add(v3.new(pitch, 0, heading))

        if cameraRot.x > maxRotX then
            cameraRot.x = maxRotX
        elseif cameraRot.x < minRotX then
            cameraRot.x = minRotX
        end

        sound.panLoop:play()
        WIRI.HARD_ATTACH_CAM_TO_ENTITY(cam, jet, cameraRot.x, cameraRot.y, cameraRot.z, 0.0, 0.0, -4.0, true)
    else
        sound.panLoop:stop()
    end

    local heading = makeAngPositive(CAM.GET_CAM_ROT(cam, 2).z)
    HUD.LOCK_MINIMAP_ANGLE(math.ceil(heading))
end


local doCannon = function ()
    if not GRAPHICS.HAS_SCALEFORM_MOVIE_LOADED(scaleform) then
        scaleform = request_scaleform_movie("ORBITAL_CANNON_CAM")

    elseif not isCannonActive then
        if CAM.IS_CAM_RENDERING(cam) then
            GRAPHICS.CLEAR_TIMECYCLE_MODIFIER()
            CAM.RENDER_SCRIPT_CAMS(false, false, 0, true, false, 0)
        end

        if AUDIO.IS_AUDIO_SCENE_ACTIVE("DLC_BTL_Hacker_Drone_HUD_Scene") then
            AUDIO.STOP_AUDIO_SCENE("DLC_BTL_Hacker_Drone_HUD_Scene")
        end

        sound.panLoop:stop()
        sound.zoomOut:stop()
        sound.fireLoop:stop()
        sound.backgroundLoop:stop()

    else
        if not CAM.IS_CAM_RENDERING(cam) then
            GRAPHICS.SET_TIMECYCLE_MODIFIER("eyeinthesky")
            CAM.RENDER_SCRIPT_CAMS(true, false, 0, true, false, 0)
        end

        for n = 1, 6 do PAD.DISABLE_CONTROL_ACTION(0, n, true) end
        PAD.DISABLE_CONTROL_ACTION(0, 85, true)
        PAD.DISABLE_CONTROL_ACTION(0, 122, true)
        HudTimer.DisableThisFrame()
        setCannonCamRot()
        setCannonCamZoom()

        GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "SET_STATE")
        GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(3)
        GRAPHICS.END_SCALEFORM_MOVIE_METHOD()

        GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "SET_CHARGING_LEVEL")
        GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_FLOAT(charge)
        GRAPHICS.END_SCALEFORM_MOVIE_METHOD()

        if PAD.IS_CONTROL_PRESSED(0, 69) or countdown == 0 then
            local raycastResult = get_raycast_result(1000.0)
            local pos = raycastResult.endCoords

            if charge == 1.0 then
                if not isCounting then
                    sound.fireLoop:play()
                    lastCountdown.reset()
                    isCounting = true
                end

                if countdown ~= 0 then
                    if lastCountdown.elapsed() >= 1000 then
                        countdown = countdown - 1
                        lastCountdown.reset()
                    end
                    GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "SET_COUNTDOWN")
                    GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(countdown)
                    GRAPHICS.END_SCALEFORM_MOVIE_METHOD()

                elseif STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(effect.asset) then
                    charge = 0.0
                    countdown = 3
                    isCounting = false
                    local rot = raycastResult.surfaceNormal:toRot()
                    rot.x = rot.x - 90.0

                    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 59, 1.0, true, false, 1.0, false)
                    GRAPHICS.USE_PARTICLE_FX_ASSET(effect.asset)
                    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
                        effect.name, pos.x, pos.y, pos.z, rot.x, rot.y, rot.z, 1.0, false, false, false, true
                    )
                    AUDIO.PLAY_SOUND_FROM_COORD(-1, "DLC_XM_Explosions_Orbital_Cannon", pos.x, pos.y, pos.z, NULL, true, 0, false)
                    CAM.SHAKE_CAM(cam, "GAMEPLAY_EXPLOSION_SHAKE", 1.5)
                    lastShot.reset()
                else
                    STREAMING.REQUEST_NAMED_PTFX_ASSET(effect.asset)
                end

            elseif charge ~= 1.0 then
                charge = interpolate(0.0, 1.0, lastShot.elapsed() / rechargeDuration)
                sound.fireLoop:stop()
                countdown = 3
                isCounting = false
            end

        elseif charge ~= 1.0 or isCounting then
            charge = interpolate(0.0, 1.0, lastShot.elapsed() / rechargeDuration)
            AUDIO.SET_VARIABLE_ON_SOUND(sound.fireLoop.Id, "Firing", 0.0)
            sound.fireLoop:stop()
            countdown = 3
            isCounting = false
        end

        if not AUDIO.IS_AUDIO_SCENE_ACTIVE("DLC_BTL_Hacker_Drone_HUD_Scene") then
            AUDIO.START_AUDIO_SCENE("DLC_BTL_Hacker_Drone_HUD_Scene")
        end
        sound.backgroundLoop:play()
        STREAMING.CLEAR_FOCUS()
        GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(scaleform, 255, 255, 255, 255, 0)
    end
end


---@param vehicle Vehicle
---@param value number
local setVehicleCamDistance = function (vehicle, value)
    if vehicle == 0 then return end
    local addr = memory.read_long(entities.handle_to_pointer(vehicle) + 0x20)
	if addr ~= NULL then
        memory.write_float(addr + 0x38, value)
    end
end


local destroy = function()
    for _, s in pairs(sound) do s:stop() end
    STREAMING.CLEAR_FOCUS()
    AUDIO.STOP_AUDIO_SCENE("DLC_BTL_Hacker_Drone_HUD_Scene")
    AUDIO.RELEASE_NAMED_SCRIPT_AUDIO_BANK("DLC_CHRISTMAS2017/XM_ION_CANNON")
    GRAPHICS.CLEAR_TIMECYCLE_MODIFIER()

    set_streamed_texture_dict_as_no_longer_needed("helicopterhud")
    set_scaleform_movie_as_no_longer_needed(scaleform)
    scaleform = 0

    if ENTITY.DOES_ENTITY_EXIST(jet) then
        request_control_once(jet)
        setVehicleCamDistance(jet, -1.57)
        entities.delete_by_handle(jet)
        jet = 0
    end

    if ENTITY.DOES_ENTITY_EXIST(object) then
        request_control_once(object)
        entities.delete_by_handle(object)
        object = 0
    end

    local pos = players.get_position(players.user())
    local ok, groundZ = util.get_ground_z(pos.x, pos.y)
    if ok then pos.z = groundZ end
    local outCoords = v3.new()
    if PATHFIND.GET_CLOSEST_VEHICLE_NODE(pos.x, pos.y, pos.z, outCoords, 1, 100.0, 2.5) then
        pos = outCoords
    end
    ENTITY.SET_ENTITY_COORDS(players.user_ped(), pos.x, pos.y, pos.z, false, false, false, true)
    ENTITY.SET_ENTITY_VISIBLE(players.user_ped(), true, true)
    PED.REMOVE_PED_HELMET(players.user_ped(), true)
    DisableOTR()

    CAM.SET_CAM_ACTIVE(cam, false)
    CAM.RENDER_SCRIPT_CAMS(false, false, -1, true, false, 0)
    CAM.DESTROY_CAM(cam, false)
    cam = 0
    HUD.UNLOCK_MINIMAP_ANGLE()
    targetVehicles = {}
    isCannonActive = false
end


self.mainLoop = function ()
    if state == UfoState.beingCreated then
        if not CAM.IS_SCREEN_FADED_OUT() then
            CAM.DO_SCREEN_FADE_OUT(800)
        else
            if not ENTITY.DOES_ENTITY_EXIST(jet) then
                request_model(vehicleHash)
                request_model(objHash)
                local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
                jet = entities.create_vehicle(vehicleHash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
                ENTITY.SET_ENTITY_VISIBLE(jet, false, false)
                ENTITY.SET_ENTITY_VISIBLE(players.user_ped(), false, true)

                VEHICLE.SET_VEHICLE_ENGINE_ON(jet, true, true, true)
                ENTITY.SET_ENTITY_INVINCIBLE(jet, true)
                VEHICLE.SET_PLANE_TURBULENCE_MULTIPLIER(jet, 0.0)
                setVehicleCamDistance(jet, -20.0)

                object = entities.create_object(objHash, pos)
                ENTITY.ATTACH_ENTITY_TO_ENTITY(object, jet, 0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, true, false, false, 0, true, 0)
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(jet, pos.x, pos.y, pos.z + 200, false, false, true)
                PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), jet, -1)

                CAM.DESTROY_ALL_CAMS(true)
                cam = CAM.CREATE_CAM("DEFAULT_SCRIPTED_CAMERA", false)
                cameraRot:set(-89.0, 0, 0)
                WIRI.HARD_ATTACH_CAM_TO_ENTITY(cam, jet, -89.0, 0.0, 0.0, 0.0, 0.0, -4.0, true)
                CAM.SET_CAM_FOV(cam, camFov)
                CAM.SET_CAM_ACTIVE(cam, true)

                request_streamed_texture_dict("helicopterhud")
                AUDIO.REQUEST_SCRIPT_AUDIO_BANK("DLC_CHRISTMAS2017/XM_ION_CANNON", false, -1)
                AUDIO.SET_AUDIO_FLAG("DisableFlightMusic", true)

                fadingTimer.reset()
            elseif fadingTimer.elapsed() > 1200 then
                state = UfoState.onFlight
                CAM.DO_SCREEN_FADE_IN(800)
            end
        end

    elseif state == UfoState.onFlight then
        if ENTITY.IS_ENTITY_VISIBLE(jet) then ENTITY.SET_ENTITY_VISIBLE(jet, false, true) end
        PAD.DISABLE_CONTROL_ACTION(0, 75, true)
		PAD.DISABLE_CONTROL_ACTION(0, 80, true)
		PAD.DISABLE_CONTROL_ACTION(0, 99, true)

        VEHICLE.DISABLE_VEHICLE_WEAPON(true, util.joaat("vehicle_weapon_player_lazer"), jet, players.user_ped())
		VEHICLE.DISABLE_VEHICLE_WEAPON(true, util.joaat("vehicle_weapon_space_rocket"), jet, players.user_ped())
        WIRI.DISABLE_CINEMATIC_BONNET_CAMERA_THIS_UPDATE()

		if PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, 75) or get_vehicle_player_is_in(PLAYER.PLAYER_ID()) ~= jet then
            CAM.DO_SCREEN_FADE_OUT(500)
		end

        if CAM.IS_SCREEN_FADED_OUT() then
            state = UfoState.beingDestroyed
        end

		if PAD.IS_CONTROL_JUST_PRESSED(0, 80) or PAD.IS_CONTROL_JUST_PRESSED(0, 45) then
            if isCannonActive then
                cameraRot:set(-89.0, 0.0, 0.0)
                WIRI.HARD_ATTACH_CAM_TO_ENTITY(cam, jet, -89.0, 0.0, 0.0, 0.0, 0.0, -4.0, true)
            end
            AUDIO.PLAY_SOUND_FRONTEND(-1, "cannon_active", "dlc_xm_orbital_cannon_sounds", true);
            zoom = 0.0
            CAM.SET_CAM_FOV(cam, maxFov)
			isCannonActive = not isCannonActive
            STREAMING.CLEAR_FOCUS()
            HUD.UNLOCK_MINIMAP_ANGLE()
		end

        if sound.ufoAmbience:hasFinished() then
            sound.ufoAmbience:play()
        end

        tractorBeam()
        drawSpriteOnPlayers()
        doCannon()
        drawInstructionalButtons()
        HudTimer.SetHeightMultThisFrame(1)
        EnableOTR()
        DisablePhone()

    elseif state == UfoState.beingDestroyed then
        destroy()
        if  CAM.IS_SCREEN_FADED_OUT() then
            fadingTimer.reset()
            state = UfoState.fadingIn
        end

    elseif state == UfoState.fadingIn then
        if  fadingTimer.elapsed() > 1200 then
            CAM.DO_SCREEN_FADE_IN(500)
            state = UfoState.nonExistent
        end
    end
end


self.destroy = function ()
    if not self.exists() then
        return
    end
    CAM.DO_SCREEN_FADE_IN(0)
    destroy()
    state = UfoState.nonExistent
end

return self