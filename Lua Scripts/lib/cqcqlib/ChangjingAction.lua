util.require_natives("1663599433")

local all_data_dir = filesystem.store_dir() .. "\\动画"
if not filesystem.exists(all_data_dir) then
    filesystem.mkdir(all_data_dir)
end

-- load anims 
local all_anims_path = all_data_dir .. '\\all_anims.txt'
local installing_anims = false
if not filesystem.exists(all_anims_path) then 
    installing_anims = true
    async_http.init('gist.githubusercontent.com', '/xSetrox/dcf6d87a273353373da0d810d93ff437/raw', function(data)
        local file = io.open(all_anims_path, 'w')
        file:write(data)
        file:close()
        installing_anims = false
    end, function()
        util.toast("Could not install anim data. Stopping script.")
        util.stop_script()
    end)
    async_http.dispatch()
end

while installing_anims do 
    util.toast("正在安装动画数据，他妈的给我等着操你妈的.....")
    util.yield()
end

local fp = io.open(all_anims_path, "r")
if not fp then
    util.toast("打开动画数据时出错,脚本现在将停止.")
    util.stop_script()
    return
end

local all_anims = {}
for l in io.lines(all_anims_path) do
    all_anims[#all_anims+1] = l
end

-- load scenarios 
-- https://gist.github.com/xSetrox/edbd91cf2faaa11761bf5de0e9e394e3/raw

local all_scenarios_path = all_data_dir .. '\\all_scenarios.txt'
local installing_scenarios = false
if not filesystem.exists(all_scenarios_path) then 
    installing_scenarios = true
    async_http.init('gist.githubusercontent.com', '/xSetrox/edbd91cf2faaa11761bf5de0e9e394e3/raw', function(data)
        local file = io.open(all_scenarios_path, 'w')
        file:write(data)
        file:close()
        installing_scenarios = false
    end, function()
        util.toast("无法安装方案数据.")
    end)
    async_http.dispatch()
end

while installing_scenarios do 
    util.toast("正在安装方案数据，他妈的给我等着...")
    util.yield()
end

local fp = io.open(all_scenarios_path, "r")
if not fp then
    util.toast("打开方案数据时出错,脚本现在将停止.")
    util.stop_script()
    return
end

local all_scenarios = {}
for l in io.lines(all_scenarios_path) do
    all_scenarios[#all_scenarios+1] = l
end

local anim_search_result_dicts = {}
local anim_search_result_anim_names = {}
local scenario_search_results = {}

local function request_anim_dict(dict)
    while not STREAMING.HAS_ANIM_DICT_LOADED(dict) do
        util.toast("正在加载动画他妈的给我等着...")
        STREAMING.REQUEST_ANIM_DICT(dict)
        util.yield()
    end
end

local function stop()
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
end

local function search_for_anim_by_name(query, search_dict)
    local found = false
    search_result_dics = {}
    anim_search_result_anim_names = {}
    for _, v in pairs(all_anims) do
        local dict, anim_name = string.partition(v, ' ')
        if (search_dict and string.contains(dict, string.lower(query))) or (not search_dict and string.contains(anim_name, string.lower(query))) then 
            anim_search_result_dicts[#anim_search_result_dicts+1] = dict 
            anim_search_result_anim_names[#anim_search_result_anim_names+1] = anim_name
            found = true
        end
        util.toast("正在搜索，他妈的给我等着.")   
    end
    return found
end

local function search_for_scenario(query)
    local found = false
    scenario_search_results = {}
    for _, v in pairs(all_scenarios) do
        if string.contains(string.lower(v), string.lower(query)) then
            scenario_search_results[#scenario_search_results+1] = v
            found = true
        end
        util.toast("他妈的正在搜索，他妈的能不能等一下.")   
    end
    return found
end


local main_root = ChangjingAction
main_root:divider("动画")

local anim_search_result_list = 0
local scenario_search_result_list = 0

main_root:action("按anim-dict搜索（推荐）", {"searchanimdict"}, "", function(on_click)
    menu.show_command_box("searchanimdict ")
end, function(search)
    local search = search_for_anim_by_name(search, true)
    if search then 
        menu.set_list_action_options(anim_search_result_list, anim_search_result_anim_names)
        menu.trigger_command(anim_search_result_list)
        menu.set_visible(anim_search_result_list, true)
    else
        util.toast("没有结果...")
        menu.set_visible(anim_search_result_list, false)
    end
end)

main_root:action("按动画名称搜索", {"searchanimname"}, "", function(on_click)
    menu.show_command_box("searchanimname ")
end, function(search)
    local search = search_for_anim_by_name(search, false)
    if search then 
        menu.set_list_action_options(anim_search_result_list, anim_search_result_anim_names)
        menu.trigger_command(anim_search_result_list)
        menu.set_visible(anim_search_result_list, true)
    else
        util.toast("没有结果的你妈的")
        menu.set_visible(anim_search_result_list, false)
    end
end)

-- anims settings
local blend_in_speed = 8.0
local blend_out_speed = 8.0
local playback_rate = 0.0
local anim_flags = {0, 1, 2, 16, 32, 120}
local anim_flag = 0
local lock_x = false 
local lock_y = false 
local lock_z = false 
-- scenarios settings
local scen_play_enter_anim = true 
anim_search_result_list = main_root:list_action("动画搜索结果", {"animsearchresults"}, "", anim_search_result_anim_names, function(index, value)
    local dict = anim_search_result_dicts[index]
    local anim_name = value
    stop()
    request_anim_dict(dict)
    should_lock_z = lock_z
    if lock_z and not util.is_session_started() then 
        should_lock_z = false 
    end
    TASK.TASK_PLAY_ANIM(players.user_ped(), dict, anim_name, blend_in_speed, blend_out_speed, -1, anim_flag, playback_rate, lock_x, lock_y, should_lock_z)
end)

main_root:divider("情节")
main_root:action("搜索", {"searchscenario"}, "", function(on_click)
    menu.show_command_box("searchscenario ")
end, function(search)
    local search = search_for_scenario(search)
    if search then 
        menu.set_list_action_options(scenario_search_result_list, scenario_search_results)
        menu.trigger_command(scenario_search_result_list)
        menu.set_visible(scenario_search_result_list, true)
    else
        util.toast("没有你妈的结果")
        menu.set_visible(scenario_search_result_list, false)
    end
end)

scenario_search_result_list = main_root:list_action("方案搜索结果", {"scenariosearchresults"}, "", scenario_search_results, function(index, value)
    stop()
    TASK.TASK_START_SCENARIO_IN_PLACE(players.user_ped(), value, 0, scen_play_enter_anim)
end)


main_root:divider("杂项")
local settings_root = main_root:list("设置", {}, "")
settings_root:divider("动画")


settings_root:slider_float("混合速度", {"blendinspeed"}, "", 0, 2000, 800, 1, function(s)
    blend_in_speed = s*0.1
end)


settings_root:slider_float("混合速度", {"blendoutspeed"}, "", 0, 2000, 800, 1, function(s)
    blend_out_speed = s*0.01
end)


settings_root:slider_float("播放速率", {"playbackrate"}, "", 0, 100, 0, 1, function(s)
    playback_rate = s*0.1
end)

settings_root:list_select("动画标志", {"animflag"}, "", {"典型的", "重复", "停止最后一帧", "上半身", "启用播放器控制", "可取消"}, 1, function(index, value)
    anim_flag = anim_flags[index]
end)


settings_root:toggle("锁 X", {"locky"}, "", function(on)
    lock_x = on
end)


settings_root:toggle("锁 Y", {"locky"}, "", function(on)
    lock_y = on
end)


settings_root:toggle("锁 Z", {"lockz"}, "", function(on)
    lock_z = on
end)

settings_root:divider("情节")
settings_root:toggle("播放输入动画", {"playscenenteranim"}, "", function(on)
    scen_play_enter_anim = on
end, true)

menu.set_visible(anim_search_result_list, false)
menu.set_visible(scenario_search_result_list, false)

menu.action(ChangjingAction, "停止一切", {"止痛药"}, "", function()
    stop()
end)

--async_http.init("pastebin.com", "/raw/nrMdhHwE", function(result)
   -- menu.hyperlink(ChangjingAction, "Join discord翻译By从前从前", result, "")
--end)
async_http.dispatch()



util.keep_running()
