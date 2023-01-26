util.require_no_lag('natives-1640181023')

b_properties = {}
b_properties.new = function ()
    local self = {}

    --self.CPedFactory = get_CpedFactory_pointer()

    self.player_ped_id = function ()
        return PLAYER.PLAYER_PED_ID()
    end

    self.aspect_ratio_16_9 = 16/9
    return self
end

b_common_funcs = {}
b_common_funcs.new = function ()
    local self = {}
    --credit to Nowiry#2663 and QuickNET#9999 for this one
    self.address_from_pointer_chain = function (basePtr, offsets)
        local addr = memory.read_long(basePtr)
        for k = 1, (#offsets - 1) do
            addr = memory.read_long(addr + offsets[k])
            if addr == 0 then
                return 0
            end
        end
        addr = addr + offsets[#offsets]
        return addr
    end
    self.get_player_vehicle_class = function ()
        local veh = entities.get_user_vehicle_as_handle()
        return VEHICLE.GET_VEHICLE_CLASS(veh)
    end
    self.get_ascpect_ratio = function()
        local screen_x, screen_y = directx.get_client_size()
    
        return screen_x / screen_y
    end
    self.to_bits = function(num)
        -- returns a table of bits, least significant first.
        local t={} -- will contain the bits
        while num>0 do
            rest=math.fmod(num,2)
            t[#t+1]=rest
            num=(num-rest)/2
        end
        return t
    end
    self.split = function (input, sep)
        local t={}
        for str in string.gmatch(input, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
    end
    local minimum = memory.alloc()
    local maximum = memory.alloc()
    self.get_pos_above_entity = function (entity)
        MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(entity), minimum, maximum)
        local maximum_vec = memory.read_vector3(maximum)
        return ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, 0, 0, maximum_vec.z)
    end
    self.copy_File = function(old_path, new_path)
        local old_file = io.open(old_path, "rb")
        local new_file = io.open(new_path, "wb")
        local old_file_sz, new_file_sz = 0, 0
        if not old_file or not new_file then
          return false
        end
        while true do
          local block = old_file:read(2^13)
          if not block then 
            old_file_sz = old_file:seek( "end" )
            break
          end
          new_file:write(block)
        end
        old_file:close()
        new_file_sz = new_file:seek( "end" )
        new_file:close()
        return new_file_sz == old_file_sz
      end
    return self
end

b_math_funcs = {}
b_math_funcs.new = function ()
    local self = {}
    self.lerp = function(a, b, t)
        return a + (b - a) * t
    end
    local EPSILON = 0.0000001
    self.RayIntersectsTriangle = function(rayOrigin, rayDirection, vertex1, vertex2, vertex3)
        local edge1, edge2, h, s, q, a, f, u, v
        edge1 = {x = vertex2.x - vertex1.x, y = vertex2.y - vertex1.y, z = vertex2.z - vertex1.z}
        edge2 = {x = vertex3.x - vertex1.x, y = vertex3.y - vertex1.y, z = vertex3.z - vertex1.z}
        h = {
            x =    edge2.y * rayDirection.z - edge2.z * rayDirection.y,
            y =    edge2.z * rayDirection.x - edge2.x * rayDirection.z,
            z =    edge2.x * rayDirection.y - edge2.y * rayDirection.x
        }
        a = h.x * edge1.x + h.y * edge1.y + h.z * edge1.z

        if a > -EPSILON and a < EPSILON then return false end

        f = 1.0/a
        s = {x = rayOrigin.x - vertex1.x, y = rayOrigin.y - vertex1.y, z = rayOrigin.z - vertex1.z}
        u = f * (h.x * s.x + h.y * s.y + h.z * s.z)
        if u < 0.0 or u > 1.0 then return false end
        q = {
            x =    edge1.y * s.z - edge1.z * s.y,
            y =    edge1.z * s.x - edge1.x * s.z,
            z =    edge1.x * s.y - edge1.y * s.x
        }
        v = f * (rayDirection.x * q.x + rayDirection.y * q.y + rayDirection.z * q.z)
        if v < 0.0 or u + v > 1.0 then return false end
        t = f *  (edge2.x * q.x + edge2.y * q.y + edge2.z * q.z)
        if t > EPSILON then
            return true, {
                x = rayOrigin.x + rayDirection.x * t,
                y = rayOrigin.y + rayDirection.y * t,
                z = rayOrigin.z + rayDirection.z * t
            }
        else
            return false
        end
    end
    return self
end

b_drawing_funcs = {}
b_drawing_funcs.new = function ()
    local self = {}
    self.draw_arrow = function(pos, angle, size, colour_a, colour_b)
        local angle_cos = math.cos(angle)
        local angle_sin = math.sin(angle)
    
        local width = 0.5 * size
        local length = 1 * size
        local height = 0.25 * size
    
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * -width - angle_sin * -length),
            pos.y + (angle_sin * -width + angle_cos * -length),
            pos.z + 0,
            pos.x + (angle_cos * 0 - angle_sin * -width),
            pos.y + (angle_sin * 0 + angle_cos * -width),
            pos.z + -height,
            pos.x + (angle_cos * 0 - angle_sin * -width),
            pos.y + (angle_sin * 0 + angle_cos * -width),
            pos.z + height,
            colour_b.r,
            colour_b.g,
            colour_b.b,
            colour_b.a
        )
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * 0 - angle_sin * -width),
            pos.y + (angle_sin * 0 + angle_cos * -width),
            pos.z + -height,
            pos.x + (angle_cos * width - angle_sin * -length),
            pos.y + (angle_sin * width + angle_cos * -length),
            pos.z + 0,
            pos.x + (angle_cos * 0 - angle_sin * -width),
            pos.y + (angle_sin * 0 + angle_cos * -width),
            pos.z + height,
            colour_a.r,
            colour_a.g,
            colour_a.b,
            colour_a.a
        )
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * width - angle_sin * -length),
            pos.y + (angle_sin * width + angle_cos * -length),
            pos.z + 0,
            pos.x + (angle_cos * 0 - angle_sin * width),
            pos.y + (angle_sin * 0 + angle_cos * width),
            pos.z + 0,
            pos.x + (angle_cos * 0 - angle_sin * -width),
            pos.y + (angle_sin * 0 + angle_cos * -width),
            pos.z + height,
            colour_a.r,
            colour_a.g,
            colour_a.b,
            colour_a.a
        )
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * 0 - angle_sin * width),
            pos.y + (angle_sin * 0 + angle_cos * width),
            pos.z + 0,
            pos.x + (angle_cos * width - angle_sin * -length),
            pos.y + (angle_sin * width + angle_cos * -length),
            pos.z + 0,
            pos.x + (angle_cos * 0 - angle_sin * -width),
            pos.y + (angle_sin * 0 + angle_cos * -width),
            pos.z + -height,
            colour_a.r,
            colour_a.g,
            colour_a.b,
            colour_a.a
        )
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * -width - angle_sin * -length),
            pos.y + (angle_sin * -width + angle_cos * -length),
            pos.z + 0,
            pos.x + (angle_cos * 0 - angle_sin * width),
            pos.y + (angle_sin * 0 + angle_cos * width),
            pos.z + 0,
            pos.x + (angle_cos * 0 - angle_sin * -width),
            pos.y + (angle_sin * 0 + angle_cos * -width),
            pos.z + -height,
            colour_b.r,
            colour_b.g,
            colour_b.b,
            colour_b.a
        )
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * 0 - angle_sin * width),
            pos.y + (angle_sin * 0 + angle_cos * width),
            pos.z + 0,
            pos.x + (angle_cos * -width - angle_sin * -length),
            pos.y + (angle_sin * -width + angle_cos * -length),
            pos.z + 0,
            pos.x + (angle_cos * 0 - angle_sin * -width),
            pos.y + (angle_sin * 0 + angle_cos * -width),
            pos.z + height,
            colour_b.r,
            colour_b.g,
            colour_b.b,
            colour_b.a
        )
    end
    self.draw_arrow_down = function(pos, angle, size, colour_a, colour_b)
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
    self.draw_quad = function (pos1_org, pos2_org, size, colour_a, colour_b, dict, texture)
        GRAPHICS.REQUEST_STREAMED_TEXTURE_DICT(dict, false)
        if GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED(dict) then
            pos1 =  {x = pos1_org.x, y = pos1_org.y, z = pos1_org.z}
            pos2 =  {x = pos2_org.x, y = pos2_org.y, z = pos2_org.z}
            pos2.z = pos2.z - size * 0.5
            pos1.z = pos1.z - size * 0.5
            GRAPHICS.SET_BACKFACECULLING(false)
            GRAPHICS._DRAW_SPRITE_POLY_2(
                pos1.x,     pos1.y,             pos1.z,
                pos2.x,     pos2.y,             pos2.z,
                pos2.x,     pos2.y,             pos2.z + size,
                colour_b.r, colour_b.g, colour_b.b, colour_b.a,
                colour_b.r, colour_b.g, colour_b.b, colour_b.a,
                colour_b.r, colour_b.g, colour_b.b, colour_b.a,
                dict,
                texture,
                0, 1, 0, 
                1, 1, 0,
                0, 0, 0
            )
              GRAPHICS._DRAW_SPRITE_POLY_2(
                pos1.x,     pos1.y,             pos1.z + size,
                pos1.x,     pos1.y,             pos1.z,
                pos2.x,     pos2.y,             pos2.z + size,
                colour_a.r, colour_a.g, colour_a.b, colour_a.a,
                colour_a.r, colour_a.g, colour_a.b, colour_a.a,
                colour_a.r, colour_a.g, colour_a.b, colour_a.a,
                dict,
                texture,
                0, 0, 0,
                1, 1, 0,
                1, 0, 0
            )
        else
            util.toast("not loaded")
        end 
    end
    self.arc_line = {}
    self.arc_line.new = function ()
        arc = {}
        arc.instability = 0.75
        arc.draw = function (pos1, pos2)
            local dif = {x = pos2.x - pos1.x, y = pos2.y - pos1.y, z = pos2.z - pos1.z}
            local distance_to_cover = math.sqrt(
                (dif.x * dif.x) +
                (dif.y * dif.y) +
                (dif.z * dif.z)
            )
            local nor_dir = {x = dif.x / distance_to_cover, y = dif.y / distance_to_cover,z = dif.z / distance_to_cover}

            for _ = 0, 3, 1 do
                local distance_covered = math.random() * 1.5
                local previous_pos = pos1
                repeat
                    local current_pos = {
                        x = pos1.x + nor_dir.x * distance_covered + (math.random() - 0.5) * arc.instability,
                        y = pos1.y + nor_dir.y * distance_covered + (math.random() - 0.5) * arc.instability,
                        z = pos1.z + nor_dir.z * distance_covered + (math.random() - 0.5) * arc.instability
                    }
                    GRAPHICS.DRAW_LINE(
                        previous_pos.x, previous_pos.y, previous_pos.z,
                        current_pos.x , current_pos.y , current_pos.z,
                        0, 255, 255, 255
                    )
                    previous_pos = current_pos
                    distance_covered = distance_covered + math.random() * 1.5
                until distance_covered > distance_to_cover
                GRAPHICS.DRAW_LINE(
                    previous_pos.x, previous_pos.y, previous_pos.z,
                    pos2.x , pos2.y , pos2.z,
                    0, 255, 255, 255
                )
            end

            arc.instability = arc.instability + (0.15 - arc.instability) *  MISC.GET_FRAME_TIME() * 7
        end
        return arc
    end
    local minimum = memory.alloc()
    local maximum = memory.alloc()
    local upVector_pointer = memory.alloc()
    local rightVector_pointer = memory.alloc()
    local forwardVector_pointer = memory.alloc()
    local position_pointer = memory.alloc()
    self.draw_bounding_box = function (entity, colour)
        ENTITY.GET_ENTITY_MATRIX(entity, rightVector_pointer, forwardVector_pointer, upVector_pointer, position_pointer);
        local forward_vector = memory.read_vector3(forwardVector_pointer)
        local right_vector = memory.read_vector3(rightVector_pointer)
        local up_vector = memory.read_vector3(upVector_pointer)

        MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(entity), minimum, maximum)
        local minimum_vec = memory.read_vector3(minimum)
        local maximum_vec = memory.read_vector3(maximum)
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
    local numbers = {}
    local x_coord_ptr = memory.alloc(4)
    local y_coord_ptr = memory.alloc(4)
    local draw_numbers = function ()
        util.create_tick_handler(function() 
            local delta_time = MISC.GET_FRAME_TIME()
            for i, number in ipairs(numbers) do
                if GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(number.pos.x, number.pos.y, number.pos.z, x_coord_ptr, y_coord_ptr) then
                    local x = memory.read_float(x_coord_ptr)
                    local y = memory.read_float(y_coord_ptr)
                    local alpha = math.min(1, number.time)
                    directx.draw_text(x, y, number.num, ALIGN_CENTRE, number.size, {r = number.colour.r * alpha,g = number.colour.g * alpha,b = number.colour.b * alpha,a = number.colour.a * alpha}, false)
                    number.pos.z = number.pos.z + 0.2 * delta_time
                end
                number.time = number.time - delta_time
                if number.time < 0 then
                    table.remove(numbers, i)
                end
            end
            return #numbers ~= 0
        end)
    end
    local random_offset = 1
    self.draw_damage_number = function(entity, num, colour, size)
        pos = ENTITY.GET_ENTITY_COORDS(entity)
        random_offset_pos = {x = pos.x + (math.random() * random_offset - random_offset * 0.5),y = pos.y + (math.random() * random_offset - random_offset * 0.5),z = pos.z}
        numbers[#numbers+1] = {
            pos = random_offset_pos,
            colour = colour,
            num = num,
            size = size,
            time = 3
        }
        if #numbers == 1 then
            draw_numbers()
        end
    end
    --all credit to Nowiry#2663 for this one
    self.draw_button_tip = function (buttons, duration, colour)
        function equals(l1, l2)
            if l1 == l2 then return true end
            local type1 = type(l1)
            local type2 = type(l2)
            if type1 ~= type2 then return false end
            if type1 ~= 'table' then return false end
            for k, v in pairs(l1) do
                if not l2[ k ] or not equals(v, l2[ k ]) then
                    return false
                end
            end
            return true
        end
        local timer = 0
        util.create_tick_handler(function ()
            local INSTRUCTIONAL = {}
        INSTRUCTIONAL.scaleform = GRAPHICS.REQUEST_SCALEFORM_MOVIE('instructional_buttons')
        INSTRUCTIONAL.isKeyboard = PAD._IS_USING_KEYBOARD(2)
    
        if not equals(buttons, INSTRUCTIONAL.currentsettup) or INSTRUCTIONAL.isKeyboard ~= PAD._IS_USING_KEYBOARD(2) then
            local colour = colour or {
                ['r'] = 0,
                ['g'] = 0,
                ['b'] = 0
            }
    
            while not GRAPHICS.HAS_SCALEFORM_MOVIE_LOADED(INSTRUCTIONAL.scaleform) do
                util.yield()
            end
            
            GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(INSTRUCTIONAL.scaleform, 'CLEAR_ALL')
            GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
    
            GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(INSTRUCTIONAL.scaleform, 'TOGGLE_MOUSE_BUTTONS')
            GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_BOOL(true)
            GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
    
            for i = 1, #buttons do
                GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(INSTRUCTIONAL.scaleform, 'SET_DATA_SLOT')
                GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(i) --position
                GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_PLAYER_NAME_STRING(PAD.GET_CONTROL_INSTRUCTIONAL_BUTTON(2, buttons[i][2], true)) --control
                GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING(buttons[i][1]) --name
                GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_BOOL(buttons[i][3] or false) --clickable
                GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(buttons[i][2]) --what control will be pressed when you click the button
                GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
            end
    
            GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(INSTRUCTIONAL.scaleform, 'SET_BACKGROUND_COLOUR')
            GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(colour.r)
            GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(colour.g)
            GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(colour.b)
            GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(80)
            GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
    
            GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(INSTRUCTIONAL.scaleform, 'DRAW_INSTRUCTIONAL_BUTTONS')
            GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
    
            INSTRUCTIONAL.currentsettup = buttons
            INSTRUCTIONAL.isKeyboard = PAD._IS_USING_KEYBOARD(2)
        end
        GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(INSTRUCTIONAL.scaleform, 255, 255, 255, 255, 0)
        if timer > duration then
            return false
        end
        timer = timer + MISC.GET_FRAME_TIME()
        return true
        end)
    end
    return self
end

b_vectors = {}
b_vectors.new = function ()
    local self = {}

    self.vector2 = {}
    self.vector2.new = function (x, y)
        return {x = x, y = y}
    end
    self.vector2.dot = function(vector_a, vector_b)
        return (vector_a.x * vector_b.x) + (vector_a.y * vector_b.y)
    end
    self.vector2.magnitude = function(vector)
        return math.sqrt((vector.x * vector.x) + (vector.y * vector.y))
    end
    self.vector2.get_angle = function(vector_a, vector_b)
        return math.acos(self.vector2.dot(vector_a, vector_b) / self.vector2.magnitude(vector_a) / self.vector2.magnitude(vector_b))
    end
    self.vector3 = {}
    self.vector3.new = function (x, y, z)
        return {x = x, y = y, z = z}
    end
    self.vector3.add = function(a, b)
        return self.vector3.new(a.x + b.x, a.y + b.y, a.z + b.z)
    end
    self.vector3.sub = function(a, b)
        return self.vector3.new(a.x - b.x, a.y - b.y, a.z - b.z)
    end
    self.vector3.multiply = function (vec, num)
        return {x = vec.x * num, y = vec.y * num, z = vec.z * num}
    end
    return self
end

b_colour = {}
b_colour.new = function ()
    local self = {}
    self.new = function (r, g, b, a)
        return {
            r = r,
            g = g,
            b = b,
            a = a
        }
    end
    self.white =    {r = 255,g = 255,b = 255,a = 255}

    self.black =    {r = 0,g = 0,b = 0,a = 255}

    self.magenta =  {r = 255,g = 0,b = 255,a = 255}

    self.red =      {r = 255,g = 0,b = 0,a = 255}

    self.green =    {r = 0,g = 255,b = 0,a = 255}

    self.blue =     {r = 0,g = 0,b = 255,a = 255}

    self.to_rage = function (colour)
        return {
            r = math.floor(colour.r * 255),
            g = math.floor(colour.g * 255),
            b = math.floor(colour.b * 255),
            a = math.floor(colour.a * 255)
        }
    end
    self.to_stand = function (colour)
        return {
            r = colour.r / 255,
            g = colour.g / 255,
            b = colour.b / 255,
            a = colour.a / 255
        }
    end
    return self
end

b_notifications = {}
b_notifications.new = function ()
    local self = {}

    local active_notifs = {}
    self.notif_padding = 0.005
    self.notif_text_size = 0.5
    self.notif_title_size = 0.6
    self.notif_spacing = 0.015
    self.notif_width = 0.15
    self.notif_flash_duration = 1
    self.notif_anim_speed = 1
    self.notif_banner_colour = {r = 1, g = 0, b = 1, a = 1}
    self.notif_flash_colour = {r = 0.5, g = 0.0, b = 0.5, a = 1}
    self.max_notifs = 10
    self.notif_banner_height = 0.002
    self.use_toast = false
    local split = function (input, sep)
        local t={}
        for str in string.gmatch(input, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
    end
    
    local function lerp(a, b, t)
        return a + (b - a) * t
    end
    local cut_string_to_length = function(input, length, fontSize)
        input = split(input, " ")
        local output = {}
        local line = ""
        for i, word in ipairs(input) do
            if directx.get_text_size(line..word, fontSize) >= length then
                if directx.get_text_size(word, fontSize) > length then
                    while directx.get_text_size(word , fontSize) > length do
                        local word_lenght = string.len(word)
                        for x = 1, word_lenght, 1 do
                            if directx.get_text_size(line..string.sub(word ,1, x), fontSize) > length then
                                output[#output+1] = line..string.sub(word, 1, x - 1)
                                line = ""
                                word = string.sub(word, x, word_lenght)
                                break
                            end
                        end
                    end
                else
                    output[#output+1] =  line
                    line = ""
                end
            end
            if i == #input then
                output[#output+1] = line..word
            end
            line = line..word.." "
        end
        return table.concat(output, "\n")
    end

    local draw_notifs = function ()
        local aspect_16_9 = 1.777777777777778
        util.create_tick_handler(function ()
            local total_height = 0
            local delta_time = MISC.GET_FRAME_TIME()
            for i = #active_notifs, 1, -1 do
                local notif = active_notifs[i]
                local notif_body_colour = notif.colour
                if notif.flashtimer > 0 then
                    notif_body_colour = self.notif_flash_colour
                    notif.flashtimer = notif.flashtimer - delta_time
                end
                if notif.current_y_pos == -10 then
                    notif.current_y_pos = total_height
                end
                notif.current_y_pos = lerp(notif.current_y_pos, total_height, 5 * delta_time * self.notif_anim_speed)
                if not notif.marked_for_deletetion then
                    notif.animation_state = lerp(notif.animation_state, 1, 10 * delta_time * self.notif_anim_speed)
                end
                --#region
                    directx.draw_rect(
                        1 - self.notif_width - self.notif_padding * 2,
                        0.1 - self.notif_padding * 2 * aspect_16_9 + notif.current_y_pos,
                        self.notif_width + (self.notif_padding * 2),
                        (notif.text_height + notif.title_height + self.notif_padding * 2 * aspect_16_9) * notif.animation_state,
                        notif_body_colour
                    )
                    directx.draw_rect(
                        1 - self.notif_width - self.notif_padding * 2,
                        0.1 - self.notif_padding * 2 * aspect_16_9 + notif.current_y_pos,
                        self.notif_width + (self.notif_padding * 2),
                        self.notif_banner_height * aspect_16_9 * notif.animation_state,
                        self.notif_banner_colour
                    )
                    directx.draw_text(
                        1 - self.notif_padding - self.notif_width,
                        0.1 - self.notif_padding * aspect_16_9 + notif.current_y_pos,
                        notif.title,
                        ALIGN_TOP_LEFT,
                        self.notif_title_size,
                        {r = 1 * notif.animation_state, g = 1 * notif.animation_state, b = 1 * notif.animation_state, a = 1 * notif.animation_state}
                    )
                    directx.draw_text(
                        1 - self.notif_padding - self.notif_width,
                        0.1 - self.notif_padding * aspect_16_9 + notif.current_y_pos + notif.title_height,
                        notif.text,
                        ALIGN_TOP_LEFT,
                        self.notif_text_size,
                        {r = 1 * notif.animation_state, g = 1 * notif.animation_state, b = 1 * notif.animation_state, a = 1 * notif.animation_state}
                    )
    --#endregion
                total_height = total_height + ((notif.total_height + self.notif_padding * 2 + self.notif_spacing) * notif.animation_state)
                if notif.marked_for_deletetion then
                    notif.animation_state = lerp(notif.animation_state, 0, 10 * delta_time)
                    if notif.animation_state < 0.05 then
                        table.remove(active_notifs, i)
                    end
                elseif notif.duration < 0 then
                    notif.marked_for_deletetion = true
                end
                notif.duration = notif.duration - delta_time
            end
            return #active_notifs > 0
        end)
    end

    self.notify = function (title,text, duration, colour)
        if self.use_toast then
            util.toast(title.."\n"..text)
            return
        end
        title = cut_string_to_length(title, self.notif_width, self.notif_title_size)
        text = cut_string_to_length(text, self.notif_width, self.notif_text_size)
        local x, text_heigth = directx.get_text_size(text, self.notif_text_size)
        local xx, title_height = directx.get_text_size(title, self.notif_title_size)
        local hash = util.joaat(title..text)
        local new_notification = {
            title = title,
            flashtimer = self.notif_flash_duration,
            colour = colour or {r = 0.094, g = 0.098, b = 0.101, a = 1},
            duration = duration or 3,
            current_y_pos = -10,
            marked_for_deletetion = false,
            animation_state = 0,
            text = text,
            hash = hash,
            text_height = text_heigth,
            title_height = title_height,
            total_height = title_height + text_heigth
        }
        for i, notif in ipairs(active_notifs) do
            if notif.hash == hash then
                notif.flashtimer = self.notif_flash_duration * 0.5
                notif.marked_for_deletetion = false
                notif.duration = duration or 3
                return
            end
        end
        active_notifs[#active_notifs+1] = new_notification
        if #active_notifs > self.max_notifs then
            table.remove(active_notifs, 1)
        end
        if #active_notifs == 1 then draw_notifs() end
    end

    return self
end

b_input = {}
b_input.new = function ()
    local self = {}
    self.throttle_up = function ()
        return PAD.IS_CONTROL_PRESSED(2, 87)
    end
    self.throttle_down = function ()
        return PAD.IS_CONTROL_PRESSED(2, 88)
    end
    self.yaw_left = function ()
        return PAD.IS_CONTROL_PRESSED(2, 89)
    end
    self.yaw_right = function ()
        return PAD.IS_CONTROL_PRESSED(2, 90)
    end
    self.roll_left = function ()
        return PAD.IS_CONTROL_PRESSED(2, 108)
    end
    self.roll_right = function ()
        return PAD.IS_CONTROL_PRESSED(2, 109)
    end
    self.jump = function ()
        return PAD.IS_CONTROL_JUST_PRESSED(2, 22)
    end
    self.cancel = function ()
        return PAD.IS_CONTROL_JUST_PRESSED(2, 194)
    end
    self.f5 = function ()
        return PAD.IS_CONTROL_JUST_PRESSED(2,318)
    end
    return self
end