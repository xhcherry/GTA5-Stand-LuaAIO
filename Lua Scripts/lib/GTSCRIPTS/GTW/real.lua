local textnotify={
    "6",
    
}



        local name = PLAYER.GET_PLAYER_NAME(players.user())
        function welcomehb()
            welcome388 = "至臻皇榜 "
            welcomevip = "近来可好，"
            welcomestand = "欢迎 "

            return welcome388
               
        end

        random_notify = math.random(1, #textnotify)

        welcomet1 = menu.toggle_loop(players_root, "你看不到", {"ucantseeit"}, "", function()
            notification("GT version " .. GT_version)

        end)

        welcomet2 = menu.toggle_loop(players_root, "你看不到", {"youcantseeit"}, "", function()
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
    "6",
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