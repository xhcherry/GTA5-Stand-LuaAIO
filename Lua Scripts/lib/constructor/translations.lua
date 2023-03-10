-- Constructor Translations

local SCRIPT_VERSION = "0.28"
local translations = {}

---
--- Debug Log
---

local function debug_log(message, additional_details)
    if CONSTRUCTOR_CONFIG.debug_mode then
        if CONSTRUCTOR_CONFIG.debug_mode == 2 and additional_details ~= nil then
            message = message .. "\n" .. inspect(additional_details)
        end
        util.log("[constructor_translations] "..message)
    end
end

---
--- Translation Helpers
---

translations.lang = {}
translations.current_translations = {}
translations.missing_translations = {}
local LANG_STRING_NOT_FOUND = "/!\\ STRING NOT FOUND /!\\"

function CONSTRUCTOR_TRANSLATE_FUNCTION(text)
    local translated_string = translations.current_translations[text]
    if translated_string ~= nil and translated_string ~= LANG_STRING_NOT_FOUND then
        --debug_log("Found local translation for '"..text.."'")
        return translated_string
    end
    local label_id = lang.find(text, "en")
    if label_id then
        --debug_log("Found global translation for '"..text.."'")
        translated_string = lang.get_string(label_id, lang.get_current())
        if translated_string ~= LANG_STRING_NOT_FOUND then
            return translated_string
        end
    else
        --debug_log("Missing translation: "..text)
        translations.missing_translations[text] = text
    end
    return text
end

translations.inject_custom_translations = function()
    for lang_id, language_key in pairs(translations.GAME_LANGUAGE_IDS) do
        if translations.lang[lang_id] ~= nil then
            --debug_log("Processing translations language "..lang_id)
            lang.set_translate(lang_id)
            for english_string, translated_string in pairs(translations.lang[lang_id]) do
                local label_id = lang.find(english_string, "en")
                --debug_log("Found label for '"..english_string.."' as label "..label_id)
                if (not label_id) or label_id == 0 then
                    label_id = lang.register(english_string)
                    --debug_log("Registered '"..english_string.."' as label "..label_id)
                end
                local existing_translation = lang.get_string(label_id, lang_id)
                if (not existing_translation) or existing_translation == english_string or existing_translation == LANG_STRING_NOT_FOUND then
                    --debug_log("Adding translation for "..lang_id.." '"..english_string.."' ["..label_id.."] as '"..translated_string.."'  Existing translation: '"..existing_translation.."'")
                    if label_id > 0 then
                        local translate_status, translate_response = pcall(lang.translate, label_id, translated_string)
                        if not translate_status then
                            debug_log("Failed to add translation '"..english_string.."' as label "..label_id)
                        end
                    else
                        --debug_log("Cannot translate internal label")
                    end
                    if lang_id == lang.get_current() then
                        translations.current_translations[english_string] = translated_string
                    end
                else
                    --debug_log("Found translation for "..lang_id.." '"..english_string.."' ["..label_id.."] as '"..existing_translation.."'")
                end
            end
        end
    end
end

translations.log_missing_translations = function()
    util.toast("Logged "..#translations.missing_translations.." missing translations", TOAST_ALL)
    util.log(inspect(translations.missing_translations))
end

translations.GAME_LANGUAGE_IDS = {
    ["en"] = "en-US",
    ["fr"] = "fr-FR",
    ["de"] = "de-DE",
    ["it"] = "it-IT",
    ["es"] = "es-ES",
    ["pt"] = "pt-BR",
    ["pl"] = "pl-PL",
    ["ru"] = "ru-RU",
    ["ko"] = "ko-KR",
    ["zh"] = "zh-TW",
    ["ja"] = "ja-JP",
}
translations.LANGUAGE_NAMES = {
    ["en-US"] = "English",
    ["fr-FR"] = "French",
    ["de-DE"] = "German",
    ["it-IT"] = "Italian",
    ["es-ES"] = "Spanish",
    ["pt-BR"] = "Brazilian",
    ["pl-PL"] = "Polish",
    ["ru-RU"] = "Russian",
    ["ko-KR"] = "Korean",
    ["zh-TW"] = "Chinese (Traditional)",
    ["ja-JP"] = "Japanese",
    ["es-MX"] = "Spanish (Mexican)",
    ["zh-CN"] = "Chinese (Simplified)"
}

translations.lang = {}

--- Chinese (Simplified)
--- By       Zelda Two

translations.lang["zh"] = {
    ["More stable, but updated less often."] = "?????????,?????????????????????.",
    ["Cutting edge updates, but less stable."] = "????????????,??????????????????",
    ["Loading..."] = "??????...",
    ["Installing auto-updater..."] = "??????????????????...",
    ["Error downloading auto-updater: "] = "????????????????????????: ",
    ["Found empty file."] = "???????????????.",
    ["Could not open file for writing."] = "??????????????????????????????.",
    ["Successfully installed auto-updater lib"] = "???????????????????????????lib",
    ["Error downloading auto-updater lib. Update failed to download."] = "??????????????????lib??????.??????????????????.",
    ["Error downloading auto-updater lib. HTTP Request timeout"] = "??????lib?????????.HTTP????????????",
    ["Invalid auto-updater lib. Please delete your Stand/Lua Scripts/lib/auto-updater.lua and try again"] = "??????????????????lib.???????????????Stand/Lua Scripts/lib/auto-updater.lua ??????????????????",
    ["translations"] = "??????",
    ["Missing translation: "] = "????????????: ",
    ["Adding translations for language "] = "?????????????????? ",
    ["Found label for "] = "???????????? ",
    ["Registered "] = "?????? ",
    ["Saving translation for "] = "???????????? ",
    ["Could not natives lib. Make sure it is selected under Stand > Lua Scripts > Repository > natives-1663599433"] = "??????lib.?????????????????? Stand > Lua Scripts > Repository > natives-1663599433",
    ["Max table depth reached"] = "???????????????????????????",
    ["Adding attachment to construct "] = "????????????????????? ",
    ["Removing preview "] = "???????????? ",
    ["Adding a preview "] = "????????????",
    ["Building construct plan description "] = "???????????????????????????",
    ["Adding preview for construct plan "] = "???????????????????????? ",
    ["Shoot (or press J) to add "] = "?????? (?????? J) ????????? ",
    ["Attaching "] = "?????? ",
    ["Adding spawned construct to list "] = "????????????????????????????????? ",
    ["Creating construct from vehicle handle "] = "?????????????????????????????? ",
    ["Vehicle is already a construct"] = "?????????????????????",
    ["Saving construct "] = "???????????? ",
    ["Cannot write to file "] = "?????????????????? ",
    ["Cannot save vehicle: Error serializing."] = "??????????????????:???????????????.",
    ["Deleting construct "] = "????????????",
    ["Spawning construct from plan "] = "????????????????????? ",
    ["Failed to spawn construct from plan "] = "????????????????????????????????? ",
    ["Building construct from plan name="] = "?????????????????????????????????=",
    ["Clean up on close"] = "?????????????????????",
    ["Rebuilding "] = "?????? ",
    ["Invalid construct file. "] = "??????????????????. ",
    ["Could not read file '"] = "?????????????????? '",
    ["Failed to load XML file: "] = "???????????? XML ??????: ",
    ["Failed to load INI file: "] = "???????????? INI ??????: ",
    ["Failed to load JSON file: "] = "???????????? JSON ??????: ",
    ["Loading construct plan file from "] = "?????????????????????????????????????????? ",
    ["Failed to load construct from file "] = "??????????????????????????? ",
    ["Loaded construct plan "] = "????????????????????? ",
    ["Animating peds "] = "?????? peds ",
    ["Rebuilding ped "] = "?????? ped ",
    ["Rebuilding reattach to menu "] = "????????????????????? ",
    ["Max depth reached while reattaching"] = "???????????????????????????????????????",
    ["Reattaching "] = "???????????? ",
    ["Load More"] = "????????????",
    ["Attachment missing handle"] = "??????????????????",
    ["Rebuilding attachment menu "] = "?????????????????? ",
    ["Name"] = "??????",
    ["Set name of the attachment"] = "???????????????",
    ["Position"] = "??????",
    ["Offset"] = "??????",
    ["X: Left / Right"] = "X: ???/???",
    ["Y: Forward / Back"] = "Y: ???/???",
    ["Z: Up / Down"] = "Z: ???/???",
    ["Rotation"] = "??????",
    ["X: Pitch"] = "X: ??????",
    ["Y: Roll"] = "Y: ??????",
    ["Z: Yaw"] = "Z: ??????",
    ["World Position"] = "???????????????",
    ["World Rotation"] = "???????????????",
    ["Hold SHIFT to fine tune"] = "??????SHIFT???????????????",
    ["Options"] = "????????????",
    ["Visible"] = "??????",
    ["Will the attachment be visible, or invisible"] = "??????????????????????????????",
    ["Collision"] = "??????",
    ["Will the attachment collide with things, or pass through them"] = "?????????????????????????????????????????????",
    ["Invincible"] = "??????",
    ["Will the attachment be impervious to damage, or be damageable. AKA Godmode."] = "????????????????????????.",
    ["Gravity"] = "??????",
    ["Will the attachment be effected by gravity, or be weightless"] = "????????????????????????????????????",
    ["Frozen"] = "??????",
    ["Will the attachment be frozen in place, or allowed to move freely"] = "??????????????????????????????????????????????????????",
    ["VEHICLE"] = "??????",
    ["Vehicle Options"] = "????????????",
    ["Engine Always On"] = "????????????",
    ["Radio Loud"] = "????????????",
    ["If enabled, vehicle radio will play loud enough to be heard outside the vehicle."] = "?????????????????????????????????????????????????????????.",
    ["Sirens"] = "??????",
    ["Off"] = "???",
    ["Lights Only"] = "?????????",
    ["Sirens and Lights"] = "???????????????",
    ["Invis Wheels"] = "????????????",
    ["Door Lock Status"] = "????????????",
    ["Vehicle door locks"] = "????????????",
    ["Dirt Level"] = "????????????",
    ["How dirty is the vehicle"] = "???????????????",
    ["Bullet Proof Tires"] = "????????????",
    ["Burst Tires"] = "??????",
    ["Are tires burst"] = "????????????",
    ["Broken Doors"] = "????????????",
    ["Remove doors and trunks"] = "????????????????????????",
    ["Break Door: Front Left"] = "?????????:??????",
    ["Break Door: Front Right"] = "?????????:??????",
    ["Break Door: Back Right"] = "?????????:??????",
    ["Break Door: Hood"] = "?????????: ?????????",
    ["Break Door: Trunk"] = "?????????: ?????????",
    ["Break Door: Trunk2"] = "?????????: ?????????2",
    ["Remove door."] = "?????????.",
    ["Ped Options"] = "????????????",
    ["Can Rag Doll"] = "?????????",
    ["If enabled, the ped can go limp."] = "????????????,ped????????????????????????.",
    ["Armor"] = "??????",
    ["How much armor does the ped have."] = "ped???????????????",
    ["On Fire"] = "??????",
    ["Will the ped be burning on fire, or not"] = "ped???????????????",
    ["Clothes"] = "??????",
    ["Props"] = "??????",
    ["Attachment Options"] = "????????????",
    ["Attached"] = "??????",
    ["Is this child physically attached to the parent, or does it move freely on its own."] = "????????????????????????????????????????????????,??????????????????.",
    ["Change Parent"] = "????????????",
    ["Select a new parent for this child. Construct will be rebuilt to accommodate changes."] = "??????????????????????????????????????????,??????????????????.",
    ["Bone Index"] = "??????????????????",
    ["Which bone of the parent should this entity be attached to"] = "??????????????????????????????????????????",
    ["Bone Index Picker"] = "????????????",
    ["Some common bones can be selected by name"] = "????????????????????????????????????",
    ["Soft Pinning"] = "?????????",
    ["Will the attachment detach when repaired"] = "???????????????????????????",
    ["Separate"] = "??????",
    ["Detach attachment from construct to create a new construct"] = "??????????????????????????????????????????",
    ["Copy to Me"] = "????????????",
    ["Attach a copy of this object to your Ped."] = "??????Ped???????????????????????????.",
    ["Making ped into "] = "??? ped ?????? ",
    ["More Options"] = "????????????",
    ["LoD Distance"] = "????????????",
    ["Level of Detail draw distance"] = "??????????????????",
    ["Blip"] = "??????",
    ["Blip Sprite"] = "????????????",
    ["Icon to show on mini map for this construct"] = "???????????????????????????????????????",
    ["Blip Color"] = "????????????",
    ["Mini map icon color"] = "????????????????????????",
    ["Blip Reference"] = "????????????",
    ["Reference website for blip details"] = "???????????????????????????????????????",
    ["Lights"] = "???",
    ["Light On"] = "??????",
    ["If attachment is a light, it will be on and lit (many lights only work during night time)."] = "?????????????????????,?????????????????????(??????????????????????????????).",
    ["Light Disabled"] = "??????",
    ["If attachment is a light, it will be ALWAYS off, regardless of others settings."] = "??????????????????,???????????????,???????????????????????????????????????????????????.",
    ["Proofs"] = "??????",
    ["Bullet Proof"] = "??????",
    ["If attachment is impervious to damage from bullets."] = "????????????????????????",
    ["Fire Proof"] = "??????",
    ["If attachment is impervious to damage from fire."] = "????????????????????????",
    ["Explosion Proof"] = "?????????",
    ["If attachment is impervious to damage from explosions."] = "????????????????????????",
    ["Melee Proof"] = "?????????",
    ["If attachment is impervious to damage from melee attacks."] = "????????????????????????",
    ["Attachments"] = "??????",
    ["Add Attachment"] = "????????????",
    ["Options for attaching other entities to this construct"] = "?????????????????????????????????.",
    ["Curated"] = "????????????",
    ["Browse a curated collection of attachments"] = "???????????????????????????",
    ["Search"] = "??????",
    ["Search for a prop by name"] = "???????????????????????????",
    ["Add by Name"] = "????????????",
    ["Add an object, vehicle, or ped by exact name."] = "????????????????????????????????????????????????.",
    ["Object by Name"] = "????????????",
    ["Add an in-game object by exact name. To search for objects try https://gta-objects.xyz/"] = "????????????????????????",
    ["Ped by Name"] = "????????????",
    ["Add a vehicle by exact name."] = "????????????????????????",
    ["Open gta-objects.xyz"] = "???????????????????????????????????????",
    ["Website for browsing and searching for props"] = "????????????????????????????????????",
    ["Add Attachment Gun"] = "???????????????",
    ["Anything you shoot with this enabled will be added to the current construct"] = "??????????????????????????????????????????????????????????????????",
    ["Edit Attachments"] = "????????????",
    ["Clone"] = "??????",
    ["Clone (In Place)"] = "?????? (??????)",
    ["Clone Reflection: X:Left/Right"] = "???????????????X:???/???",
    ["Clone Reflection: Y:Front/Back"] = "???????????????Y:???/???",
    ["Clone Reflection: Z:Up/Down"] = "???????????????Z:???/???",
    ["Actions"] = "??????",
    ["Teleport"] = "??????",
    ["Teleport Into Vehicle"] = "???????????????",
    ["Teleport Me to Construct"] = "???????????? ??????",
    ["Teleport Construct to Me"] = "?????? ????????????",
    ["Debug Info"] = "????????????",
    ["Rebuild"] = "????????????",
    ["Delete construct (if it still exists), then recreate a new one from scratch."] = "?????????????????????????????????.",
    ["Save As"] = "?????????",
    ["Save construct to disk"] = "????????????????????????",
    ["Delete"] = "??????",
    ["Delete construct and all attachments. Cannot be reconstructed unless saved."] = "???????????????????????????.?????????????????????????????????.",
    ["Are you sure you want to delete this construct? "] = "????????????????????????????????? ",
    [" children will also be deleted."] = " ?????????????????????.",
    ["Edit Attachments"] = "????????????",
    ["Rebuilding attachment menu "] = "?????????????????? ",
    ["Focusing on attachment menu "] = "?????????????????? ",
    ["Create New Construct"] = "???????????????",
    ["Vehicle"] = "??????",
    ["From Current"] = "????????????",
    ["Create a new construct based on current (or last in) vehicle"] = "???????????????(???????????????)????????????",
    ["Error: You must be (or recently been) in a vehicle to create a construct from it"] = "??????:??????????????????????????????(???????????????)??????????????????",
    ["From Vehicle Name"] = "????????????",
    ["Create a new construct from an exact vehicle name"] = "???????????????????????????",
    ["Structure (Map)"] = "??????(??????)",
    ["From New Construction Cone"] = "????????????",
    ["Create a new stationary construct"] = "???????????????????????????????????????",
    ["From Object Name"] = "????????????",
    ["Create a new stationary construct from an exact object name"] = "?????????????????????????????????????????????",
    ["Ped (Player Skin)"] = "????????????(????????????)",
    ["From Me"] = "????????????",
    ["Create a new construct from your player Ped"] = "?????????????????????????????????",
    ["Player is already a construct"] = "??????????????????????????????",
    ["From Ped Name"] = "????????????",
    ["Create a new Ped construct from exact name"] = "????????????????????????????????????",
    ["Load Construct"] = "???????????????",
    ["Load a previously saved or shared construct into the world"] = "?????????????????????????????????????????????",
    ["Loaded Constructs"] = "???????????????",
    ["View and edit already loaded constructs"] = "????????????????????????????????????",
    ["Search all your construct files"] = "?????????????????????",
    ["Edit your search query"] = "???????????????",
    ["No results found"] = "??????????????????",
    ["Missing downloaded file "] = "?????????????????? ",
    ["File downloaded "] = "??????????????? ",
    ["Unzipping"] = "???????????????",
    ["Unzipped"] = "????????????",
    ["Open Constructs Folder"] = "?????????????????????",
    ["Open constructs folder. Share your creations or add new creations here."] = "?????????????????????.?????????????????????????????????????????????.",
    ["Download Curated Constructs"] = "??????????????????",
    ["Download a curated collection of constructs."] = "???????????????????????????",
    ["Drive Spawned Vehicles"] = "??????????????????",
    ["When spawning vehicles, automatically place you into the drivers seat."] = "???????????????????????????????????????????????????.",
    ["Wear Spawned Peds"] = "???????????????????????????",
    ["When spawning peds, replace your player skin with the ped."] = "?????????????????????????????????????????????????????????????????????.",
    ["Browse"] = "??????",
    ["Global Configs"] = "????????????",
    ["Edit Offset Step"] = "???????????????",
    ["The amount of change each time you edit an attachment offset (hold SHIFT for fine tuning)"] = "???????????????????????????????????????(??????SHIFT???????????????)",
    ["Edit Rotation Step"] = "???????????????",
    ["The amount of change each time you edit an attachment rotation (hold SHIFT for fine tuning)"] = "???????????????????????????????????????(??????SHIFT???????????????)",
    ["Show Previews"] = "????????????",
    ["Show previews when adding attachments"] = "???????????????????????????",
    ["Preview Display Delay"] = "??????????????????",
    ["After browsing to a construct or attachment, wait this long before showing the preview."] = "?????????????????????????????????,??????????????????????????????.",
    ["Delete All on Unload"] = "?????????????????????????????????",
    ["Deconstruct all spawned constructs when unloading Constructor"] = "???????????????????????????????????????????????????",
    ["Clean Up"] = "??????",
    ["Remove nearby vehicles, objects and peds. Useful to delete any leftover construction debris."] = "?????????????????????????????????,?????????ped??????",
    ["Script Meta"] = "????????????",
    ["Constructor"] = "[??????]Constructor",
    ["Version"] = "??????",
    ["Release Branch"] = "???????????????",
    ["Switch from main to dev to get cutting edge updates, but also potentially more bugs."] = "???main[??????]?????????dev[??????]??????????????????bug.",
    ["Check for Update"] = "????????????",
    ["The script will automatically check for updates at most daily, but you can manually check using this option anytime."] = "?????????????????????????????????,???????????????????????????????????????.",
    ["No updates found"] = "????????????",
    ["Clean Reinstall"] = "??????????????????",
    ["Force an update to the latest version, regardless of current version."] = "???????????????????????????,????????????????????????.",
    ["Debug Mode"] = "????????????",
    ["Log additional details about Constructors actions."] = "??????????????????????????????Stand Log",
    ["Log Missing Translations"] = "??????????????????",
    ["Log any newly found missing translations"] = "???????????????????????????",
    ["Github Source"] = "Github??????",
    ["View source files on Github"] = "???Github??????????????????",
    ["Discord"] = "??????Discord",
    ["Open Discord Server"] = "??????Discord?????????",
    ["Credits"] = "??????",
    ["Developers"] = "??????",
    ["Main developer"] = "???????????????",
    ["Development, Testing, Suggestions and Support"] = "??????,???????????????",
    ["Inspirations"] = "??????",
    ["Much of Constructor is based on code originally copied from Jackz Vehicle Builder and this script wouldn't be possible without it. Constructor is just my own copy of Jackz's amazing work. Thank you Jackz!"] = "?????????Constructor????????????Jackz Vehicle Builder?????????,?????????.??????????????????????????????.?????????????????????Jackz????????????????????????.?????????,Jackz???",
    ["LanceSpooner is also a huge inspiration to this script. Thanks Lance!"] = "??????????????????LanceSpooner?????????,?????????Lance???",
    ["Install Curated Constructs"] = "??????????????????????????????",
    ["Download and install a curated collection of constructs from https://github.com/hexarobi/stand-curated-constructs"] = "??????????????????????????????????????????????????? https://github.com/hexarobi/stand-curated-constructs",
    ["Development, Ped Curation"] = "??????, Ped??????",
    ["Focus Menu on Spawned Constructs"] = "????????????????????????????????????",
    ["When spawning a construct, focus Stands menu on the newly spawned construct. Otherwise, stay in the Load Constructs menu."] = "???????????????????????????????????????????????????????????????",
    ["From Nearby"] = "????????????",
    ["Create a new construct based on nearby vehicle"] = "??????????????????????????????",
    ["Entity Options"] = "????????????",
    ["Additional options available for all entities."] = "???????????????",
    ["Alpha"] = "?????????",
    ["The amount of transparency the object has. Local only!"] = "??????????????????.????????????!",
    ["Mission Entity"] = "????????????",
    ["If attachment is treated as a mission entity."] = "???????????????????????????",
    ["Give Weapon"] = "????????????",
    ["Give the ped a weapon."] = "?????????ped??????",
    ["Vehicle by Name"] = "????????????",
    ["From Current Vehicle"] = "????????????",
    ["From Vehicle List"] = "????????????",
    ["Create a new construct from a list of vehicles"] = "????????????????????????????????????",
    ["From Object Search"] = "????????????",
    ["Create a new map by searching for a object"] = "???????????????????????????",
    ["From Current Ped"] = "????????????",
    ["From Ped List"] = "????????????",
    ["Create a new construct from a list of peds"] = "????????????????????????????????????",
    ["Spawn Entity Delay"] = "??????????????????",
    ["Pause after spawning any object. Useful for preventing issues when spawning large constructs with many objects."] = "?????????????????????????????????.",
    ["Freeze Position"] = "????????????",
    ["Will the construct be frozen in place, or allowed to move freely"] = "??????????????????????????????.",
    ["Particle Effects"] = "????????????",
    ["Browse a curated collection of particle effects"] = "????????????????????????",
    ["Clean Up Distance"] = "????????????",
    ["How far away the cleanup command will reach to delete entities."] = "??????????????????????????????",
    ["Info"] = "??????",
    ["Set name of the player that created this construct"] = "??????????????????????????????",
    ["Description"] = "??????",
    ["Set text to describe this construct"] = "??????????????????",
    ["Create a new construct from a base vehicle, object, or ped. Then extend it with attachments. Finally save your creation and share it with others."] = "?????????????????????????????????????????????????????????.???????????????????????????.??????????????????????????????????????????.",
    ["Set global configuration options."] = "????????????????????????",
    ["Information and options about the Constructor script itself."] = "???????????????????????????????????????",
    ["Chat Spawnable Dir"] = "??????????????????",
    ["Set a Constructs sub-folder to be spawnable by name. Only available for users with permission to use Spawn Commands. See Online>Chat>Commands"] = "???Constructs?????????????????????????????????.???????????????????????????????????????????????????.???????????????>??????>??????",
    ["Constructs Allowed Per Player"] = "???????????????",
    ["CqCq and Zelda Two"] = "Zelda Two",
    ["Chinese"] = "????????????",
    ["The number of constructs any one player can spawn at a time. When a player tried to spawn additional constructs past this limit, the oldest spawned construct will be deleted."] = "???????????????????????????,??????????????????????????????????????????.",
    ["Editing"] = "??????",
    ["Set configuration options relating to editing constructs."] = "???????????????constructs?????????????????????",
    ["Previews"] = "??????",
    ["Set configuration options relating to previewing constructs."] = "????????????constructs?????????????????????",
    ["Debug"] = "??????",
    ["Chat Spawn Commands"] = "??????????????????",
    ["Hold SHIFT to fine tune, or hold CONTROL to move ten steps at once."] = "??????SHIFT???????????????????????????Ctrl???????????????10???.",
    ["Set configuration options relating to debugging the menu."] = "???????????????????????????????????????",
    ["Set configuration options relating to spawning constructs."] = "????????????constructs?????????????????????",
    ["Translators"] = "??????",
    ["Auto-Update"] = "????????????",
    ["Automatically install updates as they are released. Disable if you cannot successfully fetch updates as normal."] = "????????????lua????????????????????????,?????????????????????,?????????????????????.",
}

---
--- Return
---

translations.inject_custom_translations()
return translations


