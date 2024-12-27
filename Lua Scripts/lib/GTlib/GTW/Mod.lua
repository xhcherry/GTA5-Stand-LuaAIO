    Natives = {
	    ["STAT_GET_INT"]=--[[BOOL (bool)]] function(--[[Hash (int)]] statHash,--[[int* (pointer)]] outValue,--[[int]] p2)native_invoker.begin_call()native_invoker.push_arg_int(statHash)native_invoker.push_arg_pointer(outValue)native_invoker.push_arg_int(p2)native_invoker.end_call_2(0x767FBC2AC802EF3D)return native_invoker.get_return_value_bool()end,
	    ["NET_GAMESERVER_TRANSFER_WALLET_TO_BANK"]=--[[BOOL (bool)]] function(--[[int]] charSlot,--[[int]] amount)native_invoker.begin_call()native_invoker.push_arg_int(charSlot)native_invoker.push_arg_int(amount)native_invoker.end_call_2(0xC2F7FE5309181C7D)return native_invoker.get_return_value_bool()end,
	    ["NET_GAMESERVER_TRANSFER_BANK_TO_WALLET"]=--[[BOOL (bool)]] function(--[[int]] charSlot,--[[int]] amount)native_invoker.begin_call()native_invoker.push_arg_int(charSlot)native_invoker.push_arg_int(amount)native_invoker.end_call_2(0xD47A2C1BA117471D)return native_invoker.get_return_value_bool()end,
	    ["NETWORK_GET_VC_WALLET_BALANCE"]=--[[int]] function(--[[int]] characterSlot)native_invoker.begin_call()native_invoker.push_arg_int(characterSlot)native_invoker.end_call_2(0xA40F9C2623F6A8B5)return native_invoker.get_return_value_int()end,
	    ["NETWORK_GET_VC_BANK_BALANCE"]=--[[int]] function()native_invoker.begin_call()native_invoker.end_call_2(0x76EF28DA05EA395A)return native_invoker.get_return_value_int()end,
    	["GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH"]=--[[int]] function(--[[Hash (int)]] scriptHash)native_invoker.begin_call()native_invoker.push_arg_int(scriptHash)native_invoker.end_call_2(0x2C83A9DA6BFFC4F9)return native_invoker.get_return_value_int()end,
        ["GET_HASH_KEY"]=--[[Hash (int)]] function(--[[string]] string)native_invoker.begin_call()native_invoker.push_arg_string(string)native_invoker.end_call_2(0xD24D37CC275948CC)return native_invoker.get_return_value_int()end,
    	["REQUEST_SCRIPT"]=--[[void]] function(--[[string]] scriptName)native_invoker.begin_call()native_invoker.push_arg_string(scriptName)native_invoker.end_call_2(0x6EB5F71AA68F2E8E)end,
        ["HAS_SCRIPT_LOADED"]=--[[BOOL (bool)]] function(--[[string]] scriptName)native_invoker.begin_call()native_invoker.push_arg_string(scriptName)native_invoker.end_call_2(0xE6CC9F3BA0FB9EF1)return native_invoker.get_return_value_bool()end,
        ["START_NEW_SCRIPT"]=--[[int]] function(--[[string]] scriptName,--[[int]] stackSize)native_invoker.begin_call()native_invoker.push_arg_string(scriptName)native_invoker.push_arg_int(stackSize)native_invoker.end_call_2(0xE81651AD79516E48)return native_invoker.get_return_value_int()end,
        ["SET_SCRIPT_AS_NO_LONGER_NEEDED"]=--[[void]] function(--[[string]] scriptName)native_invoker.begin_call()native_invoker.push_arg_string(scriptName)native_invoker.end_call_2(0xC90D2DCACD56184C)end,
        ["DISPLAY_ONSCREEN_KEYBOARD"]=--[[void]] function(--[[int]] p0,--[[string]] windowTitle,--[[string]] p2,--[[string]] defaultText,--[[string]] defaultConcat1,--[[string]] defaultConcat2,--[[string]] defaultConcat3,--[[int]] maxInputLength)native_invoker.begin_call()native_invoker.push_arg_int(p0)native_invoker.push_arg_string(windowTitle)native_invoker.push_arg_string(p2)native_invoker.push_arg_string(defaultText)native_invoker.push_arg_string(defaultConcat1)native_invoker.push_arg_string(defaultConcat2)native_invoker.push_arg_string(defaultConcat3)native_invoker.push_arg_int(maxInputLength)native_invoker.end_call_2(0x00DC833F2568DBF6)end,
        ["UPDATE_ONSCREEN_KEYBOARD"]=--[[int]] function()native_invoker.begin_call()native_invoker.end_call_2(0x0CF2B696BBF945AE)return native_invoker.get_return_value_int()end,
        ["GET_ONSCREEN_KEYBOARD_RESULT"]=--[[string]] function()native_invoker.begin_call()native_invoker.end_call_2(0x8362B09B91893647)return native_invoker.get_return_value_string()end,
    }

    local gtao_ver <const> = memory.rip(memory.scan("8B C3 33 D2 C6 44 24 20") + 0x24);

    if tonumber(memory.read_string(gtao_ver)) == 3411 then

        local self = {};
        self.__index = self
        setmetatable(self, self)

        function self:my_root()
            return menu.my_root()
        end

        function self:get_int(stat)
            return memory.read_int(memory.script_global(stat))
        end

        function self:set_int(stat, value)
            return memory.write_int(memory.script_global(stat), value)
        end

        function self:is_script(scriptName)
            return Natives.GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(Natives.GET_HASH_KEY(scriptName))
        end
        
        function self:run_script(scriptName, stackSize)
            if self:is_script(scriptName) >= 1 then
                util.toast("警告\n请勿重复启动脚本线程")
            else
                Natives.REQUEST_SCRIPT(scriptName)
            repeat util.yield() until Natives.HAS_SCRIPT_LOADED(scriptName)
            Natives.START_NEW_SCRIPT(scriptName, stackSize)
            Natives.SET_SCRIPT_AS_NO_LONGER_NEEDED(scriptName)
            end
        end

        function self:GetCharacter()
            local _, char = Natives.STAT_GET_INT(util.stat_get_int64("MPPLY_LAST_MP_CHAR"), 0, 1);
            return tonumber(char)
        end

        function self:wallettobank()
            if self:is_script("freemode") > 0 then
			    local wallet_balance = Natives.NETWORK_GET_VC_WALLET_BALANCE(character);
			    Natives.NET_GAMESERVER_TRANSFER_WALLET_TO_BANK(self:GetCharacter(), wallet_balance)
            else
                util.toast("需要进入GTA在线模式.")
            end
        end

		function self:banktowallet()
            if self:is_script("freemode") > 0 then
			    local bank_balance = Natives.NETWORK_GET_VC_BANK_BALANCE(character);
			    Natives.NET_GAMESERVER_TRANSFER_BANK_TO_WALLET(self:GetCharacter(), bank_balance)
            else
                util.toast("需要进入GTA在线模式.")
            end
        end

        function self:action(name, params, help_text, actionFunction)
            return self:my_root():action(name, params, help_text, actionFunction)
        end

        function self:slider(parent, menu_name, command_names, help_text, options, on_click)
            return self:my_root():textslider(parent, menu_name, command_names, help_text, options, on_click)
        end

        function self:show_keyboard(text) 
            local time = os.clock() + 0.4;
            while os.clock() < time do
                util.yield()
            end
            Natives.DISPLAY_ONSCREEN_KEYBOARD(true, 
            ("FMMC_KEY_TIP8" == nil and "HUD_TITLE" or "FMMC_KEY_TIP8"), 
            "", (text == nil 
            and "" or text), "", "", "", 60)
            while Natives.UPDATE_ONSCREEN_KEYBOARD() == 0 do
                util.yield() 
            end
            if not Natives.GET_ONSCREEN_KEYBOARD_RESULT() then
                return ""
            else
                return Natives.GET_ONSCREEN_KEYBOARD_RESULT()
            end
        end
        
        function self:Fakechat()
            local ipid = self:show_keyboard("输入虚假ID :XiProNB");
            local edit = string.match(ipid, ":(.*)");
            if edit then
                if string.match(edit, "[\128-\191\200-\239][\128-\191]*") then
                    util.toast("修改失败,不支持中文.")
                else
                    memory.write_string(memory.scan("4d") + 0x2F27D8C, edit)
                    util.toast("你已修改为: " .. edit)
                end
            else
                util.toast("已取消修改.")
            end
        end
        
        self:action("虚假聊天", {}, "点击输入你要改的ID.", function()
            if self:is_script("freemode") > 0 then
                self:Fakechat()
            else
                util.toast("需要进入GTA在线模式.")
            end
        end)

        self:action("街机游戏", {"Arcade"}, "开启街机小游戏.", function()
            if self:is_script("freemode") > 0 then
                self:run_script("ggsm_arcade",8344)
            else
                util.toast("需要进入GTA在线模式.")
            end
        end)

        self:action("周日奖励", {}, "一键获取每日/周奖励.", function()
            if self:is_script("freemode") > 0 then
                for i = 0, 2 do 
                    local objective = self:get_int(2359296 + (1 + (0 * 5571)) + 681 + 4245 + (1 + (i * 3)));
                    self:set_int(1574744 + 1 + (1 + (i * 1)), objective)
                end
                self:set_int(1574744, 1)
                self:set_int(2738865 + (1 + (0 * 6)) + 1, self:get_int(2738865 + (1 + (0 * 6)) + 2))
            else
                util.toast("需要进入GTA在线模式.")
            end
        end)

        self:action("解锁所有", {}, "一键解锁成就.", function()
            if self:is_script("freemode") > 0 then
                for i = 0, 77 do
                    util.yield(200)
                    self:set_int(4546323 + 1, i)
                    if i == 77 then
                        util.toast("已解锁77个成就")
                    end
                end
            else
                util.toast("需要进入GTA在线模式.")
            end
        end)

        self:action("启用移除载具", {}, "", function()
            if self:is_script("freemode") > 0 then
                self:set_int(262145 + 22565, 1)
                self:set_int(262145 + 14708, 1)
                self:set_int(262145 + 34371, 1)
                self:set_int(262145 + 34373, 1)
                self:set_int(262145 + 34451, 1)
                self:set_int(262145 + 34349, 1)
                self:set_int(262145 + 34527, 1)
                self:set_int(262145 + 34533, 1)
                self:set_int(262145 + 17356, 1)
                self:set_int(262145 + 17372, 1)
                self:set_int(262145 + 34589, 1)
                self:set_int(262145 + 35492, 1)
                self:set_int(262145 + 34415, 1)
                self:set_int(262145 + 34417, 1)
                self:set_int(262145 + 34465, 1)
                self:set_int(262145 + 34573, 1)
                self:set_int(262145 + 34499, 1)
                self:set_int(262145 + 34495, 1)
                self:set_int(262145 + 34493, 1)
                self:set_int(262145 + 34511, 1)
                self:set_int(262145 + 28191, 1)
                self:set_int(262145 + 34501, 1)
                self:set_int(262145 + 34333, 1)
                self:set_int(262145 + 34551, 1)
                self:set_int(262145 + 34553, 1)
                self:set_int(262145 + 34409, 1)
                self:set_int(262145 + 34365, 1)
                self:set_int(262145 + 34569, 1)
                self:set_int(262145 + 34571, 1)
                self:set_int(262145 + 23726, 1)
                self:set_int(262145 + 34401, 1)
                self:set_int(262145 + 17230, 1)
                self:set_int(262145 + 25367, 1)
                self:set_int(262145 + 34335, 1)
                self:set_int(262145 + 34337, 1)
                self:set_int(262145 + 34339, 1)
                self:set_int(262145 + 34341, 1)
                self:set_int(262145 + 34325, 1)
                self:set_int(262145 + 18947, 1)
                self:set_int(262145 + 18948, 1)
                self:set_int(262145 + 22564, 1)
                self:set_int(262145 + 17229, 1)
                self:set_int(262145 + 34367, 1)
                self:set_int(262145 + 34331, 1)
                self:set_int(262145 + 21603, 1)
                self:set_int(262145 + 17364, 1)
                self:set_int(262145 + 25369, 1)
                self:set_int(262145 + 34431, 1)
                self:set_int(262145 + 34453, 1)
                self:set_int(262145 + 34497, 1)
                self:set_int(262145 + 25387, 1)
                self:set_int(262145 + 34455, 1)
                self:set_int(262145 + 34403, 1)
                self:set_int(262145 + 17355, 1)
                self:set_int(262145 + 34399, 1)
                self:set_int(262145 + 34323, 1)
                self:set_int(262145 + 34437, 1)
                self:set_int(262145 + 23717, 1)
                self:set_int(262145 + 17358, 1)
                self:set_int(262145 + 17370, 1)
                self:set_int(262145 + 34467, 1)
                self:set_int(262145 + 34433, 1)
                self:set_int(262145 + 34435, 1)
                self:set_int(262145 + 34351, 1)
                self:set_int(262145 + 34411, 1)
                self:set_int(262145 + 34587, 1)
                self:set_int(262145 + 34565, 1)
                self:set_int(262145 + 34523, 1)
                self:set_int(262145 + 34369, 1)
                self:set_int(262145 + 34563, 1)
                self:set_int(262145 + 34559, 1)
                self:set_int(262145 + 34481, 1)
                self:set_int(262145 + 19951, 1)
                self:set_int(262145 + 34581, 1)
                self:set_int(262145 + 34577, 1)
                self:set_int(262145 + 22556, 1)
                self:set_int(262145 + 34585, 1)
                self:set_int(262145 + 34473, 1)
                self:set_int(262145 + 25386, 1)
                self:set_int(262145 + 22563, 1)
                self:set_int(262145 + 34457, 1)
                self:set_int(262145 + 34513, 1)
                self:set_int(262145 + 22557, 1)
                self:set_int(262145 + 28201, 1)
                self:set_int(262145 + 34405, 1)
                self:set_int(262145 + 34541, 1)
                self:set_int(262145 + 34459, 1)
                self:set_int(262145 + 34535, 1)
                self:set_int(262145 + 34429, 1)
                self:set_int(262145 + 25383, 1)
                self:set_int(262145 + 34439, 1)
                self:set_int(262145 + 34387, 1)
                self:set_int(262145 + 34361, 1)
                self:set_int(262145 + 34557, 1)
                self:set_int(262145 + 34503, 1)
                self:set_int(262145 + 34583, 1)
                self:set_int(262145 + 28830, 1)
                self:set_int(262145 + 28190, 1)
                self:set_int(262145 + 25379, 1)
                self:set_int(262145 + 17232, 1)
                self:set_int(262145 + 34353, 1)
                self:set_int(262145 + 34555, 1)
                self:set_int(262145 + 34597, 1)
                self:set_int(262145 + 23729, 1)
                self:set_int(262145 + 14703, 1)
                self:set_int(262145 + 25385, 1)
                self:set_int(262145 + 34471, 1)
                self:set_int(262145 + 25396, 1)
                self:set_int(262145 + 34443, 1)
                self:set_int(262145 + 34441, 1)
                self:set_int(262145 + 25397, 1)
                self:set_int(262145 + 34591, 1)
                self:set_int(262145 + 34475, 1)
                self:set_int(262145 + 34561, 1)
                self:set_int(262145 + 25389, 1)
                self:set_int(262145 + 34485, 1)
                self:set_int(262145 + 34567, 1)
                self:set_int(262145 + 34427, 1)
                self:set_int(262145 + 34529, 1)
                self:set_int(262145 + 34595, 1)
                self:set_int(262145 + 22560, 1)
                self:set_int(262145 + 34505, 1)
                self:set_int(262145 + 34355, 1)
                self:set_int(262145 + 34357, 1)
                self:set_int(262145 + 21607, 1)
                self:set_int(262145 + 17363, 1)
                self:set_int(262145 + 17373, 1)
                self:set_int(262145 + 34483, 1)
                self:set_int(262145 + 17223, 1)
                self:set_int(262145 + 34507, 1)
                self:set_int(262145 + 34531, 1)
                self:set_int(262145 + 21606, 1)
                self:set_int(262145 + 22558, 1)
                self:set_int(262145 + 22562, 1)
                self:set_int(262145 + 34593, 1)
                self:set_int(262145 + 34521, 1)
                self:set_int(262145 + 34377, 1)
                self:set_int(262145 + 34393, 1)
                self:set_int(262145 + 34469, 1)
                self:set_int(262145 + 34489, 1)
                self:set_int(262145 + 19953, 1)
                self:set_int(262145 + 34509, 1)
                self:set_int(262145 + 25393, 1)
                self:set_int(262145 + 34463, 1)
                self:set_int(262145 + 34461, 1)
                self:set_int(262145 + 17366, 1)
                self:set_int(262145 + 34515, 1)
                self:set_int(262145 + 22561, 1)
                self:set_int(262145 + 22554, 1)
                self:set_int(262145 + 34519, 1)
                self:set_int(262145 + 34345, 1)
                self:set_int(262145 + 34347, 1)
                self:set_int(262145 + 34547, 1)
                self:set_int(262145 + 34579, 1)
                self:set_int(262145 + 28831, 1)
                self:set_int(262145 + 34445, 1)
                self:set_int(262145 + 34575, 1)
                self:set_int(262145 + 34359, 1)
                self:set_int(262145 + 34479, 1)
                self:set_int(262145 + 23781, 1)
                self:set_int(262145 + 34539, 1)
                self:set_int(262145 + 34383, 1)
                self:set_int(262145 + 34381, 1)
                self:set_int(262145 + 34379, 1)
                self:set_int(262145 + 34545, 1)
                self:set_int(262145 + 22551, 1)
                self:set_int(262145 + 34343, 1)
                self:set_int(262145 + 34549, 1)
                self:set_int(262145 + 34525, 1)
                self:set_int(262145 + 23780, 1)
                self:set_int(262145 + 34537, 1)
                self:set_int(262145 + 34327, 1)
                self:set_int(262145 + 29156, 1)
                self:set_int(262145 + 20830, 1)
                self:set_int(262145 + 17371, 1)
                self:set_int(262145 + 25370, 1)
                self:set_int(262145 + 17221, 1)
                self:set_int(262145 + 34407, 1)
                self:set_int(262145 + 34477, 1)
                self:set_int(262145 + 26330, 1)
                self:set_int(262145 + 34375, 1)
                self:set_int(262145 + 29605, 1)
                self:set_int(262145 + 34487, 1)
                self:set_int(262145 + 22566, 1)
                self:set_int(262145 + 34397, 1)
                self:set_int(262145 + 34543, 1)
                self:set_int(262145 + 34517, 1)
                self:set_int(262145 + 17369, 1)
                self:set_int(262145 + 20828, 1)
                self:set_int(262145 + 34423, 1)
                self:set_int(262145 + 34425, 1)
                self:set_int(262145 + 34395, 1)
                self:set_int(262145 + 34447, 1)
                self:set_int(262145 + 34449, 1)
                self:set_int(262145 + 25384, 1)
                self:set_int(262145 + 17354, 1)
                self:set_int(262145 + 25381, 1)
                self:set_int(262145 + 34599, 1)
                util.toast("启用移除的车辆")
            else
                util.toast("需要进入GTA在线模式.")
            end
        end)

        self:slider("自助取款机", {"ATM"}, "自由转换金币.", {"转到银行", "转到钱包"}, function(index)
            if index == 1 then
                self:wallettobank()
            elseif index == 2 then
                self:banktowallet()
            end
        end)

    else
        util.toast("脚本暂时未适配游戏版本")
    end
