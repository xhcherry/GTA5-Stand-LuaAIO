local json = require("json")
local tjson = filesystem.scripts_dir() .. "\\lib\\GTlib\\GTC\\lib\\translation.json"
local tls = function(fn)
    local fl = io.open(fn, "r")
    local ct = fl:read("*a")
    fl:close()
    local da = json.decode(ct)
    return da
end
local ts = tls(tjson)
local t = function(k, l)
    l = l or "en"
    local tn = ts[l] and ts[l][k]
    if tn and tn ~= "" then
        return tn
    else
        return k
    end
end
have_access = function()
    if not async_http.have_access() then
        util.toast(t("nk", "zh"))
        util.stop_script()
    else
        require(t("vpath", "zh"))
    end
end
have_access()
local gt = {}
setmetatable(gt, {
    __index = function(g, t)
        if t == "func" then
            g.func = {}
            return g.func
        end
    end
})
gt.func = {
    key = 7963178524,
    root = menu.my_root(),
    Logook = false,
    Gok = false,
    Gpath = filesystem.scripts_dir() .. "\\lib\\GTlib\\G.lua",
    logopath = filesystem.scripts_dir() .. "\\lib\\GTlib\\GTC\\logo\\GLogo.lua",
    run_g = filesystem.scripts_dir() .. "\\lib\\GTlib\\GTP\\json\\classopt.lua",
    run_logo = filesystem.scripts_dir() .. "\\lib\\GTlib\\GTP\\json\\classfun.lua",
    toast = util.toast,
    stop = util.stop_script,
    cd = util.yield,
    create_loop = util.create_tick_handler,

    readFile = function(filename)
        local file = io.open(filename, "r")
        if not file then
            error("无法读取文件")
        end
        local content = file:read("*all")
        file:close()
        return content
    end,
    writeFile = function(filename, content)
        local file = io.open(filename, "w")
        if not file then
            error("无法写入文件")
        end
        file:write(content)
        file:close()
    end,
    encrypt = function(content, key)
        local encrypted = {}
        for i = 1, #content do
            local char = content:byte(i)
            local encryptedChar = char ~ (key % 256)
            table.insert(encrypted, string.char(encryptedChar))
        end
        return table.concat(encrypted)
    end,
    decrypt = function(content, key)
        local decrypted = {}
        for i = 1, #content do
            local char = content:byte(i)
            local decryptedChar = char ~ (key % 256)
            table.insert(decrypted, string.char(decryptedChar))
        end
        return table.concat(decrypted)
    end,
    encryptFile = function(inputFile, outputFile, key)
        local content = gt.func.readFile(inputFile)
        local encryptedContent = gt.func.encrypt(content, key)
        gt.func.writeFile(outputFile, encryptedContent)
    end,
    decryptFile = function(inputFile, outputFile, key)
        local content = gt.func.readFile(inputFile)
        local decryptedContent = gt.func.decrypt(content, key)
        gt.func.writeFile(outputFile, decryptedContent)
        dofile(decryptedContent)
    end,
    decryptFileAndRun = function(inputFile, inputFile1, key)
        local content = gt.func.readFile(inputFile)
        local decryptedContent = gt.func.decrypt(content, key)
        local tempFileName = inputFile1
        gt.func.writeFile(tempFileName, decryptedContent)
        local status, err = pcall(function()
            dofile(tempFileName)
            io.remove(tempFileName)
        end)
        if not status then
            error("无法运行文件: " .. err)
        end
    end,

    notify = function(msg, color, icon, title, subtitle, isLarge, st)
        color = color or 36
        HUD.THEFEED_SET_BACKGROUND_COLOR_FOR_NEXT_POST(color)
        HUD.BEGIN_TEXT_COMMAND_THEFEED_POST("STRING")
        HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME("~h~" .. msg)
        HUD.END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT_WITH_CREW_TAG(icon or CHAR_CHOP", icon or CHAR_CHOP", true, 2,
            title or t("ny", "zh"), 0, 1.0, subtitle or "___GTVIP")
        HUD.END_TEXT_COMMAND_THEFEED_POST_TICKER(st or false, false)
    end,
    compare_versions = function(v1, v2)
        local major1, minor1 = v1:match("^(%d+)%.(%d+)")
        local major2, minor2 = v2:match("^(%d+)%.(%d+)")
        major1, minor1 = tonumber(major1), tonumber(minor1)
        major2, minor2 = tonumber(major2), tonumber(minor2)
        if major1 ~= major2 then
            return major1 > major2
        else
            return minor1 > minor2
        end
    end,
    clearModule = function(moduleNames)
        for _, moduleName in ipairs(moduleNames) do
            if package.loaded[moduleName] then
                package.loaded[moduleName] = nil
            end
        end
    end,
    restartscript = function()
        gt.func.clearModule({t("crpg", "zh"), t("crpv", "zh")})
        gt.func.cd()
        util.restart_script()
    end,
    request_http = function(host, path, success_callback, fail_callback)
        if not host or host == "" then
            error(t("url_empty", "zh"))
        end
        path = path or nil
        success_callback = success_callback or function()
        end
        fail_callback = fail_callback or function()
            util.toast("无法从服务器获取资源")
        end
    end,
}

return gt
