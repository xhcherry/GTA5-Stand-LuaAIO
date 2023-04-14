--[[
--------------------------------
THIS FILE IS PART OF WIRISCRIPT
        Nowiry#2663
--------------------------------
]]

require "lib.GTSCRIPTS.O"


local self = {}
local version = 29
local MissileState <const> =
{
    nonExistent = -1,
    beingCreated = 0,
    onFlight = 1,
    exploting = 2,
    disconnecting = 3,
    beingDestroyed = 4
}
local BoundsState <const> =
{
    inBounds = 0,
    gettingOut = 1,
    outOfBounds = 2,
}
local state = MissileState.nonExistent
local object
local camera
local blip
local startPos
local timer <const> = newTimer()
local fxAsset <const> = "scr_xs_props"
local objHash <const> = util.joaat("xs_prop_arena_airmissile_01a")
local scaleform = 0
local effects = {missile_trail = -1}
local sounds <const> =
{
    startUp     = Sound.new("HUD_Startup", "DLC_Arena_Piloted_Missile_Sounds"),
    outOfBounds = Sound.new("Out_Of_Bounds_Alarm_Loop", "DLC_Arena_Piloted_Missile_Sounds"),
    staticLoop  = Sound.new("HUD_Static_Loop", "DLC_Arena_Piloted_Missile_Sounds"),
    disconnect  = Sound.new("HUD_Disconnect", "DLC_Arena_Piloted_Missile_Sounds")
}


self.exists = function ()
    return state ~= MissileState.nonExistent
end

self.create = function ()
    if not self.exists() then
        state = MissileState.beingCreated
    end
end

self.getVersion = function ()
    return version
end


local function invertHeading(heading)
    if heading > 180.0 then
        return (heading - 180.0)
    end
    return (heading + 180.0)
end

local function currectRotation(value)
    if value > 180 then
        value = value - 360
    end
    if value < -180 then
        value = value + 360
    end
    return value
end

local function drawInstructionalButtons()
    if Instructional:begin() then
        Instructional.add_control_group(20, "DRONE_SPACE")
        Instructional.add_control_group(21, "DRONE_POSITION")
        if not PAD.IS_USING_KEYBOARD_AND_MOUSE(0) then
            Instructional.add_control(208, "DRONE_SPEEDU")
            Instructional.add_control(207, "DRONE_SLOWD")
        else
            Instructional.add_control(209, "DRONE_SPEEDU")
            Instructional.add_control(210, "DRONE_SLOWD")
        end
        Instructional.add_control(75, "MOVE_DRONE_RE")
        Instructional:set_background_colour(0, 0, 0, 80)
        Instructional:draw()
    end
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(6)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(7)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(9)
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(8)
    HudTimer.SetHeightMultThisFrame(1)
end


local function getScriptAxes()
    local leftX  = PAD.GET_CONTROL_UNBOUND_NORMAL(0, 218)
	local leftY  = PAD.GET_CONTROL_UNBOUND_NORMAL(0, 219)
	local rightX = PAD.GET_CONTROL_UNBOUND_NORMAL(0, 220)
	local rightY = PAD.GET_CONTROL_UNBOUND_NORMAL(0, 221)
    return leftX, leftY, rightX, rightY
end


local function setMissileRotation()
    local max <const> = 40.0
    local mult = 1.0
    local axisX = 0.0
    local axisY = 0.0
    local pitch
    local roll
    local heading
    local frameTime <const> = 30 * MISC.GET_FRAME_TIME()
    local entityRoll <const> = ENTITY.GET_ENTITY_ROLL(object)
	local entityPitch <const> = ENTITY.GET_ENTITY_PITCH(object)
    local leftX, leftY, rightX, rightY = getScriptAxes()

    if PAD.IS_USING_KEYBOARD_AND_MOUSE(0) then
		mult = 3.0
		rightX = rightX * mult
		rightY = rightY * mult
	end
    if PAD.IS_LOOK_INVERTED() then
        rightY = - rightY
		leftY  = - leftY
    end
    if (rightX ~= 0 or rightY ~= 0) or (leftX ~= 0 or leftY ~= 0) then
        if rightX ~= 0 then
            axisX = rightX
        elseif leftX ~= 0 then
            axisX = leftX
        else
            axisX = 0
        end
        if rightY ~= 0 then
            axisY = rightY
        elseif leftY ~= 0 then
            axisY = leftY
        else
            axisY = 0
        end

        local entRot = ENTITY.GET_ENTITY_ROTATION(object, 2)
        heading = -(axisX * 0.05) * frameTime * 20
        pitch = (axisY * 0.05) * frameTime * 20

        if (entityRoll ~= 0 or rightX ~= 0) or leftX ~= 0 then
            if rightX ~= 0 then
                axisX = rightX
                roll = -(axisX * 0.05) * frameTime * (max - 25.0)
            elseif leftX ~= 0 then
                axisX = leftX
                roll = -(axisX * 0.05) * frameTime * (max - 25.0)
            else
                if entRot.y ~= 0 then
                    if entRot.y < 0 then
                        axisX = -1.0
                    else
                        axisX = 1.0
                    end
                else
                    axisX = 0.0
                end
                if entRot.y ~= 0 then
                    if entRot.y < 2.0 and entRot.y > 0.0 then
                        axisX = 0.0001
                    elseif entRot.y > -2.0 and entRot.y < 0.0 then
                        axisX = -0.0001
                    end
                else
                    axisX = 0.0
                end
                roll = -(axisX * 0.05) * frameTime * (max - 25)
            end
        else
            roll = 0.0
        end
        local rot = v3.new(pitch, roll, heading)
        rot:add(entRot)
        if rot.y > max then
            rot.y = max
        elseif rot.y < -max then
            rot.y = -max
        end
        if rot.x > 80 then
            rot.x = 80
        elseif rot.x < -max then
            rot.x = -max
        end
        ENTITY.SET_ENTITY_ROTATION(object, rot.x, rot.y, rot.z, 2, true)
    else
        local entRot = ENTITY.GET_ENTITY_ROTATION(object, 2)
        if entityRoll ~= 0 or entityPitch ~= 0 then
            if entRot.y ~= 0 then
                if entRot.y < 0 then
                    axisX = -1.0
                else
                    axisX = 1.0
                end
            else
                axisX = 0.0
            end
            if entRot.y ~= 0 then
                if entRot.y < 2.0 and entRot.y > 0.0 then
                    axisX = 0.0001
                elseif entRot.y > -2.0 and entRot.y < 0.0 then
                    axisX = -0.0001
                end
            else
                axisX = 0.0
            end
            if entRot.x ~= 0.0 then
				if entRot.x < 2.0 and entRot.x > 0.0 then
					axisY = 0.0001
				elseif entRot.x > -2.0 and entRot.x < 0.0 then
					axisY = -0.0001
                end
			else
                axisY = 0.0
            end
            heading = currectRotation(-(( (axisY * 0.05) * frameTime) * (max - 25)))
            roll = currectRotation(-(( (axisX * 0.05) * frameTime) * (max - 25)))
            local rot = v3.new(0.0, roll, heading)
            rot:add(entRot)
            ENTITY.SET_ENTITY_ROTATION(object, rot.x, rot.y, rot.z, 2, true)
        end
    end
end


local lowerLimit <const> = 2500.0
local upperLimit <const> = 3000.0

local getBoundsState = function ()
    local pos = ENTITY.GET_ENTITY_COORDS(object, false)
    local distance = startPos:distance(pos)
    if distance > upperLimit then
        return BoundsState.outOfBounds
    elseif distance >= lowerLimit and distance < upperLimit then
        return BoundsState.gettingOut
    end
    return BoundsState.inBounds
end


---@param heading number
local function drawMissileScaleformMovie(heading)
    if not GRAPHICS.HAS_SCALEFORM_MOVIE_LOADED(scaleform) then
        scaleform = request_scaleform_movie("SUBMARINE_MISSILES")
    else
        GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "SET_ZOOM_VISIBLE")
        GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_BOOL(false)
        GRAPHICS.END_SCALEFORM_MOVIE_METHOD()

        GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "SET_ALT_FOV_HEADING")
        GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_FLOAT(0.0)
        GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_FLOAT(0.0)
        GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_FLOAT(heading)
        GRAPHICS.END_SCALEFORM_MOVIE_METHOD()

        local boundsState = getBoundsState()
        if boundsState == BoundsState.gettingOut then
            sounds.outOfBounds:play()
            GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "SET_WARNING_IS_VISIBLE")
            GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_BOOL(true)
            GRAPHICS.END_SCALEFORM_MOVIE_METHOD()

            GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "SET_WARNING_FLASH_RATE")
            GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_FLOAT(0.5)
            GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
        elseif boundsState == BoundsState.inBounds then
            sounds.outOfBounds:stop()
            GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "SET_WARNING_IS_VISIBLE")
            GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_BOOL(false)
            GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
        end

        GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(scaleform, 255, 255, 255, 255, 1)
    end
end


local destroy = function ()
    for _, sound in pairs(sounds) do
        sound:stop()
    end
    if  GRAPHICS.DOES_PARTICLE_FX_LOOPED_EXIST(effects.missile_trail) then
        GRAPHICS.STOP_PARTICLE_FX_LOOPED(effects.missile_trail, false)
        STREAMING.REMOVE_NAMED_PTFX_ASSET(fxAsset)
    end
    AUDIO.STOP_AUDIO_SCENE("dlc_aw_arena_piloted_missile_scene")
    set_scaleform_movie_as_no_longer_needed(scaleform)

    if  HUD.DOES_BLIP_EXIST(blip) then
        util.remove_blip(blip)
        blip = 0
    end

    if  CAM.DOES_CAM_EXIST(camera) then
        CAM.RENDER_SCRIPT_CAMS(false, false, 0, true, false, 0)
        CAM.SET_CAM_ACTIVE(camera, false)
        CAM.DESTROY_CAM(camera, false)
    end

    STREAMING.CLEAR_FOCUS()
    GRAPHICS.CLEAR_TIMECYCLE_MODIFIER()
    entities.delete_by_handle(object)
    HUD.UNLOCK_MINIMAP_ANGLE()
    HUD.UNLOCK_MINIMAP_POSITION()
    ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(), false)
end


local function disableControlActions()
    for i = 1, 6 do
        PAD.DISABLE_CONTROL_ACTION(0, i, true)
    end
    PAD.DISABLE_CONTROL_ACTION(0, 71, true)
    PAD.DISABLE_CONTROL_ACTION(0, 72, true)
    PAD.DISABLE_CONTROL_ACTION(0, 63, true)
    PAD.DISABLE_CONTROL_ACTION(0, 64, true)
	PAD.DISABLE_CONTROL_ACTION(0, 87, true)
	PAD.DISABLE_CONTROL_ACTION(0, 88, true)
	PAD.DISABLE_CONTROL_ACTION(0, 89, true)
	PAD.DISABLE_CONTROL_ACTION(0, 90, true)
	PAD.DISABLE_CONTROL_ACTION(0, 129, true)
	PAD.DISABLE_CONTROL_ACTION(0, 130, true)
	PAD.DISABLE_CONTROL_ACTION(0, 133, true)
	PAD.DISABLE_CONTROL_ACTION(0, 134, true)
    PAD.DISABLE_CONTROL_ACTION(0, 75, true)
end


self.mainLoop = function ()
    if state == MissileState.beingCreated then
        ENTITY.FREEZE_ENTITY_POSITION(PLAYER.PLAYER_PED_ID(), true)
        request_model(objHash)
        local coords = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
        object = entities.create_object(objHash, coords)
        ENTITY.SET_ENTITY_HEADING(object, invertHeading(CAM.GET_GAMEPLAY_CAM_ROT(0).z))
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(object, false, true)
        ENTITY.SET_ENTITY_INVINCIBLE(object, true)
        NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(NETWORK.OBJ_TO_NET(object), PLAYER.PLAYER_ID(), true)
        ENTITY.SET_ENTITY_LOAD_COLLISION_FLAG(object, true, 1)
        NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(NETWORK.OBJ_TO_NET(object), true);
        ENTITY.SET_ENTITY_LOD_DIST(object, 700)
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(NETWORK.OBJ_TO_NET(object), false)
        ENTITY.SET_ENTITY_RECORDS_COLLISIONS(object, true)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(object, coords.x, coords.y, coords.z + 5.0, false, false, true)
        ENTITY.SET_ENTITY_HAS_GRAVITY(object, false)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(objHash)

        camera = CAM.CREATE_CAM("DEFAULT_SCRIPTED_CAMERA", true)
        CAM.SET_CAM_FOV(camera, 80.0)
        CAM.SET_CAM_NEAR_CLIP(camera, 0.01)
        CAM.SET_CAM_NEAR_DOF(camera, 0.01)
        GRAPHICS.CLEAR_TIMECYCLE_MODIFIER()
        GRAPHICS.SET_TIMECYCLE_MODIFIER("eyeinthesky")
        WIRI.HARD_ATTACH_CAM_TO_ENTITY(camera, object, 0.0, 0.0, 180.0, 0.0, -0.9, 0.0, true)
        CAM.RENDER_SCRIPT_CAMS(true, false, 0, true, true, 0)

        if not AUDIO.IS_AUDIO_SCENE_ACTIVE("dlc_aw_arena_piloted_missile_scene") then
            AUDIO.START_AUDIO_SCENE("dlc_aw_arena_piloted_missile_scene")
        end

        sounds.startUp:play()
        request_fx_asset(fxAsset)
        GRAPHICS.USE_PARTICLE_FX_ASSET(fxAsset)
        effects.missile_trail = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY(
            "scr_xs_guided_missile_trail", object, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, false, false, false, 0, 0, 0, 0
        )

        blip = HUD.ADD_BLIP_FOR_COORD(coords.x, coords.y, coords.z)
        HUD.SET_BLIP_SCALE(blip, 1.0)
        HUD.SET_BLIP_ROUTE(blip, false)
        HUD.SET_BLIP_SPRITE(blip, 548)
        HUD.SET_BLIP_COLOUR(blip, get_player_org_blip_colour(players.user()))
        startPos = coords

        if not GRAPHICS.HAS_SCALEFORM_MOVIE_LOADED(scaleform) then
            scaleform = request_scaleform_movie("SUBMARINE_MISSILES")
        end
        state = MissileState.onFlight
    elseif state == MissileState.onFlight then
        local forceMag
        local accelerating = false
        local decelerating = false
        local coords    = ENTITY.GET_ENTITY_COORDS(object, true)
        local velocity  = ENTITY.GET_ENTITY_VELOCITY(object)
        local rotation  = CAM.GET_CAM_ROT(camera, 2)
        local heading   = invertHeading( ENTITY.GET_ENTITY_HEADING(object) )
        local direction = rotation:toDir()

        DisablePhone()
        disableControlActions()
        HUD.SET_BLIP_DISPLAY(blip, 2)
        HUD.SET_BLIP_COORDS(blip, coords.x, coords.y, coords.z)
        HUD.LOCK_MINIMAP_POSITION(coords.x, coords.y)
        HUD.SET_BLIP_ROTATION(blip, math.ceil(heading))
        HUD.SET_BLIP_PRIORITY(blip, 9)
        HUD.LOCK_MINIMAP_ANGLE(math.ceil(heading))

        if NETWORK.NETWORK_HAS_CONTROL_OF_NETWORK_ID(NETWORK.OBJ_TO_NET(object))  then
            if ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(object) or ENTITY.GET_LAST_MATERIAL_HIT_BY_ENTITY(object) ~= 0 or
            ENTITY.IS_ENTITY_IN_WATER(object) or PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, 75) or
            getBoundsState() == BoundsState.outOfBounds then
                state = MissileState.exploting
            end
            if not PAD.IS_USING_KEYBOARD_AND_MOUSE(0) then
                if PAD.GET_CONTROL_UNBOUND_NORMAL(0, 208) ~= 0 then
                    accelerating = true
                end
                if PAD.GET_CONTROL_UNBOUND_NORMAL(0, 207) ~= 0 then
                    decelerating = true
                end
            else
                if PAD.GET_CONTROL_UNBOUND_NORMAL(0, 209) ~= 0 then
                    accelerating = true
                end
                if PAD.GET_CONTROL_UNBOUND_NORMAL(0, 210) ~= 0 then
                    decelerating = true
                end
            end

            if accelerating then
                forceMag = 150.0
            elseif decelerating then
                forceMag = 50.0
            else
                forceMag = 100.0
            end

            local force = v3.new(direction)
            force:mul(forceMag)
            ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(object, 1, force.x, force.y, force.z, false, false, false, false)
            setMissileRotation()
            STREAMING.SET_FOCUS_POS_AND_VEL(coords.x, coords.y, coords.z, velocity.x, velocity.y, velocity.z)
            if MISC.GET_FRAME_COUNT() % 120 == 0 then
                PED.SET_SCENARIO_PEDS_SPAWN_IN_SPHERE_AREA(coords.x, coords.y, coords.z, 60.0, 30)
            end

            local myPos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
            STREAMING.REQUEST_COLLISION_AT_COORD(myPos.x, myPos.y, myPos.z)

            drawMissileScaleformMovie(rotation.z)
            drawInstructionalButtons()
        else
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(object)
        end
    elseif state == MissileState.exploting then
        local coord = CAM.GET_CAM_COORD(camera)
        FIRE.ADD_EXPLOSION(coord.x, coord.y, coord.z, 81, 5.0, true, false, 1.0, false)
        PAD.SET_CONTROL_SHAKE(0, 300, 200)
        NETWORK.NETWORK_FADE_OUT_ENTITY(object, false, true)
        sounds.startUp:stop()
        sounds.outOfBounds:stop()

        if GRAPHICS.DOES_PARTICLE_FX_LOOPED_EXIST(effects.missile_trail) then
            GRAPHICS.STOP_PARTICLE_FX_LOOPED(effects.missile_trail, false)
            STREAMING.REMOVE_NAMED_PTFX_ASSET(fxAsset)
        end
        if HUD.DOES_BLIP_EXIST(blip) then
            util.remove_blip(blip)
        end

        timer.reset()
        sounds.staticLoop:play()
        GRAPHICS.SET_TIMECYCLE_MODIFIER("MissileOutOfRange")
        state = MissileState.disconnecting
    elseif state == MissileState.disconnecting then
        if timer.elapsed() >= 1000 then
            sounds.staticLoop:stop()
            CAM.DESTROY_ALL_CAMS(true)
            CAM.DESTROY_CAM(camera, false)
            CAM.RENDER_SCRIPT_CAMS(false, false, 0, true, false, 0)
            STREAMING.CLEAR_FOCUS()

            timer.reset()
            sounds.disconnect:play()
            state = MissileState.beingDestroyed
        end
    elseif state == MissileState.beingDestroyed then
        if timer.elapsed() >= 500 then
            destroy()
            state = MissileState.nonExistent
        end
    end
end


self.destroy = function ()
    if not self.exists() then
        return
    end
    destroy()
    state = MissileState.nonExistent
end


return self