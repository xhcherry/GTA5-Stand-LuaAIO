local base64_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
util.keep_running()

function decode(encoded_str)
  local function charToBinary(char)
      if char == "=" then
          return ""
      end
      local charIndex = string.find(base64_chars, char) - 1
      local binary = ""
      for i = 5, 0, -1 do
          binary = binary .. (charIndex >= 2^i and "1" or "0")
          charIndex = charIndex % 2^i
      end
      return binary
  end

  local function binaryToChar(binaryString)
      if #binaryString ~= 8 then
          return ""
      end
      local charCode = 0
      for i = 1, 8 do
          charCode = charCode * 2 + (binaryString:sub(i,i) == "1" and 1 or 0)
      end
      return string.char(charCode)
  end

  local binaryString = encoded_str:sub(2):gsub("[^" .. base64_chars .. "=]", ""):gsub(".", charToBinary)
  local decodedString = binaryString:gsub("%d%d%d?%d?%d?%d?%d?%d?", binaryToChar)

  return decodedString
end

if not async_http.have_access() then
  local errorMessage = decode("a6K+35Li6THVh5ZCv55So5LqS6IGU572R6K6/6Zeu")
  util.log(errorMessage)
  util.toast(errorMessage)
  util.stop_script()
end
util.yield(50)
lua_daidai = filesystem.scripts_dir() .. "lib/SakuraScript/main.lua"
lua_MainLib = filesystem.scripts_dir() .. "lib/SakuraScript/MainLib.lua"
lua_tables = filesystem.scripts_dir() .. "lib/SakuraScript/tables.lua"

function read_file(file_path)
  local file = io.open(file_path, "r")
  local content = file:read("*all")
  file:close()
  return content
end

function load_code(file_path)
  local encoded_content = read_file(file_path)
  local decoded_content = decode(encoded_content)
  
  local temp_file = filesystem.scripts_dir() .. "lib/SakuraScript/load.bin"
  local file = io.open(temp_file, "w")
  file:write(decoded_content)
  file:close()
  
  local success, error = loadfile(temp_file)
  if success then
      success()
  else
      util.stop_script()
  end
  
  os.remove(temp_file)
end

load_code(lua_daidai)
