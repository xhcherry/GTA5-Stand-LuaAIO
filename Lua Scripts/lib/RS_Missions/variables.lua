-- Game Variables
-- 1.70-3411

----------------------------------------------
--                GLOBALS
----------------------------------------------

Globals = {
    -- GlobalplayerBD[NATIVE_TO_INT(PLAYER_ID())]
    GlobalplayerBD = function()
        return 2657991 + 1 + players.user() * 467
    end,

    -- GlobalplayerBD_FM[NATIVE_TO_INT(PLAYER_ID())]
    GlobalplayerBD_FM = function()
        return 1845221 + 1 + players.user() * 889
    end,

    -- GlobalplayerBD_FM_2[NATIVE_TO_INT(PLAYER_ID())]
    GlobalplayerBD_FM_2 = function()
        return 1882632 + 1 + players.user() * 146
    end,

    -- GlobalplayerBD_FM_3[NATIVE_TO_INT(PLAYER_ID())]
    GlobalplayerBD_FM_3 = function()
        return 1887549 + 1 + players.user() * 611
    end,



    -- MPGlobalsAmbienceStruct
    MPGlobalsAmbience = 2739811,


    bBrowserVisible = 76498,


    -- g_FMMC_STRUCT_ENTITIES.sPlacedZones[iZone].iZoneTimer_EnableTime
    CasinoVault_ZoneTimer_EnableTime = 4718592 + 212658 + 1 + 0 * 191 + 42,
}



-- GlobalPlayerBroadcastDataFM
GlobalplayerBD_FM = {
    iCurrentMissionType = function()
        return Globals.GlobalplayerBD_FM()
    end
}

-- PROPERTY_BROADCAST_DETAILS
GlobalplayerBD_FM.propertyDetails = {
    _ = 268, -- offset

    iCurrentlyInsideProperty = function()
        return Globals.GlobalplayerBD_FM() + GlobalplayerBD_FM.propertyDetails._ + 35
    end
}


-- GlobalPlayerBroadcastDataFM_3
GlobalplayerBD_FM_3 = {}

-- STRUCT_MAGNATE_GANG_BOSS_GLOBAL_PLAYER_BD
GlobalplayerBD_FM_3.sMagnateGangBossData = {
    _ = 10, -- offset

    -- GlobalplayerBD_FM_3[NATIVE_TO_INT(PLAYER_ID())].sMagnateGangBossData.

    iMissionToLaunch = function()
        return Globals.GlobalplayerBD_FM_3() + GlobalplayerBD_FM_3.sMagnateGangBossData._ + 32
    end,
    iActiveMission = function()
        return Globals.GlobalplayerBD_FM_3() + GlobalplayerBD_FM_3.sMagnateGangBossData._ + 33
    end,
    iNumGoonsInGang = function()
        return Globals.GlobalplayerBD_FM_3() + GlobalplayerBD_FM_3.sMagnateGangBossData._ + 19
    end
}

-- CONTRABAND_MISSION_DATA
GlobalplayerBD_FM_3.sMagnateGangBossData.contrabandMissionData = function()
    local _offset = GlobalplayerBD_FM_3.sMagnateGangBossData._ + 183
    local _index = Globals.GlobalplayerBD_FM_3() + _offset

    return {
        iMissionWarehouse = _index,
        contrabandSize = _index + 1,
        contrabandType = _index + 2,
        bSpecialItem = _index + 3
    }
end



-- MPGlobalsAmbienceStruct
MPGlobalsAmbience = {
    -- MAGNATE_GANG_BOSS_LOCAL_GLOBALS
    sMagnateGangBossData = {
        iMissionVariation = Globals.MPGlobalsAmbience + 5265 + 347
    },

    BountyMostWantedPayment = 7116
}



-- CONTACT_REQUEST_GB_MISSION_LAUNCH_STRUCT
local _g_sContactRequestGBMissionLaunch = 1980677
g_sContactRequestGBMissionLaunch = {
    iType = _g_sContactRequestGBMissionLaunch,
    iVariation = _g_sContactRequestGBMissionLaunch + 1,
    iSubvariation = _g_sContactRequestGBMissionLaunch + 2,
    iDelay = _g_sContactRequestGBMissionLaunch + 3,
    iBitSet = _g_sContactRequestGBMissionLaunch + 4,
    Timer = _g_sContactRequestGBMissionLaunch + 5
}

-- -- PAYPHONE_FLOW_GLOBAL_STRUCT
-- local _g_PayphoneFlow = 2709501
-- g_PayphoneFlow = {
--     iBitset = _g_PayphoneFlow + 1
-- }

-- -- FIXER_FLOW_DATA
-- local _g_sFixerFlow = 1976231
-- g_sFixerFlow = {
--     -- FIXER_SECURITY_CONTRACT_DATA
--     SecurityContracts = _g_sFixerFlow + 20
-- }



-- FMMC_ROCKSTAR_CREATED_STRUCT
g_FMMC_ROCKSTAR_CREATED = {
    -- g_FMMC_ROCKSTAR_CREATED.sMissionHeaderVars[iArrayPos]
    _sMissionHeaderVars = 794744 + 4 + 1,

    -- CLOUD_LOADED_MISSION_HEADER_DETAILS
    sMissionHeaderVars = function(iArrayPos)
        local _index = g_FMMC_ROCKSTAR_CREATED._sMissionHeaderVars + iArrayPos * 89

        return {
            tlName = _index,
            iMinPlayers = _index + 69,
            iMaxPlayers = _index + 71,
            iMaxNumberOfTeams = _index + 72
        }
    end
}


-- FMMC_GLOBAL_STRUCT
local _g_FMMC_STRUCT = 4718592
g_FMMC_STRUCT = {
    iNumParticipants = _g_FMMC_STRUCT + 3522,
    iMinNumParticipants = _g_FMMC_STRUCT + 3523,

    iDifficulity = _g_FMMC_STRUCT + 3525,
    iNumberOfTeams = _g_FMMC_STRUCT + 3526,
    iMaxNumberOfTeams = _g_FMMC_STRUCT + 3527,
    iNumPlayersPerTeam = _g_FMMC_STRUCT + 3529 + 1, -- +[0~3]

    iRootContentIDHash = _g_FMMC_STRUCT + 128476,
    tl63MissionName = _g_FMMC_STRUCT + 127185,
    tl31LoadedContentID = _g_FMMC_STRUCT + 128763,
    tl23NextContentID = _g_FMMC_STRUCT + 128791 + 1, -- +[0~5]*6

    iFixedCamera = _g_FMMC_STRUCT + 157365,
    iCriticalMinimumForTeam = _g_FMMC_STRUCT + 180865 + 1 -- +[0~3]
}


-- TRANSITION_SESSION_NON_RESET_VARS
local _g_TransitionSessionNonResetVars = 2685658
g_TransitionSessionNonResetVars = {
    bAmIHeistLeader = _g_TransitionSessionNonResetVars + 6393,

    bHasQuickRestarted = _g_TransitionSessionNonResetVars + 6498,
    bHasQuickRestartedDuringStrandMission = _g_TransitionSessionNonResetVars + 6499,
    bAnyPlayerDiedDuringMission = _g_TransitionSessionNonResetVars + 6500
}

-- TRANSITION_SESSION_MAINTAIN_VARS
local _sTransVars = _g_TransitionSessionNonResetVars + 1
g_TransitionSessionNonResetVars.sTransVars = {
    iCoronaBitSet = _sTransVars + 2813
}



-- FMMC_TRANSITION_SESSION_DATA
g_sTransitionSessionData = 2684718

-- FMMC_STRAND_MISSION_DATA
local _sStrandMissionData = g_sTransitionSessionData + 43
sStrandMissionData = {
    bPassedFirstMission = _sStrandMissionData + 55,
    bPassedFirstStrandNoReset = _sStrandMissionData + 56,
    bIsThisAStrandMission = _sStrandMissionData + 57,
    bLastMission = _sStrandMissionData + 58
}



-- HEIST_CLIENT_PRE_PLANNING_LOCAL_DATA
local _g_HeistPrePlanningClient = 1929352
g_HeistPrePlanningClient = {
    eHeistFlowState = _g_HeistPrePlanningClient
}

-- HEIST_CLIENT_PLANNING_LOCAL_DATA
local _g_HeistPlanningClient = 1931285
g_HeistPlanningClient = {
    bHeistCoronaActive = _g_HeistPlanningClient + 2816
}

-- HEIST_CLIENT_SHARED_LOCAL_DATA
local _g_HeistSharedClient = 1934895
g_HeistSharedClient = {
    PlanningBoardIndex = _g_HeistSharedClient,
    vBoardPosition = _g_HeistSharedClient + 16
}



-- CASINO_HEIST_MISSION_CONFIGURATION_DATA
local _g_sCasinoHeistMissionConfigData = 1965580
g_sCasinoHeistMissionConfigData = {
    -- Not determined by players
    eChosenApproachType = _g_sCasinoHeistMissionConfigData,
    eTarget = _g_sCasinoHeistMissionConfigData + 1,
    -- Optional Preps that affect the finale, not selected on heist board
    bSecurityCameraLocationsScoped = _g_sCasinoHeistMissionConfigData + 2,
    bGuardPatrolRoutesScoped = _g_sCasinoHeistMissionConfigData + 3,
    eShipmentDisruptionLevel = _g_sCasinoHeistMissionConfigData + 4,
    bStealthNightVisionAcquired = _g_sCasinoHeistMissionConfigData + 5,
    bHandheldDrillAcquired = _g_sCasinoHeistMissionConfigData + 6,
    bEMPAcquired = _g_sCasinoHeistMissionConfigData + 7,
    -- selectable on heist board without Preps
    eDropoffLocation = _g_sCasinoHeistMissionConfigData + 8,
    eDropoffSubLocation = _g_sCasinoHeistMissionConfigData + 9,
    bDecoyCrewMemberPurchased = _g_sCasinoHeistMissionConfigData + 10,
    bSwitchGetawayVehiclePurchased = _g_sCasinoHeistMissionConfigData + 11,
    eVehicleModPresetChosen = _g_sCasinoHeistMissionConfigData + 12,
    -- FM prep that unlocks the choice on the heist board
    eCrewWeaponsExpertChosen = _g_sCasinoHeistMissionConfigData + 13,
    eCrewWeaponsLoadoutChosen = _g_sCasinoHeistMissionConfigData + 14,
    eCrewDriverChosen = _g_sCasinoHeistMissionConfigData + 15,
    eCrewVehiclesLoadoutChosen = _g_sCasinoHeistMissionConfigData + 16,
    eCrewHackerChosen = _g_sCasinoHeistMissionConfigData + 17,
    eCrewKeyAccessLevel = _g_sCasinoHeistMissionConfigData + 18,
    eEntranceChosen = _g_sCasinoHeistMissionConfigData + 19,
    eExitChosen = _g_sCasinoHeistMissionConfigData + 20,
    eMasksChosen = _g_sCasinoHeistMissionConfigData + 21,
    -- Subterfuge approach only
    eSubterfugeOutfitsIn = _g_sCasinoHeistMissionConfigData + 22,
    eSubterfugeOutfitsOut = _g_sCasinoHeistMissionConfigData + 23,
    bOfficeInfested = _g_sCasinoHeistMissionConfigData + 24,
    -- Extra Data
    iAccessPointBitset = _g_sCasinoHeistMissionConfigData + 25,
    bRappelGearAcquired = _g_sCasinoHeistMissionConfigData + 26,
    bHardMode = _g_sCasinoHeistMissionConfigData + 27
}



-- HEIST_ISLAND_PLAYER_BD_DATA
GlobalPlayerBD_HeistIsland = {
    -- HEIST_ISLAND_CONFIG
    sConfig = function()
        -- GlobalPlayerBD_HeistIsland[NATIVE_TO_INT(PLAYER_ID())].sConfig
        return 1974391 + 1 + players.user() * 53 + 5
    end
}

-- NET_HEIST_PLANNING_GENERIC_PLAYER_BD_DATA
GlobalPlayerBD_NetHeistPlanningGeneric = {
    -- GlobalPlayerBD_NetHeistPlanningGeneric[NATIVE_TO_INT(PLAYER_ID())].stFinaleLaunchTimer
    stFinaleLaunchTimer = function()
        return 1973526 + 1 + players.user() * 27 + 18
    end
}



-- WAREHOUSE_CARGO_SOURCING_DATA_STRUCT
local _g_sWarehouseCargoSourcingData = 1882747
g_sWarehouseCargoSourcingData = {
    bRequestDeliverCargo = _g_sWarehouseCargoSourcingData + 4 + 1, -- +[0~4]
    iNumCargo = _g_sWarehouseCargoSourcingData + 12,
    iSpecialCargoType = _g_sWarehouseCargoSourcingData + 13,
    iNumSpecialCargo = _g_sWarehouseCargoSourcingData + 14,
    eType = _g_sWarehouseCargoSourcingData + 15
}

local _g_sHangarCargoSourcingData = 1882771
g_sHangarCargoSourcingData = {
    iNum = _g_sHangarCargoSourcingData + 6,
    eType = _g_sHangarCargoSourcingData + 7
}

g_sHangarCargoSourcingDataBitset = function()
    return Globals.GlobalplayerBD() + 204
end



-- MP_SAVED_TUNER_CLIENT_VEHICLE_STRUCT
g_sClientVehicleSetupStruct = 2710000

-- MP_SAVED_TUNER_CLIENT_VEHICLE_STRUCT
g_sBikerClientVehicleSetupStruct = 2710900


g_iFactoryPaidResupplyTimers = 1667995


-- BUSINESS_APP_MANAGEMENT_DATA
local _g_sBusAppManagement = 1963766
g_sBusAppManagement = {
    iPropertyID = _g_sBusAppManagement,
    bRunningPrimaryApp = _g_sBusAppManagement + 1,
    bSecuroSpecCargo = _g_sBusAppManagement + 2
}




----------------------------------------------
--                LOCALS
----------------------------------------------

Locals = {
    --------  Heist Mission  --------

    ["fm_mission_controller"] = {
        iNextMission = 19781 + 1062,
        iTeamScore = 19781 + 1232 + 1, -- +[0~3]

        iServerGameState = 19781,
        iServerBitSet = 19781 + 1,
        iServerBitSet1 = 19781 + 2,

        iCashGrabTotalDrop = 19781 + 2685,
        iCashGrabTotalTake = 19781 + 2686,

        iTeamKills = 19781 + 1725 + 1,
        iTeamHeadshots = 19781 + 1740 + 1,

        iTotalMissionEndTime = 19781 + 987,

        iClientBitSet = function()
            -- MC_playerBD[PARTICIPANT_ID_TO_INT()].iClientBitSet
            return 31656 + 1 + NETWORK.PARTICIPANT_ID_TO_INT() * 293 + 127
        end,


        iLocalBoolCheck11 = 15200,


        iAdditionalTeamLives = 26207 + 1325 + 1,      -- +[0~3]

        tdObjectiveLimitTimer = 26207 + 740 + 1,      -- +[0~3]*2
        tdMultiObjectiveLimitTimer = 26207 + 749 + 1, -- +[0~3]*2
        iMultiObjectiveTimeLimit = 26207 + 765 + 1,   -- +[0~3]


        stZoneTimers = 60654 + 1 + 0 * 2, -- casino vault
    },
    ["fm_mission_controller_2020"] = {
        iNextMission = 52171 + 1589,
        iTeamScore = 52171 + 1776 + 1, -- +[0~3]

        iServerGameState = 52171,
        iServerBitSet = 52171 + 1,
        iServerBitSet1 = 52171 + 2,

        iTotalMissionEndTime = 52171 + 1496,
        sMissionContinuityVars = {
            iTotalMissionTime = 55623 + 1518 + 29
        },


        iLocalBoolCheck11 = 50815,


        iAdditionalTeamLives = 58874 + 1109 + 1,      -- +[0~3]

        tdObjectiveLimitTimer = 58874 + 297 + 1,      -- +[0~3]*2
        tdMultiObjectiveLimitTimer = 58874 + 306 + 1, -- +[0~3]*2
        iMultiObjectiveTimeLimit = 58874 + 322 + 1,   -- +[0~3]
    },

    --------  Business Mission  --------

    ["gb_contraband_buy"] = {
        eEndReason = 621 + 192,
        eModeState = 621 + 191,
        contrabandSize = 621 + 1, -- serverBD.sContraband.sContrabandMissionData.contrabandSize
        eType = 621 + 5           -- serverBD.sContraband.eType
    },
    ["gb_contraband_sell"] = {
        eSellVar = 563 + 7,
        eEndReason = 563 + 6,
        eModeState = 563 + 5
    },
    ["gb_gunrunning"] = {
        iGunrunEntityBitSet = 1262 + 4 + 63,
        eEndReason = 1262 + 582,
        eModeState = 1262 + 581,
        eMissionVariation = 1262 + 1,
        iNumEntitiesThisVariation = 1262 + 774,
        iTotalDeliveredCount = 1262 + 816
    },
    ["gb_smuggler"] = {
        iSmugglerEntityBitSet = 1985 + 6 + 63,
        eEndReason = 1985 + 771,
        eModeState = 1985 + 770,
        eMissionVariation = 1985 + 2,
        iNumEntitiesThisVariation = 1985 + 1035,
        iTotalDeliveredCount = 1985 + 1078
    },
    ["business_battles_sell"] = {
        eEndReason = 2364 + 26,
        eModeState = 2364 + 25,
        sMissionEntity = 2364 + 32,
        iTotalDeliveredCount = 2364 + 202,
        iTotalDeliveriesToMake = 2364 + 203
    },
    ["gb_illicit_goods_resupply"] = {
        iIllicitGoodBitset0 = 958 + 796,
        eEndReason = 958 + 506,
        eModeState = 958 + 505
    },
    ["gb_biker_contraband_sell"] = {
        eSellVar = 725 + 17,
        iVehicleCountDeliveredAllContraband = 725 + 978,
        iDroppedOffCount = 725 + 122,
        eEndReason = 725 + 15,
        eModeState = 725 + 14
    },
    ["gb_vehicle_export"] = {
        iExportEntityNetId = 876 + 29,
        exportEntityIeVehicleEnum = 876 + 39,
        eModeState = 876 + 459,
        sCarBombStruct = {
            iCarBombBitSet = 387 + 1
        },
    },

    --------  Client Work  --------

    ["gb_bank_job"] = {
        iMissionEntityBitSet = 1248 + 7 + 1 + 0 * 4 + 1 + 1 + 0, -- iMissionEntity = 0
        eModeState = 1248 + 5,
        eEndReason = 1248 + 6
    },
    ["gb_data_hack"] = {
        eEndReason = 1948 + 7
    },
    ["gb_infiltration"] = {
        eEndReason = 1736 + 6
    },
    ["gb_jewel_store_grab"] = {
        piDeliverer = 1268 + 8,
        eEndReason = 1268 + 6
    },

    --------  Heist Preps  --------

    ["gb_gangops"] = {
        iPhotosTaken = 2015 + 1194,
        iNumEntitiesThisVariation = 2015 + 1040,
        iMissionEntityBitSet = 2015 + 6 + 63,
        eEndReason = 2015 + 782,
        eModeState = 2015 + 781
    },

    --------  FM Content Mission  --------

    ["fm_content_acid_lab_sell"] = {
        iDropOffCount = 140 + 9 + 1,
        iTotalDropoffs = 140 + 9
    },
    ["fm_content_auto_shop_delivery"] = {
        iMissionEntityBitSet = 1625 + 2 + 5
    },
    ["fm_content_bike_shop_delivery"] = {
        iMissionEntityBitSet = 1627 + 2 + 5
    },
    ["fm_content_club_source"] = {
        iGoodsToTransfer = function()
            return 4392 + 1 + NETWORK.PARTICIPANT_ID_TO_INT() * 125 + 73
        end,
        eGoodsType = 3632 + 721 + 3
    },
    ["fm_content_daily_bounty"] = {
        iMissionBitSet = 2612 + 373
    },
    ["fm_content_payphone_hit"] = {
        iMissionServerBitSet = 5778 + 747
    },
    ["fm_content_smuggler_ops"] = {
        iMissionBitSet = 7728 + 1334
    },
    ["fm_content_smuggler_resupply"] = {
        iNumEntitiesThisVariation = 250 + 19,
        iSmugglerEntityBitSet = 6166 + 2 + 14
    },
    ["fm_content_smuggler_sell"] = {
        iDropOffCount = 140 + 60 + 1,
        iTotalDropoffs = 140 + 60
    },
    ["fm_content_vehrob_arena"] = {
        iChallengeCondition = 7922 + 1343 + 14,
        iChallengeBitset = 7922 + 1341
    },
    ["fm_content_vehrob_cargo_ship"] = {
        iChallengeBitset = 7237 + 1290
    },
    ["fm_content_vehrob_casino_prize"] = {
        iChallengeBitset = 9221 + 1314
    },
    ["fm_content_vehrob_police"] = {
        iChallengeCondition = 9045 + 1337 + 8 + 1
    },
    ["fm_content_vehrob_submarine"] = {
        iChallengeCondition = 6250 + 1200 + 19,
        iChallengeBitset = 6250 + 1197
    },

    ["fm_content_hacker_cargo_finale"] = {
        iChallengeBitset = 7671 + 1342,
        iChallengeCondition = 7671 + 1344 + 18,
        iChallengeBitset2 = 7671 + 1014,
        iChallengeConditionArray = 274 + 2414 + 1
    },
    ["fm_content_hacker_house_finale"] = {
        iChallengeBitset = 8126 + 1234
    },
    ["fm_content_hacker_whistle_fin"] = {
        iChallengeBitset = 6653 + 1227
    },
    ["fm_content_hacker_zancudo_fin"] = {
        iChallengeBitset = 8535 + 1223
    },

    --------  Heist Planning Board  --------

    ["gb_casino_heist_planning"] = {
        iScriptStage = 206,
    },
    ["gb_gang_ops_planning"] = {
        iScriptStage = 205,
    },
    ["heist_island_planning"] = {
        iScriptStage = 1564,
    },
    ["tuner_planning"] = {
        iScriptStage = 401,
    },
    ["vehrob_planning"] = {
        iScriptStage = 530,
    },

    --------  Other  --------

    ["am_imp_exp"] = {
        CarList = {
            iCar = 378 + 1,             -- +[0~4]
            bIsDelivered = 378 + 6 + 1, -- +[0~4]
        }
    },
    ["carmod_shop"] = {
        iPersonalCarModShopFlags = 1605
    },
    ["shop_controller"] = {
        iLocalBS = 355,

        iAutoShopRandomTime = 356,
        iBikerShopRandomTime = 370
    },
    ["social_controller"] = {
        eMaintainStage = 65,
    },
}



-- `fmmc_launcher`
-- MISSION_TO_LAUNCH_DETAILS
local _sLaunchMissionDetails = 19875
sLaunchMissionDetails = {
    iMinPlayers = _sLaunchMissionDetails + 15,
    iMaxParticipants = _sLaunchMissionDetails + 32,
    iMissionVariation = _sLaunchMissionDetails + 34
}


-- `freemode` Time Trial
-- AMTT_VARS_STRUCT
local _sTTVarsStruct = 14486
sTTVarsStruct = {
    iVariation = _sTTVarsStruct + 11,
    trialTimer = _sTTVarsStruct + 13,
    iPersonalBest = _sTTVarsStruct + 25,
    eAMTT_Stage = _sTTVarsStruct + 29
}


-- `freemode` RC Bandito Time Trial
-- AMRCTT_VARS_STRUCT
local _sRCTTVarsStruct = 14536
sRCTTVarsStruct = {
    eVariation = _sRCTTVarsStruct,
    eRunStage = _sRCTTVarsStruct + 2,
    timerTrial = _sRCTTVarsStruct + 6,
    iPersonalBest = _sRCTTVarsStruct + 21
}




----------------------------------------------
--                FUNCTIONS
----------------------------------------------

local g_sCURRENT_UGC_STATUS = 2693671
local g_iMissionEnteryType = 1057440

function LAUNCH_MISSION(Data)
    local iArrayPos = MISC.GET_CONTENT_ID_INDEX(Data.iRootContentID)

    local sMissionHeaderVars = g_FMMC_ROCKSTAR_CREATED.sMissionHeaderVars(iArrayPos)

    local tlName = GLOBAL_GET_STRING(sMissionHeaderVars.tlName)
    local iMaxPlayers = GLOBAL_GET_INT(sMissionHeaderVars.iMaxPlayers)


    -- g_TransitionSessionNonResetVars.bSaveBeforeCoronaVehicle = TRUE
    GLOBAL_SET_INT(_g_TransitionSessionNonResetVars + 3851, 1)

    -- CLEAR_PAUSE_MENU_IS_USING_UGC()
    ---- g_sCURRENT_UGC_STATUS.g_bPAUSE_MENU_USING_UGC = FALSE
    GLOBAL_SET_INT(g_sCURRENT_UGC_STATUS + 1, 0)

    -- SET_TRANSITION_SESSIONS_SKIP_JOB_WARNING()
    ---- SET_BIT(g_sTransitionSessionData.iThirdBitSet, ciTRANSITION_SESSIONS_SKIP_JOB_WARNING)
    GLOBAL_SET_BIT(g_sTransitionSessionData + 3, 2)


    if Data.iMissionEnteryType then
        -- SET_FM_JOB_ENTERY_TYPE(ciMISSION_ENTERY_TYPE_XXX)
        ---- g_iMissionEnteryType = iType
        GLOBAL_SET_INT(g_iMissionEnteryType, Data.iMissionEnteryType)
    end


    --[[
    if Data.iMissionType == 274 then
        -- FMMC_TYPE_TUNER_ROBBERY_FINALE

        -- SET_TRANSITION_SESSIONS_LAUNCHING_TUNER_ROBBERY_FROM_BOARD()
        ---- SET_BIT(g_sTransitionSessionData.iThirdBitSet, ciTRANSITION_SESSIONS_LAUNCHING_TUNER_ROBBERY_FROM_BOARD)
        GLOBAL_SET_BIT(g_sTransitionSessionData + 3, 13)

        -- SET_PLAYER_LAUNCHING_TUNER_ROBBERY_IN_AUTO_SHOP()
        ---- SET_BIT(GlobalplayerBD_FM_2[NATIVE_TO_INT(PLAYER_ID())].iMissionDataBitSetTwo, ciMISSION_DATA_TWO_LAUNCHING_TUNER_ROBBERY_IN_AUTO_SHOP)
        GLOBAL_SET_BIT(Globals.GlobalplayerBD_FM_2() + 33, 28)
    elseif Data.iMissionType == 260 then
        -- FMMC_TYPE_HEIST_ISLAND_FINALE

        -- SET_TRANSITION_SESSIONS_LAUNCHING_ISLAND_HEIST_FROM_BOARD()
        ---- SET_BIT(g_sTransitionSessionData.iThirdBitSet, ciTRANSITION_SESSIONS_LAUNCHING_ISLAND_HEIST_FROM_BOARD)
        GLOBAL_SET_BIT(g_sTransitionSessionData + 3, 11)

        -- HEIST_ISLAND__FLOW_SET_LAUNCHING_HEIST_IN_SUB()
        ---- SET_BIT(GlobalplayerBD_FM_2[NATIVE_TO_INT(PLAYER_ID())].iMissionDataBitSetTwo, ciMISSION_DATA_TWO_LAUNCHING_ISLAND_HEIST_IN_SUB)
        GLOBAL_SET_BIT(Globals.GlobalplayerBD_FM_2() + 33, 27)
    elseif Data.iMissionType == 158 then
        -- FMMC_TYPE_GB_CASINO_HEIST

        -- SET_TRANSITION_SESSIONS_LAUNCHING_CASINO_HEIST_FROM_BOARD()
        ---- SET_BIT(g_sTransitionSessionData.iThirdBitSet, ciTRANSITION_SESSIONS_LAUNCHING_CASINO_HEIST_FROM_BOARD)
        GLOBAL_SET_BIT(g_sTransitionSessionData + 3, 10)

        -- SMV_FLOW_SET_LAUNCHING_SMV_IN_OFFICE()
        ---- SET_BIT(GlobalplayerBD_FM_2[NATIVE_TO_INT(PLAYER_ID())].iMissionDataBitSetTwo, ciMISSION_DATA_TWO_LAUNCHING_SMV_IN_OFFICE)
        GLOBAL_SET_BIT(Globals.GlobalplayerBD_FM_2() + 33, 12)
    elseif Data.iMissionType == 233 or Data.iMissionType == 235 then
        -- FMMC_TYPE_FM_GANGOPS, FMMC_TYPE_FM_GANGOPS_FIN

        -- SVM_FLOW_SET_TRANSITION_SESSIONS_LAUNCHING_SMV_FROM_LAPTOP()
        ---- SET_BIT(g_sTransitionSessionData.iThirdBitSet, ciTRANSITION_SESSIONS_LAUNCHING_SVM_FROM_LAPTOP)
        GLOBAL_SET_BIT(g_sTransitionSessionData + 3, 4)

        -- SMV_FLOW_SET_LAUNCHING_SMV_IN_OFFICE()
        ---- SET_BIT(GlobalplayerBD_FM_2[NATIVE_TO_INT(PLAYER_ID())].iMissionDataBitSetTwo, ciMISSION_DATA_TWO_LAUNCHING_SMV_IN_OFFICE)
        GLOBAL_SET_BIT(Globals.GlobalplayerBD_FM_2() + 33, 12)

        -- SET_TRANSITION_SESSIONS_PICKED_SPECIFIC_JOB()
        ---- SET_BIT(g_sTransitionSessionData.iSecondBitSet, ciTRANSITION_SESSIONS_PICKED_SPECIFIC_JOB)
        GLOBAL_SET_BIT(g_sTransitionSessionData + 2, 29)
    end
    ]]


    -- SET_TRANSITION_SESSIONS_QUICK_MATCH_TYPE(FMMC_TYPE_XXX)
    ---- g_sTransitionSessionData.iMissionType = iMissionType
    GLOBAL_SET_INT(g_sTransitionSessionData + 9, Data.iMissionType)


    -- SET_MY_TRANSITION_SESSION_CONTENT_ID(tlName)
    ---- g_sTransitionSessionData.stFileName = stPassed
    GLOBAL_SET_STRING(g_sTransitionSessionData + 863, tlName)

    -- SET_TRANSITION_SESSIONS_QUICK_MATCH_MAX_PLAYERS(iMaxPlayers)
    ---- g_sTransitionSessionData.iMaxPlayers = iMaxPlayers
    GLOBAL_SET_INT(g_sTransitionSessionData + 42, iMaxPlayers)


    -- CLEAR_TRANSITION_SESSIONS_NEED_TO_SKYCAM_UP_NOT_WARP()
    ---- CLEAR_BIT(g_sTransitionSessionData.iSecondBitSet, ciTRANSITION_SESSIONS_NEED_TO_SKYCAM_UP_NOT_WARP)
    GLOBAL_CLEAR_BIT(g_sTransitionSessionData + 2, 14)

    -- SET_TRANSITION_SESSIONS_STARTING_QUICK_MATCH()
    ---- SET_BIT(g_sTransitionSessionData.iBitSet, ciTRANSITION_SESSIONS_STARTING_QUICK_MATCH)
    GLOBAL_SET_BIT(g_sTransitionSessionData, 5)
    ---- SET_TRANSITION_SESSIONS_SETTING_UP_QUICKMATCH()
    ------ SET_BIT(g_sTransitionSessionData.iBitSet, ciTRANSITION_SESSIONS_SETTING_UP_QUICKMATCH)
    GLOBAL_SET_BIT(g_sTransitionSessionData, 8)

    -- (bSkipSkyCam)
    -- CLEAR_TRANSITION_SESSIONS_NEED_TO_WARP_TO_START_SKYCAM()
    ---- CLEAR_BIT(g_sTransitionSessionData.iBitSet, ciTRANSITION_SESSIONS_NEED_TO_WARP_TO_START_SKYCAM)
    GLOBAL_CLEAR_BIT(g_sTransitionSessionData, 7)
    -- CLEAR_TRANSITION_SESSIONS_CORONA_CONTROLLER_MAINTAIN_CAMERA()
    ---- CLEAR_BIT(g_sTransitionSessionData.iBitSet, ciTRANSITION_SESSIONS_CORONA_CONTROLLER_MAINTAIN_CAMERA)
    GLOBAL_CLEAR_BIT(g_sTransitionSessionData, 15)


    -- CLEAR_TRANSITION_SESSIONS_CREATE_WITH_OPEN_MATCHMAKING()
    ---- g_sTransitionSessionData.bCreateWithOpenMatchMaking = FALSE
    GLOBAL_SET_INT(g_sTransitionSessionData + 717, 0)

    -- SET_TRANSITION_SESSIONS_FORCE_ME_HOST_QUICK_MATCH()
    ---- g_sTransitionSessionData.bForceMeHost = TRUE
    GLOBAL_SET_INT(g_sTransitionSessionData + 719, 1)


    -- GlobalplayerBD_FM[NATIVE_TO_INT(PLAYER_ID())].iFmLauncherGameState = FMMC_LAUNCHER_STATE_LOAD_MISSION_FOR_TRANSITION_SESSION
    GLOBAL_SET_INT(Globals.GlobalplayerBD_FM() + 96, 8)
end

-- g_structLocalHeistControl
local g_sLocalMPHeistControl = {
    _lhcMyCorona = 2635079 + 3
}

-- g_structMyHeistCorona
g_sLocalMPHeistControl.lhcMyCorona = {
    mhcAvailable = g_sLocalMPHeistControl._lhcMyCorona,
    mhcContentID = g_sLocalMPHeistControl._lhcMyCorona + 1,
    mhcIsFinale = g_sLocalMPHeistControl._lhcMyCorona + 7,
    mhcIsIntroCutscene = g_sLocalMPHeistControl._lhcMyCorona + 8,
    mhcIsMidStrandCutscene = g_sLocalMPHeistControl._lhcMyCorona + 9,
    mhcMatcID = g_sLocalMPHeistControl._lhcMyCorona + 10,
    mhcInCorona = g_sLocalMPHeistControl._lhcMyCorona + 11,
    mhcAlreadyTransitioned = g_sLocalMPHeistControl._lhcMyCorona + 12,
    mhcIsTutorialHeist = g_sLocalMPHeistControl._lhcMyCorona + 13,
}

function LAUNCH_APARTMENT_HEIST(ContentID)
    GLOBAL_SET_BOOL(g_sLocalMPHeistControl.lhcMyCorona.mhcAvailable, true)
    GLOBAL_SET_STRING(g_sLocalMPHeistControl.lhcMyCorona.mhcContentID, ContentID)
    GLOBAL_SET_BOOL(g_sLocalMPHeistControl.lhcMyCorona.mhcIsFinale, true)
    GLOBAL_SET_BOOL(g_sLocalMPHeistControl.lhcMyCorona.mhcIsIntroCutscene, false)
    GLOBAL_SET_BOOL(g_sLocalMPHeistControl.lhcMyCorona.mhcIsMidStrandCutscene, false)
    GLOBAL_SET_INT(g_sLocalMPHeistControl.lhcMyCorona.mhcMatcID, -1) -- ILLEGAL_AT_COORDS_ID
    GLOBAL_SET_BOOL(g_sLocalMPHeistControl.lhcMyCorona.mhcInCorona, false)
    GLOBAL_SET_BOOL(g_sLocalMPHeistControl.lhcMyCorona.mhcAlreadyTransitioned, false)
    GLOBAL_SET_BOOL(g_sLocalMPHeistControl.lhcMyCorona.mhcIsTutorialHeist, false)

    GLOBAL_SET_BOOL(g_HeistPlanningClient.bHeistCoronaActive, true)
end

function INSTANT_FINISH_CASINO_HEIST_PREPS()
    local script = "gb_casino_heist"

    local serverBD = 4470

    local eMissionVariation = LOCAL_GET_INT(script, serverBD + 1325)
    if eMissionVariation == 4 then
        LOCAL_SET_INT(script, serverBD + 1568, 10)
    elseif eMissionVariation == 2 then
        LOCAL_SET_BIT(script, serverBD + 1472 + 1 + 3, 22)
    elseif eMissionVariation == 1 then
        LOCAL_SET_INT(script, serverBD + 1329, 17)
    elseif eMissionVariation == 32 or eMissionVariation == 31 or eMissionVariation == 30 then
        LOCAL_SET_INT(script, serverBD + 1631, 30)
    elseif eMissionVariation == 28 or eMissionVariation == 29 then
        LOCAL_SET_BITS(script, serverBD + 1645, 0, 1)
    elseif eMissionVariation == 52 then
        LOCAL_SET_BIT(script, serverBD + 1472 + 1 + 1, 30)
    elseif eMissionVariation == 37 then
        local iOrganisationSizeOnLaunch = LOCAL_GET_INT(script, serverBD + 1516)
        if iOrganisationSizeOnLaunch == 1 then
            LOCAL_SET_BITS(script, serverBD + 1645, 1, 2, 3)
        else
            LOCAL_SET_BITS(script, serverBD + 1645, 1, 2, 3, 4, 5)
        end
    end
    LOCAL_SET_INT(script, serverBD + 1329, 3) -- SET_END_REASON(eENDREASON_MISSION_ENTITY_DELIVERED)
end

function INSTANT_FINISH_CASINO_WORK()
    local script = "gb_casino"

    local serverBD = 2904
    local playerBD = 4576

    local eMissionVariation = LOCAL_GET_INT(script, serverBD + 1321)
    if eMissionVariation == 14 then -- CSV_TRACKING_CHIPS
        for i = 0, 4 do
            -- SET_FIND_ITEM_BIT(iChip, eFINDITEMBITSET_COLLECTED)
            LOCAL_SET_BIT(script, serverBD + 1573 + 1 + i, 1)
        end
    end

    local iNumEntitiesThisVariation = LOCAL_GET_INT(script, serverBD + 1541)
    local partId = NETWORK.NETWORK_GET_PARTICIPANT_INDEX(players.user())
    for i = 0, iNumEntitiesThisVariation - 1, 1 do
        -- SET_MISSION_ENTITY_BIT(iMissionEntity, eMISSIONENTITYBITSET_DELIVERED)
        LOCAL_SET_BIT(script, serverBD + 63 + 1 + i * 3 + 1 + 0, 4)

        -- SET_MISSION_ENTITY_CLIENT_BIT(iMissionEntity, NETWORK_GET_PARTICIPANT_INDEX(playerID), eMISSIONENTITYCLIENTBITSET_MY_GANG_DELIVERED_MISSION_ENTITY)
        LOCAL_SET_BIT(script, playerBD + 1 + partId * 266 + 9 + 1 + i * 3 + 1 + 1, 3)
    end

    LOCAL_SET_INT(script, serverBD + 1324, 3)  -- SET_END_REASON(eENDREASON_MISSION_ENTITY_DELIVERED)
    LOCAL_SET_INT(script, serverBD + 1323, 33) -- SET_MODE_STATE(eMODESTATE_REWARDS)
end

function COMPLETE_DAILY_CHALLENGE()
    -- g_savedMPGlobalsNew.g_savedMPGlobals[GET_SAVE_GAME_ARRAY_SLOT()].MpSavedGeneral.Current_Daily_Objectives[i].bCompleted
    for i = 0, 2, 1 do
        GLOBAL_SET_INT(2359296 + 1 + 0 * 5571 + 681 + 4245 + 1 + i * 3 + 1, 1)
    end
end

function COMPLETE_WEEKLY_CHALLENGE(bComplete)
    local g_sWeeklyChallenge = 2738865

    GLOBAL_SET_INT(g_sWeeklyChallenge + 1 + 0 * 6 + 3, 0)
    GLOBAL_SET_INT(g_sWeeklyChallenge + 1 + 0 * 6 + 4, 0)

    if bComplete then
        local target = GLOBAL_GET_INT(g_sWeeklyChallenge + 1 + 0 * 6 + 2)
        GLOBAL_SET_INT(g_sWeeklyChallenge + 1 + 0 * 6 + 1, target)
    else
        GLOBAL_SET_INT(g_sWeeklyChallenge + 1 + 0 * 6 + 1, 0)
    end
end

function CLEAR_BIG_MESSAGE()
    for i = 0, 3 do
        -- MPGlobals.g_BigMessage[i].iMessageState
        GLOBAL_SET_INT(2672939 + 2590 + 1 + i * 80 + 2, 5) -- BIG_MESSAGE_STATE_CLEANUP

        -- MPGlobals.g_BigMessage[i].iBigMessageBitSet
        GLOBAL_SET_BIT(2672939 + 2590 + 1 + i * 80 + 69, 1) -- BIG_MESSAGE_BIT_CLEANUP_ALL
    end
end

--------------------------------
-- Hacking Functions
--------------------------------

local HACKING_MINIGAME = {}

local HackingFunc = {
    FingerprintClone = function(script, sFingerprintCloneGameplay)
        if LOCAL_GET_INT(script, sFingerprintCloneGameplay) == 4 then -- HACKING_GAME_PLAY
            LOCAL_SET_INT(script, sFingerprintCloneGameplay, 5)       -- HACKING_GAME_PASS
        end
    end,
    OrderUnlock = function(script, sOrderUnlockGameplay)
        if LOCAL_GET_INT(script, sOrderUnlockGameplay) == 4 then -- HACKING_GAME_PLAY
            LOCAL_SET_INT(script, sOrderUnlockGameplay, 5)       -- HACKING_GAME_PASS
        end
    end,
    VaultDrill = function(script, sVaultDrillData)
        if LOCAL_GET_INT(script, sVaultDrillData.iCurrentState) == 5 then -- VAULT_DRILL_MINIGAME_STATE_DRILLING
            LOCAL_SET_BIT(script, sVaultDrillData.iBitset, 13)            -- VAULT_DRILL_BITSET_HAS_PLAYER_PASSED_MINIGAME
        end
    end,
    Hotwire = function(script, eHotwireState, hpsCurPassState)
        if LOCAL_GET_INT(script, eHotwireState) == 1 then -- HOTWIRE_PLAY
            LOCAL_SET_INT(script, hpsCurPassState, 3)     -- HPS_SUCCESS
            LOCAL_SET_INT(script, eHotwireState, 2)       -- HOTWIRE_PASS
        end
    end,
    BeamHack = function(script, sBeamHackGameplayData)
        if LOCAL_GET_INT(script, sBeamHackGameplayData.eBeamHackState) == 2 then -- BEAM_HACK_PLAY
            LOCAL_SET_INT(script, sBeamHackGameplayData.eBeamHackState, 3)       -- BEAM_HACK_PASS
        end
    end,
    CircuitHacking = function(script, e_CircuitHackingMinigameState)
        if LOCAL_GET_INT(script, e_CircuitHackingMinigameState) == 3 then -- CHMS_RUNNING
            LOCAL_SET_INT(script, e_CircuitHackingMinigameState, 7)       -- CHMS_SYSTEM_HACKED
        end
    end,
    Drill = function(script, sDrillData)
        if LOCAL_GET_INT(script, sDrillData.iCurrentState) == 1 then -- DRILL_MINIGAME_STATE_DRILLING
            LOCAL_SET_INT(script, sDrillData.iCurrentState, 2)       -- DRILL_MINIGAME_STATE_CLEANUP
        end
    end,
    Hacking = function(script, sHackingData)
        if LOCAL_BITS_TEST(script, sHackingData, 0, 29) then -- BS_IS_HACKING, BS_WALLPAPER_INITIALISED
            -- BS_BRUTE_FORCE_GAME_SOLVED, BS_HACK_CONNECT_GAME_SOLVED, BS_NEW_HACKING_GAME_SOLVED
            LOCAL_SET_BITS(script, sHackingData, 9, 18, 26)
        end
    end,
    SafeCrack = function(script, SafeCrackData)
        if LOCAL_BIT_TEST(script, SafeCrackData.iBitSet, 1) then    -- SC_BS_IS_PLAYER_SAFE_CRACKING
            LOCAL_SET_INT(script, SafeCrackData.iSafeCrackStage, 3) -- MAX_NUM_LOCKS
        end
    end,

    UnderwaterTunnelWeld = function(script, erUnderwaterTunnel_WeldStage)
        if LOCAL_GET_INT(script, erUnderwaterTunnel_WeldStage) == 4 then -- UNDERWATER_TUNNEL_WELD_STAGE__RUNNING
            LOCAL_SET_INT(script, erUnderwaterTunnel_WeldStage, 6)       -- UNDERWATER_TUNNEL_WELD_STAGE__PASSED
        end
    end,
    GlassCutting = function(script, sGlassCuttingData)
        if LOCAL_BITS_TEST(script, sGlassCuttingData.iBitset, 0, 2) then -- ciGLASS_CUTTING_BITSET__STARTED, ciGLASS_CUTTING_BITSET__STARTED_TIMECYCLE_MOD
            LOCAL_SET_FLOAT(script, sGlassCuttingData.fGlassCuttingProgress, 100)
        end
    end,
    SafeCombination = function(script, eEnterSafeCombinationStage, sEnterSafeCombinationData)
        if LOCAL_GET_INT(script, eEnterSafeCombinationStage) == 3 then -- ENTER_SAFE_COMBINATION_STAGE__RUNNING
            for iPanel = 0, 2, 1 do
                -- sEnterSafeCombinationData.sEnterSafePanels[iPanel].fCurrentSafeValue
                LOCAL_SET_FLOAT(script, sEnterSafeCombinationData.sEnterSafePanels + iPanel * 2, 0)
                -- sEnterSafeCombinationData.sEnterSafePanels[iPanel].iCorrectSafeValue
                LOCAL_SET_INT(script, sEnterSafeCombinationData.sEnterSafePanels + iPanel * 2 + 1, 0)
            end
            LOCAL_SET_INT(script, sEnterSafeCombinationData.iCurrentlySelectedDisplayPanel, 2)

            PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 237, 1) -- INPUT_CURSOR_ACCEPT
        end
    end,
    VoltageHack = function(script, sVoltage)
        if LOCAL_GET_INT(script, sVoltage.eCurrentState) == 3 then -- VS_PICK_LINK
            LOCAL_SET_INT(script, sVoltage.iTargetValue, 0)
            LOCAL_SET_INT(script, sVoltage.iCurrentValue, 0)
            LOCAL_SET_INT(script, sVoltage.iLinkCount, 3)

            PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 201, 1) -- INPUT_FRONTEND_ACCEPT
        end
    end
}

-- local iHackStage = 4543372
local g_sHackingData = 2738536

HACKING_MINIGAME["fm_mission_controller"] = function(script)
    local sFingerprintCloneGameplay = 53087
    local sOrderUnlockGameplay = 54153
    local sVaultDrillData = {
        iBitset = 10143,
        iCurrentState = 10143 + 2
    }

    local eHotwireState = 1566
    local hpsCurPassState = 1535

    local sBeamHackGameplayData = {
        eBeamHackState = 1292 + 135
    }
    local e_CircuitHackingMinigameState = 11812 + 24 -- hackingMinigameData.e_CircuitHackingMinigameState

    local sDrillData = {
        iCurrentState = 10103 + 2
    }
    local sHackingData = 9809

    local SafeCrackData = {
        iBitSet = 11183,
        iSafeCrackStage = 11183 + 5
    }

    -- Securo Hack Objective
    -- if GLOBAL_GET_INT(iHackStage) > 0 then
    --     -- MC_playerBD[iLocalPart].iVehFollowing
    --     local iVehFollowing = LOCAL_GET_INT(script, 31621 + 1 + NETWORK.PARTICIPANT_ID_TO_INT() * 292 + 125)
    --     if iVehFollowing ~= -1 then
    --         -- MC_serverBD_1.tdControlVehTimer[iVeh]
    --         LOCAL_SET_INT(script, 22960 + 1 + iVehFollowing * 2, 0)
    --     end
    -- end

    HackingFunc.FingerprintClone(script, sFingerprintCloneGameplay)
    HackingFunc.OrderUnlock(script, sOrderUnlockGameplay)
    HackingFunc.VaultDrill(script, sVaultDrillData)
    HackingFunc.Hotwire(script, eHotwireState, hpsCurPassState)
    HackingFunc.BeamHack(script, sBeamHackGameplayData)
    HackingFunc.CircuitHacking(script, e_CircuitHackingMinigameState)
    HackingFunc.Drill(script, sDrillData)
    HackingFunc.Hacking(script, sHackingData)
    HackingFunc.SafeCrack(script, SafeCrackData)
end

HACKING_MINIGAME["fm_mission_controller_2020"] = function(script)
    local sFingerprintCloneGameplay = 24986
    local erUnderwaterTunnel_WeldStage = 29810
    local sGlassCuttingData = {
        iBitset = 31049,
        fGlassCuttingProgress = 31049 + 3
    }

    local eEnterSafeCombinationStage = 31024
    local sEnterSafeCombinationData = {
        iCurrentlySelectedDisplayPanel = 31025,
        sEnterSafePanels = 31025 + 1 + 1, -- +[0~2]*2
    }

    local sVoltage = {
        iTargetValue = 1744,
        iCurrentValue = 1745,
        iLinkCount = 1746,
        eCurrentState = 1760,
    }

    local sBeamHackGameplayData = {
        eBeamHackState = 1001 + 135
    }


    -- if GLOBAL_GET_INT(iHackStage) > 0 then
    --     -- MC_playerBD[iLocalPart].iVehCapturing
    --     local iVehCapturing = LOCAL_GET_INT(script, 60496 + 1 + NETWORK.PARTICIPANT_ID_TO_INT() * 261 + 111)
    --     if iVehCapturing ~= -1 then
    --         -- MC_serverBD_1.iControlVehTimer[iVeh]
    --         LOCAL_SET_INT(script, 51882 + 224 + 1 + iVehCapturing, 0)
    --     end
    -- end


    HackingFunc.FingerprintClone(script, sFingerprintCloneGameplay)
    HackingFunc.UnderwaterTunnelWeld(script, erUnderwaterTunnel_WeldStage)
    HackingFunc.GlassCutting(script, sGlassCuttingData)
    HackingFunc.SafeCombination(script, eEnterSafeCombinationStage, sEnterSafeCombinationData)
    HackingFunc.VoltageHack(script, sVoltage)
    HackingFunc.BeamHack(script, sBeamHackGameplayData)
end

HACKING_MINIGAME["fm_content_stash_house"] = function(script)
    local sSafeData = {
        eSafeStage = 140 + 15,
        iCurrentlySelectedPanel = 140 + 20,
        sSafePanel = 140 + 22 + 1,
    }

    if LOCAL_GET_INT(script, sSafeData.eSafeStage) == 3 then -- eSAFE_COMBINATIONSTAGE_RUN
        for iPanel = 0, 2, 1 do
            -- sLocalVariables.sSafeData.sSafePanel[iPanel].fCurrentValue
            LOCAL_SET_FLOAT(script, sSafeData.sSafePanel + iPanel * 2, 0)
            -- sLocalVariables.sSafeData.sSafePanel[iPanel].iCorrectValue
            LOCAL_SET_INT(script, sSafeData.sSafePanel + iPanel * 2 + 1, 0)
        end
        LOCAL_SET_INT(script, sSafeData.iCurrentlySelectedPanel, 2)

        PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 237, 1) -- INPUT_CURSOR_ACCEPT
    end
end

HACKING_MINIGAME["fm_content_island_heist"] = function(script)
    local e_CircuitHackingMinigameState = 10162 + 24
    local sHackingData = 10162

    local sVoltage = {
        iTargetValue = 787,
        iCurrentValue = 788,
        iLinkCount = 789,
        eCurrentState = 803,
    }

    HackingFunc.CircuitHacking(script, e_CircuitHackingMinigameState)
    HackingFunc.Hacking(script, sHackingData)
    HackingFunc.VoltageHack(script, sVoltage)
end

function SKIP_HACKING_MINIGAME()
    local script_list = {
        "fm_mission_controller",
        "fm_mission_controller_2020",
        "fm_content_stash_house",
        "fm_content_island_heist"
    }
    for _, script_name in pairs(script_list) do
        if IS_SCRIPT_RUNNING(script_name) then
            HACKING_MINIGAME[script_name](script_name)
            return
        end
    end


    if GLOBAL_BIT_TEST(g_sHackingData, 0, 29) then -- BS_IS_HACKING, BS_WALLPAPER_INITIALISED
        -- BS_BRUTE_FORCE_GAME_SOLVED, BS_HACK_CONNECT_GAME_SOLVED, BS_NEW_HACKING_GAME_SOLVED
        GLOBAL_SET_BITS(g_sHackingData, 9, 18, 26)
    end
end
