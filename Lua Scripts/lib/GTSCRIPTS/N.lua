-- Author: Rostal
-- Last edit date: 2022/8/1
require "lib.GTSCRIPTS.V"

--- --- --- Functions --- --- ---


function IS_PED_PLAYER(Ped)
    if PED.GET_PED_TYPE(Ped) >= 4 then
        return false
    else
        return true
    end
end

function TELEPORT(X, Y, Z)
    local Me = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
    if PED.GET_VEHICLE_PED_IS_IN(Me, false) == 0 then
        ENTITY.SET_ENTITY_COORDS(Me, X, Y, Z)
    else
        ENTITY.SET_ENTITY_COORDS(PED.GET_VEHICLE_PED_IS_IN(Me, false), X, Y, Z)
    end
end

vect = {
    ['new'] = function(x, y, z)
        return { ['x'] = x, ['y'] = y, ['z'] = z }
    end,
    ['subtract'] = function(a, b)
        return vect.new(a.x - b.x, a.y - b.y, a.z - b.z)
    end,
    ['add'] = function(a, b)
        return vect.new(a.x + b.x, a.y + b.y, a.z + b.z)
    end,
    ['mag'] = function(a)
        return math.sqrt(a.x ^ 2 + a.y ^ 2 + a.z ^ 2)
    end,
    ['norm'] = function(a)
        local mag = vect.mag(a)
        return vect.div(a, mag)
    end,
    ['mult'] = function(a, b)
        return vect.new(a.x * b, a.y * b, a.z * b)
    end,
    ['div'] = function(a, b)
        return vect.new(a.x / b, a.y / b, a.z / b)
    end,
    ['dist'] = function(a, b)
        --returns the distance between two vectors
        return vect.mag(vect.subtract(a, b))
    end
}


--returns a list of nearby vehicles given player Id
function GET_NEARBY_VEHICLES(pid, radius)
    local vehicles = {}
    local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(p)
    local v = PED.GET_VEHICLE_PED_IS_IN(p, false)
    for k, vehicle in pairs(entities.get_all_vehicles_as_handles()) do
        local veh_pos = ENTITY.GET_ENTITY_COORDS(vehicle)
        if vehicle ~= v and vect.dist(pos, veh_pos) <= radius then
            table.insert(vehicles, vehicle)
        end
    end
    return vehicles
end

--returns a list of nearby peds given player Id
function GET_NEARBY_PEDS(pid, radius)
    local peds = {}
    local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local pos = ENTITY.GET_ENTITY_COORDS(p)
    for k, ped in pairs(entities.get_all_peds_as_handles()) do
        if ped ~= p then
            local ped_pos = ENTITY.GET_ENTITY_COORDS(ped)
            if vect.dist(pos, ped_pos) <= radius then
                table.insert(peds, ped)
            end
        end
    end
    return peds
end

--返回瞄准的实体
local GetEntity_PlayerIsAimingAt = function(p)
    local ent = NULL
    if PLAYER.IS_PLAYER_FREE_AIMING(p) then
        local ptr = memory.alloc_int()
        if PLAYER.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT(p, ptr) then
            ent = memory.read_int(ptr)
        end
        memory.free(ptr)
        if ENTITY.IS_ENTITY_A_PED(ent) and PED.IS_PED_IN_ANY_VEHICLE(ent) then
            local vehicle = PED.GET_VEHICLE_PED_IS_IN(ent, false)
            ent = vehicle
        end
    end
    return ent
end
--为实体添加小地图标记
function addBlipForEntity(entity, blipSprite, colour)
    local blip = HUD.ADD_BLIP_FOR_ENTITY(entity)
    HUD.SET_BLIP_SPRITE(blip, blipSprite)
    HUD.SET_BLIP_COLOUR(blip, colour)
    HUD.SHOW_HEIGHT_ON_BLIP(blip, false)
    HUD.SET_BLIP_ROTATION(blip, GENERIC_SYSTEM.CEIL(ENTITY.GET_ENTITY_HEADING(entity)))
    NETWORK.SET_NETWORK_ID_CAN_MIGRATE(entity, false)
    util.create_thread(function()
        while not ENTITY.IS_ENTITY_DEAD(entity) do
            local heading = ENTITY.GET_ENTITY_HEADING(entity)
            HUD.SET_BLIP_ROTATION(blip, GENERIC_SYSTEM.CEIL(heading))
            util.yield()
        end
        util.remove_blip(blip)
    end)
    return blip
end
------ STAT Functions ---
function MP_INDEX()
    return "MP" .. util.get_char_slot() .. "_"
end

function IS_MPPLY(Stat)
    if string.find(Stat, "MPPLY_") or string.find(Stat, "MP_") then
        return true
    else
        return false
    end
end

function STAT_SET_INT(Stat, Value)
    if IS_MPPLY(Stat) then
        STATS.STAT_SET_INT(util.joaat(Stat), Value, true)
    else
        STATS.STAT_SET_INT(util.joaat(MP_INDEX() .. Stat), Value, true)
    end
end

function STAT_SET_FLOAT(Stat, Value)
    if string.find(Stat, "MPPLY_") or string.find(Stat, "MP_") then
        STATS.STAT_SET_FLOAT(util.joaat(Stat), Value, true)
    else
        STATS.STAT_SET_FLOAT(util.joaat(MP_INDEX() .. Stat), Value, true)
    end
end

function STAT_SET_BOOL(Stat, Value)
    if string.find(Stat, "MPPLY_") or string.find(Stat, "MP_") then
        STATS.STAT_SET_BOOL(util.joaat(Stat), Value, true)
    else
        STATS.STAT_SET_BOOL(util.joaat(MP_INDEX() .. Stat), Value, true)
    end
end

function STAT_SET_INCREMENT(Stat, Value)
    if string.find(Stat, "MPPLY_") or string.find(Stat, "MP_") then
        STATS.STAT_INCREMENT(util.joaat(Stat), Value, true)
    else
        STATS.STAT_INCREMENT(util.joaat(MP_INDEX() .. Stat), Value, true)
    end
end

function STAT_GET_INT(Stat)
    local IntPTR = memory.alloc(4)

    if string.find(Stat, "MPPLY_") or string.find(Stat, "MP_") then
        STATS.STAT_GET_INT(util.joaat(Stat), IntPTR, -1)
    else
        STATS.STAT_GET_INT(util.joaat(MP_INDEX() .. Stat), IntPTR, -1)
    end

    return memory.read_int(IntPTR)
end

function STAT_GET_FLOAT(Stat)
    local FloatPTR = memory.alloc(4)

    if string.find(Stat, "MPPLY_") or string.find(Stat, "MP_") then
        STATS.STAT_GET_FLOAT(util.joaat(Stat), FloatPTR, -1)
    else
        STATS.STAT_GET_FLOAT(util.joaat(MP_INDEX() .. Stat), FloatPTR, -1)
    end

    return tonumber(string.format("%.3f", memory.read_float(FloatPTR)))
end

function STAT_GET_BOOL(Stat)
    local BoolPTR = memory.alloc(1)

    if string.find(Stat, "MPPLY_") or string.find(Stat, "MP_") then
        STATS.STAT_GET_BOOL(util.joaat(Stat), BoolPTR, -1)
    else
        STATS.STAT_GET_BOOL(util.joaat(MP_INDEX() .. Stat), BoolPTR, -1)
    end

    if memory.read_byte(BoolPTR) == 1 then
        return "true"
    else
        return "false"
    end
end

--- GLOBAL Functions ---
function SET_INT_GLOBAL(Global, Value)
    memory.write_int(memory.script_global(Global), Value)
end

function SET_FLOAT_GLOBAL(Global, Value)
    memory.write_float(memory.script_global(Global), Value)
end

-- GET
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

-- GET
function GET_INT_LOCAL(Script, Local)
    if memory.script_local(Script, Local) ~= 0 then
        return memory.read_int(memory.script_local(Script, Local))
    end
end

---
util.keep_running()



-------------------------------
---------- 周围实体选项 ----------
-------------------------------



local NEAR_PED_CAM = menu.list(entity_options, "管理附近的NPC和镜头", {"managecamera"}, "")

menu.divider(NEAR_PED_CAM, "设置")

local HostilePed = false
menu.toggle(NEAR_PED_CAM, "只对怀有敌意的NPC有效", {}, "启用：只对怀有敌意的NPC生效" .. "\n" .. "禁用：对所有NPC生效", function(Toggle)
    HostilePedToggle = Toggle

    if HostilePedToggle then
        HostilePed = true
    else
        HostilePed = false
    end
end)

menu.divider(NEAR_PED_CAM, "NPC选项")

menu.action(NEAR_PED_CAM, "移除NPC武器", {}, "", function()
    for k, ent in pairs(entities.get_all_peds_as_handles()) do
        if not IS_PED_PLAYER(ent) then
            if HostilePed then
                if PED.IS_PED_IN_COMBAT(ent, PLAYER.PLAYER_ID()) then
                    WEAPON.REMOVE_ALL_PED_WEAPONS(ent, true)
                end
            else
                WEAPON.REMOVE_ALL_PED_WEAPONS(ent, true)
            end
        end
    end
end)

menu.action(NEAR_PED_CAM, "删除所有NPC", {}, "", function()
    for k, ent in pairs(entities.get_all_peds_as_handles()) do
        if not IS_PED_PLAYER(ent) then
            if HostilePed then
                if PED.IS_PED_IN_COMBAT(ent, PLAYER.PLAYER_ID()) then
                    entities.delete_by_handle(ent)
                end
            else
                entities.delete_by_handle(ent)
            end
        end
    end
end)

menu.action(NEAR_PED_CAM, "杀死所有NPC", {}, "", function()
    for k, ent in pairs(entities.get_all_peds_as_handles()) do
        if not IS_PED_PLAYER(ent) then
            if HostilePed then
                if PED.IS_PED_IN_COMBAT(ent, PLAYER.PLAYER_ID()) then
                    ENTITY.SET_ENTITY_HEALTH(ent, 0.0)
                end
            else
                ENTITY.SET_ENTITY_HEALTH(ent, 0.0)
            end
        end
    end
end)

-----
menu.divider(NEAR_PED_CAM, "摄像头选项")

menu.action(NEAR_PED_CAM, "删除摄像头", {}, "删除附近所有监控与摄像头", function()
    -- Credit goes to Leif.Erickson
    for k, ent in pairs(entities.get_all_objects_as_handles()) do
        local EntityModel = ENTITY.GET_ENTITY_MODEL(ent)
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
            3061645218
        }

        for i = 1, #Cams do
            if EntityModel == Cams[i] then
                entities.delete_by_handle(ent)
            end
        end
    end
end)

menu.action(NEAR_PED_CAM, "摄像头抬头", {}, "使摄像头无法拍摄到您", function()
    -- Credit goes to Leif.Erickson
    for k, ent in pairs(entities.get_all_objects_as_handles()) do
        local EntityModel = ENTITY.GET_ENTITY_MODEL(ent)
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
            3061645218
        }

        for i = 1, #Cams do
            if EntityModel == Cams[i] then
                local pos = ENTITY.GET_ENTITY_COORDS(ent)
                ENTITY.SET_ENTITY_COORDS(ent, pos.x, pos.y, pos.z + 20.0, true, false, false, false)
            end
        end
    end
end)

-- -- 附近载具
local NEARBY_VEHICLE = menu.list(entity_options, "管理附近载具", {"managevehicle"}, "")

local radius_nearby_vehicle = 30
menu.slider(NEARBY_VEHICLE, "范围半径", { "radius_nearby_vehicle" }, "设定管理附近载具的范围数值", 0, 1000, 30, 10, function(value)
    radius_nearby_vehicle = value
end)

menu.action(NEARBY_VEHICLE, "爆炸附近载具", {}, "", function()
    for k, vehicle in pairs(GET_NEARBY_VEHICLES(players.user(), radius_nearby_vehicle)) do
        VEHICLE.EXPLODE_VEHICLE(vehicle, true, true)
    end
end)

menu.divider(NEARBY_VEHICLE, "载具上天")

local launch_vehicle_height = 20
menu.slider(NEARBY_VEHICLE, "上天高度", { "launch_vehicle_height" }, "设定载具发射上天的高度数值", 0, 1000, 20, 10, function(value)
    launch_vehicle_height = value
end)

local launch_vehicle_freeze = false
menu.toggle(NEARBY_VEHICLE, "冻结载具", {}, "", function(toggle)
    launch_vehicle_freeze = toggle
end)

menu.action(NEARBY_VEHICLE, "发射上天", {}, "", function()
    for k, vehicle in ipairs(GET_NEARBY_VEHICLES(players.user(), radius_nearby_vehicle)) do
        if vehicle ~= entities.get_user_vehicle_as_handle() then
            if launch_vehicle_freeze then
                ENTITY.FREEZE_ENTITY_POSITION(vehicle, true)
            end
            local pos = ENTITY.GET_ENTITY_COORDS(vehicle)
            ENTITY.SET_ENTITY_COORDS(vehicle, pos.x, pos.y, pos.z + launch_vehicle_height, false, false, false, false)
        end
    end
end)

-- -- 附近NPC
local NEARBY_PED = menu.list(entity_options, "管理附近NPC", {"managenpc"}, "")

local radius_nearby_ped = 30
menu.slider(NEARBY_PED, "范围半径", { "radius_nearby_ped" }, "设定管理附近NPC的范围数值", 0, 1000, 30, 10, function(value)
    radius_nearby_ped = value
end)

menu.divider(NEARBY_PED, "NPC上天")

local launch_ped_height = 20
menu.slider(NEARBY_PED, "上天高度", { "launch_ped_height" }, "设定NPC发射上天的高度数值", 0, 1000, 20, 10, function(value)
    launch_ped_height = value
end)

local launch_ped_freeze = false
menu.toggle(NEARBY_PED, "冻结NPC", {}, "", function(toggle)
    launch_ped_freeze = toggle
end)

menu.action(NEARBY_PED, "发射上天", {}, "", function()
    for k, ped in ipairs(GET_NEARBY_PEDS(players.user(), radius_nearby_ped)) do
        if not IS_PED_PLAYER(ped) then
            if launch_ped_freeze then
                ENTITY.FREEZE_ENTITY_POSITION(ped, true)
            end
            local pos = ENTITY.GET_ENTITY_COORDS(ped)
            ENTITY.SET_ENTITY_COORDS(ped, pos.x, pos.y, pos.z + launch_ped_height, false, false, false, false)
        end
    end
end)

---
menu.divider(NEARBY_PED, "NPC侦查视野")

local see_range = 0.0
menu.slider(NEARBY_PED, "视力范围", { "see_range" }, "控制NPC的视野", 0.0, 20.0, 0.0, 1.0, function(value)
    see_range = value
end)

local hear_range = 0.0
menu.slider(NEARBY_PED, "听力范围", { "hear_range" }, "控制NPC的听觉", 0.0, 20.0, 0.0, 1.0, function(value)
    hear_range = value
end)

local peripheral_range = 0.0
menu.slider(NEARBY_PED, "锥形视野范围", { "peripheral_range" }, "控制NPC的视野范围", 0.0, 20.0, 0.0, 1.0, function(value)
    peripheral_range = value
end)

local highly_perceptive = false
menu.toggle(NEARBY_PED, "高度警觉性", {}, "修改NPC的警觉度", function(toggle)
    highly_perceptive = toggle
end)

menu.action(NEARBY_PED, "设置", {}, "设定全部范围", function()
    for k, ped in ipairs(entities.get_all_peds_as_handles()) do
        if not IS_PED_PLAYER(ped) then
            PED.SET_PED_SEEING_RANGE(ped, see_range)
            PED.SET_PED_HEARING_RANGE(ped, hear_range)
            PED.SET_PED_VISUAL_FIELD_PERIPHERAL_RANGE(ped, peripheral_range)
            PED.SET_PED_HIGHLY_PERCEPTIVE(ped, highly_perceptive)
        end
    end
end)

-- -- 任务实体
local MISSION_ENTITY = menu.list(entity_options, "管理任务实体", {"manageobject"}, "")

local MISSION_ENTITY_custom = menu.list(MISSION_ENTITY, "自定义 Model Hash", {}, "")

local custom_model_hash
menu.text_input(MISSION_ENTITY_custom, "输入 Model Hash ", { "custom_model_hash" }, "", function(value)
    custom_model_hash = tonumber(value)
end)

local custom_all_entity = entities.get_all_peds_as_handles()
menu.slider_text(MISSION_ENTITY_custom, "实体类型", {}, "点击应用修改", { "Ped", "Vehicle", "Object", "Pickup" }, function(value)
    if value == 1 then
        custom_all_entity = entities.get_all_peds_as_handles()
        util.toast("Ped")
    elseif value == 2 then
        custom_all_entity = entities.get_all_vehicles_as_handles()
        util.toast("Vehicle")
    elseif value == 3 then
        custom_all_entity = entities.get_all_objects_as_handles()
        util.toast("Object")
    elseif value == 4 then
        custom_all_entity = entities.get_all_pickups_as_handles()
        util.toast("Pickup")
    end
end)

local custom_isMission_entity = true
menu.toggle(MISSION_ENTITY_custom, "IS A MISSION ENTITY", {}, "是否为任务实体", function(toggle)
    custom_isMission_entity = toggle
end, true)

menu.divider(MISSION_ENTITY_custom, "传送到我")

local custom_entity_tpme_x = 0.0
menu.slider(MISSION_ENTITY_custom, "离我左/右的距离", { "custom_entity_tpme_x" }, "", -100.0, 100.0, 0.0, 1.0, function(value)
    custom_entity_tpme_x = value
end)

local custom_entity_tpme_y = 2.0
menu.slider(MISSION_ENTITY_custom, "离我前/后的距离", { "custom_entity_tpme_y" }, "", -100.0, 100.0, 2.0, 1.0, function(value)
    custom_entity_tpme_y = value
end)

local custom_entity_tpme_z = 0.0
menu.slider(MISSION_ENTITY_custom, "离我上/下的高度", { "custom_entity_tpme_z" }, "", -100.0, 100.0, 0.0, 1.0, function(value)
    custom_entity_tpme_z = value
end)

local custom_entity_tpme_head = 0.0
menu.slider(MISSION_ENTITY_custom, "head朝向", { "custom_entity_tpme_head" }, "Not use", -360.0, 360.0, 0.0, 10.0, function(value)
    custom_entity_tpme_head = value
end)

menu.action(MISSION_ENTITY_custom, "传送到我", {}, "", function()
    local flag = false
    if custom_model_hash then
        for k, ent in pairs(custom_all_entity) do
            local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
            if EntityHash == custom_model_hash then
                flag = true
                if custom_isMission_entity then
                    if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
                        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), custom_entity_tpme_x, custom_entity_tpme_y, custom_entity_tpme_z)
                        ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
                    end
                else
                    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), custom_entity_tpme_x, custom_entity_tpme_y, custom_entity_tpme_z)
                    ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
                end
            end
        end

        if not flag then
            util.toast("No this entity !")
        end

    else
        util.toast("Wrong model hash !")
    end
end)

--- ---
local MISSION_ENTITY_cargo = menu.list(MISSION_ENTITY, "CEO拉货", {}, "")

menu.action(MISSION_ENTITY_cargo, "散货板条箱 传送到我", {}, "飞机空投\nModel Hash: -265116550", function()
    local entity_model_hash = -265116550
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_cargo, "散货板条箱 传送到我", {}, "被飞机抢走\nModel Hash: 1688540826", function()
    local entity_model_hash = 1688540826
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_cargo, "散货板条箱 传送到我", {}, "被窃贼抢走\n沉船打捞\nModel Hash: -1143129136", function()
    local entity_model_hash = -1143129136
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_cargo, "追踪的车 传送到我", {}, "Trackify 在车后备箱里\nModel Hash: -1322183878", function()
    local entity_model_hash = -1322183878
    for k, ent in pairs(entities.get_all_objects_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            if ENTITY.IS_ENTITY_ATTACHED(ent) then
                local attached_ent = ENTITY.GET_ENTITY_ATTACHED_TO(ent)
                local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -1.0)
                ENTITY.SET_ENTITY_COORDS(attached_ent, coords.x, coords.y, coords.z, true, false, false, false)

                local pHead = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())
                ENTITY.SET_ENTITY_HEADING(attached_ent, pHead + 90.0)
            end
        end
    end
end)

menu.action(MISSION_ENTITY_cargo, "TP to Special Cargo", { "scargo" }, "Teleport to Special Cargo pickup", function()
    local cPickup = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(478))
    HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(478))
    if cPickup.x == 0 and cPickup.y == 0 and cPickup.z == 0 then
        util.toast("No Cargo Found")
    else
        ENTITY.SET_ENTITY_COORDS(players.user_ped(), cPickup.x, cPickup.y, cPickup.z, false, false, false, false)
    end
end)

menu.action(MISSION_ENTITY_cargo, "TP to Vehicle Cargo", { "vcargo" }, "Teleport to Vehicle Cargo pickup", function()
    local vPickup = HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(523))
    HUD.GET_BLIP_COORDS(HUD.GET_NEXT_BLIP_INFO_ID(523))
    if vPickup.x == 0 and vPickup.y == 0 and vPickup.z == 0 then
        util.toast("No Vehicle Found")
    else
        ENTITY.SET_ENTITY_COORDS(players.user_ped(), vPickup.x, vPickup.y, vPickup.z, false, false, false, false)
    end
end)

--- ---
local MISSION_ENTITY_perico = menu.list(MISSION_ENTITY, "佩里科岛", {}, "")

menu.action(MISSION_ENTITY_perico, "佩里科岛：信号塔 传送到我", {}, "\nModel Hash: 1981815996", function()
    local entity_model_hash = 1981815996
    for k, ent in pairs(entities.get_all_objects_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)

            local pHead = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())
            ENTITY.SET_ENTITY_HEADING(ent, pHead)
        end
    end
end)

menu.action(MISSION_ENTITY_perico, "佩里科岛：发电站 传送到我", {}, "\nModel Hash: 1650252819", function()
    local entity_model_hash = 1650252819
    for k, ent in pairs(entities.get_all_objects_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, 1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)

            local pHead = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())
            ENTITY.SET_ENTITY_HEADING(ent, pHead)
        end
    end
end)

menu.action(MISSION_ENTITY_perico, "佩里科岛：保安服 传送到我", {}, "\nModel Hash: -1141961823", function()
    local entity_model_hash = -1141961823
    for k, ent in pairs(entities.get_all_objects_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_perico, "佩里科岛：螺旋切割器 传送到我", {}, "\nModel Hash: -710382954", function()
    local entity_model_hash = -710382954
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_perico, "佩里科岛：抓钩 传送到我", {}, "\nModel Hash: -1789904450", function()
    local entity_model_hash = -1789904450
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_perico, "佩里科岛：运货卡车 传送到我", {}, "自动删除npc卡车司机\nModel Hash: 2014313426", function()
    local entity_model_hash = 2014313426
    for k, ent in pairs(entities.get_all_vehicles_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(ent, -1)
            if ped > 0 then
                -- has npc in truck
                if not IS_PED_PLAYER(ped) then
                    entity.delete_entity(ped)
                end
            end

            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 3.0, 0.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)

            local pHead = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())
            ENTITY.SET_ENTITY_HEADING(ent, pHead + 90.0)
        end
    end
end)

--

menu.divider(MISSION_ENTITY_perico, "")

menu.action(MISSION_ENTITY_perico, "前置：长崎 传送到我", {}, "\nModel Hash: -1352468814", function()
    local entity_model_hash = -1352468814
    for k, ent in pairs(entities.get_all_vehicles_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 7.0, -1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)

            local pHead = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())
            ENTITY.SET_ENTITY_HEADING(ent, pHead + 180.0)
        end
    end
end)

menu.action(MISSION_ENTITY_perico, "前置：保险箱密码 传送到那里", {}, "赌场 保安队长\nModel Hash: -1109568186", function()
    local entity_model_hash = -1109568186
    for k, ent in pairs(entities.get_all_peds_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ent, 0.0, 0.0, 0.5)
            ENTITY.SET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_perico, "前置：等离子切割枪包裹 传送到我", {}, "\nModel Hash: -802406134", function()
    local entity_model_hash = -802406134
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 0.0, 2.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_perico, "前置：指纹复制器 传送到我", {}, "地下车库\nModel Hash: 1506325614", function()
    local entity_model_hash = 1506325614
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 0.0, 2.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_perico, "前置：割据 传送到那里", {}, "工地\nModel Hash: 1871441709", function()
    local entity_model_hash = 1871441709
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ent, 0.0, 0.0, 0.5)
            ENTITY.SET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_perico, "前置：武器 炸掉女武神", {}, "\nModel Hash: -1600252419", function()
    local entity_model_hash = -1600252419
    for k, ent in pairs(entities.get_all_vehicles_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local pos = ENTITY.GET_ENTITY_COORDS(ent)
            FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, EXP_TAG_STICKYBOMB, 3.0, true, false, 0, false)
        end
    end
end)

--- ---
local MISSION_ENTITY_casion = menu.list(MISSION_ENTITY, "赌场抢劫", {}, "")

menu.action(MISSION_ENTITY_casion, "前置：保安 传送到我", {}, "侦查前置\nModel Hash: -1094177627", function()
    local entity_model_hash = -1094177627
    for k, ent in pairs(entities.get_all_peds_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, 10.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
            --ENTITY.SET_ENTITY_HEALTH(ent, 0.0)

            local pHead = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())
            ENTITY.SET_ENTITY_HEADING(ent, pHead)
        end
    end
end)

menu.action(MISSION_ENTITY_casion, "前置：武器(车) 传送到我", {}, "国安局面包车 武器在防暴车内\nModel Hash: 1885839156", function()
    local entity_model_hash = 1885839156
    for k, ent in pairs(entities.get_all_objects_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            if ENTITY.IS_ENTITY_ATTACHED(ent) then
                local attached_ent = ENTITY.GET_ENTITY_ATTACHED_TO(ent)
                local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -1.0)
                ENTITY.SET_ENTITY_COORDS(attached_ent, coords.x, coords.y, coords.z, true, false, false, false)

                local pHead = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())
                ENTITY.SET_ENTITY_HEADING(attached_ent, pHead + 90.0)
            end
        end
    end
end)

menu.action(MISSION_ENTITY_casion, "前置：武器 传送到我", {}, "摩托车帮 长方形板条\nModel Hash: 798951501", function()
    local entity_model_hash = 798951501
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_casion, "前置：武器(飞机) 传送到我", {}, "走私犯 水上飞机\nModel Hash: 1043222410", function()
    --Model Hash: -1628917549 (PICKUP) 炸毁飞机掉落的货物
    local entity_model_hash = 1043222410
    for k, ent in pairs(entities.get_all_vehicles_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 5.0, -1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_casion, "前置：载具 传送到我", {}, "天威 经典版\nModel Hash: 931280609", function()
    local entity_model_hash = 931280609
    for k, ent in pairs(entities.get_all_vehicles_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)

            local pHead = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())
            ENTITY.SET_ENTITY_HEADING(attached_ent, pHead + 90.0)
        end
    end
end)

menu.action(MISSION_ENTITY_casion, "前置：骇入装置 传送到我", {}, "FIB大楼 电脑旁边 提箱\n或者 国安局总部 服务器或桌子旁边\nModel Hash: -155327337", function()
    local entity_model_hash = -155327337
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_casion, "前置：金库门禁卡(狱警) 传送到我", {}, "监狱巴士 监狱 狱警\nModel Hash: 1456041926", function()
    local entity_model_hash = 1456041926
    for k, ent in pairs(entities.get_all_peds_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_casion, "前置：巡逻路线(车) 传送到我", {}, "某辆车后备箱里的箱子\nModel Hash: 1265214509", function()
    local entity_model_hash = 1265214509
    for k, ent in pairs(entities.get_all_objects_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            if ENTITY.IS_ENTITY_ATTACHED(ent) then
                local attached_ent = ENTITY.GET_ENTITY_ATTACHED_TO(ent)
                local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 4.0, -1.0)
                ENTITY.SET_ENTITY_COORDS(attached_ent, coords.x, coords.y, coords.z, true, false, false, false)

                local pHead = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())
                ENTITY.SET_ENTITY_HEADING(attached_ent, pHead)
            end
        end
    end
end)

menu.action(MISSION_ENTITY_casion, "前置：杜根货物 全部爆炸", {}, "直升机 车 船\n一次性好像炸不完\nModel Hash: -1671539132 1747439474 1448677353", function()
    for k, ent in pairs(entities.get_all_vehicles_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
            if EntityHash == -1671539132 or EntityHash == 1747439474 or EntityHash == 1448677353 then
                local pos = ENTITY.GET_ENTITY_COORDS(ent)
                FIRE.ADD_EXPLOSION(pos.x, pos.y, pos.z, EXP_TAG_STICKYBOMB, 3.0, true, false, 0, false)
            end
        end
    end
end)

menu.action(MISSION_ENTITY_casion, "前置：电钻 传送到那里", {}, "工地 找箱子里的电钻\nModel Hash: -12990308", function()
    local entity_model_hash = -12990308
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ent, 0.0, 0.0, 0.5)
            ENTITY.SET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_casion, "前置：二级保安证(尸体) 传送到那里", {}, "灵车 医院 泊车员尸体\nModel Hash: 771433594", function()
    local entity_model_hash = 771433594
    for k, ent in pairs(entities.get_all_objects_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ent, 0.0, 0.0, 0.5)
            ENTITY.SET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.divider(MISSION_ENTITY_casion, "隐迹潜踪")

menu.action(MISSION_ENTITY_casion, "前置：无人机 传送到我", {}, "纳米无人机\nModel Hash: 1657647215", function()
    -- -1285013058 无人机炸毁后掉落的零件（pickup）
    local entity_model_hash = 1657647215
    for k, ent in pairs(entities.get_all_objects_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, 0.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_casion, "前置：金库激光器 传送到我", {}, "\nModel Hash: 1953119208", function()
    local entity_model_hash = 1953119208
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.divider(MISSION_ENTITY_casion, "兵不厌诈")

menu.action(MISSION_ENTITY_casion, "前置：古倍科技套装 传送到我", {}, "\nModel Hash: 1425667258", function()
    local entity_model_hash = 1425667258
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_casion, "前置：金库钻孔机 传送到我", {}, "全福银行\nModel Hash: 415149220", function()
    local entity_model_hash = 415149220
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_casion, "前置：国安局套装 传送到我", {}, "警察局\nModel Hash: -1713985235", function()
    local entity_model_hash = -1713985235
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.divider(MISSION_ENTITY_casion, "气势汹汹")

menu.action(MISSION_ENTITY_casion, "前置：热能炸药 传送到我", {}, "\nModel Hash: -2043162923", function()
    local entity_model_hash = -2043162923
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_casion, "前置：金库炸药 传送到我", {}, "要潜水下去 难找恶心\nModel Hash: -681938663", function()
    local entity_model_hash = -681938663
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -1.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_casion, "前置：加固防弹衣 传送到我", {}, "地堡 箱子\nModel Hash: 1715697304", function()
    local entity_model_hash = 1715697304
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, 0.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.divider(MISSION_ENTITY_casion, "")

menu.action(MISSION_ENTITY_casion, "赌场：小金库手推车 传送到我", {}, "\nModel Hash: 1736112330", function()
    local entity_model_hash = 1736112330
    for k, ent in pairs(entities.get_all_objects_as_handles()) do
        local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
        if EntityHash == entity_model_hash and ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -0.5)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
        end
    end
end)

menu.action(MISSION_ENTITY_casion, "赌场：获取金库内手推车数量", {}, "先获取手推车数量才能传送\nModel Hash: 412463629, 1171655821, 1401432049", function()
    -- 手推车 实体list
    vault_trolley = {}
    local num = 0
    for k, ent in pairs(entities.get_all_objects_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local EntityHash = ENTITY.GET_ENTITY_MODEL(ent)
            if EntityHash == 412463629 then
                num = num + 1
                table.insert(vault_trolley, ent)
            elseif EntityHash == 1171655821 then
                num = num + 1
                table.insert(vault_trolley, ent)
            elseif EntityHash == 1401432049 then
                num = num + 1
                table.insert(vault_trolley, ent)
            end
        end
    end
    util.toast("Number: " .. num)
    menu.set_max_value(menu_Vault_Trolley_TP, num)
end)

menu_Vault_Trolley_TP = menu.click_slider(MISSION_ENTITY_casion, "赌场：金库内手推车 传送到我", {}, "", 0, 0, 0, 1, function(value)
    if value > 0 then
        local ent = vault_trolley[value]
        if ENTITY.DOES_ENTITY_EXIST(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, 2.0, -0.5)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)

            local pHead = ENTITY.GET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID())
            ENTITY.SET_ENTITY_HEADING(ent, pHead + 180.0)
        else
            util.toast("实体不存在")
        end
    end
end)

-------- All Type Mission Entities --------
menu.divider(MISSION_ENTITY, "所有任务实体")

--- all entity type functions ---
function mission_entity_all(menu_parent, ent)
    menu.action(menu_parent, "检测该实体是否存在", {}, "", function()
        if ENTITY.DOES_ENTITY_EXIST(ent) then
            util.toast("实体存在")
        else
            util.toast("该实体已经不存在")
        end
    end)

    menu.toggle(menu_parent, "冻结实体", {}, "", function(toggle)
        ENTITY.FREEZE_ENTITY_POSITION(ent, toggle)
    end)

    menu.toggle_loop(menu_parent, "检测实体信息", {}, "", function(toggle)
        local modelHash = ENTITY.GET_ENTITY_MODEL(ent)
        local entity_info = "Hash: " .. modelHash .. "\nHealth: " .. ENTITY.GET_ENTITY_HEALTH(ent)

        local pos = ENTITY.GET_ENTITY_COORDS(ent)
        entity_info = entity_info .. "\nX : " .. pos.x .. "\nY : " .. pos.y .. "\nZ : " .. pos.z

        local my_pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
        entity_info = entity_info .. "\n距离: " .. vect.dist(my_pos, pos)

        directx.draw_text(0.5, 0.0, entity_info, ALIGN_TOP_LEFT, 0.7, 1, 0.8, 0, 1, true)
    end)

    menu.toggle(menu_parent, "添加地图标记 (Entity)", {}, "", function(toggle)
        if toggle then
            local blip = HUD.GET_BLIP_FROM_ENTITY(ent)
            if blip > 0 then
                HUD.SET_BLIP_DISPLAY(blip, 2)
            else
                blip = HUD.ADD_BLIP_FOR_ENTITY(ent)
                HUD.SET_BLIP_COLOUR(blip, 27)
                --
                if ENTITY.IS_ENTITY_A_PED(ent) then
                    if PED.IS_PED_IN_COMBAT(ent, players.user_ped()) then
                        HUD.SET_BLIP_COLOUR(blip, 1)
                    end
                end
                --
                if ENTITY.IS_ENTITY_A_VEHICLE(ent) then
                    local ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(ent, -1)
                    if ped then
                        if PED.IS_PED_IN_COMBAT(ped, players.user_ped()) then
                            HUD.SET_BLIP_COLOUR(blip, 1)
                        end
                    end
                end
            end
        else
            local blip = HUD.GET_BLIP_FROM_ENTITY(ent)
            if blip > 0 then
                HUD.SET_BLIP_DISPLAY(blip, 0)
            end
        end
    end)

    --menu.action(menu_parent, "添加地图标记 (Pickup)", {}, "", function()
    --    HUD.ADD_BLIP_FOR_PICKUP(ent)
    --end)
    --- ---
    menu.divider(menu_parent, "传送")
    menu.click_slider(menu_parent, "传送到我面前", {}, "", -10, 10, 2, 1, function(value)
        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0.0, value, 0.0)
        ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
    end)

    menu.action(menu_parent, "传送到实体", {}, "", function()
        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ent, 0.0, 0.0, 0.0)
        ENTITY.SET_ENTITY_COORDS(players.user_ped(), coords.x, coords.y, coords.z, true, false, false, false)
    end)
    --- ---
    menu.divider(menu_parent, "移动")
    menu.click_slider(menu_parent, "前/后移动", {}, "", -100, 100, 0, 1, function(value)
        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ent, 0.0, value, 0.0)
        ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
    end)

    menu.click_slider(menu_parent, "左/右移动", {}, "", -100, 100, 0, 1, function(value)
        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ent, value, 0.0, 0.0)
        ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
    end)

    menu.click_slider(menu_parent, "上/下移动", {}, "", -100, 100, 0, 1, function(value)
        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ent, 0.0, 0.0, value)
        ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
    end)

    menu.click_slider(menu_parent, "朝向", {}, "", -360, 360, 0, 10, function(value)
        local head = ENTITY.GET_ENTITY_HEADING(ent)
        ENTITY.SET_ENTITY_HEADING(ent, head + value)
    end)
end

----- NPC -----
local MISSION_ENTITY_all_npc = menu.list(MISSION_ENTITY, "所有任务NPC", {}, "")
menu.action(MISSION_ENTITY_all_npc, "所有任务NPC数量", {}, "", function()
    local mission_entity_num = 0
    for k, ent in pairs(entities.get_all_peds_as_handles()) do
        if not IS_PED_PLAYER(ent) and ent ~= PLAYER.PLAYER_PED_ID() then
            if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
                mission_entity_num = mission_entity_num + 1
            end
        end
    end
    util.toast("Number :" .. mission_entity_num)
end)

menu.click_slider(MISSION_ENTITY_all_npc, "所有传送到我面前", {}, "", -10, 10, 2, 1, function(value)
    for k, ent in pairs(entities.get_all_peds_as_handles()) do
        if not IS_PED_PLAYER(ent) and ent ~= PLAYER.PLAYER_PED_ID() then
            if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
                local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, value, 1.0)
                ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
                util.yield(1500) -- wait 1.5s
            end
        end
    end
end)

-- 所有任务实体
mission_ent_npc_list = {}
-- 所有任务实体的menu.list
mission_ent_npc_menu_list = {}

function Clear_mission_npc_list()
    for k, v in pairs(mission_ent_npc_menu_list) do
        if v ~= nil then
            menu.delete(v)
        end
    end
    -- 所有任务实体
    mission_ent_npc_list = {}
    -- 所有任务实体的menu.list
    mission_ent_npc_menu_list = {}
end

menu.action(MISSION_ENTITY_all_npc, "获取所有任务NPC列表", {}, "", function()
    Clear_mission_npc_list()
    for k, ent in pairs(entities.get_all_peds_as_handles()) do
        if not IS_PED_PLAYER(ent) and ent ~= PLAYER.PLAYER_PED_ID() then
            if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
                table.insert(mission_ent_npc_list, ent)
                local modelHash = ENTITY.GET_ENTITY_MODEL(ent)
                local entity_info = "Hash: " .. modelHash
                if PED.IS_PED_IN_COMBAT(ent, PLAYER.PLAYER_ID()) then
                    entity_info = entity_info .. " (敌对)"
                end
                local text = "index: " .. k
                ---
                menu_mission_entity_npc = menu.list(MISSION_ENTITY_all_npc, entity_info, {}, text)
                mission_entity_all(menu_mission_entity_npc, ent)
                table.insert(mission_ent_npc_menu_list, menu_mission_entity_npc)
            end
        end
    end
end)

menu.action(MISSION_ENTITY_all_npc, "清空列表", {}, "", function()
    Clear_mission_npc_list()
end)

menu.divider(MISSION_ENTITY_all_npc, "任务NPC列表")

----- VEHICLE -----
local MISSION_ENTITY_all_vehicle = menu.list(MISSION_ENTITY, "所有任务载具", {}, "")
menu.action(MISSION_ENTITY_all_vehicle, "所有任务载具数量", {}, "", function()
    local mission_entity_num = 0
    for k, ent in pairs(entities.get_all_vehicles_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            mission_entity_num = mission_entity_num + 1
        end
    end
    util.toast("Number :" .. mission_entity_num)
end)

menu.click_slider(MISSION_ENTITY_all_vehicle, "所有传送到我面前", {}, "", -10, 10, 2, 1, function(value)
    for k, ent in pairs(entities.get_all_vehicles_as_handles()) do
        if not IS_PED_PLAYER(ent) and ent ~= PLAYER.PLAYER_PED_ID() then
            if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
                local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, value, 0.0)
                ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
                util.yield(1500) -- wait 1.5s
            end
        end
    end
end)

-- 所有任务实体
mission_ent_vehicle_list = {}
-- 所有任务实体的menu.list
mission_ent_vehicle_menu_list = {}

function Clear_mission_vehicle_list()
    for k, v in pairs(mission_ent_vehicle_menu_list) do
        if v ~= nil then
            menu.delete(v)
        end
    end
    -- 所有任务实体
    mission_ent_vehicle_list = {}
    -- 所有任务实体的menu.list
    mission_ent_vehicle_menu_list = {}
end

menu.action(MISSION_ENTITY_all_vehicle, "获取所有任务载具列表", {}, "", function()
    Clear_mission_vehicle_list()
    for k, ent in pairs(entities.get_all_vehicles_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            table.insert(mission_ent_vehicle_list, ent)
            local modelHash = ENTITY.GET_ENTITY_MODEL(ent)
            local entity_info = "Hash: " .. modelHash
            local text = "index: " .. k
            ---
            menu_mission_entity_vehicle = menu.list(MISSION_ENTITY_all_vehicle, entity_info, {}, text)
            mission_entity_all(menu_mission_entity_vehicle, ent)
            table.insert(mission_ent_vehicle_menu_list, menu_mission_entity_vehicle)
        end
    end
end)

menu.action(MISSION_ENTITY_all_vehicle, "清空列表", {}, "", function()
    Clear_mission_vehicle_list()
end)

menu.divider(MISSION_ENTITY_all_vehicle, "任务载具列表")

----- OBJECT -----
local MISSION_ENTITY_all_object = menu.list(MISSION_ENTITY, "所有任务物体", {}, "")
menu.action(MISSION_ENTITY_all_object, "所有任务物体数量", {}, "", function()
    local mission_entity_num = 0
    for k, ent in pairs(entities.get_all_objects_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            mission_entity_num = mission_entity_num + 1
        end
    end
    util.toast("Number :" .. mission_entity_num)
end)

menu.click_slider(MISSION_ENTITY_all_object, "所有传送到我面前", {}, "", -10, 10, 2, 1, function(value)
    for k, ent in pairs(entities.get_all_objects_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, value, 0.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
            util.yield(1500) -- wait 1.5s
        end
    end
end)

-- 所有任务实体
mission_ent_object_list = {}
-- 所有任务实体的menu.list
mission_ent_object_menu_list = {}

function Clear_mission_object_list()
    for k, v in pairs(mission_ent_object_menu_list) do
        if v ~= nil then
            menu.delete(v)
        end
    end
    -- 所有任务实体
    mission_ent_object_list = {}
    -- 所有任务实体的menu.list
    mission_ent_object_menu_list = {}
end

menu.action(MISSION_ENTITY_all_object, "获取所有任务物体列表", {}, "", function()
    Clear_mission_object_list()
    for k, ent in pairs(entities.get_all_objects_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            table.insert(mission_ent_object_list, ent)
            local modelHash = ENTITY.GET_ENTITY_MODEL(ent)
            local entity_info = "Hash: " .. modelHash
            local text = "index: " .. k
            ---
            menu_mission_entity_object = menu.list(MISSION_ENTITY_all_object, entity_info, {}, text)
            mission_entity_all(menu_mission_entity_object, ent)
            table.insert(mission_ent_object_menu_list, menu_mission_entity_object)
        end
    end
end)

menu.action(MISSION_ENTITY_all_object, "清空列表", {}, "", function()
    Clear_mission_object_list()
end)

menu.divider(MISSION_ENTITY_all_object, "任务物体列表")

----- PICKUP -----
local MISSION_ENTITY_all_pickup = menu.list(MISSION_ENTITY, "所有任务拾取物", {}, "")
menu.action(MISSION_ENTITY_all_pickup, "所有任务拾取物数量", {}, "", function()
    local mission_entity_num = 0
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            mission_entity_num = mission_entity_num + 1
        end
    end
    util.toast("Number :" .. mission_entity_num)
end)

menu.click_slider(MISSION_ENTITY_all_pickup, "所有传送到我面前", {}, "", -10, 10, 2, 1, function(value)
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0.0, value, 0.0)
            ENTITY.SET_ENTITY_COORDS(ent, coords.x, coords.y, coords.z, true, false, false, false)
            util.yield(1500) -- wait 1.5s
        end
    end
end)

-- 所有任务实体
mission_ent_pickup_list = {}
-- 所有任务实体的menu.list
mission_ent_pickup_menu_list = {}

function Clear_mission_pickup_list()
    for k, v in pairs(mission_ent_pickup_menu_list) do
        if v ~= nil then
            menu.delete(v)
        end
    end
    -- 所有任务实体
    mission_ent_pickup_list = {}
    -- 所有任务实体的menu.list
    mission_ent_pickup_menu_list = {}
end

menu.action(MISSION_ENTITY_all_pickup, "获取所有任务拾取物列表", {}, "", function()
    Clear_mission_pickup_list()
    for k, ent in pairs(entities.get_all_pickups_as_handles()) do
        if ENTITY.IS_ENTITY_A_MISSION_ENTITY(ent) then
            table.insert(mission_ent_pickup_list, ent)
            local modelHash = ENTITY.GET_ENTITY_MODEL(ent)
            local entity_info = "Hash: " .. modelHash
            local text = "index: " .. k
            ---
            menu_mission_entity_pickup = menu.list(MISSION_ENTITY_all_pickup, entity_info, {}, text)
            mission_entity_all(menu_mission_entity_pickup, ent)
            table.insert(mission_ent_pickup_menu_list, menu_mission_entity_pickup)
        end
    end
end)

menu.action(MISSION_ENTITY_all_pickup, "清空列表", {}, "", function()
    Clear_mission_pickup_list()
end)

menu.divider(MISSION_ENTITY_all_pickup, "任务拾取物列表")

local function interpolate(y0, y1, perc)
	perc = perc > 1.0 and 1.0 or perc
	return (1 - perc) * y0 + perc * y1
end

local function get_health_colour(perc)
	local result = {a = 255}
	local r, g, b
	if perc <= 0.5 then
		r = 1.0
		g = interpolate(0.0, 1.0, perc/0.5)
		b = 0.0
	else
		r = interpolate(1.0, 0, (perc - 0.5)/0.5)
		g = 1.0
		b = 0.0
	end
	result.r = math.ceil(r * 255)
	result.g = math.ceil(g * 255)
	result.b = math.ceil(b * 255)
	return result
end

local function draw_marker(type, pos, dir, rot, scale, rotate, colour, txdDict, txdName)
    txdDict = txdDict or 0
    txdName = txdName or 0
    colour = colour or {r = 255, g = 255, b = 255, a = 255}
    GRAPHICS.DRAW_MARKER(type, pos.x, pos.y, pos.z, dir.x, dir.y, dir.z, rot.x, rot.y, rot.z, scale.x, scale.y, scale.z, colour.r, colour.g, colour.b, colour.a, false, true, 2, rotate, txdDict, txdName, false)
end

local function request_anim_set(set)
    while not STREAMING.HAS_ANIM_SET_LOADED(set) do
        STREAMING.REQUEST_ANIM_SET(set)
        util.yield()
    end
end


peds_root = menu.list(entity_options, "控制行人", {"controlpeds"}, "")

local all_sex_voicenames = {
    "S_F_Y_HOOKER_01_WHITE_FULL_01",
    "S_F_Y_HOOKER_01_WHITE_FULL_02",
    "S_F_Y_HOOKER_01_WHITE_FULL_03",
    "S_F_Y_HOOKER_02_WHITE_FULL_01",
    "S_F_Y_HOOKER_02_WHITE_FULL_02",
    "S_F_Y_HOOKER_02_WHITE_FULL_03",
    "S_F_Y_HOOKER_03_BLACK_FULL_01",
    "S_F_Y_HOOKER_03_BLACK_FULL_03",
}

local function get_distance_between_entities(entity, target)
	if not ENTITY.DOES_ENTITY_EXIST(entity) or not ENTITY.DOES_ENTITY_EXIST(target) then
		return 0.0
	end
	local pos = ENTITY.GET_ENTITY_COORDS(entity, true)
	return ENTITY.GET_ENTITY_COORDS(target, true):distance(pos)
end

peds_thread = util.create_thread(function (thr)
    while true do
        if ped_uses > 0 then
            
            all_peds = entities.get_all_peds_as_handles()
            for k,ped in pairs(all_peds) do
                
                if not PED.IS_PED_A_PLAYER(ped) then

                    if make_peds_cops then 
                        PED.SET_PED_AS_COP(ped, true)
                    end

                    if ped_no_ragdoll then 
                        PED.SET_PED_CAN_RAGDOLL(ped, false)
                    end

                    if ped_godmode then 
                        ENTITY.SET_ENTITY_INVINCIBLE(ped, true)
                    end

                    if hooker_esp then
                        local mdl = ENTITY.GET_ENTITY_MODEL(ped)
                        if PED.IS_PED_USING_SCENARIO(ped, "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS") or PED.IS_PED_USING_SCENARIO(ped,"WORLD_HUMAN_PROSTITUTE_LOW_CLASS") then 
                            util.draw_ar_beacon(ENTITY.GET_ENTITY_COORDS(ped))
                        end
                    end

                    if ped_no_crits then
                        PED.SET_PED_SUFFERS_CRITICAL_HITS(ped, false)
                    end

                    if ped_highperception then
                        PED.SET_PED_HIGHLY_PERCEPTIVE(ped, true)
                        PED.SET_PED_HEARING_RANGE(ped, 1000.0)
                        PED.SET_PED_SEEING_RANGE(ped, 1000.0)
                        PED.SET_PED_VISUAL_FIELD_MIN_ANGLE(ped, 1000.0)
                    end

                    if ped_allcops then
                        PED.SET_PED_AS_COP(ped, true)
                    end

                    if ped_theflash then
                        PED.SET_PED_MOVE_RATE_OVERRIDE(ped, 10.0)
                    end

                    if rain_peds then 
                        if not ENTITY.IS_ENTITY_IN_AIR(ped) then 
                            local ped_c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
                            ped_c.x = ped_c.x + math.random(-50, 50)
                            ped_c.y = ped_c.y + math.random(-50, 50)
                            ped_c.z = ped_c.z + math.random(50, 100)
                            ENTITY.SET_ENTITY_COORDS(ped, ped_c.x, ped_c.y, ped_c.z)
                            ENTITY.SET_ENTITY_VELOCITY(ped, 0.0, 0.0, -1.0)
                        end
                    end

                    if ped_hardened then
                        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true)
                        PED.SET_PED_FLEE_ATTRIBUTES(ped, 0, false)
                        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true)
                        PED.SET_PED_ACCURACY(ped, 100)
                        PED.SET_PED_COMBAT_ABILITY(ped, 3)
                    end

                    if peds_ignore then
                        if not PED.GET_PED_CONFIG_FLAG(ped, 17, true) then
                            PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, true)
                            TASK.TASK_SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(ped, true)
                        end
                    end
                    if wantthesmoke then 
                        PED.SET_PED_AS_ENEMY(ped, true)
                        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true)
                        PED.SET_PED_FLEE_ATTRIBUTES(ped, 0, false)
                        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true)
                        TASK.TASK_COMBAT_PED(ped, players.user_ped(), 0, 16)
                    end

                    if apose_peds then 
                        if PED.IS_PED_IN_ANY_VEHICLE(ped, true) then
                            TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
                        end
                        request_anim_set("move_crawl")
                        PED.SET_PED_MOVEMENT_CLIPSET(ped, "move_crawl", -1)
                    end

                    if roast_voicelines then
                        local roasts = {
                            "GENERIC_INSULT_MED",
                            "GENERIC_INSULT_HIGH"
                        }
                        AUDIO.PLAY_PED_AMBIENT_SPEECH_NATIVE(ped, roasts[math.random(#roasts)], "SPEECH_PARAMS_FORCE_SHOUTED")
                    end
    
                    if sex_voicelines then
                        local voice_name = all_sex_voicenames[math.random(1, #all_sex_voicenames)]
                        local speeches = {
                            "SEX_GENERIC_FEM",
                            "SEX_HJ",
                            "SEX_ORAL_FEM",
                            "SEX_CLIMAX",
                            "SEX_GENERIC"
                        }
                        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(ped, speeches[math.random(#speeches)], voice_name, "SPEECH_PARAMS_FORCE_SHOUTED", 0)
                    end
    
                    if screamall then
                        local screams = {
                            "SCREAM_SCARED",
                            "SCREAM_PANIC_SHORT",
                            "SCREAM_TERROR"

                        }
                        AUDIO.PLAY_PED_AMBIENT_SPEECH_NATIVE(ped, screams[math.random(#screams)], "SPEECH_PARAMS_FORCE_SHOUTED")
                    end

                    if php_bars and get_distance_between_entities(players.user_ped(), ped) < 100.0 and not PED.IS_PED_FATALLY_INJURED(ped) and ENTITY.IS_ENTITY_ON_SCREEN(ped) then
                        local headPos = PED.GET_PED_BONE_COORDS(ped, 0x322C --[[head]], 0.35, 0., 0.)
                        local perc = 0.0

                        if not PED.IS_PED_FATALLY_INJURED(ped) then
                            local maxHealth = PED.GET_PED_MAX_HEALTH(ped)
                            local health = ENTITY.GET_ENTITY_HEALTH(ped)
                            perc = (health - 100.0) / (maxHealth - 100.0)
                            if perc > 1.0 then perc = 1.0  end
                        end
                        
                        local colour = get_health_colour(perc)
                        local scale = v3.new(0.10, 0.0, interpolate(0.0, 0.7, perc))
                        draw_marker(43, headPos, v3(), v3(), scale, false, colour, 0, 0)
                    end

                    if allpeds_gun ~= 0 then
                        WEAPON.GIVE_WEAPON_TO_PED(ped, allpeds_gun, 9999, false, true)
                    end

                    -- ONLINE INTERACTIONS
                    if aped_combat then
                        local tar = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(combat_tar)
                        if not PED.IS_PED_IN_COMBAT(ped, tar) then 
                            PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true)
                            PED.SET_PED_FLEE_ATTRIBUTES(ped, 0, false)
                            PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true)
                            TASK.TASK_COMBAT_PED(ped, combat_tar, 0, 16)
                        end
                    end


                end
            end
        end
        util.yield()
    end
end)

local function get_model_size(hash)
    local minptr = memory.alloc(24)
    local maxptr = memory.alloc(24)
    MISC.GET_MODEL_DIMENSIONS(hash, minptr, maxptr)
    min = memory.read_vector3(minptr)
    max = memory.read_vector3(maxptr)
    local size = {}
    size['x'] = max['x'] - min['x']
    size['y'] = max['y'] - min['y']
    size['z'] = max['z'] - min['z']
    size['max'] = math.max(size['x'], size['y'], size['z'])

    memory.free(minptr)
    memory.free(maxptr)

    return size
end

-- PEDS
ped_b_root = menu.list(peds_root, "行为", {"pedbehavior"}, "")
ped_attributes_root = menu.list(peds_root, "属性", {"pedattributes"}, "")
ped_voice = menu.list(peds_root, "声音", {"pedaudio"}, "")
ped_spawn = menu.list(peds_root, "生成", {"pedspawn"}, "")

local function request_anim_dict(dict)
    while not STREAMING.HAS_ANIM_DICT_LOADED(dict) do
        STREAMING.REQUEST_ANIM_DICT(dict)
        util.yield()
    end
end

local function request_model_load(hash)
    request_time = os.time()
    if not STREAMING.IS_MODEL_VALID(hash) then
        return
    end
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do
        if os.time() - request_time >= 10 then
            break
        end
        util.yield()
    end
end

-- SPAWNING PEDS
num_peds_spawn = 1
local function spawn_ped(hash)
coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0.0, 3.0, 0.0)
local peds_spawned = {}
request_model_load(hash)
for i=1, num_peds_spawn do
    ped = entities.create_ped(28, hash, coords, math.random(0, 270))
    peds_spawned[#peds_spawned + 1] = ped
    if spawn_dancing then 
        local d = "anim@amb@nightclub_island@dancers@crowddance_facedj@hi_intensity"
        request_anim_dict(d)
        TASK.TASK_PLAY_ANIM(ped, d, "hi_dance_facedj_13_v2_male^5", 1.0, 1.0, -1, 3, 0.5, false, false, false)
        PED.SET_PED_KEEP_TASK(ped, true)
    end
    if is_pet then
        all_pets[#all_pets + 1] = ped
        ENTITY.SET_ENTITY_INVINCIBLE(ped, true)
        TASK.TASK_FOLLOW_TO_OFFSET_OF_ENTITY(ped, players.user_ped(), 0, -1, 0, 7.0, -1, 1, true)
        PED.SET_PED_COMBAT_ABILITY(ped, 3)
        PED.SET_PED_FLEE_ATTRIBUTES(ped, 0, false)
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true)
        local blip = HUD.ADD_BLIP_FOR_ENTITY(ped)
        HUD.SET_BLIP_COLOUR(blip, 11)
    end
end
return peds_spawned
end


all_pets = {}
local function spawn_pet(hash)
request_model_load(hash)
local c = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
local pet = entities.create_ped(28, hash, c, 0)
all_pets[#all_pets + 1] = pet
ENTITY.SET_ENTITY_INVINCIBLE(pet, true)
PED.SET_PED_COMPONENT_VARIATION(pet, 0, 0, 2, 0)
TASK.TASK_FOLLOW_TO_OFFSET_OF_ENTITY(pet, players.user_ped(), 0, -1, 0, 7.0, -1, 1, true)
PED.SET_PED_COMBAT_ABILITY(pet, 0)
PED.SET_PED_FLEE_ATTRIBUTES(pet, 0, true)
PED.SET_PED_COMBAT_ATTRIBUTES(pet, 46, false)
local blip = HUD.ADD_BLIP_FOR_ENTITY(pet)
HUD.SET_BLIP_COLOUR(blip, 11)
end

local custom_animal = "a_c_retriever"
menu.text_input(ped_spawn, "自定义行人输入", {"customped"}, "输入要生成的自定义行人。模型英文名,而不是哈希值", function(on_input)
custom_animal = on_input
end, "a_c_retriever")


local animal_hashes = {1302784073, -1011537562, 802685111, util.joaat("a_c_chimp"), -1589092019, 1794449327, -664053099, -1920284487, util.joaat("a_c_retriever"), util.joaat('a_c_cow'), util.joaat("a_c_rabbit_01")}
local animal_options = {"莱斯特", "老鼠", "鱼", "黑猩猩", "黄貂鱼", "母鸡", "鹿", "虎鲸", "狗", "奶牛", "兔子", "自定义"}
menu.list_action(ped_spawn, "生成行人", {"spawnped"}, "", animal_options, function(index, value, click_type)
if value == "自定义" then
    spawn_ped(util.joaat(custom_animal))
else
    spawn_ped(animal_hashes[index])
end
end)

menu.slider(ped_spawn, "生成数量", {"pedspawnct"}, "明智地选择", 1, 10, 1, 1, function(s)
num_peds_spawn = s
end)


is_pet = false
menu.toggle(ped_spawn, "作为宠物生成", {"spawnaspet"}, "将此行人作为宠物生成.", function(on)
is_pet = on
end)

spawn_dancing = false
menu.toggle(ped_spawn, "生成舞蹈中的", {"spawndancing"}, "产生舞蹈中的行人", function(on)
spawn_dancing = on
end)

local good_guns = {0, 453432689, 171789620, 487013001, -1716189206, 1119849093}
allpeds_gun = 0
local gun_options = {"没有", "手枪", "战斗自卫冲锋枪", "霰弹枪", "刀", "加特林"}
menu.list_action(peds_root, "给所有行人枪", {"giveallpeds"}, "", gun_options, function(index, value, click_type)
if index == 1 then
    allpeds_gun = 0
else
    allpeds_gun = good_guns[index]
end
end)

menu.action(peds_root, "传送所有到我", {"tpallpedshere"}, "", function(click_type)
local c = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
all_peds = entities.get_all_peds_as_handles()
for k,ped in pairs(all_peds) do
    if not PED.IS_PED_A_PLAYER(ped) then
        if PED.IS_PED_IN_ANY_VEHICLE(ped, true) then
            TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
            TASK.TASK_LEAVE_ANY_VEHICLE(ped, 0, 16)
        end
        ENTITY.SET_ENTITY_COORDS(ped, c.x, c.y, c.z)
    end
end
end)

menu.action(peds_root, "堆叠所有行人", {"stackallpeds"}, "", function(click_type)
local c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
all_peds = entities.get_all_peds_as_handles()
local last_ped = 0
local last_ped_ht = 0
notification("请稍候…", colors.blue)
for k,ped in pairs(all_peds) do
    if not PED.IS_PED_A_PLAYER(ped) and not PED.IS_PED_FATALLY_INJURED(ped) then
        request_control_of_entity(ped)
        if PED.IS_PED_IN_ANY_VEHICLE(ped, true) then
            TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
            TASK.TASK_LEAVE_ANY_VEHICLE(ped, 0, 16)
        end

        ENTITY.DETACH_ENTITY(ped, false, false)
        if last_ped ~= 0 then
            ENTITY.ATTACH_ENTITY_TO_ENTITY(ped, last_ped, 0, 0.0, 0.0, last_ped_ht-0.5, 0.0, 0.0, 0.0, false, false, false, false, 0, false)
        else
            ENTITY.SET_ENTITY_COORDS(ped, c.x, c.y, c.z)
        end
        last_ped = ped
        last_ped_ht = get_model_size(ENTITY.GET_ENTITY_MODEL(ped)).z
    end
end
end)

hooker_esp = false
menu.toggle(peds_root, "妓女透视", {"hookeresp"}, "...", function(on)
hooker_esp = on
mod_uses("ped", if on then 1 else -1)
end)



local function task_handler(type)
all_peds = entities.get_all_peds_as_handles()
player_ped = PLAYER.PLAYER_PED_ID()
for k,ped in pairs(all_peds) do
    if not PED.IS_PED_A_PLAYER(ped) then
        pluto_switch type do
            case "Flop":
                TASK.TASK_SKY_DIVE(ped)
                break
            case "Cover":
                TASK.TASK_STAY_IN_COVER(ped)
                break
            case "Writhe":
                TASK.TASK_WRITHE(ped, player_ped, -1, 0)
                break
            case "Vault":
                TASK.TASK_CLIMB(ped, true)
                break
            case "Cower":
                TASK.TASK_COWER(ped, -1)
                break
            case "Clear":
                TASK.CLEAR_PED_TASKS(ped)
                break
        end
    end
end
end

ped_no_ragdoll = false
menu.toggle(ped_attributes_root, "无布娃娃", {"nopedragdoll"}, "", function(on)
ped_no_ragdoll = on 
mod_uses("ped", if on then 1 else -1)
end)

ped_godmode = false
menu.toggle(ped_attributes_root, "无敌", {"pedgodmode"}, "", function(on)
ped_godmode = on 
mod_uses("ped", if on then 1 else -1)
end)

ped_no_crits = false
menu.toggle(ped_attributes_root, "没有暴击", {"nopedcrits"}, "", function(on)
ped_no_crits = on 
mod_uses("ped", if on then 1 else -1)
end)

ped_highperception = false
menu.toggle(ped_attributes_root, "高感知", {"pedhighperception"}, "行人会比平时看到和听到更多。", function(on)
ped_highperception = on 
mod_uses("ped", if on then 1 else -1)
end)

ped_allcops = false
menu.toggle(ped_attributes_root, "让所有行人成为警察", {"pedallcops"}, "", function(on)
ped_allcops = on 
mod_uses("ped", if on then 1 else -1)
end)

ped_theflash = false
menu.toggle(ped_attributes_root, "兔八哥", {"looney_tunes"}, "行人移动速度超快.", function(on)
ped_theflash = on 
mod_uses("ped", if on then 1 else -1)
end)

ped_hardened = false
menu.toggle(ped_attributes_root, "久经沙场的", {"pedhardened"}, "行人不再是懦夫,他们将战斗而不是逃跑。它们也更加精确和有战斗力。", function(on)
ped_hardened = on 
mod_uses("ped", if on then 1 else -1)
end)



local task_dict = {"flop", "cover", "vault"}
local task_options = {"猛然躺下", "掩护", "跳跃", "畏缩", "扭动", "净空",}
menu.list_action(peds_root, "给所有人任务", {"taskped"}, "", task_options, function(index, value, click_type)
task_handler(value)
end)

peds_ignore = false
menu.toggle(ped_b_root, "健忘的行人", {"obliviouspeds"}, "行人不会在乎你做什么。已经对你做出反应的行人不会忘记你做了什么。", function(on)
peds_ignore = on
mod_uses("ped", if on then 1 else -1)
end)

wantthesmoke = false
menu.toggle(ped_b_root, "行人攻击我", {"iwantthesmoke"}, "告诉附近所有的行人你想要来点烟火。可能会弄坏一些东西。", function(on)
wantthesmoke = on
mod_uses("ped", if on then 1 else -1)
end)

make_peds_cops = false
menu.toggle(ped_b_root, "使附近的行人变为警察", {"makecops"}, "他们实际上不是真正的警察,但会举报犯罪。近似", function(on)
make_peds_cops = on
mod_uses("ped", if on then 1 else -1)
end)

menu.toggle(ped_b_root, "底特律", {"detroit"}, "附近的所有NPC都开始互相决斗,并获得了武器。最近的事态发展表明,这个笑话被认为是不敏感的,这很有趣,因为在推特上大喊大叫比试图解决底特律的犯罪问题花费了更多的精力。", function(on)
MISC.SET_RIOT_MODE_ENABLED(on)
end)

apose_peds = false
menu.toggle(ped_b_root, "A-姿势", {"aposepeds"}, "哦！狗屎！", function(on)
apose_peds = on
mod_uses("ped", if on then 1 else -1)
end)

roast_voicelines = false
menu.toggle(ped_voice, "严厉的声线", {"npcroasts"}, "非常不道德。", function(on)
roast_voicelines = on
mod_uses("ped", if on then 1 else -1)
end)

sex_voicelines = false
menu.toggle(ped_voice, "性感的声线", {"sexlines"}, "oH FuCK YeAh", function(on)
sex_voicelines = on
mod_uses("ped", if on then 1 else -1)
end)

screamall = false
menu.toggle(ped_voice, "尖叫", {"screamall"}, "让附近所有的行人惨叫。令人惊叹的", function(on)
screamall = on
mod_uses("ped", if on then 1 else -1)
end)

vehicles_root = menu.list(entity_options, "控制载具", {"controlvehicle"}, "")

-- VEHICLES

v_phys_root = menu.list(vehicles_root, "载具物理", {"vphysics"}, "控制载具物理")
vc_root = menu.list(v_phys_root, "载具混乱", {"chaos"}, "审判日")
v_traffic_root = menu.list(vehicles_root, "载具交通", {"traffic"}, "控制载具交通")

local function get_closest_vehicle(entity)
    local coords = ENTITY.GET_ENTITY_COORDS(entity, true)
    local vehicles = entities.get_all_vehicles_as_handles()
    local closestdist = 1000000
    local closestveh = 0
    for k, veh in pairs(vehicles) do
        if veh ~= PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false) then
            local vehcoord = ENTITY.GET_ENTITY_COORDS(veh, true)
            local dist = MISC.GET_DISTANCE_BETWEEN_COORDS(coords['x'], coords['y'], coords['z'], vehcoord['x'], vehcoord['y'], vehcoord['z'], true)
            if dist < closestdist then
                closestdist = dist
                closestveh = veh
            end
        end
    end
    return closestveh
end

menu.action(vehicles_root, "传送到最近的载具", {"closestvehicle"}, "传送到最近的载具(不包括任何您可能已经在其中的载具)。请注意,附近的“载具”可能只是低模贴图,而不是实际的载具。", function(on_click)
    local closestveh = get_closest_vehicle(players.user_ped())
    local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(closestveh, -1)
    if VEHICLE.IS_VEHICLE_SEAT_FREE(closestveh, -1) then
        PED.SET_PED_INTO_VEHICLE(players.user_ped(), closestveh, -1)
    else
        if not PED.IS_PED_A_PLAYER(driver) then
            entities.delete_by_handle(driver)
            PED.SET_PED_INTO_VEHICLE(players.user_ped(), closestveh, -1)
        elseif VEHICLE.ARE_ANY_VEHICLE_SEATS_FREE(closestveh) then
            for i=0, 10 do
                if VEHICLE.IS_VEHICLE_SEAT_FREE(closestveh, i) then
                    PED.SET_PED_INTO_VEHICLE(players.user_ped(), closestveh, i)
                end
            end
        else
            notification("附近没有找到可用座位的载具:(", colors.blue)
        end
    end
end)

vehicle_chaos = false
menu.toggle(vc_root, "载具混乱", {"chaos"}, "", function(on)
    vehicle_chaos = on
    mod_uses("vehicle", if on then 1 else -1)
end)

vc_gravity = true
menu.toggle(vc_root, "载具混沌引力", {"chaosgravity"}, "重力开/关", function(on)
    vc_gravity = on
end, true)

vc_speed = 100
menu.slider(vc_root, "载具混沌速度", {"chaosspeed"}, "迫使载具行驶的速度。越高=越混乱。", 30, 300, 100, 10, function(s)
  vc_speed = s
end)

vhp_bars = false
menu.toggle(vehicles_root, "载具血量条", {"vehhpbars"}, "在载具上面绘制血量条。", function(on)
    vhp_bars = on
    mod_uses("vehicle", if on then 1 else -1)
    if php_bars and on then
        notification("警告:您同时打开了NPC血量条!由于引擎限制,某些条形图可能不会出现。", colors.blue)
    end
end)

ascend_vehicles = false
menu.toggle(v_phys_root, "升高附近所有载具", {"ascendvehicles"}, "它应该能使它们整齐地漂浮起来,但它只是让它们在半空中旋转。真他妈的好笑。", function(on)
    ascend_vehicles = on
    mod_uses("vehicle", if on then 1 else -1)
end)

rain_vehicles = false
menu.toggle(v_phys_root, "载具雨", {"rainvehicles"}, "", function(on)
    rain_vehicles = on
    mod_uses("vehicle", if on then 1 else -1)
end)

inferno = false
menu.toggle(v_phys_root, "地狱火", {"inferno"}, "过度破坏性的“炸毁所有车辆”选项。将继续炸毁所有车辆,即使它们已经被摧毁,为了让你有经典的挂壁体验。", function(on)
    inferno = on
    mod_uses("vehicle", if on then 1 else -1)
end, false)

blackhole = false
menu.toggle(v_phys_root, "载具黑洞", {"blackhole"}, "一个超级迟缓但有趣的黑洞。", function(on)
    blackhole = on
    mod_uses("vehicle", if on then 1 else -1)
    if on then
        holecoords = players.get_position(players.user())
        notification("黑洞位置被设置为比你的位置高50个单位。打开和关闭此选项以更改位置。", colors.blue)
    end
end)

hole_zoff = 50
menu.slider(v_phys_root, "黑洞Z轴偏移", {"blackholeoffset"}, "在你上方多远的地方放置黑洞。建议将其保持在相当高的水平。", 0, 100, 50, 10, function(s)
    hole_zoff = s
  end)


beep_cars = false
menu.toggle(vehicles_root, "附近所有载具无限鸣笛", {"beepvehicles"}, "使附近所有载具发出无限哔哔。可能无法在线工作。", function(on)
    beep_cars = on
    mod_uses("vehicle", if on then 1 else -1)
end)

yeetsubmarines = false
menu.toggle(vehicles_root, "弹飞潜艇", {"yeetsubs"},  "", function(on)
    yeetsubmarines = on
    mod_uses("vehicle", if on then 1 else -1)
end)

menu.action(vehicles_root, "传送所有载具到我", {"tpallvehshere"}, "", function(click_type)
    local c = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
    all_vehs = entities.get_all_vehicles_as_handles()
    for k,veh in pairs(all_vehs) do
        if not PED.IS_PED_A_PLAYER(VEHICLE.GET_PED_IN_VEHICLE_SEAT(veh, -1, false)) then
            ENTITY.SET_ENTITY_COORDS(veh, c.x, c.y, c.z)
        end
    end
end)


halt_traffic = false
menu.toggle(v_traffic_root, "停止交通", {"halttraffic"}, "阻止附近所有载具移动分毫。", function(on)
    halt_traffic = on
    mod_uses("vehicle", if on then 1 else -1)
end)

reverse_traffic = false
menu.toggle(v_traffic_root, "反向交通", {"reversetraffic"}, "", function(on)
    reverse_traffic = on
    mod_uses("vehicle", if on then 1 else -1)
end)

vehicles_thread = util.create_thread(function (thr)
    while true do
        if vehicle_uses > 0 then
            
            all_vehicles = entities.get_all_vehicles_as_handles()
            for k,veh in pairs(all_vehicles) do
                if l_e_v_on then
                    local size = get_model_size(ENTITY.GET_ENTITY_MODEL(veh))
                    if size.x > l_e_max_x or size.y > l_e_max_y or size.z > l_e_max_y then
                        entities.delete_by_handle(veh)
                    end
                end

                if vhp_bars and get_distance_between_entities(players.user_ped(), veh) < 200.0 and not ENTITY.IS_ENTITY_DEAD(veh, false) and ENTITY.IS_ENTITY_ON_SCREEN(veh) then
                    local modelHash = ENTITY.GET_ENTITY_MODEL(veh)
                    local min, max = v3.new(), v3.new()
                    MISC.GET_MODEL_DIMENSIONS(modelHash, min, max)
                    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(veh, 0.0, 0.0, max.z + 0.3)
                    local perc = 0.0

                    if not ENTITY.IS_ENTITY_DEAD(veh, false) then
                        local maxHealth = ENTITY.GET_ENTITY_MAX_HEALTH(veh)
                        local health = ENTITY.GET_ENTITY_HEALTH(veh)
                        perc = health / maxHealth
                        if perc > 1.0 then perc = 1.0  end
                    end
                    
                    local colour = get_health_colour(perc)
                    local scale = v3.new(0.10, 0.0, interpolate(0.0, 0.7, perc))
                    draw_marker(43, pos, v3(), v3(), scale, false, colour, 0, 0)
                end

                local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(veh, -1)
                if player_cur_car ~= veh and (not PED.IS_PED_A_PLAYER(driver)) or driver == 0 then
                    
                    if yeetsubmarines then
                        if VEHICLE.IS_VEHICLE_MODEL(veh, util.joaat("kosatka")) and ENTITY.IS_ENTITY_IN_WATER(veh) then
                            request_control_of_entity_once(veh)
                            ENTITY.SET_ENTITY_MAX_SPEED(veh, 10000)
                            ENTITY.APPLY_FORCE_TO_ENTITY(veh, 1,  0.0, 0.0, 10000, 0, 0, 0, 0, true, false, true, false, true)
                        end 
                    end

                    if inferno then
                        local coords = ENTITY.GET_ENTITY_COORDS(veh, true)
                        FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], 7, 100.0, true, false, 1.0)
                    end

                    if beep_cars then
                        if not AUDIO.IS_HORN_ACTIVE(veh) then
                            VEHICLE.START_VEHICLE_HORN(veh, 200, util.joaat("HELDDOWN"), true)
                        end
                    end

                    if blackhole then
                        if bh_target ~= -1 then
                            holecoords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(bh_target), true)
                        end
                        vcoords = ENTITY.GET_ENTITY_COORDS(veh, true)
                        speed = 100
                        local x_vec = (holecoords['x']-vcoords['x'])*speed
                        local y_vec = (holecoords['y']-vcoords['y'])*speed
                        local z_vec = ((holecoords['z']+hole_zoff)-vcoords['z'])*speed
                        -- dumpster fire if this goes wrong lol
                        ENTITY.SET_ENTITY_INVINCIBLE(veh, true)
                        --losioVEHICLE.SET_VEHICLE_GRAVITY(veh, false)
                        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(veh, 1, x_vec, y_vec, z_vec, true, false, true, true)
                    end

                    if vehicle_chaos then
                        VEHICLE.SET_VEHICLE_OUT_OF_CONTROL(veh, false, true)
                        VEHICLE.SET_VEHICLE_FORWARD_SPEED(veh, vc_speed)
                        VEHICLE.SET_VEHICLE_GRAVITY(veh, vc_gravity)
                    end
                
                    if halt_traffic then
                        VEHICLE.BRING_VEHICLE_TO_HALT(veh, 0.0, -1, true)
                        coords = ENTITY.GET_ENTITY_COORDS(veh, false)
                    end

                    if ascend_vehicles then
                        VEHICLE.SET_VEHICLE_UNDRIVEABLE(veh, true)
                        VEHICLE.SET_VEHICLE_GRAVITY(veh, false)
                        ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(veh, 4, 5.0, 0.0, 0.0, true, true, true, true)
                    end

                    if rain_vehicles then 
                        if not ENTITY.IS_ENTITY_IN_AIR(veh) then 
                            local ped_c = ENTITY.GET_ENTITY_COORDS(players.user_ped())
                            ped_c.x = ped_c.x + math.random(-50, 50)
                            ped_c.y = ped_c.y + math.random(-50, 50)
                            ped_c.z = ped_c.z + math.random(100, 120)
                            ENTITY.SET_ENTITY_COORDS(veh, ped_c.x, ped_c.y, ped_c.z)
                        end
                    end

                    if reverse_traffic then
                        ped = VEHICLE.GET_PED_IN_VEHICLE_SEAT(veh, -1)
                        TASK.TASK_VEHICLE_TEMP_ACTION(ped, veh, 3, -1)
                    end
                end
            end
        end
        util.yield()
    end
end)
