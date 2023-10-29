local debugmode = false
local synctimer = {}
local settings = {
    auto = {
        cleanup = false,
        interval = 10000,
        highlimit = 24,
        modellimit = 48,
        totallimit = 128,
        timeout = 30000,
    },
    bigvehicle = {
        excludeplayer = true,
        cleanup = false,
        limit = 5,
        radius = 250,
        timeout = 15000,
    },
    vehicle = {
        excludeplayer = true,
        cleanup = false,
        interval = 5000,
        limit = 10,
        radius = 25,
        timeout = 15000,
    },
    object = {
        cleanup = false,
        interval = 5000,
        limit = 10,
        radius = 25,
        timeout = 15000,
    },
    ped = {
        cleanup = false,
        interval = 2000,
        limit = 10,
        radius = 25,
        timeout = 15000,
    },
}
local whitelist = {
    auto = {
        logged = {},
    },
    bigvehicle = {
        logged = {},
        owner = {},
    },
    vehicle = {
        timer = {},
        owner = {},
    },
    object = {
        timer = {},
        owner = {},
    },
    ped = {
        timer = {},
        owner = {},
    },
}
local bigvehiclenames = {"titan", "bombushka", "volatol", "alkonost", "kosatka", "avenger", "avenger2", "jet", "cargoplane", "blimp", "blimp2", "blimp3", "bus", "pbus", "pbus2", "nimbus", "airbus", "rentalbus", "tourbus", "tug", "tr", "tr2", "tr3", "tr4", "freight", "freightcar", "freightcar2", "freightcont1", "freighttrailer", "freightcont2", "freightgrain"}
local bigvehicle = {}

for i, Model in ipairs(bigvehiclenames) do
    bigvehicle[util.joaat(Model)] = Model
end

local allentities = {lastupdate = 0}
local allpeds2 = {lastupdate = 0}
local allvehicles2 = {lastupdate = 0}

local function notification(body, ...)
    util.toast(body, ...)
    if debugmode then
        util.log(body)
    end
end
local function does_entity_from_pointer_exist(addr)
    if allentities.lastupdate < util.current_time_millis() then
        allentities = {lastupdate = util.current_time_millis()}
        for i, Pointer in entities.get_all_vehicles_as_pointers() do
            allentities[Pointer] = true
        end
        for i, Pointer in entities.get_all_peds_as_pointers() do
            allentities[Pointer] = true
        end
        for i, Pointer in entities.get_all_pickups_as_pointers() do
            allentities[Pointer] = true
        end
        for i, Pointer in entities.get_all_objects_as_pointers() do
            allentities[Pointer] = true
        end
    end
    return allentities[addr] or false
end
local function is_pointer_a_player(addr)
    if allpeds2.lastupdate < util.current_time_millis() then
        allpeds2 = {lastupdate = util.current_time_millis()}
        for i, Pointer in entities.get_all_peds_as_pointers() do
            allpeds2[Pointer] = true
        end
    end
    return allpeds2[addr] and entities.get_player_info(addr) ~= 0
end
local function is_pointer_a_player_vehicle(addr)
    if allvehicles2.lastupdate < util.current_time_millis() then
        allvehicles2 = {lastupdate = util.current_time_millis()}
        for i, Pointer in entities.get_all_vehicles_as_pointers() do
            allvehicles2[Pointer] = true
        end
    end
    if debugmode and allvehicles2[addr] and entities.get_vehicle_has_been_owned_by_player(addr) then
        util.toast("检测到玩家车辆")
    end
    return allvehicles2[addr] and entities.get_vehicle_has_been_owned_by_player(addr)
end
local function is_mission_entity(addr)
    local NetObj = memory.read_long(addr + 0xD0)
    return ((NetObj and NetObj ~= 0) and (memory.read_ubyte(NetObj + 0x4E) ~= 0))
end
local function set_as_mission_entity(addr, toggle)
    local NetObj = memory.read_long(addr + 0xD0)
    if (NetObj and NetObj ~= 0) then
        if toggle and memory.read_ubyte(NetObj + 0x4E) == 0 then
            memory.write_ubyte(NetObj + 0x4E, 4)
            return true
        elseif memory.read_ubyte(NetObj + 0x4E) ~= 0 then
            memory.write_ubyte(NetObj + 0x4E, 0)
            return true
        end
    elseif debugmode then
        util.log("没有对象 "..tostring(addr))
    end
    if debugmode then
        util.log("未对进行任何更改 "..tostring(addr))
    end
    return false
end
local function delete(addr)
    if not is_pointer_a_player(addr) then
        if debugmode then
            set_as_mission_entity(addr, false)
        end
        entities.delete_by_pointer(addr)
    end
end
local function merge_table(noduplicates, ...)
    local tbl = {...}
    local out = (noduplicates and {} or tbl[1])
    for i = 1, #tbl do
        for n = 1, #tbl[i] do
            out[#out + 1] = tbl[i][n]
        end
    end
    return out
end
local function table_entry_counts(tbl)
    local counts = {}
    for k, v in pairs(tbl) do
        local entry = tbl[k]
        counts[entry] = (counts[entry] or 0) + 1
    end
    return counts
end
local function get_highest_count(tbl)
    local counts = table_entry_counts(tbl)
    local count = 0
    local value = -1
    for k, v in pairs(counts) do
        if v > count then
            count = v
            value = k
        end
    end
    return value, count
end
local function get_entity_owner(addr)
    if type(addr) == "table" then
        local owners = {}
        for k, v in pairs(addr) do
            owners[#owners + 1] = get_entity_owner(v)
        end
        return get_highest_count(owners)
    else
        if util.is_session_started() and not util.is_session_transition_active() then
            local NetObj = memory.read_long(addr + 0xD0)
            if NetObj and NetObj ~= 0 then
                return memory.read_byte(NetObj + 0x49)
            end
            return -1
        end
        return players.user()
    end
end

for i = 0, 31 do
    whitelist.auto[i] = {}
    whitelist.auto[i].owner = {}
    whitelist.auto[i].timer = {}
    whitelist.auto[i].current = {}
    whitelist.auto[i].models = {}
    whitelist.auto[i].highpriority = {
        total = 0,
    }
    synctimer[i] = 0
    util.create_thread(function()
        local pid = i
        while true do
            if players.exists(pid) then
                if debugmode then
                    local owned = 0
                    local allents = merge_table(true, entities.get_all_vehicles_as_pointers(), entities.get_all_peds_as_pointers(), entities.get_all_pickups_as_pointers(), entities.get_all_objects_as_pointers())
                    local exists = 0
                    for n, addr in ipairs(allents) do
                        if get_entity_owner(addr) == pid then
                            owned = owned + 1
                        end
                        if does_entity_from_pointer_exist(addr) then
                            exists = exists + 1
                        end
                    end
                    if owned > 1 then
                        util.draw_debug_text(players.get_name(pid).." - "..#whitelist.auto[i].owner.."/"..owned)
                    end
                    if exists ~= #allents then
                        notification(exists.."/"..#allents)
                    end
                end
                if pid ~= players.user() and synctimer[pid] > util.current_time_millis() then
                    local Sync = menu.ref_by_rel_path(menu.player_root(pid), "传入同步>阻止")
                    menu.trigger_command(Sync, "on")
                    while synctimer[pid] > util.current_time_millis() and players.exists(pid) do
                        util.yield()
                    end
                    util.toast(players.get_name(pid).." 不再处于超时状态", TOAST_ALL)
                    menu.trigger_command(Sync, "off")
                end
            end
            util.yield()
        end
    end, nil)
end

local autothrottler = menu.list(throttler, "自动节流", {}, "")

menu.toggle_loop(autothrottler, "开启", {}, "", function()
    local allents = merge_table(false, entities.get_all_vehicles_as_pointers(), entities.get_all_peds_as_pointers(), entities.get_all_pickups_as_pointers(), entities.get_all_objects_as_pointers())
    for i, Pointer in ipairs(allents) do
        local owner = get_entity_owner(Pointer)
        if not whitelist.auto.logged[Pointer] then
            whitelist.auto.logged[Pointer] = true
            if owner ~= -1 and players.exists(owner) and owner ~= players.user() then
                whitelist.auto[owner].owner[#whitelist.auto[owner].owner+1] = Pointer
                whitelist.auto[owner].current[#whitelist.auto[owner].current+1] = Pointer
                whitelist.auto[owner].timer[Pointer] = util.current_time_millis()
                local model = entities.get_model_hash(Pointer)
                whitelist.auto[owner].models[model] = (whitelist.auto[owner].models[model] or 0) + 1
                if is_mission_entity(Pointer) then
                    whitelist.auto[owner].highpriority[Pointer] = true
                    whitelist.auto[owner].highpriority.total = (whitelist.auto[owner].highpriority.total or 0) + 1
                end
                if synctimer[owner] > util.current_time_millis() then
                    delete(Pointer)
                end
            end
        end
    end
    for i = 0, 31 do
        if players.exists(i) then
            local existing = {}
            local existing2 = {}
            for n, Pointer in ipairs(whitelist.auto[i].current) do
                if does_entity_from_pointer_exist(Pointer) and whitelist.auto[i].timer[Pointer] + settings.auto.interval > util.current_time_millis() then
                    existing[#existing+1] = Pointer
                else
                    local model = entities.get_model_hash(Pointer)
                    whitelist.auto[i].models[model] = (whitelist.auto[i].models[model] or 1) - 1
                    if whitelist.auto[i].highpriority[Pointer] then
                        whitelist.auto[i].highpriority[Pointer] = nil
                        whitelist.auto[i].highpriority.total = whitelist.auto[i].highpriority.total - 1
                    end
                    whitelist.auto[i].current[n] = nil
                    whitelist.auto[i].timer[Pointer] = nil
                end
            end
            for n, Pointer in ipairs(whitelist.auto[i].owner) do
                if does_entity_from_pointer_exist(Pointer) then
                    existing2[#existing2+1] = Pointer
                else
                    whitelist.auto[i].owner[n] = nil
                end
            end
            whitelist.auto[i].current = existing
            whitelist.auto[i].owner = existing2
            if #whitelist.auto[i].current > settings.auto.totallimit then
                notification("[T] 限制来自的实体 "..players.get_name(i), TOAST_ALL)
                if util.current_time_millis() + settings.auto.timeout > synctimer[i] then
                    synctimer[i] = util.current_time_millis() + settings.auto.timeout
                end
                if settings.auto.cleanup then
                    for n, Pointer in ipairs(whitelist.auto[i].owner) do
                        if does_entity_from_pointer_exist(Pointer) then
                            whitelist.auto[i].timer[Pointer] = util.current_time_millis()
                            delete(Pointer)
                        end
                    end
                end
            end
            for Model, Num in pairs(whitelist.auto[i].models) do
                if Num > settings.auto.modellimit then
                    notification("[M] 限制来自的实体 "..players.get_name(i), TOAST_ALL)
                    if util.current_time_millis() + settings.auto.timeout > synctimer[i] then
                        synctimer[i] = util.current_time_millis() + settings.auto.timeout
                    end
                    if settings.auto.cleanup then
                        for n, Pointer in ipairs(allents) do
                            if does_entity_from_pointer_exist(Pointer) and entities.get_model_hash(Pointer) == Model then
                                delete(Pointer)
                            end
                        end
                    end
                end
            end
            if whitelist.auto[i].highpriority.total > settings.auto.highlimit then
                notification("[H] 限制来自的实体 "..players.get_name(i), TOAST_ALL)
                if util.current_time_millis() + settings.auto.timeout > synctimer[i] then
                    synctimer[i] = util.current_time_millis() + settings.auto.timeout
                end
                if settings.auto.cleanup then
                    for n, Pointer in ipairs(whitelist.auto[i].owner) do
                        if does_entity_from_pointer_exist(Pointer) then
                            whitelist.auto[i].timer[Pointer] = util.current_time_millis()
                            delete(Pointer)
                        end
                    end
                end
            end
        end
    end
end, function()
    whitelist.auto = {}
    whitelist.auto.logged = {}
    for i = 0, 31 do
        whitelist.auto[i] = {}
        whitelist.auto[i].owner = {}
        whitelist.auto[i].current = {}
        whitelist.auto[i].timer = {}
        whitelist.auto[i].models = {}
        whitelist.auto[i].highpriority = {
            total = 0,
        }
    end
end)
menu.toggle(autothrottler, "清理", {}, "当节流器开启时，自动删除您周围的所有相应实体", function(toggle)
    settings.auto.cleanup = toggle
end)
menu.slider(autothrottler, "间隔（秒）", {}, "指定实体同步被视为垃圾邮件的持续时间（秒）.", 0, 60, settings.auto.interval/1000, 1, function(value)
    settings.auto.interval = value*1000
end)
menu.slider(autothrottler, "超时（秒）", {}, "指定（以秒为单位）受影响的玩家传入同步将被阻止的时间.", 0, 60, settings.auto.timeout/1000, 1, function(value)
    settings.auto.timeout = value*1000
end)
menu.slider(autothrottler, "总限额", {}, "指定任何给定玩家应同步的实体总数的限制.", 0, 512, settings.auto.totallimit, 1, function(value)
    settings.auto.totallimit = value
end)
menu.slider(autothrottler, "上限", {}, '指定任何给定玩家应同步的高优先级（任务）实体的数量限制.', 0, 64, settings.auto.highlimit, 1, function(value)
    settings.auto.highlimit = value
end)
menu.slider(autothrottler, "模型限制", {}, "指定任何给定玩家应同步的具有相同模型的实体的数量限制.", 0, 128, settings.auto.modellimit, 1, function(value)
    settings.auto.modellimit = value
end)

local bigthrottler = menu.list(throttler, "大型车辆节流器", {}, "")

menu.toggle_loop(bigthrottler, "开启", {}, "", function()
    local Pointers = {}
    local pos = players.get_position(players.user())
    for i, Pointer in ipairs(entities.get_all_vehicles_as_pointers()) do
        if whitelist.bigvehicle.logged[Pointer] == nil and (v3.distance(entities.get_position(Pointer), pos) < settings.bigvehicle.radius) then
            if bigvehicle[entities.get_model_hash(Pointer)] and whitelist.bigvehicle.owner[Pointer] ~= -1 and whitelist.bigvehicle.owner[Pointer] ~= players.user() and ((settings.bigvehicle.excludeplayer and not is_pointer_a_player_vehicle(Pointer)) or not settings.bigvehicle.excludeplayer) then
                whitelist.bigvehicle.owner[Pointer] = get_entity_owner(Pointer)
                whitelist.bigvehicle.logged[Pointer] = true
            else
                whitelist.bigvehicle.logged[Pointer] = false
            end
        end
        if whitelist.bigvehicle.logged[Pointer] then
            Pointers[#Pointers+1] = Pointer
        end
    end
    if #Pointers > settings.bigvehicle.limit then
        local owners = {}
        for i, Pointer in ipairs(Pointers) do
            owners[#owners + 1] = whitelist.bigvehicle.owner[Pointer]
        end
        local owner = get_highest_count(owners)
        if players.exists(owner) then
            notification("限制来自"..players.get_name(owner), TOAST_ALL)
            if util.current_time_millis() + settings.bigvehicle.timeout > synctimer[owner] then
                synctimer[owner] = util.current_time_millis() + settings.bigvehicle.timeout
            end
        elseif settings.bigvehicle.cleanup then
            notification("节流大型车辆", TOAST_ALL)
        end
        if settings.bigvehicle.cleanup then
            if players.exists(owner) then
                for i, Pointer in ipairs(Pointers) do
                    if get_entity_owner(Pointer) == owner then
                        if does_entity_from_pointer_exist(Pointer) then
                            delete(Pointer)
                        end
                    end
                end
            else
                for i, Pointer in ipairs(Pointers) do
                    if does_entity_from_pointer_exist(Pointer) then
                        delete(Pointer)
                    end
                end
            end
        end
    end
end, function()
    whitelist.bigvehicle.timer = {}
    whitelist.bigvehicle.owner = {}
end)
menu.toggle(bigthrottler, "清理", {}, "当节流器开启时，自动删除您周围的所有对应实体.", function(toggle)
    settings.bigvehicle.cleanup = toggle
end)
menu.toggle(bigthrottler, "排除玩家车辆", {}, "这将排除玩家车辆.", function(toggle)
    settings.bigvehicle.excludeplayer = toggle
end)
menu.slider(bigthrottler, "超时（秒）", {}, "指定（以秒为单位）应阻止受影响的玩家传入同步的时间.", 0, 60, settings.bigvehicle.timeout/1000, 1, function(value)
    settings.bigvehicle.timeout = value*1000
end)
menu.slider(bigthrottler, "限度", {}, "指定任何给定玩家应以半径同步的实体数量的限制.", 0, 100, settings.bigvehicle.limit, 1, function(value)
    settings.bigvehicle.limit = value
end)
menu.slider(bigthrottler, "半径", {}, "指定要考虑实体的周围距离.", 0, 1000, settings.bigvehicle.radius, 5, function(value)
    settings.bigvehicle.radius = value
end)

local vehiclethrottler = menu.list(throttler, "车辆节流器", {}, "")

menu.toggle_loop(vehiclethrottler, "开启", {}, "", function()
    local Pointers = {}
    local pos = players.get_position(players.user())
    local allvehicles = entities.get_all_vehicles_as_pointers()
    for i, Pointer in ipairs(allvehicles) do
        if not whitelist.vehicle.timer[Pointer] and (v3.distance(entities.get_position(Pointer), pos) < settings.vehicle.radius) then
            whitelist.vehicle.owner[Pointer] = get_entity_owner(Pointer)
            if whitelist.vehicle.owner[Pointer] ~= -1 and whitelist.vehicle.owner[Pointer] ~= players.user() and ((settings.vehicle.excludeplayer and not is_pointer_a_player_vehicle(Pointer)) or not settings.vehicle.excludeplayer) then
                whitelist.vehicle.timer[Pointer] = util.current_time_millis()
            else
                whitelist.vehicle.timer[Pointer] = 0
            end
        end
        if whitelist.vehicle.timer[Pointer] and (whitelist.vehicle.timer[Pointer] + settings.vehicle.interval > util.current_time_millis()) then
            Pointers[#Pointers+1] = Pointer
        end
    end
    if #Pointers > settings.vehicle.limit then
        local owners = {}
        for i, Pointer in ipairs(Pointers) do
            owners[#owners + 1] = whitelist.vehicle.owner[Pointer]
        end
        local owner = get_highest_count(owners)
        if players.exists(owner) then
            notification("限制来自 "..players.get_name(owner), TOAST_ALL)
            if util.current_time_millis() + settings.vehicle.timeout > synctimer[owner] then
                synctimer[owner] = util.current_time_millis() + settings.vehicle.timeout
            end
        elseif settings.vehicle.cleanup then
            notification("节流车辆", TOAST_ALL)
        end
        if settings.vehicle.cleanup then
            if players.exists(owner) then
                Pointers = entities.get_all_vehicles_as_pointers()
                for i, Pointer in ipairs(Pointers) do
                    if get_entity_owner(Pointer) == owner then
                        if does_entity_from_pointer_exist(Pointer) then
                            whitelist.vehicle.timer[Pointer] = util.current_time_millis()
                            delete(Pointer)
                        end
                    end
                end
            else
                for i, Pointer in ipairs(Pointers) do
                    if does_entity_from_pointer_exist(Pointer) then
                        whitelist.vehicle.timer[Pointer] = util.current_time_millis()
                        delete(Pointer)
                    end
                end
            end
        end
    end
end, function()
    whitelist.vehicle.timer = {}
    whitelist.vehicle.owner = {}
end)
menu.toggle(vehiclethrottler, "清理", {}, "当节流器开启时，自动删除您周围的所有对应实体.", function(toggle)
    settings.vehicle.cleanup = toggle
end)
menu.toggle(vehiclethrottler, "排除玩家车辆", {}, "这将排除玩家车辆.", function(toggle)
    settings.vehicle.excludeplayer = toggle
end)
menu.slider(vehiclethrottler, "间隔（秒）", {}, "指定实体同步被视为垃圾邮件的持续时间（秒）.", 0, 60, settings.vehicle.interval/1000, 1, function(value)
    settings.vehicle.interval = value*1000
end)
menu.slider(vehiclethrottler, "超时（秒）", {}, "指定（以秒为单位）应阻止受影响的玩家传入同步的时间.", 0, 60, settings.vehicle.timeout/1000, 1, function(value)
    settings.vehicle.timeout = value*1000
end)
menu.slider(vehiclethrottler, "限度", {}, "指定任何给定玩家应以半径同步的实体数量的限制.", 0, 100, settings.vehicle.limit, 1, function(value)
    settings.vehicle.limit = value
end)
menu.slider(vehiclethrottler, "半径", {}, "指定要考虑实体的周围距离.", 0, 1000, settings.vehicle.radius, 5, function(value)
    settings.vehicle.radius = value
end)

local objectthrottler = menu.list(throttler, "对象节流", {}, "")

menu.toggle_loop(objectthrottler, "开启", {}, "", function()
    local Pointers = {}
    local pos = players.get_position(players.user())
    local allobjects = entities.get_all_objects_as_pointers()
    local allpickups = entities.get_all_pickups_as_pointers()
    local og = merge_table(false, allobjects, allpickups)
    for i, Pointer in ipairs(og) do
        if not whitelist.object.timer[Pointer] and (v3.distance(entities.get_position(Pointer), pos) < settings.object.radius) then
            whitelist.object.owner[Pointer] = get_entity_owner(Pointer)
            if whitelist.object.owner[Pointer] ~= -1 and whitelist.object.owner[Pointer] ~= players.user() then
                whitelist.object.timer[Pointer] = util.current_time_millis()
            else
                whitelist.object.timer[Pointer] = 0
            end
        end
        if whitelist.object.timer[Pointer] and (whitelist.object.timer[Pointer] + settings.object.interval > util.current_time_millis()) then
            Pointers[#Pointers+1] = Pointer
        end
    end
    if #Pointers > settings.object.limit then
        local owners = {}
        for i, Pointer in ipairs(Pointers) do
            owners[#owners + 1] = whitelist.object.owner[Pointer]
        end
        local owner = get_highest_count(owners)
        if players.exists(owner) then
            notification("限制来自的对象 "..players.get_name(owner), TOAST_ALL)
            if util.current_time_millis() + settings.object.timeout > synctimer[owner] then
                synctimer[owner] = util.current_time_millis() + settings.object.timeout
            end
        elseif settings.object.cleanup then
            notification("限制对象", TOAST_ALL)
        end
        if settings.object.cleanup then
            if players.exists(owner) then
                Pointers = entities.get_all_objects_as_pointers()
                for i, Pointer in ipairs(Pointers) do
                    if get_entity_owner(Pointer) == owner then
                        if does_entity_from_pointer_exist(Pointer) then
                            whitelist.object.timer[Pointer] = util.current_time_millis()
                            delete(Pointer)
                        end
                    end
                end
            else
                for i, Pointer in ipairs(Pointers) do
                    if does_entity_from_pointer_exist(Pointer) then
                        whitelist.object.timer[Pointer] = util.current_time_millis()
                        delete(Pointer)
                    end
                end
            end
        end
    end
end, function()
    whitelist.object.timer = {}
    whitelist.object.owner = {}
end)
menu.toggle(objectthrottler, "清理", {}, "当节流器开启时，自动删除您周围的所有对应实体.", function(toggle)
    settings.object.cleanup = toggle
end)
menu.slider(objectthrottler, "间隔（秒）", {}, "指定实体同步被视为垃圾邮件的持续时间（秒）.", 0, 60, settings.object.interval/1000, 1, function(value)
    settings.object.interval = value*1000
end)
menu.slider(objectthrottler, "超时（秒）", {}, "指定（以秒为单位）受影响的玩家传入同步将被阻止的时间.", 0, 60, settings.object.timeout/1000, 1, function(value)
    settings.object.timeout = value*1000
end)
menu.slider(objectthrottler, "限度", {}, "指定任何给定玩家应以半径同步的实体数量的限制.", 0, 100, settings.object.limit, 1, function(value)
    settings.object.limit = value
end)
menu.slider(objectthrottler, "半径", {}, "指定要扫描实体的周围距离", 0, 1000, settings.object.radius, 5, function(value)
    settings.object.radius = value
end)

local pedthrottler = menu.list(throttler, "Ped节流阀", {}, "")

menu.toggle_loop(pedthrottler, "开启", {}, "", function()
    local Pointers = {}
    local pos = players.get_position(players.user())
    local allpeds = entities.get_all_peds_as_pointers()
    for i, Pointer in ipairs(allpeds) do
        if not whitelist.ped.timer[Pointer] and (v3.distance(entities.get_position(Pointer), pos) < settings.ped.radius) then
            whitelist.ped.owner[Pointer] = get_entity_owner(Pointer)
            if whitelist.ped.owner[Pointer] ~= -1 and entities.get_player_info(Pointer) == 0 and whitelist.ped.owner[Pointer] ~= players.user() then
                whitelist.ped.timer[Pointer] = util.current_time_millis()
            else
                whitelist.ped.timer[Pointer] = 0
            end
        end
        if whitelist.ped.timer[Pointer] and (whitelist.ped.timer[Pointer] + settings.ped.interval > util.current_time_millis()) then
            Pointers[#Pointers+1] = Pointer
        end
    end
    if #Pointers > settings.ped.limit then
        local owners = {}
        for i, Pointer in ipairs(Pointers) do
            owners[#owners + 1] = whitelist.ped.owner[Pointer]
        end
        local owner = get_highest_count(owners)
        if players.exists(owner) then
            notification("限制来自 "..players.get_name(owner), TOAST_ALL)
            if util.current_time_millis() + settings.ped.timeout > synctimer[owner] then
                synctimer[owner] = util.current_time_millis() + settings.ped.timeout
            end
        elseif settings.ped.cleanup then
            notification("节流Peds", TOAST_ALL)
        end
        if settings.ped.cleanup then
            if players.exists(owner) then
                Pointers = entities.get_all_peds_as_pointers()
                for i, Pointer in ipairs(Pointers) do
                    if (entities.get_player_info(Pointer) == 0) and get_entity_owner(Pointer) == owner then
                        if does_entity_from_pointer_exist(Pointer) then
                            whitelist.ped.timer[Pointer] = util.current_time_millis()
                            delete(Pointer)
                        end
                    end
                end
            else
                for i, Pointer in ipairs(Pointers) do
                    if does_entity_from_pointer_exist(Pointer) then
                        whitelist.ped.timer[Pointer] = util.current_time_millis()
                        delete(Pointer)
                    end
                end
            end
        end
    end
end, function()
    whitelist.ped.timer = {}
    whitelist.ped.owner = {}
end)
menu.toggle(pedthrottler, "清理", {}, "当节流器开启时，自动删除您周围的所有对应实体.", function(toggle)
    settings.ped.cleanup = toggle
end)
menu.slider(pedthrottler, "间隔（秒）", {}, "指定实体同步被视为垃圾邮件的持续时间（秒）.", 0, 60, settings.ped.interval/1000, 1, function(value)
    settings.ped.interval = value*1000
end)
menu.slider(pedthrottler, "超时（秒）", {}, "指定（以秒为单位）受影响的玩家传入同步将被阻止的时间.", 0, 60, settings.ped.timeout/1000, 1, function(value)
    settings.ped.timeout = value*1000
end)
menu.slider(pedthrottler, "限度", {}, "指定任何给定玩家应以半径同步的实体数量的限制.", 0, 100, settings.ped.limit, 1, function(value)
    settings.ped.limit = value
end)
menu.slider(pedthrottler, "半径", {}, "指定要考虑实体的周围距离.", 0, 1000, settings.ped.radius, 5, function(value)
    settings.ped.radius = value
end)

util.keep_running()