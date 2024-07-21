----------------------------------------------------------------
-- Author: Rostal
-- Github: https://github.com/TCRoid/Stand-Lua-RS-Missions
----------------------------------------------------------------

if not util.is_session_started() or util.is_session_transition_active() then
    util.toast("[RS Missions.夜幕提示] 此脚本仅在线上模式可用")
end

local SCRIPT_VERSION <const> = "2024/7/9"

local SUPPORT_GAME_VERSION <const> = "1.69-3258"

local DEBUG <const> = true


--#region Consts

HIGHEST_INT = 2147483647
LOWEST_INT = -2147483647

-- MISSION DIFFICULTY
DIFF_EASY = 0
DIFF_NORMAL = 1
DIFF_HARD = 2

-- STACK SIZE
DEFAULT_STACK_SIZE = 1424
APP_INTERNET_STACK_SIZE = 4592

--#endregion

require "YMS.RS_Missions.functions"
require "YMS.RS_Missions.tables"
require "YMS.RS_Missions.variables"
require "YMS.RS_Missions.tunables"



------------------------
-- Functions
------------------------

--- Instant Finish Mission `fm_content_xxx`
--- @param script string
--- @param iGenericBitset integer
--- @param eEndReason integer
function INSTANT_FINISH_FM_CONTENT_MISSION(script)
    LOCAL_SET_BIT(script, Locals[script].iGenericBitset + 1 + 0, 11) -- SET_GENERIC_BIT(eGENERICBITSET_I_WON)
    LOCAL_SET_INT(script, Locals[script].eEndReason, 3)              -- SET_END_REASON(eENDREASON_MISSION_PASSED)
end

--- Instant Finish `fm_mission_controller` and `fm_mission_controller_2020`
function INSTANT_FINISH_FM_MISSION_CONTROLLER()
    local script = GET_RUNNING_MISSION_CONTROLLER_SCRIPT()
    if script == nil then
        return
    end

    util.request_script_host(script)

    -- String Null, get out
    for i = 0, 5 do
        local tl23NextContentID = GLOBAL_GET_STRING(FMMC_STRUCT.tl23NextContentID + i * 6)
        if tl23NextContentID ~= "" then
            GLOBAL_SET_STRING(FMMC_STRUCT.tl23NextContentID + i * 6, "")
        end
    end
    -- (not) More than max (FMMC_MAX_STRAND_MISSIONS), get out
    -- LOCAL_SET_INT(script, Locals[script].iNextMission, 5)

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

    -- SSBOOL_TEAMx_FINISHED, SBBOOL_MISSION_OVER
    LOCAL_SET_BITS(script, Locals[script].iServerBitSet, 9, 10, 11, 12, 16)
end

--- Start Mission (By Script Event)
--- @param iMission integer
--- @param iVariation integer?
--- @param iSubVariation integer?
function GB_BOSS_REQUEST_MISSION_LAUNCH_FROM_SERVER(iMission, iVariation, iSubVariation)
    ------------------------------------------------------
    ---- GB_SET_PLAYER_LAUNCHING_GANG_BOSS_MISSION
    ------------------------------------------------------

    -- GlobalplayerBD_FM_3[NATIVE_TO_INT(PLAYER_ID())].sMagnateGangBossData.iMissionToLaunch = iMission
    GLOBAL_SET_INT(GlobalplayerBD_FM_3.sMagnateGangBossData.iMissionToLaunch(), iMission)

    --------------------------------------------------
    ---- BROADCAST_GB_BOSS_WORK_REQUEST_SERVER
    --------------------------------------------------

    -- Type = SCRIPT_EVENT_GB_BOSS_WORK_REQUEST_SERVER
    -- FromPlayerIndex
    -- iMission
    -- iRequestedVariation
    -- iRequestedVariation2
    -- iRequestedVariation3
    -- iWarehouse

    util.trigger_script_event(1 << players.user(), {
        1613825825, players.user(), iMission, iVariation or -1, iSubVariation or -1, -1, -1, -1
    })
end

--- Start Mission (By Globals)
--- @param iMission integer
--- @param iVariation integer?
--- @param iSubVariation integer?
function SET_CONTACT_REQUEST_GB_MISSION_LAUNCH_DATA(iMission, iVariation, iSubVariation)
    GLOBAL_SET_INT(g_sContactRequestGBMissionLaunch.iType, iMission)
    GLOBAL_SET_INT(g_sContactRequestGBMissionLaunch.iVariation, iVariation or -1)
    GLOBAL_SET_INT(g_sContactRequestGBMissionLaunch.iSubvariation, iSubVariation or -1)
    GLOBAL_SET_INT(g_sContactRequestGBMissionLaunch.iDelay, 0)
    GLOBAL_SET_INT(g_sContactRequestGBMissionLaunch.Timer, NETWORK.GET_NETWORK_TIME())
end

--- @param iVariation integer
--- @param iSubvariation integer?
--- @param iLocation integer?
function GB_SET_PLAYER_GANG_BOSS_MISSION_VARIATION(iVariation, iSubvariation, iLocation)
    GLOBAL_SET_INT(MPGlobalsAmbience.sMagnateGangBossData.iMissionVariation, iVariation)

    if iSubvariation ~= nil then
        GLOBAL_SET_INT(MPGlobalsAmbience.sMagnateGangBossData.iMissionVariation + 1, iSubvariation)
    end
    if iLocation ~= nil then
        GLOBAL_SET_INT(MPGlobalsAmbience.sMagnateGangBossData.iMissionVariation + 2, iLocation)
    end
end

START_APP = {
    TERRORBYTE = function()
        -- GLOBAL_SET_BOOL(Globals.bBrowserVisible, true)
        START_SCRIPT("appHackerTruck", APP_INTERNET_STACK_SIZE)
    end,
    BUNKER = function()
        -- GLOBAL_SET_BOOL(Globals.bBrowserVisible, true)
        GLOBAL_SET_INT(g_sBusAppManagement.iPropertyID, GET_FACTORY_PROPERTY_ID(5))
        START_SCRIPT("appBunkerBusiness", DEFAULT_STACK_SIZE)
    end,
    HANGAR = function()
        -- GLOBAL_SET_BOOL(Globals.bBrowserVisible, true)
        GLOBAL_SET_INT(g_sBusAppManagement.iPropertyID, GET_HANGAR_PROPERTY_ID())
        START_SCRIPT("appSmuggler", APP_INTERNET_STACK_SIZE)
    end,
    NIGHTCLUB = function()
        -- GLOBAL_SET_BOOL(Globals.bBrowserVisible, true)
        GLOBAL_SET_INT(g_sBusAppManagement.iPropertyID, GET_NIGHTCLUB_PROPERTY_ID())
        START_SCRIPT("appBusinessHub", DEFAULT_STACK_SIZE)
    end,
    MASTER_CONTROL = function()
        -- GLOBAL_SET_BOOL(Globals.bBrowserVisible, true)
        START_SCRIPT("appArcadeBusinessHub", DEFAULT_STACK_SIZE)
    end,
    WAREHOUSE = function(iWarehouse)
        -- GLOBAL_SET_BOOL(Globals.bBrowserVisible, true)
        GLOBAL_SET_INT(g_sBusAppManagement.iPropertyID, iWarehouse)
        GLOBAL_SET_BOOL(g_sBusAppManagement.bRunningPrimaryApp, false)
        START_SCRIPT("appSecuroServ", APP_INTERNET_STACK_SIZE)
    end,
    IMPORT_EXPORT = function()
        -- GLOBAL_SET_BOOL(Globals.bBrowserVisible, true)
        GLOBAL_SET_INT(g_sBusAppManagement.iPropertyID, GET_IMPORT_EXPORT_GARAGE_PROPERTY_ID())
        START_SCRIPT("appImportExport", APP_INTERNET_STACK_SIZE)
    end,
    BIKER_FACTORY = function(eFactoryID)
        -- GLOBAL_SET_BOOL(Globals.bBrowserVisible, true)
        local iPropertyID = 0
        for i = 0, 4 do
            local tempFactoryID = GET_FACTORY_PROPERTY_ID(i)
            if Tables.BikerFactoryType[tempFactoryID] == eFactoryID then
                iPropertyID = tempFactoryID
            end
        end
        GLOBAL_SET_INT(g_sBusAppManagement.iPropertyID, iPropertyID)
        START_SCRIPT("appBikerBusiness", APP_INTERNET_STACK_SIZE)
    end
}



function draw_text(text)
    directx.draw_text(0.5, 0.0, text, ALIGN_TOP_LEFT, 0.6, { r = 1, g = 0, b = 1, a = 1 })
end

function toast(text)
    util.toast(text, TOAST_ALL)
end

----------------------------------------------------------
--                   MENU START
----------------------------------------------------------

local Menu_Root <const> = YMRS

menu.divider(Menu_Root, "夜幕-RS Missions")

-- Check Game Version
local CURRENT_GAME_VERSION <const> = menu.get_version().game
if SUPPORT_GAME_VERSION ~= CURRENT_GAME_VERSION then
    local state_text = string.format(
        "支持的游戏版本: %s\n当前游戏版本: %s\n不支持当前游戏版本, 建议停止使用!",
        SUPPORT_GAME_VERSION, CURRENT_GAME_VERSION)
    util.toast(state_text)

    menu.action(Menu_Root, "不支持当前游戏版本, 建议停止使用!", {}, state_text, function()
        util.toast(state_text)
    end)
end

menu.action(Menu_Root, "Restart Script", {}, "", function()
    util.restart_script()
end)




--------------------------------
--    Business Mission
--------------------------------

local Business_Mission <const> = menu.list(Menu_Root, "资产任务", {}, "")

--------------------------------
--    Special Cargo
--------------------------------

local Special_Cargo <const> = menu.list(Business_Mission, Labels.SpecialCargo, {}, "")

local SpecialCargoVars = {
    Source = {
        eMissionVariation = -1,
        iContrabandSize = 3,
        bSpecialItem = -1,
        iContrabandSizeInsFin = -1,
    },
    Sell = {
        iSaleValue = -1,
        iSpecialSaleValue = -1,
        eMissionVariation = -1,
    },
}

menu.divider(Special_Cargo, Labels.Source)

--#region Staff Source Cargo

local Special_Cargo_Staff_Source = menu.list(Special_Cargo, "员工进货", {}, "")

SpecialCargoVars.Staff = {
    WarehouseSelect = { true, true, true, true, true },
    iNumCargo = -1,
    eSpecialCargo = -1,
}

local Special_Cargo_Staff_Source_Warehouse = menu.list(Special_Cargo_Staff_Source, "特种货物仓库", {}, "")

for i = 1, 5 do
    local iWarehouse = GET_WAREHOUSE_PROPERTY_ID(i - 1)

    local menu_name = Labels.None
    if iWarehouse > 0 then
        menu_name = GET_SPECIAL_CARGO_WAREHOUSE_NAME(iWarehouse)
    end

    menu.toggle(Special_Cargo_Staff_Source_Warehouse, menu_name, {}, "", function(toggle)
        SpecialCargoVars.Staff.WarehouseSelect[i] = toggle
    end, SpecialCargoVars.Staff.WarehouseSelect[i])
end

rs.menu_slider(Special_Cargo_Staff_Source, "货物数量", { "SpecialCargoStaffNum" }, "", -1, 111, -1, 1, function(value)
    SpecialCargoVars.Staff.iNumCargo = value
end)
menu.list_select(Special_Cargo_Staff_Source, Labels.SpecialItem, {}, "同时获得一箱特殊物品", Tables.ContrabandSpecialItem, -1,
    function(value)
        SpecialCargoVars.Staff.eSpecialCargo = value
    end)

menu.action(Special_Cargo_Staff_Source, "员工立即进货", {}, "需要在仓库外面", function()
    if SpecialCargoVars.Staff.iNumCargo ~= -1 then
        GLOBAL_SET_INT(g_sWarehouseCargoSourcingData.iNumCargo, SpecialCargoVars.Staff.iNumCargo)
    end
    if SpecialCargoVars.Staff.eSpecialCargo ~= -1 then
        GLOBAL_SET_INT(g_sWarehouseCargoSourcingData.iSpecialCargoType, SpecialCargoVars.Staff.eSpecialCargo)
        GLOBAL_SET_INT(g_sWarehouseCargoSourcingData.iNumSpecialCargo, 1)
    end

    for i = 1, 5 do
        if SpecialCargoVars.Staff.WarehouseSelect[i] then
            GLOBAL_SET_BOOL(g_sWarehouseCargoSourcingData.bRequestDeliverCargo + i - 1, true)
        end
    end
end)

--#endregion


menu.list_select(Special_Cargo, Lang.SelectMission, {}, "", Tables.ContrabandBuy, -1, function(value)
    SpecialCargoVars.Source.eMissionVariation = value
end)

rs.menu_slider(Special_Cargo, "货物数量", { "SpecialCargoBuyNum" }, "", -1, 10, 3, 1, function(value)
    SpecialCargoVars.Source.iContrabandSize = value
end)
menu.list_select(Special_Cargo, Labels.SpecialItem, {}, "", Tables.BooleanSelect, -1, function(value)
    SpecialCargoVars.Source.bSpecialItem = value
end)

menu.toggle_loop(Special_Cargo, "设置购买任务数据", {}, Lang.E_B_S_M, function()
    if SpecialCargoVars.Source.iContrabandSize ~= -1 then
        GLOBAL_SET_INT(GlobalplayerBD_FM_3.sMagnateGangBossData.contrabandMissionData.contrabandSize(),
            SpecialCargoVars.Source.iContrabandSize)
    end
    if SpecialCargoVars.Source.bSpecialItem ~= -1 then
        GLOBAL_SET_INT(GlobalplayerBD_FM_3.sMagnateGangBossData.contrabandMissionData.bSpecialItem(),
            SpecialCargoVars.Source.bSpecialItem)
    end

    if SpecialCargoVars.Source.eMissionVariation ~= -1 then
        GB_SET_PLAYER_GANG_BOSS_MISSION_VARIATION(SpecialCargoVars.Source.eMissionVariation)
    end
end)

menu.action(Special_Cargo, Labels.LaunchMissionByTerrorbyte, {}, "", function()
    if IS_SCRIPT_RUNNING("gb_contraband_buy") then
        return
    end

    START_APP.TERRORBYTE()
    PAD.SET_CURSOR_POSITION(0.718, 0.272)
end)

rs.menu_slider(Special_Cargo, "货物数量", {}, Lang.O_W_F_INS_FIN, -1, 10, -1, 1, function(value)
    SpecialCargoVars.Source.iContrabandSizeInsFin = value
end)
menu.action(Special_Cargo, "直接完成 特种货物 购买任务", {}, "", function(value)
    local script = "gb_contraband_buy"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    if SpecialCargoVars.Source.iContrabandSizeInsFin ~= -1 then
        LOCAL_SET_INT(script, Locals[script].contrabandSize, SpecialCargoVars.Source.iContrabandSizeInsFin)
    end

    LOCAL_SET_INT(script, Locals[script].eType, 1)      -- eCONTRABANDTYPE_CAR
    LOCAL_SET_INT(script, Locals[script].eEndReason, 4) -- SET_END_REASON(eENDREASON_CONTRABAND_DELIVERED)
    LOCAL_SET_INT(script, Locals[script].eModeState, 8) -- SET_MODE_STATE(eMODESTATE_REWARDS)
end)



menu.divider(Special_Cargo, Labels.Sell)

local SpecialCargoWarehouseList = menu.list(Special_Cargo, "特种货物仓库电脑", {}, "")

for i = 0, 4 do
    local iWarehouse = GET_WAREHOUSE_PROPERTY_ID(i)
    if iWarehouse > 0 then
        local menu_name = GET_SPECIAL_CARGO_WAREHOUSE_NAME(iWarehouse)

        menu.action(SpecialCargoWarehouseList, menu_name, {}, "", function()
            START_APP.WAREHOUSE(iWarehouse)
        end)
    end
end



menu.list_select(Special_Cargo, Lang.SelectMission, {}, "", Tables.ContrabandSell, -1, function(value)
    SpecialCargoVars.Sell.eMissionVariation = value
end)

menu.toggle_loop(Special_Cargo, "设置出售任务数据", {}, Lang.E_B_S_M, function()
    local script = "gb_contraband_sell"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    if SpecialCargoVars.Sell.eMissionVariation ~= -1 then
        LOCAL_SET_INT(script, Locals[script].eSellVar, SpecialCargoVars.Sell.eMissionVariation)
    end
end)

menu.action(Special_Cargo, "直接完成 特种货物 出售任务", {}, "", function()
    local script = "gb_contraband_sell"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    LOCAL_SET_INT(script, Locals[script].eEndReason, 6) -- SET_END_REASON(eENDREASON_WIN_CONDITION_TRIGGERED)
    LOCAL_SET_INT(script, Locals[script].eModeState, 2) -- SET_MODE_STATE(eMODESTATE_REWARDS)
end)


menu.divider(Special_Cargo, "出售价值")

rs.menu_slider(Special_Cargo, "特种货物单位价值", { "SpecialCargoSaleValue" }, "", -1, 1000000, -1, 10000, function(value)
    SpecialCargoVars.Sell.iSaleValue = value
end)
rs.menu_slider(Special_Cargo, "特殊货物单位价值", { "SpecialItemSaleValue" }, "", -1, 1000000, -1, 10000, function(value)
    SpecialCargoVars.Sell.iSpecialSaleValue = value
end)
menu.toggle_loop(Special_Cargo, "设置出售价值", {}, "", function()
    if SpecialCargoVars.Sell.iSaleValue ~= -1 then
        Tunables.SetIntList("SpecialCargoSaleValue", SpecialCargoVars.Sell.iSaleValue)
    end
    if SpecialCargoVars.Sell.iSpecialSaleValue ~= -1 then
        Tunables.SetIntList("SpecialItemSaleValue", SpecialCargoVars.Sell.iSpecialSaleValue)
    end
end, function()
    Tunables.RestoreIntDefaults("SpecialCargoSaleValue")
    Tunables.RestoreIntDefaults("SpecialItemSaleValue")
end)



--------------------------------
--    Gunrunning Supplies
--------------------------------

local Gunrunning_Supplies <const> = menu.list(Business_Mission, get_label_text("ABH_BUS_GUNS"), {}, "")

local Gunrunning = {
    iResupplyValue = 60,
    Steal = {
        eMissionVariation = -1,
    },
    Sell = {
        eMissionVariation = -1,
        iSaleValue = -1,
    },
}

menu.divider(Gunrunning_Supplies, Labels.Source)

menu.list_select(Gunrunning_Supplies, Lang.SelectMission, {}, "", Tables.GunrunResupply, -1, function(value)
    Gunrunning.Steal.eMissionVariation = value
end)

rs.menu_slider(Gunrunning_Supplies, "原材料补给数量(%)", { "GunrunResupplyValue" }, "",
    -1, 100, 60, 10, function(value)
        Gunrunning.iResupplyValue = value
    end)

menu.action(Gunrunning_Supplies, Labels.LaunchMissionByTerrorbyte, {}, "", function()
    if IS_SCRIPT_RUNNING("gb_gunrunning") then
        return
    end

    if Gunrunning.Steal.eMissionVariation ~= -1 then
        GB_SET_PLAYER_GANG_BOSS_MISSION_VARIATION(Gunrunning.Steal.eMissionVariation)
    end

    if Gunrunning.iResupplyValue ~= -1 then
        Tunables.SetInt("GR_RESUPPLY_PACKAGE_VALUE", Gunrunning.iResupplyValue)
        Tunables.SetInt("GR_RESUPPLY_VEHICLE_VALUE", Gunrunning.iResupplyValue)
    end

    START_APP.TERRORBYTE()
    PAD.SET_CURSOR_POSITION(0.501, 0.651)
end)

menu.action(Gunrunning_Supplies, "直接完成 地堡 原材料补给任务", {}, "", function()
    local script = "gb_gunrunning"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    LOCAL_SET_BIT(script, Locals[script].iGunrunEntityBitSet + 1 + 0 * 3 + 1 + 0, 6) -- SET_GUNRUN_ENTITY_BIT(iGunrunEntity, eGUNRUNENTITYBITSET_DELIVERED)
    LOCAL_SET_INT(script, Locals[script].eEndReason, 3)                              -- SET_END_REASON(eENDREASON_GUNRUN_ENTITY_DELIVERED)
    LOCAL_SET_INT(script, Locals[script].eModeState, 14)                             -- SET_MODE_STATE(eMODESTATE_REWARDS)
end)



menu.divider(Gunrunning_Supplies, Labels.Sell)

menu.list_select(Gunrunning_Supplies, Lang.SelectMission, {}, "", Tables.GunrunSell, -1, function(value)
    Gunrunning.Sell.eMissionVariation = value
end)

menu.action(Gunrunning_Supplies, Labels.LaunchMissionByBunker, {}, "", function()
    if IS_SCRIPT_RUNNING("gb_gunrunning") then
        return
    end

    if Gunrunning.Sell.eMissionVariation ~= -1 then
        GB_SET_PLAYER_GANG_BOSS_MISSION_VARIATION(Gunrunning.Sell.eMissionVariation)
    end

    START_APP.BUNKER()
    PAD.SET_CURSOR_POSITION(0.481, 0.581)
end)

menu.action(Gunrunning_Supplies, "直接完成 地堡 出售任务", {}, "", function()
    local script = "gb_gunrunning"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local eMissionVariation = LOCAL_GET_INT(script, Locals[script].eMissionVariation)
    local deliverableQuantity = 1
    -- GRV_SELL_AMBUSHED, GRV_SELL_ROUGH_TERRAIN, GRV_SELL_HILL_CLIMB
    if eMissionVariation == 14 or eMissionVariation == 19 or eMissionVariation == 16 then
        deliverableQuantity = 5
    end

    -- Set sGangBossManageRewardsData.iNumDropsMade = sGangBossManageRewardsData.iTotalDrops
    local iNumEntitiesThisVariation = LOCAL_GET_INT(script, Locals[script].iNumEntitiesThisVariation)
    LOCAL_SET_INT(script, Locals[script].iTotalDeliveredCount, iNumEntitiesThisVariation * deliverableQuantity)

    for i = 0, iNumEntitiesThisVariation - 1, 1 do
        -- SET_GUNRUN_ENTITY_BIT(iGunrunEntity, eGUNRUNENTITYBITSET_DELIVERED)
        LOCAL_SET_BIT(script, Locals[script].iGunrunEntityBitSet + 1 + i * 3 + 1 + 0, 6)
    end

    LOCAL_SET_INT(script, Locals[script].eEndReason, 3)  -- SET_END_REASON(eENDREASON_GUNRUN_ENTITY_DELIVERED)
    LOCAL_SET_INT(script, Locals[script].eModeState, 14) -- SET_MODE_STATE(eMODESTATE_REWARDS)
end)


menu.divider(Gunrunning_Supplies, "出售价值")

rs.menu_slider(Gunrunning_Supplies, "货物单位价值", { "GunrunSaleValue" }, "", -1, 1000000, -1, 10000, function(value)
    Gunrunning.Sell.iSaleValue = value
end)
menu.toggle_loop(Gunrunning_Supplies, "设置出售价值", {}, "", function()
    if Gunrunning.Sell.iSaleValue ~= -1 then
        Tunables.SetIntList("GunrunProductSaleValue", Gunrunning.Sell.iSaleValue)
    end
end, function()
    Tunables.RestoreIntDefaults("GunrunProductSaleValue")
end)



--------------------------------
--    Air-Freight Cargo
--------------------------------

local AirFreight_Cargo <const> = menu.list(Business_Mission, get_label_text("ABH_BUS_AIR"), {}, "")

local SmugglerVars = {
    Source = {
        eMissionVariation = -1,
        iNumEntitiesThisVariation = -1,
    },
    Sell = {
        eMissionVariation = -1,
        iSaleValue = -1,
    },
    CargoType = {
        Menu = {},
    },
}


--#region Hangar Cargo Type

local AirFreight_Cargo_Type = menu.list(AirFreight_Cargo, "机库库存货物类型", {}, "")

menu.list_action(AirFreight_Cargo_Type, "设置全部货物", {}, "", Tables.HangarProductModelPropertyType, function(value)
    for slot = 0, 49 do
        local statIndex = PackedStats.PACKED_MP_INT_HANGAR_PRODUCT_0 + slot

        if GET_PACKED_STAT_INT_CODE(statIndex) > 0 then
            SET_PACKED_STAT_INT_CODE(statIndex, value)
        end
    end
    util.toast("完成！")
end)

menu.action(AirFreight_Cargo_Type, "刷新", {}, "", function()
    for slot = 0, 49 do
        local statIndex = PackedStats.PACKED_MP_INT_HANGAR_PRODUCT_0 + slot
        local model_index = GET_PACKED_STAT_INT_CODE(statIndex)

        if not SmugglerVars.CargoType.Menu[slot] then
            SmugglerVars.CargoType.Menu[slot] = menu.list_select(AirFreight_Cargo_Type, "Slot " .. slot, {}, "",
                Tables.HangarProductModelPropertyType, 1, function(value, menu_name, prev_value, click_type)
                    if click_type == CLICK_SCRIPTED or click_type == CLICK_BULK then
                        return
                    end
                    if GET_PACKED_STAT_INT_CODE(statIndex) > 0 then
                        SET_PACKED_STAT_INT_CODE(statIndex, value)
                    end
                end)
        end

        local command = SmugglerVars.CargoType.Menu[slot]
        if model_index > 0 then
            menu.set_value(command, model_index)
            menu.set_visible(command, true)
        else
            menu.set_visible(command, false)
        end
    end
end)

menu.divider(AirFreight_Cargo_Type, "货物类型列表")

--#endregion



menu.divider(AirFreight_Cargo, Labels.Source)

--#region Staff Source Cargo

local AirFreight_Cargo_Staff_Source = menu.list(AirFreight_Cargo, "员工进货", {}, "")

SmugglerVars.Staff = {
    iNum = -1,
    eType = -1,
}

menu.list_select(AirFreight_Cargo_Staff_Source, "货物类型", {}, "", Tables.SmugglerCargoType, -1, function(value)
    SmugglerVars.Staff.eType = value
end)
rs.menu_slider(AirFreight_Cargo_Staff_Source, "货物数量", { "AirCargoStaffNum" }, "", -1, 50, -1, 1, function(value)
    SmugglerVars.Staff.iNum = value
end)

menu.action(AirFreight_Cargo_Staff_Source, "员工立即进货", {}, "需要在仓库外面", function()
    if SmugglerVars.Staff.eType ~= -1 then
        GLOBAL_SET_INT(g_sHangarCargoSourcingData.eType, SmugglerVars.Staff.eType)
    end
    if SmugglerVars.Staff.iNum ~= -1 then
        GLOBAL_SET_INT(g_sHangarCargoSourcingData.iNum, SmugglerVars.Staff.iNum)
    end

    GLOBAL_SET_BIT(g_sHangarCargoSourcingDataBitset(), 9)
end)


--#endregion


menu.list_select(AirFreight_Cargo, Lang.SelectMission, {}, "", Tables.SmugglerBuy, -1, function(value)
    SmugglerVars.Source.eMissionVariation = value
end)

menu.action(AirFreight_Cargo, Labels.LaunchMissionByHangar, {}, "", function()
    if IS_SCRIPT_RUNNING("gb_smuggler") then
        return
    end

    if SmugglerVars.Source.eMissionVariation ~= -1 then
        GB_SET_PLAYER_GANG_BOSS_MISSION_VARIATION(SmugglerVars.Source.eMissionVariation)
    end

    START_APP.HANGAR()
    PAD.SET_CURSOR_POSITION(0.631, 0.0881)
end)

rs.menu_slider(AirFreight_Cargo, "货物数量", {}, Lang.O_W_F_INS_FIN, -1, 3, -1, 1, function(value)
    SmugglerVars.Source.iNumEntitiesThisVariation = value
end)

menu.action(AirFreight_Cargo, "直接完成 机库空运货物 偷取任务", {}, "货物类型会出错", function()
    local script = "gb_smuggler"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    if SmugglerVars.Source.iNumEntitiesThisVariation ~= -1 then
        LOCAL_SET_INT(script, Locals[script].iNumEntitiesThisVariation, SmugglerVars.Source.iNumEntitiesThisVariation)
    end

    local iNumEntitiesThisVariation = LOCAL_GET_INT(script, Locals[script].iNumEntitiesThisVariation)
    for i = 0, iNumEntitiesThisVariation - 1, 1 do
        -- SET_SMUGGLER_ENTITY_BIT(iSmugglerEntity, eSMUGGLERENTITYBITSET_DELIVERED)
        LOCAL_SET_BIT(script, Locals[script].iSmugglerEntityBitSet + 1 + i * 3 + 1 + 0, 6)
    end

    LOCAL_SET_INT(script, Locals[script].eEndReason, 3)  -- SET_END_REASON(eENDREASON_SMUGGLER_ENTITY_DELIVERED)
    LOCAL_SET_INT(script, Locals[script].eModeState, 18) -- SET_MODE_STATE(eMODESTATE_REWARDS)

    if iNumEntitiesThisVariation > 1 then
        util.yield(800)
        LOCAL_SET_INT(script, Locals[script].eModeState, 19) -- SET_MODE_STATE(eMODESTATE_END)
    end
end)


menu.divider(AirFreight_Cargo, Labels.Sell)

menu.list_select(AirFreight_Cargo, Lang.SelectMission, {}, "", Tables.SmugglerSell, -1, function(value)
    SmugglerVars.Sell.eMissionVariation = value
end)

menu.action(AirFreight_Cargo, Labels.LaunchMissionByHangar, {}, "", function()
    if IS_SCRIPT_RUNNING("gb_smuggler") then
        return
    end

    if SmugglerVars.Sell.eMissionVariation ~= -1 then
        GB_SET_PLAYER_GANG_BOSS_MISSION_VARIATION(SmugglerVars.Sell.eMissionVariation)
    end

    START_APP.HANGAR()
    PAD.SET_CURSOR_POSITION(0.772, 0.101)
end)

local SmugglerDeliverableQuantity = {
    [20] = 5,
    [15] = 2,
    [24] = 2,
    [21] = 3,
    [22] = 5,
    [16] = 5,
    [17] = 5,
    [25] = 5,
}

menu.action(AirFreight_Cargo, "直接完成 机库空运货物 出售任务", {}, "", function()
    local script = "gb_smuggler"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local eMissionVariation = LOCAL_GET_INT(script, Locals[script].eMissionVariation)

    local deliverableQuantity = SmugglerDeliverableQuantity[eMissionVariation]
    if deliverableQuantity == nil then
        deliverableQuantity = 1
    end

    -- Set sGangBossManageRewardsData.iNumDropsMade = sGangBossManageRewardsData.iTotalDrops
    local iNumEntitiesThisVariation = LOCAL_GET_INT(script, Locals[script].iNumEntitiesThisVariation)
    LOCAL_SET_INT(script, Locals[script].iTotalDeliveredCount, iNumEntitiesThisVariation * deliverableQuantity)

    LOCAL_SET_INT(script, Locals[script].eEndReason, 3)  -- SET_END_REASON(eENDREASON_SMUGGLER_ENTITY_DELIVERED)
    LOCAL_SET_INT(script, Locals[script].eModeState, 18) -- SET_MODE_STATE(eMODESTATE_REWARDS)
end)

menu.divider(AirFreight_Cargo, "出售价值")

rs.menu_slider(AirFreight_Cargo, "货物单位价值", { "SmugSaleValue" }, "", -1, 1000000, -1, 10000, function(value)
    SmugglerVars.Sell.iSaleValue = value
end)
menu.toggle_loop(AirFreight_Cargo, "设置出售价值", {}, "", function()
    if SmugglerVars.Sell.iSaleValue ~= -1 then
        Tunables.SetIntList("SmugProductSaleValue", SmugglerVars.Sell.iSaleValue)
    end
end, function()
    Tunables.RestoreIntDefaults("SmugProductSaleValue")
end)



--------------------------------
--    Acid Lab
--------------------------------

local Acid_Lab <const> = menu.list(Business_Mission, Labels.AcidLab, {}, "")

local AcidLab = {
    iResupplyValue = 60,
    Source = {
        eMissionVariation = -1,
    },
    Sell = {
        eMissionVariation = -1,
        iSaleValue = -1,
    },
}

menu.divider(Acid_Lab, Labels.Source)

menu.list_select(Acid_Lab, Lang.SelectMission, {}, "",
    Tables.AcidLabSource, -1, function(value)
        AcidLab.Source.eMissionVariation = value
    end)
menu.slider(Acid_Lab, "原材料补给数量(%)", { "AcidResupplyValue" }, "",
    0, 100, 60, 10, function(value)
        AcidLab.iResupplyValue = value
    end)

menu.action(Acid_Lab, Labels.LaunchMission, {}, "", function()
    Tunables.SetInt("ACID_LAB_RESUPPLY_CRATE_VALUE", AcidLab.iResupplyValue)

    -- FMMC_TYPE_ACID_LAB_SOURCE
    SET_CONTACT_REQUEST_GB_MISSION_LAUNCH_DATA(305, AcidLab.Source.eMissionVariation)
end)

menu.action(Acid_Lab, "直接完成 致幻剂实验室 原材料补给任务", {}, "", function()
    local script = "fm_content_acid_lab_source"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end
    INSTANT_FINISH_FM_CONTENT_MISSION(script)
end)


menu.divider(Acid_Lab, Labels.Sell)

menu.list_select(Acid_Lab, Lang.SelectMission, {}, "",
    Tables.AcidLabSell, -1, function(value)
        AcidLab.Sell.eMissionVariation = value
    end)
menu.toggle_loop(Acid_Lab, "设置出售任务数据", {}, Lang.E_B_S_M, function()
    if AcidLab.Sell.eMissionVariation ~= -1 then
        GB_SET_PLAYER_GANG_BOSS_MISSION_VARIATION(AcidLab.Sell.eMissionVariation)
    end
end)

menu.action(Acid_Lab, "直接完成 致幻剂实验室 出售任务", {}, "", function()
    local script = "fm_content_acid_lab_sell"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    util.create_tick_handler(function()
        if IS_SCRIPT_RUNNING(script) then
            -- Set sLocalVariables.sRewards.iDropOffCount = sLocalVariables.sRewards.iTotalDropoffs
            local iTotalDropoffs = LOCAL_GET_INT(script, Locals[script].iTotalDropoffs)
            LOCAL_SET_INT(script, Locals[script].iDropOffCount, iTotalDropoffs)
        else
            util.toast("Done")
            return false
        end
    end)
    util.yield(200)
    INSTANT_FINISH_FM_CONTENT_MISSION(script)
end)


menu.divider(Acid_Lab, "出售价值")

rs.menu_slider(Acid_Lab, "货物单位价值", { "AcidSaleValue" }, "", -1, 1000000, -1, 10000, function(value)
    AcidLab.Sell.iSaleValue = value
end)
menu.toggle_loop(Acid_Lab, "设置出售价值", {}, "", function()
    if AcidLab.Sell.iSaleValue ~= -1 then
        Tunables.SetIntList("AcidProductSaleValue", AcidLab.Sell.iSaleValue)
    end
end, function()
    Tunables.RestoreIntDefaults("AcidProductSaleValue")
end)




--------------------------------
--    Nightclub
--------------------------------

local Nightclub_Business <const> = menu.list(Business_Mission, Labels.Nightclub, {}, "")

menu.action(Nightclub_Business, "夜总会电脑", {}, "", function()
    START_APP.NIGHTCLUB()
end)

--------------------------------------------
--    Request Nightclub Goods (Yohan)
--------------------------------------------

local Club_Source = menu.list(Nightclub_Business,
    string.format("%s (%s)", get_label_text("YOHN_OP1_T"), get_label_text("CELL_YOHAN_N")), {}, "")

local ClubSource = {
    eMissionVariation = -1,
    fAmountMultiplier = -1,
    eGoodsType = -1,
}

menu.list_select(Club_Source, Lang.SelectMission, {}, "",
    Tables.ClubSource, -1, function(value)
        ClubSource.eMissionVariation = value
    end)

rs.menu_slider(Club_Source, "获取货物数量倍数", {}, "", -1, 10, -1, 1, function(value)
    ClubSource.fAmountMultiplier = value
end)
menu.list_select(Club_Source, "选择货物类型", {}, "",
    Tables.GoodsType, -1, function(value)
        ClubSource.eGoodsType = value
    end)
menu.toggle_loop(Club_Source, "设置任务数据", {}, Lang.E_B_S_M, function()
    local script = "fm_content_club_source"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    if ClubSource.fAmountMultiplier ~= -1 then
        for _, offset in pairs(TunablesI["NightclubSourceRewardAmount"]) do
            local default_value = TunableDefaults[offset]
            local new_value = default_value * ClubSource.fAmountMultiplier
            GLOBAL_SET_INT(g_sMPTunables + offset, new_value)
        end
    end

    if ClubSource.eGoodsType ~= -1 then
        LOCAL_SET_INT(script, Locals[script].eGoodsType, ClubSource.eGoodsType)
    end
end, function()
    Tunables.RestoreIntDefaults("NightclubSourceRewardAmount")
end)

menu.divider(Club_Source, "")

menu.textslider(Club_Source, Labels.LaunchMission, {}, "", {
    "Request", "Start"
}, function(value)
    local iMission = 301 -- FMMC_TYPE_CLUB_SOURCE
    if value == 1 then
        SET_CONTACT_REQUEST_GB_MISSION_LAUNCH_DATA(iMission, ClubSource.eMissionVariation)
    else
        GB_BOSS_REQUEST_MISSION_LAUNCH_FROM_SERVER(iMission, ClubSource.eMissionVariation)
    end
end)

menu.action(Club_Source, "已送达货物到夜总会", {}, "直接增加夜总会货物数量, 可以无限次送达", function()
    local script = "fm_content_club_source"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local iLocalParticipantIndexAsInt = LOCAL_GET_INT(script, Locals[script].iLocalParticipantIndexAsInt)
    LOCAL_SET_INT(script, Locals[script].iGoodsToTransfer(iLocalParticipantIndexAsInt), 1)
end)

menu.action(Club_Source, "收集夜总会货物", {}, "Only work for Truck Mission", function()
    local script = "fm_content_club_source"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local blip = HUD.GET_NEXT_BLIP_INFO_ID(478)
    if not HUD.DOES_BLIP_EXIST(blip) then
        return
    end
    local entity = HUD.GET_BLIP_INFO_ID_ENTITY_INDEX(blip)
    if not ENTITY.DOES_ENTITY_EXIST(entity) then
        return
    end
    if ENTITY.IS_ENTITY_ATTACHED(entity) then
        ENTITY.DETACH_ENTITY(entity, true, true)
        ENTITY.SET_ENTITY_VISIBLE(entity, true, false)
    end
    OBJECT.SET_PICKUP_OBJECT_COLLECTABLE_IN_VEHICLE(entity)
    OBJECT.ATTACH_PORTABLE_PICKUP_TO_PED(entity, players.user_ped())
end)

menu.action(Club_Source, "结束任务", {}, "", function()
    local script = "fm_content_club_source"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    INSTANT_FINISH_FM_CONTENT_MISSION(script)
end)


menu.divider(Nightclub_Business, Labels.Sell)

local ClubSell = {
    eMissionVariation = -1,
    iSaleValue = -1,
}

menu.list_select(Nightclub_Business, Lang.SelectMission, {}, "",
    Tables.NightclubSell, -1, function(value)
        ClubSell.eMissionVariation = value
    end)
menu.toggle_loop(Nightclub_Business, "设置出售任务数据", {}, Lang.E_B_S_M, function()
    if ClubSell.eMissionVariation ~= -1 then
        GB_SET_PLAYER_GANG_BOSS_MISSION_VARIATION(ClubSell.eMissionVariation)
    end
end)

menu.action(Nightclub_Business, "直接完成 夜总会 出售任务", {}, "", function()
    local script = "business_battles_sell"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local iMissionEntity = 0

    -- Set serverBD.iTotalDeliveredCount = serverBD.iTotalDeliveriesToMake
    local iTotalDeliveriesToMake = LOCAL_GET_INT(script, Locals[script].iTotalDeliveriesToMake)
    LOCAL_SET_INT(script, Locals[script].iTotalDeliveredCount, iTotalDeliveriesToMake)

    -- Set serverBD.sMissionEntity[iMissionEntity].iDeliveriesMade = serverBD.sMissionEntity[iMissionEntity].iDeliveriesToMake
    local iDeliveriesToMake = LOCAL_GET_INT(script, Locals[script].sMissionEntity + 1 + iMissionEntity * 42 + 30)
    LOCAL_SET_INT(script, Locals[script].sMissionEntity + 1 + iMissionEntity * 42 + 29, iDeliveriesToMake)

    LOCAL_SET_BIT(script, Locals[script].sMissionEntity + 1 + iMissionEntity * 42 + 11 + 1 + 0, 1) -- SET_MISSION_ENTITY_BIT(iMissionEntity, eMISSIONENTITYBITSET_DELIVERED)
    LOCAL_SET_INT(script, Locals[script].eEndReason, 4)                                            -- SET_END_REASON(eENDREASON_MISSION_ENTITY_DELIVERED)
    LOCAL_SET_INT(script, Locals[script].eModeState, 30)                                           -- SET_MODE_STATE(eMODESTATE_REWARDS)
end)


menu.divider(Nightclub_Business, "出售价值")

rs.menu_slider(Nightclub_Business, "货物单位价值", { "NightclubSaleValue" }, "", -1, 1000000, -1, 10000, function(value)
    ClubSell.iSaleValue = value
end)
menu.toggle_loop(Nightclub_Business, "设置出售价值", {}, "", function()
    if ClubSell.iSaleValue ~= -1 then
        Tunables.SetIntList("NightclubProductSaleValue", ClubSell.iSaleValue)
    end
end, function()
    Tunables.RestoreIntDefaults("NightclubProductSaleValue")
end)



--------------------------------
--    Motorcycle Club
--------------------------------

local Motorcycle_Club <const> = menu.list(Business_Mission, Labels.MotorcycleClub, {}, "")

local MotorcycleClubVars = {
    Steal = {
        iResupplyValue = 60,
        eMissionVariation = -1,
    },
    Sell = {
        eMissionVariation = -1,
        iSaleValue = -1,
    },
}

menu.list_action(Motorcycle_Club, "摩托帮电脑", {}, "", Tables.BikerFactory, function(value)
    START_APP.BIKER_FACTORY(value)
end)

menu.divider(Motorcycle_Club, Labels.Source)

menu.list_select(Motorcycle_Club, Lang.SelectMission, {}, "",
    Tables.BikerResupply, -1, function(value)
        MotorcycleClubVars.Steal.eMissionVariation = value
    end)

rs.menu_slider(Motorcycle_Club, "原材料补给数量(%)", { "BikerResupplyValue" }, "",
    -1, 100, 60, 10, function(value)
        MotorcycleClubVars.Steal.iResupplyValue = value
    end)

menu.action(Motorcycle_Club, Labels.LaunchMissionByTerrorbyte, {}, "", function()
    if IS_SCRIPT_RUNNING("gb_illicit_goods_resupply") then
        return
    end

    if MotorcycleClubVars.Steal.eMissionVariation ~= -1 then
        GB_SET_PLAYER_GANG_BOSS_MISSION_VARIATION(MotorcycleClubVars.Steal.eMissionVariation)
    end

    if MotorcycleClubVars.Steal.iResupplyValue ~= -1 then
        Tunables.SetInt("BIKER_RESUPPLY_PACKAGE_VALUE", MotorcycleClubVars.Steal.iResupplyValue)
        Tunables.SetInt("BIKER_RESUPPLY_VEHICLE_VALUE", MotorcycleClubVars.Steal.iResupplyValue)
    end

    START_APP.TERRORBYTE()
    PAD.SET_CURSOR_POSITION(0.722, 0.652)
end)

menu.action(Motorcycle_Club, "直接完成 摩托帮工厂 原材料补给任务", {}, "", function()
    local script = "gb_illicit_goods_resupply"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local iIllicitGood = 0
    -- SET_ILLICIT_GOOD_SERVER_BIT0(iIllicitGood, eILLICITGOODSERVERBITSET0_DELIVERED)
    LOCAL_SET_BIT(script, Locals[script].iIllicitGoodBitset0 + 1 + iIllicitGood, 2)

    LOCAL_SET_INT(script, Locals[script].eEndReason, 4) -- SET_END_REASON(eENDREASON_ILLICIT_GOODS_DELIVERED)
    LOCAL_SET_INT(script, Locals[script].eModeState, 8) -- SET_MODE_STATE(eMODESTATE_REWARDS)
end)


menu.divider(Motorcycle_Club, Labels.Sell)

menu.list_select(Motorcycle_Club, Lang.SelectMission, {}, "",
    Tables.BikerSell, -1, function(value)
        MotorcycleClubVars.Sell.eMissionVariation = value
    end)

menu.toggle_loop(Motorcycle_Club, "设置出售任务数据", {}, Lang.E_B_S_M, function()
    local script = "gb_biker_contraband_sell"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local eMissionVariation = MotorcycleClubVars.Sell.eMissionVariation
    if eMissionVariation ~= -1 then
        LOCAL_SET_INT(script, Locals[script].eSellVar, eMissionVariation)
    end
end)

menu.action(Motorcycle_Club, "直接完成 摩托帮工厂 出售任务", {}, "", function()
    local script = "gb_biker_contraband_sell"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local TotalDrops = {
        [0] = 1,
        [1] = 15,
        [2] = 15,
        [3] = 15,
        [4] = 12,
        [5] = 15,
        [6] = 4,
        [7] = 1,
        [8] = 4,
        [9] = 15,
        [10] = 1,
        [11] = 1,
        [12] = 3,
    }

    local eSellVar = LOCAL_GET_INT(script, Locals[script].eSellVar)
    local iTotalDrops = TotalDrops[eSellVar]

    LOCAL_SET_INT(script, Locals[script].iVehicleCountDeliveredAllContraband, iTotalDrops)
    LOCAL_SET_INT(script, Locals[script].iDroppedOffCount, iTotalDrops)

    LOCAL_SET_INT(script, Locals[script].eEndReason, 7) -- SET_END_REASON(eENDREASON_WIN_CONDITION_TRIGGERED)
    LOCAL_SET_INT(script, Locals[script].eModeState, 2) -- SET_MODE_STATE(eMODESTATE_REWARDS)
end)


menu.divider(Motorcycle_Club, "出售价值")

rs.menu_slider(Motorcycle_Club, "货物单位价值", { "BikerSaleValue" }, "", -1, 1000000, -1, 10000, function(value)
    MotorcycleClubVars.Sell.iSaleValue = value
end)
menu.toggle_loop(Motorcycle_Club, "设置出售价值", {}, "", function()
    if MotorcycleClubVars.Sell.iSaleValue ~= -1 then
        Tunables.SetIntList("BikerProductSaleValue", MotorcycleClubVars.Sell.iSaleValue)
    end
end, function()
    Tunables.RestoreIntDefaults("BikerProductSaleValue")
end)




--------------------------------
--    Vehicle Cargo
--------------------------------

local Vehicle_Cargo <const> = menu.list(Business_Mission, Labels.VehicleCargo, {}, "")

local VehicleCargoVars = {
    Steal = {
        eMissionVariation = -1,
        exportEntityIeVehicleEnum = -1,
    },
    Sell = {
        iSaleValue = -1,
    },
}

menu.action(Vehicle_Cargo, "交易载具电脑", {}, "", function()
    START_APP.IMPORT_EXPORT()
end)

menu.toggle_loop(Vehicle_Cargo, "可调整项", {}, "无通缉, 无维修费, 无敌人追击", function()
    Tunables.SetIntList("ImpExpWantedCap", 0)
    Tunables.SetIntList("ImpExpReduction", 0)
    Tunables.SetIntList("ImpExpGangChase", 0)
end, function()
    Tunables.RestoreIntDefaults("ImpExpWantedCap")
    Tunables.RestoreIntDefaults("ImpExpReduction")
    Tunables.RestoreIntDefaults("ImpExpGangChase")
end)


menu.divider(Vehicle_Cargo, Labels.Source)

menu.list_select(Vehicle_Cargo, Lang.SelectMission, {}, "",
    Tables.VehicleExportSteal, -1, function(value)
        VehicleCargoVars.Steal.eMissionVariation = value
    end)
menu.list_select(Vehicle_Cargo, "载具类型", {}, "",
    Tables.VehicleExportEnum, -1, function(value)
        VehicleCargoVars.Steal.exportEntityIeVehicleEnum = value
    end)

menu.toggle_loop(Vehicle_Cargo, "设置偷取任务数据", {}, Lang.E_B_S_M, function()
    if VehicleCargoVars.Steal.eMissionVariation ~= -1 then
        GB_SET_PLAYER_GANG_BOSS_MISSION_VARIATION(VehicleCargoVars.Steal.eMissionVariation)
    end

    local script = "gb_vehicle_export"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    if VehicleCargoVars.Steal.exportEntityIeVehicleEnum ~= -1 then
        LOCAL_SET_INT(script, Locals[script].exportEntityIeVehicleEnum, VehicleCargoVars.Steal.exportEntityIeVehicleEnum)
    end
end)

menu.action(Vehicle_Cargo, Labels.LaunchMissionByTerrorbyte, {}, "", function()
    if IS_SCRIPT_RUNNING("gb_vehicle_export") then
        return
    end

    START_APP.TERRORBYTE()
    PAD.SET_CURSOR_POSITION(0.259, 0.646)
end)

menu.action(Vehicle_Cargo, "任务目标载具 传送到我", {}, "", function()
    local script = "gb_vehicle_export"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    util.spoof_script(script, function()
        local iExportEntity = 0
        local net_id = LOCAL_GET_INT(script, Locals[script].iExportEntityNetId + 1 + iExportEntity)
        local vehicle = NETWORK.NET_TO_VEH(net_id)

        if ENTITY.IS_ENTITY_A_VEHICLE(vehicle) then
            TP_VEHICLE_TO_ME(vehicle)
            VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehicle, 0.0)

            -- SET_MODE_STATE(eMODESTATE_DELIVER_EXPORT_ENTITY)
            LOCAL_SET_INT(script, Locals[script].eModeState, 12)

            -- SET_BIT(sCarBombStruct.iCarBombBitSet, iCARBOMB_BITSET0_BOMB_DEFUSED)
            LOCAL_SET_BIT(script, Locals[script].sCarBombStruct.iCarBombBitSet, 2)
        end
    end)
end)


menu.divider(Vehicle_Cargo, Labels.Sell)

menu.action(Vehicle_Cargo, "跳过载具改装", {}, "在载具改装界面使用", function()
    local script = "carmod_shop"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    -- CPERSONALMODSHOPFLAG_bBodyWorkDone       5
    -- CPERSONALMODSHOPFLAG_bPerformanceDone    6
    -- CPERSONALMODSHOPFLAG_bTrackerDone        7
    -- CPERSONALMODSHOPFLAG_bPlateDone          8
    -- CPERSONALMODSHOPFLAG_bWheelsDone         9
    -- CPERSONALMODSHOPFLAG_bPrimaryColorDone   10

    LOCAL_SET_BITS(script, Locals[script].iPersonalCarModShopFlags, 5, 6, 7, 8, 9, 10)
end)

menu.divider(Vehicle_Cargo, "出售价值")

-- Commission
rs.menu_slider(Vehicle_Cargo, get_label_text("BIGM_COM"), { "VehicleCargoSaleValue" }, "", -1, 1000000, -1, 10000,
    function(value)
        VehicleCargoVars.Sell.iSaleValue = value
    end)
menu.toggle_loop(Vehicle_Cargo, "设置出售价值", {}, "", function()
    if VehicleCargoVars.Sell.iSaleValue ~= -1 then
        Tunables.SetIntList("ImpExpSellOffer", VehicleCargoVars.Sell.iSaleValue)
    end
end, function()
    Tunables.RestoreIntDefaults("ImpExpSellOffer")
end)


--------------------------------
--    Common
--------------------------------

menu.divider(Business_Mission, "")

-- Master Control Terminal
menu.action(Business_Mission, get_label_text("ARC_MCT_BLIP"), {}, "", function()
    START_APP.MASTER_CONTROL()
end)

menu.list_action(Business_Mission, "立即补满原材料", {}, "", {
    { -1, "Fill All Supplies" },
    { 0,  "Fill Fake Cash Supplies" },
    { 1,  "Fill Cocaine Supplies" },
    { 2,  "Fill Meth Supplies" },
    { 3,  "Fill Weed Supplies" },
    { 4,  "Fill Document Forgery Supplies" },
    { 5,  "Fill Bunker Supplies" },
    { 6,  "Fill Acid Lab Supplies" },
}, function(value)
    if value == -1 then
        for i = 0, 6 do
            GLOBAL_SET_INT(g_iFactoryPaidResupplyTimers + 1 + i, 1)
        end
    else
        GLOBAL_SET_INT(g_iFactoryPaidResupplyTimers + 1 + value, 1)
    end
end)



--------------------------------
--    Business Monitor
--------------------------------

local Business_Monitor <const> = menu.list(Business_Mission, "资产监视", { "BusinessMonitor" }, "")

local BusinessMonitor = {
    Menu = {
        Bunker = {},
        Nightclub = {
            product = {}
        },
        AcidLab = {},
        Biker = {},
        SpecialCargo = {},
        Hangar = {},
        SafeCash = {},
    },
    Caps = {
        Nightclub = {
            [0] = 50,  -- Cargo
            [1] = 100, -- Weapons
            [2] = 10,  -- Cocaine
            [3] = 20,  -- Meth
            [4] = 80,  -- Weed
            [5] = 60,  -- Forgery
            [6] = 40   -- Cash
        },
        Biker = {
            [0] = 60, -- Forgery
            [1] = 80, -- Weed
            [2] = 40, -- Cash
            [3] = 20, -- Meth
            [4] = 10  -- Cocaine
        },
        Bunker = 100,
        AcidLab = 160,
        Warehouse = {
            [1]  = 16,  -- "MP_WHOUSE_0",
            [2]  = 16,  -- "MP_WHOUSE_1",
            [3]  = 16,  -- "MP_WHOUSE_2",
            [4]  = 16,  -- "MP_WHOUSE_3",
            [5]  = 16,  -- "MP_WHOUSE_4",
            [6]  = 111, -- "MP_WHOUSE_5",
            [7]  = 42,  -- "MP_WHOUSE_6",
            [8]  = 111, -- "MP_WHOUSE_7",
            [9]  = 16,  -- "MP_WHOUSE_8",
            [10] = 42,  -- "MP_WHOUSE_9",
            [11] = 42,  -- "MP_WHOUSE_10",
            [12] = 42,  -- "MP_WHOUSE_11",
            [13] = 42,  -- "MP_WHOUSE_12",
            [14] = 42,  -- "MP_WHOUSE_13",
            [15] = 42,  -- "MP_WHOUSE_14",
            [16] = 111, -- "MP_WHOUSE_15",
            [17] = 111, -- "MP_WHOUSE_16",
            [18] = 111, -- "MP_WHOUSE_17",
            [19] = 111, -- "MP_WHOUSE_18",
            [20] = 111, -- "MP_WHOUSE_19",
            [21] = 42,  -- "MP_WHOUSE_20",
            [22] = 111, -- "MP_WHOUSE_21",
        },
        Hangar = 50,
        SafeCash = {
            Nightclub = 250000,
            Arcade = 100000,
            Agency = 250000,
            SalvageYard = 250000,
            BikerBar = 100000,
        },
    },
}

menu.action(Business_Monitor, "刷新状态", {}, "", function()
    if not IS_IN_SESSION() then
        util.toast("仅在线上模式战局内可用")
        return
    end

    local text = ""
    local product = 0

    -- Bunker
    if GET_BUNKER_PROPERTY_ID() > 0 then
        text = GET_FACTORY_SUPPLIES(5) .. "%"
        menu.set_value(BusinessMonitor.Menu.Bunker.supplies, text)

        product = GET_FACTORY_PRODUCT(5)
        text = product .. "/" .. BusinessMonitor.Caps.Bunker
        if product >= BusinessMonitor.Caps.Bunker then
            text = "[!] " .. text
        end
        menu.set_value(BusinessMonitor.Menu.Bunker.product, text)

        text = STAT_GET_INT(ADD_MP_INDEX("RESEARCHTOTALFORFACTORY5")) .. "/60"
        menu.set_value(BusinessMonitor.Menu.Bunker.research, text)
    else
        menu.set_value(BusinessMonitor.Menu.Bunker.supplies, "")
        menu.set_value(BusinessMonitor.Menu.Bunker.product, "")
        menu.set_value(BusinessMonitor.Menu.Bunker.research, "")
    end

    -- Nightclub
    if GET_NIGHTCLUB_PROPERTY_ID() > 0 then
        text = math.floor(STAT_GET_INT(ADD_MP_INDEX("CLUB_POPULARITY")) / 10) .. '%'
        menu.set_value(BusinessMonitor.Menu.Nightclub.popularity, text)

        text = STAT_GET_INT(ADD_MP_INDEX("CLUB_SAFE_CASH_VALUE"))
        if text >= BusinessMonitor.Caps.SafeCash.Nightclub then
            text = "[!] " .. text
        end
        menu.set_value(BusinessMonitor.Menu.Nightclub.safeCash, text)

        for i = 0, 6 do
            product = STAT_GET_INT(ADD_MP_INDEX("HUB_PROD_TOTAL_" .. i))
            text = product .. "/" .. BusinessMonitor.Caps.Nightclub[i]
            if product >= BusinessMonitor.Caps.Nightclub[i] then
                text = "[!] " .. text
            end
            menu.set_value(BusinessMonitor.Menu.Nightclub.product[i], text)
        end
    else
        menu.set_value(BusinessMonitor.Menu.Nightclub.popularity, "")
        menu.set_value(BusinessMonitor.Menu.Nightclub.product, "")
        menu.set_value(BusinessMonitor.Menu.Nightclub.safeCash, "")
        for i = 0, 6 do
            menu.set_value(BusinessMonitor.Menu.Nightclub.product[i], "")
        end
    end

    -- Acid Lab
    if DOES_PLAYER_OWN_ACID_LAB() then
        text = GET_FACTORY_SUPPLIES(6) .. "%"
        menu.set_value(BusinessMonitor.Menu.AcidLab.supplies, text)

        product = GET_FACTORY_PRODUCT(6)
        text = product .. "/" .. BusinessMonitor.Caps.AcidLab
        if product >= BusinessMonitor.Caps.AcidLab then
            text = "[!] " .. text
        end
        menu.set_value(BusinessMonitor.Menu.AcidLab.product, text)
    else
        menu.set_value(BusinessMonitor.Menu.AcidLab.supplies, "")
        menu.set_value(BusinessMonitor.Menu.AcidLab.product, "")
    end


    -- Safe Cash
    text = STAT_GET_INT(ADD_MP_INDEX("ARCADE_SAFE_CASH_VALUE"))
    if text == BusinessMonitor.Caps.SafeCash.Arcade then
        text = "[!] " .. text
    end
    menu.set_value(BusinessMonitor.Menu.SafeCash.arcade, text)

    text = STAT_GET_INT(ADD_MP_INDEX("FIXER_SAFE_CASH_VALUE"))
    if text == BusinessMonitor.Caps.SafeCash.Agency then
        text = "[!] " .. text
    end
    menu.set_value(BusinessMonitor.Menu.SafeCash.agency, text)

    text = STAT_GET_INT(ADD_MP_INDEX("SALVAGE_SAFE_CASH_VALUE"))
    if text == BusinessMonitor.Caps.SafeCash.SalvageYard then
        text = "[!] " .. text
    end
    menu.set_value(BusinessMonitor.Menu.SafeCash.salvageYard, text)



    -- Biker
    if GET_BIKER_CLUBHOUSE_PROPERTY_ID() > 0 then
        text = STAT_GET_INT(ADD_MP_INDEX("BIKER_BAR_RESUPPLY_CASH"))
        if text == BusinessMonitor.Caps.SafeCash.BikerBar then
            text = "[!] " .. text
        end
        menu.set_value(BusinessMonitor.Menu.Biker.barEarning, text)

        for i = 0, 4 do
            local iFactoryID = GET_FACTORY_PROPERTY_ID(i)
            if iFactoryID > 0 then
                local eFactoryType = Tables.BikerFactoryType[iFactoryID]

                text = GET_FACTORY_SUPPLIES(i) .. "%"
                menu.set_value(BusinessMonitor.Menu.Biker[eFactoryType].supplies, text)

                product = GET_FACTORY_PRODUCT(i)
                text = product .. "/" .. BusinessMonitor.Caps.Biker[eFactoryType]
                if product >= BusinessMonitor.Caps.Biker[eFactoryType] then
                    text = "[!] " .. text
                end
                menu.set_value(BusinessMonitor.Menu.Biker[eFactoryType].product, text)
            end
        end
    else
        menu.set_value(BusinessMonitor.Menu.Biker.barEarning, "")
        for i = 0, 4 do
            menu.set_value(BusinessMonitor.Menu.Biker[i].supplies, "")
            menu.set_value(BusinessMonitor.Menu.Biker[i].product, "")
        end
    end

    -- Special Cargo
    for i = 0, 4 do
        local iWarehouse = GET_WAREHOUSE_PROPERTY_ID(i)
        if iWarehouse > 0 then
            local sp_crate = STAT_GET_INT(ADD_MP_INDEX("CONTOTALFORWHOUSE" .. i))
            local sp_item = STAT_GET_INT(ADD_MP_INDEX("SPCONTOTALFORWHOUSE" .. i))
            local warehouse_name = GET_SPECIAL_CARGO_WAREHOUSE_NAME(iWarehouse)

            local warehouse_cap = BusinessMonitor.Caps.Warehouse[iWarehouse]

            text = sp_crate .. "(" .. sp_item .. ")/" .. warehouse_cap
            if sp_crate >= warehouse_cap then
                text = "[!] " .. text
            end
            menu.set_value(BusinessMonitor.Menu.SpecialCargo[i], text)
            menu.set_menu_name(BusinessMonitor.Menu.SpecialCargo[i], warehouse_name)
        else
            menu.set_value(BusinessMonitor.Menu.SpecialCargo[i], "")
            menu.set_menu_name(BusinessMonitor.Menu.SpecialCargo[i], Labels.None)
        end
    end

    -- Hangar
    if GET_HANGAR_PROPERTY_ID() > 0 then
        product = STAT_GET_INT(ADD_MP_INDEX("HANGAR_CONTRABAND_TOTAL"))
        text = product .. "/" .. BusinessMonitor.Caps.Hangar
        if product >= BusinessMonitor.Caps.Hangar then
            text = "[!] " .. text
        end
        menu.set_value(BusinessMonitor.Menu.Hangar.totalProducts, text)

        local hangar_products = {
            [0] = 0,
            [1] = 0,
            [2] = 0,
            [3] = 0,
            [4] = 0,
            [5] = 0,
            [6] = 0,
            [7] = 0
        }
        for slot = 0, 49 do
            local statIndex = PackedStats.PACKED_MP_INT_HANGAR_PRODUCT_0 + slot
            local model_index = GET_PACKED_STAT_INT_CODE(statIndex)
            if model_index > 0 then
                local good_type = Tables.HangaModelIndexGoodType[model_index]
                hangar_products[good_type] += 1
            end
        end
        for i = 0, 7 do
            menu.set_value(BusinessMonitor.Menu.Hangar[i], hangar_products[i])
        end
    else
        menu.set_value(BusinessMonitor.Menu.Hangar.totalProducts, "")
        for i = 0, 7 do
            menu.set_value(BusinessMonitor.Menu.Hangar[i], "")
        end
    end
end)


menu.divider(Business_Monitor, Labels.Bunker)
BusinessMonitor.Menu.Bunker.supplies = menu.readonly(Business_Monitor, Labels.Supplies)
BusinessMonitor.Menu.Bunker.product = menu.readonly(Business_Monitor, Labels.Product)
BusinessMonitor.Menu.Bunker.research = menu.readonly(Business_Monitor, get_label_text("BUNK_CCTV_2"))

menu.divider(Business_Monitor, Labels.Nightclub)
BusinessMonitor.Menu.Nightclub.popularity = menu.readonly(Business_Monitor, get_label_text("ABH_POPULARITY"))
BusinessMonitor.Menu.Nightclub.safeCash = menu.readonly(Business_Monitor, Labels.Safe)
for i = 0, 6 do
    BusinessMonitor.Menu.Nightclub.product[i] = menu.readonly(Business_Monitor, Tables.NightclubGoodsName[i])
end

menu.divider(Business_Monitor, Labels.AcidLab)
BusinessMonitor.Menu.AcidLab.supplies = menu.readonly(Business_Monitor, Labels.Supplies)
BusinessMonitor.Menu.AcidLab.product = menu.readonly(Business_Monitor, Labels.Product)

menu.divider(Business_Monitor, Labels.Safe)
BusinessMonitor.Menu.SafeCash.arcade = menu.readonly(Business_Monitor, Labels.Arcade)
BusinessMonitor.Menu.SafeCash.agency = menu.readonly(Business_Monitor, Labels.Agency)
BusinessMonitor.Menu.SafeCash.salvageYard = menu.readonly(Business_Monitor, Labels.SalvageYard)


menu.divider(Business_Monitor, "")


local Business_Monitor_Biker = menu.list(Business_Monitor, Labels.MotorcycleClub, {}, "")
BusinessMonitor.Menu.Biker.barEarning = menu.readonly(Business_Monitor_Biker, get_label_text("BBR_BLIP"))
for i = 0, 4 do
    menu.divider(Business_Monitor_Biker, Tables.BikerFactoryName[i])
    BusinessMonitor.Menu.Biker[i] = {
        supplies = menu.readonly(Business_Monitor_Biker, Labels.Supplies),
        product = menu.readonly(Business_Monitor_Biker, Labels.Product)
    }
end


local Business_Monitor_SpecialCargo = menu.list(Business_Monitor, Labels.SpecialCargo, {}, "括号里是特殊物品数量")
for i = 0, 4 do
    BusinessMonitor.Menu.SpecialCargo[i] = menu.readonly(Business_Monitor_SpecialCargo, Labels.None)
end


local Business_Monitor_Hangar = menu.list(Business_Monitor, Labels.Hangar, {}, "")
BusinessMonitor.Menu.Hangar.totalProducts = menu.readonly(Business_Monitor_Hangar, get_label_text("HC_TOTAL_STOCK"))
menu.divider(Business_Monitor_Hangar, get_label_text("HC_STOCK_LEVELS"))
for i = 0, 7 do
    BusinessMonitor.Menu.Hangar[i] = menu.readonly(Business_Monitor_Hangar, Tables.HangarGoodsName[i])
end











local Freemode_Mission <const> = menu.list(Menu_Root, "自由模式任务", {}, "")

----------------------------------------
--    Security Contract (Franklin)
----------------------------------------

local Fixer_Security <const> = menu.list(Freemode_Mission,
    string.format("%s (%s)", get_label_text("FXR_STSTART_T"), get_label_text("PIM_FRANK")), {}, "")

local FixerSecurityVars = {
    iMissionVariation = -1,
    iDifficulty = -1,
    iCashReward = -1,
}

menu.list_select(Fixer_Security, Lang.SelectMission, {}, "", Tables.SecurityContract, -1, function(value)
    FixerSecurityVars.iMissionVariation = value
end)
menu.list_select(Fixer_Security, "选择难度", {}, "", Tables.SecurityContractDifficulty, -1, function(value)
    FixerSecurityVars.iDifficulty = value
end)

menu.textslider(Fixer_Security, Labels.LaunchMission, {}, "", {
    "Request", "Start"
}, function(value)
    local thisDifficulty = FixerSecurityVars.iDifficulty
    if thisDifficulty ~= -1 then
        for iSlot = 0, 2 do
            -- g_sFixerFlow.SecurityContracts[iSlot].Difficulty
            GLOBAL_SET_INT(g_sFixerFlow.SecurityContracts + 1 + iSlot * 3 + 1, thisDifficulty)
        end
    end

    local iMission = 263 -- FMMC_TYPE_FIXER_SECURITY
    local iMissionVariation = FixerSecurityVars.iMissionVariation
    if value == 1 then
        SET_CONTACT_REQUEST_GB_MISSION_LAUNCH_DATA(iMission, iMissionVariation)
    else
        GB_BOSS_REQUEST_MISSION_LAUNCH_FROM_SERVER(iMission, iMissionVariation)
    end
end)

menu.action(Fixer_Security, "直接完成 安保合约", {}, "", function()
    local script = "fm_content_security_contract"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end
    INSTANT_FINISH_FM_CONTENT_MISSION(script)
end)

menu.divider(Fixer_Security, Lang.MissionReward)

rs.menu_slider(Fixer_Security, Lang.CashReward, { "SecurityContractCashReward" }, "", -1, 1000000, -1, 10000,
    function(value)
        FixerSecurityVars.iCashReward = value
    end)
menu.toggle_loop(Fixer_Security, Lang.SetMissionReward, {}, "", function()
    if FixerSecurityVars.iCashReward ~= -1 then
        Tunables.SetIntList("SecurityContractCashReward", FixerSecurityVars.iCashReward)
    end
end, function()
    Tunables.RestoreIntDefaults("SecurityContractCashReward")
end)



----------------------------------------
--    Payphone Hit (Franklin)
----------------------------------------

local Fixer_Payphone <const> = menu.list(Freemode_Mission,
    string.format("%s (%s)", get_label_text("FXR_BM_PH_T"), get_label_text("PIM_FRANK")), {}, "")

local FixerPayphoneVars = {
    iMissionVariation = -1,
    bBounsKill = false,
    iCashReward = -1,
    iBounsCashReward = -1,
}

menu.action(Fixer_Payphone, "请求任务", {}, "显示电话亭图标\n随机暗杀任务", function()
    -- PAYPHONEFLOW_SET_BIT(ePAYPHONEFLOWBITSET_REQUESTED)
    GLOBAL_SET_BIT(g_PayphoneFlow.iBitset + 1 + 0, 0)
end)

menu.list_select(Fixer_Payphone, Lang.SelectMission, {}, "", Tables.PayphoneHit, -1, function(value)
    FixerPayphoneVars.iMissionVariation = value
end)

menu.textslider(Fixer_Payphone, Labels.LaunchMission, {}, "", {
    "Request", "Start"
}, function(value)
    local iMission = 262 -- FMMC_TYPE_FIXER_PAYPHONE
    local iMissionVariation = FixerPayphoneVars.iMissionVariation
    if value == 1 then
        SET_CONTACT_REQUEST_GB_MISSION_LAUNCH_DATA(iMission, iMissionVariation)
    else
        GB_BOSS_REQUEST_MISSION_LAUNCH_FROM_SERVER(iMission, iMissionVariation)
    end
end)

menu.toggle(Fixer_Payphone, "暗杀奖励", {}, "", function(toggle)
    FixerPayphoneVars.bBounsKill = toggle
end)

menu.action(Fixer_Payphone, "直接完成 电话暗杀", {}, "", function()
    local script = "fm_content_payphone_hit"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    if FixerPayphoneVars.bBounsKill then
        -- SET_MISSION_SERVER_BIT(eMISSIONSERVERBITSET_GENERIC_BONUS_KILL_ACTIVE)
        LOCAL_SET_BIT(script, Locals[script].iMissionServerBitSet + 1, 1)
    end

    INSTANT_FINISH_FM_CONTENT_MISSION(script)
end)

menu.divider(Fixer_Payphone, Lang.MissionReward)

-- Payment
rs.menu_slider(Fixer_Payphone, get_label_text("FXR_ENDS_PAY"), { "PayphoneHitCashReward" }, "",
    -1, 1000000, -1, 10000, function(value)
        FixerPayphoneVars.iCashReward = value
    end)
-- Bonus Payment
rs.menu_slider(Fixer_Payphone, get_label_text("FXR_ENDS_BONPAY"), { "PayphoneHitBounsCashReward" }, "",
    -1, 1000000, -1, 10000, function(value)
        FixerPayphoneVars.iBounsCashReward = value
    end)

menu.toggle_loop(Fixer_Payphone, Lang.SetMissionReward, {}, "", function()
    if FixerPayphoneVars.iCashReward ~= -1 then
        Tunables.SetInt("FIXER_PAYPHONE_HIT_STANDARD_KILL_METHOD_CASH_REWARD", FixerPayphoneVars.iCashReward)
    end
    if FixerPayphoneVars.iBounsCashReward ~= -1 then
        Tunables.SetInt("FIXER_PAYPHONE_HIT_BONUS_KILL_METHOD_CASH_REWARD", FixerPayphoneVars.iBounsCashReward)
    end
end, function()
    Tunables.RestoreIntDefault("FIXER_PAYPHONE_HIT_STANDARD_KILL_METHOD_CASH_REWARD")
    Tunables.RestoreIntDefault("FIXER_PAYPHONE_HIT_BONUS_KILL_METHOD_CASH_REWARD")
end)



----------------------------------------
--    Client Jobs (Terrorbyte)
----------------------------------------

local Client_Jobs <const> = menu.list(Freemode_Mission,
    string.format("%s (%s)", get_label_text("HTD_WORK"), Labels.Terrorbyte), {}, "")

local ClientWorkVars = {
    iCashReward = -1
}

-- Robbery in Progress
menu.divider(Client_Jobs, get_label_text("HT_BW_T0"))

menu.textslider(Client_Jobs, Labels.LaunchMission, {}, "", {
    "Request", "Start"
}, function(value)
    local iMission = 242 -- FMMC_TYPE_FMBB_BANK_JOB
    if value == 1 then
        SET_CONTACT_REQUEST_GB_MISSION_LAUNCH_DATA(iMission)
    else
        GB_BOSS_REQUEST_MISSION_LAUNCH_FROM_SERVER(iMission)
    end
end)

menu.action(Client_Jobs, "直接完成 银行劫案", {}, "", function()
    local script = "gb_bank_job"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    LOCAL_SET_BIT(script, Locals[script].iMissionEntityBitSet, 2) -- SET_MISSION_ENTITY_BIT(iMissionEntity, eMISSIONENTITYBITSET_DELIVERED)
    LOCAL_SET_INT(script, Locals[script].eModeState, 7)           -- SET_MODE_STATE(eMODESTATE_REWARDS)
    LOCAL_SET_INT(script, Locals[script].eEndReason, 4)           -- SET_END_REASON(eENDREASON_WIN_CONDITION_TRIGGERED)
end)


-- Data Sweep
menu.divider(Client_Jobs, get_label_text("HT_BW_T1"))

menu.textslider(Client_Jobs, Labels.LaunchMission, {}, "", {
    "Request", "Start"
}, function(value)
    local iMission = 244 -- FMMC_TYPE_FMBB_DATA_HACK
    if value == 1 then
        SET_CONTACT_REQUEST_GB_MISSION_LAUNCH_DATA(iMission)
    else
        GB_BOSS_REQUEST_MISSION_LAUNCH_FROM_SERVER(iMission)
    end
end)

menu.action(Client_Jobs, "直接完成 数据检索", {}, "", function()
    local script = "gb_data_hack"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    LOCAL_SET_INT(script, Locals[script].eEndReason, 6) -- SET_END_REASON(eENDREASON_GOODS_DELIVERED_LAUNCHING_GANG)
end)


menu.divider(Client_Jobs, Lang.MissionReward)

rs.menu_slider(Client_Jobs, Lang.CashReward, { "ClientWorkCashReward" }, "", -1, 1000000, -1, 10000, function(value)
    ClientWorkVars.iCashReward = value
end)
menu.toggle_loop(Client_Jobs, Lang.SetMissionReward, {}, "", function()
    if ClientWorkVars.iCashReward ~= -1 then
        Tunables.SetIntList("ClientWorkCashReward", ClientWorkVars.iCashReward)
    end
end, function()
    Tunables.RestoreIntDefaults("ClientWorkCashReward")
end)


----------------------------------------
--    Fooligan Jobs
----------------------------------------

local Drug_Lab_Work <const> = menu.list(Freemode_Mission, "蠢人帮差事 (达克斯)", {}, "")

local DrugLabWorkVars = {
    iMissionVariation = -1,
    iCashReward = -1,
}

menu.list_select(Drug_Lab_Work, Lang.SelectMission, {}, "", Tables.DrugLabWork, -1, function(value)
    DrugLabWorkVars.iMissionVariation = value
end)

menu.textslider(Drug_Lab_Work, Labels.LaunchMission, {}, "", {
    "Request", "Start"
}, function(value)
    local iMission = 307 -- FMMC_TYPE_DRUG_LAB_WORK
    local iMissionVariation = DrugLabWorkVars.iMissionVariation
    if value == 1 then
        SET_CONTACT_REQUEST_GB_MISSION_LAUNCH_DATA(iMission, iMissionVariation)
    else
        GB_BOSS_REQUEST_MISSION_LAUNCH_FROM_SERVER(iMission, iMissionVariation)
    end
end)

menu.action(Drug_Lab_Work, "直接完成 蠢人帮差事", {}, "", function()
    local script = "fm_content_drug_lab_work"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    INSTANT_FINISH_FM_CONTENT_MISSION(script)
end)


menu.divider(Drug_Lab_Work, Lang.MissionReward)

rs.menu_slider(Drug_Lab_Work, Lang.CashReward, { "DrugLabWorkCashReward" }, "", -1, 1000000, -1, 10000, function(value)
    DrugLabWorkVars.iCashReward = value
end)
menu.toggle_loop(Drug_Lab_Work, Lang.SetMissionReward, {}, "", function()
    if DrugLabWorkVars.iCashReward ~= -1 then
        Tunables.SetInt("XM22_DRUG_LAB_WORK_CASH_REWARD", DrugLabWorkVars.iCashReward)
    end
end, function()
    Tunables.RestoreIntDefault("XM22_DRUG_LAB_WORK_CASH_REWARD")
end)



------------------------------------
--    Casino Work
------------------------------------

local Casino_Work <const> = menu.list(Freemode_Mission, "赌场工作 (贝克女士)", {}, "")

local CasinoWorkVars = {
    iMissionVariation = -1,
    iCashReward = -1,
    iChipReward = -1,
}

menu.list_select(Casino_Work, Lang.SelectMission, {}, "", Tables.CasinoWork, -1, function(value)
    CasinoWorkVars.iMissionVariation = value
end)

menu.textslider(Casino_Work, Labels.LaunchMission, {}, "", {
    "Request", "Start"
}, function(value)
    local iMission = 243 -- FMMC_TYPE_GB_CASINO
    local iMissionVariation = CasinoWorkVars.iMissionVariation
    if value == 1 then
        SET_CONTACT_REQUEST_GB_MISSION_LAUNCH_DATA(iMission, iMissionVariation)
    else
        GB_BOSS_REQUEST_MISSION_LAUNCH_FROM_SERVER(iMission, iMissionVariation)
    end
end)

menu.action(Casino_Work, "直接完成 赌场工作", {}, "", function()
    local script = "gb_casino"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local eMissionVariation = LOCAL_GET_INT(script, 2845 + 1321)
    if eMissionVariation == 14 then -- CSV_TRACKING_CHIPS
        for i = 0, 4 do
            -- SET_FIND_ITEM_BIT(iChip, eFINDITEMBITSET_COLLECTED)
            LOCAL_SET_BIT(script, 2845 + 1573 + 1 + i, 1)
        end
    end

    local iNumEntitiesThisVariation = LOCAL_GET_INT(script, 2845 + 1541)
    local partId = NETWORK.NETWORK_GET_PARTICIPANT_INDEX(players.user())
    for i = 0, iNumEntitiesThisVariation - 1, 1 do
        -- SET_MISSION_ENTITY_BIT(iMissionEntity, eMISSIONENTITYBITSET_DELIVERED)
        LOCAL_SET_BIT(script, 2845 + 63 + 1 + i * 3 + 1 + 0, 4)

        -- SET_MISSION_ENTITY_CLIENT_BIT(iMissionEntity, NETWORK_GET_PARTICIPANT_INDEX(playerID), eMISSIONENTITYCLIENTBITSET_MY_GANG_DELIVERED_MISSION_ENTITY)
        LOCAL_SET_BIT(script, 4517 + 1 + partId * 266 + 9 + 1 + i * 3 + 1 + 1, 3)
    end

    LOCAL_SET_INT(script, 2845 + 1324, 3)  -- SET_END_REASON(eENDREASON_MISSION_ENTITY_DELIVERED)
    LOCAL_SET_INT(script, 2845 + 1323, 33) -- SET_MODE_STATE(eMODESTATE_REWARDS)
end)


menu.toggle_loop(Casino_Work, "Show Info", {}, "", function()
    local script = "gb_casino"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local eMissionVariation = LOCAL_GET_INT(script, 2845 + 1321)
    local iNumEntitiesThisVariation = LOCAL_GET_INT(script, 2845 + 1541)
    local partId = NETWORK.NETWORK_GET_PARTICIPANT_INDEX(players.user())

    local text = string.format(
        "eMissionVariation: %s\niNumEntitiesThisVariation: %s\npartId: %s",

        eMissionVariation, iNumEntitiesThisVariation, partId
    )

    draw_text(text)
end)


menu.divider(Casino_Work, Lang.MissionReward)

rs.menu_slider(Casino_Work, Lang.CashReward, { "CasinoWorkCashReward" }, "", -1, 1000000, -1, 10000, function(value)
    CasinoWorkVars.iCashReward = value
end)
rs.menu_slider(Casino_Work, "筹码奖励", { "CasinoWorkChipReward" }, "", -1, 1000000, -1, 10000, function(value)
    CasinoWorkVars.iChipReward = value
end)
menu.toggle_loop(Casino_Work, Lang.SetMissionReward, {}, "", function()
    if CasinoWorkVars.iCashReward ~= -1 then
        Tunables.SetInt("VC_WORK_CASH_REWARD", CasinoWorkVars.iCashReward)
    end
    if CasinoWorkVars.iChipReward ~= -1 then
        Tunables.SetInt("VC_WORK_CHIP_REWARD", CasinoWorkVars.iChipReward)
    end
end, function()
    Tunables.RestoreIntDefault("VC_WORK_CASH_REWARD")
    Tunables.RestoreIntDefault("VC_WORK_CHIP_REWARD")
end)



------------------------------------
--    Stash House
------------------------------------

local Stash_House <const> = menu.list(Freemode_Mission, get_label_text("SH_BIGM_T"), {}, "")

menu.action(Stash_House, "传送到 藏匿屋", {}, "", function()
    local blip = HUD.GET_NEXT_BLIP_INFO_ID(845)
    if HUD.DOES_BLIP_EXIST(blip) then
        local coords = HUD.GET_BLIP_COORDS(blip)
        TELEPORT(coords)
    else
        util.toast("未在地图上找到 藏匿屋")
    end
end)
menu.action(Stash_House, Labels.LaunchMission, {}, "", function()
    -- FMMC_TYPE_STASH_HOUSE
    GB_BOSS_REQUEST_MISSION_LAUNCH_FROM_SERVER(308)
end)
menu.action(Stash_House, "直接完成 藏匿屋", {}, "", function()
    local script = "fm_content_stash_house"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end
    INSTANT_FINISH_FM_CONTENT_MISSION(script)
end)



------------------------------------
--    Auto Shop Service
------------------------------------

local Auto_Shop_Service <const> = menu.list(Freemode_Mission, get_label_text("TDEL_ES_T"), {}, "")

menu.action(Auto_Shop_Service, "获得新的客户载具", {}, "在改装铺外面生效", function()
    local script = "shop_controller"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    STAT_SET_INT(ADD_MP_INDEX("TUNER_CLIENT_VEHICLE_POSSIX"), 0)

    LOCAL_SET_INT(script, Locals[script].iAutoShopRandomTime, 0)
    -- LOCAL_BIT_SET_AUTO_SHOP_RAND_TIME, LOCAL_BIT_SHOULD_GIVE_VEHICLE_THIS_TIME
    LOCAL_SET_BITS(script, Locals[script].iLocalBS, 0, 1)
end)

menu.action(Auto_Shop_Service, "跳过客户载具改装", {}, "在改装铺内部生效", function()
    -- MP_SAVED_TUNER_VEHICLE_CLIENT_BODYWORK_DONE          0
    -- MP_SAVED_TUNER_VEHICLE_CLIENT_PERFORMANCE_DONE       1
    -- MP_SAVED_TUNER_VEHICLE_CLIENT_SERVICE_DONE           2
    -- MP_SAVED_TUNER_VEHICLE_CLIENT_WHEELS_DONE            3
    -- MP_SAVED_TUNER_VEHICLE_CLIENT_PRIMARY_COLOR_DONE     4

    for i = 0, 1 do
        -- g_sClientVehicleSetupStruct[GET_TUNER_CLIENT_VEHICLE_SLOT()].iVehicleBS
        GLOBAL_SET_BITS(g_sClientVehicleSetupStruct + 1 + i * 106 + 105, 0, 1, 2, 3, 4)
    end
end)

menu.action(Auto_Shop_Service, "直接完成 改装铺服务", {}, "", function()
    local script = "fm_content_auto_shop_delivery"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
    end

    local iMissionEntity = 0
    LOCAL_SET_BIT(script, Locals[script].iMissionEntityBitSet + 1 + iMissionEntity * 3 + 1 + 0, 4) -- eMISSIONENTITYBITSET_DELIVERED
    INSTANT_FINISH_FM_CONTENT_MISSION(script)
end)


menu.divider(Auto_Shop_Service, Lang.MissionReward)

local AutoShopServiceVars = {
    iCashReward = -1,
    iBonusAmount = -1,
}

-- Payment for Delivery
rs.menu_slider(Auto_Shop_Service, get_label_text("TDEL_ES_PAY"), { "AutoShopServiceCashReward" }, "",
    -1, 1000000, -1, 1000, function(value)
        AutoShopServiceVars.iCashReward = value
    end)

-- Satisfaction
rs.menu_slider(Auto_Shop_Service, get_label_text("TDEL_ES_SAT"), { "AutoShopServiceBonusAmount" }, "",
    -1, 1000000, -1, 1000, function(value)
        AutoShopServiceVars.iBonusAmount = value
    end)

menu.toggle_loop(Auto_Shop_Service, Lang.SetMissionReward, {}, Lang.E_B_S_M, function()
    if AutoShopServiceVars.iCashReward ~= -1 then
        Tunables.SetIntList("TunerClientVehicleDeliveryPayment", AutoShopServiceVars.iCashReward)
    end
    if AutoShopServiceVars.iBonusAmount ~= -1 then
        Tunables.SetIntList("TunerClientVehicleBouns", AutoShopServiceVars.iBonusAmount)
    end
end, function()
    Tunables.RestoreIntDefaults("TunerClientVehicleDeliveryPayment")
    Tunables.RestoreIntDefaults("TunerClientVehicleBouns")
end)



------------------------------------
--    Bike Service
------------------------------------

local Bike_Service <const> = menu.list(Freemode_Mission, get_label_text("BSDEL_ES_T"), {}, "")

menu.action(Bike_Service, "获得新的客户载具", {}, "在摩托帮会所外面生效", function()
    local script = "shop_controller"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    STAT_SET_INT(ADD_MP_INDEX("BIKER_CLIENT_VEHICLE_POSSIX"), 0)

    LOCAL_SET_INT(script, Locals[script].iBikerShopRandomTime, 0)
    -- LOCAL_BIT_SET_BIKER_SHOP_RAND_TIME, LOCAL_BIT_BIKER_CLIENT_GIVE_VEHICLE_THIS_TIME
    LOCAL_SET_BITS(script, Locals[script].iLocalBS, 11, 12)
end)

menu.action(Bike_Service, "跳过客户载具改装", {}, "在摩托帮会所内部生效", function()
    -- MP_SAVED_TUNER_VEHICLE_CLIENT_BODYWORK_DONE          0
    -- MP_SAVED_TUNER_VEHICLE_CLIENT_PERFORMANCE_DONE       1
    -- MP_SAVED_TUNER_VEHICLE_CLIENT_SERVICE_DONE           2
    -- MP_SAVED_TUNER_VEHICLE_CLIENT_WHEELS_DONE            3
    -- MP_SAVED_TUNER_VEHICLE_CLIENT_PRIMARY_COLOR_DONE     4

    -- g_sBikerClientVehicleSetupStruct.iVehicleBS
    GLOBAL_SET_BITS(g_sBikerClientVehicleSetupStruct + 105, 0, 1, 2, 3, 4)
end)

menu.action(Bike_Service, "直接完成 摩托车服务", {}, "", function()
    local script = "fm_content_bike_shop_delivery"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
    end

    local iMissionEntity = 0
    LOCAL_SET_BIT(script, Locals[script].iMissionEntityBitSet + 1 + iMissionEntity * 3 + 1 + 0, 4) -- eMISSIONENTITYBITSET_DELIVERED
    INSTANT_FINISH_FM_CONTENT_MISSION(script)
end)

menu.divider(Bike_Service, Lang.MissionReward)

local BikeServiceVars = {
    iCashReward = -1,
    iBonusAmount = -1,
}

-- Payment for Delivery
rs.menu_slider(Bike_Service, get_label_text("BSDEL_ES_PAY"), { "BikeServiceCashReward" }, "",
    -1, 1000000, -1, 1000, function(value)
        BikeServiceVars.iCashReward = value
    end)

-- Satisfaction
rs.menu_slider(Bike_Service, get_label_text("BSDEL_ES_SAT"), { "BikeServiceBonusAmount" }, "",
    -1, 1000000, -1, 1000, function(value)
        BikeServiceVars.iBonusAmount = value
    end)

menu.toggle_loop(Bike_Service, Lang.SetMissionReward, {}, Lang.E_B_S_M, function()
    if BikeServiceVars.iCashReward ~= -1 then
        Tunables.SetInt("CUSTOMER_BIKE_DELIVERY_DEFAULT_CASH_BONUS_REWARD", BikeServiceVars.iCashReward)
    end
    if BikeServiceVars.iBonusAmount ~= -1 then
        Tunables.SetIntList("BikerClientVehicleBouns", BikeServiceVars.iBonusAmount)
    end
end, function()
    Tunables.RestoreIntDefault("CUSTOMER_BIKE_DELIVERY_DEFAULT_CASH_BONUS_REWARD")
    Tunables.RestoreIntDefaults("BikerClientVehicleBouns")
end)




------------------------------------
--    Time Trial
------------------------------------

local Time_Trial <const> = menu.list(Freemode_Mission, get_label_text("PIM_CM_TT"), {}, "")

local TimeTrialParTime = {
    [0] = 103200,
    [1] = 124400,
    [2] = 124900,
    [3] = 46300,
    [4] = 249500,
    [5] = 104000,
    [6] = 38500,
    [7] = 70100,
    [8] = 135000,
    [9] = 127200,
    [10] = 101300,
    [11] = 77800,
    [12] = 58800,
    [13] = 149400,
    [14] = 60000,
    [15] = 79000,
    [16] = 103400,
    [17] = 84200,
    [18] = 178800,
    [19] = 86600,
    [20] = 76600,
    [21] = 54200,
    [22] = 100000,
    [23] = 125000,
    [24] = 120000,
    [25] = 155000,
    [26] = 80000,
    [27] = 144000,
    [28] = 136000,
    [29] = 110000,
    [30] = 86000,
    [31] = 130000
}

menu.divider(Time_Trial, get_label_text("PIM_CM_TT"))

menu.action(Time_Trial, "传送到 时间挑战赛", {}, "", function()
    local blip = HUD.GET_NEXT_BLIP_INFO_ID(430)
    if HUD.DOES_BLIP_EXIST(blip) then
        local coords = HUD.GET_BLIP_COORDS(blip)
        TELEPORT(coords)
    else
        util.toast("未在地图上找到")
    end
end)

menu.textslider(Time_Trial, "重置本周挑战记录", {}, "", {
    "首次挑战奖励", "个人最佳时间"
}, function(value)
    if value == 1 then
        STAT_SET_INT("MPPLY_TIMETRIAL_COMPLETED_WEEK", -1)
    else
        STAT_SET_INT("MPPLY_TIMETRIALBESTTIME", 0)

        local script = "freemode"
        if IS_SCRIPT_RUNNING(script) then
            LOCAL_SET_INT(script, sTTVarsStruct.iPersonalBest, HIGHEST_INT)
        end
    end
end)

menu.action(Time_Trial, "直接完成 时间挑战赛", {}, "", function()
    local script = "freemode"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    if LOCAL_GET_INT(script, sTTVarsStruct.eAMTT_Stage) == 3 then -- AMTT_GOTO
        local iVariation = LOCAL_GET_INT(script, sTTVarsStruct.iVariation)
        local iParTime = TimeTrialParTime[iVariation]
        if iParTime == nil then
            iParTime = 1000 -- 1s
        else
            iParTime = iParTime - 1000
        end
        local iStartTime = NETWORK.GET_NETWORK_TIME() - iParTime

        LOCAL_SET_INT(script, sTTVarsStruct.trialTimer, iStartTime)
        LOCAL_SET_INT(script, sTTVarsStruct.eAMTT_Stage, 4) -- AMTT_END
    end
end)



------------------------------------
--    RC Bandito Time Trial
------------------------------------

menu.divider(Time_Trial, get_label_text("PIM_TTSERI"))

local RCTimeTrialParTime = {
    [0] = 110000,
    [1] = 90000,
    [2] = 80000,
    [3] = 87000,
    [4] = 70000,
    [5] = 92000,
    [6] = 125000,
    [7] = 72000,
    [8] = 113000,
    [9] = 80000,
    [10] = 83000,
    [11] = 78000,
    [12] = 87000,
    [13] = 82000,
}

menu.action(Time_Trial, "传送到 RC匪徒时间挑战赛", {}, "", function()
    local blip = HUD.GET_NEXT_BLIP_INFO_ID(673)
    if HUD.DOES_BLIP_EXIST(blip) then
        local coords = HUD.GET_BLIP_COORDS(blip)
        TELEPORT(coords)
    else
        util.toast("未在地图上找到")
    end
end)

menu.textslider(Time_Trial, "重置本周挑战记录", {}, "", {
    "已经挑战成功", "个人最佳时间"
}, function(value)
    if value == 1 then
        STAT_SET_INT("MPPLY_RCTTCOMPLETEDWEEK", -1)
        util.toast("需要切换战局才能刷新")
    else
        STAT_SET_INT("MPPLY_RCTTBESTTIME", 0)

        local script = "freemode"
        if IS_SCRIPT_RUNNING(script) then
            LOCAL_SET_INT(script, sRCTTVarsStruct.iPersonalBest, HIGHEST_INT)
        end
    end
end)

menu.action(Time_Trial, "直接完成 RC匪徒时间挑战赛", {}, "", function()
    local script = "freemode"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    if LOCAL_GET_INT(script, sRCTTVarsStruct.eRunStage) == 4 then -- ARS_TRIAL
        local eVariation = LOCAL_GET_INT(script, sRCTTVarsStruct.eVariation)
        local iParTime = RCTimeTrialParTime[eVariation]
        if iParTime == nil then
            iParTime = 1000 -- 1s
        else
            iParTime = iParTime - 1000
        end
        local iStartTime = NETWORK.GET_NETWORK_TIME() - iParTime

        LOCAL_SET_INT(script, sRCTTVarsStruct.timerTrial, iStartTime)
        LOCAL_SET_INT(script, sRCTTVarsStruct.eRunStage, 6) -- ARS_END
    end
end)



------------------------------------
--    Salvage Yard Robbery
------------------------------------

-- local Salvage_Yard_Robbery <const> = menu.list(Freemode_Mission, get_label_text("SCOUT_BIG_START"), {}, "")







------------------------
--    Other
------------------------

menu.action(Freemode_Mission, "完成每日挑战", {}, "", function()
    COMPLETE_DAILY_CHALLENGE()
end)

menu.textslider(Freemode_Mission, "每周挑战", {},
    "点击完成后，等待一会", { "Complete", "Reset" }, function(value)
        if value == 1 then
            bComplete = true
        end
        COMPLETE_WEEKLY_CHALLENGE(bComplete)
    end)






--------------------------------
--    Heist Mission
--------------------------------

local Heist_Mission <const> = menu.list(Menu_Root, "抢劫任务", {}, "")


MissionMinPlayers = menu.toggle_loop(Heist_Mission, "最小玩家数为1", {}, "强制任务单人可开", function()
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
    GLOBAL_SET_INT(FMMC_STRUCT.iNumPlayersPerTeam, 1)
    GLOBAL_SET_INT(FMMC_STRUCT.iCriticalMinimumForTeam, 0)
    -- for i = 0, 3 do
    --     GLOBAL_SET_INT(FMMC_STRUCT.iNumPlayersPerTeam + i, 1)
    --     GLOBAL_SET_INT(FMMC_STRUCT.iCriticalMinimumForTeam + i, 0)
    -- end
end)

MissionMaxTeams = menu.toggle_loop(Heist_Mission, "最大团队数为1", {}, "用于多团队任务", function()
    GLOBAL_SET_INT(FMMC_STRUCT.iNumberOfTeams, 1)
    GLOBAL_SET_INT(FMMC_STRUCT.iMaxNumberOfTeams, 1)
end)

menu.click_slider(Heist_Mission, "设置最大团队数", {}, "", 1, 4, 2, 1, function(value)
    menu.set_value(MissionMaxTeams, false)

    GLOBAL_SET_INT(FMMC_STRUCT.iNumberOfTeams, value)
    GLOBAL_SET_INT(FMMC_STRUCT.iMaxNumberOfTeams, value)
end)



--------------------------------
--    Heist Mission Helper
--------------------------------

local Heist_Mission_Helper <const> = menu.list(Heist_Mission, "抢劫任务助手", {}, "")

--#region Heist Mission Helper

menu.action(Heist_Mission_Helper, "跳到下一个检查点", { "SkipNextObjective" }, "解决单人进行任务卡关问题", function()
    FMMC_SCRIPT(function(script)
        -- SBBOOL1_PROGRESS_OBJECTIVE_FOR_TEAM_0
        LOCAL_SET_BIT(script, Locals[script].iServerBitSet1, 17)
    end, true)
end)

menu.list_action(Heist_Mission_Helper, "更改任务难度", { "mcDifficulity" }, "", {
    { 0, get_label_text("LBD_DIF_0"), { "easy" } },   -- DIFF_EASY
    { 1, get_label_text("LBD_DIF_1"), { "normal" } }, -- DIFF_NORMAL
    { 2, get_label_text("LBD_DIF_2"), { "hard" } }    -- DIFF_HARD
}, function(value)
    GLOBAL_SET_INT(FMMC_STRUCT.iDifficulity, value)
end)

menu.toggle_loop(Heist_Mission_Helper, "禁止因触发惊动而任务失败", {}, "", function()
    FMMC_SCRIPT(function(script)
        -- SBBOOL1_AGGRO_TRIGGERED_FOR_TEAM_0, SBBOOL1_AGGRO_WILL_FAIL_FOR_TEAM_0
        LOCAL_CLEAR_BITS(script, Locals[script].iServerBitSet1, 24, 28)
    end, true)
end)

menu.toggle_loop(Heist_Mission_Helper, "禁止任务失败", {}, "", function()
    FMMC_SCRIPT(function(script)
        -- LBOOL11_STOP_MISSION_FAILING_DUE_TO_EARLY_CELEBRATION
        LOCAL_SET_BIT(script, Locals[script].iLocalBoolCheck11, 7)
    end, true)
end)

menu.click_slider(Heist_Mission_Helper, "增加团队生命数", { "mcTeamLives" }, "", -1, 30000, 0, 1, function(value)
    FMMC_SCRIPT(function(script)
        for i = 0, 3 do
            LOCAL_SET_INT(script, Locals[script].iAdditionalTeamLives + i, value)
        end
    end, true)
end)


menu.click_slider(Heist_Mission_Helper, "设置任务剩余时间", { "mcTimeDuration" }, "单位：分钟\n右下角的剩余时间倒计时",
    0, 600, 20, 10, function(value)
        FMMC_SCRIPT(function(script)
            local team = PLAYER.GET_PLAYER_TEAM(players.user())

            LOCAL_SET_INT(script, Locals[script].iMultiObjectiveTimeLimit + team, value * 60 * 1000)
        end, true)
    end)
menu.toggle_loop(Heist_Mission_Helper, "锁定任务剩余时间", { "mcTimeLock" }, "右下角的剩余时间倒计时", function()
    FMMC_SCRIPT(function(script)
        local team = PLAYER.GET_PLAYER_TEAM(players.user())

        if LOCAL_GET_BOOL(script, Locals[script].tdObjectiveLimitTimer + team * 2 + 1) then
            LOCAL_SET_INT(script, Locals[script].tdObjectiveLimitTimer + team * 2, NETWORK.GET_NETWORK_TIME())
        end
        if LOCAL_GET_BOOL(script, Locals[script].tdMultiObjectiveLimitTimer + team * 2 + 1) then
            LOCAL_SET_INT(script, Locals[script].tdMultiObjectiveLimitTimer + team * 2, NETWORK.GET_NETWORK_TIME())
        end
    end, true)
end)



local HeistMissionVehicle = {
    get_driver_name = function(vehicle)
        local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1, false)

        if entities.is_player_ped(driver) then
            return players.get_name(NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(driver))
        end

        local driver_hash = ENTITY.GET_ENTITY_MODEL(driver)
        local driver_model = util.reverse_joaat(driver_hash)
        if driver_model == "" then
            return driver_hash
        end
        return driver_model
    end
}

local Heist_Mission_Vehicle
Heist_Mission_Vehicle = menu.list(Heist_Mission_Helper, "管理任务载具", {}, "", function()
    local menu_children = menu.get_children(Heist_Mission_Vehicle)
    if #menu_children > 0 then
        for _, command in pairs(menu_children) do
            menu.delete(command)
        end
    end

    local script = GET_RUNNING_MISSION_CONTROLLER_SCRIPT()
    if script == nil then
        return
    end

    for _, vehicle in pairs(entities.get_all_vehicles_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(vehicle) then
            local entity_script = GET_ENTITY_SCRIPT(vehicle)
            if entity_script == script then
                local display_name = VEHICLE.GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(ENTITY.GET_ENTITY_MODEL(vehicle))
                local menu_name = get_label_text(display_name)
                local help_text = ""

                if not VEHICLE.IS_VEHICLE_SEAT_FREE(vehicle, -1, false) then
                    help_text = help_text .. "Driver: " .. HeistMissionVehicle.get_driver_name(vehicle)
                end

                local blip = HUD.GET_BLIP_FROM_ENTITY(vehicle)
                if HUD.DOES_BLIP_EXIST(blip) then
                    local blip_sprite = HUD.GET_BLIP_SPRITE(blip)
                    if blip_sprite == 1 then
                        menu_name = menu_name .. " [Objective]"
                    else
                        menu_name = menu_name .. " [Blip]"
                    end

                    local blip_colour = HUD.GET_BLIP_COLOUR(blip)
                    if blip_colour == 54 then
                        help_text = help_text .. "\nBLIP_COLOUR_BLUEDARK"
                    end
                end

                if vehicle == PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false) then
                    if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), false) then
                        menu_name = menu_name .. " [Current Vehicle]"
                    else
                        menu_name = menu_name .. " [Last Vehicle]"
                    end
                end


                menu.list_action(Heist_Mission_Vehicle, menu_name, {}, help_text, {
                    { 1, "传送到我并驾驶" },
                    { 2, "传送进驾驶位" },
                    { 3, "传送进空座位" },
                }, function(value)
                    if not ENTITY.DOES_ENTITY_EXIST(vehicle) then
                        return
                    end

                    if value == 1 then
                        TP_VEHICLE_TO_ME(vehicle)
                    elseif value == 2 then
                        TP_INTO_VEHICLE(vehicle, true)
                    elseif value == 3 then
                        TP_INTO_VEHICLE(vehicle)
                    end
                end)
            end
        end
    end
end)


--#endregion




menu.action(Heist_Mission, "重新加载抢劫计划面板", { "ReloadHeistBoard" }, "无需再重新进入室内来刷新面板了", function()
    if not INTERIOR.IS_INTERIOR_SCENE() then
        return
    end

    if GLOBAL_GET_INT(g_HeistPrePlanningClient.eHeistFlowState) ~= -1 then
        -- SET_HEIST_PREPLAN_STATE(HEIST_PRE_FLOW_CLEANUP)
        GLOBAL_SET_INT(g_HeistPrePlanningClient.eHeistFlowState, 22)
    end

    local script_data = {
        ["gb_casino_heist_planning"] = 2,
        ["gb_gang_ops_planning"] = 6,
        ["heist_island_planning"] = 2,
        ["tuner_planning"] = 2,
        ["vehrob_planning"] = 2,
    }
    for script, value in pairs(script_data) do
        if IS_SCRIPT_RUNNING(script) then
            -- SET_SCRIPT_STAGE(STAGE_CLEANUP)
            LOCAL_SET_INT(script, Locals[script].iScriptStage, value)
        end
    end
end)

menu.action(Heist_Mission, "直接完成任务 (通用)", { "InsFinJob" }, "联系人任务", function()
    menu.trigger_commands("scripthost")
    INSTANT_FINISH_FM_MISSION_CONTROLLER()
end)

menu.action(Heist_Mission, "成为任务脚本主机", { "fmmcHost" }, "", function()
    local script = GET_RUNNING_MISSION_CONTROLLER_SCRIPT()
    if script == nil then
        return
    end


    if util.request_script_host(script) then
        util.toast("成为任务脚本主机 成功")
    else
        util.toast("成为任务脚本主机 失败")
    end
end)






menu.divider(Heist_Mission, "")

local function HANDLE_HEIST_ELITE_CHALLENGE(script, eEliteChallenge)
    if eEliteChallenge == 0 then
        return
    end
    if eEliteChallenge == 2 then
        GLOBAL_SET_BOOL(g_TransitionSessionNonResetVars.bHasQuickRestartedDuringStrandMission, true)
        return
    end

    GLOBAL_SET_BOOL(g_TransitionSessionNonResetVars.bHasQuickRestartedDuringStrandMission, false)

    GLOBAL_SET_INT(FMMC_STRUCT.iDifficulity, DIFF_HARD)
    LOCAL_SET_INT(script, Locals[script].iTeamKills, 150)
    LOCAL_SET_INT(script, Locals[script].iTeamHeadshots, 150)
end

--------------------------------
--    Apartment Heist
--------------------------------

local Apartment_Heist <const> = menu.list(Heist_Mission, "公寓抢劫", {}, "")


menu.divider(Apartment_Heist, Labels.PREP)

local Apartment_Heist_Prep <const> = menu.list(Apartment_Heist, "前置编辑", {}, "跳过前置任务")

menu.textslider(Apartment_Heist, "全部前置", {}, "", Tables.CompleteReset, function(value)
    if value == 1 then
        STAT_SET_INT(ADD_MP_INDEX("HEIST_PLANNING_STAGE"), -1)
    else
        STAT_SET_INT(ADD_MP_INDEX("HEIST_PLANNING_STAGE"), 0)
    end
    util.toast("写入完成, 你可能需要重新进入公寓来刷新面板")
end)

local Apartment_Heist_Prep_Mission <const> = menu.list(Apartment_Heist, "前置任务编辑", {}, "自定义前置进行哪些任务")

menu.toggle_loop(Apartment_Heist, "所有前置任务可开启", {}, "取消任务面板灰色不可开启状态\n需要刷新面板", function()
    GLOBAL_SET_INT(g_HeistPrePlanningClient.iCurrentBoardDepth, 9)
end)


menu.divider(Apartment_Heist, Labels.FINALE)

local ApartmentHeistVars = {
    eEliteChallenge = 0,
    iCashReward = -1,
    iCashTotalTake = -1,
}

menu.list_action(Apartment_Heist, "完成奖章挑战", {}, "进行任务时使用", Tables.HeistAwards, function(value)
    local script = "fm_mission_controller"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    if value == 3 then
        -- Ultimate Challenge
        GLOBAL_SET_INT(FMMC_STRUCT.iDifficulity, DIFF_HARD)
    elseif value == 4 then
        -- First Person
        GLOBAL_SET_INT(FMMC_STRUCT.iFixedCamera, 1)
    elseif value == 5 then
        -- Member
        GLOBAL_SET_BOOL(g_TransitionSessionNonResetVars.bAmIHeistLeader, false)
        LOCAL_CLEAR_BIT(script, Locals[script].iClientBitSet(), 20) -- PBBOOL_HEIST_HOST
    end

    local HeistAwardCompleteBitset = 268435455 -- 2^28-1
    local stats = Tables.HeistAwardsStats[value]
    STAT_SET_INT(stats[1], HeistAwardCompleteBitset)
end)

menu.list_action(Apartment_Heist, "清空奖章挑战记录", {}, "", Tables.HeistAwards, function(value)
    local stats = Tables.HeistAwardsStats[value]
    STAT_SET_INT(stats[1], 0)
    STAT_SET_BOOL(stats[2], false)

    if value == 2 then
        -- Same Team
        STAT_SET_INT("MPPLY_HEISTTEAMPROGRESSCOUNTER", 0)
    end
end)


menu.list_select(Apartment_Heist, Labels.EliteChallenge, {}, "", Tables.EliteChallenge, 0, function(value)
    ApartmentHeistVars.eEliteChallenge = value
end)

rs.menu_slider(Apartment_Heist, "终章收入奖励", { "ApartmentHeistCashReward" },
    "困难模式*1.25\n" .. Lang.O_W_F_INS_FIN,
    -1, 10000000, -1, 50000, function(value)
        ApartmentHeistVars.iCashReward = value
    end)

rs.menu_slider(Apartment_Heist, "拿取财物收入", { "ApartmentHeistTotalTake" },
    "用于太平洋标准银行抢劫\n" .. Lang.O_W_F_INS_FIN,
    -1, 10000000, -1, 50000, function(value)
        ApartmentHeistVars.iCashTotalTake = value
    end)

menu.action(Apartment_Heist, "直接完成 公寓抢劫", {}, "", function()
    local script = "fm_mission_controller"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    if ApartmentHeistVars.iCashReward ~= -1 then
        Tunables.SetIntList("HeistFinalCashReward", ApartmentHeistVars.iCashReward)
    end
    if ApartmentHeistVars.iCashTotalTake ~= -1 then
        LOCAL_SET_INT(script, Locals[script].iCashGrabTotalTake, ApartmentHeistVars.iCashTotalTake)
    end

    HANDLE_HEIST_ELITE_CHALLENGE(script, ApartmentHeistVars.eEliteChallenge)

    INSTANT_FINISH_FM_MISSION_CONTROLLER()
end)

menu.divider(Apartment_Heist, "")

menu.list_action(Apartment_Heist, "启动差事: 抢劫任务 终章", {},
    "1. 需要在公寓内部 抢劫计划面板附近\n2. 启动差事后右下角没有提示下载，就动两下", {
        { 1, Labels.TheFleecaJob },
        { 2, Labels.ThePrisonBreak },
        { 3, Labels.TheHumaneLabsRaid },
        { 4, Labels.SeriesAFunding },
        { 5, Labels.ThePacificStandardJob }
    }, function(value)
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

        local ContentID = Tables.HeistFinalContentID[value]
        LAUNCH_APARTMENT_HEIST(ContentID)
        util.toast("请稍等...")
    end)




--------------------------------
--    The Doomsday Heist
--------------------------------

local Doomsday_Heist <const> = menu.list(Heist_Mission, get_label_text("FMMC_RSTAR_MHS2"), {}, "")

menu.divider(Doomsday_Heist, Labels.PREP)

local Doomsday_Heist_Prep <const> = menu.list(Doomsday_Heist, "前置编辑", {}, "")

menu.action(Doomsday_Heist, "直接完成 末日豪劫 前置任务", {}, "", function()
    local script = "gb_gangops"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    LOCAL_SET_INT(script, Locals[script].iPhotosTaken, 10) -- ciAMATEUR_PHOTOGRAPHY_MAX_PHOTOS

    local iNumEntitiesThisVariation = LOCAL_GET_INT(script, Locals[script].iNumEntitiesThisVariation)
    for i = 0, iNumEntitiesThisVariation - 1, 1 do
        LOCAL_SET_BIT(script, Locals[script].iMissionEntityBitSet + 1 + i * 3 + 1 + 0, 6) -- SET_MISSION_ENTITY_BIT(iMissionEntity, eMISSIONENTITYBITSET_DELIVERED)
    end

    LOCAL_SET_INT(script, Locals[script].eEndReason, 3)  -- SET_END_REASON(eENDREASON_MISSION_ENTITY_DELIVERED)
    LOCAL_SET_INT(script, Locals[script].eModeState, 24) -- SET_MODE_STATE(eMODESTATE_REWARDS)
end)


menu.divider(Doomsday_Heist, Labels.FINALE)

local DoomsdayHeistVars = {
    eEliteChallenge = 0,
    iCashReward = -1,
}

menu.list_action(Doomsday_Heist, "完成奖章挑战", {}, "进行任务时使用\n不是全部有效", Tables.GangopsAwards, function(value)
    local script = "fm_mission_controller"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local GangopsAwardCompleteBitset = 536870911 -- 2^29-1
    local stats = Tables.GangopsAwardsStats[value]
    STAT_SET_INT(stats[1], GangopsAwardCompleteBitset)

    GLOBAL_SET_INT(FMMC_STRUCT.iDifficulity, DIFF_HARD)
    GLOBAL_SET_INT(g_TransitionSessionNonResetVars.bAnyPlayerDiedDuringMission, 0)
end)

menu.list_action(Doomsday_Heist, "清空奖章挑战记录", {}, "", Tables.GangopsAwards, function(value)
    local stats = Tables.GangopsAwardsStats[value]
    STAT_SET_INT(stats[1], 0)
    STAT_SET_BOOL(stats[2], false)
end)


menu.list_select(Doomsday_Heist, Labels.EliteChallenge, {}, "", Tables.EliteChallenge, 0, function(value)
    DoomsdayHeistVars.eEliteChallenge = value
end)


rs.menu_slider(Doomsday_Heist, "终章收入奖励", { "DoomsdayHeistCashReward" },
    "困难模式*1.25\n" .. Lang.O_W_F_INS_FIN,
    -1, 10000000, -1, 50000, function(value)
        DoomsdayHeistVars.iCashReward = value
    end)

menu.action(Doomsday_Heist, "直接完成 末日豪劫", {}, "", function()
    local script = "fm_mission_controller"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    if DoomsdayHeistVars.iCashReward ~= -1 then
        Tunables.SetIntList("GangopsFinalCashReward", DoomsdayHeistVars.iCashReward)
    end

    HANDLE_HEIST_ELITE_CHALLENGE(script, DoomsdayHeistVars.eEliteChallenge)

    INSTANT_FINISH_FM_MISSION_CONTROLLER()
end)

menu.divider(Doomsday_Heist, "")

menu.list_action(Doomsday_Heist, "启动差事: 末日豪劫 终章", {}, "", Tables.DoomsdayHeistFinalRootContent, function(value)
    if IS_MISSION_CONTROLLER_SCRIPT_RUNNING() then
        return
    end

    if GET_FACILITY_PROPERTY_ID() <= 0 then
        util.toast("你需要拥有设施")
        return
    end
    if not IS_PLAYER_BOSS_OF_A_GANG() then
        util.toast("你需要注册为老大")
        return
    end
    if INTERIOR.GET_INTERIOR_FROM_ENTITY(players.user_ped()) ~= 269313 then
        util.toast("你需要在设施里面")
        return
    end

    local Data = {
        iRootContentID = value,
        iMissionType = 235, -- FMMC_TYPE_FM_GANGOPS_FIN
    }

    LAUNCH_MISSION(Data)
    util.toast("请稍等...")
end)
menu.list_action(Doomsday_Heist, "启动差事: 末日豪劫 准备任务", {}, "", Tables.DoomsdayHeistSetupRootContent, function(value)
    if IS_MISSION_CONTROLLER_SCRIPT_RUNNING() then
        return
    end

    if GET_FACILITY_PROPERTY_ID() <= 0 then
        util.toast("你需要拥有设施")
        return
    end
    if not IS_PLAYER_BOSS_OF_A_GANG() then
        util.toast("你需要注册为老大")
        return
    end
    if INTERIOR.GET_INTERIOR_FROM_ENTITY(players.user_ped()) ~= 269313 then
        util.toast("你需要在设施里面")
        return
    end

    local Data = {
        iRootContentID = value,
        iMissionType = 233, -- FMMC_TYPE_FM_GANGOPS
    }

    LAUNCH_MISSION(Data)
    util.toast("请稍等...")
end)




--------------------------------
--    Diamond Casino Heist
--------------------------------

local Casino_Heist <const> = menu.list(Heist_Mission, get_label_text("FMMC_CH_DN"), {}, "")

menu.divider(Casino_Heist, Labels.PREP)

local Casino_Heist_Prep <const> = menu.list(Casino_Heist, "前置编辑", {}, "")

menu.action(Casino_Heist, "直接完成 赌场抢劫 前置任务", {}, "", function()
    INSTANT_FINISH_CASINO_HEIST_PREPS()
end)



menu.divider(Casino_Heist, Labels.FINALE)

local Casino_Heist_Tool <const> = menu.list(Casino_Heist, "赌场抢劫工具选项", {}, "")

-- Casino Heist Tool

menu.click_slider(Casino_Heist_Tool, "设置赌场金库倒计时时长", { "CasinoVaultDuration" }, "单位: 秒",
    0, 6000, 300, 10, function(value)
        GLOBAL_SET_INT(Globals.CasinoVault_ZoneTimer_EnableTime, value * 1000)
    end)
menu.toggle_loop(Casino_Heist_Tool, "锁定赌场金库倒计时", {}, "", function()
    local script = "fm_mission_controller"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    LOCAL_SET_INT(script, Locals[script].stZoneTimers, NETWORK.GET_NETWORK_TIME())
end)

--#endregion


local CasinoHeistVars = {
    eEliteChallenge = 0,
    iCashTotalTake = -1,
    bResetPrepStats = false,
}

menu.list_select(Casino_Heist, Labels.EliteChallenge, {}, "", Tables.EliteChallenge, 0, function(value)
    CasinoHeistVars.eEliteChallenge = value
end)

rs.menu_slider(Casino_Heist, "拿取财物收入", { "CasinoHeistTotalTake" }, Lang.O_W_F_INS_FIN,
    -1, 10000000, -1, 50000, function(value)
        CasinoHeistVars.iCashTotalTake = value
    end)


menu.toggle(Casino_Heist, "重置前置任务面板", {}, "不重置则可以直接重复进行终章", function(toggle)
    CasinoHeistVars.bResetPrepStats = toggle
end)

menu.list_action(Casino_Heist, "直接完成 赌场抢劫", {}, "", Tables.CasinoHeistApproach, function(value)
    local script = "fm_mission_controller"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    if CasinoHeistVars.iCashTotalTake ~= -1 then
        LOCAL_SET_INT(script, Locals[script].iCashGrabTotalTake, CasinoHeistVars.iCashTotalTake)
    end

    HANDLE_HEIST_ELITE_CHALLENGE(script, CasinoHeistVars.eEliteChallenge)

    GLOBAL_SET_INT(g_sCasinoHeistMissionConfigData.eChosenApproachType, value)

    if CasinoHeistVars.bResetPrepStats then
        GLOBAL_SET_INT(FMMC_STRUCT.iRootContentIDHash, Tables.CasinoHeistFinalRootContent[value])
    end

    INSTANT_FINISH_FM_MISSION_CONTROLLER()
end)


menu.divider(Casino_Heist, "")

local Casino_Heist_Mission_Config <const> = menu.list(Casino_Heist, "终章面板设置", {}, "尝试用来解决单人进行任务无法设置面板的问题")

--#region

CasinoHeistVars.sConfig = {
    eChosenApproachType = 1,
    eTarget = 1,
    bHardMode = true,

    bSecurityCameraLocationsScoped = true,
    bGuardPatrolRoutesScoped = true,
    eShipmentDisruptionLevel = 3,
    bStealthNightVisionAcquired = true,
    bHandheldDrillAcquired = true,
    bEMPAcquired = true,

    eDropoffLocation = 6,
    eDropoffSubLocation = 0,
    bDecoyCrewMemberPurchased = true,
    bSwitchGetawayVehiclePurchased = true,
    eVehicleModPresetChosen = 3,

    eCrewWeaponsExpertChosen = 1,
    eCrewWeaponsLoadoutChosen = 0,
    eCrewDriverChosen = 1,
    eCrewVehiclesLoadoutChosen = 0,
    eCrewHackerChosen = 1,
    eCrewKeyAccessLevel = 2,
    eEntranceChosen = 1,
    eExitChosen = 1,
    eMasksChosen = 0,

    eSubterfugeOutfitsIn = 1,
    eSubterfugeOutfitsOut = 6,
    bOfficeInfested = true,

    bRappelGearAcquired = true,
}

menu.toggle_loop(Casino_Heist_Mission_Config, "设置终章面板", {},
    "1.确保在任务开启前启用\n2.确保采取方式选择正确\n3.其它的部分选项直接默认设置了", function()
        local Data = CasinoHeistVars.sConfig

        GLOBAL_SET_INT(g_sCasinoHeistMissionConfigData.eChosenApproachType, Data.eChosenApproachType)
        GLOBAL_SET_INT(g_sCasinoHeistMissionConfigData.eTarget, Data.eTarget)
        GLOBAL_SET_BOOL(g_sCasinoHeistMissionConfigData.bHardMode, Data.bHardMode)

        GLOBAL_SET_BOOL(g_sCasinoHeistMissionConfigData.bSecurityCameraLocationsScoped,
            Data.bSecurityCameraLocationsScoped)
        GLOBAL_SET_BOOL(g_sCasinoHeistMissionConfigData.bGuardPatrolRoutesScoped, Data.bGuardPatrolRoutesScoped)
        GLOBAL_SET_INT(g_sCasinoHeistMissionConfigData.eShipmentDisruptionLevel, Data.eShipmentDisruptionLevel)
        GLOBAL_SET_BOOL(g_sCasinoHeistMissionConfigData.bStealthNightVisionAcquired, Data.bStealthNightVisionAcquired)
        GLOBAL_SET_BOOL(g_sCasinoHeistMissionConfigData.bHandheldDrillAcquired, Data.bHandheldDrillAcquired)
        GLOBAL_SET_BOOL(g_sCasinoHeistMissionConfigData.bEMPAcquired, Data.bEMPAcquired)

        GLOBAL_SET_INT(g_sCasinoHeistMissionConfigData.eDropoffLocation, Data.eDropoffLocation)
        GLOBAL_SET_INT(g_sCasinoHeistMissionConfigData.eDropoffSubLocation, Data.eDropoffSubLocation)
        GLOBAL_SET_BOOL(g_sCasinoHeistMissionConfigData.bDecoyCrewMemberPurchased, Data.bDecoyCrewMemberPurchased)
        GLOBAL_SET_BOOL(g_sCasinoHeistMissionConfigData.bSwitchGetawayVehiclePurchased,
            Data.bSwitchGetawayVehiclePurchased)
        GLOBAL_SET_INT(g_sCasinoHeistMissionConfigData.eVehicleModPresetChosen, Data.eVehicleModPresetChosen)

        GLOBAL_SET_INT(g_sCasinoHeistMissionConfigData.eCrewWeaponsExpertChosen, Data.eCrewWeaponsExpertChosen)
        GLOBAL_SET_INT(g_sCasinoHeistMissionConfigData.eCrewWeaponsLoadoutChosen, Data.eCrewWeaponsLoadoutChosen)
        GLOBAL_SET_INT(g_sCasinoHeistMissionConfigData.eCrewDriverChosen, Data.eCrewDriverChosen)
        GLOBAL_SET_INT(g_sCasinoHeistMissionConfigData.eCrewVehiclesLoadoutChosen, Data.eCrewVehiclesLoadoutChosen)
        GLOBAL_SET_INT(g_sCasinoHeistMissionConfigData.eCrewHackerChosen, Data.eCrewHackerChosen)
        GLOBAL_SET_INT(g_sCasinoHeistMissionConfigData.eCrewKeyAccessLevel, Data.eCrewKeyAccessLevel)
        GLOBAL_SET_INT(g_sCasinoHeistMissionConfigData.eEntranceChosen, Data.eEntranceChosen)
        GLOBAL_SET_INT(g_sCasinoHeistMissionConfigData.eExitChosen, Data.eExitChosen)
        GLOBAL_SET_INT(g_sCasinoHeistMissionConfigData.eMasksChosen, Data.eMasksChosen)

        GLOBAL_SET_INT(g_sCasinoHeistMissionConfigData.eSubterfugeOutfitsIn, Data.eSubterfugeOutfitsIn)
        GLOBAL_SET_INT(g_sCasinoHeistMissionConfigData.eSubterfugeOutfitsOut, Data.eSubterfugeOutfitsOut)
        GLOBAL_SET_BOOL(g_sCasinoHeistMissionConfigData.bOfficeInfested, Data.bOfficeInfested)

        GLOBAL_SET_BOOL(g_sCasinoHeistMissionConfigData.bRappelGearAcquired, Data.bRappelGearAcquired)
    end)

menu.divider(Casino_Heist_Mission_Config, "")
menu.list_select(Casino_Heist_Mission_Config, get_label_text("CHB_APPROACH"), {}, "",
    Tables.CasinoHeistApproach, 1, function(value)
        CasinoHeistVars.sConfig.eChosenApproachType = value
    end)
menu.list_select(Casino_Heist_Mission_Config, get_label_text("CHB_TARGET"), {}, "",
    Tables.CasinoHeistTarget, 1, function(value)
        CasinoHeistVars.sConfig.eTarget = value
    end)
menu.toggle(Casino_Heist_Mission_Config, "Hard Mode", {}, "", function(toggle)
    CasinoHeistVars.sConfig.bHardMode = toggle
end, true)


menu.divider(Casino_Heist_Mission_Config, "")
menu.list_select(Casino_Heist_Mission_Config, get_label_text("CHB_ENTRANCE"), {}, "", {
    { 0,  get_label_text("CH_ACCPNT_0") },  -- MAIN_ENTRANCE
    { 1,  get_label_text("CH_ACCPNT_1") },  -- STAFF_ENTRANCE
    { 2,  get_label_text("CH_ACCPNT_2") },  -- GARBAGE_ENTRANCE
    { 3,  get_label_text("CH_ACCPNT_3") },  -- SOUTH_WEST_ROOF_TERRACE_ENTRANCE
    { 4,  get_label_text("CH_ACCPNT_4") },  -- NORTH_WEST_ROOF_TERRACE_ENTRANCE
    { 5,  get_label_text("CH_ACCPNT_5") },  -- SOUTH_EAST_ROOF_TERRACE_ENTRANCE
    { 6,  get_label_text("CH_ACCPNT_6") },  -- NORTH_EAST_ROOF_TERRACE_ENTRANCE
    { 7,  get_label_text("CH_ACCPNT_7") },  -- SOUTH_HELIPAD_ENTRANCE
    { 8,  get_label_text("CH_ACCPNT_8") },  -- NORTH_HELIPAD_ENTRANCE
    { 9,  get_label_text("CH_ACCPNT_9") },  -- SECURITY_VEHICLE_ENTRANCE
    { 10, get_label_text("CH_ACCPNT_10") }, -- SEWER_ENTRANCE
}, 1, function(value)
    CasinoHeistVars.sConfig.eEntranceChosen = value
end)
menu.list_select(Casino_Heist_Mission_Config, get_label_text("CHB_EXIT"), {}, "", {
    { 0, get_label_text("CH_ACCPNT_0") }, -- MAIN_ENTRANCE
    { 1, get_label_text("CH_ACCPNT_1") }, -- STAFF_ENTRANCE
    { 2, get_label_text("CH_ACCPNT_2") }, -- GARBAGE_ENTRANCE
    { 3, get_label_text("CH_ACCPNT_3") }, -- SOUTH_WEST_ROOF_TERRACE_ENTRANCE
    { 4, get_label_text("CH_ACCPNT_4") }, -- NORTH_WEST_ROOF_TERRACE_ENTRANCE
    { 5, get_label_text("CH_ACCPNT_5") }, -- SOUTH_EAST_ROOF_TERRACE_ENTRANCE
    { 6, get_label_text("CH_ACCPNT_6") }, -- NORTH_EAST_ROOF_TERRACE_ENTRANCE
    { 7, get_label_text("CH_ACCPNT_7") }, -- SOUTH_HELIPAD_ENTRANCE
    { 8, get_label_text("CH_ACCPNT_8") }, -- NORTH_HELIPAD_ENTRANCE
}, 1, function(value)
    CasinoHeistVars.sConfig.eExitChosen = value
end)
menu.list_select(Casino_Heist_Mission_Config, get_label_text("CHB_DROP_OFF"), {}, "", {
    { 0, "Short 1",  {}, "", get_label_text("CH_DROPOFF_0") },
    { 1, "Short 2",  {}, "", get_label_text("CH_DROPOFF_0") },
    { 2, "Short 3",  {}, "", get_label_text("CH_DROPOFF_0") },

    { 3, "Medium 1", {}, "", get_label_text("CH_DROPOFF_1") },
    { 4, "Medium 2", {}, "", get_label_text("CH_DROPOFF_1") },
    { 5, "Medium 3", {}, "", get_label_text("CH_DROPOFF_1") },

    { 6, "Long 1",   {}, "", get_label_text("CH_DROPOFF_2") },
    { 7, "Long 2",   {}, "", get_label_text("CH_DROPOFF_2") },
    { 8, "Long 3",   {}, "", get_label_text("CH_DROPOFF_2") },
}, 6, function(value)
    CasinoHeistVars.sConfig.eDropoffLocation = value
end)
menu.list_select(Casino_Heist_Mission_Config, "Force Dropoff Sub Location", {}, "", {
    { 0, Labels.None },
    { 1, "Location 1" },
    { 2, "Location 2" },
    { 3, "Location 3" },
}, 0, function(value)
    CasinoHeistVars.sConfig.eDropoffSubLocation = value
end)

menu.divider(Casino_Heist_Mission_Config, get_label_text("CHB_CREW"))
menu.list_select(Casino_Heist_Mission_Config, get_label_text("CHB_GUNMAN"), {}, "",
    Tables.CasinoHeistGunman, 1, function(value)
        CasinoHeistVars.sConfig.eCrewWeaponsExpertChosen = value
    end)
menu.list_select(Casino_Heist_Mission_Config, get_label_text("CHB_WEAP"), {}, "", {
    { 0, Labels.Default },
    { 1, "Alternate" },
}, 0, function(value)
    CasinoHeistVars.sConfig.eCrewWeaponsLoadoutChosen = value
end)
menu.list_select(Casino_Heist_Mission_Config, get_label_text("CHB_DRIVER"), {}, "",
    Tables.CasinoHeistDriver, 1, function(value)
        CasinoHeistVars.sConfig.eCrewDriverChosen = value
    end)
menu.list_select(Casino_Heist_Mission_Config, get_label_text("CHB_VEH"), {}, "", {
    { 0, Labels.Default },
    { 1, "Alternate 1" },
    { 2, "Alternate 2" },
    { 3, "Alternate 3" },
}, 0, function(value)
    CasinoHeistVars.sConfig.eCrewVehiclesLoadoutChosen = value
end)
menu.list_select(Casino_Heist_Mission_Config, get_label_text("CHB_HACKER"), {}, "",
    Tables.CasinoHeistHacker, 1, function(value)
        CasinoHeistVars.sConfig.eCrewHackerChosen = value
    end)

menu.divider(Casino_Heist_Mission_Config, get_label_text("CHB_APPROACH_2"))
menu.list_select(Casino_Heist_Mission_Config, get_label_text("CHB_OUTFIT_IN"), {}, "", {
    { 0, Labels.None },
    { 1, get_label_text("CH_OUTFIT_0") }, -- BUGSTAR
    { 2, get_label_text("CH_OUTFIT_1") }, -- MECHANIC
    { 3, get_label_text("CH_OUTFIT_2") }, -- GRUPPE_SECHS
    { 4, get_label_text("CH_OUTFIT_3") }, -- CELEBRITY
}, 1, function(value)
    CasinoHeistVars.sConfig.eSubterfugeOutfitsIn = value
end)
menu.list_select(Casino_Heist_Mission_Config, get_label_text("CHB_OUTFIT_OUT"), {}, "", {
    { 5, Labels.None },
    { 6, get_label_text("CH_OUTFIT_4") }, -- SWAT
    { 7, get_label_text("CH_OUTFIT_5") }, -- FIREMAN
    { 8, get_label_text("CH_OUTFIT_6") }, -- HIGH_ROLLER
}, 6, function(value)
    CasinoHeistVars.sConfig.eSubterfugeOutfitsOut = value
end)

--#endregion


menu.list_action(Casino_Heist, "启动差事: 赌场抢劫 终章", {},
    "", {
        { -1323726821, get_label_text("CHB_APPROACH_1") }, -- Silent & Sneaky
        { -1105714937, get_label_text("CHB_APPROACH_2") }, -- The Big Con
        { 14334224,    get_label_text("CHB_APPROACH_3") }  -- Aggressive
    }, function(value)
        if IS_MISSION_CONTROLLER_SCRIPT_RUNNING() then
            return
        end

        if GET_ARCADE_PROPERTY_ID() <= 0 then
            util.toast("你需要拥有游戏厅")
            return
        end
        if not IS_PLAYER_BOSS_OF_A_GANG() then
            util.toast("你需要注册为老大")
            return
        end
        if INTERIOR.GET_INTERIOR_FROM_ENTITY(players.user_ped()) ~= 278529 then
            util.toast("你需要在游戏厅里面")
            return
        end

        local Data = {
            iRootContentID = value,
            iMissionType = 158,      -- FMMC_TYPE_GB_CASINO_HEIST
            iMissionEnteryType = 65, -- ciMISSION_ENTERY_TYPE_CASINO_HEIST_BOARD
        }

        LAUNCH_MISSION(Data)
        util.toast("请稍等...")
    end)





--------------------------------
--    Cayo Perico Heist
--------------------------------

local Island_Heist <const> = menu.list(Heist_Mission, get_label_text("IH_TITLE"), {}, "")

local IslandHeistVars = {
    eEliteChallenge = 0,
    iTargetValue = -1,
    bResetPrepStats = false,
}

menu.divider(Island_Heist, Labels.PREP)

local Island_Heist_Prep <const> = menu.list(Island_Heist, "前置编辑", {}, "")
local Island_Heist_Prep_Secondary <const> = menu.list(Island_Heist, "前置编辑 (次要目标)", {}, "")


menu.action(Island_Heist, "直接完成 佩里科岛抢劫 前置任务", {}, "", function()
    local script = "fm_content_island_heist"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end
    INSTANT_FINISH_FM_CONTENT_MISSION(script)
end)


menu.divider(Island_Heist, Labels.FINALE)

menu.list_select(Island_Heist, Labels.EliteChallenge, {}, "", Tables.EliteChallenge, 0, function(value)
    IslandHeistVars.eEliteChallenge = value
end)

rs.menu_slider(Island_Heist, "主要目标价值", { "IslandHeistTargetValue" }, Lang.O_W_F_INS_FIN,
    -1, 2550000, -1, 50000, function(value)
        IslandHeistVars.iTargetValue = value
    end)


menu.toggle(Island_Heist, "重置前置任务面板", {}, "不重置则可以直接重复进行终章", function(toggle)
    IslandHeistVars.bResetPrepStats = toggle
end)

menu.action(Island_Heist, "直接完成 佩里科岛抢劫", {}, "", function()
    local script = "fm_mission_controller_2020"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    if IslandHeistVars.iTargetValue ~= -1 then
        Tunables.SetIntList("IslandHeistPrimaryTargetValue", IslandHeistVars.iTargetValue)
    end

    if IslandHeistVars.bResetPrepStats then
        GLOBAL_SET_INT(FMMC_STRUCT.iRootContentIDHash, 1601836271) -- H4_STEALTH_3
    end

    INSTANT_FINISH_FM_MISSION_CONTROLLER()
end)


menu.divider(Island_Heist, "")

menu.action(Island_Heist, "启动差事: 佩里科岛抢劫 终章", {},
    "如果没有完成必需前置，那么需要手动设置终章面板后才可以点击“继续”开启任务", function()
        if IS_MISSION_CONTROLLER_SCRIPT_RUNNING() then
            return
        end

        if not DOES_PLAYER_OWN_KOSATKA() then
            util.toast("你需要拥有虎鲸")
            return
        end
        if not IS_PLAYER_BOSS_OF_A_GANG() then
            util.toast("你需要注册为老大")
            return
        end
        if not IS_PLAYER_IN_KOSATKA() then
            util.toast("你需要在虎鲸里面")
            return
        end


        local Data = {
            iRootContentID = -1172878953, -- HIM_STUB
            iMissionType = 260,           -- FMMC_TYPE_HEIST_ISLAND_FINALE
            iMissionEnteryType = 67,      -- ciMISSION_ENTERY_TYPE_HEIST_ISLAND_TABLE
        }

        LAUNCH_MISSION(Data)
        util.toast("请稍等...")
    end)


local Island_Heist_Final_Config <const> = menu.list(Island_Heist, "终章面板设置", {}, "")

--#region

IslandHeistVars.sConfig = {
    ePrimaryTarget = 3,
    bHardModeEnabled = false,

    eApproachVehicle = 6,
    eInfiltrationPoint = 3,
    eCompoundEntrance = 0,
    eEscapePoint = 1,
    eTimeOfDay = 1,

    eWeaponLoadout = 1,
    bUseSuppressors = true,
    iAbilitiesBitset = 0,

    bDemolitionChargesAcquired = false,
    bAcetyleneTorchAcquired = false,
}

menu.action(Island_Heist_Final_Config, "设置终章面板", {}, "", function()
    local sConfig = GlobalPlayerBD_HeistIsland.sConfig()

    local Data = IslandHeistVars.sConfig


    GLOBAL_SET_INT(sConfig + 35, Data.eWeaponLoadout)
    GLOBAL_SET_BOOL(sConfig + 36, Data.bDemolitionChargesAcquired)
    GLOBAL_SET_BOOL(sConfig + 37, Data.bAcetyleneTorchAcquired)
    GLOBAL_SET_BOOL(sConfig + 38, Data.bHardModeEnabled)
    if Data.bHardModeEnabled then
        GLOBAL_SET_INT(FMMC_STRUCT.iDifficulity, DIFF_HARD)
    else
        GLOBAL_SET_INT(FMMC_STRUCT.iDifficulity, DIFF_NORMAL)
    end

    GLOBAL_SET_INT(sConfig + 39, Data.eApproachVehicle)
    GLOBAL_SET_INT(sConfig + 40, Data.eInfiltrationPoint)
    GLOBAL_SET_INT(sConfig + 41, Data.eCompoundEntrance)
    GLOBAL_SET_INT(sConfig + 42, Data.eEscapePoint)
    GLOBAL_SET_INT(sConfig + 43, Data.eTimeOfDay)
    GLOBAL_SET_BOOL(sConfig + 44, Data.bUseSuppressors)
    GLOBAL_SET_INT(sConfig + 45, Data.iAbilitiesBitset)
end)
menu.action(Island_Heist_Final_Config, "强制点击 继续 按钮", {}, "", function()
    GLOBAL_SET_INT(GlobalPlayerBD_NetHeistPlanningGeneric.stFinaleLaunchTimer() + 1, 1)
    GLOBAL_SET_INT(GlobalPlayerBD_NetHeistPlanningGeneric.stFinaleLaunchTimer(), 0)
end)

menu.divider(Island_Heist_Final_Config, "")

menu.toggle(Island_Heist_Final_Config, get_label_text("IHB_HARD_MODE"), {}, "", function(toggle)
    IslandHeistVars.sConfig.bHardModeEnabled = toggle
end, IslandHeistVars.sConfig.bHardModeEnabled)

menu.list_select(Island_Heist_Final_Config, get_label_text("H4P_FIN0_APRV_T"), {}, "", {
    { 1, get_label_text("H4P_FIN1_SUBM_T") }, -- KOSATKA
    { 2, get_label_text("H4P_FIN1_BOMB_T") }, -- ALKONOST
    { 3, get_label_text("H4P_FIN1_SMPL_T") }, -- VELUM
    { 4, get_label_text("H4P_FIN1_SHEL_T") }, -- STEALTH ANNIHILATOR
    { 5, get_label_text("H4P_FIN1_PBOA_T") }, -- PATROL BOAT
    { 6, get_label_text("H4P_FIN1_SBOA_T") }, -- LONGFIN
}, IslandHeistVars.sConfig.eApproachVehicle, function(value)
    IslandHeistVars.sConfig.eApproachVehicle = value
end)
menu.list_select(Island_Heist_Final_Config, get_label_text("H4P_INT0_ENTR_T"), {}, "", {
    { 0, get_label_text("H4P_FIN2_AIRS_T") }, -- AIRSTRIP
    { 1, get_label_text("H4P_FIN2_PARA_T") }, -- HALO JUMP
    { 2, get_label_text("H4P_FIN2_WBEA_T") }, -- WEST BEACH
    { 3, get_label_text("H4P_FIN2_MDOC_T") }, -- MAIN DOCK
    { 4, get_label_text("H4P_FIN2_NDOC_T") }, -- NORTH DOCK
    { 5, get_label_text("H4P_FIN2_NDRP_T") }, -- NORTH DROP ZONE
    { 6, get_label_text("H4P_FIN2_SDRP_T") }, -- SOUTH DROP ZONE
    { 7, get_label_text("H4P_FIN2_DTUN_T") }, -- DRAINAGE TUNNEL
}, IslandHeistVars.sConfig.eInfiltrationPoint, function(value)
    IslandHeistVars.sConfig.eInfiltrationPoint = value
end)
menu.list_select(Island_Heist_Final_Config, get_label_text("H4P_INT0_COMP_T"), {}, "", {
    { 0, get_label_text("H4P_INT5_MGAT_T") }, -- MAIN GATE
    { 1, get_label_text("H4P_INT5_NWAL_T") }, -- NORTH WALL
    { 2, get_label_text("H4P_INT5_NSGT_T") }, -- NORTH GATE
    { 3, get_label_text("H4P_INT5_SWAL_T") }, -- SOUTH WALL
    { 4, get_label_text("H4P_INT5_SSGT_T") }, -- SOUTH GATE
    { 5, get_label_text("H4P_INT5_DTUN_T") }, -- DRAINAGE TUNNEL
}, IslandHeistVars.sConfig.eCompoundEntrance, function(value)
    IslandHeistVars.sConfig.eCompoundEntrance = value
end)
menu.list_select(Island_Heist_Final_Config, get_label_text("H4P_INT0_EXIT_T"), {}, "", {
    { 0, get_label_text("H4P_FIN4_AIRS_T") }, -- AIRSTRIP
    { 1, get_label_text("H4P_FIN4_MDOC_T") }, -- MAIN DOCK
    { 2, get_label_text("H4P_FIN4_NDOC_T") }, -- NORTH DOCK
    { 3, get_label_text("H4P_FIN4_SUBM_T") }, -- KOSATKA
}, IslandHeistVars.sConfig.eEscapePoint, function(value)
    IslandHeistVars.sConfig.eEscapePoint = value
end)
menu.list_select(Island_Heist_Final_Config, get_label_text("H4P_FIN0_TIMD_T"), {}, "", {
    { 1, get_label_text("H4P_FIN5_TDAY_T") }, -- DAY
    { 2, get_label_text("H4P_FIN5_TNGT_T") }, -- NIGHT
}, IslandHeistVars.sConfig.eTimeOfDay, function(value)
    IslandHeistVars.sConfig.eTimeOfDay = value
end)

menu.list_select(Island_Heist_Final_Config, get_label_text("H4P_FIN0_WEAP_T"), {}, "", {
    { 1, get_label_text("H4P_FIN6_SHOT_T"), {}, get_label_text("H4P_FIN6_SHOT_I") }, -- AGGRESSOR
    { 2, get_label_text("H4P_FIN6_RIFL_T"), {}, get_label_text("H4P_FIN6_RIFL_I") }, -- CONSPIRATOR
    { 3, get_label_text("H4P_FIN6_SNIP_T"), {}, get_label_text("H4P_FIN6_SNIP_I") }, -- CRACK SHOT
    { 4, get_label_text("H4P_FIN6_MKSM_T"), {}, get_label_text("H4P_FIN6_MKSM_I") }, -- SABOTEUR
    { 5, get_label_text("H4P_FIN6_MKAR_T"), {}, get_label_text("H4P_FIN6_MKAR_I") }, -- MARKSMAN
}, IslandHeistVars.sConfig.eWeaponLoadout, function(value)
    IslandHeistVars.sConfig.eWeaponLoadout = value
end)
menu.toggle(Island_Heist_Final_Config, get_label_text("H4P_FIN6_SUPP_T"), {}, "", function(toggle)
    IslandHeistVars.sConfig.bUseSuppressors = toggle
end, IslandHeistVars.sConfig.bUseSuppressors)

local Island_Heist_Final_Config_Ability = menu.list(Island_Heist_Final_Config, get_label_text("H4P_FIN0_SUPP_T"), {}, "")
local Island_Heist_Final_Support_Crew = {
    { bit = 0, name = get_label_text("H4P_FIN7_AIRS_T"), help = get_label_text("H4P_FIN7_AIRS_I") }, -- AIRSTRIKE
    { bit = 1, name = get_label_text("H4P_FIN7_WDRP_T"), help = get_label_text("H4P_FIN7_WDRP_I") }, -- SUPPLY DROP
    { bit = 2, name = get_label_text("H4P_FIN7_SNIP_T"), help = get_label_text("H4P_FIN7_SNIP_I") }, -- SNIPER
    { bit = 3, name = get_label_text("H4P_FIN7_HELI_T"), help = get_label_text("H4P_FIN7_HELI_I") }, -- HELICOPTER BACKUP
    { bit = 4, name = get_label_text("H4P_FIN7_SPYD_T"), help = get_label_text("H4P_FIN7_SPYD_I") }, -- RECON DRONE
    { bit = 5, name = get_label_text("H4P_FIN7_WEAP_T"), help = get_label_text("H4P_FIN7_WEAP_I") }, -- WEAPON STASH
}
for _, item in pairs(Island_Heist_Final_Support_Crew) do
    menu.toggle(Island_Heist_Final_Config_Ability, item.name, {}, item.help, function(toggle)
        if toggle then
            IslandHeistVars.sConfig.iAbilitiesBitset = SET_BIT(IslandHeistVars.sConfig.iAbilitiesBitset, item.bit)
        else
            IslandHeistVars.sConfig.iAbilitiesBitset = CLEAR_BIT(IslandHeistVars.sConfig.iAbilitiesBitset, item.bit)
        end
    end)
end

menu.divider(Island_Heist_Final_Config, "")
menu.toggle(Island_Heist_Final_Config, get_label_text("H4P_PRP2_DEMC_T"), {}, "", function(toggle)
    IslandHeistVars.sConfig.bDemolitionChargesAcquired = toggle
end, IslandHeistVars.sConfig.bDemolitionChargesAcquired)
menu.toggle(Island_Heist_Final_Config, get_label_text("H4P_PRP2_ATOR_T"), {}, "", function(toggle)
    IslandHeistVars.sConfig.bAcetyleneTorchAcquired = toggle
end, IslandHeistVars.sConfig.bAcetyleneTorchAcquired)

--#endregion




--------------------------------
--    Auto Shop Robbery
--------------------------------

local Tuner_Robbery <const> = menu.list(Heist_Mission, get_label_text("TUN_ROB_CONTR"), {}, "")

local TunerRobberyVars = {
    iMissionVariation = -1,
    iCashReward = -1,
}

menu.divider(Tuner_Robbery, Labels.PREP)

menu.list_select(Tuner_Robbery, Lang.SelectMission, {}, "", Tables.TunerRobbery, -1, function(value)
    TunerRobberyVars.iMissionVariation = value
end)

menu.textslider(Tuner_Robbery, Labels.LaunchMission, {}, "", {
    "Request", "Start"
}, function(value)
    local iMission = 271 -- FMMC_TYPE_TUNER_ROBBERY
    local iMissionVariation = TunerRobberyVars.iMissionVariation
    if value == 1 then
        SET_CONTACT_REQUEST_GB_MISSION_LAUNCH_DATA(iMission, iMissionVariation)
    else
        GB_BOSS_REQUEST_MISSION_LAUNCH_FROM_SERVER(iMission, iMissionVariation)
    end
end)

menu.action(Tuner_Robbery, "直接完成 改装铺抢劫 前置任务", {}, "", function()
    local script = "fm_content_tuner_robbery"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end
    INSTANT_FINISH_FM_CONTENT_MISSION(script)
end)


menu.divider(Tuner_Robbery, Labels.FINALE)

menu.list_action(Tuner_Robbery, "启动差事: 改装铺抢劫", {}, "", Tables.TunerRobberyFinalRootContent, function(value)
    if IS_MISSION_CONTROLLER_SCRIPT_RUNNING() then
        return
    end

    if GET_AUTO_SHOP_PROPERTY_ID() <= 0 then
        util.toast("你需要拥有改装铺")
        return
    end
    if not IS_PLAYER_BOSS_OF_A_GANG() then
        util.toast("你需要注册为老大")
        return
    end
    if INTERIOR.GET_INTERIOR_FROM_ENTITY(players.user_ped()) ~= 285953 then
        util.toast("你需要在改装铺里面")
        return
    end

    local Data = {
        iRootContentID = value,
        iMissionType = 274,      -- FMMC_TYPE_TUNER_ROBBERY_FINALE
        iMissionEnteryType = 69, -- ciMISSION_ENTERY_TYPE_TUNER_JOB_BOARD
    }

    LAUNCH_MISSION(Data)
    util.toast("请稍等...")
end)

rs.menu_slider(Tuner_Robbery, Lang.CashReward, { "TunerRobberyCashReward" },
    Lang.O_W_F_INS_FIN, -1, 2000000, -1, 50000, function(value)
        TunerRobberyVars.iCashReward = value
    end)

menu.action(Tuner_Robbery, "直接完成 改装铺抢劫", {}, "", function()
    local script = "fm_mission_controller_2020"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    if TunerRobberyVars.iCashReward ~= -1 then
        Tunables.SetIntList("TunerRobberyLeaderCashReward", TunerRobberyVars.iCashReward)
    end

    INSTANT_FINISH_FM_MISSION_CONTROLLER()
end)



------------------------------------
--    The Contract: Dr. Dre
------------------------------------

local Fixer_VIP <const> = menu.list(Heist_Mission, get_label_text("FAPP_THE_CONTRACT_DR_DRE"), {}, "")

local FixerVipVars = {
    iMissionVariation = -1,
    iCashReward = -1,
}

menu.divider(Fixer_VIP, Labels.PREP)

menu.list_select(Fixer_VIP, Lang.SelectMission, {}, "", Tables.FixerVIP, -1, function(value)
    FixerVipVars.iMissionVariation = value
end)

menu.textslider(Fixer_VIP, Labels.LaunchMission, {}, "", {
    "Request", "Start"
}, function(value)
    local iMission = 264 -- FMMC_TYPE_FIXER_VIP
    local iMissionVariation = FixerVipVars.iMissionVariation
    if value == 1 then
        SET_CONTACT_REQUEST_GB_MISSION_LAUNCH_DATA(iMission, iMissionVariation)
    else
        GB_BOSS_REQUEST_MISSION_LAUNCH_FROM_SERVER(iMission, iMissionVariation)
    end
end)

menu.action(Fixer_VIP, "直接完成 合约德瑞博士 前置任务", {}, "", function()
    local script = "fm_content_vip_contract_1"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end
    INSTANT_FINISH_FM_CONTENT_MISSION(script)
end)


menu.divider(Fixer_VIP, Labels.FINALE)

menu.action(Fixer_VIP, "启动差事: 别惹德瑞", {}, "", function()
    if IS_MISSION_CONTROLLER_SCRIPT_RUNNING() then
        return
    end

    if GET_AGENCY_PROPERTY_ID() <= 0 then
        util.toast("你需要拥有事务所")
        return
    end
    if not IS_PLAYER_BOSS_OF_A_GANG() then
        util.toast("你需要注册为老大")
        return
    end

    local Data = {
        iRootContentID = 1645353926,
        iMissionType = 0,        -- FMMC_TYPE_MISSION
        iMissionEnteryType = 81, -- ciMISSION_ENTERY_TYPE_FIXER_WORLD_TRIGGER
    }

    LAUNCH_MISSION(Data)
    util.toast("请稍等...")
end)

rs.menu_slider(Fixer_VIP, Lang.CashReward, { "FixerVIPCashReward" }, Lang.O_W_F_INS_FIN,
    -1, 2000000, -1, 50000, function(value)
        FixerVipVars.iCashReward = value
    end)

menu.action(Fixer_VIP, "直接完成 别惹德瑞", {}, "", function()
    local script = "fm_mission_controller_2020"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    if FixerVipVars.iCashReward ~= -1 then
        Tunables.SetInt("FIXER_FINALE_LEADER_CASH_REWARD", FixerVipVars.iCashReward)
    end

    INSTANT_FINISH_FM_MISSION_CONTROLLER()
end)



----------------------------------------
--    The Cluckin' Bell Farm Raid
----------------------------------------

local Chicken_Factory_Raid <const> = menu.list(Heist_Mission, get_label_text("DLCC_CFRAI"), {}, "")

menu.list_action(Chicken_Factory_Raid, "启动差事: 犯罪现场", {}, "", {
    { 13546844, "潜行" },
    { 2107866924, "强攻" },
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

local FarmRaidCashReward = rs.menu_slider(Chicken_Factory_Raid, Lang.CashReward, { "FarmRaidCashReward" },
    Lang.O_W_F_INS_FIN, -1, 1000000, -1, 50000, function(value) end)

menu.action(Chicken_Factory_Raid, "直接完成 当当钟农场突袭", {}, "", function()
    local script = "fm_mission_controller_2020"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end

    local cash_reward = menu.get_value(FarmRaidCashReward)
    if cash_reward ~= -1 then
        Tunables.SetInt("-2000196818", cash_reward)
    end

    INSTANT_FINISH_FM_MISSION_CONTROLLER()
end)







--------------------------------
--    Tunable Options
--------------------------------

local Tunable_Options <const> = menu.list(Menu_Root, "可调整项", {}, "")

local TunableOptionVars = {
    missionHighEarning = 0,
    missionLowEarning = 0,
}

local Tunable_Mission_Earning = menu.list(Tunable_Options, "限制差事收入", {}, "")

menu.slider(Tunable_Mission_Earning, "最高收入", { "MissionHighEarningModifier" }, "",
    0, 15000000, TunableOptionVars.missionHighEarning, 10000, function(value)
        TunableOptionVars.missionHighEarning = value
    end)
menu.slider(Tunable_Mission_Earning, "最低收入", { "MissionLowEarningModifier" }, "",
    0, 15000000, TunableOptionVars.missionLowEarning, 10000, function(value)
        TunableOptionVars.missionLowEarning = value
    end)

menu.toggle_loop(Tunable_Mission_Earning, "限制差事收入", {},
    "例如：限制最低收入为10万，那么当任务结束最后结算的金额不到10万，就会被强制设置为10万\n0 表示不限制\n精英挑战奖励是额外加的，不受限制", function()
        if TunableOptionVars.missionHighEarning > 0 then
            Tunables.SetFloat("HIGH_ROCKSTAR_MISSIONS_MODIFIER", TunableOptionVars.missionHighEarning)
        end
        if TunableOptionVars.missionLowEarning > 0 then
            Tunables.SetFloat("LOW_ROCKSTAR_MISSIONS_MODIFIER", TunableOptionVars.missionLowEarning)
        end
    end, function()
        Tunables.SetFloat("HIGH_ROCKSTAR_MISSIONS_MODIFIER", 0)
        Tunables.SetFloat("LOW_ROCKSTAR_MISSIONS_MODIFIER", 0)
    end)



menu.toggle_loop(Tunable_Options, "移除任务冷却时间", {}, Lang.E_B_S_M, function()
    Tunables.SetIntList("MissionCooldowns", 0)
end, function()
    Tunables.RestoreIntDefaults("MissionCooldowns")
end)
menu.toggle_loop(Tunable_Options, "移除抢劫任务冷却时间", {}, Lang.E_B_S_M, function()
    Tunables.SetIntList("HeistCooldowns", 0)
end, function()
    Tunables.RestoreIntDefaults("HeistCooldowns")
end)
menu.toggle_loop(Tunable_Options, "移除NPC分红", {}, Lang.E_B_S_M, function()
    Tunables.SetIntList("NpcCut", 0)
    Tunables.SetFloatList("NpcCut", 0)
end, function()
    Tunables.RestoreIntDefaults("NpcCut")
    Tunables.RestoreFloatDefaults("NpcCut")
end)
menu.toggle_loop(Tunable_Options, "移除请求冷却时间", {}, "请求载具, 请求服务, CEO技能", function()
    Tunables.SetIntList("RequestCooldowns", 0)
end, function()
    Tunables.RestoreIntDefaults("RequestCooldowns")
end)
menu.toggle_loop(Tunable_Options, "禁用产业劫货", {}, "", function()
    Tunables.SetIntList("DisableBusinessRaid", 1)
end, function()
    Tunables.RestoreIntDefaults("DisableBusinessRaid")
end)


menu.divider(Tunable_Options, "")
menu.toggle(Tunable_Options, "禁止可调整项自动刷新", { "DisableRefreshTunable" }, "禁止切换战局后可调整项恢复为默认值", function(toggle)
    local script = "social_controller"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end
    LOCAL_SET_INT(script, Locals[script].eMaintainStage, toggle and -1 or 0)
end)
menu.action(Tunable_Options, "立即刷新可调整项", { "RefreshTunable" }, "立即将可调整项恢复为默认值", function()
    local script = "social_controller"
    if not IS_SCRIPT_RUNNING(script) then
        return
    end
    LOCAL_SET_INT(script, Locals[script].eMaintainStage, 1)

    -- eMAINTAIN_TUNEABLES_STAGE_WAIT_FOR_MODE_CHANGE = 0
    -- eMAINTAIN_TUNEABLES_STAGE_REFIL_TUNEABLES = 1
    -- eMAINTAIN_TUNEABLES_STAGE_DONE = 2
end)





--------------------------------
--    Stat Options
--------------------------------

local Stat_Options <const> = menu.list(Menu_Root, "统计数据选项", {}, "")

------------------------
-- Remove Cooldown
------------------------

local Stat_Cooldown = menu.list(Stat_Options, "立即移除冷却时间", {}, "")

local CooldownStatList = {
    { name = "公寓抢劫 手机匹配", stat = "HESIT_LAUNCH_TIME" },

    { name = "末日豪劫", stat = { "HEISTCOOLDOWNTIMER0", "HEISTCOOLDOWNTIMER1", "HEISTCOOLDOWNTIMER2" } },
    { name = "末日豪劫 手机匹配", stat = "GANGOPS_LAUNCH_TIME" },

    { name = "赌场抢劫", stat = "H3_COMPLETEDPOSIX" },
    { name = "赌场抢劫 手机匹配", stat = "MPPLY_H3_COOLDOWN" },

    { name = "佩里科岛抢劫", stat = { "H4_COOLDOWN", "H4_COOLDOWN_HARD" } },
    { name = "佩里科岛抢劫 手机匹配", stat = "MPPLY_H4_COOLDOWN" },

    {
        name = "改装铺抢劫",
        stat = { "TUNER_CONTRACT0_POSIX", "TUNER_CONTRACT1_POSIX", "TUNER_CONTRACT2_POSIX", "TUNER_CONTRACT3_POSIX", "TUNER_CONTRACT4_POSIX", "TUNER_CONTRACT5_POSIX", "TUNER_CONTRACT6_POSIX", "TUNER_CONTRACT7_POSIX" }
    },
    { name = "改装铺合约 刷新", stat = "TUNER_REFRESH_POSIX" },

    { name = "合约德瑞博士", stat = "FIXER_STORY_COOLDOWN" },
    { name = "回收站抢劫", stat = "SALV23_VEHROB_CD" },
    { name = "当当钟农场突袭", stat = "SALV23_CFR_COOLDOWN" },

    { name = "富兰克林 请求电话暗杀", stat = "PAYPHONE_HIT_CDTIMER" },
    { name = "达克斯 蠢人帮差事", stat = "XM22JUGGALOWORKCDTIMER" },
    { name = "14号探员 请求地堡研究", stat = "SOURCE_RESEARCH_CDTIMER" },
    { name = "尤汗 请求夜总会货物", stat = "SOURCE_GOODS_CDTIMER" },
    { name = "地堡 武器零件", stat = "BUNKER_CRATE_COOLDOWN" },
    { name = "夜总会 人气任务", stat = "NCLUB_EVENT_POSSIX" },
    { name = "办公室 出口混合货物", stat = "EXEC_EXP_CARGO_CD" },
    { name = "贝克女士 赌场工作任务", stat = "CASINO_MISSION_CDTIMER" },
}

for _, item in pairs(CooldownStatList) do
    menu.action(Stat_Cooldown, item.name, {}, "", function()
        local stats = { item.stat }
        if type(item.stat) == "table" then
            stats = item.stat
        end

        for _, stat in pairs(stats) do
            if string.sub(stat, 1, 6) == "MPPLY_" then
                STAT_SET_INT(stat, 0)
            else
                STAT_SET_INT(ADD_MP_INDEX(stat), 0)
            end
        end
    end)
end

------------------------
-- Remove Cutscene
------------------------

local Stat_Cutscene = menu.list(Stat_Options, "移除首次进入资产的动画教程", {}, "")

local BusinessCutsceneBitList = {
    { name = Labels.Office,                 bits = { 13 } }, -- biFmCut_OfficeCutscene
    { name = Labels.SpecialCargoWarehouse,  bits = { 14 } },
    { name = Labels.BikerClubhouse,         bits = { 15 } },
    { name = Labels.MethLab,                bits = { 16, 21 } },
    { name = Labels.CocaineLockup,          bits = { 17, 22 } },
    { name = Labels.WeedFarm,               bits = { 18, 23 } },
    { name = Labels.DocumentForgeryOffice,  bits = { 19, 24 } },
    { name = Labels.CounterfeitCashFactory, bits = { 20, 25 } },
    { name = Labels.VehicleWarehouse,       bits = { 26 } },
    { name = Labels.Bunker,                 bits = { 27, 28 } },
    { name = Labels.Hangar,                 bits = { 29, 30 } },
    { name = Labels.Facility,               bits = { 31 } },
}

for _, item in pairs(BusinessCutsceneBitList) do
    menu.textslider(Stat_Cutscene, item.name, {}, "", {
        "Set", "Reset"
    }, function(value)
        local iStatInt = STAT_GET_INT(ADD_MP_INDEX("FM_CUT_DONE"))
        if value == 1 then
            iStatInt = SET_BITS(iStatInt, table.unpack(item.bits))
        else
            iStatInt = CLEAR_BITS(iStatInt, table.unpack(item.bits))
        end
        STAT_SET_INT(ADD_MP_INDEX("FM_CUT_DONE"), iStatInt)
        util.toast("写入完成!")
    end)
end

------------------------
-- Casino Heist
------------------------

local Stat_Casino_Heist = menu.list(Stat_Options, "赌场抢劫", {}, "")

menu.textslider(Stat_Casino_Heist, "解锁莱斯特取消抢劫", {}, "", {
    "Set", "Reset"
}, function(value)
    local iStatInt = STAT_GET_INT(ADD_MP_INDEX("CAS_HEIST_FLOW"))
    if value == 1 then
        iStatInt = SET_BITS(iStatInt, 10, 11, 12, 13)
    else
        iStatInt = CLEAR_BITS(iStatInt, 10, 11, 12, 13)
    end
    STAT_SET_INT(ADD_MP_INDEX("CAS_HEIST_FLOW"), iStatInt)
    util.toast("写入完成!")

    -- ciCASINO_HEIST_FLOW_STAT_BITSET__HEIST_COMPLETED_FOR_FIRST_TIME   10
    -- ciCASINO_HEIST_FLOW_STAT_BITSET__STEALTH_APPROACH_COMPLETED       11
    -- ciCASINO_HEIST_FLOW_STAT_BITSET__SUBTERFUGE_APPROACH_COMPLETED    12
    -- ciCASINO_HEIST_FLOW_STAT_BITSET__DIRECT_APPROACH_COMPLETED        13
end)
menu.textslider(Stat_Casino_Heist, "解锁隐藏支援队伍", {}, "", {
    "Set", "Reset"
}, function(value)
    local iStatInt = STAT_GET_INT(ADD_MP_INDEX("CAS_HEIST_FLOW"))
    if value == 1 then
        iStatInt = SET_BITS(iStatInt, 9, 15, 25)
    else
        iStatInt = CLEAR_BITS(iStatInt, 9, 15, 25)
    end
    STAT_SET_INT(ADD_MP_INDEX("CAS_HEIST_FLOW"), iStatInt)
    util.toast("写入完成!")

    -- ciCASINO_HEIST_FLOW_STAT_BITSET__PATRICK_MCREARY_AVAILABLE               9
    -- ciCASINO_HEIST_FLOW_STAT_BITSET__AVI_SCHWARTZMAN_AVAILABLE               15
    -- ciCASINO_HEIST_FLOW_STAT_BITSET__AVI_SCHWARTZMAN_AVAILABLE_HELP_DONE     25
end)
menu.textslider(Stat_Casino_Heist, "已购买赌场模型保安门禁等", {}, "", {
    "Set", "Reset"
}, function(value)
    local iStatInt = STAT_GET_INT(ADD_MP_INDEX("CAS_HEIST_FLOW"))
    if value == 1 then
        iStatInt = SET_BITS(iStatInt, 6, 7, 8)
    else
        iStatInt = CLEAR_BITS(iStatInt, 6, 7, 8)
    end
    STAT_SET_INT(ADD_MP_INDEX("CAS_HEIST_FLOW"), iStatInt)
    util.toast("写入完成!")

    -- ciCASINO_HEIST_FLOW_STAT_BITSET__VAULT_DOOR_PURCHASED    6
    -- ciCASINO_HEIST_FLOW_STAT_BITSET__KEYPAD_PURCHASED        7
    -- ciCASINO_HEIST_FLOW_STAT_BITSET__MODEL_PURCHASED         8
end)

------------------------
-- Doomsday Heist
------------------------

local Stat_Doomsday_Heist = menu.list(Stat_Options, "末日豪劫", {}, "")

menu.textslider(Stat_Doomsday_Heist, "解锁莱斯特取消抢劫", {}, "解锁重玩面板", {
    "Set", "Reset"
}, function(value)
    local iStatInt = STAT_GET_INT(ADD_MP_INDEX("GANGOPS_HEIST_STATUS"))
    if value == 1 then
        iStatInt = SET_BIT(iStatInt, 13)
    else
        iStatInt = CLEAR_BIT(iStatInt, 13)
    end
    STAT_SET_INT(ADD_MP_INDEX("GANGOPS_HEIST_STATUS"), iStatInt)
    util.toast("写入完成!")

    -- GANG_OPS_BD_HEIST_STATUS_BITSET_UNLOCKED_REPLAY_BOARD    13
end)
menu.textslider(Stat_Doomsday_Heist, "解锁莱斯特免费移除通缉", {}, "", {
    "Set", "Reset"
}, function(value)
    local iStatInt = STAT_GET_INT(ADD_MP_INDEX("GANGOPS_HEIST_STATUS"))
    if value == 1 then
        iStatInt = SET_BIT(iStatInt, 19)
    else
        iStatInt = CLEAR_BIT(iStatInt, 19)
    end
    STAT_SET_INT(ADD_MP_INDEX("GANGOPS_HEIST_STATUS"), iStatInt)
    util.toast("写入完成!")

    -- GANG_OPS_BD_HEIST_STATUS_BITSET_COMPLETED_SILO_FINALE_AS_LEADER  19
end)

------------------------
-- Packed Stat Bool
------------------------

local Packed_Stat_Bool = menu.list(Stat_Options, "PACKED_STAT_BOOL", {}, "")

menu.textslider(Packed_Stat_Bool, get_label_text("WT_CANDYCANE"), {}, "", {
    "True", "False"
}, function(value)
    if value == 1 then
        SET_PACKED_STAT_BOOL_CODE(42249, true)
    else
        SET_PACKED_STAT_BOOL_CODE(42249, false)
    end
    util.toast("写入完成!")
end)
menu.textslider(Packed_Stat_Bool, get_label_text("WT_SNOWLNCHR"), {}, "", {
    "True", "False"
}, function(value)
    if value == 1 then
        SET_PACKED_STAT_BOOL_CODE(42148, true)
    else
        SET_PACKED_STAT_BOOL_CODE(42148, false)
    end
    util.toast("写入完成!")
end)









menu.divider(Menu_Root, "")

menu.action(Menu_Root, "跳过破解小游戏", { "SkipHackingMinigame" }, "所有的破解、骇入、钻孔等", function()
    SKIP_HACKING_MINIGAME()
end)
menu.action(Menu_Root, "移除自由模式横幅通知", { "clsBigMessage" }, "", function()
    CLEAR_BIG_MESSAGE()
end)

menu.action(Menu_Root, "移除任务冷却时间", {}, "切换战局会失效", function()
    Tunables.SetIntList("MissionCooldowns", 0)
end)
menu.action(Menu_Root, "移除NPC分红", {}, "切换战局会失效", function()
    Tunables.SetIntList("NpcCut", 0)
    Tunables.SetFloatList("NpcCut", 0)
end)






--------------------------------
--    Heist Prep Editor
--------------------------------


--#region Apartment Heist Prep

--------------------------------
-- Apartment Heist Prep
--------------------------------

function Tables.GetHeistPrepIndex(sRootContentID)
    for key, value in pairs(Tables.HeistPrepRootContentIDList) do
        if value == sRootContentID then
            return key
        end
    end
    return -1
end

function Tables.GetHeistPrepName(sRootContentID)
    for key, value in pairs(Tables.HeistPrepRootContentIDList) do
        if value == sRootContentID then
            return Tables.HeistPrepList[key + 2][2]
        end
    end
    return ""
end

local ApartmentHeistPrepVars = {
    iBitset = nil,
    menuList = {},

    Missions = {
        menuList = {},
    },
}

menu.action(Apartment_Heist_Prep, "读取 HEIST_PLANNING_STAGE", {}, "", function()
    ApartmentHeistPrepVars.iBitset = nil
    menu.set_value(ApartmentHeistPrepVars.menuValue, "")
    menu.set_menu_name(ApartmentHeistPrepVars.menuDivider, "")

    rs.delete_menu_list(ApartmentHeistPrepVars.menuList)
    ApartmentHeistPrepVars.menuList = {}


    local heist_root_content_hash = STAT_GET_INT(ADD_MP_INDEX("HEIST_MISSION_RCONT_ID_0"))
    if heist_root_content_hash == 0 then
        util.toast("你似乎未进行任何抢劫")
        return
    end

    local heist_prep_bitset = STAT_GET_INT(ADD_MP_INDEX("HEIST_PLANNING_STAGE"))
    ApartmentHeistPrepVars.iBitset = heist_prep_bitset
    menu.set_value(ApartmentHeistPrepVars.menuValue, heist_prep_bitset)

    local heist_name = Tables.HeistFinalName[heist_root_content_hash]
    if heist_name == nil then
        heist_name = ""
    end
    menu.set_menu_name(ApartmentHeistPrepVars.menuDivider, heist_name)

    for i = 1, 7 do
        local prep_root_content_id = STAT_GET_STRING(ADD_MP_INDEX("HEIST_MISSION_RCONT_ID_" .. i))
        if prep_root_content_id ~= "" then
            local prep_name = Tables.GetHeistPrepName(prep_root_content_id)

            local is_bitset = false
            local bit_range = (i - 1) * 3
            if BIT_TEST(heist_prep_bitset, bit_range) then
                is_bitset = true
            end

            local menu_toggle = menu.toggle(Apartment_Heist_Prep, prep_name, {}, "", function(toggle)
                if toggle then
                    ApartmentHeistPrepVars.iBitset = SET_BIT(ApartmentHeistPrepVars.iBitset, bit_range)
                else
                    ApartmentHeistPrepVars.iBitset = CLEAR_BIT(ApartmentHeistPrepVars.iBitset, bit_range)
                end
                menu.set_value(ApartmentHeistPrepVars.menuValue, ApartmentHeistPrepVars.iBitset)
            end, is_bitset)
            table.insert(ApartmentHeistPrepVars.menuList, menu_toggle)
        end
    end
end)

ApartmentHeistPrepVars.menuValue = menu.readonly(Apartment_Heist_Prep, "值")

menu.action(Apartment_Heist_Prep, "写入 HEIST_PLANNING_STAGE", {}, "", function()
    if ApartmentHeistPrepVars.iBitset == nil then
        return
    end

    STAT_SET_INT(ADD_MP_INDEX("HEIST_PLANNING_STAGE"), ApartmentHeistPrepVars.iBitset)
    util.toast("写入完成, 你可能需要重新进入公寓来刷新面板")
end)

ApartmentHeistPrepVars.menuDivider = menu.divider(Apartment_Heist_Prep, "")

-- Apartment Heist Prep Mission

menu.action(Apartment_Heist_Prep_Mission, "读取 HEIST_MISSION_RCONT_ID_x", {}, "", function()
    local heist_root_content_hash = STAT_GET_INT(ADD_MP_INDEX("HEIST_MISSION_RCONT_ID_0"))
    if heist_root_content_hash == 0 then
        util.toast("你似乎未进行任何抢劫")
        menu.set_menu_name(ApartmentHeistPrepVars.Missions.menuDivider, "")
        return
    end

    local heist_name = Tables.HeistFinalName[heist_root_content_hash]
    if heist_name == nil then
        heist_name = ""
    end
    menu.set_menu_name(ApartmentHeistPrepVars.Missions.menuDivider, heist_name)

    for i = 1, 6 do
        local root_content_id = STAT_GET_STRING(ADD_MP_INDEX("HEIST_MISSION_RCONT_ID_" .. i))

        local menu_select_value = -1
        if root_content_id ~= "" then
            local prep_index = Tables.GetHeistPrepIndex(root_content_id)
            if prep_index ~= -1 then
                menu_select_value = prep_index
            end
        end

        menu.set_value(ApartmentHeistPrepVars.Missions.menuList[i], menu_select_value)
    end
end)
menu.action(Apartment_Heist_Prep_Mission, "写入 HEIST_MISSION_RCONT_ID_x", {}, "", function()
    if STAT_GET_INT(ADD_MP_INDEX("HEIST_MISSION_RCONT_ID_0")) == 0 then
        util.toast("你似乎未进行任何抢劫")
        return
    end

    for i = 1, 6 do
        local prep_index = menu.get_value(ApartmentHeistPrepVars.Missions.menuList[i])
        if prep_index == -1 then
            STAT_SET_STRING(ADD_MP_INDEX("HEIST_MISSION_RCONT_ID_" .. i), "")
        else
            local root_content_id = Tables.HeistPrepRootContentIDList[prep_index]
            STAT_SET_STRING(ADD_MP_INDEX("HEIST_MISSION_RCONT_ID_" .. i), root_content_id)
        end
    end
    util.toast("写入完成, 你可能需要重新进入公寓来刷新面板")
end)

ApartmentHeistPrepVars.Missions.menuDivider = menu.divider(Apartment_Heist_Prep_Mission, "")

for i = 1, 6 do
    ApartmentHeistPrepVars.Missions.menuList[i] = menu.list_select(Apartment_Heist_Prep_Mission, tostring(i), {}, "",
        Tables.HeistPrepList, -1, function(value) end)
end


--#endregion



--#region Doomsday Heist Prep

--------------------------------
-- Doomsday Heist Prep
--------------------------------

local DoomsdayHeistPrepVars = {
    Prep = {
        iBitset = nil,
        menuList = {},
    },
    Setup = {
        iBitset = nil,
        menuList = {},
    },
}

menu.divider(Doomsday_Heist_Prep, "一键")

menu.textslider(Doomsday_Heist_Prep, Labels.HeistPrep, {}, "", Tables.CompleteReset, function(value)
    if value == 1 then
        STAT_SET_INT(ADD_MP_INDEX("GANGOPS_FM_MISSION_PROG"), -1)
    else
        STAT_SET_INT(ADD_MP_INDEX("GANGOPS_FM_MISSION_PROG"), 0)
    end
    util.toast("写入完成, 你可能需要重新进入设施来刷新面板")
end)

menu.textslider(Doomsday_Heist_Prep, Labels.HeistSetup, {}, "", Tables.CompleteReset, function(value)
    if value == 1 then
        STAT_SET_INT(ADD_MP_INDEX("GANGOPS_FLOW_MISSION_PROG"), -1)
    else
        STAT_SET_INT(ADD_MP_INDEX("GANGOPS_FLOW_MISSION_PROG"), 0)
    end
    util.toast("写入完成, 你可能需要重新进入设施来刷新面板")
end)


menu.divider(Doomsday_Heist_Prep, "自定义")

-- Doomsday Heist Preps

local Doomsday_Heist_Preps <const> = menu.list(Doomsday_Heist_Prep, "前置任务编辑", {}, "")

menu.action(Doomsday_Heist_Preps, "读取 GANGOPS_FM_MISSION_PROG", {}, "", function()
    if not IS_PLAYER_GANG_OPS_HEIST_ACTIVE() then
        DoomsdayHeistPrepVars.Prep.iBitset = nil
        util.toast("你似乎未进行任何抢劫")
        return
    end

    local iStatInt = STAT_GET_INT(ADD_MP_INDEX("GANGOPS_FM_MISSION_PROG"))
    menu.set_value(DoomsdayHeistPrepVars.Prep.menuValue, iStatInt)
    DoomsdayHeistPrepVars.Prep.iBitset = iStatInt

    for bit, command in pairs(DoomsdayHeistPrepVars.Prep.menuList) do
        if BIT_TEST(iStatInt, bit) then
            menu.set_value(command, true)
        else
            menu.set_value(command, false)
        end
    end
end)

DoomsdayHeistPrepVars.Prep.menuValue = menu.readonly(Doomsday_Heist_Preps, "值")

menu.action(Doomsday_Heist_Preps, "写入 GANGOPS_FM_MISSION_PROG", {}, "", function()
    if DoomsdayHeistPrepVars.Prep.iBitset == nil then
        return
    end

    STAT_SET_INT(ADD_MP_INDEX("GANGOPS_FM_MISSION_PROG"), DoomsdayHeistPrepVars.Prep.iBitset)
    util.toast("写入完成, 你可能需要重新进入设施来刷新面板")
end)

for _, item in pairs(Tables.DoomsdayHeistPrepListData) do
    if item.menu == "toggle" then
        local menu_toggle = menu.toggle(Doomsday_Heist_Preps, item.name, {}, item.help_text, function(toggle, click_type)
            if click_type == CLICK_SCRIPTED or DoomsdayHeistPrepVars.Prep.iBitset == nil then
                return
            end

            if toggle then
                DoomsdayHeistPrepVars.Prep.iBitset = SET_BIT(DoomsdayHeistPrepVars.Prep.iBitset, item.bit)
            else
                DoomsdayHeistPrepVars.Prep.iBitset = CLEAR_BIT(DoomsdayHeistPrepVars.Prep.iBitset, item.bit)
            end
            menu.set_value(DoomsdayHeistPrepVars.Prep.menuValue, DoomsdayHeistPrepVars.Prep.iBitset)
        end)

        DoomsdayHeistPrepVars.Prep.menuList[item.bit] = menu_toggle
    else
        menu.divider(Doomsday_Heist_Preps, item.name)
    end
end

-- Doomsday Heist Setups

local Doomsday_Heist_Setups <const> = menu.list(Doomsday_Heist_Prep, "准备任务编辑", {}, "")

menu.action(Doomsday_Heist_Setups, "读取 GANGOPS_FLOW_MISSION_PROG", {}, "", function()
    if not IS_PLAYER_GANG_OPS_HEIST_ACTIVE() then
        DoomsdayHeistPrepVars.Setup.iBitset = nil
        util.toast("你似乎未进行任何抢劫")
        return
    end

    local iStatInt = STAT_GET_INT(ADD_MP_INDEX("GANGOPS_FLOW_MISSION_PROG"))
    menu.set_value(DoomsdayHeistPrepVars.Setup.menuValue, iStatInt)
    DoomsdayHeistPrepVars.Setup.iBitset = iStatInt

    for bit, command in pairs(DoomsdayHeistPrepVars.Setup.menuList) do
        if BIT_TEST(iStatInt, bit) then
            menu.set_value(command, true)
        else
            menu.set_value(command, false)
        end
    end
end)

DoomsdayHeistPrepVars.Setup.menuValue = menu.readonly(Doomsday_Heist_Setups, "值")

menu.action(Doomsday_Heist_Setups, "写入 GANGOPS_FLOW_MISSION_PROG", {}, "", function()
    if DoomsdayHeistPrepVars.Setup.iBitset == nil then
        return
    end

    STAT_SET_INT(ADD_MP_INDEX("GANGOPS_FLOW_MISSION_PROG"), DoomsdayHeistPrepVars.Setup.iBitset)
    util.toast("写入完成, 你可能需要重新进入设施来刷新面板")
end)

for _, item in pairs(Tables.DoomsdayHeistSetupListData) do
    if item.menu == "toggle" then
        local menu_toggle = menu.toggle(Doomsday_Heist_Setups, item.name, {}, item.help_text,
            function(toggle, click_type)
                if click_type == CLICK_SCRIPTED or DoomsdayHeistPrepVars.Setup.iBitset == nil then
                    return
                end

                if toggle then
                    DoomsdayHeistPrepVars.Setup.iBitset = SET_BIT(DoomsdayHeistPrepVars.Setup.iBitset, item.bit)
                else
                    DoomsdayHeistPrepVars.Setup.iBitset = CLEAR_BIT(DoomsdayHeistPrepVars.Setup.iBitset, item.bit)
                end
                menu.set_value(DoomsdayHeistPrepVars.Setup.menuValue, DoomsdayHeistPrepVars.Setup.iBitset)
            end)

        DoomsdayHeistPrepVars.Setup.menuList[item.bit] = menu_toggle
    else
        menu.divider(Doomsday_Heist_Setups, item.name)
    end
end


--#endregion



--#region Casino Heist Prep

--------------------------------
-- Casino Heist Prep
--------------------------------

local CasinoHeistPrepVars = {
    Mandatory = {
        iBitset = nil,
        menuList = {},
    },
    Optional = {
        iBitset = nil,
        menuList = {},
    },
    SupportCrew = {},
    Other = {},
}

menu.divider(Casino_Heist_Prep, "一键")

menu.textslider(Casino_Heist_Prep, get_label_text("CH_DP_MAND"), {}, "", Tables.CompleteReset, function(value)
    if value == 1 then
        STAT_SET_INT(ADD_MP_INDEX("H3OPT_BITSET1"), -1)
    else
        STAT_SET_INT(ADD_MP_INDEX("H3OPT_BITSET1"), 0)
    end
end)
menu.textslider(Casino_Heist_Prep, get_label_text("CH_DP_OPT"), {}, "", Tables.CompleteReset, function(value)
    if value == 1 then
        STAT_SET_INT(ADD_MP_INDEX("H3OPT_BITSET0"), -1)
    else
        STAT_SET_INT(ADD_MP_INDEX("H3OPT_BITSET0"), 0)
    end
end)
menu.textslider(Casino_Heist_Prep, get_label_text("CHB_CREW"), {}, "", Tables.CompleteReset, function(value)
    if value == 1 then
        STAT_SET_INT(ADD_MP_INDEX("H3OPT_CREWWEAP"), 1)
        STAT_SET_INT(ADD_MP_INDEX("H3OPT_WEAPS"), 0)

        STAT_SET_INT(ADD_MP_INDEX("H3OPT_CREWDRIVER"), 1)
        STAT_SET_INT(ADD_MP_INDEX("H3OPT_VEHS"), 0)

        STAT_SET_INT(ADD_MP_INDEX("H3OPT_CREWHACKER"), 1)
    else
        STAT_SET_INT(ADD_MP_INDEX("H3OPT_CREWWEAP"), 0)
        STAT_SET_INT(ADD_MP_INDEX("H3OPT_WEAPS"), 0)

        STAT_SET_INT(ADD_MP_INDEX("H3OPT_CREWDRIVER"), 0)
        STAT_SET_INT(ADD_MP_INDEX("H3OPT_VEHS"), 0)

        STAT_SET_INT(ADD_MP_INDEX("H3OPT_CREWHACKER"), 0)
    end
end)

menu.divider(Casino_Heist_Prep, "自定义")

-- Casino Heist Mandatory Preps

local Casino_Heist_Prep_Mandatory <const> = menu.list(Casino_Heist_Prep, get_label_text("CH_DP_MAND"), {}, "")

menu.action(Casino_Heist_Prep_Mandatory, "读取 H3OPT_BITSET1", {}, "", function()
    if not IS_PLAYER_CASINO_HEIST_ACTIVE() then
        CasinoHeistPrepVars.Mandatory.iBitset = nil
        util.toast("你似乎未进行赌场抢劫")
        return
    end

    local iStatInt = STAT_GET_INT(ADD_MP_INDEX("H3OPT_BITSET1"))
    menu.set_value(CasinoHeistPrepVars.Mandatory.menuValue, iStatInt)
    CasinoHeistPrepVars.Mandatory.iBitset = iStatInt

    for bit, command in pairs(CasinoHeistPrepVars.Mandatory.menuList) do
        if BIT_TEST(iStatInt, bit) then
            menu.set_value(command, true)
        else
            menu.set_value(command, false)
        end
    end
end)

CasinoHeistPrepVars.Mandatory.menuValue = menu.readonly(Casino_Heist_Prep_Mandatory, "值")

menu.action(Casino_Heist_Prep_Mandatory, "写入 H3OPT_BITSET1", {}, "", function()
    if CasinoHeistPrepVars.Mandatory.iBitset == nil then
        return
    end

    STAT_SET_INT(ADD_MP_INDEX("H3OPT_BITSET1"), CasinoHeistPrepVars.Mandatory.iBitset)
    util.toast("写入完成, 你可能需要重新进入游戏厅来刷新面板")
end)

for _, item in pairs(Tables.CasinoHeistMandatoryPrepListData) do
    if item.menu == "toggle" then
        local menu_toggle = menu.toggle(Casino_Heist_Prep_Mandatory, item.name, {}, item.help_text,
            function(toggle, click_type)
                if click_type == CLICK_SCRIPTED or CasinoHeistPrepVars.Mandatory.iBitset == nil then
                    return
                end

                if toggle then
                    CasinoHeistPrepVars.Mandatory.iBitset = SET_BIT(CasinoHeistPrepVars.Mandatory.iBitset, item.bit)
                else
                    CasinoHeistPrepVars.Mandatory.iBitset = CLEAR_BIT(CasinoHeistPrepVars.Mandatory.iBitset, item.bit)
                end
                menu.set_value(CasinoHeistPrepVars.Mandatory.menuValue, CasinoHeistPrepVars.Mandatory.iBitset)
            end)

        CasinoHeistPrepVars.Mandatory.menuList[item.bit] = menu_toggle
    else
        menu.divider(Casino_Heist_Prep_Mandatory, item.name)
    end
end

-- Casino Heist Optional Preps

local Casino_Heist_Prep_Optional <const> = menu.list(Casino_Heist_Prep, get_label_text("CH_DP_OPT"), {}, "")

menu.action(Casino_Heist_Prep_Optional, "读取 H3OPT_BITSET0", {}, "", function()
    if not IS_PLAYER_CASINO_HEIST_ACTIVE() then
        CasinoHeistPrepVars.Optional.iBitset = nil
        util.toast("你似乎未进行赌场抢劫")
        return
    end

    local iStatInt = STAT_GET_INT(ADD_MP_INDEX("H3OPT_BITSET0"))
    menu.set_value(CasinoHeistPrepVars.Optional.menuValue, iStatInt)
    CasinoHeistPrepVars.Optional.iBitset = iStatInt

    for bit, command in pairs(CasinoHeistPrepVars.Optional.menuList) do
        if BIT_TEST(iStatInt, bit) then
            menu.set_value(command, true)
        else
            menu.set_value(command, false)
        end
    end
end)

CasinoHeistPrepVars.Optional.menuValue = menu.readonly(Casino_Heist_Prep_Optional, "值")

menu.action(Casino_Heist_Prep_Optional, "写入 H3OPT_BITSET0", {}, "", function()
    if CasinoHeistPrepVars.Optional.iBitset == nil then
        return
    end

    STAT_SET_INT(ADD_MP_INDEX("H3OPT_BITSET0"), CasinoHeistPrepVars.Optional.iBitset)
    util.toast("写入完成, 你可能需要重新进入游戏厅来刷新面板")
end)

for _, item in pairs(Tables.CasinoHeistOptionalPrepListData) do
    if item.menu == "toggle" then
        local menu_toggle = menu.toggle(Casino_Heist_Prep_Optional, item.name, {}, item.help_text,
            function(toggle, click_type)
                if click_type == CLICK_SCRIPTED or CasinoHeistPrepVars.Optional.iBitset == nil then
                    return
                end

                if toggle then
                    CasinoHeistPrepVars.Optional.iBitset = SET_BIT(CasinoHeistPrepVars.Optional.iBitset, item.bit)
                else
                    CasinoHeistPrepVars.Optional.iBitset = CLEAR_BIT(CasinoHeistPrepVars.Optional.iBitset, item.bit)
                end
                menu.set_value(CasinoHeistPrepVars.Optional.menuValue, CasinoHeistPrepVars.Optional.iBitset)
            end)

        CasinoHeistPrepVars.Optional.menuList[item.bit] = menu_toggle
    else
        menu.divider(Casino_Heist_Prep_Optional, item.name)
    end
end

-- Casino Heist Support Crew

local Casino_Heist_Prep_Support <const> = menu.list(Casino_Heist_Prep, get_label_text("CHB_CREW"), {}, "")

menu.action(Casino_Heist_Prep_Support, "读取", {}, "", function()
    if not IS_PLAYER_CASINO_HEIST_ACTIVE() then
        util.toast("你似乎未进行赌场抢劫")
        return
    end

    for stat, command in pairs(CasinoHeistPrepVars.SupportCrew) do
        local value = STAT_GET_INT(ADD_MP_INDEX(stat))
        menu.set_value(command, value)
    end
end)
menu.action(Casino_Heist_Prep_Support, "写入", {}, "", function()
    for stat, command in pairs(CasinoHeistPrepVars.SupportCrew) do
        local value = menu.get_value(command)
        STAT_SET_INT(ADD_MP_INDEX(stat), value)
    end

    util.toast("写入完成, 你可能需要重新进入游戏厅来刷新面板")
end)

menu.divider(Casino_Heist_Prep_Support, "")

CasinoHeistPrepVars.SupportCrew["H3OPT_CREWWEAP"] = menu.list_select(Casino_Heist_Prep_Support,
    get_label_text("CH_WE_EXPR"), {}, "",
    Tables.CasinoHeistGunman, 0, function(value) end)

CasinoHeistPrepVars.SupportCrew["H3OPT_WEAPS"] = menu.list_select(Casino_Heist_Prep_Support,
    get_label_text("CHB_WEAPON"), {}, "", {
        { 0, Labels.Default },
        { 1, "Alternate" },
    }, 0, function(value) end)

CasinoHeistPrepVars.SupportCrew["H3OPT_CREWDRIVER"] = menu.list_select(Casino_Heist_Prep_Support,
    get_label_text("CH_DR_EXPR"), {}, "",
    Tables.CasinoHeistDriver, 0, function(value) end)

CasinoHeistPrepVars.SupportCrew["H3OPT_VEHS"] = menu.list_select(Casino_Heist_Prep_Support,
    get_label_text("CHB_VEHICLE"), {}, "", {
        { 0, Labels.Default },
        { 1, "Alternate 1" },
        { 2, "Alternate 2" },
        { 3, "Alternate 3" },
    }, 0, function(value) end)

CasinoHeistPrepVars.SupportCrew["H3OPT_CREWHACKER"] = menu.list_select(Casino_Heist_Prep_Support,
    get_label_text("CH_HR_EXPR"), {}, "",
    Tables.CasinoHeistHacker, 0, function(value) end)


-- Casino Heist Other

local Casino_Heist_Prep_Other <const> = menu.list(Casino_Heist_Prep, Labels.Other, {}, "")

menu.action(Casino_Heist_Prep_Other, "读取", {}, "", function()
    if not IS_PLAYER_CASINO_HEIST_ACTIVE() then
        util.toast("你似乎未进行赌场抢劫")
        return
    end

    for stat, command in pairs(CasinoHeistPrepVars.Other) do
        local value = STAT_GET_INT(ADD_MP_INDEX(stat))
        menu.set_value(command, value)
    end
end)
menu.action(Casino_Heist_Prep_Other, "写入", {}, "", function()
    for stat, command in pairs(CasinoHeistPrepVars.Other) do
        local value = menu.get_value(command)
        STAT_SET_INT(ADD_MP_INDEX(stat), value)
    end

    util.toast("写入完成, 你可能需要重新进入游戏厅来刷新面板")
end)

menu.divider(Casino_Heist_Prep_Other, get_label_text("CH_DP_MAND"))

CasinoHeistPrepVars.Other["H3OPT_APPROACH"] = menu.list_select(Casino_Heist_Prep_Other,
    get_label_text("CHB_APPROACH"), {}, "", Tables.CasinoHeistApproach2, 0, function(value) end)

CasinoHeistPrepVars.Other["H3OPT_TARGET"] = menu.list_select(Casino_Heist_Prep_Other,
    get_label_text("CHB_TARGET"), {}, "", Tables.CasinoHeistTarget, 0, function(value) end)

CasinoHeistPrepVars.Other["H3_HARD_APPROACH"] = menu.list_select(Casino_Heist_Prep_Other,
    get_label_text("CHB_APPROACH") .. " (Hard)", {}, "",
    Tables.CasinoHeistApproach2, 0, function(value) end)

CasinoHeistPrepVars.Other["H3_LAST_APPROACH"] = menu.list_select(Casino_Heist_Prep_Other,
    get_label_text("CHB_APPROACH") .. " (Last)", {}, "",
    Tables.CasinoHeistApproach2, 0, function(value) end)

menu.divider(Casino_Heist_Prep_Other, get_label_text("CH_DP_OPT"))

CasinoHeistPrepVars.Other["H3OPT_DISRUPTSHIP"] = menu.slider(Casino_Heist_Prep_Other, get_label_text("CH_OPT_PREP_1"),
    {}, "", 0, 3, 0, 1, function(value) end)

CasinoHeistPrepVars.Other["H3OPT_KEYLEVELS"] = menu.slider(Casino_Heist_Prep_Other, get_label_text("CSH_ITEM_APS"),
    {}, "", 0, 2, 0, 1, function(value) end)

CasinoHeistPrepVars.Other["H3OPT_MASKS"] = menu.list_select(Casino_Heist_Prep_Other, get_label_text("CH_OPT_PREP_5"),
    {}, "", Tables.CasinoHeistMasks, 0, function(value) end)

CasinoHeistPrepVars.Other["H3OPT_MODVEH"] = menu.list_select(Casino_Heist_Prep_Other, get_label_text("GETA_MOD_T"),
    {}, "", {
        { 0, Labels.None },
        { 1, get_label_text("GETA_MOD_0") },
        { 2, get_label_text("GETA_MOD_1") },
        { 3, get_label_text("GETA_MOD_2") },
    }, 0, function(value) end)


--#endregion



--#region Island Heist Prep

--------------------------------
-- Island Heist Prep
--------------------------------

local IslandHeistPrepVars = {
    H4_MISSIONS = {},
    BITSET_STATS = {
        [12] = "H4CNF_WEAPONS",
        [13] = "H4CNF_WEP_DISRP",
        [14] = "H4CNF_ARM_DISRP",
        [15] = "H4CNF_HEL_DISRP"
    },
}


menu.action(Island_Heist_Prep, "读取", {}, "", function()
    if not IS_PLAYER_ISLAND_HEIST_ACTIVE() then
        util.toast("你似乎未进行佩里科岛抢劫")
        return
    end

    menu.set_value(IslandHeistPrepVars.MainTarget, STAT_GET_INT(ADD_MP_INDEX("H4CNF_TARGET")))


    local h4_progress = STAT_GET_INT(ADD_MP_INDEX("H4_PROGRESS"))
    menu.set_value(IslandHeistPrepVars.HardMode, BIT_TEST(h4_progress, 12))



    local h4_missions = STAT_GET_INT(ADD_MP_INDEX("H4_MISSIONS"))
    for bit = 0, 11, 1 do
        menu.set_value(IslandHeistPrepVars.H4_MISSIONS[bit], BIT_TEST(h4_missions, bit))
    end

    for bit, stat in pairs(IslandHeistPrepVars.BITSET_STATS) do
        if BIT_TEST(h4_missions, bit) then
            menu.set_value(IslandHeistPrepVars.H4_MISSIONS[bit], STAT_GET_INT(ADD_MP_INDEX(stat)))
        else
            menu.set_value(IslandHeistPrepVars.H4_MISSIONS[bit], 0)
        end
    end
end)

menu.action(Island_Heist_Prep, "写入", {}, "", function()
    if not IS_PLAYER_ISLAND_HEIST_ACTIVE() then
        util.toast("你似乎未进行佩里科岛抢劫")
        return
    end

    STAT_SET_INT(ADD_MP_INDEX("H4CNF_TARGET"), menu.get_value(IslandHeistPrepVars.MainTarget))


    local h4_progress = STAT_GET_INT(ADD_MP_INDEX("H4_PROGRESS"))
    if menu.get_value(IslandHeistPrepVars.HardMode) then
        STAT_SET_INT(ADD_MP_INDEX("H4_PROGRESS"), SET_BIT(h4_progress, 12))
    else
        STAT_SET_INT(ADD_MP_INDEX("H4_PROGRESS"), CLEAR_BIT(h4_progress, 12))
    end


    local h4_missions = 0

    for bit = 0, 11, 1 do
        if menu.get_value(IslandHeistPrepVars.H4_MISSIONS[bit]) then
            h4_missions = SET_BIT(h4_missions, bit)
        end
    end

    for bit, stat in pairs(IslandHeistPrepVars.BITSET_STATS) do
        local value = menu.get_value(IslandHeistPrepVars.H4_MISSIONS[bit])
        if value > 0 then
            h4_missions = SET_BIT(h4_missions, bit)
            STAT_SET_INT(ADD_MP_INDEX(stat), value)
        end
    end

    STAT_SET_INT(ADD_MP_INDEX("H4_MISSIONS"), h4_missions)

    util.toast("写入完成, 你可能需要重新进入虎鲸来刷新面板")
end)


menu.divider(Island_Heist_Prep, "目标")

IslandHeistPrepVars.MainTarget = menu.list_select(Island_Heist_Prep, get_label_text("IHB_MAIN_PAYOUT"), {}, "",
    Tables.IslandHeistMainTarget, 0, function(value) end)

IslandHeistPrepVars.HardMode = menu.toggle(Island_Heist_Prep, get_label_text("IHB_HARD_MODE"), {}, "",
    function(toggle) end)


menu.divider(Island_Heist_Prep, "前置")

IslandHeistPrepVars.H4_MISSIONS[0] = menu.toggle(Island_Heist_Prep, get_label_text("H4P_INT0_GATH_T"), {}, "",
    function(toggle) end)


IslandHeistPrepVars.ApproachVehicle = menu.list(Island_Heist_Prep, get_label_text("H4P_PRP0_APVH_T"), {}, "")
IslandHeistPrepVars.H4_MISSIONS[1] = menu.toggle(IslandHeistPrepVars.ApproachVehicle, get_label_text("H4P_PRP1_SUBM_T"),
    {}, "", function(toggle) end)
IslandHeistPrepVars.H4_MISSIONS[2] = menu.toggle(IslandHeistPrepVars.ApproachVehicle, get_label_text("H4P_PRP1_SBOM_T"),
    {}, "", function(toggle) end)
IslandHeistPrepVars.H4_MISSIONS[3] = menu.toggle(IslandHeistPrepVars.ApproachVehicle, get_label_text("H4P_PRP1_SPLA_T"),
    {}, "", function(toggle) end)
IslandHeistPrepVars.H4_MISSIONS[4] = menu.toggle(IslandHeistPrepVars.ApproachVehicle, get_label_text("H4P_PRP1_SHEL_T"),
    {}, "", function(toggle) end)
IslandHeistPrepVars.H4_MISSIONS[5] = menu.toggle(IslandHeistPrepVars.ApproachVehicle, get_label_text("H4P_PRP1_PBOA_T"),
    {}, "", function(toggle) end)
IslandHeistPrepVars.H4_MISSIONS[6] = menu.toggle(IslandHeistPrepVars.ApproachVehicle, get_label_text("H4P_PRP1_SBOA_T"),
    {}, "", function(toggle) end)
IslandHeistPrepVars.H4_MISSIONS[7] = menu.toggle(IslandHeistPrepVars.ApproachVehicle, get_label_text("H4P_PRP1_HEL2_T"),
    {}, "", function(toggle) end)


IslandHeistPrepVars.Equipment = menu.list(Island_Heist_Prep, get_label_text("H4P_PRP0_EQUI_T"), {}, "")
IslandHeistPrepVars.H4_MISSIONS[8] = menu.toggle(IslandHeistPrepVars.Equipment, get_label_text("H4P_PRP2_DEMC_T"), {},
    "", function(toggle) end)
IslandHeistPrepVars.H4_MISSIONS[9] = menu.toggle(IslandHeistPrepVars.Equipment, get_label_text("H4P_PRP2_ATOR_T"), {},
    "", function(toggle) end)
IslandHeistPrepVars.H4_MISSIONS[10] = menu.toggle(IslandHeistPrepVars.Equipment,
    string.format("%s (%s)", get_label_text("H4P_PRP2_TAR1_T"), get_label_text("H4P_PRP2_TAR2_T")),
    {}, "", function(toggle) end)
IslandHeistPrepVars.H4_MISSIONS[11] = menu.toggle(IslandHeistPrepVars.Equipment, get_label_text("H4P_PRP2_FING_T"), {},
    "", function(toggle) end)


IslandHeistPrepVars.H4_MISSIONS[12] = menu.list_select(Island_Heist_Prep, get_label_text("H4P_PRP0_WEPL_T"), {}, "", {
    { 0, Labels.NONE },
    { 1, get_label_text("H4P_PRP3_SHOT_T"), {}, get_label_text("H4P_FIN6_SHOT_I") }, -- AGGRESSOR
    { 2, get_label_text("H4P_PRP3_RIFL_T"), {}, get_label_text("H4P_FIN6_RIFL_I") }, -- CONSPIRATOR
    { 3, get_label_text("H4P_PRP3_SNIP_T"), {}, get_label_text("H4P_FIN6_SNIP_I") }, -- CRACK SHOT
    { 4, get_label_text("H4P_PRP3_M2SM_T"), {}, get_label_text("H4P_FIN6_M2SM_I") }, -- SABOTEUR
    { 5, get_label_text("H4P_PRP3_M2RI_T"), {}, get_label_text("H4P_FIN6_M2RI_I") }  -- MARKSMAN
}, 0, function(value) end)


IslandHeistPrepVars.Disruption = menu.list(Island_Heist_Prep, get_label_text("H4P_PRP0_DISR_T"), {}, "")
IslandHeistPrepVars.H4_MISSIONS[13] = menu.list_select(IslandHeistPrepVars.Disruption,
    get_label_text("H4P_PRP4_WEAP_T"), {}, "", {
        { 0, "None" }, { 1, "Low" }, { 2, "Medium" }, { 3, "High" }
    }, 0, function(value) end)
IslandHeistPrepVars.H4_MISSIONS[14] = menu.list_select(IslandHeistPrepVars.Disruption,
    get_label_text("H4P_PRP4_ARMR_T"), {}, "", {
        { 0, "None" }, { 1, "Low" }, { 2, "Medium" }, { 3, "High" }
    }, 0, function(value) end)
IslandHeistPrepVars.H4_MISSIONS[15] = menu.list_select(IslandHeistPrepVars.Disruption,
    get_label_text("H4P_PRP4_BRES_T"), {}, "", {
        { 0, "None" }, { 1, "Low" }, { 2, "Medium" }, { 3, "High" }
    }, 0, function(value) end)




--------------------------------
-- Island Heist Prep Secondary
--------------------------------

--

IslandHeistPrepVars.Secondary = {
    CompoundLoot = {},
    CompoundPainting = {},
    IslandLoot = {},
    LootValue = {},

    ADDITIONAL_LOOT_COMPOUND_LOCATIONS = {
        { 0, "ONE_1" },
        { 1, "ONE_2" },
        { 2, "TWO_1" },
        { 3, "TWO_2" },
        { 4, "THREE_1" },
        { 5, "THREE_2" },
        { 6, "BASEMENT_1" },
        { 7, "BASEMENT_2" }
    },
    PAINTING_LOCATIONS = {
        { 0, "ONE" },
        { 1, "TWO" },
        { 2, "THREE" },
        { 3, "FOUR" },
        { 4, "FIVE" },
        { 5, "SIX" },
        { 6, "SEVEN" }
    },
    ADDITIONAL_LOOT_ISLAND_LOCATIONS = {
        AIRSTRIP = {
            { 0, "AIRSTRIP_HIGHER_1" },
            { 1, "AIRSTRIP_HIGHER_2" },
            { 2, "AIRSTRIP_LOWER_1" },
            { 3, "AIRSTRIP_LOWER_2" },
            { 4, "AIRSTRIP_RUNWAY_1" },
            { 5, "AIRSTRIP_RUNWAY_2" }
        },
        NORTH_DOCK = {
            { 6,  "NORTH_DOCK_WAREHOUSE_1" },
            { 7,  "NORTH_DOCK_WAREHOUSE_2" },
            { 8,  "NORTH_DOCK_LEVER_1" },
            { 9,  "NORTH_DOCK_LEVER_2" },
            { 10, "NORTH_DOCK_LEVER_3" },
            { 11, "NORTH_DOCK_LOCKUP_1" },
            { 12, "NORTH_DOCK_LOCKUP_2" }
        },
        DRUG_PROCESSING = {
            { 13, "DRUG_PROCESSING_SOUTH_1" },
            { 14, "DRUG_PROCESSING_SOUTH_2" },
            { 15, "DRUG_PROCESSING_NORTH_1" },
            { 16, "DRUG_PROCESSING_NORTH_2" }
        },
        MAIN_DOCK = {
            { 17, "MAIN_DOCK_EAST_1" },
            { 18, "MAIN_DOCK_EAST_2" },
            { 19, "MAIN_DOCK_LEVER_1" },
            { 20, "MAIN_DOCK_LEVER_2" },
            { 21, "MAIN_DOCK_LEVER_3" },
            { 22, "MAIN_DOCK_SOUTH_1" },
            { 23, "MAIN_DOCK_SOUTH_2" }
        }
    }

}


local function GET_ISLAND_HEIST_ADDITIONAL_LOOT(locationBitSet, lootLocationsBitSet)
    if BIT_TEST(lootLocationsBitSet.cash, locationBitSet) then
        return 1
    end
    if BIT_TEST(lootLocationsBitSet.weed, locationBitSet) then
        return 2
    end
    if BIT_TEST(lootLocationsBitSet.coke, locationBitSet) then
        return 3
    end
    if BIT_TEST(lootLocationsBitSet.gold, locationBitSet) then
        return 4
    end
    return 0
end

local function SET_ISLAND_HEIST_ADDITIONAL_LOOT(locationBitSet, lootLocationsBitSet, lootType)
    if lootType == 0 then
        return lootLocationsBitSet
    end
    if lootType == 1 then
        lootLocationsBitSet.cash = SET_BIT(lootLocationsBitSet.cash, locationBitSet)
        return lootLocationsBitSet
    end
    if lootType == 2 then
        lootLocationsBitSet.weed = SET_BIT(lootLocationsBitSet.weed, locationBitSet)
        return lootLocationsBitSet
    end
    if lootType == 3 then
        lootLocationsBitSet.coke = SET_BIT(lootLocationsBitSet.coke, locationBitSet)
        return lootLocationsBitSet
    end
    if lootType == 4 then
        lootLocationsBitSet.gold = SET_BIT(lootLocationsBitSet.gold, locationBitSet)
        return lootLocationsBitSet
    end
end



menu.action(Island_Heist_Prep_Secondary, "读取", {}, "", function()
    if not IS_PLAYER_ISLAND_HEIST_ACTIVE() then
        util.toast("你似乎未进行佩里科岛抢劫")
        return
    end

    local lootCompound = {
        cash = STAT_GET_INT(ADD_MP_INDEX("H4LOOT_CASH_C")),
        weed = STAT_GET_INT(ADD_MP_INDEX("H4LOOT_WEED_C")),
        coke = STAT_GET_INT(ADD_MP_INDEX("H4LOOT_COKE_C")),
        gold = STAT_GET_INT(ADD_MP_INDEX("H4LOOT_GOLD_C"))
    }
    local paintings = STAT_GET_INT(ADD_MP_INDEX("H4LOOT_PAINT"))
    local lootIsland = {
        cash = STAT_GET_INT(ADD_MP_INDEX("H4LOOT_CASH_I")),
        weed = STAT_GET_INT(ADD_MP_INDEX("H4LOOT_WEED_I")),
        coke = STAT_GET_INT(ADD_MP_INDEX("H4LOOT_COKE_I")),
        gold = STAT_GET_INT(ADD_MP_INDEX("H4LOOT_GOLD_I"))
    }

    for bit, command in pairs(IslandHeistPrepVars.Secondary.CompoundLoot) do
        local lootType = GET_ISLAND_HEIST_ADDITIONAL_LOOT(bit, lootCompound)
        menu.set_value(command, lootType)
    end

    for bit, command in pairs(IslandHeistPrepVars.Secondary.CompoundPainting) do
        menu.set_value(command, BIT_TEST(paintings, bit))
    end

    for bit, command in pairs(IslandHeistPrepVars.Secondary.IslandLoot) do
        local lootType = GET_ISLAND_HEIST_ADDITIONAL_LOOT(bit, lootIsland)
        menu.set_value(command, lootType)
    end

    for stat, command in pairs(IslandHeistPrepVars.Secondary.LootValue) do
        menu.set_value(command, STAT_GET_INT(ADD_MP_INDEX(stat)))
    end
end)

menu.action(Island_Heist_Prep_Secondary, "写入", {}, "", function()
    if not IS_PLAYER_ISLAND_HEIST_ACTIVE() then
        util.toast("你似乎未进行佩里科岛抢劫")
        return
    end

    local lootCompound = {
        cash = 0,
        weed = 0,
        coke = 0,
        gold = 0
    }
    for bit, command in pairs(IslandHeistPrepVars.Secondary.CompoundLoot) do
        local lootType = menu.get_value(command)
        lootCompound = SET_ISLAND_HEIST_ADDITIONAL_LOOT(bit, lootCompound, lootType)
    end

    local paintings = 0
    for bit, command in pairs(IslandHeistPrepVars.Secondary.CompoundPainting) do
        if menu.get_value(command) then
            paintings = SET_BIT(paintings, bit)
        end
    end

    local lootIsland = {
        cash = 0,
        weed = 0,
        coke = 0,
        gold = 0
    }
    for bit, command in pairs(IslandHeistPrepVars.Secondary.IslandLoot) do
        local lootType = menu.get_value(command)
        lootIsland = SET_ISLAND_HEIST_ADDITIONAL_LOOT(bit, lootIsland, lootType)
    end


    for stat, command in pairs(IslandHeistPrepVars.Secondary.LootValue) do
        STAT_SET_INT(ADD_MP_INDEX(stat), menu.get_value(command))
    end


    STAT_SET_INT(ADD_MP_INDEX("H4LOOT_CASH_C"), lootCompound.cash)
    STAT_SET_INT(ADD_MP_INDEX("H4LOOT_WEED_C"), lootCompound.weed)
    STAT_SET_INT(ADD_MP_INDEX("H4LOOT_COKE_C"), lootCompound.coke)
    STAT_SET_INT(ADD_MP_INDEX("H4LOOT_GOLD_C"), lootCompound.gold)

    STAT_SET_INT(ADD_MP_INDEX("H4LOOT_PAINT"), paintings)

    STAT_SET_INT(ADD_MP_INDEX("H4LOOT_CASH_I"), lootIsland.cash)
    STAT_SET_INT(ADD_MP_INDEX("H4LOOT_WEED_I"), lootIsland.weed)
    STAT_SET_INT(ADD_MP_INDEX("H4LOOT_COKE_I"), lootIsland.coke)
    STAT_SET_INT(ADD_MP_INDEX("H4LOOT_GOLD_I"), lootIsland.gold)

    STAT_SET_INT(ADD_MP_INDEX("H4LOOT_CASH_C_SCOPED"), lootCompound.cash)
    STAT_SET_INT(ADD_MP_INDEX("H4LOOT_WEED_C_SCOPED"), lootCompound.weed)
    STAT_SET_INT(ADD_MP_INDEX("H4LOOT_COKE_C_SCOPED"), lootCompound.coke)
    STAT_SET_INT(ADD_MP_INDEX("H4LOOT_GOLD_C_SCOPED"), lootCompound.gold)
    STAT_SET_INT(ADD_MP_INDEX("H4LOOT_PAIN_SCOPEDT"), paintings)
    STAT_SET_INT(ADD_MP_INDEX("H4LOOT_CASH_I_SCOPED"), lootIsland.cash)
    STAT_SET_INT(ADD_MP_INDEX("H4LOOT_WEED_I_SCOPED"), lootIsland.weed)
    STAT_SET_INT(ADD_MP_INDEX("H4LOOT_COKE_I_SCOPED"), lootIsland.coke)
    STAT_SET_INT(ADD_MP_INDEX("H4LOOT_GOLD_I_SCOPED"), lootIsland.gold)

    util.toast("写入完成, 你可能需要重新进入虎鲸来刷新面板")
end)


menu.divider(Island_Heist_Prep_Secondary, "豪宅内")

IslandHeistPrepVars.Secondary.MenuCompoundLoot = menu.list(Island_Heist_Prep_Secondary, get_label_text("IHB_SUB_PAYOUT"),
    {}, "")
for _, item in pairs(IslandHeistPrepVars.Secondary.ADDITIONAL_LOOT_COMPOUND_LOCATIONS) do
    IslandHeistPrepVars.Secondary.CompoundLoot[item[1]] = menu.list_select(
        IslandHeistPrepVars.Secondary.MenuCompoundLoot,
        item[2], {}, "", Tables.IslandHeistAdditionalLoot, 0, function(value) end)
end

IslandHeistPrepVars.Secondary.MenuCompoundPainting = menu.list(Island_Heist_Prep_Secondary,
    get_label_text("H4P_INT2_PAIN_T"), {}, "")
for _, item in pairs(IslandHeistPrepVars.Secondary.PAINTING_LOCATIONS) do
    IslandHeistPrepVars.Secondary.CompoundPainting[item[1]] = menu.toggle(
        IslandHeistPrepVars.Secondary.MenuCompoundPainting,
        item[2], {}, "", function(toggle) end)
end


menu.divider(Island_Heist_Prep_Secondary, "豪宅外")

IslandHeistPrepVars.Secondary.MenuAirstripLoot = menu.list(Island_Heist_Prep_Secondary, "AIRSTRIP", {}, "")
for _, item in pairs(IslandHeistPrepVars.Secondary.ADDITIONAL_LOOT_ISLAND_LOCATIONS.AIRSTRIP) do
    IslandHeistPrepVars.Secondary.IslandLoot[item[1]] = menu.list_select(IslandHeistPrepVars.Secondary.MenuAirstripLoot,
        item[2], {}, "", Tables.IslandHeistAdditionalLoot, 0, function(value) end)
end

IslandHeistPrepVars.Secondary.MenuNorthDockLoot = menu.list(Island_Heist_Prep_Secondary, "NORTH DOCK", {}, "")
for _, item in pairs(IslandHeistPrepVars.Secondary.ADDITIONAL_LOOT_ISLAND_LOCATIONS.NORTH_DOCK) do
    IslandHeistPrepVars.Secondary.IslandLoot[item[1]] = menu.list_select(IslandHeistPrepVars.Secondary.MenuNorthDockLoot,
        item[2], {}, "", Tables.IslandHeistAdditionalLoot, 0, function(value) end)
end

IslandHeistPrepVars.Secondary.MenuDrugProcessingLoot = menu.list(Island_Heist_Prep_Secondary, "DRUG PROCESSING", {}, "")
for _, item in pairs(IslandHeistPrepVars.Secondary.ADDITIONAL_LOOT_ISLAND_LOCATIONS.DRUG_PROCESSING) do
    IslandHeistPrepVars.Secondary.IslandLoot[item[1]] = menu.list_select(
        IslandHeistPrepVars.Secondary.MenuDrugProcessingLoot,
        item[2], {}, "", Tables.IslandHeistAdditionalLoot, 0, function(value) end)
end

IslandHeistPrepVars.Secondary.MenuMainDockLoot = menu.list(Island_Heist_Prep_Secondary, "MAIN DOCK", {}, "")
for _, item in pairs(IslandHeistPrepVars.Secondary.ADDITIONAL_LOOT_ISLAND_LOCATIONS.MAIN_DOCK) do
    IslandHeistPrepVars.Secondary.IslandLoot[item[1]] = menu.list_select(IslandHeistPrepVars.Secondary.MenuMainDockLoot,
        item[2], {}, "", Tables.IslandHeistAdditionalLoot, 0, function(value) end)
end


menu.divider(Island_Heist_Prep_Secondary, "次要目标价值")

IslandHeistPrepVars.Secondary.LootValue["H4LOOT_CASH_V"] = menu.slider(Island_Heist_Prep_Secondary,
    get_label_text("H4P_INT2_CASH_T"), { "IslandHeistPrepCashValue" }, "",
    0, 10000000, 0, 10000, function(value) end)

IslandHeistPrepVars.Secondary.LootValue["H4LOOT_WEED_V"] = menu.slider(Island_Heist_Prep_Secondary,
    get_label_text("H4P_INT2_WEED_T"), { "IslandHeistPrepWeedValue" }, "",
    0, 10000000, 0, 10000, function(value) end)

IslandHeistPrepVars.Secondary.LootValue["H4LOOT_COKE_V"] = menu.slider(Island_Heist_Prep_Secondary,
    get_label_text("H4P_INT2_COKE_T"), { "IslandHeistPrepCokeValue" }, "",
    0, 10000000, 0, 10000, function(value) end)

IslandHeistPrepVars.Secondary.LootValue["H4LOOT_GOLD_V"] = menu.slider(Island_Heist_Prep_Secondary,
    get_label_text("H4P_INT2_GOLD_T"), { "IslandHeistPrepGoldValue" }, "",
    0, 10000000, 0, 10000, function(value) end)

IslandHeistPrepVars.Secondary.LootValue["H4LOOT_PAINT_V"] = menu.slider(Island_Heist_Prep_Secondary,
    get_label_text("H4P_INT2_PAIN_T"), { "IslandHeistPrepPaintValue" }, "",
    0, 10000000, 0, 10000, function(value) end)

--#endregion






menu.divider(Menu_Root, "")

local About_Options <const> = menu.list(Menu_Root, "关于", {}, "")

menu.readonly(About_Options, "Author", "Rostal")
menu.hyperlink(About_Options, "Github", "https://github.com/TCRoid/Stand-Lua-RS-Missions")
menu.readonly(About_Options, "Version", SCRIPT_VERSION)
menu.readonly(About_Options, "Support Game Version", SUPPORT_GAME_VERSION)




if DEBUG then
    require("YMS.RS_Missions.debug")
end
