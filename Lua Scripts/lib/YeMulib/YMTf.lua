---------------------------------------------夜幕独家，CV请鸣谢夜幕----------------------
util.require_natives("natives-1681379138g-uno")

Transfer:action("传送周围的可拾取物品到你这里", {}, "可能会传过来一些奇怪的东西 过于频繁的点按可能会导致游戏崩溃 当周围可拾取物品较多时,传送可能会导致掉帧", function()
    local pickup_entitycount = 0  
    local player_user_pos = players.get_position(players.user()) --获取玩家坐标
    menu.trigger_commands("infopickups on")
    for entities.get_all_pickups_as_handles() as pickups do    --循环获取周围可拾取的句柄
        SET_ENTITY_COORDS(pickups, player_user_pos, false, false, false, false)  --将拾取物传送到自己
        pickup_entitycount += 1   --每传送一个计数+1
        util.yield()
    end
    if pickup_entitycount == 0 then
            util.toast("似乎没有可拾取物")
    else
            util.toast("已经将" .. pickup_entitycount .. " 个可拾取物传送到你这里")
    end
    util.yield(2500)
    menu.trigger_commands("infopickups off")
end)

Transfer:action("传送到杰瑞德的包裹", {}, "你需要先进入杰瑞德包裹搜索区域(白圈)然后使用此功能才会直接将你传送到包裹位置 尽量不要在其它地方使用此功能否则会导致误传送 如果你不知道包裹搜索区域在哪请打开\"杰瑞德每日包裹位置\"查看", function()
    local drug_packageHash = 765087784
    local find_flag = 0;
    menu.trigger_commands("infopickups on")
    for entities.get_all_objects_as_handles() as objects do    --循环获取周围物体的句柄
        if(entities.get_model_hash(objects)== drug_packageHash) then
            local drug_packageHash_postion = GET_ENTITY_COORDS(objects,false)
            SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), drug_packageHash_postion, false, false, false, false)  --将自己传送到包裹附近
            find_flag =1;
            util.toast("已经找到杰瑞德的包裹，正在传送....")
            util.yield()
        end
    end

    if(find_flag!=1) then  
            util.toast("似乎没有找到杰瑞德的包裹，请进入杰瑞德包裹搜索区域(白圈)然后使用此功能 如果你不知道包裹搜索区域在哪请打开\"杰瑞德每日包裹位置\"查看 如有BUG问题请及时反馈给夜幕开发者")
    end
    util.yield()
end)
function TELEPORT_TO_DESIGNATIVE_BILP(sprite)
    for i = 0, 866, 1 do
        local blip = HUD.GET_CLOSEST_BLIP_INFO_ID(i)
        if HUD.DOES_BLIP_EXIST(blip) then
            local blip_sprite = HUD.GET_BLIP_SPRITE(blip)
            local blip_type = HUD.GET_BLIP_INFO_ID_TYPE(blip)
            local blip_colour = HUD.GET_BLIP_COLOUR(blip)
            local blip_hud_colour = HUD.GET_BLIP_HUD_COLOUR(blip)
            local blip_display = HUD.GET_BLIP_INFO_ID_DISPLAY(blip)
            if blip_sprite == sprite and blip_type == 4 and blip_colour == 7 and blip_hud_colour == 29 and blip_display == 4 then
                local blip_pos = HUD.GET_BLIP_COORDS(blip)
                if  blip_pos ~= nil then
                    players.teleport_3d(players.user(),blip_pos.x, blip_pos.y, blip_pos.z+1.1)
                    return true
                end
            end
        end
    end
    return false
end
Transfer:action("传送到藏货地点", {"teleporttogscachestashhouse"}, "", function()
    if TELEPORT_TO_DESIGNATIVE_BILP(845) then
        util.toast("正在传送")
    else
        util.toast("未找到藏货地点,或许今天你已经拿到了藏货")
    end
end)
Transfer:hyperlink("杰瑞德每日包裹位置","https://gtaweb.eu/gtao-map/ls/26u152ugy70g")
Transfer:readonly("感谢拾取传送功能提供者", "graies")