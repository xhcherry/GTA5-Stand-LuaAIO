-----任务选项
perrico_island = menu.list(Heist_Control2, "佩里科岛", {}, "")
    menu.action(perrico_island, "呼叫虎鲸", {}, "", function()--Update tag1.68
        SET_INT_GLOBAL(Global_Base.oVMYCar + 960, 1)--Kosatka
        notification("~y~~bold~呼叫ing~", HudColour.blue)
    end)	   
    TELEPORT_island = menu.list(perrico_island, "地点传送", {}, "")    
        menu.action(TELEPORT_island, "任务面板(虎鲸)", {}, "先呼叫潜艇", function()
            PED.SET_PED_COORDS_KEEP_VEHICLE(PLAYER.PLAYER_PED_ID(), 1561.2369, 385.8771, -49.689915)
        end)
        menu.action(TELEPORT_island, "传送到大门(外侧)", {}, "", function()
            teleport(4974.189, -5703.279, 19.898539)
        end)
        menu.action(TELEPORT_island, "传送到大门(内测)", {}, "", function()
            teleport(4993.189, -5720.279, 19.898539)
        end)
        menu.action(TELEPORT_island, "主要目标", {}, "", function()
            teleport(5006.7, -5756.2, 14.8)
        end)
        menu.action(TELEPORT_island, "次要目标", {}, "", function()
            teleport(4999.764160, -5749.863770, 14.840000)
        end)
        menu.action(TELEPORT_island, "机场(逃离)", {}, "", function()
            teleport(4443.189, -4510.279, 4.898539)
        end)
        menu.toggle_loop(TELEPORT_island, "传送到大海", {}, "", function()
            teleport(3235, -4938, 56)
            util.yield(1000)
        end)
    island_casino_Task_setting = menu.list(perrico_island, "任务设定", {}, "")
        menu.action(island_casino_Task_setting, "跳过准备任务", {}, "", function()--Update tag1.68
            STAT_SET_INT("H4CNF_TARGET", 5)--主要目标
            STAT_SET_INT("H4_MISSIONS", 65413)--接近载具
            STAT_SET_INT("H4_PROGRESS", 126823)--难度:正常
            STAT_SET_INT("H4CNF_APPROACH", -1)
            STAT_SET_INT("H4CNF_BS_ENTR", 63)
            STAT_SET_INT("H4CNF_BS_GEN", 63)
            STAT_SET_INT("H4CNF_WEP_DISRP", 3)
            STAT_SET_INT("H4CNF_ARM_DISRP", 3)
            STAT_SET_INT("H4CNF_HEL_DISRP", 3)

            SET_INT_LOCAL("heist_island_planning", 1544, 2)-------刷新https://github.com/atomikfr/CayoPericoHeistAssistant
        end)
        menu.action(island_casino_Task_setting, "重置面板", {}, "", function()--Update tag1.68
            STAT_SET_INT("H4_MISSIONS", 0) --locked
            STAT_SET_INT("H4_PROGRESS", 0) --locked
            STAT_SET_INT("H4CNF_APPROACH", 0)
            STAT_SET_INT("H4CNF_BS_ENTR", 0)
            STAT_SET_INT("H4CNF_BS_GEN", 0)
            STAT_SET_INT("H4_PLAYTHROUGH_STATUS", 0)
            STAT_SET_INT("H4CNF_TARGET", -1)

            SET_INT_LOCAL("heist_island_planning", 1544, 2)-------刷新
        end)
        menu.action(island_casino_Task_setting, "刷新任务面板", {}, "", function()--Update tag1.68
            SET_INT_LOCAL("heist_island_planning", 1544, 2)-------刷新https://github.com/atomikfr/CayoPericoHeistAssistant
        end)

    island_cut = menu.list(perrico_island, "分红调整", {}, "分红界面出现时再修改")--佩里科岛
        cayo_cut = menu.list(island_cut, "玩家[1-4]", {}, "")--https://github.com/CrazyZhang666/GTA5OnlineTools/tree/c2bf00804661a81917bd7656f6d306dc591ab795/GTA5MenuExtra/Views/HeistsEditor
            menu.click_slider(cayo_cut, "玩家1", {}, "(%)", 0, 1000, 25, 5, function(value)--Update tag(1.68)
                SET_INT_GLOBAL(1970744 + 831 + 56 + 1, value)
            end)
            menu.click_slider(cayo_cut, "玩家2", {}, "(%)", 0, 1000, 25, 5, function(value)--Update tag(1.68)
                SET_INT_GLOBAL(1970744 + 831 + 56 + 2, value)
            end)
            menu.click_slider(cayo_cut, "玩家3", {}, "(%)", 0, 1000, 25, 5, function(value)--Update tag(1.68)
                SET_INT_GLOBAL(1970744 + 831 + 56 + 3, value)
            end)
            menu.click_slider(cayo_cut, "玩家4", {}, "(%)", 0, 1000, 25, 5, function(value)--Update tag(1.68)
                SET_INT_GLOBAL(1970744 + 831 + 56 + 4, value)
            end)
        menu.action(island_cut, "自保分红", {}, "全员135%,自己60%", function()--Update tag(1.68)
            SET_INT_GLOBAL(1970744 + 831 + 56 + 1, 60)
            SET_INT_GLOBAL(1970744 + 831 + 56 + 2, 135)
            SET_INT_GLOBAL(1970744 + 831 + 56 + 3, 135)
            SET_INT_GLOBAL(1970744 + 831 + 56 + 4, 135)
        end)
        menu.click_slider(island_cut, "全员分红", {}, "(%)", 0, 1000, 25, 5, function(value)--Update tag(1.68)
            SET_INT_GLOBAL(1970744 + 831 + 56 + 1, value)
            SET_INT_GLOBAL(1970744 + 831 + 56 + 2, value)
            SET_INT_GLOBAL(1970744 + 831 + 56 + 3, value)
            SET_INT_GLOBAL(1970744 + 831 + 56 + 4, value)
        end)

    menu.list_action(perrico_island, "抢劫难度", {}, "", {{1,"正常"},{2,"困难"}}, function(Index)--Update tag1.68
        if Index == 1 then
            STAT_SET_INT("H4_PROGRESS", 126823) --locked
            SET_INT_LOCAL("heist_island_planning", 1544, 2)--刷新
        elseif Index == 2 then
            STAT_SET_INT("H4_PROGRESS", 131055)
            SET_INT_LOCAL("heist_island_planning", 1544, 2)--刷新
        end
    end)
    menu.toggle_loop(perrico_island, "跳过下水道切割", {}, "", function() 
        if IS_HELP_MSG_DISPLAYED("UT_WELD_PROMPT") then 
            PAD2._SET_CONTROL_NORMAL(2, 51, 1)
        elseif GET_INT_LOCAL("fm_mission_controller_2020", 26746) == 4 then 
            SET_INT_LOCAL("fm_mission_controller_2020", 26746, 6)
        end
    end)
    menu.action(perrico_island, "删除排水管", {}, "", function() 
        DELETE_OBJECT_BY_HASH(-1297635988)
    end)
    menu.toggle_loop(perrico_island, "跳过指纹锁", {}, "", function() --Update tag1.68
        if GET_INT_LOCAL("fm_mission_controller_2020", 24333) == 4 then -- https://www.unknowncheats.me/forum/3418914-post13398.html
            SET_INT_LOCAL("fm_mission_controller_2020", 24333, 5)
        end
    end)
    menu.action(perrico_island, "跳过切割玻璃", {}, "切割时使用", function()--Update tag1.68
            SET_FLOAT_LOCAL("fm_mission_controller_2020", 30357 + 3, 100)
        end, function()
            SET_FLOAT_LOCAL("fm_mission_controller_2020", 30357 + 3, 0)
    end)
    menu.toggle_loop(perrico_island, "绕过切割机发热", {}, "切割前开启", function()--Update tag1.68
        SET_FLOAT_LOCAL("fm_mission_controller_2020", 30357 + 4, 0)
    end)
    menu.action(perrico_island, "杀死队友", {}, "炸死队友,包括自己(无敌可免疫)", function()
        local playerList = getNonWhitelistedPlayers(whitelistListTable, whitelistGroups, whitelistedName)
        for _, pid in pairs(playerList) do
            local playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            explodePlayer(playerPed, false, expSettings)
        end
    end)

advanced_options_island = menu.list(perrico_island, "高级选项", {}, "")--佩里科岛
    menu.click_slider(advanced_options_island, "增加任务生命数", {}, "只有是战局主机时才会生效", 0, 100, 3, 1, function(value)--Update tag 1.67
        SET_INT_LOCAL("fm_mission_controller_2020", 51905 + 868 + 1, value + 2)
    end)
    menu.action(advanced_options_island, "快速完成", {}, "", function()--Update tag1.68
        menu.trigger_commands("scripthost")
        SET_INT_LOCAL("fm_mission_controller_2020", 48513 + 1, 51338752) -- 'fm_mission_controller_2020' instant finish variable?
        SET_INT_LOCAL("fm_mission_controller_2020", 48513 + 1765 + 1, 50) -- 'fm_mission_controller_2020' instant finish variable?
    end)
        

------------------赌场选项
casino = menu.list(Heist_Control2, "名钻赌场", {}, "")
    casino_Task_setting = menu.list(casino, "任务设定", {}, "")
        menu.action(casino_Task_setting, "跳过准备任务", {}, "目标：钻石\n方式:气势汹汹", function()--Update tag(1.68)
            STAT_SET_INT("CAS_HEIST_FLOW", -1)
            STAT_SET_INT("H3_LAST_APPROACH", 0)
            STAT_SET_INT("H3OPT_APPROACH", 3)
            STAT_SET_INT("H3_HARD_APPROACH", 0)
            STAT_SET_INT("H3OPT_TARGET", 3)
            STAT_SET_INT("H3OPT_POI", 1023)
            STAT_SET_INT("H3OPT_ACCESSPOINTS", 2047)
            STAT_SET_INT("H3OPT_CREWWEAP", 4)
            STAT_SET_INT("H3OPT_CREWDRIVER", 3)
            STAT_SET_INT("H3OPT_CREWHACKER", 4)
            STAT_SET_INT("H3OPT_DISRUPTSHIP", 3)
            STAT_SET_INT("H3OPT_BODYARMORLVL", -1)
            STAT_SET_INT("H3OPT_KEYLEVELS", 2)
            STAT_SET_INT("H3OPT_BITSET1", 799)
            STAT_SET_INT("H3OPT_BITSET0", 3670102)
        end)
        menu.action(casino_Task_setting, "重置面板", {}, "", function()--Update tag(1.68)
            STAT_SET_INT("H3_LAST_APPROACH", 0)
            STAT_SET_INT("H3OPT_APPROACH", 0)
            STAT_SET_INT("H3_HARD_APPROACH", 0)
            STAT_SET_INT("H3OPT_TARGET", 0)
            STAT_SET_INT("H3OPT_POI", 0)
            STAT_SET_INT("H3OPT_ACCESSPOINTS", 0)
            STAT_SET_INT("H3OPT_BITSET1", 0)
            STAT_SET_INT("H3OPT_CREWWEAP", 0)
            STAT_SET_INT("H3OPT_CREWDRIVER", 0)
            STAT_SET_INT("H3OPT_CREWHACKER", 0)
            STAT_SET_INT("H3OPT_WEAPS", 0)
            STAT_SET_INT("H3OPT_VEHS", 0)        
            STAT_SET_INT("H3OPT_DISRUPTSHIP", 0)
            STAT_SET_INT("H3OPT_BODYARMORLVL", 0)
            STAT_SET_INT("H3OPT_KEYLEVELS", 0)
            STAT_SET_INT("H3OPT_MASKS", 0)
            STAT_SET_INT("H3OPT_BITSET0", 0)
        end)
        menu.action(casino_Task_setting, "刷新任务面板", {}, "", function()
            local Bitset0 = STAT_GET_INT("H3OPT_BITSET0")
            local Bitset1 = STAT_GET_INT("H3OPT_BITSET1")
            STAT_SET_INT("H3OPT_BITSET0", math.random(2147483647))
            STAT_SET_INT("H3OPT_BITSET1", math.random(2147483647))
            util.yield_once()
            STAT_SET_INT("H3OPT_BITSET0", Bitset0)
            STAT_SET_INT("H3OPT_BITSET1", Bitset1)
        end)
    TELEPORT_casino = menu.list(casino, "地点传送", {}, "")
        menu.action(TELEPORT_casino, "计划面板(游戏厅)", {}, "先进游戏厅", function()
            teleport(2711.773, -369.458, -54.781)
        end)
        menu.action(TELEPORT_casino, "车库出口(游戏厅)", {}, "先进游戏厅", function()
            teleport(2677.237, -361.494, -55.187)
        end)
        menu.action(TELEPORT_casino, "下水道", {}, "", function()
            teleport(993.21, -146.21, 34.59)
        end)
        menu.action(TELEPORT_casino, "门口(赌场)", {}, "", function()
            teleport(917.24634, 48.989567, 80.89892)
        end)
        menu.action(TELEPORT_casino, "员工大厅(赌场)", {}, "", function()
            teleport(965.14856, -9.05023, 80.63045)
        end)
        menu.action(TELEPORT_casino, "音乐柜", {}, "", function()
            teleport(997.5346, 84.51491, 80.990555)
        end)
        menu.action(TELEPORT_casino, "废物处理间(赌场)", {}, "", function()
            teleport(2542.052, -214.3084, -58.722965)
        end)
        menu.action(TELEPORT_casino, "员工大门(赌场)", {}, "", function()
            teleport(2547.9192, -273.16754, -58.723003)
        end)
        menu.action(TELEPORT_casino, "双人刷卡点(赌场)", {}, "", function()
            teleport(2465.4746, -279.2276, -70.694145)
        end)
        menu.action(TELEPORT_casino, "金库内部(赌场)", {}, "", function()
            teleport(2515.1252, -238.91661, -70.73713)
        end)
        menu.action(TELEPORT_casino, "库外部(赌场)", {}, "", function()
            teleport(2497.5098, -238.50768, -70.7388)
        end)
        menu.action(TELEPORT_casino,"小金库(赌场)", {}, "", function()
            teleport(2520.8645, -286.30685, -58.723007)
        end)

    casino_fenhong = menu.list(casino, "分红调整", {}, "")--赌场
        casino_cut = menu.list(casino_fenhong, "玩家[1-4]", {}, "")
            menu.click_slider(casino_cut, "玩家1", {}, "(%)", 0, 1000, 25, 5, function(value)--Update tag(1.68)
                SET_INT_GLOBAL(1963945 + 1497 + 736 + 92 + 1, value)
            end)
            menu.click_slider(casino_cut, "玩家2", {}, "(%)", 0, 1000, 25, 5, function(value)--Update tag(1.68)
                SET_INT_GLOBAL(1963945 + 1497 + 736 + 92 + 2, value)
            end)
            menu.click_slider(casino_cut, "玩家3", {}, "(%)", 0, 1000, 25, 5, function(value)--Update tag(1.68)
                SET_INT_GLOBAL(1963945 + 1497 + 736 + 92 + 3, value)
            end)
            menu.click_slider(casino_cut, "玩家4", {}, "(%)", 0, 1000, 25, 5, function(value)--Update tag(1.68)
                SET_INT_GLOBAL(1963945 + 1497 + 736 + 92 + 4, value)
            end)
        menu.action(casino_fenhong, "自保分红", {}, "全员146%, 自己60%", function()--Update tag(1.68)
            SET_INT_GLOBAL(1963945 + 1497 + 736 + 92 + 1, 60)
            SET_INT_GLOBAL(1963945 + 1497 + 736 + 92 + 2, 146)
            SET_INT_GLOBAL(1963945 + 1497 + 736 + 92 + 3, 146)
            SET_INT_GLOBAL(1963945 + 1497 + 736 + 92 + 4, 146)
        end)
        menu.click_slider(casino_fenhong, "自定义分红", {}, "(%)", 0, 1000, 25, 5, function(value)--Update tag(1.68)
            SET_INT_GLOBAL(1963945 + 1497 + 736 + 92 + 1, value)
            SET_INT_GLOBAL(1963945 + 1497 + 736 + 92 + 2, value)
            SET_INT_GLOBAL(1963945 + 1497 + 736 + 92 + 3, value)
            SET_INT_GLOBAL(1963945 + 1497 + 736 + 92 + 4, value)
        end)


    menu.action(casino, "杀死队友", {}, "炸死队友,包括自己(无敌可免疫)", function()
        local playerList = getNonWhitelistedPlayers(whitelistListTable, whitelistGroups, whitelistedName)
        for _, pid in pairs(playerList) do
            local playerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
            explodePlayer(playerPed, false, expSettings)
        end
    end)
    advanced_options_casino = menu.list(casino, "高级选项", {}, "")--赌场
        menu.toggle_loop(advanced_options_casino, "自动鼠标左键点击", {}, "用于拿取目标财物时",function()
            if TASK.GET_IS_TASK_ACTIVE(PLAYER.PLAYER_PED_ID(), 135) then
                PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 237, 1)
                util.yield(50)
            end
        end)
        menu.click_slider(advanced_options_casino, "增加任务生命数", {}, "只有是战局主机时才会生效", 0, 100, 0, 1, function(value)--Update tag 1.67
            SET_INT_LOCAL("fm_mission_controller", 26136 + 1325 + 1, value)
        end)
        menu.action(advanced_options_casino, "快速完成", {}, "", function()--Update tag1.68
            menu.trigger_commands("scripthost")
            SET_INT_LOCAL("fm_mission_controller", 19728, 12) -- ???, 'fm_mission_controller' instant finish variable?
            SET_INT_LOCAL("fm_mission_controller", 19728 + 1741, 150) -- Casino Aggressive Kills & Act 3
            SET_INT_LOCAL("fm_mission_controller", 27489 + 859, 99999) -- 'fm_mission_controller' instant finish variable?
            SET_INT_LOCAL("fm_mission_controller", 31603 + 69, 99999) -- 'fm_mission_controller' instant finish variable?
            SET_INT_LOCAL("fm_mission_controller", 31603 + 97, 80) -- Act 1 Kills? Seem not to work
        end)

doomsday = menu.list(Heist_Control2, "末日豪杰", {}, "")
    doomsday_Task_setting = menu.list(doomsday, "任务设定", {}, "")
        menu.action(doomsday_Task_setting, "数据泄露 I", {}, "", function()--Update tag1.68
            STAT_SET_INT("GANGOPS_FLOW_MISSION_PROG", 503)
            STAT_SET_INT("GANGOPS_HEIST_STATUS", -229383)
            STAT_SET_INT("GANGOPS_FLOW_NOTIFICATIONS", 1557)
            SET_INT_LOCAL("gb_gang_ops_planning", 182, 6)------刷新
        end)
        menu.action(doomsday_Task_setting, "波格丹危机 II", {}, "", function()--Update tag1.68
            STAT_SET_INT("GANGOPS_FLOW_MISSION_PROG", 240)
            STAT_SET_INT("GANGOPS_HEIST_STATUS", -229378)
            STAT_SET_INT("GANGOPS_FLOW_NOTIFICATIONS", 1557)
            SET_INT_LOCAL("gb_gang_ops_planning", 182, 6)------刷新
        end)
        menu.action(doomsday_Task_setting, "末日降临 III", {}, "", function()--Update tag1.68
            STAT_SET_INT("GANGOPS_FLOW_MISSION_PROG", 16368)
            STAT_SET_INT("GANGOPS_HEIST_STATUS", -229380)
            STAT_SET_INT("GANGOPS_FLOW_NOTIFICATIONS", 1557)
            SET_INT_LOCAL("gb_gang_ops_planning", 182, 6)------刷新
        end)
        menu.action(doomsday_Task_setting, "重置任务面板", {}, "", function()--Update tag1.68
            STAT_SET_INT("GANGOPS_FLOW_MISSION_PROG", 240)
            STAT_SET_INT("GANGOPS_HEIST_STATUS", 0)
            STAT_SET_INT("GANGOPS_FLOW_NOTIFICATIONS", 1557)
            SET_INT_LOCAL("gb_gang_ops_planning", 182, 6)------刷新
        end)
        
    doomsday_Task_tp = menu.list(doomsday, "地点传送", {}, "")
        menu.action(doomsday_Task_tp, "抢劫屏幕", {}, "", function()
            teleport(350.69284, 4872.308, -60.794243)
            ENTITY.SET_ENTITY_HEADING(PLAYER.PLAYER_PED_ID(), -50)
        end)

    doomsday_cut = menu.list(doomsday, "分红设置", {}, "")--末日
        doomsday_cut1 = menu.list(doomsday_cut, "末日分红", {}, "")
            doomsday_cut_p = menu.list(doomsday_cut1, "玩家[1-4]", {}, "")
                menu.click_slider(doomsday_cut_p, "玩家1", {}, "(%)", 0, 1000, 25, 5, function(value)--Update tag(1.68)
                    SET_INT_GLOBAL(1959865 + 812 + 50 + 1, value)
                end)
                menu.click_slider(doomsday_cut_p, "玩家2", {}, "(%)", 0, 1000, 25, 5, function(value)--Update tag(1.68)
                    SET_INT_GLOBAL(1959865 + 812 + 50 + 2, value)
                end)
                menu.click_slider(doomsday_cut_p, "玩家3", {}, "(%)", 0, 1000, 25, 5, function(value)--Update tag(1.68)
                    SET_INT_GLOBAL(1959865 + 812 + 50 + 3, value)
                end)
                menu.click_slider(doomsday_cut_p, "玩家4", {}, "(%)", 0, 1000, 25, 5, function(value)--Update tag(1.68)
                    SET_INT_GLOBAL(1959865 + 812 + 50 + 4, value)
                end)
            menu.click_slider(doomsday_cut1, "全员分红", {}, "(%)", 0, 1000, 25, 5, function(value)--Update tag(1.68)
                SET_INT_GLOBAL(1959865 + 812 + 50 + 1, value)
                SET_INT_GLOBAL(1959865 + 812 + 50 + 2, value)
                SET_INT_GLOBAL(1959865 + 812 + 50 + 3, value)
                SET_INT_GLOBAL(1959865 + 812 + 50 + 4, value)
            end)

    advanced_options_doomsday = menu.list(doomsday, "高级选项", {}, "")--末日
        menu.action(advanced_options_doomsday, "快速完成", {}, "末日降临", function()--Update tag1.68
            menu.trigger_commands("scripthost")
            SET_INT_LOCAL("fm_mission_controller", 19728 + 1741, 80) -- Casino Aggressive Kills & Act 3
            SET_INT_LOCAL("fm_mission_controller", 19728 + 2686, 10000000) -- How much did you take in the casino and pacific standard heist
            SET_INT_LOCAL("fm_mission_controller", 27489 + 859, 99999) -- 'fm_mission_controller' instant finish variable?
            SET_INT_LOCAL("fm_mission_controller", 31603 + 69, 99999) -- 'fm_mission_controller' instant finish variable?
        end)
-----------

    menu.toggle_loop(Heist_Control2, "达克斯冷却", {}, "移除达克斯工作的冷却时间", function()
        STATS.STAT_SET_INT(util.joaat("MP"..util.get_char_slot().."_XM22JUGGALOWORKCDTIMER"), -1, true)
    end)
    menu.toggle_loop(Heist_Control2, "立刻完成刑事破坏", {}, "", function ()
        if SCRIPT.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(util.joaat("am_criminal_damage")) ~= 0 then
              SET_INT_LOCAL('am_criminal_damage', 105,  2147483647)
              util.yield(3000)
              SET_INT_LOCAL('am_criminal_damage', 110 + 39, 0)
          end
      end)

------赌场刷钱
casino_brush_money = menu.list(Heist_Control2, "全自动赌场刷钱", {}, "")
    require "lib.sakuralib.SlotBot"


menu.action(Heist_Control2, "将拾取物传送到自己", {}, "", function()
    local counter = 0
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    for _, pickup in entities.get_all_pickups_as_handles() do
        ENTITY.SET_ENTITY_COORDS(pickup, pos.x, pos.y, pos.z, false, false, false, false)
        counter = counter + 1
        util.yield()
    end
    if counter == 0 then
        util.toast("没有发现可捡拾物. :/")
    else
        util.toast("已传送 ".. tostring(counter) .." 个拾取物.")
    end
end)

local curcoords = {}
menu.toggle_loop(Heist_Control2, '自动出租车', {}, '自动传送到出租车接送人员,接他们并放下他们,直到你不再在出租车上', function ()
    if curcoords.x == nil then
        curcoords = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    return curcoords
    end
        local play_car = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
        local vhash = ENTITY.GET_ENTITY_MODEL(play_car)
        if play_car == 0 or util.reverse_joaat(vhash) ~= 'taxi' then
            ENTITY.SET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), 895.1739, -179.2708, 74.70049, false, true, true, false)
            util.yield(2500)
            PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 51, 1)
            util.yield(10000)
        end
        local taxi_blip = HUD.GET_CLOSEST_BLIP_INFO_ID(280)
        local taxi_ent = HUD.GET_BLIP_INFO_ID_ENTITY_INDEX(taxi_blip)
        local taxi = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(taxi_ent, 0, 6, 0)
        if HUD.DOES_BLIP_EXIST(HUD.GET_CLOSEST_BLIP_INFO_ID(280)) then
            if taxi.x ~= 0 and taxi.y ~= 0 and taxi.z ~= 0 then
                util.yield(500)
                PED.SET_PED_COORDS_KEEP_VEHICLE(PLAYER.PLAYER_PED_ID(), taxi.x, taxi.y, taxi.z, false, false, false, false)
                util.yield(1500)
                PAD.SET_CONTROL_VALUE_NEXT_FRAME(0, 86, 1)
                while HUD.DOES_BLIP_EXIST(HUD.GET_CLOSEST_BLIP_INFO_ID(280)) do
                    util.yield()
                end
                util.yield(500)
                menu.trigger_commands('tpobjective')
            end
            else
                util.yield()
        end
    end, function ()
        ENTITY.SET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), curcoords.x, curcoords.y, curcoords.z, false, true, true, false)
            util.toast('已结束出租车工作')
            curcoords = {}
    end)

    unlocks = menu.list(Heist_Control2, "解锁选项")
        menu.toggle_loop(unlocks, "50辆载具车库", {}, "", function()
            if memory.read_byte(memory.script_global(262145 + 32688)) ~= 0 then-- thx aero for this global <3
                memory.write_byte(memory.script_global(262145 + 32688), 0) 
            end
            if memory.read_byte(memory.script_global(262145 + 32702)) ~= 1 then
                memory.write_byte(memory.script_global(262145 + 32702), 1)  
            end
        end)
        menu.action(unlocks, "毒品战争内容", {}, "", function()
            for i = 33974, 34112, 1 do
                memory.write_byte(memory.script_global(262145 + i), 1)  
            end
        end)
        menu.action(unlocks, "圣诞和新年礼物", {}, "Change sessions for the gifts to be awarded.", function()
            memory.write_byte(memory.script_global(262145 + 33915), 1)  
            memory.write_byte(memory.script_global(262145 + 33916), 1)  
        end)
    talk_opt = menu.list(Heist_Control2, '对话选项', {}, '')
        menu.action(talk_opt, "跳过一句NPC对话", {}, "", function()
            AUDIO.SKIP_TO_NEXT_SCRIPTED_CONVERSATION_LINE()
        end)
        menu.toggle_loop(talk_opt, "自动跳过NPC对话", {}, "", function()
            if AUDIO.IS_SCRIPTED_CONVERSATION_ONGOING() then
                AUDIO.STOP_SCRIPTED_CONVERSATION(false)
                AUDIO.SKIP_TO_NEXT_SCRIPTED_CONVERSATION_LINE()
            end
        end)
        menu.toggle_loop(talk_opt, "自动跳过过场动画", {}, "", function()
            if CUTSCENE.IS_CUTSCENE_ACTIVE() or CUTSCENE.IS_CUTSCENE_PLAYING() then
                CUTSCENE.STOP_CUTSCENE_IMMEDIATELY()
                CUTSCENE.REMOVE_CUTSCENE()
            end
        end)

menu.toggle_loop(Heist_Control2, "自动CEO/首领", {},"", function()
    if not util.is_session_started() then return end 
    for _, label in pairs(CEOLabels) do
        if IS_HELP_MSG_DISPLAYED(label) then
            if players.get_boss(PLAYER.PLAYER_ID()) == -1 then menu.trigger_commands("ceostart") end
            if players.get_org_type(PLAYER.PLAYER_ID()) == 1 then menu.trigger_commands("ceotomc") end
            util.toast("看起来你需要成为一个CEO")
        end
    end
    for _, label in pairs(MCLabels) do
        if IS_HELP_MSG_DISPLAYED(label) then
            if players.get_boss(PLAYER.PLAYER_ID()) == -1 then menu.trigger_commands("mcstart") end
            if players.get_org_type(PLAYER.PLAYER_ID()) == 0 then menu.trigger_commands("ceotomc") end
            util.toast("看起来你需要成为一个首领")
        end
    end
end)
