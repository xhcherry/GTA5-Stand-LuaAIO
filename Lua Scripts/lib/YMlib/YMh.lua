util.keep_running()
util.require_natives(1663599433)
local root = heidong
local yourself
local yourselfCoord = {x=0,y=0,z=0}
local visualHelp = false
local visualHelpEnt
local entityToSpawn = util.joaat("prop_mk_sphere")
local blackHole = false
local blackHoleType = "black"
local blackHoleVehicle
local blackHolePos = {x = 0, y = 0, z = 0}
local vehiclePos = {x = 0, y = 0, z = 0}
local tableBlackHole = {"拉", "推",}
local pushStrength = 1
local pushToX = 1
local pushToY = 1
local pushToZ = 1

local blackHoleMenu = menu.toggle(root, "黑洞开关", {}, "", function(a)
    blackHole = a
end)

local visualHelpMenu = menu.toggle(root, "视觉帮助", {}, "在黑洞中心生成一个实体(没有碰撞)", function(a)
    visualHelp = a
end)

local blackHoleTypeMenu = menu.list_select(root, "黑洞类型 ", {}, "选择黑洞的作用", tableBlackHole, 1, function(a)
    a -= 1
    if a == 0 then
        blackHoleType = "Black"
    elseif a == 1 then
        blackHoleType = "White"
    end
end)

local pushStrengthMenu = menu.slider(root, "设置黑洞强度", {}, "设置拉或推的力度(如果力度设置为100，距离太近会使你在地图中走样)我建议力度在5到10之间", 1, 100, 1, 1, function(a)
    pushStrength = a
end)


local blackHolePosX = menu.slider(root, "黑洞位置 X", {"coordBlackHoleX"}, "设置黑洞在地图X轴上的坐标", -100000, 100000, 0, 1, function(a)
    blackHolePos.x = a
end)

local blackHolePosY = menu.slider(root, "黑洞位置 Y", {"coordBlackHoleY"}, "设置黑洞在地图Y轴上的坐标", -100000, 100000, 0, 1, function(a)
    blackHolePos.y = a
end)

local blackHolePosZ = menu.slider(root, "黑洞位置 Z", {"coordBlackHoleZ"}, "设置黑洞在地图Z轴上的坐标", -100000, 100000, 0, 1, function(a)
    blackHolePos.z = a
end)

menu.action(root, "在玩家处设定黑洞的位置", {}, "在你的人物当前位置设置黑洞的位置", function()
    blackHolePos.x = yourselfCoord.x
    blackHolePos.y = yourselfCoord.y
    blackHolePos.z = yourselfCoord.z
    blackHolePosX.value = math.floor(blackHolePos.x)
    blackHolePosY.value = math.floor(blackHolePos.y)
    blackHolePosZ.value = math.floor(blackHolePos.z)
end)


util.create_tick_handler(function()
    if ENTITY.DOES_ENTITY_EXIST(visualHelpEnt) then
        if visualHelp == true then
            ENTITY.SET_ENTITY_COORDS(visualHelpEnt, blackHolePos.x, blackHolePos.y, blackHolePos.z, false, false, false, false)
        elseif visualHelp == false then
            ENTITY.SET_ENTITY_COORDS(visualHelpEnt, 0, 0, 0, false, false, false, false)
        end
    else
        visualHelpEnt = entities.create_object(entityToSpawn, blackHolePos)
        ENTITY.FREEZE_ENTITY_POSITION(visualHelpEnt, true)
        ENTITY.SET_ENTITY_COLLISION(visualHelpEnt, true, false)
    end
    util.yield(100)
end)


util.create_tick_handler(function()
    yourself = PLAYER.GET_PLAYER_PED(players.user())
    yourselfCoord = ENTITY.GET_ENTITY_COORDS(yourself)
    if blackHole == true then
        blackHoleVehicle = entities.get_all_vehicles_as_handles()
        for index, value in ipairs(blackHoleVehicle) do
            vehiclePos = ENTITY.GET_ENTITY_COORDS(value)
            if ENTITY.DOES_ENTITY_EXIST(value) == true then
                if NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(value) == false then
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(value)
                end

                if blackHoleType == "black" then
                    if blackHolePos.x > vehiclePos.x then
                        pushToX = pushStrength
                    elseif blackHolePos.x < vehiclePos.x then
                        pushToX = -pushStrength
                    end
                    if blackHolePos.y > vehiclePos.y then
                        pushToY = pushStrength
                    elseif blackHolePos.y < vehiclePos.y then
                        pushToY = -pushStrength
                    end
                    if blackHolePos.z > vehiclePos.z then
                        pushToZ = pushStrength
                    elseif blackHolePos.z < vehiclePos.z then
                        pushToZ = -pushStrength
                    end
                    ENTITY.APPLY_FORCE_TO_ENTITY(value, 1, pushToX, pushToY, pushToZ, 0, 0, 0, 0, false, true, true, false)
                elseif blackHoleType == "white" then
                    if blackHolePos.x > vehiclePos.x then
                        pushToX = -pushStrength
                    elseif blackHolePos.x < vehiclePos.x then
                        pushToX = pushStrength
                    end
                    if blackHolePos.y > vehiclePos.y then
                        pushToY = -pushStrength
                    elseif blackHolePos.y < vehiclePos.y then
                        pushToY = pushStrength
                    end
                    if blackHolePos.z > vehiclePos.z then
                        pushToZ = -pushStrength
                    elseif blackHolePos.z < vehiclePos.z then
                        pushToZ = pushStrength
                    end
                    ENTITY.APPLY_FORCE_TO_ENTITY(value, 1, pushToX, pushToY, pushToZ, 0, 0, 0, 0, false, true, true, false)
                end
            end
        end
    end
end)


PlayerMenu = function(pid)
    local player = menu.player_root(pid)
    player:divider("夜幕单体黑洞选项")
    player:toggle_loop("使黑洞附加到玩家 "..players.get_name(pid), {}, "", function()
        local playerCoord = players.get_position(pid)
        blackHolePos.x = playerCoord.x
        blackHolePos.y = playerCoord.y
        blackHolePos.z = playerCoord.z

        blackHolePosX.value = math.floor(blackHolePos.x)
        blackHolePosY.value = math.floor(blackHolePos.y)
        blackHolePosZ.value = math.floor(blackHolePos.z)

        visualHelpMenu.value = false
        blackHoleMenu.value = true
        blackHoleTypeMenu.value = 1

        util.yield(5)
    end, function ()
        blackHoleMenu.value = false
    end)
    player:slider("黑洞强度", {}, "", 1, 100, 1, 1, function(a)
        pushStrengthMenu.value = a
    end)
end



for _,pid in pairs(players.list()) do
    PlayerMenu(pid)
end
players.on_join(PlayerMenu)