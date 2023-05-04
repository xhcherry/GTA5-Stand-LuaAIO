--on为开启，off为关闭，按需修改(请不要修改除了on与off之外的的任何内容)
if SCRIPT_MANUAL_START then 
    menu.trigger_commands("hostqu on") --主机序列
    menu.trigger_commands("scriptname on") --脚本名称
    menu.trigger_commands("hostqus off") --实体池显示
    menu.trigger_commands("scriptinfo off") --名称信息
    menu.trigger_commands("timeos off") --显示时间
    menu.trigger_commands("dayos off") --显示日期
    menu.trigger_commands("gtpng off") --显示图片
    menu.trigger_commands("playerbar1 off") --玩家栏1.0 
    menu.trigger_commands("playerbar2 off") --玩家栏2.0
    menu.trigger_commands("gifpng off") --GIF图片显示
    menu.trigger_commands("newsplay off") --新闻恶搞
    menu.trigger_commands("speedmeteor off") --显示速度
    menu.trigger_commands("standedition off") --Stand版本
end