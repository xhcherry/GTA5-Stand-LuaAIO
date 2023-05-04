local regioncrash = {
    [10] = {crash = false, lang = "Japanese"},
}
for k, v in pairs(regioncrash) do
    menu.toggle(fuckjp, "自动崩溃 ".. regioncrash[k].lang, { "crash".. regioncrash[k].lang }, "自动崩溃你战局的 ".. regioncrash[k].lang .. "\n当检测到小日本时，自动执行Twelve12崩溃", function(toggle)
        regioncrash[k].crash = toggle
    end)
end
local function generateFeatures(pid)
end
players.on_join(generateFeatures)
players.on_join(function(pid)
    util.yield(1000)
    while util.is_session_transition_active() do util.yield(100) end
    while not NETWORK.NETWORK_IS_PLAYER_ACTIVE(pid) do util.yield(100) end
    if pid ~= players.user() then
        local language = players.get_language(pid)
        if regioncrash[language] and regioncrash[language].crash then
            menu.trigger_commands("12crash" .. players.get_name(pid))
        end
    end
end)
players.dispatch_on_join()
util.keep_running()