starhb = "你已经是至臻皇榜用户\n享受所有皇榜的特权,以及:\n至臻皇榜横幅 两倍显示时间\n个性化名称缀与皇榜横幅\n参加GTLua Beta测试\n极夜(虚空)入群欢迎语\n可使用GTLua内独有功能\n无限制的至臻皇榜资格\n至臻皇榜用户参与周边抽奖\n优先获得问题解答"
imhb = "您已经是皇榜成员\n以下特权已激活:\n战局横幅提示(其他GTVIP用户)\n免疫GTVIP用户脚本攻击\nVIP特有脚本名称显示\n可被选中为随机幸运人\n免密码启动脚本\n皇榜专属独家功能\nStand+2Take1双资格皇榜\n可无限增加多个游戏ID"
hbinfo = "现在加入皇榜，即刻生效，无需等待\n加入皇榜可享受以下特权:\n战局横幅提示(其他GTVIP用户)\n免疫其他GTVIP用户的脚本攻击\n获得VIP功能与立刻加入VIP群聊 若您是卡网经销商,可免费加入GTVIP认证经销商列表\n联系QQ(1114983012/820104093)"
function checkme()
    local master = "  Ultra StatTrak™"
    local vip388 = "  Ultra StatTrak™"
    local vipme = "  GTLua Pro "..GT_version
    local standard = "StatTrak™ GTLua"
    local name = SOCIALCLUB.SC_ACCOUNT_INFO_GET_NICKNAME()
    
    if name == "RhymeBe2ar" then
        return master
    elseif name == "RcktaR" then
        return "    qianzongGol"
    elseif name == "zqxhnb" then
        return "  Huntsman VIP"
    elseif name == "Cheng1073" then 
        return "   Stupid Cheng"
    elseif name == "rudan891018" then 
        return "   rudan 891018"
    elseif name == "An_owQ" then
        return"   An_owQ Baby"
    elseif name == "Shimumu999" then
        return "Karry Handsome"
    elseif name == "KIHPUNG" then
        return " WuHuQiFei VIP"
    elseif name == "GTlxiao" then
        return "  Hu Handsome"
    elseif name == "Nimalegebi-00" then
        return "    OLDDOG VIP"
    elseif name == "tNaovo" then 
        return "Esclusive tNaovo"
    elseif name == "SmallGodGirlo3o" then
        return "SmallGodGirlo3o"
    elseif name == "Twelve___12" then 
        return " Twelve 12 Baby"
    elseif name == "Brook-Hill" then 
        return "Strawberry Sister"
    elseif name == "05L5" then
        return "  7SkyK1ng 05L5"
    elseif name == "XiaoYuXin_qwq" then
        return "Happy Every Day"
    elseif name == "Mag7777V" or name == "Magicswordstar" then
        return " Magicswordstar"
    elseif name == "HaOooo25" then
        return "  HaOooo25"
    else
        
        for _,id in ipairs(sxid) do
            if name == id.playeridx then
                return vip388
            end
        end

        for _, id in ipairs(spid) do
            if name == id.playerid then
                return vipme
            end
        end

        return standard

    end
end

-- 定义是不是皇榜的玩家
local name = SOCIALCLUB.SC_ACCOUNT_INFO_GET_NICKNAME()
isSpidPlayer = false



        if isSpidPlayer then
            loading_frames = {} -- 清空普通玩家显示的loading_frames内容
        else -- 为普通玩家仍然显示普通内容
            loading_frames = {'', 'G', 'GR', 'GRA', 'GRAN', 'GRAND', 'GRANDT', 'GRANDTO', 'GRANDTOU', 'GRANDTOUR',
                              'GRANDTOURI', 'GRANDTOURIN', 'GRANDTOURING', 'GRANDTOURINGV', 'GRANDTOURINGVI',
                              'GRANDTOURINGVIP', 'GRANDTOURINGVIP', 'GRANDTOURING', 'GRAND', '', 'GRANDTOURINGVIP', '',
                              'GRANDTOURINGVIP', '', 'GRANDTOURINGVIP', '', 'GRANDTOURINGVIP', 'GRANDTOURINGVIP',
                              'GRANDTOURINGVIP', 'GRANDTOURINGVIP', 'GRANDTOURINGVIP', 'GRANDTOURINGVIP',
                              'GRANDTOURINGVIP'}
        end

        numRepeats = 15
        checkmeInterval = 1
        count = 0

        checkmeResult = "" -- 空白闪烁
        checkmeLength = 0 -- 闪烁间隙

        for _, id in ipairs(spid) do
            if name == id.playerid then
                loading_frames = {} -- 删除原有值
                checkmeResult = checkme()
                checkmeLength = string.len(checkmeResult)
                break -- 搜索结束，可以正常显示
            end
        end

        displayedLength = 0 -- 每个字符显示的空格

        -- 逐个显示字符
        for _, id in ipairs(spid) do
            if name == id.playerid then
                for i = 1, numRepeats do
                    if displayedLength < checkmeLength then
                        displayedLength = displayedLength + 1
                        table.insert(loading_frames, checkmeResult:sub(1, displayedLength))
                    end
                end
            end
        end

        displayedLength2 = 4
        for _, id in ipairs(spid) do
            if name == id.playerid then
                local numRepeats = 5
                for i = 1, numRepeats do
                    if displayedLength2 < checkmeLength then
                        displayedLength2 = displayedLength2 - 5
                        table.insert(loading_frames, checkmeResult:sub(1, displayedLength2))
                    end
                end
            end
        end

        blinkCount = 10 -- 假设闪烁10次

        -- 在这两秒钟内闪烁已完成的字符内容
        for _, id in ipairs(spid) do
            if name == id.playerid then
                for i = 1, blinkCount do
                    if i % 2 == 0 then
                        -- 偶数次闪烁，显示空字符
                        table.insert(loading_frames, '')
                    else
                        -- 奇数次闪烁，显示已完成的字符内容
                        table.insert(loading_frames, checkmeResult)
                    end
                end
            end
        end
        -- 在最后一秒停顿，以让玩家完整的看到内容
        for _, id in ipairs(spid) do
            if name == id.playerid then
                for i = 1, 10 do
                    table.insert(loading_frames, checkmeResult)
                end
            end
        end

