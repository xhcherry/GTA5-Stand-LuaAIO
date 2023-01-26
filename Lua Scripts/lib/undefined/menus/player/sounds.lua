-- Undefined
--==============狗白又看你爹脚本是吧
local Player<const> = require "undefined.player"
local Utils<const> = require "undefined.utils"

---@param soundsSubmenu CommandRef
---@param pid Player
local function setupPlayerSoundsMenu(soundsSubmenu, pid)
    menu.toggle_loop(soundsSubmenu, "耳朵要爽死了", {}, "一次发出很少的声音来炸他们的耳朵", function()
        local player = Player.getPlayerPed(pid)
        AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Crash", player, "WASTEDSOUNDS", true, true)
        AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "BED", player, "DLC_HEIST_HACKING_SNAKE_SOUNDS", true, true)
        AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "BASE_JUMP_PASSED", player, "HUD_AWARDS", true, true)
        AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Hack_Fail", player, "DLC_sum20_Business_Battle_AC_Sounds", true, true)
        AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Beep_Red", player, "DLC_HEIST_HACKING_SNAKE_SOUNDS", true, true)
        util.yield(20)
    end)

    menu.toggle_loop(soundsSubmenu, "没有声音", {}, "", function()
        AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "BED", Player.getPlayerPed(pid), "浪费的声音", true, true)
        util.yield(5800)
    end)

    menu.toggle_loop(soundsSubmenu, "游艇喇叭声音", {}, "", function()
        AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Horn", Player.getPlayerPed(pid), "DLC_Apt_Yacht_Ambient_Soundset", true, true)
        util.yield(900)
    end)

    menu.toggle_loop(soundsSubmenu, "任务成功声音", {}, "", function()
        AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "BASE_JUMP_PASSED", Player.getPlayerPed(pid), "HUD_AWARDS", true, true)
        util.yield(1250)
    end)

    menu.toggle_loop(soundsSubmenu, "越界计时器声音", {}, "", function()
        AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Out_of_Bounds_Explode", Player.getPlayerPed(pid), "MP_MISSION_COUNTDOWN_SOUNDSET", true, true)
        util.yield(5000)
    end)

    menu.toggle_loop(soundsSubmenu, "防空系统启动声音", {Utils.getCommandName("airdefense")}, "", function()
        AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Air_Defences_Activated", Player.getPlayerPed(pid), "DLC_sum20_Business_Battle_AC_Sounds", true, true)
        util.yield(8000)
    end)

    menu.toggle_loop(soundsSubmenu, "防空系统失效声音", {}, "", function()
        AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Air_Defenses_Disabled", Player.getPlayerPed(pid), "DLC_sum20_Business_Battle_AC_Sounds", true, true)
        util.yield(2000)
    end)

    menu.toggle_loop(soundsSubmenu, "黑入失败声音", {}, "", function()
        AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Hack_Fail", Player.getPlayerPed(pid), "DLC_sum20_Business_Battle_AC_Sounds", true, true)
        util.yield(1500)
    end)

    menu.toggle_loop(soundsSubmenu, "黑入成功声音", {}, "", function()
        AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Hack_Success", Player.getPlayerPed(pid), "DLC_sum20_Business_Battle_AC_Sounds", true, true)
        util.yield(1500)
    end)

    menu.toggle_loop(soundsSubmenu, "关闭电源声音", {}, "", function()
        AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Power_Down", Player.getPlayerPed(pid), "DLC_HEIST_HACKING_SNAKE_SOUNDS", true, true)
        util.yield(1500)
    end)

    menu.toggle_loop(soundsSubmenu, "蜂鸣音", {}, "", function()
        AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Beep_Green", Player.getPlayerPed(pid), "DLC_HEIST_HACKING_SNAKE_SOUNDS", true, true)
        util.yield(1500)
    end)
end

return setupPlayerSoundsMenu
