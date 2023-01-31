require("natives-1627063482") -- da natives

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

    local cursor_texture = directx.create_texture(filesystem.scripts_dir() .. "\\resources\\" .. "imGUI_cursor.png")
    local checkmark_texture = directx.create_texture(filesystem.scripts_dir() .. "\\resources\\" .. "imGUI_checkmark.png")

    local plain_text_size = 0.5
    local subhead_text_size = 0.6

    local horizontal_temp_width = 0
    local horizontal_temp_height = 0

    local cursor_mode = false

    local temp_container = {}

    local temp_x, temp_y = 0,0

    local current_window = {}

    local windows = {}

    local tab_containers = {}

    local function get_aspect_ratio()
        local screen_x, screen_y = directx.get_client_size()

        return screen_x / screen_y
    end

    local function UI_update()
        cursor_pos = {x = PAD.GET_DISABLED_CONTROL_NORMAL(2, 239), y = PAD.GET_DISABLED_CONTROL_NORMAL(2, 240)}
        directx.draw_texture(cursor_texture, 0.004, 0.004, 0.5, 0, cursor_pos.x, cursor_pos.y, 0, text_colour)
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

    local function draw_collapse_button(x_pos, y_pos, size, dir)
        size = size or 1
        local button_size = {x = 0.005 * dir, y = 0.005}
        local aspect_ratio = get_aspect_ratio()
        if aspect_ratio >= 1 then
            button_size.y = button_size.y * aspect_ratio
        else
            button_size.x = button_size.x * aspect_ratio
        end
        local half_size = {x = button_size.x * 0.5, y = button_size.y * 0.5}
        if cursor_mode then
            if get_overlap_with_rect(button_size.x + 0.01, button_size.y + 0.01,x_pos - button_size.x * 0.5 - 0.005, y_pos - button_size.y * 0.5 - 0.005, cursor_pos) then
                directx.draw_triangle(x_pos + half_size.x * size, y_pos, x_pos - half_size.x * size, y_pos  + half_size.y * size, x_pos - half_size.x * size, y_pos - half_size.y * size, highlight_colour)
                return PAD.IS_CONTROL_JUST_PRESSED(2, 18)
           end
        end
        directx.draw_triangle(x_pos + half_size.x * size, y_pos, x_pos - half_size.x * size, y_pos  + half_size.y * size, x_pos - half_size.x * size, y_pos - half_size.y * size, text_colour) 
    end

    local function draw_tabs(tab_count)
        local aspect_ratio = get_aspect_ratio()
        
        if not current_window.tabs_collapsed then
            local button_size = {x = 0.06, y = 0.015}
            if aspect_ratio >= 1 then
                button_size.y = button_size.y * aspect_ratio
            else
                button_size.x = button_size.x * aspect_ratio
            end
            local drawpos = {x = current_window.x - button_size.x - 0.005, y = current_window.y - 0.004}
            directx.draw_rect(drawpos.x, drawpos.y, button_size.x, current_window.height + 0.008, background_colour)
            directx.draw_rect(drawpos.x, drawpos.y, button_size.x, button_size.y - 0.002, gray_colour)
            if draw_collapse_button(drawpos.x + 0.0075, drawpos.y + button_size.y *0.5, 1.25, 1) then
                current_window.tabs_collapsed = true
            end
            directx.draw_text(drawpos.x + button_size.x * 0.5,current_window.y + button_size.y * 0.5 - 0.004, "tabs", ALIGN_CENTRE, 0.5, text_colour)
                for i = 1, tab_count, 1 do
                    local button_drawpos = {x = drawpos.x, y = drawpos.y + (i) * button_size.y}
                    if cursor_mode then
                        if get_overlap_with_rect( button_size.x, button_size.y, button_drawpos.x, button_drawpos.y, cursor_pos) then
                            directx.draw_rect(button_drawpos.x, button_drawpos.y, button_size.x, button_size.y, highlight_colour)
                            if PAD.IS_CONTROL_JUST_PRESSED(2, 18) then
                                current_window.current_tab = i
                            end
                        else
                            directx.draw_rect(button_drawpos.x, button_drawpos.y, button_size.x, button_size.y, gray_colour)
                        end 
                    else
                        directx.draw_rect(button_drawpos.x, button_drawpos.y, button_size.x, button_size.y, gray_colour)
                    end
                    directx.draw_texture(tabs[i].data.icon, button_size.x * 0.1, button_size.x * 0.1, -0.1, 0.5, button_drawpos.x, button_drawpos.y + button_size.y * 0.5, 0, text_colour)
                    directx.draw_text(button_drawpos.x + (button_size.x * 0.1) * 2, button_drawpos.y + button_size.y * 0.5, tabs[i].data.title, ALIGN_CENTRE_LEFT, 0.5, text_colour, false)
                end
            else
                local button_size = {x = 0.015, y = 0.015}
                if aspect_ratio >= 1 then
                    button_size.y = button_size.y * aspect_ratio
                else
                    button_size.x = button_size.x * aspect_ratio
                end
                local drawpos = {x = current_window.x - button_size.x - 0.005, y = current_window.y - 0.004}
                directx.draw_rect(drawpos.x, drawpos.y, button_size.x, current_window.height + 0.008, background_colour)
                directx.draw_rect(drawpos.x, drawpos.y, button_size.x, button_size.y - 0.002, gray_colour)
                if draw_collapse_button(drawpos.x + 0.0075, drawpos.y + button_size.y * 0.5, 1.25, -1) then
                    current_window.tabs_collapsed = false
                end
                    for i = 1, tab_count, 1 do
                        local button_drawpos = {x = drawpos.x, y = drawpos.y + (i) * button_size.y}
                        if cursor_mode then
                            if get_overlap_with_rect( button_size.x, button_size.y, button_drawpos.x, button_drawpos.y, cursor_pos) then
                                directx.draw_rect(button_drawpos.x, button_drawpos.y, button_size.x, button_size.y, highlight_colour)
                                if PAD.IS_CONTROL_JUST_PRESSED(2, 18) then
                                    current_window.current_tab = i
                                end
                            else
                                directx.draw_rect(button_drawpos.x, button_drawpos.y, button_size.x, button_size.y, gray_colour)
                            end 
                        else
                            directx.draw_rect(button_drawpos.x, button_drawpos.y, button_size.x, button_size.y, gray_colour)
                        end
                        directx.draw_texture(tabs[i].data.icon, button_size.x * 0.4, button_size.x * 0.4, -0.1, 0.5, button_drawpos.x, button_drawpos.y + button_size.y * 0.5, 0, text_colour)
                    end
        end


    end

    local function add_with_and_height(width, height, horizontal)
        if not horizontal then
            if width > current_window.width then
                current_window.width = width
            end
            current_window.height = current_window.height + height
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
        if not current_window.horizontal then
            directx.draw_text(temp_x, temp_y, data.text, ALIGN_TOP_LEFT, 0.5, data.colour or text_colour, false)
            temp_y = temp_y + data.height
        else
            directx.draw_text(temp_x, temp_y, data.text, ALIGN_TOP_LEFT, 0.5, data.colour or text_colour, false)
            temp_x = temp_x + data.width
        end
    end

    local function draw_label(data)
        if not current_window.horizontal then
            directx.draw_text(temp_x, temp_y, data.name, ALIGN_TOP_LEFT, 0.5, data.colour or text_colour, false)
            temp_x = temp_x + current_window.width
            directx.draw_text(
                temp_x,
                temp_y,
                data.value,
                ALIGN_TOP_RIGHT,
                0.5,
                data.highlight_colour or highlight_colour,
                false
            )
            temp_x = temp_x - current_window.width
            temp_y = temp_y + data.height
        else
            directx.draw_text(temp_x, temp_y, data.name, ALIGN_TOP_LEFT, 0.5, data.colour or text_colour, false)
            temp_x = temp_x + data.name_width
            directx.draw_text(
                temp_x,
                temp_y,
                data.value,
                ALIGN_TOP_LEFT,
                0.5,
                data.highlight_colour or highlight_colour,
                false
            )
            temp_x = temp_x + data.value_width
        end
    end

    local function draw_div(data)
        if not current_window.horizontal then
            temp_y = temp_y + 0.01
            directx.draw_line(
                temp_x,
                temp_y,
                temp_x + current_window.width,
                temp_y,
                data.highlight_colour or highlight_colour,
                data.highlight_colour or highlight_colour
            )
            temp_y = temp_y + 0.01
        else
            temp_x = temp_x + 0.005
            directx.draw_line(
                temp_x,
                temp_y,
                temp_x,
                temp_y + 0.02,
                data.highlight_colour or highlight_colour,
                data.highlight_colour or highlight_colour
            )
            temp_x = temp_x + 0.005
        end
    end

    local function enable_horizontal(data)
        current_window.horizontal = true
        draw_container(data)
    end

    local function disable_horizontal(data)
        current_window.horizontal = false
        temp_x = temp_x - data.width
        temp_y = temp_y + data.height
    end

    local function draw_subhead(data)
        if not current_window.horizontal then
            directx.draw_text(
                temp_x + current_window.width * 0.5,
                temp_y,
                data.text,
                ALIGN_TOP_CENTRE,
                0.55,
                data.colour or highlight_colour,
                false
            )
            local x, y = directx.get_text_size(data.text, 0.55)
            temp_y = temp_y + y + 0.003
        else
            directx.draw_text(
                temp_x,
                temp_y,
                data.text,
                ALIGN_TOP_LEFT,
                0.55,
                data.colour or highlight_colour,
                false
            )
            temp_x = temp_x + directx.get_text_size(data.text, 0.55)
        end
    end

    local function draw_button(data)
        directx.draw_rect(temp_x, temp_y, data.width, data.height - 0.005, data.colour or highlight_colour)
        directx.draw_text(temp_x - data.padding, temp_y, data.text, ALIGN_TOP_LEFT, 0.5, text_colour)
        if not current_window.horizontal then
            temp_y = temp_y + data.height
        else
            temp_x = temp_x + data.width + (data.padding * 3)
        end
    end

    local function draw_toggle(data)
        directx.draw_rect(temp_x, temp_y, data.button_size.x, data.button_size.y, gray_colour)
        if data.state then
            directx.draw_texture(checkmark_texture, 0.005, 0.005, 0, 0, temp_x, temp_y, 0, text_colour)
        end
        temp_x = temp_x + data.button_size.x
        directx.draw_text(temp_x, temp_y, data.text, ALIGN_TOP_LEFT, 0.5, data.colour)
        if not current_window.horizontal then
            temp_y = temp_y + data.button_size.y + data.padding
            temp_x = temp_x - data.button_size.x
        else
            temp_x = temp_x + data.width + data.padding
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
        if state == nil then
            cursor_mode = not cursor_mode
        else
            cursor_mode = state
        end
        PAD._SET_CURSOR_LOCATION(0.5, 0.5)
        util.create_tick_handler(UI_update)
        if cursor_mode then
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

    self.start_tab_container = function (title, x_pos, y_pos, tabs, id)
        local sizex, sizey = directx.get_text_size(title, 0.6)
        local hash = util.joaat(id)
        if tab_containers[hash] ~= nil then
            current_window = tab_containers[hash]
            current_window.open_containers = {}
            current_window.elements = {}
            current_window.active_container = {}
            current_window.horizontal = false
            current_window.height = sizey + 0.02
            temp_y = current_window.y
            temp_x = current_window.x

            

        else
            current_window ={
                x = x_pos,
                y = y_pos,
                width = sizex + 0.02,
                height = sizey + 0.02,
                largest_height = 0,
                title = title,
                horizontal = false,
                open_containers = {},
                elements = {},
                active_container = {},
                is_being_dragged = false,
                tabs_collapsed = false,
                id = hash,
                current_tab = 1
            }
            tab_containers[hash] = current_window
        end
        current_window.active_container = current_window.elements
        tabs[current_window.current_tab].content()

        self.finish_tab_container()
    end

    self.finish_tab_container = function ()
        --determine if we use calculated height or largest height
        if current_window.height < current_window.largest_height then
            current_window.height = current_window.largest_height
        else
            current_window.largest_height = current_window.height
        end
        --calculate width + tabs
        local tab_width = current_window.tabs_collapsed == true and 0.016 or 0.061
        -- draw border
        directx.draw_rect(
            temp_x - 0.005 - tab_width,
            temp_y - 0.005 - 0.03,
            current_window.width + tab_width + 0.01,
            current_window.height + 0.04,
            highlight_colour
        )
        --draw tabs
        draw_tabs(#tabs)
        -- draw background
        directx.draw_rect(
            temp_x - 0.004,
            temp_y - 0.004,
            current_window.width + 0.008,
            current_window.height + 0.008,
            background_colour
        )
        --draw title bar
        directx.draw_rect(temp_x - tab_width - 0.004, temp_y - 0.004 - 0.03, current_window.width + tab_width + 0.008, 0.03, gray_colour)

        directx.draw_text(
            temp_x + current_window.width  * 0.5,
            temp_y - 0.03,
            current_window.title,
            ALIGN_TOP_CENTRE,
            .6,
            text_colour,
            false
        )

        if cursor_mode then
            if get_overlap_with_rect(current_window.width + tab_width + 0.008, 0.03, temp_x - tab_width - 0.004, temp_y - 0.004 - 0.03, cursor_pos) then
                if PAD.IS_CONTROL_JUST_PRESSED(2, 18) then
                    current_window.is_being_dragged = true
                end
            end
            if PAD.IS_CONTROL_JUST_RELEASED(2, 18) then
                current_window.is_being_dragged = false
            end

            if current_window.is_being_dragged then
                current_window.x = cursor_pos.x - (current_window.width - tab_width) * 0.5
                current_window.y = cursor_pos.y + 0.004 + 0.015
            end
        end

        temp_y = temp_y + 0.03

        draw_container(current_window.elements)

        temp_container = {}
        current_window = {}
    end
    --start a new window
    self.begin = function(title, x_pos, y_pos, Id)
        local sizex, sizey = directx.get_text_size(title, 0.6)
        local hash = util.joaat(Id or title)
            if windows[hash] ~= nil then
                current_window = windows[hash]
                current_window.open_containers = {}
                current_window.elements = {}
                current_window.active_container = {}
                current_window.horizontal = false
                current_window.width = sizex + 0.02
                current_window.height = sizey + 0.02
                current_window.tabs = {}
                temp_y = current_window.y
                temp_x = current_window.x
            else
                current_window = {
                    x = x_pos,
                    y = y_pos,
                    width = sizex + 0.02,
                    height = sizey + 0.02,
                    title = title,
                    horizontal = false,
                    open_containers = {},
                    elements = {},
                    active_container = {},
                    is_being_dragged = false,
                    id = hash
                }
                windows[hash] = current_window
            end
        current_window.active_container = current_window.elements
    end

    --add a text element to the current window
    self.text = function(text, colour)
        text = tostring(text)
        local width, height = directx.get_text_size(text, plain_text_size)
        add_with_and_height(width, height, current_window.horizontal)
        current_window.active_container[#current_window.active_container + 1] = {
            [draw_text] = {text = text, width = width, height = height, colour = colour}
        }
    end

    --add a subhead to the current window
    self.subhead = function(text, colour)
        text = tostring(text)
        local width, height = directx.get_text_size(text, subhead_text_size)
        add_with_and_height(width, height, current_window.horizontal)
        current_window.active_container[#current_window.active_container + 1] = {
            [draw_subhead] = {text = text, width = width, height = height, colour = colour}
        }
    end

    --add a divider to the current window
    self.divider = function(colour)
        current_window.active_container[#current_window.active_container + 1] = {[draw_div] = {colour = colour}}
        add_with_and_height(0.01, 0.02, current_window.horizontal)
    end

    --add a label to the current window (usefull for displaying variables and there value)
    self.label = function(name, value, colour, label_highlight_colour)
        name = tostring(name)
        value = tostring(value)
        local name_x, name_y = directx.get_text_size(name, plain_text_size)
        local value_x = directx.get_text_size(value, plain_text_size)
        local total_x = value_x + name_x
        add_with_and_height(total_x, name_y, current_window.horizontal)
        current_window.active_container[#current_window.active_container + 1] = {
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

    --adds a button to the current window
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
                    horizontal_temp_width + temp_x,
                    current_window.height + temp_y - name_height * 0.5 + padding * 2,
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
        current_window.active_container[#current_window.active_container + 1] = {
            [draw_button] = {
                text = name,
                width = name_width,
                height = name_height,
                colour = colour or highlight_colour,
                padding = padding
            }
        }
        add_with_and_height(name_width + (padding * 3), name_height, current_window.horizontal)
        return clicked
    end

    --adds a toggle to the current menu
    self.toggle = function(name, state, colour, optional_function)
        state = state or false
        colour = colour or text_colour
        name = tostring(name)
        local name_width, name_height = directx.get_text_size(name, plain_text_size)

        local button_size = {x = 0.010, y = 0.010}
        local aspect_ratio = get_aspect_ratio()
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
                    horizontal_temp_width + temp_x,
                    current_window.height + temp_y - button_size.y * 0.5,
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
        current_window.active_container[#current_window.active_container + 1] = {
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
        add_with_and_height(name_width + button_size.x + padding, button_size.y + padding, current_window.horizontal)
        return state
    end

    --start drawing elements in the horizontal direction
    self.start_horizontal = function()
        if horizontal_temp_width ~= 0 then
            error("new horizontal started without closing previous horizontal", 2)
        end
        current_window.open_containers[#current_window.open_containers + 1] = current_window.active_container
        temp_container = {[enable_horizontal] = {}}
        current_window.active_container = temp_container[enable_horizontal]
        current_window.horizontal = true
    end

    --return to drawing in the diagonal direction
    self.end_horizontal = function()
        current_window.active_container[#current_window.active_container + 1] = {
            [disable_horizontal] = {width = horizontal_temp_width, height = horizontal_temp_height}
        }
        current_window.horizontal = false
        add_with_and_height(horizontal_temp_width, horizontal_temp_height, current_window.horizontal)
        local parent = current_window.open_containers[#current_window.open_containers]
        parent[#parent + 1] = temp_container
        current_window.active_container = parent
        horizontal_temp_width, horizontal_temp_height = 0, 0
    end

    --finish and draw the window
    self.finish = function()
        directx.draw_rect(
            temp_x - 0.005,
            temp_y - 0.005,
            current_window.width + 0.01,
            current_window.height + 0.01,
            highlight_colour
        )
        directx.draw_rect(
            temp_x - 0.004,
            temp_y - 0.004,
            current_window.width + 0.008,
            current_window.height + 0.008,
            background_colour
        )
        directx.draw_rect(temp_x - 0.004, temp_y - 0.004, current_window.width + 0.008, 0.03, gray_colour)

        directx.draw_text(
            temp_x + current_window.width * 0.5,
            temp_y,
            current_window.title,
            ALIGN_TOP_CENTRE,
            .6,
            text_colour,
            false
        )

        if cursor_mode then
            if get_overlap_with_rect(current_window.width + 0.008, 0.03, temp_x, temp_y, cursor_pos) then
                if PAD.IS_CONTROL_JUST_PRESSED(2, 18) then
                    current_window.is_being_dragged = true
                end
            end
            if PAD.IS_CONTROL_JUST_RELEASED(2, 18) then
                current_window.is_being_dragged = false
            end

            if current_window.is_being_dragged then
                current_window.x = cursor_pos.x - current_window.width * 0.5
                current_window.y = cursor_pos.y - 0.03 * 0.5
            end
        end

        temp_y = temp_y + 0.03

        draw_container(current_window.elements)

        temp_container = {}
        current_window = {}
    end

    return self
end






