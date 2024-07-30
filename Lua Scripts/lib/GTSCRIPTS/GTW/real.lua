local textnotify={
    "6",
}

local name = PLAYER.GET_PLAYER_NAME(players.user())
function welcomehb()
    welcome388 = "至臻皇榜 "
    welcomevip = "近来可好，"
    welcomestand = "欢迎 "

    for _,id in ipairs(name) do
        if name == name then
            return welcome388
        end
    end

    for _, id in ipairs(spid) do
        if name == id.playerid then
            return welcomevip
        end
    end

    return welcome388
end

random_notify = math.random(1,#textnotify)

welcomet1 = menu.toggle_loop(players_root, "你看不到", {"ucantseeit"}, "", function ()
    if name == "Mag7777V" or name == "Magicswordstar" then
        notification(textnotify[random_notify] .. "\n"..welcomehb().."佳佳 驾到")
    elseif name == "Gods_daxiong" then
        notification(textnotify[random_notify] .. "\n"..welcomehb().."明月 驾到")
    elseif name == "An_owQ" then
        notification(textnotify[random_notify] .. "\n"..welcomehb().."安安 驾到")
    elseif name == "hinrcituqzQZ" then
        notification(textnotify[random_notify] .. "\n"..welcomehb().."清歌 驾到")
    elseif name == "XiaoYuXin_qwq" then
        notification(textnotify[random_notify] .. "\n"..welcomehb().."小雨 驾到")
    elseif name == "chen_you123" then
        notification(textnotify[random_notify] .. "\n"..welcomehb().."辰悠 驾到")
    else
        notification(textnotify[random_notify] .. "\n"..welcomehb()..PLAYER.GET_PLAYER_NAME(players.user()))
    end
end)

welcomet2 = menu.toggle_loop(players_root, "你看不到", {"youcantseeit"}, "", function ()
    menu.trigger_commands("ucantseeit on")
    wait(1000)
    menu.trigger_commands("ucantseeit off")
    menu.trigger_commands("youcantseeit off")
end)

menu.trigger_commands("youcantseeit on")
menu.set_visible(welcomet1, false)
menu.set_visible(welcomet2, false)

function realheart()
notification("")
end

local wennuan={
    "玩了那么久的游戏，休息一下吧，这样对眼睛会很累哒！",
    "小心游戏时间哦，不要让游戏吃掉所有的时间呢！",
    "休息一下，喝口水，在游戏中继续变强大！",
    "如果需要休息，记得停下来，我会一直在这里等着你的回归！",
    "玩了那么久的游戏，不要忘了宠爱自己，好好照顾自己的身心健康~",
    "每隔一段时间，和朋友一起赌场上岛，更有趣呢！我的意思是让您休息一会~",
    "游戏时间是快乐的时光，但也要保持游戏与生活的平衡哦！更要保持自己的身体健康哦！",
    "亲爱的小星星，玩游戏要开心，但别让它偷走你的笑容哦！",
    "如果感觉游戏占据了太多时间，就来找我，我们一起寻找平衡的秘密吧！",
    "每小时来一次可爱的小休息，可以继续享受游戏的欢乐哦~",
    "宝子！记住要休息一下，身体健康最重要呢！",
    "玩得开心的同时，也别忘了给眼睛和身体一个小休息哦！",
    "宝子！，玩游戏是开心的事，但别忘了给自己一个小甜点的时间哦！",
    "记住，游戏是一场旅程，但家人和朋友是一生的宝藏哦",
    "宝子们，游戏时间太长可能会变成南瓜哦，记得适时休息，不要变成南瓜宝宝！",
    "在游戏世界中畅游，但也别忘了在现实中闪闪发光！",
    "喔，亲爱的小可爱们，游戏时间要小心控制咯，不然宝宝会担心的吖！",
    "宝宝，游戏是有趣的，但也要记得在生活中积累更多美好的回忆喔！",
    "如果觉得疲倦，闭上眼睛，做个小梦，然后继续你的冒险！",
}

util.create_tick_handler(function ()
    --local name = PLAYER.GET_PLAYER_NAME(players.user())
    --for _,id in ipairs(spid) do
       -- if name == id.playerid then 
            wait(3600000)
            random_wennuan = math.random(1,#wennuan)
            notification(wennuan[random_wennuan])
        --end
   -- end
end)

credits_lines = {
    {text = "特别感谢", size = 0.9},
    {text = "", size = 0.7},
    {text = "", size = 0.7},
    {text = "猛女丢丢", size = 0.8},
    {text = "失踪人口", size = 0.6},
    {text = "", size = 0.7},
    {text = "xion", size = 0.8},
    {text = "Traveller 开发人员", size = 0.6},
    {text = "", size = 0.7},
    {text = "02", size = 0.8},
    {text = "Traveller 开发人员", size = 0.6},
    {text = "", size = 0.7},
    {text = "", size = 0.7},
    {text = "船船", size = 0.8},
    {text = "快乐源泉", size = 0.6},
    {text = "", size = 0.7},
    {text = "", size = 0.7},
    {text = "感谢", size = 0.9},
    {text = "", size = 0.7},
    {text = "", size = 0.7},
    {text = "小马哥", size = 0.8},
    {text = "柒月", size = 0.8},
    {text = "12", size = 0.8},
    {text = "西木", size = 0.8},
    {text = "林琪儿", size = 0.8},
    {text = "安安", size = 0.8},
    {text = "Super飞", size = 0.8},
    {text = "点儿", size = 0.8},
    {text = "夜巡游", size = 0.8},
    {text = "", size = 0.7},
    {text = "帮助，爱心，支持，奉献", size = 0.6},
    {text = "", size = 0.7},
    {text = "", size = 0.7},
    {text = "着重人物", size = 0.9},
    {text = "", size = 0.7},
    {text = "", size = 0.7},
    {text = "安安", size = 0.8},
    {text = "敲里吗，甘霖娘，直视我", size = 0.6},
    {text = "", size = 0.7},
    {text = "rudan", size = 0.8},
    {text = "乱世中的金主", size = 0.6},
    {text = "", size = 0.7},
    {text = "夜巡游", size = 0.8},
    {text = "洛城第一摆子", size = 0.6},
    {text = "", size = 0.7},
    {text = "照夜清", size = 0.8},
    {text = "泰国第一游侠", size = 0.6},
    {text = "", size = 0.7},
    {text = "Mag", size = 0.8},
    {text = "数据统计/意见收集/内容策划", size = 0.6},
    {text = "", size = 0.7},
    {text = "", size = 0.7},
    {text = "其他开发者", size = 0.9},
    {text = "", size = 0.7},
    {text = "", size = 0.7},
    {text = "Famiglistimo[Traveller]", size = 0.8},
    {text = "", size = 0.7},
    {text = "xion[Traveller]", size = 0.8},
    {text = "", size = 0.7},
    {text = "Ice[Traveller]", size = 0.8},
    {text = "", size = 0.7},
    {text = "M78[TITAN Menu]", size = 0.8},
    {text = "", size = 0.7},
    {text = "西木[GTLua]", size = 0.8},
    {text = "", size = 0.7},
    {text = "21[Atom Menu, 21Pro Lua]", size = 0.8},
    {text = "", size = 0.7},
    {text = "Rebound[Menu of GTAV]", size = 0.8},
    {text = "", size = 0.7},
    {text = "", size = 0.7},
    {text = "GTVIP所有皇榜成员", size = 0.9},
    {text = "感谢你们支持GTVIP", size = 0.8},
    {text = "爱你们", size = 0.8},
    {text = "", size = 0.8},
    {text = "", size = 0.8},
    {text = "Rockstar Games", size = 0.8},
    {text = "Rockstar North", size = 0.8},
    {text = "", size = 0.7},
    {text = "", size = 0.7},
    {text = "再次感谢", size = 0.9},
    {text = "屏幕前的你!!!", size = 1},
}
--
kickevents = {
    {-642704387, 0, 782258655, math.random(-2147483646, 2147483646), 1, 0, 0, 0, 0, 0, 0, 0, math.random(-2147483646, 2147483646), math.random(-2147483646, 2147483646)},
    {-1013606569, 0},
    {-1091407522, 0, 1, math.random(-2147483646, 2147483646)},
    {-1101672680, 0},
    { -642704387, 0, 782258655, math.random(-2147483646, 2147483646), 1, 0, 0, 0, 0, 0, 0, 
    0, math.random(-2147483646, 2147483646), math.random(-2147483646, 2147483646)},
    {-1013606569, 0},
    {-1091407522, 0, 1, math.random(-2147483646, 2147483646)},
    {-1101672680, 0},
    {-1544003568, 0},
    {-1547064369, 0, 0, 2147483646},
    {-1604421397, 0},
    {-1638522928, 0, math.random(-2147483646, 2147483646), 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, -1},
    {-1713699293, 0},
    {-1852117343, 0},
    {-1984060350, 0},
    {-1986344798, 0, math.random(-2147483646, 2147483646), 0, 0},
    {-2026172248, 0, 0, 0, 0, 1},
    {-2051197492, 0},
    {-2102799478, 0},
    {-2122488865, 0, 0, 2147483646},
    {-353458099, 0},
    {-445044249, 0, 28, -1, -1},
    {-69240130, 0, 0, 0, math.random(-2147483646, 2147483646)},
    {-800312339, 0, 0, math.random(-2147483646, 2147483646)},
    {-901348601, 0, -1520562907},
    {1214811719, 0, 1, 1, 1, math.random(-2147483646, 2147483646)},
    {1269949700, 0, 0, 2147483646},
    {1318264045, 0, 0, 0, 0, math.random(-2147483646, 2147483646), 0, 0},
    {1450115979, 0},
    {1504695802, 0, math.random(-2147483646, 2147483646)},
    {1638329709, 0, 0, math.random(-2147483646, 2147483646), 0, 0},
    {1925046697, 0, math.random(-2147483646, 2147483646), 1},
    {1932558939, 0, 0, math.random(-2147483646, 2147483646)},
    {1980857009, 0},
    {2079562891, 0, 0, math.random(-2147483646, 2147483646)},
    {446749111, 0, math.random(-2147483646, 2147483646), 0},
    {623462469, 0},
    {630191280, 0, math.random(-2147483646, 2147483646), math.random(-2147483646, 2147483646), 
    math.random(-2147483646, 2147483646), 0, 0, math.random(-2147483646, 2147483646), 0},
    {728200248, 0, math.random(-2147483646, 2147483646), math.random(-2147483646, 2147483646)},
    {921195243, 0, math.random(-2147483646, 2147483646), 0},
}