local Y0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1
Y0_1 = require
L1_1 = "json"
Y0_1 = Y0_1(L1_1)
L1_1 = "en"
L2_1 = false
L3_1 = "en"
L4_1 = 1
function L5_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  if A0_2 then
    L1_2 = string
    L1_2 = L1_2.gsub
    L2_2 = A0_2
    L3_2 = "\n"
    L4_2 = "\r\n"
    L1_2 = L1_2(L2_2, L3_2, L4_2)
    A0_2 = L1_2
    L1_2 = string
    L1_2 = L1_2.gsub
    L2_2 = A0_2
    L3_2 = "([^%w ])"
    function L4_2(A0_3)
      local L1_3, L2_3, L3_3, L4_3
      L1_3 = string
      L1_3 = L1_3.format
      L2_3 = "%%%02X"
      L3_3 = string
      L3_3 = L3_3.byte
      L4_3 = A0_3
      L3_3, L4_3 = L3_3(L4_3)
      return L1_3(L2_3, L3_3, L4_3)
    end
    L1_2 = L1_2(L2_2, L3_2, L4_2)
    A0_2 = L1_2
    L1_2 = string
    L1_2 = L1_2.gsub
    L2_2 = A0_2
    L3_2 = " "
    L4_2 = "+"
    L1_2 = L1_2(L2_2, L3_2, L4_2)
    A0_2 = L1_2
  end
  return A0_2
end
encode_url = L5_1
L5_1 = {}
L6_1 = {}
L6_1.code = "en"
L6_1.name = "英语"
L7_1 = {}
L7_1.code = "zh-cn"
L7_1.name = "简体中文"
L8_1 = {}
L8_1.code = "zh-tw"
L8_1.name = "繁体中文"
L9_1 = {}
L9_1.code = "ko"
L9_1.name = "韩语"
L10_1 = {}
L10_1.code = "ja"
L10_1.name = "日语"
L11_1 = {}
L11_1.code = "hi"
L11_1.name = "印地语"
L12_1 = {}
L12_1.code = "es"
L12_1.name = "西班牙语"
L13_1 = {}
L13_1.code = "fr"
L13_1.name = "法语"
L14_1 = {}
L14_1.code = "ar"
L14_1.name = "阿拉伯语"
L15_1 = {}
L15_1.code = "bn"
L15_1.name = "孟加拉语"
L16_1 = {}
L16_1.code = "ru"
L16_1.name = "俄语"
L17_1 = {}
L17_1.code = "pt"
L17_1.name = "葡萄牙语"
L18_1 = {}
L18_1.code = "id"
L18_1.name = "印度尼西亚语"
L19_1 = {}
L19_1.code = "ur"
L19_1.name = "乌都语"
L20_1 = {}
L20_1.code = "de"
L20_1.name = "德语"
L21_1 = {}
L21_1.code = "sw"
L21_1.name = "斯瓦希里语"
L22_1 = {}
L22_1.code = "mr"
L22_1.name = "马拉塔语"
L23_1 = {}
L23_1.code = "te"
L23_1.name = "泰卢固语"
L24_1 = {}
L24_1.code = "tr"
L24_1.name = "土耳其语"
L25_1 = {}
L25_1.code = "ta"
L25_1.name = "泰米尔语"
L26_1 = {}
L26_1.code = "vi"
L26_1.name = "越南语"
L5_1[1] = L6_1
L5_1[2] = L7_1
L5_1[3] = L8_1
L5_1[4] = L9_1
L5_1[5] = L10_1
L5_1[6] = L11_1
L5_1[7] = L12_1
L5_1[8] = L13_1
L5_1[9] = L14_1
L5_1[10] = L15_1
L5_1[11] = L16_1
L5_1[12] = L17_1
L5_1[13] = L18_1
L5_1[14] = L19_1
L5_1[15] = L20_1
L5_1[16] = L21_1
L5_1[17] = L22_1
L5_1[18] = L23_1
L5_1[19] = L24_1
L5_1[20] = L25_1
L5_1[21] = L26_1
L6_1 = {}
L7_1 = ipairs
L8_1 = L5_1
L7_1, L8_1, L9_1, L10_1 = L7_1(L8_1)
for L11_1, L12_1 in L7_1, L8_1, L9_1, L10_1 do
  L13_1 = table
  L13_1 = L13_1.insert
  L14_1 = L6_1
  L15_1 = L12_1.name
  L13_1(L14_1, L15_1)
end
function L7_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L3_2 = string
  L3_2 = L3_2.format
  L4_2 = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=%s&dt=t&q=%s"
  L5_2 = A1_2
  L6_2 = encode_url
  L7_2 = A0_2
  L6_2, L7_2, L8_2 = L6_2(L7_2)
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
  L4_2 = async_http
  L4_2 = L4_2.init
  L5_2 = L3_2
  L6_2 = nil
  function L7_2(A0_3, A1_3, A2_3)
    local L3_3, L4_3, L5_3
    if 200 == A2_3 then
      L3_3 = Y0_1.decode
      L4_3 = A0_3
      L3_3 = L3_3(L4_3)
      if L3_3 then
        L4_3 = L3_3[1]
        if L4_3 then
          L4_3 = L3_3[1]
          L4_3 = L4_3[1]
          if L4_3 then
            L4_3 = L3_3[1]
            L4_3 = L4_3[1]
            L4_3 = L4_3[1]
            if L4_3 then
              L4_3 = A2_2
              L5_3 = L3_3[1]
              L5_3 = L5_3[1]
              L5_3 = L5_3[1]
              L4_3(L5_3)
          end
        end
      end
      else
        L4_3 = util
        L4_3 = L4_3.toast
        L5_3 = "翻译出错啦"
        L4_3(L5_3)
      end
    else
      L3_3 = util
      L3_3 = L3_3.toast
      L4_3 = "Failed,status_code: "
      L5_3 = A2_3
      L4_3 = L4_3 .. L5_3
      L3_3(L4_3)
    end
  end
  function L8_2(A0_3)
    local L1_3, L2_3
    L1_3 = util
    L1_3 = L1_3.toast
    L2_3 = "请求发送失败"
    L1_3(L2_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2)
  L4_2 = async_http
  L4_2 = L4_2.dispatch
  L4_2()
end
function L8_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L3_2 = L2_1
  if L3_2 then
    L3_2 = PLAYER
    L3_2 = L3_2.GET_PLAYER_NAME
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    L4_2 = string
    L4_2 = L4_2.format
    L5_2 = "[%s] %s: %s"
    L6_2 = A1_2
    L7_2 = L3_2
    L8_2 = A2_2
    L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
    function L5_2(A0_3)
      local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
      L1_3 = string
      L1_3 = L1_3.format
      L2_3 = "%s: %s"
      L3_3 = L3_2
      L4_3 = A0_3
      L1_3 = L1_3(L2_3, L3_3, L4_3)
      L2_3 = notification
      L3_3 = "~y~~bold~"
      L4_3 = L1_3
      L3_3 = L3_3 .. L4_3
      L4_3 = nil
      L5_3 = "翻译"
      L2_3(L3_3, L4_3, L5_3)
      L2_3 = LOG
      L3_3 = string
      L3_3 = L3_3.format
      L4_3 = "[谷歌翻译] %s: [%s] ⇒ [%s]"
      L5_3 = L3_2
      L6_3 = A2_2
      L7_3 = A0_3
      L3_3, L4_3, L5_3, L6_3, L7_3 = L3_3(L4_3, L5_3, L6_3, L7_3)
      L2_3(L3_3, L4_3, L5_3, L6_3, L7_3)
    end
    L6_2 = L7_1
    L7_2 = A2_2
    L8_2 = L1_1
    L9_2 = L5_2
    L6_2(L7_2, L8_2, L9_2)
  end
end
L9_1 = chat
L9_1 = L9_1.on_message
L10_1 = L8_1
L9_1(L10_1)
function L9_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2
  function L3_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3
    L1_3 = A2_2
    if 2 == L1_3 then
      L1_3 = chat
      L1_3 = L1_3.send_message
      L2_3 = A0_3
      L3_3 = false
      L4_3 = true
      L5_3 = true
      L1_3(L2_3, L3_3, L4_3, L5_3)
    else
      L1_3 = chat
      L1_3 = L1_3.send_message
      L2_3 = A0_3
      L3_3 = true
      L4_3 = true
      L5_3 = true
      L1_3(L2_3, L3_3, L4_3, L5_3)
    end
  end
  L4_2 = L7_1
  L5_2 = A0_2
  L6_2 = A1_2
  L7_2 = L3_2
  L4_2(L5_2, L6_2, L7_2)
end
L10_1 = menu
L10_1 = L10_1.list
L11_1 = chat_transl
L12_1 = "谷歌线路"
L13_1 = {}
L14_1 = ""
L10_1 = L10_1(L11_1, L12_1, L13_1, L14_1)
L11_1 = menu
L11_1 = L11_1.toggle
L12_1 = L10_1
L13_1 = "启用/禁用翻译"
L14_1 = {}
L15_1 = "translate"
L14_1[1] = L15_1
L15_1 = ""
function L16_1(A0_2)
  local L1_2
  L2_1 = A0_2
end
L11_1(L12_1, L13_1, L14_1, L15_1, L16_1)
L11_1 = menu
L11_1 = L11_1.list_select
L12_1 = L10_1
L13_1 = "目标语言"
L14_1 = {}
L15_1 = "选择最终语言"
L16_1 = L6_1
L17_1 = 1
function L18_1(A0_2)
  local L1_2
  L1_2 = L5_1
  L1_2 = L1_2[A0_2]
  L1_2 = L1_2.code
  L1_1 = L1_2
end
L11_1(L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1)
L11_1 = menu
L11_1 = L11_1.list
L12_1 = L10_1
L13_1 = "自定义消息"
L14_1 = {}
L15_1 = "翻译并发送自定义消息"
L11_1 = L11_1(L12_1, L13_1, L14_1, L15_1)
L12_1 = menu
L12_1 = L12_1.list_select
L13_1 = L11_1
L14_1 = "目标语言"
L15_1 = {}
L16_1 = "选择最终语言"
L17_1 = L6_1
L18_1 = 1
function L19_1(A0_2)
  local L1_2
  L1_2 = L5_1
  L1_2 = L1_2[A0_2]
  L1_2 = L1_2.code
  L3_1 = L1_2
end
L12_1(L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1)
L12_1 = menu
L12_1 = L12_1.list_select
L13_1 = L11_1
L14_1 = "发送消息到"
L15_1 = {}
L16_1 = "选择是将消息发送到团队聊天还是全部聊天"
L17_1 = {}
L18_1 = "团队聊天"
L19_1 = "全部聊天"
L17_1[1] = L18_1
L17_1[2] = L19_1
L18_1 = 1
function L19_1(A0_2)
  local L1_2
  L4_1 = A0_2
end
L12_1(L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1)
L12_1 = menu
L12_1 = L12_1.text_input
L13_1 = L11_1
L14_1 = "消息"
L15_1 = {}
L16_1 = "transmessage"
L15_1[1] = L16_1
L16_1 = "输入要发送的消息"
function L17_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  if "" == A0_2 then
    return
  end
  L1_2 = L9_1
  L2_2 = A0_2
  L3_2 = L3_1
  L4_2 = L4_1
  L1_2(L2_2, L3_2, L4_2)
end
L12_1(L13_1, L14_1, L15_1, L16_1, L17_1)
