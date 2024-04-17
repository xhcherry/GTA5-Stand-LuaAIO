----默认速度
local move_speed_v = 0.3
local move_speed_h = 0.3
local move_speed_cam = 5
----默认视野
local cam_fov = 90
----默认镜头
local our_cam

local cam_obj = 0
local function cam_control()
    ----判断相机是否存在
    if not ENTITY.DOES_ENTITY_EXIST(cam_obj) then
        local actual_cam_pos = CAM.GET_CAM_COORD(our_cam)
        cam_obj = create_object(util.joaat("prop_tennis_ball"), actual_cam_pos.x, actual_cam_pos.y, actual_cam_pos.z)
        local head = ENTITY.GET_ENTITY_ROTATION(PLAYER.PLAYER_PED_ID(), 0)
        ENTITY.SET_ENTITY_ROTATION(cam_obj, head.x, head.y, head.z, 1, true)
        ENTITY.SET_ENTITY_VISIBLE(cam_obj, false, false)
        STREAMING.SET_FOCUS_ENTITY(cam_obj)
        ENTITY.FREEZE_ENTITY_POSITION(cam_obj, true)
        ENTITY.SET_ENTITY_INVINCIBLE(cam_obj, true)
    end

    ----coord移动方向
    local mod_x = 0
    local mod_y = 0
    local mod_z = 0
    local speed_this_frame_h = move_speed_h
    local speed_this_frame_v = move_speed_v
    if PAD.IS_CONTROL_PRESSED(55, 55) then
        speed_this_frame_h = speed_this_frame_h * 3 
        speed_this_frame_v = speed_this_frame_v * 3
    elseif PAD.IS_CONTROL_PRESSED(19, 19) then
        speed_this_frame_h = speed_this_frame_h / 10 
        speed_this_frame_v = speed_this_frame_v / 10
    end

    -- Shift/up
    if PAD.IS_CONTROL_PRESSED(21, 21) then
        mod_z = mod_z + speed_this_frame_v
    end
    -- Ctrl/down 
    if PAD.IS_CONTROL_PRESSED(36, 36) then
        mod_z = mod_z - speed_this_frame_v
    end
    -- W/forward
    if PAD.IS_CONTROL_PRESSED(32, 32) then
        mod_y = mod_y + speed_this_frame_h
    end
    -- S/back
    if PAD.IS_CONTROL_PRESSED(33, 33) then
        mod_y = mod_y - speed_this_frame_h
    end
    -- A/left
    if PAD.IS_CONTROL_PRESSED(34, 34) then
        mod_x = mod_x - speed_this_frame_h
    end
    -- D/right
    if PAD.IS_CONTROL_PRESSED(35, 35) then
        mod_x = mod_x + speed_this_frame_h
    end
    local new_pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(cam_obj, mod_x, mod_y, mod_z)
    local new_pos_behind = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(cam_obj, mod_x, mod_y, mod_z)
    ENTITY.SET_ENTITY_COORDS(cam_obj, new_pos_behind.x, new_pos_behind.y, new_pos_behind.z)
    CAM.SET_CAM_COORD(our_cam, new_pos.x, new_pos.y, new_pos.z)

    ----相机旋转
    local foxmod_x = 0
    local foxmod_y = 0
    local foxmod_z = 0
    foxmod_x = PAD.GET_DISABLED_CONTROL_NORMAL(2, 2) * 5
    foxmod_z = -PAD.GET_DISABLED_CONTROL_NORMAL(1, 1) * 5
    local cam_rot = ENTITY.GET_ENTITY_ROTATION(cam_obj, 0)
    ENTITY.SET_ENTITY_ROTATION(cam_obj, cam_rot.x - foxmod_x, cam_rot.y, cam_rot.z + foxmod_z)
    cam_rot = ENTITY.GET_ENTITY_ROTATION(cam_obj, 0)
    CAM.SET_CAM_ROT(our_cam, cam_rot.x, cam_rot.y, cam_rot.z)
end

----首次创建相机
local function cam_toggled(on)
    main_toggle = on
    if on then
        if not CAM.DOES_CAM_EXIST(our_cam) then
            our_cam = CAM.CREATE_CAM_WITH_PARAMS("DEFAULT_SCRIPTED_CAMERA", 0, 0, 0, 0, 0, 0, 2, 2)
        end
        local c2 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, -3.0, 1.0)
        cam_obj = create_object(util.joaat("prop_tennis_ball"), c2.x, c2.y, c2.z)
        local head = ENTITY.GET_ENTITY_ROTATION(PLAYER.PLAYER_PED_ID(), 0)
        ENTITY.SET_ENTITY_ROTATION(cam_obj, head.x, head.y, head.z, 1, true)
        ENTITY.SET_ENTITY_VISIBLE(cam_obj, false, false)
        STREAMING.SET_FOCUS_ENTITY(cam_obj)
        ENTITY.FREEZE_ENTITY_POSITION(cam_obj, true)
        ENTITY.SET_ENTITY_INVINCIBLE(cam_obj, true)
        CAM.SET_CAM_ACTIVE(our_cam, true)
        CAM.SET_CAM_NEAR_CLIP(our_cam, 0.0)
        -- 初始设置
        CAM.SET_CAM_FOV(our_cam, cam_fov)
        CAM.SET_CAM_NEAR_DOF(our_cam, 100)
        CAM.SET_CAM_FAR_DOF(our_cam, 100)
        CAM.SET_CAM_DOF_STRENGTH(our_cam, 1.0)
        CAM.SET_CAM_DOF_FNUMBER_OF_LENS(our_cam, 1.6)
        CAM.SET_CAM_DOF_FNUMBER_OF_LENS(our_cam, 10.0)
        CAM.SET_CAM_DOF_FOCUS_DISTANCE_BIAS(our_cam, -2.5)
        CAM.SET_CAM_DOF_MAX_NEAR_IN_FOCUS_DISTANCE(our_cam, 100.0)
        CAM.SET_CAM_DOF_MAX_NEAR_IN_FOCUS_DISTANCE_BLEND_LEVEL(our_cam, 100.0)
        -----
        CAM.SET_CAM_COORD(our_cam, c2.x, c2.y, c2.z)
        CAM.RENDER_SCRIPT_CAMS(true, true, 100, true, true, 0)

        PLAYER.SET_PLAYER_CONTROL(players.user(), false, 0)--禁止玩家控制
        ----相机控制
        while main_toggle do
            cam_control()
            util.yield()
        end
    else
        PAD.ENABLE_CONTROL_ACTION(85, 85, true)
        STREAMING.SET_FOCUS_ENTITY(players.user_ped())
        PLAYER.SET_PLAYER_CONTROL(players.user(), true, 0)
        delete_entity(cam_obj)
        CAM.RENDER_SCRIPT_CAMS(false, true, 100, true, true, 0)
        CAM.DESTROY_CAM(our_cam, false)--删除相机
        CAM.SET_CAM_ACTIVE(our_cam, false)
    end
end

menu.toggle(free_cam, "相机开启", {}, "wasd 用于平移摄像机,shift/ctrl 用于上下移动,space 用于快速移动,alt 用于精确移动", function(on)
    cam_toggled(on)
end)
menu.slider(free_cam, "视野", {"cfov"}, "", 0, 130, 90, 1, function(s)
    cam_fov = s
    CAM.SET_CAM_FOV(our_cam, s)
end)
local speed_setting_root = free_cam:list("速度设置", {}, "Affects the camera\'s movement speeds.")
    menu.slider_float(speed_setting_root, "水平移动", {"chspeed"}, "", 0, 100, 30, 1, function(s)
        move_speed_h = s * 0.01
    end)

    menu.slider_float(speed_setting_root, "垂直移动", {"cvspeed"}, "", 0, 100, 30, 1, function(s)
        move_speed_v = s * 0.01
    end)

    menu.slider_float(speed_setting_root, "旋转倍数", {"ccamspeed"}, "", 0, 1000, 500, 1, function(s)
        move_speed_cam = s * 0.01
    end)