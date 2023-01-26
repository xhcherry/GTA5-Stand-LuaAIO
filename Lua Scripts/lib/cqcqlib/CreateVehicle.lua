
util.require_natives(1651208000) --da natives
util.keep_running()

local function  left_click()
    return PAD.IS_DISABLED_CONTROL_JUST_PRESSED(2, 24)
end

local function  left_click_up()
    return PAD.IS_DISABLED_CONTROL_JUST_RELEASED(2, 24)
end

local function left_ctrl_down()
    return PAD.IS_DISABLED_CONTROL_PRESSED(2, 36)
end

local function z_click()
    return PAD.IS_DISABLED_CONTROL_JUST_PRESSED(2, 48)
end

local function draw_arrow_down (pos, angle, size, colour_a, colour_b)
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

local minimum = memory.alloc()
local maximum = memory.alloc()
local upVector_pointer = memory.alloc()
local rightVector_pointer = memory.alloc()
local forwardVector_pointer = memory.alloc()
local position_pointer = memory.alloc()
local draw_bounding_box = function (entity, colour)
    ENTITY.GET_ENTITY_MATRIX(entity, rightVector_pointer, forwardVector_pointer, upVector_pointer, position_pointer);
    local forward_vector = v3.new(forwardVector_pointer)
    local right_vector = v3.new(rightVector_pointer)
    local up_vector = v3.new(upVector_pointer)

    MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(entity), minimum, maximum)
    local minimum_vec = v3.new(minimum)
    local maximum_vec = v3.new(maximum)
    local dimensions = {x = maximum_vec.y - minimum_vec.y, y = maximum_vec.x - minimum_vec.x, z = maximum_vec.z - minimum_vec.z}

    local top_right =           ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity,       maximum_vec.x, maximum_vec.y, maximum_vec.z)
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

local mod_types = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 15, 16, 23, 24, 25, 27, 28, 30, 33, 34, 35, 38, 48}
local function max_vehicle(veh)
    if not ENTITY.DOES_ENTITY_EXIST(veh) then
        return
    end
    VEHICLE.SET_VEHICLE_MOD_KIT(veh, 0)
    for _, type in pairs(mod_types) do
        VEHICLE.SET_VEHICLE_MOD(veh, type, VEHICLE.GET_NUM_VEHICLE_MODS(veh, type) - 1, true)
    end
end

local minimum = memory.alloc()
local maximum = memory.alloc()
local function get_model_dimensions(model)
    while not STREAMING.HAS_MODEL_LOADED(model) do
        STREAMING.REQUEST_MODEL(model)
        util.yield()
    end
    MISC.GET_MODEL_DIMENSIONS(model, minimum, maximum)
        local minimum_vec = v3.new(minimum)
        local maximum_vec = v3.new(maximum)
        local dimensions = {y = maximum_vec.y - minimum_vec.y, x = maximum_vec.x - minimum_vec.x, z = maximum_vec.z - minimum_vec.z}
    return dimensions
end


local car_hash = util.joaat("t20")
local car_dimensions = get_model_dimensions(car_hash)
local x_padding = 0
local y_padding = 0

menu.text_input(ScVehicle, "车辆型号", {"gridSpawnVeh", "gridVeh", "gridSpawnModel"}, "设置要生成的模型", function(value)
    local hash = util.joaat(value)
    if STREAMING.IS_MODEL_A_VEHICLE(hash) then
        car_hash = hash
        car_dimensions = get_model_dimensions(hash)
    else
        util.toast("\""..value.."\" 不是有效的模型.")
    end
end, "t20")

local spawn_maxed
menu.toggle(ScVehicle, "最大生成量", {"gridSpawnMaxed", "gridMaxed"}, "生成的车辆已达到最大值", function (value)
    spawn_maxed = value
end)

menu.slider(ScVehicle, "X 轴", {"gridXpadding"}, "在X轴上向网格添加填充.", 0, 20, 0, 1, function (value)
    x_padding = value
end)

menu.slider(ScVehicle, "Y 轴", {"gridYpadding"}, "向Y轴上的栅格添加填充.", 0, 20, 0, 1, function (value)
    y_padding = value
end)

menu.action(ScVehicle, "切换框架", {}, "只需拨动开关就可以自由移动", function() menu.trigger_commands("freecam") end)

menu.divider(ScVehicle, "提示：按Ctrl+Z撤消")

local preview_cars = {{}}

local undo_record = {}

local up <const> = v3.new(0, 0, 1)
local is_placing = false
local start_pos
local cam_start_heading
local start_forward
local start_right
local arrow_rot = 0
util.create_tick_handler(function ()
    arrow_rot += MISC.GET_FRAME_TIME() * 45
    local camPos = v3.new(CAM.GET_FINAL_RENDERED_CAM_COORD())
    local camRot = v3.new(CAM.GET_FINAL_RENDERED_CAM_ROT())
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
        draw_arrow_down(end_pos, math.rad(arrow_rot), 1, {r = 0, g = 0, b = 255, a = 255})

        if left_click() then
            is_placing = true
            start_pos = v3.new(end_pos)
            local cam_start_rot = v3.new(CAM.GET_FINAL_RENDERED_CAM_ROT(2))
            cam_start_rot.x = 0
            cam_start_heading = v3.getHeading(cam_start_rot)
            start_forward = v3.toDir(cam_start_rot)
            start_right = v3.crossProduct(start_forward, up)
        elseif left_click_up() then
            is_placing = false
            undo_record[#undo_record+1] = {}
            local new_record = undo_record[#undo_record]
            for _, tbl in pairs(preview_cars) do
                for _, car in pairs(tbl) do
                    local pos = ENTITY.GET_ENTITY_COORDS(car, false)
                    entities.delete_by_handle(car)
                    local new_car = VEHICLE.CREATE_VEHICLE(car_hash, pos.x, pos.y, pos.z, cam_start_heading, true, false, false)
                    new_record[#new_record+1] = new_car
                    if spawn_maxed then
                        max_vehicle(new_car)
                        util.yield()
                    end
                end
            end
            preview_cars = {{}}
        end

        if left_ctrl_down() and z_click() and #undo_record > 0 then
            for _, car in pairs(undo_record[#undo_record]) do
                if ENTITY.DOES_ENTITY_EXIST(car) then
                    entities.delete_by_handle(car)
                end
            end
            undo_record[#undo_record] = nil
        end

        if is_placing then
            draw_arrow_down(start_pos, math.rad(arrow_rot), 1, {r = 255, g = 0, b = 0, a = 255})
            local angle = -math.rad(cam_start_heading)
            local angle_cos = math.cos(angle)
            local angle_sin = math.sin(angle)
            end_pos = v3.new(
                start_pos.x + (angle_cos * (end_pos.x - start_pos.x) - angle_sin * (end_pos.y - start_pos.y)),
                start_pos.y + (angle_sin * (end_pos.x - start_pos.x) + angle_cos * (end_pos.y - start_pos.y)),
                end_pos.z
            )
            local car_x_plus_pad = car_dimensions.x + x_padding
            local car_y_plus_pad = car_dimensions.y + y_padding

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
                        car = VEHICLE.CREATE_VEHICLE(car_hash, coords.x, coords.y, coords.z, cam_start_heading, false, false, false)
                        ENTITY.SET_ENTITY_ALPHA(car, 51, false)
                        ENTITY.SET_ENTITY_COLLISION(car, false, false)
                        ENTITY.FREEZE_ENTITY_POSITION(car, true)
                        if spawn_maxed then
                            max_vehicle(car)
                        end
                        preview_cars[x][y] = car
                    end
                    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(car, coords.x, coords.y, coords.z + car_dimensions.z * 0.5, false, false, false)
                    draw_bounding_box(car, {r = 255, g = 0, b = 255, a = 100})
                end
            end
            for x, tbl in pairs(preview_cars) do
                for y, car in pairs(tbl) do
                    if x > x_count or y > y_count then
                        entities.delete_by_handle(car)
                        preview_cars[x][y] = nil
                    end
                end
            end
        end

    end
end)

util.on_stop(function ()
    for _, tbl in pairs(preview_cars) do
        for _, car in pairs(tbl) do
            entities.delete_by_handle(car)
        end
    end
end)
