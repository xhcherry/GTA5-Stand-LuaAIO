local Y0_1, L1_1, L2_1, L3_1, L4_1, L5_1
Y0_1 = util
Y0_1 = Y0_1.keep_running
Y0_1()
Y0_1 = ".,?!;:-_=*&$@|`"
L1_1 = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L1_2 = {}
  L2_2 = 1
  L3_2 = #A0_2
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = 1
    L7_2 = Y0_1
    L7_2 = #L7_2
    L8_2 = 1
    for L9_2 = L6_2, L7_2, L8_2 do
      L10_2 = string
      L10_2 = L10_2.gsub
      L11_2 = A0_2[L5_2]
      L12_2 = Y0_1
      L12_2 = L12_2[L9_2]
      L13_2 = ""
      L10_2 = L10_2(L11_2, L12_2, L13_2)
      L1_2[L5_2] = L10_2
    end
  end
  L2_2 = table
  L2_2 = L2_2.concat
  L3_2 = L1_2
  return L2_2(L3_2)
end
remove_random_chars = L2_1
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = string
  L1_2 = L1_2.gsub
  L2_2 = A0_2
  L3_2 = "[^"
  L4_2 = L1_1
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
    L2_3 = L1_1
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
  L2_2 = remove_random_chars
  L3_2 = L1_2
  return L2_2(L3_2)
end
dec = L2_1
function L2_1(A0_2)
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
read_file = L2_1
function L2_1(A0_2)
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
load_code = L2_1
L2_1 = async_http
L2_1 = L2_1.have_access
L2_1 = L2_1()
if not L2_1 then
  L2_1 = dec
  L3_1 = "6K=`,.*,&+35Li6THVh5$|,:,.ZCv|=@*|.:.??55So5LqS6IGU57_2?&!`,,,:=*,R6,_;:!$K6/6Zeu"
  L2_1 = L2_1(L3_1)
  L3_1 = util
  L3_1 = L3_1.log
  L4_1 = L2_1
  L3_1(L4_1)
  L3_1 = util
  L3_1 = L3_1.toast
  L4_1 = L2_1
  L3_1(L4_1)
  L3_1 = util
  L3_1 = L3_1.stop_script
  L3_1()
end
L2_1 = menu
L2_1 = L2_1.divider
L3_1 = menu
L3_1 = L3_1.my_root
L3_1 = L3_1()
L4_1 = dec
L5_1 = "5Y-qg@6L=!!!;;._@|295-;;!Li&$@&!*tfg=="
L4_1, L5_1 = L4_1(L5_1)
L2_1 = L2_1(L3_1, L4_1, L5_1)
L3_1 = util
L3_1 = L3_1.yield
L4_1 = 50
L3_1(L4_1)
L3_1 = filesystem
L3_1 = L3_1.scripts_dir
L3_1 = L3_1()
L4_1 = "lib/SakuraScript/main.lua"
L3_1 = L3_1 .. L4_1
lua_daidai = L3_1
L3_1 = filesystem
L3_1 = L3_1.scripts_dir
L3_1 = L3_1()
L4_1 = "lib/SakuraScript/MainLib.lua"
L3_1 = L3_1 .. L4_1
lua_MainLib = L3_1
L3_1 = filesystem
L3_1 = L3_1.scripts_dir
L3_1 = L3_1()
L4_1 = "lib/SakuraScript/tables.lua"
L3_1 = L3_1 .. L4_1
lua_tables = L3_1
L3_1 = menu
L3_1 = L3_1.delete
L4_1 = L2_1
L3_1(L4_1)
L3_1 = load_code
L4_1 = lua_daidai
L3_1(L4_1)
