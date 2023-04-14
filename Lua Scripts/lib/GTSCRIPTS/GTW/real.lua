function realheart()
notification("谢谢你，能发现这个选项，并且点击了它，写下它之前，我想了很多很多\n希望你的人与事情不会为你带来压力，同时也希望事情中的任何人也不会有压力，希望你每天都开心快乐没有烦恼，与任何人和任何事都是的极其美好状态，\n也不会因为杂碎的事情而打破自己的心情，真心的祝福你\n如果真的不可避免，\n祝福你未来不会孤独的一个人承受，会有其他人聆听,而不会形只影单，\n也不会只能无奈的看着天花板,不要再半夜胡思乱想，遇到烦心事不要抱着酒瓶子库库炫一顿，\n这个样子对自己很不好，\n不仅对身体不好，对自己的心情也会有更大的影响,\n我的现实目前很糟糕，很多烦心的事情，\n围绕着我,即使我现在很不好，\n但是我仍然想为你们撑一把伞，即使我什么都做不了，但是我能对你有一个诚实的祝福\n希望你今后不会像我一样，遇到了不愉快的事情，只能去无奈，去心酸，却又一点办法都没有，我能做的就是为大家提供脚本的更新支持，除此之外没有别的，\n我也不会得到什么心灵安慰，\n而我可能仍然会困在糟糕的情绪中，我实在不想憋着了，所以请允许将这段话写进这里\n我不想描绘一幅不诚实的画面，但是很希望你们不会像我一样,我试图让这条通知变得更容易发现，但我不会这样做，\n因为显得我太矫情，同时我又很希望将我的心意传达给你们,我总是守护着自己心里的最纯真的东西，它导致我现实中心态很脆弱，总是被一切不起眼的事情而难过,\n我也在修正我自己,我希望你们遇到了令人痛苦，烦恼，烦恼之类的事情，能有一个或者多个人多个事情能在你们身边安慰你，能让糟糕心情不再那么糟糕，真心的祝福\n献给GRANDTOURINGVIP的顶级作弊者们")
draw_string(string.format("~q~  ♥♥        ♥♥ "), 0.300,0.300,1.5,5)
draw_string(string.format("~q~♥        ♥       ♥"), 0.300,0.400,1.5,5)
draw_string(string.format("~q~ ♥                ♥"), 0.300,0.500,1.5,5)
draw_string(string.format("~q~    ♥          ♥"), 0.300,0.600,1.5,5)
draw_string(string.format("~q~        ♥   ♥"), 0.300,0.700,1.5,5)
draw_string(string.format("~q~           ♥   "), 0.302,0.760,1.5,5)
--[[scaleform_thread = util.create_thread(function (thr)
scaleForm = GRAPHICS.REQUEST_SCALEFORM_MOVIE("POPUP_WARNING")
GRAPHICS.DRAW_RECT(-1, .5, 1, -1, 255, 158, 177, 255)
GRAPHICS.BEGIN_SCALEFORM_MOVIE_METHOD(scaleForm, "SHOW_POPUP_WARNING")
GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(scaleForm, 0, 0, 0, 0, 0)
GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_FLOAT(500.0)
GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("~h~~q~希望真诚的人都能被真诚相待")
GRAPHICS.SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING("~h~~q~那么这个世界也就不会有悲伤")
GRAPHICS.END_SCALEFORM_MOVIE_METHOD(scaleForm)
starttime = os.time()
while true do
if os.time() - starttime >= 0 then
util.stop_thread()
end
if GRAPHICS.HAS_SCALEFORM_MOVIE_LOADED(scaleForm) then
GRAPHICS.DRAW_SCALEFORM_MOVIE_FULLSCREEN(scaleForm, 255, 255, 255, 255, 0)
end
util.yield(0)
end
end)]]
end