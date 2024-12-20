resources_dir = filesystem.scripts_dir() .. '\\GTLuaScript\\'.. '\\nfs\\'
local sp_bg_tex_name = "nfs_spc2.png" 
local sp_pin_tex_name = "nfs_pin_spc2.png" 
local sp_bg_tex = directx.create_texture(resources_dir..sp_bg_tex_name) 
local sp_pin_tex = directx.create_texture(resources_dir..sp_pin_tex_name) 

--Default color background
sp_colour = {				
			["r"] = 0.9,
			["g"] = 0.9,
			["b"] = 0.9,
			["a"] = 1.0
		}
--Default text color
local txt_colour = {				
			["r"] = 1.0,
			["g"] = 1.0,
			["b"] = 1.0,
			["a"] = 0.0
		}


--default speedometer pos
local sp_posX = 0.86
local sp_posY = 0.86

GenerateFeatures = function()

menu.toggle(nfs_cs,"NFS版速度表", {"nfssp"}, "开启之后需要在车内方可显示，下车建议关闭",function(pog)	
	if pog then
		local sp_bg_tex_name = "nfs_spc.png"
		local sp_pin_tex_name = "nfs_pin_spc.png"
		local sp_bg_tex = directx.create_texture(resources_dir..sp_bg_tex_name) 
		local sp_pin_tex = directx.create_texture(resources_dir..sp_pin_tex_name)
		local txt_colour = {["r"] = 1.0,["g"] = 1.0,["b"] = 1.0,["a"] = 1.0}
		local sp_colour = {["r"] = 0.9,["g"] = 0.9,["b"] = 0.9,["a"] = 1.0}
	else
		local sp_bg_tex_name = "nfs_spc2.png"
		local sp_pin_tex_name = "nfs_pin_spc2.png"
		local sp_bg_tex = directx.create_texture(resources_dir..sp_bg_tex_name) 
		local sp_pin_tex = directx.create_texture(resources_dir..sp_pin_tex_name)
		local txt_colour = {["r"] = 0.0,["g"] = 0.0,["b"] = 0.0,["a"] = 0.0}
		local sp_colour = {["r"] = 1.0,["g"] = 0.0,["b"] = 1.0,["a"] = 0.0}
	end
	local sp_bg_tex = directx.create_texture(resources_dir..sp_bg_tex_name) 
	local sp_pin_tex = directx.create_texture(resources_dir..sp_pin_tex_name)
end, false)

menu.toggle(nfs_cs,"标准样式速度表显示", {"standardsp"}, "开启之后需要在车内方可显示，下车建议关闭",function(pog)	
	if pog then
		sp_bg_tex_name = "nfs_spc3.png"
		sp_pin_tex_name = "nfs_pin_spc3.png"
		sp_bg_tex = directx.create_texture(resources_dir..sp_bg_tex_name) 
		sp_pin_tex = directx.create_texture(resources_dir..sp_pin_tex_name)
		txt_colour = {["r"] = 0.0,["g"] = 0.0,["b"] = 0.0,["a"] = 1.0}
		sp_colour = {["r"] = 0.31,["g"] = 0.70,["b"] = 0.89,["a"] = 1.0}
	else
		sp_bg_tex_name = "nfs_spc2.png"
		sp_pin_tex_name = "nfs_pin_spc2.png"
		sp_bg_tex = directx.create_texture(resources_dir..sp_bg_tex_name) 
		sp_pin_tex = directx.create_texture(resources_dir..sp_pin_tex_name)
		txt_colour = {["r"] = 0.0,["g"] = 0.0,["b"] = 0.0,["a"] = 0.0}
		sp_colour = {["r"] = 1.0,["g"] = 0.0,["b"] = 1.0,["a"] = 0.0}
	end
	local sp_bg_tex = directx.create_texture(resources_dir..sp_bg_tex_name) 
	local sp_pin_tex = directx.create_texture(resources_dir..sp_pin_tex_name)
end, false)

menu.toggle(nfs_cs, '漂移模式速度表', {}, '堪称完美的显示模式,车速表里的Pro Max.\n如果你仅需要调整NFS版的转速表,请转到漂移模式转速表设置', function (on)
	if on then 
	 menu.trigger_commands("standardsp")
	 menu.trigger_commands("icluster")
	 else
		menu.trigger_commands("standardsp")
		menu.trigger_commands("icluster")
	 end
 end)

menu.rainbow(menu.colour(nfs_cs, "更改车速表强调颜色", {"spcolor"}, "您需要手动将饱和度调为0以上的数值", sp_colour, true, function(colour)
	sp_colour = colour
end))
menu.colour(nfs_cs, "更改车速表文本颜色", {"sptxtcolor"}, "", txt_colour, true, function(colour)
	txt_colour = colour
end)
menu.slider(nfs_cs, "X 位置", {"spX"}, "", 1, 1000, 860, 1, function(x)
	sp_posX=x/1000
end)
menu.slider(nfs_cs, "Y 位置", {"spY"}, "", 1, 1000, 860, 1, function(y)
	sp_posY=y/1000
end)
menu.action(nfs_cs,"默认车速表位置", {"defsp"}, "",function()
	sp_posX = 0.86
	sp_posY = 0.86
end)
end

GenerateFeatures()

while true do 
		if spo then
			--no speedometer
		else
		local veh = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
		
		if veh > 0 then
		
		local speed = ENTITY.GET_ENTITY_SPEED(veh);
		local kmh = math.floor((speed * 3.6));
		local rotation = 0.0
		
		if kmh <= 240 and rotation <= 0.75 then
			rotation = kmh/320
		end
		
		directx.draw_texture(		-- speedometer bg texture
		sp_bg_tex,				-- id
		0.060,				-- sizeX
		0.068,				-- sizeY
		0.5,				-- centerX
		0.5,				-- centerY
		sp_posX,				-- posX 
		sp_posY,		 		-- posY 
		0.0,				-- rotation
		sp_colour			--colour
	)
		directx.draw_texture(		-- speedometer pin texture
		sp_pin_tex,				-- id
		0.060,				-- sizeX
		0.066,				-- sizeY
		0.5,				-- centerX
		0.5,				-- centerY
		sp_posX,				-- posX  
		sp_posY,		 		-- posY 
		rotation,			-- rotation
		sp_colour 			--colour
	)
		directx.draw_text(	-- small text top
		sp_posX-0.018,				-- x 
		sp_posY+0.060,				-- y 
		kmh .." KM/H",		-- text
		ALIGN_TOP_LEFT,		-- alignment
		0.6,				-- scale
		txt_colour,		-- colour
		false				
	)	
	else 
		--no veh no speedo
	end
		end	
		util.yield() 
	end			



	