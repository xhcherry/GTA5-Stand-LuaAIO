arr={"xiproNB",
    "shuaige666",
    "XIPRONB",
    "XPNB","xpNB",
    "XP","xp",
    "XP666","xp666"
}

        function player_list(pid)
            XP_name = players.get_name(pid)
                for i = 1, #arr do
                    if arr[i] == XP_name then
                        util.toast("[呆呆 提示] \n检测到XP魔怔人: "..XP_name.."\n已执行踢出")
                        menu.trigger_commands("kick " .. XP_name)
                    end
                end
        end

    players.on_join(player_list)