-- ScaleformLib by aaronlink127#0127

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
return Scaleform