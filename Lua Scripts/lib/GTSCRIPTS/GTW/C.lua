--[[   To everyone who uses Heist Control.lua

    Developed and maintenanced by IceDoomfist#0001 on Discord
    This script is only compatible with Stand Lua API: https://stand.gg/

    Stand Heist Control contains some global, local variables and stats from Heist Control V2 & Master Unlocker Lua Scripts for 2Take1 and UnknownCheats
    Thanks for allowing me to use your code, jhowkNx: https://github.com/jhowkNx
    I've often been contacting on Discord, testing some developing features, sharing information like stats, global and local variables and other codes each other.

    Heist Control V2: https://github.com/jhowkNx/Heist-Control-v2
    Master Unlocker: https://github.com/jhowkNx/Master-Unlocker
    UnknownCheats: https://www.unknowncheats.me/forum/grand-theft-auto-v/

]]--

--[[   To developers who wanna learn about stats, global and local variables or Stand Lua Script API by looking into Heist Control.lua

    Thanks for looking into my script to learn something.
    This lua script is only one heist related script without these stuffs. (ALL open-source and highly polished code)
    1. Encrypting (Included compilling like .luac or using unknown methods)
    2. Highly skidded code (Almost of this case are Kiddions lua scripts coded by unknown users)

    Here are bunch of links that will be useful to you.
    I hope your learning goes well.

    Lua Tutorial: https://www.tutorialspoint.com/lua/index.htm
    - To learn basics of Lua programming language
    Stand Lua API Documentation: https://stand.gg/help/lua-api-documentation
    - To learn Stand Lua API
    UnknownCheats: https://www.unknowncheats.me/forum/grand-theft-auto-v/
    - To learn stats, global and local variables
    FiveM Docs - Game References: https://docs.fivem.net/docs/game-references/
    - Controls, Blips, etc
    Labels: https://github.com/root-cause/v-labels
    - To find stats, global and local variables by yourself.
    GTA Online Decompiled Scripts: https://github.com/root-cause/v-decompiled-scripts (Recommended) and https://github.com/Primexz/GTAV-Decompiled-Scripts
    - To find stats, global and local variables by yourself. 'freemode.c' and 'tuneables_processing.c' are used oftenly to me. 

]]--

--[[   LICENSING

    1. You can use my code if your project is *open-source and specify credit this Github page: https://github.com/IceDoomfist/Stand-Heist-Control
    2. Prohibited to use my code in ANY *mod menus. (Especially, Rebound mod menu)
    2-1. If you want to use my code, please contact on Discord: IceDoomfist#0001

    *open-source: Not used ANY encryption methods except .luac
    *mod menus: A project that almost of codes are consisted with C or C++ or C#

]]--


--- Lua Script Settings

    --- Important

        HC_VERSION = "V 3.3.1"
        CODED_GTAO_VERSION = 1.66
        SUPPORTED_STAND_VERSION = 101 -- Stand 101 | https://stand.gg/help/changelog | Not mentioned in the Changelog: 'menu.hyperlink' only accepts http and https links due to security issues

    ---

    --- Directory Settings

    HC_DIR = filesystem.scripts_dir() .. "/GTLuaScript/" .. '/Heist Control/'
        
        FolderDirs = {
            Img = HC_DIR .. "Image\\",
            Setting = HC_DIR .. "Setting\\",
            Lang = HC_DIR .. "Language\\",
            HaxUI = HC_DIR .. "GTAHaXUI\\",
        }

        FileDirs = {
            Setting = FolderDirs.Setting .. "Setting.txt",
            Log = FolderDirs.Setting .. "Log.txt",
        }

        LangDirs = {
            Custom = FolderDirs.Lang .. "Custom.txt",
            Chinese = FolderDirs.Lang .. "Chinese.txt",
            English = FolderDirs.Lang .. "English.txt",
            French = FolderDirs.Lang .. "French.txt",
            German = FolderDirs.Lang .. "German.txt",
            Italian = FolderDirs.Lang .. "Italian.txt",
            Japanese = FolderDirs.Lang .. "Japanese.txt",
            Korean = FolderDirs.Lang .. "Korean.txt",
            Polish = FolderDirs.Lang .. "Polish.txt",
            Portuguese = FolderDirs.Lang .. "Portuguese.txt",
            Russian = FolderDirs.Lang .. "Russian.txt",
            Spanish = FolderDirs.Lang .. "Spanish.txt",
        }

    ---

    --- Core Functions

        function ADD_MP_INDEX(stat)
            local Exceptions = {
                "MP_CHAR_STAT_RALLY_ANIM",
                "MP_CHAR_ARMOUR_1_COUNT",
                "MP_CHAR_ARMOUR_2_COUNT",
                "MP_CHAR_ARMOUR_3_COUNT",
                "MP_CHAR_ARMOUR_4_COUNT",
                "MP_CHAR_ARMOUR_5_COUNT",
            }
            for _, exception in pairs(Exceptions) do
                if stat == exception then
                    return "MP" .. util.get_char_slot() .. "_" .. stat
                end
            end

            if not string.contains(stat, "MP_") and not string.contains(stat, "MPPLY_") then
                return "MP" .. util.get_char_slot() .. "_" .. stat
            end
            return stat
        end

        function STAT_SET_INT(stat, value)
            STATS.STAT_SET_INT(util.joaat(ADD_MP_INDEX(stat)), value, true)
        end
        function STAT_SET_FLOAT(stat, value)
            STATS.STAT_SET_FLOAT(util.joaat(ADD_MP_INDEX(stat)), value, true)
        end
        function STAT_SET_BOOL(stat, value)
            STATS.STAT_SET_BOOL(util.joaat(ADD_MP_INDEX(stat)), value, true)
        end
        function STAT_SET_STRING(stat, value)
            STATS.STAT_SET_STRING(util.joaat(ADD_MP_INDEX(stat)), value, true)
        end
        function STAT_SET_DATE(stat, year, month, day, hour, min)
            local DatePTR = memory.alloc(8*7) -- Thanks for helping memory stuffs, aaronlink127#0127
            memory.write_int(DatePTR, year)
            memory.write_int(DatePTR+8, month)
            memory.write_int(DatePTR+16, day)
            memory.write_int(DatePTR+24, hour)
            memory.write_int(DatePTR+32, min)
            memory.write_int(DatePTR+40, 0) -- Seconds
            memory.write_int(DatePTR+48, 0) -- Milliseconds
            STATS.STAT_SET_DATE(util.joaat(ADD_MP_INDEX(stat)), DatePTR, 7, true)
        end

        function STAT_SET_MASKED_INT(stat, value1, value2)
            STATS.STAT_SET_MASKED_INT(util.joaat(ADD_MP_INDEX(stat)), value1, value2, 8, true)
        end
        function SET_PACKED_STAT_BOOL_CODE(stat, value)
            STATS.SET_PACKED_STAT_BOOL_CODE(stat, value, util.get_char_slot())
        end
        function STAT_INCREMENT(stat, value)
            STATS.STAT_INCREMENT(util.joaat(ADD_MP_INDEX(stat)), value, true)
        end

        function STAT_GET_INT(stat)
            local IntPTR = memory.alloc_int()
            STATS.STAT_GET_INT(util.joaat(ADD_MP_INDEX(stat)), IntPTR, -1)
            return memory.read_int(IntPTR)
        end
        function STAT_GET_FLOAT(stat)
            local FloatPTR = memory.alloc_int()
            STATS.STAT_GET_FLOAT(util.joaat(ADD_MP_INDEX(stat)), FloatPTR, -1)
            return tonumber(string.format("%.3f", memory.read_float(FloatPTR)))
        end
        function STAT_GET_BOOL(stat)
            if STAT_GET_INT(stat) ~= 0 then
                return "true"
            else
                return "false"
            end
        end
        function STAT_GET_STRING(stat)
            return STATS.STAT_GET_STRING(util.joaat(ADD_MP_INDEX(stat)), -1)
        end
        function STAT_GET_DATE(stat, type)
            local DatePTR = memory.alloc(8*7)
            STATS.STAT_GET_DATE(util.joaat(ADD_MP_INDEX(stat)), DatePTR, 7, true)
            local DateTypes = {
                "Years",
                "Months",
                "Days",
                "Hours",
                "Mins",
                -- Seconds,
                -- Milliseconds,
            }
            for i = 1, #DateTypes do
                if type == DateTypes[i] then
                    return memory.read_int(DatePTR + 8 * (i - 1))
                end
            end
        end

        function SET_INT_GLOBAL(global, value)
            memory.write_int(memory.script_global(global), value)
        end
        function SET_FLOAT_GLOBAL(global, value)
            memory.write_float(memory.script_global(global), value)
        end

        function GET_INT_GLOBAL(global)
            return memory.read_int(memory.script_global(global))
        end

        function SET_PACKED_INT_GLOBAL(start_global, end_global, value)
            for i = start_global, end_global do
                SET_INT_GLOBAL(262145 + i, value)
            end
        end

        function SET_INT_LOCAL(script, script_local, value)
            if memory.script_local(script, script_local) ~= 0 then
                memory.write_int(memory.script_local(script, script_local), value)
            end
        end
        function SET_FLOAT_LOCAL(script, script_local, value)
            if memory.script_local(script, script_local) ~= 0 then
                memory.write_float(memory.script_local(script, script_local), value)
            end
        end

        function GET_INT_LOCAL(script, script_local)
            if memory.script_local(script, script_local) ~= 0 then
                local ReadLocal = memory.read_int(memory.script_local(script, script_local))
                if ReadLocal ~= nil then
                    return ReadLocal
                end
            end
        end

        function SET_BIT(bits, place) -- Credit goes to WiriScript
            return (bits | (1 << place))
        end
        function SET_GLOBAL_BIT(global, bit)
            local Addr = memory.script_global(global)
            memory.write_int(Addr, SET_BIT(memory.read_int(Addr), bit))
        end
        function SET_LOCAL_BIT(script, script_local, bit)
            if memory.script_local(script, script_local) ~= 0 then
                local Addr = memory.script_local(script, script_local)
                memory.write_int(Addr, SET_BIT(memory.read_int(Addr), bit))
            end
        end

    ---
    
    --- Folders and Log Functions

        for _, folder in pairs(FolderDirs) do
            if not filesystem.exists(folder) then
                filesystem.mkdirs(folder)
            end
        end

        function CREATE_OR_RESET_FILE(dir)
            local open = io.open(dir, "w+")
            open:write("")
            open:close()
        end

        if not filesystem.exists(FileDirs.Log) then
            CREATE_OR_RESET_FILE(FileDirs.Log)
        end
        function LOG(message)
            local open = io.open(FileDirs.Log, "a+")
            open:write(os.date("[%m/%d/%Y %I:%M:%S %p]") .. " " .. message .. "\n")
            open:close()
        end
        
        function ERROR_LOG(error_message)
            LOG("Heist Control Version: " .. HC_VERSION)
            LOG("| Heist Control - ERROR | " .. error_message .. "\n")
            util.toast("Heist Control | ERROR " .. "\n\n" .. error_message)
            util.yield_once()
            util.stop_script()
        end

    ---

    --- Settings for HC

        DEFAULT_SETTINGS = { -- { setting_type, setting_value }
            { "Language", "Unknown" },
            { "Notification Type", "Stand" },
            { "Notification Icon", "HC Logo" },
            { "Notification Icon Code", "Logo" },
            { "Notification Color", "Black" },
            { "Notification Color Code", "140" },
            { "Timer Color", "White" },
            { "Timer Color Code", "FFFFFFFF" },
            { "Saved Command Name", "N/A" },
        }
        function WRITE_DEFAULT_SETTINGS()
            local FinalSettings = {}
            for i = 1, #DEFAULT_SETTINGS do
                table.insert(FinalSettings, DEFAULT_SETTINGS[i][1] .. ": " .. DEFAULT_SETTINGS[i][2])
            end
            CREATE_OR_RESET_FILE(FileDirs.Setting)

            local open = io.open(FileDirs.Setting, "a+")
            for _, setting in pairs(FinalSettings) do
                open:write(setting .. "\n")
            end
            open:close()
        end

        if not filesystem.exists(FileDirs.Setting) then
            CREATE_OR_RESET_FILE(FileDirs.Setting)
            WRITE_DEFAULT_SETTINGS()
        end

        Settings = {}
        function READ_SETTING(type)
            local Values = {}
            local open = io.open(FileDirs.Setting, "r")
            for line in open:lines() do
                table.insert(Values, line)
            end
            open:close()

            for idx, setting in pairs(Values) do
                Settings[idx] = { nil, nil } -- { type, value }
                local i, j = string.find(setting, ": ")
                if i and j ~= nil then
                    Settings[idx][1] = string.sub(setting, 0, i - 1)
                    Settings[idx][2] = string.sub(setting, j + 1, string.len(setting))
                end
            end

            local IsOldFormat = false
            for i = 1, #Settings do -- If Settings.txt file is consisted of old format
                for j = 1, 5 do
                    if Settings[i][1] == tostring(j) then
                        IsOldFormat = true
                        Settings[i][1] = DEFAULT_SETTINGS[i][1]
                        Settings[i][2] = DEFAULT_SETTINGS[i][2]
                    end
                end
            end

            if IsOldFormat then
                WRITE_DEFAULT_SETTINGS()
            end

            for i = 1, #Settings do
                if Settings[i][1] == type then
                    return Settings[i][2]
                end
            end

            for i = 1, #DEFAULT_SETTINGS do
                WRITE_DEFAULT_SETTINGS()
                if DEFAULT_SETTINGS[i][1] == type then
                    return DEFAULT_SETTINGS[i][2]
                end
            end
        end

        function WRITE_SETTING(type, value)
            for i = 1, #Settings do
                if Settings[i][1] == type then
                    Settings[i][2] = value
                    break
                elseif i == #Settings then
                    for j = 1, #DEFAULT_SETTINGS do
                        if DEFAULT_SETTINGS[j][1] == type then
                            Settings[j][1] = type
                            Settings[j][2] = value
                        end
                    end
                end
            end

            local FinalSettings = {}
            for i = 1, #Settings do
                table.insert(FinalSettings, Settings[i][1] .. ": " .. Settings[i][2])
            end

            CREATE_OR_RESET_FILE(FileDirs.Setting)
            local open = io.open(FileDirs.Setting, "a+")
            for _, setting in pairs(FinalSettings) do
                open:write(setting .. "\n")
            end
            open:close()
        end

    ---

    --- Translation Settings

        if READ_SETTING("Language") == "Unknown" then -- When execute HC for first time
            WRITE_SETTING("Language", "English")

            local LangByStandCodes = {
                { "zh", "Chinese - 中文" },
                { "fr", "French - français" },
                { "de", "German - Deutsch" },
                { "ko", "Korean - 한국어" },
                { "pl", "Polish - Polski" },
                { "pt", "Portuguese - Português" },
                { "ru", "Russian - русский" },
                { "es", "Spanish - Español" },
            }
            for i = 1, #LangByStandCodes do
                if lang.get_current() == LangByStandCodes[i][1] then
                    WRITE_SETTING("Language", LangByStandCodes[i][2])
                end
            end

            local LangByGTACodes = {
                { 3, "Italian - Italiano" },
                { 10, "Japanese - 日本語"},
            }
            for i = 1, #LangByGTACodes do
                if LOCALIZATION.GET_CURRENT_LANGUAGE() == LangByGTACodes[i][1] then
                    WRITE_SETTING("Language", LangByGTACodes[i][2])
                end
            end
        end

        function DIR_TO_FILE_NAME(folder, dir)
            local _, i = string.find(dir, folder .. "\\")
            local j = string.find(dir, ".txt")
            return string.sub(dir, i + 1, j - 1)
        end

        Translations = {}
        function LOAD_LANG(dir)
            for _, lang_dir in pairs(LangDirs) do
                if dir == lang_dir then
                    if filesystem.exists(lang_dir) then
                        local open = io.open(lang_dir, "r")
                        for line in open:lines() do
                            table.insert(Translations, line)
                        end
                        open:close()
                    else
                        ERROR_LOG(DIR_TO_FILE_NAME("Language", lang_dir) .. " language file for HC doesn't exist." .. "\n\n" .. "Please install HC from the Repository for Lua Scripts of Stand menu!")
                    end
                end
            end
        end

        LanguageByDirs = {
            { "Custom", LangDirs.Custom },
            { "Chinese - 中文", LangDirs.Chinese },
            { "English", LangDirs.English },
            { "French - français", LangDirs.French },
            { "German - Deutsch", LangDirs.German },
            { "Italian - Italiano", LangDirs.Italian },
            { "Japanese - 日本語", LangDirs.Japanese },
            { "Korean - 한국어", LangDirs.Korean },
            { "Polish - Polski", LangDirs.Polish },
            { "Portuguese - Português", LangDirs.Portuguese },
            { "Russian - русский", LangDirs.Russian },
            { "Spanish - Español", LangDirs.Spanish },
        }
        for i = 1, #LanguageByDirs do
            if READ_SETTING("Language") == LanguageByDirs[i][1] then
                LOAD_LANG(LanguageByDirs[i][2])
            end
        end

        TransFormat = " = "
        function TRANSLATE(text)
            local Translation = ""
            for i = 1, #Translations do
                local _, j = string.find(Translations[i], TransFormat)
                if j ~= nil then
                    if not string.contains(Translations[i], "#") then
                        Translation = string.sub(Translations[i], j + 1, string.len(Translations[i]))
                    end
                end
                
                if Translation ~= "" then
                    if Translations[i] == text .. TransFormat .. Translation then
                        return Translation
                    end
                end
            end
            return text
        end

    ---

    --- Other Functions

        function SHOW_IMG(img_name, max_passed_time) -- Credit goes to LanceScript Reloaded
            if filesystem.exists(FolderDirs.Img .. img_name) then
                local ImgAlpha = 0
                local IncreasedImgAlpha = 0.01
                util.create_tick_handler(function()
                    ImgAlpha = ImgAlpha + IncreasedImgAlpha
                    if ImgAlpha > 1 then
                        ImgAlpha = 1
                    elseif ImgAlpha < 0 then 
                        ImgAlpha = 0
                        return false
                    end
                end)
        
                local Img = directx.create_texture(FolderDirs.Img .. img_name)
                local StartedTime = os.clock()
                util.create_tick_handler(function()
                    directx.draw_texture(Img, 0.07, 0.07, 0.5, 0.5, 0.5, 0.5, 0, 1, 1, 1, ImgAlpha)
                    local PassedTime = os.clock() - StartedTime
                    if PassedTime > max_passed_time then
                        IncreasedImgAlpha = -0.01
                    end
                    if ImgAlpha == 0 then
                        return false
                    end
                end)
            end
        end

        function TELEPORT(x, y, z)
            PED.SET_PED_COORDS_KEEP_VEHICLE(players.user_ped(), x, y, z)
        end
        function SET_HEADING(heading)
            ENTITY.SET_ENTITY_HEADING(players.user_ped(), heading)
        end

        function IS_WORKING(is_add_new_line)
            local State = "" -- If global and local variables have been changed due to the GTAO update then
            local Version = tonumber(NETWORK.GET_ONLINE_VERSION())
            if util.is_session_started() then -- Because unable to get local variable in story mode
                if GET_INT_LOCAL("freemode", 3618) ~= util.joaat("lr_prop_carkey_fob") then -- freemode.c, joaat("lr_prop_carkey_fob")
                    State = TRANSLATE("[NOT WORKING]") .. "\n" .. TRANSLATE("- This feature isn't working due to the latest GTA Online patch:") .. " " .. Version .. ", " .. TRANSLATE("Please download the lastest version of Heist Control or wait for Heist Control's developer patching.")
                    if is_add_new_line then
                        State = State .. "\n\n"
                    end
                end
            end
            return State
        end

        function HEX_TO_RGBA(type, hex) -- https://gist.github.com/jasonbradley/4357406
            local Color = {}
            if type == "Game" then
                Color.r = tonumber("0x" .. string.sub(hex, 1, 2))
                Color.g = tonumber("0x" .. string.sub(hex, 3, 4))
                Color.b = tonumber("0x" .. string.sub(hex, 5, 6))
                Color.a = tonumber("0x" .. string.sub(hex, 7, 8))
            elseif type == "Stand" then
                Color.r = tonumber("0x" .. string.sub(hex, 1, 2)) / 255
                Color.g = tonumber("0x" .. string.sub(hex, 3, 4)) / 255
                Color.b = tonumber("0x" .. string.sub(hex, 5, 6)) / 255
                Color.a = tonumber("0x" .. string.sub(hex, 7, 8)) / 255
            end
            return Color
        end

        function GET_ACTIVE_PROFILE()
            local Dir = filesystem.stand_dir() .. "Meta State.txt"
            for type, value in pairs(util.read_colons_and_tabs_file(Dir)) do
                if type == "Active Profile" then
                    return value
                end
            end
            return "Main"
        end
        function GET_STAND_STATE(config_name)
            local Dir = filesystem.stand_dir() .. "Profiles\\" .. GET_ACTIVE_PROFILE() .. ".txt"
            for type, value in pairs(util.read_colons_and_tabs_file(Dir)) do
                if string.contains(type, config_name) then
                    return value
                end
            end
            return "FF1493FF" -- https://www.rapidtables.com/web/color/pink-color.html, Hot Pink
        end

        function GET_CURSOR_POSITION()
            local Text = menu.get_active_list_cursor_text(true, true) -- '2/12' format
            local i = string.find(Text, "/")
            return tonumber(string.sub(Text, 0, i - 1)) -- return '2'
        end

        function IS_HELP_MSG_DISPLAYED(label) -- Credit goes to jerry123#4508
            HUD.BEGIN_TEXT_COMMAND_IS_THIS_HELP_MESSAGE_BEING_DISPLAYED(label)
            return HUD.END_TEXT_COMMAND_IS_THIS_HELP_MESSAGE_BEING_DISPLAYED(0)
        end

        function DELETE_OBJECT_BY_HASH(hash)
            for _, ent in pairs(entities.get_all_objects_as_handles()) do
                if ENTITY.GET_ENTITY_MODEL(ent) == hash then
                    entities.delete_by_handle(ent)
                end
            end
        end

        function IS_PLAYER_PED(ped)
            if PED.GET_PED_TYPE(ped) < 4 then
                return true
            else
                return false
            end
        end

        function IS_IN_ARCADE()
            local PlayerPos = players.get_position(players.user())
            local Interior = INTERIOR.GET_INTERIOR_AT_COORDS(PlayerPos.x, PlayerPos.y, PlayerPos.z)
            if Interior == 278273 or Interior == 278529 then
                return true
            else
                return false
            end
        end

        function FORCE_CLOUD_SAVE()
            STATS.STAT_SAVE(0, 0, 3, 0) -- Same as menu.trigger_commands("forcecloudsave"), https://github.com/jonaaa20/RecoverySuite
            repeat util.yield_once() until HUD.BUSYSPINNER_IS_ON()
            util.arspinner_enable()
            repeat util.yield_once() until not HUD.BUSYSPINNER_IS_ON()
            util.arspinner_disable()
        end

        function START_SCRIPT(ceo_mc, name)
            if HUD.IS_PAUSE_MENU_ACTIVE() then
                NOTIFY(TRANSLATE("Please close your opened pause menu to open any apps remotely."))
                return
            end
            if players.get_boss(players.user()) ~= -1 then
                if players.get_org_type(players.user()) == 0 then -- NOTE: https://www.unknowncheats.me/forum/3683018-post106.html
                    if ceo_mc == "MC" then
                        menu.trigger_commands("ceotomc")
                        NOTIFY(TRANSLATE("Seems like you need to be a MC President. So, Heist Control made you become MC President."))
                    end
                else
                    if ceo_mc == "CEO" then
                        menu.trigger_commands("ceotomc")
                        NOTIFY(TRANSLATE("Seems like you need to be a CEO. So, Heist Control made you become CEO."))
                    end
                end
            else
                if ceo_mc == "CEO" then
                    menu.trigger_commands("ceostart")
                    NOTIFY(TRANSLATE("Seems like you need to be a CEO. So, Heist Control made you become CEO."))
                elseif ceo_mc == "MC" then
                    menu.trigger_commands("mcstart")
                    NOTIFY(TRANSLATE("Seems like you need to be a MC President. So, Heist Control made you become MC President."))
                end
            end

            SCRIPT.REQUEST_SCRIPT(name)
            repeat util.yield_once() until SCRIPT.HAS_SCRIPT_LOADED(name)
            SYSTEM.START_NEW_SCRIPT(name, 5000)
            SCRIPT.SET_SCRIPT_AS_NO_LONGER_NEEDED(name)
        end

        function CLICK_KEYBOARD(key, num) -- https://docs.fivem.net/docs/game-references/controls/
            for i = 1, num do
                PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, key, 1)
                util.yield(200)
            end
        end

        function IA_MENU_OPEN_OR_CLOSE()
            CLICK_KEYBOARD(244, 1)
        end
        function IA_MENU_UP(num)
            CLICK_KEYBOARD(172, num)
        end
        function IA_MENU_DOWN(num)
            CLICK_KEYBOARD(173, num)
        end
        function IA_MENU_ENTER(num)
            CLICK_KEYBOARD(176, num)
        end

        function CP_PRESS_ARROW_DOWN(num)
            CLICK_KEYBOARD(187, num)
        end
        function CP_PRESS_ARROW_UP(num)
            CLICK_KEYBOARD(188, num)
        end
        function CP_PRESS_ENTER(num)
            CLICK_KEYBOARD(201, num)
        end
        function CP_PRESS_BACKSPACE(num)
            CLICK_KEYBOARD(202, num)
        end
        function CP_PRESS_E(num)
            CLICK_KEYBOARD(206, num)
        end
        function CP_PRESS_D(num)
            CLICK_KEYBOARD(218, num)
        end

    ---

    --- Notification Settings

        if filesystem.exists(FolderDirs.Img .. "Logo.ytd") then
            util.register_file(FolderDirs.Img .. "Logo.ytd")
        else
            if READ_SETTING("Notification Type") == "In-Game" and READ_SETTING("Notification Icon") == "HC Logo" then
                ERROR_LOG(TRANSLATE("HC Logo image file doesn't exist.") .. "\n\n" .. TRANSLATE("Please re-enable 'Stand > Lua Scripts > Repository > Heist Control' to fix!"))
            end
        end

        function NOTIFY(Message)
            local Icon = READ_SETTING("Notification Icon Code")
            local Color = READ_SETTING("Notification Color Code")

            LOG(Message)

            if READ_SETTING("Notification Type") == "Stand" then
                util.toast(TRANSLATE("Heist Control") .. " | " .. TRANSLATE("Notification") .. "\n\n" .. Message)
            elseif READ_SETTING("Notification Type") == "In-Game" then
                if util.is_session_started() then -- Credit goes to WiriScript
                    GRAPHICS.REQUEST_STREAMED_TEXTURE_DICT(Icon, 1)
                    repeat util.yield_once() until GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED(Icon)
                    util.BEGIN_TEXT_COMMAND_THEFEED_POST(Message)
                    HUD.THEFEED_SET_BACKGROUND_COLOR_FOR_NEXT_POST(Color)
                    HUD.END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT(Icon, Icon, true, 1, TRANSLATE("Heist Control"), "~c~" .. TRANSLATE("Notification"))
                    HUD.END_TEXT_COMMAND_THEFEED_POST_TICKER(true, false)
                else
                    util.toast(TRANSLATE("Heist Control") .. " | " .. TRANSLATE("Notification") .. " - SP" .. "\n\n" .. Message)
                end
            elseif READ_SETTING("Notification Type") == "No Notification" then
                -- Nothing Does
            else
                WRITE_SETTING("Notification Type", "Stand")
                util.toast(TRANSLATE("Heist Control") .. " | " .. TRANSLATE("Notification") .. "\n\n" .. Message)
            end
        end

    ---

    --- General Settings

        util.keep_running()

        util.on_stop(function()
            HUD.UNLOCK_MINIMAP_POSITION()
        end)

        INT_MIN = -2147483648
        INT_MAX = 2147483647

        SubBlip, SubControlBlip = 0, 0
        util.create_tick_handler(function()
            SubBlip = HUD.GET_FIRST_BLIP_INFO_ID(760)
            SubControlBlip = HUD.GET_FIRST_BLIP_INFO_ID(773)
        end)

        menu.trigger_commands("noidlekick on")
        menu.trigger_commands("nodeathbarriers on")
        menu.trigger_commands("nocasinoregionlock on")

        if READ_SETTING("Timer Color") == "Stand" then
            WRITE_SETTING("Timer Color Code", GET_STAND_STATE("AR Colour"))
        end

        FULL_STAND_VERSION = menu.get_version().version_target
        CURRENT_STAND_VERSION = tonumber(string.format("%.3f", FULL_STAND_VERSION))
        if not string.contains(FULL_STAND_VERSION, "preview") then
            if CURRENT_STAND_VERSION < SUPPORTED_STAND_VERSION then
                ERROR_LOG
                (
                    TRANSLATE("Your current Stand version isn't compatible with current Heist Control version. Please update Stand to use it.") .. "\n\n" ..
                    TRANSLATE("- Current your Heist Control version:") .. " " .. HC_VERSION .. "\n" .. 
                    TRANSLATE("- At least required Stand version:") .. " " .. SUPPORTED_STAND_VERSION .. "\n" ..
                    TRANSLATE("- Current your Stand version:") .. " " .. CURRENT_STAND_VERSION
                )
            end
        end

            local LatestGTAO = tonumber(NETWORK.GET_ONLINE_VERSION())
            if CODED_GTAO_VERSION ~= LatestGTAO then
                local State = TRANSLATE("But, all features of HC should work!")
                if IS_WORKING(false) ~= "" then
                    State = TRANSLATE("Except [NOT WORKING] features should work!")
                end

                NOTIFY
                (
                    TRANSLATE("Coded GTA Online Version:") .. " " .. CODED_GTAO_VERSION .. "\n" .. 
                    TRANSLATE("Current GTA Online Version:") .. " " .. LatestGTAO .. "\n\n" .. 
                    State
                )
            end

    ---

---


--- Main Lists

    menu.divider(Heist_Control, ("任务功能"),{}, "")

        local makemoneyfast = menu.list(Heist_Control, "快速任务", {}, "此选项可帮助您快速完成各种高收益的抢劫任务")
        local autocayosolo = menu.list(makemoneyfast, "半自动单人上岛", {}, "请按顺序依次进行点击\n注:请慢慢完成,不要心急喔~")
        local autocayomult = menu.list(makemoneyfast, "半自动多人上岛", {}, "请按顺序依次进行点击\n注:请慢慢完成,不要心急喔~")
        local autocasinoheist = menu.list(makemoneyfast, "半自动多人赌场", {}, "请按顺序依次进行点击\n注:请慢慢完成,不要心急喔~")
        local autodommsheist = menu.list(makemoneyfast, "半自动多人末日", {}, "请按顺序依次进行点击\n注:请慢慢完成,不要心急喔~") 
        local auto_cayo_bot = menu.list(makemoneyfast, "全自动上岛机器人", {}, "一键勾选即可全自动完成小岛抢劫") 
        PERICO_HEIST = menu.list(Heist_Control, TRANSLATE("Cayo Perico Heist"), {"hccp"}, "#结算任务上限为255万\n#若超过上限会不到账喔(队友同理)\n#以下内容若麻烦推荐使用[自动预设]\n\n公式: (抢劫金额) 乘 (分红百分比) 减 (帕维尔的30万) = 255万\n举例:如果您选择50%的分红收入,您的抢劫金额最大收益上限应为560万左右,建议使用高级功能修改背包容量\n\n[丢丢小课堂]", function();  end)
        CASINO_HEIST = menu.list(Heist_Control, TRANSLATE("Diamond Casino Heist"), {"hccah"}, "#结算任务上限为360万\n#若超过上限会不到账喔(队友同理)\n#以下内容若麻烦推荐使用[自动预设]\n#注意:困难模式下,如果您选择100%的分红,最终会得到290万左右的金额\n#切记:请自行叠加分红百分比,若超过上限360万将得到0收入!!!\n\n[丢丢小课堂]", function(); end)
        DOOMS_HEIST = menu.list(Heist_Control, TRANSLATE("Doomsday Heist"), {"hcdooms"}, "#结算任务上限为255万\n#若超过上限会不到账喔(队友同理)\n#以下内容若麻烦推荐使用[自动预设]\n\n#注意:如果您选择100%的分红\n末日一到账金额: 120万左右\n末日二到账金额: 180万左右\n末日三到账金额: 230万左右\n[以上皆为困难模式]\n#切记:请自行叠加分红百分比,若超过上限255万将得到0收入!!!\n\n[丢丢小课堂]", function(); end)
        CLASSIC_HEISTS = menu.list(Heist_Control, TRANSLATE("Classic Heist"), {"hcclassic"}, "#全福银行抢劫结算金额为1500万\n#您必须是房主并且仅允许您个人得到1500万!!!", function(); end)
        LS_ROBBERY = menu.list(Heist_Control, TRANSLATE("LS Tuners Robbery"), {"hcls"}, "", function(); end)
        ULP_MISSIONS = menu.list(Heist_Control, TRANSLATE("ULP Missions"), {"hculp"}, "", function(); end)
        TH_CONTRACT = menu.list(Heist_Control, TRANSLATE("The Contract: Agency"), {"hcagc"}, "", function(); end)
        MASTER_UNLOCKR = menu.list(Heist_Control, TRANSLATE("Master Unlocker"), {"hcmu"}, "解锁游戏内容/DLCs/彩蛋/奖品等..", function(); end)
        TOOLS = menu.list(Heist_Control, TRANSLATE("Tools"), {"hctool"}, "#实用选项(任务)\n包含自动赚钱/快速完成/管理选项等..", function(); end)
        INFOS = menu.list(Heist_Control, TRANSLATE("Settings And About HC"), {"hcinfo"}, "", function(); end)

        menu.action(autocayosolo, "完成所有前置任务", {}, "", function()
            STAT_SET_INT("H4_MISSIONS", -1)
            STAT_SET_INT("H4CNF_APPROACH", -1)
            STAT_SET_INT("H4CNF_TARGET", 5)
            STAT_SET_INT("H4CNF_BS_ENTR", 63)
            STAT_SET_INT("H4CNF_BS_GEN", 63)
            util.toast("完成佩岛抢劫前置任务")
        end)
        
        menu.action(autocayosolo, "呼叫潜艇", {"callkoh"}, "", function()
            SET_INT_GLOBAL(2793044 + 954, 1)
            util.toast("呼叫中")
        ;  end)
        
        menu.action(autocayosolo, "传送到任务面板 [先呼叫潜艇]", {"tpkokathb"}, "", function()
            if STAT_GET_INT("IH_SUB_OWNED") == 0 then
            else
                TELEPORT(1561.2369, 385.8771, -49.689915)
                SET_HEADING(175)
                STAT_SET_INT("H4_PROGRESS", 131055)
            end
        ;  end)
        
        menu.action(autocayosolo, "全员135%分红", {"setallcut135"}, "", function()
            SET_INT_GLOBAL(1978495 + 823 + 56 + 1, 135)
            SET_INT_GLOBAL(1978495 + 823 + 56 + 2, 135)
            SET_INT_GLOBAL(1978495 + 823 + 56 + 3, 135)
            SET_INT_GLOBAL(1978495 + 823 + 56 + 4, 135)
            STAT_SET_INT("H4_PLAYTHROUGH_STATUS", 5)
        ;  end)
        
        menu.action(autocayosolo, "一键结束动画", {}, "仅限单人上岛使用", function()
            menu.trigger_commands("skipcutscene")
        ;  end)
        
        menu.action(autocayosolo, "一键完成任务", {}, "", function()
            menu.trigger_commands("scripthost")
            SET_INT_LOCAL("fm_mission_controller_2020", 42279 + 1, 51338752)
            SET_INT_LOCAL("fm_mission_controller_2020", 42279 + 1375 + 1, 50)
        ;  end)
        
        
        ---
        
        menu.action(autocayomult, "完成所有前置任务", {}, "", function()
            STAT_SET_INT("H4_MISSIONS", -1)
            STAT_SET_INT("H4CNF_APPROACH", -1)
            STAT_SET_INT("H4CNF_TARGET", 5)
            STAT_SET_INT("H4CNF_BS_ENTR", 63)
            STAT_SET_INT("H4CNF_BS_GEN", 63)
            util.toast("完成佩岛抢劫前置任务")
        end)
        
        menu.action(autocayomult, "呼叫潜艇", {"callkoh"}, "", function()
            SET_INT_GLOBAL(2793044 + 954, 1)
            util.toast("呼叫中")
        ;  end)
        
        menu.action(autocayomult, "传送到任务面板 [先呼叫潜艇]", {"tpkokathb"}, "", function()
            if STAT_GET_INT("IH_SUB_OWNED") == 0 then
            else
                TELEPORT(1561.2369, 385.8771, -49.689915)
                SET_HEADING(175)
                STAT_SET_INT("H4_PROGRESS", 131055)
            end
        ;  end)
        
        menu.action(autocayomult, "全员135%分红", {"setallcut135"}, "", function()
            SET_INT_GLOBAL(1978495 + 823 + 56 + 1, 135)
            SET_INT_GLOBAL(1978495 + 823 + 56 + 2, 135)
            SET_INT_GLOBAL(1978495 + 823 + 56 + 3, 135)
            SET_INT_GLOBAL(1978495 + 823 + 56 + 4, 135)
            STAT_SET_INT("H4_PLAYTHROUGH_STATUS", 5)
        ;  end)
        
        menu.action(autocayomult, "[频繁上岛保护]全员135%分红 你0%", {}, "", function()
            SET_INT_GLOBAL(1978495 + 823 + 56 + 1, 0)
            SET_INT_GLOBAL(1978495 + 823 + 56 + 2, 135)
            SET_INT_GLOBAL(1978495 + 823 + 56 + 3, 135)
            SET_INT_GLOBAL(1978495 + 823 + 56 + 4, 135)
            STAT_SET_INT("H4_PLAYTHROUGH_STATUS", 5)
        ;  end)
        
        menu.action(autocayomult, "一键完成任务", {""}, "必须为房主", function()
                menu.trigger_command(finishcayo)
            end)
        
        menu.action(autocayomult, "杀死队友", {}, "", function()
            menu.trigger_commands("explodeall")
        ;  end)
        
        menu.action(autocayomult, "传送到大门", {}, "", function()
            TELEPORT(4974.189, -5703.279, 19.898539)
        ;  end)
        
        menu.action(autocayomult, "传送到主要目标", {}, "", function()
            TELEPORT(5006.7, -5756.2, 14.8)
            SET_HEADING(145)
        ;  end)
        
        menu.action(autocayomult, "快速切开玻璃", {}, IS_WORKING(false), function()
            SET_FLOAT_LOCAL("fm_mission_controller_2020", 27985 + 3, 100)
        end, function()
            SET_FLOAT_LOCAL("fm_mission_controller_2020", 27985 + 3, 0)
        end)
        
        menu.action(autocayomult, "传送到出口", {}, "", function()
            TELEPORT(4990.0386, -5717.6895, 19.880217)
            SET_HEADING(50)
        ;  end)
        
        menu.action(autocayomult, "传送到大海", {}, "", function()
            TELEPORT(4771.479, -6165.737, -39.079613)
        ;  end)
        
        
        menu.divider(autocasinoheist, "只有气势汹汹可以一键完成任务")
        
        menu.action(autocasinoheist, TRANSLATE("游戏厅车库门口"), {}, "", function()
            TELEPORT(-619.987, 282.960, 81.639)
        end)
        
        menu.toggle(autocasinoheist, "气势汹汹", { "hccahdiaagg" }, IS_WORKING(true) .. TRANSLATE("选择低级买家!请保持开启直至完成")
            , function(Toggle)
                DiamondRD = Toggle

                if DiamondRD then
                    STAT_SET_INT("H3_COMPLETEDPOSIX", -1)
                    STAT_SET_INT("H3OPT_MASKS", 4)
                    STAT_SET_INT("H3OPT_WEAPS", 1)
                    STAT_SET_INT("H3OPT_VEHS", 3)
                    STAT_SET_INT("CAS_HEIST_FLOW", -1)
                    STAT_SET_INT("H3_LAST_APPROACH", 0)
                    STAT_SET_INT("H3OPT_APPROACH", 3)
                    STAT_SET_INT("H3_HARD_APPROACH", 0)
                    STAT_SET_INT("H3OPT_TARGET", 3)
                    STAT_SET_INT("H3OPT_POI", 1023)
                    STAT_SET_INT("H3OPT_ACCESSPOINTS", 2047)
                    STAT_SET_INT("H3OPT_CREWWEAP", 4)
                    STAT_SET_INT("H3OPT_CREWDRIVER", 3)
                    STAT_SET_INT("H3OPT_CREWHACKER", 4)
                    STAT_SET_INT("H3OPT_DISRUPTSHIP", 3)
                    STAT_SET_INT("H3OPT_BODYARMORLVL", -1)
                    STAT_SET_INT("H3OPT_KEYLEVELS", 2)
                    STAT_SET_INT("H3OPT_BITSET1", 799)
                    STAT_SET_INT("H3OPT_BITSET0", 3670102)
                end

                if not DiamondRD then
                    menu.set_value(CAH_1P_CUT, 100)
                    menu.set_value(CAH_1P_CUT_LOOP, false)
                    menu.set_value(CAH_2P_CUT, 100)
                    menu.set_value(CAH_2P_CUT_LOOP, false)
                    menu.set_value(CAH_3P_CUT, 100)
                    menu.set_value(CAH_3P_CUT_LOOP, false)
                    menu.set_value(CAH_4P_CUT, 100)
                    menu.set_value(CAH_4P_CUT_LOOP, false)
                end

                while DiamondRD do
                    SET_INT_GLOBAL(262145 + 28808, 1410065408)
                    menu.set_value(CAH_1P_CUT, 60)
                    menu.set_value(CAH_1P_CUT_LOOP, true)
                    menu.set_value(CAH_2P_CUT, 147)
                    menu.set_value(CAH_2P_CUT_LOOP, true)
                    menu.set_value(CAH_3P_CUT, 147)
                    menu.set_value(CAH_3P_CUT_LOOP, true)
                    menu.set_value(CAH_4P_CUT, 147)
                    menu.set_value(CAH_4P_CUT_LOOP, true)
                    util.yield()
                end
            end)

        
        menu.action(autocasinoheist, "一键完成任务", { "" }, "必须为房主", function()
            menu.trigger_command(finishcasino)
        end)
        
        menu.action(autocasinoheist, TRANSLATE("游戏厅车库门口"), {}, "", function()
            TELEPORT(-619.987, 282.960, 81.639)
        end)
        
        menu.toggle(autocasinoheist, TRANSLATE("兵不厌诈"), { "hccahgoldbig" }, IS_WORKING(true) .. TRANSLATE("选择低级买家!请保持开启直至完成")
            , function(Toggle)
                GoldND = Toggle

                if GoldND then
                    STAT_SET_INT("H3_COMPLETEDPOSIX", -1)
                    STAT_SET_INT("H3OPT_MASKS", 9)
                    STAT_SET_INT("H3OPT_WEAPS", 1)
                    STAT_SET_INT("H3OPT_VEHS", 3)
                    STAT_SET_INT("CAS_HEIST_FLOW", -1)
                    STAT_SET_INT("H3_LAST_APPROACH", 0)
                    STAT_SET_INT("H3OPT_APPROACH", 2)
                    STAT_SET_INT("H3_HARD_APPROACH", 0)
                    STAT_SET_INT("H3OPT_TARGET", 1)
                    STAT_SET_INT("H3OPT_POI", 1023)
                    STAT_SET_INT("H3OPT_ACCESSPOINTS", 2047)
                    STAT_SET_INT("H3OPT_CREWWEAP", 4)
                    STAT_SET_INT("H3OPT_CREWDRIVER", 3)
                    STAT_SET_INT("H3OPT_CREWHACKER", 4)
                    STAT_SET_INT("H3OPT_DISRUPTSHIP", 3)
                    STAT_SET_INT("H3OPT_BODYARMORLVL", -1)
                    STAT_SET_INT("H3OPT_KEYLEVELS", 2)
                    STAT_SET_INT("H3OPT_BITSET1", 159)
                    STAT_SET_INT("H3OPT_BITSET0", 524118)
                end

                if not GoldND then
                    menu.set_value(CAH_1P_CUT, 100)
                    menu.set_value(CAH_1P_CUT_LOOP, false)
                    menu.set_value(CAH_2P_CUT, 100)
                    menu.set_value(CAH_2P_CUT_LOOP, false)
                    menu.set_value(CAH_3P_CUT, 100)
                    menu.set_value(CAH_3P_CUT_LOOP, false)
                    menu.set_value(CAH_4P_CUT, 100)
                    menu.set_value(CAH_4P_CUT_LOOP, false)
                end

                while GoldND do
                    SET_INT_GLOBAL(262145 + 28807, 1410065408)
                    menu.set_value(CAH_1P_CUT, 60)
                    menu.set_value(CAH_1P_CUT_LOOP, true)
                    menu.set_value(CAH_2P_CUT, 177)
                    menu.set_value(CAH_2P_CUT_LOOP, true)
                    menu.set_value(CAH_3P_CUT, 177)
                    menu.set_value(CAH_3P_CUT_LOOP, true)
                    menu.set_value(CAH_4P_CUT, 177)
                    menu.set_value(CAH_4P_CUT_LOOP, true)

                    util.yield()
                end
        end)
        
        menu.action(autocasinoheist, TRANSLATE("隧道闸门位"), {}, "", function()
            TELEPORT(1001.569, -56.16984, 74.268)
        end)
        
        menu.action(autocasinoheist, TRANSLATE("双门禁处"), {}, "", function()
            TELEPORT(2465.4746, -279.2276, -70.694145)
        end)
        menu.action(autocasinoheist, TRANSLATE("金库内部"), {}, "", function()
            TELEPORT(2515.1252, -238.91661, -70.73713)
        end)
        
        
        menu.action(autodommsheist, TRANSLATE("设施入口"), {}, "", function()
            TELEPORT(1862.54, 265.867, 163.594)
        end)
        
        menu.action(autodommsheist, "设施里的抢劫屏幕", {}, "只能在设施里面进行传送.", function()
            TELEPORT(350.69284, 4872.308, -60.794243)
            SET_HEADING(-50)
        end)
        
        menu.list_action(autodommsheist, TRANSLATE("完成前置任务") .. " " .. TRANSLATE("[最终抢劫]"), { "hcdoomspreset" }, "",
            {
                { TRANSLATE("数据泄露 ACT I"), { "1st" } },
                { TRANSLATE("波格丹危机 ACT II"), { "2nd" } },
                { TRANSLATE("末日将至 ACT III"), { "3rd" } },
            }, function(Index)
            if Index == 1 then
                STAT_SET_INT("GANGOPS_FLOW_MISSION_PROG", 503)
                STAT_SET_INT("GANGOPS_HEIST_STATUS", -229383)
                STAT_SET_INT("GANGOPS_FLOW_NotifyS", 1557)
            elseif Index == 2 then
                STAT_SET_INT("GANGOPS_FLOW_MISSION_PROG", 240)
                STAT_SET_INT("GANGOPS_HEIST_STATUS", -229378)
                STAT_SET_INT("GANGOPS_FLOW_NotifyS", 1557)
            elseif Index == 3 then
                STAT_SET_INT("GANGOPS_FLOW_MISSION_PROG", 16368)
                STAT_SET_INT("GANGOPS_HEIST_STATUS", -229380)
                STAT_SET_INT("GANGOPS_FLOW_NotifyS", 1557)
            end
        end)
        
        menu.action(autodommsheist, "一键完成任务", { "hcinsfindooms" }, "必须为房主", function()
            menu.trigger_command(finishact)
        end)
    

        menu.divider(auto_cayo_bot, TRANSLATE("Cooldown Time (Seconds)"))

        COOLDOWN_CAYO_BOT = menu.slider(auto_cayo_bot, TRANSLATE("Auto Cayo Bot"), {""}, "", 1200, 86400, 1200, 60, function(); end)



        menu.divider(auto_cayo_bot, TRANSLATE("Settings"))

        NumberOfPlayingCP = 100
        menu.slider(auto_cayo_bot, TRANSLATE("循环时间"), {""}, "设定何时再次进行自动辅助上岛", 1, 100, 100, 1, function(Value)
            NumberOfPlayingCP = Value
        end)

            
            function CP_PRESS_D(Num)
                for i = 1, Num do
                    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 218, 1) 
                    util.yield(120)
                end
            end
            function CP_PRESS_E(Num)
                for i = 1, Num do
                    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 206, 1) 
                    util.yield(120)
                end
            end
            function CP_PRESS_ENTER(Num)
                for i = 1, Num do
                    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 201, 1) 
                    util.yield(120)
                end
            end
            function CP_PRESS_ARROW_UP(Num)
                for i = 1, Num do
                    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 188, 1) 
                    util.yield(120)
                end
            end
            function CP_PRESS_ARROW_DOWN(Num)
                for i = 1, Num do
                    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 187, 1) 
                    util.yield(120)
                end
            end
            function CP_PRESS_BACKSPACE(Num)
                for i = 1, Num do
                    PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 202, 1) 
                    util.yield(120)
                end
            end

        ---

       menu.divider(auto_cayo_bot, "确保你的生成位置是佩岛,可以按m查看")

        local NumberOfPlayedCP = 0
        AUTO_CAYO_BOT = menu.toggle_loop(auto_cayo_bot, TRANSLATE("Auto Cayo Bot"), {}, IS_WORKING(true) .. TRANSLATE("-单次收益:200万$以上\n\n-请不要按任何键,防止出现游戏错误\n-Heist-Control将以每20分钟/次自动完成单人小岛抢劫"), function()

            if NumberOfPlayingCP >= NumberOfPlayedCP then
                if not util.is_interaction_menu_open() then
                    IA_MENU_OPEN_OR_CLOSE()
                end

                
                util.yield()
                IA_MENU_OPEN_OR_CLOSE()

                if players.get_boss(players.user()) == -1 then
                    menu.trigger_commands("ceostart")
                end
                while players.get_boss(players.user()) == -1 do
                    util.yield()
                end
                util.yield(1000)
            
                IsForCayoBot = true
                menu.trigger_commands("hctimercp off")
                menu.trigger_commands("hctimercustom off")
                menu.trigger_commands("hccpquick on")
            
                local SubBlip, SubControlBlip
                util.create_tick_handler(function()
                    SubBlip = HUD.GET_FIRST_BLIP_INFO_ID(760)
                    SubControlBlip = HUD.GET_FIRST_BLIP_INFO_ID(773)
                end)
                if SubBlip == 0 and SubControlBlip == 0 then
                    NOTIFY("已请求 Kosatka。 等待几秒钟。")
                    menu.trigger_commands("hcreqkosatka")
                    while SubBlip == 0 do
                        util.yield()
                    end
                    util.yield(2000)
                end
                menu.trigger_commands("hctpsub")
                while SubControlBlip == 0 do
                    util.yield()
                end

                SET_INT_LOCAL("heist_island_planning", 1525, 2)
                util.yield(1000)
            
                while GET_INT_GLOBAL(2646729 + 1869) ~= 1 do 
                    util.yield()
                end
                util.yield(1000)

                SET_INT_LOCAL("heist_island_planning", 1432, 2) 
                while GET_INT_LOCAL("heist_island_planning", 1432) ~= 4 do 
                    util.yield()
                end
                util.yield(1000)

                CP_PRESS_E(2)
                CP_PRESS_D(1)
                CP_PRESS_ENTER(1)

                while GET_INT_LOCAL("fmmc_launcher", 16034 + 763) ~= 16 do 
                    util.yield()
                end
                util.yield(1000)

                CP_PRESS_ARROW_UP(1)
                CP_PRESS_ENTER(1)
                util.yield(1000)

                CP_PRESS_ARROW_UP(1)
                CP_PRESS_ENTER(2)

                while not HUD.IS_WARNING_MESSAGE_ACTIVE() do
                    util.yield()
                end
                util.yield(1000)
                PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 201, 1) 
                util.yield(8000)
                
                CP_PRESS_ENTER(2)
                CP_PRESS_BACKSPACE(1)
                CP_PRESS_ARROW_DOWN(1)
                CP_PRESS_ENTER(1)
                CP_PRESS_ARROW_UP(1)
                CP_PRESS_ENTER(1)
                CP_PRESS_BACKSPACE(1)
                CP_PRESS_ARROW_DOWN(1)
                CP_PRESS_ENTER(2)
                CP_PRESS_BACKSPACE(1)
                CP_PRESS_ARROW_DOWN(1)
                CP_PRESS_ENTER(2)
                CP_PRESS_BACKSPACE(1)
                CP_PRESS_ARROW_DOWN(1)
                CP_PRESS_ENTER(2)
                CP_PRESS_D(1)
                CP_PRESS_ENTER(1)
                
                while GET_INT_GLOBAL(1835499) ~= 1 do -- Waiting for loading screen, fmmc_launcher.c
                    util.yield()
                end
                util.yield(1000)
            
                CP_PRESS_ENTER(1)
                util.yield(2000)
            
                while GET_INT_LOCAL("fm_mission_controller_2020", 2758) ~= 1 do -- Waiting for loading screen 테스트 필요
                    util.yield()
                end
                util.yield(1000)

                menu.trigger_commands("skipcutscene")
                while CUTSCENE.IS_CUTSCENE_PLAYING() do
                    util.yield()
                end
                util.yield(1000)

                menu.trigger_commands("hcinsfincp")
                util.yield(5000)
            
                menu.trigger_commands("go solopublic")
                menu.trigger_commands("hccpquick off")
                
                while not IS_HELP_MSG_DISPLAYED("QUIT_RS_ALL") do
                    util.yield()
                end
                local Command = menu.ref_by_path("Online>Quick Progress>Bad Sport Status>Relinquish")
                menu.trigger_command(Command)
                menu.trigger_commands("tpmazehelipad")
            
                NumberOfPlayedCP = NumberOfPlayedCP + 1
                NOTIFY(TRANSLATE("进行一次就完成了！ 等待冷却时间...") .. "\n\n" .. TRANSLATE("启用后你玩了多少次： ") .. NumberOfPlayedCP)
                
                menu.trigger_commands("hctimertime " .. menu.get_value(COOLDOWN_CAYO_BOT))
                menu.trigger_commands("hctimercustom on")
                while menu.get_value(TIMER_CUSTOM) do
                    util.yield()
                end
            end
        end, function()
            NumberOfPlayedCP = 0
            IsForCayoBot = false
            menu.trigger_commands("hctimertime 1200")
            menu.trigger_commands("hctimercustom off")
            menu.trigger_commands("hccpquick off")
        end)
    ---


--- Cayo Perico Heist
    
    CAYO_PRESETS = menu.list(PERICO_HEIST, TRANSLATE("Automated Presets"), {}, TRANSLATE("You should enable the preset until the end of the heist!") .. "\n\n" .. TRANSLATE("Enabling one of these presets will complete all of setups, and set as max payout, $2.55 Millions. It will be affected to all of heist players."), function(); end)

        menu.divider(CAYO_PRESETS, TRANSLATE("Recommended"))

            IsForCayoBot = false
            QUICK_PRESET = menu.toggle(CAYO_PRESETS, TRANSLATE("Quick Preset (1 - 4P)"), {"hccpquick"}, IS_WORKING(true) .. TRANSLATE("There is only a primary target, depends on which you selected. All players of the heist session can get the max payout ($2.55M) by only getting it."), function()
                if menu.get_value(QUICK_PRESET) then
                    menu.trigger_commands("hccprefreshboard")

                    for i = 1, #CayoPresetLists do
                        if CayoPresetLists[i][1] == QUICK_PRESET then
                            CayoPresetLists[i][2] = true
                        end
                    end
                    for i = 1, 5 do
                        for j = 1, #ForCayoPresets[i] do
                            menu.set_help_text(ForCayoPresets[i][j][1], TRANSLATE("This feature has been controlled by another feature.") .. "\n" .. "- " .. menu.get_menu_name(CAYO_PRESETS) .. " > " .. menu.get_menu_name(QUICK_PRESET))
                        end
                    end
                else
                    for i = 1, #CayoPresetLists do
                        if CayoPresetLists[i][1] == QUICK_PRESET then
                            CayoPresetLists[i][2] = false
                        end
                    end
                    for i = 1, 5 do
                        for j = 1, #ForCayoPresets[i] do
                            menu.apply_default_state(ForCayoPresets[i][j][1])
                            menu.set_help_text(ForCayoPresets[i][j][1], ForCayoPresets[i][j][2])
                        end
                    end
                end

                while menu.get_value(QUICK_PRESET) do
                    STAT_SET_INT("H4CNF_BS_GEN", 262143)
                    STAT_SET_INT("H4CNF_BS_ENTR", 63)
                    STAT_SET_INT("H4CNF_BS_ABIL", 63)
                    STAT_SET_INT("H4CNF_WEP_DISRP", 3)
                    STAT_SET_INT("H4CNF_ARM_DISRP", 3)
                    STAT_SET_INT("H4CNF_HEL_DISRP", 3)
                    STAT_SET_INT("H4CNF_BOLTCUT", 4424)
                    STAT_SET_INT("H4CNF_UNIFORM", 5256)
                    STAT_SET_INT("H4CNF_GRAPPEL", 5156)
                    STAT_SET_INT("H4CNF_APPROACH", -1)
                    STAT_SET_INT("H4LOOT_CASH_I", 0)
                    STAT_SET_INT("H4LOOT_CASH_C", 0)
                    STAT_SET_INT("H4LOOT_WEED_I", 0)
                    STAT_SET_INT("H4LOOT_WEED_C", 0)
                    STAT_SET_INT("H4LOOT_COKE_I", 0)
                    STAT_SET_INT("H4LOOT_COKE_C", 0)
                    STAT_SET_INT("H4LOOT_GOLD_I", 0)
                    STAT_SET_INT("H4LOOT_GOLD_C", 0)
                    STAT_SET_INT("H4LOOT_PAINT", 0)
                    STAT_SET_INT("H4LOOT_CASH_V", 0)
                    STAT_SET_INT("H4LOOT_COKE_V", 0)
                    STAT_SET_INT("H4LOOT_GOLD_V", 0)
                    STAT_SET_INT("H4LOOT_PAINT_V", 0)
                    STAT_SET_INT("H4LOOT_WEED_V", 0)
                    STAT_SET_INT("H4LOOT_CASH_I_SCOPED", 0)
                    STAT_SET_INT("H4LOOT_CASH_C_SCOPED", 0)
                    STAT_SET_INT("H4LOOT_WEED_I_SCOPED", 0)
                    STAT_SET_INT("H4LOOT_WEED_C_SCOPED", 0)
                    STAT_SET_INT("H4LOOT_COKE_I_SCOPED", 0)
                    STAT_SET_INT("H4LOOT_COKE_C_SCOPED", 0)
                    STAT_SET_INT("H4LOOT_GOLD_I_SCOPED", 0)
                    STAT_SET_INT("H4LOOT_GOLD_C_SCOPED", 0)
                    STAT_SET_INT("H4LOOT_PAINT_SCOPED", 0)
                    STAT_SET_INT("H4CNF_WEAPONS", 1)
                    STAT_SET_INT("H4_MISSIONS", 65283)
                    STAT_SET_INT("H4_PROGRESS", 126823)
                    STAT_SET_INT("H4_PLAYTHROUGH_STATUS", 5)

                    local Value = menu.get_value(QUICK_PRESET_TARGET)
                    local CPTargets = { -- { stat_set_int, set_int_global }
                        { 5, 262145 + 29987 }, -- H4CNF_TARGET, IH_PRIMARY_TARGET_VALUE_SAPPHIRE_PANTHER_STATUE
                        { 4, 262145 + 29986 }, -- H4CNF_TARGET, IH_PRIMARY_TARGET_VALUE_MADRAZO_FILES
                        { 3, 262145 + 29985 }, -- H4CNF_TARGET, IH_PRIMARY_TARGET_VALUE_PINK_DIAMOND
                        { 2, 262145 + 29984 }, -- H4CNF_TARGET, IH_PRIMARY_TARGET_VALUE_BEARER_BONDS
                        { 1, 262145 + 29983 }, -- H4CNF_TARGET, IH_PRIMARY_TARGET_VALUE_PEARL_NECKLACE
                        { 0, 262145 + 29982 }, -- H4CNF_TARGET, IH_PRIMARY_TARGET_VALUE_TEQUILA
                    }
                    STAT_SET_INT("H4CNF_TARGET", CPTargets[Value][1])
                    if IsForCayoBot then
                        SET_INT_GLOBAL(CPTargets[Value][2], 2090000)
                    else
                        SET_INT_GLOBAL(CPTargets[Value][2], 2455000)
                    end
                    
                    menu.set_value(CP_REM_FEE, true)
                    menu.set_value(CP_NON_HOST_CUT, 100)
                    menu.set_value(CP_NON_HOST_CUT_LOOP, false)
                    menu.set_value(CP_HOST_CUT, 100)
                    menu.set_value(CP_HOST_CUT_LOOP, true)
                    menu.set_value(CP_2P_CUT, 145)
                    menu.set_value(CP_2P_CUT_LOOP, true)
                    menu.set_value(CP_3P_CUT, 145)
                    menu.set_value(CP_3P_CUT_LOOP, true)
                    menu.set_value(CP_4P_CUT, 145)
                    menu.set_value(CP_4P_CUT_LOOP, true)

                    util.yield_once()
                end
            end)

            QUICK_PRESET_TARGET = menu.list_select(CAYO_PRESETS, TRANSLATE("Select Primary Target"), {}, "(" .. menu.get_menu_name(QUICK_PRESET) .. ")", {
                { TRANSLATE("Sapphire Panther"), {}, "" },
                { TRANSLATE("Madrazo Files"), {}, "" },
                { TRANSLATE("Pink Diamond"), {}, "" },
                { TRANSLATE("Bearer Bonds"), {}, "" },
                { TRANSLATE("Ruby Necklace"), {}, "" },
                { TRANSLATE("Tequila"), {}, "" },
            }, 1, function(); end)

        ---

        menu.divider(CAYO_PRESETS, TRANSLATE("Automated Presets"))

            AUTOMATED_SOLO = menu.list(CAYO_PRESETS, TRANSLATE("1 Player"), {}, "", function(); end)

                AUTOAMTED_SOLO_SAPPHIRE = menu.toggle(AUTOMATED_SOLO, TRANSLATE("Sapphire Panther"), {"hccp1psp"}, IS_WORKING(false), function()
                    if menu.get_value(AUTOAMTED_SOLO_SAPPHIRE) then
                        STAT_SET_INT("H4CNF_BOLTCUT", -1)
                        STAT_SET_INT("H4CNF_UNIFORM", -1)
                        STAT_SET_INT("H4CNF_GRAPPEL", -1)
                        STAT_SET_INT("H4_MISSIONS", -1)
                        STAT_SET_INT("H4CNF_WEAPONS", 1)
                        STAT_SET_INT("H4CNF_TROJAN", 5)
                        STAT_SET_INT("H4_PLAYTHROUGH_STATUS", 100)
                        STAT_SET_INT("H4CNF_TARGET", 5)
                        STAT_SET_INT("H4LOOT_CASH_I", 5551206)
                        STAT_SET_INT("H4LOOT_CASH_I_SCOPED", 5551206)
                        STAT_SET_INT("H4LOOT_CASH_C", 0)
                        STAT_SET_INT("H4LOOT_CASH_C_SCOPED", 0)
                        STAT_SET_INT("H4LOOT_COKE_I", 4884838)
                        STAT_SET_INT("H4LOOT_COKE_I_SCOPED", 4884838)
                        STAT_SET_INT("H4LOOT_COKE_C", 0)
                        STAT_SET_INT("H4LOOT_COKE_C_SCOPED", 0)
                        STAT_SET_INT("H4LOOT_GOLD_I", 0)
                        STAT_SET_INT("H4LOOT_GOLD_I_SCOPED", 0)
                        STAT_SET_INT("H4LOOT_GOLD_C", 192)
                        STAT_SET_INT("H4LOOT_GOLD_C_SCOPED", 192)
                        STAT_SET_INT("H4LOOT_WEED_I", 0)
                        STAT_SET_INT("H4LOOT_WEED_I_SCOPED", 0)
                        STAT_SET_INT("H4LOOT_WEED_C", 0)
                        STAT_SET_INT("H4LOOT_WEED_C_SCOPED", 0)
                        STAT_SET_INT("H4LOOT_PAINT", 120)
                        STAT_SET_INT("H4LOOT_PAINT_SCOPED", 120)
                        STAT_SET_INT("H4LOOT_CASH_V", 224431)
                        STAT_SET_INT("H4LOOT_COKE_V", 353863)
                        STAT_SET_INT("H4LOOT_GOLD_V", 471817)
                        STAT_SET_INT("H4LOOT_PAINT_V", 353863)
                        STAT_SET_INT("H4LOOT_WEED_V", 0)
                        STAT_SET_INT("H4_PROGRESS", 131055)
                        STAT_SET_INT("H4CNF_BS_GEN", -1)
                        STAT_SET_INT("H4CNF_BS_ENTR", -1)
                        STAT_SET_INT("H4CNF_BS_ABIL", -1)
                        STAT_SET_INT("H4CNF_WEP_DISRP", 3)
                        STAT_SET_INT("H4CNF_ARM_DISRP", 3)
                        STAT_SET_INT("H4CNF_HEL_DISRP", 3)
                        STAT_SET_INT("H4CNF_APPROACH", -1)

                        menu.trigger_commands("hccprefreshboard")

                        for i = 1, #CayoPresetLists do
                            if CayoPresetLists[i][1] == AUTOAMTED_SOLO_SAPPHIRE then
                                CayoPresetLists[i][2] = true
                            end
                        end
                        for i = 1, 3 do
                            for j = 1, #ForCayoPresets[i] do
                                menu.set_help_text(ForCayoPresets[i][j][1], TRANSLATE("This feature has been controlled by another feature.") .. "\n" .. "- " .. menu.get_menu_name(CAYO_PRESETS) .. " > " .. menu.get_menu_name(menu.get_parent(AUTOAMTED_SOLO_SAPPHIRE)) .. " > " .. menu.get_menu_name(AUTOAMTED_SOLO_SAPPHIRE))
                            end
                        end
                    else
                        for i = 1, #CayoPresetLists do
                            if CayoPresetLists[i][1] == AUTOAMTED_SOLO_SAPPHIRE then
                                CayoPresetLists[i][2] = false
                            end
                        end
                        for i = 1, 3 do
                            for j = 1, #ForCayoPresets[i] do
                                menu.apply_default_state(ForCayoPresets[i][j][1])
                                menu.set_help_text(ForCayoPresets[i][j][1], ForCayoPresets[i][j][2])
                            end
                        end
                    end

                    while menu.get_value(AUTOAMTED_SOLO_SAPPHIRE) do
                        menu.set_value(CP_REM_FEE, false)
                        menu.set_value(CP_NON_HOST_CUT, 100)
                        menu.set_value(CP_NON_HOST_CUT_LOOP, false)
                        menu.set_value(CP_HOST_CUT, 100)
                        menu.set_value(CP_HOST_CUT_LOOP, true)

                        util.yield_once()
                    end
                end)

                AUTOMATED_SOLO_RUBY = menu.toggle(AUTOMATED_SOLO, TRANSLATE("Ruby Necklace"), {"hccp1prn"}, IS_WORKING(false), function()
                    if menu.get_value(AUTOMATED_SOLO_RUBY) then
                        STAT_SET_INT("H4CNF_TARGET", 1)
                        STAT_SET_INT("H4LOOT_CASH_I", 9208137)
                        STAT_SET_INT("H4LOOT_CASH_I_SCOPED", 9208137)
                        STAT_SET_INT("H4LOOT_CASH_C", 0)
                        STAT_SET_INT("H4LOOT_CASH_C_SCOPED", 0)
                        STAT_SET_INT("H4LOOT_COKE_I", 1048704)
                        STAT_SET_INT("H4LOOT_COKE_I_SCOPED", 1048704)
                        STAT_SET_INT("H4LOOT_COKE_C", 0)
                        STAT_SET_INT("H4LOOT_COKE_C_SCOPED", 0)
                        STAT_SET_INT("H4LOOT_GOLD_I", 0)
                        STAT_SET_INT("H4LOOT_GOLD_I_SCOPED", 0)
                        STAT_SET_INT("H4LOOT_GOLD_C", 255)
                        STAT_SET_INT("H4LOOT_GOLD_C_SCOPED", 255)
                        STAT_SET_INT("H4LOOT_WEED_I", 4206596)
                        STAT_SET_INT("H4LOOT_WEED_I_SCOPED", 4206596)
                        STAT_SET_INT("H4LOOT_WEED_C", 0)
                        STAT_SET_INT("H4LOOT_WEED_C_SCOPED", 0)
                        STAT_SET_INT("H4LOOT_PAINT", 127)
                        STAT_SET_INT("H4LOOT_PAINT_SCOPED", 127)
                        STAT_SET_INT("H4LOOT_CASH_V", 424431)
                        STAT_SET_INT("H4LOOT_COKE_V", 848863)
                        STAT_SET_INT("H4LOOT_GOLD_V", 1131817)
                        STAT_SET_INT("H4LOOT_PAINT_V", 848863)
                        STAT_SET_INT("H4LOOT_WEED_V", 679090)
                        STAT_SET_INT("H4_PROGRESS", 131055)
                        STAT_SET_INT("H4CNF_BS_GEN", 262143)
                        STAT_SET_INT("H4CNF_BS_ENTR", 63)
                        STAT_SET_INT("H4CNF_BS_ABIL", 63)
                        STAT_SET_INT("H4CNF_WEP_DISRP", 3)
                        STAT_SET_INT("H4CNF_ARM_DISRP", 3)
                        STAT_SET_INT("H4CNF_HEL_DISRP", 3)
                        STAT_SET_INT("H4CNF_APPROACH", -1)
                        STAT_SET_INT("H4CNF_BOLTCUT", 4424)
                        STAT_SET_INT("H4CNF_UNIFORM", 5256)
                        STAT_SET_INT("H4CNF_GRAPPEL", 5156)
                        STAT_SET_INT("H4_MISSIONS", -1)
                        STAT_SET_INT("H4CNF_WEAPONS", 1)
                        STAT_SET_INT("H4CNF_TROJAN", 5)
                        STAT_SET_INT("H4_PLAYTHROUGH_STATUS", 100)

                        menu.trigger_commands("hccprefreshboard")

                        for i = 1, #CayoPresetLists do
                            if CayoPresetLists[i][1] == AUTOMATED_SOLO_RUBY then
                                CayoPresetLists[i][2] = true
                            end
                        end
                        for i = 1, 3 do
                            for j = 1, #ForCayoPresets[i] do
                                menu.set_help_text(ForCayoPresets[i][j][1], TRANSLATE("This feature has been controlled by another feature.") .. "\n" .. "- " .. menu.get_menu_name(CAYO_PRESETS) .. " > " .. menu.get_menu_name(menu.get_parent(AUTOMATED_SOLO_RUBY)) .. " > " .. menu.get_menu_name(AUTOMATED_SOLO_RUBY))
                            end
                        end
                    else
                        for i = 1, #CayoPresetLists do
                            if CayoPresetLists[i][1] == AUTOMATED_SOLO_RUBY then
                                CayoPresetLists[i][2] = false
                            end
                        end
                        for i = 1, 3 do
                            for j = 1, #ForCayoPresets[i] do
                                menu.apply_default_state(ForCayoPresets[i][j][1])
                                menu.set_help_text(ForCayoPresets[i][j][1], ForCayoPresets[i][j][2])
                            end
                        end
                    end

                    while menu.get_value(AUTOMATED_SOLO_RUBY) do
                        menu.set_value(CP_REM_FEE, false)
                        menu.set_value(CP_NON_HOST_CUT, 100)
                        menu.set_value(CP_NON_HOST_CUT_LOOP, false)
                        menu.set_value(CP_HOST_CUT, 100)
                        menu.set_value(CP_HOST_CUT_LOOP, true)

                        util.yield_once()
                    end
                end)

            ---

            AUTOMATED_2P = menu.list(CAYO_PRESETS, TRANSLATE("2 Players"), {}, "", function(); end)

                AUTOAMTED_2P_SAPPHIRE = menu.toggle_loop(AUTOMATED_2P, TRANSLATE("Sapphire Panther"), {"hccp2psp"}, IS_WORKING(false), function()   
                    if menu.get_value(AUTOAMTED_2P_SAPPHIRE) then
                        STAT_SET_INT("H4CNF_BOLTCUT", 4424)
                        STAT_SET_INT("H4CNF_UNIFORM", 5256)
                        STAT_SET_INT("H4CNF_GRAPPEL", 5156)
                        STAT_SET_INT("H4_MISSIONS", -1)
                        STAT_SET_INT("H4CNF_WEAPONS", 1)
                        STAT_SET_INT("H4CNF_TROJAN", 5)
                        STAT_SET_INT("H4_PLAYTHROUGH_STATUS", 100)
                        STAT_SET_INT("H4CNF_TARGET", 5)
                        STAT_SET_INT("H4LOOT_CASH_I", 2359448)
                        STAT_SET_INT("H4LOOT_CASH_I_SCOPED", 2359448)
                        STAT_SET_INT("H4LOOT_CASH_C", 0)
                        STAT_SET_INT("H4LOOT_CASH_C_SCOPED", 0)
                        STAT_SET_INT("H4LOOT_COKE_I", 2)
                        STAT_SET_INT("H4LOOT_COKE_I_SCOPED", 2)
                        STAT_SET_INT("H4LOOT_COKE_C", 0)
                        STAT_SET_INT("H4LOOT_COKE_C_SCOPED", 0)
                        STAT_SET_INT("H4LOOT_GOLD_I", 0)
                        STAT_SET_INT("H4LOOT_GOLD_I_SCOPED", 0)
                        STAT_SET_INT("H4LOOT_GOLD_C", 255)
                        STAT_SET_INT("H4LOOT_GOLD_C_SCOPED", 255)
                        STAT_SET_INT("H4LOOT_WEED_I", 0)
                        STAT_SET_INT("H4LOOT_WEED_I_SCOPED", 0)
                        STAT_SET_INT("H4LOOT_WEED_C", 0)
                        STAT_SET_INT("H4LOOT_WEED_C_SCOPED", 0)
                        STAT_SET_INT("H4LOOT_PAINT", 127)
                        STAT_SET_INT("H4LOOT_PAINT_SCOPED", 127)
                        STAT_SET_INT("H4LOOT_CASH_V", 474431)
                        STAT_SET_INT("H4LOOT_COKE_V", 948863)
                        STAT_SET_INT("H4LOOT_GOLD_V", 1265151)
                        STAT_SET_INT("H4LOOT_PAINT_V", 948863)
                        STAT_SET_INT("H4LOOT_WEED_V", 0)
                        STAT_SET_INT("H4_PROGRESS", 126823)
                        STAT_SET_INT("H4CNF_BS_GEN", 262143)
                        STAT_SET_INT("H4CNF_BS_ENTR", 63)
                        STAT_SET_INT("H4CNF_BS_ABIL", 63)
                        STAT_SET_INT("H4CNF_WEP_DISRP", 3)
                        STAT_SET_INT("H4CNF_ARM_DISRP", 3)
                        STAT_SET_INT("H4CNF_HEL_DISRP", 3)
                        STAT_SET_INT("H4CNF_APPROACH", -1)

                        menu.trigger_commands("hccprefreshboard")

                        for i = 1, #CayoPresetLists do
                            if CayoPresetLists[i][1] == AUTOAMTED_2P_SAPPHIRE then
                                CayoPresetLists[i][2] = true
                            end
                        end
                        for i = 1, 4 do
                            for j = 1, #ForCayoPresets[i] do
                                menu.set_help_text(ForCayoPresets[i][j][1], TRANSLATE("This feature has been controlled by another feature.") .. "\n" .. "- " .. menu.get_menu_name(CAYO_PRESETS) .. " > " .. menu.get_menu_name(menu.get_parent(AUTOAMTED_2P_SAPPHIRE)) .. " > " .. menu.get_menu_name(AUTOAMTED_2P_SAPPHIRE))
                            end
                        end
                    else
                        for i = 1, #CayoPresetLists do
                            if CayoPresetLists[i][1] == AUTOAMTED_2P_SAPPHIRE then
                                CayoPresetLists[i][2] = false
                            end
                        end
                        for i = 1, 4 do
                            for j = 1, #ForCayoPresets[i] do
                                menu.apply_default_state(ForCayoPresets[i][j][1])
                                menu.set_help_text(ForCayoPresets[i][j][1], ForCayoPresets[i][j][2])
                            end
                        end
                    end

                    while menu.get_value(AUTOAMTED_2P_SAPPHIRE) do
                        menu.set_value(CP_REM_FEE, false)
                        menu.set_value(CP_NON_HOST_CUT, 50)
                        menu.set_value(CP_NON_HOST_CUT_LOOP, false)
                        menu.set_value(CP_HOST_CUT, 50)
                        menu.set_value(CP_HOST_CUT_LOOP, true)
                        menu.set_value(CP_2P_CUT, 50)
                        menu.set_value(CP_2P_CUT_LOOP, true)

                        util.yield_once()
                    end
                end)

                AUTOAMTED_2P_RUBY = menu.toggle_loop(AUTOMATED_2P, TRANSLATE("Ruby Necklace"), {"hccp2prn"}, IS_WORKING(false), function()  
                    if menu.get_value(AUTOAMTED_2P_RUBY) then
                        STAT_SET_INT("H4CNF_TARGET", 1)
                        STAT_SET_INT("H4LOOT_CASH_I", 9208137)
                        STAT_SET_INT("H4LOOT_CASH_I_SCOPED", 9208137)
                        STAT_SET_INT("H4LOOT_CASH_C", 0)
                        STAT_SET_INT("H4LOOT_CASH_C_SCOPED", 0)
                        STAT_SET_INT("H4LOOT_COKE_I", 1048704)
                        STAT_SET_INT("H4LOOT_COKE_I_SCOPED", 1048704)
                        STAT_SET_INT("H4LOOT_COKE_C", 0)
                        STAT_SET_INT("H4LOOT_COKE_C_SCOPED", 0)
                        STAT_SET_INT("H4LOOT_GOLD_I", 0)
                        STAT_SET_INT("H4LOOT_GOLD_I_SCOPED", 0)
                        STAT_SET_INT("H4LOOT_GOLD_C", 255)
                        STAT_SET_INT("H4LOOT_GOLD_C_SCOPED", 255)
                        STAT_SET_INT("H4LOOT_WEED_I", 4206596)
                        STAT_SET_INT("H4LOOT_WEED_I_SCOPED", 4206596)
                        STAT_SET_INT("H4LOOT_WEED_C", 0)
                        STAT_SET_INT("H4LOOT_WEED_C_SCOPED", 0)
                        STAT_SET_INT("H4LOOT_PAINT", 127)
                        STAT_SET_INT("H4LOOT_PAINT_SCOPED", 127)
                        STAT_SET_INT("H4LOOT_CASH_V", 572727)
                        STAT_SET_INT("H4LOOT_COKE_V", 1145454)
                        STAT_SET_INT("H4LOOT_GOLD_V", 1527272)
                        STAT_SET_INT("H4LOOT_PAINT_V", 1145454)
                        STAT_SET_INT("H4LOOT_WEED_V", 916363)
                        STAT_SET_INT("H4_PROGRESS", 126823)
                        STAT_SET_INT("H4CNF_BS_GEN", 262143)
                        STAT_SET_INT("H4CNF_BS_ENTR", 63)
                        STAT_SET_INT("H4CNF_BS_ABIL", 63)
                        STAT_SET_INT("H4CNF_WEP_DISRP", 3)
                        STAT_SET_INT("H4CNF_ARM_DISRP", 3)
                        STAT_SET_INT("H4CNF_HEL_DISRP", 3)
                        STAT_SET_INT("H4CNF_APPROACH", -1)
                        STAT_SET_INT("H4CNF_BOLTCUT", 4424)
                        STAT_SET_INT("H4CNF_UNIFORM", 5256)
                        STAT_SET_INT("H4CNF_GRAPPEL", 5156)
                        STAT_SET_INT("H4_MISSIONS", -1)
                        STAT_SET_INT("H4CNF_WEAPONS", 1)
                        STAT_SET_INT("H4CNF_TROJAN", 5)
                        STAT_SET_INT("H4_PLAYTHROUGH_STATUS", 100)

                        menu.trigger_commands("hccprefreshboard")

                        for i = 1, #CayoPresetLists do
                            if CayoPresetLists[i][1] == AUTOAMTED_2P_RUBY then
                                CayoPresetLists[i][2] = true
                            end
                        end
                        for i = 1, 4 do
                            for j = 1, #ForCayoPresets[i] do
                                menu.set_help_text(ForCayoPresets[i][j][1], TRANSLATE("This feature has been controlled by another feature.") .. "\n" .. "- " .. menu.get_menu_name(CAYO_PRESETS) .. " > " .. menu.get_menu_name(menu.get_parent(AUTOAMTED_2P_RUBY)) .. " > " .. menu.get_menu_name(AUTOAMTED_2P_RUBY))
                            end
                        end
                    else
                        for i = 1, #CayoPresetLists do
                            if CayoPresetLists[i][1] == AUTOAMTED_2P_RUBY then
                                CayoPresetLists[i][2] = false
                            end
                        end
                        for i = 1, 4 do
                            for j = 1, #ForCayoPresets[i] do
                                menu.apply_default_state(ForCayoPresets[i][j][1])
                                menu.set_help_text(ForCayoPresets[i][j][1], ForCayoPresets[i][j][2])
                            end
                        end
                    end

                    while menu.get_value(AUTOAMTED_2P_RUBY) do
                        menu.set_value(CP_REM_FEE, false)
                        menu.set_value(CP_NON_HOST_CUT, 50)
                        menu.set_value(CP_NON_HOST_CUT_LOOP, false)
                        menu.set_value(CP_HOST_CUT, 50)
                        menu.set_value(CP_HOST_CUT_LOOP, true)
                        menu.set_value(CP_2P_CUT, 50)
                        menu.set_value(CP_2P_CUT_LOOP, true)

                        util.yield_once()
                    end
                end)

            ---

            AUTOMATED_3P = menu.list(CAYO_PRESETS, TRANSLATE("3 Players"), {}, "", function(); end)

                AUTOAMTED_3P_SAPPHIRE = menu.toggle_loop(AUTOMATED_3P, TRANSLATE("Sapphire Panther"), {"hccp3psp"}, IS_WORKING(false), function()
                    if menu.get_value(AUTOAMTED_3P_SAPPHIRE) then
                        STAT_SET_INT("H4CNF_BOLTCUT", 4424)
                        STAT_SET_INT("H4CNF_UNIFORM", 5256)
                        STAT_SET_INT("H4CNF_GRAPPEL", 5156)
                        STAT_SET_INT("H4_MISSIONS", -1)
                        STAT_SET_INT("H4CNF_WEAPONS", 1)
                        STAT_SET_INT("H4CNF_TROJAN", 5)
                        STAT_SET_INT("H4_PLAYTHROUGH_STATUS", 100)
                        STAT_SET_INT("H4CNF_TARGET", 5)
                        STAT_SET_INT("H4LOOT_CASH_I", 2359448)
                        STAT_SET_INT("H4LOOT_CASH_I_SCOPED", 2359448)
                        STAT_SET_INT("H4LOOT_CASH_C", 0)
                        STAT_SET_INT("H4LOOT_CASH_C_SCOPED", 0)
                        STAT_SET_INT("H4LOOT_COKE_I", 4901222)
                        STAT_SET_INT("H4LOOT_COKE_I_SCOPED", 4901222)
                        STAT_SET_INT("H4LOOT_COKE_C", 0)
                        STAT_SET_INT("H4LOOT_COKE_C_SCOPED", 0)
                        STAT_SET_INT("H4LOOT_GOLD_I", 0)
                        STAT_SET_INT("H4LOOT_GOLD_I_SCOPED", 0)
                        STAT_SET_INT("H4LOOT_GOLD_C", 255)
                        STAT_SET_INT("H4LOOT_GOLD_C_SCOPED", 255)
                        STAT_SET_INT("H4LOOT_WEED_I", 0)
                        STAT_SET_INT("H4LOOT_WEED_I_SCOPED", 0)
                        STAT_SET_INT("H4LOOT_WEED_C", 0)
                        STAT_SET_INT("H4LOOT_WEED_C_SCOPED", 0)
                        STAT_SET_INT("H4LOOT_PAINT", 127)
                        STAT_SET_INT("H4LOOT_PAINT_SCOPED", 127)
                        STAT_SET_INT("H4LOOT_CASH_V", 515151)
                        STAT_SET_INT("H4LOOT_COKE_V", 1030303)
                        STAT_SET_INT("H4LOOT_GOLD_V", 1373737)
                        STAT_SET_INT("H4LOOT_PAINT_V", 1030303)
                        STAT_SET_INT("H4LOOT_WEED_V", 0)
                        STAT_SET_INT("H4_PROGRESS", 126823)
                        STAT_SET_INT("H4CNF_BS_GEN", 262143)
                        STAT_SET_INT("H4CNF_BS_ENTR", 63)
                        STAT_SET_INT("H4CNF_BS_ABIL", 63)
                        STAT_SET_INT("H4CNF_WEP_DISRP", 3)
                        STAT_SET_INT("H4CNF_ARM_DISRP", 3)
                        STAT_SET_INT("H4CNF_HEL_DISRP", 3)
                        STAT_SET_INT("H4CNF_APPROACH", -1)

                        menu.trigger_commands("hccprefreshboard")

                        for i = 1, #CayoPresetLists do
                            if CayoPresetLists[i][1] == AUTOAMTED_3P_SAPPHIRE then
                                CayoPresetLists[i][2] = true
                            end
                        end
                        for i = 1, 5 do
                            for j = 1, #ForCayoPresets[i] do
                                menu.set_help_text(ForCayoPresets[i][j][1], TRANSLATE("This feature has been controlled by another feature.") .. "\n" .. "- " .. menu.get_menu_name(CAYO_PRESETS) .. " > " .. menu.get_menu_name(menu.get_parent(AUTOAMTED_3P_SAPPHIRE)) .. " > " .. menu.get_menu_name(AUTOAMTED_3P_SAPPHIRE))
                            end
                        end
                    else
                        for i = 1, #CayoPresetLists do
                            if CayoPresetLists[i][1] == AUTOAMTED_3P_SAPPHIRE then
                                CayoPresetLists[i][2] = false
                            end
                        end
                        for i = 1, 5 do
                            for j = 1, #ForCayoPresets[i] do
                                menu.apply_default_state(ForCayoPresets[i][j][1])
                                menu.set_help_text(ForCayoPresets[i][j][1], ForCayoPresets[i][j][2])
                            end
                        end
                    end

                    while menu.get_value(AUTOAMTED_3P_SAPPHIRE) do
                        menu.set_value(CP_REM_FEE, false)
                        menu.set_value(CP_NON_HOST_CUT, 30)
                        menu.set_value(CP_NON_HOST_CUT_LOOP, false)
                        menu.set_value(CP_HOST_CUT, 30)
                        menu.set_value(CP_HOST_CUT_LOOP, true)
                        menu.set_value(CP_2P_CUT, 35)
                        menu.set_value(CP_2P_CUT_LOOP, true)
                        menu.set_value(CP_3P_CUT, 35)
                        menu.set_value(CP_3P_CUT_LOOP, true)

                        util.yield_once()
                    end
                end)

                AUTOAMTED_3P_RUBY = menu.toggle_loop(AUTOMATED_3P, TRANSLATE("Ruby Necklace"), {"hccp3prn"}, IS_WORKING(false), function()
                    if menu.get_value(AUTOAMTED_3P_RUBY) then
                        STAT_SET_INT("H4CNF_TARGET", 1)
                        STAT_SET_INT("H4LOOT_CASH_I", 9208137)
                        STAT_SET_INT("H4LOOT_CASH_I_SCOPED", 9208137)
                        STAT_SET_INT("H4LOOT_CASH_C", 0)
                        STAT_SET_INT("H4LOOT_CASH_C_SCOPED", 0)
                        STAT_SET_INT("H4LOOT_COKE_I", 1048704)
                        STAT_SET_INT("H4LOOT_COKE_I_SCOPED", 1048704)
                        STAT_SET_INT("H4LOOT_COKE_C", 0)
                        STAT_SET_INT("H4LOOT_COKE_C_SCOPED", 0)
                        STAT_SET_INT("H4LOOT_GOLD_I", 0)
                        STAT_SET_INT("H4LOOT_GOLD_I_SCOPED", 0)
                        STAT_SET_INT("H4LOOT_GOLD_C", 255)
                        STAT_SET_INT("H4LOOT_GOLD_C_SCOPED", 255)
                        STAT_SET_INT("H4LOOT_WEED_I", 4206596)
                        STAT_SET_INT("H4LOOT_WEED_I_SCOPED", 4206596)
                        STAT_SET_INT("H4LOOT_WEED_C", 0)
                        STAT_SET_INT("H4LOOT_WEED_C_SCOPED", 0)
                        STAT_SET_INT("H4LOOT_PAINT", 127)
                        STAT_SET_INT("H4LOOT_PAINT_SCOPED", 127)
                        STAT_SET_INT("H4LOOT_CASH_V", 598268)
                        STAT_SET_INT("H4LOOT_COKE_V", 1196536)
                        STAT_SET_INT("H4LOOT_GOLD_V", 1595382)
                        STAT_SET_INT("H4LOOT_PAINT_V", 1196536)
                        STAT_SET_INT("H4LOOT_WEED_V", 957229)
                        STAT_SET_INT("H4_PROGRESS", 126823)
                        STAT_SET_INT("H4CNF_BS_GEN", 262143)
                        STAT_SET_INT("H4CNF_BS_ENTR", 63)
                        STAT_SET_INT("H4CNF_BS_ABIL", 63)
                        STAT_SET_INT("H4CNF_WEP_DISRP", 3)
                        STAT_SET_INT("H4CNF_ARM_DISRP", 3)
                        STAT_SET_INT("H4CNF_HEL_DISRP", 3)
                        STAT_SET_INT("H4CNF_APPROACH", -1)
                        STAT_SET_INT("H4CNF_BOLTCUT", 4424)
                        STAT_SET_INT("H4CNF_UNIFORM", 5256)
                        STAT_SET_INT("H4CNF_GRAPPEL", 5156)
                        STAT_SET_INT("H4_MISSIONS", -1)
                        STAT_SET_INT("H4CNF_WEAPONS", 1)
                        STAT_SET_INT("H4CNF_TROJAN", 5)
                        STAT_SET_INT("H4_PLAYTHROUGH_STATUS", 100)

                        menu.trigger_commands("hccprefreshboard")

                        for i = 1, #CayoPresetLists do
                            if CayoPresetLists[i][1] == AUTOAMTED_3P_RUBY then
                                CayoPresetLists[i][2] = true
                            end
                        end
                        for i = 1, 5 do
                            for j = 1, #ForCayoPresets[i] do
                                menu.set_help_text(ForCayoPresets[i][j][1], TRANSLATE("This feature has been controlled by another feature.") .. "\n" .. "- " .. menu.get_menu_name(CAYO_PRESETS) .. " > " .. menu.get_menu_name(menu.get_parent(AUTOAMTED_3P_RUBY)) .. " > " .. menu.get_menu_name(AUTOAMTED_3P_RUBY))
                            end
                        end
                    else
                        for i = 1, #CayoPresetLists do
                            if CayoPresetLists[i][1] == AUTOAMTED_3P_RUBY then
                                CayoPresetLists[i][2] = false
                            end
                        end
                        for i = 1, 5 do
                            for j = 1, #ForCayoPresets[i] do
                                menu.apply_default_state(ForCayoPresets[i][j][1])
                                menu.set_help_text(ForCayoPresets[i][j][1], ForCayoPresets[i][j][2])
                            end
                        end
                    end

                    while menu.get_value(AUTOAMTED_3P_RUBY) do
                        menu.set_value(CP_REM_FEE, false)
                        menu.set_value(CP_NON_HOST_CUT, 30)
                        menu.set_value(CP_NON_HOST_CUT_LOOP, false)
                        menu.set_value(CP_HOST_CUT, 30)
                        menu.set_value(CP_HOST_CUT_LOOP, true)
                        menu.set_value(CP_2P_CUT, 35)
                        menu.set_value(CP_2P_CUT_LOOP, true)
                        menu.set_value(CP_3P_CUT, 35)
                        menu.set_value(CP_3P_CUT_LOOP, true)

                        util.yield_once()
                    end
                end)

            ---

            AUTOMATED_4P = menu.list(CAYO_PRESETS, TRANSLATE("4 Players"), {}, "", function(); end)

                AUTOAMTED_4P_SAPPHIRE = menu.toggle_loop(AUTOMATED_4P, TRANSLATE("Sapphire Panther"), {"hccp4psp"}, IS_WORKING(false), function()
                    if menu.get_value(AUTOAMTED_4P_SAPPHIRE) then
                        STAT_SET_INT("H4CNF_TARGET", 5)
                        STAT_SET_INT("H4LOOT_CASH_I", 2359448)
                        STAT_SET_INT("H4LOOT_CASH_I_SCOPED", 2359448)
                        STAT_SET_INT("H4LOOT_CASH_C", 0)
                        STAT_SET_INT("H4LOOT_CASH_C_SCOPED", 0)
                        STAT_SET_INT("H4LOOT_COKE_I", 4901222)
                        STAT_SET_INT("H4LOOT_COKE_I_SCOPED", 4901222)
                        STAT_SET_INT("H4LOOT_COKE_C", 0)
                        STAT_SET_INT("H4LOOT_COKE_C_SCOPED", 0)
                        STAT_SET_INT("H4LOOT_GOLD_I", 0)
                        STAT_SET_INT("H4LOOT_GOLD_I_SCOPED", 0)
                        STAT_SET_INT("H4LOOT_GOLD_C", 255)
                        STAT_SET_INT("H4LOOT_GOLD_C_SCOPED", 255)
                        STAT_SET_INT("H4LOOT_WEED_I", 0)
                        STAT_SET_INT("H4LOOT_WEED_I_SCOPED", 0)
                        STAT_SET_INT("H4LOOT_WEED_C", 0)
                        STAT_SET_INT("H4LOOT_WEED_C_SCOPED", 0)
                        STAT_SET_INT("H4LOOT_PAINT", 127)
                        STAT_SET_INT("H4LOOT_PAINT_SCOPED", 127)
                        STAT_SET_INT("H4LOOT_CASH_V", 599431)
                        STAT_SET_INT("H4LOOT_COKE_V", 1198863)
                        STAT_SET_INT("H4LOOT_GOLD_V", 1598484)
                        STAT_SET_INT("H4LOOT_PAINT_V", 1198863)
                        STAT_SET_INT("H4LOOT_WEED_V", 0)
                        STAT_SET_INT("H4_PROGRESS", 126823)
                        STAT_SET_INT("H4CNF_BS_GEN", 262143)
                        STAT_SET_INT("H4CNF_BS_ENTR", 63)
                        STAT_SET_INT("H4CNF_BS_ABIL", 63)
                        STAT_SET_INT("H4CNF_WEP_DISRP", 3)
                        STAT_SET_INT("H4CNF_ARM_DISRP", 3)
                        STAT_SET_INT("H4CNF_HEL_DISRP", 3)
                        STAT_SET_INT("H4CNF_APPROACH", -1)
                        STAT_SET_INT("H4CNF_BOLTCUT", 4424)
                        STAT_SET_INT("H4CNF_UNIFORM", 5256)
                        STAT_SET_INT("H4CNF_GRAPPEL", 5156)
                        STAT_SET_INT("H4_MISSIONS", -1)
                        STAT_SET_INT("H4CNF_WEAPONS", 1)
                        STAT_SET_INT("H4CNF_TROJAN", 5)
                        STAT_SET_INT("H4_PLAYTHROUGH_STATUS", 100)

                        menu.trigger_commands("hccprefreshboard")

                        for i = 1, #CayoPresetLists do
                            if CayoPresetLists[i][1] == AUTOAMTED_4P_SAPPHIRE then
                                CayoPresetLists[i][2] = true
                            end
                        end
                        for i = 1, 6 do
                            for j = 1, #ForCayoPresets[i] do
                                menu.set_help_text(ForCayoPresets[i][j][1], TRANSLATE("This feature has been controlled by another feature.") .. "\n" .. "- " .. menu.get_menu_name(CAYO_PRESETS) .. " > " .. menu.get_menu_name(menu.get_parent(AUTOAMTED_4P_SAPPHIRE)) .. " > " .. menu.get_menu_name(AUTOAMTED_4P_SAPPHIRE))
                            end
                        end
                    else
                        for i = 1, #CayoPresetLists do
                            if CayoPresetLists[i][1] == AUTOAMTED_4P_SAPPHIRE then
                                CayoPresetLists[i][2] = false
                            end
                        end
                        for i = 1, 6 do
                            for j = 1, #ForCayoPresets[i] do
                                menu.apply_default_state(ForCayoPresets[i][j][1])
                                menu.set_help_text(ForCayoPresets[i][j][1], ForCayoPresets[i][j][2])
                            end
                        end
                    end

                    while menu.get_value(AUTOAMTED_4P_SAPPHIRE) do
                        menu.set_value(CP_REM_FEE, false)
                        menu.set_value(CP_NON_HOST_CUT, 25)
                        menu.set_value(CP_NON_HOST_CUT_LOOP, false)
                        menu.set_value(CP_HOST_CUT, 25)
                        menu.set_value(CP_HOST_CUT_LOOP, true)
                        menu.set_value(CP_2P_CUT, 25)
                        menu.set_value(CP_2P_CUT_LOOP, true)
                        menu.set_value(CP_3P_CUT, 25)
                        menu.set_value(CP_3P_CUT_LOOP, true)
                        menu.set_value(CP_4P_CUT, 25)
                        menu.set_value(CP_4P_CUT_LOOP, true)

                        util.yield_once()
                    end
                end)

                AUTOAMTED_4P_RUBY = menu.toggle_loop(AUTOMATED_4P, TRANSLATE("Ruby Necklace"), {"hccp4prn"}, IS_WORKING(false), function()
                    if menu.get_value(AUTOAMTED_4P_RUBY) then
                        STAT_SET_INT("H4CNF_TARGET", 1)
                        STAT_SET_INT("H4LOOT_CASH_I", 9208137)
                        STAT_SET_INT("H4LOOT_CASH_I_SCOPED", 9208137)
                        STAT_SET_INT("H4LOOT_CASH_C", 0)
                        STAT_SET_INT("H4LOOT_CASH_C_SCOPED", 0)
                        STAT_SET_INT("H4LOOT_COKE_I", 1048704)
                        STAT_SET_INT("H4LOOT_COKE_I_SCOPED", 1048704)
                        STAT_SET_INT("H4LOOT_COKE_C", 0)
                        STAT_SET_INT("H4LOOT_COKE_C_SCOPED", 0)
                        STAT_SET_INT("H4LOOT_GOLD_I", 0)
                        STAT_SET_INT("H4LOOT_GOLD_I_SCOPED", 0)
                        STAT_SET_INT("H4LOOT_GOLD_C", 255)
                        STAT_SET_INT("H4LOOT_GOLD_C_SCOPED", 255)
                        STAT_SET_INT("H4LOOT_WEED_I", 4206596)
                        STAT_SET_INT("H4LOOT_WEED_I_SCOPED", 4206596)
                        STAT_SET_INT("H4LOOT_WEED_C", 0)
                        STAT_SET_INT("H4LOOT_WEED_C_SCOPED", 0)
                        STAT_SET_INT("H4LOOT_PAINT", 127)
                        STAT_SET_INT("H4LOOT_PAINT_SCOPED", 127)
                        STAT_SET_INT("H4LOOT_CASH_V", 655681)
                        STAT_SET_INT("H4LOOT_COKE_V", 1311363)
                        STAT_SET_INT("H4LOOT_GOLD_V", 1748484)
                        STAT_SET_INT("H4LOOT_PAINT_V", 1311363)
                        STAT_SET_INT("H4LOOT_WEED_V", 1049090)
                        STAT_SET_INT("H4_PROGRESS", 126823)
                        STAT_SET_INT("H4CNF_BS_GEN", 262143)
                        STAT_SET_INT("H4CNF_BS_ENTR", 63)
                        STAT_SET_INT("H4CNF_BS_ABIL", 63)
                        STAT_SET_INT("H4CNF_WEP_DISRP", 3)
                        STAT_SET_INT("H4CNF_ARM_DISRP", 3)
                        STAT_SET_INT("H4CNF_HEL_DISRP", 3)
                        STAT_SET_INT("H4CNF_APPROACH", -1)
                        STAT_SET_INT("H4CNF_BOLTCUT", 4424)
                        STAT_SET_INT("H4CNF_UNIFORM", 5256)
                        STAT_SET_INT("H4CNF_GRAPPEL", 5156)
                        STAT_SET_INT("H4_MISSIONS", -1)
                        STAT_SET_INT("H4CNF_WEAPONS", 1)
                        STAT_SET_INT("H4CNF_TROJAN", 5)
                        STAT_SET_INT("H4_PLAYTHROUGH_STATUS", 100)

                        menu.trigger_commands("hccprefreshboard")

                        for i = 1, #CayoPresetLists do
                            if CayoPresetLists[i][1] == AUTOAMTED_4P_RUBY then
                                CayoPresetLists[i][2] = true
                            end
                        end
                        for i = 1, 6 do
                            for j = 1, #ForCayoPresets[i] do
                                menu.set_help_text(ForCayoPresets[i][j][1], TRANSLATE("This feature has been controlled by another feature.") .. "\n" .. "- " .. menu.get_menu_name(CAYO_PRESETS) .. " > " .. menu.get_menu_name(menu.get_parent(AUTOAMTED_4P_RUBY)) .. " > " .. menu.get_menu_name(AUTOAMTED_4P_RUBY))
                            end
                        end
                    else
                        for i = 1, #CayoPresetLists do
                            if CayoPresetLists[i][1] == AUTOAMTED_4P_RUBY then
                                CayoPresetLists[i][2] = false
                            end
                        end
                        for i = 1, 6 do
                            for j = 1, #ForCayoPresets[i] do
                                menu.apply_default_state(ForCayoPresets[i][j][1])
                                menu.set_help_text(ForCayoPresets[i][j][1], ForCayoPresets[i][j][2])
                            end
                        end
                    end

                    while menu.get_value(AUTOAMTED_4P_RUBY) do
                        menu.set_value(CP_REM_FEE, false)
                        menu.set_value(CP_NON_HOST_CUT, 25)
                        menu.set_value(CP_NON_HOST_CUT_LOOP, false)
                        menu.set_value(CP_HOST_CUT, 25)
                        menu.set_value(CP_HOST_CUT_LOOP, true)
                        menu.set_value(CP_2P_CUT, 25)
                        menu.set_value(CP_2P_CUT_LOOP, true)
                        menu.set_value(CP_3P_CUT, 25)
                        menu.set_value(CP_3P_CUT_LOOP, true)
                        menu.set_value(CP_4P_CUT, 25)
                        menu.set_value(CP_4P_CUT_LOOP, true)

                        util.yield_once()
                    end
                end)

            ---

        ---

    ---

    TELEPORT_CP = menu.list(PERICO_HEIST, TRANSLATE("Teleport Places"), {}, TRANSLATE("- How to change the line color: Stand > Settings > Appearance > Colours > HUD Colour") .. "\n\n" .. TRANSLATE("- How to change the AR Beacon color: Stand > Settings > Appearance > Colours > AR Colour"), function(); end)

        CAYO_TELE_COMPOUND = menu.list(TELEPORT_CP, TRANSLATE("Compound"), {}, "", function(); end)

            CAYO_TELE_STORAGE = menu.list(CAYO_TELE_COMPOUND, TRANSLATE("Storage"), {}, "", function(); end)

                CAYO_TELE_STORAGE_NORTH = menu.action(CAYO_TELE_STORAGE, TRANSLATE("North"), {}, "", function()
                    TELEPORT(5081.0415, -5755.32, 15.829645)
                    SET_HEADING(-45)
                end)
                CAYO_TELE_STORAGE_WEST = menu.action(CAYO_TELE_STORAGE, TRANSLATE("West"), {}, "", function()
                    TELEPORT(5006.722, -5786.5967, 17.831688)
                    SET_HEADING(35)
                end)
                CAYO_TELE_STORAGE_SOUTH = menu.action(CAYO_TELE_STORAGE, TRANSLATE("South"), {}, "", function()
                    TELEPORT(5027.603, -5734.682, 17.255005)
                    SET_HEADING(-50)
                end)

            ---

            CAYO_TELE_VAULT = menu.list(CAYO_TELE_COMPOUND, TRANSLATE("Vault"), {}, "", function(); end)

                CAYO_TELE_VAULT_PRIMARY_TARGET = menu.action(CAYO_TELE_VAULT, TRANSLATE("Primary Target"), {}, "", function()
                    TELEPORT(5006.7, -5756.2, 14.8)
                    SET_HEADING(145)
                end)
                CAYO_TELE_VAULT_SECONDARY_TARGET = menu.action(CAYO_TELE_VAULT, TRANSLATE("Secondary Target"), {}, "", function()
                    TELEPORT(4999.764160, -5749.863770, 14.840000)
                end)

            ---

            CAYO_TELE_COMPOUND_OFFICE = menu.action(CAYO_TELE_COMPOUND, TRANSLATE("El Rubio's Office"), {}, "", function()
                TELEPORT(5010.12, -5750.1353, 28.84334)
                SET_HEADING(325)
            end)
            CAYO_TELE_COMPOUND_FRONT_EXIT = menu.action(CAYO_TELE_COMPOUND, TRANSLATE("Front Gate Exit"), {}, "", function()
                TELEPORT(4990.0386, -5717.6895, 19.880217)
                SET_HEADING(50)
            end)

        ---

        CAYO_TELE_ISLAND = menu.list(TELEPORT_CP, TRANSLATE("Island"), {}, "", function(); end)

            CAYO_TELE_AIRSTRIP = menu.list(CAYO_TELE_ISLAND, TRANSLATE("Airstrip"), {}, "", function(); end)

                CAYO_TELE_AIRSTRIP_1 = menu.action(CAYO_TELE_AIRSTRIP, TRANSLATE("Loot") .. " - #1", {}, "", function()
                    TELEPORT(4503.587402, -4555.740723, 2.854459)
                end)
                CAYO_TELE_AIRSTRIP_2 = menu.action(CAYO_TELE_AIRSTRIP, TRANSLATE("Loot") .. " - #2", {}, "", function()
                    TELEPORT(4437.821777, -4447.841309, 3.028436)
                end)
                CAYO_TELE_AIRSTRIP_3 = menu.action(CAYO_TELE_AIRSTRIP, TRANSLATE("Loot") .. " - #3", {}, "", function()
                    TELEPORT(4447.091797, -4442.184082, 5.936794)
                end)

            ---

            CAYO_TELE_CROP_FIELDS = menu.list(CAYO_TELE_ISLAND, TRANSLATE("Crop Fields"), {}, "", function(); end)

                CAYO_TELE_CROP_FIELDS_1 = menu.action(CAYO_TELE_CROP_FIELDS, TRANSLATE("Loot") .. " - #1", {}, "", function()
                    TELEPORT(5330.527, -5269.7515, 33.18603)
                end)

            ---

            CAYO_TELE_MAIN_DOCK = menu.list(CAYO_TELE_ISLAND, TRANSLATE("Main Dock"), {}, "", function(); end)

                CAYO_TELE_MAIN_DOCK_1 = menu.action(CAYO_TELE_MAIN_DOCK, TRANSLATE("Loot") .. " - #1", {}, "", function()
                    TELEPORT(5193.909668, -5135.642578, 2.045917)
                end)
                CAYO_TELE_MAIN_DOCK_2 = menu.action(CAYO_TELE_MAIN_DOCK, TRANSLATE("Loot") .. " - #2", {}, "", function()
                    TELEPORT(4963.184570, -5108.933105, 1.670808)
                end)
                CAYO_TELE_MAIN_DOCK_3 = menu.action(CAYO_TELE_MAIN_DOCK, TRANSLATE("Loot") .. " - #3", {}, "", function()
                    TELEPORT(4998.709473, -5165.559570, 1.464137)
                end)
                CAYO_TELE_MAIN_DOCK_4 = menu.action(CAYO_TELE_MAIN_DOCK, TRANSLATE("Loot") .. " - #4", {}, "", function()
                    TELEPORT(4924.693359, -5243.244629, 1.223599)
                end)

            ---

            CAYO_TELE_NORTH_DOCK = menu.list(CAYO_TELE_ISLAND, TRANSLATE("North Dock"), {}, "", function(); end)

                CAYO_TELE_NORTH_DOCK_1 = menu.action(CAYO_TELE_NORTH_DOCK, TRANSLATE("Loot") .. " - #1", {}, "", function()
                    TELEPORT(5132.558594, -4612.922852, 1.162808)
                end)
                CAYO_TELE_NORTH_DOCK_2 = menu.action(CAYO_TELE_NORTH_DOCK, TRANSLATE("Loot") .. " - #2", {}, "", function()
                    TELEPORT(5065.255371, -4591.706543, 1.555012)
                end)
                CAYO_TELE_NORTH_DOCK_3 = menu.action(CAYO_TELE_NORTH_DOCK, TRANSLATE("Loot") .. " - #3", {}, "", function()
                    TELEPORT(5090.916016, -4682.670898, 1.107098)
                end)

            ---

            CAYO_TELE_ISLAND_RADIO = menu.action(CAYO_TELE_ISLAND, TRANSLATE("Radio Tower"), {}, "", function()
                TELEPORT(5263.7124, -5407.5835, 65.24931)
            end)
            CAYO_TELE_ISLAND_DRAINGE_1 = menu.action(CAYO_TELE_ISLAND, TRANSLATE("Drainage Pipe"), {}, "", function()
                TELEPORT(5044.001, -5815.6426, -11.808871)
            end)
            CAYO_TELE_ISLAND_DRAINGE_2 = menu.action(CAYO_TELE_ISLAND, TRANSLATE("Drainage: 2nd Checkpoint"), {}, "", function()
                TELEPORT(5053.773, -5773.2266, -5.40778)
            end)
            CAYO_TELE_ISLAND_SAFE_ZONE = menu.action(CAYO_TELE_ISLAND, TRANSLATE("Ocean (Safe Zone)"), {}, "", function()
                TELEPORT(4771.479, -6165.737, -39.079613)
            end)

        ---

        TELEPORT_CP_KOSATKA = menu.action(TELEPORT_CP, TRANSLATE("Kosatka: Heist Board"), {"hctpsub"}, "", function()
            if STAT_GET_INT("IH_SUB_OWNED") ~= 0 then
                if not HUD.DOES_BLIP_EXIST(SubBlip) and not HUD.DOES_BLIP_EXIST(SubControlBlip) then
                    local PlayerPos = players.get_position(players.user())
                    local Interior = INTERIOR.GET_INTERIOR_AT_COORDS(PlayerPos.x, PlayerPos.y, PlayerPos.z)
                    if Interior ~= 281345 then
                        NOTIFY(TRANSLATE("Waiting for requesting Kosatka..."))
                        local CommandRef = menu.ref_by_command_name("hcreq")
                        menu.trigger_command(CommandRef, "kosatka")
                        util.arspinner_enable()
                        repeat util.yield_once() until HUD.DOES_BLIP_EXIST(SubBlip)
                        util.arspinner_disable()
                    end
                end

                TELEPORT(1561.2369, 385.8771, -49.689915)
                SET_HEADING(175)
            else
                NOTIFY(TRANSLATE("You didn't buy the Kosatka yet. Buy it first to teleport!"))
            end
        end)

    ---

    PERICO_ADV = menu.list(PERICO_HEIST, TRANSLATE("Advanced Features"), {}, "", function(); end)

        PERICO_CUTS = menu.list(PERICO_ADV, TRANSLATE("Player's Cut"), {}, TRANSLATE("Don't forget changing this feature before starting the heist! Otherwise, won't be applied."), function(); end)

            PERICO_NON_HOST_CUT = menu.list(PERICO_CUTS, TRANSLATE("Your Cut (Non-Host)"), {}, TRANSLATE("Note that modifying this won't applied to the heist board. You can check the applied cut after end of the heist."), function(); end)

                CP_NON_HOST_CUT_LOOP = menu.toggle_loop(PERICO_NON_HOST_CUT, TRANSLATE("Enable"), {"hccpnonhostloop"}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(2684801 + 6589, menu.get_value(CP_NON_HOST_CUT)) -- heist_island_planning.c
                end, function()
                    SET_INT_GLOBAL(2684801 + 6589, menu.get_default_state(CP_NON_HOST_CUT))
                end)

                CP_NON_HOST_CUT = menu.slider(PERICO_NON_HOST_CUT, TRANSLATE("Custom Percentage"), {"hccpnonhost"}, "(%)", 0, 1000, 100, 5, function(); end)

            ---

            PERICO_HOST_CUT = menu.list(PERICO_CUTS, TRANSLATE("Your Cut"), {}, TRANSLATE("Only works if you are host of the heist."), function(); end)

            CP_HOST_CUT_LOOP = menu.toggle_loop(PERICO_HOST_CUT, TRANSLATE("Enable"), {"hccphostcutloop"}, IS_WORKING(false), function()
                SET_INT_GLOBAL(1978495 + 825 + 56 + 1, menu.get_value(CP_HOST_CUT)) -- heist_island_planning.c
            end, function()
                SET_INT_GLOBAL(1978495 + 825 + 56 + 1, menu.get_default_state(CP_HOST_CUT))
            end)

                CP_HOST_CUT = menu.slider(PERICO_HOST_CUT, TRANSLATE("Custom Percentage"), {"hccphostcut"}, "(%)", 0, 1000, 100, 5, function(); end)

            ---

            PERICO_P2_CUT = menu.list(PERICO_CUTS, TRANSLATE("Player 2"), {}, TRANSLATE("Only works if you are host of the heist."), function(); end)

            CP_2P_CUT_LOOP = menu.toggle_loop(PERICO_P2_CUT, TRANSLATE("Enable"), {"hccp2pcutloop"}, IS_WORKING(false), function()
                SET_INT_GLOBAL(1978495 + 825 + 56 + 2, menu.get_value(CP_2P_CUT)) -- heist_island_planning.c
            end, function()
                SET_INT_GLOBAL(1978495 + 825 + 56 + 2, menu.get_default_state(CP_2P_CUT))
            end)

                CP_2P_CUT = menu.slider(PERICO_P2_CUT, TRANSLATE("Custom Percentage"), {"hccp2pcut"}, "(%)", 0, 1000, 100, 5, function(); end)
            
            ---
            
            PERICO_P3_CUT = menu.list(PERICO_CUTS, TRANSLATE("Player 3"), {}, TRANSLATE("Only works if you are host of the heist."), function(); end)

            CP_3P_CUT_LOOP = menu.toggle_loop(PERICO_P3_CUT, TRANSLATE("Enable"), {"hccp3pcutloop"}, IS_WORKING(false), function()
                SET_INT_GLOBAL(1978495 + 825 + 56 + 3, menu.get_value(CP_3P_CUT)) -- heist_island_planning.c
            end, function()
                SET_INT_GLOBAL(1978495 + 825 + 56 + 3, menu.get_default_state(CP_3P_CUT))
            end)

                CP_3P_CUT = menu.slider(PERICO_P3_CUT, TRANSLATE("Custom Percentage"), {"hccp3pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

            ---

            PERICO_P4_CUT = menu.list(PERICO_CUTS, TRANSLATE("Player 4"), {}, TRANSLATE("Only works if you are host of the heist."), function(); end)

            CP_4P_CUT_LOOP = menu.toggle_loop(PERICO_P4_CUT, TRANSLATE("Enable"), {"hccp4pcutloop"}, IS_WORKING(false), function()
                SET_INT_GLOBAL(1978495 + 825 + 56 + 4, menu.get_value(CP_4P_CUT)) -- heist_island_planning.c
            end, function()
                SET_INT_GLOBAL(1978495 + 825 + 56 + 4, menu.get_default_state(CP_4P_CUT))
            end)

                CP_4P_CUT = menu.slider(PERICO_P4_CUT, TRANSLATE("Custom Percentage"), {"hccp4pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

            ---

        ---

        menu.list_action(PERICO_ADV, TRANSLATE("Bag Capacity Modifier"), {"hccpbag"}, IS_WORKING(true) .. TRANSLATE("(Local)"), {
            { TRANSLATE("Normal Bag Capacity"), {"1p"}, "" },
            { TRANSLATE("Simulate Bag Capacity of 2 players"), {"2p"}, "" },
            { TRANSLATE("Simulate Bag Capacity of 3 players"), {"3p"}, "" },
            { TRANSLATE("Simulate Bag Capacity of 4 players"), {"4p"}, "" },
            { TRANSLATE("Infinite Bag Capacity"), {"inf"}, "" },
        }, function(index)
            if index ~= 5 then
                SET_INT_GLOBAL(262145 + 29732, 1800 * index) -- 1859395035
            else
                SET_INT_GLOBAL(262145 + 29732, 99999)
            end
        end)

        menu.toggle_loop(PERICO_ADV, TRANSLATE("Skip The Hacking Process"), {}, IS_WORKING(true) .. "(" .. TRANSLATE("Cayo Perico Heist") .. " > " .. TRANSLATE("Teleport Places") .. " > " .. TRANSLATE("Compound") .. " > " .. TRANSLATE("El Rubio's Office") .. ")", function() 
            if GET_INT_LOCAL("fm_mission_controller_2020", 22032) == 4 then -- https://www.unknowncheats.me/forum/3418914-post13398.html
                SET_INT_LOCAL("fm_mission_controller_2020", 22032, 5)
            end
        end)

        menu.toggle_loop(PERICO_ADV, TRANSLATE("Skip Cutting The Sewer Grill"), {}, IS_WORKING(true) .. "(" .. TRANSLATE("Cayo Perico Heist") .. " > " .. TRANSLATE("Teleport Places") .. " > " .. TRANSLATE("Island") .. " > " .. TRANSLATE("Drainage Pipe") .. ")", function() 
            if GET_INT_LOCAL("fm_mission_controller_2020", 26746) == 4 then -- https://www.unknowncheats.me/forum/3389282-post1.html  
                SET_INT_LOCAL("fm_mission_controller_2020", 26746, 6)
            end
        end)

        menu.toggle_loop(PERICO_ADV, TRANSLATE("Skip Cutting The Glass"), {}, IS_WORKING(true) .. "(" .. TRANSLATE("Cayo Perico Heist") .. " > " .. TRANSLATE("Teleport Places") .. " > " .. TRANSLATE("Compound") .. " > " .. TRANSLATE("Primary Target") .. ")", function()
            SET_FLOAT_LOCAL("fm_mission_controller_2020", 27985 + 3, 100)
        end, function()
            SET_FLOAT_LOCAL("fm_mission_controller_2020", 27985 + 3, 0)
        end)

        menu.toggle_loop(PERICO_ADV, TRANSLATE("Infinite Plasma Cutter Heat"), {}, IS_WORKING(true) .. "(" .. TRANSLATE("Cayo Perico Heist") .. " > " .. TRANSLATE("Teleport Places") .. " > " .. TRANSLATE("Compound") .. " > " .. TRANSLATE("Primary Target") .. ")", function()
            SET_FLOAT_LOCAL("fm_mission_controller_2020", 27985 + 4, 0)
        end)

        menu.toggle_loop(PERICO_ADV, TRANSLATE("Infinite Voltage Timer"), {}, IS_WORKING(true) .. "(" .. TRANSLATE("Cayo Perico Heist") .. " > " .. TRANSLATE("Teleport Places") .. " > " .. TRANSLATE("Island") .. " > " .. TRANSLATE("Radio Tower") .. ")", function()
            local Value = GET_INT_LOCAL("fm_mission_controller_2020", 1718)
            SET_INT_LOCAL("fm_mission_controller_2020", 1717, Value)
        end, function()
            SET_INT_LOCAL("fm_mission_controller_2020", 1717, 0)
        end)

        CP_REM_FEE = menu.toggle_loop(PERICO_ADV, TRANSLATE("Remove The Fencing Fee And Pavel's Cut"), {"hccpremfee"}, IS_WORKING(true) .. TRANSLATE("(Local)") .. "\n\n" .. TRANSLATE("You should enable the preset until the end of the heist!"), function()
            SET_FLOAT_GLOBAL(262145 + 29991, 0) -- 902085532
            SET_FLOAT_GLOBAL(262145 + 29992, 0) -- -1135949374
        end, function()
            SET_FLOAT_GLOBAL(262145 + 29991, -0.1)
            SET_FLOAT_GLOBAL(262145 + 29992, -0.02)
        end)

        menu.action(PERICO_ADV, TRANSLATE("Obtain The Primary Target"), {"hccpfintar"}, IS_WORKING(true) .. "(" .. TRANSLATE("Cayo Perico Heist") .. " > " .. TRANSLATE("Teleport Places") .. " > " .. TRANSLATE("Compound") .. " > " .. TRANSLATE("Primary Target") .. ")", function() -- https://www.unknowncheats.me/forum/3418914-post13398.html
            SET_INT_LOCAL("fm_mission_controller_2020", 27984, 5) -- CutterStage
            SET_INT_LOCAL("fm_mission_controller_2020", 27985, 3) -- BitCheck
        end)

        menu.action(PERICO_ADV, TRANSLATE("Remove The Drainage Pipe"), {"hccprempipe"}, "(" .. TRANSLATE("Cayo Perico Heist") .. " > " .. TRANSLATE("Teleport Places") .. " > " .. TRANSLATE("Island") .. " > " .. TRANSLATE("Drainage Pipe") .. ")", function()
            local Object = util.joaat("prop_chem_grill_bit") -- Thanks for letting me know the object, Sapphire#6031
            DELETE_OBJECT_BY_HASH(Object)
        end)

        menu.action(PERICO_ADV, TRANSLATE("Refresh Kosatka Planning Table"), {"hccprefreshboard"}, IS_WORKING(true) .. TRANSLATE("You can update changed cayo perico heist stats in the Kosatka by refreshing it."), function()
            SET_INT_LOCAL("heist_island_planning", 1525, 2) -- https://github.com/atomikfr/CayoPericoHeistAssistant
        end)
    
    ---

    menu.list_action(PERICO_HEIST, TRANSLATE("Heist Vehicles"), {"hccpveh"}, "", {
        { TRANSLATE("Kosatka"), {"kosatka"}, TRANSLATE("(Submarine)") },
        { TRANSLATE("Alkonost"), {"alkonost"}, TRANSLATE("(Plane)") },
        { TRANSLATE("Velum"), {"velum"}, TRANSLATE("(Plane)") },
        { TRANSLATE("Annihilator Stealth"), {"annihilator"}, TRANSLATE("(Helicopter)") },
        { TRANSLATE("Kurtz 31 Patrol Boat"), {"patrol"}, TRANSLATE("(Boat)") },
        { TRANSLATE("Longfin"), {"longfin"}, TRANSLATE("(Boat)") },
        { TRANSLATE("Unlock All"), {"all"}, "" },
    }, function(index)
        if index == 1 then
            STAT_SET_INT("H4_MISSIONS", 65283)
        elseif index == 2 then
            STAT_SET_INT("H4_MISSIONS", 65413)
        elseif index == 3 then 
            STAT_SET_INT("H4_MISSIONS", 65289)
        elseif index == 4 then 
            STAT_SET_INT("H4_MISSIONS", 65425)
        elseif index == 5 then 
            STAT_SET_INT("H4_MISSIONS", 65313)
        elseif index == 6 then 
            STAT_SET_INT("H4_MISSIONS", 65345)
        elseif index == 7 then
            STAT_SET_INT("H4_MISSIONS", -1)
        end

        menu.trigger_commands("hccprefreshboard")
    end)

    menu.list_action(PERICO_HEIST, TRANSLATE("Primary Target"), {"hccppritar"}, "", {
        { TRANSLATE("Sapphire Panther"), {"panther"}, "" },
        { TRANSLATE("Madrazo Files"), {"file"}, "" },
        { TRANSLATE("Pink Diamond"), {"diamond"}, "" },
        { TRANSLATE("Bearer Bonds"), {"bearer"}, "" },
        { TRANSLATE("Ruby Necklace"), {"ruby"}, "" },
        { TRANSLATE("Tequila"), {"tequila"}, "" },
    }, function(index)
        if index == 1 then
            STAT_SET_INT("H4CNF_TARGET", 5)
        elseif index == 2 then
            STAT_SET_INT("H4CNF_TARGET", 4)
        elseif index == 3 then 
            STAT_SET_INT("H4CNF_TARGET", 3)
        elseif index == 4 then 
            STAT_SET_INT("H4CNF_TARGET", 2)
        elseif index == 5 then 
            STAT_SET_INT("H4CNF_TARGET", 1)
        elseif index == 6 then 
            STAT_SET_INT("H4CNF_TARGET", 0)
        end

        menu.trigger_commands("hccprefreshboard")
    end)

    menu.list_action(PERICO_HEIST, TRANSLATE("Secondary Target"), {"hccpsectar"}, TRANSLATE("When using this method, the percentage and final payment will be random!"), {
        { TRANSLATE("Mixed Loot"), {"mixed"}, "" },
        { TRANSLATE("Cash"), {"cash"}, "" },
        { TRANSLATE("Weed"), {"weed"}, "" },
        { TRANSLATE("Coke"), {"coke"}, "" },
        { TRANSLATE("Gold"), {"gold"}, "" },
        { TRANSLATE("Remove All"), {"remall"}, "" },
    }, function(index)
        if index == 1 then
            STAT_SET_INT("H4LOOT_CASH_I", 1319624)
            STAT_SET_INT("H4LOOT_CASH_C", 18)
            STAT_SET_INT("H4LOOT_CASH_V", 89400)
            STAT_SET_INT("H4LOOT_WEED_I", 2639108)
            STAT_SET_INT("H4LOOT_WEED_C", 36)
            STAT_SET_INT("H4LOOT_WEED_V", 149000)
            STAT_SET_INT("H4LOOT_COKE_I", 4229122)
            STAT_SET_INT("H4LOOT_COKE_C", 72)
            STAT_SET_INT("H4LOOT_COKE_V", 221200)
            STAT_SET_INT("H4LOOT_GOLD_I", 8589313)
            STAT_SET_INT("H4LOOT_GOLD_C", 129)
            STAT_SET_INT("H4LOOT_GOLD_V", 322600)
            STAT_SET_INT("H4LOOT_PAINT", 127)
            STAT_SET_INT("H4LOOT_PAINT_V", 186800)
            STAT_SET_INT("H4LOOT_CASH_I_SCOPED", 1319624)
            STAT_SET_INT("H4LOOT_CASH_C_SCOPED", 18)
            STAT_SET_INT("H4LOOT_WEED_I_SCOPED", 2639108)
            STAT_SET_INT("H4LOOT_WEED_C_SCOPED", 36)
            STAT_SET_INT("H4LOOT_COKE_I_SCOPED", 4229122)
            STAT_SET_INT("H4LOOT_COKE_C_SCOPED", 72)
            STAT_SET_INT("H4LOOT_GOLD_I_SCOPED", 8589313)
            STAT_SET_INT("H4LOOT_GOLD_C_SCOPED", 129)
            STAT_SET_INT("H4LOOT_PAINT_SCOPED", 127)
        elseif index == 2 then
            STAT_SET_INT("H4LOOT_CASH_I", -1)
            STAT_SET_INT("H4LOOT_CASH_C", -1)
            STAT_SET_INT("H4LOOT_CASH_V", 90000)
            STAT_SET_INT("H4LOOT_WEED_I", 0)
            STAT_SET_INT("H4LOOT_WEED_C", 0)
            STAT_SET_INT("H4LOOT_WEED_V", 0)
            STAT_SET_INT("H4LOOT_COKE_I", 0)
            STAT_SET_INT("H4LOOT_COKE_C", 0)
            STAT_SET_INT("H4LOOT_COKE_V", 0)
            STAT_SET_INT("H4LOOT_GOLD_I", 0)
            STAT_SET_INT("H4LOOT_GOLD_C", 0)
            STAT_SET_INT("H4LOOT_GOLD_V", 0)
            STAT_SET_INT("H4LOOT_PAINT", 127)
            STAT_SET_INT("H4LOOT_PAINT_V", 190000)
            STAT_SET_INT("H4LOOT_CASH_I_SCOPED", -1)
            STAT_SET_INT("H4LOOT_CASH_C_SCOPED", -1)
            STAT_SET_INT("H4LOOT_WEED_I_SCOPED", 0)
            STAT_SET_INT("H4LOOT_WEED_C_SCOPED", 0)
            STAT_SET_INT("H4LOOT_COKE_I_SCOPED", 0)
            STAT_SET_INT("H4LOOT_COKE_C_SCOPED", 0)
            STAT_SET_INT("H4LOOT_GOLD_I_SCOPED", 0)
            STAT_SET_INT("H4LOOT_GOLD_C_SCOPED", 0)
            STAT_SET_INT("H4LOOT_PAINT_SCOPED", 127)
        elseif index == 3 then 
            STAT_SET_INT("H4LOOT_CASH_I", 0)
            STAT_SET_INT("H4LOOT_CASH_C", 0)
            STAT_SET_INT("H4LOOT_CASH_V", 0)
            STAT_SET_INT("H4LOOT_WEED_I", -1)
            STAT_SET_INT("H4LOOT_WEED_C", -1)
            STAT_SET_INT("H4LOOT_WEED_V", 140000)
            STAT_SET_INT("H4LOOT_COKE_I", 0)
            STAT_SET_INT("H4LOOT_COKE_C", 0)
            STAT_SET_INT("H4LOOT_COKE_V", 0)
            STAT_SET_INT("H4LOOT_GOLD_I", 0)
            STAT_SET_INT("H4LOOT_GOLD_C", 0)
            STAT_SET_INT("H4LOOT_GOLD_V", 0)
            STAT_SET_INT("H4LOOT_PAINT", 127)
            STAT_SET_INT("H4LOOT_PAINT_V", 190000)
            STAT_SET_INT("H4LOOT_CASH_I_SCOPED", 0)
            STAT_SET_INT("H4LOOT_CASH_C_SCOPED", 0)
            STAT_SET_INT("H4LOOT_WEED_I_SCOPED", -1)
            STAT_SET_INT("H4LOOT_WEED_C_SCOPED", -1)
            STAT_SET_INT("H4LOOT_COKE_I_SCOPED", 0)
            STAT_SET_INT("H4LOOT_COKE_C_SCOPED", 0)
            STAT_SET_INT("H4LOOT_GOLD_I_SCOPED", 0)
            STAT_SET_INT("H4LOOT_GOLD_C_SCOPED", 0)
            STAT_SET_INT("H4LOOT_PAINT_SCOPED", 127)
        elseif index == 4 then 
            STAT_SET_INT("H4LOOT_CASH_I", 0)
            STAT_SET_INT("H4LOOT_CASH_C", 0)
            STAT_SET_INT("H4LOOT_CASH_V", 0)
            STAT_SET_INT("H4LOOT_WEED_I", 0)
            STAT_SET_INT("H4LOOT_WEED_C", 0)
            STAT_SET_INT("H4LOOT_WEED_V", 0)
            STAT_SET_INT("H4LOOT_COKE_I", -1)
            STAT_SET_INT("H4LOOT_COKE_C", -1)
            STAT_SET_INT("H4LOOT_COKE_V", 210000)
            STAT_SET_INT("H4LOOT_GOLD_I", 0)
            STAT_SET_INT("H4LOOT_GOLD_C", 0)
            STAT_SET_INT("H4LOOT_GOLD_V", 0)
            STAT_SET_INT("H4LOOT_PAINT", 127)
            STAT_SET_INT("H4LOOT_PAINT_V", 190000)
            STAT_SET_INT("H4LOOT_CASH_I_SCOPED", 0)
            STAT_SET_INT("H4LOOT_CASH_C_SCOPED", 0)
            STAT_SET_INT("H4LOOT_WEED_I_SCOPED", 0)
            STAT_SET_INT("H4LOOT_WEED_C_SCOPED", 0)
            STAT_SET_INT("H4LOOT_COKE_I_SCOPED", -1)
            STAT_SET_INT("H4LOOT_COKE_C_SCOPED", -1)
            STAT_SET_INT("H4LOOT_GOLD_I_SCOPED", 0)
            STAT_SET_INT("H4LOOT_GOLD_C_SCOPED", 0)
            STAT_SET_INT("H4LOOT_PAINT_SCOPED", 127)
        elseif index == 5 then 
            STAT_SET_INT("H4LOOT_CASH_I", 0)
            STAT_SET_INT("H4LOOT_CASH_C", 0)
            STAT_SET_INT("H4LOOT_CASH_V", 0)
            STAT_SET_INT("H4LOOT_WEED_I", 0)
            STAT_SET_INT("H4LOOT_WEED_C", 0)
            STAT_SET_INT("H4LOOT_WEED_V", 0)
            STAT_SET_INT("H4LOOT_COKE_I", 0)
            STAT_SET_INT("H4LOOT_COKE_C", 0)
            STAT_SET_INT("H4LOOT_COKE_V", 0)
            STAT_SET_INT("H4LOOT_GOLD_I", -1)
            STAT_SET_INT("H4LOOT_GOLD_C", -1)
            STAT_SET_INT("H4LOOT_GOLD_V", 320000)
            STAT_SET_INT("H4LOOT_PAINT", -1)
            STAT_SET_INT("H4LOOT_PAINT_V", 190000)
            STAT_SET_INT("H4LOOT_CASH_I_SCOPED", 0)
            STAT_SET_INT("H4LOOT_CASH_C_SCOPED", 0)
            STAT_SET_INT("H4LOOT_WEED_I_SCOPED", 0)
            STAT_SET_INT("H4LOOT_WEED_C_SCOPED", 0)
            STAT_SET_INT("H4LOOT_COKE_I_SCOPED", 0)
            STAT_SET_INT("H4LOOT_COKE_C_SCOPED", 0)
            STAT_SET_INT("H4LOOT_GOLD_I_SCOPED", -1)
            STAT_SET_INT("H4LOOT_GOLD_C_SCOPED", -1)
            STAT_SET_INT("H4LOOT_PAINT_SCOPED", -1)
        elseif index == 6 then 
            STAT_SET_INT("H4LOOT_CASH_I", 0)
            STAT_SET_INT("H4LOOT_CASH_C", 0)
            STAT_SET_INT("H4LOOT_CASH_V", 0)
            STAT_SET_INT("H4LOOT_WEED_I", 0)
            STAT_SET_INT("H4LOOT_WEED_C", 0)
            STAT_SET_INT("H4LOOT_WEED_V", 0)
            STAT_SET_INT("H4LOOT_COKE_I", 0)
            STAT_SET_INT("H4LOOT_COKE_C", 0)
            STAT_SET_INT("H4LOOT_COKE_V", 0)
            STAT_SET_INT("H4LOOT_GOLD_I", 0)
            STAT_SET_INT("H4LOOT_GOLD_C", 0)
            STAT_SET_INT("H4LOOT_GOLD_V", 0)
            STAT_SET_INT("H4LOOT_PAINT", 0)
            STAT_SET_INT("H4LOOT_PAINT_V", 0)
            STAT_SET_INT("H4LOOT_CASH_I_SCOPED", 0)
            STAT_SET_INT("H4LOOT_CASH_C_SCOPED", 0)
            STAT_SET_INT("H4LOOT_WEED_I_SCOPED", 0)
            STAT_SET_INT("H4LOOT_WEED_C_SCOPED", 0)
            STAT_SET_INT("H4LOOT_COKE_I_SCOPED", 0)
            STAT_SET_INT("H4LOOT_COKE_C_SCOPED", 0)
            STAT_SET_INT("H4LOOT_GOLD_I_SCOPED", 0)
            STAT_SET_INT("H4LOOT_GOLD_C_SCOPED", 0)
            STAT_SET_INT("H4LOOT_PAINT_SCOPED", 0)
        end

        menu.trigger_commands("hccprefreshboard")
    end)

    menu.list_action(PERICO_HEIST, TRANSLATE("Compound Loot"), {"hccpcomloot"}, "", {
        { TRANSLATE("Mixed Loot"), {"mixed"}, "" },
        { TRANSLATE("Cash"), {"cash"}, "" },
        { TRANSLATE("Weed"), {"weed"}, "" },
        { TRANSLATE("Coke"), {"coke"}, "" },
        { TRANSLATE("Gold"), {"gold"}, "" },
        { TRANSLATE("Paint"), {"paint"}, "" },
        { TRANSLATE("Remove Paint (Only)"), {"rempaint"}, "" },
        { TRANSLATE("Remove All"), {"remall"}, "" },
    }, function(index)
        if index == 1 then
            STAT_SET_INT("H4LOOT_CASH_C", 2)
            STAT_SET_INT("H4LOOT_CASH_V", 474431)
            STAT_SET_INT("H4LOOT_WEED_C", 17)
            STAT_SET_INT("H4LOOT_WEED_V", 759090)
            STAT_SET_INT("H4LOOT_COKE_C", 132)
            STAT_SET_INT("H4LOOT_COKE_V", 948863)
            STAT_SET_INT("H4LOOT_GOLD_C", 104)
            STAT_SET_INT("H4LOOT_GOLD_V", 1265151)
            STAT_SET_INT("H4LOOT_PAINT", 127)
            STAT_SET_INT("H4LOOT_PAINT_V", 948863)
            STAT_SET_INT("H4LOOT_CASH_C_SCOPED", 2)
            STAT_SET_INT("H4LOOT_WEED_C_SCOPED", 17)
            STAT_SET_INT("H4LOOT_COKE_C_SCOPED", 132)
            STAT_SET_INT("H4LOOT_GOLD_C_SCOPED", 104)
            STAT_SET_INT("H4LOOT_PAINT_SCOPED", 127)
        elseif index == 2 then
            STAT_SET_INT("H4LOOT_CASH_C", -1)
            STAT_SET_INT("H4LOOT_CASH_V", 90000)
            STAT_SET_INT("H4LOOT_WEED_C", 0)
            STAT_SET_INT("H4LOOT_WEED_V", 0)
            STAT_SET_INT("H4LOOT_COKE_C", 0)
            STAT_SET_INT("H4LOOT_COKE_V", 0)
            STAT_SET_INT("H4LOOT_GOLD_C", 0)
            STAT_SET_INT("H4LOOT_GOLD_V", 0)
            STAT_SET_INT("H4LOOT_PAINT", 127)
            STAT_SET_INT("H4LOOT_PAINT_V", 190000)
            STAT_SET_INT("H4LOOT_CASH_C_SCOPED", -1)
            STAT_SET_INT("H4LOOT_WEED_C_SCOPED", 0)
            STAT_SET_INT("H4LOOT_COKE_C_SCOPED", 0)
            STAT_SET_INT("H4LOOT_GOLD_C_SCOPED", 0)
            STAT_SET_INT("H4LOOT_PAINT_SCOPED", 127)
        elseif index == 3 then 
            STAT_SET_INT("H4LOOT_CASH_C", 0)
            STAT_SET_INT("H4LOOT_CASH_V", 0)
            STAT_SET_INT("H4LOOT_WEED_C", -1)
            STAT_SET_INT("H4LOOT_WEED_V", 140000)
            STAT_SET_INT("H4LOOT_COKE_C", 0)
            STAT_SET_INT("H4LOOT_COKE_V", 0)
            STAT_SET_INT("H4LOOT_GOLD_C", 0)
            STAT_SET_INT("H4LOOT_PAINT", 127)
            STAT_SET_INT("H4LOOT_PAINT_V", 190000)
            STAT_SET_INT("H4LOOT_CASH_C_SCOPED", 0)
            STAT_SET_INT("H4LOOT_WEED_C_SCOPED", -1)
            STAT_SET_INT("H4LOOT_COKE_C_SCOPED", 0)
            STAT_SET_INT("H4LOOT_GOLD_C_SCOPED", 0)
            STAT_SET_INT("H4LOOT_PAINT_SCOPED", 127)
        elseif index == 4 then 
            STAT_SET_INT("H4LOOT_CASH_C", 0)
            STAT_SET_INT("H4LOOT_CASH_V", 0)
            STAT_SET_INT("H4LOOT_WEED_C", 0)
            STAT_SET_INT("H4LOOT_WEED_V", 0)
            STAT_SET_INT("H4LOOT_COKE_C", -1)
            STAT_SET_INT("H4LOOT_COKE_V", 210000)
            STAT_SET_INT("H4LOOT_GOLD_C", 0)
            STAT_SET_INT("H4LOOT_PAINT", 127)
            STAT_SET_INT("H4LOOT_PAINT_V", 190000)
            STAT_SET_INT("H4LOOT_CASH_C_SCOPED", 0)
            STAT_SET_INT("H4LOOT_WEED_C_SCOPED", 0)
            STAT_SET_INT("H4LOOT_COKE_C_SCOPED", -1)
            STAT_SET_INT("H4LOOT_GOLD_C_SCOPED", 0)
            STAT_SET_INT("H4LOOT_PAINT_SCOPED", 127)
        elseif index == 5 then 
            STAT_SET_INT("H4LOOT_CASH_C", 0)
            STAT_SET_INT("H4LOOT_CASH_V", 0)
            STAT_SET_INT("H4LOOT_WEED_C", 0)
            STAT_SET_INT("H4LOOT_WEED_V", 0)
            STAT_SET_INT("H4LOOT_COKE_C", 0)
            STAT_SET_INT("H4LOOT_COKE_V", 0)
            STAT_SET_INT("H4LOOT_GOLD_C", -1)
            STAT_SET_INT("H4LOOT_GOLD_V", 320000)
            STAT_SET_INT("H4LOOT_PAINT", 127)
            STAT_SET_INT("H4LOOT_PAINT_V", 190000)
            STAT_SET_INT("H4LOOT_CASH_C_SCOPED", -1)
            STAT_SET_INT("H4LOOT_WEED_C_SCOPED", 0)
            STAT_SET_INT("H4LOOT_COKE_C_SCOPED", 0)
            STAT_SET_INT("H4LOOT_GOLD_C_SCOPED", 0)
            STAT_SET_INT("H4LOOT_PAINT_SCOPED", 127)
        elseif index == 6 then 
            STAT_SET_INT("H4LOOT_CASH_C", 0)
            STAT_SET_INT("H4LOOT_CASH_V", 0)
            STAT_SET_INT("H4LOOT_WEED_C", 0)
            STAT_SET_INT("H4LOOT_WEED_V", 0)
            STAT_SET_INT("H4LOOT_COKE_C", 0)
            STAT_SET_INT("H4LOOT_COKE_V", 0)
            STAT_SET_INT("H4LOOT_GOLD_C", 0)
            STAT_SET_INT("H4LOOT_GOLD_V", 0)
            STAT_SET_INT("H4LOOT_CASH_C_SCOPED", 0)
            STAT_SET_INT("H4LOOT_WEED_C_SCOPED", 0)
            STAT_SET_INT("H4LOOT_COKE_C_SCOPED", 0)
            STAT_SET_INT("H4LOOT_GOLD_C_SCOPED", 0)
            STAT_SET_INT("H4LOOT_PAINT", 127)
            STAT_SET_INT("H4LOOT_PAINT_V", 190000)
            STAT_SET_INT("H4LOOT_PAINT_SCOPED", 127)
        elseif index == 7 then
            STAT_SET_INT("H4LOOT_PAINT", 0)
            STAT_SET_INT("H4LOOT_PAINT_V", 0)
            STAT_SET_INT("H4LOOT_PAINT_SCOPED", 0)
        elseif index == 8 then
            STAT_SET_INT("H4LOOT_CASH_C", 0)
            STAT_SET_INT("H4LOOT_WEED_C", 0)
            STAT_SET_INT("H4LOOT_COKE_C", 0)
            STAT_SET_INT("H4LOOT_GOLD_C", 0)
            STAT_SET_INT("H4LOOT_CASH_C_SCOPED", 0)
            STAT_SET_INT("H4LOOT_WEED_C_SCOPED", 0)
            STAT_SET_INT("H4LOOT_COKE_C_SCOPED", 0)
            STAT_SET_INT("H4LOOT_GOLD_C_SCOPED", 0)
            STAT_SET_INT("H4LOOT_PAINT", 0)
            STAT_SET_INT("H4LOOT_PAINT_SCOPED", 0)
        end

        menu.trigger_commands("hccprefreshboard")
    end)

    menu.list_action(PERICO_HEIST, TRANSLATE("Weapon Loadouts"), {"hccpweapon"}, "", {
        { TRANSLATE("Aggressor"), {"aggeressor"}, TRANSLATE("- Assault Shotgun + Machine Pistol") .. "\n" .. TRANSLATE("- Machete + Grenade") },
        { TRANSLATE("Conspirator"), {"conspirator"}, TRANSLATE("- Military Rifle + Pistol .50") .. "\n" .. TRANSLATE("- Knuckle Duster + Sticky Bombs") },
        { TRANSLATE("Crackshot"), {"crackshot"}, TRANSLATE("- Sniper Rifle + AP Pistol") .. "\n" .. TRANSLATE("- Knife + Molotov") },
        { TRANSLATE("Saboteur"), {"saboteur"}, TRANSLATE("- SMG Mk2 + SNS Pistol Mk2") .. "\n" .. TRANSLATE("- Knife + Pipe Bomb") },
        { TRANSLATE("Marksman"), {"marksman"}, TRANSLATE("- Assault Rifle Mk2 + Pistol Mk2") .. "\n" .. TRANSLATE("- Machete + Pipe Bomb") },
    }, function(index)
        STAT_SET_INT("H4CNF_WEAPONS", index)
        menu.trigger_commands("hccprefreshboard")
    end)

    menu.list_action(PERICO_HEIST, TRANSLATE("Equipment Spawn Location"), {"hccpequipment"}, "", { 
        { TRANSLATE("Airport"), {"airport"}, TRANSLATE("- Guard Clothing") .. "\n" .. TRANSLATE("- Bolt Cutters") },
        { TRANSLATE("Docks"), {"dock"}, TRANSLATE("- Guard Clothing") .. "\n" .. TRANSLATE("- Bolt Cutters") },
        { TRANSLATE("Compound"), {"compound"}, TRANSLATE("- Guard Clothing") .. "\n" .. TRANSLATE("- Bolt Cutters") },
    }, function(index)
        if index == 1 then
            STAT_SET_INT("H4CNF_GRAPPEL", 2022)
            STAT_SET_INT("H4CNF_UNIFORM", 12)
            STAT_SET_INT("H4CNF_BOLTCUT", 4161)
            STAT_SET_INT("H4CNF_TROJAN", 1)
        elseif index == 2 then
            STAT_SET_INT("H4CNF_GRAPPEL", 3671)
            STAT_SET_INT("H4CNF_UNIFORM", 5256)
            STAT_SET_INT("H4CNF_BOLTCUT", 4424)
            STAT_SET_INT("H4CNF_TROJAN", 2)
        elseif index == 3 then
            STAT_SET_INT("H4CNF_GRAPPEL", 85324)
            STAT_SET_INT("H4CNF_UNIFORM", 61034)
            STAT_SET_INT("H4CNF_BOLTCUT", 4612)
            STAT_SET_INT("H4CNF_TROJAN", 5)
        end

        menu.trigger_commands("hccprefreshboard")
    end)

    menu.list_action(PERICO_HEIST, TRANSLATE("Supply Truck Location"), {"hccptruck"}, "", {
        { TRANSLATE("Airport"), {"airport"}, "" },
        { TRANSLATE("North Dock"), {"ndock"}, "" },
        { TRANSLATE("Main Dock (East)"), {"edock"}, "" },
        { TRANSLATE("Main Dock (West)"), {"wdock"}, "" },
        { TRANSLATE("Compound"), {"compound"}, "" },
    }, function(index)
        STAT_SET_INT("H4CNF_TROJAN", index)
        menu.trigger_commands("hccprefreshboard")
    end)

    menu.list_action(PERICO_HEIST, TRANSLATE("Heist Difficulty"), {"hccpdifficulty"}, "", {
        { TRANSLATE("Normal"), {"normal"}, "" },
        { TRANSLATE("Hard"), {"hard"}, "" },
    }, function(index)
        if index == 1 then
            STAT_SET_INT("H4_PROGRESS", 126823)
        elseif index == 2 then
            STAT_SET_INT("H4_PROGRESS", 131055)
        end

        menu.trigger_commands("hccprefreshboard")
    end)

    CP_MORE_OPTIONS = menu.list(PERICO_HEIST, TRANSLATE("Others"), {}, "", function(); end)

        menu.action(CP_MORE_OPTIONS, TRANSLATE("Complete All Prep Missions"), {}, "", function()
            STAT_SET_INT("H4_MISSIONS", -1)
            STAT_SET_INT("H4CNF_APPROACH", -1)
            STAT_SET_INT("H4CNF_BS_ENTR", 63)
            STAT_SET_INT("H4CNF_BS_GEN", 63)
            STAT_SET_INT("H4CNF_WEP_DISRP", 3)
            STAT_SET_INT("H4CNF_ARM_DISRP", 3)
            STAT_SET_INT("H4CNF_HEL_DISRP", 3)

            menu.trigger_commands("hccprefreshboard")
        end)

        menu.action(CP_MORE_OPTIONS, TRANSLATE("Set Heist to Default (Reset)"), {"hccpreset"}, "", function()
            STAT_SET_INT("H4_MISSIONS", 0)
            STAT_SET_INT("H4_PROGRESS", 0)
            STAT_SET_INT("H4CNF_APPROACH", 0)
            STAT_SET_INT("H4CNF_BS_ENTR", 0)
            STAT_SET_INT("H4CNF_BS_GEN", 0)
            STAT_SET_INT("H4_PLAYTHROUGH_STATUS", 0)
            STAT_SET_INT("H4CNF_TARGET", -1)

            menu.trigger_commands("hccprefreshboard")
        end)

    ---

---


--- Diamond Casino Heist

    util.create_tick_handler(function() -- Found by me in gb_casino_heist_planning.c, for after launching the heist, in Board 3, these are required to work 'Makes Forced Able To Launch' feature
        if IS_WORKING(false) ~= "" then return end
        if not util.is_session_started() then return end
        if NETWORK.NETWORK_IS_ACTIVITY_SESSION() then
            for i = 1022, 1025 do
                SET_INT_GLOBAL(1971696 + 1497 + i, 1) -- Forced checked Entrance, Exit, Buyer, and Entry Disguise
            end
        end
    end)

    CASINO_PRESETS = menu.list(CASINO_HEIST, TRANSLATE("Automated Presets"), {}, TRANSLATE("Entrance and Exit will be selected 'Staff Lobby' and Buyer will be selected 'Low' by HC. But, selected Buyer won't be visible at the board somehow, don't change those options when you are before launching the heist.") .. "\n\n" .. TRANSLATE("Please don't forget that buyer should be selected 'Low'! Otherwise, won't get money."), function(); end)

        CASINO_PRESETS_DIAMOND = menu.list(CASINO_PRESETS, TRANSLATE("Diamonds"), {}, TRANSLATE("If the Heist Planning (Board 3) is empty, then please re-enable the preset that you enabled!"), function(); end)

            DIAMOND_SS = menu.toggle(CASINO_PRESETS_DIAMOND, TRANSLATE("Silent & Sneaky Approach"), {"hccahdiasil"}, IS_WORKING(false), function()
                if menu.get_value(DIAMOND_SS) then
                    menu.trigger_commands("hccahbuyer low"); util.yield_once()
                    menu.trigger_commands("hccahentrance stafflobby"); util.yield_once()
                    menu.trigger_commands("hccahexit stafflobby"); util.yield_once()

                    STAT_SET_INT("H3_COMPLETEDPOSIX", -1)
                    STAT_SET_INT("H3OPT_MASKS", 4)
                    STAT_SET_INT("H3OPT_WEAPS", 1)
                    STAT_SET_INT("H3OPT_VEHS", 3)
                    STAT_SET_INT("CAS_HEIST_FLOW", -1)
                    STAT_SET_INT("H3_LAST_APPROACH", 0)
                    STAT_SET_INT("H3OPT_APPROACH", 1)
                    STAT_SET_INT("H3_HARD_APPROACH", 0)
                    STAT_SET_INT("H3OPT_TARGET", 3)
                    STAT_SET_INT("H3OPT_POI", 1023)
                    STAT_SET_INT("H3OPT_ACCESSPOINTS", 2047)
                    STAT_SET_INT("H3OPT_CREWWEAP", 4)
                    STAT_SET_INT("H3OPT_CREWDRIVER", 3)
                    STAT_SET_INT("H3OPT_CREWHACKER", 4)
                    STAT_SET_INT("H3OPT_DISRUPTSHIP", 3)
                    STAT_SET_INT("H3OPT_BODYARMORLVL", -1)
                    STAT_SET_INT("H3OPT_KEYLEVELS", 2)
                    STAT_SET_INT("H3OPT_BITSET1", 127)
                    STAT_SET_INT("H3OPT_BITSET0", 262270)

                    menu.trigger_commands("hccahrefreshboards")

                    for i = 1, #CasinoPresetLists do
                        if CasinoPresetLists[i][1] == DIAMOND_SS then
                            CasinoPresetLists[i][2] = true
                        end
                    end
                    for i = 1, #ForCasinoPresets do
                        menu.set_help_text(ForCasinoPresets[i][1], TRANSLATE("This feature has been controlled by another feature.") .. "\n" .. "- " .. menu.get_menu_name(CASINO_PRESETS) .. " > " .. menu.get_menu_name(menu.get_parent(DIAMOND_SS)) .. " > " .. menu.get_menu_name(DIAMOND_SS))
                    end
                else
                    for i = 1, #CasinoPresetLists do
                        if CasinoPresetLists[i][1] == DIAMOND_SS then
                            CasinoPresetLists[i][2] = false
                        end
                    end
                    for i = 1, #ForCasinoPresets do
                        menu.apply_default_state(ForCasinoPresets[i][1])
                        menu.set_help_text(ForCasinoPresets[i][1], ForCasinoPresets[i][3])
                    end
                end

                while menu.get_value(DIAMOND_SS) do
                    SET_INT_GLOBAL(262145 + 28808, 1410065408) -- 1277889925
                    for i = 1, #ForCasinoPresets do
                        menu.set_value(ForCasinoPresets[i][1], ForCasinoPresets[i][2])
                    end

                    util.yield_once()
                end
            end)

            DIAMOND_BA = menu.toggle(CASINO_PRESETS_DIAMOND, TRANSLATE("BigCon Approach"), {"hccahdiabig"}, IS_WORKING(false), function()
                if menu.get_value(DIAMOND_BA) then
                    menu.trigger_commands("hccahbuyer low"); util.yield_once()
                    menu.trigger_commands("hccahentrance stafflobby"); util.yield_once()
                    menu.trigger_commands("hccahexit stafflobby"); util.yield_once()
                    menu.trigger_commands("hccahentrydisguise bugstars"); util.yield_once()
                    menu.trigger_commands("hccahexitdisguise noose"); util.yield_once()

                    STAT_SET_INT("H3_COMPLETEDPOSIX", -1)
                    STAT_SET_INT("H3OPT_MASKS", 2)
                    STAT_SET_INT("H3OPT_WEAPS", 1)
                    STAT_SET_INT("H3OPT_VEHS", 3)
                    STAT_SET_INT("CAS_HEIST_FLOW", -1)
                    STAT_SET_INT("H3_LAST_APPROACH", 0)
                    STAT_SET_INT("H3OPT_APPROACH", 2)
                    STAT_SET_INT("H3_HARD_APPROACH", 0)
                    STAT_SET_INT("H3OPT_TARGET", 3)
                    STAT_SET_INT("H3OPT_POI", 1023)
                    STAT_SET_INT("H3OPT_ACCESSPOINTS", 2047)
                    STAT_SET_INT("H3OPT_CREWWEAP", 4)
                    STAT_SET_INT("H3OPT_CREWDRIVER", 3)
                    STAT_SET_INT("H3OPT_CREWHACKER", 4)
                    STAT_SET_INT("H3OPT_DISRUPTSHIP", 3)
                    STAT_SET_INT("H3OPT_BODYARMORLVL", -1)
                    STAT_SET_INT("H3OPT_KEYLEVELS", 2)
                    STAT_SET_INT("H3OPT_BITSET1", 159)
                    STAT_SET_INT("H3OPT_BITSET0", 524118)

                    menu.trigger_commands("hccahrefreshboards")

                    for i = 1, #CasinoPresetLists do
                        if CasinoPresetLists[i][1] == DIAMOND_BA then
                            CasinoPresetLists[i][2] = true
                        end
                    end
                    for i = 1, #ForCasinoPresets do
                        menu.set_help_text(ForCasinoPresets[i][1], TRANSLATE("This feature has been controlled by another feature.") .. "\n" .. "- " .. menu.get_menu_name(CASINO_PRESETS) .. " > " .. menu.get_menu_name(menu.get_parent(DIAMOND_BA)) .. " > " .. menu.get_menu_name(DIAMOND_BA))
                    end
                else
                    for i = 1, #CasinoPresetLists do
                        if CasinoPresetLists[i][1] == DIAMOND_BA then
                            CasinoPresetLists[i][2] = false
                        end
                    end
                    for i = 1, #ForCasinoPresets do
                        menu.apply_default_state(ForCasinoPresets[i][1])
                        menu.set_help_text(ForCasinoPresets[i][1], ForCasinoPresets[i][3])
                    end
                end

                while menu.get_value(DIAMOND_BA) do
                    SET_INT_GLOBAL(262145 + 28808, 1410065408)
                    for i = 1, #ForCasinoPresets do
                        menu.set_value(ForCasinoPresets[i][1], ForCasinoPresets[i][2])
                    end

                    util.yield_once()
                end
            end)

            DIAMOND_AA = menu.toggle(CASINO_PRESETS_DIAMOND, TRANSLATE("Aggressive Approach"), {"hccahdiaagg"}, IS_WORKING(false), function()
                if menu.get_value(DIAMOND_AA) then
                    menu.trigger_commands("hccahbuyer low"); util.yield_once()
                    menu.trigger_commands("hccahentrance stafflobby"); util.yield_once()
                    menu.trigger_commands("hccahexit stafflobby"); util.yield_once()

                    STAT_SET_INT("H3_COMPLETEDPOSIX", -1)
                    STAT_SET_INT("H3OPT_MASKS", 4)
                    STAT_SET_INT("H3OPT_WEAPS", 1)
                    STAT_SET_INT("H3OPT_VEHS", 3)
                    STAT_SET_INT("CAS_HEIST_FLOW", -1)
                    STAT_SET_INT("H3_LAST_APPROACH", 0)
                    STAT_SET_INT("H3OPT_APPROACH", 3)
                    STAT_SET_INT("H3_HARD_APPROACH", 0)
                    STAT_SET_INT("H3OPT_TARGET", 3)
                    STAT_SET_INT("H3OPT_POI", 1023)
                    STAT_SET_INT("H3OPT_ACCESSPOINTS", 2047)
                    STAT_SET_INT("H3OPT_CREWWEAP", 4)
                    STAT_SET_INT("H3OPT_CREWDRIVER", 3)
                    STAT_SET_INT("H3OPT_CREWHACKER", 4)
                    STAT_SET_INT("H3OPT_DISRUPTSHIP", 3)
                    STAT_SET_INT("H3OPT_BODYARMORLVL", -1)
                    STAT_SET_INT("H3OPT_KEYLEVELS", 2)
                    STAT_SET_INT("H3OPT_BITSET1", 799)
                    STAT_SET_INT("H3OPT_BITSET0", 3670102)

                    menu.trigger_commands("hccahrefreshboards")

                    for i = 1, #CasinoPresetLists do
                        if CasinoPresetLists[i][1] == DIAMOND_AA then
                            CasinoPresetLists[i][2] = true
                        end
                    end
                    for i = 1, #ForCasinoPresets do
                        menu.set_help_text(ForCasinoPresets[i][1], TRANSLATE("This feature has been controlled by another feature.") .. "\n" .. "- " .. menu.get_menu_name(CASINO_PRESETS) .. " > " .. menu.get_menu_name(menu.get_parent(DIAMOND_AA)) .. " > " .. menu.get_menu_name(DIAMOND_AA))
                    end
                else
                    for i = 1, #CasinoPresetLists do
                        if CasinoPresetLists[i][1] == DIAMOND_AA then
                            CasinoPresetLists[i][2] = false
                        end
                    end
                    for i = 1, #ForCasinoPresets do
                        menu.apply_default_state(ForCasinoPresets[i][1])
                        menu.set_help_text(ForCasinoPresets[i][1], ForCasinoPresets[i][3])
                    end
                end

                while menu.get_value(DIAMOND_AA) do
                    SET_INT_GLOBAL(262145 + 28808, 1410065408) -- 1410065408
                    for i = 1, #ForCasinoPresets do
                        menu.set_value(ForCasinoPresets[i][1], ForCasinoPresets[i][2])
                    end

                    util.yield_once()
                end
            end)

        ---

        CASINO_PRESETS_GOLD = menu.list(CASINO_PRESETS, TRANSLATE("Gold"), {}, TRANSLATE("If the Heist Planning (Board 3) is empty, then please re-enable the preset that you enabled!"), function(); end)

            GOLD_SS = menu.toggle(CASINO_PRESETS_GOLD, TRANSLATE("Silent & Sneaky Approach"), {"hccahgoldsil"}, IS_WORKING(false), function()
                if menu.get_value(GOLD_SS) then
                    menu.trigger_commands("hccahbuyer low"); util.yield_once()
                    menu.trigger_commands("hccahentrance stafflobby"); util.yield_once()
                    menu.trigger_commands("hccahexit stafflobby"); util.yield_once()

                    STAT_SET_INT("H3_COMPLETEDPOSIX", -1)
                    STAT_SET_INT("H3OPT_MASKS", 9)
                    STAT_SET_INT("H3OPT_WEAPS", 1)
                    STAT_SET_INT("H3OPT_VEHS", 3)
                    STAT_SET_INT("CAS_HEIST_FLOW", -1)
                    STAT_SET_INT("H3_LAST_APPROACH", 0)
                    STAT_SET_INT("H3OPT_APPROACH", 1)
                    STAT_SET_INT("H3_HARD_APPROACH", 0)
                    STAT_SET_INT("H3OPT_TARGET", 1)
                    STAT_SET_INT("H3OPT_POI", 1023)
                    STAT_SET_INT("H3OPT_ACCESSPOINTS", 2047)
                    STAT_SET_INT("H3OPT_CREWWEAP", 4)
                    STAT_SET_INT("H3OPT_CREWDRIVER", 3)
                    STAT_SET_INT("H3OPT_CREWHACKER", 4)
                    STAT_SET_INT("H3OPT_DISRUPTSHIP", 3)
                    STAT_SET_INT("H3OPT_BODYARMORLVL", -1)
                    STAT_SET_INT("H3OPT_KEYLEVELS", 2)
                    STAT_SET_INT("H3OPT_BITSET1", 127)
                    STAT_SET_INT("H3OPT_BITSET0", 262270)

                    menu.trigger_commands("hccahrefreshboards")

                    for i = 1, #CasinoPresetLists do
                        if CasinoPresetLists[i][1] == GOLD_SS then
                            CasinoPresetLists[i][2] = true
                        end
                    end
                    for i = 1, #ForCasinoPresets do
                        menu.set_help_text(ForCasinoPresets[i][1], TRANSLATE("This feature has been controlled by another feature.") .. "\n" .. "- " .. menu.get_menu_name(CASINO_PRESETS) .. " > " .. menu.get_menu_name(menu.get_parent(GOLD_SS)) .. " > " .. menu.get_menu_name(GOLD_SS))
                    end
                else
                    for i = 1, #CasinoPresetLists do
                        if CasinoPresetLists[i][1] == GOLD_SS then
                            CasinoPresetLists[i][2] = false
                        end
                    end
                    for i = 1, #ForCasinoPresets do
                        menu.apply_default_state(ForCasinoPresets[i][1])
                        menu.set_help_text(ForCasinoPresets[i][1], ForCasinoPresets[i][3])
                    end
                end

                while menu.get_value(GOLD_SS) do
                    SET_INT_GLOBAL(262145 + 28807, 1410065408) -- -582734553
                    for i = 1, #ForCasinoPresets do
                        menu.set_value(ForCasinoPresets[i][1], ForCasinoPresets[i][2])
                    end

                    util.yield_once()
                end
            end)

            GOLD_BA = menu.toggle(CASINO_PRESETS_GOLD, TRANSLATE("BigCon Approach"), {"hccahgoldbig"}, IS_WORKING(false), function()
                if menu.get_value(GOLD_BA) then
                    menu.trigger_commands("hccahbuyer low"); util.yield_once()
                    menu.trigger_commands("hccahentrance stafflobby"); util.yield_once()
                    menu.trigger_commands("hccahexit stafflobby"); util.yield_once()
                    menu.trigger_commands("hccahentrydisguise bugstars"); util.yield_once()
                    menu.trigger_commands("hccahexitdisguise noose"); util.yield_once()

                    STAT_SET_INT("H3_COMPLETEDPOSIX", -1)
                    STAT_SET_INT("H3OPT_MASKS", 9)
                    STAT_SET_INT("H3OPT_WEAPS", 1)
                    STAT_SET_INT("H3OPT_VEHS", 3)
                    STAT_SET_INT("CAS_HEIST_FLOW", -1)
                    STAT_SET_INT("H3_LAST_APPROACH", 0)
                    STAT_SET_INT("H3OPT_APPROACH", 2)
                    STAT_SET_INT("H3_HARD_APPROACH", 0)
                    STAT_SET_INT("H3OPT_TARGET", 1)
                    STAT_SET_INT("H3OPT_POI", 1023)
                    STAT_SET_INT("H3OPT_ACCESSPOINTS", 2047)
                    STAT_SET_INT("H3OPT_CREWWEAP", 4)
                    STAT_SET_INT("H3OPT_CREWDRIVER", 3)
                    STAT_SET_INT("H3OPT_CREWHACKER", 4)
                    STAT_SET_INT("H3OPT_DISRUPTSHIP", 3)
                    STAT_SET_INT("H3OPT_BODYARMORLVL", -1)
                    STAT_SET_INT("H3OPT_KEYLEVELS", 2)
                    STAT_SET_INT("H3OPT_BITSET1", 159)
                    STAT_SET_INT("H3OPT_BITSET0", 524118)

                    menu.trigger_commands("hccahrefreshboards")

                    for i = 1, #CasinoPresetLists do
                        if CasinoPresetLists[i][1] == GOLD_BA then
                            CasinoPresetLists[i][2] = true
                        end
                    end
                    for i = 1, #ForCasinoPresets do
                        menu.set_help_text(ForCasinoPresets[i][1], TRANSLATE("This feature has been controlled by another feature.") .. "\n" .. "- " .. menu.get_menu_name(CASINO_PRESETS) .. " > " .. menu.get_menu_name(menu.get_parent(GOLD_BA)) .. " > " .. menu.get_menu_name(GOLD_BA))
                    end
                else
                    for i = 1, #CasinoPresetLists do
                        if CasinoPresetLists[i][1] == GOLD_BA then
                            CasinoPresetLists[i][2] = false
                        end
                    end
                    for i = 1, #ForCasinoPresets do
                        menu.apply_default_state(ForCasinoPresets[i][1])
                        menu.set_help_text(ForCasinoPresets[i][1], ForCasinoPresets[i][3])
                    end
                end

                while menu.get_value(GOLD_BA) do
                    SET_INT_GLOBAL(262145 + 28807, 1410065408)
                    for i = 1, #ForCasinoPresets do
                        menu.set_value(ForCasinoPresets[i][1], ForCasinoPresets[i][2])
                    end

                    util.yield_once()
                end
            end)

            GOLD_AA = menu.toggle(CASINO_PRESETS_GOLD, TRANSLATE("Aggressive Approach"), {"hccahgoldagg"}, IS_WORKING(false), function()
                if menu.get_value(GOLD_AA) then
                    menu.trigger_commands("hccahbuyer low"); util.yield_once()
                    menu.trigger_commands("hccahentrance stafflobby"); util.yield_once()
                    menu.trigger_commands("hccahexit stafflobby"); util.yield_once()

                    STAT_SET_INT("H3_COMPLETEDPOSIX", -1)
                    STAT_SET_INT("H3OPT_MASKS", 4)
                    STAT_SET_INT("H3OPT_WEAPS", 1)
                    STAT_SET_INT("CAS_HEIST_FLOW", -1)
                    STAT_SET_INT("H3OPT_APPROACH", 3)
                    STAT_SET_INT("H3OPT_TARGET", 1)
                    STAT_SET_INT("H3OPT_POI", 1023)
                    STAT_SET_INT("H3OPT_ACCESSPOINTS", 2047)
                    STAT_SET_INT("H3OPT_DISRUPTSHIP", 3)
                    STAT_SET_INT("H3OPT_BODYARMORLVL", -1)
                    STAT_SET_INT("H3OPT_KEYLEVELS", 2)
                    STAT_SET_INT("H3OPT_CREWWEAP", 4)
                    STAT_SET_INT("H3OPT_CREWDRIVER", 3)
                    STAT_SET_INT("H3OPT_CREWHACKER", 4)
                    STAT_SET_INT("H3OPT_BITSET1", 799)
                    STAT_SET_INT("H3OPT_BITSET0", 3670102)
                    STAT_SET_INT("H3_HARD_APPROACH", 0)
                    STAT_SET_INT("H3OPT_VEHS", 3)

                    menu.trigger_commands("hccahrefreshboards")

                    for i = 1, #CasinoPresetLists do
                        if CasinoPresetLists[i][1] == GOLD_AA then
                            CasinoPresetLists[i][2] = true
                        end
                    end
                    for i = 1, #ForCasinoPresets do
                        menu.set_help_text(ForCasinoPresets[i][1], TRANSLATE("This feature has been controlled by another feature.") .. "\n" .. "- " .. menu.get_menu_name(CASINO_PRESETS) .. " > " .. menu.get_menu_name(menu.get_parent(GOLD_AA)) .. " > " .. menu.get_menu_name(GOLD_AA))
                    end
                else
                    for i = 1, #CasinoPresetLists do
                        if CasinoPresetLists[i][1] == GOLD_AA then
                            CasinoPresetLists[i][2] = false
                        end
                    end
                    for i = 1, #ForCasinoPresets do
                        menu.apply_default_state(ForCasinoPresets[i][1])
                        menu.set_help_text(ForCasinoPresets[i][1], ForCasinoPresets[i][3])
                    end
                end

                while menu.get_value(GOLD_AA) do
                    SET_INT_GLOBAL(262145 + 28807, 1410065408)
                    for i = 1, #ForCasinoPresets do
                        menu.set_value(ForCasinoPresets[i][1], ForCasinoPresets[i][2])
                    end

                    util.yield_once()
                end
            end)

        ---

    ---

    CAH_ADVCED = menu.list(CASINO_HEIST, TRANSLATE("Advanced Features"), {}, "", function(); end)
    
        CAH_PLAYER_CUT = menu.list(CAH_ADVCED, TRANSLATE("Player's Cut"), {}, TRANSLATE("Don't forget changing this feature before starting the heist! Otherwise, won't be applied."), function(); end)

            CAH_NON_HOST = menu.list(CAH_PLAYER_CUT, TRANSLATE("Your Cut (Non-Host)"), {}, TRANSLATE("Note that modifying this won't applied to the heist board. You can check the applied cut after end of the heist."), function(); end)

                CAH_NON_HOST_CUT_LOOP = menu.toggle_loop(CAH_NON_HOST, TRANSLATE("Enable"), {"hccahnonhostloop"}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(2684801 + 6589, menu.get_value(CAH_NON_HOST_CUT)) -- gb_casino_heist_planning.c
                end, function()
                    SET_INT_GLOBAL(2684801 + 6589, menu.get_default_state(CAH_NON_HOST_CUT))
                end)

                CAH_NON_HOST_CUT = menu.slider(CAH_NON_HOST, TRANSLATE("Custom Percentage"), {"hccahnonhost"}, "(%)", 0, 1000, 100, 5, function(); end)

            ---

            CAH_HOST = menu.list(CAH_PLAYER_CUT, TRANSLATE("Your Cut"), {}, TRANSLATE("Only works if you are host of the heist."), function(); end)

            CAH_HOST_CUT_LOOP = menu.toggle_loop(CAH_HOST, TRANSLATE("Enable"), {"hccah1pcutloop"}, IS_WORKING(false), function()
                SET_INT_GLOBAL(1971696 + 1497 + 736 + 92 + 1, menu.get_value(CAH_HOST_CUT)) -- gb_casino_heist_planning.c
            end, function()
                SET_INT_GLOBAL(1971696 + 1497 + 736 + 92 + 1, menu.get_default_state(CAH_HOST_CUT))
            end)

                CAH_HOST_CUT = menu.slider(CAH_HOST, TRANSLATE("Custom Percentage"), {"hccah1pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

            ---

            CAH_2P = menu.list(CAH_PLAYER_CUT, TRANSLATE("Player 2"), {}, TRANSLATE("Only works if you are host of the heist."), function(); end)

            CAH_2P_CUT_LOOP = menu.toggle_loop(CAH_2P, TRANSLATE("Enable"), {"hccah2pcutloop"}, IS_WORKING(false), function()
                SET_INT_GLOBAL(1971696 + 1497 + 736 + 92 + 2, menu.get_value(CAH_2P_CUT)) -- gb_casino_heist_planning.c
            end, function()
                SET_INT_GLOBAL(1971696 + 1497 + 736 + 92 + 2, menu.get_default_state(CAH_2P_CUT))
            end)

                CAH_2P_CUT = menu.slider(CAH_2P, TRANSLATE("Custom Percentage"), {"hccah2pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

            ---

            CAH_3P = menu.list(CAH_PLAYER_CUT, TRANSLATE("Player 3"), {}, TRANSLATE("Only works if you are host of the heist."), function(); end)

            CAH_3P_CUT_LOOP = menu.toggle_loop(CAH_3P, TRANSLATE("Enable"), {"hccah3pcutloop"}, IS_WORKING(false), function()
                SET_INT_GLOBAL(1971696 + 1497 + 736 + 92 + 3, menu.get_value(CAH_3P_CUT)) -- gb_casino_heist_planning.c
            end, function()
                SET_INT_GLOBAL(1971696 + 1497 + 736 + 92 + 3, menu.get_default_state(CAH_3P_CUT))
            end)

                CAH_3P_CUT = menu.slider(CAH_3P, TRANSLATE("Custom Percentage"), {"hccah3pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

            ---

            CAH_4P = menu.list(CAH_PLAYER_CUT, TRANSLATE("Player 4"), {}, TRANSLATE("Only works if you are host of the heist."), function(); end)
                
            CAH_4P_CUT_LOOP = menu.toggle_loop(CAH_4P, TRANSLATE("Enable"), {"hccah4pcutloop"}, IS_WORKING(false), function()
                SET_INT_GLOBAL(1971696 + 1497 + 736 + 92 + 4, menu.get_value(CAH_4P_CUT)) -- gb_casino_heist_planning.c
            end, function()
                SET_INT_GLOBAL(1971696 + 1497 + 736 + 92 + 4, menu.get_default_state(CAH_4P_CUT))
            end)

                CAH_4P_CUT = menu.slider(CAH_4P, TRANSLATE("Custom Percentage"), {"hccah4pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

            ---

        ---

        menu.toggle_loop(CAH_ADVCED, TRANSLATE("Skip The Hacking Process"), {}, IS_WORKING(true) .. TRANSLATE("Works On Both: Fingerprint and Keypad"), function()
            if GET_INT_LOCAL("fm_mission_controller", 52962) ~= 1 then -- For Fingerprint, https://www.unknowncheats.me/forum/3418914-post13398.html
                SET_INT_LOCAL("fm_mission_controller", 52962, 5)
            end
            if GET_INT_LOCAL("fm_mission_controller", 54024) ~= 1 then -- For Keypad, https://www.unknowncheats.me/forum/3455828-post8.html
                SET_INT_LOCAL("fm_mission_controller", 54024, 5)
            end
        end)

        menu.action(CAH_ADVCED, TRANSLATE("Skip Drilling The Vault Door"), {"hccahinsvault"}, IS_WORKING(false), function() -- https://www.unknowncheats.me/forum/3418914-post13398.html
            SET_INT_LOCAL("fm_mission_controller", 10098 + 7, GET_INT_LOCAL("fm_mission_controller", 10098 + 37))
        end)

        menu.action(CAH_ADVCED, TRANSLATE("Makes Forced Able To Launch"), {"hccahforcedlaunch"}, IS_WORKING(true) .. TRANSLATE("When you are at the board you select players cut, this feature will allow you forced start even other players don't set as ready. There's visual bug related the payout."), function()
            for i = 0, 3 do
                SET_INT_GLOBAL(1971696 + 1497 + 736 + 87 + i, -1) -- Found by me in gb_casino_heist_planning.c
            end
            menu.trigger_commands("hccahrefreshboards")
        end)

        menu.action(CAH_ADVCED, TRANSLATE("Refresh Arcade Boards"), {"hccahrefreshboards"}, TRANSLATE("You can update casino heist stats while even you in the arcade."), function()
            local Bitset0 = STAT_GET_INT("H3OPT_BITSET0")
            local Bitset1 = STAT_GET_INT("H3OPT_BITSET1")
            STAT_SET_INT("H3OPT_BITSET0", math.random(INT_MAX))
            STAT_SET_INT("H3OPT_BITSET1", math.random(INT_MAX))
            util.yield_once()
            STAT_SET_INT("H3OPT_BITSET0", Bitset0)
            STAT_SET_INT("H3OPT_BITSET1", Bitset1)
        end)

    ---

    TELEPORT_CAH = menu.list(CASINO_HEIST, TRANSLATE("Teleport Places"), {}, TRANSLATE("- How to change the line color: Stand > Settings > Appearance > Colours > HUD Colour") .. "\n\n" .. TRANSLATE("- How to change the AR Beacon color: Stand > Settings > Appearance > Colours > AR Colour"), function(); end)

        ArcadePos, ArcadeHeading = nil, nil
        util.create_tick_handler(function()
            if IS_IN_ARCADE() then return end

            local Blip = HUD.GET_FIRST_BLIP_INFO_ID(740) -- Arcade Blip
            local Pos = HUD.GET_BLIP_COORDS(Blip)
            local Zone = ZONE.GET_NAME_OF_ZONE(Pos.x, Pos.y, Pos.z)
            local Label = util.get_label_text(Zone)
            local Arcades = { -- { arcade_name, pos, heading }
                { util.get_label_text("MP_ARC_1"), v3.new(-245.9931, 6210.773, 31.939024), -50 }, -- Pixel Pete's - Paleto Bay
                { util.get_label_text("MP_ARC_2"), v3.new(1695.5393, 4784.196, 41.94444), -95 }, -- Wonderama - Grapeseed
                { util.get_label_text("MP_ARC_3"), v3.new(-115.45246, -1772.0801, 29.858917), -125 }, -- Warehouse - Davis
                { util.get_label_text("FMC_LOC_WSTVNWD"), v3.new(-600.911, 279.97433, 82.041245), 80 }, -- Eight-Bit - Vinewood, West Vinewood
                { util.get_label_text("MP_ARC_5"), v3.new(-1269.7747, -304.4372, 37.001965), 75 }, -- Insert Coin - Rockford Hills
                { util.get_label_text("MP_ARC_6"), v3.new(758.91815, -814.60864, 26.301702), 90 }, -- Videogeddon - La Mesa
            }
            for i = 1, #Arcades do
                if string.contains(Arcades[i][1], Label) then
                    ArcadePos = Arcades[i][2]
                    ArcadeHeading = Arcades[i][3]
                end
            end
        end)

        TELEPORT_CAH_ENTRANCE = menu.action(TELEPORT_CAH, TRANSLATE("Entrance Of Your Arcade"), {}, TRANSLATE("Note that works perfectly when no other players are in your session."), function()
            if ArcadePos and ArcadeHeading ~= nil then
                TELEPORT(ArcadePos.x, ArcadePos.y, ArcadePos.z)
                SET_HEADING(ArcadeHeading)
            else
                NOTIFY(TRANSLATE("Please go out of the current interior to use this feature."))
            end
        end)

        menu.divider(TELEPORT_CAH, TRANSLATE("Inside"))

            TELEPORT_CAH_IN_BOARD = menu.action(TELEPORT_CAH, TRANSLATE("Planning Boards (Arcade)"), {}, TRANSLATE("You should in your arcade to use this teleport!"), function()
                if IS_IN_ARCADE() then
                    TELEPORT(2711.773, -369.458, -54.781)
                else
                    NOTIFY(menu.get_help_text(TELEPORT_CAH_IN_BOARD))
                end
            end)
            TELEPORT_CAH_IN_EXIT = menu.action(TELEPORT_CAH, TRANSLATE("Garage Exit (Arcade)"), {}, TRANSLATE("You should in your arcade to use this teleport!"), function()
                if IS_IN_ARCADE() then
                    TELEPORT(2677.237, -361.494, -55.187)
                else
                    NOTIFY(menu.get_help_text(TELEPORT_CAH_IN_EXIT))
                end
            end)
            TELEPORT_CAH_IN_DISPOSAL = menu.action(TELEPORT_CAH, TRANSLATE("Waste Disposal (Casino)"), {}, "", function()
                TELEPORT(2542.052, -214.3084, -58.722965)
            end)
            TELEPORT_CAH_IN_LOBBY = menu.action(TELEPORT_CAH, TRANSLATE("Staff Lobby (Casino)"), {}, "", function()
                TELEPORT(2547.9192, -273.16754, -58.723003)
            end)
            TELEPORT_CAH_IN_DOOR = menu.action(TELEPORT_CAH, TRANSLATE("Mantrap Door (Casino)"), {}, "", function()
                TELEPORT(2465.4746, -279.2276, -70.694145)
            end)
            TELEPORT_CAH_IN_VAULT_IN = menu.action(TELEPORT_CAH, TRANSLATE("Inside The Vault (Casino)"), {}, "", function()
                TELEPORT(2515.1252, -238.91661, -70.73713)
            end)
            TELEPORT_CAH_IN_VAULT_OUT = menu.action(TELEPORT_CAH, TRANSLATE("Outside The Vault (Casino)"), {}, "", function()
                TELEPORT(2497.5098, -238.50768, -70.7388)
            end)
            TELEPORT_CAH_IN_DAILY_CASH = menu.action(TELEPORT_CAH, TRANSLATE("Daily Cash Storage (Casino)"), {}, "", function()
                TELEPORT(2520.8645, -286.30685, -58.723007)
            end)

        ---

        menu.divider(TELEPORT_CAH, TRANSLATE("Outside"))

            TELEPORT_CAH_OUT_GATE = menu.action(TELEPORT_CAH, TRANSLATE("Main Gate (Casino)"), {}, "", function()
                TELEPORT(917.24634, 48.989567, 80.89892)
            end)
            TELEPORT_CAH_OUT_LOBBY = menu.action(TELEPORT_CAH, TRANSLATE("Staff Lobby (Casino)"), {}, "", function()
                TELEPORT(965.14856, -9.05023, 80.63045)
            end)
            TELEPORT_CAH_OUT_DISPOSAL = menu.action(TELEPORT_CAH, TRANSLATE("Waste Disposal (Casino)"), {}, "", function()
                TELEPORT(997.5346, 84.51491, 80.990555)
            end)

        ---

    ---

    CASINO_BOARD1 = menu.list(CASINO_HEIST, TRANSLATE("Heist Scope Out (Board 1)"), {}, "", function(); end)

        menu.list_action(CASINO_BOARD1, TRANSLATE("Change Approach"), {"hccahapproach"}, "", {
            { TRANSLATE("Silent & Sneaky Approach"), {"silent"}, "" },
            { TRANSLATE("BigCon Approach"), {"bigcon"}, "" },
            { TRANSLATE("Aggressive Approach"), {"aggressive"}, "" },
        }, function(index)
            STAT_SET_INT("H3_LAST_APPROACH", 0)
            STAT_SET_INT("H3OPT_APPROACH", index)
            menu.trigger_commands("hccahrefreshboards")
        end)

        menu.list_action(CASINO_BOARD1, TRANSLATE("Change Difficulty"), {"hccahdifficulty"}, "", {
            { TRANSLATE("Normal"), {"normal"}, "" },
            { TRANSLATE("Hard"), {"hard"}, "" },
        }, function(index)
            if index == 1 then
                STAT_SET_INT("H3_HARD_APPROACH", 0)
            elseif index == 2 then
                for i = 1, 3 do
                    if STAT_GET_INT("H3OPT_APPROACH") == i then
                        STAT_SET_INT("H3_HARD_APPROACH", i)
                    end
                end
            end

            menu.trigger_commands("hccahrefreshboards")
        end)

        menu.list_action(CASINO_BOARD1, TRANSLATE("Change Target"), {"hccahtarget"}, "", {
            { TRANSLATE("Diamonds"), {"diamond"}, "" },
            { TRANSLATE("Gold"), {"gold"}, "" },
            { TRANSLATE("Artwork"), {"artwork"}, "" },
            { TRANSLATE("Cash"), {"cash"}, "" },
        }, function(index)
            if index == 1 then
                STAT_SET_INT("H3OPT_TARGET", 3)
            elseif index == 2 then 
                STAT_SET_INT("H3OPT_TARGET", 1)
            elseif index == 3 then
                STAT_SET_INT("H3OPT_TARGET", 2)
            elseif index == 4 then
                STAT_SET_INT("H3OPT_TARGET", 0)
            end

            menu.trigger_commands("hccahrefreshboards")
        end)

    ---

    CASINO_BOARD2 = menu.list(CASINO_HEIST, TRANSLATE("Heist Perp Work (Board 2)"), {}, "", function(); end)

        menu.list_action(CASINO_BOARD2, TRANSLATE("Change Gunman"), {"hccahgunman"}, "", {
            { TRANSLATE("Chester McCoy"), {"chester"}, "(10% - " .. util.get_label_text("CH_SKILL_EXPR") .. ")" },
            { TRANSLATE("Gustavo Mota"), {"gustavo"}, "(9% - " .. util.get_label_text("CH_SKILL_EXPR") .. ")" },
            { TRANSLATE("Patrick McReary"), {"patrick"}, "(8% - " .. util.get_label_text("CH_SKILL_GOOD") .. ")" },
            { TRANSLATE("Charlie Reed"), {"charlie"}, "(7% - " .. util.get_label_text("CH_SKILL_GOOD") .. ")" },
            { TRANSLATE("Karl Abolaji"), {"karl"}, "(5% - " .. util.get_label_text("CH_SKILL_POOR") .. ")" },
            { TRANSLATE("Random"), {"random"}, "(???%)" },
            { TRANSLATE("Remove"), {"remove"}, "(0%)" },
        }, function(index)
            if index == 1 then
                STAT_SET_INT("H3OPT_CREWWEAP", 4)
            elseif index == 2 then
                STAT_SET_INT("H3OPT_CREWWEAP", 2)
            elseif index == 3 then
                STAT_SET_INT("H3OPT_CREWWEAP", 5)
            elseif index == 4 then
                STAT_SET_INT("H3OPT_CREWWEAP", 3)
            elseif index == 5 then
                STAT_SET_INT("H3OPT_CREWWEAP", 1)
            elseif index == 6 then
                STAT_SET_INT("H3OPT_CREWWEAP", math.random(5))
            elseif index == 7 then
                STAT_SET_INT("H3OPT_CREWWEAP", 6)
            end

            menu.trigger_commands("hccahrefreshboards")
        end)

        menu.list_action(CASINO_BOARD2, TRANSLATE("Weapon Variation"), {"hccahweaponvar"}, "", {
            { TRANSLATE("Best"), {"best"}, "" },
            { TRANSLATE("Worst"), {"worst"}, "" },
        }, function(index)
            if index == 1 then
                STAT_SET_INT("H3OPT_WEAPS", 1)
            elseif index == 2 then
                STAT_SET_INT("H3OPT_WEAPS", 0)
            end

            menu.trigger_commands("hccahrefreshboards")
        end)

        menu.list_action(CASINO_BOARD2, TRANSLATE("Change Driver"), {"hccahdriver"}, "", {
            { TRANSLATE("Chester McCoy"), {"chester"}, "(10% - " .. util.get_label_text("CH_SKILL_EXPR") .. ")" .. "\n\n" .. "- " .. util.get_label_text("CH_VEH_4_04B") .. "\n".. "- " .. util.get_label_text("CH_VEH_4_03B") .. "\n".. "- " .. util.get_label_text("CH_VEH_4_02B") .. "\n".. "- " .. util.get_label_text("CH_VEH_4_01B")  },
            { TRANSLATE("Eddie Toh"), {"eddie"}, "(9% - " .. util.get_label_text("CH_SKILL_EXPR") .. ")" .. "\n\n" .. "- " .. util.get_label_text("CH_VEH_2_04B") .. "\n" .. "- " .. util.get_label_text("CH_VEH_2_03B") .. "\n" .. "- " .. util.get_label_text("CH_VEH_2_02B") .. "\n" .. "- " .. util.get_label_text("CH_VEH_2_01B") },
            { TRANSLATE("Taliana Martinez"), {"taliana"}, "(7% - " .. util.get_label_text("CH_SKILL_GOOD") .. ")" .. "\n\n" .. "- " .. util.get_label_text("CH_VEH_1_04B") .. "\n" .. "- " .. util.get_label_text("CH_VEH_1_03B") .. "\n" .. "- " .. util.get_label_text("CH_VEH_1_02B") .. "\n" .. "- " .. util.get_label_text("CH_VEH_1_01B") },
            { TRANSLATE("Zach Nelson"), {"zach"}, "(6% - " .. util.get_label_text("CH_SKILL_GOOD") .. ")" .. "\n\n" .. "- " .. util.get_label_text("CH_VEH_3_04B") .. "\n" .. "- " .. util.get_label_text("CH_VEH_3_03B") .. "\n" .. "- " .. util.get_label_text("CH_VEH_3_02B") .. "\n" .. "- " .. util.get_label_text("CH_VEH_3_01B") },
            { TRANSLATE("Karim Denz"), {"karim"}, "(5% - " .. util.get_label_text("CH_SKILL_POOR") .. ")" .. "\n\n" .. "- " .. util.get_label_text("CH_VEH_0_04B") .. "\n" .. "- " .. util.get_label_text("CH_VEH_0_03B") .. "\n" .. "- " .. util.get_label_text("CH_VEH_0_02B") .. "\n" .. "- " .. util.get_label_text("CH_VEH_0_01B") },
            { TRANSLATE("Random"), {"random"}, "(???%)" },
            { TRANSLATE("Remove"), {"remove"}, "(0%)" },
        }, function(index)
            if index == 1 then
                STAT_SET_INT("H3OPT_CREWDRIVER", 5)
            elseif index == 2 then
                STAT_SET_INT("H3OPT_CREWDRIVER", 3)
            elseif index == 3 then
                STAT_SET_INT("H3OPT_CREWDRIVER", 2)
            elseif index == 4 then
                STAT_SET_INT("H3OPT_CREWDRIVER", 4)
            elseif index == 5 then
                STAT_SET_INT("H3OPT_CREWDRIVER", 1)
            elseif index == 6 then
                STAT_SET_INT("H3OPT_CREWDRIVER", math.random(5))
            elseif index == 7 then
                STAT_SET_INT("H3OPT_CREWDRIVER", 6)
            end

            menu.trigger_commands("hccahrefreshboards")
        end)

        menu.list_action(CASINO_BOARD2, TRANSLATE("Vehicle Variation"), {"hccahvehvar"}, "", {
            { TRANSLATE("Best"), {"best"}, "- " .. TRANSLATE("Chester McCoy") .. ": " .. util.get_label_text("CH_VEH_4_04B") .. "\n" .. "- " .. TRANSLATE("Eddie Toh") .. ": " .. util.get_label_text("CH_VEH_2_04B") .. "\n" .. "- " .. TRANSLATE("Taliana Martinez") .. ": " .. util.get_label_text("CH_VEH_1_04B") .. "\n" .. "- " .. TRANSLATE("Taliana Martinez") .. ": " .. util.get_label_text("CH_VEH_3_04B") .. "\n" .. "- " .. TRANSLATE("Karim Denz") .. ": " .. util.get_label_text("CH_VEH_0_04B") },
            { TRANSLATE("Good"), {"good"}, "- " .. TRANSLATE("Chester McCoy") .. ": " .. util.get_label_text("CH_VEH_4_03B") .. "\n" .. "- " .. TRANSLATE("Eddie Toh") .. ": " .. util.get_label_text("CH_VEH_2_03B") .. "\n" .. "- " .. TRANSLATE("Taliana Martinez") .. ": " .. util.get_label_text("CH_VEH_1_03B") .. "\n" .. "- " .. TRANSLATE("Taliana Martinez") .. ": " .. util.get_label_text("CH_VEH_3_03B") .. "\n" .. "- " .. TRANSLATE("Karim Denz") .. ": " .. util.get_label_text("CH_VEH_0_03B") },
            { TRANSLATE("Fine"), {"fine"}, "- " .. TRANSLATE("Chester McCoy") .. ": " .. util.get_label_text("CH_VEH_4_02B") .. "\n" .. "- " .. TRANSLATE("Eddie Toh") .. ": " .. util.get_label_text("CH_VEH_2_02B") .. "\n" .. "- " .. TRANSLATE("Taliana Martinez") .. ": " .. util.get_label_text("CH_VEH_1_02B") .. "\n" .. "- " .. TRANSLATE("Taliana Martinez") .. ": " .. util.get_label_text("CH_VEH_3_02B") .. "\n" .. "- " .. TRANSLATE("Karim Denz") .. ": " .. util.get_label_text("CH_VEH_0_02B") },
            { TRANSLATE("Worst"), {"worst"}, "- " .. TRANSLATE("Chester McCoy") .. ": " .. util.get_label_text("CH_VEH_4_01B") .. "\n" .. "- " .. TRANSLATE("Eddie Toh") .. ": " .. util.get_label_text("CH_VEH_2_01B") .. "\n" .. "- " .. TRANSLATE("Taliana Martinez") .. ": " .. util.get_label_text("CH_VEH_1_01B") .. "\n" .. "- " .. TRANSLATE("Taliana Martinez") .. ": " .. util.get_label_text("CH_VEH_3_01B") .. "\n" .. "- " .. TRANSLATE("Karim Denz") .. ": " .. util.get_label_text("CH_VEH_0_01B") },
            { TRANSLATE("Random"), {"random"}, "" },
        }, function(index)
            if index == 1 then
                STAT_SET_INT("H3OPT_VEHS", 3)
            elseif index == 2 then
                STAT_SET_INT("H3OPT_VEHS", 2)
            elseif index == 3 then
                STAT_SET_INT("H3OPT_VEHS", 1)
            elseif index == 4 then
                STAT_SET_INT("H3OPT_VEHS", 0)
            elseif index == 5 then
                STAT_SET_INT("H3OPT_VEHS", math.random(0, 3))
            end

            menu.trigger_commands("hccahrefreshboards")
        end)

        menu.list_action(CASINO_BOARD2, TRANSLATE("Change Hacker"), {"hccahhacker"}, "", {
            { TRANSLATE("Avi Schwartzman"), {"avi"}, "(10% - " .. util.get_label_text("CH_SKILL_EXPR") .. ")" .. "\n\n" .. "- " .. TRANSLATE("Undetected Time:") .. " 3:30" .. "\n" .. "- " .. TRANSLATE("Detected Time:") .. " 2:26" },
            { TRANSLATE("Paige Harris"), {"paige"}, "(9% - " .. util.get_label_text("CH_SKILL_EXPR") .. ")" .. "\n\n" .. "- " .. TRANSLATE("Undetected Time:") .. " 3:25" .. "\n" .. "- " .. TRANSLATE("Detected Time:") .. " 2:23" },
            { TRANSLATE("Christian Feltz"), {"christian"}, "(7% - " .. util.get_label_text("CH_SKILL_GOOD") .. ")" .. "\n\n" .. "- " .. TRANSLATE("Undetected Time:") .. " 2:59" .. "\n" .. "- " .. TRANSLATE("Detected Time:") .. " 2:05" },
            { TRANSLATE("Yohan Blair"), {"yohan"}, "(5% - " .. util.get_label_text("CH_SKILL_GOOD") .. ")" .. "\n\n" .. "- " .. TRANSLATE("Undetected Time:") .. " 2:52" .. "\n" .. "- " .. TRANSLATE("Detected Time:") .. " 2:01" },
            { TRANSLATE("Rickie Lukens"), {"rickie"}, "(3% - " .. util.get_label_text("CH_SKILL_POOR") .. ")" .. "\n\n" .. "- " .. TRANSLATE("Undetected Time:") .. " 2:26" .. "\n" .. "- " .. TRANSLATE("Detected Time:") .. " 1:42" },
            { TRANSLATE("Random"), {"random"}, "(???%)" },
            { TRANSLATE("Remove"), {"remove"}, "(0%)" },
        }, function(index)
            if index == 1 then
                STAT_SET_INT("H3OPT_CREWHACKER", 4)
            elseif index == 2 then
                STAT_SET_INT("H3OPT_CREWHACKER", 5)
            elseif index == 3 then
                STAT_SET_INT("H3OPT_CREWHACKER", 2)
            elseif index == 4 then
                STAT_SET_INT("H3OPT_CREWHACKER", 3)
            elseif index == 5 then
                STAT_SET_INT("H3OPT_CREWHACKER", 1)
            elseif index == 6 then
                STAT_SET_INT("H3OPT_CREWHACKER", math.random(5))
            elseif index == 7 then
                STAT_SET_INT("H3OPT_CREWHACKER", 6)
            end

            menu.trigger_commands("hccahrefreshboards")
        end)

        menu.list_action(CASINO_BOARD2, TRANSLATE("Choose Masks"), {"hccahmask"}, "", {
            { TRANSLATE("Remove Masks"), {"remove"}, "" },
            { TRANSLATE("Geometric Set"), {"geometric"}, "" },
            { TRANSLATE("Hunter Set"), {"hunter"}, "" },
            { TRANSLATE("Oni Half Mask Set"), {"onihalf"}, "" },
            { TRANSLATE("Emoji Set"), {"emoji"}, "" },
            { TRANSLATE("Ornate Skull Set"), {"ornate"}, "" },
            { TRANSLATE("Lucky Fruit Set"), {"lucky"}, "" },
            { TRANSLATE("Guerilla Set"), {"guerilla"}, "" },
            { TRANSLATE("Clown Set"), {"clown"}, "" },
            { TRANSLATE("Animal Set"), {"animal"}, "" },
            { TRANSLATE("Riot Set"), {"riot"}, "" },
            { TRANSLATE("Oni Set"), {"oni"}, "" },
            { TRANSLATE("Hockey Set"), {"hockey"}, "" },
        }, function(index)
            if index == 1 then
                STAT_SET_INT("H3OPT_MASKS", -1)
            else
                STAT_SET_INT("H3OPT_MASKS", index - 1)
            end

            menu.trigger_commands("hccahrefreshboards")
        end)

        menu.slider(CASINO_BOARD2, TRANSLATE("Security Pass Level"), {"hccahcard"}, "", 0, 2, 2, 1, function(value)
            STAT_SET_INT("H3OPT_KEYLEVELS", value)
            menu.trigger_commands("hccahrefreshboards")
        end)
        menu.slider(CASINO_BOARD2, TRANSLATE("Guards Strength Level"), {"hccahguard"}, TRANSLATE("0 - Strongest Guards") .. "\n" .. TRANSLATE("3 - Weakest Guards"), 0, 3, 3, 1, function(value)
            STAT_SET_INT("H3OPT_DISRUPTSHIP", value)
            menu.trigger_commands("hccahrefreshboards")
        end)

    ---

    CASINO_BOARD3 = menu.list(CASINO_HEIST, TRANSLATE("Heist Planning (Board 3)"), {}, "", function(); end)

        menu.list_select(CASINO_BOARD3, TRANSLATE("Entrance"), {"hccahentrance"}, IS_WORKING(true) .. TRANSLATE("Don't forget changing this feature before starting the heist! Otherwise, won't be applied."), {
            { TRANSLATE("Main Door"), {"maindoor"}, "" },
            { TRANSLATE("Staff Lobby"), {"stafflobby"}, "" },
            { TRANSLATE("Waste Disposal"), {"wastedisposal"}, "" },
            { TRANSLATE("S.W Roof Terrace"), {"swroofterrace"}, "" },
            { TRANSLATE("N.W Roof Terrace"), {"nwroofterrace"}, "" },
            { TRANSLATE("S.E Roof Terrace"), {"seroofterrace"}, "" },
            { TRANSLATE("N.E Roof Terrace"), {"neroofterrace"}, "" },
            { TRANSLATE("South Helipad"), {"southhelipad"}, "" },
            { TRANSLATE("North Helipad"), {"northhelipad"}, "" },
            { TRANSLATE("Security Tunnel"), {"securitytunnel"}, "" },
            { TRANSLATE("Sewers"), {"sewers"}, "" },
        }, 1, function(index)
            util.create_tick_handler(function()
                if IS_WORKING(false) ~= "" then return end
                if not util.is_session_started() then return end
                SET_INT_GLOBAL(1971696 + 1497 + 1017, index - 1) -- https://www.unknowncheats.me/forum/3666316-post96.html
            end)
            menu.trigger_commands("hccahrefreshboards")
        end)

        menu.list_select(CASINO_BOARD3, TRANSLATE("Exit"), {"hccahexit"}, IS_WORKING(true) .. TRANSLATE("Don't forget changing this feature before starting the heist! Otherwise, won't be applied."), {
            { TRANSLATE("Main Door"), {"maindoor"}, "" },
            { TRANSLATE("Staff Lobby"), {"stafflobby"}, "" },
            { TRANSLATE("Waste Disposal"), {"wastedisposal"}, "" },
            { TRANSLATE("S.W Roof Terrace"), {"swroofterrace"}, "" },
            { TRANSLATE("N.W Roof Terrace"), {"nwroofterrace"}, "" },
            { TRANSLATE("S.E Roof Terrace"), {"seroofterrace"}, "" },
            { TRANSLATE("N.E Roof Terrace"), {"neroofterrace"}, "" },
            { TRANSLATE("South Helipad"), {"southhelipad"}, "" },
            { TRANSLATE("North Helipad"), {"northhelipad"}, "" },
            { TRANSLATE("Security Tunnel"), {"securitytunnel"}, "" },
            { TRANSLATE("Sewers"), {"sewers"}, "" },
        }, 1, function(index)
            util.create_tick_handler(function()
                if IS_WORKING(false) ~= "" then return end
                if not util.is_session_started() then return end
                SET_INT_GLOBAL(1971696 + 1497 + 1018, index - 1) -- https://www.unknowncheats.me/forum/3666316-post96.html
            end)
            menu.trigger_commands("hccahrefreshboards")
        end)

        menu.list_select(CASINO_BOARD3, TRANSLATE("Buyer Level"), {"hccahbuyer"}, IS_WORKING(true) .. TRANSLATE("Don't forget changing this feature before starting the heist! Otherwise, won't be applied."), {
            { TRANSLATE("Low"), {"low"}, "" },
            { TRANSLATE("Mid"), {"mid"}, "" },
            { TRANSLATE("High"), {"high"}, "" },
        }, 1, function(index)
            util.create_tick_handler(function()
                if IS_WORKING(false) ~= "" then return end
                if not util.is_session_started() then return end
                SET_INT_GLOBAL(1971696 + 1497 + 1019, (index * 3) - 3) -- https://www.unknowncheats.me/forum/3666316-post96.html
            end)
            menu.trigger_commands("hccahrefreshboards")
        end)

        menu.list_select(CASINO_BOARD3, TRANSLATE("Entry Disguise"), {"hccahentrydisguise"}, IS_WORKING(true) .. "(" .. TRANSLATE("BigCon Approach") .. ")" .. "\n\n" .. TRANSLATE("Don't forget changing this feature before starting the heist! Otherwise, won't be applied."), {
            { TRANSLATE("Bugstars"), {"bugstars"}, "" },
            { TRANSLATE("LS Water & Power"), {"lswaternpower"}, "" },
            { TRANSLATE("Gruppe Sechs"), {"gruppesechs"}, "" },
            { TRANSLATE("Yung Ancestor"), {"yungancestor"}, "" },
        }, 1, function(index)
            util.create_tick_handler(function()
                if IS_WORKING(false) ~= "" then return end
                if not util.is_session_started() then return end
                SET_INT_GLOBAL(1971696 + 1497 + 1020, index)
            end)
            menu.trigger_commands("hccahrefreshboards")
        end)

        menu.list_select(CASINO_BOARD3, TRANSLATE("Exit Disguise"), {"hccahexitdisguise"}, IS_WORKING(true) .. "(" .. TRANSLATE("BigCon Approach") .. ")" .. "\n\n" .. TRANSLATE("Don't forget changing this feature before starting the heist! Otherwise, won't be applied."), {
            { TRANSLATE("Noose"), {"noose"}, "" },
            { TRANSLATE("Firefighters"), {"firefighters"}, "" },
            { TRANSLATE("High Rollers"), {"highrollers"}, "" },
        }, 1, function(index)
            util.create_tick_handler(function()
                if IS_WORKING(false) ~= "" then return end
                if not util.is_session_started() then return end
            end)
            menu.trigger_commands("hccahrefreshboards")
        end)

        menu.divider(CASINO_BOARD3, TRANSLATE("Remove Drills"))

            menu.action(CASINO_BOARD3, TRANSLATE("Silent, Sneaky and Aggressive Approach"), {"hccahremsilaggdrill"}, "", function()
                STAT_SET_INT("H3OPT_BITSET0", -8849)
            end)
            menu.action(CASINO_BOARD3, TRANSLATE("BigCon Approach"), {"hccahrembigdrill"}, "", function()
                STAT_SET_INT("H3OPT_BITSET0", -186)
            end)

        ---

    ---

    menu.list_action(CASINO_HEIST, TRANSLATE("Casino Story Missions"), {}, "", {
        { TRANSLATE("Loose Cheng"), {}, "" },
        { TRANSLATE("House Keeping"), {}, "" },
        { TRANSLATE("Strong Arm Tactics"), {}, "" },
        { TRANSLATE("Play to Win"), {}, "" },
        { TRANSLATE("Bad Beat"), {}, "" },
        { TRANSLATE("Cashing Out"), {}, "" },
    }, function(index)
        if index == 1 then
            STAT_SET_INT("VCM_FLOW_PROGRESS", 1048576)
        elseif index == 2 then
            STAT_SET_INT("VCM_FLOW_PROGRESS", 1310785)
        elseif index == 3 then
            STAT_SET_INT("VCM_FLOW_PROGRESS", 1310915)
        elseif index == 4 then
            STAT_SET_INT("VCM_FLOW_PROGRESS", 1311175)
        elseif index == 5 then
            STAT_SET_INT("VCM_FLOW_PROGRESS", 1311695)
        elseif index == 6 then
            STAT_SET_INT("VCM_FLOW_PROGRESS", 1312735)
        end

        STAT_SET_INT("VCM_STORY_PROGRESS", index - 1)
    end)

    CASINO_MORE = menu.list(CASINO_HEIST, TRANSLATE("Others"), {}, "", function(); end)

        menu.textslider_stateful(CASINO_MORE, TRANSLATE("Load & Unload - All Boards"), {}, "", {
            TRANSLATE("Load"),
            TRANSLATE("Unload"),
        }, function(index)
            STAT_SET_INT("H3OPT_BITSET1", index - 2)
            STAT_SET_INT("H3OPT_BITSET0", index - 2)
        end)

        REM_REPEAT_COOLDOWN = menu.action(CASINO_MORE, TRANSLATE("Remove Repeat Cooldown"), {}, TRANSLATE("You should not in your arcade to use this feature.") .. "\n\n" .. TRANSLATE("Meaning of the cooldown: Requesting new Diamond Casino Heist in calling to Lester"), function()
            if not IS_IN_ARCADE() then
                STAT_SET_INT("H3_COMPLETEDPOSIX", -1)
                STAT_SET_INT("MPPLY_H3_COOLDOWN", -1)
            else
                NOTIFY(TRANSLATE("You should not in your arcade to use this feature."))
            end
        end)

        menu.action(CASINO_MORE, TRANSLATE("Set Heist to Default (Reset)"), {"hccahreset"}, "", function()
            STAT_SET_INT("H3_LAST_APPROACH", 0)
            STAT_SET_INT("H3OPT_APPROACH", 0)
            STAT_SET_INT("H3_HARD_APPROACH", 0)
            STAT_SET_INT("H3OPT_TARGET", 0)
            STAT_SET_INT("H3OPT_POI", 0)
            STAT_SET_INT("H3OPT_ACCESSPOINTS", 0)
            STAT_SET_INT("H3OPT_BITSET1", 0)
            STAT_SET_INT("H3OPT_CREWWEAP", 0)
            STAT_SET_INT("H3OPT_CREWDRIVER", 0)
            STAT_SET_INT("H3OPT_CREWHACKER", 0)
            STAT_SET_INT("H3OPT_WEAPS", 0)
            STAT_SET_INT("H3OPT_VEHS", 0)
            STAT_SET_INT("H3OPT_DISRUPTSHIP", 0)
            STAT_SET_INT("H3OPT_BODYARMORLVL", 0)
            STAT_SET_INT("H3OPT_KEYLEVELS", 0)
            STAT_SET_INT("H3OPT_MASKS", 0)
            STAT_SET_INT("H3OPT_BITSET0", 0)

            menu.trigger_commands("hccahrefreshboards")
        end)

    ---

---


--- Doomsday Heist

    DOOMS_PRESETS = menu.list(DOOMS_HEIST, TRANSLATE("Automated Presets"), {"hcdoomspreset"}, TRANSLATE("You should enable the preset until the end of the heist!") .. "\n\n" .. TRANSLATE("Enabling one of these presets will complete all of setups, and set as max payout, $2.55 Millions. It will be affected to all of heist players."), function(); end)

        DOOMS_PRESETS_ACT1 = menu.toggle(DOOMS_PRESETS, TRANSLATE("ACT I - The Data Breaches"), {"hcdoomsact1"}, IS_WORKING(true) .. TRANSLATE("Note that there is a payout visual bug on the heist screen."), function()
            if menu.get_value(DOOMS_PRESETS_ACT1) then
                STAT_SET_INT("GANGOPS_FLOW_MISSION_PROG", 503)
                STAT_SET_INT("GANGOPS_HEIST_STATUS", -229383)
                STAT_SET_INT("GANGOPS_FLOW_NOTIFICATIONS", 1557)

                menu.trigger_commands("hcdoomsrefreshscreen")

                for i = 1, #DoomsPresetLists do
                    if DoomsPresetLists[i][1] == DOOMS_PRESETS_ACT1 then
                        DoomsPresetLists[i][2] = true
                    end
                end
                for i = 1, #ForDoomsPresets do
                    menu.set_help_text(ForDoomsPresets[i][1], TRANSLATE("This feature has been controlled by another feature.") .. "\n" .. "- " .. menu.get_menu_name(DOOMS_PRESETS) .. " > " .. menu.get_menu_name(DOOMS_PRESETS_ACT1))
                end
            else
                for i = 1, #DoomsPresetLists do
                    if DoomsPresetLists[i][1] == DOOMS_PRESETS_ACT1 then
                        DoomsPresetLists[i][2] = false
                    end
                end
                for i = 1, #ForDoomsPresets do
                    menu.apply_default_state(ForDoomsPresets[i][1])
                    menu.set_help_text(ForDoomsPresets[i][1], ForDoomsPresets[i][2])
                end
            end

            while menu.get_value(DOOMS_PRESETS_ACT1) do
                menu.set_value(DOOMS_NON_HOST_CUT, 209)
                menu.set_value(DOOMS_NON_HOST_CUT_LOOP, false)
                menu.set_value(DOOMS_HOST_CUT, 209)
                menu.set_value(DOOMS_HOST_CUT_LOOP, true)
                menu.set_value(DOOMS_2P_CUT, 209)
                menu.set_value(DOOMS_2P_CUT_LOOP, true)
                menu.set_value(DOOMS_3P_CUT, 209)
                menu.set_value(DOOMS_3P_CUT_LOOP, true)
                menu.set_value(DOOMS_4P_CUT, 209)
                menu.set_value(DOOMS_4P_CUT_LOOP, true)

                util.yield_once()
            end
        end)

        DOOMS_PRESETS_ACT2 = menu.toggle(DOOMS_PRESETS, TRANSLATE("ACT II - The Bogdan Problem"), {"hcdoomsact2"}, IS_WORKING(true) .. TRANSLATE("Note that there is a payout visual bug on the heist screen."), function()
            if menu.get_value(DOOMS_PRESETS_ACT2) then
                STAT_SET_INT("GANGOPS_FLOW_MISSION_PROG", 240)
                STAT_SET_INT("GANGOPS_HEIST_STATUS", -229378)
                STAT_SET_INT("GANGOPS_FLOW_NOTIFICATIONS", 1557)

                menu.trigger_commands("hcdoomsrefreshscreen")

                for i = 1, #DoomsPresetLists do
                    if DoomsPresetLists[i][1] == DOOMS_PRESETS_ACT2 then
                        DoomsPresetLists[i][2] = true
                    end
                end
                for i = 1, #ForDoomsPresets do
                    menu.set_help_text(ForDoomsPresets[i][1], TRANSLATE("This feature has been controlled by another feature.") .. "\n" .. "- " .. menu.get_menu_name(DOOMS_PRESETS) .. " > " .. menu.get_menu_name(DOOMS_PRESETS_ACT2))
                end
            else
                for i = 1, #DoomsPresetLists do
                    if DoomsPresetLists[i][1] == DOOMS_PRESETS_ACT2 then
                        DoomsPresetLists[i][2] = false
                    end
                end
                for i = 1, #ForDoomsPresets do
                    menu.apply_default_state(ForDoomsPresets[i][1])
                    menu.set_help_text(ForDoomsPresets[i][1], ForDoomsPresets[i][2])
                end
            end

            while menu.get_value(DOOMS_PRESETS_ACT2) do
                menu.set_value(DOOMS_NON_HOST_CUT, 142)
                menu.set_value(DOOMS_NON_HOST_CUT_LOOP, false)
                menu.set_value(DOOMS_HOST_CUT, 142)
                menu.set_value(DOOMS_HOST_CUT_LOOP, true)
                menu.set_value(DOOMS_2P_CUT, 142)
                menu.set_value(DOOMS_2P_CUT_LOOP, true)
                menu.set_value(DOOMS_3P_CUT, 142)
                menu.set_value(DOOMS_3P_CUT_LOOP, true)
                menu.set_value(DOOMS_4P_CUT, 142)
                menu.set_value(DOOMS_4P_CUT_LOOP, true)

                util.yield_once()
            end
        end)

        DOOMS_PRESETS_ACT3 = menu.toggle(DOOMS_PRESETS, TRANSLATE("ACT III - The Doomsday Scenario"), {"hcdoomsact3"}, IS_WORKING(true) .. TRANSLATE("Note that there is a payout visual bug on the heist screen."), function()
            if menu.get_value(DOOMS_PRESETS_ACT3) then
                STAT_SET_INT("GANGOPS_FLOW_MISSION_PROG", 16368)
                STAT_SET_INT("GANGOPS_HEIST_STATUS", -229380)
                STAT_SET_INT("GANGOPS_FLOW_NOTIFICATIONS", 1557)

                menu.trigger_commands("hcdoomsrefreshscreen")

                for i = 1, #DoomsPresetLists do
                    if DoomsPresetLists[i][1] == DOOMS_PRESETS_ACT3 then
                        DoomsPresetLists[i][2] = true
                    end
                end
                for i = 1, #ForDoomsPresets do
                    menu.set_help_text(ForDoomsPresets[i][1], TRANSLATE("This feature has been controlled by another feature.") .. "\n" .. "- " .. menu.get_menu_name(DOOMS_PRESETS) .. " > " .. menu.get_menu_name(DOOMS_PRESETS_ACT3))
                end
            else
                for i = 1, #DoomsPresetLists do
                    if DoomsPresetLists[i][1] == DOOMS_PRESETS_ACT3 then
                        DoomsPresetLists[i][2] = false
                    end
                end
                for i = 1, #ForDoomsPresets do
                    menu.apply_default_state(ForDoomsPresets[i][1])
                    menu.set_help_text(ForDoomsPresets[i][1], ForDoomsPresets[i][2])
                end
            end

            while menu.get_value(DOOMS_PRESETS_ACT3) do
                menu.set_value(DOOMS_NON_HOST_CUT, 113)
                menu.set_value(DOOMS_NON_HOST_CUT_LOOP, false)
                menu.set_value(DOOMS_HOST_CUT, 113)
                menu.set_value(DOOMS_HOST_CUT_LOOP, true)
                menu.set_value(DOOMS_2P_CUT, 113)
                menu.set_value(DOOMS_2P_CUT_LOOP, true)
                menu.set_value(DOOMS_3P_CUT, 113)
                menu.set_value(DOOMS_3P_CUT_LOOP, true)
                menu.set_value(DOOMS_4P_CUT, 113)
                menu.set_value(DOOMS_4P_CUT_LOOP, true)

                util.yield_once()
            end
        end)

    ---

    TELEPORT_DOOMS = menu.list(DOOMS_HEIST, TRANSLATE("Teleport Places"), {}, TRANSLATE("- How to change the line color: Stand > Settings > Appearance > Colours > HUD Colour") .. "\n\n" .. TRANSLATE("- How to change the AR Beacon color: Stand > Settings > Appearance > Colours > AR Colour"), function(); end)

        FacilityPos = nil
        util.create_tick_handler(function()
            local Blip = HUD.GET_FIRST_BLIP_INFO_ID(590) -- Facility Blip
            local Pos = HUD.GET_BLIP_COORDS(Blip)
            if HUD.DOES_BLIP_EXIST(Blip) then
                FacilityPos = Pos
            end
        end)

        TELEPORT_DOOMS_ENTRANCE = menu.action(TELEPORT_DOOMS, TRANSLATE("Entrance Of Your Facility"), {}, TRANSLATE("Note that works perfectly when no other players are in your session."), function()
            if FacilityPos ~= nil then
                TELEPORT(FacilityPos.x, FacilityPos.y, FacilityPos.z)
            else
                NOTIFY(TRANSLATE("Please go out of the current interior to use this feature."))
            end
        end)
        TELEPORT_DOOMS_SCREEN = menu.action(TELEPORT_DOOMS, TRANSLATE("Heist Screen on Facility"), {}, TRANSLATE("Make sure you are in your facility."), function()
            local Blip = HUD.GET_FIRST_BLIP_INFO_ID(428) -- Heist Blip in the Facility
            if HUD.DOES_BLIP_EXIST(Blip) then
                TELEPORT(350.69284, 4872.308, -60.794243)
                SET_HEADING(-50)
            else
                NOTIFY(menu.get_help_text(TELEPORT_DOOMS_SCREEN))
            end
        end)
        TELEPORT_DOOMS_BOARD = menu.action(TELEPORT_DOOMS, TRANSLATE("Heist Board"), {}, "(" .. TRANSLATE("The Bogdan Problem ACT II") .. ")", function()
            TELEPORT(515.528, 4835.353, -62.587)
        end)
        TELEPORT_DOOMS_CELL = menu.action(TELEPORT_DOOMS, TRANSLATE("Prisoner Cell"), {}, "(" .. TRANSLATE("The Bogdan Problem ACT II") .. ")", function()
            TELEPORT(512.888, 4833.033, -68.989)
        end)

    ---

    DOOMS_PLAYER_CUT = menu.list(DOOMS_HEIST, TRANSLATE("Player's Cut"), {}, TRANSLATE("Don't forget changing this feature before starting the heist! Otherwise, won't be applied."), function(); end)

        DOOMS_NON_HOST = menu.list(DOOMS_PLAYER_CUT, TRANSLATE("Your Cut (Non-Host)"), {}, TRANSLATE("Note that modifying this won't applied to the heist board. You can check the applied cut after end of the heist."), function(); end)

            DOOMS_NON_HOST_CUT_LOOP = menu.toggle_loop(DOOMS_NON_HOST, TRANSLATE("Enable"), {"hcdoomsnonhostloop"}, IS_WORKING(false), function()
                SET_INT_GLOBAL(2684801 + 6589, menu.get_value(DOOMS_NON_HOST_CUT)) -- gb_gang_ops_planning.c
            end, function()
                SET_INT_GLOBAL(2684801 + 6589, menu.get_default_state(DOOMS_NON_HOST_CUT))
            end)

            DOOMS_NON_HOST_CUT = menu.slider(DOOMS_NON_HOST, TRANSLATE("Custom Percentage"), {"hcdoomsnonhost"}, "(%)", 0, 1000, 100, 5, function(); end)

        ---

        DOOMS_HOST = menu.list(DOOMS_PLAYER_CUT, TRANSLATE("Your Cut"), {}, TRANSLATE("Only works if you are host of the heist."), function(); end)

        DOOMS_HOST_CUT_LOOP = menu.toggle_loop(DOOMS_HOST, TRANSLATE("Enable"), {"hcdooms1ploop"}, IS_WORKING(false), function()
            SET_INT_GLOBAL(1967630 + 812 + 50 + 1, menu.get_value(DOOMS_HOST_CUT)) -- gb_gang_ops_planning.c
        end, function()
            SET_INT_GLOBAL(1967630 + 812 + 50 + 1, menu.get_default_state(DOOMS_HOST_CUT))
        end)

            DOOMS_HOST_CUT = menu.slider(DOOMS_HOST, TRANSLATE("Custom Percentage"), {"hcdooms1pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

        ---

        DOOMS_2P = menu.list(DOOMS_PLAYER_CUT, TRANSLATE("Player 2"), {}, TRANSLATE("Only works if you are host of the heist."), function(); end)
            
            DOOMS_2P_CUT_LOOP = menu.toggle_loop(DOOMS_2P, TRANSLATE("Enable"), {"hcdooms2pcutloop"}, IS_WORKING(false), function()
                SET_INT_GLOBAL(1967630 + 812 + 50 + 2, menu.get_value(DOOMS_2P_CUT)) -- gb_gang_ops_planning.c
            end, function()
                SET_INT_GLOBAL(1967630 + 812 + 50 + 2, menu.get_default_state(DOOMS_2P_CUT))
            end)

            DOOMS_2P_CUT = menu.slider(DOOMS_2P, TRANSLATE("Custom Percentage"), {"hcdooms2pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

        ---

        DOOMS_3P = menu.list(DOOMS_PLAYER_CUT, TRANSLATE("Player 3"), {}, TRANSLATE("Only works if you are host of the heist."), function(); end)

            DOOMS_3P_CUT_LOOP = menu.toggle_loop(DOOMS_3P, TRANSLATE("Enable"), {"hcdooms3pcutloop"}, IS_WORKING(false), function()
                SET_INT_GLOBAL(1967630 + 812 + 50 + 3, menu.get_value(DOOMS_3P_CUT)) -- gb_gang_ops_planning.c
            end, function()
                SET_INT_GLOBAL(1967630 + 812 + 50 + 3, menu.get_default_state(DOOMS_3P_CUT))
            end)

            DOOMS_3P_CUT = menu.slider(DOOMS_3P, TRANSLATE("Custom Percentage"), {"hcdooms3pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

        ---

        DOOMS_4P = menu.list(DOOMS_PLAYER_CUT, TRANSLATE("Player 4"), {}, TRANSLATE("Only works if you are host of the heist."), function(); end)

            DOOMS_4P_CUT_LOOP = menu.toggle_loop(DOOMS_4P, TRANSLATE("Enable"), {"hcdooms4pcutloop"}, IS_WORKING(false), function()
                SET_INT_GLOBAL(1967630 + 812 + 50 + 4, menu.get_value(DOOMS_4P_CUT)) -- gb_gang_ops_planning.c
            end, function()
                SET_INT_GLOBAL(1967630 + 812 + 50 + 4, menu.get_default_state(DOOMS_4P_CUT))
            end)

            DOOMS_4P_CUT = menu.slider(DOOMS_4P, TRANSLATE("Custom Percentage"), {"hcdooms4pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

        ---

        menu.toggle_loop(DOOMS_PLAYER_CUT, TRANSLATE("Bypass Minimum And Maximum Percentage"), {}, IS_WORKING(true) .. TRANSLATE("Only works if you are host of the heist.") .. "\n\n" .. TRANSLATE("It allows you set 0 ~ 100(%) by modifying the heist board, ignores all of restrictions modifying cuts."), function()
            SET_INT_GLOBAL(262145 + 23290, 0) -- -2020782937, https://www.unknowncheats.me/forum/3732338-post132.html
            SET_INT_GLOBAL(262145 + 23291, 100) -- 944111042
        end, function()
            SET_INT_GLOBAL(262145 + 23290, 15)
            SET_INT_GLOBAL(262145 + 23291, 85)
        end)

    ---

    menu.toggle_loop(DOOMS_HEIST, TRANSLATE("Skip The Hacking Process"), {}, IS_WORKING(true) .. "(" .. TRANSLATE("The Data Breaches ACT I") .. " - " .. TRANSLATE("Setup: Server Farm (Lester)") .. " & " .. TRANSLATE("The Doomsday Scenario ACT III") .. ")", function()
        SET_INT_LOCAL("fm_mission_controller", 1508, 3) -- For ACT I, Setup: Server Farm (Lester), https://www.unknowncheats.me/forum/3687245-post112.html
        SET_INT_LOCAL("fm_mission_controller", 1539, 2)
        SET_INT_LOCAL("fm_mission_controller", 1265 + 135, 3) -- For ACT III, https://www.unknowncheats.me/forum/3455828-post8.html
    end)

    menu.action(DOOMS_HEIST, TRANSLATE("Refresh Heist Screen On Facility"), {"hcdoomsrefreshscreen"}, IS_WORKING(true) .. TRANSLATE("You can update changed doomsday heist stats in the Facility by refreshing it."), function()
        SET_INT_LOCAL("gb_gang_ops_planning", 178, 6) -- https://www.unknowncheats.me/forum/3682032-post104.html
    end)

    menu.action(DOOMS_HEIST, TRANSLATE("Remove EMP Mines"), {}, TRANSLATE("(ACT III, Setup - Air Defense)"), function()
        local Object = util.joaat("xm_prop_sam_turret_01")
        DELETE_OBJECT_BY_HASH(Object)
    end)

    menu.action(DOOMS_HEIST, TRANSLATE("Unlock All Doomsday Heists"), {}, TRANSLATE("Makes able to play all of Doomsday heists, ACT I, II, III."), function()
        STAT_SET_INT("GANGOPS_HEIST_STATUS", -1)
        STAT_SET_INT("GANGOPS_HEIST_STATUS", -229384)
    end)

    menu.action(DOOMS_HEIST, TRANSLATE("Complete All Prep Missions"), {}, "", function()
        STAT_SET_INT("GANGOPS_FM_MISSION_PROG", -1)
        menu.trigger_commands("hcdoomsrefreshscreen")
    end)

    menu.action(DOOMS_HEIST, TRANSLATE("Set Heist to Default (Reset)"), {"hcdoomsreset"}, "", function()
        STAT_SET_INT("GANGOPS_FLOW_MISSION_PROG", 240)
        STAT_SET_INT("GANGOPS_HEIST_STATUS", 0)
        STAT_SET_INT("GANGOPS_FLOW_NOTIFICATIONS", 1557)

        menu.trigger_commands("hcdoomsrefreshscreen")
    end)

---


--- Classic Heist

    FLEECA_HEIST = menu.list(CLASSIC_HEISTS, TRANSLATE("Fleeca Heist"), {}, "", function(); end)

        menu.toggle_loop(FLEECA_HEIST, TRANSLATE("Set Your Payout To $15M"), {"hcfleeca15m"}, IS_WORKING(true) .. TRANSLATE("(Local)") .. "\n\n" .. TRANSLATE("You should be the host of the Fleeca Heist and it'll be applied to only you."), function()
            SET_INT_GLOBAL(1937658 + 3008 + 1, 5961) -- fmmc_launcher.c
        end, function()
            SET_INT_GLOBAL(1937658 + 3008 + 1, 85)
        end)

        menu.toggle_loop(FLEECA_HEIST, TRANSLATE("Skip The Hacking Process"), {}, IS_WORKING(false), function() -- https://www.unknowncheats.me/forum/3455828-post8.html
            SET_INT_LOCAL("fm_mission_controller", 11757 + 24, 7)
        end)

        menu.toggle_loop(FLEECA_HEIST, TRANSLATE("Skip Drilling"), {}, IS_WORKING(false), function() -- https://www.unknowncheats.me/forum/3485435-post19.html
            SET_FLOAT_LOCAL("fm_mission_controller", 10058 + 11, 100)
        end)

    ---

    PACIFIC_STANDARD_HEIST = menu.list(CLASSIC_HEISTS, TRANSLATE("Pacific Standard Heist"), {}, "", function(); end)

        menu.toggle_loop(PACIFIC_STANDARD_HEIST, TRANSLATE("Keep Cash $1.85M Take"), {}, IS_WORKING(true) .. TRANSLATE("This makes you won't lose money by getting shot to the cash bags from polices"), function()
            if util.spoof_script("gb_casino_heist", function(); end) then return end -- If playing Diamond Casino Heist
            SET_INT_LOCAL("fm_mission_controller", 19707 + 2686, 1850000) -- How much did you take in the casino and pacific standard heist
        end)

        menu.toggle_loop(PACIFIC_STANDARD_HEIST, TRANSLATE("Skip The Hacking Process"), {}, IS_WORKING(false), function() -- https://www.unknowncheats.me/forum/3694259-post117.html
            SET_LOCAL_BIT("fm_mission_controller", 9764, 9)
        end)

    ---

    menu.toggle_loop(CLASSIC_HEISTS, TRANSLATE("Bypass Minimum And Maximum Percentage"), {}, IS_WORKING(true) .. TRANSLATE("Only works if you are host of the heist.") .. "\n\n" .. TRANSLATE("It allows you set 0 ~ 100(%) by modifying the heist board, ignores all of restrictions modifying cuts."), function()
        SET_INT_GLOBAL(262145 + 9084, 100) -- MAX_HEIST_CUT_AMOUNT, Default: 70(%), https://www.unknowncheats.me/forum/3664875-post95.html
        SET_INT_GLOBAL(262145 + 9186, 0) -- MEMBER_MIN_HEIST_FINALE_TAKE_PERCENTAGE, Default: 15(%)
        SET_INT_GLOBAL(262145 + 9187, 0) -- LEADER_MIN_HEIST_FINALE_TAKE_PERCENTAGE, Default: 15(%)
    end)

    menu.toggle_loop(CLASSIC_HEISTS, TRANSLATE("Complete All Setup"), {}, TRANSLATE("Works on all of the classic heists. You need to activate this until first setup mission is ended."), function()
        STAT_SET_INT("HEIST_PLANNING_STAGE", -1)
    end)

---


--- LS Robbery

    menu.toggle_loop(LS_ROBBERY, TRANSLATE("Modify Contracts payout - $1 Million"), {"hcls1m"}, IS_WORKING(true) .. TRANSLATE("(Local)") .. "\n\n" .. TRANSLATE("Always keep this option enabled before starting a contract"), function()
        SET_INT_GLOBAL(262145 + 31041, 1000000) -- TUNER_ROBBERY_GOON_CASH_REWARD
        SET_INT_GLOBAL(262145 + 31042 + 0, 1000000) -- TUNER_ROBBERY_LEADER_CASH_REWARD0
        SET_INT_GLOBAL(262145 + 31042 + 1, 1000000) -- TUNER_ROBBERY_LEADER_CASH_REWARD1
        SET_INT_GLOBAL(262145 + 31042 + 2, 1000000) -- TUNER_ROBBERY_LEADER_CASH_REWARD2
        SET_INT_GLOBAL(262145 + 31042 + 3, 1000000) -- TUNER_ROBBERY_LEADER_CASH_REWARD3
        SET_INT_GLOBAL(262145 + 31042 + 4, 1000000) -- TUNER_ROBBERY_LEADER_CASH_REWARD4
        SET_INT_GLOBAL(262145 + 31042 + 5, 1000000) -- TUNER_ROBBERY_LEADER_CASH_REWARD5
        SET_INT_GLOBAL(262145 + 31042 + 6, 1000000) -- TUNER_ROBBERY_LEADER_CASH_REWARD6
        SET_INT_GLOBAL(262145 + 31042 + 7, 1000000) -- TUNER_ROBBERY_LEADER_CASH_REWARD7
        SET_FLOAT_GLOBAL(262145 + 31038, 0) -- TUNER_ROBBERY_CONTACT_FEE
    end, function()
        SET_INT_GLOBAL(262145 + 31041, 50000)
        SET_INT_GLOBAL(262145 + 31042 + 0, 300000)
        SET_INT_GLOBAL(262145 + 31042 + 1, 185000)
        SET_INT_GLOBAL(262145 + 31042 + 2, 178000)
        SET_INT_GLOBAL(262145 + 31042 + 3, 172000)
        SET_INT_GLOBAL(262145 + 31042 + 4, 175000)
        SET_INT_GLOBAL(262145 + 31042 + 5, 182000)
        SET_INT_GLOBAL(262145 + 31042 + 6, 180000)
        SET_INT_GLOBAL(262145 + 31042 + 7, 170000)
        SET_FLOAT_GLOBAL(262145 + 31038, 0.1)
    end)

    menu.action(LS_ROBBERY, TRANSLATE("Union Depository"), {"hclsunion"}, "", function()
        STAT_SET_INT("TUNER_GEN_BS", 12543)
        STAT_SET_INT("TUNER_CURRENT", 0)
    end)
    menu.action(LS_ROBBERY, TRANSLATE("The Superdollar Deal"), {"hclssdollar"}, "", function()
        STAT_SET_INT("TUNER_GEN_BS", 4351)
        STAT_SET_INT("TUNER_CURRENT", 1)
    end)
    menu.action(LS_ROBBERY, TRANSLATE("The Bank Contract"), {"hclsbank"}, "", function()
        STAT_SET_INT("TUNER_GEN_BS", 12543)
        STAT_SET_INT("TUNER_CURRENT", 2)
    end)
    menu.action(LS_ROBBERY, TRANSLATE("The ECU Job"), {"hclsecu"}, "", function()
        STAT_SET_INT("TUNER_GEN_BS", 12543)
        STAT_SET_INT("TUNER_CURRENT", 3)
    end)
    menu.action(LS_ROBBERY, TRANSLATE("The Prison Contract"), {"hclsprison"}, "", function()
        STAT_SET_INT("TUNER_GEN_BS", 12543)
        STAT_SET_INT("TUNER_CURRENT", 4)
    end)
    menu.action(LS_ROBBERY, TRANSLATE("The Agency Deal"), {"hclsagency"}, "", function()
        STAT_SET_INT("TUNER_GEN_BS", 12543)
        STAT_SET_INT("TUNER_CURRENT", 5)
    end)
    menu.action(LS_ROBBERY, TRANSLATE("The Lost Contract"), {"hclslost"}, "", function()
        STAT_SET_INT("TUNER_GEN_BS", 12543)
        STAT_SET_INT("TUNER_CURRENT", 6)
    end)
    menu.action(LS_ROBBERY, TRANSLATE("The Data Contract"), {"hclsdata"}, "", function()
        STAT_SET_INT("TUNER_GEN_BS", 12543)
        STAT_SET_INT("TUNER_CURRENT", 7)
    end)
    menu.action(LS_ROBBERY, TRANSLATE("Complete The Preps"), {"hclscomplete"}, "", function()
        STAT_SET_INT("TUNER_GEN_BS", -1)
    end)
    
    ROBBERY_OTHERS = menu.list(LS_ROBBERY, TRANSLATE("Others"), {}, "", function(); end)
    
        menu.action(ROBBERY_OTHERS, TRANSLATE("Reset The Preps"), {"hclsresetmisson"}, "", function()
            STAT_SET_INT("TUNER_GEN_BS", 12467)
        end)
        menu.action(ROBBERY_OTHERS, TRANSLATE("Reset The Contracts"), {"hclsresetcontract"}, "", function()
            STAT_SET_INT("TUNER_GEN_BS", 8371)
            STAT_SET_INT("TUNER_CURRENT", -1)
        end)
        menu.action(ROBBERY_OTHERS, TRANSLATE("Reset Total Gains And Completed Contracts"), {"hclsresetgain"}, "", function()
            STAT_SET_INT("TUNER_COUNT", 0)
            STAT_SET_INT("TUNER_EARNINGS", 0)
        end)
    
    ---

---


--- ULP Missions

    menu.divider(ULP_MISSIONS, TRANSLATE("ULP Missions"))

        UlpMissionTypes = {
            TRANSLATE("Intelligence"),
            TRANSLATE("Counterintelligence"),
            TRANSLATE("Extraction"),
            TRANSLATE("Asset Seizure"),
            TRANSLATE("Operation Paper Trail"),
            TRANSLATE("Cleanup"),
        }
        for idx, mission_name in pairs(UlpMissionTypes) do
            menu.action(ULP_MISSIONS, mission_name, {}, "", function()
                STAT_SET_INT("ULP_MISSION_CURRENT", idx - 1)
                STAT_SET_INT("ULP_MISSION_PROGRESS", 127)
            end)
        end

    ---

    menu.divider(ULP_MISSIONS, TRANSLATE("Others"))

        menu.toggle_loop(ULP_MISSIONS, TRANSLATE("Skip The Hacking Process"), {}, IS_WORKING(true) .. "(" .. TRANSLATE("ULP Missions") .. " - " .. TRANSLATE("Counterintelligence") .. ")", function() -- Thanks for coding this, Pedro9558#3559
            SET_INT_LOCAL("fm_mission_controller_2020", 974 + 135, 3)
        end)
        menu.action(ULP_MISSIONS, TRANSLATE("Teleport To IAA Headquarters"), {}, "", function()
            local Blip = HUD.GET_FIRST_BLIP_INFO_ID(838) -- ULP Blip, https://wiki.rage.mp/index.php?title=Blips
            if Blip ~= 0 then
                local Pos = HUD.GET_BLIP_COORDS(Blip)
                TELEPORT(Pos.x, Pos.y, Pos.z)
            else
                NOTIFY(TRANSLATE("Please make sure you can play ULP Missions now!"))
            end
        end)

    ---

---


--- The Contract: Agency

    CONTRACT_VIP = menu.list(TH_CONTRACT, TRANSLATE("VIP Contract: Dr.Dre"), {}, "", function(); end)

        menu.list_action(CONTRACT_VIP, TRANSLATE("NightLife Leak"), {"hcagcnightlife"}, "", {
            { TRANSLATE("The Nightclub"), {"thenightclub"}, TRANSLATE("(Prep)") },
            { TRANSLATE("The Marina"), {"themarina"}, TRANSLATE("(Prep)") },
            { TRANSLATE("NightLife Leak"), {"nightlifeleak"}, TRANSLATE("(Mission)") },
        }, function(index)
            if index ~= 3 then
                STAT_SET_INT("FIXER_STORY_BS", index + 2)
            else
                STAT_SET_INT("FIXER_STORY_BS", 12)
            end

            STAT_SET_INT("FIXER_GENERAL_BS", -1)
            STAT_SET_INT("FIXER_COMPLETED_BS", -1)
            STAT_SET_INT("FIXER_STORY_COOLDOWN", -1)
        end)

        menu.list_action(CONTRACT_VIP, TRANSLATE("High Society Leak"), {"hcagcsociety"}, "", {
            { TRANSLATE("The Country Club"), {"thecountryclub"}, TRANSLATE("(Prep)") },
            { TRANSLATE("Guest List"), {"guestlist"}, TRANSLATE("(Prep)") },
            { TRANSLATE("High Society"), {"highsociety"}, TRANSLATE("(Mission)") },
        }, function(index)
            if index == 1 then
                STAT_SET_INT("FIXER_STORY_BS", 28)
            elseif index == 2 then
                STAT_SET_INT("FIXER_STORY_BS", 60)
            elseif index == 3 then
                STAT_SET_INT("FIXER_STORY_BS", 124)
            end

            STAT_SET_INT("FIXER_GENERAL_BS", -1)
            STAT_SET_INT("FIXER_COMPLETED_BS", -1)
            STAT_SET_INT("FIXER_STORY_STRAND", -1)
            STAT_SET_INT("FIXER_STORY_COOLDOWN", -1)
        end)

        menu.list_action(CONTRACT_VIP, TRANSLATE("South Central Leak"), {"hcagccentral"}, "", {
            { TRANSLATE("Davis"), {"davis"}, TRANSLATE("(Prep)") },
            { TRANSLATE("The Ballas"), {"theballas"}, TRANSLATE("(Prep)") },
            { TRANSLATE("Agency Studio"), {"agencystudio"}, TRANSLATE("(Mission)") },
            { TRANSLATE("Don't Fuck with Dre"), {"dontfuckwithdre"}, TRANSLATE("(Finale)") },
        }, function(index)
            if index == 1 then
                STAT_SET_INT("FIXER_STORY_BS", 252)
            elseif index == 2 then
                STAT_SET_INT("FIXER_STORY_BS", 508)
            elseif index == 3 then
                STAT_SET_INT("FIXER_STORY_BS", 2044)
            elseif index == 4 then
                STAT_SET_INT("FIXER_STORY_BS", 4092)
            end

            STAT_SET_INT("FIXER_GENERAL_BS", -1)
            STAT_SET_INT("FIXER_COMPLETED_BS", -1)
            STAT_SET_INT("FIXER_STORY_STRAND", -1)
            STAT_SET_INT("FIXER_STORY_COOLDOWN", -1)
        end)

        menu.toggle_loop(TH_CONTRACT, TRANSLATE("Modify Finale's Payout (2 Million)"), {"hcagc2m"}, IS_WORKING(true) .. TRANSLATE("(Local)"), function()
            SET_INT_GLOBAL(262145 + 31747, 2000000) -- FIXER_FINALE_LEADER_CASH_REWARD
        end, function()
            SET_INT_GLOBAL(262145 + 31747, 1000000)
        end)

        menu.toggle_loop(TH_CONTRACT, TRANSLATE("Remove Contracts & Payphone Hits Cooldown"), {"hcagcremcontractcool"}, IS_WORKING(true) .. TRANSLATE("Make sure it's enabled before starting any contracts or hits."), function() -- Credit goes to Da Chaos#9262
            SET_INT_GLOBAL(262145 + 31701, 0) -- FIXER_SECURITY_CONTRACT_COOLDOWN_TIME
            SET_INT_GLOBAL(262145 + 31765, 0) -- -2036534141
        end, function()
            SET_INT_GLOBAL(262145 + 31701, 300000)
            SET_INT_GLOBAL(262145 + 31765, 500)
        end)

        menu.toggle_loop(TH_CONTRACT, TRANSLATE("Remove Security Mission Cooldown"), {"hcagcremsecuritycool"}, IS_WORKING(false), function()
            SET_INT_GLOBAL(262145 + 31781, 0) -- 1872071131
        end, function()
            SET_INT_GLOBAL(262145 + 31781, 1200000)
        end)

        menu.textslider(TH_CONTRACT, TRANSLATE("Remote Access: Agency App"), {"hcappagency"}, TRANSLATE("Note that you don't have the app, some of functions won't work."), {
            TRANSLATE("Open"),
            TRANSLATE("Close"),
        }, function()
            START_SCRIPT("CEO", "appfixersecurity")
        end)

        menu.action(TH_CONTRACT, TRANSLATE("Complete All Missions"), {}, "", function()
            STAT_SET_INT("FIXER_GENERAL_BS", -1)
            STAT_SET_INT("FIXER_COMPLETED_BS", -1)
            STAT_SET_INT("FIXER_STORY_BS", -1)
            STAT_SET_INT("FIXER_STORY_COOLDOWN", -1)
        end)

    ---

---


--- Master Unlocker

    DLC_UNLOCKER = menu.list(MASTER_UNLOCKR, TRANSLATE("DLCs"), {}, "", function(); end)

        ARENA_TOOL = menu.list(DLC_UNLOCKER, TRANSLATE("Arena Wars DLC"), {}, "", function(); end)

            menu.action(ARENA_TOOL, TRANSLATE("Unlock all Arena Wars Trophies and Toys"), {}, "", function()
                STAT_SET_INT("ARN_BS_TRINKET_TICKERS", -1)
                STAT_SET_INT("ARN_BS_TRINKET_SAVED", -1)
                STAT_SET_INT("AWD_WATCH_YOUR_STEP", 50)
                STAT_SET_INT("AWD_TOWER_OFFENSE", 50)
                STAT_SET_INT("AWD_READY_FOR_WAR", 50)
                STAT_SET_INT("AWD_THROUGH_A_LENS", 50)
                STAT_SET_INT("AWD_SPINNER", 50)
                STAT_SET_INT("AWD_YOUMEANBOOBYTRAPS", 50)
                STAT_SET_INT("AWD_MASTER_BANDITO", 50)
                STAT_SET_INT("AWD_SITTING_DUCK", 50)
                STAT_SET_INT("AWD_CROWDPARTICIPATION", 50)
                STAT_SET_INT("AWD_KILL_OR_BE_KILLED", 50)
                STAT_SET_INT("AWD_MASSIVE_SHUNT", 50)
                STAT_SET_INT("AWD_YOURE_OUTTA_HERE", 200)
                STAT_SET_INT("AWD_WEVE_GOT_ONE", 50)
                STAT_SET_INT("AWD_ARENA_WAGEWORKER", 1000000)
                STAT_SET_INT("AWD_TIME_SERVED", 1000)
                STAT_SET_INT("AWD_TOP_SCORE", 55000)
                STAT_SET_INT("AWD_CAREER_WINNER", 1000)
                STAT_SET_INT("ARENAWARS_SP", 209)
                STAT_SET_INT("ARENAWARS_SKILL_LEVEL", 20)
                STAT_SET_INT("ARENAWARS_SP_LIFETIME", 209)
                STAT_SET_INT("ARENAWARS_AP_TIER", 1000)
                STAT_SET_INT("ARENAWARS_AP_LIFETIME", 47551850)
                STAT_SET_INT("ARENAWARS_CARRER_UNLK", 44)
                STAT_SET_INT("ARN_W_THEME_SCIFI", 1000)
                STAT_SET_INT("ARN_W_THEME_APOC", 1000)
                STAT_SET_INT("ARN_W_THEME_CONS", 1000)
                STAT_SET_INT("ARN_W_PASS_THE_BOMB", 1000)
                STAT_SET_INT("ARN_W_DETONATION", 1000)
                STAT_SET_INT("ARN_W_ARCADE_RACE", 1000)
                STAT_SET_INT("ARN_W_CTF", 1000)
                STAT_SET_INT("ARN_W_TAG_TEAM", 1000)
                STAT_SET_INT("ARN_W_DESTR_DERBY", 1000)
                STAT_SET_INT("ARN_W_CARNAGE", 1000)
                STAT_SET_INT("ARN_W_MONSTER_JAM", 1000)
                STAT_SET_INT("ARN_W_GAMES_MASTERS", 1000)
                STAT_SET_INT("ARN_L_PASS_THE_BOMB", 500)
                STAT_SET_INT("ARN_L_DETONATION", 500)
                STAT_SET_INT("ARN_L_ARCADE_RACE", 500)
                STAT_SET_INT("ARN_L_CTF", 500)
                STAT_SET_INT("ARN_L_TAG_TEAM", 500)
                STAT_SET_INT("ARN_L_DESTR_DERBY", 500)
                STAT_SET_INT("ARN_L_CARNAGE", 500)
                STAT_SET_INT("ARN_L_MONSTER_JAM", 500)
                STAT_SET_INT("ARN_L_GAMES_MASTERS", 500)
                STAT_SET_INT("NUMBER_OF_CHAMP_BOUGHT", 1000)
                STAT_SET_INT("ARN_SPECTATOR_KILLS", 1000)
                STAT_SET_INT("ARN_LIFETIME_KILLS", 1000)
                STAT_SET_INT("ARN_LIFETIME_DEATHS", 500)
                STAT_SET_INT("ARENAWARS_CARRER_WINS", 1000)
                STAT_SET_INT("ARENAWARS_CARRER_WINT", 1000)
                STAT_SET_INT("ARENAWARS_MATCHES_PLYD", 1000)
                STAT_SET_INT("ARENAWARS_MATCHES_PLYDT", 1000)
                STAT_SET_INT("ARN_SPEC_BOX_TIME_MS", 86400000)
                STAT_SET_INT("ARN_SPECTATOR_DRONE", 1000)
                STAT_SET_INT("ARN_SPECTATOR_CAMS", 1000)
                STAT_SET_INT("ARN_SMOKE", 1000)
                STAT_SET_INT("ARN_DRINK", 1000)
                STAT_SET_INT("ARN_VEH_MONSTER", 31000)
                STAT_SET_INT("ARN_VEH_MONSTER", 41000)
                STAT_SET_INT("ARN_VEH_MONSTER", 51000)
                STAT_SET_INT("ARN_VEH_CERBERUS", 1000)
                STAT_SET_INT("ARN_VEH_CERBERUS2", 1000)
                STAT_SET_INT("ARN_VEH_CERBERUS3", 1000)
                STAT_SET_INT("ARN_VEH_BRUISER", 1000)
                STAT_SET_INT("ARN_VEH_BRUISER2", 1000)
                STAT_SET_INT("ARN_VEH_BRUISER3", 1000)
                STAT_SET_INT("ARN_VEH_SLAMVAN4", 1000)
                STAT_SET_INT("ARN_VEH_SLAMVAN5", 1000)
                STAT_SET_INT("ARN_VEH_SLAMVAN6", 1000)
                STAT_SET_INT("ARN_VEH_BRUTUS", 1000)
                STAT_SET_INT("ARN_VEH_BRUTUS2", 1000)
                STAT_SET_INT("ARN_VEH_BRUTUS3", 1000)
                STAT_SET_INT("ARN_VEH_SCARAB", 1000)
                STAT_SET_INT("ARN_VEH_SCARAB2", 1000)
                STAT_SET_INT("ARN_VEH_SCARAB3", 1000)
                STAT_SET_INT("ARN_VEH_DOMINATOR4", 1000)
                STAT_SET_INT("ARN_VEH_DOMINATOR5", 1000)
                STAT_SET_INT("ARN_VEH_DOMINATOR6", 1000)
                STAT_SET_INT("ARN_VEH_IMPALER2", 1000)
                STAT_SET_INT("ARN_VEH_IMPALER3", 1000)
                STAT_SET_INT("ARN_VEH_IMPALER4", 1000)
                STAT_SET_INT("ARN_VEH_ISSI4", 1000)
                STAT_SET_INT("ARN_VEH_ISSI5", 1000)
                STAT_SET_INT("ARN_VEH_ISSI", 61000)
                STAT_SET_INT("ARN_VEH_IMPERATOR", 1000)
                STAT_SET_INT("ARN_VEH_IMPERATOR2", 1000)
                STAT_SET_INT("ARN_VEH_IMPERATOR3", 1000)
                STAT_SET_INT("ARN_VEH_ZR380", 1000)
                STAT_SET_INT("ARN_VEH_ZR3802", 1000)
                STAT_SET_INT("ARN_VEH_ZR3803", 1000)
                STAT_SET_INT("ARN_VEH_DEATHBIKE", 1000)
                STAT_SET_INT("ARN_VEH_DEATHBIKE2", 1000)
                STAT_SET_INT("ARN_VEH_DEATHBIKE3", 1000)
                STAT_SET_BOOL("AWD_BEGINNER", true)
                STAT_SET_BOOL("AWD_FIELD_FILLER", true)
                STAT_SET_BOOL("AWD_ARMCHAIR_RACER", true)
                STAT_SET_BOOL("AWD_LEARNER", true)
                STAT_SET_BOOL("AWD_SUNDAY_DRIVER", true)
                STAT_SET_BOOL("AWD_THE_ROOKIE", true)
                STAT_SET_BOOL("AWD_BUMP_AND_RUN", true)
                STAT_SET_BOOL("AWD_GEAR_HEAD", true)
                STAT_SET_BOOL("AWD_DOOR_SLAMMER", true)
                STAT_SET_BOOL("AWD_HOT_LAP", true)
                STAT_SET_BOOL("AWD_ARENA_AMATEUR", true)
                STAT_SET_BOOL("AWD_PAINT_TRADER", true)
                STAT_SET_BOOL("AWD_SHUNTER", true)
                STAT_SET_BOOL("AWD_JOCK", true)
                STAT_SET_BOOL("AWD_WARRIOR", true)
                STAT_SET_BOOL("AWD_T_BONE", true)
                STAT_SET_BOOL("AWD_MAYHEM", true)
                STAT_SET_BOOL("AWD_WRECKER", true)
                STAT_SET_BOOL("AWD_CRASH_COURSE", true)
                STAT_SET_BOOL("AWD_ARENA_LEGEND", true)
                STAT_SET_BOOL("AWD_PEGASUS", true)
                STAT_SET_BOOL("AWD_UNSTOPPABLE", true)
                STAT_SET_BOOL("AWD_CONTACT_SPORT", true)
            end)

            menu.action(ARENA_TOOL, TRANSLATE("Unlock Clothing"), {}, IS_WORKING(false), function()
                SET_PACKED_INT_GLOBAL(25842, 25909, 1) -- -1782918513, -1597048932
            end)

        ---

        SUMMER2020 = menu.list(DLC_UNLOCKER, TRANSLATE("Summer 2020 DLC"), {}, "", function(); end)
                
            menu.action(SUMMER2020, TRANSLATE("Summer 2020 Awards"), {}, "", function()
                STAT_SET_BOOL("AWD_KINGOFQUB3D", true)
                STAT_SET_BOOL("AWD_QUBISM", true)
                STAT_SET_BOOL("AWD_QUIBITS", true)
                STAT_SET_BOOL("AWD_GODOFQUB3D", true)
                STAT_SET_BOOL("AWD_GOFOR11TH", true)
                STAT_SET_BOOL("AWD_ELEVENELEVEN", true)
            end)

            menu.action(SUMMER2020, TRANSLATE("Unlock Clothing"), {}, IS_WORKING(false), function()
                SET_PACKED_INT_GLOBAL(29685, 29720, 1) -- ENABLE_LOGIN_BCTR_AGED_TEE, ENABLE_LOGIN_LEMON_SPORTS_TRACK_TOP
            end)

        ---

        TUNERS_DLC = menu.list(DLC_UNLOCKER, TRANSLATE("LS Tuners DLC"), {}, "", function(); end)

            menu.action(TUNERS_DLC, TRANSLATE("Unlock Awards"), {}, "", function()
                STAT_SET_INT("AWD_CAR_CLUB_MEM", 100)
                STAT_SET_INT("AWD_SPRINTRACER", 50)
                STAT_SET_INT("AWD_STREETRACER", 50)
                STAT_SET_INT("AWD_PURSUITRACER", 50)
                STAT_SET_INT("AWD_TEST_CAR", 240)
                STAT_SET_INT("AWD_AUTO_SHOP", 50)
                STAT_SET_INT("AWD_CAR_EXPORT", 100)
                STAT_SET_INT("AWD_GROUNDWORK", 40)
                STAT_SET_INT("AWD_ROBBERY_CONTRACT", 100)
                STAT_SET_INT("AWD_FACES_OF_DEATH", 100)
                STAT_SET_BOOL("AWD_CAR_CLUB", true)
                STAT_SET_BOOL("AWD_PRO_CAR_EXPORT", true)
                STAT_SET_BOOL("AWD_UNION_DEPOSITORY", true)
                STAT_SET_BOOL("AWD_MILITARY_CONVOY", true)
                STAT_SET_BOOL("AWD_FLEECA_BANK", true)
                STAT_SET_BOOL("AWD_FREIGHT_TRAIN", true)
                STAT_SET_BOOL("AWD_BOLINGBROKE_ASS", true)
                STAT_SET_BOOL("AWD_IAA_RAID", true)
                STAT_SET_BOOL("AWD_METH_JOB", true)
                STAT_SET_BOOL("AWD_BUNKER_RAID", true)
                STAT_SET_BOOL("AWD_STRAIGHT_TO_VIDEO", true)
                STAT_SET_BOOL("AWD_MONKEY_C_MONKEY_DO", true)
                STAT_SET_BOOL("AWD_TRAINED_TO_KILL", true)
                STAT_SET_BOOL("AWD_DIRECTOR", true)
            end)

        ---

        CONTRACT_DLC = menu.list(DLC_UNLOCKER, TRANSLATE("The Contract DLC"), {}, "", function(); end)

            menu.action(CONTRACT_DLC, TRANSLATE("Unlock Animal Masks"), {}, IS_WORKING(false), function()
                SET_PACKED_INT_GLOBAL(31859, 31870, 1) -- FIXER_LOGIN_AWARD_FISHMASK_1, FIXER_LOGIN_AWARD_SEALMASK_4
            end)
            menu.action(CONTRACT_DLC, TRANSLATE("Unlock DJ Pooh Shirts"), {}, IS_WORKING(false), function()
                SET_PACKED_INT_GLOBAL(31871, 31873, 1) -- FIXER_LOGIN_DJ_POOH_ORANGE, FIXER_LOGIN_DJ_POOH_BLUE
            end)

        ---

        CRIMINAL_DLC = menu.list(DLC_UNLOCKER, TRANSLATE("The Criminal Enterprises DLC"), {}, "", function(); end) -- https://www.unknowncheats.me/forum/3492512-post53.html
            
            menu.action(CRIMINAL_DLC, TRANSLATE("Jackets / Sweaters / Hoodies / Shirts"), {}, IS_WORKING(false), function()
                SET_PACKED_INT_GLOBAL(32907, 32914, 1) -- -1967834023, -1263992372
                SET_PACKED_INT_GLOBAL(32930, 32935, 1) -- -206691492, -1577621449
            end)
            menu.action(CRIMINAL_DLC, TRANSLATE("Pants / Caps / Hats"), {}, IS_WORKING(false), function()
                SET_PACKED_INT_GLOBAL(32917, 32919, 1) -- 638571354, 96152168
                SET_PACKED_INT_GLOBAL(32936, 32937, 1) -- -2120678580, -1003907171
                SET_PACKED_INT_GLOBAL(32988, 33001, 1) -- 191276118, -1484490421
                SET_PACKED_INT_GLOBAL(33654, 33662, 1) -- SUM2_CHRISTMAS_BEERHAT_LEMON, Between SUM2_CHRISTMAS_BEERHAT_RED_REINDEER and -1267850277
                SET_INT_GLOBAL(262145 + 32913, 1) -- -339902614
            end)
            menu.action(CRIMINAL_DLC, TRANSLATE("Earphones / Masks / Tech Demon"), {}, IS_WORKING(false), function()
                SET_PACKED_INT_GLOBAL(33002, 33013, 1) -- -889497715, -1162924007
                SET_PACKED_INT_GLOBAL(32922, 32927, 1) -- 1096886904, -359187968
                SET_PACKED_INT_GLOBAL(32942, 32950, 1) -- 190205845, -171130807
                SET_PACKED_INT_GLOBAL(32954, 32957, 1) -- 1424509866, -1677619307
                SET_PACKED_INT_GLOBAL(32958, 32983, 1) -- -1285035231, -1792568167
                SET_INT_GLOBAL(262145 + 32929, 1) -- 505550305
            end)
            menu.action(CRIMINAL_DLC, TRANSLATE("Shoes (Sliders) / Tiger"), {}, IS_WORKING(false), function()
                SET_PACKED_INT_GLOBAL(32984, 32987, 1) -- 467678514, 169972145
                SET_PACKED_INT_GLOBAL(33014, 33037, 1) -- 245491514, -141827484
            end)
            
        ---

        DRUG_WAR = menu.list(DLC_UNLOCKER, TRANSLATE("Drug War DLC"), {}, "", function(); end)

            menu.action(DRUG_WAR, TRANSLATE("Unlock Clothing"), {}, IS_WORKING(false), function() -- https://www.unknowncheats.me/forum/3635453-post69.html
                SET_PACKED_INT_GLOBAL(33973, 34112, 1) -- EVENT_LOGIN_DLC22022_ICE_VINYL_JACKET_3, -711496356
            end)

        ---

    ---

    UNLOCKER_BUILDING = menu.list(MASTER_UNLOCKR, TRANSLATE("Buildings"), {}, "", function(); end)

        menu.action(UNLOCKER_BUILDING, TRANSLATE("Skip Nightclub Setups"), {}, TRANSLATE("Skip all of setups when you buy a Nightclub first: Equipment, Staff, and Collect DJ") .. "\n\n" .. TRANSLATE("Change your session to apply!"), function() -- https://www.unknowncheats.me/forum/3735297-post3416.html
            SET_PACKED_STAT_BOOL_CODE(18161, true)
            SET_PACKED_STAT_BOOL_CODE(22067, true)
            SET_PACKED_STAT_BOOL_CODE(22068, true)
        end)

        menu.action(UNLOCKER_BUILDING, TRANSLATE("Acid Lab Equipment Upgrade"), {}, "", function() -- https://www.unknowncheats.me/forum/3631045-post2754.html
            STAT_SET_INT("AWD_CALLME", 10)
        end)

        menu.action(UNLOCKER_BUILDING, TRANSLATE("Unlock Nightclub Awards"), {}, "", function()
            STAT_SET_INT("AWD_DANCE_TO_SOLOMUN", 120)
            STAT_SET_INT("AWD_DANCE_TO_TALEOFUS", 120)
            STAT_SET_INT("AWD_DANCE_TO_DIXON", 120)
            STAT_SET_INT("AWD_DANCE_TO_BLKMAD", 120)
            STAT_SET_INT("AWD_CLUB_DRUNK", 200)
            STAT_SET_INT("NIGHTCLUB_VIP_APPEAR", 700)
            STAT_SET_INT("NIGHTCLUB_JOBS_DONE", 700)
            STAT_SET_INT("NIGHTCLUB_EARNINGS", 20721002)
            STAT_SET_INT("HUB_SALES_COMPLETED", 1001)
            STAT_SET_INT("HUB_EARNINGS", 320721002)
            STAT_SET_INT("DANCE_COMBO_DURATION_MINS", 3600000)
            STAT_SET_INT("NIGHTCLUB_PLAYER_APPEAR", 9506)
            STAT_SET_INT("LIFETIME_HUB_GOODS_SOLD", 784672)
            STAT_SET_INT("LIFETIME_HUB_GOODS_MADE", 507822)
            STAT_SET_INT("DANCEPERFECTOWNCLUB", 120)
            STAT_SET_INT("NUMUNIQUEPLYSINCLUB", 120)
            STAT_SET_INT("DANCETODIFFDJS", 4)
            STAT_SET_INT("NIGHTCLUB_HOTSPOT_TIME_MS", 3600000)
            STAT_SET_INT("NIGHTCLUB_CONT_TOTAL", 20)
            STAT_SET_INT("NIGHTCLUB_CONT_MISSION", -1)
            STAT_SET_INT("CLUB_CONTRABAND_MISSION", 1000)
            STAT_SET_INT("HUB_CONTRABAND_MISSION", 1000)
            STAT_SET_BOOL("AWD_CLUB_HOTSPOT", true)
            STAT_SET_BOOL("AWD_CLUB_CLUBBER", true)
            STAT_SET_BOOL("AWD_CLUB_COORD", true)
        end)

        menu.action(UNLOCKER_BUILDING, TRANSLATE("Unlock Arcade Awards"), {}, IS_WORKING(false) .. TRANSLATE("Trophies, toys, and clothings are included."), function()
            STAT_SET_INT("AWD_PREPARATION", 40)
            STAT_SET_INT("AWD_ASLEEPONJOB", 20)
            STAT_SET_INT("AWD_DAICASHCRAB", 100000)
            STAT_SET_INT("AWD_BIGBRO", 40)
            STAT_SET_INT("AWD_SHARPSHOOTER", 40)
            STAT_SET_INT("AWD_RACECHAMP", 40)
            STAT_SET_INT("AWD_BATSWORD", 1000000)
            STAT_SET_INT("AWD_COINPURSE", 950000)
            STAT_SET_INT("AWD_ASTROCHIMP", 3000000)
            STAT_SET_INT("AWD_MASTERFUL", 40000)
            STAT_SET_INT("SCGW_NUM_WINS_GANG_0", 50)
            STAT_SET_INT("SCGW_NUM_WINS_GANG_1", 50)
            STAT_SET_INT("SCGW_NUM_WINS_GANG_2", 50)
            STAT_SET_INT("SCGW_NUM_WINS_GANG_3", 50)
            STAT_SET_INT("CH_ARC_CAB_CLAW_TROPHY", -1)
            STAT_SET_INT("CH_ARC_CAB_LOVE_TROPHY", -1)
            STAT_SET_INT("IAP_MAX_MOON_DIST", INT_MAX)
            STAT_SET_INT("IAP_SCORE_0", 69644)
            STAT_SET_INT("IAP_SCORE_1", 50333)
            STAT_SET_INT("IAP_SCORE_2", 63512)
            STAT_SET_INT("IAP_SCORE_3", 46136)
            STAT_SET_INT("IAP_SCORE_4", 21638)
            STAT_SET_INT("IAP_SCORE_5", 2133)
            STAT_SET_INT("IAP_SCORE_6", 1215)
            STAT_SET_INT("IAP_SCORE_7", 2444)
            STAT_SET_INT("IAP_SCORE_8", 38023)
            STAT_SET_INT("IAP_SCORE_9", 2233)
            STAT_SET_INT("SCGW_SCORE_1", 50)
            STAT_SET_INT("SCGW_SCORE_2", 50)
            STAT_SET_INT("SCGW_SCORE_3", 50)
            STAT_SET_INT("SCGW_SCORE_4", 50)
            STAT_SET_INT("SCGW_SCORE_5", 50)
            STAT_SET_INT("SCGW_SCORE_6", 50)
            STAT_SET_INT("SCGW_SCORE_7", 50)
            STAT_SET_INT("SCGW_SCORE_8", 50)
            STAT_SET_INT("SCGW_SCORE_9", 50)

            for i = 0, 9 do
                STAT_SET_INT("IAP_INITIALS_" .. i, 50)
                STAT_SET_INT("DG_DEFENDER_INITIALS_" .. i, 69644)
                STAT_SET_INT("DG_DEFENDER_SCORE_" .. i, 50)
                STAT_SET_INT("DG_MONKEY_INITIALS_" .. i, 69644)
                STAT_SET_INT("DG_MONKEY_SCORE_" .. i, 50)
                STAT_SET_INT("DG_PENETRATOR_INITIALS_" .. i, 69644)
                STAT_SET_INT("DG_PENETRATOR_SCORE_" .. i, 50)
                STAT_SET_INT("GGSM_INITIALS_" .. i, 69644)
                STAT_SET_INT("GGSM_SCORE_" .. i, 50)
                STAT_SET_INT("TWR_INITIALS_" .. i, 69644)
                STAT_SET_INT("TWR_SCORE_" .. i, 50)
            end

            STAT_SET_BOOL("AWD_SCOPEOUT", true)
            STAT_SET_BOOL("AWD_CREWEDUP", true)
            STAT_SET_BOOL("AWD_MOVINGON", true)
            STAT_SET_BOOL("AWD_PROMOCAMP", true)
            STAT_SET_BOOL("AWD_GUNMAN", true)
            STAT_SET_BOOL("AWD_SMASHNGRAB", true)
            STAT_SET_BOOL("AWD_INPLAINSI", true)
            STAT_SET_BOOL("AWD_UNDETECTED", true)
            STAT_SET_BOOL("AWD_ALLROUND", true)
            STAT_SET_BOOL("AWD_ELITETHEIF", true)
            STAT_SET_BOOL("AWD_PRO", true)
            STAT_SET_BOOL("AWD_SUPPORTACT", true)
            STAT_SET_BOOL("AWD_SHAFTED", true)
            STAT_SET_BOOL("AWD_COLLECTOR", true)
            STAT_SET_BOOL("AWD_DEADEYE", true)
            STAT_SET_BOOL("AWD_PISTOLSATDAWN", true)
            STAT_SET_BOOL("AWD_TRAFFICAVOI", true)
            STAT_SET_BOOL("AWD_CANTCATCHBRA", true)
            STAT_SET_BOOL("AWD_WIZHARD", true)
            STAT_SET_BOOL("AWD_APEESCAPE", true)
            STAT_SET_BOOL("AWD_MONKEYKIND", true)
            STAT_SET_BOOL("AWD_AQUAAPE", true)
            STAT_SET_BOOL("AWD_KEEPFAITH", true)
            STAT_SET_BOOL("AWD_TRUELOVE", true)
            STAT_SET_BOOL("AWD_NEMESIS", true)
            STAT_SET_BOOL("AWD_FRIENDZONED", true)
            STAT_SET_BOOL("IAP_CHALLENGE_0", true)
            STAT_SET_BOOL("IAP_CHALLENGE_1", true)
            STAT_SET_BOOL("IAP_CHALLENGE_2", true)
            STAT_SET_BOOL("IAP_CHALLENGE_3", true)
            STAT_SET_BOOL("IAP_CHALLENGE_4", true)
            STAT_SET_BOOL("IAP_GOLD_TANK", true)
            STAT_SET_BOOL("SCGW_WON_NO_DEATHS", true)

            SET_PACKED_INT_GLOBAL(28316, 28336, 1) -- STREET_CRIMES_BOXART_TEE, RED_FAME_OR_SHAME_KRONOS, For Clothing
        end)

        menu.action(UNLOCKER_BUILDING, TRANSLATE("Casino Store Ace Masks"), {}, IS_WORKING(true) .. TRANSLATE("Make sure click before buying. When you change your session, will be changed to non-unlocked status."), function()
            SET_PACKED_INT_GLOBAL(27530, 27533, 1) -- VC_ACE_OF_SPADES, VC_ACE_OF_DIAMONDS
        end)

        menu.action(UNLOCKER_BUILDING, TRANSLATE("Add Cosmetic Decorations To The Office/MC"), {}, TRANSLATE("To apply, sell special crate or vehicle cargo and change your session!"), function()
            STAT_SET_INT("LIFETIME_BUY_COMPLETE", 1000)
            STAT_SET_INT("LIFETIME_BUY_UNDERTAKEN", 1000)
            STAT_SET_INT("LIFETIME_SELL_COMPLETE", 1000)
            STAT_SET_INT("LIFETIME_SELL_UNDERTAKEN", 1000)
            STAT_SET_INT("LIFETIME_CONTRA_EARNINGS", 20000000)
            STAT_SET_INT("LIFETIME_BIKER_BUY_COMPLET", 1000)
            STAT_SET_INT("LIFETIME_BIKER_BUY_UNDERTA", 1000)
            STAT_SET_INT("LIFETIME_BIKER_SELL_COMPLET", 1000)
            STAT_SET_INT("LIFETIME_BIKER_SELL_UNDERTA", 1000)
            STAT_SET_INT("LIFETIME_BKR_SELL_EARNINGS0", 20000000)

            for i = 1, 5 do
                STAT_SET_INT("LIFETIME_BIKER_BUY_COMPLET" .. i, 1000)
                STAT_SET_INT("LIFETIME_BIKER_BUY_UNDERTA" .. i, 1000)
                STAT_SET_INT("LIFETIME_BIKER_SELL_COMPLET" .. i, 1000)
                STAT_SET_INT("LIFETIME_BIKER_SELL_UNDERTA" .. i, 1000)
                STAT_SET_INT("LIFETIME_BKR_SELL_EARNINGS" .. i, 20000000)
            end
        end)

    ---

    UNLOCKER_HEISTS = menu.list(MASTER_UNLOCKR, TRANSLATE("Heists"), {}, TRANSLATE("Unlocks almost of unlockable stuffs related the heist like clothing, etc."), function(); end)

        menu.action(UNLOCKER_HEISTS, TRANSLATE("Cayo Perico Heist"), {}, IS_WORKING(false), function()
            STAT_SET_INT("AWD_LOSTANDFOUND", 500000)
            STAT_SET_INT("AWD_SUNSET", 1800000)
            STAT_SET_INT("AWD_TREASURE_HUNTER", 1000000)
            STAT_SET_INT("AWD_WRECK_DIVING", 1000000)
            STAT_SET_INT("AWD_KEINEMUSIK", 1800000)
            STAT_SET_INT("AWD_PALMS_TRAX", 1800000)
            STAT_SET_INT("AWD_MOODYMANN", 1800000)
            STAT_SET_INT("AWD_FILL_YOUR_BAGS", 1000000000)
            STAT_SET_INT("AWD_WELL_PREPARED", 80)
            STAT_SET_INT("H4_H4_DJ_MISSIONS", -1)
            STAT_SET_BOOL("AWD_INTELGATHER", true)
            STAT_SET_BOOL("AWD_COMPOUNDINFILT", true)
            STAT_SET_BOOL("AWD_LOOT_FINDER", true)
            STAT_SET_BOOL("AWD_MAX_DISRUPT", true)
            STAT_SET_BOOL("AWD_THE_ISLAND_HEIST", true)
            STAT_SET_BOOL("AWD_GOING_ALONE", true)
            STAT_SET_BOOL("AWD_TEAM_WORK", true)
            STAT_SET_BOOL("AWD_MIXING_UP", true)
            STAT_SET_BOOL("AWD_PRO_THIEF", true)
            STAT_SET_BOOL("AWD_CAT_BURGLAR", true)
            STAT_SET_BOOL("AWD_ONE_OF_THEM", true)
            STAT_SET_BOOL("AWD_GOLDEN_GUN", true)
            STAT_SET_BOOL("AWD_ELITE_THIEF", true)
            STAT_SET_BOOL("AWD_PROFESSIONAL", true)
            STAT_SET_BOOL("AWD_HELPING_OUT", true)
            STAT_SET_BOOL("AWD_COURIER", true)
            STAT_SET_BOOL("AWD_PARTY_VIBES", true)
            STAT_SET_BOOL("AWD_HELPING_HAND", true)
            STAT_SET_BOOL("AWD_ELEVENELEVEN", true)
            STAT_SET_BOOL("COMPLETE_H4_F_USING_VETIR", true)
            STAT_SET_BOOL("COMPLETE_H4_F_USING_LONGFIN", true)
            STAT_SET_BOOL("COMPLETE_H4_F_USING_ANNIH", true)
            STAT_SET_BOOL("COMPLETE_H4_F_USING_ALKONOS", true)
            STAT_SET_BOOL("COMPLETE_H4_F_USING_PATROLB", true)
            SET_PACKED_INT_GLOBAL(30209, 30232, 1) -- TOPS_ISLAND_HEIST_EVENT_JACKET_1, PANTS_BIGNESS_TIE_DYE_SWEAT_PANTS
            SET_PACKED_INT_GLOBAL(30238, 30277, 1) -- ACCESSORIES_GLOW_BRACELET_1, ACCESSORIES_GLOW_NECKLACE_16
            SET_PACKED_INT_GLOBAL(30282, 30301, 1) -- HEIST4_FESTIVE_MASK_0, HEIST4_FESTIVE_MASK_19
            SET_PACKED_INT_GLOBAL(30866, 30901, 1) -- ACCESSORIES_SUNGLASSES_1_0, ACCESSORIES_SUNGLASSES_3_11
            SET_PACKED_INT_GLOBAL(30911, 30916, 1) -- PALMS_TRAX_EVENT_TEE_1, STILL_SLIPPING_EVENT_TEE_2
        end)

        menu.action(UNLOCKER_HEISTS, TRANSLATE("Diamond Casino Heist"), {}, "", function()
            STAT_SET_INT("CAS_HEIST_NOTS", -1)
            STAT_SET_INT("CH_ARC_CAB_CLAW_TROPHY", -1)
            STAT_SET_INT("CH_ARC_CAB_LOVE_TROPHY", -1)
            STAT_SET_INT("SIGNAL_JAMMERS_COLLECTED", 50)
            STAT_SET_INT("AWD_ODD_JOBS", 52)
            STAT_SET_INT("AWD_PREPARATION", 40)
            STAT_SET_INT("AWD_ASLEEPONJOB", 20)
            STAT_SET_INT("AWD_DAICASHCRAB", 100000)
            STAT_SET_INT("AWD_BIGBRO", 40)
            STAT_SET_INT("AWD_SHARPSHOOTER", 40)
            STAT_SET_INT("AWD_RACECHAMP", 40)
            STAT_SET_INT("AWD_BATSWORD", 1000000)
            STAT_SET_INT("AWD_COINPURSE", 950000)
            STAT_SET_INT("AWD_ASTROCHIMP", 3000000)
            STAT_SET_INT("AWD_MASTERFUL", 40000)
            STAT_SET_INT("H3_BOARD_DIALOGUE0", -1)
            STAT_SET_INT("H3_BOARD_DIALOGUE1", -1)
            STAT_SET_INT("H3_BOARD_DIALOGUE2", -1)
            STAT_SET_INT("H3_VEHICLESUSED", -1)
            STAT_SET_BOOL("AWD_FIRST_TIME1", true)
            STAT_SET_BOOL("AWD_FIRST_TIME2", true)
            STAT_SET_BOOL("AWD_FIRST_TIME3", true)
            STAT_SET_BOOL("AWD_FIRST_TIME4", true)
            STAT_SET_BOOL("AWD_FIRST_TIME5", true)
            STAT_SET_BOOL("AWD_FIRST_TIME6", true)
            STAT_SET_BOOL("AWD_ALL_IN_ORDER", true)
            STAT_SET_BOOL("AWD_SUPPORTING_ROLE", true)
            STAT_SET_BOOL("AWD_LEADER", true)
            STAT_SET_BOOL("AWD_ODD_JOBS", true)
            STAT_SET_BOOL("AWD_SURVIVALIST", true)
            STAT_SET_BOOL("AWD_SCOPEOUT", true)
            STAT_SET_BOOL("AWD_CREWEDUP", true)
            STAT_SET_BOOL("AWD_MOVINGON", true)
            STAT_SET_BOOL("AWD_PROMOCAMP", true)
            STAT_SET_BOOL("AWD_GUNMAN", true)
            STAT_SET_BOOL("AWD_SMASHNGRAB", true)
            STAT_SET_BOOL("AWD_INPLAINSI", true)
            STAT_SET_BOOL("AWD_UNDETECTED", true)
            STAT_SET_BOOL("AWD_ALLROUND", true)
            STAT_SET_BOOL("AWD_ELITETHEIF", true)
            STAT_SET_BOOL("AWD_PRO", true)
            STAT_SET_BOOL("AWD_SUPPORTACT", true)
            STAT_SET_BOOL("AWD_SHAFTED", true)
            STAT_SET_BOOL("AWD_COLLECTOR", true)
            STAT_SET_BOOL("AWD_DEADEYE", true)
            STAT_SET_BOOL("AWD_PISTOLSATDAWN", true)
            STAT_SET_BOOL("AWD_TRAFFICAVOI", true)
            STAT_SET_BOOL("AWD_CANTCATCHBRA", true)
            STAT_SET_BOOL("AWD_WIZHARD", true)
            STAT_SET_BOOL("AWD_APEESCAPE", true)
            STAT_SET_BOOL("AWD_MONKEYKIND", true)
            STAT_SET_BOOL("AWD_AQUAAPE", true)
            STAT_SET_BOOL("AWD_KEEPFAITH", true)
            STAT_SET_BOOL("AWD_TRUELOVE", true)
            STAT_SET_BOOL("AWD_NEMESIS", true)
            STAT_SET_BOOL("AWD_FRIENDZONED", true)
            STAT_SET_BOOL("VCM_FLOW_CS_RSC_SEEN", true)
            STAT_SET_BOOL("VCM_FLOW_CS_BWL_SEEN", true)
            STAT_SET_BOOL("VCM_FLOW_CS_MTG_SEEN", true)
            STAT_SET_BOOL("VCM_FLOW_CS_OIL_SEEN", true)
            STAT_SET_BOOL("VCM_FLOW_CS_DEF_SEEN", true)
            STAT_SET_BOOL("VCM_FLOW_CS_FIN_SEEN", true)
            STAT_SET_BOOL("CAS_VEHICLE_REWARD", false)
            STAT_SET_BOOL("HELP_FURIA", true)
            STAT_SET_BOOL("HELP_MINITAN", true)
            STAT_SET_BOOL("HELP_YOSEMITE2", true)
            STAT_SET_BOOL("HELP_ZHABA", true)
            STAT_SET_BOOL("HELP_IMORGEN", true)
            STAT_SET_BOOL("HELP_SULTAN2", true)
            STAT_SET_BOOL("HELP_VAGRANT", true)
            STAT_SET_BOOL("HELP_VSTR", true)
            STAT_SET_BOOL("HELP_STRYDER", true)
            STAT_SET_BOOL("HELP_SUGOI", true)
            STAT_SET_BOOL("HELP_KANJO", true)
            STAT_SET_BOOL("HELP_FORMULA", true)
            STAT_SET_BOOL("HELP_FORMULA2", true)
            STAT_SET_BOOL("HELP_JB7002", true)
        end)

        menu.action(UNLOCKER_HEISTS, TRANSLATE("Doomsday Heist"), {}, "", function()
            STAT_SET_INT("GANGOPS_FM_MISSION_PROG", -1)
            STAT_SET_INT("GANGOPS_FLOW_MISSION_PROG", -1)
            STAT_SET_INT("MPPLY_GANGOPS_ALLINORDER", 100)
            STAT_SET_INT("MPPLY_GANGOPS_LOYALTY", 100)
            STAT_SET_INT("MPPLY_GANGOPS_CRIMMASMD", 100)
            STAT_SET_INT("MPPLY_GANGOPS_LOYALTY2", 100)
            STAT_SET_INT("MPPLY_GANGOPS_LOYALTY3", 100)
            STAT_SET_INT("MPPLY_GANGOPS_CRIMMASMD2", 100)
            STAT_SET_INT("MPPLY_GANGOPS_CRIMMASMD3", 100)
            STAT_SET_INT("MPPLY_GANGOPS_SUPPORT", 100)
            STAT_SET_INT("CR_GANGOP_MORGUE", 10)
            STAT_SET_INT("CR_GANGOP_DELUXO", 10)
            STAT_SET_INT("CR_GANGOP_SERVERFARM", 10)
            STAT_SET_INT("CR_GANGOP_IAABASE_FIN", 10)
            STAT_SET_INT("CR_GANGOP_STEALOSPREY", 10)
            STAT_SET_INT("CR_GANGOP_FOUNDRY", 10)
            STAT_SET_INT("CR_GANGOP_RIOTVAN", 10)
            STAT_SET_INT("CR_GANGOP_SUBMARINECAR", 10)
            STAT_SET_INT("CR_GANGOP_SUBMARINE_FIN", 10)
            STAT_SET_INT("CR_GANGOP_PREDATOR", 10)
            STAT_SET_INT("CR_GANGOP_BMLAUNCHER", 10)
            STAT_SET_INT("CR_GANGOP_BCCUSTOM", 10)
            STAT_SET_INT("CR_GANGOP_STEALTHTANKS", 10)
            STAT_SET_INT("CR_GANGOP_SPYPLANE", 10)
            STAT_SET_INT("CR_GANGOP_FINALE", 10)
            STAT_SET_INT("CR_GANGOP_FINALE_P2", 10)
            STAT_SET_INT("CR_GANGOP_FINALE_P3", 10)
            STAT_SET_BOOL("MPPLY_AWD_GANGOPS_IAA", true)
            STAT_SET_BOOL("MPPLY_AWD_GANGOPS_SUBMARINE", true)
            STAT_SET_BOOL("MPPLY_AWD_GANGOPS_MISSILE", true)
            STAT_SET_BOOL("MPPLY_AWD_GANGOPS_ALLINORDER", true)
            STAT_SET_BOOL("MPPLY_AWD_GANGOPS_LOYALTY", true)
            STAT_SET_BOOL("MPPLY_AWD_GANGOPS_LOYALTY2", true)
            STAT_SET_BOOL("MPPLY_AWD_GANGOPS_LOYALTY3", true)
            STAT_SET_BOOL("MPPLY_AWD_GANGOPS_CRIMMASMD", true)
            STAT_SET_BOOL("MPPLY_AWD_GANGOPS_CRIMMASMD2", true)
            STAT_SET_BOOL("MPPLY_AWD_GANGOPS_CRIMMASMD3", true)
        end)
        
        menu.action(UNLOCKER_HEISTS, TRANSLATE("Classic Heist"), {}, "", function()
            STAT_SET_INT("AWD_FINISH_HEISTS", 900)
            STAT_SET_INT("MPPLY_WIN_GOLD_MEDAL_HEISTS", 900)
            STAT_SET_INT("AWD_DO_HEIST_AS_MEMBER", 900)
            STAT_SET_INT("AWD_DO_HEIST_AS_THE_LEADER", 900)
            STAT_SET_INT("AWD_FINISH_HEIST_SETUP_JOB", 900)
            STAT_SET_INT("AWD_FINISH_HEIST", 900)
            STAT_SET_INT("HEIST_COMPLETION", 900)
            STAT_SET_INT("HEISTS_ORGANISED", 900)
            STAT_SET_INT("AWD_CONTROL_CROWDS", 900)
            STAT_SET_INT("AWD_WIN_GOLD_MEDAL_HEISTS", 900)
            STAT_SET_INT("AWD_COMPLETE_HEIST_NOT_DIE", 900)
            STAT_SET_INT("HEIST_START", 900)
            STAT_SET_INT("HEIST_END", 900)
            STAT_SET_INT("CUTSCENE_MID_PRISON", 900)
            STAT_SET_INT("CUTSCENE_MID_HUMANE", 900)
            STAT_SET_INT("CUTSCENE_MID_NARC", 900)
            STAT_SET_INT("CUTSCENE_MID_ORNATE", 900)
            STAT_SET_INT("CR_FLEECA_PREP_1", 5000)
            STAT_SET_INT("CR_FLEECA_PREP_2", 5000)
            STAT_SET_INT("CR_FLEECA_FINALE", 5000)
            STAT_SET_INT("CR_PRISON_PLANE", 5000)
            STAT_SET_INT("CR_PRISON_BUS", 5000)
            STAT_SET_INT("CR_PRISON_STATION", 5000)
            STAT_SET_INT("CR_PRISON_UNFINISHED_BIZ", 5000)
            STAT_SET_INT("CR_PRISON_FINALE", 5000)
            STAT_SET_INT("CR_HUMANE_KEY_CODES", 5000)
            STAT_SET_INT("CR_HUMANE_ARMORDILLOS", 5000)
            STAT_SET_INT("CR_HUMANE_EMP", 5000)
            STAT_SET_INT("CR_HUMANE_VALKYRIE", 5000)
            STAT_SET_INT("CR_HUMANE_FINALE", 5000)
            STAT_SET_INT("CR_NARC_COKE", 5000)
            STAT_SET_INT("CR_NARC_TRASH_TRUCK", 5000)
            STAT_SET_INT("CR_NARC_BIKERS", 5000)
            STAT_SET_INT("CR_NARC_WEED", 5000)
            STAT_SET_INT("CR_NARC_STEAL_METH", 5000)
            STAT_SET_INT("CR_NARC_FINALE", 5000)
            STAT_SET_INT("CR_PACIFIC_TRUCKS", 5000)
            STAT_SET_INT("CR_PACIFIC_WITSEC", 5000)
            STAT_SET_INT("CR_PACIFIC_HACK", 5000)
            STAT_SET_INT("CR_PACIFIC_BIKES", 5000)
            STAT_SET_INT("CR_PACIFIC_CONVOY", 5000)
            STAT_SET_INT("CR_PACIFIC_FINALE", 5000)
            STAT_SET_INT("MPPLY_HEIST_ACH_TRACKER", -1)
            STAT_SET_BOOL("MPPLY_AWD_COMPLET_HEIST_MEM", true)
            STAT_SET_BOOL("MPPLY_AWD_COMPLET_HEIST_1STPER", true)
            STAT_SET_BOOL("MPPLY_AWD_FLEECA_FIN", true)
            STAT_SET_BOOL("MPPLY_AWD_HST_ORDER", true)
            STAT_SET_BOOL("MPPLY_AWD_HST_SAME_TEAM", true)
            STAT_SET_BOOL("MPPLY_AWD_HST_ULT_CHAL", true)
            STAT_SET_BOOL("MPPLY_AWD_HUMANE_FIN", true)
            STAT_SET_BOOL("MPPLY_AWD_PACIFIC_FIN", true)
            STAT_SET_BOOL("MPPLY_AWD_PRISON_FIN", true)
            STAT_SET_BOOL("MPPLY_AWD_SERIESA_FIN", true)
            STAT_SET_BOOL("AWD_FINISH_HEIST_NO_DAMAGE", true)
            STAT_SET_BOOL("AWD_SPLIT_HEIST_TAKE_EVENLY", true)
            STAT_SET_BOOL("AWD_ALL_ROLES_HEIST", true)
            STAT_SET_BOOL("AWD_MATCHING_OUTFIT_HEIST", true)
            STAT_SET_BOOL("HEIST_PLANNING_DONE_PRINT", true)
            STAT_SET_BOOL("HEIST_PLANNING_DONE_HELP_0", true)
            STAT_SET_BOOL("HEIST_PLANNING_DONE_HELP_1", true)
            STAT_SET_BOOL("HEIST_PRE_PLAN_DONE_HELP_0", true)
            STAT_SET_BOOL("HEIST_CUTS_DONE_FINALE", true)
            STAT_SET_BOOL("HEIST_IS_TUTORIAL", false)
            STAT_SET_BOOL("HEIST_STRAND_INTRO_DONE", true)
            STAT_SET_BOOL("HEIST_CUTS_DONE_ORNATE", true)
            STAT_SET_BOOL("HEIST_CUTS_DONE_PRISON", true)
            STAT_SET_BOOL("HEIST_CUTS_DONE_BIOLAB", true)
            STAT_SET_BOOL("HEIST_CUTS_DONE_NARCOTIC", true)
            STAT_SET_BOOL("HEIST_CUTS_DONE_TUTORIAL", true)
            STAT_SET_BOOL("HEIST_AWARD_DONE_PREP", true)
            STAT_SET_BOOL("HEIST_AWARD_BOUGHT_IN", true)
        end)
        
        menu.action(UNLOCKER_HEISTS, TRANSLATE("The Contract: Agency"), {}, "", function()
            STAT_SET_INT("AWD_CONTRACTOR", 50)
            STAT_SET_INT("AWD_COLD_CALLER", 50)
            STAT_SET_INT("AWD_PRODUCER", 60)
            STAT_SET_INT("FIXERTELEPHONEHITSCOMPL", 10)
            STAT_SET_INT("PAYPHONE_BONUS_KILL_METHOD", 10)
            STAT_SET_INT("FIXER_COUNT", 501)
            STAT_SET_INT("FIXER_SC_VEH_RECOVERED", 501)
            STAT_SET_INT("FIXER_SC_VAL_RECOVERED", 501)
            STAT_SET_INT("FIXER_SC_GANG_TERMINATED", 501)
            STAT_SET_INT("FIXER_SC_VIP_RESCUED", 501)
            STAT_SET_INT("FIXER_SC_ASSETS_PROTECTED", 501)
            STAT_SET_INT("FIXER_SC_EQ_DESTROYED", 501)
            STAT_SET_INT("FIXER_EARNINGS", 300000)
            STAT_SET_BOOL("AWD_TEEING_OFF", true)
            STAT_SET_BOOL("AWD_PARTY_NIGHT", true)
            STAT_SET_BOOL("AWD_BILLIONAIRE_GAMES", true)
            STAT_SET_BOOL("AWD_HOOD_PASS", true)
            STAT_SET_BOOL("AWD_STUDIO_TOUR", true)
            STAT_SET_BOOL("AWD_DONT_MESS_DRE", true)
            STAT_SET_BOOL("AWD_BACKUP", true)
            STAT_SET_BOOL("AWD_SHORTFRANK_1", true)
            STAT_SET_BOOL("AWD_SHORTFRANK_2", true)
            STAT_SET_BOOL("AWD_SHORTFRANK_3", true)
            STAT_SET_BOOL("AWD_CONTR_KILLER", true)
            STAT_SET_BOOL("AWD_DOGS_BEST_FRIEND", true)
            STAT_SET_BOOL("AWD_MUSIC_STUDIO", true)
            STAT_SET_BOOL("AWD_SHORTLAMAR_1", true)
            STAT_SET_BOOL("AWD_SHORTLAMAR_2", true)
            STAT_SET_BOOL("AWD_SHORTLAMAR_3", true)
            STAT_SET_BOOL("BS_FRANKLIN_DIALOGUE_0", true)
            STAT_SET_BOOL("BS_FRANKLIN_DIALOGUE_1", true)
            STAT_SET_BOOL("BS_FRANKLIN_DIALOGUE_2", true)
            STAT_SET_BOOL("BS_IMANI_D_APP_SETUP", true)
            STAT_SET_BOOL("BS_IMANI_D_APP_STRAND", true)
            STAT_SET_BOOL("BS_IMANI_D_APP_PARTY", true)
            STAT_SET_BOOL("BS_IMANI_D_APP_PARTY_2", true)
            STAT_SET_BOOL("BS_IMANI_D_APP_PARTY_F", true)
            STAT_SET_BOOL("BS_IMANI_D_APP_BILL", true)
            STAT_SET_BOOL("BS_IMANI_D_APP_BILL_2", true)
            STAT_SET_BOOL("BS_IMANI_D_APP_BILL_F", true)
            STAT_SET_BOOL("BS_IMANI_D_APP_HOOD", true)
            STAT_SET_BOOL("BS_IMANI_D_APP_HOOD_2", true)
            STAT_SET_BOOL("BS_IMANI_D_APP_HOOD_F", true)
        end)

    ---

    UNLOCKER_MISSIONS = menu.list(MASTER_UNLOCKR, TRANSLATE("Missions"), {}, "", function(); end)

        menu.action(UNLOCKER_MISSIONS, TRANSLATE("Unlock Taxi Missions"), {}, IS_WORKING(false), function() -- https://github.com/ImSapphire/unlock_drug_war_content/blob/main/unlock_drug_war_content.lua
            SET_INT_GLOBAL(262145 + 33770, 1) -- XM22_TAXI_DRIVER_ENABLE
        end)

        menu.action(UNLOCKER_MISSIONS, TRANSLATE("Unlock Yacht Missions"), {}, "", function()
            STAT_SET_INT("YACHT_MISSION_PROG", 0)
            STAT_SET_INT("YACHT_MISSION_FLOW", 21845)
            STAT_SET_INT("CASINO_DECORATION_GIFT_1", -1)
        end)

        menu.action(UNLOCKER_MISSIONS, TRANSLATE("Unlock All Contacts"), {}, "", function()
            STAT_SET_INT("FM_ACT_PHN", -1)
            STAT_SET_INT("FM_VEH_TX1", -1)
            STAT_SET_INT("FM_CUT_DONE", -1)
            STAT_SET_INT("FM_CUT_DONE_2", -1)

            for i = 2, 9 do
                STAT_SET_INT("FM_ACT_PH" .. i, -1)
            end
        end)

        menu.action(UNLOCKER_MISSIONS, TRANSLATE("Skip Lamar Missions To The Last One"), {}, TRANSLATE("Change your session to apply!"), function() -- https://www.unknowncheats.me/forum/2770402-post3008.html
            STAT_SET_BOOL("LOW_FLOW_CS_DRV_SEEN", true)
            STAT_SET_BOOL("LOW_FLOW_CS_TRA_SEEN", true)
            STAT_SET_BOOL("LOW_FLOW_CS_FUN_SEEN", true)
            STAT_SET_BOOL("LOW_FLOW_CS_PHO_SEEN", true)
            STAT_SET_BOOL("LOW_FLOW_CS_FIN_SEEN", true)
            STAT_SET_BOOL("LOW_BEN_INTRO_CS_SEEN", true)
            util.yield_once()
            STAT_SET_INT("LOWRIDER_FLOW_COMPLETE", 3)
            util.yield_once()
            STAT_SET_INT("LOW_FLOW_CURRENT_PROG", 8)
            STAT_SET_INT("LOW_FLOW_CURRENT_CALL", 8)
        end)

    ---

    UNLOCKER_ANNIVERSARY = menu.list(MASTER_UNLOCKR, TRANSLATE("Special Anniversaries"), {}, "", function(); end)

        XMAS_FEATURES = menu.list(UNLOCKER_ANNIVERSARY, TRANSLATE("Christmas"), {}, "", function(); end)

            menu.toggle_loop(XMAS_FEATURES, TRANSLATE("Bypass Christmas Clothing"), {}, IS_WORKING(true) .. TRANSLATE("You must keep this feature enabled in order to wear it!"), function()
                SET_PACKED_INT_GLOBAL(9393, 9400, 0) -- DISABLE_SNOWBALLS, ENABLE_CLEAR_STRUCT_ON_TRAN_FAIL
                SET_PACKED_INT_GLOBAL(9401, 9402, 7) -- MAX_NUMBER_OF_SNOWBALLS, PICK_UP_NUMBER_OF_SNOWBALLS
            end)
            
            menu.action(XMAS_FEATURES, TRANSLATE("Unlock Christmas Liveries"), {}, "", function()
                for i = 1, 20 do
                    STAT_SET_INT("MPPLY_XMASLIVERIES" .. i, -1)
                end
            end)

            menu.action(XMAS_FEATURES, TRANSLATE("Unlock Christmas Content"), {}, IS_WORKING(false), function()
                SET_PACKED_INT_GLOBAL(9393, 9402, 1) -- DISABLE_SNOWBALLS, PICK_UP_NUMBER_OF_SNOWBALLS
                SET_PACKED_INT_GLOBAL(9449, 9451, 1) -- TOGGLE_CHRISTMAS_EVE_GIFT, TOGGLE_NEW_YEARS_DAY_GIFT
                SET_PACKED_INT_GLOBAL(12710, 12711, 1) -- XMAS2015_VEHICLE, XMAS2015_MASKS
                SET_PACKED_INT_GLOBAL(12816, 12819, 1) -- TOGGLE_2015_CHRISTMAS_EVE_GIFT, TOGGLE_2015_CHRISTMAS_DAY_GIFT
                SET_PACKED_INT_GLOBAL(19115, 19118, 1) -- TOGGLE_2016_CHRISTMAS_EVE_GIFT, TOGGLE_2016_CHRISTMAS_DAY_GIFT
                SET_PACKED_INT_GLOBAL(23407, 23415, 1) -- 1840129338, -495986083
                SET_PACKED_INT_GLOBAL(23434, 23437, 1) -- -101086705, TOGGLE_2017_CHRISTMAS_DAY_GIFT
                SET_PACKED_INT_GLOBAL(25834, 25836, 1) -- XMASDAYGIFT2018_CAR, XMASDAYGIFT2018_CAR2
                SET_PACKED_INT_GLOBAL(25838, 25841, 1) -- TOGGLE_2018_CHRISTMAS_EVE_GIFT, TOGGLE_2018_CHRISTMAS_DAY_GIFT
                SET_PACKED_INT_GLOBAL(28690, 28693, 1) -- TOGGLE_2019_CHRISTMAS_EVE_GIFT, TOGGLE_2019_CHRISTMAS_DAY_GIFT
                SET_PACKED_INT_GLOBAL(31756, 31757, 1) -- TOGGLE_2021_CHRISTMAS_GIFT, TOGGLE_2021_NEW_YEARS_GIFT
                SET_PACKED_INT_GLOBAL(33915, 33916, 1) -- XMASGIFTS2022, NEWYEARSGIFTS2022, https://www.unknowncheats.me/forum/3630405-post34.html (2022)
                SET_INT_GLOBAL(262145 + 4763, 1) -- TOGGLE_XMAS_CONTENT
                SET_INT_GLOBAL(262145 + 9185, 1) -- TOGGLE_GIFT_TO_PLAYER_WHEN_LOGGING_ON
                SET_INT_GLOBAL(262145 + 12713, 1) -- XMAS2015_PYJAMAS
                SET_INT_GLOBAL(262145 + 19256, 1) -- CHRISTMAS2016_CLOTHING
                SET_INT_GLOBAL(262145 + 23056, 1) -- CHRISTMAS2017_CLOTHING
                SET_INT_GLOBAL(262145 + 24203, 1) -- NEW_BH_VEHICLE_TEXT
                SET_INT_GLOBAL(262145 + 30902, 1) -- TOGGLE_2020_CHRISTMAS_DAY_GIFT
            end)

        ---

        menu.toggle_loop(UNLOCKER_ANNIVERSARY, TRANSLATE("Independence's Day"), {}, IS_WORKING(true) .. TRANSLATE("Note: You may need to keep activating to use some of Independence Day's contents."), function()
            SET_PACKED_INT_GLOBAL(8268, 8274, 1) -- INDEPENDENCE_DAY_DEACTIVATE_FIREWORKS_LAUNCHER, TOGGLE_ACTIVATE_MONSTER_TRUCK
            SET_PACKED_INT_GLOBAL(8297, 8303, 1) -- UNLOCKINDEPENDENCE_BEER_HAT_1, UNLOCKINDEPENDENCE_STATUE_HAPPINESS_SHIRT
            SET_INT_GLOBAL(262145 + 8259, 1) -- TOGGLE_ACTIVATE_INDEPENDENCE_PACK
        end)

        menu.action(UNLOCKER_ANNIVERSARY, TRANSLATE("Valentine's Day"), {}, IS_WORKING(false), function()
            SET_PACKED_INT_GLOBAL(12030, 12034, 1) -- TURN_ON_VALENTINE_WEAPON, TURN_ON_VALENTINE_CLOTHING
            SET_PACKED_INT_GLOBAL(13396, 13397, 1) -- TURN_ON_VALENTINE_2016_CLOTHING, TURN_ON_VALENTINE_2016_VEHICLE
            SET_INT_GLOBAL(262145 + 7059, 1) -- TURN_ON_VALENTINES_EVENT
        end)

    ---

    UNLOCKER_SHIRT_HAT = menu.list(MASTER_UNLOCKR, TRANSLATE("Clothes"), {}, "", function(); end)
    
        menu.action(UNLOCKER_SHIRT_HAT, TRANSLATE("Unlock Lots of Hats And Shirts"), {}, IS_WORKING(true) .. TRANSLATE("500+ unlocks are included, try and see how many clothes would be unlocked."), function()
            SET_PACKED_INT_GLOBAL(11955, 11964, 1) -- DLC_SHIRT_MELTDOWN, DLC_SHIRT_CAPOLAVORO
            SET_PACKED_INT_GLOBAL(12591, 12613, 1) -- AWARD_LOW_HATS_MAGNETICS_SCRIPT, AWARD_LOW_TSHIRT_VAMPIRES_ON_THE_BEACH
            SET_PACKED_INT_GLOBAL(15222, 15236, 1) -- ACCOUNTANTSHIRTEVENT, CRESTTSHIRTEVENT
            SET_PACKED_INT_GLOBAL(16784, 16790, 1) -- AWARD_JUMPSUIT_WHITE, AWARD_JUMPSUIT_SILVER
            SET_PACKED_INT_GLOBAL(17532, 17553, 1) -- -1422129266, 310744591
            SET_PACKED_INT_GLOBAL(21109, 21147, 1) -- AWARD_BLACK_AMMUNATION_CAP, AWARD_RSTAR_LOGO_WHITE
            SET_PACKED_INT_GLOBAL(24204, 24230, 1) -- AWARD_EMOTION_983_TSHIRT, AWARD_FAKE_VAPID_TSHIRT
            SET_PACKED_INT_GLOBAL(24704, 24712, 1) -- MAISONETTE_LOS_SANTOS_TSHIRT, TONYS_FUN_HOUSE_TSHIRT
            SET_PACKED_INT_GLOBAL(24744, 24763, 1) -- AWARD_LS_UR, AWARD_BLAINE_COUNTY_RADIO
            SET_PACKED_INT_GLOBAL(24918, 24941, 1) -- -726113206, -1910486921
            SET_PACKED_INT_GLOBAL(25910, 25919, 1) -- -1344369866, 1799248495
            SET_PACKED_INT_GLOBAL(27027, 27033, 1) -- 760292630, 1007326524
            SET_PACKED_INT_GLOBAL(30233, 30237, 1) -- HATS_ISLAND_HEIST_EVENT_HAT_1, HATS_ISLAND_HEIST_EVENT_HAT_5
            SET_PACKED_INT_GLOBAL(31871, 31873, 1) -- FIXER_LOGIN_DJ_POOH_ORANGE, FIXER_LOGIN_DJ_POOH_BLUE
            SET_INT_GLOBAL(262145 + 25706, 1) -- ENABLE_RACE_CREATOR_JUBILEE

            -- https://www.unknowncheats.me/forum/grand-theft-auto-v/461672-gtahax-1-57-external-thread-3-a-23.html
            SET_INT_GLOBAL(262145 + 25791, 1) -- Kifflom Tee

            for i = 31768, 32273 do
                SET_PACKED_STAT_BOOL_CODE(i, true) -- Found by me in freemode.c, https://www.unknowncheats.me/forum/3196991-post328.html
            end

            -- https://www.unknowncheats.me/forum/3704307-post121.html
            SET_PACKED_STAT_BOOL_CODE(15408, true) -- Black Shrewsbury Cap
            SET_PACKED_STAT_BOOL_CODE(34510, true) -- Glow Believe Backwards Cap
            SET_PACKED_STAT_BOOL_CODE(34509, true) -- Black Believe Backwards Cap
            SET_PACKED_STAT_BOOL_CODE(34508, true) -- Gray Believe Backwards Cap
            SET_PACKED_STAT_BOOL_CODE(34375, true) -- Black LD Organics Forwards Cap
            SET_PACKED_STAT_BOOL_CODE(27087, true) -- Unicorn
            SET_PACKED_STAT_BOOL_CODE(34372, true) -- Horror Pumpkin
            SET_PACKED_STAT_BOOL_CODE(27088, true) -- Gingerbread
            SET_PACKED_STAT_BOOL_CODE(34378, true) -- Junk Energy Drink Chute Bag
            SET_PACKED_STAT_BOOL_CODE(32275, true) -- Circoloco Tee
            SET_PACKED_STAT_BOOL_CODE(32316, true) -- Marathon Hoodie
            SET_PACKED_STAT_BOOL_CODE(34507, true) -- White UFO Boxer Shorts
            SET_PACKED_STAT_BOOL_CODE(34506, true) -- Green UFO Boxer Shorts
            SET_PACKED_STAT_BOOL_CODE(89, true) -- Rockstar V Neck
            SET_PACKED_STAT_BOOL_CODE(87, true) -- Red Skull V Neck 
            SET_PACKED_STAT_BOOL_CODE(36809, true) -- All Type of 'Nemesis' Tees
            SET_PACKED_STAT_BOOL_CODE(22176, true) -- White Solomun Tee
            SET_PACKED_STAT_BOOL_CODE(22192, true) -- Tale Of Us Black Box Tee
            SET_PACKED_STAT_BOOL_CODE(16008, true) -- White Dixon Repeated Logo Tee
            SET_PACKED_STAT_BOOL_CODE(16009, true) -- The Black Madonna Star Tee
            SET_PACKED_STAT_BOOL_CODE(22172, true) -- Black Solomun Yellow Logo Tee
            SET_PACKED_STAT_BOOL_CODE(22170, true) -- Black Tale Of Us Emb. Tee
            SET_PACKED_STAT_BOOL_CODE(22162, true) -- Black Dixon Wilderness Tee
            SET_PACKED_STAT_BOOL_CODE(22150, true) -- Black The Black Madonna Emb. Tee
            SET_PACKED_STAT_BOOL_CODE(30702, true) -- Blue Keinemusik Tee
            SET_PACKED_STAT_BOOL_CODE(30701, true) -- Moodymann Tee
            SET_PACKED_STAT_BOOL_CODE(30699, true) -- Palms Trax LS Tee
            SET_PACKED_STAT_BOOL_CODE(34380, true) -- Pumpkin Tee 
            SET_PACKED_STAT_BOOL_CODE(3613, true) -- Elitas T-shirt
            SET_PACKED_STAT_BOOL_CODE(3781, true) -- Elite Lousy T-shirt
            SET_PACKED_STAT_BOOL_CODE(3780, true) -- Elite Challenge T-Shirt
            SET_PACKED_STAT_BOOL_CODE(3779, true) -- Showroom T-shirt
            SET_PACKED_STAT_BOOL_CODE(3778, true) -- Shot Caller T-shirt
            SET_PACKED_STAT_BOOL_CODE(3777, true) -- One Man Army T-shirt
            SET_PACKED_STAT_BOOL_CODE(3776, true) -- Psycho Killer T-shirt
            SET_PACKED_STAT_BOOL_CODE(3775, true) -- Decorated T-shirt
            SET_PACKED_STAT_BOOL_CODE(3774, true) -- Can't Touch This T-shirt
            SET_PACKED_STAT_BOOL_CODE(3773, true) -- Asshole T-shirt
            SET_PACKED_STAT_BOOL_CODE(3771, true) -- For Hire T-shirt
            SET_PACKED_STAT_BOOL_CODE(3770, true) -- Death Defying T-shirt
            SET_PACKED_STAT_BOOL_CODE(113, true) -- I Heart LC T-shirt
            SET_PACKED_STAT_BOOL_CODE(7551, true) -- DCTL T-Shirt
            SET_PACKED_STAT_BOOL_CODE(9374, true) -- R* Crosswalk Tee
            SET_PACKED_STAT_BOOL_CODE(9385, true) -- Crosswalk Tee
            SET_PACKED_STAT_BOOL_CODE(15402, true) -- White Ammu-Nation Tee
            SET_PACKED_STAT_BOOL_CODE(15392, true) -- Black Coil Hoodie
        end)

        menu.action(UNLOCKER_SHIRT_HAT, TRANSLATE("Unlock Sasquatch Outfit"), {}, IS_WORKING(false), function() -- https://www.unknowncheats.me/forum/3492512-post53.html
            SET_INT_GLOBAL(262145 + 32938, 1) -- -1966279346
        end)

        menu.action(UNLOCKER_SHIRT_HAT, TRANSLATE("Unlock 'Don't Cross the Line Tee'"), {}, "", function()
            STAT_SET_INT("DCTL_WINS", 500)
            STAT_SET_INT("DCTL_PLAY_COUNT", 750)
        end)

    ---

    UNLOCKER_TATTOO = menu.list(MASTER_UNLOCKR, TRANSLATE("Tattoos"), {}, "", function(); end)

        menu.action(UNLOCKER_TATTOO, TRANSLATE("Unlock Some Tattoos"), {}, "", function()
            -- https://www.unknowncheats.me/forum/3252891-post942.html
            STAT_SET_INT("AWD_CAR_BOMBS_ENEMY_KILLS", 25) -- Trust No One
            STAT_SET_INT("AWD_HOLD_UP_SHOPS", 20) -- Clown, Clown and Gun, Clown Dual Wield & Clown Dual Wield Dollar
            STAT_SET_INT("AWD_FMBBETWIN", 50000) -- Hustler
            STAT_SET_INT("AWD_100_HEADSHOTS", 500) -- Skull
            STAT_SET_INT("AWD_FM_DM_WINS", 50) -- Burning Heart
            STAT_SET_INT("AWD_RACES_WON", 50) -- Racing Brunette
            STAT_SET_INT("AWD_FMREVENGEKILLSDM", 50) -- Dragon and Dagger
            STAT_SET_INT("AWD_FM_DM_TOTALKILLS", 500) -- Melting Skull
            STAT_SET_INT("LAP_DANCED_BOUGHT", 25) -- Hottie
            STAT_SET_INT("AWD_FM_TDM_MVP", 50) -- Grim Reaper
            STAT_SET_INT("AWD_FMKILLBOUNTY", 25) -- Skull and Sword
            STAT_SET_INT("SNIPERRFL_ENEMY_KILLS", 100) -- Broken Skull
            STAT_SET_BOOL("AWD_FMWINEVERYGAMEMODE", true) -- Angel
            STAT_SET_BOOL("AWD_FMMOSTKILLSSURVIVE", true) -- The Wages of Sin
            STAT_SET_BOOL("AWD_FMRACEWORLDRECHOLDER", true) -- Racing Blonde
            STAT_SET_BOOL("AWD_FMATTGANGHQ", true) -- Grim Reaper Smoking Gun
            STAT_SET_BOOL("AWD_FMKILL3ANDWINGTARACE", true) -- Ride or Die
            STAT_SET_BOOL("AWD_FMKILLSTREAKSDM", true) -- Flaming Skull

            -- https://www.unknowncheats.me/forum/3647348-post2928.html
            STAT_SET_INT("KILLS_PLAYERS", 250) -- Blank Scroll
            STAT_SET_INT("KILLS_PLAYERS", 500) -- Embellished Scroll
            STAT_SET_INT("KILLS_PLAYERS", 1000) -- Seven Deadly Sins
            STAT_SET_BOOL("AWD_FMFULLYMODDEDCAR", true) -- Los Santos Customs

            -- https://www.unknowncheats.me/forum/3662516-post2964.html
            SET_PACKED_STAT_BOOL_CODE(15887, true) -- Lucky 7s Tattoo - Male
            SET_PACKED_STAT_BOOL_CODE(15894, true) -- The Royals Tattoo - Male
            SET_PACKED_STAT_BOOL_CODE(15898, true) -- Lucky 7s Tattoo - Female
            SET_PACKED_STAT_BOOL_CODE(15905, true) -- The Royals Tattoo - Female
        end)

        menu.action(UNLOCKER_TATTOO, TRANSLATE("Alien Tatto (Illuminati)"), {}, TRANSLATE("Change your session to apply!"), function()
            SET_PACKED_STAT_BOOL_CODE(15737, true) -- Male
            SET_PACKED_STAT_BOOL_CODE(15748, true) -- Female
        end)

    ---

    UNLOCKER_VEHICLE = menu.list(MASTER_UNLOCKR, TRANSLATE("Vehicles"), {}, "", function(); end)

        menu.action(UNLOCKER_VEHICLE, TRANSLATE("Unlock Some Trade Prices"), {}, "", function()
            STAT_SET_INT("GANGOPS_FLOW_BITSET_MISS0", -1)
            STAT_SET_INT("LFETIME_HANGAR_BUY_UNDETAK", 42)
            STAT_SET_INT("LFETIME_HANGAR_BUY_COMPLET", 42)
            STAT_SET_INT("AT_FLOW_IMPEXP_NUM", 32)
            STAT_SET_INT("AT_FLOW_VEHICLE_BS", -1)
            STAT_SET_INT("WVM_FLOW_VEHICLE_BS", -1)
            STAT_SET_INT("H3_BOARD_DIALOGUE0", -1)
            STAT_SET_INT("H3_BOARD_DIALOGUE1", -1)
            STAT_SET_INT("H3_BOARD_DIALOGUE2", -1)
            STAT_SET_INT("H3_VEHICLESUSED", -1)
            STAT_SET_INT("WAM_FLOW_VEHICLE_BS", -1)
            STAT_SET_BOOL("HELP_VETO", true)
            STAT_SET_BOOL("HELP_VETO2", true)
            STAT_SET_BOOL("HELP_ITALIRSX", true)
            STAT_SET_BOOL("HELP_BRIOSO2", true)
            STAT_SET_BOOL("HELP_MANCHEZ2", true)
            STAT_SET_BOOL("HELP_SLAMTRUCK", true)
            STAT_SET_BOOL("HELP_VETIR", true)
            STAT_SET_BOOL("HELP_SQUADDIE", true)
            STAT_SET_BOOL("HELP_DINGY5", true)
            STAT_SET_BOOL("HELP_VERUS", true)
            STAT_SET_BOOL("HELP_WEEVIL", true)
            STAT_SET_BOOL("HELP_VEHUNTUNER", true)
            STAT_SET_BOOL("FIXER_VEH_HELP", true)
            STAT_SET_BOOL("HELP_DOMINATOR7", true)
            STAT_SET_BOOL("HELP_JESTER4", true)
            STAT_SET_BOOL("HELP_FUTO2", true)
            STAT_SET_BOOL("HELP_DOMINATOR8", true)
            STAT_SET_BOOL("HELP_PREVION", true)
            STAT_SET_BOOL("HELP_GROWLER", true)
            STAT_SET_BOOL("HELP_COMET6", true)
            STAT_SET_BOOL("HELP_VECTRE", true)
            STAT_SET_BOOL("HELP_SULTAN3", true)
            STAT_SET_BOOL("HELP_CYPHER", true)
        end)

        menu.action(UNLOCKER_VEHICLE, TRANSLATE("Taxi Livery"), {}, TRANSLATE("a.k.a: 'Downtown Cab Co.' livery"), function() -- https://www.unknowncheats.me/forum/3630202-post2734.html
            STAT_SET_INT("AWD_TAXIDRIVER", 100)
        end)

        menu.action(UNLOCKER_VEHICLE, TRANSLATE("Unlock The Shotaro"), {}, "", function()
            STAT_SET_INT("CRDEADLINE", -1)
        end)

    ---

    SPECIAL_WEAPON = menu.list(MASTER_UNLOCKR, TRANSLATE("Weapons"), {}, "", function(); end)

        menu.action(SPECIAL_WEAPON, TRANSLATE("Service Carbine"), {}, IS_WORKING(false), function() -- https://www.unknowncheats.me/forum/3488328-post27.html
            SET_INT_GLOBAL(262145 + 32865, 1) -- UNLOCK_SERVICE_CARBINE_FOR_PURCHASE
        end)

        menu.action(SPECIAL_WEAPON, TRANSLATE("Stone Hatchet Challenge"), {}, TRANSLATE("Change your session to apply!"), function()
            STAT_SET_MASKED_INT("MP_NGDLCPSTAT_INT0", 5, 16) -- Got this from random Kiddions Lua on Discord
            STAT_SET_BOOL("MPPLY_MELEECHLENGECOMPLETED", true)
        end)

        menu.action(SPECIAL_WEAPON, TRANSLATE("Double Action Revolver"), {}, TRANSLATE("Change your session to apply!"), function()
            STAT_SET_MASKED_INT("GANGOPSPSTAT_INT102", 3, 24) -- Got this from random Kiddions Lua on Discord
            STAT_SET_BOOL("MPPLY_HEADSHOTCHLENGECOMPLETED", true)
        end)

        menu.action(SPECIAL_WEAPON, TRANSLATE("Navy Revolver"), {}, "", function()
            STAT_SET_BOOL("MPPLY_NAVYREVOLVERCOMPLETED", true)
        end)

        menu.action(SPECIAL_WEAPON, TRANSLATE("Ceramic Pistol"), {}, "", function() -- https://www.unknowncheats.me/forum/3439472-post2.html
            STAT_SET_INT("CAS_HEIST_FLOW", 4096)
        end)

        menu.action(SPECIAL_WEAPON, TRANSLATE("Up-N-Atomizer"), {}, IS_WORKING(false), function()
            SET_INT_GLOBAL(103634, 90) -- freemode.c
        end)

    ---

    menu.action(MASTER_UNLOCKR, TRANSLATE("Vanilla Unicorn Award"), {}, "", function()
        for i = 0, 25, 5 do
            STAT_SET_INT("LAP_DANCED_BOUGHT", i)
        end
        STAT_SET_INT("PROSTITUTES_FREQUENTED", 1000)
    end)

    menu.action(MASTER_UNLOCKR, TRANSLATE("Returning Player Bonus"), {}, IS_WORKING(false), function()
        SET_INT_GLOBAL(103635, 1) -- freemode.c
        SET_INT_GLOBAL(152523, 2) -- freemode.c
    end)

---


--- Tools

    TUNABLES = menu.list(TOOLS, TRANSLATE("Tunables"), {}, "", function(); end) -- Almost not credited global variables from: https://www.unknowncheats.me/forum/3337151-post1560.html

        TUNABLES_CD = menu.list(TUNABLES, TRANSLATE("Remove Cooldowns"), {}, "", function(); end)

            menu.divider(TUNABLES_CD, TRANSLATE("Supplies' Delay"))

                menu.toggle_loop(TUNABLES_CD, TRANSLATE("MC Business"), {}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(262145 + 18954, 0) -- BIKER_PURCHASE_SUPPLIES_DELAY
                end, function()
                    SET_INT_GLOBAL(262145 + 18954, 600)
                end)
                
                menu.toggle_loop(TUNABLES_CD, TRANSLATE("Bunker"), {}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(262145 + 21557, 0) -- GR_PURCHASE_SUPPLIES_DELAY
                end, function()
                    SET_INT_GLOBAL(262145 + 21557, 600)
                end)

            ---

            menu.divider(TUNABLES_CD, TRANSLATE("Buying And Selling"))

                menu.toggle_loop(TUNABLES_CD, TRANSLATE("Special Cargo"), {}, IS_WORKING(false), function() 
                    SET_INT_GLOBAL(262145 + 15553, 0) -- EXEC_BUY_COOLDOWN
                    SET_INT_GLOBAL(262145 + 15554, 0) -- EXEC_SELL_COOLDOWN
                end, function()
                    SET_INT_GLOBAL(262145 + 15553, 300000)
                    SET_INT_GLOBAL(262145 + 15554, 1800000)
                end)

                menu.toggle_loop(TUNABLES_CD, TRANSLATE("Vehicle Cargo"), {}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(262145 + 19314, 0) -- IMPEXP_STEAL_COOLDOWN
                    SET_INT_GLOBAL(262145 + 19682, 0) -- 1 Vehicle, 1001423248
                    SET_INT_GLOBAL(262145 + 19683, 0) -- 2 Vehicles, 240134765
                    SET_INT_GLOBAL(262145 + 19684, 0) -- 3 Vehicles, 1915379148
                    SET_INT_GLOBAL(262145 + 19685, 0) -- 4 Vehicles, -824005590
                end, function()
                    SET_INT_GLOBAL(262145 + 19314, 180000)
                    SET_INT_GLOBAL(262145 + 19682, 1200000)
                    SET_INT_GLOBAL(262145 + 19683, 1680000)
                    SET_INT_GLOBAL(262145 + 19684, 2340000)
                    SET_INT_GLOBAL(262145 + 19685, 2880000)
                end)

                menu.toggle_loop(TUNABLES_CD, TRANSLATE("Air-Freight Cargo"), {}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(262145 + 22751, 0) -- Tobacco, Counterfeit Goods, SMUG_STEAL_EASY_COOLDOWN_TIMER
                    SET_INT_GLOBAL(262145 + 22752, 0) -- Animal Materials, Art, Jewelry, SMUG_STEAL_MED_COOLDOWN_TIMER
                    SET_INT_GLOBAL(262145 + 22753, 0) -- Narcotics, Chemicals, Medical Supplies, SMUG_STEAL_HARD_COOLDOWN_TIMER
                    SET_INT_GLOBAL(262145 + 22754, 0) -- Additional Time per Player, 1722502526
                    SET_INT_GLOBAL(262145 + 22755, 0) -- Sale, -1091356151
                end, function()
                    SET_INT_GLOBAL(262145 + 22751, 120000)
                    SET_INT_GLOBAL(262145 + 22752, 180000)
                    SET_INT_GLOBAL(262145 + 22753, 240000)
                    SET_INT_GLOBAL(262145 + 22754, 60000)
                    SET_INT_GLOBAL(262145 + 22755, 2000)
                end)

            ---

            menu.divider(TUNABLES_CD, TRANSLATE("Others"))

                menu.toggle_loop(TUNABLES_CD, TRANSLATE("Client Jobs"), {}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(262145 + 24636, 0) -- Between Jobs, -926426916
                    SET_INT_GLOBAL(262145 + 24637, 0) -- Robbery in Progress, 1733390598
                    SET_INT_GLOBAL(262145 + 24638, 0) -- Data Sweep, 724724668
                    SET_INT_GLOBAL(262145 + 24639, 0) -- Targeted Data, 846317886
                    SET_INT_GLOBAL(262145 + 24640, 0) -- Diamond Shopping, 443623246
                    SET_INT_GLOBAL(262145 + 24642, 0) -- Collectors Pieces, -1203647122, https://www.unknowncheats.me/forum/3496393-post32.html
                    SET_INT_GLOBAL(262145 + 24643, 0) -- Deal Breaker, -1963126951, https://www.unknowncheats.me/forum/3496393-post32.html
                end, function()
                    SET_INT_GLOBAL(262145 + 24636, 300000)
                    SET_INT_GLOBAL(262145 + 24637, 1800000)
                    SET_INT_GLOBAL(262145 + 24638, 1800000)
                    SET_INT_GLOBAL(262145 + 24639, 1800000)
                    SET_INT_GLOBAL(262145 + 24640, 1800000)
                    SET_INT_GLOBAL(262145 + 24642, 600000)
                    SET_INT_GLOBAL(262145 + 24643, 600000)
                end)

                menu.toggle_loop(TUNABLES_CD, TRANSLATE("Club Work"), {}, IS_WORKING(false), function() -- https://www.unknowncheats.me/forum/3735173-post133.html
                    SET_INT_GLOBAL(2765974 + 93 + 1 + 13, 0) -- Deathmatch
                    SET_INT_GLOBAL(2765974 + 93 + 1 + 25, 0) -- Joust
                    SET_INT_GLOBAL(2765974 + 93 + 1 + 30, 0) -- Stand Your Ground
                    SET_INT_GLOBAL(2765974 + 93 + 1 + 31, 0) -- Caged In
                    SET_INT_GLOBAL(262145 + 13081, 0) -- GB_COOLDOWN_UNTIL_NEXT_BOSS_WORK
                    SET_INT_GLOBAL(262145 + 18746, 0) -- 1107909355
                end, function()
                    SET_INT_GLOBAL(262145 + 13081, 300000)
                    SET_INT_GLOBAL(262145 + 18746, 180000)
                end)

                REMOVE_LUCKY_WHEEL_COOLDOWN = menu.toggle_loop(TUNABLES_CD, TRANSLATE("Spin Lucky Wheel"), {}, IS_WORKING(false), function() -- https://www.unknowncheats.me/forum/3531489-post51.html
                    STAT_SET_INT("LUCKY_WHEEL_NUM_SPIN", 0)
                    SET_INT_GLOBAL(262145 + 27196, 1) -- 9960150
                    SET_INT_GLOBAL(262145 + 27197, 1) -- -312420223
                end)

                menu.toggle_loop(TUNABLES_CD, TRANSLATE("Kosatka Missiles"), {}, IS_WORKING(true) .. TRANSLATE("Also will increase Kosatka missiles distance."), function()
                    SET_INT_GLOBAL(262145 + 30187, 0) -- IH_SUBMARINE_MISSILES_COOLDOWN
                    SET_INT_GLOBAL(262145 + 30188, 99999) -- IH_SUBMARINE_MISSILES_DISTANCE
                end, function()
                    SET_INT_GLOBAL(262145 + 30187, 60000)
                    SET_INT_GLOBAL(262145 + 30188, 4000)
                end)

                menu.toggle_loop(TUNABLES_CD, TRANSLATE("Dax Job"), {}, TRANSLATE("Note that Dax Job means from cellphone"), function() -- https://www.unknowncheats.me/forum/3629824-post2716.html
                    STAT_SET_INT("XM22JUGGALOWORKCDTIMER", -1)
                end)

                menu.toggle_loop(TUNABLES_CD, TRANSLATE("CEO Vehicles"), {}, IS_WORKING(false), function() -- Credit goes to Professor#4478's Kiddions Lua
                    SET_INT_GLOBAL(262145 + 12832, 0) -- GB_CALL_VEHICLE_COOLDOWN
                end, function()
                    SET_INT_GLOBAL(262145 + 12832, 120000)
                end)

            ---

        ---

        TUNABLES_MUT = menu.list(TUNABLES, TRANSLATE("Multipliers"), {}, "", function(); end)

            MUT_INPUT = menu.slider_float(TUNABLES_MUT, TRANSLATE("Multipliers"), {"hcmultiplier"}, "", 0, 500000, 100, 100, function(); end)

            menu.divider(TUNABLES_MUT, "XP & AP")

                menu.toggle_loop(TUNABLES_MUT, "XP", {}, IS_WORKING(false), function()
                    SET_FLOAT_GLOBAL(262145 + 1, menu.get_value(MUT_INPUT) / 100) -- XP_MULTIPLIER
                end, function()
                    SET_FLOAT_GLOBAL(262145 + 1, menu.get_default_state(MUT_INPUT))
                end)
                menu.toggle_loop(TUNABLES_MUT, "AP", {}, IS_WORKING(false), function()
                    SET_FLOAT_GLOBAL(262145 + 25926, menu.get_value(MUT_INPUT) / 100) -- AP_MULTIPLIER
                end, function()
                    SET_FLOAT_GLOBAL(262145 + 25926, menu.get_default_state(MUT_INPUT))
                end)

            ---

            menu.divider(TUNABLES_MUT, TRANSLATE("LS Car Meet"))

                menu.toggle_loop(TUNABLES_MUT, TRANSLATE("Street Race"), {}, IS_WORKING(false), function()
                    SET_FLOAT_GLOBAL(262145 + 31648, menu.get_value(MUT_INPUT) / 100) -- TUNER_STREET_RACE_PLACE_XP_MULTIPLIER
                end, function()
                    SET_FLOAT_GLOBAL(262145 + 31648, menu.get_default_state(MUT_INPUT))
                end)
                menu.toggle_loop(TUNABLES_MUT, TRANSLATE("Pursuit Race"), {}, IS_WORKING(false), function()
                    SET_FLOAT_GLOBAL(262145 + 31649, menu.get_value(MUT_INPUT) / 100) -- TUNER_PURSUIT_RACE_PLACE_XP_MULTIPLIER
                end, function()
                    SET_FLOAT_GLOBAL(262145 + 31649, menu.get_default_state(MUT_INPUT))
                end)
                menu.toggle_loop(TUNABLES_MUT, TRANSLATE("Scramble"), {}, IS_WORKING(false), function()
                    SET_FLOAT_GLOBAL(262145 + 31650, menu.get_value(MUT_INPUT) / 100) -- TUNER_CHECKPOINT_RACE_PLACE_XP_MULTIPLIER
                end, function()
                    SET_FLOAT_GLOBAL(262145 + 31650, menu.get_default_state(MUT_INPUT))
                end)
                menu.toggle_loop(TUNABLES_MUT, TRANSLATE("Head 2 Head"), {}, IS_WORKING(false), function()
                    SET_FLOAT_GLOBAL(262145 + 31651, menu.get_value(MUT_INPUT) / 100) -- TUNER_HEADTOHEAD_RACE_PLACE_XP_MULTIPLIER
                end, function()
                    SET_FLOAT_GLOBAL(262145 + 31651, menu.get_default_state(MUT_INPUT))
                end)
                menu.toggle_loop(TUNABLES_MUT, TRANSLATE("LS Car Meet"), {}, IS_WORKING(false), function()
                    SET_FLOAT_GLOBAL(262145 + 31652, menu.get_value(MUT_INPUT) / 100) -- TUNER_CARCLUB_VISITS_STREAK_XP_MULTIPLIER
                end, function()
                    SET_FLOAT_GLOBAL(262145 + 31652, menu.get_default_state(MUT_INPUT))
                end)
                menu.toggle_loop(TUNABLES_MUT, TRANSLATE("LS Car Meet's Track"), {}, IS_WORKING(false), function()
                    SET_FLOAT_GLOBAL(262145 + 31653, menu.get_value(MUT_INPUT) / 100) -- TUNER_CARCLUB_TIME_XP_MULTIPLIER
                end, function()
                    SET_FLOAT_GLOBAL(262145 + 31653, menu.get_default_state(MUT_INPUT))
                end)

            ---

        ---

        TUNABLES_CAH = menu.list(TUNABLES, TRANSLATE("Casino Services: Chips") .. " " .. TRANSLATE("(Risky)"), {}, "", function(); end)

            CHIPS_AMOUNT = menu.slider(TUNABLES_CAH, TRANSLATE("Chips Amount"), {"hccasinochips"}, "", INT_MIN, INT_MAX, 0, 10000, function(); end)

            menu.divider(TUNABLES_CAH, TRANSLATE("Casino Services: Chips") .. " " .. TRANSLATE("(Risky)"))

                menu.action(TUNABLES_CAH, TRANSLATE("Trade in Chips"), {}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(262145 + 26980, menu.get_value(CHIPS_AMOUNT)) -- VC_CASINO_CHIP_MIN_SELL
                end)
                menu.action(TUNABLES_CAH, TRANSLATE("Max Chips"), {}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(262145 + 26981, menu.get_value(CHIPS_AMOUNT)) -- VC_CASINO_CHIP_MAX_BUY
                end)

            ---

            menu.divider(TUNABLES_CAH, TRANSLATE("Others"))

                menu.toggle_loop(TUNABLES_CAH, TRANSLATE("Remove Cooldown Buy Chips"), {}, TRANSLATE("If you enable this, able to buy over 20K or 50K chips by removing cooldown time."), function()
                    STAT_SET_INT("MPPLY_CASINO_CHIPS_PUR_GD", 0)
                    STAT_SET_INT("MPPLY_CASINO_CHIPS_PURTIM", 0)
                end)

                menu.action(TUNABLES_CAH, TRANSLATE("Get Visitor Bonus Again"), {}, TRANSLATE("Change your session to apply!"), function()
                    STAT_SET_INT("MPPLY_CHIPS_COL_TIME", 0)
                end)

            ---

        ---

        TUNABLES_OTH = menu.list(TUNABLES, TRANSLATE("Others"), {}, "", function(); end)

            menu.toggle_loop(TUNABLES_OTH, TRANSLATE("Make One Snack Full Health"), {}, IS_WORKING(true) .. TRANSLATE("Whatever you use a snack, will make you full health."), function()
                for i = 113, 119 do -- PSANDQS_HEALTH_REPLENISH_MULTIPLIER, SPRUNK_HEALTH_REPLENISH_MULTIPLIER
                    SET_FLOAT_GLOBAL(262145 + i, 99999)
                end
            end, function()
                for i = 113, 119 do
                    SET_FLOAT_GLOBAL(262145 + i, 1)
                end
            end)

            menu.toggle_loop(TUNABLES_OTH, TRANSLATE("Auto Refill Snacks & Armours"), {}, "", function()
                STAT_SET_INT("NO_BOUGHT_YUM_SNACKS", 30)
                STAT_SET_INT("NO_BOUGHT_HEALTH_SNACKS", 15)
                STAT_SET_INT("NO_BOUGHT_EPIC_SNACKS", 15)
                STAT_SET_INT("NUMBER_OF_ORANGE_BOUGHT", 10)
                STAT_SET_INT("NUMBER_OF_BOURGE_BOUGHT", 10)
                STAT_SET_INT("CIGARETTES_BOUGHT", 10)

                for i = 1, 5 do
                    STAT_SET_INT("MP_CHAR_ARMOUR_" .. i .. "_COUNT", 10)
                end
            end)

            menu.toggle_loop(TUNABLES_OTH, TRANSLATE("Infinite Stone Hatchet's Power"), {}, IS_WORKING(false), function() -- https://www.unknowncheats.me/forum/3484239-post11.html
                SET_INT_GLOBAL(262145 + 25302, 99999) -- Duration, BB_HATCHET_RAMPAGE_DURATION_MAX
                SET_INT_GLOBAL(262145 + 25303, 99999) -- Added Duration per Kill, BB_HATCHET_RAMPAGE_DURATION_EXTENSION
                SET_INT_GLOBAL(262145 + 25304, 0) -- Cooldown, BB_HATCHET_RAMPAGE_COOLDOWN
                SET_FLOAT_GLOBAL(262145 + 25297, 99999) -- Weapon Defense, BB_HATCHET_RAMPAGE_DAMAGE_RECIEVED
                SET_FLOAT_GLOBAL(262145 + 25300, 99999) -- Health Recharge Multiplier, BB_HATCHET_RAMPAGE_HEALTH_REGEN_RATE
                SET_FLOAT_GLOBAL(262145 + 25301, 99999) -- Health Recharge Limit, BB_HATCHET_RAMPAGE_HEALTH_REGEN_MAX
            end, function()
                SET_INT_GLOBAL(262145 + 25302, 12000)
                SET_INT_GLOBAL(262145 + 25303, 6000)
                SET_INT_GLOBAL(262145 + 25304, 60000)
                SET_FLOAT_GLOBAL(262145 + 25297, 0.5)
                SET_FLOAT_GLOBAL(262145 + 25300, 2)
                SET_FLOAT_GLOBAL(262145 + 25301, 1)
            end)

            menu.action(TUNABLES_OTH, TRANSLATE("Single MC Vehicle Sell"), {}, IS_WORKING(true) .. TRANSLATE("Forces the amount of MC Business' sale vehicles to one. Please click once before starting selling mission. Only works when you're the leader."), function()
                SET_INT_LOCAL("gb_biker_contraband_sell", 698 + 17, 0) -- https://github.com/Tgamer500/YiffWarePWLua/blob/main/YiffWarePW.lua
            end)
        
            menu.action(TUNABLES_OTH, TRANSLATE("7 Years GTA Online Playtime"), {}, TRANSLATE("Make your account look like you've played GTA Online for 7 years."), function()
                STAT_SET_INT("MP_PLAYING_TIME", 0)
                STAT_INCREMENT("MP_PLAYING_TIME", 60 * 60 * 24 * 365 * 7 * 1000)
                FORCE_CLOUD_SAVE()
            end)
            
        ---

        CUSTOM_MONEY_REMOVER = menu.slider(TUNABLES, TRANSLATE("Custom Money Remover"), {"hcmoneyremove"}, IS_WORKING(true) .. TRANSLATE("The best way to remove GTA Online banked money up to $2B at once!"), 0, 2000000000, 5000, 10000, function(Value)
            menu.show_warning(TUNABLES, CLICK_MENU, TRANSLATE("Do you sure remove your money?"), function()
                SET_INT_GLOBAL(262145 + 20288, Value) -- -156036296, https://www.unknowncheats.me/forum/3276092-post3.html
                SET_PACKED_STAT_BOOL_CODE(15382, true) -- Makes able to buy the Ballistic Armor
                SET_PACKED_STAT_BOOL_CODE(9461, true) -- Makes you have the Ballistic Armor
    
                menu.trigger_commands("nopimenugrey on")
                if util.is_interaction_menu_open() then IA_MENU_OPEN_OR_CLOSE() end
                SET_INT_GLOBAL(2766487, 85) -- Renders Ballistic Equipment Services screen of the Interaction Menu
                IA_MENU_OPEN_OR_CLOSE()
                IA_MENU_ENTER(1)
                NOTIFY(TRANSLATE("Because this feature works via requesting the Ballistic Armor, it'll be dropped nearby soon."))
            end, function()
                menu.focus(CUSTOM_MONEY_REMOVER)
                NOTIFY(TRANSLATE("Successfully cancelled!"))
            end)
        end)

    ---

    AFK_MONEY = menu.list(TOOLS, TRANSLATE("AFK Money") .. " " .. TRANSLATE("(Risky)"), {}, TRANSLATE("All of features use undetected methods but use at own your risk. If you earn too much, you can be banned."), function(); end)

        menu.divider(AFK_MONEY, TRANSLATE("Cooldown Time (Seconds)"))

            COOLDOWN_CAYO_BOT = menu.slider(AFK_MONEY, TRANSLATE("Auto Cayo Bot"), {"hctimecpbot"}, "", 1200, 86400, 1200, 60, function(); end)
            COOLDOWN_RIG_SLOT = menu.slider(AFK_MONEY, TRANSLATE("Auto Rig Slot Machine"), {"hctimeautorig"}, "", 1, 86400, 1, 1, function(); end)

        ---

        menu.divider(AFK_MONEY, TRANSLATE("Settings"))

            LUCKY_WHEEL_REWARD = menu.list_select(AFK_MONEY, TRANSLATE("Change Reward"), {"hcluckywheelreward"}, "(" ..  TRANSLATE("Tools") .. " > " .. TRANSLATE("AFK Money") .. " " .. TRANSLATE("(Risky)") .. " > " .. TRANSLATE("Auto Lucky Wheel") .. ")", {
                { TRANSLATE("25K Chips"), {"chips"}, "" },
                { TRANSLATE("15K RP"), {"rp"}, TRANSLATE("Can be used to increase your crew level.") },
                { TRANSLATE("Vehicle Discount"), {"discount"}, "" },
                { TRANSLATE("Clothing"), {"clothing"}, "" },
            }, 1, function(); end)

            NUM_OF_PLAYING_CAYO_BOT = menu.slider(AFK_MONEY, TRANSLATE("How Many Times To Play"), {"hcnumcayobot"}, "(" .. TRANSLATE("Tools") .. " > " .. TRANSLATE("AFK Money") .. " " .. TRANSLATE("(Risky)") .. " > " .. TRANSLATE("Auto Cayo Bot") .. ")", 1, 100, 100, 1, function(); end)
            RATIO_JACKPOT_LOSS = menu.slider(AFK_MONEY, TRANSLATE("Ratio of Jackpot and Loss"), {"hcratiojacknloss"}, "(" .. TRANSLATE("Tools") .. " > " .. TRANSLATE("AFK Money") .. " " .. TRANSLATE("(Risky)") .. " > " .. TRANSLATE("Auto Rig Slot Machine") .. ")", 1, 100, 1, 1, function(); end)

        ---

        menu.divider(AFK_MONEY, TRANSLATE("Others"))

            menu.action(AFK_MONEY, TRANSLATE("Teleport to the Lucky Wheel"), {}, TRANSLATE("Works unless you are in the casino.") .. "\n" .. TRANSLATE("If you are in it, not required to use. Just use 'Auto Lucky Wheel'"), function()
                menu.trigger_commands("casinotp" .. players.get_name(players.user()))
                repeat util.yield_once() until CAM.IS_SCREEN_FADING_IN()
                SET_HEADING(5)
                TELEPORT(1110.877, 228.31776, -49.635803)
            end)

        ---

        menu.divider(AFK_MONEY, TRANSLATE("AFK Money") .. " " .. TRANSLATE("(Risky)"))

            NumberOfPlayedCP = 0
            AUTO_CAYO_BOT = menu.toggle_loop(AFK_MONEY, TRANSLATE("Auto Cayo Bot"), {}, IS_WORKING(true) .. TRANSLATE("Solo Cayo Perico Heist will be done by Heist Control automatically per 20 mins to get $2.09M. Don't press any keys to prevent some game bugs."), function()
                -- The idea and source code from Raid Control for X-Force, but almost tweaked by me.
                -- Raid Control Auto Cayo Bot Source Code: https://pastebin.com/JKVXcZBz

                if menu.get_value(NUM_OF_PLAYING_CAYO_BOT) >= NumberOfPlayedCP then
                    if not players.is_using_controller(players.user()) then
                        if not util.is_interaction_menu_open() then IA_MENU_OPEN_OR_CLOSE() end
                        if GET_INT_GLOBAL(2774132 + 1 + (0 * 66) + 1 + GET_INT_LOCAL("am_pi_menu", 232)) ~= 37 then -- am_pi_menu.c
                            NOTIFY(TRANSLATE("Make sure your spawning position is 'Last Location'") .. "\n" .. TRANSLATE("You can set it on Interaction Menu."))
                            menu.apply_default_state(AUTO_CAYO_BOT)
                            return
                        end
                        util.yield_once()
                        IA_MENU_OPEN_OR_CLOSE()
                    end

                    if players.get_boss(players.user()) == -1 then menu.trigger_commands("ceostart") end
                    repeat util.yield_once() until players.get_boss(players.user()) ~= -1
                
                    IsForCayoBot = true
                    menu.trigger_commands("hctimercp off")
                    menu.trigger_commands("hctimercustom off")
                    menu.trigger_commands("hccpquick on")
                
                    menu.trigger_commands("hctpsub")
                    repeat util.yield_once() until HUD.DOES_BLIP_EXIST(SubControlBlip)

                    menu.trigger_commands("hccprefreshboard")
                    repeat util.yield(2000) until GET_INT_LOCAL("heist_island_planning", 1525) ~= 2
                
                    repeat util.yield(2000) until GET_INT_GLOBAL(2646729 + 1869) == 1 -- fmmc_launcher.c, If not ready to set planning board

                    SET_INT_LOCAL("heist_island_planning", 1432, 2) -- Set planning board loading state
                    repeat util.yield(2000) until GET_INT_LOCAL("heist_island_planning", 1432) == 4 -- If not planning board has been loaded

                    CP_PRESS_E(2)
                    CP_PRESS_D(1)
                    CP_PRESS_ENTER(1)

                    repeat util.yield(2000) until GET_INT_LOCAL("fmmc_launcher", 16034 + 763) == 16 -- If "LOB_H_FCP" label not loaded

                    CP_PRESS_ARROW_UP(1)
                    CP_PRESS_ENTER(1)
                    util.yield(2000)

                    CP_PRESS_ARROW_UP(1)
                    CP_PRESS_ENTER(2)

                    repeat util.yield(2000) until HUD.IS_WARNING_MESSAGE_ACTIVE() -- "Are you sure you want to launch this Job on your own?"
                    PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 201, 1) -- Enter Key
                    util.yield(8000)
                    
                    CP_PRESS_ENTER(2)
                    CP_PRESS_BACKSPACE(1)
                    CP_PRESS_ARROW_DOWN(1)
                    CP_PRESS_ENTER(1)
                    CP_PRESS_ARROW_UP(1)
                    CP_PRESS_ENTER(1)
                    CP_PRESS_BACKSPACE(1)
                    CP_PRESS_ARROW_DOWN(1)
                    CP_PRESS_ENTER(2)
                    CP_PRESS_BACKSPACE(1)
                    CP_PRESS_ARROW_DOWN(1)
                    CP_PRESS_ENTER(2)
                    CP_PRESS_BACKSPACE(1)
                    CP_PRESS_ARROW_DOWN(1)
                    CP_PRESS_ENTER(2)
                    CP_PRESS_D(1)
                    CP_PRESS_ENTER(1)
                    
                    repeat util.yield(2000) until GET_INT_GLOBAL(1835499) == 1 -- Waiting for the loading screen, fmmc_launcher.c
                    CP_PRESS_ENTER(1)
                    util.yield(2000)
                
                    repeat util.yield(2000) until GET_INT_LOCAL("fm_mission_controller_2020", 2758) == 1 -- Waiting for the loading screen

                    menu.trigger_commands("skipcutscene")
                    repeat util.yield(2000) until not CUTSCENE.IS_CUTSCENE_PLAYING()

                    menu.trigger_commands("hcinsfincp")
                    util.yield(5000)
                
                    menu.trigger_commands("go solopublic")
                    menu.trigger_commands("hccpquick off")
                    
                    repeat HUD.CLEAR_ALL_HELP_MESSAGES(); util.yield_once() until IS_HELP_MSG_DISPLAYED("QUIT_RS_ALL")
                    local Command = menu.ref_by_path("Online>Quick Progress>Bad Sport Status>Relinquish", 44)
                    menu.trigger_command(Command)
                    menu.trigger_commands("tpmazehelipad")
                
                    NumberOfPlayedCP = NumberOfPlayedCP + 1
                    NOTIFY(TRANSLATE("Playing one time has been done! Waiting for the cooldown time...") .. "\n\n" .. TRANSLATE("How many times you've played after enabled:") .. " " .. NumberOfPlayedCP)
                    
                    menu.trigger_commands("hctimertime " .. menu.get_value(COOLDOWN_CAYO_BOT))
                    menu.trigger_commands("hctimercustom on")
                    repeat util.yield_once() until not menu.get_value(TIMER_CUSTOM)
                end
            end, function()
                NumberOfPlayedCP = 0
                IsForCayoBot = false
                menu.trigger_commands("hctimertime 1200")
                menu.trigger_commands("hctimercustom off")
                menu.trigger_commands("hccpquick off")
            end)

            NumberOfSpin = 0
            menu.toggle_loop(AFK_MONEY, TRANSLATE("Auto Rig Slot Machine"), {"hcautorigslot"}, IS_WORKING(true) .. TRANSLATE("Don't earn more than $50M per a day (real-time), otherwise it'll lead you get banned!"), function()
                if NumberOfSpin == 0 then
                    PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 204, 1) -- Press Tab to Bet Max
                    util.yield(100)
                end

                local SpinState = 3396 + 1 + players.user() * 11 + 10 -- https://github.com/jonaaa20/RecoverySuite
                if GET_INT_LOCAL("casino_slots", SpinState) == 0 then -- If not rigging now
                    if NumberOfSpin >= menu.get_value(RATIO_JACKPOT_LOSS) then
                        menu.trigger_commands("rigslotmachines jackpot")
                        NumberOfSpin = 0
                    else
                        if NumberOfSpin == 0 then
                            menu.trigger_commands("rigslotmachines loss")
                        end
                        NumberOfSpin = NumberOfSpin + 1
                    end

                    PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 208, 1) -- Press Tab to Bet Max
                    SET_INT_LOCAL("casino_slots", 1633, 8) -- Set as rigging is done

                    repeat util.yield_once() until GET_INT_LOCAL("casino_slots", SpinState) == 3
                    SET_INT_LOCAL("casino_slots", SpinState, 6) -- Skipping animations
                   
                    util.yield(menu.get_value(COOLDOWN_RIG_SLOT) * 1000)
                end
            end, function()
                menu.trigger_commands("rigslotmachines off")
                NumberOfSpin = 0
            end)

            menu.toggle_loop(AFK_MONEY, TRANSLATE("Auto Lucky Wheel"), {"hcautoluckywheel"}, IS_WORKING(true) .. TRANSLATE("Let you get the selected lucky wheel reward per 3 seconds automatically.") .. "\n\n" .. TRANSLATE("Please use with 'Teleport to the Lucky Wheel' feature!"), function()
                menu.trigger_commands("rigluckywheel off")
                menu.set_value(REMOVE_LUCKY_WHEEL_COOLDOWN, true)
                util.yield(1500)

                local Rewards = {
                    { 15 }, -- 25K Chips
                    { 17 }, -- 15K RP
                    { 4 }, -- Vehicle Discount
                    { 0, 8, 12, 16 }, -- Clothing
                }
                local Value = menu.get_value(LUCKY_WHEEL_REWARD)
                local Random = math.random(#Rewards[Value])
                SET_INT_LOCAL("casino_lucky_wheel", 275 + 14, Rewards[Value][Random]) -- Setting Lucky Wheel Reward
                SET_INT_LOCAL("casino_lucky_wheel", 275 + 45, 11) -- Rigging state: done
                util.yield(1500)
            end)

        ---

    ---

    INSTANT_FINISH = menu.list(TOOLS, ("快速完成"), {"hcinsfin"}, TRANSLATE("Instant finishes are pretty new features. Due to that, most of them aren't known how they don't work. Please don't complain to me if one of them don't work to you."), function(); end)

        menu.divider(INSTANT_FINISH, TRANSLATE("Heists"))

            finishcayo = menu.action(INSTANT_FINISH, TRANSLATE("Cayo / Tuners / ULP / Agency"), {"hcinsfincp"}, IS_WORKING(true) .. TRANSLATE("Note that may works for some of other preps. Only 'Quick Preset' is compatible with Cayo Perico Heist."), function() -- https://www.unknowncheats.me/forum/3524081-post3.html
                menu.trigger_commands("scripthost")

                SET_INT_LOCAL("fm_mission_controller_2020", 42279 + 1, 51338752) -- 'fm_mission_controller_2020' instant finish variable?
                SET_INT_LOCAL("fm_mission_controller_2020", 42279 + 1375 + 1, 50) -- 'fm_mission_controller_2020' instant finish variable?
            end)

            finishcasino = menu.action(INSTANT_FINISH, TRANSLATE("Casino Aggressive / Classic"), {"hcinsfincah"}, IS_WORKING(true) .. TRANSLATE("Note that if you don't use Heist Control's automated Casino Heist presets, won't get money."), function()
                menu.trigger_commands("scripthost")
                
                SET_INT_LOCAL("fm_mission_controller", 19707 + 1741, 80) -- Casino Aggressive Kills & Act 3
                SET_INT_LOCAL("fm_mission_controller", 19707 + 2686, 10000000) -- How much did you take in the casino and pacific standard heist
                SET_INT_LOCAL("fm_mission_controller", 28329 + 1, 99999) -- 'fm_mission_controller' instant finish variable?
                SET_INT_LOCAL("fm_mission_controller", 31585 + 69, 99999) -- 'fm_mission_controller' instant finish variable?
            end)

            finishact = menu.action(INSTANT_FINISH, TRANSLATE("Doomsday"), {"hcinsfindooms"}, IS_WORKING(true) .. TRANSLATE("Note that you may press multiple times to instant finish the heist."), function()
                menu.trigger_commands("scripthost")

                SET_INT_LOCAL("fm_mission_controller", 19707, 12) -- ???, 'fm_mission_controller' instant finish variable?
                SET_INT_LOCAL("fm_mission_controller", 19707 + 1741, 150) -- Casino Aggressive Kills & Act 3
                SET_INT_LOCAL("fm_mission_controller", 28329 + 1, 99999) -- 'fm_mission_controller' instant finish variable?
                SET_INT_LOCAL("fm_mission_controller", 31585 + 69, 99999) -- 'fm_mission_controller' instant finish variable?
                SET_INT_LOCAL("fm_mission_controller", 31585 + 97, 80) -- Act 1 Kills? Seem not to work
            end)
            
        ---

        menu.divider(INSTANT_FINISH, TRANSLATE("Others"))

            menu.action(INSTANT_FINISH, TRANSLATE("Bunker"), {"hcinsfinbk"}, IS_WORKING(true) .. TRANSLATE("(Selling Only)"), function() -- https://www.unknowncheats.me/forum/3521137-post39.html
                SET_INT_LOCAL("gb_gunrunning", 1205 + 774, 0)
            end)

            menu.action(INSTANT_FINISH, TRANSLATE("Air Cargo"), {"hcinsfinac"}, IS_WORKING(true) .. TRANSLATE("(Selling Only)"), function() -- https://www.unknowncheats.me/forum/3513482-post37.html
                SET_INT_LOCAL("gb_smuggler", 1928 + 1035, GET_INT_LOCAL("gb_smuggler", 1928 + 1078))
            end)

            menu.action(INSTANT_FINISH, TRANSLATE("Acid Lab"), {"hcinsfinacid"}, IS_WORKING(true) .. TRANSLATE("(Selling Only)"), function() -- https://www.unknowncheats.me/forum/3641612-post76.html
                SET_INT_LOCAL("fm_content_acid_lab_sell", 5192 + 1357 + 2, 9)
                SET_INT_LOCAL("fm_content_acid_lab_sell", 5192 + 1357 + 3, 10)
                SET_INT_LOCAL("fm_content_acid_lab_sell", 5192 + 1293, 2)
            end)

            menu.action(INSTANT_FINISH, TRANSLATE("Headhunter"), {"hcinsfinhh"}, "", function() -- Thanks to Sapphire#6031 helping me code this
                local Blip = HUD.GET_FIRST_BLIP_INFO_ID(432) -- Headhunter Target Blip
                while HUD.DOES_BLIP_EXIST(Blip) do
                    local Ped = HUD.GET_BLIP_INFO_ID_ENTITY_INDEX(Blip)
                    ENTITY.SET_ENTITY_HEALTH(Ped, 0)
                    Blip = HUD.GET_NEXT_BLIP_INFO_ID(432)
                    util.yield_once()
                end

                util.yield(2000)
                players.set_wanted_level(players.user(), 0)
            end)

            menu.action(INSTANT_FINISH, TRANSLATE("Sightseer"), {"hcinsfinss"}, IS_WORKING(false), function() -- https://www.unknowncheats.me/forum/3488056-post24.html
                SET_INT_LOCAL("gb_sightseer", 249 + 1 + NETWORK.PARTICIPANT_ID_TO_INT() * 6 + 5, 3)
            end)
            
        ---

    ---

    REMOTE_ACCESS = menu.list(TOOLS, TRANSLATE("Remote Access"), {"hcapp"}, TRANSLATE("Let you open remotely some of apps for missions.") .. "\n\n" .. TRANSLATE("Note that you don't have the app, some of functions won't work."), function(); end)

        menu.textslider(REMOTE_ACCESS, TRANSLATE("Bunker"), {"hcappbunker"}, "", {
            TRANSLATE("Open"),
            TRANSLATE("Close"),
        }, function()
            START_SCRIPT("CEO", "appbunkerbusiness")
        end)
        menu.textslider(REMOTE_ACCESS, TRANSLATE("Air Cargo"), {"hcappaircargo"}, "", {
            TRANSLATE("Open"),
            TRANSLATE("Close"),
        }, function()
            START_SCRIPT("CEO", "appsmuggler")
        end)
        menu.textslider(REMOTE_ACCESS, TRANSLATE("Nightclub"), {"hcappnightclub"}, "", {
            TRANSLATE("Open"),
            TRANSLATE("Close"),
        }, function()
            START_SCRIPT("CEO", "appbusinesshub")
        end)
        menu.action(REMOTE_ACCESS, TRANSLATE("The Open Road"), {"hcapptheopenroad"}, "(" .. TRANSLATE("Biker Business Management") .. ")", function()
            START_SCRIPT("MC", "appbikerbusiness")
        end)
        menu.action(REMOTE_ACCESS, TRANSLATE("Master Control Terminal"), {"hcappmastercontrol"}, "", function()
            START_SCRIPT("CEO", "apparcadebusinesshub")
        end)
        menu.action(REMOTE_ACCESS, TRANSLATE("Touchscreen Terminal"), {"hcapptouchscreen"}, "(" .. TRANSLATE("Terrobyte") .. ")", function()
            START_SCRIPT("CEO", "apphackertruck")
        end)

    ---

    COOLDOWN_TIMER = menu.list(TOOLS, TRANSLATE("Heist Cooldown Timers"), {"hctimer"}, TRANSLATE("Heist Control will show how much the cooldown time left, and let you know if it passed."), function(); end)

        TimerCayo = {
            Total = 1200,
            Min = 0,
            Plus = 0,
            Sec = 0,
        }
        TimerCasino = {
            Total = 1200,
            Min = 0,
            Plus = 0,
            Sec = 0,
        }
        TimerDooms = {
            Total = 1200,
            Min = 0,
            Plus = 0,
            Sec = 0,
        }
        TimerClassic = {
            Total = 1200,
            Min = 0,
            Plus = 0,
            Sec = 0,
        }
        TimerRobbery = {
            Total = 1200,
            Min = 0,
            Plus = 0,
            Sec = 0,
        }
        TimerAgency = {
            Total = 1200,
            Min = 0,
            Plus = 0,
            Sec = 0,
        }
        TimerCustom = {
            Total = nil,
            Min = 0,
            Plus = 0,
            Sec = 0,
        }

        TimerPos = {
            X = 0.97,
            Y = 0.12,
        }

        menu.divider(COOLDOWN_TIMER, TRANSLATE("Settings"))

            TIMER_POS = menu.list(COOLDOWN_TIMER, TRANSLATE("Text Position"), {}, "", function(); end)

                menu.divider(TIMER_POS, TRANSLATE("Heist Control"))

                    menu.slider(TIMER_POS, "X", {"hctimerx"}, "", 0, 100, 97, 1, function(x)
                        TimerPos.X = x / 100
                    end)
                    menu.slider(TIMER_POS, "Y", {"hctimery"}, "", 0, 100, 12, 1, function(y)
                        TimerPos.Y = y / 100
                    end)

                ---

                menu.divider(TIMER_POS, "Stand")

                    menu.link(TIMER_POS, menu.ref_by_command_name("infotextx"), true)
                    menu.link(TIMER_POS, menu.ref_by_command_name("infotexty"), true)

                ---

            ---

            TIMER_COLOR = menu.list(COOLDOWN_TIMER, TRANSLATE("Text Color"), {}, "", function(); end)

                TIMER_COLOR_HC = menu.list(TIMER_COLOR, TRANSLATE("Heist Control"), {}, "", function(); end)

                TIMER_COLOR_STAND = menu.list(TIMER_COLOR, "Stand", {}, "", function(); end)

                    HudCommandRef = menu.ref_by_path("Stand>Settings>Appearance>Colours>HUD Colour", 44)
                    HudChildren = menu.get_children(HudCommandRef)
                    for _, child in pairs(HudChildren) do
                        menu.link(TIMER_COLOR_STAND, child)
                    end

                ---

            ---

            IS_STAND_OVERLAY = menu.toggle(COOLDOWN_TIMER, TRANSLATE("Use Stand's Overlay"), {}, TRANSLATE("Enabled: Use Stand's Overlay & Settings: Game > Info Overlay") .. "\n\n" .. TRANSLATE("Disabled: Use Heist Control's Overlay & Settings"), function(); end)
            CUSTOM_TIMER_TIME = menu.slider(COOLDOWN_TIMER, TRANSLATE("Set Custom Time (Seconds)"), {"hctimertime"}, "", 0, 259200, 1200, 60, function(); end)

        ---

        menu.divider(COOLDOWN_TIMER, TRANSLATE("Heist Cooldown Timer"))

            TIMER_CAYO = menu.toggle(COOLDOWN_TIMER, TRANSLATE("Cayo Perico Heist"), {"hctimercp"}, "", function()
                if not menu.get_value(TIMER_CAYO) then
                    TimerCayo.Total, TimerCayo.Min, TimerCayo.Plus, TimerCayo.Sec = 1200, 0, 0, 0
                end

                while menu.get_value(TIMER_CAYO) do
                    if TimerCayo.Total == 0 then
                        NOTIFY(TRANSLATE("Cayo Perico Heist") .. " - " .. TRANSLATE("Cooldown time has passed, you can play the heist again!"))
                        menu.apply_default_state(TIMER_CAYO)
                    end
  
                    TimerCayo.Total = TimerCayo.Total - 1
                    TimerCayo.Min = math.floor(TimerCayo.Total / 60)
                    TimerCayo.Plus = TimerCayo.Plus + 1
                    TimerCayo.Sec = 1200 - TimerCayo.Min * 60 - TimerCayo.Plus
                    util.yield(1000)
                end
            end)

            TIMER_CASINO = menu.toggle(COOLDOWN_TIMER, TRANSLATE("Diamond Casino Heist"), {"hctimercah"}, "", function()
                if not menu.get_value(TIMER_CASINO) then
                    TimerCasino.Total, TimerCasino.Min, TimerCasino.Plus, TimerCasino.Sec = 1200, 0, 0, 0
                end

                while menu.get_value(TIMER_CASINO) do
                    if TimerCasino.Total == 0 then
                        NOTIFY(TRANSLATE("Diamond Casino Heist") .. " - " .. TRANSLATE("Cooldown time has passed, you can play the heist again!"))
                        menu.apply_default_state(TIMER_CASINO)
                    end

                    TimerCasino.Total = TimerCasino.Total - 1
                    TimerCasino.Min = math.floor(TimerCasino.Total / 60)
                    TimerCasino.Plus = TimerCasino.Plus + 1
                    TimerCasino.Sec = 1200 - TimerCasino.Min * 60 - TimerCasino.Plus
                    util.yield(1000)
                end
            end)

            TIMER_DOOMS = menu.toggle(COOLDOWN_TIMER, TRANSLATE("Doomsday Heist"), {"hctimerdooms"}, "", function()
                if not menu.get_value(TIMER_DOOMS) then
                    TimerDooms.Total, TimerDooms.Min, TimerDooms.Plus, TimerDooms.Sec = 1200, 0, 0, 0
                end

                while menu.get_value(TIMER_DOOMS) do
                    if TimerDooms.Total == 0 then
                        NOTIFY(TRANSLATE("Doomsday Heist") .. " - " .. TRANSLATE("Cooldown time has passed, you can play the heist again!"))
                        menu.apply_default_state(TIMER_DOOMS)
                    end
                    
                    TimerDooms.Total = TimerDooms.Total - 1
                    TimerDooms.Min = math.floor(TimerDooms.Total / 60)
                    TimerDooms.Plus = TimerDooms.Plus + 1
                    TimerDooms.Sec = 1200 - TimerDooms.Min * 60 - TimerDooms.Plus
                    util.yield(1000)
                end
            end)

            TIMER_CLASSIC = menu.toggle(COOLDOWN_TIMER, TRANSLATE("Classic Heist"), {"hctimerclassic"}, "", function()
                if not menu.get_value(TIMER_CLASSIC) then
                    TimerClassic.Total, TimerClassic.Min, TimerClassic.Plus, TimerClassic.Sec = 1200, 0, 0, 0
                end

                while menu.get_value(TIMER_CLASSIC) do
                    if TimerClassic.Total == 0 then
                        NOTIFY(TRANSLATE("Classic Heist") .. " - " .. TRANSLATE("Cooldown time has passed, you can play the heist again!"))
                        menu.apply_default_state(TIMER_CLASSIC)
                    end

                    TimerClassic.Total = TimerClassic.Total - 1
                    TimerClassic.Min = math.floor(TimerClassic.Total / 60)
                    TimerClassic.Plus = TimerClassic.Plus + 1
                    TimerClassic.Sec = 1200 - TimerClassic.Min * 60 - TimerClassic.Plus
                    util.yield(1000)
                end
            end)

            TIMER_ROBBERY = menu.toggle(COOLDOWN_TIMER, TRANSLATE("LS Tuners Robbery"), {"hctimerrobbery"}, "", function()
                if not menu.get_value(TIMER_ROBBERY) then
                    TimerRobbery.Total, TimerRobbery.Min, TimerRobbery.Plus, TimerRobbery.Sec = 1200, 0, 0, 0
                end

                while menu.get_value(TIMER_ROBBERY) do
                    if TimerRobbery.Total == 0 then
                        NOTIFY(TRANSLATE("LS Tuners Robbery") .. " - " .. TRANSLATE("Cooldown time has passed, you can play the heist again!"))
                        menu.apply_default_state(TIMER_ROBBERY)
                    end

                    TimerRobbery.Total = TimerRobbery.Total - 1
                    TimerRobbery.Min = math.floor(TimerRobbery.Total / 60)
                    TimerRobbery.Plus = TimerRobbery.Plus + 1
                    TimerRobbery.Sec = 1200 - TimerRobbery.Min * 60 - TimerRobbery.Plus
                    util.yield(1000)
                end
            end)

            TIMER_AGENCY = menu.toggle(COOLDOWN_TIMER, TRANSLATE("The Contract: Agency"), {"hctimeragency"}, "", function()
                if not menu.get_value(TIMER_AGENCY) then
                    TimerAgency.Total, TimerAgency.Min, TimerAgency.Plus, TimerAgency.Sec = 1200, 0, 0, 0
                end

                while menu.get_value(TIMER_AGENCY) do
                    if TimerAgency.Total == 0 then
                        NOTIFY(TRANSLATE("The Contract: Agency") .. " - " .. TRANSLATE("Cooldown time has passed, you can play the heist again!"))
                        menu.apply_default_state(TIMER_AGENCY)
                    end

                    TimerAgency.Total = TimerAgency.Total - 1
                    TimerAgency.Min = math.floor(TimerAgency.Total / 60)
                    TimerAgency.Plus = TimerAgency.Plus + 1
                    TimerAgency.Sec = 1200 - TimerAgency.Min * 60 - TimerAgency.Plus
                    util.yield(1000)
                end
            end)

            TIMER_CUSTOM = menu.toggle(COOLDOWN_TIMER, TRANSLATE("Custom Timer"), {"hctimercustom"}, "", function()
                if menu.get_value(TIMER_CUSTOM) then
                    TimerCustom.Total = menu.get_value(CUSTOM_TIMER_TIME)
                else
                    TimerCustom.Total, TimerCustom.Min, TimerCustom.Plus, TimerCustom.Sec = menu.get_value(CUSTOM_TIMER_TIME), 0, 0, 0
                end

                while menu.get_value(TIMER_CUSTOM) do
                    if TimerCustom.Total == 0 then
                        NOTIFY(TRANSLATE("Custom Timer") .. " - " .. TRANSLATE("Cooldown time has passed, you can play the heist again!"))
                        menu.apply_default_state(TIMER_CUSTOM)
                    end

                    TimerCustom.Total = TimerCustom.Total - 1
                    TimerCustom.Min = math.floor(TimerCustom.Total / 60)
                    TimerCustom.Plus = TimerCustom.Plus + 1
                    TimerCustom.Sec = menu.get_value(CUSTOM_TIMER_TIME) - TimerCustom.Min * 60 - TimerCustom.Plus
                    util.yield(1000)
                end
            end)

        ---

        TimerRGB = HEX_TO_RGBA("Stand", READ_SETTING("Timer Color Code"))
        util.create_tick_handler(function()
            local TimerTypes = { -- { is_timer_enabled, timer_name, minutes, seconds }
                { menu.get_value(TIMER_CAYO), TRANSLATE("Cayo Perico Heist"), TimerCayo.Min, TimerCayo.Sec },
                { menu.get_value(TIMER_CASINO), TRANSLATE("Diamond Casino Heist"), TimerCasino.Min, TimerCasino.Sec },
                { menu.get_value(TIMER_DOOMS), TRANSLATE("Doomsday Heist"), TimerDooms.Min, TimerDooms.Sec },
                { menu.get_value(TIMER_CLASSIC), TRANSLATE("Classic Heist"), TimerClassic.Min, TimerClassic.Sec },
                { menu.get_value(TIMER_ROBBERY), TRANSLATE("LS Tuners Robbery"), TimerRobbery.Min, TimerRobbery.Sec },
                { menu.get_value(TIMER_AGENCY), TRANSLATE("The Contract: Agency"), TimerAgency.Min, TimerAgency.Sec },
                { menu.get_value(TIMER_CUSTOM), TRANSLATE("Custom Timer"), TimerCustom.Min, TimerCustom.Sec },
            }
            local IsOneOfThemEnabled = false
            for i = 1, #TimerTypes do
                if TimerTypes[i][1] then
                    IsOneOfThemEnabled = true
                end
            end
            if not IsOneOfThemEnabled then return end

            for i = 1, #TimerTypes do
                for j = 3, 4 do
                    if TimerTypes[i][j] < 10 then
                        TimerTypes[i][j] = 0 .. TimerTypes[i][j]
                    end
                end
            end
            if menu.get_value(IS_STAND_OVERLAY) then
                for i = 1, #TimerTypes do
                    if TimerTypes[i][1] then
                        util.draw_debug_text(TimerTypes[i][2] .. " [" .. TimerTypes[i][3] .. ":" .. TimerTypes[i][4] .. "]")
                    end
                end
            else
                if IsOneOfThemEnabled then
                    for i = 1, #TimerTypes do
                        directx.draw_text(TimerPos.X, TimerPos.Y + 0.02 * (i - 1), TimerTypes[i][2] .. " [" .. TimerTypes[i][3] .. ":" .. TimerTypes[i][4] .. "]", 2, 0.6, TimerRGB, false)
                    end
                end
            end
        end)

    ---

    NEAR_PED_CAM = menu.list(TOOLS, TRANSLATE("Manage Nearby Peds And Cams"), {}, "", function(); end)

        menu.divider(NEAR_PED_CAM, TRANSLATE("Peds"))

            menu.toggle_loop(NEAR_PED_CAM, TRANSLATE("Ignore You"), {"hcignoreped"}, TRANSLATE("Makes hostile peds (Included guards, polices, and gangs) ignore you even saw you. Except for the rare case, they don't shoot to you."), function()
                PLAYER.SET_EVERYONE_IGNORE_PLAYER(players.user(), true) -- https://github.com/ozarkv40/ozark-src, <3
            end, function()
                PLAYER.SET_EVERYONE_IGNORE_PLAYER(players.user(), false)
            end)

            menu.action(NEAR_PED_CAM, TRANSLATE("Remove Weapons"), {"hcremwepon"}, "", function()
                for _, ped in pairs(entities.get_all_peds_as_handles()) do
                    if IS_PLAYER_PED(ped) or ENTITY.IS_ENTITY_DEAD(ped) then goto out end
                    WEAPON.REMOVE_ALL_PED_WEAPONS(ped, true)
                    ::out::
                end
            end)

            menu.action(NEAR_PED_CAM, TRANSLATE("Delete"), {"hcdelped"}, "", function()
                for _, ped in pairs(entities.get_all_peds_as_handles()) do
                    if IS_PLAYER_PED(ped) or ENTITY.IS_ENTITY_DEAD(ped) then goto out end
                    entities.delete_by_handle(ped)
                    ::out::
                end
            end)

            menu.action(NEAR_PED_CAM, TRANSLATE("Kill"), {"hckillped"}, "", function()
                for _, ped in pairs(entities.get_all_peds_as_handles()) do
                    if IS_PLAYER_PED(ped) or ENTITY.IS_ENTITY_DEAD(ped) then goto out end
                    ENTITY.SET_ENTITY_HEALTH(ped, 0)
                    ::out::
                end
            end)

            menu.action(NEAR_PED_CAM, TRANSLATE("Shoot"), {"hcshootped"}, "", function() -- Thanks for coding this, Pedro9558#3559
                for _, ped in pairs(entities.get_all_peds_as_handles()) do
                    if IS_PLAYER_PED(ped) or ENTITY.IS_ENTITY_DEAD(ped) then goto out end
                    if PED.GET_VEHICLE_PED_IS_USING(ped) ~= 0 then TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped) end

                    local PedPos = ENTITY.GET_ENTITY_COORDS(ped)
                    local AddPos = ENTITY.GET_ENTITY_COORDS(ped)
                    AddPos.z = AddPos.z + 1
                    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(AddPos.x, AddPos.y, AddPos.z, PedPos.x, PedPos.y, PedPos.z, 1000, false, 0xC472FE2, players.user_ped(), false, true, 1000)
                    ::out::
                end
            end)

        ---

        menu.divider(NEAR_PED_CAM, TRANSLATE("Cameras"))

            AllCamLists = {
                util.joaat("prop_cctv_cam_01a"),
                util.joaat("prop_cctv_cam_01b"),
                util.joaat("prop_cctv_cam_02a"),
                util.joaat("prop_cctv_cam_03a"),
                util.joaat("prop_cctv_cam_04a"),
                util.joaat("prop_cctv_cam_04c"),
                util.joaat("prop_cctv_cam_05a"),
                util.joaat("prop_cctv_cam_06a"),
                util.joaat("prop_cctv_cam_07a"),
                util.joaat("prop_cs_cctv"),
                util.joaat("p_cctv_s"),
                util.joaat("hei_prop_bank_cctv_01"),
                util.joaat("hei_prop_bank_cctv_02"),
                util.joaat("ch_prop_ch_cctv_cam_02a"),
                util.joaat("xm_prop_x17_server_farm_cctv_01"),
            }

            menu.action(NEAR_PED_CAM, TRANSLATE("Taze"), {"hctazecam"}, "", function()
                for _, ent in pairs(entities.get_all_objects_as_handles()) do
                    for __, cam in pairs(AllCamLists) do
                        if ENTITY.GET_ENTITY_MODEL(ent) == cam then
                            local CamPos = ENTITY.GET_ENTITY_COORDS(ent)
                            local AddPos = ENTITY.GET_ENTITY_COORDS(ent)
                            AddPos.z = AddPos.z + 1
                            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(AddPos.x, AddPos.y, AddPos.z, CamPos.x, CamPos.y, CamPos.z, 1000, false, 0x3656C8C1, players.user_ped(), false, true, 1000)
                        end
                    end
                end
            end)

            menu.action(NEAR_PED_CAM, TRANSLATE("Delete"), {"hcdelcam"}, "", function()
                for _, cam in pairs(AllCamLists) do
                    DELETE_OBJECT_BY_HASH(cam)
                end
            end)

        ---

    ---

    BYPASS_DOOR = menu.list(TOOLS, TRANSLATE("Bypass Locked Doors"), {}, "", function(); end)

        menu.divider(BYPASS_DOOR, TRANSLATE("Settings"))

            IMPROVED_NO_CLIP_SPEED = menu.slider(BYPASS_DOOR, TRANSLATE("Speed of Improved No Clip"), {"hcspeednoclip"}, "", 1, 100, 10, 5, function()
                local CommandRef = menu.ref_by_command_name("levitatespeed")
                menu.trigger_command(CommandRef, menu.get_value(IMPROVED_NO_CLIP_SPEED) * 0.01)
            end)

            DISTANCE_TPTF = menu.slider(BYPASS_DOOR, TRANSLATE("Distance of Teleport To Forward"), {"hcdistptf"}, "", 1, 100, 10, 5, function(); end)

        ---

        menu.divider(BYPASS_DOOR, TRANSLATE("Bypass Locked Doors"))

            IMPROVED_NO_CLIP = menu.toggle(BYPASS_DOOR, TRANSLATE("Improved No Clip"), {"hcnoclip"}, "", function() -- From Command Box Scripts: No Clip
                local Commands = { -- { command_ref, arg }
                    { menu.ref_by_command_name("levitate"), "on" },
                    { menu.ref_by_command_name("levitatespeed"), menu.get_value(IMPROVED_NO_CLIP_SPEED) * 0.01 },
                    { menu.ref_by_command_name("levitatesprintmultiplier"), "0.50" },
                    { menu.ref_by_command_name("levitatepassivemin"), "0" },
                    { menu.ref_by_command_name("levitatepassivemax"), "0" },
                    { menu.ref_by_command_name("levitatepassivespeed"), "0" },
                    { menu.ref_by_command_name("levitateassistup"), "0" },
                    { menu.ref_by_command_name("levitateassistdown"), "0" },
                    { menu.ref_by_command_name("levitateassistdeadzone"), "0" },
                    { menu.ref_by_command_name("levitateassistsnap"), "0" },
                }
                if menu.get_value(IMPROVED_NO_CLIP) then
                    for i = 1, #Commands do
                        menu.trigger_command(Commands[i][1], Commands[i][2])
                    end
                else
                    for i = 1, #Commands do
                        menu.apply_default_state(Commands[i][1])
                    end
                end
            end)
    
            menu.action(BYPASS_DOOR, TRANSLATE("Teleport To Forward"), {"hctptf"}, "", function() -- Credit goes to LanceScript Reloaded
                local Handle = PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) and PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false) or players.user_ped()
                local Pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(Handle, 0, menu.get_value(DISTANCE_TPTF) * 0.1, 0)
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Handle, Pos.x, Pos.y, Pos.z, false, false, false)
            end)

        ---

    ---

    menu.list_action(TOOLS, TRANSLATE("Request Services"), {"hcreq"}, "", {
        { TRANSLATE("MOC"), {"moc"}, "" },
        { TRANSLATE("Avenger"), {"avenger"}, "" },
        { TRANSLATE("Terrorbyte"), {"terrorbyte"}, "" },
        { TRANSLATE("Kosatka"), {"kosatka"}, "" },
        { TRANSLATE("Acid Lab"), {"acidlab"}, "" },
        { TRANSLATE("Dingy"), {"dingy"}, "" },
        { TRANSLATE("Ballistic Armor"), {"ballisticarmor"}, "" },
        { TRANSLATE("RC Bandito"), {"rcbandito"}, "" },
        { TRANSLATE("RC Tank"), {"rctank"}, "" },
    }, function(index)
        if index == 1 then
            SET_INT_GLOBAL(2793046 + 925, 1)
        elseif index == 2 then
            SET_INT_GLOBAL(2793046 + 933, 1)
        elseif index == 3 then
            SET_INT_GLOBAL(2793046 + 937, 1)
        elseif index == 4 then
            SET_INT_GLOBAL(2793046 + 954, 1)
        elseif index == 5 then
            SET_INT_GLOBAL(2793046 + 938, 1)
        elseif index == 6 then
            SET_INT_GLOBAL(2793046 + 966, 1)
        elseif index == 7 then
            SET_INT_GLOBAL(2793046 + 896, 1)
        elseif index == 8 then
            SET_INT_GLOBAL(2793046 + 6874, 1)
        elseif index == 9 then
            SET_INT_GLOBAL(2793046 + 6875, 1)
        end
    end)

    STAT_EDITOR_READER = menu.list(TOOLS, TRANSLATE("Stat Editor And Reader"), {}, "", function(); end)

        PRESET_STAT_EDITOR = menu.list(STAT_EDITOR_READER, TRANSLATE("Preset Stat Editor"), {}, "", function(); end)

            PLAYTIME_EDITOR = menu.list(PRESET_STAT_EDITOR, TRANSLATE("Playtime"), {}, "", function(); end)

                menu.divider(PLAYTIME_EDITOR, TRANSLATE("Method"))

                    IS_TIME_ADDING_METHOD = menu.toggle(PLAYTIME_EDITOR, TRANSLATE("Add Additional Playtime"), {}, TRANSLATE("Enabled: Add Method") .. "\n" .. TRANSLATE("- Adds Up To Your Current Playtime") .. "\n\n" .. TRANSLATE("Disabled: Overwrite Method") .. "\n" .. TRANSLATE("- Overwrites Your Current Playtime") .. "\n\n" .. TRANSLATE("Note: The overwrite method supports up to 24.8 days, but add method supports up to 50,000 days"), function(); end)

                ---
                
                menu.divider(PLAYTIME_EDITOR, TRANSLATE("Modify Stat"))

                    PLAYTIME_DAYS = menu.slider(PLAYTIME_EDITOR, TRANSLATE("Days"), {"hcplaytimedays"}, "", 0, 50000, 0, 1, function(); end)
                    PLAYTIME_HOURS = menu.slider(PLAYTIME_EDITOR, TRANSLATE("Hours"), {"hcplaytimehours"}, "", 0, 50000, 0, 1, function(); end)
                    PLAYTIME_MINS = menu.slider(PLAYTIME_EDITOR, TRANSLATE("Minutes"), {"hcplaytimemins"}, "", 0, 50000, 0, 1, function(); end)

                ---

                menu.divider(PLAYTIME_EDITOR, TRANSLATE("Set Stat"))

                    PlaytimeStats = {
                        { TRANSLATE("Total Playtime"), "TOTAL_PLAYING_TIME" },
                        { TRANSLATE("GTA Online Playtime"), "MP_PLAYING_TIME" },
                        { TRANSLATE("Deathmatches"), "MPPLY_TOTAL_TIME_SPENT_DEATHMAT" },
                        { TRANSLATE("Races"), "MPPLY_TOTAL_TIME_SPENT_RACES" },
                        { TRANSLATE("Creator"), "MPPLY_TOTAL_TIME_MISSION_CREATO" },
                    }
                    for i = 1, #PlaytimeStats do
                        menu.action(PLAYTIME_EDITOR, PlaytimeStats[i][1], {}, "", function()
                            if not menu.get_value(IS_TIME_ADDING_METHOD) then
                                STAT_SET_INT(PlaytimeStats[i][2], menu.get_value(PLAYTIME_DAYS) * 86400000 + menu.get_value(PLAYTIME_HOURS) * 3600000 + menu.get_value(PLAYTIME_MINS) * 60000)
                            else
                                STAT_INCREMENT(PlaytimeStats[i][2], menu.get_value(PLAYTIME_DAYS) * 86400000 + menu.get_value(PLAYTIME_HOURS) * 3600000 + menu.get_value(PLAYTIME_MINS) * 60000)
                            end
            
                            NOTIFY
                            (
                                TRANSLATE("Successfully set!") .. "\n\n" .. 
                                TRANSLATE("Days") .. ": " .. menu.get_value(PLAYTIME_DAYS) .. "\n" .. 
                                TRANSLATE("Hours") .. ": " .. menu.get_value(PLAYTIME_HOURS) .. "\n" .. 
                                TRANSLATE("Mins") .. ": " .. menu.get_value(PLAYTIME_MINS)
                            )

                            FORCE_CLOUD_SAVE()
                        end)
                    end

                ---

            ---

            CASH_EDITOR = menu.list(PRESET_STAT_EDITOR, TRANSLATE("Cash Earned & Spent"), {}, "", function(); end)

                menu.divider(CASH_EDITOR, TRANSLATE("Modify Stat"))

                    CASH_EDITOR_AMOUNT = menu.slider(CASH_EDITOR, TRANSLATE("Cash Amount"), {"hccasheditor"}, "($)", INT_MIN, INT_MAX, 0, 10000, function(); end)

                ---

                menu.divider(CASH_EDITOR, TRANSLATE("Set Stat"))

                    menu.action(CASH_EDITOR, TRANSLATE("Total Earned"), {}, "", function()
                        STAT_SET_INT("MPPLY_TOTAL_EVC", menu.get_value(CASH_EDITOR_AMOUNT))
                        FORCE_CLOUD_SAVE()
                    end)
                    menu.action(CASH_EDITOR, TRANSLATE("Total Spent"), {}, "", function()
                        STAT_SET_INT("MPPLY_TOTAL_SVC", menu.get_value(CASH_EDITOR_AMOUNT))
                        FORCE_CLOUD_SAVE()
                    end)

                ---

                menu.divider(CASH_EDITOR, TRANSLATE("Related Earned Cash"))

                    menu.action(CASH_EDITOR, TRANSLATE("Jobs"), {}, "", function()
                        STAT_SET_INT("MONEY_EARN_JOBS", menu.get_value(CASH_EDITOR_AMOUNT))
                        FORCE_CLOUD_SAVE()
                    end)
                    menu.action(CASH_EDITOR, TRANSLATE("Betting"), {}, "", function()
                        STAT_SET_INT("MONEY_EARN_BETTING", menu.get_value(CASH_EDITOR_AMOUNT))
                        FORCE_CLOUD_SAVE()
                    end)
                    menu.action(CASH_EDITOR, TRANSLATE("Shared"), {}, "", function()
                        STAT_SET_INT("MONEY_EARN_SHARED", menu.get_value(CASH_EDITOR_AMOUNT))
                        FORCE_CLOUD_SAVE()
                    end)
                    menu.action(CASH_EDITOR, TRANSLATE("Car Sales"), {}, "", function()
                        STAT_SET_INT("MONEY_EARN_SELLING_VEH", menu.get_value(CASH_EDITOR_AMOUNT))
                        FORCE_CLOUD_SAVE()
                    end)
                    menu.action(CASH_EDITOR, TRANSLATE("Others"), {}, "", function()
                        STAT_SET_INT("MONEY_EARN_GOOD_SPORT", menu.get_value(CASH_EDITOR_AMOUNT))
                        FORCE_CLOUD_SAVE()
                    end)
                    menu.action(CASH_EDITOR, TRANSLATE("Picked Up"), {}, "", function()
                        STAT_SET_INT("MONEY_EARN_PICKED_UP", menu.get_value(CASH_EDITOR_AMOUNT))
                        FORCE_CLOUD_SAVE()
                    end)

                ---

            ---
            
        ---

        STAT_EDITOR = menu.list(STAT_EDITOR_READER, TRANSLATE("Custom Stat Editor") .. " " .. TRANSLATE("(Risky)"), {}, TRANSLATE("Use at your own risk! Setting certain stats may cause a ban like casino-related stats."), function(); end)

            menu.divider(STAT_EDITOR, TRANSLATE("Modify Stat"))

                STAT_EDITOR_NAME = menu.text_input(STAT_EDITOR, TRANSLATE("Stat Name"), {"hceditname"}, TRANSLATE("Note: MP0_ or MP1_ will be selected by HC automatically, therefore don't write it."), function()
                    local MenuValue = menu.get_value(STAT_EDITOR_NAME)
                    local UpperValue = string.upper(MenuValue)
                    if MenuValue ~= UpperValue then
                        menu.trigger_commands("hceditname " .. UpperValue)
                    end

                    local BlacklistedChars = {
                        "MP0_",
                        "MP1_",
                        "MPx_",
                        "_",
                    }
                    for _, keyword in pairs(BlacklistedChars) do
                        if string.startswith(MenuValue, keyword) then
                            menu.apply_default_state(STAT_EDITOR_NAME)
                            NOTIFY(menu.get_help_text(STAT_EDITOR_NAME))
                            NOTIFY(TRANSLATE("Successfully cancelled!"))
                        end
                    end
                end)

                STAT_EDITOR_VALUE = menu.text_input(STAT_EDITOR, TRANSLATE("Stat Value"), {"hceditvalue"}, "", function(); end)

            ---

            menu.divider(STAT_EDITOR, "Date")

                DATE_YEARS = menu.slider(STAT_EDITOR, TRANSLATE("Years"), {"hcedityears"}, "", 2013, os.date("%Y"), 0, 1, function(); end)
                DATE_MONTHS = menu.slider(STAT_EDITOR, TRANSLATE("Months"), {"hceditmonths"}, "", 0, 12, 0, 1, function(); end)
                DATE_DAYS = menu.slider(STAT_EDITOR, TRANSLATE("Days"), {"hceditdays"}, "", 0, 31, 0, 1, function(); end)
                DATE_HOURS = menu.slider(STAT_EDITOR, TRANSLATE("Hours"), {"hcedithours"}, "", 0, 24, 0, 1, function(); end)
                DATE_MINS = menu.slider(STAT_EDITOR, TRANSLATE("Mins"), {"hceditmins"}, "", 0, 60, 0, 1, function(); end)

            ---

            menu.divider(STAT_EDITOR, TRANSLATE("Set Stat"))

                menu.action(STAT_EDITOR, "Integer", {}, TRANSLATE("Example Stat") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. "NO_BOUGHT_YUM_SNACKS\n" .. TRANSLATE("Stat Value") .. ": " .. "30", function()
                    if menu.get_value(STAT_EDITOR_NAME) == "" or menu.get_value(STAT_EDITOR_VALUE) == "" then
                        menu.focus(STAT_EDITOR_NAME)
                        NOTIFY(TRANSLATE("You didn't specify the value. Please specify it!"))
                    else
                        STAT_SET_INT(menu.get_value(STAT_EDITOR_NAME), menu.get_value(STAT_EDITOR_VALUE))
                        NOTIFY(TRANSLATE("Successfully set!") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. ADD_MP_INDEX(menu.get_value(STAT_EDITOR_NAME)) .. "\n" .. TRANSLATE("Stat Value") .. ": " .. menu.get_value(STAT_EDITOR_VALUE))
                        FORCE_CLOUD_SAVE()
                    end
                end)

                menu.action(STAT_EDITOR, "Float", {}, TRANSLATE("Example Stat") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. "PLAYER_MENTAL_STATE\n" .. TRANSLATE("Stat Value") .. ": " .. "100.0", function()
                    if menu.get_value(STAT_EDITOR_NAME) == "" or menu.get_value(STAT_EDITOR_VALUE) == "" then
                        menu.focus(STAT_EDITOR_NAME)
                        NOTIFY(TRANSLATE("You didn't specify the value. Please specify it!"))
                    else
                        -- STAT_SET_FLOAT(menu.get_value(STAT_EDITOR_NAME), menu.get_value(STAT_EDITOR_VALUE))
                        STATS.STAT_SET_FLOAT(util.joaat(ADD_MP_INDEX(stat)), value, true)
                        NOTIFY(TRANSLATE("Successfully set!") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. ADD_MP_INDEX(menu.get_value(STAT_EDITOR_NAME)) .. "\n" .. TRANSLATE("Stat Value") .. ": " .. menu.get_value(STAT_EDITOR_VALUE))
                        FORCE_CLOUD_SAVE()
                    end
                end)

                menu.action(STAT_EDITOR, "Boolean", {}, TRANSLATE("Example Stat") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. "CL_RACE_MODDED_CAR\n" .. TRANSLATE("Stat Value") .. ": " .. "'true' or 'false'", function()
                    if menu.get_value(STAT_EDITOR_NAME) == "" or menu.get_value(STAT_EDITOR_VALUE) == "" then
                        menu.focus(STAT_EDITOR_NAME)
                        NOTIFY(TRANSLATE("You didn't specify the value. Please specify it!"))
                    else
                        if string.contains(menu.get_value(STAT_EDITOR_VALUE), "true") then
                            STAT_SET_BOOL(menu.get_value(STAT_EDITOR_NAME), true)
                        elseif string.contains(menu.get_value(STAT_EDITOR_VALUE), "false") then
                            STAT_SET_BOOL(menu.get_value(STAT_EDITOR_NAME), false)
                        end 
                        NOTIFY(TRANSLATE("Successfully set!") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. ADD_MP_INDEX(menu.get_value(STAT_EDITOR_NAME)) .. "\n" .. TRANSLATE("Stat Value") .. ": " .. menu.get_value(STAT_EDITOR_VALUE))
                        FORCE_CLOUD_SAVE()
                    end
                end)

                menu.action(STAT_EDITOR, "String", {}, TRANSLATE("Example Stat") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. "CHAR_NAME\n" .. TRANSLATE("Stat Value") .. ": " .. "STRING", function()
                    if menu.get_value(STAT_EDITOR_NAME) == "" or menu.get_value(STAT_EDITOR_VALUE) == "" then
                        menu.focus(STAT_EDITOR_NAME)
                        NOTIFY(TRANSLATE("You didn't specify the value. Please specify it!"))
                    else
                        STAT_SET_STRING(menu.get_value(STAT_EDITOR_NAME), menu.get_value(STAT_EDITOR_VALUE))
                        NOTIFY(TRANSLATE("Successfully set!") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. ADD_MP_INDEX(menu.get_value(STAT_EDITOR_NAME)) .. "\n" .. TRANSLATE("Stat Value") .. ": " .. menu.get_value(STAT_EDITOR_VALUE))
                        FORCE_CLOUD_SAVE()
                    end
                end)

                menu.action(STAT_EDITOR, "Date", {}, TRANSLATE("Example Stat") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. "CHAR_DATE_CREATED\n" .. TRANSLATE("Stat Value") .. ": " .. TRANSLATE("Years") .. ": 1970, " .. TRANSLATE("Months") .. ": 12, " .. TRANSLATE("Days") .. ": 25", function()
                    if menu.get_value(STAT_EDITOR_NAME) == "" then
                        menu.focus(STAT_EDITOR_NAME)
                        NOTIFY(TRANSLATE("You didn't specify the value. Please specify it!"))
                    else
                        STAT_SET_DATE(menu.get_value(STAT_EDITOR_NAME), menu.get_value(DATE_YEARS), menu.get_value(DATE_MONTHS), menu.get_value(DATE_DAYS), menu.get_value(DATE_HOURS), menu.get_value(DATE_MINS))
                        NOTIFY(TRANSLATE("Successfully set!") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. ADD_MP_INDEX(menu.get_value(STAT_EDITOR_NAME)) .. "\n" .. TRANSLATE("Years") .. ": " .. menu.get_value(DATE_YEARS) .. "\n" .. TRANSLATE("Months") .. ": " .. menu.get_value(DATE_MONTHS) .. "\n" .. TRANSLATE("Days") .. ": " .. menu.get_value(DATE_DAYS) .. "\n" .. TRANSLATE("Hours") .. ": " .. menu.get_value(DATE_HOURS) .. "\n" .. TRANSLATE("Mins") .. ": " .. menu.get_value(DATE_MINS))
                        FORCE_CLOUD_SAVE()
                    end
                end)

            ---

        ---

        STAT_READER = menu.list(STAT_EDITOR_READER, TRANSLATE("Custom Stat Reader"), {}, "", function(); end)

            menu.divider(STAT_READER, TRANSLATE("Modify Stat"))

                STAT_READER_NAME = menu.text_input(STAT_READER, TRANSLATE("Stat Name"), {"hcreadername"}, TRANSLATE("Note: MP0_ or MP1_ will be selected by HC automatically, therefore don't write it."), function()
                    local MenuValue = menu.get_value(STAT_READER_NAME)
                    local UpperValue = string.upper(MenuValue)
                    if MenuValue ~= UpperValue then
                        menu.trigger_commands("hcreadername " .. UpperValue)
                    end

                    local BlacklistedChars = {
                        "MP0_",
                        "MP1_",
                        "MPx_",
                        "_",
                    }
                    for _, keyword in pairs(BlacklistedChars) do
                        if string.startswith(MenuValue, keyword) then
                            menu.apply_default_state(STAT_READER_NAME)
                            NOTIFY(menu.get_help_text(STAT_READER_NAME))
                            NOTIFY(TRANSLATE("Successfully cancelled!"))
                        end
                    end
                end)

            ---

            menu.divider(STAT_READER, TRANSLATE("Settings"))

                ClipboardString = ""
                menu.toggle_loop(STAT_READER, TRANSLATE("Auto Paste To Stat Name"), {}, TRANSLATE("If your clipboard contains stat name, the strings will be pasted into 'Stat Name' automatically."), function()
                    local String = util.get_clipboard_text()
                    if ClipboardString ~= String then
                        if string.contains(String, "_") and string.len(String) < 40 then
                            menu.trigger_commands("hcreadername " .. String)
                        end
                    end
                    ClipboardString = String
                end)

                IS_READER_COPY = menu.toggle(STAT_READER, TRANSLATE("Copy Stat Value"), {}, "", function(); end)

            ---

            menu.divider(STAT_READER, TRANSLATE("Read Stat"))

                menu.action(STAT_READER, "Integer", {}, TRANSLATE("Example Stat") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. "NO_BOUGHT_YUM_SNACKS", function()
                    if menu.get_value(STAT_READER_NAME) == "" then
                        menu.focus(STAT_READER_NAME)
                        NOTIFY(TRANSLATE("You didn't specify the value. Please specify it!"))
                    else
                        NOTIFY(TRANSLATE("Successfully read!") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. ADD_MP_INDEX(menu.get_value(STAT_READER_NAME)) .. "\n" .. TRANSLATE("Stat Value") .. ": " .. STAT_GET_INT(menu.get_value(STAT_READER_NAME)))
                        if menu.get_value(IS_READER_COPY) then
                            util.copy_to_clipboard(STAT_GET_INT(menu.get_value(STAT_READER_NAME)))
                        end
                    end
                end)

                menu.action(STAT_READER, "Float", {}, TRANSLATE("Example Stat") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. "PLAYER_MENTAL_STATE", function()
                    if menu.get_value(STAT_READER_NAME) == "" then
                        menu.focus(STAT_READER_NAME)
                        NOTIFY(TRANSLATE("You didn't specify the value. Please specify it!"))
                    else
                        NOTIFY(TRANSLATE("Successfully read!") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. ADD_MP_INDEX(menu.get_value(STAT_READER_NAME)) .. "\n" .. TRANSLATE("Stat Value") .. ": " .. STAT_GET_FLOAT(menu.get_value(STAT_READER_NAME)))
                        if menu.get_value(IS_READER_COPY) then
                            util.copy_to_clipboard(STAT_GET_FLOAT(menu.get_value(STAT_READER_NAME)))
                        end
                    end
                end)

                menu.action(STAT_READER, "Boolean", {}, TRANSLATE("Example Stat") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. "CL_RACE_MODDED_CAR", function()
                    if menu.get_value(STAT_READER_NAME) == "" then
                        menu.focus(STAT_READER_NAME)
                        NOTIFY(TRANSLATE("You didn't specify the value. Please specify it!"))
                    else
                        NOTIFY(TRANSLATE("Successfully read!") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. ADD_MP_INDEX(menu.get_value(STAT_READER_NAME)) .. "\n" .. TRANSLATE("Stat Value") .. ": " .. STAT_GET_BOOL(menu.get_value(STAT_READER_NAME)))
                        if menu.get_value(IS_READER_COPY) then
                            util.copy_to_clipboard(STAT_GET_BOOL(menu.get_value(STAT_READER_NAME)))
                        end
                    end
                end)

                menu.action(STAT_READER, "String", {}, TRANSLATE("Example Stat") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. "CHAR_NAME", function()
                    if menu.get_value(STAT_READER_NAME) == "" then
                        menu.focus(STAT_READER_NAME)
                        NOTIFY(TRANSLATE("You didn't specify the value. Please specify it!"))
                    else
                        NOTIFY(TRANSLATE("Successfully read!") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. ADD_MP_INDEX(menu.get_value(STAT_READER_NAME)) .. "\n" .. TRANSLATE("Stat Value") .. ": " .. STAT_GET_STRING(menu.get_value(STAT_READER_NAME)))
                        if menu.get_value(IS_READER_COPY) then
                            util.copy_to_clipboard(STAT_GET_STRING(menu.get_value(STAT_READER_NAME)))
                        end
                    end
                end)

                menu.action(STAT_READER, "Date", {}, TRANSLATE("Example Stat") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. "CHAR_DATE_CREATED", function()
                    if menu.get_value(STAT_READER_NAME) == "" then
                        menu.focus(STAT_READER_NAME)
                        NOTIFY(TRANSLATE("You didn't specify the value. Please specify it!"))
                    else
                        NOTIFY(TRANSLATE("Successfully read!") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. ADD_MP_INDEX(menu.get_value(STAT_READER_NAME)) .. "\n" .. "Years: " .. STAT_GET_DATE(menu.get_value(STAT_READER_NAME), "Years") .. "\n" .. "Months: " .. STAT_GET_DATE(menu.get_value(STAT_READER_NAME), "Months") .. "\n" .. "Days: " .. STAT_GET_DATE(menu.get_value(STAT_READER_NAME), "Days") .. "\n" .. "Hours: " .. STAT_GET_DATE(menu.get_value(STAT_READER_NAME), "Hours") .. "\n" .. "Mins: " .. STAT_GET_DATE(menu.get_value(STAT_READER_NAME), "Mins"))
                        if menu.get_value(IS_READER_COPY) then
                            util.copy_to_clipboard(TRANSLATE("Years") .. ": " .. STAT_GET_DATE(menu.get_value(STAT_READER_NAME), "Years") .. "\n" .. TRANSLATE("Months") .. ": " .. STAT_GET_DATE(menu.get_value(STAT_READER_NAME), "Months") .. "\n" .. TRANSLATE("Days") .. ": " .. STAT_GET_DATE(menu.get_value(STAT_READER_NAME), "Days") .. "\n" .. TRANSLATE("Hours") .. ": " .. STAT_GET_DATE(menu.get_value(STAT_READER_NAME), "Hours") .. "\n" .. TRANSLATE("Mins") .. ": " .. STAT_GET_DATE(menu.get_value(STAT_READER_NAME), "Mins"))
                        end
                    end
                end)

            ---

        ---

        GTAHAXUI_STAT_EDITOR = menu.list(STAT_EDITOR_READER, TRANSLATE("GTAHaXUI Stat Editor"), {}, TRANSLATE("GTAHaXUI is a free mod menu for editing stats, globals, and locals from UnknownCheats. Heist Control can help you using customizable GTAHaXUI's stat txt files. Note that you can download the files by googling easily."), function(); end)

            GTAHAXUI_STAT_EDITOR_LIST = menu.list(GTAHAXUI_STAT_EDITOR, TRANSLATE("Load Custom Stat Files"), {"hchaxui"}, TRANSLATE("Supported Stat Types") .. "\n\n" .. "- 'INT32': " .. TRANSLATE("For normal numbers, generally called 'Int(eger)'") .. "\n" .. "- 'INT64': " .. TRANSLATE("For more big numbers") .. "\n" .. "- 'BOOL': " ..  TRANSLATE("'true' or 'false'"), function(); end)

                menu.divider(GTAHAXUI_STAT_EDITOR_LIST, TRANSLATE("Tools"))

                    menu.action(GTAHAXUI_STAT_EDITOR_LIST, TRANSLATE("Refresh"), {}, TRANSLATE("Refresh the list via restarting Heist Control."), function()
                        WRITE_SETTING("Saved Command Name", "hchaxui")
                        util.restart_script()
                    end)

                ---

                menu.divider(GTAHAXUI_STAT_EDITOR_LIST, TRANSLATE("Load Custom Stat Files"))

                    local HaxUIFiles = {} -- { file_name }
                    for idx, file_dir in pairs(filesystem.list_files(FolderDirs.HaxUI)) do
                        if string.contains(file_dir, ".txt") then 
                            menu.list(GTAHAXUI_STAT_EDITOR_LIST, DIR_TO_FILE_NAME("GTAHaXUI", file_dir), { "hchaxui" .. idx }, "", function(); end)
                            table.insert(HaxUIFiles, DIR_TO_FILE_NAME("GTAHaXUI", file_dir))
                        end
                    end

                    for idx1, file_name in pairs(HaxUIFiles) do
                        local open = io.open(FolderDirs.HaxUI .. file_name .. ".txt", "r")
                        local Contents = {}
                        for line in open:lines() do
                            table.insert(Contents, line)
                        end
                        open:close()

                        local StatTypes = { -- https://www.unknowncheats.me/forum/2689198-post2471.html
                            "INT32",
                            "INT64",
                            "BOOL",
                        }
                        local HelpTexts = {
                            Comment = TRANSLATE("Perfect. The file has consisted of the most ideal format. Go ahead!"),
                            Type = "N/A",
                            NumOfLine = #Contents,
                            InvalidLine = 0,
                            MPx = 0,
                            MPPLY = 0,
                        }
                        for _, file_content in pairs(Contents) do
                            for __, stat_type in pairs(StatTypes) do
                                if string.contains(file_content, stat_type) then -- If Heist Control detects GTAHaXUI's file stat type
                                    HelpTexts.Type = stat_type
                                    goto out
                                end
                            end
                        end
                        for _, file_content in pairs(Contents) do
                            if string.startswith(file_content, "$MP") then -- If at least one of the valid stats are included
                                HelpTexts.Type = "AUTO"
                                goto out
                            end
                        end
                        ::out::

                        local Stats = {} -- { stat_name, value }
                        for idx2, file_content in pairs(Contents) do
                            if string.startswith(file_content, "$MPPLY_") then -- If a MPPLY stat
                                if Contents[idx2+1] ~= nil then
                                    if not string.startswith(Contents[idx2+1], "$MP") then
                                        local _, i = string.find(file_content, "$MPPLY_")
                                        local Stat = string.sub(file_content, i + 1, string.len(file_content))
                                        Stat = string.upper(Stat)
                                        HelpTexts.MPPLY = HelpTexts.MPPLY + 1
                                        table.insert(Stats, { Stat, Contents[idx2+1] })
                                    else
                                        HelpTexts.InvalidLine = HelpTexts.InvalidLine + 1
                                    end
                                end
                            elseif string.startswith(file_content, "$MP") then -- If a MPx stat
                                if Contents[idx2+1] ~= nil then
                                    if not string.startswith(Contents[idx2+1], "$MP") then
                                        local _, i = string.find(file_content, "$MP")
                                        local Stat = string.sub(file_content, i + 3, string.len(file_content))
                                        Stat = string.upper(Stat)
                                        HelpTexts.MPx = HelpTexts.MPx + 1
                                        table.insert(Stats, { Stat, Contents[idx2+1] })
                                    else
                                        HelpTexts.InvalidLine = HelpTexts.InvalidLine + 1
                                    end
                                end
                            else -- If not a stat name
                                if Contents[idx2-1] ~= nil then -- If not the first line of the txt file
                                    if not string.startswith(Contents[idx2-1], "$MP") then -- Unless the previous line is stat name
                                        HelpTexts.InvalidLine = HelpTexts.InvalidLine + 1
                                    end
                                end
                            end
                        end

                        if HelpTexts.InvalidLine ~= 0 then
                            HelpTexts.Comment = TRANSLATE("Seems some of lines are invalid. But it doesn't matter too much. Go ahead.")
                        end
                        if HelpTexts.Type == "N/A" then
                            HelpTexts.Comment = TRANSLATE("Please check this file has been typed for GTAHaXUI. Applying it won't affect anything in GTAV.")
                        end

                        local CommandRef = menu.ref_by_command_name("hchaxui" .. idx1)
                        menu.divider(CommandRef, TRANSLATE("Tools"))

                            menu.action(CommandRef, TRANSLATE("Refresh"), {}, TRANSLATE("Refresh the list via restarting Heist Control."), function()
                                WRITE_SETTING("Saved Command Name", "hchaxui" .. idx1)
                                util.restart_script()
                            end)

                            menu.action(CommandRef, TRANSLATE("Apply Stats"), {}, "", function()
                                if HelpTexts.Type == "N/A" then NOTIFY(HelpTexts.Comment) return end
                                menu.show_warning(CommandRef, CLICK_MENU, TRANSLATE("Do you sure apply the number of stats?") .. "\n" .. "- " .. HelpTexts.MPx + HelpTexts.MPPLY, function()
                                    for i = 1, #Stats do
                                        if string.isalpha(string.lower(Stats[i][2])) then -- If stat value is BOOL
                                            if string.contains(Stats[i][2], "true") then
                                                STAT_SET_BOOL(Stats[i][1], true)
                                            elseif string.contains(Stats[i][2], "false") then
                                                STAT_SET_BOOL(Stats[i][1], false)
                                            end
                                        else
                                            if INT_MIN <= tonumber(Stats[i][2]) or tonumber(Stats[i][2]) <= INT_MAX then -- If stat value is INT32
                                                STAT_SET_INT(Stats[i][1], tonumber(Stats[i][2]))
                                            else -- If stat value is INT64
                                                STAT_SET_INT(Stats[i][1], 0)
                                                STAT_INCREMENT(Stats[i][1], tonumber(Stats[i][2]))
                                            end
                                        end
                                    end

                                    NOTIFY(TRANSLATE("Successfully set!"))
                                    FORCE_CLOUD_SAVE()
                                end, function()
                                    menu.focus(CommandRef)
                                    NOTIFY(TRANSLATE("Successfully cancelled!"))
                                end)
                            end)

                            menu.action(CommandRef, TRANSLATE("Delete This File"), {}, "", function()
                                menu.show_warning(CommandRef, CLICK_MENU, TRANSLATE("Do you sure delete this file? It cannot be recovered!"), function()
                                    local Children = menu.get_children(CommandRef)
                                    for _, child in pairs(Children) do
                                        menu.delete(child)
                                    end
                                    os.remove(FolderDirs.HaxUI .. file_name .. ".txt")

                                    menu.delete(CommandRef)
                                    NOTIFY(TRANSLATE("Successfully deleted!"))
                                end, function()
                                    menu.trigger_command(CommandRef)
                                    NOTIFY(TRANSLATE("Successfully cancelled!"))
                                end)
                            end)

                        ---

                        menu.divider(CommandRef, TRANSLATE("Comment"))

                            menu.action(CommandRef, TRANSLATE("Comment"), {}, HelpTexts.Comment, function(); end)

                        ---

                        menu.divider(CommandRef, TRANSLATE("Information"))

                            menu.action(CommandRef, TRANSLATE("Type") .. ": " .. HelpTexts.Type, {}, TRANSLATE("Except for 'N/A', doesn't matter what it is. Heist Control will make it compatible with GTAV using all methods.") .. "\n\n" .. TRANSLATE("'N/A' means this file isn't for setting stats for GTAHaXUI."), function(); end)
                            menu.action(CommandRef, TRANSLATE("Total Number of Lines") .. ": " .. HelpTexts.NumOfLine, {}, TRANSLATE("It means the number of lines of the loaded file."), function(); end)
                            menu.action(CommandRef, TRANSLATE("Number of Invalid Lines") .. ": " .. HelpTexts.InvalidLine, {}, TRANSLATE("Unless this value is '0', some of stats may not be applied, but doesn't matter unless almost of total number of lines are invalid."), function(); end)
                            menu.action(CommandRef, TRANSLATE("Number of 'MPx' Stats") .. ": " .. HelpTexts.MPx, {}, TRANSLATE("It means the number of 'MP0_ABCDE_FGHIJ' or 'MP1_ABCDE_FGHIJ' format stats."), function(); end)
                            menu.action(CommandRef, TRANSLATE("Number of 'MPPLY' Stats") .. ": " .. HelpTexts.MPPLY, {}, TRANSLATE("It means the number of 'MPPLY_ABCDE_FGHIJ' format stats."), function(); end)

                        ---
                    end

                ---

            ---

            menu.action(GTAHAXUI_STAT_EDITOR, TRANSLATE("Open Folder for Custom Stat Files"), {}, FolderDirs.HaxUI, function()
                util.open_folder(FolderDirs.HaxUI)
            end)
            
            menu.hyperlink(GTAHAXUI_STAT_EDITOR, TRANSLATE("Visit GTAHaXUI"), "https://www.unknowncheats.me/forum/grand-theft-auto-v/461672-gtahax-1-58-external-thread-3-a.html", "")

        ---

        menu.hyperlink(STAT_EDITOR_READER, TRANSLATE("All Stats List"), "https://gist.github.com/1337Nexo/945fe9724b9dd20d33e7afeabd2746dc", "")
        menu.hyperlink(STAT_EDITOR_READER, TRANSLATE("Some Useful Stats List"), "https://www.unknowncheats.me/forum/2770402-post3008.html", "")
        
    ---

    INFO_SPOOFING = menu.list(TOOLS, TRANSLATE("Stat Spoofing"), {}, TRANSLATE("Change your session to apply!"), function(); end)

        INFO_SPOOFING_WALLET_MONEY = menu.list(INFO_SPOOFING, TRANSLATE("Wallet Money"), {}, "", function(); end) -- freemode.c

            menu.toggle_loop(INFO_SPOOFING_WALLET_MONEY, TRANSLATE("Enable"), {}, IS_WORKING(false), function()
                SET_INT_GLOBAL((1853910 + 1 + players.user() * 862) + 205 + 3, menu.get_value(WALLET_MONEY_SPOOFING))
            end, function()
                SET_INT_GLOBAL((1853910 + 1 + players.user() * 862) + 205 + 3, players.get_wallet(players.user()))
            end)

            WALLET_MONEY_SPOOFING = menu.slider(INFO_SPOOFING_WALLET_MONEY, TRANSLATE("Value"), {"hcwalletmoneyspoofing"}, "", INT_MIN, INT_MAX, players.get_wallet(players.user()), 10000, function(); end)

        --- 

        INFO_SPOOFING_MONEY = menu.list(INFO_SPOOFING, TRANSLATE("Total Money"), {}, "", function(); end) -- freemode.c

            menu.toggle_loop(INFO_SPOOFING_MONEY, TRANSLATE("Enable"), {}, IS_WORKING(false), function()
                SET_INT_GLOBAL((1853910 + 1 + players.user() * 862) + 205 + 56, menu.get_value(TOTAL_MONEY_SPOOFING))
            end, function()
                SET_INT_GLOBAL((1853910 + 1 + players.user() * 862) + 205 + 56, players.get_money(players.user()))
            end)

            TOTAL_MONEY_SPOOFING = menu.slider(INFO_SPOOFING_MONEY, TRANSLATE("Value"), {"hctotalmoneyspoofing"}, "", INT_MIN, INT_MAX, players.get_bank(players.user()), 10000, function(); end)

        ---

        INFO_SPOOFING_KILL = menu.list(INFO_SPOOFING, TRANSLATE("Kills"), {}, "", function(); end) -- freemode.c

            menu.toggle_loop(INFO_SPOOFING_KILL, TRANSLATE("Enable"), {}, IS_WORKING(false), function()
                SET_INT_GLOBAL((1853910 + 1 + players.user() * 862) + 205 + 28, menu.get_value(KILL_SPOOFING))
            end, function()
                SET_INT_GLOBAL((1853910 + 1 + players.user() * 862) + 205 + 28, players.get_kills(players.user()))
            end)

            KILL_SPOOFING = menu.slider(INFO_SPOOFING_KILL, TRANSLATE("Value"), {"hckillspoofing"}, "", INT_MIN, INT_MAX, players.get_kills(players.user()), 1, function(); end)

        ---

        INFO_SPOOFING_DEATH = menu.list(INFO_SPOOFING, TRANSLATE("Deaths"), {}, "", function(); end)

            menu.toggle_loop(INFO_SPOOFING_DEATH, TRANSLATE("Enable"), {}, IS_WORKING(false), function() -- freemode.c
                SET_INT_GLOBAL((1853910 + 1 + players.user() * 862) + 205 + 29, menu.get_value(DEATH_SPOOFING))
            end, function()
                SET_INT_GLOBAL((1853910 + 1 + players.user() * 862) + 205 + 29, players.get_deaths(players.user()))
            end)

            DEATH_SPOOFING = menu.slider(INFO_SPOOFING_DEATH, TRANSLATE("Value"), {"hcdeathspoofing"}, "", INT_MIN, INT_MAX, players.get_deaths(players.user()), 1, function(); end)

        ---

    ---

    TOOLS_OTH = menu.list(TOOLS, TRANSLATE("Others"), {}, "", function(); end)

        menu.toggle_loop(TOOLS_OTH, TRANSLATE("Disable Transaction Errors"), {"hcnotransactionerr"}, IS_WORKING(true) .. TRANSLATE("This can be used to remove transaction errors while you are doing special cargo money loop in Musiness Banager Lua."), function()
            if IS_WORKING(false) ~= "" then return end
            if not util.is_session_started() then return end

            if GET_INT_GLOBAL(4536679) == 4 or 20 then
                SET_INT_GLOBAL(4536673, 0) -- https://github.com/jonaaa20/RecoverySuite
            end
        end)

        menu.toggle_loop(TOOLS_OTH, TRANSLATE("Auto Become a CEO/MC"), {"hcautobecomeceomc"}, TRANSLATE("Detects the cases that you should be a CEO/MC to start some heists/missions, make you one of it."), function()
            if not util.is_session_started() then return end

            local CEOLabels = {
                "HIP_HELP_BBOSS",
                "HIP_HELP_BBOSS2",
                "HPBOARD_REG",
                "HPBOARD_REGB",
                "HT_NOT_BOSS",
                "HUB_PC_BLCK",
                "NHPG_HELP_BBOSS",
                "OFF_COMP_REG",
                "TRUCK_PC_BLCK",
                "TUN_HELP_BBOSS",
                "BUNK_PC_BLCK",
                "CH_FINALE_REG",
                "CH_PREP_REG",
                "CH_SETUP_REG",
                "FHQ_PC_BLCK",
                "HANG_PC_BLCK",
                "HFBOARD_REG",
                "HIBOARD_REG",
                "HIBOARD_REGB",
                "MP_OFF_LAP_1",
                "MP_OFF_LAP_PC",
                "OFF_COMP_REG",
                "ARC_PC_BLCK",
                "ARC_HT_0",
                "ARC_HT_0B",
                "ACID_SLL_HLP2",
                "HRBOARD_REG",
                "HRBOARD_REGB",
            }
            for _, label in pairs(CEOLabels) do
                if IS_HELP_MSG_DISPLAYED(label) then
                    if players.get_boss(players.user()) == -1 then menu.trigger_commands("ceostart") end
                    if players.get_org_type(players.user()) == 1 then menu.trigger_commands("ceotomc") end
                    NOTIFY(TRANSLATE("Seems like you need to be a CEO. So, Heist Control made you become CEO."))
                end
            end
    
            local MCLabels = {
                "CLBHBKRREG",
                "ARC_HT_1",
                "ARC_HT_1B",
            }
            for _, label in pairs(MCLabels) do
                if IS_HELP_MSG_DISPLAYED(label) then
                    if players.get_boss(players.user()) == -1 then menu.trigger_commands("mcstart") end
                    if players.get_org_type(players.user()) == 0 then menu.trigger_commands("ceotomc") end
                    NOTIFY(TRANSLATE("Seems like you need to be a MC President. So, Heist Control made you become MC President."))
                end
            end
        end)

        menu.toggle_loop(TOOLS_OTH, TRANSLATE("Auto Collect Targets"), {}, TRANSLATE("Collects targets via clicking left mouse button. Note that there are some delays before disabling completely."), function()
            if HUD.IS_PAUSE_MENU_ACTIVE() then return end -- If pause menu is showing
            if util.spoof_script("appinternet", function(); end) then return end -- If Internet on cellphone is showing

            PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 237, 1) -- Clicks left mouse button
            util.yield(50)
        end)

        menu.textslider(TOOLS_OTH, TRANSLATE("Skips Conversation With NPCs"), {}, TRANSLATE("Skipping white texts where are center, under of the screen.") .. "\n\n" .. TRANSLATE("Would helpful for skipping something cannot be skipped using 'Game > Skip Cutscene'"), {
            TRANSLATE("All"),
            TRANSLATE("One Line"),
        }, function(index)
            if AUDIO.IS_SCRIPTED_CONVERSATION_ONGOING() then
                if index == 1 then
                    AUDIO.STOP_SCRIPTED_CONVERSATION(false)
                elseif index == 2 then
                    AUDIO.SKIP_TO_NEXT_SCRIPTED_CONVERSATION_LINE()
                end
            end
        end)

        menu.action(TOOLS_OTH, TRANSLATE("Clear All Help Messages"), {}, TRANSLATE("Clearing a black box with white help texts where are left, above of the screen.") .. "\n\n" .. TRANSLATE("Would helpful for skipping something cannot be skipped using 'Game > Skip Cutscene'"), function()
            HUD.CLEAR_ALL_HELP_MESSAGES()
        end)

        menu.action(TOOLS_OTH, TRANSLATE("Motion Skip"), {}, TRANSLATE("a.k.a Pause Menu Glitch") .. "\n\n" .. TRANSLATE("Can be used for getting targets slightly more fast."), function()
            TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
        end)
        
    ---

---


--- Setting & About HC

    menu.divider(INFOS, TRANSLATE("Language"))

        HC_LANG = menu.list_action(INFOS, TRANSLATE("Language") .. ": " .. READ_SETTING("Language"), {"hclang"}, "", {
            { "Custom", {"custom"}, "" },
            { "Chinese - 中文", {"chinese"}, "" },
            { "English", {"english"}, "" },
            { "French - français", {"french"}, "" },
            { "German - Deutsch", {"german"}, "" },
            { "Italian - Italiano", {"italian"}, "" },
            { "Japanese - 日本語", {"japanese"}, "Using this language without the customized font for Japanese will cause the situation that almost of characters are broken." .. "\n\n" .. "Please download it in Heist Control Discord!" },
            { "Korean - 한국어", {"korean"}, "Using this language without the preset font will cause the situation that almost of characters are broken." .. "\n\n" .. "Please enter this command on Command Box: 'presetfont nanumgothic'" },
            { "Polish - Polski", {"polish"}, "" },
            { "Portuguese - Português", {"portuguese"}, "" },
            { "Russian - русский", {"russian"}, "" },
            { "Spanish - Español", {"spanish"}, "" },
        }, function(_, name)
            menu.show_warning(HC_LANG, CLICK_MENU, TRANSLATE("Would you like to restart HC now?"), function()
                WRITE_SETTING("Language", name)
                util.restart_script()
            end, function()
                menu.focus(HC_LANG)
                NOTIFY(TRANSLATE("Successfully cancelled!"))
            end)
        end)

        HC_LANG_GEN = menu.list(INFOS, TRANSLATE("Generate Translation Template"), {}, "", function(); end)

            menu.divider(HC_LANG_GEN, TRANSLATE("Generate New Translation File"))

                TRANS_FILE_NAME = menu.text_input(HC_LANG_GEN, TRANSLATE("Name of The File"), {"hcgennewtrans"}, TRANSLATE("HC will overwrite if name of the file already exists."), function(); end, "Custom")

                menu.action(HC_LANG_GEN, TRANSLATE("Generate New Translation File"), {}, TRANSLATE("This action will take a few seconds. Please wait for it patiently, don't press multiple times."), function()
                    local Name = menu.get_value(TRANS_FILE_NAME)
                    if Name == "" then
                        NOTIFY(TRANSLATE("Please input name of the file!"))
                        menu.focus(TRANS_FILE_NAME)
                        return
                    end

                    menu.trigger_commands("hcupdatetransenglish")
                    NOTIFY(TRANSLATE("Waiting for updating English.txt..."))
                    util.yield(5000)

                    local File = Name .. ".txt"
                    local GeneratedFileDir = FolderDirs.Lang .. File
                    io.copyto(FolderDirs.Lang .. "English.txt", GeneratedFileDir)
                    NOTIFY(TRANSLATE("Waiting for generating:") .. " " .. File .. "...")
                    repeat util.yield_once() until filesystem.exists(GeneratedFileDir)

                    NOTIFY
                    (
                        File .. ": " .. TRANSLATE("Successfully Generated!") .. "\n\n" .. 
                        TRANSLATE("Directory of the file:") .. " " .. "%AppData%\\Stand\\Lua Scripts\\store\\Heist Control\\Language\\" .. File
                    )
                end)

            ---

            menu.divider(HC_LANG_GEN, TRANSLATE("Update Translation File"))

                UPDATE_FILE_LIST = menu.list(HC_LANG_GEN, TRANSLATE("Update Translation File"), {"hcupdatetrans"}, "", function(); end)

                    menu.divider(UPDATE_FILE_LIST, TRANSLATE("Tools"))

                        menu.action(UPDATE_FILE_LIST, TRANSLATE("Refresh"), {}, TRANSLATE("Refresh the list via restarting Heist Control."), function()
                            WRITE_SETTING("Saved Command Name", "hcupdatetrans")
                            util.restart_script()
                        end)

                    ---
                    
                    menu.divider(UPDATE_FILE_LIST, TRANSLATE("Update Translation File"))

                        for _, path in ipairs(filesystem.list_files(FolderDirs.Lang)) do
                            if string.contains(path, ".txt") then
                                menu.action(UPDATE_FILE_LIST, DIR_TO_FILE_NAME("Language", path), {"hcupdatetrans" .. DIR_TO_FILE_NAME("Language", path)}, TRANSLATE("This action will take a few seconds. Please wait for it patiently, don't press multiple times."), function()
                                    local Dir = filesystem.scripts_dir() .. SCRIPT_FILENAME
                                    local open = io.open(Dir, "r")
                                    local CodeTable = {}
                                    for line in open:lines() do
                                        table.insert(CodeTable, line)
                                    end
                                    open:close()
                                
                                    local GeneratedCodeTable = {}
                                    local StartPos = 0
                                    for _, trans in pairs(CodeTable) do
                                        while trans:find("TRANSLATE", StartPos) ~= nil do
                                            local CodeBlackListedTexts = {
                                                "TRANSLATE(Text)",
                                                '"TRANSLATE", start',
                                            }
                                            for __, Text in pairs(CodeBlackListedTexts) do
                                                if trans:find(Text) then 
                                                    goto out_of_code_loop
                                                end
                                            end
                                
                                            local __, i = trans:find("TRANSLATE", StartPos)
                                            local ___, j = trans:find('")', i + 1)
                                            if i and j ~= nil then
                                                local Text = string.sub(trans, i + 3, j - 2)
                                                table.insert(GeneratedCodeTable, Text)
                                                StartPos = j + 1
                                            else
                                                goto out_of_code_loop
                                            end
                                        end
                                        
                                        ::out_of_code_loop::
                                        StartPos = 0
                                    end
                                    
                                    ::out_of_duplicated_check_loop::
                                    for idx1, code1 in pairs(GeneratedCodeTable) do
                                        for idx2, code2 in pairs(GeneratedCodeTable) do
                                            if code1 == code2 then
                                                if idx1 < idx2 then
                                                    table.remove(GeneratedCodeTable, idx2)
                                                    goto out_of_duplicated_check_loop
                                                end
                                            end
                                        end
                                    end

                                    local open = io.open(path, "r")
                                    local TransTable = {}
                                    for line in open:lines() do
                                        table.insert(TransTable, line)
                                    end
                                    open:close()

                                    local GeneratedTransTable = {}
                                    for _, trans in pairs(TransTable) do
                                        GeneratedTransTable[#GeneratedTransTable+1] = { nil, nil } -- { english_translation, local_language_translation }
                                    end

                                    local BlacklistedChars = {
                                        "#",
                                    }
                                    for idx, trans in pairs(TransTable) do
                                        if string.contains(trans, TransFormat) then
                                            for _, Text in pairs(BlacklistedChars) do
                                                if trans:find(Text) or trans == "" or trans == " " then
                                                    goto out_of_trans_loop
                                                end
                                            end
                                
                                            local i = trans:find(TransFormat)
                                            GeneratedTransTable[idx][1] = string.sub(trans, 0, i - 1)

                                            local _, j = trans:find(TransFormat)
                                            GeneratedTransTable[idx][2] = string.sub(trans, j + 1, string.len(trans))
                                        end
                                
                                        ::out_of_trans_loop::
                                    end

                                    local ExistsTrans = {} -- In the Lua: Exists, In the translation: Exists
                                    local NotExistTrans = {} -- In the Lua: Exists, In the translation: Not Exist
                                    local NumberOfExistsTrans = 0
                                    local NumberOfNotExistTrans = 0
                                    for idx, _ in pairs(GeneratedTransTable) do
                                        if GeneratedTransTable[idx][1] and GeneratedTransTable[idx][2] ~= nil then
                                            for __, code in pairs(GeneratedCodeTable) do
                                                if GeneratedTransTable[idx][1] == code then
                                                    table.insert(ExistsTrans, GeneratedTransTable[idx][1] .. TransFormat .. GeneratedTransTable[idx][2])
                                                    NumberOfExistsTrans = NumberOfExistsTrans + 1
                                                end
                                            end
                                        end

                                        for __, code in pairs(GeneratedCodeTable) do
                                            local IsExists1 = false
                                            for i, ___ in pairs(GeneratedTransTable) do
                                                if code == GeneratedTransTable[i][1] then
                                                    IsExists1 = true
                                                end
                                            end

                                            if not IsExists1 then
                                                local Translation = code .. TransFormat .. code
                                                local IsExists2 = false
                                                for ___, trans in pairs(NotExistTrans) do
                                                    if Translation == trans then
                                                        IsExists2 = true
                                                    end
                                                end

                                                if not IsExists2 then
                                                    table.insert(NotExistTrans, Translation)
                                                    NumberOfNotExistTrans = NumberOfNotExistTrans + 1
                                                end
                                            end
                                        end
                                    end

                                    local FinalTrans = {}
                                    local ExistsNoteTrans = { -- "" = Blank, means '\n'
                                        "# DON'T REMOVE '#', OTHERWISE WILL CAUSE ERRORS!",
                                        "",
                                        "# Generated Date: " .. os.date("%m/%d/%Y %I:%M:%S %p"),
                                        "# Heist Control Version: " .. tostring(HC_VERSION),
                                        "",
                                        "# Thank you for translating Heist Control!",
                                        "# You should translate right-side of '=' character.",
                                        "# You can use all characters except '=' character.",
                                        "# Using '#' character means the line will be ignored.",
                                        "# Please join the Discord Server for Heist Control if you don't know how to translate.",
                                        "",
                                    }
                                    for _, trans in pairs(ExistsNoteTrans) do
                                        table.insert(FinalTrans, trans)
                                    end

                                    for idx, trans in pairs(ExistsTrans) do
                                        table.insert(FinalTrans, trans)
                                    end

                                    local NotExistNoteTrans = {
                                        "",
                                        "",
                                        "# Start of newly updated translations.",
                                        "# Translate them!",
                                        "",
                                        "",
                                    }
                                    if NumberOfNotExistTrans ~= 0 then
                                        for _, trans in pairs(NotExistNoteTrans) do
                                            table.insert(FinalTrans, trans)
                                        end
                                    end

                                    for _, trans in pairs(NotExistTrans) do
                                        table.insert(FinalTrans, trans)
                                    end

                                    CREATE_OR_RESET_FILE(path)
                                    for _, trans in pairs(FinalTrans) do
                                        local open = io.open(path, "a+")
                                        open:write(trans .. "\n")
                                        open:close()
                                    end

                                    NOTIFY
                                    (
                                        DIR_TO_FILE_NAME("Language", path) .. ".txt: " .. TRANSLATE("Successfully Updated!") .. "\n\n" ..
                                        TRANSLATE("- Total number of translations:") .. " " .. NumberOfExistsTrans + NumberOfNotExistTrans .. "\n\n" .. 
                                        TRANSLATE("- Number of not modified translations:") .. " " .. NumberOfExistsTrans .. "\n" .. 
                                        TRANSLATE("- Number of modified (updated) translations:") .. " " .. NumberOfNotExistTrans
                                    )
                                end)
                            end
                        end

                    ---

                ---

            ---

            menu.divider(HC_LANG_GEN, TRANSLATE("Tools"))

                menu.action(HC_LANG_GEN, TRANSLATE("Open Folder for Translations"), {}, FolderDirs.Lang, function()
                    util.open_folder(FolderDirs.Lang)
                end)

            ---

        ---

    ---

    menu.divider(INFOS, TRANSLATE("Settings"))

        NOTIFICATION_SETTING = menu.list(INFOS, TRANSLATE("Notification") .. ": " .. READ_SETTING("Notification Type"), {"hcnotification"}, "", function(); end)

            menu.divider(NOTIFICATION_SETTING, TRANSLATE("Notification's Style"))

                NOTIFICATION_ICON_SETTING = menu.list_action(NOTIFICATION_SETTING, TRANSLATE("Icon") .. ": " .. READ_SETTING("Notification Icon"), {}, "", {
                    { TRANSLATE("HC Logo"), {}, "" },
                    { TRANSLATE("Lester"), {}, "" },
                    { TRANSLATE("Legend Of Heist"), {}, "" }, 
                    { TRANSLATE("Skull Head"), {}, "" },
                    { TRANSLATE("Warstock"), {}, "" },
                    { TRANSLATE("Black R*"), {}, "" },
                    { TRANSLATE("R* Social Club"), {}, "" },
                }, function(index)
                    local IconTypes = {
                        "Logo",
                        "CHAR_LESTER",
                        "CHAR_ALL_PLAYERS_CONF",
                        "CHAR_LESTER_DEATHWISH",
                        "CHAR_MILSITE",
                        "CHAR_MP_FM_CONTACT",
                        "CHAR_SOCIAL_CLUB",
                    }
                    WRITE_SETTING("Notification Icon Code", IconTypes[index])

                    local Children = menu.get_children(NOTIFICATION_ICON_SETTING)
                    for idx, ref in pairs(Children) do
                        if index == idx then
                            WRITE_SETTING("Notification Icon", menu.get_menu_name(ref))
                        end
                    end

                    WRITE_SETTING("Notification Type", "In-Game")
                    menu.set_menu_name(NOTIFICATION_ICON_SETTING, TRANSLATE("Icon") .. ": " .. READ_SETTING("Notification Icon"))
                    menu.trigger_commands("clearnotifications")
                    menu.trigger_commands("clearstandnotifys")
                    NOTIFY(TRANSLATE("Successfully set!"))
                end)

                NOTIFICATION_COLOR_SETTING = menu.list_action(NOTIFICATION_SETTING, TRANSLATE("Background Color") .. ": " .. READ_SETTING("Notification Color"), {}, "", {
                    { TRANSLATE("White"), {}, "" },
                    { TRANSLATE("Black"), {}, "" },
                    { TRANSLATE("Red"), {}, "" },
                    { TRANSLATE("Orange"), {}, "" },
                    { TRANSLATE("Yellow"), {}, "" },
                    { TRANSLATE("Mint"), {}, "" },
                    { TRANSLATE("Green"), {}, "" },
                    { TRANSLATE("Light Blue"), {}, "" },
                }, function(index)
                    local Children = menu.get_children(NOTIFICATION_COLOR_SETTING)
                    for idx, ref in pairs(Children) do
                        if index == idx then
                            WRITE_SETTING("Notification Color", menu.get_menu_name(ref))
                        end
                    end
                    
                    local ColorTypes = {
                        160,
                        140,
                        6,
                        130,
                        180,
                        200,
                        184,
                        40,
                    }
                    WRITE_SETTING("Notification Color Code", ColorTypes[index])
                    
                    WRITE_SETTING("Notification Type", "In-Game")
                    menu.set_menu_name(NOTIFICATION_COLOR_SETTING, TRANSLATE("Background Color") .. ": " .. READ_SETTING("Notification Color"))
                    menu.trigger_commands("clearnotifications")
                    menu.trigger_commands("clearstandnotifys")
                    NOTIFY(TRANSLATE("Successfully set!"))
                end)

            ---

            menu.divider(NOTIFICATION_SETTING, TRANSLATE("Type"))

                menu.action(NOTIFICATION_SETTING, "Stand", {}, "", function()
                    WRITE_SETTING("Notification Type", "Stand")         
                    menu.set_menu_name(NOTIFICATION_SETTING, TRANSLATE("Notification") .. ": " .. READ_SETTING("Notification Type"))   
                    NOTIFY(TRANSLATE("Successfully set!"))
                end)
                menu.action(NOTIFICATION_SETTING, TRANSLATE("In-Game"), {}, "", function()
                    WRITE_SETTING("Notification Type", "In-Game")
                    menu.set_menu_name(NOTIFICATION_SETTING, TRANSLATE("Notification") .. ": " .. READ_SETTING("Notification Type"))
                    NOTIFY(TRANSLATE("Successfully set!"))
                end)
                menu.action(NOTIFICATION_SETTING, TRANSLATE("No Notification"), {}, "", function()
                    WRITE_SETTING("Notification Type", "No Notification")
                    menu.set_menu_name(NOTIFICATION_SETTING, TRANSLATE("Notification") .. ": " .. READ_SETTING("Notification Type"))
                    NOTIFY(TRANSLATE("Successfully set!"))
                end)

            ---

        ---

        TIMER_SETTING = menu.list_action(INFOS, TRANSLATE("Heist Cooldown Timer") .. ": " .. READ_SETTING("Timer Color"), {"hctimercolor"}, TRANSLATE("'Stand' setting is synced with Stand's default feature: 'Stand > Settings > Appearance > Colours > AR Colour'") .. "\n\n" .. TRANSLATE("If you changed the Stand's setting while HC is still running, need to restart HC to apply."), {
            { "Stand", {}, "" }, 
            { TRANSLATE("Black"), {}, "" },
            { TRANSLATE("White"), {}, "" },
            { TRANSLATE("Red"), {}, "" },
            { TRANSLATE("Orange"), {}, "" },
            { TRANSLATE("Yellow"), {}, "" },
            { TRANSLATE("Mint"), {}, "" }, 
            { TRANSLATE("Green"), {}, "" },
            { TRANSLATE("Light Blue"), {}, "" },
        }, function(index)
            local Children = menu.get_children(TIMER_SETTING)
            for idx, ref in pairs(Children) do
                if index == idx then
                    WRITE_SETTING("Timer Color", menu.get_menu_name(ref))
                end
            end

            local ColorCodes = {
                "000000FF",
                "FFFFFFFF",
                "FF0000FF",
                "FFA500FF",
                "FFFF00FF",
                "A2E4B8FF",
                "008000FF",
                "ADD8E6FF",
            }
            if index ~= 1 then
                WRITE_SETTING("Timer Color Code", ColorCodes[index-1])
            else
                WRITE_SETTING("Timer Color Code", GET_STAND_STATE("AR Colour"))
            end

            TimerRGB = HEX_TO_RGBA("Stand", READ_SETTING("Timer Color Code"))
            menu.set_menu_name(TIMER_SETTING, TRANSLATE("Heist Cooldown Timer") .. ": " .. READ_SETTING("Timer Color"))
            NOTIFY(TRANSLATE("Successfully set!"))
        end)

    ---

    menu.divider(INFOS, TRANSLATE("About HC"))

        CREDITS = menu.list(INFOS, TRANSLATE("Credits"), {"hccredit"}, "", function(); end)

            menu.divider(CREDITS, "jhowkNX")

                menu.hyperlink(CREDITS, "jhowkNx", "https://github.com/jhowkNx", TRANSLATE("Heist Control for 2Take1 Developer. He allowed me to use his code. HC wouldn't exist without his help. Serious thanks to him!"))

            ---

            menu.divider(CREDITS, TRANSLATE("Heist Control"))

                menu.action(CREDITS, "Nowiri", {}, "", function(); end)
                menu.action(CREDITS, "Aji", {}, "", function(); end)
                menu.action(CREDITS, "Vsus", {}, "", function(); end)
                menu.action(CREDITS, "sG.wolf", {}, "", function(); end)
                menu.action(CREDITS, "41Baloo", {}, "", function();end)
                menu.action(CREDITS, "Zetax", {}, "", function(); end)
                menu.hyperlink(CREDITS, "UnknownCheats", "https://www.unknowncheats.me/forum/grand-theft-auto-v/", "")

            ---

            menu.divider(CREDITS, TRANSLATE("Translators"))

                menu.action(CREDITS, "aRIES", {}, TRANSLATE("Maintains HC's translation") .. ": Chinese - 中文", function(); end)
                menu.action(CREDITS, "Leif.Erickson", {}, TRANSLATE("Maintains HC's translation") .. ": French - français", function(); end)
                menu.action(CREDITS, "Hibanana", {}, TRANSLATE("Maintains HC's translation") .. ": German - Deutsch", function(); end)
                menu.action(CREDITS, "Okami", {}, TRANSLATE("Maintains HC's translation") .. ": Italian - Italiano", function(); end)
                menu.action(CREDITS, "Greensky445", {}, TRANSLATE("Maintains HC's translation") .. ": Japanese - 日本語", function(); end)
                menu.action(CREDITS, "IceDoomfist", {}, TRANSLATE("Maintains HC's translation") .. ": Korean - 한국어", function(); end)
                menu.action(CREDITS, "-Negotium-", {}, TRANSLATE("Maintains HC's translation") .. ": Polish - Polski", function(); end)
                menu.action(CREDITS, "Pedro9558", {}, TRANSLATE("Maintains HC's translation") .. ": Portuguese - Português", function(); end)
                menu.action(CREDITS, "Sega", {}, TRANSLATE("Maintains HC's translation") .. ": Russian - русский", function(); end)
                menu.action(CREDITS, "zigmazero", {}, TRANSLATE("Maintains HC's translation") .. ": Spanish - Español", function(); end)

            ---

        ---

        menu.hyperlink(INFOS, TRANSLATE("Join Discord Server!"), "https://discord.gg/KTFAYQn5Xz", TRANSLATE("If you have any questions regarding Heist Control? Joining it will help you so much!") .. "\n\n" .. TRANSLATE("- Download sharable customized translations and GTAHaXUI stat files.") .. "\n" .. TRANSLATE("- Post a suggestion or an issue to improve Heist Control."))
        menu.hyperlink(INFOS, TRANSLATE("Youtube"), "https://www.youtube.com/@standheistcontrol", TRANSLATE("Videos related to HC's tutorial are uploaded here, subscribe to the channel to show your support :D"))
        menu.hyperlink(INFOS, TRANSLATE("Changelog"), "https://github.com/IceDoomfist/Stand-Heist-Control/releases", TRANSLATE("If you want to know what was changed in the latest version, click me!"))

    ---

---



--- Others

    if READ_SETTING("Saved Command Name") ~= "N/A" then
        menu.trigger_commands(READ_SETTING("Saved Command Name"))
        WRITE_SETTING("Saved Command Name", "N/A")
    end

    menu.trigger_commands("hcnotransactionerr")
    menu.trigger_commands("hcautobecomeceomc")

    HCTimerSettingChildren = menu.get_children(TIMER_SETTING)
    for _, child in pairs(HCTimerSettingChildren) do
        menu.link(TIMER_COLOR_HC, child)
    end

    ForCayoPresets = { -- { command_ref, default_help_text }
        {
            { CP_REM_FEE, IS_WORKING(false) },
        },
        {
            { CP_NON_HOST_CUT, "(%)" },
            { CP_NON_HOST_CUT_LOOP, IS_WORKING(false) },     
        },
        {
            { CP_HOST_CUT, "(%)" },
            { CP_HOST_CUT_LOOP, IS_WORKING(false) },
        },
        {
            { CP_2P_CUT, "(%)" },
            { CP_2P_CUT_LOOP, IS_WORKING(false) },
        },
        {
            { CP_3P_CUT, "(%)" },
            { CP_3P_CUT_LOOP, IS_WORKING(false) },
        },
        {
            { CP_4P_CUT, "(%)" },
            { CP_4P_CUT_LOOP, IS_WORKING(false) },
        },
    }
    CayoPresetLists = { -- { command_ref, is_enabled }
        { QUICK_PRESET, false },
        { AUTOAMTED_SOLO_SAPPHIRE, false },
        { AUTOMATED_SOLO_RUBY, false },
        { AUTOAMTED_2P_SAPPHIRE, false },
        { AUTOAMTED_2P_RUBY, false },
        { AUTOAMTED_3P_SAPPHIRE, false },
        { AUTOAMTED_3P_RUBY, false },
        { AUTOAMTED_4P_SAPPHIRE, false },
        { AUTOAMTED_4P_RUBY, false },
    }
    util.create_tick_handler(function()
        local CayoEnabledPresets = 0
        for i = 1, #CayoPresetLists do
            if CayoPresetLists[i][2] then
                CayoEnabledPresets = CayoEnabledPresets + 1
            end
        end
        if CayoEnabledPresets > 1 then
            NOTIFY(TRANSLATE("Don't enable both of automated presets at once") .. " - " .. TRANSLATE("Cayo Perico Heist") .. "\n\n" .. TRANSLATE("Successfully cancelled!"))
            for i = 1, #CayoPresetLists do
                if CayoPresetLists[i][2] then
                    menu.set_value(CayoPresetLists[i][1], false)
                end
            end
        end
    end)

    ForCasinoPresets = { -- { command_ref, value, default_help_text }
        { CAH_NON_HOST_CUT, 60, "(%)" },
        { CAH_NON_HOST_CUT_LOOP, false, IS_WORKING(false) },
        { CAH_HOST_CUT, 60, "(%)" },
        { CAH_HOST_CUT_LOOP, true, IS_WORKING(false) },
        { CAH_2P_CUT, 147, "(%)" },
        { CAH_2P_CUT_LOOP, true, IS_WORKING(false) },
        { CAH_3P_CUT, 147, "(%)" },
        { CAH_3P_CUT_LOOP, true, IS_WORKING(false) },
        { CAH_4P_CUT, 147, "(%)" },
        { CAH_4P_CUT_LOOP, true, IS_WORKING(false) },
    }
    CasinoPresetLists = { -- { command_ref, is_enabled }
        { DIAMOND_SS, false },
        { DIAMOND_BA, false },
        { DIAMOND_AA, false },
        { GOLD_SS, false },
        { GOLD_BA, false },
        { GOLD_AA, false },
    }
    util.create_tick_handler(function()
        local CasinoEnabledPresets = 0
        for i = 1, #CasinoPresetLists do
            if CasinoPresetLists[i][2] then
                CasinoEnabledPresets = CasinoEnabledPresets + 1
            end
        end
        if CasinoEnabledPresets > 1 then
            NOTIFY(TRANSLATE("Don't enable both of automated presets at once") .. " - " .. TRANSLATE("Diamond Casino Heist") .. "\n\n" .. TRANSLATE("Successfully cancelled!"))
            for i = 1, #CasinoPresetLists do
                if CasinoPresetLists[i][2] then
                    menu.set_value(CasinoPresetLists[i][1], false)
                end
            end
        end
    end)

    ForDoomsPresets = { -- { command_ref, default_help_text }
        { DOOMS_NON_HOST_CUT, "(%)" },
        { DOOMS_NON_HOST_CUT_LOOP, IS_WORKING(false) },
        { DOOMS_HOST_CUT, "(%)" },
        { DOOMS_HOST_CUT_LOOP, IS_WORKING(false) },
        { DOOMS_2P_CUT, "(%)" },
        { DOOMS_2P_CUT_LOOP, IS_WORKING(false) },
        { DOOMS_3P_CUT, "(%)" },
        { DOOMS_3P_CUT_LOOP, IS_WORKING(false) },
        { DOOMS_4P_CUT, "(%)" },
        { DOOMS_4P_CUT_LOOP, IS_WORKING(false) },
    }
    DoomsPresetLists = { -- { command_ref, is_enabled }
        { DOOMS_PRESETS_ACT1, false },
        { DOOMS_PRESETS_ACT2, false },
        { DOOMS_PRESETS_ACT3, false },
    }
    util.create_tick_handler(function()
        local DoomsEnabledPresets = 0
        for i = 1, #DoomsPresetLists do
            if DoomsPresetLists[i][2] then
                DoomsEnabledPresets = DoomsEnabledPresets + 1
            end
        end
        if DoomsEnabledPresets > 1 then
            NOTIFY(TRANSLATE("Don't enable both of automated presets at once") .. " - " .. TRANSLATE("Doomsday Heist") .. "\n\n" .. TRANSLATE("Successfully cancelled!"))
            for i = 1, #DoomsPresetLists do
                if DoomsPresetLists[i][2] then
                    menu.set_value(DoomsPresetLists[i][1], false)
                end
            end
        end
    end)

    TPs = {
        {
            { CAYO_TELE_COMPOUND, nil },
            { CAYO_TELE_ISLAND, nil },
            { TELEPORT_CP_KOSATKA, HUD.GET_BLIP_COORDS(SubBlip) },
        },

        {
            { CAYO_TELE_AIRSTRIP, nil },
            { CAYO_TELE_CROP_FIELDS, nil },
            { CAYO_TELE_MAIN_DOCK, nil },
            { CAYO_TELE_NORTH_DOCK, nil },
            { CAYO_TELE_ISLAND_RADIO, v3.new(5263.7124, -5407.5835, 65.24931) },
            { CAYO_TELE_ISLAND_DRAINGE_1, v3.new(5044.001, -5815.6426, -11.808871) },
            { CAYO_TELE_ISLAND_DRAINGE_2, v3.new(5053.773, -5773.2266, -5.40778) },
            { CAYO_TELE_ISLAND_SAFE_ZONE, v3.new(4771.479, -6165.737, -39.079613) },
        },

        {
            { CAYO_TELE_STORAGE, nil },
            { CAYO_TELE_VAULT, nil },
            { CAYO_TELE_COMPOUND_OFFICE, v3.new(5010.12, -5750.1353, 28.84334) },
            { CAYO_TELE_COMPOUND_FRONT_EXIT, v3.new(4990.0386, -5717.6895, 19.880217) },
        },
        {
            { CAYO_TELE_STORAGE_NORTH, v3.new(5081.0415, -5755.32, 15.829645) },
            { CAYO_TELE_STORAGE_WEST, v3.new(5006.722, -5786.5967, 17.831688) },
            { CAYO_TELE_STORAGE_SOUTH, v3.new(5027.603, -5734.682, 17.255005) },
        },
        {
            { CAYO_TELE_VAULT_PRIMARY_TARGET, v3.new(5006.7, -5756.2, 14.8) },
            { CAYO_TELE_VAULT_SECONDARY_TARGET, v3.new(4999.764160, -5749.863770, 14.840000) },
        },

        {
            { CAYO_TELE_AIRSTRIP_1, v3.new(4503.587402, -4555.740723, 2.854459) },
            { CAYO_TELE_AIRSTRIP_2, v3.new(4437.821777, -4447.841309, 3.028436) },
            { CAYO_TELE_AIRSTRIP_3, v3.new(4447.091797, -4442.184082, 5.936794) },
        },
        {
            { CAYO_TELE_CROP_FIELDS_1, v3.new(5330.527, -5269.7515, 33.18603) },
        },
        {
            { CAYO_TELE_MAIN_DOCK_1, v3.new(5193.909668, -5135.642578, 2.045917) },
            { CAYO_TELE_MAIN_DOCK_2, v3.new(4963.184570, -5108.933105, 1.670808) },
            { CAYO_TELE_MAIN_DOCK_3, v3.new(4998.709473, -5165.559570, 1.464137) },
            { CAYO_TELE_MAIN_DOCK_4, v3.new(4924.693359, -5243.244629, 1.223599) },
        },
        {
            { CAYO_TELE_NORTH_DOCK_1, v3.new(5132.558594, -4612.922852, 1.162808) },
            { CAYO_TELE_NORTH_DOCK_2, v3.new(5065.255371, -4591.706543, 1.555012) },
            { CAYO_TELE_NORTH_DOCK_3, v3.new(5090.916016, -4682.670898, 1.107098) },
        },

        {
            { TELEPORT_CAH_ENTRANCE, ArcadePos },
            { TELEPORT_CAH_IN_BOARD, v3.new(2711.773, -369.458, -54.781) },
            { TELEPORT_CAH_IN_EXIT, v3.new(2677.237, -361.494, -55.187) },
            { TELEPORT_CAH_IN_DISPOSAL, v3.new(2542.052, -214.3084, -58.722965) },
            { TELEPORT_CAH_IN_LOBBY, v3.new(2547.9192, -273.16754, -58.723003) },
            { TELEPORT_CAH_IN_DOOR, v3.new(2465.4746, -279.2276, -70.694145) },
            { TELEPORT_CAH_IN_VAULT_IN, v3.new(2515.1252, -238.91661, -70.73713) },
            { TELEPORT_CAH_IN_VAULT_OUT, v3.new(2497.5098, -238.50768, -70.7388) },
            { TELEPORT_CAH_IN_DAILY_CASH, v3.new(2520.8645, -286.30685, -58.723007) },
            { TELEPORT_CAH_OUT_GATE, v3.new(917.24634, 48.989567, 80.89892) },
            { TELEPORT_CAH_OUT_LOBBY, v3.new(965.14856, -9.05023, 80.63045) },
            { TELEPORT_CAH_OUT_DISPOSAL, v3.new(997.5346, 84.51491, 80.990555) },
        },
 
        {
            { TELEPORT_DOOMS_ENTRANCE, FacilityPos },
            { TELEPORT_DOOMS_SCREEN, v3.new(350.69284, 4872.308, -60.794243) },
            { TELEPORT_DOOMS_BOARD, v3.new(515.528, 4835.353, -62.587) },
            { TELEPORT_DOOMS_CELL, v3.new(512.888, 4833.033, -68.989) },
        },
    }
    for i = 1, #TPs do
        for j = 1, #TPs[i] do
            if TPs[i][j][2] ~= nil then
                menu.on_tick_in_viewport(TPs[i][j][1], function()
                    if GET_CURSOR_POSITION() == j then
                        local Command = menu.ref_by_path("Stand>Settings>Appearance>Stream-Proof Rendering", 44)
                        if menu.get_value(Command) then return end
            
                        local PlayerPos = players.get_position(players.user())
                        local Color = HEX_TO_RGBA("Game", GET_STAND_STATE("HUD Colour"))
                        GRAPHICS.DRAW_LINE(PlayerPos.x, PlayerPos.y, PlayerPos.z, TPs[i][j][2].x, TPs[i][j][2].y, TPs[i][j][2].z, Color.r, Color.g, Color.b, Color.a)
                        HUD.LOCK_MINIMAP_POSITION(TPs[i][j][2].x, TPs[i][j][2].y)
                        local BeaconPos = v3.new(TPs[i][j][2].x, TPs[i][j][2].y, TPs[i][j][2].z)
                        util.draw_ar_beacon(BeaconPos)
                    end
                end)
            else
                menu.on_tick_in_viewport(TPs[i][j][1], function()
                    HUD.UNLOCK_MINIMAP_POSITION()
                end)
            end
        end
    end

    TPPlaces = {
        TELEPORT_CP,
        TELEPORT_CAH,
        TELEPORT_DOOMS,
    }
    for _, list in pairs(TPPlaces) do
        menu.on_tick_in_viewport(list, function()
            HUD.UNLOCK_MINIMAP_POSITION()
        end)
    end

---