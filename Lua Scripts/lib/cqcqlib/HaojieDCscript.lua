util.require_natives(1663599433)
local loop = false

util.toast("去他妈的鲨鱼卡!!!")

menu.action(HaojieDC, "前往名钻豪华赌场!", {"tpcasino"}, "", function(click_type)
    ENTITY.SET_ENTITY_COORDS(players.user_ped(), 924.5333, 46.603252, 81.10639 , 1, 0, 0, 1)
end)

menu.action(HaojieDC, "前往钻石赌博区!", {"tpslot"}, "闪闪发光!", function(click_type)
    math.randomseed()
    math.random()
    math.random()
    math.random()
    local r = math.random(1,3)
    if(r == 1) then
        ENTITY.SET_ENTITY_COORDS(players.user_ped(), 1113.7837, 239.45398, -49.84081 , 1, 0, 0, 1)
    elseif (r==2) then
        ENTITY.SET_ENTITY_COORDS(players.user_ped(), 1116.7186, 228.10817, -49.84075 , 1, 0, 0, 1)
    elseif (r==3) then
        ENTITY.SET_ENTITY_COORDS(players.user_ped(), 1137.0839, 252.51076, -51.035732 , 1, 0, 0, 1)
    end
end)

menu.action(HaojieDC, "前往出纳员!", {"tpcashier"}, "去拿你辛苦工作的报酬吧!", function(click_type)
    ENTITY.SET_ENTITY_COORDS(players.user_ped(), 1116.0076, 219.90002, -49.435116 , 1, 0, 0, 1)
end)

menu.action(HaojieDC, "循环赌博", {"startcasinoloop"}, "自动赢得老虎机头奖和离开老虎机: 这样你就不会触发赌场冷却时间. 建议用鼠标自动点击器挂机赚钱", function(click_type)
    loop = not loop
    util.show_corner_help("欢迎来到高端人士交际圈! 一定要下最大赌注.")
    while(loop) do
        menu.trigger_commands("rigslotmachines jackpot")
        for i=1,100 do 
            util.show_corner_help("回合获胜")
            util.yield(100)
        end
        menu.trigger_commands("rigslotmachines loss")
        for i=1,100 do 
            util.show_corner_help("回合输了")
            util.yield(100)
        end
    end
    util.toast("再见! 希望你赚了很多钱!")
end)

menu.action(HaojieDC, "俄罗斯轮盘", {"roulette"}, "带你去俄罗斯轮盘,把它调到1.在第一张12上下注50k,在第一张1上下注5k", function(click_type)
    ENTITY.SET_ENTITY_COORDS(players.user_ped(), 1133.4238, 263.72913, -51.03577 , 1, 0, 0, 1)
    menu.trigger_commands("rigroulette 1")
end)

    menu.action(HaojieDC, "~~随机传送~~", {"randomtp"}, "*使用自担风险* 可能会让你在地图或其他奇怪的东西下生成", function(click_type)
        local x,y,z,distToGround, currentHeight
        math.randomseed()
        math.random()
        math.random()
        math.random()
        x = math.random(-3430, 4130)
        y = math.random(-3560, 8000)
        menu.trigger_commands("posx "..x)
        menu.trigger_commands("posy "..y)
        menu.trigger_commands("posz "..ENTITY.GET_ENTITY_HEIGHT_ABOVE_GROUND(players.user_ped()))
end)