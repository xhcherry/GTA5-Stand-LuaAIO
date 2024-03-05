package.preload['src.lib.utils'] = (function (...)
					local _ENV = _ENV;
					local function module(name, ...)
						local t = package.loaded[name] or _ENV[name] or { _NAME = name };
						package.loaded[name] = t;
						for i = 1, select("#", ...) do
							(select(i, ...))(t);
						end
						_ENV = t;
						_M = t;
						return t;
					end
				-- package.loaded["src.lib.utils"] = nil
local moduleExports = {}

function moduleExports.tableToUrlParams(t)
    local url_params = {}
    for k, v in pairs(t) do
        table.insert(url_params, moduleExports.url_encode(k) .. '=' .. moduleExports.url_encode(v))
    end
    return table.concat(url_params, "&")
end

function moduleExports.url_encode(text)
    if (text) then
        text = string.gsub(text, "\n", "\r\n")
        text = string.gsub(text, "([^%w ])", function(c)
            return string.format("%%%02X", string.byte(c))
        end)
        text = string.gsub(text, " ", "+")
    end
    return text
end

function moduleExports.url_decode(text)
    return string.gsub(text, "%+", " ")
end

function moduleExports.unicode_escape(unicode)
    return utf8.char(tonumber(unicode, 16))
end

function moduleExports.templateReplace(template, ...)
    local args = { ... }
    local result = template:gsub("{arg(%d+)}", function(n)
        return args[tonumber(n)]
    end)
    return result
end

function moduleExports.toast(template, ...)
    local args = { ... }
    local result = template:gsub("{arg(%d+)}", function(n)
        return args[tonumber(n)]
    end)
    util.toast(result, TOAST_ALL)
end

function moduleExports.debugLog(message)
    if Config.debugMode then
        local formattedMessage = string.format("[%s] %s", SCRIPT_NAME, message)
        util.toast(formattedMessage)
        util.log(formattedMessage)
    end
end

function moduleExports.extractJSON(responseText)
    local jsonStr = responseText:match("(%b{})")
    return jsonStr and json.decode(jsonStr) or nil
end

function moduleExports.isJSON(text)
    local jsonStr = text:match("(%b{})")
    return jsonStr ~= nil
end

---@param windowName string #Must be a label
---@param maxInput integer
---@param defaultText string
---@return string
function moduleExports.get_input_from_screen_keyboard(windowName, maxInput, defaultText)
    MISC.DISPLAY_ONSCREEN_KEYBOARD(0, windowName, "", defaultText, "", "", "", maxInput);
    while MISC.UPDATE_ONSCREEN_KEYBOARD() == 0 do util.yield_once() end
    if MISC.UPDATE_ONSCREEN_KEYBOARD() == 1 then return MISC.GET_ONSCREEN_KEYBOARD_RESULT() end
    return ""
end

return moduleExports
 end)
package.preload['src.lib.updater'] = (function (...)
					local _ENV = _ENV;
					local function module(name, ...)
						local t = package.loaded[name] or _ENV[name] or { _NAME = name };
						package.loaded[name] = t;
						for i = 1, select("#", ...) do
							(select(i, ...))(t);
						end
						_ENV = t;
						_M = t;
						return t;
					end
				
local moduleExports = {}

local mainGitHubPath = "/Totoro-Li/PolyglotTranslator/main/"
local mainFileName = "PolyglotTranslator.lua"

local function parseVersionInfo(content)
    local majorPattern = "MAJOR%s*:%s*(%d+)"
    local minorPattern = "MINOR%s*:%s*(%d+)"
    local patchPattern = "PATCH%s*:%s*(%d+)"
    local changelogPattern = "CHANGELOG%s*(.-)%-%-%-%s*END OF VERSION"

    local major = tonumber(content:match(majorPattern))
    local minor = tonumber(content:match(minorPattern))
    local patch = tonumber(content:match(patchPattern))
    local changelog = content:match(changelogPattern)

    if not major or not minor or not patch then
        return nil
    end

    local changelogLines = {}
    for line in changelog:gmatch("[^\r\n]+") do
        table.insert(changelogLines, line)
    end

    return {
        major = major,
        minor = minor,
        patch = patch,
        changelog = changelogLines
    }
end


local function isUpdateNeeded(currentVersion, newVersion)
    if not newVersion then return false end
    polyglotUtils.debugLog("Current version: " .. currentVersion.major .. "." .. currentVersion.minor .. "." .. currentVersion.patch)
    polyglotUtils.debugLog("New version: " .. newVersion.major .. "." .. newVersion.minor .. "." .. newVersion.patch)

    if newVersion.major > currentVersion.major or
        (newVersion.major == currentVersion.major and newVersion.minor > currentVersion.minor) or
        (newVersion.major == currentVersion.major and newVersion.minor == currentVersion.minor and newVersion.patch > currentVersion.patch) then
        return true
    end

    return false
end


local function startUpdate(content, updateCallback)
    local newVersionInfo = parseVersionInfo(content)
    if not newVersionInfo then
        polyglotUtils.toast(LOC.unexpectedResponse)
        return
    end
    ---@type file*?
    local scriptFile = io.open(filesystem.scripts_dir() .. mainFileName, "rb")
    if scriptFile == nil then
        updateCallback(newVersionInfo)
        return
    end
    -- Read current version info and match with parseVersionInfo
    local versionInfo = parseVersionInfo(scriptFile:read("*a"))
    scriptFile:close()
    if isUpdateNeeded(versionInfo, newVersionInfo) then
        updateCallback(newVersionInfo)
    else
        polyglotUtils.toast(LOC.noUpdatesAvailable)
    end
end

local State <const> =
{
    Idle = 0,
    DownloadingScript = 1
}
local state = State.Idle



return moduleExports
 end)
package.preload['src.lib.translation'] = (function (...)
					local _ENV = _ENV;
					local function module(name, ...)
						local t = package.loaded[name] or _ENV[name] or { _NAME = name };
						package.loaded[name] = t;
						for i = 1, select("#", ...) do
							(select(i, ...))(t);
						end
						_ENV = t;
						_M = t;
						return t;
					end
				-- package.loaded["src.lib.translation"] = nil
local moduleExports = {}

local Languages = {
    {
        Name = "简体中文",
        Key = "zh-cn"
    }, {
        Name = "繁体中文",
        Key = "zh-tw"
    }, {
        Name = "英语",
        Key = "en"
    }, --[[{
        Name = "日语",
        Key = "ja"
    }, {
        Name = "俄语",
        Key = "ru"
    },  {
        Name = "韩语",
        Key = "ko"
    },]] }

LangPairs = {} -- Aux for sorting
LangKeyList = {}
LangNameList = {}
LangLookupByName = {}
LangLookupByKey = {}

for i = 1, #Languages do
    local Language = Languages[i]
    LangPairs[i] = {
        key = Language.Key,
        name = Language.Name
    }
    LangLookupByName[Language.Name] = Language.Key
    LangLookupByKey[Language.Key] = Language.Name
end

table.sort(LangPairs, function(a, b) return a.name < b.name end)

for i = 1, #LangPairs do
    LangKeyList[i] = LangPairs[i].key
    LangNameList[i] = LangPairs[i].name
end

ChatGPTPromptPresets = {
    ["Basic"] = "Translate the following message to {{lang}} in a natural and Internet style.",
    ["Cute with Emoticons"] = "Please translate the following text into {{lang}}, in the style of game message scenario with one emoticon at the end of message, be natural and without the feeling of machine translation. Context is related to Grand Theft Auto OL. Use simple emoticons containing ASCII letters like parentheses and quotation marks.",
    ["Add Emoticon At End"] = "Please add one cute emoticon(Kaomoji) at the end of message, according to the mood and emotion of message. Do not modify the words.",
    ["Model Roleplay"] = "You are a translation model. Please translate the following text to {{lang}}.",
    ["AI Self-aware"] = "As an AI language model, please convert the following text to {{lang}}."
}

ChatGPTPromptPresetsOptions = {}
for k, v in pairs(ChatGPTPromptPresets) do
    table.insert(ChatGPTPromptPresetsOptions, k)
end


local function googleTranslateCall(text, targetLang, onSuccess)
    local HEADERS = {
        ["User-Agent"] = "User-Agent",
        "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/14.0.1 Safari/605.1.15"
    }
    local params = {
        client = "dict-chrome-ex",
        sl = "auto",
        tl = targetLang,
        dt = "t",
        dj = "1",
        source = "input",
        q = polyglotUtils.url_encode(text)
    }

    async_http.init("translate.googleapis.com", "/translate_a/t?" .. polyglotUtils.tableToUrlParams(params),
        function(body, header_fields, status_code)
            if status_code == 200 and body ~= "" then
                polyglotUtils.debugLog("Google translate response: " .. body)
                local translation, sourceLang = body:match('%[%["(.-)","(.-)"%]%]')
                translation = translation:gsub("\\u(%x%x%x%x)", polyglotUtils.unicode_escape)
                translation = translation:gsub(" <code> 0 </code> ", "\n")
                translation = translation:gsub("<code>0</code>", "\n")
                translation = translation:gsub("\\(.)", "%1")
                onSuccess(translation, sourceLang)
            else
                polyglotUtils.toast(LOC.templates.errorTranslating, text, tostring(status_code))
            end
        end)
    for key, value in pairs(HEADERS) do async_http.add_header(key, value) end
    async_http.dispatch()
end

local function generatePromptFromPreset(preset, text, targetLang)
    local prompt = ChatGPTPromptPresets[preset] ..
                       " The translation should be provided in the following JSON format:\n```json\n{\n    \"translations\": [\n        {\n            \"t\": \"{{translated_message}}\",\n            \"s\": \"{{English name of source_language}}\"\n        }\n    ]\n}\n```\nMessage: {{text}}"
    prompt = prompt:gsub("{{lang}}", LangLookupByKey[targetLang]) -- Replace {lang} placeholder
    prompt = prompt:gsub("{{text}}", text) -- Replace {text} placeholder
    return prompt
end

local function chatGPTTranslateCall(text, targetLang, onSuccess)
    local apiKey = Config.apiKey
    if apiKey == nil or apiKey == "" then
        polyglotUtils.toast(LOC.templates.apiKeyNotSet)
        return
    end

    local prompt = generatePromptFromPreset(Config.chatGPTPromptPreset, text, targetLang)
    local postData = {
        model = "gpt-3.5-turbo",
        messages = {
            {
                role = "user",
                content = prompt
            }
        },
        stream = false
    }
    postData = json.encode(postData)
    async_http.init("api.openai.com", "/v1/chat/completions", function(body, header_fields, status_code)
        if status_code == 200 and body ~= "" then
            polyglotUtils.debugLog("ChatGPT response: " .. body)
            local response = json.decode(body)
            local responseContent = response.choices[1].message.content
            polyglotUtils.debugLog("ChatGPT response content: " .. responseContent)
            if polyglotUtils.isJSON(responseContent) then
                local translation = polyglotUtils.extractJSON(responseContent).translations[1]
                local translatedMessage = translation.t
                translatedMessage = translatedMessage:gsub("\\u0026", "&")
                translatedMessage = translatedMessage:gsub("\\\"", "\"")
                translatedMessage = translatedMessage:gsub("\\\\", "\\")
                translatedMessage = translatedMessage:gsub("~", " ")
                translatedMessage = translatedMessage:match("^%s*(.-)%s*$") -- Remove heading and trailing spaces
                local sourceLang = LangLookupByName[translation.s]
                onSuccess(translatedMessage, sourceLang or "en")
            else
                polyglotUtils.toast("The API returned a natural language response: " .. responseContent)
            end
        else
            polyglotUtils.toast(LOC.templates.errorTranslating, text, tostring(status_code))
        end
    end, function() polyglotUtils.toast(LOC.templates.errorConnectingToChatGPTAPI) end)
    async_http.set_post("application/json", postData)
    async_http.add_header("Authorization", "Bearer " .. apiKey)
    async_http.dispatch()
    polyglotUtils.debugLog("ChatGPT request sent with post data: " .. postData)
end

local translationMethods = {
    ["Google Translate"] = googleTranslateCall,
    -- ["Bing"] = bingTranslateCall,
}

TranslationMethodOptions = {
    "谷歌引擎",
    -- "Bing",
}


function moduleExports.translateText(text, targetLang, translationMethod, onSuccess)
    if translationMethods[translationMethod] then
        translationMethods[translationMethod](text, targetLang, function(translation, sourceLang)
            onSuccess(translation, sourceLang:lower())
        end)
    end
end

return moduleExports
 end)
package.preload['src.lib.chat'] = (function (...)
					local _ENV = _ENV;
					local function module(name, ...)
						local t = package.loaded[name] or _ENV[name] or { _NAME = name };
						package.loaded[name] = t;
						for i = 1, select("#", ...) do
							(select(i, ...))(t);
						end
						_ENV = t;
						_M = t;
						return t;
					end
				-- package.loaded["src.lib.chat"] = nil
local scaleformHandleTable = {}
local scaleformTypes = {
    ["number"] = GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_FLOAT,
    ["string"] = GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_PLAYER_NAME_STRING,
    ["boolean"] = GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_BOOL
}

local checkScaleformAndLoad = function(scaleformName)
    if not scaleformHandleTable[scaleformName] or
        not GRAPHICS.HAS_SCALEFORM_MOVIE_LOADED(scaleformHandleTable[scaleformName]) then
        local scaleformHandle = GRAPHICS.REQUEST_SCALEFORM_MOVIE(scaleformName)
        while not GRAPHICS.HAS_SCALEFORM_MOVIE_LOADED(scaleformHandle) do util.yield() end
        scaleformHandleTable[scaleformName] = scaleformHandle
        GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(scaleformHandle, 255, 255, 255, 255, 1)
    end
end

local function callScaleformMethod(scaleformName, method, ...)
    local args = {...}
    checkScaleformAndLoad(scaleformName)
    if GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleformHandleTable[scaleformName], method) then
        for i = 1, #args do
            local arg = args[i]
            local type = type(arg)
            local pushFunc = scaleformTypes[type]
            if pushFunc then
                pushFunc(arg)
            else
                error("Invalid type passed to scaleform method: " .. type)
            end
        end
        GRAPHICS.END_SCALEFORM_MOVIE_METHOD()
    end
end

---@param player string
---@param message string
---@param scope string
---@param teamOnly boolean
---@param eHudColour number
local function drawScaleformMultiplayerChat(player, message, scope, teamOnly, eHudColour)
    callScaleformMethod("MULTIPLAYER_CHAT", "ADD_MESSAGE", player, message, scope, teamOnly, eHudColour)
end

local moduleExports = {}

local colors = {
    topbar = {
        ["r"] = 50 / 255,
        ["g"] = 50 / 255,
        ["b"] = 50 / 255,
        ["a"] = 1.0
    }, -- grayish
    background = {
        ["r"] = 5 / 255,
        ["g"] = 5 / 255,
        ["b"] = 5 / 255,
        ["a"] = 0.5
    }, -- blackish
    subhead = {
        ["r"] = 1,
        ["g"] = 1,
        ["b"] = 1,
        ["a"] = 1.0
    }, -- white
    label = {
        ["r"] = 1,
        ["g"] = 1,
        ["b"] = 1,
        ["a"] = 1.0
    }, -- white
    highlight = {
        ["r"] = 160 / 255,
        ["g"] = 160 / 255,
        ["b"] = 160 / 255,
        ["a"] = 1.0
    } -- also grayish
}

TranslatedMsgLocationOptions = {
    LOC.translatedMsgLocationOptions.teamChatNotNetworked, LOC.translatedMsgLocationOptions.teamChatNetworked,
    LOC.translatedMsgLocationOptions.globalChatNotNetworked, LOC.translatedMsgLocationOptions.globalChatNetworked,
    LOC.translatedMsgLocationOptions.notification, LOC.translatedMsgLocationOptions.popup}

local messages = {}
local display_duration = 3000 -- Time in ms to display each message
local max_messages = 5 -- Maximum number of messages to display at a time

local function calculate_max_scale(text, max_width)
    local text_width, _ = directx.get_text_size(text)
    local scale = 1.0

    if text_width > max_width then scale = max_width / text_width end

    return scale
end

-- Helper function to wrap the text to fit the given width
local function wrap_text(text, width)
    local lines = {}
    local words = {}
    local line = ""
    local line_width

    for word in text:gmatch("%S+") do table.insert(words, word) end

    for i, word in ipairs(words) do
        if line == "" then
            line = word
        else
            line_width, _ = directx.get_text_size(line)
            if line_width < width then
                line = line .. " " .. word
            else
                table.insert(lines, line)
                line = word
            end
        end

        if i == #words then table.insert(lines, line) end
    end

    return lines
end
--气泡
local function display_popup(sender, message, src_language)
    local current_time = util.current_time_millis()
    table.insert(messages, {
        sender = sender,
        message = message,
        src_language = src_language,
        banner_color = {
            r = math.random(),
            g = math.random(),
            b = math.random(),
            a = 1.0
        },
        start_time = current_time
    })

    if #messages > max_messages then table.remove(messages, 1) end
end

util.create_tick_handler(function()
    local current_time = util.current_time_millis()

    for i, msg in ipairs(messages) do
        if current_time - msg.start_time > display_duration then
            table.remove(messages, i)
            break
        end

        local x, y, width, height = 0.75, 0.05 * (i - 1), 0.2, 0.05
        local padding = 0.005

        -- Calculate the maximum scale for sender name and message
        local sender_scale = calculate_max_scale(msg.sender, width * 0.4)
        local message_scale = calculate_max_scale(msg.message, width * 0.6)

        -- Draw the background rectangle
        directx.draw_rect(x, y, width, height, colors.background)
        directx.draw_rect(x, y, padding, height, msg.banner_color)

        -- Draw the sender name
        directx.draw_text(x + padding, y + padding / 2, msg.sender, ALIGN_TOP_LEFT, sender_scale, colors.label, true)

        -- Draw the message with word wrapping
        local wrapped_message = wrap_text(msg.message, width * 0.6)
        local line_spacing = 0.01
        local message_y = y + height / 2
        for _, line in ipairs(wrapped_message) do
            directx.draw_text(x + padding * 2 + width * 0.4, message_y, line, ALIGN_TOP_LEFT, message_scale,
                colors.subhead, true)
            message_y = message_y + line_spacing
        end

        -- Draw the source language
        directx.draw_text(x + width - padding, y + padding / 2, msg.src_language, ALIGN_TOP_RIGHT, 1.0, colors.highlight)
    end
end)

local botSend = false -- To avoid infinite loop
function moduleExports.createOnMessageCallback(translateTextCB)
    return function(sender, reserved, text, team_chat, networked, is_auto)
        if not Config.translateOn then return end
        if not botSend then
            if not Config.translateSelf and (sender == players.user()) then
                return
            else
                translateTextCB(text, Config.targetLanguageIncoming, Config.translationMethodIncoming,
                    function(translation, sourceLang)
                        ---@type string
                        local senderName = players.get_name(sender)
                        local resultText = translation
                        ---@type number
                        local colorFinal = Config.colorSelect
                        local translatedMsgLocation = Config.translatedMsgLocation
                        ---@type string
                        local teamChatLabel = Config.teamChatLabel
                        ---@type string
                        local allChatLabel = Config.allChatLabel
                        if Config.blacklistedLanguages[sourceLang] == true then return end
                        -- "Team Chat not networked", "Team Chat networked", "Global Chat not networked", "Global Chat networked", "Notification"
                        if (translatedMsgLocation == 1) then
                            drawScaleformMultiplayerChat(senderName, resultText, teamChatLabel, false, colorFinal)
                        end
                        if (translatedMsgLocation == 2) then
                            botSend = true
                            -- void chat.send_message(string text, bool team_chat, bool add_to_local_history, bool networked)
                            -- add_to_local_history set to false so that the message doesn't appear twice
                            chat.send_message(senderName .. " : " .. resultText, true, false, true)
                            drawScaleformMultiplayerChat(senderName, resultText, teamChatLabel, false, colorFinal)
                        end
                        if (translatedMsgLocation == 3) then
                            drawScaleformMultiplayerChat(senderName, resultText, allChatLabel, false, colorFinal)
                        end
                        if (translatedMsgLocation == 4) then
                            botSend = true
                            -- Ref : void chat.send_message(string text, bool team_chat, bool add_to_local_history, bool networked)
                            chat.send_message(senderName .. " : " .. resultText, false, false, true)
                            drawScaleformMultiplayerChat(senderName, resultText, allChatLabel, false, colorFinal)
                        end
                        if (translatedMsgLocation == 5) then
                            polyglotUtils.toast(senderName .. " : " .. resultText)
                        end
                        if (translatedMsgLocation == 6) then
                            notification("玩家: "..senderName.."\n翻译的消息: "..resultText.."\n初始语言: "..sourceLang)
                        end
                    end)
            end
        end
        botSend = false
    end
end

function moduleExports.sendMessage(myText, translateTextCB)
    translateTextCB(myText, Config.targetLanguageOutgoing, Config.translationMethodOutgoing,
        function(translation, sourceLang)
            -- for _, pId in ipairs(players.list()) do
            --     chat.send_targeted_message(pId, players.user(), translation, false)
            -- end
            -- void chat.send_message(string text, bool team_chat, bool add_to_local_history, bool networked)
            chat.send_message(translation, false, true, true)
            polyglotUtils.debugLog("Message sent: " .. translation)
        end)
end

function moduleExports.sendPrivateMessage(myText, pid, translateTextCB)
    translateTextCB(myText, Config.targetLanguageOutgoing, Config.translationMethodOutgoing,
        function(translation, sourceLang)
            local msg = polyglotUtils.templateReplace(LOC.sendingToPlayerLookupByKey[Config.targetLanguageOutgoing], players.get_name(pid)) .. translation
            chat.send_targeted_message(pid, players.user(), msg, true)
            chat.send_message(msg, true, true, false)
            polyglotUtils.debugLog("Message sent: " .. translation)
        end)
end

return moduleExports
 end)
package.preload['src.lib.localization'] = (function (...)
					local _ENV = _ENV;
					local function module(name, ...)
						local t = package.loaded[name] or _ENV[name] or { _NAME = name };
						package.loaded[name] = t;
						for i = 1, select("#", ...) do
							(select(i, ...))(t);
						end
						_ENV = t;
						_M = t;
						return t;
					end
				-- package.loaded["src.lib.localization"] = nil
local engTranslations = {
    noInternetAccess = "To use Polyglot Translator, please enable internet access",
    checkForUpdates = "Check for updates",
    checkForUpdatesD = "Check for updates for Polyglot Translator",
    updateInProgress = "Update in progress...",
    updating = "Updating...",
    failedToUpdate = "Failed to update the script file.",
    unexpectedResponse = "Unexpected update file. Local file will stay unchanged.",
    failedToDownloadFromGitHub = "Failed to download from GitHub.",
    changelog = "Changelog",
    noUpdatesAvailable = "No updates available.",
    chatGPTSettings = "ChatGPT Settings",
    chatGPTSettingsD = "ChatGPT Settings",
    apiKeyInput = "API Key",
    apiKeyInputD = "Enter your API key",
    chatGPTPromptPreset = "ChatGPT Prompt Preset",
    chatGPTPromptPresetD = "Choose the prompt preset for ChatGPT",
    temperature = "Temperature",
    temperatureD = "What sampling temperature to use, between 0 and 2. Higher values like 0.8 will make the output more random, while lower values like 0.2 will make it more focused and deterministic. We generally recommend altering this or top p but not both. (Default: 1)",
    topP = "Top P",
    topPD = "Number between 0 and 1. An alternative to sampling with temperature, called nucleus sampling, where the model considers the results of the tokens with top p probability mass. So 0.1 means only the tokens comprising the top 10% probability mass are considered. We generally recommend altering this or temperature but not both. (Default: 1)",
    presencePenalty = "Presence Penalty",
    presencePenaltyD = "Number between -2.0 and 2.0. Positive values penalize new tokens based on whether they appear in the text so far, increasing the model's likelihood to talk about new topics. (Default: 0)",
    frequencyPenalty = "Frequency Penalty",
    frequencyPenaltyD = "Number between -2.0 and 2.0. Positive values penalize new tokens based on their existing frequency in the text so far, decreasing the model's likelihood to repeat the same line verbatim. (Default: 0)",

    translatorListenerOn = "Translator Listener On",
    translatorListenerOnD = "Translator will listen to incoming messages and translate",
    translateYourself = "Translate Own Messages",
    translateYourselfD = "Translate messages sent by yourself",
    translatedMessageDisplay = "Translated Message Display",
    translatedMessageDisplayD = "Location of translated Message. You need to click to apply change",
    scriptSettings = "Other Settings For Polyglot Translator",
    scriptSettingsD = "Including color settings and updates",
    playerNameColor = "Player Name Color",
    customLabelForTeamTranslationD = "Leaving it blank will revert it to the original label",
    customLabelForAllTranslationD = "Leaving it blank will revert it to the original label",
    translatorListenerBlacklist = "Translator Listener Blacklist",
    translatorListenerBlacklistD = "Ignore messages in languages toggled on in this list",
    translationMethod = "Translation Method",
    translationMethodD = "Choose the translation method",
    incomingMessages = "Incoming Messages",
    incomingMessagesD = "Choose the translation method for incoming messages",
    outgoingMessages = "Outgoing Messages",
    outgoingMessagesD = "Choose the translation method for outgoing messages",
    targetLanguageIncoming = "Target Language Incoming",
    targetLanguageIncomingD = "Language to translate incoming messages to. You need to click to apply change",
    sendTranslatedMessage = "Send Translated Message",
    targetLanguageOutgoing = "Target Language Outgoing",
    targetLanguageOutgoingD = "Language to translate your messages to. You need to click to apply change",
    sendMessage = "Send Message",
    sendMessageD = "Input the text for your message",
	credits = "Credits",
    translatedMsgLocationOptions = {
        teamChatNotNetworked = "Team Chat not networked",
        teamChatNetworked = "Team Chat networked",
        globalChatNotNetworked = "Global Chat not networked",
        globalChatNetworked = "Global Chat networked",
        notification = "Stand Notification",
        popup = "Popup"
    },
    templates = {
        -- Example: "ChatGPT Prompt Preset changed to {arg1} "
        updateSuccessful = "Update successful, current version: {arg1}",
        apiKeyNotSet = "API key not set. Please enter your API key in the settings",
        errorTranslating = "Error translating, Original message: {arg1}, Status code: {arg2}",
        errorConnectingToChatGPTAPI = "Error connecting to ChatGPT API",
        chatGPTPromptChangedTo = "ChatGPT Prompt Preset changed to {arg1}",
        selectedColor = "Selected color: {arg1}",
        customLabelForTeamTranslation = "Custom Label For [{arg1}] Translation",
        customLabelForAllTranslation = "Custom Label For [{arg1}] Translation",
        translationMethodIncomingChangedTo = "Translation Method Incoming changed to {arg1}",
        translationMethodOutgoingChangedTo = "Translation Method Outgoing changed to {arg1}",
        sendingToPlayer = "[To {arg1}] "
    },

    CustomLabels = {
        inputMessage = "Please input your message"
    }
}
local esTranslations = {
    noInternetAccess = "Para usar Polyglot Translator, habilite el acceso a internet",
    checkForUpdates = "Buscar actualizaciones",
    checkForUpdatesD = "Buscar actualizaciones para Polyglot Translator",
    updateInProgress = "Actualización en curso...",
    updating = "Actualizando...",
    failedToUpdate = "Error al actualizar el archivo de script.",
    unexpectedResponse = "Archivo de actualización inesperado. El archivo local no cambiará.",
    failedToDownloadFromGitHub = "Error al descargar desde GitHub.",
    noUpdatesAvailable = "No hay actualizaciones disponibles.",
    changelog = "Registro de cambios",
    chatGPTSettings = "Ajustes de ChatGPT",
    chatGPTSettingsD = "Ajustes de ChatGPT",
    apiKeyInput = "Clave API",
    apiKeyInputD = "Ingrese su clave API",
    chatGPTPromptPreset = "Preajuste de indicaciones de ChatGPT",
    chatGPTPromptPresetD = "Elija el preajuste de indicaciones para ChatGPT",
    temperature = "Temperatura",
    temperatureD = "La temperatura de muestreo a utilizar, entre 0 y 2. Valores más altos como 0.8 harán que la salida sea más aleatoria, mientras que valores más bajos como 0.2 la harán más enfocada y determinista. Generalmente recomendamos alterar esto o el top p pero no ambos. (Por defecto: 1)",
    topP = "Top P",
    topPD = "Número entre 0 y 1. Una alternativa al muestreo con temperatura, llamada muestreo del núcleo, donde el modelo considera los resultados de los tokens con la masa de probabilidad top p. Entonces, 0.1 significa que solo se consideran los tokens que comprenden el 10% superior de la masa de probabilidad. Generalmente recomendamos alterar esto o la temperatura, pero no ambos. (Por defecto: 1)",
    presencePenalty = "Penalización de presencia",
    presencePenaltyD = "Número entre -2.0 y 2.0. Los valores positivos penalizan los nuevos tokens según si aparecen en el texto hasta ahora, aumentando la probabilidad del modelo de hablar sobre nuevos temas. (Por defecto: 0)",
    frequencyPenalty = "Penalización de frecuencia",
    frequencyPenaltyD = "Número entre -2.0 y 2.0. Los valores positivos penalizan los nuevos tokens según su frecuencia existente en el texto hasta ahora, disminuyendo la probabilidad del modelo de repetir la misma línea textual. (Por defecto: 0)",

    translatorListenerOn = "Escucha del traductor activada",
    translatorListenerOnD = "El traductor escuchará los mensajes entrantes y los traducirá",
    translateYourself = "Traducir mensajes propios",
    translateYourselfD = "Traducir mensajes enviados por usted mismo",
    translatedMessageDisplay = "Visualización del mensaje traducido",
    translatedMessageDisplayD = "Ubicación del mensaje traducido. Debe hacer clic para aplicar el cambio",
    scriptSettings = "Otros ajustes para Polyglot Translator",
    scriptSettingsD = "Incluyendo ajustes de color y actualizaciones",
    playerNameColor = "Color del nombre del jugador",
    customLabelForTeamTranslationD = "Dejar en blanco volverá a la etiqueta original",
    customLabelForAllTranslationD = "Dejar en blanco volverá a la etiqueta original",
    translatorListenerBlacklist = "Lista negra del escucha del traductor",
    translatorListenerBlacklistD = "Ignorar mensajes en idiomas activados en esta lista",
    translationMethod = "Método de traducción",
    translationMethodD = "Elija el método de traducción",
    incomingMessages = "Mensajes entrantes",
    incomingMessagesD = "Elija el método de traducción para mensajes entrantes",
    outgoingMessages = "Mensajes salientes",
    outgoingMessagesD = "Elija el método de traducción para mensajes salientes",
    targetLanguageIncoming = "Idioma objetivo entrante",
    targetLanguageIncomingD = "Idioma para traducir mensajes entrantes. Debe hacer clic para aplicar el cambio",
    sendTranslatedMessage = "Enviar mensaje traducido",
    targetLanguageOutgoing = "Idioma objetivo saliente",
    targetLanguageOutgoingD = "Idioma para traducir sus mensajes. Debe hacer clic para aplicar el cambio",
    sendMessage = "Enviar mensaje",
    sendMessageD = "Ingrese el texto para su mensaje",
    translatedMsgLocationOptions = {
        teamChatNotNetworked = "Chat de equipo no conectado en red",
        teamChatNetworked = "Chat de equipo conectado en red",
        globalChatNotNetworked = "Chat global no conectado en red",
        globalChatNetworked = "Chat global conectado en red",
        notification = "Notificación estándar",
        popup = "Ventana emergente"
    },
    templates = {
        -- Example: "ChatGPT Prompt Preset changed to {arg1} "
        updateSuccessful = "Actualización exitosa, versión actual: {arg1}",
        apiKeyNotSet = "Clave API no establecida. Ingrese su clave API en la configuración",
        errorTranslating = "Error al traducir, Mensaje original: {arg1}, Código de estado: {arg2}",
        errorConnectingToChatGPTAPI = "Error al conectar con la API de ChatGPT",
        chatGPTPromptChangedTo = "Preajuste de indicaciones de ChatGPT cambiado a {arg1}",
        selectedColor = "Color seleccionado: {arg1}",
        customLabelForTeamTranslation = "Etiqueta personalizada para la traducción de [{arg1}]",
        customLabelForAllTranslation = "Etiqueta personalizada para la traducción de [{arg1}]",
        translationMethodIncomingChangedTo = "Método de traducción entrante cambiado a {arg1}",
        translationMethodOutgoingChangedTo = "Método de traducción saliente cambiado a {arg1}",
        sendingToPlayer = "[A {arg1}] "
    },

    CustomLabels = {
        inputMessage = "Ingrese el mensaje"
    }
}

local frTranslations = {
    noInternetAccess = "Pour utiliser Polyglot Translator, veuillez activer l'accès à Internet",
    checkForUpdates = "Vérifier les mises à jour",
    checkForUpdatesD = "Vérifier les mises à jour pour Polyglot Translator",
    updateInProgress = "Mise à jour en cours...",
    updating = "Mise à jour...",
    failedToUpdate = "Échec de la mise à jour du fichier de script.",
    unexpectedResponse = "Fichier de mise à jour inattendu. Le fichier local restera inchangé.",
    failedToDownloadFromGitHub = "Échec du téléchargement depuis GitHub.",
    changelog = "Changelog",
    noUpdatesAvailable = "Aucune mise à jour disponible.",
    chatGPTSettings = "Paramètres ChatGPT",
    chatGPTSettingsD = "Paramètres ChatGPT",
    apiKeyInput = "Clé API",
    apiKeyInputD = "Entrez votre clé API",
    chatGPTPromptPreset = "Préréglage d'invite ChatGPT",
    chatGPTPromptPresetD = "Choisissez le préréglage d'invite pour ChatGPT",
    temperature = "Température",
    temperatureD = "Quelle température d'échantillonnage utiliser, entre 0 et 2. Des valeurs plus élevées comme 0,8 rendront la sortie plus aléatoire, tandis que des valeurs plus basses comme 0,2 la rendront plus concentrée et déterministe. Nous recommandons généralement de modifier cela ou top p mais pas les deux. (Par défaut: 1)",
    topP = "Top P",
    topPD = "Nombre entre 0 et 1. Une alternative à l'échantillonnage avec température, appelée échantillonnage de noyau, où le modèle considère les résultats des jetons avec une masse de probabilité de top p. Donc, 0,1 signifie que seuls les jetons représentant les 10% de masse de probabilité les plus élevés sont pris en compte. Nous recommandons généralement de modifier cela ou la température, mais pas les deux. (Par défaut: 1)",
    presencePenalty = "Pénalité de présence",
    presencePenaltyD = "Nombre entre -2,0 et 2,0. Les valeurs positives pénalisent les nouveaux jetons en fonction de leur apparition dans le texte jusqu'à présent, augmentant la probabilité que le modèle parle de nouveaux sujets. (Par défaut: 0)",
    frequencyPenalty = "Pénalité de fréquence",
    frequencyPenaltyD = "Nombre entre -2,0 et 2,0. Les valeurs positives pénalisent les nouveaux jetons en fonction de leur fréquence existante dans le texte jusqu'à présent, diminuant la probabilité que le modèle répète la même ligne mot pour mot. (Par défaut: 0)",

    translatorListenerOn = "Écouteur de traduction activé",
    translatorListenerOnD = "Le traducteur écoutera les messages entrants et les traduira",
    translateYourself = "Traduire ses propres messages",
    translateYourselfD = "Traduire les messages envoyés par vous-même",
    translatedMessageDisplay = "Affichage du message traduit",
    translatedMessageDisplayD = "Emplacement du message traduit. Vous devez cliquer pour appliquer le changement",
    scriptSettings = "Autres paramètres pour Polyglot Translator",
    scriptSettingsD = "Y compris les paramètres de couleur et les mises à jour",
    playerNameColor = "Couleur du nom du joueur",
    customLabelForTeamTranslationD = "Le laisser vide le rétablira à l'étiquette d'origine",
    customLabelForAllTranslationD = "Le laisser vide le rétablira à l'étiquette d'origine",
    translatorListenerBlacklist = "Liste noire de l'écouteur de traduction",
    translatorListenerBlacklistD = "Ignorer les messages dans les langues activées dans cette liste",
    translationMethod = "Méthode de traduction",
    translationMethodD = "Choisissez la méthode de traduction",
    incomingMessages = "Messages entrants",
    incomingMessagesD = "Choisissez la méthode de traduction pour les messages entrants",
    outgoingMessages = "Messages sortants",
    outgoingMessagesD = "Choisissez la méthode de traduction pour les messages sortants",
    targetLanguageIncoming = "Langue cible entrante",
    targetLanguageIncomingD = "Langue pour traduire les messages entrants. Vous devez cliquerpour appliquer le changement",
    sendTranslatedMessage = "Envoyer le message traduit",
    targetLanguageOutgoing = "Langue cible sortante",
    targetLanguageOutgoingD = "Langue pour traduire vos messages. Vous devez cliquer pour appliquer le changement",
    sendMessage = "Envoyer le message",
    sendMessageD = "Saisissez le texte de votre message",
    translatedMsgLocationOptions = {
        teamChatNotNetworked = "Chat d'équipe non connecté",
        teamChatNetworked = "Chat d'équipe connecté",
        globalChatNotNetworked = "Chat global non connecté",
        globalChatNetworked = "Chat global connecté",
        notification = "Stand Notification",
        popup = "Popup"
    },
    templates = {
        -- Exemple: "Préréglage d'invite ChatGPT modifié en {arg1} "
        updateSuccessful = "Mise à jour réussie, version actuelle: {arg1}",
        apiKeyNotSet = "Clé API non définie. Veuillez entrer votre clé API dans les paramètres",
        errorTranslating = "Erreur de traduction, Message original: {arg1}, Code d'état: {arg2}",
        errorConnectingToChatGPTAPI = "Erreur de connexion à l'API ChatGPT",
        chatGPTPromptChangedTo = "Préréglage d'invite ChatGPT modifié en {arg1}",
        selectedColor = "Couleur sélectionnée: {arg1}",
        customLabelForTeamTranslation = "Étiquette personnalisée pour la traduction [{arg1}]",
        customLabelForAllTranslation = "Étiquette personnalisée pour la traduction [{arg1}]",
        translationMethodIncomingChangedTo = "Méthode de traduction entrante modifiée en {arg1}",
        translationMethodOutgoingChangedTo = "Méthode de traduction sortante modifiée en {arg1}",
        sendingToPlayer = "[À {arg1}] "
    },
    CustomLabels = {
        inputMessage = "Entrez le message"
    }
}

local zhTranslations = {
    noInternetAccess = "要使用多语种翻译器，请启用互联网访问",
    checkForUpdates = "检查更新",
    checkForUpdatesD = "检查多语种翻译器的更新",
    updateInProgress = "更新进行中...",
    updating = "正在更新...",
    failedToUpdate = "无法更新脚本文件。",
    unexpectedResponse = "意外的更新文件。本地文件将保持不变。",
    failedToDownloadFromGitHub = "无法从GitHub下载。",
    changeLog = "更新日志",
    noUpdatesAvailable = "没有可用的更新。",
    chatGPTSettings = "ChatGPT 设置",
    chatGPTSettingsD = "ChatGPT 设置",
    apiKeyInput = "API 密钥",
    apiKeyInputD = "输入您的 API 密钥",
    chatGPTPromptPreset = "ChatGPT 提示预设",
    chatGPTPromptPresetD = "为 ChatGPT 选择提示预设",
    temperature = "温度",
    temperatureD = "使用的采样温度，介于 0 和 2 之间。较高的值（如 0.8）会使输出更随机，而较低的值（如 0.2）会使其更集中和确定性。我们通常建议更改此项或顶部 p，但不要同时更改两者。（默认值：1）",
    topP = "Top P",
    topPD = "介于 0 和 1 之间的数字。与使用温度采样的替代方法，称为核采样，其中模型考虑具有最高 p 概率质量的标记结果。因此，0.1 意味着仅考虑包含最高 10% 概率质量的标记。我们通常建议更改此项或温度，但不要同时更改两者。（默认值：1）",
    presencePenalty = "存在惩罚",
    presencePenaltyD = "介于 -2.0 和 2.0 之间的数字。正值会根据它们在迄今为止的文本中的出现情况对新标记进行惩罚，从而增加模型谈论新主题的可能性。（默认值：0）",
    frequencyPenalty = "频率惩罚",
    frequencyPenaltyD = "介于 -2.0 和 2.0 之间的数字。正值会根据它们在迄今为止的文本中的频率对新标记进行惩罚，从而降低模型重复相同行的可能性。（默认值：0）",

    translatorListenerOn = "开启翻译玩家信息",
    translatorListenerOnD = "翻译器将监听传入的消息并进行翻译",
    translateYourself = "翻译自己的消息",
    translateYourselfD = "翻译您自己发送的消息",
    translatedMessageDisplay = "翻译消息显示模式",
    translatedMessageDisplayD = "翻译后的消息位置。您需要点击以应用更改",
    scriptSettings = "多语种翻译器的其他设置",
    scriptSettingsD = "包括颜色设置和更新",
    playerNameColor = "玩家名字颜色",
    customLabelForTeamTranslationD = "将其留空将还原为原始标签",
    customLabelForAllTranslationD = "将其留空将还原为原始标签",
    translatorListenerBlacklist = "翻译语言黑名单",
    translatorListenerBlacklistD = "在此列表中切换为开启的语言的消息将被忽略",
    translationMethod = "翻译引擎选择",
    translationMethodD = "选择翻译引擎",
    incomingMessages = "传入的消息",
    incomingMessagesD = "选择传入消息的翻译引擎",
    outgoingMessages = "发出的消息",
    outgoingMessagesD = "选择发出消息的翻译引擎",
    targetLanguageIncoming = "翻译后的语言",
    targetLanguageIncomingD = "默认为中文\n您需要点击以应用更改",
    sendTranslatedMessage = "发送翻译后的消息",
    targetLanguageOutgoing = "玩家们应该看到何种语言？",
    targetLanguageOutgoingD = "您发送的消息的最终语言\n默认为英文\n您需要点击以应用更改",
    sendMessage = "发送消息",
    sendMessageD = "输入您要发送的消息文本",
    translatedMsgLocationOptions = {
        teamChatNotNetworked = "团队聊天-自己可见",
        teamChatNetworked = "团队聊天-全局可见",
        globalChatNotNetworked = "全局聊天-自己可见",
        globalChatNetworked = "全局聊天-全局可见",
        notification = "Stand通知",
        popup = "通知弹窗"
    },
    templates = {
        -- 示例："ChatGPT 提示预设更改为 {arg1} "
        updateSuccessful = "更新成功，当前版本：{arg1}",
        apiKeyNotSet = "API 密钥未设置。请在设置中输入您的 API 密钥",
        errorTranslating = "翻译错误，原始消息：{arg1}，状态代码：{arg2}",
        errorConnectingToChatGPTAPI = "连接 ChatGPT API 错误",
        chatGPTPromptChangedTo = "ChatGPT 提示预设更改为 {arg1}",
        selectedColor = "已选择颜色：{arg1}",
        customLabelForTeamTranslation = "自定义 [{arg1}] 翻译标签",
        customLabelForAllTranslation = "自定义 [{arg1}] 翻译标签",
        translationMethodIncomingChangedTo = "传入消息的翻译方法更改为 {arg1}",
        translationMethodOutgoingChangedTo = "发出消息的翻译方法更改为 {arg1}",
        sendingToPlayer = "[发送给 {arg1}] "
    },
    CustomLabels = {
        inputMessage = "输入待发送的消息"
    }
}

local jaTranslations = {
    noInternetAccess = "Polyglot Translatorを使用するには、インターネットアクセスを有効にしてください",
    checkForUpdates = "更新を確認",
    checkForUpdatesD = "Polyglot Translatorの更新を確認",
    updateInProgress = "更新中...",
    updating = "更新しています...",
    failedToUpdate = "スクリプトファイルの更新に失敗しました。",
    unexpectedResponse = "予期しない更新ファイル。ローカルファイルは変更されません。",
    failedToDownloadFromGitHub = "GitHubからのダウンロードに失敗しました。",
    changeLog = "変更履歴",
    noUpdatesAvailable = "利用可能な更新はありません。",
    chatGPTSettings = "ChatGPT設定",
    chatGPTSettingsD = "ChatGPT設定",
    apiKeyInput = "APIキー",
    apiKeyInputD = "APIキーを入力してください",
    chatGPTPromptPreset = "ChatGPTプロンプトプリセット",
    chatGPTPromptPresetD = "ChatGPTのプロンプトプリセットを選択",
    temperature = "温度",
    temperatureD = "0から2までの範囲でサンプリング温度を使用します。0.8のような高い値は出力をランダムにし、0.2のような低い値は出力を集中的かつ決定的にします。一般的に、これまたはトップpを変更することをお勧めしますが、両方は変更しないでください。(デフォルト：1)",
    topP = "トップP",
    topPD = "0から1までの数値。温度でサンプリングする代わりに、核サンプリングと呼ばれる方法で、モデルはトップp確率質量のトークンの結果を検討します。したがって、0.1は、トップ10％の確率質量を構成するトークンのみが考慮されることを意味します。一般的に、これまたは温度を変更することをお勧めしますが、両方は変更しないでください。(デフォルト：1)",
    presencePenalty = "出現ペナルティ",
    presencePenaltyD = "-2.0から2.0までの数値。正の値は、これまでのテキストに表示されるかどうかに基づいて新しいトークンにペナルティを与え、モデルが新しいトピックについて話す可能性を高めます。(デフォルト：0)",
    frequencyPenalty = "頻度ペナルティ",
    frequencyPenaltyD = "-2.0から2.0までの数値。正の値は、これまでのテキストでの既存の頻度に基づいて新しいトークンにペナルティを与え、モデルが同じ行を逐語的に繰り返す可能性を減らします。(デフォルト：0)",

    translatorListenerOn = "翻訳リスナーオン",
    translatorListenerOnD = "翻訳者は着信メッセージをリッスンして翻訳します",
    translateYourself = "自分のメッセージを翻訳する",
    translateYourselfD = "自分が送信したメッセージを翻訳する",
    translatedMessageDisplay = "翻訳されたメッセージの表示",
    translatedMessageDisplayD = "翻訳されたメッセージの場所。変更を適用するにはクリックする必要があります",
    scriptSettings = "Polyglot Translatorのその他の設定",
    scriptSettingsD = "カラー設定や更新を含む",
    playerNameColor = "プレイヤー名の色",
    customLabelForTeamTranslationD = "空白にすると、元のラベルに戻ります",
    customLabelForAllTranslationD = "空白にすると、元のラベルに戻ります",
    translatorListenerBlacklist = "翻訳リスナーブラックリスト",
    translatorListenerBlacklistD = "このリストでオンに切り替えられた言語のメッセージを無視する",
    translationMethod = "翻訳方法",
    translationMethodD = "翻訳方法を選択してください",
    incomingMessages = "受信メッセージ",
    incomingMessagesD = "受信メッセージの翻訳方法を選択してください",
    outgoingMessages = "送信メッセージ",
    outgoingMessagesD = "送信メッセージの翻訳方法を選択してください",
    targetLanguageIncoming = "受信メッセージのターゲット言語",
    targetLanguageIncomingD = "受信メッセージを翻訳する言語。変更を適用するにはクリックする必要があります",
    sendTranslatedMessage = "翻訳されたメッセージを送信",
    targetLanguageOutgoing = "送信メッセージのターゲット言語",
    targetLanguageOutgoingD = "あなたのメッセージを翻訳する言語。変更を適用するにはクリックする必要があります",
    sendMessage = "メッセージを送信",
    sendMessageD = "メッセージのテキストを入力してください",
    translatedMsgLocationOptions = {
        teamChatNotNetworked = "ネットワーク化されていないチームチャット",
        teamChatNetworked = "ネットワーク化されたチームチャット",
        globalChatNotNetworked = "ネットワーク化されていないグローバルチャット",
        globalChatNetworked = "ネットワーク化されたグローバルチャット",
        notification = "スタンド通知",
        popups = "ポップアップ"
    },
    templates = {
        -- 例："ChatGPTプロンプトプリセットが{arg1}に変更されました"
        updateSuccessful = "更新が成功しました、現在のバージョン：{arg1}",
        apiKeyNotSet = "APIキーが設定されていません。設定でAPIキーを入力してください",
        errorTranslating = "翻訳エラー、元のメッセージ：{arg1}、ステータスコード：{arg2}",
        errorConnectingToChatGPTAPI = "ChatGPT APIへの接続エラー",
        chatGPTPromptChangedTo = "ChatGPTプロンプトプリセットが{arg1}に変更されました",
        selectedColor = "選択された色：{arg1}",
        customLabelForTeamTranslation = "[{arg1}]翻訳のカスタムラベル",
        customLabelForAllTranslation = "[{arg1}]翻訳のカスタムラベル",
        sendingToPlayer = "[{arg1}に宛てて] "
    },
    CustomLabels = {
        inputMessage = "入力メッセージ"
    }
}

local ruTranslations = {
    noInternetAccess = "Это скрипт Polyglot Translator, пожалуйста, включите доступ в интернет",
    checkForUpdates = "Проверить обновления",
    checkForUpdatesD = "Проверить обновления для Polyglot Translator",
    updateInProgress = "Обновление в процессе...",
    updating = "Обновляю...",
    failedToUpdate = "Не удалось обновить файл скрипта.",
    unexpectedResponse = "Неожиданное обновление файла. Локальный файл останется неизменным.",
    failedToDownloadFromGitHub = "Ошибка обновления с GitHub.",
    changelog = "Изменения",
    noUpdatesAvailable = "Обновлений не найдено.",
    chatGPTSettings = "Настройки ChatGPT",
    chatGPTSettingsD = "Настройки ChatGPT",
    apiKeyInput = "Ключ API",
    apiKeyInputD = "Введите свой ключ API",
    chatGPTPromptPreset = "Предустановки ChatGPT",
    chatGPTPromptPresetD = "Выберите предварительную настройку подсказки для ChatGPT",
    temperature = "Температура",
    temperatureD = "Какая температура выборки будет использоваться, от 0 до 2. Более высокие значения, например 0,8, сделают вывод более случайным, а более низкие, например 0,2, сделают его более целенаправленным и детерминированным. Обычно рекомендуется изменять либо это значение, либо верхнее p, но не оба. (По умолчанию: 1)",
    topP = "Top P",
    topPD = "Число от 0 до 1. Альтернатива выборке с температурой, называемой выборкой по ядру, когда модель рассматривает результаты токенов, имеющих верхнюю p-ю вероятностную массу. Таким образом, 0,1 означает, что рассматриваются только лексемы, составляющие верхние 10% вероятностной массы. Обычно мы рекомендуем изменять этот параметр или температуру, но не оба. (По умолчанию: 1)",
    presencePenalty = "Наказание за присутствие",
    presencePenaltyD = "Число между -2,0 и 2,0. Положительные значения штрафуют новые лексемы на основе того, появляются ли они в тексте до сих пор, увеличивая вероятность того, что модель будет говорить о новых темах. (По умолчанию: 0)",
    frequencyPenalty = "Частота штрафа",
    frequencyPenaltyD = "Число между -2,0 и 2,0. Положительные значения штрафуют новые лексемы на основе их существующей частоты в тексте, уменьшая вероятность того, что модель будет повторять одну и ту же строку дословно. (По умолчанию: 0)",

    translatorListenerOn = "Активировать переводчик",
    translatorListenerOnD = "Переводчик будет видеть входящие сообщения и переводить",
    translateYourself = "Перевод собственных сообщений",
    translateYourselfD = "Переводить сообщения, отправленные самим собой",
    translatedMessageDisplay = "Переведённые сообщения на экране",
    translatedMessageDisplayD = "Расположение переведенного сообщения. Необходимо нажать, чтобы применить изменения",
    scriptSettings = "Другие настройки для переводчика-полиглота",
    scriptSettingsD = "Включая настройки цвета и обновления",
    playerNameColor = "Цвет имени игроков",
    customLabelForTeamTranslationD = "Оставляя это пустым, вы вернете его к оригинальной метке",
    customLabelForAllTranslationD = "Если оставить его пустым, то он вернется к исходной метке",
    translatorListenerBlacklist = "Чёрный список языков переводчика",
    translatorListenerBlacklistD = "Игнорировать сообщения на языках, включенных в этом списке",
    translationMethod = "Метод перевода",
    translationMethodD = "Выберите метод перевода",
    incomingMessages = "Входящие сообщения",
    incomingMessagesD = "Выберите метод перевода для входящих сообщений",
    outgoingMessages = "Исходящие сообщения",
    outgoingMessagesD = "Выберите метод перевода для исходящих сообщений",
    targetLanguageIncoming = "Входящий целевой язык",
    targetLanguageIncomingD = "Язык, на который будут переводиться входящие сообщения. Для применения изменений необходимо нажать кнопку",
    sendTranslatedMessage = "Отправить переведенное сообщение",
    targetLanguageOutgoing = "Исходящий целевой язык",
    targetLanguageOutgoingD = "Язык, на который будут переводиться ваши сообщения. Вам нужно нажать кнопку , чтобы применить изменения",
    sendMessage = "Отправить сообщение",
    sendMessageD = "Введите текст сообщения",
    translatedMsgLocationOptions = {
        teamChatNotNetworked = "Чат организации (сеть без подключения)",
        teamChatNetworked = "Чат организации (сеть)",
        globalChatNotNetworked = "Чат виден всем (сеть без подключения)",
        globalChatNetworked = "Чат виден всем (сеть)",
        notification = "Уведомления",
        popup = "Всплывающее окно"
    },
    templates = {
        -- Example: "ChatGPT Prompt Preset changed to {arg1} "
        updateSuccessful = "Обновление успешно, текущая версия: {arg1}",
        apiKeyNotSet = "API не установлен. Пожалуйста введите API в настройках",
        errorTranslating = "Ошибка перевода, Оригинальное сообщение: {arg1}, Код статуса: {arg2}",
        errorConnectingToChatGPTAPI = "Ошибка подключения к ChatGPT API",
        chatGPTPromptChangedTo = "ChatGPT Предварительная установка подсказки изменена на {arg1}",
        selectedColor = "Выбранный цвет: {arg1}",
        customLabelForTeamTranslation = "Пользовательская метка для [{arg1}] перевода",
        customLabelForAllTranslation = "Пользовательская метка для [{arg1}] перевода",
        translationMethodIncomingChangedTo = "Метод входящего перевода изменён на  {arg1}",
        translationMethodOutgoingChangedTo = "Метод исходящего перевода изменён на {arg1}",
        sendingToPlayer = "[К {arg1}] "
    },
    CustomLabels = {
        inputMessage = "Введите сообщение"
    }
}

local ptTranslations = {
    noInternetAccess = "Para utilizar o Polyglot Translator, active o acesso à Internet",
    checkForUpdates = "Verificar se há actualizações",
    checkForUpdatesD = "Verificar se há actualizações para o Polyglot Translator",
    updateInProgress = "Atualização em curso...",
    updating = "Atualização...",
    failedToUpdate = "Falha ao atualizar o ficheiro de script.",
    unexpectedResponse = "Ficheiro de atualização inesperado. O ficheiro local permanecerá inalterado.",
    failedToDownloadFromGitHub = "Falha ao descarregar do GitHub.",
    changelog = "Registo de alterações",
    noUpdatesAvailable = "Não há actualizações disponíveis.",
    chatGPTSettings = "Definições do ChatGPT",
    chatGPTSettingsD = "Definições do ChatGPT",
    apiKeyInput = "Chave da API",
    apiKeyInputD = "Introduza a sua chave API",
    chatGPTPromptPreset = "Predefinição do prompt do ChatGPT",
    chatGPTPromptPresetD = "Escolha a predefinição de prompt para ChatGPT",
    temperature = "Temperatura",
    temperatureD = "Qual a temperatura de amostragem a utilizar, entre 0 e 2. Valores mais altos, como 0,8, tornarão a saída mais aleatória, enquanto valores mais baixos, como 0,2, a tornarão mais focada e determinística. Geralmente, recomendamos alterar este valor ou top p, mas não ambos. (Predefinição: 1)",
    topP = "Top P",
    topPD = "Número entre 0 e 1. Uma alternativa à amostragem com temperatura, chamada amostragem de núcleo, em que o modelo considera os resultados dos tokens com massa de probabilidade p superior. Assim, 0,1 significa que apenas são considerados os tokens que compreendem a massa de probabilidade 10% superior. Geralmente, recomendamos a alteração deste valor ou da temperatura, mas não de ambos. (Predefinição: 1)",
    presencePenalty = "Penalidade de presença",
    presencePenaltyD = "Número entre -2,0 e 2,0. Os valores positivos penalizam os novos tokens com base no facto de aparecerem ou não no texto até ao momento, aumentando a probabilidade de o modelo falar sobre novos tópicos. (Predefinição: 0)",
    frequencyPenalty = "Penalização de frequência",
    frequencyPenaltyD = "Número entre -2,0 e 2,0. Os valores positivos penalizam os novos tokens com base na sua frequência existente no texto até ao momento, diminuindo a probabilidade de o modelo repetir a mesma linha literalmente. (Predefinição: 0)",
    translatorListenerOn = "Ouvinte do tradutor ligado",
    translatorListenerOnD = "O tradutor ouve as mensagens que chegam e traduz",
    translateYourself = "Traduzir mensagens próprias",
    translateYourselfD = "Traduzir as mensagens enviadas por si próprio",
    translatedMessageDisplay = "Ecrã de mensagens traduzidas",
    translatedMessageDisplayD = "Localização da mensagem traduzida. Tem de clicar para aplicar a alteração",
    scriptSettings = "Outras definições para o Tradutor Poliglota",
    scriptSettingsD = "Incluindo definições de cor e actualizações",
    playerNameColor = "Cor do nome do jogador",
    customLabelForTeamTranslationD = "Se deixar em branco, a etiqueta será revertida para a etiqueta original",
    customLabelForAllTranslationD = "Se o deixar em branco, irá reverter para a etiqueta original",
    translatorListenerBlacklist = "Lista negra de ouvintes do tradutor",
    translatorListenerBlacklistD = "Ignorar mensagens em línguas activadas nesta lista",
    translationMethod = "Método de tradução",
    translationMethodD = "Escolher o método de tradução",
    incomingMessages = "Mensagens recebidas",
    incomingMessagesD = "Escolher o método de tradução para as mensagens recebidas",
    outgoingMessages = "Mensagens de saída",
    outgoingMessagesD = "Escolher o método de tradução para as mensagens de saída",
    targetLanguageIncoming = "Língua de destino de entrada",
    targetLanguageIncomingD = "Língua para a qual traduzir as mensagens recebidas. É necessário clicar para aplicar a alteração",
    sendTranslatedMessage = "Enviar mensagem traduzida",
    targetLanguageOutgoing = "Idioma de destino de saída",
    targetLanguageOutgoingD = "Língua para a qual traduzir as suas mensagens. Tem de clicar para aplicar a alteração",
    sendMessage = "Enviar mensagem",
    sendMessageD = "Introduza o texto da sua mensagem",
    inputMessage = "Por favor, introduza a sua mensagem",
    translatedMsgLocationOptions = {
        teamChatNotNetworked = "O Chat da Equipa não está ligado em rede",
        teamChatNetworked = "Chat da equipa ligado em rede",
        globalChatNotNetworked = "Bate-papo Global não está em rede",
        globalChatNetworked = "Chat global em rede",
        notification = "Notificação de suporte",
        popup = "Popup"
    },
    modelos = {
        -- Exemplo: "Predefinição do prompt ChatGPT alterada para {arg1} "
        updateSuccessful = "Atualização bem sucedida, versão atual: {arg1}",
        apiKeyNotSet = "Chave de API não definida. Por favor, introduza a sua chave API nas definições",
        errorTranslating = "Erro de tradução, Mensagem original: {arg1}, Código de estado: {arg2}",
        errorConnectingToChatGPTAPI = "Erro ao ligar à API do ChatGPT",
        chatGPTPromptChangedTo = "A predefinição do prompt do ChatGPT foi alterada para {arg1}",
        selectedColor = "Cor selecionada: {arg1}",
        customLabelForTeamTranslation = "Etiqueta personalizada para a tradução de [{arg1}]",
        customLabelForAllTranslation = "Etiqueta personalizada para a tradução de [{arg1}]",
        translationMethodIncomingChangedTo = "Método de tradução de entrada alterado para {arg1}",
        translationMethodOutgoingChangedTo = "Método de tradução de saída alterado para {arg1}"
    }
}

local languages = {"en", "es", "fr", "zh", "ja", "ru", "pt"}
local translations = {
    en = engTranslations,
    es = esTranslations,
    fr = frTranslations,
    zh = zhTranslations,
    ja = jaTranslations,
    ru = ruTranslations,
	pt = ptTranslations
}
function merge(t1, t2)
    for k, v in pairs(t2) do
        if (type(v) == "table") and (type(t1[k] or false) == "table") then
            merge(t1[k], t2[k])
        else
            t1[k] = v
        end
    end
    return t1
end

local returnTable = {}

if table.contains(languages, lang.get_current()) then
    returnTable = merge(translations.en, translations[lang.get_current()])
else
    returnTable = translations.en
end

local sendingToPlayerTranslations = {
    af = "[Aan {arg1}] ",
    sq = "[Për {arg1}] ",
    ar = "[إلى {arg1}] ",
    az = "[{arg1} üçün] ",
    eu = "[{arg1}-(r)i] ",
    be = "[Да {arg1}] ",
    bn = "[{arg1} প্রতি] ",
    bg = "[До {arg1}] ",
    ca = "[A {arg1}] ",
    ["zh-cn"] = "[发送给 {arg1}] ",
    ["zh-tw"] = "[發送給 {arg1}] ",
    hr = "[Za {arg1}] ",
    cs = "[Pro {arg1}] ",
    da = "[Til {arg1}] ",
    nl = "[Aan {arg1}] ",
    en = "[To {arg1}] ",
    eo = "[Al {arg1}] ",
    et = "[{arg1}-le] ",
    tl = "[Para kay {arg1}] ",
    fi = "[{arg1}:lle] ",
    fr = "[À {arg1}] ",
    gl = "[A {arg1}] ",
    ka = "[{arg1}მიმართავი] ",
    de = "[An {arg1}] ",
    el = "[Προς {arg1}] ",
    gu = "[{arg1} પ્રતિ] ",
    ht = "[Pou {arg1}] ",
    iw = "[אל {arg1}] ",
    hi = "[{arg1} को] ",
    hu = "[{arg1} részére] ",
    is = "[Til {arg1}] ",
    id = "[Kepada {arg1}] ",
    ga = "[Chuig {arg1}] ",
    it = "[A {arg1}] ",
    ja = "[{arg1}に宛てて] ",
    kn = "[{arg1} ಗೆ] ",
    ko = "[{arg1}에게] ",
    la = "[Ad {arg1}] ",
    lv = "[{arg1} vērsts] ",
    lt = "[{arg1} kam] ",
    mk = "[До {arg1}] ",
    ms = "[Kepada {arg1}] ",
    mt = "[Lil {arg1}] ",
    no = "[Til {arg1}] ",
    fa = "[به {arg1}] ",
    pl = "[Do {arg1}] ",
    pt = "[Para {arg1}] ",
    ro = "[Către {arg1}] ",
    ru = "[К {arg1}] ",
    sr = "[За {arg1}] ",
    sk = "[Pre {arg1}] ",
    sl = "[Za {arg1}] ",
    es = "[A {arg1}] ",
    sw = "[Kwa {arg1}] ",
    sv = "[Till {arg1}] ",
    ta = "[{arg1} க்கு] ",
    te = "[{arg1} కు] ",
    th = "[ถึง {arg1}] ",
    tr = "[{arg1} için] ",
    uk = "[До {arg1}] ",
    ur = "[{arg1} کے لئے] ",
    vi = "[Đến {arg1}] ",
    cy = "[I {arg1}] ",
    yi = "[צו {arg1}] "
}

returnTable.sendingToPlayerLookupByKey = sendingToPlayerTranslations

-----------------------------------
-- LABELS
-----------------------------------	
CustomLabels = {
    InputMessage = returnTable.CustomLabels.inputMessage
}

for key, text in pairs(CustomLabels) do CustomLabels[key] = util.register_label(text) end

return returnTable
 end)
package.preload['src.lib.menus'] = (function (...)
					local _ENV = _ENV;
					local function module(name, ...)
						local t = package.loaded[name] or _ENV[name] or { _NAME = name };
						package.loaded[name] = t;
						for i = 1, select("#", ...) do
							(select(i, ...))(t);
						end
						_ENV = t;
						_M = t;
						return t;
					end
				local polyglotUpdater = require "src.lib.updater"
local polyglotChat = require "src.lib.chat"
local polyglotTranslation = require "src.lib.translation"

Config = {
    general = {
        language = {}
    },
    translationMethodIncoming = "Google Translate",
    translationMethodOutgoing = "Google Translate",
    targetLanguageIncoming = "zh",
    targetLanguageOutgoing = "en",

    blacklistedLanguages = {},

    chatGPTPromptPreset = "Basic",
    temperature = 1.0,
    topP = 1.0,
    presencePenalty = 0.0,
    frequencyPenalty = 0.0,

    translateOn = true,
    translateSelf = false,

    translatedMsgLocation = 6,

    colorSelect = 1,
    allChatLabel = util.get_label_text("MP_CHAT_ALL"),
    teamChatLabel = util.get_label_text("MP_CHAT_TEAM"),

    debugMode = false
}

--[[if not async_http.have_access() then
    polyglotUtils.toast(LOC.noInternetAccess)
end]]


local focusRef = {}
local isFocused = false

menu.toggle(chat_translation, LOC.translatorListenerOn, {"translateon"}, LOC.translatorListenerOnD,
    function(on) Config.translateOn = on end, true)

menu.toggle(chat_translation, LOC.translateYourself, {"translateself"}, LOC.translateYourselfD,
    function(on) Config.translateSelf = on end)

chat_translation:list_select(LOC.translatedMessageDisplay, {}, LOC.translatedMessageDisplayD,
    TranslatedMsgLocationOptions, #TranslatedMsgLocationOptions,
    function(index, option, prevIndex, clickType) Config.translatedMsgLocation = index end)

-- CommandRef|CommandUniqPtr menu.list(CommandRef parent, Label menu_name, table<any, string> command_names = {}, Label help_text = "", ?function on_click = nil, ?function on_back = nil, ?function on_active_list_update = nil)
--[[local settingTranslationMenu = menu.list(chat_translation, LOC.scriptSettings, {}, LOC.scriptSettingsD)
local colorTranslation = menu.list(settingTranslationMenu, LOC.playerNameColor)
menu.on_focus(colorTranslation, function()
    util.yield(50)
    isFocused = false
end)
local selectMenu = menu.action(colorTranslation,
    polyglotUtils.templateReplace(LOC.templates.selectedColor, Config.colorSelect), {}, "",
    function() menu.focus(focusRef[tonumber(Config.colorSelect)]) end)
menu.on_focus(selectMenu, function()
    util.yield(50)
    isFocused = false
end)
for i = 1, 234 do
    focusRef[i] = menu.action(colorTranslation, "Color : " .. i, {}, "", function()
        menu.set_menu_name(selectMenu, "Selected : " .. "Color : " .. i)
        Config.colorSelect = i
    end)
    menu.on_focus(focusRef[i], function()
        isFocused = false
        util.yield(50)
        isFocused = true
        while isFocused do
            if not menu.is_open() then isFocused = false end
            ptr1 = memory.alloc()
            ptr2 = memory.alloc()
            ptr3 = memory.alloc()
            ptr4 = memory.alloc()
            HUD.GET_HUD_COLOUR(i, ptr1, ptr2, ptr3, ptr4)
            directx.draw_text(0.5, 0.5, "example", 5, 0.75, {
                r = memory.read_int(ptr1) / 255,
                g = memory.read_int(ptr2) / 255,
                b = memory.read_int(ptr3) / 255,
                a = memory.read_int(ptr4) / 255
            }, true)
            util.yield()
        end
    end)
end

menu.text_input(settingTranslationMenu, polyglotUtils.templateReplace(LOC.templates.customLabelForTeamTranslation,
    string.upper(util.get_label_text("MP_CHAT_TEAM"))), {"labelteam"}, LOC.customLabelForTeamTranslationD,
    function(s, click_type)
        if (s == "") then
            Config.teamChatLabel = util.get_label_text("MP_CHAT_TEAM")
        else
            Config.teamChatLabel = s
        end
    end)
if not (Config.teamChatLabel == util.get_label_text("MP_CHAT_TEAM")) then
    menu.trigger_commands("labelteam " .. Config.teamChatLabel)
end

menu.text_input(settingTranslationMenu, polyglotUtils.templateReplace(LOC.templates.customLabelForAllTranslation,
    string.upper(util.get_label_text("MP_CHAT_ALL"))), {"labelall"}, LOC.customLabelForAllTranslationD,
    function(s, click_type)
        if (s == "") then
            Config.allChatLabel = util.get_label_text("MP_CHAT_ALL")
        else
            Config.allChatLabel = s
        end
    end)
if not (Config.teamChatLabel == util.get_label_text("MP_CHAT_TEAM")) then
    menu.trigger_commands("labelall " .. Config.allChatLabel)
end]]
-- CommandRef|CommandUniqPtr menu.action(CommandRef parent, Label menu_name, table<any, string> command_names, Label help_text, function on_click, ?function on_command = nil, ?string syntax = nil, int perm = COMMANDPERM_USERONLY)


local blacklistMenu = menu.list(chat_translation, LOC.translatorListenerBlacklist, {}, LOC.translatorListenerBlacklistD)
-- CommandRef|CommandUniqPtr menu.toggle(CommandRef parent, Label menu_name, table<any, string> command_names, Label help_text, function on_change, bool default_on = false)
for i, langKey in ipairs(LangKeyList) do
    Config.blacklistedLanguages[langKey] = false
    blacklistMenu:toggle(LangLookupByKey[langKey], {}, "", function(on) Config.blacklistedLanguages[langKey] = on end,
        false)
end

local translationMethodMenu = menu.list(chat_translation, LOC.translationMethod, {}, LOC.translationMethodD)

menu.list_select(translationMethodMenu, LOC.incomingMessages, {}, LOC.incomingMessagesD, TranslationMethodOptions, 1,
    function(index, option, prevIndex, clickType)
        polyglotUtils.toast(LOC.templates.translationMethodIncomingChangedTo, option)
        Config.translationMethodIncoming = option
    end)

menu.list_select(translationMethodMenu, LOC.outgoingMessages, {}, LOC.outgoingMessagesD, TranslationMethodOptions, 1,
    function(index, option, prevIndex, clickType)
        polyglotUtils.toast(LOC.templates.translationMethodOutgoingChangedTo, option)
        Config.translationMethodOutgoing = option
    end)

menu.list_select(chat_translation, LOC.targetLanguageIncoming, {"inlang"}, LOC.targetLanguageIncomingD, LangNameList, 1,
    function(index, option, prevIndex, clickType) Config.targetLanguageIncoming = LangLookupByName[option] end)

---@type CommandRef
local translateMyMsg = menu.list(chat_translation, LOC.sendTranslatedMessage)

translateMyMsg:list_select(LOC.targetLanguageOutgoing, {"outlang"}, LOC.targetLanguageOutgoingD, LangNameList, 3,
    function(index, option, prevIndex, clickType) Config.targetLanguageOutgoing = LangLookupByName[option] end)

translateMyMsg:action(LOC.sendMessage, {"Sendmessage"}, LOC.sendMessageD, function(on_click)
    -- polyglotUtils.toast(LOC.inputMessage)
    -- menu.show_command_box("Sendmessage ")
    local text = polyglotUtils.get_input_from_screen_keyboard(CustomLabels.InputMessage, 100, "")
    if text == "" then return end
    polyglotChat.sendMessage(text, polyglotTranslation.translateText)
    -- , function(on_command)
    --     local myText = on_command
    --     polyglotChat.sendMessage(myText, polyglotTranslation.translateText)
end)
-- int chat.on_message(function callback)
--     Registers a function to be called when a chat message is sent:

--     chat.on_message(function(sender, reserved, text, team_chat, networked, is_auto)
--         -- Do stuff...
--     end)
chat.on_message(polyglotChat.createOnMessageCallback(polyglotTranslation.translateText))

end)
package.preload['src.lib.external.json'] = (function (...)
					local _ENV = _ENV;
					local function module(name, ...)
						local t = package.loaded[name] or _ENV[name] or { _NAME = name };
						package.loaded[name] = t;
						for i = 1, select("#", ...) do
							(select(i, ...))(t);
						end
						_ENV = t;
						_M = t;
						return t;
					end
				--
-- json.lua
--
-- Copyright (c) 2020 rxi
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy of
-- this software and associated documentation files (the "Software"), to deal in
-- the Software without restriction, including without limitation the rights to
-- use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
-- of the Software, and to permit persons to whom the Software is furnished to do
-- so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.
--

local json = { _version = "0.1.2" }

-------------------------------------------------------------------------------
-- Encode
-------------------------------------------------------------------------------

local encode

local escape_char_map = {
  [ "\\" ] = "\\",
  [ "\"" ] = "\"",
  [ "\b" ] = "b",
  [ "\f" ] = "f",
  [ "\n" ] = "n",
  [ "\r" ] = "r",
  [ "\t" ] = "t",
}

local escape_char_map_inv = { [ "/" ] = "/" }
for k, v in pairs(escape_char_map) do
  escape_char_map_inv[v] = k
end


local function escape_char(c)
  return "\\" .. (escape_char_map[c] or string.format("u%04x", c:byte()))
end


local function encode_nil(val)
  return "null"
end


local function encode_table(val, stack)
  local res = {}
  stack = stack or {}

  -- Circular reference?
  if stack[val] then error("circular reference") end

  stack[val] = true

  if rawget(val, 1) ~= nil or next(val) == nil then
    -- Treat as array -- check keys are valid and it is not sparse
    local n = 0
    for k in pairs(val) do
      if type(k) ~= "number" then
        error("invalid table: mixed or invalid key types")
      end
      n = n + 1
    end
    if n ~= #val then
      error("invalid table: sparse array")
    end
    -- Encode
    for i, v in ipairs(val) do
      table.insert(res, encode(v, stack))
    end
    stack[val] = nil
    return "[" .. table.concat(res, ",") .. "]"

  else
    -- Treat as an object
    for k, v in pairs(val) do
      if type(k) ~= "string" then
        error("invalid table: mixed or invalid key types")
      end
      table.insert(res, encode(k, stack) .. ":" .. encode(v, stack))
    end
    stack[val] = nil
    return "{" .. table.concat(res, ",") .. "}"
  end
end


local function encode_string(val)
  return '"' .. val:gsub('[%z\1-\31\\"]', escape_char) .. '"'
end


local function encode_number(val)
  -- Check for NaN, -inf and inf
  if val ~= val or val <= -math.huge or val >= math.huge then
    error("unexpected number value '" .. tostring(val) .. "'")
  end
  return string.format("%.14g", val)
end


local type_func_map = {
  [ "nil"     ] = encode_nil,
  [ "table"   ] = encode_table,
  [ "string"  ] = encode_string,
  [ "number"  ] = encode_number,
  [ "boolean" ] = tostring,
}


encode = function(val, stack)
  local t = type(val)
  local f = type_func_map[t]
  if f then
    return f(val, stack)
  end
  error("unexpected type '" .. t .. "'")
end


function json.encode(val)
  return ( encode(val) )
end


-------------------------------------------------------------------------------
-- Decode
-------------------------------------------------------------------------------

local parse

local function create_set(...)
  local res = {}
  for i = 1, select("#", ...) do
    res[ select(i, ...) ] = true
  end
  return res
end

local space_chars   = create_set(" ", "\t", "\r", "\n")
local delim_chars   = create_set(" ", "\t", "\r", "\n", "]", "}", ",")
local escape_chars  = create_set("\\", "/", '"', "b", "f", "n", "r", "t", "u")
local literals      = create_set("true", "false", "null")

local literal_map = {
  [ "true"  ] = true,
  [ "false" ] = false,
  [ "null"  ] = nil,
}


local function next_char(str, idx, set, negate)
  for i = idx, #str do
    if set[str:sub(i, i)] ~= negate then
      return i
    end
  end
  return #str + 1
end


local function decode_error(str, idx, msg)
  local line_count = 1
  local col_count = 1
  for i = 1, idx - 1 do
    col_count = col_count + 1
    if str:sub(i, i) == "\n" then
      line_count = line_count + 1
      col_count = 1
    end
  end
  error( string.format("%s at line %d col %d", msg, line_count, col_count) )
end


local function codepoint_to_utf8(n)
  -- http://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=iws-appendixa
  local f = math.floor
  if n <= 0x7f then
    return string.char(n)
  elseif n <= 0x7ff then
    return string.char(f(n / 64) + 192, n % 64 + 128)
  elseif n <= 0xffff then
    return string.char(f(n / 4096) + 224, f(n % 4096 / 64) + 128, n % 64 + 128)
  elseif n <= 0x10ffff then
    return string.char(f(n / 262144) + 240, f(n % 262144 / 4096) + 128,
                       f(n % 4096 / 64) + 128, n % 64 + 128)
  end
  error( string.format("invalid unicode codepoint '%x'", n) )
end


local function parse_unicode_escape(s)
  local n1 = tonumber( s:sub(1, 4),  16 )
  local n2 = tonumber( s:sub(7, 10), 16 )
   -- Surrogate pair?
  if n2 then
    return codepoint_to_utf8((n1 - 0xd800) * 0x400 + (n2 - 0xdc00) + 0x10000)
  else
    return codepoint_to_utf8(n1)
  end
end


local function parse_string(str, i)
  local res = ""
  local j = i + 1
  local k = j

  while j <= #str do
    local x = str:byte(j)

    if x < 32 then
      decode_error(str, j, "control character in string")

    elseif x == 92 then -- `\`: Escape
      res = res .. str:sub(k, j - 1)
      j = j + 1
      local c = str:sub(j, j)
      if c == "u" then
        local hex = str:match("^[dD][89aAbB]%x%x\\u%x%x%x%x", j + 1)
                 or str:match("^%x%x%x%x", j + 1)
                 or decode_error(str, j - 1, "invalid unicode escape in string")
        res = res .. parse_unicode_escape(hex)
        j = j + #hex
      else
        if not escape_chars[c] then
          decode_error(str, j - 1, "invalid escape char '" .. c .. "' in string")
        end
        res = res .. escape_char_map_inv[c]
      end
      k = j + 1

    elseif x == 34 then -- `"`: End of string
      res = res .. str:sub(k, j - 1)
      return res, j + 1
    end

    j = j + 1
  end

  decode_error(str, i, "expected closing quote for string")
end


local function parse_number(str, i)
  local x = next_char(str, i, delim_chars)
  local s = str:sub(i, x - 1)
  local n = tonumber(s)
  if not n then
    decode_error(str, i, "invalid number '" .. s .. "'")
  end
  return n, x
end


local function parse_literal(str, i)
  local x = next_char(str, i, delim_chars)
  local word = str:sub(i, x - 1)
  if not literals[word] then
    decode_error(str, i, "invalid literal '" .. word .. "'")
  end
  return literal_map[word], x
end


local function parse_array(str, i)
  local res = {}
  local n = 1
  i = i + 1
  while 1 do
    local x
    i = next_char(str, i, space_chars, true)
    -- Empty / end of array?
    if str:sub(i, i) == "]" then
      i = i + 1
      break
    end
    -- Read token
    x, i = parse(str, i)
    res[n] = x
    n = n + 1
    -- Next token
    i = next_char(str, i, space_chars, true)
    local chr = str:sub(i, i)
    i = i + 1
    if chr == "]" then break end
    if chr ~= "," then decode_error(str, i, "expected ']' or ','") end
  end
  return res, i
end


local function parse_object(str, i)
  local res = {}
  i = i + 1
  while 1 do
    local key, val
    i = next_char(str, i, space_chars, true)
    -- Empty / end of object?
    if str:sub(i, i) == "}" then
      i = i + 1
      break
    end
    -- Read key
    if str:sub(i, i) ~= '"' then
      decode_error(str, i, "expected string for key")
    end
    key, i = parse(str, i)
    -- Read ':' delimiter
    i = next_char(str, i, space_chars, true)
    if str:sub(i, i) ~= ":" then
      decode_error(str, i, "expected ':' after key")
    end
    i = next_char(str, i + 1, space_chars, true)
    -- Read value
    val, i = parse(str, i)
    -- Set
    res[key] = val
    -- Next token
    i = next_char(str, i, space_chars, true)
    local chr = str:sub(i, i)
    i = i + 1
    if chr == "}" then break end
    if chr ~= "," then decode_error(str, i, "expected '}' or ','") end
  end
  return res, i
end


local char_func_map = {
  [ '"' ] = parse_string,
  [ "0" ] = parse_number,
  [ "1" ] = parse_number,
  [ "2" ] = parse_number,
  [ "3" ] = parse_number,
  [ "4" ] = parse_number,
  [ "5" ] = parse_number,
  [ "6" ] = parse_number,
  [ "7" ] = parse_number,
  [ "8" ] = parse_number,
  [ "9" ] = parse_number,
  [ "-" ] = parse_number,
  [ "t" ] = parse_literal,
  [ "f" ] = parse_literal,
  [ "n" ] = parse_literal,
  [ "[" ] = parse_array,
  [ "{" ] = parse_object,
}


parse = function(str, idx)
  local chr = str:sub(idx, idx)
  local f = char_func_map[chr]
  if f then
    return f(str, idx)
  end
  decode_error(str, idx, "unexpected character '" .. chr .. "'")
end


function json.decode(str)
  if type(str) ~= "string" then
    error("expected argument of type string, got " .. type(str))
  end
  local res, idx = parse(str, next_char(str, 1, space_chars, true))
  idx = next_char(str, idx, space_chars, true)
  if idx <= #str then
    decode_error(str, idx, "trailing garbage")
  end
  return res
end


return json end)
--util.keep_running()
--require "lib.GTSCRIPTS.V"
json = require "src.lib.external.json"
polyglotUtils = require "src.lib.utils"
LOC = require "src.lib.localization"

require "src.lib.menus"