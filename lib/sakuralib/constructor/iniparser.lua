local ini = {
    version = "0.2.10",
    __debug = false
}

-- Localizing things we'll use often, for faster access.
-- This allows Lua to index the stack instead of performing a hash lookup each time we make a call to _G.
local type,
f_open,
str_sub,
str_len,
str_gmatch = type, io.open, string.sub, string.len, string.gmatch

-------------------------
-- Universal Functions --
-------------------------

local og_tostring = tostring
local function tostring(...)
    local old = os.setlocale(nil, "all")
    os.setlocale("en_US.UTF-8", "numeric")
    local ok, res = pcall(og_tostring, ...)
    os.setlocale(old, "all")
    if not ok then
        error(res)
    end
    return res
end

local og_tonumber = tonumber
local function tonumber(...)
    local old = os.setlocale(nil, "all", "numeric")
    os.setlocale("en_US.UTF-8", "numeric")
    local ok, res = pcall(og_tonumber, ...)
    os.setlocale(old, "all")
    if not ok then
        error(res)
    end
    return res
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
            print("KEY: "..key.."\nTYPE: "..type(val).."\nVALUE: "..tostring(val).."\nTABLE: "..(tab_name or tab).."\n")
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
    local handle = f_open(path, "r")
    local content = handle:read("*a")
    handle:close()

    return content:match(key_name.."=(%a%a%a%a)") == desired_value
end

-- Parse an INI file from `path`.
-- `options` is an optional table parameter, that may contain the following keys:
-- - "cwd" to specify the current working directory. Useful for relative importing.
--   For compatibility, the `options` parameter may be a string, in which case it's implied to be this "cwd" value.
-- - "commaCompat" to enable compatibility for files that use ',' as a decimal separator to read floats correctly
function ini.parse(path, options)
    assert(type(options) == "table" or type(options) == "string" or type(options) == "nil", "ini.parse 'options' must be a table.")
    assert(type(path) == "string", "ini.parse 'path' must be a string.")

    if options == nil then
        options = {}
    elseif type(options) == "string" then
        options = {
            cwd = options
        }
    end
    if options.cwd ~= nil then
        path = options.cwd .. path
    end

    local res,
    cache,
    section = {}, { lines = {}, values = {}, keys = {} }, nil -- Inline cache gave smaller execution times.

    local file = f_open(path)

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
                            cache.keys[key] = serialized_key
                        end

                        -- Check if the value has been cached:
                        local cache_val = cache.values[value]
                        if cache_val then
                            serialized_val = cache_val
                        else
                            local nVal
                            if options.commaCompat then
                                local tmp = value:gsub(",", ".")
                                nVal = tonumber(tmp)
                            else
                                nVal = tonumber(value)
                            end
                            local bVal = luaBoolValues[value]

                            if nVal then
                                serialized_val = nVal
                            elseif bVal ~= nil then
                                if bVal == "nil" then
                                    serialized_val = nil
                                else
                                    serialized_val = bVal
                                end
                            else
                                serialized_val = value
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

    file:close()

    res.save = function (_path, skip_keys)
        local cats,
        resl,
        skip = {}, {}, {}

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
            local f = f_open(_path or path, "w+")
            if f then
                f:write(table.concat(resl, "\n"))
                f:close()
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
                    local mt, __newindex = getmetatable(tab), nil

                    if mt then
                        __newindex = mt.__newindex
                        mt.__newindex = nil
                    end

                    res[k][key] = val

                    if __newindex then
                        mt.__newindex = __newindex
                    end
                end
            })

            return res[k]
        end
    })

    return res
end

return ini
