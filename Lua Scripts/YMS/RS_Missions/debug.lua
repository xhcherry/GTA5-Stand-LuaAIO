local Menu_Root <const> = YMRS

menu.divider(Menu_Root, "DEBUG")

local Freemode_Mission = Menu_Root
local Heist_Mission = Menu_Root


local LocalsTest = {
    ["fm_content_vehrob_arena"] = {
        iChallengeCondition = 7807 + 1342 + 14,
        iChallengeBitset = 7807 + 1340,

        eEndReason = 7807 + 1285,
        iGenericBitset = 7748
    },
    ["fm_content_vehrob_cargo_ship"] = {
        iChallengeBitset = 7025 + 1286,

        eEndReason = 7025 + 1224,
        iGenericBitset = 6934
    },
    ["fm_content_vehrob_casino_prize"] = {
        iChallengeBitset = 9060 + 1310,

        eEndReason = 9060 + 1231,
        iGenericBitset = 8979
    },
    ["fm_content_vehrob_police"] = {
        iChallengeCondition = 8847 + 1333 + 8 + 1, -- +[0~2]

        eEndReason = 8847 + 1276,
        iGenericBitset = 8772
    },
    ["fm_content_vehrob_submarine"] = {
        iChallengeCondition = 6125 + 1199 + 19,
        iChallengeBitset = 6125 + 1196,

        eEndReason = 6125 + 1137,
        iGenericBitset = 6041
    },
    ["fm_content_chop_shop_delivery"] = {
        iMissionEntityBitSet = 1893 + 2 + 14,

        eEndReason = 1893 + 137,
        iGenericBitset = 1835
    }
}


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



local bTransitionSessionSkipLbAndNjvs = g_sTransitionSessionData + 702

-- `fmmc_launcher`
-- CORONA_MENU_DATA
local _coronaMenuData = 17445
local coronaMenuData = {
    iCurrentSelection = _coronaMenuData + 911,
}

local _sLaunchMissionDetails = 19709
local sLaunchMissionDetails2 = {
    iIntroStatus = _sLaunchMissionDetails,
    iHeistStatus = _sLaunchMissionDetails + 3,
    iLobbyStatus = _sLaunchMissionDetails + 4,
    iInviteScreenStatus = _sLaunchMissionDetails + 6,
    iInCoronaStatus = _sLaunchMissionDetails + 7,
    iBettingStatus = _sLaunchMissionDetails + 10,
    iLoadStatus = _sLaunchMissionDetails + 11,

    iMaxParticipants = _sLaunchMissionDetails + 32,
}




GlobalplayerBD_FM.eCoronaStatus = function()
    return Globals.GlobalplayerBD_FM() + 193
end

g_TransitionSessionNonResetVars.sTransVars = {
    iCoronaBitSet = 2685444 + 1 + 2813
}

g_HeistPlanningClient.bLaunchTimerExpired = 1930926 + 2812



local CORONA_STATUS_ENUM = {
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




------------------------------------
--    Auto Island Heist
------------------------------------

local Auto_Island_Heist <const> = menu.list(Menu_Root, "全自动佩里科岛抢劫", {}, "")


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
    return STAT_GET_INT(ADD_MP_INDEX("SPAWN_LOCATION_SETTING"))
end

function AutoIslandHeist.setSpawnLocation(iLocation)
    STAT_SET_INT(ADD_MP_INDEX("SPAWN_LOCATION_SETTING"), iLocation)
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

                    LOCAL_SET_INT(script, sLaunchMissionDetails2.iMaxParticipants, 1)

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
                        GLOBAL_SET_INT(FMMC_STRUCT.iDifficulity, DIFF_NORMAL)

                        GLOBAL_SET_INT(sConfig + 39, Data.eApproachVehicle)
                        GLOBAL_SET_INT(sConfig + 40, Data.eInfiltrationPoint)
                        GLOBAL_SET_INT(sConfig + 41, Data.eCompoundEntrance)
                        GLOBAL_SET_INT(sConfig + 42, Data.eEscapePoint)
                        GLOBAL_SET_INT(sConfig + 43, Data.eTimeOfDay)
                        GLOBAL_SET_BOOL(sConfig + 44, Data.bUseSuppressors)

                        GLOBAL_SET_INT(GlobalPlayerBD_NetHeistPlanningGeneric.stFinaleLaunchTimer() + 1, 1)
                        GLOBAL_SET_INT(GlobalPlayerBD_NetHeistPlanningGeneric.stFinaleLaunchTimer(), 0)

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





------------------------------------
--    Auto Apartment Heist
------------------------------------

local Auto_Apartment_Heist <const> = menu.list(Menu_Root, "全自动公寓抢劫", {}, "")


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
    GLOBAL_SET_INT(FMMC_STRUCT.iDifficulity, DIFF_HARD)
    -- First Person
    GLOBAL_SET_INT(FMMC_STRUCT.iFixedCamera, 1)
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
        if not IS_PLAYER_IN_APARTMENT_PLANNING_ROOM() then
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

                        LOCAL_SET_INT(script, sLaunchMissionDetails2.iMaxParticipants, 1)

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








------------------------------------
--    Salvage Yard Robbery
------------------------------------

local Salvage_Yard_Robbery <const> = menu.list(Freemode_Mission, get_label_text("SCOUT_BIG_START"), {}, "")

local SalvageYardRobberyVars = {
    challengeCompleted = true
}

local SalvageYardRobberyChallenge = {
    ["fm_content_vehrob_arena"] = function(script)
        LOCAL_SET_INT(script, LocalsTest[script].iChallengeCondition, 100)
        LOCAL_CLEAR_BITS(script, LocalsTest[script].iChallengeBitset + 1 + 0, 17, 18)
    end,
    ["fm_content_vehrob_cargo_ship"] = function(script)
        LOCAL_CLEAR_BITS(script, LocalsTest[script].iChallengeBitset + 1 + 0, 31)
        LOCAL_CLEAR_BITS(script, LocalsTest[script].iChallengeBitset + 1 + 1, 0, 1) -- 32, 33
    end,
    ["fm_content_vehrob_casino_prize"] = function(script)
        LOCAL_CLEAR_BITS(script, LocalsTest[script].iChallengeBitset + 1 + 0, 24, 25, 26)
    end,
    ["fm_content_vehrob_police"] = function(script)
        for i = 0, 2 do
            LOCAL_SET_INT(script, LocalsTest[script].iChallengeCondition + i, 1)
        end
    end,
    ["fm_content_vehrob_submarine"] = function(script)
        LOCAL_SET_INT(script, LocalsTest[script].iChallengeCondition, 100)
        LOCAL_CLEAR_BITS(script, LocalsTest[script].iChallengeBitset + 1 + 1, 9, 10) -- 41, 42
    end
}

menu.action(Salvage_Yard_Robbery, "直接完成 回收站抢劫 前置任务", {}, "", function()
    local data = {
        ["fm_content_vehrob_scoping"] = {
            eEndReason = 3752 + 508,
            iGenericBitset = 3695
        },
        ["fm_content_vehrob_prep"] = {
            eEndReason = 11366 + 1272,
            iGenericBitset = 11265
        },
        ["fm_content_vehrob_task"] = {
            eEndReason = 4773 + 1043,
            iGenericBitset = 4705
        },
        ["fm_content_vehrob_disrupt"] = {
            eEndReason = 4570 + 924,
            iGenericBitset = 4511
        }
    }

    for script, item in pairs(data) do
        if IS_SCRIPT_RUNNING(script) then
            LOCAL_SET_BIT(script, item.iGenericBitset + 1 + 0, 11)
            LOCAL_SET_INT(script, item.eEndReason, 3)
        end
    end
end)

menu.toggle(Salvage_Yard_Robbery, get_label_text("SAL23_ENDS_CHAL"), {}, "", function(toggle)
    SalvageYardRobberyVars.challengeCompleted = toggle
end, true)

menu.action(Salvage_Yard_Robbery, "直接完成 回收站抢劫 终章", {}, "", function()
    for script, func in pairs(SalvageYardRobberyChallenge) do
        if IS_SCRIPT_RUNNING(script) then
            if SalvageYardRobberyVars.challengeCompleted then
                func(script)
            end

            LOCAL_SET_BIT(script, LocalsTest[script].iGenericBitset + 1 + 0, 11)
            LOCAL_SET_INT(script, LocalsTest[script].eEndReason, 3)
        end
    end
end)


menu.divider(Salvage_Yard_Robbery, "Sell")

menu.action(Salvage_Yard_Robbery, "直接完成 出售任务", {}, "", function()
    local script = "fm_content_chop_shop_delivery"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
    end

    local iMissionEntity = 0
    LOCAL_SET_BIT(script, LocalsTest[script].iMissionEntityBitSet + 1 + iMissionEntity * 3 + 1 + 0, 4) -- eMISSIONENTITYBITSET_DELIVERED

    LOCAL_SET_BIT(script, LocalsTest[script].iGenericBitset + 1 + 0, 11)
    LOCAL_SET_INT(script, LocalsTest[script].eEndReason, 3)
end)




----------------------------------------
--    Bail Office
----------------------------------------

local Bail_Office <const> = menu.list(Heist_Mission, get_label_text("CELL_BAIL_OF"), {}, "")

menu.list_action(Bail_Office, "启动差事: 头号通缉犯", {}, "", {
    { -1814367299, "头号通缉犯：惠特尼" },
    { -1443228923, "头号通缉犯：里伯曼" },
    { -625494467, "头号通缉犯：奥尼尔" },
    { -1381858108, "头号通缉犯：汤普森" },
    { 1585225527, "头号通缉犯：宋" },
    { -62594295, "头号通缉犯：加西亚" },
}, function(value)
    if IS_MISSION_CONTROLLER_SCRIPT_RUNNING() then
        return
    end

    local Data = {
        iRootContentID = value,
        iMissionType = 0,        -- FMMC_TYPE_MISSION
        iMissionEnteryType = 32, -- ciMISSION_ENTERY_TYPE_V2_CORONA
    }

    LAUNCH_MISSION(Data)
    util.toast("请稍等...")
end)







local fm_content_xxx = {
    { script = "fm_content_acid_lab_sell",       eEndReason = 5483 + 1294,  iGenericBitset = 5418 },
    { script = "fm_content_acid_lab_setup",      eEndReason = 3348 + 541,   iGenericBitset = 3294 },
    { script = "fm_content_acid_lab_source",     eEndReason = 7654 + 1162,  iGenericBitset = 7577 },
    { script = "fm_content_ammunation",          eEndReason = 2079 + 204,   iGenericBitset = 2025 },
    { script = "fm_content_armoured_truck",      eEndReason = 1902 + 113,   iGenericBitset = 1836 },
    { script = "fm_content_auto_shop_delivery",  eEndReason = 1572 + 83,    iGenericBitset = 1518 },
    { script = "fm_content_bank_shootout",       eEndReason = 2209 + 221,   iGenericBitset = 2138 },
    { script = "fm_content_bar_resupply",        eEndReason = 2275 + 287,   iGenericBitset = 2219 },
    { script = "fm_content_bicycle_time_trial",  eEndReason = 2942 + 83,    iGenericBitset = 2886 },
    { script = "fm_content_bike_shop_delivery",  eEndReason = 1574 + 83,    iGenericBitset = 1518 },
    { script = "fm_content_bounty_targets",      eEndReason = 7019 + 1251,  iGenericBitset = 6941 },
    { script = "fm_content_business_battles",    eEndReason = 5257 + 1138,  iGenericBitset = 5186 },
    { script = "fm_content_cargo",               eEndReason = 5830 + 1148,  iGenericBitset = 5761 },
    { script = "fm_content_cerberus",            eEndReason = 1589 + 91,    iGenericBitset = 1539 },
    { script = "fm_content_chop_shop_delivery",  eEndReason = 1893 + 137,   iGenericBitset = 1835 },
    { script = "fm_content_clubhouse_contracts", eEndReason = 6639 + 1255,  iGenericBitset = 6573 },
    { script = "fm_content_club_management",     eEndReason = 5207 + 775,   iGenericBitset = 5148 },
    { script = "fm_content_club_odd_jobs",       eEndReason = 1794 + 83,    iGenericBitset = 1738 },
    { script = "fm_content_club_source",         eEndReason = 3540 + 674,   iGenericBitset = 3467 },
    { script = "fm_content_convoy",              eEndReason = 2736 + 437,   iGenericBitset = 2672 },
    { script = "fm_content_crime_scene",         eEndReason = 1948 + 151,   iGenericBitset = 1892 },
    { script = "fm_content_daily_bounty",        eEndReason = 2533 + 325,   iGenericBitset = 2480 },
    { script = "fm_content_dispatch_work",       eEndReason = 4856 + 755,   iGenericBitset = 4797 },
    { script = "fm_content_drug_lab_work",       eEndReason = 7884 + 1253,  iGenericBitset = 7820 },
    { script = "fm_content_drug_vehicle",        eEndReason = 1762 + 115,   iGenericBitset = 1707 },
    { script = "fm_content_export_cargo",        eEndReason = 2200 + 191,   iGenericBitset = 2146 },
    { script = "fm_content_ghosthunt",           eEndReason = 1552 + 88,    iGenericBitset = 1499 },
    { script = "fm_content_golden_gun",          eEndReason = 1762 + 93,    iGenericBitset = 1711 },
    { script = "fm_content_gunrunning",          eEndReason = 5639 + 1237,  iGenericBitset = 5566 },
    { script = "fm_content_island_dj",           eEndReason = 3451 + 495,   iGenericBitset = 3374 },
    { script = "fm_content_island_heist",        eEndReason = 13311 + 1339, iGenericBitset = 13220 },
    { script = "fm_content_metal_detector",      eEndReason = 1810 + 93,    iGenericBitset = 1757 },
    { script = "fm_content_movie_props",         eEndReason = 1888 + 137,   iGenericBitset = 1833 },
    { script = "fm_content_parachuter",          eEndReason = 1568 + 83,    iGenericBitset = 1518 },
    { script = "fm_content_payphone_hit",        eEndReason = 5675 + 683,   iGenericBitset = 5616 },
    { script = "fm_content_phantom_car",         eEndReason = 1577 + 83,    iGenericBitset = 1527 },
    { script = "fm_content_pizza_delivery",      eEndReason = 1704 + 83,    iGenericBitset = 1648 },
    { script = "fm_content_possessed_animals",   eEndReason = 1593 + 83,    iGenericBitset = 1541 },
    { script = "fm_content_robbery",             eEndReason = 1732 + 87,    iGenericBitset = 1666 },
    { script = "fm_content_security_contract",   eEndReason = 7136 + 1278,  iGenericBitset = 7058 },
    { script = "fm_content_sightseeing",         eEndReason = 1822 + 84,    iGenericBitset = 1770 },
    { script = "fm_content_skydive",             eEndReason = 3010 + 93,    iGenericBitset = 2953 },
    { script = "fm_content_slasher",             eEndReason = 1597 + 83,    iGenericBitset = 1545 },
    { script = "fm_content_smuggler_ops",        eEndReason = 7600 + 1270,  iGenericBitset = 7523 },
    { script = "fm_content_smuggler_plane",      eEndReason = 1838 + 178,   iGenericBitset = 1771 },
    { script = "fm_content_smuggler_resupply",   eEndReason = 6045 + 1271,  iGenericBitset = 5966 },
    { script = "fm_content_smuggler_sell",       eEndReason = 4015 + 489,   iGenericBitset = 3880 },
    { script = "fm_content_smuggler_trail",      eEndReason = 2051 + 130,   iGenericBitset = 1980 },
    { script = "fm_content_source_research",     eEndReason = 4318 + 1195,  iGenericBitset = 4261 },
    { script = "fm_content_stash_house",         eEndReason = 3521 + 475,   iGenericBitset = 3467 },
    { script = "fm_content_taxi_driver",         eEndReason = 1993 + 83,    iGenericBitset = 1941 },
    { script = "fm_content_tow_truck_work",      eEndReason = 1755 + 91,    iGenericBitset = 1702 },
    { script = "fm_content_tuner_robbery",       eEndReason = 7313 + 1194,  iGenericBitset = 7226 },
    { script = "fm_content_ufo_abduction",       eEndReason = 2858 + 334,   iGenericBitset = 2792 },
    { script = "fm_content_vehicle_list",        eEndReason = 1568 + 83,    iGenericBitset = 1518 },
    { script = "fm_content_vehrob_arena",        eEndReason = 7807 + 1285,  iGenericBitset = 7748 },
    { script = "fm_content_vehrob_cargo_ship",   eEndReason = 7025 + 1224,  iGenericBitset = 6934 },
    { script = "fm_content_vehrob_casino_prize", eEndReason = 9060 + 1231,  iGenericBitset = 8979 },
    { script = "fm_content_vehrob_disrupt",      eEndReason = 4570 + 924,   iGenericBitset = 4511 },
    { script = "fm_content_vehrob_police",       eEndReason = 8847 + 1276,  iGenericBitset = 8772 },
    { script = "fm_content_vehrob_prep",         eEndReason = 11366 + 1272, iGenericBitset = 11265 },
    { script = "fm_content_vehrob_scoping",      eEndReason = 3752 + 508,   iGenericBitset = 3695 },
    { script = "fm_content_vehrob_submarine",    eEndReason = 6125 + 1137,  iGenericBitset = 6041 },
    { script = "fm_content_vehrob_task",         eEndReason = 4773 + 1043,  iGenericBitset = 4705 },
    { script = "fm_content_vip_contract_1",      eEndReason = 8692 + 1157,  iGenericBitset = 8619 },
    { script = "fm_content_xmas_mugger",         eEndReason = 1620 + 83,    iGenericBitset = 1568 },
    { script = "fm_content_xmas_truck",          eEndReason = 1461 + 91,    iGenericBitset = 1409 },
}
menu.action(Menu_Root, "Complete fm_content_xxx Mission", {}, "", function()
    for _, item in pairs(fm_content_xxx) do
        if IS_SCRIPT_RUNNING(item.script) then
            LOCAL_SET_BIT(item.script, item.iGenericBitset + 1 + 0, 11)
            LOCAL_SET_INT(item.script, item.eEndReason, 3)

            util.toast(item.script, TOAST_ALL)
        end
    end
end)







----------------------------------------
--    Instant Finish Test
----------------------------------------

local Instant_Finish_Test <const> = menu.list(Menu_Root, "Instant Finish Test", {}, "")


menu.divider(Instant_Finish_Test, "fm_content Mission")

local TestScript1 = "fm_content_bicycle_time_trial"

menu.toggle_loop(Instant_Finish_Test, "Show Local Info", {}, "", function()
    local script = TestScript1
    if not IS_SCRIPT_RUNNING(script) then return end

    local iLocalPart = LOCAL_GET_INT(script, 3427)

    local text = string.format(
        "PARTICIPANT_ID_TO_INT: %s\nLOCAL_PARTICIPANT_INDEX_AS_INT: %s\niGoodsToTransfer: %s",
        NETWORK.PARTICIPANT_ID_TO_INT(),
        iLocalPart,
        LOCAL_GET_INT(script, 4267 + 1 + iLocalPart * 125 + 73)
    )

    draw_text(text)
end)


menu.action(Instant_Finish_Test, "SET_MISSION_ENTITY_BIT", {}, "", function()
    local script = TestScript1
    if not IS_SCRIPT_RUNNING(script) then return end

    local eBitset = 1
    local iVar0 = math.floor(eBitset / 32) -- iBitSet
    local iVar1 = math.floor(eBitset % 32) -- iBitVal
    util.toast(string.format("iVar0: %s, iVar1: %s", iVar0, iVar1))

    local iMissionEntity = 0
    local address = memory.script_local(script, 2310 + 31 + 1 + iMissionEntity * 42 + 11 + 1 + iVar0)
    MISC.SET_BIT(address, iVar1)
end)

menu.action(Instant_Finish_Test, "Set Local Variations", {}, "", function()
    local script = TestScript1
    if not IS_SCRIPT_RUNNING(script) then return end

    local iLocalPart = LOCAL_GET_INT(script, 3427)
    LOCAL_SET_INT(script, 4267 + 1 + iLocalPart * 125 + 73, 1)
end)

menu.action(Instant_Finish_Test, "End Mission", {}, "", function()
    local script = TestScript1
    if not IS_SCRIPT_RUNNING(script) then return end

    -- SET_GAME_STATE(eGAMESTATE_END)
    LOCAL_SET_INT(script, 1543 + 82, 3)
end)
menu.action(Instant_Finish_Test, "Test Complete fm_content", {}, "", function()
    local script = TestScript1
    if not IS_SCRIPT_RUNNING(script) then return end

    LOCAL_SET_BIT(script, 2873 + 1 + 0, 0)

    LOCAL_SET_BIT(script, 2860 + 1 + 0, 11) -- SET_GENERIC_BIT(eGENERICBITSET_I_WON)
    -- LOCAL_SET_INT(script, 2913 + 83, 3)     -- SET_END_REASON(eENDREASON_MISSION_PASSED)
end)



menu.divider(Instant_Finish_Test, "gb Mission")

local TestScript2 = "gb_vehicle_export"

local TestSelectMission2 = 13
menu.slider(Instant_Finish_Test, "Select Mission", { "TestSelectMission2" }, "",
    0, 99, 0, 1, function(value)
        TestSelectMission2 = value
    end)
menu.toggle_loop(Instant_Finish_Test, "Set Select Mission", {}, "", function()
    local script = TestScript2
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    LOCAL_SET_INT(script, 834 + 9, TestSelectMission2)
end)

menu.action(Instant_Finish_Test, "End Mission", {}, "", function()
    local script = "gb_vehicle_export"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    LOCAL_SET_INT(script, 834 + 459, 14) -- SET_MODE_STATE(eMODESTATE_END)
end)

menu.action(Instant_Finish_Test, "Test Complete Vehicle Export", {}, "", function()
    local script = "gb_vehicle_export"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    -- LOCAL_SET_INT(script, 388 + 1, 1)

    -- SET_EXPORT_ENTITY_BIT(iExportEntity,
    -- eEXPORTENTITYBITSET_DELIVERED, eEXPORTENTITYBITSET_FADED_OUT_FOR_DELIVERY, eEXPORTENTITYBITSET_DELIVERED_BY_KEY_ORGINISATION
    LOCAL_SET_BITS(script, 834 + 48 + 1 + 0 * 2 + 1 + 0, 6, 16, 18)


    LOCAL_SET_INT(script, 834 + 460, 4)  -- SET_END_REASON(eENDREASON_EXPORT_ENTITY_DELIVERED)
    LOCAL_SET_INT(script, 834 + 459, 13) -- SET_MODE_STATE(eMODESTATE_REWARDS)
end)









----------------------------------------
--    Freemode Test
----------------------------------------


local Freemode_Test <const> = menu.list(Menu_Root, "Freemode Test", {}, "")

menu.toggle_loop(Freemode_Test, "Show Local Info", { "t" }, "", function()
    local script = "am_pi_menu"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local text = string.format(
        "ePiStage: %s, bCursorAccept: %s, iCursorValueChange: %s\nbiStoreActive: %s, bGBMenuShouldRefresh: %s, biListenForDoubleTap: %s",
        LOCAL_GET_INT(script, 1526),
        LOCAL_GET_INT(script, 1679),
        LOCAL_GET_INT(script, 1683),
        LOCAL_BIT_TEST(script, 1691, 18),
        LOCAL_GET_INT(script, 1501),
        LOCAL_BIT_TEST(script, 1691, 31)

    )

    draw_text(text)
end)

menu.toggle_loop(Freemode_Test, "Show Global Info", {}, "", function()
    -- Global_2710523.f_8191
    -- PIMenuData.iCurrentSelection

    -- Global_2710428
    -- g_iPIM_SubMenu

    -- Global_4541816
    -- g_iMenuCursorItem

    -- Global_2672855.f_990.f_6
    -- MPGlobals.PlayerInteractionData.iLaunchStage

    -- Global_2710431
    -- g_bPIM_ResetMenuNow

    -- Global_2710523.f_8192, 1
    -- PIMenuData.iMenuBitSet, biM_MenuSetup

    -- Global_2710429
    -- g_bPIM_SelectAvailable


    local text = string.format(
        "iCurrentSelection: %s, g_iPIM_SubMenu: %s, g_iMenuCursorItem: %s\nPlayerInteractionData.iLaunchStage: %s\nbiM_MenuSetup: %s, g_bPIM_SelectAvailable:%s\niBS_PauseMenuFlags: %s",
        GLOBAL_GET_INT(2710523 + 8191),
        GLOBAL_GET_INT(2710428),
        GLOBAL_GET_INT(4541816),
        GLOBAL_GET_INT(2672855 + 990 + 6),
        GLOBAL_BIT_TEST(2710523 + 8192, 1),
        GLOBAL_GET_INT(2710429),
        GLOBAL_GET_INT(1574589)
    )

    draw_text(text)
end)

menu.toggle_loop(Freemode_Test, "Show CUTSCENE", {}, "", function()
    local text = string.format(
        "IS_CUTSCENE_PLAYING: %s\nIS_CUTSCENE_ACTIVE: %s\nIS_PLAYER_IN_CUTSCENE: %s\nNETWORK_IS_IN_MP_CUTSCENE: %s",
        CUTSCENE.IS_CUTSCENE_PLAYING(),
        CUTSCENE.IS_CUTSCENE_ACTIVE(),
        NETWORK.IS_PLAYER_IN_CUTSCENE(players.user()),
        NETWORK.NETWORK_IS_IN_MP_CUTSCENE()
    )
    draw_text(text)
end)
menu.toggle_loop(Freemode_Test, "Show SESSION", {}, "", function()
    local text = string.format(
        "NETWORK_SESSION_IS_PRIVATE: %s\nNETWORK_IS_SESSION_ACTIVE: %s\nNETWORK_IS_IN_SESSION: %s\nNETWORK_IS_SESSION_STARTED: %s\nNETWORK_IS_SESSION_BUSY: %s",
        NETWORK.NETWORK_SESSION_IS_PRIVATE(),
        NETWORK.NETWORK_IS_SESSION_ACTIVE(),
        NETWORK.NETWORK_IS_IN_SESSION(),
        NETWORK.NETWORK_IS_SESSION_STARTED(),
        NETWORK.NETWORK_IS_SESSION_BUSY()
    )
    draw_text(text)
end)



menu.action(Freemode_Test, "注册为CEO", {}, "", function()
    local ePiStage = 1526

    local g_iPIM_SubMenu = 2710428
    local PIMenuData = {
        iCurrentSelection = 2710523 + 8191
    }
    local g_bPIM_ResetMenuNow = 2710431


    local script = "am_pi_menu"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    -- PLAYER_CONTROL, INPUT_INTERACTION_MENU
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 244, 1.0)

    repeat
        util.yield()
    until LOCAL_GET_INT(script, ePiStage) == 1

    GLOBAL_SET_INT(g_iPIM_SubMenu, 116) -- REGISTER AS A BOSS
    GLOBAL_SET_INT(PIMenuData.iCurrentSelection, 0)

    GLOBAL_SET_BOOL(g_bPIM_ResetMenuNow, true)

    util.yield(50)

    -- FRONTEND_CONTROL, INPUT_CELLPHONE_SELECT
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 176, 1.0)

    repeat
        util.yield()
    until GLOBAL_GET_INT(g_iPIM_SubMenu) == 27 -- Start an Organization
    GLOBAL_SET_INT(PIMenuData.iCurrentSelection, 0)

    util.yield(10)

    -- FRONTEND_CONTROL, INPUT_CELLPHONE_SELECT
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 176, 1.0)

    util.yield(10)

    -- FRONTEND_CONTROL, INPUT_FRONTEND_ACCEPT
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 201, 1.0)

    util.yield(10)

    if LOCAL_GET_INT(script, ePiStage) == 1 then
        -- PLAYER_CONTROL, INPUT_INTERACTION_MENU
        PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 244, 1.0)
    end
end)
menu.action(Freemode_Test, "切换到 邀请战局", {}, "", function()
    local g_Private_Players_FM_SESSION_Menu_Choice = 1575035
    local g_PauseMenuMissionCreatorData = {
        iBS_PauseMenuFlags = 1574589
    }

    -- FM_SESSION_MENU_CHOICE_JOIN_CLOSED_INVITE_ONLY
    GLOBAL_SET_INT(g_Private_Players_FM_SESSION_Menu_Choice, 11)

    -- bsPauseRequestingTransition, bsPauseMenuRequestingNewSession
    GLOBAL_SET_BITS(g_PauseMenuMissionCreatorData.iBS_PauseMenuFlags, 0, 5)

    util.yield(200)

    GLOBAL_SET_INT(g_PauseMenuMissionCreatorData.iBS_PauseMenuFlags, 0)
end)


menu.action(Freemode_Test, "切换战局 到 虎鲸", {}, "", function()
    -- MP_SETTING_SPAWN_SUBMARINE
    STAT_SET_INT(ADD_MP_INDEX("SPAWN_LOCATION_SETTING"), 16)

    menu.trigger_commands("go inviteonly")
end)
menu.action(Freemode_Test, "切换战局 到 游戏厅", {}, "", function()
    -- MP_SETTING_SPAWN_ARCADE
    STAT_SET_INT(ADD_MP_INDEX("SPAWN_LOCATION_SETTING"), 15)

    menu.trigger_commands("go inviteonly")
end)
menu.action(Freemode_Test, "切换战局 到 设施", {}, "", function()
    -- MP_SETTING_SPAWN_DEFUNCT_BASE
    STAT_SET_INT(ADD_MP_INDEX("SPAWN_LOCATION_SETTING"), 11)

    menu.trigger_commands("go inviteonly")
end)





menu.divider(Freemode_Test, "")
menu.action(Freemode_Test, "iMaterialsTotal = 0", {}, "", function()
    local pid = players.user()
    for i = 0, 6 do
        GLOBAL_SET_INT(1845263 + 1 + pid * 877 + 267 + 195 + 1 + i * 13 + 2, 0)
    end
end)
menu.action(Freemode_Test, "iProductTotal = 100", {}, "", function()
    local pid = players.user()
    for i = 0, 6 do
        GLOBAL_SET_INT(1845263 + 1 + pid * 877 + 267 + 195 + 1 + i * 13 + 1, 100)
    end
end)












----------------------------------------
--    Start Mission Test
----------------------------------------

local Test_Start_Mission <const> = menu.list(Menu_Root, "Start Mission Test", {}, "")

menu.toggle_loop(Test_Start_Mission, "Show Global Info", {}, "", function()
    local text = string.format(
        "%s",
        "-1"
    )

    draw_text(text)
end)

menu.divider(Test_Start_Mission, "Freemode Mission")

menu.click_slider(Test_Start_Mission, "Request FMMC_TYPE Mission", { "fmmcReq" }, "", 0, 310, 0, 1, function(value)
    SET_CONTACT_REQUEST_GB_MISSION_LAUNCH_DATA(value)
end)
menu.click_slider(Test_Start_Mission, "Start FMMC_TYPE Mission", { "fmmcStart" }, "", 0, 310, 0, 1, function(value)
    GB_BOSS_REQUEST_MISSION_LAUNCH_FROM_SERVER(value)
end)


menu.divider(Test_Start_Mission, "Job")

local TestStartRootContentID = menu.text_input(Test_Start_Mission, "Root Content ID (Hash)",
    { "rs_StartRootContentID" }, "", function(value) end)

menu.action(Test_Start_Mission, "Launch Mission", {}, "", function()
    local value = menu.get_value(TestStartRootContentID)
    if value == "" then
        return
    end
    if tonumber(value) == nil then
        value = util.joaat(value)
    end

    util.toast(value)

    local Data = {
        iRootContentID = tonumber(value),
        iMissionType = 0,        -- FMMC_TYPE_MISSION
        iMissionEnteryType = 32, -- ciMISSION_ENTERY_TYPE_V2_CORONA
    }

    LAUNCH_MISSION(Data)
    util.toast("请稍等...")
end)


menu.divider(Test_Start_Mission, "Terminate Script")

local TestTerminateScript = menu.text_input(Test_Start_Mission, "Script Name",
    { "rs_TerminateScript" }, "", function(value) end)
menu.action(Test_Start_Mission, "TERMINATE_ALL_SCRIPTS_WITH_THIS_NAME", {}, "", function()
    local value = menu.get_value(TestTerminateScript)
    if value == "" then
        return
    end

    MISC.TERMINATE_ALL_SCRIPTS_WITH_THIS_NAME(value)
end)







----------------------------------------
--    Job Mission Test
----------------------------------------

local Job_Mission_Test <const> = menu.list(Menu_Root, "Job Mission Test", {}, "")


menu.toggle_loop(Job_Mission_Test, "Show g_FMMC_STRUCT Info", {}, "", function()
    local iRootContentID = GLOBAL_GET_INT(FMMC_STRUCT.iRootContentIDHash)
    local iArrayPos = MISC.GET_CONTENT_ID_INDEX(iRootContentID)

    local text = string.format(
        "MissionName: %s, iRootContentIDHash: %s, iArrayPos: %s\ntl31LoadedContentID: %s\ntl23NextContentID: %s, %s, %s\niEndCutscene: %s",
        GLOBAL_GET_STRING(FMMC_STRUCT.tl63MissionName),
        iRootContentID,
        iArrayPos,

        GLOBAL_GET_STRING(FMMC_STRUCT.tl31LoadedContentID),

        GLOBAL_GET_STRING(FMMC_STRUCT.tl23NextContentID + 0 * 6),
        GLOBAL_GET_STRING(FMMC_STRUCT.tl23NextContentID + 1 * 6),
        GLOBAL_GET_STRING(FMMC_STRUCT.tl23NextContentID + 2 * 6),

        GLOBAL_GET_INT(g_FMMC_STRUCT + 127643)
    )

    -- util.log(text)
    draw_text(text)
end)

menu.toggle_loop(Job_Mission_Test, "最小玩家数为1", {}, "强制任务单人可开", function()
    local script = "fmmc_launcher"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local iArrayPos = LOCAL_GET_INT(script, sLaunchMissionDetails.iMissionVariation)
    if iArrayPos == 0 then
        return
    end

    -- g_FMMC_ROCKSTAR_CREATED.sMissionHeaderVars[iArrayPos].iMinPlayers
    if GLOBAL_GET_INT(Globals.sMissionHeaderVars + iArrayPos * 89 + 69) > 1 then
        GLOBAL_SET_INT(Globals.sMissionHeaderVars + iArrayPos * 89 + 69, 1)
        LOCAL_SET_INT(script, sLaunchMissionDetails.iMinPlayers, 1)
    end

    GLOBAL_SET_INT(FMMC_STRUCT.iMinNumParticipants, 1)
    for i = 0, 3 do
        GLOBAL_SET_INT(FMMC_STRUCT.iNumPlayersPerTeam + i, 1)
        GLOBAL_SET_INT(FMMC_STRUCT.iCriticalMinimumForTeam + i, 0)
    end
end)

local SetMissionMaxTeams2 = menu.toggle_loop(Job_Mission_Test, "最大团队数为1", {}, "用于多团队任务", function()
    GLOBAL_SET_INT(FMMC_STRUCT.iNumberOfTeams, 1)
    GLOBAL_SET_INT(FMMC_STRUCT.iMaxNumberOfTeams, 1)
end)

menu.click_slider(Job_Mission_Test, "设置最大团队数", {}, "", 1, 4, 2, 1, function(value)
    menu.set_value(SetMissionMaxTeams2, false)

    GLOBAL_SET_INT(FMMC_STRUCT.iNumberOfTeams, value)
    GLOBAL_SET_INT(FMMC_STRUCT.iMaxNumberOfTeams, value)
end)

menu.action(Job_Mission_Test, "Mission Finish", { "MissionFinish" }, "", function()
    local script = GET_RUNNING_MISSION_CONTROLLER_SCRIPT()
    if script == nil then return end

    -- CHECK_TO_SEE_IF_THIS_IS_THE_LAST_STRAND_MISSION()
    for i = 0, 5 do
        local tl23NextContentID = GLOBAL_GET_STRING(FMMC_STRUCT.tl23NextContentID + i * 6)
        if tl23NextContentID ~= "" then
            GLOBAL_SET_STRING(FMMC_STRUCT.tl23NextContentID + i * 6, "")
        end
    end

    -- g_FMMC_STRUCT.iCelebrationType
    -- GLOBAL_SET_INT(4718592 + 178859, 5)

    -- ciMISSION_CUTSCENE_ISLAND_HEIST_HS4F_DRP_OFF
    -- LOCAL_SET_INT(script, 50150 + 3016, 69)    -- MISSION_HAS_VALID_MOCAP
    -- LOCAL_SET_INT(script, 50150 + 2525 + 1, 0) -- SHOULD_PLAY_END_MOCAP



    if GLOBAL_GET_BOOL(StrandMissionData.bIsThisAStrandMission) then
        GLOBAL_SET_BOOL(StrandMissionData.bPassedFirstMission, true)
        GLOBAL_SET_BOOL(StrandMissionData.bPassedFirstStrandNoReset, true)
        GLOBAL_SET_BOOL(StrandMissionData.bLastMission, true)
    end

    -- LBOOL11_STOP_MISSION_FAILING_DUE_TO_EARLY_CELEBRATION
    LOCAL_SET_BIT(script, Locals[script].iLocalBoolCheck11, 7)

    for i = 0, 3 do
        -- MC_serverBD.iTeamScore[iTeam]
        LOCAL_SET_INT(script, Locals[script].iTeamScore + i, 999999)
    end

    -- SSBOOL_TEAMx_FINISHED
    LOCAL_SET_BITS(script, Locals[script].iServerBitSet, 9, 10, 11, 12)
end)

menu.action(Job_Mission_Test, "Mission Over", { "MissionOver" }, "", function()
    local script = GET_RUNNING_MISSION_CONTROLLER_SCRIPT()
    if script == nil then return end

    LOCAL_SET_BIT(script, Locals[script].iServerBitSet, 16)
end)





menu.divider(Job_Mission_Test, "fmmc_launcher")


local CORONA_STATUS = {
    [0] = "CORONA_STATUS_IDLE",
    [1] = "CORONA_STATUS_CAN_START",
    [2] = "CORONA_STATUS_WALK_IN",
    [3] = "CORONA_STATUS_JOIN_HOST",
    [4] = "CORONA_STATUS_MatC_HAND_SHAKE",
    [5] = "CORONA_STATUS_INIT_CORONA",
    [6] = "CORONA_STATUS_INIT_TRAN_SCRIPT",
    [7] = "CORONA_STATUS_GET_DATA_SETUP_TRAN",
    [8] = "CORONA_STATUS_SETUP_VARS",
    [9] = "CORONA_STATUS_INTRO",
    [10] = "CORONA_STATUS_LOBBY",
    [11] = "CORONA_STATUS_H2H_LOBBY",
    [12] = "CORONA_STATUS_LEADERBOARD",
    [13] = "CORONA_STATUS_JOINED_PLAYERS",
    [14] = "CORONA_STATUS_LOCAL_PLAYERS",
    [15] = "CORONA_STATUS_LAST_JOB_PLAYERS",
    [16] = "CORONA_STATUS_LAST_HEIST_PLAYERS",
    [17] = "CORONA_STATUS_FRIENDS",
    [18] = "CORONA_STATUS_CREW_MEMBERS",
    [19] = "CORONA_STATUS_MATCHED_PLAYERS",
    [20] = "CORONA_LAUNCH_TRANSITION",
    [21] = "CORONA_STATUS_BALANCE_AND_LOAD",
    [22] = "CORONA_STATUS_SCTV_HOLDING",
    [23] = "CORONA_STATUS_SCTV_PROPERTY_CAM",
    [24] = "CORONA_STATUS_IN_CORONA",
    [25] = "CORONA_STATUS_IN_GENERIC_JOB_CORONA",
    [26] = "CORONA_STATUS_TEAM_DM",
    [27] = "CORONA_STATUS_HEIST_PLANNING",
    [28] = "CORONA_STATUS_HEIST_PLANNING_CUTSCENE",
    [29] = "CORONA_STATUS_HEIST_CUTSCENE",
    [30] = "CORONA_STATUS_HEIST_TUTORIAL_CUTSCENE",
    [31] = "CORONA_STATUS_FLOW_CUTSCENE",
    [32] = "CORONA_STATUS_GANG_OPS_HEIST_PLANNING",
    [33] = "CORONA_STATUS_CASINO_HEIST_PLANNING",
    [34] = "CORONA_STATUS_GENERIC_HEIST_PLANNING",
    [35] = "CORONA_STATUS_BETTING",
    [36] = "CORONA_STATUS_WAIT_FOR_CASH_TRANSACTION",
    [37] = "CORONA_STATUS_KICKED",
    [38] = "CORONA_STATUS_RESET_POSITION",
    [39] = "CORONA_STATUS_WARP_TO_SAFE_LOC",
    [40] = "CORONA_STATUS_WALK_OUT",
    [41] = "CORONA_STATUS_LAUNCH",
    [42] = "CORONA_STATUS_WAIT_FOR_ACTIVE",
    [43] = "CORONA_STATUS_QUIT"
}

menu.toggle_loop(Job_Mission_Test, "Show Global Info", {}, "", function()
    -- Global_1845281[PLAYER::PLAYER_ID() /*883*/].f_193
    -- GlobalplayerBD_FM[NATIVE_TO_INT(PLAYER_ID())].eCoronaStatus
    local eCoronaStatus = GLOBAL_GET_INT(1845281 + 1 + players.user() * 883 + 193)
    if CORONA_STATUS[eCoronaStatus] then
        eCoronaStatus = CORONA_STATUS[eCoronaStatus]
    end


    local text = string.format(
        "eCoronaStatus: %s\niSwitchState: %s, iArrayPos: %s, IsThisAStrandMission: %s\nIS_A_STRAND_MISSION_BEING_INITIALISED: %s\nHAS_NEXT_STRAND_MISSION_HAS_BEEN_DOWNLOADED: %s\nIS_NEXT_STRAND_MISSION_READY_TO_SET_UP: %s\nIS_STRAND_MISSION_READY_TO_START_DOWNLOAD: %s\niVoteStatus: %s, iCelebrationType: %s",
        eCoronaStatus,

        GLOBAL_GET_INT(2684504 + 43 + 3),   -- g_sTransitionSessionData.sStrandMissionData.iSwitchState
        GLOBAL_GET_INT(2684504 + 43),       -- g_sTransitionSessionData.sStrandMissionData.iArrayPos
        GLOBAL_GET_BOOL(2684504 + 43 + 57), -- g_sTransitionSessionData.sStrandMissionData.bIsThisAStrandMission

        -- g_sTransitionSessionData.sStrandMissionData.iBitSet
        GLOBAL_BIT_TEST(2684504 + 43 + 4, 0), -- ciSTRAND_BITSET_A_STRAND_MISSION_BEING_INITIALISED
        GLOBAL_BIT_TEST(2684504 + 43 + 4, 6), -- ciSTRAND_BITSET_MISSION_HAS_BEEN_DOWNLOADED
        GLOBAL_BIT_TEST(2684504 + 43 + 4, 7), -- ciSTRAND_BITSET_MISSION_READY_TO_SET_UP
        GLOBAL_BIT_TEST(2684504 + 43 + 4, 8), -- ciSTRAND_BITSET_MISSION_READY_TO_START_DOWNLOAD

        GLOBAL_GET_INT(1919969 + 9),          -- g_sFMMCEOM.iVoteStatus
        GLOBAL_GET_INT(4718592 + 178859)      -- g_FMMC_STRUCT.iCelebrationType
    )

    draw_text(text)
end)

menu.toggle_loop(Job_Mission_Test, "Show Local Info", {}, "", function()
    local script = "fmmc_launcher"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local __coronaMenuData = 17445
    local __sLaunchMissionDetails = 19709

    local text = string.format(
        "iCurrentSelection: %s\niIntroStatus: %s, iLobbyStatus: %s, iInviteScreenStatus: %s, iInCoronaStatus: %s, iBettingStatus: %s, iLoadStatus: %s",
        LOCAL_GET_INT(script, __coronaMenuData + 911), -- coronaMenuData.iCurrentSelection
        LOCAL_GET_INT(script, __sLaunchMissionDetails),
        LOCAL_GET_INT(script, __sLaunchMissionDetails + 4),
        LOCAL_GET_INT(script, __sLaunchMissionDetails + 6),
        LOCAL_GET_INT(script, __sLaunchMissionDetails + 7),
        LOCAL_GET_INT(script, __sLaunchMissionDetails + 10),
        LOCAL_GET_INT(script, __sLaunchMissionDetails + 11)
    )

    draw_text(text)
end)



menu.toggle_loop(Job_Mission_Test, "Show Global Info 2", {}, "", function()
    local text = string.format(
        "tlGlobalFinaleRContID: %s\nmhcContentID: %s\ng_HeistPlanningClient.eHeistFlowState: %s\ng_HeistPrePlanningClient.eHeistFlowState: %s",
        GLOBAL_GET_STRING(1934536 + 10),    -- g_HeistSharedClient.tlGlobalFinaleRContID
        GLOBAL_GET_STRING(2635126 + 3 + 1), -- g_sLocalMPHeistControl.lhcMyCorona.mhcContentID
        GLOBAL_GET_INT(1930926 + 2768),     -- g_HeistPlanningClient.eHeistFlowState
        GLOBAL_GET_INT(1928993)
    )

    draw_text(text)
end)



local iCoronaBitSet = 2685444 + 1 + 2813

local function SET_CORONA_BIT(iCoronaBit)
    local iBitSet = math.ceil(iCoronaBit / 32)
    local iBitVal = iCoronaBit % 32

    util.toast(string.format("iBitSet: %s, iBitVal: %s", iBitSet, iBitVal))

    if iBitSet >= 9 then -- NUM_CORONA_BITSETS
        return
    end

    -- SET_BIT(g_TransitionSessionNonResetVars.sTransVars.iCoronaBitSet[iBitSet], iBitVal)
    -- MISC::SET_BIT(&(Global_2685444.f_1.f_2813[iVar0]), bVar1);
    GLOBAL_SET_BIT(2685444 + 1 + 2813 + 1 + iBitSet, iBitVal)
end
menu.click_slider(Job_Mission_Test, "SET_CORONA_BIT", { "Test_iCoronaBit" }, "",
    0, 200, 170, 1, function(value)
        SET_CORONA_BIT(value)
    end)







menu.divider(Job_Mission_Test, "fm_mission_controller")

menu.toggle_loop(Job_Mission_Test, "Show Global Info", {}, "", function()
    local text = string.format(
        "iCurrentGangopsMission: %s, eChosenApproachType: %s, bIsThisAStrandMission: %s\nbPassedFirstMission: %s, bPassedFirstStrandNoReset: %s, bLastMission: %s\nIS_A_STRAND_MISSION_BEING_INITIALISED: %s",
        GLOBAL_GET_INT(2684312 + 26),
        GLOBAL_GET_INT(1963911),
        GLOBAL_GET_INT(2684312 + 43 + 57),

        GLOBAL_GET_INT(2684312 + 43 + 55),
        GLOBAL_GET_INT(2684312 + 43 + 56),
        GLOBAL_GET_INT(2684312 + 43 + 58),
        GLOBAL_BIT_TEST(2684312 + 43 + 4, 0)
    )

    draw_text(text)
end)

menu.toggle_loop(Job_Mission_Test, "Show Local Info", {}, "", function()
    local script = "fm_mission_controller"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local MC_serverBD = 19746

    local iTeam = 0

    local text = string.format(
        "iServerGameState: %s",
        LOCAL_GET_INT(script, MC_serverBD)
    )

    draw_text(text)
end)








menu.divider(Job_Mission_Test, "fm_mission_controller_2020")

menu.toggle_loop(Job_Mission_Test, "Show Local Info", {}, "", function()
    local script = "fm_mission_controller_2020"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local MC_serverBD = 50150

    local iTeam = 0

    local text = string.format(
        "iServerGameState: %s",
        LOCAL_GET_INT(script, MC_serverBD)
    )

    draw_text(text)
end)















menu.divider(Job_Mission_Test, "")

menu.action(Job_Mission_Test, "Get Content Info (By Natives)", { "getContentInfo" }, "", function()
    local content_id = NETWORK.UGC_GET_CONTENT_ID(0)
    if content_id ~= nil then
        local text = string.format(
            "\nContent Name: %s\nContent ID: %s\nContent Path: %s\nRoot Content ID: %s (%s)\nRoot Content ID Index: %s",
            NETWORK.UGC_GET_CONTENT_NAME(0),
            content_id,
            NETWORK.UGC_GET_CONTENT_PATH(0, 0),
            NETWORK.UGC_GET_ROOT_CONTENT_ID(0),
            util.joaat(NETWORK.UGC_GET_ROOT_CONTENT_ID(0)),
            MISC.GET_CONTENT_ID_INDEX(util.joaat(NETWORK.UGC_GET_ROOT_CONTENT_ID(0)))
        )
        toast(text)
    end
end)

menu.action(Job_Mission_Test, "Get Content Info (By Globals)", { "getGContentInfo" }, "", function()
    local iRootContentIDHash = GLOBAL_GET_INT(FMMC_STRUCT.iRootContentIDHash)
    if iRootContentIDHash ~= 0 then
        local text = string.format(
            "\nContent Name: %s\nContent ID: %s\nRoot Content ID: %s (%s)",
            GLOBAL_GET_STRING(FMMC_STRUCT.tl63MissionName),
            GLOBAL_GET_STRING(FMMC_STRUCT.tl31LoadedContentID),
            "",
            iRootContentIDHash
        )
        toast(text)
    end
end)


menu.divider(Job_Mission_Test, "")
menu.toggle_loop(Job_Mission_Test, "Show Mission Controller Script", {}, "", function()
    local script = GET_RUNNING_MISSION_CONTROLLER_SCRIPT()
    if script == nil then return end

    local text = ""

    util.spoof_script(script, function()
        local isHost = NETWORK.NETWORK_IS_HOST_OF_THIS_SCRIPT()
        local getHost = players.get_name(NETWORK.NETWORK_GET_HOST_OF_THIS_SCRIPT())
        local instanceId = NETWORK.NETWORK_GET_INSTANCE_ID_OF_THIS_SCRIPT()

        text = string.format(
            "Script: %s\nNETWORK_IS_HOST_OF_THIS_SCRIPT: %s\nNETWORK_GET_HOST_OF_THIS_SCRIPT: %s\nNETWORK_GET_INSTANCE_ID_OF_THIS_SCRIPT: %s",
            script,
            isHost,
            getHost,
            instanceId
        )
    end)

    local getHost2 = players.get_name(NETWORK.NETWORK_GET_HOST_OF_SCRIPT(script, 0, 0))
    local scriptHost = players.get_name(players.get_script_host())

    text = string.format(
        "%s\nNETWORK_GET_HOST_OF_SCRIPT: %s\nScript Host: %s",
        text,
        getHost2,
        scriptHost
    )

    draw_text(text)
end)
menu.action(Job_Mission_Test, "Request Mission Controller Script Host", {}, "", function()
    local script = GET_RUNNING_MISSION_CONTROLLER_SCRIPT()
    if script == nil then return end

    if util.request_script_host(script) then
        util.toast("Success")
    else
        util.toast("Fail")
    end
end)








----------------------------------------
--    Script Event Test
----------------------------------------

local Script_Event_Test <const> = menu.list(Menu_Root, "Script Event Test", {}, "")

local ScriptEventDetails = memory.alloc(8 * 2)
menu.toggle_loop(Script_Event_Test, "Get Network Script Event", {}, "", function()
    -- SCRIPT_EVENT_QUEUE_NETWORK = 1
    local eventType = 174 -- EVENT_NETWORK_SCRIPT_EVENT

    for eventIndex = 0, SCRIPT.GET_NUMBER_OF_EVENTS(1) - 1 do
        if SCRIPT.GET_EVENT_AT_INDEX(1, eventIndex) == eventType then
            if SCRIPT.GET_EVENT_DATA(1, eventIndex, ScriptEventDetails, 2) then
                local eventHash = memory.read_int(ScriptEventDetails)
                local FromPlayerIndex = memory.read_int(ScriptEventDetails + 8)

                local text = string.format(
                    "Script Event Hash: %s\nFrom Player: %s\nTime: %s",
                    eventHash,
                    players.get_name(FromPlayerIndex),
                    os.date("%Y-%m-%d %H:%M:%S", util.current_unix_time_seconds())
                )

                toast(text)
            end
        end
    end
end)
