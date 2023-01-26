-- Undefined
--==============狗白又看你爹脚本是吧
util.keep_running()
local mainGitlabPath = "/undefinedscripts/undefined-for-stand/-/raw/main/"

-- Check if all required files exist
local REQUIRED_FILES<const> = {"lib/natives-1663599433.lua", "lib/undefined/utils.lua", "lib/undefined/raycast.lua", "lib/undefined/network.lua",
                               "lib/undefined/player.lua", "lib/undefined/ped.lua", "lib/undefined/vehicle.lua", "lib/undefined/menus/main.lua", "lib/undefined/menus/session.lua",
                               "lib/undefined/menus/session/onlinelist.lua", "lib/undefined/menus/session/aiminfo.lua", "lib/undefined/menus/vehicle.lua",
                               "lib/undefined/menus/aim.lua", "lib/undefined/menus/aim/ped.lua", "lib/undefined/menus/aim/settings.lua", "lib/undefined/menus/aim/vehicle.lua",
                               "lib/undefined/menus/aim/beam.lua", "lib/undefined/menus/aim/object.lua", "lib/undefined/menus/aim/teleport.lua", "lib/undefined/menus/teleport.lua",
                               "lib/undefined/menus/world.lua", "lib/undefined/menus/player.lua", "lib/undefined/menus/player/neutral.lua",--===
                               "lib/undefined/menus/player/trolling.lua", "lib/undefined/menus/player/sounds.lua", "lib/undefined/menus/player/vehicle.lua",
                               "lib/undefined/menus/player/malicious.lua", "lib/undefined/updater.lua", "lib/undefined/constants.lua", "Undefined.lua"}

local startScript<const> = require "lib.undefined.menus.main"
local CONSTANTS<const> = require "lib.undefined.constants"
local Utils<const> = require "lib.undefined.utils"
--local setupUpdater<const> = require "lib.undefined.updater"
--local updateActionRef<const> = setupUpdater(mainGitlabPath, REQUIRED_FILES)

local SCRIPTS_DIR<const> = filesystem.scripts_dir()
local fileMissing = false

UND_privateMode = false
--====
if filesystem.exists(filesystem.scripts_dir() .. "lib/undefined/menus/self/private.lua") then
    UND_privateMode = true
end

for _, file in REQUIRED_FILES do
    if not filesystem.exists(SCRIPTS_DIR .. file) then
        Utils.showToast("一些必需的文件丢失了，我将尝试下载它们.")
        fileMissing = true
        break
    end
end

--local checkUpdatesRef

--local function checkForUpdates(auto)
    --local success = function(resBody)
     --   if not string.find(resBody, CONSTANTS.SCRIPT.VERSION) or fileMissing then
      --      menu.set_visible(checkUpdatesRef, false)
       --     menu.set_visible(updateActionRef, true)
       --     if auto ~= true then
       --         menu.focus(updateActionRef)
        --        menu.trigger_command(updateActionRef)
        --    else
          --      Utils.showToast("现在有一个新版本。使用菜单中的更新脚本选项进行更新.")
         --   end
      --  elseif auto ~= true then
         --   Utils.showToast("没有更新.")
     --   end
  --  end
   -- async_http.init("https://gitlab.com", mainGitlabPath .. "lib/undefined/constants.lua", success)
    --async_http.dispatch()
--end

--checkUpdatesRef = menu.action(Undefined, "检查更新", {}, "", checkForUpdates)

--if fileMissing then
  --  checkForUpdates()
  --  return
--end

startScript()
--checkForUpdates(true)
