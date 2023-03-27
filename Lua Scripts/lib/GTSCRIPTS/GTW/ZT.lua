local clr = {r=0,g=1,b=1,a=1}
menu.rainbow(
menu.colour(ZT, "主题颜色", {""}, "", clr, true, function(val)
clr = val
end)
)
local spacer_ref = menu.ref_by_path("Stand>Settings>Appearance>Spacer Size", 24)
local list_height = menu.ref_by_path("Stand>Settings>Appearance>List Height", 35)
local tab_height = menu.ref_by_path("Stand>Settings>Appearance>Tabs>Height", 35)
local tab_wid_ref = menu.ref_by_path("Stand>Settings>Appearance>Tabs>Width", 24)
local tab_pos_ref = menu.ref_by_path("Stand>Settings>Appearance>Tabs>Position", 24)
local addr_ref = menu.ref_by_path("Stand>Settings>Appearance>Address Bar>Address Bar", 24)
local addr_height_ref = menu.ref_by_path("Stand>Settings>Appearance>Address Bar>Height", 24)
local bg_ref_r = menu.ref_by_path("Stand>Settings>Appearance>Colours>Background Colour>Red", 24)
local bg_ref_g = menu.ref_by_path("Stand>Settings>Appearance>Colours>Background Colour>Green", 24)
local bg_ref_b = menu.ref_by_path("Stand>Settings>Appearance>Colours>Background Colour>Blue", 24)
local bg_ref_a = menu.ref_by_path("Stand>Settings>Appearance>Colours>Background Colour>Opacity", 24)

local time = util.current_time_millis
local timer = time()
local pulsel = true

menu.toggle(ZT,"重置动画", {}, "", function(st) pulsel = st end, pulsel)
local animsp = 0.001
menu.slider(ZT,"动画速度", {""}, "", -2147483648, 2147483647, 100, 20, function(val) timer = time() animsp = val/100000 end)
local sep_height = 1/1080
menu.slider(ZT, "选项分离高度", {""}, "", 0, 16, 1, 1, function(val) sep_height = val/1080 end)

local last_slot
local def_height = 32/1080
util.create_tick_handler(function()
local list_h = menu.get_value(list_height)/1080
local tab_h = menu.get_value(tab_height)/1080
local bg_clr = {
r=menu.get_value(bg_ref_r)/0,
g=menu.get_value(bg_ref_g)/129,
b=menu.get_value(bg_ref_b)/131,
a=menu.get_value(bg_ref_a)/255,
}
if menu.command_box_is_open() then
local command_box_x, command_box_y, command_box_w = menu.command_box_get_dimensions()
for i=0,23 do
local pct = i/24
pct = pct*0.8+0.2
pct = pct*clr.a*0.7
local fd = {
r=bg_clr.r*(1-pct) + clr.r*pct,
g=bg_clr.g*(1-pct) + clr.g*pct,
b=bg_clr.b*(1-pct) + clr.b*pct,
a=1
}
directx.draw_rect(command_box_x, command_box_y + i/1080,command_box_w,1/1080,fd)
end
end
if not menu.is_open() then
return true
end
local sl = menu.get_active_list_cursor_text(true,true)
if pulsel and last_slot and last_slot ~= sl then
timer = time()
end
last_slot = sl
local spacer = menu.get_value(spacer_ref)
local spacer_x = spacer/1920
local spacer_y = spacer/1080
local tab_wid = menu.get_value(tab_wid_ref)/1920
local addr_h = menu.get_value(addr_height_ref)/1080
local menu_x, menu_y, menu_w, menu_h = menu.get_main_view_position_and_size()
local menu_w_pix = menu_w*1920
for i=0,menu_w_pix-1 do
local pct = i / menu_w_pix
if animsp ~= 0 then
pct = ((pct - (time()-timer)*animsp)%1)
end
pct = pct * clr.a
local fd = {
r=bg_clr.r*(1-pct) + clr.r*pct,
g=bg_clr.g*(1-pct) + clr.g*pct,
 b=bg_clr.b*(1-pct) + clr.b*pct,
a=1
}
directx.draw_rect(i/1920+menu_x,menu_y,1/1920,math.min(menu_h, 1),
 bg_clr.r*(1-pct) + clr.r*pct,
bg_clr.g*(1-pct) + clr.g*pct,
bg_clr.b*(1-pct) + clr.b*pct,
1)
end
if sep_height ~= 0 and list_h ~= 0 then
for i=1,math.ceil(menu_h/(list_h)-1) do
directx.draw_rect(menu_x,menu_y + i*list_h-sep_height,menu_w,sep_height*2,clr)
if i > 1000 then break end
end
directx.draw_rect(menu_x,menu_y,menu_w,sep_height,clr)
directx.draw_rect(menu_x,menu_y+menu_h-sep_height,menu_w,sep_height,clr)
end
local tab_cnt = 7
if menu.get_edition() == 0 then
tab_cnt = 8
end
local addr_offs = 0
local addr_offs_l = 0
local addr_offs_r = 0
if menu.are_tabs_visible() then
local tab_pos = menu.get_value(tab_pos_ref)
if tab_pos == 1 then 
addr_offs = tab_h + spacer_y
directx.draw_rect(menu_x,menu_y-spacer_y-tab_h,tab_wid*tab_cnt,tab_h,bg_clr)
for i=0,tab_cnt-1 do
directx.draw_rect(menu_x+tab_wid*i,menu_y-spacer_y-3/1080,tab_wid,3/1080,clr)
directx.draw_rect(menu_x+tab_wid*i + tab_wid/2 - 8/1920,menu_y-spacer_y-3/1080,16/1920,3/1080,clr)
end
elseif tab_pos == 5 then
directx.draw_rect(menu_x - tab_wid - spacer_x,menu_y,tab_wid,tab_h*tab_cnt,clr)
addr_offs_l = tab_wid + spacer_x
elseif tab_pos == 6 then 
directx.draw_rect(menu_x + menu_w + spacer_x,menu_y,tab_wid,tab_h*tab_cnt,clr)
addr_offs_r = tab_wid + spacer_x
end
end
if menu.get_value(addr_ref) then
local addr_x = menu_x - addr_offs_l
local addr_y = menu_y - addr_offs - spacer_y - addr_h
local addr_w = menu_w + addr_offs_l + addr_offs_r
local addr_h_pix = addr_h*1080
for i=0,addr_h_pix-1 do
local pct = i/addr_h_pix
pct = pct*0.8+0.2
pct = pct*clr.a*0.7
directx.draw_rect(addr_x, addr_y + i/1080,addr_w,1/1080,
bg_clr.r*(1-pct) + clr.r*pct,
bg_clr.g*(1-pct) + clr.g*pct,
bg_clr.b*(1-pct) + clr.b*pct,1)
end
end
return true
end)