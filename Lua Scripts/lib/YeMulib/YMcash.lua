--credut to abuazizv for the orginal rebound lua
util.require_natives(1663599433)
--shameless skidded from MB
local function SetGlobalInt(address, value)
    memory.write_int(memory.script_global(address), value)
end

        function GetGlobalInt(global)
            return memory.read_int(memory.script_global(global))
        end
		
local limted = menu.list(cash, "交易限制", {}, "")



function trigger_transaction(hash, amount)
    SetGlobalInt(4536533+ 1, 2147483646)
    SetGlobalInt(4536533+ 7, 2147483647)
    SetGlobalInt(4536533+ 6, 0)
    SetGlobalInt(4536533+ 5, 0)
    SetGlobalInt(4536533+ 3, hash)
    SetGlobalInt(4536533+ 2, amount)
    SetGlobalInt(4536533,2)
	end
	
menu.toggle_loop(cash,"100万循环[最佳]", {}, "", function()
    trigger_transaction(0x615762F1, 1000000)
	util.yield()
end)



menu.toggle_loop(cash,"5万循环", {}, "", function()
    trigger_transaction(0x610F9AB4, 50000)
	util.yield()
end)

menu.toggle_loop(cash,"400万循环(慢)", {}, "", function()
    trigger_transaction(0x176D9D54, 15000000)
	util.yield(3000)
	trigger_transaction(0xED97AFC1, 7000000)
	util.yield(3000)
	trigger_transaction(0xA174F633, 15000000)
	util.yield(3000)
	trigger_transaction(0x314FB8B0, 1000000)
	util.yield(3000)
	trigger_transaction(0x4B6A869C, 2000000)
	util.yield(40000)
end)

menu.toggle_loop(cash,"5000筹码循环", {}, "", function()
    SetGlobalInt(1971266, 1)
	util.yield(3000)
end)

--from heist control
menu.toggle_loop(cash,"阻止交易错误", {}, "", function()
            if not util.is_session_started() then return end
            if GetGlobalInt(4536683) == 4 or 20 then
                SetGlobalInt(4536677, 0)
            end
        end)
		
local Options = {
    {name = "15M (Bend Job)", hash = 0x176D9D54, amount = 15000000},
    {name = "15M (Bend Bonus)", hash = 0xA174F633, amount = 15000000},
    {name = "15M (Criminal Mastermind)", hash = 0x3EBB7442, amount = 15000000},
    {name = "15M (Gangpos Mastermind)", hash = 0x23F59C7C, amount = 15000000},
    {name = "7M (Gang)", hash = 0xED97AFC1, amount = 7000000},
    {name = "3.6M (Casino Heist)", hash = 0xB703ED29, amount = 3619000},
    {name = "3M (Agency Story)", hash = 0xBD0D94E3, amount = 3000000},
    {name = "3M (Gangpos Mastermind)", hash = 0x370A42A5, amount = 3000000},
    {name = "2.5M (Gang)", hash = 0x46521174, amount = 2550000},
    {name = "2.5M (Island Heist)", hash = 0xDBF39508, amount = 2550000},
    {name = "2M (Gangpos Award Order)", hash = 0x32537662, amount = 2000000},
    {name = "2M (Heist Awards)", hash = 0x8107BB89, amount = 2000000},
    {name = "2M (Tuner Robbery)", hash = 0x921FCF3C, amount = 2000000},
    {name = "2M (Business Hub)", hash = 0x4B6A869C, amount = 2000000},
    {name = "1.5M (Gangpos Loyal Award)", hash = 0x33E1D8F6, amount = 1500000},
    {name = "1.2M (Boss Agency)", hash = 0xCCFA52D, amount = 1200000},
    {name = "1M (Music Trip)", hash = 0xDF314B5A, amount = 1000000},
    {name = "1M (Daily Objective Event)", hash = 0x314FB8B0, amount = 1000000},
    {name = "1M (Daily Objective)", hash = 0xBFCBE6B6, amount = 1000000},
    {name = "1M (Juggalo Story Award)", hash = 0x615762F1, amount = 1000000},
    {name = "700K (Gangpos Loyal Award)", hash = 0xED74CC1D, amount = 700000},
    {name = "680K (Betting)", hash = 0xACA75AAE, amount = 680000},
    {name = "620K (Vehicle Export)", hash = 0xEE884170, amount = 620000},
    {name = "500K (Casino Straight Flush)", hash = 0x059E889DD, amount = 500000},
    {name = "500K (Juggalo Story)", hash = 0x05F2B7EE, amount = 500000},
    {name = "400K (Cayo Heist Award Professional)", hash = 0xAC7144BC, amount = 400000},
    {name = "400K (Cayo Heist Award Cat Burglar)", hash = 0xB4CA7969, amount = 400000},
    {name = "400K (Cayo Heist Award Elite Thief)", hash = 0xF5AAD2DE, amount = 400000},
    {name = "400K (Cayo Heist Award Island Thief)", hash = 0x1868FE18, amount = 400000},
    {name = "350K (Casino Heist Award Elite Thief)", hash = 0x7954FD0F, amount = 350000},
    {name = "300K (Casino Heist Award All Rounder)", hash = 0x234B8864, amount = 300000},
    {name = "300K (Casino Heist Award Pro Thief)", hash = 0x2EC48716, amount = 300000},
    {name = "300K (Ambient Job Blast)", hash = 0xC94D30CC, amount = 300000},
    {name = "300K (Premium Job)", hash = 0xFD2A7DE7, amount = 300000},
    {name = "270K (Smuggler Agency)", hash = 0x1B9AFE05, amount = 270000},
    {name = "250K (Casino Heist Award Professional)", hash = 0x5D7FD908, amount = 250000},
    {name = "250K (Fixer Award Agency Story)", hash = 0x87356274, amount = 250000},
    {name = "200K (DoomsDay Finale Bonus)", hash = 0x9145F938, amount = 200000},
    {name = "200K (Action Figures)", hash = 0xCDCF2380, amount = 200000},
    {name = "190K (Vehicle Sales)", hash = 0xFD389995, amount = 190000},
    {name = "180K (Jobs)", hash = -0x3D3A1CC7, amount = 180000}
}

for i, v in ipairs(Options) do
menu.action(limted,v.name, {}, "", function()
        trigger_transaction(v.hash, v.amount)
    end)
end

