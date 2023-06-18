-- Auto-Updater v1.6.4
-- by Hexarobi
-- For Lua Scripts for the Stand Mod Menu for GTA5
-- https://github.com/hexarobi/stand-lua-auto-updater
-- Example Usage:
--    auto_updater = require("auto-updater")
--    auto_updater.run_auto_update({
--        source_url="https://raw.githubusercontent.com/hexarobi/stand-lua-hornsongs/main/HornSongs.lua",
--        script_relpath=SCRIPT_RELPATH,  -- Set by Stand automatically for root script file, or can be used for lib files
--    })

local debug_mode = false

---
--- Dependencies
---

--util.ensure_package_is_installed('lua/json')
--local status_json, json = pcall(require, "json")
--if not status_json then error("Could not load json lib. Make sure it is selected under Stand > Lua Scripts > Repository > json") end

---
--- Utilities
---

local function string_starts(String,Start)
    return string.sub(String,1,string.len(Start))==Start
end

local function parse_url_host(url)
    return url:match("://(.-)/")
end

local function parse_url_path(url)
    return "/"..url:match("://.-/(.*)")
end

local function modify_github_url_branch(url, switch_to_branch)
    local root, path = url:match("^(https://raw.githubusercontent.com/[^/]+/[^/]+)/[^/]+/([^/].*)$")
    return root.."/"..switch_to_branch.."/"..path
end

local function debug_log(message)
    if debug_mode then
        util.log("[auto-updater] "..message)
    end
end

---
--- Version File
---

local function save_version_data(auto_update_config)
    local file = io.open(auto_update_config.version_file, "wb")
    if file == nil then util.toast("Error opening version file for writing: "..auto_update_config.version_file, TOAST_ALL) return end
    file:write(soup.json.encode(auto_update_config.version_data))
    file:close()
end

local function load_version_data(auto_update_config)
    local file = io.open(auto_update_config.version_file)
    if file then
        local version = file:read()
        file:close()
        local status, version_data = pcall(soup.json.decode, version)
        if not status and type(version) == "string" then
            version_data = {version_id=version}
        end
        auto_update_config.version_data = version_data
        --util.toast("Loaded version data "..inspect(auto_update_config.version_data), TOAST_ALL)
    else
        auto_update_config.version_data = {}
        --util.toast("Created new version data "..inspect(auto_update_config.version_data), TOAST_ALL)
    end
end

local function update_version_last_checked_time(auto_update_config)
    load_version_data(auto_update_config)
    auto_update_config.version_data.last_checked = util.current_unix_time_seconds()
    save_version_data(auto_update_config)
end

local function update_version_id(auto_update_config, version_id)
    local script_version = auto_update_config.version_data.script_version
    load_version_data(auto_update_config)
    auto_update_config.version_data.version_id = version_id
    auto_update_config.version_data.fresh_update = true
    auto_update_config.version_data.last_checked = util.current_unix_time_seconds()
    auto_update_config.version_data.script_version = script_version
    save_version_data(auto_update_config)
end

---
--- Replacer
---

local function replace_current_script(auto_update_config, new_script)
    local file = io.open(auto_update_config.script_path, "wb")
    if file == nil then
        util.toast("Error updating "..auto_update_config.script_path..". Could not open file for writing.")
    end
    file:write(new_script.."\n")
    file:close()
    auto_update_config.script_updated = true
end

local function parse_script_version(auto_update_config, script)
    auto_update_config.version_data.script_version = script:match('SCRIPT_VERSION = "([^ ]+)"')
end

---
--- Config Defaults
---

local function expand_auto_update_config(auto_update_config)
    auto_update_config.script_relpath = auto_update_config.script_relpath:gsub("\\", "/")
    auto_update_config.script_path = filesystem.scripts_dir() .. auto_update_config.script_relpath
    auto_update_config.script_filename = ("/"..auto_update_config.script_relpath):match("^.*/(.+)$")
    auto_update_config.script_reldirpath = ("/"..auto_update_config.script_relpath):match("^(.*)/[^/]+$")
    filesystem.mkdirs(filesystem.scripts_dir() .. auto_update_config.script_reldirpath)
    if auto_update_config.version_file == nil then
        auto_update_config.version_store_dir = filesystem.store_dir() .. "auto-updater" .. auto_update_config.script_reldirpath
        filesystem.mkdirs(auto_update_config.version_store_dir)
        auto_update_config.version_file = auto_update_config.version_store_dir .. "/" .. auto_update_config.script_filename .. ".version"
    end
    if auto_update_config.source_url == nil then        -- For backward compatibility with older configs
        auto_update_config.source_url = "https://" .. auto_update_config.source_host .. "/" .. auto_update_config.source_path
    end
    if auto_update_config.switch_to_branch ~= nil then
        auto_update_config.source_url = modify_github_url_branch(auto_update_config.source_url, auto_update_config.switch_to_branch)
    end
    --if auto_update_config.restart_delay == nil then
    --    auto_update_config.restart_delay = 100
    --end
    if auto_update_config.http_timeout == nil then
        auto_update_config.http_timeout = 30000
    end
    if auto_update_config.expected_status_code == nil then
        auto_update_config.expected_status_code = 200
    end
    if auto_update_config.check_interval == nil then
        auto_update_config.check_interval = 86400 -- Daily = 86400 seconds
    end
    load_version_data(auto_update_config)
end

---
--- Downloader
---

local is_download_complete

local function process_auto_update(auto_update_config)
    async_http.init(parse_url_host(auto_update_config.source_url), parse_url_path(auto_update_config.source_url), function(result, headers, status_code)
        if status_code == 304 then
            -- No update found
            update_version_last_checked_time(auto_update_config)
            is_download_complete = true
            return
        end
        if status_code ~= auto_update_config.expected_status_code then
            util.toast("Error updating "..auto_update_config.script_filename..": Unexpected status code: "..status_code, TOAST_ALL)
            is_download_complete = false
            return
        end
        if not result or result == "" then
            util.toast("Error updating "..auto_update_config.script_filename..": Empty content", TOAST_ALL)
            is_download_complete = false
            return
        end
        if auto_update_config.verify_file_begins_with ~= nil then
            if not string_starts(result, auto_update_config.verify_file_begins_with) then
                util.toast("Error updating "..auto_update_config.script_filename..": Found invalid content", TOAST_ALL)
                is_download_complete = false
                return
            end
        end
        if auto_update_config.verify_file_does_not_begin_with == nil then
            auto_update_config.verify_file_does_not_begin_with = "<"
        end
        if string_starts(result, auto_update_config.verify_file_does_not_begin_with) then
            util.toast("Error updating "..auto_update_config.script_filename..": Found invalid content", TOAST_ALL)
            is_download_complete = false
            return
        end
        replace_current_script(auto_update_config, result)
        parse_script_version(auto_update_config, result)
        if headers then
            for header_key, header_value in pairs(headers) do
                if header_key:lower() == "etag" then
                    update_version_id(auto_update_config, header_value)
                end
            end
        end
        is_download_complete = true
        if not auto_update_config.silent_updates then
            util.toast("Updated "..auto_update_config.script_filename, TOAST_ALL)
        end
    end, function()
        util.toast("Error updating "..auto_update_config.script_filename..": Update failed to download.", TOAST_ALL)
    end)
    -- Only use cached version if this is not a clean reinstall, and if the file still exists on disk
    if auto_update_config.clean_reinstall ~= true and filesystem.exists(auto_update_config.script_path) then
        -- Use ETags to only fetch files if they have been updated
        -- https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/ETag
        if auto_update_config.version_data.version_id then
            async_http.add_header("If-None-Match", auto_update_config.version_data.version_id)
        end
    end
    async_http.dispatch()
end

local function is_due_for_update_check(auto_update_config)
    return (
        auto_update_config.clean_reinstall == true
        or auto_update_config.version_data.last_checked == nil
        or auto_update_config.check_interval == 0
        or ((util.current_unix_time_seconds() - auto_update_config.version_data.last_checked) > auto_update_config.check_interval)
        or (not filesystem.exists(auto_update_config.script_path))
    )
end

---
--- Require with Auto Update (for libs)
---

local function require_with_auto_update(auto_update_config)
    auto_update_config.lib_require_path = auto_update_config.script_relpath:gsub("[.]lua$", "")
    --if auto_update_config.auto_restart == nil then auto_update_config.auto_restart = false end
    run_auto_update(auto_update_config)
    local auto_loaded_lib_status, loaded_lib = pcall(require, auto_update_config.lib_require_path)
    if not auto_loaded_lib_status then
        util.toast("Failed to load required file: "..auto_update_config.script_relpath.."\n"..tostring(loaded_lib), TOAST_ALL)
        return
    end
    auto_update_config.loaded_lib = loaded_lib
    return loaded_lib
end

---
--- Auto Update Check
---

function run_auto_update(auto_update_config)
    expand_auto_update_config(auto_update_config)
    debug_log("Running auto-update on "..auto_update_config.script_filename.."...", TOAST_ALL)
    if not auto_update_config.is_dependency then util.set_busy(true) end
    if is_due_for_update_check(auto_update_config) then
        is_download_complete = nil
        util.create_thread(function()
            process_auto_update(auto_update_config)
        end)
        local i = 1
        while (is_download_complete == nil and i < (auto_update_config.http_timeout / 500)) do
            util.yield(250)
            i = i + 1
        end
        if is_download_complete == nil then
            util.toast("Error updating "..auto_update_config.script_filename..": HTTP Timeout. This error can often be resolved by using Cloudflare DNS settings: 1.1.1.1 and 1.0.0.1 For more info visit http://1.1.1.1/dns/", TOAST_ALL)
            return false
        end
        if (auto_update_config.script_updated and not auto_update_config.is_dependency) and auto_update_config.auto_restart ~= false then
            debug_log("Restarting...", TOAST_ALL)
            if auto_update_config.restart_delay then util.yield(auto_update_config.restart_delay) end
            util.restart_script()
            return
        end
    end
    local dependency_updated = false
    if auto_update_config.dependencies ~= nil then
        for _, dependency in pairs(auto_update_config.dependencies) do
            dependency.is_dependency = true
            if dependency.silent_updates == nil then dependency.silent_updates = auto_update_config.silent_updates end
            if (is_due_for_update_check(auto_update_config) or auto_update_config.script_updated or auto_update_config.version_data.fresh_update) then dependency.check_interval = 0 end
            if dependency.is_required and dependency.script_relpath:match("(.*)[.]lua$") then
                require_with_auto_update(dependency)
            else
                run_auto_update(dependency)
            end
            if dependency.script_updated then dependency_updated = true end
        end
    end
    if (dependency_updated) and auto_update_config.auto_restart ~= false then
        debug_log("Dependency updated. Restarting...", TOAST_ALL)
        if auto_update_config.restart_delay then util.yield(auto_update_config.restart_delay) end
        util.restart_script()
        return
    else
        if auto_update_config.version_data.fresh_update and not auto_update_config.is_dependency then
            -- TODO: Show changelog
            if auto_update_config.version_data.script_version then
                util.toast("Updated "..auto_update_config.script_filename.." to "..tostring(auto_update_config.version_data.script_version), TOAST_ALL)
            end
            auto_update_config.version_data.fresh_update = false
            save_version_data(auto_update_config)
        end
    end
    if not auto_update_config.is_dependency then util.set_busy(false) end
    return true
end


---
--- Legacy Compatibility
---

-- Wrapper for old function names
function auto_update(auto_update_config)
    run_auto_update(auto_update_config)
end

---
--- Self-Update
---

util.create_thread(function()
    run_auto_update({
        source_url="https://raw.githubusercontent.com/hexarobi/stand-lua-auto-updater/main/auto-updater.lua",
        script_relpath="lib/auto-updater.lua",
        verify_file_begins_with="--",
        check_interval = 86400,
    })
end)

---
--- Return Object
---

return {
    run_auto_update = run_auto_update,
    require_with_auto_update = require_with_auto_update,
}
