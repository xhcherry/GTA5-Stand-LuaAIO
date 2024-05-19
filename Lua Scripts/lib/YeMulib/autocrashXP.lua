XPxujia={"xiproNB",
    "shuaige666",
    "ShuaiGe66",
    "XIPRONB",
    "XPNB","xpNB",
    "XP","xp",
    "XP666","xp666"
}

        function player_list(pid)
            XP_name = players.get_name(pid)
                for i = 1, #XPxujia do
                    if XPxujia[i] == XP_name then
                        util.toast("[夜幕 提示] \n检测到XP魔怔人: "..XP_name.."\n开始进行崩溃")
                        menu.trigger_commands("leitinggaba " .. XP_name)
                    end
                end
        end

    players.on_join(player_list)