--[[

    Developed and maintenanced by IceDoomfist#0001: https://icedoomfist.com/My_Profile/
    Stand Heist Control is based by Heist Control V2 & Master Unlocker Lua Scripts for 2T1
    Thanks to allow me to use your code, jhowkNx: https://github.com/jhowkNx
    We're keeping connecion friendly, and sharing info like stats, global or local variables and codes each other.

    Almost global, local variables and stats from jhowNx and UnknownCheats: https://www.unknowncheats.me/forum/grand-theft-auto-v/
    Note that this lua script contains code from other lua scripts & public menus.
    I tried to credit all, if something is missed, really sorry about that.
    This script is only compatible with Stand Lua API: https://stand.gg/help/lua-api-documentation
    I don't guarantee this script will work with other menus' Lua API.

    Except almost global, local variables and stats, ALL coded by me except credited one. You should credit me to use.

]]--


--- Lua Script Settings

    --- Important

        local HCVersion = "V 3.0.9"
        local BasedGTAO = 1.64

    ---

    --- Directory Settings

        HCFolderDir = filesystem.scripts_dir() .. "/baibaiScript/" .. '/Heist Control/'
        local ImgFolderDir = HCFolderDir .. "Image\\"
        local SettingFolderDir = HCFolderDir .. "Setting\\"
        local LangFolderDir = HCFolderDir .. "Language\\"

        local SettingDir = SettingFolderDir .. "Setting.txt"
        local LogDir = SettingFolderDir .. "Log.txt"

        local ChineseDir = LangFolderDir .. "Chinese.txt"
        local EnglishDir = LangFolderDir .. "English.txt"
        local FrenchDir = LangFolderDir .. "French.txt"
        local GermanDir = LangFolderDir .. "German.txt"
        local JapaneseDir = LangFolderDir .. "Japanese.txt"
        local KoreanDir = LangFolderDir .. "Korean.txt"
        local PortugueseDir = LangFolderDir .. "Portuguese.txt"
        local RussianDir = LangFolderDir .. "Russian.txt"
        local SpanishDir = LangFolderDir .. "Spanish.txt"
            
    ---

    --- Core Functions

        function IS_MPPLY(Stat)
            local Stats = {
                "MP_PLAYING_TIME",
                "MP_NGDLCPSTAT_INT0",
            }

            for i = 1, #Stats do
                if Stat == Stats[i] then
                    return true
                end
            end

            if string.find(Stat, "MPPLY_") then
                return true
            else
                return false
            end
        end
        function ADD_MP_INDEX(Stat)
            if not IS_MPPLY(Stat) then
                Stat = "MP" .. util.get_char_slot() .. "_" .. Stat
            end
            return Stat
        end

        function STAT_SET_INT(Stat, Value)
            STATS.STAT_SET_INT(util.joaat(ADD_MP_INDEX(Stat)), Value, true)
        end
        function STAT_SET_FLOAT(Stat, Value)
            STATS.STAT_SET_FLOAT(util.joaat(ADD_MP_INDEX(Stat)), Value, true)
        end
        function STAT_SET_BOOL(Stat, Value)
            STATS.STAT_SET_BOOL(util.joaat(ADD_MP_INDEX(Stat)), Value, true)
        end
        function STAT_SET_STRING(Stat, Value)
            STATS.STAT_SET_STRING(util.joaat(ADD_MP_INDEX(Stat)), Value, true)
        end
        function STAT_SET_DATE(Stat, Year, Month, Day, Hour, Min)
            local DatePTR = memory.alloc(7*8) -- Thanks to help memory stuffs, aaronlink127#0127
            memory.write_int(DatePTR, Year)
            memory.write_int(DatePTR+8, Month)
            memory.write_int(DatePTR+16, Day)
            memory.write_int(DatePTR+24, Hour)
            memory.write_int(DatePTR+32, Min)
            memory.write_int(DatePTR+40, 0) -- Second
            memory.write_int(DatePTR+48, 0) -- Millisecond
            STATS.STAT_SET_DATE(util.joaat(ADD_MP_INDEX(Stat)), DatePTR, 7, true)
        end

        function STAT_SET_MASKED_INT(Stat, Value1, Value2)
            STATS.STAT_SET_MASKED_INT(util.joaat(ADD_MP_INDEX(Stat)), Value1, Value2, 8, true)
        end
        function STAT_SET_PACKED_BOOL(Stat, Value)
            STATS.SET_PACKED_STAT_BOOL_CODE(Stat, Value, util.get_char_slot())
        end
        function STAT_SET_INCREMENT(Stat, Value)
            STATS.STAT_INCREMENT(util.joaat(ADD_MP_INDEX(Stat)), Value, true)
        end

        function STAT_GET_INT(Stat)
            local IntPTR = memory.alloc_int()
            STATS.STAT_GET_INT(util.joaat(ADD_MP_INDEX(Stat)), IntPTR, -1)
            return memory.read_int(IntPTR)
        end
        function STAT_GET_FLOAT(Stat)
            local FloatPTR = memory.alloc_int()
            STATS.STAT_GET_FLOAT(util.joaat(ADD_MP_INDEX(Stat)), FloatPTR, -1)
            return tonumber(string.format("%.3f", memory.read_float(FloatPTR)))
        end
        function STAT_GET_BOOL(Stat)
            if STAT_GET_INT(Stat) == 0 then
                return "false"
            elseif STAT_GET_INT(Stat) == 1 then
                return "true"
            else
                return "STAT_UNKNOWN"
            end 
        end
        function STAT_GET_STRING(Stat)
            return STATS.STAT_GET_STRING(util.joaat(ADD_MP_INDEX(Stat)), -1)
        end
        function STAT_GET_DATE(Stat, Sort)
            local DatePTR = memory.alloc(7*8)
            STATS.STAT_GET_DATE(util.joaat(ADD_MP_INDEX(Stat)), DatePTR, 7, true)
            local Add = 0
            if Sort == "Year" then
                Add = 0
            elseif Sort == "Month" then
                Add = 8
            elseif Sort == "Days" then
                Add = 16
            elseif Sort == "Hours" then
                Add = 24
            elseif Sort == "Mins" then
                Add = 32
            end
            return memory.read_int(DatePTR+Add)
        end

        function SET_INT_GLOBAL(Global, Value)
            memory.write_int(memory.script_global(Global), Value)
        end
        function SET_FLOAT_GLOBAL(Global, Value)
            memory.write_float(memory.script_global(Global), Value)
        end

        function GET_INT_GLOBAL(Global)
            return memory.read_int(memory.script_global(Global))
        end

        function SET_PACKED_INT_GLOBAL(StartGlobal, EndGlobal, Value)
            for i = StartGlobal, EndGlobal do
                SET_INT_GLOBAL(262145 + i, Value)
            end
        end

        function SET_INT_LOCAL(Script, Local, Value)
            if memory.script_local(Script, Local) ~= 0 then
                memory.write_int(memory.script_local(Script, Local), Value)
            end
        end
        function SET_FLOAT_LOCAL(Script, Local, Value)
            if memory.script_local(Script, Local) ~= 0 then
                memory.write_float(memory.script_local(Script, Local), Value)
            end
        end

        function GET_INT_LOCAL(Script, Local)
            if memory.script_local(Script, Local) ~= 0 then
                local Value = memory.read_int(memory.script_local(Script, Local))
                if Value ~= nil then
                    return Value
                end
            end
        end

    ---

    --- Native and Folders


        AllFolders = {
            HCFolderDir,
            ImgFolderDir,
            SettingFolderDir,
            LangFolderDir,
        }
        for i = 1, #AllFolders do
            if not filesystem.exists(AllFolders[i]) then
                filesystem.mkdir(AllFolders[i])
            end
        end

    ---

    --- Settings for HC

        Settings = { -- Setting sorts
            "Language",
            "Notification Sort",
            "Notification Icon",
            "Notification Color",
            "Timer Color",
        }

        if not filesystem.exists(SettingDir) then -- Default setting values
            util.write_colons_file(SettingDir, {
                "Unknown",
                "Stand",
                "HC Logo",
                "Black",
                "White",
            })
        end

        function READ_SETTING(Sort)
            for i = 1, #Settings do
                if Sort == Settings[i] then
                    return util.read_colons_and_tabs_file(SettingDir)[tostring(i)]
                end
            end
        end

        function WRITE_SETTING(Sort, Value)
            local FinalSettings = {}
            for i = 1, #Settings do
                if Sort == Settings[i] then
                    FinalSettings[#FinalSettings+1] = Value
                else
                    FinalSettings[#FinalSettings+1] = READ_SETTING(Settings[i])
                end
            end

            util.write_colons_file(SettingDir, {
                FinalSettings[1],
                FinalSettings[2],
                FinalSettings[3],
                FinalSettings[4],
                FinalSettings[5],
            })
        end

    ---

    --- Log Functions

        if not filesystem.exists(LogDir) then
            local open = io.open(LogDir, "w+")
            open:write("")
            open:close()
        end
        function LOG(Message)
            local open = io.open(LogDir, "a+")
            open:write(os.date("[%m/%d/%Y %I:%M:%S %p]") .. " " .. Message .. "\n")
            open:close()
        end
        
        function ERROR_LOG(ErrorMsg)
            LOG("Heist Control Version: " .. HCVersion)
            LOG("[Heist Control - ERROR] " .. ErrorMsg .. "\n")
            util.toast("[ Heist Control - ERROR ]" .. "\n\n" .. ErrorMsg)
            util.yield()
            util.stop_script()
        end

    ---

    --- Language Settings

        if READ_SETTING("Language") == "Unknown" then -- When execute HC for first time
            if lang.get_current() == "zh" then
                WRITE_SETTING("Language", "Chinese - 中文")
            elseif lang.get_current() == "fr" then
                WRITE_SETTING("Language", "French - français")
            elseif lang.get_current() == "de" then
                WRITE_SETTING("Language", "German - Deutsch")
            elseif lang.get_current() == "ko" then
                WRITE_SETTING("Language", "Korean - 한국어")
            elseif lang.get_current() == "pt" then    
                WRITE_SETTING("Language", "Portuguese - Português")
            elseif lang.get_current() == "ru" then
                WRITE_SETTING("Language", "Russian - русский")
            elseif lang.get_current() == "es" then
                WRITE_SETTING("Language", "Spanish - Español")
            else
                WRITE_SETTING("Language", "English")
            end
        end

        function TO_LANG_NAME(LanguageDir)
            local i, j = string.find(LanguageDir, "Language\\")
            local k, l = string.find(LanguageDir, ".txt")
            return string.sub(LanguageDir, j + 1, k - 1)
        end
        TranslationDirs = {
            ChineseDir,
            EnglishDir,
            FrenchDir,
            GermanDir,
            JapaneseDir,
            KoreanDir,
            PortugueseDir,
            RussianDir,
            SpanishDir,
        }
        function LOAD_LANG(Dir)
            for i = 1, #TranslationDirs do
                if Dir == TranslationDirs[i] then
                    if filesystem.exists(Dir) then
                        SelectedLangDir = Dir
                    else
                        ERROR_LOG(TO_LANG_NAME(TranslationDirs[i]) .. " language file for HC doesn't exist." .. "\n\n" .. "Please install HC properly again!")
                    end
                end
            end
        end

        LOAD_LANG(EnglishDir)
        
        if READ_SETTING("Language") == "Chinese - 中文" then
            LOAD_LANG(ChineseDir)
        elseif READ_SETTING("Language") == "French - français" then
            LOAD_LANG(FrenchDir)
        elseif READ_SETTING("Language") == "German - Deutsch" then
            LOAD_LANG(GermanDir)
        elseif READ_SETTING("Language") == "Japanese - 日本語" then
            LOAD_LANG(JapaneseDir)
        elseif READ_SETTING("Language") == "Korean - 한국어" then
            LOAD_LANG(KoreanDir)
        elseif READ_SETTING("Language") == "Portuguese - Português" then
            LOAD_LANG(PortugueseDir)
        elseif READ_SETTING("Language") == "Russian - русский" then
            LOAD_LANG(RussianDir)
        elseif READ_SETTING("Language") == "Spanish - Español" then
            LOAD_LANG(SpanishDir)
        else
            WRITE_SETTING("Language", "English")
        end

    ---

    --- Translation Settings

        local Texts = {}
        local open = io.open(SelectedLangDir, "r+")
        for i in open:lines() do
            table.insert(Texts, i)
        end
        open:close()

        function TRANSLATE(Text)
            local Translation = ""
            for i = 1, #Texts do
                local j, k = string.find(Texts[i], " = ")
                if k ~= nil then
                    if not string.find(Texts[i], "#") then
                        Translation = string.sub(Texts[i], k + 1)
                    end
                end
                
                if Translation ~= "" then
                    if Texts[i] == Text .. " = " .. Translation then
                        return Translation
                    elseif i == #Texts then
                        return Text
                    end 
                end 
            end
        end

    ---

    --- Other Functions

        function SHOW_IMG(ImgName, MaxPassedTime) -- Credit goes to LanceScript-reloaded
            if filesystem.exists(ImgFolderDir .. ImgName) then
                local Img = directx.create_texture(ImgFolderDir .. ImgName)

                local ImgAlpha = 0
                local IncreasedImgAlpha = 0.01
        
                local StartedTime = os.clock()
                util.create_tick_handler(function()
                    ImgAlpha = ImgAlpha + IncreasedImgAlpha
                    if ImgAlpha > 1 then
                        ImgAlpha = 1
                    elseif ImgAlpha < 0 then 
                        ImgAlpha = 0
                        return false
                    end
                end)
        
                util.create_tick_handler(function()
                    directx.draw_texture(Img, 0.07, 0.07, 0.5, 0.5, 0.5, 0.5, 0, 1, 1, 1, ImgAlpha)
                    local PassedTime = os.clock() - StartedTime
                    if PassedTime > MaxPassedTime then
                        IncreasedImgAlpha = -0.01
                    end
                    if ImgAlpha == 0 then
                        return false
                    end
                end)
            end
        end

        function TELEPORT(X, Y, Z)
            PED.SET_PED_COORDS_KEEP_VEHICLE(players.user_ped(), X, Y, Z)
        end
        function SET_HEADING(Heading)
            ENTITY.SET_ENTITY_HEADING(players.user_ped(), Heading)
        end

        function IS_WORKING(IsAddNewLine)
            local State = "" -- If global and local variables have been changed due to the GTAO update then
            local GTAO_VER = NETWORK.GET_ONLINE_VERSION()
            if util.is_session_started() then
                if GET_INT_LOCAL("freemode", 3618) ~= util.joaat("lr_prop_carkey_fob") then -- freemode.c, joaat("lr_prop_carkey_fob")
                    State = "[NOT WORKING]\n- This feature isn't working due to the latest GTA Online patch: " .. GTAO_VER .. ". Please download the lastest version of Heist Control or wait for Heist Control's developer patching."
                    if IsAddNewLine then
                        State = State .. "\n\n"
                    end
                end
            end
            return State
        end

        function RGB(R, G, B, A) -- Credit goes to LanceScript-reloaded
            local Color = {}
            Color.r = R
            Color.g = G
            Color.b = B
            Color.a = A
            return Color
        end

        function IS_HELP_MSG_DISPLAYED(Label) -- Credit goes to jerry123#4508
            HUD.BEGIN_TEXT_COMMAND_IS_THIS_HELP_MESSAGE_BEING_DISPLAYED(Label) -- Labels List: https://gist.githubusercontent.com/aaronlink127/afc889be7d52146a76bab72ede0512c7/raw
            return HUD.END_TEXT_COMMAND_IS_THIS_HELP_MESSAGE_BEING_DISPLAYED(0)
        end

        function IS_PED_PLAYER(Ped)
            if PED.GET_PED_TYPE(Ped) >= 4 then
                return false
            else
                return true
            end
        end

        function FORCE_CLOUD_SAVE()
            STATS.STAT_SAVE(0, 0, 3, 0) -- Same as menu.trigger_commands("forcecloudsave"), https://github.com/jonaaa20/RecoverySuite
            util.yield(1500)
            util.arspinner_enable()
            util.yield(4500)
            util.arspinner_disable()
        end

        function IA_MENU_OPEN_OR_CLOSE()
            PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 244, 1)
            util.yield(200)
        end
        function IA_MENU_UP(Num)
            for i = 1, Num do
                PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 172, 1)
                util.yield(200)
            end
        end
        function IA_MENU_DOWN(Num)
            for i = 1, Num do
                PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 173, 1)
                util.yield(200)
            end
        end
        function IA_MENU_ENTER(Num)
            for i = 1, Num do
                PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 176, 1)
                util.yield(200)
            end
        end

    ---

    --- Notification Settings

        local NotiIcon, NotiColor = "Logo", 140
        if filesystem.exists(ImgFolderDir .. "Logo.ytd") then
            util.register_file(ImgFolderDir .. "Logo.ytd")
        else
            if READ_SETTING("Notification Sort") == "In-Game" and READ_SETTING("Notification Icon") == "HC Logo" then
                ERROR_LOG("HC Logo for In-Game notification doesn't exist." .. "\n\n" .. "How to fix: Install HC via Heist Control Installer.exe")
            end
        end

        local NotiIconSorts = {
            { "HC Logo", "Logo" },
            { "Lester" , "CHAR_LESTER" },
            { "Legend Of Heist", "CHAR_ALL_PLAYERS_CONF" },
            { "Skull Head", "CHAR_LESTER_DEATHWISH" },
            { "Warstock", "CHAR_MILSITE" },
            { "Black R*", "CHAR_MP_FM_CONTACT" },
            { "R* Social Club", "CHAR_SOCIAL_CLUB" },   
        }
        local NotiColorSorts = {
            { "White", 160 },
            { "Black", 140 },
            { "Red", 6 },
            { "Orange", 130 },
            { "Yellow", 180 },
            { "Mint", 200 },
            { "Green", 184 },
            { "Light Blue", 40 },
        }
        function NOTIFY(Message)
            LOG(Message)

            for i = 1, #NotiIconSorts do
                if READ_SETTING("Notification Icon") == NotiIconSorts[i][1] then
                    NotiIcon = NotiIconSorts[i][2]
                    break
                elseif i == #NotiIconSorts then
                    WRITE_SETTING("Notification Icon", NotiIconSorts[1][1])
                    NotiIcon = NotiIconSorts[1][2]
                end
            end
            
            for i = 1, #NotiColorSorts do
                if READ_SETTING("Notification Color") == NotiColorSorts[i][1] then
                    NotiColor = NotiColorSorts[i][2]
                    break
                elseif i == #NotiColorSorts then
                    WRITE_SETTING("Notification Color", NotiColorSorts[1][1])
                    NotiColor = NotiColorSorts[1][2]
                end 
            end

            if READ_SETTING("Notification Sort") == "Stand" then
                util.toast("[ " .. TRANSLATE("Heist Control") .. " ]" .. "\n\n" .. Message)
            elseif READ_SETTING("Notification Sort") == "In-Game" then
                if util.is_session_started() then -- Credit goes to WiriScript
                    GRAPHICS.REQUEST_STREAMED_TEXTURE_DICT(NotiIcon, 1)
                    while not GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED(NotiIcon) do
                        util.yield()
                    end
                    util.BEGIN_TEXT_COMMAND_THEFEED_POST(Message)
                    HUD.THEFEED_SET_BACKGROUND_COLOR_FOR_NEXT_POST(NotiColor)
                    HUD.END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT(NotiIcon, NotiIcon, true, 1, TRANSLATE("Heist Control"), "~c~" .. TRANSLATE("Notification"))
                    HUD.END_TEXT_COMMAND_THEFEED_POST_TICKER(true, false)
                else
                    util.toast("[ " .. TRANSLATE("Heist Control") .. " - SP ]" .. "\n\n" .. Message)
                end
            elseif READ_SETTING("Notification Sort") == "No Notification" then
                -- Nothing Do
            else 
                WRITE_SETTING("Notification Sort", "Stand")
                util.toast("[ " .. TRANSLATE("Heist Control") .. " ]" .. "\n\n" .. Message)
            end
        end

    ---

    --- General Settings


        INT_MIN = -2147483648
        INT_MAX = 2147483647


        util.keep_running()



        local PERICO_HEIST = menu.list(Heist_Control, TRANSLATE("Cayo Perico Heist"), {"hccp"}, "", function();  end)
        local CASINO_HEIST = menu.list(Heist_Control, TRANSLATE("Diamond Casino Heist"), {"hccah"}, "", function(); end)
        local DOOMS_HEIST = menu.list(Heist_Control, TRANSLATE("Doomsday Heist"), {"hcdooms"}, "", function(); end)
        local CLASSIC_HEISTS = menu.list(Heist_Control, TRANSLATE("Classic Heist"), {"hcclassic"}, "", function(); end)
        local LS_ROBBERY = menu.list(Heist_Control, TRANSLATE("LS Tuners Robbery"), {"hcls"}, "", function(); end)
        local ULP_MISSIONS = menu.list(Heist_Control, TRANSLATE("ULP Missions"), {"hculp"}, "", function(); end)
        local TH_CONTRACT = menu.list(Heist_Control, TRANSLATE("The Contract: Agency"), {"hcagc"}, "", function(); end)
        local makemoneyfast = menu.list(Heist_Control, "代练选项")
        local autocayosolo = menu.list(makemoneyfast, "全自动单人上岛")
        local autocayomult = menu.list(makemoneyfast, "全自动多人上岛")
        local autocasinoheist = menu.list(makemoneyfast, "全自动多人赌场")
        local autodommsheist = menu.list(makemoneyfast, "全自动多人末日") 
        local auto_cayo_bot = menu.list(makemoneyfast, "全自动上岛机器人") 
        local MASTER_UNLOCKR = menu.list(Heist_Control, TRANSLATE("Master Unlocker"), {"hcmu"}, "", function(); end)
        local TOOLS = menu.list(Heist_Control, TRANSLATE("Tools"), {"hctool"}, "", function(); end)
        local INFOS = menu.list(Heist_Control, TRANSLATE("Settings And About HC"), {"hcinfo"}, "", function(); end)

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
            SET_INT_GLOBAL(1977693 + 823 + 56 + 1, 135)
            SET_INT_GLOBAL(1977693 + 823 + 56 + 2, 135)
            SET_INT_GLOBAL(1977693 + 823 + 56 + 3, 135)
            SET_INT_GLOBAL(1977693 + 823 + 56 + 4, 135)
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
            SET_INT_GLOBAL(1977693 + 823 + 56 + 1, 135)
            SET_INT_GLOBAL(1977693 + 823 + 56 + 2, 135)
            SET_INT_GLOBAL(1977693 + 823 + 56 + 3, 135)
            SET_INT_GLOBAL(1977693 + 823 + 56 + 4, 135)
            STAT_SET_INT("H4_PLAYTHROUGH_STATUS", 5)
        ;  end)
        
        menu.action(autocayomult, "[频繁上岛保护]全员135%分红 你0%", {}, "", function()
            SET_INT_GLOBAL(1977693 + 823 + 56 + 1, 0)
            SET_INT_GLOBAL(1977693 + 823 + 56 + 2, 135)
            SET_INT_GLOBAL(1977693 + 823 + 56 + 3, 135)
            SET_INT_GLOBAL(1977693 + 823 + 56 + 4, 135)
            STAT_SET_INT("H4_PLAYTHROUGH_STATUS", 5)
        ;  end)
        
        menu.action(autocayomult, "一键完成任务", { "hcinsfincp" }, IS_WORKING(false) .. ""
            , function()
                menu.trigger_commands("scripthost")
    
                SET_INT_LOCAL("fm_mission_controller_2020", 42279 + 1, 51338752)
                SET_INT_LOCAL("fm_mission_controller_2020", 42279 + 1375 + 1, 50)
        end)
        
        menu.divider(autocayomult, "~~~~~~~~~~~~~")
        
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
        
        menu.toggle(autocasinoheist, "气势汹汹", { "hccahdiaagg" }, IS_WORKING(true) .. TRANSLATE("选择低级买家!~~~~~请保持开启直至完成")
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

        
        menu.action(autocasinoheist, "一键完成任务", { "hcinsfincah" }, IS_WORKING(false), function()
            menu.trigger_commands("scripthost")
                    
            SET_INT_LOCAL("fm_mission_controller", 19707 + 1741, 151)
            SET_INT_LOCAL("fm_mission_controller", 19707 + 2686, 10000000)
            SET_INT_LOCAL("fm_mission_controller", 27471 + 859, 99999)
            SET_INT_LOCAL("fm_mission_controller", 31585 + 69, 99999)
            SET_INT_LOCAL("fm_mission_controller", 31585 + 97, 79)
        end)
        
        menu.divider(autocasinoheist, "~~~~~~~~~~~~~")
        
        menu.action(autocasinoheist, TRANSLATE("游戏厅车库门口"), {}, "", function()
            TELEPORT(-619.987, 282.960, 81.639)
        end)
        
        menu.toggle(autocasinoheist, TRANSLATE("兵不厌诈"), { "hccahgoldbig" }, IS_WORKING(true) .. TRANSLATE("选择低级买家!~~~~~请保持开启直至完成")
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
        
        menu.action(autodommsheist, "一键完成任务", { "hcinsfindooms" }, IS_WORKING(false), function()
            menu.trigger_commands("scripthost")
    
            SET_INT_LOCAL("fm_mission_controller", 19707, 12)
            SET_INT_LOCAL("fm_mission_controller", 28329 + 1, 99999)
            SET_INT_LOCAL("fm_mission_controller", 31585 + 69, 99999)
        end)
    

        menu.divider(auto_cayo_bot, TRANSLATE("Cooldown Time (Seconds)"))

        COOLDOWN_CAYO_BOT = menu.slider(auto_cayo_bot, TRANSLATE("Auto Cayo Bot"), {""}, "", 1200, 86400, 1200, 60, function(); end)



        menu.divider(auto_cayo_bot, TRANSLATE("Settings"))

        NumberOfPlayingCP = 100
        menu.slider(auto_cayo_bot, TRANSLATE("How many time to play Auto Cayo Bot"), {""}, "", 1, 100, 100, 1, function(Value)
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
        AUTO_CAYO_BOT = menu.toggle_loop(auto_cayo_bot, TRANSLATE("Auto Cayo Bot"), {}, IS_WORKING(true) .. TRANSLATE("Heist Control 将每 20 分钟自动完成一次 Solo Cayo Perico Heist，可获得 209 万美元。 不要按任何键以防止一些游戏错误。 "), function()

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




--- Cayo Perico Heist
    
    local CAYO_AUTO_PRST = menu.list(PERICO_HEIST, TRANSLATE("Automated Presets"), {}, TRANSLATE("- Remember to choose your preset before entering the Submarine") .. "\n\n" .. TRANSLATE("- Remember to deactivate the preset at the end."), function(); end)

        local AUTOMATED_SOLO = menu.list(CAYO_AUTO_PRST, TRANSLATE("1 Player"), {}, "", function(); end)

            menu.toggle_loop(AUTOMATED_SOLO, TRANSLATE("Sapphire Panther"), {"hccp1psp"}, IS_WORKING(false), function()
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
                menu.set_value(CP_REM_FEE, false)
                menu.set_value(CP_HOST_CUT, 100)
                menu.set_value(CP_HOST_CUT_LOOP, true)
            end, function()
                menu.set_value(CP_HOST_CUT, 100)
                menu.set_value(CP_HOST_CUT_LOOP, false)
            end)

            menu.toggle_loop(AUTOMATED_SOLO, TRANSLATE("Ruby Necklace"), {"hccp1prn"}, IS_WORKING(false), function()
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
                menu.set_value(CP_REM_FEE, false)
                menu.set_value(CP_HOST_CUT, 100)
                menu.set_value(CP_HOST_CUT_LOOP, true)
            end, function()
                menu.set_value(CP_HOST_CUT, 100)
                menu.set_value(CP_HOST_CUT_LOOP, false)
            end)

        ---

        local AUTOMATED_2P = menu.list(CAYO_AUTO_PRST, TRANSLATE("2 Players"), {}, "", function(); end)

            menu.toggle_loop(AUTOMATED_2P, TRANSLATE("Sapphire Panther"), {"hccp2psp"}, IS_WORKING(false), function()   
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
                menu.set_value(CP_REM_FEE, false)
                menu.set_value(CP_HOST_CUT, 50)
                menu.set_value(CP_HOST_CUT_LOOP, true)
                menu.set_value(CP_2P_CUT, 50)
                menu.set_value(CP_2P_CUT_LOOP, true)
            end, function()
                menu.set_value(CP_HOST_CUT, 100)
                menu.set_value(CP_HOST_CUT_LOOP, false)
                menu.set_value(CP_2P_CUT, 100)
                menu.set_value(CP_2P_CUT_LOOP, false)
            end)

            menu.toggle_loop(AUTOMATED_2P, TRANSLATE("Ruby Necklace"), {"hccp2prn"}, IS_WORKING(false), function()  
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
                menu.set_value(CP_REM_FEE, false)
                menu.set_value(CP_HOST_CUT, 50)
                menu.set_value(CP_HOST_CUT_LOOP, true)
                menu.set_value(CP_2P_CUT, 50)
                menu.set_value(CP_2P_CUT_LOOP, true)
            end, function()
                menu.set_value(CP_HOST_CUT, 100)
                menu.set_value(CP_HOST_CUT_LOOP, false)
                menu.set_value(CP_2P_CUT, 100)
                menu.set_value(CP_2P_CUT_LOOP, false)
            end)

        ---

        local AUTOMATED_3P = menu.list(CAYO_AUTO_PRST, TRANSLATE("3 Players"), {}, "", function(); end)

            menu.toggle_loop(AUTOMATED_3P, TRANSLATE("Sapphire Panther"), {"hccp3psp"}, IS_WORKING(false), function()
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
                menu.set_value(CP_REM_FEE, false)
                menu.set_value(CP_HOST_CUT, 30)
                menu.set_value(CP_HOST_CUT_LOOP, true)
                menu.set_value(CP_2P_CUT, 35)
                menu.set_value(CP_2P_CUT_LOOP, true)
                menu.set_value(CP_3P_CUT, 35)
                menu.set_value(CP_3P_CUT_LOOP, true)
            end, function()
                menu.set_value(CP_HOST_CUT, 100)
                menu.set_value(CP_HOST_CUT_LOOP, false)
                menu.set_value(CP_2P_CUT, 100)
                menu.set_value(CP_2P_CUT_LOOP, false)
                menu.set_value(CP_3P_CUT, 100)
                menu.set_value(CP_3P_CUT_LOOP, false)
            end)

            menu.toggle_loop(AUTOMATED_3P, TRANSLATE("Ruby Necklace"), {"hccp3prn"}, IS_WORKING(false), function()
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
                menu.set_value(CP_REM_FEE, false)
                menu.set_value(CP_HOST_CUT, 30)
                menu.set_value(CP_HOST_CUT_LOOP, true)
                menu.set_value(CP_2P_CUT, 35)
                menu.set_value(CP_2P_CUT_LOOP, true)
                menu.set_value(CP_3P_CUT, 35)
                menu.set_value(CP_3P_CUT_LOOP, true)
            end, function()
                menu.set_value(CP_HOST_CUT, 100)
                menu.set_value(CP_HOST_CUT_LOOP, false)
                menu.set_value(CP_2P_CUT, 100)
                menu.set_value(CP_2P_CUT_LOOP, false)
                menu.set_value(CP_3P_CUT, 100)
                menu.set_value(CP_3P_CUT_LOOP, false)
            end)

        ---

        local AUTOMATED_4P = menu.list(CAYO_AUTO_PRST, TRANSLATE("4 Players"), {}, "", function(); end)

            menu.toggle_loop(AUTOMATED_4P, TRANSLATE("Sapphire Panther"), {"hccp4psp"}, IS_WORKING(false), function()
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
                menu.set_value(CP_REM_FEE, false)
                menu.set_value(CP_HOST_CUT, 25)
                menu.set_value(CP_HOST_CUT_LOOP, true)
                menu.set_value(CP_2P_CUT, 25)
                menu.set_value(CP_2P_CUT_LOOP, true)
                menu.set_value(CP_3P_CUT, 25)
                menu.set_value(CP_3P_CUT_LOOP, true)
                menu.set_value(CP_4P_CUT, 25)
                menu.set_value(CP_4P_CUT_LOOP, true)
            end, function()
                menu.set_value(CP_HOST_CUT, 100)
                menu.set_value(CP_HOST_CUT_LOOP, false)
                menu.set_value(CP_2P_CUT, 100)
                menu.set_value(CP_2P_CUT_LOOP, false)
                menu.set_value(CP_3P_CUT, 100)
                menu.set_value(CP_3P_CUT_LOOP, false)
                menu.set_value(CP_4P_CUT, 100)
                menu.set_value(CP_4P_CUT_LOOP, false)
            end)

            menu.toggle_loop(AUTOMATED_4P, TRANSLATE("Ruby Necklace"), {"hccp4prn"}, IS_WORKING(false), function()
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
                menu.set_value(CP_REM_FEE, false)
                menu.set_value(CP_HOST_CUT, 25)
                menu.set_value(CP_HOST_CUT_LOOP, true)
                menu.set_value(CP_2P_CUT, 25)
                menu.set_value(CP_2P_CUT_LOOP, true)
                menu.set_value(CP_3P_CUT, 25)
                menu.set_value(CP_3P_CUT_LOOP, true)
                menu.set_value(CP_4P_CUT, 25)
                menu.set_value(CP_4P_CUT_LOOP, true)
            end, function()
                menu.set_value(CP_HOST_CUT, 100)
                menu.set_value(CP_HOST_CUT_LOOP, false)
                menu.set_value(CP_2P_CUT, 100)
                menu.set_value(CP_2P_CUT_LOOP, false)
                menu.set_value(CP_3P_CUT, 100)
                menu.set_value(CP_3P_CUT_LOOP, false)
                menu.set_value(CP_4P_CUT, 100)
                menu.set_value(CP_4P_CUT_LOOP, false)
            end)

        ---

        IsForCayoBot = false
        menu.toggle(CAYO_AUTO_PRST, TRANSLATE("Quick Preset (1 - 4P)"), {"hccpquick"}, IS_WORKING(false), function(Toggle)
            quickcp = Toggle

            if quickcp then
                NOTIFY(TRANSLATE("There are no secondary targets, there's only the primary target. Your goal is get it.") .. "\n\n" .. TRANSLATE("Leave activated until the end of the heist"))
            end

            if not quickcp then
                menu.set_value(CP_REM_FEE, false)
                menu.set_value(CP_HOST_CUT_LOOP, 100)
                menu.set_value(CP_HOST_CUT_LOOP, false)
                menu.set_value(CP_2P_CUT, 100)
                menu.set_value(CP_2P_CUT_LOOP, false)
                menu.set_value(CP_3P_CUT, 100)
                menu.set_value(CP_3P_CUT_LOOP, false)
                menu.set_value(CP_4P_CUT, 100)
                menu.set_value(CP_4P_CUT_LOOP, false)
            end

            while quickcp do
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
                STAT_SET_INT("H4CNF_TARGET", 5)
                STAT_SET_INT("H4CNF_WEAPONS", 1)
                STAT_SET_INT("H4_MISSIONS", 65283)
                STAT_SET_INT("H4_PROGRESS", 126823)
                STAT_SET_INT("H4_PLAYTHROUGH_STATUS", 5)

                if IsForCayoBot then
                    SET_INT_GLOBAL(262145 + 29987, 2090000) -- 266828370
                else
                    SET_INT_GLOBAL(262145 + 29987, 2455000)
                end
                
                menu.set_value(CP_REM_FEE, true)
                menu.set_value(CP_HOST_CUT, 100)
                menu.set_value(CP_HOST_CUT_LOOP, true)
                menu.set_value(CP_2P_CUT, 145)
                menu.set_value(CP_2P_CUT_LOOP, true)
                menu.set_value(CP_3P_CUT, 145)
                menu.set_value(CP_3P_CUT_LOOP, true)
                menu.set_value(CP_4P_CUT, 145)
                menu.set_value(CP_4P_CUT_LOOP, true)

                util.yield()
            end
        end)

    ---

    local STANDARD_SET = menu.list(PERICO_HEIST, TRANSLATE("Standard Preset"), {}, TRANSLATE("- Remember to choose your preset before entering the Submarine") .. "\n\n" .. TRANSLATE("- Remember to deactivate the preset at the end."), function(); end)

        menu.action(STANDARD_SET, TRANSLATE("Semi-Original Preset"), {"hccporigin"}, "", function()
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
            STAT_SET_INT("H4LOOT_CASH_I", 1089792)
            STAT_SET_INT("H4LOOT_CASH_C", 0)
            STAT_SET_INT("H4LOOT_WEED_I", 9114214)
            STAT_SET_INT("H4LOOT_WEED_C", 37)
            STAT_SET_INT("H4LOOT_COKE_I", 6573209)
            STAT_SET_INT("H4LOOT_COKE_C", 26)
            STAT_SET_INT("H4LOOT_GOLD_I", 0)
            STAT_SET_INT("H4LOOT_GOLD_C", 192)
            STAT_SET_INT("H4LOOT_PAINT", 127)
            STAT_SET_INT("H4_PROGRESS", 124271)
            STAT_SET_INT("H4LOOT_CASH_V", 22500)
            STAT_SET_INT("H4LOOT_COKE_V", 55023)
            STAT_SET_INT("H4LOOT_GOLD_V", 83046)
            STAT_SET_INT("H4LOOT_PAINT_V", 47375)
            STAT_SET_INT("H4LOOT_WEED_V", 36967)
            STAT_SET_INT("H4LOOT_CASH_I_SCOPED", 1089792)
            STAT_SET_INT("H4LOOT_CASH_C_SCOPED", 0)
            STAT_SET_INT("H4LOOT_WEED_I_SCOPED", 9114214)
            STAT_SET_INT("H4LOOT_WEED_C_SCOPED", 37)
            STAT_SET_INT("H4LOOT_COKE_I_SCOPED", 6573209)
            STAT_SET_INT("H4LOOT_COKE_C_SCOPED", 26)
            STAT_SET_INT("H4LOOT_GOLD_I_SCOPED", 0)
            STAT_SET_INT("H4LOOT_GOLD_C_SCOPED", 192)
            STAT_SET_INT("H4LOOT_PAINT_SCOPED", 127)
            STAT_SET_INT("H4_MISSIONS", -1)
            STAT_SET_INT("H4_PLAYTHROUGH_STATUS", 5)
            STAT_SET_INT("H4CNF_TARGET", math.random(1, 5))
            STAT_SET_INT("H4CNF_WEAPONS", math.random(1, 5))
        end)

    ---

    local TELEPORT_CP = menu.list(PERICO_HEIST, TRANSLATE("Custom Teleport"), {}, "", function(); end)

        local CAYO_TELE_COMPOUND = menu.list(TELEPORT_CP, TRANSLATE("Compound"), {}, "", function(); end)

            local CAYO_TELE_STORAGE = menu.list(CAYO_TELE_COMPOUND, TRANSLATE("Storage"), {}, "", function(); end)

                menu.action(CAYO_TELE_STORAGE, TRANSLATE("North"), {}, "", function()
                    TELEPORT(5081.0415, -5755.32, 15.829645)
                end)
                menu.action(CAYO_TELE_STORAGE, TRANSLATE("West"), {}, "", function()
                    TELEPORT(5006.722, -5786.5967, 17.831688)
                end)
                menu.action(CAYO_TELE_STORAGE, TRANSLATE("South"), {}, "", function()
                    TELEPORT(5027.603, -5734.682, 17.255005)
                end)

            ---

            local CAYO_TELE_VAULT = menu.list(CAYO_TELE_COMPOUND, TRANSLATE("Vault"), {}, "", function(); end)

                CAYO_TELE_VAULT_PRIMARY = menu.action(CAYO_TELE_VAULT, TRANSLATE("Primary Target"), {}, "", function()
                    TELEPORT(5006.7, -5756.2, 14.8)
                    SET_HEADING(145)
                end)
                menu.action(CAYO_TELE_VAULT, TRANSLATE("Secondary Target"), {}, "", function()
                    TELEPORT(4999.764160, -5749.863770, 14.840000)
                end)

            ---

            menu.action(CAYO_TELE_COMPOUND, TRANSLATE("El Rubio's Office"), {}, "", function()
                TELEPORT(5010.12, -5750.1353, 28.84334)
                SET_HEADING(325)
            end)
            menu.action(CAYO_TELE_COMPOUND, TRANSLATE("Front Gate Exit"), {}, "", function()
                TELEPORT(4990.0386, -5717.6895, 19.880217)
                SET_HEADING(50)
            end)

        ---

        local CAYO_TELE_ISLAND = menu.list(TELEPORT_CP, TRANSLATE("Island"), {}, "", function(); end)

            local CAYO_TELE_AIRSTRIP = menu.list(CAYO_TELE_ISLAND, TRANSLATE("Airstrip"), {}, "", function(); end)

                menu.action(CAYO_TELE_AIRSTRIP, TRANSLATE("Loot") .. " - #1", {}, "", function()
                    TELEPORT(4503.587402, -4555.740723, 2.854459)
                end)
                menu.action(CAYO_TELE_AIRSTRIP, TRANSLATE("Loot") .. " - #2", {}, "", function()
                    TELEPORT(4437.821777, -4447.841309, 3.028436)
                end)
                menu.action(CAYO_TELE_AIRSTRIP, TRANSLATE("Loot") .. " - #3", {}, "", function()
                    TELEPORT(4447.091797, -4442.184082, 5.936794)
                end)

            ---

            local CAYO_TELE_CROP_FIELDS = menu.list(CAYO_TELE_ISLAND, TRANSLATE("Crop Fields"), {}, "", function(); end)

                menu.action(CAYO_TELE_CROP_FIELDS, TRANSLATE("Loot") .. " - #1", {}, "", function()
                    TELEPORT(5330.527, -5269.7515, 33.18603)
                end)

            ---

            local CAYO_TELE_MAIN_DOCK = menu.list(CAYO_TELE_ISLAND, TRANSLATE("Main Dock"), {}, "", function(); end)

                menu.action(CAYO_TELE_MAIN_DOCK, TRANSLATE("Loot") .. " - #1", {}, "", function()
                    TELEPORT(5193.909668, -5135.642578, 2.045917)
                end)
                menu.action(CAYO_TELE_MAIN_DOCK, TRANSLATE("Loot") .. " - #2", {}, "", function()
                    TELEPORT(4963.184570, -5108.933105, 1.670808)
                end)
                menu.action(CAYO_TELE_MAIN_DOCK, TRANSLATE("Loot") .. " - #3", {}, "", function()
                    TELEPORT(4998.709473, -5165.559570, 1.464137)
                end)
                menu.action(CAYO_TELE_MAIN_DOCK, TRANSLATE("Loot") .. " - #4", {}, "", function()
                    TELEPORT(4924.693359, -5243.244629, 1.223599)
                end)

            ---

            local CAYO_TELE_NORTH_DOCK = menu.list(CAYO_TELE_ISLAND, TRANSLATE("North Dock"), {}, "", function(); end)

                menu.action(CAYO_TELE_NORTH_DOCK, TRANSLATE("Loot") .. " - #1", {}, "", function()
                    TELEPORT(5132.558594, -4612.922852, 1.162808)
                end)
                menu.action(CAYO_TELE_NORTH_DOCK, TRANSLATE("Loot") .. " - #2", {}, "", function()
                    TELEPORT(5065.255371, -4591.706543, 1.555012)
                end)
                menu.action(CAYO_TELE_NORTH_DOCK, TRANSLATE("Loot") .. " - #3", {}, "", function()
                    TELEPORT(5090.916016, -4682.670898, 1.107098)
                end)

            ---

                menu.action(CAYO_TELE_ISLAND, TRANSLATE("Radio Tower"), {}, "", function()
                    TELEPORT(5263.7124, -5407.5835, 65.24931)
                end)
                CAYO_TELE_ISLAND_DRAINGE_1ST = menu.action(CAYO_TELE_ISLAND, TRANSLATE("Drainage Pipe"), {}, "", function()
                    TELEPORT(5044.001, -5815.6426, -11.808871)
                end)
                CAYO_TELE_ISLAND_DRAINGE_2ND = menu.action(CAYO_TELE_ISLAND, TRANSLATE("Drainage: 2nd Checkpoint"), {}, "", function()
                    TELEPORT(5053.773, -5773.2266, -5.40778)
                end)
                menu.action(CAYO_TELE_ISLAND, TRANSLATE("Ocean (Safe Zone)"), {}, "", function()
                    TELEPORT(4771.479, -6165.737, -39.079613)
                end)

            ---

        ---

        menu.action(TELEPORT_CP, TRANSLATE("Kosatka: Heist Board (Call Kosatka first)"), {"hctpsub"}, "", function()
            if STAT_GET_INT("IH_SUB_OWNED") ~= 0 then
                TELEPORT(1561.2369, 385.8771, -49.689915)
                SET_HEADING(175)
            else
                NOTIFY(TRANSLATE("You didn't buy the Kosatka yet. Buy it first to teleport!"))
            end
        end)

    ---

    local PERICO_ADV = menu.list(PERICO_HEIST, TRANSLATE("Advanced Features"), {}, "", function(); end)

        local HSCUT_CP = menu.list(PERICO_ADV, TRANSLATE("Player's Cut"), {}, "", function(); end)

            local PERICO_HOST_CUT = menu.list(HSCUT_CP, TRANSLATE("Your Cut"), {}, "", function(); end)

                CP_HOST_CUT_LOOP = menu.toggle_loop(PERICO_HOST_CUT, TRANSLATE("Enable"), {"hccphostcutloop"}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(1977693 + 823 + 56 + 1, menu.get_value(CP_HOST_CUT)) -- heist_island_planning.c
                end, function()
                    SET_INT_GLOBAL(1977693 + 823 + 56 + 1, 100)
                end)

                CP_HOST_CUT = menu.slider(PERICO_HOST_CUT, TRANSLATE("Custom Percentage"), {"hccphostcut"}, "(%)", 0, 1000, 100, 5, function(); end)

            ---

            local PERICO_P2_CUT = menu.list(HSCUT_CP, TRANSLATE("Player 2"), {}, "", function(); end)

                CP_2P_CUT_LOOP = menu.toggle_loop(PERICO_P2_CUT, TRANSLATE("Enable"), {"hccp2pcutloop"}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(1977693 + 823 + 56 + 2, menu.get_value(CP_2P_CUT)) -- heist_island_planning.c
                end, function()
                    SET_INT_GLOBAL(1977693 + 823 + 56 + 2, 100)
                end)

                CP_2P_CUT = menu.slider(PERICO_P2_CUT, TRANSLATE("Custom Percentage"), {"hccp2pcut"}, "(%)", 0, 1000, 100, 5, function(); end)
            
            ---
            
            local PERICO_P3_CUT = menu.list(HSCUT_CP, TRANSLATE("Player 3"), {}, "", function(); end)

                CP_3P_CUT_LOOP = menu.toggle_loop(PERICO_P3_CUT, TRANSLATE("Enable"), {"hccp3pcutloop"}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(1977693 + 823 + 56 + 3, menu.get_value(CP_3P_CUT)) -- heist_island_planning.c
                end, function()
                    SET_INT_GLOBAL(1977693 + 823 + 56 + 3, 100)
                end)

                CP_3P_CUT = menu.slider(PERICO_P3_CUT, TRANSLATE("Custom Percentage"), {"hccp3pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

            ---

            local PERICO_P4_CUT = menu.list(HSCUT_CP, TRANSLATE("Player 4"), {}, "", function(); end)

                CP_4P_CUT_LOOP = menu.toggle_loop(PERICO_P4_CUT, TRANSLATE("Enable"), {"hccp4pcutloop"}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(1977693 + 823 + 56 + 4, menu.get_value(CP_4P_CUT)) -- heist_island_planning.c
                end, function()
                    SET_INT_GLOBAL(1977693 + 823 + 56 + 4, 100)
                end)

                CP_4P_CUT = menu.slider(PERICO_P4_CUT, TRANSLATE("Custom Percentage"), {"hccp4pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

            ---
            
            menu.toggle_loop(HSCUT_CP, TRANSLATE("Set 100% for everyone"), {"hccpcutall100"}, IS_WORKING(false), function()
                menu.set_value(CP_HOST_CUT, 100)
                menu.set_value(CP_HOST_CUT_LOOP, true)
                menu.set_value(CP_2P_CUT, 100)
                menu.set_value(CP_2P_CUT_LOOP, true)
                menu.set_value(CP_3P_CUT, 100)
                menu.set_value(CP_3P_CUT_LOOP, true)
                menu.set_value(CP_4P_CUT, 100)
                menu.set_value(CP_4P_CUT_LOOP, true)
            end, function()
                menu.set_value(CP_HOST_CUT_LOOP, false)
                menu.set_value(CP_2P_CUT_LOOP, false)
                menu.set_value(CP_3P_CUT_LOOP, false)
                menu.set_value(CP_4P_CUT_LOOP, false)
            end)

        ---

        menu.list_action(PERICO_ADV, TRANSLATE("Bag Capacity Modifier"), {"hccpbag"}, IS_WORKING(true) .. TRANSLATE("(Local)"), {
            { TRANSLATE("Normal Bag Capacity"), {"1p"} },
            { TRANSLATE("Simulate Bag Capacity of 2 players"), {"2p"} },
            { TRANSLATE("Simulate Bag Capacity of 3 players"), {"3p"} },
            { TRANSLATE("Simulate Bag Capacity of 4 players"), {"4p"} },
            { TRANSLATE("Infinite Bag Capacity"), {"inf"} },
        }, function(Index)
            if Index ~= 5 then
                SET_INT_GLOBAL(262145 + 29732, 1800 * Index) -- 1859395035
            else
                SET_INT_GLOBAL(262145 + 29732, 99999)
            end
        end)

        menu.toggle_loop(PERICO_ADV, TRANSLATE("Skip The Hacking Process"), {}, IS_WORKING(false), function() 
            if GET_INT_LOCAL("fm_mission_controller_2020", 22032) == 4 then -- Locals from https://www.unknowncheats.me/forum/3418914-post13398.html, Values from Heist Control for Nightfall
                SET_INT_LOCAL("fm_mission_controller_2020", 22032, 5)
            end
        end)

        menu.toggle_loop(PERICO_ADV, TRANSLATE("Skip Cutting The Sewer Grill"), {}, IS_WORKING(true) .. TRANSLATE("Use with Cayo Perico Heist > Custom Teleport > Island > Drainage Pipe!"), function() 
            if IS_HELP_MSG_DISPLAYED("UT_WELD_PROMPT") then -- "~s~Press ~INPUT_CONTEXT~ to cut through the grill."
                PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 51, 1)
            elseif GET_INT_LOCAL("fm_mission_controller_2020", 26746) == 4 then -- Local from https://www.unknowncheats.me/forum/3389282-post1.html  
                SET_INT_LOCAL("fm_mission_controller_2020", 26746, 6)
            end
        end)

        menu.toggle_loop(PERICO_ADV, TRANSLATE("Skip Cutting The Glass"), {}, IS_WORKING(false), function()
            SET_FLOAT_LOCAL("fm_mission_controller_2020", 27985 + 3, 100)
        end, function()
            SET_FLOAT_LOCAL("fm_mission_controller_2020", 27985 + 3, 0)
        end)

        menu.toggle_loop(PERICO_ADV, TRANSLATE("Infinite Plasma Cutter Heat"), {}, IS_WORKING(false), function()
            SET_FLOAT_LOCAL("fm_mission_controller_2020", 27985 + 4, 0)
        end)

        menu.toggle_loop(PERICO_ADV, TRANSLATE("Infinite Voltage Timer"), {}, IS_WORKING(false), function()
            local Value = GET_INT_LOCAL("fm_mission_controller_2020", 1718)
            SET_INT_LOCAL("fm_mission_controller_2020", 1717, Value)
        end, function()
            SET_INT_LOCAL("fm_mission_controller_2020", 1717, 0)
        end)

        CP_REM_FEE = menu.toggle_loop(PERICO_ADV, TRANSLATE("Remove The Fencing Fee And Pavel's Cut"), {"hccpremfee"}, IS_WORKING(true) .. TRANSLATE("Leave activated until the end of the heist"), function()
            SET_FLOAT_GLOBAL(262145 + 29991, 0) -- 902085532
            SET_FLOAT_GLOBAL(262145 + 29992, 0) -- -1135949374
        end, function()
            SET_FLOAT_GLOBAL(262145 + 29991, -0.1)
            SET_FLOAT_GLOBAL(262145 + 29992, -0.02)
        end)

        menu.action(PERICO_ADV, TRANSLATE("Obtain The Primary Target"), {"hccpfintar"}, IS_WORKING(false), function() -- Locals from https://www.unknowncheats.me/forum/3418914-post13398.html, Values from Heist Control for Nightfall
            SET_INT_LOCAL("fm_mission_controller_2020", 27984, 5) -- CutterStage
            SET_INT_LOCAL("fm_mission_controller_2020", 27985, 3) -- BitCheck
        end)

        menu.action(PERICO_ADV, TRANSLATE("Remove The Drainage Pipe"), {"hccprempipe"}, "", function() -- Thanks to help me to code, Sapphire#6031
            for k, ent in pairs(entities.get_all_objects_as_handles()) do
                if ENTITY.GET_ENTITY_MODEL(ent) == -1297635988 then
                    entities.delete_by_handle(ent)
                end
            end
        end)
    
    ---

    menu.list_action(PERICO_HEIST, TRANSLATE("Heist Vehicles"), {"hccpveh"}, "", {
        { TRANSLATE("Kosatka (Submarine)"), {"kosatka"} },
        { TRANSLATE("Alkonost (Plane)"), {"alkonost"} },
        { TRANSLATE("Velum (Plane)"), {"velum"} },
        { TRANSLATE("Annihilator Stealth (Helicopter)"), {"annihilator"} },
        { TRANSLATE("Kurtz 31 Patrol Boat (Boat)"), {"patrol"} },
        { TRANSLATE("Longfin (Boat)"), {"longfin"} },
        { TRANSLATE("Unlock All Of The Vehicles"), {"all"} },
    }, function(Index)
        if Index == 1 then
            STAT_SET_INT("H4_MISSIONS", 65283)
        elseif Index == 2 then
            STAT_SET_INT("H4_MISSIONS", 65413)
        elseif Index == 3 then 
            STAT_SET_INT("H4_MISSIONS", 65289)
        elseif Index == 4 then 
            STAT_SET_INT("H4_MISSIONS", 65425)
        elseif Index == 5 then 
            STAT_SET_INT("H4_MISSIONS", 65313)
        elseif Index == 6 then 
            STAT_SET_INT("H4_MISSIONS", 65345)
        elseif Index == 7 then
            STAT_SET_INT("H4_MISSIONS", -1)
        end
    end)

    menu.list_action(PERICO_HEIST, TRANSLATE("Primary Target"), {"hccppritar"}, "", {
        { TRANSLATE("Sapphire Panther"), {"panther"} },
        { TRANSLATE("Madrazo Files"), {"file"} },
        { TRANSLATE("Pink Diamond"), {"diamond"} },
        { TRANSLATE("Bearer Bonds"), {"bearer"} },
        { TRANSLATE("Ruby Necklace"), {"ruby"} },
        { TRANSLATE("Tequila"), {"tequila"} },
    }, function(Index)
        if Index == 1 then
            STAT_SET_INT("H4CNF_TARGET", 5)
        elseif Index == 2 then
            STAT_SET_INT("H4CNF_TARGET", 4)
        elseif Index == 3 then 
            STAT_SET_INT("H4CNF_TARGET", 3)
        elseif Index == 4 then 
            STAT_SET_INT("H4CNF_TARGET", 2)
        elseif Index == 5 then 
            STAT_SET_INT("H4CNF_TARGET", 1)
        elseif Index == 6 then 
            STAT_SET_INT("H4CNF_TARGET", 0)
        end
    end)

    menu.list_action(PERICO_HEIST, TRANSLATE("Secondary Target"), {"hccpsectar"}, TRANSLATE("When using this method, the percentage and final payment will be random!"), {
        { TRANSLATE("Mixed Loot"), {"mixed"} },
        { TRANSLATE("Cash"), {"cash"} },
        { TRANSLATE("Weed"), {"weed"} },
        { TRANSLATE("Coke"), {"coke"} },
        { TRANSLATE("Gold"), {"gold"} },
        { TRANSLATE("Remove All Secondary Targets"), {"remall"} },
    }, function(Index)
        if Index == 1 then
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
        elseif Index == 2 then
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
        elseif Index == 3 then 
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
        elseif Index == 4 then 
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
        elseif Index == 5 then 
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
        elseif Index == 6 then 
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
    end)

    menu.list_action(PERICO_HEIST, TRANSLATE("Compound Loot"), {"hccpcomloot"}, "", {
        { TRANSLATE("Mixed Loot"), {"mixed"} },
        { TRANSLATE("Cash"), {"cash"} },
        { TRANSLATE("Weed"), {"weed"} },
        { TRANSLATE("Coke"), {"coke"} },
        { TRANSLATE("Gold"), {"gold"} },
        { TRANSLATE("Paint"), {"paint"} },
        { TRANSLATE("Remove Paint [Only]"), {"rempaint"} },
        { TRANSLATE("Remove All Secondary Targets"), {"remall"} },
    }, function(Index)
        if Index == 1 then
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
        elseif Index == 2 then
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
        elseif Index == 3 then 
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
        elseif Index == 4 then 
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
        elseif Index == 5 then 
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
        elseif Index == 6 then 
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
        elseif Index == 7 then
            STAT_SET_INT("H4LOOT_PAINT", 0)
            STAT_SET_INT("H4LOOT_PAINT_V", 0)
            STAT_SET_INT("H4LOOT_PAINT_SCOPED", 0)
        elseif Index == 8 then
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
    end)

    menu.list_action(PERICO_HEIST, TRANSLATE("Weapon Loadouts"), {"hccpweapon"}, "", {
        { TRANSLATE("Aggressor"), {"aggeressor"} },
        { TRANSLATE("Conspirator"), {"conspirator"} },
        { TRANSLATE("Crackshot"), {"crackshot"} },
        { TRANSLATE("Saboteur"), {"saboteur"} },
        { TRANSLATE("Marksman"), {"marksman"} },
    }, function(Index)
        if Index == 1 then
            NOTIFY(TRANSLATE("- Assault Shotgun + Machine Pistol") .. "\n" .. TRANSLATE("- Machete + Grenade"))
        elseif Index == 2 then
            NOTIFY(TRANSLATE("- Military Rifle + Pistol .50") .. "\n" .. TRANSLATE("- Knuckle Duster + Sticky Bombs"))
        elseif Index == 3 then 
            NOTIFY(TRANSLATE("- Sniper Rifle + AP Pistol") .. "\n" .. TRANSLATE("- Knife + Molotov"))
        elseif Index == 4 then 
            NOTIFY(TRANSLATE("- SMG Mk2 + SNS Pistol Mk2"))
        elseif Index == 5 then 
            NOTIFY(TRANSLATE("- Assault Rifle Mk2 + Pistol .50") .. "\n" .. TRANSLATE("- Machete + Pipe Bomb"))
        end
        
        STAT_SET_INT("H4CNF_WEAPONS", Index)
    end)

    menu.list_action(PERICO_HEIST, TRANSLATE("Equipment's Spawn Location"), {"hccpequip"}, TRANSLATE("- Guard Clothing") .. "\n" .. TRANSLATE("- Bolt Cutters"), { 
        { TRANSLATE("Airport"), {"airport"} },
        { TRANSLATE("Docks"), {"dock"} },
        { TRANSLATE("Compound"), {"compound"} },
    }, function(Index)
        if Index == 1 then
            STAT_SET_INT("H4CNF_GRAPPEL", 2022)
            STAT_SET_INT("H4CNF_UNIFORM", 12)
            STAT_SET_INT("H4CNF_BOLTCUT", 4161)
            STAT_SET_INT("H4CNF_TROJAN", 1)
        elseif Index == 2 then
            STAT_SET_INT("H4CNF_GRAPPEL", 3671)
            STAT_SET_INT("H4CNF_UNIFORM", 5256)
            STAT_SET_INT("H4CNF_BOLTCUT", 4424)
            STAT_SET_INT("H4CNF_TROJAN", 2)
        elseif Index == 3 then
            STAT_SET_INT("H4CNF_GRAPPEL", 85324)
            STAT_SET_INT("H4CNF_UNIFORM", 61034)
            STAT_SET_INT("H4CNF_BOLTCUT", 4612)
            STAT_SET_INT("H4CNF_TROJAN", 5)
        end
    end)

    menu.list_action(PERICO_HEIST, TRANSLATE("Supply Truck Location"), {"hccptruck"}, "", {
        { TRANSLATE("Airport"), {"airport"} },
        { TRANSLATE("North Dock"), {"ndock"} },
        { TRANSLATE("Main Dock [East]"), {"edock"} },
        { TRANSLATE("Main Dock [West]"), {"wdock"} },
        { TRANSLATE("Compound"), {"compound"} },
    }, function(Index)
        STAT_SET_INT("H4CNF_TROJAN", Index)
    end)

    menu.list_action(PERICO_HEIST, TRANSLATE("Heist Difficulty"), {"hccpdiff"}, "", {
        { TRANSLATE("Normal"), {"normal"} },
        { TRANSLATE("Hard"), {"hard"} },
    }, function(Index)
        if Index == 1 then
            STAT_SET_INT("H4_PROGRESS", 126823)
        elseif Index == 2 then
            STAT_SET_INT("H4_PROGRESS", 131055)
        end
    end)

    local MORE_OPTIONS = menu.list(PERICO_HEIST, TRANSLATE("Others"), {}, "", function(); end)

        menu.action(MORE_OPTIONS, TRANSLATE("Unlock The Heist Awards"), {}, "", function()
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
        end)

        menu.action(MORE_OPTIONS, TRANSLATE("Complete All Prep Missions"), {}, "", function()
            STAT_SET_INT("H4_MISSIONS", -1)
            STAT_SET_INT("H4CNF_APPROACH", -1)
            STAT_SET_INT("H4CNF_BS_ENTR", 63)
            STAT_SET_INT("H4CNF_BS_GEN", 63)
            STAT_SET_INT("H4CNF_WEP_DISRP", 3)
            STAT_SET_INT("H4CNF_ARM_DISRP", 3)
            STAT_SET_INT("H4CNF_HEL_DISRP", 3)
        end)

        menu.action(MORE_OPTIONS, TRANSLATE("Force The Final Cutscene"), {}, TRANSLATE("Keep in mind that you must use this option before starting the Heist"), function()
            STAT_SET_INT("H4_PLAYTHROUGH_STATUS", 0)
        end)

        menu.action(MORE_OPTIONS, TRANSLATE("Set Heist To Default (Reset)"), {"hccpreset"}, "", function()
            STAT_SET_INT("H4_MISSIONS", 0)
            STAT_SET_INT("H4_PROGRESS", 0)
            STAT_SET_INT("H4CNF_APPROACH", 0)
            STAT_SET_INT("H4CNF_BS_ENTR", 0)
            STAT_SET_INT("H4CNF_BS_GEN", 0)
            STAT_SET_INT("H4_PLAYTHROUGH_STATUS", 0)
            STAT_SET_INT("H4CNF_TARGET", -1)
        end)

    ---

---


--- Diamond Casino Heist

    local CASINO_PRESETS = menu.list(CASINO_HEIST, TRANSLATE("Automated Presets"), {}, "", function(); end)

        local CASINO_PRESETS_DIAMOND = menu.list(CASINO_PRESETS, TRANSLATE("Diamonds"), {}, TRANSLATE("$3.5 Million For All Players"), function(); end)

            menu.toggle(CASINO_PRESETS_DIAMOND, TRANSLATE("Silent & Sneaky Approach"), {"hccahdiasil"}, IS_WORKING(true) .. TRANSLATE("ALWAYS Choose The Low Level Buyer!"), function(Toggle)
                DiamondST = Toggle

                if DiamondST then
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
                end

                if not DiamondST then
                    menu.set_value(CAH_1P_CUT, 100)
                    menu.set_value(CAH_1P_CUT_LOOP, false)
                    menu.set_value(CAH_2P_CUT, 100)
                    menu.set_value(CAH_2P_CUT_LOOP, false)
                    menu.set_value(CAH_3P_CUT, 100)
                    menu.set_value(CAH_3P_CUT_LOOP, false)
                    menu.set_value(CAH_4P_CUT, 100)
                    menu.set_value(CAH_4P_CUT_LOOP, false)
                end

                while DiamondST do
                    SET_INT_GLOBAL(262145 + 28808, 1410065408) -- 1277889925
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

            menu.toggle(CASINO_PRESETS_DIAMOND, TRANSLATE("BigCon Approach"), {"hccahdiabig"}, IS_WORKING(true) .. TRANSLATE("ALWAYS choose Low Level Buyer!"), function(Toggle)
                DiamondND = Toggle

                if DiamondND then
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
                end

                if not DiamondND then
                    menu.set_value(CAH_1P_CUT, 100)
                    menu.set_value(CAH_1P_CUT_LOOP, false)
                    menu.set_value(CAH_2P_CUT, 100)
                    menu.set_value(CAH_2P_CUT_LOOP, false)
                    menu.set_value(CAH_3P_CUT, 100)
                    menu.set_value(CAH_3P_CUT_LOOP, false)
                    menu.set_value(CAH_4P_CUT, 100)
                    menu.set_value(CAH_4P_CUT_LOOP, false)
                end

                while DiamondND do
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

            menu.toggle(CASINO_PRESETS_DIAMOND, TRANSLATE("Aggressive Approach"), {"hccahdiaagg"}, IS_WORKING(true) .. TRANSLATE("ALWAYS choose Low Level Buyer!"), function(Toggle)
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

        ---

        local CASINO_PRESETS_GOLD = menu.list(CASINO_PRESETS, TRANSLATE("Gold"), {}, TRANSLATE("$3.5 Millions & For All Players"), function(); end)

            menu.toggle(CASINO_PRESETS_GOLD, TRANSLATE("Silent & Sneaky Approach"), {"hccahgoldsil"}, IS_WORKING(true) .. TRANSLATE("ALWAYS choose Low Level Buyer!"), function(Toggle)
                GoldST = Toggle

                if GoldST then
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
                end

                if not GoldST then
                    menu.set_value(CAH_1P_CUT, 100)
                    menu.set_value(CAH_1P_CUT_LOOP, false)
                    menu.set_value(CAH_2P_CUT, 100)
                    menu.set_value(CAH_2P_CUT_LOOP, false)
                    menu.set_value(CAH_3P_CUT, 100)
                    menu.set_value(CAH_3P_CUT_LOOP, false)
                    menu.set_value(CAH_4P_CUT, 100)
                    menu.set_value(CAH_4P_CUT_LOOP, false)
                end

                while GoldST do
                    SET_INT_GLOBAL(262145 + 28807, 1410065408) -- -582734553
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

        ---

        local CASINO_PRESETS_GOLD = menu.list(CASINO_PRESETS, TRANSLATE("Gold"), {}, TRANSLATE("$3.5 Millions & For All Players"), function(); end)

            menu.toggle(CASINO_PRESETS_GOLD, TRANSLATE("Silent & Sneaky Approach"), {"hccahgoldsil"}, IS_WORKING(true) .. TRANSLATE("ALWAYS choose Low Level Buyer!"), function(Toggle)
                GoldST = Toggle

                if GoldST then
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
                end

                if not GoldST then
                    menu.set_value(CAH_1P_CUT, 100)
                    menu.set_value(CAH_1P_CUT_LOOP, false)
                    menu.set_value(CAH_2P_CUT, 100)
                    menu.set_value(CAH_2P_CUT_LOOP, false)
                    menu.set_value(CAH_3P_CUT, 100)
                    menu.set_value(CAH_3P_CUT_LOOP, false)
                    menu.set_value(CAH_4P_CUT, 100)
                    menu.set_value(CAH_4P_CUT_LOOP, false)
                end

                while GoldST do
                    SET_INT_GLOBAL(262145 + 28807, 1410065408) -- -582734553
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

            menu.toggle(CASINO_PRESETS_GOLD, TRANSLATE("BigCon Approach"), {"hccahgoldbig"}, IS_WORKING(true) .. TRANSLATE("ALWAYS choose Low Level Buyer!"), function(Toggle)
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

            menu.toggle(CASINO_PRESETS_GOLD, TRANSLATE("Aggressive Approach"), {"hccahgoldagg"}, IS_WORKING(true) .. TRANSLATE("ALWAYS choose Low Level Buyer!"), function(Toggle)
                GoldRD = Toggle

                if GoldRD then
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
                    STAT_SET_INT("H3_HARD_APPROACH", 0)
                    STAT_SET_INT("H3OPT_VEHS", 3)
                end

                if not GoldRD then
                    menu.set_value(CAH_1P_CUT, 100)
                    menu.set_value(CAH_1P_CUT_LOOP, false)
                    menu.set_value(CAH_2P_CUT, 100)
                    menu.set_value(CAH_2P_CUT_LOOP, false)
                    menu.set_value(CAH_3P_CUT, 100)
                    menu.set_value(CAH_3P_CUT_LOOP, false)
                    menu.set_value(CAH_4P_CUT, 100)
                    menu.set_value(CAH_4P_CUT_LOOP, false)
                end

                while GoldRD do
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

        ---

    ---

    local CAH_ADVCED = menu.list(CASINO_HEIST, TRANSLATE("Advanced Features"), {}, "", function(); end)
    
        local CAH_PLAYER_CUT = menu.list(CAH_ADVCED, TRANSLATE("Player's Cut"), {}, "", function(); end)

            local CAH_NON_YOUR_CUT = menu.list(CAH_PLAYER_CUT, TRANSLATE("Your Cut (Non-Host)"), {}, "", function(); end)

                CAH_NON_HOST_CUT_LOOP = menu.toggle_loop(CAH_NON_YOUR_CUT, TRANSLATE("Enable"), {"hccahnonhostloop"}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(2684799 + 6546, menu.get_value(CAH_NON_HOST_CUT)) -- gb_casino_heist.c
                end, function()
                    SET_INT_GLOBAL(2684799 + 6546, 100)
                end)

                CAH_NON_HOST_CUT = menu.slider(CAH_NON_YOUR_CUT, TRANSLATE("Custom Percentage"), {"hccahnonhost"}, "(%)", 0, 1000, 100, 5, function(); end)

            ---

            local CAH_PLAYER_HOST = menu.list(CAH_PLAYER_CUT, TRANSLATE("Your Cut"), {}, "", function(); end)

                CAH_1P_CUT_LOOP = menu.toggle_loop(CAH_PLAYER_HOST, TRANSLATE("Enable"), {"hccah1pcutloop"}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(1970895 + 2326, menu.get_value(CAH_1P_CUT)) -- gb_casino_heist.c
                end, function()
                    SET_INT_GLOBAL(1970895 + 2326, 100)
                end)

                CAH_1P_CUT = menu.slider(CAH_PLAYER_HOST, TRANSLATE("Custom Percentage"), {"hccah1pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

            ---

            local CAH_PLAYER_TWO = menu.list(CAH_PLAYER_CUT, TRANSLATE("Player 2"), {}, "", function(); end)

                CAH_2P_CUT_LOOP = menu.toggle_loop(CAH_PLAYER_TWO, TRANSLATE("Enable"), {"hccah2pcutloop"}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(1970895 + 2326 + 1, menu.get_value(CAH_2P_CUT)) -- gb_casino_heist.c
                end, function()
                    SET_INT_GLOBAL(1970895 + 2326 + 1, 100)
                end)

                CAH_2P_CUT = menu.slider(CAH_PLAYER_TWO, TRANSLATE("Custom Percentage"), {"hccah2pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

            ---

            local CAH_PLAYER_THREE = menu.list(CAH_PLAYER_CUT, TRANSLATE("Player 3"), {}, "", function(); end)

                CAH_3P_CUT_LOOP = menu.toggle_loop(CAH_PLAYER_THREE, TRANSLATE("Enable"), {"hccah3pcutloop"}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(1970895 + 2326 + 2, menu.get_value(CAH_3P_CUT)) -- gb_casino_heist.c
                end, function()
                    SET_INT_GLOBAL(1970895 + 2326 + 2, 100)
                end)

                CAH_3P_CUT = menu.slider(CAH_PLAYER_THREE, TRANSLATE("Custom Percentage"), {"hccah3pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

            ---

            local CAH_PLAYER_FOUR = menu.list(CAH_PLAYER_CUT, TRANSLATE("Player 4"), {}, "", function(); end)
                
                CAH_4P_CUT_LOOP = menu.toggle_loop(CAH_PLAYER_FOUR, TRANSLATE("Enable"), {"hccah4pcutloop"}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(1970895 + 2326 + 3, menu.get_value(CAH_4P_CUT)) -- gb_casino_heist.c
                end, function()
                    SET_INT_GLOBAL(1970895 + 2326 + 3, 100)
                end)

                CAH_4P_CUT = menu.slider(CAH_PLAYER_FOUR, TRANSLATE("Custom Percentage"), {"hccah4pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

            ---

            menu.toggle_loop(CAH_PLAYER_CUT, TRANSLATE("Set 100% for everyone"), {"hccahall100"}, IS_WORKING(false), function()
                menu.set_value(CAH_1P_CUT, 100)
                menu.set_value(CAH_1P_CUT_LOOP, true)
                menu.set_value(CAH_2P_CUT, 100)
                menu.set_value(CAH_2P_CUT_LOOP, true)
                menu.set_value(CAH_3P_CUT, 100)
                menu.set_value(CAH_3P_CUT_LOOP, true)
                menu.set_value(CAH_4P_CUT, 100)
                menu.set_value(CAH_4P_CUT_LOOP, true)
            end, function()
                menu.set_value(CAH_1P_CUT, 100)
                menu.set_value(CAH_1P_CUT_LOOP, false)
                menu.set_value(CAH_2P_CUT, 100)
                menu.set_value(CAH_2P_CUT_LOOP, false)
                menu.set_value(CAH_3P_CUT, 100)
                menu.set_value(CAH_3P_CUT_LOOP, false)
                menu.set_value(CAH_4P_CUT, 100)
                menu.set_value(CAH_4P_CUT_LOOP, false)
            end)

        ---

        menu.toggle_loop(CAH_ADVCED, TRANSLATE("Skip The Hacking Process"), {}, IS_WORKING(true) .. TRANSLATE("Works On Both: Fingerprint and Keypad"), function()
            if GET_INT_LOCAL("fm_mission_controller", 52962) ~= 1 then -- For Fingerprint, Locals from https://www.unknowncheats.me/forum/3418914-post13398.html, Values from Heist Control for Nightfall
                SET_INT_LOCAL("fm_mission_controller", 52962, 5)
            end
            if GET_INT_LOCAL("fm_mission_controller", 54024) ~= 1 then -- For Keypad, https://www.unknowncheats.me/forum/3455828-post8.html
                SET_INT_LOCAL("fm_mission_controller", 54024, 5)
            end
        end)

        menu.action(CAH_ADVCED, TRANSLATE("Skip Drilling The Vault Door"), {"hccahinsvault"}, IS_WORKING(false), function() -- Locals from https://www.unknowncheats.me/forum/3418914-post13398.html, Values from Heist Control for Nightfall
            local Value = GET_INT_LOCAL("fm_mission_controller", 10098 + 37)
            SET_INT_LOCAL("fm_mission_controller", 10098 + 7, Value)
        end)

    ---

    local TELEPORT_CAH = menu.list(CASINO_HEIST, TRANSLATE("Custom Teleport"), {}, "", function(); end)

        menu.divider(TELEPORT_CAH, TRANSLATE("Inside"))

            menu.action(TELEPORT_CAH, TRANSLATE("Planning Boards (Arcade)"), {}, "", function()
                TELEPORT(2711.773, -369.458, -54.781)
            end)
            menu.action(TELEPORT_CAH, TRANSLATE("Garage Exit (Arcade)"), {}, "", function()
                TELEPORT(2677.237, -361.494, -55.187)
            end)
            menu.action(TELEPORT_CAH, TRANSLATE("Waste Disposal (Casino)"), {}, "", function()
                TELEPORT(2542.052, -214.3084, -58.722965)
            end)
            menu.action(TELEPORT_CAH, TRANSLATE("Staff Lobby (Casino)"), {}, "", function()
                TELEPORT(2547.9192, -273.16754, -58.723003)
            end)
            menu.action(TELEPORT_CAH, TRANSLATE("Mantrap Door (Casino)"), {}, "", function()
                TELEPORT(2465.4746, -279.2276, -70.694145)
            end)
            menu.action(TELEPORT_CAH, TRANSLATE("Inside The Vault (Casino)"), {}, "", function()
                TELEPORT(2515.1252, -238.91661, -70.73713)
            end)
            menu.action(TELEPORT_CAH, TRANSLATE("Outside The Vault (Casino)"), {}, "", function()
                TELEPORT(2497.5098, -238.50768, -70.7388)
            end)
            menu.action(TELEPORT_CAH, TRANSLATE("Daily Cash Storage (Casino)"), {}, "", function()
                TELEPORT(2520.8645, -286.30685, -58.723007)
            end)

        ---

        menu.divider(TELEPORT_CAH, TRANSLATE("Outside"))

            menu.action(TELEPORT_CAH, TRANSLATE("Main Gate (Casino)"), {}, "", function()
                TELEPORT(917.24634, 48.989567, 80.89892)
            end)
            menu.action(TELEPORT_CAH, TRANSLATE("Staff Lobby (Casino)"), {}, "", function()
                TELEPORT(965.14856, -9.05023, 80.63045)
            end)
            menu.action(TELEPORT_CAH, TRANSLATE("Waste Disposal (Casino)"), {}, "", function()
                TELEPORT(997.5346, 84.51491, 80.990555)
            end)

        ---

    ---

    local CASINO_BOARD1 = menu.list(CASINO_HEIST, TRANSLATE("Heist Scope Out (Board 1)"), {}, "", function(); end)

        local BOARD1_APPROACH = menu.list(CASINO_BOARD1, TRANSLATE("Change Approach And Difficulty"), {}, "", function(); end)

            menu.list_action(BOARD1_APPROACH, TRANSLATE("Silent & Sneaky Approach"), {"hccahdiffsil"}, "", {
                { TRANSLATE("Normal"), {"normal"} },
                { TRANSLATE("Hard"), {"hard"} },
            }, function(Index)
                if Index == 1 then
                    STAT_SET_INT("H3_HARD_APPROACH", 0)
                elseif Index == 2 then
                    STAT_SET_INT("H3_HARD_APPROACH", 1)
                end
        
                STAT_SET_INT("H3_LAST_APPROACH", 0)
                STAT_SET_INT("H3OPT_APPROACH", 1)
            end)
        
            menu.list_action(BOARD1_APPROACH, TRANSLATE("BigCon Approach"), {"hccahdiffbig"}, "", {
                { TRANSLATE("Normal"), {"normal"} },
                { TRANSLATE("Hard"), {"hard"} },
            }, function(Index)
                if Index == 1 then
                    STAT_SET_INT("H3_HARD_APPROACH", 0)
                elseif Index == 2 then
                    STAT_SET_INT("H3_HARD_APPROACH", 2)
                end
        
                STAT_SET_INT("H3_LAST_APPROACH", 0)
                STAT_SET_INT("H3OPT_APPROACH", 2)
            end)
        
            menu.list_action(BOARD1_APPROACH, TRANSLATE("Aggressive Approach"), {"hccahdiffagg"}, "", {
                { TRANSLATE("Normal"), {"normal"} },
                { TRANSLATE("Hard"), {"hard"} },
            }, function(Index)
                if Index == 1 then
                    STAT_SET_INT("H3_LAST_APPROACH", 0)
                    STAT_SET_INT("H3OPT_APPROACH", 1)
                elseif Index == 2 then
                    STAT_SET_INT("H3OPT_APPROACH", 3)
                    STAT_SET_INT("H3_HARD_APPROACH", 0)
                end
        
                STAT_SET_INT("H3_LAST_APPROACH", 0)
            end)

        --- 

        menu.list_action(CASINO_BOARD1, TRANSLATE("Change Target"), {"hccahtar"}, "", {
            { TRANSLATE("Diamonds"), {"diamond"} },
            { TRANSLATE("Gold"), {"gold"} },
            { TRANSLATE("Artwork"), {"artwork"} },
            { TRANSLATE("Cash"), {"cash"} },
        }, function(Index)
            if Index == 1 then
                STAT_SET_INT("H3OPT_TARGET", 3)
            elseif Index == 2 then 
                STAT_SET_INT("H3OPT_TARGET", 1)
            elseif Index == 3 then
                STAT_SET_INT("H3OPT_TARGET", 2)
            elseif Index == 4 then
                STAT_SET_INT("H3OPT_TARGET", 0)
            end
        end)

        if STAT_GET_INT("H3OPT_ACCESSPOINTS") ~= 0 then
            AccessPoint = 1
        else
            AccessPoint = 2 
        end
        menu.list_select(CASINO_BOARD1, TRANSLATE("P.O.I And Access Points"), {"hccahpoi"}, TRANSLATE("Change your session to apply!"), {
            { TRANSLATE("Scope(d)"), {"scope"} },
            { TRANSLATE("Unscope(d)"), {"unscope"} },
        }, AccessPoint, function(Index)
            if Index == 1 then
                STAT_SET_INT("H3OPT_POI", -1)
                STAT_SET_INT("H3OPT_ACCESSPOINTS", 2047)
            elseif Index == 2 then
                STAT_SET_INT("H3OPT_POI", 0)
                STAT_SET_INT("H3OPT_ACCESSPOINTS", 0)
            end
        end)

    ---

    local CASINO_BOARD2 = menu.list(CASINO_HEIST, TRANSLATE("Heist Perp Work (Board 2)"), {}, "", function(); end)

        menu.list_action(CASINO_BOARD2, TRANSLATE("Change Gunman"), {"hccahweaponvar"}, "", {
            { TRANSLATE("Chester McCoy") .. " (10%)", {"chester"} },
            { TRANSLATE("Gustavo Mota") .. " (9%)", {"gustavo"} },
            { TRANSLATE("Patrick McReary") .. " (8%)", {"patrick"} },
            { TRANSLATE("Charlie Reed") .. " (7%)", {"charlie"} },
            { TRANSLATE("Karl Abolaji") .. " (5%)", {"karl"} },
            { TRANSLATE("Random") .. " (??%)", {"random"} },
            { TRANSLATE("Remove") .. " (0%)", {"remove"} },
        }, function(Index)
            if Index == 1 then
                STAT_SET_INT("H3OPT_CREWWEAP", 4)
            elseif Index == 2 then
                STAT_SET_INT("H3OPT_CREWWEAP", 2)
            elseif Index == 3 then
                STAT_SET_INT("H3OPT_CREWWEAP", 5)
            elseif Index == 4 then
                STAT_SET_INT("H3OPT_CREWWEAP", 3)
            elseif Index == 5 then
                STAT_SET_INT("H3OPT_CREWWEAP", 1)
            elseif Index == 6 then
                STAT_SET_INT("H3OPT_CREWWEAP", math.random(1, 5))
            elseif Index == 7 then
                STAT_SET_INT("H3OPT_CREWWEAP", 6)
            end
        end)

        menu.list_action(CASINO_BOARD2, TRANSLATE("Weapon Variation"), {"hccahweaponvar"}, "", {
            { TRANSLATE("Best"), {"best"} },
            { TRANSLATE("Worst"), {"worst"} },
        }, function(Index)
            if Index == 1 then
                STAT_SET_INT("H3OPT_WEAPS", 1)
            elseif Index == 2 then
                STAT_SET_INT("H3OPT_WEAPS", 0)
            end
        end)

        menu.list_action(CASINO_BOARD2, TRANSLATE("Change Vehicle"), {"hccahveh"}, "", {
            { TRANSLATE("Chester McCoy") .. " (10%)", {"chester"} },
            { TRANSLATE("Eddie Toh") .. " (9%)", {"eddie"} },
            { TRANSLATE("Taliana Martinez") .. " (7%)", {"taliana"} },
            { TRANSLATE("Zach Nelson") .. " (6%)", {"zach"} },
            { TRANSLATE("Karim Denz") .. " (5%)", {"karim"} },
            { TRANSLATE("Random") .. " (??%)", {"random"} },
            { TRANSLATE("Remove") .. " (0%)", {"remove"} },
        }, function(Index)
            if Index == 1 then
                STAT_SET_INT("H3OPT_CREWDRIVER", 5)
            elseif Index == 2 then
                STAT_SET_INT("H3OPT_CREWDRIVER", 3)
            elseif Index == 3 then
                STAT_SET_INT("H3OPT_CREWDRIVER", 2)
            elseif Index == 4 then
                STAT_SET_INT("H3OPT_CREWDRIVER", 4)
            elseif Index == 5 then
                STAT_SET_INT("H3OPT_CREWDRIVER", 1)
            elseif Index == 6 then
                STAT_SET_INT("H3OPT_CREWDRIVER", math.random(1, 5))
            elseif Index == 7 then
                STAT_SET_INT("H3OPT_CREWDRIVER", 6)
            end
        end)

        menu.list_action(CASINO_BOARD2, TRANSLATE("Vehicle Variation"), {"hccahvehvar"}, "", {
            { TRANSLATE("Best"), {"best"} },
            { TRANSLATE("Good"), {"good"} },
            { TRANSLATE("Fine"), {"fine"} },
            { TRANSLATE("Worst"), {"worst"} },
            { TRANSLATE("Random"), {"random"} },
        }, function(Index)
            if Index == 1 then
                STAT_SET_INT("H3OPT_VEHS", 3)
            elseif Index == 2 then
                STAT_SET_INT("H3OPT_VEHS", 2)
            elseif Index == 3 then
                STAT_SET_INT("H3OPT_VEHS", 1)
            elseif Index == 4 then
                STAT_SET_INT("H3OPT_VEHS", 0)
            elseif Index == 5 then
                STAT_SET_INT("H3OPT_VEHS", math.random(0, 3))
            end
        end)

        menu.list_action(CASINO_BOARD2, TRANSLATE("Change Hacker"), {"hccahhack"}, "", {
            { TRANSLATE("Avi Schwartzman") .. " (10%)", {"avi"} },
            { TRANSLATE("Paige Harris") .. " (9%)", {"paige"} },
            { TRANSLATE("Christian Feltz") .. " (7%)", {"christian"} },
            { TRANSLATE("Yohan Blair") .. " (5%)", {"yohan"} },
            { TRANSLATE("Rickie Luken") .. " (3%)", {"rickie"} },
            { TRANSLATE("Random") .. " (??%)", {"random"} },
            { TRANSLATE("Remove") .. " (0%)", {"remove"} },
        }, function(Index)
            if Index == 1 then
                STAT_SET_INT("H3OPT_CREWHACKER", 4)
            elseif Index == 2 then
                STAT_SET_INT("H3OPT_CREWHACKER", 5)
            elseif Index == 3 then
                STAT_SET_INT("H3OPT_CREWHACKER", 2)
            elseif Index == 4 then
                STAT_SET_INT("H3OPT_CREWHACKER", 3)
            elseif Index == 5 then
                STAT_SET_INT("H3OPT_CREWHACKER", 1)
            elseif Index == 6 then
                STAT_SET_INT("H3OPT_CREWHACKER", math.random(1, 5))
            elseif Index == 7 then
                STAT_SET_INT("H3OPT_CREWHACKER", 6)
            end
        end)

        menu.list_action(CASINO_BOARD2, TRANSLATE("Choose Masks"), {"hccahmask"}, "", {
            { TRANSLATE("Remove Masks"), {"remove"} },
            { TRANSLATE("Geometric Set"), {"geometric"} },
            { TRANSLATE("Hunter Set"), {"hunter"} },
            { TRANSLATE("Oni Half Mask Set"), {"onihalf"} },
            { TRANSLATE("Emoji Set"), {"emoji"} },
            { TRANSLATE("Ornate Skull Set"), {"ornate"} },
            { TRANSLATE("Lucky Fruit Set"), {"lucky"} },
            { TRANSLATE("Guerilla Set"), {"guerilla"} },
            { TRANSLATE("Clown Set"), {"clown"} },
            { TRANSLATE("Animal Set"), {"animal"} },
            { TRANSLATE("Riot Set"), {"riot"} },
            { TRANSLATE("Oni Set"), {"oni"} },
            { TRANSLATE("Hockey Set"), {"hockey"} },
        }, function(Index)
            if Index == 1 then
                STAT_SET_INT("H3OPT_MASKS", -1)
            else
                STAT_SET_INT("H3OPT_MASKS", Index - 1)
            end
        end)

        menu.click_slider(CASINO_BOARD2, TRANSLATE("Security Pass Level"), {"hccahcard"}, "", 0, 2, 2, 1, function(Value)
            STAT_SET_INT("H3OPT_KEYLEVELS", Value)
        end)
        menu.click_slider(CASINO_BOARD2, TRANSLATE("Guards Strength Level"), {"hccahguard"}, TRANSLATE("0 - Strongest Guards") .. "\n" .. TRANSLATE("3 - Weakest Guards"), 0, 3, 3, 1, function(Value)
            STAT_SET_INT("H3OPT_DISRUPTSHIP", Value)
        end)

    ---

    local CASINO_BOARD3 = menu.list(CASINO_HEIST, TRANSLATE("Heist Planning (Board 3)"), {}, "", function(); end)

        menu.divider(CASINO_BOARD3, TRANSLATE("Remove Drills"))

            menu.action(CASINO_BOARD3, TRANSLATE("Silent & Sneaky and Aggressive Approach"), {"hccahremsilaggdrill"}, "", function()
                STAT_SET_INT("H3OPT_BITSET0", -8849)
            end)
            menu.action(CASINO_BOARD3, TRANSLATE("BigCon Approach"), {"hccahrembigdrill"}, "", function()
                STAT_SET_INT("H3OPT_BITSET0", -186)
            end)

        ---

    ---

    menu.list_action(CASINO_HEIST, TRANSLATE("Board Loader And Unloader"), {"hccahboard"}, "", {
        { TRANSLATE("Load All Of The Boards"), {"load"} },
        { TRANSLATE("Unload All Of The Boards"), {"unload"} },
    }, function(Index)
        if Index == 1 then
            STAT_SET_INT("H3OPT_BITSET1", -1)
            STAT_SET_INT("H3OPT_BITSET0", -1)
        elseif Index == 2 then
            STAT_SET_INT("H3OPT_BITSET1", 0)
            STAT_SET_INT("H3OPT_BITSET0", 0)
        end
    end)

    menu.list_action(CASINO_HEIST, TRANSLATE("Casino Story Missions"), {}, "", {
        { TRANSLATE("Loose Cheng") },
        { TRANSLATE("House Keeping") },
        { TRANSLATE("Strong Arm Tactics") },
        { TRANSLATE("Play to Win") },
        { TRANSLATE("Bad Beat") },
        { TRANSLATE("Cashing Out") },
    }, function(Index)
        if Index == 1 then
            STAT_SET_INT("VCM_FLOW_PROGRESS", 1048576)
        elseif Index == 2 then
            STAT_SET_INT("VCM_FLOW_PROGRESS", 1310785)
        elseif Index == 3 then
            STAT_SET_INT("VCM_FLOW_PROGRESS", 1310915)
        elseif Index == 4 then
            STAT_SET_INT("VCM_FLOW_PROGRESS", 1311175)
        elseif Index == 5 then
            STAT_SET_INT("VCM_FLOW_PROGRESS", 1311695)
        elseif Index == 6 then
            STAT_SET_INT("VCM_FLOW_PROGRESS", 1312735)  
        end

        STAT_SET_INT("VCM_STORY_PROGRESS", Index - 1)
    end)

    local CASINO_MORE = menu.list(CASINO_HEIST, TRANSLATE("Others"), {}, "", function(); end)

        menu.action(CASINO_MORE, TRANSLATE("Unlock Heist Awards"), {}, "", function()
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

        menu.action(CASINO_MORE, TRANSLATE("Remove Heist Cooldown"), {}, TRANSLATE("Note that this doesn't bypass server-side cooldown time, just bypassing payment."), function()
            STAT_SET_INT("H3_COMPLETEDPOSIX", -1)
            STAT_SET_INT("MPPLY_H3_COOLDOWN", -1)
        end)

        menu.action(CASINO_MORE, TRANSLATE("Skip Ms. Baker missions to the Cashing Out (Last One)"), {}, "", function()
            STAT_SET_INT("VCM_FLOW_PROGRESS", -1)
            STAT_SET_INT("VCM_STORY_PROGRESS", 5)
            STAT_SET_BOOL("AWD_LEADER", true)
            STAT_SET_BOOL("VCM_FLOW_CS_FIN_SEEN", true)
        end)

        menu.action(CASINO_MORE, TRANSLATE("Set Heist to Default [Reset]"), {"hccahreset"}, "", function()
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
        end)

    ---

---


--- Doomsday Heist

    menu.list_action(DOOMS_HEIST, TRANSLATE("Automated Presets") .. " " .. TRANSLATE("(Final Heist)"), {"hcdoomspreset"}, "", {
        { TRANSLATE("The Data Breaches ACT I"), {"1st"} },
        { TRANSLATE("The Bogdan Problem ACT II"), {"2nd"} },
        { TRANSLATE("The Doomsday Scenario ACT III"), {"3rd"} },
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

    local TELEPORT_DOOMS = menu.list(DOOMS_HEIST, TRANSLATE("Custom Teleport"), {}, "", function(); end)

        menu.action(TELEPORT_DOOMS, TRANSLATE("Heist Screen on Facility"), {}, TRANSLATE("Make sure you are in the your facility."), function()
            TELEPORT(350.69284, 4872.308, -60.794243)
            SET_HEADING(-50)
        end)
        menu.action(TELEPORT_DOOMS, TRANSLATE("Heist Board"), {}, "(" .. TRANSLATE("The Bogdan Problem ACT II") .. ")", function()
            TELEPORT(515.528, 4835.353, -62.587)
        end)
        menu.action(TELEPORT_DOOMS, TRANSLATE("Prisoner Cell"), {}, "(" .. TRANSLATE("The Bogdan Problem ACT II") .. ")", function()
            TELEPORT(512.888, 4833.033, -68.989)
        end)

    ---

    local DDHEIST_PLYR_MANAGER = menu.list(DOOMS_HEIST, TRANSLATE("Player's Cut"), {}, "", function(); end)

        local DDHEIST_HOST_MANAGER = menu.list(DDHEIST_PLYR_MANAGER, TRANSLATE("Your Cut"), {}, "", function(); end)

            DOOMS_HOST_CUT_LOOP = menu.toggle_loop(DDHEIST_HOST_MANAGER, TRANSLATE("Enable"), {"hcdooms1ploop"}, IS_WORKING(false), function()
                SET_INT_GLOBAL(1966831 + 812 + 50 + 1, menu.get_value(DOOMS_HOST_CUT)) -- gb_gang_ops_planning.c
            end, function()
                SET_INT_GLOBAL(1966831 + 812 + 50 + 1, 100)
            end)

            DOOMS_HOST_CUT = menu.slider(DDHEIST_HOST_MANAGER, TRANSLATE("Custom Percentage"), {"hcdooms1pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

        ---

        local DDHEIST_PLAYER2_MANAGER = menu.list(DDHEIST_PLYR_MANAGER, TRANSLATE("Player 2"), {}, "", function(); end)
            
            DOOMS_2P_CUT_LOOP = menu.toggle_loop(DDHEIST_PLAYER2_MANAGER, TRANSLATE("Enable"), {"hcdooms2pcutloop"}, IS_WORKING(false), function()
                SET_INT_GLOBAL(1966831 + 812 + 50 + 2, menu.get_value(DOOMS_2P_CUT)) -- gb_gang_ops_planning.c
            end, function()
                SET_INT_GLOBAL(1966831 + 812 + 50 + 2, 100)
            end)

            DOOMS_2P_CUT = menu.slider(DDHEIST_PLAYER2_MANAGER, TRANSLATE("Custom Percentage"), {"hcdooms2pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

        ---

        local DDHEIST_PLAYER3_MANAGER = menu.list(DDHEIST_PLYR_MANAGER, TRANSLATE("Player 3"), {}, "", function(); end)

            DOOMS_3P_CUT_LOOP = menu.toggle_loop(DDHEIST_PLAYER3_MANAGER, TRANSLATE("Enable"), {"hcdooms3pcutloop"}, IS_WORKING(false), function()
                SET_INT_GLOBAL(1966831 + 812 + 50 + 3, menu.get_value(DOOMS_3P_CUT)) -- gb_gang_ops_planning.c
            end, function()
                SET_INT_GLOBAL(1966831 + 812 + 50 + 3, 100)
            end)

            DOOMS_3P_CUT = menu.slider(DDHEIST_PLAYER3_MANAGER, TRANSLATE("Custom Percentage"), {"hcdooms3pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

        ---

        local DDHEIST_PLAYER4_MANAGER = menu.list(DDHEIST_PLYR_MANAGER, TRANSLATE("Player 4"), {}, "", function(); end)

            DOOMS_4P_CUT_LOOP = menu.toggle_loop(DDHEIST_PLAYER4_MANAGER, TRANSLATE("Enable"), {"hcdooms4pcutloop"}, IS_WORKING(false), function()
                SET_INT_GLOBAL(1966831 + 812 + 50 + 4, menu.get_value(DOOMS_4P_CUT)) -- gb_gang_ops_planning.c
            end, function()
                SET_INT_GLOBAL(1966831 + 812 + 50 + 4, 100)
            end)

            DOOMS_4P_CUT = menu.slider(DDHEIST_PLAYER4_MANAGER, TRANSLATE("Custom Percentage"), {"hcdooms4pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

        ---

        menu.toggle_loop(DDHEIST_PLYR_MANAGER, TRANSLATE("Modify ACT I Payment ($2.5 Millions)"), {"hcdooms1stpay"}, IS_WORKING(true) .. TRANSLATE("Set difficulty as hard. In-Game percentage may seem weird. Applied to everyone."), function()
            menu.set_value(DOOMS_HOST_CUT, 209)
            menu.set_value(DOOMS_HOST_CUT_LOOP, true)
            menu.set_value(DOOMS_2P_CUT, 209)
            menu.set_value(DOOMS_2P_CUT_LOOP, true)
            menu.set_value(DOOMS_3P_CUT, 209)
            menu.set_value(DOOMS_3P_CUT_LOOP, true)
            menu.set_value(DOOMS_4P_CUT, 209)
            menu.set_value(DOOMS_4P_CUT_LOOP, true)
        end, function()
            menu.set_value(DOOMS_HOST_CUT, 100)
            menu.set_value(DOOMS_HOST_CUT_LOOP, false)
            menu.set_value(DOOMS_2P_CUT, 100)
            menu.set_value(DOOMS_2P_CUT_LOOP, false)
            menu.set_value(DOOMS_3P_CUT, 100)
            menu.set_value(DOOMS_3P_CUT_LOOP, false)
            menu.set_value(DOOMS_4P_CUT, 100)
            menu.set_value(DOOMS_4P_CUT_LOOP, false)
        end)

        menu.toggle_loop(DDHEIST_PLYR_MANAGER, TRANSLATE("Modify ACT II Payment ($2.5 Millions)"), {"hcdooms2ndpay"}, IS_WORKING(true) .. TRANSLATE("Set difficulty as hard. In-Game percentage may seem weird. Applied to everyone."), function()
            menu.set_value(DOOMS_HOST_CUT, 142)
            menu.set_value(DOOMS_HOST_CUT_LOOP, true)
            menu.set_value(DOOMS_2P_CUT, 142)
            menu.set_value(DOOMS_2P_CUT_LOOP, true)
            menu.set_value(DOOMS_3P_CUT, 142)
            menu.set_value(DOOMS_3P_CUT_LOOP, true)
            menu.set_value(DOOMS_4P_CUT, 142)
            menu.set_value(DOOMS_4P_CUT_LOOP, true)
        end, function()
            menu.set_value(DOOMS_HOST_CUT, 100)
            menu.set_value(DOOMS_HOST_CUT_LOOP, false)
            menu.set_value(DOOMS_2P_CUT, 100)
            menu.set_value(DOOMS_2P_CUT_LOOP, false)
            menu.set_value(DOOMS_3P_CUT, 100)
            menu.set_value(DOOMS_3P_CUT_LOOP, false)
            menu.set_value(DOOMS_4P_CUT, 100)
            menu.set_value(DOOMS_4P_CUT_LOOP, false)
        end)

        menu.toggle_loop(DDHEIST_PLYR_MANAGER, TRANSLATE("Modify ACT III Payment ($2.5 Millions)"), {"hcdooms3rdpay"}, IS_WORKING(true) .. TRANSLATE("Set difficulty as hard. In-Game percentage may seem weird. Applied to everyone."), function()
            menu.set_value(DOOMS_HOST_CUT, 113)
            menu.set_value(DOOMS_HOST_CUT_LOOP, true)
            menu.set_value(DOOMS_2P_CUT, 113)
            menu.set_value(DOOMS_2P_CUT_LOOP, true)
            menu.set_value(DOOMS_3P_CUT, 113)
            menu.set_value(DOOMS_3P_CUT_LOOP, true)
            menu.set_value(DOOMS_4P_CUT, 113)
            menu.set_value(DOOMS_4P_CUT_LOOP, true)
        end, function()
            menu.set_value(DOOMS_HOST_CUT, 100)
            menu.set_value(DOOMS_HOST_CUT_LOOP, false)
            menu.set_value(DOOMS_2P_CUT, 100)
            menu.set_value(DOOMS_2P_CUT_LOOP, false)
            menu.set_value(DOOMS_3P_CUT, 100)
            menu.set_value(DOOMS_3P_CUT_LOOP, false)
            menu.set_value(DOOMS_4P_CUT, 100)
            menu.set_value(DOOMS_4P_CUT_LOOP, false)
        end)

    ---

    menu.toggle_loop(DOOMS_HEIST, TRANSLATE("Skip The Hacking Process"), {}, IS_WORKING(true) .. "(" .. TRANSLATE("The Doomsday Scenario ACT III") .. " & " .. TRANSLATE("The Data Breaches ACT I") .. " - " .. TRANSLATE("Setup: Server Farm (Lester)") .. ")", function() -- https://www.unknowncheats.me/forum/3455828-post8.html
        SET_INT_LOCAL("fm_mission_controller", 1265 + 135, 3) -- For ACT III
        SET_INT_LOCAL("fm_mission_controller", 1510, 2) -- For ACT I, Setup: Server Farm (Lester)
    end)

    menu.action(DOOMS_HEIST, TRANSLATE("Unlock All Doomsday Heists"), {}, "", function()
        STAT_SET_INT("GANGOPS_HEIST_STATUS", -1)
        STAT_SET_INT("GANGOPS_HEIST_STATUS", -229384)
    end)

    menu.action(DOOMS_HEIST, TRANSLATE("Unlock Heist Awards"), {}, "", function()
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

    menu.action(DOOMS_HEIST, TRANSLATE("Complete All Preps (Not Setups)"), {}, "", function()
        STAT_SET_INT("GANGOPS_FM_MISSION_PROG", -1)
    end)

    menu.action(DOOMS_HEIST, TRANSLATE("Set Heist to Default [Reset]"), {"hcdoomsreset"}, TRANSLATE("Change your session to apply!"), function()
        STAT_SET_INT("GANGOPS_FLOW_MISSION_PROG", 240)
        STAT_SET_INT("GANGOPS_HEIST_STATUS", 0)
        STAT_SET_INT("GANGOPS_FLOW_NotifyS", 1557)
    end)

---


--- Classic Heist

    local FLEECA_HEIST = menu.list(CLASSIC_HEISTS, TRANSLATE("Fleeca Heist"), {}, "", function(); end)

        menu.divider(FLEECA_HEIST, TRANSLATE("Your Payout (Million)"))
        
            menu.toggle_loop(FLEECA_HEIST, TRANSLATE("Enable"), {"hcfleecapayloop"}, IS_WORKING(true) .. TRANSLATE("Will be applied only to you and you have to be the host") .. "\n\n" .. TRANSLATE("- Only do this only 1-2 times in less than 24 hours.") .. "\n" .. TRANSLATE("- Otherwise, you can be banned!"), function(Toggle)
                local Value = 100
                if menu.get_value(FLEECA_PAYOUT) == 5 then
                    Value = 1987
                elseif menu.get_value(FLEECA_PAYOUT) == 10 then
                    Value = 3974
                elseif menu.get_value(FLEECA_PAYOUT) == 15 then
                    Value = 5961
                end

                SET_INT_GLOBAL(1937658 + 3008 + 1, Value) -- fmmc_launcher.c
            end, function()
                SET_INT_GLOBAL(1937658 + 3008 + 1, 100)
            end)

            FLEECA_PAYOUT = menu.slider(FLEECA_HEIST, TRANSLATE("Modify The Payout"), {"hcfleecapay"}, "", 5, 15, 15, 5, function(Value); end)

        ---

        menu.divider(FLEECA_HEIST, TRANSLATE("Others"))

            menu.toggle_loop(FLEECA_HEIST, TRANSLATE("Complete All Setup"), {}, TRANSLATE("You may need to choose a new Heist and then complete the first setup for it to activate"), function()
                STAT_SET_INT("HEIST_PLANNING_STAGE", -1)
            end)
            menu.toggle_loop(FLEECA_HEIST, TRANSLATE("Skip The Hacking Process"), {}, IS_WORKING(false), function() -- https://www.unknowncheats.me/forum/3455828-post8.html
                SET_INT_LOCAL("fm_mission_controller", 11757 + 24, 7)
            end)
            menu.toggle_loop(FLEECA_HEIST, TRANSLATE("Skip Drilling"), {}, "", function() -- https://www.unknowncheats.me/forum/3485435-post19.html
                SET_FLOAT_LOCAL("fm_mission_controller", 10058 + 11, 100)
            end)

        ---

    ---

    menu.action(CLASSIC_HEISTS, TRANSLATE("Unlock Heist Awards"), {}, "", function()
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

---


--- LS Robbery

    menu.toggle_loop(LS_ROBBERY, TRANSLATE("Modify Contracts payout - $1 Million"), {"hcls1m"}, IS_WORKING(true) .. TRANSLATE("(Local)") .. "\n\n" .. TRANSLATE("Always keep this option enabled before starting a contract"), function()
        SET_INT_GLOBAL(262145 + 31041, 1000000) -- -1834943393
        SET_INT_GLOBAL(262145 + 31042 + 0, 1000000) -- -920277662
        SET_INT_GLOBAL(262145 + 31042 + 1, 1000000) -- 391170487
        SET_INT_GLOBAL(262145 + 31042 + 2, 1000000) -- -1073898730
        SET_INT_GLOBAL(262145 + 31042 + 3, 1000000) -- -842025286
        SET_INT_GLOBAL(262145 + 31042 + 4, 1000000) -- -724024117
        SET_INT_GLOBAL(262145 + 31042 + 5, 1000000) -- -492445594
        SET_INT_GLOBAL(262145 + 31042 + 6, 1000000) -- 1996622112
        SET_INT_GLOBAL(262145 + 31042 + 7, 1000000) -- -2066209588
        SET_FLOAT_GLOBAL(262145 + 31038, 0) -- 1830621208
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
    
    local ROBBERY_RESETER = menu.list(LS_ROBBERY, TRANSLATE("Others"), {}, "", function(); end)
    
        menu.action(ROBBERY_RESETER, TRANSLATE("Reset The Preps"), {"hclsresetmisson"}, "", function()
            STAT_SET_INT("TUNER_GEN_BS", 12467)
        end)
        menu.action(ROBBERY_RESETER, TRANSLATE("Reset The Contracts"), {"hclsresetcontract"}, "", function()
            STAT_SET_INT("TUNER_GEN_BS", 8371)
            STAT_SET_INT("TUNER_CURRENT", -1)
        end)
        menu.action(ROBBERY_RESETER, TRANSLATE("Reset Total Gains And Completed Contracts"), {"hclsresetgain"}, "", function()
            STAT_SET_INT("TUNER_COUNT", 0)
            STAT_SET_INT("TUNER_EARNINGS", 0)
        end)
    
    ---

---


--- ULP Missions

    menu.divider(ULP_MISSIONS, TRANSLATE("ULP Missions"))

        local UlpMissionsTable = {
            TRANSLATE("Intelligence"),
            TRANSLATE("Counterintelligence"),
            TRANSLATE("Extraction"),
            TRANSLATE("Asset Seizure"),
            TRANSLATE("Operation Paper Trail"),
            TRANSLATE("Cleanup"),
        }
        for i = 1, #UlpMissionsTable do
            menu.action(ULP_MISSIONS, UlpMissionsTable[i], {}, "", function()
                STAT_SET_INT("ULP_MISSION_CURRENT", i - 1)
                STAT_SET_INT("ULP_MISSION_PROGRESS", 127)
            end)
        end

    ---

    menu.divider(ULP_MISSIONS, TRANSLATE("Others"))

        menu.toggle_loop(ULP_MISSIONS, TRANSLATE("Skip The Hacking Process"), {}, TRANSLATE("(" .. TRANSLATE("ULP Missions") .. " - " .. TRANSLATE("Counterintelligence") .. ")"), function() -- Thanks for coding this, Pedro9558#3559
            SET_INT_LOCAL("fm_mission_controller_2020", 974 + 135, 3)
        end)
        menu.action(ULP_MISSIONS, TRANSLATE("Teleport To IAA Headquarters"), {}, "", function()
            TELEPORT(101.595, -662.923, 45.093)
        end)

    ---

---


--- The Contract: Agency

    local CONTRACT_VIP = menu.list(TH_CONTRACT, TRANSLATE("VIP Contract: Dr.Dre"), {}, TRANSLATE("The feature to be worked properly, you may need to log out of F.Clinton & Partner"), function(); end)

        menu.list_action(CONTRACT_VIP, TRANSLATE("NightLife Leak"), {"hcagcnightlife"}, "", {
            { TRANSLATE("The Nightclub (Prep)"), {"nightclub"} },
            { TRANSLATE("The Marina (Prep)"), {"marina"} },
            { TRANSLATE("NightLife Leak (Mission)"), {"mission"} },
        }, function(Index)
            if Index == 1 then
                STAT_SET_INT("FIXER_STORY_BS", 3)
            elseif Index == 2 then
                STAT_SET_INT("FIXER_STORY_BS", 4)
            elseif Index == 3 then
                STAT_SET_INT("FIXER_STORY_BS", 12)
            end

            STAT_SET_INT("FIXER_GENERAL_BS", -1)
            STAT_SET_INT("FIXER_COMPLETED_BS", -1)
            STAT_SET_INT("FIXER_STORY_COOLDOWN", -1)
        end)

        menu.list_action(CONTRACT_VIP, TRANSLATE("High Society Leak"), {"hcagcsociety"}, "", {
            { TRANSLATE("The Country Club (Prep)"), {"club"} },
            { TRANSLATE("Guest List (Prep)"), {"guest"} },
            { TRANSLATE("High Society (Mission)"), {"mission"} },
        }, function(Index)
            if Index == 1 then
                STAT_SET_INT("FIXER_STORY_BS", 28)
            elseif Index == 2 then
                STAT_SET_INT("FIXER_STORY_BS", 60)
            elseif Index == 3 then
                STAT_SET_INT("FIXER_STORY_BS", 124)
            end

            STAT_SET_INT("FIXER_GENERAL_BS", -1)
            STAT_SET_INT("FIXER_COMPLETED_BS", -1)
            STAT_SET_INT("FIXER_STORY_STRAND", -1)
            STAT_SET_INT("FIXER_STORY_COOLDOWN", -1)
        end)

        menu.list_action(CONTRACT_VIP, TRANSLATE("South Central Leak"), {"hcagccentral"}, TRANSLATE("Change your session to apply!"), {
            { TRANSLATE("Davis (Prep)"), {"davis"} },
            { TRANSLATE("The Ballas (Prep)"), {"ballas"} },
            { TRANSLATE("Agency Studio (Mission)"), {"studio"} },
            { TRANSLATE("Finale: Don't Fuck with Dre"), {"final"} },
        }, function(Index)
            if Index == 1 then
                STAT_SET_INT("FIXER_STORY_BS", 252)
            elseif Index == 2 then
                STAT_SET_INT("FIXER_STORY_BS", 508)
            elseif Index == 3 then
                STAT_SET_INT("FIXER_STORY_BS", 2044)
            elseif Index == 4 then
                STAT_SET_INT("FIXER_STORY_BS", 4092)
            end

            STAT_SET_INT("FIXER_GENERAL_BS", -1)
            STAT_SET_INT("FIXER_COMPLETED_BS", -1)
            STAT_SET_INT("FIXER_STORY_STRAND", -1)
            STAT_SET_INT("FIXER_STORY_COOLDOWN", -1)
        end)

        menu.toggle_loop(TH_CONTRACT, TRANSLATE("Modify Finale's Payout (2 Million)"), {"hcagcpay"}, IS_WORKING(true) .. TRANSLATE("(Local)"), function()
            SET_INT_GLOBAL(262145 + 31747, 2000000) -- -2108119120
        end, function()
            SET_INT_GLOBAL(262145 + 31747, 1000000)
        end)

        menu.toggle_loop(TH_CONTRACT, TRANSLATE("Skip The Cooldown Of Contracts and Payphone Hits"), {"hcagccoolhit"}, IS_WORKING(true) .. TRANSLATE("Make sure it's enabled before starting any contracts or hits."), function() -- Credit goes to Da Chaos#9262
            SET_INT_GLOBAL(262145 + 31701, 0) -- -1462622971
            SET_INT_GLOBAL(262145 + 31765, 0) -- -2036534141
        end, function()
            SET_INT_GLOBAL(262145 + 31701, 300000)
            SET_INT_GLOBAL(262145 + 31765, 500)
        end)

        menu.toggle_loop(TH_CONTRACT, TRANSLATE("Remove Security Mission's Cooldown"), {"hcagcremcool"}, IS_WORKING(false), function()
            SET_INT_GLOBAL(262145 + 31781, 0) -- 1872071131
        end, function()
            SET_INT_GLOBAL(262145 + 31781, 1200000)
        end)

        menu.action(TH_CONTRACT, TRANSLATE("Complete All Missions"), {}, "", function()
            STAT_SET_INT("FIXER_GENERAL_BS", -1)
            STAT_SET_INT("FIXER_COMPLETED_BS", -1)
            STAT_SET_INT("FIXER_STORY_BS", -1)
            STAT_SET_INT("FIXER_STORY_COOLDOWN", -1)
        end)

        menu.action(TH_CONTRACT, TRANSLATE("Unlock Heist Awards"), {}, "", function()
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

---


--- Master Unlocker

    local DLC_UNLOCKER = menu.list(MASTER_UNLOCKR, TRANSLATE("DLCs"), {}, "", function(); end)

        local ARENA_TOOL = menu.list(DLC_UNLOCKER, TRANSLATE("Arena Wars DLC"), {}, "", function(); end)

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

            menu.action(ARENA_TOOL, TRANSLATE("Arena Wars Clothing"), {}, IS_WORKING(false), function()
                SET_PACKED_INT_GLOBAL(25842, 25909, 1) -- -1782918513, -1597048932
            end)

        ---

        local SUMMER2020 = menu.list(DLC_UNLOCKER, TRANSLATE("Summer 2020 DLC"), {}, "", function(); end)
                
            menu.action(SUMMER2020, TRANSLATE("Summer 2020 Awards"), {}, "", function()
                STAT_SET_BOOL("AWD_KINGOFQUB3D", true)
                STAT_SET_BOOL("AWD_QUBISM", true)
                STAT_SET_BOOL("AWD_QUIBITS", true)
                STAT_SET_BOOL("AWD_GODOFQUB3D", true)
                STAT_SET_BOOL("AWD_GOFOR11TH", true)
                STAT_SET_BOOL("AWD_ELEVENELEVEN", true)
            end)

            menu.action(SUMMER2020, TRANSLATE("Unlock Summer DLC Clothing"), {}, IS_WORKING(false), function()
                SET_PACKED_INT_GLOBAL(29685, 29720, 1) -- -1685644799, 1216916542
            end)

        ---

        local TUNERS_DLC = menu.list(DLC_UNLOCKER, TRANSLATE("LS Tuners DLC"), {}, "", function(); end)

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

        local CONTRACT_DLC = menu.list(DLC_UNLOCKER, TRANSLATE("The Contract DLC" ), {}, "", function(); end)

            menu.action(CONTRACT_DLC, TRANSLATE("Unlock Animal Masks"), {}, IS_WORKING(false), function()
                SET_PACKED_INT_GLOBAL(31859, 31870, 1) -- 1322343910, -1255995444
            end)
            menu.action(CONTRACT_DLC, TRANSLATE("Unlock DJ Pooh Shirts"), {}, IS_WORKING(false), function()
                SET_PACKED_INT_GLOBAL(31871, 31873, 1) -- -2066580907, -1668169283
            end)

        ---

        local CRIMINAL_DLC = menu.list(DLC_UNLOCKER, TRANSLATE("The Criminal Enterprises DLC"), {}, "", function(); end) -- https://www.unknowncheats.me/forum/3492512-post53.html
            
            menu.action(CRIMINAL_DLC, TRANSLATE("Jackets / Sweaters / Hoodies / Shirts"), {}, IS_WORKING(false), function()
                SET_PACKED_INT_GLOBAL(32907, 32914, 1) -- -1967834023, -1263992372
                SET_PACKED_INT_GLOBAL(32930, 32935, 1) -- -206691492, -1577621449
            end)
            menu.action(CRIMINAL_DLC, TRANSLATE("Pants / Caps / Hats"), {}, IS_WORKING(false), function()
                SET_INT_GLOBAL(262145 + 32913, 1) -- -339902614
                SET_PACKED_INT_GLOBAL(32917, 32919, 1) -- 638571354, 96152168
                SET_PACKED_INT_GLOBAL(32936, 32937, 1) -- -2120678580, -1003907171
                SET_PACKED_INT_GLOBAL(32988, 33001, 1) -- 191276118, -1484490421
                SET_PACKED_INT_GLOBAL(33654, 33662, 1) -- 466041728, Between 197902950 and -1267850277
            end)
            menu.action(CRIMINAL_DLC, TRANSLATE("Earphones / Masks / Tech Demon"), {}, IS_WORKING(false), function()
                SET_INT_GLOBAL(262145 + 32929, 1) -- 505550305
                SET_PACKED_INT_GLOBAL(33002, 33013, 1) -- -889497715, -1162924007
                SET_PACKED_INT_GLOBAL(32922, 32927, 1) -- 1096886904, -359187968
                SET_PACKED_INT_GLOBAL(32942, 32950, 1) -- 190205845, -171130807
                SET_PACKED_INT_GLOBAL(32954, 32957, 1) -- 1424509866, -1677619307
                SET_PACKED_INT_GLOBAL(32958, 32983, 1) -- -1285035231, -1792568167
            end)
            menu.action(CRIMINAL_DLC, TRANSLATE("Shoes (Sliders) / Tiger"), {}, IS_WORKING(false), function()
                SET_PACKED_INT_GLOBAL(32984, 32987, 1) -- 467678514, 169972145
                SET_PACKED_INT_GLOBAL(33014, 33037, 1) -- 245491514, -141827484
            end)
            
        ---

    ---

    local UNLOCKER_BUILDING = menu.list(MASTER_UNLOCKR, TRANSLATE("Buildings"), {}, "", function(); end)

        local ARCADE_TOOL = menu.list(UNLOCKER_BUILDING, TRANSLATE("Arcade Unlockers"), {}, "", function(); end)

            menu.action(ARCADE_TOOL, TRANSLATE("Unlock Arcade Trophies and Toys"), {}, "", function()
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
                STAT_SET_INT("IAP_INITIALS_0", 50)
                STAT_SET_INT("IAP_INITIALS_1", 50)
                STAT_SET_INT("IAP_INITIALS_2", 50)
                STAT_SET_INT("IAP_INITIALS_3", 50)
                STAT_SET_INT("IAP_INITIALS_4", 50)
                STAT_SET_INT("IAP_INITIALS_5", 50)
                STAT_SET_INT("IAP_INITIALS_6", 50)
                STAT_SET_INT("IAP_INITIALS_7", 50)
                STAT_SET_INT("IAP_INITIALS_8", 50)
                STAT_SET_INT("IAP_INITIALS_9", 50)
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
                STAT_SET_INT("DG_DEFENDER_INITIALS_0", 69644)
                STAT_SET_INT("DG_DEFENDER_INITIALS_1", 69644)
                STAT_SET_INT("DG_DEFENDER_INITIALS_2", 69644)
                STAT_SET_INT("DG_DEFENDER_INITIALS_3", 69644)
                STAT_SET_INT("DG_DEFENDER_INITIALS_4", 69644)
                STAT_SET_INT("DG_DEFENDER_INITIALS_5", 69644)
                STAT_SET_INT("DG_DEFENDER_INITIALS_6", 69644)
                STAT_SET_INT("DG_DEFENDER_INITIALS_7", 69644)
                STAT_SET_INT("DG_DEFENDER_INITIALS_8", 69644)
                STAT_SET_INT("DG_DEFENDER_INITIALS_9", 69644)
                STAT_SET_INT("DG_DEFENDER_SCORE_0", 50)
                STAT_SET_INT("DG_DEFENDER_SCORE_1", 50)
                STAT_SET_INT("DG_DEFENDER_SCORE_2", 50)
                STAT_SET_INT("DG_DEFENDER_SCORE_3", 50)
                STAT_SET_INT("DG_DEFENDER_SCORE_4", 50)
                STAT_SET_INT("DG_DEFENDER_SCORE_5", 50)
                STAT_SET_INT("DG_DEFENDER_SCORE_6", 50)
                STAT_SET_INT("DG_DEFENDER_SCORE_7", 50)
                STAT_SET_INT("DG_DEFENDER_SCORE_8", 50)
                STAT_SET_INT("DG_DEFENDER_SCORE_9", 50)
                STAT_SET_INT("DG_MONKEY_INITIALS_0", 69644)
                STAT_SET_INT("DG_MONKEY_INITIALS_1", 69644)
                STAT_SET_INT("DG_MONKEY_INITIALS_2", 69644)
                STAT_SET_INT("DG_MONKEY_INITIALS_3", 69644)
                STAT_SET_INT("DG_MONKEY_INITIALS_4", 69644)
                STAT_SET_INT("DG_MONKEY_INITIALS_5", 69644)
                STAT_SET_INT("DG_MONKEY_INITIALS_6", 69644)
                STAT_SET_INT("DG_MONKEY_INITIALS_7", 69644)
                STAT_SET_INT("DG_MONKEY_INITIALS_8", 69644)
                STAT_SET_INT("DG_MONKEY_INITIALS_9", 69644)
                STAT_SET_INT("DG_MONKEY_SCORE_0", 50)
                STAT_SET_INT("DG_MONKEY_SCORE_1", 50)
                STAT_SET_INT("DG_MONKEY_SCORE_2", 50)
                STAT_SET_INT("DG_MONKEY_SCORE_3", 50)
                STAT_SET_INT("DG_MONKEY_SCORE_4", 50)
                STAT_SET_INT("DG_MONKEY_SCORE_5", 50)
                STAT_SET_INT("DG_MONKEY_SCORE_6", 50)
                STAT_SET_INT("DG_MONKEY_SCORE_7", 50)
                STAT_SET_INT("DG_MONKEY_SCORE_8", 50)
                STAT_SET_INT("DG_MONKEY_SCORE_9", 50)
                STAT_SET_INT("DG_PENETRATOR_INITIALS_0", 69644)
                STAT_SET_INT("DG_PENETRATOR_INITIALS_1", 69644)
                STAT_SET_INT("DG_PENETRATOR_INITIALS_2", 69644)
                STAT_SET_INT("DG_PENETRATOR_INITIALS_3", 69644)
                STAT_SET_INT("DG_PENETRATOR_INITIALS_4", 69644)
                STAT_SET_INT("DG_PENETRATOR_INITIALS_5", 69644)
                STAT_SET_INT("DG_PENETRATOR_INITIALS_6", 69644)
                STAT_SET_INT("DG_PENETRATOR_INITIALS_7", 69644)
                STAT_SET_INT("DG_PENETRATOR_INITIALS_8", 69644)
                STAT_SET_INT("DG_PENETRATOR_INITIALS_9", 69644)
                STAT_SET_INT("DG_PENETRATOR_SCORE_0", 50)
                STAT_SET_INT("DG_PENETRATOR_SCORE_1", 50)
                STAT_SET_INT("DG_PENETRATOR_SCORE_2", 50)
                STAT_SET_INT("DG_PENETRATOR_SCORE_3", 50)
                STAT_SET_INT("DG_PENETRATOR_SCORE_4", 50)
                STAT_SET_INT("DG_PENETRATOR_SCORE_5", 50)
                STAT_SET_INT("DG_PENETRATOR_SCORE_6", 50)
                STAT_SET_INT("DG_PENETRATOR_SCORE_7", 50)
                STAT_SET_INT("DG_PENETRATOR_SCORE_8", 50)
                STAT_SET_INT("DG_PENETRATOR_SCORE_9", 50)
                STAT_SET_INT("GGSM_INITIALS_0", 69644)
                STAT_SET_INT("GGSM_INITIALS_1", 69644)
                STAT_SET_INT("GGSM_INITIALS_2", 69644)
                STAT_SET_INT("GGSM_INITIALS_3", 69644)
                STAT_SET_INT("GGSM_INITIALS_4", 69644)
                STAT_SET_INT("GGSM_INITIALS_5", 69644)
                STAT_SET_INT("GGSM_INITIALS_6", 69644)
                STAT_SET_INT("GGSM_INITIALS_7", 69644)
                STAT_SET_INT("GGSM_INITIALS_8", 69644)
                STAT_SET_INT("GGSM_INITIALS_9", 69644)
                STAT_SET_INT("GGSM_SCORE_0", 50)
                STAT_SET_INT("GGSM_SCORE_1", 50)
                STAT_SET_INT("GGSM_SCORE_2", 50)
                STAT_SET_INT("GGSM_SCORE_3", 50)
                STAT_SET_INT("GGSM_SCORE_4", 50)
                STAT_SET_INT("GGSM_SCORE_5", 50)
                STAT_SET_INT("GGSM_SCORE_6", 50)
                STAT_SET_INT("GGSM_SCORE_7", 50)
                STAT_SET_INT("GGSM_SCORE_8", 50)
                STAT_SET_INT("GGSM_SCORE_9", 50)
                STAT_SET_INT("TWR_INITIALS_0", 69644)
                STAT_SET_INT("TWR_INITIALS_1", 69644)
                STAT_SET_INT("TWR_INITIALS_2", 69644)
                STAT_SET_INT("TWR_INITIALS_3", 69644)
                STAT_SET_INT("TWR_INITIALS_4", 69644)
                STAT_SET_INT("TWR_INITIALS_5", 69644)
                STAT_SET_INT("TWR_INITIALS_6", 69644)
                STAT_SET_INT("TWR_INITIALS_7", 69644)
                STAT_SET_INT("TWR_INITIALS_8", 69644)
                STAT_SET_INT("TWR_INITIALS_9", 69644)
                STAT_SET_INT("TWR_SCORE_0", 50)
                STAT_SET_INT("TWR_SCORE_1", 50)
                STAT_SET_INT("TWR_SCORE_2", 50)
                STAT_SET_INT("TWR_SCORE_3", 50)
                STAT_SET_INT("TWR_SCORE_4", 50)
                STAT_SET_INT("TWR_SCORE_5", 50)
                STAT_SET_INT("TWR_SCORE_6", 50)
                STAT_SET_INT("TWR_SCORE_7", 50)
                STAT_SET_INT("TWR_SCORE_8", 50)
                STAT_SET_INT("TWR_SCORE_9", 50)
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
                STAT_SET_BOOL("AWD_APEESCAP", true)
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
            end)

            menu.action(ARCADE_TOOL, TRANSLATE("Unlock Arcade Clothing"), {}, IS_WORKING(false), function()
                SET_PACKED_INT_GLOBAL(28316, 28336, 1) -- 1380945288, -2029732713
            end)

        ---

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

        menu.action(UNLOCKER_BUILDING, TRANSLATE("Casino Store Ace Masks"), {}, IS_WORKING(true) .. TRANSLATE("Make sure click before buying. When you change your session, will be changed to non-unlocked status."), function()
            SET_PACKED_INT_GLOBAL(27530, 27533, 1) -- -425372143, 1422194221
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
            STAT_SET_INT("LIFETIME_BIKER_BUY_COMPLET1", 1000)
            STAT_SET_INT("LIFETIME_BIKER_BUY_UNDERTA1", 1000)
            STAT_SET_INT("LIFETIME_BIKER_SELL_COMPLET1", 1000)
            STAT_SET_INT("LIFETIME_BIKER_SELL_UNDERTA1", 1000)
            STAT_SET_INT("LIFETIME_BIKER_BUY_COMPLET2", 1000)
            STAT_SET_INT("LIFETIME_BIKER_BUY_UNDERTA2", 1000)
            STAT_SET_INT("LIFETIME_BIKER_SELL_COMPLET2", 1000)
            STAT_SET_INT("LIFETIME_BIKER_SELL_UNDERTA2", 1000)
            STAT_SET_INT("LIFETIME_BIKER_BUY_COMPLET3", 1000)
            STAT_SET_INT("LIFETIME_BIKER_BUY_UNDERTA3", 1000)
            STAT_SET_INT("LIFETIME_BIKER_SELL_COMPLET3", 1000)
            STAT_SET_INT("LIFETIME_BIKER_SELL_UNDERTA3", 1000)
            STAT_SET_INT("LIFETIME_BIKER_BUY_COMPLET4", 1000)
            STAT_SET_INT("LIFETIME_BIKER_BUY_UNDERTA4", 1000)
            STAT_SET_INT("LIFETIME_BIKER_SELL_COMPLET4", 1000)
            STAT_SET_INT("LIFETIME_BIKER_SELL_UNDERTA4", 1000)
            STAT_SET_INT("LIFETIME_BIKER_BUY_COMPLET5", 1000)
            STAT_SET_INT("LIFETIME_BIKER_BUY_UNDERTA5", 1000)
            STAT_SET_INT("LIFETIME_BIKER_SELL_COMPLET5", 1000)
            STAT_SET_INT("LIFETIME_BIKER_SELL_UNDERTA5", 1000)
            STAT_SET_INT("LIFETIME_BKR_SELL_EARNINGS0", 20000000)
            STAT_SET_INT("LIFETIME_BKR_SELL_EARNINGS1", 20000000)
            STAT_SET_INT("LIFETIME_BKR_SELL_EARNINGS2", 20000000)
            STAT_SET_INT("LIFETIME_BKR_SELL_EARNINGS3", 20000000)
            STAT_SET_INT("LIFETIME_BKR_SELL_EARNINGS4", 20000000)
            STAT_SET_INT("LIFETIME_BKR_SELL_EARNINGS5", 20000000)
        end)

    ---

    local UNLOCKER_MISSIONS = menu.list(MASTER_UNLOCKR, TRANSLATE("Missions"), {}, "", function(); end)

        menu.action(UNLOCKER_MISSIONS, TRANSLATE("Cayo Perico Unlockables"), {}, IS_WORKING(false), function()
            SET_PACKED_INT_GLOBAL(30209, 30232, 1) -- 433014829, 1014784742
            SET_PACKED_INT_GLOBAL(30238, 30277, 1) -- -38929647, 1052683033
            SET_PACKED_INT_GLOBAL(30282, 30301, 1) -- -2141771850, -1871460122
            SET_PACKED_INT_GLOBAL(30866, 30901, 1) -- 92877911, -1993561101
            SET_PACKED_INT_GLOBAL(30911, 30916, 1) -- -312057690, 265922985
        end)

        menu.action(UNLOCKER_MISSIONS, TRANSLATE("Unlock Yacht Missions"), {}, "", function()
            STAT_SET_INT("YACHT_MISSION_PROG", 0)
            STAT_SET_INT("YACHT_MISSION_FLOW", 21845)
            STAT_SET_INT("CASINO_DECORATION_GIFT_1", -1)
        end)

        menu.action(UNLOCKER_MISSIONS, TRANSLATE("Unlock All Contacts"), {}, "", function()
            STAT_SET_INT("FM_ACT_PHN", -1)
            STAT_SET_INT("FM_ACT_PH2", -1)
            STAT_SET_INT("FM_ACT_PH3", -1)
            STAT_SET_INT("FM_ACT_PH4", -1)
            STAT_SET_INT("FM_ACT_PH5", -1)
            STAT_SET_INT("FM_VEH_TX1", -1)
            STAT_SET_INT("FM_ACT_PH6", -1)
            STAT_SET_INT("FM_ACT_PH7", -1)
            STAT_SET_INT("FM_ACT_PH8", -1)
            STAT_SET_INT("FM_ACT_PH9", -1)
            STAT_SET_INT("FM_CUT_DONE", -1)
            STAT_SET_INT("FM_CUT_DONE_2", -1)
        end)

        menu.action(UNLOCKER_MISSIONS, TRANSLATE("Skip Lamar Missions To The Last One"), {}, TRANSLATE("Change your session to apply!"), function()
            STAT_SET_BOOL("LOW_FLOW_CS_DRV_SEEN", true)
            STAT_SET_BOOL("LOW_FLOW_CS_TRA_SEEN", true)
            STAT_SET_BOOL("LOW_FLOW_CS_FUN_SEEN", true)
            STAT_SET_BOOL("LOW_FLOW_CS_PHO_SEEN", true)
            STAT_SET_BOOL("LOW_FLOW_CS_FIN_SEEN", true)
            STAT_SET_BOOL("LOW_BEN_INTRO_CS_SEEN", true)
            STAT_SET_INT("LOWRIDER_FLOW_COMPLETE", 3)
            STAT_SET_INT("LOW_FLOW_CURRENT_PROG", 9)
            STAT_SET_INT("LOW_FLOW_CURRENT_CALL", 9)
        end)

    ---

    local UNLOCKER_ANNIVERSARY = menu.list(MASTER_UNLOCKR, TRANSLATE("Special Anniversaries"), {}, "", function(); end)

        local XMAS_FEATURES = menu.list(UNLOCKER_ANNIVERSARY, TRANSLATE("Christmas"), {}, "", function(); end)

            menu.toggle_loop(XMAS_FEATURES, TRANSLATE("Bypass Christmas Clothing"), {"hcxmas"}, IS_WORKING(true) .. TRANSLATE("You must keep this feature enabled in order to wear it!"), function()
                SET_PACKED_INT_GLOBAL(9393, 9400, 0) -- joaat("disable_snowballs"), -1810184402
                SET_PACKED_INT_GLOBAL(9401, 9402, 7) -- joaat("max_number_of_snowballs"), joaat("pick_up_number_of_snowballs")
            end)
            
            menu.action(XMAS_FEATURES, TRANSLATE("Unlock Christmas Liveries"), {}, "", function()
                for i = 1, 20 do
                    STAT_SET_INT("MPPLY_XMASLIVERIES" .. tostring(i), -1)
                end
            end)

            menu.action(XMAS_FEATURES, TRANSLATE("Unlock Christmas Content"), {}, IS_WORKING(false), function()
                SET_PACKED_INT_GLOBAL(9393, 9402, 1) -- joaat("disable_snowballs"), joaat("pick_up_number_of_snowballs")
                SET_PACKED_INT_GLOBAL(9449, 9451, 1) -- joaat("toggle_christmas_eve_gift"), joaat("toggle_new_years_day_gift")
                SET_PACKED_INT_GLOBAL(12710, 12711, 1) -- joaat("XMAS2015_VEHICLE"), -452612879
                SET_PACKED_INT_GLOBAL(12816, 12819, 1) -- joaat("toggle_2015_christmas_eve_gift"), joaat("toggle_2015_christmas_day_gift")
                SET_PACKED_INT_GLOBAL(19115, 19118, 1) -- joaat("toggle_2016_christmas_eve_gift"), joaat("toggle_2016_christmas_day_gift")
                SET_PACKED_INT_GLOBAL(23407, 23415, 1) -- 1840129338, -495986083
                SET_PACKED_INT_GLOBAL(23434, 23437, 1) -- -101086705, -1663567610
                SET_PACKED_INT_GLOBAL(25834, 25836, 1) -- 1975465829, -146321616
                SET_PACKED_INT_GLOBAL(25838, 25841, 1) -- joaat("toggle_2018_christmas_eve_gift"), joaat("toggle_2018_christmas_day_gift")
                SET_PACKED_INT_GLOBAL(28690, 28693, 1) -- joaat("toggle_2019_christmas_eve_gift"), joaat("toggle_2019_christmas_day_gift")
                SET_PACKED_INT_GLOBAL(31756, 31757, 1) -- 1073486652, -1378428735
                SET_INT_GLOBAL(262145 + 4763, 1) -- joaat("toggle_xmas_content")
                SET_INT_GLOBAL(262145 + 9185, 1) -- joaat("toggle_gift_to_player_when_logging_on")
                SET_INT_GLOBAL(262145 + 12713, 1) -- 1247240781
                SET_INT_GLOBAL(262145 + 19256, 1) -- joaat("christmas2016_clothing")
                SET_INT_GLOBAL(262145 + 23056, 1) -- joaat("christmas2017_clothing")
                SET_INT_GLOBAL(262145 + 24203, 1) -- -1029230616
                SET_INT_GLOBAL(262145 + 30902, 1) -- 950317171
            end)

        ---

        menu.toggle_loop(UNLOCKER_ANNIVERSARY, TRANSLATE("Independence Day"), {}, IS_WORKING(false), function()
            SET_PACKED_INT_GLOBAL(8268, 8274, 1) -- joaat("independence_day_deactivate_fireworks_launcher"), joaat("Toggle_activate_Monster_truck") 
            SET_PACKED_INT_GLOBAL(8297, 8303, 1) -- joaat("unlockindependence_beer_hat_1"), joaat("unlockindependence_statue_happiness_shirt")
            SET_INT_GLOBAL(262145 + 8259, 1) -- joaat("toggle_activate_independence_pack")
        end)

        menu.action(UNLOCKER_ANNIVERSARY, TRANSLATE("Valentine's Day"), {}, IS_WORKING(false), function()
            SET_PACKED_INT_GLOBAL(12030, 12034, 1) -- joaat("TURN_ON_VALENTINE_WEAPON"), joaat("TURN_ON_VALENTINE_CLOTHING")
            SET_PACKED_INT_GLOBAL(13396, 13397, 1) -- joaat("TURN_ON_VALENTINE_2016_CLOTHING"), joaat("TURN_ON_VALENTINE_2016_VEHICLE")
            SET_INT_GLOBAL(262145 + 7059, 1) -- joaat("TURN_ON_VALENTINES_EVENT")
        end)

    ---

    local UNLOCKER_SHIRT_HAT = menu.list(MASTER_UNLOCKR, TRANSLATE("Clothes"), {}, "", function(); end)
    
        menu.action(UNLOCKER_SHIRT_HAT, TRANSLATE("Unlock Hats And Many Shirts"), {}, IS_WORKING(false), function()
            SET_PACKED_INT_GLOBAL(11955, 11964, 1) -- joaat("dlc_shirt_meltdown"), joaat("dlc_shirt_capolavoro")
            SET_PACKED_INT_GLOBAL(12591, 12613, 1) -- 340737912, -677479510
            SET_PACKED_INT_GLOBAL(15222, 15236, 1) -- -1787967139, 729622893
            SET_PACKED_INT_GLOBAL(16784, 16790, 1) -- -11411245, -475481933
            SET_PACKED_INT_GLOBAL(17532, 17553, 1) -- -1422129266, 310744591
            SET_PACKED_INT_GLOBAL(21109, 21147, 1) -- joaat("award_black_ammunation_cap"), 1389326679
            SET_PACKED_INT_GLOBAL(24204, 24230, 1) -- 442763143, -551933864
            SET_PACKED_INT_GLOBAL(24704, 24712, 1) -- 1652837933, -359066225
            SET_PACKED_INT_GLOBAL(24744, 24763, 1) -- 970577296, -1201184054
            SET_PACKED_INT_GLOBAL(24918, 24941, 1) -- -726113206, -1910486921
            SET_PACKED_INT_GLOBAL(25910, 25919, 1) -- -1344369866, 1799248495
            SET_PACKED_INT_GLOBAL(27027, 27033, 1) -- 760292630, 1007326524
            SET_PACKED_INT_GLOBAL(30233, 30237, 1) -- 630881878, 1495295329
            SET_PACKED_INT_GLOBAL(31871, 31873, 1) -- -2066580907, -1668169283
            SET_INT_GLOBAL(262145 + 25706, 1) -- -1519472948

            for i = 31768, 32273 do
                STAT_SET_PACKED_BOOL(i, 1) -- freemode.c, https://www.unknowncheats.me/forum/3196991-post328.html
            end
        end)

        menu.action(UNLOCKER_SHIRT_HAT, TRANSLATE("Unlock Sasquatch Outfit"), {}, IS_WORKING(false), function() -- https://www.unknowncheats.me/forum/3492512-post53.html
            SET_INT_GLOBAL(262145 + 32938, 1) -- -1966279346
        end)

        menu.action(UNLOCKER_SHIRT_HAT, TRANSLATE("Unlock 'Don't Cross the Line Tee'"), {}, IS_WORKING(false), function()
            STAT_SET_INT("DCTL_WINS", 500)
            STAT_SET_INT("DCTL_PLAY_COUNT", 750)
        end)

    ---

    local UNLOCKER_VEHICLE = menu.list(MASTER_UNLOCKR, TRANSLATE("Vehicles"), {}, "", function(); end)

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

        menu.action(UNLOCKER_VEHICLE, TRANSLATE("Unlock The Shotaro"), {}, "", function()
            STAT_SET_INT("CRDEADLINE", -1)
        end)

    ---

    local SPECIAL_WEAPON = menu.list(MASTER_UNLOCKR, TRANSLATE("Weapons"), {}, "", function(); end)

        menu.action(SPECIAL_WEAPON, TRANSLATE("Service Carbine"), {}, IS_WORKING(false), function()
            SET_INT_GLOBAL(262145 + 32865, 1) -- 88184590, https://www.unknowncheats.me/forum/3488328-post27.html
        end)

        menu.action(SPECIAL_WEAPON, TRANSLATE("Stone Hatchet Challenge"), {}, TRANSLATE("Change your session to apply!"), function()
            STAT_SET_MASKED_INT("MP_NGDLCPSTAT_INT0", 5, 16)
            STAT_SET_BOOL("MPPLY_MELEECHLENGECOMPLETED", true)
        end)

        menu.action(SPECIAL_WEAPON, TRANSLATE("Double Action Revolver"), {}, TRANSLATE("Change your session to apply!"), function()
            STAT_SET_MASKED_INT("GANGOPSPSTAT_INT102", 3, 24)
            STAT_SET_BOOL("MPPLY_HEADSHOTCHLENGECOMPLETED", true)
        end)

        menu.action(SPECIAL_WEAPON, TRANSLATE("Navy Revolver"), {}, "", function()
            STAT_SET_BOOL("MPPLY_NAVYREVOLVERCOMPLETED", true)
        end)

        menu.action(SPECIAL_WEAPON, TRANSLATE("Up-N-Atomizer"), {}, IS_WORKING(false), function()
            SET_INT_GLOBAL(103634, 90) -- freemode.c, joaat("weapon_raypistol"), -1, 0
        end)

    ---

    menu.action(MASTER_UNLOCKR, TRANSLATE("Vanilla Unicorn Award"), {}, "", function()
        for i = 0, 25, 5 do
            STAT_SET_INT("LAP_DANCED_BOUGHT", i)
        end
        STAT_SET_INT("PROSTITUTES_FREQUENTED", 1000)
    end)

    menu.action(MASTER_UNLOCKR, TRANSLATE("Alien Tatto (Illuminati)"), {}, TRANSLATE("Change your session to apply!"), function()
        STAT_SET_INT("TATTOO_FM_CURRENT_32", -1)
    end)

    menu.action(MASTER_UNLOCKR, TRANSLATE("Returning Player Bonus"), {}, IS_WORKING(false), function()
        SET_INT_GLOBAL(103635, 1) -- freemode.c, joaat("component_raypistol_varmod_xmas18"), joaat("weapon_raypistol"), -1
        SET_INT_GLOBAL(152523, 2) -- freemode.c, STATS::STAT_GET_INT(joaat("sp_unlock_exclus_content"), &iVar0, -1);
    end)

---


--- Tools

    local TUNABLES = menu.list(TOOLS, TRANSLATE("Tunables"), {}, "", function(); end) -- Almost non-credited global variables from: https://www.unknowncheats.me/forum/3337151-post1560.html

        local TUNABLES_CD = menu.list(TUNABLES, TRANSLATE("Remove Cooldowns"), {}, "", function(); end)

            menu.divider(TUNABLES_CD, TRANSLATE("Supplies' Delay"))

                menu.toggle_loop(TUNABLES_CD, TRANSLATE("MC Business"), {"hcresupmc"}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(262145 + 18954, 0) -- 728170457
                end, function()
                    SET_INT_GLOBAL(262145 + 18954, 600)
                end)
                
                menu.toggle_loop(TUNABLES_CD, TRANSLATE("Bunker"), {"hcresupbunker"}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(262145 + 21557, 0) -- -2094564985
                end, function()
                    SET_INT_GLOBAL(262145 + 21557, 600)
                end)

            ---

            menu.divider(TUNABLES_CD, TRANSLATE("Buying And Selling"))

                menu.toggle_loop(TUNABLES_CD, TRANSLATE("Special Cargo"), {"hccoolspecial"}, IS_WORKING(false), function() 
                    SET_INT_GLOBAL(262145 + 15553, 0) -- Buy, 153204142
                    SET_INT_GLOBAL(262145 + 15554, 0) -- Sell, 1291620941
                end, function()
                    SET_INT_GLOBAL(262145 + 15553, 300000)
                    SET_INT_GLOBAL(262145 + 15554, 1800000)
                end)

                menu.toggle_loop(TUNABLES_CD, TRANSLATE("Vehicle Cargo"), {"hccoolveh"}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(262145 + 19683, 0) -- -82707601
                    SET_INT_GLOBAL(262145 + 19684, 0) -- 1 Vehicle, 1001423248
                    SET_INT_GLOBAL(262145 + 19685, 0) -- 2 Vehicles, 240134765
                    SET_INT_GLOBAL(262145 + 19686, 0) -- 3 Vehicles, 1915379148
                    SET_INT_GLOBAL(262145 + 19687, 0) -- 4 Vehicles, -824005590
                end, function()
                    SET_INT_GLOBAL(262145 + 19683, 180000)
                    SET_INT_GLOBAL(262145 + 19684, 1200000)
                    SET_INT_GLOBAL(262145 + 19685, 1680000)
                    SET_INT_GLOBAL(262145 + 19686, 2340000)
                    SET_INT_GLOBAL(262145 + 19687, 2880000)
                end)

                menu.toggle_loop(TUNABLES_CD, TRANSLATE("Air-Freight Cargo"), {"hccoolair"}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(262145 + 22751, 0) -- Tobacco, Counterfeit Goods, 1278611667
                    SET_INT_GLOBAL(262145 + 22752, 0) -- Animal Materials, Art, Jewelry, -1424847540
                    SET_INT_GLOBAL(262145 + 22753, 0) -- Narcotics, Chemicals, Medical Supplies, -1817541754
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

                menu.toggle_loop(TUNABLES_CD, TRANSLATE("Client Jobs"), {"hccoolclient"}, IS_WORKING(false), function()
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

                menu.toggle_loop(TUNABLES_CD, TRANSLATE("Spin Lucky Wheel"), {"hccoolluckywheel"}, IS_WORKING(false), function() -- https://www.unknowncheats.me/forum/3531489-post51.html
                    SET_INT_GLOBAL(262145 + 27197, 1) -- -312420223
                    SET_INT_GLOBAL(262145 + 27196, 1) -- 9960150
                end)

                menu.toggle_loop(TUNABLES_CD, TRANSLATE("Kosatka Missiles"), {"hccoolmissile"}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(262145 + 30187, 0) -- 729164624
                    SET_INT_GLOBAL(262145 + 30188, 99999) -- 1968456272
                end, function()
                    SET_INT_GLOBAL(262145 + 30187, 60000)
                    SET_INT_GLOBAL(262145 + 30188, 4000)
                end)

                menu.toggle_loop(TUNABLES_CD, TRANSLATE("CEO Vehicles"), {"hccoolceoveh"}, IS_WORKING(false), function() -- Credit goes to Professor#4478's Kiddions Lua
                    SET_INT_GLOBAL(262145 + 12832, 0) -- 2092239066
                end, function()
                    SET_INT_GLOBAL(262145 + 12832, 120000)
                end)

            ---

        ---

        local TUNABLES_MUT = menu.list(TUNABLES, TRANSLATE("Multipliers"), {}, "", function(); end)

            MUT_Input = 1
            menu.slider_float(TUNABLES_MUT, TRANSLATE("Multipliers"), {"hcmut"}, "", 0, 500000, 100, 100, function(Value)
                MUT_Input = Value / 100
            end)

            menu.divider(TUNABLES_MUT, TRANSLATE("XP & AP"))

                menu.toggle_loop(TUNABLES_MUT, TRANSLATE("XP"), {"hcmutxp"}, IS_WORKING(false), function()
                    SET_FLOAT_GLOBAL(262145 + 1, MUT_Input) -- joaat("XP_MULTIPLIER")
                end, function()
                    SET_FLOAT_GLOBAL(262145 + 1, 1)
                end)
                menu.toggle_loop(TUNABLES_MUT, TRANSLATE("AP"), {"hcmutap"}, IS_WORKING(false), function()
                    SET_FLOAT_GLOBAL(262145 + 25926, MUT_Input) -- -1258787971
                end, function()
                    SET_FLOAT_GLOBAL(262145 + 25926, 1)
                end)

            ---

            menu.divider(TUNABLES_MUT, TRANSLATE("LS Car Meet"))

                menu.toggle_loop(TUNABLES_MUT, TRANSLATE("Street Race"), {"hcmutstreet"}, IS_WORKING(false), function()
                    SET_FLOAT_GLOBAL(262145 + 31649, MUT_Input) -- -1755846889
                end, function()
                    SET_FLOAT_GLOBAL(262145 + 31649, 1)
                end)
                menu.toggle_loop(TUNABLES_MUT, TRANSLATE("Pursuit Race"), {"hcmutpursuit"}, IS_WORKING(false), function()
                    SET_FLOAT_GLOBAL(262145 + 31650, MUT_Input) -- -1610590555
                end, function()
                    SET_FLOAT_GLOBAL(262145 + 31650, 1)
                end)
                menu.toggle_loop(TUNABLES_MUT, TRANSLATE("Scramble"), {"hcmutscramble"}, IS_WORKING(false), function()
                    SET_FLOAT_GLOBAL(262145 + 31651, MUT_Input) -- 1434998920
                end, function()
                    SET_FLOAT_GLOBAL(262145 + 31651, 1)
                end)
                menu.toggle_loop(TUNABLES_MUT, TRANSLATE("Head 2 Head"), {"hcmuthth"}, IS_WORKING(false), function()
                    SET_FLOAT_GLOBAL(262145 + 31652, MUT_Input) -- -813694860
                end, function()
                    SET_FLOAT_GLOBAL(262145 + 31652, 1)
                end)
                menu.toggle_loop(TUNABLES_MUT, TRANSLATE("LS Car Meet"), {"hcmutcar"}, IS_WORKING(false), function()
                    SET_FLOAT_GLOBAL(262145 + 31653, MUT_Input) -- 1819417801
                end, function()
                    SET_FLOAT_GLOBAL(262145 + 31653, 1)
                end)
                menu.toggle_loop(TUNABLES_MUT, TRANSLATE("LS Car Meet's Track"), {"hcmuttrack"}, IS_WORKING(false), function()
                    SET_FLOAT_GLOBAL(262145 + 31654, MUT_Input) -- -679396556
                end, function()
                    SET_FLOAT_GLOBAL(262145 + 31654, 1)
                end)

            ---

        ---

        local TUNABLES_CRATE = menu.list(TUNABLES, TRANSLATE("Trigger Special Crate Missions"), {}, TRANSLATE("Note that buying special crates can only in the Terrobyte."), function(); end)

            menu.toggle_loop(TUNABLES_CRATE, TRANSLATE("Ornamental Egg"), {}, IS_WORKING(false), function()
                SET_INT_GLOBAL(1949968, 1) -- freemode.c
                SET_INT_GLOBAL(1949814, 2) -- freemode.c
            end, function()
                SET_INT_GLOBAL(1949968, 0)
            end)
            menu.toggle_loop(TUNABLES_CRATE, TRANSLATE("Gold Minigun"), {}, IS_WORKING(false), function()
                SET_INT_GLOBAL(1949968, 1)
                SET_INT_GLOBAL(1949814, 4)
            end, function()
                SET_INT_GLOBAL(1949968, 0)
            end)
            menu.toggle_loop(TUNABLES_CRATE, TRANSLATE("Large Diamond"), {}, IS_WORKING(false), function()
                SET_INT_GLOBAL(1949968, 1)
                SET_INT_GLOBAL(1949814, 6)
            end, function()
                SET_INT_GLOBAL(1949968, 0)
            end)
            menu.toggle_loop(TUNABLES_CRATE, TRANSLATE("Rage Hide"), {}, IS_WORKING(false), function()
                SET_INT_GLOBAL(1949968, 1)
                SET_INT_GLOBAL(1949814, 7)
            end, function()
                SET_INT_GLOBAL(1949968, 0)
            end)
            menu.toggle_loop(TUNABLES_CRATE, TRANSLATE("Film Reel"), {}, IS_WORKING(false), function()
                SET_INT_GLOBAL(1949968, 1)
                SET_INT_GLOBAL(1949814, 8)
            end, function()
                SET_INT_GLOBAL(1949968, 0)
            end)
            menu.toggle_loop(TUNABLES_CRATE, TRANSLATE("Rare Pocket Watch"), {}, IS_WORKING(false), function()
                SET_INT_GLOBAL(1949968, 1)
                SET_INT_GLOBAL(1949814, 9)
            end, function()
                SET_INT_GLOBAL(1949968, 0)
            end)
            
        ---

        local TUNABLES_SEL = menu.list(TUNABLES, TRANSLATE("Bunker Mission Selector"), {}, "", function(); end)
            
            menu.toggle_loop(TUNABLES_SEL, TRANSLATE("(SPECIAL) Trigger Alien Egg Mission"), {}, IS_WORKING(true) .. "(" .. TRANSLATE("Steal Supplies") .. ")", function()
                SET_INT_GLOBAL(2793044 + 5225 + 345, 20)
                STAT_SET_INT("LFETIME_BIKER_BUY_COMPLET5", 1200)
                STAT_SET_INT("LFETIME_BIKER_BUY_UNDERTA5", 1200)
            end)

            menu.divider(TUNABLES_SEL, TRANSLATE("Steal Supplies"))

                menu.toggle_loop(TUNABLES_SEL, TRANSLATE("Altruist Camp"), {}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(2793044 + 5225 + 345, 1)
                end)
                menu.toggle_loop(TUNABLES_SEL, TRANSLATE("Dune Buggy (Arm Runners)"), {}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(2793044 + 5225 + 345, 2)
                end)
                menu.toggle_loop(TUNABLES_SEL, TRANSLATE("Riot Van (Police)"), {}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(2793044 + 5225 + 345, 3)
                end)
                menu.toggle_loop(TUNABLES_SEL, TRANSLATE("Old Mine"), {}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(2793044 + 5225 + 345, 4)
                end)
                menu.toggle_loop(TUNABLES_SEL, TRANSLATE("Technical Aqua (4 Helicopters)"), {}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(2793044 + 5225 + 345, 5)
                end)
                menu.toggle_loop(TUNABLES_SEL, TRANSLATE("Rival Operation"), {}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(2793044 + 5225 + 345, 6)
                end)
                menu.toggle_loop(TUNABLES_SEL, TRANSLATE("Zancudo River"), {}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(2793044 + 5225 + 345, 7)
                end)
                menu.toggle_loop(TUNABLES_SEL, TRANSLATE("Ballistic Equipment"), {}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(2793044 + 5225 + 345, 8)
                end)
                menu.toggle_loop(TUNABLES_SEL, TRANSLATE("Merryweather HQ (Railgun)"), {}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(2793044 + 5225 + 345, 9)
                end)
                menu.toggle_loop(TUNABLES_SEL, TRANSLATE("Training Ground (Tank)"), {}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(2793044 + 5225 + 345, 10)
                end)
                menu.toggle_loop(TUNABLES_SEL, TRANSLATE("Heist Crew (Technical Pickup)"), {}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(2793044 + 5225 + 345, 11)
                end)
                menu.toggle_loop(TUNABLES_SEL, TRANSLATE("Rusty Van (Rumpo Classic)"), {}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(2793044 + 5225 + 345, 12)
                end)
                menu.toggle_loop(TUNABLES_SEL, TRANSLATE("Stealth Zone (Yacht/Docks)"), {}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(2793044 + 5225 + 345, 13)
                end)

            ---

            menu.divider(TUNABLES_SEL, TRANSLATE("Sell Weapons"))

                menu.toggle_loop(TUNABLES_SEL, TRANSLATE("Insurgent Pick-Up Custom (Merryweather)"), {}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(2793044 + 5225 + 345, 14)
                end)
                menu.toggle_loop(TUNABLES_SEL, TRANSLATE("Insurgent (Stealth)"), {}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(2793044 + 5225 + 345, 15)
                end)
                menu.toggle_loop(TUNABLES_SEL, TRANSLATE("Marshall"), {}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(2793044 + 5225 + 345, 16)
                end)
                menu.toggle_loop(TUNABLES_SEL, TRANSLATE("Insurgent Pick-Up Custom (A to B)"), {}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(2793044 + 5225 + 345, 17)
                end)
                menu.toggle_loop(TUNABLES_SEL, TRANSLATE("Phantom Wedge"), {}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(2793044 + 5225 + 345, 18)
                end)
                menu.toggle_loop(TUNABLES_SEL, TRANSLATE("Dune FAV"), {}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(2793044 + 5225 + 345, 19)
                end)

            ---

        ---

        local TUNABLES_RSU = menu.list(TUNABLES, TRANSLATE("Remove Other Cost"), {}, "", function(); end)

            menu.toggle_loop(TUNABLES_RSU, TRANSLATE("Repair Vehicle Cargo (Stealing)"), {"hcremcostveh"}, IS_WORKING(true) .. TRANSLATE("When you sell a vehicle, it blocks having to pay for the repair."), function() 
                SET_INT_GLOBAL(262145 + 19661, 0) -- Top, 681515537
                SET_INT_GLOBAL(262145 + 19662, 0) -- Mid, -567224847
                SET_INT_GLOBAL(262145 + 19663, 0) -- Standard, 2100161424
            end, function()
                SET_INT_GLOBAL(262145 + 19661, 34000)
                SET_INT_GLOBAL(262145 + 19662, 21250)
                SET_INT_GLOBAL(262145 + 19663, 12750)
            end)

            menu.toggle_loop(TUNABLES_RSU, TRANSLATE("Ron's Cut from an Air-Freight Cargo sale"), {"hcremcostron"}, IS_WORKING(false), function()
                SET_FLOAT_GLOBAL(262145 + 22793, 0) -- 1232447926
            end, function()
                SET_FLOAT_GLOBAL(262145 + 22793, 0.025)
            end)

            menu.toggle_loop(TUNABLES_RSU, TRANSLATE("Tony's Cut from a Nightclub sale"), {"hcremcosttony"}, IS_WORKING(false), function() -- https://www.unknowncheats.me/forum/3347568-post13086.html
                SET_FLOAT_GLOBAL(262145 + 24496, 0) -- -1002770353
            end, function()
                SET_FLOAT_GLOBAL(262145 + 24496, 0.1)
            end)

            menu.toggle_loop(TUNABLES_RSU, TRANSLATE("Buying MC Business Supplies"), {"hcremcostresupmc"}, IS_WORKING(true) .. TRANSLATE("Make sure use this before accessing the laptop!"), function()
                SET_INT_GLOBAL(262145 + 18953, 1000) -- joaat("BIKER_PURCHASE_SUPPLIES_COST_PER_SEGMENT")
            end, function()
                SET_INT_GLOBAL(262145 + 18953, 15000)
            end)

            menu.toggle_loop(TUNABLES_RSU, TRANSLATE("Buying Bunker Supplies"), {"hcremcostresupbunker"}, IS_WORKING(true) .. TRANSLATE("Make sure use this before accessing the laptop!"), function()
                SET_INT_GLOBAL(262145 + 21555, 1000) -- 970448219
                SET_INT_GLOBAL(262145 + 21556, 1000) -- 262971166
            end, function()
                SET_INT_GLOBAL(262145 + 21555, 15000)
                SET_INT_GLOBAL(262145 + 21556, 15000)
            end)

            menu.toggle_loop(TUNABLES_RSU, TRANSLATE("Changing Appearance"), {}, IS_WORKING(false), function() -- Tbh, an idea from Kiddions mod menu, but, found by me in decompiled script
                SET_INT_GLOBAL(262145 + 19110, 0) -- 1533055729, am_pi_menu.c, 0, "PIM_FREE", (0 + iVar6), bVar1, 0, 0, 0
            end, function()
                SET_INT_GLOBAL(262145 + 19110, 100000)
            end)

            menu.toggle_loop(TUNABLES_RSU, TRANSLATE("Renaming CEO/MC"), {}, IS_WORKING(false), function() -- https://www.unknowncheats.me/forum/grand-theft-auto-v/500059-globals-locals-discussion-read-page-1-a-2.html#post3496393
                SET_INT_GLOBAL(262145 + 15891, 0) -- 1901455739
                SET_INT_GLOBAL(262145 + 16769, 0) -- -89259989
                SET_INT_GLOBAL(262145 + 18025, 0) -- -1069516318
            end, function()
                SET_INT_GLOBAL(262145 + 15891, 50000)
                SET_INT_GLOBAL(262145 + 16769, 5000)
                SET_INT_GLOBAL(262145 + 18025, 50000)
            end)

            menu.toggle_loop(TUNABLES_RSU, TRANSLATE("CEO Abilities") .. TRANSLATE(" & ").. TRANSLATE("CEO Vehicles"), {}, IS_WORKING(false), function() -- Credit goes to Professor#4478's Kiddions Lua
                SET_PACKED_INT_GLOBAL(12842, 12851, 0) -- 51567061, -1972817298
                SET_PACKED_INT_GLOBAL(15968, 15973, 0) -- -1451871600, 1289619793
                SET_INT_GLOBAL(262145 + 15890, 0) -- -939028485
                SET_INT_GLOBAL(262145 + 19302, 0) -- 2052581897
                SET_INT_GLOBAL(262145 + 19304, 0) -- -1333531254
            end, function()
                SET_PACKED_INT_GLOBAL(12842, 12851, 5000) -- 15263926, -400440420
                SET_PACKED_INT_GLOBAL(15968, 15973, 5000) -- -679448434, 1289619793
                SET_INT_GLOBAL(262145 + 12842, 20000) -- 51567061
                SET_INT_GLOBAL(262145 + 12846, 25000) -- -1560965224
                SET_INT_GLOBAL(262145 + 12847, 1000) -- 2096833423
                SET_INT_GLOBAL(262145 + 12848, 1500) -- -688609610
                SET_INT_GLOBAL(262145 + 12849, 1000) -- 153241568
                SET_INT_GLOBAL(262145 + 12850, 12000) -- 813006152
                SET_INT_GLOBAL(262145 + 12851, 15000) -- -1972817298
                SET_INT_GLOBAL(262145 + 15890, 5000) -- -939028485
                SET_INT_GLOBAL(262145 + 15968, 10000) -- -1451871600
                SET_INT_GLOBAL(262145 + 15969, 7000) -- 650824488
                SET_INT_GLOBAL(262145 + 15970, 9000) -- 253623806
                SET_INT_GLOBAL(262145 + 19302, 5000) -- 2052581897
                SET_INT_GLOBAL(262145 + 19304, 10000) -- -1333531254
            end)
            
        ---

        local TUNABLES_CAH = menu.list(TUNABLES, TRANSLATE("Casino Services: Chips") .. " " .. TRANSLATE("(Risky)"), {}, TRANSLATE("Make sure don't buy chip more than 1.5M per a day (real-time). Otherwise, you can be banned!"), function(); end)

            util.create_tick_handler(function()
                if IS_WORKING(false) == "" then
                    if GET_INT_GLOBAL(1853910 + 1 + players.user() * 862 + 267 + 384) == 0 then -- Found by me, freemode.c or casino_slots.c
                        CasinoMembership = "Normal"
                    else
                        CasinoMembership = "VIP"
                    end
                else
                    CasinoMembership = "N/A"
                end
            end)

            local CAHAmount = 0
            menu.slider(TUNABLES_CAH, TRANSLATE("Chips Amount"), {"hccahservice"}, "", INT_MIN, INT_MAX, 0, 10000, function(Value)
                CAHAmount = Value
            end)

            menu.divider(TUNABLES_CAH, TRANSLATE("Casino Services: Chips") .. " " .. TRANSLATE("(Risky)"))

                menu.action(TUNABLES_CAH, TRANSLATE("Trade in Chips"), {}, IS_WORKING(false), function()
                    SET_INT_GLOBAL(262145 + 26980, CAHAmount) -- 363132936
                end, function()
                    SET_INT_GLOBAL(262145 + 26980, 1)
                end)

                menu.action(TUNABLES_CAH, TRANSLATE("Max Chips"), {}, IS_WORKING(false), function()
                    if CasinoMembership == "Normal" then
                        SET_INT_GLOBAL(262145 + 26981, CAHAmount) -- -1679646912
                    elseif CasinoMembership == "VIP" then
                        SET_INT_GLOBAL(262145 + 26981, CAHAmount)
                    end
                end, function()
                    if CasinoMembership == "Normal" then
                        SET_INT_GLOBAL(262145 + 26982, 20000) -- 1136733337
                    elseif CasinoMembership == "VIP" then
                        SET_INT_GLOBAL(262145 + 26982, 50000)
                    end
                end)

            ---

            menu.divider(TUNABLES_CAH, TRANSLATE("Others"))

                menu.toggle_loop(TUNABLES_CAH, TRANSLATE("Remove Cooldown Buy Chips"), {}, TRANSLATE("If you enable this, able to buy over 20K or 50K chips by removing cooldown time."), function()
                    STAT_SET_INT("MPPLY_CASINO_CHIPS_PUR_GD", 0)
                    STAT_SET_INT("MPPLY_CASINO_CHIPS_PURTIM", 0)
                end)

                CASINO_MEMBERSHIP = menu.action_slider(TUNABLES_CAH, TRANSLATE("Change Membership of Casino"), {}, IS_WORKING(true) .. TRANSLATE("Your Membership of Casino: ") .. CasinoMembership, {
                    "Normal",
                    "VIP",
                }, function(Index)
                    SET_INT_GLOBAL(1853910 + 1 + players.user() * 862 + 267 + 384, Index - 1)
                    util.yield()
                    menu.set_help_text(CASINO_MEMBERSHIP, TRANSLATE("Your Membership of Casino: ") .. CasinoMembership)
                end)

                menu.action(TUNABLES_CAH, TRANSLATE("Get Visitor Bonus Again"), {}, TRANSLATE("Change your session to apply!"), function()
                    STAT_SET_INT("MPPLY_CHIPS_COL_TIME", 0)
                end)

            ---

        ---

        local TUNABLES_OTH = menu.list(TUNABLES, TRANSLATE("Others"), {}, "", function(); end)

            menu.toggle_loop(TUNABLES_OTH, TRANSLATE("Single MC Vehicle Sell"), {"hcsinglemcveh"}, IS_WORKING(true) .. TRANSLATE("Forces the amount of MC Business' sale vehicles to one. (Only works when you're the leader, and breaks sale missions if you aren't)"), function() -- https://github.com/Tgamer500/YiffWarePWLua/blob/main/YiffWarePW.lua
                if GET_INT_LOCAL("gb_biker_contraband_sell", 698 + 17) ~= 0 then
                    SET_INT_LOCAL("gb_biker_contraband_sell", 698 + 17, 0)
                end
            end)

            menu.toggle_loop(TUNABLES_OTH, TRANSLATE("Make One Snack Full Health"), {}, IS_WORKING(true) .. TRANSLATE("Whatever you use a snack, will make you full health."), function()
                SET_FLOAT_GLOBAL(262145 + 112, 99999) -- Ps & Qs, joaat("PSANDQS_HEALTH_REPLENISH_MULTIPLIER")
                SET_FLOAT_GLOBAL(262145 + 113, 99999) -- Egochaser, joaat("EGOCHASER_HEALTH_REPLENISH_MULTIPLIER"
                SET_FLOAT_GLOBAL(262145 + 114, 99999) -- Meteorite, joaat("METEORITE_HEALTH_REPLENISH_MULTIPLIER")
                SET_FLOAT_GLOBAL(262145 + 115, 99999) -- Redwood, joaat("REDWOOD_HEALTH_DEPLETE_MULTIPLIER")
                SET_FLOAT_GLOBAL(262145 + 116, 99999) -- eCola, joaat("ORANGOTANG_HEALTH_REPLENISH_MULTIPLIER")
                SET_FLOAT_GLOBAL(262145 + 117, 99999) -- Bourgeoix, joaat("BOURGEOIX_HEALTH_REPLENISH_MULTIPLIER")
                SET_FLOAT_GLOBAL(262145 + 118, 99999) -- Sprunk, 1405423594
            end, function()
                SET_FLOAT_GLOBAL(262145 + 112, 1)
                SET_FLOAT_GLOBAL(262145 + 113, 1)
                SET_FLOAT_GLOBAL(262145 + 114, 1)
                SET_FLOAT_GLOBAL(262145 + 115, 1)
                SET_FLOAT_GLOBAL(262145 + 116, 1)
                SET_FLOAT_GLOBAL(262145 + 117, 1)
                SET_FLOAT_GLOBAL(262145 + 118, 1)
            end)

            menu.toggle_loop(TUNABLES_OTH, TRANSLATE("Infinite Stone Hatchet's Power"), {}, IS_WORKING(false), function() -- https://www.unknowncheats.me/forum/3484239-post11.html
                SET_FLOAT_GLOBAL(262145 + 25297, 99999) -- Weapon Defense, 2117353658
                SET_FLOAT_GLOBAL(262145 + 25300, 99999) -- Health Recharge Multiplier, 847150217
                SET_FLOAT_GLOBAL(262145 + 25301, 99999) -- Health Recharge Limit, 1172828143
                SET_INT_GLOBAL(262145 + 25302, 99999) -- Duration, 927295469
                SET_INT_GLOBAL(262145 + 25303, 99999) -- Added Duration per Kill, 1080926656
                SET_INT_GLOBAL(262145 + 25304, 0) -- Cooldown, 972932785
            end, function()
                SET_FLOAT_GLOBAL(262145 + 25297, 0.5)
                SET_FLOAT_GLOBAL(262145 + 25300, 2)
                SET_FLOAT_GLOBAL(262145 + 25301, 1)
                SET_INT_GLOBAL(262145 + 25302, 12000)
                SET_INT_GLOBAL(262145 + 25303, 6000)
                SET_INT_GLOBAL(262145 + 25304, 60000)
            end)
        
            menu.action(TUNABLES_OTH, TRANSLATE("7 Years GTA Online Playtime"), {}, TRANSLATE("Make your account look like you've played GTA Online for 7 years."), function()
                STAT_SET_INT("MP_PLAYING_TIME", 0)
                STAT_SET_INCREMENT("MP_PLAYING_TIME", (60 * 60 * 24 * 365 * 7) * 1000) -- Converting seconds to millisecond
                FORCE_CLOUD_SAVE()
            end)
            
        ---

        menu.slider(TUNABLES, TRANSLATE("Custom Money Remover"), {"hcmoneyrem"}, IS_WORKING(true) .. TRANSLATE("An Easy Way To Remove GTA Online's banked money"), 0, 2000000000, 5000, 10000, function(Value)
            SET_INT_GLOBAL(262145 + 20288, Value) -- -156036296, https://www.unknowncheats.me/forum/3276092-post3.html
            STAT_SET_PACKED_BOOL(15382, true) -- Makes able to buy the Ballistic Armor
            STAT_SET_PACKED_BOOL(9461, true) -- Makes you have the Ballistic Armor

            menu.trigger_commands(TRANSLATE("nopimenugrey on"))
            if util.is_interaction_menu_open() then
                IA_MENU_OPEN_OR_CLOSE()
            end
            SET_INT_GLOBAL(2766485, 85) -- Renders Ballistic Equipment Services screen of the Interaction Menu
            IA_MENU_OPEN_OR_CLOSE()
            IA_MENU_ENTER(1)

            NOTIFY(TRANSLATE("Because this feature works via requesting the Ballistic Armor, so, it'll be dropped nearby soon."))
        end)

    ---

    local AFK_MONEY = menu.list(TOOLS, TRANSLATE("AFK Money") .. " " .. TRANSLATE("(Risky)"), {}, TRANSLATE("All of features use undetected methods but use at own your risk. If you earn too much, you can be banned."), function(); end)

        menu.divider(AFK_MONEY, TRANSLATE("Cooldown Time (Seconds)"))

            COOLDOWN_CAYO_BOT = menu.slider(AFK_MONEY, TRANSLATE("Auto Cayo Bot"), {"hctimecpbot"}, "", 1200, 86400, 1200, 60, function(); end)
            COOLDOWN_TIME_TRIAL = menu.slider(AFK_MONEY, TRANSLATE("Auto Time Trial"), {"hctimetrial"}, "", 1200, 86400, 1200, 60, function(); end)
            COOLDOWN_RIG_SLOT = menu.slider(AFK_MONEY, TRANSLATE("Auto Rig Slot Machine"), {"hctimeautorig"}, "", 1, 86400, 1, 1, function(); end)

        ---

        menu.divider(AFK_MONEY, TRANSLATE("Settings"))

            NumberOfPlayingCP = 100
            menu.slider(AFK_MONEY, TRANSLATE("How many time to play Auto Cayo Bot"), {"hccpbotnum"}, "", 1, 100, 100, 1, function(Value)
                NumberOfPlayingCP = Value
            end)

            NumberOfLoss = 1
            menu.slider(AFK_MONEY, TRANSLATE("Ratio of Jackpot and Loss"), {"hcrigratio"}, "", 1, 100, 1, 1, function(Value)
                NumberOfLoss = Value
            end)

        ---

        menu.divider(AFK_MONEY, TRANSLATE("Others"))

            menu.action(AFK_MONEY, TRANSLATE("Teleport to the Lucky Wheel"), {}, TRANSLATE("If this doesn't work properly, please press again. It'll fix the situation."), function() -- If anyone know a better method to do this, please let me know.
                for i = 1, 3 do
                    SET_HEADING(5)
                    TELEPORT(1110.269, 229.11899, -49.63585)
                    util.yield(500)
                end
            end)

        ---

        menu.divider(AFK_MONEY, TRANSLATE("AFK Money") .. " " .. TRANSLATE("(Risky)"))

            --- Functions for Auto Cayo Bot
            
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

            local NumberOfPlayedCP = 0
            AUTO_CAYO_BOT = menu.toggle_loop(AFK_MONEY, TRANSLATE("Auto Cayo Bot"), {}, IS_WORKING(true) .. TRANSLATE("Solo Cayo Perico Heist will be done by Heist Control automatically per 20 mins to get $2.09M. Don't press any keys to prevent some game bugs."), function()
                -- An idea and source code from Raid Control for X-Force, but almost tweaked by me.
                -- Raid Control Auto Cayo Bot Source Code: https://pastebin.com/JKVXcZBz

                if NumberOfPlayingCP >= NumberOfPlayedCP then
                    if not util.is_interaction_menu_open() then
                        IA_MENU_OPEN_OR_CLOSE()
                    end

                    if GET_INT_GLOBAL(2774130 + 1 + (0 * 66) + 1 + GET_INT_LOCAL("am_pi_menu", 232)) ~= 37 then -- am_pi_menu.c
                        NOTIFY("Make sure your spawning position is 'Last Location'" .. "\n" .. "You can set it on Interaction Menu.")
                        menu.set_value(AUTO_CAYO_BOT, false)
                        return
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
                    util.create_tick_handler(function() -- Updates blip info per a tick
                        SubBlip = HUD.GET_FIRST_BLIP_INFO_ID(760)
                        SubControlBlip = HUD.GET_FIRST_BLIP_INFO_ID(773)
                    end)
                    if SubBlip == 0 and SubControlBlip == 0 then
                        NOTIFY("Kosatka has been requested. Wait for a few secs.")
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

                    SET_INT_LOCAL("heist_island_planning", 1525, 2) -- Restarts Kosatka PC to apply stats, From https://github.com/atomikfr/CayoPericoHeistAssistant
                    util.yield(1000)
                
                    while GET_INT_GLOBAL(2646729 + 1869) ~= 1 do -- fmmc_launcher.c, If not ready to set planning board
                        util.yield()
                    end
                    util.yield(1000)

                    SET_INT_LOCAL("heist_island_planning", 1432, 2) -- Set planning board loading state
                    while GET_INT_LOCAL("heist_island_planning", 1432) ~= 4 do -- If not planning board has been loaded
                        util.yield()
                    end
                    util.yield(1000)

                    CP_PRESS_E(2)
                    CP_PRESS_D(1)
                    CP_PRESS_ENTER(1)

                    while GET_INT_LOCAL("fmmc_launcher", 16034 + 763) ~= 16 do -- If "LOB_H_FCP" label not loaded
                        util.yield()
                    end
                    util.yield(1000)

                    CP_PRESS_ARROW_UP(1)
                    CP_PRESS_ENTER(1)
                    util.yield(1000)

                    CP_PRESS_ARROW_UP(1)
                    CP_PRESS_ENTER(2)

                    while not HUD.IS_WARNING_MESSAGE_ACTIVE() do -- "Are you sure you want to launch this Job on your own?"
                        util.yield()
                    end
                    util.yield(1000)
                    PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 201, 1) -- Almost same as CP_PRESS_ENTER(1), but this is for "FRONTEND_CONTROL"
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
                    NOTIFY(TRANSLATE("Playing one time has been done! Waiting for the cooldown time...") .. "\n\n" .. TRANSLATE("How many times you've played after enabled: ") .. NumberOfPlayedCP)
                    
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

            local NumberOfSpin = 0
            menu.toggle_loop(AFK_MONEY, TRANSLATE("Auto Rig Slot Machine"), {"hcautorig"}, IS_WORKING(true) .. TRANSLATE("NOT WORKING NOW - Looking into why this feature isn't working currently. Please wait for the next update.") .. "\n\n" .. TRANSLATE("Don't earn more than $50M per a day (real-time), otherwise it'll lead you get banned!"), function() -- https://github.com/jonaaa20/RecoverySuite
                if NumberOfSpin == 0 then
                    PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 204, 1) -- Press Tab to Bet Max
                    util.yield(100)
                end

                local SpinState = 3396 + 1 + players.user() * 11 + 10
                if GET_INT_LOCAL("casino_slots", SpinState) == 0 then -- If not rigging now
                    if NumberOfSpin >= NumberOfLoss then
                        menu.trigger_commands("rigslotmachines jackpot")
                        NumberOfSpin = 0
                    else
                        if NumberOfSpin == 0 then
                            menu.trigger_commands("rigslotmachines loss")
                        end
                        NumberOfSpin = NumberOfSpin + 1
                    end

                    PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 208, 1) -- Press Tab to Bet Max
                    SET_INT_LOCAL("casino_slots", 1637, 8) -- Set as rigging is done

                    while GET_INT_LOCAL("casino_slots", SpinState) ~= 3 do
                        util.yield()
                    end
                    SET_INT_LOCAL("casino_slots", SpinState, 6) -- Skipping animations
                   
                    util.yield(menu.get_value(COOLDOWN_RIG_SLOT) * 1000)
                end
            end, function()
                menu.trigger_commands("rigslotmachines off")
                NumberOfSpin = 0
            end)

            menu.toggle_loop(AFK_MONEY, TRANSLATE("Auto Lucky Wheel"), {"hcautoluckywheel"}, IS_WORKING(true) .. TRANSLATE("Let you earn 25K chips per 3 seconds automatically.") .. "\n\n" .. TRANSLATE("Please use with 'Teleport to the Lucky Wheel' !"), function()
                menu.trigger_commands("rigluckywheel off")
                menu.trigger_commands("hccoolluckywheel on")
                util.yield(1500)

                SET_INT_LOCAL("casino_lucky_wheel", 275 + 14, 15) -- Changes reward to 25,000 Chips
                SET_INT_LOCAL("casino_lucky_wheel", 275 + 45, 11) -- Rigging state: done
                util.yield(1500)
            end)

            menu.toggle_loop(AFK_MONEY, TRANSLATE("Auto Win Black Jack"), {"hcautoblackjack"}, "", function() -- Thanks to allow me to use the code, jerry123#4508
                if not (IS_HELP_MSG_DISPLAYED('BJACK_BET') or IS_HELP_MSG_DISPLAYED('BJACK_TURN') or IS_HELP_MSG_DISPLAYED('BJACK_TURN_D') or IS_HELP_MSG_DISPLAYED('BJACK_TURN_S')) then 
                    return
                end

                if IS_HELP_MSG_DISPLAYED('BJACK_BET') then
                    PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 204, 1) -- Max Bet
                    PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 201, 1) -- Bet
                else
                    PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 203, 1) -- Pass
                end
            end)

            menu.toggle_loop(AFK_MONEY, TRANSLATE("Auto Time Trial"), {"hcautotrial"}, "", function() -- Tbh, an idea from X-Force, but all coded by me
                local Blip = HUD.GET_FIRST_BLIP_INFO_ID(430) -- Time Trial Blip
                local Pos = HUD.GET_BLIP_COORDS(Blip)
                TELEPORT(Pos.x, Pos.y, Pos.z)

                local Hash = util.joaat("t20")
                STREAMING.REQUEST_MODEL(Hash)
                while not STREAMING.HAS_MODEL_LOADED(Hash) do
                    util.yield()
                end

                local Veh = entities.create_vehicle(Hash, players.get_position(players.user()), CAM.GET_GAMEPLAY_CAM_ROT(0).z)
                TASK.TASK_WARP_PED_INTO_VEHICLE(players.user_ped(), Veh, -1)
                STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(Hash)
                PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 51, 1) -- Press E to start Time Trial
                util.yield(1500)
                menu.trigger_commands("tpobjective")
                util.yield(500)
                entities.delete_by_handle(Veh)

                STAT_SET_INT("MPPLY_TIMETRIAL_COMPLETED_WEEK", -1)
                menu.trigger_commands("hctimercustom off")
                util.yield(500)

                menu.trigger_commands("hctimertime " .. menu.get_value(COOLDOWN_TIME_TRIAL))
                menu.trigger_commands("hctimercustom on")
                NOTIFY(TRANSLATE("Finished The Time Trial! Waiting for the cooldown timer..."))
                util.yield(500)
                while menu.get_value(TIMER_CUSTOM) do
                    util.yield()
                end
            end, function()
                menu.trigger_commands("hctimertime 1200")
                menu.trigger_commands("hctimercustom off")
            end)

            menu.toggle_loop(AFK_MONEY, TRANSLATE("Auto Headhunter"), {"hcautoheadhunter"}, TRANSLATE("Also works playing with your associates. Just hire the user to do it.") .. "\n\n" .. TRANSLATE("If you expect Transaction Error, stop using this feature and have to restart your game to fix it."), function()
                if players.get_boss(players.user()) == -1 then
                    menu.trigger_commands("ceostart")
                    NOTIFY(TRANSLATE("Starting CEO... Please wait for a few secs."))
                    util.yield(5000)
                end

                menu.trigger_commands("nopimenugrey on")
                if util.is_interaction_menu_open() then
                    IA_MENU_OPEN_OR_CLOSE()
                end
                SET_INT_GLOBAL(2766485, 29) -- Renders VIP Work screen of the Interaction Menu
                IA_MENU_OPEN_OR_CLOSE()
                IA_MENU_DOWN(8)
                IA_MENU_ENTER(2)

                util.yield(2000)
                menu.trigger_commands("noworkcooldown on") 
                menu.trigger_commands("hcinsfinhh")

                menu.trigger_commands("hctimercustom off")
                NOTIFY(TRANSLATE("Playing one time has been done! Waiting for the cooldown time..."))
                menu.trigger_commands("hctimertime 300")
                menu.trigger_commands("hctimercustom on")
                while menu.get_value(TIMER_CUSTOM) do
                    util.yield()
                end
            end, function()
                menu.trigger_commands("hctimertime 1200")
                menu.trigger_commands("hctimercustom off")
            end)

            menu.toggle_loop(AFK_MONEY, TRANSLATE("Auto Sightseer"), {"hcautosightseer"}, IS_WORKING(true) .. TRANSLATE("Also works playing with your associates. Just hire the user to do it.") .. "\n\n" .. TRANSLATE("If you expect Transaction Error, stop using this feature and have to restart your game to fix it."), function()              
                if players.get_boss(players.user()) == -1 then
                    menu.trigger_commands("ceostart")
                    NOTIFY(TRANSLATE("Starting CEO... Please wait for a few secs."))
                    util.yield(5000)
                end

                menu.trigger_commands("nopimenugrey on")
                if util.is_interaction_menu_open() then
                    IA_MENU_OPEN_OR_CLOSE()
                end
                SET_INT_GLOBAL(2766485, 29) -- Renders VIP Work screen of the Interaction Menu
                IA_MENU_OPEN_OR_CLOSE()
                IA_MENU_UP(2)
                IA_MENU_ENTER(2)

                util.yield(5000)
                menu.trigger_commands("noworkcooldown on")
                menu.trigger_commands("hcinsfinss")

                menu.trigger_commands("hctimercustom off")
                NOTIFY(TRANSLATE("Playing one time has been done! Waiting for the cooldown time..."))
                menu.trigger_commands("hctimertime 300")
                menu.trigger_commands("hctimercustom on")
                while menu.get_value(TIMER_CUSTOM) do
                    util.yield()
                end
            end, function()
                menu.trigger_commands("hctimertime 1200")
                menu.trigger_commands("hctimercustom off")
            end)

        ---

    ---

    local INSTANT_FINISH = menu.list(TOOLS, TRANSLATE("Instant Finish Heists & Others"), {"hcinsfin"}, "", function(); end)

        menu.divider(INSTANT_FINISH, "Heists")

            menu.action(INSTANT_FINISH, TRANSLATE("Cayo / Tuners / ULP / Agency"), {"hcinsfincp"}, IS_WORKING(true) .. TRANSLATE("(Local)") .. "\n\n" .. TRANSLATE("Note that not working on ULP Missions - Superyatch"), function() -- https://www.unknowncheats.me/forum/3524081-post3.html
                menu.trigger_commands("scripthost")

                SET_INT_LOCAL("fm_mission_controller_2020", 42279 + 1, 51338752)
                SET_INT_LOCAL("fm_mission_controller_2020", 42279 + 1375 + 1, 50)
            end)

            menu.action(INSTANT_FINISH, TRANSLATE("Casino Aggressive / Classic"), {"hcinsfincah"}, IS_WORKING(false), function()
                menu.trigger_commands("scripthost")
                
                SET_INT_LOCAL("fm_mission_controller", 19707 + 1741, 151)
                SET_INT_LOCAL("fm_mission_controller", 19707 + 2686, 10000000)
                SET_INT_LOCAL("fm_mission_controller", 27471 + 859, 99999)
                SET_INT_LOCAL("fm_mission_controller", 31585 + 69, 99999)
                SET_INT_LOCAL("fm_mission_controller", 31585 + 97, 79)
            end)

            menu.action(INSTANT_FINISH, TRANSLATE("Doomsday"), {"hcinsfindooms"}, IS_WORKING(false), function()
                menu.trigger_commands("scripthost")

                SET_INT_LOCAL("fm_mission_controller", 19707, 12)
                SET_INT_LOCAL("fm_mission_controller", 28329 + 1, 99999)
                SET_INT_LOCAL("fm_mission_controller", 31585 + 69, 99999)
            end)
            
        ---

        menu.divider(INSTANT_FINISH, TRANSLATE("Others"))

            menu.action(INSTANT_FINISH, TRANSLATE("Bunker"), {"hcinsfinbk"}, IS_WORKING(true) .. TRANSLATE("(Selling Only)"), function() -- https://www.unknowncheats.me/forum/3521137-post39.html
                SET_INT_LOCAL("gb_gunrunning", 1205 + 774, 0)
            end)

            menu.action(INSTANT_FINISH, TRANSLATE("Air Cargo"), {"hcinsfinac"}, IS_WORKING(true) .. TRANSLATE("(Selling Only)"), function() -- https://www.unknowncheats.me/forum/3513482-post37.html
                SET_INT_LOCAL("gb_smuggler", 1928 + 1035, GET_INT_LOCAL("gb_smuggler", 1928 + 1078))
            end)

            menu.action(INSTANT_FINISH, TRANSLATE("Headhunter"), {"hcinsfinhh"}, "", function()
                local Blip = HUD.GET_FIRST_BLIP_INFO_ID(432) -- Thanks to Sapphire#6031 helping me code this
                while Blip ~= 0 do
                    local Ped = HUD.GET_BLIP_INFO_ID_ENTITY_INDEX(Blip)
                    ENTITY.SET_ENTITY_HEALTH(Ped, 0)
                    Blip = HUD.GET_NEXT_BLIP_INFO_ID(432)
                    util.yield()
                end

                util.yield(2000)
                util.set_local_player_wanted_level(0, false)
            end)

            menu.action(INSTANT_FINISH, TRANSLATE("Sightseer"), {"hcinsfinss"}, IS_WORKING(false), function() -- https://www.unknowncheats.me/forum/3488056-post24.html
                SET_INT_LOCAL("gb_sightseer", 249 + 1 + NETWORK.PARTICIPANT_ID_TO_INT() * 6 + 5, 3)
            end)
            
        ---

    ---

    local COOLDOWN_TIMER = menu.list(TOOLS, TRANSLATE("Heist Cooldown Timers"), {}, TRANSLATE("HC can show you when the heist's cooldown has passed."), function(); end)

        local TimerCayoTotal, TimerCasinoTotal, TimerDoomsTotal, TimerClassicTotal, TimerRobberyTotal, TimerAgencyTotal, TimerCustomTotal = 1200, 1200, 1200, 1200, 1200, 1200, 1200

        local TimerCayoMin, TimerCayoPlus, TimerCayoSec = 0, 0, 0
        local TimerCasinoMin, TimerCasinoPlus, TimerCasinoSec = 0, 0, 0
        local TimerDoomsMin, TimerDoomsPlus, TimerDoomsSec = 0, 0, 0
        local TimerClassicMin, TimerClassicPlus, TimerClassicSec = 0, 0, 0
        local TimerRobberyMin, TimerRobberyPlus, TimerRobberySec = 0, 0, 0
        local TimerAgencyMin, TimerAgencyPlus, TimerAgencySec = 0, 0, 0
        local TimerCustomMin, TimerCustomPlus, TimerCustomSec = 0, 0, 0

        local TimerCustomTime = 1200
        local TimerPos = {}

        menu.divider(COOLDOWN_TIMER, TRANSLATE("Settings"))

            local TIMER_POS = menu.list(COOLDOWN_TIMER, TRANSLATE("Text's Position"), {}, "", function(); end)

                menu.divider(TIMER_POS, TRANSLATE("Heist Control"))

                    TimerPos.X = 0.97
                    menu.slider(TIMER_POS, "X", {"hctimerx"}, "", 0, 100, 97, 1, function(X)
                        TimerPos.X = X / 100
                    end)

                    TimerPos.Y = 0.12
                    menu.slider(TIMER_POS, "Y", {"hctimery"}, "", 0, 100, 12, 1, function(Y)
                        TimerPos.Y = Y / 100
                    end)

                ---

                menu.divider(TIMER_POS, "Stand")

                    menu.action(TIMER_POS, "Stand", {}, "", function()
                        local Ref = menu.ref_by_command_name("infotextpos")
                        menu.focus(Ref)
                    end)

                ---

            ---

            menu.list_action(COOLDOWN_TIMER, TRANSLATE("Text Color"), {}, "", {
                { TRANSLATE("Heist Control") },
                { "Stand" },
            }, function(Index)
                if Index == 1 then
                    local Ref = menu.ref_by_command_name("hctimercolor")
                    menu.focus(Ref)
                elseif Index == 2 then
                    local Ref = menu.ref_by_command_name("hud")
                    menu.focus(Ref)
                end
            end)

            menu.toggle(COOLDOWN_TIMER, TRANSLATE("Use Stand's Overlay"), {}, TRANSLATE("Enabled: Use Stand's Overlay & Settings: Game > Info Overlay") .. "\n\n" .. TRANSLATE("Disabled: Use Heist Control's Overlay & Settings"), function(Toggle)
                IsStandOverlay = Toggle
            end)
            menu.slider(COOLDOWN_TIMER, TRANSLATE("Set Custom Time (Seconds)"), {"hctimertime"}, "", 0, 259200, 1200, 60, function(Value)
                TimerCustomTotal, TimerCustomTime = Value, Value
            end)

        ---

        menu.divider(COOLDOWN_TIMER, TRANSLATE("Heist Cooldown Timer"))

            TIMER_CAYO = menu.toggle(COOLDOWN_TIMER, TRANSLATE("Cayo Perico Heist"), {"hctimercp"}, "", function()
                if not menu.get_value(TIMER_CAYO) then
                    TimerCayoTotal, TimerCayoMin, TimerCayoPlus, TimerCayoSec = 1200, 0, 0, 0
                end

                while menu.get_value(TIMER_CAYO) do
                    if TimerCayoTotal == 0 then
                        NOTIFY(TRANSLATE("Cayo Perico Heist") .. " - " .. TRANSLATE("Cooldown time has passed, you can play the heist again!"))
                        menu.set_value(TIMER_CAYO, false)
                    end
  
                    TimerCayoTotal = TimerCayoTotal - 1
                    TimerCayoMin = math.floor(TimerCayoTotal / 60)
                    TimerCayoPlus = TimerCayoPlus + 1
                    TimerCayoSec = 1200 - TimerCayoMin * 60 - TimerCayoPlus
                    util.yield(1000)
                end
            end)

            TIMER_CASINO = menu.toggle(COOLDOWN_TIMER, TRANSLATE("Diamond Casino Heist"), {"hctimercah"}, "", function()
                if not menu.get_value(TIMER_CASINO) then
                    TimerCasinoTotal, TimerCasinoMin, TimerCasinoPlus, TimerCasinoSec = 1200, 0, 0, 0
                end

                while menu.get_value(TIMER_CASINO) do
                    if TimerCasinoTotal == 0 then
                        NOTIFY(TRANSLATE("Diamond Casino Heist") .. " - " .. TRANSLATE("Cooldown time has passed, you can play the heist again!"))
                        menu.set_value(TIMER_CASINO, false)
                    end

                    TimerCasinoTotal = TimerCasinoTotal - 1
                    TimerCasinoMin = math.floor(TimerCasinoTotal / 60)
                    TimerCasinoPlus = TimerCasinoPlus + 1
                    TimerCasinoSec = 1200 - TimerCasinoMin * 60 - TimerCasinoPlus
                    util.yield(1000)
                end
            end)

            TIMER_DOOMS = menu.toggle(COOLDOWN_TIMER, TRANSLATE("Doomsday Heist"), {"hctimerdooms"}, "", function()
                if not menu.get_value(TIMER_DOOMS) then
                    TimerDoomsTotal, TimerDoomsMin, TimerDoomsPlus, TimerDoomsSec = 1200, 0, 0, 0
                end

                while menu.get_value(TIMER_DOOMS) do
                    if TimerDoomsTotal == 0 then
                        NOTIFY(TRANSLATE("Doomsday Heist") .. " - " .. TRANSLATE("Cooldown time has passed, you can play the heist again!"))
                        menu.set_value(TIMER_DOOMS, false)
                    end
                    
                    TimerDoomsTotal = TimerDoomsTotal - 1
                    TimerDoomsMin = math.floor(TimerDoomsTotal / 60)
                    TimerDoomsPlus = TimerDoomsPlus + 1
                    TimerDoomsSec = 1200 - TimerDoomsMin * 60 - TimerDoomsPlus
                    util.yield(1000)
                end
            end)

            TIMER_CLASSIC = menu.toggle(COOLDOWN_TIMER, TRANSLATE("Classic Heist"), {"hctimerclassic"}, "", function()
                if not menu.get_value(TIMER_CLASSIC) then
                    TimerClassicTotal, TimerClassicMin, TimerClassicPlus, TimerClassicSec = 1200, 0, 0, 0
                end

                while menu.get_value(TIMER_CLASSIC) do
                    if TimerClassicTotal == 0 then
                        NOTIFY(TRANSLATE("Classic Heist") .. " - " .. TRANSLATE("Cooldown time has passed, you can play the heist again!"))
                        menu.set_value(TIMER_CLASSIC, false)
                    end

                    TimerClassicTotal = TimerClassicTotal - 1
                    TimerClassicMin = math.floor(TimerClassicTotal / 60)
                    TimerClassicPlus = TimerClassicPlus + 1
                    TimerClassicSec = 1200 - TimerClassicMin * 60 - TimerClassicPlus
                    util.yield(1000)
                end
            end)

            TIMER_ROBBERY = menu.toggle(COOLDOWN_TIMER, TRANSLATE("LS Tuners Robbery"), {"hctimerrobbery"}, "", function()
                if not menu.get_value(TIMER_ROBBERY) then
                    TimerRobberyTotal, TimerRobberyMin, TimerRobberyPlus, TimerRobberySec = 1200, 0, 0, 0
                end

                while menu.get_value(TIMER_ROBBERY) do
                    if TimerRobberyTotal == 0 then
                        NOTIFY(TRANSLATE("LS Tuners Robbery") .. " - " .. TRANSLATE("Cooldown time has passed, you can play the heist again!"))
                        menu.set_value(TIMER_ROBBERY, false)
                    end

                    TimerRobberyTotal = TimerRobberyTotal - 1
                    TimerRobberyMin = math.floor(TimerRobberyTotal / 60)
                    TimerRobberyPlus = TimerRobberyPlus + 1
                    TimerRobberySec = 1200 - TimerRobberyMin * 60 - TimerRobberyPlus
                    util.yield(1000)
                end
            end)

            TIMER_AGENCY = menu.toggle(COOLDOWN_TIMER, TRANSLATE("The Contract: Agency"), {"hctimeragency"}, "", function()
                if not menu.get_value(TIMER_AGENCY) then
                    TimerAgencyTotal, TimerAgencyMin, TimerAgencyPlus, TimerAgencySec = 1200, 0, 0, 0
                end

                while menu.get_value(TIMER_AGENCY) do
                    if TimerAgencyTotal == 0 then
                        NOTIFY(TRANSLATE("The Contract: Agency") .. " - " .. TRANSLATE("Cooldown time has passed, you can play the heist again!"))
                        menu.set_value(TIMER_AGENCY, false)
                    end

                    TimerAgencyTotal = TimerAgencyTotal - 1
                    TimerAgencyMin = math.floor(TimerAgencyTotal / 60)
                    TimerAgencyPlus = TimerAgencyPlus + 1
                    TimerAgencySec = 1200 - TimerAgencyMin * 60 - TimerAgencyPlus
                    util.yield(1000)
                end
            end)

            TIMER_CUSTOM = menu.toggle(COOLDOWN_TIMER, TRANSLATE("Custom Timer"), {"hctimercustom"}, "", function()
                if not menu.get_value(TIMER_CUSTOM) then
                    TimerCustomTotal, TimerCustomMin, TimerCustomPlus, TimerCustomSec = TimerCustomTime, 0, 0, 0
                end

                while menu.get_value(TIMER_CUSTOM) do
                    if TimerCustomTotal == 0 then
                        NOTIFY(TRANSLATE("Custom Timer") .. " - " .. TRANSLATE("Cooldown time has passed, you can play the heist again!"))
                        menu.set_value(TIMER_CUSTOM, false)
                    end

                    TimerCustomTotal = TimerCustomTotal - 1
                    TimerCustomMin = math.floor(TimerCustomTotal / 60)
                    TimerCustomPlus = TimerCustomPlus + 1
                    TimerCustomSec = TimerCustomTime - TimerCustomMin * 60 - TimerCustomPlus
                    util.yield(1000)
                end
            end)

        ---

        TimerRGB = RGB(0, 0, 0, 1) -- https://gist.github.com/Lerg/586c387f978121d264d6#file-colors-lua
        util.create_tick_handler(function() -- Refresh timer color setting per tick
            if filesystem.exists(SettingDir) then
                if READ_SETTING("Timer Color") == "Black" then
                    TimerRGB = RGB(0, 0, 0, 1)
                elseif READ_SETTING("Timer Color") == "White" then
                    TimerRGB = RGB(1, 1, 1, 1)
                elseif READ_SETTING("Timer Color") == "Red" then
                    TimerRGB = RGB(1, 0, 0, 1)
                elseif READ_SETTING("Timer Color") == "Orange" then
                    TimerRGB = RGB(1, 0.64705882352941, 0, 1)
                elseif READ_SETTING("Timer Color") == "Yellow" then
                    TimerRGB = RGB(1, 1, 0, 1)
                elseif READ_SETTING("Timer Color") == "Mint" then
                    TimerRGB = RGB(0.12549019607843, 0.69803921568627, 0.66666666666667, 1)
                elseif READ_SETTING("Timer Color") == "Green" then
                    TimerRGB = RGB(0, 0.50196078431373, 0, 1)
                elseif READ_SETTING("Timer Color") == "Light Blue" then
                    TimerRGB = RGB(0.67843137254902, 0.84705882352941, 0.90196078431373, 1)
                else 
                    WRITE_SETTING("Timer Color", "White")
                    TimerRGB = RGB(1, 1, 1, 1)
                end  
            end
        end)

        util.create_tick_handler(function() -- Show timer texts per tick
            if IsStandOverlay then
                if menu.get_value(TIMER_CAYO) then
                    util.draw_debug_text(TRANSLATE("Cayo Perico Heist") .. " [" .. TimerCayoMin .. ":" .. TimerCayoSec .. "]")
                end
                if menu.get_value(TIMER_CASINO) then
                    util.draw_debug_text(TRANSLATE("Diamond Casino Heist") .. " [" .. TimerCasinoMin .. ":" .. TimerCasinoSec .. "]")
                end
                if menu.get_value(TIMER_DOOMS) then
                    util.draw_debug_text(TRANSLATE("Doomsday Heist") .. " [" .. TimerDoomsMin .. ":" .. TimerDoomsSec .. "]")
                end
                if menu.get_value(TIMER_CLASSIC) then
                    util.draw_debug_text(TRANSLATE("Classic Heist") .. " [" .. TimerClassicMin .. ":" .. TimerClassicSec .. "]")
                end
                if menu.get_value(TIMER_ROBBERY) then
                    util.draw_debug_text(TRANSLATE("LS Tuners Robbery") .. " [" .. TimerRobberyMin .. ":" .. TimerRobberySec .. "]")
                end
                if menu.get_value(TIMER_AGENCY) then
                    util.draw_debug_text(TRANSLATE("The Contract: Agency") .. " [" .. TimerAgencyMin .. ":" .. TimerAgencySec .. "]")
                end
                if menu.get_value(TIMER_CUSTOM) then
                    util.draw_debug_text(TRANSLATE("Custom Timer") .. " [" .. TimerCustomMin .. ":" .. TimerCustomSec .. "]")
                end
            else
                if menu.get_value(TIMER_CAYO) or menu.get_value(TIMER_CASINO) or menu.get_value(TIMER_DOOMS) or menu.get_value(TIMER_CLASSIC) or menu.get_value(TIMER_ROBBERY) or menu.get_value(TIMER_AGENCY) or menu.get_value(TIMER_CUSTOM) then
                    directx.draw_text(TimerPos.X, TimerPos.Y + 0.00, TRANSLATE("Cayo Perico Heist") .. " [" .. TimerCayoMin .. ":" .. TimerCayoSec .. "]", 2, 0.6, TimerRGB, false)
                    directx.draw_text(TimerPos.X, TimerPos.Y + 0.02, TRANSLATE("Diamond Casino Heist") .. " [" .. TimerCasinoMin .. ":" .. TimerCasinoSec .. "]", 2, 0.6, TimerRGB, false)
                    directx.draw_text(TimerPos.X, TimerPos.Y + 0.04, TRANSLATE("Doomsday Heist") .. " [" .. TimerDoomsMin .. ":" .. TimerDoomsSec .. "]", 2, 0.6, TimerRGB, false)
                    directx.draw_text(TimerPos.X, TimerPos.Y + 0.06, TRANSLATE("Classic Heist") .. " [" .. TimerClassicMin .. ":" .. TimerClassicSec .. "]", 2, 0.6, TimerRGB, false)
                    directx.draw_text(TimerPos.X, TimerPos.Y + 0.08, TRANSLATE("LS Tuners Robbery") .. " [" .. TimerRobberyMin .. ":" .. TimerRobberySec .. "]", 2, 0.6, TimerRGB, false)
                    directx.draw_text(TimerPos.X, TimerPos.Y + 0.10, TRANSLATE("The Contract: Agency") .. " [" .. TimerAgencyMin .. ":" .. TimerAgencySec .. "]", 2, 0.6, TimerRGB, false)
                    directx.draw_text(TimerPos.X, TimerPos.Y + 0.12, TRANSLATE("Custom Timer") .. " [" .. TimerCustomMin .. ":" .. TimerCustomSec .. "]", 2, 0.6, TimerRGB, false)
                end
            end
        end)

    ---

    local NEAR_PED_CAM = menu.list(TOOLS, TRANSLATE("Manage Nearby Peds And Cams"), {}, "", function(); end)

        menu.divider(NEAR_PED_CAM, TRANSLATE("Settings"))
            
            IS_HOSTILE_PED = menu.toggle(NEAR_PED_CAM, TRANSLATE("Work only to hostile peds"), {}, TRANSLATE("Enabled: Ped options will only affect hostile peds") .. "\n\n" .. TRANSLATE("Disabled: Ped options will affect all peds"), function() end)

        ---

        menu.divider(NEAR_PED_CAM, TRANSLATE("Peds"))

            menu.action(NEAR_PED_CAM, TRANSLATE("Remove Weapons"), {"hcremwepon"}, "", function()
                for k, ent in pairs(entities.get_all_peds_as_handles()) do
                    if not IS_PED_PLAYER(ent) then
                        if menu.get_value(IS_HOSTILE_PED) then
                            if PED.IS_PED_IN_COMBAT(ent, players.user()) then
                                WEAPON.REMOVE_ALL_PED_WEAPONS(ent, true)
                            end
                        else
                            WEAPON.REMOVE_ALL_PED_WEAPONS(ent, true)
                        end
                    end
                end
            end)

            menu.action(NEAR_PED_CAM, TRANSLATE("Delete"), {"hcdelped"}, "", function()
                for k, ent in pairs(entities.get_all_peds_as_handles()) do
                    if not IS_PED_PLAYER(ent) then
                        if menu.get_value(IS_HOSTILE_PED) then
                            if PED.IS_PED_IN_COMBAT(ent, players.user()) then
                                entities.delete_by_handle(ent)
                            end
                        else
                            entities.delete_by_handle(ent)
                        end
                    end
                end
            end)

            menu.action(NEAR_PED_CAM, TRANSLATE("Kill"), {"hckillped"}, "", function()
                for k, ent in pairs(entities.get_all_peds_as_handles()) do
                    if not IS_PED_PLAYER(ent) then
                        if menu.get_value(IS_HOSTILE_PED) then
                            if PED.IS_PED_IN_COMBAT(ent, players.user()) then
                                ENTITY.SET_ENTITY_HEALTH(ent, 0)
                            end
                        else
                            ENTITY.SET_ENTITY_HEALTH(ent, 0)
                        end
                    end
                end
            end)

            menu.action(NEAR_PED_CAM, TRANSLATE("Shoot"), {"hcshootped"}, "", function() -- Thanks for coding this, Pedro9558#3559
                for k, ent in pairs(entities.get_all_peds_as_handles()) do
                    if not IS_PED_PLAYER(ent) and not ENTITY.IS_ENTITY_DEAD(ent) then
                        local PedPos = v3.new(ENTITY.GET_ENTITY_COORDS(ent))
                        local AddPos = v3.new(ENTITY.GET_ENTITY_COORDS(ent))
                        AddPos:add(v3.new(0, 0, 1))
                        if menu.get_value(IS_HOSTILE_PED) then
                            if PED.IS_PED_IN_COMBAT(ent, players.user()) then
                                if (PED.GET_VEHICLE_PED_IS_USING(ent) ~= 0) then
                                    TASK.CLEAR_PED_TASKS_IMMEDIATELY(ent)
                                end
                                MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(AddPos.x, AddPos.y, AddPos.z, PedPos.x, PedPos.y, PedPos.z, 1000, false, 0xC472FE2, players.user_ped(), false, true, 1000)
                            end
                        else
                            if (PED.GET_VEHICLE_PED_IS_USING(ent) ~= 0) then
                                TASK.CLEAR_PED_TASKS_IMMEDIATELY(ent)
                            end
                            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(AddPos.x, AddPos.y, AddPos.z, PedPos.x, PedPos.y, PedPos.z, 1000, false, 0xC472FE2, players.user_ped(), false, true, 1000)
                        end
                    end
                end
            end)

        ---

        menu.divider(NEAR_PED_CAM, TRANSLATE("Cameras"))

            menu.action(NEAR_PED_CAM, TRANSLATE("Delete"), {"hcdelcam"}, "(" .. TRANSLATE("Cayo Perico Heist") .. " & " .. TRANSLATE("Diamond Casino Heist") .. ")", function()
                for k, ent in pairs(entities.get_all_objects_as_handles()) do
                    local Cams = {
                        -1233322078,
                        168901740,
                        -1095296451,
                        -173206916,
                        -1159421424,
                        548760764,
                        -1340405475,
                        1449155105,
                        -354221800,
                        -1884701657,
                        2090203758,
                        -1007354661,
                        -1842407088,
                        289451089,
                        3061645218,
                        -247409812,
                    }

                    local EntityModel = ENTITY.GET_ENTITY_MODEL(ent)
                    for i = 1, #Cams do
                        if EntityModel == Cams[i] then
                            entities.delete_by_handle(ent)
                        end
                    end
                end
            end)

        ---

    ---

    local BYPASS_DOOR = menu.list(TOOLS, TRANSLATE("Bypass Locked Doors"), {}, "", function(); end)

        menu.divider(BYPASS_DOOR, TRANSLATE("Settings"))

            NOCLIP_SPEED = menu.slider(BYPASS_DOOR, TRANSLATE("Speed of Improved No Clip"), {"hcspdhcnoclip"}, "", 1, 100, 10, 5, function(); end)
            DISTANCE_TPTF = menu.slider(BYPASS_DOOR, TRANSLATE("Distance of Teleport To Forward"), {"hcdishctptf"}, "", 1, 100, 10, 5, function(); end)

        ---

        menu.divider(BYPASS_DOOR, TRANSLATE("Bypass Locked Doors"))

            menu.toggle(BYPASS_DOOR, TRANSLATE("Improved No Clip"), {"hcnoclip"}, "", function(Toggle) -- From Command Box Scripts: No Clip
                ImprovedNoClip = Toggle
        
                if ImprovedNoClip then
                    menu.trigger_commands("levitate on")
                    menu.trigger_commands("levitatespeed " .. menu.get_value(NOCLIP_SPEED) * 0.01)
                    menu.trigger_commands("levitatesprintmultiplier 0.50")
                    menu.trigger_commands("levitatepassivemin 0")
                    menu.trigger_commands("levitatepassivemax 0")
                    menu.trigger_commands("levitatepassivespeed 0")
                    menu.trigger_commands("levitateassistup 0")
                    menu.trigger_commands("levitateassistdown 0")
                    menu.trigger_commands("levitateassistdeadzone 0")
                    menu.trigger_commands("levitateassistsnap 0")
                else
                    menu.trigger_commands("levitate off")
                end

                while ImprovedNoClip do
                    menu.trigger_commands("levitatespeed " .. menu.get_value(NOCLIP_SPEED) * 0.01)
                    util.yield(500)
                end
            end)
    
            menu.action(BYPASS_DOOR, TRANSLATE("Teleport To Forward"), {"hctptf"}, "", function() -- Credit goes to LanceScript-reloaded
                local Handle = PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) and PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false) or players.user_ped()
                local Pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(Handle, 0, menu.get_value(DISTANCE_TPTF) * 0.1, 0)
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Handle, Pos.x, Pos.y, Pos.z, false, false, false)
            end)

        ---

    ---

    local REQ_SERVICE = menu.list(TOOLS, TRANSLATE("Request Services"), {}, "", function(); end) -- freemode.c, https://www.unknowncheats.me/forum/3442776-post4.html

        menu.action(REQ_SERVICE, TRANSLATE("MOC"), {"hcreqmoc"}, IS_WORKING(false), function()
            SET_INT_GLOBAL(2793044 + 925, 1)
        end)
        menu.action(REQ_SERVICE, TRANSLATE("Avenger"), {"hcreqavenger"}, IS_WORKING(false), function()
            SET_INT_GLOBAL(2793044 + 933, 1)
        end)
        menu.action(REQ_SERVICE, TRANSLATE("Terrobyte"), {"hcreqterrobyte"}, IS_WORKING(false), function()
            SET_INT_GLOBAL(2793044 + 937, 1)
        end)
        menu.action(REQ_SERVICE, TRANSLATE("Kosatka"), {"hcreqkosatka"}, IS_WORKING(false), function()
            SET_INT_GLOBAL(2793044 + 954, 1)
        end)
        menu.action(REQ_SERVICE, TRANSLATE("Dingy"), {"hcreqdingy"}, IS_WORKING(false), function()
            SET_INT_GLOBAL(2793044 + 966, 1)
        end)
        menu.action(REQ_SERVICE, TRANSLATE("Ballistic Armor"), {"hcreqminigun"}, IS_WORKING(false), function()
            SET_INT_GLOBAL(2793044 + 886, 1)
        end)

    ---

    local INFO_SPOOFING = menu.list(TOOLS, TRANSLATE("Stat Spoofing"), {}, TRANSLATE("Change your session to apply!"), function(); end)

        local INFO_SPOOFING_WALLET_MONEY = menu.list(INFO_SPOOFING, TRANSLATE("Wallet Money"), {}, "", function(); end) -- freemode.c

            menu.toggle_loop(INFO_SPOOFING_WALLET_MONEY, TRANSLATE("Enable"), {}, IS_WORKING(false), function()
                SET_INT_GLOBAL((1853910 + 1 + players.user() * 862) + 205 + 3, menu.get_value(WALLET_MONEY_SPOOFING))
            end, function()
                SET_INT_GLOBAL((1853910 + 1 + players.user() * 862) + 205 + 3, players.get_wallet(players.user()))
            end)

            WALLET_MONEY_SPOOFING = menu.slider(INFO_SPOOFING_WALLET_MONEY, TRANSLATE("Value"), {"hcwalletmoneyspoofing"}, "", INT_MIN, INT_MAX, players.get_wallet(players.user()), 10000, function(); end)

        --- 

        local INFO_SPOOFING_MONEY = menu.list(INFO_SPOOFING, TRANSLATE("Total Money"), {}, "", function(); end) -- freemode.c

            menu.toggle_loop(INFO_SPOOFING_MONEY, TRANSLATE("Enable"), {}, IS_WORKING(false), function()
                SET_INT_GLOBAL((1853910 + 1 + players.user() * 862) + 205 + 56, menu.get_value(TOTAL_MONEY_SPOOFING))
            end, function()
                SET_INT_GLOBAL((1853910 + 1 + players.user() * 862) + 205 + 56, players.get_money(players.user()))
            end)

            TOTAL_MONEY_SPOOFING = menu.slider(INFO_SPOOFING_MONEY, TRANSLATE("Value"), {"hctotalmoneyspoofing"}, "", INT_MIN, INT_MAX, players.get_bank(players.user()), 10000, function(); end)

        ---

        local INFO_SPOOFING_KILL = menu.list(INFO_SPOOFING, TRANSLATE("Kills"), {}, "", function(); end) -- freemode.c

            menu.toggle_loop(INFO_SPOOFING_KILL, TRANSLATE("Enable"), {}, IS_WORKING(false), function()
                SET_INT_GLOBAL((1853910 + 1 + players.user() * 862) + 205 + 28, menu.get_value(KILL_SPOOFING))
            end, function()
                SET_INT_GLOBAL((1853910 + 1 + players.user() * 862) + 205 + 28, players.get_kills(players.user()))
            end)

            KILL_SPOOFING = menu.slider(INFO_SPOOFING_KILL, TRANSLATE("Value"), {"hckillspoofing"}, "", INT_MIN, INT_MAX, players.get_kills(players.user()), 1, function(); end)

        ---

        local INFO_SPOOFING_DEATH = menu.list(INFO_SPOOFING, TRANSLATE("Deaths"), {}, "", function(); end)

            menu.toggle_loop(INFO_SPOOFING_DEATH, TRANSLATE("Enable"), {}, IS_WORKING(false), function() -- freemode.c
                SET_INT_GLOBAL((1853910 + 1 + players.user() * 862) + 205 + 29, menu.get_value(DEATH_SPOOFING))
            end, function()
                SET_INT_GLOBAL((1853910 + 1 + players.user() * 862) + 205 + 29, players.get_deaths(players.user()))
            end)

            DEATH_SPOOFING = menu.slider(INFO_SPOOFING_DEATH, TRANSLATE("Value"), {"hcdeathspoofing"}, "", INT_MIN, INT_MAX, players.get_deaths(players.user()), 1, function(); end)

        ---

    ---

    local STAT_EDITOR_READER = menu.list(TOOLS, TRANSLATE("Stat Editor And Reader"), {}, "", function(); end)

        local PRESET_STAT_EDITOR = menu.list(STAT_EDITOR_READER, TRANSLATE("Preset Stat Editor"), {}, "", function(); end)

            local PLAYTIME_EDITOR = menu.list(PRESET_STAT_EDITOR, TRANSLATE("Playtime"), {}, "", function(); end)

                menu.divider(PLAYTIME_EDITOR, TRANSLATE("Method"))

                    IS_TIME_ADDING_METHOD = menu.toggle(PLAYTIME_EDITOR, TRANSLATE("Add Additional Playtime"), {}, TRANSLATE("Enabled: Add Method") .. "\n" .. TRANSLATE("- Adds Up To Your Current Playtime") .. "\n\n" .. TRANSLATE("Disabled: Overwrite Method") .. "\n" .. TRANSLATE("- Overwrites Your Current Playtime") .. "\n\n" .. TRANSLATE("Note: The overwrite method supports up to 24.8 days, but add method supports up to 50,000 days"), function(); end)

                ---
                
                menu.divider(PLAYTIME_EDITOR, TRANSLATE("Modify Stat"))

                    PLAYTIME_DAY = menu.slider(PLAYTIME_EDITOR, TRANSLATE("Days"), {"hcplaytimeday"}, "", 0, 50000, 0, 1, function(); end)
                    PLAYTIME_HOUR = menu.slider(PLAYTIME_EDITOR, TRANSLATE("Hours"), {"hcplaytimehour"}, "", 0, 50000, 0, 1, function(); end)
                    PLAYTIME_MIN = menu.slider(PLAYTIME_EDITOR, TRANSLATE("Minutes"), {"hcplaytimemin"}, "", 0, 50000, 0, 1, function(); end)

                ---

                menu.divider(PLAYTIME_EDITOR, TRANSLATE("Set Stat"))

                    menu.action(PLAYTIME_EDITOR, TRANSLATE("Total Playtime"), {}, "", function()
                        if not menu.get_value(IS_TIME_ADDING_METHOD) then
                            STAT_SET_INT("TOTAL_PLAYING_TIME", menu.get_value(PLAYTIME_DAY) * 86400000 + menu.get_value(PLAYTIME_HOUR) * 3600000 + menu.get_value(PLAYTIME_MIN) * 60000)
                        else
                            STAT_SET_INCREMENT("TOTAL_PLAYING_TIME", menu.get_value(PLAYTIME_DAY) * 86400000 + menu.get_value(PLAYTIME_HOUR) * 3600000 + menu.get_value(PLAYTIME_MIN) * 60000)
                        end

                        NOTIFY(TRANSLATE("Successfully set!") .. "\n\n" .. TRANSLATE("Days") .. ": " .. menu.get_value(PLAYTIME_DAY) .. "\n" .. TRANSLATE("Hours") .. ": " .. menu.get_value(PLAYTIME_HOUR) .. "\n" .. TRANSLATE("Mins") .. ": " .. menu.get_value(PLAYTIME_MIN))
                        FORCE_CLOUD_SAVE()
                    end)
                    menu.action(PLAYTIME_EDITOR, TRANSLATE("GTA Online Playtime"), {}, "", function()
                        if not menu.get_value(IS_TIME_ADDING_METHOD) then
                            STAT_SET_INT("MP_PLAYING_TIME", menu.get_value(PLAYTIME_DAY) * 86400000 + menu.get_value(PLAYTIME_HOUR) * 3600000 + menu.get_value(PLAYTIME_MIN) * 60000)
                        else
                            STAT_SET_INCREMENT("MP_PLAYING_TIME", menu.get_value(PLAYTIME_DAY) * 86400000 + menu.get_value(PLAYTIME_HOUR) * 3600000 + menu.get_value(PLAYTIME_MIN) * 60000)
                        end
        
                        NOTIFY(TRANSLATE("Successfully set!") .. "\n\n" .. TRANSLATE("Days") .. ": " .. menu.get_value(PLAYTIME_DAY) .. "\n" .. TRANSLATE("Hours") .. ": " .. menu.get_value(PLAYTIME_HOUR) .. "\n" .. TRANSLATE("Mins") .. ": " .. menu.get_value(PLAYTIME_MIN))
                        FORCE_CLOUD_SAVE()
                    end)
                    menu.action(PLAYTIME_EDITOR, TRANSLATE("Deathmatches"), {}, "", function()
                        if not menu.get_value(IS_TIME_ADDING_METHOD) then
                            STAT_SET_INT("MPPLY_TOTAL_TIME_SPENT_DEATHMAT", menu.get_value(PLAYTIME_DAY) * 86400000 + menu.get_value(PLAYTIME_HOUR) * 3600000 + menu.get_value(PLAYTIME_MIN) * 60000)
                        else
                            STAT_SET_INCREMENT("MPPLY_TOTAL_TIME_SPENT_DEATHMAT", menu.get_value(PLAYTIME_DAY) * 86400000 + menu.get_value(PLAYTIME_HOUR) * 3600000 + menu.get_value(PLAYTIME_MIN) * 60000)
                        end
        
                        NOTIFY(TRANSLATE("Successfully set!") .. "\n\n" .. TRANSLATE("Days") .. ": " .. menu.get_value(PLAYTIME_DAY) .. "\n" .. TRANSLATE("Hours") .. ": " .. menu.get_value(PLAYTIME_HOUR) .. "\n" .. TRANSLATE("Mins") .. ": " .. menu.get_value(PLAYTIME_MIN))
                        FORCE_CLOUD_SAVE()
                    end)
                    menu.action(PLAYTIME_EDITOR, TRANSLATE("Races"), {}, "", function()
                        if not menu.get_value(IS_TIME_ADDING_METHOD) then
                            STAT_SET_INT("MPPLY_TOTAL_TIME_SPENT_RACES", menu.get_value(PLAYTIME_DAY) * 86400000 + menu.get_value(PLAYTIME_HOUR) * 3600000 + menu.get_value(PLAYTIME_MIN) * 60000)
                        else
                            STAT_SET_INCREMENT("MPPLY_TOTAL_TIME_SPENT_RACES", menu.get_value(PLAYTIME_DAY) * 86400000 + menu.get_value(PLAYTIME_HOUR) * 3600000 + menu.get_value(PLAYTIME_MIN) * 60000)
                        end
        
                        NOTIFY(TRANSLATE("Successfully set!") .. "\n\n" .. TRANSLATE("Days") .. ": " .. menu.get_value(PLAYTIME_DAY) .. "\n" .. TRANSLATE("Hours") .. ": " .. menu.get_value(PLAYTIME_HOUR) .. "\n" .. TRANSLATE("Mins") .. ": " .. menu.get_value(PLAYTIME_MIN))
                        FORCE_CLOUD_SAVE()
                    end)
                    menu.action(PLAYTIME_EDITOR, TRANSLATE("Creator"), {}, "", function()
                        if not menu.get_value(IS_TIME_ADDING_METHOD) then
                            STAT_SET_INT("MPPLY_TOTAL_TIME_MISSION_CREATO", menu.get_value(PLAYTIME_DAY) * 86400000 + menu.get_value(PLAYTIME_HOUR) * 3600000 + menu.get_value(PLAYTIME_MIN) * 60000)
                        else
                            STAT_SET_INCREMENT("MPPLY_TOTAL_TIME_MISSION_CREATO", menu.get_value(PLAYTIME_DAY) * 86400000 + menu.get_value(PLAYTIME_HOUR) * 3600000 + menu.get_value(PLAYTIME_MIN) * 60000)
                        end
        
                        NOTIFY(TRANSLATE("Successfully set!") .. "\n\n" .. TRANSLATE("Days") .. ": " .. menu.get_value(PLAYTIME_DAY) .. "\n" .. TRANSLATE("Hours") .. ": " .. menu.get_value(PLAYTIME_HOUR) .. "\n" .. TRANSLATE("Mins") .. ": " .. menu.get_value(PLAYTIME_MIN))
                        FORCE_CLOUD_SAVE()
                    end)

                ---

            ---

            local CASH_EDITOR = menu.list(PRESET_STAT_EDITOR, TRANSLATE("Cash Earned & Spent"), {}, "", function(); end)

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

        local STAT_EDITOR = menu.list(STAT_EDITOR_READER, TRANSLATE("Custom Stat Editor") .. " " .. TRANSLATE("(Risky)"), {}, TRANSLATE("Use at your own risk! Setting certain stats may cause a ban like casino-related stats."), function(); end)

            menu.divider(STAT_EDITOR, TRANSLATE("Modify Stat"))

                STAT_EDITOR_NAME = menu.text_input(STAT_EDITOR, TRANSLATE("Stat Name"), {"hceditname"}, TRANSLATE("Note: MP0_ or MP1_ will be selected by HC automatically, therefore don't write it."), function(); end)
                STAT_EDITOR_VALUE = menu.text_input(STAT_EDITOR, TRANSLATE("Stat Value"), {"hceditvalue"}, "", function(); end)

                util.create_tick_handler(function()
                    local MenuValue = menu.get_value(STAT_EDITOR_NAME)
                    local UpperValue = string.upper(MenuValue)
                    if MenuValue ~= UpperValue then
                        menu.trigger_commands("hceditname " .. UpperValue)
                    end
                end)

            ---

            menu.divider(STAT_EDITOR, TRANSLATE("Date"))

                DATE_YEAR = menu.slider(STAT_EDITOR, TRANSLATE("Year"), {"hcedityear"}, "", 2013, os.date("%Y"), 0, 1, function(); end)
                DATE_MONTH = menu.slider(STAT_EDITOR, TRANSLATE("Month"), {"hceditmonth"}, "", 0, 12, 0, 1, function(); end)
                DATE_DAY = menu.slider(STAT_EDITOR, TRANSLATE("Days"), {"hceditday"}, "", 0, 31, 0, 1, function(); end)
                DATE_HOUR = menu.slider(STAT_EDITOR, TRANSLATE("Hours"), {"hcedithour"}, "", 0, 24, 0, 1, function(); end)
                DATE_MIN = menu.slider(STAT_EDITOR, TRANSLATE("Mins"), {"hceditmin"}, "", 0, 60, 0, 1, function(); end)

            ---

            menu.divider(STAT_EDITOR, TRANSLATE("Set Stat"))

                menu.action(STAT_EDITOR, TRANSLATE("Integer"), {}, TRANSLATE("Example Stat") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. TRANSLATE("NO_BOUGHT_YUM_SNACKS\n") .. TRANSLATE("Stat Value") .. ": " .. "30", function()
                    if menu.get_value(STAT_EDITOR_NAME) == "" or menu.get_value(STAT_EDITOR_VALUE) == "" then
                        NOTIFY(TRANSLATE("You didn't specify the value. Please specify it!"))
                    else
                        STAT_SET_INT(menu.get_value(STAT_EDITOR_NAME), menu.get_value(STAT_EDITOR_VALUE))
                        NOTIFY(TRANSLATE("Successfully set!") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. ADD_MP_INDEX(menu.get_value(STAT_EDITOR_NAME)) .. "\n" .. TRANSLATE("Stat Value") .. ": " .. menu.get_value(STAT_EDITOR_VALUE))
                        FORCE_CLOUD_SAVE()
                    end
                end)

                menu.action(STAT_EDITOR, TRANSLATE("Float"), {}, TRANSLATE("Example Stat") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. TRANSLATE("PLAYER_MENTAL_STATE\n") .. TRANSLATE("Stat Value") .. ": " .. "100.0", function()
                    if menu.get_value(STAT_EDITOR_NAME) == "" or menu.get_value(STAT_EDITOR_VALUE) == "" then
                        NOTIFY(TRANSLATE("You didn't specify the value. Please specify it!"))
                    else
                        STAT_SET_FLOAT(menu.get_value(STAT_EDITOR_NAME), menu.get_value(STAT_EDITOR_VALUE))
                        NOTIFY(TRANSLATE("Successfully set!") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. ADD_MP_INDEX(menu.get_value(STAT_EDITOR_NAME)) .. "\n" .. TRANSLATE("Stat Value") .. ": " .. menu.get_value(STAT_EDITOR_VALUE))
                        FORCE_CLOUD_SAVE()
                    end
                end)

                menu.action(STAT_EDITOR, TRANSLATE("Boolean"), {}, TRANSLATE("Example Stat") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. TRANSLATE("CL_RACE_MODDED_CAR\n") .. TRANSLATE("Stat Value") .. ": " .. "true or false", function()
                    if menu.get_value(STAT_EDITOR_NAME) == "" or menu.get_value(STAT_EDITOR_VALUE) == "" then
                        NOTIFY(TRANSLATE("You didn't specify the value. Please specify it!"))
                    else
                        STAT_SET_BOOL(menu.get_value(STAT_EDITOR_NAME), menu.get_value(STAT_EDITOR_VALUE))
                        NOTIFY(TRANSLATE("Successfully set!") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. ADD_MP_INDEX(menu.get_value(STAT_EDITOR_NAME)) .. "\n" .. TRANSLATE("Stat Value") .. ": " .. menu.get_value(STAT_EDITOR_VALUE))
                        FORCE_CLOUD_SAVE()
                    end
                end)

                menu.action(STAT_EDITOR, TRANSLATE("String"), {}, TRANSLATE("Example Stat") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. TRANSLATE("CHAR_NAME\n") .. TRANSLATE("Stat Value") .. ": " .. "STRING", function()
                    if menu.get_value(STAT_EDITOR_NAME) == "" or menu.get_value(STAT_EDITOR_VALUE) == "" then
                        NOTIFY(TRANSLATE("You didn't specify the value. Please specify it!"))
                    else
                        STAT_SET_STRING(menu.get_value(STAT_EDITOR_NAME), menu.get_value(STAT_EDITOR_VALUE))
                        NOTIFY(TRANSLATE("Successfully set!") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. ADD_MP_INDEX(menu.get_value(STAT_EDITOR_NAME)) .. "\n" .. TRANSLATE("Stat Value") .. ": " .. menu.get_value(STAT_EDITOR_VALUE))
                        FORCE_CLOUD_SAVE()
                    end
                end)

                menu.action(STAT_EDITOR, TRANSLATE("Date"), {}, TRANSLATE("Example Stat") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. TRANSLATE("CHAR_DATE_CREATED\n") .. TRANSLATE("Stat Value") .. ": " .. "Year: 1970, Month: 1, Day: 1", function()
                    if menu.get_value(STAT_EDITOR_NAME) == "" then
                        NOTIFY(TRANSLATE("You didn't specify the value. Please specify it!"))
                    else
                        STAT_SET_DATE(menu.get_value(STAT_EDITOR_NAME), menu.get_value(DATE_YEAR), menu.get_value(DATE_MONTH), menu.get_value(DATE_DAY), menu.get_value(DATE_HOUR), menu.get_value(DATE_MIN))
                        NOTIFY(TRANSLATE("Successfully set!") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. ADD_MP_INDEX(menu.get_value(STAT_EDITOR_NAME)) .. "\n" .. TRANSLATE("Year: ") .. menu.get_value(DATE_YEAR) .. "\n" .. TRANSLATE("Month: ") .. menu.get_value(DATE_MONTH) .. "\n" ..TRANSLATE("Day: ") .. menu.get_value(DATE_DAY) .. "\n" .. TRANSLATE("Hour: ") .. menu.get_value(DATE_HOUR) .. "\n" .. TRANSLATE("Min: ") .. menu.get_value(DATE_MIN))
                        FORCE_CLOUD_SAVE()
                    end
                end)

            ---

        ---

        local STAT_READER = menu.list(STAT_EDITOR_READER, TRANSLATE("Custom Stat Reader"), {}, "", function(); end)

            menu.divider(STAT_READER, TRANSLATE("Modify Stat"))

                STAT_READER_NAME = menu.text_input(STAT_READER, TRANSLATE("Stat Name"), {"hcreadername"}, "", function(); end)

                util.create_tick_handler(function()
                    local MenuValue = menu.get_value(STAT_READER_NAME)
                    local UpperValue = string.upper(MenuValue)
                    if MenuValue ~= UpperValue then
                        menu.trigger_commands("hcreadername " .. UpperValue)
                    end
                end)

            ---

            menu.divider(STAT_READER, TRANSLATE("Settings"))

                IS_READER_COPY = menu.toggle(STAT_READER, TRANSLATE("Copy Stat Value"), {}, "", function(); end)

            ---

            menu.divider(STAT_READER, TRANSLATE("Read Stat"))

                menu.action(STAT_READER, TRANSLATE("Integer"), {}, "", function()
                    if menu.get_value(STAT_READER_NAME) == "" then
                        NOTIFY(TRANSLATE("You didn't specify the value. Please specify it!"))
                    else
                        NOTIFY(TRANSLATE("Successfully read!") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. ADD_MP_INDEX(menu.get_value(STAT_READER_NAME)) .. "\n" .. TRANSLATE("Stat Value") .. ": " .. STAT_GET_INT(menu.get_value(STAT_READER_NAME)))
                        if menu.get_value(IS_READER_COPY) then
                            util.copy_to_clipboard(STAT_GET_INT(menu.get_value(STAT_READER_NAME)))
                        end
                    end
                end)

                menu.action(STAT_READER, TRANSLATE("Float"), {}, "", function()
                    if menu.get_value(STAT_READER_NAME) == "" then
                        NOTIFY(TRANSLATE("You didn't specify the value. Please specify it!"))
                    else
                        NOTIFY(TRANSLATE("Successfully read!") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. ADD_MP_INDEX(menu.get_value(STAT_READER_NAME)) .. "\n" .. TRANSLATE("Stat Value") .. ": " .. STAT_GET_FLOAT(menu.get_value(STAT_READER_NAME)))
                        if menu.get_value(IS_READER_COPY) then
                            util.copy_to_clipboard(STAT_GET_FLOAT(menu.get_value(STAT_READER_NAME)))
                        end
                    end
                end)

                menu.action(STAT_READER, TRANSLATE("Bool"), {}, "", function()
                    if menu.get_value(STAT_READER_NAME) == "" then
                        NOTIFY(TRANSLATE("You didn't specify the value. Please specify it!"))
                    else
                        NOTIFY(TRANSLATE("Successfully read!") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. ADD_MP_INDEX(menu.get_value(STAT_READER_NAME)) .. "\n" .. TRANSLATE("Stat Value") .. ": " .. STAT_GET_BOOL(menu.get_value(STAT_READER_NAME)))
                        if menu.get_value(IS_READER_COPY) then
                            util.copy_to_clipboard(STAT_GET_BOOL(menu.get_value(STAT_READER_NAME)))
                        end
                    end
                end)

                menu.action(STAT_READER, TRANSLATE("String"), {}, "", function()
                    if menu.get_value(STAT_READER_NAME) == "" then
                        NOTIFY(TRANSLATE("You didn't specify the value. Please specify it!"))
                    else
                        NOTIFY(TRANSLATE("Successfully read!") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. ADD_MP_INDEX(menu.get_value(STAT_READER_NAME)) .. "\n" .. TRANSLATE("Stat Value") .. ": " .. STAT_GET_STRING(menu.get_value(STAT_READER_NAME)))
                        if menu.get_value(IS_READER_COPY) then
                            util.copy_to_clipboard(STAT_GET_STRING(menu.get_value(STAT_READER_NAME)))
                        end
                    end
                end)

                menu.action(STAT_READER, TRANSLATE("Date"), {}, "", function()
                    if menu.get_value(STAT_READER_NAME) == "" then
                        NOTIFY(TRANSLATE("You didn't specify the value. Please specify it!"))
                    else
                        NOTIFY(TRANSLATE("Successfully read!") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. ADD_MP_INDEX(menu.get_value(STAT_READER_NAME)) .. "\n" .. TRANSLATE("Year: ") .. STAT_GET_DATE(menu.get_value(STAT_READER_NAME), "Year") .. "\n" .. TRANSLATE("Month: ") .. STAT_GET_DATE(menu.get_value(STAT_READER_NAME), "Month") .. "\n" .. TRANSLATE("Day: ") .. STAT_GET_DATE(menu.get_value(STAT_READER_NAME), "Days") .. "\n" .. TRANSLATE("Hour: ") .. STAT_GET_DATE(menu.get_value(STAT_READER_NAME), "Hours") .. "\n" .. TRANSLATE("Min: ") .. STAT_GET_DATE(menu.get_value(STAT_READER_NAME), "Mins"))
                        if menu.get_value(IS_READER_COPY) then
                            util.copy_to_clipboard("Year: " .. STAT_GET_DATE(menu.get_value(STAT_READER_NAME), "Year") .. "\n" .. TRANSLATE("Month: ") .. STAT_GET_DATE(menu.get_value(STAT_READER_NAME), "Month") .. "\n" .. TRANSLATE("Day: ") .. STAT_GET_DATE(menu.get_value(STAT_READER_NAME), "Days") .. "\n" .. TRANSLATE("Hour: ") .. STAT_GET_DATE(menu.get_value(STAT_READER_NAME), "Hours") .. "\n" .. TRANSLATE("Min: ") .. STAT_GET_DATE(menu.get_value(STAT_READER_NAME), "Mins"))
                        end
                    end
                end)

            ---

        ---
        
    ---

    local TOOLS_OTH = menu.list(TOOLS, TRANSLATE("Others"), {}, "", function(); end)

        menu.toggle_loop(TOOLS_OTH, TRANSLATE("Auto Collect Targets"), {"hcautocollect"}, TRANSLATE("Collects targets via clicking left mouse button. Note that there are some delays before disabling completely."), function()
            PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 237, 1)
            util.yield(50)
        end)

        menu.action(TOOLS_OTH, TRANSLATE("Motion Skip"), {}, TRANSLATE("a.k.a Pause Menu Glitch"), function()
            TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
        end)

        menu.action_slider(TOOLS_OTH, TRANSLATE("Skips Conversation With NPCs"), {}, "", {
            TRANSLATE("All"),
            TRANSLATE("One Line"),
        }, function(Index)
            if AUDIO.IS_SCRIPTED_CONVERSATION_ONGOING() then
                if Index == 1 then
                    AUDIO.STOP_SCRIPTED_CONVERSATION(false)
                elseif Index == 2 then
                    AUDIO.SKIP_TO_NEXT_SCRIPTED_CONVERSATION_LINE()
                end
            end
        end)
        
    ---

---


--- Setting & About HC

    menu.divider(INFOS, TRANSLATE("Language"))

        HC_LANG = menu.list_action(INFOS, TRANSLATE("Language Setting") .. ": " .. READ_SETTING("Language"), {"hclang"}, "", {
            { "Custom", {"custom"} },
            { "Chinese - 中文", {"chinese"} },
            { "English", {"english"} },
            { "French - français", {"french"} },
            { "German - Deutsch", {"german"} },
            { "Japanese - 日本語", {"japanese"} },
            { "Korean - 한국어", {"korean"} },
            { "Portuguese - Português", {"portuguese"}},
            { "Russian - русский", {"russian"} },
            { "Spanish - Español", {"spanish"} },
            -- { "Turkish - Türkçe", {"turkish"} },
        }, function(Index, Name)
            menu.show_warning(HC_LANG, CLICK_MENU, TRANSLATE("Would you like to restart HC now?"), function()
                WRITE_SETTING("Language", Name)
                util.restart_script()
            end)
        end)

        --- Still not perfectly working, coding in progress... Already spent over 20 hours for this feature, though... huh

        -- HC_LANG_GEN = menu.list(INFOS, TRANSLATE("Generate Translation Template"), {}, "", function(); end)

        --     function DIR_TO_LANG_FILE_NAME(Path)
        --         local _, i = string.find(Path, "Language\\")
        --         local j, _ = string.find(Path, ".txt")
        --         local Dir = string.sub(Path, i + 1, j - 1)
        --         return Dir
        --     end

        --     menu.divider(HC_LANG_GEN, TRANSLATE("Generate New Translation File"))

        --         TRANS_FILE_NAME = menu.text_input(HC_LANG_GEN, TRANSLATE("Name of The File"), {"hcgennewtrans"}, TRANSLATE("HC will overwrite if name of the file already exists."), function(); end)

        --         menu.action(HC_LANG_GEN, TRANSLATE("Generate New Translation File"), {}, "", function()
        --             local Name = menu.get_value(TRANS_FILE_NAME)
        --             if Name == "" then
        --                 NOTIFY(TRANSLATE("Please input name of the file!"))
        --                 return
        --             end

        --             menu.trigger_commands("hcupdatetransenglish")
        --             NOTIFY(TRANSLATE("Waiting for updating English.txt..."))
        --             util.yield(3000)

        --             local File = Name .. ".txt"
        --             io.copyto(LangFolderDir .. "English.txt", LangFolderDir .. File)

        --             NOTIFY(
        --                 File .. ": " .. TRANSLATE("Sucessfully Generated!") .. "\n\n" .. 
        --                 TRANSLATE("Directory of the file: %AppData%\\Stand\\Lua Scripts\\store\\Heist Control\\Language\\") .. File
        --             )
        --         end)

        --     ---

        --     menu.divider(HC_LANG_GEN, TRANSLATE("Update Translation File"))

        --         UPDATE_FILE_LIST = menu.list(HC_LANG_GEN, TRANSLATE("Update Translation File"), {}, "", function(); end)

        --             menu.divider(UPDATE_FILE_LIST, TRANSLATE("Tools"))

        --                 menu.action(UPDATE_FILE_LIST, TRANSLATE("Refresh"), {}, TRANSLATE("Refresh the list via restarting Heist Control."), function()
        --                     util.restart_script()
        --                 end)

        --             ---
                    
        --             menu.divider(UPDATE_FILE_LIST, TRANSLATE("Update Translation File"))

        --                 for _, path in ipairs(filesystem.list_files(LangFolderDir)) do
        --                     menu.action(UPDATE_FILE_LIST, DIR_TO_LANG_FILE_NAME(path), {"hcupdatetrans" .. DIR_TO_LANG_FILE_NAME(path)}, "", function()
        --                         local Dir = filesystem.scripts_dir() .. SCRIPT_FILENAME
        --                         local open = io.open(Dir, "r")
        --                         local CodeTable = {}
        --                         for i in open:lines() do
        --                             table.insert(CodeTable, i)
        --                         end
        --                         open:close()
                            
                            
        --                         local GeneratedCodeTable = {}
        --                         local StartPos = 1
        --                         for _, trans in pairs(CodeTable) do
        --                             while trans:find("TRANSLATE", StartPos) ~= nil do
        --                                 local CodeBlackListedTexts = {
        --                                     "TRANSLATE(Text)",
        --                                     '"TRANSLATE", start',
        --                                 }
        --                                 for _, Text in pairs(CodeBlackListedTexts) do
        --                                     if trans:find(Text) then 
        --                                         goto outofcodeloop
        --                                     end
        --                                 end
                            
        --                                 local _, i = trans:find("TRANSLATE", StartPos)
        --                                 local _, j = trans:find('")', StartPos)
        --                                 if i and j ~= nil then
        --                                     local Text = string.sub(trans, i + 3, j - 2)
        --                                     for _, DuplicatedText in pairs(GeneratedCodeTable) do
        --                                         if Text == DuplicatedText then 
        --                                             goto outofcodeloop 
        --                                         end
        --                                     end
                            
        --                                     GeneratedCodeTable[#GeneratedCodeTable+1] = Text
        --                                     StartPos = j + 1
        --                                 else
        --                                     goto outofcodeloop
        --                                 end
        --                             end
                                    
        --                             ::outofcodeloop::
        --                             StartPos = 1 
        --                         end

                            

        --                         local open = io.open(path, "r")
        --                         local TransTable = {}
        --                         for i in open:lines() do
        --                             table.insert(TransTable, i)
        --                         end
        --                         open:close()

        --                         local GeneratedTransTable = {}
        --                         for i = 1, #TransTable do
        --                             GeneratedTransTable[#GeneratedTransTable+1] = { "", "" } -- english_translation, local_language_ranslation
        --                         end

        --                         local TransBlackListedTexts = {
        --                             "#",
        --                         }
        --                         for idx, trans in pairs(TransTable) do
        --                             if trans:find(" = ") ~= nil then
        --                                 for _, Text in pairs(TransBlackListedTexts) do
        --                                     if trans:find(Text) or
        --                                        trans == ""      or
        --                                        trans == " "     then
                                                
        --                                        goto outoftransloop
        --                                     end
        --                                 end
                            
        --                                 local i = trans:find(" = ")
        --                                 local Text = string.sub(trans, 0, i - 1)
        --                                 if Text ~= "" then
        --                                     GeneratedTransTable[idx][1] = Text
        --                                 end

        --                                 local _, i = trans:find(" = ")
        --                                 local Text = string.sub(trans, i + 1, string.len(trans))
        --                                 if Text ~= "" then
        --                                     GeneratedTransTable[idx][2] = Text
        --                                 end
        --                             end
                            
        --                             ::outoftransloop::
        --                         end

                        
                            
        --                         local ExistsTrans = {} -- In the Lua: Exists, In the translation: Exists
        --                         local NotExistTrans = {} -- In the Lua: Exists, In the translation: Not Exist
        --                         local NumberOfExistsTrans = 0
        --                         local NumberOfNotExistTrans = 0
        --                         for _, code in pairs(GeneratedCodeTable) do
        --                             for idx, _ in pairs(GeneratedTransTable) do
        --                                 local Translation = code .. " = " ..  code
        --                                 local Test = false
        --                                 if code == GeneratedTransTable[idx][1] then
        --                                     Translation = GeneratedTransTable[idx][1] .. " = " .. GeneratedTransTable[idx][2]
        --                                     ExistsTrans[#ExistsTrans+1] = Translation
        --                                     Test = true
        --                                     NumberOfExistsTrans = NumberOfExistsTrans + 1
        --                                 end

        --                                 if not Test then
        --                                     NotExistTrans[#NotExistTrans+1] = Translation
        --                                     NumberOfNotExistTrans = NumberOfNotExistTrans + 1
        --                                 end
        --                             end
        --                         end


        --                         local FinalTrans = {}
        --                         local ExistsNoteTrans = { -- "" = Blank, means '\n'
        --                             "# DON'T REMOVE '#', OTHERWISE WILL CAUSE ERRORS!",
        --                             "",
        --                             "# Generated Date: " .. os.date("%Y") .. "/" .. os.date("%m") .. "/" .. os.date("%d") .. " " .. os.date("%I") .. ":" .. os.date("%M") .. ":" .. os.date("%S") .. " " .. os.date("%p"),
        --                             "# Heist Control Version: " .. tostring(HCVersion),
        --                             "",
        --                             "# Thank you for translating Heist Control!",
        --                             "# You should translate right-side of '=' character.",
        --                             "# You can use all characters except '=' character.",
        --                             "# Using '#' character means the line will be ignored.",
        --                             "# If you want to release your own translation officially, please contact to the developer of Heist Control in its Discord server.",
        --                             "# Learn more: https://icedoomfist.com/Stand_Heist_Control/How_To_Translate/",
        --                             "",
        --                             "",
        --                         }
        --                         for _, trans in pairs(ExistsNoteTrans) do
        --                             FinalTrans[#FinalTrans+1] = trans
        --                         end

        --                         for idx, trans in pairs(ExistsTrans) do
        --                             FinalTrans[#FinalTrans+1] = trans
        --                         end


        --                         local NotExistNoteTrans = {
        --                             "",
        --                             "",
        --                             "# Start of newly updated translations.",
        --                             "# Translate them!",
        --                             "",
        --                             "",
        --                         }
        --                         for _, trans in pairs(NotExistNoteTrans) do
        --                             FinalTrans[#FinalTrans+1] = trans
        --                         end

        --                         for _, trans in pairs(NotExistTrans) do
        --                             FinalTrans[#FinalTrans+1] = trans
        --                         end



        --                         local open = io.open(path, "w+")
        --                         open:write("")
        --                         open:close()

        --                         for _, trans in pairs(FinalTrans) do
        --                             local open = io.open(path, "a+")
        --                             open:write(trans .. "\n")
        --                             open:close()
        --                         end

        --                         NOTIFY(
        --                             DIR_TO_LANG_FILE_NAME(path) .. ".txt: " .. TRANSLATE("Sucessfully Updated!") .. "\n\n" ..
        --                             TRANSLATE("- Total number of translations: ") .. NumberOfExistsTrans + NumberOfNotExistTrans .. "\n\n" .. 
        --                             TRANSLATE("- Number of not modified translations: ") .. NumberOfExistsTrans .. "\n" .. 
        --                             TRANSLATE("- Number of modified (updated) translations: ") .. NumberOfNotExistTrans
        --                         )
        --                     end)
        --                 end

                    ---

                ---

            ---

        ---

        menu.hyperlink(INFOS, TRANSLATE("How To Translate"), "https://icedoomfist.com/Stand_Heist_Control/How_To_Translate", TRANSLATE("Always looking for translators for non-existing languages. If you're interested in translating HC, click!"))

    ---

    menu.divider(INFOS, TRANSLATE("Settings"))

        NOTIFICATION_SETTING = menu.list(INFOS, TRANSLATE("Notification") .. ": " .. READ_SETTING("Notification Sort"), {"hcnotification"}, "", function(); end)

            menu.divider(NOTIFICATION_SETTING, TRANSLATE("Notification's Style"))

                NOTIFICATION_ICON_SETTING = menu.list_action(NOTIFICATION_SETTING, TRANSLATE("Icon") .. ": " .. READ_SETTING("Notification Icon"), {}, "", {
                    { TRANSLATE("HC Logo") },
                    { TRANSLATE("Lester") },
                    { TRANSLATE("Legend Of Heist") }, 
                    { TRANSLATE("Skull Head") },
                    { TRANSLATE("Warstock") },
                    { TRANSLATE("Black R*") },
                    { TRANSLATE("R* Social Club") },
                }, function(Index)
                    WRITE_SETTING("Notification Icon", NotiIconSorts[Index][1])
                    WRITE_SETTING("Notification Sort", "In-Game")
                    menu.trigger_commands("clearnotifications")
                    NOTIFY(TRANSLATE("Successfully set!"))
                end)

                NOTIFICATION_COLOR_SETTING = menu.list_action(NOTIFICATION_SETTING, TRANSLATE("Background Color") .. ": " .. READ_SETTING("Notification Color"), {}, "", {
                    { TRANSLATE("White") },
                    { TRANSLATE("Black") },
                    { TRANSLATE("Red") },
                    { TRANSLATE("Orange") },
                    { TRANSLATE("Yellow") },
                    { TRANSLATE("Mint") },
                    { TRANSLATE("Green") },
                    { TRANSLATE("Light Blue") },
                }, function(Index)
                    WRITE_SETTING("Notification Color", NotiColorSorts[Index][1])
                    WRITE_SETTING("Notification Sort", "In-Game")
                    menu.trigger_commands("clearnotifications")
                    NOTIFY(TRANSLATE("Successfully set!"))
                end)

            ---

            menu.divider(NOTIFICATION_SETTING, TRANSLATE("Type"))

                menu.action(NOTIFICATION_SETTING, "Stand", {}, "", function()
                    WRITE_SETTING("Notification Sort", "Stand")            
                    NOTIFY(TRANSLATE("Successfully set!"))
                end)
                menu.action(NOTIFICATION_SETTING, TRANSLATE("In-Game"), {}, "", function()
                    WRITE_SETTING("Notification Sort", "In-Game")
                    NOTIFY(TRANSLATE("Successfully set!"))
                end)
                menu.action(NOTIFICATION_SETTING, TRANSLATE("No Notification"), {}, "", function()
                    WRITE_SETTING("Notification Sort", "No Notification")
                end)

            ---

        ---

        TIMER_SETTING = menu.list_action(INFOS, TRANSLATE("Heist Cooldown Timer") .. ": " .. READ_SETTING("Timer Color"), {"hctimercolor"}, "", {
            { TRANSLATE("Black") },
            { TRANSLATE("White") },
            { TRANSLATE("Red") },
            { TRANSLATE("Orange") },
            { TRANSLATE("Yellow") },
            { TRANSLATE("Mint") }, 
            { TRANSLATE("Green") },
            { TRANSLATE("Light Blue") },
        }, function(Index)
            if Index == 1 then
                WRITE_SETTING("Timer Color", "Black")
            elseif Index == 2 then
                WRITE_SETTING("Timer Color", "White")
            elseif Index == 3 then
                WRITE_SETTING("Timer Color", "Red")
            elseif Index == 4 then
                WRITE_SETTING("Timer Color", "Orange")
            elseif Index == 5 then
                WRITE_SETTING("Timer Color", "Yellow")
            elseif Index == 6 then
                WRITE_SETTING("Timer Color", "Mint")
            elseif Index == 7 then
                WRITE_SETTING("Timer Color", "Green")
            elseif Index == 8 then
                WRITE_SETTING("Timer Color", "Light Blue")
            end
        end)

        util.create_tick_handler(function() -- Refresh settings per tick for menu names
            if filesystem.exists(SettingDir) then
                menu.set_menu_name(NOTIFICATION_SETTING, TRANSLATE("Notification") .. ": " .. READ_SETTING("Notification Sort"))
                menu.set_menu_name(NOTIFICATION_ICON_SETTING, TRANSLATE("Icon") .. ": " .. READ_SETTING("Notification Icon"))
                menu.set_menu_name(NOTIFICATION_COLOR_SETTING, TRANSLATE("Background Color") .. ": " .. READ_SETTING("Notification Color"))
                menu.set_menu_name(TIMER_SETTING, TRANSLATE("Heist Cooldown Timer") .. ": " .. READ_SETTING("Timer Color"))
                util.yield(500)
            end
        end)

    ---

    menu.divider(INFOS, TRANSLATE("About HC"))

        local CREDITS = menu.list(INFOS, TRANSLATE("Credits"), {"hccredit"}, "", function(); end)

            menu.divider(CREDITS, "jhowkNX")

                menu.hyperlink(CREDITS, "jhowkNx", "https://github.com/jhowkNx", TRANSLATE("Heist Control for 2Take1 Developer. He allowed me to use his code. HC wouldn't exist without his help. Serious thanks to him!"))

            ---

            menu.divider(CREDITS, TRANSLATE("Heist Control"))

                menu.action(CREDITS, "Nowiri", {}, TRANSLATE("Creator of WiriScript which helped me code HC!"), function(); end)
                menu.action(CREDITS, "Baloo", {}, TRANSLATE("Helped me with a lot of things for HC website's maintenance."), function();end)
                menu.action(CREDITS, "Zetax", {}, TRANSLATE("Helped me code the website's design."), function(); end)
                menu.action(CREDITS, "Aji", {}, TRANSLATE("Made the logo, banner and other images for HC."), function(); end)
                menu.hyperlink(CREDITS, "UnknownCheats", "https://www.unknowncheats.me/forum/grand-theft-auto-v/", TRANSLATE("Let me know about stats info."))

            ---

            menu.divider(CREDITS, TRANSLATE("Translators"))

                menu.action(CREDITS, "Qiusha", {}, TRANSLATE("Maintains HC's translation") .. ": Chinese - 中文", function(); end)
                menu.action(CREDITS, "Leif.Erickson", {}, TRANSLATE("Maintains HC's translation") .. ": French - français", function(); end)
                menu.action(CREDITS, "Hibanana", {}, TRANSLATE("Maintains HC's translation") .. ": German - Deutsch", function(); end)
                menu.action(CREDITS, "Greensky445", {}, TRANSLATE("Maintains HC's translation") .. ": Japanese - 日本語", function(); end)
                menu.action(CREDITS, "IceDoomfist", {}, TRANSLATE("Maintains HC's translation") .. ": Korean - 한국어", function(); end)
                menu.action(CREDITS, "Pedro9558", {}, TRANSLATE("Maintains HC's translation") .. ": Portuguese - Português", function(); end)
                menu.action(CREDITS, "Sega", {}, TRANSLATE("Maintains HC's translation") .. ": Russian - русский", function(); end)
                menu.action(CREDITS, "zigmazero", {}, TRANSLATE("Maintains HC's translation") .. ": Spanish - Español", function(); end)
                -- menu.action(CREDITS, "Emre", {}, TRANSLATE("Maintains HC's translation") .. ": Turkish - Türkçe", function(); end)

            ---

        ---

        menu.hyperlink(INFOS, TRANSLATE("Join Discord Server!"), "https://icedoomfist.com/Link/HC_Discord", TRANSLATE("Get Support, Report Bugs and Enjoy Other Stuffs!"))
        menu.hyperlink(INFOS, TRANSLATE("Youtube"), "https://icedoomfist.com/Link/HC_Youtube", TRANSLATE("Videos related to HC's tutorial are uploaded here, subscribe to the channel to show your support :D"))
        menu.hyperlink(INFOS, TRANSLATE("Tutorial"), "https://icedoomfist.com/Stand_Heist_Control/Tutorial", TRANSLATE("If you don't know how to use HC, click me!"))
        menu.hyperlink(INFOS, TRANSLATE("Changelog"), "https://icedoomfist.com/Stand_Heist_Control/Changelog", TRANSLATE("If you want to know what was changed in the latest version, click me!"))

    ---

---