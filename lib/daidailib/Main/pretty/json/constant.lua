-- Copyright (c) 2019, Souche Inc.

local Constant = {
    ESC_MAP = {
        ["\\"] = [[\]],
        ["\""] = [[\"]],
        ["/"] = [[\/]],
        ["\b"] = [[\b]],
        ["\f"] = [[\f]],
        ["\n"] = [[\n]],
        ["\r"] = [[\r]],
        ["\t"] = [[\t]],
        ["\a"] = [[\u0007]],
        ["\v"] = [[\u000b]]
    },

    UN_ESC_MAP = {
        b = "\b",
        f = "\f",
        n = "\n",
        r = "\r",
        t = "\t",
        u0007 = "\a",
        u000b = "\v"
    },

    NULL = setmetatable({}, {
        __tostring = function() return "null" end
    })
}

return Constant
