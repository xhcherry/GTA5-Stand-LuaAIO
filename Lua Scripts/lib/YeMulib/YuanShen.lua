util.log("\n□□□□□□□□□□□□□■□□□□□■□□□□□□□□□■□□□□□□□□□□□□□■□□□\n□■■■■■■■■■■□□□■□□□□■□□□□□□□□□□■□□□□□□■■■□□□■□□□\n□■□□□■□□□□□□■■■■□■■■■■■□□□■■■■■■■■■□□□□□□□□■□□□\n□■□■■■■■■■□□□□□■□■□■□□■□□□■□□□□□□□■□□□□□□□■■■■■\n□■□■□□□□□■□□□□■□□■□■□□■□□□■□□□□□□□■□■■■■■□□■□□■\n□■□■■■■■■■□□□□■■□■■■■■■□□□■■■■■■■■■□□□■□□□□■□□■\n□■□■□□□□□■□□□■■□■■□■□□■□□□■□□□□□□□□□□■□□□□□■□□■\n□■□■■■■■■■□□■□■□□■□■□□■□□□■■■■■■■■■□□■□■□□□■□□■\n□■□□□□■□□□□□□□■□□■■■■■■□□□■■□□□□□□■□■□□□■□□■□□■\n□■□□■□■□■□□□□□■□□■□■□□■□□■□■□□□□□□■□■■■■■□□■□□■\n□■□■□□■□□■□□□□■□□□□■□□□□□■□■■■■■■■■□□□□□□□■□□□■\n■□■□□■■□□□■□□□■□□□□■□□□□■□□■□□□□□□■□□□□□□■□□■■□")


util.toast("你这个原批" .. players.get_name(players.user()) .. "纯纯的米孝子")
YUANSHEN1 = menu.list(YUANSHEN, "原神", {""}, "！！！")
menu.divider(YUANSHEN1, "妈的，忍不了，一秒把原神打开！他钟离的雷神", {}, "")
menu.divider(YUANSHEN1, "的温迪的纳西妲的刻晴的凝光的行秋的重云的香", {}, "")
menu.divider(YUANSHEN1, "菱的胡桃的甘雨的可莉的万叶的凌华的凌人的早", {}, "")
menu.divider(YUANSHEN1, "柚的优菈的迪卢克的阿贝多的班尼特的宵宫的莫", {}, "")
menu.divider(YUANSHEN1, "娜的申鹤的璃月的蒙德的稻妻的须弥的至冬的原", {}, "")
menu.divider(YUANSHEN1, "神的都是我的嗯啊，原原原！！好好玩原原原原", {}, "")
menu.divider(YUANSHEN1, "原原原蹦蹦炸弹！拒收病婿！天理尝蛆！靖妖傩", {}, "")
menu.divider(YUANSHEN1, "舞！烧冻鸡翅！斩尽牛杂！这是斩灭海参的力量", {}, "")
menu.divider(YUANSHEN1, "这是忘放孜然！神里流霜灭！别想投胎哦！裁雨", {}, "")
menu.divider(YUANSHEN1, "留虹！无想的一刀！大原特原！大原特原！", {}, "")

menu.divider(YUANSHEN, "所有人目光向我看齐!我宣布个事!")

local OPA = {
  "我爱玩原神",
  "么么么,我爱琴",
  "么么么,我爱安柏",
  "么么么,我爱丽莎",
  "么么么,我爱芭芭拉",
  "么么么,我爱可莉",
  "么么么,我爱诺艾尔",
  "么么么,我爱菲谢尔",
  "么么么,我爱砂糖",
  "么么么,我爱莫娜",
  "么么么,我爱迪奥娜",
  "么么么,我爱罗莎莉亚",
  "么么么,我爱优菈",
  "么么么,我爱埃洛伊",
  "么么么,我爱北斗",
  "么么么,我爱凝光",
  "么么么,我爱香菱",
  "么么么,我爱刻晴",
  "么么么,我爱七七",
  "么么么,我爱辛焱",
  "么么么,我爱甘雨",
  "么么么,我爱胡桃",
  "么么么,我爱绯烟",
  "么么么,我爱神里绫华",
  "么么么,我爱宵宫",
  "么么么,我爱早柚",
  "么么么,我爱雷电将军",
  "么么么,我爱九条裟罗",
  "么么么,我爱珊瑚宫心海",
  "么么么,我爱纳西妲",
  "么么么,我爱妮露",
  "么么么,我爱派蒙",
  "我是琴的狗",
  "我是安柏的狗",
  "我是丽莎的狗",
  "我是芭芭拉的狗",
  "我是可莉的狗",
  "我是诺艾尔的狗",
  "我是菲谢尔的狗",
  "我是砂糖的狗",
  "我是莫娜的狗",
  "我是迪奥娜的狗",
  "我是罗莎莉亚的狗",
  "我是优菈的狗",
  "我是埃洛伊的狗",
  "我是北斗的狗",
  "我是凝光的狗",
  "我是香菱的狗",
  "我是刻晴的狗",
  "我是七七的狗",
  "我是辛焱的狗",
  "我是甘雨的狗",
  "我是胡桃的狗",
  "我是绯烟的狗",
  "我是神里绫华的狗",
  "我是山里灵活的狗",
  "我是宵宫的狗",
  "我是早柚的狗",
  "我是雷电将军的狗",
  "我是九条裟罗的狗",
  "我是珊瑚宫心海的狗",
  "我是纳西妲的狗",
  "我是妮露的狗",
  "我是派蒙的狗",
  "我是米哈游的狗",
  "原!原!原!原!原!",
  "大原特原!大原特原!",
  "哥求求你了给我玩一会原神吧",
  "我一秒不玩原神身上就像有蚂蚁再爬一般痒",
  "啊啊啊啊啊啊啊啊,我他妈一秒打开原神",
  "我太爱原神了",
  "我是十足的米孝子",
  "原!我的命!",
  "GTAV画质还不如原神",
  "我就爱玩原神",
  "塞尔达不是抄袭原神的吗?",
  "感谢米哈游大爹创造了原神",
  "因为原神烧鸡变多了",
  "我天天晚上在被窝里玩原神",
  "我天天晚上在被窝里对着神里绫华打胶",
  "送我20原石你就是我爹",
  "不玩原神的闭嘴",
  "你玩过原神吗?你那垃圾电脑带不动吧",
  "都给我下载原神https://ys.mihoyo.com/",
  "煞笔二刺猿不如玩原神",
  "不如原神",
}
local OPB = {}
local OPC = 0
local function e412b2c28b479a79fc59a86cbc()
  local OPD = {}
  for i = 1, #OPA do
    if not OPB[i] then
      table.insert(OPD, i)
    end
  end
  if #OPD == 0 then
    OPB = {}
    OPD = {1, 2, 3}
  end
  local OPE = OPD[math.random(#OPD)]
  OPB[OPE] = true
  local OPF = OPA[OPE]
  chat.send_message(OPF, false, true, true)
end
menu.action(YUANSHEN, "随机发送OP宣言", {""}, "*免责声明*\n我不能确保你的Stand不会因为短期频繁使用此功能而不被封禁\n\n建议在\n线上 > 聊天选项 > 记录战局聊天信息\n开启信息记录功能(被封禁可能也没啥用)", function()
  OPC = OPC + 1

  if OPC == 100 then
    chat.send_message("我是米孝子,我是米卫兵", false, true, true)
  elseif OPC == 500 then
    chat.send_message("我晚上做梦意淫原神女角色", false, true, true)
  elseif OPC == 1000 then
    chat.send_message("今天我开心,送大家每人一万原石", false, true, true)
  else
    math.randomseed(os.time())
    e412b2c28b479a79fc59a86cbc()
  end
end)
menu.divider(YUANSHEN, "原神! 启动!")
menu.hyperlink(YUANSHEN, "下载崩坏学院2", "https://www.benghuai.com/")
menu.hyperlink(YUANSHEN, "下载崩坏3", "https://www.bh3.com/")
menu.hyperlink(YUANSHEN, "下载未定事件簿", "https://wd.mihoyo.com/")
menu.hyperlink(YUANSHEN, "下载原神", "https://ys.mihoyo.com/")
menu.hyperlink(YUANSHEN, "下载Genshin", "https://genshin.hoyoverse.com/en")
menu.hyperlink(YUANSHEN, "下载崩坏：星穹铁道", "https://sr.mihoyo.com/")
menu.hyperlink(YUANSHEN, "下载绝区零", "https://zzz.mihoyo.com/")
menu.hyperlink(YUANSHEN, "打开米哈游", "https://www.mihoyo.com/")
