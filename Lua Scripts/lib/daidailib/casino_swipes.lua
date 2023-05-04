
CSstate = {}
CSmenus = {}
commands = {
    rigslotmachines=menu.ref_by_path("Online>Quick Progress>Casino>Slot Machines Outcome")
}
slot_machine_positions = {
    {
        seated={x=1102.2573, y=232.43211, z=-50.0909},
        standing={x=1102.6787, y=232.73073, z=-49.84076, h=90},
    },
    {
        seated={x=1112.4808, y=234.83745, z=-50.0909},
        standing={x=1112.0146, y=235.13573, z=-49.84075, h=-90},
    },
    {
        seated={x=1110.1028, y=235.05864, z=-50.0909},
        standing={x=1110.5834, y=235.30466, z=-49.840767, h=90},
    },
    {
        seated={x=1111.9581, y=237.83565, z=-50.0909},
        standing={x=1112.1866, y=237.27339, z=-49.840763, h=0},
    },
    {
        seated={x=1113.66, y=238.81334, z=-50.0909},
        standing={x=1113.8134, y=238.09317, z=-49.840786, h=0}
    },
    {
        seated={x=1139.4238, y=250.89787, z=-51.2909},
        standing={x=1139.8647, y=250.2418, z=-51.035732, h=70}
    },
    {
        seated={x=1130.6184, y=251.2604, z=-51.2909},
        standing={x=1130.7328, y=251.68321, z=-51.035774, h=180}
    },
    {
        seated={x=1137.2375, y=253.092, z=-51.2909},
        standing={x=1137.3026, y=253.69514, z=-51.03577, h=180}
    },
    {
        seated={x=1103.4133, y=230.6071, z=-50.0909},
        standing={x=1102.95, y=230.27, z=-49.84, h=-90},
    },
    {
        seated={x=1118.7598, y=230.03072, z=-50.0909},
        standing={x=1119.2648, y=230.20291, z=-49.840748, h=100}
    },
}

local CONFIG_DIR = filesystem.store_dir() .. 'daidai-log\\'
filesystem.mkdirs(CONFIG_DIR)
local LEGACY_SPIN_LOG_FILE = CONFIG_DIR .. "spin_log.json"
local SPIN_LOG_FILE = CONFIG_DIR .. "spin_log_".. players.get_rockstar_id(players.user()) .. ".json"

function IS_MPPLY(Stat)
    local Stats = {
        "MP_PLAYING_TIME",
        "MP_NGDLCPSTAT_INT0",
    }
    for i = 1, #Stats do
        if Stat == Stats[i] then
            return true
        end
    end
    if string.find(Stat, "MPPLY_") then
        return true
    else
        return false
    end
end
function ADD_MP_INDEX(Stat)
    if not IS_MPPLY(Stat) then
        Stat = "MP" .. util.get_char_slot() .. "_" .. Stat
    end
    return Stat
end
function STAT_GET_INT(Stat)
    local IntPTR = memory.alloc_int()
    STATS.STAT_GET_INT(util.joaat(ADD_MP_INDEX(Stat)), IntPTR, -1)
    return memory.read_int(IntPTR)
end
function get_chip_count()
    return STAT_GET_INT("CASINO_CHIPS")
end
function debug_log(message)
    if casinoconfig.debug_mode then
        util.log("[CasinoSwipes] "..message)
    end
end
function array_reverse(x)
    local n, m = #x, #x/2
    for i=1, m do
        x[i], x[n-i+1] = x[n-i+1], x[i]
    end
    return x
end
function press_button(button_id)
    for i = 1,10 do
        PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, button_id, 1)
        util.yield()
    end
end
function format_large_number(number)
    local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')
    int = int:reverse():gsub("(%d%d%d)", "%1,")
    return minus .. int:reverse():gsub("^,", "") .. fraction
end
function is_spin_recent(spin_log_item)
    if spin_log_item.is_rigged then
        if spin_log_item.timestamp == nil and spin_log_item.time ~= nil then
            local target_time_milli = util.current_time_millis() - casinoconfig.millis_in_day
            if spin_log_item.time > target_time_milli then
                return true
            else
                return false
            end
        elseif spin_log_item.timestamp ~= nil then
            local target_time_seconds = util.current_unix_time_seconds() - casinoconfig.seconds_in_day
            if spin_log_item.timestamp > target_time_seconds then
                return true
            else
                return false
            end
        end
    end
    return true
end

function count_wins(spin_log)
    local num_wins = 0
    for _, spin in pairs(spin_log) do
        if is_spin_recent(spin) then
            num_wins = num_wins + 1
        end
    end
    return num_wins
end
function calculate_daily_winnings(spin_log)
    local daily_winnings = 0
    for _, spin in pairs(spin_log) do
        if is_spin_recent(spin) and spin.winnings ~= nil and spin.winnings > 0 then
            daily_winnings = daily_winnings + (spin.winnings or 0)
        end
    end
    return daily_winnings
end
function calculate_losses_since_win(spin_log)
    local num_losses = 0
    for _, spin_log_item in pairs(array_reverse(spin_log)) do
        if not spin_log_item.is_rigged then
            num_losses = num_losses + 1
        else
            return num_losses
        end
    end
    return num_losses
end
function disp_time(time)
    --local days = math.floor(time/86400)
    local hours = math.floor((time % 86400)/3600)
    local minutes = math.floor((time % 3600)/60)
    --local seconds = math.floor(time % 60)
    return string.format("%d:%02d",hours,minutes)
end
function is_player_within_dimensions(dimensions, pid)
    if pid == nil then pid = players.user_ped() end
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local player_pos = ENTITY.GET_ENTITY_COORDS(target_ped)
    return (
            player_pos.x > dimensions.min.x and player_pos.x < dimensions.max.x
                    and player_pos.y > dimensions.min.y and player_pos.y < dimensions.max.y
                    and player_pos.z > dimensions.min.z and player_pos.z < dimensions.max.z
    )
end
function is_player_in_casino(pid)
    return is_player_within_dimensions({
        min={
            x=1073.9967,
            y=189.58717,
            z=-53.838943,
        },
        max={
            x=1166.935,
            y=284.88977,
            z=-42.28554,
        },
    }, pid)
end
function teleport_to_casino()
    CSstate.is_teleporting_to_casino = true
    menu.trigger_commands("casinotp"..players.get_name(players.user()))
end
function is_player_near_slot_machine(slot_machine_position, sensitivty)
    if sensitivty == nil then sensitivty = 1 end
    return is_player_within_dimensions({
        min={
            x=slot_machine_position.x - sensitivty,
            y=slot_machine_position.y - sensitivty,
            z=slot_machine_position.z - sensitivty,
        },
        max={
            x=slot_machine_position.x + sensitivty,
            y=slot_machine_position.y + sensitivty,
            z=slot_machine_position.z + sensitivty,
        },
    }, players.user())
end
function is_player_at_any_slot_machine()
    for _, slot_machine_position in pairs(slot_machine_positions) do
        if is_player_near_slot_machine(slot_machine_position.seated, 0.3) then
            return true
        end
    end
    return false
end
function find_free_slot_machine()
    util.toast("查找可用的老虎机")
    debug_log("Finding available slot machine")
    CSstate.is_finding_slot_machine = true
    for _, slot_machine_position in pairs(slot_machine_positions) do
        if not CSstate.auto_spin then return end
        local pos = slot_machine_position.standing
        ENTITY.SET_ENTITY_COORDS(players.user_ped(), pos.x, pos.y, pos.z)
        ENTITY.SET_ENTITY_HEADING(players.user_ped(), pos.h)
        util.yield(casinoconfig.delay_between_button_press)
        PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 51, 1)
        util.yield(casinoconfig.delay_between_button_press * 2)
        PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 201, 1)
        util.yield(casinoconfig.delay_sitting_at_slot_machine)
        if is_player_near_slot_machine(slot_machine_position.seated, 0.3) then
            debug_log("Found available slot machine")
            util.toast("找到老虎机")
            CSstate.is_finding_slot_machine = false
            return true
        end
    end
    CSstate.is_finding_slot_machine = false
    return false
end
function save_spin_log(spin_log)
    local file = io.open(SPIN_LOG_FILE, "wb")
    if file == nil then util.toast("打开赌场日志文件进行写入时出错："..SPIN_LOG_FILE, TOAST_ALL) return end
    file:write(soup.json.encode(spin_log))
    file:close()
end
function load_spin_log()
    local file = io.open(SPIN_LOG_FILE)
    if not file then
        debug_log("Trying legacy spin log file")
        file = io.open(LEGACY_SPIN_LOG_FILE)
    end
    if file then
        local version = file:read()
        file:close()
        local spin_log_status, spin_log = pcall(soup.json.decode, version)
        if not spin_log_status then
            util.toast("无法解码赌场日志文件", TOAST_ALL)
            return {}
        end
        return spin_log
    else
        return {}
    end
end
function log_spin(is_rigged, spin_winnings)
    debug_log("Logging spin")
    local spin_log = load_spin_log()
    local num_wins = count_wins(spin_log)
    -- Reset spin log if no daily wins. Avoid growing too large.
    if num_wins == 0 and #spin_log > 0 then spin_log = {} end
    table.insert(spin_log, {
        is_rigged=is_rigged,
        timestamp=util.current_unix_time_seconds(),
        winnings=spin_winnings,
        log_time=os.date("%H:%M:%S")
    })
    save_spin_log(spin_log)
end
function get_daily_winnings()
    local spin_log = load_spin_log()
    return calculate_daily_winnings(spin_log)
end
local max_daily_winnings = 40000000
function max_daily_winnings_value(value)
    max_daily_winnings = value * 1000000
end
function find_earliest_rigged_spin()
    local winnings = 0
    local spin_log = load_spin_log()
    for _, spin_log_item in pairs(array_reverse(spin_log)) do
        if is_spin_recent(spin_log_item) then
            winnings = winnings + (spin_log_item.winnings or 0)
            if winnings > max_daily_winnings then
                return spin_log_item
            end
        end
    end
end
function get_safe_playtime()
    local first_spin = find_earliest_rigged_spin()
    if first_spin == nil then return "00:00" end
    local countdown
    if first_spin.timestamp == nil and first_spin.time ~= nil then
        countdown = first_spin.time - util.current_time_millis() - casinoconfig.millis_in_day
    else
        countdown = first_spin.timestamp - util.current_unix_time_seconds() + casinoconfig.seconds_in_day
    end
    if countdown > 0 then
        return disp_time(countdown)
    else
        return "00:00"
    end
end
function is_num_daily_wins_exceeded()
    return get_daily_winnings() >= max_daily_winnings
end

function refresh_daily_winnings()
    CSmenus.daily_winnings.value = "$" .. format_large_number(get_daily_winnings())
    debug_log("Refreshed daily winning to "..CSmenus.daily_winnings.value)
end
function refresh_next_spin_time()
    local safe_playtime = get_safe_playtime()
    if safe_playtime and safe_playtime ~= "00:00" then
        CSmenus.next_spin_time.value = safe_playtime
    else
        CSmenus.next_spin_time.value = "已准备就绪!"
    end
end
local loss_ratio = 2
function loss_ratio_value(value)
    loss_ratio = value
end
function only_loss(on)
    if on then
        loss_ratio = 9999999999
    else
        loss_ratio = 2
    end
end

function switch_rigged_state()
    local spin_log = load_spin_log()
    if calculate_losses_since_win(spin_log) >= loss_ratio then
        CSstate.is_rigged = true
    else
        CSstate.is_rigged = false
    end
end
function exit_slots()
    debug_log("Exiting slots")
    menu.trigger_commands("rigslotmachines off")
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 202, 1)
    util.yield(casinoconfig.delay_between_button_press)
end
function is_slots_ready_for_spin()
    if not is_player_in_casino(players.user()) then
        util.toast("您必须在赌场中并坐在高支出的老虎机上才能启动自动执行")
        exit_slots()
        return false
    end
    if not is_player_at_any_slot_machine() then
        util.toast("您必须坐在高支出老虎机（“钻石矿工”或“太阳的迪蒂”）上才能启动自动执行")
        exit_slots()
        return false
    end
    if is_num_daily_wins_exceeded() then
        util.toast("您已经赢得了每日限额。在"..get_safe_playtime())
        exit_slots()
        return false
    end
    return true
end
function acquire_chips()
    debug_log("Acquiring chips")
    util.toast("从收银员处获取筹码")
    local cashier_position = {x=1116.0953, y=219.82039, z=-49.43512, h=-90}
    ENTITY.SET_ENTITY_COORDS(players.user_ped(), cashier_position.x, cashier_position.y, cashier_position.z)
    ENTITY.SET_ENTITY_HEADING(players.user_ped(), cashier_position.h)
    util.yield(5000)
    util.yield(casinoconfig.delay_between_button_press)
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 51, 1)
    util.yield(casinoconfig.delay_between_button_press)
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 192, 1)
    util.yield(casinoconfig.delay_between_button_press)
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 201, 1)
    util.yield(casinoconfig.delay_between_button_press)
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 201, 1)
    util.yield(casinoconfig.delay_between_button_press)
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 202, 1)
    util.yield(casinoconfig.delay_between_button_press)
    CSstate.has_chips = true
end
function stop_auto_spin()
    debug_log("Stopping auto spin")
    util.toast("自动进行完成")
    CSmenus.auto_spin.value = false
end
function cash_out_chips()
    if get_chip_count() <= 10000 then
        debug_log("Too few chips, skipping cash out")
        stop_auto_spin()
        return
    end
    debug_log("Cashing out chips")
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 202, 1)
    util.yield(casinoconfig.delay_between_button_press)
    local cashier_position = {x=1116.0953, y=219.82039, z=-49.43512, h=-90}
    ENTITY.SET_ENTITY_COORDS(players.user_ped(), cashier_position.x, cashier_position.y, cashier_position.z)
    ENTITY.SET_ENTITY_HEADING(players.user_ped(), cashier_position.h)
    util.yield(5000)
    util.yield(casinoconfig.delay_between_button_press)
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 51, 1)
    util.yield(casinoconfig.delay_between_button_press)
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 187, 1)
    util.yield(casinoconfig.delay_between_button_press)
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 192, 1)
    util.yield(casinoconfig.delay_between_button_press)
    local end_time <const> = util.current_time_millis() + 6000
    while end_time > util.current_time_millis() do
        PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 189, 1)
        util.yield()
    end
    util.yield(casinoconfig.delay_between_button_press)
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 201, 1)
    util.yield(casinoconfig.delay_between_button_press)
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 201, 1)
    util.yield(casinoconfig.delay_between_button_press)
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 202, 1)
    util.yield(casinoconfig.delay_between_button_press)
    CSstate.has_chips = false
    stop_auto_spin()
end
function spin_slots()
    if not is_slots_ready_for_spin() then
        debug_log("Slot machine not ready for spinning")
        return
    end
    switch_rigged_state()
    local previous_chip_count = get_chip_count()
    if not casinoconfig.never_rig then
        if CSstate.is_rigged then
            debug_log("Setting slots to win")
            util.toast("执行老虎机为赢")
            if casinoconfig.test_mode then
                menu.trigger_command(commands.rigslotmachines, "smallwin")
            else
                menu.trigger_command(commands.rigslotmachines, "jackpot")
            end
            CSstate.has_chips = true
        else
            debug_log("Setting slots to lose")
            util.toast("执行老虎机为输")
            menu.trigger_command(commands.rigslotmachines, "loss")
        end
        util.yield(casinoconfig.delay_between_button_press * 2)
        debug_log("Setting bet amount")
        if CSstate.is_rigged then
            press_button(204)   -- TAB for Max Bet
        else
            press_button(204)   -- TAB for Max Bet
            util.yield(casinoconfig.delay_between_button_press * 2)
            press_button(203)   -- Space to cycle to lowest bet
        end
        util.yield(casinoconfig.delay_between_button_press)
    end
    debug_log("Spinning slot")
    press_button(201)
    util.yield(casinoconfig.delay_between_button_press * 4)
    debug_log("Setting slots to unrigged")
    menu.trigger_command(commands.rigslotmachines, "off")
    util.yield(casinoconfig.delay_between_spins - 1000)
    local spin_winnings = get_chip_count() - previous_chip_count
    debug_log("Chip change "..tostring(spin_winnings))
    log_spin(CSstate.is_rigged, spin_winnings)
    refresh_daily_winnings()
    refresh_next_spin_time()
end
function bandit_tick()
    if CSstate.auto_spin then
        local current_time = util.current_time_millis()
        if CSstate.next_update_time == nil or current_time > CSstate.next_update_time then
            local delay_time = casinoconfig.default_spin_delay_time
            if is_num_daily_wins_exceeded() then
                debug_log("Daily win limit exceeded")
                util.toast("您已经赢得了每日限额。在"..get_safe_playtime())
                if is_player_at_any_slot_machine() then
                    exit_slots()
                elseif casinoconfig.auto_cash_out then
                    cash_out_chips()
                end
            elseif is_player_in_casino(players.user()) and CSstate.is_teleporting_to_casino then
                debug_log("Teleport to Casino complete")
                CSstate.is_teleporting_to_casino = false
                delay_time = casinoconfig.delay_after_entering_casino
            elseif CSstate.is_teleporting_to_casino then
            elseif not is_player_in_casino(players.user()) then
                debug_log("Teleporting to Casino")
                teleport_to_casino()
            elseif CSstate.has_chips ~= true and get_chip_count() < 5000 then
                acquire_chips()
            elseif CSstate.is_finding_slot_machine then
            elseif not is_player_at_any_slot_machine() then
                find_free_slot_machine()
            else
                spin_slots()
                delay_time = casinoconfig.delay_between_spins
                if CSstate.is_rigged then
                    delay_time = delay_time + 3000
                end
            end
            CSstate.next_update_time = util.current_time_millis() + delay_time
        end
    end
    return true
end
function next_spin_time_tick()
    if CSstate.next_spin_time_update == nil or util.current_unix_time_seconds() > CSstate.next_spin_time_update then
        refresh_next_spin_time()
        CSstate.next_spin_time_update = util.current_unix_time_seconds() + 60
    end
end
spin_log_menu_items = {}
function show_casino_log()
    for _, spin_log_menu_item in pairs(spin_log_menu_items) do
        menu.delete(spin_log_menu_item)
    end
    local spin_log = load_spin_log()
    for index, spin_log_item in pairs(spin_log) do
        local time_ago = tostring(disp_time(util.current_unix_time_seconds() - spin_log_item.timestamp))
        local timestamp = (spin_log_item.log_time or "")
        local item = string.format("Spin #%d [%s] [%s] $%s", index, timestamp, time_ago, spin_log_item.winnings)
        local spin_log_item_menu = menu.readonly(CSmenus.spin_log, item)
        table.insert(spin_log_menu_items, spin_log_item_menu)
    end
end