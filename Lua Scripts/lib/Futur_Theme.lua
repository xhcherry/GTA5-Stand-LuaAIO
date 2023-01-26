--Futurist theme for Stand menu by CocoW#6969 V0.1 

local main_file = "main.png" 
local tp_circ_file = "top_circle.png" 
local bt_circ_file = "btbar_circle.png" 

require("natives-1606100775")

local main_tex = directx.create_texture(filesystem.scripts_dir() .. main_file) 
local tp_circ_tex = directx.create_texture(filesystem.scripts_dir() .. tp_circ_file) 
local bt_circ_tex = directx.create_texture(filesystem.scripts_dir() .. bt_circ_file)


--Default status bar text color
local bt_txt_colours = {
			["r"] = 0.0,
			["g"] = 0.0,
			["b"] = 0.0,
			["a"] = 1.0
		}

--Default rotation
local rotation = 0.0
local intensity = 0.01

GenerateFeatures = function() 
menu.slider(menu.my_root(), "Circles speed", {"cspd"}, "", 1, 10, 1, 1, function(speed)
	intensity=speed/100
end)
end

GenerateFeatures()


while true do 
	if menu.is_open() then ---------------------------------THEME----------------------------------------
		 
		rotation = rotation+intensity --rotate the circle
		local x = menu.get_x()/1920
		local y = menu.get_y()/1080
		
		directx.draw_texture(				---- top circle
		tp_circ_tex,			-- id
		0.1,				-- sizeX
		0.1,				-- sizeY
		0.5,				-- centerX
		0.5,				-- centerY
		x+0.122,				-- posX 
		y-0.02,				-- posY 
		rotation,				-- rotation
		{					-- colour
			["r"] = 1.0,
			["g"] = 1.0,
			["b"] = 1.0,
			["a"] = 1.0
		}
	)	

		directx.draw_texture(				---- main bg
		main_tex,			-- id
		0.11,				-- sizeX
		0.11,				-- sizeY
		0.0,				-- centerX
		0.0,				-- centerY
		x-0.005,				-- posX
		y-0.175,				-- posY 
		0.0,				-- rotation
		{					-- colour
			["r"] = 1.0,
			["g"] = 1.0,
			["b"] = 1.0,
			["a"] = 1.0
		}
	)
		directx.draw_texture(				---- small round bt
		bt_circ_tex,			-- id
		0.015,				-- sizeX
		0.015,				-- sizeY
		0.5,				-- centerX
		0.5,				-- centerY
		x+0.194,				-- posX
		y+0.392,				-- posY 
		-rotation,				-- rotation
		{					-- colour
			["r"] = 1.0,
			["g"] = 1.0,
			["b"] = 1.0,
			["a"] = 1.0
		}
	)
		
		
		
		
	
	end

		util.yield() 
	end

while true do  
	util.yield()
end


