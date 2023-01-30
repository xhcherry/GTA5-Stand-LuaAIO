-- Curated Constructs Installer
menu.divider(menu.my_root(), "Downloading curated constructs.")
menu.divider(menu.my_root(), "When the download is complete, the files")
menu.divider(menu.my_root(), "will be extracted to your Constructs folder.")
menu.divider(menu.my_root(), "This will take a few minutes.")
menu.divider(menu.my_root(), "Please wait...")
local status_auto_updater, auto_updater = pcall(require, "auto-updater")
if not status_auto_updater then error("Could not load auto-updater") end

local CONSTRUCTS_DIR = filesystem.stand_dir() .. 'Constructs/'
local CURATED_CONSTRUCTS_DIR = CONSTRUCTS_DIR..'/Curated'
filesystem.mkdirs(CURATED_CONSTRUCTS_DIR)

local function download_and_extract_curated_constructs()
    local ZIP_FILE_STORE_PATH = "/Constructor/downloads/CuratedConstructs.zip"
    local DOWNLOADED_ZIP_FILE_PATH = filesystem.store_dir() .. ZIP_FILE_STORE_PATH

    util.toast("Downloading curated constructs...", TOAST_ALL)
    auto_updater.run_auto_update({
        source_url="https://codeload.github.com/hexarobi/stand-curated-constructs/zip/refs/heads/main",
        script_relpath="store"..ZIP_FILE_STORE_PATH,
        http_timeout=120000,
    })

    if not filesystem.exists(DOWNLOADED_ZIP_FILE_PATH) then
        error("Missing downloaded file "..DOWNLOADED_ZIP_FILE_PATH)
    end
    util.toast("Successfully downloaded curated constructs "..DOWNLOADED_ZIP_FILE_PATH, TOAST_ALL)

    util.toast("Extracting curated constructs...", TOAST_ALL)
    -- I could not find a way to extract a zip using simple lua. Running an OS command requires special user auth, but seems worth it.
    -- To avoid requiring these permissions, comment out the following line. The only effect will be lack of auto-installing curated constructs.
    util.i_really_need_manual_access_to_process_apis()
    local command = 'tar -C "'..CURATED_CONSTRUCTS_DIR..'" -xf "'..DOWNLOADED_ZIP_FILE_PATH..'" --strip-components=1'
    util.log("Running command: "..command)
    if os.execute(command) then
        util.toast("Successfully installed curated constructs!", TOAST_ALL)
        util.log("Cleaning up zip...", TOAST_ALL)
        os.remove(DOWNLOADED_ZIP_FILE_PATH)
        util.log("Cleaning up script...", TOAST_ALL)
        os.remove(filesystem.scripts_dir()..SCRIPT_RELPATH)
        util.log("Clean up complete.", TOAST_ALL)
        if CONSTRUCTOR_LOAD_CONSTRUCTS_MENU ~= nil then
            pcall(menu.focus, CONSTRUCTOR_LOAD_CONSTRUCTS_MENU)
        end
        menu.trigger_commands("constructorloadconstruct")
        util.stop_script()
    else
        util.toast("There was a problem extracting the curated constructs", TOAST_ALL)
    end
end

util.yield(1)
download_and_extract_curated_constructs()
