----------------------------------------CV请告知夜幕团队并鸣谢夜幕----------------------------
----------------------感谢呆呆-----------------------
require "lib.YeMulib.YeMulib"
local resource_path = filesystem.scripts_dir() .. "\\resources\\YMIMG\\WatchDogs\\"
local cursor_texture = directx.create_texture(resource_path .. "cursor.png")
local point_texture = directx.create_texture(resource_path .. "point.png")


---判断是否为实体
local function is_an_entity(entity)
    if ENTITY.DOES_ENTITY_EXIST(entity) then
        if ENTITY.IS_ENTITY_A_PED(entity) or ENTITY.IS_ENTITY_A_VEHICLE(entity) or ENTITY.IS_ENTITY_AN_OBJECT(entity) then
            return true
        end
    end
    return false
end

---判断是否为玩家
local function is_ped_player(Ped)
    if PED.GET_PED_TYPE(Ped) >= 4 then
        return false
    else
        return true
    end
end

---判断是否为玩家载具
local function is_player_vehicle(Vehicle)
    if Vehicle == entities.get_user_vehicle_as_handle() or Vehicle == entities.get_user_personal_vehicle_as_handle() then
        return true
    elseif not VEHICLE.IS_VEHICLE_SEAT_FREE(Vehicle, -1, false) then
        local ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(Vehicle, -1)
        if ped then
            if is_ped_player(ped) then
                return true
            end
        end
    end
    return false
end

---自定义 Label
local customLabels = {
    EnterFileName = "Enter the file name",
    InvalidChar = "Got an invalid character, try again",
    EnterValue = "Enter the value",
    ValueMustBeNumber = "The value must be a number, try again",
    Search = "Type the word to search"
}
for key, text in pairs(customLabels) do
    customLabels[key] = util.register_label(text)
end

local function get_offset_from_cam(dist)
    local rot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
    local pos = CAM.GET_FINAL_RENDERED_CAM_COORD()
    local dir = rot:toDir()
    dir:mul(dist)
    local offset = v3.new(pos)
    offset:add(dir)
    return offset
end

local TraceFlag = {
    everything = 4294967295,
    none = 0,
    world = 1,
    vehicles = 2,
    pedsSimpleCollision = 4,
    peds = 8,
    objects = 16,
    water = 32,
    foliage = 256,
}

local function get_raycast_result(dist, flag)
    local result = {}
    flag = flag or TraceFlag.everything
    local didHit = memory.alloc(1)
    local endCoords = v3.new()
    local normal = v3.new()
    local hitEntity = memory.alloc_int()
    local camPos = CAM.GET_FINAL_RENDERED_CAM_COORD()
    local offset = get_offset_from_cam(dist)

    local handle = SHAPETEST.START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE(camPos.x, camPos.y, camPos.z, offset.x,
        offset.y, offset.z, flag, players.user_ped(), 7)
    SHAPETEST.GET_SHAPE_TEST_RESULT(handle, didHit, memory.addrof(endCoords), memory.addrof(normal), hitEntity)

    result.didHit = memory.read_byte(didHit) ~= 0
    result.endCoords = endCoords
    result.surfaceNormal = normal
    result.hitEntity = memory.read_int(hitEntity)
    return result
end

---获取玩家正在朝向观看的实体
local function get_entity_is_looking_at()
    local ent = nil
    local range = 1500.0
    local raycastResult = get_raycast_result(range)
    if raycastResult.didHit then
        ent = raycastResult.hitEntity
    end
    return ent
end

local function get_input_from_screen_keyboard(windowName, maxInput, defaultText)
    MISC.DISPLAY_ONSCREEN_KEYBOARD(0, windowName, "", defaultText, "", "", "", maxInput);
    while MISC.UPDATE_ONSCREEN_KEYBOARD() == 0 do
        util.yield(250)
    end
    if MISC.UPDATE_ONSCREEN_KEYBOARD() == 1 then
        return MISC.GET_ONSCREEN_KEYBOARD_RESULT()
    end
    return ""
end

---玩家和实体之间连线
local function draw_line_to_entity(ent)
    if ENTITY.DOES_ENTITY_EXIST(ent) then
        local pos1 = ENTITY.GET_ENTITY_COORDS(players.user_ped())
        local pos2 = ENTITY.GET_ENTITY_COORDS(ent)
        GRAPHICS.DRAW_LINE(pos1.x, pos1.y, pos1.z, pos2.x, pos2.y, pos2.z, 255, 0, 255, 255)
    end
end

-- 启用/禁用呼出电话
local function toggle_cellphone_state(toggle)
    local cellphone_script = "cellphone_controller"
    local cellphone_hash = util.joaat(cellphone_script)
    if toggle then
        --enable, restart script
        if SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(cellphone_hash) <= 0 then
            SCRIPT1.REQUEST_SCRIPT(cellphone_script)
            if SCRIPT1.HAS_SCRIPT_LOADED(cellphone_script) then
                SYSTEM.START_NEW_SCRIPT(cellphone_script, 1424)
                SCRIPT1.SET_SCRIPT_AS_NO_LONGER_NEEDED(cellphone_script)
            end
        end
    else
        --disable
        if SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(cellphone_hash) > 0 then
            MISC.TERMINATE_ALL_SCRIPTS_WITH_THIS_NAME(cellphone_script)
        end
    end
end

-- 启用/禁用鼠标模式
local function toggle_cursor_mode(toggle)
    if toggle then
        PAD.SET_CURSOR_POSITION(0.5, 0.5)
        menu.trigger_commands("disablelookud on")
        menu.trigger_commands("disablelooklr on")
        menu.trigger_commands("disableattack on")
        menu.trigger_commands("disableattack2 on")
    else
        menu.trigger_commands("disablelookud off")
        menu.trigger_commands("disablelooklr off")
        menu.trigger_commands("disableattack off")
        menu.trigger_commands("disableattack2 off")
    end
end

-------------------------------
-------- Draw Function --------
-------------------------------

-- 颜色
local color = {
    purple = { r = 1.0, g = 0.0, b = 1.0, a = 1.0 },
    orange = { r = 1.0, g = 1.0, b = 0.0, a = 1.0 },
    black  = { r = 0.0, g = 0.0, b = 0.0, a = 1.0 },
    white  = { r = 1.0, g = 1.0, b = 1.0, a = 1.0 },
    green  = { r = 0.0, g = 1.0, b = 0.0, a = 1.0 },
    red    = { r = 1.0, g = 0.0, b = 0.0, a = 1.0 },
}

local button_color = {
    background = { r = 0.41176, g = 0.41176, b = 0.41176, a = 0.8 },
    text       = { r = 1.0, g = 1.0, b = 1.0, a = 1.0 },
}

local window_color = {
    background = { r = 0.5451, g = 0.52549, b = 0.5098, a = 0.8 },
    div = { r = 1.0, g = 1.0, b = 1.0, a = 0.5 },
}

-- 主窗口
local window = {
    x = 0.1,
    y = 0.25,
    width = 0.28,
    height = 0.1, --跟随菜单选项数量
    padding = 0.01,
}
-- 绘制
local draw = {
    x = 0.0,
    y = 0.0,
    width = 0.0,
    height = 0.01,
    horizontal = true,
}

-- 开始绘制下一行
local function to_draw_next_line(height)
    draw.x = window.x + window.padding
    draw.y = draw.y + draw.height + height
    draw.height = 0.01

    window.height = draw.y - window.y + window.padding
end

-- 是否超出了窗口的宽
local function is_out_of_window_width(width)
    if draw.horizontal then
        if draw.x + width > window.width + window.x then
            return true
        end
    else
        return true
    end
    return false
end

local function add_width_and_height(width, height)
    if height > draw.height then
        draw.height = height
    end
    draw.x = draw.x + width + 0.005
end

-- 鼠标指针是否在选项区域
local function is_overlap_in_rect(rect_x, rect_y, width, height)
    local cursor_pos = {
        x = PAD.GET_DISABLED_CONTROL_NORMAL(2, 239),
        y = PAD.GET_DISABLED_CONTROL_NORMAL(2, 240)
    }
    if rect_x <= cursor_pos.x and rect_x + width >= cursor_pos.x then
        if rect_y <= cursor_pos.y and rect_y + height >= cursor_pos.y then
            return true
        end
    end
    return false
end

-- 临时
local function draw_string(text)
    local scale = 0.6
    local background = {
        ["r"] = 0.0,
        ["g"] = 0.0,
        ["b"] = 0.0,
        ["a"] = 0.6
    }
    local text_width, text_height = directx.get_text_size(text, scale)

    directx.draw_rect(0.5 - 0.01, 0.0, text_width + 0.02, text_height + 0.02, background)
    directx.draw_text(0.5, 0.01, text, ALIGN_TOP_LEFT, scale, color.white)
end

-- 绘制鼠标指针
local function draw_cursor()
    local cursor_pos = {
        x = PAD.GET_DISABLED_CONTROL_NORMAL(2, 239),
        y = PAD.GET_DISABLED_CONTROL_NORMAL(2, 240)
    }
    directx.draw_texture(cursor_texture, 0.005, 0.005, 0.5, 0.5, cursor_pos.x, cursor_pos.y, 0, color.white)
end

-- 绘制分割线
local function draw_div()
    directx.draw_line(window.x, draw.y, window.x + window.width, draw.y, window_color.div)
    draw.height = 0.01
    to_draw_next_line(0.01)
end

-- 绘制文本 无背景
local function draw_text(name, scale)
    local width, height = directx.get_text_size(name, scale)

    if is_out_of_window_width(width) then
        to_draw_next_line(0.01)
    end

    directx.draw_text(draw.x, draw.y, name, ALIGN_TOP_LEFT, scale, color.white)
    add_width_and_height(width, height)
end

-- 绘制输入框
local function draw_input(name, value, scale, on_input)
    local padding = 0.005

    local text = name .. ": " .. value
    value = tostring(value)

    local text_width, text_height = directx.get_text_size(text, scale)
    local width, height = text_width + padding * 2, text_height + padding * 2

    if is_out_of_window_width(width) then
        to_draw_next_line(0.01)
    end

    directx.draw_rect(draw.x, draw.y, width, height, button_color.background)
    local text_x, text_y = draw.x + padding, draw.y + padding
    directx.draw_text(text_x, text_y, text, ALIGN_TOP_LEFT, scale, button_color.text)

    if is_overlap_in_rect(draw.x, draw.y, width, height) then
        if PAD.IS_CONTROL_JUST_PRESSED(2, 18) then
            if on_input ~= nil then
                local input = get_input_from_screen_keyboard(customLabels.EnterValue, 10, value)
                on_input(input)
            end
        end
    end

    add_width_and_height(width, height)
end

-- 绘制按钮
local function draw_button(name, scale, on_click, on_overlap)
    local padding = 0.005

    local text_width, text_height = directx.get_text_size(name, scale)
    local width, height = text_width + padding * 2, text_height + padding * 2

    if is_out_of_window_width(width) then
        to_draw_next_line(0.01)
    end

    directx.draw_rect(draw.x, draw.y, width, height, button_color.background)
    local text_x, text_y = draw.x + padding, draw.y + padding
    directx.draw_text(text_x, text_y, name, ALIGN_TOP_LEFT, scale, button_color.text)

    if is_overlap_in_rect(draw.x, draw.y, width, height) then
        if PAD.IS_CONTROL_JUST_PRESSED(2, 18) then
            if on_click ~= nil then
                on_click()
            end
        else
            if on_overlap ~= nil then
                on_overlap()
            end
        end
    end

    add_width_and_height(width, height)
end

-- 绘制复选按钮
local function draw_toggle(name, toggle, scale, on_click)
    local padding = 0.005

    local text = name .. ": Off"
    if toggle then
        text = name .. ": On"
    end

    local text_width, text_height = directx.get_text_size(text, scale)
    local width, height = text_width + padding * 2, text_height + padding * 2

    if is_out_of_window_width(width) then
        to_draw_next_line(0.01)
    end

    directx.draw_rect(draw.x, draw.y, width, height, button_color.background)
    local text_x, text_y = draw.x + padding, draw.y + padding
    directx.draw_text(text_x, text_y, text, ALIGN_TOP_LEFT, scale, button_color.text)

    if is_overlap_in_rect(draw.x, draw.y, width, height) then
        if PAD.IS_CONTROL_JUST_PRESSED(2, 18) then
            if on_click ~= nil then
                toggle = not toggle
                on_click(toggle)
            end
        end
    end

    add_width_and_height(width, height)
end

-- 绘制滑动按钮，但不能滑
local function draw_slider(name, value, scale, on_input, on_sub, on_add)
    local padding = 0.005

    local text = name .. ": " .. value
    value = tostring(value)

    --Text
    local text_width, text_height = directx.get_text_size(text, scale)
    local width = text_width + padding * 2
    local height = text_height + padding * 2

    if is_out_of_window_width(width) then
        to_draw_next_line(0.01)
    end

    --background
    directx.draw_rect(draw.x, draw.y, width, height, button_color.background)

    local text_x, text_y = draw.x + padding, draw.y + padding
    directx.draw_text(text_x, text_y, text, ALIGN_TOP_LEFT, scale, button_color.text)

    if is_overlap_in_rect(draw.x, draw.y, width, height) then
        if PAD.IS_CONTROL_JUST_PRESSED(2, 18) then
            if on_input ~= nil then
                local input = get_input_from_screen_keyboard(customLabels.EnterValue, 10, value)
                on_input(input)
            end
        end
    end

    --Button
    local draw_x, draw_y = draw.x + width + 0.001, draw.y
    local btn_width, btn_height = directx.get_text_size("+", scale)
    local btn_bg_width = btn_width + padding * 2
    local btn_bg_height = btn_height + padding * 2

    --background
    directx.draw_rect(draw_x, draw_y, btn_bg_width, btn_bg_height, button_color.background)
    directx.draw_rect(draw_x + btn_bg_width + 0.001, draw_y, btn_bg_width, btn_bg_height, button_color.background)

    local btn_x, btn_y = draw_x + padding, draw_y + padding
    directx.draw_text(btn_x, btn_y, "-", ALIGN_TOP_LEFT, scale, button_color.text)
    directx.draw_text(draw_x + btn_bg_width + 0.001 + padding, btn_y, "+", ALIGN_TOP_LEFT, scale, button_color.text)

    -- Sub
    if is_overlap_in_rect(draw_x, draw_y, btn_bg_width, btn_bg_height) then
        if PAD.IS_CONTROL_JUST_PRESSED(2, 18) then
            if on_sub ~= nil then
                on_sub(value)
            end
        end
    end
    -- Add
    if is_overlap_in_rect(draw_x + btn_bg_width + 0.001, draw_y, btn_bg_width, btn_bg_height) then
        if PAD.IS_CONTROL_JUST_PRESSED(2, 18) then
            if on_add ~= nil then
                on_add(value)
            end
        end
    end

    width = width + draw_x + btn_bg_width * 2 + 0.001
    add_width_and_height(width, height)
end

------------------------
-- 绘制 菜单窗口
------------------------
local function draw_menu_window(ent)
    directx.draw_rect(window.x, window.y, window.width, window.height, window_color.background)
    draw.x, draw.y = window.x + window.padding, window.y + window.padding

    ------ title ------
    local text = "模型名字: " .. ent_data.model_name .. "\n模型Hash: " .. ent_data.model_hash
    draw_text(text, 0.6)
    to_draw_next_line(0.02)
    draw_div()
    ------ tabs ------
    draw_button("实体选项", 0.6, function()
        draw_menu_select = "entity"
    end)
    --Vehicle
    if ENTITY.IS_ENTITY_A_VEHICLE(ent) then
        draw_button("载具选项", 0.6, function()
            draw_menu_select = "vehicle"
        end)
    end
    --Ped
    if ENTITY.IS_ENTITY_A_PED(ent) then
        draw_button("Ped选项", 0.6, function()
            draw_menu_select = "ped"
        end)
        --Player
        if is_ped_player(ent) then
            draw_button("移除玩家选项", 0.6, function()
                draw_menu_select = "player"
            end)
        end
    end

    to_draw_next_line(0.02)
    draw_div()
end

------------------------
-- 绘制 Entity 菜单选项
------------------------
local function draw_entity_menu(ent)
    draw_menu_window(ent)

    ------ options ------
    draw_toggle("冻结", ent_data.freeze, 0.6, function(toggle)
        ent_data.freeze = toggle
        ENTITY.FREEZE_ENTITY_POSITION(ent, toggle)
    end)
    draw_toggle("重力", ent_data.gravity, 0.6, function(toggle)
        ent_data.gravity = toggle
        ENTITY.SET_ENTITY_HAS_GRAVITY(ent, toggle)
    end)
    draw_button("爆炸", 0.6, function()
        local pos = ENTITY.GET_ENTITY_COORDS(ent)
        FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z - 0.5, EXP_TAG_STICKYBOMB, 5.0, true, false, 0.0, false)
    end)
    draw_toggle("可见的", ent_data.visible, 0.6, function(toggle)
        ent_data.visible = toggle
        ENTITY.SET_ENTITY_VISIBLE(ent, toggle, 0)
    end)
    draw_toggle("可碰撞", ent_data.collision, 0.6, function(toggle)
        ent_data.collision = toggle
        ENTITY.SET_ENTITY_COLLISION(ent, toggle, true)
    end)
    to_draw_next_line(0.01)

    draw_input("当前血量", ent_data.health, 0.6, function(value)
        value = tonumber(value)
        if value ~= nil then
            ent_data.health = value
            ENTITY.SET_ENTITY_HEALTH(ent, value)
        end
    end)
    draw_input("最大血量", ent_data.max_health, 0.6, function(value)
        value = tonumber(value)
        if value ~= nil then
            ent_data.max_health = value
            ENTITY.SET_ENTITY_MAX_HEALTH(ent, value)
        end
    end)
    to_draw_next_line(0.01)
    draw_div()

    draw_button("传送到我", 0.6, function()
        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), ent_data.tp_x, ent_data.tp_y,
            ent_data.tp_z)
        ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
    end)
    draw_button("传送到实体", 0.6, function()
        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ent, ent_data.tp_x, ent_data.tp_y,
            ent_data.tp_z)
        ENTITY.SET_ENTITY_COORDS(players.user_ped(), coords.x, coords.y, coords.z, true, false, false, false)
    end)
    to_draw_next_line(0.01)
    draw_div()
    draw_button("看门狗V2由夜幕-Ping制作，CV请鸣谢夜幕！", 0.7, function()
    end)


    to_draw_next_line(0.01)

end

------------------------
-- 绘制 Vehicle 菜单选项
------------------------
local function draw_vehicle_menu(vehicle)
    draw_menu_window(vehicle)

    ------ options ------
    draw_button("传送到载具", 0.6, function()
        if VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(vehicle) then
            PED.SET_PED_INTO_VEHICLE(players.user_ped(), vehicle, -2)
        else
            util.toast("载具已无空座位")
        end
    end)
    draw_button("传送到驾驶位", 0.6, function()
        if VEHICLE.IS_VEHICLE_SEAT_FREE(vehicle, -1, false) then
            PED.SET_PED_INTO_VEHICLE(players.user_ped(), vehicle, -1)
        else
            local ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1)
            if ped and not is_ped_player(ped) then
                local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, 0.0, 0.0, 3.0)
                ENTITY.SET_ENTITY_COORDS(ped, coords.x, coords.y, coords.z, true, false, false, false)
                PED.SET_PED_INTO_VEHICLE(players.user_ped(), vehicle, -1)
            else
                util.toast("驾驶位可能是玩家，无法传送")
            end
        end
    end)
    draw_button("传送到副驾驶位", 0.6, function()
        if VEHICLE.GET_VEHICLE_NUMBER_OF_PASSENGERS(vehicle, true, false) > 1 then
            if VEHICLE.IS_VEHICLE_SEAT_FREE(vehicle, 0, false) then
                PED.SET_PED_INTO_VEHICLE(players.user_ped(), vehicle, 0)
            else
                local ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, 0)
                if ped and not is_ped_player(ped) then
                    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(vehicle, 0.0, 0.0, 3.0)
                    ENTITY.SET_ENTITY_COORDS(ped, coords.x, coords.y, coords.z, true, false, false, false)
                    PED.SET_PED_INTO_VEHICLE(players.user_ped(), vehicle, 0)
                else
                    util.toast("副驾驶位可能是玩家，无法传送")
                end
            end
        end
    end)
    to_draw_next_line(0.01)

    draw_toggle("载具门锁", veh_data.door_lock, 0.6, function(toggle)
        veh_data.door_lock = toggle
        if toggle then
            VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, 2)
            VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(vehicle, true)
        else
            VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, 1)
            VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER(vehicle, players.user(), false)
            VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(vehicle, false)
        end
    end)
    draw_button("将载具调头", 0.6, function()
            local rot = ENTITY.GET_ENTITY_ROTATION(vehicle, 0)
            local vel = ENTITY.GET_ENTITY_VELOCITY(vehicle)
            ENTITY.SET_ENTITY_ROTATION(vehicle, rot['x'], rot['y'], rot['z']+180, 0, true)
            ENTITY.SET_ENTITY_VELOCITY(vehicle, -vel['x'], -vel['y'], vel['z'])
    end)
    draw_button("将载具翻转", 0.6, function()
            local rot = ENTITY.GET_ENTITY_ROTATION(car, 0)
            local vel = ENTITY.GET_ENTITY_VELOCITY(car)
            ENTITY.SET_ENTITY_ROTATION(car, rot['x'], rot['y']+180, rot['z'], 0, true)
            ENTITY.SET_ENTITY_VELOCITY(car, -vel['x'], -vel['y'], vel['z'])
    end)

    draw_button("清空载具", 0.6, function()
        for i = -1, 4 do
            if not VEHICLE.IS_VEHICLE_SEAT_FREE(vehicle, i, true) then
                local ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, i, true)
                if ped then
                    TASK.TASK_LEAVE_VEHICLE(ped, vehicle, 16)
                end
            end
        end
    end)
    to_draw_next_line(0.01)
    draw_button("打开车门", 0.6, function()
        if vehicle ~= 0 then
            request_control_of_entity(vehicle)
            local d = VEHICLE.GET_NUMBER_OF_VEHICLE_DOORS(vehicle)
            for i=0, d do
                        VEHICLE.SET_VEHICLE_DOOR_OPEN(vehicle, i, false, true)
                        break
            end
        end
    end)
    draw_button("关闭车门", 0.6, function()
        if vehicle ~= 0 then
            request_control_of_entity(vehicle)
            local d = VEHICLE.GET_NUMBER_OF_VEHICLE_DOORS(vehicle)
            for i=0, d do
                        VEHICLE.SET_VEHICLE_DOOR_SHUT(vehicle, i, true)
                        break
            end
        end
    end)
    draw_button("损坏车门", 0.6, function()
        if vehicle ~= 0 then
            request_control_of_entity(vehicle)
            local d = VEHICLE.GET_NUMBER_OF_VEHICLE_DOORS(vehicle)
            for i=0, d do
                        VEHICLE.SET_VEHICLE_DOOR_BROKEN(vehicle, i, false)
                        break
            end
        end
    end)
    draw_button("关掉它的发动机", 0.6, function()
        if vehicle ~= 0 then
            request_control_of_entity(vehicle)
            VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, false, true, false)
        end
    end)
    to_draw_next_line(0.01)
    draw_div()
    draw_button("看门狗V2由夜幕-Ping制作，CV请鸣谢夜幕！", 0.7, function()
    end)

    to_draw_next_line(0.01)

end

------------------------
-- 绘制 Ped 菜单选项
------------------------
local function draw_ped_menu(ped)
    draw_menu_window(ped)

    ------ options ------
    draw_button("传送到我的载具", 0.6, function()
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)
        if vehicle then
            PED.SET_PED_INTO_VEHICLE(ped, vehicle, -2)
        end
    end)
    draw_button("移除全部武器", 0.6, function()
        WEAPON.REMOVE_ALL_PED_WEAPONS(ped)
    end)
    to_draw_next_line(0.01)

    draw_button("随机变装", 0.6, function()
        PED.SET_PED_RANDOM_COMPONENT_VARIATION(ped, 0)
        PED.SET_PED_RANDOM_PROPS(ped)
    end)
    to_draw_next_line(0.01)
    draw_div()
    draw_button("看门狗V2由夜幕-Ping制作，CV请鸣谢夜幕！", 0.7, function()
    end)

    to_draw_next_line(0.01)
end

------------------------
-- 绘制 Player 菜单选项
------------------------
local function draw_player_menu(player_ped)
    draw_menu_window(player_ped)

    ------ options ------
    draw_button("此行为单体崩溃", 0.7, function()
    end)
    draw_button("主机崩溃-单体", 0.6, function()
        util.toast( "请等待7-15秒崩溃进程")
        local self_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
        menu.trigger_commands("tpmazehelipad")
        ENTITY.SET_ENTITY_COORDS(self_ped, -6170, 10837, 40, true, false, false)
        util.yield(1000)
        ENTITY.SET_ENTITY_COORDS(self_ped, -18, 708, 243, true, false, false)
        util.yield(1000)
        ENTITY.SET_ENTITY_COORDS(self_ped, -74, 100, 174, true, false, false)
        util.yield(1000)
        ENTITY.SET_ENTITY_COORDS(self_ped, -101, 100, 374, true, false, false)
        util.yield(1000)
        ENTITY.SET_ENTITY_COORDS(self_ped, -6170, 10837, 40, true, false, false)
        util.yield(900)
        ENTITY.SET_ENTITY_COORDS(self_ped, -18, 708, 243, true, false, false)
        util.yield(900)
        ENTITY.SET_ENTITY_COORDS(self_ped, -74, 100, 174, true, false, false)
        util.yield(900)
        ENTITY.SET_ENTITY_COORDS(self_ped, -101, 100, 374, true, false, false)
        util.yield(1000)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(self_ped, 24, 7643.5, 19, true, true, true)
        util.yield(1000)
        menu.trigger_commands("tpmtchiliad")
        menu.trigger_commands("tpmazehelipad")
        util.toast( "主机崩溃---结束")
    end)

    to_draw_next_line(0.02)
    draw_div()

    draw_button("此行为全局崩溃", 0.7, function()
    end)
    draw_button("满天星河-全局", 0.6, function()
    menu.trigger_commands("anticrashcam on")
    local user = players.user()
    local user_ped = players.user_ped()
    local pos = players.get_position(user)
    local cspped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    local TPpos = ENTITY.GET_ENTITY_COORDS(cspped, true)
    local cargobob = CreateVehicle(0XFCFCB68B, TPpos, ENTITY.GET_ENTITY_HEADING(SelfPlayerPed), true)
    local cargobobPos = ENTITY.GET_ENTITY_COORDS(cargobob, true)
    local veh = CreateVehicle(0X187D938D, TPpos, ENTITY.GET_ENTITY_HEADING(SelfPlayerPed), true)
    local vehPos = ENTITY.GET_ENTITY_COORDS(veh, true)
    local newRope = PHYSICS.ADD_ROPE(TPpos.x, TPpos.y, TPpos.z, 0, 0, 10, 1, 1, 0, 1, 1, false, false, false, 1.0, false, 0)
    PHYSICS.ATTACH_ENTITIES_TO_ROPE(newRope, cargobob, veh, cargobobPos.x, cargobobPos.y, cargobobPos.z, vehPos.x, vehPos.y, vehPos.z, 2, false, false, 0, 0, "Center", "Center")
        util.yield(80)
        PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(players.user(), 0xFBF7D21F)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user_ped, 0xFBAB5776, 100, false)
        TASK.TASK_PARACHUTE_TO_TARGET(user_ped, pos.x, pos.y, pos.z)
        util.yield()
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(user_ped)
        util.yield(250)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user_ped, 0xFBAB5776, 100, false)
        PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
        util.yield(1000)
        for i = 1, 5 do
            util.spoof_script("freemode", SYSTEM.WAIT)
        end
        ENTITY.SET_ENTITY_HEALTH(user_ped, 0)
        NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(pos.x,pos.y,pos.z, 0, false, false, 0)
        util.yield(2500)
    entities.delete_by_handle(cargobob)
    entities.delete_by_handle(veh)
    PHYSICS.DELETE_CHILD_ROPE(newRope)
    menu.trigger_commands("anticrashcam off")
    end)
    draw_button("人物伞崩-全局", 0.6, function()
util.toast("开崩")
for n = 0 , 5 do
    PEDP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
    object_hash = 2186304526
                                STREAMING.REQUEST_MODEL(object_hash)
  while not STREAMING.HAS_MODEL_LOADED(object_hash) do
       util.yield()
     end
    PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PEDP, 0,0,500, 0, 0, 1)
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PEDP, 0xFBAB5776, 1000, false)
    util.yield(800)
    for i = 0 , 20 do
    PED.FORCE_PED_TO_OPEN_PARACHUTE(PEDP)
    end
    util.yield(800)
    menu.trigger_commands("tpmazehelipad")
    end
    util.toast("崩溃执行结束")
end)

    to_draw_next_line(0.02)
    draw_div()
    draw_button("看门狗V2由夜幕-Ping制作，CV请鸣谢夜幕！", 0.7, function()
    end)

    to_draw_next_line(0.01)
end

-- 初始化实体数据
local function init_ent_data(ent)
    local model_hash = ENTITY.GET_ENTITY_MODEL(ent)
    local model_name = util.reverse_joaat(model_hash)
    local health = ENTITY.GET_ENTITY_HEALTH(ent)
    local max_health = ENTITY.GET_ENTITY_MAX_HEALTH(ent)

    ent_data = {
        model_hash = model_hash,
        model_name = model_name,
        ----- ENTITY -----
        godmode = false,
        freeze = false,
        fire = false,
        visible = true,
        collision = true,
        gravity = true,
        --health
        health = health,
        max_health = max_health,
        --teleport
        tp_x = 0.0,
        tp_y = 2.0,
        tp_z = 0.0,
    }

    if ENTITY.IS_ENTITY_A_VEHICLE(ent) then
        veh_data = {
            door_lock = false,
        }

        local lock_state = VEHICLE.GET_VEHICLE_DOOR_LOCK_STATUS(ent)
        if lock_state == 2 or lock_state == 3 or lock_state == 4 or lock_state == 8 or lock_state == 10 then
            veh_data.door_lock = true
        end
    end

end

-----主菜单
last_ent = nil --上一个实体
tick_ent = nil --正在控制的实体
is_pressed_key = false --是否按下了呼出按键
draw_menu_select = "entity" --正在描绘的菜单选项
local toggle_cursor_key = 21 --SHIFT

Watchdogs = menu.toggle_loop(online, "看门狗V2模式", {}, "开启后会禁用弹出手机\nSHIFT建呼出菜单\n可以使用夜幕保存加载配置！", function()
    --draw point
    directx.draw_texture(point_texture, 0.0015, 0.0015, 0.5, 0.5, 0.5, 0.5, 0, color.white)
    toggle_cellphone_state(false)
    local ent = get_entity_is_looking_at()
    if is_an_entity(ent) then
        draw_line_to_entity(ent)
        if PAD.IS_CONTROL_JUST_RELEASED(2, toggle_cursor_key) then
            --disable
            if is_pressed_key then
                is_pressed_key = false
                tick_ent = nil
                draw_menu_select = "entity"
            else
                --enable
                if last_ent ~= ent then
                    init_ent_data(ent)
                    last_ent = ent
                end
                is_pressed_key = true
                tick_ent = ent
            end
            toggle_cursor_mode(is_pressed_key)
        end
    else
        --disable
        if PAD.IS_CONTROL_JUST_RELEASED(2, toggle_cursor_key) then
            if is_pressed_key then
                tick_ent = nil
                is_pressed_key = false
                draw_menu_select = "entity"
                toggle_cursor_mode(false)
            end
        end
    end

    if is_pressed_key == true and tick_ent ~= nil then
        if not ENTITY.DOES_ENTITY_EXIST(tick_ent) then
            tick_ent = nil
            is_pressed_key = false
            draw_menu_select = "entity"
            toggle_cursor_mode(false)
            util.toast("实体已经不存在")
        end
        if draw_menu_select == "entity" then
            draw_entity_menu(tick_ent)
        elseif draw_menu_select == "vehicle" then
            draw_vehicle_menu(tick_ent)
        elseif draw_menu_select == "ped" then
            draw_ped_menu(tick_ent)
        elseif draw_menu_select == "player" then
            draw_player_menu(tick_ent)
        end

        draw_cursor()
    end

end, function()
    tick_ent = nil
    is_pressed_key = false
    draw_menu_select = "entity"
    toggle_cursor_mode(false)
    toggle_cellphone_state(true)
end)
menu.set_value(Watchdogs, config_active12)




