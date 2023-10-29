local Languages = {
	{ Name = "Afrikaans-南非荷兰语", Key = "af" },
	{ Name = "Albanian-阿尔巴尼亚语", Key = "sq" },
	{ Name = "Arabic-阿拉伯语", Key = "ar" },
	{ Name = "Azerbaijani-阿塞拜疆语", Key = "az" },
	{ Name = "Basque-巴斯克语", Key = "eu" },
	{ Name = "Belarusian-白俄罗斯语", Key = "be" },
	{ Name = "Bengali-孟加拉语", Key = "bn" },
	{ Name = "Bulgarian-保加利亚语", Key = "bg" },
	{ Name = "Catalan-加泰罗尼亚语", Key = "ca" },
	{ Name = "Chinese Simplified-简体中文", Key = "zh-CN" },
	{ Name = "Chinese Traditional-繁体中文", Key = "zh-TW" },
	{ Name = "Croatian-克罗地亚语", Key = "hr" },
	{ Name = "Czech-捷克语", Key = "cs" },
	{ Name = "Danish-丹麦语", Key = "da" },
	{ Name = "Dutch-荷兰语", Key = "nl" },
	{ Name = "English-英语", Key = "en" },
	{ Name = "Esperanto-世界语", Key = "eo" },
	{ Name = "Estonian-爱沙尼亚语", Key = "et" },
	{ Name = "Filipino-菲律宾语", Key = "tl" },
	{ Name = "Finnish-芬兰语", Key = "fi" },
	{ Name = "French-法语", Key = "fr" },
	{ Name = "Galician-加利西亚语", Key = "gl" },
	{ Name = "Georgian-格鲁吉亚语", Key = "ka" },
	{ Name = "German-德语", Key = "de" },
	{ Name = "Greek-希腊语", Key = "el" },
	{ Name = "Gujarati-古吉尔特拉语", Key = "gu" },
	{ Name = "Haitian Creole-海地克里奥尔语", Key = "ht" },
	{ Name = "Hebrew-希伯来语", Key = "iw" },
	{ Name = "Hindi-印度语(印度北部)", Key = "hi" },
	{ Name = "Hungarian-匈牙利语", Key = "hu" },
	{ Name = "Icelandic-冰岛语", Key = "is" },
	{ Name = "Indonesian-印度尼西亚语", Key = "id" },
	{ Name = "Irish-爱尔兰语", Key = "ga" },
	{ Name = "Italian-意大利语", Key = "it" },
	{ Name = "Japanese-日语", Key = "ja" },
	{ Name = "Kannada-坎纳达语(印度西南部)", Key = "kn" },
	{ Name = "Korean-韩语", Key = "ko" },
	{ Name = "Latin-拉丁语", Key = "la" },
	{ Name = "Latvian-拉脱维亚语", Key = "lv" },
	{ Name = "Lithuanian-立陶宛语", Key = "lt" },
	{ Name = "Macedonian-马其顿语", Key = "mk" },
	{ Name = "Malay-马来语", Key = "ms" },
	{ Name = "Maltese-马耳他语", Key = "mt" },
	{ Name = "Norwegian-挪威语", Key = "no" },
	{ Name = "Persian-波斯语", Key = "fa" },
	{ Name = "Polish-波兰语", Key = "pl" },
	{ Name = "Portuguese-葡萄牙语", Key = "pt" },
	{ Name = "Romanian-罗马尼亚语", Key = "ro" },
	{ Name = "Russian-俄语", Key = "ru" },
	{ Name = "Serbian-塞尔维亚语", Key = "sr" },
	{ Name = "Slovak-斯洛伐克语", Key = "sk" },
	{ Name = "Slovenian-斯洛文尼亚语", Key = "sl" },
	{ Name = "Spanish-西班牙语", Key = "es" },
	{ Name = "Swahili-斯瓦西里语(非洲东部)", Key = "sw" },
	{ Name = "Swedish-瑞典语", Key = "sv" },
	{ Name = "Tamil-泰米尔语", Key = "ta" },
	{ Name = "Telugu-泰卢固语", Key = "te" },
	{ Name = "Thai-泰语", Key = "th" },
	{ Name = "Turkish-土耳其语", Key = "tr" },
	{ Name = "Ukrainian-乌克兰语", Key = "uk" },
	{ Name = "Urdu-乌尔都语(印度巴基斯坦通用语言)", Key = "ur" },
	{ Name = "Vietnamese-越南语", Key = "vi" },
	{ Name = "Welsh-威尔士语", Key = "cy" },
	{ Name = "Yiddish-意第绪语(犹太语)", Key = "yi" },
}

local LangKeys = {}
local LangName = {}
local LangIndexes = {}
local LangLookupByName = {}
local LangLookupByKey = {}
local PlayerSpooflist = {}
local PlayerSpoof = {}

for i=1,#Languages do
	local Language = Languages[i]
	LangKeys[i] = Language.Name
	LangName[i] = Language.Name
	LangIndexes[Language.Key] = i
	LangLookupByName[Language.Name] = Language.Key
	LangLookupByKey[Language.Key] = Language.Name
end

table.sort(LangKeys)

function encode(text)
	return string.gsub(text, "%s", "+")
end

menu.toggle(fanyigongneng, "启用战局翻译", {}, '', function(on) 
    run = on
end, true)
    
targetlangmenu = menu.slider_text(fanyigongneng, "选择翻译后的语言", {}, "切换后单击此选项以进行更改", LangName, function(s)
    targetlang = LangLookupByName[LangKeys[s]]
end)


tradlocamenu = menu.slider_text(fanyigongneng, "翻译结果显示位置", {}, "切换后单击此选项以进行更改", {"通知栏","团队(团队可见)", "全部(仅本地可见)", "全部(全部可见)", "团队(仅本地可见)"}, function(s)
    Tradloca = s
end)

menu.toggle(fanyigongneng, "翻译自己的信息", {}, "", function(on)
    traductself = on	
end)
traductsamelang = false
menu.toggle(fanyigongneng, "翻译同当前选中的语言", {}, "若无法正常使用请见谅,因为采用谷歌翻译", function(on)
    traductsamelang = on	
end)

traductmymessage = menu.list(fanyigongneng, "将发送的信息翻译成其他语言")
finallangmenu = menu.slider_text(traductmymessage, "翻译成", {"finallang"}, "发送的消息被翻译成当前选中语言，切换后单击此选项以进行更改", LangName, function(s)
   targetlangmessagesend = LangLookupByName[LangKeys[s]]
end)

spoofsend = menu.slider_text(traductmymessage, "选择由谁发送这个信息", {"Spoofas"}, "仅自己可见", PlayerSpooflist, function(s)
    spoofingas = PlayerSpoof[s]
end)
menu.action(traductmymessage, "发送消息", {"Sendmessage"}, "", function(on_click)
    menu.show_command_box("Sendmessage ")
end, function(on_command)
    mytext = on_command
    async_http.init("translate.googleapis.com", "/translate_a/single?client=gtx&sl=auto&tl="..targetlangmessagesend.."&dt=t&q="..encode(mytext), function(Sucess)
        if Sucess ~= "" then
            translation, original, sourceLang = Sucess:match("^%[%[%[\"(.-)\",\"(.-)\",.-,.-,.-]],.-,\"(.-)\"")
            for _, PlayerID in ipairs(players.list()) do
                chat.send_targeted_message(PlayerID, spoofingas,string.gsub(translation, "%+", " "), false)
            end
        end
    end)
    async_http.dispatch()
end)
botsend = false
ran = 0
chat.on_message(function(packet_sender, message_sender, text, team_chat)
if run  then
if not botsend then
    if not traductself and (packet_sender == players.user()) then
    else
    async_http.init("translate.googleapis.com", "/translate_a/single?client=gtx&sl=auto&tl="..targetlang.."&dt=t&q="..encode(text), function(Sucess)
        if Sucess ~= "" then
            translation, original, sourceLang = Sucess:match("^%[%[%[\"(.-)\",\"(.-)\",.-,.-,.-]],.-,\"(.-)\"")
            if not traductsamelang and (sourceLang == targetlang)then
            else
                if (Tradloca == 1) then	
                    util.toast(players.get_name(packet_sender).." : "..string.gsub(translation, "%+", " "), TOAST_ALL)
                end if (Tradloca == 2) then
                    botsend = true
                    chat.send_message(players.get_name(packet_sender).." : "..string.gsub(translation, "%+", " "), true, true, true)
                end if (Tradloca == 3) then
                    chat.send_message(players.get_name(packet_sender).." : "..string.gsub(translation, "%+", " "), false, true, false)
                end if (Tradloca == 4) then
                    botsend = true
                    chat.send_message(players.get_name(packet_sender).." : "..string.gsub(translation, "%+", " "), false, true, true)
                end if (Tradloca == 5) then
                    chat.send_message(players.get_name(packet_sender).." : "..string.gsub(translation, "%+", " "), true, true, false)
                end
            end
        end
    end)
    async_http.dispatch()
    end
end
botsend = false
end
end)
players.on_join(function(PlayerID)
    PlayerSpooflist[PlayerID] = players.get_name(PlayerID)
    PlayerSpoof[PlayerID] = PlayerID
    menu.set_action_slider_options(spoofsend, PlayerSpooflist)
    if (PlayerID == players.user()) then
        spoofingas = PlayerID
        menu.set_value(spoofsend, PlayerID)
    end
end)

players.on_leave(function(PlayerID)
    PlayerSpooflist[PlayerID] = nil
    PlayerSpoof[PlayerID] = nil
    menu.set_action_slider_options(spoofsend, PlayerSpooflist)
end)

run = 0
while run<10 do 
	Tradloca = menu.get_value(tradlocamenu)
	targetlangmessagesend = LangLookupByName[LangKeys[menu.get_value(finallangmenu)]]
	targetlang = LangLookupByName[LangKeys[menu.get_value(targetlangmenu)]]
	util.yield()
	run = run+1
end
