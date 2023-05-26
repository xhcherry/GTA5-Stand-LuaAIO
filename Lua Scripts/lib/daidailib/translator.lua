
----函数库
function tableToUrlParams(t)
    local url_params = {}
    for k, v in pairs(t) do
        table.insert(url_params, url_encode(k) .. '=' .. url_encode(v))
    end
    return table.concat(url_params, "&")
end
function url_encode(text)
    if (text) then
        text = string.gsub(text, "\n", "\r\n")
        text = string.gsub(text, "([^%w ])", function(c)
            return string.format("%%%02X", string.byte(c))
        end)
        text = string.gsub(text, " ", "+")
    end
    return text
end
function unicode_escape(unicode)
    return utf8.char(tonumber(unicode, 16))
end

local Config = {}
function Config:new()
    local newConfig = {}
    setmetatable(newConfig, self)--setmetatable把 mymetatable 设为 mytable 的元表
    return newConfig
end
    Config.__index = function(self, key)
        if key == "LangKeyList" then
            return getLangKeyList()
        elseif key == "LangNameList" then
            return getLangNameList()
        elseif key == "LangLookupByKey" then
            return getLangLookupByKey()
        elseif key == "LangLookupByName" then
            return getLangLookupByName()
        else
            return rawget(self, key)
        end
    end
    local config = Config:new()
        config.translationMethodIncoming = "Google Translate"
        config.targetLanguageIncoming = "af"
        config.blacklistedLanguages = {}
        config.translateOn = false
        config.translateSelf = true
        config.translatedMsgLocation = 5


    local Languages = {
        { Name = "简体中文",             Key = "zh-cn" },
        { Name = "繁体中文",             Key = "zh-tw" },
        { Name = "英语",                 Key = "en" },
        { Name = "法语",                 Key = "fr" },
        { Name = "德语",                 Key = "de" },
        { Name = "日语",                 Key = "ja" },
        { Name = "俄语",                 Key = "ru" },
        { Name = "泰语",                 Key = "th" },
    }

    local LangPairs = {}
    local LangKeyList = {}
    local LangNameList = {}
    local LangLookupByName = {}
    local LangLookupByKey = {}

    for i = 1, #Languages do
        local Language = Languages[i]
        LangPairs[i] = { key = Language.Key, name = Language.Name }
        LangLookupByName[Language.Name] = Language.Key
        LangLookupByKey[Language.Key] = Language.Name
    end

    table.sort(LangPairs, function(a, b)
        return a.name < b.name
    end)

    for i = 1, #LangPairs do
        LangKeyList[i] = LangPairs[i].key
        LangNameList[i] = LangPairs[i].name
    end

    function getLangNameList()
        return LangNameList
    end
    function getLangKeyList()
        return LangKeyList
    end
    function getLangLookupByKey()
        return LangLookupByKey
    end
    function getLangLookupByName()
        return LangLookupByName
    end


    ----翻译函数
    function createGoogleTranslateCall(config)
        return function(text, targetLang, onSuccess)
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
                q = url_encode(text),
            }
            async_http.init("translate.googleapis.com", "/translate_a/t?" .. tableToUrlParams(params),function(body, header_fields, status_code)
                    if status_code == 200 and body ~= "" then
                        util.log("[谷歌翻译]: " .. body)
                        local translation, sourceLang = body:match('%[%["(.-)","(.-)"%]%]')
                        translation = translation:gsub("\\u(%x%x%x%x)", unicode_escape)
                        translation = translation:gsub(" <code> 0 </code> ", "\n")
                        translation = translation:gsub("<code>0</code>", "\n")
                        translation = translation:gsub("\\(.)", "%1")
                        onSuccess(translation, sourceLang)
                    else
                        util.toast("翻译错误，原始消息：{arg1}，状态代码：{arg2}", text, tostring(status_code))
                    end
                end)
            for key, value in pairs(HEADERS) do
                async_http.add_header(key, value)
            end
            async_http.dispatch()
        end
    end


    
    --翻译方法
    local createMethods = {["Google Translate"] = createGoogleTranslateCall,}
    function translateText(text, targetLang, translationMethod, config, onSuccess)
        if createMethods[translationMethod] then
            createMethods[translationMethod](config)(text, targetLang, function(translation, sourceLang)
                onSuccess(translation, sourceLang:lower())
            end)
        end
    end


    local botSend = false -- 避免无限循环
    function createOnMessageCallback(config, translateTextCB)
        return function(sender, reserved, text, team_chat, networked, is_auto)
            if not config.translateOn then
                return
            end
            if not botSend then
                if not config.translateSelf and (sender == players.user()) then
                    return
                else
                    translateTextCB(text, config.targetLanguageIncoming, config.translationMethodIncoming, config, function(translation, sourceLang)
                        --ScaleformLib
                        sfchat = require("lib.daidailib.ScaleformLib")("multiplayer_chat")
                        sfchat:draw_fullscreen()
                        local senderName = players.get_name(sender)
                        local resultText = translation
                        local translatedMsgLocation = config.translatedMsgLocation
                        if config.blacklistedLanguages[sourceLang] == true then
                            return
                        end

                        if (translatedMsgLocation == 1) then--"团队聊天未联网"
                            sfchat.ADD_MESSAGE(senderName, resultText, "团队", false, 1)
                        end
                        if (translatedMsgLocation == 2) then--"团队聊天已联网"
                            botSend = true
                            chat.send_message(senderName .. " : " .. resultText, true, false, true)
                            sfchat.ADD_MESSAGE(senderName, resultText, "团队", false, 1)
                        end
                        if (translatedMsgLocation == 3) then--"全球聊天未联网",
                            sfchat.ADD_MESSAGE(senderName, resultText, "全部", false, 1)
                        end
                        if (translatedMsgLocation == 4) then--"全球聊天已联网"
                            botSend = true
                            chat.send_message(senderName .. " : " .. resultText, false, false, true)
                            sfchat.ADD_MESSAGE(senderName, resultText, "全部", false, 1)
                        end
                        if (translatedMsgLocation == 5) then--通知
                            notification("~y~~bold~"..senderName .. " : " .. resultText, math.random(0, 200))
                        end
                    end)
                end
            end
            botSend = false
        end
    end



    

    menu.toggle(chat_transl, "开启", {},"翻译器将监听传入的消息并进行翻译", function(on)
            config.translateOn = on
    end)

    menu.toggle(chat_transl, "翻译自己", {}, "翻译您自己发送的消息", function(on)
        config.translateSelf = on
    end,true)
    local TranslatedMsgLocationOptions = {
        "团队聊天未联网",
        "团队聊天已联网",
        "全球聊天未联网",
        "全球聊天已联网",
        "通知"
    }
    menu.list_select(chat_transl, "翻译位置", {},"选择翻译的位置", TranslatedMsgLocationOptions, 5,function(index, option, prevIndex, clickType)
        config.translatedMsgLocation = index
    end)

    local blacklistMenu = menu.list(chat_transl, "翻译语言黑名单", {},"在列表中开启的语言的消息将被忽略")
        for i, langKey in ipairs(config.LangKeyList) do
            config.blacklistedLanguages[langKey] = false
            blacklistMenu:toggle(config.LangLookupByKey[langKey], {}, "", function(on)
                config.blacklistedLanguages[langKey] = on
            end, false)
        end

    menu.list_select(chat_transl, "目标语言", {}, "",config.LangNameList, 1, function(index, option, prevIndex, clickType)
            config.targetLanguageIncoming = config.LangLookupByName[option]
    end)

    chat.on_message(createOnMessageCallback(config, translateText))