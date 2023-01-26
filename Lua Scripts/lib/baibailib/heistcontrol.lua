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

        local HCVersion = "V 3.0.6"
        local BasedGTAO = 1.61

    ---

    --- Directory Settings

        local HCFolderDir = filesystem.scripts_dir() .. "/baibaiScript/"..'/Heist Control/'

        local ImgFolderDir = HCFolderDir .. "Image\\"
        local SettingFolderDir = HCFolderDir .. "Setting\\"
        local LangFolderDir = HCFolderDir .. "Language\\"

        local SettingDir = SettingFolderDir .. "Setting.txt"
        local LogDir = SettingFolderDir .. "Log.txt"

        local CustomDir = LangFolderDir .. "Custom.txt"
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

        function MP_INDEX()
            return "MP" .. util.get_char_slot() .. "_"
        end
        function IS_MPPLY(Stat)
            local Stats = {
                "MP_PLAYING_TIME",
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
                Stat = MP_INDEX() .. Stat
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

        function STAT_SET_PACKED_BOOL(Stat, Value)
            STATS._SET_PACKED_STAT_BOOL(Stat, Value, util.get_char_slot())
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
            elseif Sort == "Day" then
                Add = 16
            elseif Sort == "Hour" then
                Add = 24
            elseif Sort == "Min" then
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

    --- Files & Folders

        util.require_natives("natives-1660775568")

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
            CustomDir,
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
                        ERROR_LOG(TO_LANG_NAME(TranslationDirs[i]) .. " HC的语言文件不存在." .. "\n\n" .. "如何修复:重新安装!")
                    end
                end
            end
        end

        LOAD_LANG(EnglishDir)
        
        if READ_SETTING("Language") == "Custom" then
            LOAD_LANG(CustomDir)
        elseif READ_SETTING("Language") == "Chinese - 中文" then
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

        function SHOW_IMG(ImgName, MaxPassedTime) -- Credit goes to LanceScript
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

        function IsWorking(IsAddNewLine)
            local State = "" -- If global and local variables have been changed due to the GTAO update then 
            if util.is_session_started() then
                if GET_INT_LOCAL("freemode", 3504) ~= util.joaat("lr_prop_carkey_fob") then -- freemode.c, joaat("lr_prop_carkey_fob")
                    State = "[NOT WORKING]"
                    if IsAddNewLine then
                        State = State .. "\n\n"
                    end
                end
            end
            return State
        end

        function RGB(R, G, B, A) -- Credit goes to LanceScript
            local Color = {}
            Color.r = R
            Color.g = G
            Color.b = B
            Color.a = A
            return Color
        end

        function HelpMsgBeingDisplayed(Label) -- Credit goes to jerry123#4508
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
            PAD._SET_CONTROL_NORMAL(0, 244, 1)
            util.yield(200)
        end
        function IA_MENU_UP(Num)
            for i = 1, Num do
                PAD._SET_CONTROL_NORMAL(0, 172, 1)
                util.yield(200)
            end
        end
        function IA_MENU_DOWN(Num)
            for i = 1, Num do
                PAD._SET_CONTROL_NORMAL(0, 173, 1)
                util.yield(200)
            end
        end
        function IA_MENU_ENTER(Num)
            for i = 1, Num do
                PAD._SET_CONTROL_NORMAL(0, 176, 1)
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
                ERROR_LOG("游戏内通知的HC Logo不存在." .. "\n\n" .. "如何修复:重新安装")
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
                    HUD._THEFEED_SET_NEXT_POST_BACKGROUND_COLOR(NotiColor)
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


    ---

    --- Announcement

        if SCRIPT_MANUAL_START then
            async_http.init("icedoomfist.com", "/Stand_Heist_Control/Announcement/", function(Sucess)
                if Sucess ~= "" then
                    NOTIFY("[ " .. TRANSLATE("Announcement") .. " ]" .. "\n\n" .. Sucess)
                end
            end)
    
            async_http.dispatch()
        end

    ---

---


    Heist_Control = menu.list(menu.my_root(), "任务选项", {""}, "预设传送")
    menu.divider(Heist_Control, TRANSLATE("抢劫控制") .. " " .. HCVersion)

        local PERICO_HEIST = menu.list(Heist_Control, TRANSLATE("佩岛抢劫"), {"hccp"}, "", function();  end)
        local CASINO_HEIST = menu.list(Heist_Control, TRANSLATE("赌场抢劫"), {"hccah"}, "", function(); end)
        local DOOMS_HEIST = menu.list(Heist_Control, TRANSLATE("末日抢劫"), {"hcdooms"}, "", function(); end)
        local CLASSIC_HEISTS = menu.list(Heist_Control, TRANSLATE("公寓抢劫"), {"hcclassic"}, "", function(); end)
        local LS_ROBBERY = menu.list(Heist_Control, TRANSLATE("改装铺合约"), {"hcls"}, "", function(); end)
        local ULP_MISSIONS = menu.list(Heist_Control, "ULP任务", {"hculp"}, "", function(); end)
        local TH_CONTRACT = menu.list(Heist_Control, TRANSLATE("合约任务"), {"hcagc"}, "", function(); end)
        local MASTER_UNLOCKR = menu.list(Heist_Control, TRANSLATE("解锁大师"), {"hcmu"}, "", function(); end)
        local TOOLS = menu.list(Heist_Control, TRANSLATE("工具选项"), {"hctool"}, "", function(); end)
        local INFOS = menu.list(Heist_Control, TRANSLATE("设置&关于HC"), {"hcinfo"}, "", function(); end)

    ---

---


--- Cayo Perico Heist
    
    local CAYO_AUTO_PRST = menu.list(PERICO_HEIST, TRANSLATE("自动预设"), {}, TRANSLATE("- 请在虎鲸外或主甲板板选择预设") .. "\n\n" .. TRANSLATE("- 任务结束时取消预设."), function(); end)

        local AUTOMATED_SOLO = menu.list(CAYO_AUTO_PRST, TRANSLATE("1 玩家"), {}, "", function(); end)

            menu.toggle_loop(AUTOMATED_SOLO, TRANSLATE("猎豹雕像"), {"hccp1psp"}, IsWorking(false), function()
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

            menu.toggle_loop(AUTOMATED_SOLO, TRANSLATE("红宝石项链"), {"hccp1prn"}, IsWorking(false), function()
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

        local AUTOMATED_2P = menu.list(CAYO_AUTO_PRST, TRANSLATE("2 玩家"), {}, "", function(); end)

            menu.toggle_loop(AUTOMATED_2P, TRANSLATE("猎豹雕像"), {"hccp2psp"}, IsWorking(false), function()   
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

            menu.toggle_loop(AUTOMATED_2P, TRANSLATE("红宝石项链"), {"hccp2prn"}, IsWorking(false), function()  
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

        local AUTOMATED_3P = menu.list(CAYO_AUTO_PRST, TRANSLATE("3 玩家"), {}, "", function(); end)

            menu.toggle_loop(AUTOMATED_3P, TRANSLATE("猎豹雕像"), {"hccp3psp"}, IsWorking(false), function()
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

            menu.toggle_loop(AUTOMATED_3P, TRANSLATE("红宝石项链"), {"hccp3prn"}, IsWorking(false), function()
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

        local AUTOMATED_4P = menu.list(CAYO_AUTO_PRST, TRANSLATE("4 玩家"), {}, "", function(); end)

            menu.toggle_loop(AUTOMATED_4P, TRANSLATE("猎豹雕像"), {"hccp4psp"}, IsWorking(false), function()
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

            menu.toggle_loop(AUTOMATED_4P, TRANSLATE("红宝石项链"), {"hccp4prn"}, IsWorking(false), function()
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
        menu.toggle(CAYO_AUTO_PRST, TRANSLATE("快速预设 [1~4人]"), {"hccpquick"}, IsWorking(false), function(Toggle)
            quickcp = Toggle

            if quickcp then
                NOTIFY(TRANSLATE("没有次要目标,只有主要目标.你的目标是得到它.") .. "\n\n" .. TRANSLATE("保持激活状态直到抢劫结束"))
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
                    SET_INT_GLOBAL(262145 + 29975, 2090000) -- 266828370
                else
                    SET_INT_GLOBAL(262145 + 29975, 2455000)
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

    local STANDARD_SET = menu.list(PERICO_HEIST, TRANSLATE("标准预设"), {}, TRANSLATE("- 请在虎鲸外或主甲板板选择预设") .. "\n\n" .. TRANSLATE("- 任务结束时取消预设."), function(); end)

        menu.action(STANDARD_SET, TRANSLATE("正常原始预设"), {"hccporigin"}, "", function()
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

    local TELEPORT_CP = menu.list(PERICO_HEIST, TRANSLATE("自定义传送"), {}, "", function(); end)

        local CAYO_TELE_COMPOUND = menu.list(TELEPORT_CP, TRANSLATE("入口点"), {}, "", function(); end)

            local CAYO_TELE_STORAGE = menu.list(CAYO_TELE_COMPOUND, TRANSLATE("庄园"), {}, "", function(); end)

                menu.action(CAYO_TELE_STORAGE, TRANSLATE("北"), {}, "", function()
                    TELEPORT(5081.0415, -5755.32, 15.829645)
                end)
                menu.action(CAYO_TELE_STORAGE, TRANSLATE("西"), {}, "", function()
                    TELEPORT(5006.722, -5786.5967, 17.831688)
                end)
                menu.action(CAYO_TELE_STORAGE, TRANSLATE("南"), {}, "", function()
                    TELEPORT(5027.603, -5734.682, 17.255005)
                end)

            ---

            local CAYO_TELE_VAULT = menu.list(CAYO_TELE_COMPOUND, TRANSLATE("保险库"), {}, "", function(); end)

                CAYO_TELE_VAULT_PRIMARY = menu.action(CAYO_TELE_VAULT, TRANSLATE("主要目标"), {}, "", function()
                    TELEPORT(5006.7, -5756.2, 14.8)
                    SET_HEADING(145)
                end)
                menu.action(CAYO_TELE_VAULT, TRANSLATE("次要目标"), {}, "", function()
                    TELEPORT(4999.764160, -5749.863770, 14.840000)
                end)

            ---

            menu.action(CAYO_TELE_COMPOUND, TRANSLATE("胡安办公室"), {}, "", function()
                TELEPORT(5010.12, -5750.1353, 28.84334)
                SET_HEADING(325)
            end)
            menu.action(CAYO_TELE_COMPOUND, TRANSLATE("前门出口"), {}, "", function()
                TELEPORT(4990.0386, -5717.6895, 19.880217)
                SET_HEADING(50)
            end)

        ---

        local CAYO_TELE_ISLAND = menu.list(TELEPORT_CP, TRANSLATE("佩里科岛"), {}, "", function(); end)

            local CAYO_TELE_AIRSTRIP = menu.list(CAYO_TELE_ISLAND, TRANSLATE("飞机跑道"), {}, "", function(); end)

                menu.action(CAYO_TELE_AIRSTRIP, TRANSLATE("战利品") .. " - #1", {}, "", function()
                    TELEPORT(4503.587402, -4555.740723, 2.854459)
                end)
                menu.action(CAYO_TELE_AIRSTRIP, TRANSLATE("战利品") .. " - #2", {}, "", function()
                    TELEPORT(4437.821777, -4447.841309, 3.028436)
                end)
                menu.action(CAYO_TELE_AIRSTRIP, TRANSLATE("战利品") .. " - #3", {}, "", function()
                    TELEPORT(4447.091797, -4442.184082, 5.936794)
                end)

            ---

            local CAYO_TELE_CROP_FIELDS = menu.list(CAYO_TELE_ISLAND, TRANSLATE("大麻地"), {}, "", function(); end)

                menu.action(CAYO_TELE_CROP_FIELDS, TRANSLATE("战利品") .. " - #1", {}, "", function()
                    TELEPORT(5330.527, -5269.7515, 33.18603)
                end)

            ---

            local CAYO_TELE_MAIN_DOCK = menu.list(CAYO_TELE_ISLAND, TRANSLATE("主码头"), {}, "", function(); end)

                menu.action(CAYO_TELE_MAIN_DOCK, TRANSLATE("战利品") .. " - #1", {}, "", function()
                    TELEPORT(5193.909668, -5135.642578, 2.045917)
                end)
                menu.action(CAYO_TELE_MAIN_DOCK, TRANSLATE("战利品") .. " - #2", {}, "", function()
                    TELEPORT(4963.184570, -5108.933105, 1.670808)
                end)
                menu.action(CAYO_TELE_MAIN_DOCK, TRANSLATE("战利品") .. " - #3", {}, "", function()
                    TELEPORT(4998.709473, -5165.559570, 1.464137)
                end)
                menu.action(CAYO_TELE_MAIN_DOCK, TRANSLATE("战利品") .. " - #4", {}, "", function()
                    TELEPORT(4924.693359, -5243.244629, 1.223599)
                end)

            ---

            local CAYO_TELE_NORTH_DOCK = menu.list(CAYO_TELE_ISLAND, TRANSLATE("北码头"), {}, "", function(); end)

                menu.action(CAYO_TELE_NORTH_DOCK, TRANSLATE("战利品") .. " - #1", {}, "", function()
                    TELEPORT(5132.558594, -4612.922852, 1.162808)
                end)
                menu.action(CAYO_TELE_NORTH_DOCK, TRANSLATE("战利品") .. " - #2", {}, "", function()
                    TELEPORT(5065.255371, -4591.706543, 1.555012)
                end)
                menu.action(CAYO_TELE_NORTH_DOCK, TRANSLATE("战利品") .. " - #3", {}, "", function()
                    TELEPORT(5090.916016, -4682.670898, 1.107098)
                end)

            ---

                menu.action(CAYO_TELE_ISLAND, TRANSLATE("无线电塔"), {}, "", function()
                    TELEPORT(5263.7124, -5407.5835, 65.24931)
                end)
                CAYO_TELE_ISLAND_DRAINGE_1ST = menu.action(CAYO_TELE_ISLAND, TRANSLATE("排水渠"), {}, "", function()
                    TELEPORT(5044.001, -5815.6426, -11.808871)
                end)
                CAYO_TELE_ISLAND_DRAINGE_2ND = menu.action(CAYO_TELE_ISLAND, TRANSLATE("排水渠:检查点2"), {}, "", function()
                    TELEPORT(5053.773, -5773.2266, -5.40778)
                end)
                menu.action(CAYO_TELE_ISLAND, TRANSLATE("海洋撤离点"), {}, "", function()
                    TELEPORT(4771.479, -6165.737, -39.079613)
                end)

            ---

        ---

        menu.action(TELEPORT_CP, TRANSLATE("虎鲸:抢劫面板[首先呼出虎鲸]"), {"hctpsub"}, "", function()
            if STAT_GET_INT("IH_SUB_OWNED") == 0 then
                NOTIFY(TRANSLATE("你还没有购买虎鲸.先买了它才能传送!"))
            else
                TELEPORT(1561.2369, 385.8771, -49.689915)
                SET_HEADING(175)
            end
        end)

    ---

    local PERICO_ADV = menu.list(PERICO_HEIST, TRANSLATE("高级功能"), {}, "", function(); end)

        local HSCUT_CP = menu.list(PERICO_ADV, TRANSLATE("玩家分红"), {}, "", function(); end)

            local PERICO_HOST_CUT = menu.list(HSCUT_CP, TRANSLATE("你的分红"), {}, "", function(); end)

                CP_HOST_CUT_LOOP = menu.toggle_loop(PERICO_HOST_CUT, TRANSLATE("启用"), {"hccphostcutloop"}, IsWorking(false), function()
                    SET_INT_GLOBAL(1973321 + 823 + 56 + 1, menu.get_value(CP_HOST_CUT)) -- heist_island_planning.c
                end, function()
                    SET_INT_GLOBAL(1973321 + 823 + 56 + 1, 100)
                end)

                CP_HOST_CUT = menu.slider(PERICO_HOST_CUT, TRANSLATE("自定义分红"), {"hccphostcut"}, "(%)", 0, 1000, 100, 5, function(); end)

            ---

            local PERICO_P2_CUT = menu.list(HSCUT_CP, TRANSLATE("玩家 2"), {}, "", function(); end)

                CP_2P_CUT_LOOP = menu.toggle_loop(PERICO_P2_CUT, TRANSLATE("启用"), {"hccp2pcutloop"}, IsWorking(false), function()
                    SET_INT_GLOBAL(1973321 + 823 + 56 + 2, menu.get_value(CP_2P_CUT)) -- heist_island_planning.c
                end, function()
                    SET_INT_GLOBAL(1973321 + 823 + 56 + 2, 100)
                end)

                CP_2P_CUT = menu.slider(PERICO_P2_CUT, TRANSLATE("自定义分红"), {"hccp2pcut"}, "(%)", 0, 1000, 100, 5, function(); end)
            
            ---
            
            local PERICO_P3_CUT = menu.list(HSCUT_CP, TRANSLATE("玩家 3"), {}, "", function(); end)

                CP_3P_CUT_LOOP = menu.toggle_loop(PERICO_P3_CUT, TRANSLATE("启用"), {"hccp3pcutloop"}, IsWorking(false), function()
                    SET_INT_GLOBAL(1973321 + 823 + 56 + 3, menu.get_value(CP_3P_CUT)) -- heist_island_planning.c
                end, function()
                    SET_INT_GLOBAL(1973321 + 823 + 56 + 3, 100)
                end)

                CP_3P_CUT = menu.slider(PERICO_P3_CUT, TRANSLATE("自定义分红"), {"hccp3pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

            ---

            local PERICO_P4_CUT = menu.list(HSCUT_CP, TRANSLATE("玩家 4"), {}, "", function(); end)

                CP_4P_CUT_LOOP = menu.toggle_loop(PERICO_P4_CUT, TRANSLATE("启用"), {"hccp4pcutloop"}, IsWorking(false), function()
                    SET_INT_GLOBAL(1973321 + 823 + 56 + 4, menu.get_value(CP_4P_CUT)) -- heist_island_planning.c
                end, function()
                    SET_INT_GLOBAL(1973321 + 823 + 56 + 4, 100)
                end)

                CP_4P_CUT = menu.slider(PERICO_P4_CUT, TRANSLATE("自定义分红"), {"hccp4pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

            ---
            
            menu.toggle_loop(HSCUT_CP, TRANSLATE("所有人设置为100%"), {"hccpcutall100"}, IsWorking(false), function()
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

        menu.list_action(PERICO_ADV, TRANSLATE("背包容量修改"), {"hccpbag"}, IsWorking(true) .. TRANSLATE("[Locally]"), {
            { TRANSLATE("正常背包容量"), {"1p"} },
            { TRANSLATE("模拟2名玩家的背包"), {"2p"} },
            { TRANSLATE("模拟3名玩家的背包"), {"3p"} },
            { TRANSLATE("模拟4名玩家的背包"), {"4p"} },
            { TRANSLATE("无限背包容量"), {"inf"} },
        }, function(Index)
            if Index ~= 5 then
                SET_INT_GLOBAL(262145 + 29720, 1800 * Index) -- 1859395035
            else
                SET_INT_GLOBAL(262145 + 29720, 99999)
            end
        end)

        menu.toggle_loop(PERICO_ADV, TRANSLATE("跳过黑入"), {}, IsWorking(false), function() 
            if GET_INT_LOCAL("fm_mission_controller_2020", 23385) == 4 then -- Locals from https://www.unknowncheats.me/forum/3418914-post13398.html, Values from Heist Control for Nightfall
                SET_INT_LOCAL("fm_mission_controller_2020", 23385, 5)
            end
        end)

        menu.toggle_loop(PERICO_ADV, TRANSLATE("跳过排水渠切割机"), {}, IsWorking(true) .. "与佩里科岛配合使用 > 自定义传送 > 佩里科岛 > 排水渠!", function() 
            if HelpMsgBeingDisplayed("UT_WELD_PROMPT") then -- "~s~Press ~INPUT_CONTEXT~ to cut through the grill."
                PAD._SET_CONTROL_NORMAL(2, 51, 1)
            elseif GET_INT_LOCAL("fm_mission_controller_2020", 27500) == 4 then -- Local from https://www.unknowncheats.me/forum/3389282-post1.html  
                SET_INT_LOCAL("fm_mission_controller_2020", 27500, 6)
            end
        end)

        menu.toggle_loop(PERICO_ADV, TRANSLATE("立即打开切割玻璃"), {}, IsWorking(false), function()
            SET_FLOAT_LOCAL("fm_mission_controller_2020", 28736 + 3, 100)
        end, function()
            SET_FLOAT_LOCAL("fm_mission_controller_2020", 28736 + 3, 0)
        end)

        menu.toggle_loop(PERICO_ADV, TRANSLATE("绕过切割玻璃发热"), {}, IsWorking(false), function()
            SET_FLOAT_LOCAL("fm_mission_controller_2020", 28736 + 4, 0)
        end)

        menu.toggle_loop(PERICO_ADV, TRANSLATE("无限门禁时间"), {}, IsWorking(false), function()
            local Value = GET_INT_LOCAL("fm_mission_controller_2020", 1716)
            SET_INT_LOCAL("fm_mission_controller_2020", 1715, Value)
        end, function()
            SET_INT_LOCAL("fm_mission_controller_2020", 1715, 0)
        end)

        CP_REM_FEE = menu.toggle_loop(PERICO_ADV, TRANSLATE("移除倒卖费&帕维尔分红"), {"hccpremfee"}, IsWorking(true) .. TRANSLATE("Leave activated until the end of the heist"), function()
            SET_FLOAT_GLOBAL(262145 + 29979, 0) -- 902085532
            SET_FLOAT_GLOBAL(262145 + 29980, 0) -- -1135949374
        end, function()
            SET_FLOAT_GLOBAL(262145 + 29979, -0.1)
            SET_FLOAT_GLOBAL(262145 + 29980, -0.02)
        end)

        menu.action(PERICO_ADV, TRANSLATE("自动完成主要目标"), {"hccpfintar"}, IsWorking(false), function() -- Locals from https://www.unknowncheats.me/forum/3418914-post13398.html, Values from Heist Control for Nightfall
            SET_INT_LOCAL("fm_mission_controller_2020", 28735, 5) -- CutterStage
            SET_INT_LOCAL("fm_mission_controller_2020", 28736, 3) -- BitCheck
        end)

        menu.action(PERICO_ADV, TRANSLATE("拆除排水管"), {"hccprempipe"}, "", function() -- Thanks to help me to code, Sapphire#6031
            for k, ent in pairs(entities.get_all_objects_as_handles()) do
                if ENTITY.GET_ENTITY_MODEL(ent) == -1297635988 then
                    entities.delete_by_handle(ent)
                end
            end
        end)
    
    ---

    menu.list_action(PERICO_HEIST, TRANSLATE("抢劫载具"), {"hccpveh"}, "", {
        { TRANSLATE("潜水艇 虎鲸"), {"kosatka"} },
        { TRANSLATE("飞机 阿尔科诺斯特"), {"alkonost"} },
        { TRANSLATE("飞机 梅杜莎"), {"velum"} },
        { TRANSLATE("直升机 隐形歼灭者"), {"annihilator"} },
        { TRANSLATE("船 巡逻艇"), {"patrol"} },
        { TRANSLATE("船 长鳍"), {"longfin"} },
        { TRANSLATE("解锁所有载具"), {"all"} },
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

    menu.list_action(PERICO_HEIST, TRANSLATE("主要目标"), {"hccppritar"}, "", {
        { TRANSLATE("猎豹雕像"), {"panther"} },
        { "马德拉索文件", {"file"} },
        { "粉钻", {"diamond"} },
        { "不记名债券", {"bearer"} },
        { TRANSLATE("红宝石项链"), {"ruby"} },
        { "龙舌兰酒", {"tequila"} },
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

    menu.list_action(PERICO_HEIST, TRANSLATE("次要目标"), {"hccpsectar"}, TRANSLATE("使用次要目标会使你的最终分红随机!"), {
        { "混合战利品", {"mixed"} },
        { "现金", {"cash"} },
        { "大麻", {"weed"} },
        { "可卡因", {"coke"} },
        { "黄金", {"gold"} },
        { TRANSLATE("移除所有次要目标"), {"remall"} },
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

    menu.list_action(PERICO_HEIST, TRANSLATE("庄园内战利品"), {"hccpcomloot"}, "", {
        { "混合战利品", {"mixed"} },
        { "全为现金", {"cash"} },
        { "全为大麻", {"weed"} },
        { "全为可卡因", {"coke"} },
        { "全为黄金", {"gold"} },
        { "全为画", {"paint"} },
        { "移除所有画", {"rempaint"} },
        { TRANSLATE("移除所有庄园内战利品"), {"remall"} },
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

    menu.list_action(PERICO_HEIST, TRANSLATE("武器配置"), {"hccpweapon"}, "", {
        { TRANSLATE("侵略者配置"), {"aggeressor"} },
        { TRANSLATE("阴谋者配置"), {"conspirator"} },
        { TRANSLATE("神枪手配置"), {"crackshot"} },
        { TRANSLATE("破坏者配置"), {"saboteur"} },
        { TRANSLATE("神射手配置"), {"marksman"} },
    }, function(Index)
        if Index == 1 then
            NOTIFY(TRANSLATE("- Assault SG + Machine Pistol") .. "\n" .. TRANSLATE("- Machete + Grenade"))
        elseif Index == 2 then
            NOTIFY(TRANSLATE("- Military Rifle + AP") .. "\n" .. TRANSLATE("- Knuckles + Stickies"))
        elseif Index == 3 then 
            NOTIFY(TRANSLATE("- Sniper + AP") .. "\n" .. TRANSLATE("- Knife + Molotov"))
        elseif Index == 4 then 
            NOTIFY(TRANSLATE("- SMG Mk2 + SNS Pistol"))
        elseif Index == 5 then 
            NOTIFY(TRANSLATE("- AK-47 + Pistol .50") .. "\n" .. TRANSLATE("- Machete + Pipe Bomb"))
        end
        
        STAT_SET_INT("H4CNF_WEAPONS", Index)
    end)

    menu.list_action(PERICO_HEIST, TRANSLATE("准备[制服,钩抓,剪钳]生成区域"), {"hccpequip"}, TRANSLATE("- 制服") .. "\n" .. TRANSLATE("- 剪钳"), { 
        { "飞机场", {"airport"} },
        { "码头", {"dock"} },
        { "庄园", {"compound"} },
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

    menu.list_action(PERICO_HEIST, TRANSLATE("设置补给车位置"), {"hccptruck"}, "", {
        { "飞机场", {"airport"} },
        { "北码头", {"ndock"} },
        { "主码头[东]", {"edock"} },
        { "主码头[西]", {"wdock"} },
        { "庄园附近", {"compound"} },
    }, function(Index)
        STAT_SET_INT("H4CNF_TROJAN", Index)
    end)

    menu.list_action(PERICO_HEIST, TRANSLATE("设置抢劫难度"), {"hccpdiff"}, "", {
        { TRANSLATE("正常"), {"normal"} },
        { TRANSLATE("困难"), {"hard"} },
    }, function(Index)
        if Index == 1 then
            STAT_SET_INT("H4_PROGRESS", 126823)
        elseif Index == 2 then
            STAT_SET_INT("H4_PROGRESS", 131055)
        end
    end)

    local MORE_OPTIONS = menu.list(PERICO_HEIST, TRANSLATE("其他"), {}, "", function(); end)

        menu.action(MORE_OPTIONS, TRANSLATE("解锁佩里科岛奖项"), {}, "", function()
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
        end)

        menu.action(MORE_OPTIONS, TRANSLATE("完成所有准备任务"), {}, "", function()
            STAT_SET_INT("H4_MISSIONS", -1)
            STAT_SET_INT("H4CNF_APPROACH", -1)
            STAT_SET_INT("H4CNF_BS_ENTR", 63)
            STAT_SET_INT("H4CNF_BS_GEN", 63)
            STAT_SET_INT("H4CNF_WEP_DISRP", 3)
            STAT_SET_INT("H4CNF_ARM_DISRP", 3)
            STAT_SET_INT("H4CNF_HEL_DISRP", 3)
        end)

        menu.action(MORE_OPTIONS, TRANSLATE("强制完成最后的过场动画"), {}, TRANSLATE("你必须在开始任务前打开此选项"), function()
            STAT_SET_INT("H4_PLAYTHROUGH_STATUS", 0)
        end)

        menu.action(MORE_OPTIONS, TRANSLATE("设置抢劫为默认[重置]"), {"hccpreset"}, "", function()
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

    local CASINO_PRESETS = menu.list(CASINO_HEIST, TRANSLATE("自动预设"), {}, "", function(); end)

        local CASINO_PRESETS_DIAMOND = menu.list(CASINO_PRESETS, TRANSLATE("钻石"), {}, TRANSLATE("全员350万"), function(); end)

            menu.toggle(CASINO_PRESETS_DIAMOND, TRANSLATE("隐迹潜踪"), {"hccahdiasil"}, IsWorking(true) .. TRANSLATE("选择低级买家!"), function(Toggle)
                DiamondST = Toggle

                if DiamondST then
                    STAT_SET_INT("H3_COMPLETEDPOSIX", -1)
                    STAT_SET_INT("H3OPT_MASKS", 4)
                    STAT_SET_INT("H3OPT_WEAPS", 1)
                    STAT_SET_INT("H3OPT_VEHS", 3)
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
                    SET_INT_GLOBAL(262145 + 28796, 1410065408) -- 1277889925
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

            menu.toggle(CASINO_PRESETS_DIAMOND, TRANSLATE("兵不厌诈"), {"hccahdiabig"}, IsWorking(true) .. TRANSLATE("选择低级买家!"), function(Toggle)
                DiamondND = Toggle

                if DiamondND then
                    STAT_SET_INT("H3_COMPLETEDPOSIX", -1)
                    STAT_SET_INT("H3OPT_MASKS", 2)
                    STAT_SET_INT("H3OPT_WEAPS", 1)
                    STAT_SET_INT("H3OPT_VEHS", 3)
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
                    SET_INT_GLOBAL(262145 + 28796, 1410065408)
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

            menu.toggle(CASINO_PRESETS_DIAMOND, TRANSLATE("气势汹汹"), {"hccahdiaagg"}, IsWorking(true) .. TRANSLATE("选择低级买家!"), function(Toggle)
                DiamondRD = Toggle

                if DiamondRD then
                    STAT_SET_INT("H3_COMPLETEDPOSIX", -1)
                    STAT_SET_INT("H3OPT_MASKS", 4)
                    STAT_SET_INT("H3OPT_WEAPS", 1)
                    STAT_SET_INT("H3OPT_VEHS", 3)
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
                    SET_INT_GLOBAL(262145 + 28796, 1410065408)
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

        local CASINO_PRESETS_GOLD = menu.list(CASINO_PRESETS, TRANSLATE("黄金"), {}, TRANSLATE("全员350万"), function(); end)

            menu.toggle(CASINO_PRESETS_GOLD, TRANSLATE("隐迹潜踪"), {"hccahgoldsil"}, IsWorking(true) .. TRANSLATE("选择低级买家!"), function(Toggle)
                GoldST = Toggle

                if GoldST then
                    STAT_SET_INT("H3_COMPLETEDPOSIX", -1)
                    STAT_SET_INT("H3OPT_MASKS", 9)
                    STAT_SET_INT("H3OPT_WEAPS", 1)
                    STAT_SET_INT("H3OPT_VEHS", 3)
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
                    SET_INT_GLOBAL(262145 + 28795, 1410065408) -- -582734553
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

            menu.toggle(CASINO_PRESETS_GOLD, TRANSLATE("兵不厌诈"), {"hccahgoldbig"}, IsWorking(true) .. TRANSLATE("选择低级买家!"), function(Toggle)
                GoldND = Toggle

                if GoldND then
                    STAT_SET_INT("H3_COMPLETEDPOSIX", -1)
                    STAT_SET_INT("H3OPT_MASKS", 9)
                    STAT_SET_INT("H3OPT_WEAPS", 1)
                    STAT_SET_INT("H3OPT_VEHS", 3)
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
                    SET_INT_GLOBAL(262145 + 28795, 1410065408)
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

            menu.toggle(CASINO_PRESETS_GOLD, TRANSLATE("气势汹汹"), {"hccahgoldagg"}, IsWorking(true) .. TRANSLATE("选择低级买家!"), function(Toggle)
                GoldRD = Toggle

                if GoldRD then
                    STAT_SET_INT("H3_COMPLETEDPOSIX", -1)
                    STAT_SET_INT("H3OPT_MASKS", 4)
                    STAT_SET_INT("H3OPT_WEAPS", 1)
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
                    SET_INT_GLOBAL(262145 + 28795, 1410065408)
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

    local CAH_ADVCED = menu.list(CASINO_HEIST, TRANSLATE("高级功能"), {}, "", function(); end)
    
        local CAH_PLAYER_CUT = menu.list(CAH_ADVCED, TRANSLATE("玩家分红"), {}, "", function(); end)

            local CAH_NON_YOUR_CUT = menu.list(CAH_PLAYER_CUT, TRANSLATE("你的分红(不是主机时用)"), {}, "", function(); end)

                CAH_NON_HOST_CUT_LOOP = menu.toggle_loop(CAH_NON_YOUR_CUT, TRANSLATE("启用"), {"hccahnonhostloop"}, IsWorking(false), function()
                    SET_INT_GLOBAL(2715699 + 6546, menu.get_value(CAH_NON_HOST_CUT)) -- gb_casino_heist.c
                end, function()
                    SET_INT_GLOBAL(2715699 + 6546, 100)
                end)

                CAH_NON_HOST_CUT = menu.slider(CAH_NON_YOUR_CUT, TRANSLATE("自定义分红"), {"hccahnonhost"}, "(%)", 0, 1000, 100, 5, function(); end)

            ---

            local CAH_PLAYER_HOST = menu.list(CAH_PLAYER_CUT, TRANSLATE("你的分红(你是主机时用)"), {}, "", function(); end)

                CAH_1P_CUT_LOOP = menu.toggle_loop(CAH_PLAYER_HOST, TRANSLATE("启用"), {"hccah1pcutloop"}, IsWorking(false), function()
                    SET_INT_GLOBAL(1966534 + 2326, menu.get_value(CAH_1P_CUT)) -- gb_casino_heist.c
                end, function()
                    SET_INT_GLOBAL(1966534 + 2326, 100)
                end)

                CAH_1P_CUT = menu.slider(CAH_PLAYER_HOST, TRANSLATE("自定义分红"), {"hccah1pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

            ---

            local CAH_PLAYER_TWO = menu.list(CAH_PLAYER_CUT, TRANSLATE("玩家 2"), {}, "", function(); end)

                CAH_2P_CUT_LOOP = menu.toggle_loop(CAH_PLAYER_TWO, TRANSLATE("启用"), {"hccah2pcutloop"}, IsWorking(false), function()
                    SET_INT_GLOBAL(1966534 + 2326 + 1, menu.get_value(CAH_2P_CUT)) -- gb_casino_heist.c
                end, function()
                    SET_INT_GLOBAL(1966534 + 2326 + 1, 100)
                end)

                CAH_2P_CUT = menu.slider(CAH_PLAYER_TWO, TRANSLATE("自定义分红"), {"hccah2pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

            ---

            local CAH_PLAYER_THREE = menu.list(CAH_PLAYER_CUT, TRANSLATE("玩家 3"), {}, "", function(); end)

                CAH_3P_CUT_LOOP = menu.toggle_loop(CAH_PLAYER_THREE, TRANSLATE("启用"), {"hccah3pcutloop"}, IsWorking(false), function()
                    SET_INT_GLOBAL(1966534 + 2326 + 2, menu.get_value(CAH_3P_CUT)) -- gb_casino_heist.c
                end, function()
                    SET_INT_GLOBAL(1966534 + 2326 + 2, 100)
                end)

                CAH_3P_CUT = menu.slider(CAH_PLAYER_THREE, TRANSLATE("自定义分红"), {"hccah3pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

            ---

            local CAH_PLAYER_FOUR = menu.list(CAH_PLAYER_CUT, TRANSLATE("玩家 4"), {}, "", function(); end)
                
                CAH_4P_CUT_LOOP = menu.toggle_loop(CAH_PLAYER_FOUR, TRANSLATE("启用"), {"hccah4pcutloop"}, IsWorking(false), function()
                    SET_INT_GLOBAL(1966534 + 2326 + 3, menu.get_value(CAH_4P_CUT)) -- gb_casino_heist.c
                end, function()
                    SET_INT_GLOBAL(1966534 + 2326 + 3, 100)
                end)

                CAH_4P_CUT = menu.slider(CAH_PLAYER_FOUR, TRANSLATE("自定义分红"), {"hccah4pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

            ---

            menu.toggle_loop(CAH_PLAYER_CUT, TRANSLATE("所有人设置为100%"), {"hccahall100"}, IsWorking(false), function()
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

        menu.toggle_loop(CAH_ADVCED, TRANSLATE("跳过黑入"), {}, IsWorking(true) .. TRANSLATE("适用两种方式:键盘和指纹"), function()
            if GET_INT_LOCAL("fm_mission_controller", 52929) ~= 1 then -- For Fingerprint, Locals from https://www.unknowncheats.me/forum/3418914-post13398.html, Values from Heist Control for Nightfall
                SET_INT_LOCAL("fm_mission_controller", 52929, 5)
            end
            if GET_INT_LOCAL("fm_mission_controller", 53991) ~= 1 then -- For Keypad, https://www.unknowncheats.me/forum/3455828-post8.html
                SET_INT_LOCAL("fm_mission_controller", 53991, 5)
            end
        end)

        menu.action(CAH_ADVCED, TRANSLATE("即时金库门激光"), {"hccahinsvault"}, IsWorking(false), function() -- Locals from https://www.unknowncheats.me/forum/3418914-post13398.html, Values from Heist Control for Nightfall
            local Value = GET_INT_LOCAL("fm_mission_controller", 10082 + 37)
            SET_INT_LOCAL("fm_mission_controller", 10082 + 7, Value)
        end)

    ---

    local TELEPORT_CAH = menu.list(CASINO_HEIST, TRANSLATE("自定义传送"), {}, "", function(); end)

        menu.divider(TELEPORT_CAH, TRANSLATE("内部"))

            menu.action(TELEPORT_CAH, TRANSLATE("游戏厅面板"), {}, "", function()
                TELEPORT(2711.773, -369.458, -54.781)
            end)
            menu.action(TELEPORT_CAH, TRANSLATE("游戏厅车库门口"), {}, "", function()
                TELEPORT(2677.237, -361.494, -55.187)
            end)
            menu.action(TELEPORT_CAH, TRANSLATE("废物处理间"), {}, "", function()
                TELEPORT(2542.052, -214.3084, -58.722965)
            end)
            menu.action(TELEPORT_CAH, TRANSLATE("员工休息室"), {}, "", function()
                TELEPORT(2547.9192, -273.16754, -58.723003)
            end)
            menu.action(TELEPORT_CAH, TRANSLATE("双门禁处"), {}, "", function()
                TELEPORT(2465.4746, -279.2276, -70.694145)
            end)
            menu.action(TELEPORT_CAH, TRANSLATE("金库内部"), {}, "", function()
                TELEPORT(2515.1252, -238.91661, -70.73713)
            end)
            menu.action(TELEPORT_CAH, TRANSLATE("小金库内部"), {}, "", function()
                TELEPORT(2497.5098, -238.50768, -70.7388)
            end)
            menu.action(TELEPORT_CAH, TRANSLATE("每日转盘室"), {}, "", function()
                TELEPORT(2520.8645, -286.30685, -58.723007)
            end)

        ---

        menu.divider(TELEPORT_CAH, TRANSLATE("外面"))

            menu.action(TELEPORT_CAH, TRANSLATE("正门"), {}, "", function()
                TELEPORT(917.24634, 48.989567, 80.89892)
            end)
            menu.action(TELEPORT_CAH, TRANSLATE("后面门禁"), {}, "", function()
                TELEPORT(965.14856, -9.05023, 80.63045)
            end)
            menu.action(TELEPORT_CAH, TRANSLATE("音乐柜"), {}, "", function()
                TELEPORT(997.5346, 84.51491, 80.990555)
            end)

        ---

    ---

    local CASINO_BOARD1 = menu.list(CASINO_HEIST, TRANSLATE("抢劫面板一"), {}, "", function(); end)

        local BOARD1_APPROACH = menu.list(CASINO_BOARD1, TRANSLATE("设置抢劫方式和难度"), {}, "", function(); end)

            menu.list_action(BOARD1_APPROACH, TRANSLATE("隐迹潜踪"), {"hccahdiffsil"}, "", {
                { TRANSLATE("正常"), {"normal"} },
                { TRANSLATE("困难"), {"hard"} },
            }, function(Index)
                if Index == 1 then
                    STAT_SET_INT("H3_HARD_APPROACH", 0)
                elseif Index == 2 then
                    STAT_SET_INT("H3_HARD_APPROACH", 1)
                end
        
                STAT_SET_INT("H3_LAST_APPROACH", 0)
                STAT_SET_INT("H3OPT_APPROACH", 1)
            end)
        
            menu.list_action(BOARD1_APPROACH, TRANSLATE("兵不厌诈"), {"hccahdiffbig"}, "", {
                { TRANSLATE("正常"), {"normal"} },
                { TRANSLATE("困难"), {"hard"} },
            }, function(Index)
                if Index == 1 then
                    STAT_SET_INT("H3_HARD_APPROACH", 0)
                elseif Index == 2 then
                    STAT_SET_INT("H3_HARD_APPROACH", 2)
                end
        
                STAT_SET_INT("H3_LAST_APPROACH", 0)
                STAT_SET_INT("H3OPT_APPROACH", 2)
            end)
        
            menu.list_action(BOARD1_APPROACH, TRANSLATE("气势汹汹"), {"hccahdiffagg"}, "", {
                { TRANSLATE("正常"), {"normal"} },
                { TRANSLATE("困难"), {"hard"} },
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

        menu.list_action(CASINO_BOARD1, TRANSLATE("设置目标"), {"hccahtar"}, "", {
            { TRANSLATE("钻石"), {"diamond"} },
            { TRANSLATE("黄金"), {"gold"} },
            { TRANSLATE("艺术品"), {"artwork"} },
            { TRANSLATE("现金"), {"cash"} },
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
        menu.list_select(CASINO_BOARD1, TRANSLATE("解锁所有兴趣点&出入口"), {"hccahpoi"}, TRANSLATE("切换战局应用!"), {
            { "范围(d)", {"scope"} },
            { "取消范围(d)", {"unscope"} },
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

    local CASINO_BOARD2 = menu.list(CASINO_HEIST, TRANSLATE("抢劫面板二"), {}, "", function(); end)

        menu.list_action(CASINO_BOARD2, TRANSLATE("设置枪手"), {"hccahweaponvar"}, "", {
            { TRANSLATE("切斯特·麦考伊") .. " (10%)", {"chester"} },
            { TRANSLATE("古斯塔沃·莫塔") .. " (9%)", {"gustavo"} },
            { TRANSLATE("帕特里克·麦克雷里") .. " (8%)", {"patrick"} },
            { TRANSLATE("查理·里德") .. " (7%)", {"charlie"} },
            { TRANSLATE("卡尔·阿博拉吉") .. " (5%)", {"karl"} },
            { TRANSLATE("随机枪手") .. " (??%)", {"random"} },
            { TRANSLATE("移除枪手") .. " (0%)", {"remove"} },
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

        menu.list_action(CASINO_BOARD2, TRANSLATE("武器设置"), {"hccahweaponvar"}, "", {
            { TRANSLATE("最好的武器"), {"best"} },
            { TRANSLATE("最烂的武器"), {"worst"} },
        }, function(Index)
            if Index == 1 then
                STAT_SET_INT("H3OPT_WEAPS", 1)
            elseif Index == 2 then
                STAT_SET_INT("H3OPT_WEAPS", 0)
            end
        end)

        menu.list_action(CASINO_BOARD2, TRANSLATE("设置司机"), {"hccahveh"}, "", {
            { TRANSLATE("切斯特·麦考伊") .. " (10%)", {"chester"} },
            { TRANSLATE("艾迪·陶") .. " (9%)", {"eddie"} },
            { TRANSLATE("塔莉安娜·马丁内斯") .. " (7%)", {"taliana"} },
            { TRANSLATE("扎克·尼尔森") .. " (6%)", {"zach"} },
            { TRANSLATE("卡里姆·登茨") .. " (5%)", {"karim"} },
            { TRANSLATE("随机司机") .. " (??%)", {"random"} },
            { TRANSLATE("移除司机") .. " (0%)", {"remove"} },
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

        menu.list_action(CASINO_BOARD2, TRANSLATE("载具设置"), {"hccahvehvar"}, "", {
            { TRANSLATE("最好的车"), {"best"} },
            { TRANSLATE("一般好车"), {"good"} },
            { TRANSLATE("一般的车"), {"fine"} },
            { TRANSLATE("最烂的车"), {"worst"} },
            { TRANSLATE("随机载具"), {"random"} },
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

        menu.list_action(CASINO_BOARD2, TRANSLATE("设置黑客"), {"hccahhack"}, "", {
            { TRANSLATE("阿维·施瓦茨曼") .. " (10%)", {"avi"} },
            { TRANSLATE("佩奇·哈里斯") .. " (9%)", {"paige"} },
            { TRANSLATE("克里斯汀·费尔兹") .. " (7%)", {"christian"} },
            { TRANSLATE("约翰·布莱尔") .. " (6%)", {"yohan"} },
            { TRANSLATE("瑞奇·鲁肯斯") .. " (3%)", {"rickie"} },
            { TRANSLATE("随机黑客") .. " (??%)", {"random"} },
            { TRANSLATE("移除黑客") .. " (0%)", {"remove"} },
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

        menu.list_action(CASINO_BOARD2, "设置面具", {"hccahmask"}, "", {
            { TRANSLATE("移除面具"), {"remove"} },
            { TRANSLATE("几何面具"), {"geometric"} },
            { TRANSLATE("猎人系列"), {"hunter"} },
            { TRANSLATE("半鬼面系列"), {"onihalf"} },
            { TRANSLATE("表情包系列"), {"emoji"} },
            { TRANSLATE("华丽纹饰骷髅头系列"), {"ornate"} },
            { TRANSLATE("幸运水果系列"), {"lucky"} },
            { TRANSLATE("游击队系列"), {"guerilla"} },
            { TRANSLATE("小丑系列"), {"clown"} },
            { TRANSLATE("动物系列"), {"animal"} },
            { TRANSLATE("防爆系列"), {"riot"} },
            { TRANSLATE("鬼面系列"), {"oni"} },
            { TRANSLATE("曲棍球系列"), {"hockey"} },
        }, function(Index)
            if Index == 1 then
                STAT_SET_INT("H3OPT_MASKS", -1)
            else
                STAT_SET_INT("H3OPT_MASKS", Index - 1)
            end
        end)

        menu.click_slider(CASINO_BOARD2, TRANSLATE("解锁二级门禁卡"), {"hccahcard"}, "", 0, 2, 2, 1, function(Value)
            STAT_SET_INT("H3OPT_KEYLEVELS", Value)
        end)
        menu.click_slider(CASINO_BOARD2, TRANSLATE("削弱重甲兵安保"), {"hccahguard"}, TRANSLATE("0 - 重甲兵安保") .. "\n" .. TRANSLATE("3 - 普通安保"), 0, 3, 3, 1, function(Value)
            STAT_SET_INT("H3OPT_DISRUPTSHIP", Value)
        end)

    ---

    local CASINO_BOARD3 = menu.list(CASINO_HEIST, TRANSLATE("抢劫面板三"), {}, "", function(); end)

        menu.divider(CASINO_BOARD3, TRANSLATE("移除钻头"))

            menu.action(CASINO_BOARD3, TRANSLATE("隐迹潜踪"), {"hccahremsilaggdrill"}, "", function()
                STAT_SET_INT("H3OPT_BITSET0", -8849)
            end)
            menu.action(CASINO_BOARD3, TRANSLATE("兵不厌诈"), {"hccahrembigdrill"}, "", function()
                STAT_SET_INT("H3OPT_BITSET0", -186)
            end)

        ---

    ---

    menu.list_action(CASINO_HEIST, TRANSLATE("卸载&加载策划版"), {"hccahboard"}, "", {
        { TRANSLATE("加载所有策划版"), {"load"} },
        { TRANSLATE("卸载所有策划版"), {"unload"} },
    }, function(Index)
        if Index == 1 then
            STAT_SET_INT("H3OPT_BITSET1", -1)
            STAT_SET_INT("H3OPT_BITSET0", -1)
        elseif Index == 2 then
            STAT_SET_INT("H3OPT_BITSET1", 0)
            STAT_SET_INT("H3OPT_BITSET0", 0)
        end
    end)

    menu.list_action(CASINO_HEIST, TRANSLATE("赌场任务"), {}, "", {
        { TRANSLATE("解救陈陶") },
        { TRANSLATE("日常杂物") },
        { TRANSLATE("铁腕战术") },
        { TRANSLATE("志在得胜") },
        { TRANSLATE("出奇制胜") },
        { TRANSLATE("金盆套现") },
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

    local CASINO_MORE = menu.list(CASINO_HEIST, TRANSLATE("其他"), {}, "", function(); end)

        menu.action(CASINO_MORE, TRANSLATE("解锁赌场奖项"), {}, "", function()
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

        menu.action(CASINO_MORE, TRANSLATE("移除抢劫准备冷却"), {}, "这只能绕过支付冷却并不能绕过服务器冷却[好像是16分钟冷却？]", function()
            STAT_SET_INT("H3_COMPLETEDPOSIX", -1)
            STAT_SET_INT("MPPLY_H3_COOLDOWN", -1)
        end)

        menu.action(CASINO_MORE, TRANSLATE("跳过阿加莎·贝克的任务到最后一项"), {}, "", function()
            STAT_SET_INT("VCM_FLOW_PROGRESS", -1)
            STAT_SET_INT("VCM_STORY_PROGRESS", 5)
            STAT_SET_BOOL("AWD_LEADER", true)
            STAT_SET_BOOL("VCM_FLOW_CS_FIN_SEEN", true)
        end)

        menu.action(CASINO_MORE, TRANSLATE("设置抢劫为默认[重置]"), {"hccahreset"}, "", function()
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

    menu.list_action(DOOMS_HEIST, TRANSLATE("自动预设") .. " " .. TRANSLATE("[最终抢劫]"), {"hcdoomspreset"}, "", {
        { TRANSLATE("数据泄露 ACT I"), {"1st"} },
        { TRANSLATE("波格丹危机 ACT II"), {"2nd"} },
        { TRANSLATE("末日将至 ACT III"), {"3rd"} },
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

    local TELEPORT_DOOMS = menu.list(DOOMS_HEIST, TRANSLATE("自定义传送"), {}, "", function(); end)

        menu.action(TELEPORT_DOOMS, "设施里的抢劫屏幕", {}, "只能在设施里面进行传送.", function()
            TELEPORT(350.69284, 4872.308, -60.794243)
            SET_HEADING(-50)
        end)
        menu.action(TELEPORT_DOOMS, TRANSLATE("抢劫面板"), {}, "[" .. TRANSLATE("波格丹危机 ACT II") .. "]", function()
            TELEPORT(515.528, 4835.353, -62.587)
        end)
        menu.action(TELEPORT_DOOMS, TRANSLATE("波格丹囚室"), {}, "[" .. TRANSLATE("波格丹危机 ACT II") .. "]", function()
            TELEPORT(512.888, 4833.033, -68.989)
        end)

    ---

    local DDHEIST_PLYR_MANAGER = menu.list(DOOMS_HEIST, TRANSLATE("玩家分红"), {}, "", function(); end)

        local DDHEIST_HOST_MANAGER = menu.list(DDHEIST_PLYR_MANAGER, TRANSLATE("你的分红"), {}, "", function(); end)

            DOOMS_HOST_CUT_LOOP = menu.toggle_loop(DDHEIST_HOST_MANAGER, TRANSLATE("启用"), {"hcdooms1ploop"}, IsWorking(false), function()
                SET_INT_GLOBAL(1962546 + 812 + 50 + 1, menu.get_value(DOOMS_HOST_CUT)) -- gb_gang_ops_planning.c
            end, function()
                SET_INT_GLOBAL(1962546 + 812 + 50 + 1, 100)
            end)

            DOOMS_HOST_CUT = menu.slider(DDHEIST_HOST_MANAGER, TRANSLATE("自定义分红"), {"hcdooms1pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

        ---

        local DDHEIST_PLAYER2_MANAGER = menu.list(DDHEIST_PLYR_MANAGER, TRANSLATE("玩家 2"), {}, "", function(); end)
            
            DOOMS_2P_CUT_LOOP = menu.toggle_loop(DDHEIST_PLAYER2_MANAGER, TRANSLATE("启用"), {"hcdooms2pcutloop"}, IsWorking(false), function()
                SET_INT_GLOBAL(1962546 + 812 + 50 + 2, menu.get_value(DOOMS_2P_CUT)) -- gb_gang_ops_planning.c
            end, function()
                SET_INT_GLOBAL(1962546 + 812 + 50 + 2, 100)
            end)

            DOOMS_2P_CUT = menu.slider(DDHEIST_PLAYER2_MANAGER, TRANSLATE("自定义分红"), {"hcdooms2pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

        ---

        local DDHEIST_PLAYER3_MANAGER = menu.list(DDHEIST_PLYR_MANAGER, TRANSLATE("玩家 3"), {}, "", function(); end)

            DOOMS_3P_CUT_LOOP = menu.toggle_loop(DDHEIST_PLAYER3_MANAGER, TRANSLATE("启用"), {"hcdooms3pcutloop"}, IsWorking(false), function()
                SET_INT_GLOBAL(1962546 + 812 + 50 + 3, menu.get_value(DOOMS_3P_CUT)) -- gb_gang_ops_planning.c
            end, function()
                SET_INT_GLOBAL(1962546 + 812 + 50 + 3, 100)
            end)

            DOOMS_3P_CUT = menu.slider(DDHEIST_PLAYER3_MANAGER, TRANSLATE("自定义分红"), {"hcdooms3pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

        ---

        local DDHEIST_PLAYER4_MANAGER = menu.list(DDHEIST_PLYR_MANAGER, TRANSLATE("玩家 4"), {}, "", function(); end)

            DOOMS_4P_CUT_LOOP = menu.toggle_loop(DDHEIST_PLAYER4_MANAGER, TRANSLATE("启用"), {"hcdooms4pcutloop"}, IsWorking(false), function()
                SET_INT_GLOBAL(1962546 + 812 + 50 + 4, menu.get_value(DOOMS_4P_CUT)) -- gb_gang_ops_planning.c
            end, function()
                SET_INT_GLOBAL(1962546 + 812 + 50 + 4, 100)
            end)

            DOOMS_4P_CUT = menu.slider(DDHEIST_PLAYER4_MANAGER, TRANSLATE("自定义分红"), {"hcdooms4pcut"}, "(%)", 0, 1000, 100, 5, function(); end)

        ---

        menu.toggle_loop(DDHEIST_PLYR_MANAGER, TRANSLATE("末日一分红[250万]"), {"hcdooms1stpay"}, IsWorking(true) .. TRANSLATE("设置为困难难度.百分比看不全很奇怪,但并不影响适.用于所有人."), function()
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

        menu.toggle_loop(DDHEIST_PLYR_MANAGER, TRANSLATE("末日二分红[250万]"), {"hcdooms2ndpay"}, IsWorking(true) .. TRANSLATE("设置为困难难度.百分比看不全很奇怪,但并不影响适.用于所有人."), function()
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

        menu.toggle_loop(DDHEIST_PLYR_MANAGER, TRANSLATE("末日三分红[250万]"), {"hcdooms3rdpay"}, IsWorking(true) .. TRANSLATE("设置为困难难度.百分比看不全很奇怪,但并不影响适.用于所有人."), function()
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

    menu.toggle_loop(DOOMS_HEIST, TRANSLATE("跳过黑入"), {}, IsWorking(true) .. "[" .. TRANSLATE("末日将至 ACT III") .. " & " .. TRANSLATE("数据泄露 ACT I") .. " - " .. TRANSLATE("设置:服务器群(莱斯特)") .. "]", function() -- https://www.unknowncheats.me/forum/3455828-post8.html
        SET_INT_LOCAL("fm_mission_controller", 1263 + 135, 3) -- For ACT III
        SET_INT_LOCAL("fm_mission_controller", 1537, 2) -- For ACT I, Setup: Server Farm (Lester)
    end)

    menu.action(DOOMS_HEIST, TRANSLATE("解锁所有末日豪劫选项"), {}, "", function()
        STAT_SET_INT("GANGOPS_HEIST_STATUS", -1)
        STAT_SET_INT("GANGOPS_HEIST_STATUS", -229384)
    end)

    menu.action(DOOMS_HEIST, TRANSLATE("解锁末日豪杰奖项"), {}, "", function()
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

    menu.action(DOOMS_HEIST, TRANSLATE("完成所有准备任务(非前置)"), {}, "", function()
        STAT_SET_INT("GANGOPS_FM_MISSION_PROG", -1)
    end)

    menu.action(DOOMS_HEIST, TRANSLATE("设置抢劫为默认[重置]"), {"hcdoomsreset"}, TRANSLATE("切换战局应用!"), function()
        STAT_SET_INT("GANGOPS_FLOW_MISSION_PROG", 240)
        STAT_SET_INT("GANGOPS_HEIST_STATUS", 0)
        STAT_SET_INT("GANGOPS_FLOW_NotifyS", 1557)
    end)

---


--- Classic Heist

    local FLEECA_HEIST = menu.list(CLASSIC_HEISTS, TRANSLATE("公寓抢劫"), {}, "", function(); end)

        menu.divider(FLEECA_HEIST, TRANSLATE("你的分红(百万)"))
        
            menu.toggle_loop(FLEECA_HEIST, TRANSLATE("启用"), {"hcfleecapayloop"}, IsWorking(true) .. TRANSLATE("你必须是主机") .. "\n\n" .. TRANSLATE("- 24小时内只执行一次或两次.") .. "\n" .. TRANSLATE("- 否则,你将会被封号!"), function(Toggle)
                local Value = 100
                if menu.get_value(FLEECA_PAYOUT) == 5 then
                    Value = 1987
                elseif menu.get_value(FLEECA_PAYOUT) == 10 then
                    Value = 3974
                elseif menu.get_value(FLEECA_PAYOUT) == 15 then
                    Value = 5961
                end

                SET_INT_GLOBAL(1933908 + 3008 + 1, Value) -- fmmc_launcher.c
            end, function()
                SET_INT_GLOBAL(1933908 + 3008 + 1, 100)
            end)

            FLEECA_PAYOUT = menu.slider(FLEECA_HEIST, TRANSLATE("修改分红"), {"hcfleecapay"}, "", 5, 15, 15, 5, function(Value); end)

        ---

        menu.divider(FLEECA_HEIST, TRANSLATE("其他"))

            menu.toggle_loop(FLEECA_HEIST, TRANSLATE("完成所有前置"), {}, TRANSLATE("你必须全程激活,然后需要选择一个抢劫任务,完成第一个前置."), function()
                STAT_SET_INT("HEIST_PLANNING_STAGE", -1)
            end)
            menu.toggle_loop(FLEECA_HEIST, TRANSLATE("跳过黑入"), {}, IsWorking(false), function() -- https://www.unknowncheats.me/forum/3455828-post8.html
                SET_INT_LOCAL("fm_mission_controller", 11731 + 24, 7)
            end)
            menu.toggle_loop(FLEECA_HEIST, "跳过钻孔", {}, "", function() -- https://www.unknowncheats.me/forum/3485435-post19.html
                SET_FLOAT_LOCAL("fm_mission_controller", 10042 + 11, 100)
            end)

        ---

    ---

    menu.action(CLASSIC_HEISTS, TRANSLATE("解锁公寓抢劫奖选"), {}, "", function()
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

    menu.toggle_loop(LS_ROBBERY, TRANSLATE("修改合约分红-100万美元"), {"hcls1m"}, IsWorking(true) .. TRANSLATE("[Locally]") .. "\n\n" .. TRANSLATE("开始任务前始终激活到结束"), function()
        SET_INT_GLOBAL(262145 + 31029, 1000000) -- -1834943393
        SET_INT_GLOBAL(262145 + 31030 + 0, 1000000) -- -920277662
        SET_INT_GLOBAL(262145 + 31030 + 1, 1000000) -- 391170487
        SET_INT_GLOBAL(262145 + 31030 + 2, 1000000) -- -1073898730
        SET_INT_GLOBAL(262145 + 31030 + 3, 1000000) -- -842025286
        SET_INT_GLOBAL(262145 + 31030 + 4, 1000000) -- -724024117
        SET_INT_GLOBAL(262145 + 31030 + 5, 1000000) -- -492445594
        SET_INT_GLOBAL(262145 + 31030 + 6, 1000000) -- 1996622112
        SET_INT_GLOBAL(262145 + 31030 + 7, 1000000) -- -2066209588
        SET_FLOAT_GLOBAL(262145 + 31026, 0) -- 1830621208
    end, function()
        SET_INT_GLOBAL(262145 + 31029, 50000)
        SET_INT_GLOBAL(262145 + 31030 + 0, 300000)
        SET_INT_GLOBAL(262145 + 31030 + 1, 185000)
        SET_INT_GLOBAL(262145 + 31030 + 2, 178000)
        SET_INT_GLOBAL(262145 + 31030 + 3, 172000)
        SET_INT_GLOBAL(262145 + 31030 + 4, 175000)
        SET_INT_GLOBAL(262145 + 31030 + 5, 182000)
        SET_INT_GLOBAL(262145 + 31030 + 6, 180000)
        SET_INT_GLOBAL(262145 + 31030 + 7, 170000)
        SET_FLOAT_GLOBAL(262145 + 31026, 0.1)
    end)

    menu.action(LS_ROBBERY, TRANSLATE("联合储蓄"), {"hclsunion"}, "", function()
        STAT_SET_INT("TUNER_GEN_BS", 12543)
        STAT_SET_INT("TUNER_CURRENT", 0)
    end)
    menu.action(LS_ROBBERY, TRANSLATE("大钞交易"), {"hclssdollar"}, "", function()
        STAT_SET_INT("TUNER_GEN_BS", 4351)
        STAT_SET_INT("TUNER_CURRENT", 1)
    end)
    menu.action(LS_ROBBERY, TRANSLATE("银行合约"), {"hclsbank"}, "", function()
        STAT_SET_INT("TUNER_GEN_BS", 12543)
        STAT_SET_INT("TUNER_CURRENT", 2)
    end)
    menu.action(LS_ROBBERY, TRANSLATE("电控单元"), {"hclsecu"}, "", function()
        STAT_SET_INT("TUNER_GEN_BS", 12543)
        STAT_SET_INT("TUNER_CURRENT", 3)
    end)
    menu.action(LS_ROBBERY, TRANSLATE("监狱合约"), {"hclsprison"}, "", function()
        STAT_SET_INT("TUNER_GEN_BS", 12543)
        STAT_SET_INT("TUNER_CURRENT", 4)
    end)
    menu.action(LS_ROBBERY, TRANSLATE("IAA 交易"), {"hclsagency"}, "", function()
        STAT_SET_INT("TUNER_GEN_BS", 12543)
        STAT_SET_INT("TUNER_CURRENT", 5)
    end)
    menu.action(LS_ROBBERY, TRANSLATE("摩托帮交易"), {"hclslost"}, "", function()
        STAT_SET_INT("TUNER_GEN_BS", 12543)
        STAT_SET_INT("TUNER_CURRENT", 6)
    end)
    menu.action(LS_ROBBERY, TRANSLATE("数据合约"), {"hclsdata"}, "", function()
        STAT_SET_INT("TUNER_GEN_BS", 12543)
        STAT_SET_INT("TUNER_CURRENT", 7)
    end)
    menu.action(LS_ROBBERY, TRANSLATE("完成任务(前置)"), {"hclscomplete"}, "", function()
        STAT_SET_INT("TUNER_GEN_BS", -1)
    end)
    
    local ROBBERY_RESETER = menu.list(LS_ROBBERY, TRANSLATE("其他"), {}, "", function(); end)
    
        menu.action(ROBBERY_RESETER, TRANSLATE("重置任务(前置)"), {"hclsresetmisson"}, "", function()
            STAT_SET_INT("TUNER_GEN_BS", 12467)
        end)
        menu.action(ROBBERY_RESETER, TRANSLATE("重置合约"), {"hclsresetcontract"}, "", function()
            STAT_SET_INT("TUNER_GEN_BS", 8371)
            STAT_SET_INT("TUNER_CURRENT", -1)
        end)
        menu.action(ROBBERY_RESETER, TRANSLATE("重置总收益&完成任务"), {"hclsresetgain"}, "", function()
            STAT_SET_INT("TUNER_COUNT", 0)
            STAT_SET_INT("TUNER_EARNINGS", 0)
        end)
    
    ---

---


--- ULP Missions

    menu.divider(ULP_MISSIONS, "ULP任务")

        local UlpMissionsTable = {
            "情报",
            "反情报",
            "撤离",
            "资产扣押",
            "觅迹行动",
            "清场",
        }
        for i = 1, #UlpMissionsTable do
            menu.action(ULP_MISSIONS, UlpMissionsTable[i], {}, "", function()
                STAT_SET_INT("ULP_MISSION_CURRENT", i - 1)
                STAT_SET_INT("ULP_MISSION_PROGRESS", 127)
            end)
        end

    ---

    menu.divider(ULP_MISSIONS, TRANSLATE("其他"))

        menu.toggle_loop(ULP_MISSIONS, TRANSLATE("跳过黑入"), {}, "[" .. "ULP任务" .. " - " .. "反情报" .. "]", function() -- Thanks for coding this, Pedro9558#3559
            SET_INT_LOCAL("fm_mission_controller_2020", 972 + 135, 3)
        end)
        menu.action(ULP_MISSIONS, "传送到IAA总部", {}, "", function()
            TELEPORT(101.595, -662.923, 45.093)
        end)

    ---

---


--- The Contract: Agency

    local CONTRACT_VIP = menu.list(TH_CONTRACT, TRANSLATE("VIP合约:德瑞博士"), {}, TRANSLATE("要使功能正常运作,你需要注销CEO&摩托帮"), function(); end)

        menu.list_action(CONTRACT_VIP, TRANSLATE("夜生活泄密"), {"hcagcnightlife"}, "", {
            { TRANSLATE("夜总会(前置)"), {"nightclub"} },
            { TRANSLATE("船坞(前置)"), {"marina"} },
            { TRANSLATE("夜生活泄密(任务)"), {"mission"} },
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

        menu.list_action(CONTRACT_VIP, TRANSLATE("上流社会泄密"), {"hcagcsociety"}, "", {
            { TRANSLATE("乡村俱乐部(前置)"), {"club"} },
            { TRANSLATE("宾客名单(前置)"), {"guest"} },
            { TRANSLATE("上流社会(任务)"), {"mission"} },
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

        menu.list_action(CONTRACT_VIP, TRANSLATE("南中心区泄密"), {"hcagccentral"}, TRANSLATE("切换战局应用!"), {
            { TRANSLATE("戴维斯(前置)"), {"davis"} },
            { TRANSLATE("巴勒斯帮会(前置)"), {"ballas"} },
            { TRANSLATE("事务所(任务)"), {"studio"} },
            { TRANSLATE("最终合约:别惹德瑞"), {"final"} },
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

        menu.toggle_loop(TH_CONTRACT, TRANSLATE("修改最终合约收入(200万)"), {"hcagcpay"}, IsWorking(true) .. TRANSLATE("[Locally]"), function()
            SET_INT_GLOBAL(262145 + 31735, 2000000) -- -2108119120
        end, function()
            SET_INT_GLOBAL(262145 + 31735, 1000000)
        end)

        menu.toggle_loop(TH_CONTRACT, TRANSLATE("跳过合约&电话的冷却时间"), {"hcagccoolhit"}, IsWorking(true) .. TRANSLATE("在开始任务前激活."), function() -- Credit goes to Da Chaos#9262
            SET_INT_GLOBAL(262145 + 31689, 0) -- -1462622971
            SET_INT_GLOBAL(262145 + 31753, 0) -- -2036534141
        end, function()
            SET_INT_GLOBAL(262145 + 31689, 300000)
            SET_INT_GLOBAL(262145 + 31753, 500)
        end)

        menu.toggle_loop(TH_CONTRACT, TRANSLATE("移除安全合约冷却时间"), {"hcagcremcool"}, IsWorking(false), function()
            SET_INT_GLOBAL(262145 + 31769, 0) -- 1872071131
        end, function()
            SET_INT_GLOBAL(262145 + 31769, 1200000)
        end)

        menu.action(TH_CONTRACT, TRANSLATE("完成所有任务"), {}, "", function()
            STAT_SET_INT("FIXER_GENERAL_BS", -1)
            STAT_SET_INT("FIXER_COMPLETED_BS", -1)
            STAT_SET_INT("FIXER_STORY_BS", -1)
            STAT_SET_INT("FIXER_STORY_COOLDOWN", -1)
        end)

        menu.action(TH_CONTRACT, TRANSLATE("解锁抢劫奖选"), {}, "", function()
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

        local ARENA_TOOL = menu.list(DLC_UNLOCKER, TRANSLATE("竞技场之战DLC"), {}, "", function(); end)

            menu.action(ARENA_TOOL, TRANSLATE("解锁所有竞技场之战奖杯和玩具"), {}, "", function()
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

            menu.action(ARENA_TOOL, TRANSLATE("竞技场之战服装"), {}, IsWorking(false), function()
                SET_PACKED_INT_GLOBAL(25830, 25897, 1) -- -1782918513, -1597048932
            end)

        ---

        local SUMMER2020 = menu.list(DLC_UNLOCKER, TRANSLATE("2020年夏季DLC"), {}, "", function(); end)
                
            menu.action(SUMMER2020, TRANSLATE("2020年夏季奖选"), {}, "", function()
                STAT_SET_BOOL("AWD_KINGOFQUB3D", true)
                STAT_SET_BOOL("AWD_QUBISM", true)
                STAT_SET_BOOL("AWD_QUIBITS", true)
                STAT_SET_BOOL("AWD_GODOFQUB3D", true)
                STAT_SET_BOOL("AWD_GOFOR11TH", true)
                STAT_SET_BOOL("AWD_ELEVENELEVEN", true)
            end)

            menu.action(SUMMER2020, TRANSLATE("解锁夏季DLC服装"), {}, IsWorking(false), function()
                SET_PACKED_INT_GLOBAL(29673, 29708, 1) -- -1685644799, 1216916542
            end)

        ---

        local TUNERS_DLC = menu.list(DLC_UNLOCKER, TRANSLATE("车友会DLC"), {}, "", function(); end)

            menu.action(TUNERS_DLC, TRANSLATE("解锁车友会服装"), {}, IsWorking(false), function()
                SET_PACKED_INT_GLOBAL(31175, 31197, 1) -- -1888532800, 842355026
                SET_PACKED_INT_GLOBAL(31007, 31013, 1) -- -1578784326, -1342847946
                SET_INT_GLOBAL(2870055, 1) -- freemode.c, STREAMING::REMOVE_ANIM_DICT("MP_WEAPON_DROP");
            end)

            menu.action(TUNERS_DLC, TRANSLATE("解锁奖项"), {}, "", function()
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

        local CONTRACT_DLC = menu.list(DLC_UNLOCKER, TRANSLATE("合约DLC" ), {}, "", function(); end)

            menu.action(CONTRACT_DLC, TRANSLATE("解锁动物面具"), {}, IsWorking(false), function()
                SET_PACKED_INT_GLOBAL(31842, 31853, 1) -- 1322343910, -1255995444
            end)
            menu.action(CONTRACT_DLC, TRANSLATE("解锁DJ小熊衬衫"), {}, IsWorking(false), function()
                SET_PACKED_INT_GLOBAL(31854, 31856, 1) -- -2066580907, -1668169283
            end)

        ---

        local CRIMINAL_DLC = menu.list(DLC_UNLOCKER, "犯罪集团DLC", {}, "", function(); end) -- https://www.unknowncheats.me/forum/3492512-post53.html
            
            menu.action(CRIMINAL_DLC, "夹克/毛衣/连帽衫/衬衫", {}, IsWorking(false), function()
                SET_PACKED_INT_GLOBAL(32817, 32824, 1)
                SET_PACKED_INT_GLOBAL(32840, 32845, 1)
            end)
            menu.action(CRIMINAL_DLC, "裤子/制服帽/帽子", {}, IsWorking(false), function()
                SET_INT_GLOBAL(262145 + 32823, 1)
                SET_PACKED_INT_GLOBAL(32827, 32829, 1)
                SET_PACKED_INT_GLOBAL(32846, 32847, 1)
                SET_PACKED_INT_GLOBAL(32898, 32911, 1)
                SET_PACKED_INT_GLOBAL(33559, 33567, 1)
            end)
            menu.action(CRIMINAL_DLC, "耳机/面具/科技恶魔", {}, IsWorking(false), function()
                SET_INT_GLOBAL(262145 + 32839, 1)
                SET_PACKED_INT_GLOBAL(32912, 32923, 1)
                SET_PACKED_INT_GLOBAL(32832, 32837, 1)
                SET_PACKED_INT_GLOBAL(32852, 32860, 1)
                SET_PACKED_INT_GLOBAL(32864, 32867, 1)
                SET_PACKED_INT_GLOBAL(32868, 32893, 1)
            end)
            menu.action(CRIMINAL_DLC, "鞋子(滑轮)/老虎", {}, IsWorking(false), function()
                SET_PACKED_INT_GLOBAL(32894, 32897, 1)
                SET_PACKED_INT_GLOBAL(32924, 32947, 1)
            end)
            
        ---

    ---

    local UNLOCKER_BUILDING = menu.list(MASTER_UNLOCKR, TRANSLATE("建筑物"), {}, "", function(); end)

        local ARCADE_TOOL = menu.list(UNLOCKER_BUILDING, TRANSLATE("游戏厅解锁"), {}, "", function(); end)

            menu.action(ARCADE_TOOL, TRANSLATE("解锁游戏厅奖杯和玩具"), {}, "", function()
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

            menu.action(ARCADE_TOOL, TRANSLATE("解锁游戏厅服装"), {}, IsWorking(false), function()
                SET_PACKED_INT_GLOBAL(28304, 28324, 1) -- 1380945288, -2029732713
            end)

        ---

        menu.action(UNLOCKER_BUILDING, TRANSLATE("解锁夜总会奖选"), {}, "", function()
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

        menu.action(UNLOCKER_BUILDING, TRANSLATE("赌场商店王牌面具"), {}, IsWorking(true) .. "点击解锁后.切换战局就可以购买了.", function()
            SET_PACKED_INT_GLOBAL(27518, 27521, 1) -- -425372143, 1422194221
        end)

        menu.action(UNLOCKER_BUILDING, TRANSLATE("添加装饰物到办公室/摩托帮"), {}, "点击后切换战局随便售卖一个板条箱或特殊载具!", function()
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

    local UNLOCKER_MISSIONS = menu.list(MASTER_UNLOCKR, TRANSLATE("任务"), {}, "", function(); end)

        menu.action(UNLOCKER_MISSIONS, TRANSLATE("佩里科岛解锁"), {}, IsWorking(false), function()
            SET_PACKED_INT_GLOBAL(30197, 30220, 1) -- 433014829, 1014784742
            SET_PACKED_INT_GLOBAL(30226, 30265, 1) -- -38929647, 1052683033
            SET_PACKED_INT_GLOBAL(30270, 30289, 1) -- -2141771850, -1871460122
            SET_PACKED_INT_GLOBAL(30854, 30889, 1) -- 92877911, -1993561101
            SET_PACKED_INT_GLOBAL(30899, 30904, 1) -- -312057690, 265922985
        end)

        menu.action(UNLOCKER_MISSIONS, TRANSLATE("解锁游艇任务"), {}, "", function()
            STAT_SET_INT("YACHT_MISSION_PROG", 0)
            STAT_SET_INT("YACHT_MISSION_FLOW", 21845)
            STAT_SET_INT("CASINO_DECORATION_GIFT_1", -1)
        end)

        menu.action(UNLOCKER_MISSIONS, TRANSLATE("解锁所有联系人"), {}, "", function()
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

        menu.action(UNLOCKER_MISSIONS, TRANSLATE("跳过拉马任务到最后一项"), {}, TRANSLATE("切换战局应用!"), function()
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

    local UNLOCKER_ANNIVERSARY = menu.list(MASTER_UNLOCKR, TRANSLATE("周年纪念日"), {}, "", function(); end)

        local XMAS_FEATURES = menu.list(UNLOCKER_ANNIVERSARY, TRANSLATE("圣诞节"), {}, "", function(); end)

            menu.toggle_loop(XMAS_FEATURES, TRANSLATE("圣诞服装"), {"hcxmas"}, IsWorking(true) .. TRANSLATE("始终激活才可以穿戴!"), function()
                SET_PACKED_INT_GLOBAL(9392, 9399, 0) -- joaat("disable_snowballs"), -1810184402
                SET_PACKED_INT_GLOBAL(9400, 9401, 7) -- joaat("max_number_of_snowballs"), joaat("pick_up_number_of_snowballs")
            end)
            
            menu.action(XMAS_FEATURES, TRANSLATE("解锁圣诞涂装"), {}, "", function()
                STAT_SET_INT("MPPLY_XMASLIVERIES1", -1)
                STAT_SET_INT("MPPLY_XMASLIVERIES2", -1)
                STAT_SET_INT("MPPLY_XMASLIVERIES3", -1)
                STAT_SET_INT("MPPLY_XMASLIVERIES4", -1)
                STAT_SET_INT("MPPLY_XMASLIVERIES5", -1)
                STAT_SET_INT("MPPLY_XMASLIVERIES6", -1)
                STAT_SET_INT("MPPLY_XMASLIVERIES7", -1)
                STAT_SET_INT("MPPLY_XMASLIVERIES8", -1)
                STAT_SET_INT("MPPLY_XMASLIVERIES9", -1)
                STAT_SET_INT("MPPLY_XMASLIVERIES10", -1)
                STAT_SET_INT("MPPLY_XMASLIVERIES11", -1)
                STAT_SET_INT("MPPLY_XMASLIVERIES12", -1)
                STAT_SET_INT("MPPLY_XMASLIVERIES13", -1)
                STAT_SET_INT("MPPLY_XMASLIVERIES14", -1)
                STAT_SET_INT("MPPLY_XMASLIVERIES15", -1)
                STAT_SET_INT("MPPLY_XMASLIVERIES16", -1)
                STAT_SET_INT("MPPLY_XMASLIVERIES17", -1)
                STAT_SET_INT("MPPLY_XMASLIVERIES18", -1)
                STAT_SET_INT("MPPLY_XMASLIVERIES19", -1)
                STAT_SET_INT("MPPLY_XMASLIVERIES20", -1)
            end)

            menu.action(XMAS_FEATURES, TRANSLATE("解锁圣诞节内容"), {}, IsWorking(false), function()
                SET_PACKED_INT_GLOBAL(9392, 9401, 1) -- joaat("disable_snowballs"), joaat("pick_up_number_of_snowballs")
                SET_PACKED_INT_GLOBAL(9448, 9450, 1) -- joaat("toggle_christmas_eve_gift"), joaat("toggle_new_years_day_gift")
                SET_PACKED_INT_GLOBAL(12707, 12708, 1) -- joaat("XMAS2015_VEHICLE"), -452612879
                SET_PACKED_INT_GLOBAL(12813, 12816, 1) -- joaat("toggle_2015_christmas_eve_gift"), joaat("toggle_2015_christmas_day_gift")
                SET_PACKED_INT_GLOBAL(19160, 19163, 1) -- joaat("toggle_2016_christmas_eve_gift"), joaat("toggle_2016_christmas_day_gift")
                SET_PACKED_INT_GLOBAL(23435, 23443, 1) -- 1840129338, -495986083
                SET_PACKED_INT_GLOBAL(23462, 23465, 1) -- -101086705, -1663567610
                SET_PACKED_INT_GLOBAL(25822, 25824, 1) -- 1975465829, -146321616
                SET_PACKED_INT_GLOBAL(25826, 25829, 1) -- joaat("toggle_2018_christmas_eve_gift"), joaat("toggle_2018_christmas_day_gift")
                SET_PACKED_INT_GLOBAL(28678, 28681, 1) -- joaat("toggle_2019_christmas_eve_gift"), joaat("toggle_2019_christmas_day_gift")
                SET_PACKED_INT_GLOBAL(31744, 31745, 1) -- 1073486652, -1378428735
                SET_INT_GLOBAL(262145 + 4762, 1) -- joaat("toggle_xmas_content")
                SET_INT_GLOBAL(262145 + 9184, 1) -- joaat("toggle_gift_to_player_when_logging_on")
                SET_INT_GLOBAL(262145 + 12710, 1) -- 1247240781
                SET_INT_GLOBAL(262145 + 19301, 1) -- joaat("christmas2016_clothing")
                SET_INT_GLOBAL(262145 + 23084, 1) -- joaat("christmas2017_clothing")
                SET_INT_GLOBAL(262145 + 24231, 1) -- -1029230616
                SET_INT_GLOBAL(262145 + 30890, 1) -- 950317171
            end)

        ---

        menu.toggle_loop(UNLOCKER_ANNIVERSARY, TRANSLATE("独立日"), {}, IsWorking(false), function()
            SET_PACKED_INT_GLOBAL(8267, 8273, 1) -- joaat("independence_day_deactivate_fireworks_launcher"), joaat("Toggle_activate_Monster_truck") 
            SET_PACKED_INT_GLOBAL(8296, 8302, 1) -- joaat("unlockindependence_beer_hat_1"), joaat("unlockindependence_statue_happiness_shirt")
            SET_INT_GLOBAL(262145 + 8258, 1) -- joaat("toggle_activate_independence_pack")
        end)

        menu.action(UNLOCKER_ANNIVERSARY, TRANSLATE("情人节"), {}, IsWorking(false), function()
            SET_PACKED_INT_GLOBAL(12027, 12031, 1) -- joaat("TURN_ON_VALENTINE_WEAPON"), joaat("TURN_ON_VALENTINE_CLOTHING")
            SET_PACKED_INT_GLOBAL(13393, 13394, 1) -- joaat("TURN_ON_VALENTINE_2016_CLOTHING"), joaat("TURN_ON_VALENTINE_2016_VEHICLE")
            SET_INT_GLOBAL(262145 + 7058, 1) -- joaat("TURN_ON_VALENTINES_EVENT")
        end)

    ---

    local UNLOCKER_SHIRT_HAT = menu.list(MASTER_UNLOCKR, TRANSLATE("服装"), {}, "", function(); end)
    
        menu.action(UNLOCKER_SHIRT_HAT, TRANSLATE("解锁帽子和很多衬衫"), {}, IsWorking(false), function()
            SET_PACKED_INT_GLOBAL(11952, 11961, 1) -- joaat("dlc_shirt_meltdown"), joaat("dlc_shirt_capolavoro")
            SET_PACKED_INT_GLOBAL(12588, 12610, 1) -- 340737912, -677479510
            SET_PACKED_INT_GLOBAL(15219, 15233, 1) -- -1787967139, 729622893
            SET_PACKED_INT_GLOBAL(16839, 16845, 1) -- -11411245, -475481933
            SET_PACKED_INT_GLOBAL(17580, 17601, 1) -- -1422129266, 310744591
            SET_PACKED_INT_GLOBAL(21153, 21191, 1) -- joaat("award_black_ammunation_cap"), 1389326679
            SET_PACKED_INT_GLOBAL(24232, 24258, 1) -- 442763143, -551933864
            SET_PACKED_INT_GLOBAL(24732, 24740, 1) -- 1652837933, -359066225
            SET_PACKED_INT_GLOBAL(24772, 24791, 1) -- 970577296, -1201184054
            SET_PACKED_INT_GLOBAL(24946, 24969, 1) -- -726113206, -1910486921
            SET_PACKED_INT_GLOBAL(25898, 25907, 1) -- -1344369866, 1799248495
            SET_PACKED_INT_GLOBAL(27015, 27021, 1) -- 760292630, 1007326524
            SET_PACKED_INT_GLOBAL(30221, 30225, 1) -- 630881878, 1495295329
            SET_PACKED_INT_GLOBAL(31854, 31856, 1) -- -2066580907, -1668169283
            SET_INT_GLOBAL(262145 + 25698, 1) -- -1519472948

            for i = 31768, 32273 do
                STAT_SET_PACKED_BOOL(i, 1) -- freemode.c, https://www.unknowncheats.me/forum/3196991-post328.html
            end
        end)

        menu.action(UNLOCKER_SHIRT_HAT, "解锁大脚怪服装", {}, IsWorking(false), function() -- https://www.unknowncheats.me/forum/3492512-post53.html
            SET_INT_GLOBAL(262145 + 32848, 1) -- -1966279346
        end)

        menu.action(UNLOCKER_SHIRT_HAT, TRANSLATE("解锁不要越线T恤"), {}, IsWorking(false), function()
            STAT_SET_INT("DCTL_WINS", 500)
            STAT_SET_INT("DCTL_PLAY_COUNT", 750)
        end)

    ---

    local UNLOCKER_VEHICLE = menu.list(MASTER_UNLOCKR, TRANSLATE("载具"), {}, "", function(); end)

        menu.action(UNLOCKER_VEHICLE, TRANSLATE("解锁部分载具交易价格"), {}, "", function()
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

        menu.action(UNLOCKER_VEHICLE, TRANSLATE("解锁圣太郎"), {}, "", function()
            STAT_SET_INT("CRDEADLINE", -1)
        end)

    ---

    local SPECIAL_WEAPON = menu.list(MASTER_UNLOCKR, TRANSLATE("武器"), {}, "", function(); end)

        menu.action(SPECIAL_WEAPON, "M16卡宾枪", {}, IsWorking(false), function()
            SET_INT_GLOBAL(262145 + 32775, 1) -- https://www.unknowncheats.me/forum/3488328-post27.html
        end)
        menu.action(SPECIAL_WEAPON, TRANSLATE("石斧"), {}, "", function()
            STAT_SET_BOOL("MPPLY_MELEECHLENGECOMPLETED", true)
        end)
        menu.action(SPECIAL_WEAPON, TRANSLATE("双动式左轮手枪"), {}, "", function()
            STAT_SET_BOOL("MPPLY_HEADSHOTCHLENGECOMPLETED", true)
        end)
        menu.action(SPECIAL_WEAPON, TRANSLATE("海军左轮手枪"), {}, "", function()
            STAT_SET_BOOL("MPPLY_NAVYREVOLVERCOMPLETED", true)
        end)
        menu.action(SPECIAL_WEAPON, TRANSLATE("原子能枪"), {}, IsWorking(false), function()
            SET_INT_GLOBAL(103375, 90) -- freemode.c, joaat("weapon_raypistol"), -1, 0
        end)

    ---

    menu.action(MASTER_UNLOCKR, TRANSLATE("香草独角兽奖"), {}, "", function()
        STAT_SET_INT("LAP_DANCED_BOUGHT", 0)
        STAT_SET_INT("LAP_DANCED_BOUGHT", 5)
        STAT_SET_INT("LAP_DANCED_BOUGHT", 10)
        STAT_SET_INT("LAP_DANCED_BOUGHT", 15)
        STAT_SET_INT("LAP_DANCED_BOUGHT", 25)
        STAT_SET_INT("PROSTITUTES_FREQUENTED", 1000)
    end)

    menu.action(MASTER_UNLOCKR, TRANSLATE("外星人纹身(光明会)"), {}, TRANSLATE("切换战局应用!"), function()
        STAT_SET_INT("TATTOO_FM_CURRENT_32", -1)
    end)

    menu.action(MASTER_UNLOCKR, TRANSLATE("回归奖金"), {}, IsWorking(false), function()
        SET_INT_GLOBAL(152259, 2) -- freemode.c, STATS::STAT_GET_INT(joaat("sp_unlock_exclus_content"), &iVar0, -1);
        SET_INT_GLOBAL(103376, 1) -- freemode.c, joaat("component_raypistol_varmod_xmas18"), joaat("weapon_raypistol"), -1
    end)

---


--- Tools

    local TUNABLES = menu.list(TOOLS, TRANSLATE("可调参数"), {}, "", function(); end) -- Almost non-credited global variables from: https://www.unknowncheats.me/forum/3337151-post1560.html

        local TUNABLES_CD = menu.list(TUNABLES, TRANSLATE("移除冷却时间"), {}, "", function(); end)

            menu.divider(TUNABLES_CD, TRANSLATE("补给延迟"))

                menu.toggle_loop(TUNABLES_CD, TRANSLATE("摩托帮业务"), {"hcresupmc"}, IsWorking(false), function()
                    SET_INT_GLOBAL(262145 + 18999, 0) -- 728170457
                end, function()
                    SET_INT_GLOBAL(262145 + 18999, 600)
                end)
                
                menu.toggle_loop(TUNABLES_CD, TRANSLATE("地堡"), {"hcresupbunker"}, IsWorking(false), function()
                    SET_INT_GLOBAL(262145 + 21601, 0) -- -2094564985
                end, function()
                    SET_INT_GLOBAL(262145 + 21601, 600)
                end)

            ---

            menu.divider(TUNABLES_CD, TRANSLATE("购买&出售"))

                menu.toggle_loop(TUNABLES_CD, TRANSLATE("特殊货物"), {"hccoolspecial"}, IsWorking(false), function() 
                    SET_INT_GLOBAL(262145 + 15608, 0) -- Buy, 153204142
                    SET_INT_GLOBAL(262145 + 15609, 0) -- Sell, 1291620941
                end, function()
                    SET_INT_GLOBAL(262145 + 15608, 300000)
                    SET_INT_GLOBAL(262145 + 15609, 1800000)
                end)

                menu.toggle_loop(TUNABLES_CD, TRANSLATE("载具货物"), {"hccoolveh"}, IsWorking(false), function()
                    SET_INT_GLOBAL(262145 + 19359, 0) -- -82707601
                    SET_INT_GLOBAL(262145 + 19727, 0) -- 1 Vehicle, 1001423248
                    SET_INT_GLOBAL(262145 + 19728, 0) -- 2 Vehicles, 240134765
                    SET_INT_GLOBAL(262145 + 19729, 0) -- 3 Vehicles, 1915379148
                    SET_INT_GLOBAL(262145 + 19730, 0) -- 4 Vehicles, -824005590
                end, function()
                    SET_INT_GLOBAL(262145 + 19359, 180000)
                    SET_INT_GLOBAL(262145 + 19727, 1200000)
                    SET_INT_GLOBAL(262145 + 19728, 1680000)
                    SET_INT_GLOBAL(262145 + 19729, 2340000)
                    SET_INT_GLOBAL(262145 + 19730, 2880000)
                end)

                menu.toggle_loop(TUNABLES_CD, TRANSLATE("空运货物"), {"hccoolair"}, IsWorking(false), function()
                    SET_INT_GLOBAL(262145 + 22779, 0) -- Tobacco, Counterfeit Goods, 1278611667
                    SET_INT_GLOBAL(262145 + 22780, 0) -- Animal Materials, Art, Jewelry, -1424847540
                    SET_INT_GLOBAL(262145 + 22781, 0) -- Narcotics, Chemicals, Medical Supplies, -1817541754
                    SET_INT_GLOBAL(262145 + 22782, 0) -- Additional Time per Player, 1722502526
                    SET_INT_GLOBAL(262145 + 22783, 0) -- Sale, -1091356151
                end, function()
                    SET_INT_GLOBAL(262145 + 22779, 120000)
                    SET_INT_GLOBAL(262145 + 22780, 180000)
                    SET_INT_GLOBAL(262145 + 22781, 240000)
                    SET_INT_GLOBAL(262145 + 22782, 60000)
                    SET_INT_GLOBAL(262145 + 22783, 2000)
                end)

            ---

            menu.divider(TUNABLES_CD, TRANSLATE("其他"))

                menu.toggle_loop(TUNABLES_CD, TRANSLATE("委托人工作"), {"hccoolclient"}, IsWorking(false), function()
                    SET_INT_GLOBAL(262145 + 24664, 0) -- Between Jobs, -926426916
                    SET_INT_GLOBAL(262145 + 24665, 0) -- Robbery in Progress, 1733390598
                    SET_INT_GLOBAL(262145 + 24666, 0) -- Data Sweep, 724724668
                    SET_INT_GLOBAL(262145 + 24667, 0) -- Targeted Data, 846317886
                    SET_INT_GLOBAL(262145 + 24668, 0) -- Diamond Shopping, 443623246
                    SET_INT_GLOBAL(262145 + 24670, 0) -- Collectors Pieces, -1203647122, https://www.unknowncheats.me/forum/3496393-post32.html
                    SET_INT_GLOBAL(262145 + 24671, 0) -- Deal Breaker, -1963126951, https://www.unknowncheats.me/forum/3496393-post32.html
                end, function()
                    SET_INT_GLOBAL(262145 + 24664, 300000)
                    SET_INT_GLOBAL(262145 + 24665, 1800000)
                    SET_INT_GLOBAL(262145 + 24666, 1800000)
                    SET_INT_GLOBAL(262145 + 24667, 1800000)
                    SET_INT_GLOBAL(262145 + 24668, 1800000)
                    SET_INT_GLOBAL(262145 + 24670, 600000)
                    SET_INT_GLOBAL(262145 + 24671, 600000)
                end)

                menu.toggle_loop(TUNABLES_CD, TRANSLATE("发射虎鲸导弹"), {"hccoolmissile"}, IsWorking(false), function()
                    SET_INT_GLOBAL(262145 + 30175, 0) -- 729164624
                    SET_INT_GLOBAL(262145 + 30176, 99999) -- 1968456272
                end, function()
                    SET_INT_GLOBAL(262145 + 30175, 60000)
                    SET_INT_GLOBAL(262145 + 30176, 4000)
                end)

                menu.toggle_loop(TUNABLES_CD, "CEO载具", {"hccoolceoveh"}, IsWorking(false), function() -- Credit goes to Professor#4478's Kiddions Lua
                    SET_INT_GLOBAL(262145 + 12829, 0) -- 2092239066
                end, function()
                    SET_INT_GLOBAL(262145 + 12829, 120000)
                end)

            ---

        ---

        local TUNABLES_MUT = menu.list(TUNABLES, TRANSLATE("乘数"), {}, "", function(); end)

            MUT_Input = 1
            menu.slider_float(TUNABLES_MUT, TRANSLATE("乘数"), {"hcmut"}, "", 0, 500000, 100, 100, function(Value)
                MUT_Input = Value / 100
            end)

            menu.divider(TUNABLES_MUT, "XP & AP")

                menu.toggle_loop(TUNABLES_MUT, "XP", {"hcmutxp"}, IsWorking(false), function()
                    SET_FLOAT_GLOBAL(262145 + 1, MUT_Input) -- joaat("XP_MULTIPLIER")
                end, function()
                    SET_FLOAT_GLOBAL(262145 + 1, 1)
                end)
                menu.toggle_loop(TUNABLES_MUT, "AP", {"hcmutap"}, IsWorking(false), function()
                    SET_FLOAT_GLOBAL(262145 + 25914, MUT_Input) -- -1258787971
                end, function()
                    SET_FLOAT_GLOBAL(262145 + 25914, 1)
                end)

            ---

            menu.divider(TUNABLES_MUT, TRANSLATE("车友会"))

                menu.toggle_loop(TUNABLES_MUT, TRANSLATE("街头赛"), {"hcmutstreet"}, IsWorking(false), function()
                    SET_FLOAT_GLOBAL(262145 + 31637, MUT_Input) -- -1755846889
                end, function()
                    SET_FLOAT_GLOBAL(262145 + 31637, 1)
                end)
                menu.toggle_loop(TUNABLES_MUT, TRANSLATE("追逐赛"), {"hcmutpursuit"}, IsWorking(false), function()
                    SET_FLOAT_GLOBAL(262145 + 31638, MUT_Input) -- -1610590555
                end, function()
                    SET_FLOAT_GLOBAL(262145 + 31638, 1)
                end)
                menu.toggle_loop(TUNABLES_MUT, TRANSLATE("争夺赛"), {"hcmutscramble"}, IsWorking(false), function()
                    SET_FLOAT_GLOBAL(262145 + 31639, MUT_Input) -- 1434998920
                end, function()
                    SET_FLOAT_GLOBAL(262145 + 31639, 1)
                end)
                menu.toggle_loop(TUNABLES_MUT, TRANSLATE("2对2赛？"), {"hcmuthth"}, IsWorking(false), function()
                    SET_FLOAT_GLOBAL(262145 + 31640, MUT_Input) -- -813694860
                end, function()
                    SET_FLOAT_GLOBAL(262145 + 31640, 1)
                end)
                menu.toggle_loop(TUNABLES_MUT, TRANSLATE("车友会"), {"hcmutcar"}, IsWorking(false), function()
                    SET_FLOAT_GLOBAL(262145 + 31641, MUT_Input) -- 1819417801
                end, function()
                    SET_FLOAT_GLOBAL(262145 + 31641, 1)
                end)
                menu.toggle_loop(TUNABLES_MUT, TRANSLATE("车友会赛道"), {"hcmuttrack"}, IsWorking(false), function()
                    SET_FLOAT_GLOBAL(262145 + 31642, MUT_Input) -- -679396556
                end, function()
                    SET_FLOAT_GLOBAL(262145 + 31642, 1)
                end)

            ---

        ---

        local TUNABLES_CRATE = menu.list(TUNABLES, TRANSLATE("触发特殊货物任务"), {}, TRANSLATE("购买特殊货物箱只能在恐霸内."), function(); end)

            menu.toggle_loop(TUNABLES_CRATE, TRANSLATE("装饰彩蛋"), {}, IsWorking(false), function()
                SET_INT_GLOBAL(1946111, 1) -- freemode.c, MISC::GET_RANDOM_INT_IN_RANGE(1, 101);
                SET_INT_GLOBAL(1945957, 2) -- freemode.c, Global_1945957 = iVar0;
            end, function()
                SET_INT_GLOBAL(1946111, 0)
            end)
            menu.toggle_loop(TUNABLES_CRATE, TRANSLATE("黄金火神机枪"), {}, IsWorking(false), function()
                SET_INT_GLOBAL(1946111, 1)
                SET_INT_GLOBAL(1945957, 4)
            end, function()
                SET_INT_GLOBAL(1946111, 0)
            end)
            menu.toggle_loop(TUNABLES_CRATE, TRANSLATE("大钻石"), {}, IsWorking(false), function()
                SET_INT_GLOBAL(1946111, 1)
                SET_INT_GLOBAL(1945957, 6)
            end, function()
                SET_INT_GLOBAL(1946111, 0)
            end)
            menu.toggle_loop(TUNABLES_CRATE, TRANSLATE("稀有兽皮"), {}, IsWorking(false), function()
                SET_INT_GLOBAL(1946111, 1)
                SET_INT_GLOBAL(1945957, 7)
            end, function()
                SET_INT_GLOBAL(1946111, 0)
            end)
            menu.toggle_loop(TUNABLES_CRATE, TRANSLATE("电影胶卷"), {}, IsWorking(false), function()
                SET_INT_GLOBAL(1946111, 1)
                SET_INT_GLOBAL(1945957, 8)
            end, function()
                SET_INT_GLOBAL(1946111, 0)
            end)
            menu.toggle_loop(TUNABLES_CRATE, TRANSLATE("稀有怀表"), {}, IsWorking(false), function()
                SET_INT_GLOBAL(1946111, 1)
                SET_INT_GLOBAL(1945957, 9)
            end, function()
                SET_INT_GLOBAL(1946111, 0)
            end)
            
        ---

        local TUNABLES_SEL = menu.list(TUNABLES, TRANSLATE("地堡任务选择"), {}, "", function(); end)
            
            menu.toggle_loop(TUNABLES_SEL, TRANSLATE("[特殊] 触发异形蛋任务"), {}, IsWorking(true) .. "[" .. TRANSLATE("Steal Supplies") .. "]", function()
                SET_INT_GLOBAL(2815059 + 5195 + 344, 20) -- freemode.c, 584112nd line
                STAT_SET_INT("LFETIME_BIKER_BUY_COMPLET5", 1200)
                STAT_SET_INT("LFETIME_BIKER_BUY_UNDERTA5", 1200)
            end)

            menu.divider(TUNABLES_SEL, TRANSLATE("偷窃物资"))

                menu.toggle_loop(TUNABLES_SEL, TRANSLATE("利他教营地"), {}, IsWorking(false), function()
                    SET_INT_GLOBAL(2815059 + 5195 + 344, 1)
                end)
                menu.toggle_loop(TUNABLES_SEL, TRANSLATE("沙丘越野车"), {}, IsWorking(false), function()
                    SET_INT_GLOBAL(2815059 + 5195 + 344, 2)
                end)
                menu.toggle_loop(TUNABLES_SEL, TRANSLATE("防暴警察"), {}, IsWorking(false), function()
                    SET_INT_GLOBAL(2815059 + 5195 + 344, 3)
                end)
                menu.toggle_loop(TUNABLES_SEL, TRANSLATE("矿洞"), {}, IsWorking(false), function()
                    SET_INT_GLOBAL(2815059 + 5195 + 344, 4)
                end)
                menu.toggle_loop(TUNABLES_SEL, TRANSLATE("水电公司"), {}, IsWorking(false), function()
                    SET_INT_GLOBAL(2815059 + 5195 + 344, 5)
                end)
                menu.toggle_loop(TUNABLES_SEL, TRANSLATE("敌对组织"), {}, IsWorking(false), function()
                    SET_INT_GLOBAL(2815059 + 5195 + 344, 6)
                end)
                menu.toggle_loop(TUNABLES_SEL, TRANSLATE("桑库多河"), {}, IsWorking(false), function()
                    SET_INT_GLOBAL(2815059 + 5195 + 344, 7)
                end)
                menu.toggle_loop(TUNABLES_SEL, TRANSLATE("丽莎"), {}, IsWorking(false), function()
                    SET_INT_GLOBAL(2815059 + 5195 + 344, 8)
                end)
                menu.toggle_loop(TUNABLES_SEL, TRANSLATE("梅利威瑟总部"), {}, IsWorking(false), function()
                    SET_INT_GLOBAL(2815059 + 5195 + 344, 9)
                end)
                menu.toggle_loop(TUNABLES_SEL, TRANSLATE("训练场(坦克)"), {}, IsWorking(false), function()
                    SET_INT_GLOBAL(2815059 + 5195 + 344, 10)
                end)
                menu.toggle_loop(TUNABLES_SEL, TRANSLATE("佩罗海滩"), {}, IsWorking(false), function()
                    SET_INT_GLOBAL(2815059 + 5195 + 344, 11)
                end)
                menu.toggle_loop(TUNABLES_SEL, TRANSLATE("乔拉斯普林斯大道"), {}, IsWorking(false), function()
                    SET_INT_GLOBAL(2815059 + 5195 + 344, 12)
                end)
                menu.toggle_loop(TUNABLES_SEL, TRANSLATE("卓布卡拉大街"), {}, IsWorking(false), function()
                    SET_INT_GLOBAL(2815059 + 5195 + 344, 13)
                end)

            ---

            menu.divider(TUNABLES_SEL, TRANSLATE("出售武器"))

                menu.toggle_loop(TUNABLES_SEL, TRANSLATE("HVY叛乱皮卡"), {}, IsWorking(false), function()
                    SET_INT_GLOBAL(2815059 + 5195 + 344, 14)
                end)
                menu.toggle_loop(TUNABLES_SEL, TRANSLATE("HVY叛乱分子(普通)"), {}, IsWorking(false), function()
                    SET_INT_GLOBAL(2815059 + 5195 + 344, 15)
                end)
                menu.toggle_loop(TUNABLES_SEL, TRANSLATE("马绍尔"), {}, IsWorking(false), function()
                    SET_INT_GLOBAL(2815059 + 5195 + 344, 16)
                end)
                menu.toggle_loop(TUNABLES_SEL, TRANSLATE("HVY叛乱皮卡(定制)"), {}, IsWorking(false), function()
                    SET_INT_GLOBAL(2815059 + 5195 + 344, 17)
                end)
                menu.toggle_loop(TUNABLES_SEL, TRANSLATE("尖锥魅影"), {}, IsWorking(false), function()
                    SET_INT_GLOBAL(2815059 + 5195 + 344, 18)
                end)
                menu.toggle_loop(TUNABLES_SEL, TRANSLATE("沙丘FAV"), {}, IsWorking(false), function()
                    SET_INT_GLOBAL(2815059 + 5195 + 344, 19)
                end)

            ---

        ---

        local TUNABLES_RSU = menu.list(TUNABLES, TRANSLATE("移除其他费用"), {}, "", function(); end)

            menu.toggle_loop(TUNABLES_RSU, TRANSLATE("维修载具货物"), {"hcremcostveh"}, IsWorking(true) .. TRANSLATE("出售载具时,阻止支付维修费用."), function() 
                SET_INT_GLOBAL(262145 + 19706, 0) -- Top, 681515537
                SET_INT_GLOBAL(262145 + 19707, 0) -- Mid, -567224847
                SET_INT_GLOBAL(262145 + 19708, 0) -- Standard, 2100161424
            end, function()
                SET_INT_GLOBAL(262145 + 19706, 34000)
                SET_INT_GLOBAL(262145 + 19707, 21250)
                SET_INT_GLOBAL(262145 + 19708, 12750)
            end)

            menu.toggle_loop(TUNABLES_RSU, TRANSLATE("移除罗恩空运货物份额"), {"hcremcostron"}, IsWorking(false), function()
                SET_FLOAT_GLOBAL(262145 + 22821, 0) -- 1232447926
            end, function()
                SET_FLOAT_GLOBAL(262145 + 22821, 0.025)
            end)

            menu.toggle_loop(TUNABLES_RSU, TRANSLATE("移除托尼夜总会的份额"), {"hcremcosttony"}, IsWorking(false), function() -- https://www.unknowncheats.me/forum/3347568-post13086.html
                SET_FLOAT_GLOBAL(262145 + 24524, 0) -- -1002770353
            end, function()
                SET_FLOAT_GLOBAL(262145 + 24524, 0.1)
            end)

            menu.toggle_loop(TUNABLES_RSU, TRANSLATE("补给摩托帮业务"), {"hcremcostresupmc"}, IsWorking(true) .. "在访问笔记本前激活!", function()
                SET_INT_GLOBAL(262145 + 18998, 1000) -- joaat("BIKER_PURCHASE_SUPPLIES_COST_PER_SEGMENT")
            end, function()
                SET_INT_GLOBAL(262145 + 18998, 15000)
            end)

            menu.toggle_loop(TUNABLES_RSU, TRANSLATE("补给地堡"), {"hcremcostresupbunker"}, IsWorking(true) .. "在访问笔记本前激活!", function()
                SET_INT_GLOBAL(262145 + 21599, 1000) -- 970448219
                SET_INT_GLOBAL(262145 + 21600, 1000) -- 262971166
            end, function()
                SET_INT_GLOBAL(262145 + 21599, 15000)
                SET_INT_GLOBAL(262145 + 21600, 15000)
            end)

            menu.toggle_loop(TUNABLES_RSU, "改变外观", {}, IsWorking(false), function() -- Tbh, an idea from Kiddions mod menu, but, found by me in decompiled script
                SET_INT_GLOBAL(262145 + 19155, 0) -- 1533055729, am_pi_menu.c, 0, "PIM_FREE", (0 + iVar6), bVar1, 0, 0, 0
            end, function()
                SET_INT_GLOBAL(262145 + 19155, 100000)
            end)

            menu.toggle_loop(TUNABLES_RSU, "重命名CEO/摩托帮", {}, IsWorking(false), function() -- https://www.unknowncheats.me/forum/grand-theft-auto-v/500059-globals-locals-discussion-read-page-1-a-2.html#post3496393
                SET_INT_GLOBAL(262145 + 15946, 0) -- 1901455739
                SET_INT_GLOBAL(262145 + 16824, 0) -- -89259989
                SET_INT_GLOBAL(262145 + 18073, 0) -- -1069516318
            end, function()
                SET_INT_GLOBAL(262145 + 15946, 50000)
                SET_INT_GLOBAL(262145 + 16824, 5000)
                SET_INT_GLOBAL(262145 + 18073, 50000)
            end)

            menu.toggle_loop(TUNABLES_RSU, "CEO技能" .. " & ".. "CEO载具", {}, IsWorking(false), function() -- Credit goes to Professor#4478's Kiddions Lua
                SET_PACKED_INT_GLOBAL(12839, 12848, 0) -- 51567061, -1972817298
                SET_PACKED_INT_GLOBAL(16023, 16028, 0) -- -1451871600, 1289619793
                SET_INT_GLOBAL(262145 + 15945, 0) -- -939028485
                SET_INT_GLOBAL(262145 + 19347, 0) -- 2052581897
                SET_INT_GLOBAL(262145 + 19349, 0) -- -1333531254
            end, function()
                SET_PACKED_INT_GLOBAL(12840, 12842, 5000) -- 15263926, -400440420
                SET_PACKED_INT_GLOBAL(16026, 16028, 5000) -- -679448434, 1289619793
                SET_INT_GLOBAL(262145 + 12839, 20000) -- 51567061
                SET_INT_GLOBAL(262145 + 12843, 25000) -- -1560965224
                SET_INT_GLOBAL(262145 + 12844, 1000) -- 2096833423
                SET_INT_GLOBAL(262145 + 12845, 1500) -- -688609610
                SET_INT_GLOBAL(262145 + 12846, 1000) -- 153241568
                SET_INT_GLOBAL(262145 + 12847, 12000) -- 813006152
                SET_INT_GLOBAL(262145 + 12848, 15000) -- -1972817298
                SET_INT_GLOBAL(262145 + 15945, 5000) -- -939028485
                SET_INT_GLOBAL(262145 + 16023, 10000) -- -1451871600
                SET_INT_GLOBAL(262145 + 16024, 7000) -- 650824488
                SET_INT_GLOBAL(262145 + 16025, 9000) -- 253623806
                SET_INT_GLOBAL(262145 + 19347, 5000) -- 2052581897
                SET_INT_GLOBAL(262145 + 19349, 10000) -- -1333531254
            end)
            
        ---

        local TUNABLES_CAH = menu.list(TUNABLES, "赌场服务:筹码" .. " " .. TRANSLATE("[风险]"), {}, "每天购买的筹码不得超过150万(实时).否则,有概率封号!", function(); end)

            util.create_tick_handler(function()
                if IsWorking(false) == "" then
                    if GET_INT_GLOBAL(1853348 + 1 + players.user() * 834 + 267 + 384) == 0 then -- Found by me, freemode.c or casino_slots.c
                        CasinoMembership = "Normal"
                    else
                        CasinoMembership = "VIP"
                    end
                else
                    CasinoMembership = "N/A"
                end
            end)

            local CAHAmount = 0
            menu.slider(TUNABLES_CAH, "筹码数量", {"hccahservice"}, "", INT_MIN, INT_MAX, 0, 10000, function(Value)
                CAHAmount = Value
            end)

            menu.divider(TUNABLES_CAH, "赌场服务:筹码" .. " " .. TRANSLATE("[风险]"))

                menu.action(TUNABLES_CAH, "筹码交易", {}, IsWorking(false), function()
                    SET_INT_GLOBAL(262145 + 26968, CAHAmount) -- 363132936
                end, function()
                    SET_INT_GLOBAL(262145 + 26968, 1)
                end)

                menu.action(TUNABLES_CAH, "最大筹码", {}, IsWorking(false), function()
                    if CasinoMembership == "Normal" then
                        SET_INT_GLOBAL(262145 + 26969, CAHAmount) -- -1679646912
                    elseif CasinoMembership == "VIP" then
                        SET_INT_GLOBAL(262145 + 26969, CAHAmount)
                    end
                end, function()
                    if CasinoMembership == "Normal" then
                        SET_INT_GLOBAL(262145 + 26970, 20000) -- 1136733337
                    elseif CasinoMembership == "VIP" then
                        SET_INT_GLOBAL(262145 + 26970, 50000)
                    end
                end)

            ---

            menu.divider(TUNABLES_CAH, TRANSLATE("其他"))

                menu.toggle_loop(TUNABLES_CAH, "移除购买筹码的冷却时间", {}, "如果你启用这个,将移除购买筹码的冷却时间.", function()
                    STAT_SET_INT("MPPLY_CASINO_CHIPS_PUR_GD", 0)
                    STAT_SET_INT("MPPLY_CASINO_CHIPS_PURTIM", 0)
                end)

                CASINO_MEMBERSHIP = menu.action_slider(TUNABLES_CAH, "更改赌场会员资格", {}, IsWorking(true) .. "你的赌场会员资格: " .. CasinoMembership, {
                    "普通",
                    "VIP",
                }, function(Index)
                    SET_INT_GLOBAL(1853348 + 1 + players.user() * 834 + 267 + 384, Index - 1)
                    util.yield()
                    menu.set_help_text(CASINO_MEMBERSHIP, "Your Membership of Casino: " .. CasinoMembership)
                end)

                menu.action(TUNABLES_CAH, "再次获得访客奖励", {}, "切换战局应用!", function()
                    STAT_SET_INT("MPPLY_CHIPS_COL_TIME", 0)
                end)

            ---

        ---

        local TUNABLES_OTH = menu.list(TUNABLES, TRANSLATE("其他"), {}, "", function(); end)

            menu.toggle_loop(TUNABLES_OTH, TRANSLATE("单件摩托帮载具出售"), {"hcsinglemcveh"}, IsWorking(true) .. TRANSLATE("摩托帮载具出售始终为一辆."), function() -- https://github.com/Tgamer500/YiffWarePWLua/blob/main/YiffWarePW.lua
                if GET_INT_LOCAL("gb_biker_contraband_sell", 696 + 17) ~= 0 then
                    SET_INT_LOCAL("gb_biker_contraband_sell", 696 + 17, 0)
                end
            end)

            menu.toggle_loop(TUNABLES_OTH, "自动补充零食&护甲", {}, "", function()
                STAT_SET_INT("NO_BOUGHT_YUM_SNACKS", 30)
                STAT_SET_INT("NO_BOUGHT_HEALTH_SNACKS", 15)
                STAT_SET_INT("NO_BOUGHT_EPIC_SNACKS", 15)
                STAT_SET_INT("NUMBER_OF_ORANGE_BOUGHT", 10)
                STAT_SET_INT("NUMBER_OF_BOURGE_BOUGHT", 10)
                STAT_SET_INT("CIGARETTES_BOUGHT", 10)
                STAT_SET_INT("MP_CHAR_ARMOUR_1_COUNT", 10)
                STAT_SET_INT("MP_CHAR_ARMOUR_2_COUNT", 10)
                STAT_SET_INT("MP_CHAR_ARMOUR_3_COUNT", 10)
                STAT_SET_INT("MP_CHAR_ARMOUR_4_COUNT", 10)
                STAT_SET_INT("MP_CHAR_ARMOUR_5_COUNT", 10)
            end)

            menu.toggle_loop(TUNABLES_OTH, TRANSLATE("让一种零食回满血"), {}, IsWorking(true) .. TRANSLATE("无论你吃的是什么零食,一份就回满血."), function()
                SET_FLOAT_GLOBAL(262145 + 112, 99999) -- Ps & Qs, joaat("PSANDQS_HEALTH_REPLENISH_MULTIPLIER")
                SET_FLOAT_GLOBAL(262145 + 113, 99999) -- Egochaser, joaat("EGOCHASER_HEALTH_REPLENISH_MULTIPLIER"
                SET_FLOAT_GLOBAL(262145 + 114, 99999) -- Meteorite, joaat("METEORITE_HEALTH_REPLENISH_MULTIPLIER")
                SET_FLOAT_GLOBAL(262145 + 115, 99999) -- Redwood, joaat("REDWOOD_HEALTH_DEPLETE_MULTIPLIER")
                SET_FLOAT_GLOBAL(262145 + 116, 99999) -- eCola, joaat("ORANGOTANG_HEALTH_REPLENISH_MULTIPLIER")
                SET_FLOAT_GLOBAL(262145 + 117, 99999) -- joaat("BOURGEOIX_HEALTH_REPLENISH_MULTIPLIER")
                SET_FLOAT_GLOBAL(262145 + 118, 99999) -- 1405423594
            end, function()
                SET_FLOAT_GLOBAL(262145 + 112, 1)
                SET_FLOAT_GLOBAL(262145 + 113, 1)
                SET_FLOAT_GLOBAL(262145 + 114, 1)
                SET_FLOAT_GLOBAL(262145 + 115, 1)
                SET_FLOAT_GLOBAL(262145 + 116, 1)
                SET_FLOAT_GLOBAL(262145 + 117, 1)
                SET_FLOAT_GLOBAL(262145 + 118, 1)
            end)

            menu.toggle_loop(TUNABLES_OTH, TRANSLATE("无限石斧力量"), {}, IsWorking(false), function() -- https://www.unknowncheats.me/forum/3484239-post11.html
                SET_FLOAT_GLOBAL(262145 + 25325, 99999) -- Weapon Defense, 2117353658
                SET_FLOAT_GLOBAL(262145 + 25328, 99999) -- Health Recharge Multiplier, 847150217
                SET_FLOAT_GLOBAL(262145 + 25329, 99999) -- Health Recharge Limit, 1172828143
                SET_INT_GLOBAL(262145 + 25330, 99999) -- Duration, 927295469
                SET_INT_GLOBAL(262145 + 25331, 99999) -- Added Duration per Kill, 1080926656
                SET_INT_GLOBAL(262145 + 25332, 0) -- Cooldown, 972932785
            end, function()
                SET_FLOAT_GLOBAL(262145 + 25325, 0.5)
                SET_FLOAT_GLOBAL(262145 + 25328, 2)
                SET_FLOAT_GLOBAL(262145 + 25329, 1)
                SET_INT_GLOBAL(262145 + 25330, 12000)
                SET_INT_GLOBAL(262145 + 25331, 6000)
                SET_INT_GLOBAL(262145 + 25332, 60000)
            end)
        
            menu.action(TUNABLES_OTH, TRANSLATE("7年GTA5游戏时间"), {}, TRANSLATE("让你的账号显示游玩7年时间."), function()
                STAT_SET_INT("MP_PLAYING_TIME", 0)
                STAT_SET_INCREMENT("MP_PLAYING_TIME", (60 * 60 * 24 * 365 * 7) * 1000)
                FORCE_CLOUD_SAVE()
            end)
            
        ---

        menu.slider(TUNABLES, TRANSLATE("自定义金钱移除"), {"hcmoneyrem"}, IsWorking(true) .. TRANSLATE("移除GTA5银行里面的钱"), 0, 2000000000, 5000, 10000, function(Value)
            SET_INT_GLOBAL(262145 + 20333, Value) -- -156036296, https://www.unknowncheats.me/forum/3276092-post3.html
            STAT_SET_PACKED_BOOL(15382, true) -- Makes able to buy the Ballistic Armor
            STAT_SET_PACKED_BOOL(9461, true) -- Makes you have the Ballistic Armor

            menu.trigger_commands("nopimenugrey on")
            if util.is_interaction_menu_open() then
                IA_MENU_OPEN_OR_CLOSE()
            end
            SET_INT_GLOBAL(2789741, 85)
            IA_MENU_OPEN_OR_CLOSE()
            IA_MENU_ENTER(1)

            NOTIFY("因为这个功能是通过请求空投重甲来实现的，所以很快就会在附近掉落空投.")
        end)

    ---

    local AFK_MONEY = menu.list(TOOLS, TRANSLATE("挂机刷钱") .. " " .. TRANSLATE("[风险]"), {}, TRANSLATE("使用的方法是安全的,但是你刷的太多了,可能会被封号.风险自负."), function(); end)

        menu.divider(AFK_MONEY, TRANSLATE("冷却时间[秒]"))

            COOLDOWN_CAYO_BOT = menu.slider(AFK_MONEY, "自动佩岛机器人", {"hctimecpbot"}, "", 1200, 86400, 1200, 60, function(); end)
            COOLDOWN_TIME_TRIAL = menu.slider(AFK_MONEY, TRANSLATE("自动时间挑战赛"), {"hctimetrial"}, "", 1200, 86400, 1200, 60, function(); end)
            COOLDOWN_RIG_SLOT = menu.slider(AFK_MONEY, TRANSLATE("自动老虎机"), {"hctimeautorig"}, "", 1, 86400, 1, 1, function(); end)

        ---

        menu.divider(AFK_MONEY, TRANSLATE("设置"))

            NumberOfPlayingCP = 100
            menu.slider(AFK_MONEY, "自动佩岛机器人循环次数", {"hccpbotnum"}, "", 1, 100, 100, 1, function(Value)
                NumberOfPlayingCP = Value
            end)

            NumberOfLoss = 1
            menu.slider(AFK_MONEY, TRANSLATE("老虎机累积奖金限制比例"), {"hcrigratio"}, "", 1, 100, 1, 1, function(Value)
                NumberOfLoss = Value
            end)

        ---

        menu.divider(AFK_MONEY, TRANSLATE("挂机刷钱") .. " " .. TRANSLATE("[风险]"))

            --- Functions for Auto Cayo Bot
            
                function CP_PRESS_D(Num)
                    for i = 1, Num do
                        PAD._SET_CONTROL_NORMAL(0, 218, 1) 
                        util.yield(120)
                    end
                end
                function CP_PRESS_E(Num)
                    for i = 1, Num do
                        PAD._SET_CONTROL_NORMAL(0, 206, 1) 
                        util.yield(120)
                    end
                end
                function CP_PRESS_ENTER(Num)
                    for i = 1, Num do
                        PAD._SET_CONTROL_NORMAL(0, 201, 1) 
                        util.yield(120)
                    end
                end
                function CP_PRESS_ARROW_UP(Num)
                    for i = 1, Num do
                        PAD._SET_CONTROL_NORMAL(0, 188, 1) 
                        util.yield(120)
                    end
                end
                function CP_PRESS_ARROW_DOWN(Num)
                    for i = 1, Num do
                        PAD._SET_CONTROL_NORMAL(0, 187, 1) 
                        util.yield(120)
                    end
                end
                function CP_PRESS_BACKSPACE(Num)
                    for i = 1, Num do
                        PAD._SET_CONTROL_NORMAL(2, 202, 1) 
                        util.yield(120)
                    end
                end

            ---

            local NumberOfPlayedCP = 0
            menu.toggle_loop(AFK_MONEY, "自动佩岛机器人", {}, IsWorking(true) .. "单人自动佩里科岛抢劫,每20分钟自动完成一次,每次获得209万美元.开启后不要按任何键以免出现BUG.", function() -- An idea and source code from Raid Control for X-Force, but almost tweaked by me.
                if NumberOfPlayingCP >= NumberOfPlayedCP then
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
                        NOTIFY("已请求虎鲸.等待几秒钟.")
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

                    SET_INT_LOCAL("heist_island_planning", 1523, 2) -- Restarts Kosatka PC to apply stats, From https://github.com/atomikfr/CayoPericoHeistAssistant
                    util.yield(1000)
                
                    while GET_INT_GLOBAL(2678393 + 1865) ~= 1 do -- fmmc_launcher.c, If not ready to set planning board
                        util.yield()
                    end
                    util.yield(1000)

                    SET_INT_LOCAL("heist_island_planning", 1430, 2) -- Set planning board loading state
                    while GET_INT_LOCAL("heist_island_planning", 1430) ~= 4 do -- If not planning board has been loaded
                        util.yield()
                    end
                    util.yield(1000)

                    CP_PRESS_E(2)
                    CP_PRESS_D(1)
                    CP_PRESS_ENTER(1)

                    while GET_INT_LOCAL("fmmc_launcher", 15495 + 757) ~= 16 do -- If "LOB_H_FCP" label not loaded
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
                    PAD._SET_CONTROL_NORMAL(2, 201, 1) -- Almost same as CP_PRESS_ENTER(1), but this is for "FRONTEND_CONTROL"
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
                    
                    while GET_INT_GLOBAL(1835497) ~= 1 do -- fmmc_launcher.c
                        util.yield()
                    end
                    util.yield(1000)
                
                    CP_PRESS_ENTER(1)
                    util.yield(2000)
                
                    while GET_INT_LOCAL("fm_mission_controller_2020", 2754) ~= 1 do
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
                    
                    while not HelpMsgBeingDisplayed("QUIT_RS_ALL") do
                        util.yield()
                    end
                    local Command = menu.ref_by_path("Online>Quick Progress>Bad Sport Status>Relinquish")
                    menu.trigger_command(Command)
                    menu.trigger_commands("tpmazehelipad")
                
                    NumberOfPlayedCP = NumberOfPlayedCP + 1
                    NOTIFY("结束战斗!等待冷却时间..." .. "\n\n" .. "你已经抢了多少次: " .. NumberOfPlayedCP)
                    
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

            NumberOfSpin = 0
            menu.toggle_loop(AFK_MONEY, TRANSLATE("自动老虎机"), {"hcautorig"}, IsWorking(false), function() -- https://github.com/jonaaa20/RecoverySuite
                if NumberOfSpin == 0 then
                    PAD._SET_CONTROL_NORMAL(2, 204, 1) -- Press Tab to Bet Max
                    util.yield(100)
                end

                if GET_INT_LOCAL("CASINO_SLOTS", 3394 + 1 + players.user() * 11 + 10) == 0 then -- If not rigging now
                    if NumberOfSpin >= NumberOfLoss then
                        menu.trigger_commands("rigslotmachines jackpot")
                        NumberOfSpin = 0
                    else
                        if NumberOfSpin == 0 then
                            menu.trigger_commands("rigslotmachines loss")
                        end
                        NumberOfSpin = NumberOfSpin + 1
                    end

                    PAD._SET_CONTROL_NORMAL(2, 208, 1) -- Press Tab to Bet Max
                    
                    SET_INT_LOCAL("CASINO_SLOTS", 1631, 8) -- Set as rigging is done

                    while GET_INT_LOCAL("CASINO_SLOTS", 3394 + 1 + players.user() * 11 + 10) ~= 3 do
                        util.yield()
                    end
                    SET_INT_LOCAL("CASINO_SLOTS", 3394 + 1 + players.user() * 11 + 10, 6) -- Skipping animations
                   
                    util.yield(menu.get_value(COOLDOWN_RIG_SLOT) * 1000)
                end
            end, function()
                menu.trigger_commands("rigslotmachines off")
                NumberOfSpin = 0
            end)

            menu.toggle_loop(AFK_MONEY, TRANSLATE("自动阻止杰克"), {"hcautoblackjack"}, "", function() -- Thanks to allow me to use the code, jerry123#4508
                if not (HelpMsgBeingDisplayed('BJACK_BET') or HelpMsgBeingDisplayed('BJACK_TURN') or HelpMsgBeingDisplayed('BJACK_TURN_D') or HelpMsgBeingDisplayed('BJACK_TURN_S')) then 
                    return
                end

                if HelpMsgBeingDisplayed('BJACK_BET') then
                    PAD._SET_CONTROL_NORMAL(2, 204, 1) -- Max Bet
                    PAD._SET_CONTROL_NORMAL(2, 201, 1) -- Bet
                else
                    PAD._SET_CONTROL_NORMAL(2, 203, 1) -- Pass
                end
            end)

            menu.toggle_loop(AFK_MONEY, TRANSLATE("自动时间挑战赛"), {"hcautotrial"}, "", function() -- Tbh, an idea from X-Force, but all coded by me
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
                PAD._SET_CONTROL_NORMAL(2, 51, 1) -- Press E to Start Time Trial
                util.yield(1500)
                menu.trigger_commands("tpobjective")
                util.yield(500)
                entities.delete_by_handle(Veh)

                STAT_SET_INT("MPPLY_TIMETRIAL_COMPLETED_WEEK", -1)
                STAT_SET_INT("MPPLY_RCTTCOMPLETEDWEEK", -1)
                menu.trigger_commands("hctimercustom off")
                util.yield(500)
                menu.trigger_commands("hctimertime " .. menu.get_value(COOLDOWN_TIME_TRIAL))
                menu.trigger_commands("hctimercustom on")
                NOTIFY(TRANSLATE("一次计时结束!等待冷却时间..."))
                util.yield(500)
                while menu.get_value(TIMER_CUSTOM) do
                    util.yield()
                end
            end, function()
                menu.trigger_commands("hctimertime 1200")
                menu.trigger_commands("hctimercustom off")
            end)

            menu.toggle_loop(AFK_MONEY, "自动猎杀专员", {"hcautoheadhunter"}, "可以和你的朋友一起玩.只需要雇佣他." .. "\n\n" .. "如果交易错误,停止使用此功能,然后必须重新启动游戏才可以修复.", function()
                if players.get_boss(players.user()) == -1 then
                    menu.trigger_commands("ceostart")
                    NOTIFY("请求CEO... 等待几秒钟.")
                    util.yield(5000)
                end

                menu.trigger_commands("nopimenugrey on")
                if util.is_interaction_menu_open() then
                    IA_MENU_OPEN_OR_CLOSE()
                end
                SET_INT_GLOBAL(2789741, 29)
                IA_MENU_OPEN_OR_CLOSE()
                IA_MENU_DOWN(8)
                IA_MENU_ENTER(2)

                util.yield(2000)
                menu.trigger_commands("noworkcooldown on") 
                menu.trigger_commands("hcinsfinhh")

                menu.trigger_commands("hctimercustom off")
                NOTIFY("完成一次!等待冷却时间...")
                menu.trigger_commands("hctimertime 300")
                menu.trigger_commands("hctimercustom on")
                while menu.get_value(TIMER_CUSTOM) do
                    util.yield()
                end
            end, function()
                menu.trigger_commands("hctimertime 1200")
                menu.trigger_commands("hctimercustom off")
            end)

            menu.toggle_loop(AFK_MONEY, "自动观光客", {"hcautosightseer"}, IsWorking(true) .. "可以和你的朋友一起玩.只需要雇佣他." .. "\n\n" .. "如果交易错误,停止使用此功能,然后必须重新启动游戏才可以修复.", function()              
                if players.get_boss(players.user()) == -1 then
                    menu.trigger_commands("ceostart")
                    NOTIFY("请求CEO... 等待几秒钟.")
                    util.yield(5000)
                end

                menu.trigger_commands("nopimenugrey on")
                if util.is_interaction_menu_open() then
                    IA_MENU_OPEN_OR_CLOSE()
                end
                SET_INT_GLOBAL(2789741, 29)
                IA_MENU_OPEN_OR_CLOSE()
                IA_MENU_UP(2)
                IA_MENU_ENTER(2)

                util.yield(5000)
                menu.trigger_commands("noworkcooldown on")
                menu.trigger_commands("hcinsfinss")

                menu.trigger_commands("hctimercustom off")
                NOTIFY("完成一次!等待冷却时间...")
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

    local INSTANT_FINISH = menu.list(TOOLS, "即时完成抢劫&其他", {"hcinsfin"}, "", function(); end)

        menu.divider(INSTANT_FINISH, "抢劫")

            menu.action(INSTANT_FINISH, "佩岛/改装铺/ULP/合约", {"hcinsfincp"}, IsWorking(false) .. "请注意在ULP任务/超级游艇/不能启作用", function() -- Done Cayo Perico Heist Instantly: https://www.unknowncheats.me/forum/3472329-post13554.html
                menu.trigger_commands("scripthost")

                SET_INT_LOCAL("fm_mission_controller_2020", 31554 + 6843, 51338752)
                SET_INT_LOCAL("fm_mission_controller_2020", 31554 + 8218, 50)
            end)

            menu.action(INSTANT_FINISH, "赌场气势汹汹/公寓抢劫", {"hcinsfincah"}, IsWorking(false), function()
                menu.trigger_commands("scripthost")
                
                SET_INT_LOCAL("fm_mission_controller", 19679 + 1741, 151)
                SET_INT_LOCAL("fm_mission_controller", 19679 + 2686, 10000000)
                SET_INT_LOCAL("fm_mission_controller", 27440 + 859, 99999)
                SET_INT_LOCAL("fm_mission_controller", 31554 + 69, 99999)
                SET_INT_LOCAL("fm_mission_controller", 31554 + 97, 79)
            end)

            menu.action(INSTANT_FINISH, "末日豪劫", {"hcinsfindooms"}, IsWorking(false), function()
                menu.trigger_commands("scripthost")

                SET_INT_LOCAL("fm_mission_controller", 19679, 12)
                SET_INT_LOCAL("fm_mission_controller", 28298 + 1, 99999)
                SET_INT_LOCAL("fm_mission_controller", 31554 + 69, 99999)
            end)
            
        ---

        menu.divider(INSTANT_FINISH, TRANSLATE("其他"))

            menu.action(INSTANT_FINISH, TRANSLATE("地堡"), {"hcinsfinbk"}, IsWorking(true) .. "[Selling Only]", function() -- https://www.unknowncheats.me/forum/3521137-post39.html
                SET_INT_LOCAL("gb_gunrunning", 1203 + 774, 0)
            end)

            menu.action(INSTANT_FINISH, "猎杀专员", {"hcinsfinhh"}, "", function()
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

            menu.action(INSTANT_FINISH, "观光客", {"hcinsfinss"}, IsWorking(false), function() -- https://www.unknowncheats.me/forum/3488056-post24.html
                SET_INT_LOCAL("gb_sightseer", 247 + 1 + NETWORK.PARTICIPANT_ID_TO_INT() * 6 + 5, 3)
            end)

            menu.action(INSTANT_FINISH, "空运货物", {"hcinsfinac"}, IsWorking(true) .. "[Selling Only]", function() -- https://www.unknowncheats.me/forum/3513482-post37.html
                SET_INT_LOCAL("gb_smuggler", 1926 + 1035, GET_INT_LOCAL("gb_smuggler", 1926 + 1078))
            end)
            
        ---

    ---

    local COOLDOWN_TIMER = menu.list(TOOLS, TRANSLATE("抢劫冷却计时器"), {}, TRANSLATE("当你设定的时间过去后,HC会提示你抢劫冷却时间已过."), function(); end)

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

        menu.divider(COOLDOWN_TIMER, TRANSLATE("设置"))

            local TIMER_POS = menu.list(COOLDOWN_TIMER, TRANSLATE("文本位置"), {}, "", function(); end)

                menu.divider(TIMER_POS, TRANSLATE("抢劫控制"))

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
                        menu.trigger_commands("infotextpos")
                    end)

                ---

            ---

            menu.list_action(COOLDOWN_TIMER, TRANSLATE("文本颜色"), {}, "", {
                { TRANSLATE("抢劫控制") },
                { "Stand" },
            }, function(Index)
                if Index == 1 then
                    menu.trigger_commands("hctimercolor")
                elseif Index == 2 then
                    menu.trigger_commands("hud")
                end
            end)

            menu.toggle(COOLDOWN_TIMER, TRANSLATE("使用Stand信息显示"), {}, TRANSLATE("启用:使用Stand的信息显示&设置: 游戏 > 信息显示") .. "\n\n" .. TRANSLATE("禁用:使用控制抢劫的信息显示&设置"), function(Toggle)
                IsStandOverlay = Toggle
            end)
            menu.slider(COOLDOWN_TIMER, TRANSLATE("设置自定义时间"), {"hctimertime"}, "", 0, 259200, 1200, 60, function(Value)
                TimerCustomTotal, TimerCustomTime = Value, Value
            end)

        ---

        menu.divider(COOLDOWN_TIMER, TRANSLATE("抢劫冷却计时器"))

            TIMER_CAYO = menu.toggle(COOLDOWN_TIMER, TRANSLATE("佩里科岛"), {"hctimercp"}, "", function()
                if not menu.get_value(TIMER_CAYO) then
                    TimerCayoTotal, TimerCayoMin, TimerCayoPlus, TimerCayoSec = 1200, 0, 0, 0
                end

                while menu.get_value(TIMER_CAYO) do
                    if TimerCayoTotal == 0 then
                        NOTIFY(TRANSLATE("佩里科岛") .. " - " .. TRANSLATE("冷却时间过去了,你可以再次开启抢劫了!"))
                        menu.set_value(TIMER_CAYO, false)
                    end
  
                    TimerCayoTotal = TimerCayoTotal - 1
                    TimerCayoMin = math.floor(TimerCayoTotal / 60)
                    TimerCayoPlus = TimerCayoPlus + 1
                    TimerCayoSec = 1200 - TimerCayoMin * 60 - TimerCayoPlus
                    util.yield(1000)
                end
            end)

            TIMER_CASINO = menu.toggle(COOLDOWN_TIMER, TRANSLATE("名钻赌场"), {"hctimercah"}, "", function()
                if not menu.get_value(TIMER_CASINO) then
                    TimerCasinoTotal, TimerCasinoMin, TimerCasinoPlus, TimerCasinoSec = 1200, 0, 0, 0
                end

                while menu.get_value(TIMER_CASINO) do
                    if TimerCasinoTotal == 0 then
                        NOTIFY(TRANSLATE("名钻赌场") .. " - " .. TRANSLATE("冷却时间过去了,你可以再次开启抢劫了!"))
                        menu.set_value(TIMER_CASINO, false)
                    end

                    TimerCasinoTotal = TimerCasinoTotal - 1
                    TimerCasinoMin = math.floor(TimerCasinoTotal / 60)
                    TimerCasinoPlus = TimerCasinoPlus + 1
                    TimerCasinoSec = 1200 - TimerCasinoMin * 60 - TimerCasinoPlus
                    util.yield(1000)
                end
            end)

            TIMER_DOOMS = menu.toggle(COOLDOWN_TIMER, TRANSLATE("末日豪劫"), {"hctimerdooms"}, "", function()
                if not menu.get_value(TIMER_DOOMS) then
                    TimerDoomsTotal, TimerDoomsMin, TimerDoomsPlus, TimerDoomsSec = 1200, 0, 0, 0
                end

                while menu.get_value(TIMER_DOOMS) do
                    if TimerDoomsTotal == 0 then
                        NOTIFY(TRANSLATE("末日豪劫") .. " - " .. TRANSLATE("冷却时间过去了,你可以再次开启抢劫了!"))
                        menu.set_value(TIMER_DOOMS, false)
                    end
                    
                    TimerDoomsTotal = TimerDoomsTotal - 1
                    TimerDoomsMin = math.floor(TimerDoomsTotal / 60)
                    TimerDoomsPlus = TimerDoomsPlus + 1
                    TimerDoomsSec = 1200 - TimerDoomsMin * 60 - TimerDoomsPlus
                    util.yield(1000)
                end
            end)

            TIMER_CLASSIC = menu.toggle(COOLDOWN_TIMER, TRANSLATE("公寓抢劫"), {"hctimerclassic"}, "", function()
                if not menu.get_value(TIMER_CLASSIC) then
                    TimerClassicTotal, TimerClassicMin, TimerClassicPlus, TimerClassicSec = 1200, 0, 0, 0
                end

                while menu.get_value(TIMER_CLASSIC) do
                    if TimerClassicTotal == 0 then
                        NOTIFY(TRANSLATE("公寓抢劫") .. " - " .. TRANSLATE("冷却时间过去了,你可以再次开启抢劫了!"))
                        menu.set_value(TIMER_CLASSIC, false)
                    end

                    TimerClassicTotal = TimerClassicTotal - 1
                    TimerClassicMin = math.floor(TimerClassicTotal / 60)
                    TimerClassicPlus = TimerClassicPlus + 1
                    TimerClassicSec = 1200 - TimerClassicMin * 60 - TimerClassicPlus
                    util.yield(1000)
                end
            end)

            TIMER_ROBBERY = menu.toggle(COOLDOWN_TIMER, TRANSLATE("改装铺合约"), {"hctimerrobbery"}, "", function()
                if not menu.get_value(TIMER_ROBBERY) then
                    TimerRobberyTotal, TimerRobberyMin, TimerRobberyPlus, TimerRobberySec = 1200, 0, 0, 0
                end

                while menu.get_value(TIMER_ROBBERY) do
                    if TimerRobberyTotal == 0 then
                        NOTIFY(TRANSLATE("改装铺合约") .. " - " .. TRANSLATE("冷却时间过去了,你可以再次开启抢劫了!"))
                        menu.set_value(TIMER_ROBBERY, false)
                    end

                    TimerRobberyTotal = TimerRobberyTotal - 1
                    TimerRobberyMin = math.floor(TimerRobberyTotal / 60)
                    TimerRobberyPlus = TimerRobberyPlus + 1
                    TimerRobberySec = 1200 - TimerRobberyMin * 60 - TimerRobberyPlus
                    util.yield(1000)
                end
            end)

            TIMER_AGENCY = menu.toggle(COOLDOWN_TIMER, TRANSLATE("事务所合约"), {"hctimeragency"}, "", function()
                if not menu.get_value(TIMER_AGENCY) then
                    TimerAgencyTotal, TimerAgencyMin, TimerAgencyPlus, TimerAgencySec = 1200, 0, 0, 0
                end

                while menu.get_value(TIMER_AGENCY) do
                    if TimerAgencyTotal == 0 then
                        NOTIFY(TRANSLATE("事务所合约") .. " - " .. TRANSLATE("冷却时间过去了,你可以再次开启抢劫了!"))
                        menu.set_value(TIMER_AGENCY, false)
                    end

                    TimerAgencyTotal = TimerAgencyTotal - 1
                    TimerAgencyMin = math.floor(TimerAgencyTotal / 60)
                    TimerAgencyPlus = TimerAgencyPlus + 1
                    TimerAgencySec = 1200 - TimerAgencyMin * 60 - TimerAgencyPlus
                    util.yield(1000)
                end
            end)

            TIMER_CUSTOM = menu.toggle(COOLDOWN_TIMER, TRANSLATE("定制抢劫"), {"hctimercustom"}, "", function()
                if not menu.get_value(TIMER_CUSTOM) then
                    TimerCustomTotal, TimerCustomMin, TimerCustomPlus, TimerCustomSec = TimerCustomTime, 0, 0, 0
                end

                while menu.get_value(TIMER_CUSTOM) do
                    if TimerCustomTotal == 0 then
                        NOTIFY(TRANSLATE("定制抢劫") .. " - " .. TRANSLATE("冷却时间过去了,你可以再次开启抢劫了!"))
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
                    util.draw_debug_text(TRANSLATE("Custom Heist") .. " [" .. TimerCustomMin .. ":" .. TimerCustomSec .. "]")
                end
            else
                if menu.get_value(TIMER_CAYO) or menu.get_value(TIMER_CASINO) or menu.get_value(TIMER_DOOMS) or menu.get_value(TIMER_CLASSIC) or menu.get_value(TIMER_ROBBERY) or menu.get_value(TIMER_AGENCY) or menu.get_value(TIMER_CUSTOM) then
                    directx.draw_text(TimerPos.X, TimerPos.Y + 0.00, TRANSLATE("Cayo Perico Heist") .. " [" .. TimerCayoMin .. ":" .. TimerCayoSec .. "]", 2, 0.6, TimerRGB, false)
                    directx.draw_text(TimerPos.X, TimerPos.Y + 0.02, TRANSLATE("Diamond Casino Heist") .. " [" .. TimerCasinoMin .. ":" .. TimerCasinoSec .. "]", 2, 0.6, TimerRGB, false)
                    directx.draw_text(TimerPos.X, TimerPos.Y + 0.04, TRANSLATE("Doomsday Heist") .. " [" .. TimerDoomsMin .. ":" .. TimerDoomsSec .. "]", 2, 0.6, TimerRGB, false)
                    directx.draw_text(TimerPos.X, TimerPos.Y + 0.06, TRANSLATE("Classic Heist") .. " [" .. TimerClassicMin .. ":" .. TimerClassicSec .. "]", 2, 0.6, TimerRGB, false)
                    directx.draw_text(TimerPos.X, TimerPos.Y + 0.08, TRANSLATE("LS Tuners Robbery") .. " [" .. TimerRobberyMin .. ":" .. TimerRobberySec .. "]", 2, 0.6, TimerRGB, false)
                    directx.draw_text(TimerPos.X, TimerPos.Y + 0.10, TRANSLATE("The Contract: Agency") .. " [" .. TimerAgencyMin .. ":" .. TimerAgencySec .. "]", 2, 0.6, TimerRGB, false)
                    directx.draw_text(TimerPos.X, TimerPos.Y + 0.12, TRANSLATE("Custom Heist") .. " [" .. TimerCustomMin .. ":" .. TimerCustomSec .. "]", 2, 0.6, TimerRGB, false)
                end
            end
        end)

    ---

    local NEAR_PED_CAM = menu.list(TOOLS, TRANSLATE("管理附近的NPC&摄像头"), {}, "", function(); end)

        menu.divider(NEAR_PED_CAM, TRANSLATE("设置"))
            
            IS_HOSTILE_PED = menu.toggle(NEAR_PED_CAM, TRANSLATE("只对敌对NPC起作用"), {}, TRANSLATE("启用:仅对敌对NPC有效") .. "\n\n" .. TRANSLATE("禁用:适用于所有NPC"), function() end)

        ---

        menu.divider(NEAR_PED_CAM, TRANSLATE("NPC"))

            menu.action(NEAR_PED_CAM, TRANSLATE("移除武器"), {"hcremwepon"}, "", function()
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

            menu.action(NEAR_PED_CAM, TRANSLATE("删除"), {"hcdelped"}, "", function()
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

            menu.action(NEAR_PED_CAM, TRANSLATE("击杀"), {"hckillped"}, "", function()
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

            menu.action(NEAR_PED_CAM, "射击", {"hcshootped"}, "", function() -- Thanks for coding this, Pedro9558#3559
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

        menu.divider(NEAR_PED_CAM, TRANSLATE("摄像头"))

            menu.action(NEAR_PED_CAM, TRANSLATE("删除"), {"hcdelcam"}, "[" .. TRANSLATE("佩里科岛") .. " & " .. TRANSLATE("名钻赌场") .. "]", function()
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

    local BYPASS_DOOR = menu.list(TOOLS, TRANSLATE("绕过上锁门"), {}, "", function(); end)

        menu.divider(BYPASS_DOOR, TRANSLATE("设置"))

            NOCLIP_SPEED = menu.slider(BYPASS_DOOR, TRANSLATE("改善悬浮速度"), {"hcspdhcnoclip"}, "", 1, 100, 10, 5, function(); end)
            DISTANCE_TPTF = menu.slider(BYPASS_DOOR, TRANSLATE("往前传送的距离"), {"hcdishctptf"}, "", 1, 100, 10, 5, function(); end)

        ---

        menu.divider(BYPASS_DOOR, TRANSLATE("绕过上锁门"))

            menu.toggle(BYPASS_DOOR, TRANSLATE("悬浮"), {"hcnoclip"}, "", function(Toggle) -- From Command Box Scripts: No Clip
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
    
            menu.action(BYPASS_DOOR, TRANSLATE("向前TP"), {"hctptf"}, "", function() -- Credit goes to Lancescript
                local Handle = PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) and PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false) or players.user_ped()
                local Pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(Handle, 0, menu.get_value(DISTANCE_TPTF) * 0.1, 0)
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Handle, Pos.x, Pos.y, Pos.z, false, false, false)
            end)

        ---

    ---

    local REQ_SERVICE = menu.list(TOOLS, TRANSLATE("请求服务"), {}, "", function(); end) -- All from decompiled scripts found by me except credited one

        menu.action(REQ_SERVICE, TRANSLATE("机动作战中心"), {"hcreqmoc"}, IsWorking(false), function()
            SET_INT_GLOBAL(2815059 + 913, 1) -- freemode.c, (var uParam0, var uParam1, int* iParam2, int* iParam3, int iParam4, int* iParam5, int* iParam6)
        end)
        menu.action(REQ_SERVICE, TRANSLATE("复仇者"), {"hcreqavenger"}, IsWorking(false), function()
            SET_INT_GLOBAL(2815059 + 921, 1) -- freemode.c, Var112 = { OBJECT::_GET_OBJECT_OFFSET_FROM_COORDS(Param2, fParam5, 0f, -7,5f, 1f) };
        end)
        menu.action(REQ_SERVICE, TRANSLATE("恐霸"), {"hcreqterrobyte"}, IsWorking(false), function()
            SET_INT_GLOBAL(2815059 + 925, 1) -- freemode.c, (var uParam0, var uParam1, int* iParam2, int* iParam3, int iParam4, int* iParam5, int* iParam6)
        end)
        menu.action(REQ_SERVICE, TRANSLATE("虎鲸"), {"hcreqkosatka"}, IsWorking(false), function()
            SET_INT_GLOBAL(2815059 + 933, 1) -- freemode.c, (var uParam0, var uParam1, int* iParam2, int* iParam3, int iParam4, int* iParam5, int* iParam6)
        end)
        menu.action(REQ_SERVICE, TRANSLATE("小艇"), {"hcreqdingy"}, IsWorking(false), function()
            SET_INT_GLOBAL(2815059 + 945, 1) -- freemode.c, (var uParam0, var uParam1, int* iParam2, int* iParam3, int iParam4, int* iParam5, int* iParam6)
        end)
        menu.action(REQ_SERVICE, TRANSLATE("重型防弹装甲"), {"hcreqminigun"}, IsWorking(false), function()
            SET_INT_GLOBAL(2815059 + 884, 1) -- freemode.c, (!NETWORK::NETWORK_IS_SCRIPT_ACTIVE("AM_AMMO_DROP", PLAYER::PLAYER_ID(), true, 0))
        end)
        menu.action(REQ_SERVICE, "喷气机空袭", {"hcreqairstrike"}, IsWorking(false), function() -- https://github.com/Primexz/GTA-Monopol_ModMenu
            SET_INT_GLOBAL(2815059 + 4455, 1) -- am_contact_requests.c
        end)
        menu.action(REQ_SERVICE, "弹药箱", {"hcreqsupply"}, IsWorking(false), function() -- https://github.com/Primexz/GTA-Monopol_ModMenu
            SET_INT_GLOBAL(2815059 + 874, 1) -- am_contact_requests.c
        end)
        menu.action(REQ_SERVICE, "水上皮卡", {"hcreqboatpickup"}, IsWorking(false), function() -- https://github.com/Primexz/GTA-Monopol_ModMenu
            SET_INT_GLOBAL(2815059 + 875, 1) -- am_contact_requests.c
        end)

    ---

    local INFO_SPOOFING = menu.list(TOOLS, TRANSLATE("信息欺骗"), {}, TRANSLATE("切换战局应用!"), function(); end) -- Thanks to help me find this, Anry#4040

        local INFO_SPOOFING_WALLET_MONEY = menu.list(INFO_SPOOFING, "假钱", {}, "", function(); end) -- freemode.c

            menu.toggle_loop(INFO_SPOOFING_WALLET_MONEY, TRANSLATE("启用"), {}, IsWorking(false), function()
                SET_INT_GLOBAL((1853348 + 1 + players.user() * 834) + 205 + 3, menu.get_value(WALLET_MONEY_SPOOFING))
            end, function()
                SET_INT_GLOBAL((1853348 + 1 + players.user() * 834) + 205 + 3, players.get_wallet(players.user()))
            end)

            WALLET_MONEY_SPOOFING = menu.slider(INFO_SPOOFING_WALLET_MONEY, TRANSLATE("数值"), {"hcwalletmoneyspoofing"}, "", INT_MIN, INT_MAX, players.get_wallet(players.user()), 10000, function(); end)

        --- 

        local INFO_SPOOFING_MONEY = menu.list(INFO_SPOOFING, TRANSLATE("金钱总额"), {}, "", function(); end) -- freemode.c, joaat("mpply_most_favorite_station")

            menu.toggle_loop(INFO_SPOOFING_MONEY, TRANSLATE("启用"), {}, IsWorking(false), function()
                SET_INT_GLOBAL((1853348 + 1 + players.user() * 834) + 205 + 56, menu.get_value(TOTAL_MONEY_SPOOFING))
            end, function()
                SET_INT_GLOBAL((1853348 + 1 + players.user() * 834) + 205 + 56, players.get_money(players.user()))
            end)

            TOTAL_MONEY_SPOOFING = menu.slider(INFO_SPOOFING_MONEY, TRANSLATE("数值"), {"hctotalmoneyspoofing"}, "", INT_MIN, INT_MAX, players.get_bank(players.user()), 10000, function(); end)

        ---

        local INFO_SPOOFING_KILL = menu.list(INFO_SPOOFING, TRANSLATE("击杀"), {}, "", function(); end) -- freemode.c, joaat("mpply_kills_players")

            menu.toggle_loop(INFO_SPOOFING_KILL, TRANSLATE("启用"), {}, IsWorking(false), function()
                SET_INT_GLOBAL((1853348 + 1 + players.user() * 834) + 205 + 28, menu.get_value(KILL_SPOOFING))
            end, function()
                SET_INT_GLOBAL((1853348 + 1 + players.user() * 834) + 205 + 28, players.get_kills(players.user()))
            end)

            KILL_SPOOFING = menu.slider(INFO_SPOOFING_KILL, TRANSLATE("数值"), {"hckillspoofing"}, "", INT_MIN, INT_MAX, players.get_kills(players.user()), 1, function(); end)

        ---

        local INFO_SPOOFING_DEATH = menu.list(INFO_SPOOFING, TRANSLATE("死亡"), {}, "", function(); end)

            menu.toggle_loop(INFO_SPOOFING_DEATH, TRANSLATE("启用"), {}, IsWorking(false), function() -- freemode.c, joaat("mpply_deaths_player")
                SET_INT_GLOBAL((1853348 + 1 + players.user() * 834) + 205 + 29, menu.get_value(DEATH_SPOOFING))
            end, function()
                SET_INT_GLOBAL((1853348 + 1 + players.user() * 834) + 205 + 29, players.get_deaths(players.user()))
            end)

            DEATH_SPOOFING = menu.slider(INFO_SPOOFING_DEATH, TRANSLATE("数值"), {"hcdeathspoofing"}, "", INT_MIN, INT_MAX, players.get_deaths(players.user()), 1, function(); end)

        ---

    ---

    local BUSINESS_UPGRADE = menu.list(TOOLS, TRANSLATE("业务升级状态"), {}, "", function(); end) -- All stats name credit goes to Raid Control for X-Force

        function CHECK(Int)
            if Int >= 1 then
                return "是"
            else
                return "不是"
            end
        end

        menu.list_action(BUSINESS_UPGRADE, TRANSLATE("伪造证件"), {}, "", {
            { TRANSLATE("设备升级") .. ": " .. CHECK(STAT_GET_INT("FACTORYUPGRADES4")) },
            { TRANSLATE("员工升级") .. ": " .. CHECK(STAT_GET_INT("FACTORYUPGRADES4_1")) },
            { TRANSLATE("安保升级") .. ": " .. CHECK(STAT_GET_INT("FACTORYUPGRADES4_2")) },
        }, function(); end)

        menu.list_action(BUSINESS_UPGRADE, TRANSLATE("大麻"), {}, "", {
            { TRANSLATE("设备升级") .. ": " .. CHECK(STAT_GET_INT("FACTORYUPGRADES3")) },
            { TRANSLATE("员工升级") .. ": " .. CHECK(STAT_GET_INT("FACTORYUPGRADES3_1")) },
            { TRANSLATE("安保升级") .. ": " .. CHECK(STAT_GET_INT("FACTORYUPGRADES3_2")) },
        }, function(); end)

        menu.list_action(BUSINESS_UPGRADE, TRANSLATE("假钞"), {}, "", {
            { TRANSLATE("设备升级") .. ": " .. CHECK(STAT_GET_INT("FACTORYUPGRADES2")) },
            { TRANSLATE("员工升级") .. ": " .. CHECK(STAT_GET_INT("FACTORYUPGRADES2_1")) },
            { TRANSLATE("安保升级") .. ": " .. CHECK(STAT_GET_INT("FACTORYUPGRADES2_2")) },
        }, function(); end)

        menu.list_action(BUSINESS_UPGRADE, TRANSLATE("冰毒"), {}, "", {
            { TRANSLATE("设备升级") .. ": " .. CHECK(STAT_GET_INT("FACTORYUPGRADES1")) },
            { TRANSLATE("员工升级") .. ": " .. CHECK(STAT_GET_INT("FACTORYUPGRADES1_1")) },
            { TRANSLATE("安保升级") .. ": " .. CHECK(STAT_GET_INT("FACTORYUPGRADES1_2")) },
        }, function(); end)

        menu.list_action(BUSINESS_UPGRADE, TRANSLATE("可卡因"), {}, "", {
            { TRANSLATE("设备升级") .. ": " .. CHECK(STAT_GET_INT("FACTORYUPGRADES0")) },
            { TRANSLATE("员工升级") .. ": " .. CHECK(STAT_GET_INT("FACTORYUPGRADES0_1")) },
            { TRANSLATE("安保升级") .. ": " .. CHECK(STAT_GET_INT("FACTORYUPGRADES0_2")) },
        }, function(); end)

        menu.list_action(BUSINESS_UPGRADE, TRANSLATE("地堡"), {}, "", {
            { TRANSLATE("设备升级") .. ": " .. CHECK(STAT_GET_INT("BUNKER_EQUIPMENT")) },
            { TRANSLATE("员工升级") .. ": " .. CHECK(STAT_GET_INT("BUNKER_STAFF")) },
            { TRANSLATE("安保升级") .. ": " .. CHECK(STAT_GET_INT("BUNKER_SECURITY")) },
            { TRANSLATE("装修升级") .. ": " .. CHECK(STAT_GET_INT("BUNKER_DECOR")) },
            { TRANSLATE("靶场升级") .. ": " .. CHECK(STAT_GET_INT("BUNKER_FIRING_RANGE")) },
            { TRANSLATE("枪械库升级") .. ": " .. CHECK(STAT_GET_INT("BUNKER_GUNLOCKER")) },
            { TRANSLATE("个人住所升级") .. ": " .. CHECK(STAT_GET_INT("BUNKER_SAVEBED")) },
            { TRANSLATE("运输载具升级") .. ": " .. CHECK(STAT_GET_INT("BUNKER_TRANSPORTATION")) },
        }, function(); end)

        menu.list_action(BUSINESS_UPGRADE, TRANSLATE("游戏厅"), {}, "", {
            { TRANSLATE("无人机站") .. ": " .. CHECK(STAT_GET_INT("ARCADE_DRON_ST")) },
            { TRANSLATE("主控制终端") .. ": " .. CHECK(STAT_GET_INT("ARCADE_BUS_HUB")) },
            { TRANSLATE("地板") .. ": " .. CHECK(STAT_GET_INT("ARCADE_FLOOR")) },
            { TRANSLATE("样式") .. ": " .. CHECK(STAT_GET_INT("ARCADE_CEILING")) },
            { TRANSLATE("墙") .. ": " .. CHECK(STAT_GET_INT("ARCADE_WALL")) },
            { TRANSLATE("个人住所升级") .. ": " .. CHECK(STAT_GET_INT("ARCADE_PERSONAL_QUARTERS")) },
            { TRANSLATE("车库") .. ": " .. CHECK(STAT_GET_INT("ARCADE_GARAGE")) },
            { TRANSLATE("霓虹灯") .. ": " .. CHECK(STAT_GET_INT("ARCADE_NEON_LIGHTS")) },
            { TRANSLATE("排行榜屏幕") .. ": " .. CHECK(STAT_GET_INT("ARCADE_SCREENS")) },
        }, function(); end)

        menu.list_action(BUSINESS_UPGRADE, TRANSLATE("夜总会"), {}, "", {
            { TRANSLATE("样式") .. ": " .. CHECK(STAT_GET_INT("NIGHTCLUB_STYLE")) },
            { TRANSLATE("照明") .. ": " .. CHECK(STAT_GET_INT("NIGHTCLUB_LIGHTING")) },
            { TRANSLATE("舞者") .. ": " .. CHECK(STAT_GET_INT("NIGHTCLUB_MOD_4")) },
            { TRANSLATE("员工升级") .. ": " .. CHECK(STAT_GET_INT("NIGHTCLUB_MOD_5")) },
            { TRANSLATE("付费DJ") .. ": " .. CHECK(STAT_GET_INT("NIGHTCLUB_MOD_6")) },
        }, function(); end)

    ---

    local STAT_EDITOR_READER = menu.list(TOOLS, TRANSLATE("统计编辑&读取"), {}, "", function(); end)

        local PRESET_STAT_EDITOR = menu.list(STAT_EDITOR_READER, TRANSLATE("预设统计编辑"), {}, "", function(); end)

            local PLAYTIME_EDITOR = menu.list(PRESET_STAT_EDITOR, TRANSLATE("游戏时间"), {}, "", function(); end)

                menu.divider(PLAYTIME_EDITOR, TRANSLATE("方法"))

                    IS_TIME_ADDING_METHOD = menu.toggle(PLAYTIME_EDITOR, TRANSLATE("使用添加游戏时间"), {}, TRANSLATE("启用:使用添加游戏时间方法") .. "\n" .. TRANSLATE("- 从当前游戏时间添加") .. "\n\n" .. TRANSLATE("禁用:使用设置游戏时间的方法") .. "\n" .. TRANSLATE("- 设置相等与你设置的时间") .. "\n\n" .. TRANSLATE("这套方法最多设置24.8天,但添加的方法可以到50000天"), function(); end)

                ---
                
                menu.divider(PLAYTIME_EDITOR, TRANSLATE("修改统计"))

                    PLAYTIME_DAY = menu.slider(PLAYTIME_EDITOR, TRANSLATE("天"), {"hcplaytimeday"}, "", 0, 50000, 0, 1, function(); end)
                    PLAYTIME_HOUR = menu.slider(PLAYTIME_EDITOR, TRANSLATE("小时"), {"hcplaytimehour"}, "", 0, 50000, 0, 1, function(); end)
                    PLAYTIME_MIN = menu.slider(PLAYTIME_EDITOR, TRANSLATE("分"), {"hcplaytimemin"}, "", 0, 50000, 0, 1, function(); end)

                ---

                menu.divider(PLAYTIME_EDITOR, TRANSLATE("设置统计"))

                    menu.action(PLAYTIME_EDITOR, TRANSLATE("总游戏时间"), {}, "", function()
                        if not menu.get_value(IS_TIME_ADDING_METHOD) then
                            STAT_SET_INT("TOTAL_PLAYING_TIME", menu.get_value(PLAYTIME_DAY) * 86400000 + menu.get_value(PLAYTIME_HOUR) * 3600000 + menu.get_value(PLAYTIME_MIN) * 60000)
                        else
                            STAT_SET_INCREMENT("TOTAL_PLAYING_TIME", menu.get_value(PLAYTIME_DAY) * 86400000 + menu.get_value(PLAYTIME_HOUR) * 3600000 + menu.get_value(PLAYTIME_MIN) * 60000)
                        end

                        NOTIFY(TRANSLATE("设置成功!") .. "\n\n" .. TRANSLATE("Day") .. ": " .. menu.get_value(PLAYTIME_DAY) .. "\n" .. TRANSLATE("Hour") .. ": " .. menu.get_value(PLAYTIME_HOUR) .. "\n" .. TRANSLATE("Min") .. ": " .. menu.get_value(PLAYTIME_MIN))
                        FORCE_CLOUD_SAVE()
                    end)
                    menu.action(PLAYTIME_EDITOR, TRANSLATE("GTA5游戏时间"), {}, "", function()
                        if not menu.get_value(IS_TIME_ADDING_METHOD) then
                            STAT_SET_INT("MP_PLAYING_TIME", menu.get_value(PLAYTIME_DAY) * 86400000 + menu.get_value(PLAYTIME_HOUR) * 3600000 + menu.get_value(PLAYTIME_MIN) * 60000)
                        else
                            STAT_SET_INCREMENT("MP_PLAYING_TIME", menu.get_value(PLAYTIME_DAY) * 86400000 + menu.get_value(PLAYTIME_HOUR) * 3600000 + menu.get_value(PLAYTIME_MIN) * 60000)
                        end
        
                        NOTIFY(TRANSLATE("设置成功!") .. "\n\n" .. TRANSLATE("Day") .. ": " .. menu.get_value(PLAYTIME_DAY) .. "\n" .. TRANSLATE("Hour") .. ": " .. menu.get_value(PLAYTIME_HOUR) .. "\n" .. TRANSLATE("Min") .. ": " .. menu.get_value(PLAYTIME_MIN))
                        FORCE_CLOUD_SAVE()
                    end)
                    menu.action(PLAYTIME_EDITOR, TRANSLATE("死斗"), {}, "", function()
                        if not menu.get_value(IS_TIME_ADDING_METHOD) then
                            STAT_SET_INT("MPPLY_TOTAL_TIME_SPENT_DEATHMAT", menu.get_value(PLAYTIME_DAY) * 86400000 + menu.get_value(PLAYTIME_HOUR) * 3600000 + menu.get_value(PLAYTIME_MIN) * 60000)
                        else
                            STAT_SET_INCREMENT("MPPLY_TOTAL_TIME_SPENT_DEATHMAT", menu.get_value(PLAYTIME_DAY) * 86400000 + menu.get_value(PLAYTIME_HOUR) * 3600000 + menu.get_value(PLAYTIME_MIN) * 60000)
                        end
        
                        NOTIFY(TRANSLATE("设置成功!") .. "\n\n" .. TRANSLATE("Day") .. ": " .. menu.get_value(PLAYTIME_DAY) .. "\n" .. TRANSLATE("Hour") .. ": " .. menu.get_value(PLAYTIME_HOUR) .. "\n" .. TRANSLATE("Min") .. ": " .. menu.get_value(PLAYTIME_MIN))
                        FORCE_CLOUD_SAVE()
                    end)
                    menu.action(PLAYTIME_EDITOR, TRANSLATE("竞赛"), {}, "", function()
                        if not menu.get_value(IS_TIME_ADDING_METHOD) then
                            STAT_SET_INT("MPPLY_TOTAL_TIME_SPENT_RACES", menu.get_value(PLAYTIME_DAY) * 86400000 + menu.get_value(PLAYTIME_HOUR) * 3600000 + menu.get_value(PLAYTIME_MIN) * 60000)
                        else
                            STAT_SET_INCREMENT("MPPLY_TOTAL_TIME_SPENT_RACES", menu.get_value(PLAYTIME_DAY) * 86400000 + menu.get_value(PLAYTIME_HOUR) * 3600000 + menu.get_value(PLAYTIME_MIN) * 60000)
                        end
        
                        NOTIFY(TRANSLATE("设置成功!") .. "\n\n" .. TRANSLATE("Day") .. ": " .. menu.get_value(PLAYTIME_DAY) .. "\n" .. TRANSLATE("Hour") .. ": " .. menu.get_value(PLAYTIME_HOUR) .. "\n" .. TRANSLATE("Min") .. ": " .. menu.get_value(PLAYTIME_MIN))
                        FORCE_CLOUD_SAVE()
                    end)
                    menu.action(PLAYTIME_EDITOR, TRANSLATE("创作者"), {}, "", function()
                        if not menu.get_value(IS_TIME_ADDING_METHOD) then
                            STAT_SET_INT("MPPLY_TOTAL_TIME_MISSION_CREATO", menu.get_value(PLAYTIME_DAY) * 86400000 + menu.get_value(PLAYTIME_HOUR) * 3600000 + menu.get_value(PLAYTIME_MIN) * 60000)
                        else
                            STAT_SET_INCREMENT("MPPLY_TOTAL_TIME_MISSION_CREATO", menu.get_value(PLAYTIME_DAY) * 86400000 + menu.get_value(PLAYTIME_HOUR) * 3600000 + menu.get_value(PLAYTIME_MIN) * 60000)
                        end
        
                        NOTIFY(TRANSLATE("设置成功!") .. "\n\n" .. TRANSLATE("Day") .. ": " .. menu.get_value(PLAYTIME_DAY) .. "\n" .. TRANSLATE("Hour") .. ": " .. menu.get_value(PLAYTIME_HOUR) .. "\n" .. TRANSLATE("Min") .. ": " .. menu.get_value(PLAYTIME_MIN))
                        FORCE_CLOUD_SAVE()
                    end)

                ---

            ---

            local CASH_EDITOR = menu.list(PRESET_STAT_EDITOR, TRANSLATE("现金收入&支出"), {}, "", function(); end)

                menu.divider(CASH_EDITOR, TRANSLATE("修改统计"))

                    CASH_EDITOR_AMOUNT = menu.slider(CASH_EDITOR, TRANSLATE("Cash Amount"), {"hccasheditor"}, "($)", INT_MIN, INT_MAX, 0, 10000, function(); end)

                ---

                menu.divider(CASH_EDITOR, TRANSLATE("设置统计"))

                    menu.action(CASH_EDITOR, TRANSLATE("总收入"), {}, "", function()
                        STAT_SET_INT("MPPLY_TOTAL_EVC", menu.get_value(CASH_EDITOR_AMOUNT))
                        FORCE_CLOUD_SAVE()
                    end)
                    menu.action(CASH_EDITOR, TRANSLATE("总支出"), {}, "", function()
                        STAT_SET_INT("MPPLY_TOTAL_SVC", menu.get_value(CASH_EDITOR_AMOUNT))
                        FORCE_CLOUD_SAVE()
                    end)

                ---

                menu.divider(CASH_EDITOR, TRANSLATE("相关现金收入"))

                    menu.action(CASH_EDITOR, TRANSLATE("工作"), {}, "", function()
                        STAT_SET_INT("MONEY_EARN_JOBS", menu.get_value(CASH_EDITOR_AMOUNT))
                        FORCE_CLOUD_SAVE()
                    end)
                    menu.action(CASH_EDITOR, TRANSLATE("赌博"), {}, "", function()
                        STAT_SET_INT("MONEY_EARN_BETTING", menu.get_value(CASH_EDITOR_AMOUNT))
                        FORCE_CLOUD_SAVE()
                    end)
                    menu.action(CASH_EDITOR, TRANSLATE("共享"), {}, "", function()
                        STAT_SET_INT("MONEY_EARN_SHARED", menu.get_value(CASH_EDITOR_AMOUNT))
                        FORCE_CLOUD_SAVE()
                    end)
                    menu.action(CASH_EDITOR, TRANSLATE("载具出售"), {}, "", function()
                        STAT_SET_INT("MONEY_EARN_SELLING_VEH", menu.get_value(CASH_EDITOR_AMOUNT))
                        FORCE_CLOUD_SAVE()
                    end)
                    menu.action(CASH_EDITOR, TRANSLATE("其他"), {}, "", function()
                        STAT_SET_INT("MONEY_EARN_GOOD_SPORT", menu.get_value(CASH_EDITOR_AMOUNT))
                        FORCE_CLOUD_SAVE()
                    end)
                    menu.action(CASH_EDITOR, TRANSLATE("拾取"), {}, "", function()
                        STAT_SET_INT("MONEY_EARN_PICKED_UP", menu.get_value(CASH_EDITOR_AMOUNT))
                        FORCE_CLOUD_SAVE()
                    end)

                ---

            ---
            
        ---

        local STAT_EDITOR = menu.list(STAT_EDITOR_READER, TRANSLATE("自定义统计编辑") .. " " .. TRANSLATE("[风险]"), {}, TRANSLATE("设置一些特定的统计数字可能会导致封号.使用时风险自负!"), function(); end)

            menu.divider(STAT_EDITOR, TRANSLATE("修改统计"))

                menu.text_input(STAT_EDITOR, TRANSLATE("统计名称"), {"hceditname"}, TRANSLATE("注意: MP0_ 或 MP1_ 会被HC自动选择,所以不要写入."), function(Input)
                    EditStatName = string.upper(Input)
                end)
                menu.text_input(STAT_EDITOR, TRANSLATE("统计数值"), {"hceditvalue"}, "", function(Input)
                    EditStatValue = Input
                end)

            ---

            menu.divider(STAT_EDITOR, "日期")

                DATE_YEAR = menu.slider(STAT_EDITOR, "年", {"hcedityear"}, "", 2013, os.date("%Y"), 0, 1, function(); end)
                DATE_MONTH = menu.slider(STAT_EDITOR, "月", {"hceditmonth"}, "", 0, 12, 0, 1, function(); end)
                DATE_DAY = menu.slider(STAT_EDITOR, "天", {"hceditday"}, "", 0, 31, 0, 1, function(); end)
                DATE_HOUR = menu.slider(STAT_EDITOR, "小时", {"hcedithour"}, "", 0, 24, 0, 1, function(); end)
                DATE_MIN = menu.slider(STAT_EDITOR, "分", {"hceditmin"}, "", 0, 60, 0, 1, function(); end)

            ---

            menu.divider(STAT_EDITOR, TRANSLATE("设置统计"))

                menu.action(STAT_EDITOR, "整数值", {}, TRANSLATE("示例统计信息") .. "\n\n" .. TRANSLATE("统计名称") .. ": " .. "NO_BOUGHT_YUM_SNACKS\n" .. TRANSLATE("统计数值") .. ": " .. "30", function()
                    if EditStatName == nil or EditStatValue == nil then
                        NOTIFY(TRANSLATE("你没有输入数值.请输入!"))
                    else
                        STAT_SET_INT(EditStatName, EditStatValue)
                        NOTIFY(TRANSLATE("设置成功!") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. ADD_MP_INDEX(EditStatName) .. "\n" .. TRANSLATE("Stat Value") .. ": " .. EditStatValue)
                        FORCE_CLOUD_SAVE()
                    end
                end)

                menu.action(STAT_EDITOR, "浮动值", {}, TRANSLATE("示例统计信息") .. "\n\n" .. TRANSLATE("统计名称") .. ": " .. "PLAYER_MENTAL_STATE\n" .. TRANSLATE("统计数值") .. ": " .. "100.0", function()
                    if EditStatName == nil or EditStatValue == nil then
                        NOTIFY(TRANSLATE("你没有输入数值.请输入!"))
                    else
                        STAT_SET_FLOAT(EditStatName, EditStatValue)
                        NOTIFY(TRANSLATE("设置成功!") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. ADD_MP_INDEX(EditStatName) .. "\n" .. TRANSLATE("Stat Value") .. ": " .. EditStatValue)
                        FORCE_CLOUD_SAVE()
                    end
                end)

                menu.action(STAT_EDITOR, "布尔值", {}, TRANSLATE("示例统计信息") .. "\n\n" .. TRANSLATE("统计名称") .. ": " .. "CL_RACE_MODDED_CAR\n" .. TRANSLATE("统计数值") .. ": " .. "true or false", function()
                    if EditStatName == nil or EditStatValue == nil then
                        NOTIFY(TRANSLATE("你没有输入数值.请输入!"))
                    else
                        STAT_SET_BOOL(EditStatName, EditStatValue)
                        NOTIFY(TRANSLATE("设置成功!") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. ADD_MP_INDEX(EditStatName) .. "\n" .. TRANSLATE("Stat Value") .. ": " .. EditStatValue)
                        FORCE_CLOUD_SAVE()
                    end
                end)

                menu.action(STAT_EDITOR, "字符串", {}, TRANSLATE("示例统计信息") .. "\n\n" .. TRANSLATE("统计名称") .. ": " .. "CHAR_NAME\n" .. TRANSLATE("统计数值") .. ": " .. "STRING", function()
                    if EditStatName == nil or EditStatValue == nil then
                        NOTIFY(TRANSLATE("你没有输入数值.请输入!"))
                    else
                        STAT_SET_STRING(EditStatName, EditStatValue)
                        NOTIFY(TRANSLATE("设置成功!") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. ADD_MP_INDEX(EditStatName) .. "\n" .. TRANSLATE("Stat Value") .. ": " .. EditStatValue)
                        FORCE_CLOUD_SAVE()
                    end
                end)

                menu.action(STAT_EDITOR, "日期", {}, TRANSLATE("示例统计信息") .. "\n\n" .. TRANSLATE("统计名称") .. ": " .. "CHAR_DATE_CREATED\n" .. TRANSLATE("统计数值") .. ": " .. "Year: 1970, Month: 1, Day: 1", function()
                    if EditStatName == nil then
                        NOTIFY(TRANSLATE("你没有输入数值.请输入!"))
                    else
                        STAT_SET_DATE(EditStatName, menu.get_value(DATE_YEAR), menu.get_value(DATE_MONTH), menu.get_value(DATE_DAY), menu.get_value(DATE_HOUR), menu.get_value(DATE_MIN))
                        NOTIFY(TRANSLATE("设置成功!") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. ADD_MP_INDEX(EditStatName) .. "\n" .. "Year: " .. menu.get_value(DATE_YEAR) .. "\n" .. "Month: " .. menu.get_value(DATE_MONTH) .. "\n" .."Day: " .. menu.get_value(DATE_DAY) .. "\n" .. "Hour: " .. menu.get_value(DATE_HOUR) .. "\n" .. "Min: " .. menu.get_value(DATE_MIN))
                        FORCE_CLOUD_SAVE()
                    end
                end)

            ---

        ---

        local STAT_READER = menu.list(STAT_EDITOR_READER, TRANSLATE("自定义统计读取"), {}, "", function(); end)

            menu.divider(STAT_READER, TRANSLATE("修改统计"))

                menu.text_input(STAT_READER, TRANSLATE("统计名称"), {"hcreadername"}, "", function(Input)
                    ReaderStatName = string.upper(Input)
                end)

            ---

            menu.divider(STAT_READER, TRANSLATE("设置"))

                IS_READER_COPY = menu.toggle(STAT_READER, TRANSLATE("复制统计值"), {}, "", function(); end)

            ---

            menu.divider(STAT_READER, TRANSLATE("读取统计"))

                menu.action(STAT_READER, "整数", {}, "", function()
                    if ReaderStatName == nil then
                        NOTIFY(TRANSLATE("你没有输入数值.请输入!"))
                    else
                        NOTIFY(TRANSLATE("设置成功!") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. ADD_MP_INDEX(ReaderStatName) .. "\n" .. TRANSLATE("Stat Value") .. ": " .. STAT_GET_INT(ReaderStatName))
                        if menu.get_value(IS_READER_COPY) then
                            util.copy_to_clipboard(STAT_GET_INT(ReaderStatName))
                        end
                    end
                end)

                menu.action(STAT_READER, "浮动", {}, "", function()
                    if ReaderStatName == nil then
                        NOTIFY(TRANSLATE("你没有输入数值.请输入!"))
                    else
                        NOTIFY(TRANSLATE("设置成功!") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. ADD_MP_INDEX(ReaderStatName) .. "\n" .. TRANSLATE("Stat Value") .. ": " .. STAT_GET_FLOAT(ReaderStatName))
                        if menu.get_value(IS_READER_COPY) then
                            util.copy_to_clipboard(STAT_GET_FLOAT(ReaderStatName))
                        end
                    end
                end)

                menu.action(STAT_READER, "布尔", {}, "", function()
                    if ReaderStatName == nil then
                        NOTIFY(TRANSLATE("你没有输入数值.请输入!"))
                    else
                        NOTIFY(TRANSLATE("设置成功!") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. ADD_MP_INDEX(ReaderStatName) .. "\n" .. TRANSLATE("Stat Value") .. ": " .. STAT_GET_BOOL(ReaderStatName))
                        if menu.get_value(IS_READER_COPY) then
                            util.copy_to_clipboard(STAT_GET_BOOL(ReaderStatName))
                        end
                    end
                end)

                menu.action(STAT_READER, "字符串", {}, "", function()
                    if ReaderStatName == nil then
                        NOTIFY(TRANSLATE("你没有输入数值.请输入!"))
                    else
                        NOTIFY(TRANSLATE("设置成功!") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. ADD_MP_INDEX(ReaderStatName) .. "\n" .. TRANSLATE("Stat Value") .. ": " .. STAT_GET_STRING(ReaderStatName))
                        if menu.get_value(IS_READER_COPY) then
                            util.copy_to_clipboard(STAT_GET_STRING(ReaderStatName))
                        end
                    end
                end)

                menu.action(STAT_READER, "日期", {}, "", function()
                    if ReaderStatName == nil then
                        NOTIFY(TRANSLATE("你没有输入数值.请输入!"))
                    else
                        NOTIFY(TRANSLATE("设置成功!") .. "\n\n" .. TRANSLATE("Stat Name") .. ": " .. ADD_MP_INDEX(ReaderStatName) .. "\n" .. "Year: " .. STAT_GET_DATE(ReaderStatName, "Year") .. "\n" .. "Month: " .. STAT_GET_DATE(ReaderStatName, "Month") .. "\n" .. "Day: " .. STAT_GET_DATE(ReaderStatName, "Day") .. "\n" .. "Hour: " .. STAT_GET_DATE(ReaderStatName, "Hour") .. "\n" .. "Min: " .. STAT_GET_DATE(ReaderStatName, "Min"))
                        if menu.get_value(IS_READER_COPY) then
                            util.copy_to_clipboard("Year: " .. STAT_GET_DATE(ReaderStatName, "Year") .. "\n" .. "Month: " .. STAT_GET_DATE(ReaderStatName, "Month") .. "\n" .. "Day: " .. STAT_GET_DATE(ReaderStatName, "Day") .. "\n" .. "Hour: " .. STAT_GET_DATE(ReaderStatName, "Hour") .. "\n" .. "Min: " .. STAT_GET_DATE(ReaderStatName, "Min"))
                        end
                    end
                end)

            ---

        ---
        
    ---

    local TOOLS_OTH = menu.list(TOOLS, TRANSLATE("其他"), {}, "", function(); end)

        menu.toggle_loop(TOOLS_OTH, "自动拾取道具", {"hcautocollect"}, "点击自动拾取道具.关闭后会有点延迟.", function()
            PAD._SET_CONTROL_NORMAL(0, 237, 1)
            util.yield(50)
        end)

        menu.action(TOOLS_OTH, "运动跳过", {}, "又名暂停菜单故障", function()
            TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
        end)

        menu.action_slider(TOOLS_OTH, "跳过与NPC的对话", {}, "", {
            "所有",
            "一行",
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

    menu.divider(INFOS, TRANSLATE("语言"))

        HC_LANG = menu.list_action(INFOS, TRANSLATE("语言设置") .. ": " .. READ_SETTING("Language"), {"hclang"}, "", {
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
            menu.show_warning(HC_LANG, CLICK_MENU, TRANSLATE("你想现在重启HC吗?"), function()
                WRITE_SETTING("Language", Name)
                util.restart_script()
            end)
        end)

        menu.hyperlink(INFOS, TRANSLATE("如何翻译"), "https://icedoomfist.com/Stand_Heist_Control/How_To_Translate", TRANSLATE("一直在寻找新的翻译人员而不是现有的语言.如果您对翻译HC感兴趣，请点击!"))

    ---

    menu.divider(INFOS, TRANSLATE("设置"))

        NOTIFICATION_SETTING = menu.list(INFOS, TRANSLATE("Notification") .. ": " .. READ_SETTING("Notification Sort"), {"hcnotification"}, "", function(); end)

            menu.divider(NOTIFICATION_SETTING, TRANSLATE("游戏内自定义"))

                NOTIFICATION_ICON_SETTING = menu.list_action(NOTIFICATION_SETTING, TRANSLATE("Icon") .. ": " .. TRANSLATE(READ_SETTING("Notification Icon")), {}, "", {
                    { TRANSLATE("HC Logo") },
                    { TRANSLATE("莱斯特") },
                    { TRANSLATE("抢劫传说") }, 
                    { TRANSLATE("骷髅头") },
                    { TRANSLATE("军火商") },
                    { TRANSLATE("黑色R*") },
                    { TRANSLATE("R*Social Club") },
                }, function(Index)
                    WRITE_SETTING("Notification Icon", NotiIconSorts[Index][1])
                    WRITE_SETTING("Notification Sort", "In-Game")
                    menu.trigger_commands("clearnotifications")
                    NOTIFY(TRANSLATE("成功设置!"))
                end)

                NOTIFICATION_COLOR_SETTING = menu.list_action(NOTIFICATION_SETTING, TRANSLATE("Background Color") .. ": " .. TRANSLATE(READ_SETTING("Notification Color")), {}, "", {
                    { TRANSLATE("白色") },
                    { TRANSLATE("黑色") },
                    { TRANSLATE("红色") },
                    { TRANSLATE("橙色") },
                    { TRANSLATE("黄色") },
                    { TRANSLATE("薄荷") },
                    { TRANSLATE("绿色") },
                    { TRANSLATE("浅蓝") },
                }, function(Index)
                    WRITE_SETTING("Notification Color", NotiColorSorts[Index][1])
                    WRITE_SETTING("Notification Sort", "In-Game")
                    menu.trigger_commands("clearnotifications")
                    NOTIFY(TRANSLATE("成功设置!"))
                end)

            ---

            menu.divider(NOTIFICATION_SETTING, TRANSLATE("种类"))

                menu.action(NOTIFICATION_SETTING, "Stand", {}, "", function()
                    WRITE_SETTING("Notification Sort", "Stand")            
                    NOTIFY(TRANSLATE("成功设置!"))
                end)
                menu.action(NOTIFICATION_SETTING, TRANSLATE("游戏中"), {}, "", function()
                    WRITE_SETTING("Notification Sort", "In-Game")
                    NOTIFY(TRANSLATE("成功设置!"))
                end)
                menu.action(NOTIFICATION_SETTING, TRANSLATE("没有通知"), {}, "", function()
                    WRITE_SETTING("Notification Sort", "No Notification")
                end)

            ---

        ---

        TIMER_SETTING = menu.list_action(INFOS, TRANSLATE("Heist Cooldown Timer") .. ": " .. TRANSLATE(READ_SETTING("Timer Color")), {"hctimercolor"}, "", {
            { TRANSLATE("黑色") },
            { TRANSLATE("白色") },
            { TRANSLATE("红色") },
            { TRANSLATE("橙色") },
            { TRANSLATE("黄色") },
            { TRANSLATE("薄荷") }, 
            { TRANSLATE("绿色") },
            { TRANSLATE("浅蓝") },
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
                menu.set_menu_name(NOTIFICATION_SETTING, TRANSLATE("通知") .. ": " .. TRANSLATE(READ_SETTING("Notification Sort")))
                menu.set_menu_name(NOTIFICATION_ICON_SETTING, TRANSLATE("图标") .. ": " .. TRANSLATE(READ_SETTING("Notification Icon")))
                menu.set_menu_name(NOTIFICATION_COLOR_SETTING, TRANSLATE("背景颜色") .. ": " .. TRANSLATE(READ_SETTING("Notification Color")))
                menu.set_menu_name(TIMER_SETTING, TRANSLATE("抢劫冷却计时器") .. ": " .. TRANSLATE(READ_SETTING("Timer Color")))
                util.yield(500)
            end
        end)

    ---

    menu.divider(INFOS, TRANSLATE("关于HC"))

        local CREDITS = menu.list(INFOS, TRANSLATE("鸣谢"), {"hccredit"}, "", function(); end)

            menu.divider(CREDITS, "jhowkNX")

                menu.hyperlink(CREDITS, "jhowkNx", "https://github.com/jhowkNx", TRANSLATE("2Take1抢劫控制开发,他允许我使用他的代码.没有他，HC不存在.真的很感谢他!"))

            ---

            menu.divider(CREDITS, TRANSLATE("抢劫控制"))

                menu.action(CREDITS, "Nowiri & Lance", {}, TRANSLATE("Wiriscript和Lancescript的开发帮我编码HC"), function(); end)
                menu.action(CREDITS, "Baloo", {}, TRANSLATE("HC网站维护提供了很多帮助."), function();end)
                menu.action(CREDITS, "Zetax", {}, TRANSLATE("帮我设计我的网站."), function(); end)
                menu.action(CREDITS, "Aji", {}, TRANSLATE("为HC制作Logo、横幅等."), function(); end)
                menu.hyperlink(CREDITS, "unknowncheats", "https://www.unknowncheats.me/forum/grand-theft-auto-v/", TRANSLATE("让我了解统计信息."))

            ---

            menu.divider(CREDITS, TRANSLATE("翻译人员"))

                menu.action(CREDITS, "Qiusha", {}, TRANSLATE("维护 HC 的翻译") .. ": Chinese - 中文", function(); end)
                menu.action(CREDITS, "Leif.Erickson", {}, TRANSLATE("维护 HC 的翻译") .. ": French - français", function(); end)
                menu.action(CREDITS, "Hibanana", {}, TRANSLATE("维护 HC 的翻译") .. ": German - Deutsch", function(); end)
                menu.action(CREDITS, "Greensky445", {}, TRANSLATE("维护 HC 的翻译") .. ": Japanese - 日本語", function(); end)
                menu.action(CREDITS, "IceDoomfist", {}, TRANSLATE("维护 HC 的翻译") .. ": Korean - 한국어", function(); end)
                menu.action(CREDITS, "Pedro9558", {}, TRANSLATE("维护 HC 的翻译") .. ": Portuguese - Português", function(); end)
                menu.action(CREDITS, "Sega", {}, TRANSLATE("维护 HC 的翻译") .. ": Russian - русский", function(); end)
                menu.action(CREDITS, "zigmazero", {}, TRANSLATE("维护 HC 的翻译") .. ": Spanish - Español", function(); end)
                -- menu.action(CREDITS, "Emre", {}, TRANSLATE("Maintains HC's translation") .. ": Turkish - Türkçe", function(); end)

            ---

        ---

        menu.hyperlink(INFOS, TRANSLATE("加入Discord服务器!"), "https://icedoomfist.com/Link/HC_Discord", TRANSLATE("获得帮助,下载测试版,享受其他东西!"))
        menu.hyperlink(INFOS, TRANSLATE("Youtube"), "https://icedoomfist.com/Link/HC_Youtube", TRANSLATE("上传HC相关教程的视频，请订阅我的频道, :D"))
        menu.hyperlink(INFOS, TRANSLATE("教程"), "https://icedoomfist.com/Stand_Heist_Control/Tutorial", TRANSLATE("如果您不知道如何使用 HC，请点击!"))
        menu.hyperlink(INFOS, TRANSLATE("更新日志"), "https://icedoomfist.com/Stand_Heist_Control/Changelog", TRANSLATE("如果您想知道最新版本的更改，请点击!"))

    ---

---