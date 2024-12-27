-- again, localized natives, except in a table so that i can give different types different push functions automatically
local scaleform_types={
    ["number"]=function(value)native_invoker.begin_call()native_invoker.push_arg_float(value)native_invoker.end_call("D69736AAE04DB51A")end,
    ["string"]=function(value)native_invoker.begin_call()native_invoker.push_arg_string(value)native_invoker.end_call("E83A3E3557A56640")end,
    ["boolean"]=function(value)native_invoker.begin_call()native_invoker.push_arg_bool(value)native_invoker.end_call("C58424BA936EB458")end
}
-- generic call scaleform function
local function CallScaleformMethod(sf, method, ...)
    local args = {...}
    if GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(sf, method) then
        for i=1,#args do
            local arg = args[i]
            local type = type(arg)
            local push_f = scaleform_types[type]
            if push_f then
                push_f(arg)
            else
                error("Invalid type passed to scaleform method: "..type) --传递给scaleform方法的类型无效
            end
        end
        GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
    --[[ this error, while nice to have for debugging, is probably not nice for release code
    else
        error("Scaleform movie method fail (Scaleform not loaded?)") ]]
    end
end
local ScaleformFunctions = {
    draw=function(self, x, y, w, h)
        GRAPHICS.DRAW_SCALEFORM_MOVIE(self.id, x, y, w, h, 255, 255, 255, 255, 1)
    end,
    draw_fullscreen=function(self)
        GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(self.id, 255, 255, 255, 255, 1)
    end,
    draw_3d=function(self, pos, rot, size)
        pos = pos or {x=0,y=0,z=0}
        rot = rot or {x=0,y=0,z=0}
        size = size or {x=1,y=1,z=1}
        GRAPHICS.DRAW_SCALEFORM_MOVIE_3D(self.id, pos.x, pos.y, pos.z, rot.x, rot.y, rot.z, 0, 2, 0, size.x, size.y, size.z, 1)
    end,
    draw_3d_solid=function(self, pos, rot, size)
        pos = pos or {x=0,y=0,z=0}
        rot = rot or {x=0,y=0,z=0}
        size = size or {x=1,y=1,z=1}
        GRAPHICS.DRAW_SCALEFORM_MOVIE_3D_SOLID(self.id, pos.x, pos.y, pos.z, rot.x, rot.y, rot.z, 0, 2, 0, size.x, size.y, size.z, 1)
    end,
    delete=function(self)
        local mem = memory.alloc(4)
        memory.write_int(mem, self.id)
        -- part of the hacky solution
        util.spoof_script("stats_controller",function()
            GRAPHICS.SET_SCALEFORM_MOVIE_AS_NO_LONGER_NEEDED(mem)
        end)
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
            id = GRAPHICS.REQUEST_SCALEFORM_MOVIE(id)
        end)
        --[[ while not GRAPHICS.HAS_SCALEFORM_MOVIE_LOADED(id) do
            util.yield()
        end ]]
    end
    
    local tbl = {id=id}
    setmetatable(tbl,metaScaleform)
    return tbl
end
return Scaleform