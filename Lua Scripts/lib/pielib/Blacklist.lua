----黑名单表
blacklist={"1111",-----测试黑名单,发布时删除
    "jiangling6998",------江陵,盗版lua作者(jiangling lua),呼吁大家抵制盗版,因为正版也不收费
    "",
    ""
}

function Black_list()
    -----检测到战局有黑名单直接踢
    for pid = 0, 31 do
        Blacklist_player = players.get_name(pid)
            for i = 1, #blacklist do
                if blacklist[i] == Blacklist_player then
                    util.toast("检测到黑名单玩家: "..Blacklist_player.."\n已执行踢出")
                    menu.trigger_commands("kick " .. Blacklist_player)
                end
            end
    end
end
function Black_self()
    -----检测到使用者存在于黑名单直接闪退游戏
    Blacklist_self = players.get_name(players.user())
    for i = 0, #blacklist do
        if blacklist[i] == Blacklist_self then
                os.exit() 
                --此为闪退游戏内容,测试时务必隐藏此句,以免游戏闪退(发布时开启)
        end
    end
end