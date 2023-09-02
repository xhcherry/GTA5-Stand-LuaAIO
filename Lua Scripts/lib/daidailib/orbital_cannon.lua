require "lib.daidailib.functions"

local self = {}
local version = 27
local targetId = -1
local cam = 0
local zoomLevel = 0.0
local scaleform = 0
local maxFov = 110
local minFov = 25
local camFov = maxFov
local zoomTimer = newTimer()
local canZoom = false -- 不使用键盘时使用
local State =
{
    NonExistent = -1,
    FadingOut = 0,
    CreatingCam = 1,
    LoadingScene = 2,
    FadingIn = 3,
    Charging = 4,
    Spectating = 5,
    Shooting = 6,
    FadingOut2 = 7,
    Destroying = 8,
    FadingIn2 = 9
}
local sounds = {
	zoomOut = Sound.new("zoom_out_loop", "dlc_xm_orbital_cannon_sounds"),
	activating = Sound.new("cannon_activating_loop", "dlc_xm_orbital_cannon_sounds"),
	backgroundLoop = Sound.new("background_loop", "dlc_xm_orbital_cannon_sounds"),
	fireLoop = Sound.new("cannon_charge_fire_loop", "dlc_xm_orbital_cannon_sounds")
}
local countdown = 3 -- `seconds`
local isCounting = false
local lastCountdown = newTimer()
local state = State.NonExistent
local chargeLevel = 0.0
local timer = newTimer()
local didShoot = false
local NULL = 0
local becomeOrbitalCannon = menu.ref_by_path("Online>Become The Orbital Cannon", 38)
local orbitalBlast = Effect.new("scr_xm_orbital", "scr_xm_orbital_blast")
local newSceneStart = newTimer()
local chargeTimer = newTimer()
local isRelocating = false
local noTargetTimer = newTimer()


self.exists = function ()
    return state ~= State.NonExistent
end

self.getVersion = function ()
    return version
end

---@param playSound boolean
local DispatchZoomLevel = function (playSound)
    if playSound then sounds.zoomOut:play() end
    GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "SET_ZOOM_LEVEL")
    GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_FLOAT(zoomLevel)
    GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
    zoomTimer.reset()
end


local SetCannonCamZoom = function ()
    local fovTarget = interpolate(maxFov, minFov, zoomLevel)
    local fov = CAM.GET_CAM_FOV(cam)
    if fovTarget ~= fov then
        camFov = interpolate(fov, fovTarget, zoomTimer.elapsed() / 200)
        CAM.SET_CAM_FOV(cam, camFov)
        return
    else
        sounds.zoomOut:stop()
    end

    if PAD.IS_USING_KEYBOARD_AND_MOUSE(2) then
        if PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, 241) and zoomLevel < 1.0 then
            zoomLevel = zoomLevel + 0.25
            DispatchZoomLevel(true)
        elseif PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, 242) and
        zoomLevel > 0.0 then
            zoomLevel = zoomLevel - 0.25
            DispatchZoomLevel(true)
        end
    elseif canZoom then
        local controlNormal = PAD.GET_CONTROL_NORMAL(0, 221)
        if controlNormal > 0.3 and canZoom and zoomLevel < 1.0 then
            zoomLevel = zoomLevel + 0.25
            DispatchZoomLevel(true)
            canZoom = false
        elseif controlNormal < -0.3 and canZoom and zoomLevel > 0.0 then
            zoomLevel = zoomLevel - 0.25
            DispatchZoomLevel(true)
            canZoom = false
        end
    elseif PAD.GET_CONTROL_NORMAL(0, 221) == 0 then
        canZoom = true
    end
end


---@param pos Vector3
---@param size number
---@param hudColour integer
local DrawLockonSprite = function (pos, size, hudColour)
    local colour = get_hud_colour(hudColour)
    local txdSizeX = 0.013
    local txdSizeY = 0.013 * GRAPHICS.GET_ASPECT_RATIO(false)
    GRAPHICS.SET_DRAW_ORIGIN(pos.x, pos.y, pos.z, 0)
    size = (size * 0.03)
    GRAPHICS.DRAW_SPRITE("helicopterhud", "hud_corner", -size * 0.5, -size, txdSizeX, txdSizeY, 0.0, colour.r, colour.g, colour.b, colour.a, true, 0)
    GRAPHICS.DRAW_SPRITE("helicopterhud", "hud_corner",  size * 0.5, -size, txdSizeX, txdSizeY, 90.0, colour.r, colour.g, colour.b, colour.a, true, 0)
    GRAPHICS.DRAW_SPRITE("helicopterhud", "hud_corner", -size * 0.5,  size, txdSizeX, txdSizeY, 270., colour.r, colour.g, colour.b, colour.a, true, 0)
    GRAPHICS.DRAW_SPRITE("helicopterhud", "hud_corner",  size * 0.5,  size, txdSizeX, txdSizeY, 180., colour.r, colour.g, colour.b, colour.a, true, 0)
    GRAPHICS.CLEAR_DRAW_ORIGIN()
end


local DisableControlActions = function ()
    PAD.DISABLE_CONTROL_ACTION(0, 142, true)
    PAD.DISABLE_CONTROL_ACTION(0, 141, true)
    PAD.DISABLE_CONTROL_ACTION(0, 140, true)
    PAD.DISABLE_CONTROL_ACTION(0, 24, true)
    PAD.DISABLE_CONTROL_ACTION(0, 84, true)
    PAD.DISABLE_CONTROL_ACTION(0, 85, true)
    PAD.DISABLE_CONTROL_ACTION(0, 263, true)
    PAD.DISABLE_CONTROL_ACTION(0, 264, true)
    PAD.DISABLE_CONTROL_ACTION(0, 143, true)
    PAD.DISABLE_CONTROL_ACTION(0, 200, true)
    PAD.DISABLE_CONTROL_ACTION(0, 257, true)
    PAD.DISABLE_CONTROL_ACTION(0, 99, true)
    PAD.DISABLE_CONTROL_ACTION(0, 115, true)
    HUD.HUD_SUPPRESS_WEAPON_WHEEL_RESULTS_THIS_FRAME()
end


---@param distance number
---@return integer
function GetArrowAlpha(distance)
    local alpha = 255
    local maxDistance = 2500
    local minDistance = 1000
    if distance > maxDistance then
        alpha = 0
    elseif distance < minDistance then
        alpha = 255
    else
        local perc = 1.0 - (distance - minDistance) / (maxDistance - minDistance)
        alpha = math.ceil(alpha * perc)
    end
    return alpha
end


---@param message string
---@param duration integer
local DisplayHelpMessage = function (message, duration)
    HUD.BEGIN_TEXT_COMMAND_DISPLAY_HELP(message)
    HUD.END_TEXT_COMMAND_DISPLAY_HELP(0, false, true, duration)
end


---@param entity Entity
---@param hudColour HudColour
function DrawDirectionalArrowForEntity(entity, hudColour)
    local entPos = ENTITY.GET_ENTITY_COORDS(entity, false)
    local screenX, screenY = memory.alloc(4), memory.alloc(4)
    if not GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(entPos.x, entPos.y, entPos.z, screenX, screenY) then
        local colour = get_hud_colour(hudColour)
        local camPos = CAM.GET_CAM_COORD(cam)
        local camRot = v3.new(-math.pi/2, 0, 0)
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
            azimuth = -90.0
        else
            azimuth = 90.0
        end

        local angle = math.atan(
            math.cos(camRot.x) * math.sin(elevation) - math.sin(camRot.x) * math.cos(elevation) * math.cos(-azimuth - camRot.z),
            math.sin(-azimuth - camRot.z) * math.cos(elevation)
        )
        local screenX = 0.5 - math.cos(angle) * 0.19
        local screenY = 0.5 - math.sin(angle) * 0.19
        local colourA = GetArrowAlpha(distanceXY)
        GRAPHICS.DRAW_SPRITE("helicopterhud", "hudArrow", screenX, screenY, 0.02, 0.04, math.deg(angle) - 90.0, colour.r, colour.g, colour.b, colourA, false, 0)
    end
end


---@param player Player
---@return boolean
local IsPlayerActive = function (player)
    if NETWORK.NETWORK_IS_PLAYER_ACTIVE(player) then
        return true
    end
    return false
end


function DrawMarkersOnPlayers()
    for _, player in ipairs(players.list()) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(player)
        if PED.IS_PED_INJURED(ped) or not IsPlayerActive(player) or player == targetId then
            continue
        end
        if GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED("helicopterhud") then
            local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
            local txdScale = interpolate(1.0, 0.5, camFov / maxFov)
            DrawLockonSprite(pos, txdScale, HudColour.green)
            DrawDirectionalArrowForEntity(ped, HudColour.green)
        end
    end
end


Destroy = function ()
    sounds.backgroundLoop:stop()
    sounds.fireLoop:stop()
    sounds.zoomOut:stop()
    sounds.activating:stop()

    PLAYER.DISABLE_PLAYER_FIRING(players.user(), false)
    menu.set_value(becomeOrbitalCannon, false)

    GRAPHICS.ANIMPOSTFX_STOP("MP_OrbitalCannon")
    MISC.CLEAR_OVERRIDE_WEATHER()
    GRAPHICS.CASCADE_SHADOWS_SET_AIRCRAFT_MODE(false)
    AUDIO.STOP_AUDIO_SCENE("dlc_xm_orbital_cannon_camera_active_scene")
    AUDIO.RELEASE_NAMED_SCRIPT_AUDIO_BANK("DLC_CHRISTMAS2017/XM_ION_CANNON")

    CAM.RENDER_SCRIPT_CAMS(false, false, 0, true, false, 0)
    if  CAM.DOES_CAM_EXIST(cam) then
        CAM.SET_CAM_ACTIVE(cam, false)
        CAM.DESTROY_CAM(cam, false)
    end
    STREAMING.CLEAR_FOCUS()
    NETWORK.NETWORK_SET_IN_FREE_CAM_MODE(false)
    set_scaleform_movie_as_no_longer_needed(scaleform)

    targetId = -1
    scaleform = 0
    isRelocating = false
    zoomLevel = 0.0
    chargeLevel = 0.0
    didShoot = false
    camFov = maxFov
    countdown = 3
    timer.disable()
    chargeTimer.disable()
    noTargetTimer.disable()
end


local DrawInstructionalButtons = function()
    if  Instructional:begin() then
        Instructional.add_control(202, "HUD_INPUT3")
        if not PAD.IS_USING_KEYBOARD_AND_MOUSE(0) then
            Instructional.add_control(221, "ORB_CAN_ZOOM")
        else
            Instructional.add_control(242, "ORB_CAN_ZOOMO")
            Instructional.add_control(241, "ORB_CAN_ZOOMI")
        end
        Instructional.add_control(24, "ORB_CAN_FIRE")
        Instructional:set_background_colour(0, 0, 0, 80)
        Instructional:draw()
    end
end


---@param state integer
local SetCannonState = function (state)
    GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "SET_STATE")
    GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(state)
    GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
end


self.destroy = function ()
    if not CAM.IS_SCREEN_FADED_IN() then CAM.DO_SCREEN_FADE_IN(0) end
    Destroy()
    state = State.NonExistent
end


---@param target Player
self.create = function (target)
    if target == targetId or self.exists() then
        return
    end
    AUDIO.PLAY_SOUND_FRONTEND(-1, "menu_select", "dlc_xm_orbital_cannon_sounds", true)
    targetId = target
    state = State.FadingOut
end


self.mainLoop  = function ()
    if state == State.NonExistent then
        -- Do nothing
    elseif not CAM.DOES_CAM_EXIST(cam) then
        sounds.activating:play()

        cam = CAM.CREATE_CAM("DEFAULT_SCRIPTED_CAMERA", false)
        local pos = players.get_position(targetId)
        CAM.SET_CAM_COORD(cam, pos.x, pos.y, pos.z + 300.0)
        CAM.SET_CAM_ROT(cam, -90.0, 0.0, 0.0, 2)
        CAM.SET_CAM_FOV(cam, maxFov)
        CAM.SET_CAM_ACTIVE(cam, true)

        AUDIO.REQUEST_SCRIPT_AUDIO_BANK("DLC_CHRISTMAS2017/XM_ION_CANNON", false, -1)
        request_streamed_texture_dict("helicopterhud")
        scaleform = request_scaleform_movie("ORBITAL_CANNON_CAM")
        AUDIO.START_AUDIO_SCENE("dlc_xm_orbital_cannon_camera_active_scene")
        menu.set_value(becomeOrbitalCannon, true)
        DispatchZoomLevel(false)
        state = State.FadingOut

    elseif not GRAPHICS.HAS_SCALEFORM_MOVIE_LOADED(scaleform) then
        scaleform = request_scaleform_movie("ORBITAL_CANNON_CAM")

    else
        local myPos = players.get_position(players.user())
        STREAMING.REQUEST_COLLISION_AT_COORD(myPos.x, myPos.y, myPos.z)
        SetCannonState(4)

        if util.is_session_transition_active() then
            Destroy()
            state = State.NonExistent
        end

        if PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, 202) then
            timer.reset()
            state = State.FadingOut2
        end

        if state == State.FadingOut then
            if not CAM.IS_SCREEN_FADED_OUT() then
                CAM.DO_SCREEN_FADE_OUT(500)
            else
                isRelocating = false
                state = State.LoadingScene
            end

        elseif state == State.LoadingScene then
            local pos = players.get_position(targetId)
            STREAMING.NEW_LOAD_SCENE_START_SPHERE(pos.x, pos.y, pos.z, 300.0, 0)
            STREAMING.SET_FOCUS_POS_AND_VEL(pos.x, pos.y, pos.z, 5.0, 0.0, 0.0)
            NETWORK.NETWORK_SET_IN_FREE_CAM_MODE(true)
            timer.disable()
            newSceneStart.reset()
            state = State.FadingIn

        elseif state == State.FadingIn then
            if not CAM.IS_SCREEN_FADED_OUT() then
                -- 如果出于某种原因，游戏的屏幕会逐渐消失
                -- before we do
                CAM.DO_SCREEN_FADE_OUT(0)
            elseif not timer.isEnabled() then
                if  STREAMING.IS_NEW_LOAD_SCENE_LOADED() or newSceneStart.elapsed() > 10000 then
                    STREAMING.NEW_LOAD_SCENE_STOP()
                    timer.reset()
                end
            elseif timer.elapsed() > 2000 then
                CAM.DO_SCREEN_FADE_IN(500)
                CAM.RENDER_SCRIPT_CAMS(true, false, 0, true, false, 0)
                sounds.activating:stop()
                sounds.backgroundLoop:play()
                GRAPHICS.ANIMPOSTFX_PLAY("MP_OrbitalCannon", 0, true)
                MISC.SET_OVERRIDE_WEATHER("Clear")
                GRAPHICS.CASCADE_SHADOWS_SET_AIRCRAFT_MODE(true)
                state = State.Charging
            end

            local pos = players.get_position(targetId)
            CAM.SET_CAM_COORD(cam, pos.x, pos.y, pos.z + 300.0)

        elseif state == State.Charging then
            if chargeLevel == 100 then
                state = State.Spectating
            elseif not chargeTimer.isEnabled() then
                chargeTimer.reset()
            elseif chargeTimer.elapsed() < 3000 then
                chargeLevel = interpolate(0.0, 100.0, chargeTimer.elapsed() / 3000)
            else
                chargeLevel = 100.0
                AUDIO.PLAY_SOUND_FRONTEND(-1, "cannon_active", "dlc_xm_orbital_cannon_sounds", true)
                chargeTimer.disable()
                state = State.Spectating
            end

            local pos = players.get_position(targetId)
            CAM.SET_CAM_COORD(cam, pos.x, pos.y, pos.z + 300.0)
            SetCannonCamZoom()

        elseif state == State.Spectating then
            local camPos = CAM.GET_CAM_COORD(cam)
            local ptr = memory.alloc(4)
            MISC.GET_GROUND_Z_EXCLUDING_OBJECTS_FOR_3D_COORD(camPos.x, camPos.y, camPos.z, ptr, false, false)
            local groundZ = memory.read_float(ptr)
            STREAMING.SET_FOCUS_POS_AND_VEL(camPos.x, camPos.y, groundZ, 5.0, 0.0, 0.0)

            if PAD.IS_DISABLED_CONTROL_PRESSED(0, 69) then
                if not isCounting then
                    PAD.SET_CONTROL_SHAKE(0, 1000, 50)
                    sounds.fireLoop:play()
                    isCounting = true
                    lastCountdown.reset()
                end

                if lastCountdown.elapsed() > 1000 and countdown > 0 then
                    countdown = countdown - 1
                    lastCountdown.reset()
                elseif countdown == 0 then
                    sounds.fireLoop:stop()
                    timer.reset()
                    state = State.Shooting
                end

                GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "SET_COUNTDOWN")
                GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(countdown)
                GRAPHICS.END_SCALEFORM_MOVIE_METHOD()

            elseif isCounting then
                AUDIO.SET_VARIABLE_ON_SOUND(sounds.fireLoop.Id, "Firing", 0.0)
                sounds.fireLoop:stop()
                countdown = 3
                isCounting = false
            end

            SetCannonCamZoom()
            if not IsPlayerActive(targetId) then--玩家未处于活动状态显示目标丢失
                if not noTargetTimer.isEnabled() then
                    DisplayHelpMessage("ORB_CAN_NO_TARG", 5000)
                    noTargetTimer.reset()
                elseif noTargetTimer.elapsed() > 3000 then
                    timer.reset()
                    noTargetTimer.disable()
                    state = State.FadingOut2
                end

            elseif PED.IS_PED_FATALLY_INJURED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(targetId)) then
                if not noTargetTimer.isEnabled() then
                    isRelocating = true
                    DisplayHelpMessage("ORB_CAN_DEAD", 5000)
                    noTargetTimer.reset()
                elseif noTargetTimer.elapsed() > 30000 then
                    isRelocating = false
                    timer.reset()
                    state = State.FadingOut2
                end

            elseif isRelocating then
                noTargetTimer.disable()
                state = State.FadingOut

            else
                local pos = players.get_position(targetId)
                CAM.SET_CAM_COORD(cam, pos.x, pos.y, pos.z + 300.0)
            end

        elseif state == State.Shooting then
            if STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(orbitalBlast.asset) then
                chargeLevel = 0.0
                local pos = players.get_position(targetId)
                FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), pos.x, pos.y, pos.z, 59, 1.0, true, false, 1.0)
                GRAPHICS.USE_PARTICLE_FX_ASSET(orbitalBlast.asset)
                GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
                    orbitalBlast.name, pos.x, pos.y, pos.z, 0.0, 0.0, 0.0, 1.0, false, false, false, true
                )
                AUDIO.PLAY_SOUND_FROM_COORD(-1, "DLC_XM_Explosions_Orbital_Cannon", pos.x, pos.y, pos.z, NULL, true, 0, false)
                CAM.SHAKE_CAM(cam, "GAMEPLAY_EXPLOSION_SHAKE", 1.5)
                PAD.SET_CONTROL_SHAKE(0, 500, 256)
                timer.reset()
                state = State.FadingOut2
                didShoot = true
            else
                STREAMING.REQUEST_NAMED_PTFX_ASSET(orbitalBlast.asset)
            end

        elseif state == State.FadingOut2 then
            if CAM.IS_SCREEN_FADED_OUT() then
                timer.reset()
                STREAMING.CLEAR_FOCUS()
                state = State.FadingIn2
            elseif not didShoot or timer.elapsed() > 2000 then
                CAM.DO_SCREEN_FADE_OUT(500)
            end

        elseif state == State.FadingIn2 then
            if timer.elapsed() > 2000 then
                CAM.RENDER_SCRIPT_CAMS(false, false, 0, true, false, 0)
                CAM.DO_SCREEN_FADE_IN(500)
                state = State.Destroying
            end

        elseif state == State.Destroying then
            Destroy()
            state = State.NonExistent
            return
        end

        DisableControlActions()
        HUD.HIDE_HUD_AND_RADAR_THIS_FRAME()
        DrawInstructionalButtons()
        HudTimer.DisableThisFrame()
        DisablePhone()

        if state ~= State.FadingOut or isRelocating then
            GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "SET_CHARGING_LEVEL")
            GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_FLOAT(chargeLevel / 100)
            GRAPHICS.END_SCALEFORM_MOVIE_METHOD()

            GRAPHICS.SET_SCRIPT_GFX_DRAW_ORDER(0)
            GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(scaleform, 255, 255, 255, 255, 0)
            DrawMarkersOnPlayers()
        end
    end
end

return self