util.require_natives(1640181023) -- da natives

UI = {}

UI.new = function()
    -- PRIVATE VARIABLES
    local self = {}

    background_colour = {
        ["r"] = 0.1,
        ["g"] = 0.1,
        ["b"] = 0.1,
        ["a"] = 1
    }

    --gray colour for the header
    gray_colour = {
        ["r"] = 0.2,
        ["g"] = 0.2,
        ["b"] = 0.2,
        ["a"] = 1
    }

    -- text colour
    text_colour = {
        ["r"] = 1.0,
        ["g"] = 1.0,
        ["b"] = 1.0,
        ["a"] = 1.0
    }

    highlight_colour = {
        ["r"] = 1.0,
        ["g"] = 0.0,
        ["b"] = 1.0,
        ["a"] = 1
    }

    local cursor_texture = directx.create_texture(filesystem.scripts_dir() .. "\\resources\\" .. "ImGUI_cursor.png")
    local checkmark_texture = directx.create_texture(filesystem.scripts_dir() .. "\\resources\\" .. "ImGUI_checkmark.png")

    local plain_text_size = 0.5
    local subhead_text_size = 0.6

    local horizontal_temp_width = 0
    local horizontal_temp_height = 0

    local cursor_mode = false
    local dragging_hash = nil

    local temp_container = {}

    local window = {}

    local function get_ascpect_ratio()
        local screen_x, screen_y = directx.get_client_size()

        return screen_x / screen_y
    end

    local function UI_update()
        cursor_pos = {x = PAD.GET_DISABLED_CONTROL_NORMAL(2, 239), y = PAD.GET_DISABLED_CONTROL_NORMAL(2, 240)}
        directx.draw_texture(cursor_texture, 0.004, 0.004, 0.5, 0, cursor_pos.x, cursor_pos.y, 0, text_colour)
        PAD.DISABLE_ALL_CONTROL_ACTIONS(2)
        PAD.ENABLE_CONTROL_ACTION(2, 18, true)
        return cursor_mode
    end

    -- get an if an area is overlapping with the center of the screen
    local function get_overlap_with_rect(width, height, rect_x, rect_y, cursor_pos)
        if rect_x <= cursor_pos.x and rect_x + width >= cursor_pos.x then
            if rect_y <= cursor_pos.y and rect_y + height >= cursor_pos.y then
                return true
            end
        else
            return false
        end
    end

    local function add_with_and_height(width, height, horizontal)
        if not horizontal then
            if width > window.width then
                window.width = width
            end
            window.height = window.height + height
        else
            horizontal_temp_width = horizontal_temp_width + width
            if height > horizontal_temp_height then
                horizontal_temp_height = height
            end
        end
    end

    local function draw_container(container)
        for index, data in pairs(container) do
            local type = next(data)
            type(data[type])
        end
    end

    local function draw_text(data)
        if not window.horizontal then
            directx.draw_text(window.x, window.y, data.text, ALIGN_TOP_LEFT, 0.5, data.colour or text_colour, false)
            window.y = window.y + data.height
        else
            directx.draw_text(window.x, window.y, data.text, ALIGN_TOP_LEFT, 0.5, data.colour or text_colour, false)
            window.x = window.x + data.width
        end
    end

    local function draw_label(data)
        if not window.horizontal then
            directx.draw_text(window.x, window.y, data.name, ALIGN_TOP_LEFT, 0.5, data.colour or text_colour, false)
            window.x = window.x + window.width
            directx.draw_text(
                window.x,
                window.y,
                data.value,
                ALIGN_TOP_RIGHT,
                0.5,
                data.highlight_colour or highlight_colour,
                false
            )
            window.x = window.x - window.width
            window.y = window.y + data.height
        else
            directx.draw_text(window.x, window.y, data.name, ALIGN_TOP_LEFT, 0.5, data.colour or text_colour, false)
            window.x = window.x + data.name_width
            directx.draw_text(
                window.x,
                window.y,
                data.value,
                ALIGN_TOP_LEFT,
                0.5,
                data.highlight_colour or highlight_colour,
                false
            )
            window.x = window.x + data.value_width
        end
    end

    local function draw_div(data)
        if not window.horizontal then
            window.y = window.y + 0.01
            directx.draw_line(
                window.x,
                window.y,
                window.x + window.width,
                window.y,
                data.highlight_colour or highlight_colour,
                data.highlight_colour or highlight_colour
            )
            window.y = window.y + 0.01
        else
            window.x = window.x + 0.005
            directx.draw_line(
                window.x,
                window.y,
                window.x,
                window.y + 0.02,
                data.highlight_colour or highlight_colour,
                data.highlight_colour or highlight_colour
            )
            window.x = window.x + 0.005
        end
    end

    local function enable_horizontal(data)
        window.horizontal = true
        draw_container(data)
    end

    local function disable_horizontal(data)
        window.horizontal = false
        window.x = window.x - data.width
        window.y = window.y + data.height
    end

    local function draw_subhead(data)
        if not window.horizontal then
            directx.draw_text(
                window.x + window.width * 0.5,
                window.y,
                data.text,
                ALIGN_TOP_CENTRE,
                0.55,
                data.colour or highlight_colour,
                false
            )
            x, y = directx.get_text_size(data.text, 0.55)
            window.y = window.y + y + 0.003
        else
            directx.draw_text(
                window.x,
                window.y,
                data.text,
                ALIGN_TOP_LEFT,
                0.55,
                data.colour or highlight_colour,
                false
            )
            window.x = window.x + directx.get_text_size(data.text, 0.55)
        end
    end

    local function draw_button(data)
        directx.draw_rect(window.x, window.y, data.width, data.height - 0.005, data.colour or highlight_colour)
        directx.draw_text(window.x - data.padding, window.y, data.text, ALIGN_TOP_LEFT, 0.5, text_colour)
        if not window.horizontal then
            window.y = window.y + data.height
        else
            window.x = window.x + data.width + (data.padding * 3)
        end
    end

    local function draw_toggle(data)
        directx.draw_rect(window.x, window.y, data.button_size.x, data.button_size.y, gray_colour)
        if data.state then
            directx.draw_texture(checkmark_texture, 0.005, 0.005, 0, 0, window.x, window.y, 0, text_colour)
        end
        window.x = window.x + data.button_size.x
        directx.draw_text(window.x, window.y, data.text, ALIGN_TOP_LEFT, 0.5, data.colour)
        if not window.horizontal then
            window.y = window.y + data.button_size.y + data.padding
            window.x = window.x - data.button_size.x
        else
            window.x = window.x + data.width + data.padding
        end
    end

    -- SETTERS
    self.set_background_colour = function(r, g, b)
        background_colour = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = 1}
    end
    self.set_highlight_colour = function(r, g, b)
        highlight_colour = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = 1}
    end
    self.set_text_colour = function(r, g, b)
        text_colour = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = 1}
    end
    -- OTHER METHODS

    --enable or disable the cursor
    self.toggle_cursor_mode = function(state)
        cursor_mode = state or not cursor_mode
        util.create_tick_handler(UI_update)
    end

    --start a new window
    self.begin = function(unique_title, x, y)
        local sizex, sizey = directx.get_text_size(unique_title or "new window", 0.6)
        window = {
            x = x,
            y = y,
            width = sizex + 0.02,
            height = sizey + 0.02,
            title = unique_title or "new window",
            horizontal = false,
            open_containers = {},
            elements = {},
            active_container = {},
            hash = util.joaat(unique_title or "new window")
        }
        window.active_container = window.elements
    end

    --add a text element to the current window
    self.text = function(text, colour)
        text = tostring(text)
        local width, height = directx.get_text_size(text, plain_text_size)
        add_with_and_height(width, height, window.horizontal)
        window.active_container[#window.active_container + 1] = {
            [draw_text] = {text = text, width = width, height = height, colour = colour}
        }
    end

    --add a subhead to the current window
    self.subhead = function(text, colour)
        text = tostring(text)
        local width, height = directx.get_text_size(text, subhead_text_size)
        add_with_and_height(width, height, window.horizontal)
        window.active_container[#window.active_container + 1] = {
            [draw_subhead] = {text = text, width = width, height = height, colour = colour}
        }
    end

    --add a divider to the current window
    self.divider = function(colour)
        window.active_container[#window.active_container + 1] = {[draw_div] = {colour = colour}}
        add_with_and_height(0.01, 0.02, window.horizontal)
    end

    --add a label to the current window (usefull for displaying variables and there value)
    self.label = function(name, value, colour, label_highlight_colour)
        name = tostring(name)
        value = tostring(value)
        local name_x, name_y = directx.get_text_size(name, plain_text_size)
        local value_x = directx.get_text_size(value, plain_text_size)
        local total_x = value_x + name_x
        add_with_and_height(total_x, name_y, window.horizontal)
        window.active_container[#window.active_container + 1] = {
            [draw_label] = {
                name = name,
                value = value,
                name_width = name_x,
                value_width = value_x,
                height = name_y,
                colour = colour,
                highlight_colour = label_highlight_colour
            }
        }
    end

    self.button = function(name, colour, button_highlight_colour)
        name = tostring(name)
        local name_width, name_height = directx.get_text_size(name, plain_text_size)
        local padding = 0.001
        name_width, name_height = name_width + padding, name_height + 0.005 + padding
        local clicked = false
        if cursor_mode then
            if
                get_overlap_with_rect(
                    name_width,
                    name_height - (padding * 4),
                    horizontal_temp_width + window.x,
                    window.height + window.y - name_height * 0.5 + padding * 2,
                    cursor_pos
                )
             then
                colour =
                    button_highlight_colour or
                    {
                        ["r"] = 0.5,
                        ["g"] = 0.0,
                        ["b"] = 0.5,
                        ["a"] = 1
                    }
                if PAD.IS_CONTROL_JUST_PRESSED(2, 18) then
                    clicked = true
                end
            end
        end
        window.active_container[#window.active_container + 1] = {
            [draw_button] = {
                text = name,
                width = name_width,
                height = name_height,
                colour = colour or highlight_colour,
                padding = padding
            }
        }
        add_with_and_height(name_width + (padding * 3), name_height, window.horizontal)
        return clicked
    end

    self.toggle = function(name, state, colour, optional_function)
        state = state or false
        colour = colour or text_colour
        name = tostring(name)
        local name_width, name_height = directx.get_text_size(name, plain_text_size)

        local button_size = {x = 0.010, y = 0.010}
        local aspect_ratio = get_ascpect_ratio()
        if aspect_ratio >= 1 then
            button_size.y = button_size.y * aspect_ratio
        else
            button_size.x = button_size.x * aspect_ratio
        end

        local padding = 0.005

        if cursor_mode then
            if
                get_overlap_with_rect(
                    button_size.x,
                    button_size.y,
                    horizontal_temp_width + window.x,
                    window.height + window.y - button_size.y * 0.5,
                    cursor_pos
                )
             then
                if PAD.IS_CONTROL_JUST_PRESSED(2, 18) then
                    state = not state
                    if optional_function ~= nil then
                        optional_function(state)
                    end
                end
            end
        end
        window.active_container[#window.active_container + 1] = {
            [draw_toggle] = {
                text = name,
                width = name_width,
                height = name_height,
                colour = colour,
                button_size = button_size,
                padding = padding,
                state = state
            }
        }
        add_with_and_height(name_width + button_size.x + padding, button_size.y + padding, window.horizontal)
        return state
    end

    --start drawing elements in the horizontal direction
    self.start_horizontal = function()
        if horizontal_temp_width ~= 0 then
            error("new horizontal started without closing previous horizontal", 2)
        end
        window.open_containers[#window.open_containers + 1] = window.active_container
        temp_container = {[enable_horizontal] = {}}
        window.active_container = temp_container[enable_horizontal]
        window.horizontal = true
    end

    --return to drawing in the diagonal direction
    self.end_horizontal = function()
        window.active_container[#window.active_container + 1] = {
            [disable_horizontal] = {width = horizontal_temp_width, height = horizontal_temp_height}
        }
        window.horizontal = false
        add_with_and_height(horizontal_temp_width, horizontal_temp_height, window.horizontal)
        local parent = window.open_containers[#window.open_containers]
        parent[#parent + 1] = temp_container
        window.active_container = parent
        horizontal_temp_width, horizontal_temp_height = 0, 0
    end

    --finish and draw the window
    self.finish = function()
        directx.draw_rect(
            window.x - 0.005,
            window.y - 0.005,
            window.width + 0.01,
            window.height + 0.01,
            highlight_colour
        )
        directx.draw_rect(
            window.x - 0.004,
            window.y - 0.004,
            window.width + 0.008,
            window.height + 0.008,
            background_colour
        )
        directx.draw_rect(window.x - 0.004, window.y - 0.004, window.width + 0.008, 0.03, gray_colour)

        directx.draw_text(
            window.x + window.width * 0.5,
            window.y,
            window.title,
            ALIGN_TOP_CENTRE,
            .6,
            text_colour,
            false
        )

        local new_x, new_y = window.x, window.y
        if cursor_mode then
            if get_overlap_with_rect(window.width + 0.008, 0.03, window.x, window.y, cursor_pos) then
                if PAD.IS_CONTROL_JUST_PRESSED(2, 18) then
                    dragging_hash = window.hash
                end
            end
            if PAD.IS_CONTROL_JUST_RELEASED(2, 18) then
                dragging_hash = nil
            end

            if dragging_hash == util.joaat(window.title) then
                new_x = cursor_pos.x - window.width * 0.5
                new_y = cursor_pos.y - 0.03 * 0.5
            end
        end

        window.y = window.y + 0.03

        draw_container(window.elements)

        temp_container = {}
        window = {}
        return new_x, new_y
        
    end

    return self
end

util.require_natives(1640181023) -- da natives

UI = {}

UI.new = function()
    -- PRIVATE VARIABLES
    local self = {}

    background_colour = {
        ["r"] = 0.1,
        ["g"] = 0.1,
        ["b"] = 0.1,
        ["a"] = 1
    }

    --gray colour for the header
    gray_colour = {
        ["r"] = 0.2,
        ["g"] = 0.2,
        ["b"] = 0.2,
        ["a"] = 1
    }

    -- text colour
    text_colour = {
        ["r"] = 1.0,
        ["g"] = 1.0,
        ["b"] = 1.0,
        ["a"] = 1.0
    }

    highlight_colour = {
        ["r"] = 1.0,
        ["g"] = 0.0,
        ["b"] = 1.0,
        ["a"] = 1
    }

    local cursor_texture = directx.create_texture(filesystem.scripts_dir() .. "\\resources\\" .. "ImGUI_cursor.png")
    local checkmark_texture = directx.create_texture(filesystem.scripts_dir() .. "\\resources\\" .. "ImGUI_checkmark.png")

    local plain_text_size = 0.5
    local subhead_text_size = 0.6

    local horizontal_temp_width = 0
    local horizontal_temp_height = 0

    local cursor_mode = false
    local dragging_hash = nil

    local temp_container = {}

    local window = {}

    local function get_ascpect_ratio()
        local screen_x, screen_y = directx.get_client_size()

        return screen_x / screen_y
    end

    local function UI_update()
        cursor_pos = {x = PAD.GET_DISABLED_CONTROL_NORMAL(2, 239), y = PAD.GET_DISABLED_CONTROL_NORMAL(2, 240)}
        directx.draw_texture(cursor_texture, 0.004, 0.004, 0.5, 0, cursor_pos.x, cursor_pos.y, 0, text_colour)
        PAD.DISABLE_ALL_CONTROL_ACTIONS(2)
        PAD.ENABLE_CONTROL_ACTION(2, 18, true)
        return cursor_mode
    end

    -- get an if an area is overlapping with the center of the screen
    local function get_overlap_with_rect(width, height, rect_x, rect_y, cursor_pos)
        if rect_x <= cursor_pos.x and rect_x + width >= cursor_pos.x then
            if rect_y <= cursor_pos.y and rect_y + height >= cursor_pos.y then
                return true
            end
        else
            return false
        end
    end

    local function add_with_and_height(width, height, horizontal)
        if not horizontal then
            if width > window.width then
                window.width = width
            end
            window.height = window.height + height
        else
            horizontal_temp_width = horizontal_temp_width + width
            if height > horizontal_temp_height then
                horizontal_temp_height = height
            end
        end
    end

    local function draw_container(container)
        for index, data in pairs(container) do
            local type = next(data)
            type(data[type])
        end
    end

    local function draw_text(data)
        if not window.horizontal then
            directx.draw_text(window.x, window.y, data.text, ALIGN_TOP_LEFT, 0.5, data.colour or text_colour, false)
            window.y = window.y + data.height
        else
            directx.draw_text(window.x, window.y, data.text, ALIGN_TOP_LEFT, 0.5, data.colour or text_colour, false)
            window.x = window.x + data.width
        end
    end

    local function draw_label(data)
        if not window.horizontal then
            directx.draw_text(window.x, window.y, data.name, ALIGN_TOP_LEFT, 0.5, data.colour or text_colour, false)
            window.x = window.x + window.width
            directx.draw_text(
                window.x,
                window.y,
                data.value,
                ALIGN_TOP_RIGHT,
                0.5,
                data.highlight_colour or highlight_colour,
                false
            )
            window.x = window.x - window.width
            window.y = window.y + data.height
        else
            directx.draw_text(window.x, window.y, data.name, ALIGN_TOP_LEFT, 0.5, data.colour or text_colour, false)
            window.x = window.x + data.name_width
            directx.draw_text(
                window.x,
                window.y,
                data.value,
                ALIGN_TOP_LEFT,
                0.5,
                data.highlight_colour or highlight_colour,
                false
            )
            window.x = window.x + data.value_width
        end
    end

    local function draw_div(data)
        if not window.horizontal then
            window.y = window.y + 0.01
            directx.draw_line(
                window.x,
                window.y,
                window.x + window.width,
                window.y,
                data.highlight_colour or highlight_colour,
                data.highlight_colour or highlight_colour
            )
            window.y = window.y + 0.01
        else
            window.x = window.x + 0.005
            directx.draw_line(
                window.x,
                window.y,
                window.x,
                window.y + 0.02,
                data.highlight_colour or highlight_colour,
                data.highlight_colour or highlight_colour
            )
            window.x = window.x + 0.005
        end
    end

    local function enable_horizontal(data)
        window.horizontal = true
        draw_container(data)
    end

    local function disable_horizontal(data)
        window.horizontal = false
        window.x = window.x - data.width
        window.y = window.y + data.height
    end

    local function draw_subhead(data)
        if not window.horizontal then
            directx.draw_text(
                window.x + window.width * 0.5,
                window.y,
                data.text,
                ALIGN_TOP_CENTRE,
                0.55,
                data.colour or highlight_colour,
                false
            )
            x, y = directx.get_text_size(data.text, 0.55)
            window.y = window.y + y + 0.003
        else
            directx.draw_text(
                window.x,
                window.y,
                data.text,
                ALIGN_TOP_LEFT,
                0.55,
                data.colour or highlight_colour,
                false
            )
            window.x = window.x + directx.get_text_size(data.text, 0.55)
        end
    end

    local function draw_button(data)
        directx.draw_rect(window.x, window.y, data.width, data.height - 0.005, data.colour or highlight_colour)
        directx.draw_text(window.x - data.padding, window.y, data.text, ALIGN_TOP_LEFT, 0.5, text_colour)
        if not window.horizontal then
            window.y = window.y + data.height
        else
            window.x = window.x + data.width + (data.padding * 3)
        end
    end

    local function draw_toggle(data)
        directx.draw_rect(window.x, window.y, data.button_size.x, data.button_size.y, gray_colour)
        if data.state then
            directx.draw_texture(checkmark_texture, 0.005, 0.005, 0, 0, window.x, window.y, 0, text_colour)
        end
        window.x = window.x + data.button_size.x
        directx.draw_text(window.x, window.y, data.text, ALIGN_TOP_LEFT, 0.5, data.colour)
        if not window.horizontal then
            window.y = window.y + data.button_size.y + data.padding
            window.x = window.x - data.button_size.x
        else
            window.x = window.x + data.width + data.padding
        end
    end

    -- SETTERS
    self.set_background_colour = function(r, g, b)
        background_colour = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = 1}
    end
    self.set_highlight_colour = function(r, g, b)
        highlight_colour = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = 1}
    end
    self.set_text_colour = function(r, g, b)
        text_colour = {["r"] = r, ["g"] = g, ["b"] = b, ["a"] = 1}
    end
    -- OTHER METHODS

    --enable or disable the cursor
    self.toggle_cursor_mode = function(state)
        cursor_mode = state or not cursor_mode
        util.create_tick_handler(UI_update)
    end

    --start a new window
    self.begin = function(unique_title, x, y)
        local sizex, sizey = directx.get_text_size(unique_title or "new window", 0.6)
        window = {
            x = x,
            y = y,
            width = sizex + 0.02,
            height = sizey + 0.02,
            title = unique_title or "new window",
            horizontal = false,
            open_containers = {},
            elements = {},
            active_container = {},
            hash = util.joaat(unique_title or "new window")
        }
        window.active_container = window.elements
    end

    --add a text element to the current window
    self.text = function(text, colour)
        text = tostring(text)
        local width, height = directx.get_text_size(text, plain_text_size)
        add_with_and_height(width, height, window.horizontal)
        window.active_container[#window.active_container + 1] = {
            [draw_text] = {text = text, width = width, height = height, colour = colour}
        }
    end

    --add a subhead to the current window
    self.subhead = function(text, colour)
        text = tostring(text)
        local width, height = directx.get_text_size(text, subhead_text_size)
        add_with_and_height(width, height, window.horizontal)
        window.active_container[#window.active_container + 1] = {
            [draw_subhead] = {text = text, width = width, height = height, colour = colour}
        }
    end

    --add a divider to the current window
    self.divider = function(colour)
        window.active_container[#window.active_container + 1] = {[draw_div] = {colour = colour}}
        add_with_and_height(0.01, 0.02, window.horizontal)
    end

    --add a label to the current window (usefull for displaying variables and there value)
    self.label = function(name, value, colour, label_highlight_colour)
        name = tostring(name)
        value = tostring(value)
        local name_x, name_y = directx.get_text_size(name, plain_text_size)
        local value_x = directx.get_text_size(value, plain_text_size)
        local total_x = value_x + name_x
        add_with_and_height(total_x, name_y, window.horizontal)
        window.active_container[#window.active_container + 1] = {
            [draw_label] = {
                name = name,
                value = value,
                name_width = name_x,
                value_width = value_x,
                height = name_y,
                colour = colour,
                highlight_colour = label_highlight_colour
            }
        }
    end

    self.button = function(name, colour, button_highlight_colour)
        name = tostring(name)
        local name_width, name_height = directx.get_text_size(name, plain_text_size)
        local padding = 0.001
        name_width, name_height = name_width + padding, name_height + 0.005 + padding
        local clicked = false
        if cursor_mode then
            if
                get_overlap_with_rect(
                    name_width,
                    name_height - (padding * 4),
                    horizontal_temp_width + window.x,
                    window.height + window.y - name_height * 0.5 + padding * 2,
                    cursor_pos
                )
             then
                colour =
                    button_highlight_colour or
                    {
                        ["r"] = 0.5,
                        ["g"] = 0.0,
                        ["b"] = 0.5,
                        ["a"] = 1
                    }
                if PAD.IS_CONTROL_JUST_PRESSED(2, 18) then
                    clicked = true
                end
            end
        end
        window.active_container[#window.active_container + 1] = {
            [draw_button] = {
                text = name,
                width = name_width,
                height = name_height,
                colour = colour or highlight_colour,
                padding = padding
            }
        }
        add_with_and_height(name_width + (padding * 3), name_height, window.horizontal)
        return clicked
    end

    self.toggle = function(name, state, colour, optional_function)
        state = state or false
        colour = colour or text_colour
        name = tostring(name)
        local name_width, name_height = directx.get_text_size(name, plain_text_size)

        local button_size = {x = 0.010, y = 0.010}
        local aspect_ratio = get_ascpect_ratio()
        if aspect_ratio >= 1 then
            button_size.y = button_size.y * aspect_ratio
        else
            button_size.x = button_size.x * aspect_ratio
        end

        local padding = 0.005

        if cursor_mode then
            if
                get_overlap_with_rect(
                    button_size.x,
                    button_size.y,
                    horizontal_temp_width + window.x,
                    window.height + window.y - button_size.y * 0.5,
                    cursor_pos
                )
             then
                if PAD.IS_CONTROL_JUST_PRESSED(2, 18) then
                    state = not state
                    if optional_function ~= nil then
                        optional_function(state)
                    end
                end
            end
        end
        window.active_container[#window.active_container + 1] = {
            [draw_toggle] = {
                text = name,
                width = name_width,
                height = name_height,
                colour = colour,
                button_size = button_size,
                padding = padding,
                state = state
            }
        }
        add_with_and_height(name_width + button_size.x + padding, button_size.y + padding, window.horizontal)
        return state
    end

    --start drawing elements in the horizontal direction
    self.start_horizontal = function()
        if horizontal_temp_width ~= 0 then
            error("new horizontal started without closing previous horizontal", 2)
        end
        window.open_containers[#window.open_containers + 1] = window.active_container
        temp_container = {[enable_horizontal] = {}}
        window.active_container = temp_container[enable_horizontal]
        window.horizontal = true
    end

    --return to drawing in the diagonal direction
    self.end_horizontal = function()
        window.active_container[#window.active_container + 1] = {
            [disable_horizontal] = {width = horizontal_temp_width, height = horizontal_temp_height}
        }
        window.horizontal = false
        add_with_and_height(horizontal_temp_width, horizontal_temp_height, window.horizontal)
        local parent = window.open_containers[#window.open_containers]
        parent[#parent + 1] = temp_container
        window.active_container = parent
        horizontal_temp_width, horizontal_temp_height = 0, 0
    end

    --finish and draw the window
    self.finish = function()
        directx.draw_rect(
            window.x - 0.005,
            window.y - 0.005,
            window.width + 0.01,
            window.height + 0.01,
            highlight_colour
        )
        directx.draw_rect(
            window.x - 0.004,
            window.y - 0.004,
            window.width + 0.008,
            window.height + 0.008,
            background_colour
        )
        directx.draw_rect(window.x - 0.004, window.y - 0.004, window.width + 0.008, 0.03, gray_colour)

        directx.draw_text(
            window.x + window.width * 0.5,
            window.y,
            window.title,
            ALIGN_TOP_CENTRE,
            .6,
            text_colour,
            false
        )

        local new_x, new_y = window.x, window.y
        if cursor_mode then
            if get_overlap_with_rect(window.width + 0.008, 0.03, window.x, window.y, cursor_pos) then
                if PAD.IS_CONTROL_JUST_PRESSED(2, 18) then
                    dragging_hash = window.hash
                end
            end
            if PAD.IS_CONTROL_JUST_RELEASED(2, 18) then
                dragging_hash = nil
            end

            if dragging_hash == util.joaat(window.title) then
                new_x = cursor_pos.x - window.width * 0.5
                new_y = cursor_pos.y - 0.03 * 0.5
            end
        end

        window.y = window.y + 0.03

        draw_container(window.elements)

        temp_container = {}
        window = {}
        return new_x, new_y
        
    end

    return self
end
