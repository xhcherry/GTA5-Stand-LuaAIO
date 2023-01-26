
--_____________________________________________________----------------------_____________________________________________________----------------------_







----------------------------------------------------------------------------------------------------------------------
--[[
GK Script
]]
----------------------------------------------------------------------------------------------------------------------




--______________________________________________________________________________________________________________________________----------------------_
--______________________________________________________----------------------_____________________________________________________----------------------_____________________________________________________----------------------_














function MDS(pid)
    menu.trigger_commands("anticrashcam on")
    local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
	local plauuepos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
    plauuepos.x = plauuepos.x + 5
    plauuepos.z = plauuepos.z + 5
    local hunter = {}
    for i = 1 ,3 do
        for n = 0,120 do
            hunter[n] = CreateVehicle(1077420264,plauuepos,0)
            util.yield(0)
            ENTITY.FREEZE_ENTITY_POSITION(hunter[n],true)
            util.yield(0)
            VEHICLE.EXPLODE_VEHICLE(hunter[n], true, true)
        end
        util.yield(190)
        for i = 1,#hunter do
            if hunter[i] ~= nil then
                entities.delete_by_handle(hunter[i])
            end
        end
    end
    util.toast("Finished!")
	menu.trigger_commands("anticrashcam off")
    hunter = nil
    plauuepos = nil
	
end
	
	
	
-- local natives, so we dont need to require natives (even though most scripts that require this would probably require them already, so there would be no cost to using them here, i just like this)
local function HAS_SCALEFORM_MOVIE_LOADED(scaleformHandle)native_invoker.begin_call()native_invoker.push_arg_int(scaleformHandle)native_invoker.end_call("85F01B8D5B90570E")return native_invoker.get_return_value_bool()end
local function DRAW_SCALEFORM_MOVIE(scaleformHandle,x,y,width,height,red,green,blue,alpha,unk)native_invoker.begin_call()native_invoker.push_arg_int(scaleformHandle)native_invoker.push_arg_float(x)native_invoker.push_arg_float(y)native_invoker.push_arg_float(width)native_invoker.push_arg_float(height)native_invoker.push_arg_int(red)native_invoker.push_arg_int(green)native_invoker.push_arg_int(blue)native_invoker.push_arg_int(alpha)native_invoker.push_arg_int(unk)native_invoker.end_call("54972ADAF0294A93")end
local function DRAW_SCALEFORM_MOVIE_FULLSCREEN(scaleform,red,green,blue,alpha,unk)native_invoker.begin_call()native_invoker.push_arg_int(scaleform)native_invoker.push_arg_int(red)native_invoker.push_arg_int(green)native_invoker.push_arg_int(blue)native_invoker.push_arg_int(alpha)native_invoker.push_arg_int(unk)native_invoker.end_call("0DF606929C105BE1")end
local function DRAW_SCALEFORM_MOVIE_3D(scaleform,posX,posY,posZ,rotX,rotY,rotZ,p7,p8,p9,scaleX,scaleY,scaleZ,p13)native_invoker.begin_call()native_invoker.push_arg_int(scaleform)native_invoker.push_arg_float(posX)native_invoker.push_arg_float(posY)native_invoker.push_arg_float(posZ)native_invoker.push_arg_float(rotX)native_invoker.push_arg_float(rotY)native_invoker.push_arg_float(rotZ)native_invoker.push_arg_float(p7)native_invoker.push_arg_float(p8)native_invoker.push_arg_float(p9)native_invoker.push_arg_float(scaleX)native_invoker.push_arg_float(scaleY)native_invoker.push_arg_float(scaleZ)native_invoker.push_arg_int(p13)native_invoker.end_call("87D51D72255D4E78")end
local function DRAW_SCALEFORM_MOVIE_3D_SOLID(scaleform,posX,posY,posZ,rotX,rotY,rotZ,p7,p8,p9,scaleX,scaleY,scaleZ,p13)native_invoker.begin_call()native_invoker.push_arg_int(scaleform)native_invoker.push_arg_float(posX)native_invoker.push_arg_float(posY)native_invoker.push_arg_float(posZ)native_invoker.push_arg_float(rotX)native_invoker.push_arg_float(rotY)native_invoker.push_arg_float(rotZ)native_invoker.push_arg_float(p7)native_invoker.push_arg_float(p8)native_invoker.push_arg_float(p9)native_invoker.push_arg_float(scaleX)native_invoker.push_arg_float(scaleY)native_invoker.push_arg_float(scaleZ)native_invoker.push_arg_int(p13)native_invoker.end_call("1CE592FDC749D6F5")end
local function SET_SCALEFORM_MOVIE_AS_NO_LONGER_NEEDED(scaleformHandle)native_invoker.begin_call()native_invoker.push_arg_pointer(scaleformHandle)native_invoker.end_call("1D132D614DD86811")end
local function REQUEST_SCALEFORM_MOVIE(scaleformName)native_invoker.begin_call()native_invoker.push_arg_string(scaleformName)native_invoker.end_call("11FE353CF9733E6F")return native_invoker.get_return_value_int()end
local function BEGIN_SCALEFORM_MOVIE_METHOD(scaleform,methodName)native_invoker.begin_call()native_invoker.push_arg_int(scaleform)native_invoker.push_arg_string(methodName)native_invoker.end_call("F6E48914C7A8694E")return native_invoker.get_return_value_bool()end
local function END_SCALEFORM_MOVIE_METHOD()native_invoker.begin_call()native_invoker.end_call("C6796A8FFA375E53")end
-- again, localized natives, except in a table so that i can give different types different push functions automatically
local scaleform_types={
    ["number"]=function(value)native_invoker.begin_call()native_invoker.push_arg_float(value)native_invoker.end_call("D69736AAE04DB51A")end,
    ["string"]=function(value)native_invoker.begin_call()native_invoker.push_arg_string(value)native_invoker.end_call("E83A3E3557A56640")end,
    ["boolean"]=function(value)native_invoker.begin_call()native_invoker.push_arg_bool(value)native_invoker.end_call("C58424BA936EB458")end
}
-- generic call scaleform function
local function CallScaleformMethod(sf, method, ...)
    local args = {...}
    if BEGIN_SCALEFORM_MOVIE_METHOD(sf, method) then
        for i=1,#args do
            local arg = args[i]
            local type = type(arg)
            local push_f = scaleform_types[type]
            if push_f then
                push_f(arg)
            else
                error("Invalid type passed to scaleform method: "..type)
            end
        end
        END_SCALEFORM_MOVIE_METHOD()
    --[[ this error, while nice to have for debugging, is probably not nice for release code
    else
        error("Scaleform movie method fail (Scaleform not loaded?)") ]]
    end
end
local ScaleformFunctions = {
    draw=function(self, x, y, w, h)
        DRAW_SCALEFORM_MOVIE(self.id, x, y, w, h, 255, 255, 255, 255, 1)
    end,
    draw_fullscreen=function(self)
        DRAW_SCALEFORM_MOVIE_FULLSCREEN(self.id, 255, 255, 255, 255, 1)
    end,
    draw_3d=function(self, pos, rot, size)
        pos = pos or {x=0,y=0,z=0}
        rot = rot or {x=0,y=0,z=0}
        size = size or {x=1,y=1,z=1}
        DRAW_SCALEFORM_MOVIE_3D(self.id, pos.x, pos.y, pos.z, rot.x, rot.y, rot.z, 0, 2, 0, size.x, size.y, size.z, 1)
    end,
    draw_3d_solid=function(self, pos, rot, size)
        pos = pos or {x=0,y=0,z=0}
        rot = rot or {x=0,y=0,z=0}
        size = size or {x=1,y=1,z=1}
        DRAW_SCALEFORM_MOVIE_3D_SOLID(self.id, pos.x, pos.y, pos.z, rot.x, rot.y, rot.z, 0, 2, 0, size.x, size.y, size.z, 1)
    end,
    delete=function(self)
        local mem = memory.alloc(4)
        memory.write_int(mem, self.id)
        -- part of the hacky solution
        util.spoof_script("stats_controller",function()
            SET_SCALEFORM_MOVIE_AS_NO_LONGER_NEEDED(mem)
        end)
        memory.free(mem)
    end
}
local metaScaleform = {
    __index=function(self, key)
        return ScaleformFunctions[key] or function(...)
            CallScaleformMethod(self.id, key, ...)
        end
    end
}
local function Scaleform(id)
    if type(id) == "string" then
        -- this spoof script is a hacky solution to certain problems (mainly with instructional_buttons) but should work
        util.spoof_script("stats_controller",function()
            id = REQUEST_SCALEFORM_MOVIE(id)
        end)
        while not HAS_SCALEFORM_MOVIE_LOADED(id) do
            util.yield()
        end
    end
    local tbl = {id=id}
    setmetatable(tbl,metaScaleform)
    return tbl
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

return Scaleform

