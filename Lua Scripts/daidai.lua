local Y0_1, L1_1, L2_1, L3_1
Y0_1 = util
Y0_1 = Y0_1.keep_running
Y0_1()
Y0_1 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = string
  L1_2 = L1_2.gsub
  L2_2 = A0_2
  L3_2 = "[^"
  L4_2 = Y0_1
  L5_2 = "=]"
  L3_2 = L3_2 .. L4_2 .. L5_2
  L4_2 = ""
  L1_2 = L1_2(L2_2, L3_2, L4_2)
  A0_2 = L1_2
  L2_2 = A0_2
  L1_2 = A0_2.gsub
  L3_2 = "."
  function L4_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
    if "=" == A0_3 then
      L1_3 = ""
      return L1_3
    end
    L1_3 = ""
    L2_3 = Y0_1
    L3_3 = L2_3
    L2_3 = L2_3.find
    L4_3 = A0_3
    L2_3 = L2_3(L3_3, L4_3)
    L2_3 = L2_3 - 1
    L3_3 = 6
    L4_3 = 1
    L5_3 = -1
    for L6_3 = L3_3, L4_3, L5_3 do
      L7_3 = L1_3
      L8_3 = 2
      L8_3 = L8_3 ^ L6_3
      L8_3 = L2_3 % L8_3
      L9_3 = L6_3 - 1
      L10_3 = 2
      L9_3 = L10_3 ^ L9_3
      L9_3 = L2_3 % L9_3
      L8_3 = L8_3 - L9_3
      if L8_3 > 0 then
        L8_3 = "1"
        if L8_3 then
          goto lbl_37
        end
      end
      L8_3 = "0"
      ::lbl_37::
      L7_3 = L7_3 .. L8_3
      L1_3 = L7_3
    end
    return L1_3
  end
  L1_2 = L1_2(L2_2, L3_2, L4_2)
  L2_2 = L1_2
  L1_2 = L1_2.gsub
  L3_2 = "%d%d%d?%d?%d?%d?%d?%d?"
  function L4_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3
    L1_3 = #A0_3
    if 8 ~= L1_3 then
      L1_3 = ""
      return L1_3
    end
    L1_3 = 0
    L2_3 = 1
    L3_3 = 8
    L4_3 = 1
    for L5_3 = L2_3, L3_3, L4_3 do
      L7_3 = A0_3
      L6_3 = A0_3.sub
      L8_3 = L5_3
      L9_3 = L5_3
      L6_3 = L6_3(L7_3, L8_3, L9_3)
      if "1" == L6_3 then
        L6_3 = 8
        L6_3 = L6_3 - L5_3
        L7_3 = 2
        L6_3 = L7_3 ^ L6_3
        if L6_3 then
          goto lbl_26
        end
      end
      L6_3 = 0
      ::lbl_26::
      L1_3 = L1_3 + L6_3
    end
    L2_3 = string
    L2_3 = L2_3.char
    L3_3 = L1_3
    return L2_3(L3_3)
  end
  L1_2 = L1_2(L2_2, L3_2, L4_2)
  return L1_2
end
dec = L1_1
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = io
  L1_2 = L1_2.open
  L2_2 = A0_2
  L3_2 = "r"
  L1_2 = L1_2(L2_2, L3_2)
  L3_2 = L1_2
  L2_2 = L1_2.read
  L4_2 = "*all"
  L2_2 = L2_2(L3_2, L4_2)
  L4_2 = L1_2
  L3_2 = L1_2.close
  L3_2(L4_2)
  return L2_2
end
read_file = L1_1
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = read_file
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = dec
  L3_2 = L1_2
  L2_2 = L2_2(L3_2)
  L3_2 = load
  L4_2 = L2_2
  L3_2, L4_2 = L3_2(L4_2)
  if L3_2 then
    L5_2 = L3_2
    L5_2()
  else
    L5_2 = util
    L5_2 = L5_2.stop_script
    L5_2()
  end
end
load_code = L1_1
L1_1 = async_http
L1_1 = L1_1.have_access
L1_1 = L1_1()
if not L1_1 then
  L1_1 = util
  L1_1 = L1_1.log
  L2_1 = "请为Lua启用互联网访问"
  L1_1(L2_1)
  L1_1 = util
  L1_1 = L1_1.toast
  L2_1 = "请为Lua启用互联网访问"
  L1_1(L2_1)
  L1_1 = util
  L1_1 = L1_1.stop_script
  L1_1()
end
L1_1 = menu
L1_1 = L1_1.divider
L2_1 = menu
L2_1 = L2_1.my_root
L2_1 = L2_1()
L3_1 = "加载中~"
L1_1 = L1_1(L2_1, L3_1)
L2_1 = util
L2_1 = L2_1.yield
L3_1 = 50
L2_1(L3_1)
L2_1 = filesystem
L2_1 = L2_1.scripts_dir
L2_1 = L2_1()
L3_1 = "lib/SakuraScript/main.lua"
L2_1 = L2_1 .. L3_1
lua_daidai = L2_1
L2_1 = filesystem
L2_1 = L2_1.scripts_dir
L2_1 = L2_1()
L3_1 = "lib/SakuraScript/MainLib.lua"
L2_1 = L2_1 .. L3_1
lua_MainLib = L2_1
L2_1 = filesystem
L2_1 = L2_1.scripts_dir
L2_1 = L2_1()
L3_1 = "lib/SakuraScript/tables.lua"
L2_1 = L2_1 .. L3_1
lua_tables = L2_1
L2_1 = menu
L2_1 = L2_1.delete
L3_1 = L1_1
L2_1(L3_1)
L2_1 = load_code
L3_1 = lua_daidai
L2_1(L3_1)
