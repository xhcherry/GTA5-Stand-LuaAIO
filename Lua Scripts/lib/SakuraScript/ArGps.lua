local MARKER_ARROW = 2
local arrow_spacing = 2
local line_smoothing = 0.5
local line_z_offset = -1
local lowering_strength = 6
local max_nodes = 25
local arrow_colours = {r = 255, g = 234, b = 0, a = 100}

menu.slider(Veh_AR_GPS, "最大节点数", {}, "较高的数字可能会导致滞后或卡顿", 5, 100, max_nodes, 1, function(value)
    max_nodes = value
end)
menu.slider(Veh_AR_GPS, "标记外观", {}, "更改用于标记外观样式", 1, 44, MARKER_ARROW, 1, function(value)
    MARKER_ARROW = value
end)
menu.slider(Veh_AR_GPS, "标记空间", {}, "每个标记之间的间距", 1, 20, arrow_spacing, 1, function(value)
    arrow_spacing = value
end)

menu.rainbow(menu.colour(Veh_AR_GPS, "颜色", {"arggpscolour"}, "", arrow_colours.r / 255, arrow_colours.g / 255, arrow_colours.b / 255, arrow_colours.a / 255, true, function(value)
    arrow_colours = {r = math.floor(value.r * 255), g = math.floor(value.g * 255), b = math.floor(value.b * 255), a = math.floor(value.a * 255)}
end))

local function quadraticBezierCurve(p0, p1, p2, t)
    local a = (1 - t) ^ 2
    local b = 2 * (1 - t) * t
    local c = t ^ 2

    local term1 = v3(p0):mul(a)
    local term2 = v3(p1):mul(b)
    local term3 = v3(p2):mul(c)

    local result = term1:add(term2):add(term3)

    local u = 1 - t
    local term4 = v3(p1):sub(p0):mul(2 * u)
    local term5 = v3(p2):sub(p1):mul(2 * t)
    term4:add(term5)

    return result, term4
end

local function draw_arrows_between_points(point_a, point_b)
    local dist = v3.distance(point_a, point_b)
    local count = math.floor(dist / arrow_spacing)
    local dir = v3(point_b):sub(point_a):normalise()
    local player_pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())

    for i = 0, count do
        local draw_pos = v3(dir):mul(i * arrow_spacing):add(point_a)
        local dist = v3.distance(draw_pos, player_pos)
        draw_pos.z = draw_pos.z - (lowering_strength / dist) - line_z_offset
        GRAPHICS.DRAW_MARKER(MARKER_ARROW, draw_pos.x, draw_pos.y, draw_pos.z, dir.x, dir.y, dir.z, 90, 0, 0, 1, 1, 1, arrow_colours.r, arrow_colours.g, arrow_colours.b, arrow_colours.a, false, false, 0, false, 0, 0, false)
    end
end

local function draw_arrows_between_points_smooth(point_a, point_b, point_c)
    local dist = v3.distance(point_a, point_b) + v3.distance(point_b, point_c)
    local count = math.floor(dist / arrow_spacing)
    local player_pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())

    for i = 1, count do
        local t = 1 - i / count
        local draw_pos, dir = quadraticBezierCurve(point_a, point_b, point_c, t)

        draw_pos.z = draw_pos.z - (lowering_strength / v3.distance(draw_pos, player_pos)) - line_z_offset
        GRAPHICS.DRAW_MARKER(MARKER_ARROW, draw_pos.x, draw_pos.y, draw_pos.z, dir.x, dir.y, dir.z, 90, 0, 0, 1, 1, 1, arrow_colours.r, arrow_colours.g, arrow_colours.b, arrow_colours.a, false, false, 0, false, 0, 0, false)
    end
end

local function get_corner_points(point_a, point_b, point_c)
    local b_to_a = v3(point_a):sub(point_b)
    local b_to_c = v3(point_c):sub(point_b)

    b_to_a:mul(line_smoothing):add(point_b)
    b_to_c:mul(line_smoothing):add(point_b)

    return b_to_a, b_to_c
end

local function get_route_clean(max_nodes)
    local route = util.get_gps_route(0)
    local result = {}
    for i, node in ipairs(route) do
        if #result >= max_nodes then break end
        if node.junction then
            goto continue
        end
        table.insert(result, v3(node.x, node.y, node.z))
        ::continue::
    end
    return result
end

menu.toggle_loop(Veh_AR_GPS, "AR GPS", {}, "沿gps路线绘制箭头", function()
    local points = get_route_clean(max_nodes)
    local start_point = nil
    for i = 1, #points do
        if points[i + 2] then
            local subpoint_a, subpoint_b = get_corner_points(start_point or points[i], points[i + 1], points[i + 2])
            draw_arrows_between_points(start_point or points[i], subpoint_a)
            draw_arrows_between_points_smooth(subpoint_a, points[i + 1], subpoint_b)
            start_point = subpoint_b
        elseif points[i + 1] then
            draw_arrows_between_points(start_point or points[i], points[i + 1])
        end
    end
end)