---@diagnostic disable: undefined-global
-- Author: well in that case#0082 (700091773695033505)
-- INI Parser: Parse your INI configuration files into their Lua-table equivalent.
--
-- Licensing:
--      - You're granted the four essential freedoms of free software (https://www.gnu.org/philosophy/free-sw.html#four-freedoms) under these conditions:
--          - You don't claim you've originally made this script.
--          - If you modify this script, you include a link to the original source on GitLab (found below) inside of your repository or source:
--              - https://gitlab.com/wellinthatcase/2take1-scripts-case/-/blob/main/ini_parser.lua
--
-- Other Credits:
--      - kektram#8996 (743564698699563020); significantly assisted with parse optimizations, and other areas such as garbage collection.

local ini = {
    version = "0.2.8",
    __debug = false
}

-- Localizing things we'll use often, for faster access.
-- This allows Lua to index the stack instead of performing a hash lookup each time we make a call to _G.
local type,
f_open,
str_sub,
str_len,
tostring,
tonumber,
str_gmatch,
default_path = type, io.open, string.sub, string.len, tostring, tonumber, string.gmatch, nil

if menu then
    default_path = filesystem.scripts_dir() .. '\\store\\'
else
    default_path = "./"
end

-----------------------
--  Debug Utilities  --
-----------------------
function ini._Case_Ini_Recurse(tab, tab_name)
    for key, val in pairs(tab) do
        if type(val) == "table" then
            ini._Case_Ini_Recurse(val, key)
        else
            tab = tostring(tab)
            util.log("KEY: "..key.."\nTYPE: "..type(val).."\nVALUE: "..tostring(val).."\nTABLE: "..(tab_name or tab).."\n")
        end
    end
end

-------------------------
-- Beginning of Parser --
-------------------------

-- str:sub previously in parseStringIntoLuaValue created a new string * amount of lines in the file.
-- I learned during profiling that I created upwards of 55,000 dead-strings, along with using tonumber on all of them.
-- So, this table looks less visually appealing, but it's significantly better for medium to large files, should they ever exist.
local luaBoolValues = {
    ["nil"] = "nil",
    [" nil"] = "nil",
    ["nil "] = nil,
    ["true"] = true,
    [" true"] = true,
    ["true "] = true,
    ["false"] = false,
    [" false"] = false,
    ["false "] = false
}

-- A lot of local functions could be removed because they existed only to describe the action.
-- This can't be 'inlined' because it's called several different times in several different locations.
local function serializeKey(str)
    if str_sub(str, -1) == " " then
        str = str_sub(str, 1, #str - 1)
    end

    return str
end

-- This skips parsing, which makes it significantly faster, but far less useful.
-- The use of `ini.match` is to match key_name=desired_value, so if you wish to affirm values directly, and only affirm them, use this.
-- This will not automatically render desired_value into a number or boolean, so you will always need to pass a string.
--
-- Notes:
--  Reading how Kek's Lua handled INI files inspired me to create `ini.parse`, but the original use of how Kektram affirmed values was still useful.
--  As a result, `ini.match` brings the best of both worlds, between value affirmation and parsing INI into a Lua table.
--
-- Unlike `ini.parse` this will not give you the option to treat your file as if it was a Lua table.
function ini.match(path, key_name, desired_value, use_cache)
    local handle <close> = f_open(path, "r")
    local content = handle:read("*a")

    return content:match(key_name.."=(%a%a%a%a)") == desired_value
end

-- Parse an INI file from `path`.
-- `cwd` is an optional parameter to specify the current working directory. Useful for relative importing.
--
-- This function tries to dicipher if `path` is already absolute by checking if it leads to an existing file.
-- If it does, then path isn't modified. However, if it does not, then cwd is concatenated before path then we check again.
-- If that check proves to be fruitful, then we consider cwd .. path to be the full path. That's effectively a relative import.
--
-- To note though, in some rare circumstances, a file may exist in both the absolute path you've passed, and in the CWD.
-- If this happens, then `path` is left as-is, and the absolute path is preferred over the relative one.
function ini.parse(path, cwd)
    assert(type(cwd) == "string" or type(cwd) == "nil", "ini.parse 'cwd' must be a string.")
    assert(type(path) == "string", "ini.parse 'path' must be a string.")

    -- Decipher `path` and decide whether it's absolute or relative.
    do
        cwd = cwd or default_path
        local _1, absStatus = pcall(function() return f_open(path) ~= nil end)
        local _2, relStatus = pcall(function() return f_open(path) ~= nil end)

        -- We need to ensure there were no errors for 2T1 compatibility.
        absStatus = _1 and absStatus
        relStatus = _2 and relStatus

        if absStatus then
            path = path
        elseif relStatus and not absStatus then
            path = cwd..path
        elseif not (absStatus and relStatus) then
            -- Note: Wrapping in pcall remains for 2T1 API support, since errors are thrown for non-appdata paths.
            local status, _ = pcall(function ()
                local f = f_open(path, "a+")
                if f then f:close() end
            end)

            if status then
                path = path
            else
                local status1, _1 = pcall(function ()
                    local f = f_open(cwd .. path, "a+")
                    if f then f:close() end
                end)

                if not status1 then
                    util.log("Err Paths:\n1:"..cwd..path.."\n2:"..path)
                    error "ini.parse path leads to nil file. Check debug console for err paths."
                else
                    path = cwd .. path
                end
            end
        end
    end

    local res,
    cache,
    section,
    subsection = {}, { lines = {}, values = {}, keys = {} }, nil, nil -- Inline cache gave smaller execution times.

    local file <close> = f_open(path)

    -- This gets messy because we must minimize function calls; they're very expensive in Lua.
    for str in str_gmatch(file:read("*a"), "[^\n\r\x80-\xFF]+") do
        local lc = str_sub(str, -1)     -- Last character.
        local fc = str_sub(str, 1, 1)   -- First character.

        -------------------------------------------------------------
        -- Only continue if the line meets the following conditions:
        --      1. It's not a comment.
        --      2. It isn't just a new-line.
        -------------------------------------------------------------
        if not (fc == ";" or fc == "\n") then
            -- This line is a section.
            if fc == "[" and lc == "]" then
                local name = str_sub(str, 2, -2)

                if section ~= name then
                    section = serializeKey(name)
                end
            else
                --------------------------------------
                -- Checking if this line is cached: --
                --------------------------------------
                local cache_line = cache.lines[str]
                if cache_line then
                    if section then
                        if not res[section] then
                            res[section] = {}
                        end

                        res[section][cache_line.key] = cache_line.value
                    else
                        res[cache_line.key] = cache_line.value
                    end
                else
                    ------------------------------------------------
                    -- This line is not cached, let's process it. --
                    ------------------------------------------------
                    for key, value in str_gmatch(str, "%s*([^=]*)=([^=]*)%f[%s%z]") do
                        local serialized_val, serialized_key

                        -- Check if the key has been cached:
                        local cache_key = cache.keys[key]
                        if cache_key then
                            serialized_key = cache_key
                        else
                            serialized_key = serializeKey(key)
                            cache.keys[serialized_key] = serialized_key
                        end

                        -- Check if the value has been cached:
                        local cache_val = cache.values[value]
                        if cache_val then
                            serialized_val = cache_val
                        else
                            -- For locales using comma as decimal comma separator
                            if type(value) == "string" then value = value:gsub(",", ".") end

                            local nVal = tonumber(value)
                            local bVal = luaBoolValues[value]

                            if nVal then
                                serialized_val = nVal
                            elseif bVal ~= nil then
                                if bVal == "nil" then
                                    serialized_val = nil
                                else
                                    serialized_val = bVal
                                end
                            end

                            cache.values[value] = serialized_val
                        end

                        -- Insert into category if one exists, otherwise insert as-is.
                        if section then
                            if not res[section] then
                                res[section] = {}
                            end

                            res[section][serialized_key] = serialized_val
                        else
                            res[serialized_key] = serialized_val
                        end

                        -- Cache this line.
                        cache.lines[str] = { key = serialized_key, value = serialized_val }
                    end
                end
            end
        end
    end

    res.save = function (_path, skip_keys)
        local cats, resl, skip = {}, {}, {}

        if type(skip_keys) == "table" then
            for _, k in next, skip_keys do
                skip[k] = 0
            end
        end

        for key, value in pairs(res) do
            if not skip[key] and type(value) == "table" then
                table.insert(cats, key)
            end
        end

        for key, value in pairs(res) do
            if not skip[key] and type(value) ~= "table" and type(value) ~= "function" then
                key = tostring(key)
                value = tostring(value)

                if value:sub(1, 1) == " " then
                    value = value:gsub(2, #value)
                end

                resl[#resl + 1] = key .. "=" .. value
            end
        end

        for _, tab in pairs(cats) do
            resl[#resl + 1] = "[" .. tab .. "]"

            for key, value in pairs(res[tab]) do
                key = tostring(key)
                value = tostring(value)

                if value:sub(1, 1) == " " then
                    value = value:gsub(2, #value)
                end

                resl[#resl + 1] = key .. "=" .. value
            end
        end

        local status, _ = pcall(function ()
            local f <close> = f_open(_path or path, "w+")
            if f then
                f:write(table.concat(resl, "\n"))
            else
                error("ini.parse.save path invalid: ".._path or path)
            end
        end)

        return status
    end

    -- QoL Improvement; it allows `cfg.new_category.key = value` to be used when `new_category` doesn't actually exist yet.
    setmetatable(res, {
        __index = function (_, k)
            res[k] = {}

            setmetatable(res[k], {
                __newindex = function (tab, key, val)
                    local mt = getmetatable(tab)
                    local ni = nil

                    if mt then
                        ni = mt.__newindex
                        mt.__newindex = nil
                    end

                    res[k][key] = val

                    if ni then
                        mt.__newindex = ni
                    end
                end
            })

            return res[k]
        end
    })

    collectgarbage()
    return res
end

return ini
