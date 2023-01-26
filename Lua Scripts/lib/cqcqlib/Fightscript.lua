
--require("natives-1640181023")
--util.require_natives(1651208000)
util.require_natives(1663599433)
require("lib.cqcqlib.Fight_ped_list")
require("lib.cqcqlib.Fight_objects_list")
require("lib.cqcqlib.Fight_Lib")

util.keep_running()

local scriptName = "CqCq script3.0"

--local menuroot = menu.my_root()
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

CCAM = 0
STP_SPEED_MODIFIER = 0.02
STP_COORD_HEIGHT = 300

local function onStartup()
    SE_LocalPed = GetLocalPed()
    SE_Notifications = false -- notifications globally
    SEisExploInvis = true
    SEisExploAudible = false
    AIM_WHITELIST = {}
    --------
    util.toast("运行 " .. scriptName)
end

onStartup()

-----------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------

local lobbyFeats = menu.list(Fight_script, "战局功能", {}, "")

menu.divider(lobbyFeats, "恶搞")

menuAction(lobbyFeats, "所有人爆炸自杀", {"allsuicide"}, "", function()
    EveryoneExplodeSuicides()
end)

-----------------------------------------------------------------------------------------------------------------

local lobbyremove = menu.list(lobbyFeats, "全局移除", {}, "")

Pizzaall = menuAction(lobbyremove, "瘟疫崩溃", {"plagueall"}, "被大多数菜单屏蔽.", function ()
    menu.show_warning(Pizzaall, 1, "", PizzaCAll)
end)

menuAction(lobbyremove, "自由模式死亡", {"allfdeath"}, "可能对某些/大多数菜单不起作用. 各种各样的'延迟踢'.", function ()
    FreemodeDeathAll()
end)

TXC_SLOW = false

menuAction(lobbyremove, "AIO踢", {"allaiokick", "allaiok"}, "可能在某些菜单上不起作用.", function ()
    AIOKickAll()
end)

menuToggle(lobbyremove, "更慢但是更好的AIO踢", {}, "", function (on)
    TXC_SLOW = on
    if SE_Notifications then
        util.toast("" .. tostring(on))
    end
end)

----------------------------------------------------------------------------

local otherFeats = menu.list(lobbyFeats, "其他功能/工具", {}, "")
VehTeleportLoadIterations = 20

menuAction(otherFeats, "移除所有人的载具无敌", {"allremovevehgod"}, "", function ()
    RemoveVehicleGodmodeForAll()
end)

menuAction(otherFeats, "将所有人传送到海洋", {"alltpvehocean"}, "", function()
    TeleportEveryonesVehicleToOcean()
end)

menuAction(otherFeats, "将所有人传送到花园银行楼顶 ", {"alltpvehmazebank"}, "", function()
    TeleportEveryonesVehicleToMazeBank()
end)

menu.slider(otherFeats, "循环加载载具传送", {"vehloaditerations"}, "请记住,每次循环都是十分之一秒.默认值为20秒或2秒.", 1, 100, 20, 1, function(value)
    VehTeleportLoadIterations = value
end)

menuAction(otherFeats, "检查整个战局的无敌玩家", {}, "通知他们的名字.", function()
    CheckLobbyForGodmode()
end)


menuToggleLoop(otherFeats, "加入战局时向玩家敬酒", {}, "", function ()
    CheckLobbyForPlayers()
end)

-----------------------------------------------------------------------------------------------------------------------------------

--preload

local mFunFeats = menu.list(Fight_script, "武器功能", {"wpfeats"}, "")
menu.divider(mFunFeats, "粘性炸弹枪")

SE_stickyEntities = {}
SE_stickyCount = 1
----
SE_stickyvec3 = {}
SE_stickyvec3count = 1
----
menuToggleLoop(mFunFeats, "改进的粘性炸弹枪", {"sbgun"}, "记录下你射击的地点和内容,以便日后引爆.", function ()
    local pped = GetLocalPed() --get local ped, assign to "pped"
    if PED.IS_PED_SHOOTING(pped) then --check for shooting
        local tarEnt = memory.alloc() --allocate memory to get Target Entity
        local isEntFound = PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(players.user(), tarEnt) --is the entity found withing our aiming range?
        if isEntFound then --if the entity is found, then...
            local entt = memory.read_int(tarEnt) --get the entity handle
            SE_stickyEntities[SE_stickyCount] = entt --assign it to our table
            SE_stickyCount = SE_stickyCount + 1 --make our counter + 1
            if SE_Notifications then
                util.toast("标记实体.")
            end
        else --if we WEREN't aiming at an entity, then...
            local minevec3 = memory.alloc() --allocate memory for target coords
            local junk = WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(pped, minevec3) --get target coords
            local mv3 = memory.read_vector3(minevec3) --get v3 coords
            SE_stickyvec3[SE_stickyvec3count] = mv3 --assign to table
            SE_stickyvec3count = SE_stickyvec3count + 1 --counter + 1
            memory.free(minevec3)
            if SE_Notifications then
                util.toast("标记坐标.")
            end
        end
        memory.free(tarEnt)
    end
end)

menuAction(mFunFeats, "爆炸所有粘性炸弹", {"expsb"}, "爆炸所有标记的实体，并用一个粘性炸弹协调.", function ()
    for i = 1, #SE_stickyEntities do
        local targetC = getEntityCoords(SE_stickyEntities[i])
        SE_add_owned_explosion(GetLocalPed(), targetC.x, targetC.y, targetC.z, 2, 10, SEisExploAudible, SEisExploInvis, 0)
    end
    for i = 1, #SE_stickyvec3 do
        local tarc = SE_stickyvec3[i]
        SE_add_owned_explosion(GetLocalPed(), tarc.x, tarc.y, tarc.z, 2, 10, SEisExploAudible, SEisExploInvis, 0)
    end
    if SE_Notifications then
        util.toast("所有粘性炸弹都炸了!")
    end
end)

menuAction(mFunFeats, "解除所有粘性炸弹", {"clearsb"}, "", function ()
    if SE_Notifications then
        util.toast("所有粘性炸弹都删除了!")
    end
    SE_stickyEntities = {}
    SE_stickyCount = 1
    SE_stickyvec3 = {}
    SE_stickyvec3count = 1
end)


----
menu.divider(mFunFeats, "删除枪")
----


MarkedForExt = {}
MarkedForExtCount = 1
----
menuToggleLoop(mFunFeats, "改进的删除枪", {}, "", function ()
    local localPed = GetLocalPed()
    if PED.IS_PED_SHOOTING(localPed) then
        local point = memory.alloc(4)
        local isEntFound = PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(players.user(), point)
        if isEntFound then
            local entt = memory.read_int(point)
            if ENTITY.IS_ENTITY_A_PED(entt) and PED.IS_PED_IN_ANY_VEHICLE(entt) then
                local pedVeh = PED.GET_VEHICLE_PED_IS_IN(entt, false)
                local maxPassengers = VEHICLE.GET_VEHICLE_MAX_NUMBER_OF_PASSENGERS(pedVeh) - 1
                for i = -1, maxPassengers do
                    local seatFree = VEHICLE.IS_VEHICLE_SEAT_FREE(pedVeh, i, false)
                    if not seatFree then
                        local targetPed = VEHICLE.GET_PED_IN_VEHICLE_SEAT(pedVeh, i, false)
                        MarkedForExt[MarkedForExtCount] = targetPed
                        if SE_Notifications then
                            util.toast("标记为删除! 测量 " .. MarkedForExtCount)
                        end
                        MarkedForExtCount = MarkedForExtCount + 1
                    end
                end
                MarkedForExt[MarkedForExtCount] = pedVeh
                if SE_Notifications then
                    util.toast("标记为删除! 测量 " .. MarkedForExtCount)
                end
                MarkedForExtCount = MarkedForExtCount + 1
            else
                MarkedForExt[MarkedForExtCount] = entt
                if SE_Notifications then
                    util.toast("标记为删除! 测量 " .. MarkedForExtCount)
                end
                MarkedForExtCount = MarkedForExtCount + 1
            end
        end
        memory.free(point)
    end
end)

menuAction(mFunFeats, "删除", {}, "", function ()
    for i = 1, #MarkedForExt, 1 do
        entities.delete_by_handle(MarkedForExt[i])
    end
    MarkedForExt = {}
    MarkedForExtCount = 1
    -- resets the extinction
    if SE_Notifications then
        util.toast("清理所有被标记的实体...")
    end
end)
menuAction(mFunFeats, "清理删除列表", {}, "", function ()
    MarkedForExt = {}
    MarkedForExtCount = 1
end)


----------------------------------------------------------------------------------------------------

menu.divider(mFunFeats, "感应地雷枪")

PROX_Coords = {}
PROX_Count = 1

menuToggleLoop(mFunFeats, "感应地雷枪", {"proxgun"}, "仅适用于坐标, 不是实体.", function ()
    local localped = GetLocalPed()
    if PED.IS_PED_SHOOTING(localped) then --check if we shooting
        local pointer = memory.alloc() --allocate memory for coords
        local junk = WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(localped, pointer) --get pointer to coord
        local coord = memory.read_vector3(pointer) --get coord (read from pointer)
        if coord.x ~= 0.0 and coord.y ~= 0.0 and coord.z ~= 0.0 then --check for dud (if we didn't register the shot)
            PROX_Coords[PROX_Count] = coord --assign coord to table
            PROX_Count = PROX_Count + 1 --make the counter go up
            if SE_Notifications then
                util.toast("感应地雷放在 " .. coord.x .. " " .. coord.y .. " " .. coord.z)
            end
        end
        memory.free(pointer) --free the memory so we don't bruh moment the script
    end
end)



menuToggleLoop(mFunFeats, "启用/禁用感应地雷", {"enableprox", "proxon"}, "让感应地雷检查实体是否在它们旁边.", function ()
    if PROX_Coords ~= nil then
        for i = 1, #PROX_Coords do
            local pedTable = entities.get_all_peds_as_handles()
            for a = 1, #pedTable do
                if ENTITY.IS_ENTITY_IN_AREA(pedTable[a], PROX_Coords[i].x + 2, PROX_Coords[i].y + 2, PROX_Coords[i].z, PROX_Coords[i].x - 2, PROX_Coords[i].y - 2, PROX_Coords[i].z + 2, true, true, true) then
                    SE_add_owned_explosion(GetLocalPed(), PROX_Coords[i].x, PROX_Coords[i].y, PROX_Coords[i].z, 2, 10, true, false, 0.4)
                end
            end
        end
    end
end)

menuAction(mFunFeats, "清理所有感应地雷", {"clearprox"}, "", function ()
    util.toast("已清理掉所有 " .. #PROX_Coords .. " 感应地雷!")
    PROX_Coords = {}
    PROX_Count = 1
end)

----------------------------------------------------------------------------------------------------
menu.divider(mFunFeats, "击杀光环")

--preload
KA_Radius = 20
KA_Blame = true
KA_Players = false
KA_Onlyplayers = false
KA_Delvehs = false
KA_Delpeds = false

menuToggleLoop(mFunFeats, "击杀光环", {"killaura"}, "杀死NPC,可选的玩家,可选的朋友", function ()
    local tKCount = 1
    local toKill = {}
    local ourcoords = getEntityCoords(GetLocalPed())
    local ourped = GetLocalPed()
    local weaponhash = 177293209 -- heavy sniper mk2 hash
    --
    local pedPointers = entities.get_all_peds_as_pointers()
    for i = 1, #pedPointers do
        local v3 = entities.get_position(pedPointers[i])
        local vdist = MISC.GET_DISTANCE_BETWEEN_COORDS(ourcoords.x, ourcoords.y, ourcoords.z, v3.x, v3.y, v3.z, true)
        if vdist <= KA_Radius then
            toKill[tKCount] = entities.pointer_to_handle(pedPointers[i])
            tKCount = tKCount + 1
        end
    end
    for i = 1, #toKill do
        if (not KA_Onlyplayers and not PED.IS_PED_A_PLAYER(toKill[i])) or (KA_Players) or (KA_Onlyplayers and PED.IS_PED_A_PLAYER(toKill[i])) then
            if toKill[i] ~= GetLocalPed() then
                if not PED.IS_PED_DEAD_OR_DYING(toKill[i]) then
                    if PED.IS_PED_IN_ANY_VEHICLE(toKill[i]) then
                        local veh = PED.GET_VEHICLE_PED_IS_IN(toKill[i], false)
                        local pedcoords = getEntityCoords(toKill[i])
                        if not PED.IS_PED_A_PLAYER(toKill[i]) and KA_Delvehs then
                            entities.delete_by_handle(veh)
                        end
                        if KA_Blame then
                            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(pedcoords.x, pedcoords.y, pedcoords.z + 0.5, pedcoords.x, pedcoords.y, pedcoords.z, 1000, true, weaponhash, ourped, false, FastNet, -1, veh, true)
                            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(pedcoords.x, pedcoords.y, pedcoords.z - 0.5, pedcoords.x, pedcoords.y, pedcoords.z, 1000, true, weaponhash, ourped, false, FastNet, -1, veh, true)
                            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(pedcoords.x + 1, pedcoords.y, pedcoords.z + 0.5, pedcoords.x, pedcoords.y, pedcoords.z, 1000, true, weaponhash, ourped, false, FastNet, -1, veh, true)
                            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(pedcoords.x - 1, pedcoords.y, pedcoords.z + 0.5, pedcoords.x, pedcoords.y, pedcoords.z, 1000, true, weaponhash, ourped, false, FastNet, -1, veh, true)
                            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(pedcoords.x, pedcoords.y + 1, pedcoords.z + 0.5, pedcoords.x, pedcoords.y, pedcoords.z, 1000, true, weaponhash, ourped, false, FastNet, -1, veh, true)
                            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(pedcoords.x, pedcoords.y - 1, pedcoords.z + 0.5, pedcoords.x, pedcoords.y, pedcoords.z, 1000, true, weaponhash, ourped, false, FastNet, -1, veh, true)
                        else
                            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(pedcoords.x, pedcoords.y, pedcoords.z + 0.5, pedcoords.x, pedcoords.y, pedcoords.z, 1000, true, weaponhash, 0, false, false, -1, veh, true)
                            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(pedcoords.x, pedcoords.y, pedcoords.z - 0.5, pedcoords.x, pedcoords.y, pedcoords.z, 1000, true, weaponhash, 0, false, false, -1, veh, true)
                            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(pedcoords.x + 1, pedcoords.y, pedcoords.z + 0.5, pedcoords.x, pedcoords.y, pedcoords.z, 1000, true, weaponhash, 0, false, false, -1, veh, true)
                            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(pedcoords.x - 1, pedcoords.y, pedcoords.z + 0.5, pedcoords.x, pedcoords.y, pedcoords.z, 1000, true, weaponhash, 0, false, false, -1, veh, true)
                            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(pedcoords.x, pedcoords.y + 1, pedcoords.z + 0.5, pedcoords.x, pedcoords.y, pedcoords.z, 1000, true, weaponhash, 0, false, false, -1, veh, true)
                            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(pedcoords.x, pedcoords.y - 1, pedcoords.z + 0.5, pedcoords.x, pedcoords.y, pedcoords.z, 1000, true, weaponhash, 0, false, false, -1, veh, true)
                        end
                        wait(50)
                        if not PED.IS_PED_A_PLAYER(toKill[i]) and PED.IS_PED_DEAD_OR_DYING(toKill[i]) and KA_Delpeds then
                            entities.delete_by_handle(toKill[i])
                        end
                    else
                        local pedcoords = getEntityCoords(toKill[i])
                        if KA_Blame then
                            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pedcoords.x, pedcoords.y, pedcoords.z + 2, pedcoords.x, pedcoords.y, pedcoords.z, 1000, true, weaponhash, ourped, false, false, -1)
                        else
                            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pedcoords.x, pedcoords.y, pedcoords.z + 2, pedcoords.x, pedcoords.y, pedcoords.z, 1000, true, weaponhash, 0, false, false, -1)
                        end
                        wait(50)
                        if not PED.IS_PED_A_PLAYER(toKill[i]) and PED.IS_PED_DEAD_OR_DYING(toKill[i]) and KA_Delpeds then
                            entities.delete_by_handle(toKill[i])
                        end
                    end
                end
            end
        end
    end
    wait(100)
end)

local killAuraSettings = menu.list(mFunFeats, "击杀光环设置", {}, "")
menu.divider(killAuraSettings, "击杀光环设置")

menu.slider(killAuraSettings, "击杀光环半径", {"karadius"}, "", 1, 100, 20, 1, function (value)
    KA_Radius = value
end)

menuToggle(killAuraSettings, "死亡原因归咎于你", {"kablame"}, "如果关闭,死亡原因将不会归咎于你.", function (toggle)
    KA_Blame = toggle
end, true)

menuToggle(killAuraSettings, "不以玩家为目标", {"kaplayers"}, "", function (toggle)
    KA_Players = toggle
    if toggle then
        if KA_Onlyplayers then
            menu.trigger_commands("kaonlyplayers")
        end
    end
end)

menuToggle(killAuraSettings, "只以玩家为目标", {"kaonlyplayers"}, "", function (toggle)
    KA_Onlyplayers = toggle
    if toggle then
        if KA_Players then
            menu.trigger_commands("kaplayers")
        end
    end
end)

menuToggle(killAuraSettings, "删除NPC的载具", {"kadelvehs"}, "如果开启,将会删除NPC的车辆,这使得他们更容易被杀死.", function (toggle)
    KA_Delvehs = toggle
end)

menuToggle(killAuraSettings, "射击后删除NPC", {"kasilent"}, "如果打开,将删除你杀死的NPC", function (toggle)
    KA_Delpeds = toggle
end)

menuToggleLoop(killAuraSettings, "绘制击杀光环的半径", {"kasphere"}, "绘制一个显示你的击杀光环范围的球体.", function ()
    local myC = getEntityCoords(GetLocalPed())
    GRAPHICS._DRAW_SPHERE(myC.x, myC.y, myC.z, KA_Radius, 255, 0, 0, 0.3)
end)

menuToggleLoop(killAuraSettings, "在半径内绘制NPC", {"kadrawpeds"}, "如果开启,将绘制选定半径内的NPC数量.不需要启动杀戮光环.", function ()
    local dcount = 1
    local dtable = {}
    local ourcoords = getEntityCoords(GetLocalPed())
    --
    local pedPointers = entities.get_all_peds_as_pointers()
    for i = 1, #pedPointers do
        local v3 = entities.get_position(pedPointers[i])
        local vdist = MISC.GET_DISTANCE_BETWEEN_COORDS(ourcoords.x, ourcoords.y, ourcoords.z, v3.x, v3.y, v3.z, true)
        if vdist <= KA_Radius then
            dtable[dcount] = entities.pointer_to_handle(pedPointers[i])
            dcount = dcount + 1
        end
    end
    local cc = {r = 1.0, g = 1.0, b = 1.0, a = 1.0}
    directx.draw_text(0.0, 0.11, "半径范围内的NPC >> " .. KA_Radius .. " << " .. #dtable, ALIGN_TOP_LEFT, 0.5, cc, false)
end)

menuAction(killAuraSettings, "生成测试NPC", {}, "", function ()
    local hash = joaat("G_M_M_ChiGoon_02")
    local coords = getEntityCoords(GetLocalPed())
    requestModel(hash)
    while not hasModelLoaded(hash) do wait() end
    PED.CREATE_PED(24, hash, coords.x, coords.y, coords.z, 0, true, false)
    noNeedModel(hash)
end)

menuAction(killAuraSettings, "填充地图", {}, "在杀了太多NPC后, 您可以使用这个简洁的按钮重新填充地图. 多酷!", function ()
    MISC.POPULATE_NOW()
end)


----------------------------------------------------------------------------------------------------

menu.divider(mFunFeats, "PVP")
local pvphelp = menu.list(mFunFeats, "PVP助手", {"pvphelp"}, "")

menu.divider(pvphelp, "无声自瞄")

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

menu.toggle_loop(pvphelp, "自瞄2.0", {}, "", function ()
    if PED.IS_PED_SHOOTING(GetLocalPed()) then --main start, checking.


        Silent_Aimbot.hash = WEAPON.GET_SELECTED_PED_WEAPON(GetLocalPed())
        local suitable = GetSuitableAimbotTarget(Silent_Aimbot.fov, Silent_Aimbot.fov_check,
            Silent_Aimbot.dist, Silent_Aimbot.los_check)

        if suitable ~= nil then
            local hitboxesCheckCount = 0
            for i, v in pairs(Silent_Aimbot.hitboxes) do
                if (v.toggled) then
                    ShootBulletAtPedBone(suitable, v.hash, Silent_Aimbot.dmg,
                        Silent_Aimbot.hash, Silent_Aimbot.advanced.speed)
                        if SE_Notifications then util.toast("射击 " .. i .. " 玩家 " .. GetPlayerName_ped(suitable)) end
                        break;
                else
                    hitboxesCheckCount = hitboxesCheckCount + 1
                end
            end
            if (hitboxesCheckCount == 3) then --if all 3 are disabled
                util.toast("未选择射击位置!")
            end
        end


    end
end)

local aimbot_settings = menu.list(pvphelp, "自瞄2.0设置", {}, "")
menu.divider(aimbot_settings, "---设置---")
menu.slider(aimbot_settings, "伤害", {"saimdmg", "silentdamage"}, "", 1, 10000, 100, 10, function (v) Silent_Aimbot.dmg = v end)
menu.slider(aimbot_settings, "范围", {"saimrange", "silentrange"}, "", 1, 10000, 300, 100, function (v) Silent_Aimbot.dist = v end)
menu.slider(aimbot_settings, "视野", {"saimfov", "silentfov"}, "", 1, 1000, 20, 1, function (v) Silent_Aimbot.fov = v/10 end)
menu.toggle(aimbot_settings, "检查视野", {}, "", function (toggle) Silent_Aimbot.fov_check = toggle end, true)
menu.toggle(aimbot_settings, "检查视线", {}, "", function (toggle) Silent_Aimbot.los_check = toggle end, true)
menu.divider(aimbot_settings, "---射击位置---")
menu.toggle(aimbot_settings, "头", {"saimhead", "silenthead"}, "", function (toggle) Silent_Aimbot.hitboxes.head.toggled = toggle end)
menu.toggle(aimbot_settings, "脊柱/身体", {"saimspine", "saimbody", "silentbody"}, "", function (toggle) Silent_Aimbot.hitboxes.spine.toggled = toggle end)
menu.toggle(aimbot_settings, "屁股", {"saimpelvis", "silentpelvis"}, "", function (toggle) Silent_Aimbot.hitboxes.pelvis.toggled = toggle end)
menu.divider(aimbot_settings, "---高级选项---")
menu.slider(aimbot_settings, "设置子弹速度", {"silentspeed"}, "默认值为-1.", -1, 2147483647, -1, 10, function (v) Silent_Aimbot.advanced.speed = v end)

--GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS --for shooting the kneecaps
--https://wiki.gtanet.work/index.php?title=Bones
--IK_Head 	12844
--SKEL_Spine2 	24817
--SKEL_Pelvis 	11816
--SKEL_R_Toe0 	20781
--IK_R_Hand 	6286

----------------------------------------------------------------------------------------------------

menu.divider(pvphelp, "载具自瞄")
--TYSM NOWIRY AND AARON!

VEH_MISSILE_SPEED = 10000

menuToggleLoop(pvphelp, "直升机/飞机自瞄", {}, "让直升机/飞机瞄准最近的玩家. 把这个和'无声自瞄'结合起来，看起来你超级棒 :)", function ()
    local p = GetClosestPlayerWithRange_Whitelist(200)
    local localped = GetLocalPed()
    local localcoords2 = getEntityCoords(localped)
    if p ~= nil and not PED.IS_PED_DEAD_OR_DYING(p) and ENTITY.HAS_ENTITY_CLEAR_LOS_TO_ENTITY(localped, p, 17) and not AIM_WHITELIST[NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(p)] and (not players.is_in_interior(NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(p))) and (not players.is_godmode(NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(p))) then
        if PED.IS_PED_IN_ANY_VEHICLE(localped) then
            local veh = PED.GET_VEHICLE_PED_IS_IN(localped, false)
            if VEHICLE.GET_VEHICLE_CLASS(veh) == 15 or VEHICLE.GET_VEHICLE_CLASS(veh) == 16 then --vehicle class of heli
                --did all prechecks, time to actually face them
                -- local pcoords = PED.GET_PED_BONE_COORDS(p, 24817, 0, 0, 0)
                -- local look = util.v3_look_at(localCoords, pcoords) --x = pitch (vertical), y = roll (fuck no), z = heading (horizontal)
                local pcoords2 = PED.GET_PED_BONE_COORDS(p, 24817, 0, 0, 0)
                local look2 = v3.lookAt(localcoords2, pcoords2)
                local look = GetTableFromV3Instance(look2)
                ENTITY.SET_ENTITY_ROTATION(veh, look.x, look.y, look.z, 1, true)
            end
        end
    end
end)

menuAction(pvphelp, "修改导弹速度", {}, "", function ()
    local localped = GetLocalPed()
    if PED.IS_PED_IN_ANY_VEHICLE(localped) then
        local veh = PED.GET_VEHICLE_PED_IS_IN(localped, false)
        if VEHICLE.GET_VEHICLE_CLASS(veh) == 15 or VEHICLE.GET_VEHICLE_CLASS(veh) == 16 then --vehicle class of heli
            SetVehicleMissileSpeed(VEH_MISSILE_SPEED)
        end
    end
end)

menu.slider(pvphelp, "设置导弹速度", {"vehmissilespeed"}, "", 1, 2147483647, 10000, 100, function (value)
    VEH_MISSILE_SPEED = value
end)

----------------------------------------------------------------------------------------------------

menu.divider(pvphelp, "RPG自瞄")

MISL_AIM = false
local missile_settings = {
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
local missile_particles = {
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
    {"RPG", util.joaat("w_lr_rpg_rocket")},
    {"制导RPG", util.joaat("w_lr_homing_rocket")},
    {"暴君MK2导弹", util.joaat("w_ex_vehiclemissile_3")},
    {"B11齐射导弹", util.joaat("w_smug_airmissile_01b")},
    {"b11引导导弹", util.joaat("w_battle_airmissile_01")},
    {"切尔诺伯格导弹", util.joaat("w_ex_vehiclemissile_4")},
    {"阿库拉导弹", util.joaat("w_smug_airmissile_02")},
    {"榴弹发射器", util.joaat("w_lr_40mm")}, --grenade launcher lmfao
    {"紧凑型发射器", util.joaat("w_lr_ml_40mm")}, --compact emp launhcer lmao
    {"催泪瓦斯", util.joaat("w_ex_grenadesmoke")} --tear gas grenade lmfao
}

Chosen_Rocket_Hash = Rocket_Hashes[1][2] --default is the regular RPG
MISSILE_ENTITY_TABLE = {}
menu.toggle(pvphelp, "RPG自瞄 / 更多导弹", {"rpgaim"}, "设置为和自己当前武器同类型的导弹/火箭,否则无效. 默认RPG", function (on)
    if on then
        MISL_AIM = true
        while MISL_AIM do
            local localped = GetLocalPed()
            local localcoords = getEntityCoords(GetLocalPed())
            local forOffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(localped, 0, 5, 0)
            RRocket = OBJECT.GET_CLOSEST_OBJECT_OF_TYPE(forOffset.x, forOffset.y, forOffset.z, 10, Chosen_Rocket_Hash, false, true, true, true)
            local p
            if missile_settings.multitarget then
                if missile_settings.air_target then
                    p = GetClosestPlayerWithRange_Whitelist_DisallowEntities(missile_settings.radius, MISSILE_ENTITY_TABLE, true)
                else
                    p = GetClosestPlayerWithRange_Whitelist_DisallowEntities(missile_settings.radius, MISSILE_ENTITY_TABLE, false)
                end
            elseif missile_settings.multiped then
                if missile_settings.air_target then
                    p = GetClosestNonPlayerPedWithRange_DisallowedEntities(missile_settings.radius, MISSILE_ENTITY_TABLE, true)
                else
                    p = GetClosestNonPlayerPedWithRange_DisallowedEntities(missile_settings.radius, MISSILE_ENTITY_TABLE, false)
                end
            elseif not missile_settings.multitarget then
                if missile_settings.air_target then
                    p = GetClosestPlayerWithRange_Whitelist(missile_settings.radius, true)
                else
                    p = GetClosestPlayerWithRange_Whitelist(missile_settings.radius, false)
                end
            end
            local ppcoords = getEntityCoords(p)
            ----
            if (RRocket ~= 0) and (p ~= nil) and (not PED.IS_PED_DEAD_OR_DYING(p)) and (not AIM_WHITELIST[NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(p)]) and (PED.IS_PED_SHOOTING(localped)) and (not players.is_in_interior(NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(p))) and (ppcoords.z > 1) then
                util.create_thread(function ()
                    local plocalized = p
                    local msl = RRocket
                    if missile_settings.multitarget then
                        MISSILE_ENTITY_TABLE[#MISSILE_ENTITY_TABLE+1] = plocalized
                    end
                    if (ENTITY.HAS_ENTITY_CLEAR_LOS_TO_ENTITY(localped, plocalized, 17) and missile_settings.los) or not missile_settings.los or MISL_AIR then
                        if SE_Notifications then
                            util.toast("先驱完成!")
                        end
                        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(msl)
                        if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(msl) then
                            for i = 1, 10 do
                                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(msl)
                            end
                        else
                            if SE_Notifications then
                                util.toast("拥有控制权")
                            end
                        end
                        local aircount = 1
                        ----
                        Missile_Camera = 0

                        --preload the fake rocket and the particle fx
                        -- > -- Load the particleFX for the fakerocket so it networks to other players
                        STREAMING.REQUEST_NAMED_PTFX_ASSET(missile_particles.dictionary)
                        while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(missile_particles.dictionary) do
                            STREAMING.REQUEST_NAMED_PTFX_ASSET(missile_particles.dictionary)
                            wait()
                        end
                        GRAPHICS.USE_PARTICLE_FX_ASSET(missile_particles.dictionary)
                        -- > -- we now have loaded our PTFX for our fake rocket.
                        --GRAPHICS.START_PARTICLE_FX_NON_LOOPED_ON_ENTITY("exp_grd_rpg_lod", msl, 0, 0, 0, 0, 0, 0, 2, false, false, false)
                        --while the rocket exists, we do this vvvv
                        while ENTITY.DOES_ENTITY_EXIST(msl) do
                            if SE_Notifications then
                                util.toast("导弹存在")
                            end
                            -- NEW CODE W/O DEPRECATION:
                            --local pcoords2 = v3.new(PED.GET_PED_BONE_COORDS(plocalized, 20781, 0, 0, 0))
                            local pcoords2 = getEntityCoords(plocalized)
                            local pcoords = GetTableFromV3Instance(pcoords2)
                            local lc2 = getEntityCoords(msl)
                            local lc = GetTableFromV3Instance(lc2)
                            local look2 = v3.lookAt(lc2, pcoords2)
                            local look = GetTableFromV3Instance(look2)
                            local dir2 = v3.toDir(look2)
                            local dir = GetTableFromV3Instance(dir2)
                            --didn't wanna make new fuckin variables/replace old ones, so we're multiplying the code by 2 because fuck you.
                            -- // -- // --
                            -- // -- // --
                            if missile_settings.ptfx then
                                STREAMING.REQUEST_NAMED_PTFX_ASSET(missile_particles.dictionary)
                                while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(missile_particles.dictionary) do
                                    STREAMING.REQUEST_NAMED_PTFX_ASSET(missile_particles.dictionary)
                                    wait()
                                end
                                GRAPHICS.USE_PARTICLE_FX_ASSET(missile_particles.dictionary)
                                -- > -- we now have loaded our PTFX for our fake rocket.
                                --(​const char* effectName, float xPos, float yPos, float zPos, float xRot, float yRot, float zRot, float scale, BOOL xAxis, BOOL yAxis, BOOL zAxis, BOOL p11)
                                GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(missile_particles.name, lc.x, lc.y, lc.z, 0, 0, 0, 0.4 * missile_settings.ptfx_scale, false, false, false, true)
                            end
                            -- // -- // --
                            -- // -- // --
                            --airstrike air
                            if aircount < 2 and MISL_AIR then
                                if ENTITY.DOES_ENTITY_EXIST(msl) then
                                    --thanks ren!
                                    ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(msl, 1, 0, 0, 2700, true, false, true, true)
                                    aircount = aircount + 1
                                    wait(1100)
                                end
                            end
                            local lookCountD = 0
                            if MISL_AIR then
                                if missile_settings.cam then
                                    if not CAM.DOES_CAM_EXIST(Missile_Camera) then
                                        if SE_Notifications then
                                            util.toast("记录仪视角启用")
                                        end
                                        CAM.DESTROY_ALL_CAMS(true)
                                        Missile_Camera = CAM.CREATE_CAM("DEFAULT_SCRIPTED_CAMERA", true)
                                        --ATTACH_CAM_TO_ENTITY_WITH_FIXED_DIRECTION(Missile_Camera, msl, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1)
                                        CAM.SET_CAM_ACTIVE(Missile_Camera, true)
                                        CAM.RENDER_SCRIPT_CAMS(true, false, 0, true, true, 0)
                                    end
                                end
                                local distx = math.abs(lc.x - pcoords.x)
                                local disty = math.abs(lc.y - pcoords.y)
                                local distz = math.abs(lc.z - pcoords.z)
                                if missile_settings.cam then
                                    local ddisst = SYSTEM.VDIST(pcoords.x, pcoords.y, pcoords.z, lc.x, lc.y, lc.z)
                                    if ddisst > 50 then
                                        local camcoordv3 = CAM.GET_CAM_COORD(Missile_Camera)
                                        local look3 = v3.lookAt(camcoordv3, lc2)
                                        local look4 = GetTableFromV3Instance(look3)
                                        --local look2 = util.v3_look_at(CAM.GET_CAM_COORD(Missile_Camera), lc)
                                        --local backoffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(p, 0, -30, 10)
                                        local backoffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(msl, 10, 10, -2)
                                        CAM.SET_CAM_COORD(Missile_Camera, backoffset.x, backoffset.y, backoffset.z)
                                        if lookCountD < 1 then
                                            CAM.SET_CAM_ROT(Missile_Camera, look4.x, look4.y, look4.z, 2)
                                            lookCountD = lookCountD + 1
                                        end
                                    else
                                        local camcoordv3 = CAM.GET_CAM_COORD(Missile_Camera)
                                        local look3 = v3.lookAt(camcoordv3, lc2)
                                        local look4 = GetTableFromV3Instance(look3)
                                        CAM.SET_CAM_ROT(Missile_Camera, look4.x, look4.y, look4.z, 2)
                                    end
                                end
                                --CAM.SET_CAM_PARAMS(Missile_Camera, lc.x, lc.y, lc.z + 1, look.x, look.y, look.z, 100, 0, 0, 0, 0) --(​Cam cam, float posX, float posY, float posZ, float rotX, float rotY, float rotZ, float fieldOfView, Any p8, int p9, int p10, int p11)
                                ENTITY.SET_ENTITY_ROTATION(msl, look.x, look.y, look.z, 2, true)
                                ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(msl, 1, dir.x * missile_settings.speed * distx, dir.y * missile_settings.speed * disty, dir.z * missile_settings.speed * distz, true, false, true, true)
                                wait()
                            else
                                -- vanilla "aimbot"
                                ENTITY.SET_ENTITY_ROTATION(msl, look.x, look.y, look.z, 2, true)
                                ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(msl, 1, dir.x * missile_settings.speed, dir.y * missile_settings.speed, dir.z * missile_settings.speed, true, false, true, true)
                                wait()
                            end
                            --free all our v3 instances
                        end

                        --rocket has stopped existing
                        if missile_settings.cam then
                            wait(2000)
                            if SE_Notifications then
                                util.toast("记录仪视角移除")
                            end
                            CAM.RENDER_SCRIPT_CAMS(false, false, 0, true, true, 0)
                            if CAM.IS_CAM_ACTIVE(Missile_Camera) then
                                CAM.SET_CAM_ACTIVE(Missile_Camera, false)
                            end
                            CAM.DESTROY_CAM(Missile_Camera, true)
                        end
                    end
                    --improve this logic lmfao
                    if missile_settings.multitarget then
                        table.remove(MISSILE_ENTITY_TABLE, GetValueIndexFromTable(MISSILE_ENTITY_TABLE, plocalized))
                        util.toast("移除导弹 " .. tostring(plocalized) .. " 在爆炸处 " .. tostring(GetValueIndexFromTable(MISSILE_ENTITY_TABLE, p)))
                    end
                end)
            end
            wait()
        end
    else
        MISL_AIM = false
    end
end)

MISL_AIR = false

local rpgrockets = menu.list(pvphelp, "导弹设置", {}, "")

local function generateRockets()
for i = 1, #Rocket_Hashes do
    menu.action(rpgrockets, "设置 " .. Rocket_Hashes[i][1], {"rocket " .. Rocket_Hashes[i][1]}, "", function ()
        Chosen_Rocket_Hash = Rocket_Hashes[i][2]
        util.toast("将使用的火箭设置为 " .. Rocket_Hashes[i][1] .. " || " .. Rocket_Hashes[i][2])
    end)
end
end
generateRockets()

local rpgsettings = menu.list(pvphelp, "RPG自瞄设置", {"rpgsettings"}, "不要在大桥下或者类似的地方使用,否则自崩")

menu.toggle(rpgsettings, "启用标枪模式", {"rpgjavelin"}, "让RPG飞得很高，杀死离你最近的玩家 | 注意: 结合“RPG视线移除”对你看不见的目标开火.", function (on)
    if on then
        MISL_AIR = true
    else
        MISL_AIR = false
    end
end)

menu.slider(rpgsettings, "RPG自瞄范围", {"msl_frc_rad"}, "", 1, 10000, 300, 10, function (value)
    missile_settings.radius = value
end)

menu.slider(rpgsettings, "RPG速度修改", {"msl_spd_mult"}, "速度乘数. 默认100, 是最好的.", 1, 10000, 100, 10, function (value)
    missile_settings.speed = value
end)

menuToggle(rpgsettings, "RPG视线移除", {}, "移除视线检查. 除非你知道你在做什么，否则不要打开这个.", function (on)
    missile_settings.los = not on
end)

menuToggle(rpgsettings, "RPG记录仪", {"rpgcamera"}, "如果你使用标枪模式，你终于可以知道你的火箭去了哪里.", function (on)
    missile_settings.cam = on
end)

menuToggle(rpgsettings, "启用粒子效果", {}, "为导弹启用粒子效果, 让他们看起来更合法. 默认启用.", function (toggle)
    missile_settings.ptfx = toggle
end, true)

menu.toggle(rpgsettings, "只瞄准空中目标", {}, "", function (toggle)
    missile_settings.air_target = toggle
end)

menuToggle(rpgsettings, "锁定多个目标", {}, "会让导弹瞄准不同的实体. 如果导弹已经射向一个实体, 其他导弹会射向其他实体. 对多人有用.", function (toggle)
    missile_settings.multitarget = toggle
end)

menuToggle(rpgsettings, "以NPC为目标", {}, "", function (toggle)
    missile_settings.multiped = toggle
end)

menu.divider(rpgsettings, "------- 粒子效果 (高级) -------")

menu.slider(rpgsettings, "比例", {"rpgparscale"}, "", 1, 10, 1, 1, function (scale)
    missile_settings.ptfx_scale = scale
end)

menu.text_input(rpgsettings, "名字", {"rpgptfx"}, "", function (text)
    missile_particles.name = text
end, "exp_grd_rpg_lod")

menu.text_input(rpgsettings, "哈希值", {"rpgdictionary"}, "", function (text)
    missile_particles.dictionary = text
end, "core")

----------------------------------------------------------------------------------------------------

menu.divider(pvphelp, "天基炮")

--preload
ORB_Sneaky = false

menuAction(pvphelp, "天基炮射击标记点", {"orbway", "orbwp"}, "标点之后再使用，否则不起作用并且报错", function ()
    local wpos = Get_Waypoint_Pos2()
    if SE_Notifications then
        util.toast("所选标记点目标: " .. wpos.x .. " " .. wpos.y .. " " .. wpos.z)
    end
    if ORB_Sneaky then
        for a = 1, 30 do
            SE_add_explosion(wpos.x, wpos.y, wpos.z + 30 - a, 29, 10, true, false, 1, false)
            SE_add_explosion(wpos.x, wpos.y, wpos.z + 30 - a, 59, 10, true, false, 1, false)
            wait(30)
        end
    else
        for i = 1, 30 do
            SE_add_owned_explosion(GetLocalPed(), wpos.x, wpos.y, wpos.z + 30 - i, 29, 10, true, false, 1)
            SE_add_owned_explosion(GetLocalPed(), wpos.x, wpos.y, wpos.z + 30 - i, 59, 10, true, false, 1)
            wait(30)
        end
    end
end)

menuToggle(pvphelp, "隐秘的爆炸", {}, "天基炮的爆炸不会归咎于你.", function (on)
    ORB_Sneaky = on
end)

----------------------------------------------------------------------------------------------------

menu.divider(pvphelp, "自爆卡车")

--preload
CAR_S_sneaky = false
CAR_S_BLACKLIST = {}

menuToggleLoop(pvphelp, "自动载具自毁", {"carexplode"}, "当你在玩家旁边时会自动引爆你的车.", function()
    local ourped = GetLocalPed()
    if PED.IS_PED_IN_ANY_VEHICLE(ourped, false) then
        local pedTable = entities.get_all_peds_as_pointers()
        local ourCoords = getEntityCoords(ourped)
        for i = 1, #pedTable do
            local handle = entities.pointer_to_handle(pedTable[i])
            if PED.IS_PED_A_PLAYER(handle) then
                local playerID = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(handle)
                local v3 = entities.get_position(pedTable[i])
                local dist = DistanceBetweenTwoCoords(ourCoords, v3)
                if dist < 5 and handle ~= GetLocalPed() and not CAR_S_BLACKLIST[playerID] then
                    if CAR_S_sneaky then
                        SE_add_explosion(ourCoords.x, ourCoords.y, ourCoords.z, 2, 10, true, false, 0.1, false)
                        SE_add_explosion(ourCoords.x - 4, ourCoords.y, ourCoords.z, 2, 20, false, true, 0.1, false)
                        SE_add_explosion(ourCoords.x + 4, ourCoords.y, ourCoords.z, 2, 20, false, true, 0.1, false)
                        SE_add_explosion(ourCoords.x, ourCoords.y - 4, ourCoords.z, 2, 20, false, true, 0.1, false)
                        SE_add_explosion(ourCoords.x, ourCoords.y + 4, ourCoords.z, 2, 20, false, true, 0.1, false)
                    else
                        SE_add_owned_explosion(ourped, ourCoords.x, ourCoords.y, ourCoords.z, 2, 10, true, false, 0.1)
                        SE_add_owned_explosion(ourped, ourCoords.x - 4, ourCoords.y, ourCoords.z, 2, 20, false, true, 0.1)
                        SE_add_owned_explosion(ourped, ourCoords.x + 4, ourCoords.y, ourCoords.z, 2, 20, false, true, 0.1)
                        SE_add_owned_explosion(ourped, ourCoords.x, ourCoords.y - 4, ourCoords.z, 2, 20, false, true, 0.1)
                        SE_add_owned_explosion(ourped, ourCoords.x, ourCoords.y + 4, ourCoords.z, 2, 20, false, true, 0.1)
                    end
                end
            end
        end
    end
end)

menuToggle(pvphelp, "隐秘的载具自毁", {"carexplodesneaky"}, "汽车自毁的爆炸不会归咎于你.", function(on)
    CAR_S_sneaky = on
end)

----------------------------------------------------------------------------------------------------

menu.divider(pvphelp, "快速射击")

LegitRapidFire = false
LegitRapidMS = 100

menuToggle(pvphelp, "合法的快速射击 (快速开关)", {"legitrapidfire"}, "快速切换到手榴弹,并在你射击后切换到你的武器. 对狙击枪,RPG,榴弹发射器有用.", function(on)
    local localped = GetLocalPed()
    if on then
        LegitRapidFire = true
        util.create_thread(function ()
            while LegitRapidFire do
                if PED.IS_PED_SHOOTING(localped) then
                    local currentWpMem = memory.alloc()
                    local junk = WEAPON.GET_CURRENT_PED_WEAPON(localped, currentWpMem, 1)
                    local currentWP = memory.read_int(currentWpMem)
                    memory.free(currentWpMem)
                    WEAPON.SET_CURRENT_PED_WEAPON(localped, 2481070269, true) --2481070269 is grenade
                    wait(LegitRapidMS)
                    WEAPON.SET_CURRENT_PED_WEAPON(localped, currentWP, true)
                end
                wait()
            end
            util.stop_thread()
        end)
    else
        LegitRapidFire = false
    end
end)

menu.slider(pvphelp, "合法的快速射击延迟 (ms)", {"legitrapiddelay"}, "切换到手榴弹和切换到武器的延迟时间.", 1, 1000, 100, 50, function (value)
    LegitRapidMS = value
end)

----------------------------------------------------------------------------------------------------

menu.divider(pvphelp, "导弹防御")

Actual_Missiles = {
    util.joaat("w_lr_rpg_rocket"),
    util.joaat("w_lr_homing_rocket"),
    --util.joaat("w_ex_vehiclemissile_3"),
    --util.joaat("w_smug_airmissile_01b"),
    --util.joaat("w_battle_airmissile_01"),
    --util.joaat("w_ex_vehiclemissile_4"),
    --util.joaat("w_smug_airmissile_02"),
}

menu.toggle_loop(pvphelp, "导弹护盾", {"missileshield"}, "生成一面墙, 阻止导弹到达你的位置. 如果你在使用导弹发射器,则没有效果.", function()
    --local weapon = WEAPON.GET_SELECTED_PED_WEAPON(GetLocalPed())
    --if (weapon ~= -1312131151) and (weapon ~= 1672152130) then
    local missile = 0
    local forOffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(GetLocalPed(), 0, 5, 0)
    for i = 1, #Actual_Missiles do

        missile = OBJECT.GET_CLOSEST_OBJECT_OF_TYPE(forOffset.x, forOffset.y, forOffset.z, 10, Actual_Missiles[i], false, true, true, true)
        if (missile ~= 0) then --missile exists
            local pcoords = getEntityCoords(GetLocalPed())
            local mcoords = getEntityCoords(missile)
            --distance check, if the missile is too close, we're already fcked, so why bother?
            --also prevents false-flagging missile launcher as a missile (since it actually renders the object)
            if (SYSTEM.VDIST2(pcoords.x, pcoords.y, pcoords.z, mcoords.x, mcoords.y, mcoords.z) < 100) then return end

            local offsetForward = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(missile, 0, 3, 0); offsetForward.z = offsetForward.z - 3
            local missileRot = v3.new(ENTITY.GET_ENTITY_ROTATION(missile, 2))
            --now spawn a wall there, and make it face the entity
            --make a thread, since we wait a sec before deleting the wall
            util.create_thread(function()
                util.toast("thread started.")
                local obj = SpawnObjectAtCoords(util.joaat("sr_prop_sr_track_wall"), offsetForward)
                ENTITY.SET_ENTITY_INVINCIBLE(obj, true)
                ENTITY.SET_ENTITY_ROTATION(obj, missileRot:getX(), missileRot:getY(), missileRot:getZ()+90, 2, true)
                --ENTITY.SET_ENTITY_VISIBLE(obj, false, false)
                util.yield(1000)
                entities.delete_by_handle(obj)
                util.toast("Deleted object.")
                return
            end)

            return
        end

    end
end)


-----------------------------------------------------------------------------------------------------------------------------------

local toolFeats = menu.list(Fight_script, "工具", {}, "")

menu.divider(toolFeats, "平滑TP")

FRAME_STP = false

menuAction(toolFeats, "平滑传送", {"stp"}, "", function ()
    SmoothTeleportToCord(Get_Waypoint_Pos2(), FRAME_STP)
end)

menuToggle(toolFeats, "平滑传送(v2)", {"stpv2"}, "让你或你的载具一起传送,以实现更平稳的传送.", function(toggle)
    FRAME_STP = toggle
end)

menuAction(toolFeats, "重置视角", {"resetstp"}, "将脚本视角渲染为假,同时销毁当前视角.", function ()
    local renderingCam = CAM.GET_RENDERING_CAM()
    CAM.RENDER_SCRIPT_CAMS(false, false, 0, true, true, 0)
    CAM.DESTROY_CAM(renderingCam, true)
end)

local stpsettings = menu.list(toolFeats, "平滑传送设置", {}, "")

menu.slider(stpsettings, "速度设置 (x) /10", {"stpspeed"}, "这将除以10,因为滑块不能接受非整数", 1, 100, 10, 1, function(value)
    local multiply = value / 10
    if SE_Notifications then
        util.toast("平滑传送速度设置为 " .. tostring(multiply) .. "!")
    end
    STP_SPEED_MODIFIER = 0.02 --set it again so it doesnt multiply over and over. This took too long to figure out....
    STP_SPEED_MODIFIER = STP_SPEED_MODIFIER * multiply
end)

menu.slider(stpsettings, "过渡高度 (米)", {"stpheight"}, "设置视角在过渡时的高度.", 0, 10000, 300, 10, function (value)
    local height = value
    if SE_Notifications then
        util.toast("平滑传送高度设置为 " .. tostring(height) .. "!")
    end
    STP_COORD_HEIGHT = height
end)

menu.divider(toolFeats, "-=-=-=-=-=-=-=-=-")

--

--preload
DR_TXT_SCALE = 0.5


menuToggleLoop(toolFeats, "绘制位置", {"drawpos"},  "", function ()
    local pos = getEntityCoords(GetLocalPed())
    local cc = {r = 190.0, g = 1.0, b = 120.0, a = 1.0}
    directx.draw_text(0.0, 0.0, "x: " .. pos.x .. " // y: " .. pos.y .. " // z: " .. pos.z, ALIGN_TOP_LEFT, DR_TXT_SCALE, cc, false)
end)

menuToggleLoop(toolFeats, "绘制旋转", {"drawrot"}, "", function ()
    local rot = ENTITY.GET_ENTITY_ROTATION(GetLocalPed(), 2)
    local cc = {r = 190.0, g = 1.0, b = 120.0, a = 1.0}
    directx.draw_text(0.5, 0.03, "高度: " .. rot.x .. " // 弯度: " .. rot.y .. " // 偏移度: " .. rot.z, ALIGN_CENTRE, DR_TXT_SCALE, cc, false)
    local facingtowards
    if ((rot.z >= 135) or (rot.z < -135)) then facingtowards = "-Y"
    elseif ((rot.z < 135) and (rot.z >= 45)) then facingtowards = "-X"
    elseif ((rot.z >= -135) and (rot.z < -45)) then facingtowards = "+X"
    elseif ((rot.z >= -45) or (rot.z < 45)) then facingtowards = "+Y" end
    directx.draw_text(0.5, 0.07, "面向 " .. facingtowards, ALIGN_CENTRE, DR_TXT_SCALE, cc, false)
end)

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

menuToggleLoop(toolFeats, "绘制实体池", {"drawentpool"}, "", function ()
    local cc = {r = 190.0, g = 1.0, b = 120.0, a = 1.0}
    if EP_drawveh then
        local vehpool = entities.get_all_vehicles_as_pointers()
        directx.draw_text(EPS_vehx, EPS_vehy, "载具: " .. #vehpool, ALIGN_TOP_LEFT, DR_TXT_SCALE, cc, false)
    end
    if EP_drawped then
        local pedpool = entities.get_all_peds_as_pointers()
        directx.draw_text(EPS_pedx, EPS_pedy, "PED: " .. #pedpool, ALIGN_TOP_LEFT, DR_TXT_SCALE, cc, false)
    end
    if EP_drawobj then
        local objpool = entities.get_all_objects_as_pointers()
        directx.draw_text(EPS_objx, EPS_objy, "物体: " .. #objpool, ALIGN_TOP_LEFT, DR_TXT_SCALE, cc, false)
    end
    if EP_drawpick then
        local pickpool = entities.get_all_pickups_as_pointers()
        directx.draw_text(EPS_pickx, EPS_picky, "收集品: " .. #pickpool, ALIGN_TOP_LEFT, DR_TXT_SCALE, cc, false)
    end
end)

local ePS = menu.list(toolFeats, "实体池设置", {}, "")
menuToggle(ePS, "绘制载具", {}, "", function (toggle)
    EP_drawveh = toggle
end, true)
menu.slider(ePS, "载具文本位置 X", {"epvehposx"}, "/100", 0, 100, 0, 1, function (value)
    EPS_vehx = value / 100
end) 
menu.slider(ePS, "载具文本位置 Y", {"epvehposy"}, "/100", 0, 100, 3, 1, function (value)
    EPS_vehy = value / 100
end)
menuToggle(ePS, "绘制PED", {}, "", function (toggle)
    EP_drawped = toggle
end, true)
menu.slider(ePS, "PED文本位置 X", {"eppedposx"}, "/100", 0, 100, 0, 1, function (value)
    EPS_pedx = value / 100
end)
menu.slider(ePS, "PED文本位置 Y", {"eppedposy"}, "/100", 0, 100, 5, 1, function (value)
    EPS_pedy = value / 100
end)
menuToggle(ePS, "绘制物体", {}, "", function (toggle)
    EP_drawobj = toggle
end, true)
menu.slider(ePS, "物体文本位置 X", {"epobjposx"}, "/100", 0, 100, 0, 1, function (value)
    EPS_objx = value / 100
end)
menu.slider(ePS, "物体文本位置 Y", {"epobjposy"}, "/100", 0, 100, 7, 1, function (value)
    EPS_objy = value / 100
end)
menuToggle(ePS, "绘制收集品", {}, "", function (toggle)
    EP_drawpick = toggle
end, true)
menu.slider(ePS, "收集品文本位置 X", {"epickjposx"}, "/100", 0, 100, 0, 1, function (value)
    EPS_pickx = value / 100
end)
menu.slider(ePS, "收集品文本位置 Y", {"epickjposy"}, "/100", 0, 100, 9, 1, function (value)
    EPS_picky = value / 100
end)

menu.divider(toolFeats, "设置")
menu.slider(toolFeats, "文本比例 (/10)", {"drscale"}, "将文本的比例设定为您指定的值, 除以10. 这是因为它只接受整数值.", 1, 50, 5, 1, function (value)
    DR_TXT_SCALE = value / 10
end)

menu.divider(toolFeats, "其他")

----
YOINK_PEDS = false
YOINK_VEHICLES = false
YOINK_OBJECTS = false
YOINK_PICKUPS = false

YOINK_RANGE = 500

Yoinkshit = false

menuToggle(toolFeats, "控制器", {}, "", function (yoink)
    if yoink then
        Yoinkshit = true
        util.create_thread(function()
            while Yoinkshit do
                local yoinksq = YOINK_RANGE^2
                local localCoord = getEntityCoords(getPlayerPed(players.user()))
                local BigTable = {}
                if YOINK_PEDS then
                    local pedTable = entities.get_all_peds_as_pointers()
                    for i = 1, #pedTable do
                        local coord = entities.get_position(pedTable[i])
                        local distsq = SYSTEM.VDIST2(coord.x, coord.y, coord.z, localCoord.x, localCoord.y, localCoord.z)
                        local handle = entities.pointer_to_handle(pedTable[i])
                        if not PED.IS_PED_A_PLAYER(handle) then
                            if distsq <= yoinksq then
                                BigTable[#BigTable+1] = handle
                            end
                        end
                    end
                end
                wait()
                if YOINK_VEHICLES then
                    local vehTable = entities.get_all_vehicles_as_pointers()
                    for i = 1, #vehTable do
                        local coord = entities.get_position(vehTable[i])
                        local distsq = SYSTEM.VDIST2(coord.x, coord.y, coord.z, localCoord.x, localCoord.y, localCoord.z)
                        if distsq <= yoinksq then
                            BigTable[#BigTable+1] = entities.pointer_to_handle(vehTable[i])
                        end
                    end
                end
                wait()
                if YOINK_OBJECTS then
                    local objTable = entities.get_all_objects_as_pointers()
                    for i = 1, #objTable do
                        local coord = entities.get_position(objTable[i])
                        local distsq = SYSTEM.VDIST2(coord.x, coord.y, coord.z, localCoord.x, localCoord.y, localCoord.z)
                        if distsq <= yoinksq then
                            BigTable[#BigTable+1] = entities.pointer_to_handle(objTable[i])
                        end
                    end
                end
                if YOINK_PICKUPS then
                    local pickTable = entities.get_all_pickups_as_pointers()
                    for i = 1, #pickTable do
                        local coord = entities.get_position(pickTable[i])
                        local distsq = SYSTEM.VDIST2(coord.x, coord.y, coord.z, localCoord.x, localCoord.y, localCoord.z)
                        if distsq <= yoinksq then
                            BigTable[#BigTable+1] = entities.pointer_to_handle(pickTable[i])
                        end
                    end
                end
                for i = 1, #BigTable do
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(BigTable[i])
                    wait()
                end
                util.toast("请求控制所有")
                ----
                wait()
            end
            util.stop_thread()
        end)
    else
        Yoinkshit = false
    end
end)
local yoinkSettings = menu.list(toolFeats, "控制设置", {}, "")
menu.slider(yoinkSettings, "管理范围", {"yoinkrange"}, "", 1, 5000, 500, 10, function (value)
    YOINK_RANGE = value
end)
menuToggle(yoinkSettings, "PED", {}, "", function (peds)
    YOINK_PEDS = peds
end)
menuToggle(yoinkSettings, "载具", {}, "", function (vehs)
    YOINK_VEHICLES = vehs
end)
menuToggle(yoinkSettings, "物体", {}, "", function (objs)
    YOINK_OBJECTS = objs
end)
menuToggle(yoinkSettings, "收集品", {}, "", function (pick)
    YOINK_PICKUPS = pick
end)


local tpyoink = menu.list(toolFeats, "传送所有到我", {}, "")

menu.action(tpyoink, "传送所有PED", {}, "", function ()
    TpAllPeds(players.user())
end)
menu.action(tpyoink, "传送所有载具", {}, "WARNING: DANGEROUS SHIT!", function()
    TpAllVehs(players.user())
end)
menu.action(tpyoink, "传送所有物体", {}, "WARNING: BIG CHANCE YOU MIGHT CRASH!", function ()
    TpAllObjects(players.user())
end)
menu.action(tpyoink, "传送所有收集品", {}, "", function ()
    TpAllPickups(players.user())
end)


local clearAreaTools = menu.list(toolFeats, "清理区域", {}, "")
CLEAR_AREA_RANGE = 100
local function clearAreaOfEntities(tbl, range)
    local rangesq = range*range
    local pc = ENTITY.GET_ENTITY_COORDS(GetLocalPed())
    for _, v in pairs(tbl) do
        local cc = entities.get_position(v)
        if (SYSTEM.VDIST2(pc.x, pc.y, pc.z, cc.x, cc.y, cc.z) <= rangesq) then
            local h = entities.pointer_to_handle(v)
            if (ENTITY.IS_ENTITY_A_PED(h) and not PED.IS_PED_A_PLAYER(h)) or (not ENTITY.IS_ENTITY_A_PED(h)) then
                --todo: ped check if ped is a player []done
                --todo: dont delete vehicle that you are driving/riding
                for i = 0, 20 do NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(h) end
                entities.delete_by_handle(h)
            end
        end
    end
end
menu.action(clearAreaTools, "清理PED", {"clearpeds"}, "", function ()
    local pp = entities.get_all_peds_as_pointers()
    clearAreaOfEntities(pp, CLEAR_AREA_RANGE)
end)
menu.action(clearAreaTools, "清理载具", {"clearvehs"}, "", function ()
    local vp = entities.get_all_vehicles_as_pointers()
    clearAreaOfEntities(vp, CLEAR_AREA_RANGE)
end)
menu.action(clearAreaTools, "清理物体", {"clearobjs"}, "", function ()
    local op = entities.get_all_objects_as_pointers()
    clearAreaOfEntities(op, CLEAR_AREA_RANGE)
end)
menu.action(clearAreaTools, "清理收集品", {"clearpickups"}, "", function ()
    local pp = entities.get_all_pickups_as_pointers()
    clearAreaOfEntities(pp, CLEAR_AREA_RANGE)
end)
menu.action(clearAreaTools, "清理所有绳索", {"clearropes"}, "", function() 
    for i = 0, 100 do
        PHYSICS.DELETE_CHILD_ROPE(i)
    end
end)
menu.slider(clearAreaTools, "清理区域范围", {"cleararearange"}, "", 1, 10000, 100, 50, function (value)
    CLEAR_AREA_RANGE = value
end)
--------------------------------------------------------------------------------------------------------------------------

local vehicleFeats = menu.list(Fight_script, "载具选项", {"vehicleFeats"}, "")

menu.divider(vehicleFeats, "载具工具")

menuToggleLoop(vehicleFeats, "显示载具旋转和速度", {}, "", function()
    local veh = PED.GET_VEHICLE_PED_IS_IN(GetLocalPed(), false)
    local vv = ENTITY.GET_ENTITY_ROTATION(veh, 2)
    local velMag = ENTITY.GET_ENTITY_SPEED_VECTOR(veh, true).y
    --[[
        x = left/right
        y = forward/backward
        z = up/down
    ]]
    local entSpeed = ENTITY.GET_ENTITY_SPEED(veh)
    directx.draw_text(0.5, 0.45, "高度: " .. v3.getX(vv), 1, 0.7, WhiteText, false)
    directx.draw_text(0.5, 0.5, "弯度: " .. v3.getY(vv), 1, 0.7, WhiteText, false)
    directx.draw_text(0.5, 0.55, "偏移度: " .. v3.getZ(vv), 1, 0.7, WhiteText, false)
    directx.draw_text(0.5, 0.60, "加速度: " .. tostring(velMag), 1, 0.7, WhiteText, false)
    directx.draw_text(0.5, 0.65, "速度: " .. tostring(entSpeed), 1, 0.7, WhiteText, false)
end)

menuToggleLoop(vehicleFeats, "将载具上下颠倒", {}, "对MK2有用.", function ()
    UpsideDownVehicleRotationWithKeys()
    --rotation logic (up-down || PITCH/ROLL)
    --[[Notes:
        Pitch can be max. 90, min. -90. This means that ROLL will have to account for upside-down behaviour.
        We ROLL cuttoff / alternate point will be at 100, for simplicity's sake, but full-upside down, no other values changed is:
        -Same pitch
        -opposite roll (-180, 180)
        -same yaw
    ]]
end)

local fastTurnVehicleScale = 3

menuToggleLoop(vehicleFeats, "载具快速定制转弯", {}, "用A/D键快速转动载具.", function ()
    FastTurnVehicleWithKeys(fastTurnVehicleScale)
end)

menu.slider(vehicleFeats, "载具快速定制转弯强度 (/10)", {"vehfastturn"}, "设置自定义转弯的比例.", 1, 1000, 30, 5, function(value)
    fastTurnVehicleScale = value / 10
end)

menu.divider(vehicleFeats, "解锁载具")

menuToggleLoop(vehicleFeats, "解锁你射击的载具", {"unlockvehshot"}, "这将在锁定的玩家载具上起作用.", function ()
    UnlockVehicleShoot()
end)

menuToggleLoop(vehicleFeats, "解锁你试图进入的载具", {"unlockvehget"}, "这将在锁定的玩家载具上起作用.", function ()
    UnlockVehicleGetIn()
end)

menuToggleLoop(vehicleFeats, "立即启动汽车", {"turnvehonget"}, "当你进入车内时,立即启动汽车引擎.", function ()
    TurnCarOnInstantly()
end)

menu.divider(vehicleFeats, "自动功能")

menuToggleLoop(vehicleFeats, "上车时自动执行'性能'", {"autoperf"}, "当你进入车辆时，执行命令'perf'.", function ()
    local localped = GetLocalPed()
    if PED.IS_PED_GETTING_INTO_A_VEHICLE(localped) then
        menu.trigger_commands("perf")
    end
end)

menuToggleLoop(vehicleFeats, "上车时自动'打开电台'", {"autotune"}, "上车后执行'tune'命令.", function()
    local localped = GetLocalPed()
    if PED.IS_PED_GETTING_INTO_A_VEHICLE(localped) then
        menu.trigger_commands("tune")
    end
end)

menu.divider(vehicleFeats, "速度调节*")

--preload
SuperVehMultiply = 1.2

BetterSuperDrive = false
menuToggle(vehicleFeats, "速度更改 (锁定)", {"vehmultiply"}, "", function (superd)
    if superd then
        local localped = GetLocalPed()
        BetterSuperDrive = true
        util.create_thread(function()
            while BetterSuperDrive do
                if PED.IS_PED_IN_ANY_VEHICLE(localped, false) then
                    --if PAD.IS_CONTROL_PRESSED(0, 71) then --71 == INPUT_VEH_ACCELERATE
                        local veh = PED.GET_VEHICLE_PED_IS_IN(localped, false)
                        local vehVel = ENTITY.GET_ENTITY_VELOCITY(veh)
                        local newVel = {x = vehVel.x * SuperVehMultiply, y = vehVel.y * SuperVehMultiply, z = vehVel.z * SuperVehMultiply}
                        ENTITY.SET_ENTITY_VELOCITY(veh, newVel.x, newVel.y, newVel.z)
                        wait(100)
                    --end
                end
                wait()
            end
            util.stop_thread()
        end)
    else
        BetterSuperDrive = false
    end
end)

menuToggle(vehicleFeats, "速度更改 (绑定到LShift)", {"vehmultiplyshift"}, "", function (superd)
    if superd then
        local localped = GetLocalPed()
        BetterSuperDrive = true
        util.create_thread(function()
            while BetterSuperDrive do
                if PED.IS_PED_IN_ANY_VEHICLE(localped, false) then
                    if PAD.IS_CONTROL_PRESSED(0, 21) --[[or PAD.IS_CONTROL_PRESSED(0, 61)]] then --21 == INPUT_SPRINT || 61 == INPUT_VEH_MOVE_UP_ONLY
                        local veh = PED.GET_VEHICLE_PED_IS_IN(localped, false)
                        local vehVel = ENTITY.GET_ENTITY_VELOCITY(veh)
                        local newVel = {x = vehVel.x * SuperVehMultiply, y = vehVel.y * SuperVehMultiply, z = vehVel.z * SuperVehMultiply}
                        ENTITY.SET_ENTITY_VELOCITY(veh, newVel.x, newVel.y, newVel.z)
                        wait(100)
                    end
                end
                wait()
            end
            util.stop_thread()
        end)
    else
        BetterSuperDrive = false
    end
end)

menu.slider(vehicleFeats, "速度数值调节 (/100)", {"vehmultnum"}, "除以 100.", 1, 1000, 120, 10, function(val)
    SuperVehMultiply = val/100
end)

menu.divider(vehicleFeats, "其他选项")

menu.click_slider(vehicleFeats, "切换座位", {"vehseat"}, "", -1, 6, -1, 1, function (value)
    local ourped = GetLocalPed()
    if PED.IS_PED_IN_ANY_VEHICLE(ourped, false) then
        local veh = PED.GET_VEHICLE_PED_IS_IN(ourped, false)
        PED.SET_PED_INTO_VEHICLE(ourped, veh, value)
    else
        util.toast("先给我上车 :)")
    end
end)

local upboost = {
    multiplier = 1
}
menuAction(vehicleFeats, "小幅跳跃", {"smallupboost"}, "为跳跃做一点小小的提升 :)", function ()
    local veh = PED.GET_VEHICLE_PED_IS_IN(GetLocalPed(), false)
    if veh ~= 0 then
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(veh, 1, 0, 0, 2 * upboost.multiplier, true, true, true, true)
    else
        util.toast("不在车内!")
    end
end)

menu.slider(vehicleFeats, "跳跃高度", {"smallmultiplier"}, "上面“小幅跳跃”功能的乘数.", 1, 100, 1, 1, function (slider)
    upboost.multiplier = slider
end)

--testing
menu.toggle_loop(vehicleFeats, "直升机运送坦克", {}, "Heeeliiicopter", function ()
    if PED.IS_PED_IN_ANY_VEHICLE(GetLocalPed(), false) then
        local veh = PED.GET_VEHICLE_PED_IS_IN(GetLocalPed(), false)
        VEHICLE.SET_VEHICLE_TANK_TURRET_POSITION(veh, math.random(-180, 180), true)
        wait(1)
    end
end)




HAVE_SPAWN_FEATURES_BEEN_GENERATED = false
SPAWN_FROZEN = false
SPAWN_GOD = false
local spawnFeats = menu.list(Fight_script, "生成功能", {}, "")

function GenerateSpawnFeatures()
    if not HAVE_SPAWN_FEATURES_BEEN_GENERATED then
        HAVE_SPAWN_FEATURES_BEEN_GENERATED = true
        menu.divider(spawnFeats, "------------------")
        
        local spawnPeds = menu.list(spawnFeats, "PED", {}, "")
        SPAWNED_PEDS = {}
        SPAWNED_PEDS_COUNT = 0
        local timeBeforePeds = util.current_time_millis()
        menu.action(spawnPeds, "清理所有生成的ped", {"cleanpeds"}, "", function()
            if SPAWNED_PEDS_COUNT ~= 0 then
                for i = 1, SPAWNED_PEDS_COUNT do
                    entities.delete_by_handle(SPAWNED_PEDS[i])
                end
                SPAWNED_PEDS_COUNT = 0
                SPAWNED_PEDS = {}
            else
                util.toast("没有PED了!")
            end
        end)
        menu.divider(spawnPeds, "生成")
        for i = 1, #UNIVERSAL_PEDS_LIST do
            menu.action(spawnPeds, "生成 " .. tostring(UNIVERSAL_PEDS_LIST[i]), {"catspawnped " .. tostring(UNIVERSAL_PEDS_LIST[i])}, "", function()
                SPAWNED_PEDS_COUNT = SPAWNED_PEDS_COUNT + 1
                SPAWNED_PEDS[SPAWNED_PEDS_COUNT] = SpawnPedOnPlayer(util.joaat(UNIVERSAL_PEDS_LIST[i]), players.user())
                if SPAWN_FROZEN then
                    ENTITY.FREEZE_ENTITY_POSITION(SPAWNED_PEDS[SPAWNED_PEDS_COUNT], true)
                end
                if SPAWN_GOD then
                    ENTITY.SET_ENTITY_INVINCIBLE(SPAWNED_PEDS[SPAWNED_PEDS_COUNT], true)
                end
            end)
            if i % 32 == 0 then
                wait()
            end
        end
        local timeAfterPeds = util.current_time_millis()

        util.toast("大约花了 " .. timeAfterPeds - timeBeforePeds .. "毫秒!")
        ----------------------------------------------------------------------------
        local spawnObjs = menu.list(spawnFeats, "物体", {}, "")
        SPAWNED_OBJS = {}
        SPAWNED_OBJ_COUNT = 0
        local timeBeforeObjs = util.current_time_millis()
        menu.action(spawnObjs, "清理所有生成的物体", {"cleanobjs"}, "", function()
            if SPAWNED_OBJ_COUNT ~= 0 then
                for i = 1, SPAWNED_OBJ_COUNT do
                    entities.delete_by_handle(SPAWNED_OBJS[i])
                end
                SPAWNED_OBJS = {}
                SPAWNED_OBJ_COUNT = 0
            else
                util.toast("没有物体了!")
            end
        end)
        menu.divider(spawnObjs, "生成")
        for i = 1, #UNIVERSAL_OBJECTS_LIST do
            menu.action(spawnObjs, "生成 " .. tostring(UNIVERSAL_OBJECTS_LIST[i]), {"catspawnobj " .. tostring(UNIVERSAL_OBJECTS_LIST[i])}, "", function ()
                SPAWNED_OBJ_COUNT = SPAWNED_OBJ_COUNT + 1
                SPAWNED_OBJS[SPAWNED_OBJ_COUNT] = SpawnObjectOnPlayer(util.joaat(tostring(UNIVERSAL_OBJECTS_LIST[i])), players.user())
                if SPAWN_FROZEN then
                    ENTITY.FREEZE_ENTITY_POSITION(SPAWNED_OBJS[SPAWNED_OBJ_COUNT], true)
                end
                if SPAWN_GOD then
                    ENTITY.SET_ENTITY_INVINCIBLE(SPAWNED_OBJS[SPAWNED_OBJ_COUNT], true)
                end
            end)
            if i % 100 == 0 then
                wait()
            end
        end
        local timeAfterObjs = util.current_time_millis()

        util.toast("大约花了 " .. timeAfterObjs - timeBeforeObjs .. "毫秒!")

        -----

        menu.toggle(spawnFeats, "冻结生成", {}, "这将产生冻结在原地的PED/物体.", function(on)
            SPAWN_FROZEN = on
        end)
        menu.toggle(spawnFeats, "无敌生成", {}, "这将生成无法受到伤害的PED/物体.", function(on)
            SPAWN_GOD = on
        end)
    else
        util.toast("已经生成了!")
    end
end

menuAction(spawnFeats, "加载生成选项", {}, "这不是自动完成的，因为它需要时间/导致滞后.", function()
    GenerateSpawnFeatures()
end)

--------------------------------------------------------------------------------------------------------------------------

local helperFeatures = menu.list(Fight_script, "助手", {}, "")

menuAction(helperFeatures, "传送安全代码", {}, "传送机构任务中的安全密码 (tequi-la-la, stripclub)", function()
    local objTable = entities.get_all_objects_as_pointers()
    local lookingFor = 367638847 -- || 0x15E9B93F || sf_prop_sf_codes_01a || HEXtoDECIMAL
    for i = 1, #objTable do
        if entities.get_model_hash(objTable[i]) == lookingFor then
            local h = entities.pointer_to_handle(objTable[i])
            local ppos = getEntityCoords(GetLocalPed())
            ENTITY.SET_ENTITY_COORDS(h, ppos.x, ppos.y, ppos.z, false, false, false, false)
            break
        end
    end
end)

menu.toggle_loop(helperFeatures, "透视无人机 (试验)", {}, "", function ()
    local objs = entities.get_all_objects_as_pointers()
    for _, obj in pairs(objs) do
        if (entities.get_model_hash(obj) == 430841677) or (entities.get_model_hash(obj) == -1324942671) then --nano drone object
            local pos = entities.get_position(obj)
            local ourpedpos = getEntityCoords(GetLocalPed())
            GRAPHICS.DRAW_LINE(ourpedpos.x, ourpedpos.y, ourpedpos.z, pos.x, pos.y, pos.z, 255, 255, 255, 255)
        end
    end
end)

--1: building
--2: vehicle
--3: simplePed
--4: precisePed
--5: objects
-- this is for raycasting (FLAGS)

-- menu.toggle(helperFeatures, "反自瞄", {"keramiaa"}, "CSGO式攻击.", function (on)
--     local anti_aim = on
--     while anti_aim do
        
--     end
-- end)

--------------------------------------------------------------------------------------------------------------------------

local editGuns = menu.list(Fight_script, "工具枪", {}, "")

--todo: 2take1 edit gun.
--[[
    Get bone coords 0
    Raycast, toDir returns direction vector normalized to 1.
    (flag 2)
    Get that coord,
    offset from bone 0
    attach with that offset.
]]

local attachGun = menu.list(editGuns, "附加枪 (非物理)", {}, "附加枪的设置, 将实体附加到实体.")
local attach_gun = {
    e1 = 0, e2 = 0,
    bone = 0,
    px = 0, py = 0, pz = 0,
    rx = 0, ry = 0, rz = 0,
    softPinning = false, collision = false,
    vertexIndex = 0, fixedRot = true
}
menu.divider(attachGun, "------")
menu.toggle_loop(attachGun, "开启", {"attachgun"}, "以非物理方式将实体附加到实体 (没有PED).", function ()
    if attach_gun.e1 == 0 then util.draw_debug_text("移动1") elseif attach_gun.e2 == 0 then util.draw_debug_text("移动2") end
    if PLAYER.IS_PLAYER_FREE_AIMING(players.user()) then
        if PAD.IS_CONTROL_JUST_PRESSED(0, 54) then -- 54 || INPUT_WEAPON_SPECIAL_TWO || E
            local entpointer = memory.alloc()
            util.toast("分配.")
            if PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(players.user(), entpointer) then
                local handle = memory.read_int(entpointer)
                if ENTITY.IS_ENTITY_A_PED(handle) then handle = PED.GET_VEHICLE_PED_IS_IN(handle, false) end
                if attach_gun.e1 == 0 then
                    attach_gun.e1 = handle
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(handle)
                elseif attach_gun.e2 == 0 then
                    if attach_gun.e1 == handle then util.toast("不能有相同的实体!") else
                        attach_gun.e2 = handle
                        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(handle)
                        ---- --- -- ---
                        util.toast("附加完成!")
                        --attachments here
                        local en1 = attach_gun.e1
                        local en2 = attach_gun.e2
                        --(entity1, entity2, boneIndex, xPos, yPos, zPos, xRot, yRot, zRot, p9, useSoftPinning, collision, isPed, vertexIndex, fixedRot)
                        ENTITY.ATTACH_ENTITY_TO_ENTITY(en1, en2, attach_gun.bone, attach_gun.px, attach_gun.py, attach_gun.pz, attach_gun.rx, attach_gun.ry, attach_gun.rz, false,
                        attach_gun.softPinning, attach_gun.collision, false, attach_gun.vertexIndex, attach_gun.fixedRot)
                        --clear edit gun memory
                        attach_gun.e1 = 0
                        attach_gun.e2 = 0
                    end
                end
            end
            util.toast("释放.")
            memory.free(entpointer)
        end
    end
end)

menu.divider(attachGun, "设置")
menu.slider(attachGun, "骨骼位置", {"attachGunbone"}, "附枪骨骼位置.仅限高级用户!", -100000, 100000, 0, 1, function(value) attach_gun.bone = value end)
menu.slider(attachGun, "X 偏移", {"attachGunxoffset"}, "", -10000, 10000, 0, 100, function (value) attach_gun.px = value/100 end);menu.slider(attachGun, "Y 偏移", {"attachGunyoffset"}, "", -10000, 10000, 0, 100, function (value) attach_gun.py = value/100 end);menu.slider(attachGun, "Z 偏移", {"attachGunzoffset"}, "", -10000, 10000, 0, 100, function (value) attach_gun.pz = value/100 end)
menu.slider(attachGun, "X 旋转", {"attachGunrotx"}, "", -360, 360, 0, 10, function (value) attach_gun.rx = value end); menu.slider(attachGun, "Y 旋转", {"attachGunroty"}, "", -360, 360, 0, 10, function (value) attach_gun.ry = value end); menu.slider(attachGun, "Z 旋转", {"attachGunrotz"}, "", -360, 360, 0, 10, function (value) attach_gun.rz = value end)
menu.toggle(attachGun, "软连接", {"attachGunsoftpinning"}, "如果设置为关闭,则固定时附加实体不会分离.", function (toggle) attach_gun.softPinning = toggle end)
menu.toggle(attachGun, "碰撞", {"attachGuncollision"}, "控制两个实体之间的碰撞. 设置关闭则是禁用碰撞.", function (toggle) attach_gun.collision = toggle end)
menu.slider(attachGun, "顶点位置", {"attachGunvertex"}, "仅限高级用户!顶点位置.", -100000, 100000, 0, 1, function (value) attach_gun.vertexIndex = value end)
menu.toggle(attachGun, "固定旋转", {"attachGunfixedrot"}, "如果为关闭，则忽略实体向量.", function (toggle) attach_gun.fixedRot = toggle end, true)


local p_AttachGun = menu.list(editGuns, "附加枪 (物理)", {}, "Attach gun that uses ATTACH_ENTITY_TO_ENTITY_PHYSICALLY, making entites have collision with each other.")
local p_attach_gun = {
    e1 = 0, e2 = 0,
    bone1 = 0, bone2 = 0,
    px1 = 0, py1 = 0, pz1 = 0,
    px2 = 0, py2 = 0, pz2 = 0,
    rx = 0, ry = 0, rz = 0,
    breakforce = 200, fixedRot = true,
    collision = true, dontTPToBone = true,
}
menu.divider(p_AttachGun, "------")
menu.toggle_loop(p_AttachGun, "开启", {"pattachgun"}, "以物理方式将实体连接到实体(无ped).", function ()
    if p_attach_gun.e1 == 0 then util.draw_debug_text("移动1") elseif p_attach_gun.e2 == 0 then util.draw_debug_text("移动2") end
    if PLAYER.IS_PLAYER_FREE_AIMING(players.user()) then
        if PAD.IS_CONTROL_JUST_PRESSED(0, 54) then -- 54 || INPUT_WEAPON_SPECIAL_TWO || E
            local entpointer = memory.alloc()
            util.toast("分配.")
            if PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(players.user(), entpointer) then
                local handle = memory.read_int(entpointer)
                if ENTITY.IS_ENTITY_A_PED(handle) then handle = PED.GET_VEHICLE_PED_IS_IN(handle, false) end
                if p_attach_gun.e1 == 0 then
                    p_attach_gun.e1 = handle
                    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(handle)
                elseif p_attach_gun.e2 == 0 then
                    if p_attach_gun.e1 == handle then util.toast("不能有相同的实体!") else
                        p_attach_gun.e2 = handle
                        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(handle)
                        ---- --- -- ---
                        util.toast("附加完成!")
                        --(​Entity entity1, Entity entity2, int boneIndex1, int boneIndex2, float xPos1, float yPos1, float zPos1, float xPos2, float yPos2, float zPos2,
                        -- float xRot, float yRot, float zRot, float breakForce, BOOL fixedRot, BOOL p15, BOOL collision, BOOL p17, int p18)
                        ENTITY.ATTACH_ENTITY_TO_ENTITY_PHYSICALLY(p_attach_gun.e1, p_attach_gun.e2,
                        p_attach_gun.bone1, p_attach_gun.bone2,
                        p_attach_gun.px1, p_attach_gun.py1, p_attach_gun.pz1, p_attach_gun.px2, p_attach_gun.py2, p_attach_gun.pz2,
                        p_attach_gun.rx, p_attach_gun.ry, p_attach_gun.rz,
                        p_attach_gun.breakforce, p_attach_gun.fixedRot, true, p_attach_gun.collision, p_attach_gun.dontTPToBone, 2)
                        --clear edit gun memory
                        p_attach_gun.e1 = 0
                        p_attach_gun.e2 = 0
                    end
                end
            end
            util.toast("释放.")
            memory.free(entpointer)
        end
    end
end)
menu.divider(p_AttachGun, "设置")
menu.slider(p_AttachGun, "骨骼位置 1", {"pattachbone1"}, "仅限高级用户!", -100000, 100000, 0, 1, function (value) p_attach_gun.bone1 = value end) menu.slider(p_AttachGun, "骨骼位置 2", {"pattachbone2"}, "仅限高级用户!", -100000, 100000, 0, 1, function (value) p_attach_gun.bone2 = value end)
menu.slider(p_AttachGun, "X 偏移 1", {"pattachx1"}, "X 偏移: 实体 1", -100000, 100000, 0, 100, function (value) p_attach_gun.px1 = value/100 end) menu.slider(p_AttachGun, "Y 偏移 1", {"pattachy1"}, "Y 偏移: 实体 1", -100000, 100000, 0, 100, function (value) p_attach_gun.py1 = value/100 end) menu.slider(p_AttachGun, "Z 偏移 1", {"pattachz1"}, "Z 偏移: 实体 1", -100000, 100000, 0, 100, function (value) p_attach_gun.pz1 = value/100 end)
menu.slider(p_AttachGun, "X 偏移 2", {"pattachx2"}, "X 偏移: 实体 2", -100000, 100000, 0, 100, function (value) p_attach_gun.px2 = value/100 end) menu.slider(p_AttachGun, "Y 偏移 2", {"pattachy2"}, "Y 偏移: 实体 2", -100000, 100000, 0, 100, function (value) p_attach_gun.py2 = value/100 end) menu.slider(p_AttachGun, "Z 偏移 2", {"pattachz2"}, "Z 偏移: 实体 2", -100000, 100000, 0, 100, function (value) p_attach_gun.pz2 = value/100 end)
menu.slider(p_AttachGun, "X 旋转", {"pattachxrot"}, "", -360, 360, 0, 10, function (value) p_attach_gun.rx = value end) menu.slider(p_AttachGun, "Y 旋转", {"pattachyrot"}, "", -360, 360, 0, 10, function (value) p_attach_gun.ry = value end) menu.slider(p_AttachGun, "Z 旋转", {"pattachzrot"}, "", -360, 360, 0, 10, function (value) p_attach_gun.rz = value end)
menu.slider(p_AttachGun, "断裂力", {"pattachbreakforce"}, "打破这种结合所需的力量.", 0, 100000, 200, 100, function (value) p_attach_gun.breakforce = value end)
menu.toggle(p_AttachGun, "固定旋转", {"pattachfixedrot"}, "如果为关闭，则忽略实体向量.", function (toggle) p_attach_gun.fixedRot = toggle end, true)
menu.toggle(p_AttachGun, "碰撞", {"pattachcollision"}, "控制两个实体之间的碰撞. 设置关闭则是禁用碰撞.", function (toggle) p_attach_gun.collision = toggle end, true)
menu.toggle(p_AttachGun, "不传送到骨骼位置", {"pattachdonttptobone"}, "不要将实体传送到目标实体骨骼索引的位置.", function (toggle) p_attach_gun.dontTPToBone = toggle end, true)
--WIP


--------------------------------------------------------------------------------------------------------------------------

function funcsForEntity(handleTable, intMenuList, handle)
    menu.action(intMenuList, "删除列表", {}, "删除实体的文件夹. 如果这个实体消失了,但列表中没有消失,则使用此选项.", function()
        menu.delete(intMenuList)
        local indx = GetValueIndexFromTable(handleTable, handle)
        table.remove(handleTable, indx)
    end)
    menu.action(intMenuList, "删除实体", {}, "", function()
        entities.delete_by_handle(handle)
    end)
    menu.action(intMenuList, "请求控制", {}, "请求控制实体.", function()
        for i = 1, 10 do 
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(handle)
            util.yield()
        end
        if (NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(handle)) then util.toast("拥有控制权.") else util.toast("无法控制!") end
    end)
    menu.action(intMenuList, "传送到我", {}, "将实体传送给你.", function()
        local mypos = getEntityCoords(GetLocalPed())
        ENTITY.SET_ENTITY_COORDS(handle, mypos.x, mypos.y, mypos.z, false, false, false, false)
    end)
    menu.action(intMenuList, "附加到我自己", {}, "将实体附加到您身上,没有碰撞. 更多选择可能会晚些时候!", function()
        ENTITY.ATTACH_ENTITY_TO_ENTITY(handle, GetLocalPed(), -1, 0, 0, 0, 0, 0, 0, true, true, false, false, 0, true, true)
    end)
    menu.action(intMenuList, "传送到随机玩家", {}, "将实体传送给随机玩家.", function()
        local plist = players.list(false, true, true)
        local randomIndex = math.random(1, #plist)

        local randomPID = plist[randomIndex]
        local pos = getEntityCoords(getPlayerPed(randomPID))
        ENTITY.SET_ENTITY_COORDS(handle, pos.x, pos.y, pos.z, false, false, false, false)
        util.toast("传送到 PID: " .. randomPID .. " || 名字: " .. GetPlayerName_pid(randomPID))
    end)
    menu.action(intMenuList, "向任意方向发射", {}, "以随机方向发射实体.", function()
        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(handle, 1,
            math.random(100, 2000), math.random(100, 2000), math.random(100, 2000),
            true, false, true)
    end)
end

function doesEntityExist(handleTable, intMenuList, handle)
    if (not ENTITY.DOES_ENTITY_EXIST(handle)) then
        local indx = GetValueIndexFromTable(handleTable, handle)
        table.remove(handleTable, indx)
        menu.delete(intMenuList)
        return false
    end
    util.yield(500)
end

function makeListForEntity(parent, entityHandle)
    return menu.list(parent, GetEntityTypeString(entityHandle) .. " | 移动: " .. entityHandle, {}, "")
end

EntityManipulationHandleList = {}
local entityManipulation = menu.list(Fight_script, "实体操纵枪", {"emanipulation"}, "对玩家无效.")
menu.divider(entityManipulation, "实体操作")

menu.toggle_loop(entityManipulation, "启用 (添加实体)", {}, "", function()
    if (PED.IS_PED_SHOOTING(GetLocalPed()) and PLAYER.IS_PLAYER_FREE_AIMING(players.user())) then
        local entityPointer = memory.alloc()

        if PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(players.user(), entityPointer) then
            local entityHandle = memory.read_int(entityPointer)
            --don't need the pointer anymore...
            memory.free(entityPointer)

            --put it in table so we don't add it again l8r
            if (DoesTableContainValue(EntityManipulationHandleList, entityHandle)) then util.toast("实体已在列表中!") return end
            EntityManipulationHandleList[#EntityManipulationHandleList+1] = entityHandle

            --if we shoot a car, it gives us the ped driving. So why not include the car as well?
            if (ENTITY.IS_ENTITY_A_PED(entityHandle) and PED.IS_PED_IN_ANY_VEHICLE(entityHandle, false)) then
                local veh = PED.GET_VEHICLE_PED_IS_IN(entityHandle, false)
                local mlistBufferVeh = makeListForEntity(entityManipulation, veh)
                funcsForEntity(EntityManipulationHandleList, mlistBufferVeh, veh)
            end

            --make the list with the functions
            local mListBuffer = makeListForEntity(entityManipulation, entityHandle)
            funcsForEntity(EntityManipulationHandleList, mListBuffer, entityHandle)

            --make the tick handler so that it deletes list when entity is deleted
            --tysm Zack#1307 for fixing my error w/ the tick handler!
            util.create_tick_handler(function() return doesEntityExist(EntityManipulationHandleList, mListBuffer, entityHandle) end)
            if (SE_Notifications) then util.toast("添加实体!") end
        end
    end
end)




--------------------------------------------------------------------------------------------------------------------------

menu.divider(Fight_script, "----------设置----------")

menuToggle(Fight_script, "隐形爆炸", {"SE_invis", "seinvis"}, "切换爆炸是否不可见. 开=不可见. // 取消了燃烧瓶持久的火焰效果", function(on)
    SEisExploInvis = on
    if SE_Notifications then
        util.toast("爆炸不可见性设置为 " .. tostring(on))
    end
end, true) --last "true" is makes invisibility enabled by default.

menuToggle(Fight_script, "听得见的爆炸", {"SE_audible", "seaudible"}, "切换爆炸是否会被听到. 开=可听见.", function(on)
    SEisExploAudible = on
    if SE_Notifications then
        util.toast("爆炸声音设置为 " .. tostring(on))
    end
end)

menuToggle(Fight_script, "启用/禁用通知", {}, "禁用通知，如'粘贴炸弹已放置!' 或'已标记的实体'.' 诸如此类. 尤其是那些令人讨厌的平移功能.", function(on)
    SE_Notifications = on
end)

--------------------------------------------------------------------------------------------------------------------------

--preload explosion delay
SE_explodeDelay = 0
local function playerActionsSetup(pid) --set up player actions (necessary for each PID)
    menu.divider(menu.player_root(pid), scriptName)
    local playerMain = menu.list(menu.player_root(pid), scriptName, {}, "")
    menu.divider(playerMain, scriptName)
    local playerSuicides = menu.list(playerMain, "自杀", {}, "") --suicides parent
    local playerWeapons = menu.list(playerMain, "武器", {}, "") -- weapons parent
    local playerTools = menu.list(playerMain, "工具", {}, "") --tools parent
    local playerOtherTrolling = menu.list(playerMain, "恶搞", {}, "")

    --suicides

    menuAction(playerSuicides, "让玩家自爆", {"suicide"}, "", function()
        MakePlayerExplodeSuicide(pid)
    end)
    menuToggleLoop(playerSuicides, "循环自爆", {"loopsuicide"}, "", function()
        MakePlayerExplodeSuicide(pid)
        wait(SE_explodeDelay)
    end)
    menuAction(playerSuicides, "玩家自燃", {"suimolly", "suimolotov"}, "如果隐形爆炸开启，火焰将不会停留在玩家身上.", function()
        MakePlayerMolotovSuicide(pid)
    end)
    menuToggleLoop(playerSuicides, "循环自燃", {"loopsuimolly", "loopsuimolotov"}, "", function()
        MakePlayerMolotovSuicide(pid)
        wait(SE_explodeDelay)
    end)

    menu.click_slider(playerSuicides, "更改爆炸延迟 (毫秒)", {"SEexpdel"}, "以毫秒为单位更改爆炸延迟.最长10秒(10000毫秒)", 0, 10000, 0, 10, function(val)
        SE_explodeDelay = val
    end)

    -----------------------------------------------------------------------------------------------------------------------------------

    --weapons

    menuToggleLoop(playerWeapons, "爆炸枪", {"pexplogun"}, "给玩家一把爆炸枪.", function ()
        local pped = getPlayerPed(pid)
        local impactCoord = v3.new()
        local shot = WEAPON.GET_PED_LAST_WEAPON_IMPACT_COORD(pped, impactCoord)
        if shot then
            --local explo = {x = v3.getX(impactCoord), y = v3.getY(impactCoord), z = v3.getZ(impactCoord)}
            local explo = GetTableFromV3Instance(impactCoord)
            SE_add_owned_explosion(pped, explo.x, explo.y, explo.z, 2, 10, SEisExploAudible, SEisExploInvis, 0)
        end
        v3.free(impactCoord)
    end)

    -----------------------------------------------------------------------------------------------------------------------------------

    --other trolling

    menu.divider(playerOtherTrolling, "载具恶搞")
    local vehicletrolling = menu.list(playerOtherTrolling, "把车拖走", {}, "")
    menuAction(vehicletrolling, "将墙放在玩家面前", {}, "在玩家面前放置墙壁.半秒后删除.当他们向前驾驶史诗巨魔时使用这个.", function ()
        PlaceWallInFrontOfPlayer(pid)
    end)

    --preload
    VehTroll_VehicleName = "adder"
    VehTroll_Invis = false

    menu.divider(vehicletrolling, "丢弃载具")

    menuAction(vehicletrolling, "将载具放在玩家身上", {}, "", function ()
        DropVehicleOnPlayer(pid, VehTroll_VehicleName, VehTroll_Invis)
    end)

    menu.text_input(vehicletrolling, "输入载具名称", {"vehtrollname"}, "为载具投放输入载具名称. RAGE中赋予它的实际名称, 例如. 暴君MK2 = oppressor2.", function (text)
        VehTroll_VehicleName = tostring(text)
    end, "adder")

    menuToggle(vehicletrolling, "使载具隐形", {"vehtrollinvis"}, "", function(toggle)
        VehTroll_Invis = toggle
    end)

    -----------------------------------------------------------------------------

    menu.divider(vehicletrolling, "传送玩家的载具")

    menuAction(vehicletrolling, "将玩家传送到海洋中", {"tpocean"}, "可能需要多次点击.", function()
        TeleportPlayersVehicleToOcean(pid)
    end)

    menuAction(vehicletrolling, "将玩家传送到花园银行楼顶", {"tpmazebank"}, "可能需要多次点击.", function()
        TeleportPlayersVehicleToMazeBank(pid)
    end)

    menuToggleLoop(vehicletrolling, "伪造玩家的载具", {"vehfakelag"}, "将玩家的载具传送到他们身后一点,模拟延迟.", function ()
        FakeLagPlayerVehicle(pid)
    end)

    -----------------------------------------------------------------------------------------------------------------------------------

    menu.divider(playerOtherTrolling, "折磨功能")
    local ptossf = menu.list(playerOtherTrolling, "折磨玩家", {}, "")

    menuToggleLoop(ptossf, "把玩家扔来扔去", {"tossplayer", "toss", "ragtoss"}, "在玩家身上循环无伤害爆炸. 如果您这样设置它们，它们将是不可见的.", function()
        local playerCoords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), true)

        SE_add_explosion(playerCoords['x'], playerCoords['y'], playerCoords['z'], 1, 1, SEisExploAudible, SEisExploInvis, 0, true)
    end)

    -----------------------------------

    menu.divider(playerOtherTrolling, "传送实体")
    local pteleportEntities = menu.list(playerOtherTrolling, "传送实体到玩家", {}, "")
    menu.action(pteleportEntities, "将所有PED传送到玩家", {"dumppeds"}, "", function ()
        TpAllPeds(pid)
    end)
    menu.action(pteleportEntities, "将所有载具传送到玩家", {"dumpvehs"}, "", function ()
        TpAllVehs(pid)
    end)
    menu.action(pteleportEntities, "将所有物体传送到玩家", {"dumpobjs"}, "", function ()
        TpAllObjects(pid)
    end)
    menu.action(pteleportEntities, "将所有收集品传送到玩家", {"dumppickups"}, "", function ()
        TpAllPickups(pid)
    end)

    -----------------------------------

    menu.divider(playerOtherTrolling, "恶意功能")
    local ptoxic = menu.list(playerOtherTrolling, "恶意选项", {}, "")

    -----------------------------------

    
    menuAction(ptoxic, "无效的仓库邀请", {}, "", function ()
        util.trigger_script_event(1 << pid, {-446275082, pid, 0, 1, 0})
    end)
    menu.divider(ptoxic, "移除")
    menuAction(ptoxic, "自由模式死亡", {"fdeath"}, "", function ()
        FreemodeDeathPlayer(pid)
    end)
    menuAction(ptoxic, "AIO踢出", {"aiok", "aiokick"}, "如果在战局功能中启用了“更慢但是更好的aio ”,那么在这里也使用它。", function ()
        AIOKickPlayer(pid)
    end)
    menuAction(ptoxic, "瘟疫崩溃", {"byeplague"}, "在很少的菜单上工作，但在合法的菜单上工作.", function ()
        PlagueCrashPlayer(pid)
    end)
    menu.action(ptoxic, "无效服装崩溃", {"badoutfit"}, "", function ()
        BadOutfitCrash(pid)
    end)
    menu.action(ptoxic, "错误网络载具崩溃", {"badnetveh"}, "", function ()
        BadNetVehicleCrash(pid)
    end)
    menu.action(ptoxic, "绳索崩溃战局", {"badrope"}, "", function()
        RopeCrashLobby(pid)
    end)
    ---------------------------------------------------------------------------------------------------------

    

    ---------------------------------------------------------------------------------------------------------

    menu.divider(playerTools, "移动检查")

    --preload
    SE_waittime = 1000
    menuToggleLoop(playerTools, "移动检查", {"movecheck"}, "如果该玩家正在移动则会通知你.", function ()
        local pped = getPlayerPed(pid)
        local pcoords1 = getEntityCoords(pped)
        wait(SE_waittime)
        local pcoords2 = getEntityCoords(pped)
        if pcoords1.x ~= pcoords2.x or pcoords1.y ~= pcoords2.y or pcoords1.z ~= pcoords2.z then
            local playerName = tostring(PLAYER.GET_PLAYER_NAME(pid))
            util.toast(playerName .. " 正在移动!")
        end
    end)

    menu.slider(playerTools, "移动检查间隔 (毫秒)", {"movecheckms"}, "它检查移动需要多少毫秒,1000毫秒= 1秒", 1, 60000, 1000, 100, function(value)
        SE_waittime = value
        if SE_Notifications then
            util.toast("将移动检查间隔设置为 " .. SE_waittime)
        end
    end)

    menu.divider(playerTools, "掉帧")

    Ptools_PanTable = {}
    Ptools_PanCount = 1
    Ptools_FishPan = 20

    menuAction(playerTools, "掉帧", {"pan"}, "", function ()
        local targetped = getPlayerPed(pid)
        local targetcoords = getEntityCoords(targetped)

        local hash = joaat("tug")
        requestModel(hash)
        while not hasModelLoaded(hash) do wait() end

        for i = 1, Ptools_FishPan do
            Ptools_PanTable[Ptools_PanCount] = VEHICLE.CREATE_VEHICLE(hash, targetcoords.x, targetcoords.y, targetcoords.z, 0, true, true, true)
            ----
            local netID = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(Ptools_PanTable[Ptools_PanCount])
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(Ptools_PanTable[Ptools_PanCount])
            NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(netID)
            NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(netID)
            NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netID, false)
            NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(netID, pid, true)
            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Ptools_PanTable[Ptools_PanCount], true, false)
            ENTITY.SET_ENTITY_VISIBLE(Ptools_PanTable[Ptools_PanCount], false, 0)
            ----
            if SE_Notifications then
                util.toast("使用的索引生成 " .. Ptools_PanCount)
            end
            Ptools_PanCount = Ptools_PanCount + 1
        end
    end)

    --preload

    menu.slider(playerTools, "炸鱼的数量", {"friedfish"}, "", 1, 300, 20, 1, function(value)
        Ptools_FishPan = value
    end)

    menuAction(playerTools, "移除掉帧", {"rmpan"}, "", function ()
        for x = 1, 5, 1 do
            for i = 1, #Ptools_PanTable do
                entities.delete_by_handle(Ptools_PanTable[i])
                wait(10)
            end
        end
        --
        Ptools_PanCount = 1
        Ptools_PanTable = {}
        noNeedModel(util.joaat("tug"))
    end)

    menu.divider(playerTools, "无敌工具")

    menuAction(playerTools, "无敌检查", {"godcheck"}, "", function()
        if (players.is_godmode(pid) and not players.is_in_interior(pid)) then
            util.toast(players.get_name(pid) .. " 是无敌!")
        elseif (players.is_in_interior(pid)) then
            util.toast(players.get_name(pid) .. " 在室内!")
        else
            util.toast(players.get_name(pid) .. " 不是无敌!")
        end
    end)

    menuToggleLoop(playerTools, "移除玩家无敌", {"rmgod"}, "移除玩家的无敌,如果他们没有使用一个好的付费菜单.", function ()
        util.trigger_script_event(1 << pid, {801199324, pid, 869796886})
    end)

    menuToggleLoop(playerTools, "移除玩家载具无敌", {"rmvehgod"}, "逐步移除玩家的载具无敌.", function()
        local ped = getPlayerPed(pid)
        if PED.IS_PED_IN_ANY_VEHICLE(ped, false) and not PED.IS_PED_DEAD_OR_DYING(ped) then
            local veh = PED.GET_VEHICLE_PED_IS_IN(ped, false)
            ENTITY.SET_ENTITY_CAN_BE_DAMAGED(veh, true)
            ENTITY.SET_ENTITY_INVINCIBLE(veh, false)
        end
    end)

    menu.divider(playerTools, "平滑传送")

    menuAction(playerTools, "平滑传送", {"stp"}, "平滑传送到玩家.如果他们在一辆车里,它会平稳的传送到他们的车里.", function()
        local targetPed = getPlayerPed(pid)
        local targetCoords = getEntityCoords(targetPed)
        if not PED.IS_PED_IN_ANY_VEHICLE(targetPed, true) then
            SmoothTeleportToCord(targetCoords)
        else
            SmoothTeleportToVehicle(targetPed)
        end
    end)

    ----------------------------------------------------------------------------

    menu.divider(playerMain, "设置")

    menuToggle(playerMain, "来自无声自瞄的黑名单", {"aimblacklist"}, "将选定的玩家列入无声自瞄黑名单.", function(on)
        AIM_WHITELIST[pid] = on
    end)

    menuToggle(playerMain, "自爆卡车黑名单", {"carbombblacklist"}, "将选定的玩家列入黑名单,禁止其标记载具自爆.", function(on)
        CAR_S_BLACKLIST[pid] = on
    end)

    menuToggle(playerMain, "讨厌玩家", {"hate"}, "将除此人之外的所有人加入自瞄白名单.", function (on)
        local hate = on
        local hatername = GetPlayerName_pid(pid)
        local playerTable = players.list(false, true, true)
        if hate then
            for i = 1, #playerTable do
                local name = GetPlayerName_pid(playerTable[i])
                menu.trigger_commands("aimblacklist " .. name .. " on")
                wait()
            end
            menu.trigger_commands("aimblacklist " .. hatername .. " off")
            util.toast("我讨厌他.")
        end
        if not hate then
            for i = 1, #playerTable do
                local name = GetPlayerName_pid(playerTable[i])
                menu.trigger_commands("aimblacklist " .. name .. " off")
                wait()
            end
            util.toast("我讨厌他.")
        end
    end)

end

players.on_join(playerActionsSetup)
players.dispatch_on_join()
