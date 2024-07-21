-- Game Variables
-- 1.69-3258

--------------------------------
-- Globals
--------------------------------

Globals = {
    -- GlobalplayerBD[NATIVE_TO_INT(PLAYER_ID())]
    GlobalplayerBD = function()
        return 2657971 + 1 + players.user() * 465
    end,

    -- GlobalplayerBD_FM[NATIVE_TO_INT(PLAYER_ID())]
    GlobalplayerBD_FM = function()
        return 1845281 + 1 + players.user() * 883
    end,

    -- GlobalplayerBD_FM_2[NATIVE_TO_INT(PLAYER_ID())]
    GlobalplayerBD_FM_2 = function()
        return 1882632 + 1 + players.user() * 146
    end,

    -- GlobalplayerBD_FM_3[NATIVE_TO_INT(PLAYER_ID())]
    GlobalplayerBD_FM_3 = function()
        return 1887305 + 1 + players.user() * 610
    end,


    -- NET_HEIST_PLANNING_GENERIC_PLAYER_BD_DATA
    GlobalPlayerBD_NetHeistPlanningGeneric = function()
        return 1972760 + 1 + players.user() * 27
    end,


    -- MPGlobalsAmbienceStruct
    MPGlobalsAmbience = 2738934,


    bBrowserVisible = 76498,

    -- g_FMMC_ROCKSTAR_CREATED.sMissionHeaderVars[iArrayPos]
    sMissionHeaderVars = 794744 + 4 + 1,


    -- g_FMMC_STRUCT_ENTITIES.sPlacedZones[iZone].iZoneTimer_EnableTime
    CasinoVault_ZoneTimer_EnableTime = 4718592 + 210289 + 1 + 0 * 190 + 41,
}


-- GlobalPlayerBroadcastDataFM
GlobalplayerBD_FM = {}

-- PROPERTY_BROADCAST_DETAILS
GlobalplayerBD_FM.propertyDetails = {
    _ = 268, -- offset

    iCurrentlyInsideProperty = function()
        return Globals.GlobalplayerBD() + GlobalplayerBD_FM.propertyDetails._ + 35
    end
}


-- GlobalPlayerBroadcastDataFM_3
GlobalplayerBD_FM_3 = {
    _sMagnateGangBossData = function()
        -- GlobalplayerBD_FM_3[NATIVE_TO_INT(PLAYER_ID())].sMagnateGangBossData
        return Globals.GlobalplayerBD_FM_3() + 10
    end,
    _contrabandMissionData = function()
        -- GlobalplayerBD_FM_3[NATIVE_TO_INT(PLAYER_ID())].sMagnateGangBossData.contrabandMissionData
        return GlobalplayerBD_FM_3._sMagnateGangBossData() + 183
    end,
}

-- STRUCT_MAGNATE_GANG_BOSS_GLOBAL_PLAYER_BD
GlobalplayerBD_FM_3.sMagnateGangBossData = {
    iMissionToLaunch = function()
        return GlobalplayerBD_FM_3._sMagnateGangBossData() + 32
    end,
    iNumGoonsInGang = function()
        return GlobalplayerBD_FM_3._sMagnateGangBossData() + 19
    end,
}

-- CONTRABAND_MISSION_DATA
GlobalplayerBD_FM_3.sMagnateGangBossData.contrabandMissionData = {
    contrabandSize = function()
        return GlobalplayerBD_FM_3._contrabandMissionData() + 1
    end,
    bSpecialItem = function()
        return GlobalplayerBD_FM_3._contrabandMissionData() + 3
    end,
}



-- MPGlobalsAmbienceStruct
MPGlobalsAmbience = {
    -- MAGNATE_GANG_BOSS_LOCAL_GLOBALS
    sMagnateGangBossData = {
        iMissionVariation = Globals.MPGlobalsAmbience + 5249 + 347,
    },
}



-- CONTACT_REQUEST_GB_MISSION_LAUNCH_STRUCT
local _g_sContactRequestGBMissionLaunch = 1979230
g_sContactRequestGBMissionLaunch = {
    iType = _g_sContactRequestGBMissionLaunch,
    iVariation = _g_sContactRequestGBMissionLaunch + 1,
    iSubvariation = _g_sContactRequestGBMissionLaunch + 2,
    iDelay = _g_sContactRequestGBMissionLaunch + 3,
    iBitSet = _g_sContactRequestGBMissionLaunch + 4,
    Timer = _g_sContactRequestGBMissionLaunch + 5
}

-- PAYPHONE_FLOW_GLOBAL_STRUCT
local _g_PayphoneFlow = 2709088
g_PayphoneFlow = {
    iBitset = _g_PayphoneFlow + 1,
}

-- FIXER_FLOW_DATA
local _g_sFixerFlow = 1975462
g_sFixerFlow = {
    -- FIXER_SECURITY_CONTRACT_DATA
    SecurityContracts = _g_sFixerFlow + 20
}


-- FMMC_GLOBAL_STRUCT
g_FMMC_STRUCT = 4718592
FMMC_STRUCT = {
    iNumParticipants = g_FMMC_STRUCT + 3522,
    iMinNumParticipants = g_FMMC_STRUCT + 3523,

    iDifficulity = g_FMMC_STRUCT + 3525,
    iNumberOfTeams = g_FMMC_STRUCT + 3526,
    iMaxNumberOfTeams = g_FMMC_STRUCT + 3527,
    iNumPlayersPerTeam = g_FMMC_STRUCT + 3529 + 1, -- +[0~3]

    iRootContentIDHash = g_FMMC_STRUCT + 127178,
    tl63MissionName = g_FMMC_STRUCT + 127185,
    tl31LoadedContentID = g_FMMC_STRUCT + 127465,
    tl23NextContentID = g_FMMC_STRUCT + 127493 + 1, -- +[0~5]*6

    iFixedCamera = g_FMMC_STRUCT + 155346,
    iCriticalMinimumForTeam = g_FMMC_STRUCT + 178821 + 1 -- +[0~3]
}

-- TRANSITION_SESSION_NON_RESET_VARS
local _g_TransitionSessionNonResetVars = 2685444
g_TransitionSessionNonResetVars = {
    bAmIHeistLeader = _g_TransitionSessionNonResetVars + 6381,
    bHasQuickRestartedDuringStrandMission = _g_TransitionSessionNonResetVars + 6487,
    bAnyPlayerDiedDuringMission = _g_TransitionSessionNonResetVars + 6488
}

-- FMMC_STRAND_MISSION_DATA
g_sTransitionSessionData = 2684504
sStrandMissionData = g_sTransitionSessionData + 43
StrandMissionData = {
    bPassedFirstMission = sStrandMissionData + 55,
    bPassedFirstStrandNoReset = sStrandMissionData + 56,
    bIsThisAStrandMission = sStrandMissionData + 57,
    bLastMission = sStrandMissionData + 58
}



-- HEIST_CLIENT_PRE_PLANNING_LOCAL_DATA
local _g_HeistPrePlanningClient = 1928993
g_HeistPrePlanningClient = {
    eHeistFlowState = _g_HeistPrePlanningClient,
    iCurrentBoardDepth = _g_HeistPrePlanningClient + 1708
}

-- HEIST_CLIENT_PLANNING_LOCAL_DATA
local _g_HeistPlanningClient = 1930926
g_HeistPlanningClient = {
    bHeistCoronaActive = _g_HeistPlanningClient + 2816
}


-- CASINO_HEIST_MISSION_CONFIGURATION_DATA
local _g_sCasinoHeistMissionConfigData = 1964815
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
        -- GlobalPlayerBD_HeistIsland[NATIVE_TO_INT(sData.piLeader)].sConfig
        return 1973625 + 1 + players.user() * 53 + 5
    end
}

-- NET_HEIST_PLANNING_GENERIC_PLAYER_BD_DATA
GlobalPlayerBD_NetHeistPlanningGeneric = {
    stFinaleLaunchTimer = function()
        return Globals.GlobalPlayerBD_NetHeistPlanningGeneric() + 18
    end
}



-- WAREHOUSE_CARGO_SOURCING_DATA_STRUCT
local _g_sWarehouseCargoSourcingData = 1882599
g_sWarehouseCargoSourcingData = {
    bRequestDeliverCargo = _g_sWarehouseCargoSourcingData + 4 + 1, -- +[0~4]
    iNumCargo = _g_sWarehouseCargoSourcingData + 12,
    iSpecialCargoType = _g_sWarehouseCargoSourcingData + 13,
    iNumSpecialCargo = _g_sWarehouseCargoSourcingData + 14,
    eType = _g_sWarehouseCargoSourcingData + 15
}

local _g_sHangarCargoSourcingData = 1882623
g_sHangarCargoSourcingData = {
    iNum = _g_sHangarCargoSourcingData + 6,
    eType = _g_sHangarCargoSourcingData + 7
}

g_sHangarCargoSourcingDataBitset = function()
    return Globals.GlobalplayerBD() + 202
end


-- MP_SAVED_TUNER_CLIENT_VEHICLE_STRUCT
g_sClientVehicleSetupStruct = 2709424
-- MP_SAVED_TUNER_CLIENT_VEHICLE_STRUCT
g_sBikerClientVehicleSetupStruct = 2710310

g_iFactoryPaidResupplyTimers = 1663174

-- BUSINESS_APP_MANAGEMENT_DATA
local _g_sBusAppManagement = 1963007
g_sBusAppManagement = {
    iPropertyID = _g_sBusAppManagement,
    bRunningPrimaryApp = _g_sBusAppManagement + 1,
    bSecuroSpecCargo = _g_sBusAppManagement + 2
}


--------------------------------
-- Locals
--------------------------------

Locals = {
    -------- Business Mission --------

    ["gb_contraband_buy"] = {
        -- iServerBitSet1 = 601 + 186,
        -- iLocalBitset5 = 476,
        eEndReason = 603 + 192,
        eModeState = 603 + 191,
        contrabandSize = 603 + 1, -- serverBD.sContraband.sContrabandMissionData.contrabandSize
        eType = 603 + 5           -- serverBD.sContraband.eType
    },
    ["gb_contraband_sell"] = {
        eSellVar = 545 + 7,
        eEndReason = 545 + 6,
        eModeState = 545 + 5
    },
    ["gb_gunrunning"] = {
        iGunrunEntityBitSet = 1211 + 4 + 63,
        eEndReason = 1211 + 582,
        eModeState = 1211 + 581,
        eMissionVariation = 1211 + 1,
        iNumEntitiesThisVariation = 1211 + 774,
        iTotalDeliveredCount = 1211 + 816
    },
    ["gb_smuggler"] = {
        iSmugglerEntityBitSet = 1934 + 6 + 63,
        eEndReason = 1934 + 771,
        eModeState = 1934 + 770,
        eMissionVariation = 1934 + 2,
        iNumEntitiesThisVariation = 1934 + 1035,
        iTotalDeliveredCount = 1934 + 1078
    },
    ["fm_content_acid_lab_source"] = {
        iGenericBitset = 7577,
        eEndReason = 7654 + 1162
    },
    ["fm_content_acid_lab_sell"] = {
        iGenericBitset = 5418,
        eEndReason = 5483 + 1294,
        iDropOffCount = 119 + 9 + 1,
        iTotalDropoffs = 119 + 9
    },
    ["business_battles_sell"] = {
        eEndReason = 2312 + 26,
        eModeState = 2312 + 25,
        sMissionEntity = 2312 + 32,
        iTotalDeliveredCount = 2312 + 202,
        iTotalDeliveriesToMake = 2312 + 203
    },
    ["fm_content_club_source"] = {
        eGoodsType = 3540 + 720 + 3,
        iLocalParticipantIndexAsInt = 3453,
        iGoodsToTransfer = function(iLocalParticipantIndexAsInt)
            return 4299 + 1 + iLocalParticipantIndexAsInt * 125 + 73
        end,
        iGenericBitset = 3467,
        eEndReason = 3540 + 674
    },
    ["gb_illicit_goods_resupply"] = {
        iIllicitGoodBitset0 = 937 + 796,
        eEndReason = 937 + 506,
        eModeState = 937 + 505
    },
    ["gb_biker_contraband_sell"] = {
        eSellVar = 704 + 17,
        iVehicleCountDeliveredAllContraband = 704 + 978,
        iDroppedOffCount = 704 + 122,
        eEndReason = 704 + 15,
        eModeState = 704 + 14
    },
    ["gb_vehicle_export"] = {
        iExportEntityNetId = 836 + 29,
        exportEntityIeVehicleEnum = 836 + 39,
        eModeState = 836 + 459,
        sCarBombStruct = {
            iCarBombBitSet = 369 + 1
        },
    },

    -------- Freemode Mission --------

    ["fm_content_security_contract"] = {
        iGenericBitset = 7058,
        eEndReason = 7136 + 1278
    },
    ["fm_content_payphone_hit"] = {
        iGenericBitset = 5616,
        eEndReason = 5675 + 683,
        iMissionServerBitSet = 5675 + 740
    },

    -- Client Work
    ["gb_bank_job"] = {
        iMissionEntityBitSet = 1227 + 7 + 1 + 0 * 4 + 1 + 1 + 0, -- iMissionEntity = 0
        eModeState = 1227 + 5,
        eEndReason = 1227 + 6
    },
    ["gb_data_hack"] = {
        eEndReason = 1927 + 7
    },

    ["fm_content_drug_lab_work"] = {
        iGenericBitset = 7820,
        eEndReason = 7884 + 1253
    },
    ["fm_content_stash_house"] = {
        iGenericBitset = 3467,
        eEndReason = 3521 + 475
    },
    ["fm_content_auto_shop_delivery"] = {
        iGenericBitset = 1518,
        eEndReason = 1572 + 83,
        iMissionEntityBitSet = 1572 + 2 + 5
    },
    ["fm_content_bike_shop_delivery"] = {
        iGenericBitset = 1518,
        eEndReason = 1574 + 83,
        iMissionEntityBitSet = 1574 + 2 + 5
    },

    ["fm_content_island_heist"] = {
        iGenericBitset = 13220,
        eEndReason = 13311 + 1339
    },
    ["fm_content_tuner_robbery"] = {
        iGenericBitset = 7226,
        eEndReason = 7313 + 1194
    },
    ["fm_content_vip_contract_1"] = {
        iGenericBitset = 8619,
        eEndReason = 8692 + 1157
    },
    ["gb_gangops"] = {
        iPhotosTaken = 1963 + 1194,
        iNumEntitiesThisVariation = 1963 + 1040,
        iMissionEntityBitSet = 1963 + 6 + 63,
        eEndReason = 1963 + 782,
        eModeState = 1963 + 781
    },

    -------- Heist Planning Board --------

    ["gb_casino_heist_planning"] = {
        iScriptStage = 185,
    },
    ["gb_gang_ops_planning"] = {
        iScriptStage = 184,
    },
    ["heist_island_planning"] = {
        iScriptStage = 1546,
    },
    ["tuner_planning"] = {
        iScriptStage = 383,
    },
    ["vehrob_planning"] = {
        iScriptStage = 512,
    },

    -------- Heist Mission --------

    ["fm_mission_controller"] = {
        iNextMission = 19746 + 1062,
        iTeamScore = 19746 + 1232 + 1, -- +[0~3]

        iServerGameState = 19746,
        iServerBitSet = 19746 + 1,
        iServerBitSet1 = 19746 + 2,

        iCashGrabTotalTake = 19746 + 2686,
        iTeamKills = 19746 + 1725 + 1,
        iTeamHeadshots = 19746 + 1740 + 1,

        iClientBitSet = function()
            -- MC_playerBD[PARTICIPANT_ID_TO_INT()].iClientBitSet
            return 31621 + 1 + NETWORK.PARTICIPANT_ID_TO_INT() * 292 + 127
        end,

        iLocalBoolCheck11 = 15166,

        iAdditionalTeamLives = 26172 + 1325 + 1,      -- +[0~3]

        tdObjectiveLimitTimer = 26172 + 740 + 1,      -- +[0~3]*2
        tdMultiObjectiveLimitTimer = 26172 + 749 + 1, -- +[0~3]*2
        iMultiObjectiveTimeLimit = 26172 + 765 + 1,   -- +[0~3]

        stZoneTimers = 59899 + 1 + 0 * 2,             -- casino vault
    },
    ["fm_mission_controller_2020"] = {
        iNextMission = 50150 + 1583,
        iTeamScore = 50150 + 1770 + 1, -- +[0~3]

        iServerGameState = 50150,
        iServerBitSet = 50150 + 1,
        iServerBitSet1 = 50150 + 2,

        iLocalBoolCheck11 = 48799,

        iAdditionalTeamLives = 56798 + 868 + 1,       -- +[0~3]

        tdObjectiveLimitTimer = 56798 + 297 + 1,      -- +[0~3]*2
        tdMultiObjectiveLimitTimer = 56798 + 306 + 1, -- +[0~3]*2
        iMultiObjectiveTimeLimit = 56798 + 322 + 1,   -- +[0~3]
    },

    -------- Other --------

    ["carmod_shop"] = {
        iPersonalCarModShopFlags = 1585
    },
    ["shop_controller"] = {
        iLocalBS = 332,

        iAutoShopRandomTime = 333,
        iBikerShopRandomTime = 347
    },
    ["social_controller"] = {
        eMaintainStage = 65,
    },
}

-- `fmmc_launcher`
-- MISSION_TO_LAUNCH_DETAILS
local _sLaunchMissionDetails = 19709
sLaunchMissionDetails = {
    iMinPlayers = _sLaunchMissionDetails + 15,
    iMissionVariation = _sLaunchMissionDetails + 34
}

-- `freemode` Time Trial
-- AMTT_VARS_STRUCT
local _sTTVarsStruct = 14386
sTTVarsStruct = {
    iVariation = _sTTVarsStruct + 11,
    trialTimer = _sTTVarsStruct + 13,
    iPersonalBest = _sTTVarsStruct + 25,
    eAMTT_Stage = _sTTVarsStruct + 29
}

-- `freemode` RC Bandito Time Trial
-- AMRCTT_VARS_STRUCT
local _sRCTTVarsStruct = 14436
sRCTTVarsStruct = {
    eVariation = _sRCTTVarsStruct,
    eRunStage = _sRCTTVarsStruct + 2,
    timerTrial = _sRCTTVarsStruct + 6,
    iPersonalBest = _sRCTTVarsStruct + 21
}





--------------------------------
-- Functions
--------------------------------

local g_sCURRENT_UGC_STATUS = 2693440
local g_iMissionEnteryType = 1057440

function LAUNCH_MISSION(Data)
    local iArrayPos = MISC.GET_CONTENT_ID_INDEX(Data.iRootContentID)

    -- g_FMMC_ROCKSTAR_CREATED.sMissionHeaderVars[iArrayPos].tlName
    local tlName = GLOBAL_GET_STRING(Globals.sMissionHeaderVars + iArrayPos * 89)
    -- g_FMMC_ROCKSTAR_CREATED.sMissionHeaderVars[iArrayPos].iMaxPlayers
    local iMaxPlayers = GLOBAL_GET_INT(Globals.sMissionHeaderVars + iArrayPos * 89 + 71)

    -- g_TransitionSessionNonResetVars.bSaveBeforeCoronaVehicle = TRUE
    GLOBAL_SET_INT(_g_TransitionSessionNonResetVars + 3850, 1)

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

    -- CLEAR_TRANSITION_SESSIONS_NEED_TO_WARP_TO_START_SKYCAM()
    ---- CLEAR_BIT(g_sTransitionSessionData.iBitSet, ciTRANSITION_SESSIONS_NEED_TO_WARP_TO_START_SKYCAM)
    GLOBAL_CLEAR_BIT(g_sTransitionSessionData, 7)

    -- CLEAR_TRANSITION_SESSIONS_CORONA_CONTROLLER_MAINTAIN_CAMERA()
    ---- CLEAR_BIT(g_sTransitionSessionData.iBitSet, ciTRANSITION_SESSIONS_CORONA_CONTROLLER_MAINTAIN_CAMERA)
    GLOBAL_CLEAR_BIT(g_sTransitionSessionData, 15)

    -- SET_TRANSITION_SESSIONS_FORCE_ME_HOST_QUICK_MATCH()
    ---- g_sTransitionSessionData.bForceMeHost = TRUE
    GLOBAL_SET_INT(g_sTransitionSessionData + 719, 1)


    -- GlobalplayerBD_FM[NATIVE_TO_INT(PLAYER_ID())].iFmLauncherGameState = FMMC_LAUNCHER_STATE_LOAD_MISSION_FOR_TRANSITION_SESSION
    GLOBAL_SET_INT(Globals.GlobalplayerBD_FM() + 96, 8)
end

-- g_structLocalHeistControl
local g_sLocalMPHeistControl = {
    _ = 2635126,
    _lhcMyCorona = 2635126 + 3,
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
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local serverBD = 4413

    local eMissionVariation = LOCAL_GET_INT(script, serverBD + 1457)
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

function COMPLETE_DAILY_CHALLENGE()
    -- g_savedMPGlobalsNew.g_savedMPGlobals[GET_SAVE_GAME_ARRAY_SLOT()].MpSavedGeneral.Current_Daily_Objectives[i].bCompleted
    for i = 0, 2, 1 do
        GLOBAL_SET_INT(2359296 + 1 + 0 * 5569 + 681 + 4244 + 1 + i * 3 + 1, 1)
    end
end

function COMPLETE_WEEKLY_CHALLENGE(bComplete)
    local g_sWeeklyChallenge = 2737992

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
        GLOBAL_SET_INT(2672855 + 2557 + 1 + i * 80 + 2, 5) -- BIG_MESSAGE_STATE_CLEANUP

        -- MPGlobals.g_BigMessage[i].iBigMessageBitSet
        GLOBAL_SET_BIT(2672855 + 2557 + 1 + i * 80 + 69, 1) -- BIG_MESSAGE_BIT_CLEANUP_ALL
    end
end

--------------------------------
-- Hacking Functions
--------------------------------

local HACKING_MINIGAME = {}

local iHackStage = 4543372

HACKING_MINIGAME.MISSION_CONTROLLER = function(script)
    local sFingerprintCloneGameplay = 53019
    local sOrderUnlockGameplay = 54085
    local sVaultDrillData = {
        iBitset = 10109,
        iCurrentState = 10109 + 2
    }

    local eHotwireState = 1545
    local hpsCurPassState = 1514

    local sBeamHackGameplayData = {
        eBeamHackState = 1271 + 135
    }
    local e_CircuitHackingMinigameState = 11778 + 24 -- hackingMinigameData.e_CircuitHackingMinigameState

    local sDrillData = {
        iCurrentState = 10069 + 2
    }
    local sHackingData = 9775

    local SafeCrackData = {
        iBitSet = 11149,
        iSafeCrackStage = 11149 + 5
    }

    -- Securo Hack Objective
    if GLOBAL_GET_INT(iHackStage) > 0 then
        -- MC_playerBD[iLocalPart].iVehFollowing
        local iVehFollowing = LOCAL_GET_INT(script, 31621 + 1 + NETWORK.PARTICIPANT_ID_TO_INT() * 292 + 125)
        if iVehFollowing ~= -1 then
            -- MC_serverBD_1.tdControlVehTimer[iVeh]
            LOCAL_SET_INT(script, 22960 + 1 + iVehFollowing * 2, 0)
        end
    end


    if LOCAL_GET_INT(script, sFingerprintCloneGameplay) == 4 then -- HACKING_GAME_PLAY
        LOCAL_SET_INT(script, sFingerprintCloneGameplay, 5)       -- HACKING_GAME_PASS
    end

    if LOCAL_GET_INT(script, sOrderUnlockGameplay) == 4 then -- HACKING_GAME_PLAY
        LOCAL_SET_INT(script, sOrderUnlockGameplay, 5)       -- HACKING_GAME_PASS
    end

    if LOCAL_GET_INT(script, sVaultDrillData.iCurrentState) == 5 then -- VAULT_DRILL_MINIGAME_STATE_DRILLING
        LOCAL_SET_BIT(script, sVaultDrillData.iBitset, 13)            -- VAULT_DRILL_BITSET_HAS_PLAYER_PASSED_MINIGAME
    end

    if LOCAL_GET_INT(script, eHotwireState) == 1 then -- HOTWIRE_PLAY
        LOCAL_SET_INT(script, hpsCurPassState, 3)     -- HPS_SUCCESS
        LOCAL_SET_INT(script, eHotwireState, 2)       -- HOTWIRE_PASS
    end

    if LOCAL_GET_INT(script, sBeamHackGameplayData.eBeamHackState) == 2 then -- BEAM_HACK_PLAY
        LOCAL_SET_INT(script, sBeamHackGameplayData.eBeamHackState, 3)       -- BEAM_HACK_PASS
    end

    if LOCAL_GET_INT(script, e_CircuitHackingMinigameState) == 3 then -- CHMS_RUNNING
        LOCAL_SET_INT(script, e_CircuitHackingMinigameState, 7)       -- CHMS_SYSTEM_HACKED
    end

    if LOCAL_GET_INT(script, sDrillData.iCurrentState) == 1 then -- DRILL_MINIGAME_STATE_DRILLING
        LOCAL_SET_INT(script, sDrillData.iCurrentState, 2)       -- DRILL_MINIGAME_STATE_CLEANUP
    end

    if LOCAL_BITS_TEST(script, sHackingData, 0, 29) then -- BS_IS_HACKING, BS_WALLPAPER_INITIALISED
        -- BS_BRUTE_FORCE_GAME_SOLVED, BS_HACK_CONNECT_GAME_SOLVED
        LOCAL_SET_BITS(script, sHackingData, 9, 18)
    end

    if LOCAL_BIT_TEST(script, SafeCrackData.iBitSet, 1) then    -- SC_BS_IS_PLAYER_SAFE_CRACKING
        LOCAL_SET_INT(script, SafeCrackData.iSafeCrackStage, 3) -- MAX_NUM_LOCKS
    end
end

HACKING_MINIGAME.MISSION_CONTROLLER_2020 = function(script)
    local sFingerprintCloneGameplay = 24880
    local erUnderwaterTunnel_WeldStage = 29700
    local sGlassCuttingData = {
        iBitset = 30939,
        fGlassCuttingProgress = 30939 + 3
    }

    local eEnterSafeCombinationStage = 30914
    local sEnterSafeCombinationData = {
        iCurrentlySelectedDisplayPanel = 30915,
        sEnterSafePanels = 30915 + 1 + 1, -- +[0~2]*2
    }

    local Voltage = {
        iTargetValue = 1723,
        iCurrentValue = 1724,
        iLinkCount = 1725,
        eCurrentState = 1739,
    }

    local sBeamHackGameplayData = {
        eBeamHackState = 980 + 135
    }


    if LOCAL_GET_INT(script, sFingerprintCloneGameplay) == 4 then -- HACKING_GAME_PLAY
        LOCAL_SET_INT(script, sFingerprintCloneGameplay, 5)       -- HACKING_GAME_PASS
    end

    if LOCAL_GET_INT(script, erUnderwaterTunnel_WeldStage) == 4 then -- UNDERWATER_TUNNEL_WELD_STAGE__RUNNING
        LOCAL_SET_INT(script, erUnderwaterTunnel_WeldStage, 6)       -- UNDERWATER_TUNNEL_WELD_STAGE__PASSED
    end

    if LOCAL_BITS_TEST(script, sGlassCuttingData.iBitset, 0, 2) then -- ciGLASS_CUTTING_BITSET__STARTED, ciGLASS_CUTTING_BITSET__STARTED_TIMECYCLE_MOD
        LOCAL_SET_FLOAT(script, sGlassCuttingData.fGlassCuttingProgress, 100)
    end

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

    if LOCAL_GET_INT(script, Voltage.eCurrentState) == 3 then -- VS_PICK_LINK
        LOCAL_SET_INT(script, Voltage.iTargetValue, 0)
        LOCAL_SET_INT(script, Voltage.iCurrentValue, 0)
        LOCAL_SET_INT(script, Voltage.iLinkCount, 3)

        PAD.SET_CONTROL_VALUE_NEXT_FRAME(2, 201, 1) -- INPUT_FRONTEND_ACCEPT
    end

    if LOCAL_GET_INT(script, sBeamHackGameplayData.eBeamHackState) == 2 then -- BEAM_HACK_PLAY
        LOCAL_SET_INT(script, sBeamHackGameplayData.eBeamHackState, 3)       -- BEAM_HACK_PASS
    end

    if GLOBAL_GET_INT(iHackStage) > 0 then
        -- MC_playerBD[iLocalPart].iVehCapturing
        local iVehCapturing = LOCAL_GET_INT(script, 60496 + 1 + NETWORK.PARTICIPANT_ID_TO_INT() * 261 + 111)
        if iVehCapturing ~= -1 then
            -- MC_serverBD_1.iControlVehTimer[iVeh]
            LOCAL_SET_INT(script, 51882 + 224 + 1 + iVehCapturing, 0)
        end
    end
end

HACKING_MINIGAME["fm_content_stash_house"] = function(script)
    local sSafeData = {
        eSafeStage = 119 + 15,
        iCurrentlySelectedPanel = 119 + 20,
        sSafePanel = 119 + 22 + 1,
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

function SKIP_HACKING_MINIGAME()
    local script = "fm_mission_controller"
    if IS_SCRIPT_RUNNING(script) then
        HACKING_MINIGAME.MISSION_CONTROLLER(script)
        return
    end

    script = "fm_mission_controller_2020"
    if IS_SCRIPT_RUNNING(script) then
        HACKING_MINIGAME.MISSION_CONTROLLER_2020(script)
        return
    end

    local script_list = {
        "fm_content_stash_house",
    }
    for _, script_name in pairs(script_list) do
        HACKING_MINIGAME[script_name](script_name)
        return
    end
end
