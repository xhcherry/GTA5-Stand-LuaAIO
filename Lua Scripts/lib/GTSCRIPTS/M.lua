--[[
--------------------------------
THIS FILE IS PART OF WIRISCRIPT
        Nowiry#2663
--------------------------------
]]

require "lib.GTSCRIPTS.O"

local self = {}
local version = 27
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
        if not WIRI.IS_USING_KEYBOARD_AND_MOUSE(0) then
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
    WIRI_HUD.HIDE_HUD_COMPONENT_THIS_FRAME(6)
    WIRI_HUD.HIDE_HUD_COMPONENT_THIS_FRAME(7)
    WIRI_HUD.HIDE_HUD_COMPONENT_THIS_FRAME(9)
    WIRI_HUD.HIDE_HUD_COMPONENT_THIS_FRAME(8)
    HudTimer.SetHeightMultThisFrame(1)
end


local function getScriptAxes()
    local leftX  = WIRI_PAD.GET_CONTROL_UNBOUND_NORMAL(0, 218)
	local leftY  = WIRI_PAD.GET_CONTROL_UNBOUND_NORMAL(0, 219)
	local rightX = WIRI_PAD.GET_CONTROL_UNBOUND_NORMAL(0, 220)
	local rightY = WIRI_PAD.GET_CONTROL_UNBOUND_NORMAL(0, 221)
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
    local frameTime <const> = 30 * WIRI_MISC.GET_FRAME_TIME()
    local entityRoll <const> = WIRI_ENTITY.GET_ENTITY_ROLL(object)
	local entityPitch <const> = WIRI_ENTITY.GET_ENTITY_PITCH(object)
    local leftX, leftY, rightX, rightY = getScriptAxes()

    if WIRI.IS_USING_KEYBOARD_AND_MOUSE(0) then
		mult = 3.0
		rightX = rightX * mult
		rightY = rightY * mult
	end
    if WIRI.IS_LOOK_INVERTED() then
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

        local entRot = WIRI.GET_ENTITY_ROTATION(object, 2)
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
        WIRI.SET_ENTITY_ROTATION(object, rot.x, rot.y, rot.z, 2, true)
    else
        local entRot = WIRI.GET_ENTITY_ROTATION(object, 2)
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
            WIRI.SET_ENTITY_ROTATION(object, rot.x, rot.y, rot.z, 2, true)
        end
    end
end


local lowerLimit <const> = 2500.0
local upperLimit <const> = 3000.0

local getBoundsState = function ()
    local pos = WIRI_ENTITY.GET_ENTITY_COORDS(object, false)
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
    if not WIRI_GRAPHICS.HAS_SCALEFORM_MOVIE_LOADED(scaleform) then
        scaleform = request_scaleform_movie("SUBMARINE_MISSILES")
    else
        WIRI_GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "SET_ZOOM_VISIBLE")
        WIRI_GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_BOOL(false)
        WIRI_GRAPHICS.END_SCALEFORM_MOVIE_METHOD()

        WIRI_GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "SET_ALT_FOV_HEADING")
        WIRI_GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_FLOAT(0.0)
        WIRI_GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_FLOAT(0.0)
        WIRI_GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_FLOAT(heading)
        WIRI_GRAPHICS.END_SCALEFORM_MOVIE_METHOD()

        local boundsState = getBoundsState()
        if boundsState == BoundsState.gettingOut then
            sounds.outOfBounds:play()
            WIRI_GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "SET_WARNING_IS_VISIBLE")
            WIRI_GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_BOOL(true)
            WIRI_GRAPHICS.END_SCALEFORM_MOVIE_METHOD()

            WIRI_GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "SET_WARNING_FLASH_RATE")
            WIRI_GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_FLOAT(0.5)
            WIRI_GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
        elseif boundsState == BoundsState.inBounds then
            sounds.outOfBounds:stop()
            WIRI_GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleform, "SET_WARNING_IS_VISIBLE")
            WIRI_GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_BOOL(false)
            WIRI_GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
        end

        WIRI_GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(scaleform, 255, 255, 255, 255, 1)
    end
end


local destroy = function ()
    for _, sound in pairs(sounds) do
        sound:stop()
    end
    if  WIRI_GRAPHICS.DOES_PARTICLE_FX_LOOPED_EXIST(effects.missile_trail) then
        WIRI_GRAPHICS.STOP_PARTICLE_FX_LOOPED(effects.missile_trail, false)
        WIRI_STREAMING.REMOVE_NAMED_PTFX_ASSET(fxAsset)
    end
    AUDIO.STOP_AUDIO_SCENE("dlc_aw_arena_piloted_missile_scene")
    set_scaleform_movie_as_no_longer_needed(scaleform)

    if  WIRI_HUD.DOES_BLIP_EXIST(blip) then
        util.remove_blip(blip)
        blip = 0
    end

    if  WIRI_CAM.DOES_CAM_EXIST(camera) then
        WIRI_CAM.RENDER_SCRIPT_CAMS(false, false, 0, true, false, 0)
        WIRI_CAM.SET_CAM_ACTIVE(camera, false)
        WIRI_CAM.DESTROY_CAM(camera, false)
    end

    WIRI_STREAMING.CLEAR_FOCUS()
    WIRI_GRAPHICS.CLEAR_TIMECYCLE_MODIFIER()
    entities.delete_by_handle(object)
    WIRI_HUD.UNLOCK_MINIMAP_ANGLE()
    WIRI_HUD.UNLOCK_MINIMAP_POSITION()
    WIRI_ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(), false)
end


function disableControlActions()
    for i = 1, 6 do
        WIRI_PAD.DISABLE_CONTROL_ACTION(0, i, true)
    end
    WIRI_PAD.DISABLE_CONTROL_ACTION(0, 71, true)
    WIRI_PAD.DISABLE_CONTROL_ACTION(0, 72, true)
    WIRI_PAD.DISABLE_CONTROL_ACTION(0, 63, true)
    WIRI_PAD.DISABLE_CONTROL_ACTION(0, 64, true)
	WIRI_PAD.DISABLE_CONTROL_ACTION(0, 87, true)
	WIRI_PAD.DISABLE_CONTROL_ACTION(0, 88, true)
	WIRI_PAD.DISABLE_CONTROL_ACTION(0, 89, true)
	WIRI_PAD.DISABLE_CONTROL_ACTION(0, 90, true)
	WIRI_PAD.DISABLE_CONTROL_ACTION(0, 129, true)
	WIRI_PAD.DISABLE_CONTROL_ACTION(0, 130, true)
	WIRI_PAD.DISABLE_CONTROL_ACTION(0, 133, true)
	WIRI_PAD.DISABLE_CONTROL_ACTION(0, 134, true)
    WIRI_PAD.DISABLE_CONTROL_ACTION(0, 75, true)
end


self.mainLoop = function ()
    if state == MissileState.beingCreated then
        WIRI_ENTITY.FREEZE_ENTITY_POSITION(PLAYER.PLAYER_PED_ID(), true)
        request_model(objHash)
        local coords = WIRI_ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), false)
        object = entities.create_object(objHash, coords)
        WIRI_ENTITY.SET_ENTITY_HEADING(object, invertHeading(WIRI_CAM.GET_GAMEPLAY_CAM_ROT(0).z))
        WIRI_ENTITY.SET_ENTITY_AS_MISSION_ENTITY(object, false, true)
        WIRI_ENTITY.SET_ENTITY_INVINCIBLE(object, true)
        WIRI_NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(WIRI_NETWORK.OBJ_TO_NET(object), PLAYER.PLAYER_ID(), true)
        WIRI_ENTITY.SET_ENTITY_LOAD_COLLISION_FLAG(object, true, 1)
        WIRI_NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(WIRI_NETWORK.OBJ_TO_NET(object), true);
        WIRI_ENTITY.SET_ENTITY_LOD_DIST(object, 700)
        WIRI_NETWORK.SET_NETWORK_ID_CAN_MIGRATE(WIRI_NETWORK.OBJ_TO_NET(object), false)
        WIRI_ENTITY.SET_ENTITY_RECORDS_COLLISIONS(object, true)
        WIRI_ENTITY.SET_ENTITY_COORDS_NO_OFFSET(object, coords.x, coords.y, coords.z + 5.0, false, false, true)
        WIRI_ENTITY.SET_ENTITY_HAS_GRAVITY(object, false)
        WIRI_STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(objHash)

        camera = WIRI_CAM.CREATE_CAM("DEFAULT_SCRIPTED_CAMERA", true)
        WIRI_CAM.SET_CAM_FOV(camera, 80.0)
        WIRI_CAM.SET_CAM_NEAR_CLIP(camera, 0.01)
        WIRI_CAM.SET_CAM_NEAR_DOF(camera, 0.01)
        WIRI_GRAPHICS.CLEAR_TIMECYCLE_MODIFIER()
        WIRI_GRAPHICS.SET_TIMECYCLE_MODIFIER("eyeinthesky")
        WIRI.HARD_ATTACH_CAM_TO_ENTITY(camera, object, 0.0, 0.0, 180.0, 0.0, -0.9, 0.0, true)
        WIRI_CAM.RENDER_SCRIPT_CAMS(true, false, 0, true, true, 0)

        if not AUDIO.IS_AUDIO_SCENE_ACTIVE("dlc_aw_arena_piloted_missile_scene") then
            AUDIO.START_AUDIO_SCENE("dlc_aw_arena_piloted_missile_scene")
        end

        sounds.startUp:play()
        request_fx_asset(fxAsset)
        WIRI_GRAPHICS.USE_PARTICLE_FX_ASSET(fxAsset)
        effects.missile_trail = WIRI_GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY(
            "scr_xs_guided_missile_trail", object, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, false, false, false, 0, 0, 0, 0
        )

        blip = WIRI_HUD.ADD_BLIP_FOR_COORD(coords.x, coords.y, coords.z)
        WIRI_HUD.SET_BLIP_SCALE(blip, 1.0)
        WIRI_HUD.SET_BLIP_ROUTE(blip, false)
        WIRI_HUD.SET_BLIP_SPRITE(blip, 548)
        WIRI_HUD.SET_BLIP_COLOUR(blip, get_player_org_blip_colour(players.user()))
        startPos = coords

        if not WIRI_GRAPHICS.HAS_SCALEFORM_MOVIE_LOADED(scaleform) then
            scaleform = request_scaleform_movie("SUBMARINE_MISSILES")
        end
        state = MissileState.onFlight
    elseif state == MissileState.onFlight then
        local forceMag
        local accelerating = false
        local decelerating = false
        local coords    = WIRI_ENTITY.GET_ENTITY_COORDS(object, true)
        local velocity  = WIRI_ENTITY.GET_ENTITY_VELOCITY(object)
        local rotation  = WIRI_CAM.GET_CAM_ROT(camera, 2)
        local heading   = invertHeading( WIRI_ENTITY.GET_ENTITY_HEADING(object) )
        local direction = rotation:toDir()

        DisablePhone()
        disableControlActions()
        WIRI_HUD.SET_BLIP_DISPLAY(blip, 2)
        WIRI_HUD.SET_BLIP_COORDS(blip, coords.x, coords.y, coords.z)
        WIRI_HUD.LOCK_MINIMAP_POSITION(coords.x, coords.y)
        WIRI_HUD.SET_BLIP_ROTATION(blip, math.ceil(heading))
        WIRI_HUD.SET_BLIP_PRIORITY(blip, 9)
        WIRI_HUD.LOCK_MINIMAP_ANGLE(math.ceil(heading))

        if WIRI_NETWORK.NETWORK_HAS_CONTROL_OF_NETWORK_ID(WIRI_NETWORK.OBJ_TO_NET(object))  then
            if WIRI_ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(object) or WIRI_ENTITY.GET_LAST_MATERIAL_HIT_BY_ENTITY(object) ~= 0 or
            WIRI_ENTITY.IS_ENTITY_IN_WATER(object) or WIRI_PAD.IS_DISABLED_CONTROL_JUST_PRESSED(0, 75) or
            getBoundsState() == BoundsState.outOfBounds then
                state = MissileState.exploting
            end
            if not WIRI.IS_USING_KEYBOARD_AND_MOUSE(0) then
                if WIRI_PAD.GET_CONTROL_UNBOUND_NORMAL(0, 208) ~= 0 then
                    accelerating = true
                end
                if WIRI_PAD.GET_CONTROL_UNBOUND_NORMAL(0, 207) ~= 0 then
                    decelerating = true
                end
            else
                if WIRI_PAD.GET_CONTROL_UNBOUND_NORMAL(0, 209) ~= 0 then
                    accelerating = true
                end
                if WIRI_PAD.GET_CONTROL_UNBOUND_NORMAL(0, 210) ~= 0 then
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
            WIRI_ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(object, 1, force.x, force.y, force.z, false, false, false, false)
            setMissileRotation()
            WIRI_STREAMING.SET_FOCUS_POS_AND_VEL(coords.x, coords.y, coords.z, velocity.x, velocity.y, velocity.z)
            if WIRI_MISC.GET_FRAME_COUNT() % 120 == 0 then
                WIRI_PED.SET_SCENARIO_PEDS_SPAWN_IN_SPHERE_AREA(coords.x, coords.y, coords.z, 60.0, 30)
            end

            local myPos = WIRI_ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
            WIRI_STREAMING.REQUEST_COLLISION_AT_COORD(myPos.x, myPos.y, myPos.z)

            drawMissileScaleformMovie(rotation.z)
            drawInstructionalButtons()
        else
            WIRI_NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(object)
        end
    elseif state == MissileState.exploting then
        local coord = WIRI_CAM.GET_CAM_COORD(camera)
        FIRE.ADD_EXPLOSION(coord.x, coord.y, coord.z, 81, 5.0, true, false, 1.0, false)
        WIRI.SET_CONTROL_SHAKE(0, 300, 200)
        WIRI_NETWORK.NETWORK_FADE_OUT_ENTITY(object, false, true)
        sounds.startUp:stop()
        sounds.outOfBounds:stop()

        if WIRI_GRAPHICS.DOES_PARTICLE_FX_LOOPED_EXIST(effects.missile_trail) then
            WIRI_GRAPHICS.STOP_PARTICLE_FX_LOOPED(effects.missile_trail, false)
            WIRI_STREAMING.REMOVE_NAMED_PTFX_ASSET(fxAsset)
        end
        if WIRI_HUD.DOES_BLIP_EXIST(blip) then
            util.remove_blip(blip)
        end

        timer.reset()
        sounds.staticLoop:play()
        WIRI_GRAPHICS.SET_TIMECYCLE_MODIFIER("MissileOutOfRange")
        state = MissileState.disconnecting
    elseif state == MissileState.disconnecting then
        if timer.elapsed() >= 1000 then
            sounds.staticLoop:stop()
            WIRI_CAM.DESTROY_ALL_CAMS(true)
            WIRI_CAM.DESTROY_CAM(camera, false)
            WIRI_CAM.RENDER_SCRIPT_CAMS(false, false, 0, true, false, 0)
            WIRI_STREAMING.CLEAR_FOCUS()

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