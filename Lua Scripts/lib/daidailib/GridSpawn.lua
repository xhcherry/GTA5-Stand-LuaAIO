function left_click()
    return PAD.IS_DISABLED_CONTROL_JUST_PRESSED(2, 24)
end
function left_click_up()
    return PAD.IS_DISABLED_CONTROL_JUST_RELEASED(2, 24)
end
function left_ctrl_down()
    return PAD.IS_DISABLED_CONTROL_PRESSED(2, 36)
end
function x_click()
    return PAD.IS_DISABLED_CONTROL_JUST_PRESSED(2, 73)
end
function draw_arrow_down(pos, angle, size, colour_a, colour_b)
    colour_b = colour_b or {r = 255, g = 255, b = 255, a = colour_a.a}
    local angle_cos = math.cos(angle)
    local angle_sin = math.sin(angle)
    local width = 0.5 * size
    local length = 1 * size
    local height = 0.25 * size
    
    GRAPHICS.DRAW_POLY(
        pos.x + (angle_cos * 0 - angle_sin * 0),
        pos.y + (angle_sin * 0 + angle_cos * 0),
        pos.z + 0,
        pos.x + (angle_cos * 0 - angle_sin * height),
        pos.y + (angle_sin * 0 + angle_cos * height),
        pos.z + length + height,
        pos.x + (angle_cos * width - angle_sin * 0),
        pos.y + (angle_sin * width + angle_cos * 0),
        pos.z + length,
        colour_b.r,
        colour_b.g,
        colour_b.b,
        colour_b.a
    )
    GRAPHICS.DRAW_POLY(
        pos.x + (angle_cos * 0 - angle_sin * -height),
        pos.y + (angle_sin * 0 + angle_cos * -height),
        pos.z + length + height,
        pos.x + (angle_cos * 0 - angle_sin * 0),
        pos.y + (angle_sin * 0 + angle_cos * 0),
        pos.z + 0,
        pos.x + (angle_cos * width - angle_sin * 0),
        pos.y + (angle_sin * width + angle_cos * 0),
        pos.z + length,
        colour_b.r,
        colour_b.g,
        colour_b.b,
        colour_b.a
    )
    GRAPHICS.DRAW_POLY(
        pos.x + (angle_cos * 0 - angle_sin * 0),
        pos.y + (angle_sin * 0 + angle_cos * 0),
        pos.z + 0,
        pos.x + (angle_cos * 0 - angle_sin * -height),
        pos.y + (angle_sin * 0 + angle_cos * -height),
        pos.z + length + height,
        pos.x + (angle_cos * -width - angle_sin * 0),
        pos.y + (angle_sin * -width + angle_cos * 0),
        pos.z + length,
        colour_a.r,
        colour_a.g,
        colour_a.b,
        colour_a.a
    )
    GRAPHICS.DRAW_POLY(
        pos.x + (angle_cos * 0 - angle_sin * height),
        pos.y + (angle_sin * 0 + angle_cos * height),
        pos.z + length + height,
        pos.x + (angle_cos * 0 - angle_sin * 0),
        pos.y + (angle_sin * 0 + angle_cos * 0),
        pos.z + 0,
        pos.x + (angle_cos * -width - angle_sin * 0),
        pos.y + (angle_sin * -width + angle_cos * 0),
        pos.z + length,
        colour_a.r,
        colour_a.g,
        colour_a.b,
        colour_a.a
    )
    GRAPHICS.DRAW_POLY(
        pos.x + (angle_cos * 0 - angle_sin * height),
        pos.y + (angle_sin * 0 + angle_cos * height),
        pos.z + length + height,
        pos.x + (angle_cos * 0 - angle_sin * -height),
        pos.y + (angle_sin * 0 + angle_cos * -height),
        pos.z + length + height,
        pos.x + (angle_cos * width - angle_sin * 0),
        pos.y + (angle_sin * width + angle_cos * 0),
        pos.z + length,
        colour_b.r,
        colour_b.g,
        colour_b.b,
        colour_b.a
    )
    GRAPHICS.DRAW_POLY(
        pos.x + (angle_cos * 0 - angle_sin * -height),
        pos.y + (angle_sin * 0 + angle_cos * -height),
        pos.z + length + height,
        pos.x + (angle_cos * 0 - angle_sin * height),
        pos.y + (angle_sin * 0 + angle_cos * height),
        pos.z + length + height,
        pos.x + (angle_cos * -width - angle_sin * 0),
        pos.y + (angle_sin * -width + angle_cos * 0),
        pos.z + length,
        colour_a.r,
        colour_a.g,
        colour_a.b,
        colour_a.a
    )
end

local gridminimum = memory.alloc()
local gridmaximum = memory.alloc()
local upVector_pointer = memory.alloc()
local rightVector_pointer = memory.alloc()
local forwardVector_pointer = memory.alloc()
local position_pointer = memory.alloc()
function griddraw_bounding_box(entity, colour)
    ENTITY.GET_ENTITY_MATRIX(entity, rightVector_pointer, forwardVector_pointer, upVector_pointer, position_pointer);
    local forward_vector = v3.new(forwardVector_pointer)
    local right_vector = v3.new(rightVector_pointer)
    local up_vector = v3.new(upVector_pointer)

    MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(entity), gridminimum, gridmaximum)
    local gridminimum_vec = v3.new(gridminimum)
    local gridmaximum_vec = v3.new(gridmaximum)
    local dimensions = {x = gridmaximum_vec.y - gridminimum_vec.y, y = gridmaximum_vec.x - gridminimum_vec.x, z = gridmaximum_vec.z - gridminimum_vec.z}

    local top_right =           ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity,       gridmaximum_vec.x, gridmaximum_vec.y, gridmaximum_vec.z)
    local top_right_back =      {x = forward_vector.x * -dimensions.y + top_right.x,        y = forward_vector.y * -dimensions.y + top_right.y,         z = forward_vector.z * -dimensions.y + top_right.z}
    local bottom_right_back =   {x = up_vector.x * -dimensions.z + top_right_back.x,        y = up_vector.y * -dimensions.z + top_right_back.y,         z = up_vector.z * -dimensions.z + top_right_back.z}
    local bottom_left_back =    {x = -right_vector.x * dimensions.x + bottom_right_back.x,  y = -right_vector.y * dimensions.x + bottom_right_back.y,   z = -right_vector.z * dimensions.x + bottom_right_back.z}
    local top_left =            {x = -right_vector.x * dimensions.x + top_right.x,          y = -right_vector.y * dimensions.x + top_right.y,           z = -right_vector.z * dimensions.x + top_right.z}
    local bottom_right =        {x = -up_vector.x * dimensions.z + top_right.x,             y = -up_vector.y * dimensions.z + top_right.y,              z = -up_vector.z * dimensions.z + top_right.z}
    local bottom_left =         {x = forward_vector.x * dimensions.y + bottom_left_back.x,  y = forward_vector.y * dimensions.y + bottom_left_back.y,   z = forward_vector.z * dimensions.y + bottom_left_back.z}
    local top_left_back =       {x = up_vector.x * dimensions.z + bottom_left_back.x,       y = up_vector.y * dimensions.z + bottom_left_back.y,        z = up_vector.z * dimensions.z + bottom_left_back.z}

    GRAPHICS.DRAW_LINE(
        top_right.x, top_right.y, top_right.z,
        top_right_back.x, top_right_back.y, top_right_back.z,
       colour.r, colour.g, colour.b, colour.a
    )
    GRAPHICS.DRAW_LINE(
        top_right.x, top_right.y, top_right.z,
        top_left.x, top_left.y, top_left.z,
       colour.r, colour.g, colour.b, colour.a
    )
    GRAPHICS.DRAW_LINE(
        top_right.x, top_right.y, top_right.z,
        bottom_right.x, bottom_right.y, bottom_right.z,
       colour.r, colour.g, colour.b, colour.a
    )
    GRAPHICS.DRAW_LINE(
        bottom_left_back.x, bottom_left_back.y, bottom_left_back.z,
        bottom_right_back.x, bottom_right_back.y, bottom_right_back.z,
       colour.r, colour.g, colour.b, colour.a
    )
    GRAPHICS.DRAW_LINE(
        bottom_left_back.x, bottom_left_back.y, bottom_left_back.z,
        bottom_left.x, bottom_left.y, bottom_left.z,
       colour.r, colour.g, colour.b, colour.a
    )
    GRAPHICS.DRAW_LINE(
        bottom_left_back.x, bottom_left_back.y, bottom_left_back.z,
        top_left_back.x, top_left_back.y, top_left_back.z,
       colour.r, colour.g, colour.b, colour.a
    )
    GRAPHICS.DRAW_LINE(
        top_left_back.x, top_left_back.y, top_left_back.z,
        top_right_back.x, top_right_back.y, top_right_back.z,
       colour.r, colour.g, colour.b, colour.a
    )
    GRAPHICS.DRAW_LINE(
        top_left_back.x, top_left_back.y, top_left_back.z,
        top_left.x, top_left.y, top_left.z,
       colour.r, colour.g, colour.b, colour.a
    )
    GRAPHICS.DRAW_LINE(
        bottom_right_back.x, bottom_right_back.y, bottom_right_back.z,
        top_right_back.x, top_right_back.y, top_right_back.z,
       colour.r, colour.g, colour.b, colour.a
    )
    GRAPHICS.DRAW_LINE(
        bottom_left.x, bottom_left.y, bottom_left.z,
        top_left.x, top_left.y, top_left.z,
       colour.r, colour.g, colour.b, colour.a
    )
    GRAPHICS.DRAW_LINE(
        bottom_left.x, bottom_left.y, bottom_left.z,
        bottom_right.x, bottom_right.y, bottom_right.z,
       colour.r, colour.g, colour.b, colour.a
    )
    GRAPHICS.DRAW_LINE(
        bottom_right_back.x, bottom_right_back.y, bottom_right_back.z,
        bottom_right.x, bottom_right.y, bottom_right.z,
       colour.r, colour.g, colour.b, colour.a
    )
end


--[[ local gridminimum = memory.alloc()
local gridmaximum = memory.alloc() ]]
function get_model_dimensions(model)
    while not STREAMING.HAS_MODEL_LOADED(model) do
        STREAMING.REQUEST_MODEL(model)
        util.yield()
    end
    MISC.GET_MODEL_DIMENSIONS(model, gridminimum, gridmaximum)
        local gridminimum_vec = v3.new(gridminimum)
        local gridmaximum_vec = v3.new(gridmaximum)
        local dimensions = {y = gridmaximum_vec.y - gridminimum_vec.y, x = gridmaximum_vec.x - gridminimum_vec.x, z = gridmaximum_vec.z - gridminimum_vec.z}
    return dimensions
end


local gridcar_hash = util.joaat("t20")
local car_dimensions = get_model_dimensions(gridcar_hash)
local gridx_padding = 0
local gridy_padding = 0

menu.text_input(gridspawn, "车辆模型", {"gridSpawnVeh", "gridVeh", "gridSpawnModel"}, "输入车辆模型名字", function(value)
    local hash = util.joaat(value)
    if STREAMING.IS_MODEL_A_VEHICLE(hash) then
        gridcar_hash = hash
        car_dimensions = get_model_dimensions(hash)
    else
        util.toast("\""..value.."\"不是有效的模型.")
    end
end, "t20")


menu.slider(gridspawn, "X填充距离", {}, "在 X 轴上向网格填充时的间距", 0, 20, 0, 1, function (value)
    gridx_padding = value
end)

menu.slider(gridspawn, "Y填充距离", {}, "在 Y 轴上向网格填充时的间距", 0, 20, 0, 1, function (value)
    gridy_padding = value
end)

menu.action(gridspawn, "切换自由摄像头", {}, "", function()
    menu.trigger_commands("freecam")
end)

menu.divider(gridspawn, "提示：按 X 撤消")






local preview_cars = {{}}
local undo_record = {}
local gridup = v3.new(0, 0, 1)
local is_placing = false
local start_pos
local cam_start_heading
local start_forward
local start_right
local gridarrow_rot = 0

menu.toggle_loop(gridspawn, "网格生成", {}, "", function()
    PLAYER.DISABLE_PLAYER_FIRING(players.user_ped(), true)
    gridarrow_rot += MISC.GET_FRAME_TIME() * 45
    local camPos = v3.new(CAM.GET_FINAL_RENDERED_CAM_COORD())
    local camRot = v3.new(CAM.GET_FINAL_RENDERED_CAM_ROT(2))
    local dir = v3.toDir(camRot)
    v3.mul(dir, 200)
    v3.add(dir, camPos)
    local handle = SHAPETEST.START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE(
                        camPos.x, camPos.y, camPos.z,
                        dir.x, dir.y, dir.z,
                        1, 0, 4
                    )

    local hit = memory.alloc(8)
    local end_pos = memory.alloc()
    local surfaceNormal = memory.alloc()
    local ent = memory.alloc_int()
    SHAPETEST.GET_SHAPE_TEST_RESULT(handle, hit, end_pos, surfaceNormal, ent)

    if memory.read_byte(hit) ~= 0 then
        end_pos = v3.new(end_pos)
        draw_arrow_down(end_pos, math.rad(gridarrow_rot), 1, {r = 0, g = 0, b = 255, a = 255})

        if left_click() then
            is_placing = true
            start_pos = v3.new(end_pos)
            local cam_start_rot = v3.new(CAM.GET_FINAL_RENDERED_CAM_ROT(2))
            cam_start_rot.x = 0
            cam_start_heading = v3.getHeading(cam_start_rot)
            start_forward = v3.toDir(cam_start_rot)
            start_right = v3.crossProduct(start_forward, gridup)
        elseif left_click_up() then
            is_placing = false
            undo_record[#undo_record+1] = {}
            local new_record = undo_record[#undo_record]
            for _, tbl in pairs(preview_cars) do
                for _, car in pairs(tbl) do
                    local pos = ENTITY.GET_ENTITY_COORDS(car, false)
                    entities.delete(car)
                    local new_car = VEHICLE.CREATE_VEHICLE(gridcar_hash, pos.x, pos.y, pos.z, cam_start_heading, true, false, false)
                    new_record[#new_record+1] = new_car
                end
            end
            preview_cars = {{}}
        end

        if x_click() and #undo_record > 0 then
            for _, car in pairs(undo_record[#undo_record]) do
                if ENTITY.DOES_ENTITY_EXIST(car or 0) then
                    entities.delete(car)
                end
            end
            undo_record[#undo_record] = nil
        end

        if is_placing then
            draw_arrow_down(start_pos, math.rad(gridarrow_rot), 1, {r = 255, g = 0, b = 0, a = 255})
            local angle = -math.rad(cam_start_heading)
            local angle_cos = math.cos(angle)
            local angle_sin = math.sin(angle)
            end_pos = v3.new(
                start_pos.x + (angle_cos * (end_pos.x - start_pos.x) - angle_sin * (end_pos.y - start_pos.y)),
                start_pos.y + (angle_sin * (end_pos.x - start_pos.x) + angle_cos * (end_pos.y - start_pos.y)),
                end_pos.z
            )
            local car_x_plus_pad = car_dimensions.x + gridx_padding
            local car_y_plus_pad = car_dimensions.y + gridy_padding

            local x_count = math.min(math.floor(math.abs((start_pos.x - end_pos.x) / car_x_plus_pad)), 9)
            local y_count = math.min(math.floor(math.abs((start_pos.y - end_pos.y) / car_y_plus_pad)), 9)
            for x = 0, x_count, 1 do
                for y = 0, y_count, 1 do
                    local mult_x = if start_pos.x > end_pos.x then -1 else 1
                    local mult_y = if start_pos.y > end_pos.y then -1 else 1
                    local temp_forward = v3.new(start_forward)
                    local temp_right = v3.new(start_right)
                    v3.mul(temp_forward, (car_y_plus_pad * y) * mult_y)
                    v3.mul(temp_right, (car_x_plus_pad * x) * mult_x)
                    v3.add(temp_forward, temp_right)
                    v3.add(temp_forward, start_pos)
                    local coords = temp_forward

                    local z_found, z_coord = util.get_ground_z(coords.x, coords.y)
                    if z_found then
                        coords.z = z_coord
                    else
                        coords.z = start_pos.z
                    end
                    local car
                    if preview_cars[x] then
                        if preview_cars[x][y] then
                            car = preview_cars[x][y]
                        end
                    else
                        preview_cars[x] = {}
                    end
                    if not car then
                        car = VEHICLE.CREATE_VEHICLE(gridcar_hash, coords.x, coords.y, coords.z, cam_start_heading, false, false, false)
                        ENTITY.SET_ENTITY_ALPHA(car, 51, false)
                        ENTITY.SET_ENTITY_COLLISION(car, false, false)
                        ENTITY.FREEZE_ENTITY_POSITION(car, true)
                        preview_cars[x][y] = car
                    end
                    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(car, coords.x, coords.y, coords.z + car_dimensions.z * 0.5, false, false, false)
                    griddraw_bounding_box(car, {r = 255, g = 0, b = 255, a = 100})
                end
            end
            for x, tbl in pairs(preview_cars) do
                for y, car in pairs(tbl) do
                    if x > x_count or y > y_count then
                        entities.delete(car)
                        preview_cars[x][y] = nil
                    end
                end
            end
        end

    end
end)