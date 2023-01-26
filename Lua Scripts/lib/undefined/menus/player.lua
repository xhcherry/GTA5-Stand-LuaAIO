-- Undefined
--==============狗白又看你爹脚本是吧
local Utils<const> = require "undefined.utils"
local CONSTANTS<const> = require "undefined.constants"
local Player<const> = require "undefined.player"

local setupPlayerNeutralMenu = require "lib.undefined.menus.player.neutral"
local setupPlayerTrollingMenu = require "lib.undefined.menus.player.trolling"
local setupPlayerSoundsMenu = require "lib.undefined.menus.player.sounds"
local setupPlayerVehicleMenu = require "lib.undefined.menus.player.vehicle"
local setupPlayerMaliciousMenu = require "lib.undefined.menus.player.malicious"

UND_followEnabledFor = 0

local function setupPlayerMenu()
    players.on_join(function(pid)
        local playerRootMenu = menu.player_root(pid)
        menu.divider(playerRootMenu, "CqCq Script2.0")

        -- Neutral
        local neutralSubmenu = menu.list(playerRootMenu, "友好选项", {}, "")
        setupPlayerNeutralMenu(neutralSubmenu, pid)

        -- Trolling
        local trollingSubmenu = menu.list(playerRootMenu, "恶搞选项", {}, "")
        setupPlayerTrollingMenu(trollingSubmenu, pid)

        -- Sounds
        local soundsSubmenu = menu.list(playerRootMenu, "声音选项", {}, "使用前，您还可以听到音量降低的声音!")
        setupPlayerSoundsMenu(soundsSubmenu, pid)

        -- Vehicle
        local vehicleSubmenu = menu.list(playerRootMenu, "车辆恶搞", {}, "")
        setupPlayerVehicleMenu(vehicleSubmenu, pid)

        -- Vehicle
        local maliciousSubmenu = menu.list(playerRootMenu, "移除选项", {}, "")
        setupPlayerMaliciousMenu(maliciousSubmenu, pid)

        if UND_privateMode then
            local setupPlayerPrivateMenu = require "lib.undefined.menus.player.private"
            local privateSubmenu = menu.list(playerRootMenu, "UNDFD", {}, "")
            setupPlayerPrivateMenu(privateSubmenu, pid)
        end
    end)

    players.dispatch_on_join()
end

return setupPlayerMenu
