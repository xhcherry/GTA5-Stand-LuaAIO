local YMencouragement={
    "欢迎使用夜幕LUA",
    "又遇到你了，真好！",
    "梦里能达到的地方，总有一天，脚步也能达到。",
    "你喜欢什么不重要，重要的是，你是否有能力去喜欢。喜欢的东西都很贵，要去努力，才有能力拥有。",
    "向每个人学习，但不要模仿任何人。",
    "伟大的成就，来自为远大的目标所花费的巨大心思和付诸的最大努力。",
    "花的生命虽然短暂，但它毕竟拥抱过春天。",
    "一生这么短，一定要回归现实生活，将余生留给最爱的人。",
    "有时候，明明心如刀割，却要灿烂的微笑，明明很脆弱，却表现的如此坚强，眼泪在眼里打转，却告诉每个人我很好。",
    "生活坏到一定程度就会好起来的，因为它无法更坏。",
    "懒可以毁掉一个人，勤可以激发一个人；对生活不失希望，微笑面对困境与磨难，心怀梦想，即使遥远，加油。",
    "世界上那些最容易的事情中，拖延时间最不费力。",
    "孤独不是给别人机会来可怜你，而是给你机会发现更强大的自己。",
    "生活，有悲伤，有惊喜，有成功，有失败。让你痛哭流涕，有时也会喜极而泣。",
    "人生如白驹过隙死不足恨但夙心往志，不闻于末世矣。",
    "人生本来一场空，有无之间的更替便是人生，得失之后的心态决定苦乐。缘来不拒，境去不留，看淡得失。",
    "无论怎样，我都相信路的尽头会有清澈的微光，黑暗过后一定是最美的黎明。",
    "有时候，上天没有给你想要的。不是因为你不配，而是你值得拥有更好的。",
    "每一个不曾起舞的日子，都是对生命的辜负。",
    "没有事情是小到不值得了解的，也没有什么事情会大到无法去尝试；你的一生我只借一程，这一程便是余生。",
    "越努力越幸运，不要给年轻找太多借口，现在你能做的，除了努力，别无其他。",
    "不要在该奋斗的年纪选择安逸，只有度过了一段连自己都被感动了的日子，才会变成那个最好的自己。",
    "无论多少岁，什么身份，都配得上五彩缤纷的生活。记得永远保有对生活热情、对生命负责的心态。",
    "不要让不好的事情毁了你这一天，乐观一点，开心一点，生命如此短暂，别浪费时间在不值一提的事情上。",
    "无论你碰到多么大的困难，都没有比放弃自己更困难！",
    "宁愿独处也不要和融不进去的人待在一起，不要刻意的去维持关系让自己越来越虚伪，宁可孤独，也不违心。",
    "一个急于赶路的人，无心欣赏身边美景的；心若累了，让它休息，灵魂的修复是人生永不干枯的希望。",
    "心宽阔了，才能明白没有一个人是孤岛，才能欣赏到对岸的风景，才能懂得如何接纳他人。",
    "无人理睬时，坚定执着。万人羡慕时，心如止水。",
    "书本里的故事，总有你学到的人生，所以要多阅读；为了自己想过的生活，勇于放弃一些东西，是值得的。",
    "人不怕卑微，就怕失去希望，期待明天，期待阳光，人就会从卑微中站起来，带着封存梦想去拥抱蓝天。",
    "诚信总会给你带来成功，但可能是下一站。",
    "希望，哪怕是不现实的幻想，也是需要的，有益的，美好的，对于青年尤其是这样。",
    "那些受过的苦，流过的泪，都将照亮我们的路。",
    "门庭若市却孜然一身，车水马龙却素昧平生。",
    "上苍不会给你快乐、也不会给你痛苦，它只会给你真实的生活。有人忍受不了生活的平淡而死去，却不知道生命本身就是奇迹！",
    "成功不是得到多少东西，而是看你把身上多余的东西扔掉多少。",
    "自强不息，进学不已",
}
random_notify = math.random(1,#YMencouragement)

local colors = {
    green = 184,
    red = 6,
    yellow = 190,
    black = 2,
    white = 1,
    gray = 3,
    pink = 190,
    purple = 49, 
    blue = 11
    }
    function notification(message, color)
        HUD._THEFEED_SET_NEXT_POST_BACKGROUND_COLOR(color)
        HUD._THEFEED_SET_NEXT_POST_BACKGROUND_COLOR(color)
        HUD._THEFEED_SET_NEXT_POST_BACKGROUND_COLOR(color)
        HUD._THEFEED_SET_NEXT_POST_BACKGROUND_COLOR(color)
        HUD._THEFEED_SET_NEXT_POST_BACKGROUND_COLOR(color)
        local picture = "CHAR_SOCIAL_CLUB"
        GRAPHICS.REQUEST_STREAMED_TEXTURE_DICT(picture, 0)
        while not GRAPHICS.HAS_STREAMED_TEXTURE_DICT_LOADED(picture) do
            util.yield()
        end
        util.BEGIN_TEXT_COMMAND_THEFEED_POST(message)
        title = "夜幕LUA"
        if color == colors.red or color == colors.red then
            subtitle = "~u~用户" .. players.get_name(players.user()) .. "&#8721;"
        elseif color == colors.black then
            subtitle = "~c~用户" .. players.get_name(players.user()) .. "&#8721;"
        else
            subtitle = "~u~用户" .. players.get_name(players.user()) .. "&#8721;"
        end
        HUD.END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT(picture, picture, true, 5, title, subtitle)
        HUD.END_TEXT_COMMAND_THEFEED_POST_TICKER(true, false)
        util.log(message)
    end
     notification("你好，尊贵的夜幕用户!\n&#8721;已连接！\n""[" .. YMencouragement[random_notify] .. "]", colors.black)
    util.on_stop(function()
     notification("下次遇见会更好!", colors.gray)
    end)