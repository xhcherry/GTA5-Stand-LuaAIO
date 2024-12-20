-- stackoverflow is love
-- https://stackoverflow.com/a/67917666
local function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

local joaat = util.joaat
local my_root = menu.my_root()
local action = menu.action
local slider = menu.slider
local div = menu.divider
local max_int = 2147483647

local STATS = {
    ["STAT_GET_INT"]=--[[BOOL (bool)]] function(--[[Hash (int)]] statHash,--[[int* (pointer)]] outValue,--[[int]] p2)native_invoker.begin_call()native_invoker.push_arg_int(statHash)native_invoker.push_arg_pointer(outValue)native_invoker.push_arg_int(p2)native_invoker.end_call_2(0x767FBC2AC802EF3D)return native_invoker.get_return_value_bool()end,
    ["STAT_GET_FLOAT"]=--[[BOOL (bool)]] function(--[[Hash (int)]] statHash,--[[float* (pointer)]] outValue,--[[Any (int)]] p2)native_invoker.begin_call()native_invoker.push_arg_int(statHash)native_invoker.push_arg_pointer(outValue)native_invoker.push_arg_int(p2)native_invoker.end_call_2(0xD7AE6C9C9C6AC54C)return native_invoker.get_return_value_bool()end,
    ["STAT_SET_INT"]=--[[BOOL (bool)]] function(--[[Hash (int)]] statName,--[[int]] value,--[[BOOL (bool)]] save)native_invoker.begin_call()native_invoker.push_arg_int(statName)native_invoker.push_arg_int(value)native_invoker.push_arg_bool(save)native_invoker.end_call_2(0xB3271D7AB655B441)return native_invoker.get_return_value_bool()end,
    ["STAT_SET_FLOAT"]=--[[BOOL (bool)]] function(--[[Hash (int)]] statName,--[[float]] value,--[[BOOL (bool)]] save)native_invoker.begin_call()native_invoker.push_arg_int(statName)native_invoker.push_arg_float(value)native_invoker.push_arg_bool(save)native_invoker.end_call_2(0x4851997F37FE9B3C)return native_invoker.get_return_value_bool()end,
}

local mem = {
    alloc = memory.alloc,
    g_global = memory.script_global,
    get_int = memory.read_int,
    get_float = memory.read_float,
}

local kills_ptr  = mem.alloc(4)
local deaths_ptr = mem.alloc(4)
local ratio_ptr  = mem.alloc(4)

-- thank you Sapphire for helping me with reading/writing globals and helping me fix the ratio not being written c:
local global_kills  = mem.g_global(1853910 + 1 + (players.user() * 862) + 205 + 28)
local global_deaths = mem.g_global(1853910 + 1 + (players.user() * 862) + 205 + 29)
local global_ratio  = mem.g_global(1853910 + 1 + (players.user() * 862) + 205 + 26)

local kills_stat_hash  = joaat("MPPLY_KILLS_PLAYERS")
local deaths_stat_hash = joaat("MPPLY_DEATHS_PLAYER")
local ratio_stat_hash  = joaat("MPPLY_KILL_DEATH_RATIO")

util.create_tick_handler(function()

    STATS.STAT_GET_INT(kills_stat_hash, kills_ptr, -1)
    STATS.STAT_GET_INT(deaths_stat_hash, deaths_ptr, -1)
    STATS.STAT_GET_FLOAT(ratio_stat_hash, ratio_ptr, -1)

    get_stat_kills  = mem.get_int(kills_ptr)
    get_stat_deaths = mem.get_int(deaths_ptr)
    get_stat_ratio  = mem.get_float(ratio_ptr)

    get_global_kills  = mem.get_int(global_kills)
    get_global_deaths = mem.get_int(global_deaths)
    get_global_ratio = mem.get_float(global_ratio)

    if get_global_kills == get_stat_kills then
        cur_kills = get_global_kills
    else
        cur_kills = get_stat_kills
    end

    if get_global_deaths == get_stat_deaths then
        cur_deaths = get_global_deaths
    else
        cur_deaths = get_stat_deaths
    end

    if get_global_ratio == get_stat_ratio then
        cur_ratio = get_global_ratio
    else
        cur_ratio = get_stat_ratio
    end
end)

--if util.is_session_started() then

    div(kdr, "当前KD")

    local cur_kills_display = action(kdr, "当前击杀数: " .. cur_kills, { "" }, "", function() end)

    local cur_death_display = action(kdr, "当前死亡数: " .. cur_deaths, { "" }, "", function() end)

    local cur_ratio_display = action(kdr, "当前KD值: " .. cur_ratio, { "" }, "", function() end)

    div(kdr, "新的KD")

    local kills_slider_value = cur_kills
    local deaths_slider_value = cur_deaths

    local new_kills = slider(kdr, "新的击杀数", {"killsamount"}, "", -max_int, max_int, cur_kills, 1, function(value)
        kills_slider_value = value
    end)

    local new_deaths = slider(kdr, "新的死亡数", {"deathsamount"}, "", -max_int, max_int, cur_deaths, 1, function(value)
        deaths_slider_value = value
    end)

    util.create_tick_handler(function()
        new_ratio = menu.get_value(new_kills) / menu.get_value(new_deaths)
    end)

    local new_ratio_display = action(kdr, "新的KD值: " .. round(new_ratio, 2), { "" }, "", function()  end)

    action(kdr, "应用更改", { "setkda" }, "", function()
        if util.is_session_started() then
        memory.write_int(global_kills, kills_slider_value)
        memory.write_int(global_deaths, deaths_slider_value)
        memory.write_float(global_ratio, new_ratio)

        STATS.STAT_SET_INT(kills_stat_hash, kills_slider_value, true)
        STATS.STAT_SET_INT(deaths_stat_hash, deaths_slider_value, true)
        STATS.STAT_SET_FLOAT(ratio_stat_hash, new_ratio, true)

        util.toast("设置KD为 " .. new_ratio .. " 成功")
        else
        util.toast("你需要进入线上模式")
        end
    end)

    util.create_tick_handler(function()
        menu.set_menu_name(cur_kills_display, "当前击杀数: " .. cur_kills)
        menu.set_menu_name(cur_death_display, "当前死亡数: " .. cur_deaths)
        menu.set_menu_name(cur_ratio_display, "当前KD值: " .. round(cur_ratio, 2))
        menu.set_menu_name(new_ratio_display, "新的KD值: " .. new_ratio)
    end)
--[[else
    util.yield(169)
    util.toast("You have to be online!")
end]]

util.keep_running()