-- Constructor Translations

local SCRIPT_VERSION = "0.29"
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
    ["More stable, but updated less often."] = "更稳定,但更新频率较低.",
    ["Cutting edge updates, but less stable."] = "最新版本,但是不太稳定",
    ["Loading..."] = "加载...",
    ["Installing auto-updater..."] = "安装自动更新...",
    ["Error downloading auto-updater: "] = "自动更新下载错误: ",
    ["Found empty file."] = "发现空文件.",
    ["Could not open file for writing."] = "无法打开文件进行写入.",
    ["Successfully installed auto-updater lib"] = "成功安装自动更新到lib",
    ["Error downloading auto-updater lib. Update failed to download."] = "自动更新下载lib错误.更新下载失败.",
    ["Error downloading auto-updater lib. HTTP Request timeout"] = "下载lib时出错.HTTP请求超时",
    ["Invalid auto-updater lib. Please delete your Stand/Lua Scripts/lib/auto-updater.lua and try again"] = "无效自动更新lib.请删除你的Stand/Lua Scripts/lib/auto-updater.lua 然后在试一次",
    ["translations"] = "翻译",
    ["Missing translation: "] = "缺少翻译: ",
    ["Adding translations for language "] = "添加语言翻译 ",
    ["Found label for "] = "建立标签 ",
    ["Registered "] = "记录 ",
    ["Saving translation for "] = "保存翻译 ",
    ["Could not natives lib. Make sure it is selected under Stand > Lua Scripts > Repository > natives-1663599433"] = "没有lib.确保已经下载 Stand > Lua Scripts > Repository > natives-1663599433",
    ["Max table depth reached"] = "达到最大组合数量？",
    ["Adding attachment to construct "] = "添加附件到构造 ",
    ["Removing preview "] = "删除预览 ",
    ["Adding a preview "] = "添加预览",
    ["Building construct plan description "] = "建造构造平面图说明",
    ["Adding preview for construct plan "] = "为模型添加平面图 ",
    ["Shoot (or press J) to add "] = "射击 (或按 J) 到添加 ",
    ["Attaching "] = "附加 ",
    ["Adding spawned construct to list "] = "添加生成的构造到列表中 ",
    ["Creating construct from vehicle handle "] = "从载具手把中创建构造 ",
    ["Vehicle is already a construct"] = "载具已经是构造",
    ["Saving construct "] = "保存构造 ",
    ["Cannot write to file "] = "无法写入文件 ",
    ["Cannot save vehicle: Error serializing."] = "无法保存载具:序列化错误.",
    ["Deleting construct "] = "删除构造",
    ["Spawning construct from plan "] = "从计划生成构造 ",
    ["Failed to spawn construct from plan "] = "无法从平面图中生成构造 ",
    ["Building construct from plan name="] = "从平面图名称中生成构造=",
    ["Clean up on close"] = "关闭脚本时清理",
    ["Rebuilding "] = "重建 ",
    ["Invalid construct file. "] = "无效构造文件. ",
    ["Could not read file '"] = "无法读取文件 '",
    ["Failed to load XML file: "] = "无法加载 XML 文件: ",
    ["Failed to load INI file: "] = "无法加载 INI 文件: ",
    ["Failed to load JSON file: "] = "无法加载 JSON 文件: ",
    ["Loading construct plan file from "] = "从文件路径加载构造平面图文件 ",
    ["Failed to load construct from file "] = "无法从文件加载构造 ",
    ["Loaded construct plan "] = "加载构造平面图 ",
    ["Animating peds "] = "动画 peds ",
    ["Rebuilding ped "] = "重建 ped ",
    ["Rebuilding reattach to menu "] = "重新附加到菜单 ",
    ["Max depth reached while reattaching"] = "最大地下水位深度重新连接？",
    ["Reattaching "] = "重新连接 ",
    ["Load More"] = "加载更多",
    ["Attachment missing handle"] = "附件缺少手把",
    ["Rebuilding attachment menu "] = "重建附件菜单 ",
    ["Name"] = "名称",
    ["Set name of the attachment"] = "此组件名称",
    ["Position"] = "位置",
    ["Offset"] = "偏移",
    ["X: Left / Right"] = "X: 左/右",
    ["Y: Forward / Back"] = "Y: 前/后",
    ["Z: Up / Down"] = "Z: 上/下",
    ["Rotation"] = "旋转",
    ["X: Pitch"] = "X: 俯仰",
    ["Y: Roll"] = "Y: 翻滚",
    ["Z: Yaw"] = "Z: 偏摆",
    ["World Position"] = "世界：偏移",
    ["World Rotation"] = "世界：旋转",
    ["Hold SHIFT to fine tune"] = "按住SHIFT键进行微调",
    ["Options"] = "其他选项",
    ["Visible"] = "可见",
    ["Will the attachment be visible, or invisible"] = "附件是可见还是不可见",
    ["Collision"] = "碰撞",
    ["Will the attachment collide with things, or pass through them"] = "附件是会与物体碰撞还是穿过他们",
    ["Invincible"] = "无敌",
    ["Will the attachment be impervious to damage, or be damageable. AKA Godmode."] = "附件是不是无敌的.",
    ["Gravity"] = "重力",
    ["Will the attachment be effected by gravity, or be weightless"] = "附件是受重力影响还是失重",
    ["Frozen"] = "冻结",
    ["Will the attachment be frozen in place, or allowed to move freely"] = "附件会被冻结在原地，还是允许自由移动",
    ["VEHICLE"] = "载具",
    ["Vehicle Options"] = "载具选项",
    ["Engine Always On"] = "引擎启动",
    ["Radio Loud"] = "载具电台",
    ["If enabled, vehicle radio will play loud enough to be heard outside the vehicle."] = "如果开启载具电台声音大到可以在车外听到.",
    ["Sirens"] = "警笛",
    ["Off"] = "关",
    ["Lights Only"] = "仅灯光",
    ["Sirens and Lights"] = "警笛和灯光",
    ["Invis Wheels"] = "隐形轮胎",
    ["Door Lock Status"] = "门锁状态",
    ["Vehicle door locks"] = "载具门锁",
    ["Dirt Level"] = "污垢等级",
    ["How dirty is the vehicle"] = "载具有多脏",
    ["Bullet Proof Tires"] = "防弹轮胎",
    ["Burst Tires"] = "爆胎",
    ["Are tires burst"] = "车胎爆破",
    ["Broken Doors"] = "拆除车门",
    ["Remove doors and trunks"] = "移除车门和后备箱",
    ["Break Door: Front Left"] = "拆除门:左后",
    ["Break Door: Front Right"] = "拆除门:右前",
    ["Break Door: Back Right"] = "拆除门:右后",
    ["Break Door: Hood"] = "拆除门: 引擎盖",
    ["Break Door: Trunk"] = "拆除门: 后备箱",
    ["Break Door: Trunk2"] = "拆除门: 后备箱2",
    ["Remove door."] = "拆除门.",
    ["Ped Options"] = "人物选项",
    ["Can Rag Doll"] = "布娃娃",
    ["If enabled, the ped can go limp."] = "如果启用,ped将没有布娃娃系统.",
    ["Armor"] = "护甲",
    ["How much armor does the ped have."] = "ped有多少护甲",
    ["On Fire"] = "着火",
    ["Will the ped be burning on fire, or not"] = "ped会不会着火",
    ["Clothes"] = "衣服",
    ["Props"] = "道具",
    ["Attachment Options"] = "附件选项",
    ["Attached"] = "附加",
    ["Is this child physically attached to the parent, or does it move freely on its own."] = "这个附着物是附加在身体上还是父级,还是自由移动.",
    ["Change Parent"] = "更改父级",
    ["Select a new parent for this child. Construct will be rebuilt to accommodate changes."] = "为这个附着物更换一个新的父级,构造将被重建.",
    ["Bone Index"] = "骨骼附加位置",
    ["Which bone of the parent should this entity be attached to"] = "此实体应附加到父级的哪个骨骼",
    ["Bone Index Picker"] = "骨骼搜索",
    ["Some common bones can be selected by name"] = "可以按常见名称来搜索骨骼",
    ["Soft Pinning"] = "软固定",
    ["Will the attachment detach when repaired"] = "维修时附件会分离吗",
    ["Separate"] = "分离",
    ["Detach attachment from construct to create a new construct"] = "从构造中分离附件以创建新构造",
    ["Copy to Me"] = "复制到我",
    ["Attach a copy of this object to your Ped."] = "将此Ped的附件附加到你身上.",
    ["Making ped into "] = "将 ped 变成 ",
    ["More Options"] = "更多选项",
    ["LoD Distance"] = "细节距离",
    ["Level of Detail draw distance"] = "细节绘制距离",
    ["Blip"] = "图标",
    ["Blip Sprite"] = "地图图标",
    ["Icon to show on mini map for this construct"] = "在小地图上显示该构造的图标",
    ["Blip Color"] = "图标颜色",
    ["Mini map icon color"] = "小地图的图标颜色",
    ["Blip Reference"] = "图标参考",
    ["Reference website for blip details"] = "参考网站地图图标的详细信息",
    ["Lights"] = "灯",
    ["Light On"] = "开灯",
    ["If attachment is a light, it will be on and lit (many lights only work during night time)."] = "如果附附件是灯,它是否会被打开(很多灯只会在晚上工作).",
    ["Light Disabled"] = "禁灯",
    ["If attachment is a light, it will be ALWAYS off, regardless of others settings."] = "如果附件是灯,它将被关闭,只要你开了这个无论这么设置都是关闭.",
    ["Proofs"] = "防护",
    ["Bullet Proof"] = "防弹",
    ["If attachment is impervious to damage from bullets."] = "附件不受子弹伤害",
    ["Fire Proof"] = "防火",
    ["If attachment is impervious to damage from fire."] = "附件不受火焰伤害",
    ["Explosion Proof"] = "防爆炸",
    ["If attachment is impervious to damage from explosions."] = "附件不受爆炸伤害",
    ["Melee Proof"] = "防近战",
    ["If attachment is impervious to damage from melee attacks."] = "附件不受近战伤害",
    ["Attachments"] = "附件",
    ["Add Attachment"] = "添加附件",
    ["Options for attaching other entities to this construct"] = "添加其他附件到该组件内.",
    ["Curated"] = "附件大全",
    ["Browse a curated collection of attachments"] = "浏览精心挑选的附件",
    ["Search"] = "搜索",
    ["Search for a prop by name"] = "按名称搜索大致附件",
    ["Add by Name"] = "搜索添加",
    ["Add an object, vehicle, or ped by exact name."] = "搜索准确名称添加物体，车辆或人物.",
    ["Object by Name"] = "物体名称",
    ["Add an in-game object by exact name. To search for objects try https://gta-objects.xyz/"] = "搜索准确名称添加",
    ["Ped by Name"] = "人物名称",
    ["Add a vehicle by exact name."] = "搜索准确名称添加",
    ["Open gta-objects.xyz"] = "打开用于搜索模型名称的网站",
    ["Website for browsing and searching for props"] = "用于浏览和搜索附件的网站",
    ["Add Attachment Gun"] = "附件添加枪",
    ["Anything you shoot with this enabled will be added to the current construct"] = "启用此功能射击的任何物体都将添加到当前构造中",
    ["Edit Attachments"] = "编辑附件",
    ["Clone"] = "克隆",
    ["Clone (In Place)"] = "克隆 (原处)",
    ["Clone Reflection: X:Left/Right"] = "克隆映像：X:左/右",
    ["Clone Reflection: Y:Front/Back"] = "克隆映像：Y:前/后",
    ["Clone Reflection: Z:Up/Down"] = "克隆映像：Z:上/下",
    ["Actions"] = "行动",
    ["Teleport"] = "传送",
    ["Teleport Into Vehicle"] = "传送到载具",
    ["Teleport Me to Construct"] = "传送我到 构造",
    ["Teleport Construct to Me"] = "构造 传送到我",
    ["Debug Info"] = "调试信息",
    ["Rebuild"] = "重新创建",
    ["Delete construct (if it still exists), then recreate a new one from scratch."] = "删除当前组件并重新生成.",
    ["Save As"] = "另存为",
    ["Save construct to disk"] = "将构造保存到磁盘",
    ["Delete"] = "删除",
    ["Delete construct and all attachments. Cannot be reconstructed unless saved."] = "删除构造和所有附件.除非保存，否则无法重建.",
    ["Are you sure you want to delete this construct? "] = "您确定要删除此构造吗？ ",
    [" children will also be deleted."] = " 附件也将被删除.",
    ["Edit Attachments"] = "编辑附件",
    ["Rebuilding attachment menu "] = "重建附件菜单 ",
    ["Focusing on attachment menu "] = "调整附件菜单 ",
    ["Create New Construct"] = "创建新构造",
    ["Vehicle"] = "载具",
    ["From Current"] = "当前载具",
    ["Create a new construct based on current (or last in) vehicle"] = "在当前载具(或最后一辆)进行构建",
    ["Error: You must be (or recently been) in a vehicle to create a construct from it"] = "错误:你必须在坐过当前载具(或最后一辆)才能进行构造",
    ["From Vehicle Name"] = "载具名称",
    ["Create a new construct from an exact vehicle name"] = "搜索载具名称并生成",
    ["Structure (Map)"] = "构造(地图)",
    ["From New Construction Cone"] = "物体构造",
    ["Create a new stationary construct"] = "搜索并创建一个新的固定模型",
    ["From Object Name"] = "物体名称",
    ["Create a new stationary construct from an exact object name"] = "从物体名称搜索一个新的固定模型",
    ["Ped (Player Skin)"] = "玩家模型(玩家皮肤)",
    ["From Me"] = "构造自己",
    ["Create a new construct from your player Ped"] = "对当前模型进行自我构造",
    ["Player is already a construct"] = "玩家已经是一个构造体",
    ["From Ped Name"] = "人物名称",
    ["Create a new Ped construct from exact name"] = "搜索创建一个新的人物模型",
    ["Load Construct"] = "加载构造体",
    ["Load a previously saved or shared construct into the world"] = "将保存或共享的构造加载到世界中",
    ["Loaded Constructs"] = "已加载构造",
    ["View and edit already loaded constructs"] = "查看和编辑已经加载的构造",
    ["Search all your construct files"] = "搜索文件并生成",
    ["Edit your search query"] = "搜索构造体",
    ["No results found"] = "没有搜索结果",
    ["Missing downloaded file "] = "缺少下载文件 ",
    ["File downloaded "] = "文件已下载 ",
    ["Unzipping"] = "正在解压缩",
    ["Unzipped"] = "已解压缩",
    ["Open Constructs Folder"] = "打开模组文件夹",
    ["Open constructs folder. Share your creations or add new creations here."] = "打开模组文件夹.在此处分享您的作品或添加新作品.",
    ["Download Curated Constructs"] = "下载精选模组",
    ["Download a curated collection of constructs."] = "下载精选的模组集合",
    ["Drive Spawned Vehicles"] = "驾驶生成载具",
    ["When spawning vehicles, automatically place you into the drivers seat."] = "生成载具时，自动将您置于驾驶员座位.",
    ["Wear Spawned Peds"] = "穿上生成的人物模型",
    ["When spawning peds, replace your player skin with the ped."] = "生成人物模型后将用人物模型的皮肤代替玩家的皮肤.",
    ["Browse"] = "浏览",
    ["Global Configs"] = "全局配置",
    ["Edit Offset Step"] = "编辑偏移量",
    ["The amount of change each time you edit an attachment offset (hold SHIFT for fine tuning)"] = "每次编辑附件偏移时的变化量(按住SHIFT键进行微调)",
    ["Edit Rotation Step"] = "编辑旋转量",
    ["The amount of change each time you edit an attachment rotation (hold SHIFT for fine tuning)"] = "每次编辑附件旋转时的变化量(按住SHIFT键进行微调)",
    ["Show Previews"] = "显示预览",
    ["Show previews when adding attachments"] = "选择附件时显示预览",
    ["Preview Display Delay"] = "显示预览延迟",
    ["After browsing to a construct or attachment, wait this long before showing the preview."] = "在浏览一个组件或单附件,需要多久才会显示出来.",
    ["Delete All on Unload"] = "停止脚本时删除所有生成",
    ["Deconstruct all spawned constructs when unloading Constructor"] = "停止脚本时解构所有生成的组件或附件",
    ["Clean Up"] = "清理",
    ["Remove nearby vehicles, objects and peds. Useful to delete any leftover construction debris."] = "移除附近所有生成的载具,物体和ped组件",
    ["Script Meta"] = "脚本信息",
    ["Constructor"] = "[构造]Constructor",
    ["Version"] = "版本",
    ["Release Branch"] = "更新发布处",
    ["Switch from main to dev to get cutting edge updates, but also potentially more bugs."] = "从main[稳定]切换到dev[开发]可能会有更多bug.",
    ["Check for Update"] = "检查更新",
    ["The script will automatically check for updates at most daily, but you can manually check using this option anytime."] = "脚本会每天自动检查更新,但是你也可以用此项手动检查.",
    ["No updates found"] = "没有更新",
    ["Clean Reinstall"] = "清除重新安装",
    ["Force an update to the latest version, regardless of current version."] = "强制更新到最新版本,而不考虑当前版本.",
    ["Debug Mode"] = "调试模式",
    ["Log additional details about Constructors actions."] = "记录构造者调试信息到Stand Log",
    ["Log Missing Translations"] = "记录缺失翻译",
    ["Log any newly found missing translations"] = "记录任何缺失的翻译",
    ["Github Source"] = "Github资源",
    ["View source files on Github"] = "在Github上查看源文件",
    ["Discord"] = "官方Discord",
    ["Open Discord Server"] = "打开Discord服务器",
    ["Credits"] = "鸣谢",
    ["Developers"] = "开发",
    ["Main developer"] = "本脚本开发",
    ["Development, Testing, Suggestions and Support"] = "测试,建议和支持",
    ["Inspirations"] = "启示",
    ["Much of Constructor is based on code originally copied from Jackz Vehicle Builder and this script wouldn't be possible without it. Constructor is just my own copy of Jackz's amazing work. Thank you Jackz!"] = "大部分Constructor都是基于Jackz Vehicle Builder的代码,没有它.这个脚本就不可能实现.构造者只是我对Jackz惊人作品的复制品.谢谢你,Jackz！",
    ["LanceSpooner is also a huge inspiration to this script. Thanks Lance!"] = "构造者要感谢LanceSpooner的启发,谢谢你Lance！",
    ["Install Curated Constructs"] = "安装作者推荐精选模组",
    ["Download and install a curated collection of constructs from https://github.com/hexarobi/stand-curated-constructs"] = "从以下网站下载并安装精选的构造合集 https://github.com/hexarobi/stand-curated-constructs",
    ["Development, Ped Curation"] = "开发, Ped策划",
    ["Focus Menu on Spawned Constructs"] = "生成组件自动切换父级菜单",
    ["When spawning a construct, focus Stands menu on the newly spawned construct. Otherwise, stay in the Load Constructs menu."] = "生成组件时自动帮你切换到已加载的构造菜单中",
    ["From Nearby"] = "附近载具",
    ["Create a new construct based on nearby vehicle"] = "从附近载具创建新构造",
    ["Entity Options"] = "实体选项",
    ["Additional options available for all entities."] = "实体选择选",
    ["Alpha"] = "透明度",
    ["The amount of transparency the object has. Local only!"] = "该物体透明度.仅限本地!",
    ["Mission Entity"] = "任务实体",
    ["If attachment is treated as a mission entity."] = "附件被视为任务实体",
    ["Give Weapon"] = "给予武器",
    ["Give the ped a weapon."] = "给予该ped武器",
    ["Vehicle by Name"] = "载具名称",
    ["From Current Vehicle"] = "当前载具",
    ["From Vehicle List"] = "载具列表",
    ["Create a new construct from a list of vehicles"] = "从载具列表中生成新的载具",
    ["From Object Search"] = "物体名称",
    ["Create a new map by searching for a object"] = "搜索物体名称并生成",
    ["From Current Ped"] = "自我构造",
    ["From Ped List"] = "人物列表",
    ["Create a new construct from a list of peds"] = "从人物列表中生成新的人物",
    ["Spawn Entity Delay"] = "生成实体延迟",
    ["Pause after spawning any object. Useful for preventing issues when spawning large constructs with many objects."] = "每个实体生成之间的延迟.",
    ["Freeze Position"] = "冻结位置",
    ["Will the construct be frozen in place, or allowed to move freely"] = "附件是否被冻结在原地.",
    ["Particle Effects"] = "粒子特效",
    ["Browse a curated collection of particle effects"] = "预览精品粒子特效",
    ["Clean Up Distance"] = "清理距离",
    ["How far away the cleanup command will reach to delete entities."] = "实体的清除距离是多少",
    ["Info"] = "信息",
    ["Set name of the player that created this construct"] = "创建此模组的作者名字",
    ["Description"] = "描述",
    ["Set text to describe this construct"] = "此模组的描述",
    ["Create a new construct from a base vehicle, object, or ped. Then extend it with attachments. Finally save your creation and share it with others."] = "从一个车辆、物体或人物创建一个新的组合.然后用附件来拼接它.最后保存你的创作并与他人分享.",
    ["Set global configuration options."] = "设置全局配置选项",
    ["Information and options about the Constructor script itself."] = "关于此脚本的相关信息和选项",
    ["Chat Spawnable Dir"] = "聊天生成目录",
    ["Set a Constructs sub-folder to be spawnable by name. Only available for users with permission to use Spawn Commands. See Online>Chat>Commands"] = "将Constructs子文件夹设置为名称生成.仅适用于有权使用“生成命令”的用户.请参见线上>聊天>命令",
    ["Constructs Allowed Per Player"] = "构造体上限",
    ["CqCq and Zelda Two"] = "Zelda Two",
    ["Chinese"] = "中文翻译",
    ["The number of constructs any one player can spawn at a time. When a player tried to spawn additional constructs past this limit, the oldest spawned construct will be deleted."] = "玩家可生成的构造数,当生成指定数后将删除老的构造.",
    ["Editing"] = "编辑",
    ["Set configuration options relating to editing constructs."] = "设置编辑与constructs有关的配置选项",
    ["Previews"] = "预览",
    ["Set configuration options relating to previewing constructs."] = "设置预览constructs有关的配置选项",
    ["Debug"] = "调试",
    ["Chat Spawn Commands"] = "聊天生成命令",
    ["Hold SHIFT to fine tune, or hold CONTROL to move ten steps at once."] = "按住SHIFT键进行微调，或按住Ctrl键一次移动10倍.",
    ["Set configuration options relating to debugging the menu."] = "设置调试菜单有关的配置选项",
    ["Set configuration options relating to spawning constructs."] = "设置生成constructs有关的配置选项",
    ["Translators"] = "翻译",
    ["Auto-Update"] = "自动更新",
    ["Rotation Order"] = "旋转顺序",
    ["Set the order that rotations should be applied."] = "设置旋转顺序",
    ["Additional options available for Ped entities."] = "人物可用选项.",
    ["Make a new copy of this entity, at the same location as the original"] = "为该实体制作一个新的副本，位置与原实体相同",
    ["Make a new copy of this entity, but at the mirror location about the X-axis"] = "为该实体制作一个新的副本，位置在X轴镜像位置.",
    ["Make a new copy of this entity, but at the mirror location about the Y-axis"] = "为该实体制作一个新的副本，位置在Y轴镜像位置.",
    ["Make a new copy of this entity, but at the mirror location about the Z-axis"] = "为该实体制作一个新的副本，位置在Z轴镜像位置.",
    ["Move your player to the construct, or vice versa."] = "玩家传到构造或构造传送到玩家.",
    ["Information about the construct"] = "有关该构造的信息",
    ["Position and Rotation options"] = "位置和旋转选项",
    ["Configuration options for this entity"] = "该实体的配置选项",
    ["Modify other entities attached to this entity"] = "修改附加到此实体的其他实体",
    ["Make a copy of this attachment"] = "复制此附件",
    ["Move your player nearby the construct, but not inside of it."] = "将玩家传送到构造附近",
    ["Move the construct to be nearby your player"] = "将构造移动到玩家附近",
    ["Automatically install updates as they are released. Disable if you cannot successfully fetch updates as normal."] = "作者更新lua时会自动进行更新,如果你无法更新,请取消自动更新.",
}

---
--- Return
---

translations.inject_custom_translations()
return translations


