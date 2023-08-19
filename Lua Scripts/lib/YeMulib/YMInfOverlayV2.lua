local kia_max_dist = 20
local hash_cache = {}
local ent_cache = {}
local kia_scale = 0.5
local kia_show_hp = true 
local kia_show_name = true
local kia_show_heading = true
local kia_show_speed = true 
local kia_show_invincible = true
local kia_show_language = true 
local kia_show_pid = true 
local kia_show_rank = true
local kia_show_money = true
local kia_on_vehicles = false
local kia_on_peds = true 
local kia_show_kd = true
local kia_on_objects = false
local kia_show_wanted = true 
local kia_alignment = 4

local white = {r = 1.0, g = 1.0, b = 1, a = 0.6}
local green = {r = 0.0, g = 1.0 , b = 0,0, a = 0.6}
local cyan = {r = 0, g = 1, b = 1, a = 0.6}
local orange = {r = 0.7, g = 0.3, b = 0.0, a = 0.6}
local red = {r = 1.0, g = 0.0, b = 0.0, a = 0.6}

local function world_to_screen_coords(x, y, z)
    sc_x = memory.alloc(8)
    sc_y = memory.alloc(8)
    GET_SCREEN_COORD_FROM_WORLD_COORD(x, y, z, sc_x, sc_y)
    local ret = {
        x = memory.read_float(sc_x),
        y = memory.read_float(sc_y)
    }
    return ret
end

local function get_model_size(hash)
    local minptr = memory.alloc(24)
    local maxptr = memory.alloc(24)
    local min = {}
    local max = {}
    GET_MODEL_DIMENSIONS(hash, minptr, maxptr)
    min.x, min.y, min.z = v3.get(minptr)
    max.x, max.y, max.z = v3.get(maxptr)
    local size = {}
    size.x = max.x - min.x
    size.y = max.y - min.y
    size.z = max.z - min.z
    size['max'] = math.max(size.x, size.y, size.z)
    return size
end

function round(x)
    return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5)
  end

function lang_num_to_name(num) 
    local langs =
    {
        'English',
        'French', 
        'German',
        'Spanish',
        'Portuguese',
        'Polish',
        'Russian',
        'Korean',
        'Chinese (Traditional)',
        'Japanese', 
        'Mexican', 
        'Chinese (Simplified)'
    }

    if langs[num + 1] == nil then 
        return '???'
    else
        return langs[num + 1]
    end
end

function get_info_of_entity(ptr)
    if table.contains(ent_cache, ptr) then 
        return ent_cache[ptr] 
    end
    local ent = entities.pointer_to_handle(ptr)

    local info = {}
    info.health = GET_ENTITY_HEALTH(ent)
    info.hdl = ent
    info.max_health = GET_ENTITY_MAX_HEALTH(ent)
    info.heading = GET_ENTITY_HEADING(ent)
    info.size = get_model_size(GET_ENTITY_MODEL(ent))
    info.pos = v3.new(GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(ent, 0.0, 0.0, info.size.z / 1.5))
    info.invincible = not GET_ENTITY_CAN_BE_DAMAGED(ent)
    info.speed = GET_ENTITY_SPEED(ent)

    if IS_PED_A_PLAYER(ent) then 
        local pid = NETWORK_GET_PLAYER_INDEX_FROM_PED(ent)
        info.name = players.get_name_with_tags(pid)
        info.pid = pid
        info.rank = players.get_rank(pid)
        info.money = players.get_money(pid)
        info.kd = math.floor(players.get_kd(pid) * 100)/100
        info.language = lang_num_to_name(players.get_language(pid))
        info.wanted_level = GET_PLAYER_WANTED_LEVEL(pid)
        info.invincible = players.is_godmode(pid)
    else
        local mdl = GET_ENTITY_MODEL(ent) 
        if table.contains(hash_cache, mdl) then 
            info.name = hash_cache[mdl] 
        else 
            info.name = util.reverse_joaat(mdl) 
            hash_cache[mdl] = info.name
        end
        if IS_ENTITY_A_PED(ent) then 
            info.money = GET_PED_MONEY(ent)
        end
    end
        
    ent_cache[ptr] = info
    return info 
end


play_infoV2:slider("信息检测距离", {'kiamaxdist'}, '', 1, 200, 20, 1, function(dist)
    kia_max_dist = dist
end)

play_infoV2:slider_float("信息显示大小", {'kiascale'}, '', 1, 1000, 5, 1, function(scale)
    kia_scale = scale * 0.1
end)


play_infoV2:divider("显示项 ")
play_infoV2:toggle('生命值', {'kiahp'}, '', function(on)
    kia_show_hp = on
end, true)

play_infoV2:toggle('名字', {'kianame'}, '', function(on)
    kia_show_name = on
end, true)

play_infoV2:toggle('标题', {'kiaheading'}, '', function(on)
    kia_show_heading = on
end, true)

play_infoV2:toggle('速度', {'kiaspeed'}, '', function(on)
    kia_show_speed = on
end, true)


play_infoV2:toggle('钱', {'kiamoney'}, '', function(on)
    kia_show_money = on
end, true)

play_infoV2:toggle('语言', {'kialanguage'}, '', function(on)
    kia_show_language = on
end, true)

play_infoV2:toggle('水平', {'kiawanted'}, '', function(on)
    kia_show_wanted = on
end, true)


play_infoV2:toggle('是否无敌', {'kiainvincible'}, '', function(on)
    kia_show_invincible = on
end, true)

play_infoV2:toggle('PID', {'kiapid'}, '', function(on)
    kia_show_pid = on
end, true)

play_infoV2:toggle('K/D', {'kiakd'}, '', function(on)
    kia_show_kd = on
end, true)



play_infoV2:toggle('排名', {'kiarank'}, '', function(on)
    kia_show_rank = on
end, true)

play_infoV2:divider("显示关于")

play_infoV2:toggle('载具', {'kiavehicles'}, '', function(on)
    kia_on_vehicles = on 
end, false)

play_infoV2:toggle('人物', {'kiapeds'}, '', function(on)
    kia_on_peds = on    
end, true)

play_infoV2:toggle('物体', {'kiaobjects'}, '', function(on)
    kia_on_objects = on    
end, false)

function get_hp_color(hp, max_hp) 
    local perc = math.ceil((hp / max_hp)*100)
    if perc >= 100 then
        return green 
    elseif perc < 100 and perc >= 50 then 
        return orange
    elseif perc < 50 then
        return red 
    end
end 
function format_int(number)

    local i, j, minus, int, fraction = tostring(number):find('([-]?)(%d+)([.]?%d*)')
  
    -- reverse the int-string and append a comma to all blocks of 3 digits
    int = int:reverse():gsub("(%d%d%d)", "%1,")
  
    -- reverse the int-string back remove an optional comma and put the 
    -- optional minus and fractional part back
    return minus .. int:reverse():gsub("^,", "") .. fraction
  end

util.create_tick_handler(function()
    local ent_collection = {}
    if kia_on_peds then 
        for _, ped in pairs(entities.get_all_peds_as_pointers()) do
            local c1 = players.get_cam_pos(players.user())
            local c2 = v3.new(entities.get_position(ped))
            if v3.distance(c1, c2) < kia_max_dist then
                ent_collection[#ent_collection+1] = get_info_of_entity(ped)
            end
        end
    end

    if kia_on_vehicles then 
        for _, veh in pairs(entities.get_all_vehicles_as_pointers()) do
            local c1 =  players.get_cam_pos(players.user())
            local c2 = v3.new(entities.get_position(veh))
            if v3.distance(c1, c2) < kia_max_dist then
                ent_collection[#ent_collection+1] = get_info_of_entity(veh)
            end
        end
    end

    if kia_on_objects then 
        for _, obj in pairs(entities.get_all_objects_as_pointers()) do
            local c1 =  players.get_cam_pos(players.user())
            local c2 = v3.new(entities.get_position(obj))
            if v3.distance(c1, c2) < kia_max_dist then
                ent_collection[#ent_collection+1] = get_info_of_entity(obj)
            end
        end
    end

    for _, info in pairs(ent_collection) do 
        local line_spacing = kia_scale /  30
        local cur_y_off = line_spacing
        if info.hdl ~= players.user_ped() then 
            local info_pos = world_to_screen_coords(info.pos.x, info.pos.y, info.pos.z)
            if kia_show_name then 
                directx.draw_text(info_pos.x, info_pos.y + cur_y_off, '名称' ..tostring(info.name), kia_alignment, kia_scale, white, false, nil)
                cur_y_off += line_spacing
            end

            if kia_show_hp then 
                local hp_color = get_hp_color(info.health, info.max_health)
                directx.draw_text(info_pos.x, info_pos.y + cur_y_off,  '生命值' ..tostring(info.health) .. '/' .. tostring(info.max_health), kia_alignment, kia_scale, hp_color, false, nil)
                cur_y_off += line_spacing
            end

            if kia_show_heading then 
                directx.draw_text(info_pos.x, info_pos.y + cur_y_off, tostring(math.ceil(info.heading)) .. '°', kia_alignment, kia_scale, white, false, nil)
                cur_y_off += line_spacing
            end

            if kia_show_invincible then 
                if info.invincible then 
                    directx.draw_text(info_pos.x, info_pos.y + cur_y_off, '是否无敌', kia_alignment, kia_scale, green, false, nil)
                    cur_y_off += line_spacing
                end
            end

            if kia_show_speed then 
                if info.speed > 0 then 
                    directx.draw_text(info_pos.x, info_pos.y + cur_y_off, tostring(math.ceil(info.speed)) .. ' 米/秒', kia_alignment, kia_scale, cyan, false, nil)
                    cur_y_off += line_spacing
                end
            end

            if IS_PED_A_PLAYER(info.hdl) then 
                if kia_show_pid then 
                    directx.draw_text(info_pos.x, info_pos.y + cur_y_off, 'PID: ' .. tostring(info.pid), kia_alignment, kia_scale, white, false, nil)
                    cur_y_off += line_spacing
                end

                if kia_show_rank then 
                    directx.draw_text(info_pos.x, info_pos.y + cur_y_off, '排名: ' .. tostring(info.rank), kia_alignment, kia_scale, white, false, nil)
                    cur_y_off += line_spacing
                end

                if kia_show_kd then 
                    directx.draw_text(info_pos.x, info_pos.y + cur_y_off, tostring(info.kd) .. ' KD', kia_alignment, kia_scale, white, false, nil)
                    cur_y_off += line_spacing
                end

                if kia_show_language then
                    directx.draw_text(info_pos.x, info_pos.y + cur_y_off, '说话 ' ..  info.language, kia_alignment, kia_scale, cyan, false, nil)
                    cur_y_off += line_spacing
                end 
                
                if kia_show_wanted then 
                    if info.wanted_level > 0 then 
                        directx.draw_text(info_pos.x, info_pos.y + cur_y_off, tostring(info.wanted_level) .. ' stars', kia_alignment, kia_scale, red, false, nil)
                        cur_y_off += line_spacing
                    end
                end

            end
            
            if IS_ENTITY_A_PED(info.hdl) then 
                if kia_show_money then 
                    directx.draw_text(info_pos.x, info_pos.y + cur_y_off, '$' .. format_int(info.money), kia_alignment, kia_scale, green, false, nil)
                    cur_y_off += line_spacing
                end
            end

        end
    end

end)

play_infoV2:divider('功能作者:Lance')