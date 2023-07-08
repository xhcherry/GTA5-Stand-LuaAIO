--credut to abuazizv for the orginal rebound lua

--shameless skidded from MB
local function SetGlobalInt(address, value)
    memory.write_int(memory.script_global(address), value)
end


function trigger_transaction(hash, amount)
    SetGlobalInt(4536533+ 1, 2147483646)
    SetGlobalInt(4536533+ 7, 2147483647)
    SetGlobalInt(4536533+ 6, 0)
    SetGlobalInt(4536533+ 5, 0)
    SetGlobalInt(4536533+ 3, hash)
    SetGlobalInt(4536533+ 2, amount)
    SetGlobalInt(4536533,2)
	end
	
	
   
   
menu.toggle_loop(cash,"1M Loop", {}, "", function()
    trigger_transaction(0x615762F1, 1000000)
	util.yield()
end)



menu.toggle_loop(cash,"50K Loop", {}, "", function()
    trigger_transaction(0x610F9AB4, 50000)
	util.yield()
end)

menu.toggle_loop(cash,"40m Loop (slow)", {}, "", function()
    trigger_transaction(0x176D9D54, 15000000)
	trigger_transaction(0xED97AFC1, 7000000)
	trigger_transaction(0xA174F633, 15000000)
	trigger_transaction(0x314FB8B0, 1000000)
	trigger_transaction(0x4B6A869C, 2000000)
	util.yield(40000)
end)


menu.action(cash,"15M (Bend Job Limited)", {}, "", function()
    trigger_transaction(0x176D9D54, 15000000)
end)


menu.action(cash,"5M (Bend Bonus Limited)", {}, "", function()
    trigger_transaction(0xA174F633, 15000000)
end)

menu.action(cash,"7M (Gang Money Limited)", {}, "", function()
    trigger_transaction(0xED97AFC1, 7000000)
end)

menu.action(cash,"3.6M (Casino Heist Money Limited)", {}, "", function()
    trigger_transaction(0xB703ED29, 3619000)
end)

menu.action(cash,"2.5M (Gang Money Limited)", {}, "", function()
    trigger_transaction(0x46521174, 2550000)
end)

menu.action(cash,"2.5M (Island Heist Money Limited)", {}, "", function()
    trigger_transaction(0xDBF39508, 2550000)
end)

menu.action(cash,"2M (Heist Awards Money Limited)", {}, "", function()
    trigger_transaction(0x8107BB89, 2000000)
end)

menu.action(cash,"2M (Tuner Robbery Money Limited)", {}, "", function()
    trigger_transaction(0x921FCF3C, 2000000)
end)

menu.action(cash,"2M (Business Hub Money Limited)", {}, "", function()
    trigger_transaction(0x4B6A869C, 2000000)
end)

menu.action(cash,"1M (Music Trip Money Limited)", {}, "", function()
    trigger_transaction(0xDF314B5A, 1000000)
end)

menu.action(cash,"1M (Daily Objective Event Money Limited)", {}, "", function()
    trigger_transaction(0x314FB8B0, 1000000)
end)

menu.action(cash,"1M (Daily Objective Money Limited)", {}, "", function()
    trigger_transaction(0xBFCBE6B6, 1000000)
end)

menu.action(cash,"680K (Betting Money Limited)", {}, "", function()
    trigger_transaction(0xACA75AAE, 680000)
end)

menu.action(cash,"500K (Juggalo Story Money Limited)", {}, "", function()
    trigger_transaction(0x05F2B7EE, 500000)
end)

menu.action(cash,"310K (Vehicle Export Money Limited)", {}, "", function()
    trigger_transaction(0xEE884170, 310000)
end)

menu.action(cash,"200K (DoomsDay Finale Bonus Money Limited)", {}, "", function()
    trigger_transaction(0xBA16F44B, 200000)
end)

menu.action(cash,"200K (Action Figures Money Limited)", {}, "", function()
    trigger_transaction(0x9145F938, 200000)
end)

menu.action(cash,"200K (Collectibles Money Limited)", {}, "", function()
    trigger_transaction(0xCDCF2380, 200000)
end)

menu.action(cash,"190K (Vehicle Sales Money Limited)", {}, "", function()
    trigger_transaction(0xFD389995, 190000)
end)

