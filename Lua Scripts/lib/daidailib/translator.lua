--配置
local config = {
    translationMethodIncoming = "Google Translate",--默认平台
    targetLanguageIncoming = "zh-cn",--默认语言
    blacklistedLanguages = {},--默认黑名单
    translateOn = false,--默认翻译器状态
    translateSelf = true,--默认翻译自己
    translatedMsgLocation = 5--默认翻译位置
}

local Languages = {
    { Name = "简体中文",             Key = "zh-cn" },
    { Name = "繁体中文",             Key = "zh-tw" },
    { Name = "英语",                 Key = "en" },
    { Name = "韩语",                 Key = "ko" },
    { Name = "法语",                 Key = "fr" },
    { Name = "德语",                 Key = "de" },
    { Name = "日语",                 Key = "ja" },
    { Name = "俄语",                 Key = "ru" },
    { Name = "泰语",                 Key = "th" },
    { Name = "南非荷兰语",           Key = "af" },
    { Name = "阿尔巴尼亚语",         Key = "sq" },
    { Name = "阿拉伯语",             Key = "ar" },
    { Name = "阿塞拜疆语",           Key = "az" },
    { Name = "巴士克语",             Key = "eu" },
    { Name = "比利时语",             Key = "be" },
    { Name = "孟加拉语",             Key = "bn" },
    { Name = "保加利亚语",           Key = "bg" },
    { Name = "加泰隆语",             Key = "ca" },
    { Name = "克罗地亚语",           Key = "hr" },
    { Name = "捷克语",               Key = "cs" },
    { Name = "丹麦语",               Key = "da" },
    { Name = "荷兰语",               Key = "nl" },
    { Name = "世界语",               Key = "eo" },
    { Name = "爱沙尼亚语",           Key = "et" },
    { Name = "菲律宾语",             Key = "tl" },
    { Name = "芬兰语",               Key = "fi" },
    { Name = "加利西亚语",           Key = "gl" },
    { Name = "乔治亚语",             Key = "ka" },
    { Name = "希腊语",               Key = "el" },
    { Name = "古吉拉特语",           Key = "gu" },
    { Name = "海地克里奥尔语",       Key = "ht" },
    { Name = "希伯来语",             Key = "iw" },
    { Name = "印地语",               Key = "hi" },
    { Name = "匈牙利语",             Key = "hu" },
    { Name = "冰岛语",               Key = "is" },
    { Name = "印度尼西亚语",         Key = "id" },
    { Name = "爱尔兰语",             Key = "ga" },
    { Name = "意大利语",             Key = "it" },
    { Name = "卡纳拉语",             Key = "kn" },
    { Name = "拉丁语",               Key = "la" },
    { Name = "拉脱维亚语",           Key = "lv" },
    { Name = "立陶宛语",             Key = "lt" },
    { Name = "马其顿语",             Key = "mk" },
    { Name = "马来语",               Key = "ms" },
    { Name = "马耳他语",             Key = "mt" },
    { Name = "挪威语",               Key = "no" },
    { Name = "波斯语",               Key = "fa" },
    { Name = "波兰语",               Key = "pl" },
    { Name = "葡萄牙语",             Key = "pt" },
    { Name = "罗马尼亚",             Key = "ro" },
    { Name = "塞尔维亚语",           Key = "sr" },
    { Name = "斯洛伐克语",           Key = "sk" },
    { Name = "斯洛文尼亚语",         Key = "sl" },
    { Name = "西班牙语",             Key = "es" },
    { Name = "斯瓦希里语",           Key = "sw" },
    { Name = "瑞典语",               Key = "sv" },
    { Name = "泰米尔语",             Key = "ta" },
    { Name = "泰卢固语",             Key = "te" },
    { Name = "土耳其语",             Key = "tr" },
    { Name = "乌克兰语",             Key = "uk" },
    { Name = "乌都语",               Key = "ur" },
    { Name = "越南语",               Key = "vi" },
    { Name = "威尔士语",             Key = "cy" },
    { Name = "意第绪语",             Key = "yi" }
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

--[[ table.sort(LangPairs, function(a, b)--对LangPairs表元素排序
    return a.name < b.name
end) ]]

for i = 1, #LangPairs do
    LangKeyList[i] = LangPairs[i].key
    LangNameList[i] = LangPairs[i].name
end



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

----翻译函数
function createGoogleTranslateCall(config)
    return function(text, targetLang, onSuccess)
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
                    local translation, sourceLang = body:match('%[%["(.-)","(.-)"%]%]')
                    translation = translation:gsub("\\u(%x%x%x%x)", unicode_escape)
                    translation = translation:gsub(" <code> 0 </code> ", "\n")
                    translation = translation:gsub("<code>0</code>", "\n")
                    translation = translation:gsub("\\(.)", "%1")
                    onSuccess(translation, sourceLang)
                end
            end,function()
                util.toast("翻译出错啦")
            end)
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
local transl_text_col = 1 --白色
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
                    local senderName = players.get_name(sender)
                    local resultText = translation
                    local translatedMsgLocation = config.translatedMsgLocation
                    if config.blacklistedLanguages[sourceLang] == true then
                        return
                    end

                    util.log("[谷歌翻译]: " ..string.format('["%s"]', text).." ⇒ ".. string.format('["%s"]', translation))

                    if (translatedMsgLocation == 1) then--"团队聊天未联网"
                        sfchat.ADD_MESSAGE(senderName, resultText, "团队(未联网)", false, transl_text_col)
                    end
                    if (translatedMsgLocation == 2) then--"团队聊天已联网"
                        botSend = true
                        chat.send_message(senderName .. " : " .. resultText, true, false, true)
                        sfchat.ADD_MESSAGE(senderName, resultText, "团队", false, transl_text_col)
                    end
                    if (translatedMsgLocation == 3) then--"全球聊天未联网",
                        sfchat.ADD_MESSAGE(senderName, resultText, "全部(未联网)", false, transl_text_col)
                    end
                    if (translatedMsgLocation == 4) then--"全球聊天已联网"
                        botSend = true
                        chat.send_message(senderName .. " : " .. resultText, false, false, true)
                        sfchat.ADD_MESSAGE(senderName, resultText, "全部", false, transl_text_col)
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

local TranslatedMsgLocationOptions = {"团队聊天未联网","团队聊天已联网","全球聊天未联网","全球聊天已联网","通知"}
menu.list_select(chat_transl, "翻译位置", {},"选择翻译的位置", TranslatedMsgLocationOptions, 5, function(index, option, prevIndex, clickType)
    config.translatedMsgLocation = index
end)

local blacklistMenu = menu.list(chat_transl, "翻译语言黑名单", {},"在列表中开启的语言的消息将被忽略")
    for i, langKey in ipairs(LangKeyList) do
        config.blacklistedLanguages[langKey] = false
        blacklistMenu:toggle(LangLookupByKey[langKey], {}, "", function(on)
            config.blacklistedLanguages[langKey] = on
        end, false)
    end

menu.list_select(chat_transl, "目标语言", {}, "",LangNameList, 1, function(index)
    config.targetLanguageIncoming = LangKeyList[index]
end)

local common_settings = menu.list(chat_transl, "通用设置", {},"")
    local trans_col_name = {"纯白","白色","黑色","灰色","浅灰色","暗灰色","红色","浅红色","暗红色","蓝色","浅蓝色","暗蓝色","黄色","浅黄色","暗黄色","橙色","浅橙色","暗橙色","绿色","浅绿色","暗绿色",}
    menu.list_select(common_settings, '翻译文本颜色', {''}, '', trans_col_name, 2, function (c)
        transl_text_col = c - 1
    end)

chat.on_message(createOnMessageCallback(config, translateText))