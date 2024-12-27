

menu.toggle(Advanced_chat, "开启", {}, "", function(on)
    conditional_coloring = on
end)

local change_color = menu.list(Advanced_chat, "更改颜色", {}, "")
local tags_root = menu.list(Advanced_chat, "标签", {}, "根据某些标准给每个人标签")
local general_settings = menu.list(Advanced_chat, "通用设置", {}, "最大聊天时长等")

local max_chat_len = 254
menu.slider(general_settings, "最大聊天长度", {}, "超出此范围的任何内容都将自动被修剪,不适用于您的聊天.", 1, 254, 254, 1, function(value)
    max_chat_len = value
end)

local max_chats = 10000
menu.slider(general_settings, "最多显示行数", {}, "可以显示/在历史记录中的最大聊天行数,超过此值的任何内容都不会显示.", 1, 20, 10, 1, function(value)
    max_chats = value * 1000
end)

--[[ local max_times = 10000
menu.slider(general_settings, "最大显示时长", {}, "", 1, 20, 10, 1, function(value)
    max_times = value * 1000
end) ]]

local uwuify = false
menu.toggle(general_settings, "UwU", {}, "可爱化聊天", function(on)
    uwuify = on
end)




local hud_colors = {me = 224,friends = 225,strangers = 226,modders = 227}
function replace_hud_color(index, color)
    HUD.REPLACE_HUD_COLOUR_WITH_RGBA(index, color.r * 255, color.g * 255, color.b * 255, color.a * 255)
end

local me_color = {r = 1, g = 0, b = 1, a = 1}
change_color:colour("自我", {"chatmecolor"}, "", me_color, true, function(rgb)
    replace_hud_color(hud_colors.me, rgb)
end)

local friends_color = {r = 0, g = 1, b = 0, a = 1}
change_color:colour("友好", {"chatfriendcolor"}, "", friends_color, true, function(rgb)
    replace_hud_color(hud_colors.friends, rgb)
end)

local strangers_color = {r = 1, g = 1, b = 1, a = 1}
change_color:colour("陌生人", {"chatstrangercolor"}, "", strangers_color, true, function(rgb)
    replace_hud_color(hud_colors.strangers, rgb)
end)

local modders_color = {r = 1, g = 0, b = 0, a = 1}
change_color:colour("作弊者", {"chatmoddercolor"}, "", modders_color, true, function(rgb)
    replace_hud_color(hud_colors.modders, rgb)
end)


replace_hud_color(hud_colors.me, me_color)
replace_hud_color(hud_colors.friends, friends_color)
replace_hud_color(hud_colors.strangers, strangers_color)
replace_hud_color(hud_colors.modders, modders_color)



local tag_mode = 1
menu.list_select(tags_root,"当前标签", {}, "选择标签", {{1,"GTAV默认"}, {2,"Stand标签"}, {3,"自定义文本"}, {4,"没有标签"}}, 1, function(index)
    tag_mode = index
end)
custom_tagtxt = menu.action(tags_root,"自定义标签文本", {}, "", function()
    local label = util.register_label("输入文本")
	local input = get_input_from_screen_keyboard(label, 5, "")
    if input == "" then return end
    menu.set_menu_name(custom_tagtxt, '自定义标签文本: ' .. input)
    custom_tag = input
end)



local handle_ptr = memory.alloc(13*8)
local function pid_to_handle(pid)
    NETWORK.NETWORK_HANDLE_FROM_PLAYER(pid, handle_ptr, 13)
    return handle_ptr
end

-- some code from https://github.com/cummodore69/uwuifier/blob/main/uwuifier/uwuifier.lua
function uwu(text)
    text = string.lower(text):gsub("l", "w"):gsub("r", "w"):gsub("v", "f"):gsub("i", "i-i"):gsub("d", "d-d"):gsub("n", "n-n")
    local ran = math.random(1,3)
    if ran == 1 then
        text = text .. " uwu"
    elseif ran == 2 then
        text = text .. " nya.."
    elseif ran == 3 then
        text = text .. " ><"
    end
    return text
end

local message_history = {}
function new_chat_obj(player_name, player_color, tag, text, networked)
    local chat = {
        name = player_name,
        color = player_color,
        tag = tag, 
        text = text,
        networked = networked
    }
    return chat
end

chat.on_message(function(sender, reserved, text, team_chat, networked, is_auto)
    if conditional_coloring then
        --清除历史消息
        sfchat.RESET()

        --截取文本最大长度
        if players.user() ~= sender then 
            text = text:sub(1, max_chat_len)
        end
        --可爱化聊天
        if uwuify then 
            text = uwu(text)
        end
        --更改颜色
        local player_color = 1
        local hdl = pid_to_handle(sender)

        if sender == players.user() then 
            player_color = hud_colors.me
        elseif players.is_marked_as_modder(sender) then 
            player_color = hud_colors.modders
        elseif NETWORK.NETWORK_IS_FRIEND(hdl) then
            player_color = hud_colors.friends
        else
            player_color = hud_colors.strangers
        end

        -- 自定义标签
        if tag_mode == 1 then 
            tag = team_chat and "团队" or "全部"
        elseif tag_mode == 2 then 
            tag = players.get_tags_string(sender)
        elseif tag_mode == 3 then
            tag = custom_tag
        elseif tag_mode == 4 then
            tag = ""
        end

        --加入聊天内容
        local this_chat = new_chat_obj(players.get_name(sender), player_color, tag, text, networked)
        message_history[#message_history + 1] = this_chat

        --截取最大行数外内容
        if #message_history > max_chats then
            table.remove(message_history, 1)
        end

        --显示历史消息
        for _, chat in pairs(message_history) do
            sfchat.ADD_MESSAGE(chat.name, chat.text, chat.tag, chat.networked, chat.color)
        end
        sfchat.showFeed()--显示聊天记录
    end
end)