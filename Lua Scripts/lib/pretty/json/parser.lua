-- Copyright (c) 2019, Souche Inc.

local Constant = require "pretty.json.constant"

local NULL = Constant.NULL
local UN_ESC_MAP = Constant.UN_ESC_MAP

local function next_char(str, pos)
    pos = pos + #str:match("^%s*", pos)
    return str:sub(pos, pos), pos
end

local function syntax_error(str, pos)
    return error("Invalid json syntax starting at position " .. pos .. ": " .. str:sub(pos, pos + 10))
end

local Parser = {}

setmetatable(Parser, {
    __call = function(self, opts)
        local parser = {
            without_null = opts.without_null
        }

        setmetatable(parser, { __index = Parser })

        return parser
    end
})

function Parser:number(str, pos)
    local num = str:match("^-?%d+%.?%d*[eE]?[+-]?%d*", pos)
    local val = tonumber(num)

    if not val then
        syntax_error(str, pos)
    else
        return val, pos + #num
    end
end

function Parser:string(str, pos)
    pos = pos + 1
    
    local i = 1
    local chars = {}
    while(pos <= #str) do
        local c = str:sub(pos, pos)

        if c == "\"" then
            return table.concat(chars, ""), pos + 1
        elseif c == "\\" then
            local j = pos + 1

            local next_c = str:sub(j, j)
            for k, v in pairs(UN_ESC_MAP) do
                if str:sub(j, j + #k - 1) == k then
                    next_c = v
                    j = j + #k - 1
                end
            end

            c = next_c
            pos = j
        end

        chars[i] = c
        i = i + 1
        pos = pos + 1
    end

    syntax_error(str, pos)
end

function Parser:array(str, pos)
    local arr = {}
    local val
    local i = 1
    local c
    
    pos = pos + 1
    while true do
        val, pos = self:json(str, pos)
        arr[i] = val
        i = i + 1

        c, pos = next_char(str, pos)
        if (c == ",") then
            pos = pos + 1
        elseif (c == "]") then
            return arr, pos + 1
        else
            syntax_error(str, pos)
        end
    end

    return arr
end

function Parser:table(str, pos)
    local obj = {}
    local key
    local val
    local c

    pos = pos + 1
    while true do
        c, pos = next_char(str, pos)

        if c == "}" then return obj, pos + 1
        elseif c == "\"" then key, pos = self:string(str, pos)
        else syntax_error(str, pos) end

        c, pos = next_char(str, pos)
        if c ~= ":" then syntax_error(str, pos) end

        val, pos = self:json(str, pos + 1)
        obj[key] = val

        c, pos = next_char(str, pos)
        if c == "}" then
            return obj, pos + 1
        elseif c == "," then
            pos = pos + 1
        else
            syntax_error(str, pos)
        end
    end
end

function Parser:json(str, pos)
    local first = false
    local val
    local c

    if not pos or pos == 1 then first = true end
    pos = pos or 1

    if type(str) ~= "string" then error("str should be a string")
    elseif pos > #str then error("Reached unexpected end of input") end

    c, pos = next_char(str, pos)
    if c == "{" then
        val, pos =  self:table(str, pos)
    elseif c == "[" then
        val, pos = self:array(str, pos)
    elseif c == "\"" then
        val, pos = self:string(str, pos)
    elseif c == "-" or c:match("%d") then
        val, pos = self:number(str, pos)
    else
        for k, v in pairs({ ["true"] = true, ["false"] = false, ["null"] = NULL }) do
            if (str:sub(pos, pos + #k - 1) == k) then 
                val, pos = v, pos + #k
                break
            end
        end

        if val == nil then syntax_error(str, pos) end
    end

    if first and pos <= #str then syntax_error(str, pos) end
    if self.without_null and val == NULL then val = nil end

    return val, pos
end

return Parser
