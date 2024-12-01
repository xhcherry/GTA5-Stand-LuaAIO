local stat_type = 1  --默认值int
local stst_name = ""
local readvalue = ""

menu.text_input(Stat_Editor, "STAT", {"input_stats_name"}, "", function(value)
    if value == "" then return end
    stst_name = value
end)
local stat_type_menu = menu.list_select(Stat_Editor, "类型", {}, "操作前务必确认stat值的类型", {{ "int" }, { "float" }, { "string" }, { "bool" }}, 1, function(value)
    stat_type = value
end)

menu.divider(Stat_Editor, "读取")

local stat_readvalue = menu.readonly(Stat_Editor, "值")

menu.action(Stat_Editor, "读取", {}, "", function()
    if stat_type == 1 then
        readvalue = STAT_GET_INT(stst_name)
    elseif stat_type == 2 then
        readvalue = STAT_GET_FLOAT(stst_name)
    elseif stat_type == 3 then
        readvalue = STAT_GET_STRING(stst_name)
    elseif stat_type == 4 then
        readvalue = STAT_GET_BOOL(stst_name)
    end
    menu.set_value(stat_readvalue, tostring(readvalue))
end)



menu.divider(Stat_Editor, "设置")

menu.text_input(Stat_Editor, "设置值", {"set_stats_value"}, "",function(value)
    if value == "" then return end

    if stat_type == 1 then  --int
        value = tonumber(value)
        if type(value) == "number" then
            STAT_SET_INT(stst_name, value)
        else
            util.toast("设置失败: 格式错误")
            return
        end
    elseif stat_type == 2 then  --float
        value = tonumber(value)
        if type(value) == "number" then
            STAT_SET_FLOAT(stst_name, value)
        else
            util.toast("设置失败: 格式错误")
            return
        end
    elseif stat_type == 3 then  --string
        if type(value) == "string" then
            STAT_SET_STRING(stst_name, value)
        else
            util.toast("设置失败: 格式错误")
            return
        end
    elseif stat_type == 4 then  --bool
        if value == "true" then
            STAT_SET_BOOL(stst_name, true)
        elseif value == "false" then
            STAT_SET_BOOL(stst_name, false)
        else
            util.toast("设置失败: 格式错误")
            return
        end
    end

    util.toast("设置完成")
end)
