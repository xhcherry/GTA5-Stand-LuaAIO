local SCRIPT_VERSION = "0.25"
local config = {
    debug_mode = false,
    test_mode = false,
    auto_cash_out = false,
    never_rig = false,
    delay_between_button_press = 500,
    delay_sitting_at_slot_machine = 5000,
    delay_between_spins = 3000,
    delay_after_entering_casino = 4000,
    default_spin_delay_time = 1000,
    loss_ratio = 2,
    max_allowed_daily_winnings = 45,
    max_daily_winnings = 40000000,
    millis_in_day = 86400000,
    seconds_in_day = 86400,
}
local state = {}
local menus = {}
local commands = {
    rigslotmachines=menu.ref_by_path("Online>Quick Progress>Casino>Slot Machines Outcome")
}

local slot_machine_positions = {
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

---
--- Utils
---

-- From HeistControl
local function IS_MPPLY(Stat)
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

local function ADD_MP_INDEX(Stat)
    if not IS_MPPLY(Stat) then
        Stat = "MP" .. util.get_char_slot() .. "_" .. Stat
    end
    return Stat
end

local function STAT_GET_INT(Stat)
    local IntPTR = memory.alloc_int()
    STATS.STAT_GET_INT(util.joaat(ADD_MP_INDEX(Stat)), IntPTR, -1)
    return memory.read_int(IntPTR)
end

local function get_chip_count()
    return STAT_GET_INT("CASINO_CHIPS")
end

local function debug_log(message)
    if config.debug_mode then
        util.log("[Sakura] "..message)
    end
end

local function array_reverse(x)
    local n, m = #x, #x/2
    for i=1, m do
        x[i], x[n-i+1] = x[n-i+1], x[i]
    end
    return x
end

local function press_button(button_id)
    for i = 1,10 do
        PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, button_id, 1)
        util.yield()
    end
end

local function format_large_number(number)
    local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')

    -- reverse the int-string and append a comma to all blocks of 3 digits
    int = int:reverse():gsub("(%d%d%d)", "%1,")

    -- reverse the int-string back remove an optional comma and put the
    -- optional minus and fractional part back
    return minus .. int:reverse():gsub("^,", "") .. fraction
end

local function is_spin_recent(spin_log_item)
    if spin_log_item.is_rigged then
        if spin_log_item.timestamp == nil and spin_log_item.time ~= nil then
            local target_time_milli = util.current_time_millis() - config.millis_in_day
            if spin_log_item.time > target_time_milli then
                return true
            else
                return false
            end
        elseif spin_log_item.timestamp ~= nil then
            local target_time_seconds = util.current_unix_time_seconds() - config.seconds_in_day
            if spin_log_item.timestamp > target_time_seconds then
                return true
            else
                return false
            end
        end
    end
    return true
end

local function count_wins(spin_log)
    local num_wins = 0
    for _, spin in pairs(spin_log) do
        if is_spin_recent(spin) then
            num_wins = num_wins + 1
        end
    end
    return num_wins
end

local function calculate_daily_winnings(spin_log)
    local daily_winnings = 0
    for _, spin in pairs(spin_log) do
        if is_spin_recent(spin) and spin.winnings ~= nil and spin.winnings > 0 then
            daily_winnings = daily_winnings + (spin.winnings or 0)
        end
    end
    return daily_winnings
end

local function calculate_losses_since_win(spin_log)
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

local function disp_time(time)
    --local days = math.floor(time/86400)
    local hours = math.floor((time % 86400)/3600)
    local minutes = math.floor((time % 3600)/60)
    --local seconds = math.floor(time % 60)
    return string.format("%d:%02d",hours,minutes)
end

local function is_player_within_dimensions(dimensions, pid)
    if pid == nil then pid = players.user_ped() end
    local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local player_pos = ENTITY.GET_ENTITY_COORDS(target_ped)
    return (
            player_pos.x > dimensions.min.x and player_pos.x < dimensions.max.x
                    and player_pos.y > dimensions.min.y and player_pos.y < dimensions.max.y
                    and player_pos.z > dimensions.min.z and player_pos.z < dimensions.max.z
    )
end

local function is_player_in_casino(pid)
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

local function teleport_to_casino()
    state.is_teleporting_to_casino = true
    menu.trigger_commands("casinotp"..players.get_name(players.user()))
end

local function is_player_near_slot_machine(slot_machine_position, sensitivty)
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

local function is_player_at_any_slot_machine()
    for _, slot_machine_position in pairs(slot_machine_positions) do
        if is_player_near_slot_machine(slot_machine_position.seated, 0.3) then
            return true
        end
    end
    return false
end

local function find_free_slot_machine()
    util.toast("正在查找可用的老虎机")
    debug_log("Finding available slot machine")
    state.is_finding_slot_machine = true
    for _, slot_machine_position in pairs(slot_machine_positions) do
        if state.is_finding_slot_machine == false then return end
        local pos = slot_machine_position.standing
        ENTITY.SET_ENTITY_COORDS(players.user_ped(), pos.x, pos.y, pos.z)
        ENTITY.SET_ENTITY_HEADING(players.user_ped(), pos.h)
        util.yield(config.delay_between_button_press)

        -- E to sit down
        PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 51, 1)
        util.yield(config.delay_between_button_press * 2)

        -- Enter to excuse help message
        PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 201, 1)
        util.yield(config.delay_sitting_at_slot_machine)

        if is_player_at_any_slot_machine() then
            debug_log("Found available slot machine")
            util.toast("找到老虎机")
            state.is_finding_slot_machine = false
            return true
        end
    end
    state.is_finding_slot_machine = false
    return false
end

---
--- Spin Log
---

local CONFIG_DIR = filesystem.store_dir() .. 'SakuraLog\\SlotBot Log\\'
filesystem.mkdirs(CONFIG_DIR)
local LEGACY_SPIN_LOG_FILE = CONFIG_DIR .. "spin_log.json"
local SPIN_LOG_FILE = CONFIG_DIR .. "spin_log_".. players.get_rockstar_id(players.user()) .. ".json"

local function save_spin_log(spin_log)
    local file = io.open(SPIN_LOG_FILE, "wb")
    if file == nil then util.toast("日志文件写入时出错: "..SPIN_LOG_FILE, TOAST_ALL) return end
    file:write(soup.json.encode(spin_log))
    file:close()
end

local function load_spin_log()
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
            util.toast("无法解码日志文件", TOAST_ALL)
            return {}
        end
        return spin_log
    else
        return {}
    end
end

local function log_spin(is_rigged, spin_winnings)
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

---
--- Functions
---

local function get_daily_winnings()
    local spin_log = load_spin_log()
    return calculate_daily_winnings(spin_log)
end

--local function get_num_wins_past_day()
--    local spin_log = load_spin_log()
--    return count_wins(spin_log)
--end

local function find_earliest_rigged_spin()
    local winnings = 0
    local spin_log = load_spin_log()
    for _, spin_log_item in pairs(array_reverse(spin_log)) do
        if is_spin_recent(spin_log_item) then
            winnings = winnings + (spin_log_item.winnings or 0)
            if winnings > config.max_daily_winnings then
                return spin_log_item
            end
        end
    end
end

local function get_safe_playtime()
    local first_spin = find_earliest_rigged_spin()
    if first_spin == nil then return "00:00" end
    local countdown
    if first_spin.timestamp == nil and first_spin.time ~= nil then
        countdown = first_spin.time - util.current_time_millis() - config.millis_in_day
    else
        countdown = first_spin.timestamp - util.current_unix_time_seconds() + config.seconds_in_day
    end
    if countdown > 0 then
        return disp_time(countdown)
    else
        return "00:00"
    end
end

local function is_num_daily_wins_exceeded()
    return get_daily_winnings() >= config.max_daily_winnings
end

local function refresh_daily_winnings()
    menus.daily_winnings.value = "$" .. format_large_number(get_daily_winnings())
    debug_log("Refreshed daily winning to "..menus.daily_winnings.value)
end

local function refresh_next_spin_time()
    local safe_playtime = get_safe_playtime()
    if safe_playtime and safe_playtime ~= "00:00" then
        menus.next_spin_time.value = safe_playtime
    else
        menus.next_spin_time.value = "准备就绪!"
    end
end

local function switch_rigged_state()
    local spin_log = load_spin_log()
    if calculate_losses_since_win(spin_log) >= config.loss_ratio then
        state.is_rigged = true
    else
        state.is_rigged = false
    end
end

local function exit_slots()
    debug_log("Exiting slots")
    menu.trigger_commands("rigslotmachines off")
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 202, 1)
    util.yield(config.delay_between_button_press)
end

local function is_slots_ready_for_spin()

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
        util.toast("您已经赢得了每日限额。在 "..get_safe_playtime())
        exit_slots()
        return false
    end

    return true
end

local function acquire_chips()
    debug_log("Acquiring chips")
    util.toast("从收银员处获取筹码")

    local cashier_position = {x=1116.0953, y=219.82039, z=-49.43512, h=-90}
    ENTITY.SET_ENTITY_COORDS(players.user_ped(), cashier_position.x, cashier_position.y, cashier_position.z)
    ENTITY.SET_ENTITY_HEADING(players.user_ped(), cashier_position.h)
    util.yield(5000)
    util.yield(config.delay_between_button_press)

    -- E to speak to Cashier
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 51, 1)
    util.yield(config.delay_between_button_press)

    -- Tab to max
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 192, 1)
    util.yield(config.delay_between_button_press)

    -- Enter to submit
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 201, 1)
    util.yield(config.delay_between_button_press)

    -- Enter to confirm
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 201, 1)
    util.yield(config.delay_between_button_press)

    -- Esc to exit
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 202, 1)
    util.yield(config.delay_between_button_press)

    state.has_chips = true
end

local function stop_auto_spin()
    debug_log("Stopping auto spin")
    util.toast("自动执行完成")
    menus.auto_spin.value = false
end

local function cash_out_chips()
    if get_chip_count() <= 10000 then
        debug_log("Too few chips, skipping cash out")
        stop_auto_spin()
        return
    end
    debug_log("Cashing out chips")

    -- Esc to exit
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 202, 1)
    util.yield(config.delay_between_button_press)

    local cashier_position = {x=1116.0953, y=219.82039, z=-49.43512, h=-90}
    ENTITY.SET_ENTITY_COORDS(players.user_ped(), cashier_position.x, cashier_position.y, cashier_position.z)
    ENTITY.SET_ENTITY_HEADING(players.user_ped(), cashier_position.h)
    util.yield(5000)
    util.yield(config.delay_between_button_press)

    -- E to speak to Cashier
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 51, 1)
    util.yield(config.delay_between_button_press)

    -- Down to withdrawl
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 187, 1)
    util.yield(config.delay_between_button_press)

    -- Tab to max
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 192, 1)
    util.yield(config.delay_between_button_press)

    -- Left to lower amount and keep some chips for next time
    local end_time <const> = util.current_time_millis() + 6000
    while end_time > util.current_time_millis() do
        PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 189, 1)
        util.yield()
    end
    util.yield(config.delay_between_button_press)

    -- Enter to submit
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 201, 1)
    util.yield(config.delay_between_button_press)

    -- Enter to confirm
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 201, 1)
    util.yield(config.delay_between_button_press)

    -- Esc to exit
    PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 202, 1)
    util.yield(config.delay_between_button_press)

    state.has_chips = false
    stop_auto_spin()
end

---
--- Spin Slots
---

local function spin_slots()

    if not is_slots_ready_for_spin() then
        debug_log("Slot machine not ready for spinning")
        return
    end

    switch_rigged_state()

    local previous_chip_count = get_chip_count()

    if not config.never_rig then
        if state.is_rigged then
            debug_log("Setting slots to win")
            util.toast("旋转老虎机为赢")
            if config.test_mode then
                menu.trigger_command(commands.rigslotmachines, "smallwin")
            else
                menu.trigger_command(commands.rigslotmachines, "jackpot")
            end
            state.has_chips = true
        else
            debug_log("Setting slots to lose")
            util.toast("旋转老虎机为输")
            menu.trigger_command(commands.rigslotmachines, "loss")
        end
        util.yield(config.delay_between_button_press * 2)

        -- Set Bet Amount
        debug_log("Setting bet amount")
        if state.is_rigged then
            press_button(204)   -- TAB for Max Bet
        else
            press_button(204)   -- TAB for Max Bet
            util.yield(config.delay_between_button_press * 2)
            press_button(203)   -- Space to cycle to lowest bet
        end
        util.yield(config.delay_between_button_press)
    end

    -- Spin
    debug_log("Spinning slot")
    press_button(201)
    util.yield(config.delay_between_button_press * 4)

    debug_log("Setting slots to unrigged")
    menu.trigger_command(commands.rigslotmachines, "off")

    util.yield(config.delay_between_spins - 1000)

    local spin_winnings = get_chip_count() - previous_chip_count
    debug_log("Chip change "..tostring(spin_winnings))

    log_spin(state.is_rigged, spin_winnings)
    refresh_daily_winnings()
    refresh_next_spin_time()
end

---
--- Update Tick
---

local function bandit_tick()
    if state.auto_spin then
        local current_time = util.current_time_millis()
        if state.next_update_time == nil or current_time > state.next_update_time then
            local delay_time = config.default_spin_delay_time

            if is_num_daily_wins_exceeded() then
                debug_log("Daily win limit exceeded")
                util.toast("您已经赢得了每日限额。在 "..get_safe_playtime())
                if is_player_at_any_slot_machine() then
                    exit_slots()
                elseif config.auto_cash_out then
                    cash_out_chips()
                end
            elseif is_player_in_casino(players.user()) and state.is_teleporting_to_casino then
                debug_log("Teleport to Casino complete")
                state.is_teleporting_to_casino = false
                delay_time = config.delay_after_entering_casino
            elseif state.is_teleporting_to_casino then
                -- Do nothing but continue to wait
            elseif not is_player_in_casino(players.user()) then
                debug_log("Teleporting to Casino")
                teleport_to_casino()
            elseif state.has_chips ~= true and get_chip_count() < 5000 then
                acquire_chips()
            elseif state.is_finding_slot_machine then
                -- Do nothing but continue to wait
            elseif not is_player_at_any_slot_machine() then
                find_free_slot_machine()
            else
                spin_slots()
                delay_time = config.delay_between_spins
                if state.is_rigged then
                    -- Extend time for celebration animation
                    delay_time = delay_time + 3000
                end
            end

            state.next_update_time = util.current_time_millis() + delay_time
        end
    end
    return true
end

local function next_spin_time_tick()
    if state.next_spin_time_update == nil or util.current_unix_time_seconds() > state.next_spin_time_update then
        refresh_next_spin_time()
        state.next_spin_time_update = util.current_unix_time_seconds() + 60
    end
end

---
--- Menus
---
menus.auto_spin = menu.toggle(casino_brush_money, "自动刷钱", {}, "", function(toggle)
    debug_log("Toggled auto-spin "..tostring(toggle))
    state.auto_spin = toggle
    if not toggle then
        state.is_finding_slot_machine = false
    end
end)

menus.daily_winnings = menu.readonly(casino_brush_money, "每日奖金")
refresh_daily_winnings()
menus.next_spin_time = menu.readonly(casino_brush_money, "距离下一次可执行的时间")
refresh_next_spin_time()

---
--- Options Menu
---

local menu_options = menu.list(casino_brush_money, "选项", {}, "用于控制脚本行为方式的设置")
menu.slider(menu_options, "目标每日奖金（百万）", {}, "设置在 24 小时内赢取的目标金额。在一天内赢得超过 5000 万美元可能会有风险", 1, config.max_allowed_daily_winnings, math.floor(config.max_daily_winnings / 1000000), 1, function(value)
    config.max_daily_winnings = value * 1000000
    refresh_next_spin_time()
end)
menu.toggle(menu_options, "自动提现", {}, "自动执行完成后自动兑现筹码", function(on)
    config.auto_cash_out = on
end)
menu.slider(menu_options, "损失率", {}, "每次获胜之后的失败次数.", 1, 10, config.loss_ratio, 1, function(value)
    config.loss_ratio = value
end)
menu.toggle(menu_options, "从不钻机", {}, "如果打开，那么所有旋转都将是公平的.", function(on)
    config.never_rig = on
end, config.never_rig)
menu.toggle(menu_options, "调试模式", {}, "", function(on)
    config.debug_mode = on
end, config.debug_mode)

menus.delays = menu.list(menu_options, "延误", {}, "在执行某些操作后调整暂停计时器")
menu.slider(menus.delays, "按下按钮", {}, "按下任意按钮后暂停的毫秒数", 300, 3000, config.delay_between_button_press, 100, function(value)
    config.delay_between_button_press = value
end)
menu.slider(menus.delays, "进入赌场", {}, "进入赌场后暂停的毫秒数", 500, 10000, config.delay_after_entering_casino, 100, function(value)
    config.delay_after_entering_casino = value
end)

---
--- Actions Menu
---

menus.actions = menu.list(menu_options, "行动", {}, "")
menu.action(menus.actions, "传送到赌场", {}, "", function()
    teleport_to_casino()
end)
menu.action(menus.actions, "获取筹码", {}, "自动从赌场收银员获得50000筹码的每日限额", function()
    acquire_chips()
end)
menu.action(menus.actions, "查找老虎机", {}, "自动定位空置的高赔付老虎机", function()
    find_free_slot_machine()
end)
menu.action(menus.actions, "兑现筹码", {}, "自动兑现筹码，同时保留一些储备", function()
    cash_out_chips()
end)

---
--- Spin Log Menu
---

local spin_log_menu_items = {}
menus.spin_log = menu.list(menu_options, "查看日志", {}, "", function()
    for _, spin_log_menu_item in pairs(spin_log_menu_items) do
        menu.delete(spin_log_menu_item)
    end
    local spin_log = load_spin_log()
    for index, spin_log_item in pairs(spin_log) do
        local time_ago = tostring(disp_time(util.current_unix_time_seconds() - spin_log_item.timestamp))
        local timestamp = (spin_log_item.log_time or "")
        local item = string.format("Spin #%d [%s] [%s] $%s", index, timestamp, time_ago, spin_log_item.winnings)
        local spin_log_item_menu = menu.readonly(menus.spin_log, item)
        table.insert(spin_log_menu_items, spin_log_item_menu)
    end
end)

menu.action(menu_options, "清除日志", {}, "", function()
    save_spin_log({})
    refresh_daily_winnings()
    refresh_next_spin_time()
end)


---
--- Tick Handler
---

util.create_tick_handler(bandit_tick)
util.create_tick_handler(next_spin_time_tick)
