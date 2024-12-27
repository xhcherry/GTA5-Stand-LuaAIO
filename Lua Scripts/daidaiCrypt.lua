local function decryptFile(lua)
				local file = io.open(filesystem.scripts_dir() .. "lib\\SakuraScript\\" .. lua .. ".lua", "r")
				local data = file:read("*a")
				file:close()
				
				data = string.gsub(data, ".", function(c)
								return string.char(string.byte(c) - 3)
				end)
				
				file = io.open(filesystem.scripts_dir() .. "lib\\SakuraScript\\" .. lua .. "-dec.lua", "w")
				file:write(data)
				file:close()
end

local function encryptFile(lua)
				local file = io.open(filesystem.scripts_dir() .. "lib\\SakuraScript\\" .. lua .. "-dec.lua", "r")
				local data = file:read("*a")
				file:close()
				
				data = string.gsub(data, ".", function(c)
								return string.char(string.byte(c) + 3)
				end)
				
				file = io.open(filesystem.scripts_dir() .. "lib\\SakuraScript\\" .. lua .. ".lua", "w")
				file:write(data)
				file:close()
end

menu.my_root():action("Decrypt", {}, "", function()
				decryptFile("MainLib")
				decryptFile("tables")
				util.toast("Done")
end)

menu.my_root():action("Encrypt", {}, "", function()
				encryptFile("MainLib")
				encryptFile("tables")
				util.toast("Done")
end)