------------------------------------------------------
--                AUTOMATIC HEIST
------------------------------------------------------

local Menu_Root <const> = menu.my_root()

local Automatic_Heist <const> = menu.list(Menu_Root, "自动化抢劫任务", {}, "")


--------------------
-- Globals
--------------------

local bTransitionSessionSkipLbAndNjvs = g_sTransitionSessionData + 702

GlobalplayerBD_FM.eCoronaStatus = function()
    return Globals.GlobalplayerBD_FM() + 193
end

g_HeistPlanningClient.bLaunchTimerExpired = 1931285 + 2812


--------------------
-- Locals
--------------------

-- `fmmc_launcher`
-- CORONA_MENU_DATA
local _coronaMenuData = 17602
local coronaMenuData = {
    iCurrentSelection = _coronaMenuData + 920
}




--------------------
-- Functions
--------------------

local CORONA_STATUS_ENUM <const> = {
    CORONA_STATUS_IDLE = 0,
    CORONA_STATUS_INTRO = 9,
    CORONA_STATUS_TEAM_DM = 26,
    CORONA_STATUS_HEIST_PLANNING = 27,
    CORONA_STATUS_GENERIC_HEIST_PLANNING = 34
}

local function GET_CORONA_STATUS()
    return GLOBAL_GET_INT(GlobalplayerBD_FM.eCoronaStatus())
end

local function IS_PLAYER_IN_CORONA()
    return GLOBAL_GET_INT(GlobalplayerBD_FM.eCoronaStatus()) ~= CORONA_STATUS_ENUM.CORONA_STATUS_IDLE
end


local function draw_top_centred_text(text)
    local scale = 0.6

    local text_width, text_height = directx.get_text_size(text, scale)
    local text_x = 0.5 - text_width / 2

    directx.draw_rect(text_x - 0.01, 0.0,
        text_width + 0.03, text_height + 0.02,
        { r = 0.0, g = 0.0, b = 0.0, a = 0.6 })
    directx.draw_text(text_x, 0.01, text, ALIGN_TOP_LEFT, scale,
        { r = 1, g = 0, b = 1, a = 1 })
end




--------------------------------------
--    Auto Island Heist
--------------------------------------

local Auto_Island_Heist <const> = menu.list(Automatic_Heist, "全自动佩里科岛抢劫", {}, "")


local AutoIslandHeistStatus <const> = {
    Disable = 0,
    Freemode = 1,
    InKotsatka = 2,
    RegisterAsCEO = 3,
    CoronaIntro = 4,
    CoronaHeistPlanning = 5,
    CoronaTeamDM = 6,
    InMission = 7,
    MissionEnd = 8,
    Cleanup = 9
}


local AutoIslandHeist = {
    menuAction = 0,
    enable = false,
    status = AutoIslandHeistStatus.Disable,

    spawnLocation = nil,

    setting = {
        rewardValue = 2000000,
        addRandom = true,
        disableCut = false,
        delay = 1500,
        disableToast = false,
        disableDraw = false
    }
}

function AutoIslandHeist.setStatus(eStatus)
    AutoIslandHeist.status = eStatus
end

function AutoIslandHeist.getSpawnLocation()
    return STAT_GET_INT(MPX("SPAWN_LOCATION_SETTING"))
end

function AutoIslandHeist.setSpawnLocation(iLocation)
    STAT_SET_INT(MPX("SPAWN_LOCATION_SETTING"), iLocation)
end

function AutoIslandHeist.toggleActionName(toggle)
    if toggle then
        menu.set_menu_name(AutoIslandHeist.menuAction, "开启 全自动佩里科岛抢劫")
    else
        menu.set_menu_name(AutoIslandHeist.menuAction, "停止 全自动佩里科岛抢劫")
    end
end

function AutoIslandHeist.cleanup()
    if AutoIslandHeist.spawnLocation then
        AutoIslandHeist.setSpawnLocation(AutoIslandHeist.spawnLocation)
    end

    AutoIslandHeist.enable = false
    AutoIslandHeist.status = AutoIslandHeistStatus.Disable
    AutoIslandHeist.toggleActionName(true)
end

function AutoIslandHeist.toast(text)
    if not AutoIslandHeist.setting.disableToast then
        util.toast("[全自动佩里科岛抢劫] " .. text)
    end
end

function AutoIslandHeist.draw(text)
    if not AutoIslandHeist.setting.disableDraw then
        draw_top_centred_text("[全自动佩里科岛抢劫] " .. text)
    end
end

AutoIslandHeist.menuAction = menu.action(Auto_Island_Heist, "开启 全自动佩里科岛抢劫", {}, "[仅适用于单人]", function()
    if AutoIslandHeist.enable then
        AutoIslandHeist.enable = false
        return
    end

    if IS_MISSION_CONTROLLER_SCRIPT_RUNNING() then
        return
    end
    if not DOES_PLAYER_OWN_KOSATKA() then
        util.toast("你需要拥有虎鲸")
        return
    end

    if AutoIslandHeist.setting.rewardValue ~= -1 then
        -- Add random value
        if AutoIslandHeist.setting.addRandom then
            AutoIslandHeist.setting.rewardValue = AutoIslandHeist.setting.rewardValue +
                math.random(0, 50000)
        end

        -- Calculate estimated reward value
        local estimatedValue = AutoIslandHeist.setting.rewardValue
        if not AutoIslandHeist.setting.disableCut then
            estimatedValue = math.ceil(estimatedValue * 0.88)
        end
        AutoIslandHeist.toast("预计收入: " .. estimatedValue)
    end

    AutoIslandHeist.toggleActionName(false)
    AutoIslandHeist.enable = true
    AutoIslandHeist.spawnLocation = nil

    AutoIslandHeist.setStatus(AutoIslandHeistStatus.Freemode)

    util.create_tick_handler(function()
        if not AutoIslandHeist.enable then
            AutoIslandHeist.cleanup()
            AutoIslandHeist.toast("已停止...")
            return false
        end

        local setting = AutoIslandHeist.setting
        local eStatus = AutoIslandHeist.status
        local statusText = ""

        if eStatus == AutoIslandHeistStatus.Freemode then
            if not IS_PLAYER_IN_KOSATKA() then
                AutoIslandHeist.spawnLocation = AutoIslandHeist.getSpawnLocation()
                AutoIslandHeist.setSpawnLocation(16) -- MP_SETTING_SPAWN_SUBMARINE
                menu.trigger_commands("go inviteonly")

                AutoIslandHeist.toast("切换战局到虎鲸...")
            end
            AutoIslandHeist.setStatus(AutoIslandHeistStatus.InKotsatka)
        elseif eStatus == AutoIslandHeistStatus.InKotsatka then
            if IS_IN_SESSION() then
                if IS_PLAYER_IN_KOSATKA() then
                    util.yield(setting.delay)

                    if not IS_PLAYER_BOSS_OF_A_GANG() then
                        menu.trigger_commands("ceostart")

                        AutoIslandHeist.toast("注册为CEO...")
                        AutoIslandHeist.setStatus(AutoIslandHeistStatus.RegisterAsCEO)
                    else
                        local Data = {
                            iRootContentID = -1172878953, -- HIM_STUB
                            iMissionType = 260,           -- FMMC_TYPE_HEIST_ISLAND_FINALE
                            iMissionEnteryType = 67,      -- ciMISSION_ENTERY_TYPE_HEIST_ISLAND_TABLE
                        }
                        LAUNCH_MISSION(Data)

                        AutoIslandHeist.toast("启动差事...")
                        AutoIslandHeist.setStatus(AutoIslandHeistStatus.CoronaIntro)
                    end
                end
            end
        elseif eStatus == AutoIslandHeistStatus.RegisterAsCEO then
            if IS_PLAYER_BOSS_OF_A_GANG() then
                util.yield(setting.delay)

                AutoIslandHeist.setStatus(AutoIslandHeistStatus.InKotsatka)
            end
        elseif eStatus == AutoIslandHeistStatus.CoronaIntro then
            statusText = "等待差事加载..."

            local script = "fmmc_launcher"
            if IS_SCRIPT_RUNNING(script) then
                if GET_CORONA_STATUS() == CORONA_STATUS_ENUM.CORONA_STATUS_INTRO then
                    util.yield(setting.delay)

                    LOCAL_SET_INT(script, sLaunchMissionDetails.iMaxParticipants, 1)

                    AutoIslandHeist.toast("开始游戏...")
                    AutoIslandHeist.setStatus(AutoIslandHeistStatus.CoronaHeistPlanning)
                end
            end
        elseif eStatus == AutoIslandHeistStatus.CoronaHeistPlanning then
            statusText = "等待继续..."

            if IS_SCRIPT_RUNNING("heist_island_planning") then
                local script = "fmmc_launcher"
                if IS_SCRIPT_RUNNING(script) then
                    if GET_CORONA_STATUS() == CORONA_STATUS_ENUM.CORONA_STATUS_GENERIC_HEIST_PLANNING then
                        util.yield(setting.delay)


                        local sConfig = GlobalPlayerBD_HeistIsland.sConfig()

                        local Data = {
                            bHardModeEnabled = false,
                            eApproachVehicle = 6,
                            eInfiltrationPoint = 3,
                            eCompoundEntrance = 0,
                            eEscapePoint = 1,
                            eTimeOfDay = 1,
                            eWeaponLoadout = 1,
                            bUseSuppressors = true
                        }
                        GLOBAL_SET_INT(sConfig + 35, Data.eWeaponLoadout)
                        GLOBAL_SET_BOOL(sConfig + 38, Data.bHardModeEnabled)
                        GLOBAL_SET_INT(g_FMMC_STRUCT.iDifficulity, DIFF_NORMAL)

                        GLOBAL_SET_INT(sConfig + 39, Data.eApproachVehicle)
                        GLOBAL_SET_INT(sConfig + 40, Data.eInfiltrationPoint)
                        GLOBAL_SET_INT(sConfig + 41, Data.eCompoundEntrance)
                        GLOBAL_SET_INT(sConfig + 42, Data.eEscapePoint)
                        GLOBAL_SET_INT(sConfig + 43, Data.eTimeOfDay)
                        GLOBAL_SET_BOOL(sConfig + 44, Data.bUseSuppressors)

                        SET_NET_TIMER_STARTED_AND_EXPIRED(GlobalPlayerBD_NetHeistPlanningGeneric.stFinaleLaunchTimer())

                        AutoIslandHeist.toast("设置面板并继续...")
                        AutoIslandHeist.setStatus(AutoIslandHeistStatus.CoronaTeamDM)
                    end
                end
            end
        elseif eStatus == AutoIslandHeistStatus.CoronaTeamDM then
            local script = "fmmc_launcher"
            if IS_SCRIPT_RUNNING(script) then
                if GET_CORONA_STATUS() == CORONA_STATUS_ENUM.CORONA_STATUS_TEAM_DM then
                    util.yield(setting.delay)

                    -- ciCORONA_LOBBY_START_GAME
                    LOCAL_SET_INT(script, coronaMenuData.iCurrentSelection, 14)

                    -- FRONTEND_CONTROL, INPUT_FRONTEND_ACCEPT
                    PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 201, 1.0)

                    AutoIslandHeist.toast("准备就绪，进入任务...")
                    AutoIslandHeist.setStatus(AutoIslandHeistStatus.InMission)
                end
            end
        elseif eStatus == AutoIslandHeistStatus.InMission then
            statusText = "等待任务开始..."

            if IS_IN_SESSION() then
                local script = "fm_mission_controller_2020"
                if IS_SCRIPT_RUNNING(script) then
                    -- GAME_STATE_RUNNING
                    if LOCAL_GET_INT(script, Locals[script].iServerGameState) == 6 then
                        util.yield(setting.delay + 3000)

                        if setting.rewardValue ~= -1 then
                            Tunables.SetIntList("IslandHeistPrimaryTargetValue", setting.rewardValue)
                        end
                        if setting.disableCut then
                            Tunables.SetFloatList("NpcCut", 0)
                        end
                        INSTANT_FINISH_FM_MISSION_CONTROLLER()

                        -- g_sTransitionSessionData.bTransitionSessionSkipLbAndNjvs
                        GLOBAL_SET_BOOL(bTransitionSessionSkipLbAndNjvs, true)

                        AutoIslandHeist.toast("直接完成任务...")
                        AutoIslandHeist.setStatus(AutoIslandHeistStatus.MissionEnd)
                    end
                end
            end
        elseif eStatus == AutoIslandHeistStatus.MissionEnd then
            statusText = "等待任务结束..."

            if not IS_SCRIPT_RUNNING("fm_mission_controller_2020") then
                AutoIslandHeist.toast("任务已完成...")
                AutoIslandHeist.setStatus(AutoIslandHeistStatus.Cleanup)
            end
        elseif eStatus == AutoIslandHeistStatus.Cleanup then
            AutoIslandHeist.cleanup()
            AutoIslandHeist.toast("结束...")
            return false
        end

        if statusText ~= "" then
            AutoIslandHeist.draw(statusText)
        end
    end)
end)

menu.divider(Auto_Island_Heist, "收入")
local Auto_Island_Heist_Reward = menu.slider(Auto_Island_Heist, "主要目标价值", { "AutoIslandHeistRewardValue" }, "",
    -1, 2550000, AutoIslandHeist.setting.rewardValue, 50000, function(value)
        AutoIslandHeist.setting.rewardValue = value
    end)
menu.add_value_replacement(Auto_Island_Heist_Reward, -1, Labels.Default)
menu.toggle(Auto_Island_Heist, "添加随机数", {}, "主要目标价值加0 ~ 50000的随机数", function(toggle)
    AutoIslandHeist.setting.addRandom = toggle
end, true)
menu.toggle(Auto_Island_Heist, "禁用NPC分红", {}, "", function(toggle)
    AutoIslandHeist.setting.disableCut = toggle
end)

menu.divider(Auto_Island_Heist, "设置")
menu.slider(Auto_Island_Heist, "延迟", { "AutoIslandHeistDelay" }, "到达新的状态后的等待时间",
    0, 5000, AutoIslandHeist.setting.delay, 100, function(value)
        AutoIslandHeist.setting.delay = value
    end)
menu.toggle(Auto_Island_Heist, "禁用通知提示", {}, "", function(toggle)
    AutoIslandHeist.setting.disableToast = toggle
end)
menu.toggle(Auto_Island_Heist, "禁用绘制提示文本", {}, "", function(toggle)
    AutoIslandHeist.setting.disableDraw = toggle
end)








--------------------------------------
--    Auto Apartment Heist
--------------------------------------

local Auto_Apartment_Heist <const> = menu.list(Automatic_Heist, "全自动公寓抢劫", {}, "")


local AutoApartmentHeistStatus <const> = {
    Disable = 0,
    InPlanningRoom = 1,
    CoronaIntro = 2,
    CoronaHeistPlanning = 3,
    CoronaTeamDM = 4,
    InMission = 5,
    MissionEnd = 6,
    Cleanup = 7
}


local AutoApartmentHeist = {
    menuAction = 0,
    enable = false,
    status = AutoApartmentHeistStatus.Disable,

    minPlayers = false,
    maxTeams = false,

    setting = {
        delay = 1500,
        disableToast = false,
        disableDraw = false
    }
}

function AutoApartmentHeist.processHeistAward()
    for _, item in pairs(Tables.HeistAwardsStats) do
        STAT_SET_INT(item[1], 268435455)
        STAT_SET_BOOL(item[2], false)
    end

    local script = "fm_mission_controller"

    -- Ultimate Challenge
    GLOBAL_SET_INT(g_FMMC_STRUCT.iDifficulity, DIFF_HARD)
    -- First Person
    GLOBAL_SET_INT(g_FMMC_STRUCT.iFixedCamera, 1)
    -- Member
    GLOBAL_SET_BOOL(g_TransitionSessionNonResetVars.bAmIHeistLeader, false)
    LOCAL_CLEAR_BIT(script, Locals[script].iClientBitSet(), 20) -- PBBOOL_HEIST_HOST
end

function AutoApartmentHeist.setStatus(eStatus)
    AutoApartmentHeist.status = eStatus
end

function AutoApartmentHeist.toggleActionName(toggle)
    if toggle then
        menu.set_menu_name(AutoApartmentHeist.menuAction, "开启 全自动公寓抢劫")
    else
        menu.set_menu_name(AutoApartmentHeist.menuAction, "停止 全自动公寓抢劫")
    end
end

function AutoApartmentHeist.cleanup()
    menu.set_value(MissionMinPlayers, AutoApartmentHeist.minPlayers)
    menu.set_value(MissionMaxTeams, AutoApartmentHeist.maxTeams)

    AutoApartmentHeist.enable = false
    AutoApartmentHeist.status = AutoApartmentHeistStatus.Disable
    AutoApartmentHeist.toggleActionName(true)
end

function AutoApartmentHeist.toast(text)
    if not AutoApartmentHeist.setting.disableToast then
        util.toast("[全自动公寓抢劫] " .. text)
    end
end

function AutoApartmentHeist.draw(text)
    if not AutoApartmentHeist.setting.disableDraw then
        draw_top_centred_text("[全自动公寓抢劫] " .. text)
    end
end

AutoApartmentHeist.menuAction = menu.action(Auto_Apartment_Heist, "开启 全自动公寓抢劫", {},
    "[仅适用于单人]\n同时完成所有奖章挑战, 可获得1400多万\n1. 需要在公寓内部 抢劫计划面板附近\n2. 启动差事后右下角没有提示下载，就动两下\n3. 如果精英挑战没有完成就增加延迟", function()
        if AutoApartmentHeist.enable then
            AutoApartmentHeist.enable = false
            return
        end

        if IS_MISSION_CONTROLLER_SCRIPT_RUNNING() then
            return
        end
        if not IS_PLAYER_IN_INTERIOR() then
            util.toast("你需要在公寓内部")
            return
        end
        if not IS_PLAYER_NEAR_HEIST_PLANNING_BOARD() then
            util.toast("你需要在抢劫计划面板附近")
            return
        end

        AutoApartmentHeist.minPlayers = menu.get_value(MissionMinPlayers)
        AutoApartmentHeist.maxTeams = menu.get_value(MissionMaxTeams)

        menu.set_value(MissionMinPlayers, true)
        menu.set_value(MissionMaxTeams, true)

        AutoApartmentHeist.toggleActionName(false)
        AutoApartmentHeist.enable = true

        AutoApartmentHeist.setStatus(AutoApartmentHeistStatus.InPlanningRoom)

        util.create_tick_handler(function()
            if not AutoApartmentHeist.enable then
                AutoApartmentHeist.cleanup()
                AutoApartmentHeist.toast("已停止...")
                return false
            end

            local setting = AutoApartmentHeist.setting
            local eStatus = AutoApartmentHeist.status
            local statusText = ""

            if eStatus == AutoApartmentHeistStatus.InPlanningRoom then
                local ContentID = "tYc3SkqXTk6ia7j0lezrbQ"
                LAUNCH_APARTMENT_HEIST(ContentID)

                AutoApartmentHeist.toast("启动差事...")
                AutoApartmentHeist.setStatus(AutoApartmentHeistStatus.CoronaIntro)
            elseif eStatus == AutoApartmentHeistStatus.CoronaIntro then
                statusText = "等待差事加载... (右下角没有提示下载就动两下)"

                local script = "fmmc_launcher"
                if IS_SCRIPT_RUNNING(script) then
                    if GET_CORONA_STATUS() == CORONA_STATUS_ENUM.CORONA_STATUS_INTRO then
                        util.yield(setting.delay)

                        LOCAL_SET_INT(script, sLaunchMissionDetails.iMaxParticipants, 1)

                        GLOBAL_SET_BIT(g_TransitionSessionNonResetVars.sTransVars.iCoronaBitSet + 1 + 4, 0)   -- CORONA_HEIST_CUTSCENE_HAS_BEEN_VALIDATED
                        GLOBAL_CLEAR_BIT(g_TransitionSessionNonResetVars.sTransVars.iCoronaBitSet + 1 + 4, 1) -- CORONA_HEIST_FINALE_CUTSCENE_CAN_PLAY

                        AutoApartmentHeist.toast("开始游戏...")
                        AutoApartmentHeist.setStatus(AutoApartmentHeistStatus.CoronaHeistPlanning)
                    end
                end
            elseif eStatus == AutoApartmentHeistStatus.CoronaHeistPlanning then
                statusText = "等待继续..."

                if GET_CORONA_STATUS() == CORONA_STATUS_ENUM.CORONA_STATUS_HEIST_PLANNING then
                    util.yield(setting.delay)

                    GLOBAL_SET_BOOL(g_HeistPlanningClient.bLaunchTimerExpired, true)

                    AutoApartmentHeist.toast("继续...")
                    AutoApartmentHeist.setStatus(AutoApartmentHeistStatus.CoronaTeamDM)
                end
            elseif eStatus == AutoApartmentHeistStatus.CoronaTeamDM then
                local script = "fmmc_launcher"
                if IS_SCRIPT_RUNNING(script) then
                    if GET_CORONA_STATUS() == CORONA_STATUS_ENUM.CORONA_STATUS_TEAM_DM then
                        util.yield(setting.delay)

                        -- ciCORONA_LOBBY_START_GAME
                        LOCAL_SET_INT(script, coronaMenuData.iCurrentSelection, 14)

                        -- FRONTEND_CONTROL, INPUT_FRONTEND_ACCEPT
                        PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 201, 1.0)

                        AutoApartmentHeist.toast("准备就绪，进入任务...")
                        AutoApartmentHeist.setStatus(AutoApartmentHeistStatus.InMission)
                    end
                end
            elseif eStatus == AutoApartmentHeistStatus.InMission then
                statusText = "等待任务开始..."

                if IS_IN_SESSION() then
                    local script = "fm_mission_controller"
                    if IS_SCRIPT_RUNNING(script) then
                        -- GAME_STATE_RUNNING
                        if LOCAL_GET_INT(script, Locals[script].iServerGameState) == 9 then
                            util.yield(setting.delay + 1000)

                            AutoApartmentHeist.processHeistAward()
                            INSTANT_FINISH_FM_MISSION_CONTROLLER()

                            AutoApartmentHeist.toast("直接完成任务...")
                            AutoApartmentHeist.setStatus(AutoApartmentHeistStatus.MissionEnd)
                        end
                    end
                end
            elseif eStatus == AutoApartmentHeistStatus.MissionEnd then
                statusText = "等待任务结束..."

                if not IS_SCRIPT_RUNNING("fm_mission_controller") then
                    AutoApartmentHeist.toast("任务已完成...")
                    AutoApartmentHeist.setStatus(AutoApartmentHeistStatus.Cleanup)
                end
            elseif eStatus == AutoApartmentHeistStatus.Cleanup then
                AutoApartmentHeist.cleanup()
                AutoApartmentHeist.toast("结束...")
                return false
            end

            if statusText ~= "" then
                AutoApartmentHeist.draw(statusText)
            end
        end)
    end)


menu.divider(Auto_Apartment_Heist, "设置")
menu.slider(Auto_Apartment_Heist, "延迟", { "AutoApartmentHeistDelay" }, "到达新的状态后的等待时间",
    0, 5000, AutoApartmentHeist.setting.delay, 100, function(value)
        AutoApartmentHeist.setting.delay = value
    end)
menu.toggle(Auto_Apartment_Heist, "禁用通知提示", {}, "", function(toggle)
    AutoApartmentHeist.setting.disableToast = toggle
end)
menu.toggle(Auto_Apartment_Heist, "禁用绘制提示文本", {}, "", function(toggle)
    AutoApartmentHeist.setting.disableDraw = toggle
end)

menu.divider(Auto_Apartment_Heist, "")
menu.action(Auto_Apartment_Heist, "清除奖章挑战记录", {}, "", function()
    for _, item in pairs(Tables.HeistAwardsStats) do
        STAT_SET_INT(item[1], 0)
        STAT_SET_BOOL(item[2], false)
    end
    util.toast("完成！")
end)
