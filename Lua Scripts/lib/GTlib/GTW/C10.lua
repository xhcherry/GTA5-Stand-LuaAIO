--[[   To everyone who uses Heist Control.lua

    Developed and maintenanced by @icedoomfist on Discord
    This script is only compatible with Stand Lua API: https://stand.gg/

    Stand Heist Control contains some global, local variables and stats from Heist Control V2 & Master Unlocker Lua Scripts for 2Take1 and UnknownCheats
    Thanks for allowing me to use your code, jhowkNx: https://github.com/jhowkNx
    I've often been contacting on Discord, testing some developing features, sharing information like stats, global and local variables and other codes each other.

    Heist Control V2: https://github.com/jhowkNx/Heist-Control-v2
    Master Unlocker: https://github.com/jhowkNx/Master-Unlocker
    UnknownCheats: https://www.unknowncheats.me/forum/grand-theft-auto-v/

]]--

--[[   To developers who wanna learn about stats, global and local variables or Stand Lua Script API by looking into Heist Control.lua

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
    GTA Online Decompiled Scripts: https://github.com/root-cause/v-decompiled-scripts (Recommended)
    - To find stats, global and local variables by yourself. 'freemode.c' and 'tuneables_processing.c' are oftenly used to me. 

]]--


--- Lua Script Settings

    --- Important

        HC_VERSION = "V 3.4.5"
        CODED_GTAO_VERSION = 1.70 -- b3407

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
            Vietnamese = FolderDirs.Lang .. "Vietnamese.txt",
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
        function STAT_SET_BOOL(stat, value)
            STATS.STAT_SET_BOOL(util.joaat(ADD_MP_INDEX(stat)), value, true)
        end
        function STAT_SET_STRING(stat, value)
            STATS.STAT_SET_STRING(util.joaat(ADD_MP_INDEX(stat)), value, true)
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
        function STAT_GET_STRING(stat)
            return STATS.STAT_GET_STRING(util.joaat(ADD_MP_INDEX(stat)), -1)
        end

        function SET_INT_GLOBAL(global, value)
            memory.write_int(memory.script_global(global), value)
        end
        function SET_INT_TUNABLE_GLOBAL(hash, value)
            memory.write_int(memory.script_global(262145 + memory.tunable_offset(hash)), value)
        end
        function SET_FLOAT_GLOBAL(global, value)
            memory.write_float(memory.script_global(global), value)
        end
        function SET_FLOAT_TUNABLE_GLOBAL(hash, value)
            memory.write_float(memory.script_global(262145 + memory.tunable_offset(hash)), value)
        end

        function GET_INT_GLOBAL(global)
            return memory.read_int(memory.script_global(global))
        end

        function SET_PACKED_INT_GLOBAL(start_global, end_global, value)
            for i = start_global, end_global do
                SET_INT_GLOBAL(262145 + i, value)
            end
        end
        function SET_PACKED_INT_TUNABLE_GLOBAL(start_hash, end_hash, value)
            for i = memory.tunable_offset(start_hash), memory.tunable_offset(end_hash) do
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
                { "it", "Italian - Italiano" },
                { "jp", "Japanese - 日本語" },
                { "ko", "Korean - 한국어" },
                { "pl", "Polish - Polski" },
                { "pt", "Portuguese - Português" },
                { "ru", "Russian - русский" },
                { "es", "Spanish - Español" },
                { "vi", "Vietnamese - Tiếng Việt" },
            }
            for i = 1, #LangByStandCodes do
                if lang.get_current() == LangByStandCodes[i][1] then
                    WRITE_SETTING("Language", LangByStandCodes[i][2])
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
            { "Vietnamese - Tiếng Việt", LangDirs.Vietnamese },
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
--[[
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
]]
        function TELEPORT(x, y, z)
            PED.SET_PED_COORDS_KEEP_VEHICLE(players.user_ped(), x, y, z)
        end
        function SET_HEADING(heading)
            ENTITY.SET_ENTITY_HEADING(players.user_ped(), heading)
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
            return tonumber(string.sub(Text, 0, i - 1)) -- Returns '2'
        end

        function IS_HELP_MSG_DISPLAYED(label) -- Credit goes to @jerry1234508 on Discord
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

        function START_SCRIPT(name)
            if HUD.IS_PAUSE_MENU_ACTIVE() then
                NOTIFY(TRANSLATE("Please close your opened pause menu to open any apps remotely."))
                return
            end

            SCRIPT.REQUEST_SCRIPT(name)
            repeat util.yield_once() until SCRIPT.HAS_SCRIPT_LOADED(name)
            SYSTEM.START_NEW_SCRIPT(name, 5000)
            SCRIPT.SET_SCRIPT_AS_NO_LONGER_NEEDED(name)
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

        if CODED_GTAO_VERSION ~= tonumber(NETWORK.GET_ONLINE_VERSION()) then
            NOTIFY
            (
                TRANSLATE("Supported GTA:O Version:") .. " " .. CODED_GTAO_VERSION .. "\n" ..
                TRANSLATE("Current GTA:O Version:") .. " " .. tonumber(NETWORK.GET_ONLINE_VERSION()) .. "\n\n" ..
                TRANSLATE("Please download the latest Heist Control or wait for developer's patching!")
            )

            util.stop_script()
        end

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

        if READ_SETTING("Timer Color") == "Stand" then
            WRITE_SETTING("Timer Color Code", GET_STAND_STATE("AR Colour"))
        end
--[[
        if SCRIPT_MANUAL_START and not SCRIPT_SILENT_START then
            SHOW_IMG("HC Banner.png", 2.5)
        end
]]
    ---

---


--- Main Lists

    menu.divider(Heist_Control, TRANSLATE("Heist Control") .. " " .. HC_VERSION)

        PERICO_HEIST = menu.list(Heist_Control, TRANSLATE("Cayo Perico Heist"), {"hccp"}, TRANSLATE("Max payout for this heist") .. "\n\n" .. TRANSLATE("- Under $2.550.000 per run") .. "\n" .. TRANSLATE("- Under $4.100.000 per hour") .. "\n\n" .. TRANSLATE("You won't get money if you don't keep money limitation!"), function();  end)
        CASINO_HEIST = menu.list(Heist_Control, TRANSLATE("Diamond Casino Heist"), {"hccah"}, TRANSLATE("Max payout for this heist") .. "\n\n" .. TRANSLATE("- Under $3.650.000 per run") .. "\n\n" .. TRANSLATE("You won't get money if you don't keep money limitation!"), function(); end)
        DOOMS_HEIST = menu.list(Heist_Control, TRANSLATE("Doomsday Heist"), {"hcdooms"}, TRANSLATE("Max payout for this heist") .. "\n\n" .. TRANSLATE("- Under $2.550.000 per run") .. "\n\n" .. TRANSLATE("You won't get money if you don't keep money limitation!"), function(); end)
        CLASSIC_HEISTS = menu.list(Heist_Control, TRANSLATE("Classic Heist"), {"hcclassic"}, TRANSLATE("Max payout for this heist") .. "\n\n" .. TRANSLATE("- Fleeca Heist ~ Pacific Standard Heist: Under $15.000.000 per run") .. "\n\n" .. TRANSLATE("You won't get money if you don't keep money limitation!"), function(); end)
        ROBBERYS = menu.list(Heist_Control, TRANSLATE("Robberies"), {"hcrob"}, "", function(); end)
        MISSONS = menu.list(Heist_Control, TRANSLATE("Missions"), {"hcmission"}, "", function(); end)
        MASTER_UNLOCKER = menu.list(Heist_Control, TRANSLATE("Master Unlocker"), {"hcmu"}, "", function(); end)
        TOOLS = menu.list(Heist_Control, TRANSLATE("Tools"), {"hctool"}, "", function(); end)
        INFOS = menu.list(Heist_Control, TRANSLATE("Settings And About HC"), {"hcinfo"}, "", function(); end)

    ---

---


--- Cayo Perico Heist
util.yield()
    
    CAYO_PRESETS = menu.list(PERICO_HEIST, TRANSLATE("Automated Presets"), {}, TRANSLATE("You should enable the preset until the end of the heist!") .. "\n\n" .. TRANSLATE("Enabling one of these presets will complete all of setups, and set as max payout, $2.55 Millions. It will be affected to all of heist players."), function(); end)

        menu.divider(CAYO_PRESETS, TRANSLATE("Recommended"))

            QuickPresetTunables = {
                memory.tunable_offset("IH_PRIMARY_TARGET_VALUE_SAPPHIRE_PANTHER_STATUE"),
                memory.tunable_offset("IH_PRIMARY_TARGET_VALUE_MADRAZO_FILES"),
                memory.tunable_offset("IH_PRIMARY_TARGET_VALUE_PINK_DIAMOND"),
                memory.tunable_offset("IH_PRIMARY_TARGET_VALUE_BEARER_BONDS"),
                memory.tunable_offset("IH_PRIMARY_TARGET_VALUE_PEARL_NECKLACE"),
                memory.tunable_offset("IH_PRIMARY_TARGET_VALUE_TEQUILA"),
            }
            QUICK_PRESET = menu.toggle(CAYO_PRESETS, TRANSLATE("Quick Preset (1 - 4P)"), {"hccpquick"}, TRANSLATE("There is only a primary target, depends on which you selected. All players of the heist session can get the max payout ($2.45M) by only getting it."), function()
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
                        { 5, 262145 + QuickPresetTunables[1] },
                        { 4, 262145 + QuickPresetTunables[2] },
                        { 3, 262145 + QuickPresetTunables[3] },
                        { 2, 262145 + QuickPresetTunables[4] },
                        { 1, 262145 + QuickPresetTunables[5] },
                        { 0, 262145 + QuickPresetTunables[6] },
                    }
                    STAT_SET_INT("H4CNF_TARGET", CPTargets[Value][1])
                    SET_INT_GLOBAL(CPTargets[Value][2], 2455000)
                    
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
                { 1, TRANSLATE("Sapphire Panther"), {}, "" },
                { 2, TRANSLATE("Madrazo Files"), {}, "" },
                { 3, TRANSLATE("Pink Diamond"), {}, "" },
                { 4, TRANSLATE("Bearer Bonds"), {}, "" },
                { 5, TRANSLATE("Ruby Necklace"), {}, "" },
                { 6, TRANSLATE("Tequila"), {}, "" },
            }, 1, function(); end)

        ---

        menu.divider(CAYO_PRESETS, TRANSLATE("Automated Presets"))

            AUTOMATED_SOLO = menu.list(CAYO_PRESETS, TRANSLATE("1 Player"), {}, "", function(); end)

                AUTOAMTED_SOLO_SAPPHIRE = menu.toggle(AUTOMATED_SOLO, TRANSLATE("Sapphire Panther"), {"hccp1psp"}, "", function()
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

                AUTOMATED_SOLO_RUBY = menu.toggle(AUTOMATED_SOLO, TRANSLATE("Ruby Necklace"), {"hccp1prn"}, "", function()
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

                AUTOAMTED_2P_SAPPHIRE = menu.toggle_loop(AUTOMATED_2P, TRANSLATE("Sapphire Panther"), {"hccp2psp"}, "", function()   
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

                AUTOAMTED_2P_RUBY = menu.toggle_loop(AUTOMATED_2P, TRANSLATE("Ruby Necklace"), {"hccp2prn"}, "", function()  
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

                AUTOAMTED_3P_SAPPHIRE = menu.toggle_loop(AUTOMATED_3P, TRANSLATE("Sapphire Panther"), {"hccp3psp"}, "", function()
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

                AUTOAMTED_3P_RUBY = menu.toggle_loop(AUTOMATED_3P, TRANSLATE("Ruby Necklace"), {"hccp3prn"}, "", function()
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

                AUTOAMTED_4P_SAPPHIRE = menu.toggle_loop(AUTOMATED_4P, TRANSLATE("Sapphire Panther"), {"hccp4psp"}, "", function()
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

                AUTOAMTED_4P_RUBY = menu.toggle_loop(AUTOMATED_4P, TRANSLATE("Ruby Necklace"), {"hccp4prn"}, "", function()
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

        TELEPORT_CP_KOSATKA = menu.action(TELEPORT_CP, TRANSLATE("Kosatka: Heist Board"), {"hctpsub"}, TRANSLATE("Note that works on best when you are alone in your session."), function()
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

                TELEPORT(1561.2369, 385.8831, -49.689915)
                SET_HEADING(175)
            else
                NOTIFY(TRANSLATE("You didn't buy the Kosatka yet. Buy it first to teleport!"))
            end
        end)

    ---

    PERICO_ADV = menu.list(PERICO_HEIST, TRANSLATE("Advanced Features"), {}, "", function(); end)

        PERICO_CUTS = menu.list(PERICO_ADV, TRANSLATE("Player's Cut"), {}, TRANSLATE("Don't forget changing this feature before starting the heist! Otherwise, won't be applied."), function(); end)

            PERICO_NON_HOST_CUT = menu.list(PERICO_CUTS, TRANSLATE("Your Cut (Non-Host)"), {}, TRANSLATE("Note that modifying this won't applied to the heist board. You can check the applied cut after end of the heist."), function(); end)

                CP_NON_HOST_CUT_LOOP = menu.toggle_loop(PERICO_NON_HOST_CUT, TRANSLATE("Enable"), {"hccpnonhostloop"}, "", function()
                    SET_INT_GLOBAL(2685658 + 6651, menu.get_value(CP_NON_HOST_CUT))-- [[update]] (freemode.c)
                end, function()
                    SET_INT_GLOBAL(2685658 + 6651, menu.get_default_state(CP_NON_HOST_CUT)) -- [[update]] (freemode.c)
                end)

                CP_NON_HOST_CUT = menu.slider(PERICO_NON_HOST_CUT, TRANSLATE("Custom Percentage"), {"hccpnonhost"}, "(%)", 0, 1000, 100, 5, function(); end)

            ---

            PERICO_HOST_CUT = menu.list(PERICO_CUTS, TRANSLATE("Your Cut"), {}, TRANSLATE("Only works if you are host of the heist."), function(); end)

                CP_HOST_CUT_LOOP = menu.toggle_loop(PERICO_HOST_CUT, TRANSLATE("Enable"), {"hccphostcutloop"}, "", function()
                    SET_INT_GLOBAL(1972414 + 831 + 56 + 1, menu.get_value(CP_HOST_CUT)) -- [[update]] (heist_island_planning.c)
                end, function()
                    SET_INT_GLOBAL(1972414 + 831 + 56 + 1, menu.get_default_state(CP_HOST_CUT)) -- [[update]]
                end)

                CP_HOST_CUT = menu.slider(PERICO_HOST_CUT, TRANSLATE("Custom Percentage"), {"hccphostcut"}, "(%)", 0, 1000, 100, 5, function(); end)

            ---

            PERICO_P2_CUT = menu.list(PERICO_CUTS, TRANSLATE("Player 2"), {}, TRANSLATE("Only works if you are host of the heist."), function(); end)

                CP_2P_CUT_LOOP = menu.toggle_loop(PERICO_P2_CUT, TRANSLATE("Enable"), {"hccp2pcutloop"}, "", function()
                    SET_INT_GLOBAL(1972414 + 831 + 56 + 2, menu.get_value(CP_2P_CUT)) -- heist_island_planning.c [[update]]
                end, function()
                    SET_INT_GLOBAL(1972414 + 831 + 56 + 2, menu.get_default_state(CP_2P_CUT)) -- [[update]]
                end)

                CP_2P_CUT = menu.slider(PERICO_P2_CUT, TRANSLATE("Custom Percentage"), {"hccp2pcut"}, "(%)", 0, 1000, 100, 5, function(); end)
            
            ---
            
            PERICO_P3_CUT = menu.list(PERICO_CUTS, TRANSLATE("Player 3"), {}, TRANSLATE("Only works if you are host of the heist."), function(); end)

                CP_3P_CUT_LOOP = menu.toggle_loop(PERICO_P3_CUT, TRANSLATE("Enable"), {"hccp3pcutloop"}, "", function()
                    SET_INT_GLOBAL(1972414 + 831 + 56 + 3, menu.get_value(CP_3P_CUT)) -- heist_island_planning.c [[update]]
                end, function()
                    SET_INT_GLOBAL(1972414 + 831 + 56 + 3, menu.get_default_state(CP_3P_CUT)) -- [[update]]
                end)

                CP_3P_CUT = menu.slider(PERICO_P3_CUT, TRANSLATE("Custom Percentage"), {"hccp3pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

            ---

            PERICO_P4_CUT = menu.list(PERICO_CUTS, TRANSLATE("Player 4"), {}, TRANSLATE("Only works if you are host of the heist."), function(); end)

                CP_4P_CUT_LOOP = menu.toggle_loop(PERICO_P4_CUT, TRANSLATE("Enable"), {"hccp4pcutloop"}, "", function()
                    SET_INT_GLOBAL(1972414 + 831 + 56 + 4, menu.get_value(CP_4P_CUT)) -- heist_island_planning.c [[update]]
                end, function()
                    SET_INT_GLOBAL(1972414 + 831 + 56 + 4, menu.get_default_state(CP_4P_CUT)) -- [[update]]
                end)

                CP_4P_CUT = menu.slider(PERICO_P4_CUT, TRANSLATE("Custom Percentage"), {"hccp4pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

            ---

        ---

        menu.list_action(PERICO_ADV, TRANSLATE("Bag Capacity Modifier"), {"hccpbag"}, TRANSLATE("(Local)"), {
            { 1, TRANSLATE("Normal Bag Capacity"), {"1p"}, "" },
            { 2, TRANSLATE("Simulate Bag Capacity of 2 players"), {"2p"}, "" },
            { 3, TRANSLATE("Simulate Bag Capacity of 3 players"), {"3p"}, "" },
            { 4, TRANSLATE("Simulate Bag Capacity of 4 players"), {"4p"}, "" },
            { 5, TRANSLATE("Infinite Bag Capacity"), {"inf"}, "" },
        }, function(index)
            if index ~= 5 then
                SET_INT_TUNABLE_GLOBAL(1859395035, 1800 * index)
            else
                SET_INT_TUNABLE_GLOBAL(1859395035, 99999)
            end
        end)

        menu.toggle_loop(PERICO_ADV, TRANSLATE("Skip The Hacking Process"), {}, "(" .. TRANSLATE("Cayo Perico Heist") .. " > " .. TRANSLATE("Teleport Places") .. " > " .. TRANSLATE("Compound") .. " > " .. TRANSLATE("El Rubio's Office") .. ")", function() 
            if GET_INT_LOCAL("fm_mission_controller_2020", 24986) == 4 then -- https://www.unknowncheats.me/forum/3418914-post13398.html
                SET_INT_LOCAL("fm_mission_controller_2020", 24986, 5) -- [[update]]
            end
        end)

        menu.toggle_loop(PERICO_ADV, TRANSLATE("Skip Cutting The Sewer Grill"), {}, "(" .. TRANSLATE("Cayo Perico Heist") .. " > " .. TRANSLATE("Teleport Places") .. " > " .. TRANSLATE("Island") .. " > " .. TRANSLATE("Drainage Pipe") .. ")", function() 
            if GET_INT_LOCAL("fm_mission_controller_2020", 29810) == 4 then -- https://www.unknowncheats.me/forum/3389282-post1.html  
                SET_INT_LOCAL("fm_mission_controller_2020", 29810, 6) -- [[update]]
            end
        end)

        menu.toggle_loop(PERICO_ADV, TRANSLATE("Skip Cutting The Glass"), {}, "(" .. TRANSLATE("Cayo Perico Heist") .. " > " .. TRANSLATE("Teleport Places") .. " > " .. TRANSLATE("Compound") .. " > " .. TRANSLATE("Primary Target") .. ")", function()
            SET_FLOAT_LOCAL("fm_mission_controller_2020", 31049 + 3, 100)
        end, function()
            SET_FLOAT_LOCAL("fm_mission_controller_2020", 31049 + 3, 0) -- [[update]]
        end)

        menu.toggle_loop(PERICO_ADV, TRANSLATE("Infinite Plasma Cutter Heat"), {}, "(" .. TRANSLATE("Cayo Perico Heist") .. " > " .. TRANSLATE("Teleport Places") .. " > " .. TRANSLATE("Compound") .. " > " .. TRANSLATE("Primary Target") .. ")", function()
            SET_FLOAT_LOCAL("fm_mission_controller_2020", 31049 + 4, 0) -- [[update]]
        end)

        menu.toggle_loop(PERICO_ADV, TRANSLATE("Infinite Voltage Timer"), {}, "(" .. TRANSLATE("Cayo Perico Heist") .. " > " .. TRANSLATE("Teleport Places") .. " > " .. TRANSLATE("Island") .. " > " .. TRANSLATE("Radio Tower") .. ")", function()
            local Value = GET_INT_LOCAL("fm_mission_controller_2020", 1745) -- [[update]]
            SET_INT_LOCAL("fm_mission_controller_2020", 1744, Value) -- [[update]]
        end, function()
            SET_INT_LOCAL("fm_mission_controller_2020", 1744, 0) -- [[update]]
        end)

        CPRemFeeTunables = {
            memory.tunable_offset(902085532),
            memory.tunable_offset(-1135949374),
        }
        CP_REM_FEE = menu.toggle_loop(PERICO_ADV, TRANSLATE("Remove The Fencing Fee And Pavel's Cut"), {"hccpremfee"}, TRANSLATE("(Local)") .. "\n\n" .. TRANSLATE("You should enable the preset until the end of the heist!"), function()
            SET_FLOAT_GLOBAL(262145 + CPRemFeeTunables[1], 0)
            SET_FLOAT_GLOBAL(262145 + CPRemFeeTunables[2], 0)
        end, function()
            SET_FLOAT_GLOBAL(262145 + CPRemFeeTunables[1], -0.1)
            SET_FLOAT_GLOBAL(262145 + CPRemFeeTunables[2], -0.02)
        end)

        menu.action(PERICO_ADV, TRANSLATE("Force Ready"), {"hccpforceready"}, TRANSLATE("Forces the players on board to ready."), function() 
            -- [[update]]
            SET_INT_GLOBAL(1973526 + 1 + (1 * 27) + 8 + 1, 1) -- Thanks to @vithiam on Discord
            SET_INT_GLOBAL(1973526 + 1 + (2 * 27) + 8 + 2, 1) 
            SET_INT_GLOBAL(1973526 + 1 + (3 * 27) + 8 + 3, 1) 
        end)

        menu.action(PERICO_ADV, TRANSLATE("Obtain The Primary Target"), {"hccpfintar"}, "(" .. TRANSLATE("Cayo Perico Heist") .. " > " .. TRANSLATE("Teleport Places") .. " > " .. TRANSLATE("Compound") .. " > " .. TRANSLATE("Primary Target") .. ")", function() -- https://www.unknowncheats.me/forum/3418914-post13398.html
            SET_INT_LOCAL("fm_mission_controller_2020", 31048, 5) -- CutterStage [[update]]
            SET_INT_LOCAL("fm_mission_controller_2020", 31049, 3) -- BitCheck
        end)

        menu.action(PERICO_ADV, TRANSLATE("Increase Team Lives"), {"hccpincteamlives"}, TRANSLATE("Increases the amount of team lives. Make sure to have script host if it doesn't seem to work."), function()
            menu.trigger_commands("scripthost")
            SET_INT_LOCAL("fm_mission_controller_2020", 58874 + 1109 + 1, 10000000) -- Thanks to @vithiam on Discord [[update]]
        end)

        menu.action(PERICO_ADV, TRANSLATE("Remove The Drainage Pipe"), {"hccprempipe"}, "(" .. TRANSLATE("Cayo Perico Heist") .. " > " .. TRANSLATE("Teleport Places") .. " > " .. TRANSLATE("Island") .. " > " .. TRANSLATE("Drainage Pipe") .. ")", function()
            local Object = util.joaat("prop_chem_grill_bit") -- Thanks for letting me know the object, @stand.gg on Discord
            DELETE_OBJECT_BY_HASH(Object)
        end)

        menu.action(PERICO_ADV, TRANSLATE("Refresh Kosatka Planning Table"), {"hccprefreshboard"}, TRANSLATE("You can update changed cayo perico heist stats in the Kosatka by refreshing it."), function()
            SET_INT_LOCAL("heist_island_planning", 1564, 2) -- https://github.com/atomikfr/CayoPericoHeistAssistant [[update]]
        end)
    
    ---

    menu.list_action(PERICO_HEIST, TRANSLATE("Heist Vehicles"), {"hccpveh"}, "", {
        { 1, TRANSLATE("Kosatka"), {"kosatka"}, TRANSLATE("(Submarine)") },
        { 2, TRANSLATE("Alkonost"), {"alkonost"}, TRANSLATE("(Plane)") },
        { 3, TRANSLATE("Velum"), {"velum"}, TRANSLATE("(Plane)") },
        { 4, TRANSLATE("Annihilator Stealth"), {"annihilator"}, TRANSLATE("(Helicopter)") },
        { 5, TRANSLATE("Kurtz 31 Patrol Boat"), {"patrol"}, TRANSLATE("(Boat)") },
        { 6, TRANSLATE("Longfin"), {"longfin"}, TRANSLATE("(Boat)") },
        { 7, TRANSLATE("Unlock All"), {"all"}, "" },
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
        { 1, TRANSLATE("Sapphire Panther"), {"panther"}, "" },
        { 2, TRANSLATE("Madrazo Files"), {"file"}, "" },
        { 3, TRANSLATE("Pink Diamond"), {"diamond"}, "" },
        { 4, TRANSLATE("Bearer Bonds"), {"bearer"}, "" },
        { 5, TRANSLATE("Ruby Necklace"), {"ruby"}, "" },
        { 6, TRANSLATE("Tequila"), {"tequila"}, "" },
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
        { 1, TRANSLATE("Mixed Loot"), {"mixed"}, "" },
        { 2, TRANSLATE("Cash"), {"cash"}, "" },
        { 3, TRANSLATE("Weed"), {"weed"}, "" },
        { 4, TRANSLATE("Coke"), {"coke"}, "" },
        { 5, TRANSLATE("Gold"), {"gold"}, "" },
        { 6, TRANSLATE("Remove All"), {"remall"}, "" },
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
        { 1, TRANSLATE("Mixed Loot"), {"mixed"}, "" },
        { 2, TRANSLATE("Cash"), {"cash"}, "" },
        { 3, TRANSLATE("Weed"), {"weed"}, "" },
        { 4, TRANSLATE("Coke"), {"coke"}, "" },
        { 5, TRANSLATE("Gold"), {"gold"}, "" },
        { 6, TRANSLATE("Paint"), {"paint"}, "" },
        { 7, TRANSLATE("Remove Paint (Only)"), {"rempaint"}, "" },
        { 8, TRANSLATE("Remove All"), {"remall"}, "" },
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
        { 1, TRANSLATE("Aggressor"), {"aggeressor"}, TRANSLATE("- Assault Shotgun + Machine Pistol") .. "\n" .. TRANSLATE("- Machete + Grenade") },
        { 2, TRANSLATE("Conspirator"), {"conspirator"}, TRANSLATE("- Military Rifle + Pistol .50") .. "\n" .. TRANSLATE("- Knuckle Duster + Sticky Bombs") },
        { 3, TRANSLATE("Crackshot"), {"crackshot"}, TRANSLATE("- Sniper Rifle + AP Pistol") .. "\n" .. TRANSLATE("- Knife + Molotov") },
        { 4, TRANSLATE("Saboteur"), {"saboteur"}, TRANSLATE("- SMG Mk2 + SNS Pistol Mk2") .. "\n" .. TRANSLATE("- Knife + Pipe Bomb") },
        { 5, TRANSLATE("Marksman"), {"marksman"}, TRANSLATE("- Assault Rifle Mk2 + Pistol Mk2") .. "\n" .. TRANSLATE("- Machete + Pipe Bomb") },
    }, function(index)
        STAT_SET_INT("H4CNF_WEAPONS", index)
        menu.trigger_commands("hccprefreshboard")
    end)

    menu.list_action(PERICO_HEIST, TRANSLATE("Equipment Spawn Location"), {"hccpequipment"}, "", { 
        { 1, TRANSLATE("Airport"), {"airport"}, TRANSLATE("- Guard Clothing") .. "\n" .. TRANSLATE("- Bolt Cutters") },
        { 2, TRANSLATE("Docks"), {"dock"}, TRANSLATE("- Guard Clothing") .. "\n" .. TRANSLATE("- Bolt Cutters") },
        { 3, TRANSLATE("Compound"), {"compound"}, TRANSLATE("- Guard Clothing") .. "\n" .. TRANSLATE("- Bolt Cutters") },
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
        { 1, TRANSLATE("Airport"), {"airport"}, "" },
        { 2, TRANSLATE("North Dock"), {"ndock"}, "" },
        { 3, TRANSLATE("Main Dock (East)"), {"edock"}, "" },
        { 4, TRANSLATE("Main Dock (West)"), {"wdock"}, "" },
        { 5, TRANSLATE("Compound"), {"compound"}, "" },
    }, function(index)
        STAT_SET_INT("H4CNF_TROJAN", index)
        menu.trigger_commands("hccprefreshboard")
    end)

    menu.list_action(PERICO_HEIST, TRANSLATE("Heist Difficulty"), {"hccpdifficulty"}, "", {
        { 1, TRANSLATE("Normal"), {"normal"}, "" },
        { 2, TRANSLATE("Hard"), {"hard"}, "" },
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
util.yield()

    CasinoPresetTunables = {
        memory.tunable_offset(1277889925),
        memory.tunable_offset(-582734553),
    }
    CASINO_PRESETS = menu.list(CASINO_HEIST, TRANSLATE("Automated Presets"), {}, TRANSLATE("Please don't forget that BUYER should be selected LOW! Otherwise, won't get money."), function(); end)

        CASINO_PRESETS_DIAMOND = menu.list(CASINO_PRESETS, TRANSLATE("Diamonds"), {}, TRANSLATE("If the Heist Planning (Board 3) is empty, then please re-enable the preset that you enabled!"), function(); end)

            DIAMOND_SS = menu.toggle(CASINO_PRESETS_DIAMOND, TRANSLATE("Silent & Sneaky Approach"), {"hccahdiasil"}, "", function()
                if menu.get_value(DIAMOND_SS) then
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
                    SET_INT_GLOBAL(262145 + CasinoPresetTunables[1], 1410065408)
                    for i = 1, #ForCasinoPresets do
                        menu.set_value(ForCasinoPresets[i][1], ForCasinoPresets[i][2])
                    end

                    util.yield_once()
                end
            end)

            DIAMOND_BA = menu.toggle(CASINO_PRESETS_DIAMOND, TRANSLATE("BigCon Approach"), {"hccahdiabig"}, "", function()
                if menu.get_value(DIAMOND_BA) then
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
                    SET_INT_GLOBAL(262145 + CasinoPresetTunables[1], 1410065408)
                    for i = 1, #ForCasinoPresets do
                        menu.set_value(ForCasinoPresets[i][1], ForCasinoPresets[i][2])
                    end

                    util.yield_once()
                end
            end)

            DIAMOND_AA = menu.toggle(CASINO_PRESETS_DIAMOND, TRANSLATE("Aggressive Approach"), {"hccahdiaagg"}, "", function()
                if menu.get_value(DIAMOND_AA) then
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
                    SET_INT_GLOBAL(262145 + CasinoPresetTunables[1], 1410065408)
                    for i = 1, #ForCasinoPresets do
                        menu.set_value(ForCasinoPresets[i][1], ForCasinoPresets[i][2])
                    end

                    util.yield_once()
                end
            end)

        ---

        CASINO_PRESETS_GOLD = menu.list(CASINO_PRESETS, TRANSLATE("Gold"), {}, TRANSLATE("If the Heist Planning (Board 3) is empty, then please re-enable the preset that you enabled!"), function(); end)

            GOLD_SS = menu.toggle(CASINO_PRESETS_GOLD, TRANSLATE("Silent & Sneaky Approach"), {"hccahgoldsil"}, "", function()
                if menu.get_value(GOLD_SS) then
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
                    SET_INT_GLOBAL(262145 + CasinoPresetTunables[2], 1410065408)
                    for i = 1, #ForCasinoPresets do
                        menu.set_value(ForCasinoPresets[i][1], ForCasinoPresets[i][2])
                    end

                    util.yield_once()
                end
            end)

            GOLD_BA = menu.toggle(CASINO_PRESETS_GOLD, TRANSLATE("BigCon Approach"), {"hccahgoldbig"}, "", function()
                if menu.get_value(GOLD_BA) then
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
                    SET_INT_GLOBAL(262145 + CasinoPresetTunables[2], 1410065408)
                    for i = 1, #ForCasinoPresets do
                        menu.set_value(ForCasinoPresets[i][1], ForCasinoPresets[i][2])
                    end

                    util.yield_once()
                end
            end)

            GOLD_AA = menu.toggle(CASINO_PRESETS_GOLD, TRANSLATE("Aggressive Approach"), {"hccahgoldagg"}, "", function()
                if menu.get_value(GOLD_AA) then
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
                    SET_INT_GLOBAL(262145 + CasinoPresetTunables[2], 1410065408)
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

                CAH_NON_HOST_CUT_LOOP = menu.toggle_loop(CAH_NON_HOST, TRANSLATE("Enable"), {"hccahnonhostloop"}, "", function()
                    SET_INT_GLOBAL(2685658 + 6651, menu.get_value(CAH_NON_HOST_CUT)) -- gb_casino_heist_planning.c [[update]]
                end, function()
                    SET_INT_GLOBAL(2685658 + 6651, menu.get_default_state(CAH_NON_HOST_CUT)) -- [[update]]
                end)

                CAH_NON_HOST_CUT = menu.slider(CAH_NON_HOST, TRANSLATE("Custom Percentage"), {"hccahnonhost"}, "(%)", 0, 1000, 100, 5, function(); end)

            ---

            CAH_HOST = menu.list(CAH_PLAYER_CUT, TRANSLATE("Your Cut"), {}, TRANSLATE("Only works if you are host of the heist."), function(); end)

                CAH_HOST_CUT_LOOP = menu.toggle_loop(CAH_HOST, TRANSLATE("Enable"), {"hccah1pcutloop"}, "", function()
                    SET_INT_GLOBAL(1965614 + 1497 + 736 + 92 + 1, menu.get_value(CAH_HOST_CUT)) -- gb_casino_heist_planning.c [[update]]
                end, function()
                    SET_INT_GLOBAL(1965614 + 1497 + 736 + 92 + 1, menu.get_default_state(CAH_HOST_CUT)) -- [[update]]
                end)

                CAH_HOST_CUT = menu.slider(CAH_HOST, TRANSLATE("Custom Percentage"), {"hccah1pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

            ---

            CAH_2P = menu.list(CAH_PLAYER_CUT, TRANSLATE("Player 2"), {}, TRANSLATE("Only works if you are host of the heist."), function(); end)

                CAH_2P_CUT_LOOP = menu.toggle_loop(CAH_2P, TRANSLATE("Enable"), {"hccah2pcutloop"}, "", function()
                    SET_INT_GLOBAL(1965614 + 1497 + 736 + 92 + 2, menu.get_value(CAH_2P_CUT)) -- gb_casino_heist_planning.c [[update]]
                end, function()
                    SET_INT_GLOBAL(1965614 + 1497 + 736 + 92 + 2, menu.get_default_state(CAH_2P_CUT)) -- [[update]]
                end)

                CAH_2P_CUT = menu.slider(CAH_2P, TRANSLATE("Custom Percentage"), {"hccah2pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

            ---

            CAH_3P = menu.list(CAH_PLAYER_CUT, TRANSLATE("Player 3"), {}, TRANSLATE("Only works if you are host of the heist."), function(); end)

                CAH_3P_CUT_LOOP = menu.toggle_loop(CAH_3P, TRANSLATE("Enable"), {"hccah3pcutloop"}, "", function()
                    SET_INT_GLOBAL(1965614 + 1497 + 736 + 92 + 3, menu.get_value(CAH_3P_CUT)) -- gb_casino_heist_planning.c [[update]]
                end, function()
                    SET_INT_GLOBAL(1965614 + 1497 + 736 + 92 + 3, menu.get_default_state(CAH_3P_CUT)) --[[update]]
                end)

                CAH_3P_CUT = menu.slider(CAH_3P, TRANSLATE("Custom Percentage"), {"hccah3pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

            ---

            CAH_4P = menu.list(CAH_PLAYER_CUT, TRANSLATE("Player 4"), {}, TRANSLATE("Only works if you are host of the heist."), function(); end)
                
                CAH_4P_CUT_LOOP = menu.toggle_loop(CAH_4P, TRANSLATE("Enable"), {"hccah4pcutloop"}, "", function()
                    SET_INT_GLOBAL(1965614 + 1497 + 736 + 92 + 4, menu.get_value(CAH_4P_CUT)) -- gb_casino_heist_planning.c [[update]]
                end, function()
                    SET_INT_GLOBAL(1965614 + 1497 + 736 + 92 + 4, menu.get_default_state(CAH_4P_CUT)) -- [[update]]
                end)

                CAH_4P_CUT = menu.slider(CAH_4P, TRANSLATE("Custom Percentage"), {"hccah4pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

            ---

        ---

        menu.toggle_loop(CAH_ADVCED, TRANSLATE("Skip The Hacking Process"), {}, TRANSLATE("Works On Both: Fingerprint and Keypad"), function()
            if GET_INT_LOCAL("fm_mission_controller", 53087) ~= 1 then -- For Fingerprint, https://www.unknowncheats.me/forum/3418914-post13398.html
                SET_INT_LOCAL("fm_mission_controller", 53087, 5) -- [[update]]
            end
            if GET_INT_LOCAL("fm_mission_controller", 54153) ~= 1 then -- For Keypad, https://www.unknowncheats.me/forum/3455828-post8.html
                SET_INT_LOCAL("fm_mission_controller", 54153, 5) -- [[update]]
            end
        end)

        menu.action(CAH_ADVCED, TRANSLATE("Allow You Play Alone"), {}, TRANSLATE("Allow you play alone this heist without another player.") .. "\n\n" .. TRANSLATE("Press this feature once before launching the heist."), function()
            -- [[update]]
            if GET_INT_LOCAL("fmmc_launcher", 19875 + 34) ~= nil then -- https://www.unknowncheats.me/forum/grand-theft-auto-v/463868-modest-menu-lua-scripting-megathread-239.html#google_vignette
                if GET_INT_LOCAL("fmmc_launcher", 19875 + 34) ~= 0 then
                    if GET_INT_LOCAL("fmmc_launcher", 19875 + 15) > 1 then
                        SET_INT_LOCAL("fmmc_launcher", 19875 + 15, 1)
                        SET_INT_GLOBAL(794744 + 4 + 1 + (GET_INT_LOCAL("fmmc_launcher", 19875 + 34) * 89) + 69, 1)
                    end
                    
                    SET_INT_GLOBAL(4718592 + 3526, 1)
                    SET_INT_GLOBAL(4718592 + 3527, 1)
                    SET_INT_GLOBAL(4718592 + 3529 + 1, 1)
                    SET_INT_GLOBAL(4718592 + 180865 + 1, 0)
                end
            end
        end)

        menu.action(CAH_ADVCED, TRANSLATE("Force Ready"), {"hccahforceready"}, TRANSLATE("Forces the players on board to ready."), function() 
            -- [[update]]
            SET_INT_GLOBAL(1969977 + 1 + (1 * 68) + 8 + 1, 1) -- Thanks to @vithiam on Discord
            SET_INT_GLOBAL(1969977 + 1 + (2 * 68) + 8 + 2, 1) 
            SET_INT_GLOBAL(1969977 + 1 + (3 * 68) + 8 + 3, 1)
        end)

        menu.action(CAH_ADVCED, TRANSLATE("Skip Drilling The Vault Door"), {"hccahinsvault"}, "", function() -- https://www.unknowncheats.me/forum/3418914-post13398.html
            SET_INT_LOCAL("fm_mission_controller", 10143 + 7, GET_INT_LOCAL("fm_mission_controller", 10143 + 37)) -- [[update]]
        end)

        menu.action(CAH_ADVCED, TRANSLATE("Increase Team Lives"), {"hccahincteamlives"}, TRANSLATE("Increases the amount of team lives. Make sure to have script host if it doesn't seem to work."), function()
            menu.trigger_commands("scripthost")
            SET_INT_LOCAL("fm_mission_controller", 19781 + 1765 + 1, 10000000) -- Thanks to @vithiam on Discord [[update]]
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
            { 1, TRANSLATE("Silent & Sneaky Approach"), {"silent"}, "" },
            { 2, TRANSLATE("BigCon Approach"), {"bigcon"}, "" },
            { 3, TRANSLATE("Aggressive Approach"), {"aggressive"}, "" },
        }, function(index)
            STAT_SET_INT("H3_LAST_APPROACH", 0)
            STAT_SET_INT("H3OPT_APPROACH", index)
            menu.trigger_commands("hccahrefreshboards")
        end)

        menu.list_action(CASINO_BOARD1, TRANSLATE("Change Difficulty"), {"hccahdifficulty"}, "", {
            { 1, TRANSLATE("Normal"), {"normal"}, "" },
            { 2, TRANSLATE("Hard"), {"hard"}, "" },
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
            { 1, TRANSLATE("Diamonds"), {"diamond"}, "" },
            { 2, TRANSLATE("Gold"), {"gold"}, "" },
            { 3, TRANSLATE("Artwork"), {"artwork"}, "" },
            { 4, TRANSLATE("Cash"), {"cash"}, "" },
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
            { 1, TRANSLATE("Chester McCoy"), {"chester"}, "(10% - " .. util.get_label_text("CH_SKILL_EXPR") .. ")" },
            { 2, TRANSLATE("Gustavo Mota"), {"gustavo"}, "(9% - " .. util.get_label_text("CH_SKILL_EXPR") .. ")" },
            { 3, TRANSLATE("Patrick McReary"), {"patrick"}, "(8% - " .. util.get_label_text("CH_SKILL_GOOD") .. ")" },
            { 4, TRANSLATE("Charlie Reed"), {"charlie"}, "(7% - " .. util.get_label_text("CH_SKILL_GOOD") .. ")" },
            { 5, TRANSLATE("Karl Abolaji"), {"karl"}, "(5% - " .. util.get_label_text("CH_SKILL_POOR") .. ")" },
            { 6, TRANSLATE("Random"), {"random"}, "(???%)" },
            { 7, TRANSLATE("Remove"), {"remove"}, "(0%)" },
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
            { 1, TRANSLATE("Best"), {"best"}, "" },
            { 2, TRANSLATE("Worst"), {"worst"}, "" },
        }, function(index)
            if index == 1 then
                STAT_SET_INT("H3OPT_WEAPS", 1)
            elseif index == 2 then
                STAT_SET_INT("H3OPT_WEAPS", 0)
            end

            menu.trigger_commands("hccahrefreshboards")
        end)

        menu.list_action(CASINO_BOARD2, TRANSLATE("Change Driver"), {"hccahdriver"}, "", {
            { 1, TRANSLATE("Chester McCoy"), {"chester"}, "(10% - " .. util.get_label_text("CH_SKILL_EXPR") .. ")" .. "\n\n" .. "- " .. util.get_label_text("CH_VEH_4_04B") .. "\n".. "- " .. util.get_label_text("CH_VEH_4_03B") .. "\n".. "- " .. util.get_label_text("CH_VEH_4_02B") .. "\n".. "- " .. util.get_label_text("CH_VEH_4_01B")  },
            { 2, TRANSLATE("Eddie Toh"), {"eddie"}, "(9% - " .. util.get_label_text("CH_SKILL_EXPR") .. ")" .. "\n\n" .. "- " .. util.get_label_text("CH_VEH_2_04B") .. "\n" .. "- " .. util.get_label_text("CH_VEH_2_03B") .. "\n" .. "- " .. util.get_label_text("CH_VEH_2_02B") .. "\n" .. "- " .. util.get_label_text("CH_VEH_2_01B") },
            { 3, TRANSLATE("Taliana Martinez"), {"taliana"}, "(7% - " .. util.get_label_text("CH_SKILL_GOOD") .. ")" .. "\n\n" .. "- " .. util.get_label_text("CH_VEH_1_04B") .. "\n" .. "- " .. util.get_label_text("CH_VEH_1_03B") .. "\n" .. "- " .. util.get_label_text("CH_VEH_1_02B") .. "\n" .. "- " .. util.get_label_text("CH_VEH_1_01B") },
            { 4, TRANSLATE("Zach Nelson"), {"zach"}, "(6% - " .. util.get_label_text("CH_SKILL_GOOD") .. ")" .. "\n\n" .. "- " .. util.get_label_text("CH_VEH_3_04B") .. "\n" .. "- " .. util.get_label_text("CH_VEH_3_03B") .. "\n" .. "- " .. util.get_label_text("CH_VEH_3_02B") .. "\n" .. "- " .. util.get_label_text("CH_VEH_3_01B") },
            { 5, TRANSLATE("Karim Denz"), {"karim"}, "(5% - " .. util.get_label_text("CH_SKILL_POOR") .. ")" .. "\n\n" .. "- " .. util.get_label_text("CH_VEH_0_04B") .. "\n" .. "- " .. util.get_label_text("CH_VEH_0_03B") .. "\n" .. "- " .. util.get_label_text("CH_VEH_0_02B") .. "\n" .. "- " .. util.get_label_text("CH_VEH_0_01B") },
            { 6, TRANSLATE("Random"), {"random"}, "(???%)" },
            { 7, TRANSLATE("Remove"), {"remove"}, "(0%)" },
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
            { 1, TRANSLATE("Best"), {"best"}, "- " .. TRANSLATE("Chester McCoy") .. ": " .. util.get_label_text("CH_VEH_4_04B") .. "\n" .. "- " .. TRANSLATE("Eddie Toh") .. ": " .. util.get_label_text("CH_VEH_2_04B") .. "\n" .. "- " .. TRANSLATE("Taliana Martinez") .. ": " .. util.get_label_text("CH_VEH_1_04B") .. "\n" .. "- " .. TRANSLATE("Taliana Martinez") .. ": " .. util.get_label_text("CH_VEH_3_04B") .. "\n" .. "- " .. TRANSLATE("Karim Denz") .. ": " .. util.get_label_text("CH_VEH_0_04B") },
            { 2, TRANSLATE("Good"), {"good"}, "- " .. TRANSLATE("Chester McCoy") .. ": " .. util.get_label_text("CH_VEH_4_03B") .. "\n" .. "- " .. TRANSLATE("Eddie Toh") .. ": " .. util.get_label_text("CH_VEH_2_03B") .. "\n" .. "- " .. TRANSLATE("Taliana Martinez") .. ": " .. util.get_label_text("CH_VEH_1_03B") .. "\n" .. "- " .. TRANSLATE("Taliana Martinez") .. ": " .. util.get_label_text("CH_VEH_3_03B") .. "\n" .. "- " .. TRANSLATE("Karim Denz") .. ": " .. util.get_label_text("CH_VEH_0_03B") },
            { 3, TRANSLATE("Fine"), {"fine"}, "- " .. TRANSLATE("Chester McCoy") .. ": " .. util.get_label_text("CH_VEH_4_02B") .. "\n" .. "- " .. TRANSLATE("Eddie Toh") .. ": " .. util.get_label_text("CH_VEH_2_02B") .. "\n" .. "- " .. TRANSLATE("Taliana Martinez") .. ": " .. util.get_label_text("CH_VEH_1_02B") .. "\n" .. "- " .. TRANSLATE("Taliana Martinez") .. ": " .. util.get_label_text("CH_VEH_3_02B") .. "\n" .. "- " .. TRANSLATE("Karim Denz") .. ": " .. util.get_label_text("CH_VEH_0_02B") },
            { 4, TRANSLATE("Worst"), {"worst"}, "- " .. TRANSLATE("Chester McCoy") .. ": " .. util.get_label_text("CH_VEH_4_01B") .. "\n" .. "- " .. TRANSLATE("Eddie Toh") .. ": " .. util.get_label_text("CH_VEH_2_01B") .. "\n" .. "- " .. TRANSLATE("Taliana Martinez") .. ": " .. util.get_label_text("CH_VEH_1_01B") .. "\n" .. "- " .. TRANSLATE("Taliana Martinez") .. ": " .. util.get_label_text("CH_VEH_3_01B") .. "\n" .. "- " .. TRANSLATE("Karim Denz") .. ": " .. util.get_label_text("CH_VEH_0_01B") },
            { 5, TRANSLATE("Random"), {"random"}, "" },
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
            { 1, TRANSLATE("Avi Schwartzman"), {"avi"}, "(10% - " .. util.get_label_text("CH_SKILL_EXPR") .. ")" .. "\n\n" .. "- " .. TRANSLATE("Undetected Time:") .. " 3:30" .. "\n" .. "- " .. TRANSLATE("Detected Time:") .. " 2:26" },
            { 2, TRANSLATE("Paige Harris"), {"paige"}, "(9% - " .. util.get_label_text("CH_SKILL_EXPR") .. ")" .. "\n\n" .. "- " .. TRANSLATE("Undetected Time:") .. " 3:25" .. "\n" .. "- " .. TRANSLATE("Detected Time:") .. " 2:23" },
            { 3, TRANSLATE("Christian Feltz"), {"christian"}, "(7% - " .. util.get_label_text("CH_SKILL_GOOD") .. ")" .. "\n\n" .. "- " .. TRANSLATE("Undetected Time:") .. " 2:59" .. "\n" .. "- " .. TRANSLATE("Detected Time:") .. " 2:05" },
            { 4, TRANSLATE("Yohan Blair"), {"yohan"}, "(5% - " .. util.get_label_text("CH_SKILL_GOOD") .. ")" .. "\n\n" .. "- " .. TRANSLATE("Undetected Time:") .. " 2:52" .. "\n" .. "- " .. TRANSLATE("Detected Time:") .. " 2:01" },
            { 5, TRANSLATE("Rickie Lukens"), {"rickie"}, "(3% - " .. util.get_label_text("CH_SKILL_POOR") .. ")" .. "\n\n" .. "- " .. TRANSLATE("Undetected Time:") .. " 2:26" .. "\n" .. "- " .. TRANSLATE("Detected Time:") .. " 1:42" },
            { 6, TRANSLATE("Random"), {"random"}, "(???%)" },
            { 7, TRANSLATE("Remove"), {"remove"}, "(0%)" },
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
            { 1, TRANSLATE("Remove Masks"), {"remove"}, "" },
            { 2, TRANSLATE("Geometric Set"), {"geometric"}, "" },
            { 3, TRANSLATE("Hunter Set"), {"hunter"}, "" },
            { 4, TRANSLATE("Oni Half Mask Set"), {"onihalf"}, "" },
            { 5, TRANSLATE("Emoji Set"), {"emoji"}, "" },
            { 6, TRANSLATE("Ornate Skull Set"), {"ornate"}, "" },
            { 7, TRANSLATE("Lucky Fruit Set"), {"lucky"}, "" },
            { 8, TRANSLATE("Guerilla Set"), {"guerilla"}, "" },
            { 9, TRANSLATE("Clown Set"), {"clown"}, "" },
            { 10, TRANSLATE("Animal Set"), {"animal"}, "" },
            { 11, TRANSLATE("Riot Set"), {"riot"}, "" },
            { 12, TRANSLATE("Oni Set"), {"oni"}, "" },
            { 13, TRANSLATE("Hockey Set"), {"hockey"}, "" },
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

        menu.list_action(CASINO_BOARD3, TRANSLATE("Entrance"), {"hccahentrance"}, TRANSLATE("Don't forget changing this feature before starting the heist! Otherwise, won't be applied."), {
            { 1, TRANSLATE("Main Door"), {"maindoor"}, "" },
            { 2, TRANSLATE("Staff Lobby"), {"stafflobby"}, "" },
            { 3, TRANSLATE("Waste Disposal"), {"wastedisposal"}, "" },
            { 4, TRANSLATE("S.W Roof Terrace"), {"swroofterrace"}, "" },
            { 5, TRANSLATE("N.W Roof Terrace"), {"nwroofterrace"}, "" },
            { 6, TRANSLATE("S.E Roof Terrace"), {"seroofterrace"}, "" },
            { 7, TRANSLATE("N.E Roof Terrace"), {"neroofterrace"}, "" },
            { 8, TRANSLATE("South Helipad"), {"southhelipad"}, "" },
            { 9, TRANSLATE("North Helipad"), {"northhelipad"}, "" },
            { 10, TRANSLATE("Security Tunnel"), {"securitytunnel"}, "" },
            { 11, TRANSLATE("Sewers"), {"sewers"}, "" },
        }, function(index)
            util.create_tick_handler(function()
                if not util.is_session_started() then return end
                SET_INT_GLOBAL(1965614 + 1497 + 1017, index - 1) -- https://www.unknowncheats.me/forum/3666316-post96.html [[update]]
            end)
            menu.trigger_commands("hccahrefreshboards")
        end)

        menu.list_action(CASINO_BOARD3, TRANSLATE("Exit"), {"hccahexit"}, TRANSLATE("Don't forget changing this feature before starting the heist! Otherwise, won't be applied."), {
            { 1, TRANSLATE("Main Door"), {"maindoor"}, "" },
            { 2, TRANSLATE("Staff Lobby"), {"stafflobby"}, "" },
            { 3, TRANSLATE("Waste Disposal"), {"wastedisposal"}, "" },
            { 4, TRANSLATE("S.W Roof Terrace"), {"swroofterrace"}, "" },
            { 5, TRANSLATE("N.W Roof Terrace"), {"nwroofterrace"}, "" },
            { 6, TRANSLATE("S.E Roof Terrace"), {"seroofterrace"}, "" },
            { 7, TRANSLATE("N.E Roof Terrace"), {"neroofterrace"}, "" },
            { 8, TRANSLATE("South Helipad"), {"southhelipad"}, "" },
            { 9, TRANSLATE("North Helipad"), {"northhelipad"}, "" },
            { 10, TRANSLATE("Security Tunnel"), {"securitytunnel"}, "" },
            { 11, TRANSLATE("Sewers"), {"sewers"}, "" },
        }, function(index)
            util.create_tick_handler(function()
                if not util.is_session_started() then return end
                SET_INT_GLOBAL(1965614 + 1497 + 1018, index - 1) -- https://www.unknowncheats.me/forum/3666316-post96.html [[update]]
            end)
            menu.trigger_commands("hccahrefreshboards")
        end)

        menu.list_action(CASINO_BOARD3, TRANSLATE("Buyer Level"), {"hccahbuyer"}, TRANSLATE("Don't forget changing this feature before starting the heist! Otherwise, won't be applied."), {
            { 1, TRANSLATE("Low"), {"low"}, "" },
            { 2, TRANSLATE("Mid"), {"mid"}, "" },
            { 3, TRANSLATE("High"), {"high"}, "" },
        }, function(index)
            util.create_tick_handler(function()
                if not util.is_session_started() then return end
                SET_INT_GLOBAL(1965614 + 1497 + 1019, (index * 3) - 3) -- https://www.unknowncheats.me/forum/3666316-post96.html [[update]]
            end)
            menu.trigger_commands("hccahrefreshboards")
        end)

        menu.list_action(CASINO_BOARD3, TRANSLATE("Entry Disguise"), {"hccahentrydisguise"}, "(" .. TRANSLATE("BigCon Approach") .. ")" .. "\n\n" .. TRANSLATE("Don't forget changing this feature before starting the heist! Otherwise, won't be applied."), {
            { 1, TRANSLATE("Bugstars"), {"bugstars"}, "" },
            { 2, TRANSLATE("LS Water & Power"), {"lswaternpower"}, "" },
            { 3, TRANSLATE("Gruppe Sechs"), {"gruppesechs"}, "" },
            { 4, TRANSLATE("Yung Ancestor"), {"yungancestor"}, "" },
        }, function(index)
            util.create_tick_handler(function()
                if not util.is_session_started() then return end
                SET_INT_GLOBAL(1965614 + 1497 + 1020, index) -- [[update]]
            end)
            menu.trigger_commands("hccahrefreshboards")
        end)

        menu.list_action(CASINO_BOARD3, TRANSLATE("Exit Disguise"), {"hccahexitdisguise"}, "(" .. TRANSLATE("BigCon Approach") .. ")" .. "\n\n" .. TRANSLATE("Don't forget changing this feature before starting the heist! Otherwise, won't be applied."), {
            { 1, TRANSLATE("Noose"), {"noose"}, "" },
            { 2, TRANSLATE("Firefighters"), {"firefighters"}, "" },
            { 3, TRANSLATE("High Rollers"), {"highrollers"}, "" },
        }, function(index)
            util.create_tick_handler(function()
                if not util.is_session_started() then return end
                SET_INT_GLOBAL(1965614 + 1497 + 1021, index + 5) -- [[update]]
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

    CASINO_MORE = menu.list(CASINO_HEIST, TRANSLATE("Others"), {}, "", function(); end)

        menu.action(CASINO_MORE, TRANSLATE("Load All Boards"), {"hccahloadallboards"}, "", function()
            STAT_SET_INT("H3OPT_BITSET1", -1)
            STAT_SET_INT("H3OPT_BITSET0", -1)
            STAT_SET_INT("H3OPT_ACCESSPOINTS", 2047)
            STAT_SET_INT("H3OPT_POI", 1023)
        end)

        menu.action(CASINO_MORE, TRANSLATE("Unload All Boards"), {"hccahunloadallboards"}, "", function()
            STAT_SET_INT("H3OPT_BITSET1", 0)
            STAT_SET_INT("H3OPT_BITSET0", 0)
            STAT_SET_INT("H3OPT_ACCESSPOINTS", 0)
            STAT_SET_INT("H3OPT_POI", 0)
        end)

        menu.action(CASINO_MORE, TRANSLATE("Remove Repeat Cooldown"), {"hccahremovecooldown"}, TRANSLATE("You should not in your arcade to use this feature.") .. "\n\n" .. TRANSLATE("Meaning of the cooldown: Requesting new Diamond Casino Heist in calling to Lester"), function()
            if not IS_IN_ARCADE() then
                STAT_SET_INT("H3_COMPLETEDPOSIX", -1)
                STAT_SET_INT("MPPLY_H3_COOLDOWN", -1)
            else
                NOTIFY(TRANSLATE("You should not in your arcade to use this feature."))
            end
        end)

        menu.action(CASINO_MORE, TRANSLATE("Set Heist to Default (Reset)"), {"hccahreset"}, "", function()
            STAT_SET_INT("H3OPT_DISRUPTSHIP", 0)
            STAT_SET_INT("H3OPT_BODYARMORLVL", 0)
            STAT_SET_INT("H3OPT_CREWWEAP", 0)
            STAT_SET_INT("H3OPT_CREWDRIVER", 0)
            STAT_SET_INT("H3OPT_CREWHACKER", 0)
            STAT_SET_INT("H3OPT_KEYLEVELS", 0)
            STAT_SET_INT("H3OPT_MODVEH", 0)
            STAT_SET_INT("H3OPT_MASKS", 0)
            STAT_SET_INT("H3OPT_WEAPS", 0)
            STAT_SET_INT("H3OPT_VEHS", 0)
            STAT_SET_INT("H3OPT_APPROACH", 0)
            STAT_SET_INT("H3OPT_BITSET0", 0)
            STAT_SET_INT("H3OPT_ACCESSPOINTS", 0)
            STAT_SET_INT("H3OPT_TARGET", 0)
            STAT_SET_INT("H3OPT_POI", 0)
            STAT_SET_INT("H3OPT_BITSET1", 0)
            STAT_SET_INT("H3_PARTIALPASS", 0)
            STAT_SET_INT("CAS_HEIST_NOTS", 0)
            STAT_SET_INT("CAS_HEIST_FLOW", 0)
            STAT_SET_INT("H3_LAST_APPROACH", 0)
            STAT_SET_INT("H3_HARD_APPROACH", 0)
            STAT_SET_INT("H3_SKIPCOUNT", 0)
            STAT_SET_INT("H3_MISSIONSKIPPED", 0)
            STAT_SET_INT("H3_BOARD_DIALOGUE0", 0)
            STAT_SET_INT("H3_BOARD_DIALOGUE1", 0)
            STAT_SET_INT("H3_BOARD_DIALOGUE2", 0)
            STAT_SET_INT("H3_VEHICLESUSED", 0)
            STAT_SET_INT("MPPLY_H3_COOLDOWN", 0)
            STAT_SET_INT("H3_COMPLETEDPOSIX", 0)

            menu.trigger_commands("hccahrefreshboards")
        end)

    ---

---


--- Doomsday Heist
util.yield()

    DOOMS_PRESETS = menu.list(DOOMS_HEIST, TRANSLATE("Automated Presets"), {"hcdoomspreset"}, TRANSLATE("You should enable the preset until the end of the heist!") .. "\n\n" .. TRANSLATE("Enabling one of these presets will complete all of setups, and set as max payout, $2.55 Millions. It will be affected to all of heist players."), function(); end)

        DOOMS_PRESETS_ACT1 = menu.toggle(DOOMS_PRESETS, TRANSLATE("ACT I - The Data Breaches"), {"hcdoomsact1"}, TRANSLATE("Note that there is a payout visual bug on the heist screen."), function()
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

        DOOMS_PRESETS_ACT2 = menu.toggle(DOOMS_PRESETS, TRANSLATE("ACT II - The Bogdan Problem"), {"hcdoomsact2"}, TRANSLATE("Note that there is a payout visual bug on the heist screen."), function()
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

        DOOMS_PRESETS_ACT3 = menu.toggle(DOOMS_PRESETS, TRANSLATE("ACT III - The Doomsday Scenario"), {"hcdoomsact3"}, TRANSLATE("Note that there is a payout visual bug on the heist screen."), function()
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

            DOOMS_NON_HOST_CUT_LOOP = menu.toggle_loop(DOOMS_NON_HOST, TRANSLATE("Enable"), {"hcdoomsnonhostloop"}, "", function()
                SET_INT_GLOBAL(2685658 + 6651, menu.get_value(DOOMS_NON_HOST_CUT)) -- gb_gang_ops_planning.c [[update]]
            end, function()
                SET_INT_GLOBAL(2685658 + 6651, menu.get_default_state(DOOMS_NON_HOST_CUT)) -- [[update]]
            end)

            DOOMS_NON_HOST_CUT = menu.slider(DOOMS_NON_HOST, TRANSLATE("Custom Percentage"), {"hcdoomsnonhost"}, "(%)", 0, 1000, 100, 5, function(); end)

        ---

        DOOMS_HOST = menu.list(DOOMS_PLAYER_CUT, TRANSLATE("Your Cut"), {}, TRANSLATE("Only works if you are host of the heist."), function(); end)

            DOOMS_HOST_CUT_LOOP = menu.toggle_loop(DOOMS_HOST, TRANSLATE("Enable"), {"hcdooms1ploop"}, "", function()
                SET_INT_GLOBAL(1961513 + 812 + 50 + 1, menu.get_value(DOOMS_HOST_CUT)) -- gb_gang_ops_planning.c [[update]]
            end, function()
                SET_INT_GLOBAL(1961513 + 812 + 50 + 1, menu.get_default_state(DOOMS_HOST_CUT)) -- [[update]]
            end)

            DOOMS_HOST_CUT = menu.slider(DOOMS_HOST, TRANSLATE("Custom Percentage"), {"hcdooms1pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

        ---

        DOOMS_2P = menu.list(DOOMS_PLAYER_CUT, TRANSLATE("Player 2"), {}, TRANSLATE("Only works if you are host of the heist."), function(); end)
            
            DOOMS_2P_CUT_LOOP = menu.toggle_loop(DOOMS_2P, TRANSLATE("Enable"), {"hcdooms2pcutloop"}, "", function()
                SET_INT_GLOBAL(1961513 + 812 + 50 + 2, menu.get_value(DOOMS_2P_CUT)) -- gb_gang_ops_planning.c [[update]]
            end, function()
                SET_INT_GLOBAL(1961513 + 812 + 50 + 2, menu.get_default_state(DOOMS_2P_CUT)) -- [[update]]
            end)

            DOOMS_2P_CUT = menu.slider(DOOMS_2P, TRANSLATE("Custom Percentage"), {"hcdooms2pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

        ---

        DOOMS_3P = menu.list(DOOMS_PLAYER_CUT, TRANSLATE("Player 3"), {}, TRANSLATE("Only works if you are host of the heist."), function(); end)

            DOOMS_3P_CUT_LOOP = menu.toggle_loop(DOOMS_3P, TRANSLATE("Enable"), {"hcdooms3pcutloop"}, "", function()
                SET_INT_GLOBAL(1961513 + 812 + 50 + 3, menu.get_value(DOOMS_3P_CUT)) -- gb_gang_ops_planning.c [[update]]
            end, function()
                SET_INT_GLOBAL(1961513 + 812 + 50 + 3, menu.get_default_state(DOOMS_3P_CUT)) -- [[update]]
            end)

            DOOMS_3P_CUT = menu.slider(DOOMS_3P, TRANSLATE("Custom Percentage"), {"hcdooms3pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

        ---

        DOOMS_4P = menu.list(DOOMS_PLAYER_CUT, TRANSLATE("Player 4"), {}, TRANSLATE("Only works if you are host of the heist."), function(); end)

            DOOMS_4P_CUT_LOOP = menu.toggle_loop(DOOMS_4P, TRANSLATE("Enable"), {"hcdooms4pcutloop"}, "", function()
                SET_INT_GLOBAL(1961513 + 812 + 50 + 4, menu.get_value(DOOMS_4P_CUT)) -- gb_gang_ops_planning.c [[update]]
            end, function()
                SET_INT_GLOBAL(1961513 + 812 + 50 + 4, menu.get_default_state(DOOMS_4P_CUT)) -- [[update]]
            end)

            DOOMS_4P_CUT = menu.slider(DOOMS_4P, TRANSLATE("Custom Percentage"), {"hcdooms4pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

        ---

        DoomsBypassMinMaxTunables = {
            memory.tunable_offset(-2020782937),
            memory.tunable_offset(944111042),
        }
        menu.toggle_loop(DOOMS_PLAYER_CUT, TRANSLATE("Bypass Minimum And Maximum Percentage"), {}, TRANSLATE("Only works if you are host of the heist.") .. "\n\n" .. TRANSLATE("It allows you set 0 ~ 100(%) by modifying the heist board, ignores all of restrictions modifying cuts."), function()
            SET_INT_GLOBAL(262145 + DoomsBypassMinMaxTunables[1], 0) -- https://www.unknowncheats.me/forum/3732338-post132.html
            SET_INT_GLOBAL(262145 + DoomsBypassMinMaxTunables[2], 100)
        end, function()
            SET_INT_GLOBAL(262145 + DoomsBypassMinMaxTunables[1], 15)
            SET_INT_GLOBAL(262145 + DoomsBypassMinMaxTunables[2], 85)
        end)

    ---

    menu.toggle_loop(DOOMS_HEIST, TRANSLATE("Skip The Hacking Process"), {}, "(" .. TRANSLATE("The Data Breaches ACT I") .. " - " .. TRANSLATE("Setup: Server Farm (Lester)") .. " & " .. TRANSLATE("The Doomsday Scenario ACT III") .. ")", function()
        SET_INT_LOCAL("fm_mission_controller", 1536, 3) -- For ACT I, Setup: Server Farm (Lester), https://www.unknowncheats.me/forum/3687245-post112.html [[update]]
        SET_INT_LOCAL("fm_mission_controller", 1567, 2) -- [[update]]
        SET_INT_LOCAL("fm_mission_controller", 1292 + 135, 3) -- For ACT III, https://www.unknowncheats.me/forum/3455828-post8.html [[update]]
    end)

    menu.action(DOOMS_HEIST, TRANSLATE("Allow You Play Alone"), {}, TRANSLATE("Allow you play alone this heist without another player.") .. "\n\n" .. TRANSLATE("Press this feature once before launching the heist."), function()
        -- [[update]]
        if GET_INT_LOCAL("fmmc_launcher", 19875 + 34) ~= nil then -- https://www.unknowncheats.me/forum/grand-theft-auto-v/463868-modest-menu-lua-scripting-megathread-239.html#google_vignette
            if GET_INT_LOCAL("fmmc_launcher", 19875 + 34) ~= 0 then
                if GET_INT_LOCAL("fmmc_launcher", 19875 + 15) > 1 then
                    SET_INT_LOCAL("fmmc_launcher", 19875 + 15, 1)
                    SET_INT_GLOBAL(794744 + 4 + 1 + (GET_INT_LOCAL("fmmc_launcher", 19875 + 34) * 89) + 69, 1)
                end
                
                SET_INT_GLOBAL(4718592 + 3526, 1)
                SET_INT_GLOBAL(4718592 + 3527, 1)
                SET_INT_GLOBAL(4718592 + 3529 + 1, 1)
                SET_INT_GLOBAL(4718592 + 180865 + 1, 0)
            end
        end
    end)

    menu.action(DOOMS_HEIST, TRANSLATE("Force Ready"), {"hcdoomsforceready"}, TRANSLATE("Forces the players on board to ready."), function() 
        -- [[update]]
        SET_INT_GLOBAL(1882780 + 1 + (1 * 149) + 43 + 1 + 4 + 8, 1) -- Thanks to @vithiam on Discord
        SET_INT_GLOBAL(1882780 + 1 + (2 * 149) + 43 + 2 + 4 + 8, 1)
        SET_INT_GLOBAL(1882780 + 1 + (3 * 149) + 43 + 3 + 4 + 8, 1)
    end)

    menu.action(DOOMS_HEIST, TRANSLATE("Increase Team Lives"), {"hcdoomsincteamlives"}, TRANSLATE("Increases the amount of team lives. Make sure to have script host if it doesn't seem to work."), function()
        menu.trigger_commands("scripthost")
        SET_INT_LOCAL("fm_mission_controller", 19781 + 1765 + 1, 10000000) -- Thanks to @vithiam on Discord [[update]]
    end)

    menu.action(DOOMS_HEIST, TRANSLATE("Refresh Heist Screen On Facility"), {"hcdoomsrefreshscreen"}, TRANSLATE("You can update changed doomsday heist stats in the Facility by refreshing it."), function()
        SET_INT_LOCAL("gb_gang_ops_planning", 205, 6) -- https://www.unknowncheats.me/forum/3682032-post104.html [[update]]
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
util.yield()

    CLASSIC_PRESETS = menu.list(CLASSIC_HEISTS, TRANSLATE("Automated Presets"), {}, TRANSLATE("Compatible with any classic heist and any difficulty level.") .. "\n\n" .. TRANSLATE("Note that you should use this feature when you're on the planning board after watching or skipping the cutscene. It only works if you are host of the heist."), function(); end)

        menu.textslider_stateful(CLASSIC_PRESETS, TRANSLATE("Automated Presets"), {"hcclassicpreset"}, TRANSLATE("- Option 1: Each player will receive $15.000.000") .. "\n" .. TRANSLATE("- Option 2: Only other players will receive $15.000.000"), { -- Big thanks to @negotium.rpm on Discord
            TRANSLATE("Option 1"),
            TRANSLATE("Option 2"),
        }, function(index)
            local MouseSupport = menu.get_value(menu.ref_by_path("Stand>Settings>Input>Mouse Support>Mouse Support"))
            menu.ref_by_path("Game>Disables>Disable Game Inputs>Presets>Numpad"):trigger()
            menu.ref_by_path("Stand>Settings>Input>Mouse Support>Mouse Support").value = false
            util.yield(250)

            local Difficulty = GET_INT_GLOBAL(4718592 + 3525) -- [[update]]
            local HeistID = STAT_GET_STRING("HEIST_MISSION_RCONT_ID_1")
            local HeistData = {
                ["hK5OgJk1BkinXGGXghhTMg"] = {{-29712, 14906}, {-14806, 7453}, {-11824, 5962}}, -- Fleeca Job
                ["7-w96-PU4kSevhtG5YwUHQ"] = {{-17040, 4285, 4285, 4285}, {-8468, 2142, 2142, 2142}, {-6756, 1714, 1714, 1714}}, -- Prison Break
                ["BWsCWtmnvEWXBrprK9hDHA"] = {{-12596, 3174, 3174, 3174}, {-6248, 1587, 1587, 1587}, {-4976, 1269, 1269, 1269}}, -- Humane Labs Raid
                ["20Lu41Px20OJMPdZ6wXG3g"] = {{-16872, 4243, 4243, 4243}, {-8384, 2121, 2121, 2121}, {-6688, 1697, 1697, 1697}}, -- Series A Funding
                ["zCxFg29teE2ReKGnr0L4Bg"] = {{-7900, 2000, 2000, 2000}, {-3900, 1000, 1000, 1000}, {-3100, 800, 800, 800}} -- Pacific Standard Job
            }

            local SetCuts = HeistData[HeistID]
            if SetCuts then
                local PlayerCut = SetCuts[Difficulty + 1]
                if PlayerCut then
                    for i = 1, 4 do
                        SET_INT_GLOBAL(1929317 + 1 + i, PlayerCut[i] or 0) -- [[update]]
                    end
                end
            end

            PAD.SET_CURSOR_POSITION(0.775, 0.175) -- Moves Cursor
            PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 237, 1) -- Presses Left Mouse Button
            PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 202, 1) -- Presses ESC
            util.yield(500)

            if index == 1 then
                SET_INT_GLOBAL(1931285 + 3008 + 1, GET_INT_GLOBAL(1929317 + 1 + 2)) -- [[update]]
            elseif index == 2 then
                SET_INT_GLOBAL(1931285 + 3008 + 1, 0) -- [[update]]
            end
            PAD.SET_CURSOR_POSITION(0.5, 0.5)

            if MouseSupport then
                menu.ref_by_path("Game>Disables>Disable Game Inputs>Presets>Mouse"):trigger()
                menu.ref_by_path("Stand>Settings>Input>Mouse Support>Mouse Support").value = true
            end
        end)

    ---

    menu.toggle_loop(CLASSIC_HEISTS, TRANSLATE("Remove The Cooldown"), {}, TRANSLATE("This doesn't bypass server-sided cooldown time, 20 mins. This just bypasses unable to launch heist in heist board."), function()
        SET_INT_GLOBAL(1877417 + 1 + (PLAYER.PLAYER_ID() * 77) + 76, -1) -- Thanks to @vithiam on Discord [[update]]
    end)

    menu.toggle_loop(CLASSIC_HEISTS, TRANSLATE("Skip The Hacking Process"), {}, "(" .. TRANSLATE("Fleeca Heist") .. " & " .. TRANSLATE("Pacific Standard Heist") .. ")", function()
        SET_INT_LOCAL("fm_mission_controller", 11812 + 24, 7) -- Fleeca Heist, https://www.unknowncheats.me/forum/3455828-post8.html [[update]]
        SET_LOCAL_BIT("fm_mission_controller", 9809, 9) -- Pacific Standard Heist, https://www.unknowncheats.me/forum/3694259-post117.html [[update]]
    end)

    menu.toggle_loop(CLASSIC_HEISTS, TRANSLATE("Skip Drilling"), {}, "(" .. TRANSLATE("Fleeca Heist") .. ")", function()
        SET_FLOAT_LOCAL("fm_mission_controller", 10103 + 11, 100) -- https://www.unknowncheats.me/forum/3485435-post19.html [[update]]
    end)

    menu.toggle_loop(CLASSIC_HEISTS, TRANSLATE("Force Challenges Bonus"), {}, TRANSLATE("Allows you to gain an additional 12 millions for completing the Pacific Standard Job finale on hard difficulty. Note that it will only affect you, even if you are not the host. Enable before starting the heist and keep it enabled until it ends."), function() -- Big thanks to @negotium.rpm on Discord
        -- Force All In Order
        STAT_SET_INT("MPPLY_HEISTFLOWORDERPROGRESS", 134217727)
        STAT_SET_BOOL("MPPLY_AWD_HST_ORDER", false)
        -- Force Loyalty
        STAT_SET_INT("MPPLY_HEISTTEAMPROGRESSBITSET", 134217727)
        STAT_SET_BOOL("MPPLY_AWD_HST_SAME_TEAM", false)
        -- Force Criminal Mastermind
        STAT_SET_INT("MPPLY_HEISTNODEATHPROGREITSET", 134217727)
        STAT_SET_BOOL("MPPLY_AWD_HST_ULT_CHAL", false)
    end, function()
        -- Complete All In Order
        STAT_SET_INT("MPPLY_HEISTFLOWORDERPROGRESS", 268435455)
        STAT_SET_BOOL("MPPLY_AWD_HST_ORDER", true)
        -- Complete Loyalty
        STAT_SET_INT("MPPLY_HEISTTEAMPROGRESSBITSET", 268435455)
        STAT_SET_BOOL("MPPLY_AWD_HST_SAME_TEAM", true)
        -- Complete Criminal Mastermind
        STAT_SET_INT("MPPLY_HEISTNODEATHPROGREITSET", 268435455)
        STAT_SET_BOOL("MPPLY_AWD_HST_ULT_CHAL", true)
    end)

    FleecaBypassMinMaxTunables = {
        memory.tunable_offset("MAX_HEIST_CUT_AMOUNT"),
        memory.tunable_offset("MEMBER_MIN_HEIST_FINALE_TAKE_PERCENTAGE"),
        memory.tunable_offset("LEADER_MIN_HEIST_FINALE_TAKE_PERCENTAGE"),
    }
    menu.toggle_loop(CLASSIC_HEISTS, TRANSLATE("Bypass Minimum And Maximum Percentage"), {}, TRANSLATE("Only works if you are host of the heist.") .. "\n\n" .. TRANSLATE("It allows you set 0 ~ 100(%) by modifying the heist board, ignores all of restrictions modifying cuts."), function()
        SET_INT_GLOBAL(262145 + FleecaBypassMinMaxTunables[1], 100) -- https://www.unknowncheats.me/forum/3664875-post95.html
        SET_INT_GLOBAL(262145 + FleecaBypassMinMaxTunables[2], 0)
        SET_INT_GLOBAL(262145 + FleecaBypassMinMaxTunables[3], 0)
    end, function()
        SET_INT_GLOBAL(262145 + FleecaBypassMinMaxTunables[1], 70)
        SET_INT_GLOBAL(262145 + FleecaBypassMinMaxTunables[2], 15)
        SET_INT_GLOBAL(262145 + FleecaBypassMinMaxTunables[3], 15)
    end)

    menu.textslider_stateful(CLASSIC_HEISTS, TRANSLATE("Complete All Setups"), {}, TRANSLATE("Allows you to complete all setups for the selected heist. Note that you have to be in your apartment for the feature to work properly. After using, you will automatically be returned to Story Mode to apply the changes."), {
        TRANSLATE("Fleeca Job"), 
        TRANSLATE("Prison Break"), 
        TRANSLATE("Humane Labs Raid"), 
        TRANSLATE("Series A Funding"), 
        TRANSLATE("Pacific Standard Job"),
    }, function(index)
        local ApartmentID = GET_INT_GLOBAL(1845221 + 1 + (players.user() * 889) + 268 + 36) -- Information > Status > Apartment ID [[update]]
        if ApartmentID == -1 or ApartmentID >= 24 and ApartmentID <= 33 or ApartmentID >= 44 and ApartmentID <= 60 then
            NOTIFY(TRANSLATE("It seems that you are currently not in any apartment."))
        elseif ApartmentID >= 8 and ApartmentID <= 23 or ApartmentID >= 66 and ApartmentID <= 72 then
            NOTIFY(TRANSLATE("The heist planning board couldn't be found in this apartment. Make sure you are in one of the high-end apartments."))
        else
            menu.trigger_commands("hcclassicunlockall")
            util.yield(100)
    
            local DepthLV = {{-1, 0, 1}, {-1, 0, 0, 0, 1}, {-1, 0, 0, 1, 2, 2}, {-1, 0, 0, 0, 1, 2}, {-1, 0, 1, 2, 2, 2}}
            local ProgressHash = {-836352461, 137052480, 496643418, 1585746186, 911181645}
            local RewardCosmetic = {25, 22, 23, 24, 21}
            local RcontID = {
                {-1072870761, "hK5OgJk1BkinXGGXghhTMg", "V7yEdnL6TEyU3i-U1Rv_pQ"}, -- Fleeca Job
                {979654579, "7-w96-PU4kSevhtG5YwUHQ", "oSXhVwaHH0KDOzg0rfIj3Q", "QS6WYcjJFk2YxqYDMN8mjQ", "JJ9OzPbPo02eQbaniO8E3g"}, -- Prison Break
                {-1096986654, "BWsCWtmnvEWXBrprK9hDHA", "6k6LOpnf2E-GG38OhjS-TA", "nSWwSwAf3EaHZWsk449lBg", "ciWN4gwmakid4lW-nSllcA", "v-8OOQYzxE-Zvqj5xO03DQ"}, -- Humane Labs Raid
                {164435858, "20Lu41Px20OJMPdZ6wXG3g", "6UzZkstFeEeCkvs2lrF_6A", "PPnsIR0v2U2COyRbED87gw", "z49DSS9db0i_vh6A2e-Q-g", "Fo168mMjCUCeN_IKmL4VnA"}, -- Series A Funding
                {-231973569, "zCxFg29teE2ReKGnr0L4Bg", "6ClY8ZA_DkuBUdZ_fPn6Rw", "OiSO3Z0YdkCaEqVHhhkj4Q", "Cy2OZSwCt0-mSXY00o4SNw", "Y4zpRQDfvkawfFDR1Uxi2A"} -- Pacific Standard Job
            }
    
            STAT_SET_INT("HEIST_PLANNING_STAGE", -1)
            STAT_SET_INT("BITSET_HEIST_VS_MISSIONS", -17809409)
            STAT_SET_INT("HEIST_SESSION_ID_MACADDR", 183381814)
            STAT_SET_INT("HEIST_LEADER_APART_ID", ApartmentID)
            STAT_SET_INT("MPPLY_HEIST_PROGRESS_HASH", ProgressHash[index])
            STAT_SET_INT("HEIST_TOTAL_REWARD_COSMETIC", RewardCosmetic[index])
    
            for i = 0, 7 do
                if i == 0 then
                    STAT_SET_INT("HEIST_MISSION_RCONT_ID_" .. i, RcontID[index][i + 1])
                else
                    STAT_SET_STRING("HEIST_MISSION_RCONT_ID_" .. i, RcontID[index][i + 1] or "")
                end
                STAT_SET_INT("HEIST_MISSION_DEPTH_LV_" .. i, DepthLV[index][i + 1] or -1)
            end
    
            FORCE_CLOUD_SAVE()
            menu.trigger_commands("quittosp")
        end
    end)

    menu.action(CLASSIC_HEISTS, TRANSLATE("Allow You Play Alone"), {}, TRANSLATE("Allow you play alone this heist without another player.") .. "\n\n" .. TRANSLATE("Press this feature once before launching the heist."), function()
        if GET_INT_LOCAL("fmmc_launcher", 19875 + 34) ~= nil then -- https://www.unknowncheats.me/forum/grand-theft-auto-v/463868-modest-menu-lua-scripting-megathread-239.html#google_vignette
            if GET_INT_LOCAL("fmmc_launcher", 19875 + 34) ~= 0 then
                if GET_INT_LOCAL("fmmc_launcher", 19875 + 15) > 1 then
                    SET_INT_LOCAL("fmmc_launcher", 19875 + 15, 1)
                    SET_INT_GLOBAL(794744 + 4 + 1 + (GET_INT_LOCAL("fmmc_launcher", 19875 + 34) * 89) + 69, 1)
                end
                
                SET_INT_GLOBAL(4718592 + 3526, 1)
                SET_INT_GLOBAL(4718592 + 3527, 1)
                SET_INT_GLOBAL(4718592 + 3529 + 1, 1)
                SET_INT_GLOBAL(4718592 + 180865 + 1, 0)
            end
        end
    end)

    menu.action(CLASSIC_HEISTS, TRANSLATE("Force Ready"), {"hcclassicforceready"}, TRANSLATE("Make all of players forced ready in planning board."), function()
        -- [[update]]
        SET_INT_GLOBAL(2657991 + 1 + (1 * 467) + 269, 6) -- Thanks to @vithiam on Discord
        SET_INT_GLOBAL(2657991 + 1 + (2 * 467) + 269, 6)
        SET_INT_GLOBAL(2657991 + 1 + (3 * 467) + 269, 6)
    end)

    menu.action(CLASSIC_HEISTS, TRANSLATE("Increase Team Lives"), {"hcclassicincteamlives"}, TRANSLATE("Increases the amount of team lives. Make sure to have script host if it doesn't seem to work."), function()
        menu.trigger_commands("scripthost")
        SET_INT_LOCAL("fm_mission_controller", 19781 + 1765 + 1, 10000000) -- Thanks to @vithiam on Discord [[update]]
    end)

    menu.action(CLASSIC_HEISTS, TRANSLATE("Unlock All Classic Heists"), {"hcclassicunlockall"}, TRANSLATE("Unlocks all heists on the planning board. Also marks all tutorials as completed and allows you to skip cutscenes. After using, you will automatically be returned to Story Mode to apply the changes."), function() -- Big thanks to @negotium.rpm on Discord
        local SavedStrand = {{-1072870761, 1, 1}, {979654579, 1, 1}, {-1096986654, 1, 1}, {164435858, 1, 1}, {-231973569, 1, 1}}
        for i = 0, 4 do
            STAT_SET_INT("HEIST_SAVED_STRAND_" .. i, SavedStrand[i + 1][1])
            STAT_SET_INT("HEIST_SAVED_STRAND_" .. i .. "_L", SavedStrand[i + 1][2])
            STAT_SET_INT("HEIST_SAVED_STRAND_" .. i .. "_M", SavedStrand[i + 1][3])
        end
    
        STAT_SET_INT("BITSET_HEIST_VS_MISSIONS", -1)
        STAT_SET_INT("MPPLY_HEIST_RESET_PROFILE", 1)
        STAT_SET_INT("MPPLY_UNIQUE_HEIST_FINALE", 5)
        STAT_SET_INT("MPPLY_AVAILABLE_HEIST_FINALE", 5)
    
        -- Tutorials & Cutscenes
        STAT_SET_INT("CUTSCENE_MID_PRISON", 1)
        STAT_SET_INT("CUTSCENE_MID_HUMANE", 1)
        STAT_SET_INT("CUTSCENE_MID_NARC", 1)
        STAT_SET_INT("CUTSCENE_MID_ORNATE", 1)
        STAT_SET_INT("CUTSCENE_MID_TUT", 1)
        STAT_SET_BOOL("HEIST_PLANNING_DONE_PRINT", true)
        STAT_SET_BOOL("HEIST_PLANNING_DONE_HELP_0", true)
        STAT_SET_BOOL("HEIST_PLANNING_DONE_HELP_1", true)
        STAT_SET_BOOL("HEIST_PRE_PLAN_DONE_HELP_0", true)
        STAT_SET_BOOL("HEIST_CUTS_DONE_FINALE", true)
        STAT_SET_BOOL("HEIST_IS_TUTORIAL", false)
        STAT_SET_BOOL("HEIST_CUTS_DONE_ORNATE", true)
        STAT_SET_BOOL("HEIST_CUTS_DONE_BIOLAB", true)
        STAT_SET_BOOL("HEIST_CUTS_DONE_PRISON", true)
        STAT_SET_BOOL("HEIST_CUTS_DONE_NARCOTIC", true)
        STAT_SET_BOOL("HEIST_CUTS_DONE_TUTORIAL", true)
        STAT_SET_BOOL("HEIST_AWARD_DONE_PREP", true)
        STAT_SET_BOOL("HEIST_AWARD_BOUGHT_IN", true)
        STAT_SET_BOOL("HEIST_STRAND_INTRO_DONE", true)
        STAT_SET_BOOL("MPPLY_JOBFLOW_HEIST_TEXT", true)
    
        util.yield(50)
        if STAT_GET_INT("BITSET_HEIST_VS_MISSIONS") == -1 then -- Because this feature is used in 'Complete All Setups'
            FORCE_CLOUD_SAVE()
            menu.trigger_commands("quittosp")
        end
    end)

---


--- Robberies
util.yield()

    LS_ROBBERY = menu.list(ROBBERYS, TRANSLATE("The Los Santos Tuners Robbery"), {}, "", function(); end)

        menu.list_action(LS_ROBBERY, TRANSLATE("The Los Santos Tuners Robbery"), {"hcls"}, "", {
            { 1, TRANSLATE("Union Depository"), {"uniondepository"}, "" },
            { 2, TRANSLATE("The Superdollar Deal"), {"superdollardeal"}, "" },
            { 3, TRANSLATE("The Bank Contract"), {"bankcontract"}, "" },
            { 4, TRANSLATE("The ECU Job"), {"ecujob"}, "" },
            { 5, TRANSLATE("The Prison Contract"), {"prisoncontract"}, "" },
            { 6, TRANSLATE("The Agency Deal"), {"agencydeal"}, "" },
            { 7, TRANSLATE("The Lost Contract"), {"lostcontract"}, "" },
            { 8, TRANSLATE("The Data Contract"), {"datacontract"}, "" },
        }, function(index)
            if index ~= 2 then
                STAT_SET_INT("TUNER_GEN_BS", 12543)
            else
                STAT_SET_INT("TUNER_GEN_BS", 4351)
            end
            
            STAT_SET_INT("TUNER_CURRENT", index - 1)
        end)

        LSRob1MTunables = {
            memory.tunable_offset("TUNER_ROBBERY_GOON_CASH_REWARD"),
            memory.tunable_offset("TUNER_ROBBERY_LEADER_CASH_REWARD0"),
            memory.tunable_offset("TUNER_ROBBERY_LEADER_CASH_REWARD1"),
            memory.tunable_offset("TUNER_ROBBERY_LEADER_CASH_REWARD2"),
            memory.tunable_offset("TUNER_ROBBERY_LEADER_CASH_REWARD3"),
            memory.tunable_offset("TUNER_ROBBERY_LEADER_CASH_REWARD4"),
            memory.tunable_offset("TUNER_ROBBERY_LEADER_CASH_REWARD5"),
            memory.tunable_offset("TUNER_ROBBERY_LEADER_CASH_REWARD6"),
            memory.tunable_offset("TUNER_ROBBERY_LEADER_CASH_REWARD7"),
            memory.tunable_offset("TUNER_ROBBERY_CONTACT_FEE"),
        }
        menu.toggle_loop(LS_ROBBERY, TRANSLATE("Modify Contracts payout - $1 Million"), {"hcls1m"}, TRANSLATE("(Local)") .. "\n\n" .. TRANSLATE("Always keep this option enabled before starting a contract"), function()
            SET_INT_GLOBAL(262145 + LSRob1MTunables[1], 1000000) -- TUNER_ROBBERY_GOON_CASH_REWARD
            SET_INT_GLOBAL(262145 + LSRob1MTunables[2] + 0, 1000000) -- TUNER_ROBBERY_LEADER_CASH_REWARD0
            SET_INT_GLOBAL(262145 + LSRob1MTunables[3] + 1, 1000000) -- TUNER_ROBBERY_LEADER_CASH_REWARD1
            SET_INT_GLOBAL(262145 + LSRob1MTunables[4] + 2, 1000000) -- TUNER_ROBBERY_LEADER_CASH_REWARD2
            SET_INT_GLOBAL(262145 + LSRob1MTunables[5] + 3, 1000000) -- TUNER_ROBBERY_LEADER_CASH_REWARD3
            SET_INT_GLOBAL(262145 + LSRob1MTunables[6] + 4, 1000000) -- TUNER_ROBBERY_LEADER_CASH_REWARD4
            SET_INT_GLOBAL(262145 + LSRob1MTunables[7] + 5, 1000000) -- TUNER_ROBBERY_LEADER_CASH_REWARD5
            SET_INT_GLOBAL(262145 + LSRob1MTunables[8] + 6, 1000000) -- TUNER_ROBBERY_LEADER_CASH_REWARD6
            SET_INT_GLOBAL(262145 + LSRob1MTunables[9] + 7, 1000000) -- TUNER_ROBBERY_LEADER_CASH_REWARD7
            SET_FLOAT_GLOBAL(262145 + LSRob1MTunables[10], 0) -- TUNER_ROBBERY_CONTACT_FEE
        end, function()
            SET_INT_GLOBAL(262145 + LSRob1MTunables[1], 50000)
            SET_INT_GLOBAL(262145 + LSRob1MTunables[2] + 0, 300000)
            SET_INT_GLOBAL(262145 + LSRob1MTunables[3] + 1, 185000)
            SET_INT_GLOBAL(262145 + LSRob1MTunables[4] + 2, 178000)
            SET_INT_GLOBAL(262145 + LSRob1MTunables[5] + 3, 172000)
            SET_INT_GLOBAL(262145 + LSRob1MTunables[6] + 4, 175000)
            SET_INT_GLOBAL(262145 + LSRob1MTunables[7] + 5, 182000)
            SET_INT_GLOBAL(262145 + LSRob1MTunables[8] + 6, 180000)
            SET_INT_GLOBAL(262145 + LSRob1MTunables[9] + 7, 170000)
            SET_FLOAT_GLOBAL(262145 + LSRob1MTunables[10], 0.1)
        end)

        menu.action(LS_ROBBERY, TRANSLATE("Complete The Preps"), {"hclscomplete"}, "", function()
            STAT_SET_INT("TUNER_GEN_BS", -1)
        end)
        menu.action(LS_ROBBERY, TRANSLATE("Reset The Preps"), {"hclsresetmisson"}, "", function()
            STAT_SET_INT("TUNER_GEN_BS", 12467)
        end)
        menu.action(LS_ROBBERY, TRANSLATE("Reset The Contracts"), {"hclsresetcontract"}, "", function()
            STAT_SET_INT("TUNER_GEN_BS", 8371)
            STAT_SET_INT("TUNER_CURRENT", -1)
        end)
        menu.action(LS_ROBBERY, TRANSLATE("Reset Total Gains And Completed Contracts"), {"hclsresetgain"}, "", function()
            STAT_SET_INT("TUNER_COUNT", 0)
            STAT_SET_INT("TUNER_EARNINGS", 0)
        end)

    ---

    TH_CONTRACT = menu.list(ROBBERYS, TRANSLATE("The Contract Robbery"), {}, "", function(); end)

        CONTRACT_VIP = menu.list(TH_CONTRACT, TRANSLATE("The Contract Robbery"), {"hccontract"}, "", function(); end)

            menu.list_action(CONTRACT_VIP, TRANSLATE("NightLife Leak"), {"hccontractnightlife"}, "", {
                { 1, TRANSLATE("The Nightclub"), {"thenightclub"}, "" },
                { 2, TRANSLATE("The Marina"), {"themarina"}, "" },
                { 3, TRANSLATE("NightLife Leak"), {"nightlifeleak"}, "" },
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

            menu.list_action(CONTRACT_VIP, TRANSLATE("High Society Leak"), {"hccontractsociety"}, "", {
                { 1, TRANSLATE("The Country Club"), {"thecountryclub"}, "" },
                { 2, TRANSLATE("Guest List"), {"guestlist"}, "" },
                { 3, TRANSLATE("High Society"), {"highsociety"}, "" },
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

            menu.list_action(CONTRACT_VIP, TRANSLATE("South Central Leak"), {"hccontractcentral"}, "", {
                { 1, TRANSLATE("Davis"), {"davis"}, "" },
                { 2, TRANSLATE("The Ballas"), {"theballas"}, "" },
                { 3, TRANSLATE("Agency Studio"), {"agencystudio"}, "" },
                { 4, TRANSLATE("Don't Fuck with Dre"), {"dontfuckwithdre"}, "" },
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

            menu.list_action(CONTRACT_VIP, TRANSLATE("Record A Studios"), {"hccontractrecord"}, "", {
                { 1, TRANSLATE("Seed Capital"), {"seedcapital"}, "" },
                { 2, TRANSLATE("Fire It Up"), {"fireitup"}, "" },
                { 3, TRANSLATE("OG Kush"), {"ogkush"}, "" },
            }, function(index)
                STAT_SET_INT("FIXER_SHORT_TRIPS", index)
                STAT_SET_INT("FIXER_GENERAL_BS", -259160457)
            end)

        ---

        TH2MTunables = {
            memory.tunable_offset("FIXER_FINALE_LEADER_CASH_REWARD")
        }
        menu.toggle_loop(TH_CONTRACT, TRANSLATE("Modify Finale's Payout (2 Million)"), {"hccontract2m"}, TRANSLATE("(Local)"), function()
            SET_INT_GLOBAL(262145 + TH2MTunables[1], 2000000)
        end, function()
            SET_INT_GLOBAL(262145 + TH2MTunables[1], 1000000)
        end)

        THContractRemCooldownTunables= {
            memory.tunable_offset("FIXER_SECURITY_CONTRACT_COOLDOWN_TIME"),
            memory.tunable_offset(-2036534141),
        }
        menu.toggle_loop(TH_CONTRACT, TRANSLATE("Remove Contracts & Payphone Hits Cooldown"), {"hccontractremcool"}, TRANSLATE("Make sure it's enabled before starting any contracts or hits."), function() -- Credit goes to @dachaos9262 on Discord
            SET_INT_GLOBAL(262145 + THContractRemCooldownTunables[1], 0) 
            SET_INT_GLOBAL(262145 + THContractRemCooldownTunables[2], 0)
        end, function()
            SET_INT_GLOBAL(262145 + THContractRemCooldownTunables[1], 300000)
            SET_INT_GLOBAL(262145 + THContractRemCooldownTunables[2], 500)
        end)

        THSecurityRemCooldownTunables = {
            memory.tunable_offset(1872071131),
        }
        menu.toggle_loop(TH_CONTRACT, TRANSLATE("Remove Security Mission Cooldown"), {"hccontractremsecuritycool"}, "", function()
            SET_INT_GLOBAL(262145 + THSecurityRemCooldownTunables[1], 0)
        end, function()
            SET_INT_GLOBAL(262145 + THSecurityRemCooldownTunables[1], 1200000)
        end)

        menu.action(TH_CONTRACT, TRANSLATE("Complete All Missions"), {}, "", function()
            STAT_SET_INT("FIXER_GENERAL_BS", -1)
            STAT_SET_INT("FIXER_COMPLETED_BS", -1)
            STAT_SET_INT("FIXER_STORY_BS", -1)
            STAT_SET_INT("FIXER_STORY_COOLDOWN", -1)
        end)

    ---

    CHOP_SHOP_ROB = menu.list(ROBBERYS, TRANSLATE("The Chop Shop Robbery"), {}, "", function(); end)

        menu.list_action(CHOP_SHOP_ROB, TRANSLATE("The Chop Shop Robbery"), {"hcchopshop"}, "", {
            { 1, TRANSLATE("The Cargo Ship Robbery"), {"cargoship"}, "" },
            { 2, TRANSLATE("The Gangbanger Robbery"), {"gangbanger"}, "" },
            { 3, TRANSLATE("The Duggan Robbery"), {"duggan"}, "" },
            { 4, TRANSLATE("The Podium Robbery"), {"podium"}, "" },
            { 5, TRANSLATE("The McTony Robbery"), {"mctony"}, "" },
        }, function(index)
            STAT_SET_INT("SALV23_VEH_ROB", index - 1)
            STAT_SET_INT("MOST_TIME_ON_3_PLUS_STARS ", 300000)
            STAT_SET_INT("SALV23_PLAN_DIALOGUE", 4131109)
            STAT_SET_INT("SALV23_FM_PROG", 126)
            STAT_SET_INT("SALV23_GEN_BS", -10241)
            STAT_SET_INT("SALV23_DISRUPT", 3)
            STAT_SET_INT("SALV23_VEH_MODS", 0)
            STAT_SET_INT("SALV23_SCOPE_BS", -1)
            STAT_SET_BOOL("SALV23_CAN_KEEP", true)
        end)

        menu.toggle_loop(CHOP_SHOP_ROB, TRANSLATE("Skip The Hacking Process"), {}, TRANSLATE("Works On Both: Beam Puzzle & Brute Force"), function()
            SET_INT_LOCAL("fm_content_vehrob_casino_prize", 1045 + 135, 3) -- Beam Puzzle Hack
            SET_INT_LOCAL("fm_content_vehrob_police", 7511, 536871425) -- Brute Force
        end)
        
    ---

---


--- Missions
util.yield()

    menu.list_action(MISSONS, TRANSLATE("Lowrider"), {"hclowrider"}, "", {
        { 1, TRANSLATE("Community Outreach"), {"communityoutreach"}, "" },
        { 2, TRANSLATE("Slow and Low"), {"slowandlow"}, "" },
        { 3, TRANSLATE("It's a G thing"), {"itsagthing"}, "" },
        { 4, TRANSLATE("Funeral Party"), {"funeralparty"}, "" },
        { 5, TRANSLATE("Lowrider Envy"), {"lowriderenvy"}, "" },
        { 6, TRANSLATE("Point and Shoot"), {"pointandshoot"}, "" },
        { 7, TRANSLATE("Desperate Times Call For..."), {"desperatetimescallfor"}, "" },
        { 8, TRANSLATE("Peace Offerings"), {"peaceofferings"}, "" },
    }, function(index)
        STAT_SET_INT("LOW_FLOW_CURRENT_PROG", index)
        STAT_SET_INT("LOW_FLOW_CURRENT_CALL", index)
        STAT_SET_INT("LOWRIDER_FLOW_COMPLETE", 0)
    end)

    menu.list_action(MISSONS, TRANSLATE("Casino Story"), {"hclowrider"}, "", {
        { 1, TRANSLATE("Loose Cheng"), {"loosecheng"}, "" },
        { 2, TRANSLATE("House Keeping"), {"housekeeping"}, "" },
        { 3, TRANSLATE("Strong Arm Tactics"), {"strongarmtactics"}, "" },
        { 4, TRANSLATE("Play to Win"), {"playtowin"}, "" },
        { 5, TRANSLATE("Bad Beat"), {"badbeat"}, "" },
        { 6, TRANSLATE("Cashing Out"), {"cashingout"}, "" },
    }, function(index)
        STAT_SET_INT("VCM_STORY_PROGRESS", index - 1)
        STAT_SET_INT("VCM_FLOW_PROGRESS", 1311695)
    end)

    menu.list_action(MISSONS, TRANSLATE("A Superyacht Life"), {"hcyacht"}, "", {
        { 1, TRANSLATE("Overboard"), {"overboard"}, "" },
        { 2, TRANSLATE("Salvage"), {"salvage"}, "" },
        { 3, TRANSLATE("All Hands"), {"allhands"}, "" },
        { 4, TRANSLATE("Icebreaker"), {"icebreaker"}, "" },
        { 5, TRANSLATE("Bon Voyage"), {"bonvoyage"}, "" },
        { 6, TRANSLATE("D-Day"), {"dday"}, "" },
    }, function(index)
        STAT_SET_INT("YACHT_MISSION_PROG", index - 1)
        STAT_SET_INT("YACHT_MISSION_FLOW", 21845)
    end)

    OPT_MISSIONS = menu.list(MISSONS, TRANSLATE("Operation Paper Trail"), {}, "", function(); end)

        menu.list_action(OPT_MISSIONS, TRANSLATE("Operation Paper Trail"), {"hcopt"}, "", {
            { 1, TRANSLATE("Intelligence"), {"intelligence"}, "" },
            { 2, TRANSLATE("Counterintelligence"), {"counterintelligence"}, "" },
            { 3, TRANSLATE("Extraction"), {"extraction"}, "" },
            { 4, TRANSLATE("Asset Seizure"), {"assetseizure"}, "" },
            { 5, TRANSLATE("Operation Paper Trail"), {"operationpapertrail"}, "" },
            { 6, TRANSLATE("Cleanup"), {"cleanup"}, "" },
        }, function(index)
            STAT_SET_INT("ULP_MISSION_CURRENT", index - 1)
            STAT_SET_INT("ULP_MISSION_PROGRESS", 127)
        end)

        menu.toggle_loop(OPT_MISSIONS, TRANSLATE("Skip The Hacking Process"), {}, "(" .. TRANSLATE("Operation Paper Trail") .. " - " .. TRANSLATE("Counterintelligence") .. ")", function() -- Thanks for coding this, @pedro9558 on Discord
            SET_INT_LOCAL("fm_mission_controller_2020", 1001 + 135, 3) -- [[update]]
        end)

        menu.action(OPT_MISSIONS, TRANSLATE("Teleport To IAA Headquarters"), {}, "", function()
            local Blip = HUD.GET_FIRST_BLIP_INFO_ID(838) -- ULP Blip, https://wiki.rage.mp/index.php?title=Blips
            if Blip ~= 0 then
                local Pos = HUD.GET_BLIP_COORDS(Blip)
                TELEPORT(Pos.x, Pos.y, Pos.z)
            else
                NOTIFY(TRANSLATE("Please make sure you can play Operation Paper Trail now!"))
            end
        end)

    ---

    menu.list_action(MISSONS, TRANSLATE("Los Santos Drug Wars"), {"hclsdrugwars"}, "", {
        { 1, TRANSLATE("Welcome to the Troupe"), {"welcometothetroupe"}, TRANSLATE("(First Dose)") },
        { 2, TRANSLATE("Designated Driver"), {"designateddriver"}, TRANSLATE("(First Dose)") },
        { 3, TRANSLATE("Fatal Incursion"), {"fatalincursion"}, TRANSLATE("(First Dose)") },
        { 4, TRANSLATE("Uncontrolled Substance"), {"uncontrolledsubstance"}, TRANSLATE("(First Dose)") },
        { 5, TRANSLATE("Make War not Love"), {"makewarnotlove"}, TRANSLATE("(First Dose)") },
        { 6, TRANSLATE("Off the Rails"), {"offtherails"}, TRANSLATE("(First Dose)") },
        { 7, TRANSLATE("This is an Intervention"), {"thisisanintervention"}, TRANSLATE("(Last Dose)") },
        { 8, TRANSLATE("Unusual Suspects"), {"unusualsuspects"}, TRANSLATE("(Last Dose)") },
        { 9, TRANSLATE("FriedMind"), {"friedmind"}, TRANSLATE("(Last Dose)") },
        { 10, TRANSLATE("Checking In"), {"checkingin"}, TRANSLATE("(Last Dose)") },
        { 11, TRANSLATE("BDKD"), {"bdkd"}, TRANSLATE("(Last Dose)") },
    }, function(index)
        STAT_SET_INT("XM22_CURRENT", index - 1)

        if index == 1 then
            STAT_SET_INT("XM22_MISSIONS", 0)
        elseif index == 2 then
            STAT_SET_INT("XM22_MISSIONS", 2)
        elseif index == 3 then
            STAT_SET_INT("XM22_MISSIONS", 3)
        elseif index == 4 then
            STAT_SET_INT("XM22_MISSIONS", 7)
        elseif index == 5 then
            STAT_SET_INT("XM22_MISSIONS", 15)
        elseif index == 6 then
            STAT_SET_INT("XM22_MISSIONS", 31)
        elseif index == 7 then
            STAT_SET_INT("XM22_MISSIONS", 4194367)
        elseif index == 8 then
            STAT_SET_INT("XM22_MISSIONS", 4194431)
        elseif index == 9 then
            STAT_SET_INT("XM22_MISSIONS", 4194559)
        elseif index == 10 then
            STAT_SET_INT("XM22_MISSIONS", 4194815)
        elseif index == 11 then
            STAT_SET_INT("XM22_MISSIONS", 4195327)
        end
    end)

    menu.list_action(MISSONS, TRANSLATE("San Andreas Mercenaries"), {"hcsam"}, "", {
        { 1, TRANSLATE("Reporting for Duty"), {"reportingforduty"}, "" },
        { 2, TRANSLATE("Falling In"), {"fallingin"}, "" },
        { 3, TRANSLATE("On Parade"), {"onparade"}, "" },
        { 4, TRANSLATE("Breaking Ranks"), {"breakingranks"}, "" },
        { 5, TRANSLATE("Unconventional Warfare"), {"unconventionalwarfare"}, "" },
        { 6, TRANSLATE("Shock & Awe"), {"shockawe"}, "" },
        { 7, TRANSLATE("Unlock All Missions"), {"unlockall"}, "" },
    }, function(index)
        if index ~= 7 then
            STAT_SET_INT("SUM23_AVOP_CURRENT", index - 1)
        else
            STAT_SET_INT("SUM23_AVOP_CURRENT", 0)
        end

        if index == 1 then
            STAT_SET_INT("SUM23_AVOP_PROGRESS", 0)
        elseif index == 2 then
            STAT_SET_INT("SUM23_AVOP_PROGRESS", 1)
        elseif index == 3 then
            STAT_SET_INT("SUM23_AVOP_PROGRESS", 3)
        elseif index == 4 then
            STAT_SET_INT("SUM23_AVOP_PROGRESS", 7)
        elseif index == 5 then
            STAT_SET_INT("SUM23_AVOP_PROGRESS", 15)
        elseif index == 6 then
            STAT_SET_INT("SUM23_AVOP_PROGRESS", 31)
        elseif index == 7 then
            STAT_SET_INT("SUM23_AVOP_PROGRESS", 20543)
        end
    end)

    menu.list_action(MISSONS, TRANSLATE("The Cluckin' Bell Farm Raid"), {"hccbfr"}, "", { -- https://www.unknowncheats.me/forum/4013202-post4268.html
        { 1, TRANSLATE("Slush Fund"), {"slushfund"}, "" },
        { 2, TRANSLATE("Breaking and Entering"), {"breakingandentering"}, "" },
        { 3, TRANSLATE("Concealed Weapons"), {"concealedweapons"}, "" },
        { 4, TRANSLATE("Hit and Run"), {"hitandrun"}, "" },
        { 5, TRANSLATE("Disorganized Crime"), {"disorganizedcrime"}, "" },
        { 6, TRANSLATE("Scene of The Crime"), {"sceneofthecrime"}, "" },
    }, function(index)
        STAT_SET_INT("SALV23_CFR_COOLDOWN", -1) -- Removes The Cooldown

        if index == 1 then
            STAT_SET_INT("SALV23_INST_PROG", 0)
        elseif index == 2 then
            STAT_SET_INT("SALV23_INST_PROG", 1)
        elseif index == 3 then
            STAT_SET_INT("SALV23_INST_PROG", 3)
        elseif index == 4 then
            STAT_SET_INT("SALV23_INST_PROG", 7)
        elseif index == 5 then
            STAT_SET_INT("SALV23_INST_PROG", 15)
        elseif index == 6 then
            STAT_SET_INT("SALV23_INST_PROG", 31)
        end
    end)

---


--- Master Unlocker
util.yield()

    DLC_UNLOCKER = menu.list(MASTER_UNLOCKER, TRANSLATE("DLCs"), {}, "", function(); end)

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

            menu.action(ARENA_TOOL, TRANSLATE("Unlock Clothing"), {}, "", function()
                SET_PACKED_INT_TUNABLE_GLOBAL("ENABLE_LOGIN_ALBANY_LOGO_WHITE_SHIRT", "ENABLE_LOGIN_DECLASSE_LADY_BLACK_SHIRT", 1)
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

            menu.action(SUMMER2020, TRANSLATE("Unlock Clothing"), {}, "", function()
                SET_PACKED_INT_TUNABLE_GLOBAL("ENABLE_LOGIN_BCTR_AGED_TEE", "ENABLE_LOGIN_LEMON_SPORTS_TRACK_TOP", 1)
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

            menu.action(CONTRACT_DLC, TRANSLATE("Unlock Animal Masks"), {}, "", function()
                SET_PACKED_INT_TUNABLE_GLOBAL("FIXER_LOGIN_AWARD_FISHMASK_1", "FIXER_LOGIN_AWARD_SEALMASK_4", 1)
            end)
            menu.action(CONTRACT_DLC, TRANSLATE("Unlock DJ Pooh Shirts"), {}, "", function()
                SET_PACKED_INT_TUNABLE_GLOBAL("FIXER_LOGIN_DJ_POOH_ORANGE", "FIXER_LOGIN_DJ_POOH_BLUE", 1) 
            end)

        ---

        CRIMINAL_DLC = menu.list(DLC_UNLOCKER, TRANSLATE("The Criminal Enterprises DLC"), {}, "", function(); end) -- https://www.unknowncheats.me/forum/3492512-post53.html
            
            menu.action(CRIMINAL_DLC, TRANSLATE("Jackets / Sweaters / Hoodies / Shirts"), {}, "", function()
                SET_PACKED_INT_TUNABLE_GLOBAL(-1967834023, -1263992372, 1) 
                SET_PACKED_INT_TUNABLE_GLOBAL(-206691492, -1577621449, 1)
            end)
            menu.action(CRIMINAL_DLC, TRANSLATE("Pants / Caps / Hats"), {}, "", function()
                SET_PACKED_INT_TUNABLE_GLOBAL(638571354, 96152168, 1)
                SET_PACKED_INT_TUNABLE_GLOBAL(-2120678580, -1003907171, 1)
                SET_PACKED_INT_TUNABLE_GLOBAL(191276118, -1484490421, 1)
                SET_PACKED_INT_TUNABLE_GLOBAL("SUM2_CHRISTMAS_BEERHAT_LEMON", "SUM2_CHRISTMAS_BEERHAT_RED_REINDEER", 1)
                SET_INT_TUNABLE_GLOBAL(-339902614, 1)
            end)
            menu.action(CRIMINAL_DLC, TRANSLATE("Earphones / Masks / Tech Demon"), {}, "", function()
                SET_PACKED_INT_TUNABLE_GLOBAL(-889497715, -1162924007, 1)
                SET_PACKED_INT_TUNABLE_GLOBAL(1096886904, -359187968, 1)
                SET_PACKED_INT_TUNABLE_GLOBAL(190205845, -171130807, 1)
                SET_PACKED_INT_TUNABLE_GLOBAL(1424509866, -1677619307, 1)
                SET_PACKED_INT_TUNABLE_GLOBAL(-1285035231, -1792568167, 1)
                SET_INT_TUNABLE_GLOBAL(505550305, 1)
            end)
            menu.action(CRIMINAL_DLC, TRANSLATE("Shoes (Sliders) / Tiger"), {}, "", function()
                SET_PACKED_INT_TUNABLE_GLOBAL(467678514, 169972145, 1)
                SET_PACKED_INT_TUNABLE_GLOBAL(245491514, -141827484, 1) 
            end)
            
        ---

        DRUG_WAR = menu.list(DLC_UNLOCKER, TRANSLATE("Drug War DLC"), {}, "", function(); end)

            menu.action(DRUG_WAR, TRANSLATE("Unlock Clothing"), {}, "", function() -- https://www.unknowncheats.me/forum/3635453-post69.html
                SET_PACKED_INT_TUNABLE_GLOBAL("EVENT_LOGIN_DLC22022_ICE_VINYL_JACKET_3", "PURPLE_SNAKESKIN_MOTOR_HELMET", 1)
            end)

        ---

    ---

    UNLOCKER_BUILDING = menu.list(MASTER_UNLOCKER, TRANSLATE("Buildings"), {}, "", function(); end)

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

        menu.action(UNLOCKER_BUILDING, TRANSLATE("Unlock Arcade Awards"), {}, TRANSLATE("Trophies, toys, and clothings are included."), function()
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

            SET_PACKED_INT_TUNABLE_GLOBAL("STREET_CRIMES_BOXART_TEE", "RED_FAME_OR_SHAME_KRONOS", 1) -- For Clothing
        end)

        menu.action(UNLOCKER_BUILDING, TRANSLATE("Casino Store Ace Masks"), {}, TRANSLATE("Make sure click before buying. When you change your session, will be changed to non-unlocked status."), function()
            SET_PACKED_INT_TUNABLE_GLOBAL("VC_ACE_OF_SPADES", "VC_ACE_OF_DIAMONDS", 1)
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

    UNLOCKER_HEISTS = menu.list(MASTER_UNLOCKER, TRANSLATE("Heists"), {}, TRANSLATE("Unlocks almost of unlockable stuffs related the heist like clothing, etc."), function(); end)

        menu.action(UNLOCKER_HEISTS, TRANSLATE("Cayo Perico Heist"), {}, "", function()
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
            SET_PACKED_INT_TUNABLE_GLOBAL("TOPS_ISLAND_HEIST_EVENT_JACKET_1", "PANTS_BIGNESS_TIE_DYE_SWEAT_PANTS", 1)
            SET_PACKED_INT_TUNABLE_GLOBAL("ACCESSORIES_GLOW_BRACELET_1", "ACCESSORIES_GLOW_NECKLACE_16", 1)
            SET_PACKED_INT_TUNABLE_GLOBAL("HEIST4_FESTIVE_MASK_0", "HEIST4_FESTIVE_MASK_19", 1)
            SET_PACKED_INT_TUNABLE_GLOBAL("ACCESSORIES_SUNGLASSES_1_0", "ACCESSORIES_SUNGLASSES_3_11", 1)
            SET_PACKED_INT_TUNABLE_GLOBAL("PALMS_TRAX_EVENT_TEE_1", "STILL_SLIPPING_EVENT_TEE_2", 1)
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

    UNLOCKER_MISSIONS = menu.list(MASTER_UNLOCKER, TRANSLATE("Missions"), {}, "", function(); end)

        menu.action(UNLOCKER_MISSIONS, TRANSLATE("Unlock Taxi Missions"), {}, "", function() -- https://github.com/ImSapphire/unlock_drug_war_content/blob/main/unlock_drug_war_content.lua
            SET_INT_TUNABLE_GLOBAL("XM22_TAXI_DRIVER_ENABLE", 1)
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

    ---

    UNLOCKER_ANNIVERSARY = menu.list(MASTER_UNLOCKER, TRANSLATE("Special Anniversaries"), {}, "", function(); end)

        XMAS_FEATURES = menu.list(UNLOCKER_ANNIVERSARY, TRANSLATE("Christmas"), {}, "", function(); end)

            BypassXMASTunables = {
                memory.tunable_offset("DISABLE_SNOWBALLS"),
                memory.tunable_offset("ENABLE_CLEAR_STRUCT_ON_TRAN_FAIL"),
                memory.tunable_offset("MAX_NUMBER_OF_SNOWBALLS"),
                memory.tunable_offset("PICK_UP_NUMBER_OF_SNOWBALLS"),
            }
            menu.toggle_loop(XMAS_FEATURES, TRANSLATE("Bypass Christmas Clothing"), {}, TRANSLATE("You must keep this feature enabled in order to wear it!"), function()
                SET_PACKED_INT_GLOBAL(BypassXMASTunables[1], BypassXMASTunables[2], 0)
                SET_PACKED_INT_GLOBAL(BypassXMASTunables[3], BypassXMASTunables[4], 7)
            end)
            
            menu.action(XMAS_FEATURES, TRANSLATE("Unlock Christmas Liveries"), {}, "", function()
                for i = 1, 20 do
                    STAT_SET_INT("MPPLY_XMASLIVERIES" .. i, -1)
                end
            end)

            menu.action(XMAS_FEATURES, TRANSLATE("Unlock Christmas Content"), {}, "", function()
                SET_PACKED_INT_TUNABLE_GLOBAL("DISABLE_SNOWBALLS", "PICK_UP_NUMBER_OF_SNOWBALLS", 1)
                SET_PACKED_INT_TUNABLE_GLOBAL("TOGGLE_CHRISTMAS_EVE_GIFT", "TOGGLE_NEW_YEARS_DAY_GIFT", 1)
                SET_PACKED_INT_TUNABLE_GLOBAL("XMAS2015_VEHICLE", "XMAS2015_MASKS", 1)
                SET_PACKED_INT_TUNABLE_GLOBAL("TOGGLE_2015_CHRISTMAS_EVE_GIFT", "TOGGLE_2015_CHRISTMAS_DAY_GIFT", 1)
                SET_PACKED_INT_TUNABLE_GLOBAL("TOGGLE_2016_CHRISTMAS_EVE_GIFT", "TOGGLE_2016_CHRISTMAS_DAY_GIFT", 1)
                SET_PACKED_INT_TUNABLE_GLOBAL(1840129338, -495986083, 1)
                SET_PACKED_INT_TUNABLE_GLOBAL(-101086705, "TOGGLE_2017_CHRISTMAS_DAY_GIFT", 1)
                SET_PACKED_INT_TUNABLE_GLOBAL("XMASDAYGIFT2018_CAR", "XMASDAYGIFT2018_CAR2", 1)
                SET_PACKED_INT_TUNABLE_GLOBAL("TOGGLE_2018_CHRISTMAS_EVE_GIFT", "TOGGLE_2018_CHRISTMAS_DAY_GIFT", 1)
                SET_PACKED_INT_TUNABLE_GLOBAL("TOGGLE_2019_CHRISTMAS_EVE_GIFT", "TOGGLE_2019_CHRISTMAS_DAY_GIFT", 1)
                SET_PACKED_INT_TUNABLE_GLOBAL("TOGGLE_2021_CHRISTMAS_GIFT", "TOGGLE_2021_NEW_YEARS_GIFT", 1)
                SET_PACKED_INT_TUNABLE_GLOBAL("XMASGIFTS2022", "NEWYEARSGIFTS2022", 1) -- https://www.unknowncheats.me/forum/3630405-post34.html (2022)
                SET_INT_TUNABLE_GLOBAL("TOGGLE_XMAS_CONTENT", 1)
                SET_INT_TUNABLE_GLOBAL("TOGGLE_GIFT_TO_PLAYER_WHEN_LOGGING_ON", 1)
                SET_INT_TUNABLE_GLOBAL("XMAS2015_PYJAMAS", 1)
                SET_INT_TUNABLE_GLOBAL("CHRISTMAS2016_CLOTHING", 1)
                SET_INT_TUNABLE_GLOBAL("CHRISTMAS2017_CLOTHING", 1)
                SET_INT_TUNABLE_GLOBAL("NEW_BH_VEHICLE_TEXT", 1)
                SET_INT_TUNABLE_GLOBAL("TOGGLE_2020_CHRISTMAS_DAY_GIFT", 1)
            end)

        ---

        IndependenceTunables = {
            memory.tunable_offset("INDEPENDENCE_DAY_DEACTIVATE_FIREWORKS_LAUNCHER"),
            memory.tunable_offset("TOGGLE_ACTIVATE_MONSTER_TRUCK"),
            memory.tunable_offset("UNLOCKINDEPENDENCE_BEER_HAT_1"),
            memory.tunable_offset("UNLOCKINDEPENDENCE_STATUE_HAPPINESS_SHIRT"),
            memory.tunable_offset("TOGGLE_ACTIVATE_INDEPENDENCE_PACK"),
        }
        menu.toggle_loop(UNLOCKER_ANNIVERSARY, TRANSLATE("Independence's Day"), {}, TRANSLATE("Note: You may need to keep activating to use some of Independence Day's contents."), function()
            SET_PACKED_INT_GLOBAL(IndependenceTunables[1], IndependenceTunables[2], 1)
            SET_PACKED_INT_GLOBAL(IndependenceTunables[3], IndependenceTunables[4], 1)
            SET_INT_GLOBAL(262145 + IndependenceTunables[5], 1)
        end)

        menu.action(UNLOCKER_ANNIVERSARY, TRANSLATE("Valentine's Day"), {}, "", function()
            SET_PACKED_INT_TUNABLE_GLOBAL("TURN_ON_VALENTINE_WEAPON", "TURN_ON_VALENTINE_CLOTHING", 1)
            SET_PACKED_INT_TUNABLE_GLOBAL("TURN_ON_VALENTINE_2016_CLOTHING", "TURN_ON_VALENTINE_2016_VEHICLE", 1)
            SET_INT_TUNABLE_GLOBAL("TURN_ON_VALENTINES_EVENT", 1)
        end)

    ---

    UNLOCKER_SHIRT_HAT = menu.list(MASTER_UNLOCKER, TRANSLATE("Clothes"), {}, "", function(); end)
    
        menu.action(UNLOCKER_SHIRT_HAT, TRANSLATE("Unlock Lots of Hats And Shirts"), {}, TRANSLATE("500+ unlocks are included, try and see how many clothes would be unlocked."), function()
            SET_PACKED_INT_TUNABLE_GLOBAL("DLC_SHIRT_MELTDOWN", "DLC_SHIRT_CAPOLAVORO", 1)
            SET_PACKED_INT_TUNABLE_GLOBAL("AWARD_LOW_HATS_MAGNETICS_SCRIPT", "AWARD_LOW_TSHIRT_VAMPIRES_ON_THE_BEACH", 1)
            SET_PACKED_INT_TUNABLE_GLOBAL("ACCOUNTANTSHIRTEVENT", "CRESTTSHIRTEVENT", 1)
            SET_PACKED_INT_TUNABLE_GLOBAL("AWARD_JUMPSUIT_WHITE", "AWARD_JUMPSUIT_SILVER", 1)
            SET_PACKED_INT_TUNABLE_GLOBAL("TSHIRT_WESTERN_BIG_LOGO_WHITE", 310744591, 1)
            SET_PACKED_INT_TUNABLE_GLOBAL("AWARD_BLACK_AMMUNATION_CAP", "AWARD_RSTAR_LOGO_WHITE", 1)
            SET_PACKED_INT_TUNABLE_GLOBAL("AWARD_EMOTION_983_TSHIRT", "AWARD_FAKE_VAPID_TSHIRT", 1)
            SET_PACKED_INT_TUNABLE_GLOBAL("MAISONETTE_LOS_SANTOS_TSHIRT", "TONYS_FUN_HOUSE_TSHIRT", 1)
            SET_PACKED_INT_TUNABLE_GLOBAL("AWARD_LS_UR", "AWARD_BLAINE_COUNTY_RADIO", 1)
            SET_PACKED_INT_TUNABLE_GLOBAL(-726113206, -1910486921, 1)
            SET_PACKED_INT_TUNABLE_GLOBAL(-1344369866, 1799248495, 1)
            SET_PACKED_INT_TUNABLE_GLOBAL(760292630, 1007326524, 1)
            SET_PACKED_INT_TUNABLE_GLOBAL("HATS_ISLAND_HEIST_EVENT_HAT_1", "HATS_ISLAND_HEIST_EVENT_HAT_5", 1)
            SET_PACKED_INT_TUNABLE_GLOBAL("FIXER_LOGIN_DJ_POOH_ORANGE", "FIXER_LOGIN_DJ_POOH_BLUE", 1)
            SET_INT_TUNABLE_GLOBAL("ENABLE_RACE_CREATOR_JUBILEE", 1)

            -- https://www.unknowncheats.me/forum/grand-theft-auto-v/461672-gtahax-1-57-external-thread-3-a-23.html
            SET_INT_TUNABLE_GLOBAL("KIFFLOMTEE_LOGINAWARD", 1) -- Kifflom Tee

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

        menu.action(UNLOCKER_SHIRT_HAT, TRANSLATE("Unlock Sasquatch Outfit"), {}, "", function() -- https://www.unknowncheats.me/forum/3492512-post53.html
            SET_INT_TUNABLE_GLOBAL(-1966279346, 1)
        end)

        menu.action(UNLOCKER_SHIRT_HAT, TRANSLATE("Unlock 'Don't Cross the Line Tee'"), {}, "", function()
            STAT_SET_INT("DCTL_WINS", 500)
            STAT_SET_INT("DCTL_PLAY_COUNT", 750)
        end)

    ---

    UNLOCKER_TATTOO = menu.list(MASTER_UNLOCKER, TRANSLATE("Tattoos"), {}, "", function(); end)

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

    UNLOCKER_VEHICLE = menu.list(MASTER_UNLOCKER, TRANSLATE("Vehicles"), {}, "", function(); end)

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

    SPECIAL_WEAPON = menu.list(MASTER_UNLOCKER, TRANSLATE("Weapons"), {}, "", function(); end)

        menu.action(SPECIAL_WEAPON, TRANSLATE("Service Carbine"), {}, "", function() -- https://www.unknowncheats.me/forum/3488328-post27.html
            SET_INT_TUNABLE_GLOBAL("UNLOCK_SERVICE_CARBINE_FOR_PURCHASE", 1)
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

        menu.action(SPECIAL_WEAPON, TRANSLATE("Up-N-Atomizer"), {}, "", function()
            SET_INT_GLOBAL(104662, 90) -- freemode.c [[update]]
        end)

    ---

    menu.action(MASTER_UNLOCKER, TRANSLATE("Vanilla Unicorn Award"), {}, "", function()
        for i = 0, 25, 5 do
            STAT_SET_INT("LAP_DANCED_BOUGHT", i)
        end
        STAT_SET_INT("PROSTITUTES_FREQUENTED", 1000)
    end)

    menu.action(MASTER_UNLOCKER, TRANSLATE("Returning Player Bonus"), {}, "", function()
        SET_INT_GLOBAL(104663, 1) -- freemode.c [[update]]
        SET_INT_GLOBAL(153015, 2) -- freemode.c [[update]]
    end)

---


--- Tools
util.yield()

    TUNABLES = menu.list(TOOLS, TRANSLATE("Tunables"), {}, "", function(); end) -- Almost not credited global variables from: https://www.unknowncheats.me/forum/3337151-post1560.html

        TUNABLES_CD = menu.list(TUNABLES, TRANSLATE("Remove Cooldowns"), {}, "", function(); end)

            menu.divider(TUNABLES_CD, TRANSLATE("Supplies' Delay"))

                MCCooldownTunables = {
                    memory.tunable_offset("BIKER_PURCHASE_SUPPLIES_DELAY"),
                }
                menu.toggle_loop(TUNABLES_CD, TRANSLATE("MC Business"), {}, "", function()
                    SET_INT_GLOBAL(262145 + MCCooldownTunables[1], 0)
                end, function()
                    SET_INT_GLOBAL(262145 + MCCooldownTunables[1], 600)
                end)
                
                BunkerCooldownTunables = {
                    memory.tunable_offset("GR_PURCHASE_SUPPLIES_DELAY"),
                }
                menu.toggle_loop(TUNABLES_CD, TRANSLATE("Bunker"), {}, "", function()
                    SET_INT_GLOBAL(262145 + BunkerCooldownTunables[1], 0)
                end, function()
                    SET_INT_GLOBAL(262145 + BunkerCooldownTunables[1], 600)
                end)

            ---

            menu.divider(TUNABLES_CD, TRANSLATE("Buying And Selling"))

                SCCooldownTunables = {
                    memory.tunable_offset("EXEC_BUY_COOLDOWN"),
                    memory.tunable_offset("EXEC_SELL_COOLDOWN"),
                }
                menu.toggle_loop(TUNABLES_CD, TRANSLATE("Special Cargo"), {}, "", function() 
                    SET_INT_GLOBAL(262145 + SCCooldownTunables[1], 0)
                    SET_INT_GLOBAL(262145 + SCCooldownTunables[2], 0)
                end, function()
                    SET_INT_GLOBAL(262145 + SCCooldownTunables[1], 300000)
                    SET_INT_GLOBAL(262145 + SCCooldownTunables[2], 1800000)
                end)

                VCCooldownTunables = {
                    memory.tunable_offset("IMPEXP_STEAL_COOLDOWN"),
                    memory.tunable_offset(1001423248),
                    memory.tunable_offset(240134765),
                    memory.tunable_offset(1915379148),
                    memory.tunable_offset(-824005590),
                }
                menu.toggle_loop(TUNABLES_CD, TRANSLATE("Vehicle Cargo"), {}, "", function()
                    SET_INT_GLOBAL(262145 + VCCooldownTunables[1], 0)
                    SET_INT_GLOBAL(262145 + VCCooldownTunables[2], 0) -- 1 Vehicle
                    SET_INT_GLOBAL(262145 + VCCooldownTunables[3], 0) -- 2 Vehicles
                    SET_INT_GLOBAL(262145 + VCCooldownTunables[4], 0) -- 3 Vehicles
                    SET_INT_GLOBAL(262145 + VCCooldownTunables[5], 0) -- 4 Vehicles
                end, function()
                    SET_INT_GLOBAL(262145 + VCCooldownTunables[1], 180000)
                    SET_INT_GLOBAL(262145 + VCCooldownTunables[2], 1200000)
                    SET_INT_GLOBAL(262145 + VCCooldownTunables[3], 1680000)
                    SET_INT_GLOBAL(262145 + VCCooldownTunables[4], 2340000)
                    SET_INT_GLOBAL(262145 + VCCooldownTunables[5], 2880000)
                end)

                AFCCooldownTunables = {
                    memory.tunable_offset("SMUG_STEAL_EASY_COOLDOWN_TIMER"),
                    memory.tunable_offset("SMUG_STEAL_MED_COOLDOWN_TIMER"),
                    memory.tunable_offset("SMUG_STEAL_HARD_COOLDOWN_TIMER"),
                    memory.tunable_offset(1722502526),
                    memory.tunable_offset(-1091356151),
                }
                menu.toggle_loop(TUNABLES_CD, TRANSLATE("Air-Freight Cargo"), {}, "", function()
                    SET_INT_GLOBAL(262145 + AFCCooldownTunables[1], 0) -- Tobacco, Counterfeit Goods
                    SET_INT_GLOBAL(262145 + AFCCooldownTunables[2], 0) -- Animal Materials, Art, Jewelry
                    SET_INT_GLOBAL(262145 + AFCCooldownTunables[3], 0) -- Narcotics, Chemicals, Medical Supplies
                    SET_INT_GLOBAL(262145 + AFCCooldownTunables[4], 0) -- Additional Time per Player
                    SET_INT_GLOBAL(262145 + AFCCooldownTunables[5], 0) -- Sale
                end, function()
                    SET_INT_GLOBAL(262145 + AFCCooldownTunables[1], 120000)
                    SET_INT_GLOBAL(262145 + AFCCooldownTunables[2], 180000)
                    SET_INT_GLOBAL(262145 + AFCCooldownTunables[3], 240000)
                    SET_INT_GLOBAL(262145 + AFCCooldownTunables[4], 60000)
                    SET_INT_GLOBAL(262145 + AFCCooldownTunables[5], 2000)
                end)

            ---

            menu.divider(TUNABLES_CD, TRANSLATE("Others"))

                SLWCooldownTunables = {
                    memory.tunable_offset(9960150),
                    memory.tunable_offset(-312420223),
                }
                menu.toggle_loop(TUNABLES_CD, TRANSLATE("Spin Lucky Wheel"), {}, "", function() -- https://www.unknowncheats.me/forum/3531489-post51.html
                    STAT_SET_INT("LUCKY_WHEEL_NUM_SPIN", 0)
                    SET_INT_GLOBAL(262145 + SLWCooldownTunables[1], 1)
                    SET_INT_GLOBAL(262145 + SLWCooldownTunables[2], 1)
                end)

                CeoVehCooldownTunables = {
                    memory.tunable_offset("GB_CALL_VEHICLE_COOLDOWN"),
                }
                menu.toggle_loop(TUNABLES_CD, TRANSLATE("CEO Vehicles"), {}, "", function()
                    SET_INT_GLOBAL(262145 + CeoVehCooldownTunables[1], 0)
                end, function()
                    SET_INT_GLOBAL(262145 + CeoVehCooldownTunables[1], 120000)
                end)

                CJCooldownTunables = {
                    memory.tunable_offset(-926426916),
                    memory.tunable_offset(1733390598),
                    memory.tunable_offset(724724668),
                    memory.tunable_offset(846317886),
                    memory.tunable_offset(443623246),
                    memory.tunable_offset(-1203647122),
                    memory.tunable_offset(-1963126951),
                }
                menu.toggle_loop(TUNABLES_CD, TRANSLATE("Client Jobs"), {}, "", function()
                    SET_INT_GLOBAL(262145 + CJCooldownTunables[1], 0) -- Between Jobs
                    SET_INT_GLOBAL(262145 + CJCooldownTunables[2], 0) -- Robbery in Progress
                    SET_INT_GLOBAL(262145 + CJCooldownTunables[3], 0) -- Data Sweep
                    SET_INT_GLOBAL(262145 + CJCooldownTunables[4], 0) -- Targeted Data
                    SET_INT_GLOBAL(262145 + CJCooldownTunables[5], 0) -- Diamond Shopping
                    SET_INT_GLOBAL(262145 + CJCooldownTunables[6], 0) -- Collectors Pieces, https://www.unknowncheats.me/forum/3496393-post32.html
                    SET_INT_GLOBAL(262145 + CJCooldownTunables[7], 0) -- Deal Breaker, https://www.unknowncheats.me/forum/3496393-post32.html
                end, function()
                    SET_INT_GLOBAL(262145 + CJCooldownTunables[1], 300000)
                    SET_INT_GLOBAL(262145 + CJCooldownTunables[2], 1800000)
                    SET_INT_GLOBAL(262145 + CJCooldownTunables[3], 1800000)
                    SET_INT_GLOBAL(262145 + CJCooldownTunables[4], 1800000)
                    SET_INT_GLOBAL(262145 + CJCooldownTunables[5], 1800000)
                    SET_INT_GLOBAL(262145 + CJCooldownTunables[6], 600000)
                    SET_INT_GLOBAL(262145 + CJCooldownTunables[7], 600000)
                end)

                CWCooldownTunables = {
                    memory.tunable_offset("GB_COOLDOWN_UNTIL_NEXT_BOSS_WORK"),
                    memory.tunable_offset(1107909355),
                }
                menu.toggle_loop(TUNABLES_CD, TRANSLATE("Club Work"), {}, "", function()
                    SET_INT_GLOBAL(262145 + CWCooldownTunables[1], 0)
                    SET_INT_GLOBAL(262145 + CWCooldownTunables[2], 0)
                end, function()
                    SET_INT_GLOBAL(262145 + CWCooldownTunables[1], 300000)
                    SET_INT_GLOBAL(262145 + CWCooldownTunables[2], 180000)
                end)

                MBJCooldownTunables = {
                    memory.tunable_offset("VC_WORK_REQUEST_COOLDOWN"),
                }
                menu.toggle_loop(TUNABLES_CD, TRANSLATE("Ms Baker Job"), {}, "", function()
                    SET_INT_GLOBAL(262145 + MBJCooldownTunables[1], 0)
                end)

                EMGMCooldownTunables = {
                    memory.tunable_offset(972761388),
                }
                menu.toggle_loop(TUNABLES_CD, TRANSLATE("Export Mixed Goods Mission"), {}, "", function()
                    SET_INT_GLOBAL(262145 + EMGMCooldownTunables[1], 0)
                end)

                menu.toggle_loop(TUNABLES_CD, TRANSLATE("Yohan Nightclub Mission"), {}, "", function()
                    STAT_SET_INT("SOURCE_GOODS_CDTIMER", -1)
                    STAT_SET_INT("SOURCE_RESEARCH_CDTIMER", -1)
                end)

                menu.toggle_loop(TUNABLES_CD, TRANSLATE("Biker Bar Mission"), {}, "", function()
                    STAT_SET_INT("BIKER_BAR_RESUPPLY_CD_POSIX", -1)
                end)

                menu.toggle_loop(TUNABLES_CD, TRANSLATE("Dax Job"), {}, TRANSLATE("Note that Dax Job means from cellphone"), function() -- https://www.unknowncheats.me/forum/3629824-post2716.html
                    STAT_SET_INT("XM22JUGGALOWORKCDTIMER", -1)
                end)

            ---

        ---

        TUNABLES_MUT = menu.list(TUNABLES, TRANSLATE("Multipliers"), {}, "", function(); end)

            MUT_INPUT = menu.slider_float(TUNABLES_MUT, TRANSLATE("Multipliers"), {"hcmultiplier"}, "", 0, 720000, 100, 100, function(); end)

            menu.divider(TUNABLES_MUT, "XP & AP")

                XPnAPTunables = {
                    memory.tunable_offset("XP_MULTIPLIER"),
                    memory.tunable_offset("AP_MULTIPLIER"),
                }
                menu.toggle_loop(TUNABLES_MUT, "XP", {}, "", function()
                    SET_FLOAT_GLOBAL(262145 + XPnAPTunables[1], menu.get_value(MUT_INPUT) / 100)
                end, function()
                    SET_FLOAT_GLOBAL(262145 + XPnAPTunables[1], menu.get_default_state(MUT_INPUT))
                end)
                menu.toggle_loop(TUNABLES_MUT, "AP", {}, "", function()
                    SET_FLOAT_GLOBAL(262145 + XPnAPTunables[2], menu.get_value(MUT_INPUT) / 100)
                end, function()
                    SET_FLOAT_GLOBAL(262145 + XPnAPTunables[2], menu.get_default_state(MUT_INPUT))
                end)

            ---

            menu.divider(TUNABLES_MUT, TRANSLATE("LS Car Meet"))

                LSCMTunables = {
                    memory.tunable_offset("TUNER_STREET_RACE_PLACE_XP_MULTIPLIER"),
                    memory.tunable_offset("TUNER_PURSUIT_RACE_PLACE_XP_MULTIPLIER"),
                    memory.tunable_offset("TUNER_CHECKPOINT_RACE_PLACE_XP_MULTIPLIER"),
                    memory.tunable_offset("TUNER_HEADTOHEAD_RACE_PLACE_XP_MULTIPLIER"),
                    memory.tunable_offset("TUNER_CARCLUB_VISITS_STREAK_XP_MULTIPLIER"),
                    memory.tunable_offset("TUNER_CARCLUB_TIME_XP_MULTIPLIER"),
                }
                menu.toggle_loop(TUNABLES_MUT, TRANSLATE("Street Race"), {}, "", function()
                    SET_FLOAT_GLOBAL(262145 + LSCMTunables[1], menu.get_value(MUT_INPUT) / 100)
                end, function()
                    SET_FLOAT_GLOBAL(262145 + LSCMTunables[1], menu.get_default_state(MUT_INPUT))
                end)
                menu.toggle_loop(TUNABLES_MUT, TRANSLATE("Pursuit Race"), {}, "", function()
                    SET_FLOAT_GLOBAL(262145 + LSCMTunables[2], menu.get_value(MUT_INPUT) / 100)
                end, function()
                    SET_FLOAT_GLOBAL(262145 + LSCMTunables[2], menu.get_default_state(MUT_INPUT))
                end)
                menu.toggle_loop(TUNABLES_MUT, TRANSLATE("Scramble"), {}, "", function()
                    SET_FLOAT_GLOBAL(262145 + LSCMTunables[3], menu.get_value(MUT_INPUT) / 100)
                end, function()
                    SET_FLOAT_GLOBAL(262145 + LSCMTunables[3], menu.get_default_state(MUT_INPUT))
                end)
                menu.toggle_loop(TUNABLES_MUT, TRANSLATE("Head 2 Head"), {}, "", function()
                    SET_FLOAT_GLOBAL(262145 + LSCMTunables[4], menu.get_value(MUT_INPUT) / 100)
                end, function()
                    SET_FLOAT_GLOBAL(262145 + LSCMTunables[4], menu.get_default_state(MUT_INPUT))
                end)
                menu.toggle_loop(TUNABLES_MUT, TRANSLATE("LS Car Meet"), {}, "", function()
                    SET_FLOAT_GLOBAL(262145 + LSCMTunables[5], menu.get_value(MUT_INPUT) / 100)
                end, function()
                    SET_FLOAT_GLOBAL(262145 + LSCMTunables[5], menu.get_default_state(MUT_INPUT))
                end)
                menu.toggle_loop(TUNABLES_MUT, TRANSLATE("LS Car Meet's Track"), {}, "", function()
                    SET_FLOAT_GLOBAL(262145 + LSCMTunables[6], menu.get_value(MUT_INPUT) / 100) 
                end, function()
                    SET_FLOAT_GLOBAL(262145 + LSCMTunables[6], menu.get_default_state(MUT_INPUT))
                end)

            ---

        ---

        TUNABLES_OTH = menu.list(TUNABLES, TRANSLATE("Others"), {}, "", function(); end)

            MOSFHTunables = {
                memory.tunable_offset("PSANDQS_HEALTH_REPLENISH_MULTIPLIER"),
                memory.tunable_offset("EGOCHASER_HEALTH_REPLENISH_MULTIPLIER"),
                memory.tunable_offset("METEORITE_HEALTH_REPLENISH_MULTIPLIER"),
                memory.tunable_offset("REDWOOD_HEALTH_DEPLETE_MULTIPLIER"),
                memory.tunable_offset("ORANGOTANG_HEALTH_REPLENISH_MULTIPLIER"),
                memory.tunable_offset("BOURGEOIX_HEALTH_REPLENISH_MULTIPLIER"),
                memory.tunable_offset("SPRUNK_HEALTH_REPLENISH_MULTIPLIER"),
            }
            menu.toggle_loop(TUNABLES_OTH, TRANSLATE("Make One Snack Full Health"), {}, TRANSLATE("Whatever you use a snack, will make you full health."), function()
                for i = 1, 7 do
                    SET_FLOAT_GLOBAL(262145 + MOSFHTunables[i], 99999)
                end
            end, function()
                for i = 1, 7 do
                    SET_FLOAT_GLOBAL(262145 + MOSFHTunables[i], 1)
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

            ISHPTunables = {
                memory.tunable_offset("BB_HATCHET_RAMPAGE_DURATION_MAX"),
                memory.tunable_offset("BB_HATCHET_RAMPAGE_DURATION_EXTENSION"),
                memory.tunable_offset("BB_HATCHET_RAMPAGE_COOLDOWN"),
                memory.tunable_offset("BB_HATCHET_RAMPAGE_DAMAGE_RECIEVED"),
                memory.tunable_offset("BB_HATCHET_RAMPAGE_HEALTH_REGEN_RATE"),
                memory.tunable_offset("BB_HATCHET_RAMPAGE_HEALTH_REGEN_MAX"),
            }
            menu.toggle_loop(TUNABLES_OTH, TRANSLATE("Infinite Stone Hatchet's Power"), {}, "", function() -- https://www.unknowncheats.me/forum/3484239-post11.html
                SET_INT_GLOBAL(262145 + ISHPTunables[1], 99999) -- Duration
                SET_INT_GLOBAL(262145 + ISHPTunables[2], 99999) -- Added Duration per Kill
                SET_INT_GLOBAL(262145 + ISHPTunables[3], 0) -- Cooldown
                SET_FLOAT_GLOBAL(262145 + ISHPTunables[4], 99999) -- Weapon Defense
                SET_FLOAT_GLOBAL(262145 + ISHPTunables[5], 99999) -- Health Recharge Multiplier
                SET_FLOAT_GLOBAL(262145 + ISHPTunables[6], 99999) -- Health Recharge Limit
            end, function()
                SET_INT_GLOBAL(262145 + ISHPTunables[1], 12000)
                SET_INT_GLOBAL(262145 + ISHPTunables[2], 6000)
                SET_INT_GLOBAL(262145 + ISHPTunables[3], 60000)
                SET_FLOAT_GLOBAL(262145 + ISHPTunables[4], 0.5)
                SET_FLOAT_GLOBAL(262145 + ISHPTunables[5], 2)
                SET_FLOAT_GLOBAL(262145 + ISHPTunables[6], 1)
            end)

            menu.action(TUNABLES_OTH, TRANSLATE("Single MC Vehicle Sell"), {}, TRANSLATE("Forces the amount of MC Business' sale vehicles to one. Please click once before starting selling mission. Only works when you're the leader."), function()
                SET_INT_LOCAL("gb_biker_contraband_sell", 704 + 17, 0) -- https://github.com/Tgamer500/YiffWarePWLua/blob/main/YiffWarePW.lua
            end)
        
            menu.action(TUNABLES_OTH, TRANSLATE("7 Years GTA Online Playtime"), {}, TRANSLATE("Make your account look like you've played GTA Online for 7 years."), function()
                STAT_SET_INT("MP_PLAYING_TIME", 0)
                STAT_INCREMENT("MP_PLAYING_TIME", 60 * 60 * 24 * 365 * 7 * 1000)
                FORCE_CLOUD_SAVE()
            end)
            
        ---

        CUSTOM_MONEY_REMOVER = menu.slider(TUNABLES, TRANSLATE("Custom Money Remover"), {"hcmoneyremove"}, TRANSLATE("The best way to remove GTA Online banked money up to $2B at once!"), 0, 2000000000, 5000, 10000, function(Value)
            menu.show_warning(TUNABLES, CLICK_MENU, TRANSLATE("Do you sure remove your money?"), function()
                SET_INT_TUNABLE_GLOBAL(-156036296, Value) -- https://www.unknowncheats.me/forum/3276092-post3.html
                SET_PACKED_STAT_BOOL_CODE(15382, true) -- Makes able to buy the Ballistic Armor
                SET_PACKED_STAT_BOOL_CODE(9461, true) -- Makes you have the Ballistic Armor

                menu.trigger_commands("nopimenugrey on")
                if util.is_interaction_menu_open() then PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 244, 1) end
                SET_INT_GLOBAL(2711018, 85) -- Renders Ballistic Equipment Services screen of the Interaction Menu [[update]]
                PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 244, 1) -- Presses M
                PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 176, 1) -- Presses Enter
                NOTIFY(TRANSLATE("Because this feature works via requesting the Ballistic Armor, it'll be dropped nearby soon."))
            end, function()
                menu.focus(CUSTOM_MONEY_REMOVER)
                NOTIFY(TRANSLATE("Successfully cancelled!"))
            end)
        end)

    ---

    INSTANT_FINISH = menu.list(TOOLS, TRANSLATE("Instant Finish Heists & Others"), {"hcinsfin"}, "", function(); end)

        menu.divider(INSTANT_FINISH, TRANSLATE("Heists"))

            menu.action(INSTANT_FINISH, TRANSLATE("Cayo / Tuners / ULP / Agency"), {"hcinsfincp"}, TRANSLATE("Note that may works for some of other preps. Only 'Quick Preset' is compatible with Cayo Perico Heist."), function() -- https://www.unknowncheats.me/forum/3524081-post3.html
                menu.trigger_commands("scripthost")

                SET_INT_LOCAL("fm_mission_controller_2020", 52171, 9) -- 'fm_mission_controller_2020' instant finish variable? [[update]]
                SET_INT_LOCAL("fm_mission_controller_2020", 52171 + 1776 + 1, 50) -- 'fm_mission_controller_2020' instant finish variable? [[update]]
            end)

            menu.action(INSTANT_FINISH, TRANSLATE("Casino Aggressive / Classic"), {"hcinsfincah"}, TRANSLATE("Note that if you don't use Heist Control's automated Casino Heist presets, won't get money.") .. "\n\n" .. TRANSLATE("Instant finishing Pacific Standard heist won't work."), function()
                menu.trigger_commands("scripthost")
                
                -- [[update]]
                SET_INT_LOCAL("fm_mission_controller", 19781 + 1741, 80) -- Casino Aggressive Kills & Act 3
                SET_INT_LOCAL("fm_mission_controller", 19781 + 2686, 10000000) -- How much did you take in the casino and pacific standard heist
                SET_INT_LOCAL("fm_mission_controller", 27489 + 859 + 18, 99999) -- 'fm_mission_controller' instant finish variable? (possibly outdated)
                SET_INT_LOCAL("fm_mission_controller", 31656 + 69, 99999) -- 'fm_mission_controller' instant finish variable? (this is writing nonsense + possibly outdated)
            end)

            menu.action(INSTANT_FINISH, TRANSLATE("Doomsday"), {"hcinsfindooms"}, TRANSLATE("Note that you may press multiple times to instant finish the heist."), function()
                menu.trigger_commands("scripthost")

                -- [[update]]
                SET_INT_LOCAL("fm_mission_controller", 19781, 12) -- ???, 'fm_mission_controller' instant finish variable?
                SET_INT_LOCAL("fm_mission_controller", 19781 + 1741, 150) -- Casino Aggressive Kills & Act 3 1741 possibly outdated
                SET_INT_LOCAL("fm_mission_controller", 27489 + 859 + 18, 99999) -- 'fm_mission_controller' instant finish variable? (possibly outdated)
                SET_INT_LOCAL("fm_mission_controller", 31656 + 69, 99999) -- 'fm_mission_controller' instant finish variable? (this is writing nonsense + possibly outdated)
                SET_INT_LOCAL("fm_mission_controller", 31656 + 97, 80) -- Act 1 Kills? Seem not to work (this is writing nonsense + possibly outdated)
            end)
            
        ---

        menu.divider(INSTANT_FINISH, TRANSLATE("Others"))

            menu.action(INSTANT_FINISH, TRANSLATE("Bunker"), {"hcinsfinbk"}, TRANSLATE("(Selling Only)"), function() -- https://www.unknowncheats.me/forum/3521137-post39.html
                SET_INT_LOCAL("gb_gunrunning", 1262 + 774, 0) -- [[update]]
            end)

            menu.action(INSTANT_FINISH, TRANSLATE("Air Cargo"), {"hcinsfinac"}, TRANSLATE("(Selling Only)"), function() -- https://www.unknowncheats.me/forum/3513482-post37.html
                SET_INT_LOCAL("gb_smuggler", 1985 + 1035, GET_INT_LOCAL("gb_smuggler", 1934 + 1078)) -- [[update]]
            end)

            menu.action(INSTANT_FINISH, TRANSLATE("Acid Lab"), {"hcinsfinacid"}, TRANSLATE("(Selling Only)"), function() -- https://www.unknowncheats.me/forum/3641612-post76.html
                -- [[update]]
                SET_INT_LOCAL("fm_content_acid_lab_sell", 5653 + 1374 + 2, 9)
                SET_INT_LOCAL("fm_content_acid_lab_sell", 5653 + 1374 + 3, 10)
                SET_INT_LOCAL("fm_content_acid_lab_sell", 5653 + 1308, 2)
            end)

            menu.action(INSTANT_FINISH, TRANSLATE("Headhunter"), {"hcinsfinhh"}, "", function() -- Thanks to @stand.gg on Discord helping me code this
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

            menu.action(INSTANT_FINISH, TRANSLATE("Sightseer"), {"hcinsfinss"}, "", function() -- https://www.unknowncheats.me/forum/3488056-post24.html
                SET_INT_LOCAL("gb_sightseer", 256 + 1 + NETWORK.PARTICIPANT_ID_TO_INT() * 6 + 5, 3) -- [[update]]
            end)
            
        ---

    ---

    REMOTE_ACCESS = menu.list(TOOLS, TRANSLATE("Remote Access"), {"hcapp"}, TRANSLATE("Let you open remotely some of apps for missions.") .. "\n\n" .. TRANSLATE("Note that you don't have the app, some of functions won't work."), function(); end)

        menu.textslider(REMOTE_ACCESS, TRANSLATE("Bunker"), {"hcappbunker"}, "", {
            TRANSLATE("Open"),
            TRANSLATE("Close"),
        }, function()
            START_SCRIPT("appbunkerbusiness")
        end)
        menu.textslider(REMOTE_ACCESS, TRANSLATE("Air Cargo"), {"hcappaircargo"}, "", {
            TRANSLATE("Open"),
            TRANSLATE("Close"),
        }, function()
            START_SCRIPT("appsmuggler")
        end)
        menu.textslider(REMOTE_ACCESS, TRANSLATE("Nightclub"), {"hcappnightclub"}, "", {
            TRANSLATE("Open"),
            TRANSLATE("Close"),
        }, function()
            START_SCRIPT("appbusinesshub")
        end)
        menu.textslider(REMOTE_ACCESS, TRANSLATE("San Andreas Mercenaries Terminal"), {"hcappsanandreasmercenaries"}, "", {
            TRANSLATE("Open"),
            TRANSLATE("Close"),
        }, function()
            START_SCRIPT("appavengeroperations")
        end)
        menu.textslider(REMOTE_ACCESS, TRANSLATE("Agency"), {"hcappagency"}, TRANSLATE("Note that you don't have the app, some of functions won't work."), {
            TRANSLATE("Open"),
            TRANSLATE("Close"),
        }, function()
            START_SCRIPT("appfixersecurity")
        end)
        menu.action(REMOTE_ACCESS, TRANSLATE("The Open Road"), {"hcapptheopenroad"}, "(" .. TRANSLATE("Biker Business Management") .. ")", function()
            START_SCRIPT("appbikerbusiness")
        end)
        menu.action(REMOTE_ACCESS, TRANSLATE("Master Control Terminal"), {"hcappmastercontrol"}, "", function()
            START_SCRIPT("apparcadebusinesshub")
        end)
        menu.action(REMOTE_ACCESS, TRANSLATE("Touchscreen Terminal"), {"hcapptouchscreen"}, "(" .. TRANSLATE("Terrobyte") .. ")", function()
            START_SCRIPT("apphackertruck")
        end)

    ---

    COOLDOWN_TIMER = menu.list(TOOLS, TRANSLATE("Heist Cooldown Timers"), {"hctimer"}, TRANSLATE("There is cooldown time when after you do play any heists once. The cooldown time is 20 mins, so this let you know the time passed or not."), function(); end)

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

            menu.action(NEAR_PED_CAM, TRANSLATE("Shoot"), {"hcshootped"}, "", function() -- Thanks for coding this, @pedro9558 on Discord
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

    PRESET_STAT_EDITOR = menu.list(TOOLS, TRANSLATE("Preset Stat Editor"), {}, "", function(); end)

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

        CREW_LEVEL_EDITOR = menu.list(PRESET_STAT_EDITOR, TRANSLATE("Crew Level"), {}, "", function(); end)

            for i = 0, 4 do
                menu.divider(CREW_LEVEL_EDITOR, TRANSLATE("Crew") .. " " .. i)

                    CREW_RP = menu.readonly(CREW_LEVEL_EDITOR, TRANSLATE("Crew RP"))
                    CREW_ID = menu.readonly(CREW_LEVEL_EDITOR, TRANSLATE("Crew ID"))
                    CREW_CURRENT = menu.readonly(CREW_LEVEL_EDITOR, TRANSLATE("Current Crew Level"))
                    CREW_LEVEL = menu.slider(CREW_LEVEL_EDITOR, TRANSLATE("Choose Crew Level"), { "hccrewlevel" .. i }, "", 1, 8000, 1, 1, function(); end)
                    menu.action(CREW_LEVEL_EDITOR, TRANSLATE("Set Crew Level"), { "hcsetcrewlevel" .. i }, "", function()
                        local RpForRank = util.get_rp_required_for_rank(menu.get_value(CREW_LEVEL))
                        STAT_SET_INT("MPPLY_CREW_LOCAL_XP_" .. i, RpForRank)
                    end)

                    menu.set_value(CREW_RP, STAT_GET_INT("MPPLY_CREW_LOCAL_XP_" .. i))
                    menu.set_value(CREW_ID, STAT_GET_INT("MPPLY_CREW_" .. i .. "_ID"))
                    menu.set_value(CREW_CURRENT, STAT_GET_INT("MPPLY_CURRENT_CREW_RANK"))

                ---
            end

        ---

    ---

    GTAHAXUI_STAT_EDITOR = menu.list(TOOLS, TRANSLATE("GTAHaXUI Stat Editor"), {}, TRANSLATE("GTAHaXUI is a free mod menu for editing stats, globals, and locals from UnknownCheats. Heist Control can help you using customizable GTAHaXUI's stat txt files. Note that you can download the files by googling easily."), function(); end)

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
                                    local Stat = string.sub(file_content, i - 5, string.len(file_content))
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

    INFO_SPOOFING = menu.list(TOOLS, TRANSLATE("Stat Spoofing"), {}, TRANSLATE("Change your session to apply!"), function(); end)

        INFO_SPOOFING_WALLET_MONEY = menu.list(INFO_SPOOFING, TRANSLATE("Wallet Money"), {}, "", function(); end) -- freemode.c

            -- [[update]]
            menu.toggle_loop(INFO_SPOOFING_WALLET_MONEY, TRANSLATE("Enable"), {}, "", function()
                SET_INT_GLOBAL((1845221 + 1 + players.user() * 889) + 206 + 3, menu.get_value(WALLET_MONEY_SPOOFING))
            end, function()
                SET_INT_GLOBAL((1845221 + 1 + players.user() * 889) + 206 + 3, players.get_wallet(players.user()))
            end)

            WALLET_MONEY_SPOOFING = menu.slider(INFO_SPOOFING_WALLET_MONEY, TRANSLATE("Value"), {"hcwalletmoneyspoofing"}, "", INT_MIN, INT_MAX, players.get_wallet(players.user()), 10000, function(); end)

        --- 

        INFO_SPOOFING_MONEY = menu.list(INFO_SPOOFING, TRANSLATE("Total Money"), {}, "", function(); end) -- freemode.c

            -- [[update]]
            menu.toggle_loop(INFO_SPOOFING_MONEY, TRANSLATE("Enable"), {}, "", function()
                SET_INT_GLOBAL((1845221 + 1 + players.user() * 889) + 206 + 56, menu.get_value(TOTAL_MONEY_SPOOFING))
            end, function()
                SET_INT_GLOBAL((1845221 + 1 + players.user() * 889) + 206 + 56, players.get_money(players.user()))
            end)

            TOTAL_MONEY_SPOOFING = menu.slider(INFO_SPOOFING_MONEY, TRANSLATE("Value"), {"hctotalmoneyspoofing"}, "", INT_MIN, INT_MAX, players.get_bank(players.user()), 10000, function(); end)

        ---

        INFO_SPOOFING_KILL = menu.list(INFO_SPOOFING, TRANSLATE("Kills"), {}, "", function(); end) -- freemode.c

            -- [[update]]
            menu.toggle_loop(INFO_SPOOFING_KILL, TRANSLATE("Enable"), {}, "", function()
                SET_INT_GLOBAL((1845221 + 1 + players.user() * 889) + 206 + 28, menu.get_value(KILL_SPOOFING))
            end, function()
                SET_INT_GLOBAL((1845221 + 1 + players.user() * 889) + 206 + 28, players.get_kills(players.user()))
            end)

            KILL_SPOOFING = menu.slider(INFO_SPOOFING_KILL, TRANSLATE("Value"), {"hckillspoofing"}, "", INT_MIN, INT_MAX, players.get_kills(players.user()), 1, function(); end)

        ---

        INFO_SPOOFING_DEATH = menu.list(INFO_SPOOFING, TRANSLATE("Deaths"), {}, "", function(); end)

            -- [[update]]
            menu.toggle_loop(INFO_SPOOFING_DEATH, TRANSLATE("Enable"), {}, "", function() -- freemode.c
                SET_INT_GLOBAL((1845221 + 1 + players.user() * 889) + 206 + 29, menu.get_value(DEATH_SPOOFING))
            end, function()
                SET_INT_GLOBAL((1845221 + 1 + players.user() * 889) + 206 + 29, players.get_deaths(players.user()))
            end)

            DEATH_SPOOFING = menu.slider(INFO_SPOOFING_DEATH, TRANSLATE("Value"), {"hcdeathspoofing"}, "", INT_MIN, INT_MAX, players.get_deaths(players.user()), 1, function(); end)

        ---

    ---

    TOOLS_OTH = menu.list(TOOLS, TRANSLATE("Others"), {}, "", function(); end)

        menu.toggle_loop(TOOLS_OTH, TRANSLATE("Disable Transaction Errors"), {"hcnotransactionerr"}, "", function()
            if not util.is_session_started() then return end

            if GET_INT_GLOBAL(4538095) == 4 or GET_INT_GLOBAL(4538095) == 20 then -- [[update]]
                SET_INT_GLOBAL(4538089, 0) -- https://github.com/jonaaa20/RecoverySuite [[update]]
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
util.yield()

    menu.divider(INFOS, TRANSLATE("Language"))

        HC_LANG = menu.list_action(INFOS, TRANSLATE("Language") .. ": " .. READ_SETTING("Language"), {"hclang"}, "", {
            { 1, "Custom", {"custom"}, "" },
            { 2, "Chinese - 中文", {"chinese"}, "" },
            { 3, "English", {"english"}, "" },
            { 4, "French - français", {"french"}, "" },
            { 5, "German - Deutsch", {"german"}, "" },
            { 6, "Italian - Italiano", {"italian"}, "" },
            { 7, "Japanese - 日本語", {"japanese"}, "" },
            { 8, "Korean - 한국어", {"korean"}, "Using this language without the preset font will cause the situation that almost of characters are broken." .. "\n\n" .. "Please enter this command on Command Box: 'presetfont nanumgothic'" },
            { 9, "Polish - Polski", {"polish"}, "" },
            { 10, "Portuguese - Português", {"portuguese"}, "" },
            { 11, "Russian - русский", {"russian"}, "" },
            { 12, "Spanish - Español", {"spanish"}, "" },
            { 13, "Vietnamese - Tiếng Việt", {"vietnamese"}, "Using this language without the preset font will cause the situation that almost of characters are broken." .. "\n\n" .. "Please enter this command on Command Box: 'presetfont bevietnamprolight'"},
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
                    { 1, TRANSLATE("HC Logo"), {}, "" },
                    { 2, TRANSLATE("Lester"), {}, "" },
                    { 3, TRANSLATE("Legend Of Heist"), {}, "" }, 
                    { 4, TRANSLATE("Skull Head"), {}, "" },
                    { 5, TRANSLATE("Warstock"), {}, "" },
                    { 6, TRANSLATE("Black R*"), {}, "" },
                    { 7, TRANSLATE("R* Social Club"), {}, "" },
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
                    { 1, TRANSLATE("White"), {}, "" },
                    { 2, TRANSLATE("Black"), {}, "" },
                    { 3, TRANSLATE("Red"), {}, "" },
                    { 4, TRANSLATE("Orange"), {}, "" },
                    { 5, TRANSLATE("Yellow"), {}, "" },
                    { 6, TRANSLATE("Mint"), {}, "" },
                    { 7, TRANSLATE("Green"), {}, "" },
                    { 8, TRANSLATE("Light Blue"), {}, "" },
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
            { 1, "Stand", {}, "" }, 
            { 2, TRANSLATE("Black"), {}, "" },
            { 3, TRANSLATE("White"), {}, "" },
            { 4, TRANSLATE("Red"), {}, "" },
            { 5, TRANSLATE("Orange"), {}, "" },
            { 6, TRANSLATE("Yellow"), {}, "" },
            { 7, TRANSLATE("Mint"), {}, "" }, 
            { 8, TRANSLATE("Green"), {}, "" },
            { 9, TRANSLATE("Light Blue"), {}, "" },
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

        menu.hyperlink(INFOS, TRANSLATE("Join Discord Server!"), "https://discord.gg/KTFAYQn5Xz", TRANSLATE("If you have any questions regarding Heist Control? Joining it will help you so much!") .. "\n\n" .. TRANSLATE("- Download sharable customized translations and GTAHaXUI stat files.") .. "\n" .. TRANSLATE("- Post a suggestion or an issue to improve Heist Control."))
        menu.hyperlink(INFOS, TRANSLATE("Changelog"), "https://github.com/calamity-inc/Stand-Heist-Control", TRANSLATE("If you want to know what was changed in the latest version, click me!"))

    ---

---



--- Others

    if READ_SETTING("Saved Command Name") ~= "N/A" then
        menu.trigger_commands(READ_SETTING("Saved Command Name"))
        WRITE_SETTING("Saved Command Name", "N/A")
    end

    menu.trigger_commands("hcnotransactionerr")

    HCTimerSettingChildren = menu.get_children(TIMER_SETTING)
    for _, child in pairs(HCTimerSettingChildren) do
        menu.link(TIMER_COLOR_HC, child)
    end

    ForCayoPresets = { -- { command_ref, default_help_text }
        {
            { CP_REM_FEE, "" },
        },
        {
            { CP_NON_HOST_CUT, "(%)" },
            { CP_NON_HOST_CUT_LOOP, "" },     
        },
        {
            { CP_HOST_CUT, "(%)" },
            { CP_HOST_CUT_LOOP, "" },
        },
        {
            { CP_2P_CUT, "(%)" },
            { CP_2P_CUT_LOOP, "" },
        },
        {
            { CP_3P_CUT, "(%)" },
            { CP_3P_CUT_LOOP, "" },
        },
        {
            { CP_4P_CUT, "(%)" },
            { CP_4P_CUT_LOOP, "" },
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
        { CAH_NON_HOST_CUT_LOOP, false, "" },
        { CAH_HOST_CUT, 60, "(%)" },
        { CAH_HOST_CUT_LOOP, true, "" },
        { CAH_2P_CUT, 147, "(%)" },
        { CAH_2P_CUT_LOOP, true, "" },
        { CAH_3P_CUT, 147, "(%)" },
        { CAH_3P_CUT_LOOP, true, "" },
        { CAH_4P_CUT, 147, "(%)" },
        { CAH_4P_CUT_LOOP, true, "" },
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
        { DOOMS_NON_HOST_CUT_LOOP, "" },
        { DOOMS_HOST_CUT, "(%)" },
        { DOOMS_HOST_CUT_LOOP, "" },
        { DOOMS_2P_CUT, "(%)" },
        { DOOMS_2P_CUT_LOOP, "" },
        { DOOMS_3P_CUT, "(%)" },
        { DOOMS_3P_CUT_LOOP, "" },
        { DOOMS_4P_CUT, "(%)" },
        { DOOMS_4P_CUT_LOOP, "" },
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