---------------第二任务

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
    local DatePTR = memory.alloc(7*8) 
    memory.write_int(DatePTR, Year)
    memory.write_int(DatePTR+8, Month)
    memory.write_int(DatePTR+16, Day)
    memory.write_int(DatePTR+24, Hour)
    memory.write_int(DatePTR+32, Min)
    memory.write_int(DatePTR+40, 0) 
    memory.write_int(DatePTR+48, 0) 
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

function TELEPORT(X, Y, Z)
    PED.SET_PED_COORDS_KEEP_VEHICLE(players.user_ped(), X, Y, Z)
end
function SET_HEADING(Heading)
    ENTITY.SET_ENTITY_HEADING(players.user_ped(), Heading)
end

function IsWorking(IsAddNewLine)
    local State = "" 
    if util.is_session_started() then
        if GET_INT_LOCAL("freemode", 3504) ~= util.joaat("lr_prop_carkey_fob") then 
            State = "[NOT WORKING]"
            if IsAddNewLine then
                State = State .. "\n\n"
            end
        end
    end
    return State
end

function RGB(R, G, B, A) 
    local Color = {}
    Color.r = R
    Color.g = G
    Color.b = B
    Color.a = A
    return Color
end

function HelpMsgBeingDisplayed(Label) 
    HUD.BEGIN_TEXT_COMMAND_IS_THIS_HELP_MESSAGE_BEING_DISPLAYED(Label) 
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
    STATS.STAT_SAVE(0, 0, 3, 0) 
    util.yield(1500)
    util.arspinner_enable()
    util.yield(4500)
    util.arspinner_disable()
end

function IA_MENU_OPEN()
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
local renwu1 = menu.list(renwu, "佩里科岛抢劫任务")
menu.action(renwu1, "完成所有前置任务", {}, "", function()
    STAT_SET_INT("H4_MISSIONS", -1)
    STAT_SET_INT("H4CNF_APPROACH", -1)
    STAT_SET_INT("H4CNF_TARGET", 5)
    STAT_SET_INT("H4CNF_BS_ENTR", 63)
    STAT_SET_INT("H4CNF_BS_GEN", 63)
    util.toast("完成佩岛抢劫前置任务")
end)


menu.action(renwu1, "传送到任务面板 [先呼叫潜艇]", {"tpkokathb"}, "", function()
    if STAT_GET_INT("IH_SUB_OWNED") == 0 then
    else
        TELEPORT(1561.2369, 385.8771, -49.689915)
        SET_HEADING(175)
        STAT_SET_INT("H4_PROGRESS", 131055)
    end
;  end)

menu.action(renwu1, "全员135%分红", {"setallcut135"}, "", function()
    SET_INT_GLOBAL(1977693 + 823 + 56 + 1, 135)
    SET_INT_GLOBAL(1977693 + 823 + 56 + 2, 135)
    SET_INT_GLOBAL(1977693 + 823 + 56 + 3, 135)
    SET_INT_GLOBAL(1977693 + 823 + 56 + 4, 135)
    STAT_SET_INT("H4_PLAYTHROUGH_STATUS", 5)
;  end)

menu.action(renwu1, "[频繁上岛保护]全员135%分红 你0%", {}, "", function()
    SET_INT_GLOBAL(1977693 + 823 + 56 + 1, 0)
    SET_INT_GLOBAL(1977693 + 823 + 56 + 2, 135)
    SET_INT_GLOBAL(1977693 + 823 + 56 + 3, 135)
    SET_INT_GLOBAL(1977693 + 823 + 56 + 4, 135)
    STAT_SET_INT("H4_PLAYTHROUGH_STATUS", 5)
;  end)

menu.action(renwu1, "一键完成任务", {}, "", function()
        menu.trigger_commands("scripthost")
        SET_INT_LOCAL("fm_mission_controller_2020", 42279 + 1, 51338752)
        SET_INT_LOCAL("fm_mission_controller_2020", 42279 + 1375 + 1, 50)
end)

menu.action(renwu1, "杀死队友", {}, "", function()
    menu.trigger_commands("explodeall")
;  end)

menu.action(renwu1, "传送到大门", {}, "", function()
    TELEPORT(4974.189, -5703.279, 19.898539)
;  end)

menu.action(renwu1, "传送到主要目标", {}, "", function()
    TELEPORT(5006.7, -5756.2, 14.8)
    SET_HEADING(145)
;  end)

menu.action(renwu1, "传送到出口", {}, "", function()
    TELEPORT(4990.0386, -5717.6895, 19.880217)
    SET_HEADING(50)
;  end)

menu.action(renwu1, "传送到大海", {}, "", function()
    TELEPORT(4771.479, -6165.737, -39.079613)
;  end)

local renwu2 = menu.list(renwu, "名钻赌场抢劫任务")

menu.divider(renwu2, "只有气势汹汹可以一键完成任务")
        
menu.action(renwu2, "游戏厅车库门口", {}, "", function()
    TELEPORT(-619.987, 282.960, 81.639)
end)



menu.action(renwu2, "一键完成任务", {},"", function()
    menu.trigger_commands("scripthost")
    SET_INT_LOCAL("fm_mission_controller", 19707 + 1741, 151)
    SET_INT_LOCAL("fm_mission_controller", 19707 + 2686, 10000000)
    SET_INT_LOCAL("fm_mission_controller", 27471 + 859, 99999)
    SET_INT_LOCAL("fm_mission_controller", 31585 + 69, 99999)
    SET_INT_LOCAL("fm_mission_controller", 31585 + 97, 79)
end)

menu.action(renwu2, "传送到游戏厅车库门口", {}, "", function()
    TELEPORT(-619.987, 282.960, 81.639)
end)

doomsday = menu.list(renwu, "末日豪杰", {""}, "")
    doomsday_Task_setting = menu.list(doomsday, "任务设定", {""}, "")
        menu.action(doomsday_Task_setting, "数据泄露 I", {}, "", function()
            STAT_SET_INT("GANGOPS_FLOW_MISSION_PROG", 503)
            STAT_SET_INT("GANGOPS_HEIST_STATUS", -229383)
            STAT_SET_INT("GANGOPS_FLOW_NOTIFICATIONS", 1557)
        end)
        menu.action(doomsday_Task_setting, "波格丹危机 II", {}, "", function()
            STAT_SET_INT("GANGOPS_FLOW_MISSION_PROG", 240)
            STAT_SET_INT("GANGOPS_HEIST_STATUS", -229378)
            STAT_SET_INT("GANGOPS_FLOW_NOTIFICATIONS", 1557)
        end)
        menu.action(doomsday_Task_setting, "末日降临 III", {}, "", function()
            STAT_SET_INT("GANGOPS_FLOW_MISSION_PROG", 16368)
            STAT_SET_INT("GANGOPS_HEIST_STATUS", -229380)
            STAT_SET_INT("GANGOPS_FLOW_NOTIFICATIONS", 1557)
        end)
        menu.action(doomsday_Task_setting, "重置任务面板", {}, "切换战局生效", function()
            STAT_SET_INT("GANGOPS_FLOW_MISSION_PROG", 240)
            STAT_SET_INT("GANGOPS_HEIST_STATUS", 0)
            STAT_SET_INT("GANGOPS_FLOW_NOTIFICATIONS", 1557)
            util.toast("[Pie sauce 提示] \n重置完成,切换战局生效")
        end)
    doomsday_Task_tp = menu.list(doomsday, "地点传送", {""}, "")
        menu.action(doomsday_Task_tp, "抢劫屏幕", {}, "", function()
            TELEPORT(350.69284, 4872.308, -60.794243)
            SET_HEADING(-50)
        end)

    doomsday_Task_fenhong = menu.list(doomsday, "分红设置", {""}, "")
        menu.action(doomsday_Task_fenhong, "全员100%分红", {}, "分红界面出现时再修改", function()
            SET_INT_GLOBAL(1966831 + 812 + 50 + 1, 100)
            SET_INT_GLOBAL(1966831 + 812 + 50 + 2, 100)
            SET_INT_GLOBAL(1966831 + 812 + 50 + 3, 100)
            SET_INT_GLOBAL(1966831 + 812 + 50 + 4, 100)
        end)
        menu.action(doomsday_Task_fenhong, "全员135%分红", {}, "分红界面出现时再修改", function()
            SET_INT_GLOBAL(1966831 + 812 + 50 + 1, 135)
            SET_INT_GLOBAL(1966831 + 812 + 50 + 2, 135)
            SET_INT_GLOBAL(1966831 + 812 + 50 + 3, 135)
            SET_INT_GLOBAL(1966831 + 812 + 50 + 4, 135)
        end)
        menu.action(doomsday_Task_fenhong, "自保分红", {}, "分红界面出现时再修改", function()
            SET_INT_GLOBAL(1966831 + 812 + 50 + 1, 60)
            SET_INT_GLOBAL(1966831 + 812 + 50 + 2, 135)
            SET_INT_GLOBAL(1966831 + 812 + 50 + 3, 135)
            SET_INT_GLOBAL(1966831 + 812 + 50 + 4, 135)
        end)
        
        local doomsday_dividends = 25
        doomsday_custom_dividends = menu.list(doomsday_Task_fenhong, "自定义分红", {}, "")
            menu.toggle_loop(doomsday_custom_dividends, "开启", {}, "", function()
                SET_INT_GLOBAL(1977693 + 823 + 56 + 1, menu.get_value(doomsday_dividends))
                SET_INT_GLOBAL(1977693 + 823 + 56 + 2, menu.get_value(doomsday_dividends))
                SET_INT_GLOBAL(1977693 + 823 + 56 + 3, menu.get_value(doomsday_dividends))
                SET_INT_GLOBAL(1977693 + 823 + 56 + 4, menu.get_value(doomsday_dividends))
            end)
            doomsday_dividends = menu.slider(doomsday_custom_dividends, "分红金额", {"hcdoomsdaycut"}, "(%)", 0, 1000, 25, 5, function(); end)
Translations = {}
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

local auto_cayo_bot = menu.list(renwu, "全自动上岛机器人") 
menu.divider(auto_cayo_bot, TRANSLATE("冷却时间(秒)"))

        COOLDOWN_CAYO_BOT = menu.slider(auto_cayo_bot, TRANSLATE("自动上岛机器人"), {""}, "", 1200, 86400, 1200, 60, function(); end)



        menu.divider(auto_cayo_bot, TRANSLATE("设置"))

        NumberOfPlayingCP = 100
        menu.slider(auto_cayo_bot, TRANSLATE("自动上岛冷却时间"), {""}, "", 1, 100, 100, 1, function(Value)
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
            end

        function NOTIFY(Message)
            local Icon = READ_SETTING("Notification Icon Code")
            local Color = READ_SETTING("Notification Color Code")

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

Settings = {}
        function READ_SETTING(type)
            local Values = {}

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
        end
        ---

       menu.divider(auto_cayo_bot, "确保你的生成位置是佩岛,可以按m查看")

        local NumberOfPlayedCP = 0
        AUTO_CAYO_BOT = menu.toggle_loop(auto_cayo_bot, TRANSLATE("开启上岛"), {}, IS_WORKING(true) .. TRANSLATE("Heist Control 将每 20 分钟自动完成一次 Solo Cayo Perico Heist，可获得 209 万美元。 不要按任何键以防止一些游戏错误。 "), function()

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
            
                local SubBlip, SubControlBlip
                util.create_tick_handler(function()
                    SubBlip = HUD.GET_FIRST_BLIP_INFO_ID(760)
                    SubControlBlip = HUD.GET_FIRST_BLIP_INFO_ID(773)
                end)
                if SubBlip == 0 and SubControlBlip == 0 then
                    NOTIFY("已请求 Kosatka。 等待几秒钟。")
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
        end)
        menu.toggle_loop(renwu, "跳过达克斯冷却", {}, "", function() -- thx icedoomfist for the stat name <3
            STATS.STAT_SET_INT(util.joaat("MP"..util.get_char_slot().."_XM22JUGGALOWORKCDTIMER"), -1, true)
        end)
        menu.toggle_loop(renwu, "禁用阻止实体轰炸", {}, "将在任务中自动禁用阻止实体轰炸,防止任务卡关.", function()
            local EntitySpam = menu.ref_by_path("Online>Protections>Block Entity Spam>Block Entity Spam")
            if NETWORK.NETWORK_IS_ACTIVITY_SESSION() == true then
                if not menu.get_value(EntitySpam) then return end
                menu.trigger_command(EntitySpam, "off")
            else
                if menu.get_value(EntitySpam) then return end
                menu.trigger_command(EntitySpam, "on")
            end
        end)
        
        menu.action(renwu, "清理敌人", {}, "", function()
            local counter = 0
            for _, ped in entities.get_all_peds_as_handles() do
                if HUD.GET_BLIP_COLOUR(HUD.GET_BLIP_FROM_ENTITY(ped)) == 1 or TASK.GET_IS_TASK_ACTIVE(ped, 352) then -- shitty way to go about it but hey, it works (most of the time).
                    ENTITY.SET_ENTITY_HEALTH(ped, 0)
                    counter += 1
                    util.yield()
                end
            end
            if counter == 0 then
                util.toast("没有发现敌人. :/")
            else
                util.toast("已清理 ".. tostring(counter) .." 个敌人.")
            end
        end)
        menu.action(renwu, "将拾取物传送到自己", {}, "", function()
            local counter = 0
            local pos = players.get_position(players.user())
            for _, pickup in entities.get_all_pickups_as_handles() do
                ENTITY.SET_ENTITY_COORDS(pickup, pos, false, false, false, false)
                counter += 1
                util.yield()
            end
            if counter == 0 then
                util.toast("没有发现可捡拾物. :/")
            else
                util.toast("已传送 ".. tostring(counter) .." 个拾取物.")
            end
        end)
        menu.toggle_loop(renwu, "快速更换武器", {"fasthands"}, "更快地更换你的武器.", function()
            if TASK.GET_IS_TASK_ACTIVE(players.user_ped(), 56) then
                PED.FORCE_PED_AI_AND_ANIMATION_UPDATE(players.user_ped())
            end
        end)
        menu.toggle_loop(renwu, "锁定玩家", {}, "允许您使用武装载具上的制导导弹发射器锁定玩家.", function()
            for _, pid in players.list(true, true, true) do
                local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                PLAYER.ADD_PLAYER_TARGETABLE_ENTITY(players.user(), ped)
                ENTITY.SET_ENTITY_IS_TARGET_PRIORITY(ped, false, 400.0)    
            end
        end, function()
            for _, pid in players.list(true, true, true) do
                local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
                PLAYER.REMOVE_PLAYER_TARGETABLE_ENTITY(players.user(), ped)
            end
        end)
        
        if menu.get_edition() > 1 then
            menu.toggle_loop(renwu, "瞄准时的透视", {"aimesp"}, "", function()
                if PLAYER.IS_PLAYER_FREE_AIMING(players.user()) then
                    menu.trigger_command(menu.ref_by_path("World>Inhabitants>Player ESP>Bone ESP>Low Latency Rendering"))
                else
                    menu.trigger_command(menu.ref_by_path("World>Inhabitants>Player ESP>Bone ESP>Disabled"))
                end
            end, function()
                menu.trigger_command(menu.ref_by_path("World>Inhabitants>Player ESP>Bone ESP>Disabled"))
            end)
        end
        


--------------------------------------------------------------------------------------------------------------------------------