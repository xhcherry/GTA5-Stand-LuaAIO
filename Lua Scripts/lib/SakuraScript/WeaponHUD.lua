local weapon_images = {}
local resources_dir = filesystem.resources_dir() .. '\\SakuraImg\\weaponhud\\'

--读取图片
for _, path in pairs(filesystem.list_files(resources_dir)) do 
    local gun_image = string.gsub(path, resources_dir, '')
    local gun_name = string.gsub(gun_image, '.png', '')
    weapon_images[gun_name] = directx.create_texture(path)
end

--位置
local pos_x = 0.82
local pos_y = 0.8

--颜色
local MAIN_COLOR = {r = 1, g = 1, b = 1, a = 0.8}
local OUT_OF_AMMO_COLOR = {r = 1, g = 0, b = 0, a = 0.8}--空弹药

local wep_hash_ptr = memory.alloc(4)
local ammo_in_clip_ptr = memory.alloc(4)
local cur_total_ammo_for_gun = 0
memory.write_int(ammo_in_clip_ptr, 0)




menu.toggle_loop(weapon_hud,'武器HUD', {}, '', function()
    if NETWORK.NETWORK_IS_SESSION_STARTED() then
        local veh = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
        if not PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID()) or (PED.IS_PED_DOING_DRIVEBY(PLAYER.PLAYER_PED_ID()) and veh ~= 0) then 
            WEAPON.GET_CURRENT_PED_WEAPON(PLAYER.PLAYER_PED_ID(), wep_hash_ptr, true)
            local wep_hash = memory.read_int(wep_hash_ptr)
            local wep_name = util.reverse_joaat(wep_hash)
            --if WEAPON.GET_WEAPON_DAMAGE_TYPE(wep_hash) ~= 2 then
                if wep_name == '' then 
                    if wep_hash == 350597077 then
                        wep_name = 'WEAPON_TACTICALSMG'
                    elseif wep_hash == 911657153 then
                        wep_name = 'WEAPON_STUNGUN'
                    else
                        wep_name = 'WEAPON_UNKNOWN'
                    end
                end
                wep_name = string.lower(wep_name)
                if weapon_images[wep_name] ~= nil then
                    directx.draw_texture(weapon_images[wep_name], 0.02, 0.02, 1.0, 0.5, pos_x, pos_y, 0, MAIN_COLOR)
                    WEAPON.GET_AMMO_IN_CLIP(PLAYER.PLAYER_PED_ID(), wep_hash, ammo_in_clip_ptr)
                    local ammo_in_clip = memory.read_int(ammo_in_clip_ptr)
                    local max_clip_ammo = WEAPON.GET_MAX_AMMO_IN_CLIP(PLAYER.PLAYER_PED_ID(), wep_hash, true)
                    if max_clip_ammo == ammo_in_clip then
                        cur_total_ammo_for_gun = WEAPON.GET_AMMO_IN_PED_WEAPON(PLAYER.PLAYER_PED_ID(), wep_hash) - max_clip_ammo
                    end
                    if WEAPON.GET_WEAPON_DAMAGE_TYPE(wep_hash) ~= 2 then
                        if ammo_in_clip == 1 then
                            directx.draw_text(pos_x+0.03, pos_y-0.01, ammo_in_clip + cur_total_ammo_for_gun, 6, 0.8, ammo_in_clip > 0 and MAIN_COLOR or OUT_OF_AMMO_COLOR)
                        else
                            directx.draw_text(pos_x+0.03, pos_y-0.01, ammo_in_clip, 6, 0.8, ammo_in_clip > 0 and MAIN_COLOR or OUT_OF_AMMO_COLOR)
                            directx.draw_text(pos_x+0.03, pos_y+0.01, cur_total_ammo_for_gun + 1, 6, 0.45,  cur_total_ammo_for_gun > 0 and MAIN_COLOR or OUT_OF_AMMO_COLOR)
                        end
                    end

                    --HUD_line
                    directx.draw_line(pos_x+0.037, pos_y-0.022, pos_x+0.037, pos_y+0.018, MAIN_COLOR)
                end
            --end
        end
    end
end)

menu.divider(weapon_hud,"设置")
menu.slider_float(weapon_hud,'位置 X', {}, '', 0, 1000, 82, 1, function(val)
    pos_x = val * 0.01
end)
menu.slider_float(weapon_hud,'位置 Y', {}, '', 0, 1000, 80, 1, function(val)
    pos_y = val * 0.01
end)
menu.toggle_loop(weapon_hud,'禁用游戏弹药HUD', {''}, '', function()
    HUD.HIDE_HUD_COMPONENT_THIS_FRAME(2)
end)

