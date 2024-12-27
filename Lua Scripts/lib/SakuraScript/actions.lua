local SCRIPT_SOURCE = "REPO"
local SCRIPT_BRANCH = "release"
local BRANCH_LAST_COMMIT = "c6ab1c273850de8b851a24d25c102f06f864f836"
local SCRIPT_BRANCH_IDS = {"master","release"}
local SCRIPT_BRANCH_NAMES = {{"dev"},{"release"}}

local SCRIPT = "actions"
VERSION = "1.10.10"
local ANIMATIONS_DATA_FILE = filesystem.scripts_dir().. "/daidaiScript/actions/animations.txt"
local ANIMATIONS_DATA_FILE_VERSION = "1.0"
local SPECIAL_ANIMATIONS_DATA_FILE_VERSION = "1.0.0"

function dumpTable(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dumpTable(v) .. ','
       end
       return s .. '} '
    elseif type(o) == "string" then
        return '"' .. o .. "'"
    else
       return tostring(o)
    end
end

------------------------------------------------------------------
function show_busyspinner(text)
    HUD.BEGIN_TEXT_COMMAND_BUSYSPINNER_ON("STRING")
    HUD.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME(text)
    HUD.END_TEXT_COMMAND_BUSYSPINNER_ON(2)
end


SCRIPT_DEBUG = SCRIPT_SOURCE == nil

function try_require(name, isOptional)
    local status, data = pcall(require, name)
    if status then
        return data
    else
        if data then
            util.toast(name .. ": " .. data, TOAST_ALL)
        end
        if SCRIPT_SOURCE == "REPO" then
            if isOptional then
                Log.debug("缺少依赖: " .. name)
            else
                util.toast("缺少必需的依赖 (\"" .. name .. "\"). 请从仓库>依赖列表中安装")
                Log.severe("缺少必需的依赖:", name)
            end
        elseif download_lib_update then
            local lockPath = download_lib_update(name, function()
                Log.log("Downloaded ", isOptional and "optional" or "required", "library:", name)
            end)
            while filesystem.exists(lockPath) do
                util.yield(500)
            end
            return require(name)
        end
        return nil
    end
end
-- END TEMPLATE --


--require "lib.daidaimain.natives.natives"

if metaList then
    menu.divider(metaList, "-- Credits --")
    menu.hyperlink(metaList, "dpemotes", "https://github.com/andristum/dpemotes/", "对于特殊动画,代码是从依赖中来的")
end

-- Iterates in consistent order a Key/Value
function pairsByKeys(t, f)
    local a = {}
    for n in pairs(t) do
       table.insert(a, n)
    end
    table.sort(a, f)
    local i = 0 -- iterator variable
    local iter = function()
        -- iterator function
        i = i + 1
        if a[i] == nil then
            return nil
        else
            return a[i], t[a[i]]
        end
    end
    return iter
 end
local status = pcall(require, 'lib.SakuraScript.Main.action.actions_data')
if not status then
    util.toast("加载资源文件失败: lib.daidaimain.action.actions_data")
    util.stop_script()
end

-- Messy Globals
local scenarioCount = 0

local clearActionImmediately = true
local favorites = {}
local favoritesActions = {}
local recents = {}
local animFlags = AnimationFlags.ANIM_FLAG_REPEAT | AnimationFlags.ANIM_FLAG_ENABLE_PLAYER_CONTROL
local allowControl = true
local affectType = 0
-----------------------
-- SCENARIOS
----------------------

menu.action(action_list_lua, "停止所有动作", {}, "停止当前场景或动画", function(v)
    clear_anim_props()
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
    if clearActionImmediately then
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
    else
        TASK.CLEAR_PED_TASKS(ped)
    end
    if affectType > 0 then
        local peds = entities.get_all_peds_as_handles()
        for _, npc in ipairs(peds) do
            if not PED.IS_PED_A_PLAYER(npc) and not PED.IS_PED_IN_ANY_VEHICLE(npc, true) then
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(npc)
                if clearActionImmediately then
                    TASK.CLEAR_PED_TASKS_IMMEDIATELY(npc)
                else
                    TASK.CLEAR_PED_TASKS(npc)
                end
            end
        end
    end
end)
menu.toggle(action_list_lua, "立即清除", {}, "如果启用，将在激活新动画/场景时立即停止正在播放的动画/场景。 如果为关，您将顺利过渡到下一个动作.", function(on)
    lclearActionImmediately = on
end, clearActionImmediately)
menu.list_select(action_list_lua, "行动目标", {}, "将执行此操作的实体", {{1,"自己"}, {2,"NPC"}, {3,"全部"}}, 1, function(index)
    affectType = index - 1
end)
function onControllablePress(value)
    if value then
        animFlags = AnimationFlags.ANIM_FLAG_REPEAT | AnimationFlags.ANIM_FLAG_ENABLE_PLAYER_CONTROL
    else
        animFlags = AnimationFlags.ANIM_FLAG_REPEAT
    end
end
function generateAnimationAction(key, data)
    return function()
        util.toast("播放动画: " .. data[3] or key)
        util.log(string.format("dict=%s anim=%s name=%s", data[1], data[2], data[3]))
        play_anim(data[1], data[2], false, data)
    end
end

menu.divider(action_list_lua, "项目")
local specialAnimationsMenu = menu.list(action_list_lua, "特殊动画", {}, "可以使用道具的特殊动画")
menu.toggle(specialAnimationsMenu, "可控", {}, "动画是否允许玩家控制?", onControllablePress, allowControl)
local animationsMenu = menu.list(action_list_lua, "动画", {}, "您可以播放的动画列表")
menu.toggle(animationsMenu, "可控", {}, "动画是否允许玩家控制?", onControllablePress, allowControl)


for category, rows in pairsByKeys(SPECIAL_ANIMATIONS) do
    local catmenu = menu.list(specialAnimationsMenu, category, {})
    for key, data in pairsByKeys(rows) do
        menu.action(
            catmenu,
            data[3] or key,
            {"playanim"..key},
            string.format("%s %s\nPlay this animation\nAnimation Id: %s", data[1], data[2], key),
            generateAnimationAction(key, data)
        )
    end
end


-----------------------
-- ANIMATIONS
----------------------
local animLoaded = false
local animAttachments = {}
function clear_anim_props()
    for ent, shouldDelete in pairs(animAttachments) do
        if shouldDelete then
            entities.delete(ent)
        else
            ENTITY.DETACH_ENTITY(ent, false)
        end
    end
end
function delete_anim_props()
    for ent, _ in pairs(animAttachments) do
        entities.delete(ent)
    end
end

local animMenuData = {}
local resultMenus = {}
local cloudFavoritesMenu = menu.list(animationsMenu, "云收藏夹", {}, "查看其他用户分类保存的收藏夹，或存储您自己的收藏夹.")
local favoritesMenu = menu.list(animationsMenu, "收藏夹", {}, "所有您喜爱的动画列表。 按住 SHIFT 可在收藏夹中添加或删除.")
local cloudFavoritesUploadMenu = menu.list(cloudFavoritesMenu, "上传", {}, "添加您自己的云动画收藏夹.测试版.")
local cloudUploadFromFavorites = menu.list(cloudFavoritesUploadMenu, "收藏夹", {}, "浏览您喜爱的播放动画并上传", function() populate_cloud_list(true) end)
local cloudUploadFromRecent = menu.list(cloudFavoritesUploadMenu, "最近", {}, "浏览您最近播放的动画",  function() populate_cloud_list(false) end)
local cloudFavoritesBrowseMenu = menu.list(cloudFavoritesMenu, "浏览", {}, "浏览所有上传的云动画收藏夹")

local cloudUsers = {} -- Record<user, { menu, categories = Record<dictionary, { menu, animations = {} }>}
local cloud_loading = false
function cloudvehicle_fetch_error(code)
    return function()
        cloud_loading = false
        util.toast("获取云数据时发生错误. 编码: " .. code, TOAST_ALL)
        HUD.BUSYSPINNER_OFF()
    end
end
local cloud_list = {}
function upload_animation(group, animation, alias)
    show_busyspinner("上传动画")
    async_http.init('jackz.me',
        string.format(
            '/stand/cloud/actions/manage?scname=%s&hash=%d&alias=%s&dict=%s&anim=%s',
            SOCIALCLUB._SC_GET_NICKNAME(),
            menu.get_activation_key_hash(),
            alias or '',
            group,
            animation
        ),
        function(body)
            if body == "OK" then
                util.toast("上传成功 " .. group .. "/" .. animation)
            elseif body == "Conflict" then
                util.toast("动画已经上传")
            else
                util.toast("上传失败 " .. group .. "/" .. animation .. ": " .. body)
            end
            HUD.BUSYSPINNER_OFF()
        end
    )
    async_http.set_post('text/plain', '')
    async_http.dispatch()
end
function populate_cloud_list(useFavorites)
    local listMenu = useFavorites and cloudUploadFromFavorites or cloudUploadFromRecent
    local tuple = useFavorites and favorites or recents
    for _, m in ipairs(cloud_list) do
        menu.delete(m)
    end
    cloud_list = {}
    for _, favorite in ipairs(tuple) do
        local name = favorite[2]
        -- if favorite[3] then
        --     name = favorite[3] .. " (" .. favorite[2] .. ")"
        -- end
        local action = menu.action(listMenu, name, {}, "Upload the " .. favorite[2] .. " from group " .. favorite[1] .. " to the cloud", function(v)
            upload_animation(favorite[1], favorite[2], nil)
        end)
        table.insert(cloud_list, action)
    end
end
function populate_user_dict(user, dictionary)
    show_busyspinner("获取动画 " .. dictionary)
    while cloud_loading do
        util.yield()
    end
    cloud_loading = true
    async_http.init('jackz.me', '/stand/cloud/actions/list?method=actions&scname=' .. user .. "&dict=" .. dictionary, function(body)
        cloud_loading = false
        if body:sub(1, 1) == "<" then
            util.toast("速度限制，几秒钟后再试.")
            menu.divider(cloudUsers[user].categories[dictionary].menu, "速度限制，几秒钟后再试")
            return
        end
        for _, animation in ipairs(cloudUsers[user].categories[dictionary].animations) do
            pcall(menu.delete, animation)
        end
        cloudUsers[user].categories[dictionary].animations = {}
        local count = 0
        for animation in string.gmatch(body, "[^\r\n]+") do
            count = count + 1
            local action = menu.action(cloudUsers[user].categories[dictionary].menu, animation, {}, dictionary .. " " .. animation, function(_)
                play_anim(dictionary, animation)
            end)
            table.insert(cloudUsers[user].categories[dictionary].animations, action)
        end
        menu.set_menu_name(cloudUsers[user].categories[dictionary].menu, dictionary .. " (" .. count .. ")")
        HUD.BUSYSPINNER_OFF()
    end, cloudvehicle_fetch_error("FETCH_USER_ANIMS"))
    async_http.dispatch()
end
menu.on_focus(cloudFavoritesBrowseMenu, function()
    show_busyspinner("获取用户")
    while cloud_loading do
        util.yield()
    end
    cloud_loading = true
    async_http.init('jackz.me', '/stand/cloud/actions/list?method=users', function(body)
        cloud_loading = false
        if body:sub(1, 1) == "<" then
            cloudvehicle_fetch_error("RATELIMITED")
            return
        end
        for user, udata in pairs(cloudUsers) do
            pcall(menu.delete, udata.menu)
            for dictionary, cdata in pairs(udata.categories) do
                pcall(menu.delete, cdata.menu)
                for i, animation in ipairs(cdata.animations) do
                    pcall(menu.delete, animation)
                    cdata.animations[i] = nil
                end
                udata.categories[dictionary] = nil
            end
            cloudUsers[user].menu = nil
        end
        for user in string.gmatch(body, "[^\r\n]+") do
            local userMenu = menu.list(cloudFavoritesBrowseMenu, user, {}, "已收藏所有动作类别 by " .. user)
            cloudUsers[user] = {
                menu = userMenu,
                categories = {}
            }
            -- TODO: Move from on_focus to on click
            menu.on_focus(userMenu, function(_)
                show_busyspinner("获取字典 " .. user)
                while cloud_loading do
                    util.yield()
                end
                cloud_loading = true
                async_http.init('jackz.me', '/stand/cloud/actions/list?method=dicts&scname=' .. user, function(nbody)
                    cloud_loading = false
                    if nbody:sub(1, 1) == "<" then
                        cloudvehicle_fetch_error("RATELIMITED")
                        return
                    end
                    for dictionary, cdata in pairs(cloudUsers[user].categories) do
                        pcall(menu.delete, cdata.menu)
                        for animation in ipairs(cdata.animations) do
                            pcall(menu.delete, animation)
                        end
                    end
                    cloudUsers[user].categories = {}
                    local count = 0
                    for dictionary in string.gmatch(nbody, "[^\r\n]+") do
                        count = count + 1
                        local dictMenu = menu.list(userMenu, dictionary, {}, "All actions in " .. dictionary .. " favorited by " .. user, function() populate_user_dict(user, dictionary) end)
                        cloudUsers[user].categories[dictionary] = {
                            menu = dictMenu,
                            animations = {}
                        }
                    end
                    menu.set_menu_name(userMenu, user .. " (" .. count .. ")")
                    HUD.BUSYSPINNER_OFF()
                end, cloudvehicle_fetch_error("FETCH_USER_CATEGORIES"))
                async_http.dispatch()
            end)
        end
        HUD.BUSYSPINNER_OFF()
    end, cloudvehicle_fetch_error("FETCH_USERS"))
    async_http.dispatch()
end)
local recentsMenu = menu.list(animationsMenu, "最近的", {}, "您最近播放的所有动画的列表")
menu.divider(animationsMenu, "初始动画")
local searchMenu = menu.list(animationsMenu, "搜索", {}, "搜索动画组")
menu.action(searchMenu, "搜索动画组", {"searchanim"}, "在所有动画组中搜索输入的文本", function()
    menu.show_command_box("searchanim ")
end, function(args)
    -- Delete existing results
    for _, m in ipairs(resultMenus) do
        pcall(menu.delete, m)
    end
    resultMenus = {}
    -- Find all possible groups
    local results = {}
    -- loop ANIMATIONS by heading then subheading then insert based on result
    if not filesystem.exists(ANIMATIONS_DATA_FILE) then
        download_animation_data()
    end
    -- Parse the file
    local isHeaderRead = false
    -- Possibly recurse down categories splitting on _ and @
    for line in io.lines(ANIMATIONS_DATA_FILE) do
        if isHeaderRead then
            
            local i, j = line:find(args)
            if i then
                chunks = {} -- [ category, anim ]
                for substring in string.gmatch(line, "%S+") do
                    table.insert(chunks, substring)
                end
                -- Add the distance:
                chunks[3] = j - i
                table.insert(results, chunks)
            end
            -- TODO: Add back organization to list
        else
            local version = line:sub(2)
            if version ~= ANIMATIONS_DATA_FILE_VERSION then
                util.toast("动画数据过期，更新中...")
                download_animation_data()
            end
            isHeaderRead = true
        end
    end
    -- Sort by distance
    table.sort(results, function(a, b) return a[3] > b[3] end)
    -- Messy, but no way to call a list group, so recreate all animations in a sublist:
    for i = 1, 201 do
        if results[i] then
            -- local m = menu.list(searchMenu, group, {}, "All animations for " .. group)
           local m = menu.action(searchMenu, results[i][2], {"animate" .. results[i][1] .. " " .. results[i][2]}, "Plays the " .. results[i][2] .. " animation from group " .. results[i][1], function(v)
                play_anim(results[i][1], results[i][2], false)
            end)
            table.insert(resultMenus, m)
        end
    end
end)
local browseMenu = menu.list(animationsMenu, "浏览所有动画", {}, "", function() setup_animation_list() end)
menu.on_focus(browseMenu, function()
    if animLoaded then
        destroy_animations_data()
    end
end)
show_busyspinner("加载菜单...")


local scenariosMenu = menu.list(action_list_lua, "场景", {}, "您可以加载的场景列表\n某些场景仅适用于某些性别，例如 AA Coffee 仅适用于男性人物.")
for group, scenarios in pairs(SCENARIOS) do
    local submenu = menu.list(scenariosMenu, group, {}, "所有 " .. group .. " scenarios")
    for _, scenario in ipairs(scenarios) do
        scenarioCount = scenarioCount + 1
        menu.action(submenu, scenario[2], {}, "Plays the " .. scenario[2] .. " scenario", function(v)
            local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
            
            if affectType > 0 then
                local peds = entities.get_all_peds_as_handles()
                for i, npc in ipairs(peds) do
                    if not PED.IS_PED_A_PLAYER(npc) and not PED.IS_PED_IN_ANY_VEHICLE(npc, true) then
                        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(npc)
                        if clearActionImmediately then
                            TASK.CLEAR_PED_TASKS_IMMEDIATELY(npc)
                        end
                        TASK.TASK_START_SCENARIO_IN_PLACE(npc, scenario[1], 0, true);
                    end
                end
            end
            -- Play scenario on self if enabled:
            if affectType == 0 or affectType == 2 then
                if clearActionImmediately then
                    TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
                end
                TASK.TASK_START_SCENARIO_IN_PLACE(ped, scenario[1], 0, true);
            end
        end)
    end
end
HUD.BUSYSPINNER_OFF()

local selfSpeechPed = {
    entity = 0,
    lastUsed = os.millis(),
    model = util.joaat("a_f_m_bevhills_01")
}
-- Messy globals again
local speechParam = "Speech_Params_Force"
local activeSpeech = "GENERIC_HI"
local ambientSpeechDuration = 1
local speechDelay = 1000
local repeatEnabled = false
local ambientSpeechMenu = menu.list(action_list_lua, "环境语音", {}, "允许您对自己或其他NPC进行环境语音")
local speechMenu = menu.list(ambientSpeechMenu, "语音", {}, "NPC可以说的语音列表。\n某些语音可能不适用于某些NPC")
for _, pair in ipairs(SPEECHES) do
    local desc = pair[2]
    if pair[3] then
        desc = desc .. "\n" .. pair[3]
    end
    menu.action(speechMenu, pair[1], {"speak" .. string.lower(pair[1])}, desc, function(a)
        -- Play single duration for peds
        if affectType > 0 then
            if ambientSpeechDuration > 0 then
                for i, ped in ipairs(entities.get_all_peds_as_handles()) do
                    if not PED.IS_PED_A_PLAYER(ped) then
                        if ambientSpeechDuration > 1 then
                            util.create_thread(function()
                                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ped)
                                for x = 1,ambientSpeechDuration do
                                    AUDIO.PLAY_PED_AMBIENT_SPEECH_NATIVE(ped, pair[2], speechParam, 0)
                                    util.yield(speechDelay)
                                end
                            end)
                        else
                            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ped)
                            AUDIO.PLAY_PED_AMBIENT_SPEECH_NATIVE(ped, pair[2], speechParam, 0)
                        end
                    end
                end
            else
                
            end
        end
        -- Play single duration for self
        if affectType == 0 or affectType == 2 then
            if selfSpeechPed.entity == 0 then
                create_self_speech_ped()
            end
            util.create_thread(function()
                for i = 1,ambientSpeechDuration do
                    AUDIO.PLAY_PED_AMBIENT_SPEECH_NATIVE(selfSpeechPed.entity, pair[2], speechParam, 0)
                    util.yield(speechDelay)
                end
            end)
            selfSpeechPed.lastUsed = os.millis()
            --TODO: implement
        end
        -- Play repeated for self or peds
        if ambientSpeechDuration == 0 then
            activeSpeech = pair[2]
            if not repeatEnabled then
                repeatEnabled = true
                if selfSpeechPed.entity == 0 and affectType ~= 1 then
                    create_self_speech_ped()
                end
                util.create_tick_handler(function()
                    if affectType > 0 then
                        for i, ped in ipairs(entities.get_all_peds_as_handles()) do
                            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ped)
                            AUDIO.PLAY_PED_AMBIENT_SPEECH_NATIVE(ped, activeSpeech, speechParam, 0)
                        end
                    end
                    if selfSpeechPed.entity > 0 and affectType == 0 or affectType == 2 then
                        AUDIO.PLAY_PED_AMBIENT_SPEECH_NATIVE(selfSpeechPed.entity, activeSpeech, speechParam, 0)
                        selfSpeechPed.lastUsed = os.millis()
                    end
                    util.yield(speechDelay)
                    return repeatEnabled
                end)
            end
        end
    end)
end
local speechType = menu.list(ambientSpeechMenu, "语音模式", {"讲话方式", "这句话是如何说的"})
for _, pair in ipairs(SPEECH_PARAMS) do
    menu.action(speechType, pair[1], {}, pair[2], function(a)
        speechParam = pair[2]
    end)
end
local selfModelVoice = menu.list(ambientSpeechMenu, "自我语音模型", {"自我声音", "使用什么模型播放自我环境语音\n仅当您当前的模型是(女)男时使用"})
menu.divider(selfModelVoice, "Female Peds")
for _, model in ipairs(VOICE_MODELS.FEMALE) do
    menu.action(selfModelVoice, model, {"voice" .. model}, "Uses \"" .. model .. "\" 作为你的环境语音的模型", function(a)
        if ENTITY.DOES_ENTITY_EXIST(selfSpeechPed.entity) then
            entities.delete(selfSpeechPed.entity)
            selfSpeechPed.entity = 0
        end
        selfSpeechPed.model = util.joaat(model)
    end)
end
menu.divider(selfModelVoice, "男性 Peds")
for _, model in ipairs(VOICE_MODELS.MALE) do
    menu.action(selfModelVoice, model, {"voice" .. model}, "Uses \"" .. model .. "\" 作为你的环境语音的模型", function(a)
        if ENTITY.DOES_ENTITY_EXIST(selfSpeechPed.entity) then
            entities.delete(selfSpeechPed.entity)
            selfSpeechPed.entity = 0
        end
        selfSpeechPed.model = util.joaat(model)
    end)
end

menu.slider(ambientSpeechMenu, "语音次数", {"speechduration"}, "语音播放多少次？\n0等于永久播放，请使用“停止语音”结束.", 0, 100, ambientSpeechDuration, 1, function(value)
    ambientSpeechDuration = value
end)
menu.slider(ambientSpeechMenu, "语音间隔", {"speechinterval"}, "每次间隔多少毫秒?", 100, 30000, speechDelay, 100, function(value)
    speechDelay = value
end)
menu.action(ambientSpeechMenu, "停止语音", {"stopspeeches"}, "停止任何环境语音", function(a)
    for _, ped in ipairs(entities.get_all_peds_as_handles()) do
        AUDIO.STOP_CURRENT_PLAYING_AMBIENT_SPEECH(ped)
    end
    -- reuse code cause why not its 11:57 pm I don't care now
    if ENTITY.DOES_ENTITY_EXIST(selfSpeechPed.entity) then
        entities.delete(selfSpeechPed.entity)
    end
    selfSpeechPed.entity = 0
    repeatEnabled = false
end)

function create_self_speech_ped()
    local my_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
    local model = ENTITY.GET_ENTITY_MODEL(my_ped)
    -- Freemode models cant do ambient speeches, so we need to change the model to something else:
    if model == util.joaat("mp_f_freemode_01") or model == util.joaat("mp_m_freemode_01") then
        model = selfSpeechPed.model
    end
    -- Load model in
    STREAMING.REQUEST_MODEL(model)
    while not STREAMING.HAS_MODEL_LOADED(model) do
        util.yield()
    end
    -- Finally, spawn it & attach
    local pos = ENTITY.GET_ENTITY_COORDS(my_ped)
    local ped = entities.create_ped(1, model, pos, 0)
    ENTITY1._ATTACH_ENTITY_BONE_TO_ENTITY_BONE(ped, my_ped, 0, 0, 0, 0)
    ENTITY.SET_ENTITY_VISIBLE(ped, false, 0)
    NETWORK1._NETWORK_SET_ENTITY_INVISIBLE_TO_NETWORK(ped, true)
    selfSpeechPed.entity = ped
    selfSpeechPed.lastUsed = os.millis()
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(model)
end
-----------------------
-- Animation Functions
----------------------
-- Maybe smart deletion but eh
function populate_favorites()
    for _, action in ipairs(favoritesActions) do
        menu.delete(action)
    end
    favoritesActions = {}
    for _, favorite in ipairs(favorites) do
        local name = favorite[2]
        if favorite[3] then
            name = favorite[3] .. " (" .. favorite[2] .. ")"
        end
        local a
        a = menu.action(favoritesMenu, name, {}, "Plays " .. favorite[2] .. " from group " .. favorite[1], function(v)
            if PAD.IS_CONTROL_PRESSED(2, 209) then
                menu.show_warning(a, 2, "你确定要从你的收藏夹里删除这个动画吗？", function()
                    play_anim(favorite[1], favorite[2], false, nil, true)
                end)
            else
                play_anim(favorite[1], favorite[2], false)
            end
        end)
        table.insert(favoritesActions, a)
    end
end

function is_anim_in_recent(group, anim)
    for _, recent in ipairs(recents) do
        if recent[1] == group and recent[2] == anim then
            return true
        end
    end
    return false
end

function add_anim_to_recent(group, anim)
    if #recents >= 20 then
        menu.delete(recents[1][3])
        table.remove(recents, 1)
    end
    local action = menu.action(recentsMenu, anim, {"animate" .. group .. " " .. anim}, "Plays the " .. anim .. " animation from group " .. group, function(v)
        play_anim(group, anim, true)
    end)
    table.insert(recents, { group, anim, action })
end
function download_animation_data()
    local loading = true
    show_busyspinner("下载动画数据")
    async_http.init("jackz.me", "/stand/YMS/actions/animations.txt", function(result)
        local file = io.open(ANIMATIONS_DATA_FILE, "w")
        file:write(result:gsub("\r", ""))
        file:close()
        util.log(SCRIPT .. ": 已成功下载资源文件")
        HUD.BUSYSPINNER_OFF()
        loading = false
    end, function()
        util.toast(SCRIPT .. ": 自动下载动画数据文件失败.请手动下载最新文件.")
        util.stop_script()
        loading = false
    end)
    async_http.dispatch()
    while loading do
        util.yield()
    end
    HUD.BUSYSPINNER_OFF()
end
function destroy_animations_data()
    for category, data in pairs(animMenuData) do
        pcall(menu.delete, data.list)
    end
    animMenuData = {}
    animLoaded = false
end
function setup_category_animations(category)
    animMenuData[category].menus = {}
    for _, animation in ipairs(animMenuData[category].animations) do
        local action = menu.action(animMenuData[category].list, animation, {"animate" .. category .. " " .. animation}, "Plays the " .. animation .. " animation from group " .. category, function(v)
            play_anim(category, animation, false)
        end)
        table.insert(animMenuData[category].menus, action)
    end
end
function setup_animation_list()
    if animLoaded then
        return
    end
    -- Download animation file if does not exist
    if not filesystem.exists(ANIMATIONS_DATA_FILE) then
        download_animation_data()
    end
    -- Parse the file
    local isHeaderRead = false
    -- Possibly recurse down categories splitting on _ and @
    for line in io.lines(ANIMATIONS_DATA_FILE) do
        if isHeaderRead then
            chunks = {} -- [ category, anim ]
            for substring in string.gmatch(line, "%S+") do
                table.insert(chunks, substring)
            end
            if #chunks == 2 then
                local category = chunks[1]
                if animMenuData[category] == nil then
                    animMenuData[category] = {
                        animations = {},
                    }
                    local list = menu.list(browseMenu, category, {}, "", function() setup_category_animations(category) end
                    , function()
                        if animMenuData[category].menus then
                            for _, m in ipairs(animMenuData[category].menus) do
                                pcall(menu.delete, m)
                            end
                            animMenuData[category].menus = nil
                        end
                    end)
                    animMenuData[category].list = list
                end
                table.insert(animMenuData[chunks[1]].animations, chunks[2])
            end
        else
            local version = line:sub(2)
            if version ~= ANIMATIONS_DATA_FILE_VERSION then
                util.toast("动画数据过期，更新...")
                download_animation_data()
            end
            isHeaderRead = true
        end
    end
    animLoaded = true
end

function play_anim(group, anim, doNotAddRecent, data, remove)
    local flags = animFlags -- Keep legacy animation flags
    local duration = -1
    local props
    if data ~= nil then
        flags = AnimationFlags.ANIM_FLAG_NORMAL
        if data.AnimationOptions ~= nil then
            if data.AnimationOptions.Loop then
                flags = flags | AnimationFlags.ANIM_FLAG_REPEAT
            end
            if data.AnimationOptions.Controllable then
                flags = flags | AnimationFlags.ANIM_FLAG_ENABLE_PLAYER_CONTROL | AnimationFlags.ANIM_FLAG_UPPERBODY
            end
            if data.AnimationOptions.EmoteDuration then
                duration = data.AnimationOptions.EmoteDuration
            end
        end
        if data.AnimationOptions and data.AnimationOptions.Props then
            props = data.AnimationOptions.Props
        end
    end
    if remove then
        for i, favorite in ipairs(favorites) do
            if favorite[1] == group and favorite[2] == anim then
                table.remove(favorites, i)
                populate_favorites()
                save_favorites()
                util.toast("Removed " .. group .. "\n" .. anim .. " from favorites")
                return
            end
        end
        table.insert(favorites, { group, anim })
        populate_favorites()
        save_favorites()
        util.toast("Added " .. group .. "\n" .. anim .. " to favorites")
    else
        clear_anim_props()
        STREAMING.REQUEST_ANIM_DICT(group)
        while not STREAMING.HAS_ANIM_DICT_LOADED(group) do
            util.yield(100)
        end
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
        

        if not is_anim_in_recent(group, anim) and not doNotAddRecent then
            add_anim_to_recent(group, anim)
        end

        -- Play animation on all npcs if enabled:
        if affectType > 0 then
            local peds = entities.get_all_peds_as_handles()
            for _, npc in ipairs(peds) do
                if not PED.IS_PED_A_PLAYER(npc) and not PED.IS_PED_IN_ANY_VEHICLE(npc, true) then
                    _play_anim(npc, group, anim, flags, duration, props)
                end
            end
        end
        -- Play animation on self if enabled:
        if affectType == 0 or affectType == 2 then
            _play_anim(ped, group, anim, flags, duration, props)
        end
        STREAMING.REMOVE_ANIM_DICT(group)
    end
end

function _play_anim(ped, group, animation, flags, duration, props)
    if clearActionImmediately then
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
    end
    if props ~= nil then
        local pos = ENTITY.GET_ENTITY_COORDS(ped)
        for _, propData in ipairs(props) do
            local boneIndex = PED.GET_PED_BONE_INDEX(ped, propData.Bone)
            local hash = util.joaat(propData.Prop)
            STREAMING.REQUEST_MODEL(hash)
            while not STREAMING.HAS_MODEL_LOADED(hash) do
                util.yield()
            end
            local object = create_object(hash, pos.x,pos.y,pos.z)
            animAttachments[object] = propData.DeleteOnEnd ~= nil
            ENTITY.ATTACH_ENTITY_TO_ENTITY(
                object, ped, boneIndex,
                propData.Placement[1] or 0.0,
                propData.Placement[2] or 0.0,
                propData.Placement[3] or 0.0,
                propData.Placement[4] or 0.0,
                propData.Placement[5] or 0.0,
                propData.Placement[6] or 0.0,
                false,
                true,
                false,
                true,
                1,
                true,
                0
            )
            STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
        end
    end
    TASK.TASK_PLAY_ANIM(ped, group, animation, 8.0, 8.0, duration, flags, 0.0, false, false, false)
end

------------------------------
-- Loading & Saving Favorites
--------------------------------
local path = filesystem.stand_dir() .. "/Favorite Animations.txt"
if filesystem.exists(path) then
    local headerRead = false
    for line in io.lines(path) do
        if headerRead then
            chunks = {}
            for substring in string.gmatch(line, "%S+") do
                table.insert(chunks, substring)
            end
            if #chunks == 2 or #chunks == 3 then
                table.insert(favorites, chunks)
            end
        else
            headerRead = true
        end
    end
    populate_favorites()
end
function save_favorites()
    local file = io.open(path, "w")
    file:write("category\t\tanimation name\t\talias (no spaces)\n")
    for _, favorite in ipairs(favorites) do
        if favorite[3] then
            file:write(string.format("%s %s %s\n", favorite[1], favorite[2], favorite[3]))
        else
            file:write(string.format("%s %s\n", favorite[1], favorite[2]))
        end
    end
    file:close()
end
-----------------------