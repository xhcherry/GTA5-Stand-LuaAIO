local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1, L49_1, L50_1, L51_1, L52_1, L53_1, L54_1, L55_1, L56_1, L57_1, L58_1, L59_1, L60_1, L61_1, L62_1, L63_1, L64_1, L65_1, L66_1, L67_1, L68_1, L69_1, L70_1, L71_1, L72_1, L73_1, L74_1, L75_1, L76_1, L77_1, L78_1, L79_1, L80_1, L81_1
L0_1 = require
L1_1 = "lib.daidailib.Config.Config"
L0_1(L1_1)
L0_1 = require
L1_1 = "lib.daidailib.Main.json"
L0_1 = L0_1(L1_1)
json = L0_1
L0_1 = require
L1_1 = "lib.daidailib.Main.pretty.json"
L0_1 = L0_1(L1_1)
json1 = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = filesystem
  L1_2 = L1_2.stand_dir
  L1_2 = L1_2()
  L2_2 = "Sakura.log"
  L1_2 = L1_2 .. L2_2
  L2_2 = io
  L2_2 = L2_2.open
  L3_2 = L1_2
  L4_2 = "a+"
  L2_2 = L2_2(L3_2, L4_2)
  L4_2 = L2_2
  L3_2 = L2_2.write
  L5_2 = os
  L5_2 = L5_2.date
  L6_2 = "[%Y-%m-%d %H:%M:%S]"
  L5_2 = L5_2(L6_2)
  L6_2 = " "
  L7_2 = A0_2
  L8_2 = "\n"
  L5_2 = L5_2 .. L6_2 .. L7_2 .. L8_2
  L3_2(L4_2, L5_2)
  L4_2 = L2_2
  L3_2 = L2_2.close
  L3_2(L4_2)
end
LOG = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = LOG
  L2_2 = "|ERROR| "
  L3_2 = A0_2
  L2_2 = L2_2 .. L3_2
  L1_2(L2_2)
  L1_2 = util
  L1_2 = L1_2.toast
  L2_2 = "|ERROR| "
  L3_2 = "\n"
  L4_2 = A0_2
  L2_2 = L2_2 .. L3_2 .. L4_2
  L1_2(L2_2)
  L1_2 = util
  L1_2 = L1_2.stop_script
  L1_2()
end
ERROR_LOG = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = soup
  L1_2 = L1_2.FileReader
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = soup
  L2_2 = L2_2.audWav
  L3_2 = L1_2
  L2_2 = L2_2(L3_2)
  L3_2 = soup
  L3_2 = L3_2.audDevice
  L3_2 = L3_2.getDefault
  L3_2 = L3_2()
  L5_2 = L3_2
  L4_2 = L3_2.getName
  L4_2 = L4_2(L5_2)
  L6_2 = L3_2
  L5_2 = L3_2.open
  L7_2 = L2_2.channels
  L5_2 = L5_2(L6_2, L7_2)
  L6_2 = soup
  L6_2 = L6_2.audMixer
  L6_2 = L6_2()
  L6_2.stop_playback_when_done = false
  L8_2 = L6_2
  L7_2 = L6_2.setOutput
  L9_2 = L5_2
  L7_2(L8_2, L9_2)
  L8_2 = L6_2
  L7_2 = L6_2.playSound
  L9_2 = L2_2
  L7_2(L8_2, L9_2)
  while true do
    L8_2 = L5_2
    L7_2 = L5_2.isPlaying
    L7_2 = L7_2(L8_2)
    if not L7_2 then
      break
    end
    L7_2 = util
    L7_2 = L7_2.yield
    L8_2 = 10
    L7_2(L8_2)
  end
end
PlaySound = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = util
  L1_2 = L1_2.spoof_script
  L2_2 = "main_persistent"
  function L3_2()
    local L0_3, L1_3, L2_3
    L0_3 = GRAPHICS
    L0_3 = L0_3.REQUEST_STREAMED_TEXTURE_DICT
    L1_3 = A0_2
    L2_3 = false
    L0_3(L1_3, L2_3)
  end
  L1_2(L2_2, L3_2)
end
request_streamed_texture = L0_1
L0_1 = filesystem
L0_1 = L0_1.exists
L1_1 = filesystem
L1_1 = L1_1.resources_dir
L1_1 = L1_1()
L2_1 = "/SakuraImg/Textures.ytd"
L1_1 = L1_1 .. L2_1
L0_1 = L0_1(L1_1)
if L0_1 then
  L0_1 = util
  L0_1 = L0_1.register_file
  L1_1 = filesystem
  L1_1 = L1_1.resources_dir
  L1_1 = L1_1()
  L2_1 = "/SakuraImg/Textures.ytd"
  L1_1 = L1_1 .. L2_1
  L0_1(L1_1)
  L0_1 = request_streamed_texture
  L1_1 = "Textures"
  L0_1(L1_1)
else
  L0_1 = ERROR_LOG
  L1_1 = "未找到所需文件: Textures.ytd"
  L0_1(L1_1)
end
function L0_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L3_2 = A2_2 or nil
  if not A2_2 then
    L3_2 = "通知"
  end
  L4_2 = string
  L4_2 = L4_2.format
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  L5_2 = HUD
  L6_2 = "THEFEED_SET_BACKGROUND_COLOR_FOR_NEXT_POST"
  L5_2 = L5_2[L6_2]
  L6_2 = A1_2 or L6_2
  if not A1_2 then
    L6_2 = HudColour
    L6_2 = L6_2.blue
  end
  L5_2(L6_2)
  L5_2 = util
  L5_2 = L5_2.BEGIN_TEXT_COMMAND_THEFEED_POST
  L6_2 = L4_2
  L5_2(L6_2)
  L5_2 = HUD
  L6_2 = "END_TEXT_COMMAND_THEFEED_POST_MESSAGETEXT"
  L5_2 = L5_2[L6_2]
  L6_2 = "Textures"
  L7_2 = "logo"
  L8_2 = true
  L9_2 = 4
  L10_2 = "Sakura"
  L11_2 = "~b~"
  L12_2 = L3_2
  L11_2 = L11_2 .. L12_2
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L5_2 = HUD
  L5_2 = L5_2.END_TEXT_COMMAND_THEFEED_POST_TICKER
  L6_2 = false
  L7_2 = false
  L5_2(L6_2, L7_2)
end
notification = L0_1
function L0_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = {}
  L1_2 = util
  L1_2 = L1_2.current_time_millis
  L1_2 = L1_2()
  L0_2.start = L1_2
  function L1_2()
    local L0_3, L1_3
    L0_3 = util
    L0_3 = L0_3.current_time_millis
    L0_3 = L0_3()
    L0_2.start = L0_3
  end
  function L2_2()
    local L0_3, L1_3
    L0_3 = util
    L0_3 = L0_3.current_time_millis
    L0_3 = L0_3()
    L1_3 = L0_2.start
    L0_3 = L0_3 - L1_3
    return L0_3
  end
  L3_2 = {}
  L3_2.reset = L1_2
  L3_2.elapsed = L2_2
  return L3_2
end
newTimer = L0_1
L0_1 = newTimer
L0_1 = L0_1()
timer = L0_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = setmetatable
  L3_2 = {}
  L4_2 = Sound
  L2_2 = L2_2(L3_2, L4_2)
  L2_2.name = A0_2
  L2_2.reference = A1_2
  return L2_2
end
Sound_new = L0_1
L0_1 = {}
new = L0_1
function L0_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2
  L4_2 = {}
  L5_2 = A0_2 / 255
  L4_2.r = L5_2
  L5_2 = A1_2 / 255
  L4_2.g = L5_2
  L5_2 = A2_2 / 255
  L4_2.b = L5_2
  L4_2.a = A3_2
  return L4_2
end
new_colour = L0_1
L0_1 = new
function L1_1(A0_2, A1_2, A2_2)
  local L3_2
  L3_2 = {}
  L3_2.ms = A0_2
  L3_2.s = A1_2
  L3_2.min = A2_2
  return L3_2
end
L0_1.delay = L1_1
L0_1 = {}
L0_1.asset = ""
L0_1.name = ""
L0_1.scale = 1.0
Effect = L0_1
L0_1 = Effect
L1_1 = Effect
L0_1.__index = L1_1
L0_1 = Effect
function L1_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2
  L3_2 = setmetatable
  L4_2 = {}
  L5_2 = Effect
  L3_2 = L3_2(L4_2, L5_2)
  L3_2.name = A1_2
  L3_2.asset = A0_2
  L3_2.scale = A2_2
  return L3_2
end
L0_1.new = L1_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = os
  L2_2 = L2_2.time
  L2_2 = L2_2()
  L3_2 = A1_2 or L3_2
  if not A1_2 then
    L3_2 = 3
  end
  L2_2 = L2_2 + L3_2
  L3_2 = STREAMING
  L3_2 = L3_2.REQUEST_MODEL
  L4_2 = A0_2
  L3_2(L4_2)
  while true do
    L3_2 = STREAMING
    L3_2 = L3_2.HAS_MODEL_LOADED
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    if L3_2 then
      break
    end
    L3_2 = os
    L3_2 = L3_2.time
    L3_2 = L3_2()
    if not (L2_2 >= L3_2) then
      break
    end
    L3_2 = STREAMING
    L3_2 = L3_2.REQUEST_MODEL
    L4_2 = A0_2
    L3_2(L4_2)
    L3_2 = util
    L3_2 = L3_2.yield
    L3_2()
  end
  L3_2 = STREAMING
  L3_2 = L3_2.HAS_MODEL_LOADED
  L4_2 = A0_2
  return L3_2(L4_2)
end
request_model = L0_1
function L0_1(...)
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = {}
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = ...
  L0_2[1] = L1_2
  L0_2[2] = L2_2
  L0_2[3] = L3_2
  L0_2[4] = L4_2
  L0_2[5] = L5_2
  L0_2[6] = L6_2
  L0_2[7] = L7_2
  L0_2[8] = L8_2
  L0_2[9] = L9_2
  L1_2 = ipairs
  L2_2 = L0_2
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = os
    L7_2 = L7_2.time
    L7_2 = L7_2()
    L7_2 = L7_2 + 3
    L8_2 = STREAMING
    L8_2 = L8_2.REQUEST_MODEL
    L9_2 = L6_2
    L8_2(L9_2)
    while true do
      L8_2 = STREAMING
      L8_2 = L8_2.HAS_MODEL_LOADED
      L9_2 = L6_2
      L8_2 = L8_2(L9_2)
      if L8_2 then
        break
      end
      L8_2 = os
      L8_2 = L8_2.time
      L8_2 = L8_2()
      if not (L7_2 >= L8_2) then
        break
      end
      L8_2 = STREAMING
      L8_2 = L8_2.REQUEST_MODEL
      L9_2 = L6_2
      L8_2(L9_2)
      L8_2 = util
      L8_2 = L8_2.yield
      L8_2()
    end
  end
end
request_models = L0_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = os
  L2_2 = L2_2.time
  L2_2 = L2_2()
  L3_2 = A1_2 or L3_2
  if not A1_2 then
    L3_2 = 3
  end
  L2_2 = L2_2 + L3_2
  L3_2 = STREAMING
  L3_2 = L3_2.REQUEST_NAMED_PTFX_ASSET
  L4_2 = A0_2
  L3_2(L4_2)
  while true do
    L3_2 = STREAMING
    L3_2 = L3_2.HAS_NAMED_PTFX_ASSET_LOADED
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    if L3_2 then
      break
    end
    L3_2 = os
    L3_2 = L3_2.time
    L3_2 = L3_2()
    if not (L2_2 >= L3_2) then
      break
    end
    L3_2 = STREAMING
    L3_2 = L3_2.REQUEST_NAMED_PTFX_ASSET
    L4_2 = A0_2
    L3_2(L4_2)
    L3_2 = util
    L3_2 = L3_2.yield
    L3_2()
  end
  L3_2 = GRAPHICS
  L3_2 = L3_2.USE_PARTICLE_FX_ASSET
  L4_2 = A0_2
  L3_2(L4_2)
end
request_ptfx_asset = L0_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = os
  L2_2 = L2_2.time
  L2_2 = L2_2()
  L3_2 = A1_2 or L3_2
  if not A1_2 then
    L3_2 = 3
  end
  L2_2 = L2_2 + L3_2
  L3_2 = GRAPHICS
  L3_2 = L3_2.REQUEST_STREAMED_TEXTURE_DICT
  L4_2 = A0_2
  L5_2 = false
  L3_2(L4_2, L5_2)
  while true do
    L3_2 = GRAPHICS
    L3_2 = L3_2.HAS_STREAMED_TEXTURE_DICT_LOADED
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    if L3_2 then
      break
    end
    L3_2 = os
    L3_2 = L3_2.time
    L3_2 = L3_2()
    if not (L2_2 >= L3_2) then
      break
    end
    L3_2 = GRAPHICS
    L3_2 = L3_2.REQUEST_STREAMED_TEXTURE_DICT
    L4_2 = A0_2
    L5_2 = false
    L3_2(L4_2, L5_2)
    L3_2 = util
    L3_2 = L3_2.yield
    L3_2()
  end
end
request_streamed_texture_dict = L0_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = os
  L2_2 = L2_2.time
  L2_2 = L2_2()
  L3_2 = A1_2 or L3_2
  if not A1_2 then
    L3_2 = 3
  end
  L2_2 = L2_2 + L3_2
  L3_2 = NETWORK
  L3_2 = L3_2.NETWORK_REQUEST_CONTROL_OF_ENTITY
  L4_2 = A0_2
  L3_2(L4_2)
  while true do
    L3_2 = NETWORK
    L3_2 = L3_2.NETWORK_HAS_CONTROL_OF_ENTITY
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    if L3_2 then
      break
    end
    L3_2 = os
    L3_2 = L3_2.time
    L3_2 = L3_2()
    if not (L2_2 >= L3_2) then
      break
    end
    L3_2 = NETWORK
    L3_2 = L3_2.NETWORK_GET_NETWORK_ID_FROM_ENTITY
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    L4_2 = NETWORK
    L4_2 = L4_2.SET_NETWORK_ID_CAN_MIGRATE
    L5_2 = L3_2
    L6_2 = true
    L4_2(L5_2, L6_2)
    L4_2 = NETWORK
    L4_2 = L4_2.NETWORK_REQUEST_CONTROL_OF_ENTITY
    L5_2 = A0_2
    L4_2(L5_2)
    L4_2 = util
    L4_2 = L4_2.yield
    L4_2()
  end
  L3_2 = NETWORK
  L3_2 = L3_2.NETWORK_HAS_CONTROL_OF_ENTITY
  L4_2 = A0_2
  return L3_2(L4_2)
end
request_control = L0_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = os
  L2_2 = L2_2.time
  L2_2 = L2_2()
  L3_2 = A1_2 or L3_2
  if not A1_2 then
    L3_2 = 3
  end
  L2_2 = L2_2 + L3_2
  L3_2 = STREAMING
  L3_2 = L3_2.REQUEST_ANIM_DICT
  L4_2 = A0_2
  L3_2(L4_2)
  while true do
    L3_2 = STREAMING
    L3_2 = L3_2.HAS_ANIM_DICT_LOADED
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    if L3_2 then
      break
    end
    L3_2 = os
    L3_2 = L3_2.time
    L3_2 = L3_2()
    if not (L2_2 >= L3_2) then
      break
    end
    L3_2 = STREAMING
    L3_2 = L3_2.REQUEST_ANIM_DICT
    L4_2 = A0_2
    L3_2(L4_2)
    L3_2 = util
    L3_2 = L3_2.yield
    L3_2()
  end
end
request_anim_dict = L0_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = os
  L2_2 = L2_2.time
  L2_2 = L2_2()
  L3_2 = A1_2 or L3_2
  if not A1_2 then
    L3_2 = 5
  end
  L2_2 = L2_2 + L3_2
  L3_2 = WEAPON
  L3_2 = L3_2.REQUEST_WEAPON_ASSET
  L4_2 = A0_2
  L5_2 = 31
  L6_2 = false
  L3_2(L4_2, L5_2, L6_2)
  while true do
    L3_2 = WEAPON
    L3_2 = L3_2.HAS_WEAPON_ASSET_LOADED
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    if L3_2 then
      break
    end
    L3_2 = os
    L3_2 = L3_2.time
    L3_2 = L3_2()
    if not (L2_2 >= L3_2) then
      break
    end
    L3_2 = WEAPON
    L3_2 = L3_2.REQUEST_WEAPON_ASSET
    L4_2 = A0_2
    L5_2 = 31
    L6_2 = false
    L3_2(L4_2, L5_2, L6_2)
    L3_2 = util
    L3_2 = L3_2.yield
    L3_2()
  end
end
request_weapon_asset = L0_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = os
  L2_2 = L2_2.time
  L2_2 = L2_2()
  L3_2 = A1_2 or L3_2
  if not A1_2 then
    L3_2 = 5
  end
  L2_2 = L2_2 + L3_2
  L3_2 = STREAMING
  L3_2 = L3_2.REQUEST_IPL
  L4_2 = A0_2
  L3_2(L4_2)
  while true do
    L3_2 = STREAMING
    L3_2 = L3_2.IS_IPL_ACTIVE
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    if L3_2 then
      break
    end
    L3_2 = os
    L3_2 = L3_2.time
    L3_2 = L3_2()
    if not (L2_2 >= L3_2) then
      break
    end
    L3_2 = STREAMING
    L3_2 = L3_2.REQUEST_IPL
    L4_2 = A0_2
    L3_2(L4_2)
    L3_2 = util
    L3_2 = L3_2.yield
    L3_2()
  end
end
request_ipl = L0_1
function L0_1(A0_2)
  local L1_2, L2_2
  L1_2 = STREAMING
  L1_2 = L1_2.IS_IPL_ACTIVE
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L1_2 = STREAMING
    L1_2 = L1_2.REMOVE_IPL
    L2_2 = A0_2
    L1_2(L2_2)
  end
end
remove_ipl = L0_1
function L0_1(A0_2, A1_2, A2_2, A3_2, A4_2, A5_2)
  local L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L6_2 = request_model
  L7_2 = A1_2
  L6_2(L7_2)
  L6_2 = PED
  L6_2 = L6_2.CREATE_PED
  L7_2 = A0_2
  L8_2 = A1_2
  L9_2 = 0
  L10_2 = 0
  L11_2 = 0
  L12_2 = A5_2
  L13_2 = true
  L14_2 = false
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  L7_2 = ENTITY
  L7_2 = L7_2.SET_ENTITY_COORDS
  L8_2 = L6_2
  L9_2 = A2_2
  L10_2 = A3_2
  L11_2 = A4_2
  L12_2 = false
  L13_2 = false
  L14_2 = false
  L15_2 = false
  L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  return L6_2
end
create_ped = L0_1
function L0_1(A0_2, A1_2, A2_2, A3_2, A4_2)
  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L5_2 = request_model
  L6_2 = A0_2
  L5_2(L6_2)
  L5_2 = VEHICLE
  L5_2 = L5_2.CREATE_VEHICLE
  L6_2 = A0_2
  L7_2 = 0
  L8_2 = 0
  L9_2 = 0
  L10_2 = A4_2
  L11_2 = true
  L12_2 = true
  L13_2 = true
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L6_2 = ENTITY
  L6_2 = L6_2.SET_ENTITY_COORDS
  L7_2 = L5_2
  L8_2 = A1_2
  L9_2 = A2_2
  L10_2 = A3_2
  L11_2 = false
  L12_2 = false
  L13_2 = false
  L14_2 = false
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  return L5_2
end
create_vehicle = L0_1
function L0_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L4_2 = request_model
  L5_2 = A0_2
  L4_2(L5_2)
  L4_2 = OBJECT
  L4_2 = L4_2.CREATE_OBJECT
  L5_2 = A0_2
  L6_2 = 0
  L7_2 = 0
  L8_2 = 0
  L9_2 = true
  L10_2 = false
  L11_2 = true
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_COORDS
  L6_2 = L4_2
  L7_2 = A1_2
  L8_2 = A2_2
  L9_2 = A3_2
  L10_2 = false
  L11_2 = false
  L12_2 = false
  L13_2 = false
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  return L4_2
end
create_object = L0_1
function L0_1(A0_2, A1_2, A2_2, A3_2, A4_2)
  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L5_2 = request_model
  L6_2 = A4_2
  L5_2(L6_2)
  L5_2 = OBJECT
  L5_2 = L5_2.CREATE_AMBIENT_PICKUP
  L6_2 = A3_2
  L7_2 = A0_2
  L8_2 = A1_2
  L9_2 = A2_2
  L10_2 = 0
  L11_2 = 1
  L12_2 = A4_2
  L13_2 = false
  L14_2 = true
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
end
create_ambient_pickup = L0_1
function L0_1(A0_2)
  local L1_2, L2_2
  L1_2 = ENTITY
  L1_2 = L1_2.DOES_ENTITY_EXIST
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L1_2 = request_control
    L2_2 = A0_2
    L1_2(L2_2)
    L1_2 = entities
    L1_2 = L1_2.delete
    L2_2 = A0_2
    L1_2(L2_2)
  end
end
delete_entity = L0_1
function L0_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2
  L3_2 = io
  L3_2 = L3_2.open
  L4_2 = A0_2
  L5_2 = A1_2
  L3_2 = L3_2(L4_2, L5_2)
  L5_2 = L3_2
  L4_2 = L3_2.write
  L6_2 = A2_2
  L4_2(L5_2, L6_2)
  L5_2 = L3_2
  L4_2 = L3_2.close
  L4_2(L5_2)
end
filewrite = L0_1
function L0_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2
  L3_2 = filesystem
  L3_2 = L3_2.exists
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  if L3_2 then
    L3_2 = io
    L3_2 = L3_2.open
    L4_2 = A0_2
    L5_2 = A1_2
    L3_2 = L3_2(L4_2, L5_2)
    L5_2 = L3_2
    L4_2 = L3_2.read
    L6_2 = A2_2
    L4_2 = L4_2(L5_2, L6_2)
    L6_2 = L3_2
    L5_2 = L3_2.close
    L5_2(L6_2)
    return L4_2
  end
end
fileread = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L1_2 = {}
  L2_2 = ipairs
  L3_2 = filesystem
  L3_2 = L3_2.list_files
  L4_2 = A0_2
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L3_2(L4_2)
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L9_2 = L7_2
    L8_2 = L7_2.sub
    L11_2 = L7_2
    L10_2 = L7_2.rfind
    L12_2 = "\\"
    L10_2 = L10_2(L11_2, L12_2)
    L10_2 = L10_2 + 1
    L12_2 = L7_2
    L11_2 = L7_2.rfind
    L13_2 = "."
    L11_2 = L11_2(L12_2, L13_2)
    L11_2 = L11_2 - 1
    L8_2 = L8_2(L9_2, L10_2, L11_2)
    L10_2 = L7_2
    L9_2 = L7_2.match
    L11_2 = ".+%.(%w+)$"
    L9_2 = L9_2(L10_2, L11_2)
    L10_2 = #L1_2
    L10_2 = L10_2 + 1
    L1_2[L10_2] = L8_2
  end
  L2_2 = #L1_2
  if 0 == L2_2 then
    L2_2 = {}
    L3_2 = ""
    L2_2[1] = L3_2
    L1_2 = L2_2
  end
  return L1_2
end
read_filename = L0_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = request_model
  L3_2 = A1_2
  L2_2(L3_2)
  L2_2 = PLAYER
  L2_2 = L2_2.SET_PLAYER_MODEL
  L3_2 = A0_2
  L4_2 = A1_2
  L2_2(L3_2, L4_2)
  L2_2 = STREAMING
  L2_2 = L2_2.SET_MODEL_AS_NO_LONGER_NEEDED
  L3_2 = A1_2
  L2_2(L3_2)
  L2_2 = give_all_weapon
  L3_2 = A0_2
  L2_2(L3_2)
end
change_model = L0_1
function L0_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2
  L3_2 = PED
  L3_2 = L3_2.SET_PED_COORDS_KEEP_VEHICLE
  L4_2 = PLAYER
  L4_2 = L4_2.PLAYER_PED_ID
  L4_2 = L4_2()
  L5_2 = A0_2
  L6_2 = A1_2
  L7_2 = A2_2
  L3_2(L4_2, L5_2, L6_2, L7_2)
end
teleport = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = ENTITY
  L1_2 = L1_2.IS_ENTITY_A_VEHICLE
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L1_2 = VEHICLE
    L1_2 = L1_2.GET_PED_IN_VEHICLE_SEAT
    L2_2 = A0_2
    L3_2 = -1
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = ENTITY
    L2_2 = L2_2.DOES_ENTITY_EXIST
    L3_2 = L1_2
    L2_2 = L2_2(L3_2)
    if L2_2 then
      L2_2 = PED
      L2_2 = L2_2.IS_PED_A_PLAYER
      L3_2 = L1_2
      L2_2 = L2_2(L3_2)
      if not L2_2 then
        L2_2 = delete_entity
        L3_2 = L1_2
        L2_2(L3_2)
      end
    end
    L2_2 = PED
    L2_2 = L2_2.SET_PED_INTO_VEHICLE
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2 = L3_2()
    L4_2 = A0_2
    L5_2 = -1
    L2_2(L3_2, L4_2, L5_2)
  end
end
drive_vehicle = L0_1
function L0_1()
  local L0_2, L1_2, L2_2
  L0_2 = HUD
  L0_2 = L0_2.HIDE_HUD_COMPONENT_THIS_FRAME
  L1_2 = 6
  L0_2(L1_2)
  L0_2 = HUD
  L0_2 = L0_2.HIDE_HUD_COMPONENT_THIS_FRAME
  L1_2 = 7
  L0_2(L1_2)
  L0_2 = HUD
  L0_2 = L0_2.HIDE_HUD_COMPONENT_THIS_FRAME
  L1_2 = 8
  L0_2(L1_2)
  L0_2 = HUD
  L0_2 = L0_2.HIDE_HUD_COMPONENT_THIS_FRAME
  L1_2 = 9
  L0_2(L1_2)
  L0_2 = memory
  L0_2 = L0_2.write_int
  L1_2 = memory
  L1_2 = L1_2.script_global
  L2_2 = 1646860
  L1_2 = L1_2(L2_2)
  L2_2 = 1
  L0_2(L1_2, L2_2)
  L0_2 = sf
  L0_2 = L0_2.CLEAR_ALL
  L0_2()
  L0_2 = sf
  L0_2 = L0_2.TOGGLE_MOUSE_BUTTONS
  L1_2 = false
  L0_2(L1_2)
  L0_2 = sf
  return L0_2
end
show_button = L0_1
function L0_1()
  local L0_2, L1_2
  L0_2 = sf
  L0_2 = L0_2.DRAW_INSTRUCTIONAL_BUTTONS
  L0_2()
  L0_2 = sf
  L1_2 = L0_2
  L0_2 = L0_2.draw_fullscreen
  L0_2(L1_2)
end
show_button2 = L0_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  if A1_2 then
    L2_2 = ENTITY
    L2_2 = L2_2.SET_ENTITY_ALPHA
    L3_2 = A0_2
    L4_2 = 255
    L5_2 = false
    L2_2(L3_2, L4_2, L5_2)
  else
    L2_2 = ENTITY
    L2_2 = L2_2.SET_ENTITY_ALPHA
    L3_2 = A0_2
    L4_2 = 0
    L5_2 = false
    L2_2(L3_2, L4_2, L5_2)
  end
  L2_2 = ENTITY
  L2_2 = L2_2.SET_ENTITY_VISIBLE
  L3_2 = A0_2
  L4_2 = A1_2
  L5_2 = false
  L2_2(L3_2, L4_2, L5_2)
end
set_entity_full_visible = L0_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = ENTITY
  L2_2 = L2_2.IS_ENTITY_A_PED
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if 0 == L2_2 then
    return
  end
  L2_2 = NETWORK
  L2_2 = L2_2.NETWORK_REQUEST_CONTROL_OF_ENTITY
  L3_2 = A0_2
  L2_2(L3_2)
  L2_2 = PED
  L2_2 = L2_2.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS
  L3_2 = A0_2
  L4_2 = A1_2
  L2_2(L3_2, L4_2)
  L2_2 = PED
  L2_2 = L2_2.SET_PED_FLEE_ATTRIBUTES
  L3_2 = A0_2
  L4_2 = 0
  L5_2 = not A1_2
  L2_2(L3_2, L4_2, L5_2)
  L2_2 = PED
  L2_2 = L2_2.SET_PED_COMBAT_ATTRIBUTES
  L3_2 = A0_2
  L4_2 = 17
  L5_2 = A1_2
  L2_2(L3_2, L4_2, L5_2)
end
calm_ped = L0_1
function L0_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L3_2 = MISC
  L3_2 = L3_2.GET_DISTANCE_BETWEEN_COORDS
  L4_2 = A0_2.x
  L5_2 = A0_2.y
  L6_2 = A0_2.z
  L7_2 = A1_2.x
  L8_2 = A1_2.y
  L9_2 = A1_2.z
  L10_2 = A2_2
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  return L3_2
end
Get_Distance = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = util
  L1_2 = L1_2.get_ground_z
  L2_2 = A0_2.x
  L3_2 = A0_2.y
  L1_2, L2_2 = L1_2(L2_2, L3_2)
  L3_2 = 0
  while not L1_2 and L3_2 <= 100 do
    L4_2 = util
    L4_2 = L4_2.get_ground_z
    L5_2 = A0_2.x
    L6_2 = A0_2.y
    L4_2, L5_2 = L4_2(L5_2, L6_2)
    L2_2 = L5_2
    L1_2 = L4_2
    L3_2 = L3_2 + 1
    L4_2 = util
    L4_2 = L4_2.yield
    L4_2()
  end
  if L1_2 then
    A0_2.z = L2_2
  end
  L4_2 = A0_2.x
  L5_2 = A0_2.y
  L6_2 = L2_2
  return L4_2, L5_2, L6_2
end
waypoint_coord = L0_1
function L0_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L3_2 = ENTITY
  L3_2 = L3_2.GET_ENTITY_COORDS
  L4_2 = A0_2
  L5_2 = false
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = ENTITY
  L4_2 = L4_2.GET_ENTITY_COORDS
  L5_2 = A1_2
  L6_2 = false
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = v3
  L5_2 = L5_2.new
  L6_2 = L4_2
  L5_2 = L5_2(L6_2)
  L7_2 = L5_2
  L6_2 = L5_2.sub
  L8_2 = L3_2
  L6_2(L7_2, L8_2)
  L7_2 = L5_2
  L6_2 = L5_2.toRot
  L6_2 = L6_2(L7_2)
  if not A2_2 then
    L7_2 = ENTITY
    L7_2 = L7_2.SET_ENTITY_HEADING
    L8_2 = A0_2
    L9_2 = L6_2.z
    L7_2(L8_2, L9_2)
  else
    L7_2 = ENTITY
    L7_2 = L7_2.SET_ENTITY_ROTATION
    L8_2 = A0_2
    L9_2 = L6_2.x
    L10_2 = L6_2.y
    L11_2 = L6_2.z
    L12_2 = 2
    L13_2 = 0
    L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  end
end
set_entity_face_entity = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = {}
  L2_2 = {}
  L3_2 = "nil"
  L4_2 = "PED"
  L5_2 = "载具"
  L6_2 = "物体"
  L2_2[1] = L3_2
  L2_2[2] = L4_2
  L2_2[3] = L5_2
  L2_2[4] = L6_2
  L3_2 = ENTITY
  L3_2 = L3_2.DOES_ENTITY_EXIST
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  if L3_2 then
    L3_2 = ENTITY
    L3_2 = L3_2.GET_ENTITY_MODEL
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    L1_2.hash = L3_2
    L3_2 = ENTITY
    L3_2 = L3_2.GET_ENTITY_HEALTH
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    L1_2.health = L3_2
    L3_2 = ENTITY
    L3_2 = L3_2.GET_ENTITY_TYPE
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    L1_2.type = L3_2
    L3_2 = ENTITY
    L3_2 = L3_2.GET_ENTITY_TYPE
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    L3_2 = L3_2 + 1
    L3_2 = L2_2[L3_2]
    L1_2.type_name = L3_2
    L3_2 = math
    L3_2 = L3_2.floor
    L4_2 = ENTITY
    L4_2 = L4_2.GET_ENTITY_SPEED
    L5_2 = A0_2
    L4_2, L5_2, L6_2 = L4_2(L5_2)
    L3_2 = L3_2(L4_2, L5_2, L6_2)
    L1_2.speed = L3_2
    return L1_2
  end
  L3_2 = 0
  return L3_2
end
get_entity_info = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = PLAYER
  L1_2 = L1_2.IS_PLAYER_FREE_AIMING
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if not L1_2 then
    L1_2 = 0
    return L1_2
  end
  L1_2 = memory
  L1_2 = L1_2.alloc_int
  L1_2 = L1_2()
  L2_2 = PLAYER
  L2_2 = L2_2.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT
  L3_2 = A0_2
  L4_2 = L1_2
  L2_2 = L2_2(L3_2, L4_2)
  if L2_2 then
    L2_2 = memory
    L2_2 = L2_2.read_int
    L3_2 = L1_2
    L2_2 = L2_2(L3_2)
    entity = L2_2
  end
  L2_2 = ENTITY
  L2_2 = L2_2.DOES_ENTITY_EXIST
  L3_2 = entity
  L2_2 = L2_2(L3_2)
  if L2_2 then
    L2_2 = ENTITY
    L2_2 = L2_2.IS_ENTITY_A_PED
    L3_2 = entity
    L2_2 = L2_2(L3_2)
    if L2_2 then
      L2_2 = PED
      L2_2 = L2_2.IS_PED_IN_ANY_VEHICLE
      L3_2 = entity
      L4_2 = false
      L2_2 = L2_2(L3_2, L4_2)
      if L2_2 then
        L2_2 = PED
        L2_2 = L2_2.GET_VEHICLE_PED_IS_IN
        L3_2 = entity
        L4_2 = false
        L2_2 = L2_2(L3_2, L4_2)
        entity = L2_2
      end
    end
  end
  L2_2 = entity
  return L2_2
end
get_entity_player_is_aiming_at = L0_1
function L0_1(A0_2, A1_2, A2_2, A3_2, A4_2)
  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L5_2 = HUD
  L5_2 = L5_2.BEGIN_TEXT_COMMAND_DISPLAY_TEXT
  L6_2 = "STRING"
  L5_2(L6_2)
  L5_2 = HUD
  L5_2 = L5_2.SET_TEXT_FONT
  L6_2 = A4_2 or L6_2
  if not A4_2 then
    L6_2 = 1
  end
  L5_2(L6_2)
  L5_2 = HUD
  L5_2 = L5_2.SET_TEXT_SCALE
  L6_2 = A3_2
  L7_2 = A3_2
  L5_2(L6_2, L7_2)
  L5_2 = HUD
  L5_2 = L5_2.SET_TEXT_DROP_SHADOW
  L5_2()
  L5_2 = HUD
  L5_2 = L5_2.SET_TEXT_WRAP
  L6_2 = 0.0
  L7_2 = 1.0
  L5_2(L6_2, L7_2)
  L5_2 = HUD
  L5_2 = L5_2.SET_TEXT_DROPSHADOW
  L6_2 = 1
  L7_2 = 0
  L8_2 = 0
  L9_2 = 0
  L10_2 = 0
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = HUD
  L5_2 = L5_2.SET_TEXT_OUTLINE
  L5_2()
  L5_2 = HUD
  L5_2 = L5_2.SET_TEXT_EDGE
  L6_2 = 1
  L7_2 = 0
  L8_2 = 0
  L9_2 = 0
  L10_2 = 0
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = HUD
  L5_2 = L5_2.ADD_TEXT_COMPONENT_SUBSTRING_PLAYER_NAME
  L6_2 = A0_2
  L5_2(L6_2)
  L5_2 = HUD
  L5_2 = L5_2.END_TEXT_COMMAND_DISPLAY_TEXT
  L6_2 = A1_2
  L7_2 = A2_2
  L5_2(L6_2, L7_2)
end
draw_string = L0_1
function L0_1(A0_2, A1_2, A2_2, A3_2, A4_2, A5_2, A6_2, A7_2)
  local L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2
  L8_2 = PLAYER
  L8_2 = L8_2.PLAYER_PED_ID
  L8_2 = L8_2()
  L9_2 = util
  L9_2 = L9_2.joaat
  L10_2 = A0_2
  L9_2 = L9_2(L10_2)
  A0_2 = L9_2
  L9_2 = STREAMING
  L9_2 = L9_2.REQUEST_MODEL
  L10_2 = A0_2
  L9_2(L10_2)
  while true do
    L9_2 = STREAMING
    L9_2 = L9_2.HAS_MODEL_LOADED
    L10_2 = A0_2
    L9_2 = L9_2(L10_2)
    if L9_2 then
      break
    end
    L9_2 = util
    L9_2 = L9_2.yield
    L9_2()
  end
  L9_2 = STREAMING
  L9_2 = L9_2.SET_MODEL_AS_NO_LONGER_NEEDED
  L10_2 = A0_2
  L9_2(L10_2)
  L9_2 = OBJECT
  L9_2 = L9_2.CREATE_OBJECT
  L10_2 = A0_2
  L11_2 = 0.0
  L12_2 = 0.0
  L13_2 = 0
  L14_2 = true
  L15_2 = true
  L16_2 = false
  L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  L10_2 = ENTITY
  L10_2 = L10_2.ATTACH_ENTITY_TO_ENTITY
  L11_2 = L9_2
  L12_2 = L8_2
  L13_2 = PED
  L13_2 = L13_2.GET_PED_BONE_INDEX
  L14_2 = PLAYER
  L14_2 = L14_2.PLAYER_PED_ID
  L14_2 = L14_2()
  L15_2 = A1_2
  L13_2 = L13_2(L14_2, L15_2)
  L14_2 = A2_2
  L15_2 = A3_2
  L16_2 = A4_2
  L17_2 = A5_2
  L18_2 = A6_2
  L19_2 = A7_2
  L20_2 = false
  L21_2 = false
  L22_2 = false
  L23_2 = false
  L24_2 = 0
  L25_2 = true
  L26_2 = 0
  L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
end
attach_to_player = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = memory
  L1_2 = L1_2.alloc
  L2_2 = 4
  L1_2 = L1_2(L2_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = WATER
  L3_2 = L3_2.GET_WATER_HEIGHT
  L4_2 = L2_2.x
  L5_2 = L2_2.y
  L6_2 = L2_2.z
  L7_2 = L1_2
  return L3_2(L4_2, L5_2, L6_2, L7_2)
end
is_entity_on_water = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L1_2 = {}
  L2_2 = "MP_CHAR_STAT_RALLY_ANIM"
  L3_2 = "MP_CHAR_ARMOUR_1_COUNT"
  L4_2 = "MP_CHAR_ARMOUR_2_COUNT"
  L5_2 = "MP_CHAR_ARMOUR_3_COUNT"
  L6_2 = "MP_CHAR_ARMOUR_4_COUNT"
  L7_2 = "MP_CHAR_ARMOUR_5_COUNT"
  L1_2[1] = L2_2
  L1_2[2] = L3_2
  L1_2[3] = L4_2
  L1_2[4] = L5_2
  L1_2[5] = L6_2
  L1_2[6] = L7_2
  L2_2 = pairs
  L3_2 = L1_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    if A0_2 == L7_2 then
      L8_2 = "MP"
      L9_2 = util
      L9_2 = L9_2.get_char_slot
      L9_2 = L9_2()
      L10_2 = "_"
      L11_2 = A0_2
      L8_2 = L8_2 .. L9_2 .. L10_2 .. L11_2
      return L8_2
    end
  end
  L2_2 = string
  L2_2 = L2_2.contains
  L3_2 = A0_2
  L4_2 = "MP_"
  L2_2 = L2_2(L3_2, L4_2)
  if not L2_2 then
    L2_2 = string
    L2_2 = L2_2.contains
    L3_2 = A0_2
    L4_2 = "MPPLY_"
    L2_2 = L2_2(L3_2, L4_2)
    if not L2_2 then
      L2_2 = "MP"
      L3_2 = util
      L3_2 = L3_2.get_char_slot
      L3_2 = L3_2()
      L4_2 = "_"
      L5_2 = A0_2
      L2_2 = L2_2 .. L3_2 .. L4_2 .. L5_2
      return L2_2
    end
  end
  return A0_2
end
ADD_MP_INDEX = L0_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = STATS
  L2_2 = L2_2.STAT_SET_INT
  L3_2 = util
  L3_2 = L3_2.joaat
  L4_2 = ADD_MP_INDEX
  L5_2 = A0_2
  L4_2, L5_2 = L4_2(L5_2)
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = A1_2
  L5_2 = true
  L2_2(L3_2, L4_2, L5_2)
end
STAT_SET_INT = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = memory
  L1_2 = L1_2.alloc_int
  L1_2 = L1_2()
  L2_2 = STATS
  L2_2 = L2_2.STAT_GET_INT
  L3_2 = util
  L3_2 = L3_2.joaat
  L4_2 = ADD_MP_INDEX
  L5_2 = A0_2
  L4_2, L5_2 = L4_2(L5_2)
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = L1_2
  L5_2 = -1
  L2_2(L3_2, L4_2, L5_2)
  L2_2 = memory
  L2_2 = L2_2.read_int
  L3_2 = L1_2
  return L2_2(L3_2)
end
STAT_GET_INT = L0_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = memory
  L2_2 = L2_2.write_int
  L3_2 = memory
  L3_2 = L3_2.script_global
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = A1_2
  L2_2(L3_2, L4_2)
end
SET_INT_GLOBAL = L0_1
function L0_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2
  L3_2 = memory
  L3_2 = L3_2.script_local
  L4_2 = A0_2
  L5_2 = A1_2
  L3_2 = L3_2(L4_2, L5_2)
  if 0 ~= L3_2 then
    L3_2 = memory
    L3_2 = L3_2.write_int
    L4_2 = memory
    L4_2 = L4_2.script_local
    L5_2 = A0_2
    L6_2 = A1_2
    L4_2 = L4_2(L5_2, L6_2)
    L5_2 = A2_2
    L3_2(L4_2, L5_2)
  end
end
SET_INT_LOCAL = L0_1
function L0_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2
  L3_2 = memory
  L3_2 = L3_2.script_local
  L4_2 = A0_2
  L5_2 = A1_2
  L3_2 = L3_2(L4_2, L5_2)
  if 0 ~= L3_2 then
    L3_2 = memory
    L3_2 = L3_2.write_float
    L4_2 = memory
    L4_2 = L4_2.script_local
    L5_2 = A0_2
    L6_2 = A1_2
    L4_2 = L4_2(L5_2, L6_2)
    L5_2 = A2_2
    L3_2(L4_2, L5_2)
  end
end
SET_FLOAT_LOCAL = L0_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = memory
  L2_2 = L2_2.write_float
  L3_2 = memory
  L3_2 = L3_2.script_global
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = A1_2
  L2_2(L3_2, L4_2)
end
SET_FLOAT_GLOBAL = L0_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = STATS
  L2_2 = L2_2.STAT_SET_BOOL
  L3_2 = util
  L3_2 = L3_2.joaat
  L4_2 = ADD_MP_INDEX
  L5_2 = A0_2
  L4_2, L5_2 = L4_2(L5_2)
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = A1_2
  L5_2 = true
  L2_2(L3_2, L4_2, L5_2)
end
STAT_SET_BOOL = L0_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = memory
  L2_2 = L2_2.script_local
  L3_2 = A0_2
  L4_2 = A1_2
  L2_2 = L2_2(L3_2, L4_2)
  if 0 ~= L2_2 then
    L2_2 = memory
    L2_2 = L2_2.read_int
    L3_2 = memory
    L3_2 = L3_2.script_local
    L4_2 = A0_2
    L5_2 = A1_2
    L3_2, L4_2, L5_2 = L3_2(L4_2, L5_2)
    L2_2 = L2_2(L3_2, L4_2, L5_2)
    if nil ~= L2_2 then
      return L2_2
    end
  end
end
GET_INT_LOCAL = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = ""
  L2_2 = "abcdefghijklmnopqrstuvwxyzABCEDFGHIJKLMNOPQRSTUVWXYZ0123456789"
  L3_2 = 1
  L4_2 = A0_2
  L5_2 = 1
  for L6_2 = L3_2, L4_2, L5_2 do
    L7_2 = L1_2
    L8_2 = math
    L8_2 = L8_2.random
    L9_2 = #L2_2
    L8_2 = L8_2(L9_2)
    L8_2 = L2_2[L8_2]
    L7_2 = L7_2 .. L8_2
    L1_2 = L7_2
  end
  return L1_2
end
random_string = L0_1
function L0_1(A0_2)
  local L1_2, L2_2
  L1_2 = json
  L1_2 = L1_2.decode
  L2_2 = A0_2
  return L1_2(L2_2)
end
StrToTable = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = type
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if "table" == L1_2 then
    L1_2 = TableToStr
    L2_2 = A0_2
    return L1_2(L2_2)
  else
    L1_2 = type
    L2_2 = A0_2
    L1_2 = L1_2(L2_2)
    if "string" == L1_2 then
      L1_2 = "'"
      L2_2 = A0_2
      L3_2 = "'"
      L1_2 = L1_2 .. L2_2 .. L3_2
      return L1_2
    else
      L1_2 = tostring
      L2_2 = A0_2
      return L1_2(L2_2)
    end
  end
end
ToStringEx = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  if nil == A0_2 then
    L1_2 = ""
    return L1_2
  end
  L1_2 = "{"
  L2_2 = 1
  L3_2 = pairs
  L4_2 = A0_2
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = ","
    if 1 == L2_2 then
      L9_2 = ""
    end
    if L7_2 == L2_2 then
      L10_2 = L1_2
      L11_2 = L9_2
      L12_2 = ToStringEx
      L13_2 = L8_2
      L12_2 = L12_2(L13_2)
      L10_2 = L10_2 .. L11_2 .. L12_2
      L1_2 = L10_2
    else
      L10_2 = type
      L11_2 = L7_2
      L10_2 = L10_2(L11_2)
      if "number" ~= L10_2 then
        L10_2 = type
        L11_2 = L7_2
        L10_2 = L10_2(L11_2)
        if "string" ~= L10_2 then
          goto lbl_48
        end
      end
      L10_2 = L1_2
      L11_2 = L9_2
      L12_2 = "["
      L13_2 = ToStringEx
      L14_2 = L7_2
      L13_2 = L13_2(L14_2)
      L14_2 = "]="
      L15_2 = ToStringEx
      L16_2 = L8_2
      L15_2 = L15_2(L16_2)
      L10_2 = L10_2 .. L11_2 .. L12_2 .. L13_2 .. L14_2 .. L15_2
      L1_2 = L10_2
      goto lbl_78
      ::lbl_48::
      L10_2 = type
      L11_2 = L7_2
      L10_2 = L10_2(L11_2)
      if "userdata" == L10_2 then
        L10_2 = L1_2
        L11_2 = L9_2
        L12_2 = "*s"
        L13_2 = TableToStr
        L14_2 = getmetatable
        L15_2 = L7_2
        L14_2, L15_2, L16_2, L17_2 = L14_2(L15_2)
        L13_2 = L13_2(L14_2, L15_2, L16_2, L17_2)
        L14_2 = "*e"
        L15_2 = "="
        L16_2 = ToStringEx
        L17_2 = L8_2
        L16_2 = L16_2(L17_2)
        L10_2 = L10_2 .. L11_2 .. L12_2 .. L13_2 .. L14_2 .. L15_2 .. L16_2
        L1_2 = L10_2
      else
        L10_2 = L1_2
        L11_2 = L9_2
        L12_2 = L7_2
        L13_2 = "="
        L14_2 = ToStringEx
        L15_2 = L8_2
        L14_2 = L14_2(L15_2)
        L10_2 = L10_2 .. L11_2 .. L12_2 .. L13_2 .. L14_2
        L1_2 = L10_2
      end
    end
    ::lbl_78::
    L2_2 = L2_2 + 1
  end
  L3_2 = L1_2
  L4_2 = "}"
  L3_2 = L3_2 .. L4_2
  L1_2 = L3_2
  return L1_2
end
TableToStr = L0_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L2_2 = pairs
  L3_2 = A0_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    if A1_2 == L7_2 then
      L8_2 = true
      return L8_2
    end
  end
  L2_2 = false
  return L2_2
end
table_find = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = CAM
  L1_2 = L1_2.GET_GAMEPLAY_CAM_ROT
  L2_2 = 0
  L1_2 = L1_2(L2_2)
  L2_2 = CAM
  L2_2 = L2_2.GET_GAMEPLAY_CAM_COORD
  L2_2 = L2_2()
  L3_2 = v3
  L3_2 = L3_2.toDir
  L4_2 = L1_2
  L3_2 = L3_2(L4_2)
  L4_2 = {}
  L5_2 = L2_2.x
  L6_2 = L3_2.x
  L6_2 = L6_2 * A0_2
  L5_2 = L5_2 + L6_2
  L4_2.x = L5_2
  L5_2 = L2_2.y
  L6_2 = L3_2.y
  L6_2 = L6_2 * A0_2
  L5_2 = L5_2 + L6_2
  L4_2.y = L5_2
  L5_2 = L2_2.z
  L6_2 = L3_2.z
  L6_2 = L6_2 * A0_2
  L5_2 = L5_2 + L6_2
  L4_2.z = L5_2
  return L4_2
end
get_offset_from_gameplay_camera = L0_1
function L0_1(A0_2, A1_2, A2_2, A3_2, A4_2)
  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  if 1 == A4_2 then
    L5_2 = 1
    L6_2 = #A0_2
    L7_2 = 1
    for L8_2 = L5_2, L6_2, L7_2 do
      L9_2 = request_ipl
      L10_2 = A0_2[L8_2]
      L9_2(L10_2)
    end
    L5_2 = ENTITY
    L5_2 = L5_2.SET_ENTITY_COORDS_NO_OFFSET
    L6_2 = PLAYER
    L6_2 = L6_2.PLAYER_PED_ID
    L6_2 = L6_2()
    L7_2 = A1_2
    L8_2 = A2_2
    L9_2 = A3_2
    L10_2 = false
    L11_2 = false
    L12_2 = false
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  else
    L5_2 = 1
    L6_2 = #A0_2
    L7_2 = 1
    for L8_2 = L5_2, L6_2, L7_2 do
      L9_2 = remove_ipl
      L10_2 = A0_2[L8_2]
      L9_2(L10_2)
    end
  end
end
load_IPL = L0_1
L0_1 = {}
L0_1.lib = "scr_rcbarry2"
L0_1.name = "scr_clown_appears"
function L1_1(A0_2)
  local L1_2
  L1_2 = particle_gun_fx
  L1_2 = L1_2[A0_2]
  L0_1 = L1_2
end
selete_particle_gun = L1_1
function L1_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L0_2 = PED
  L0_2 = L0_2.IS_PED_SHOOTING
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  if L0_2 then
    L0_2 = util
    L0_2 = L0_2.joaat
    L1_2 = "w_lr_firework_rocket"
    L0_2 = L0_2(L1_2)
    L1_2 = ENTITY
    L1_2 = L1_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = 0.0
    L4_2 = 0.5
    L5_2 = 0.5
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2)
    L2_2 = {}
    L3_2 = {}
    L4_2 = get_offset_from_gameplay_camera
    L5_2 = 15
    L4_2 = L4_2(L5_2)
    L3_2 = L4_2
    L4_2 = L3_2.x
    L5_2 = L1_2.x
    L4_2 = L4_2 - L5_2
    L4_2 = L4_2 * 15
    L2_2.x = L4_2
    L4_2 = L3_2.y
    L5_2 = L1_2.y
    L4_2 = L4_2 - L5_2
    L4_2 = L4_2 * 15
    L2_2.y = L4_2
    L4_2 = L3_2.z
    L5_2 = L1_2.z
    L4_2 = L4_2 - L5_2
    L4_2 = L4_2 * 15
    L2_2.z = L4_2
    L4_2 = ENTITY
    L4_2 = L4_2.DOES_ENTITY_EXIST
    L5_2 = particle_gun_bullet
    L4_2 = L4_2(L5_2)
    if L4_2 then
      L4_2 = delete_entity
      L5_2 = particle_gun_bullet
      L4_2(L5_2)
    end
    L4_2 = create_object
    L5_2 = L0_2
    L6_2 = L1_2.x
    L7_2 = L1_2.y
    L8_2 = L1_2.z
    L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
    particle_gun_bullet = L4_2
    L4_2 = set_entity_full_visible
    L5_2 = particle_gun_bullet
    L6_2 = false
    L4_2(L5_2, L6_2)
    L4_2 = ENTITY
    L4_2 = L4_2.SET_ENTITY_INVINCIBLE
    L5_2 = particle_gun_bullet
    L6_2 = true
    L4_2(L5_2, L6_2)
    L4_2 = ENTITY
    L4_2 = L4_2.SET_ENTITY_COLLISION
    L5_2 = particle_gun_bullet
    L6_2 = false
    L7_2 = true
    L4_2(L5_2, L6_2, L7_2)
    L4_2 = ENTITY
    L4_2 = L4_2.SET_ENTITY_HAS_GRAVITY
    L5_2 = particle_gun_bullet
    L6_2 = false
    L4_2(L5_2, L6_2)
    L4_2 = CAM
    L4_2 = L4_2.GET_GAMEPLAY_CAM_ROT
    L5_2 = 0
    L4_2 = L4_2(L5_2)
    L5_2 = ENTITY
    L5_2 = L5_2.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
    L6_2 = particle_gun_bullet
    L7_2 = 1
    L8_2 = L2_2.x
    L9_2 = L2_2.y
    L10_2 = L2_2.z
    L11_2 = false
    L12_2 = false
    L13_2 = false
    L14_2 = false
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    L5_2 = ENTITY
    L5_2 = L5_2.SET_ENTITY_ROTATION
    L6_2 = particle_gun_bullet
    L7_2 = L4_2.x
    L8_2 = L4_2.y
    L9_2 = L4_2.z
    L10_2 = 0
    L11_2 = true
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    L5_2 = request_ptfx_asset
    L6_2 = L0_1.lib
    L5_2(L6_2)
    L5_2 = GRAPHICS
    L5_2 = L5_2.USE_PARTICLE_FX_ASSET
    L6_2 = L0_1.lib
    L5_2(L6_2)
    L5_2 = GRAPHICS
    L6_2 = "START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY"
    L5_2 = L5_2[L6_2]
    L6_2 = L0_1.name
    L7_2 = particle_gun_bullet
    L8_2 = 0
    L9_2 = 0
    L10_2 = 0
    L11_2 = 0
    L12_2 = 180
    L13_2 = 0
    L14_2 = 1
    L15_2 = true
    L16_2 = true
    L17_2 = true
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  end
end
particle_gun = L1_1
function L1_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = MONEY
  L0_2 = L0_2.NETWORK_GET_VC_BANK_BALANCE
  L0_2 = L0_2()
  if L0_2 > 0 then
    L1_2 = NETSHOPPING1
    L1_2 = L1_2._NET_GAMESERVER_TRANSFER_BANK_TO_WALLET
    L2_2 = 0
    L3_2 = L0_2
    L1_2(L2_2, L3_2)
    L1_2 = util
    L1_2 = L1_2.toast
    L2_2 = "取出 "
    L3_2 = L0_2
    L4_2 = "$ 到钱包"
    L2_2 = L2_2 .. L3_2 .. L4_2
    L1_2(L2_2)
  else
    L1_2 = util
    L1_2 = L1_2.toast
    L2_2 = "余额不足,交易失败"
    L1_2(L2_2)
  end
end
bank_to_wallet = L1_1
function L1_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = MONEY
  L0_2 = L0_2.NETWORK_GET_VC_WALLET_BALANCE
  L1_2 = 0
  L0_2 = L0_2(L1_2)
  if L0_2 > 0 then
    L1_2 = NETSHOPPING1
    L1_2 = L1_2._NET_GAMESERVER_TRANSFER_WALLET_TO_BANK
    L2_2 = 0
    L3_2 = L0_2
    L1_2(L2_2, L3_2)
    L1_2 = util
    L1_2 = L1_2.toast
    L2_2 = "存入 "
    L3_2 = L0_2
    L4_2 = "$ 到银行"
    L2_2 = L2_2 .. L3_2 .. L4_2
    L1_2(L2_2)
  else
    L1_2 = util
    L1_2 = L1_2.toast
    L2_2 = "余额不足,交易失败"
    L1_2(L2_2)
  end
end
wallet_to_bank = L1_1
function L1_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = MONEY
  L0_2 = L0_2.NETWORK_GET_VC_WALLET_BALANCE
  L1_2 = 0
  L0_2 = L0_2(L1_2)
  if L0_2 > 0 then
    L1_2 = NETSHOPPING1
    L1_2 = L1_2._NET_GAMESERVER_TRANSFER_WALLET_TO_BANK
    L2_2 = 0
    L3_2 = L0_2
    L1_2(L2_2, L3_2)
    L1_2 = util
    L1_2 = L1_2.toast
    L2_2 = "已将"
    L3_2 = L0_2
    L4_2 = "$存入银行"
    L2_2 = L2_2 .. L3_2 .. L4_2
    L1_2(L2_2)
  end
end
auto_deposit = L1_1
function L1_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L0_2 = ENTITY
  L0_2 = L0_2.GET_ENTITY_COORDS
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = false
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = WATER
  L1_2 = L1_2.SET_DEEP_OCEAN_SCALER
  L2_2 = 0.0
  L1_2(L2_2)
  L1_2 = WATER
  L1_2 = L1_2.MODIFY_WATER
  L2_2 = L0_2.x
  L3_2 = L0_2.y
  L4_2 = -500000.0
  L5_2 = 0.2
  L1_2(L2_2, L3_2, L4_2, L5_2)
  L1_2 = WATER
  L1_2 = L1_2.MODIFY_WATER
  L2_2 = L0_2.x
  L2_2 = L2_2 + 2
  L3_2 = L0_2.y
  L4_2 = -500000.0
  L5_2 = 0.2
  L1_2(L2_2, L3_2, L4_2, L5_2)
  L1_2 = WATER
  L1_2 = L1_2.MODIFY_WATER
  L2_2 = L0_2.x
  L3_2 = L0_2.y
  L3_2 = L3_2 + 2
  L4_2 = -500000.0
  L5_2 = 0.2
  L1_2(L2_2, L3_2, L4_2, L5_2)
  L1_2 = WATER
  L1_2 = L1_2.MODIFY_WATER
  L2_2 = L0_2.x
  L2_2 = L2_2 - 2
  L3_2 = L0_2.y
  L4_2 = -500000.0
  L5_2 = 0.2
  L1_2(L2_2, L3_2, L4_2, L5_2)
  L1_2 = WATER
  L1_2 = L1_2.MODIFY_WATER
  L2_2 = L0_2.x
  L3_2 = L0_2.y
  L3_2 = L3_2 - 2
  L4_2 = -500000.0
  L5_2 = 0.2
  L1_2(L2_2, L3_2, L4_2, L5_2)
  L1_2 = WATER
  L1_2 = L1_2.MODIFY_WATER
  L2_2 = L0_2.x
  L3_2 = math
  L3_2 = L3_2.random
  L4_2 = 4
  L5_2 = 10
  L3_2 = L3_2(L4_2, L5_2)
  L2_2 = L2_2 + L3_2
  L3_2 = L0_2.y
  L4_2 = -500000.0
  L5_2 = 0.2
  L1_2(L2_2, L3_2, L4_2, L5_2)
  L1_2 = WATER
  L1_2 = L1_2.MODIFY_WATER
  L2_2 = L0_2.x
  L3_2 = L0_2.y
  L4_2 = math
  L4_2 = L4_2.random
  L5_2 = 4
  L6_2 = 10
  L4_2 = L4_2(L5_2, L6_2)
  L3_2 = L3_2 + L4_2
  L4_2 = -500000.0
  L5_2 = 0.2
  L1_2(L2_2, L3_2, L4_2, L5_2)
  L1_2 = WATER
  L1_2 = L1_2.MODIFY_WATER
  L2_2 = L0_2.x
  L3_2 = math
  L3_2 = L3_2.random
  L4_2 = 4
  L5_2 = 10
  L3_2 = L3_2(L4_2, L5_2)
  L2_2 = L2_2 - L3_2
  L3_2 = L0_2.y
  L4_2 = -500000.0
  L5_2 = 0.2
  L1_2(L2_2, L3_2, L4_2, L5_2)
  L1_2 = WATER
  L1_2 = L1_2.MODIFY_WATER
  L2_2 = L0_2.x
  L3_2 = L0_2.y
  L4_2 = math
  L4_2 = L4_2.random
  L5_2 = 4
  L6_2 = 10
  L4_2 = L4_2(L5_2, L6_2)
  L3_2 = L3_2 - L4_2
  L4_2 = -500000.0
  L5_2 = 0.2
  L1_2(L2_2, L3_2, L4_2, L5_2)
end
water_vortex = L1_1
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = 0
  L2_2 = 49
  L3_2 = 1
  for L4_2 = L1_2, L2_2, L3_2 do
    L5_2 = VEHICLE
    L5_2 = L5_2.GET_NUM_VEHICLE_MODS
    L6_2 = A0_2
    L7_2 = L4_2
    L5_2 = L5_2(L6_2, L7_2)
    L6_2 = VEHICLE
    L6_2 = L6_2.SET_VEHICLE_MOD
    L7_2 = A0_2
    L8_2 = L4_2
    L9_2 = L5_2 - 1
    L10_2 = true
    L6_2(L7_2, L8_2, L9_2, L10_2)
  end
end
upgrade_vehicle = L1_1
function L1_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = PED
  L0_2 = L0_2.IS_PED_IN_ANY_VEHICLE
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = false
  L0_2 = L0_2(L1_2, L2_2)
  if not L0_2 then
    L0_2 = util
    L0_2 = L0_2.toast
    L1_2 = "请先进入载具"
    L0_2(L1_2)
    return
  end
  L0_2 = PED
  L0_2 = L0_2.IS_PED_IN_ANY_VEHICLE
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = false
  L0_2 = L0_2(L1_2, L2_2)
  if L0_2 then
    L0_2 = ENTITY
    L0_2 = L0_2.GET_ENTITY_COORDS
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_PED_ID
    L1_2 = L1_2()
    L2_2 = false
    L0_2 = L0_2(L1_2, L2_2)
    L1_2 = PED
    L1_2 = L1_2.GET_VEHICLE_PED_IS_IN
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = false
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = util
    L2_2 = L2_2.joaat
    L3_2 = "u_m_m_jesus_01"
    L2_2 = L2_2(L3_2)
    L3_2 = create_ped
    L4_2 = 26
    L5_2 = L2_2
    L6_2 = L0_2.x
    L7_2 = L0_2.y
    L8_2 = L0_2.z
    L9_2 = 0
    L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    L4_2 = ENTITY
    L4_2 = L4_2.SET_ENTITY_INVINCIBLE
    L5_2 = L3_2
    L6_2 = true
    L4_2(L5_2, L6_2)
    L4_2 = PED
    L4_2 = L4_2.SET_PED_INTO_VEHICLE
    L5_2 = PLAYER
    L5_2 = L5_2.PLAYER_PED_ID
    L5_2 = L5_2()
    L6_2 = L1_2
    L7_2 = 0
    L4_2(L5_2, L6_2, L7_2)
    L4_2 = PED
    L4_2 = L4_2.SET_PED_INTO_VEHICLE
    L5_2 = L3_2
    L6_2 = L1_2
    L7_2 = -1
    L4_2(L5_2, L6_2, L7_2)
    L4_2 = ENTITY
    L4_2 = L4_2.SET_ENTITY_COLLISION
    L5_2 = L1_2
    L6_2 = false
    L7_2 = false
    L4_2(L5_2, L6_2, L7_2)
    L4_2 = {}
    L4_2.x = 0
    L4_2.y = 0
    L4_2.z = 10000
    L5_2 = VEHICLE
    L5_2 = L5_2.SET_VEHICLE_GRAVITY
    L6_2 = L1_2
    L7_2 = false
    L5_2(L6_2, L7_2)
    L5_2 = ENTITY
    L5_2 = L5_2.SET_ENTITY_VELOCITY
    L6_2 = L1_2
    L7_2 = L4_2.x
    L8_2 = L4_2.y
    L9_2 = L4_2.z
    L5_2(L6_2, L7_2, L8_2, L9_2)
    L5_2 = util
    L5_2 = L5_2.yield
    L6_2 = 5000
    L5_2(L6_2)
    L5_2 = ENTITY
    L5_2 = L5_2.SET_ENTITY_HEALTH
    L6_2 = PLAYER
    L6_2 = L6_2.PLAYER_PED_ID
    L6_2 = L6_2()
    L7_2 = 0
    L8_2 = 0
    L5_2(L6_2, L7_2, L8_2)
  end
end
To_Heaven = L1_1
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2
  L1_2 = 0
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2 = L3_2()
  L4_2 = false
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = ENTITY
  L3_2 = L3_2.GET_ENTITY_HEADING
  L4_2 = PLAYER
  L4_2 = L4_2.PLAYER_PED_ID
  L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2 = L4_2()
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
  supermand = A0_2
  L4_2 = supermand
  if L4_2 then
    L4_2 = ENTITY
    L4_2 = L4_2.FREEZE_ENTITY_POSITION
    L5_2 = PLAYER
    L5_2 = L5_2.PLAYER_PED_ID
    L5_2 = L5_2()
    L6_2 = true
    L4_2(L5_2, L6_2)
    L4_2 = TASK
    L4_2 = L4_2.CLEAR_PED_TASKS_IMMEDIATELY
    L5_2 = PLAYER
    L5_2 = L5_2.PLAYER_PED_ID
    L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2 = L5_2()
    L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
    L4_2 = CAM
    L4_2 = L4_2.CREATE_CAM_WITH_PARAMS
    L5_2 = "DEFAULT_SCRIPTED_CAMERA"
    L6_2 = L2_2.x
    L7_2 = L2_2.y
    L8_2 = L2_2.z
    L9_2 = 0.0
    L10_2 = 0.0
    L11_2 = 0.0
    L12_2 = 120
    L13_2 = true
    L14_2 = 0
    L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    camera = L4_2
    L4_2 = CAM
    L4_2 = L4_2.RENDER_SCRIPT_CAMS
    L5_2 = true
    L6_2 = false
    L7_2 = 0
    L8_2 = true
    L9_2 = true
    L10_2 = 0
    L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
    L4_2 = request_anim_dict
    L5_2 = "skydive@freefall"
    L4_2(L5_2)
    L4_2 = TASK
    L4_2 = L4_2.TASK_PLAY_ANIM
    L5_2 = PLAYER
    L5_2 = L5_2.PLAYER_PED_ID
    L5_2 = L5_2()
    L6_2 = "skydive@freefall"
    L7_2 = "free_forward"
    L8_2 = 1.0
    L9_2 = 1.0
    L10_2 = -1
    L11_2 = 3
    L12_2 = 0.5
    L13_2 = false
    L14_2 = false
    L15_2 = false
    L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  else
    L4_2 = TASK
    L4_2 = L4_2.CLEAR_PED_TASKS_IMMEDIATELY
    L5_2 = PLAYER
    L5_2 = L5_2.PLAYER_PED_ID
    L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2 = L5_2()
    L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
    L4_2 = support_ent
    if 0 ~= L4_2 then
      L4_2 = delete_entity
      L5_2 = support_ent
      L4_2(L5_2)
    end
    L4_2 = camera
    if 0 ~= L4_2 then
      L4_2 = CAM
      L4_2 = L4_2.RENDER_SCRIPT_CAMS
      L5_2 = false
      L6_2 = false
      L7_2 = 0
      L8_2 = true
      L9_2 = true
      L10_2 = 0
      L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
      L4_2 = CAM
      L4_2 = L4_2.DESTROY_CAM
      L5_2 = camera
      L6_2 = false
      L4_2(L5_2, L6_2)
      camera = 0
    end
    L4_2 = ENTITY
    L4_2 = L4_2.FREEZE_ENTITY_POSITION
    L5_2 = PLAYER
    L5_2 = L5_2.PLAYER_PED_ID
    L5_2 = L5_2()
    L6_2 = false
    L4_2(L5_2, L6_2)
  end
  while true do
    L4_2 = supermand
    if not L4_2 then
      break
    end
    L4_2 = PAD
    L4_2 = L4_2.GET_CONTROL_NORMAL
    L5_2 = 1
    L6_2 = 1
    L4_2 = L4_2(L5_2, L6_2)
    L4_2 = -2 * L4_2
    L5_2 = PAD
    L5_2 = L5_2.GET_CONTROL_NORMAL
    L6_2 = 2
    L7_2 = 2
    L5_2 = L5_2(L6_2, L7_2)
    L5_2 = -2 * L5_2
    L6_2 = PAD
    L6_2 = L6_2.GET_CONTROL_NORMAL
    L7_2 = 30
    L8_2 = 30
    L6_2 = L6_2(L7_2, L8_2)
    L7_2 = math
    L7_2 = L7_2.abs
    L8_2 = L1_2
    L7_2 = L7_2(L8_2)
    if L7_2 >= 120 then
      L4_2 = -L4_2
    end
    L7_2 = ENTITY
    L7_2 = L7_2.GET_ENTITY_COORDS
    L8_2 = PLAYER
    L8_2 = L8_2.PLAYER_PED_ID
    L8_2 = L8_2()
    L9_2 = false
    L7_2 = L7_2(L8_2, L9_2)
    L8_2 = L5_2 * 2
    L1_2 = L1_2 + L8_2
    L8_2 = L4_2 * 2
    L3_2 = L3_2 + L8_2
    L8_2 = PAD
    L8_2 = L8_2.IS_CONTROL_PRESSED
    L9_2 = 0
    L10_2 = 55
    L8_2 = L8_2(L9_2, L10_2)
    L9_2 = PAD
    L9_2 = L9_2.IS_CONTROL_PRESSED
    L10_2 = 0
    L11_2 = 21
    L9_2 = L9_2(L10_2, L11_2)
    L10_2 = math
    L10_2 = L10_2.abs
    L11_2 = L1_2
    L10_2 = L10_2(L11_2)
    L11_2 = 360
    if L10_2 >= L11_2 then
      L1_2 = 0
    end
    L10_2 = math
    L10_2 = L10_2.abs
    L11_2 = L3_2
    L10_2 = L10_2(L11_2)
    L11_2 = 360
    if L10_2 >= L11_2 then
      L3_2 = 0
    end
    L10_2 = ENTITY
    L10_2 = L10_2.DOES_ENTITY_EXIST
    L11_2 = support_ent
    L10_2 = L10_2(L11_2)
    if L10_2 then
      L10_2 = ENTITY
      L10_2 = L10_2.GET_ENTITY_ROTATION
      L11_2 = support_ent
      L12_2 = 1
      L10_2 = L10_2(L11_2, L12_2)
      L11_2 = ENTITY
      L11_2 = L11_2.SET_ENTITY_ROTATION
      L12_2 = support_ent
      L13_2 = L1_2
      L14_2 = 0.0
      L15_2 = L3_2
      L16_2 = 1
      L17_2 = true
      L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
      L11_2 = ENTITY
      L11_2 = L11_2.SET_ENTITY_MAX_SPEED
      L12_2 = support_ent
      L13_2 = 600
      L11_2(L12_2, L13_2)
      L11_2 = PAD
      L11_2 = L11_2.IS_CONTROL_PRESSED
      L12_2 = 0
      L13_2 = 32
      L11_2 = L11_2(L12_2, L13_2)
      L12_2 = PAD
      L12_2 = L12_2.IS_CONTROL_PRESSED
      L13_2 = 0
      L14_2 = 33
      L12_2 = L12_2(L13_2, L14_2)
      L13_2 = ENTITY
      L13_2 = L13_2.GET_ENTITY_SPEED_VECTOR
      L14_2 = support_ent
      L15_2 = true
      L13_2 = L13_2(L14_2, L15_2)
      L14_2 = L13_2.x
      L15_2 = math
      L15_2 = L15_2.abs
      L16_2 = L14_2
      L15_2 = L15_2(L16_2)
      if L15_2 > 5 then
        L15_2 = ENTITY
        L15_2 = L15_2.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
        L16_2 = support_ent
        L17_2 = 0
        L18_2 = -L14_2
        L19_2 = 0
        L20_2 = 0
        L21_2 = true
        L22_2 = true
        L23_2 = true
        L24_2 = true
        L15_2(L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
      end
      if L11_2 then
        L15_2 = ENTITY
        L15_2 = L15_2.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
        L16_2 = support_ent
        L17_2 = 0
        L18_2 = 0
        L19_2 = 600
        L20_2 = 0
        L21_2 = true
        L22_2 = true
        L23_2 = true
        L24_2 = true
        L15_2(L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
      end
      if L12_2 then
        L15_2 = ENTITY
        L15_2 = L15_2.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
        L16_2 = support_ent
        L17_2 = 0
        L18_2 = 0
        L19_2 = -600
        L20_2 = 0
        L21_2 = true
        L22_2 = true
        L23_2 = true
        L24_2 = true
        L15_2(L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
      end
      if L8_2 then
        L15_2 = ENTITY
        L15_2 = L15_2.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
        L16_2 = support_ent
        L17_2 = 0
        L18_2 = 0
        L19_2 = 0
        L20_2 = 300.0
        L21_2 = true
        L22_2 = true
        L23_2 = true
        L24_2 = true
        L15_2(L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
      end
      if L9_2 then
        L15_2 = ENTITY
        L15_2 = L15_2.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
        L16_2 = support_ent
        L17_2 = 0
        L18_2 = 0
        L19_2 = 0
        L20_2 = -300.0
        L21_2 = true
        L22_2 = true
        L23_2 = true
        L24_2 = true
        L15_2(L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
      end
      if L6_2 then
        L15_2 = ENTITY
        L15_2 = L15_2.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
        L16_2 = support_ent
        L17_2 = 0
        L18_2 = L6_2 * 600
        L19_2 = 0
        L20_2 = 0.0
        L21_2 = true
        L22_2 = true
        L23_2 = true
        L24_2 = true
        L15_2(L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
      end
      L15_2 = CAM
      L15_2 = L15_2.HARD_ATTACH_CAM_TO_ENTITY
      L16_2 = camera
      L17_2 = PLAYER
      L17_2 = L17_2.PLAYER_PED_ID
      L17_2 = L17_2()
      L18_2 = 0.0
      L19_2 = 0.0
      L20_2 = 0.0
      L21_2 = 0.0
      L22_2 = -5.0
      L23_2 = 0.0
      L24_2 = true
      L15_2(L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
    else
      L10_2 = create_object
      L11_2 = util
      L11_2 = L11_2.joaat
      L12_2 = "IG_RoosterMcCraw"
      L11_2 = L11_2(L12_2)
      L12_2 = L7_2.x
      L13_2 = L7_2.y
      L14_2 = L7_2.z
      L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2)
      support_ent = L10_2
      L10_2 = ENTITY
      L10_2 = L10_2.SET_ENTITY_ROTATION
      L11_2 = support_ent
      L12_2 = -90
      L13_2 = 90
      L14_2 = 90
      L15_2 = 0
      L10_2(L11_2, L12_2, L13_2, L14_2, L15_2)
      L10_2 = ENTITY
      L10_2 = L10_2.ATTACH_ENTITY_TO_ENTITY
      L11_2 = PLAYER
      L11_2 = L11_2.PLAYER_PED_ID
      L11_2 = L11_2()
      L12_2 = support_ent
      L13_2 = 90
      L14_2 = 0
      L15_2 = 0
      L16_2 = 0
      L17_2 = 0
      L18_2 = 0
      L19_2 = 0
      L20_2 = true
      L21_2 = false
      L22_2 = false
      L23_2 = true
      L24_2 = 0
      L25_2 = true
      L26_2 = 0
      L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
    end
    L10_2 = util
    L10_2 = L10_2.yield
    L10_2()
  end
end
superman_fly = L1_1
function L1_1()
  local L0_2, L1_2, L2_2
  L0_2 = WEAPON
  L0_2 = L0_2.REMOVE_ALL_PROJECTILES_OF_TYPE
  L1_2 = 741814745
  L2_2 = false
  L0_2(L1_2, L2_2)
  L0_2 = WEAPON
  L0_2 = L0_2.REMOVE_ALL_PROJECTILES_OF_TYPE
  L1_2 = -1312131151
  L2_2 = false
  L0_2(L1_2, L2_2)
  L0_2 = WEAPON
  L0_2 = L0_2.REMOVE_ALL_PROJECTILES_OF_TYPE
  L1_2 = -1568386805
  L2_2 = false
  L0_2(L1_2, L2_2)
  L0_2 = WEAPON
  L0_2 = L0_2.REMOVE_ALL_PROJECTILES_OF_TYPE
  L1_2 = 2138347493
  L2_2 = false
  L0_2(L1_2, L2_2)
  L0_2 = WEAPON
  L0_2 = L0_2.REMOVE_ALL_PROJECTILES_OF_TYPE
  L1_2 = 1672152130
  L2_2 = false
  L0_2(L1_2, L2_2)
  L0_2 = WEAPON
  L0_2 = L0_2.REMOVE_ALL_PROJECTILES_OF_TYPE
  L1_2 = 125959754
  L2_2 = false
  L0_2(L1_2, L2_2)
  L0_2 = WEAPON
  L0_2 = L0_2.REMOVE_ALL_PROJECTILES_OF_TYPE
  L1_2 = -1813897027
  L2_2 = false
  L0_2(L1_2, L2_2)
  L0_2 = WEAPON
  L0_2 = L0_2.REMOVE_ALL_PROJECTILES_OF_TYPE
  L1_2 = 615608432
  L2_2 = false
  L0_2(L1_2, L2_2)
  L0_2 = WEAPON
  L0_2 = L0_2.REMOVE_ALL_PROJECTILES_OF_TYPE
  L1_2 = 1420407917
  L2_2 = false
  L0_2(L1_2, L2_2)
  L0_2 = WEAPON
  L0_2 = L0_2.REMOVE_ALL_PROJECTILES_OF_TYPE
  L1_2 = 1169823560
  L2_2 = false
  L0_2(L1_2, L2_2)
end
remove_explosive = L1_1
function L1_1()
  local L0_2, L1_2
  L0_2 = PLAYER
  L0_2 = L0_2.IS_PLAYER_FREE_AIMING
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2 = L1_2()
  L0_2 = L0_2(L1_2)
  if L0_2 then
    L0_2 = MISC
    L0_2 = L0_2.SET_TIME_SCALE
    L1_2 = 0.2
    L0_2(L1_2)
    L0_2 = GRAPHICS
    L0_2 = L0_2.SET_TIMECYCLE_MODIFIER
    L1_2 = "LostTimeFlash"
    L0_2(L1_2)
  else
    L0_2 = MISC
    L0_2 = L0_2.SET_TIME_SCALE
    L1_2 = 1
    L0_2(L1_2)
    L0_2 = GRAPHICS
    L0_2 = L0_2.SET_TIMECYCLE_MODIFIER
    L1_2 = "DEFAULT"
    L0_2(L1_2)
  end
end
dead_eye = L1_1
function L1_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L0_2 = math
  L0_2 = L0_2.random
  L1_2 = 0
  L2_2 = 255
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = math
  L1_2 = L1_2.random
  L2_2 = 0
  L3_2 = 255
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = math
  L2_2 = L2_2.random
  L3_2 = 0
  L4_2 = 255
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = PED
  L3_2 = L3_2.GET_VEHICLE_PED_IS_IN
  L4_2 = PLAYER
  L4_2 = L4_2.PLAYER_PED_ID
  L4_2 = L4_2()
  L5_2 = false
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = VEHICLE
  L4_2 = L4_2.SET_VEHICLE_NEON_COLOUR
  L5_2 = L3_2
  L6_2 = L0_2
  L7_2 = L1_2
  L8_2 = L2_2
  L4_2(L5_2, L6_2, L7_2, L8_2)
  L4_2 = VEHICLE
  L4_2 = L4_2.SET_VEHICLE_NEON_ENABLED
  L5_2 = L3_2
  L6_2 = 2
  L7_2 = true
  L4_2(L5_2, L6_2, L7_2)
  L4_2 = 0
  L5_2 = 1
  L6_2 = 1
  for L7_2 = L4_2, L5_2, L6_2 do
    L8_2 = VEHICLE
    L8_2 = L8_2.SET_VEHICLE_NEON_ENABLED
    L9_2 = L3_2
    L10_2 = L7_2
    L11_2 = false
    L8_2(L9_2, L10_2, L11_2)
  end
  L4_2 = VEHICLE
  L4_2 = L4_2.SET_VEHICLE_NEON_ENABLED
  L5_2 = L3_2
  L6_2 = 3
  L7_2 = false
  L4_2(L5_2, L6_2, L7_2)
  L4_2 = util
  L4_2 = L4_2.yield
  L5_2 = 100
  L4_2(L5_2)
  L4_2 = VEHICLE
  L4_2 = L4_2.SET_VEHICLE_NEON_ENABLED
  L5_2 = L3_2
  L6_2 = 0
  L7_2 = true
  L4_2(L5_2, L6_2, L7_2)
  L4_2 = 1
  L5_2 = 3
  L6_2 = 1
  for L7_2 = L4_2, L5_2, L6_2 do
    L8_2 = VEHICLE
    L8_2 = L8_2.SET_VEHICLE_NEON_ENABLED
    L9_2 = L3_2
    L10_2 = L7_2
    L11_2 = false
    L8_2(L9_2, L10_2, L11_2)
  end
  L4_2 = util
  L4_2 = L4_2.yield
  L5_2 = 100
  L4_2(L5_2)
  L4_2 = 0
  L5_2 = 2
  L6_2 = 1
  for L7_2 = L4_2, L5_2, L6_2 do
    L8_2 = VEHICLE
    L8_2 = L8_2.SET_VEHICLE_NEON_ENABLED
    L9_2 = L3_2
    L10_2 = L7_2
    L11_2 = false
    L8_2(L9_2, L10_2, L11_2)
  end
  L4_2 = VEHICLE
  L4_2 = L4_2.SET_VEHICLE_NEON_ENABLED
  L5_2 = L3_2
  L6_2 = 3
  L7_2 = true
  L4_2(L5_2, L6_2, L7_2)
  L4_2 = util
  L4_2 = L4_2.yield
  L5_2 = 100
  L4_2(L5_2)
  L4_2 = 2
  L5_2 = 3
  L6_2 = 1
  for L7_2 = L4_2, L5_2, L6_2 do
    L8_2 = VEHICLE
    L8_2 = L8_2.SET_VEHICLE_NEON_ENABLED
    L9_2 = L3_2
    L10_2 = L7_2
    L11_2 = false
    L8_2(L9_2, L10_2, L11_2)
  end
  L4_2 = VEHICLE
  L4_2 = L4_2.SET_VEHICLE_NEON_ENABLED
  L5_2 = L3_2
  L6_2 = 0
  L7_2 = false
  L4_2(L5_2, L6_2, L7_2)
  L4_2 = VEHICLE
  L4_2 = L4_2.SET_VEHICLE_NEON_ENABLED
  L5_2 = L3_2
  L6_2 = 1
  L7_2 = true
  L4_2(L5_2, L6_2, L7_2)
  L4_2 = util
  L4_2 = L4_2.yield
  L5_2 = 100
  L4_2(L5_2)
end
veh_circle_light = L1_1
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  if A1_2 then
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = PLAYER
    L3_2 = L3_2.GET_PLAYER_PED
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    if L2_2 == L3_2 then
      return
    end
    L2_2 = ENTITY
    L2_2 = L2_2.ATTACH_ENTITY_TO_ENTITY
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2 = L3_2()
    L4_2 = PLAYER
    L4_2 = L4_2.GET_PLAYER_PED
    L5_2 = A0_2
    L4_2 = L4_2(L5_2)
    L5_2 = 0
    L6_2 = -0.058
    L7_2 = 0.197
    L8_2 = 0.595
    L9_2 = 2.0
    L10_2 = 1.0
    L11_2 = 1
    L12_2 = true
    L13_2 = true
    L14_2 = true
    L15_2 = false
    L16_2 = 0
    L17_2 = true
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
    L2_2 = request_anim_dict
    L3_2 = "anim@heists@heist_safehouse_intro@phone_couch@male"
    L2_2(L3_2)
    L2_2 = TASK
    L2_2 = L2_2.TASK_PLAY_ANIM
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2 = L3_2()
    L4_2 = "anim@heists@heist_safehouse_intro@phone_couch@male"
    L5_2 = "phone_couch_male_idle"
    L6_2 = 3.0
    L7_2 = 2.0
    L8_2 = -1
    L9_2 = 3
    L10_2 = 1.0
    L11_2 = false
    L12_2 = false
    L13_2 = false
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  else
    L2_2 = ENTITY
    L2_2 = L2_2.DETACH_ENTITY
    L3_2 = PLAYER
    L3_2 = L3_2.GET_PLAYER_PED
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    L4_2 = false
    L5_2 = false
    L2_2(L3_2, L4_2, L5_2)
    L2_2 = ENTITY
    L2_2 = L2_2.DETACH_ENTITY
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2 = L3_2()
    L4_2 = false
    L5_2 = false
    L2_2(L3_2, L4_2, L5_2)
    L2_2 = TASK
    L2_2 = L2_2.CLEAR_PED_TASKS
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L3_2()
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  end
end
ride_player1 = L1_1
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  if A1_2 then
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = PLAYER
    L3_2 = L3_2.GET_PLAYER_PED
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    if L2_2 == L3_2 then
      return
    end
    L2_2 = ENTITY
    L2_2 = L2_2.ATTACH_ENTITY_TO_ENTITY
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2 = L3_2()
    L4_2 = PLAYER
    L4_2 = L4_2.GET_PLAYER_PED
    L5_2 = A0_2
    L4_2 = L4_2(L5_2)
    L5_2 = 0
    L6_2 = 0
    L7_2 = 0.597
    L8_2 = 0.995
    L9_2 = 2.0
    L10_2 = 1.0
    L11_2 = 1
    L12_2 = true
    L13_2 = true
    L14_2 = true
    L15_2 = false
    L16_2 = 0
    L17_2 = true
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
    L2_2 = request_anim_dict
    L3_2 = "timetable@jimmy@mics3_ig_15@"
    L2_2(L3_2)
    L2_2 = TASK
    L2_2 = L2_2.TASK_PLAY_ANIM
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2 = L3_2()
    L4_2 = "timetable@jimmy@mics3_ig_15@"
    L5_2 = "idle_a_tracy"
    L6_2 = 3.0
    L7_2 = 2.0
    L8_2 = -1
    L9_2 = 3
    L10_2 = 1.0
    L11_2 = false
    L12_2 = false
    L13_2 = false
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  else
    L2_2 = ENTITY
    L2_2 = L2_2.DETACH_ENTITY
    L3_2 = PLAYER
    L3_2 = L3_2.GET_PLAYER_PED
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    L4_2 = false
    L5_2 = false
    L2_2(L3_2, L4_2, L5_2)
    L2_2 = ENTITY
    L2_2 = L2_2.DETACH_ENTITY
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2 = L3_2()
    L4_2 = false
    L5_2 = false
    L2_2(L3_2, L4_2, L5_2)
    L2_2 = TASK
    L2_2 = L2_2.CLEAR_PED_TASKS
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L3_2()
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  end
end
ride_player2 = L1_1
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L1_2 = ENTITY
  L1_2 = L1_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = 0
  L4_2 = -100
  L5_2 = 100
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = PLAYER
  L3_2 = L3_2.GET_PLAYER_PED
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = false
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = ENTITY
  L3_2 = L3_2.SET_ENTITY_COORDS
  L4_2 = PLAYER
  L4_2 = L4_2.PLAYER_PED_ID
  L4_2 = L4_2()
  L5_2 = L1_2.x
  L6_2 = L1_2.y
  L7_2 = L1_2.z
  L8_2 = false
  L9_2 = false
  L10_2 = false
  L11_2 = false
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L3_2 = WEAPON
  L3_2 = L3_2.GIVE_DELAYED_WEAPON_TO_PED
  L4_2 = PLAYER
  L4_2 = L4_2.PLAYER_PED_ID
  L4_2 = L4_2()
  L5_2 = util
  L5_2 = L5_2.joaat
  L6_2 = "gadget_parachute"
  L5_2 = L5_2(L6_2)
  L6_2 = 1
  L7_2 = 0
  L3_2(L4_2, L5_2, L6_2, L7_2)
  while true do
    L3_2 = ENTITY
    L3_2 = L3_2.GET_ENTITY_COORDS
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2 = L4_2()
    L5_2 = false
    L3_2 = L3_2(L4_2, L5_2)
    L4_2 = Get_Distance
    L5_2 = L2_2
    L6_2 = L3_2
    L7_2 = true
    L4_2 = L4_2(L5_2, L6_2, L7_2)
    if L4_2 < 123 then
      L5_2 = PED
      L5_2 = L5_2.FORCE_PED_TO_OPEN_PARACHUTE
      L6_2 = PLAYER
      L6_2 = L6_2.PLAYER_PED_ID
      L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L6_2()
      L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
      return
    end
    L5_2 = util
    L5_2 = L5_2.yield
    L5_2()
  end
end
landing_on_player = L1_1
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if 0 ~= L1_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.GET_ENTITY_COORDS
    L2_2 = PLAYER
    L2_2 = L2_2.GET_PLAYER_PED
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    L3_2 = false
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = HUD
    L2_2 = L2_2.SET_NEW_WAYPOINT
    L3_2 = L1_2.x
    L4_2 = L1_2.y
    L2_2(L3_2, L4_2)
    L2_2 = util
    L2_2 = L2_2.yield
    L3_2 = 500
    L2_2(L3_2)
  end
end
set_waypoint = L1_1
L1_1 = {}
L1_1.name = ""
L1_1.rid = ""
L1_1.crew = ""
L1_1.ip = ""
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = {}
  L2_2 = "name"
  L3_2 = "rid"
  L4_2 = "crew"
  L5_2 = "ip"
  L1_2[1] = L2_2
  L1_2[2] = L3_2
  L1_2[3] = L4_2
  L1_2[4] = L5_2
  L2_2 = 0
  function L3_2()
    local L0_3, L1_3, L2_3
    L0_3 = L2_2
    L0_3 = L0_3 + 1
    L2_2 = L0_3
    L1_3 = L2_2
    L0_3 = L1_2
    L1_3 = L0_3[L1_3]
    L0_3 = A0_2
    L0_3 = L0_3[L1_3]
    if nil == L0_3 then
      L0_3 = nil
      return L0_3
    end
    L1_3 = L2_2
    L0_3 = L1_2
    L0_3 = L0_3[L1_3]
    L2_3 = L2_2
    L1_3 = L1_2
    L2_3 = L1_3[L2_3]
    L1_3 = A0_2
    L1_3 = L1_3[L2_3]
    return L0_3, L1_3
  end
  return L3_2
end
L1_1.__pairs = L2_1
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = {}
  L2_2 = memory
  L2_2 = L2_2.alloc
  L3_2 = 104
  L2_2 = L2_2(L3_2)
  L3_2 = memory
  L3_2 = L3_2.alloc
  L4_2 = 280
  L3_2 = L3_2(L4_2)
  L4_2 = NETWORK
  L4_2 = L4_2.NETWORK_HANDLE_FROM_PLAYER
  L5_2 = A0_2
  L6_2 = L2_2
  L7_2 = 13
  L4_2(L5_2, L6_2, L7_2)
  L4_2 = NETWORK
  L4_2 = L4_2.NETWORK_IS_HANDLE_VALID
  L5_2 = L2_2
  L6_2 = 13
  L4_2 = L4_2(L5_2, L6_2)
  if L4_2 then
    L4_2 = NETWORK
    L4_2 = L4_2.NETWORK_CLAN_PLAYER_GET_DESC
    L5_2 = L3_2
    L6_2 = 35
    L7_2 = L2_2
    L4_2 = L4_2(L5_2, L6_2, L7_2)
    if L4_2 then
      L4_2 = memory
      L4_2 = L4_2.read_int
      L5_2 = L3_2
      L4_2 = L4_2(L5_2)
      L1_2.icon = L4_2
      L4_2 = memory
      L4_2 = L4_2.read_string
      L5_2 = L3_2 + 8
      L4_2 = L4_2(L5_2)
      L1_2.name = L4_2
      L4_2 = memory
      L4_2 = L4_2.read_string
      L5_2 = L3_2 + 136
      L4_2 = L4_2(L5_2)
      L1_2.tag = L4_2
      L4_2 = memory
      L4_2 = L4_2.read_string
      L5_2 = L3_2 + 176
      L4_2 = L4_2(L5_2)
      L1_2.rank = L4_2
      L4_2 = players
      L4_2 = L4_2.clan_get_motto
      L5_2 = A0_2
      L4_2 = L4_2(L5_2)
      L1_2.motto = L4_2
      L4_2 = memory
      L4_2 = L4_2.read_byte
      L5_2 = L3_2 + 160
      L4_2 = L4_2(L5_2)
      if 0 ~= L4_2 then
        L4_2 = "On"
        if L4_2 then
          goto lbl_71
        end
      end
      L4_2 = "Off"
      ::lbl_71::
      L1_2.alt_badge = L4_2
    end
  end
  return L1_2
end
get_player_crew = L2_1
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = setmetatable
  L2_2 = {}
  L3_2 = L1_1
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_NAME
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L1_2.name = L2_2
  L2_2 = players
  L2_2 = L2_2.get_rockstar_id
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L1_2.rid = L2_2
  L2_2 = get_player_crew
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L1_2.crew = L2_2
  L2_2 = intToIp
  L3_2 = players
  L3_2 = L3_2.get_connect_ip
  L4_2 = A0_2
  L3_2, L4_2, L5_2, L6_2, L7_2 = L3_2(L4_2)
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L1_2.ip = L2_2
  L2_2 = json1
  L2_2 = L2_2.stringify
  L3_2 = L1_2
  L4_2 = nil
  L5_2 = 4
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = filesystem
  L3_2 = L3_2.scripts_dir
  L3_2 = L3_2()
  L4_2 = "daidaiScript/profiles/"
  L5_2 = L1_2.name
  L6_2 = ".json"
  L3_2 = L3_2 .. L4_2 .. L5_2 .. L6_2
  L4_2 = filewrite
  L5_2 = L3_2
  L6_2 = "w+"
  L7_2 = L2_2 or L7_2
  if not L2_2 then
    L7_2 = 0
  end
  L4_2(L5_2, L6_2, L7_2)
  L4_2 = notification
  L5_2 = "~y~~bold~信息已保存"
  L6_2 = HudColour
  L6_2 = L6_2.blue
  L4_2(L5_2, L6_2)
end
save_player_info = L2_1
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if 0 ~= L1_2 then
    L2_2 = ENTITY
    L2_2 = L2_2.GET_ENTITY_COORDS
    L3_2 = PLAYER
    L3_2 = L3_2.GET_PLAYER_PED
    L4_2 = A0_2
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2 = L3_2(L4_2)
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
    L3_2 = 1200
    L4_2 = 0.001
    L5_2 = 0.03
    L6_2 = 1
    L7_2 = L3_2
    L8_2 = 1
    for L9_2 = L6_2, L7_2, L8_2 do
      L10_2 = util
      L10_2 = L10_2.yield
      L11_2 = 1.0E-6
      L10_2(L11_2)
      L10_2 = math
      L10_2 = L10_2.rad
      L11_2 = math
      L11_2 = L11_2.random
      L12_2 = 0
      L13_2 = 360
      L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2 = L11_2(L12_2, L13_2)
      L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
      L11_2 = math
      L11_2 = L11_2.cos
      L12_2 = L10_2
      L11_2 = L11_2(L12_2)
      L11_2 = L11_2 * L4_2
      L12_2 = math
      L12_2 = L12_2.sin
      L13_2 = L10_2
      L12_2 = L12_2(L13_2)
      L12_2 = L12_2 * L4_2
      L13_2 = v3
      L14_2 = L2_2.x
      L14_2 = L14_2 + L11_2
      L15_2 = L2_2.y
      L15_2 = L15_2 + L12_2
      L16_2 = L2_2.z
      L13_2 = L13_2(L14_2, L15_2, L16_2)
      L14_2 = FIRE
      L14_2 = L14_2.ADD_EXPLOSION
      L15_2 = L13_2.x
      L16_2 = L13_2.y
      L17_2 = L13_2.z
      L18_2 = 0
      L19_2 = 100
      L20_2 = true
      L21_2 = false
      L22_2 = 0
      L23_2 = false
      L14_2(L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
      L4_2 = L4_2 + L5_2
    end
    L6_2 = util
    L6_2 = L6_2.yield
    L7_2 = 0.001
    L6_2(L7_2)
  end
end
cluster_bomb = L2_1
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if 0 ~= L1_2 then
    L1_2 = PED
    L1_2 = L1_2.IS_PED_IN_ANY_VEHICLE
    L2_2 = PLAYER
    L2_2 = L2_2.GET_PLAYER_PED
    L3_2 = A0_2
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L2_2(L3_2)
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
    if L1_2 then
      L1_2 = PED
      L1_2 = L1_2.GET_VEHICLE_PED_IS_IN
      L2_2 = PLAYER
      L2_2 = L2_2.GET_PLAYER_PED
      L3_2 = A0_2
      L2_2 = L2_2(L3_2)
      L3_2 = false
      L1_2 = L1_2(L2_2, L3_2)
      L2_2 = ENTITY
      L2_2 = L2_2.GET_ENTITY_COORDS
      L3_2 = L1_2
      L4_2 = false
      L2_2 = L2_2(L3_2, L4_2)
      L3_2 = FIRE
      L3_2 = L3_2.ADD_EXPLOSION
      L4_2 = L2_2.x
      L5_2 = L2_2.y
      L6_2 = L2_2.z
      L7_2 = 67
      L8_2 = 1
      L9_2 = true
      L10_2 = false
      L11_2 = 0
      L12_2 = false
      L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
      L3_2 = util
      L3_2 = L3_2.yield
      L4_2 = 100
      L3_2(L4_2)
    end
  end
end
Vehicle_asphalt = L2_1
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2
  L1_2 = PED
  L1_2 = L1_2.GET_VEHICLE_PED_IS_IN
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = false
  L1_2 = L1_2(L2_2, L3_2)
  if nil ~= L1_2 then
    L2_2 = ENTITY
    L2_2 = L2_2.GET_ENTITY_COORDS
    L3_2 = PLAYER
    L3_2 = L3_2.GET_PLAYER_PED
    L4_2 = A0_2
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2 = L3_2(L4_2)
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
    L3_2 = 999999.0
    L4_2 = request_control
    L5_2 = L1_2
    L4_2(L5_2)
    L4_2 = 1
    L5_2 = 1000
    L6_2 = 1
    for L7_2 = L4_2, L5_2, L6_2 do
      L8_2 = math
      L8_2 = L8_2.random
      L9_2 = -L3_2
      L10_2 = L3_2
      L8_2 = L8_2(L9_2, L10_2)
      L9_2 = math
      L9_2 = L9_2.random
      L10_2 = -L3_2
      L11_2 = L3_2
      L9_2 = L9_2(L10_2, L11_2)
      L10_2 = -L3_2
      L11_2 = ENTITY
      L11_2 = L11_2.APPLY_FORCE_TO_ENTITY
      L12_2 = L1_2
      L13_2 = 1
      L14_2 = L2_2.x
      L15_2 = L2_2.y
      L16_2 = L2_2.z
      L17_2 = L8_2
      L18_2 = L9_2
      L19_2 = L10_2
      L20_2 = 0
      L21_2 = true
      L22_2 = true
      L23_2 = true
      L24_2 = false
      L25_2 = true
      L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
      L11_2 = util
      L11_2 = L11_2.yield
      L12_2 = 1
      L11_2(L12_2)
    end
    L4_2 = util
    L4_2 = L4_2.yield
    L5_2 = 1
    L4_2(L5_2)
  end
end
massacre_vehicle = L2_1
L2_1 = {}
function L3_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L0_2 = {}
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "a_c_fish"
  L1_2 = L1_2(L2_2)
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "a_c_stingray"
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2(L3_2)
  L0_2[1] = L1_2
  L0_2[2] = L2_2
  L0_2[3] = L3_2
  L0_2[4] = L4_2
  L0_2[5] = L5_2
  L0_2[6] = L6_2
  L0_2[7] = L7_2
  L0_2[8] = L8_2
  L0_2[9] = L9_2
  L0_2[10] = L10_2
  L0_2[11] = L11_2
  L0_2[12] = L12_2
  L0_2[13] = L13_2
  L0_2[14] = L14_2
  L0_2[15] = L15_2
  L0_2[16] = L16_2
  L0_2[17] = L17_2
  L1_2 = math
  L1_2 = L1_2.random
  L2_2 = #L0_2
  L1_2 = L1_2(L2_2)
  L1_2 = L0_2[L1_2]
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2 = L3_2()
  L4_2 = false
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = L2_2.x
  L4_2 = math
  L4_2 = L4_2.random
  L5_2 = -30
  L6_2 = 30
  L4_2 = L4_2(L5_2, L6_2)
  L3_2 = L3_2 + L4_2
  L2_2.x = L3_2
  L3_2 = L2_2.y
  L4_2 = math
  L4_2 = L4_2.random
  L5_2 = -30
  L6_2 = 30
  L4_2 = L4_2(L5_2, L6_2)
  L3_2 = L3_2 + L4_2
  L2_2.y = L3_2
  L3_2 = L2_2.z
  L3_2 = L3_2 + 50
  L2_2.z = L3_2
  L3_2 = L2_1
  L3_2 = #L3_2
  L4_2 = L3_2 + 1
  L3_2 = L2_1
  L5_2 = create_ped
  L6_2 = 28
  L7_2 = L1_2
  L8_2 = L2_2.x
  L9_2 = L2_2.y
  L10_2 = L2_2.z
  L11_2 = math
  L11_2 = L11_2.random
  L12_2 = 270
  L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L11_2(L12_2)
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L3_2[L4_2] = L5_2
  L3_2 = ENTITY
  L3_2 = L3_2.SET_ENTITY_HEALTH
  L4_2 = L2_1
  L4_2 = #L4_2
  L5_2 = L4_2 + 1
  L4_2 = L2_1
  L4_2 = L4_2[L5_2]
  L5_2 = 0.0
  L6_2 = 1
  L3_2(L4_2, L5_2, L6_2)
  L3_2 = ENTITY
  L3_2 = L3_2.APPLY_FORCE_TO_ENTITY
  L4_2 = L2_1
  L4_2 = #L4_2
  L5_2 = L4_2 + 1
  L4_2 = L2_1
  L4_2 = L4_2[L5_2]
  L5_2 = 1
  L6_2 = 0.0
  L7_2 = 0.0
  L8_2 = 1.0
  L9_2 = 0.0
  L10_2 = 0.0
  L11_2 = 0.0
  L12_2 = 0
  L13_2 = false
  L14_2 = false
  L15_2 = true
  L16_2 = false
  L17_2 = true
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L3_2 = L2_1
  L3_2 = #L3_2
  if L3_2 > 40 then
    L3_2 = delete_entity
    L4_2 = L2_1
    L4_2 = L4_2[1]
    L3_2(L4_2)
    L3_2 = table
    L3_2 = L3_2.remove
    L4_2 = L2_1
    L5_2 = 1
    L3_2(L4_2, L5_2)
  end
  L3_2 = util
  L3_2 = L3_2.yield
  L4_2 = 200
  L3_2(L4_2)
end
fish_rain = L3_1
function L3_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = ipairs
  L1_2 = entities
  L1_2 = L1_2.get_all_peds_as_handles
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L1_2()
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = PED
    L6_2 = L6_2.IS_PED_A_PLAYER
    L7_2 = L5_2
    L6_2 = L6_2(L7_2)
    if not L6_2 then
      L6_2 = PED
      L6_2 = L6_2.GET_VEHICLE_PED_IS_IN
      L7_2 = L5_2
      L8_2 = true
      L6_2 = L6_2(L7_2, L8_2)
      if 0 ~= L6_2 then
        L7_2 = VEHICLE
        L7_2 = L7_2.GET_PED_IN_VEHICLE_SEAT
        L8_2 = L6_2
        L9_2 = -1
        L7_2 = L7_2(L8_2, L9_2)
        if L7_2 == L5_2 then
          L7_2 = request_control
          L8_2 = L5_2
          L7_2(L8_2)
          L7_2 = TASK
          L7_2 = L7_2.SET_DRIVE_TASK_DRIVING_STYLE
          L8_2 = L5_2
          L9_2 = 1471
          L7_2(L8_2, L9_2)
        end
      end
    end
  end
end
force_npc_reverse_travel = L3_1
function L3_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = {}
  L0_2.x = -914.1707
  L0_2.y = -1164.9396
  L0_2.z = 250
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "jet"
  L1_2 = L1_2(L2_2)
  L2_2 = request_model
  L3_2 = L1_2
  L2_2(L3_2)
  L2_2 = create_vehicle
  L3_2 = L1_2
  L4_2 = L0_2.x
  L5_2 = L0_2.y
  L6_2 = L0_2.z
  L7_2 = -68
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L3_2 = VEHICLE
  L3_2 = L3_2.SET_HELI_BLADES_FULL_SPEED
  L4_2 = L2_2
  L3_2(L4_2)
  L3_2 = VEHICLE
  L3_2 = L3_2.SET_VEHICLE_ENGINE_ON
  L4_2 = L2_2
  L5_2 = true
  L6_2 = true
  L7_2 = false
  L3_2(L4_2, L5_2, L6_2, L7_2)
  L3_2 = VEHICLE
  L3_2 = L3_2.CONTROL_LANDING_GEAR
  L4_2 = L2_2
  L5_2 = 3
  L3_2(L4_2, L5_2)
  L3_2 = VEHICLE
  L3_2 = L3_2.SET_PLANE_TURBULENCE_MULTIPLIER
  L4_2 = L2_2
  L5_2 = 0.0
  L3_2(L4_2, L5_2)
  L3_2 = 1
  L4_2 = 5
  L5_2 = 1
  for L6_2 = L3_2, L4_2, L5_2 do
    L7_2 = VEHICLE
    L7_2 = L7_2.SET_VEHICLE_FORWARD_SPEED
    L8_2 = L2_2
    L9_2 = 150.0
    L7_2(L8_2, L9_2)
    L7_2 = util
    L7_2 = L7_2.yield
    L8_2 = 1000
    L7_2(L8_2)
  end
end
attacks_911 = L3_1
function L3_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L3_2 = TASK
  L3_2 = L3_2.SET_TASK_VEHICLE_CHASE_BEHAVIOR_FLAG
  L4_2 = A0_2
  L5_2 = 1
  L6_2 = true
  L3_2(L4_2, L5_2, L6_2)
  L3_2 = TASK
  L4_2 = "SET_TASK_VEHICLE_CHASE_IDEAL_PURSUIT_DISTANCE"
  L3_2 = L3_2[L4_2]
  L4_2 = A0_2
  L5_2 = 10.0
  L3_2(L4_2, L5_2)
  while A0_2 do
    L3_2 = ENTITY
    L3_2 = L3_2.DOES_ENTITY_EXIST
    L4_2 = A2_2
    L3_2 = L3_2(L4_2)
    if L3_2 then
      L3_2 = ENTITY
      L3_2 = L3_2.DOES_ENTITY_EXIST
      L4_2 = A0_2
      L3_2 = L3_2(L4_2)
      if L3_2 then
        L3_2 = ENTITY
        L3_2 = L3_2.GET_ENTITY_HEALTH
        L4_2 = A2_2
        L3_2 = L3_2(L4_2)
        if 0 ~= L3_2 then
          goto lbl_34
        end
      end
    end
    do return end
    ::lbl_34::
    L3_2 = ENTITY
    L3_2 = L3_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
    L4_2 = A1_2
    L5_2 = math
    L5_2 = L5_2.random
    L6_2 = -5
    L7_2 = 5
    L5_2 = L5_2(L6_2, L7_2)
    L6_2 = math
    L6_2 = L6_2.random
    L7_2 = -5
    L8_2 = 5
    L6_2 = L6_2(L7_2, L8_2)
    L7_2 = 0.0
    L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
    L4_2 = ENTITY
    L4_2 = L4_2.GET_ENTITY_COORDS
    L5_2 = A2_2
    L4_2 = L4_2(L5_2)
    L5_2 = MISC
    L5_2 = L5_2.GET_DISTANCE_BETWEEN_COORDS
    L6_2 = L3_2.x
    L7_2 = L3_2.y
    L8_2 = L3_2.z
    L9_2 = L4_2.x
    L10_2 = L4_2.y
    L11_2 = L4_2.z
    L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    if L5_2 >= 10 then
      L5_2 = ENTITY
      L5_2 = L5_2.SET_ENTITY_COORDS
      L6_2 = A2_2
      L7_2 = L3_2.x
      L8_2 = L3_2.y
      L9_2 = L3_2.z
      L5_2(L6_2, L7_2, L8_2, L9_2)
      L5_2 = ENTITY
      L5_2 = L5_2.SET_ENTITY_HEADING
      L6_2 = A2_2
      L7_2 = ENTITY
      L7_2 = L7_2.GET_ENTITY_HEADING
      L8_2 = A1_2
      L7_2 = L7_2(L8_2)
      L7_2 = L7_2 + 90
      L5_2(L6_2, L7_2)
    end
    L5_2 = TASK
    L5_2 = L5_2.TASK_VEHICLE_SHOOT_AT_PED
    L6_2 = A0_2
    L7_2 = A1_2
    L8_2 = 1.0
    L5_2(L6_2, L7_2, L8_2)
    L5_2 = util
    L5_2 = L5_2.yield
    L6_2 = 3000
    L5_2(L6_2)
  end
end
firefighter_thread = L3_1
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "firetruk"
  L1_2 = L1_2(L2_2)
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "S_M_Y_Fireman_01"
  L2_2 = L2_2(L3_2)
  L3_2 = PLAYER
  L3_2 = L3_2.GET_PLAYER_PED
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = ENTITY
  L4_2 = L4_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L5_2 = L3_2
  L6_2 = math
  L6_2 = L6_2.random
  L7_2 = -5
  L8_2 = 5
  L6_2 = L6_2(L7_2, L8_2)
  L7_2 = math
  L7_2 = L7_2.random
  L8_2 = -5
  L9_2 = 5
  L7_2 = L7_2(L8_2, L9_2)
  L8_2 = 0.0
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  L5_2 = create_vehicle
  L6_2 = L1_2
  L7_2 = L4_2.x
  L8_2 = L4_2.y
  L9_2 = L4_2.z
  L10_2 = ENTITY
  L10_2 = L10_2.GET_ENTITY_HEADING
  L11_2 = L3_2
  L10_2, L11_2, L12_2, L13_2 = L10_2(L11_2)
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L6_2 = VEHICLE
  L6_2 = L6_2.SET_VEHICLE_SIREN
  L7_2 = L5_2
  L8_2 = true
  L6_2(L7_2, L8_2)
  L6_2 = ENTITY
  L6_2 = L6_2.SET_ENTITY_HEADING
  L7_2 = L5_2
  L8_2 = ENTITY
  L8_2 = L8_2.GET_ENTITY_HEADING
  L9_2 = L3_2
  L8_2 = L8_2(L9_2)
  L8_2 = L8_2 + 90
  L6_2(L7_2, L8_2)
  L6_2 = VEHICLE
  L6_2 = L6_2.SET_VEHICLE_ENGINE_ON
  L7_2 = L5_2
  L8_2 = true
  L9_2 = true
  L10_2 = false
  L6_2(L7_2, L8_2, L9_2, L10_2)
  L6_2 = VEHICLE
  L6_2 = L6_2.SET_VEHICLE_WEAPON_CAN_TARGET_OBJECTS
  L7_2 = L5_2
  L8_2 = true
  L6_2(L7_2, L8_2)
  L6_2 = VEHICLE
  L6_2 = L6_2.SET_VEHICLE_DOORS_LOCKED
  L7_2 = L5_2
  L8_2 = 2
  L6_2(L7_2, L8_2)
  L6_2 = create_ped
  L7_2 = 1
  L8_2 = L2_2
  L9_2 = L4_2.x
  L10_2 = L4_2.y
  L11_2 = L4_2.z
  L12_2 = ENTITY
  L12_2 = L12_2.GET_ENTITY_HEADING
  L13_2 = L3_2
  L12_2, L13_2 = L12_2(L13_2)
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L7_2 = PED
  L7_2 = L7_2.SET_PED_COMBAT_ATTRIBUTES
  L8_2 = L6_2
  L9_2 = 5
  L10_2 = true
  L7_2(L8_2, L9_2, L10_2)
  L7_2 = PED
  L7_2 = L7_2.SET_PED_FLEE_ATTRIBUTES
  L8_2 = L6_2
  L9_2 = 0
  L10_2 = false
  L7_2(L8_2, L9_2, L10_2)
  L7_2 = PED
  L7_2 = L7_2.SET_PED_COMBAT_ATTRIBUTES
  L8_2 = L6_2
  L9_2 = 46
  L10_2 = true
  L7_2(L8_2, L9_2, L10_2)
  L7_2 = TASK
  L7_2 = L7_2.TASK_COMBAT_PED
  L8_2 = L6_2
  L9_2 = L3_2
  L10_2 = 0
  L11_2 = 16
  L7_2(L8_2, L9_2, L10_2, L11_2)
  L7_2 = PED
  L7_2 = L7_2.SET_PED_INTO_VEHICLE
  L8_2 = L6_2
  L9_2 = L5_2
  L10_2 = -1
  L7_2(L8_2, L9_2, L10_2)
  L7_2 = TASK
  L7_2 = L7_2.SET_TASK_VEHICLE_CHASE_BEHAVIOR_FLAG
  L8_2 = L6_2
  L9_2 = 1
  L10_2 = true
  L7_2(L8_2, L9_2, L10_2)
  L7_2 = TASK
  L8_2 = "SET_TASK_VEHICLE_CHASE_IDEAL_PURSUIT_DISTANCE"
  L7_2 = L7_2[L8_2]
  L8_2 = L6_2
  L9_2 = 10.0
  L7_2(L8_2, L9_2)
  L7_2 = TASK
  L7_2 = L7_2.TASK_VEHICLE_CHASE
  L8_2 = L6_2
  L9_2 = L3_2
  L7_2(L8_2, L9_2)
  L7_2 = firefighter_thread
  L8_2 = L6_2
  L9_2 = L3_2
  L10_2 = L5_2
  L7_2(L8_2, L9_2, L10_2)
  L7_2 = ENTITY
  L7_2 = L7_2.SET_ENTITY_INVINCIBLE
  L8_2 = L6_2
  L9_2 = true
  L7_2(L8_2, L9_2)
  L7_2 = ENTITY
  L7_2 = L7_2.SET_ENTITY_INVINCIBLE
  L8_2 = L5_2
  L9_2 = true
  L7_2(L8_2, L9_2)
end
Firetruck_attack = L3_1
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED_SCRIPT_INDEX
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = get_random_offset_from_entity
  L3_2 = L1_2
  L4_2 = 50.0
  L5_2 = 60.0
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = v3
  L3_2 = L3_2.new
  L3_2 = L3_2()
  L4_2 = memory
  L4_2 = L4_2.alloc
  L5_2 = 4
  L4_2 = L4_2(L5_2)
  L5_2 = PATHFIND
  L5_2 = L5_2.GET_CLOSEST_VEHICLE_NODE_WITH_HEADING
  L6_2 = L2_2.x
  L7_2 = L2_2.y
  L8_2 = L2_2.z
  L9_2 = L3_2
  L10_2 = L4_2
  L11_2 = 1
  L12_2 = 3.0
  L13_2 = 0
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  if L5_2 then
    L5_2 = util
    L5_2 = L5_2.joaat
    L6_2 = "police3"
    L5_2 = L5_2(L6_2)
    L6_2 = util
    L6_2 = L6_2.joaat
    L7_2 = "s_m_y_cop_01"
    L6_2 = L6_2(L7_2)
    L7_2 = request_model
    L8_2 = L5_2
    L7_2(L8_2)
    L7_2 = request_model
    L8_2 = L6_2
    L7_2(L8_2)
    L7_2 = ENTITY
    L7_2 = L7_2.GET_ENTITY_COORDS
    L8_2 = L1_2
    L9_2 = false
    L7_2 = L7_2(L8_2, L9_2)
    L8_2 = entities
    L8_2 = L8_2.create_vehicle
    L9_2 = L5_2
    L10_2 = L7_2
    L11_2 = 0.0
    L8_2 = L8_2(L9_2, L10_2, L11_2)
    L9_2 = ENTITY
    L9_2 = L9_2.DOES_ENTITY_EXIST
    L10_2 = L8_2
    L9_2 = L9_2(L10_2)
    if not L9_2 then
      return
    end
    L9_2 = ENTITY
    L9_2 = L9_2.SET_ENTITY_COORDS
    L10_2 = L8_2
    L11_2 = L3_2.x
    L12_2 = L3_2.y
    L13_2 = L3_2.z
    L14_2 = false
    L15_2 = false
    L16_2 = false
    L17_2 = false
    L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
    L9_2 = ENTITY
    L9_2 = L9_2.SET_ENTITY_HEADING
    L10_2 = L8_2
    L11_2 = memory
    L11_2 = L11_2.read_float
    L12_2 = L4_2
    L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L11_2(L12_2)
    L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
    L9_2 = VEHICLE
    L9_2 = L9_2.SET_VEHICLE_SIREN
    L10_2 = L8_2
    L11_2 = true
    L9_2(L10_2, L11_2)
    L9_2 = AUDIO
    L9_2 = L9_2.BLIP_SIREN
    L10_2 = L8_2
    L9_2(L10_2)
    L9_2 = VEHICLE
    L9_2 = L9_2.SET_VEHICLE_ENGINE_ON
    L10_2 = L8_2
    L11_2 = true
    L12_2 = true
    L13_2 = true
    L9_2(L10_2, L11_2, L12_2, L13_2)
    L9_2 = ENTITY
    L9_2 = L9_2.SET_ENTITY_INVINCIBLE
    L10_2 = L8_2
    L11_2 = true
    L9_2(L10_2, L11_2)
    L9_2 = memory
    L9_2 = L9_2.alloc_int
    L9_2 = L9_2()
    L10_2 = TASK
    L10_2 = L10_2.OPEN_SEQUENCE_TASK
    L11_2 = L9_2
    L10_2(L11_2)
    L10_2 = TASK
    L10_2 = L10_2.TASK_COMBAT_PED
    L11_2 = 0
    L12_2 = L1_2
    L13_2 = 0
    L14_2 = 16
    L10_2(L11_2, L12_2, L13_2, L14_2)
    L10_2 = TASK
    L10_2 = L10_2.TASK_GO_TO_ENTITY
    L11_2 = 0
    L12_2 = L1_2
    L13_2 = 6000
    L14_2 = 10.0
    L15_2 = 3.0
    L16_2 = 0.0
    L17_2 = 0
    L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
    L10_2 = TASK
    L10_2 = L10_2.SET_SEQUENCE_TO_REPEAT
    L11_2 = memory
    L11_2 = L11_2.read_int
    L12_2 = L9_2
    L11_2 = L11_2(L12_2)
    L12_2 = true
    L10_2(L11_2, L12_2)
    L10_2 = TASK
    L10_2 = L10_2.CLOSE_SEQUENCE_TASK
    L11_2 = memory
    L11_2 = L11_2.read_int
    L12_2 = L9_2
    L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L11_2(L12_2)
    L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
    L10_2 = -1
    L11_2 = 0
    L12_2 = 1
    for L13_2 = L10_2, L11_2, L12_2 do
      L14_2 = entities
      L14_2 = L14_2.create_ped
      L15_2 = 5
      L16_2 = L6_2
      L17_2 = L3_2
      L18_2 = 0.0
      L14_2 = L14_2(L15_2, L16_2, L17_2, L18_2)
      L15_2 = ENTITY
      L15_2 = L15_2.SET_ENTITY_AS_MISSION_ENTITY
      L16_2 = L14_2
      L17_2 = true
      L18_2 = false
      L15_2(L16_2, L17_2, L18_2)
      L15_2 = set_decor_flag
      L16_2 = L14_2
      L17_2 = DecorFlag_isAttacker
      L15_2(L16_2, L17_2)
      L15_2 = PED
      L15_2 = L15_2.SET_PED_INTO_VEHICLE
      L16_2 = L14_2
      L17_2 = L8_2
      L18_2 = L13_2
      L15_2(L16_2, L17_2, L18_2)
      L15_2 = PED
      L15_2 = L15_2.SET_PED_RANDOM_COMPONENT_VARIATION
      L16_2 = L14_2
      L17_2 = 0
      L15_2(L16_2, L17_2)
      if -1 == L13_2 then
        L15_2 = "weapon_pistol"
        if L15_2 then
          goto lbl_179
        end
      end
      L15_2 = "weapon_pumpshotgun"
      ::lbl_179::
      L16_2 = WEAPON
      L16_2 = L16_2.GIVE_WEAPON_TO_PED
      L17_2 = L14_2
      L18_2 = util
      L18_2 = L18_2.joaat
      L19_2 = L15_2
      L18_2 = L18_2(L19_2)
      L19_2 = -1
      L20_2 = false
      L21_2 = true
      L16_2(L17_2, L18_2, L19_2, L20_2, L21_2)
      L16_2 = PED
      L16_2 = L16_2.SET_PED_COMBAT_ATTRIBUTES
      L17_2 = L14_2
      L18_2 = 1
      L19_2 = true
      L16_2(L17_2, L18_2, L19_2)
      L16_2 = PED
      L16_2 = L16_2.SET_PED_AS_COP
      L17_2 = L14_2
      L18_2 = true
      L16_2(L17_2, L18_2)
      L16_2 = ENTITY
      L16_2 = L16_2.SET_ENTITY_INVINCIBLE
      L17_2 = L14_2
      L18_2 = true
      L16_2(L17_2, L18_2)
      L16_2 = TASK
      L16_2 = L16_2.TASK_PERFORM_SEQUENCE
      L17_2 = L14_2
      L18_2 = memory
      L18_2 = L18_2.read_int
      L19_2 = L9_2
      L18_2, L19_2, L20_2, L21_2 = L18_2(L19_2)
      L16_2(L17_2, L18_2, L19_2, L20_2, L21_2)
    end
    L10_2 = TASK
    L10_2 = L10_2.CLEAR_SEQUENCE_TASK
    L11_2 = L9_2
    L10_2(L11_2)
    L10_2 = AUDIO
    L10_2 = L10_2.PLAY_POLICE_REPORT
    L11_2 = "SCRIPTED_SCANNER_REPORT_FRANLIN_0_KIDNAP"
    L12_2 = 0.0
    L10_2(L11_2, L12_2)
  end
end
spawn_police_car = L3_1
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = PED
  L1_2 = L1_2.GET_VEHICLE_PED_IS_IN
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = false
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = request_control
  L3_2 = L1_2
  L2_2(L3_2)
  L2_2 = VEHICLE
  L2_2 = L2_2.GET_NUMBER_OF_VEHICLE_DOORS
  L3_2 = L1_2
  L2_2 = L2_2(L3_2)
  L3_2 = VEHICLE
  L3_2 = L3_2.POP_OUT_VEHICLE_WINDSCREEN
  L4_2 = L1_2
  L3_2(L4_2)
  L3_2 = 0
  L4_2 = L2_2
  L5_2 = 1
  for L6_2 = L3_2, L4_2, L5_2 do
    L7_2 = VEHICLE
    L7_2 = L7_2.SET_VEHICLE_DOOR_BROKEN
    L8_2 = L1_2
    L9_2 = L6_2
    L10_2 = false
    L7_2(L8_2, L9_2, L10_2)
  end
  L3_2 = 0
  L4_2 = 5
  L5_2 = 1
  for L6_2 = L3_2, L4_2, L5_2 do
    L7_2 = entities
    L7_2 = L7_2.detach_wheel
    L8_2 = entities
    L8_2 = L8_2.handle_to_pointer
    L9_2 = L1_2
    L8_2 = L8_2(L9_2)
    L9_2 = L6_2
    L7_2(L8_2, L9_2)
  end
end
detach_vehicle_parts = L3_1
function L3_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L0_2 = 2825402133
  L1_2 = 3268439891
  L2_2 = ENTITY
  L2_2 = L2_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2 = L3_2()
  L4_2 = 0
  L5_2 = -2
  L6_2 = 0
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  L3_2 = change_model
  L4_2 = PLAYER
  L4_2 = L4_2.PLAYER_ID
  L4_2 = L4_2()
  L5_2 = L1_2
  L3_2(L4_2, L5_2)
  L3_2 = 1
  L4_2 = 5
  L5_2 = 1
  for L6_2 = L3_2, L4_2, L5_2 do
    L7_2 = create_ped
    L8_2 = 28
    L9_2 = L0_2
    L10_2 = L2_2.x
    L11_2 = L2_2.y
    L12_2 = L2_2.z
    L13_2 = 72
    L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
    L8_2 = join_group
    L9_2 = L7_2
    L8_2(L9_2)
  end
end
monkey_king = L3_1
function L3_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = PED
  L0_2 = L0_2.IS_PED_SHOOTING
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
  if L0_2 then
    L0_2 = get_entity_player_is_aiming_at
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_ID
    L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2 = L1_2()
    L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    L1_2 = NULL
    if L0_2 ~= L1_2 then
      L1_2 = ENTITY
      L1_2 = L1_2.IS_ENTITY_A_VEHICLE
      L2_2 = L0_2
      L1_2 = L1_2(L2_2)
      if L1_2 then
        L1_2 = request_control
        L2_2 = L0_2
        L1_2 = L1_2(L2_2)
        if L1_2 then
          L1_2 = random_colour
          L1_2 = L1_2()
          L2_2 = random_colour
          L2_2 = L2_2()
          L3_2 = VEHICLE
          L3_2 = L3_2.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR
          L4_2 = L0_2
          L5_2 = L1_2.r
          L6_2 = L1_2.g
          L7_2 = L1_2.b
          L3_2(L4_2, L5_2, L6_2, L7_2)
          L3_2 = VEHICLE
          L3_2 = L3_2.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR
          L4_2 = L0_2
          L5_2 = L2_2.r
          L6_2 = L2_2.g
          L7_2 = L2_2.b
          L3_2(L4_2, L5_2, L6_2, L7_2)
        end
      end
    end
  end
end
Paintball_gun = L3_1
L3_1 = {}
L4_1 = 0
L5_1 = 7
L6_1 = 1
for L7_1 = L4_1, L5_1, L6_1 do
  L8_1 = directx
  L8_1 = L8_1.create_texture
  L9_1 = filesystem
  L9_1 = L9_1.resources_dir
  L9_1 = L9_1()
  L10_1 = "\\SakuraImg\\speedometer\\"
  L11_1 = "/gear_"
  L12_1 = tostring
  L13_1 = L7_1
  L12_1 = L12_1(L13_1)
  L13_1 = ".png"
  L9_1 = L9_1 .. L10_1 .. L11_1 .. L12_1 .. L13_1
  L8_1 = L8_1(L9_1)
  L3_1[L7_1] = L8_1
end
L4_1 = {}
L5_1 = 0
L6_1 = 9
L7_1 = 1
for L8_1 = L5_1, L6_1, L7_1 do
  L9_1 = directx
  L9_1 = L9_1.create_texture
  L10_1 = filesystem
  L10_1 = L10_1.resources_dir
  L10_1 = L10_1()
  L11_1 = "\\SakuraImg\\speedometer\\"
  L12_1 = "/mph_"
  L13_1 = tostring
  L14_1 = L8_1
  L13_1 = L13_1(L14_1)
  L14_1 = ".png"
  L10_1 = L10_1 .. L11_1 .. L12_1 .. L13_1 .. L14_1
  L9_1 = L9_1(L10_1)
  L4_1[L8_1] = L9_1
end
L5_1 = directx
L5_1 = L5_1.create_texture
L6_1 = filesystem
L6_1 = L6_1.resources_dir
L6_1 = L6_1()
L7_1 = "\\SakuraImg\\speedometer\\"
L8_1 = "/dial.png"
L6_1 = L6_1 .. L7_1 .. L8_1
L5_1 = L5_1(L6_1)
L6_1 = directx
L6_1 = L6_1.create_texture
L7_1 = filesystem
L7_1 = L7_1.resources_dir
L7_1 = L7_1()
L8_1 = "\\SakuraImg\\speedometer\\"
L9_1 = "/needle.png"
L7_1 = L7_1 .. L8_1 .. L9_1
L6_1 = L6_1(L7_1)
L7_1 = directx
L7_1 = L7_1.create_texture
L8_1 = filesystem
L8_1 = L8_1.resources_dir
L8_1 = L8_1()
L9_1 = "\\SakuraImg\\speedometer\\"
L10_1 = "/kph_label.png"
L8_1 = L8_1 .. L9_1 .. L10_1
L7_1 = L7_1(L8_1)
L8_1 = 0.84
L9_1 = 0.75
function L10_1(A0_2)
  local L1_2
  L1_2 = A0_2 / 100
  L8_1 = L1_2
end
speedometer_X = L10_1
function L10_1(A0_2)
  local L1_2
  L1_2 = A0_2 / 100
  L9_1 = L1_2
end
speedometer_Y = L10_1
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2
  L0_2 = entities
  L0_2 = L0_2.get_user_vehicle_as_pointer
  L1_2 = false
  L0_2 = L0_2(L1_2)
  L1_2 = entities
  L1_2 = L1_2.pointer_to_handle
  L2_2 = L0_2
  L1_2 = L1_2(L2_2)
  if 0 ~= L0_2 then
    L2_2 = entities
    L2_2 = L2_2.get_rpm
    L3_2 = L0_2
    L2_2 = L2_2(L3_2)
    L3_2 = math
    L3_2 = L3_2.rad
    L4_2 = 90.18
    L3_2 = L3_2(L4_2)
    L4_2 = L2_2 / 1
    L4_2 = L4_2 / 1.485
    L4_2 = L4_2 - 0.17
    L5_2 = entities
    L5_2 = L5_2.get_current_gear
    L6_2 = L0_2
    L5_2 = L5_2(L6_2)
    L6_2 = directx
    L6_2 = L6_2.draw_texture
    L7_2 = L5_1
    L8_2 = 0.08
    L9_2 = 0.08
    L10_2 = 0.5
    L11_2 = 0.5
    L12_2 = L8_1
    L13_2 = L9_1
    L13_2 = L13_2 - 0.004
    L14_2 = 0
    L15_2 = 1.0
    L16_2 = 1.0
    L17_2 = 1.0
    L18_2 = 1.0
    L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L6_2 = directx
    L6_2 = L6_2.draw_texture
    L7_2 = L6_1
    L8_2 = 0.08
    L9_2 = 0.08
    L10_2 = 0.5
    L11_2 = 0.5
    L12_2 = L8_1
    L13_2 = L9_1
    L14_2 = L4_2
    L15_2 = 1.0
    L16_2 = 1.0
    L17_2 = 1.0
    L18_2 = 0.5
    L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    if L5_2 < 8 then
      L6_2 = directx
      L6_2 = L6_2.draw_texture
      L7_2 = L3_1
      L7_2 = L7_2[L5_2]
      L8_2 = 0.08
      L9_2 = 0.08
      L10_2 = 0.5
      L11_2 = 0.5
      L12_2 = L8_1
      L12_2 = L12_2 - 1.0E-4
      L13_2 = L9_1
      L13_2 = L13_2 - 0.005
      L14_2 = 0
      L15_2 = 1
      L16_2 = 1
      L17_2 = 1
      L18_2 = 1
      L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    else
      L6_2 = directx
      L6_2 = L6_2.draw_texture
      L7_2 = L3_1
      L7_2 = L7_2[7]
      L8_2 = 0.08
      L9_2 = 0.08
      L10_2 = 0.5
      L11_2 = 0.5
      L12_2 = L8_1
      L12_2 = L12_2 - 1.0E-4
      L13_2 = L9_1
      L13_2 = L13_2 - 0.005
      L14_2 = 0
      L15_2 = 1
      L16_2 = 1
      L17_2 = 1
      L18_2 = 1
      L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    end
    L6_2 = math
    L6_2 = L6_2.ceil
    L7_2 = ENTITY
    L7_2 = L7_2.GET_ENTITY_SPEED
    L8_2 = L1_2
    L7_2 = L7_2(L8_2)
    L7_2 = L7_2 * 3.6
    L6_2 = L6_2(L7_2)
    L7_2 = tostring
    L8_2 = L6_2
    L7_2 = L7_2(L8_2)
    L8_2 = 0
    L9_2 = 1
    L10_2 = #L7_2
    L11_2 = 1
    for L12_2 = L9_2, L10_2, L11_2 do
      L13_2 = directx
      L13_2 = L13_2.draw_texture
      L14_2 = tonumber
      L16_2 = L7_2
      L15_2 = L7_2.sub
      L17_2 = L12_2
      L18_2 = L12_2
      L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2 = L15_2(L16_2, L17_2, L18_2)
      L14_2 = L14_2(L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
      L15_2 = L4_1
      L14_2 = L15_2[L14_2]
      L15_2 = 0.06
      L16_2 = 0.06
      L17_2 = 0.5
      L18_2 = 0.5
      L19_2 = L8_1
      L19_2 = L19_2 + L8_2
      L20_2 = L9_1
      L20_2 = L20_2 + 0.1
      L21_2 = 0
      L22_2 = 1.0
      L23_2 = 1.0
      L24_2 = 1.0
      L25_2 = 1
      L13_2(L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
      L8_2 = L8_2 + 0.03
    end
    L8_2 = L8_2 + 0.011
    L9_2 = directx
    L9_2 = L9_2.draw_texture
    L10_2 = L7_1
    L11_2 = 0.06
    L12_2 = 0.06
    L13_2 = 0.5
    L14_2 = 0.5
    L15_2 = L8_1
    L15_2 = L15_2 + L8_2
    L16_2 = L9_1
    L16_2 = L16_2 + 0.13
    L17_2 = 0
    L18_2 = 1.0
    L19_2 = 1.0
    L20_2 = 1.0
    L21_2 = 1
    L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
  end
end
speedometer = L10_1
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = pairs
  L1_2 = entities
  L1_2 = L1_2.get_all_objects_as_handles
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L1_2()
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = is_entity_a_projectile
    L7_2 = ENTITY
    L7_2 = L7_2.GET_ENTITY_MODEL
    L8_2 = L5_2
    L7_2, L8_2, L9_2 = L7_2(L8_2)
    L6_2 = L6_2(L7_2, L8_2, L9_2)
    if L6_2 then
      L6_2 = HUD
      L6_2 = L6_2.GET_BLIP_FROM_ENTITY
      L7_2 = L5_2
      L6_2 = L6_2(L7_2)
      if 0 == L6_2 then
        L6_2 = HUD
        L6_2 = L6_2.ADD_BLIP_FOR_ENTITY
        L7_2 = L5_2
        L6_2 = L6_2(L7_2)
        L7_2 = HUD
        L7_2 = L7_2.SET_BLIP_SPRITE
        L8_2 = L6_2
        L9_2 = 443
        L7_2(L8_2, L9_2)
        L7_2 = HUD
        L7_2 = L7_2.SET_BLIP_COLOUR
        L8_2 = L6_2
        L9_2 = 75
        L7_2(L8_2, L9_2)
      end
    end
  end
end
Missile_radar = L10_1
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2
  L0_2 = directx
  L0_2 = L0_2.create_texture
  L1_2 = filesystem
  L1_2 = L1_2.scripts_dir
  L1_2 = L1_2()
  L2_2 = "\\daidaiScript\\"
  L3_2 = "\\flightredux\\"
  L4_2 = "contact.png"
  L1_2 = L1_2 .. L2_2 .. L3_2 .. L4_2
  L0_2 = L0_2(L1_2)
  L1_2 = pairs
  L2_2 = entities
  L2_2 = L2_2.get_all_vehicles_as_handles
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L2_2()
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = ENTITY
    L7_2 = L7_2.GET_ENTITY_MODEL
    L8_2 = L6_2
    L7_2 = L7_2(L8_2)
    L8_2 = ENTITY
    L8_2 = L8_2.GET_ENTITY_HEALTH
    L9_2 = L6_2
    L8_2 = L8_2(L9_2)
    if L8_2 > 0 then
      L8_2 = ENTITY
      L8_2 = L8_2.GET_ENTITY_COORDS
      L9_2 = L6_2
      L8_2 = L8_2(L9_2)
      L9_2 = world_to_screen_coords
      L10_2 = L8_2.x
      L11_2 = L8_2.y
      L12_2 = L8_2.z
      L9_2 = L9_2(L10_2, L11_2, L12_2)
      L10_2 = directx
      L10_2 = L10_2.draw_texture
      L11_2 = L0_2
      L12_2 = 0.005
      L13_2 = 0.005
      L14_2 = 0.5
      L15_2 = 0.5
      L16_2 = L9_2.x
      L17_2 = L9_2.y
      L18_2 = 0
      L19_2 = 0
      L20_2 = 100
      L21_2 = 0
      L22_2 = 100
      L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
    end
  end
end
Vehicle_identify = L10_1
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L0_2 = PLAYER
  L0_2 = L0_2.GET_PLAYERS_LAST_VEHICLE
  L0_2 = L0_2()
  if 0 ~= L0_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = 0.0
    L4_2 = 5.0
    L5_2 = 0.0
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2)
    L2_2 = -67533719
    L3_2 = request_model
    L4_2 = L2_2
    L3_2(L4_2)
    L3_2 = entities
    L3_2 = L3_2.create_ped
    L4_2 = 32
    L5_2 = L2_2
    L6_2 = L1_2
    L7_2 = ENTITY
    L7_2 = L7_2.GET_ENTITY_HEADING
    L8_2 = PLAYER
    L8_2 = L8_2.PLAYER_PED_ID
    L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L8_2()
    L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
    L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
    L4_2 = ENTITY
    L4_2 = L4_2.SET_ENTITY_VISIBLE
    L5_2 = L3_2
    L6_2 = false
    L7_2 = false
    L4_2(L5_2, L6_2, L7_2)
    L4_2 = HUD
    L4_2 = L4_2.ADD_BLIP_FOR_ENTITY
    L5_2 = L0_2
    L4_2 = L4_2(L5_2)
    L5_2 = HUD
    L5_2 = L5_2.SET_BLIP_COLOUR
    L6_2 = L4_2
    L7_2 = 7
    L5_2(L6_2, L7_2)
    L5_2 = PED
    L5_2 = L5_2.SET_PED_INTO_VEHICLE
    L6_2 = L3_2
    L7_2 = L0_2
    L8_2 = -1
    L5_2(L6_2, L7_2, L8_2)
    L5_2 = TASK
    L5_2 = L5_2.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE
    L6_2 = L3_2
    L7_2 = L0_2
    L8_2 = L1_2.x
    L9_2 = L1_2.y
    L10_2 = L1_2.z
    L11_2 = 50
    L12_2 = 786996
    L13_2 = 5
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
    while L3_2 do
      L5_2 = PED
      L5_2 = L5_2.IS_PED_GETTING_INTO_A_VEHICLE
      L6_2 = PLAYER
      L6_2 = L6_2.PLAYER_PED_ID
      L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L6_2()
      L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
      if L5_2 then
        L5_2 = PED
        L5_2 = L5_2.GET_VEHICLE_PED_IS_ENTERING
        L6_2 = PLAYER
        L6_2 = L6_2.PLAYER_PED_ID
        L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L6_2()
        L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
        if L5_2 == L0_2 then
          L6_2 = delete_entity
          L7_2 = L3_2
          L6_2(L7_2)
          L6_2 = util
          L6_2 = L6_2.remove_blip
          L7_2 = L4_2
          L6_2(L7_2)
          break
        end
      end
      L5_2 = util
      L5_2 = L5_2.yield
      L5_2()
    end
  end
end
recall_vehicle = L10_1
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L0_2 = filesystem
  L0_2 = L0_2.scripts_dir
  L0_2 = L0_2()
  L1_2 = "daidaiScript/Outfits/A-test.txt"
  L0_2 = L0_2 .. L1_2
  L1_2 = fileread
  L2_2 = L0_2
  L3_2 = "r"
  L4_2 = "*all"
  L1_2 = L1_2(L2_2, L3_2, L4_2)
  if "" ~= L1_2 then
    L2_2 = filewrite
    L3_2 = L0_2
    L4_2 = "w+"
    L5_2 = ""
    L2_2(L3_2, L4_2, L5_2)
  end
  L2_2 = 0
  L3_2 = 11
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = PED
    L6_2 = L6_2.GET_PED_DRAWABLE_VARIATION
    L7_2 = PLAYER
    L7_2 = L7_2.PLAYER_PED_ID
    L7_2 = L7_2()
    L8_2 = L5_2
    L6_2 = L6_2(L7_2, L8_2)
    L7_2 = PED
    L7_2 = L7_2.GET_PED_TEXTURE_VARIATION
    L8_2 = PLAYER
    L8_2 = L8_2.PLAYER_PED_ID
    L8_2 = L8_2()
    L9_2 = L5_2
    L7_2 = L7_2(L8_2, L9_2)
    L8_2 = "DRAWABLE "
    L9_2 = L5_2
    L10_2 = ": "
    L11_2 = L6_2
    L12_2 = ","
    L13_2 = L7_2
    L14_2 = "\n"
    L8_2 = L8_2 .. L9_2 .. L10_2 .. L11_2 .. L12_2 .. L13_2 .. L14_2
    L9_2 = filewrite
    L10_2 = L0_2
    L11_2 = "a+"
    L12_2 = L8_2
    L9_2(L10_2, L11_2, L12_2)
  end
  L2_2 = 0
  L3_2 = 9
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = PED
    L6_2 = L6_2.GET_PED_PROP_INDEX
    L7_2 = PLAYER
    L7_2 = L7_2.PLAYER_PED_ID
    L7_2 = L7_2()
    L8_2 = L5_2
    L6_2 = L6_2(L7_2, L8_2)
    L7_2 = PED
    L7_2 = L7_2.GET_PED_PROP_TEXTURE_INDEX
    L8_2 = PLAYER
    L8_2 = L8_2.PLAYER_PED_ID
    L8_2 = L8_2()
    L9_2 = L5_2
    L7_2 = L7_2(L8_2, L9_2)
    L8_2 = "PROPS "
    L9_2 = L5_2
    L10_2 = ": "
    L11_2 = L6_2
    L12_2 = ","
    L13_2 = L7_2
    L14_2 = "\n"
    L8_2 = L8_2 .. L9_2 .. L10_2 .. L11_2 .. L12_2 .. L13_2 .. L14_2
    L9_2 = filewrite
    L10_2 = L0_2
    L11_2 = "a+"
    L12_2 = L8_2
    L9_2(L10_2, L11_2, L12_2)
  end
  L2_2 = util
  L2_2 = L2_2.toast
  L3_2 = "读写完成"
  L2_2(L3_2)
end
read_appearance = L10_1
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  walkonair = A0_2
  L1_2 = walkonair
  if L1_2 then
    while true do
      L1_2 = walkonair
      if not L1_2 then
        goto lbl_260
      end
      L1_2 = show_button
      L1_2()
      L1_2 = sf
      L1_2 = L1_2.SET_DATA_SLOT
      L2_2 = 0
      L3_2 = PAD
      L3_2 = L3_2.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING
      L4_2 = 0
      L5_2 = 38
      L6_2 = true
      L3_2 = L3_2(L4_2, L5_2, L6_2)
      L4_2 = "向上"
      L1_2(L2_2, L3_2, L4_2)
      L1_2 = sf
      L1_2 = L1_2.SET_DATA_SLOT
      L2_2 = 1
      L3_2 = PAD
      L3_2 = L3_2.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING
      L4_2 = 0
      L5_2 = 44
      L6_2 = true
      L3_2 = L3_2(L4_2, L5_2, L6_2)
      L4_2 = "向下"
      L1_2(L2_2, L3_2, L4_2)
      L1_2 = sf
      L1_2 = L1_2.DRAW_INSTRUCTIONAL_BUTTONS
      L1_2()
      L1_2 = sf
      L2_2 = L1_2
      L1_2 = L1_2.draw_fullscreen
      L1_2(L2_2)
      L1_2 = ENTITY
      L1_2 = L1_2.GET_ENTITY_COORDS
      L2_2 = PLAYER
      L2_2 = L2_2.PLAYER_PED_ID
      L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L2_2()
      L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
      L2_2 = FIRE
      L2_2 = L2_2.STOP_FIRE_IN_RANGE
      L3_2 = L1_2.x
      L4_2 = L1_2.y
      L5_2 = L1_2.z
      L6_2 = 500
      L2_2(L3_2, L4_2, L5_2, L6_2)
      L2_2 = FIRE
      L2_2 = L2_2.STOP_ENTITY_FIRE
      L3_2 = PLAYER
      L3_2 = L3_2.PLAYER_PED_ID
      L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L3_2()
      L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
      L2_2 = PED
      L2_2 = L2_2.IS_PED_IN_ANY_VEHICLE
      L3_2 = PLAYER
      L3_2 = L3_2.PLAYER_PED_ID
      L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L3_2()
      L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
      if not L2_2 then
        L2_2 = air_block
        if 0 ~= L2_2 then
          L2_2 = ENTITY
          L2_2 = L2_2.DOES_ENTITY_EXIST
          L3_2 = air_block
          L2_2 = L2_2(L3_2)
          if L2_2 then
            goto lbl_109
          end
        end
        L2_2 = 1352775717
        L3_2 = ENTITY
        L3_2 = L3_2.GET_ENTITY_COORDS
        L4_2 = PLAYER
        L4_2 = L4_2.PLAYER_PED_ID
        L4_2 = L4_2()
        L5_2 = false
        L3_2 = L3_2(L4_2, L5_2)
        L4_2 = L3_2.z
        L4_2 = L4_2 - 1.4
        airb_ht = L4_2
        L4_2 = create_object
        L5_2 = L2_2
        L6_2 = L3_2.x
        L7_2 = L3_2.y
        L8_2 = airb_ht
        L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
        air_block = L4_2
        L4_2 = ENTITY
        L4_2 = L4_2.SET_ENTITY_INVINCIBLE
        L5_2 = air_block
        L6_2 = true
        L4_2(L5_2, L6_2)
        L4_2 = ENTITY
        L4_2 = L4_2.SET_ENTITY_ALPHA
        L5_2 = air_block
        L6_2 = 0
        L4_2(L5_2, L6_2)
        L4_2 = ENTITY
        L4_2 = L4_2.SET_ENTITY_VISIBLE
        L5_2 = air_block
        L6_2 = false
        L7_2 = 0
        L4_2(L5_2, L6_2, L7_2)
        ::lbl_109::
        L2_2 = ENTITY
        L2_2 = L2_2.GET_ENTITY_COORDS
        L3_2 = PLAYER
        L3_2 = L3_2.PLAYER_PED_ID
        L3_2 = L3_2()
        L4_2 = false
        L2_2 = L2_2(L3_2, L4_2)
        L3_2 = ENTITY
        L3_2 = L3_2.GET_ENTITY_COORDS
        L4_2 = air_block
        L5_2 = false
        L3_2 = L3_2(L4_2, L5_2)
        L4_2 = MISC
        L4_2 = L4_2.GET_DISTANCE_BETWEEN_COORDS
        L5_2 = L2_2.x
        L6_2 = L2_2.y
        L7_2 = L2_2.z
        L8_2 = L3_2.x
        L9_2 = L3_2.y
        L10_2 = L3_2.z
        L11_2 = true
        L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
        L5_2 = 1.4
        if L4_2 > L5_2 then
          L4_2 = ENTITY
          L4_2 = L4_2.SET_ENTITY_COORDS
          L5_2 = air_block
          L6_2 = L2_2.x
          L7_2 = L2_2.y
          L8_2 = L2_2.z
          L8_2 = L8_2 - 1.4
          L9_2 = false
          L10_2 = false
          L11_2 = false
          L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
          L4_2 = ENTITY
          L4_2 = L4_2.SET_ENTITY_HEADING
          L5_2 = air_block
          L6_2 = ENTITY
          L6_2 = L6_2.GET_ENTITY_HEADING
          L7_2 = PLAYER
          L7_2 = L7_2.PLAYER_PED_ID
          L7_2, L8_2, L9_2, L10_2, L11_2 = L7_2()
          L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
          L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
        end
        L4_2 = PAD
        L4_2 = L4_2.IS_CONTROL_PRESSED
        L5_2 = 0
        L6_2 = 38
        L4_2 = L4_2(L5_2, L6_2)
        if L4_2 then
          L4_2 = airb_ht
          L4_2 = L4_2 + 0.1
          airb_ht = L4_2
          L4_2 = ENTITY
          L4_2 = L4_2.SET_ENTITY_COORDS
          L5_2 = air_block
          L6_2 = L2_2.x
          L7_2 = L2_2.y
          L8_2 = airb_ht
          L9_2 = false
          L10_2 = false
          L11_2 = false
          L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
          L4_2 = ENTITY
          L4_2 = L4_2.SET_ENTITY_COORDS_NO_OFFSET
          L5_2 = PLAYER
          L5_2 = L5_2.PLAYER_PED_ID
          L5_2 = L5_2()
          L6_2 = L2_2.x
          L7_2 = L2_2.y
          L8_2 = airb_ht
          L8_2 = L8_2 + 1.5
          L9_2 = true
          L10_2 = false
          L11_2 = false
          L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
          L4_2 = ENTITY
          L4_2 = L4_2.SET_ENTITY_HEADING
          L5_2 = air_block
          L6_2 = ENTITY
          L6_2 = L6_2.GET_ENTITY_HEADING
          L7_2 = PLAYER
          L7_2 = L7_2.PLAYER_PED_ID
          L7_2, L8_2, L9_2, L10_2, L11_2 = L7_2()
          L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
          L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
        end
        L4_2 = PAD
        L4_2 = L4_2.IS_CONTROL_PRESSED
        L5_2 = 0
        L6_2 = 44
        L4_2 = L4_2(L5_2, L6_2)
        if L4_2 then
          L4_2 = airb_ht
          L4_2 = L4_2 - 0.1
          airb_ht = L4_2
          L4_2 = ENTITY
          L4_2 = L4_2.SET_ENTITY_COORDS
          L5_2 = air_block
          L6_2 = L2_2.x
          L7_2 = L2_2.y
          L8_2 = airb_ht
          L9_2 = false
          L10_2 = false
          L11_2 = false
          L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
          L4_2 = ENTITY
          L4_2 = L4_2.SET_ENTITY_COORDS_NO_OFFSET
          L5_2 = PLAYER
          L5_2 = L5_2.PLAYER_PED_ID
          L5_2 = L5_2()
          L6_2 = L2_2.x
          L7_2 = L2_2.y
          L8_2 = airb_ht
          L8_2 = L8_2 + 1.5
          L9_2 = true
          L10_2 = false
          L11_2 = false
          L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
          L4_2 = ENTITY
          L4_2 = L4_2.SET_ENTITY_HEADING
          L5_2 = air_block
          L6_2 = ENTITY
          L6_2 = L6_2.GET_ENTITY_HEADING
          L7_2 = PLAYER
          L7_2 = L7_2.PLAYER_PED_ID
          L7_2, L8_2, L9_2, L10_2, L11_2 = L7_2()
          L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
          L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
        end
      end
      L2_2 = util
      L2_2 = L2_2.yield
      L2_2()
    end
  else
    L1_2 = ENTITY
    L1_2 = L1_2.DOES_ENTITY_EXIST
    L2_2 = air_block
    L1_2 = L1_2(L2_2)
    if L1_2 then
      L1_2 = delete_entity
      L2_2 = air_block
      L1_2(L2_2)
    end
  end
  ::lbl_260::
end
walk_on_air = L10_1
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  movement_toggle = A0_2
  if A0_2 then
    while true do
      L1_2 = movement_toggle
      if not L1_2 then
        break
      end
      L1_2 = ENTITY
      L1_2 = L1_2.GET_ENTITY_COORDS
      L2_2 = PLAYER
      L2_2 = L2_2.PLAYER_PED_ID
      L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L2_2()
      L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
      L2_2 = ENTITY
      L2_2 = L2_2.GET_ENTITY_HEADING
      L3_2 = PLAYER
      L3_2 = L3_2.PLAYER_PED_ID
      L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L3_2()
      L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
      L3_2 = ENTITY
      L3_2 = L3_2.DOES_ENTITY_EXIST
      L4_2 = movement_dow
      L3_2 = L3_2(L4_2)
      if not L3_2 then
        L3_2 = -1272257643
        L4_2 = request_model
        L5_2 = L3_2
        L4_2(L5_2)
        L4_2 = OBJECT
        L4_2 = L4_2.CREATE_OBJECT_NO_OFFSET
        L5_2 = L3_2
        L6_2 = 0
        L7_2 = 0
        L8_2 = 0
        L9_2 = true
        L10_2 = false
        L11_2 = false
        L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
        movement_dow = L4_2
        L4_2 = ENTITY
        L4_2 = L4_2.SET_ENTITY_ALPHA
        L5_2 = movement_dow
        L6_2 = 0
        L4_2(L5_2, L6_2)
        L4_2 = ENTITY
        L4_2 = L4_2.SET_ENTITY_VISIBLE
        L5_2 = movement_dow
        L6_2 = false
        L7_2 = 0
        L4_2(L5_2, L6_2, L7_2)
      end
      L3_2 = ENTITY
      L3_2 = L3_2.SET_ENTITY_COORDS_NO_OFFSET
      L4_2 = movement_dow
      L5_2 = L1_2.x
      L6_2 = L1_2.y
      L7_2 = L1_2.z
      L7_2 = L7_2 - 1.08
      L8_2 = false
      L9_2 = false
      L10_2 = false
      L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
      L3_2 = CAM
      L3_2 = L3_2.GET_GAMEPLAY_CAM_ROT
      L4_2 = 5
      L3_2 = L3_2(L4_2)
      L4_2 = ENTITY
      L4_2 = L4_2.SET_ENTITY_ROTATION
      L5_2 = PLAYER
      L5_2 = L5_2.PLAYER_PED_ID
      L5_2 = L5_2()
      L6_2 = 0
      L7_2 = 0
      L8_2 = L3_2.z
      L9_2 = 5
      L10_2 = true
      L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
      L4_2 = ENTITY
      L4_2 = L4_2.FREEZE_ENTITY_POSITION
      L5_2 = PLAYER
      L5_2 = L5_2.PLAYER_PED_ID
      L5_2 = L5_2()
      L6_2 = true
      L4_2(L5_2, L6_2)
      L4_2 = PAD
      L4_2 = L4_2.IS_CONTROL_PRESSED
      L5_2 = 0
      L6_2 = 32
      L4_2 = L4_2(L5_2, L6_2)
      if L4_2 then
        L4_2 = ENTITY
        L4_2 = L4_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
        L5_2 = PLAYER
        L5_2 = L5_2.PLAYER_PED_ID
        L5_2 = L5_2()
        L6_2 = 0
        L7_2 = 1
        L8_2 = 0
        L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
        L5_2 = ENTITY
        L5_2 = L5_2.SET_ENTITY_COORDS_NO_OFFSET
        L6_2 = PLAYER
        L6_2 = L6_2.PLAYER_PED_ID
        L6_2 = L6_2()
        L7_2 = L4_2.x
        L8_2 = L4_2.y
        L9_2 = L4_2.z
        L10_2 = true
        L11_2 = false
        L12_2 = false
        L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
        L5_2 = ENTITY
        L5_2 = L5_2.FREEZE_ENTITY_POSITION
        L6_2 = PLAYER
        L6_2 = L6_2.PLAYER_PED_ID
        L6_2 = L6_2()
        L7_2 = false
        L5_2(L6_2, L7_2)
      else
        L4_2 = PAD
        L4_2 = L4_2.IS_CONTROL_PRESSED
        L5_2 = 0
        L6_2 = 33
        L4_2 = L4_2(L5_2, L6_2)
        if L4_2 then
          L4_2 = ENTITY
          L4_2 = L4_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
          L5_2 = PLAYER
          L5_2 = L5_2.PLAYER_PED_ID
          L5_2 = L5_2()
          L6_2 = 0
          L7_2 = -1
          L8_2 = 0
          L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
          L5_2 = ENTITY
          L5_2 = L5_2.SET_ENTITY_COORDS_NO_OFFSET
          L6_2 = PLAYER
          L6_2 = L6_2.PLAYER_PED_ID
          L6_2 = L6_2()
          L7_2 = L4_2.x
          L8_2 = L4_2.y
          L9_2 = L4_2.z
          L10_2 = true
          L11_2 = false
          L12_2 = false
          L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
          L5_2 = ENTITY
          L5_2 = L5_2.FREEZE_ENTITY_POSITION
          L6_2 = PLAYER
          L6_2 = L6_2.PLAYER_PED_ID
          L6_2 = L6_2()
          L7_2 = false
          L5_2(L6_2, L7_2)
        end
      end
      L4_2 = PAD
      L4_2 = L4_2.IS_CONTROL_PRESSED
      L5_2 = 0
      L6_2 = 34
      L4_2 = L4_2(L5_2, L6_2)
      if L4_2 then
        L4_2 = ENTITY
        L4_2 = L4_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
        L5_2 = PLAYER
        L5_2 = L5_2.PLAYER_PED_ID
        L5_2 = L5_2()
        L6_2 = -1
        L7_2 = 0
        L8_2 = 0
        L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
        L5_2 = ENTITY
        L5_2 = L5_2.SET_ENTITY_COORDS_NO_OFFSET
        L6_2 = PLAYER
        L6_2 = L6_2.PLAYER_PED_ID
        L6_2 = L6_2()
        L7_2 = L4_2.x
        L8_2 = L4_2.y
        L9_2 = L4_2.z
        L10_2 = true
        L11_2 = false
        L12_2 = false
        L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
      else
        L4_2 = PAD
        L4_2 = L4_2.IS_CONTROL_PRESSED
        L5_2 = 0
        L6_2 = 35
        L4_2 = L4_2(L5_2, L6_2)
        if L4_2 then
          L4_2 = ENTITY
          L4_2 = L4_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
          L5_2 = PLAYER
          L5_2 = L5_2.PLAYER_PED_ID
          L5_2 = L5_2()
          L6_2 = 1
          L7_2 = 0
          L8_2 = 0
          L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
          L5_2 = ENTITY
          L5_2 = L5_2.SET_ENTITY_COORDS_NO_OFFSET
          L6_2 = PLAYER
          L6_2 = L6_2.PLAYER_PED_ID
          L6_2 = L6_2()
          L7_2 = L4_2.x
          L8_2 = L4_2.y
          L9_2 = L4_2.z
          L10_2 = true
          L11_2 = false
          L12_2 = false
          L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
        end
      end
      L4_2 = PAD
      L4_2 = L4_2.IS_CONTROL_PRESSED
      L5_2 = 0
      L6_2 = 21
      L4_2 = L4_2(L5_2, L6_2)
      if L4_2 then
        L4_2 = ENTITY
        L4_2 = L4_2.GET_ENTITY_COORDS
        L5_2 = PLAYER
        L5_2 = L5_2.PLAYER_PED_ID
        L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L5_2()
        L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
        L5_2 = ENTITY
        L5_2 = L5_2.SET_ENTITY_COORDS_NO_OFFSET
        L6_2 = PLAYER
        L6_2 = L6_2.PLAYER_PED_ID
        L6_2 = L6_2()
        L7_2 = L4_2.x
        L8_2 = L4_2.y
        L9_2 = L4_2.z
        L9_2 = L9_2 + 1
        L10_2 = true
        L11_2 = false
        L12_2 = false
        L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
        L5_2 = ENTITY
        L5_2 = L5_2.FREEZE_ENTITY_POSITION
        L6_2 = PLAYER
        L6_2 = L6_2.PLAYER_PED_ID
        L6_2 = L6_2()
        L7_2 = false
        L5_2(L6_2, L7_2)
      else
        L4_2 = PAD
        L4_2 = L4_2.IS_CONTROL_PRESSED
        L5_2 = 0
        L6_2 = 36
        L4_2 = L4_2(L5_2, L6_2)
        if L4_2 then
          L4_2 = ENTITY
          L4_2 = L4_2.GET_ENTITY_COORDS
          L5_2 = PLAYER
          L5_2 = L5_2.PLAYER_PED_ID
          L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L5_2()
          L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
          L5_2 = ENTITY
          L5_2 = L5_2.SET_ENTITY_COORDS_NO_OFFSET
          L6_2 = PLAYER
          L6_2 = L6_2.PLAYER_PED_ID
          L6_2 = L6_2()
          L7_2 = L4_2.x
          L8_2 = L4_2.y
          L9_2 = L4_2.z
          L9_2 = L9_2 - 1
          L10_2 = true
          L11_2 = false
          L12_2 = false
          L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
          L5_2 = ENTITY
          L5_2 = L5_2.FREEZE_ENTITY_POSITION
          L6_2 = PLAYER
          L6_2 = L6_2.PLAYER_PED_ID
          L6_2 = L6_2()
          L7_2 = false
          L5_2(L6_2, L7_2)
        end
      end
      L4_2 = util
      L4_2 = L4_2.yield
      L4_2()
    end
  else
    L1_2 = ENTITY
    L1_2 = L1_2.FREEZE_ENTITY_POSITION
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = false
    L1_2(L2_2, L3_2)
    L1_2 = delete_entity
    L2_2 = movement_dow
    L1_2(L2_2)
  end
end
Silky_movement = L10_1
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L0_2 = ENTITY
  L0_2 = L0_2.GET_ENTITY_COORDS
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = false
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = nil
  L2_2 = nil
  L3_2 = ipairs
  L4_2 = gasStations
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = MISC
    L9_2 = L9_2.GET_DISTANCE_BETWEEN_COORDS
    L10_2 = L8_2[1]
    L11_2 = L8_2[2]
    L12_2 = L8_2[3]
    L13_2 = L0_2.x
    L14_2 = L0_2.y
    L15_2 = L0_2.z
    L16_2 = true
    L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
    if not L2_2 or L2_2 and L2_2 > L9_2 then
      L2_2 = L9_2
      L1_2 = L8_2
    end
  end
  return L1_2
end
GetClosestGasStation = L10_1
L10_1 = v3
L11_1 = 1
L12_1 = 1
L13_1 = 1
L10_1 = L10_1(L11_1, L12_1, L13_1)
L11_1 = 25
L12_1 = {}
L12_1.r = 255
L12_1.g = 165
L12_1.b = 255
L12_1.a = 100
function L13_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L4_2 = 1
  L4_2 = L4_2 - A3_2
  L4_2 = L4_2 ^ 2
  L5_2 = 1
  L5_2 = L5_2 - A3_2
  L5_2 = 2 * L5_2
  L5_2 = L5_2 * A3_2
  L6_2 = A3_2 ^ 2
  L7_2 = v3
  L8_2 = A0_2
  L7_2 = L7_2(L8_2)
  L8_2 = L7_2
  L7_2 = L7_2.mul
  L9_2 = L4_2
  L7_2 = L7_2(L8_2, L9_2)
  L8_2 = v3
  L9_2 = A1_2
  L8_2 = L8_2(L9_2)
  L9_2 = L8_2
  L8_2 = L8_2.mul
  L10_2 = L5_2
  L8_2 = L8_2(L9_2, L10_2)
  L9_2 = v3
  L10_2 = A2_2
  L9_2 = L9_2(L10_2)
  L10_2 = L9_2
  L9_2 = L9_2.mul
  L11_2 = L6_2
  L9_2 = L9_2(L10_2, L11_2)
  L11_2 = L7_2
  L10_2 = L7_2.add
  L12_2 = L8_2
  L10_2 = L10_2(L11_2, L12_2)
  L11_2 = L10_2
  L10_2 = L10_2.add
  L12_2 = L9_2
  L10_2 = L10_2(L11_2, L12_2)
  L11_2 = 1
  L11_2 = L11_2 - A3_2
  L12_2 = v3
  L13_2 = A1_2
  L12_2 = L12_2(L13_2)
  L13_2 = L12_2
  L12_2 = L12_2.sub
  L14_2 = A0_2
  L12_2 = L12_2(L13_2, L14_2)
  L13_2 = L12_2
  L12_2 = L12_2.mul
  L14_2 = 2 * L11_2
  L12_2 = L12_2(L13_2, L14_2)
  L13_2 = v3
  L14_2 = A2_2
  L13_2 = L13_2(L14_2)
  L14_2 = L13_2
  L13_2 = L13_2.sub
  L15_2 = A1_2
  L13_2 = L13_2(L14_2, L15_2)
  L14_2 = L13_2
  L13_2 = L13_2.mul
  L15_2 = 2 * A3_2
  L13_2 = L13_2(L14_2, L15_2)
  L15_2 = L12_2
  L14_2 = L12_2.add
  L16_2 = L13_2
  L14_2(L15_2, L16_2)
  L14_2 = L10_2
  L15_2 = L12_2
  return L14_2, L15_2
end
quadraticBezierCurve = L13_1
function L13_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2
  L2_2 = v3
  L2_2 = L2_2.distance
  L3_2 = A0_2
  L4_2 = A1_2
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = math
  L3_2 = L3_2.floor
  L4_2 = L2_2 / 2
  L3_2 = L3_2(L4_2)
  L4_2 = v3
  L5_2 = A1_2
  L4_2 = L4_2(L5_2)
  L5_2 = L4_2
  L4_2 = L4_2.sub
  L6_2 = A0_2
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = L4_2
  L4_2 = L4_2.normalise
  L4_2 = L4_2(L5_2)
  L5_2 = ENTITY
  L5_2 = L5_2.GET_ENTITY_COORDS
  L6_2 = PLAYER
  L6_2 = L6_2.PLAYER_PED_ID
  L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2 = L6_2()
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2)
  L6_2 = 0
  L7_2 = L3_2
  L8_2 = 1
  for L9_2 = L6_2, L7_2, L8_2 do
    L10_2 = v3
    L11_2 = L4_2
    L10_2 = L10_2(L11_2)
    L11_2 = L10_2
    L10_2 = L10_2.mul
    L12_2 = L9_2 * 2
    L10_2 = L10_2(L11_2, L12_2)
    L11_2 = L10_2
    L10_2 = L10_2.add
    L12_2 = A0_2
    L10_2 = L10_2(L11_2, L12_2)
    L11_2 = v3
    L11_2 = L11_2.distance
    L12_2 = L10_2
    L13_2 = L5_2
    L11_2 = L11_2(L12_2, L13_2)
    L12_2 = L10_2.z
    L13_2 = 6
    L13_2 = L13_2 / L11_2
    L13_2 = L13_2 - 0.8
    L12_2 = L12_2 - L13_2
    L10_2.z = L12_2
    L12_2 = GRAPHICS1
    L12_2 = L12_2.DRAW_MARKER
    L13_2 = 2
    L14_2 = L10_2
    L15_2 = L4_2
    L16_2 = v3
    L17_2 = 90
    L18_2 = 0
    L19_2 = 0
    L16_2 = L16_2(L17_2, L18_2, L19_2)
    L17_2 = L10_1
    L18_2 = L12_1.r
    L19_2 = L12_1.g
    L20_2 = L12_1.b
    L21_2 = L12_1.a
    L22_2 = false
    L23_2 = false
    L24_2 = 0
    L25_2 = false
    L26_2 = 0
    L27_2 = 0
    L28_2 = false
    L12_2(L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2)
  end
end
draw_arrows_between_points = L13_1
function L13_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2
  L3_2 = v3
  L3_2 = L3_2.distance
  L4_2 = A0_2
  L5_2 = A1_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = v3
  L4_2 = L4_2.distance
  L5_2 = A1_2
  L6_2 = A2_2
  L4_2 = L4_2(L5_2, L6_2)
  L3_2 = L3_2 + L4_2
  L4_2 = math
  L4_2 = L4_2.floor
  L5_2 = L3_2 / 2
  L4_2 = L4_2(L5_2)
  L5_2 = ENTITY
  L5_2 = L5_2.GET_ENTITY_COORDS
  L6_2 = PLAYER
  L6_2 = L6_2.PLAYER_PED_ID
  L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2 = L6_2()
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2)
  L6_2 = 1
  L7_2 = L4_2
  L8_2 = 1
  for L9_2 = L6_2, L7_2, L8_2 do
    L10_2 = L9_2 / L4_2
    L11_2 = 1
    L10_2 = L11_2 - L10_2
    L11_2 = quadraticBezierCurve
    L12_2 = A0_2
    L13_2 = A1_2
    L14_2 = A2_2
    L15_2 = L10_2
    L11_2, L12_2 = L11_2(L12_2, L13_2, L14_2, L15_2)
    dir = L12_2
    draw_pos = L11_2
    L11_2 = draw_pos
    L12_2 = draw_pos
    L12_2 = L12_2.z
    L13_2 = v3
    L13_2 = L13_2.distance
    L14_2 = draw_pos
    L15_2 = L5_2
    L13_2 = L13_2(L14_2, L15_2)
    L14_2 = 6
    L13_2 = L14_2 / L13_2
    L13_2 = L13_2 - 0.8
    L12_2 = L12_2 - L13_2
    L11_2.z = L12_2
    L11_2 = GRAPHICS1
    L11_2 = L11_2.DRAW_MARKER
    L12_2 = 2
    L13_2 = draw_pos
    L14_2 = dir
    L15_2 = v3
    L16_2 = 90
    L17_2 = 0
    L18_2 = 0
    L15_2 = L15_2(L16_2, L17_2, L18_2)
    L16_2 = L10_1
    L17_2 = L12_1.r
    L18_2 = L12_1.g
    L19_2 = L12_1.b
    L20_2 = L12_1.a
    L21_2 = false
    L22_2 = false
    L23_2 = 0
    L24_2 = false
    L25_2 = 0
    L26_2 = 0
    L27_2 = false
    L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2)
  end
end
draw_arrows_between_points_smooth = L13_1
function L13_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2
  L3_2 = v3
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = L3_2
  L3_2 = L3_2.sub
  L5_2 = A1_2
  L3_2 = L3_2(L4_2, L5_2)
  b_to_a = L3_2
  L3_2 = v3
  L4_2 = A2_2
  L3_2 = L3_2(L4_2)
  L4_2 = L3_2
  L3_2 = L3_2.sub
  L5_2 = A1_2
  L3_2 = L3_2(L4_2, L5_2)
  b_to_c = L3_2
  L3_2 = b_to_a
  L4_2 = L3_2
  L3_2 = L3_2.mul
  L5_2 = 0.2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = L3_2
  L3_2 = L3_2.add
  L5_2 = A1_2
  L3_2(L4_2, L5_2)
  L3_2 = b_to_c
  L4_2 = L3_2
  L3_2 = L3_2.mul
  L5_2 = 0.2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = L3_2
  L3_2 = L3_2.add
  L5_2 = A1_2
  L3_2(L4_2, L5_2)
  L3_2 = b_to_a
  L4_2 = b_to_c
  return L3_2, L4_2
end
get_corner_points = L13_1
function L13_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L1_2 = util
  L1_2 = L1_2.get_gps_route
  L2_2 = 0
  L1_2 = L1_2(L2_2)
  L2_2 = {}
  L3_2 = pairs
  L4_2 = L1_2
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = #L2_2
    if A0_2 <= L9_2 then
      break
    end
    L9_2 = L8_2.junction
    if not L9_2 then
      L9_2 = v3
      L10_2 = L8_2.x
      L11_2 = L8_2.y
      L12_2 = L8_2.z
      L9_2 = L9_2(L10_2, L11_2, L12_2)
      L10_2 = table
      L10_2 = L10_2.insert
      L11_2 = L2_2
      L12_2 = L9_2
      L10_2(L11_2, L12_2)
    end
  end
  return L2_2
end
get_route_clean = L13_1
function L13_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = PED
  L0_2 = L0_2.IS_PED_IN_ANY_VEHICLE
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = true
  L0_2 = L0_2(L1_2, L2_2)
  if L0_2 then
    L0_2 = get_route_clean
    L1_2 = L11_1
    L0_2 = L0_2(L1_2)
    L1_2 = nil
    L2_2 = 1
    L3_2 = #L0_2
    L4_2 = 1
    for L5_2 = L2_2, L3_2, L4_2 do
      L6_2 = L5_2 + 2
      L6_2 = L0_2[L6_2]
      if L6_2 then
        L6_2 = get_corner_points
        L7_2 = L0_2[L5_2]
        L8_2 = L5_2 + 1
        L8_2 = L0_2[L8_2]
        L9_2 = L5_2 + 2
        L9_2 = L0_2[L9_2]
        L6_2, L7_2 = L6_2(L7_2, L8_2, L9_2)
        subpoint_b = L7_2
        subpoint_a = L6_2
        L6_2 = draw_arrows_between_points
        L7_2 = L0_2[L5_2]
        L8_2 = subpoint_a
        L6_2(L7_2, L8_2)
        L6_2 = draw_arrows_between_points_smooth
        L7_2 = subpoint_a
        L8_2 = L5_2 + 1
        L8_2 = L0_2[L8_2]
        L9_2 = subpoint_b
        L6_2(L7_2, L8_2, L9_2)
        L1_2 = subpoint_b
      else
        L6_2 = L5_2 + 1
        L6_2 = L0_2[L6_2]
        if L6_2 then
          L6_2 = draw_arrows_between_points
          L7_2 = L0_2[L5_2]
          L8_2 = L5_2 + 1
          L8_2 = L0_2[L8_2]
          L6_2(L7_2, L8_2)
        end
      end
    end
  end
end
AR_navigation = L13_1
function L13_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2
  L0_2 = entities
  L0_2 = L0_2.get_all_vehicles_as_handles
  L0_2 = L0_2()
  L1_2 = entities
  L1_2 = L1_2.get_all_peds_as_handles
  L1_2 = L1_2()
  L2_2 = entities
  L2_2 = L2_2.get_all_objects_as_handles
  L2_2 = L2_2()
  L3_2 = util
  L3_2 = L3_2.yield
  L4_2 = 100
  L3_2(L4_2)
  L3_2 = {}
  L4_2 = {}
  L4_2.x = 0.0
  L4_2.y = 0.0
  L4_2.z = 1000.0
  L5_2 = PED
  L5_2 = L5_2.GET_VEHICLE_PED_IS_IN
  L6_2 = PLAYER
  L6_2 = L6_2.GET_PLAYER_PED
  L7_2 = PLAYER
  L7_2 = L7_2.PLAYER_ID
  L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2 = L7_2()
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
  L7_2 = false
  L5_2 = L5_2(L6_2, L7_2)
  L6_2 = 1
  L7_2 = #L1_2
  L8_2 = 1
  for L9_2 = L6_2, L7_2, L8_2 do
    L10_2 = PED
    L10_2 = L10_2.IS_PED_A_PLAYER
    L11_2 = L1_2[L9_2]
    L10_2 = L10_2(L11_2)
    if not L10_2 then
      L10_2 = math
      L10_2 = L10_2.random
      L11_2 = 1000.0
      L12_2 = 10000.0
      L10_2 = L10_2(L11_2, L12_2)
      L3_2.x = L10_2
      L10_2 = math
      L10_2 = L10_2.random
      L11_2 = 1000.0
      L12_2 = 10000.0
      L10_2 = L10_2(L11_2, L12_2)
      L3_2.y = L10_2
      L10_2 = math
      L10_2 = L10_2.random
      L11_2 = 1000.0
      L12_2 = 7500.0
      L10_2 = L10_2(L11_2, L12_2)
      L3_2.z = L10_2
      L10_2 = ENTITY
      L10_2 = L10_2.FREEZE_ENTITY_POSITION
      L11_2 = L1_2[L9_2]
      L12_2 = false
      L10_2(L11_2, L12_2)
      L10_2 = ENTITY
      L10_2 = L10_2.APPLY_FORCE_TO_ENTITY
      L11_2 = L1_2[L9_2]
      L12_2 = 5
      L13_2 = 100.0
      L14_2 = 100.0
      L15_2 = 100.0
      L16_2 = 100.0
      L17_2 = 100.0
      L18_2 = 100.0
      L19_2 = 0
      L20_2 = 1
      L21_2 = 1
      L22_2 = 1
      L23_2 = 0
      L24_2 = 1
      L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
      L10_2 = ENTITY
      L10_2 = L10_2.SET_ENTITY_VELOCITY
      L11_2 = L1_2[L9_2]
      L12_2 = L3_2.x
      L13_2 = L3_2.y
      L14_2 = L3_2.z
      L10_2(L11_2, L12_2, L13_2, L14_2)
    end
  end
  L6_2 = 1
  L7_2 = #L0_2
  L8_2 = 1
  for L9_2 = L6_2, L7_2, L8_2 do
    L10_2 = L0_2[L9_2]
    if L10_2 ~= L5_2 then
      L10_2 = math
      L10_2 = L10_2.random
      L11_2 = 1000.0
      L12_2 = 10000.0
      L10_2 = L10_2(L11_2, L12_2)
      L3_2.x = L10_2
      L10_2 = math
      L10_2 = L10_2.random
      L11_2 = 1000.0
      L12_2 = 10000.0
      L10_2 = L10_2(L11_2, L12_2)
      L3_2.y = L10_2
      L10_2 = math
      L10_2 = L10_2.random
      L11_2 = 1000.0
      L12_2 = 7500.0
      L10_2 = L10_2(L11_2, L12_2)
      L3_2.z = L10_2
      L10_2 = ENTITY
      L10_2 = L10_2.FREEZE_ENTITY_POSITION
      L11_2 = L0_2[L9_2]
      L12_2 = false
      L10_2(L11_2, L12_2)
      L10_2 = VEHICLE
      L10_2 = L10_2.SET_VEHICLE_GRAVITY
      L11_2 = L0_2[L9_2]
      L12_2 = false
      L10_2(L11_2, L12_2)
      L10_2 = ENTITY
      L10_2 = L10_2.SET_ENTITY_VELOCITY
      L11_2 = L0_2[L9_2]
      L12_2 = L4_2.x
      L13_2 = L4_2.y
      L14_2 = L4_2.z
      L10_2(L11_2, L12_2, L13_2, L14_2)
      L10_2 = util
      L10_2 = L10_2.yield
      L11_2 = 25
      L10_2(L11_2)
      L10_2 = ENTITY
      L10_2 = L10_2.SET_ENTITY_VELOCITY
      L11_2 = L0_2[L9_2]
      L12_2 = L3_2.x
      L13_2 = L3_2.y
      L14_2 = L3_2.z
      L10_2(L11_2, L12_2, L13_2, L14_2)
    end
  end
  L6_2 = 1
  L7_2 = #L2_2
  L8_2 = 1
  for L9_2 = L6_2, L7_2, L8_2 do
    L10_2 = math
    L10_2 = L10_2.random
    L11_2 = 1000.0
    L12_2 = 10000.0
    L10_2 = L10_2(L11_2, L12_2)
    L3_2.x = L10_2
    L10_2 = math
    L10_2 = L10_2.random
    L11_2 = 1000.0
    L12_2 = 10000.0
    L10_2 = L10_2(L11_2, L12_2)
    L3_2.y = L10_2
    L10_2 = math
    L10_2 = L10_2.random
    L11_2 = 1000.0
    L12_2 = 7500.0
    L10_2 = L10_2(L11_2, L12_2)
    L3_2.z = L10_2
    L10_2 = ENTITY
    L10_2 = L10_2.FREEZE_ENTITY_POSITION
    L11_2 = L2_2[L9_2]
    L12_2 = false
    L10_2(L11_2, L12_2)
    L10_2 = ENTITY
    L10_2 = L10_2.SET_ENTITY_VELOCITY
    L11_2 = L2_2[L9_2]
    L12_2 = L3_2.x
    L13_2 = L3_2.y
    L14_2 = L3_2.z
    L10_2(L11_2, L12_2, L13_2, L14_2)
  end
end
World_Bombing = L13_1
function L13_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2
  L0_2 = ENTITY
  L0_2 = L0_2.GET_ENTITY_COORDS
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = false
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = create_vehicle
  L2_2 = 1353120668
  L3_2 = L0_2.x
  L4_2 = L0_2.y
  L5_2 = L0_2.z
  L6_2 = ENTITY
  L6_2 = L6_2.GET_ENTITY_HEADING
  L7_2 = PLAYER
  L7_2 = L7_2.PLAYER_PED_ID
  L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2 = L7_2()
  L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
  L2_2 = ENTITY
  L2_2 = L2_2.SET_ENTITY_ALPHA
  L3_2 = L1_2
  L4_2 = 0
  L5_2 = false
  L2_2(L3_2, L4_2, L5_2)
  L2_2 = ENTITY
  L2_2 = L2_2.SET_ENTITY_INVINCIBLE
  L3_2 = L1_2
  L4_2 = true
  L2_2(L3_2, L4_2)
  L2_2 = VEHICLE
  L2_2 = L2_2.SET_VEHICLE_ENGINE_ON
  L3_2 = L1_2
  L4_2 = true
  L5_2 = true
  L6_2 = false
  L2_2(L3_2, L4_2, L5_2, L6_2)
  L2_2 = PED
  L2_2 = L2_2.SET_PED_INTO_VEHICLE
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2 = L3_2()
  L4_2 = L1_2
  L5_2 = -1
  L2_2(L3_2, L4_2, L5_2)
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "prop_rub_trolley02a"
  L2_2 = L2_2(L3_2)
  L3_2 = create_object
  L4_2 = L2_2
  L5_2 = L0_2.x
  L6_2 = L0_2.y
  L7_2 = L0_2.z
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
  L4_2 = ENTITY
  L4_2 = L4_2.ATTACH_ENTITY_TO_ENTITY
  L5_2 = L3_2
  L6_2 = L1_2
  L7_2 = 0
  L8_2 = 0
  L9_2 = 0
  L10_2 = 0
  L11_2 = 0
  L12_2 = 0
  L13_2 = 0
  L14_2 = true
  L15_2 = false
  L16_2 = false
  L17_2 = false
  L18_2 = 0
  L19_2 = true
  L20_2 = 0
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
end
drive_shopping_cart = L13_1
function L13_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2
  L0_2 = is_entity_on_water
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
  if not L0_2 then
    L0_2 = notification
    L1_2 = "~y~~bold~不在水上:)"
    L2_2 = HudColour
    L2_2 = L2_2.blue
    L0_2(L1_2, L2_2)
    return
  end
  L0_2 = -311022263
  L1_2 = 59140280
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L3_2()
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
  L3_2 = request_model
  L4_2 = L0_2
  L5_2 = L1_2
  L3_2(L4_2, L5_2)
  L3_2 = PED
  L3_2 = L3_2.CLONE_PED
  L4_2 = PLAYER
  L4_2 = L4_2.PLAYER_PED_ID
  L4_2 = L4_2()
  L5_2 = true
  L6_2 = false
  L7_2 = true
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
  L4_2 = VEHICLE
  L4_2 = L4_2.CREATE_VEHICLE
  L5_2 = L0_2
  L6_2 = L2_2.x
  L7_2 = L2_2.y
  L8_2 = L2_2.z
  L9_2 = ENTITY
  L9_2 = L9_2.GET_ENTITY_HEADING
  L10_2 = PLAYER
  L10_2 = L10_2.PLAYER_PED_ID
  L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L10_2()
  L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
  L10_2 = true
  L11_2 = true
  L12_2 = false
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L5_2 = OBJECT
  L5_2 = L5_2.CREATE_OBJECT
  L6_2 = L1_2
  L7_2 = L2_2.x
  L8_2 = L2_2.y
  L9_2 = L2_2.z
  L10_2 = true
  L11_2 = false
  L12_2 = true
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L6_2 = PED
  L6_2 = L6_2.SET_PED_INTO_VEHICLE
  L7_2 = PLAYER
  L7_2 = L7_2.PLAYER_PED_ID
  L7_2 = L7_2()
  L8_2 = L4_2
  L9_2 = -1
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = ENTITY
  L6_2 = L6_2.SET_ENTITY_VISIBLE
  L7_2 = L4_2
  L8_2 = false
  L9_2 = false
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = ENTITY
  L6_2 = L6_2.ATTACH_ENTITY_TO_ENTITY
  L7_2 = L5_2
  L8_2 = L4_2
  L9_2 = 0
  L10_2 = 0
  L11_2 = 0
  L12_2 = 0
  L13_2 = 270
  L14_2 = 0
  L15_2 = 0
  L16_2 = true
  L17_2 = false
  L18_2 = false
  L19_2 = true
  L20_2 = 0
  L21_2 = true
  L22_2 = 0
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
  L6_2 = ENTITY
  L6_2 = L6_2.ATTACH_ENTITY_TO_ENTITY
  L7_2 = L3_2
  L8_2 = L5_2
  L9_2 = 0
  L10_2 = 0
  L11_2 = -1
  L12_2 = 0
  L13_2 = 90
  L14_2 = -90
  L15_2 = 0
  L16_2 = true
  L17_2 = false
  L18_2 = false
  L19_2 = true
  L20_2 = 0
  L21_2 = true
  L22_2 = 0
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
  L6_2 = ENTITY
  L6_2 = L6_2.SET_ENTITY_INVINCIBLE
  L7_2 = L4_2
  L8_2 = true
  L6_2(L7_2, L8_2)
  L6_2 = ENTITY
  L6_2 = L6_2.SET_ENTITY_ALPHA
  L7_2 = PLAYER
  L7_2 = L7_2.PLAYER_PED_ID
  L7_2 = L7_2()
  L8_2 = 0
  L9_2 = false
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = calm_ped
  L7_2 = L3_2
  L8_2 = true
  L6_2(L7_2, L8_2)
  while L3_2 do
    L6_2 = PED
    L6_2 = L6_2.GET_VEHICLE_PED_IS_IN
    L7_2 = PLAYER
    L7_2 = L7_2.GET_PLAYER_PED
    L8_2 = PLAYER
    L8_2 = L8_2.PLAYER_ID
    L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L8_2()
    L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
    L8_2 = false
    L6_2 = L6_2(L7_2, L8_2)
    L7_2 = PED
    L7_2 = L7_2.IS_PED_IN_ANY_VEHICLE
    L8_2 = PLAYER
    L8_2 = L8_2.PLAYER_PED_ID
    L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L8_2()
    L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
    if not L7_2 then
      L7_2 = ENTITY
      L7_2 = L7_2.DOES_ENTITY_EXIST
      L8_2 = L4_2
      L7_2 = L7_2(L8_2)
      if L7_2 then
        L7_2 = ENTITY
        L7_2 = L7_2.DOES_ENTITY_EXIST
        L8_2 = L5_2
        L7_2 = L7_2(L8_2)
        if L7_2 then
          L7_2 = delete_entity
          L8_2 = L4_2
          L7_2(L8_2)
          L7_2 = delete_entity
          L8_2 = L3_2
          L7_2(L8_2)
          L7_2 = delete_entity
          L8_2 = L5_2
          L7_2(L8_2)
          return
      end
    end
    elseif L6_2 ~= L4_2 then
      L7_2 = ENTITY
      L7_2 = L7_2.DOES_ENTITY_EXIST
      L8_2 = L4_2
      L7_2 = L7_2(L8_2)
      if L7_2 then
        L7_2 = ENTITY
        L7_2 = L7_2.DOES_ENTITY_EXIST
        L8_2 = L5_2
        L7_2 = L7_2(L8_2)
        if L7_2 then
          L7_2 = delete_entity
          L8_2 = L4_2
          L7_2(L8_2)
          L7_2 = delete_entity
          L8_2 = L3_2
          L7_2(L8_2)
          L7_2 = delete_entity
          L8_2 = L5_2
          L7_2(L8_2)
          return
        end
      end
    end
    L7_2 = TASK
    L7_2 = L7_2.TASK_STAND_STILL
    L8_2 = L3_2
    L9_2 = 10000
    L7_2(L8_2, L9_2)
    L7_2 = util
    L7_2 = L7_2.yield
    L7_2()
  end
end
surf = L13_1
vehicle_uses = 0
ped_uses = 0
pickup_uses = 0
player_uses = 0
object_uses = 0
robustmode = false
function L13_1(A0_2, A1_2)
  local L2_2
  if A1_2 < 0 then
    L2_2 = is_loading
    if L2_2 then
      return
    end
  end
  if "vehicle" == A0_2 then
    L2_2 = vehicle_uses
    if L2_2 <= 0 and A1_2 < 0 then
      return
    end
    L2_2 = vehicle_uses
    L2_2 = L2_2 + A1_2
    vehicle_uses = L2_2
  elseif "pickup" == A0_2 then
    L2_2 = pickup_uses
    if L2_2 <= 0 and A1_2 < 0 then
      return
    end
    L2_2 = pickup_uses
    L2_2 = L2_2 + A1_2
    pickup_uses = L2_2
  elseif "ped" == A0_2 then
    L2_2 = ped_uses
    if L2_2 <= 0 and A1_2 < 0 then
      return
    end
    L2_2 = ped_uses
    L2_2 = L2_2 + A1_2
    ped_uses = L2_2
  elseif "player" == A0_2 then
    L2_2 = player_uses
    if L2_2 <= 0 and A1_2 < 0 then
      return
    end
    L2_2 = player_uses
    L2_2 = L2_2 + A1_2
    player_uses = L2_2
  elseif "object" == A0_2 then
    L2_2 = object_uses
    if L2_2 <= 0 and A1_2 < 0 then
      return
    end
    L2_2 = object_uses
    L2_2 = L2_2 + A1_2
    object_uses = L2_2
  end
end
mod_uses = L13_1
function L13_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2
  L2_2 = memory
  L2_2 = L2_2.alloc
  L2_2 = L2_2()
  L3_2 = memory
  L3_2 = L3_2.alloc
  L3_2 = L3_2()
  L4_2 = memory
  L4_2 = L4_2.alloc
  L4_2 = L4_2()
  L5_2 = memory
  L5_2 = L5_2.alloc
  L5_2 = L5_2()
  L6_2 = CAM
  L6_2 = L6_2.GET_GAMEPLAY_CAM_ROT
  L7_2 = 2
  L6_2 = L6_2(L7_2)
  L7_2 = CAM
  L7_2 = L7_2.GET_GAMEPLAY_CAM_COORD
  L7_2 = L7_2()
  L8_2 = toDirection
  L9_2 = CAM
  L9_2 = L9_2.GET_GAMEPLAY_CAM_ROT
  L10_2 = 0
  L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2 = L9_2(L10_2)
  L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
  L9_2 = {}
  L10_2 = L7_2.x
  L11_2 = L8_2.x
  L11_2 = L11_2 * A1_2
  L10_2 = L10_2 + L11_2
  L9_2.x = L10_2
  L10_2 = L7_2.y
  L11_2 = L8_2.y
  L11_2 = L11_2 * A1_2
  L10_2 = L10_2 + L11_2
  L9_2.y = L10_2
  L10_2 = L7_2.z
  L11_2 = L8_2.z
  L11_2 = L11_2 * A1_2
  L10_2 = L10_2 + L11_2
  L9_2.z = L10_2
  L10_2 = SHAPETEST
  L10_2 = L10_2.GET_SHAPE_TEST_RESULT
  L11_2 = SHAPETEST
  L12_2 = "START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE"
  L11_2 = L11_2[L12_2]
  L12_2 = L7_2.x
  L13_2 = L7_2.y
  L14_2 = L7_2.z
  L15_2 = L9_2.x
  L16_2 = L9_2.y
  L17_2 = L9_2.z
  L18_2 = A0_2
  L19_2 = -1
  L20_2 = 1
  L11_2 = L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
  L12_2 = L2_2
  L13_2 = L3_2
  L14_2 = L4_2
  L15_2 = L5_2
  L10_2(L11_2, L12_2, L13_2, L14_2, L15_2)
  L10_2 = memory
  L10_2 = L10_2.read_int
  L11_2 = L2_2
  L10_2 = L10_2(L11_2)
  L11_2 = memory
  L11_2 = L11_2.read_vector3
  L12_2 = L3_2
  L11_2 = L11_2(L12_2)
  L12_2 = memory
  L12_2 = L12_2.read_vector3
  L13_2 = L4_2
  L12_2 = L12_2(L13_2)
  L13_2 = memory
  L13_2 = L13_2.read_int
  L14_2 = L5_2
  L13_2 = L13_2(L14_2)
  L14_2 = {}
  L15_2 = L10_2
  L16_2 = L11_2
  L17_2 = L12_2
  L18_2 = L13_2
  L14_2[1] = L15_2
  L14_2[2] = L16_2
  L14_2[3] = L17_2
  L14_2[4] = L18_2
  return L14_2
end
raycast_gameplay_cam = L13_1
function L13_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = memory
  L1_2 = L1_2.alloc
  L2_2 = 24
  L1_2 = L1_2(L2_2)
  L2_2 = memory
  L2_2 = L2_2.alloc
  L3_2 = 24
  L2_2 = L2_2(L3_2)
  L3_2 = MISC
  L3_2 = L3_2.GET_MODEL_DIMENSIONS
  L4_2 = A0_2
  L5_2 = L1_2
  L6_2 = L2_2
  L3_2(L4_2, L5_2, L6_2)
  L3_2 = memory
  L3_2 = L3_2.read_vector3
  L4_2 = L1_2
  L3_2 = L3_2(L4_2)
  min = L3_2
  L3_2 = memory
  L3_2 = L3_2.read_vector3
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  max = L3_2
  L3_2 = {}
  L4_2 = max
  L4_2 = L4_2.x
  L5_2 = min
  L5_2 = L5_2.x
  L4_2 = L4_2 - L5_2
  L3_2.x = L4_2
  L4_2 = max
  L4_2 = L4_2.y
  L5_2 = min
  L5_2 = L5_2.y
  L4_2 = L4_2 - L5_2
  L3_2.y = L4_2
  L4_2 = max
  L4_2 = L4_2.z
  L5_2 = min
  L5_2 = L5_2.z
  L4_2 = L4_2 - L5_2
  L3_2.z = L4_2
  L4_2 = math
  L4_2 = L4_2.max
  L5_2 = L3_2.x
  L6_2 = L3_2.y
  L7_2 = L3_2.z
  L4_2 = L4_2(L5_2, L6_2, L7_2)
  L3_2.max = L4_2
  return L3_2
end
get_model_size = L13_1
function L13_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = pairs
  L3_2 = entities
  L3_2 = L3_2.get_all_objects_as_handles
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L3_2()
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = ENTITY
    L8_2 = L8_2.GET_ENTITY_MODEL
    L9_2 = L7_2
    L8_2 = L8_2(L9_2)
    if L8_2 == L1_2 then
      L8_2 = ENTITY
      L8_2 = L8_2.SET_ENTITY_AS_MISSION_ENTITY
      L9_2 = L7_2
      L10_2 = false
      L11_2 = false
      L8_2(L9_2, L10_2, L11_2)
      L8_2 = delete_entity
      L9_2 = L7_2
      L8_2(L9_2)
    end
  end
end
delete_object = L13_1
function L13_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2
  L1_2 = players
  L1_2 = L1_2.get_position
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = L1_2.z
  L2_2 = L2_2 + 63
  L1_2.z = L2_2
  L2_2 = MISC
  L2_2 = L2_2.GET_HASH_KEY
  L3_2 = "p_spinning_anus_s"
  L2_2 = L2_2(L3_2)
  L3_2 = entities
  L3_2 = L3_2.create_object
  L4_2 = L2_2
  L5_2 = L1_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = PLAYER
  L4_2 = L4_2.GET_PLAYER_PED_SCRIPT_INDEX
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  L5_2 = PED
  L5_2 = L5_2.GET_VEHICLE_PED_IS_IN
  L6_2 = L4_2
  L7_2 = false
  L5_2 = L5_2(L6_2, L7_2)
  L6_2 = PED
  L6_2 = L6_2.IS_PED_IN_VEHICLE
  L7_2 = L4_2
  L8_2 = L5_2
  L9_2 = false
  L6_2 = L6_2(L7_2, L8_2, L9_2)
  if L6_2 then
    L6_2 = request_control
    L7_2 = L5_2
    L6_2(L7_2)
    L6_2 = ENTITY
    L6_2 = L6_2.GET_ENTITY_COORDS
    L7_2 = PLAYER
    L7_2 = L7_2.GET_PLAYER_PED
    L8_2 = A0_2
    L7_2 = L7_2(L8_2)
    L8_2 = false
    L6_2 = L6_2(L7_2, L8_2)
    L7_2 = VEHICLE
    L7_2 = L7_2.BRING_VEHICLE_TO_HALT
    L8_2 = L5_2
    L9_2 = 0.0
    L10_2 = 1
    L11_2 = false
    L7_2(L8_2, L9_2, L10_2, L11_2)
    L7_2 = FIRE
    L7_2 = L7_2.ADD_EXPLOSION
    L8_2 = L6_2.x
    L9_2 = L6_2.y
    L10_2 = L6_2.z
    L11_2 = 83
    L12_2 = 100.0
    L13_2 = false
    L14_2 = true
    L15_2 = 0.0
    L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
    L7_2 = util
    L7_2 = L7_2.yield
    L8_2 = 1000
    L7_2(L8_2)
    L7_2 = VEHICLE
    L7_2 = L7_2.SET_VEHICLE_ENGINE_ON
    L8_2 = L5_2
    L9_2 = false
    L10_2 = true
    L11_2 = true
    L7_2(L8_2, L9_2, L10_2, L11_2)
    L7_2 = ENTITY
    L7_2 = L7_2.APPLY_FORCE_TO_ENTITY
    L8_2 = L5_2
    L9_2 = 1
    L10_2 = 0.0
    L11_2 = 0.0
    L12_2 = 65
    L13_2 = 0.0
    L14_2 = 0.0
    L15_2 = 0.0
    L16_2 = 1
    L17_2 = false
    L18_2 = true
    L19_2 = true
    L20_2 = true
    L21_2 = true
    L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
    L7_2 = util
    L7_2 = L7_2.yield
    L8_2 = 6000
    L7_2(L8_2)
    L7_2 = delete_entity
    L8_2 = L3_2
    L7_2(L8_2)
  else
    L6_2 = delete_entity
    L7_2 = L3_2
    L6_2(L7_2)
    L6_2 = util
    L6_2 = L6_2.toast
    L7_2 = "目标不在车辆中"
    L6_2(L7_2)
  end
end
UFO_gravitation = L13_1
function L13_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  if A0_2 then
    L1_2 = CAM
    L1_2 = L1_2.DOES_CAM_EXIST
    L2_2 = antiCrashCam
    L1_2 = L1_2(L2_2)
    if not L1_2 then
      L1_2 = CAM
      L1_2 = L1_2.CREATE_CAM_WITH_PARAMS
      L2_2 = "DEFAULT_SCRIPTED_CAMERA"
      L3_2 = -10000
      L4_2 = -10000
      L5_2 = 3000
      L6_2 = 0
      L7_2 = 0
      L8_2 = 90
      L9_2 = 70
      L10_2 = true
      L11_2 = 1
      L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
      antiCrashCam = L1_2
    end
    L1_2 = CAM
    L1_2 = L1_2.RENDER_SCRIPT_CAMS
    L2_2 = true
    L3_2 = true
    L4_2 = 1
    L5_2 = false
    L6_2 = false
    L7_2 = false
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    L1_2 = CAM
    L1_2 = L1_2.SET_CAM_ACTIVE
    L2_2 = antiCrashCam
    L3_2 = true
    L1_2(L2_2, L3_2)
    L1_2 = PLAYER
    L1_2 = L1_2.SET_PLAYER_CONTROL
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_ID
    L2_2 = L2_2()
    L3_2 = false
    L4_2 = 0
    L1_2(L2_2, L3_2, L4_2)
  else
    L1_2 = CAM
    L1_2 = L1_2.SET_CAM_ACTIVE
    L2_2 = antiCrashCam
    L3_2 = false
    L1_2(L2_2, L3_2)
    L1_2 = CAM
    L1_2 = L1_2.RENDER_SCRIPT_CAMS
    L2_2 = false
    L3_2 = true
    L4_2 = 10
    L5_2 = false
    L6_2 = false
    L7_2 = false
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    L1_2 = CAM
    L1_2 = L1_2.DESTROY_CAM
    L2_2 = antiCrashCam
    L3_2 = false
    L1_2(L2_2, L3_2)
    L1_2 = PLAYER
    L1_2 = L1_2.SET_PLAYER_CONTROL
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_ID
    L2_2 = L2_2()
    L3_2 = true
    L4_2 = 0
    L1_2(L2_2, L3_2, L4_2)
  end
end
anti_crash_cam = L13_1
function L13_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = {}
  L0_2.a = 255
  L1_2 = math
  L1_2 = L1_2.random
  L2_2 = 0
  L3_2 = 255
  L1_2 = L1_2(L2_2, L3_2)
  L0_2.r = L1_2
  L1_2 = math
  L1_2 = L1_2.random
  L2_2 = 0
  L3_2 = 255
  L1_2 = L1_2(L2_2, L3_2)
  L0_2.g = L1_2
  L1_2 = math
  L1_2 = L1_2.random
  L2_2 = 0
  L3_2 = 255
  L1_2 = L1_2(L2_2, L3_2)
  L0_2.b = L1_2
  return L0_2
end
random_colour = L13_1
function L13_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = {}
  L2_2.a = 255
  L3_2 = A0_2 / 1000
  L4_2 = math
  L4_2 = L4_2.floor
  L5_2 = math
  L5_2 = L5_2.sin
  L6_2 = L3_2 * A1_2
  L6_2 = L6_2 + 0
  L5_2 = L5_2(L6_2)
  L5_2 = L5_2 * 127
  L5_2 = L5_2 + 128
  L4_2 = L4_2(L5_2)
  L2_2.r = L4_2
  L4_2 = math
  L4_2 = L4_2.floor
  L5_2 = math
  L5_2 = L5_2.sin
  L6_2 = L3_2 * A1_2
  L6_2 = L6_2 + 2
  L5_2 = L5_2(L6_2)
  L5_2 = L5_2 * 127
  L5_2 = L5_2 + 128
  L4_2 = L4_2(L5_2)
  L2_2.g = L4_2
  L4_2 = math
  L4_2 = L4_2.floor
  L5_2 = math
  L5_2 = L5_2.sin
  L6_2 = L3_2 * A1_2
  L6_2 = L6_2 + 4
  L5_2 = L5_2(L6_2)
  L5_2 = L5_2 * 127
  L5_2 = L5_2 + 128
  L4_2 = L4_2(L5_2)
  L2_2.b = L4_2
  return L2_2
end
gradient_colour = L13_1
function L13_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = PED
  L1_2 = L1_2.IS_PED_IN_GROUP
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if not L1_2 then
    L1_2 = PED
    L1_2 = L1_2.SET_PED_AS_GROUP_MEMBER
    L2_2 = A0_2
    L3_2 = PLAYER
    L3_2 = L3_2.GET_PLAYER_GROUP
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_ID
    L4_2, L5_2 = L4_2()
    L3_2, L4_2, L5_2 = L3_2(L4_2, L5_2)
    L1_2(L2_2, L3_2, L4_2, L5_2)
    L1_2 = PED
    L1_2 = L1_2.SET_PED_NEVER_LEAVES_GROUP
    L2_2 = A0_2
    L3_2 = true
    L1_2(L2_2, L3_2)
  end
  L1_2 = PED
  L1_2 = L1_2.SET_PED_RELATIONSHIP_GROUP_HASH
  L2_2 = A0_2
  L3_2 = util
  L3_2 = L3_2.joaat
  L4_2 = "rgFM_HateEveryOne"
  L3_2, L4_2, L5_2 = L3_2(L4_2)
  L1_2(L2_2, L3_2, L4_2, L5_2)
  L1_2 = PED
  L1_2 = L1_2.SET_GROUP_SEPARATION_RANGE
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_GROUP
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_ID
  L3_2, L4_2, L5_2 = L3_2()
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = 9999.0
  L1_2(L2_2, L3_2)
  L1_2 = PED
  L1_2 = L1_2.SET_GROUP_FORMATION_SPACING
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_GROUP
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_ID
  L3_2, L4_2, L5_2 = L3_2()
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = 1.0
  L4_2 = 0.9
  L5_2 = 3.0
  L1_2(L2_2, L3_2, L4_2, L5_2)
  L1_2 = PED
  L1_2 = L1_2.SET_GROUP_FORMATION
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_GROUP
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_ID
  L3_2, L4_2, L5_2 = L3_2()
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = 0
  L1_2(L2_2, L3_2)
end
join_group = L13_1
function L13_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = util
  L0_2 = L0_2.register_label
  L1_2 = "输入坐标(x,y,z),以','分开"
  L0_2 = L0_2(L1_2)
  L1_2 = get_input_from_screen_keyboard
  L2_2 = L0_2
  L3_2 = 20
  L4_2 = ""
  L1_2 = L1_2(L2_2, L3_2, L4_2)
  if "" == L1_2 then
    return
  end
  L2_2 = string
  L2_2 = L2_2.split
  L3_2 = L1_2
  L4_2 = ","
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = 1
  L4_2 = 3
  L5_2 = 1
  for L6_2 = L3_2, L4_2, L5_2 do
    L7_2 = tonumber
    L8_2 = L2_2[L6_2]
    L7_2 = L7_2(L8_2)
    L2_2[L6_2] = L7_2
    L7_2 = type
    L8_2 = L2_2[L6_2]
    L7_2 = L7_2(L8_2)
    if "number" == L7_2 then
      L7_2 = #L2_2
      if 3 == L7_2 then
        goto lbl_39
      end
    end
    L7_2 = util
    L7_2 = L7_2.toast
    L8_2 = "格式错误"
    L7_2(L8_2)
    do return end
    ::lbl_39::
  end
  L3_2 = teleport
  L4_2 = L2_2[1]
  L5_2 = L2_2[2]
  L6_2 = L2_2[3]
  L3_2(L4_2, L5_2, L6_2)
end
Custom_teleport = L13_1
function L13_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2
  L0_2 = is_entity_on_water
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
  if not L0_2 then
    L0_2 = notification
    L1_2 = "~y~~bold~不在水上:D"
    L2_2 = HudColour
    L2_2 = L2_2.blue
    L0_2(L1_2, L2_2)
    return
  end
  L0_2 = ENTITY
  L0_2 = L0_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = 0
  L3_2 = 0
  L4_2 = 0
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2)
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_HEADING
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "kosatka"
  L2_2 = L2_2(L3_2)
  L3_2 = request_model
  L4_2 = L2_2
  L3_2(L4_2)
  L3_2 = entities
  L3_2 = L3_2.create_vehicle
  L4_2 = L2_2
  L5_2 = L0_2
  L6_2 = L1_2
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  L4_2 = PED
  L4_2 = L4_2.SET_PED_INTO_VEHICLE
  L5_2 = PLAYER
  L5_2 = L5_2.PLAYER_PED_ID
  L5_2 = L5_2()
  L6_2 = L3_2
  L7_2 = -1
  L4_2(L5_2, L6_2, L7_2)
  L4_2 = ENTITY
  L4_2 = L4_2.SET_ENTITY_VISIBLE
  L5_2 = L3_2
  L6_2 = false
  L7_2 = false
  L4_2(L5_2, L6_2, L7_2)
  L4_2 = util
  L4_2 = L4_2.joaat
  L5_2 = "prop_cj_big_boat"
  L4_2 = L4_2(L5_2)
  L5_2 = request_model
  L6_2 = L4_2
  L5_2(L6_2)
  L5_2 = entities
  L5_2 = L5_2.create_object
  L6_2 = L4_2
  L7_2 = L0_2
  L8_2 = L1_2
  L5_2 = L5_2(L6_2, L7_2, L8_2)
  L6_2 = ENTITY
  L6_2 = L6_2.ATTACH_ENTITY_TO_ENTITY
  L7_2 = L5_2
  L8_2 = L3_2
  L9_2 = 0
  L10_2 = 0
  L11_2 = 0
  L12_2 = 0
  L13_2 = 0
  L14_2 = 0
  L15_2 = 0
  L16_2 = true
  L17_2 = false
  L18_2 = false
  L19_2 = true
  L20_2 = 0
  L21_2 = true
  L22_2 = 0
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
  L6_2 = ENTITY
  L6_2 = L6_2.SET_ENTITY_COLLISION
  L7_2 = L5_2
  L8_2 = true
  L9_2 = false
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = ENTITY
  L6_2 = L6_2.SET_ENTITY_COLLISION
  L7_2 = L3_2
  L8_2 = false
  L9_2 = false
  L6_2(L7_2, L8_2, L9_2)
end
super_yacht = L13_1
function L13_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L3_2 = 510628364
  L4_2 = create_object
  L5_2 = L3_2
  L6_2 = A0_2
  L7_2 = A1_2
  L8_2 = A2_2
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_VISIBLE
  L6_2 = L4_2
  L7_2 = true
  L8_2 = false
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_COLLISION
  L6_2 = L4_2
  L7_2 = false
  L5_2(L6_2, L7_2)
  L5_2 = ENTITY
  L5_2 = L5_2.FREEZE_ENTITY_POSITION
  L6_2 = L4_2
  L7_2 = true
  L5_2(L6_2, L7_2)
  return L4_2
end
create_shooting_target = L13_1
L13_1 = {}
L14_1 = "Lazer"
L15_1 = "raiju"
L16_1 = "molotok"
L17_1 = "pyro"
L18_1 = "strikeforce"
L19_1 = "seabreeze"
L20_1 = "howard"
L21_1 = "besra"
L22_1 = "starling"
L23_1 = "rogue"
L24_1 = "Stunt"
L25_1 = "alphaz1"
L26_1 = "nimbus"
L27_1 = "luxor2"
L28_1 = "mogul"
L29_1 = "streamer216"
L30_1 = "vestra"
L31_1 = "cuban800"
L32_1 = "dodo"
L33_1 = "velum"
L34_1 = "mammatus"
L35_1 = "duster"
L36_1 = "microlight"
L13_1[1] = L14_1
L13_1[2] = L15_1
L13_1[3] = L16_1
L13_1[4] = L17_1
L13_1[5] = L18_1
L13_1[6] = L19_1
L13_1[7] = L20_1
L13_1[8] = L21_1
L13_1[9] = L22_1
L13_1[10] = L23_1
L13_1[11] = L24_1
L13_1[12] = L25_1
L13_1[13] = L26_1
L13_1[14] = L27_1
L13_1[15] = L28_1
L13_1[16] = L29_1
L13_1[17] = L30_1
L13_1[18] = L31_1
L13_1[19] = L32_1
L13_1[20] = L33_1
L13_1[21] = L34_1
L13_1[22] = L35_1
L13_1[23] = L36_1
function L14_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  L0_2 = v3
  L0_2 = L0_2.new
  L0_2 = L0_2()
  L1_2 = WEAPON
  L1_2 = L1_2.GET_PED_LAST_WEAPON_IMPACT_COORD
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = L0_2
  L1_2 = L1_2(L2_2, L3_2)
  if L1_2 then
    L1_2 = PED
    L1_2 = L1_2.IS_PED_IN_ANY_VEHICLE
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L2_2()
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    if not L1_2 then
      L1_2 = 1267718013
      L2_2 = request_model
      L3_2 = L1_2
      L2_2(L3_2)
      L2_2 = OBJECT
      L2_2 = L2_2.CREATE_OBJECT
      L3_2 = L1_2
      L4_2 = L0_2.x
      L5_2 = L0_2.y
      L6_2 = L0_2.z
      L6_2 = L6_2 + 0.1
      L7_2 = true
      L8_2 = false
      L9_2 = true
      L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
      L3_2 = ENTITY
      L3_2 = L3_2.SET_ENTITY_ROTATION
      L4_2 = L2_2
      L5_2 = 0
      L6_2 = 0
      L7_2 = 90
      L8_2 = 2
      L9_2 = true
      L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
      L3_2 = ENTITY
      L3_2 = L3_2.SET_ENTITY_VISIBLE
      L4_2 = L2_2
      L5_2 = false
      L6_2 = false
      L3_2(L4_2, L5_2, L6_2)
      L3_2 = ENTITY
      L3_2 = L3_2.SET_ENTITY_COLLISION
      L4_2 = L2_2
      L5_2 = false
      L3_2(L4_2, L5_2)
      L3_2 = ENTITY
      L3_2 = L3_2.FREEZE_ENTITY_POSITION
      L4_2 = L2_2
      L5_2 = true
      L3_2(L4_2, L5_2)
      L3_2 = create_shooting_target
      L4_2 = L0_2.x
      L5_2 = L0_2.y
      L6_2 = L0_2.z
      L3_2 = L3_2(L4_2, L5_2, L6_2)
      L4_2 = PLAYER
      L4_2 = L4_2.GET_PLAYER_PED_SCRIPT_INDEX
      L5_2 = PLAYER
      L5_2 = L5_2.PLAYER_PED_ID
      L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L5_2()
      L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
      L5_2 = util
      L5_2 = L5_2.joaat
      L6_2 = math
      L6_2 = L6_2.random
      L7_2 = 1
      L8_2 = L13_1
      L8_2 = #L8_2
      L6_2 = L6_2(L7_2, L8_2)
      L7_2 = L13_1
      L6_2 = L7_2[L6_2]
      L5_2 = L5_2(L6_2)
      L6_2 = request_model
      L7_2 = L5_2
      L6_2(L7_2)
      L6_2 = ENTITY
      L6_2 = L6_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
      L7_2 = L2_2
      L8_2 = math
      L8_2 = L8_2.random
      L9_2 = -200
      L10_2 = 200
      L8_2 = L8_2(L9_2, L10_2)
      L9_2 = math
      L9_2 = L9_2.random
      L10_2 = -200
      L11_2 = 200
      L9_2 = L9_2(L10_2, L11_2)
      L10_2 = math
      L10_2 = L10_2.random
      L11_2 = 100
      L12_2 = 500
      L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L10_2(L11_2, L12_2)
      L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
      L7_2 = entities
      L7_2 = L7_2.create_vehicle
      L8_2 = L5_2
      L9_2 = L6_2
      L10_2 = math
      L10_2 = L10_2.random
      L11_2 = -180
      L12_2 = 180
      L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L10_2(L11_2, L12_2)
      L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
      L8_2 = CAM
      L8_2 = L8_2.CREATE_CAMERA
      L9_2 = 26379945
      L10_2 = true
      L8_2 = L8_2(L9_2, L10_2)
      L9_2 = util
      L9_2 = L9_2.create_tick_handler
      function L10_2()
        local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3
        L0_3 = Get_Distance
        L1_3 = ENTITY
        L1_3 = L1_3.GET_ENTITY_COORDS
        L2_3 = L3_2
        L3_3 = false
        L1_3 = L1_3(L2_3, L3_3)
        L2_3 = ENTITY
        L2_3 = L2_3.GET_ENTITY_COORDS
        L3_3 = L7_2
        L4_3 = false
        L2_3 = L2_3(L3_3, L4_3)
        L3_3 = true
        L0_3 = L0_3(L1_3, L2_3, L3_3)
        if L0_3 > 10 then
          L1_3 = ENTITY
          L1_3 = L1_3.SET_ENTITY_COLLISION
          L2_3 = L7_2
          L3_3 = false
          L4_3 = true
          L1_3(L2_3, L3_3, L4_3)
        else
          L1_3 = ENTITY
          L1_3 = L1_3.SET_ENTITY_COLLISION
          L2_3 = L7_2
          L3_3 = true
          L4_3 = true
          L1_3(L2_3, L3_3, L4_3)
        end
        L1_3 = ENTITY
        L1_3 = L1_3.DOES_ENTITY_EXIST
        L2_3 = L7_2
        L1_3 = L1_3(L2_3)
        if L1_3 then
          L1_3 = PLAYER
          L1_3 = L1_3.DISABLE_PLAYER_FIRING
          L2_3 = PLAYER
          L2_3 = L2_3.PLAYER_PED_ID
          L2_3 = L2_3()
          L3_3 = true
          L1_3(L2_3, L3_3)
        else
          L1_3 = PLAYER
          L1_3 = L1_3.DISABLE_PLAYER_FIRING
          L2_3 = PLAYER
          L2_3 = L2_3.PLAYER_PED_ID
          L2_3 = L2_3()
          L3_3 = false
          L1_3(L2_3, L3_3)
        end
        L1_3 = set_entity_face_entity
        L2_3 = L7_2
        L3_3 = L2_2
        L4_3 = true
        L1_3(L2_3, L3_3, L4_3)
        L1_3 = ENTITY
        L1_3 = L1_3.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
        L2_3 = L7_2
        L3_3 = 1
        L4_3 = 0
        L5_3 = 1.5
        L6_3 = 0.0
        L7_3 = true
        L8_3 = true
        L9_3 = true
        L10_3 = true
        L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3)
        L1_3 = CAM
        L1_3 = L1_3.RENDER_SCRIPT_CAMS
        L2_3 = true
        L3_3 = false
        L4_3 = 3000
        L5_3 = 1
        L6_3 = 0
        L7_3 = 0
        L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3)
        L1_3 = CAM
        L1_3 = L1_3.SHAKE_CAM
        L2_3 = L8_2
        L3_3 = "DRUNK_SHAKE"
        L4_3 = 1
        L1_3(L2_3, L3_3, L4_3)
        L1_3 = GRAPHICS
        L1_3 = L1_3.ANIMPOSTFX_PLAY
        L2_3 = "MP_corona_switch_supermod"
        L3_3 = 0
        L4_3 = true
        L1_3(L2_3, L3_3, L4_3)
        L1_3 = GRAPHICS
        L1_3 = L1_3.ANIMPOSTFX_PLAY
        L2_3 = "MP_OrbitalCannon"
        L3_3 = 0
        L4_3 = true
        L1_3(L2_3, L3_3, L4_3)
        L1_3 = ENTITY
        L1_3 = L1_3.HAS_ENTITY_COLLIDED_WITH_ANYTHING
        L2_3 = L7_2
        L1_3 = L1_3(L2_3)
        if L1_3 then
          L1_3 = ENTITY
          L1_3 = L1_3.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
          L2_3 = L7_2
          L3_3 = math
          L3_3 = L3_3.random
          L4_3 = -5
          L5_3 = 5
          L3_3 = L3_3(L4_3, L5_3)
          L4_3 = math
          L4_3 = L4_3.random
          L5_3 = -5
          L6_3 = 5
          L4_3 = L4_3(L5_3, L6_3)
          L5_3 = math
          L5_3 = L5_3.random
          L6_3 = -5
          L7_3 = 5
          L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3 = L5_3(L6_3, L7_3)
          L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3)
          L2_3 = FIRE
          L2_3 = L2_3.ADD_EXPLOSION
          L3_3 = L1_3.x
          L4_3 = L1_3.y
          L5_3 = L1_3.z
          L6_3 = 59
          L7_3 = 1
          L8_3 = true
          L9_3 = false
          L10_3 = 1.0
          L11_3 = false
          L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3)
          L2_3 = AUDIO
          L2_3 = L2_3.PLAY_SOUND_FROM_ENTITY
          L3_3 = -1
          L4_3 = "DLC_XM_Explosions_Orbital_Cannon"
          L5_3 = L7_2
          L6_3 = 0
          L7_3 = true
          L8_3 = 0
          L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3)
          L2_3 = util
          L2_3 = L2_3.yield
          L3_3 = 1500
          L2_3(L3_3)
          L2_3 = CAM
          L2_3 = L2_3.RENDER_SCRIPT_CAMS
          L3_3 = false
          L4_3 = false
          L5_3 = 3000
          L6_3 = 1
          L7_3 = 0
          L8_3 = 0
          L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3)
          L2_3 = CAM
          L2_3 = L2_3.DESTROY_CAM
          L3_3 = L8_2
          L4_3 = true
          L2_3(L3_3, L4_3)
          L2_3 = GRAPHICS
          L2_3 = L2_3.ANIMPOSTFX_STOP
          L3_3 = "MP_OrbitalCannon"
          L4_3 = 0
          L5_3 = true
          L2_3(L3_3, L4_3, L5_3)
          L2_3 = GRAPHICS
          L2_3 = L2_3.ANIMPOSTFX_STOP
          L3_3 = "MP_OrbitalCannon"
          L4_3 = 0
          L5_3 = true
          L2_3(L3_3, L4_3, L5_3)
          L2_3 = GRAPHICS
          L2_3 = L2_3.ANIMPOSTFX_STOP
          L3_3 = "MP_corona_switch_supermod"
          L4_3 = 0
          L5_3 = true
          L2_3(L3_3, L4_3, L5_3)
          L2_3 = GRAPHICS
          L2_3 = L2_3.ANIMPOSTFX_STOP
          L3_3 = "MP_corona_switch_supermod"
          L4_3 = 0
          L5_3 = true
          L2_3(L3_3, L4_3, L5_3)
          L2_3 = delete_entity
          L3_3 = L7_2
          L2_3(L3_3)
          L2_3 = delete_entity
          L3_3 = L2_2
          L2_3(L3_3)
          L2_3 = delete_entity
          L3_3 = L3_2
          L2_3(L3_3)
          L2_3 = false
          return L2_3
        end
      end
      L9_2(L10_2)
      L9_2 = CAM
      L9_2 = L9_2.HARD_ATTACH_CAM_TO_ENTITY
      L10_2 = L8_2
      L11_2 = L7_2
      L12_2 = -10
      L13_2 = 0
      L14_2 = 0
      L15_2 = 0
      L16_2 = -10
      L17_2 = 6
      L18_2 = true
      L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
      L9_2 = VEHICLE
      L9_2 = L9_2.GET_VEHICLE_CAUSE_OF_DESTRUCTION
      L10_2 = L7_2
      L9_2 = L9_2(L10_2)
      L10_2 = VEHICLE
      L10_2 = L10_2.SET_ALLOW_VEHICLE_EXPLODES_ON_CONTACT
      L11_2 = L7_2
      L12_2 = true
      L10_2(L11_2, L12_2)
      L10_2 = VEHICLE
      L10_2 = L10_2.SET_VEHICLE_ENGINE_ON
      L11_2 = L7_2
      L12_2 = true
      L13_2 = true
      L14_2 = 0
      L10_2(L11_2, L12_2, L13_2, L14_2)
      L10_2 = PED
      L10_2 = L10_2.CREATE_RANDOM_PED_AS_DRIVER
      L11_2 = L7_2
      L12_2 = 1
      L10_2 = L10_2(L11_2, L12_2)
      KamikazePilot = L10_2
      L10_2 = VEHICLE
      L10_2 = L10_2.CONTROL_LANDING_GEAR
      L11_2 = L7_2
      L12_2 = 3
      L10_2(L11_2, L12_2)
    end
  end
end
Kamikaze_Gun = L14_1
function L14_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_COORDS
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED
  L3_2 = A0_2
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L2_2(L3_2)
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = math
  L3_2 = L3_2.random
  L4_2 = 1
  L5_2 = L13_1
  L5_2 = #L5_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = L13_1
  L3_2 = L4_2[L3_2]
  L2_2 = L2_2(L3_2)
  L3_2 = request_model
  L4_2 = L2_2
  L3_2(L4_2)
  L3_2 = ENTITY
  L3_2 = L3_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L4_2 = PLAYER
  L4_2 = L4_2.GET_PLAYER_PED
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  L5_2 = math
  L5_2 = L5_2.random
  L6_2 = -200
  L7_2 = 200
  L5_2 = L5_2(L6_2, L7_2)
  L6_2 = math
  L6_2 = L6_2.random
  L7_2 = -200
  L8_2 = 200
  L6_2 = L6_2(L7_2, L8_2)
  L7_2 = math
  L7_2 = L7_2.random
  L8_2 = 100
  L9_2 = 500
  L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L7_2(L8_2, L9_2)
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  L4_2 = entities
  L4_2 = L4_2.create_vehicle
  L5_2 = L2_2
  L6_2 = L3_2
  L7_2 = math
  L7_2 = L7_2.random
  L8_2 = -180
  L9_2 = 180
  L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L7_2(L8_2, L9_2)
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  L5_2 = CAM
  L5_2 = L5_2.CREATE_CAMERA
  L6_2 = 26379945
  L7_2 = true
  L5_2 = L5_2(L6_2, L7_2)
  L6_2 = util
  L6_2 = L6_2.create_tick_handler
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3
    L0_3 = Get_Distance
    L1_3 = ENTITY
    L1_3 = L1_3.GET_ENTITY_COORDS
    L2_3 = PLAYER
    L2_3 = L2_3.GET_PLAYER_PED
    L3_3 = A0_2
    L2_3 = L2_3(L3_3)
    L3_3 = false
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = ENTITY
    L2_3 = L2_3.GET_ENTITY_COORDS
    L3_3 = L4_2
    L4_3 = false
    L2_3 = L2_3(L3_3, L4_3)
    L3_3 = true
    L0_3 = L0_3(L1_3, L2_3, L3_3)
    if L0_3 > 10 then
      L1_3 = ENTITY
      L1_3 = L1_3.SET_ENTITY_COLLISION
      L2_3 = L4_2
      L3_3 = false
      L4_3 = true
      L1_3(L2_3, L3_3, L4_3)
    else
      L1_3 = ENTITY
      L1_3 = L1_3.SET_ENTITY_COLLISION
      L2_3 = L4_2
      L3_3 = true
      L4_3 = true
      L1_3(L2_3, L3_3, L4_3)
    end
    L1_3 = set_entity_face_entity
    L2_3 = L4_2
    L3_3 = PLAYER
    L3_3 = L3_3.GET_PLAYER_PED
    L4_3 = A0_2
    L3_3 = L3_3(L4_3)
    L4_3 = true
    L1_3(L2_3, L3_3, L4_3)
    L1_3 = ENTITY
    L1_3 = L1_3.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
    L2_3 = L4_2
    L3_3 = 1
    L4_3 = 0
    L5_3 = 1.5
    L6_3 = 0.0
    L7_3 = true
    L8_3 = true
    L9_3 = true
    L10_3 = true
    L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3)
    L1_3 = CAM
    L1_3 = L1_3.RENDER_SCRIPT_CAMS
    L2_3 = true
    L3_3 = false
    L4_3 = 3000
    L5_3 = 1
    L6_3 = 0
    L7_3 = 0
    L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3)
    L1_3 = CAM
    L1_3 = L1_3.SHAKE_CAM
    L2_3 = L5_2
    L3_3 = "DRUNK_SHAKE"
    L4_3 = 1
    L1_3(L2_3, L3_3, L4_3)
    L1_3 = GRAPHICS
    L1_3 = L1_3.ANIMPOSTFX_PLAY
    L2_3 = "MP_corona_switch_supermod"
    L3_3 = 0
    L4_3 = true
    L1_3(L2_3, L3_3, L4_3)
    L1_3 = GRAPHICS
    L1_3 = L1_3.ANIMPOSTFX_PLAY
    L2_3 = "MP_OrbitalCannon"
    L3_3 = 0
    L4_3 = true
    L1_3(L2_3, L3_3, L4_3)
    L1_3 = ENTITY
    L1_3 = L1_3.HAS_ENTITY_COLLIDED_WITH_ANYTHING
    L2_3 = L4_2
    L1_3 = L1_3(L2_3)
    if L1_3 then
      L1_3 = ENTITY
      L1_3 = L1_3.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
      L2_3 = L4_2
      L3_3 = math
      L3_3 = L3_3.random
      L4_3 = -5
      L5_3 = 5
      L3_3 = L3_3(L4_3, L5_3)
      L4_3 = math
      L4_3 = L4_3.random
      L5_3 = -5
      L6_3 = 5
      L4_3 = L4_3(L5_3, L6_3)
      L5_3 = math
      L5_3 = L5_3.random
      L6_3 = -5
      L7_3 = 5
      L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3 = L5_3(L6_3, L7_3)
      L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3)
      L2_3 = FIRE
      L2_3 = L2_3.ADD_EXPLOSION
      L3_3 = L1_3.x
      L4_3 = L1_3.y
      L5_3 = L1_3.z
      L6_3 = 59
      L7_3 = 1
      L8_3 = true
      L9_3 = false
      L10_3 = 1.0
      L11_3 = false
      L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3)
      L2_3 = AUDIO
      L2_3 = L2_3.PLAY_SOUND_FROM_ENTITY
      L3_3 = -1
      L4_3 = "DLC_XM_Explosions_Orbital_Cannon"
      L5_3 = L4_2
      L6_3 = 0
      L7_3 = true
      L8_3 = 0
      L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3)
      L2_3 = util
      L2_3 = L2_3.yield
      L3_3 = 1500
      L2_3(L3_3)
      L2_3 = CAM
      L2_3 = L2_3.RENDER_SCRIPT_CAMS
      L3_3 = false
      L4_3 = false
      L5_3 = 3000
      L6_3 = 1
      L7_3 = 0
      L8_3 = 0
      L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3)
      L2_3 = CAM
      L2_3 = L2_3.DESTROY_CAM
      L3_3 = L5_2
      L4_3 = true
      L2_3(L3_3, L4_3)
      L2_3 = GRAPHICS
      L2_3 = L2_3.ANIMPOSTFX_STOP
      L3_3 = "MP_OrbitalCannon"
      L4_3 = 0
      L5_3 = true
      L2_3(L3_3, L4_3, L5_3)
      L2_3 = GRAPHICS
      L2_3 = L2_3.ANIMPOSTFX_STOP
      L3_3 = "MP_OrbitalCannon"
      L4_3 = 0
      L5_3 = true
      L2_3(L3_3, L4_3, L5_3)
      L2_3 = GRAPHICS
      L2_3 = L2_3.ANIMPOSTFX_STOP
      L3_3 = "MP_corona_switch_supermod"
      L4_3 = 0
      L5_3 = true
      L2_3(L3_3, L4_3, L5_3)
      L2_3 = GRAPHICS
      L2_3 = L2_3.ANIMPOSTFX_STOP
      L3_3 = "MP_corona_switch_supermod"
      L4_3 = 0
      L5_3 = true
      L2_3(L3_3, L4_3, L5_3)
      L2_3 = delete_entity
      L3_3 = L4_2
      L2_3(L3_3)
      L2_3 = false
      return L2_3
    end
  end
  L6_2(L7_2)
  L6_2 = CAM
  L6_2 = L6_2.HARD_ATTACH_CAM_TO_ENTITY
  L7_2 = L5_2
  L8_2 = L4_2
  L9_2 = -10
  L10_2 = 0
  L11_2 = 0
  L12_2 = 0
  L13_2 = -10
  L14_2 = 6
  L15_2 = true
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  L6_2 = VEHICLE
  L6_2 = L6_2.GET_VEHICLE_CAUSE_OF_DESTRUCTION
  L7_2 = L4_2
  L6_2 = L6_2(L7_2)
  L7_2 = VEHICLE
  L7_2 = L7_2.SET_ALLOW_VEHICLE_EXPLODES_ON_CONTACT
  L8_2 = L4_2
  L9_2 = true
  L7_2(L8_2, L9_2)
  L7_2 = VEHICLE
  L7_2 = L7_2.SET_VEHICLE_ENGINE_ON
  L8_2 = L4_2
  L9_2 = true
  L10_2 = true
  L11_2 = 0
  L7_2(L8_2, L9_2, L10_2, L11_2)
  L7_2 = PED
  L7_2 = L7_2.CREATE_RANDOM_PED_AS_DRIVER
  L8_2 = L4_2
  L9_2 = 1
  L7_2 = L7_2(L8_2, L9_2)
  KamikazePilot = L7_2
  L7_2 = VEHICLE
  L7_2 = L7_2.CONTROL_LANDING_GEAR
  L8_2 = L4_2
  L9_2 = 3
  L7_2(L8_2, L9_2)
end
Send_Kamikaze_Gun = L14_1
function L14_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L0_2 = 0.01
  L1_2 = 0.005
  L2_2 = 0
  L3_2 = 32
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = PLAYER
    L6_2 = L6_2.GET_PLAYER_PED
    L7_2 = L5_2
    L6_2 = L6_2(L7_2)
    if 0 ~= L6_2 then
      L6_2 = PLAYER
      L6_2 = L6_2.GET_PLAYER_NAME
      L7_2 = L5_2
      L6_2 = L6_2(L7_2)
      L7_2 = " ["
      L8_2 = "~w~"
      L9_2 = "~o~"
      L10_2 = memory
      L10_2 = L10_2.alloc
      L11_2 = 52
      L10_2 = L10_2(L11_2)
      L11_2 = NETWORK
      L11_2 = L11_2.NETWORK_HANDLE_FROM_PLAYER
      L12_2 = L5_2
      L13_2 = L10_2
      L14_2 = 13
      L11_2(L12_2, L13_2, L14_2)
      L11_2 = players
      L11_2 = L11_2.get_host
      L11_2 = L11_2()
      if L11_2 == L5_2 then
        L11_2 = L7_2
        L12_2 = "H"
        L11_2 = L11_2 .. L12_2
        L7_2 = L11_2
        L8_2 = "~y~"
      end
      L11_2 = players
      L11_2 = L11_2.get_script_host
      L11_2 = L11_2()
      if L11_2 == L5_2 then
        L11_2 = L7_2
        L12_2 = "S"
        L11_2 = L11_2 .. L12_2
        L7_2 = L11_2
        L8_2 = "~b~"
      end
      L11_2 = players
      L11_2 = L11_2.is_marked_as_modder
      L12_2 = L5_2
      L11_2 = L11_2(L12_2)
      if L11_2 then
        L11_2 = L7_2
        L12_2 = "M"
        L11_2 = L11_2 .. L12_2
        L7_2 = L11_2
        L8_2 = "~r~"
      end
      L11_2 = players
      L11_2 = L11_2.is_godmode
      L12_2 = L5_2
      L11_2 = L11_2(L12_2)
      if L11_2 then
        L11_2 = L7_2
        L12_2 = "G"
        L11_2 = L11_2 .. L12_2
        L7_2 = L11_2
      end
      L11_2 = players
      L11_2 = L11_2.is_in_interior
      L12_2 = L5_2
      L11_2 = L11_2(L12_2)
      if L11_2 then
        L11_2 = L7_2
        L12_2 = "I"
        L11_2 = L11_2 .. L12_2
        L7_2 = L11_2
        L8_2 = "~g~"
      end
      L11_2 = NETWORK
      L11_2 = L11_2.NETWORK_IS_FRIEND
      L12_2 = L10_2
      L11_2 = L11_2(L12_2)
      if L11_2 then
        L11_2 = L7_2
        L12_2 = "F"
        L11_2 = L11_2 .. L12_2
        L7_2 = L11_2
        L8_2 = "~q~"
      end
      L11_2 = PLAYER
      L11_2 = L11_2.PLAYER_ID
      L11_2 = L11_2()
      if L11_2 == L5_2 then
        L8_2 = "~b~"
      end
      if " [" == L7_2 then
        L7_2 = ""
      else
        L11_2 = L7_2
        L12_2 = "]"
        L11_2 = L11_2 .. L12_2
        L7_2 = L11_2
      end
      L11_2 = draw_string
      L12_2 = L8_2
      L13_2 = L6_2
      L14_2 = L9_2
      L15_2 = L7_2
      L12_2 = L12_2 .. L13_2 .. L14_2 .. L15_2
      L13_2 = L0_2
      L14_2 = L1_2
      L15_2 = 0.4
      L16_2 = 4
      L11_2(L12_2, L13_2, L14_2, L15_2, L16_2)
      L11_2 = #L6_2
      L12_2 = #L7_2
      L11_2 = L11_2 + L12_2
      L11_2 = L11_2 / 400
      L11_2 = L0_2 + L11_2
      L0_2 = L11_2 + 0.04
      L11_2 = 0.93
      if L0_2 > L11_2 then
        L1_2 = L1_2 + 0.02
        L0_2 = 0.01
      end
    end
  end
end
player_bar = L14_1
function L14_1()
  local L0_2, L1_2, L2_2
  L0_2 = PED
  L0_2 = L0_2.IS_PED_SHOOTING
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2)
  if L0_2 then
    L0_2 = get_entity_player_is_aiming_at
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_ID
    L1_2, L2_2 = L1_2()
    L0_2 = L0_2(L1_2, L2_2)
    L1_2 = NETWORK
    L1_2 = L1_2.NETWORK_REQUEST_CONTROL_OF_ENTITY
    L2_2 = L0_2
    L1_2(L2_2)
    L1_2 = ENTITY
    L1_2 = L1_2.DOES_ENTITY_EXIST
    L2_2 = L0_2
    L1_2 = L1_2(L2_2)
    if L1_2 then
      L1_2 = ENTITY
      L1_2 = L1_2.IS_AN_ENTITY
      L2_2 = L0_2
      L1_2 = L1_2(L2_2)
      if L1_2 then
        L1_2 = PED
        L1_2 = L1_2.IS_PED_A_PLAYER
        L2_2 = L0_2
        L1_2 = L1_2(L2_2)
        if not L1_2 then
          L1_2 = delete_entity
          L2_2 = L0_2
          L1_2(L2_2)
        end
      end
    end
  end
end
delete_gun = L14_1
function L14_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  L0_2 = PED
  L0_2 = L0_2.GET_VEHICLE_PED_IS_IN
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_ID
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  L2_2 = false
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = AUDIO
  L1_2 = L1_2.IS_HORN_ACTIVE
  L2_2 = L0_2
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.GET_ENTITY_COORDS
    L2_2 = L0_2
    L1_2 = L1_2(L2_2)
    L2_2 = v3
    L2_2 = L2_2.new
    L3_2 = L1_2
    L2_2 = L2_2(L3_2)
    L3_2 = 1
    L4_2 = 3
    L5_2 = 1
    for L6_2 = L3_2, L4_2, L5_2 do
      L7_2 = ENTITY
      L7_2 = L7_2.GET_ENTITY_ROTATION
      L8_2 = L0_2
      L9_2 = 2
      L7_2 = L7_2(L8_2, L9_2)
      L8_2 = L7_2
      L7_2 = L7_2.toDir
      L7_2 = L7_2(L8_2)
      L8_2 = ENTITY
      L8_2 = L8_2.GET_ENTITY_VELOCITY
      L9_2 = L0_2
      L8_2 = L8_2(L9_2)
      L9_2 = v3
      L9_2 = L9_2.mul
      L10_2 = L7_2
      L11_2 = math
      L11_2 = L11_2.abs
      L12_2 = L8_2.x
      L11_2 = L11_2(L12_2)
      L11_2 = 25 + L11_2
      L9_2(L10_2, L11_2)
      L9_2 = v3
      L9_2 = L9_2.add
      L10_2 = L2_2
      L11_2 = L7_2
      L9_2(L10_2, L11_2)
      L9_2 = FIRE
      L9_2 = L9_2.ADD_OWNED_EXPLOSION
      L10_2 = VEHICLE
      L10_2 = L10_2.GET_PED_IN_VEHICLE_SEAT
      L11_2 = L0_2
      L12_2 = -1
      L10_2 = L10_2(L11_2, L12_2)
      L11_2 = L2_2.x
      L12_2 = math
      L12_2 = L12_2.random
      L13_2 = -2
      L14_2 = 2
      L12_2 = L12_2(L13_2, L14_2)
      L11_2 = L11_2 + L12_2
      L12_2 = L2_2.y
      L13_2 = math
      L13_2 = L13_2.random
      L14_2 = -2
      L15_2 = 2
      L13_2 = L13_2(L14_2, L15_2)
      L12_2 = L12_2 + L13_2
      L13_2 = L2_2.z
      L14_2 = 10
      L15_2 = 100
      L16_2 = true
      L17_2 = false
      L18_2 = 0.1
      L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
      L9_2 = util
      L9_2 = L9_2.yield
      L9_2()
    end
  end
end
horn_bomb = L14_1
function L14_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if 0 ~= L1_2 then
    L1_2 = PLAYER
    L1_2 = L1_2.GET_PLAYER_PED_SCRIPT_INDEX
    L2_2 = A0_2
    L1_2 = L1_2(L2_2)
    L2_2 = ENTITY
    L2_2 = L2_2.GET_ENTITY_COORDS
    L3_2 = L1_2
    L4_2 = false
    L2_2 = L2_2(L3_2, L4_2)
    L3_2 = util
    L3_2 = L3_2.joaat
    L4_2 = "prop_shuttering03"
    L3_2 = L3_2(L4_2)
    L4_2 = request_model
    L5_2 = L3_2
    L4_2(L5_2)
    L4_2 = ENTITY
    L4_2 = L4_2.APPLY_FORCE_TO_ENTITY
    L5_2 = PLAYER
    L5_2 = L5_2.GET_PLAYER_PED
    L6_2 = A0_2
    L5_2 = L5_2(L6_2)
    L6_2 = 3
    L7_2 = 50
    L8_2 = 50
    L9_2 = 0
    L10_2 = 0.0
    L11_2 = 0.0
    L12_2 = 0.0
    L13_2 = 0
    L14_2 = false
    L15_2 = false
    L16_2 = true
    L17_2 = false
    L18_2 = false
    L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L4_2 = entities
    L4_2 = L4_2.create_object
    L5_2 = L3_2
    L6_2 = ENTITY
    L6_2 = L6_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
    L7_2 = PLAYER
    L7_2 = L7_2.GET_PLAYER_PED
    L8_2 = A0_2
    L7_2 = L7_2(L8_2)
    L8_2 = 0
    L9_2 = 1
    L10_2 = 0
    L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
    L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L5_2 = entities
    L5_2 = L5_2.create_object
    L6_2 = L3_2
    L7_2 = ENTITY
    L7_2 = L7_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
    L8_2 = PLAYER
    L8_2 = L8_2.GET_PLAYER_PED
    L9_2 = A0_2
    L8_2 = L8_2(L9_2)
    L9_2 = 0
    L10_2 = 0
    L11_2 = 0
    L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L7_2(L8_2, L9_2, L10_2, L11_2)
    L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L6_2 = ENTITY
    L6_2 = L6_2.SET_ENTITY_VISIBLE
    L7_2 = L4_2
    L8_2 = false
    L6_2(L7_2, L8_2)
    L6_2 = ENTITY
    L6_2 = L6_2.SET_ENTITY_VISIBLE
    L7_2 = L5_2
    L8_2 = false
    L6_2(L7_2, L8_2)
    L6_2 = util
    L6_2 = L6_2.yield
    L6_2()
    L6_2 = delete_entity
    L7_2 = L4_2
    L6_2(L7_2)
    L6_2 = delete_entity
    L7_2 = L5_2
    L6_2(L7_2)
    L6_2 = util
    L6_2 = L6_2.yield
    L6_2()
  end
end
Driving_Player = L14_1
function L14_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L1_2 = 1768956181
  L2_2 = ENTITY
  L2_2 = L2_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L3_2 = PLAYER
  L3_2 = L3_2.GET_PLAYER_PED
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = 0
  L5_2 = 0
  L6_2 = -1
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  L3_2 = {}
  L4_2 = 1
  L5_2 = 18
  L6_2 = 1
  for L7_2 = L4_2, L5_2, L6_2 do
    L8_2 = create_object
    L9_2 = L1_2
    L10_2 = L2_2.x
    L11_2 = L2_2.y
    L12_2 = L2_2.z
    L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2)
    L3_2[L7_2] = L8_2
    L8_2 = ENTITY
    L8_2 = L8_2.SET_ENTITY_ROTATION
    L9_2 = L3_2[L7_2]
    L10_2 = 0
    L11_2 = 0
    L12_2 = L7_2 * 10
    L13_2 = 1
    L14_2 = true
    L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  end
end
Hamster_Ball = L14_1
function L14_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "sr_mp_spec_races_take_flight_sign"
  L1_2 = L1_2(L2_2)
  L2_2 = -3
  L3_2 = 5
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = ENTITY
    L6_2 = L6_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
    L7_2 = PLAYER
    L7_2 = L7_2.GET_PLAYER_PED
    L8_2 = A0_2
    L7_2 = L7_2(L8_2)
    L8_2 = 0
    L9_2 = L5_2
    L10_2 = 2
    L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
    L7_2 = create_object
    L8_2 = L1_2
    L9_2 = L6_2.x
    L10_2 = L6_2.y
    L11_2 = L6_2.z
    L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2)
    L8_2 = ENTITY
    L8_2 = L8_2.SET_ENTITY_ROTATION
    L9_2 = L7_2
    L10_2 = 0
    L11_2 = 180
    L12_2 = ENTITY
    L12_2 = L12_2.GET_ENTITY_HEADING
    L13_2 = PLAYER
    L13_2 = L13_2.GET_PLAYER_PED
    L14_2 = A0_2
    L13_2, L14_2 = L13_2(L14_2)
    L12_2 = L12_2(L13_2, L14_2)
    L12_2 = L12_2 + 90
    L13_2 = 2
    L8_2(L9_2, L10_2, L11_2, L12_2, L13_2)
  end
end
shredder = L14_1
function L14_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2
  biker_toggled = A0_2
  L2_2 = biker_toggled
  if L2_2 then
    L2_2 = -1342281820
    L3_2 = request_model
    L4_2 = L2_2
    L3_2(L4_2)
    L3_2 = ENTITY
    L3_2 = L3_2.GET_ENTITY_COORDS
    L4_2 = PLAYER
    L4_2 = L4_2.GET_PLAYER_PED
    L5_2 = A1_2
    L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L4_2(L5_2)
    L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
    L4_2 = L3_2.z
    L4_2 = L4_2 - 10
    L3_2.z = L4_2
    L4_2 = OBJECT
    L4_2 = L4_2.CREATE_OBJECT_NO_OFFSET
    L5_2 = L2_2
    L6_2 = L3_2.x
    L7_2 = L3_2.y
    L8_2 = L3_2.z
    L9_2 = true
    L10_2 = false
    L11_2 = true
    L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    send_biker = L4_2
    while true do
      L4_2 = biker_toggled
      if not L4_2 then
        break
      end
      L4_2 = ENTITY
      L4_2 = L4_2.GET_ENTITY_COORDS
      L5_2 = PLAYER
      L5_2 = L5_2.GET_PLAYER_PED
      L6_2 = A1_2
      L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L5_2(L6_2)
      L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
      L5_2 = ENTITY
      L5_2 = L5_2.SET_ENTITY_COORDS_NO_OFFSET
      L6_2 = send_biker
      L7_2 = L4_2.x
      L8_2 = L4_2.y
      L9_2 = L3_2.z
      L10_2 = false
      L11_2 = false
      L12_2 = false
      L13_2 = false
      L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
      L5_2 = L3_2.z
      L5_2 = L5_2 + 0.1
      L3_2.z = L5_2
      L5_2 = util
      L5_2 = L5_2.yield
      L6_2 = 10
      L5_2(L6_2)
      L5_2 = ENTITY
      L5_2 = L5_2.GET_ENTITY_COORDS
      L6_2 = PLAYER
      L6_2 = L6_2.GET_PLAYER_PED
      L7_2 = A1_2
      L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L6_2(L7_2)
      L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
      L6_2 = L5_2.z
      L7_2 = L3_2.z
      if L6_2 < L7_2 then
        L7_2 = ENTITY
        L7_2 = L7_2.APPLY_FORCE_TO_ENTITY
        L8_2 = PLAYER
        L8_2 = L8_2.GET_PLAYER_PED
        L9_2 = A1_2
        L8_2 = L8_2(L9_2)
        L9_2 = 3
        L10_2 = 50
        L11_2 = 50
        L12_2 = 0
        L13_2 = 0.0
        L14_2 = 0.0
        L15_2 = 0.0
        L16_2 = 0
        L17_2 = false
        L18_2 = false
        L19_2 = true
        L20_2 = false
        L21_2 = false
        L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
        L7_2 = ENTITY
        L7_2 = L7_2.APPLY_FORCE_TO_ENTITY
        L8_2 = PED
        L8_2 = L8_2.GET_VEHICLE_PED_IS_IN
        L9_2 = PLAYER
        L9_2 = L9_2.GET_PLAYER_PED
        L10_2 = A1_2
        L9_2 = L9_2(L10_2)
        L10_2 = false
        L8_2 = L8_2(L9_2, L10_2)
        L9_2 = 3
        L10_2 = 50
        L11_2 = 50
        L12_2 = 0
        L13_2 = 0.0
        L14_2 = 0.0
        L15_2 = 0.0
        L16_2 = 0
        L17_2 = false
        L18_2 = false
        L19_2 = true
        L20_2 = false
        L21_2 = false
        L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
        L7_2 = L6_2 - 10
        L3_2.z = L7_2
      end
    end
  else
    L2_2 = delete_entity
    L3_2 = send_biker
    L2_2(L3_2)
  end
end
biker_lift = L14_1
function L14_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  if 1 == A0_2 then
    SpawnHeight = 250
  elseif 2 == A0_2 then
    SpawnHeight = 500
  elseif 3 == A0_2 then
    SpawnHeight = 1000
  end
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = 368211810
  L3_2 = 1455990255
  L4_2 = request_model
  L5_2 = L2_2
  L4_2(L5_2)
  L4_2 = request_model
  L5_2 = L3_2
  L4_2(L5_2)
  L4_2 = ENTITY
  L4_2 = L4_2.GET_ENTITY_HEADING
  L5_2 = L1_2
  L4_2 = L4_2(L5_2)
  L5_2 = ENTITY
  L5_2 = L5_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L6_2 = L1_2
  L7_2 = 0
  L8_2 = 0
  L9_2 = SpawnHeight
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
  L6_2 = ENTITY
  L6_2 = L6_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L7_2 = L1_2
  L8_2 = 0
  L9_2 = 0
  L10_2 = SpawnHeight
  L10_2 = L10_2 + 4
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
  L7_2 = entities
  L7_2 = L7_2.create_vehicle
  L8_2 = L2_2
  L9_2 = L5_2
  L10_2 = L4_2
  L7_2 = L7_2(L8_2, L9_2, L10_2)
  L8_2 = ENTITY
  L8_2 = L8_2.SET_ENTITY_INVINCIBLE
  L9_2 = L7_2
  L10_2 = true
  L8_2(L9_2, L10_2)
  L8_2 = PED
  L8_2 = L8_2.IS_PED_IN_ANY_VEHICLE
  L9_2 = L1_2
  L10_2 = true
  L8_2 = L8_2(L9_2, L10_2)
  if L8_2 then
    L8_2 = entities
    L8_2 = L8_2.get_user_vehicle_as_handle
    L8_2 = L8_2()
    Car = L8_2
    L8_2 = ENTITY
    L8_2 = L8_2.SET_ENTITY_HEADING
    L9_2 = Car
    L10_2 = L4_2 + 180
    L8_2(L9_2, L10_2)
    L8_2 = ENTITY
    L8_2 = L8_2.SET_ENTITY_VELOCITY
    L9_2 = Car
    L10_2 = 0
    L11_2 = 100
    L12_2 = 0
    L8_2(L9_2, L10_2, L11_2, L12_2)
  else
    L8_2 = entities
    L8_2 = L8_2.create_vehicle
    L9_2 = L3_2
    L10_2 = L6_2
    L11_2 = 0
    L8_2 = L8_2(L9_2, L10_2, L11_2)
    Car = L8_2
    L8_2 = ENTITY
    L8_2 = L8_2.SET_ENTITY_HEADING
    L9_2 = Car
    L10_2 = L4_2 + 180
    L8_2(L9_2, L10_2)
    L8_2 = PED
    L8_2 = L8_2.SET_PED_INTO_VEHICLE
    L9_2 = L1_2
    L10_2 = Car
    L11_2 = -1
    L8_2(L9_2, L10_2, L11_2)
  end
  L8_2 = ENTITY
  L8_2 = L8_2.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
  L9_2 = L7_2
  L10_2 = 1
  L11_2 = 0
  L12_2 = 100
  L13_2 = 0
  L14_2 = true
  L15_2 = true
  L16_2 = true
  L17_2 = true
  L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L8_2 = ENTITY
  L8_2 = L8_2.SET_ENTITY_COORDS
  L9_2 = Car
  L10_2 = L6_2.x
  L11_2 = L6_2.y
  L12_2 = L6_2.z
  L13_2 = false
  L14_2 = false
  L15_2 = false
  L16_2 = false
  L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  L8_2 = ENTITY
  L8_2 = L8_2.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
  L9_2 = Car
  L10_2 = 1
  L11_2 = 0
  L12_2 = -100
  L13_2 = 0
  L14_2 = true
  L15_2 = true
  L16_2 = true
  L17_2 = true
  L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L8_2 = 350
  L9_2 = util
  L9_2 = L9_2.create_tick_handler
  function L10_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3
    L0_3 = L8_2
    L0_3 = L0_3 - 1
    L8_2 = L0_3
    L0_3 = util
    L0_3 = L0_3.draw_centred_text
    L1_3 = "开仓倒计时 : "
    L2_3 = L8_2
    L1_3 = L1_3 .. L2_3
    L0_3(L1_3)
    L0_3 = L8_2
    if L0_3 < 0 then
      L0_3 = VEHICLE
      L0_3 = L0_3.SET_VEHICLE_DOOR_OPEN
      L1_3 = L7_2
      L2_3 = 2
      L3_3 = false
      L4_3 = false
      L0_3(L1_3, L2_3, L3_3, L4_3)
      L0_3 = false
      return L0_3
    end
  end
  L9_2(L10_2)
end
extreme_jump = L14_1
function L14_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = {}
  L0_2.x = -914.1707
  L0_2.y = -1164.9396
  L0_2.z = 250
  L1_2 = create_vehicle
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "jet"
  L2_2 = L2_2(L3_2)
  L3_2 = L0_2.x
  L4_2 = L0_2.y
  L5_2 = L0_2.z
  L6_2 = -68
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
  L2_2 = VEHICLE
  L2_2 = L2_2.SET_VEHICLE_ENGINE_ON
  L3_2 = L1_2
  L4_2 = true
  L5_2 = true
  L6_2 = false
  L2_2(L3_2, L4_2, L5_2, L6_2)
  L2_2 = VEHICLE
  L2_2 = L2_2.CONTROL_LANDING_GEAR
  L3_2 = L1_2
  L4_2 = 3
  L2_2(L3_2, L4_2)
  L2_2 = VEHICLE
  L2_2 = L2_2.SET_PLANE_TURBULENCE_MULTIPLIER
  L3_2 = L1_2
  L4_2 = 0.0
  L2_2(L3_2, L4_2)
  L2_2 = 1
  L3_2 = 5
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = VEHICLE
    L6_2 = L6_2.SET_VEHICLE_FORWARD_SPEED
    L7_2 = L1_2
    L8_2 = 150.0
    L6_2(L7_2, L8_2)
    L6_2 = util
    L6_2 = L6_2.yield
    L7_2 = 1000
    L6_2(L7_2)
  end
end
planetobank = L14_1
function L14_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  L1_2 = {}
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = ENTITY
  L3_2 = L3_2.GET_ENTITY_COORDS
  L4_2 = L2_2
  L5_2 = false
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = L3_2.y
  L4_2 = L4_2 - 5
  L3_2.y = L4_2
  L4_2 = L3_2.z
  L4_2 = L4_2 + 1
  L3_2.z = L4_2
  L4_2 = util
  L4_2 = L4_2.joaat
  L5_2 = "U_M_M_YuleMonster"
  L4_2 = L4_2(L5_2)
  L5_2 = request_model
  L6_2 = L4_2
  L5_2(L6_2)
  L5_2 = 1
  L6_2 = 48
  L7_2 = 1
  for L8_2 = L5_2, L6_2, L7_2 do
    L9_2 = entities
    L9_2 = L9_2.create_ped
    L10_2 = 28
    L11_2 = L4_2
    L12_2 = L3_2
    L13_2 = 0
    L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2)
    L1_2[L8_2] = L9_2
    L9_2 = ENTITY
    L9_2 = L9_2.SET_ENTITY_INVINCIBLE
    L10_2 = L1_2[L8_2]
    L11_2 = true
    L9_2(L10_2, L11_2)
    L9_2 = PED
    L9_2 = L9_2.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS
    L10_2 = L1_2[L8_2]
    L11_2 = true
    L9_2(L10_2, L11_2)
    L9_2 = PED
    L9_2 = L9_2.SET_PED_COMPONENT_VARIATION
    L10_2 = L1_2[L8_2]
    L11_2 = 0
    L12_2 = 0
    L13_2 = 1
    L14_2 = 0
    L9_2(L10_2, L11_2, L12_2, L13_2, L14_2)
    L9_2 = TASK
    L9_2 = L9_2.TASK_FOLLOW_TO_OFFSET_OF_ENTITY
    L10_2 = L1_2[L8_2]
    L11_2 = L2_2
    L12_2 = 0
    L13_2 = -0.3
    L14_2 = 0
    L15_2 = 7.0
    L16_2 = -1
    L17_2 = 10
    L18_2 = true
    L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L9_2 = WEAPON
    L9_2 = L9_2.GIVE_WEAPON_TO_PED
    L10_2 = L1_2[L8_2]
    L11_2 = util
    L11_2 = L11_2.joaat
    L12_2 = "WEAPON_CANDYCANE"
    L11_2 = L11_2(L12_2)
    L12_2 = 9999
    L13_2 = true
    L14_2 = true
    L9_2(L10_2, L11_2, L12_2, L13_2, L14_2)
    L9_2 = PED
    L9_2 = L9_2.SET_PED_COMBAT_ATTRIBUTES
    L10_2 = L1_2[L8_2]
    L11_2 = 20
    L12_2 = true
    L9_2(L10_2, L11_2, L12_2)
    L9_2 = PED
    L9_2 = L9_2.SET_PED_SHOOT_RATE
    L10_2 = L1_2[L8_2]
    L11_2 = 1000
    L9_2(L10_2, L11_2)
    L9_2 = util
    L9_2 = L9_2.yield
    L9_2()
  end
end
Create_Monster_Army = L14_1
function L14_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L0_2 = util
  L0_2 = L0_2.joaat
  L1_2 = "speedo2"
  L0_2 = L0_2(L1_2)
  L1_2 = request_model
  L2_2 = L0_2
  L1_2(L2_2)
  L1_2 = ENTITY
  L1_2 = L1_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = 0
  L4_2 = 0
  L5_2 = 0
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_HEADING
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2 = L3_2()
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  L3_2 = entities
  L3_2 = L3_2.create_vehicle
  L4_2 = L0_2
  L5_2 = L1_2
  L6_2 = L2_2
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  L4_2 = PED
  L4_2 = L4_2.SET_PED_INTO_VEHICLE
  L5_2 = PLAYER
  L5_2 = L5_2.PLAYER_PED_ID
  L5_2 = L5_2()
  L6_2 = L3_2
  L7_2 = -1
  L4_2(L5_2, L6_2, L7_2)
  L4_2 = util
  L4_2 = L4_2.toast
  L5_2 = "~o~按下鼠标右键引爆载具"
  L4_2(L5_2)
  L4_2 = util
  L4_2 = L4_2.create_tick_handler
  function L5_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3
    L0_3 = VEHICLE
    L0_3 = L0_3.START_VEHICLE_HORN
    L1_3 = L3_2
    L2_3 = 300
    L3_3 = 1330140418
    L4_3 = false
    L0_3(L1_3, L2_3, L3_3, L4_3)
    L0_3 = util
    L0_3 = L0_3.yield
    L1_3 = 500
    L0_3(L1_3)
  end
  L4_2(L5_2)
  while L3_2 do
    L4_2 = ENTITY
    L4_2 = L4_2.SET_ENTITY_INVINCIBLE
    L5_2 = L3_2
    L6_2 = false
    L4_2(L5_2, L6_2)
    L4_2 = PAD
    L4_2 = L4_2.IS_CONTROL_PRESSED
    L5_2 = 0
    L6_2 = 68
    L4_2 = L4_2(L5_2, L6_2)
    if L4_2 then
      L4_2 = ENTITY
      L4_2 = L4_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
      L5_2 = L3_2
      L6_2 = 0
      L7_2 = 0
      L8_2 = 0
      L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
      L5_2 = FIRE
      L5_2 = L5_2.ADD_EXPLOSION
      L6_2 = L4_2.x
      L7_2 = L4_2.y
      L8_2 = L4_2.z
      L9_2 = 59
      L10_2 = 1
      L11_2 = true
      L12_2 = false
      L13_2 = 1.0
      L14_2 = false
      L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
      L5_2 = util
      L5_2 = L5_2.yield
      L6_2 = 1000
      L5_2(L6_2)
      L5_2 = delete_entity
      L6_2 = L3_2
      L5_2(L6_2)
      break
    end
    L4_2 = util
    L4_2 = L4_2.yield
    L4_2()
  end
end
bomb_car = L14_1
function L14_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED_SCRIPT_INDEX
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = L1_2
  L4_2 = false
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = L2_2.x
  L2_2.x = L3_2
  L3_2 = L2_2.y
  L2_2.y = L3_2
  L3_2 = L2_2.z
  L2_2.z = L3_2
  L3_2 = util
  L3_2 = L3_2.joaat
  L4_2 = "a_c_cat_01"
  L3_2 = L3_2(L4_2)
  hash = L3_2
  L3_2 = request_model
  L4_2 = hash
  L3_2(L4_2)
  L3_2 = 1
  L4_2 = 30
  L5_2 = 1
  for L6_2 = L3_2, L4_2, L5_2 do
    L7_2 = entities
    L7_2 = L7_2.create_ped
    L8_2 = 28
    L9_2 = hash
    L10_2 = L2_2
    L11_2 = math
    L11_2 = L11_2.random
    L12_2 = 0
    L13_2 = 270
    L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2 = L11_2(L12_2, L13_2)
    L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
    L8_2 = math
    L8_2 = L8_2.random
    L9_2 = -10
    L10_2 = 10
    L8_2 = L8_2(L9_2, L10_2)
    L8_2 = L8_2 * 5
    L9_2 = math
    L9_2 = L9_2.random
    L10_2 = -10
    L11_2 = 10
    L9_2 = L9_2(L10_2, L11_2)
    L9_2 = L9_2 * 5
    L10_2 = math
    L10_2 = L10_2.random
    L11_2 = -10
    L12_2 = 10
    L10_2 = L10_2(L11_2, L12_2)
    L10_2 = L10_2 * 5
    L11_2 = ENTITY
    L11_2 = L11_2.SET_ENTITY_INVINCIBLE
    L12_2 = L7_2
    L13_2 = true
    L11_2(L12_2, L13_2)
    L11_2 = ENTITY
    L11_2 = L11_2.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
    L12_2 = L7_2
    L13_2 = 1
    L14_2 = L8_2
    L15_2 = L9_2
    L16_2 = L10_2
    L17_2 = true
    L18_2 = false
    L19_2 = true
    L20_2 = true
    L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
    L11_2 = AUDIO
    L11_2 = L11_2.PLAY_PAIN
    L12_2 = L7_2
    L13_2 = 7
    L14_2 = 0
    L11_2(L12_2, L13_2, L14_2)
  end
end
cat_bomb = L14_1
L14_1 = 0
L15_1 = nil
L16_1 = 0
function L17_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = PED
  L1_2 = L1_2.CLONE_PED
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = false
  L4_2 = false
  L5_2 = true
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2)
  L2_2 = ENTITY
  L2_2 = L2_2.FREEZE_ENTITY_POSITION
  L3_2 = L1_2
  L4_2 = true
  L2_2(L3_2, L4_2)
  L2_2 = ENTITY
  L2_2 = L2_2.SET_ENTITY_INVINCIBLE
  L3_2 = L1_2
  L4_2 = true
  L2_2(L3_2, L4_2)
  L2_2 = PED
  L2_2 = L2_2.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS
  L3_2 = L1_2
  L4_2 = true
  L2_2(L3_2, L4_2)
  L2_2 = TASK
  L3_2 = "TASK_SET_BLOCKING_OF_NON_TEMPORARY_EVENTS"
  L2_2 = L2_2[L3_2]
  L3_2 = L1_2
  L4_2 = true
  L2_2(L3_2, L4_2)
  L2_2 = ENTITY
  L2_2 = L2_2.SET_ENTITY_COORDS
  L3_2 = L1_2
  L4_2 = 0
  L5_2 = 0
  L6_2 = -50
  L7_2 = true
  L8_2 = true
  L9_2 = true
  L10_2 = false
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L2_2 = ENTITY
  L2_2 = L2_2.SET_ENTITY_ALPHA
  L3_2 = L1_2
  L4_2 = 200
  L5_2 = false
  L2_2(L3_2, L4_2, L5_2)
  L2_2 = ENTITY
  L2_2 = L2_2.SET_ENTITY_COLLISION
  L3_2 = L1_2
  L4_2 = false
  L5_2 = true
  L2_2(L3_2, L4_2, L5_2)
  return L1_2
end
create_player_clone = L17_1
function L17_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L0_2 = players
  L0_2 = L0_2.get_focused
  L0_2 = L0_2()
  L1_2 = L0_2[1]
  if nil ~= L1_2 then
    L1_2 = L0_2[2]
    if nil == L1_2 then
      L1_2 = menu
      L1_2 = L1_2.is_open
      L1_2 = L1_2()
      if L1_2 then
        L1_2 = L0_2[1]
        L2_2 = L15_1
        if L1_2 ~= L2_2 then
          L2_2 = L16_1
          if 0 ~= L2_2 then
            L2_2 = delete_entity
            L3_2 = L16_1
            L2_2(L3_2)
          end
          L15_1 = L1_2
          L2_2 = create_player_clone
          L3_2 = L1_2
          L2_2 = L2_2(L3_2)
          L16_1 = L2_2
        end
        L2_2 = get_offset_from_gameplay_camera
        L3_2 = 3.0
        L2_2 = L2_2(L3_2)
        L3_2 = ENTITY
        L3_2 = L3_2.SET_ENTITY_COORDS
        L4_2 = L16_1
        L5_2 = L2_2.x
        L6_2 = L2_2.y
        L7_2 = L2_2.z
        L7_2 = L7_2 - 1
        L8_2 = true
        L9_2 = true
        L10_2 = true
        L11_2 = false
        L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
        L3_2 = ENTITY
        L3_2 = L3_2.SET_ENTITY_ROTATION
        L4_2 = L16_1
        L5_2 = 0
        L6_2 = 0
        L7_2 = L14_1
        L8_2 = 0
        L9_2 = true
        L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
        L3_2 = util
        L3_2 = L3_2.draw_box
        L4_2 = v3
        L4_2 = L4_2.new
        L5_2 = L2_2.x
        L6_2 = L2_2.y
        L7_2 = L2_2.z
        L7_2 = L7_2 + 0.1
        L4_2 = L4_2(L5_2, L6_2, L7_2)
        L5_2 = v3
        L5_2 = L5_2.new
        L6_2 = 0
        L7_2 = 0
        L8_2 = L14_1
        L5_2 = L5_2(L6_2, L7_2, L8_2)
        L6_2 = v3
        L6_2 = L6_2.new
        L7_2 = 1
        L8_2 = 1
        L9_2 = 2
        L6_2 = L6_2(L7_2, L8_2, L9_2)
        L7_2 = 255
        L8_2 = 255
        L9_2 = 255
        L10_2 = 50
        L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
        L3_2 = L14_1
        L4_2 = 360
        if L3_2 >= L4_2 then
          L3_2 = 0
          L14_1 = L3_2
        else
          L3_2 = L14_1
          L3_2 = L3_2 + 1
          L14_1 = L3_2
        end
    end
  end
  else
    L1_2 = L15_1
    if nil ~= L1_2 then
      L1_2 = delete_entity
      L2_2 = L16_1
      L1_2(L2_2)
      L1_2 = 0
      L16_1 = L1_2
      L1_2 = nil
      L15_1 = L1_2
    end
  end
end
Draw_player_model = L17_1
L17_1 = {}
L17_1.a = "scr_rcbarry2"
L17_1.b = "scr_clown_appears"
L17_1.c = "5"
function L18_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L0_2 = PLAYER
  L0_2 = L0_2.GET_PLAYER_PED_SCRIPT_INDEX
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_COORDS
  L2_2 = L0_2
  L3_2 = true
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = request_ptfx_asset
  L3_2 = L17_1.a
  L2_2(L3_2)
  L2_2 = GRAPHICS
  L2_2 = L2_2.USE_PARTICLE_FX_ASSET
  L3_2 = L17_1.a
  L2_2(L3_2)
  L2_2 = GRAPHICS
  L3_2 = "START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD"
  L2_2 = L2_2[L3_2]
  L3_2 = L17_1.b
  L4_2 = L1_2.x
  L5_2 = L1_2.y
  L6_2 = L1_2.z
  L7_2 = 0
  L8_2 = 0
  L9_2 = 0
  L10_2 = L17_1.c
  L11_2 = true
  L12_2 = true
  L13_2 = false
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L2_2 = util
  L2_2 = L2_2.yield
  L3_2 = 200
  L2_2(L3_2)
end
ptfx_fun = L18_1
function L18_1(A0_2)
  local L1_2, L2_2
  L1_2 = funptfx
  L1_2 = L1_2[A0_2]
  L2_2 = L1_2[3]
  L17_1.c = L2_2
  L2_2 = L1_2[2]
  L17_1.b = L2_2
  L2_2 = L1_2[1]
  L17_1.a = L2_2
end
sel_ptfx_fun = L18_1
L18_1 = {}
L18_1.lib = "core"
L18_1.sel = "ent_dst_concrete_large"
function L19_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED_SCRIPT_INDEX
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = L1_2
  L4_2 = true
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = request_ptfx_asset
  L4_2 = L18_1.lib
  L3_2(L4_2)
  L3_2 = GRAPHICS
  L3_2 = L3_2.USE_PARTICLE_FX_ASSET
  L4_2 = L18_1.lib
  L3_2(L4_2)
  L3_2 = GRAPHICS
  L4_2 = "START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD"
  L3_2 = L3_2[L4_2]
  L4_2 = L18_1.sel
  L5_2 = L2_2.x
  L6_2 = L2_2.y
  L7_2 = L2_2.z
  L7_2 = L7_2 + 1
  L8_2 = 0
  L9_2 = 0
  L10_2 = 0
  L11_2 = 5
  L12_2 = true
  L13_2 = true
  L14_2 = true
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
end
p_eff_bomb = L19_1
function L19_1(A0_2)
  local L1_2
  L1_2 = Fxha
  L1_2 = L1_2[A0_2]
  L18_1.sel = L1_2
  L18_1.lib = "core"
end
sel_p_eff_bomb = L19_1
function L19_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = io
  L1_2 = L1_2.open
  L2_2 = A0_2
  L3_2 = "r"
  L1_2 = L1_2(L2_2, L3_2)
  if L1_2 then
    L2_2 = json
    L2_2 = L2_2.decode
    L4_2 = L1_2
    L3_2 = L1_2.read
    L5_2 = "*a"
    L3_2, L4_2, L5_2 = L3_2(L4_2, L5_2)
    L2_2 = L2_2(L3_2, L4_2, L5_2)
    L4_2 = L1_2
    L3_2 = L1_2.close
    L3_2(L4_2)
    return L2_2
  else
    L2_2 = ERROR_LOG
    L3_2 = "无法读取文件"
    L4_2 = A0_2
    L5_2 = "'"
    L3_2 = L3_2 .. L4_2 .. L5_2
    L2_2(L3_2)
  end
end
load_cloth_from_file = L19_1
function L19_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L1_2 = {}
  L2_2 = ipairs
  L3_2 = filesystem
  L3_2 = L3_2.list_files
  L4_2 = A0_2
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2 = L3_2(L4_2)
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = string
    L8_2 = L8_2.match
    L9_2 = L7_2
    L10_2 = "(.-)([^\\/]-%.?([^%.\\/]*))$"
    L8_2, L9_2, L10_2 = L8_2(L9_2, L10_2)
    L11_2 = filesystem
    L11_2 = L11_2.is_dir
    L12_2 = L7_2
    L11_2 = L11_2(L12_2)
    if not L11_2 and "json" == L10_2 then
      L11_2 = load_cloth_from_file
      L12_2 = L7_2
      L11_2 = L11_2(L12_2)
      L12_2 = table
      L12_2 = L12_2.insert
      L13_2 = L1_2
      L14_2 = L11_2
      L12_2(L13_2, L14_2)
    end
  end
  return L1_2
end
load_clothes = L19_1
function L19_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L0_2 = filesystem
  L0_2 = L0_2.scripts_dir
  L0_2 = L0_2()
  L1_2 = "daidaiScript\\Outfits"
  L0_2 = L0_2 .. L1_2
  L1_2 = menu
  L1_2 = L1_2.action
  L2_2 = my_cloth
  L3_2 = "打开文件夹"
  L4_2 = {}
  L5_2 = ""
  function L6_2()
    local L0_3, L1_3
    L0_3 = util
    L0_3 = L0_3.open_folder
    L1_3 = L0_2
    L0_3(L1_3)
  end
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
  outs_folfer = L1_2
  L1_2 = menu
  L1_2 = L1_2.divider
  L2_2 = my_cloth
  L3_2 = "衣柜"
  L1_2 = L1_2(L2_2, L3_2)
  outs_div = L1_2
  L1_2 = load_clothes
  L2_2 = L0_2
  L1_2 = L1_2(L2_2)
  presetclothes = L1_2
  L1_2 = pairs
  L2_2 = presetclothes
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = menu
    L7_2 = L7_2.action
    L8_2 = my_cloth
    L9_2 = L6_2.name
    L10_2 = "["
    L11_2 = L6_2.type
    L12_2 = "]"
    L9_2 = L9_2 .. L10_2 .. L11_2 .. L12_2
    L10_2 = {}
    L11_2 = ""
    function L12_2()
      local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3
      L0_3 = L6_2.type
      if "女性" == L0_3 then
        L0_3 = change_model
        L1_3 = PLAYER
        L1_3 = L1_3.PLAYER_ID
        L1_3 = L1_3()
        L2_3 = MISC
        L2_3 = L2_3.GET_HASH_KEY
        L3_3 = "mp_f_freemode_01"
        L2_3, L3_3, L4_3, L5_3 = L2_3(L3_3)
        L0_3(L1_3, L2_3, L3_3, L4_3, L5_3)
        L0_3 = menu
        L0_3 = L0_3.trigger_commands
        L1_3 = "mpfemale"
        L0_3(L1_3)
      else
        L0_3 = change_model
        L1_3 = PLAYER
        L1_3 = L1_3.PLAYER_ID
        L1_3 = L1_3()
        L2_3 = MISC
        L2_3 = L2_3.GET_HASH_KEY
        L3_3 = "mp_m_freemode_01"
        L2_3, L3_3, L4_3, L5_3 = L2_3(L3_3)
        L0_3(L1_3, L2_3, L3_3, L4_3, L5_3)
        L0_3 = menu
        L0_3 = L0_3.trigger_commands
        L1_3 = "mpmale"
        L0_3(L1_3)
      end
      L0_3 = PED
      L0_3 = L0_3.SET_PED_COMPONENT_VARIATION
      L1_3 = PLAYER
      L1_3 = L1_3.GET_PLAYER_PED
      L2_3 = PLAYER
      L2_3 = L2_3.PLAYER_ID
      L2_3, L3_3, L4_3, L5_3 = L2_3()
      L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3)
      L2_3 = 0
      L3_3 = L6_2.Head
      L4_3 = L6_2.Head_Variation
      L5_3 = 0
      L0_3(L1_3, L2_3, L3_3, L4_3, L5_3)
      L0_3 = PED
      L0_3 = L0_3.SET_PED_COMPONENT_VARIATION
      L1_3 = PLAYER
      L1_3 = L1_3.GET_PLAYER_PED
      L2_3 = PLAYER
      L2_3 = L2_3.PLAYER_ID
      L2_3, L3_3, L4_3, L5_3 = L2_3()
      L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3)
      L2_3 = 1
      L3_3 = L6_2.Mask
      L4_3 = L6_2.Mask_Variation
      L5_3 = 0
      L0_3(L1_3, L2_3, L3_3, L4_3, L5_3)
      L0_3 = PED
      L0_3 = L0_3.SET_PED_COMPONENT_VARIATION
      L1_3 = PLAYER
      L1_3 = L1_3.GET_PLAYER_PED
      L2_3 = PLAYER
      L2_3 = L2_3.PLAYER_ID
      L2_3, L3_3, L4_3, L5_3 = L2_3()
      L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3)
      L2_3 = 2
      L3_3 = L6_2.Hair
      L4_3 = 0
      L5_3 = 0
      L0_3(L1_3, L2_3, L3_3, L4_3, L5_3)
      L0_3 = PED1
      L0_3 = L0_3._SET_PED_HAIR_COLOR
      L1_3 = PLAYER
      L1_3 = L1_3.GET_PLAYER_PED
      L2_3 = PLAYER
      L2_3 = L2_3.PLAYER_ID
      L2_3, L3_3, L4_3, L5_3 = L2_3()
      L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3)
      L2_3 = L6_2.Hair_Colour
      L3_3 = L6_2.highlight_Color
      L0_3(L1_3, L2_3, L3_3)
      L0_3 = PED
      L0_3 = L0_3.SET_PED_COMPONENT_VARIATION
      L1_3 = PLAYER
      L1_3 = L1_3.GET_PLAYER_PED
      L2_3 = PLAYER
      L2_3 = L2_3.PLAYER_ID
      L2_3, L3_3, L4_3, L5_3 = L2_3()
      L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3)
      L2_3 = 3
      L3_3 = L6_2.Gloves_Torso
      L4_3 = L6_2.Gloves_Torso_Variation
      L5_3 = 0
      L0_3(L1_3, L2_3, L3_3, L4_3, L5_3)
      L0_3 = PED
      L0_3 = L0_3.SET_PED_COMPONENT_VARIATION
      L1_3 = PLAYER
      L1_3 = L1_3.GET_PLAYER_PED
      L2_3 = PLAYER
      L2_3 = L2_3.PLAYER_ID
      L2_3, L3_3, L4_3, L5_3 = L2_3()
      L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3)
      L2_3 = 4
      L3_3 = L6_2.Pants
      L4_3 = L6_2.Pants_Variation
      L5_3 = 0
      L0_3(L1_3, L2_3, L3_3, L4_3, L5_3)
      L0_3 = PED
      L0_3 = L0_3.SET_PED_COMPONENT_VARIATION
      L1_3 = PLAYER
      L1_3 = L1_3.GET_PLAYER_PED
      L2_3 = PLAYER
      L2_3 = L2_3.PLAYER_ID
      L2_3, L3_3, L4_3, L5_3 = L2_3()
      L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3)
      L2_3 = 5
      L3_3 = L6_2.Parachute_Bag
      L4_3 = L6_2.Parachute_Bag_Variation
      L5_3 = 0
      L0_3(L1_3, L2_3, L3_3, L4_3, L5_3)
      L0_3 = PED
      L0_3 = L0_3.SET_PED_COMPONENT_VARIATION
      L1_3 = PLAYER
      L1_3 = L1_3.GET_PLAYER_PED
      L2_3 = PLAYER
      L2_3 = L2_3.PLAYER_ID
      L2_3, L3_3, L4_3, L5_3 = L2_3()
      L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3)
      L2_3 = 6
      L3_3 = L6_2.Shoes
      L4_3 = L6_2.Shoes_Variation
      L5_3 = 0
      L0_3(L1_3, L2_3, L3_3, L4_3, L5_3)
      L0_3 = PED
      L0_3 = L0_3.SET_PED_COMPONENT_VARIATION
      L1_3 = PLAYER
      L1_3 = L1_3.GET_PLAYER_PED
      L2_3 = PLAYER
      L2_3 = L2_3.PLAYER_ID
      L2_3, L3_3, L4_3, L5_3 = L2_3()
      L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3)
      L2_3 = 7
      L3_3 = L6_2.Accessories
      L4_3 = L6_2.Accessories_Variation
      L5_3 = 0
      L0_3(L1_3, L2_3, L3_3, L4_3, L5_3)
      L0_3 = PED
      L0_3 = L0_3.SET_PED_COMPONENT_VARIATION
      L1_3 = PLAYER
      L1_3 = L1_3.GET_PLAYER_PED
      L2_3 = PLAYER
      L2_3 = L2_3.PLAYER_ID
      L2_3, L3_3, L4_3, L5_3 = L2_3()
      L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3)
      L2_3 = 8
      L3_3 = L6_2.Top_2
      L4_3 = L6_2.Top_2_Variation
      L5_3 = 0
      L0_3(L1_3, L2_3, L3_3, L4_3, L5_3)
      L0_3 = PED
      L0_3 = L0_3.SET_PED_COMPONENT_VARIATION
      L1_3 = PLAYER
      L1_3 = L1_3.GET_PLAYER_PED
      L2_3 = PLAYER
      L2_3 = L2_3.PLAYER_ID
      L2_3, L3_3, L4_3, L5_3 = L2_3()
      L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3)
      L2_3 = 9
      L3_3 = L6_2.Top_3
      L4_3 = L6_2.Top_3_Variation
      L5_3 = 0
      L0_3(L1_3, L2_3, L3_3, L4_3, L5_3)
      L0_3 = PED
      L0_3 = L0_3.SET_PED_COMPONENT_VARIATION
      L1_3 = PLAYER
      L1_3 = L1_3.GET_PLAYER_PED
      L2_3 = PLAYER
      L2_3 = L2_3.PLAYER_ID
      L2_3, L3_3, L4_3, L5_3 = L2_3()
      L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3)
      L2_3 = 10
      L3_3 = L6_2.Decals
      L4_3 = L6_2.Decals_Variation
      L5_3 = 0
      L0_3(L1_3, L2_3, L3_3, L4_3, L5_3)
      L0_3 = PED
      L0_3 = L0_3.SET_PED_COMPONENT_VARIATION
      L1_3 = PLAYER
      L1_3 = L1_3.GET_PLAYER_PED
      L2_3 = PLAYER
      L2_3 = L2_3.PLAYER_ID
      L2_3, L3_3, L4_3, L5_3 = L2_3()
      L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3)
      L2_3 = 11
      L3_3 = L6_2.Top
      L4_3 = L6_2.Top_Variation
      L5_3 = 0
      L0_3(L1_3, L2_3, L3_3, L4_3, L5_3)
      L0_3 = PED
      L0_3 = L0_3.SET_PED_PROP_INDEX
      L1_3 = PLAYER
      L1_3 = L1_3.GET_PLAYER_PED
      L2_3 = PLAYER
      L2_3 = L2_3.PLAYER_ID
      L2_3, L3_3, L4_3, L5_3 = L2_3()
      L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3)
      L2_3 = 0
      L3_3 = L6_2.Hat
      L4_3 = L6_2.Hat_Variation
      L5_3 = 0
      L0_3(L1_3, L2_3, L3_3, L4_3, L5_3)
      L0_3 = PED
      L0_3 = L0_3.SET_PED_PROP_INDEX
      L1_3 = PLAYER
      L1_3 = L1_3.GET_PLAYER_PED
      L2_3 = PLAYER
      L2_3 = L2_3.PLAYER_ID
      L2_3, L3_3, L4_3, L5_3 = L2_3()
      L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3)
      L2_3 = 1
      L3_3 = L6_2.Glasses
      L4_3 = L6_2.Glasses_Variation
      L5_3 = 0
      L0_3(L1_3, L2_3, L3_3, L4_3, L5_3)
      L0_3 = PED
      L0_3 = L0_3.SET_PED_PROP_INDEX
      L1_3 = PLAYER
      L1_3 = L1_3.GET_PLAYER_PED
      L2_3 = PLAYER
      L2_3 = L2_3.PLAYER_ID
      L2_3, L3_3, L4_3, L5_3 = L2_3()
      L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3)
      L2_3 = 2
      L3_3 = L6_2.Earwear
      L4_3 = L6_2.Earwear_Variation
      L5_3 = 0
      L0_3(L1_3, L2_3, L3_3, L4_3, L5_3)
      L0_3 = PED
      L0_3 = L0_3.SET_PED_PROP_INDEX
      L1_3 = PLAYER
      L1_3 = L1_3.GET_PLAYER_PED
      L2_3 = PLAYER
      L2_3 = L2_3.PLAYER_ID
      L2_3, L3_3, L4_3, L5_3 = L2_3()
      L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3)
      L2_3 = 6
      L3_3 = L6_2.Watch
      L4_3 = L6_2.Watch_Variation
      L5_3 = 0
      L0_3(L1_3, L2_3, L3_3, L4_3, L5_3)
      L0_3 = PED
      L0_3 = L0_3.SET_PED_PROP_INDEX
      L1_3 = PLAYER
      L1_3 = L1_3.GET_PLAYER_PED
      L2_3 = PLAYER
      L2_3 = L2_3.PLAYER_ID
      L2_3, L3_3, L4_3, L5_3 = L2_3()
      L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3)
      L2_3 = 7
      L3_3 = L6_2.Bracelet
      L4_3 = L6_2.Bracelet_Variation
      L5_3 = 0
      L0_3(L1_3, L2_3, L3_3, L4_3, L5_3)
    end
    L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2)
    L6_2.name = L7_2
  end
end
Preset_outfits = L19_1
function L19_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = menu
  L0_2 = L0_2.delete
  L1_2 = outs_folfer
  L0_2(L1_2)
  L0_2 = menu
  L0_2 = L0_2.delete
  L1_2 = outs_div
  L0_2(L1_2)
  L0_2 = pairs
  L1_2 = presetclothes
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = L5_2.name
    if L6_2 then
      L6_2 = menu
      L6_2 = L6_2.delete
      L7_2 = L5_2.name
      L6_2(L7_2)
    end
  end
end
endPreset_outfits = L19_1
function L19_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L1_2 = PED
  L1_2 = L1_2.IS_PED_IN_ANY_VEHICLE
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED
  L3_2 = A0_2
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L2_2(L3_2)
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  if L1_2 then
    L1_2 = PED
    L1_2 = L1_2.GET_VEHICLE_PED_IS_USING
    L2_2 = PLAYER
    L2_2 = L2_2.GET_PLAYER_PED
    L3_2 = A0_2
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L2_2(L3_2)
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    L2_2 = ENTITY
    L2_2 = L2_2.GET_ENTITY_MODEL
    L3_2 = L1_2
    L2_2 = L2_2(L3_2)
    L3_2 = VEHICLE
    L3_2 = L3_2.GET_VEHICLE_MODEL_NUMBER_OF_SEATS
    L4_2 = L2_2
    L3_2 = L3_2(L4_2)
    L4_2 = 0
    L5_2 = L3_2 - 1
    L6_2 = 1
    for L7_2 = L4_2, L5_2, L6_2 do
      L8_2 = VEHICLE
      L8_2 = L8_2.ARE_ANY_VEHICLE_SEATS_FREE
      L9_2 = L1_2
      L8_2 = L8_2(L9_2)
      if L8_2 then
        L8_2 = PED
        L8_2 = L8_2.SET_PED_INTO_VEHICLE
        L9_2 = PLAYER
        L9_2 = L9_2.GET_PLAYER_PED
        L10_2 = PLAYER
        L10_2 = L10_2.PLAYER_ID
        L10_2, L11_2 = L10_2()
        L9_2 = L9_2(L10_2, L11_2)
        L10_2 = L1_2
        L11_2 = L7_2
        L8_2(L9_2, L10_2, L11_2)
        break
      end
    end
  else
    L1_2 = util
    L1_2 = L1_2.toast
    L2_2 = "玩家不在载具"
    L1_2(L2_2)
  end
end
tp_p_car = L19_1
function L19_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  if A0_2 then
    L1_2 = entities
    L1_2 = L1_2.get_all_peds_as_handles
    L1_2 = L1_2()
    L2_2 = 1
    L3_2 = #L1_2
    L4_2 = 1
    for L5_2 = L2_2, L3_2, L4_2 do
      L6_2 = PED
      L6_2 = L6_2.IS_PED_A_PLAYER
      L7_2 = L1_2[L5_2]
      L6_2 = L6_2(L7_2)
      if not L6_2 then
        L6_2 = NETWORK
        L6_2 = L6_2.NETWORK_REQUEST_CONTROL_OF_ENTITY
        L7_2 = L1_2[L5_2]
        L6_2(L7_2)
        L6_2 = PED
        L6_2 = L6_2.SET_PED_CONFIG_FLAG
        L7_2 = L1_2[L5_2]
        L8_2 = 223
        L9_2 = true
        L6_2(L7_2, L8_2, L9_2)
      end
    end
  else
    L1_2 = entities
    L1_2 = L1_2.get_all_peds_as_handles
    L1_2 = L1_2()
    L2_2 = 1
    L3_2 = #L1_2
    L4_2 = 1
    for L5_2 = L2_2, L3_2, L4_2 do
      L6_2 = PED
      L6_2 = L6_2.IS_PED_A_PLAYER
      L7_2 = L1_2[L5_2]
      L6_2 = L6_2(L7_2)
      if not L6_2 then
        L6_2 = NETWORK
        L6_2 = L6_2.NETWORK_REQUEST_CONTROL_OF_ENTITY
        L7_2 = L1_2[L5_2]
        L6_2(L7_2)
        L6_2 = PED
        L6_2 = L6_2.SET_PED_CONFIG_FLAG
        L7_2 = L1_2[L5_2]
        L8_2 = 223
        L9_2 = false
        L6_2(L7_2, L8_2, L9_2)
      end
    end
  end
end
shrink_peds = L19_1
function L19_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = L1_2
  L4_2 = true
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = MISC
  L3_2 = L3_2.GET_HASH_KEY
  L4_2 = "Player_One"
  L3_2 = L3_2(L4_2)
  L4_2 = 0
  L5_2 = 25
  L6_2 = 1
  for L7_2 = L4_2, L5_2, L6_2 do
    L8_2 = create_ped
    L9_2 = 1
    L10_2 = L3_2
    L11_2 = L2_2.x
    L12_2 = L2_2.y
    L13_2 = L2_2.z
    L14_2 = 0
    L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  end
  L4_2 = FIRE
  L4_2 = L4_2.ADD_OWNED_EXPLOSION
  L5_2 = L1_2
  L6_2 = L2_2.x
  L7_2 = L2_2.y
  L8_2 = L2_2.z
  L9_2 = 2
  L10_2 = 50
  L11_2 = true
  L12_2 = false
  L13_2 = 0.0
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
end
niggers_bomb = L19_1
function L19_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2
  L0_2 = entities
  L0_2 = L0_2.get_user_vehicle_as_handle
  L0_2 = L0_2()
  if 0 ~= L0_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.GET_ENTITY_COORDS
    L2_2 = L0_2
    L3_2 = true
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = get_model_size
    L3_2 = ENTITY
    L3_2 = L3_2.GET_ENTITY_MODEL
    L4_2 = L0_2
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L3_2(L4_2)
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
    L3_2 = 1
    L4_2 = 3
    L5_2 = 1
    for L6_2 = L3_2, L4_2, L5_2 do
      if 1 == L6_2 then
        L7_2 = ENTITY
        L7_2 = L7_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
        L8_2 = L0_2
        L9_2 = L2_2.x
        L9_2 = -L9_2
        L10_2 = L2_2.y
        L10_2 = L10_2 + 0.1
        L11_2 = L2_2.z
        L11_2 = L11_2 / 2
        L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2)
        aad = L7_2
      elseif 2 == L6_2 then
        L7_2 = ENTITY
        L7_2 = L7_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
        L8_2 = L0_2
        L9_2 = 0.0
        L10_2 = L2_2.y
        L10_2 = L10_2 + 0.1
        L11_2 = L2_2.z
        L11_2 = L11_2 / 2
        L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2)
        aad = L7_2
      else
        L7_2 = ENTITY
        L7_2 = L7_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
        L8_2 = L0_2
        L9_2 = L2_2.x
        L10_2 = L2_2.y
        L10_2 = L10_2 + 0.1
        L11_2 = L2_2.z
        L11_2 = L11_2 / 2
        L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2)
        aad = L7_2
      end
      L7_2 = ENTITY
      L7_2 = L7_2.GET_ENTITY_SPEED
      L8_2 = L0_2
      L7_2 = L7_2(L8_2)
      if L7_2 > 10 then
        L7_2 = memory
        L7_2 = L7_2.alloc
        L7_2 = L7_2()
        L8_2 = memory
        L8_2 = L8_2.alloc
        L8_2 = L8_2()
        L9_2 = memory
        L9_2 = L9_2.alloc
        L9_2 = L9_2()
        L10_2 = memory
        L10_2 = L10_2.alloc
        L10_2 = L10_2()
        L11_2 = SHAPETEST
        L11_2 = L11_2.GET_SHAPE_TEST_RESULT
        L12_2 = SHAPETEST
        L13_2 = "START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE"
        L12_2 = L12_2[L13_2]
        L13_2 = L1_2.x
        L14_2 = L1_2.y
        L15_2 = L1_2.z
        L16_2 = aad
        L16_2 = L16_2.x
        L17_2 = aad
        L17_2 = L17_2.y
        L18_2 = aad
        L18_2 = L18_2.z
        L19_2 = -1
        L20_2 = L0_2
        L21_2 = 4
        L12_2 = L12_2(L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
        L13_2 = L7_2
        L14_2 = L8_2
        L15_2 = L9_2
        L16_2 = L10_2
        L11_2(L12_2, L13_2, L14_2, L15_2, L16_2)
        L11_2 = memory
        L11_2 = L11_2.read_int
        L12_2 = L7_2
        L11_2 = L11_2(L12_2)
        L12_2 = memory
        L12_2 = L12_2.read_vector3
        L13_2 = L8_2
        L12_2 = L12_2(L13_2)
        L13_2 = memory
        L13_2 = L13_2.read_vector3
        L14_2 = L9_2
        L13_2 = L13_2(L14_2)
        L14_2 = memory
        L14_2 = L14_2.read_int
        L15_2 = L10_2
        L14_2 = L14_2(L15_2)
        L15_2 = {}
        L16_2 = L11_2
        L17_2 = L12_2
        L18_2 = L13_2
        L19_2 = L14_2
        L15_2[1] = L16_2
        L15_2[2] = L17_2
        L15_2[3] = L18_2
        L15_2[4] = L19_2
        L16_2 = L15_2[1]
        if 0 ~= L16_2 then
          L16_2 = ENTITY
          L16_2 = L16_2.SET_ENTITY_VELOCITY
          L17_2 = L0_2
          L18_2 = 0.0
          L19_2 = 0.0
          L20_2 = 0.0
          L16_2(L17_2, L18_2, L19_2, L20_2)
        end
      end
    end
  end
end
aa_thread = L19_1
function L19_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L0_2 = PLAYER
  L0_2 = L0_2.PLAYER_PED_ID
  L0_2 = L0_2()
  L1_2 = PED
  L1_2 = L1_2.IS_PED_GETTING_INTO_A_VEHICLE
  L2_2 = L0_2
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L1_2 = PED
    L1_2 = L1_2.GET_VEHICLE_PED_IS_ENTERING
    L2_2 = L0_2
    L1_2 = L1_2(L2_2)
    L2_2 = VEHICLE
    L2_2 = L2_2.GET_IS_VEHICLE_ENGINE_RUNNING
    L3_2 = L1_2
    L2_2 = L2_2(L3_2)
    if not L2_2 then
      L2_2 = VEHICLE
      L2_2 = L2_2.SET_VEHICLE_ENGINE_HEALTH
      L3_2 = L1_2
      L4_2 = 1000
      L2_2(L3_2, L4_2)
      L2_2 = VEHICLE
      L2_2 = L2_2.SET_VEHICLE_ENGINE_ON
      L3_2 = L1_2
      L4_2 = true
      L5_2 = true
      L6_2 = false
      L2_2(L3_2, L4_2, L5_2, L6_2)
    end
    L2_2 = VEHICLE
    L2_2 = L2_2.GET_VEHICLE_CLASS
    L3_2 = L1_2
    L2_2 = L2_2(L3_2)
    if 15 == L2_2 then
      L2_2 = VEHICLE
      L2_2 = L2_2.SET_HELI_BLADES_FULL_SPEED
      L3_2 = L1_2
      L2_2(L3_2)
    end
  end
end
fastoncar = L19_1
function L19_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  auto_lock_door = A0_2
  L1_2 = auto_lock_door
  if L1_2 then
    while true do
      L1_2 = auto_lock_door
      if not L1_2 then
        break
      end
      L1_2 = PED
      L1_2 = L1_2.IS_PED_IN_ANY_VEHICLE
      L2_2 = PLAYER
      L2_2 = L2_2.PLAYER_PED_ID
      L2_2 = L2_2()
      L3_2 = true
      L1_2 = L1_2(L2_2, L3_2)
      if L1_2 then
        L1_2 = PED
        L1_2 = L1_2.GET_VEHICLE_PED_IS_IN
        L2_2 = PLAYER
        L2_2 = L2_2.PLAYER_PED_ID
        L2_2 = L2_2()
        L3_2 = false
        L1_2 = L1_2(L2_2, L3_2)
        L2_2 = request_control
        L3_2 = L1_2
        L2_2(L3_2)
        L2_2 = VEHICLE
        L2_2 = L2_2.SET_VEHICLE_DOORS_LOCKED
        L3_2 = L1_2
        L4_2 = 2
        L2_2(L3_2, L4_2)
        L2_2 = PAD
        L2_2 = L2_2.IS_CONTROL_PRESSED
        L3_2 = 0
        L4_2 = 23
        L2_2 = L2_2(L3_2, L4_2)
        if L2_2 then
          L2_2 = TASK
          L2_2 = L2_2.CLEAR_PED_TASKS_IMMEDIATELY
          L3_2 = PLAYER
          L3_2 = L3_2.PLAYER_PED_ID
          L3_2, L4_2, L5_2 = L3_2()
          L2_2(L3_2, L4_2, L5_2)
        end
      else
        L1_2 = PLAYER
        L1_2 = L1_2.GET_PLAYERS_LAST_VEHICLE
        L1_2 = L1_2()
        L2_2 = VEHICLE
        L2_2 = L2_2.SET_VEHICLE_DOORS_LOCKED
        L3_2 = L1_2
        L4_2 = 1
        L2_2(L3_2, L4_2)
      end
      L1_2 = util
      L1_2 = L1_2.yield
      L1_2()
    end
  else
    L1_2 = PED
    L1_2 = L1_2.GET_VEHICLE_PED_IS_IN
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = false
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = PLAYER
    L2_2 = L2_2.GET_PLAYERS_LAST_VEHICLE
    L2_2 = L2_2()
    L3_2 = VEHICLE
    L3_2 = L3_2.SET_VEHICLE_DOORS_LOCKED
    L4_2 = L1_2
    L5_2 = 1
    L3_2(L4_2, L5_2)
    L3_2 = VEHICLE
    L3_2 = L3_2.SET_VEHICLE_DOORS_LOCKED
    L4_2 = L2_2
    L5_2 = 1
    L3_2(L4_2, L5_2)
  end
end
auto_locked = L19_1
function L19_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
  L0_2 = PED
  L0_2 = L0_2.GET_VEHICLE_PED_IS_TRYING_TO_ENTER
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2, L4_2, L5_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2)
  L1_2 = PED
  L1_2 = L1_2.IS_PED_IN_ANY_VEHICLE
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = false
  L1_2 = L1_2(L2_2, L3_2)
  if L1_2 then
    L1_2 = PED
    L1_2 = L1_2.GET_VEHICLE_PED_IS_IN
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = false
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = VEHICLE
    L2_2 = L2_2.SET_VEHICLE_DOORS_LOCKED
    L3_2 = L1_2
    L4_2 = 1
    L2_2(L3_2, L4_2)
    L2_2 = VEHICLE
    L2_2 = L2_2.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS
    L3_2 = L1_2
    L4_2 = false
    L2_2(L3_2, L4_2)
    L2_2 = VEHICLE
    L2_2 = L2_2.SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER
    L3_2 = L1_2
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_ID
    L4_2 = L4_2()
    L5_2 = false
    L2_2(L3_2, L4_2, L5_2)
    L2_2 = ENTITY
    L2_2 = L2_2.FREEZE_ENTITY_POSITION
    L3_2 = vehicle
    L4_2 = false
    L2_2(L3_2, L4_2)
    L2_2 = util
    L2_2 = L2_2.yield
    L2_2()
  elseif 0 ~= L0_2 then
    L1_2 = request_control
    L2_2 = L0_2
    L1_2(L2_2)
    L1_2 = VEHICLE
    L1_2 = L1_2.SET_VEHICLE_DOORS_LOCKED
    L2_2 = L0_2
    L3_2 = 1
    L1_2(L2_2, L3_2)
    L1_2 = VEHICLE
    L1_2 = L1_2.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS
    L2_2 = L0_2
    L3_2 = false
    L1_2(L2_2, L3_2)
    L1_2 = VEHICLE
    L1_2 = L1_2.SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER
    L2_2 = L0_2
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_ID
    L3_2 = L3_2()
    L4_2 = false
    L1_2(L2_2, L3_2, L4_2)
    L1_2 = VEHICLE
    L1_2 = L1_2.SET_VEHICLE_HAS_BEEN_OWNED_BY_PLAYER
    L2_2 = L0_2
    L3_2 = false
    L1_2(L2_2, L3_2)
  end
end
unlockcar = L19_1
function L19_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if 0 ~= L1_2 then
    L1_2 = pairs
    L2_2 = weapon_list
    L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
    for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
      L7_2 = WEAPON
      L7_2 = L7_2.GIVE_WEAPON_TO_PED
      L8_2 = PLAYER
      L8_2 = L8_2.GET_PLAYER_PED
      L9_2 = A0_2
      L8_2 = L8_2(L9_2)
      L9_2 = L6_2.hash
      L10_2 = 9999
      L11_2 = false
      L12_2 = false
      L7_2(L8_2, L9_2, L10_2, L11_2, L12_2)
    end
  end
end
give_all_weapon = L19_1
function L19_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if 0 ~= L1_2 then
    L1_2 = pairs
    L2_2 = weapon_list
    L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
    for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
      L7_2 = WEAPON
      L7_2 = L7_2.REMOVE_WEAPON_FROM_PED
      L8_2 = PLAYER
      L8_2 = L8_2.GET_PLAYER_PED
      L9_2 = A0_2
      L8_2 = L8_2(L9_2)
      L9_2 = L6_2.hash
      L7_2(L8_2, L9_2)
    end
  end
end
remove_all_weapon = L19_1
function L19_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if 0 ~= L1_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.GET_ENTITY_COORDS
    L2_2 = PLAYER
    L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    L3_2 = false
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = util
    L2_2 = L2_2.joaat
    L3_2 = "weapon_heavysniper"
    L2_2 = L2_2(L3_2)
    L3_2 = request_weapon_asset
    L4_2 = L2_2
    L3_2(L4_2)
    L3_2 = WEAPON
    L3_2 = L3_2.GIVE_WEAPON_TO_PED
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2 = L4_2()
    L5_2 = L2_2
    L6_2 = 120
    L7_2 = true
    L8_2 = false
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
    L3_2 = MISC
    L3_2 = L3_2.SHOOT_SINGLE_BULLET_BETWEEN_COORDS
    L4_2 = L1_2.x
    L5_2 = L1_2.y
    L6_2 = L1_2.z
    L6_2 = L6_2 + 5
    L7_2 = L1_2.x
    L8_2 = L1_2.y
    L9_2 = L1_2.z
    L10_2 = 200
    L11_2 = false
    L12_2 = L2_2
    L13_2 = 0
    L14_2 = true
    L15_2 = false
    L16_2 = 2500.0
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  end
end
Heavy_gun_to_player = L19_1
function L19_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if 0 ~= L1_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.GET_ENTITY_COORDS
    L2_2 = PLAYER
    L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    L3_2 = false
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = util
    L2_2 = L2_2.joaat
    L3_2 = "weapon_firework"
    L2_2 = L2_2(L3_2)
    L3_2 = request_weapon_asset
    L4_2 = L2_2
    L3_2(L4_2)
    L3_2 = WEAPON
    L3_2 = L3_2.GIVE_WEAPON_TO_PED
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2 = L4_2()
    L5_2 = L2_2
    L6_2 = 120
    L7_2 = true
    L8_2 = false
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
    L3_2 = MISC
    L3_2 = L3_2.SHOOT_SINGLE_BULLET_BETWEEN_COORDS
    L4_2 = L1_2.x
    L5_2 = L1_2.y
    L6_2 = L1_2.z
    L6_2 = L6_2 + 3.0
    L7_2 = L1_2.x
    L8_2 = L1_2.y
    L9_2 = L1_2.z
    L9_2 = L9_2 - 2.0
    L10_2 = 200
    L11_2 = false
    L12_2 = L2_2
    L13_2 = 0
    L14_2 = true
    L15_2 = false
    L16_2 = 2500.0
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  end
end
firework_to_player = L19_1
function L19_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if 0 ~= L1_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.GET_ENTITY_COORDS
    L2_2 = PLAYER
    L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    L3_2 = false
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = util
    L2_2 = L2_2.joaat
    L3_2 = "weapon_raypistol"
    L2_2 = L2_2(L3_2)
    L3_2 = request_weapon_asset
    L4_2 = L2_2
    L3_2(L4_2)
    L3_2 = WEAPON
    L3_2 = L3_2.GIVE_WEAPON_TO_PED
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2 = L4_2()
    L5_2 = L2_2
    L6_2 = 120
    L7_2 = true
    L8_2 = false
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
    L3_2 = MISC
    L3_2 = L3_2.SHOOT_SINGLE_BULLET_BETWEEN_COORDS
    L4_2 = L1_2.x
    L5_2 = L1_2.y
    L6_2 = L1_2.z
    L6_2 = L6_2 + 3.0
    L7_2 = L1_2.x
    L8_2 = L1_2.y
    L9_2 = L1_2.z
    L9_2 = L9_2 - 2.0
    L10_2 = 200
    L11_2 = false
    L12_2 = L2_2
    L13_2 = 0
    L14_2 = true
    L15_2 = false
    L16_2 = 2500.0
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  end
end
atom_waves_to_player = L19_1
function L19_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if 0 ~= L1_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.GET_ENTITY_COORDS
    L2_2 = PLAYER
    L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    L3_2 = false
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = util
    L2_2 = L2_2.joaat
    L3_2 = "weapon_molotov"
    L2_2 = L2_2(L3_2)
    L3_2 = request_weapon_asset
    L4_2 = L2_2
    L3_2(L4_2)
    L3_2 = WEAPON
    L3_2 = L3_2.GIVE_WEAPON_TO_PED
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2 = L4_2()
    L5_2 = L2_2
    L6_2 = 120
    L7_2 = true
    L8_2 = false
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
    L3_2 = MISC
    L3_2 = L3_2.SHOOT_SINGLE_BULLET_BETWEEN_COORDS
    L4_2 = L1_2.x
    L5_2 = L1_2.y
    L6_2 = L1_2.z
    L7_2 = L1_2.x
    L8_2 = L1_2.y
    L9_2 = L1_2.z
    L9_2 = L9_2 - 2.0
    L10_2 = 200
    L11_2 = false
    L12_2 = L2_2
    L13_2 = 0
    L14_2 = true
    L15_2 = false
    L16_2 = 2500.0
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  end
end
Incendiary_to_player = L19_1
function L19_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if 0 ~= L1_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.GET_ENTITY_COORDS
    L2_2 = PLAYER
    L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    L3_2 = false
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = util
    L2_2 = L2_2.joaat
    L3_2 = "weapon_emplauncher"
    L2_2 = L2_2(L3_2)
    L3_2 = request_weapon_asset
    L4_2 = L2_2
    L3_2(L4_2)
    L3_2 = WEAPON
    L3_2 = L3_2.GIVE_WEAPON_TO_PED
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2 = L4_2()
    L5_2 = L2_2
    L6_2 = 120
    L7_2 = true
    L8_2 = false
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
    L3_2 = MISC
    L3_2 = L3_2.SHOOT_SINGLE_BULLET_BETWEEN_COORDS
    L4_2 = L1_2.x
    L5_2 = L1_2.y
    L6_2 = L1_2.z
    L7_2 = L1_2.x
    L8_2 = L1_2.y
    L9_2 = L1_2.z
    L9_2 = L9_2 - 2.0
    L10_2 = 200
    L11_2 = false
    L12_2 = L2_2
    L13_2 = 0
    L14_2 = true
    L15_2 = false
    L16_2 = 2500.0
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  end
end
ElectroMagnetic_Pulse_to_player = L19_1
function L19_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "p_spinning_anus_s"
  L1_2 = L1_2(L2_2)
  L2_2 = request_model
  L3_2 = L1_2
  L2_2(L3_2)
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = ENTITY
  L3_2 = L3_2.GET_ENTITY_COORDS
  L4_2 = L2_2
  L5_2 = false
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = PED
  L4_2 = L4_2.IS_PED_IN_ANY_VEHICLE
  L5_2 = L2_2
  L6_2 = true
  L4_2 = L4_2(L5_2, L6_2)
  if L4_2 then
    L4_2 = deleplayercar
    L5_2 = A0_2
    L4_2(L5_2)
  end
  L4_2 = entities
  L4_2 = L4_2.create_object
  L5_2 = L1_2
  L6_2 = L3_2
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_VISIBLE
  L6_2 = L4_2
  L7_2 = false
  L5_2(L6_2, L7_2)
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_INVINCIBLE
  L6_2 = L4_2
  L7_2 = true
  L5_2(L6_2, L7_2)
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_COLLISION
  L6_2 = L4_2
  L7_2 = true
  L8_2 = true
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = delete_entity
  L6_2 = L4_2
  L5_2(L6_2)
end
Scope_deletion = L19_1
function L19_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if 0 ~= L1_2 then
    L1_2 = util
    L1_2 = L1_2.joaat
    L2_2 = "adder"
    L1_2 = L1_2(L2_2)
    L2_2 = PLAYER
    L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    L3_2 = ENTITY
    L3_2 = L3_2.GET_ENTITY_COORDS
    L4_2 = L2_2
    L3_2 = L3_2(L4_2)
    L4_2 = L3_2.z
    L4_2 = L4_2 - 10
    L3_2.z = L4_2
    L4_2 = request_model
    L5_2 = L1_2
    L4_2(L5_2)
    L4_2 = entities
    L4_2 = L4_2.create_vehicle
    L5_2 = L1_2
    L6_2 = L3_2
    L7_2 = 0
    L4_2 = L4_2(L5_2, L6_2, L7_2)
    L5_2 = ENTITY
    L5_2 = L5_2.SET_ENTITY_VISIBLE
    L6_2 = L4_2
    L7_2 = false
    L5_2(L6_2, L7_2)
    L5_2 = util
    L5_2 = L5_2.yield
    L6_2 = 250
    L5_2(L6_2)
    if 0 ~= L4_2 then
      L5_2 = ENTITY
      L5_2 = L5_2.APPLY_FORCE_TO_ENTITY
      L6_2 = L4_2
      L7_2 = 1
      L8_2 = 0.0
      L9_2 = 0.0
      L10_2 = 100
      L11_2 = 0.0
      L12_2 = 0.0
      L13_2 = 0.0
      L14_2 = 0
      L15_2 = 1
      L16_2 = 1
      L17_2 = 1
      L18_2 = 0
      L19_2 = 1
      L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
      L5_2 = util
      L5_2 = L5_2.yield
      L6_2 = 250
      L5_2(L6_2)
      L5_2 = delete_entity
      L6_2 = L4_2
      L5_2(L6_2)
    end
  end
end
Bounce_Flying_Player = L19_1
function L19_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if 0 ~= L1_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.GET_ENTITY_COORDS
    L2_2 = PLAYER
    L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    L3_2 = false
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = util
    L2_2 = L2_2.joaat
    L3_2 = "weapon_firework"
    L2_2 = L2_2(L3_2)
    L3_2 = request_weapon_asset
    L4_2 = L2_2
    L3_2(L4_2)
    L3_2 = WEAPON
    L3_2 = L3_2.GIVE_WEAPON_TO_PED
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2 = L4_2()
    L5_2 = L2_2
    L6_2 = 120
    L7_2 = true
    L8_2 = false
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
    L3_2 = MISC
    L3_2 = L3_2.SHOOT_SINGLE_BULLET_BETWEEN_COORDS
    L4_2 = L1_2.x
    L5_2 = L1_2.y
    L6_2 = L1_2.z
    L6_2 = L6_2 + 3.0
    L7_2 = L1_2.x
    L8_2 = L1_2.y
    L9_2 = L1_2.z
    L9_2 = L9_2 - 2.0
    L10_2 = 200
    L11_2 = false
    L12_2 = L2_2
    L13_2 = 0
    L14_2 = true
    L15_2 = false
    L16_2 = 2500.0
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
    L3_2 = util
    L3_2 = L3_2.joaat
    L4_2 = "adder"
    L3_2 = L3_2(L4_2)
    L4_2 = PLAYER
    L4_2 = L4_2.GET_PLAYER_PED_SCRIPT_INDEX
    L5_2 = A0_2
    L4_2 = L4_2(L5_2)
    L5_2 = ENTITY
    L5_2 = L5_2.GET_ENTITY_COORDS
    L6_2 = L4_2
    L5_2 = L5_2(L6_2)
    L6_2 = L5_2.z
    L6_2 = L6_2 - 10
    L5_2.z = L6_2
    L6_2 = request_model
    L7_2 = L3_2
    L6_2(L7_2)
    L6_2 = entities
    L6_2 = L6_2.create_vehicle
    L7_2 = L3_2
    L8_2 = L5_2
    L9_2 = 0
    L6_2 = L6_2(L7_2, L8_2, L9_2)
    L7_2 = ENTITY
    L7_2 = L7_2.SET_ENTITY_VISIBLE
    L8_2 = L6_2
    L9_2 = false
    L7_2(L8_2, L9_2)
    if 0 ~= L6_2 then
      L7_2 = ENTITY
      L7_2 = L7_2.APPLY_FORCE_TO_ENTITY
      L8_2 = L6_2
      L9_2 = 1
      L10_2 = 0.0
      L11_2 = 0.0
      L12_2 = 100
      L13_2 = 0.0
      L14_2 = 0.0
      L15_2 = 0.0
      L16_2 = 0
      L17_2 = 1
      L18_2 = 1
      L19_2 = 1
      L20_2 = 0
      L21_2 = 1
      L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
      L7_2 = util
      L7_2 = L7_2.yield
      L8_2 = 100
      L7_2(L8_2)
      L7_2 = delete_entity
      L8_2 = L6_2
      L7_2(L8_2)
    end
  end
end
firework_send_player = L19_1
air_strike_state = 0
L19_1 = util
L19_1 = L19_1.joaat
L20_1 = "weapon_airstrike_rocket"
L19_1 = L19_1(L20_1)
L20_1 = _ENV
L21_1 = "air_strike_plane"
function L22_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L0_2 = Config
  L0_2 = L0_2.controls
  L0_2 = L0_2.airstrikeaircraft
  L1_2 = air_strike_state
  if 0 == L1_2 then
    L1_2 = notification
    L2_2 = "~y~~bold~空袭飞机可用于飞机和直升机"
    L3_2 = HudColour
    L3_2 = L3_2.blue
    L1_2(L2_2, L3_2)
    L1_2 = "按 ~%s~ 以使用空袭飞机"
    L2_2 = util
    L2_2 = L2_2.show_corner_help
    L4_2 = L1_2
    L3_2 = L1_2.format
    L5_2 = "INPUT_VEH_HORN"
    L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2, L5_2)
    L2_2(L3_2, L4_2, L5_2, L6_2)
    air_strike_state = 1
  end
  L1_2 = PED
  L1_2 = L1_2.IS_PED_IN_FLYING_VEHICLE
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2, L3_2, L4_2, L5_2, L6_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
  if L1_2 then
    L1_2 = PAD
    L1_2 = L1_2.IS_CONTROL_PRESSED
    L2_2 = 2
    L3_2 = L0_2
    L1_2 = L1_2(L2_2, L3_2)
    if L1_2 then
      L1_2 = timer
      L1_2 = L1_2.elapsed
      L1_2 = L1_2()
      L2_2 = 800
      if L1_2 > L2_2 then
        L1_2 = PED
        L1_2 = L1_2.GET_VEHICLE_PED_IS_IN
        L2_2 = PLAYER
        L2_2 = L2_2.PLAYER_PED_ID
        L2_2 = L2_2()
        L3_2 = false
        L1_2 = L1_2(L2_2, L3_2)
        L2_2 = ENTITY
        L2_2 = L2_2.GET_ENTITY_COORDS
        L3_2 = L1_2
        L4_2 = false
        L2_2 = L2_2(L3_2, L4_2)
        L3_2 = get_ground_z
        L4_2 = L2_2
        L3_2 = L3_2(L4_2)
        L4_2 = newTimer
        L4_2 = L4_2()
        L5_2 = util
        L5_2 = L5_2.create_tick_handler
        function L6_2()
          local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3
          L0_3 = util
          L0_3 = L0_3.yield
          L1_3 = 500
          L0_3(L1_3)
          L0_3 = L2_2.z
          L1_3 = L3_2
          L0_3 = L0_3 - L1_3
          if L0_3 < 10.0 then
            L0_3 = false
            return L0_3
          end
          L0_3 = get_random_offset_in_range
          L1_3 = L2_2
          L2_3 = 0.0
          L3_3 = 5.0
          L0_3 = L0_3(L1_3, L2_3, L3_3)
          L1_3 = MISC
          L1_3 = L1_3.SHOOT_SINGLE_BULLET_BETWEEN_COORDS
          L2_3 = L0_3.x
          L3_3 = L0_3.y
          L4_3 = L0_3.z
          L4_3 = L4_3 - 3.0
          L5_3 = L0_3.x
          L6_3 = L0_3.y
          L7_3 = L3_2
          L8_3 = 200
          L9_3 = true
          L10_3 = L19_1
          L11_3 = PLAYER
          L11_3 = L11_3.PLAYER_PED_ID
          L11_3 = L11_3()
          L12_3 = true
          L13_3 = false
          L14_3 = 1000.0
          L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3)
          L1_3 = L4_2.elapsed
          L1_3 = L1_3()
          L2_3 = 5000
          L1_3 = L1_3 < L2_3
          return L1_3
        end
        L5_2(L6_2)
        L5_2 = timer
        L5_2 = L5_2.reset
        L5_2()
      end
    end
  end
end
L20_1[L21_1] = L22_1
L20_1 = _ENV
L21_1 = "Firework_Gun"
function L22_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2
  L0_2 = WEAPON
  L0_2 = L0_2.GET_SELECTED_PED_WEAPON
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
  if 2138347493 == L0_2 then
    L0_2 = ENTITY
    L0_2 = L0_2.DOES_ENTITY_EXIST
    L1_2 = firework
    L0_2 = L0_2(L1_2)
    if not L0_2 then
      L0_2 = PLAYER
      L0_2 = L0_2.DISABLE_PLAYER_FIRING
      L1_2 = PLAYER
      L1_2 = L1_2.PLAYER_PED_ID
      L1_2 = L1_2()
      L2_2 = true
      L0_2(L1_2, L2_2)
      L0_2 = PAD
      L0_2 = L0_2.IS_DISABLED_CONTROL_PRESSED
      L1_2 = 0
      L2_2 = 24
      L0_2 = L0_2(L1_2, L2_2)
      if L0_2 then
        L0_2 = util
        L0_2 = L0_2.joaat
        L1_2 = "w_lr_firework_rocket"
        L0_2 = L0_2(L1_2)
        L1_2 = request_model
        L2_2 = L0_2
        L1_2(L2_2)
        L1_2 = ENTITY
        L1_2 = L1_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
        L2_2 = PLAYER
        L2_2 = L2_2.PLAYER_PED_ID
        L2_2 = L2_2()
        L3_2 = 0.0
        L4_2 = 0.5
        L5_2 = 0.5
        L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2)
        L2_2 = {}
        L3_2 = get_offset_from_gameplay_camera
        L4_2 = 15
        L3_2 = L3_2(L4_2)
        L4_2 = L3_2.x
        L5_2 = L1_2.x
        L4_2 = L4_2 - L5_2
        L4_2 = L4_2 * 15
        L2_2.x = L4_2
        L4_2 = L3_2.y
        L5_2 = L1_2.y
        L4_2 = L4_2 - L5_2
        L4_2 = L4_2 * 15
        L2_2.y = L4_2
        L4_2 = L3_2.z
        L5_2 = L1_2.z
        L4_2 = L4_2 - L5_2
        L4_2 = L4_2 * 15
        L2_2.z = L4_2
        L4_2 = OBJECT
        L4_2 = L4_2.CREATE_OBJECT_NO_OFFSET
        L5_2 = L0_2
        L6_2 = L1_2.x
        L7_2 = L1_2.y
        L8_2 = L1_2.z
        L9_2 = true
        L10_2 = false
        L11_2 = false
        L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
        firework = L4_2
        L4_2 = CAM
        L4_2 = L4_2.GET_GAMEPLAY_CAM_ROT
        L5_2 = 0
        L4_2 = L4_2(L5_2)
        L5_2 = ENTITY
        L5_2 = L5_2.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
        L6_2 = firework
        L7_2 = 1
        L8_2 = L2_2.x
        L9_2 = L2_2.y
        L10_2 = L2_2.z
        L11_2 = false
        L12_2 = false
        L13_2 = false
        L14_2 = false
        L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
        L5_2 = ENTITY
        L5_2 = L5_2.SET_ENTITY_ROTATION
        L6_2 = firework
        L7_2 = L4_2.x
        L8_2 = L4_2.y
        L9_2 = L4_2.z
        L10_2 = 0
        L11_2 = true
        L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
        L5_2 = ENTITY
        L5_2 = L5_2.SET_ENTITY_HAS_GRAVITY
        L6_2 = firework
        L7_2 = false
        L5_2(L6_2, L7_2)
        L5_2 = request_ptfx_asset
        L6_2 = "scr_rcpaparazzo1"
        L5_2(L6_2)
        L5_2 = GRAPHICS
        L5_2 = L5_2.USE_PARTICLE_FX_ASSET
        L6_2 = "scr_rcpaparazzo1"
        L5_2(L6_2)
        L5_2 = GRAPHICS
        L6_2 = "START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY"
        L5_2 = L5_2[L6_2]
        L6_2 = "scr_mich4_firework_trail_spawn"
        L7_2 = firework
        L8_2 = 0.0
        L9_2 = 0.0
        L10_2 = 0.0
        L11_2 = 0.0
        L12_2 = 0.0
        L13_2 = 0.0
        L14_2 = 1.0
        L15_2 = false
        L16_2 = false
        L17_2 = false
        L18_2 = 0
        L19_2 = 0
        L20_2 = 0
        L21_2 = 0
        L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
        L6_2 = GRAPHICS
        L6_2 = L6_2.SET_PARTICLE_FX_LOOPED_COLOUR
        L7_2 = L5_2
        L8_2 = 255
        L9_2 = 255
        L10_2 = 255
        L11_2 = 0
        L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
        L6_2 = 150
        while true do
          L7_2 = ENTITY
          L7_2 = L7_2.HAS_ENTITY_COLLIDED_WITH_ANYTHING
          L8_2 = firework
          L7_2 = L7_2(L8_2)
          if not (not L7_2 and L6_2 > 0) then
            break
          end
          L7_2 = WEAPON
          L7_2 = L7_2.GET_SELECTED_PED_WEAPON
          L8_2 = PLAYER
          L8_2 = L8_2.PLAYER_PED_ID
          L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L8_2()
          L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
          if 2138347493 == L7_2 then
            L7_2 = PLAYER
            L7_2 = L7_2.DISABLE_PLAYER_FIRING
            L8_2 = PLAYER
            L8_2 = L8_2.PLAYER_PED_ID
            L8_2 = L8_2()
            L9_2 = true
            L7_2(L8_2, L9_2)
          end
          L6_2 = L6_2 - 1
          L7_2 = util
          L7_2 = L7_2.yield
          L7_2()
        end
        if not (L6_2 <= 0) then
          L7_2 = ENTITY
          L7_2 = L7_2.HAS_ENTITY_COLLIDED_WITH_ANYTHING
          L8_2 = firework
          L7_2 = L7_2(L8_2)
          if not L7_2 then
            goto lbl_258
          end
        end
        L7_2 = GRAPHICS
        L7_2 = L7_2.STOP_PARTICLE_FX_LOOPED
        L8_2 = L5_2
        L9_2 = false
        L7_2(L8_2, L9_2)
        L7_2 = ENTITY
        L7_2 = L7_2.GET_ENTITY_COORDS
        L8_2 = firework
        L9_2 = true
        L7_2 = L7_2(L8_2, L9_2)
        L8_2 = delete_entity
        L9_2 = firework
        L8_2(L9_2)
        L8_2 = 1
        L9_2 = 10
        L10_2 = 1
        for L11_2 = L8_2, L9_2, L10_2 do
          L12_2 = util
          L12_2 = L12_2.joaat
          L13_2 = "adder"
          L12_2 = L12_2(L13_2)
          L13_2 = request_model
          L14_2 = L12_2
          L13_2(L14_2)
          L13_2 = entities
          L13_2 = L13_2.create_vehicle
          L14_2 = L12_2
          L15_2 = L7_2
          L16_2 = 0
          L13_2 = L13_2(L14_2, L15_2, L16_2)
          L14_2 = ENTITY
          L14_2 = L14_2.SET_ENTITY_COLLISION
          L15_2 = L13_2
          L16_2 = false
          L17_2 = true
          L14_2(L15_2, L16_2, L17_2)
          L14_2 = ENTITY
          L14_2 = L14_2.SET_ENTITY_ROTATION
          L15_2 = L13_2
          L16_2 = math
          L16_2 = L16_2.random
          L17_2 = -180.0
          L18_2 = 180.0
          L16_2 = L16_2(L17_2, L18_2)
          L17_2 = math
          L17_2 = L17_2.random
          L18_2 = -180.0
          L19_2 = 180.0
          L17_2 = L17_2(L18_2, L19_2)
          L18_2 = math
          L18_2 = L18_2.random
          L19_2 = -180.0
          L20_2 = 180.0
          L18_2 = L18_2(L19_2, L20_2)
          L19_2 = 0
          L20_2 = true
          L14_2(L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
          L14_2 = VEHICLE
          L14_2 = L14_2.SET_VEHICLE_FORWARD_SPEED
          L15_2 = L13_2
          L16_2 = 25
          L14_2(L15_2, L16_2)
          L14_2 = util
          L14_2 = L14_2.yield
          L15_2 = 250
          L14_2(L15_2)
          L14_2 = ENTITY
          L14_2 = L14_2.SET_ENTITY_COLLISION
          L15_2 = L13_2
          L16_2 = true
          L17_2 = true
          L14_2(L15_2, L16_2, L17_2)
        end
      end
    end
  end
  ::lbl_258::
end
L20_1[L21_1] = L22_1
L20_1 = _ENV
L21_1 = "Telomere_gun"
function L22_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L0_2 = draw_string
  L1_2 = "~b~已准备就绪"
  L2_2 = 0.02
  L3_2 = 0.05
  L4_2 = 0.6
  L5_2 = 4
  L0_2(L1_2, L2_2, L3_2, L4_2, L5_2)
  L0_2 = PED
  L0_2 = L0_2.IS_PED_SHOOTING
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  if L0_2 then
    L0_2 = util
    L0_2 = L0_2.joaat
    L1_2 = "w_lr_firework_rocket"
    L0_2 = L0_2(L1_2)
    L1_2 = ENTITY
    L1_2 = L1_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = 0.0
    L4_2 = 0.5
    L5_2 = 0.5
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2)
    L2_2 = {}
    L3_2 = get_offset_from_gameplay_camera
    L4_2 = 15
    L3_2 = L3_2(L4_2)
    L4_2 = L3_2.x
    L5_2 = L1_2.x
    L4_2 = L4_2 - L5_2
    L4_2 = L4_2 * 15
    L2_2.x = L4_2
    L4_2 = L3_2.y
    L5_2 = L1_2.y
    L4_2 = L4_2 - L5_2
    L4_2 = L4_2 * 15
    L2_2.y = L4_2
    L4_2 = L3_2.z
    L5_2 = L1_2.z
    L4_2 = L4_2 - L5_2
    L4_2 = L4_2 * 15
    L2_2.z = L4_2
    L4_2 = ENTITY
    L4_2 = L4_2.DOES_ENTITY_EXIST
    L5_2 = particle_gun_bullet
    L4_2 = L4_2(L5_2)
    if L4_2 then
      L4_2 = delete_entity
      L5_2 = particle_gun_bullet
      L4_2(L5_2)
    end
    L4_2 = create_object
    L5_2 = L0_2
    L6_2 = L1_2.x
    L7_2 = L1_2.y
    L8_2 = L1_2.z
    L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
    particle_gun_bullet = L4_2
    L4_2 = set_entity_full_visible
    L5_2 = particle_gun_bullet
    L6_2 = false
    L4_2(L5_2, L6_2)
    L4_2 = ENTITY
    L4_2 = L4_2.SET_ENTITY_INVINCIBLE
    L5_2 = particle_gun_bullet
    L6_2 = true
    L4_2(L5_2, L6_2)
    L4_2 = ENTITY
    L4_2 = L4_2.SET_ENTITY_COLLISION
    L5_2 = particle_gun_bullet
    L6_2 = false
    L7_2 = true
    L4_2(L5_2, L6_2, L7_2)
    L4_2 = ENTITY
    L4_2 = L4_2.SET_ENTITY_HAS_GRAVITY
    L5_2 = particle_gun_bullet
    L6_2 = false
    L4_2(L5_2, L6_2)
    L4_2 = CAM
    L4_2 = L4_2.GET_GAMEPLAY_CAM_ROT
    L5_2 = 0
    L4_2 = L4_2(L5_2)
    L5_2 = ENTITY
    L5_2 = L5_2.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
    L6_2 = particle_gun_bullet
    L7_2 = 1
    L8_2 = L2_2.x
    L9_2 = L2_2.y
    L10_2 = L2_2.z
    L11_2 = false
    L12_2 = false
    L13_2 = false
    L14_2 = false
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    L5_2 = ENTITY
    L5_2 = L5_2.SET_ENTITY_ROTATION
    L6_2 = particle_gun_bullet
    L7_2 = L4_2.x
    L8_2 = L4_2.y
    L9_2 = L4_2.z
    L10_2 = 0
    L11_2 = true
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    L5_2 = util
    L5_2 = L5_2.yield
    L6_2 = 200
    L5_2(L6_2)
    L5_2 = os
    L5_2 = L5_2.time
    L5_2 = L5_2()
    L5_2 = L5_2 + 4
    while true do
      L6_2 = os
      L6_2 = L6_2.time
      L6_2 = L6_2()
      if not (L5_2 >= L6_2) then
        break
      end
      L6_2 = draw_string
      L7_2 = "~r~充能中..."
      L8_2 = 0.02
      L9_2 = 0.05
      L10_2 = 0.6
      L11_2 = 4
      L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
      L6_2 = PLAYER
      L6_2 = L6_2.DISABLE_PLAYER_FIRING
      L7_2 = PLAYER
      L7_2 = L7_2.PLAYER_ID
      L7_2 = L7_2()
      L8_2 = true
      L6_2(L7_2, L8_2)
      L6_2 = ENTITY
      L6_2 = L6_2.GET_ENTITY_COORDS
      L7_2 = particle_gun_bullet
      L8_2 = false
      L6_2 = L6_2(L7_2, L8_2)
      L7_2 = FIRE
      L7_2 = L7_2.ADD_EXPLOSION
      L8_2 = L6_2.x
      L9_2 = L6_2.y
      L10_2 = L6_2.z
      L11_2 = 5
      L12_2 = 1
      L13_2 = true
      L14_2 = false
      L15_2 = 0
      L16_2 = false
      L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
      L7_2 = util
      L7_2 = L7_2.yield
      L7_2()
    end
  end
end
L20_1[L21_1] = L22_1
L20_1 = _ENV
L21_1 = "grappling_gun"
function L22_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L0_2 = PED
  L0_2 = L0_2.IS_PED_SHOOTING
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  if L0_2 then
    L0_2 = PED
    L0_2 = L0_2.GET_VEHICLE_PED_IS_IN
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_PED_ID
    L1_2 = L1_2()
    L2_2 = false
    L0_2 = L0_2(L1_2, L2_2)
    if L0_2 then
      L0_2 = raycast_gameplay_cam
      L1_2 = -1
      L2_2 = 10000.0
      L0_2 = L0_2(L1_2, L2_2)
      L1_2 = L0_2[1]
      if 1 == L1_2 then
        L1_2 = nil
        L2_2 = TASK
        L2_2 = L2_2.TASK_SKY_DIVE
        L3_2 = PLAYER
        L3_2 = L3_2.PLAYER_PED_ID
        L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L3_2()
        L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
        while true do
          L2_2 = PAD
          L2_2 = L2_2.IS_CONTROL_JUST_PRESSED
          L3_2 = 45
          L4_2 = 45
          L2_2 = L2_2(L3_2, L4_2)
          if L2_2 then
            break
          end
          L2_2 = L0_2[4]
          if 0 ~= L2_2 then
            L2_2 = ENTITY
            L2_2 = L2_2.GET_ENTITY_TYPE
            L3_2 = L0_2[4]
            L2_2 = L2_2(L3_2)
            if L2_2 >= 1 then
              L2_2 = ENTITY
              L2_2 = L2_2.GET_ENTITY_TYPE
              L3_2 = L0_2[4]
              L2_2 = L2_2(L3_2)
              if L2_2 < 3 then
                L2_2 = ENTITY
                L2_2 = L2_2.GET_ENTITY_COORDS
                L3_2 = L0_2[4]
                L4_2 = true
                L2_2 = L2_2(L3_2, L4_2)
                ggc1 = L2_2
            end
          end
          else
            L2_2 = L0_2[2]
            ggc1 = L2_2
          end
          L2_2 = players
          L2_2 = L2_2.get_position
          L3_2 = PLAYER
          L3_2 = L3_2.PLAYER_ID
          L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L3_2()
          L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
          L3_2 = MISC
          L3_2 = L3_2.GET_DISTANCE_BETWEEN_COORDS
          L4_2 = ggc1
          L4_2 = L4_2.x
          L5_2 = ggc1
          L5_2 = L5_2.y
          L6_2 = ggc1
          L6_2 = L6_2.z
          L7_2 = L2_2.x
          L8_2 = L2_2.y
          L9_2 = L2_2.z
          L10_2 = true
          L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
          if not L1_2 or L1_2 > L3_2 then
            L1_2 = L3_2
          else
            break
          end
          L4_2 = ENTITY
          L4_2 = L4_2.IS_ENTITY_DEAD
          L5_2 = PLAYER
          L5_2 = L5_2.PLAYER_PED_ID
          L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L5_2()
          L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
          if L4_2 then
            break
          end
          if L3_2 >= 10 then
            L4_2 = {}
            L5_2 = ggc1
            L5_2 = L5_2.x
            L6_2 = L2_2.x
            L5_2 = L5_2 - L6_2
            L5_2 = L5_2 * L3_2
            L4_2.x = L5_2
            L5_2 = ggc1
            L5_2 = L5_2.y
            L6_2 = L2_2.y
            L5_2 = L5_2 - L6_2
            L5_2 = L5_2 * L3_2
            L4_2.y = L5_2
            L5_2 = ggc1
            L5_2 = L5_2.z
            L6_2 = L2_2.z
            L5_2 = L5_2 - L6_2
            L5_2 = L5_2 * L3_2
            L4_2.z = L5_2
            L5_2 = ENTITY
            L5_2 = L5_2.SET_ENTITY_VELOCITY
            L6_2 = PLAYER
            L6_2 = L6_2.PLAYER_PED_ID
            L6_2 = L6_2()
            L7_2 = L4_2.x
            L8_2 = L4_2.y
            L9_2 = L4_2.z
            L5_2(L6_2, L7_2, L8_2, L9_2)
          end
          L4_2 = util
          L4_2 = L4_2.yield
          L4_2()
        end
      end
    end
  end
end
L20_1[L21_1] = L22_1
L20_1 = {}
L21_1 = 0
L22_1 = _ENV
L23_1 = "spawn_cargobob_with_magnet"
function L24_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = STREAMING
  L0_2 = L0_2.REQUEST_MODEL
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "cargobob"
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2 = L1_2(L2_2)
  L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  L0_2 = ENTITY
  L0_2 = L0_2.GET_ENTITY_COORDS
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = true
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_HEADING
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  L2_2 = {}
  L3_2 = L0_2.x
  L2_2.x = L3_2
  L3_2 = L0_2.y
  L2_2.y = L3_2
  L3_2 = L0_2.z
  L3_2 = L3_2 + 5.0
  L2_2.z = L3_2
  L3_2 = ENTITY
  L3_2 = L3_2.DOES_ENTITY_EXIST
  L4_2 = L21_1
  L3_2 = L3_2(L4_2)
  if L3_2 then
    L3_2 = delete_entity
    L4_2 = L21_1
    L3_2(L4_2)
  end
  L3_2 = entities
  L3_2 = L3_2.create_vehicle
  L4_2 = util
  L4_2 = L4_2.joaat
  L5_2 = "cargobob"
  L4_2 = L4_2(L5_2)
  L5_2 = L2_2
  L6_2 = L1_2
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  L4_2 = VEHICLE
  L4_2 = L4_2.SET_VEHICLE_ON_GROUND_PROPERLY
  L5_2 = L3_2
  L6_2 = 1.0
  L4_2(L5_2, L6_2)
  L4_2 = VEHICLE
  L4_2 = L4_2.SET_HELI_BLADES_FULL_SPEED
  L5_2 = L3_2
  L4_2(L5_2)
  L4_2 = VEHICLE
  L4_2 = L4_2.CREATE_PICK_UP_ROPE_FOR_CARGOBOB
  L5_2 = L3_2
  L6_2 = 1
  L4_2(L5_2, L6_2)
  L21_1 = L3_2
  L4_2 = PLAYER
  L4_2 = L4_2.PLAYER_PED_ID
  L4_2 = L4_2()
  L5_2 = PED
  L5_2 = L5_2.SET_PED_INTO_VEHICLE
  L6_2 = L4_2
  L7_2 = L3_2
  L8_2 = -1
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = table
  L5_2 = L5_2.insert
  L6_2 = L20_1
  L7_2 = L3_2
  L5_2(L6_2, L7_2)
  return L3_2
end
L22_1[L23_1] = L24_1
L22_1 = 0
L23_1 = _ENV
L24_1 = "spawn_skylift"
function L25_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = STREAMING
  L0_2 = L0_2.REQUEST_MODEL
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "skylift"
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2 = L1_2(L2_2)
  L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  L0_2 = PLAYER
  L0_2 = L0_2.PLAYER_PED_ID
  L0_2 = L0_2()
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_COORDS
  L2_2 = L0_2
  L3_2 = true
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_HEADING
  L3_2 = L0_2
  L2_2 = L2_2(L3_2)
  L3_2 = {}
  L4_2 = L1_2.x
  L3_2.x = L4_2
  L4_2 = L1_2.y
  L3_2.y = L4_2
  L4_2 = L1_2.z
  L4_2 = L4_2 + 5.0
  L3_2.z = L4_2
  L4_2 = ENTITY
  L4_2 = L4_2.DOES_ENTITY_EXIST
  L5_2 = L22_1
  L4_2 = L4_2(L5_2)
  if L4_2 then
    L4_2 = delete_entity
    L5_2 = L22_1
    L4_2(L5_2)
  end
  L4_2 = entities
  L4_2 = L4_2.create_vehicle
  L5_2 = util
  L5_2 = L5_2.joaat
  L6_2 = "skylift"
  L5_2 = L5_2(L6_2)
  L6_2 = L3_2
  L7_2 = L2_2
  L4_2 = L4_2(L5_2, L6_2, L7_2)
  L5_2 = VEHICLE
  L5_2 = L5_2.SET_HELI_BLADES_FULL_SPEED
  L6_2 = L4_2
  L5_2(L6_2)
  L22_1 = L4_2
  L5_2 = PED
  L5_2 = L5_2.SET_PED_INTO_VEHICLE
  L6_2 = L0_2
  L7_2 = L4_2
  L8_2 = -1
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = table
  L5_2 = L5_2.insert
  L6_2 = L20_1
  L7_2 = L4_2
  L5_2(L6_2, L7_2)
  return L4_2
end
L23_1[L24_1] = L25_1
L23_1 = _ENV
L24_1 = "attach_vehicle_to_skylift"
function L25_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  L0_2 = ENTITY
  L0_2 = L0_2.DOES_ENTITY_EXIST
  L1_2 = L22_1
  L0_2 = L0_2(L1_2)
  if L0_2 then
    L0_2 = ENTITY
    L0_2 = L0_2.GET_ENTITY_COORDS
    L1_2 = L22_1
    L2_2 = true
    L0_2 = L0_2(L1_2, L2_2)
    L1_2 = 10.0
    L2_2 = VEHICLE
    L2_2 = L2_2.GET_CLOSEST_VEHICLE
    L3_2 = L0_2.x
    L4_2 = L0_2.y
    L5_2 = L0_2.z
    L6_2 = L1_2
    L7_2 = 0
    L8_2 = 70
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
    if 0 ~= L2_2 then
      L3_2 = ENTITY
      L3_2 = L3_2.ATTACH_ENTITY_TO_ENTITY
      L4_2 = L2_2
      L5_2 = L22_1
      L6_2 = 0
      L7_2 = 0.0
      L8_2 = -3.5
      L9_2 = -2.0
      L10_2 = 0.0
      L11_2 = 0.0
      L12_2 = 0.0
      L13_2 = true
      L14_2 = true
      L15_2 = true
      L16_2 = false
      L17_2 = 0
      L18_2 = true
      L19_2 = 0
      L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
      L3_2 = ENTITY
      L3_2 = L3_2.IS_ENTITY_ATTACHED
      L4_2 = L2_2
      L3_2 = L3_2(L4_2)
      if L3_2 then
        attachedVehicle = L2_2
      end
    end
  end
end
L23_1[L24_1] = L25_1
L23_1 = _ENV
L24_1 = "detach_vehicle_from_skylift"
function L25_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = ENTITY
  L1_2 = L1_2.IS_ENTITY_ATTACHED
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.DETACH_ENTITY
    L2_2 = A0_2
    L3_2 = true
    L4_2 = true
    L1_2(L2_2, L3_2, L4_2)
  end
end
L23_1[L24_1] = L25_1
L23_1 = _ENV
L24_1 = "kamikaze_dare"
function L25_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L2_2 = {}
  L3_2 = "Lazer"
  L4_2 = "Mammatus"
  L5_2 = "Cuban800"
  L2_2[1] = L3_2
  L2_2[2] = L4_2
  L2_2[3] = L5_2
  L3_2 = L2_2[A0_2]
  L4_2 = util
  L4_2 = L4_2.joaat
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  L5_2 = request_model
  L6_2 = L4_2
  L5_2(L6_2)
  L5_2 = PLAYER
  L5_2 = L5_2.GET_PLAYER_PED_SCRIPT_INDEX
  L6_2 = A1_2
  L5_2 = L5_2(L6_2)
  L6_2 = get_random_offset_from_entity
  L7_2 = L5_2
  L8_2 = 20.0
  L9_2 = 20.0
  L6_2 = L6_2(L7_2, L8_2, L9_2)
  L7_2 = L6_2.z
  L7_2 = L7_2 + 30.0
  L6_2.z = L7_2
  L7_2 = entities
  L7_2 = L7_2.create_vehicle
  L8_2 = L4_2
  L9_2 = L6_2
  L10_2 = 0.0
  L7_2 = L7_2(L8_2, L9_2, L10_2)
  L8_2 = set_entity_face_entity
  L9_2 = L7_2
  L10_2 = L5_2
  L11_2 = true
  L8_2(L9_2, L10_2, L11_2)
  L8_2 = VEHICLE
  L8_2 = L8_2.SET_VEHICLE_FORWARD_SPEED
  L9_2 = L7_2
  L10_2 = 150.0
  L8_2(L9_2, L10_2)
  L8_2 = VEHICLE
  L8_2 = L8_2.CONTROL_LANDING_GEAR
  L9_2 = L7_2
  L10_2 = 3
  L8_2(L9_2, L10_2)
  L8_2 = util
  L8_2 = L8_2.yield
  L9_2 = 1000
  L8_2(L9_2)
  L8_2 = delete_entity
  L9_2 = L7_2
  L8_2(L9_2)
end
L23_1[L24_1] = L25_1
L23_1 = _ENV
L24_1 = "Impact_player"
function L25_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L2_2 = {}
  L3_2 = "insurgent2"
  L4_2 = "phantom2"
  L5_2 = "adder"
  L2_2[1] = L3_2
  L2_2[2] = L4_2
  L2_2[3] = L5_2
  L3_2 = L2_2[A0_2]
  L4_2 = util
  L4_2 = L4_2.joaat
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  L5_2 = request_model
  L6_2 = L4_2
  L5_2(L6_2)
  L5_2 = PLAYER
  L5_2 = L5_2.GET_PLAYER_PED_SCRIPT_INDEX
  L6_2 = A1_2
  L5_2 = L5_2(L6_2)
  L6_2 = get_random_offset_from_entity
  L7_2 = L5_2
  L8_2 = 12.0
  L9_2 = 12.0
  L6_2 = L6_2(L7_2, L8_2, L9_2)
  L7_2 = entities
  L7_2 = L7_2.create_vehicle
  L8_2 = L4_2
  L9_2 = L6_2
  L10_2 = 0.0
  L7_2 = L7_2(L8_2, L9_2, L10_2)
  L8_2 = set_entity_face_entity
  L9_2 = L7_2
  L10_2 = L5_2
  L11_2 = false
  L8_2(L9_2, L10_2, L11_2)
  L8_2 = VEHICLE
  L8_2 = L8_2.SET_VEHICLE_DOORS_LOCKED
  L9_2 = L7_2
  L10_2 = 2
  L8_2(L9_2, L10_2)
  L8_2 = VEHICLE
  L8_2 = L8_2.SET_VEHICLE_FORWARD_SPEED
  L9_2 = L7_2
  L10_2 = 100.0
  L8_2(L9_2, L10_2)
  L8_2 = util
  L8_2 = L8_2.yield
  L9_2 = 1000
  L8_2(L9_2)
  L8_2 = delete_entity
  L9_2 = L7_2
  L8_2(L9_2)
end
L23_1[L24_1] = L25_1
L23_1 = 1
L24_1 = _ENV
L25_1 = "blackHolePos"
L26_1 = {}
L27_1 = "x"
L26_1[L27_1] = 0
L27_1 = "y"
L26_1[L27_1] = 0
L27_1 = "z"
L26_1[L27_1] = 0
L24_1[L25_1] = L26_1
L24_1 = _ENV
L25_1 = "tableBlackHole"
L26_1 = {}
L27_1 = "吸引"
L28_1 = "排斥"
L26_1[1] = L27_1
L26_1[2] = L28_1
L24_1[L25_1] = L26_1
L24_1 = 1
L25_1 = 1
L26_1 = 1
L27_1 = 1
L28_1 = _ENV
L29_1 = "black_hole_type"
function L30_1(A0_2)
  local L1_2
  L23_1 = A0_2
end
L28_1[L29_1] = L30_1
L28_1 = _ENV
L29_1 = "black_hole_Sth"
function L30_1(A0_2)
  local L1_2
  L24_1 = A0_2
end
L28_1[L29_1] = L30_1
L28_1 = _ENV
L29_1 = "black_hole_posuser"
function L30_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = ENTITY
  L0_2 = L0_2.GET_ENTITY_COORDS
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_ID
  L2_2, L3_2, L4_2 = L2_2()
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2, L3_2, L4_2)
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2)
  L1_2 = menu
  L1_2 = L1_2.set_value
  L2_2 = blackHolePosX
  L3_2 = math
  L3_2 = L3_2.floor
  L4_2 = L0_2.x
  L3_2, L4_2 = L3_2(L4_2)
  L1_2(L2_2, L3_2, L4_2)
  L1_2 = menu
  L1_2 = L1_2.set_value
  L2_2 = blackHolePosY
  L3_2 = math
  L3_2 = L3_2.floor
  L4_2 = L0_2.y
  L3_2, L4_2 = L3_2(L4_2)
  L1_2(L2_2, L3_2, L4_2)
  L1_2 = menu
  L1_2 = L1_2.set_value
  L2_2 = blackHolePosZ
  L3_2 = math
  L3_2 = L3_2.floor
  L4_2 = L0_2.z
  L3_2, L4_2 = L3_2(L4_2)
  L1_2(L2_2, L3_2, L4_2)
  L1_2 = blackHolePos
  L2_2 = L0_2.x
  L1_2.x = L2_2
  L1_2 = blackHolePos
  L2_2 = L0_2.y
  L1_2.y = L2_2
  L1_2 = blackHolePos
  L2_2 = L0_2.z
  L1_2.z = L2_2
end
L28_1[L29_1] = L30_1
L28_1 = _ENV
L29_1 = "black_hole_posx"
function L30_1(A0_2)
  local L1_2
  L1_2 = blackHolePos
  L1_2.x = A0_2
end
L28_1[L29_1] = L30_1
L28_1 = _ENV
L29_1 = "black_hole_posy"
function L30_1(A0_2)
  local L1_2
  L1_2 = blackHolePos
  L1_2.y = A0_2
end
L28_1[L29_1] = L30_1
L28_1 = _ENV
L29_1 = "black_hole_posz"
function L30_1(A0_2)
  local L1_2
  L1_2 = blackHolePos
  L1_2.z = A0_2
end
L28_1[L29_1] = L30_1
L28_1 = _ENV
L29_1 = "black_hole"
function L30_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2
  L0_2 = entities
  L0_2 = L0_2.get_all_peds_as_handles
  L0_2 = L0_2()
  L1_2 = entities
  L1_2 = L1_2.get_all_vehicles_as_handles
  L1_2 = L1_2()
  L2_2 = ipairs
  L3_2 = L0_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = PLAYER
    L8_2 = L8_2.GET_PLAYER_PED
    L9_2 = PLAYER
    L9_2 = L9_2.PLAYER_ID
    L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L9_2()
    L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
    if L7_2 ~= L8_2 then
      L8_2 = #L1_2
      L8_2 = L8_2 + 1
      L1_2[L8_2] = L7_2
    end
  end
  L2_2 = ipairs
  L3_2 = L1_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = ENTITY
    L8_2 = L8_2.GET_ENTITY_COORDS
    L9_2 = L7_2
    L8_2 = L8_2(L9_2)
    vehiclePos = L8_2
    L8_2 = ENTITY
    L8_2 = L8_2.DOES_ENTITY_EXIST
    L9_2 = L7_2
    L8_2 = L8_2(L9_2)
    if true == L8_2 then
      L8_2 = NETWORK
      L8_2 = L8_2.NETWORK_HAS_CONTROL_OF_ENTITY
      L9_2 = L7_2
      L8_2 = L8_2(L9_2)
      if false == L8_2 then
        L8_2 = NETWORK
        L8_2 = L8_2.NETWORK_REQUEST_CONTROL_OF_ENTITY
        L9_2 = L7_2
        L8_2(L9_2)
      end
      L8_2 = L23_1
      if 1 == L8_2 then
        L8_2 = blackHolePos
        L8_2 = L8_2.x
        L9_2 = vehiclePos
        L9_2 = L9_2.x
        if L8_2 > L9_2 then
          L8_2 = L24_1
          L25_1 = L8_2
        else
          L8_2 = blackHolePos
          L8_2 = L8_2.x
          L9_2 = vehiclePos
          L9_2 = L9_2.x
          if L8_2 < L9_2 then
            L8_2 = L24_1
            L8_2 = -L8_2
            L25_1 = L8_2
          end
        end
        L8_2 = blackHolePos
        L8_2 = L8_2.y
        L9_2 = vehiclePos
        L9_2 = L9_2.y
        if L8_2 > L9_2 then
          L8_2 = L24_1
          L26_1 = L8_2
        else
          L8_2 = blackHolePos
          L8_2 = L8_2.y
          L9_2 = vehiclePos
          L9_2 = L9_2.y
          if L8_2 < L9_2 then
            L8_2 = L24_1
            L8_2 = -L8_2
            L26_1 = L8_2
          end
        end
        L8_2 = blackHolePos
        L8_2 = L8_2.z
        L9_2 = vehiclePos
        L9_2 = L9_2.z
        if L8_2 > L9_2 then
          L8_2 = L24_1
          L27_1 = L8_2
        else
          L8_2 = blackHolePos
          L8_2 = L8_2.z
          L9_2 = vehiclePos
          L9_2 = L9_2.z
          if L8_2 < L9_2 then
            L8_2 = L24_1
            L8_2 = -L8_2
            L27_1 = L8_2
          end
        end
        L8_2 = ENTITY
        L8_2 = L8_2.APPLY_FORCE_TO_ENTITY
        L9_2 = L7_2
        L10_2 = 1
        L11_2 = L25_1
        L12_2 = L26_1
        L13_2 = L27_1
        L14_2 = 0
        L15_2 = 0
        L16_2 = 0
        L17_2 = 0
        L18_2 = false
        L19_2 = true
        L20_2 = true
        L21_2 = false
        L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
      else
        L8_2 = L23_1
        if 2 == L8_2 then
          L8_2 = blackHolePos
          L8_2 = L8_2.x
          L9_2 = vehiclePos
          L9_2 = L9_2.x
          if L8_2 > L9_2 then
            L8_2 = L24_1
            L8_2 = -L8_2
            L25_1 = L8_2
          else
            L8_2 = blackHolePos
            L8_2 = L8_2.x
            L9_2 = vehiclePos
            L9_2 = L9_2.x
            if L8_2 < L9_2 then
              L8_2 = L24_1
              L25_1 = L8_2
            end
          end
          L8_2 = blackHolePos
          L8_2 = L8_2.y
          L9_2 = vehiclePos
          L9_2 = L9_2.y
          if L8_2 > L9_2 then
            L8_2 = L24_1
            L8_2 = -L8_2
            L26_1 = L8_2
          else
            L8_2 = blackHolePos
            L8_2 = L8_2.y
            L9_2 = vehiclePos
            L9_2 = L9_2.y
            if L8_2 < L9_2 then
              L8_2 = L24_1
              L26_1 = L8_2
            end
          end
          L8_2 = blackHolePos
          L8_2 = L8_2.z
          L9_2 = vehiclePos
          L9_2 = L9_2.z
          if L8_2 > L9_2 then
            L8_2 = L24_1
            L8_2 = -L8_2
            L27_1 = L8_2
          else
            L8_2 = blackHolePos
            L8_2 = L8_2.z
            L9_2 = vehiclePos
            L9_2 = L9_2.z
            if L8_2 < L9_2 then
              L8_2 = L24_1
              L27_1 = L8_2
            end
          end
          L8_2 = ENTITY
          L8_2 = L8_2.APPLY_FORCE_TO_ENTITY
          L9_2 = L7_2
          L10_2 = 1
          L11_2 = L25_1
          L12_2 = L26_1
          L13_2 = L27_1
          L14_2 = 0
          L15_2 = 0
          L16_2 = 0
          L17_2 = 0
          L18_2 = false
          L19_2 = true
          L20_2 = true
          L21_2 = false
          L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
        end
      end
    end
  end
end
L28_1[L29_1] = L30_1
L28_1 = _ENV
L29_1 = "lochness_mk2"
function L30_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2
  L0_2 = ENTITY
  L0_2 = L0_2.GET_ENTITY_COORDS
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
  L1_2 = MISC
  L1_2 = L1_2.GET_HASH_KEY
  L2_2 = "h4_prop_h4_loch_monster"
  L1_2 = L1_2(L2_2)
  L2_2 = MISC
  L2_2 = L2_2.GET_HASH_KEY
  L3_2 = "oppressor2"
  L2_2 = L2_2(L3_2)
  L3_2 = create_object
  L4_2 = L1_2
  L5_2 = L0_2.x
  L6_2 = L0_2.y
  L7_2 = L0_2.z
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
  L4_2 = create_vehicle
  L5_2 = L2_2
  L6_2 = L0_2.x
  L7_2 = L0_2.y
  L8_2 = L0_2.z
  L9_2 = 0
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L5_2 = PED
  L5_2 = L5_2.SET_PED_INTO_VEHICLE
  L6_2 = PLAYER
  L6_2 = L6_2.PLAYER_PED_ID
  L6_2 = L6_2()
  L7_2 = L4_2
  L8_2 = -1
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = ENTITY
  L5_2 = L5_2.ATTACH_ENTITY_TO_ENTITY
  L6_2 = L3_2
  L7_2 = L4_2
  L8_2 = 0
  L9_2 = -0.25
  L10_2 = -1.0
  L11_2 = 1.0
  L12_2 = 0.0
  L13_2 = 0.0
  L14_2 = -90.0
  L15_2 = true
  L16_2 = false
  L17_2 = false
  L18_2 = false
  L19_2 = 0
  L20_2 = true
  L21_2 = 0
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
end
L28_1[L29_1] = L30_1
L28_1 = 1
L29_1 = _ENV
L30_1 = "no_clip_speed"
function L31_1(A0_2)
  local L1_2
  L28_1 = A0_2
end
L29_1[L30_1] = L31_1
L29_1 = _ENV
L30_1 = "no_clip"
function L31_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  no_clipd = A0_2
  L1_2 = no_clipd
  if L1_2 then
    while true do
      L1_2 = no_clipd
      if not L1_2 then
        break
      end
      L1_2 = PED
      L1_2 = L1_2.IS_PED_IN_ANY_VEHICLE
      L2_2 = PLAYER
      L2_2 = L2_2.PLAYER_PED_ID
      L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L2_2()
      L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
      if L1_2 then
        L1_2 = PED
        L1_2 = L1_2.GET_VEHICLE_PED_IS_IN
        L2_2 = PLAYER
        L2_2 = L2_2.PLAYER_PED_ID
        L2_2 = L2_2()
        L3_2 = false
        L1_2 = L1_2(L2_2, L3_2)
        if 0 ~= L1_2 then
          L2_2 = ENTITY
          L2_2 = L2_2.FREEZE_ENTITY_POSITION
          L3_2 = L1_2
          L4_2 = true
          L2_2(L3_2, L4_2)
          L2_2 = ENTITY
          L2_2 = L2_2.SET_ENTITY_COLLISION
          L3_2 = L1_2
          L4_2 = false
          L5_2 = false
          L2_2(L3_2, L4_2, L5_2)
          L2_2 = CAM
          L2_2 = L2_2.GET_GAMEPLAY_CAM_ROT
          L3_2 = 5
          L2_2 = L2_2(L3_2)
          L3_2 = ENTITY
          L3_2 = L3_2.SET_ENTITY_ROTATION
          L4_2 = L1_2
          L5_2 = L2_2.x
          L6_2 = L2_2.y
          L7_2 = L2_2.z
          L8_2 = 5
          L9_2 = true
          L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
          L3_2 = util
          L3_2 = L3_2.is_key_down
          L4_2 = 87
          L3_2 = L3_2(L4_2)
          if L3_2 then
            L3_2 = ENTITY
            L3_2 = L3_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
            L4_2 = L1_2
            L5_2 = 0
            L6_2 = L28_1
            L6_2 = 1 * L6_2
            L7_2 = 0
            L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
            L4_2 = ENTITY
            L4_2 = L4_2.SET_ENTITY_COORDS_NO_OFFSET
            L5_2 = L1_2
            L6_2 = L3_2.x
            L7_2 = L3_2.y
            L8_2 = L3_2.z
            L9_2 = false
            L10_2 = false
            L11_2 = false
            L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
          else
            L3_2 = util
            L3_2 = L3_2.is_key_down
            L4_2 = 83
            L3_2 = L3_2(L4_2)
            if L3_2 then
              L3_2 = ENTITY
              L3_2 = L3_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
              L4_2 = L1_2
              L5_2 = 0
              L6_2 = L28_1
              L6_2 = -1 * L6_2
              L7_2 = 0
              L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
              L4_2 = ENTITY
              L4_2 = L4_2.SET_ENTITY_COORDS_NO_OFFSET
              L5_2 = L1_2
              L6_2 = L3_2.x
              L7_2 = L3_2.y
              L8_2 = L3_2.z
              L9_2 = false
              L10_2 = false
              L11_2 = false
              L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
            end
          end
          L3_2 = util
          L3_2 = L3_2.is_key_down
          L4_2 = 65
          L3_2 = L3_2(L4_2)
          if L3_2 then
            L3_2 = ENTITY
            L3_2 = L3_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
            L4_2 = L1_2
            L5_2 = L28_1
            L5_2 = -1 * L5_2
            L6_2 = 0
            L7_2 = 0
            L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
            L4_2 = ENTITY
            L4_2 = L4_2.SET_ENTITY_COORDS_NO_OFFSET
            L5_2 = L1_2
            L6_2 = L3_2.x
            L7_2 = L3_2.y
            L8_2 = L3_2.z
            L9_2 = false
            L10_2 = false
            L11_2 = false
            L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
          else
            L3_2 = util
            L3_2 = L3_2.is_key_down
            L4_2 = 68
            L3_2 = L3_2(L4_2)
            if L3_2 then
              L3_2 = ENTITY
              L3_2 = L3_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
              L4_2 = L1_2
              L5_2 = L28_1
              L5_2 = 1 * L5_2
              L6_2 = 0
              L7_2 = 0
              L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
              L4_2 = ENTITY
              L4_2 = L4_2.SET_ENTITY_COORDS_NO_OFFSET
              L5_2 = L1_2
              L6_2 = L3_2.x
              L7_2 = L3_2.y
              L8_2 = L3_2.z
              L9_2 = false
              L10_2 = false
              L11_2 = false
              L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
            end
          end
          L3_2 = util
          L3_2 = L3_2.is_key_down
          L4_2 = 16
          L3_2 = L3_2(L4_2)
          if L3_2 then
            L3_2 = ENTITY
            L3_2 = L3_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
            L4_2 = L1_2
            L5_2 = 0
            L6_2 = 0
            L7_2 = L28_1
            L7_2 = 1 * L7_2
            L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
            L4_2 = ENTITY
            L4_2 = L4_2.SET_ENTITY_COORDS_NO_OFFSET
            L5_2 = L1_2
            L6_2 = L3_2.x
            L7_2 = L3_2.y
            L8_2 = L3_2.z
            L9_2 = false
            L10_2 = false
            L11_2 = false
            L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
          end
          L3_2 = util
          L3_2 = L3_2.is_key_down
          L4_2 = 17
          L3_2 = L3_2(L4_2)
          if L3_2 then
            L3_2 = ENTITY
            L3_2 = L3_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
            L4_2 = L1_2
            L5_2 = 0
            L6_2 = 0
            L7_2 = L28_1
            L7_2 = -1 * L7_2
            L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
            L4_2 = ENTITY
            L4_2 = L4_2.SET_ENTITY_COORDS_NO_OFFSET
            L5_2 = L1_2
            L6_2 = L3_2.x
            L7_2 = L3_2.y
            L8_2 = L3_2.z
            L9_2 = false
            L10_2 = false
            L11_2 = false
            L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
          end
        end
      else
        L1_2 = PLAYER
        L1_2 = L1_2.PLAYER_PED_ID
        L1_2 = L1_2()
        L2_2 = ENTITY
        L2_2 = L2_2.FREEZE_ENTITY_POSITION
        L3_2 = L1_2
        L4_2 = true
        L2_2(L3_2, L4_2)
        L2_2 = ENTITY
        L2_2 = L2_2.SET_ENTITY_COLLISION
        L3_2 = L1_2
        L4_2 = false
        L5_2 = false
        L2_2(L3_2, L4_2, L5_2)
        L2_2 = CAM
        L2_2 = L2_2.GET_GAMEPLAY_CAM_ROT
        L3_2 = 5
        L2_2 = L2_2(L3_2)
        L3_2 = ENTITY
        L3_2 = L3_2.SET_ENTITY_ROTATION
        L4_2 = L1_2
        L5_2 = L2_2.x
        L6_2 = L2_2.y
        L7_2 = L2_2.z
        L8_2 = 5
        L9_2 = true
        L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
        L3_2 = util
        L3_2 = L3_2.is_key_down
        L4_2 = 87
        L3_2 = L3_2(L4_2)
        if L3_2 then
          L3_2 = ENTITY
          L3_2 = L3_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
          L4_2 = L1_2
          L5_2 = 0
          L6_2 = L28_1
          L6_2 = 1 * L6_2
          L7_2 = 0
          L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
          L4_2 = ENTITY
          L4_2 = L4_2.SET_ENTITY_COORDS_NO_OFFSET
          L5_2 = L1_2
          L6_2 = L3_2.x
          L7_2 = L3_2.y
          L8_2 = L3_2.z
          L9_2 = false
          L10_2 = false
          L11_2 = false
          L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
        else
          L3_2 = util
          L3_2 = L3_2.is_key_down
          L4_2 = 83
          L3_2 = L3_2(L4_2)
          if L3_2 then
            L3_2 = ENTITY
            L3_2 = L3_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
            L4_2 = L1_2
            L5_2 = 0
            L6_2 = L28_1
            L6_2 = -1 * L6_2
            L7_2 = 0
            L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
            L4_2 = ENTITY
            L4_2 = L4_2.SET_ENTITY_COORDS_NO_OFFSET
            L5_2 = L1_2
            L6_2 = L3_2.x
            L7_2 = L3_2.y
            L8_2 = L3_2.z
            L9_2 = false
            L10_2 = false
            L11_2 = false
            L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
          end
        end
        L3_2 = util
        L3_2 = L3_2.is_key_down
        L4_2 = 65
        L3_2 = L3_2(L4_2)
        if L3_2 then
          L3_2 = ENTITY
          L3_2 = L3_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
          L4_2 = L1_2
          L5_2 = L28_1
          L5_2 = -1 * L5_2
          L6_2 = 0
          L7_2 = 0
          L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
          L4_2 = ENTITY
          L4_2 = L4_2.SET_ENTITY_COORDS_NO_OFFSET
          L5_2 = L1_2
          L6_2 = L3_2.x
          L7_2 = L3_2.y
          L8_2 = L3_2.z
          L9_2 = false
          L10_2 = false
          L11_2 = false
          L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
        else
          L3_2 = util
          L3_2 = L3_2.is_key_down
          L4_2 = 68
          L3_2 = L3_2(L4_2)
          if L3_2 then
            L3_2 = ENTITY
            L3_2 = L3_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
            L4_2 = L1_2
            L5_2 = L28_1
            L5_2 = 1 * L5_2
            L6_2 = 0
            L7_2 = 0
            L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
            L4_2 = ENTITY
            L4_2 = L4_2.SET_ENTITY_COORDS_NO_OFFSET
            L5_2 = L1_2
            L6_2 = L3_2.x
            L7_2 = L3_2.y
            L8_2 = L3_2.z
            L9_2 = false
            L10_2 = false
            L11_2 = false
            L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
          end
        end
        L3_2 = util
        L3_2 = L3_2.is_key_down
        L4_2 = 16
        L3_2 = L3_2(L4_2)
        if L3_2 then
          L3_2 = ENTITY
          L3_2 = L3_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
          L4_2 = L1_2
          L5_2 = 0
          L6_2 = 0
          L7_2 = L28_1
          L7_2 = 1 * L7_2
          L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
          L4_2 = ENTITY
          L4_2 = L4_2.SET_ENTITY_COORDS_NO_OFFSET
          L5_2 = L1_2
          L6_2 = L3_2.x
          L7_2 = L3_2.y
          L8_2 = L3_2.z
          L9_2 = false
          L10_2 = false
          L11_2 = false
          L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
        end
        L3_2 = util
        L3_2 = L3_2.is_key_down
        L4_2 = 17
        L3_2 = L3_2(L4_2)
        if L3_2 then
          L3_2 = ENTITY
          L3_2 = L3_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
          L4_2 = L1_2
          L5_2 = 0
          L6_2 = 0
          L7_2 = L28_1
          L7_2 = -1 * L7_2
          L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
          L4_2 = ENTITY
          L4_2 = L4_2.SET_ENTITY_COORDS_NO_OFFSET
          L5_2 = L1_2
          L6_2 = L3_2.x
          L7_2 = L3_2.y
          L8_2 = L3_2.z
          L9_2 = false
          L10_2 = false
          L11_2 = false
          L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
        end
      end
      L1_2 = util
      L1_2 = L1_2.yield
      L1_2()
    end
  else
    L1_2 = PED
    L1_2 = L1_2.IS_PED_IN_ANY_VEHICLE
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L2_2()
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    if L1_2 then
      L1_2 = PED
      L1_2 = L1_2.GET_VEHICLE_PED_IS_IN
      L2_2 = PLAYER
      L2_2 = L2_2.PLAYER_PED_ID
      L2_2 = L2_2()
      L3_2 = false
      L1_2 = L1_2(L2_2, L3_2)
      if 0 ~= L1_2 then
        L2_2 = ENTITY
        L2_2 = L2_2.FREEZE_ENTITY_POSITION
        L3_2 = L1_2
        L4_2 = false
        L2_2(L3_2, L4_2)
        L2_2 = ENTITY
        L2_2 = L2_2.SET_ENTITY_COLLISION
        L3_2 = L1_2
        L4_2 = true
        L5_2 = true
        L2_2(L3_2, L4_2, L5_2)
      end
    else
      L1_2 = PLAYER
      L1_2 = L1_2.PLAYER_PED_ID
      L1_2 = L1_2()
      L2_2 = ENTITY
      L2_2 = L2_2.FREEZE_ENTITY_POSITION
      L3_2 = L1_2
      L4_2 = false
      L2_2(L3_2, L4_2)
      L2_2 = ENTITY
      L2_2 = L2_2.SET_ENTITY_COLLISION
      L3_2 = L1_2
      L4_2 = true
      L5_2 = true
      L2_2(L3_2, L4_2, L5_2)
      L2_2 = TASK
      L2_2 = L2_2.CLEAR_PED_TASKS_IMMEDIATELY
      L3_2 = L1_2
      L2_2(L3_2)
    end
  end
end
L29_1[L30_1] = L31_1
L29_1 = _ENV
L30_1 = "do_ped_suicide"
function L31_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L1_2 = request_control_of_entity_once
  L2_2 = A0_2
  L1_2(L2_2)
  L1_2 = TASK
  L1_2 = L1_2.CLEAR_PED_TASKS_IMMEDIATELY
  L2_2 = A0_2
  L1_2(L2_2)
  L1_2 = PED
  L1_2 = L1_2.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS
  L2_2 = A0_2
  L3_2 = true
  L1_2(L2_2, L3_2)
  L1_2 = WEAPON
  L1_2 = L1_2.GIVE_WEAPON_TO_PED
  L2_2 = A0_2
  L3_2 = util
  L3_2 = L3_2.joaat
  L4_2 = "weapon_pistol"
  L3_2 = L3_2(L4_2)
  L4_2 = 1
  L5_2 = false
  L6_2 = true
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
  L1_2 = WEAPON
  L1_2 = L1_2.SET_CURRENT_PED_WEAPON
  L2_2 = A0_2
  L3_2 = util
  L3_2 = L3_2.joaat
  L4_2 = "weapon_pistol"
  L3_2 = L3_2(L4_2)
  L4_2 = true
  L1_2(L2_2, L3_2, L4_2)
  L1_2 = request_anim_dict
  L2_2 = "mp_suicide"
  L1_2(L2_2)
  L1_2 = util
  L1_2 = L1_2.yield
  L2_2 = 1000
  L1_2(L2_2)
  L1_2 = os
  L1_2 = L1_2.time
  L1_2 = L1_2()
  while true do
    L2_2 = ENTITY
    L2_2 = L2_2.GET_ENTITY_SPEED
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    if not (L2_2 > 1) then
      break
    end
    L2_2 = os
    L2_2 = L2_2.time
    L2_2 = L2_2()
    L2_2 = L2_2 - L1_2
    if not (L2_2 < 3) then
      break
    end
    L2_2 = util
    L2_2 = L2_2.yield
    L2_2()
  end
  L2_2 = TASK
  L2_2 = L2_2.TASK_PLAY_ANIM
  L3_2 = A0_2
  L4_2 = "mp_suicide"
  L5_2 = "pistol"
  L6_2 = 8.0
  L7_2 = 8.0
  L8_2 = -1
  L9_2 = 2
  L10_2 = 0.0
  L11_2 = false
  L12_2 = false
  L13_2 = false
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L2_2 = util
  L2_2 = L2_2.yield
  L3_2 = 800
  L2_2(L3_2)
  L2_2 = ENTITY
  L2_2 = L2_2.SET_ENTITY_HEALTH
  L3_2 = A0_2
  L4_2 = 0.0
  L5_2 = 0
  L2_2(L3_2, L4_2, L5_2)
  L2_2 = util
  L2_2 = L2_2.yield
  L3_2 = 10000
  L2_2(L3_2)
  L2_2 = delete_entity
  L3_2 = A0_2
  L2_2(L3_2)
end
L29_1[L30_1] = L31_1
L29_1 = _ENV
L30_1 = "npc_suicide"
function L31_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
  L3_2 = A1_2
  L2_2 = L2_2(L3_2)
  L3_2 = ENTITY
  L3_2 = L3_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L4_2 = L2_2
  L5_2 = 0.0
  L6_2 = 1.0
  L7_2 = 0.0
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
  L4_2 = 0
  if 1 == A0_2 then
    L5_2 = PED
    L5_2 = L5_2.CLONE_PED
    L6_2 = L2_2
    L7_2 = true
    L8_2 = false
    L9_2 = true
    L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
    L4_2 = L5_2
    L5_2 = ENTITY
    L5_2 = L5_2.SET_ENTITY_COORDS
    L6_2 = L4_2
    L7_2 = L3_2.x
    L8_2 = L3_2.y
    L9_2 = L3_2.z
    L5_2(L6_2, L7_2, L8_2, L9_2)
    L5_2 = ENTITY
    L5_2 = L5_2.SET_ENTITY_HEADING
    L6_2 = L4_2
    L7_2 = ENTITY
    L7_2 = L7_2.GET_ENTITY_HEADING
    L8_2 = L2_2
    L7_2 = L7_2(L8_2)
    L7_2 = L7_2 + 180
    L5_2(L6_2, L7_2)
  else
    L5_2 = traumatize_option_hashes
    L5_2 = L5_2[A0_2]
    L6_2 = request_model
    L7_2 = L5_2
    L6_2(L7_2)
    L6_2 = entities
    L6_2 = L6_2.create_ped
    L7_2 = 3
    L8_2 = L5_2
    L9_2 = L3_2
    L10_2 = ENTITY
    L10_2 = L10_2.GET_ENTITY_HEADING
    L11_2 = L2_2
    L10_2 = L10_2(L11_2)
    L10_2 = L10_2 + 180
    L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
    L4_2 = L6_2
  end
  L5_2 = do_ped_suicide
  L6_2 = L4_2
  L5_2(L6_2)
end
L29_1[L30_1] = L31_1
L29_1 = "vigilante"
L30_1 = _ENV
L31_1 = "create_attach_ent"
function L32_1(A0_2, A1_2, A2_2, A3_2, A4_2)
  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2
  L5_2 = STREAMING
  L5_2 = L5_2.IS_MODEL_A_PED
  L6_2 = A0_2
  L5_2 = L5_2(L6_2)
  if L5_2 then
    L5_2 = create_ped
    L6_2 = 1
    L7_2 = A0_2
    L8_2 = A1_2
    L9_2 = A2_2
    L10_2 = A3_2 + 20
    L11_2 = ENTITY
    L11_2 = L11_2.GET_ENTITY_HEADING
    L12_2 = A4_2
    L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L11_2(L12_2)
    L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
    L6_2 = calm_ped
    L7_2 = L5_2
    L8_2 = true
    L6_2(L7_2, L8_2)
    L6_2 = ENTITY
    L6_2 = L6_2.ATTACH_ENTITY_TO_ENTITY
    L7_2 = L5_2
    L8_2 = A4_2
    L9_2 = 0
    L10_2 = 0
    L11_2 = 0
    L12_2 = 0
    L13_2 = 0
    L14_2 = 0
    L15_2 = 0
    L16_2 = true
    L17_2 = false
    L18_2 = false
    L19_2 = true
    L20_2 = 0
    L21_2 = true
    L22_2 = 0
    L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
  else
    L5_2 = STREAMING
    L5_2 = L5_2.IS_MODEL_A_VEHICLE
    L6_2 = A0_2
    L5_2 = L5_2(L6_2)
    if L5_2 then
      L5_2 = create_vehicle
      L6_2 = A0_2
      L7_2 = A1_2
      L8_2 = A2_2
      L9_2 = A3_2 + 20
      L10_2 = ENTITY
      L10_2 = L10_2.GET_ENTITY_HEADING
      L11_2 = A4_2
      L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L10_2(L11_2)
      L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
      L6_2 = ENTITY
      L6_2 = L6_2.ATTACH_ENTITY_TO_ENTITY
      L7_2 = L5_2
      L8_2 = A4_2
      L9_2 = 0
      L10_2 = 0
      L11_2 = 0
      L12_2 = 0
      L13_2 = 0
      L14_2 = 0
      L15_2 = 0
      L16_2 = true
      L17_2 = false
      L18_2 = false
      L19_2 = true
      L20_2 = 0
      L21_2 = true
      L22_2 = 0
      L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
    else
      L5_2 = STREAMING
      L5_2 = L5_2.IS_MODEL_VALID
      L6_2 = A0_2
      L5_2 = L5_2(L6_2)
      if L5_2 then
        L5_2 = create_object
        L6_2 = A0_2
        L7_2 = A1_2
        L8_2 = A2_2
        L9_2 = A3_2 + 20
        L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
        L6_2 = ENTITY
        L6_2 = L6_2.ATTACH_ENTITY_TO_ENTITY
        L7_2 = L5_2
        L8_2 = A4_2
        L9_2 = 0
        L10_2 = 0
        L11_2 = 0
        L12_2 = 0
        L13_2 = 0
        L14_2 = 0
        L15_2 = 0
        L16_2 = true
        L17_2 = false
        L18_2 = false
        L19_2 = true
        L20_2 = 0
        L21_2 = true
        L22_2 = 0
        L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
      end
    end
  end
end
L30_1[L31_1] = L32_1
L30_1 = _ENV
L31_1 = "selete_attach_entity_gun"
function L32_1(A0_2)
  local L1_2
  L1_2 = Objl
  L1_2 = L1_2[A0_2]
  L29_1 = L1_2
end
L30_1[L31_1] = L32_1
L30_1 = _ENV
L31_1 = "attach_entity_gun"
function L32_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = v3
  L0_2 = L0_2.new
  L0_2 = L0_2()
  L1_2 = memory
  L1_2 = L1_2.alloc
  L2_2 = 8
  L1_2 = L1_2(L2_2)
  L2_2 = WEAPON
  L2_2 = L2_2.GET_PED_LAST_WEAPON_IMPACT_COORD
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2 = L3_2()
  L4_2 = L0_2
  L2_2 = L2_2(L3_2, L4_2)
  if L2_2 then
    L2_2 = PLAYER
    L2_2 = L2_2.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_ID
    L3_2 = L3_2()
    L4_2 = L1_2
    L2_2 = L2_2(L3_2, L4_2)
    if L2_2 then
      L2_2 = memory
      L2_2 = L2_2.read_int
      L3_2 = L1_2
      L2_2 = L2_2(L3_2)
      L3_2 = STREAMING
      L3_2 = L3_2.IS_MODEL_A_PED
      L4_2 = ENTITY
      L4_2 = L4_2.GET_ENTITY_MODEL
      L5_2 = L2_2
      L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L4_2(L5_2)
      L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
      if L3_2 then
        L3_2 = PED
        L3_2 = L3_2.IS_PED_IN_ANY_VEHICLE
        L4_2 = L2_2
        L3_2 = L3_2(L4_2)
        if L3_2 then
          L3_2 = PED
          L3_2 = L3_2.GET_VEHICLE_PED_IS_IN
          L4_2 = L2_2
          L5_2 = false
          L3_2 = L3_2(L4_2, L5_2)
          L2_2 = L3_2
        end
      end
      L3_2 = MISC
      L3_2 = L3_2.GET_HASH_KEY
      L4_2 = L29_1
      L3_2 = L3_2(L4_2)
      L4_2 = create_attach_ent
      L5_2 = L3_2
      L6_2 = L0_2.x
      L7_2 = L0_2.y
      L8_2 = L0_2.z
      L9_2 = L2_2
      L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
    end
  end
end
L30_1[L31_1] = L32_1
L30_1 = _ENV
L31_1 = "targeted_strike"
function L32_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L0_2 = HUD
  L0_2 = L0_2.IS_WAYPOINT_ACTIVE
  L0_2 = L0_2()
  if L0_2 then
    L0_2 = HUD
    L0_2 = L0_2.GET_BLIP_INFO_ID_COORD
    L1_2 = HUD
    L1_2 = L1_2.GET_FIRST_BLIP_INFO_ID
    L2_2 = HUD
    L2_2 = L2_2.GET_WAYPOINT_BLIP_ENUM_ID
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2 = L2_2()
    L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    L1_2 = 1
    L2_2 = 30
    L3_2 = 1
    for L4_2 = L1_2, L2_2, L3_2 do
      L5_2 = SE_add_owned_explosion
      L6_2 = PLAYER
      L6_2 = L6_2.PLAYER_PED_ID
      L6_2 = L6_2()
      L7_2 = L0_2.x
      L8_2 = L0_2.y
      L9_2 = L0_2.z
      L9_2 = L9_2 + 30
      L9_2 = L9_2 - L4_2
      L10_2 = 29
      L11_2 = 10
      L12_2 = true
      L13_2 = false
      L14_2 = 1
      L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
      L5_2 = FIRE
      L5_2 = L5_2.ADD_EXPLOSION
      L6_2 = L0_2.x
      L7_2 = L0_2.y
      L8_2 = L0_2.z
      L8_2 = L8_2 + 30
      L8_2 = L8_2 - L4_2
      L9_2 = 29
      L10_2 = 10
      L11_2 = true
      L12_2 = false
      L13_2 = 0
      L14_2 = false
      L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
      L5_2 = FIRE
      L5_2 = L5_2.ADD_EXPLOSION
      L6_2 = L0_2.x
      L7_2 = L0_2.y
      L8_2 = L0_2.z
      L8_2 = L8_2 + 30
      L8_2 = L8_2 - L4_2
      L9_2 = 59
      L10_2 = 10
      L11_2 = true
      L12_2 = false
      L13_2 = 0
      L14_2 = false
      L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
      L5_2 = util
      L5_2 = L5_2.yield
      L6_2 = 30
      L5_2(L6_2)
    end
  end
end
L30_1[L31_1] = L32_1
L30_1 = _ENV
L31_1 = "executeNuke"
function L32_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L1_2 = 0
  L2_2 = 100
  L3_2 = 4
  for L4_2 = L1_2, L2_2, L3_2 do
    L5_2 = FIRE
    L5_2 = L5_2.ADD_EXPLOSION
    L6_2 = A0_2.x
    L7_2 = A0_2.y
    L8_2 = A0_2.z
    L8_2 = L8_2 + L4_2
    L9_2 = 8
    L10_2 = 10.0
    L11_2 = true
    L12_2 = false
    L13_2 = 1.0
    L14_2 = false
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    L5_2 = util
    L5_2 = L5_2.yield
    L6_2 = 50
    L5_2(L6_2)
  end
  L1_2 = FIRE
  L1_2 = L1_2.ADD_EXPLOSION
  L2_2 = A0_2.x
  L3_2 = A0_2.y
  L4_2 = A0_2.z
  L5_2 = 82
  L6_2 = 10.0
  L7_2 = true
  L8_2 = false
  L9_2 = 1.0
  L10_2 = false
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L1_2 = FIRE
  L1_2 = L1_2.ADD_EXPLOSION
  L2_2 = A0_2.x
  L3_2 = A0_2.y
  L4_2 = A0_2.z
  L5_2 = 82
  L6_2 = 10.0
  L7_2 = true
  L8_2 = false
  L9_2 = 1.0
  L10_2 = false
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L1_2 = FIRE
  L1_2 = L1_2.ADD_EXPLOSION
  L2_2 = A0_2.x
  L3_2 = A0_2.y
  L4_2 = A0_2.z
  L5_2 = 82
  L6_2 = 10.0
  L7_2 = true
  L8_2 = false
  L9_2 = 1.0
  L10_2 = false
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L1_2 = FIRE
  L1_2 = L1_2.ADD_EXPLOSION
  L2_2 = A0_2.x
  L3_2 = A0_2.y
  L4_2 = A0_2.z
  L5_2 = 82
  L6_2 = 10.0
  L7_2 = true
  L8_2 = false
  L9_2 = 1.0
  L10_2 = false
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
end
L30_1[L31_1] = L32_1
L30_1 = _ENV
L31_1 = "targeted_loop_strike"
function L32_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L0_2 = HUD
  L0_2 = L0_2.GET_BLIP_INFO_ID_COORD
  L1_2 = HUD
  L1_2 = L1_2.GET_FIRST_BLIP_INFO_ID
  L2_2 = HUD
  L2_2 = L2_2.GET_WAYPOINT_BLIP_ENUM_ID
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2()
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  if L0_2 then
    L1_2 = util
    L1_2 = L1_2.joaat
    L2_2 = "w_arena_airmissile_01a"
    L1_2 = L1_2(L2_2)
    L2_2 = request_model
    L3_2 = L1_2
    L2_2(L3_2)
    L2_2 = L0_2.z
    L2_2 = L2_2 + 30
    L0_2.z = L2_2
    L2_2 = entities
    L2_2 = L2_2.create_object
    L3_2 = L1_2
    L4_2 = L0_2
    L2_2 = L2_2(L3_2, L4_2)
    L3_2 = L0_2.z
    L3_2 = L3_2 - 30
    L0_2.z = L3_2
    L3_2 = ENTITY
    L3_2 = L3_2.SET_ENTITY_ROTATION
    L4_2 = L2_2
    L5_2 = -90
    L6_2 = 0
    L7_2 = 0
    L8_2 = 2
    L9_2 = true
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    L3_2 = ENTITY
    L3_2 = L3_2.APPLY_FORCE_TO_ENTITY
    L4_2 = L2_2
    L5_2 = 0
    L6_2 = 0
    L7_2 = 0
    L8_2 = 0
    L9_2 = 0.0
    L10_2 = 0.0
    L11_2 = 0.0
    L12_2 = 0
    L13_2 = true
    L14_2 = false
    L15_2 = true
    L16_2 = false
    L17_2 = true
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
    L3_2 = STREAMING
    L3_2 = L3_2.SET_MODEL_AS_NO_LONGER_NEEDED
    L4_2 = L1_2
    L3_2(L4_2)
    while true do
      L3_2 = ENTITY
      L3_2 = L3_2.HAS_ENTITY_COLLIDED_WITH_ANYTHING
      L4_2 = L2_2
      L3_2 = L3_2(L4_2)
      if L3_2 then
        break
      end
      L3_2 = util
      L3_2 = L3_2.yield_once
      L3_2()
    end
    L3_2 = delete_entity
    L4_2 = L2_2
    L3_2(L4_2)
    L3_2 = executeNuke
    L4_2 = L0_2
    L3_2(L4_2)
  end
end
L30_1[L31_1] = L32_1
L30_1 = _ENV
L31_1 = "pilot_lamp"
function L32_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = PED
  L0_2 = L0_2.IS_PED_IN_ANY_VEHICLE
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = false
  L0_2 = L0_2(L1_2, L2_2)
  if L0_2 then
    L0_2 = show_button
    L0_2()
    L0_2 = sf
    L0_2 = L0_2.SET_DATA_SLOT
    L1_2 = 0
    L2_2 = PAD
    L2_2 = L2_2.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING
    L3_2 = 0
    L4_2 = 35
    L5_2 = true
    L2_2 = L2_2(L3_2, L4_2, L5_2)
    L3_2 = "右转灯"
    L0_2(L1_2, L2_2, L3_2)
    L0_2 = sf
    L0_2 = L0_2.SET_DATA_SLOT
    L1_2 = 1
    L2_2 = PAD
    L2_2 = L2_2.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING
    L3_2 = 0
    L4_2 = 130
    L5_2 = true
    L2_2 = L2_2(L3_2, L4_2, L5_2)
    L3_2 = "双闪灯"
    L0_2(L1_2, L2_2, L3_2)
    L0_2 = sf
    L0_2 = L0_2.SET_DATA_SLOT
    L1_2 = 2
    L2_2 = PAD
    L2_2 = L2_2.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING
    L3_2 = 0
    L4_2 = 34
    L5_2 = true
    L2_2 = L2_2(L3_2, L4_2, L5_2)
    L3_2 = "左转灯"
    L0_2(L1_2, L2_2, L3_2)
    L0_2 = show_button2
    L0_2()
    L0_2 = PED
    L0_2 = L0_2.GET_VEHICLE_PED_IS_IN
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_PED_ID
    L1_2 = L1_2()
    L2_2 = false
    L0_2 = L0_2(L1_2, L2_2)
    L1_2 = PAD
    L1_2 = L1_2.IS_CONTROL_PRESSED
    L2_2 = 0
    L3_2 = 34
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = PAD
    L2_2 = L2_2.IS_CONTROL_PRESSED
    L3_2 = 0
    L4_2 = 35
    L2_2 = L2_2(L3_2, L4_2)
    L3_2 = PAD
    L3_2 = L3_2.IS_CONTROL_PRESSED
    L4_2 = 0
    L5_2 = 130
    L3_2 = L3_2(L4_2, L5_2)
    if L1_2 and not L2_2 and not L3_2 then
      L4_2 = VEHICLE
      L4_2 = L4_2.SET_VEHICLE_INDICATOR_LIGHTS
      L5_2 = L0_2
      L6_2 = 1
      L7_2 = true
      L4_2(L5_2, L6_2, L7_2)
    elseif L2_2 and not L1_2 and not L3_2 then
      L4_2 = VEHICLE
      L4_2 = L4_2.SET_VEHICLE_INDICATOR_LIGHTS
      L5_2 = L0_2
      L6_2 = 0
      L7_2 = true
      L4_2(L5_2, L6_2, L7_2)
    elseif L3_2 and not L1_2 and not L2_2 then
      L4_2 = VEHICLE
      L4_2 = L4_2.SET_VEHICLE_INDICATOR_LIGHTS
      L5_2 = L0_2
      L6_2 = 1
      L7_2 = true
      L4_2(L5_2, L6_2, L7_2)
      L4_2 = VEHICLE
      L4_2 = L4_2.SET_VEHICLE_INDICATOR_LIGHTS
      L5_2 = L0_2
      L6_2 = 0
      L7_2 = true
      L4_2(L5_2, L6_2, L7_2)
    else
      L4_2 = VEHICLE
      L4_2 = L4_2.SET_VEHICLE_INDICATOR_LIGHTS
      L5_2 = L0_2
      L6_2 = 0
      L7_2 = false
      L4_2(L5_2, L6_2, L7_2)
      L4_2 = VEHICLE
      L4_2 = L4_2.SET_VEHICLE_INDICATOR_LIGHTS
      L5_2 = L0_2
      L6_2 = 1
      L7_2 = false
      L4_2(L5_2, L6_2, L7_2)
    end
  end
end
L30_1[L31_1] = L32_1
L30_1 = _ENV
L31_1 = "vehicle_attach"
function L32_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2
  L2_2 = PED
  L2_2 = L2_2.GET_VEHICLE_PED_IS_IN
  L3_2 = PLAYER
  L3_2 = L3_2.GET_PLAYER_PED_SCRIPT_INDEX
  L4_2 = A1_2
  L3_2 = L3_2(L4_2)
  L4_2 = true
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = entities
  L3_2 = L3_2.get_user_vehicle_as_handle
  L3_2 = L3_2()
  if 0 ~= L2_2 then
    L4_2 = request_control
    L5_2 = L2_2
    L4_2(L5_2)
    if 1 == A0_2 then
      L4_2 = ENTITY
      L4_2 = L4_2.ATTACH_ENTITY_TO_ENTITY
      L5_2 = PLAYER
      L5_2 = L5_2.PLAYER_PED_ID
      L5_2 = L5_2()
      L6_2 = L2_2
      L7_2 = 0
      L8_2 = 0.0
      L9_2 = -0.2
      L10_2 = 2.0
      L11_2 = 1.0
      L12_2 = 1.0
      L13_2 = 1
      L14_2 = true
      L15_2 = true
      L16_2 = true
      L17_2 = false
      L18_2 = 0
      L19_2 = true
      L20_2 = 0
      L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
    elseif 2 == A0_2 then
      if 0 ~= L3_2 and L2_2 ~= L3_2 then
        L4_2 = ENTITY
        L4_2 = L4_2.ATTACH_ENTITY_TO_ENTITY
        L5_2 = L2_2
        L6_2 = L3_2
        L7_2 = 0
        L8_2 = 0.0
        L9_2 = -5.0
        L10_2 = 0.0
        L11_2 = 1.0
        L12_2 = 1.0
        L13_2 = 1
        L14_2 = true
        L15_2 = true
        L16_2 = true
        L17_2 = false
        L18_2 = 0
        L19_2 = true
        L20_2 = 0
        L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
      end
    elseif 3 == A0_2 then
      if 0 ~= L3_2 and L2_2 ~= L3_2 then
        L4_2 = ENTITY
        L4_2 = L4_2.ATTACH_ENTITY_TO_ENTITY
        L5_2 = L3_2
        L6_2 = L2_2
        L7_2 = 0
        L8_2 = 0.0
        L9_2 = -5.0
        L10_2 = 0.0
        L11_2 = 1.0
        L12_2 = 1.0
        L13_2 = 1
        L14_2 = true
        L15_2 = true
        L16_2 = true
        L17_2 = false
        L18_2 = 0
        L19_2 = true
        L20_2 = 0
        L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
      end
    elseif 4 == A0_2 then
      L4_2 = ENTITY
      L4_2 = L4_2.DETACH_ENTITY
      L5_2 = L2_2
      L6_2 = false
      L7_2 = false
      L4_2(L5_2, L6_2, L7_2)
      if 0 ~= L3_2 then
        L4_2 = ENTITY
        L4_2 = L4_2.DETACH_ENTITY
        L5_2 = L3_2
        L6_2 = false
        L7_2 = false
        L4_2(L5_2, L6_2, L7_2)
      end
      L4_2 = ENTITY
      L4_2 = L4_2.DETACH_ENTITY
      L5_2 = PLAYER
      L5_2 = L5_2.PLAYER_PED_ID
      L5_2 = L5_2()
      L6_2 = false
      L7_2 = false
      L4_2(L5_2, L6_2, L7_2)
    end
  end
end
L30_1[L31_1] = L32_1
L30_1 = _ENV
L31_1 = "tp_waypoint"
function L32_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = HUD
  L0_2 = L0_2.IS_WAYPOINT_ACTIVE
  L0_2 = L0_2()
  if L0_2 then
    L0_2 = HUD
    L0_2 = L0_2.GET_BLIP_INFO_ID_COORD
    L1_2 = HUD
    L1_2 = L1_2.GET_FIRST_BLIP_INFO_ID
    L2_2 = HUD
    L2_2 = L2_2.GET_WAYPOINT_BLIP_ENUM_ID
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2 = L2_2()
    L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    L1_2 = waypoint_coord
    L2_2 = L0_2
    L1_2, L2_2, L3_2 = L1_2(L2_2)
    L4_2 = teleport
    L5_2 = L1_2
    L6_2 = L2_2
    L7_2 = L3_2
    L4_2(L5_2, L6_2, L7_2)
  end
end
L30_1[L31_1] = L32_1
L30_1 = _ENV
L31_1 = "riding_animals"
function L32_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2
  L1_2 = {}
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "a_c_deer"
  L2_2 = L2_2(L3_2)
  L3_2 = util
  L3_2 = L3_2.joaat
  L4_2 = "a_c_boar"
  L3_2 = L3_2(L4_2)
  L4_2 = util
  L4_2 = L4_2.joaat
  L5_2 = "a_c_cow"
  L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L4_2(L5_2)
  L1_2[1] = L2_2
  L1_2[2] = L3_2
  L1_2[3] = L4_2
  L1_2[4] = L5_2
  L1_2[5] = L6_2
  L1_2[6] = L7_2
  L1_2[7] = L8_2
  L1_2[8] = L9_2
  L1_2[9] = L10_2
  L1_2[10] = L11_2
  L1_2[11] = L12_2
  L1_2[12] = L13_2
  L1_2[13] = L14_2
  L1_2[14] = L15_2
  L1_2[15] = L16_2
  L1_2[16] = L17_2
  L1_2[17] = L18_2
  L1_2[18] = L19_2
  L1_2[19] = L20_2
  L1_2[20] = L21_2
  L1_2[21] = L22_2
  L2_2 = L1_2[A0_2]
  L3_2 = ENTITY
  L3_2 = L3_2.GET_ENTITY_COORDS
  L4_2 = PLAYER
  L4_2 = L4_2.PLAYER_PED_ID
  L4_2 = L4_2()
  L5_2 = false
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = create_ped
  L5_2 = 8
  L6_2 = L2_2
  L7_2 = L3_2.x
  L8_2 = L3_2.y
  L9_2 = L3_2.z
  L10_2 = ENTITY
  L10_2 = L10_2.GET_ENTITY_HEADING
  L11_2 = PLAYER
  L11_2 = L11_2.PLAYER_PED_ID
  L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L11_2()
  L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_INVINCIBLE
  L6_2 = L4_2
  L7_2 = true
  L5_2(L6_2, L7_2)
  L5_2 = ENTITY
  L5_2 = L5_2.FREEZE_ENTITY_POSITION
  L6_2 = L4_2
  L7_2 = true
  L5_2(L6_2, L7_2)
  L5_2 = 0
  L6_2 = 0
  if 1 == A0_2 then
    L5_2 = 0.3
    L6_2 = 0.15
  elseif 2 == A0_2 then
    L5_2 = 0.4
    L6_2 = 0.3
  elseif 3 == A0_2 then
    L5_2 = 0.2
    L6_2 = 0.1
  end
  L7_2 = ENTITY
  L7_2 = L7_2.GET_ENTITY_MODEL
  L8_2 = PLAYER
  L8_2 = L8_2.PLAYER_PED_ID
  L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L8_2()
  L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
  L8_2 = util
  L8_2 = L8_2.joaat
  L9_2 = "mp_f_freemode_01"
  L8_2 = L8_2(L9_2)
  if L7_2 == L8_2 then
    z_off = L6_2
  else
    z_off = L5_2
  end
  L7_2 = ENTITY
  L7_2 = L7_2.ATTACH_ENTITY_TO_ENTITY
  L8_2 = PLAYER
  L8_2 = L8_2.PLAYER_PED_ID
  L8_2 = L8_2()
  L9_2 = L4_2
  L10_2 = PED
  L10_2 = L10_2.GET_PED_BONE_INDEX
  L11_2 = L4_2
  L12_2 = 24816
  L10_2 = L10_2(L11_2, L12_2)
  L11_2 = -0.3
  L12_2 = 0.0
  L13_2 = z_off
  L14_2 = 0.0
  L15_2 = 0.0
  L16_2 = 90.0
  L17_2 = false
  L18_2 = false
  L19_2 = false
  L20_2 = true
  L21_2 = 2
  L22_2 = true
  L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
  L7_2 = request_anim_dict
  L8_2 = "rcmjosh2"
  L7_2(L8_2)
  L7_2 = TASK
  L7_2 = L7_2.TASK_PLAY_ANIM
  L8_2 = PLAYER
  L8_2 = L8_2.PLAYER_PED_ID
  L8_2 = L8_2()
  L9_2 = "rcmjosh2"
  L10_2 = "josh_sitting_loop"
  L11_2 = 8.0
  L12_2 = 1
  L13_2 = -1
  L14_2 = 2
  L15_2 = 1.0
  L16_2 = false
  L17_2 = false
  L18_2 = false
  L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  L7_2 = ENTITY
  L7_2 = L7_2.FREEZE_ENTITY_POSITION
  L8_2 = L4_2
  L9_2 = false
  L7_2(L8_2, L9_2)
  L7_2 = ENTITY
  L7_2 = L7_2.FREEZE_ENTITY_POSITION
  L8_2 = PLAYER
  L8_2 = L8_2.PLAYER_PED_ID
  L8_2 = L8_2()
  L9_2 = false
  L7_2(L8_2, L9_2)
  while true do
    L7_2 = ENTITY
    L7_2 = L7_2.DOES_ENTITY_EXIST
    L8_2 = L4_2
    L7_2 = L7_2(L8_2)
    if not L7_2 then
      break
    end
    L7_2 = PAD
    L7_2 = L7_2.IS_CONTROL_JUST_PRESSED
    L8_2 = 23
    L9_2 = 23
    L7_2 = L7_2(L8_2, L9_2)
    if L7_2 then
      L7_2 = ENTITY
      L7_2 = L7_2.DETACH_ENTITY
      L8_2 = PLAYER
      L8_2 = L8_2.PLAYER_PED_ID
      L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L8_2()
      L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
      L7_2 = delete_entity_by_handle
      L8_2 = L4_2
      L7_2(L8_2)
      L7_2 = TASK
      L7_2 = L7_2.CLEAR_PED_TASKS_IMMEDIATELY
      L8_2 = PLAYER
      L8_2 = L8_2.PLAYER_PED_ID
      L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L8_2()
      L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
      L4_2 = 0
    end
    L7_2 = ENTITY
    L7_2 = L7_2.IS_ENTITY_IN_AIR
    L8_2 = L4_2
    L7_2 = L7_2(L8_2)
    if not L7_2 then
      L7_2 = PAD
      L7_2 = L7_2.IS_CONTROL_PRESSED
      L8_2 = 0
      L9_2 = 32
      L7_2 = L7_2(L8_2, L9_2)
      if L7_2 then
        L7_2 = PAD
        L7_2 = L7_2.GET_CONTROL_NORMAL
        L8_2 = 146
        L9_2 = 146
        L7_2 = L7_2(L8_2, L9_2)
        L8_2 = ENTITY
        L8_2 = L8_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
        L9_2 = L4_2
        L10_2 = L7_2 * 10.0
        L11_2 = 8.0
        L12_2 = 0.0
        L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2)
        L9_2 = TASK
        L9_2 = L9_2.TASK_LOOK_AT_COORD
        L10_2 = L4_2
        L11_2 = L8_2.x
        L12_2 = L8_2.y
        L13_2 = L8_2.z
        L14_2 = 0
        L15_2 = 0
        L16_2 = 2
        L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
        L9_2 = TASK
        L9_2 = L9_2.TASK_GO_STRAIGHT_TO_COORD
        L10_2 = L4_2
        L11_2 = L8_2.x
        L12_2 = L8_2.y
        L13_2 = L8_2.z
        L14_2 = 20.0
        L15_2 = -1
        L16_2 = ENTITY
        L16_2 = L16_2.GET_ENTITY_HEADING
        L17_2 = L4_2
        L16_2 = L16_2(L17_2)
        L17_2 = 0.5
        L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
      end
    end
    L7_2 = util
    L7_2 = L7_2.yield
    L7_2()
  end
end
L30_1[L31_1] = L32_1
L30_1 = _ENV
L31_1 = "god_cam"
function L32_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  godcam = A0_2
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = PLAYER
  L3_2 = L3_2.GET_PLAYER_PED
  L4_2 = A1_2
  L3_2 = L3_2(L4_2)
  L4_2 = false
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = CAM
  L3_2 = L3_2.GET_GAMEPLAY_CAM_ROT
  L3_2 = L3_2()
  L4_2 = CAM
  L4_2 = L4_2.CREATE_CAM_WITH_PARAMS
  L5_2 = "DEFAULT_SCRIPTED_CAMERA"
  L6_2 = L2_2.x
  L7_2 = L2_2.y
  L8_2 = L2_2.z
  L9_2 = L3_2.y
  L9_2 = L9_2 - 90
  L10_2 = L3_2.y
  L11_2 = L3_2.z
  L12_2 = 200
  L13_2 = true
  L14_2 = true
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  L5_2 = CAM
  L5_2 = L5_2.SET_CAM_ACTIVE
  L6_2 = L4_2
  L7_2 = true
  L5_2(L6_2, L7_2)
  L5_2 = CAM
  L5_2 = L5_2.RENDER_SCRIPT_CAMS
  L6_2 = true
  L7_2 = true
  L8_2 = 1000
  L9_2 = true
  L10_2 = true
  L11_2 = 0
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L5_2 = godcam
  if L5_2 then
    while true do
      L5_2 = godcam
      if not L5_2 then
        break
      end
      L5_2 = ENTITY
      L5_2 = L5_2.GET_ENTITY_COORDS
      L6_2 = PLAYER
      L6_2 = L6_2.GET_PLAYER_PED
      L7_2 = A1_2
      L6_2 = L6_2(L7_2)
      L7_2 = false
      L5_2 = L5_2(L6_2, L7_2)
      L2_2 = L5_2
      L5_2 = CAM
      L5_2 = L5_2.SET_CAM_COORD
      L6_2 = L4_2
      L7_2 = L2_2.x
      L8_2 = L2_2.y
      L9_2 = L2_2.z
      L9_2 = L9_2 + 10
      L5_2(L6_2, L7_2, L8_2, L9_2)
      L5_2 = util
      L5_2 = L5_2.yield
      L5_2()
    end
  else
    L5_2 = CAM
    L5_2 = L5_2.SET_CAM_ACTIVE
    L6_2 = L4_2
    L7_2 = false
    L5_2(L6_2, L7_2)
    L5_2 = CAM
    L5_2 = L5_2.DESTROY_CAM
    L6_2 = L4_2
    L7_2 = true
    L5_2(L6_2, L7_2)
    L5_2 = CAM
    L5_2 = L5_2.RENDER_SCRIPT_CAMS
    L6_2 = false
    L7_2 = true
    L8_2 = 1000
    L9_2 = true
    L10_2 = true
    L11_2 = 0
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  end
end
L30_1[L31_1] = L32_1
L30_1 = _ENV
L31_1 = "atom_force"
function L32_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2
  atom_force_toggle = A0_2
  L1_2 = atom_force_toggle
  if L1_2 then
    L1_2 = string
    L1_2 = L1_2.format
    L2_2 = "按 ~%s~ 和 ~%s~ 来使用原力"
    L3_2 = "INPUT_ATTACK"
    L4_2 = "INPUT_AIM"
    L1_2 = L1_2(L2_2, L3_2, L4_2)
    L2_2 = util
    L2_2 = L2_2.show_corner_help
    L3_2 = L1_2
    L2_2(L3_2)
    L2_2 = Effect
    L2_2 = L2_2.new
    L3_2 = "scr_ie_tw"
    L4_2 = "scr_impexp_tw_take_zone"
    L2_2 = L2_2(L3_2, L4_2)
    L3_2 = {}
    L3_2.r = 0.5
    L3_2.g = 0.0
    L3_2.b = 0.5
    L3_2.a = 1.0
    L4_2 = request_ptfx_asset
    L5_2 = L2_2.asset
    L4_2(L5_2)
    L4_2 = GRAPHICS
    L4_2 = L4_2.USE_PARTICLE_FX_ASSET
    L5_2 = L2_2.asset
    L4_2(L5_2)
    L4_2 = GRAPHICS
    L4_2 = L4_2.SET_PARTICLE_FX_NON_LOOPED_COLOUR
    L5_2 = L3_2.r
    L6_2 = L3_2.g
    L7_2 = L3_2.b
    L4_2(L5_2, L6_2, L7_2)
    L4_2 = GRAPHICS
    L5_2 = "START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY"
    L4_2 = L4_2[L5_2]
    L5_2 = L2_2.name
    L6_2 = PLAYER
    L6_2 = L6_2.PLAYER_PED_ID
    L6_2 = L6_2()
    L7_2 = 0.0
    L8_2 = 0.0
    L9_2 = -0.9
    L10_2 = 1.0
    L11_2 = 1.0
    L12_2 = 1
    L13_2 = 1.0
    L14_2 = false
    L15_2 = false
    L16_2 = false
    L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  end
  while true do
    L1_2 = atom_force_toggle
    if not L1_2 then
      break
    end
    L1_2 = PLAYER
    L1_2 = L1_2.DISABLE_PLAYER_FIRING
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_ID
    L2_2 = L2_2()
    L3_2 = true
    L1_2(L2_2, L3_2)
    L1_2 = PAD
    L1_2 = L1_2.DISABLE_CONTROL_ACTION
    L2_2 = 0
    L3_2 = 25
    L4_2 = true
    L1_2(L2_2, L3_2, L4_2)
    L1_2 = PAD
    L1_2 = L1_2.DISABLE_CONTROL_ACTION
    L2_2 = 0
    L3_2 = 68
    L4_2 = true
    L1_2(L2_2, L3_2, L4_2)
    L1_2 = PAD
    L1_2 = L1_2.DISABLE_CONTROL_ACTION
    L2_2 = 0
    L3_2 = 91
    L4_2 = true
    L1_2(L2_2, L3_2, L4_2)
    L1_2 = get_ped_nearby_vehicles
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L2_2()
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
    L2_2 = ipairs
    L3_2 = L1_2
    L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
    for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
      L8_2 = PED
      L8_2 = L8_2.IS_PED_IN_ANY_VEHICLE
      L9_2 = PLAYER
      L9_2 = L9_2.PLAYER_PED_ID
      L9_2 = L9_2()
      L10_2 = false
      L8_2 = L8_2(L9_2, L10_2)
      if L8_2 then
        L8_2 = PED
        L8_2 = L8_2.GET_VEHICLE_PED_IS_IN
        L9_2 = PLAYER
        L9_2 = L9_2.PLAYER_PED_ID
        L9_2 = L9_2()
        L10_2 = false
        L8_2 = L8_2(L9_2, L10_2)
        if L8_2 == L7_2 then
          goto lbl_171
        end
      end
      L8_2 = PAD
      L8_2 = L8_2.IS_DISABLED_CONTROL_PRESSED
      L9_2 = 0
      L10_2 = 24
      L8_2 = L8_2(L9_2, L10_2)
      if L8_2 then
        L8_2 = request_control
        L9_2 = L7_2
        L8_2 = L8_2(L9_2)
        if L8_2 then
          L8_2 = ENTITY
          L8_2 = L8_2.APPLY_FORCE_TO_ENTITY
          L9_2 = L7_2
          L10_2 = 1
          L11_2 = 0.0
          L12_2 = 0.0
          L13_2 = 0.5
          L14_2 = 1.0
          L15_2 = 1.0
          L16_2 = 1
          L17_2 = 0
          L18_2 = false
          L19_2 = false
          L20_2 = true
          L21_2 = false
          L22_2 = false
          L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
      end
      else
        L8_2 = PAD
        L8_2 = L8_2.IS_DISABLED_CONTROL_PRESSED
        L9_2 = 0
        L10_2 = 25
        L8_2 = L8_2(L9_2, L10_2)
        if L8_2 then
          L8_2 = request_control
          L9_2 = L7_2
          L8_2 = L8_2(L9_2)
          if L8_2 then
            L8_2 = ENTITY
            L8_2 = L8_2.APPLY_FORCE_TO_ENTITY
            L9_2 = L7_2
            L10_2 = 1
            L11_2 = 0.0
            L12_2 = 0.0
            L13_2 = -70.0
            L14_2 = 1.0
            L15_2 = 1.0
            L16_2 = 1
            L17_2 = 0
            L18_2 = false
            L19_2 = false
            L20_2 = true
            L21_2 = false
            L22_2 = false
            L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
          end
        end
      end
      ::lbl_171::
    end
    L2_2 = util
    L2_2 = L2_2.yield
    L2_2()
  end
end
L30_1[L31_1] = L32_1
L30_1 = _ENV
L31_1 = "filesystem"
L30_1 = L30_1[L31_1]
L31_1 = "store_dir"
L30_1 = L30_1[L31_1]
L30_1 = L30_1()
L31_1 = "SakuraLog\\Death Log"
L30_1 = L30_1 .. L31_1
L31_1 = _ENV
L32_1 = "filesystem"
L31_1 = L31_1[L32_1]
L32_1 = "mkdirs"
L31_1 = L31_1[L32_1]
L32_1 = L30_1
L31_1(L32_1)
L31_1 = _ENV
L32_1 = "filesystem"
L31_1 = L31_1[L32_1]
L32_1 = "store_dir"
L31_1 = L31_1[L32_1]
L31_1 = L31_1()
L32_1 = "SakuraLog\\Death Log\\Death_Log.txt"
L31_1 = L31_1 .. L32_1
L32_1 = _ENV
L33_1 = "add_deathlog"
function L34_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L3_2 = io
  L3_2 = L3_2.open
  L4_2 = L31_1
  L5_2 = "a+"
  L3_2, L4_2 = L3_2(L4_2, L5_2)
  if not L3_2 then
    L5_2 = false
    return L5_2
  end
  L6_2 = L3_2
  L5_2 = L3_2.write
  L7_2 = A0_2
  L8_2 = " "
  L9_2 = A1_2
  L10_2 = " 类型: "
  L11_2 = A2_2
  L12_2 = "\n"
  L7_2 = L7_2 .. L8_2 .. L9_2 .. L10_2 .. L11_2 .. L12_2
  L5_2(L6_2, L7_2)
  L6_2 = L3_2
  L5_2 = L3_2.close
  L5_2(L6_2)
  L5_2 = input
  L6_2 = true
  return L5_2, L6_2
end
L32_1[L33_1] = L34_1
L32_1 = _ENV
L33_1 = "death_log"
function L34_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = PED
  L0_2 = L0_2.IS_PED_DEAD_OR_DYING
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  if L0_2 then
    L0_2 = PED
    L0_2 = L0_2.GET_PED_SOURCE_OF_DEATH
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_PED_ID
    L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2 = L1_2()
    L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
    L1_2 = os
    L1_2 = L1_2.time
    L1_2 = L1_2()
    L2_2 = os
    L2_2 = L2_2.date
    L3_2 = "%Y-%m-%d %H:%M:%S"
    L4_2 = L1_2
    L2_2 = L2_2(L3_2, L4_2)
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2 = L3_2()
    if L0_2 == L3_2 then
      L3_2 = NETWORK
      L3_2 = L3_2.NETWORK_GET_PLAYER_INDEX_FROM_PED
      L4_2 = L0_2
      L3_2 = L3_2(L4_2)
      L4_2 = PLAYER
      L4_2 = L4_2.GET_PLAYER_NAME
      L5_2 = L3_2
      L4_2 = L4_2(L5_2)
      L5_2 = add_deathlog
      L6_2 = "["
      L7_2 = L2_2
      L8_2 = "]"
      L6_2 = L6_2 .. L7_2 .. L8_2
      L7_2 = "玩家: "
      L8_2 = L4_2
      L7_2 = L7_2 .. L8_2
      L8_2 = "自杀"
      L5_2(L6_2, L7_2, L8_2)
      L5_2 = util
      L5_2 = L5_2.yield
      L6_2 = 12000
      L5_2(L6_2)
      return
    end
    L3_2 = STREAMING
    L3_2 = L3_2.IS_MODEL_A_PED
    L4_2 = ENTITY
    L4_2 = L4_2.GET_ENTITY_MODEL
    L5_2 = L0_2
    L4_2, L5_2, L6_2, L7_2, L8_2 = L4_2(L5_2)
    L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
    if L3_2 then
      L3_2 = NETWORK
      L3_2 = L3_2.NETWORK_GET_PLAYER_INDEX_FROM_PED
      L4_2 = L0_2
      L3_2 = L3_2(L4_2)
      L4_2 = PLAYER
      L4_2 = L4_2.GET_PLAYER_NAME
      L5_2 = L3_2
      L4_2 = L4_2(L5_2)
      if nil ~= L4_2 then
        L5_2 = add_deathlog
        L6_2 = "["
        L7_2 = L2_2
        L8_2 = "]"
        L6_2 = L6_2 .. L7_2 .. L8_2
        L7_2 = "玩家: "
        L8_2 = L4_2
        L7_2 = L7_2 .. L8_2
        L8_2 = "武器"
        L5_2(L6_2, L7_2, L8_2)
      end
      L5_2 = util
      L5_2 = L5_2.toast
      L6_2 = "被"
      L7_2 = L4_2
      L8_2 = "使用武器击杀"
      L6_2 = L6_2 .. L7_2 .. L8_2
      L5_2(L6_2)
      L5_2 = util
      L5_2 = L5_2.yield
      L6_2 = 12000
      L5_2(L6_2)
    else
      L3_2 = STREAMING
      L3_2 = L3_2.IS_MODEL_A_VEHICLE
      L4_2 = ENTITY
      L4_2 = L4_2.GET_ENTITY_MODEL
      L5_2 = L0_2
      L4_2, L5_2, L6_2, L7_2, L8_2 = L4_2(L5_2)
      L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
      if L3_2 then
        L3_2 = entities
        L3_2 = L3_2.get_owner
        L4_2 = entities
        L4_2 = L4_2.handle_to_pointer
        L5_2 = L0_2
        L4_2, L5_2, L6_2, L7_2, L8_2 = L4_2(L5_2)
        L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
        L4_2 = PLAYER
        L4_2 = L4_2.GET_PLAYER_NAME
        L5_2 = L3_2
        L4_2 = L4_2(L5_2)
        if nil ~= L4_2 then
          L5_2 = add_deathlog
          L6_2 = "["
          L7_2 = L2_2
          L8_2 = "]"
          L6_2 = L6_2 .. L7_2 .. L8_2
          L7_2 = "玩家: "
          L8_2 = L4_2
          L7_2 = L7_2 .. L8_2
          L8_2 = "载具"
          L5_2(L6_2, L7_2, L8_2)
        end
        L5_2 = util
        L5_2 = L5_2.toast
        L6_2 = "被"
        L7_2 = L4_2
        L8_2 = "使用载具击杀"
        L6_2 = L6_2 .. L7_2 .. L8_2
        L5_2(L6_2)
        L5_2 = util
        L5_2 = L5_2.yield
        L6_2 = 12000
        L5_2(L6_2)
      end
    end
  end
end
L32_1[L33_1] = L34_1
L32_1 = _ENV
L33_1 = "open_dea_log"
function L34_1()
  local L0_2, L1_2
  L0_2 = util
  L0_2 = L0_2.open_folder
  L1_2 = L30_1
  L0_2(L1_2)
end
L32_1[L33_1] = L34_1
L32_1 = _ENV
L33_1 = "clear_dea_log"
function L34_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = io
  L0_2 = L0_2.remove
  L1_2 = L31_1
  L0_2(L1_2)
  L0_2 = notification
  L1_2 = "~y~~bold~清除完成"
  L2_2 = math
  L2_2 = L2_2.random
  L3_2 = 0
  L4_2 = 200
  L2_2, L3_2, L4_2 = L2_2(L3_2, L4_2)
  L0_2(L1_2, L2_2, L3_2, L4_2)
end
L32_1[L33_1] = L34_1
L32_1 = "u_m_m_jesus_01"
L33_1 = _ENV
L34_1 = "Delcar"
function L35_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2
  L3_2 = PED
  L3_2 = L3_2.IS_PED_IN_ANY_VEHICLE
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  if true == L3_2 then
    L3_2 = PED
    L3_2 = L3_2.GET_VEHICLE_PED_IS_IN
    L4_2 = A0_2
    L5_2 = true
    L3_2 = L3_2(L4_2, L5_2)
    L4_2 = GetControl
    L5_2 = L3_2
    L6_2 = A1_2
    L7_2 = A2_2
    L4_2(L5_2, L6_2, L7_2)
    L4_2 = ENTITY
    L4_2 = L4_2.SET_ENTITY_AS_MISSION_ENTITY
    L5_2 = L3_2
    L4_2(L5_2)
    L4_2 = delete_entity
    L5_2 = L3_2
    L4_2(L5_2)
  end
end
L33_1[L34_1] = L35_1
L33_1 = _ENV
L34_1 = "SetPedCoor"
function L35_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L4_2 = ENTITY
  L4_2 = L4_2.SET_ENTITY_COORDS
  L5_2 = A0_2
  L6_2 = A1_2
  L7_2 = A2_2
  L8_2 = A3_2
  L9_2 = false
  L10_2 = true
  L11_2 = true
  L12_2 = false
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
end
L33_1[L34_1] = L35_1
L33_1 = _ENV
L34_1 = "Teabagtime"
function L35_1(A0_2, A1_2, A2_2, A3_2, A4_2, A5_2, A6_2, A7_2)
  local L8_2, L9_2
  L8_2 = util
  L8_2 = L8_2.create_tick_handler
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3
    L0_3 = AUDIO
    L1_3 = "PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE"
    L0_3 = L0_3[L1_3]
    L1_3 = A0_2
    L2_3 = "LES1A_DHAC"
    L3_3 = "LESTER"
    L4_3 = "SPEECH_PARAMS_FORCE_SHOUTED"
    L5_3 = 1
    L0_3(L1_3, L2_3, L3_3, L4_3, L5_3)
    L0_3 = AUDIO
    L1_3 = "PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE"
    L0_3 = L0_3[L1_3]
    L1_3 = A1_2
    L2_3 = "TUSCO_AHAD"
    L3_3 = "LESTER"
    L4_3 = "SPEECH_PARAMS_FORCE_SHOUTED"
    L5_3 = 1
    L0_3(L1_3, L2_3, L3_3, L4_3, L5_3)
    L0_3 = AUDIO
    L1_3 = "PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE"
    L0_3 = L0_3[L1_3]
    L1_3 = A2_2
    L2_3 = "LES1A_DHAC"
    L3_3 = "LESTER"
    L4_3 = "SPEECH_PARAMS_FORCE_SHOUTED"
    L5_3 = 1
    L0_3(L1_3, L2_3, L3_3, L4_3, L5_3)
    L0_3 = AUDIO
    L1_3 = "PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE"
    L0_3 = L0_3[L1_3]
    L1_3 = A3_2
    L2_3 = "TUSCO_AHAD"
    L3_3 = "LESTER"
    L4_3 = "SPEECH_PARAMS_FORCE_SHOUTED"
    L5_3 = 1
    L0_3(L1_3, L2_3, L3_3, L4_3, L5_3)
    L0_3 = AUDIO
    L1_3 = "PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE"
    L0_3 = L0_3[L1_3]
    L1_3 = A4_2
    L2_3 = "LES1A_DHAC"
    L3_3 = "LESTER"
    L4_3 = "SPEECH_PARAMS_FORCE_SHOUTED"
    L5_3 = 1
    L0_3(L1_3, L2_3, L3_3, L4_3, L5_3)
    L0_3 = AUDIO
    L1_3 = "PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE"
    L0_3 = L0_3[L1_3]
    L1_3 = A5_2
    L2_3 = "TUSCO_AHAD"
    L3_3 = "LESTER"
    L4_3 = "SPEECH_PARAMS_FORCE_SHOUTED"
    L5_3 = 1
    L0_3(L1_3, L2_3, L3_3, L4_3, L5_3)
    L0_3 = AUDIO
    L1_3 = "PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE"
    L0_3 = L0_3[L1_3]
    L1_3 = A6_2
    L2_3 = "LES1A_DHAC"
    L3_3 = "LESTER"
    L4_3 = "SPEECH_PARAMS_FORCE_SHOUTED"
    L5_3 = 1
    L0_3(L1_3, L2_3, L3_3, L4_3, L5_3)
    L0_3 = AUDIO
    L1_3 = "PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE"
    L0_3 = L0_3[L1_3]
    L1_3 = A7_2
    L2_3 = "TUSCO_AHAD"
    L3_3 = "LESTER"
    L4_3 = "SPEECH_PARAMS_FORCE_SHOUTED"
    L5_3 = 1
    L0_3(L1_3, L2_3, L3_3, L4_3, L5_3)
    L0_3 = util
    L0_3 = L0_3.yield
    L1_3 = 100
    L0_3(L1_3)
  end
  L8_2(L9_2)
end
L33_1[L34_1] = L35_1
L33_1 = _ENV
L34_1 = "Jesuslovesyou"
function L35_1(A0_2)
  local L1_2, L2_2
  L1_2 = util
  L1_2 = L1_2.create_tick_handler
  function L2_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3
    L0_3 = ipairs
    L1_3 = A0_2
    L0_3, L1_3, L2_3, L3_3 = L0_3(L1_3)
    for L4_3, L5_3 in L0_3, L1_3, L2_3, L3_3 do
      L6_3 = AUDIO
      L7_3 = "PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE"
      L6_3 = L6_3[L7_3]
      L7_3 = L5_3
      L8_3 = "BUMP"
      L9_3 = "JESSE"
      L10_3 = "SPEECH_PARAMS_FORCE"
      L11_3 = 1
      L6_3(L7_3, L8_3, L9_3, L10_3, L11_3)
      L6_3 = util
      L6_3 = L6_3.yield
      L7_3 = 250
      L6_3(L7_3)
    end
  end
  L1_2(L2_2)
end
L33_1[L34_1] = L35_1
L33_1 = _ENV
L34_1 = "Trevortime"
function L35_1(A0_2)
  local L1_2, L2_2
  L1_2 = util
  L1_2 = L1_2.create_tick_handler
  function L2_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3
    L0_3 = ipairs
    L1_3 = A0_2
    L0_3, L1_3, L2_3, L3_3 = L0_3(L1_3)
    for L4_3, L5_3 in L0_3, L1_3, L2_3, L3_3 do
      L6_3 = AUDIO
      L7_3 = "PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE"
      L6_3 = L6_3[L7_3]
      L7_3 = L5_3
      L8_3 = "TR2_ABAJ"
      L9_3 = "TREVOR"
      L10_3 = "SPEECH_PARAMS_FORCE"
      L11_3 = 1
      L6_3(L7_3, L8_3, L9_3, L10_3, L11_3)
      L6_3 = util
      L6_3 = L6_3.yield
      L7_3 = 100
      L6_3(L7_3)
    end
  end
  L1_2(L2_2)
end
L33_1[L34_1] = L35_1
L33_1 = _ENV
L34_1 = "Fuckyou"
function L35_1(A0_2)
  local L1_2, L2_2
  L1_2 = util
  L1_2 = L1_2.create_tick_handler
  function L2_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
    L0_3 = ipairs
    L1_3 = A0_2
    L0_3, L1_3, L2_3, L3_3 = L0_3(L1_3)
    for L4_3, L5_3 in L0_3, L1_3, L2_3, L3_3 do
      L6_3 = AUDIO
      L6_3 = L6_3.PLAY_PED_AMBIENT_SPEECH_NATIVE
      L7_3 = L5_3
      L8_3 = "GENERIC_FUCK_YOU"
      L9_3 = "SPEECH_PARAMS_FORCE"
      L10_3 = 1
      L6_3(L7_3, L8_3, L9_3, L10_3)
      L6_3 = util
      L6_3 = L6_3.yield
      L7_3 = 100
      L6_3(L7_3)
    end
  end
  L1_2(L2_2)
end
L33_1[L34_1] = L35_1
L33_1 = _ENV
L34_1 = "Provoke"
function L35_1(A0_2)
  local L1_2, L2_2
  L1_2 = util
  L1_2 = L1_2.create_tick_handler
  function L2_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
    L0_3 = ipairs
    L1_3 = A0_2
    L0_3, L1_3, L2_3, L3_3 = L0_3(L1_3)
    for L4_3, L5_3 in L0_3, L1_3, L2_3, L3_3 do
      L6_3 = AUDIO
      L6_3 = L6_3.PLAY_PED_AMBIENT_SPEECH_NATIVE
      L7_3 = L5_3
      L8_3 = "Provoke_Trespass"
      L9_3 = "Speech_Params_Force_Shouted_Critical"
      L10_3 = 1
      L6_3(L7_3, L8_3, L9_3, L10_3)
      L6_3 = util
      L6_3 = L6_3.yield
      L7_3 = 100
      L6_3(L7_3)
    end
  end
  L1_2(L2_2)
end
L33_1[L34_1] = L35_1
L33_1 = _ENV
L34_1 = "Insulthigh"
function L35_1(A0_2)
  local L1_2, L2_2
  L1_2 = util
  L1_2 = L1_2.create_tick_handler
  function L2_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
    L0_3 = ipairs
    L1_3 = A0_2
    L0_3, L1_3, L2_3, L3_3 = L0_3(L1_3)
    for L4_3, L5_3 in L0_3, L1_3, L2_3, L3_3 do
      L6_3 = AUDIO
      L6_3 = L6_3.PLAY_PED_AMBIENT_SPEECH_NATIVE
      L7_3 = L5_3
      L8_3 = "Generic_Insult_High"
      L9_3 = "SPEECH_PARAMS_FORCE"
      L10_3 = 1
      L6_3(L7_3, L8_3, L9_3, L10_3)
      L6_3 = util
      L6_3 = L6_3.yield
      L7_3 = 100
      L6_3(L7_3)
    end
  end
  L1_2(L2_2)
end
L33_1[L34_1] = L35_1
L33_1 = _ENV
L34_1 = "Warcry"
function L35_1(A0_2)
  local L1_2, L2_2
  L1_2 = util
  L1_2 = L1_2.create_tick_handler
  function L2_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
    L0_3 = ipairs
    L1_3 = A0_2
    L0_3, L1_3, L2_3, L3_3 = L0_3(L1_3)
    for L4_3, L5_3 in L0_3, L1_3, L2_3, L3_3 do
      L6_3 = AUDIO
      L6_3 = L6_3.PLAY_PED_AMBIENT_SPEECH_NATIVE
      L7_3 = L5_3
      L8_3 = "GENERIC_WAR_CRY"
      L9_3 = "SPEECH_PARAMS_FORCE"
      L10_3 = 1
      L6_3(L7_3, L8_3, L9_3, L10_3)
      L6_3 = util
      L6_3 = L6_3.yield
      L7_3 = 100
      L6_3(L7_3)
    end
  end
  L1_2(L2_2)
end
L33_1[L34_1] = L35_1
L33_1 = _ENV
L34_1 = "Pedspawn"
function L35_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = request_model
  L3_2 = A0_2
  L2_2(L3_2)
  L2_2 = entities
  L2_2 = L2_2.create_ped
  L3_2 = 1
  L4_2 = A0_2
  L5_2 = A1_2
  L6_2 = 0
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  L3_2 = ENTITY
  L3_2 = L3_2.SET_ENTITY_INVINCIBLE
  L4_2 = L2_2
  L5_2 = true
  L3_2(L4_2, L5_2)
  L3_2 = ENTITY
  L3_2 = L3_2.FREEZE_ENTITY_POSITION
  L4_2 = L2_2
  L5_2 = true
  L3_2(L4_2, L5_2)
  L3_2 = PED
  L3_2 = L3_2.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS
  L4_2 = L2_2
  L5_2 = true
  L3_2(L4_2, L5_2)
  L3_2 = PED
  L3_2 = L3_2.SET_PED_CAN_LOSE_PROPS_ON_DAMAGE
  L4_2 = L2_2
  L5_2 = false
  L3_2(L4_2, L5_2)
  L3_2 = util
  L3_2 = L3_2.joaat
  L4_2 = "ig_lestercrest"
  L3_2 = L3_2(L4_2)
  if A0_2 == L3_2 then
    L3_2 = PED
    L3_2 = L3_2.SET_PED_PROP_INDEX
    L4_2 = L2_2
    L5_2 = 1
    L3_2(L4_2, L5_2)
  end
  return L2_2
end
L33_1[L34_1] = L35_1
L33_1 = _ENV
L34_1 = "Runanim"
function L35_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L3_2 = TASK
  L3_2 = L3_2.TASK_PLAY_ANIM
  L4_2 = A0_2
  L5_2 = A1_2
  L6_2 = A2_2
  L7_2 = 1.0
  L8_2 = 1.0
  L9_2 = -1
  L10_2 = 3
  L11_2 = 0.5
  L12_2 = false
  L13_2 = false
  L14_2 = false
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  while true do
    L3_2 = ENTITY
    L3_2 = L3_2.IS_ENTITY_PLAYING_ANIM
    L4_2 = A0_2
    L5_2 = A1_2
    L6_2 = A2_2
    L7_2 = 3
    L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
    if false ~= L3_2 then
      break
    end
    L3_2 = TASK
    L3_2 = L3_2.TASK_PLAY_ANIM
    L4_2 = A0_2
    L5_2 = A1_2
    L6_2 = A2_2
    L7_2 = 1.0
    L8_2 = 1.0
    L9_2 = -1
    L10_2 = 3
    L11_2 = 0.5
    L12_2 = false
    L13_2 = false
    L14_2 = false
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    L3_2 = util
    L3_2 = L3_2.yield
    L3_2()
  end
end
L33_1[L34_1] = L35_1
L33_1 = _ENV
L34_1 = "PFP"
function L35_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = A1_2
  L2_2 = L2_2(L3_2)
  L3_2 = ENTITY
  L3_2 = L3_2.GET_ENTITY_COORDS
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = L2_2.x
  L5_2 = L3_2.x
  L4_2 = L4_2 - L5_2
  L5_2 = L2_2.y
  L6_2 = L3_2.y
  L5_2 = L5_2 - L6_2
  L6_2 = MISC
  L6_2 = L6_2.GET_HEADING_FROM_VECTOR_2D
  L7_2 = L4_2
  L8_2 = L5_2
  L6_2 = L6_2(L7_2, L8_2)
  L7_2 = ENTITY
  L7_2 = L7_2.SET_ENTITY_HEADING
  L8_2 = A0_2
  L9_2 = L6_2
  return L7_2(L8_2, L9_2)
end
L33_1[L34_1] = L35_1
L33_1 = _ENV
L34_1 = "DelEnt"
function L35_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = ipairs
  L2_2 = A0_2
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = ENTITY
    L7_2 = L7_2.SET_ENTITY_AS_MISSION_ENTITY
    L8_2 = L6_2
    L7_2(L8_2)
    L7_2 = delete_entity
    L8_2 = L6_2
    L7_2(L8_2)
  end
end
L33_1[L34_1] = L35_1
L33_1 = _ENV
L34_1 = "Stopsound"
function L35_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
  L0_2 = 0
  L1_2 = 99
  L2_2 = 1
  for L3_2 = L0_2, L1_2, L2_2 do
    L4_2 = AUDIO
    L4_2 = L4_2.STOP_SOUND
    L5_2 = L3_2
    L4_2(L5_2)
  end
end
L33_1[L34_1] = L35_1
L33_1 = _ENV
L34_1 = "IPM"
function L35_1(A0_2, A1_2, A2_2, A3_2, A4_2)
  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L5_2 = ENTITY
  L5_2 = L5_2.GET_ENTITY_COORDS
  L6_2 = A0_2
  L5_2 = L5_2(L6_2)
  L6_2 = SYSTEM
  L6_2 = L6_2.VDIST2
  L7_2 = L5_2.x
  L8_2 = L5_2.y
  L9_2 = L5_2.z
  L10_2 = A1_2.x
  L11_2 = A1_2.y
  L12_2 = A1_2.z
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L7_2 = 0.5
  if L6_2 < L7_2 then
    L7_2 = util
    L7_2 = L7_2.yield
    L8_2 = 800
    L7_2(L8_2)
  else
    L7_2 = 0.5
    if L6_2 >= L7_2 then
      L7_2 = DelEnt
      L8_2 = A3_2[A4_2]
      L7_2(L8_2)
      A3_2[A4_2] = false
      L7_2 = Stopsound
      L7_2()
    end
  end
end
L33_1[L34_1] = L35_1
L33_1 = _ENV
L34_1 = "select_ped_cage"
function L35_1(A0_2)
  local L1_2
  L1_2 = pedset_tab
  L1_2 = L1_2[A0_2]
  L32_1 = L1_2
end
L33_1[L34_1] = L35_1
L33_1 = _ENV
L34_1 = "auto_ped_cage"
function L35_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED_SCRIPT_INDEX
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = L1_2
  L4_2 = true
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = PLAYER
  L3_2 = L3_2.GET_PLAYER_NAME
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = ped_cage_table
  L4_2 = L4_2[A0_2]
  if not L4_2 then
    L4_2 = {}
    L5_2 = util
    L5_2 = L5_2.joaat
    L6_2 = L32_1
    L5_2 = L5_2(L6_2)
    L6_2 = {}
    L7_2 = "p1"
    L8_2 = "p2"
    L9_2 = "p3"
    L10_2 = "p4"
    L11_2 = "p5"
    L12_2 = "p6"
    L13_2 = "p7"
    L14_2 = "p8"
    L6_2[1] = L7_2
    L6_2[2] = L8_2
    L6_2[3] = L9_2
    L6_2[4] = L10_2
    L6_2[5] = L11_2
    L6_2[6] = L12_2
    L6_2[7] = L13_2
    L6_2[8] = L14_2
    L7_2 = ipairs
    L8_2 = L6_2
    L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
    for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
      L13_2 = Pedspawn
      L14_2 = L5_2
      L15_2 = L2_2
      L13_2 = L13_2(L14_2, L15_2)
      L12_2 = L13_2
      L13_2 = table
      L13_2 = L13_2.insert
      L14_2 = L4_2
      L15_2 = L12_2
      L13_2(L14_2, L15_2)
    end
    L7_2 = SetPedCoor
    L8_2 = L4_2[1]
    L9_2 = L2_2.x
    L10_2 = L2_2.y
    L10_2 = L10_2 - 0.5
    L11_2 = L2_2.z
    L11_2 = L11_2 - 1.0
    L7_2(L8_2, L9_2, L10_2, L11_2)
    L7_2 = SetPedCoor
    L8_2 = L4_2[2]
    L9_2 = L2_2.x
    L9_2 = L9_2 - 0.5
    L10_2 = L2_2.y
    L10_2 = L10_2 - 0.5
    L11_2 = L2_2.z
    L11_2 = L11_2 - 1.0
    L7_2(L8_2, L9_2, L10_2, L11_2)
    L7_2 = SetPedCoor
    L8_2 = L4_2[3]
    L9_2 = L2_2.x
    L9_2 = L9_2 - 0.5
    L10_2 = L2_2.y
    L11_2 = L2_2.z
    L11_2 = L11_2 - 1.0
    L7_2(L8_2, L9_2, L10_2, L11_2)
    L7_2 = SetPedCoor
    L8_2 = L4_2[4]
    L9_2 = L2_2.x
    L9_2 = L9_2 - 0.5
    L10_2 = L2_2.y
    L10_2 = L10_2 + 0.5
    L11_2 = L2_2.z
    L11_2 = L11_2 - 1.0
    L7_2(L8_2, L9_2, L10_2, L11_2)
    L7_2 = SetPedCoor
    L8_2 = L4_2[5]
    L9_2 = L2_2.x
    L10_2 = L2_2.y
    L10_2 = L10_2 + 0.5
    L11_2 = L2_2.z
    L11_2 = L11_2 - 1.0
    L7_2(L8_2, L9_2, L10_2, L11_2)
    L7_2 = SetPedCoor
    L8_2 = L4_2[6]
    L9_2 = L2_2.x
    L9_2 = L9_2 + 0.5
    L10_2 = L2_2.y
    L10_2 = L10_2 + 0.5
    L11_2 = L2_2.z
    L11_2 = L11_2 - 1.0
    L7_2(L8_2, L9_2, L10_2, L11_2)
    L7_2 = SetPedCoor
    L8_2 = L4_2[7]
    L9_2 = L2_2.x
    L9_2 = L9_2 + 0.5
    L10_2 = L2_2.y
    L11_2 = L2_2.z
    L11_2 = L11_2 - 1.0
    L7_2(L8_2, L9_2, L10_2, L11_2)
    L7_2 = SetPedCoor
    L8_2 = L4_2[8]
    L9_2 = L2_2.x
    L9_2 = L9_2 + 0.5
    L10_2 = L2_2.y
    L10_2 = L10_2 - 0.5
    L11_2 = L2_2.z
    L11_2 = L11_2 - 1.0
    L7_2(L8_2, L9_2, L10_2, L11_2)
    L7_2 = util
    L7_2 = L7_2.joaat
    L8_2 = "IG_LesterCrest"
    L7_2 = L7_2(L8_2)
    if L5_2 == L7_2 then
      L7_2 = Teabagtime
      L8_2 = L4_2[1]
      L9_2 = L4_2[2]
      L10_2 = L4_2[3]
      L11_2 = L4_2[4]
      L12_2 = L4_2[5]
      L13_2 = L4_2[6]
      L14_2 = L4_2[7]
      L15_2 = L4_2[8]
      L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
    else
      L7_2 = util
      L7_2 = L7_2.joaat
      L8_2 = "player_two"
      L7_2 = L7_2(L8_2)
      if L5_2 == L7_2 then
        L7_2 = Trevortime
        L8_2 = L4_2
        L7_2(L8_2)
      else
        L7_2 = util
        L7_2 = L7_2.joaat
        L8_2 = "u_m_m_jesus_01"
        L7_2 = L7_2(L8_2)
        if L5_2 == L7_2 then
          L7_2 = Jesuslovesyou
          L8_2 = L4_2
          L7_2(L8_2)
        else
          L7_2 = util
          L7_2 = L7_2.joaat
          L8_2 = "IG_LesterCrest"
          L7_2 = L7_2(L8_2)
          if L5_2 == L7_2 then
            L7_2 = util
            L7_2 = L7_2.joaat
            L8_2 = "player_two"
            L7_2 = L7_2(L8_2)
            if not L7_2 then
              goto lbl_232
            end
          end
          L7_2 = GENERIC_AUDIO
          L7_2 = L7_2.DOES_CONTEXT_EXIST_FOR_THIS_PED
          L8_2 = L4_2[1]
          L9_2 = "GENERIC_FUCK_YOU"
          L7_2 = L7_2(L8_2, L9_2)
          if true == L7_2 then
            L7_2 = Fuckyou
            L8_2 = L4_2
            L7_2(L8_2)
          else
            L7_2 = GENERIC_AUDIO
            L7_2 = L7_2.DOES_CONTEXT_EXIST_FOR_THIS_PED
            L8_2 = L4_2[1]
            L9_2 = "Provoke_Trespass"
            L7_2 = L7_2(L8_2, L9_2)
            if L7_2 then
              L7_2 = Provoke
              L8_2 = L4_2
              L7_2(L8_2)
            else
              L7_2 = GENERIC_AUDIO
              L7_2 = L7_2.DOES_CONTEXT_EXIST_FOR_THIS_PED
              L8_2 = L4_2[1]
              L9_2 = "Generic_Insult_High"
              L7_2 = L7_2(L8_2, L9_2)
              if L7_2 then
                L7_2 = Insulthigh
                L8_2 = L4_2
                L7_2(L8_2)
              else
                L7_2 = GENERIC_AUDIO
                L7_2 = L7_2.DOES_CONTEXT_EXIST_FOR_THIS_PED
                L8_2 = L4_2[1]
                L9_2 = "GENERIC_WAR_CRY"
                L7_2 = L7_2(L8_2, L9_2)
                if L7_2 then
                  L7_2 = Warcry
                  L8_2 = L4_2
                  L7_2(L8_2)
                end
              end
            end
          end
        end
      end
    end
    ::lbl_232::
    L7_2 = request_anim_dict
    L8_2 = "rcmpaparazzo_2"
    L7_2(L8_2)
    L7_2 = request_anim_dict
    L8_2 = "mp_player_int_upperfinger"
    L7_2(L8_2)
    L7_2 = request_anim_dict
    L8_2 = "misscarsteal2peeing"
    L7_2(L8_2)
    L7_2 = request_anim_dict
    L8_2 = "mp_player_int_upperpeace_sign"
    L7_2(L8_2)
    L7_2 = {}
    L8_2 = L4_2[2]
    L9_2 = L4_2[3]
    L10_2 = L4_2[4]
    L11_2 = L4_2[5]
    L12_2 = L4_2[6]
    L13_2 = L4_2[7]
    L14_2 = L4_2[8]
    L7_2[1] = L8_2
    L7_2[2] = L9_2
    L7_2[3] = L10_2
    L7_2[4] = L11_2
    L7_2[5] = L12_2
    L7_2[6] = L13_2
    L7_2[7] = L14_2
    L8_2 = ipairs
    L9_2 = L7_2
    L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2)
    for L12_2, L13_2 in L8_2, L9_2, L10_2, L11_2 do
      L14_2 = util
      L14_2 = L14_2.joaat
      L15_2 = "player_two"
      L14_2 = L14_2(L15_2)
      if L5_2 == L14_2 then
        L14_2 = Runanim
        L15_2 = L13_2
        L16_2 = "misscarsteal2peeing"
        L17_2 = "peeing_loop"
        L14_2(L15_2, L16_2, L17_2)
        L14_2 = PED
        L14_2 = L14_2.GET_PED_BONE_INDEX
        L15_2 = L13_2
        L16_2 = 11816
        L14_2 = L14_2(L15_2, L16_2)
        L15_2 = request_ptfx_asset
        L16_2 = "core"
        L15_2(L16_2)
        L15_2 = GRAPHICS
        L15_2 = L15_2.USE_PARTICLE_FX_ASSET
        L16_2 = "core"
        L15_2(L16_2)
        L15_2 = GRAPHICS
        L16_2 = "START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE"
        L15_2 = L15_2[L16_2]
        L16_2 = "ent_amb_peeing"
        L17_2 = L13_2
        L18_2 = 0
        L19_2 = 0
        L20_2 = 0
        L21_2 = -90
        L22_2 = 0
        L23_2 = 0
        L24_2 = L14_2
        L25_2 = 2
        L26_2 = false
        L27_2 = false
        L28_2 = false
        L29_2 = 0
        L30_2 = 0
        L31_2 = 0
        L32_2 = 0
        L15_2(L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2)
      else
        L14_2 = util
        L14_2 = L14_2.joaat
        L15_2 = "u_m_m_jesus_01"
        L14_2 = L14_2(L15_2)
        if L5_2 == L14_2 then
          L14_2 = Runanim
          L15_2 = L4_2[1]
          L16_2 = "mp_player_int_upperpeace_sign"
          L17_2 = "mp_player_int_peace_sign"
          L14_2(L15_2, L16_2, L17_2)
          L14_2 = Runanim
          L15_2 = L13_2
          L16_2 = "mp_player_int_upperpeace_sign"
          L17_2 = "mp_player_int_peace_sign"
          L14_2(L15_2, L16_2, L17_2)
        else
          L14_2 = Runanim
          L15_2 = L13_2
          L16_2 = "mp_player_int_upperfinger"
          L17_2 = "mp_player_int_finger_02_fp"
          L14_2(L15_2, L16_2, L17_2)
          L14_2 = Runanim
          L15_2 = L4_2[1]
          L16_2 = "rcmpaparazzo_2"
          L17_2 = "shag_loop_a"
          L14_2(L15_2, L16_2, L17_2)
        end
      end
    end
    L8_2 = ipairs
    L9_2 = L4_2
    L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2)
    for L12_2, L13_2 in L8_2, L9_2, L10_2, L11_2 do
      L14_2 = PFP
      L15_2 = L13_2
      L16_2 = L1_2
      L14_2(L15_2, L16_2)
    end
    L8_2 = ped_cage_table
    L8_2[A0_2] = L4_2
  end
  while true do
    L4_2 = ped_cage_table
    L4_2 = L4_2[A0_2]
    if not L4_2 then
      break
    end
    L4_2 = players
    L4_2 = L4_2.exists
    L5_2 = A0_2
    L4_2 = L4_2(L5_2)
    if L4_2 then
      L4_2 = IPM
      L5_2 = L1_2
      L6_2 = L2_2
      L7_2 = L3_2
      L8_2 = ped_cage_table
      L9_2 = A0_2
      L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
    end
  end
end
L33_1[L34_1] = L35_1
L33_1 = "prop_mineshaft_door"
L34_1 = _ENV
L35_1 = "select_obj_cage"
function L36_1(A0_2)
  local L1_2
  L1_2 = objsetcage
  L1_2 = L1_2[A0_2]
  L33_1 = L1_2
end
L34_1[L35_1] = L36_1
L34_1 = _ENV
L35_1 = "ObjFrezSpawn"
function L36_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L2_2 = A0_2
  L3_2 = OBJECT
  L3_2 = L3_2.CREATE_OBJECT
  L4_2 = L2_2
  L5_2 = A1_2.x
  L6_2 = A1_2.y
  L7_2 = A1_2.z
  L8_2 = true
  L9_2 = true
  L10_2 = true
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L4_2 = ENTITY
  L4_2 = L4_2.FREEZE_ENTITY_POSITION
  L5_2 = L3_2
  L6_2 = true
  L4_2(L5_2, L6_2)
  return L3_2
end
L34_1[L35_1] = L36_1
L34_1 = _ENV
L35_1 = "SetObjCo"
function L36_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L4_2 = ENTITY
  L4_2 = L4_2.SET_ENTITY_COORDS
  L5_2 = A0_2
  L6_2 = A1_2
  L7_2 = A2_2
  L8_2 = A3_2
  L9_2 = false
  L10_2 = true
  L11_2 = true
  L12_2 = false
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
end
L34_1[L35_1] = L36_1
L34_1 = _ENV
L35_1 = "auto_obj_cage"
function L36_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED_SCRIPT_INDEX
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = L1_2
  L4_2 = true
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = PLAYER
  L3_2 = L3_2.GET_PLAYER_NAME
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = obj_table
  L4_2 = L4_2[A0_2]
  if not L4_2 then
    L4_2 = {}
    L5_2 = menu
    L5_2 = L5_2.get_value
    L6_2 = menu
    L6_2 = L6_2.ref_by_rel_path
    L7_2 = menu
    L7_2 = L7_2.player_root
    L8_2 = A0_2
    L7_2 = L7_2(L8_2)
    L8_2 = "Spectate>Nuts Method"
    L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2 = L6_2(L7_2, L8_2)
    L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
    L6_2 = Delcar
    L7_2 = L1_2
    L8_2 = L5_2
    L9_2 = A0_2
    L6_2(L7_2, L8_2, L9_2)
    L6_2 = util
    L6_2 = L6_2.joaat
    L7_2 = L33_1
    L6_2 = L6_2(L7_2)
    L7_2 = request_model
    L8_2 = L6_2
    L7_2(L8_2)
    L7_2 = {}
    L8_2 = "o1"
    L9_2 = "o2"
    L10_2 = "o3"
    L11_2 = "o4"
    L12_2 = "o5"
    L13_2 = "o6"
    L14_2 = "o7"
    L15_2 = "o8"
    L7_2[1] = L8_2
    L7_2[2] = L9_2
    L7_2[3] = L10_2
    L7_2[4] = L11_2
    L7_2[5] = L12_2
    L7_2[6] = L13_2
    L7_2[7] = L14_2
    L7_2[8] = L15_2
    L8_2 = ipairs
    L9_2 = L7_2
    L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2)
    for L12_2, L13_2 in L8_2, L9_2, L10_2, L11_2 do
      L14_2 = ObjFrezSpawn
      L15_2 = L6_2
      L16_2 = L2_2
      L14_2 = L14_2(L15_2, L16_2)
      L13_2 = L14_2
      L14_2 = table
      L14_2 = L14_2.insert
      L15_2 = L4_2
      L16_2 = L13_2
      L14_2(L15_2, L16_2)
    end
    L8_2 = obj_table
    L8_2[A0_2] = L4_2
    L8_2 = SetObjCo
    L9_2 = L4_2[1]
    L10_2 = L2_2.x
    L11_2 = L2_2.y
    L11_2 = L11_2 - 0.5
    L12_2 = L2_2.z
    L12_2 = L12_2 - 1.0
    L8_2(L9_2, L10_2, L11_2, L12_2)
    L8_2 = SetObjCo
    L9_2 = L4_2[2]
    L10_2 = L2_2.x
    L10_2 = L10_2 - 0.5
    L11_2 = L2_2.y
    L11_2 = L11_2 - 0.5
    L12_2 = L2_2.z
    L12_2 = L12_2 - 1.0
    L8_2(L9_2, L10_2, L11_2, L12_2)
    L8_2 = SetObjCo
    L9_2 = L4_2[3]
    L10_2 = L2_2.x
    L10_2 = L10_2 - 0.5
    L11_2 = L2_2.y
    L12_2 = L2_2.z
    L12_2 = L12_2 - 1.0
    L8_2(L9_2, L10_2, L11_2, L12_2)
    L8_2 = SetObjCo
    L9_2 = L4_2[4]
    L10_2 = L2_2.x
    L10_2 = L10_2 - 0.5
    L11_2 = L2_2.y
    L11_2 = L11_2 + 0.5
    L12_2 = L2_2.z
    L12_2 = L12_2 - 1.0
    L8_2(L9_2, L10_2, L11_2, L12_2)
    L8_2 = SetObjCo
    L9_2 = L4_2[5]
    L10_2 = L2_2.x
    L11_2 = L2_2.y
    L11_2 = L11_2 + 0.5
    L12_2 = L2_2.z
    L12_2 = L12_2 - 1.0
    L8_2(L9_2, L10_2, L11_2, L12_2)
    L8_2 = SetObjCo
    L9_2 = L4_2[6]
    L10_2 = L2_2.x
    L10_2 = L10_2 + 0.5
    L11_2 = L2_2.y
    L11_2 = L11_2 + 0.5
    L12_2 = L2_2.z
    L12_2 = L12_2 - 1.0
    L8_2(L9_2, L10_2, L11_2, L12_2)
    L8_2 = SetObjCo
    L9_2 = L4_2[7]
    L10_2 = L2_2.x
    L10_2 = L10_2 + 0.5
    L11_2 = L2_2.y
    L12_2 = L2_2.z
    L12_2 = L12_2 - 1.0
    L8_2(L9_2, L10_2, L11_2, L12_2)
    L8_2 = SetObjCo
    L9_2 = L4_2[8]
    L10_2 = L2_2.x
    L10_2 = L10_2 + 0.5
    L11_2 = L2_2.y
    L11_2 = L11_2 - 0.5
    L12_2 = L2_2.z
    L12_2 = L12_2 - 1.0
    L8_2(L9_2, L10_2, L11_2, L12_2)
    L8_2 = ENTITY
    L8_2 = L8_2.SET_ENTITY_ROTATION
    L9_2 = L4_2[1]
    L10_2 = 0
    L11_2 = 0
    L12_2 = 180
    L13_2 = 1
    L14_2 = true
    L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    L8_2 = ENTITY
    L8_2 = L8_2.SET_ENTITY_ROTATION
    L9_2 = L4_2[2]
    L10_2 = 0
    L11_2 = 0
    L12_2 = 135
    L13_2 = 1
    L14_2 = true
    L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    L8_2 = ENTITY
    L8_2 = L8_2.SET_ENTITY_ROTATION
    L9_2 = L4_2[3]
    L10_2 = 0
    L11_2 = 0
    L12_2 = 90
    L13_2 = 1
    L14_2 = true
    L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    L8_2 = ENTITY
    L8_2 = L8_2.SET_ENTITY_ROTATION
    L9_2 = L4_2[4]
    L10_2 = 0
    L11_2 = 0
    L12_2 = 45
    L13_2 = 1
    L14_2 = true
    L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    L8_2 = ENTITY
    L8_2 = L8_2.SET_ENTITY_ROTATION
    L9_2 = L4_2[6]
    L10_2 = 0
    L11_2 = 0
    L12_2 = 315
    L13_2 = 1
    L14_2 = true
    L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    L8_2 = ENTITY
    L8_2 = L8_2.SET_ENTITY_ROTATION
    L9_2 = L4_2[7]
    L10_2 = 0
    L11_2 = 0
    L12_2 = 270
    L13_2 = 1
    L14_2 = true
    L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    L8_2 = ENTITY
    L8_2 = L8_2.SET_ENTITY_ROTATION
    L9_2 = L4_2[8]
    L10_2 = 0
    L11_2 = 0
    L12_2 = 225
    L13_2 = 1
    L14_2 = true
    L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    L8_2 = ipairs
    L9_2 = L4_2
    L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2)
    for L12_2, L13_2 in L8_2, L9_2, L10_2, L11_2 do
      L14_2 = AUDIO
      L14_2 = L14_2.PLAY_SOUND_FROM_ENTITY
      L15_2 = -1
      L16_2 = "Alarm_Interior"
      L17_2 = L13_2
      L18_2 = "DLC_H3_FM_FIB_Raid_Sounds"
      L19_2 = 0
      L20_2 = 0
      L14_2(L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
    end
  end
  while true do
    L4_2 = obj_table
    L4_2 = L4_2[A0_2]
    if not L4_2 then
      break
    end
    L4_2 = players
    L4_2 = L4_2.exists
    L5_2 = A0_2
    L4_2 = L4_2(L5_2)
    if L4_2 then
      L4_2 = IPM
      L5_2 = L1_2
      L6_2 = L2_2
      L7_2 = L3_2
      L8_2 = obj_table
      L9_2 = A0_2
      L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
    end
  end
end
L34_1[L35_1] = L36_1
L34_1 = _ENV
L35_1 = "change_ammo_effect"
function L36_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L2_2 = A0_2 - 2
  explosion_id = L2_2
  L2_2 = v3
  L2_2 = L2_2.new
  L2_2 = L2_2()
  while true do
    L3_2 = players
    L3_2 = L3_2.exists
    L4_2 = A1_2
    L3_2 = L3_2(L4_2)
    if not L3_2 then
      break
    end
    L3_2 = explosion_id
    if -1 == L3_2 then
      break
    end
    L3_2 = WEAPON
    L3_2 = L3_2.GET_PED_LAST_WEAPON_IMPACT_COORD
    L4_2 = PLAYER
    L4_2 = L4_2.GET_PLAYER_PED
    L5_2 = A1_2
    L4_2 = L4_2(L5_2)
    L5_2 = L2_2
    L3_2 = L3_2(L4_2, L5_2)
    if L3_2 then
      L3_2 = v3
      L3_2 = L3_2.get
      L4_2 = L2_2
      L3_2, L4_2, L5_2 = L3_2(L4_2)
      L6_2 = FIRE
      L6_2 = L6_2.ADD_OWNED_EXPLOSION
      L7_2 = PLAYER
      L7_2 = L7_2.GET_PLAYER_PED
      L8_2 = A1_2
      L7_2 = L7_2(L8_2)
      L8_2 = L3_2
      L9_2 = L4_2
      L10_2 = L5_2
      L11_2 = explosion_id
      L12_2 = 1.0
      L13_2 = true
      L14_2 = false
      L15_2 = 0
      L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
    end
    L3_2 = util
    L3_2 = L3_2.yield
    L3_2()
  end
end
L34_1[L35_1] = L36_1
L34_1 = _ENV
L35_1 = "escort"
function L36_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2
  L0_2 = ENTITY
  L0_2 = L0_2.GET_ENTITY_HEADING
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2)
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "Lazer"
  L1_2 = L1_2(L2_2)
  L2_2 = 1082797888
  L3_2 = request_model
  L4_2 = L1_2
  L3_2(L4_2)
  L3_2 = request_model
  L4_2 = L2_2
  L3_2(L4_2)
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2 = L3_2()
  L4_2 = ENTITY
  L4_2 = L4_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L5_2 = L3_2
  L6_2 = 0
  L7_2 = 0
  L8_2 = 200
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  L5_2 = ENTITY
  L5_2 = L5_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L6_2 = L3_2
  L7_2 = -50
  L8_2 = -50
  L9_2 = 200
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
  L6_2 = ENTITY
  L6_2 = L6_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L7_2 = L3_2
  L8_2 = 50
  L9_2 = -50
  L10_2 = 200
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
  L7_2 = ENTITY
  L7_2 = L7_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L8_2 = L3_2
  L9_2 = -50
  L10_2 = -100
  L11_2 = 200
  L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2)
  L8_2 = ENTITY
  L8_2 = L8_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L9_2 = L3_2
  L10_2 = 50
  L11_2 = -100
  L12_2 = 200
  L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2)
  L9_2 = ENTITY
  L9_2 = L9_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L10_2 = L3_2
  L11_2 = -20
  L12_2 = 0
  L13_2 = 0
  L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2)
  L10_2 = ENTITY
  L10_2 = L10_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L11_2 = L3_2
  L12_2 = 20
  L13_2 = 0
  L14_2 = 0
  L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2)
  L11_2 = ENTITY
  L11_2 = L11_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L12_2 = L3_2
  L13_2 = -40
  L14_2 = -40
  L15_2 = 0
  L11_2 = L11_2(L12_2, L13_2, L14_2, L15_2)
  L12_2 = ENTITY
  L12_2 = L12_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L13_2 = L3_2
  L14_2 = 40
  L15_2 = -40
  L16_2 = 0
  L12_2 = L12_2(L13_2, L14_2, L15_2, L16_2)
  L13_2 = PED
  L13_2 = L13_2.IS_PED_IN_ANY_VEHICLE
  L14_2 = PLAYER
  L14_2 = L14_2.PLAYER_PED_ID
  L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2 = L14_2()
  L13_2 = L13_2(L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2)
  if not L13_2 then
    L13_2 = entities
    L13_2 = L13_2.create_vehicle
    L14_2 = L1_2
    L15_2 = L4_2
    L16_2 = L0_2
    L13_2 = L13_2(L14_2, L15_2, L16_2)
    PlayerJet = L13_2
    L13_2 = entities
    L13_2 = L13_2.create_object
    L14_2 = L2_2
    L15_2 = L9_2
    L13_2 = L13_2(L14_2, L15_2)
    aTarget = L13_2
    L13_2 = entities
    L13_2 = L13_2.create_object
    L14_2 = L2_2
    L15_2 = L10_2
    L13_2 = L13_2(L14_2, L15_2)
    bTarget = L13_2
    L13_2 = entities
    L13_2 = L13_2.create_object
    L14_2 = L2_2
    L15_2 = L11_2
    L13_2 = L13_2(L14_2, L15_2)
    cTarget = L13_2
    L13_2 = entities
    L13_2 = L13_2.create_object
    L14_2 = L2_2
    L15_2 = L12_2
    L13_2 = L13_2(L14_2, L15_2)
    dTarget = L13_2
    L13_2 = ENTITY
    L13_2 = L13_2.SET_ENTITY_COLLISION
    L14_2 = aTarget
    L15_2 = false
    L16_2 = false
    L13_2(L14_2, L15_2, L16_2)
    L13_2 = ENTITY
    L13_2 = L13_2.SET_ENTITY_VISIBLE
    L14_2 = aTarget
    L15_2 = false
    L16_2 = false
    L13_2(L14_2, L15_2, L16_2)
    L13_2 = ENTITY
    L13_2 = L13_2.SET_ENTITY_COLLISION
    L14_2 = bTarget
    L15_2 = false
    L16_2 = false
    L13_2(L14_2, L15_2, L16_2)
    L13_2 = ENTITY
    L13_2 = L13_2.SET_ENTITY_VISIBLE
    L14_2 = bTarget
    L15_2 = false
    L16_2 = false
    L13_2(L14_2, L15_2, L16_2)
    L13_2 = ENTITY
    L13_2 = L13_2.SET_ENTITY_COLLISION
    L14_2 = cTarget
    L15_2 = false
    L16_2 = false
    L13_2(L14_2, L15_2, L16_2)
    L13_2 = ENTITY
    L13_2 = L13_2.SET_ENTITY_VISIBLE
    L14_2 = cTarget
    L15_2 = false
    L16_2 = false
    L13_2(L14_2, L15_2, L16_2)
    L13_2 = ENTITY
    L13_2 = L13_2.SET_ENTITY_COLLISION
    L14_2 = dTarget
    L15_2 = false
    L16_2 = false
    L13_2(L14_2, L15_2, L16_2)
    L13_2 = ENTITY
    L13_2 = L13_2.SET_ENTITY_VISIBLE
    L14_2 = dTarget
    L15_2 = false
    L16_2 = false
    L13_2(L14_2, L15_2, L16_2)
    L13_2 = PED
    L13_2 = L13_2.SET_PED_INTO_VEHICLE
    L14_2 = L3_2
    L15_2 = PlayerJet
    L16_2 = -1
    L13_2(L14_2, L15_2, L16_2)
    L13_2 = VEHICLE
    L13_2 = L13_2.CONTROL_LANDING_GEAR
    L14_2 = PlayerJet
    L15_2 = 3
    L13_2(L14_2, L15_2)
    L13_2 = ENTITY
    L13_2 = L13_2.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
    L14_2 = PlayerJet
    L15_2 = 1
    L16_2 = 0
    L17_2 = 100
    L18_2 = 0
    L19_2 = true
    L20_2 = true
    L21_2 = true
    L22_2 = true
    L13_2(L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
    L13_2 = entities
    L13_2 = L13_2.create_vehicle
    L14_2 = L1_2
    L15_2 = L5_2
    L16_2 = L0_2
    L13_2 = L13_2(L14_2, L15_2, L16_2)
    JetA = L13_2
    L13_2 = entities
    L13_2 = L13_2.create_vehicle
    L14_2 = L1_2
    L15_2 = L6_2
    L16_2 = L0_2
    L13_2 = L13_2(L14_2, L15_2, L16_2)
    JetB = L13_2
    L13_2 = entities
    L13_2 = L13_2.create_vehicle
    L14_2 = L1_2
    L15_2 = L7_2
    L16_2 = L0_2
    L13_2 = L13_2(L14_2, L15_2, L16_2)
    JetC = L13_2
    L13_2 = entities
    L13_2 = L13_2.create_vehicle
    L14_2 = L1_2
    L15_2 = L8_2
    L16_2 = L0_2
    L13_2 = L13_2(L14_2, L15_2, L16_2)
    JetD = L13_2
    L13_2 = PED
    L13_2 = L13_2.CREATE_RANDOM_PED_AS_DRIVER
    L14_2 = JetA
    L15_2 = 1
    L13_2 = L13_2(L14_2, L15_2)
    PilotA = L13_2
    L13_2 = VEHICLE
    L13_2 = L13_2.SET_VEHICLE_ENGINE_ON
    L14_2 = JetA
    L15_2 = true
    L16_2 = true
    L17_2 = 0
    L13_2(L14_2, L15_2, L16_2, L17_2)
    L13_2 = PED
    L13_2 = L13_2.CREATE_RANDOM_PED_AS_DRIVER
    L14_2 = JetB
    L15_2 = 1
    L13_2 = L13_2(L14_2, L15_2)
    PilotB = L13_2
    L13_2 = VEHICLE
    L13_2 = L13_2.SET_VEHICLE_ENGINE_ON
    L14_2 = JetB
    L15_2 = true
    L16_2 = true
    L17_2 = 0
    L13_2(L14_2, L15_2, L16_2, L17_2)
    L13_2 = PED
    L13_2 = L13_2.CREATE_RANDOM_PED_AS_DRIVER
    L14_2 = JetC
    L15_2 = 1
    L13_2 = L13_2(L14_2, L15_2)
    PilotC = L13_2
    L13_2 = VEHICLE
    L13_2 = L13_2.SET_VEHICLE_ENGINE_ON
    L14_2 = JetC
    L15_2 = true
    L16_2 = true
    L17_2 = 0
    L13_2(L14_2, L15_2, L16_2, L17_2)
    L13_2 = PED
    L13_2 = L13_2.CREATE_RANDOM_PED_AS_DRIVER
    L14_2 = JetD
    L15_2 = 1
    L13_2 = L13_2(L14_2, L15_2)
    PilotD = L13_2
    L13_2 = VEHICLE
    L13_2 = L13_2.SET_VEHICLE_ENGINE_ON
    L14_2 = JetD
    L15_2 = true
    L16_2 = true
    L17_2 = 0
    L13_2(L14_2, L15_2, L16_2, L17_2)
    L13_2 = join_group
    L14_2 = PilotA
    L13_2(L14_2)
    L13_2 = join_group
    L14_2 = PilotB
    L13_2(L14_2)
    L13_2 = join_group
    L14_2 = PilotC
    L13_2(L14_2)
    L13_2 = join_group
    L14_2 = PilotD
    L13_2(L14_2)
    L13_2 = ENTITY
    L13_2 = L13_2.SET_ENTITY_INVINCIBLE
    L14_2 = PlayerJet
    L15_2 = true
    L13_2(L14_2, L15_2)
    L13_2 = ENTITY
    L13_2 = L13_2.SET_ENTITY_INVINCIBLE
    L14_2 = JetA
    L15_2 = true
    L13_2(L14_2, L15_2)
    L13_2 = ENTITY
    L13_2 = L13_2.SET_ENTITY_INVINCIBLE
    L14_2 = JetB
    L15_2 = true
    L13_2(L14_2, L15_2)
    L13_2 = ENTITY
    L13_2 = L13_2.SET_ENTITY_INVINCIBLE
    L14_2 = JetC
    L15_2 = true
    L13_2(L14_2, L15_2)
    L13_2 = ENTITY
    L13_2 = L13_2.SET_ENTITY_INVINCIBLE
    L14_2 = JetD
    L15_2 = true
    L13_2(L14_2, L15_2)
  end
  L13_2 = set_entity_face_entity
  L14_2 = JetA
  L15_2 = aTarget
  L16_2 = true
  L13_2(L14_2, L15_2, L16_2)
  L13_2 = set_entity_face_entity
  L14_2 = JetB
  L15_2 = bTarget
  L16_2 = true
  L13_2(L14_2, L15_2, L16_2)
  L13_2 = set_entity_face_entity
  L14_2 = JetC
  L15_2 = cTarget
  L16_2 = true
  L13_2(L14_2, L15_2, L16_2)
  L13_2 = set_entity_face_entity
  L14_2 = JetD
  L15_2 = dTarget
  L16_2 = true
  L13_2(L14_2, L15_2, L16_2)
  L13_2 = ENTITY
  L13_2 = L13_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L14_2 = JetA
  L15_2 = 0
  L16_2 = 0
  L17_2 = 0
  L13_2 = L13_2(L14_2, L15_2, L16_2, L17_2)
  L14_2 = ENTITY
  L14_2 = L14_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L15_2 = JetB
  L16_2 = 0
  L17_2 = 0
  L18_2 = 0
  L14_2 = L14_2(L15_2, L16_2, L17_2, L18_2)
  L15_2 = ENTITY
  L15_2 = L15_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L16_2 = JetC
  L17_2 = 0
  L18_2 = 0
  L19_2 = 0
  L15_2 = L15_2(L16_2, L17_2, L18_2, L19_2)
  L16_2 = ENTITY
  L16_2 = L16_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L17_2 = JetD
  L18_2 = 0
  L19_2 = 0
  L20_2 = 0
  L16_2 = L16_2(L17_2, L18_2, L19_2, L20_2)
  L17_2 = MISC
  L17_2 = L17_2.GET_DISTANCE_BETWEEN_COORDS
  L18_2 = L13_2.x
  L19_2 = L13_2.y
  L20_2 = L13_2.z
  L21_2 = L9_2.x
  L22_2 = L9_2.y
  L23_2 = L9_2.z
  L24_2 = true
  L17_2 = L17_2(L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
  L18_2 = MISC
  L18_2 = L18_2.GET_DISTANCE_BETWEEN_COORDS
  L19_2 = L14_2.x
  L20_2 = L14_2.y
  L21_2 = L14_2.z
  L22_2 = L10_2.x
  L23_2 = L10_2.y
  L24_2 = L10_2.z
  L25_2 = true
  L18_2 = L18_2(L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
  L19_2 = MISC
  L19_2 = L19_2.GET_DISTANCE_BETWEEN_COORDS
  L20_2 = L15_2.x
  L21_2 = L15_2.y
  L22_2 = L15_2.z
  L23_2 = L11_2.x
  L24_2 = L11_2.y
  L25_2 = L11_2.z
  L26_2 = true
  L19_2 = L19_2(L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
  L20_2 = MISC
  L20_2 = L20_2.GET_DISTANCE_BETWEEN_COORDS
  L21_2 = L16_2.x
  L22_2 = L16_2.y
  L23_2 = L16_2.z
  L24_2 = L12_2.x
  L25_2 = L12_2.y
  L26_2 = L12_2.z
  L27_2 = true
  L20_2 = L20_2(L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2)
  if L17_2 < 40 then
    aJetSpeed = -0.8
  else
    aJetSpeed = 0.5
  end
  if L18_2 < 40 then
    bJetSpeed = -0.8
  else
    bJetSpeed = 0.5
  end
  if L19_2 < 40 then
    cJetSpeed = -0.8
  else
    cJetSpeed = 0.5
  end
  if L20_2 < 40 then
    dJetSpeed = -0.8
  else
    dJetSpeed = 0.5
  end
  L21_2 = PED
  L21_2 = L21_2.IS_PED_ON_FOOT
  L22_2 = L3_2
  L21_2 = L21_2(L22_2)
  if not L21_2 then
    L21_2 = ENTITY
    L21_2 = L21_2.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
    L22_2 = JetA
    L23_2 = 1
    L24_2 = 0
    L25_2 = aJetSpeed
    L26_2 = 0
    L27_2 = true
    L28_2 = true
    L29_2 = true
    L30_2 = true
    L21_2(L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2)
    L21_2 = ENTITY
    L21_2 = L21_2.SET_ENTITY_COORDS_NO_OFFSET
    L22_2 = aTarget
    L23_2 = L9_2.x
    L24_2 = L9_2.y
    L25_2 = L9_2.z
    L26_2 = false
    L27_2 = false
    L28_2 = false
    L21_2(L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2)
    L21_2 = ENTITY
    L21_2 = L21_2.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
    L22_2 = JetB
    L23_2 = 1
    L24_2 = 0
    L25_2 = bJetSpeed
    L26_2 = 0
    L27_2 = true
    L28_2 = true
    L29_2 = true
    L30_2 = true
    L21_2(L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2)
    L21_2 = ENTITY
    L21_2 = L21_2.SET_ENTITY_COORDS_NO_OFFSET
    L22_2 = bTarget
    L23_2 = L10_2.x
    L24_2 = L10_2.y
    L25_2 = L10_2.z
    L26_2 = false
    L27_2 = false
    L28_2 = false
    L21_2(L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2)
    L21_2 = ENTITY
    L21_2 = L21_2.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
    L22_2 = JetC
    L23_2 = 1
    L24_2 = 0
    L25_2 = cJetSpeed
    L26_2 = 0
    L27_2 = true
    L28_2 = true
    L29_2 = true
    L30_2 = true
    L21_2(L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2)
    L21_2 = ENTITY
    L21_2 = L21_2.SET_ENTITY_COORDS_NO_OFFSET
    L22_2 = cTarget
    L23_2 = L11_2.x
    L24_2 = L11_2.y
    L25_2 = L11_2.z
    L26_2 = false
    L27_2 = false
    L28_2 = false
    L21_2(L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2)
    L21_2 = ENTITY
    L21_2 = L21_2.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
    L22_2 = JetD
    L23_2 = 1
    L24_2 = 0
    L25_2 = dJetSpeed
    L26_2 = 0
    L27_2 = true
    L28_2 = true
    L29_2 = true
    L30_2 = true
    L21_2(L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2)
    L21_2 = ENTITY
    L21_2 = L21_2.SET_ENTITY_COORDS_NO_OFFSET
    L22_2 = dTarget
    L23_2 = L12_2.x
    L24_2 = L12_2.y
    L25_2 = L12_2.z
    L26_2 = false
    L27_2 = false
    L28_2 = false
    L21_2(L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2)
  end
end
L34_1[L35_1] = L36_1
L34_1 = _ENV
L35_1 = "firefighting"
function L36_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  L1_2 = {}
  L2_2 = 1
  L3_2 = 11
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = players
    L6_2 = L6_2.get_position
    L7_2 = A0_2
    L6_2 = L6_2(L7_2)
    L7_2 = #L1_2
    L7_2 = L7_2 + 1
    L8_2 = entities
    L8_2 = L8_2.create_object
    L9_2 = 200846641
    L10_2 = v3
    L10_2 = L10_2.new
    L11_2 = L6_2.x
    L12_2 = math
    L12_2 = L12_2.random
    L13_2 = -5
    L14_2 = 5
    L12_2 = L12_2(L13_2, L14_2)
    L11_2 = L11_2 + L12_2
    L12_2 = L6_2.y
    L13_2 = math
    L13_2 = L13_2.random
    L14_2 = -5
    L15_2 = 5
    L13_2 = L13_2(L14_2, L15_2)
    L12_2 = L12_2 + L13_2
    L13_2 = L6_2.z
    L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L10_2(L11_2, L12_2, L13_2)
    L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L1_2[L7_2] = L8_2
    L7_2 = util
    L7_2 = L7_2.yield
    L7_2()
  end
  L2_2 = util
  L2_2 = L2_2.yield
  L3_2 = 500
  L2_2(L3_2)
  L2_2 = ipairs
  L3_2 = L1_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = ENTITY
    L8_2 = L8_2.GET_ENTITY_COORDS
    L9_2 = L7_2
    L8_2 = L8_2(L9_2)
    L9_2 = FIRE
    L9_2 = L9_2.ADD_EXPLOSION
    L10_2 = L8_2.x
    L11_2 = L8_2.y
    L12_2 = L8_2.z
    L13_2 = 64
    L14_2 = 100
    L15_2 = true
    L16_2 = true
    L17_2 = 0.5
    L18_2 = true
    L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  end
  L2_2 = util
  L2_2 = L2_2.yield
  L3_2 = 13000
  L2_2(L3_2)
  L2_2 = 1
  L3_2 = #L1_2
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = delete_entity
    L7_2 = L1_2[L5_2]
    L6_2(L7_2)
  end
end
L34_1[L35_1] = L36_1
L34_1 = _ENV
L35_1 = "intToIp"
function L36_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  ip = ""
  L1_2 = string
  L1_2 = L1_2.format
  L2_2 = "%x"
  L3_2 = A0_2
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = 1
  L3_2 = #L1_2
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = math
    L6_2 = L6_2.fmod
    L7_2 = L5_2
    L8_2 = 2
    L6_2 = L6_2(L7_2, L8_2)
    if 0 == L6_2 then
      L6_2 = ip
      if "" ~= L6_2 then
        L6_2 = ip
        L7_2 = "."
        L8_2 = var_int
        L6_2 = L6_2 .. L7_2 .. L8_2
        ip = L6_2
      else
        L6_2 = var_int
        ip = L6_2
      end
    else
      L6_2 = tostring
      L7_2 = tonumber
      L8_2 = string
      L8_2 = L8_2.sub
      L9_2 = L1_2
      L10_2 = L5_2
      L11_2 = L5_2 + 1
      L8_2 = L8_2(L9_2, L10_2, L11_2)
      L9_2 = 16
      L7_2, L8_2, L9_2, L10_2, L11_2 = L7_2(L8_2, L9_2)
      L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
      var_int = L6_2
    end
  end
  L2_2 = ip
  return L2_2
end
L34_1[L35_1] = L36_1
L34_1 = 5
L35_1 = 100
L36_1 = {}
L37_1 = "r"
L36_1[L37_1] = 0
L37_1 = "g"
L36_1[L37_1] = 0
L37_1 = "b"
L38_1 = 1
L36_1[L37_1] = L38_1
L37_1 = "a"
L36_1[L37_1] = 0
L37_1 = _ENV
L38_1 = "graffiti_bright"
function L39_1(A0_2)
  local L1_2
  L35_1 = A0_2
end
L37_1[L38_1] = L39_1
L37_1 = _ENV
L38_1 = "graffiti_radiu"
function L39_1(A0_2)
  local L1_2
  L34_1 = A0_2
end
L37_1[L38_1] = L39_1
L37_1 = _ENV
L38_1 = "graffiti_color"
function L39_1(A0_2)
  local L1_2
  L36_1 = A0_2
end
L37_1[L38_1] = L39_1
L37_1 = _ENV
L38_1 = "Graffiti_weapon"
function L39_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  Graffiti = A0_2
  L1_2 = {}
  while true do
    L2_2 = Graffiti
    if not L2_2 then
      break
    end
    L2_2 = v3
    L2_2 = L2_2.new
    L2_2 = L2_2()
    L3_2 = WEAPON
    L3_2 = L3_2.GET_PED_LAST_WEAPON_IMPACT_COORD
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2 = L4_2()
    L5_2 = L2_2
    L3_2 = L3_2(L4_2, L5_2)
    if L3_2 then
      L3_2 = PED
      L3_2 = L3_2.IS_PED_IN_ANY_VEHICLE
      L4_2 = PLAYER
      L4_2 = L4_2.PLAYER_PED_ID
      L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L4_2()
      L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
      if not L3_2 then
        L3_2 = #L1_2
        L3_2 = L3_2 + 1
        L1_2[L3_2] = L2_2
      end
    end
    L3_2 = 1
    L4_2 = #L1_2
    L5_2 = 1
    for L6_2 = L3_2, L4_2, L5_2 do
      L7_2 = GRAPHICS
      L7_2 = L7_2.DRAW_LIGHT_WITH_RANGE
      L8_2 = L1_2[L6_2]
      L8_2 = L8_2.x
      L9_2 = L1_2[L6_2]
      L9_2 = L9_2.y
      L10_2 = L1_2[L6_2]
      L10_2 = L10_2.z
      L11_2 = L36_1.r
      L11_2 = L11_2 * 255
      L12_2 = L36_1.g
      L12_2 = L12_2 * 255
      L13_2 = L36_1.b
      L13_2 = L13_2 * 255
      L14_2 = L34_1
      L14_2 = L14_2 / 10
      L15_2 = L35_1
      L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
    end
    L3_2 = util
    L3_2 = L3_2.yield
    L3_2()
  end
end
L37_1[L38_1] = L39_1
L37_1 = _ENV
L38_1 = "Shark_gun"
function L39_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L0_2 = v3
  L0_2 = L0_2.new
  L0_2 = L0_2()
  L1_2 = WEAPON
  L1_2 = L1_2.GET_PED_LAST_WEAPON_IMPACT_COORD
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = L0_2
  L1_2 = L1_2(L2_2, L3_2)
  if L1_2 then
    L1_2 = 113504370
    L2_2 = create_ped
    L3_2 = 26
    L4_2 = L1_2
    L5_2 = L0_2.x
    L6_2 = L0_2.y
    L7_2 = L0_2.z
    L8_2 = 0
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
    L3_2 = ENTITY
    L3_2 = L3_2.FREEZE_ENTITY_POSITION
    L4_2 = L2_2
    L5_2 = true
    L3_2(L4_2, L5_2)
    L3_2 = ENTITY
    L3_2 = L3_2.SET_ENTITY_ROTATION
    L4_2 = L2_2
    L5_2 = 90
    L6_2 = 0
    L7_2 = 0
    L8_2 = 1
    L9_2 = true
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    L3_2 = FIRE
    L3_2 = L3_2.ADD_EXPLOSION
    L4_2 = L0_2.x
    L5_2 = L0_2.y
    L6_2 = L0_2.z
    L7_2 = 4
    L8_2 = 100
    L9_2 = true
    L10_2 = false
    L11_2 = 1
    L12_2 = false
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
    L3_2 = FIRE
    L3_2 = L3_2.ADD_EXPLOSION
    L4_2 = L0_2.x
    L5_2 = L0_2.y
    L6_2 = L0_2.z
    L7_2 = 13
    L8_2 = 1
    L9_2 = true
    L10_2 = false
    L11_2 = 0
    L12_2 = false
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  end
end
L37_1[L38_1] = L39_1
L37_1 = _ENV
L38_1 = "Shark_eating"
function L39_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_COORDS
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED
  L3_2 = A0_2
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L2_2(L3_2)
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L2_2 = 113504370
  L3_2 = create_ped
  L4_2 = 26
  L5_2 = L2_2
  L6_2 = L1_2.x
  L7_2 = L1_2.y
  L8_2 = L1_2.z
  L9_2 = 0
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = ENTITY
  L4_2 = L4_2.FREEZE_ENTITY_POSITION
  L5_2 = L3_2
  L6_2 = true
  L4_2(L5_2, L6_2)
  L4_2 = ENTITY
  L4_2 = L4_2.SET_ENTITY_ROTATION
  L5_2 = L3_2
  L6_2 = 90
  L7_2 = 0
  L8_2 = 0
  L9_2 = 1
  L10_2 = true
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L4_2 = FIRE
  L4_2 = L4_2.ADD_EXPLOSION
  L5_2 = L1_2.x
  L6_2 = L1_2.y
  L7_2 = L1_2.z
  L8_2 = 4
  L9_2 = 100
  L10_2 = true
  L11_2 = false
  L12_2 = 1
  L13_2 = false
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L4_2 = FIRE
  L4_2 = L4_2.ADD_EXPLOSION
  L5_2 = L1_2.x
  L6_2 = L1_2.y
  L7_2 = L1_2.z
  L8_2 = 13
  L9_2 = 1
  L10_2 = true
  L11_2 = false
  L12_2 = 0
  L13_2 = false
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
end
L37_1[L38_1] = L39_1
L37_1 = _ENV
L38_1 = "NPC_kill"
function L39_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "mp_m_weapexp_01"
  L1_2 = L1_2(L2_2)
  L2_2 = request_model
  L3_2 = L1_2
  L2_2(L3_2)
  L2_2 = 1
  L3_2 = 10
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = ENTITY
    L6_2 = L6_2.GET_ENTITY_COORDS
    L7_2 = PLAYER
    L7_2 = L7_2.GET_PLAYER_PED
    L8_2 = A0_2
    L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L7_2(L8_2)
    L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
    L7_2 = L6_2.x
    L8_2 = math
    L8_2 = L8_2.random
    L9_2 = -20
    L10_2 = 20 + L5_2
    L8_2 = L8_2(L9_2, L10_2)
    L7_2 = L7_2 + L8_2
    L6_2.x = L7_2
    L7_2 = L6_2.y
    L8_2 = math
    L8_2 = L8_2.random
    L9_2 = -20
    L10_2 = 20
    L8_2 = L8_2(L9_2, L10_2)
    L7_2 = L7_2 + L8_2
    L6_2.y = L7_2
    L7_2 = PED
    L7_2 = L7_2.CREATE_PED
    L8_2 = 4
    L9_2 = L1_2
    L10_2 = L6_2.x
    L11_2 = L6_2.y
    L12_2 = L6_2.z
    L13_2 = 1.0
    L14_2 = true
    L15_2 = false
    L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
    L8_2 = WEAPON
    L8_2 = L8_2.GIVE_DELAYED_WEAPON_TO_PED
    L9_2 = L7_2
    L10_2 = 1198256469
    L11_2 = 0
    L12_2 = true
    L8_2(L9_2, L10_2, L11_2, L12_2)
    L8_2 = ENTITY
    L8_2 = L8_2.SET_ENTITY_HEALTH
    L9_2 = L7_2
    L10_2 = 410
    L11_2 = 0
    L8_2(L9_2, L10_2, L11_2)
    L8_2 = PED
    L8_2 = L8_2.SET_PED_COMBAT_ABILITY
    L9_2 = L7_2
    L10_2 = 2
    L8_2(L9_2, L10_2)
    L8_2 = PED
    L8_2 = L8_2.SET_PED_COMBAT_ATTRIBUTES
    L9_2 = L7_2
    L10_2 = 5
    L11_2 = true
    L8_2(L9_2, L10_2, L11_2)
    L8_2 = TASK
    L8_2 = L8_2.TASK_COMBAT_PED
    L9_2 = L7_2
    L10_2 = PLAYER
    L10_2 = L10_2.GET_PLAYER_PED
    L11_2 = A0_2
    L10_2 = L10_2(L11_2)
    L11_2 = 1
    L12_2 = 16
    L8_2(L9_2, L10_2, L11_2, L12_2)
    L8_2 = PED
    L8_2 = L8_2.SET_PED_RELATIONSHIP_GROUP_HASH
    L9_2 = L7_2
    L10_2 = 2229074605
    L8_2(L9_2, L10_2)
    L8_2 = ENTITY
    L8_2 = L8_2.GET_ENTITY_COORDS
    L9_2 = L7_2
    L8_2 = L8_2(L9_2)
    L9_2 = MISC
    L9_2 = L9_2.SHOOT_SINGLE_BULLET_BETWEEN_COORDS
    L10_2 = L8_2.x
    L11_2 = L8_2.y
    L12_2 = L8_2.z
    L13_2 = L8_2.x
    L14_2 = L8_2.y
    L15_2 = L8_2.z
    L15_2 = L15_2 + 0.1
    L16_2 = 0
    L17_2 = 0
    L18_2 = 453432689
    L19_2 = PLAYER
    L19_2 = L19_2.GET_PLAYER_PED
    L20_2 = A0_2
    L19_2 = L19_2(L20_2)
    L20_2 = false
    L21_2 = true
    L22_2 = 100
    L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
    L9_2 = STREAMING
    L9_2 = L9_2.SET_MODEL_AS_NO_LONGER_NEEDED
    L10_2 = L1_2
    L9_2(L10_2)
  end
end
L37_1[L38_1] = L39_1
L37_1 = _ENV
L38_1 = "Remove_dead_body"
function L39_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = ipairs
  L1_2 = entities
  L1_2 = L1_2.get_all_peds_as_handles
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2 = L1_2()
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = ENTITY
    L6_2 = L6_2.IS_ENTITY_DEAD
    L7_2 = L5_2
    L8_2 = true
    L6_2 = L6_2(L7_2, L8_2)
    if L6_2 then
      L6_2 = request_control
      L7_2 = L5_2
      L6_2(L7_2)
      L6_2 = delete_entity
      L7_2 = L5_2
      L6_2(L7_2)
    end
  end
end
L37_1[L38_1] = L39_1
L37_1 = _ENV
L38_1 = "Remove_zombies"
function L39_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = ipairs
  L1_2 = entities
  L1_2 = L1_2.get_all_peds_as_handles
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2 = L1_2()
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = ENTITY
    L6_2 = L6_2.GET_ENTITY_MODEL
    L7_2 = L5_2
    L6_2 = L6_2(L7_2)
    if -1404353274 == L6_2 then
      L6_2 = request_control
      L7_2 = L5_2
      L6_2(L7_2)
      L6_2 = delete_entity
      L7_2 = L5_2
      L6_2(L7_2)
    end
  end
end
L37_1[L38_1] = L39_1
L37_1 = _ENV
L38_1 = "NPC_Ignore_player"
function L39_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = ipairs
  L1_2 = entities
  L1_2 = L1_2.get_all_peds_as_handles
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2 = L1_2()
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = calm_ped
    L7_2 = L5_2
    L8_2 = true
    L6_2(L7_2, L8_2)
  end
  L0_2 = PLAYER
  L0_2 = L0_2.SET_POLICE_IGNORE_PLAYER
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2 = L1_2()
  L2_2 = true
  L0_2(L1_2, L2_2)
  L0_2 = PLAYER
  L0_2 = L0_2.SET_EVERYONE_IGNORE_PLAYER
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2 = L1_2()
  L2_2 = true
  L0_2(L1_2, L2_2)
  L0_2 = PLAYER
  L0_2 = L0_2.SET_PLAYER_CAN_BE_HASSLED_BY_GANGS
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2 = L1_2()
  L2_2 = false
  L0_2(L1_2, L2_2)
  L0_2 = PLAYER
  L0_2 = L0_2.SET_IGNORE_LOW_PRIORITY_SHOCKING_EVENTS
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2 = L1_2()
  L2_2 = true
  L0_2(L1_2, L2_2)
end
L37_1[L38_1] = L39_1
L37_1 = 0
L38_1 = _ENV
L39_1 = "player_disguise_select"
function L40_1(A0_2)
  local L1_2
  L37_1 = A0_2
end
L38_1[L39_1] = L40_1
L38_1 = 0
L39_1 = _ENV
L40_1 = "player_disguise"
function L41_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  disguise_state = A0_2
  L1_2 = disguise_state
  if L1_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.SET_ENTITY_ALPHA
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = 0
    L4_2 = false
    L1_2(L2_2, L3_2, L4_2)
    while true do
      L1_2 = disguise_state
      if not L1_2 then
        goto lbl_116
      end
      L1_2 = disguise_objectt
      L2_2 = L37_1
      if L1_2 ~= L2_2 then
        L1_2 = ENTITY
        L1_2 = L1_2.DOES_ENTITY_EXIST
        L2_2 = L38_1
        L1_2 = L1_2(L2_2)
        if L1_2 then
          L1_2 = delete_entity
          L2_2 = L38_1
          L1_2(L2_2)
        end
      end
      L1_2 = L37_1
      disguise_objectt = L1_2
      L1_2 = util
      L1_2 = L1_2.joaat
      L2_2 = disguise_objects
      L3_2 = disguise_objectt
      L2_2 = L2_2[L3_2]
      L1_2 = L1_2(L2_2)
      object_hash = L1_2
      L1_2 = players
      L1_2 = L1_2.get_position
      L2_2 = PLAYER
      L2_2 = L2_2.PLAYER_ID
      L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L2_2()
      L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
      player_pos = L1_2
      L1_2 = L38_1
      if nil ~= L1_2 then
        L1_2 = ENTITY
        L1_2 = L1_2.DOES_ENTITY_EXIST
        L2_2 = L38_1
        L1_2 = L1_2(L2_2)
        if L1_2 then
          goto lbl_60
        end
      end
      L1_2 = entities
      L1_2 = L1_2.create_object
      L2_2 = object_hash
      L3_2 = player_pos
      L1_2 = L1_2(L2_2, L3_2)
      L38_1 = L1_2
      ::lbl_60::
      L1_2 = ENTITY
      L1_2 = L1_2.SET_ENTITY_COLLISION
      L2_2 = L38_1
      L3_2 = false
      L4_2 = false
      L1_2(L2_2, L3_2, L4_2)
      L1_2 = ENTITY
      L1_2 = L1_2.GET_ENTITY_ROTATION
      L2_2 = PLAYER
      L2_2 = L2_2.PLAYER_PED_ID
      L2_2 = L2_2()
      L3_2 = 5
      L1_2 = L1_2(L2_2, L3_2)
      player_rot = L1_2
      L1_2 = ENTITY
      L1_2 = L1_2.SET_ENTITY_COORDS
      L2_2 = L38_1
      L3_2 = player_pos
      L3_2 = L3_2.x
      L4_2 = player_pos
      L4_2 = L4_2.y
      L5_2 = player_pos
      L5_2 = L5_2.z
      L5_2 = L5_2 - 1
      L6_2 = false
      L7_2 = false
      L8_2 = false
      L9_2 = false
      L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
      L1_2 = ENTITY
      L1_2 = L1_2.SET_ENTITY_ROTATION
      L2_2 = L38_1
      L3_2 = 0
      L4_2 = 0
      L5_2 = player_rot
      L5_2 = L5_2.z
      L6_2 = 1
      L7_2 = true
      L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
      L1_2 = util
      L1_2 = L1_2.yield
      L1_2()
    end
  else
    L1_2 = delete_entity
    L2_2 = L38_1
    L1_2(L2_2)
    L1_2 = ENTITY
    L1_2 = L1_2.SET_ENTITY_ALPHA
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = 255
    L4_2 = false
    L1_2(L2_2, L3_2, L4_2)
  end
  ::lbl_116::
end
L39_1[L40_1] = L41_1
L39_1 = _ENV
L40_1 = "get_closest_train"
function L41_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = entities
  L0_2 = L0_2.get_all_vehicles_as_handles
  L0_2 = L0_2()
  L1_2 = pairs
  L2_2 = L0_2
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = ENTITY
    L7_2 = L7_2.GET_ENTITY_MODEL
    L8_2 = L6_2
    L7_2 = L7_2(L8_2)
    if 1030400667 == L7_2 then
      L7_2 = request_control
      L8_2 = L6_2
      L7_2(L8_2)
      return L6_2
    end
  end
  L1_2 = util
  L1_2 = L1_2.toast
  L2_2 = "找不到附近的火车"
  L1_2(L2_2)
  L1_2 = 0
  return L1_2
end
L39_1[L40_1] = L41_1
L39_1 = _ENV
L40_1 = "spawn_train"
function L41_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L2_2 = {}
  L3_2 = util
  L3_2 = L3_2.joaat
  L4_2 = "metrotrain"
  L3_2 = L3_2(L4_2)
  L4_2 = util
  L4_2 = L4_2.joaat
  L5_2 = "freight"
  L4_2 = L4_2(L5_2)
  L5_2 = util
  L5_2 = L5_2.joaat
  L6_2 = "freightcar"
  L5_2 = L5_2(L6_2)
  L6_2 = util
  L6_2 = L6_2.joaat
  L7_2 = "freightcont1"
  L6_2 = L6_2(L7_2)
  L7_2 = util
  L7_2 = L7_2.joaat
  L8_2 = "freightcont2"
  L7_2 = L7_2(L8_2)
  L8_2 = util
  L8_2 = L8_2.joaat
  L9_2 = "freightgrain"
  L8_2 = L8_2(L9_2)
  L9_2 = util
  L9_2 = L9_2.joaat
  L10_2 = "tankercar"
  L9_2, L10_2, L11_2 = L9_2(L10_2)
  L2_2[1] = L3_2
  L2_2[2] = L4_2
  L2_2[3] = L5_2
  L2_2[4] = L6_2
  L2_2[5] = L7_2
  L2_2[6] = L8_2
  L2_2[7] = L9_2
  L2_2[8] = L10_2
  L2_2[9] = L11_2
  L3_2 = ipairs
  L4_2 = L2_2
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = request_model
    L10_2 = L8_2
    L9_2(L10_2)
  end
  L3_2 = VEHICLE
  L3_2 = L3_2.CREATE_MISSION_TRAIN
  L4_2 = A0_2
  L5_2 = A1_2.x
  L6_2 = A1_2.y
  L7_2 = A1_2.z
  L8_2 = 0
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
  L4_2 = ENTITY
  L4_2 = L4_2.GET_ENTITY_COORDS
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  L5_2 = NETWORK
  L5_2 = L5_2.NETWORK_GET_NETWORK_ID_FROM_ENTITY
  L6_2 = veh
  L5_2 = L5_2(L6_2)
  L6_2 = NETWORK
  L6_2 = L6_2.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID
  L7_2 = L5_2
  L6_2(L7_2)
  L6_2 = NETWORK
  L6_2 = L6_2.SET_NETWORK_ID_CAN_MIGRATE
  L7_2 = L5_2
  L8_2 = false
  L6_2(L7_2, L8_2)
  L6_2 = util
  L6_2 = L6_2.toast
  L7_2 = string
  L7_2 = L7_2.format
  L8_2 = "火车生成于 (%.1f, %.1f, %.1f)"
  L9_2 = L4_2.x
  L10_2 = L4_2.y
  L11_2 = L4_2.z
  L7_2, L8_2, L9_2, L10_2, L11_2 = L7_2(L8_2, L9_2, L10_2, L11_2)
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
end
L39_1[L40_1] = L41_1
L39_1 = _ENV
L40_1 = "block_spectate"
function L41_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L0_2 = players
  L0_2 = L0_2.list
  L1_2 = false
  L2_2 = true
  L3_2 = true
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = v3
    L6_2 = L6_2.distance
    L7_2 = players
    L7_2 = L7_2.get_position
    L8_2 = PLAYER
    L8_2 = L8_2.PLAYER_ID
    L8_2, L9_2, L10_2, L11_2 = L8_2()
    L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2)
    L8_2 = players
    L8_2 = L8_2.get_position
    L9_2 = L5_2
    L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2)
    L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
    L7_2 = v3
    L7_2 = L7_2.distance
    L8_2 = players
    L8_2 = L8_2.get_position
    L9_2 = PLAYER
    L9_2 = L9_2.PLAYER_ID
    L9_2, L10_2, L11_2 = L9_2()
    L8_2 = L8_2(L9_2, L10_2, L11_2)
    L9_2 = players
    L9_2 = L9_2.get_cam_pos
    L10_2 = L5_2
    L9_2, L10_2, L11_2 = L9_2(L10_2)
    L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2)
    if not (L7_2 < 25.0) or not (L6_2 > 30.0) then
      L7_2 = players
      L7_2 = L7_2.get_spectate_target
      L8_2 = L5_2
      L7_2 = L7_2(L8_2)
      L8_2 = PLAYER
      L8_2 = L8_2.PLAYER_ID
      L8_2 = L8_2()
      if L7_2 ~= L8_2 then
        goto lbl_96
      end
    end
    L7_2 = menu
    L7_2 = L7_2.trigger_commands
    L8_2 = "timeout "
    L9_2 = players
    L9_2 = L9_2.get_name
    L10_2 = L5_2
    L9_2 = L9_2(L10_2)
    L10_2 = " on"
    L8_2 = L8_2 .. L9_2 .. L10_2
    L7_2(L8_2)
    L7_2 = players
    L7_2 = L7_2.get_position
    L8_2 = PLAYER
    L8_2 = L8_2.PLAYER_ID
    L8_2, L9_2, L10_2, L11_2 = L8_2()
    L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2)
    L8_2 = v3
    L8_2 = L8_2.distance
    L9_2 = L7_2
    L10_2 = players
    L10_2 = L10_2.get_cam_pos
    L11_2 = L5_2
    L10_2, L11_2 = L10_2(L11_2)
    L8_2 = L8_2(L9_2, L10_2, L11_2)
    if L8_2 < 25.0 then
      repeat
        L8_2 = util
        L8_2 = L8_2.yield
        L8_2()
        L8_2 = v3
        L8_2 = L8_2.distance
        L9_2 = L7_2
        L10_2 = players
        L10_2 = L10_2.get_cam_pos
        L11_2 = L5_2
        L10_2, L11_2 = L10_2(L11_2)
        L8_2 = L8_2(L9_2, L10_2, L11_2)
      until L8_2 > 50.0
      L8_2 = menu
      L8_2 = L8_2.trigger_commands
      L9_2 = "timeout "
      L10_2 = players
      L10_2 = L10_2.get_name
      L11_2 = L5_2
      L10_2 = L10_2(L11_2)
      L11_2 = " off"
      L9_2 = L9_2 .. L10_2 .. L11_2
      L8_2(L9_2)
    end
    ::lbl_96::
  end
end
L39_1[L40_1] = L41_1
L39_1 = _ENV
L40_1 = "frozen_vehicles"
L41_1 = {}
L39_1[L40_1] = L41_1
L39_1 = _ENV
L40_1 = "update_frozen_vehicles"
function L41_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = pairs
  L1_2 = frozen_vehicles
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = ENTITY
    L6_2 = L6_2.DOES_ENTITY_EXIST
    L7_2 = L5_2.vehicle
    L6_2 = L6_2(L7_2)
    if L6_2 then
      L6_2 = ENTITY
      L6_2 = L6_2.FREEZE_ENTITY_POSITION
      L7_2 = L5_2.vehicle
      L8_2 = true
      L6_2(L7_2, L8_2)
    end
  end
end
L39_1[L40_1] = L41_1
L39_1 = _ENV
L40_1 = "refresh_frozen_vehicles_menu_list"
function L41_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L0_2 = menu
  L0_2 = L0_2.delete
  L1_2 = frozen_vehicles_menu_list
  L0_2(L1_2)
  L0_2 = menu
  L0_2 = L0_2.list
  L1_2 = vf
  L2_2 = "已冻结的载具"
  L0_2 = L0_2(L1_2, L2_2)
  frozen_vehicles_menu_list = L0_2
  L0_2 = pairs
  L1_2 = frozen_vehicles
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = menu
    L6_2 = L6_2.action
    L7_2 = frozen_vehicles_menu_list
    L8_2 = L5_2.name
    L9_2 = {}
    L10_2 = "unfreeze"
    L11_2 = L4_2
    L10_2 = L10_2 .. L11_2
    L9_2[1] = L10_2
    L10_2 = "点击解冻载具"
    function L11_2()
      local L0_3, L1_3, L2_3
      L0_3 = table
      L0_3 = L0_3.remove
      L1_3 = frozen_vehicles
      L2_3 = L4_2
      L0_3(L1_3, L2_3)
      L0_3 = ENTITY
      L0_3 = L0_3.FREEZE_ENTITY_POSITION
      L1_3 = L5_2.vehicle
      L2_3 = false
      L0_3(L1_3, L2_3)
      L0_3 = refresh_frozen_vehicles_menu_list
      L0_3()
    end
    L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
  end
end
L39_1[L40_1] = L41_1
L39_1 = _ENV
L40_1 = "add_frozen_vehicle"
function L41_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = pairs
  L2_2 = frozen_vehicles
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = L6_2.vehicle
    if L7_2 == A0_2 then
      return
    end
  end
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_MODEL
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = VEHICLE
  L2_2 = L2_2.GET_DISPLAY_NAME_FROM_VEHICLE_MODEL
  L3_2 = L1_2
  L2_2 = L2_2(L3_2)
  L3_2 = table
  L3_2 = L3_2.insert
  L4_2 = frozen_vehicles
  L5_2 = {}
  L5_2.name = L2_2
  L5_2.vehicle = A0_2
  L3_2(L4_2, L5_2)
  L3_2 = refresh_frozen_vehicles_menu_list
  L3_2()
  L3_2 = update_frozen_vehicles
  L3_2()
end
L39_1[L40_1] = L41_1
L39_1 = _ENV
L40_1 = "save_config"
function L41_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2
  L0_2 = filesystem
  L0_2 = L0_2.scripts_dir
  L0_2 = L0_2()
  L1_2 = "lib/daidailib/Config/Config.lua"
  L0_2 = L0_2 .. L1_2
  L1_2 = notification
  L2_2 = "~y~~bold~配置已保存"
  L3_2 = HudColour
  L3_2 = L3_2.blue
  L1_2(L2_2, L3_2)
  L1_2 = "--[Lua配置]"
  L2_2 = [[

config_active1 = ]]
  L3_2 = menu
  L3_2 = L3_2.get_value
  L4_2 = host_sequence
  L3_2 = L3_2(L4_2)
  L4_2 = [[

config_active1_x = ]]
  L5_2 = menu
  L5_2 = L5_2.get_value
  L6_2 = host_sequence_x
  L5_2 = L5_2(L6_2)
  L6_2 = [[

config_active1_y = ]]
  L7_2 = menu
  L7_2 = L7_2.get_value
  L8_2 = host_sequence_y
  L7_2 = L7_2(L8_2)
  L8_2 = [[

config_active2 = ]]
  L9_2 = menu
  L9_2 = L9_2.get_value
  L10_2 = show_time
  L9_2 = L9_2(L10_2)
  L10_2 = [[

config_active3 = ]]
  L11_2 = menu
  L11_2 = L11_2.get_value
  L12_2 = script_name
  L11_2 = L11_2(L12_2)
  L12_2 = [[

config_active4 = ]]
  L13_2 = menu
  L13_2 = L13_2.get_value
  L14_2 = numfps
  L13_2 = L13_2(L14_2)
  L14_2 = [[

config_active5 = ]]
  L15_2 = menu
  L15_2 = L15_2.get_value
  L16_2 = show_entityinfo
  L15_2 = L15_2(L16_2)
  L16_2 = [[

config_active6 = ]]
  L17_2 = menu
  L17_2 = L17_2.get_value
  L18_2 = players_info
  L17_2 = L17_2(L18_2)
  L18_2 = [[

config_active6_x = ]]
  L19_2 = menu
  L19_2 = L19_2.get_value
  L20_2 = infoverlay_x
  L19_2 = L19_2(L20_2)
  L20_2 = [[

config_active6_y = ]]
  L21_2 = menu
  L21_2 = L21_2.get_value
  L22_2 = infoverlay_y
  L21_2 = L21_2(L22_2)
  L22_2 = [[

config_active7 = ]]
  L23_2 = menu
  L23_2 = L23_2.get_value
  L24_2 = auto_kick_adBot
  L23_2 = L23_2(L24_2)
  L24_2 = [[

config_active8 = ]]
  L25_2 = menu
  L25_2 = L25_2.get_value
  L26_2 = players_bar
  L25_2 = L25_2(L26_2)
  L1_2 = L1_2 .. L2_2 .. L3_2 .. L4_2 .. L5_2 .. L6_2 .. L7_2 .. L8_2 .. L9_2 .. L10_2 .. L11_2 .. L12_2 .. L13_2 .. L14_2 .. L15_2 .. L16_2 .. L17_2 .. L18_2 .. L19_2 .. L20_2 .. L21_2 .. L22_2 .. L23_2 .. L24_2 .. L25_2
  L2_2 = io
  L2_2 = L2_2.open
  L3_2 = L0_2
  L4_2 = "w"
  L2_2 = L2_2(L3_2, L4_2)
  L4_2 = L2_2
  L3_2 = L2_2.write
  L5_2 = L1_2
  L3_2(L4_2, L5_2)
  L4_2 = L2_2
  L3_2 = L2_2.close
  L3_2(L4_2)
end
L39_1[L40_1] = L41_1
L39_1 = _ENV
L40_1 = "loop_clear_entity"
function L41_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = pairs
  L1_2 = entities
  L1_2 = L1_2.get_all_vehicles_as_handles
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2 = L1_2()
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = request_control
    L7_2 = L5_2
    L6_2(L7_2)
    L6_2 = delete_entity
    L7_2 = L5_2
    L6_2(L7_2)
  end
  L0_2 = pairs
  L1_2 = entities
  L1_2 = L1_2.get_all_peds_as_handles
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2 = L1_2()
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = request_control
    L7_2 = L5_2
    L6_2(L7_2)
    L6_2 = delete_entity
    L7_2 = L5_2
    L6_2(L7_2)
  end
  L0_2 = pairs
  L1_2 = entities
  L1_2 = L1_2.get_all_objects_as_handles
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2 = L1_2()
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = request_control
    L7_2 = L5_2
    L6_2(L7_2)
    L6_2 = delete_entity
    L7_2 = L5_2
    L6_2(L7_2)
  end
end
L39_1[L40_1] = L41_1
L39_1 = _ENV
L40_1 = "request_control_of_table_once"
function L41_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = ipairs
  L2_2 = A0_2
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = NETWORK
    L7_2 = L7_2.NETWORK_REQUEST_CONTROL_OF_ENTITY
    L8_2 = L6_2
    L7_2(L8_2)
  end
end
L39_1[L40_1] = L41_1
L39_1 = _ENV
L40_1 = "World_gravity"
function L41_1(A0_2)
  local L1_2, L2_2
  gravity_current_index = A0_2
  if 1 ~= A0_2 then
    while true do
      L1_2 = gravity_current_index
      if L1_2 ~= A0_2 then
        break
      end
      L1_2 = request_control_of_table_once
      L2_2 = entities
      L2_2 = L2_2.get_all_vehicles_as_handles
      L2_2 = L2_2()
      L1_2(L2_2)
      L1_2 = request_control_of_table_once
      L2_2 = entities
      L2_2 = L2_2.get_all_objects_as_handles
      L2_2 = L2_2()
      L1_2(L2_2)
      L1_2 = request_control_of_table_once
      L2_2 = entities
      L2_2 = L2_2.get_all_peds_as_handles
      L2_2 = L2_2()
      L1_2(L2_2)
      L1_2 = request_control_of_table_once
      L2_2 = entities
      L2_2 = L2_2.get_all_pickups_as_handles
      L2_2 = L2_2()
      L1_2(L2_2)
      L1_2 = MISC
      L1_2 = L1_2.SET_GRAVITY_LEVEL
      L2_2 = A0_2 - 1
      L1_2(L2_2)
      L1_2 = util
      L1_2 = L1_2.yield
      L1_2()
    end
  else
    L1_2 = MISC
    L1_2 = L1_2.SET_GRAVITY_LEVEL
    L2_2 = A0_2 - 1
    L1_2(L2_2)
  end
end
L39_1[L40_1] = L41_1
L39_1 = _ENV
L40_1 = "vehicle_automatically"
function L41_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = PED
  L0_2 = L0_2.GET_VEHICLE_PED_IS_IN
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = false
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = CAM
  L1_2 = L1_2.GET_GAMEPLAY_CAM_ROT
  L2_2 = 2
  L1_2 = L1_2(L2_2)
  L2_2 = v3
  L2_2 = L2_2.getHeading
  L3_2 = v3
  L3_2 = L3_2.new
  L4_2 = L1_2
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2 = L3_2(L4_2)
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  L3_2 = ENTITY
  L3_2 = L3_2.GET_ENTITY_HEIGHT_ABOVE_GROUND
  L4_2 = L0_2
  L3_2 = L3_2(L4_2)
  L4_2 = L3_2 < 2
  L5_2 = ENTITY
  L5_2 = L5_2.GET_ENTITY_SPEED
  L6_2 = L0_2
  L5_2 = L5_2(L6_2)
  L6_2 = VEHICLE
  L6_2 = L6_2.IS_VEHICLE_ON_ALL_WHEELS
  L7_2 = L0_2
  L6_2 = L6_2(L7_2)
  if not L6_2 then
    L6_2 = ENTITY
    L6_2 = L6_2.IS_ENTITY_UPSIDEDOWN
    L7_2 = L0_2
    L6_2 = L6_2(L7_2)
    if L6_2 and L4_2 then
      L6_2 = VEHICLE
      L6_2 = L6_2.SET_VEHICLE_ON_GROUND_PROPERLY
      L7_2 = L0_2
      L8_2 = 5.0
      L6_2(L7_2, L8_2)
      L6_2 = ENTITY
      L6_2 = L6_2.SET_ENTITY_HEADING
      L7_2 = L0_2
      L8_2 = L2_2
      L6_2(L7_2, L8_2)
      L6_2 = util
      L6_2 = L6_2.yield
      L6_2()
      L6_2 = VEHICLE
      L6_2 = L6_2.SET_VEHICLE_FORWARD_SPEED
      L7_2 = L0_2
      L8_2 = L5_2
      L6_2(L7_2, L8_2)
    end
  end
end
L39_1[L40_1] = L41_1
L39_1 = _ENV
L40_1 = "util"
L39_1 = L39_1[L40_1]
L40_1 = "joaat"
L39_1 = L39_1[L40_1]
L40_1 = "ar_prop_ar_neon_gate4x_04a"
L39_1 = L39_1(L40_1)
L40_1 = _ENV
L41_1 = "Protect_ball"
function L42_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  if A0_2 then
    L1_2 = STREAMING
    L1_2 = L1_2.REQUEST_MODEL
    L2_2 = L39_1
    L1_2(L2_2)
    while true do
      L1_2 = STREAMING
      L1_2 = L1_2.HAS_MODEL_LOADED
      L2_2 = L39_1
      L1_2 = L1_2(L2_2)
      if L1_2 then
        break
      end
      L1_2 = STREAMING
      L1_2 = L1_2.REQUEST_MODEL
      L2_2 = L39_1
      L1_2(L2_2)
      L1_2 = util
      L1_2 = L1_2.yield
      L1_2()
    end
    L1_2 = entities
    L1_2 = L1_2.create_object
    L2_2 = L39_1
    L3_2 = v3
    L4_2 = -75.14637
    L5_2 = -818.67236
    L6_2 = 326.1751
    L3_2, L4_2, L5_2, L6_2, L7_2 = L3_2(L4_2, L5_2, L6_2)
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    c1 = L1_2
    L1_2 = entities
    L1_2 = L1_2.create_object
    L2_2 = L39_1
    L3_2 = v3
    L4_2 = -75.14637
    L5_2 = -818.67236
    L6_2 = 326.1751
    L3_2, L4_2, L5_2, L6_2, L7_2 = L3_2(L4_2, L5_2, L6_2)
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    c2 = L1_2
    L1_2 = entities
    L1_2 = L1_2.create_object
    L2_2 = L39_1
    L3_2 = v3
    L4_2 = -75.14637
    L5_2 = -818.67236
    L6_2 = 326.1751
    L3_2, L4_2, L5_2, L6_2, L7_2 = L3_2(L4_2, L5_2, L6_2)
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    c3 = L1_2
    L1_2 = entities
    L1_2 = L1_2.create_object
    L2_2 = L39_1
    L3_2 = v3
    L4_2 = -75.14637
    L5_2 = -818.67236
    L6_2 = 326.1751
    L3_2, L4_2, L5_2, L6_2, L7_2 = L3_2(L4_2, L5_2, L6_2)
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    c4 = L1_2
    L1_2 = entities
    L1_2 = L1_2.create_object
    L2_2 = L39_1
    L3_2 = v3
    L4_2 = -75.14637
    L5_2 = -818.67236
    L6_2 = 326.1751
    L3_2, L4_2, L5_2, L6_2, L7_2 = L3_2(L4_2, L5_2, L6_2)
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    c5 = L1_2
    L1_2 = entities
    L1_2 = L1_2.create_object
    L2_2 = L39_1
    L3_2 = v3
    L4_2 = -75.14637
    L5_2 = -818.67236
    L6_2 = 326.1751
    L3_2, L4_2, L5_2, L6_2, L7_2 = L3_2(L4_2, L5_2, L6_2)
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    c6 = L1_2
    L1_2 = entities
    L1_2 = L1_2.create_object
    L2_2 = L39_1
    L3_2 = v3
    L4_2 = -75.14637
    L5_2 = -818.67236
    L6_2 = 326.1751
    L3_2, L4_2, L5_2, L6_2, L7_2 = L3_2(L4_2, L5_2, L6_2)
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    c7 = L1_2
    L1_2 = entities
    L1_2 = L1_2.create_object
    L2_2 = L39_1
    L3_2 = v3
    L4_2 = -75.14637
    L5_2 = -818.67236
    L6_2 = 326.1751
    L3_2, L4_2, L5_2, L6_2, L7_2 = L3_2(L4_2, L5_2, L6_2)
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    c8 = L1_2
    L1_2 = entities
    L1_2 = L1_2.create_object
    L2_2 = L39_1
    L3_2 = v3
    L4_2 = -75.14637
    L5_2 = -818.67236
    L6_2 = 326.1751
    L3_2, L4_2, L5_2, L6_2, L7_2 = L3_2(L4_2, L5_2, L6_2)
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    c9 = L1_2
    L1_2 = entities
    L1_2 = L1_2.create_object
    L2_2 = L39_1
    L3_2 = v3
    L4_2 = -75.14637
    L5_2 = -818.67236
    L6_2 = 326.1751
    L3_2, L4_2, L5_2, L6_2, L7_2 = L3_2(L4_2, L5_2, L6_2)
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    c10 = L1_2
    L1_2 = entities
    L1_2 = L1_2.create_object
    L2_2 = L39_1
    L3_2 = v3
    L4_2 = -75.14637
    L5_2 = -818.67236
    L6_2 = 326.1751
    L3_2, L4_2, L5_2, L6_2, L7_2 = L3_2(L4_2, L5_2, L6_2)
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    c11 = L1_2
    L1_2 = entities
    L1_2 = L1_2.create_object
    L2_2 = L39_1
    L3_2 = v3
    L4_2 = -75.14637
    L5_2 = -818.67236
    L6_2 = 326.1751
    L3_2, L4_2, L5_2, L6_2, L7_2 = L3_2(L4_2, L5_2, L6_2)
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    c12 = L1_2
    L1_2 = entities
    L1_2 = L1_2.create_object
    L2_2 = L39_1
    L3_2 = v3
    L4_2 = -75.14637
    L5_2 = -818.67236
    L6_2 = 326.1751
    L3_2, L4_2, L5_2, L6_2, L7_2 = L3_2(L4_2, L5_2, L6_2)
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    c13 = L1_2
    L1_2 = entities
    L1_2 = L1_2.create_object
    L2_2 = L39_1
    L3_2 = v3
    L4_2 = -75.14637
    L5_2 = -818.67236
    L6_2 = 326.1751
    L3_2, L4_2, L5_2, L6_2, L7_2 = L3_2(L4_2, L5_2, L6_2)
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    c14 = L1_2
    L1_2 = entities
    L1_2 = L1_2.create_object
    L2_2 = L39_1
    L3_2 = v3
    L4_2 = -75.14637
    L5_2 = -818.67236
    L6_2 = 326.1751
    L3_2, L4_2, L5_2, L6_2, L7_2 = L3_2(L4_2, L5_2, L6_2)
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    c15 = L1_2
    L1_2 = entities
    L1_2 = L1_2.create_object
    L2_2 = L39_1
    L3_2 = v3
    L4_2 = -75.14637
    L5_2 = -818.67236
    L6_2 = 326.1751
    L3_2, L4_2, L5_2, L6_2, L7_2 = L3_2(L4_2, L5_2, L6_2)
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    c16 = L1_2
    L1_2 = entities
    L1_2 = L1_2.create_object
    L2_2 = L39_1
    L3_2 = v3
    L4_2 = -75.14637
    L5_2 = -818.67236
    L6_2 = 326.1751
    L3_2, L4_2, L5_2, L6_2, L7_2 = L3_2(L4_2, L5_2, L6_2)
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    c17 = L1_2
    L1_2 = entities
    L1_2 = L1_2.create_object
    L2_2 = L39_1
    L3_2 = v3
    L4_2 = -75.14637
    L5_2 = -818.67236
    L6_2 = 326.1751
    L3_2, L4_2, L5_2, L6_2, L7_2 = L3_2(L4_2, L5_2, L6_2)
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    c18 = L1_2
    L1_2 = entities
    L1_2 = L1_2.create_object
    L2_2 = L39_1
    L3_2 = v3
    L4_2 = -75.14637
    L5_2 = -818.67236
    L6_2 = 326.1751
    L3_2, L4_2, L5_2, L6_2, L7_2 = L3_2(L4_2, L5_2, L6_2)
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    c19 = L1_2
    L1_2 = ENTITY
    L1_2 = L1_2.FREEZE_ENTITY_POSITION
    L2_2 = c1
    L3_2 = true
    L1_2(L2_2, L3_2)
    L1_2 = ENTITY
    L1_2 = L1_2.FREEZE_ENTITY_POSITION
    L2_2 = c2
    L3_2 = true
    L1_2(L2_2, L3_2)
    L1_2 = ENTITY
    L1_2 = L1_2.FREEZE_ENTITY_POSITION
    L2_2 = c3
    L3_2 = true
    L1_2(L2_2, L3_2)
    L1_2 = ENTITY
    L1_2 = L1_2.FREEZE_ENTITY_POSITION
    L2_2 = c4
    L3_2 = true
    L1_2(L2_2, L3_2)
    L1_2 = ENTITY
    L1_2 = L1_2.FREEZE_ENTITY_POSITION
    L2_2 = c5
    L3_2 = true
    L1_2(L2_2, L3_2)
    L1_2 = ENTITY
    L1_2 = L1_2.FREEZE_ENTITY_POSITION
    L2_2 = c6
    L3_2 = true
    L1_2(L2_2, L3_2)
    L1_2 = ENTITY
    L1_2 = L1_2.FREEZE_ENTITY_POSITION
    L2_2 = c7
    L3_2 = true
    L1_2(L2_2, L3_2)
    L1_2 = ENTITY
    L1_2 = L1_2.FREEZE_ENTITY_POSITION
    L2_2 = c8
    L3_2 = true
    L1_2(L2_2, L3_2)
    L1_2 = ENTITY
    L1_2 = L1_2.FREEZE_ENTITY_POSITION
    L2_2 = c9
    L3_2 = true
    L1_2(L2_2, L3_2)
    L1_2 = ENTITY
    L1_2 = L1_2.FREEZE_ENTITY_POSITION
    L2_2 = c10
    L3_2 = true
    L1_2(L2_2, L3_2)
    L1_2 = ENTITY
    L1_2 = L1_2.FREEZE_ENTITY_POSITION
    L2_2 = c11
    L3_2 = true
    L1_2(L2_2, L3_2)
    L1_2 = ENTITY
    L1_2 = L1_2.FREEZE_ENTITY_POSITION
    L2_2 = c12
    L3_2 = true
    L1_2(L2_2, L3_2)
    L1_2 = ENTITY
    L1_2 = L1_2.FREEZE_ENTITY_POSITION
    L2_2 = c13
    L3_2 = true
    L1_2(L2_2, L3_2)
    L1_2 = ENTITY
    L1_2 = L1_2.FREEZE_ENTITY_POSITION
    L2_2 = c14
    L3_2 = true
    L1_2(L2_2, L3_2)
    L1_2 = ENTITY
    L1_2 = L1_2.FREEZE_ENTITY_POSITION
    L2_2 = c15
    L3_2 = true
    L1_2(L2_2, L3_2)
    L1_2 = ENTITY
    L1_2 = L1_2.FREEZE_ENTITY_POSITION
    L2_2 = c16
    L3_2 = true
    L1_2(L2_2, L3_2)
    L1_2 = ENTITY
    L1_2 = L1_2.FREEZE_ENTITY_POSITION
    L2_2 = c17
    L3_2 = true
    L1_2(L2_2, L3_2)
    L1_2 = ENTITY
    L1_2 = L1_2.FREEZE_ENTITY_POSITION
    L2_2 = c18
    L3_2 = true
    L1_2(L2_2, L3_2)
    L1_2 = ENTITY
    L1_2 = L1_2.FREEZE_ENTITY_POSITION
    L2_2 = c19
    L3_2 = true
    L1_2(L2_2, L3_2)
    L1_2 = ENTITY
    L1_2 = L1_2.SET_ENTITY_ROTATION
    L2_2 = c2
    L3_2 = 0.0
    L4_2 = 0.0
    L5_2 = 10.0
    L6_2 = 1
    L7_2 = true
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    L1_2 = ENTITY
    L1_2 = L1_2.SET_ENTITY_ROTATION
    L2_2 = c3
    L3_2 = 0.0
    L4_2 = 0.0
    L5_2 = 20.0
    L6_2 = 1
    L7_2 = true
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    L1_2 = ENTITY
    L1_2 = L1_2.SET_ENTITY_ROTATION
    L2_2 = c4
    L3_2 = 0.0
    L4_2 = 0.0
    L5_2 = 30.0
    L6_2 = 1
    L7_2 = true
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    L1_2 = ENTITY
    L1_2 = L1_2.SET_ENTITY_ROTATION
    L2_2 = c5
    L3_2 = 0.0
    L4_2 = 0.0
    L5_2 = 40.0
    L6_2 = 1
    L7_2 = true
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    L1_2 = ENTITY
    L1_2 = L1_2.SET_ENTITY_ROTATION
    L2_2 = c6
    L3_2 = 0.0
    L4_2 = 0.0
    L5_2 = 50.0
    L6_2 = 1
    L7_2 = true
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    L1_2 = ENTITY
    L1_2 = L1_2.SET_ENTITY_ROTATION
    L2_2 = c7
    L3_2 = 0.0
    L4_2 = 0.0
    L5_2 = 60.0
    L6_2 = 1
    L7_2 = true
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    L1_2 = ENTITY
    L1_2 = L1_2.SET_ENTITY_ROTATION
    L2_2 = c8
    L3_2 = 0.0
    L4_2 = 0.0
    L5_2 = 70.0
    L6_2 = 1
    L7_2 = true
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    L1_2 = ENTITY
    L1_2 = L1_2.SET_ENTITY_ROTATION
    L2_2 = c9
    L3_2 = 0.0
    L4_2 = 0.0
    L5_2 = 80.0
    L6_2 = 1
    L7_2 = true
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    L1_2 = ENTITY
    L1_2 = L1_2.SET_ENTITY_ROTATION
    L2_2 = c10
    L3_2 = 0.0
    L4_2 = 0.0
    L5_2 = 90.0
    L6_2 = 1
    L7_2 = true
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    L1_2 = ENTITY
    L1_2 = L1_2.SET_ENTITY_ROTATION
    L2_2 = c11
    L3_2 = 0.0
    L4_2 = 0.0
    L5_2 = 100.0
    L6_2 = 1
    L7_2 = true
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    L1_2 = ENTITY
    L1_2 = L1_2.SET_ENTITY_ROTATION
    L2_2 = c12
    L3_2 = 0.0
    L4_2 = 0.0
    L5_2 = 110.0
    L6_2 = 1
    L7_2 = true
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    L1_2 = ENTITY
    L1_2 = L1_2.SET_ENTITY_ROTATION
    L2_2 = c13
    L3_2 = 0.0
    L4_2 = 0.0
    L5_2 = 120.0
    L6_2 = 1
    L7_2 = true
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    L1_2 = ENTITY
    L1_2 = L1_2.SET_ENTITY_ROTATION
    L2_2 = c14
    L3_2 = 0.0
    L4_2 = 0.0
    L5_2 = 130.0
    L6_2 = 1
    L7_2 = true
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    L1_2 = ENTITY
    L1_2 = L1_2.SET_ENTITY_ROTATION
    L2_2 = c15
    L3_2 = 0.0
    L4_2 = 0.0
    L5_2 = 140.0
    L6_2 = 1
    L7_2 = true
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    L1_2 = ENTITY
    L1_2 = L1_2.SET_ENTITY_ROTATION
    L2_2 = c16
    L3_2 = 0.0
    L4_2 = 0.0
    L5_2 = 150.0
    L6_2 = 1
    L7_2 = true
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    L1_2 = ENTITY
    L1_2 = L1_2.SET_ENTITY_ROTATION
    L2_2 = c18
    L3_2 = 0.0
    L4_2 = 0.0
    L5_2 = 160.0
    L6_2 = 1
    L7_2 = true
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    L1_2 = ENTITY
    L1_2 = L1_2.SET_ENTITY_ROTATION
    L2_2 = c19
    L3_2 = 0.0
    L4_2 = 0.0
    L5_2 = 170.0
    L6_2 = 1
    L7_2 = true
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    L1_2 = ENTITY
    L1_2 = L1_2.SET_ENTITY_COORDS
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = -75.14637
    L4_2 = -818.67236
    L5_2 = 326.1751
    L1_2(L2_2, L3_2, L4_2, L5_2)
  else
    L1_2 = delete_entity
    L2_2 = c1
    L1_2(L2_2)
    L1_2 = delete_entity
    L2_2 = c2
    L1_2(L2_2)
    L1_2 = delete_entity
    L2_2 = c3
    L1_2(L2_2)
    L1_2 = delete_entity
    L2_2 = c4
    L1_2(L2_2)
    L1_2 = delete_entity
    L2_2 = c5
    L1_2(L2_2)
    L1_2 = delete_entity
    L2_2 = c6
    L1_2(L2_2)
    L1_2 = delete_entity
    L2_2 = c7
    L1_2(L2_2)
    L1_2 = delete_entity
    L2_2 = c8
    L1_2(L2_2)
    L1_2 = delete_entity
    L2_2 = c9
    L1_2(L2_2)
    L1_2 = delete_entity
    L2_2 = c10
    L1_2(L2_2)
    L1_2 = delete_entity
    L2_2 = c11
    L1_2(L2_2)
    L1_2 = delete_entity
    L2_2 = c12
    L1_2(L2_2)
    L1_2 = delete_entity
    L2_2 = c13
    L1_2(L2_2)
    L1_2 = delete_entity
    L2_2 = c14
    L1_2(L2_2)
    L1_2 = delete_entity
    L2_2 = c15
    L1_2(L2_2)
    L1_2 = delete_entity
    L2_2 = c16
    L1_2(L2_2)
    L1_2 = delete_entity
    L2_2 = c17
    L1_2(L2_2)
    L1_2 = delete_entity
    L2_2 = c18
    L1_2(L2_2)
    L1_2 = delete_entity
    L2_2 = c19
    L1_2(L2_2)
  end
end
L40_1[L41_1] = L42_1
L40_1 = _ENV
L41_1 = "ShootEffect"
L42_1 = {}
L43_1 = "scale"
L42_1[L43_1] = 0
L43_1 = "rotation"
L44_1 = nil
L42_1[L43_1] = L44_1
L40_1[L41_1] = L42_1
L40_1 = _ENV
L41_1 = "ShootEffect"
L40_1 = L40_1[L41_1]
L41_1 = _ENV
L42_1 = "ShootEffect"
L41_1 = L41_1[L42_1]
L40_1.__index = L41_1
L40_1 = _ENV
L41_1 = "setmetatable"
L40_1 = L40_1[L41_1]
L41_1 = _ENV
L42_1 = "ShootEffect"
L41_1 = L41_1[L42_1]
L42_1 = _ENV
L43_1 = "Effect"
L42_1 = L42_1[L43_1]
L40_1(L41_1, L42_1)
L40_1 = _ENV
L41_1 = "ShootEffect_new"
function L42_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2
  L4_2 = setmetatable
  L5_2 = {}
  L6_2 = ShootEffect
  L4_2 = L4_2(L5_2, L6_2)
  tbl = L4_2
  L4_2 = tbl
  L4_2.name = A1_2
  L4_2 = tbl
  L4_2.asset = A0_2
  L4_2 = tbl
  L5_2 = A2_2 or L5_2
  if not A2_2 then
    L5_2 = 1.0
  end
  L4_2.scale = L5_2
  L4_2 = tbl
  L5_2 = A3_2 or L5_2
  if not A3_2 then
    L5_2 = v3
    L5_2 = L5_2.new
    L5_2 = L5_2()
  end
  L4_2.rotation = L5_2
  L4_2 = tbl
  return L4_2
end
L40_1[L41_1] = L42_1
L40_1 = _ENV
L41_1 = "shootingEffects"
L42_1 = {}
L43_1 = _ENV
L44_1 = "ShootEffect_new"
L43_1 = L43_1[L44_1]
L44_1 = "scr_rcbarry2"
L45_1 = "muz_clown"
L46_1 = 0.8
L47_1 = _ENV
L48_1 = "v3"
L47_1 = L47_1[L48_1]
L48_1 = "new"
L47_1 = L47_1[L48_1]
L48_1 = 90
L49_1 = 0.0
L50_1 = 0.0
L47_1, L48_1, L49_1, L50_1, L51_1, L52_1, L53_1, L54_1, L55_1, L56_1, L57_1, L58_1, L59_1, L60_1, L61_1, L62_1, L63_1, L64_1, L65_1, L66_1, L67_1, L68_1, L69_1, L70_1, L71_1, L72_1, L73_1, L74_1, L75_1, L76_1, L77_1, L78_1, L79_1, L80_1, L81_1 = L47_1(L48_1, L49_1, L50_1)
L43_1 = L43_1(L44_1, L45_1, L46_1, L47_1, L48_1, L49_1, L50_1, L51_1, L52_1, L53_1, L54_1, L55_1, L56_1, L57_1, L58_1, L59_1, L60_1, L61_1, L62_1, L63_1, L64_1, L65_1, L66_1, L67_1, L68_1, L69_1, L70_1, L71_1, L72_1, L73_1, L74_1, L75_1, L76_1, L77_1, L78_1, L79_1, L80_1, L81_1)
L44_1 = _ENV
L45_1 = "ShootEffect_new"
L44_1 = L44_1[L45_1]
L45_1 = "scr_rcbarry2"
L46_1 = "scr_clown_bul"
L47_1 = 0.3
L48_1 = _ENV
L49_1 = "v3"
L48_1 = L48_1[L49_1]
L49_1 = "new"
L48_1 = L48_1[L49_1]
L49_1 = 180.0
L50_1 = 0.0
L51_1 = 0.0
L48_1, L49_1, L50_1, L51_1, L52_1, L53_1, L54_1, L55_1, L56_1, L57_1, L58_1, L59_1, L60_1, L61_1, L62_1, L63_1, L64_1, L65_1, L66_1, L67_1, L68_1, L69_1, L70_1, L71_1, L72_1, L73_1, L74_1, L75_1, L76_1, L77_1, L78_1, L79_1, L80_1, L81_1 = L48_1(L49_1, L50_1, L51_1)
L44_1, L45_1, L46_1, L47_1, L48_1, L49_1, L50_1, L51_1, L52_1, L53_1, L54_1, L55_1, L56_1, L57_1, L58_1, L59_1, L60_1, L61_1, L62_1, L63_1, L64_1, L65_1, L66_1, L67_1, L68_1, L69_1, L70_1, L71_1, L72_1, L73_1, L74_1, L75_1, L76_1, L77_1, L78_1, L79_1, L80_1, L81_1 = L44_1(L45_1, L46_1, L47_1, L48_1, L49_1, L50_1, L51_1, L52_1, L53_1, L54_1, L55_1, L56_1, L57_1, L58_1, L59_1, L60_1, L61_1, L62_1, L63_1, L64_1, L65_1, L66_1, L67_1, L68_1, L69_1, L70_1, L71_1, L72_1, L73_1, L74_1, L75_1, L76_1, L77_1, L78_1, L79_1, L80_1, L81_1)
L42_1[1] = L43_1
L42_1[2] = L44_1
L42_1[3] = L45_1
L42_1[4] = L46_1
L42_1[5] = L47_1
L42_1[6] = L48_1
L42_1[7] = L49_1
L42_1[8] = L50_1
L42_1[9] = L51_1
L42_1[10] = L52_1
L42_1[11] = L53_1
L42_1[12] = L54_1
L42_1[13] = L55_1
L42_1[14] = L56_1
L42_1[15] = L57_1
L42_1[16] = L58_1
L42_1[17] = L59_1
L42_1[18] = L60_1
L42_1[19] = L61_1
L42_1[20] = L62_1
L42_1[21] = L63_1
L42_1[22] = L64_1
L42_1[23] = L65_1
L42_1[24] = L66_1
L42_1[25] = L67_1
L42_1[26] = L68_1
L42_1[27] = L69_1
L42_1[28] = L70_1
L42_1[29] = L71_1
L42_1[30] = L72_1
L42_1[31] = L73_1
L42_1[32] = L74_1
L42_1[33] = L75_1
L42_1[34] = L76_1
L42_1[35] = L77_1
L42_1[36] = L78_1
L42_1[37] = L79_1
L42_1[38] = L80_1
L42_1[39] = L81_1
L40_1[L41_1] = L42_1
L40_1 = 1
L41_1 = _ENV
L42_1 = "Shoot_effect_option"
function L43_1(A0_2)
  local L1_2
  L40_1 = A0_2
end
L41_1[L42_1] = L43_1
L41_1 = _ENV
L42_1 = "Shoot_effect"
function L43_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L0_2 = shootingEffects
  L1_2 = L40_1
  L0_2 = L0_2[L1_2]
  L1_2 = STREAMING
  L1_2 = L1_2.HAS_NAMED_PTFX_ASSET_LOADED
  L2_2 = L0_2.asset
  L1_2 = L1_2(L2_2)
  if not L1_2 then
    L1_2 = GRAPHICS1
    L1_2 = L1_2.REQUEST_NAMED_PTFX_ASSET
    L2_2 = L0_2.asset
    L1_2(L2_2)
  else
    L1_2 = PED
    L1_2 = L1_2.IS_PED_SHOOTING
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2 = L2_2()
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
    if L1_2 then
      L1_2 = WEAPON
      L1_2 = L1_2.GET_CURRENT_PED_WEAPON_ENTITY_INDEX
      L2_2 = PLAYER
      L2_2 = L2_2.PLAYER_PED_ID
      L2_2 = L2_2()
      L3_2 = 0
      L1_2 = L1_2(L2_2, L3_2)
      L2_2 = ENTITY
      L2_2 = L2_2.GET_ENTITY_BONE_INDEX_BY_NAME
      L3_2 = L1_2
      L4_2 = "gun_muzzle"
      L2_2 = L2_2(L3_2, L4_2)
      L3_2 = GRAPHICS
      L3_2 = L3_2.USE_PARTICLE_FX_ASSET
      L4_2 = L0_2.asset
      L3_2(L4_2)
      L3_2 = GRAPHICS
      L4_2 = "START_PARTICLE_FX_NON_LOOPED_ON_ENTITY_BONE"
      L3_2 = L3_2[L4_2]
      L4_2 = L0_2.name
      L5_2 = L1_2
      L6_2 = 0.0
      L7_2 = 0.0
      L8_2 = 0.0
      L9_2 = L0_2.rotation
      L9_2 = L9_2.x
      L10_2 = L0_2.rotation
      L10_2 = L10_2.y
      L11_2 = L0_2.rotation
      L11_2 = L11_2.z
      L12_2 = L2_2
      L13_2 = L0_2.scale
      L14_2 = false
      L15_2 = false
      L16_2 = false
      L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
    end
  end
end
L41_1[L42_1] = L43_1
L41_1 = {}
L42_1 = "colorCanChange"
L43_1 = false
L41_1[L42_1] = L43_1
L41_1.__index = L41_1
L42_1 = _ENV
L43_1 = "setmetatable"
L42_1 = L42_1[L43_1]
L43_1 = L41_1
L44_1 = _ENV
L45_1 = "Effect"
L44_1 = L44_1[L45_1]
L42_1(L43_1, L44_1)
L42_1 = "new"
function L43_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2
  L3_2 = setmetatable
  L4_2 = {}
  L5_2 = L41_1
  L3_2 = L3_2(L4_2, L5_2)
  L3_2.name = A1_2
  L3_2.asset = A0_2
  L4_2 = A2_2 or L4_2
  if not A2_2 then
    L4_2 = false
  end
  L3_2.colorCanChange = L4_2
  return L3_2
end
L41_1[L42_1] = L43_1
L42_1 = _ENV
L43_1 = "hitEffects"
L44_1 = {}
L45_1 = "new"
L45_1 = L41_1[L45_1]
L46_1 = "scr_rcbarry2"
L47_1 = "scr_exp_clown"
L45_1 = L45_1(L46_1, L47_1)
L46_1 = "new"
L46_1 = L41_1[L46_1]
L47_1 = "scr_rcbarry2"
L48_1 = "scr_clown_appears"
L46_1 = L46_1(L47_1, L48_1)
L47_1 = "new"
L47_1 = L41_1[L47_1]
L48_1 = "scr_rcpaparazzo1"
L49_1 = "scr_mich4_firework_trailburst_spawn"
L50_1 = true
L47_1 = L47_1(L48_1, L49_1, L50_1)
L48_1 = "new"
L48_1 = L41_1[L48_1]
L49_1 = "scr_indep_fireworks"
L50_1 = "scr_indep_firework_starburst"
L51_1 = true
L48_1 = L48_1(L49_1, L50_1, L51_1)
L49_1 = "new"
L49_1 = L41_1[L49_1]
L50_1 = "scr_indep_fireworks"
L51_1 = "scr_indep_firework_fountain"
L52_1 = true
L49_1 = L49_1(L50_1, L51_1, L52_1)
L50_1 = "new"
L50_1 = L41_1[L50_1]
L51_1 = "scr_rcbarry1"
L52_1 = "scr_alien_disintegrate"
L50_1 = L50_1(L51_1, L52_1)
L51_1 = "new"
L51_1 = L41_1[L51_1]
L52_1 = "scr_rcbarry2"
L53_1 = "scr_clown_bul"
L51_1 = L51_1(L52_1, L53_1)
L52_1 = "new"
L52_1 = L41_1[L52_1]
L53_1 = "proj_indep_firework"
L54_1 = "scr_indep_firework_grd_burst"
L52_1 = L52_1(L53_1, L54_1)
L53_1 = "new"
L53_1 = L41_1[L53_1]
L54_1 = "scr_rcbarry2"
L55_1 = "muz_clown"
L53_1, L54_1, L55_1, L56_1, L57_1, L58_1, L59_1, L60_1, L61_1, L62_1, L63_1, L64_1, L65_1, L66_1, L67_1, L68_1, L69_1, L70_1, L71_1, L72_1, L73_1, L74_1, L75_1, L76_1, L77_1, L78_1, L79_1, L80_1, L81_1 = L53_1(L54_1, L55_1)
L44_1[1] = L45_1
L44_1[2] = L46_1
L44_1[3] = L47_1
L44_1[4] = L48_1
L44_1[5] = L49_1
L44_1[6] = L50_1
L44_1[7] = L51_1
L44_1[8] = L52_1
L44_1[9] = L53_1
L44_1[10] = L54_1
L44_1[11] = L55_1
L44_1[12] = L56_1
L44_1[13] = L57_1
L44_1[14] = L58_1
L44_1[15] = L59_1
L44_1[16] = L60_1
L44_1[17] = L61_1
L44_1[18] = L62_1
L44_1[19] = L63_1
L44_1[20] = L64_1
L44_1[21] = L65_1
L44_1[22] = L66_1
L44_1[23] = L67_1
L44_1[24] = L68_1
L44_1[25] = L69_1
L44_1[26] = L70_1
L44_1[27] = L71_1
L44_1[28] = L72_1
L44_1[29] = L73_1
L44_1[30] = L74_1
L44_1[31] = L75_1
L44_1[32] = L76_1
L44_1[33] = L77_1
L44_1[34] = L78_1
L44_1[35] = L79_1
L44_1[36] = L80_1
L44_1[37] = L81_1
L42_1[L43_1] = L44_1
L42_1 = 1
L43_1 = _ENV
L44_1 = "set_effectColour"
function L45_1(A0_2)
  local L1_2
  hiteffectColour = A0_2
end
L43_1[L44_1] = L45_1
L43_1 = _ENV
L44_1 = "hit_effect_option"
function L45_1(A0_2)
  local L1_2
  L42_1 = A0_2
end
L43_1[L44_1] = L45_1
L43_1 = _ENV
L44_1 = "Hit_effect"
function L45_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L0_2 = hitEffects
  L1_2 = L42_1
  L0_2 = L0_2[L1_2]
  L1_2 = STREAMING
  L1_2 = L1_2.HAS_NAMED_PTFX_ASSET_LOADED
  L2_2 = L0_2.asset
  L1_2 = L1_2(L2_2)
  if not L1_2 then
    L1_2 = STREAMING
    L1_2 = L1_2.REQUEST_NAMED_PTFX_ASSET
    L2_2 = L0_2.asset
    return L1_2(L2_2)
  end
  L1_2 = v3
  L1_2 = L1_2.new
  L1_2 = L1_2()
  L2_2 = WEAPON
  L2_2 = L2_2.GET_PED_LAST_WEAPON_IMPACT_COORD
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2 = L3_2()
  L4_2 = L1_2
  L2_2 = L2_2(L3_2, L4_2)
  if L2_2 then
    L2_2 = get_raycast_result
    L3_2 = 1000.0
    L2_2 = L2_2(L3_2)
    L3_2 = L2_2.surfaceNormal
    L4_2 = L3_2
    L3_2 = L3_2.toRot
    L3_2 = L3_2(L4_2)
    L4_2 = GRAPHICS
    L4_2 = L4_2.USE_PARTICLE_FX_ASSET
    L5_2 = L0_2.asset
    L4_2(L5_2)
    L4_2 = L0_2.colorCanChange
    if L4_2 then
      L4_2 = GRAPHICS
      L4_2 = L4_2.SET_PARTICLE_FX_NON_LOOPED_COLOUR
      L5_2 = hiteffectColour
      L5_2 = L5_2.r
      L6_2 = hiteffectColour
      L6_2 = L6_2.g
      L7_2 = hiteffectColour
      L7_2 = L7_2.b
      L4_2(L5_2, L6_2, L7_2)
    end
    L4_2 = GRAPHICS
    L5_2 = "START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD"
    L4_2 = L4_2[L5_2]
    L5_2 = L0_2.name
    L6_2 = L1_2.x
    L7_2 = L1_2.y
    L8_2 = L1_2.z
    L9_2 = L3_2.x
    L9_2 = L9_2 - 90.0
    L10_2 = L3_2.y
    L11_2 = L3_2.z
    L12_2 = 1.0
    L13_2 = false
    L14_2 = false
    L15_2 = false
    L16_2 = false
    L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  end
end
L43_1[L44_1] = L45_1
L43_1 = _ENV
L44_1 = "Cage_proof"
function L45_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L0_2 = ENTITY
  L0_2 = L0_2.GET_ENTITY_COORDS
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = false
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = ipairs
  L2_2 = cageModels
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = OBJECT
    L7_2 = L7_2.GET_CLOSEST_OBJECT_OF_TYPE
    L8_2 = L0_2.x
    L9_2 = L0_2.y
    L10_2 = L0_2.z
    L11_2 = 8.0
    L12_2 = L6_2
    L13_2 = false
    L14_2 = false
    L15_2 = false
    L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
    if 0 ~= L7_2 then
      L8_2 = ENTITY
      L8_2 = L8_2.DOES_ENTITY_EXIST
      L9_2 = L7_2
      L8_2 = L8_2(L9_2)
      if L8_2 then
        L8_2 = request_control
        L9_2 = L7_2
        L8_2(L9_2)
        L8_2 = delete_entity
        L9_2 = L7_2
        L8_2(L9_2)
      end
    end
  end
end
L43_1[L44_1] = L45_1
L43_1 = _ENV
L44_1 = "CreateVehicle"
function L45_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2
  L4_2 = STREAMING
  L4_2 = L4_2.REQUEST_MODEL
  L5_2 = A0_2
  L4_2(L5_2)
  while true do
    L4_2 = STREAMING
    L4_2 = L4_2.HAS_MODEL_LOADED
    L5_2 = A0_2
    L4_2 = L4_2(L5_2)
    if L4_2 then
      break
    end
    L4_2 = util
    L4_2 = L4_2.yield
    L4_2()
  end
  L4_2 = entities
  L4_2 = L4_2.create_vehicle
  L5_2 = A0_2
  L6_2 = A1_2
  L7_2 = A2_2
  L4_2 = L4_2(L5_2, L6_2, L7_2)
  L5_2 = STREAMING
  L5_2 = L5_2.SET_MODEL_AS_NO_LONGER_NEEDED
  L6_2 = A0_2
  L5_2(L6_2)
  if A3_2 then
    L5_2 = ENTITY
    L5_2 = L5_2.SET_ENTITY_INVINCIBLE
    L6_2 = L4_2
    L7_2 = true
    L5_2(L6_2, L7_2)
  end
  return L4_2
end
L43_1[L44_1] = L45_1
L43_1 = _ENV
L44_1 = "CreatePed"
function L45_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2
  L4_2 = STREAMING
  L4_2 = L4_2.REQUEST_MODEL
  L5_2 = A1_2
  L4_2(L5_2)
  while true do
    L4_2 = STREAMING
    L4_2 = L4_2.HAS_MODEL_LOADED
    L5_2 = A1_2
    L4_2 = L4_2(L5_2)
    if L4_2 then
      break
    end
    L4_2 = util
    L4_2 = L4_2.yield
    L4_2()
  end
  L4_2 = entities
  L4_2 = L4_2.create_ped
  L5_2 = A0_2
  L6_2 = A1_2
  L7_2 = A2_2
  L8_2 = A3_2
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  L5_2 = STREAMING
  L5_2 = L5_2.SET_MODEL_AS_NO_LONGER_NEEDED
  L6_2 = A1_2
  L5_2(L6_2)
  return L4_2
end
L43_1[L44_1] = L45_1
L43_1 = _ENV
L44_1 = "CreateObject"
function L45_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2
  L3_2 = STREAMING
  L3_2 = L3_2.REQUEST_MODEL
  L4_2 = A0_2
  L3_2(L4_2)
  while true do
    L3_2 = STREAMING
    L3_2 = L3_2.HAS_MODEL_LOADED
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    if L3_2 then
      break
    end
    L3_2 = util
    L3_2 = L3_2.yield
    L3_2()
  end
  L3_2 = entities
  L3_2 = L3_2.create_object
  L4_2 = A0_2
  L5_2 = A1_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = STREAMING
  L4_2 = L4_2.SET_MODEL_AS_NO_LONGER_NEEDED
  L5_2 = A0_2
  L4_2(L5_2)
  if A2_2 then
    L4_2 = ENTITY
    L4_2 = L4_2.FREEZE_ENTITY_POSITION
    L5_2 = L3_2
    L6_2 = true
    L4_2(L5_2, L6_2)
  end
  return L3_2
end
L43_1[L44_1] = L45_1
L43_1 = _ENV
L44_1 = "task_veh_crash"
function L45_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED_SCRIPT_INDEX
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = PED
  L2_2 = L2_2.IS_PED_IN_ANY_VEHICLE
  L3_2 = L1_2
  L4_2 = true
  L2_2 = L2_2(L3_2, L4_2)
  if L2_2 then
    L2_2 = PED
    L2_2 = L2_2.GET_VEHICLE_PED_IS_IN
    L3_2 = L1_2
    L4_2 = false
    L2_2 = L2_2(L3_2, L4_2)
    L3_2 = TASK
    L3_2 = L3_2.TASK_VEHICLE_TEMP_ACTION
    L4_2 = L1_2
    L5_2 = L2_2
    L6_2 = 16
    L7_2 = 100
    L3_2(L4_2, L5_2, L6_2, L7_2)
    L3_2 = TASK
    L3_2 = L3_2.TASK_VEHICLE_TEMP_ACTION
    L4_2 = L1_2
    L5_2 = L2_2
    L6_2 = 17
    L7_2 = 100
    L3_2(L4_2, L5_2, L6_2, L7_2)
    L3_2 = TASK
    L3_2 = L3_2.TASK_VEHICLE_TEMP_ACTION
    L4_2 = L1_2
    L5_2 = L2_2
    L6_2 = 18
    L7_2 = 100
    L3_2(L4_2, L5_2, L6_2, L7_2)
  else
    L2_2 = util
    L2_2 = L2_2.toast
    L3_2 = "玩家不在载具"
    L2_2(L3_2)
  end
end
L43_1[L44_1] = L45_1
L43_1 = _ENV
L44_1 = "prop_grass"
function L45_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L1_2 = 1
  L2_2 = 30
  L3_2 = 1
  for L4_2 = L1_2, L2_2, L3_2 do
    L5_2 = PLAYER
    L5_2 = L5_2.GET_PLAYER_PED
    L6_2 = A0_2
    L5_2 = L5_2(L6_2)
    if 0 ~= L5_2 then
      L6_2 = util
      L6_2 = L6_2.joaat
      L7_2 = "prop_tall_grass_ba"
      L6_2 = L6_2(L7_2)
      L7_2 = ENTITY
      L7_2 = L7_2.GET_ENTITY_COORDS
      L8_2 = L5_2
      L9_2 = false
      L7_2 = L7_2(L8_2, L9_2)
      L8_2 = create_object
      L9_2 = L6_2
      L10_2 = L7_2.x
      L11_2 = L7_2.y
      L12_2 = L7_2.z
      L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2)
      L9_2 = ENTITY
      L9_2 = L9_2.SET_ENTITY_COORDS_NO_OFFSET
      L10_2 = L8_2
      L11_2 = L7_2.x
      L12_2 = L7_2.y
      L13_2 = L7_2.z
      L14_2 = false
      L15_2 = true
      L16_2 = true
      L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
      L9_2 = util
      L9_2 = L9_2.yield
      L10_2 = 500
      L9_2(L10_2)
      L9_2 = delete_entity
      L10_2 = L8_2
      L9_2(L10_2)
    end
  end
end
L43_1[L44_1] = L45_1
L43_1 = _ENV
L44_1 = "PED_crash"
function L45_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L1_2 = ENTITY
  L1_2 = L1_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = 0
  L4_2 = 3
  L5_2 = 0
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2)
  L2_2 = create_ped
  L3_2 = 26
  L4_2 = util
  L4_2 = L4_2.joaat
  L5_2 = "a_c_rat"
  L4_2 = L4_2(L5_2)
  L5_2 = L1_2.x
  L6_2 = L1_2.y
  L7_2 = L1_2.z
  L8_2 = 0
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  L3_2 = create_vehicle
  L4_2 = 2623428164
  L5_2 = L1_2.x
  L6_2 = L1_2.y
  L7_2 = L1_2.z
  L8_2 = 0
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
  L4_2 = PED
  L4_2 = L4_2.SET_PED_INTO_VEHICLE
  L5_2 = L2_2
  L6_2 = L3_2
  L7_2 = -1
  L4_2(L5_2, L6_2, L7_2)
  L4_2 = ENTITY
  L4_2 = L4_2.FREEZE_ENTITY_POSITION
  L5_2 = L3_2
  L6_2 = true
  L4_2(L5_2, L6_2)
  L4_2 = TASK
  L4_2 = L4_2.TASK_OPEN_VEHICLE_DOOR
  L5_2 = L2_2
  L6_2 = L3_2
  L7_2 = 9999
  L8_2 = -1
  L9_2 = 2
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = TASK
  L4_2 = L4_2.TASK_LEAVE_VEHICLE
  L5_2 = L2_2
  L6_2 = L3_2
  L7_2 = 0
  L4_2(L5_2, L6_2, L7_2)
  L4_2 = util
  L4_2 = L4_2.yield
  L5_2 = 50
  L4_2(L5_2)
  L4_2 = FIRE
  L4_2 = L4_2.ADD_EXPLOSION
  L5_2 = L1_2.x
  L6_2 = L1_2.y
  L7_2 = L1_2.z
  L8_2 = 0
  L9_2 = 1
  L10_2 = true
  L11_2 = false
  L12_2 = 0
  L13_2 = false
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L4_2 = delete_entity
  L5_2 = L2_2
  L4_2(L5_2)
end
L43_1[L44_1] = L45_1
L43_1 = _ENV
L44_1 = "Invalid_rope"
function L45_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = L1_2
  L4_2 = true
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = create_vehicle
  L4_2 = 4244420235
  L5_2 = L2_2.x
  L6_2 = L2_2.y
  L7_2 = L2_2.z
  L8_2 = ENTITY
  L8_2 = L8_2.GET_ENTITY_HEADING
  L9_2 = PLAYER
  L9_2 = L9_2.PLAYER_PED_ID
  L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2 = L9_2()
  L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2 = L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
  L4_2 = ENTITY
  L4_2 = L4_2.GET_ENTITY_COORDS
  L5_2 = L3_2
  L6_2 = true
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = create_vehicle
  L6_2 = 410882957
  L7_2 = L2_2.x
  L8_2 = L2_2.y
  L9_2 = L2_2.z
  L10_2 = ENTITY
  L10_2 = L10_2.GET_ENTITY_HEADING
  L11_2 = PLAYER
  L11_2 = L11_2.PLAYER_PED_ID
  L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2 = L11_2()
  L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2 = L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
  L6_2 = ENTITY
  L6_2 = L6_2.GET_ENTITY_COORDS
  L7_2 = L5_2
  L8_2 = true
  L6_2 = L6_2(L7_2, L8_2)
  L7_2 = PHYSICS
  L7_2 = L7_2.ADD_ROPE
  L8_2 = L2_2.x
  L9_2 = L2_2.y
  L10_2 = L2_2.z
  L11_2 = 0
  L12_2 = 0
  L13_2 = 10
  L14_2 = 1
  L15_2 = 1
  L16_2 = 0
  L17_2 = 1
  L18_2 = 1
  L19_2 = false
  L20_2 = false
  L21_2 = false
  L22_2 = 1.0
  L23_2 = false
  L24_2 = 0
  L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
  L8_2 = PHYSICS
  L8_2 = L8_2.ATTACH_ENTITIES_TO_ROPE
  L9_2 = L7_2
  L10_2 = L3_2
  L11_2 = L5_2
  L12_2 = L4_2.x
  L13_2 = L4_2.y
  L14_2 = L4_2.z
  L15_2 = L6_2.x
  L16_2 = L6_2.y
  L17_2 = L6_2.z
  L18_2 = 2
  L19_2 = false
  L20_2 = false
  L21_2 = 0
  L22_2 = 0
  L23_2 = "Center"
  L24_2 = "Center"
  L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
end
L43_1[L44_1] = L45_1
L43_1 = _ENV
L44_1 = "new_guibeng"
function L45_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2
  L1_2 = {}
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "boattrailer"
  L2_2 = L2_2(L3_2)
  L3_2 = util
  L3_2 = L3_2.joaat
  L4_2 = "trailersmall"
  L3_2 = L3_2(L4_2)
  L4_2 = util
  L4_2 = L4_2.joaat
  L5_2 = "raketrailer"
  L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2 = L4_2(L5_2)
  L1_2[1] = L2_2
  L1_2[2] = L3_2
  L1_2[3] = L4_2
  L1_2[4] = L5_2
  L1_2[5] = L6_2
  L1_2[6] = L7_2
  L1_2[7] = L8_2
  L1_2[8] = L9_2
  L1_2[9] = L10_2
  L1_2[10] = L11_2
  L1_2[11] = L12_2
  L1_2[12] = L13_2
  L1_2[13] = L14_2
  L1_2[14] = L15_2
  L1_2[15] = L16_2
  L1_2[16] = L17_2
  L1_2[17] = L18_2
  L1_2[18] = L19_2
  L1_2[19] = L20_2
  L1_2[20] = L21_2
  L1_2[21] = L22_2
  L1_2[22] = L23_2
  L1_2[23] = L24_2
  L1_2[24] = L25_2
  L1_2[25] = L26_2
  L1_2[26] = L27_2
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = PLAYER
  L3_2 = L3_2.GET_PLAYER_PED
  L4_2 = A0_2
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2 = L3_2(L4_2)
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2)
  L3_2 = CreatePed
  L4_2 = 26
  L5_2 = util
  L5_2 = L5_2.joaat
  L6_2 = "ig_kaylee"
  L5_2 = L5_2(L6_2)
  L6_2 = L2_2
  L7_2 = 0
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
  L4_2 = ENTITY
  L4_2 = L4_2.SET_ENTITY_VISIBLE
  L5_2 = L3_2
  L6_2 = false
  L4_2(L5_2, L6_2)
  L4_2 = 1
  L5_2 = 3
  L6_2 = 1
  for L7_2 = L4_2, L5_2, L6_2 do
    L8_2 = ENTITY
    L8_2 = L8_2.SET_ENTITY_COORDS_NO_OFFSET
    L9_2 = L3_2
    L10_2 = L2_2.x
    L11_2 = L2_2.y
    L12_2 = L2_2.z
    L8_2(L9_2, L10_2, L11_2, L12_2)
    L8_2 = pairs
    L9_2 = L1_2
    L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2)
    for L12_2, L13_2 in L8_2, L9_2, L10_2, L11_2 do
      L14_2 = {}
      L15_2 = CreateVehicle
      L16_2 = L13_2
      L17_2 = L2_2
      L18_2 = 0
      L15_2 = L15_2(L16_2, L17_2, L18_2)
      L14_2[L12_2] = L15_2
      L15_2 = pairs
      L16_2 = L14_2
      L15_2, L16_2, L17_2, L18_2 = L15_2(L16_2)
      for L19_2, L20_2 in L15_2, L16_2, L17_2, L18_2 do
        L21_2 = ENTITY
        L22_2 = "ATTACH_ENTITY_BONE_TO_ENTITY_BONE_Y_FORWARD"
        L21_2 = L21_2[L22_2]
        L22_2 = L20_2
        L23_2 = L3_2
        L24_2 = 0
        L25_2 = 0
        L26_2 = true
        L27_2 = true
        L21_2(L22_2, L23_2, L24_2, L25_2, L26_2, L27_2)
      end
    end
    L8_2 = util
    L8_2 = L8_2.yield
    L9_2 = 100
    L8_2(L9_2)
    L8_2 = FIRE
    L8_2 = L8_2.ADD_EXPLOSION
    L9_2 = L2_2.x
    L10_2 = L2_2.y
    L11_2 = L2_2.z
    L12_2 = 4
    L13_2 = 100
    L14_2 = true
    L15_2 = false
    L16_2 = 1
    L17_2 = false
    L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  end
end
L43_1[L44_1] = L45_1
L43_1 = _ENV
L44_1 = "nature"
function L45_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L0_2 = PLAYER
  L0_2 = L0_2.PLAYER_ID
  L0_2 = L0_2()
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "h4_prop_bush_mang_ad"
  L2_2 = L2_2(L3_2)
  L3_2 = util
  L3_2 = L3_2.yield
  L4_2 = 100
  L3_2(L4_2)
  L3_2 = ENTITY
  L3_2 = L3_2.SET_ENTITY_VISIBLE
  L4_2 = L1_2
  L5_2 = false
  L3_2(L4_2, L5_2)
  L3_2 = 0
  L4_2 = 110
  L5_2 = 1
  for L6_2 = L3_2, L4_2, L5_2 do
    L7_2 = PLAYER
    L7_2 = L7_2.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE
    L8_2 = L0_2
    L9_2 = L2_2
    L7_2(L8_2, L9_2)
    L7_2 = PED
    L7_2 = L7_2.SET_PED_COMPONENT_VARIATION
    L8_2 = L1_2
    L9_2 = 5
    L10_2 = L6_2
    L11_2 = 0
    L12_2 = 0
    L7_2(L8_2, L9_2, L10_2, L11_2, L12_2)
    L7_2 = util
    L7_2 = L7_2.yield
    L8_2 = 25
    L7_2(L8_2)
    L7_2 = PLAYER
    L8_2 = "CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE"
    L7_2 = L7_2[L8_2]
    L8_2 = L0_2
    L7_2(L8_2)
  end
  L3_2 = 1
  L4_2 = 5
  L5_2 = 1
  for L6_2 = L3_2, L4_2, L5_2 do
    L7_2 = util
    L7_2 = L7_2.spoof_script
    L8_2 = "freemode"
    L9_2 = SYSTEM
    L9_2 = L9_2.WAIT
    L7_2(L8_2, L9_2)
  end
  L3_2 = ENTITY
  L3_2 = L3_2.SET_ENTITY_HEALTH
  L4_2 = L1_2
  L5_2 = 0
  L6_2 = 0
  L3_2(L4_2, L5_2, L6_2)
  L3_2 = players
  L3_2 = L3_2.get_position
  L4_2 = L0_2
  L3_2 = L3_2(L4_2)
  L4_2 = NETWORK
  L4_2 = L4_2.NETWORK_RESURRECT_LOCAL_PLAYER
  L5_2 = L3_2.x
  L6_2 = L3_2.y
  L7_2 = L3_2.z
  L8_2 = 0
  L9_2 = false
  L10_2 = false
  L11_2 = 0
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L4_2 = ENTITY
  L4_2 = L4_2.SET_ENTITY_VISIBLE
  L5_2 = L1_2
  L6_2 = true
  L4_2(L5_2, L6_2)
end
L43_1[L44_1] = L45_1
L43_1 = _ENV
L44_1 = "unknown"
function L45_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2
  L0_2 = 0
  L1_2 = 32
  L2_2 = 1
  for L3_2 = L0_2, L1_2, L2_2 do
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2 = L4_2()
    L5_2 = ENTITY
    L5_2 = L5_2.GET_ENTITY_COORDS
    L6_2 = L4_2
    L7_2 = true
    L5_2 = L5_2(L6_2, L7_2)
    L6_2 = PLAYER
    L6_2 = L6_2.GET_PLAYER_PED_SCRIPT_INDEX
    L7_2 = L3_2
    L6_2 = L6_2(L7_2)
    L7_2 = ENTITY
    L7_2 = L7_2.GET_ENTITY_COORDS
    L8_2 = L6_2
    L9_2 = true
    L7_2 = L7_2(L8_2, L9_2)
    L8_2 = L5_2.x
    L8_2 = L8_2 + 10
    L5_2.x = L8_2
    L8_2 = L7_2.x
    L8_2 = L8_2 + 10
    L7_2.x = L8_2
    L8_2 = CreateObject
    L9_2 = util
    L9_2 = L9_2.joaat
    L10_2 = "apa_prop_flag_china"
    L9_2 = L9_2(L10_2)
    L10_2 = L7_2
    L11_2 = ENTITY
    L11_2 = L11_2.GET_ENTITY_HEADING
    L12_2 = L4_2
    L11_2 = L11_2(L12_2)
    L12_2 = true
    L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2)
    L9_2 = ENTITY
    L9_2 = L9_2.GET_ENTITY_COORDS
    L10_2 = L8_2
    L11_2 = true
    L9_2 = L9_2(L10_2, L11_2)
    L10_2 = CreatePed
    L11_2 = 26
    L12_2 = util
    L12_2 = L12_2.joaat
    L13_2 = "A_C_HEN"
    L12_2 = L12_2(L13_2)
    L13_2 = L7_2
    L14_2 = 0
    L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2)
    L11_2 = ENTITY
    L11_2 = L11_2.GET_ENTITY_COORDS
    L12_2 = L8_2
    L13_2 = true
    L11_2 = L11_2(L12_2, L13_2)
    L12_2 = PHYSICS
    L12_2 = L12_2.ADD_ROPE
    L13_2 = L7_2.x
    L14_2 = L7_2.y
    L15_2 = L7_2.z
    L16_2 = 0
    L17_2 = 0
    L18_2 = 0
    L19_2 = 1
    L20_2 = 1
    L21_2 = 0.003
    L22_2 = 1
    L23_2 = 1
    L24_2 = true
    L25_2 = true
    L26_2 = true
    L27_2 = 1.0
    L28_2 = true
    L29_2 = 0
    L12_2 = L12_2(L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2)
    L13_2 = PHYSICS
    L13_2 = L13_2.ATTACH_ENTITIES_TO_ROPE
    L14_2 = L12_2
    L15_2 = L8_2
    L16_2 = L10_2
    L17_2 = L9_2.x
    L18_2 = L9_2.y
    L19_2 = L9_2.z
    L20_2 = L11_2.x
    L21_2 = L11_2.y
    L22_2 = L11_2.z
    L23_2 = 2
    L24_2 = false
    L25_2 = false
    L26_2 = 0
    L27_2 = 0
    L28_2 = "Center"
    L29_2 = "Center"
    L13_2(L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2)
    L13_2 = util
    L13_2 = L13_2.yield
    L14_2 = 3500
    L13_2(L14_2)
    L13_2 = PHYSICS
    L13_2 = L13_2.DELETE_CHILD_ROPE
    L14_2 = L12_2
    L13_2(L14_2)
    L13_2 = delete_entity
    L14_2 = L10_2
    L13_2(L14_2)
  end
end
L43_1[L44_1] = L45_1
L43_1 = {}
L44_1 = {}
L45_1 = 4090
L46_1 = 64017
L47_1 = 2108
L48_1 = 20781
L49_1 = 31086
L50_1 = 46078
L51_1 = 16335
L52_1 = 22711
L53_1 = 2992
L44_1[1] = L45_1
L44_1[2] = L46_1
L44_1[3] = L47_1
L44_1[4] = L48_1
L44_1[5] = L49_1
L44_1[6] = L50_1
L44_1[7] = L51_1
L44_1[8] = L52_1
L44_1[9] = L53_1
L45_1 = _ENV
L46_1 = "fireself"
function L47_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2
  if A0_2 then
    L1_2 = request_ptfx_asset
    L2_2 = "core"
    L1_2(L2_2)
    L1_2 = pairs
    L2_2 = L44_1
    L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
    for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
      L7_2 = GRAPHICS
      L7_2 = L7_2.USE_PARTICLE_FX_ASSET
      L8_2 = "core"
      L7_2(L8_2)
      L7_2 = PED
      L7_2 = L7_2.GET_PED_BONE_INDEX
      L8_2 = PLAYER
      L8_2 = L8_2.PLAYER_PED_ID
      L8_2 = L8_2()
      L9_2 = L6_2
      L7_2 = L7_2(L8_2, L9_2)
      L8_2 = GRAPHICS
      L9_2 = "START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE"
      L8_2 = L8_2[L9_2]
      L9_2 = "fire_wrecked_plane_cockpit"
      L10_2 = PLAYER
      L10_2 = L10_2.PLAYER_PED_ID
      L10_2 = L10_2()
      L11_2 = 0.0
      L12_2 = 0.0
      L13_2 = 0.0
      L14_2 = 0.0
      L15_2 = 0.0
      L16_2 = 90.0
      L17_2 = L7_2
      L18_2 = 0.5
      L19_2 = false
      L20_2 = false
      L21_2 = false
      L22_2 = 0
      L23_2 = 0
      L24_2 = 0
      L25_2 = 0
      L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
      L9_2 = L43_1
      L9_2 = #L9_2
      L10_2 = L9_2 + 1
      L9_2 = L43_1
      L9_2[L10_2] = L8_2
      L9_2 = GRAPHICS
      L9_2 = L9_2.SET_PARTICLE_FX_LOOPED_COLOUR
      L10_2 = L8_2
      L11_2 = 100
      L12_2 = 100
      L13_2 = 100
      L14_2 = 0
      L9_2(L10_2, L11_2, L12_2, L13_2, L14_2)
    end
  else
    L1_2 = pairs
    L2_2 = L43_1
    L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
    for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
      L7_2 = GRAPHICS
      L7_2 = L7_2.REMOVE_PARTICLE_FX
      L8_2 = L6_2
      L9_2 = false
      L7_2(L8_2, L9_2)
      L7_2 = GRAPHICS
      L7_2 = L7_2.STOP_PARTICLE_FX_LOOPED
      L8_2 = L6_2
      L9_2 = false
      L7_2(L8_2, L9_2)
    end
  end
end
L45_1[L46_1] = L47_1
L45_1 = _ENV
L46_1 = "get_player_vehicle_in_control"
function L47_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_ID
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2 = L3_2()
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  L3_2 = PLAYER
  L3_2 = L3_2.GET_PLAYER_PED_SCRIPT_INDEX
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = ENTITY
  L4_2 = L4_2.GET_ENTITY_COORDS
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  L5_2 = ENTITY
  L5_2 = L5_2.GET_ENTITY_COORDS
  L6_2 = L2_2
  L5_2 = L5_2(L6_2)
  L6_2 = SYSTEM
  L6_2 = L6_2.VDIST2
  L7_2 = L4_2.x
  L8_2 = L4_2.y
  L9_2 = 0
  L10_2 = L5_2.x
  L11_2 = L5_2.y
  L12_2 = 0
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L7_2 = NETWORK
  L7_2 = L7_2.NETWORK_IS_IN_SPECTATOR_MODE
  L7_2 = L7_2()
  L8_2 = PED
  L8_2 = L8_2.GET_VEHICLE_PED_IS_IN
  L9_2 = L3_2
  L10_2 = true
  L8_2 = L8_2(L9_2, L10_2)
  if A1_2 then
    L9_2 = A1_2.near_only
    if L9_2 and 0 == L8_2 then
      L9_2 = 0
      return L9_2
    end
  end
  if 0 == L8_2 and L3_2 ~= L2_2 then
    L9_2 = 1500
    if L6_2 > L9_2 and not L7_2 then
      L9_2 = show_busyspinner
      L10_2 = "AUTO_SPECTATE"
      L9_2(L10_2)
      L9_2 = NETWORK
      L9_2 = L9_2.NETWORK_SET_IN_SPECTATOR_MODE
      L10_2 = true
      L11_2 = L3_2
      L9_2(L10_2, L11_2)
      if A1_2 then
        L9_2 = A1_2.loops
        if nil ~= L9_2 then
          L9_2 = A1_2.loops
          if L9_2 then
            goto lbl_71
          end
        end
      end
      L9_2 = 30
      ::lbl_71::
      while 0 == L8_2 and L9_2 > 0 do
        L10_2 = util
        L10_2 = L10_2.yield
        L11_2 = 100
        L10_2(L11_2)
        L10_2 = PED
        L10_2 = L10_2.GET_VEHICLE_PED_IS_IN
        L11_2 = L3_2
        L12_2 = true
        L10_2 = L10_2(L11_2, L12_2)
        L8_2 = L10_2
        L9_2 = L9_2 - 1
      end
      L10_2 = HUD
      L10_2 = L10_2.BUSYSPINNER_OFF
      L10_2()
    end
  end
  if L8_2 > 0 then
    L9_2 = NETWORK
    L9_2 = L9_2.NETWORK_HAS_CONTROL_OF_ENTITY
    L10_2 = L8_2
    L9_2 = L9_2(L10_2)
    if L9_2 then
      return L8_2
    end
    L9_2 = NETWORK
    L9_2 = L9_2.NETWORK_GET_NETWORK_ID_FROM_ENTITY
    L10_2 = L8_2
    L9_2 = L9_2(L10_2)
    L10_2 = false
    L11_2 = 15
    L12_2 = NETWORK
    L12_2 = L12_2.SET_NETWORK_ID_CAN_MIGRATE
    L13_2 = L9_2
    L14_2 = true
    L12_2(L13_2, L14_2)
    while not L10_2 do
      L12_2 = NETWORK
      L12_2 = L12_2.NETWORK_REQUEST_CONTROL_OF_ENTITY
      L13_2 = L8_2
      L12_2 = L12_2(L13_2)
      L10_2 = L12_2
      L11_2 = L11_2 - 1
      L12_2 = util
      L12_2 = L12_2.yield
      L13_2 = 15
      L12_2(L13_2)
      if L11_2 <= 0 then
        break
      end
    end
  end
  if not L7_2 then
    L9_2 = NETWORK
    L9_2 = L9_2.NETWORK_SET_IN_SPECTATOR_MODE
    L10_2 = false
    L11_2 = L3_2
    L9_2(L10_2, L11_2)
  end
  return L8_2
end
L45_1[L46_1] = L47_1
L45_1 = _ENV
L46_1 = "control_vehicle"
function L47_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2
  L3_2 = get_player_vehicle_in_control
  L4_2 = A0_2
  L5_2 = A2_2
  L3_2 = L3_2(L4_2, L5_2)
  if L3_2 > 0 then
    L4_2 = A1_2
    L5_2 = L3_2
    L4_2(L5_2)
  else
    if nil ~= A2_2 then
      L4_2 = A2_2.silent
      if true == L4_2 then
        goto lbl_20
      end
    end
    L4_2 = _lang
    L4_2 = L4_2.toast
    L5_2 = "PLAYER_OUT_OF_RANGE"
    L4_2(L5_2)
  end
  ::lbl_20::
end
L45_1[L46_1] = L47_1
L45_1 = _ENV
L46_1 = "notify"
function L47_1(A0_2)
  local L1_2, L2_2
  L1_2 = util
  L1_2 = L1_2.toast
  L2_2 = A0_2
  L1_2(L2_2)
end
L45_1[L46_1] = L47_1
L45_1 = _ENV
L46_1 = "ExplodeThem"
function L47_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = FIRE
  L1_2 = L1_2.ADD_EXPLOSION
  L2_2 = A0_2.x
  L3_2 = A0_2.y
  L4_2 = A0_2.z
  L5_2 = 0
  L6_2 = 1.0
  L7_2 = false
  L8_2 = true
  L9_2 = 0.0
  L10_2 = false
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
end
L45_1[L46_1] = L47_1
L45_1 = _ENV
L46_1 = "is_player_friend"
function L47_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = memory
  L1_2 = L1_2.alloc
  L2_2 = 104
  L1_2 = L1_2(L2_2)
  L2_2 = NETWORK
  L2_2 = L2_2.NETWORK_HANDLE_FROM_PLAYER
  L3_2 = A0_2
  L4_2 = L1_2
  L5_2 = 13
  L2_2(L3_2, L4_2, L5_2)
  L2_2 = NETWORK
  L2_2 = L2_2.NETWORK_IS_HANDLE_VALID
  L3_2 = L1_2
  L4_2 = 13
  L2_2 = L2_2(L3_2, L4_2)
  if L2_2 then
    L2_2 = NETWORK
    L2_2 = L2_2.NETWORK_IS_FRIEND
    L3_2 = L1_2
    L2_2 = L2_2(L3_2)
  end
  return L2_2
end
L45_1[L46_1] = L47_1
L45_1 = _ENV
L46_1 = "oppKarma"
function L47_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  while true do
    L0_2 = oppressorKarma
    if not L0_2 then
      break
    end
    L0_2 = pairs
    L1_2 = players
    L1_2 = L1_2.list
    L2_2 = true
    L3_2 = true
    L4_2 = true
    L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L1_2(L2_2, L3_2, L4_2)
    L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
    for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
      L6_2 = oppressorFriendKarma
      if not L6_2 then
        L6_2 = is_player_friend
        L7_2 = L5_2
        L6_2 = L6_2(L7_2)
        if L6_2 then
          L5_2 = L5_2 + 1
      end
      else
        L6_2 = oppressorYourselfKarma
        if not L6_2 then
          L6_2 = PLAYER
          L6_2 = L6_2.PLAYER_ID
          L6_2 = L6_2()
          if L5_2 == L6_2 then
            L5_2 = L5_2 + 1
          end
        end
      end
      L6_2 = PLAYER
      L6_2 = L6_2.GET_PLAYER_PED_SCRIPT_INDEX
      L7_2 = L5_2
      L6_2 = L6_2(L7_2)
      L7_2 = PED
      L7_2 = L7_2.IS_PED_IN_MODEL
      L8_2 = L6_2
      L9_2 = 2069146067
      L7_2 = L7_2(L8_2, L9_2)
      if L7_2 then
        L7_2 = selectedKarmaMK2
        if "[Remove]" ~= L7_2 then
          L7_2 = selectedKarmaMK2
          if nil ~= L7_2 then
            goto lbl_56
          end
        end
        L7_2 = control_vehicle
        L8_2 = L5_2
        function L9_2(A0_3)
          local L1_3, L2_3
          L1_3 = delete_entity
          L2_3 = A0_3
          L1_3(L2_3)
          L1_3 = util
          L1_3 = L1_3.yield
          L2_3 = 100
          L1_3(L2_3)
        end
        L7_2(L8_2, L9_2)
        goto lbl_83
        ::lbl_56::
        L7_2 = selectedKarmaMK2
        if "[Kill]" == L7_2 then
          L7_2 = ExplodeThem
          L8_2 = ENTITY
          L8_2 = L8_2.GET_ENTITY_COORDS
          L9_2 = L6_2
          L8_2, L9_2, L10_2 = L8_2(L9_2)
          L7_2(L8_2, L9_2, L10_2)
        else
          L7_2 = selectedKarmaMK2
          if "[Remove + Kill]" == L7_2 then
            L7_2 = control_vehicle
            L8_2 = L5_2
            function L9_2(A0_3)
              local L1_3, L2_3
              L1_3 = delete_entity
              L2_3 = A0_3
              L1_3(L2_3)
            end
            L7_2(L8_2, L9_2)
            L7_2 = util
            L7_2 = L7_2.yield
            L8_2 = 100
            L7_2(L8_2)
            L7_2 = ExplodeThem
            L8_2 = ENTITY
            L8_2 = L8_2.GET_ENTITY_COORDS
            L9_2 = L6_2
            L8_2, L9_2, L10_2 = L8_2(L9_2)
            L7_2(L8_2, L9_2, L10_2)
          end
        end
        ::lbl_83::
        L7_2 = notify
        L8_2 = "检测到马克兔 "
        L9_2 = players
        L9_2 = L9_2.get_name
        L10_2 = L5_2
        L9_2 = L9_2(L10_2)
        L10_2 = " 报应启用"
        L8_2 = L8_2 .. L9_2 .. L10_2
        L7_2(L8_2)
      end
      L7_2 = util
      L7_2 = L7_2.yield
      L8_2 = 10
      L7_2(L8_2)
    end
    L0_2 = util
    L0_2 = L0_2.yield
    L1_2 = 2000
    L0_2(L1_2)
  end
end
L45_1[L46_1] = L47_1
L45_1 = _ENV
L46_1 = "auto_kill_NPC"
function L47_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = pairs
  L1_2 = entities
  L1_2 = L1_2.get_all_peds_as_handles
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2 = L1_2()
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = PED
    L6_2 = L6_2.IS_PED_A_PLAYER
    L7_2 = L5_2
    L6_2 = L6_2(L7_2)
    if not L6_2 then
      L6_2 = ENTITY
      L6_2 = L6_2.DOES_ENTITY_EXIST
      L7_2 = L5_2
      L6_2 = L6_2(L7_2)
      if L6_2 then
        L6_2 = ENTITY
        L6_2 = L6_2.SET_ENTITY_HEALTH
        L7_2 = L5_2
        L8_2 = 0.0
        L6_2(L7_2, L8_2)
      end
    end
  end
end
L45_1[L46_1] = L47_1
L45_1 = _ENV
L46_1 = "auto_kill_enemy"
function L47_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = pairs
  L1_2 = entities
  L1_2 = L1_2.get_all_peds_as_handles
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2 = L1_2()
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = PED
    L6_2 = L6_2.IS_PED_A_PLAYER
    L7_2 = L5_2
    L6_2 = L6_2(L7_2)
    if not L6_2 then
      L6_2 = PED
      L6_2 = L6_2.IS_PED_IN_COMBAT
      L7_2 = L5_2
      L8_2 = PLAYER
      L8_2 = L8_2.PLAYER_ID
      L8_2 = L8_2()
      L6_2 = L6_2(L7_2, L8_2)
      if L6_2 then
        L6_2 = ENTITY
        L6_2 = L6_2.SET_ENTITY_HEALTH
        L7_2 = L5_2
        L8_2 = 0.0
        L6_2(L7_2, L8_2)
      end
    end
  end
end
L45_1[L46_1] = L47_1
L45_1 = _ENV
L46_1 = "transit_tp"
function L47_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L0_2 = HUD
  L0_2 = L0_2.IS_WAYPOINT_ACTIVE
  L0_2 = L0_2()
  if not L0_2 then
    L0_2 = util
    L0_2 = L0_2.toast
    L1_2 = "请先在地图上标点"
    L0_2(L1_2)
    return
  end
  L0_2 = HUD
  L0_2 = L0_2.GET_BLIP_INFO_ID_COORD
  L1_2 = HUD
  L1_2 = L1_2.GET_FIRST_BLIP_INFO_ID
  L2_2 = HUD
  L2_2 = L2_2.GET_WAYPOINT_BLIP_ENUM_ID
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L2_2()
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L1_2 = PED
  L1_2 = L1_2.GET_VEHICLE_PED_IS_USING
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L2_2 = false
  repeat
    L3_2 = util
    L3_2 = L3_2.get_ground_z
    L4_2 = L0_2.x
    L5_2 = L0_2.y
    L3_2, L4_2 = L3_2(L4_2, L5_2)
    L0_2.z = L4_2
    L2_2 = L3_2
    L3_2 = util
    L3_2 = L3_2.yield
    L3_2()
  until L2_2
  if 0 ~= L1_2 then
    L3_2 = ENTITY
    L3_2 = L3_2.SET_ENTITY_VISIBLE
    L4_2 = L1_2
    L5_2 = false
    L3_2(L4_2, L5_2)
  end
  L3_2 = STREAMING
  L3_2 = L3_2.SWITCH_TO_MULTI_FIRSTPART
  L4_2 = PLAYER
  L4_2 = L4_2.PLAYER_PED_ID
  L4_2 = L4_2()
  L5_2 = 8
  L6_2 = 1
  L3_2(L4_2, L5_2, L6_2)
  L3_2 = HUD
  L3_2 = L3_2.BEGIN_TEXT_COMMAND_BUSYSPINNER_ON
  L4_2 = "PM_WAIT"
  L3_2(L4_2)
  L3_2 = HUD
  L3_2 = L3_2.END_TEXT_COMMAND_BUSYSPINNER_ON
  L4_2 = 4
  L3_2(L4_2)
  repeat
    L3_2 = util
    L3_2 = L3_2.yield
    L3_2()
    L3_2 = STREAMING
    L3_2 = L3_2.IS_SWITCH_TO_MULTI_FIRSTPART_FINISHED
    L3_2 = L3_2()
  until L3_2
  if 0 == L1_2 then
    L3_2 = ENTITY
    L3_2 = L3_2.SET_ENTITY_COORDS_NO_OFFSET
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2 = L4_2()
    L5_2 = L0_2.x
    L6_2 = L0_2.y
    L7_2 = L0_2.z
    L8_2 = false
    L9_2 = false
    L10_2 = false
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  else
    L3_2 = ENTITY
    L3_2 = L3_2.SET_ENTITY_VISIBLE
    L4_2 = L1_2
    L5_2 = false
    L3_2(L4_2, L5_2)
    L3_2 = ENTITY
    L3_2 = L3_2.SET_ENTITY_COORDS_NO_OFFSET
    L4_2 = L1_2
    L5_2 = L0_2.x
    L6_2 = L0_2.y
    L7_2 = L0_2.z
    L8_2 = false
    L9_2 = false
    L10_2 = false
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  end
  L3_2 = STREAMING
  L3_2 = L3_2.SWITCH_TO_MULTI_SECONDPART
  L4_2 = PLAYER
  L4_2 = L4_2.PLAYER_PED_ID
  L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L4_2()
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L3_2 = STREAMING
  L3_2 = L3_2.ALLOW_PLAYER_SWITCH_OUTRO
  L3_2()
  repeat
    L3_2 = util
    L3_2 = L3_2.yield
    L3_2()
    L3_2 = STREAMING
    L3_2 = L3_2.IS_PLAYER_SWITCH_IN_PROGRESS
    L3_2 = L3_2()
  until not L3_2
  if 0 == L1_2 then
    L3_2 = NETWORK
    L3_2 = L3_2.NETWORK_FADE_IN_ENTITY
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2 = L4_2()
    L5_2 = true
    L6_2 = true
    L3_2(L4_2, L5_2, L6_2)
  else
    L3_2 = NETWORK
    L3_2 = L3_2.NETWORK_FADE_IN_ENTITY
    L4_2 = L1_2
    L5_2 = true
    L6_2 = true
    L3_2(L4_2, L5_2, L6_2)
    L3_2 = NETWORK
    L3_2 = L3_2.NETWORK_FADE_IN_ENTITY
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2 = L4_2()
    L5_2 = true
    L6_2 = true
    L3_2(L4_2, L5_2, L6_2)
    L3_2 = ENTITY
    L3_2 = L3_2.SET_ENTITY_VISIBLE
    L4_2 = L1_2
    L5_2 = true
    L3_2(L4_2, L5_2)
  end
  L3_2 = HUD
  L3_2 = L3_2.BUSYSPINNER_OFF
  L3_2()
end
L45_1[L46_1] = L47_1
L45_1 = _ENV
L46_1 = "random_position"
function L47_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L0_2 = {}
  L1_2 = math
  L1_2 = L1_2.random
  L2_2 = -1794
  L3_2 = 2940
  L1_2 = L1_2(L2_2, L3_2)
  L0_2.x = L1_2
  L1_2 = math
  L1_2 = L1_2.random
  L2_2 = -3026
  L3_2 = 6298
  L1_2 = L1_2(L2_2, L3_2)
  L0_2.y = L1_2
  L1_2 = math
  L1_2 = L1_2.random
  L2_2 = 0
  L3_2 = 800
  L1_2 = L1_2(L2_2, L3_2)
  L0_2.z = L1_2
  L1_2 = waypoint_coord
  L2_2 = L0_2
  L1_2, L2_2, L3_2 = L1_2(L2_2)
  L4_2 = ENTITY
  L4_2 = L4_2.SET_ENTITY_COORDS
  L5_2 = PLAYER
  L5_2 = L5_2.PLAYER_PED_ID
  L5_2 = L5_2()
  L6_2 = L1_2
  L7_2 = L2_2
  L8_2 = L3_2
  L9_2 = false
  L10_2 = false
  L11_2 = false
  L12_2 = false
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
end
L45_1[L46_1] = L47_1
L45_1 = _ENV
L46_1 = "IS_HELP_MSG_DISPLAYED"
function L47_1(A0_2)
  local L1_2, L2_2
  L1_2 = HUD
  L2_2 = "BEGIN_TEXT_COMMAND_IS_THIS_HELP_MESSAGE_BEING_DISPLAYED"
  L1_2 = L1_2[L2_2]
  L2_2 = A0_2
  L1_2(L2_2)
  L1_2 = HUD
  L2_2 = "END_TEXT_COMMAND_IS_THIS_HELP_MESSAGE_BEING_DISPLAYED"
  L1_2 = L1_2[L2_2]
  L2_2 = 0
  return L1_2(L2_2)
end
L45_1[L46_1] = L47_1
L45_1 = _ENV
L46_1 = "DELETE_OBJECT_BY_HASH"
function L47_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = pairs
  L2_2 = entities
  L2_2 = L2_2.get_all_objects_as_handles
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2 = L2_2()
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = ENTITY
    L7_2 = L7_2.GET_ENTITY_MODEL
    L8_2 = L6_2
    L7_2 = L7_2(L8_2)
    if L7_2 == A0_2 then
      L7_2 = delete_entity
      L8_2 = L6_2
      L7_2(L8_2)
    end
  end
end
L45_1[L46_1] = L47_1
L45_1 = _ENV
L46_1 = "BlockSyncs"
function L47_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L2_2 = ipairs
  L3_2 = players
  L3_2 = L3_2.list
  L4_2 = false
  L5_2 = true
  L6_2 = true
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L3_2(L4_2, L5_2, L6_2)
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    if L7_2 ~= A0_2 then
      L8_2 = menu
      L8_2 = L8_2.ref_by_rel_path
      L9_2 = menu
      L9_2 = L9_2.player_root
      L10_2 = L7_2
      L9_2 = L9_2(L10_2)
      L10_2 = "Outgoing Syncs>Block"
      L8_2 = L8_2(L9_2, L10_2)
      L9_2 = menu
      L9_2 = L9_2.trigger_command
      L10_2 = L8_2
      L11_2 = "on"
      L9_2(L10_2, L11_2)
    end
  end
  L2_2 = util
  L2_2 = L2_2.yield
  L3_2 = 10
  L2_2(L3_2)
  L2_2 = A1_2
  L2_2()
  L2_2 = ipairs
  L3_2 = players
  L3_2 = L3_2.list
  L4_2 = false
  L5_2 = true
  L6_2 = true
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L3_2(L4_2, L5_2, L6_2)
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    if L7_2 ~= A0_2 then
      L8_2 = menu
      L8_2 = L8_2.ref_by_rel_path
      L9_2 = menu
      L9_2 = L9_2.player_root
      L10_2 = L7_2
      L9_2 = L9_2(L10_2)
      L10_2 = "Outgoing Syncs>Block"
      L8_2 = L8_2(L9_2, L10_2)
      L9_2 = menu
      L9_2 = L9_2.trigger_command
      L10_2 = L8_2
      L11_2 = "off"
      L9_2(L10_2, L11_2)
    end
  end
end
L45_1[L46_1] = L47_1
L45_1 = _ENV
L46_1 = "RqModel"
function L47_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = STREAMING
  L1_2 = L1_2.REQUEST_MODEL
  L2_2 = A0_2
  L1_2(L2_2)
  L1_2 = 0
  L2_2 = util
  L2_2 = L2_2.toast
  L3_2 = "正在请求模型..."
  L2_2(L3_2)
  while true do
    L2_2 = STREAMING
    L2_2 = L2_2.HAS_MODEL_LOADED
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    if not (not L2_2 and L1_2 < 100) then
      break
    end
    L2_2 = STREAMING
    L2_2 = L2_2.REQUEST_MODEL
    L3_2 = A0_2
    L2_2(L3_2)
    L1_2 = L1_2 + 1
    L2_2 = util
    L2_2 = L2_2.yield
    L3_2 = 10
    L2_2(L3_2)
  end
  L2_2 = STREAMING
  L2_2 = L2_2.HAS_MODEL_LOADED
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    L2_2 = util
    L2_2 = L2_2.toast
    L3_2 = "已尝试1秒,无法加载此指定模型!"
    L2_2(L3_2)
  end
end
L45_1[L46_1] = L47_1
L45_1 = _ENV
L46_1 = "ENTITY"
L45_1 = L45_1[L46_1]
L46_1 = "GET_ENTITY_COORDS"
L45_1 = L45_1[L46_1]
L46_1 = _ENV
L47_1 = "PLAYER"
L46_1 = L46_1[L47_1]
L47_1 = "GET_PLAYER_PED"
L46_1 = L46_1[L47_1]
L47_1 = _ENV
L48_1 = "aaaio"
function L49_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2
  L1_2 = players
  L1_2 = L1_2.exists
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_ID
    L1_2 = L1_2()
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = players
    L3_2 = L3_2.get_position
    L4_2 = L1_2
    L3_2 = L3_2(L4_2)
    L4_2 = BlockSyncs
    L5_2 = A0_2
    function L6_2()
      local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
      L0_3 = util
      L0_3 = L0_3.yield
      L1_3 = 100
      L0_3(L1_3)
      L0_3 = PLAYER
      L0_3 = L0_3.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE
      L1_3 = PLAYER
      L1_3 = L1_3.PLAYER_ID
      L1_3 = L1_3()
      L2_3 = 4227322399
      L0_3(L1_3, L2_3)
      L0_3 = WEAPON
      L0_3 = L0_3.GIVE_DELAYED_WEAPON_TO_PED
      L1_3 = L2_2
      L2_3 = 4222310262
      L3_3 = 100
      L4_3 = false
      L0_3(L1_3, L2_3, L3_3, L4_3)
      L0_3 = TASK
      L0_3 = L0_3.TASK_PARACHUTE_TO_TARGET
      L1_3 = L2_2
      L2_3 = L3_2.x
      L3_3 = L3_2.y
      L4_3 = L3_2.z
      L0_3(L1_3, L2_3, L3_3, L4_3)
      L0_3 = util
      L0_3 = L0_3.yield
      L0_3()
      L0_3 = TASK
      L0_3 = L0_3.CLEAR_PED_TASKS_IMMEDIATELY
      L1_3 = L2_2
      L0_3(L1_3)
      L0_3 = util
      L0_3 = L0_3.yield
      L1_3 = 250
      L0_3(L1_3)
      L0_3 = WEAPON
      L0_3 = L0_3.GIVE_DELAYED_WEAPON_TO_PED
      L1_3 = L2_2
      L2_3 = 4222310262
      L3_3 = 100
      L4_3 = false
      L0_3(L1_3, L2_3, L3_3, L4_3)
      L0_3 = PLAYER
      L1_3 = "CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE"
      L0_3 = L0_3[L1_3]
      L1_3 = L1_2
      L0_3(L1_3)
      L0_3 = util
      L0_3 = L0_3.yield
      L1_3 = 1000
      L0_3(L1_3)
      L0_3 = 1
      L1_3 = 5
      L2_3 = 1
      for L3_3 = L0_3, L1_3, L2_3 do
        L4_3 = util
        L4_3 = L4_3.spoof_script
        L5_3 = "freemode"
        L6_3 = SYSTEM
        L6_3 = L6_3.WAIT
        L4_3(L5_3, L6_3)
      end
      L0_3 = ENTITY
      L0_3 = L0_3.SET_ENTITY_HEALTH
      L1_3 = L2_2
      L2_3 = 0
      L3_3 = 0
      L0_3(L1_3, L2_3, L3_3)
      L0_3 = NETWORK
      L0_3 = L0_3.NETWORK_RESURRECT_LOCAL_PLAYER
      L1_3 = L3_2.x
      L2_3 = L3_2.y
      L3_3 = L3_2.z
      L4_3 = 0
      L5_3 = false
      L6_3 = false
      L7_3 = 0
      L0_3(L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3)
    end
    L4_2(L5_2, L6_2)
  end
  L1_2 = players
  L1_2 = L1_2.exists
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L1_2 = util
    L1_2 = L1_2.current_time_millis
    L1_2 = L1_2()
    L1_2 = L1_2 + 2000
    while true do
      L2_2 = util
      L2_2 = L2_2.current_time_millis
      L2_2 = L2_2()
      if not (L1_2 > L2_2) then
        break
      end
      L2_2 = ENTITY
      L2_2 = L2_2.GET_ENTITY_COORDS
      L3_2 = PLAYER
      L3_2 = L3_2.GET_PLAYER_PED_SCRIPT_INDEX
      L4_2 = A0_2
      L3_2 = L3_2(L4_2)
      L4_2 = true
      L2_2 = L2_2(L3_2, L4_2)
      L3_2 = 1
      L4_2 = 10
      L5_2 = 1
      for L6_2 = L3_2, L4_2, L5_2 do
        L7_2 = AUDIO
        L7_2 = L7_2.PLAY_SOUND_FROM_COORD
        L8_2 = -1
        L9_2 = "10s"
        L10_2 = L2_2.x
        L11_2 = L2_2.y
        L12_2 = L2_2.z
        L13_2 = "MP_MISSION_COUNTDOWN_SOUNDSET"
        L14_2 = true
        L15_2 = 70
        L16_2 = false
        L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
      end
      L3_2 = util
      L3_2 = L3_2.yield
      L4_2 = 0
      L3_2(L4_2)
    end
  end
  L1_2 = players
  L1_2 = L1_2.exists
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L1_2 = util
    L1_2 = L1_2.current_time_millis
    L1_2 = L1_2()
    L1_2 = L1_2 + 2000
    while true do
      L2_2 = util
      L2_2 = L2_2.current_time_millis
      L2_2 = L2_2()
      if not (L1_2 > L2_2) then
        break
      end
      L2_2 = ENTITY
      L2_2 = L2_2.GET_ENTITY_COORDS
      L3_2 = PLAYER
      L3_2 = L3_2.GET_PLAYER_PED_SCRIPT_INDEX
      L4_2 = A0_2
      L3_2 = L3_2(L4_2)
      L4_2 = true
      L2_2 = L2_2(L3_2, L4_2)
      L3_2 = 1
      L4_2 = 20
      L5_2 = 1
      for L6_2 = L3_2, L4_2, L5_2 do
        L7_2 = AUDIO
        L7_2 = L7_2.PLAY_SOUND_FROM_COORD
        L8_2 = -1
        L9_2 = "Event_Message_Purple"
        L10_2 = L2_2.x
        L11_2 = L2_2.y
        L12_2 = L2_2.z
        L13_2 = "GTAO_FM_Events_Soundset"
        L14_2 = true
        L15_2 = 1000
        L16_2 = false
        L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
        L7_2 = AUDIO
        L7_2 = L7_2.PLAY_SOUND_FROM_COORD
        L8_2 = -1
        L9_2 = "5s"
        L10_2 = L2_2.x
        L11_2 = L2_2.y
        L12_2 = L2_2.z
        L13_2 = "GTAO_FM_Events_Soundset"
        L14_2 = true
        L15_2 = 1000
        L16_2 = false
        L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
      end
      L3_2 = util
      L3_2 = L3_2.yield
      L3_2()
    end
  end
  L1_2 = players
  L1_2 = L1_2.exists
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L1_2 = PLAYER
    L1_2 = L1_2.GET_PLAYER_PED_SCRIPT_INDEX
    L2_2 = A0_2
    L1_2 = L1_2(L2_2)
    L2_2 = ENTITY
    L2_2 = L2_2.GET_ENTITY_COORDS
    L3_2 = L1_2
    L4_2 = true
    L2_2 = L2_2(L3_2, L4_2)
    L3_2 = L2_2.z
    L3_2 = L3_2 + 10
    L2_2.z = L3_2
    L3_2 = entities
    L3_2 = L3_2.get_all_vehicles_as_handles
    L3_2 = L3_2()
    veh = L3_2
    L3_2 = 1
    L4_2 = veh
    L4_2 = #L4_2
    L5_2 = 1
    for L6_2 = L3_2, L4_2, L5_2 do
      L7_2 = NETWORK
      L7_2 = L7_2.NETWORK_REQUEST_CONTROL_OF_ENTITY
      L8_2 = veh
      L8_2 = L8_2[L6_2]
      L7_2(L8_2)
      L7_2 = ENTITY
      L7_2 = L7_2.SET_ENTITY_COORDS_NO_OFFSET
      L8_2 = veh
      L8_2 = L8_2[L6_2]
      L9_2 = L2_2.x
      L10_2 = L2_2.y
      L11_2 = L2_2.z
      L12_2 = ENTITY
      L12_2 = L12_2.GET_ENTITY_HEADING
      L13_2 = L1_2
      L12_2 = L12_2(L13_2)
      L13_2 = 10
      L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
      L7_2 = TASK
      L7_2 = L7_2.TASK_VEHICLE_TEMP_ACTION
      L8_2 = L1_2
      L9_2 = veh
      L9_2 = L9_2[L6_2]
      L10_2 = 18
      L11_2 = 999
      L7_2(L8_2, L9_2, L10_2, L11_2)
      L7_2 = TASK
      L7_2 = L7_2.TASK_VEHICLE_TEMP_ACTION
      L8_2 = L1_2
      L9_2 = veh
      L9_2 = L9_2[L6_2]
      L10_2 = 16
      L11_2 = 999
      L7_2(L8_2, L9_2, L10_2, L11_2)
    end
  end
  L1_2 = players
  L1_2 = L1_2.exists
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L1_2 = {}
    L2_2 = 1492612435
    L3_2 = 3517794615
    L4_2 = 3889340782
    L5_2 = 3253274834
    L1_2[1] = L2_2
    L1_2[2] = L3_2
    L1_2[3] = L4_2
    L1_2[4] = L5_2
    L2_2 = {}
    L3_2 = 1
    L4_2 = 4
    L5_2 = 1
    for L6_2 = L3_2, L4_2, L5_2 do
      L7_2 = util
      L7_2 = L7_2.create_thread
      function L8_2()
        local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3
        L0_3 = RqModel
        L2_3 = L6_2
        L1_3 = L1_2
        L1_3 = L1_3[L2_3]
        L0_3(L1_3)
        L0_3 = L45_1
        L1_3 = L46_1
        L2_3 = A0_2
        L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3 = L1_3(L2_3)
        L0_3 = L0_3(L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3)
        L1_3 = VEHICLE
        L1_3 = L1_3.CREATE_VEHICLE
        L3_3 = L6_2
        L2_3 = L1_2
        L2_3 = L2_3[L3_3]
        L3_3 = L0_3.x
        L4_3 = L0_3.y
        L5_3 = L0_3.z
        L6_3 = math
        L6_3 = L6_3.random
        L7_3 = 0
        L8_3 = 360
        L6_3 = L6_3(L7_3, L8_3)
        L7_3 = true
        L8_3 = true
        L9_3 = false
        L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3)
        L2_3 = 1
        L3_3 = 20
        L4_3 = 1
        for L5_3 = L2_3, L3_3, L4_3 do
          L6_3 = NETWORK
          L6_3 = L6_3.NETWORK_REQUEST_CONTROL_OF_ENTITY
          L7_3 = L1_3
          L6_3(L7_3)
        end
        L2_3 = VEHICLE
        L2_3 = L2_3.SET_VEHICLE_MOD_KIT
        L3_3 = L1_3
        L4_3 = 0
        L2_3(L3_3, L4_3)
        L2_3 = 0
        L3_3 = 49
        L4_3 = 1
        for L5_3 = L2_3, L3_3, L4_3 do
          L6_3 = VEHICLE
          L6_3 = L6_3.GET_NUM_VEHICLE_MODS
          L7_3 = L1_3
          L8_3 = L5_3
          L6_3 = L6_3(L7_3, L8_3)
          L6_3 = L6_3 - 1
          L7_3 = VEHICLE
          L7_3 = L7_3.SET_VEHICLE_MOD
          L8_3 = L1_3
          L9_3 = L5_3
          L10_3 = L6_3
          L11_3 = true
          L7_3(L8_3, L9_3, L10_3, L11_3)
          L7_3 = VEHICLE
          L7_3 = L7_3.TOGGLE_VEHICLE_MOD
          L8_3 = L1_3
          L9_3 = L6_3
          L10_3 = true
          L7_3(L8_3, L9_3, L10_3)
        end
        L2_3 = 0
        L3_3 = 20
        L4_3 = 1
        for L5_3 = L2_3, L3_3, L4_3 do
          L6_3 = VEHICLE
          L6_3 = L6_3.DOES_EXTRA_EXIST
          L7_3 = L1_3
          L8_3 = L5_3
          L6_3 = L6_3(L7_3, L8_3)
          if L6_3 then
            L6_3 = VEHICLE
            L6_3 = L6_3.SET_VEHICLE_EXTRA
            L7_3 = L1_3
            L8_3 = L5_3
            L9_3 = true
            L6_3(L7_3, L8_3, L9_3)
          end
        end
        L2_3 = VEHICLE
        L2_3 = L2_3.SET_VEHICLE_TYRES_CAN_BURST
        L3_3 = L1_3
        L4_3 = false
        L2_3(L3_3, L4_3)
        L2_3 = VEHICLE
        L2_3 = L2_3.SET_VEHICLE_WINDOW_TINT
        L3_3 = L1_3
        L4_3 = 1
        L2_3(L3_3, L4_3)
        L2_3 = VEHICLE
        L2_3 = L2_3.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX
        L3_3 = L1_3
        L4_3 = 1
        L2_3(L3_3, L4_3)
        L2_3 = VEHICLE
        L2_3 = L2_3.SET_VEHICLE_NUMBER_PLATE_TEXT
        L3_3 = L1_3
        L4_3 = " "
        L2_3(L3_3, L4_3)
        L2_3 = 1
        L3_3 = 50
        L4_3 = 1
        for L5_3 = L2_3, L3_3, L4_3 do
          L6_3 = NETWORK
          L6_3 = L6_3.NETWORK_REQUEST_CONTROL_OF_ENTITY
          L7_3 = L1_3
          L6_3(L7_3)
          L6_3 = L45_1
          L7_3 = L46_1
          L8_3 = A0_2
          L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3 = L7_3(L8_3)
          L6_3 = L6_3(L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3)
          L0_3 = L6_3
          L6_3 = ENTITY
          L6_3 = L6_3.SET_ENTITY_COORDS_NO_OFFSET
          L7_3 = L1_3
          L8_3 = L0_3.x
          L9_3 = L0_3.y
          L10_3 = L0_3.z
          L11_3 = false
          L12_3 = false
          L13_3 = false
          L6_3(L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3)
          L6_3 = util
          L6_3 = L6_3.yield
          L6_3()
        end
        L2_3 = L2_2
        L2_3 = #L2_3
        L3_3 = L2_3 + 1
        L2_3 = L2_2
        L2_3[L3_3] = L1_3
      end
      L7_2(L8_2)
    end
  end
  L1_2 = players
  L1_2 = L1_2.exists
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L1_2 = 2
    L2_2 = 6
    L3_2 = 1
    for L4_2 = L1_2, L2_2, L3_2 do
      L5_2 = PLAYER
      L5_2 = L5_2.GET_PLAYER_PED_SCRIPT_INDEX
      L6_2 = A0_2
      L5_2 = L5_2(L6_2)
      pedp = L5_2
      L5_2 = ENTITY
      L5_2 = L5_2.GET_ENTITY_COORDS
      L6_2 = TargetPlayerPed
      L7_2 = true
      L5_2 = L5_2(L6_2, L7_2)
      pos = L5_2
      L5_2 = CreateVehicle
      L6_2 = 410882957
      L7_2 = pos
      L8_2 = ENTITY
      L8_2 = L8_2.GET_ENTITY_HEADING
      L9_2 = TargetPlayerPed
      L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L8_2(L9_2)
      L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
      dune = L5_2
      L5_2 = ENTITY
      L5_2 = L5_2.FREEZE_ENTITY_POSITION
      L6_2 = dune
      L7_2 = true
      L5_2(L6_2, L7_2)
      L5_2 = CreateVehicle
      L6_2 = 2971866336
      L7_2 = pos
      L8_2 = ENTITY
      L8_2 = L8_2.GET_ENTITY_HEADING
      L9_2 = TargetPlayerPed
      L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L8_2(L9_2)
      L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
      dune1 = L5_2
      L5_2 = ENTITY
      L5_2 = L5_2.FREEZE_ENTITY_POSITION
      L6_2 = dune1
      L7_2 = true
      L5_2(L6_2, L7_2)
      L5_2 = CreateVehicle
      L6_2 = 3602674979
      L7_2 = pos
      L8_2 = ENTITY
      L8_2 = L8_2.GET_ENTITY_HEADING
      L9_2 = TargetPlayerPed
      L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L8_2(L9_2)
      L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
      barracks = L5_2
      L5_2 = ENTITY
      L5_2 = L5_2.FREEZE_ENTITY_POSITION
      L6_2 = barracks
      L7_2 = true
      L5_2(L6_2, L7_2)
      L5_2 = CreateVehicle
      L6_2 = 444583674
      L7_2 = pos
      L8_2 = ENTITY
      L8_2 = L8_2.GET_ENTITY_HEADING
      L9_2 = TargetPlayerPed
      L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L8_2(L9_2)
      L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
      barracks1 = L5_2
      L5_2 = ENTITY
      L5_2 = L5_2.FREEZE_ENTITY_POSITION
      L6_2 = barracks1
      L7_2 = true
      L5_2(L6_2, L7_2)
      L5_2 = CreateVehicle
      L6_2 = 2971866336
      L7_2 = pos
      L8_2 = ENTITY
      L8_2 = L8_2.GET_ENTITY_HEADING
      L9_2 = TargetPlayerPed
      L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L8_2(L9_2)
      L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
      dunecar = L5_2
      L5_2 = ENTITY
      L5_2 = L5_2.FREEZE_ENTITY_POSITION
      L6_2 = dunecar
      L7_2 = true
      L5_2(L6_2, L7_2)
      L5_2 = CreateVehicle
      L6_2 = 3602674979
      L7_2 = pos
      L8_2 = ENTITY
      L8_2 = L8_2.GET_ENTITY_HEADING
      L9_2 = TargetPlayerPed
      L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L8_2(L9_2)
      L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
      dunecar1 = L5_2
      L5_2 = ENTITY
      L5_2 = L5_2.FREEZE_ENTITY_POSITION
      L6_2 = dunecar1
      L7_2 = true
      L5_2(L6_2, L7_2)
      L5_2 = CreateVehicle
      L6_2 = 444583674
      L7_2 = pos
      L8_2 = ENTITY
      L8_2 = L8_2.GET_ENTITY_HEADING
      L9_2 = TargetPlayerPed
      L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L8_2(L9_2)
      L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
      dunecar2 = L5_2
      L5_2 = ENTITY
      L5_2 = L5_2.FREEZE_ENTITY_POSITION
      L6_2 = dunecar2
      L7_2 = true
      L5_2(L6_2, L7_2)
      L5_2 = CreateVehicle
      L6_2 = 4244420235
      L7_2 = pos
      L8_2 = ENTITY
      L8_2 = L8_2.GET_ENTITY_HEADING
      L9_2 = TargetPlayerPed
      L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L8_2(L9_2)
      L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
      barracks3 = L5_2
      L5_2 = ENTITY
      L5_2 = L5_2.FREEZE_ENTITY_POSITION
      L6_2 = barracks3
      L7_2 = true
      L5_2(L6_2, L7_2)
      L5_2 = CreateVehicle
      L6_2 = 3602674979
      L7_2 = pos
      L8_2 = ENTITY
      L8_2 = L8_2.GET_ENTITY_HEADING
      L9_2 = TargetPlayerPed
      L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L8_2(L9_2)
      L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
      barracks31 = L5_2
      L5_2 = ENTITY
      L5_2 = L5_2.FREEZE_ENTITY_POSITION
      L6_2 = barracks31
      L7_2 = true
      L5_2(L6_2, L7_2)
      L5_2 = ENTITY
      L5_2 = L5_2.ATTACH_ENTITY_TO_ENTITY
      L6_2 = barracks3
      L7_2 = dunecar
      L8_2 = 0
      L9_2 = 0
      L10_2 = 0
      L11_2 = 0
      L12_2 = 0
      L13_2 = 0
      L14_2 = 0
      L15_2 = true
      L16_2 = true
      L17_2 = true
      L18_2 = false
      L19_2 = 0
      L20_2 = true
      L21_2 = 0
      L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
      L5_2 = ENTITY
      L5_2 = L5_2.ATTACH_ENTITY_TO_ENTITY
      L6_2 = barracks31
      L7_2 = dunecar
      L8_2 = 0
      L9_2 = 0
      L10_2 = 0
      L11_2 = 0
      L12_2 = 0
      L13_2 = 0
      L14_2 = 0
      L15_2 = true
      L16_2 = true
      L17_2 = true
      L18_2 = false
      L19_2 = 0
      L20_2 = true
      L21_2 = 0
      L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
      L5_2 = ENTITY
      L5_2 = L5_2.ATTACH_ENTITY_TO_ENTITY
      L6_2 = barracks
      L7_2 = dunecar
      L8_2 = 0
      L9_2 = 0
      L10_2 = 0
      L11_2 = 0
      L12_2 = 0
      L13_2 = 0
      L14_2 = 0
      L15_2 = true
      L16_2 = true
      L17_2 = true
      L18_2 = false
      L19_2 = 0
      L20_2 = true
      L21_2 = 0
      L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
      L5_2 = ENTITY
      L5_2 = L5_2.ATTACH_ENTITY_TO_ENTITY
      L6_2 = barracks1
      L7_2 = dunecar
      L8_2 = 0
      L9_2 = 0
      L10_2 = 0
      L11_2 = 0
      L12_2 = 0
      L13_2 = 0
      L14_2 = 0
      L15_2 = true
      L16_2 = true
      L17_2 = true
      L18_2 = false
      L19_2 = 0
      L20_2 = true
      L21_2 = 0
      L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
      L5_2 = ENTITY
      L5_2 = L5_2.ATTACH_ENTITY_TO_ENTITY
      L6_2 = dune
      L7_2 = dunecar
      L8_2 = 0
      L9_2 = 0
      L10_2 = 0
      L11_2 = 0
      L12_2 = 0
      L13_2 = 0
      L14_2 = 0
      L15_2 = true
      L16_2 = true
      L17_2 = true
      L18_2 = false
      L19_2 = 0
      L20_2 = true
      L21_2 = 0
      L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
      L5_2 = ENTITY
      L5_2 = L5_2.ATTACH_ENTITY_TO_ENTITY
      L6_2 = dune1
      L7_2 = dunecar
      L8_2 = 0
      L9_2 = 0
      L10_2 = 0
      L11_2 = 0
      L12_2 = 0
      L13_2 = 0
      L14_2 = 0
      L15_2 = true
      L16_2 = true
      L17_2 = true
      L18_2 = false
      L19_2 = 0
      L20_2 = true
      L21_2 = 0
      L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
      L5_2 = ENTITY
      L5_2 = L5_2.ATTACH_ENTITY_TO_ENTITY
      L6_2 = dunecar1
      L7_2 = dunecar
      L8_2 = 0
      L9_2 = 0
      L10_2 = 0
      L11_2 = 0
      L12_2 = 0
      L13_2 = 0
      L14_2 = 0
      L15_2 = true
      L16_2 = true
      L17_2 = true
      L18_2 = false
      L19_2 = 0
      L20_2 = true
      L21_2 = 0
      L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
      L5_2 = ENTITY
      L5_2 = L5_2.ATTACH_ENTITY_TO_ENTITY
      L6_2 = dunecar2
      L7_2 = dunecar
      L8_2 = 0
      L9_2 = 0
      L10_2 = 0
      L11_2 = 0
      L12_2 = 0
      L13_2 = 0
      L14_2 = 0
      L15_2 = true
      L16_2 = true
      L17_2 = true
      L18_2 = false
      L19_2 = 0
      L20_2 = true
      L21_2 = 0
      L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
      L5_2 = ENTITY
      L5_2 = L5_2.ATTACH_ENTITY_TO_ENTITY
      L6_2 = dunecar
      L7_2 = pedp
      L8_2 = 0
      L9_2 = 0
      L10_2 = 0
      L11_2 = 0
      L12_2 = 0
      L13_2 = 0
      L14_2 = 0
      L15_2 = true
      L16_2 = true
      L17_2 = true
      L18_2 = false
      L19_2 = 0
      L20_2 = true
      L21_2 = 0
      L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
      L5_2 = util
      L5_2 = L5_2.yield
      L6_2 = 5000
      L5_2(L6_2)
      L5_2 = 0
      L6_2 = 100
      L7_2 = 1
      for L8_2 = L5_2, L6_2, L7_2 do
        L9_2 = ENTITY
        L9_2 = L9_2.SET_ENTITY_COORDS_NO_OFFSET
        L10_2 = dunecar
        L11_2 = pos
        L11_2 = L11_2.x
        L12_2 = pos
        L12_2 = L12_2.y
        L13_2 = pos
        L13_2 = L13_2.z
        L14_2 = false
        L15_2 = true
        L16_2 = true
        L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
        L9_2 = util
        L9_2 = L9_2.yield
        L10_2 = 10
        L9_2(L10_2)
      end
      L5_2 = util
      L5_2 = L5_2.yield
      L6_2 = 2000
      L5_2(L6_2)
      L5_2 = delete_entity
      L6_2 = dune
      L5_2(L6_2)
      L5_2 = delete_entity
      L6_2 = dune1
      L5_2(L6_2)
      L5_2 = delete_entity
      L6_2 = barracks
      L5_2(L6_2)
      L5_2 = delete_entity
      L6_2 = barracks1
      L5_2(L6_2)
      L5_2 = delete_entity
      L6_2 = dunecar
      L5_2(L6_2)
      L5_2 = delete_entity
      L6_2 = dunecar1
      L5_2(L6_2)
      L5_2 = delete_entity
      L6_2 = dunecar2
      L5_2(L6_2)
      L5_2 = delete_entity
      L6_2 = barracks3
      L5_2(L6_2)
      L5_2 = delete_entity
      L6_2 = barracks31
      L5_2(L6_2)
    end
  end
end
L47_1[L48_1] = L49_1
L47_1 = _ENV
L48_1 = "naturecrashv1"
function L49_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2 = L1_2()
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = players
  L3_2 = L3_2.get_position
  L4_2 = L1_2
  L3_2 = L3_2(L4_2)
  L4_2 = BlockSyncs
  L5_2 = A0_2
  function L6_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3
    L0_3 = util
    L0_3 = L0_3.yield
    L1_3 = 100
    L0_3(L1_3)
    L0_3 = menu
    L0_3 = L0_3.trigger_commands
    L1_3 = "invisibility on"
    L0_3(L1_3)
    L0_3 = 0
    L1_3 = 110
    L2_3 = 1
    for L3_3 = L0_3, L1_3, L2_3 do
      L4_3 = PLAYER
      L4_3 = L4_3.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE
      L5_3 = L1_2
      L6_3 = 4227322399
      L4_3(L5_3, L6_3)
      L4_3 = PED
      L4_3 = L4_3.SET_PED_COMPONENT_VARIATION
      L5_3 = L2_2
      L6_3 = 5
      L7_3 = L3_3
      L8_3 = 0
      L9_3 = 0
      L4_3(L5_3, L6_3, L7_3, L8_3, L9_3)
      L4_3 = util
      L4_3 = L4_3.yield
      L5_3 = 50
      L4_3(L5_3)
      L4_3 = PLAYER
      L5_3 = "CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE"
      L4_3 = L4_3[L5_3]
      L5_3 = L1_2
      L4_3(L5_3)
    end
    L0_3 = util
    L0_3 = L0_3.yield
    L1_3 = 250
    L0_3(L1_3)
    L0_3 = 1
    L1_3 = 5
    L2_3 = 1
    for L3_3 = L0_3, L1_3, L2_3 do
      L4_3 = util
      L4_3 = L4_3.spoof_script
      L5_3 = "freemode"
      L6_3 = SYSTEM
      L6_3 = L6_3.WAIT
      L4_3(L5_3, L6_3)
    end
    L0_3 = ENTITY
    L0_3 = L0_3.SET_ENTITY_HEALTH
    L1_3 = L2_2
    L2_3 = 0
    L3_3 = 0
    L0_3(L1_3, L2_3, L3_3)
    L0_3 = NETWORK
    L0_3 = L0_3.NETWORK_RESURRECT_LOCAL_PLAYER
    L1_3 = L3_2.x
    L2_3 = L3_2.y
    L3_3 = L3_2.z
    L4_3 = 0
    L5_3 = false
    L6_3 = false
    L7_3 = 0
    L0_3(L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3)
    L0_3 = PLAYER
    L1_3 = "CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE"
    L0_3 = L0_3[L1_3]
    L1_3 = L1_2
    L0_3(L1_3)
    L0_3 = menu
    L0_3 = L0_3.trigger_commands
    L1_3 = "invisibility off"
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2)
end
L47_1[L48_1] = L49_1
L47_1 = _ENV
L48_1 = "OXcrashgg"
function L49_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED_SCRIPT_INDEX
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = L1_2
  L4_2 = true
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = CreatePed
  L4_2 = 26
  L5_2 = util
  L5_2 = L5_2.joaat
  L6_2 = "cs_beverly"
  L5_2 = L5_2(L6_2)
  L6_2 = L2_2
  L7_2 = 0
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
  L4_2 = ENTITY
  L4_2 = L4_2.SET_ENTITY_VISIBLE
  L5_2 = L3_2
  L6_2 = false
  L7_2 = 0
  L4_2(L5_2, L6_2, L7_2)
  L4_2 = util
  L4_2 = L4_2.yield
  L5_2 = 100
  L4_2(L5_2)
  L4_2 = WEAPON
  L4_2 = L4_2.GIVE_WEAPON_TO_PED
  L5_2 = L3_2
  L6_2 = -270015777
  L7_2 = 80
  L8_2 = true
  L9_2 = true
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = util
  L4_2 = L4_2.yield
  L5_2 = 1000
  L4_2(L5_2)
  L4_2 = FIRE
  L4_2 = L4_2.ADD_OWNED_EXPLOSION
  L5_2 = PLAYER
  L5_2 = L5_2.PLAYER_PED_ID
  L5_2 = L5_2()
  L6_2 = L2_2.x
  L7_2 = L2_2.y
  L8_2 = L2_2.z
  L9_2 = 2
  L10_2 = 50
  L11_2 = true
  L12_2 = false
  L13_2 = 0.0
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L4_2 = util
  L4_2 = L4_2.yield
  L5_2 = 10000
  L4_2(L5_2)
  L4_2 = delete_entity
  L5_2 = L3_2
  L4_2(L5_2)
  L4_2 = players
  L4_2 = L4_2.exists
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  if L4_2 then
    L4_2 = util
    L4_2 = L4_2.toast
    L5_2 = "未能移除玩家,正在使用cs_fabien模型"
    L4_2(L5_2)
    L4_2 = CreatePed
    L5_2 = 26
    L6_2 = util
    L6_2 = L6_2.joaat
    L7_2 = "cs_fabien"
    L6_2 = L6_2(L7_2)
    L7_2 = L2_2
    L8_2 = 0
    L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
    L5_2 = ENTITY
    L5_2 = L5_2.SET_ENTITY_VISIBLE
    L6_2 = L4_2
    L7_2 = false
    L8_2 = 0
    L5_2(L6_2, L7_2, L8_2)
    L5_2 = util
    L5_2 = L5_2.yield
    L6_2 = 100
    L5_2(L6_2)
    L5_2 = WEAPON
    L5_2 = L5_2.GIVE_WEAPON_TO_PED
    L6_2 = L4_2
    L7_2 = -270015777
    L8_2 = 80
    L9_2 = true
    L10_2 = true
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
    L5_2 = util
    L5_2 = L5_2.yield
    L6_2 = 1000
    L5_2(L6_2)
    L5_2 = FIRE
    L5_2 = L5_2.ADD_OWNED_EXPLOSION
    L6_2 = PLAYER
    L6_2 = L6_2.PLAYER_PED_ID
    L6_2 = L6_2()
    L7_2 = L2_2.x
    L8_2 = L2_2.y
    L9_2 = L2_2.z
    L10_2 = 2
    L11_2 = 50
    L12_2 = true
    L13_2 = false
    L14_2 = 0.0
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    L5_2 = util
    L5_2 = L5_2.yield
    L6_2 = 5000
    L5_2(L6_2)
    L5_2 = delete_entity
    L6_2 = L4_2
    L5_2(L6_2)
  end
  L4_2 = players
  L4_2 = L4_2.exists
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  if L4_2 then
    L4_2 = util
    L4_2 = L4_2.toast
    L5_2 = "未能移除玩家,正在使用cs_manuel模型"
    L4_2(L5_2)
    L4_2 = CreatePed
    L5_2 = 26
    L6_2 = util
    L6_2 = L6_2.joaat
    L7_2 = "cs_manuel"
    L6_2 = L6_2(L7_2)
    L7_2 = L2_2
    L8_2 = 0
    L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
    L5_2 = ENTITY
    L5_2 = L5_2.SET_ENTITY_VISIBLE
    L6_2 = L4_2
    L7_2 = false
    L8_2 = 0
    L5_2(L6_2, L7_2, L8_2)
    L5_2 = util
    L5_2 = L5_2.yield
    L6_2 = 100
    L5_2(L6_2)
    L5_2 = WEAPON
    L5_2 = L5_2.GIVE_WEAPON_TO_PED
    L6_2 = L4_2
    L7_2 = -270015777
    L8_2 = 80
    L9_2 = true
    L10_2 = true
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
    L5_2 = util
    L5_2 = L5_2.yield
    L6_2 = 1000
    L5_2(L6_2)
    L5_2 = FIRE
    L5_2 = L5_2.ADD_OWNED_EXPLOSION
    L6_2 = PLAYER
    L6_2 = L6_2.PLAYER_PED_ID
    L6_2 = L6_2()
    L7_2 = L2_2.x
    L8_2 = L2_2.y
    L9_2 = L2_2.z
    L10_2 = 2
    L11_2 = 50
    L12_2 = true
    L13_2 = false
    L14_2 = 0.0
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    L5_2 = util
    L5_2 = L5_2.yield
    L6_2 = 5000
    L5_2(L6_2)
    L5_2 = delete_entity
    L6_2 = L4_2
    L5_2(L6_2)
  end
  L4_2 = players
  L4_2 = L4_2.exists
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  if L4_2 then
    L4_2 = util
    L4_2 = L4_2.toast
    L5_2 = "未能移除玩家,正在使用cs_taostranslator模型"
    L4_2(L5_2)
    L4_2 = CreatePed
    L5_2 = 26
    L6_2 = util
    L6_2 = L6_2.joaat
    L7_2 = "cs_taostranslator"
    L6_2 = L6_2(L7_2)
    L7_2 = L2_2
    L8_2 = 0
    L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
    L5_2 = ENTITY
    L5_2 = L5_2.SET_ENTITY_VISIBLE
    L6_2 = L4_2
    L7_2 = false
    L8_2 = 0
    L5_2(L6_2, L7_2, L8_2)
    L5_2 = util
    L5_2 = L5_2.yield
    L6_2 = 100
    L5_2(L6_2)
    L5_2 = WEAPON
    L5_2 = L5_2.GIVE_WEAPON_TO_PED
    L6_2 = L4_2
    L7_2 = -270015777
    L8_2 = 80
    L9_2 = true
    L10_2 = true
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
    L5_2 = util
    L5_2 = L5_2.yield
    L6_2 = 1000
    L5_2(L6_2)
    L5_2 = FIRE
    L5_2 = L5_2.ADD_OWNED_EXPLOSION
    L6_2 = PLAYER
    L6_2 = L6_2.PLAYER_PED_ID
    L6_2 = L6_2()
    L7_2 = L2_2.x
    L8_2 = L2_2.y
    L9_2 = L2_2.z
    L10_2 = 2
    L11_2 = 50
    L12_2 = true
    L13_2 = false
    L14_2 = 0.0
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    L5_2 = util
    L5_2 = L5_2.yield
    L6_2 = 5000
    L5_2(L6_2)
    L5_2 = delete_entity
    L6_2 = L4_2
    L5_2(L6_2)
  end
  L4_2 = players
  L4_2 = L4_2.exists
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  if L4_2 then
    L4_2 = util
    L4_2 = L4_2.toast
    L5_2 = "未能移除玩家,正在使用cs_taostranslator2模型"
    L4_2(L5_2)
    L4_2 = CreatePed
    L5_2 = 26
    L6_2 = util
    L6_2 = L6_2.joaat
    L7_2 = "cs_taostranslator2"
    L6_2 = L6_2(L7_2)
    L7_2 = L2_2
    L8_2 = 0
    L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
    L5_2 = ENTITY
    L5_2 = L5_2.SET_ENTITY_VISIBLE
    L6_2 = L4_2
    L7_2 = false
    L8_2 = 0
    L5_2(L6_2, L7_2, L8_2)
    L5_2 = util
    L5_2 = L5_2.yield
    L6_2 = 100
    L5_2(L6_2)
    L5_2 = WEAPON
    L5_2 = L5_2.GIVE_WEAPON_TO_PED
    L6_2 = L4_2
    L7_2 = -270015777
    L8_2 = 80
    L9_2 = true
    L10_2 = true
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
    L5_2 = util
    L5_2 = L5_2.yield
    L6_2 = 1000
    L5_2(L6_2)
    L5_2 = FIRE
    L5_2 = L5_2.ADD_OWNED_EXPLOSION
    L6_2 = PLAYER
    L6_2 = L6_2.PLAYER_PED_ID
    L6_2 = L6_2()
    L7_2 = L2_2.x
    L8_2 = L2_2.y
    L9_2 = L2_2.z
    L10_2 = 2
    L11_2 = 50
    L12_2 = true
    L13_2 = false
    L14_2 = 0.0
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    L5_2 = util
    L5_2 = L5_2.yield
    L6_2 = 5000
    L5_2(L6_2)
    L5_2 = delete_entity
    L6_2 = L4_2
    L5_2(L6_2)
  end
  L4_2 = players
  L4_2 = L4_2.exists
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  if L4_2 then
    L4_2 = util
    L4_2 = L4_2.toast
    L5_2 = "未能移除玩家,正在使用cs_tenniscoach模型"
    L4_2(L5_2)
    L4_2 = CreatePed
    L5_2 = 26
    L6_2 = util
    L6_2 = L6_2.joaat
    L7_2 = "cs_tenniscoach"
    L6_2 = L6_2(L7_2)
    L7_2 = L2_2
    L8_2 = 0
    L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
    L5_2 = ENTITY
    L5_2 = L5_2.SET_ENTITY_VISIBLE
    L6_2 = L4_2
    L7_2 = false
    L8_2 = 0
    L5_2(L6_2, L7_2, L8_2)
    L5_2 = util
    L5_2 = L5_2.yield
    L6_2 = 100
    L5_2(L6_2)
    L5_2 = WEAPON
    L5_2 = L5_2.GIVE_WEAPON_TO_PED
    L6_2 = L4_2
    L7_2 = -270015777
    L8_2 = 80
    L9_2 = true
    L10_2 = true
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
    L5_2 = util
    L5_2 = L5_2.yield
    L6_2 = 1000
    L5_2(L6_2)
    L5_2 = FIRE
    L5_2 = L5_2.ADD_OWNED_EXPLOSION
    L6_2 = PLAYER
    L6_2 = L6_2.PLAYER_PED_ID
    L6_2 = L6_2()
    L7_2 = L2_2.x
    L8_2 = L2_2.y
    L9_2 = L2_2.z
    L10_2 = 2
    L11_2 = 50
    L12_2 = true
    L13_2 = false
    L14_2 = 0.0
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    L5_2 = util
    L5_2 = L5_2.yield
    L6_2 = 5000
    L5_2(L6_2)
    L5_2 = delete_entity
    L6_2 = L4_2
    L5_2(L6_2)
  end
  L4_2 = players
  L4_2 = L4_2.exists
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  if L4_2 then
    L4_2 = util
    L4_2 = L4_2.toast
    L5_2 = "未能移除玩家,正在使用cs_wade模型"
    L4_2(L5_2)
    L4_2 = CreatePed
    L5_2 = 26
    L6_2 = util
    L6_2 = L6_2.joaat
    L7_2 = "cs_wade"
    L6_2 = L6_2(L7_2)
    L7_2 = L2_2
    L8_2 = 0
    L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
    L5_2 = ENTITY
    L5_2 = L5_2.SET_ENTITY_VISIBLE
    L6_2 = L4_2
    L7_2 = false
    L8_2 = 0
    L5_2(L6_2, L7_2, L8_2)
    L5_2 = util
    L5_2 = L5_2.yield
    L6_2 = 100
    L5_2(L6_2)
    L5_2 = WEAPON
    L5_2 = L5_2.GIVE_WEAPON_TO_PED
    L6_2 = L4_2
    L7_2 = -270015777
    L8_2 = 80
    L9_2 = true
    L10_2 = true
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
    L5_2 = util
    L5_2 = L5_2.yield
    L6_2 = 1000
    L5_2(L6_2)
    L5_2 = FIRE
    L5_2 = L5_2.ADD_OWNED_EXPLOSION
    L6_2 = PLAYER
    L6_2 = L6_2.PLAYER_PED_ID
    L6_2 = L6_2()
    L7_2 = L2_2.x
    L8_2 = L2_2.y
    L9_2 = L2_2.z
    L10_2 = 2
    L11_2 = 50
    L12_2 = true
    L13_2 = false
    L14_2 = 0.0
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    L5_2 = util
    L5_2 = L5_2.yield
    L6_2 = 5000
    L5_2(L6_2)
    L5_2 = delete_entity
    L6_2 = L4_2
    L5_2(L6_2)
  end
  L4_2 = util
  L4_2 = L4_2.yield
  L5_2 = 2000
  L4_2(L5_2)
  L4_2 = players
  L4_2 = L4_2.exists
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  if not L4_2 then
    L4_2 = util
    L4_2 = L4_2.toast
    L5_2 = "成功移除玩家"
    L4_2(L5_2)
  end
end
L47_1[L48_1] = L49_1
L47_1 = _ENV
L48_1 = "Northern_crash"
function L49_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_COORDS
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
  L3_2 = A0_2
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L2_2(L3_2)
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "player_zero"
  L2_2 = L2_2(L3_2)
  L3_2 = request_model
  L4_2 = L2_2
  L3_2(L4_2)
  L3_2 = entities
  L3_2 = L3_2.create_ped
  L4_2 = 0
  L5_2 = L2_2
  L6_2 = L1_2
  L7_2 = 0
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
  L4_2 = PED
  L4_2 = L4_2.SET_PED_COMPONENT_VARIATION
  L5_2 = L3_2
  L6_2 = 0
  L7_2 = 0
  L8_2 = 6
  L9_2 = 0
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = PED
  L4_2 = L4_2.SET_PED_COMPONENT_VARIATION
  L5_2 = L3_2
  L6_2 = 0
  L7_2 = 0
  L8_2 = 5
  L9_2 = 0
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = util
  L4_2 = L4_2.yield
  L4_2()
  L4_2 = ENTITY
  L4_2 = L4_2.SET_ENTITY_COORDS
  L5_2 = L3_2
  L6_2 = L1_2.x
  L7_2 = L1_2.y
  L8_2 = L1_2.z
  L9_2 = true
  L10_2 = false
  L11_2 = false
  L12_2 = true
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L4_2 = util
  L4_2 = L4_2.yield
  L5_2 = 500
  L4_2(L5_2)
  L4_2 = delete_entity
  L5_2 = L3_2
  L4_2(L5_2)
end
L47_1[L48_1] = L49_1
L47_1 = _ENV
L48_1 = "Rebound_crash"
function L49_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED_SCRIPT_INDEX
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = players
  L2_2 = L2_2.get_position
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = util
  L3_2 = L3_2.joaat
  L4_2 = "mp_m_freemode_01"
  L3_2 = L3_2(L4_2)
  L4_2 = util
  L4_2 = L4_2.joaat
  L5_2 = "taxi"
  L4_2 = L4_2(L5_2)
  L5_2 = request_model
  L6_2 = L4_2
  L5_2(L6_2)
  L5_2 = request_model
  L6_2 = L3_2
  L5_2(L6_2)
  L5_2 = 1
  L6_2 = 10
  L7_2 = 1
  for L8_2 = L5_2, L6_2, L7_2 do
    L9_2 = entities
    L9_2 = L9_2.create_vehicle
    L10_2 = L4_2
    L11_2 = L2_2
    L12_2 = 0
    L9_2 = L9_2(L10_2, L11_2, L12_2)
    L10_2 = entities
    L10_2 = L10_2.create_ped
    L11_2 = 2
    L12_2 = L3_2
    L13_2 = L2_2
    L14_2 = 0
    L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2)
    L11_2 = PED
    L11_2 = L11_2.SET_PED_INTO_VEHICLE
    L12_2 = L10_2
    L13_2 = L9_2
    L14_2 = -1
    L11_2(L12_2, L13_2, L14_2)
    L11_2 = util
    L11_2 = L11_2.yield
    L12_2 = 100
    L11_2(L12_2)
    L11_2 = TASK
    L11_2 = L11_2.TASK_VEHICLE_HELI_PROTECT
    L12_2 = L10_2
    L13_2 = L9_2
    L14_2 = L1_2
    L15_2 = 10.0
    L16_2 = 0
    L17_2 = 10
    L18_2 = 0
    L19_2 = 0
    L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
    L11_2 = util
    L11_2 = L11_2.yield
    L12_2 = 1000
    L11_2(L12_2)
    L11_2 = delete_entity
    L12_2 = L10_2
    L11_2(L12_2)
    L11_2 = delete_entity
    L12_2 = L9_2
    L11_2(L12_2)
  end
  L5_2 = STREAMING
  L5_2 = L5_2.SET_MODEL_AS_NO_LONGER_NEEDED
  L6_2 = L3_2
  L5_2(L6_2)
  L5_2 = STREAMING
  L5_2 = L5_2.SET_MODEL_AS_NO_LONGER_NEEDED
  L6_2 = L4_2
  L5_2(L6_2)
end
L47_1[L48_1] = L49_1
L47_1 = _ENV
L48_1 = "nightfull_crash"
function L49_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED_SCRIPT_INDEX
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "cs_taostranslator2"
  L2_2 = L2_2(L3_2)
  while true do
    L3_2 = STREAMING
    L3_2 = L3_2.HAS_MODEL_LOADED
    L4_2 = L2_2
    L3_2 = L3_2(L4_2)
    if L3_2 then
      break
    end
    L3_2 = STREAMING
    L3_2 = L3_2.REQUEST_MODEL
    L4_2 = L2_2
    L3_2(L4_2)
    L3_2 = util
    L3_2 = L3_2.yield
    L4_2 = 5
    L3_2(L4_2)
  end
  L3_2 = {}
  L4_2 = 1
  L5_2 = 10
  L6_2 = 1
  for L7_2 = L4_2, L5_2, L6_2 do
    L8_2 = ENTITY
    L8_2 = L8_2.GET_ENTITY_COORDS
    L9_2 = L1_2
    L10_2 = true
    L8_2 = L8_2(L9_2, L10_2)
    L9_2 = ENTITY
    L9_2 = L9_2.GET_ENTITY_COORDS
    L10_2 = L3_2[L7_2]
    L11_2 = false
    L9_2 = L9_2(L10_2, L11_2)
    L10_2 = entities
    L10_2 = L10_2.create_ped
    L11_2 = 0
    L12_2 = L2_2
    L13_2 = L8_2
    L14_2 = 0
    L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2)
    L3_2[L7_2] = L10_2
    L10_2 = WEAPON
    L10_2 = L10_2.GIVE_DELAYED_WEAPON_TO_PED
    L11_2 = L3_2[L7_2]
    L12_2 = 2982836145
    L13_2 = 0
    L14_2 = true
    L10_2(L11_2, L12_2, L13_2, L14_2)
    L10_2 = WEAPON
    L10_2 = L10_2.SET_PED_GADGET
    L11_2 = L3_2[L7_2]
    L12_2 = 2982836145
    L13_2 = true
    L10_2(L11_2, L12_2, L13_2)
    L10_2 = ENTITY
    L10_2 = L10_2.SET_ENTITY_VISIBLE
    L11_2 = L3_2[L7_2]
    L12_2 = true
    L10_2(L11_2, L12_2)
    L10_2 = util
    L10_2 = L10_2.yield
    L11_2 = 25
    L10_2(L11_2)
  end
  L4_2 = util
  L4_2 = L4_2.yield
  L5_2 = 2500
  L4_2(L5_2)
  L4_2 = 1
  L5_2 = 10
  L6_2 = 1
  for L7_2 = L4_2, L5_2, L6_2 do
    L8_2 = delete_entity
    L9_2 = L3_2[L7_2]
    L8_2(L9_2)
    L8_2 = util
    L8_2 = L8_2.yield
    L9_2 = 25
    L8_2(L9_2)
  end
end
L47_1[L48_1] = L49_1
L47_1 = _ENV
L48_1 = "Inshallah_crash"
function L49_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_COORDS
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
  L3_2 = A0_2
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L2_2(L3_2)
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L2_2 = CreatePed
  L3_2 = 28
  L4_2 = -1011537562
  L5_2 = L1_2
  L6_2 = 0
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  L3_2 = CreatePed
  L4_2 = 28
  L5_2 = -541762431
  L6_2 = L1_2
  L7_2 = 0
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
  L4_2 = WEAPON
  L4_2 = L4_2.GIVE_WEAPON_TO_PED
  L5_2 = L2_2
  L6_2 = -1813897027
  L7_2 = 1
  L8_2 = true
  L9_2 = true
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = WEAPON
  L4_2 = L4_2.GIVE_WEAPON_TO_PED
  L5_2 = L3_2
  L6_2 = -1813897027
  L7_2 = 1
  L8_2 = true
  L9_2 = true
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = util
  L4_2 = L4_2.yield
  L5_2 = 1000
  L4_2(L5_2)
  L4_2 = TASK
  L4_2 = L4_2.TASK_THROW_PROJECTILE
  L5_2 = L2_2
  L6_2 = L1_2.x
  L7_2 = L1_2.y
  L8_2 = L1_2.z
  L9_2 = 0
  L10_2 = 0
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L4_2 = TASK
  L4_2 = L4_2.TASK_THROW_PROJECTILE
  L5_2 = L3_2
  L6_2 = L1_2.x
  L7_2 = L1_2.y
  L8_2 = L1_2.z
  L9_2 = 0
  L10_2 = 0
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
end
L47_1[L48_1] = L49_1
L47_1 = _ENV
L48_1 = "v1_frag"
function L49_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = BlockSyncs
  L2_2 = A0_2
  function L3_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3
    L0_3 = entities
    L0_3 = L0_3.create_object
    L1_3 = util
    L1_3 = L1_3.joaat
    L2_3 = "prop_fragtest_cnst_04"
    L1_3 = L1_3(L2_3)
    L2_3 = ENTITY
    L2_3 = L2_3.GET_ENTITY_COORDS
    L3_3 = PLAYER
    L3_3 = L3_3.GET_PLAYER_PED_SCRIPT_INDEX
    L4_3 = A0_2
    L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3 = L3_3(L4_3)
    L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3 = L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3)
    L0_3 = L0_3(L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3)
    L1_3 = OBJECT
    L1_3 = L1_3.BREAK_OBJECT_FRAGMENT_CHILD
    L2_3 = L0_3
    L3_3 = 1
    L4_3 = false
    L1_3(L2_3, L3_3, L4_3)
    L1_3 = delete_entity
    L2_3 = L0_3
    L1_3(L2_3)
    L1_3 = entities
    L1_3 = L1_3.create_object
    L2_3 = util
    L2_3 = L2_3.joaat
    L3_3 = "prop_fragtest_cnst_04"
    L2_3 = L2_3(L3_3)
    L3_3 = ENTITY
    L3_3 = L3_3.GET_ENTITY_COORDS
    L4_3 = PLAYER
    L4_3 = L4_3.GET_PLAYER_PED_SCRIPT_INDEX
    L5_3 = A0_2
    L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3 = L4_3(L5_3)
    L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3 = L3_3(L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3)
    L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3)
    L2_3 = OBJECT
    L2_3 = L2_3.BREAK_OBJECT_FRAGMENT_CHILD
    L3_3 = L1_3
    L4_3 = 1
    L5_3 = false
    L2_3(L3_3, L4_3, L5_3)
    L2_3 = delete_entity
    L3_3 = L1_3
    L2_3(L3_3)
    L2_3 = entities
    L2_3 = L2_3.create_object
    L3_3 = util
    L3_3 = L3_3.joaat
    L4_3 = "prop_fragtest_cnst_04"
    L3_3 = L3_3(L4_3)
    L4_3 = ENTITY
    L4_3 = L4_3.GET_ENTITY_COORDS
    L5_3 = PLAYER
    L5_3 = L5_3.GET_PLAYER_PED_SCRIPT_INDEX
    L6_3 = A0_2
    L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3 = L5_3(L6_3)
    L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3 = L4_3(L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3)
    L2_3 = L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3)
    L3_3 = OBJECT
    L3_3 = L3_3.BREAK_OBJECT_FRAGMENT_CHILD
    L4_3 = L2_3
    L5_3 = 1
    L6_3 = false
    L3_3(L4_3, L5_3, L6_3)
    L3_3 = delete_entity
    L4_3 = L2_3
    L3_3(L4_3)
    L3_3 = entities
    L3_3 = L3_3.create_object
    L4_3 = util
    L4_3 = L4_3.joaat
    L5_3 = "prop_fragtest_cnst_04"
    L4_3 = L4_3(L5_3)
    L5_3 = ENTITY
    L5_3 = L5_3.GET_ENTITY_COORDS
    L6_3 = PLAYER
    L6_3 = L6_3.GET_PLAYER_PED_SCRIPT_INDEX
    L7_3 = A0_2
    L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3 = L6_3(L7_3)
    L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3 = L5_3(L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3)
    L3_3 = L3_3(L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3)
    L4_3 = OBJECT
    L4_3 = L4_3.BREAK_OBJECT_FRAGMENT_CHILD
    L5_3 = L3_3
    L6_3 = 1
    L7_3 = false
    L4_3(L5_3, L6_3, L7_3)
    L4_3 = delete_entity
    L5_3 = L3_3
    L4_3(L5_3)
    L4_3 = entities
    L4_3 = L4_3.create_object
    L5_3 = util
    L5_3 = L5_3.joaat
    L6_3 = "prop_fragtest_cnst_04"
    L5_3 = L5_3(L6_3)
    L6_3 = ENTITY
    L6_3 = L6_3.GET_ENTITY_COORDS
    L7_3 = PLAYER
    L7_3 = L7_3.GET_PLAYER_PED_SCRIPT_INDEX
    L8_3 = A0_2
    L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3 = L7_3(L8_3)
    L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3 = L6_3(L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3)
    L4_3 = L4_3(L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3)
    L5_3 = OBJECT
    L5_3 = L5_3.BREAK_OBJECT_FRAGMENT_CHILD
    L6_3 = L4_3
    L7_3 = 1
    L8_3 = false
    L5_3(L6_3, L7_3, L8_3)
    L5_3 = delete_entity
    L6_3 = L4_3
    L5_3(L6_3)
    L5_3 = entities
    L5_3 = L5_3.create_object
    L6_3 = util
    L6_3 = L6_3.joaat
    L7_3 = "prop_fragtest_cnst_04"
    L6_3 = L6_3(L7_3)
    L7_3 = ENTITY
    L7_3 = L7_3.GET_ENTITY_COORDS
    L8_3 = PLAYER
    L8_3 = L8_3.GET_PLAYER_PED_SCRIPT_INDEX
    L9_3 = A0_2
    L8_3, L9_3, L10_3, L11_3, L12_3, L13_3 = L8_3(L9_3)
    L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3 = L7_3(L8_3, L9_3, L10_3, L11_3, L12_3, L13_3)
    L5_3 = L5_3(L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3)
    L6_3 = OBJECT
    L6_3 = L6_3.BREAK_OBJECT_FRAGMENT_CHILD
    L7_3 = L5_3
    L8_3 = 1
    L9_3 = false
    L6_3(L7_3, L8_3, L9_3)
    L6_3 = delete_entity
    L7_3 = L5_3
    L6_3(L7_3)
    L6_3 = entities
    L6_3 = L6_3.create_object
    L7_3 = util
    L7_3 = L7_3.joaat
    L8_3 = "prop_fragtest_cnst_04"
    L7_3 = L7_3(L8_3)
    L8_3 = ENTITY
    L8_3 = L8_3.GET_ENTITY_COORDS
    L9_3 = PLAYER
    L9_3 = L9_3.GET_PLAYER_PED_SCRIPT_INDEX
    L10_3 = A0_2
    L9_3, L10_3, L11_3, L12_3, L13_3 = L9_3(L10_3)
    L8_3, L9_3, L10_3, L11_3, L12_3, L13_3 = L8_3(L9_3, L10_3, L11_3, L12_3, L13_3)
    L6_3 = L6_3(L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3)
    L7_3 = OBJECT
    L7_3 = L7_3.BREAK_OBJECT_FRAGMENT_CHILD
    L8_3 = L6_3
    L9_3 = 1
    L10_3 = false
    L7_3(L8_3, L9_3, L10_3)
    L7_3 = delete_entity
    L8_3 = L6_3
    L7_3(L8_3)
    L7_3 = entities
    L7_3 = L7_3.create_object
    L8_3 = util
    L8_3 = L8_3.joaat
    L9_3 = "prop_fragtest_cnst_04"
    L8_3 = L8_3(L9_3)
    L9_3 = ENTITY
    L9_3 = L9_3.GET_ENTITY_COORDS
    L10_3 = PLAYER
    L10_3 = L10_3.GET_PLAYER_PED_SCRIPT_INDEX
    L11_3 = A0_2
    L10_3, L11_3, L12_3, L13_3 = L10_3(L11_3)
    L9_3, L10_3, L11_3, L12_3, L13_3 = L9_3(L10_3, L11_3, L12_3, L13_3)
    L7_3 = L7_3(L8_3, L9_3, L10_3, L11_3, L12_3, L13_3)
    L8_3 = OBJECT
    L8_3 = L8_3.BREAK_OBJECT_FRAGMENT_CHILD
    L9_3 = L7_3
    L10_3 = 1
    L11_3 = false
    L8_3(L9_3, L10_3, L11_3)
    L8_3 = delete_entity
    L9_3 = L7_3
    L8_3(L9_3)
    L8_3 = entities
    L8_3 = L8_3.create_object
    L9_3 = util
    L9_3 = L9_3.joaat
    L10_3 = "prop_fragtest_cnst_04"
    L9_3 = L9_3(L10_3)
    L10_3 = ENTITY
    L10_3 = L10_3.GET_ENTITY_COORDS
    L11_3 = PLAYER
    L11_3 = L11_3.GET_PLAYER_PED_SCRIPT_INDEX
    L12_3 = A0_2
    L11_3, L12_3, L13_3 = L11_3(L12_3)
    L10_3, L11_3, L12_3, L13_3 = L10_3(L11_3, L12_3, L13_3)
    L8_3 = L8_3(L9_3, L10_3, L11_3, L12_3, L13_3)
    L9_3 = OBJECT
    L9_3 = L9_3.BREAK_OBJECT_FRAGMENT_CHILD
    L10_3 = L8_3
    L11_3 = 1
    L12_3 = false
    L9_3(L10_3, L11_3, L12_3)
    L9_3 = delete_entity
    L10_3 = L8_3
    L9_3(L10_3)
    L9_3 = entities
    L9_3 = L9_3.create_object
    L10_3 = util
    L10_3 = L10_3.joaat
    L11_3 = "prop_fragtest_cnst_04"
    L10_3 = L10_3(L11_3)
    L11_3 = ENTITY
    L11_3 = L11_3.GET_ENTITY_COORDS
    L12_3 = PLAYER
    L12_3 = L12_3.GET_PLAYER_PED_SCRIPT_INDEX
    L13_3 = A0_2
    L12_3, L13_3 = L12_3(L13_3)
    L11_3, L12_3, L13_3 = L11_3(L12_3, L13_3)
    L9_3 = L9_3(L10_3, L11_3, L12_3, L13_3)
    L10_3 = OBJECT
    L10_3 = L10_3.BREAK_OBJECT_FRAGMENT_CHILD
    L11_3 = L9_3
    L12_3 = 1
    L13_3 = false
    L10_3(L11_3, L12_3, L13_3)
    L10_3 = util
    L10_3 = L10_3.yield
    L11_3 = 1000
    L10_3(L11_3)
    L10_3 = delete_entity
    L11_3 = L9_3
    L10_3(L11_3)
  end
  L1_2(L2_2, L3_2)
end
L47_1[L48_1] = L49_1
L47_1 = _ENV
L48_1 = "Jesus_crash"
function L49_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED_SCRIPT_INDEX
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = players
  L2_2 = L2_2.get_position
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = util
  L3_2 = L3_2.joaat
  L4_2 = "u_m_m_jesus_01"
  L3_2 = L3_2(L4_2)
  L4_2 = util
  L4_2 = L4_2.joaat
  L5_2 = "oppressor"
  L4_2 = L4_2(L5_2)
  L5_2 = util
  L5_2 = L5_2.request_model
  L6_2 = L4_2
  L5_2(L6_2)
  L5_2 = util
  L5_2 = L5_2.request_model
  L6_2 = L3_2
  L5_2(L6_2)
  L5_2 = 1
  L6_2 = 10
  L7_2 = 1
  for L8_2 = L5_2, L6_2, L7_2 do
    L9_2 = players
    L9_2 = L9_2.exists
    L10_2 = A0_2
    L9_2 = L9_2(L10_2)
    if not L9_2 then
      return
    end
    L9_2 = entities
    L9_2 = L9_2.create_vehicle
    L10_2 = L4_2
    L11_2 = L2_2
    L12_2 = 0
    L9_2 = L9_2(L10_2, L11_2, L12_2)
    L10_2 = entities
    L10_2 = L10_2.create_ped
    L11_2 = 2
    L12_2 = L3_2
    L13_2 = L2_2
    L14_2 = 0
    L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2)
    L11_2 = PED
    L11_2 = L11_2.SET_PED_INTO_VEHICLE
    L12_2 = L10_2
    L13_2 = L9_2
    L14_2 = -1
    L11_2(L12_2, L13_2, L14_2)
    L11_2 = util
    L11_2 = L11_2.yield
    L12_2 = 100
    L11_2(L12_2)
    L11_2 = TASK
    L11_2 = L11_2.TASK_VEHICLE_HELI_PROTECT
    L12_2 = L10_2
    L13_2 = L9_2
    L14_2 = L1_2
    L15_2 = 10.0
    L16_2 = 0
    L17_2 = 10
    L18_2 = 0
    L19_2 = 0
    L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
    L11_2 = util
    L11_2 = L11_2.yield
    L12_2 = 1000
    L11_2(L12_2)
    L11_2 = delete_entity
    L12_2 = L10_2
    L11_2(L12_2)
    L11_2 = delete_entity
    L12_2 = L9_2
    L11_2(L12_2)
  end
  L5_2 = STREAMING
  L5_2 = L5_2.SET_MODEL_AS_NO_LONGER_NEEDED
  L6_2 = L3_2
  L5_2(L6_2)
  L5_2 = STREAMING
  L5_2 = L5_2.SET_MODEL_AS_NO_LONGER_NEEDED
  L6_2 = L4_2
  L5_2(L6_2)
end
L47_1[L48_1] = L49_1
L47_1 = _ENV
L48_1 = "Memoir"
function L49_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = PLAYER
  L1_2 = L1_2.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_ID
  L2_2 = L2_2()
  L3_2 = 3842125059
  L1_2(L2_2, L3_2)
  L1_2 = TASK
  L1_2 = L1_2.CLEAR_PED_TASKS_IMMEDIATELY
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_ID
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L3_2()
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L1_2 = util
  L1_2 = L1_2.yield
  L2_2 = 20
  L1_2(L2_2)
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_COORDS
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
  L3_2 = A0_2
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L2_2(L3_2)
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L2_2 = ENTITY
  L2_2 = L2_2.SET_ENTITY_COORDS_NO_OFFSET
  L3_2 = PLAYER
  L3_2 = L3_2.GET_PLAYER_PED_SCRIPT_INDEX
  L4_2 = PLAYER
  L4_2 = L4_2.PLAYER_ID
  L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L4_2()
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = L1_2.x
  L5_2 = L1_2.y
  L6_2 = L1_2.z
  L7_2 = false
  L8_2 = true
  L9_2 = true
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L2_2 = WEAPON
  L2_2 = L2_2.GIVE_DELAYED_WEAPON_TO_PED
  L3_2 = PLAYER
  L3_2 = L3_2.GET_PLAYER_PED_SCRIPT_INDEX
  L4_2 = PLAYER
  L4_2 = L4_2.PLAYER_ID
  L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L4_2()
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = 4222310262
  L5_2 = 1000
  L6_2 = false
  L2_2(L3_2, L4_2, L5_2, L6_2)
  L2_2 = TASK
  L2_2 = L2_2.TASK_PARACHUTE_TO_TARGET
  L3_2 = PLAYER
  L3_2 = L3_2.GET_PLAYER_PED_SCRIPT_INDEX
  L4_2 = PLAYER
  L4_2 = L4_2.PLAYER_ID
  L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L4_2()
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = -1087
  L5_2 = -3012
  L6_2 = 13.94
  L2_2(L3_2, L4_2, L5_2, L6_2)
  L2_2 = util
  L2_2 = L2_2.yield
  L3_2 = 500
  L2_2(L3_2)
  L2_2 = TASK
  L2_2 = L2_2.CLEAR_PED_TASKS_IMMEDIATELY
  L3_2 = PLAYER
  L3_2 = L3_2.GET_PLAYER_PED_SCRIPT_INDEX
  L4_2 = PLAYER
  L4_2 = L4_2.PLAYER_ID
  L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L4_2()
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L2_2 = util
  L2_2 = L2_2.yield
  L3_2 = 1000
  L2_2(L3_2)
  L2_2 = PLAYER
  L3_2 = "CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE"
  L2_2 = L2_2[L3_2]
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_ID
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L3_2()
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L2_2 = TASK
  L2_2 = L2_2.CLEAR_PED_TASKS_IMMEDIATELY
  L3_2 = PLAYER
  L3_2 = L3_2.GET_PLAYER_PED_SCRIPT_INDEX
  L4_2 = PLAYER
  L4_2 = L4_2.PLAYER_ID
  L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L4_2()
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
end
L47_1[L48_1] = L49_1
L47_1 = _ENV
L48_1 = "guibeng"
function L49_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED_SCRIPT_INDEX
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2 = L3_2()
  L4_2 = true
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = CreateVehicle
  L4_2 = util
  L4_2 = L4_2.joaat
  L5_2 = "tr3"
  L4_2 = L4_2(L5_2)
  L5_2 = L2_2
  L6_2 = ENTITY
  L6_2 = L6_2.GET_ENTITY_HEADING
  L7_2 = PLAYER
  L7_2 = L7_2.PLAYER_PED_ID
  L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L7_2()
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
  L7_2 = true
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
  L4_2 = ENTITY
  L4_2 = L4_2.ATTACH_ENTITY_TO_ENTITY
  L5_2 = L3_2
  L6_2 = PLAYER
  L6_2 = L6_2.PLAYER_PED_ID
  L6_2 = L6_2()
  L7_2 = 0
  L8_2 = 0
  L9_2 = 0
  L10_2 = 0
  L11_2 = 0
  L12_2 = 0
  L13_2 = 0
  L14_2 = true
  L15_2 = true
  L16_2 = true
  L17_2 = false
  L18_2 = 0
  L19_2 = true
  L20_2 = 0
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
  L4_2 = ENTITY
  L4_2 = L4_2.SET_ENTITY_VISIBLE
  L5_2 = L3_2
  L6_2 = false
  L7_2 = 0
  L4_2(L5_2, L6_2, L7_2)
  L4_2 = CreateVehicle
  L5_2 = util
  L5_2 = L5_2.joaat
  L6_2 = "chernobog"
  L5_2 = L5_2(L6_2)
  L6_2 = L2_2
  L7_2 = ENTITY
  L7_2 = L7_2.GET_ENTITY_HEADING
  L8_2 = PLAYER
  L8_2 = L8_2.PLAYER_PED_ID
  L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L8_2()
  L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
  L8_2 = true
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  L5_2 = ENTITY
  L5_2 = L5_2.ATTACH_ENTITY_TO_ENTITY
  L6_2 = L4_2
  L7_2 = PLAYER
  L7_2 = L7_2.PLAYER_PED_ID
  L7_2 = L7_2()
  L8_2 = 0
  L9_2 = 0
  L10_2 = 0
  L11_2 = 0
  L12_2 = 0
  L13_2 = 0
  L14_2 = 0
  L15_2 = true
  L16_2 = true
  L17_2 = true
  L18_2 = false
  L19_2 = 0
  L20_2 = true
  L21_2 = 0
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_VISIBLE
  L6_2 = L4_2
  L7_2 = false
  L8_2 = 0
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = CreateVehicle
  L6_2 = util
  L6_2 = L6_2.joaat
  L7_2 = "avenger"
  L6_2 = L6_2(L7_2)
  L7_2 = L2_2
  L8_2 = ENTITY
  L8_2 = L8_2.GET_ENTITY_HEADING
  L9_2 = PLAYER
  L9_2 = L9_2.PLAYER_PED_ID
  L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L9_2()
  L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
  L9_2 = true
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
  L6_2 = ENTITY
  L6_2 = L6_2.ATTACH_ENTITY_TO_ENTITY
  L7_2 = L5_2
  L8_2 = PLAYER
  L8_2 = L8_2.PLAYER_PED_ID
  L8_2 = L8_2()
  L9_2 = 0
  L10_2 = 0
  L11_2 = 0
  L12_2 = 0
  L13_2 = 0
  L14_2 = 0
  L15_2 = 0
  L16_2 = true
  L17_2 = true
  L18_2 = true
  L19_2 = false
  L20_2 = 0
  L21_2 = true
  L22_2 = 0
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
  L6_2 = ENTITY
  L6_2 = L6_2.SET_ENTITY_VISIBLE
  L7_2 = L5_2
  L8_2 = false
  L9_2 = 0
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = 0
  L7_2 = 100
  L8_2 = 1
  for L9_2 = L6_2, L7_2, L8_2 do
    L10_2 = ENTITY
    L10_2 = L10_2.GET_ENTITY_COORDS
    L11_2 = L1_2
    L12_2 = true
    L10_2 = L10_2(L11_2, L12_2)
    L11_2 = ENTITY
    L11_2 = L11_2.SET_ENTITY_COORDS
    L12_2 = PLAYER
    L12_2 = L12_2.PLAYER_PED_ID
    L12_2 = L12_2()
    L13_2 = L10_2.x
    L14_2 = L10_2.y
    L15_2 = L10_2.z
    L16_2 = true
    L17_2 = false
    L18_2 = false
    L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L11_2 = util
    L11_2 = L11_2.yield
    L12_2 = math
    L12_2 = L12_2.random
    L12_2 = L12_2()
    L12_2 = 10 * L12_2
    L11_2(L12_2)
    L11_2 = ENTITY
    L11_2 = L11_2.SET_ENTITY_COORDS
    L12_2 = PLAYER
    L12_2 = L12_2.PLAYER_PED_ID
    L12_2 = L12_2()
    L13_2 = L2_2.x
    L14_2 = L2_2.y
    L15_2 = L2_2.z
    L16_2 = true
    L17_2 = false
    L18_2 = false
    L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L11_2 = util
    L11_2 = L11_2.yield
    L12_2 = math
    L12_2 = L12_2.random
    L12_2 = L12_2()
    L12_2 = 10 * L12_2
    L11_2(L12_2)
  end
end
L47_1[L48_1] = L49_1
L47_1 = _ENV
L48_1 = "get_random_offset_from_entity"
function L49_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2
  L3_2 = ENTITY
  L3_2 = L3_2.GET_ENTITY_COORDS
  L4_2 = A0_2
  L5_2 = false
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = get_random_offset_in_range
  L5_2 = L3_2
  L6_2 = A1_2
  L7_2 = A2_2
  return L4_2(L5_2, L6_2, L7_2)
end
L47_1[L48_1] = L49_1
L47_1 = _ENV
L48_1 = "get_random_offset_in_range"
function L49_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L3_2 = random_float
  L4_2 = A1_2
  L5_2 = A2_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = random_float
  L5_2 = 0
  L6_2 = math
  L6_2 = L6_2.pi
  L6_2 = 2 * L6_2
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = v3
  L5_2 = L5_2.new
  L6_2 = math
  L6_2 = L6_2.cos
  L7_2 = L4_2
  L6_2 = L6_2(L7_2)
  L7_2 = math
  L7_2 = L7_2.sin
  L8_2 = L4_2
  L7_2 = L7_2(L8_2)
  L8_2 = 0.0
  L5_2 = L5_2(L6_2, L7_2, L8_2)
  L7_2 = L5_2
  L6_2 = L5_2.mul
  L8_2 = L3_2
  L6_2(L7_2, L8_2)
  L7_2 = A0_2
  L6_2 = A0_2.add
  L8_2 = L5_2
  L6_2(L7_2, L8_2)
  return A0_2
end
L47_1[L48_1] = L49_1
L47_1 = _ENV
L48_1 = "random_float"
function L49_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = math
  L2_2 = L2_2.random
  L2_2 = L2_2()
  L3_2 = A1_2 - A0_2
  L2_2 = L2_2 * L3_2
  L2_2 = A0_2 + L2_2
  return L2_2
end
L47_1[L48_1] = L49_1
L47_1 = _ENV
L48_1 = "creep"
function L49_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "s_m_y_clown_01"
  L1_2 = L1_2(L2_2)
  L2_2 = Effect
  L2_2 = L2_2.new
  L3_2 = "scr_rcbarry2"
  L4_2 = "scr_exp_clown"
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = Effect
  L3_2 = L3_2.new
  L4_2 = "scr_rcbarry2"
  L5_2 = "scr_clown_appears"
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = request_model
  L5_2 = L1_2
  L4_2(L5_2)
  L4_2 = PLAYER
  L4_2 = L4_2.GET_PLAYER_PED_SCRIPT_INDEX
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  L5_2 = ENTITY
  L5_2 = L5_2.GET_ENTITY_COORDS
  L6_2 = L4_2
  L7_2 = false
  L5_2 = L5_2(L6_2, L7_2)
  L6_2 = get_random_offset_from_entity
  L7_2 = L4_2
  L8_2 = 5.0
  L9_2 = 8.0
  L6_2 = L6_2(L7_2, L8_2, L9_2)
  L7_2 = L6_2.z
  L7_2 = L7_2 - 1.0
  L6_2.z = L7_2
  L7_2 = entities
  L7_2 = L7_2.create_ped
  L8_2 = 0
  L9_2 = L1_2
  L10_2 = L6_2
  L11_2 = 0.0
  L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2)
  L8_2 = request_ptfx_asset
  L9_2 = L3_2.asset
  L8_2(L9_2)
  L8_2 = GRAPHICS
  L8_2 = L8_2.USE_PARTICLE_FX_ASSET
  L9_2 = L3_2.asset
  L8_2(L9_2)
  L8_2 = GRAPHICS
  L9_2 = "START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY"
  L8_2 = L8_2[L9_2]
  L9_2 = L3_2.name
  L10_2 = L7_2
  L11_2 = 0.0
  L12_2 = 0.0
  L13_2 = -1.0
  L14_2 = 0.0
  L15_2 = 0.0
  L16_2 = 0.0
  L17_2 = 0.5
  L18_2 = false
  L19_2 = false
  L20_2 = false
  L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
  L8_2 = set_entity_face_entity
  L9_2 = L7_2
  L10_2 = L4_2
  L11_2 = false
  L8_2(L9_2, L10_2, L11_2)
  L8_2 = PED
  L8_2 = L8_2.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS
  L9_2 = L7_2
  L10_2 = true
  L8_2(L9_2, L10_2)
  L8_2 = TASK
  L8_2 = L8_2.TASK_GO_TO_COORD_ANY_MEANS
  L9_2 = L7_2
  L10_2 = L5_2.x
  L11_2 = L5_2.y
  L12_2 = L5_2.z
  L13_2 = 5.0
  L14_2 = 0
  L15_2 = false
  L16_2 = 0
  L17_2 = 0.0
  L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L8_2 = L5_2
  L9_2 = PED
  L9_2 = L9_2.SET_PED_KEEP_TASK
  L10_2 = L7_2
  L11_2 = true
  L9_2(L10_2, L11_2)
  L9_2 = AUDIO
  L9_2 = L9_2.STOP_PED_SPEAKING
  L10_2 = L7_2
  L11_2 = true
  L9_2(L10_2, L11_2)
  L9_2 = util
  L9_2 = L9_2.create_tick_handler
  function L10_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3
    L0_3 = ENTITY
    L0_3 = L0_3.GET_ENTITY_COORDS
    L1_3 = L7_2
    L2_3 = true
    L0_3 = L0_3(L1_3, L2_3)
    L1_3 = players
    L1_3 = L1_3.get_position
    L2_3 = A0_2
    L1_3 = L1_3(L2_3)
    L2_3 = ENTITY
    L2_3 = L2_3.DOES_ENTITY_EXIST
    L3_3 = L7_2
    L2_3 = L2_3(L3_3)
    if L2_3 then
      L2_3 = PED
      L2_3 = L2_3.IS_PED_FATALLY_INJURED
      L3_3 = L7_2
      L2_3 = L2_3(L3_3)
      if not L2_3 then
        goto lbl_25
      end
    end
    L2_3 = false
    do return L2_3 end
    goto lbl_122
    ::lbl_25::
    L3_3 = L0_3
    L2_3 = L0_3.distance
    L4_3 = L1_3
    L2_3 = L2_3(L3_3, L4_3)
    L3_3 = 150
    if L2_3 > L3_3 then
      L2_3 = request_control
      L3_3 = L7_2
      L2_3 = L2_3(L3_3)
      if L2_3 then
        L2_3 = delete_entity
        L3_3 = L7_2
        L2_3(L3_3)
        L2_3 = false
        return L2_3
    end
    else
      L3_3 = L0_3
      L2_3 = L0_3.distance
      L4_3 = L1_3
      L2_3 = L2_3(L3_3, L4_3)
      if L2_3 < 3.0 then
        L2_3 = request_control
        L3_3 = L7_2
        L2_3 = L2_3(L3_3)
        if L2_3 then
          L2_3 = request_ptfx_asset
          L3_3 = L2_2.asset
          L2_3(L3_3)
          L2_3 = GRAPHICS
          L2_3 = L2_3.USE_PARTICLE_FX_ASSET
          L3_3 = L2_2.asset
          L2_3(L3_3)
          L2_3 = GRAPHICS
          L3_3 = "START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD"
          L2_3 = L2_3[L3_3]
          L3_3 = L2_2.name
          L4_3 = L0_3.x
          L5_3 = L0_3.y
          L6_3 = L0_3.z
          L7_3 = 0.0
          L8_3 = 0.0
          L9_3 = 0.0
          L10_3 = 1.0
          L11_3 = false
          L12_3 = false
          L13_3 = false
          L14_3 = false
          L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3)
          L2_3 = FIRE
          L2_3 = L2_3.ADD_EXPLOSION
          L3_3 = L0_3.x
          L4_3 = L0_3.y
          L5_3 = L0_3.z
          L6_3 = 0
          L7_3 = 1.0
          L8_3 = true
          L9_3 = true
          L10_3 = 1.0
          L11_3 = false
          L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3)
          L2_3 = ENTITY
          L2_3 = L2_3.SET_ENTITY_VISIBLE
          L3_3 = L7_2
          L4_3 = false
          L5_3 = false
          L2_3(L3_3, L4_3, L5_3)
          L2_3 = delete_entity
          L3_3 = L7_2
          L2_3(L3_3)
          L2_3 = false
          return L2_3
      end
      else
        L3_3 = L1_3
        L2_3 = L1_3.distance
        L4_3 = L8_2
        L2_3 = L2_3(L3_3, L4_3)
        if L2_3 > 3.0 then
          L2_3 = request_control
          L3_3 = L7_2
          L2_3 = L2_3(L3_3)
          if L2_3 then
            L8_2 = L1_3
            L2_3 = TASK
            L2_3 = L2_3.TASK_GO_TO_COORD_ANY_MEANS
            L3_3 = L7_2
            L4_3 = L1_3.x
            L5_3 = L1_3.y
            L6_3 = L1_3.z
            L7_3 = 5.0
            L8_3 = 0
            L9_3 = false
            L10_3 = 0
            L11_3 = 0.0
            L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3)
          end
        end
      end
    end
    ::lbl_122::
  end
  L9_2(L10_2)
end
L47_1[L48_1] = L49_1
L47_1 = _ENV
L48_1 = "Preview"
L49_1 = {}
L50_1 = "handle"
L49_1[L50_1] = 0
L50_1 = "modelHash"
L49_1[L50_1] = 0
L47_1[L48_1] = L49_1
L47_1 = _ENV
L48_1 = "Preview"
L47_1 = L47_1[L48_1]
L48_1 = _ENV
L49_1 = "Preview"
L48_1 = L48_1[L49_1]
L47_1.__index = L48_1
L47_1 = _ENV
L48_1 = "Preview"
L47_1 = L47_1[L48_1]
L48_1 = "new"
function L49_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = setmetatable
  L2_2 = {}
  L3_2 = Preview
  L1_2 = L1_2(L2_2, L3_2)
  L1_2.modelHash = A0_2
  return L1_2
end
L47_1[L48_1] = L49_1
L47_1 = _ENV
L48_1 = "Preview"
L47_1 = L47_1[L48_1]
L48_1 = "create"
function L49_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L4_2 = A0_2
  L3_2 = A0_2.exists
  L3_2 = L3_2(L4_2)
  if L3_2 then
    return
  end
  L3_2 = VEHICLE
  L3_2 = L3_2.CREATE_VEHICLE
  L4_2 = A0_2.modelHash
  L5_2 = A1_2.x
  L6_2 = A1_2.y
  L7_2 = A1_2.z
  L8_2 = A2_2
  L9_2 = false
  L10_2 = false
  L11_2 = false
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  A0_2.handle = L3_2
  L3_2 = ENTITY
  L3_2 = L3_2.SET_ENTITY_ALPHA
  L4_2 = A0_2.handle
  L5_2 = 153
  L6_2 = true
  L3_2(L4_2, L5_2, L6_2)
  L3_2 = ENTITY
  L3_2 = L3_2.SET_ENTITY_COLLISION
  L4_2 = A0_2.handle
  L5_2 = false
  L6_2 = false
  L3_2(L4_2, L5_2, L6_2)
  L3_2 = ENTITY
  L3_2 = L3_2.SET_CAN_CLIMB_ON_ENTITY
  L4_2 = A0_2.handle
  L5_2 = false
  L3_2(L4_2, L5_2)
end
L47_1[L48_1] = L49_1
L47_1 = _ENV
L48_1 = "Preview"
L47_1 = L47_1[L48_1]
L48_1 = "setRotation"
function L49_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L2_2 = ENTITY
  L2_2 = L2_2.SET_ENTITY_ROTATION
  L3_2 = A0_2.handle
  L4_2 = A1_2.x
  L5_2 = A1_2.y
  L6_2 = A1_2.z
  L7_2 = 0
  L8_2 = true
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
end
L47_1[L48_1] = L49_1
L47_1 = _ENV
L48_1 = "Preview"
L47_1 = L47_1[L48_1]
L48_1 = "setCoords"
function L49_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = ENTITY
  L2_2 = L2_2.SET_ENTITY_COORDS_NO_OFFSET
  L3_2 = A0_2.handle
  L4_2 = A1_2.x
  L5_2 = A1_2.y
  L6_2 = A1_2.z
  L7_2 = false
  L8_2 = false
  L9_2 = false
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
end
L47_1[L48_1] = L49_1
L47_1 = _ENV
L48_1 = "Preview"
L47_1 = L47_1[L48_1]
L48_1 = "destroy"
function L49_1(A0_2)
  local L1_2, L2_2
  L1_2 = delete_entity
  L2_2 = A0_2.handle
  L1_2(L2_2)
  A0_2.handle = 0
end
L47_1[L48_1] = L49_1
L47_1 = _ENV
L48_1 = "Preview"
L47_1 = L47_1[L48_1]
L48_1 = "setOnGround"
function L49_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = VEHICLE
  L1_2 = L1_2.SET_VEHICLE_ON_GROUND_PROPERLY
  L2_2 = A0_2.handle
  L3_2 = 1.0
  L1_2(L2_2, L3_2)
end
L47_1[L48_1] = L49_1
L47_1 = _ENV
L48_1 = "Preview"
L47_1 = L47_1[L48_1]
L48_1 = "exists"
function L49_1(A0_2)
  local L1_2, L2_2
  L1_2 = A0_2.handle
  L1_2 = ENTITY
  L1_2 = L1_2.DOES_ENTITY_EXIST
  L2_2 = A0_2.handle
  L1_2 = 0 ~= L1_2 and L1_2
  return L1_2
end
L47_1[L48_1] = L49_1
L47_1 = _ENV
L48_1 = "util"
L47_1 = L47_1[L48_1]
L48_1 = "joaat"
L47_1 = L47_1[L48_1]
L48_1 = "adder"
L47_1 = L47_1(L48_1)
L48_1 = _ENV
L49_1 = "Preview"
L48_1 = L48_1[L49_1]
L49_1 = "new"
L48_1 = L48_1[L49_1]
L49_1 = L47_1
L48_1 = L48_1(L49_1)
L49_1 = false
L50_1 = 100.0
L51_1 = 15.0
L52_1 = 0.0
L53_1 = L51_1
L54_1 = _ENV
L55_1 = "get_veh_distance"
function L56_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = PAD
  L0_2 = L0_2.IS_CONTROL_JUST_PRESSED
  L1_2 = 2
  L2_2 = 241
  L0_2 = L0_2(L1_2, L2_2)
  if L0_2 then
    L0_2 = L52_1
    if L0_2 < 1.0 then
      L0_2 = L52_1
      L0_2 = L0_2 + 0.25
      L52_1 = L0_2
      L0_2 = timer
      L0_2 = L0_2.reset
      L0_2()
  end
  else
    L0_2 = PAD
    L0_2 = L0_2.IS_CONTROL_JUST_PRESSED
    L1_2 = 2
    L2_2 = 242
    L0_2 = L0_2(L1_2, L2_2)
    if L0_2 then
      L0_2 = L52_1
      if L0_2 > 0.0 then
        L0_2 = L52_1
        L0_2 = L0_2 - 0.25
        L52_1 = L0_2
        L0_2 = timer
        L0_2 = L0_2.reset
        L0_2()
      end
    end
  end
  L0_2 = interpolate
  L1_2 = L51_1
  L2_2 = L50_1
  L3_2 = L52_1
  L0_2 = L0_2(L1_2, L2_2, L3_2)
  L1_2 = L53_1
  if L1_2 ~= L0_2 then
    L1_2 = timer
    L1_2 = L1_2.elapsed
    L1_2 = L1_2()
    L2_2 = 200
    if L1_2 <= L2_2 then
      L1_2 = interpolate
      L2_2 = L53_1
      L3_2 = L0_2
      L4_2 = timer
      L4_2 = L4_2.elapsed
      L4_2 = L4_2()
      L4_2 = L4_2 / 200
      L1_2 = L1_2(L2_2, L3_2, L4_2)
      L53_1 = L1_2
    end
  end
  L1_2 = L53_1
  return L1_2
end
L54_1[L55_1] = L56_1
L54_1 = _ENV
L55_1 = "Instructional_add_control_group"
function L56_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = PAD
  L3_2 = "GET_CONTROL_GROUP_INSTRUCTIONAL_BUTTONS_STRING"
  L2_2 = L2_2[L3_2]
  L3_2 = 2
  L4_2 = A0_2
  L5_2 = true
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = Instructional
  L4_2 = L3_2
  L3_2 = L3_2.add_data_slot
  L5_2 = A0_2
  L6_2 = A1_2
  L7_2 = L2_2
  L3_2(L4_2, L5_2, L6_2, L7_2)
end
L54_1[L55_1] = L56_1
L54_1 = _ENV
L55_1 = "Vehicle_gun_opt"
function L56_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = Objvehicles
  L1_2 = L1_2[A0_2]
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = L1_2
  L2_2 = L2_2(L3_2)
  L47_1 = L2_2
end
L54_1[L55_1] = L56_1
L54_1 = _ENV
L55_1 = "Vehicle_gun_into"
function L56_1(A0_2)
  local L1_2
  L49_1 = A0_2
end
L54_1[L55_1] = L56_1
L54_1 = _ENV
L55_1 = "Vehicle_gun"
function L56_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L0_2 = request_model
  L1_2 = L47_1
  L0_2(L1_2)
  L0_2 = CAM
  L0_2 = L0_2.GET_GAMEPLAY_CAM_ROT
  L1_2 = 0
  L0_2 = L0_2(L1_2)
  L1_2 = get_veh_distance
  L1_2 = L1_2()
  L2_2 = get_raycast_result
  L3_2 = L1_2 + 5.0
  L4_2 = TraceFlag
  L4_2 = L4_2.world
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = L2_2.didHit
  if L3_2 then
    L3_2 = L2_2.endCoords
    if L3_2 then
      goto lbl_25
    end
  end
  L3_2 = get_offset_from_cam
  L4_2 = L1_2
  L3_2 = L3_2(L4_2)
  ::lbl_25::
  L4_2 = Config
  L4_2 = L4_2.general
  L4_2 = L4_2.disablepreview
  if not L4_2 then
    L4_2 = PLAYER
    L4_2 = L4_2.IS_PLAYER_FREE_AIMING
    L5_2 = PLAYER
    L5_2 = L5_2.PLAYER_ID
    L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L5_2()
    L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
    if L4_2 then
      L4_2 = L48_1
      L5_2 = L4_2
      L4_2 = L4_2.exists
      L4_2 = L4_2(L5_2)
      if not L4_2 then
        L4_2 = L47_1
        L48_1.modelHash = L4_2
        L4_2 = L48_1
        L5_2 = L4_2
        L4_2 = L4_2.create
        L6_2 = L3_2
        L7_2 = L0_2.z
        L4_2(L5_2, L6_2, L7_2)
      else
        L4_2 = L48_1
        L5_2 = L4_2
        L4_2 = L4_2.setCoords
        L6_2 = L3_2
        L4_2(L5_2, L6_2)
        L4_2 = L48_1
        L5_2 = L4_2
        L4_2 = L4_2.setRotation
        L6_2 = L0_2
        L4_2(L5_2, L6_2)
        L4_2 = L2_2.didHit
        if L4_2 then
          L4_2 = L48_1
          L5_2 = L4_2
          L4_2 = L4_2.setOnGround
          L4_2(L5_2)
        end
      end
      L4_2 = Instructional
      L5_2 = L4_2
      L4_2 = L4_2.begin
      L4_2 = L4_2(L5_2)
      if L4_2 then
        L4_2 = Instructional_add_control_group
        L5_2 = 29
        L6_2 = "FM_AE_SORT_2"
        L4_2(L5_2, L6_2)
        L4_2 = Instructional
        L5_2 = L4_2
        L4_2 = L4_2.set_background_colour
        L6_2 = 0
        L7_2 = 0
        L8_2 = 0
        L9_2 = 80
        L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
        L4_2 = Instructional
        L5_2 = L4_2
        L4_2 = L4_2.draw
        L4_2(L5_2)
      end
  end
  else
    L4_2 = L48_1
    L5_2 = L4_2
    L4_2 = L4_2.exists
    L4_2 = L4_2(L5_2)
    if L4_2 then
      L4_2 = L48_1
      L5_2 = L4_2
      L4_2 = L4_2.destroy
      L4_2(L5_2)
    end
  end
  L4_2 = PED
  L4_2 = L4_2.IS_PED_SHOOTING
  L5_2 = PLAYER
  L5_2 = L5_2.PLAYER_PED_ID
  L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L5_2()
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  if L4_2 then
    L4_2 = VEHICLE
    L4_2 = L4_2.CREATE_VEHICLE
    L5_2 = L47_1
    L6_2 = L3_2.x
    L7_2 = L3_2.y
    L8_2 = L3_2.z
    L9_2 = L0_2.z
    L10_2 = true
    L11_2 = true
    L12_2 = false
    L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
    L5_2 = NETWORK
    L5_2 = L5_2.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES
    L6_2 = NETWORK
    L6_2 = L6_2.VEH_TO_NET
    L7_2 = L4_2
    L6_2 = L6_2(L7_2)
    L7_2 = true
    L5_2(L6_2, L7_2)
    L5_2 = ENTITY
    L5_2 = L5_2.SET_ENTITY_COORDS_NO_OFFSET
    L6_2 = L4_2
    L7_2 = L3_2.x
    L8_2 = L3_2.y
    L9_2 = L3_2.z
    L10_2 = false
    L11_2 = false
    L12_2 = false
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
    L5_2 = ENTITY
    L5_2 = L5_2.SET_ENTITY_ROTATION
    L6_2 = L4_2
    L7_2 = L0_2.x
    L8_2 = L0_2.y
    L9_2 = L0_2.z
    L10_2 = 0
    L11_2 = true
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    L5_2 = VEHICLE
    L5_2 = L5_2.SET_VEHICLE_FORWARD_SPEED
    L6_2 = L4_2
    L7_2 = 200.0
    L5_2(L6_2, L7_2)
    L5_2 = L49_1
    if not L5_2 then
      L5_2 = VEHICLE
      L5_2 = L5_2.SET_VEHICLE_DOORS_LOCKED
      L6_2 = L4_2
      L7_2 = 2
      L5_2(L6_2, L7_2)
    else
      L5_2 = VEHICLE
      L5_2 = L5_2.SET_VEHICLE_ENGINE_ON
      L6_2 = L4_2
      L7_2 = true
      L8_2 = true
      L9_2 = true
      L5_2(L6_2, L7_2, L8_2, L9_2)
      L5_2 = PED
      L5_2 = L5_2.SET_PED_INTO_VEHICLE
      L6_2 = PLAYER
      L6_2 = L6_2.PLAYER_PED_ID
      L6_2 = L6_2()
      L7_2 = L4_2
      L8_2 = -1
      L5_2(L6_2, L7_2, L8_2)
    end
  end
end
L54_1[L55_1] = L56_1
L54_1 = _ENV
L55_1 = "Vehicle_gun_stop"
function L56_1()
  local L0_2, L1_2
  L0_2 = L48_1
  L1_2 = L0_2
  L0_2 = L0_2.exists
  L0_2 = L0_2(L1_2)
  if L0_2 then
    L0_2 = L48_1
    L1_2 = L0_2
    L0_2 = L0_2.destroy
    L0_2(L1_2)
  end
end
L54_1[L55_1] = L56_1
L54_1 = {}
L55_1 = _ENV
L56_1 = "change_ridicule"
function L57_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = util
  L0_2 = L0_2.register_label
  L1_2 = "嘲讽内容"
  L0_2 = L0_2(L1_2)
  L1_2 = get_input_from_screen_keyboard
  L2_2 = L0_2
  L3_2 = 50
  L4_2 = chaofeng
  L1_2 = L1_2(L2_2, L3_2, L4_2)
  if "" == L1_2 then
    return
  end
  chaofeng = L1_2
end
L55_1[L56_1] = L57_1
L55_1 = _ENV
L56_1 = "Attack_ridicule"
function L57_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L0_2 = ipairs
  L1_2 = players
  L1_2 = L1_2.list
  L2_2 = false
  L3_2 = true
  L4_2 = true
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L1_2(L2_2, L3_2, L4_2)
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = players
    L6_2 = L6_2.is_marked_as_attacker
    L7_2 = L5_2
    L8_2 = SYSTEM
    L8_2 = L8_2.SHIFT_LEFT
    L9_2 = 3
    L10_2 = 1
    L8_2, L9_2, L10_2 = L8_2(L9_2, L10_2)
    L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
    if not L6_2 then
      L6_2 = players
      L6_2 = L6_2.is_marked_as_attacker
      L7_2 = L5_2
      L8_2 = SYSTEM
      L8_2 = L8_2.SHIFT_LEFT
      L9_2 = 4
      L10_2 = 1
      L8_2, L9_2, L10_2 = L8_2(L9_2, L10_2)
      L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
      if not L6_2 then
        L6_2 = players
        L6_2 = L6_2.is_marked_as_attacker
        L7_2 = L5_2
        L8_2 = SYSTEM
        L8_2 = L8_2.SHIFT_LEFT
        L9_2 = 5
        L10_2 = 1
        L8_2, L9_2, L10_2 = L8_2(L9_2, L10_2)
        L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
        if not L6_2 then
          L6_2 = players
          L6_2 = L6_2.is_marked_as_attacker
          L7_2 = L5_2
          L8_2 = SYSTEM
          L8_2 = L8_2.SHIFT_LEFT
          L9_2 = 12
          L10_2 = 1
          L8_2, L9_2, L10_2 = L8_2(L9_2, L10_2)
          L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
          if not L6_2 then
            L6_2 = players
            L6_2 = L6_2.is_marked_as_attacker
            L7_2 = L5_2
            L8_2 = SYSTEM
            L8_2 = L8_2.SHIFT_LEFT
            L9_2 = 13
            L10_2 = 1
            L8_2, L9_2, L10_2 = L8_2(L9_2, L10_2)
            L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
            if not L6_2 then
              L6_2 = players
              L6_2 = L6_2.is_marked_as_attacker
              L7_2 = L5_2
              L8_2 = SYSTEM
              L8_2 = L8_2.SHIFT_LEFT
              L9_2 = 14
              L10_2 = 1
              L8_2, L9_2, L10_2 = L8_2(L9_2, L10_2)
              L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
              if not L6_2 then
                goto lbl_100
              end
            end
          end
        end
      end
    end
    L6_2 = table_find
    L7_2 = L54_1
    L8_2 = L5_2
    L6_2 = L6_2(L7_2, L8_2)
    if not L6_2 then
      L6_2 = chat
      L6_2 = L6_2.send_message
      L7_2 = PLAYER
      L7_2 = L7_2.GET_PLAYER_NAME
      L8_2 = L5_2
      L7_2 = L7_2(L8_2)
      L8_2 = chaofeng
      L9_2 = author
      L7_2 = L7_2 .. L8_2 .. L9_2
      L8_2 = false
      L9_2 = true
      L10_2 = true
      L6_2(L7_2, L8_2, L9_2, L10_2)
      L6_2 = table
      L6_2 = L6_2.insert
      L7_2 = L54_1
      L8_2 = L5_2
      L6_2(L7_2, L8_2)
    end
    ::lbl_100::
  end
  L0_2 = pairs
  L1_2 = L54_1
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = PLAYER
    L6_2 = L6_2.GET_PLAYER_PED
    L7_2 = L5_2
    L6_2 = L6_2(L7_2)
    if 0 == L6_2 then
      L6_2 = L54_1
      L6_2[L4_2] = nil
    end
  end
end
L55_1[L56_1] = L57_1
L55_1 = _ENV
L56_1 = "get_offset_from_camera"
function L57_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = CAM
  L1_2 = L1_2.GET_FINAL_RENDERED_CAM_ROT
  L2_2 = 0
  L1_2 = L1_2(L2_2)
  L2_2 = CAM
  L2_2 = L2_2.GET_FINAL_RENDERED_CAM_COORD
  L2_2 = L2_2()
  L3_2 = rotation_to_direction
  L4_2 = L1_2
  L3_2 = L3_2(L4_2)
  L4_2 = {}
  L5_2 = L2_2.x
  L6_2 = L3_2.x
  L6_2 = L6_2 * A0_2
  L5_2 = L5_2 + L6_2
  L4_2.x = L5_2
  L5_2 = L2_2.y
  L6_2 = L3_2.y
  L6_2 = L6_2 * A0_2
  L5_2 = L5_2 + L6_2
  L4_2.y = L5_2
  L5_2 = L2_2.z
  L6_2 = L3_2.z
  L6_2 = L6_2 * A0_2
  L5_2 = L5_2 + L6_2
  L4_2.z = L5_2
  return L4_2
end
L55_1[L56_1] = L57_1
L55_1 = _ENV
L56_1 = "rotation_to_direction"
function L57_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = {}
  L2_2 = math
  L2_2 = L2_2.pi
  L2_2 = L2_2 / 180
  L3_2 = A0_2.x
  L2_2 = L2_2 * L3_2
  L1_2.x = L2_2
  L2_2 = math
  L2_2 = L2_2.pi
  L2_2 = L2_2 / 180
  L3_2 = A0_2.y
  L2_2 = L2_2 * L3_2
  L1_2.y = L2_2
  L2_2 = math
  L2_2 = L2_2.pi
  L2_2 = L2_2 / 180
  L3_2 = A0_2.z
  L2_2 = L2_2 * L3_2
  L1_2.z = L2_2
  L2_2 = {}
  L3_2 = math
  L3_2 = L3_2.sin
  L4_2 = L1_2.z
  L3_2 = L3_2(L4_2)
  L3_2 = -L3_2
  L4_2 = math
  L4_2 = L4_2.abs
  L5_2 = math
  L5_2 = L5_2.cos
  L6_2 = L1_2.x
  L5_2, L6_2 = L5_2(L6_2)
  L4_2 = L4_2(L5_2, L6_2)
  L3_2 = L3_2 * L4_2
  L2_2.x = L3_2
  L3_2 = math
  L3_2 = L3_2.cos
  L4_2 = L1_2.z
  L3_2 = L3_2(L4_2)
  L4_2 = math
  L4_2 = L4_2.abs
  L5_2 = math
  L5_2 = L5_2.cos
  L6_2 = L1_2.x
  L5_2, L6_2 = L5_2(L6_2)
  L4_2 = L4_2(L5_2, L6_2)
  L3_2 = L3_2 * L4_2
  L2_2.y = L3_2
  L3_2 = math
  L3_2 = L3_2.sin
  L4_2 = L1_2.x
  L3_2 = L3_2(L4_2)
  L2_2.z = L3_2
  return L2_2
end
L55_1[L56_1] = L57_1
function L55_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = CAM
  L1_2 = L1_2.GET_FINAL_RENDERED_CAM_ROT
  L2_2 = 0
  L1_2 = L1_2(L2_2)
  L2_2 = CAM
  L2_2 = L2_2.GET_FINAL_RENDERED_CAM_COORD
  L2_2 = L2_2()
  L3_2 = rotation_to_direction
  L4_2 = L1_2
  L3_2 = L3_2(L4_2)
  L4_2 = {}
  L5_2 = L2_2.x
  L6_2 = L3_2.x
  L6_2 = L6_2 * A0_2
  L5_2 = L5_2 + L6_2
  L4_2.x = L5_2
  L5_2 = L2_2.y
  L6_2 = L3_2.y
  L6_2 = L6_2 * A0_2
  L5_2 = L5_2 + L6_2
  L4_2.y = L5_2
  L5_2 = L2_2.z
  L6_2 = L3_2.z
  L6_2 = L6_2 * A0_2
  L5_2 = L5_2 + L6_2
  L4_2.z = L5_2
  return L4_2
end
L56_1 = _ENV
L57_1 = "override_lodscale"
function L58_1(A0_2)
  local L1_2, L2_2
  while A0_2 and 1 ~= A0_2 do
    L1_2 = STREAMING
    L1_2 = L1_2.OVERRIDE_LODSCALE_THIS_FRAME
    L2_2 = A0_2
    L1_2(L2_2)
    goto lbl_11
    do break end
    ::lbl_11::
    L1_2 = util
    L1_2 = L1_2.yield
    L1_2()
  end
end
L56_1[L57_1] = L58_1
L56_1 = _ENV
L57_1 = "dead_warning"
function L58_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L0_2 = ENTITY
  L0_2 = L0_2.IS_ENTITY_DEAD
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  if L0_2 then
    L0_2 = "~o~不玩原神\n死了吧-~o~"
    L1_2 = PLAYER
    L1_2 = L1_2.GET_PLAYER_NAME
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_ID
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L2_2()
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    L0_2 = L0_2 .. L1_2
    L1_2 = GRAPHICS
    L1_2 = L1_2.REQUEST_SCALEFORM_MOVIE
    L2_2 = "MP_BIG_MESSAGE_FREEMODE"
    L1_2 = L1_2(L2_2)
    L2_2 = GRAPHICS
    L2_2 = L2_2.BEGIN_SCALEFORM_MOVIE_METHOD
    L3_2 = L1_2
    L4_2 = "SHOW_SHARD_WASTED_MP_MESSAGE"
    L2_2(L3_2, L4_2)
    L2_2 = GRAPHICS
    L2_2 = L2_2.DRAW_SCALEFORM_MOVIE
    L3_2 = L1_2
    L4_2 = 0.5
    L5_2 = 0.5
    L6_2 = 1
    L7_2 = 1
    L8_2 = 255
    L9_2 = 225
    L10_2 = 255
    L11_2 = 255
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    L2_2 = GRAPHICS
    L3_2 = "SCALEFORM_MOVIE_METHOD_ADD_PARAM_TEXTURE_NAME_STRING"
    L2_2 = L2_2[L3_2]
    L3_2 = L0_2
    L2_2(L3_2)
    L2_2 = GRAPHICS
    L2_2 = L2_2.END_SCALEFORM_MOVIE_METHOD
    L3_2 = L1_2
    L2_2(L3_2)
  end
end
L56_1[L57_1] = L58_1
L56_1 = _ENV
L57_1 = "get_vehicle_player_is_in"
function L58_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED_SCRIPT_INDEX
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = PED
  L2_2 = L2_2.IS_PED_IN_ANY_VEHICLE
  L3_2 = L1_2
  L4_2 = false
  L2_2 = L2_2(L3_2, L4_2)
  if L2_2 then
    L2_2 = PED
    L2_2 = L2_2.GET_VEHICLE_PED_IS_IN
    L3_2 = L1_2
    L4_2 = false
    return L2_2(L3_2, L4_2)
  end
  L2_2 = 0
  return L2_2
end
L56_1[L57_1] = L58_1
L56_1 = _ENV
L57_1 = "addBlipForEntity"
function L58_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L3_2 = HUD
  L3_2 = L3_2.ADD_BLIP_FOR_ENTITY
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = HUD
  L4_2 = L4_2.SET_BLIP_SPRITE
  L5_2 = L3_2
  L6_2 = A1_2
  L4_2(L5_2, L6_2)
  L4_2 = HUD
  L4_2 = L4_2.SET_BLIP_COLOUR
  L5_2 = L3_2
  L6_2 = A2_2
  L4_2(L5_2, L6_2)
  L4_2 = HUD
  L4_2 = L4_2.SHOW_HEIGHT_ON_BLIP
  L5_2 = L3_2
  L6_2 = false
  L4_2(L5_2, L6_2)
  L4_2 = HUD
  L4_2 = L4_2.SET_BLIP_ROTATION
  L5_2 = L3_2
  L6_2 = SYSTEM
  L6_2 = L6_2.CEIL
  L7_2 = ENTITY
  L7_2 = L7_2.GET_ENTITY_HEADING
  L8_2 = A0_2
  L7_2, L8_2 = L7_2(L8_2)
  L6_2, L7_2, L8_2 = L6_2(L7_2, L8_2)
  L4_2(L5_2, L6_2, L7_2, L8_2)
  L4_2 = NETWORK
  L4_2 = L4_2.SET_NETWORK_ID_CAN_MIGRATE
  L5_2 = A0_2
  L6_2 = false
  L4_2(L5_2, L6_2)
  L4_2 = util
  L4_2 = L4_2.create_thread
  function L5_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3
    while true do
      L0_3 = ENTITY
      L0_3 = L0_3.IS_ENTITY_DEAD
      L1_3 = A0_2
      L0_3 = L0_3(L1_3)
      if L0_3 then
        break
      end
      L0_3 = ENTITY
      L0_3 = L0_3.GET_ENTITY_HEADING
      L1_3 = A0_2
      L0_3 = L0_3(L1_3)
      L1_3 = HUD
      L1_3 = L1_3.SET_BLIP_ROTATION
      L2_3 = L3_2
      L3_3 = SYSTEM
      L3_3 = L3_3.CEIL
      L4_3 = L0_3
      L3_3, L4_3 = L3_3(L4_3)
      L1_3(L2_3, L3_3, L4_3)
      L1_3 = util
      L1_3 = L1_3.yield
      L1_3()
      L1_3 = ENTITY
      L1_3 = L1_3.IS_ENTITY_DEAD
      L2_3 = A0_2
      L1_3 = L1_3(L2_3)
      if not L1_3 then
        L1_3 = ENTITY
        L1_3 = L1_3.IS_ENTITY_DEAD
        L2_3 = A0_2
        L1_3 = L1_3(L2_3)
        if not L1_3 then
          L1_3 = ENTITY
          L1_3 = L1_3.DOES_ENTITY_EXIST
          L2_3 = A0_2
          L1_3 = L1_3(L2_3)
          if L1_3 then
            L1_3 = VEHICLE
            L1_3 = L1_3.GET_VEHICLE_ENGINE_HEALTH
            L2_3 = A0_2
            L1_3 = L1_3(L2_3)
            if not (L1_3 <= 0) then
              goto lbl_53
            end
          end
        end
      end
      L1_3 = util
      L1_3 = L1_3.remove_blip
      L2_3 = L3_2
      L1_3(L2_3)
      L1_3 = util
      L1_3 = L1_3.yield
      L1_3()
      ::lbl_53::
    end
  end
  L4_2(L5_2)
  return L3_2
end
L56_1[L57_1] = L58_1
L56_1 = _ENV
L57_1 = "getOffsetFromEntityGivenDistance"
function L58_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = A0_2
  L4_2 = 0
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = math
  L3_2 = L3_2.random
  L3_2 = L3_2()
  L4_2 = math
  L4_2 = L4_2.random
  L5_2 = 0
  L6_2 = 1
  L4_2 = L4_2(L5_2, L6_2)
  L3_2 = L3_2 + L4_2
  L4_2 = math
  L4_2 = L4_2.pi
  L3_2 = L3_2 * L4_2
  L4_2 = vect
  L4_2 = L4_2.new
  L5_2 = L2_2.x
  L6_2 = math
  L6_2 = L6_2.cos
  L7_2 = L3_2
  L6_2 = L6_2(L7_2)
  L6_2 = A1_2 * L6_2
  L5_2 = L5_2 + L6_2
  L6_2 = L2_2.y
  L7_2 = math
  L7_2 = L7_2.sin
  L8_2 = L3_2
  L7_2 = L7_2(L8_2)
  L7_2 = A1_2 * L7_2
  L6_2 = L6_2 + L7_2
  L7_2 = L2_2.z
  L4_2 = L4_2(L5_2, L6_2, L7_2)
  return L4_2
end
L56_1[L57_1] = L58_1
L56_1 = _ENV
L57_1 = "send_Angry_Trevor"
function L58_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "bodhi2"
  L1_2 = L1_2(L2_2)
  L2_2 = -1686040670
  L3_2 = request_models
  L4_2 = L1_2
  L5_2 = L2_2
  L3_2(L4_2, L5_2)
  L3_2 = PLAYER
  L3_2 = L3_2.GET_PLAYER_PED_SCRIPT_INDEX
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = ENTITY
  L4_2 = L4_2.GET_ENTITY_COORDS
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  L5_2 = entities
  L5_2 = L5_2.create_vehicle
  L6_2 = L1_2
  L7_2 = L4_2
  L8_2 = CAM
  L8_2 = L8_2.GET_GAMEPLAY_CAM_ROT
  L9_2 = 0
  L8_2 = L8_2(L9_2)
  L8_2 = L8_2.z
  L5_2 = L5_2(L6_2, L7_2, L8_2)
  L6_2 = ENTITY
  L6_2 = L6_2.DOES_ENTITY_EXIST
  L7_2 = L5_2
  L6_2 = L6_2(L7_2)
  if not L6_2 then
    return
  end
  L6_2 = getOffsetFromEntityGivenDistance
  L7_2 = L5_2
  L8_2 = 50.0
  L6_2 = L6_2(L7_2, L8_2)
  L7_2 = v3
  L7_2 = L7_2.new
  L7_2 = L7_2()
  L8_2 = memory
  L8_2 = L8_2.alloc
  L8_2 = L8_2()
  L9_2 = PATHFIND
  L9_2 = L9_2.GET_CLOSEST_VEHICLE_NODE_WITH_HEADING
  L10_2 = L6_2.x
  L11_2 = L6_2.y
  L12_2 = L6_2.z
  L13_2 = L7_2
  L14_2 = L8_2
  L15_2 = 1
  L16_2 = 3.0
  L17_2 = 0
  L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  if L9_2 then
    L9_2 = ENTITY
    L9_2 = L9_2.SET_ENTITY_COORDS
    L10_2 = L5_2
    L11_2 = v3
    L11_2 = L11_2.getX
    L12_2 = L7_2
    L11_2 = L11_2(L12_2)
    L12_2 = v3
    L12_2 = L12_2.getY
    L13_2 = L7_2
    L12_2 = L12_2(L13_2)
    L13_2 = v3
    L13_2 = L13_2.getZ
    L14_2 = L7_2
    L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2 = L13_2(L14_2)
    L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
    L9_2 = ENTITY
    L9_2 = L9_2.SET_ENTITY_HEADING
    L10_2 = L5_2
    L11_2 = memory
    L11_2 = L11_2.read_float
    L12_2 = L8_2
    L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2 = L11_2(L12_2)
    L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
    L9_2 = VEHICLE
    L9_2 = L9_2.SET_VEHICLE_SIREN
    L10_2 = L5_2
    L11_2 = true
    L9_2(L10_2, L11_2)
    L9_2 = VEHICLE
    L9_2 = L9_2.SET_VEHICLE_ENGINE_ON
    L10_2 = L5_2
    L11_2 = true
    L12_2 = true
    L13_2 = true
    L9_2(L10_2, L11_2, L12_2, L13_2)
    L9_2 = -1
    L10_2 = -1
    L11_2 = 1
    for L12_2 = L9_2, L10_2, L11_2 do
      L13_2 = entities
      L13_2 = L13_2.create_ped
      L14_2 = 2
      L15_2 = L2_2
      L16_2 = L7_2
      L17_2 = CAM
      L17_2 = L17_2.GET_GAMEPLAY_CAM_ROT
      L18_2 = 0
      L17_2 = L17_2(L18_2)
      L17_2 = L17_2.z
      L13_2 = L13_2(L14_2, L15_2, L16_2, L17_2)
      L14_2 = addBlipForEntity
      L15_2 = L5_2
      L16_2 = 724
      L17_2 = 17
      L14_2(L15_2, L16_2, L17_2)
      L14_2 = PED
      L14_2 = L14_2.SET_PED_INTO_VEHICLE
      L15_2 = L13_2
      L16_2 = L5_2
      L17_2 = L12_2
      L14_2(L15_2, L16_2, L17_2)
      L14_2 = TASK
      L14_2 = L14_2.TASK_COMBAT_PED
      L15_2 = L13_2
      L16_2 = L3_2
      L17_2 = 0
      L18_2 = 16
      L14_2(L15_2, L16_2, L17_2, L18_2)
      L14_2 = PED
      L14_2 = L14_2.SET_PED_KEEP_TASK
      L15_2 = L13_2
      L16_2 = true
      L14_2(L15_2, L16_2)
      L14_2 = VEHICLE
      L14_2 = L14_2.SET_VEHICLE_COLOURS
      L15_2 = L5_2
      L16_2 = 32
      L17_2 = 32
      L14_2(L15_2, L16_2, L17_2)
      L14_2 = VEHICLE
      L15_2 = "SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS"
      L14_2 = L14_2[L15_2]
      L15_2 = L5_2
      L16_2 = true
      L14_2(L15_2, L16_2)
      L14_2 = VEHICLE
      L14_2 = L14_2.SET_VEHICLE_DOORS_LOCKED
      L15_2 = L5_2
      L16_2 = -1
      L17_2 = 3
      L14_2(L15_2, L16_2, L17_2)
      L14_2 = PED
      L14_2 = L14_2.SET_PED_COMBAT_ATTRIBUTES
      L15_2 = L13_2
      L16_2 = 46
      L17_2 = true
      L14_2(L15_2, L16_2, L17_2)
      L14_2 = PED
      L14_2 = L14_2.SET_PED_COMBAT_ATTRIBUTES
      L15_2 = L13_2
      L16_2 = 3
      L17_2 = false
      L14_2(L15_2, L16_2, L17_2)
      L14_2 = PED
      L14_2 = L14_2.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS
      L15_2 = L13_2
      L16_2 = true
      L14_2(L15_2, L16_2)
      L14_2 = VEHICLE
      L14_2 = L14_2.SET_VEHICLE_NUMBER_PLATE_TEXT
      L15_2 = L5_2
      L16_2 = "Betty 32"
      L14_2(L15_2, L16_2)
      L14_2 = VEHICLE
      L14_2 = L14_2.MODIFY_VEHICLE_TOP_SPEED
      L15_2 = L5_2
      L16_2 = 50
      L14_2(L15_2, L16_2)
      L14_2 = ENTITY
      L14_2 = L14_2.SET_ENTITY_INVINCIBLE
      L15_2 = L13_2
      L16_2 = true
      L14_2(L15_2, L16_2)
      L14_2 = ENTITY
      L14_2 = L14_2.SET_ENTITY_INVINCIBLE
      L15_2 = L5_2
      L16_2 = true
      L14_2(L15_2, L16_2)
      L14_2 = VEHICLE
      L14_2 = L14_2.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX
      L15_2 = L5_2
      L16_2 = 0
      L14_2(L15_2, L16_2)
      L14_2 = PED
      L14_2 = L14_2.SET_PED_NEVER_LEAVES_GROUP
      L15_2 = L13_2
      L16_2 = true
      L14_2(L15_2, L16_2)
      L14_2 = TASK
      L14_2 = L14_2.TASK_VEHICLE_MISSION_PED_TARGET
      L15_2 = L13_2
      L16_2 = L5_2
      L17_2 = L3_2
      L18_2 = 6
      L19_2 = 100
      L20_2 = 0
      L21_2 = 0
      L22_2 = 0
      L23_2 = true
      L14_2(L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
    end
    L9_2 = 0
    L10_2 = 0
    L11_2 = 1
    for L12_2 = L9_2, L10_2, L11_2 do
      L13_2 = entities
      L13_2 = L13_2.create_ped
      L14_2 = 2
      L15_2 = L2_2
      L16_2 = L7_2
      L17_2 = CAM
      L17_2 = L17_2.GET_GAMEPLAY_CAM_ROT
      L18_2 = 0
      L17_2 = L17_2(L18_2)
      L17_2 = L17_2.z
      L13_2 = L13_2(L14_2, L15_2, L16_2, L17_2)
      L14_2 = PED
      L14_2 = L14_2.SET_PED_INTO_VEHICLE
      L15_2 = L13_2
      L16_2 = L5_2
      L17_2 = L12_2
      L14_2(L15_2, L16_2, L17_2)
      L14_2 = PED
      L14_2 = L14_2.SET_PED_COMBAT_ATTRIBUTES
      L15_2 = L13_2
      L16_2 = 3
      L17_2 = false
      L14_2(L15_2, L16_2, L17_2)
      L14_2 = PED
      L14_2 = L14_2.SET_PED_COMBAT_ATTRIBUTES
      L15_2 = L13_2
      L16_2 = 46
      L17_2 = true
      L14_2(L15_2, L16_2, L17_2)
      L14_2 = ENTITY
      L14_2 = L14_2.SET_ENTITY_VISIBLE
      L15_2 = L13_2
      L16_2 = false
      L17_2 = 0
      L14_2(L15_2, L16_2, L17_2)
      L14_2 = TASK
      L14_2 = L14_2.TASK_COMBAT_PED
      L15_2 = L13_2
      L16_2 = L3_2
      L17_2 = 0
      L18_2 = 16
      L14_2(L15_2, L16_2, L17_2, L18_2)
      L14_2 = ENTITY
      L14_2 = L14_2.SET_ENTITY_INVINCIBLE
      L15_2 = L13_2
      L16_2 = true
      L14_2(L15_2, L16_2)
      L14_2 = PED
      L14_2 = L14_2.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS
      L15_2 = L13_2
      L16_2 = true
      L14_2(L15_2, L16_2)
    end
  end
  L9_2 = STREAMING
  L9_2 = L9_2.SET_MODEL_AS_NO_LONGER_NEEDED
  L10_2 = L2_2
  L9_2(L10_2)
  L9_2 = STREAMING
  L9_2 = L9_2.SET_MODEL_AS_NO_LONGER_NEEDED
  L10_2 = L1_2
  L9_2(L10_2)
end
L56_1[L57_1] = L58_1
L56_1 = _ENV
L57_1 = "ride_cow"
function L58_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2
  if A0_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.GET_ENTITY_HEADING
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L2_2()
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
    L2_2 = ENTITY
    L2_2 = L2_2.GET_ENTITY_COORDS
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L3_2()
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
    L3_2 = create_vehicle
    L4_2 = 1641462412
    L5_2 = L2_2.x
    L6_2 = L2_2.y
    L7_2 = L2_2.z
    L8_2 = L1_2
    L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
    L4_2 = ENTITY
    L4_2 = L4_2.SET_ENTITY_VISIBLE
    L5_2 = L3_2
    L6_2 = false
    L7_2 = 0
    L4_2(L5_2, L6_2, L7_2)
    L4_2 = ENTITY
    L4_2 = L4_2.SET_ENTITY_INVINCIBLE
    L5_2 = L3_2
    L6_2 = true
    L4_2(L5_2, L6_2)
    L4_2 = create_ped
    L5_2 = 29
    L6_2 = 4244282910
    L7_2 = L2_2.x
    L8_2 = L2_2.y
    L9_2 = L2_2.z
    L10_2 = L1_2
    L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
    L5_2 = PED
    L5_2 = L5_2.SET_PED_INTO_VEHICLE
    L6_2 = PLAYER
    L6_2 = L6_2.PLAYER_PED_ID
    L6_2 = L6_2()
    L7_2 = L3_2
    L8_2 = -1
    L5_2(L6_2, L7_2, L8_2)
    L5_2 = PED
    L5_2 = L5_2.GET_PED_BONE_INDEX
    L6_2 = L4_2
    L7_2 = 31086
    L5_2 = L5_2(L6_2, L7_2)
    L6_2 = ENTITY
    L6_2 = L6_2.ATTACH_ENTITY_TO_ENTITY
    L7_2 = L4_2
    L8_2 = L3_2
    L9_2 = L5_2
    L10_2 = 0
    L11_2 = -1
    L12_2 = 0.5
    L13_2 = 0
    L14_2 = 0
    L15_2 = 0
    L16_2 = true
    L17_2 = false
    L18_2 = false
    L19_2 = false
    L20_2 = 1
    L21_2 = true
    L22_2 = 0
    L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
    L6_2 = PED
    L6_2 = L6_2.SET_PED_CONFIG_FLAG
    L7_2 = L4_2
    L8_2 = 208
    L9_2 = true
    L6_2(L7_2, L8_2, L9_2)
    L6_2 = PED
    L6_2 = L6_2.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS
    L7_2 = L4_2
    L8_2 = true
    L6_2(L7_2, L8_2)
    L6_2 = ENTITY
    L6_2 = L6_2.SET_ENTITY_INVINCIBLE
    L7_2 = L4_2
    L8_2 = true
    L6_2(L7_2, L8_2)
  else
    L1_2 = delete_entity
    L2_2 = vehicle_for_cow_rider
    L1_2(L2_2)
    L1_2 = delete_entity
    L2_2 = cow_for_cow_rider
    L1_2(L2_2)
  end
end
L56_1[L57_1] = L58_1
L56_1 = _ENV
L57_1 = "Pearl_fireworks"
function L58_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2
  L0_2 = "anim@mp_fireworks"
  L1_2 = "place_firework_3_box"
  L2_2 = request_anim_dict
  L3_2 = L0_2
  L2_2(L3_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2 = L3_2()
  L4_2 = 0.0
  L5_2 = 0.52
  L6_2 = 0.0
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  L3_2 = ENTITY
  L3_2 = L3_2.FREEZE_ENTITY_POSITION
  L4_2 = PLAYER
  L4_2 = L4_2.PLAYER_PED_ID
  L4_2 = L4_2()
  L5_2 = true
  L3_2(L4_2, L5_2)
  L3_2 = TASK
  L3_2 = L3_2.TASK_PLAY_ANIM
  L4_2 = PLAYER
  L4_2 = L4_2.PLAYER_PED_ID
  L4_2 = L4_2()
  L5_2 = L0_2
  L6_2 = L1_2
  L7_2 = -1
  L8_2 = -8.0
  L9_2 = 3000
  L10_2 = 0
  L11_2 = 0
  L12_2 = false
  L13_2 = false
  L14_2 = false
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  L3_2 = util
  L3_2 = L3_2.yield
  L4_2 = 1500
  L3_2(L4_2)
  L3_2 = create_object
  L4_2 = -879052345
  L5_2 = L2_2.x
  L6_2 = L2_2.y
  L7_2 = L2_2.z
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
  L4_2 = ENTITY
  L4_2 = L4_2.GET_ENTITY_COORDS
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  L5_2 = OBJECT
  L5_2 = L5_2.PLACE_OBJECT_ON_GROUND_PROPERLY
  L6_2 = L3_2
  L5_2(L6_2)
  L5_2 = ENTITY
  L5_2 = L5_2.FREEZE_ENTITY_POSITION
  L6_2 = PLAYER
  L6_2 = L6_2.PLAYER_PED_ID
  L6_2 = L6_2()
  L7_2 = false
  L5_2(L6_2, L7_2)
  L5_2 = ENTITY
  L5_2 = L5_2.FREEZE_ENTITY_POSITION
  L6_2 = L3_2
  L7_2 = true
  L5_2(L6_2, L7_2)
  L5_2 = util
  L5_2 = L5_2.yield
  L6_2 = 5000
  L5_2(L6_2)
  L5_2 = "scr_indep_fireworks"
  L6_2 = "scr_indep_firework_fountain"
  L7_2 = request_ptfx_asset
  L8_2 = L5_2
  L7_2(L8_2)
  L7_2 = 1
  L8_2 = 20
  L9_2 = 1
  for L10_2 = L7_2, L8_2, L9_2 do
    L11_2 = math
    L11_2 = L11_2.ceil
    L12_2 = L10_2 / 5
    L11_2 = L11_2(L12_2)
    L11_2 = L11_2 / 100
    L12_2 = GRAPHICS
    L12_2 = L12_2.USE_PARTICLE_FX_ASSET
    L13_2 = L5_2
    L12_2(L13_2)
    L12_2 = GRAPHICS
    L13_2 = "START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY"
    L12_2 = L12_2[L13_2]
    L13_2 = L6_2
    L14_2 = L3_2
    L15_2 = 0
    L16_2 = 0
    L17_2 = 0.2
    L18_2 = 0
    L19_2 = 180
    L20_2 = 0
    L21_2 = L11_2
    L22_2 = true
    L23_2 = true
    L24_2 = true
    L12_2(L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
    L12_2 = GRAPHICS
    L12_2 = L12_2.SET_PARTICLE_FX_NON_LOOPED_COLOUR
    L13_2 = 0.8862745098039215
    L14_2 = 0.06666666666666667
    L15_2 = 0.047058823529411764
    L12_2(L13_2, L14_2, L15_2)
    L12_2 = util
    L12_2 = L12_2.yield
    L13_2 = 100
    L12_2(L13_2)
  end
  L7_2 = os
  L7_2 = L7_2.time
  L7_2 = L7_2()
  L7_2 = L7_2 + 10
  while true do
    L8_2 = os
    L8_2 = L8_2.time
    L8_2 = L8_2()
    if not (L7_2 >= L8_2) then
      break
    end
    L8_2 = GRAPHICS
    L8_2 = L8_2.USE_PARTICLE_FX_ASSET
    L9_2 = L5_2
    L8_2(L9_2)
    L8_2 = GRAPHICS
    L9_2 = "START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY"
    L8_2 = L8_2[L9_2]
    L9_2 = L6_2
    L10_2 = L3_2
    L11_2 = 0
    L12_2 = 0
    L13_2 = 0.2
    L14_2 = 0
    L15_2 = 180
    L16_2 = 0
    L17_2 = 0.08
    L18_2 = true
    L19_2 = true
    L20_2 = true
    L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
    L8_2 = GRAPHICS
    L9_2 = "START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY"
    L8_2 = L8_2[L9_2]
    L9_2 = L6_2
    L10_2 = L3_2
    L11_2 = 0
    L12_2 = 0
    L13_2 = 0.2
    L14_2 = 0
    L15_2 = 180
    L16_2 = 0
    L17_2 = 0.08
    L18_2 = true
    L19_2 = true
    L20_2 = true
    L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
    L8_2 = GRAPHICS
    L8_2 = L8_2.SET_PARTICLE_FX_NON_LOOPED_COLOUR
    L9_2 = math
    L9_2 = L9_2.random
    L10_2 = 0
    L11_2 = 255
    L9_2 = L9_2(L10_2, L11_2)
    L9_2 = L9_2 / 255
    L10_2 = math
    L10_2 = L10_2.random
    L11_2 = 0
    L12_2 = 255
    L10_2 = L10_2(L11_2, L12_2)
    L10_2 = L10_2 / 255
    L11_2 = math
    L11_2 = L11_2.random
    L12_2 = 0
    L13_2 = 255
    L11_2 = L11_2(L12_2, L13_2)
    L11_2 = L11_2 / 255
    L8_2(L9_2, L10_2, L11_2)
    L8_2 = util
    L8_2 = L8_2.yield
    L9_2 = 100
    L8_2(L9_2)
  end
  L8_2 = util
  L8_2 = L8_2.yield
  L9_2 = 8000
  L8_2(L9_2)
  L8_2 = delete_entity
  L9_2 = L3_2
  L8_2(L9_2)
end
L56_1[L57_1] = L58_1
L56_1 = {}
L57_1 = _ENV
L58_1 = "anfangyanhua"
function L59_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L0_2 = "anim@mp_fireworks"
  L1_2 = "place_firework_3_box"
  L2_2 = request_anim_dict
  L3_2 = L0_2
  L2_2(L3_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2 = L3_2()
  L4_2 = 0.0
  L5_2 = 0.52
  L6_2 = 0.0
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2 = L3_2()
  L4_2 = ENTITY
  L4_2 = L4_2.FREEZE_ENTITY_POSITION
  L5_2 = L3_2
  L6_2 = true
  L4_2(L5_2, L6_2)
  L4_2 = TASK
  L4_2 = L4_2.TASK_PLAY_ANIM
  L5_2 = L3_2
  L6_2 = L0_2
  L7_2 = L1_2
  L8_2 = -1
  L9_2 = -8.0
  L10_2 = 3000
  L11_2 = 0
  L12_2 = 0
  L13_2 = false
  L14_2 = false
  L15_2 = false
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  L4_2 = util
  L4_2 = L4_2.yield
  L5_2 = 1500
  L4_2(L5_2)
  L4_2 = entities
  L4_2 = L4_2.create_object
  L5_2 = util
  L5_2 = L5_2.joaat
  L6_2 = "ind_prop_firework_03"
  L5_2 = L5_2(L6_2)
  L6_2 = L2_2
  L7_2 = true
  L8_2 = false
  L9_2 = false
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L5_2 = ENTITY
  L5_2 = L5_2.GET_ENTITY_COORDS
  L6_2 = L4_2
  L5_2 = L5_2(L6_2)
  L6_2 = OBJECT
  L6_2 = L6_2.PLACE_OBJECT_ON_GROUND_PROPERLY
  L7_2 = L4_2
  L6_2(L7_2)
  L6_2 = ENTITY
  L6_2 = L6_2.FREEZE_ENTITY_POSITION
  L7_2 = L3_2
  L8_2 = false
  L6_2(L7_2, L8_2)
  L6_2 = util
  L6_2 = L6_2.yield
  L7_2 = 1000
  L6_2(L7_2)
  L6_2 = ENTITY
  L6_2 = L6_2.FREEZE_ENTITY_POSITION
  L7_2 = L4_2
  L8_2 = true
  L6_2(L7_2, L8_2)
  L6_2 = L56_1
  L6_2 = #L6_2
  L7_2 = L6_2 + 1
  L6_2 = L56_1
  L6_2[L7_2] = L4_2
end
L57_1[L58_1] = L59_1
L57_1 = _ENV
L58_1 = "yanhuafashe"
function L59_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2
  L0_2 = L56_1
  L0_2 = #L0_2
  if 0 == L0_2 then
    L0_2 = util
    L0_2 = L0_2.toast
    L1_2 = "请先安放烟花!"
    L0_2(L1_2)
    return
  end
  L0_2 = "scr_indep_fireworks"
  L1_2 = "scr_indep_firework_trailburst"
  L2_2 = request_ptfx_asset
  L3_2 = L0_2
  L2_2(L3_2)
  L2_2 = util
  L2_2 = L2_2.toast
  L3_2 = "烟花发射wow"
  L2_2(L3_2)
  L2_2 = 1
  L3_2 = 50
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = pairs
    L7_2 = L56_1
    L6_2, L7_2, L8_2, L9_2 = L6_2(L7_2)
    for L10_2, L11_2 in L6_2, L7_2, L8_2, L9_2 do
      L12_2 = GRAPHICS
      L12_2 = L12_2.USE_PARTICLE_FX_ASSET
      L13_2 = L0_2
      L12_2(L13_2)
      L12_2 = GRAPHICS
      L13_2 = "START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY"
      L12_2 = L12_2[L13_2]
      L13_2 = L1_2
      L14_2 = L11_2
      L15_2 = 0
      L16_2 = 0
      L17_2 = 0
      L18_2 = 0
      L19_2 = 180
      L20_2 = 0
      L21_2 = 1
      L22_2 = true
      L23_2 = true
      L24_2 = true
      L12_2(L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
      L12_2 = GRAPHICS
      L12_2 = L12_2.SET_PARTICLE_FX_NON_LOOPED_COLOUR
      L13_2 = math
      L13_2 = L13_2.random
      L14_2 = 0
      L15_2 = 255
      L13_2 = L13_2(L14_2, L15_2)
      L13_2 = L13_2 / 255
      L14_2 = math
      L14_2 = L14_2.random
      L15_2 = 0
      L16_2 = 255
      L14_2 = L14_2(L15_2, L16_2)
      L14_2 = L14_2 / 255
      L15_2 = math
      L15_2 = L15_2.random
      L16_2 = 0
      L17_2 = 255
      L15_2 = L15_2(L16_2, L17_2)
      L15_2 = L15_2 / 255
      L12_2(L13_2, L14_2, L15_2)
      L12_2 = util
      L12_2 = L12_2.yield
      L13_2 = 100
      L12_2(L13_2)
    end
  end
  L2_2 = pairs
  L3_2 = L56_1
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = delete_entity
    L9_2 = L7_2
    L8_2(L9_2)
  end
  L2_2 = {}
  L56_1 = L2_2
end
L57_1[L58_1] = L59_1
L57_1 = _ENV
L58_1 = "nvwushen"
function L59_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2
  gUsingValkRocket = A0_2
  L1_2 = gUsingValkRocket
  if L1_2 then
    L1_2 = 0
    L2_2 = 0
    L3_2 = 0
    L4_2 = false
    function L5_2(A0_3, A1_3, A2_3, A3_3)
      local L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3
      L4_3 = GRAPHICS
      L4_3 = L4_3.DRAW_RECT
      L5_3 = A0_3
      L6_3 = A1_3
      L7_3 = A2_3
      L8_3 = A3_3
      L9_3 = 255
      L10_3 = 255
      L11_3 = 255
      L12_3 = 255
      L13_3 = false
      L4_3(L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3)
    end
    while true do
      L6_2 = gUsingValkRocket
      if not L6_2 then
        break
      end
      L6_2 = util
      L6_2 = L6_2.yield_once
      L6_2()
      L6_2 = PED
      L6_2 = L6_2.IS_PED_SHOOTING
      L7_2 = PLAYER
      L7_2 = L7_2.PLAYER_PED_ID
      L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2 = L7_2()
      L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
      if L6_2 and not L4_2 then
        L4_2 = true
        L6_2 = timer
        L6_2 = L6_2.reset
        L6_2()
      elseif L4_2 then
        L6_2 = ENTITY
        L6_2 = L6_2.DOES_ENTITY_EXIST
        L7_2 = L1_2
        L6_2 = L6_2(L7_2)
        if not L6_2 then
          L6_2 = get_offset_from_cam
          L7_2 = 10
          L6_2 = L6_2(L7_2)
          L7_2 = entities
          L7_2 = L7_2.create_object
          L8_2 = util
          L8_2 = L8_2.joaat
          L9_2 = "w_lr_rpg_rocket"
          L8_2 = L8_2(L9_2)
          L9_2 = L6_2
          L7_2 = L7_2(L8_2, L9_2)
          L1_2 = L7_2
          L7_2 = ENTITY
          L7_2 = L7_2.SET_ENTITY_INVINCIBLE
          L8_2 = L1_2
          L9_2 = true
          L7_2(L8_2, L9_2)
          L7_2 = ENTITY
          L7_2 = L7_2.SET_ENTITY_LOAD_COLLISION_FLAG
          L8_2 = L1_2
          L9_2 = true
          L10_2 = 1
          L7_2(L8_2, L9_2, L10_2)
          L7_2 = NETWORK
          L7_2 = L7_2.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES
          L8_2 = NETWORK
          L8_2 = L8_2.OBJ_TO_NET
          L9_2 = L1_2
          L8_2 = L8_2(L9_2)
          L9_2 = true
          L7_2(L8_2, L9_2)
          L7_2 = NETWORK
          L7_2 = L7_2.SET_NETWORK_ID_CAN_MIGRATE
          L8_2 = NETWORK
          L8_2 = L8_2.OBJ_TO_NET
          L9_2 = L1_2
          L8_2 = L8_2(L9_2)
          L9_2 = false
          L7_2(L8_2, L9_2)
          L7_2 = ENTITY
          L7_2 = L7_2.SET_ENTITY_RECORDS_COLLISIONS
          L8_2 = L1_2
          L9_2 = true
          L7_2(L8_2, L9_2)
          L7_2 = ENTITY
          L7_2 = L7_2.SET_ENTITY_HAS_GRAVITY
          L8_2 = L1_2
          L9_2 = false
          L7_2(L8_2, L9_2)
          L7_2 = CAM
          L7_2 = L7_2.DESTROY_ALL_CAMS
          L8_2 = true
          L7_2(L8_2)
          L7_2 = CAM
          L7_2 = L7_2.CREATE_CAM
          L8_2 = "DEFAULT_SCRIPTED_CAMERA"
          L9_2 = true
          L7_2 = L7_2(L8_2, L9_2)
          L2_2 = L7_2
          L7_2 = CAM
          L7_2 = L7_2.SET_CAM_NEAR_CLIP
          L8_2 = L2_2
          L9_2 = 0.01
          L7_2(L8_2, L9_2)
          L7_2 = CAM
          L7_2 = L7_2.SET_CAM_NEAR_DOF
          L8_2 = L2_2
          L9_2 = 0.01
          L7_2(L8_2, L9_2)
          L7_2 = GRAPHICS
          L7_2 = L7_2.CLEAR_TIMECYCLE_MODIFIER
          L7_2()
          L7_2 = GRAPHICS
          L7_2 = L7_2.SET_TIMECYCLE_MODIFIER
          L8_2 = "CAMERA_secuirity"
          L7_2(L8_2)
          L7_2 = CAM1
          L7_2 = L7_2.HARD_ATTACH_CAM_TO_ENTITY
          L8_2 = L2_2
          L9_2 = L1_2
          L10_2 = 0.0
          L11_2 = 0.0
          L12_2 = 0.0
          L13_2 = 0.0
          L14_2 = 0.0
          L15_2 = 0.0
          L16_2 = true
          L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
          L7_2 = CAM
          L7_2 = L7_2.SET_CAM_ACTIVE
          L8_2 = L2_2
          L9_2 = true
          L7_2(L8_2, L9_2)
          L7_2 = CAM
          L7_2 = L7_2.RENDER_SCRIPT_CAMS
          L8_2 = true
          L9_2 = false
          L10_2 = 0
          L11_2 = true
          L12_2 = true
          L13_2 = 0
          L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
          L7_2 = PLAYER
          L7_2 = L7_2.DISABLE_PLAYER_FIRING
          L8_2 = PLAYER
          L8_2 = L8_2.PLAYER_PED_ID
          L8_2 = L8_2()
          L9_2 = true
          L7_2(L8_2, L9_2)
          L7_2 = ENTITY
          L7_2 = L7_2.FREEZE_ENTITY_POSITION
          L8_2 = PLAYER
          L8_2 = L8_2.PLAYER_PED_ID
          L8_2 = L8_2()
          L9_2 = true
          L7_2(L8_2, L9_2)
        else
          L6_2 = CAM
          L6_2 = L6_2.GET_GAMEPLAY_CAM_ROT
          L7_2 = 0
          L6_2 = L6_2(L7_2)
          L7_2 = ENTITY
          L7_2 = L7_2.GET_ENTITY_COORDS
          L8_2 = L1_2
          L9_2 = false
          L7_2 = L7_2(L8_2, L9_2)
          L9_2 = L6_2
          L8_2 = L6_2.toDir
          L8_2 = L8_2(L9_2)
          L10_2 = L8_2
          L9_2 = L8_2.mul
          L11_2 = 40.0
          L9_2(L10_2, L11_2)
          L9_2 = ENTITY
          L9_2 = L9_2.SET_ENTITY_ROTATION
          L10_2 = L1_2
          L11_2 = L6_2.x
          L12_2 = L6_2.y
          L13_2 = L6_2.z
          L14_2 = 0
          L15_2 = true
          L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
          L9_2 = STREAMING
          L9_2 = L9_2.SET_FOCUS_POS_AND_VEL
          L10_2 = L7_2.x
          L11_2 = L7_2.y
          L12_2 = L7_2.z
          L13_2 = L6_2.x
          L14_2 = L6_2.y
          L15_2 = L6_2.z
          L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
          L9_2 = ENTITY
          L9_2 = L9_2.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
          L10_2 = L1_2
          L11_2 = 1
          L12_2 = L8_2.x
          L13_2 = L8_2.y
          L14_2 = L8_2.z
          L15_2 = false
          L16_2 = false
          L17_2 = false
          L18_2 = false
          L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
          L9_2 = HUD
          L9_2 = L9_2.HIDE_HUD_AND_RADAR_THIS_FRAME
          L9_2()
          L9_2 = PLAYER
          L9_2 = L9_2.DISABLE_PLAYER_FIRING
          L10_2 = PLAYER
          L10_2 = L10_2.PLAYER_PED_ID
          L10_2 = L10_2()
          L11_2 = true
          L9_2(L10_2, L11_2)
          L9_2 = ENTITY
          L9_2 = L9_2.FREEZE_ENTITY_POSITION
          L10_2 = PLAYER
          L10_2 = L10_2.PLAYER_PED_ID
          L10_2 = L10_2()
          L11_2 = true
          L9_2(L10_2, L11_2)
          L9_2 = HUD1
          L10_2 = "HUD_SUPPRESS_WEAPON_WHEEL_RESULTS_THIS_FRAME"
          L9_2 = L9_2[L10_2]
          L9_2()
          L9_2 = L5_2
          L10_2 = 0.5
          L11_2 = 0.475
          L12_2 = 0.05
          L13_2 = 0.002
          L9_2(L10_2, L11_2, L12_2, L13_2)
          L9_2 = L5_2
          L10_2 = 0.5
          L11_2 = 0.525
          L12_2 = 0.05
          L13_2 = 0.002
          L9_2(L10_2, L11_2, L12_2, L13_2)
          L9_2 = L5_2
          L10_2 = 0.475
          L11_2 = 0.5
          L12_2 = 0.002
          L13_2 = 0.052
          L9_2(L10_2, L11_2, L12_2, L13_2)
          L9_2 = L5_2
          L10_2 = 0.525
          L11_2 = 0.5
          L12_2 = 0.002
          L13_2 = 0.052
          L9_2(L10_2, L11_2, L12_2, L13_2)
          L9_2 = L5_2
          L10_2 = 0.55
          L11_2 = 0.5
          L12_2 = 0.05
          L13_2 = 0.002
          L9_2(L10_2, L11_2, L12_2, L13_2)
          L9_2 = L5_2
          L10_2 = 0.45
          L11_2 = 0.5
          L12_2 = 0.05
          L13_2 = 0.002
          L9_2(L10_2, L11_2, L12_2, L13_2)
          L9_2 = L5_2
          L10_2 = 0.5
          L11_2 = 0.55
          L12_2 = 0.002
          L13_2 = 0.05
          L9_2(L10_2, L11_2, L12_2, L13_2)
          L9_2 = L5_2
          L10_2 = 0.5
          L11_2 = 0.45
          L12_2 = 0.002
          L13_2 = 0.05
          L9_2(L10_2, L11_2, L12_2, L13_2)
          L9_2 = 7000
          L10_2 = timer
          L10_2 = L10_2.elapsed
          L10_2 = L10_2()
          L10_2 = L10_2 / L9_2
          L10_2 = 0.5 * L10_2
          L11_2 = 0.5
          L10_2 = L11_2 - L10_2
          L11_2 = L10_2 / 0.5
          L12_2 = get_blended_colour
          L13_2 = L11_2
          L12_2 = L12_2(L13_2)
          L13_2 = GRAPHICS
          L13_2 = L13_2.DRAW_RECT
          L14_2 = 0.25
          L15_2 = 0.5
          L16_2 = 0.03
          L17_2 = 0.5
          L18_2 = 255
          L19_2 = 255
          L20_2 = 255
          L21_2 = 120
          L22_2 = false
          L13_2(L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
          L13_2 = GRAPHICS
          L13_2 = L13_2.DRAW_RECT
          L14_2 = 0.25
          L15_2 = L10_2 / 2
          L16_2 = 0.75
          L15_2 = L16_2 - L15_2
          L16_2 = 0.03
          L17_2 = L10_2
          L18_2 = L12_2.r
          L19_2 = L12_2.g
          L20_2 = L12_2.b
          L21_2 = L12_2.a
          L22_2 = false
          L13_2(L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
          L13_2 = ENTITY
          L13_2 = L13_2.HAS_ENTITY_COLLIDED_WITH_ANYTHING
          L14_2 = L1_2
          L13_2 = L13_2(L14_2)
          if L13_2 or L10_2 <= 0 then
            L13_2 = ENTITY
            L13_2 = L13_2.GET_ENTITY_COORDS
            L14_2 = L1_2
            L15_2 = false
            L13_2 = L13_2(L14_2, L15_2)
            L14_2 = FIRE
            L14_2 = L14_2.ADD_EXPLOSION
            L15_2 = L13_2.x
            L16_2 = L13_2.y
            L17_2 = L13_2.z
            L18_2 = 32
            L19_2 = 1.0
            L20_2 = true
            L21_2 = false
            L22_2 = 0.4
            L23_2 = false
            L14_2(L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
            L14_2 = delete_entity
            L15_2 = L1_2
            L14_2(L15_2)
            L14_2 = CAM
            L14_2 = L14_2.RENDER_SCRIPT_CAMS
            L15_2 = false
            L16_2 = false
            L17_2 = 0
            L18_2 = true
            L19_2 = false
            L20_2 = 0
            L14_2(L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
            L14_2 = GRAPHICS
            L14_2 = L14_2.SET_TIMECYCLE_MODIFIER
            L15_2 = "DEFAULT"
            L14_2(L15_2)
            L14_2 = STREAMING
            L14_2 = L14_2.CLEAR_FOCUS
            L14_2()
            L14_2 = CAM
            L14_2 = L14_2.DESTROY_CAM
            L15_2 = L2_2
            L16_2 = true
            L14_2(L15_2, L16_2)
            L14_2 = PLAYER
            L14_2 = L14_2.DISABLE_PLAYER_FIRING
            L15_2 = PLAYER
            L15_2 = L15_2.PLAYER_PED_ID
            L15_2 = L15_2()
            L16_2 = false
            L14_2(L15_2, L16_2)
            L14_2 = ENTITY
            L14_2 = L14_2.FREEZE_ENTITY_POSITION
            L15_2 = PLAYER
            L15_2 = L15_2.PLAYER_PED_ID
            L15_2 = L15_2()
            L16_2 = false
            L14_2(L15_2, L16_2)
            L1_2 = 0
            L4_2 = false
          end
        end
      end
    end
    if L1_2 then
      L6_2 = ENTITY
      L6_2 = L6_2.DOES_ENTITY_EXIST
      L7_2 = L1_2
      L6_2 = L6_2(L7_2)
      if L6_2 then
        L6_2 = ENTITY
        L6_2 = L6_2.GET_ENTITY_COORDS
        L7_2 = L1_2
        L8_2 = false
        L6_2 = L6_2(L7_2, L8_2)
        L7_2 = FIRE
        L7_2 = L7_2.ADD_EXPLOSION
        L8_2 = L6_2.x
        L9_2 = L6_2.y
        L10_2 = L6_2.z
        L11_2 = 32
        L12_2 = 1.0
        L13_2 = true
        L14_2 = false
        L15_2 = 0.4
        L16_2 = false
        L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
        L7_2 = delete_entity
        L8_2 = L1_2
        L7_2(L8_2)
        L7_2 = STREAMING
        L7_2 = L7_2.CLEAR_FOCUS
        L7_2()
        L7_2 = CAM
        L7_2 = L7_2.RENDER_SCRIPT_CAMS
        L8_2 = false
        L9_2 = false
        L10_2 = 0
        L11_2 = true
        L12_2 = false
        L13_2 = 0
        L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
        L7_2 = CAM
        L7_2 = L7_2.DESTROY_CAM
        L8_2 = L2_2
        L9_2 = true
        L7_2(L8_2, L9_2)
        L7_2 = GRAPHICS
        L7_2 = L7_2.SET_TIMECYCLE_MODIFIER
        L8_2 = "DEFAULT"
        L7_2(L8_2)
        L7_2 = ENTITY
        L7_2 = L7_2.FREEZE_ENTITY_POSITION
        L8_2 = PLAYER
        L8_2 = L8_2.PLAYER_PED_ID
        L8_2 = L8_2()
        L9_2 = false
        L7_2(L8_2, L9_2)
        L7_2 = PLAYER
        L7_2 = L7_2.DISABLE_PLAYER_FIRING
        L8_2 = PLAYER
        L8_2 = L8_2.PLAYER_PED_ID
        L8_2 = L8_2()
        L9_2 = false
        L7_2(L8_2, L9_2)
        L7_2 = HUD
        L7_2 = L7_2.DOES_BLIP_EXIST
        L8_2 = L3_2
        L7_2 = L7_2(L8_2)
        if L7_2 then
          L7_2 = util
          L7_2 = L7_2.remove_blip
          L8_2 = L3_2
          L7_2(L8_2)
        end
        L7_2 = HUD
        L7_2 = L7_2.UNLOCK_MINIMAP_ANGLE
        L7_2()
        L7_2 = HUD
        L7_2 = L7_2.UNLOCK_MINIMAP_POSITION
        L7_2()
      end
    end
  end
end
L57_1[L58_1] = L59_1
L57_1 = _ENV
L58_1 = "requestweapon"
function L59_1(...)
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L0_2 = {}
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = ...
  L0_2[1] = L1_2
  L0_2[2] = L2_2
  L0_2[3] = L3_2
  L0_2[4] = L4_2
  L0_2[5] = L5_2
  L0_2[6] = L6_2
  L0_2[7] = L7_2
  L0_2[8] = L8_2
  L0_2[9] = L9_2
  L0_2[10] = L10_2
  L1_2 = ipairs
  L2_2 = L0_2
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = WEAPON
    L7_2 = L7_2.REQUEST_WEAPON_ASSET
    L8_2 = L6_2
    L9_2 = 31
    L10_2 = 26
    L7_2(L8_2, L9_2, L10_2)
    while true do
      L7_2 = WEAPON
      L7_2 = L7_2.HAS_WEAPON_ASSET_LOADED
      L8_2 = L6_2
      L7_2 = L7_2(L8_2)
      if L7_2 then
        break
      end
      L7_2 = util
      L7_2 = L7_2.yield
      L7_2()
    end
  end
end
L57_1[L58_1] = L59_1
L57_1 = _ENV
L58_1 = "RGBNeonKit"
function L59_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = PED
  L1_2 = L1_2.GET_VEHICLE_PED_IS_IN
  L2_2 = A0_2
  L3_2 = false
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = 0
  L3_2 = 3
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = VEHICLE
    L6_2 = L6_2.SET_VEHICLE_NEON_ENABLED
    L7_2 = L1_2
    L8_2 = L5_2
    L9_2 = true
    L6_2(L7_2, L8_2, L9_2)
  end
end
L57_1[L58_1] = L59_1
L57_1 = 100
L58_1 = _ENV
L59_1 = "colorspeed"
function L60_1(A0_2)
  local L1_2
  L1_2 = 10000
  L1_2 = L1_2 / A0_2
  L57_1 = L1_2
end
L58_1[L59_1] = L60_1
L58_1 = _ENV
L59_1 = "zjbs"
function L60_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = PED
  L0_2 = L0_2.IS_PED_IN_ANY_VEHICLE
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = true
  L0_2 = L0_2(L1_2, L2_2)
  if 0 ~= L0_2 then
    L0_2 = PED
    L0_2 = L0_2.GET_VEHICLE_PED_IS_IN
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_PED_ID
    L1_2 = L1_2()
    L2_2 = true
    L0_2 = L0_2(L1_2, L2_2)
    L1_2 = RGBNeonKit
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2 = L2_2()
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
    L1_2 = math
    L1_2 = L1_2.random
    L2_2 = 0
    L3_2 = 255
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = math
    L2_2 = L2_2.random
    L3_2 = 0
    L4_2 = 255
    L2_2 = L2_2(L3_2, L4_2)
    L3_2 = math
    L3_2 = L3_2.random
    L4_2 = 0
    L5_2 = 255
    L3_2 = L3_2(L4_2, L5_2)
    L4_2 = VEHICLE
    L4_2 = L4_2.SET_VEHICLE_NEON_COLOUR
    L5_2 = L0_2
    L6_2 = L1_2
    L7_2 = L2_2
    L8_2 = L3_2
    L4_2(L5_2, L6_2, L7_2, L8_2)
    L4_2 = VEHICLE
    L4_2 = L4_2.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR
    L5_2 = L0_2
    L6_2 = L1_2
    L7_2 = L2_2
    L8_2 = L3_2
    L4_2(L5_2, L6_2, L7_2, L8_2)
    L4_2 = VEHICLE
    L4_2 = L4_2.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR
    L5_2 = L0_2
    L6_2 = L1_2
    L7_2 = L2_2
    L8_2 = L3_2
    L4_2(L5_2, L6_2, L7_2, L8_2)
    L4_2 = util
    L4_2 = L4_2.yield
    L5_2 = L57_1
    L4_2(L5_2)
  end
end
L58_1[L59_1] = L60_1
L58_1 = 100
L59_1 = _ENV
L60_1 = "qzdcolorspeed"
function L61_1(A0_2)
  local L1_2
  L1_2 = 10000
  L1_2 = L1_2 / A0_2
  L58_1 = L1_2
end
L59_1[L60_1] = L61_1
L59_1 = _ENV
L60_1 = "qzd"
function L61_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L0_2 = {}
  L1_2 = {}
  L2_2 = 64
  L3_2 = 1
  L1_2[1] = L2_2
  L1_2[2] = L3_2
  L2_2 = {}
  L3_2 = 73
  L4_2 = 2
  L2_2[1] = L3_2
  L2_2[2] = L4_2
  L3_2 = {}
  L4_2 = 51
  L5_2 = 3
  L3_2[1] = L4_2
  L3_2[2] = L5_2
  L4_2 = {}
  L5_2 = 92
  L6_2 = 4
  L4_2[1] = L5_2
  L4_2[2] = L6_2
  L5_2 = {}
  L6_2 = 89
  L7_2 = 5
  L5_2[1] = L6_2
  L5_2[2] = L7_2
  L6_2 = {}
  L7_2 = 88
  L8_2 = 6
  L6_2[1] = L7_2
  L6_2[2] = L8_2
  L7_2 = {}
  L8_2 = 38
  L9_2 = 7
  L7_2[1] = L8_2
  L7_2[2] = L9_2
  L8_2 = {}
  L9_2 = 39
  L10_2 = 8
  L8_2[1] = L9_2
  L8_2[2] = L10_2
  L9_2 = {}
  L10_2 = 137
  L11_2 = 9
  L9_2[1] = L10_2
  L9_2[2] = L11_2
  L10_2 = {}
  L11_2 = 135
  L12_2 = 10
  L10_2[1] = L11_2
  L10_2[2] = L12_2
  L11_2 = {}
  L12_2 = 145
  L13_2 = 11
  L11_2[1] = L12_2
  L11_2[2] = L13_2
  L12_2 = {}
  L13_2 = 142
  L14_2 = 12
  L12_2[1] = L13_2
  L12_2[2] = L14_2
  L0_2[1] = L1_2
  L0_2[2] = L2_2
  L0_2[3] = L3_2
  L0_2[4] = L4_2
  L0_2[5] = L5_2
  L0_2[6] = L6_2
  L0_2[7] = L7_2
  L0_2[8] = L8_2
  L0_2[9] = L9_2
  L0_2[10] = L10_2
  L0_2[11] = L11_2
  L0_2[12] = L12_2
  L1_2 = PED
  L1_2 = L1_2.IS_PED_IN_ANY_VEHICLE
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  if 0 ~= L1_2 then
    L1_2 = PED
    L1_2 = L1_2.GET_VEHICLE_PED_IS_IN
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = true
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = RGBNeonKit
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2 = L3_2()
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    L2_2 = math
    L2_2 = L2_2.random
    L3_2 = 1
    L4_2 = 12
    L2_2 = L2_2(L3_2, L4_2)
    L3_2 = VEHICLE
    L3_2 = L3_2.TOGGLE_VEHICLE_MOD
    L4_2 = L1_2
    L5_2 = 22
    L6_2 = true
    L3_2(L4_2, L5_2, L6_2)
    L3_2 = VEHICLE
    L3_2 = L3_2.SET_VEHICLE_NEON_INDEX_COLOUR
    L4_2 = L1_2
    L5_2 = L0_2[L2_2]
    L5_2 = L5_2[1]
    L3_2(L4_2, L5_2)
    L3_2 = VEHICLE
    L3_2 = L3_2.SET_VEHICLE_COLOURS
    L4_2 = L1_2
    L5_2 = L0_2[L2_2]
    L5_2 = L5_2[1]
    L6_2 = L0_2[L2_2]
    L6_2 = L6_2[1]
    L3_2(L4_2, L5_2, L6_2)
    L3_2 = VEHICLE
    L3_2 = L3_2.SET_VEHICLE_EXTRA_COLOURS
    L4_2 = L1_2
    L5_2 = 0
    L6_2 = L0_2[L2_2]
    L6_2 = L6_2[1]
    L3_2(L4_2, L5_2, L6_2)
    L3_2 = VEHICLE
    L3_2 = L3_2.SET_VEHICLE_EXTRA_COLOUR_5
    L4_2 = L1_2
    L5_2 = L0_2[L2_2]
    L5_2 = L5_2[1]
    L3_2(L4_2, L5_2)
    L3_2 = VEHICLE
    L3_2 = L3_2.SET_VEHICLE_XENON_LIGHT_COLOR_INDEX
    L4_2 = L1_2
    L5_2 = L0_2[L2_2]
    L5_2 = L5_2[2]
    L3_2(L4_2, L5_2)
    L3_2 = util
    L3_2 = L3_2.yield
    L4_2 = L58_1
    L3_2(L4_2)
  end
end
L59_1[L60_1] = L61_1
L59_1 = {}
L60_1 = _ENV
L61_1 = "B11_attack"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_COORDS
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = false
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = {}
  L3_2 = ENTITY
  L3_2 = L3_2.DOES_ENTITY_EXIST
  L4_2 = L59_1
  L4_2 = L4_2[1]
  L3_2 = L3_2(L4_2)
  if L3_2 then
    return
  end
  L3_2 = 1
  L4_2 = 30
  L5_2 = 1
  for L6_2 = L3_2, L4_2, L5_2 do
    L7_2 = L59_1
    L8_2 = create_vehicle
    L9_2 = 1692272545
    L10_2 = L1_2.x
    L11_2 = math
    L11_2 = L11_2.random
    L12_2 = -100
    L13_2 = 100
    L11_2 = L11_2(L12_2, L13_2)
    L10_2 = L10_2 + L11_2
    L11_2 = L1_2.y
    L12_2 = math
    L12_2 = L12_2.random
    L13_2 = -100
    L14_2 = 100
    L12_2 = L12_2(L13_2, L14_2)
    L11_2 = L11_2 + L12_2
    L12_2 = L1_2.z
    L12_2 = L12_2 + 200
    L13_2 = math
    L13_2 = L13_2.random
    L14_2 = 0
    L15_2 = 360
    L13_2, L14_2, L15_2 = L13_2(L14_2, L15_2)
    L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
    L7_2[L6_2] = L8_2
    L7_2 = ENTITY
    L7_2 = L7_2.SET_ENTITY_INVINCIBLE
    L8_2 = L59_1
    L8_2 = L8_2[L6_2]
    L9_2 = true
    L7_2(L8_2, L9_2)
    L7_2 = ENTITY
    L7_2 = L7_2.SET_ENTITY_COLLISION
    L8_2 = L59_1
    L8_2 = L8_2[L6_2]
    L9_2 = false
    L10_2 = true
    L7_2(L8_2, L9_2, L10_2)
    L7_2 = HUD
    L7_2 = L7_2.ADD_BLIP_FOR_ENTITY
    L8_2 = L59_1
    L8_2 = L8_2[L6_2]
    L7_2 = L7_2(L8_2)
    L8_2 = HUD
    L8_2 = L8_2.SET_BLIP_COLOUR
    L9_2 = L7_2
    L10_2 = 1
    L8_2(L9_2, L10_2)
    L8_2 = PED
    L8_2 = L8_2.CREATE_RANDOM_PED_AS_DRIVER
    L9_2 = L59_1
    L9_2 = L9_2[L6_2]
    L10_2 = 1
    L8_2 = L8_2(L9_2, L10_2)
    L2_2[L6_2] = L8_2
    L8_2 = VEHICLE
    L8_2 = L8_2.SET_VEHICLE_ENGINE_ON
    L9_2 = L2_2[L6_2]
    L10_2 = true
    L11_2 = true
    L12_2 = 0
    L8_2(L9_2, L10_2, L11_2, L12_2)
    L8_2 = VEHICLE
    L8_2 = L8_2.SET_VEHICLE_FORWARD_SPEED
    L9_2 = L59_1
    L9_2 = L9_2[L6_2]
    L10_2 = 27.77777777777778
    L8_2(L9_2, L10_2)
    L8_2 = TASK
    L8_2 = L8_2.TASK_COMBAT_PED
    L9_2 = L2_2[L6_2]
    L10_2 = PLAYER
    L10_2 = L10_2.GET_PLAYER_PED
    L11_2 = A0_2
    L10_2 = L10_2(L11_2)
    L11_2 = 0
    L12_2 = 16
    L8_2(L9_2, L10_2, L11_2, L12_2)
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "active_bowling_balls"
L62_1 = 0
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "bomb_shower_tick_handler"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = os
  L1_2 = L1_2.clock
  L1_2 = L1_2()
  L2_2 = active_bowling_balls
  L2_2 = L2_2 + 1
  active_bowling_balls = L2_2
  L2_2 = util
  L2_2 = L2_2.create_tick_handler
  function L3_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3
    L0_3 = ENTITY
    L0_3 = L0_3.HAS_ENTITY_COLLIDED_WITH_ANYTHING
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    if not L0_3 then
      L0_3 = os
      L0_3 = L0_3.clock
      L0_3 = L0_3()
      L1_3 = L1_2
      L0_3 = L0_3 - L1_3
      if not (L0_3 > 10) then
        L0_3 = ENTITY
        L0_3 = L0_3.DOES_ENTITY_EXIST
        L1_3 = A0_2
        L0_3 = L0_3(L1_3)
        if L0_3 then
          goto lbl_55
        end
      end
    end
    L0_3 = ENTITY
    L0_3 = L0_3.DOES_ENTITY_EXIST
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    if L0_3 then
      L0_3 = ENTITY
      L0_3 = L0_3.GET_ENTITY_COORDS
      L1_3 = A0_2
      L0_3 = L0_3(L1_3)
      L1_3 = FIRE
      L1_3 = L1_3.ADD_EXPLOSION
      L2_3 = L0_3.x
      L3_3 = L0_3.y
      L4_3 = L0_3.z
      L5_3 = 17
      L6_3 = 100.0
      L7_3 = true
      L8_3 = false
      L9_3 = 0.0
      L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3)
      L1_3 = delete_entity
      L2_3 = A0_2
      L1_3(L2_3)
    end
    L0_3 = active_bowling_balls
    if L0_3 > 0 then
      L0_3 = active_bowling_balls
      L0_3 = L0_3 - 1
      active_bowling_balls = L0_3
    end
    L0_3 = util
    L0_3 = L0_3.stop_thread
    L0_3()
    ::lbl_55::
  end
  L2_2(L3_2)
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "custom_rgb"
L62_1 = true
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "rgb_thread"
L62_1 = _ENV
L63_1 = "util"
L62_1 = L62_1[L63_1]
L63_1 = "create_thread"
L62_1 = L62_1[L63_1]
function L63_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = 255
  L2_2 = 0
  L3_2 = 0
  L4_2 = {}
  L5_2 = 255
  L6_2 = 0
  L7_2 = 0
  L4_2[1] = L5_2
  L4_2[2] = L6_2
  L4_2[3] = L7_2
  rgb = L4_2
  while true do
    L4_2 = custom_rgb
    if not L4_2 then
      if L1_2 > 0 then
        L4_2 = 255
        if L2_2 < L4_2 and 0 == L3_2 then
          L1_2 = L1_2 - 1
          L2_2 = L2_2 + 1
      end
      else
        if 0 == L1_2 and L2_2 > 0 then
          L4_2 = 255
          if L3_2 < L4_2 then
            L2_2 = L2_2 - 1
            L3_2 = L3_2 + 1
        end
        else
          L4_2 = 255
          if L1_2 < L4_2 and L3_2 > 0 then
            L1_2 = L1_2 + 1
            L3_2 = L3_2 - 1
          end
        end
      end
      L4_2 = rgb
      L4_2[1] = L1_2
      L4_2 = rgb
      L4_2[2] = L2_2
      L4_2 = rgb
      L4_2[3] = L3_2
    else
      L4_2 = {}
      L5_2 = custom_r
      L6_2 = custom_g
      L7_2 = custom_b
      L4_2[1] = L5_2
      L4_2[2] = L6_2
      L4_2[3] = L7_2
      rgb = L4_2
    end
    L4_2 = util
    L4_2 = L4_2.yield
    L4_2()
  end
end
L62_1 = L62_1(L63_1)
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "dispatch_griefer_jesus"
function L62_1(A0_2)
  local L1_2, L2_2
  L1_2 = util
  L1_2 = L1_2.create_thread
  function L2_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3
    L1_3 = util
    L1_3 = L1_3.toast
    L2_3 = "悲伤耶稣派来了!"
    L1_3(L2_3)
    L1_3 = request_model
    L2_3 = -835930287
    L1_3(L2_3)
    L1_3 = PLAYER
    L1_3 = L1_3.GET_PLAYER_PED_SCRIPT_INDEX
    L2_3 = A0_2
    L1_3 = L1_3(L2_3)
    L2_3 = ENTITY
    L2_3 = L2_3.GET_ENTITY_COORDS
    L3_3 = L1_3
    L4_3 = false
    L2_3 = L2_3(L3_3, L4_3)
    coords = L2_3
    L2_3 = coords
    L3_3 = coords
    L3_3 = L3_3.x
    L2_3.x = L3_3
    L2_3 = coords
    L3_3 = coords
    L3_3 = L3_3.y
    L2_3.y = L3_3
    L2_3 = coords
    L3_3 = coords
    L3_3 = L3_3.z
    L2_3.z = L3_3
    L2_3 = entities
    L2_3 = L2_3.create_ped
    L3_3 = 1
    L4_3 = -835930287
    L5_3 = coords
    L6_3 = 90.0
    L2_3 = L2_3(L3_3, L4_3, L5_3, L6_3)
    L3_3 = ENTITY
    L3_3 = L3_3.SET_ENTITY_INVINCIBLE
    L4_3 = L2_3
    L5_3 = true
    L3_3(L4_3, L5_3)
    L3_3 = PED
    L3_3 = L3_3.SET_PED_HEARING_RANGE
    L4_3 = L2_3
    L5_3 = 9999
    L3_3(L4_3, L5_3)
    L3_3 = PED
    L3_3 = L3_3.SET_PED_CONFIG_FLAG
    L4_3 = L2_3
    L5_3 = 281
    L6_3 = true
    L3_3(L4_3, L5_3, L6_3)
    L3_3 = PED
    L3_3 = L3_3.SET_PED_COMBAT_ATTRIBUTES
    L4_3 = L2_3
    L5_3 = 5
    L6_3 = true
    L3_3(L4_3, L5_3, L6_3)
    L3_3 = PED
    L3_3 = L3_3.SET_PED_COMBAT_ATTRIBUTES
    L4_3 = L2_3
    L5_3 = 46
    L6_3 = true
    L3_3(L4_3, L5_3, L6_3)
    L3_3 = PED
    L3_3 = L3_3.SET_PED_CAN_RAGDOLL
    L4_3 = L2_3
    L5_3 = false
    L3_3(L4_3, L5_3)
    L3_3 = WEAPON
    L3_3 = L3_3.GIVE_WEAPON_TO_PED
    L4_3 = L2_3
    L5_3 = util
    L5_3 = L5_3.joaat
    L6_3 = "WEAPON_RAILGUN"
    L5_3 = L5_3(L6_3)
    L6_3 = 9999
    L7_3 = true
    L8_3 = true
    L3_3(L4_3, L5_3, L6_3, L7_3, L8_3)
    L3_3 = TASK
    L3_3 = L3_3.TASK_GO_TO_ENTITY
    L4_3 = L2_3
    L5_3 = L1_3
    L6_3 = -1
    L7_3 = -1
    L8_3 = 100.0
    L9_3 = 0.0
    L10_3 = 0
    L3_3(L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3)
    L3_3 = TASK
    L3_3 = L3_3.TASK_COMBAT_PED
    L4_3 = L2_3
    L5_3 = L1_3
    L6_3 = 0
    L7_3 = 16
    L3_3(L4_3, L5_3, L6_3, L7_3)
    L3_3 = PED
    L3_3 = L3_3.SET_PED_ACCURACY
    L4_3 = L2_3
    L5_3 = 100.0
    L3_3(L4_3, L5_3)
    L3_3 = PED
    L3_3 = L3_3.SET_PED_COMBAT_ABILITY
    L4_3 = L2_3
    L5_3 = 2
    L3_3(L4_3, L5_3)
    while true do
      L3_3 = ENTITY
      L3_3 = L3_3.GET_ENTITY_COORDS
      L4_3 = L1_3
      L5_3 = false
      L3_3 = L3_3(L4_3, L5_3)
      L4_3 = ENTITY
      L4_3 = L4_3.GET_ENTITY_COORDS
      L5_3 = L2_3
      L6_3 = false
      L4_3 = L4_3(L5_3, L6_3)
      L5_3 = MISC
      L5_3 = L5_3.GET_DISTANCE_BETWEEN_COORDS
      L6_3 = L3_3.x
      L7_3 = L3_3.y
      L8_3 = L3_3.z
      L9_3 = L4_3.x
      L10_3 = L4_3.y
      L11_3 = L4_3.z
      L12_3 = false
      L5_3 = L5_3(L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3)
      if L5_3 > 100 then
        L6_3 = ENTITY
        L6_3 = L6_3.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
        L7_3 = L1_3
        L8_3 = -3.0
        L9_3 = 0.0
        L10_3 = 0.0
        L6_3 = L6_3(L7_3, L8_3, L9_3, L10_3)
        L7_3 = ENTITY
        L7_3 = L7_3.SET_ENTITY_COORDS
        L8_3 = L2_3
        L9_3 = L6_3.x
        L10_3 = L6_3.y
        L11_3 = L6_3.z
        L12_3 = false
        L13_3 = false
        L14_3 = false
        L15_3 = false
        L7_3(L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3)
      end
      L6_3 = ENTITY
      L6_3 = L6_3.DOES_ENTITY_EXIST
      L7_3 = L2_3
      L6_3 = L6_3(L7_3)
      if not L6_3 then
        L6_3 = util
        L6_3 = L6_3.toast
        L7_3 = "耶稣显然不再存在。或许已被玩家清除。"
        L6_3(L7_3)
        L6_3 = util
        L6_3 = L6_3.stop_thread
        L6_3()
      end
      L6_3 = PLAYER
      L6_3 = L6_3.GET_PLAYER_PED_SCRIPT_INDEX
      L7_3 = A0_2
      L6_3 = L6_3(L7_3)
      L7_3 = players
      L7_3 = L7_3.exists
      L8_3 = A0_2
      L7_3 = L7_3(L8_3)
      if not L7_3 then
        L7_3 = util
        L7_3 = L7_3.toast
        L8_3 = "玩家目标已丢失。悲伤的耶稣线正在停止"
        L7_3(L8_3)
        L7_3 = util
        L7_3 = L7_3.stop_thread
        L7_3()
      else
        L7_3 = TASK
        L7_3 = L7_3.TASK_COMBAT_PED
        L8_3 = L2_3
        L9_3 = L6_3
        L10_3 = 0
        L11_3 = 16
        L7_3(L8_3, L9_3, L10_3, L11_3)
      end
      L7_3 = util
      L7_3 = L7_3.yield
      L7_3()
    end
  end
  L1_2 = L1_2(L2_2)
  griefer_jesus = L1_2
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "send_attacker"
function L62_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
  L3_2 = A1_2
  L2_2 = L2_2(L3_2)
  L3_2 = ENTITY
  L3_2 = L3_2.GET_ENTITY_COORDS
  L4_2 = L2_2
  L5_2 = false
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = create_ped
  L5_2 = 28
  L6_2 = A0_2
  L7_2 = L3_2.x
  L8_2 = L3_2.y
  L9_2 = L3_2.z
  L10_2 = math
  L10_2 = L10_2.random
  L11_2 = 0
  L12_2 = 270
  L10_2, L11_2, L12_2 = L10_2(L11_2, L12_2)
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_INVINCIBLE
  L6_2 = L4_2
  L7_2 = true
  L5_2(L6_2, L7_2)
  L5_2 = TASK
  L5_2 = L5_2.TASK_COMBAT_PED
  L6_2 = L4_2
  L7_2 = L2_2
  L8_2 = 0
  L9_2 = 16
  L5_2(L6_2, L7_2, L8_2, L9_2)
  L5_2 = PED
  L5_2 = L5_2.SET_PED_ACCURACY
  L6_2 = L4_2
  L7_2 = 100.0
  L5_2(L6_2, L7_2)
  L5_2 = PED
  L5_2 = L5_2.SET_PED_COMBAT_ABILITY
  L6_2 = L4_2
  L7_2 = 2
  L5_2(L6_2, L7_2)
  L5_2 = PED
  L5_2 = L5_2.SET_PED_AS_ENEMY
  L6_2 = L4_2
  L7_2 = true
  L5_2(L6_2, L7_2)
  L5_2 = PED
  L5_2 = L5_2.SET_PED_FLEE_ATTRIBUTES
  L6_2 = L4_2
  L7_2 = 0
  L8_2 = false
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = PED
  L5_2 = L5_2.SET_PED_COMBAT_ATTRIBUTES
  L6_2 = L4_2
  L7_2 = 46
  L8_2 = true
  L5_2(L6_2, L7_2, L8_2)
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "send_aircraft_attacker"
function L62_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2
  L3_2 = PLAYER
  L3_2 = L3_2.GET_PLAYER_PED_SCRIPT_INDEX
  L4_2 = A2_2
  L3_2 = L3_2(L4_2)
  L4_2 = ENTITY
  L4_2 = L4_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L5_2 = L3_2
  L6_2 = 1.0
  L7_2 = 0.0
  L8_2 = 500.0
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  L5_2 = request_model
  L6_2 = A0_2
  L5_2(L6_2)
  L5_2 = request_model
  L6_2 = A1_2
  L5_2(L6_2)
  L5_2 = L4_2.x
  L5_2 = L5_2 + 2
  L4_2.x = L5_2
  L5_2 = L4_2.y
  L5_2 = L5_2 + 2
  L4_2.y = L5_2
  L5_2 = entities
  L5_2 = L5_2.create_vehicle
  L6_2 = A0_2
  L7_2 = L4_2
  L8_2 = 0.0
  L5_2 = L5_2(L6_2, L7_2, L8_2)
  L6_2 = VEHICLE
  L6_2 = L6_2.CONTROL_LANDING_GEAR
  L7_2 = L5_2
  L8_2 = 3
  L6_2(L7_2, L8_2)
  L6_2 = VEHICLE
  L6_2 = L6_2.SET_HELI_BLADES_FULL_SPEED
  L7_2 = L5_2
  L6_2(L7_2)
  L6_2 = VEHICLE
  L6_2 = L6_2.SET_VEHICLE_FORWARD_SPEED
  L7_2 = L5_2
  L8_2 = VEHICLE
  L8_2 = L8_2.GET_VEHICLE_ESTIMATED_MAX_SPEED
  L9_2 = L5_2
  L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2 = L8_2(L9_2)
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
  L6_2 = ENTITY
  L6_2 = L6_2.SET_ENTITY_INVINCIBLE
  L7_2 = L5_2
  L8_2 = true
  L6_2(L7_2, L8_2)
  L6_2 = -1
  L7_2 = VEHICLE
  L7_2 = L7_2.GET_VEHICLE_MODEL_NUMBER_OF_SEATS
  L8_2 = A0_2
  L7_2 = L7_2(L8_2)
  L7_2 = L7_2 - 2
  L8_2 = 1
  for L9_2 = L6_2, L7_2, L8_2 do
    L10_2 = entities
    L10_2 = L10_2.create_ped
    L11_2 = 28
    L12_2 = A1_2
    L13_2 = L4_2
    L14_2 = 30.0
    L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2)
    L11_2 = TASK
    L11_2 = L11_2.TASK_PLANE_MISSION
    L12_2 = L10_2
    L13_2 = L5_2
    L14_2 = 0
    L15_2 = L3_2
    L16_2 = 0
    L17_2 = 0
    L18_2 = 0
    L19_2 = 6
    L20_2 = 0.0
    L21_2 = 0
    L22_2 = 0.0
    L23_2 = 50.0
    L24_2 = 40.0
    L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
    L11_2 = PED
    L11_2 = L11_2.SET_PED_COMBAT_ATTRIBUTES
    L12_2 = L10_2
    L13_2 = 5
    L14_2 = true
    L11_2(L12_2, L13_2, L14_2)
    L11_2 = PED
    L11_2 = L11_2.SET_PED_COMBAT_ATTRIBUTES
    L12_2 = L10_2
    L13_2 = 46
    L14_2 = true
    L11_2(L12_2, L13_2, L14_2)
    L11_2 = PED
    L11_2 = L11_2.SET_PED_INTO_VEHICLE
    L12_2 = L10_2
    L13_2 = L5_2
    L14_2 = L9_2
    L11_2(L12_2, L13_2, L14_2)
    L11_2 = TASK
    L11_2 = L11_2.TASK_COMBAT_PED
    L12_2 = L10_2
    L13_2 = L3_2
    L14_2 = 0
    L15_2 = 16
    L11_2(L12_2, L13_2, L14_2, L15_2)
    L11_2 = PED
    L11_2 = L11_2.SET_PED_ACCURACY
    L12_2 = L10_2
    L13_2 = 100.0
    L11_2(L12_2, L13_2)
    L11_2 = PED
    L11_2 = L11_2.SET_PED_COMBAT_ABILITY
    L12_2 = L10_2
    L13_2 = 2
    L11_2(L12_2, L13_2)
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "spam_entity_on_player"
function L62_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L2_2 = request_model
  L3_2 = A1_2
  L2_2(L3_2)
  L2_2 = 1
  L3_2 = 30
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = ENTITY
    L6_2 = L6_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
    L7_2 = A0_2
    L8_2 = math
    L8_2 = L8_2.random
    L9_2 = -1
    L10_2 = 1
    L8_2 = L8_2(L9_2, L10_2)
    L9_2 = math
    L9_2 = L9_2.random
    L10_2 = -1
    L11_2 = 1
    L9_2 = L9_2(L10_2, L11_2)
    L10_2 = math
    L10_2 = L10_2.random
    L11_2 = -1
    L12_2 = 1
    L10_2, L11_2, L12_2, L13_2 = L10_2(L11_2, L12_2)
    L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
    rand_coords = L6_2
    L6_2 = rand_coords
    L7_2 = rand_coords
    L7_2 = L7_2.x
    L6_2.x = L7_2
    L6_2 = rand_coords
    L7_2 = rand_coords
    L7_2 = L7_2.y
    L6_2.y = L7_2
    L6_2 = rand_coords
    L7_2 = rand_coords
    L7_2 = L7_2.z
    L6_2.z = L7_2
    L6_2 = OBJECT
    L6_2 = L6_2.CREATE_OBJECT_NO_OFFSET
    L7_2 = A1_2
    L8_2 = rand_coords
    L8_2 = L8_2.x
    L9_2 = rand_coords
    L9_2 = L9_2.y
    L10_2 = rand_coords
    L10_2 = L10_2.z
    L11_2 = true
    L12_2 = false
    L13_2 = false
    L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
    obj = L6_2
    grav_factor = 1.0
    L6_2 = ENTITY
    L6_2 = L6_2.SET_ENTITY_HAS_GRAVITY
    L7_2 = obj
    L8_2 = true
    L6_2(L7_2, L8_2)
    L6_2 = OBJECT
    L7_2 = "SET_ACTIVATE_OBJECT_PHYSICS_AS_SOON_AS_IT_IS_UNFROZEN"
    L6_2 = L6_2[L7_2]
    L7_2 = obj
    L8_2 = true
    L6_2(L7_2, L8_2)
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "start_angryplanes_thread"
function L62_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L0_2 = {}
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "lazer"
  L1_2 = L1_2(L2_2)
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "jet"
  L2_2 = L2_2(L3_2)
  L3_2 = util
  L3_2 = L3_2.joaat
  L4_2 = "cargoplane"
  L3_2 = L3_2(L4_2)
  L4_2 = util
  L4_2 = L4_2.joaat
  L5_2 = "titan"
  L4_2 = L4_2(L5_2)
  L5_2 = util
  L5_2 = L5_2.joaat
  L6_2 = "luxor"
  L5_2 = L5_2(L6_2)
  L6_2 = util
  L6_2 = L6_2.joaat
  L7_2 = "seabreeze"
  L6_2 = L6_2(L7_2)
  L7_2 = util
  L7_2 = L7_2.joaat
  L8_2 = "vestra"
  L7_2 = L7_2(L8_2)
  L8_2 = util
  L8_2 = L8_2.joaat
  L9_2 = "volatol"
  L8_2 = L8_2(L9_2)
  L9_2 = util
  L9_2 = L9_2.joaat
  L10_2 = "tula"
  L9_2 = L9_2(L10_2)
  L10_2 = util
  L10_2 = L10_2.joaat
  L11_2 = "buzzard"
  L10_2 = L10_2(L11_2)
  L11_2 = util
  L11_2 = L11_2.joaat
  L12_2 = "avenger"
  L11_2, L12_2 = L11_2(L12_2)
  L0_2[1] = L1_2
  L0_2[2] = L2_2
  L0_2[3] = L3_2
  L0_2[4] = L4_2
  L0_2[5] = L5_2
  L0_2[6] = L6_2
  L0_2[7] = L7_2
  L0_2[8] = L8_2
  L0_2[9] = L9_2
  L0_2[10] = L10_2
  L0_2[11] = L11_2
  L0_2[12] = L12_2
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = 200
  L3_2 = ENTITY
  L3_2 = L3_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L4_2 = L1_2
  L5_2 = math
  L5_2 = L5_2.random
  L6_2 = -L2_2
  L7_2 = L2_2
  L5_2 = L5_2(L6_2, L7_2)
  L6_2 = math
  L6_2 = L6_2.random
  L7_2 = -L2_2
  L8_2 = L2_2
  L6_2 = L6_2(L7_2, L8_2)
  L7_2 = math
  L7_2 = L7_2.random
  L8_2 = 600
  L9_2 = 800
  L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L7_2(L8_2, L9_2)
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L4_2 = math
  L4_2 = L4_2.random
  L5_2 = 1
  L6_2 = #L0_2
  L4_2 = L4_2(L5_2, L6_2)
  L4_2 = L0_2[L4_2]
  L5_2 = request_model
  L6_2 = L4_2
  L5_2(L6_2)
  L5_2 = entities
  L5_2 = L5_2.create_vehicle
  L6_2 = L4_2
  L7_2 = L3_2
  L8_2 = math
  L8_2 = L8_2.random
  L9_2 = 0
  L10_2 = 270
  L8_2, L9_2, L10_2, L11_2, L12_2 = L8_2(L9_2, L10_2)
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L6_2 = set_entity_face_entity
  L7_2 = L5_2
  L8_2 = L1_2
  L9_2 = true
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = VEHICLE
  L6_2 = L6_2.SET_VEHICLE_ENGINE_ON
  L7_2 = L5_2
  L8_2 = true
  L9_2 = true
  L10_2 = false
  L6_2(L7_2, L8_2, L9_2, L10_2)
  L6_2 = VEHICLE
  L6_2 = L6_2.SET_HELI_BLADES_FULL_SPEED
  L7_2 = L5_2
  L6_2(L7_2)
  L6_2 = VEHICLE
  L6_2 = L6_2.SET_VEHICLE_FORWARD_SPEED
  L7_2 = L5_2
  L8_2 = VEHICLE
  L8_2 = L8_2.GET_VEHICLE_ESTIMATED_MAX_SPEED
  L9_2 = L5_2
  L8_2 = L8_2(L9_2)
  L8_2 = L8_2 + 1000.0
  L6_2(L7_2, L8_2)
  L6_2 = VEHICLE
  L6_2 = L6_2.SET_VEHICLE_OUT_OF_CONTROL
  L7_2 = L5_2
  L8_2 = true
  L9_2 = true
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = util
  L6_2 = L6_2.yield
  L7_2 = 5000
  L6_2(L7_2)
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "dispatch_mariachi"
function L62_1(A0_2)
  local L1_2, L2_2
  L1_2 = util
  L1_2 = L1_2.create_thread
  function L2_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3
    L0_3 = {}
    L1_3 = nil
    L2_3 = {}
    L3_3 = -1.0
    L4_3 = 0.0
    L5_3 = 1.0
    L2_3[1] = L3_3
    L2_3[2] = L4_3
    L2_3[3] = L5_3
    L3_3 = -927261102
    L4_3 = nil
    L5_3 = request_model
    L6_3 = L3_3
    L5_3(L6_3)
    L5_3 = PLAYER
    L5_3 = L5_3.GET_PLAYER_PED_SCRIPT_INDEX
    L6_3 = A0_2
    L5_3 = L5_3(L6_3)
    L1_3 = L5_3
    L5_3 = 1
    L6_3 = 3
    L7_3 = 1
    for L8_3 = L5_3, L6_3, L7_3 do
      L9_3 = ENTITY
      L9_3 = L9_3.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
      L10_3 = L1_3
      L11_3 = L2_3[L8_3]
      L12_3 = 1.0
      L13_3 = 0.0
      L9_3 = L9_3(L10_3, L11_3, L12_3, L13_3)
      L10_3 = entities
      L10_3 = L10_3.create_ped
      L11_3 = 1
      L12_3 = L3_3
      L13_3 = L9_3
      L14_3 = 0.0
      L10_3 = L10_3(L11_3, L12_3, L13_3, L14_3)
      L11_3 = entities
      L11_3 = L11_3.create_object
      L12_3 = util
      L12_3 = L12_3.joaat
      L13_3 = "prop_flag_mexico"
      L12_3 = L12_3(L13_3)
      L13_3 = L9_3
      L14_3 = 0
      L11_3 = L11_3(L12_3, L13_3, L14_3)
      L12_3 = ENTITY
      L12_3 = L12_3.SET_ENTITY_HEADING
      L13_3 = L10_3
      L14_3 = ENTITY
      L14_3 = L14_3.GET_ENTITY_HEADING
      L15_3 = L1_3
      L14_3 = L14_3(L15_3)
      L14_3 = L14_3 + 180
      L12_3(L13_3, L14_3)
      L12_3 = ENTITY
      L12_3 = L12_3.ATTACH_ENTITY_TO_ENTITY
      L13_3 = L11_3
      L14_3 = L10_3
      L15_3 = 0
      L16_3 = 0.0
      L17_3 = 0.0
      L18_3 = 0.0
      L19_3 = 0.0
      L20_3 = 0.0
      L21_3 = 0.0
      L22_3 = true
      L23_3 = true
      L24_3 = false
      L25_3 = true
      L26_3 = 1
      L27_3 = true
      L28_3 = 0
      L12_3(L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3)
      L12_3 = ENTITY
      L12_3 = L12_3.SET_ENTITY_COMPLETELY_DISABLE_COLLISION
      L13_3 = L10_3
      L14_3 = true
      L15_3 = false
      L12_3(L13_3, L14_3, L15_3)
      L12_3 = TASK
      L12_3 = L12_3.TASK_START_SCENARIO_IN_PLACE
      L13_3 = L10_3
      L14_3 = "WORLD_HUMAN_MUSICIAN"
      L15_3 = 0
      L16_3 = false
      L12_3(L13_3, L14_3, L15_3, L16_3)
      L12_3 = PED
      L12_3 = L12_3.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS
      L13_3 = L10_3
      L14_3 = true
      L12_3(L13_3, L14_3)
      L12_3 = PED
      L12_3 = L12_3.SET_PED_FLEE_ATTRIBUTES
      L13_3 = L10_3
      L14_3 = 0
      L15_3 = false
      L12_3(L13_3, L14_3, L15_3)
      L12_3 = PED
      L12_3 = L12_3.SET_PED_CAN_RAGDOLL
      L13_3 = L10_3
      L14_3 = false
      L12_3(L13_3, L14_3)
      L12_3 = ENTITY
      L12_3 = L12_3.SET_ENTITY_INVINCIBLE
      L13_3 = L10_3
      L14_3 = true
      L12_3(L13_3, L14_3)
      L12_3 = #L0_3
      L12_3 = L12_3 + 1
      L0_3[L12_3] = L10_3
    end
  end
  L1_2 = L1_2(L2_2)
  mariachi_thr = L1_2
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "spawn_object_in_front_of_ped"
function L62_1(A0_2, A1_2, A2_2, A3_2, A4_2, A5_2)
  local L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L6_2 = ENTITY
  L6_2 = L6_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L7_2 = A0_2
  L8_2 = 0.0
  L9_2 = A3_2
  L10_2 = A4_2
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
  coords = L6_2
  L6_2 = request_model
  L7_2 = A1_2
  L6_2(L7_2)
  L6_2 = ENTITY
  L6_2 = L6_2.GET_ENTITY_HEADING
  L7_2 = A0_2
  L6_2 = L6_2(L7_2)
  hdng = L6_2
  L6_2 = OBJECT
  L6_2 = L6_2.CREATE_OBJECT_NO_OFFSET
  L7_2 = A1_2
  L8_2 = coords
  L8_2 = L8_2.x
  L9_2 = coords
  L9_2 = L9_2.y
  L10_2 = coords
  L10_2 = L10_2.z
  L11_2 = true
  L12_2 = false
  L13_2 = false
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  new = L6_2
  L6_2 = ENTITY
  L6_2 = L6_2.SET_ENTITY_HEADING
  L7_2 = new
  L8_2 = hdng
  L8_2 = L8_2 + A2_2
  L6_2(L7_2, L8_2)
  if A5_2 then
    L6_2 = OBJECT
    L6_2 = L6_2.PLACE_OBJECT_ON_GROUND_PROPERLY
    L7_2 = new
    L6_2(L7_2)
  end
  L6_2 = new
  return L6_2
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "disable_fog"
function L62_1(A0_2)
  local L1_2, L2_2
  disablefog = A0_2
  while true do
    L1_2 = disablefog
    if not L1_2 then
      break
    end
    L1_2 = GRAPHICS
    L1_2 = L1_2.SET_TIMECYCLE_MODIFIER
    L2_2 = "int_no_fogalpha"
    L1_2(L2_2)
    L1_2 = util
    L1_2 = L1_2.yield
    L1_2()
  end
  L1_2 = GRAPHICS
  L1_2 = L1_2.SET_TIMECYCLE_MODIFIER
  L2_2 = "jewelry_entrance_INT_fog"
  L1_2(L2_2)
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "peeloop_player"
function L62_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2
  if A1_2 then
    L2_2 = PLAYER
    L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    L3_2 = PED
    L3_2 = L3_2.GET_PED_BONE_INDEX
    L4_2 = L2_2
    L5_2 = 11816
    L3_2 = L3_2(L4_2, L5_2)
    L4_2 = request_ptfx_asset_peeloop
    L5_2 = "core"
    L4_2(L5_2)
    L4_2 = GRAPHICS
    L4_2 = L4_2.USE_PARTICLE_FX_ASSET
    L5_2 = "core"
    L4_2(L5_2)
    L4_2 = GRAPHICS
    L5_2 = "START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE"
    L4_2 = L4_2[L5_2]
    L5_2 = "ent_amb_peeing"
    L6_2 = L2_2
    L7_2 = 0
    L8_2 = 0
    L9_2 = 0
    L10_2 = -90
    L11_2 = 0
    L12_2 = 0
    L13_2 = L3_2
    L14_2 = 2
    L15_2 = false
    L16_2 = false
    L17_2 = false
    L18_2 = 0
    L19_2 = 0
    L20_2 = 0
    L21_2 = 0
    L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
    ptfx_id = L4_2
  else
    L2_2 = GRAPHICS
    L2_2 = L2_2.REMOVE_PARTICLE_FX
    L3_2 = ptfx_id
    L4_2 = true
    L2_2(L3_2, L4_2)
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "get_condensed_player_name"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = "<C>"
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_NAME
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = "</C>"
  L1_2 = L1_2 .. L2_2 .. L3_2
  L2_2 = players
  L2_2 = L2_2.get_boss
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if -1 ~= L2_2 then
    L2_2 = players
    L2_2 = L2_2.get_org_colour
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    L3_2 = get_hud_colour_from_org_colour
    L4_2 = L2_2
    L3_2 = L3_2(L4_2)
    L4_2 = string
    L4_2 = L4_2.format
    L5_2 = "~HC_%d~%s~s~"
    L6_2 = L3_2
    L7_2 = L1_2
    return L4_2(L5_2, L6_2, L7_2)
  end
  return L1_2
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "get_net_obj"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = entities
  L1_2 = L1_2.handle_to_pointer
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = NULL
  if L1_2 ~= L2_2 then
    L2_2 = memory
    L2_2 = L2_2.read_long
    L3_2 = L1_2 + 208
    L2_2 = L2_2(L3_2)
    if L2_2 then
      goto lbl_16
    end
  end
  L2_2 = NULL
  ::lbl_16::
  return L2_2
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "get_entity_owner"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = get_net_obj
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = NULL
  if L1_2 ~= L2_2 then
    L2_2 = memory
    L2_2 = L2_2.read_byte
    L3_2 = L1_2 + 73
    L2_2 = L2_2(L3_2)
    if L2_2 then
      goto lbl_15
    end
  end
  L2_2 = -1
  ::lbl_15::
  return L2_2
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "chickenmode"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = menu
  L1_2 = L1_2.ref_by_path
  L2_2 = "Online>Protections>Events>Raw Network Events>Any Event>Block>Enabled"
  L1_2 = L1_2(L2_2)
  L2_2 = menu
  L2_2 = L2_2.ref_by_path
  L3_2 = "Online>Protections>Events>Raw Network Events>Any Event>Block>Disabled"
  L2_2 = L2_2(L3_2)
  L3_2 = menu
  L3_2 = L3_2.ref_by_path
  L4_2 = "Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Enabled"
  L3_2 = L3_2(L4_2)
  L4_2 = menu
  L4_2 = L4_2.ref_by_path
  L5_2 = "Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Disabled"
  L4_2 = L4_2(L5_2)
  if A0_2 then
    L5_2 = util
    L5_2 = L5_2.toast
    L6_2 = "开启自闭模式"
    L5_2(L6_2)
    L5_2 = menu
    L5_2 = L5_2.trigger_commands
    L6_2 = "desyncall on"
    L5_2(L6_2)
    L5_2 = menu
    L5_2 = L5_2.trigger_command
    L6_2 = L3_2
    L5_2(L6_2)
    L5_2 = menu
    L5_2 = L5_2.trigger_command
    L6_2 = L1_2
    L5_2(L6_2)
    L5_2 = menu
    L5_2 = L5_2.trigger_commands
    L6_2 = "anticrashcamera on"
    L5_2(L6_2)
  else
    L5_2 = util
    L5_2 = L5_2.toast
    L6_2 = "关闭自闭模式"
    L5_2(L6_2)
    L5_2 = menu
    L5_2 = L5_2.trigger_commands
    L6_2 = "desyncall off"
    L5_2(L6_2)
    L5_2 = menu
    L5_2 = L5_2.trigger_command
    L6_2 = L4_2
    L5_2(L6_2)
    L5_2 = menu
    L5_2 = L5_2.trigger_command
    L6_2 = L2_2
    L5_2(L6_2)
    L5_2 = menu
    L5_2 = L5_2.trigger_commands
    L6_2 = "anticrashcamera off"
    L5_2(L6_2)
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "blockcrasheffect"
function L62_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
  L0_2 = ENTITY
  L0_2 = L0_2.GET_ENTITY_COORDS
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = false
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = GRAPHICS
  L1_2 = L1_2.REMOVE_PARTICLE_FX_IN_RANGE
  L2_2 = L0_2.x
  L3_2 = L0_2.y
  L4_2 = L0_2.z
  L5_2 = 400
  L1_2(L2_2, L3_2, L4_2, L5_2)
  L1_2 = GRAPHICS
  L1_2 = L1_2.REMOVE_PARTICLE_FX_FROM_ENTITY
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2, L3_2, L4_2, L5_2 = L2_2()
  L1_2(L2_2, L3_2, L4_2, L5_2)
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "blockfireeffect"
function L62_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
  L0_2 = ENTITY
  L0_2 = L0_2.GET_ENTITY_COORDS
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = false
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = FIRE
  L1_2 = L1_2.STOP_FIRE_IN_RANGE
  L2_2 = L0_2.x
  L3_2 = L0_2.y
  L4_2 = L0_2.z
  L5_2 = 100
  L1_2(L2_2, L3_2, L4_2, L5_2)
  L1_2 = FIRE
  L1_2 = L1_2.STOP_ENTITY_FIRE
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2, L3_2, L4_2, L5_2 = L2_2()
  L1_2(L2_2, L3_2, L4_2, L5_2)
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "sendmugger_npc"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = NETWORK
  L1_2 = L1_2.NETWORK_IS_SCRIPT_ACTIVE
  L2_2 = "am_gang_call"
  L3_2 = 0
  L4_2 = true
  L5_2 = 0
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2)
  if L1_2 then
    L1_2 = util
    L1_2 = L1_2.toast
    L2_2 = "当前劫匪活动还未结束哦"
    L1_2(L2_2)
  else
    L1_2 = Global_Base
    L1_2 = L1_2.gpbd_fm_1
    L2_2 = memory
    L2_2 = L2_2.script_global
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_ID
    L3_2 = L3_2()
    L3_2 = L3_2 * 867
    L3_2 = L3_2 + 1
    L3_2 = L1_2 + L3_2
    L3_2 = L3_2 + 140
    L2_2 = L2_2(L3_2)
    L3_2 = memory
    L3_2 = L3_2.write_int
    L4_2 = L2_2
    L5_2 = SetBit
    L6_2 = memory
    L6_2 = L6_2.read_int
    L7_2 = L2_2
    L6_2 = L6_2(L7_2)
    L7_2 = 0
    L5_2, L6_2, L7_2 = L5_2(L6_2, L7_2)
    L3_2(L4_2, L5_2, L6_2, L7_2)
    L3_2 = write_global
    L3_2 = L3_2.int
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_ID
    L4_2 = L4_2()
    L4_2 = L4_2 * 867
    L4_2 = L4_2 + 1
    L4_2 = L1_2 + L4_2
    L4_2 = L4_2 + 141
    L5_2 = A0_2
    L3_2(L4_2, L5_2)
    L3_2 = util
    L3_2 = L3_2.toast
    L4_2 = "劫匪已出动"
    L3_2(L4_2)
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "block_mugger"
function L62_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = NETWORK
  L0_2 = L0_2.NETWORK_IS_SCRIPT_ACTIVE
  L1_2 = "am_gang_call"
  L2_2 = 0
  L3_2 = true
  L4_2 = 0
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2)
  if L0_2 then
    L0_2 = memory
    L0_2 = L0_2.read_int
    L1_2 = memory
    L1_2 = L1_2.script_local
    L2_2 = "am_gang_call"
    L3_2 = 286
    L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2 = L1_2(L2_2, L3_2)
    L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    L1_2 = memory
    L1_2 = L1_2.read_int
    L2_2 = memory
    L2_2 = L2_2.script_local
    L3_2 = "am_gang_call"
    L4_2 = 287
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2 = L2_2(L3_2, L4_2)
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    L2_2 = memory
    L2_2 = L2_2.read_int
    L3_2 = memory
    L3_2 = L3_2.script_local
    L4_2 = "am_gang_call"
    L5_2 = 73
    L3_2, L4_2, L5_2, L6_2, L7_2 = L3_2(L4_2, L5_2)
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
    L3_2 = NETWORK
    L3_2 = L3_2.NETWORK_DOES_NETWORK_ID_EXIST
    L4_2 = L2_2
    L3_2 = L3_2(L4_2)
    if L3_2 then
      L3_2 = PLAYER
      L3_2 = L3_2.PLAYER_ID
      L3_2 = L3_2()
      if L1_2 == L3_2 then
        L3_2 = NETWORK
        L3_2 = L3_2.NET_TO_PED
        L4_2 = L2_2
        L3_2 = L3_2(L4_2)
        L4_2 = delete_entity
        L5_2 = L3_2
        L4_2(L5_2)
        L4_2 = util
        L4_2 = L4_2.toast
        L5_2 = "劫匪来自: "
        L6_2 = PLAYER
        L6_2 = L6_2.GET_PLAYER_NAME
        L7_2 = L0_2
        L6_2 = L6_2(L7_2)
        L5_2 = L5_2 .. L6_2
        L4_2(L5_2)
      end
    end
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "show_mugger"
function L62_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
  L0_2 = NETWORK
  L0_2 = L0_2.NETWORK_IS_SESSION_ACTIVE
  L0_2 = L0_2()
  if L0_2 then
    L0_2 = NETWORK
    L0_2 = L0_2.NETWORK_IS_SCRIPT_ACTIVE
    L1_2 = "am_gang_call"
    L2_2 = 0
    L3_2 = true
    L4_2 = 0
    L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2)
    if L0_2 then
      L0_2 = memory
      L0_2 = L0_2.read_int
      L1_2 = memory
      L1_2 = L1_2.script_local
      L2_2 = "am_gang_call"
      L3_2 = 73
      L1_2, L2_2, L3_2, L4_2, L5_2 = L1_2(L2_2, L3_2)
      L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2)
      L1_2 = NETWORK
      L1_2 = L1_2.NETWORK_DOES_NETWORK_ID_EXIST
      L2_2 = L0_2
      L1_2 = L1_2(L2_2)
      if L1_2 then
        L1_2 = ENTITY
        L1_2 = L1_2.IS_ENTITY_DEAD
        L2_2 = NETWORK
        L2_2 = L2_2.NET_TO_PED
        L3_2 = L0_2
        L2_2 = L2_2(L3_2)
        L3_2 = false
        L1_2 = L1_2(L2_2, L3_2)
        if not L1_2 then
          L1_2 = NETWORK
          L1_2 = L1_2.NET_TO_PED
          L2_2 = L0_2
          L1_2 = L1_2(L2_2)
          L2_2 = draw_bounding_box
          L3_2 = L1_2
          L4_2 = true
          L5_2 = {}
          L5_2.r = 255
          L5_2.g = 0
          L5_2.b = 0
          L5_2.a = 80
          L2_2(L3_2, L4_2, L5_2)
        end
      end
    end
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "supermanpersonl"
function L62_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L0_2 = memory
  L0_2 = L0_2.alloc_int
  L0_2 = L0_2()
  L1_2 = WEAPON
  L1_2 = L1_2.GET_CURRENT_PED_WEAPON
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = L0_2
  L4_2 = 1
  L1_2(L2_2, L3_2, L4_2)
  L1_2 = memory
  L1_2 = L1_2.read_int
  L2_2 = L0_2
  L1_2 = L1_2(L2_2)
  L2_2 = WEAPON
  L2_2 = L2_2.IS_PED_ARMED
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2 = L3_2()
  L4_2 = 1
  L2_2 = L2_2(L3_2, L4_2)
  if not L2_2 then
    L2_2 = util
    L2_2 = L2_2.joaat
    L3_2 = "weapon_unarmed"
    L2_2 = L2_2(L3_2)
    if L1_2 ~= L2_2 then
      goto lbl_90
    end
  end
  L2_2 = v3
  L2_2 = L2_2.new
  L2_2 = L2_2()
  L3_2 = ENTITY
  L3_2 = L3_2.GET_ENTITY_COORDS
  L4_2 = PLAYER
  L4_2 = L4_2.PLAYER_PED_ID
  L4_2 = L4_2()
  L5_2 = false
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = WEAPON
  L4_2 = L4_2.GET_PED_LAST_WEAPON_IMPACT_COORD
  L5_2 = PLAYER
  L5_2 = L5_2.PLAYER_PED_ID
  L5_2 = L5_2()
  L6_2 = L2_2
  L4_2 = L4_2(L5_2, L6_2)
  if L4_2 then
    L4_2 = set_explosion_proof
    L5_2 = PLAYER
    L5_2 = L5_2.PLAYER_PED_ID
    L5_2 = L5_2()
    L6_2 = true
    L4_2(L5_2, L6_2)
    L4_2 = util
    L4_2 = L4_2.yield_once
    L4_2()
    L4_2 = FIRE
    L4_2 = L4_2.ADD_EXPLOSION
    L5_2 = L3_2.x
    L6_2 = L3_2.y
    L7_2 = L3_2.z
    L7_2 = L7_2 - 1.0
    L8_2 = 29
    L9_2 = 5.0
    L10_2 = false
    L11_2 = true
    L12_2 = 0.3
    L13_2 = true
    L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  else
    L4_2 = FIRE
    L4_2 = L4_2.IS_EXPLOSION_IN_SPHERE
    L5_2 = 29
    L6_2 = L3_2.x
    L7_2 = L3_2.y
    L8_2 = L3_2.z
    L9_2 = 2.0
    L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
    if not L4_2 then
      L4_2 = set_explosion_proof
      L5_2 = PLAYER
      L5_2 = L5_2.PLAYER_PED_ID
      L5_2 = L5_2()
      L6_2 = false
      L4_2(L5_2, L6_2)
    end
  end
  ::lbl_90::
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "mutually_exclusive_weapons"
L62_1 = {}
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "toDirection"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = {}
  L2_2 = math
  L2_2 = L2_2.pi
  L2_2 = L2_2 / 180
  L3_2 = A0_2.x
  L2_2 = L2_2 * L3_2
  L1_2.x = L2_2
  L2_2 = math
  L2_2 = L2_2.pi
  L2_2 = L2_2 / 180
  L3_2 = A0_2.y
  L2_2 = L2_2 * L3_2
  L1_2.y = L2_2
  L2_2 = math
  L2_2 = L2_2.pi
  L2_2 = L2_2 / 180
  L3_2 = A0_2.z
  L2_2 = L2_2 * L3_2
  L1_2.z = L2_2
  L2_2 = {}
  L3_2 = math
  L3_2 = L3_2.sin
  L4_2 = L1_2.z
  L3_2 = L3_2(L4_2)
  L3_2 = -L3_2
  L4_2 = math
  L4_2 = L4_2.abs
  L5_2 = math
  L5_2 = L5_2.cos
  L6_2 = L1_2.x
  L5_2, L6_2 = L5_2(L6_2)
  L4_2 = L4_2(L5_2, L6_2)
  L3_2 = L3_2 * L4_2
  L2_2.x = L3_2
  L3_2 = math
  L3_2 = L3_2.cos
  L4_2 = L1_2.z
  L3_2 = L3_2(L4_2)
  L4_2 = math
  L4_2 = L4_2.abs
  L5_2 = math
  L5_2 = L5_2.cos
  L6_2 = L1_2.x
  L5_2, L6_2 = L5_2(L6_2)
  L4_2 = L4_2(L5_2, L6_2)
  L3_2 = L3_2 * L4_2
  L2_2.y = L3_2
  L3_2 = math
  L3_2 = L3_2.sin
  L4_2 = L1_2.x
  L3_2 = L3_2(L4_2)
  L2_2.z = L3_2
  return L2_2
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "direction"
function L62_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = ENTITY
  L0_2 = L0_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = 0
  L3_2 = 5
  L4_2 = 0
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2)
  L1_2 = raycast_gameplay_cam
  L2_2 = -1
  L3_2 = 1000
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = nil
  L3_2 = L1_2[1]
  if 0 ~= L3_2 then
    L2_2 = L1_2[2]
  else
    L3_2 = get_offset_from_gameplay_camera
    L4_2 = 1000
    L3_2 = L3_2(L4_2)
    L2_2 = L3_2
  end
  L3_2 = L2_2.x
  L4_2 = L0_2.x
  L3_2 = L3_2 - L4_2
  L3_2 = L3_2 * 1000
  L2_2.x = L3_2
  L3_2 = L2_2.y
  L4_2 = L0_2.y
  L3_2 = L3_2 - L4_2
  L3_2 = L3_2 * 1000
  L2_2.y = L3_2
  L3_2 = L2_2.z
  L4_2 = L0_2.z
  L3_2 = L3_2 - L4_2
  L3_2 = L3_2 * 1000
  L2_2.z = L3_2
  L3_2 = L2_2
  L4_2 = L0_2
  return L3_2, L4_2
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "nukegunmode"
function L62_1()
  local L0_2, L1_2, L2_2
  L0_2 = PED
  L0_2 = L0_2.IS_PED_SHOOTING
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2)
  if L0_2 then
    L0_2 = WEAPON
    L0_2 = L0_2.REMOVE_ALL_PROJECTILES_OF_TYPE
    L1_2 = -1312131151
    L2_2 = false
    L0_2(L1_2, L2_2)
    L0_2 = util
    L0_2 = L0_2.create_thread
    function L1_2()
      local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3
      L0_3 = util
      L0_3 = L0_3.joaat
      L1_3 = "w_arena_airmissile_01a"
      L0_3 = L0_3(L1_3)
      L1_3 = request_model
      L2_3 = L0_3
      L1_3(L2_3)
      L1_3 = CAM
      L1_3 = L1_3.GET_FINAL_RENDERED_CAM_ROT
      L2_3 = 2
      L1_3 = L1_3(L2_3)
      L2_3 = direction
      L2_3, L3_3 = L2_3()
      L4_3 = entities
      L4_3 = L4_3.create_object
      L5_3 = L0_3
      L6_3 = L3_3
      L4_3 = L4_3(L5_3, L6_3)
      L5_3 = ENTITY
      L5_3 = L5_3.APPLY_FORCE_TO_ENTITY
      L6_3 = L4_3
      L7_3 = 0
      L8_3 = L2_3.x
      L9_3 = L2_3.y
      L10_3 = L2_3.z
      L11_3 = 0.0
      L12_3 = 0.0
      L13_3 = 0.0
      L14_3 = 0
      L15_3 = true
      L16_3 = false
      L17_3 = true
      L18_3 = false
      L19_3 = true
      L5_3(L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3)
      L5_3 = ENTITY
      L5_3 = L5_3.SET_ENTITY_ROTATION
      L6_3 = L4_3
      L7_3 = L1_3.x
      L8_3 = L1_3.y
      L9_3 = L1_3.z
      L10_3 = 1
      L11_3 = true
      L5_3(L6_3, L7_3, L8_3, L9_3, L10_3, L11_3)
      while true do
        L5_3 = ENTITY
        L5_3 = L5_3.HAS_ENTITY_COLLIDED_WITH_ANYTHING
        L6_3 = L4_3
        L5_3 = L5_3(L6_3)
        if L5_3 then
          break
        end
        L5_3 = util
        L5_3 = L5_3.yield
        L5_3()
      end
      L5_3 = ENTITY
      L5_3 = L5_3.GET_ENTITY_COORDS
      L6_3 = L4_3
      L7_3 = true
      L5_3 = L5_3(L6_3, L7_3)
      L6_3 = delete_entity
      L7_3 = L4_3
      L6_3(L7_3)
      L6_3 = executeNuke
      L7_3 = L5_3
      L6_3(L7_3)
    end
    L0_2(L1_2)
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "get_peds_in_player_range"
function L62_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L2_2 = {}
  L3_2 = PLAYER
  L3_2 = L3_2.GET_PLAYER_PED_SCRIPT_INDEX
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = players
  L4_2 = L4_2.get_position
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  L5_2 = ipairs
  L6_2 = entities
  L6_2 = L6_2.get_all_peds_as_handles
  L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2 = L6_2()
  L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
    if L10_2 ~= L3_2 then
      L11_2 = PED
      L11_2 = L11_2.IS_PED_FATALLY_INJURED
      L12_2 = L10_2
      L11_2 = L11_2(L12_2)
      if not L11_2 then
        L11_2 = ENTITY
        L11_2 = L11_2.GET_ENTITY_COORDS
        L12_2 = L10_2
        L13_2 = true
        L11_2 = L11_2(L12_2, L13_2)
        L13_2 = L4_2
        L12_2 = L4_2.distance
        L14_2 = L11_2
        L12_2 = L12_2(L13_2, L14_2)
        if A1_2 >= L12_2 then
          L12_2 = table
          L12_2 = L12_2.insert
          L13_2 = L2_2
          L14_2 = L10_2
          L12_2(L13_2, L14_2)
        end
      end
    end
  end
  return L2_2
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "zidanleixing"
function L62_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L0_2 = pairs
  L1_2 = weapon_stuff
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = L5_2[1]
    L7_2 = L5_2[2]
    L8_2 = false
    L9_2 = menu
    L9_2 = L9_2.toggle
    L10_2 = weapon_thing
    L11_2 = L6_2
    L12_2 = {}
    L13_2 = ""
    function L14_2(A0_3)
      local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3
      L8_2 = A0_3
      while true do
        L1_3 = L8_2
        if not L1_3 then
          break
        end
        L1_3 = util
        L1_3 = L1_3.joaat
        L2_3 = L7_2
        L1_3 = L1_3(L2_3)
        projectile = L1_3
        while true do
          L2_3 = WEAPON
          L2_3 = L2_3.HAS_WEAPON_ASSET_LOADED
          L3_3 = projectile
          L2_3 = L2_3(L3_3)
          if L2_3 then
            break
          end
          L2_3 = WEAPON
          L2_3 = L2_3.REQUEST_WEAPON_ASSET
          L3_3 = projectile
          L4_3 = 31
          L5_3 = false
          L2_3(L3_3, L4_3, L5_3)
          L2_3 = util
          L2_3 = L2_3.yield
          L3_3 = 10
          L2_3(L3_3)
        end
        L2_3 = v3
        L2_3 = L2_3.new
        L2_3 = L2_3()
        L3_3 = PED
        L3_3 = L3_3.IS_PED_SHOOTING
        L4_3 = PLAYER
        L4_3 = L4_3.PLAYER_PED_ID
        L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3 = L4_3()
        L3_3 = L3_3(L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3)
        if L3_3 then
          L3_3 = WEAPON
          L3_3 = L3_3.GET_PED_LAST_WEAPON_IMPACT_COORD
          L4_3 = PLAYER
          L4_3 = L4_3.PLAYER_PED_ID
          L4_3 = L4_3()
          L5_3 = L2_3
          L3_3 = L3_3(L4_3, L5_3)
          if not L3_3 then
            L3_3 = v3
            L3_3 = L3_3.set
            L4_3 = L2_3
            L5_3 = CAM
            L5_3 = L5_3.GET_FINAL_RENDERED_CAM_ROT
            L6_3 = 2
            L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3 = L5_3(L6_3)
            L3_3(L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3)
            L3_3 = v3
            L3_3 = L3_3.toDir
            L4_3 = L2_3
            L3_3 = L3_3(L4_3)
            L4_3 = v3
            L4_3 = L4_3.set
            L5_3 = L2_3
            L6_3 = v3
            L6_3 = L6_3.get
            L7_3 = L3_3
            L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3 = L6_3(L7_3)
            L4_3(L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3)
            L4_3 = v3
            L4_3 = L4_3.mul
            L5_3 = L2_3
            L6_3 = 1000
            L4_3(L5_3, L6_3)
            L4_3 = v3
            L4_3 = L4_3.set
            L5_3 = L3_3
            L6_3 = CAM
            L6_3 = L6_3.GET_FINAL_RENDERED_CAM_COORD
            L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3 = L6_3()
            L4_3(L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3)
            L4_3 = v3
            L4_3 = L4_3.add
            L5_3 = L2_3
            L6_3 = L3_3
            L4_3(L5_3, L6_3)
          end
          L3_3 = v3
          L3_3 = L3_3.get
          L4_3 = L2_3
          L3_3, L4_3, L5_3 = L3_3(L4_3)
          L6_3 = WEAPON
          L6_3 = L6_3.GET_CURRENT_PED_WEAPON_ENTITY_INDEX
          L7_3 = PLAYER
          L7_3 = L7_3.PLAYER_PED_ID
          L7_3 = L7_3()
          L8_3 = 0
          L6_3 = L6_3(L7_3, L8_3)
          L7_3 = ENTITY1
          L7_3 = L7_3._GET_ENTITY_BONE_POSITION_2
          L8_3 = L6_3
          L9_3 = ENTITY
          L9_3 = L9_3.GET_ENTITY_BONE_INDEX_BY_NAME
          L10_3 = L6_3
          L11_3 = "gun_muzzle"
          L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3 = L9_3(L10_3, L11_3)
          L7_3 = L7_3(L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3)
          L8_3 = MISC
          L8_3 = L8_3.SHOOT_SINGLE_BULLET_BETWEEN_COORDS
          L9_3 = L7_3.x
          L10_3 = L7_3.y
          L11_3 = L7_3.z
          L12_3 = L3_3
          L13_3 = L4_3
          L14_3 = L5_3
          L15_3 = 1
          L16_3 = true
          L17_3 = L1_3
          L18_3 = PLAYER
          L18_3 = L18_3.PLAYER_PED_ID
          L18_3 = L18_3()
          L19_3 = true
          L20_3 = false
          L21_3 = 1000
          L8_3(L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3)
        end
        L3_3 = util
        L3_3 = L3_3.yield
        L3_3()
      end
      L1_3 = ENTITY
      L1_3 = L1_3.GET_ENTITY_COORDS
      L2_3 = PLAYER
      L2_3 = L2_3.PLAYER_PED_ID
      L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3 = L2_3()
      L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3)
      L2_3 = MISC
      L2_3 = L2_3.CLEAR_AREA_OF_PROJECTILES
      L3_3 = L1_3.x
      L4_3 = L1_3.y
      L5_3 = L1_3.z
      L6_3 = 999999
      L7_3 = 0
      L2_3(L3_3, L4_3, L5_3, L6_3, L7_3)
    end
    L9_2(L10_2, L11_2, L12_2, L13_2, L14_2)
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "juqishoulai"
function L62_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L0_2 = PAD
  L0_2 = L0_2.IS_CONTROL_PRESSED
  L1_2 = 1
  L2_2 = 323
  L0_2 = L0_2(L1_2, L2_2)
  if L0_2 then
    L0_2 = request_anim_dict
    L1_2 = "random@mugging3"
    L0_2(L1_2)
    L0_2 = ENTITY
    L0_2 = L0_2.IS_ENTITY_PLAYING_ANIM
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_PED_ID
    L1_2 = L1_2()
    L2_2 = "random@mugging3"
    L3_2 = "handsup_standing_base"
    L4_2 = 3
    L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2)
    if not L0_2 then
      L0_2 = WEAPON
      L0_2 = L0_2.SET_CURRENT_PED_WEAPON
      L1_2 = PLAYER
      L1_2 = L1_2.PLAYER_PED_ID
      L1_2 = L1_2()
      L2_2 = MISC
      L2_2 = L2_2.GET_HASH_KEY
      L3_2 = "WEAPON_UNARMED"
      L2_2 = L2_2(L3_2)
      L3_2 = true
      L0_2(L1_2, L2_2, L3_2)
      L0_2 = TASK
      L0_2 = L0_2.TASK_PLAY_ANIM
      L1_2 = PLAYER
      L1_2 = L1_2.PLAYER_PED_ID
      L1_2 = L1_2()
      L2_2 = "random@mugging3"
      L3_2 = "handsup_standing_base"
      L4_2 = 3
      L5_2 = 3
      L6_2 = -1
      L7_2 = 51
      L8_2 = 0
      L9_2 = false
      L10_2 = false
      L11_2 = false
      L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
      L0_2 = STREAMING
      L0_2 = L0_2.REMOVE_ANIM_DICT
      L1_2 = "random@mugging3"
      L0_2(L1_2)
      L0_2 = PED
      L0_2 = L0_2.SET_ENABLE_HANDCUFFS
      L1_2 = PLAYER
      L1_2 = L1_2.PLAYER_PED_ID
      L1_2 = L1_2()
      L2_2 = true
      L0_2(L1_2, L2_2)
    end
  end
  L0_2 = PAD
  L0_2 = L0_2.IS_CONTROL_RELEASED
  L1_2 = 1
  L2_2 = 323
  L0_2 = L0_2(L1_2, L2_2)
  if L0_2 then
    L0_2 = ENTITY
    L0_2 = L0_2.IS_ENTITY_PLAYING_ANIM
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_PED_ID
    L1_2 = L1_2()
    L2_2 = "random@mugging3"
    L3_2 = "handsup_standing_base"
    L4_2 = 3
    L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2)
    if L0_2 then
      L0_2 = TASK
      L0_2 = L0_2.CLEAR_PED_SECONDARY_TASK
      L1_2 = PLAYER
      L1_2 = L1_2.PLAYER_PED_ID
      L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L1_2()
      L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
      L0_2 = PED
      L0_2 = L0_2.SET_ENABLE_HANDCUFFS
      L1_2 = PLAYER
      L1_2 = L1_2.PLAYER_PED_ID
      L1_2 = L1_2()
      L2_2 = false
      L0_2(L1_2, L2_2)
    end
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "Space_walk"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = PAD
  L1_2 = L1_2.IS_CONTROL_PRESSED
  L2_2 = 0
  L3_2 = 32
  L1_2 = L1_2(L2_2, L3_2)
  if not L1_2 then
    L1_2 = PAD
    L1_2 = L1_2.IS_CONTROL_PRESSED
    L2_2 = 0
    L3_2 = 34
    L1_2 = L1_2(L2_2, L3_2)
    if not L1_2 then
      L1_2 = PAD
      L1_2 = L1_2.IS_CONTROL_PRESSED
      L2_2 = 0
      L3_2 = 35
      L1_2 = L1_2(L2_2, L3_2)
      if not L1_2 then
        goto lbl_48
      end
    end
  end
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_FORWARD_VECTOR
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2, L3_2, L4_2, L5_2, L6_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
  L2_2 = L1_2.x
  L2_2 = -L2_2
  L1_2.x = L2_2
  L2_2 = L1_2.y
  L2_2 = -L2_2
  L1_2.y = L2_2
  L2_2 = L1_2.z
  L2_2 = -L2_2
  L1_2.z = L2_2
  L2_2 = ENTITY
  L2_2 = L2_2.SET_ENTITY_VELOCITY
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2 = L3_2()
  L4_2 = L1_2.x
  L5_2 = L1_2.y
  L5_2 = L5_2 * 3
  L6_2 = 0.0
  L2_2(L3_2, L4_2, L5_2, L6_2)
  ::lbl_48::
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "Performing_actions"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L1_2 = {}
  L2_2 = "anim@arena@celeb@flat@solo@no_props@"
  L3_2 = "anim@arena@celeb@flat@solo@no_props@"
  L4_2 = "anim@mp_player_intcelebrationfemale@karate_chops"
  L1_2[1] = L2_2
  L1_2[2] = L3_2
  L1_2[3] = L4_2
  L2_2 = {}
  L3_2 = "cap_a_player_a"
  L4_2 = "flip_a_player_a"
  L5_2 = "karate_chops"
  L2_2[1] = L3_2
  L2_2[2] = L4_2
  L2_2[3] = L5_2
  L3_2 = request_anim_dict
  L4_2 = L1_2[A0_2]
  L3_2(L4_2)
  L3_2 = TASK
  L3_2 = L3_2.TASK_PLAY_ANIM
  L4_2 = PLAYER
  L4_2 = L4_2.PLAYER_PED_ID
  L4_2 = L4_2()
  L5_2 = L1_2[A0_2]
  L6_2 = L2_2[A0_2]
  L7_2 = 8.0
  L8_2 = 8.0
  L9_2 = 5000
  L10_2 = 1
  L11_2 = 0
  L12_2 = true
  L13_2 = true
  L14_2 = true
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "renzhepao"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  if A0_2 then
    L1_2 = "missfbi1"
    L2_2 = "ledge_loop"
    L3_2 = request_anim_dict
    L4_2 = L1_2
    L3_2(L4_2)
    L3_2 = TASK
    L3_2 = L3_2.TASK_PLAY_ANIM
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2 = L4_2()
    L5_2 = L1_2
    L6_2 = L2_2
    L7_2 = 3
    L8_2 = 3
    L9_2 = -1
    L10_2 = 51
    L11_2 = 0
    L12_2 = false
    L13_2 = false
    L14_2 = false
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    L3_2 = PED
    L3_2 = L3_2.SET_ENABLE_HANDCUFFS
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2 = L4_2()
    L5_2 = true
    L3_2(L4_2, L5_2)
  else
    L1_2 = TASK
    L1_2 = L1_2.CLEAR_PED_TASKS_IMMEDIATELY
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2 = L2_2()
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    L1_2 = PED
    L1_2 = L1_2.SET_ENABLE_HANDCUFFS
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = false
    L1_2(L2_2, L3_2)
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "forward_somersault"
function L62_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  L0_2 = util
  L0_2 = L0_2.joaat
  L1_2 = "prop_ecola_can"
  L0_2 = L0_2(L1_2)
  L1_2 = entities
  L1_2 = L1_2.create_object
  L2_2 = L0_2
  L3_2 = players
  L3_2 = L3_2.get_position
  L4_2 = PLAYER
  L4_2 = L4_2.PLAYER_ID
  L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L4_2()
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  L2_2 = ENTITY
  L2_2 = L2_2.FREEZE_ENTITY_POSITION
  L3_2 = L1_2
  L2_2(L3_2)
  L2_2 = ENTITY
  L2_2 = L2_2.ATTACH_ENTITY_TO_ENTITY
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2 = L3_2()
  L4_2 = L1_2
  L5_2 = 0
  L6_2 = 0
  L7_2 = 0
  L8_2 = 0
  L9_2 = 0
  L10_2 = 0
  L11_2 = 0
  L12_2 = true
  L13_2 = false
  L14_2 = false
  L15_2 = false
  L16_2 = 0
  L17_2 = true
  L18_2 = 0
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  L2_2 = CAM
  L2_2 = L2_2.GET_GAMEPLAY_CAM_ROT
  L3_2 = 0
  L2_2 = L2_2(L3_2)
  L2_2 = L2_2.z
  L3_2 = ENTITY
  L3_2 = L3_2.SET_ENTITY_ROTATION
  L4_2 = L1_2
  L5_2 = 0
  L6_2 = 0
  L7_2 = L2_2
  L8_2 = 1
  L9_2 = true
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L3_2 = 1
  L4_2 = -360
  L5_2 = -8
  for L6_2 = L3_2, L4_2, L5_2 do
    L7_2 = ENTITY
    L7_2 = L7_2.SET_ENTITY_ROTATION
    L8_2 = L1_2
    L9_2 = L6_2
    L10_2 = 0
    L11_2 = L2_2
    L12_2 = 1
    L13_2 = true
    L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
    L7_2 = util
    L7_2 = L7_2.yield
    L7_2()
  end
  L3_2 = ENTITY
  L3_2 = L3_2.DETACH_ENTITY
  L4_2 = PLAYER
  L4_2 = L4_2.PLAYER_PED_ID
  L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L4_2()
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  L3_2 = delete_entity
  L4_2 = L1_2
  L3_2(L4_2)
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "kill_player"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED_SCRIPT_INDEX
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = L1_2
  L4_2 = true
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = FIRE
  L3_2 = L3_2.ADD_EXPLOSION
  L4_2 = L2_2.x
  L5_2 = L2_2.y
  L6_2 = L2_2.z
  L6_2 = L6_2 + 2
  L7_2 = 7
  L8_2 = 1000
  L9_2 = false
  L10_2 = true
  L11_2 = 0
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "nimingsharen"
function L62_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = pairs
  L1_2 = players
  L1_2 = L1_2.list
  L2_2 = false
  L3_2 = true
  L4_2 = true
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2 = L1_2(L2_2, L3_2, L4_2)
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = kill_player
    L7_2 = L5_2
    L6_2(L7_2)
    L6_2 = util
    L6_2 = L6_2.yield
    L6_2()
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "daidaishijian"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  timeos = A0_2
  L1_2 = timeos
  if L1_2 then
    while true do
      L1_2 = timeos
      if not L1_2 then
        break
      end
      L1_2 = draw_string
      L2_2 = string
      L2_2 = L2_2.format
      L3_2 = os
      L3_2 = L3_2.date
      L4_2 = "~bold~~italic~~o~%Y-%m-%d ~b~%H:%M:%S"
      L5_2 = os
      L5_2 = L5_2.time
      L5_2, L6_2 = L5_2()
      L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2, L5_2, L6_2)
      L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
      L3_2 = 0.43
      L4_2 = 0.05
      L5_2 = 0.47
      L6_2 = 5
      L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
      L1_2 = util
      L1_2 = L1_2.yield
      L1_2()
    end
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "ptlz"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_COORDS
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
  L3_2 = A0_2
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L2_2(L3_2)
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "prop_gold_cont_01"
  L2_2 = L2_2(L3_2)
  L3_2 = request_model
  L4_2 = L2_2
  L3_2(L4_2)
  L3_2 = L1_2.z
  L3_2 = L3_2 - 0.9
  L1_2.z = L3_2
  L3_2 = OBJECT
  L3_2 = L3_2.CREATE_OBJECT
  L4_2 = L2_2
  L5_2 = L1_2.x
  L6_2 = L1_2.y
  L7_2 = L1_2.z
  L8_2 = true
  L9_2 = true
  L10_2 = true
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L4_2 = ENTITY
  L4_2 = L4_2.FREEZE_ENTITY_POSITION
  L5_2 = L3_2
  L6_2 = true
  L4_2(L5_2, L6_2)
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "qdkj"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_COORDS
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
  L3_2 = A0_2
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2 = L2_2(L3_2)
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  L2_2 = 1089807209
  L3_2 = request_model
  L4_2 = L2_2
  L3_2(L4_2)
  L3_2 = OBJECT
  L3_2 = L3_2.CREATE_OBJECT
  L4_2 = L2_2
  L5_2 = L1_2.x
  L5_2 = L5_2 - 1
  L6_2 = L1_2.y
  L7_2 = L1_2.z
  L7_2 = L7_2 - 0.5
  L8_2 = true
  L9_2 = true
  L10_2 = false
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L4_2 = OBJECT
  L4_2 = L4_2.CREATE_OBJECT
  L5_2 = L2_2
  L6_2 = L1_2.x
  L6_2 = L6_2 + 1
  L7_2 = L1_2.y
  L8_2 = L1_2.z
  L8_2 = L8_2 - 0.5
  L9_2 = true
  L10_2 = true
  L11_2 = false
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L5_2 = OBJECT
  L5_2 = L5_2.CREATE_OBJECT
  L6_2 = L2_2
  L7_2 = L1_2.x
  L8_2 = L1_2.y
  L8_2 = L8_2 + 1
  L9_2 = L1_2.z
  L9_2 = L9_2 - 0.5
  L10_2 = true
  L11_2 = true
  L12_2 = false
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L6_2 = OBJECT
  L6_2 = L6_2.CREATE_OBJECT
  L7_2 = L2_2
  L8_2 = L1_2.x
  L9_2 = L1_2.y
  L9_2 = L9_2 - 1
  L10_2 = L1_2.z
  L10_2 = L10_2 - 0.5
  L11_2 = true
  L12_2 = true
  L13_2 = false
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L7_2 = OBJECT
  L7_2 = L7_2.CREATE_OBJECT
  L8_2 = L2_2
  L9_2 = L1_2.x
  L10_2 = L1_2.y
  L11_2 = L1_2.z
  L11_2 = L11_2 + 0.75
  L12_2 = true
  L13_2 = true
  L14_2 = false
  L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  L8_2 = ENTITY
  L8_2 = L8_2.FREEZE_ENTITY_POSITION
  L9_2 = L3_2
  L10_2 = true
  L8_2(L9_2, L10_2)
  L8_2 = ENTITY
  L8_2 = L8_2.FREEZE_ENTITY_POSITION
  L9_2 = L4_2
  L10_2 = true
  L8_2(L9_2, L10_2)
  L8_2 = ENTITY
  L8_2 = L8_2.FREEZE_ENTITY_POSITION
  L9_2 = L5_2
  L10_2 = true
  L8_2(L9_2, L10_2)
  L8_2 = ENTITY
  L8_2 = L8_2.FREEZE_ENTITY_POSITION
  L9_2 = L6_2
  L10_2 = true
  L8_2(L9_2, L10_2)
  L8_2 = ENTITY
  L8_2 = L8_2.FREEZE_ENTITY_POSITION
  L9_2 = L7_2
  L10_2 = true
  L8_2(L9_2, L10_2)
  L8_2 = util
  L8_2 = L8_2.yield
  L9_2 = 15
  L8_2(L9_2)
  L8_2 = STREAMING
  L8_2 = L8_2.SET_MODEL_AS_NO_LONGER_NEEDED
  L9_2 = L3_2
  L8_2(L9_2)
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "zdlz"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_COORDS
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
  L3_2 = A0_2
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L2_2(L3_2)
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "bkr_prop_moneypack_03a"
  L2_2 = L2_2(L3_2)
  L3_2 = request_model
  L4_2 = L2_2
  L3_2(L4_2)
  L3_2 = OBJECT
  L3_2 = L3_2.CREATE_OBJECT
  L4_2 = L2_2
  L5_2 = L1_2.x
  L5_2 = L5_2 - 0.7
  L6_2 = L1_2.y
  L7_2 = L1_2.z
  L8_2 = true
  L9_2 = true
  L10_2 = false
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L4_2 = OBJECT
  L4_2 = L4_2.CREATE_OBJECT
  L5_2 = L2_2
  L6_2 = L1_2.x
  L6_2 = L6_2 + 0.7
  L7_2 = L1_2.y
  L8_2 = L1_2.z
  L9_2 = true
  L10_2 = true
  L11_2 = false
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L5_2 = OBJECT
  L5_2 = L5_2.CREATE_OBJECT
  L6_2 = L2_2
  L7_2 = L1_2.x
  L8_2 = L1_2.y
  L8_2 = L8_2 + 0.7
  L9_2 = L1_2.z
  L10_2 = true
  L11_2 = true
  L12_2 = false
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L6_2 = OBJECT
  L6_2 = L6_2.CREATE_OBJECT
  L7_2 = L2_2
  L8_2 = L1_2.x
  L9_2 = L1_2.y
  L9_2 = L9_2 - 0.7
  L10_2 = L1_2.z
  L11_2 = true
  L12_2 = true
  L13_2 = false
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L7_2 = OBJECT
  L7_2 = L7_2.CREATE_OBJECT
  L8_2 = L2_2
  L9_2 = L1_2.x
  L9_2 = L9_2 - 0.7
  L10_2 = L1_2.y
  L11_2 = L1_2.z
  L11_2 = L11_2 + 0.25
  L12_2 = true
  L13_2 = true
  L14_2 = false
  L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  L8_2 = OBJECT
  L8_2 = L8_2.CREATE_OBJECT
  L9_2 = L2_2
  L10_2 = L1_2.x
  L10_2 = L10_2 + 0.7
  L11_2 = L1_2.y
  L12_2 = L1_2.z
  L12_2 = L12_2 + 0.25
  L13_2 = true
  L14_2 = true
  L15_2 = false
  L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  L9_2 = OBJECT
  L9_2 = L9_2.CREATE_OBJECT
  L10_2 = L2_2
  L11_2 = L1_2.x
  L12_2 = L1_2.y
  L12_2 = L12_2 + 0.7
  L13_2 = L1_2.z
  L13_2 = L13_2 + 0.25
  L14_2 = true
  L15_2 = true
  L16_2 = false
  L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  L10_2 = OBJECT
  L10_2 = L10_2.CREATE_OBJECT
  L11_2 = L2_2
  L12_2 = L1_2.x
  L13_2 = L1_2.y
  L13_2 = L13_2 - 0.7
  L14_2 = L1_2.z
  L14_2 = L14_2 + 0.25
  L15_2 = true
  L16_2 = true
  L17_2 = false
  L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L11_2 = OBJECT
  L11_2 = L11_2.CREATE_OBJECT
  L12_2 = L2_2
  L13_2 = L1_2.x
  L14_2 = L1_2.y
  L15_2 = L1_2.z
  L15_2 = L15_2 + 0.75
  L16_2 = true
  L17_2 = true
  L18_2 = false
  L11_2 = L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  L12_2 = util
  L12_2 = L12_2.yield
  L13_2 = 15
  L12_2(L13_2)
  L12_2 = ENTITY
  L12_2 = L12_2.GET_ENTITY_ROTATION
  L13_2 = L7_2
  L14_2 = 0
  L12_2 = L12_2(L13_2, L14_2)
  L12_2.y = 90
  L13_2 = ENTITY
  L13_2 = L13_2.SET_ENTITY_ROTATION
  L14_2 = L7_2
  L15_2 = L12_2.x
  L16_2 = L12_2.y
  L17_2 = L12_2.z
  L18_2 = 1
  L19_2 = true
  L13_2(L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
  L13_2 = STREAMING
  L13_2 = L13_2.SET_MODEL_AS_NO_LONGER_NEEDED
  L14_2 = L7_2
  L13_2(L14_2)
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "yylz"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_COORDS
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
  L3_2 = A0_2
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L2_2(L3_2)
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L2_2 = 684586828
  L3_2 = request_model
  L4_2 = L2_2
  L3_2(L4_2)
  L3_2 = OBJECT
  L3_2 = L3_2.CREATE_OBJECT
  L4_2 = L2_2
  L5_2 = L1_2.x
  L6_2 = L1_2.y
  L7_2 = L1_2.z
  L7_2 = L7_2 - 1
  L8_2 = true
  L9_2 = true
  L10_2 = false
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L4_2 = OBJECT
  L4_2 = L4_2.CREATE_OBJECT
  L5_2 = L2_2
  L6_2 = L1_2.x
  L7_2 = L1_2.y
  L8_2 = L1_2.z
  L9_2 = true
  L10_2 = true
  L11_2 = false
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L5_2 = OBJECT
  L5_2 = L5_2.CREATE_OBJECT
  L6_2 = L2_2
  L7_2 = L1_2.x
  L8_2 = L1_2.y
  L9_2 = L1_2.z
  L9_2 = L9_2 + 1
  L10_2 = true
  L11_2 = true
  L12_2 = false
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L6_2 = util
  L6_2 = L6_2.yield
  L7_2 = 15
  L6_2(L7_2)
  L6_2 = ENTITY
  L6_2 = L6_2.GET_ENTITY_ROTATION
  L7_2 = L4_2
  L8_2 = 0
  L6_2 = L6_2(L7_2, L8_2)
  L6_2.y = 90
  L7_2 = ENTITY
  L7_2 = L7_2.SET_ENTITY_ROTATION
  L8_2 = L4_2
  L9_2 = L6_2.x
  L10_2 = L6_2.y
  L11_2 = L6_2.z
  L12_2 = 1
  L13_2 = true
  L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L7_2 = STREAMING
  L7_2 = L7_2.SET_MODEL_AS_NO_LONGER_NEEDED
  L8_2 = L4_2
  L7_2(L8_2)
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "cclz"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_COORDS
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
  L3_2 = A0_2
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L2_2(L3_2)
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L2_2 = 4022605402
  L3_2 = request_model
  L4_2 = L2_2
  L3_2(L4_2)
  L3_2 = OBJECT
  L3_2 = L3_2.CREATE_OBJECT
  L4_2 = L2_2
  L5_2 = L1_2.x
  L6_2 = L1_2.y
  L7_2 = L1_2.z
  L7_2 = L7_2 - 1
  L8_2 = true
  L9_2 = true
  L10_2 = false
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L4_2 = util
  L4_2 = L4_2.yield
  L5_2 = 15
  L4_2(L5_2)
  L4_2 = STREAMING
  L4_2 = L4_2.SET_MODEL_AS_NO_LONGER_NEEDED
  L5_2 = L3_2
  L4_2(L5_2)
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "sdkl1"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_COORDS
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
  L3_2 = A0_2
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L2_2(L3_2)
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L2_2 = 238789712
  L3_2 = request_model
  L4_2 = L2_2
  L3_2(L4_2)
  L3_2 = OBJECT
  L3_2 = L3_2.CREATE_OBJECT
  L4_2 = L2_2
  L5_2 = L1_2.x
  L6_2 = L1_2.y
  L7_2 = L1_2.z
  L7_2 = L7_2 - 1
  L8_2 = true
  L9_2 = true
  L10_2 = false
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L4_2 = util
  L4_2 = L4_2.yield
  L5_2 = 15
  L4_2(L5_2)
  L4_2 = STREAMING
  L4_2 = L4_2.SET_MODEL_AS_NO_LONGER_NEEDED
  L5_2 = L3_2
  L4_2(L5_2)
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "sdkl2"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_COORDS
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
  L3_2 = A0_2
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2 = L2_2(L3_2)
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "ch_prop_tree_02a"
  L2_2 = L2_2(L3_2)
  L3_2 = request_model
  L4_2 = L2_2
  L3_2(L4_2)
  L3_2 = OBJECT
  L3_2 = L3_2.CREATE_OBJECT
  L4_2 = L2_2
  L5_2 = L1_2.x
  L5_2 = L5_2 - 0.75
  L6_2 = L1_2.y
  L7_2 = L1_2.z
  L7_2 = L7_2 - 0.5
  L8_2 = true
  L9_2 = true
  L10_2 = false
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L4_2 = OBJECT
  L4_2 = L4_2.CREATE_OBJECT
  L5_2 = L2_2
  L6_2 = L1_2.x
  L6_2 = L6_2 + 0.75
  L7_2 = L1_2.y
  L8_2 = L1_2.z
  L8_2 = L8_2 - 0.5
  L9_2 = true
  L10_2 = true
  L11_2 = false
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L5_2 = OBJECT
  L5_2 = L5_2.CREATE_OBJECT
  L6_2 = L2_2
  L7_2 = L1_2.x
  L8_2 = L1_2.y
  L8_2 = L8_2 + 0.75
  L9_2 = L1_2.z
  L9_2 = L9_2 - 0.5
  L10_2 = true
  L11_2 = true
  L12_2 = false
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L6_2 = OBJECT
  L6_2 = L6_2.CREATE_OBJECT
  L7_2 = L2_2
  L8_2 = L1_2.x
  L9_2 = L1_2.y
  L9_2 = L9_2 - 0.75
  L10_2 = L1_2.z
  L10_2 = L10_2 - 0.5
  L11_2 = true
  L12_2 = true
  L13_2 = false
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L7_2 = OBJECT
  L7_2 = L7_2.CREATE_OBJECT
  L8_2 = L2_2
  L9_2 = L1_2.x
  L10_2 = L1_2.y
  L11_2 = L1_2.z
  L11_2 = L11_2 + 0.5
  L12_2 = true
  L13_2 = true
  L14_2 = false
  L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  L8_2 = util
  L8_2 = L8_2.yield
  L9_2 = 15
  L8_2(L9_2)
  L8_2 = STREAMING
  L8_2 = L8_2.SET_MODEL_AS_NO_LONGER_NEEDED
  L9_2 = L3_2
  L8_2(L9_2)
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "sdkl3"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_COORDS
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
  L3_2 = A0_2
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L2_2(L3_2)
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "ch_prop_tree_03a"
  L2_2 = L2_2(L3_2)
  L3_2 = request_model
  L4_2 = L2_2
  L3_2(L4_2)
  L3_2 = OBJECT
  L3_2 = L3_2.CREATE_OBJECT
  L4_2 = L2_2
  L5_2 = L1_2.x
  L5_2 = L5_2 - 0.75
  L6_2 = L1_2.y
  L7_2 = L1_2.z
  L7_2 = L7_2 - 0.5
  L8_2 = true
  L9_2 = true
  L10_2 = false
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L4_2 = OBJECT
  L4_2 = L4_2.CREATE_OBJECT
  L5_2 = L2_2
  L6_2 = L1_2.x
  L6_2 = L6_2 + 0.75
  L7_2 = L1_2.y
  L8_2 = L1_2.z
  L8_2 = L8_2 - 0.5
  L9_2 = true
  L10_2 = true
  L11_2 = false
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L5_2 = OBJECT
  L5_2 = L5_2.CREATE_OBJECT
  L6_2 = L2_2
  L7_2 = L1_2.x
  L8_2 = L1_2.y
  L8_2 = L8_2 + 0.75
  L9_2 = L1_2.z
  L9_2 = L9_2 - 0.5
  L10_2 = true
  L11_2 = true
  L12_2 = false
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L6_2 = OBJECT
  L6_2 = L6_2.CREATE_OBJECT
  L7_2 = L2_2
  L8_2 = L1_2.x
  L9_2 = L1_2.y
  L9_2 = L9_2 - 0.75
  L10_2 = L1_2.z
  L10_2 = L10_2 - 0.5
  L11_2 = true
  L12_2 = true
  L13_2 = false
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L7_2 = OBJECT
  L7_2 = L7_2.CREATE_OBJECT
  L8_2 = L2_2
  L9_2 = L1_2.x
  L10_2 = L1_2.y
  L11_2 = L1_2.z
  L11_2 = L11_2 + 0.5
  L12_2 = true
  L13_2 = true
  L14_2 = false
  L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  L8_2 = util
  L8_2 = L8_2.yield
  L8_2()
  L8_2 = ENTITY
  L8_2 = L8_2.GET_ENTITY_ROTATION
  L9_2 = L3_2
  L10_2 = 0
  L8_2 = L8_2(L9_2, L10_2)
  L8_2.y = 90
  L9_2 = ENTITY
  L9_2 = L9_2.SET_ENTITY_ROTATION
  L10_2 = L3_2
  L11_2 = L8_2.x
  L12_2 = L8_2.y
  L13_2 = L8_2.z
  L14_2 = 1
  L15_2 = true
  L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  L9_2 = STREAMING
  L9_2 = L9_2.SET_MODEL_AS_NO_LONGER_NEEDED
  L10_2 = L3_2
  L9_2(L10_2)
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "powercage"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2
  L1_2 = 6
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "prop_elecbox_12"
  L2_2 = L2_2(L3_2)
  L3_2 = PLAYER
  L3_2 = L3_2.GET_PLAYER_PED_SCRIPT_INDEX
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = ENTITY
  L4_2 = L4_2.GET_ENTITY_COORDS
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  L5_2 = L4_2.z
  L5_2 = L5_2 - 0.5
  L4_2.z = L5_2
  L5_2 = request_model
  L6_2 = L2_2
  L5_2(L6_2)
  L5_2 = v3
  L5_2 = L5_2.new
  L6_2 = 0
  L7_2 = 0
  L8_2 = 0
  L5_2 = L5_2(L6_2, L7_2, L8_2)
  L6_2 = 1
  L7_2 = L1_2
  L8_2 = 1
  for L9_2 = L6_2, L7_2, L8_2 do
    L10_2 = L9_2 / L1_2
    L10_2 = L10_2 * 360
    L5_2.z = L10_2
    L12_2 = L5_2
    L11_2 = L5_2.toDir
    L11_2 = L11_2(L12_2)
    L13_2 = L11_2
    L12_2 = L11_2.mul
    L14_2 = 2.5
    L12_2(L13_2, L14_2)
    L13_2 = L11_2
    L12_2 = L11_2.add
    L14_2 = L4_2
    L12_2(L13_2, L14_2)
    L12_2 = 1
    L13_2 = 5
    L14_2 = 1
    for L15_2 = L12_2, L13_2, L14_2 do
      L16_2 = entities
      L16_2 = L16_2.create_object
      L17_2 = L2_2
      L18_2 = L11_2
      L16_2 = L16_2(L17_2, L18_2)
      L17_2 = ENTITY
      L17_2 = L17_2.SET_ENTITY_ROTATION
      L18_2 = L16_2
      L19_2 = 90.0
      L20_2 = 0.0
      L21_2 = L10_2
      L22_2 = 1
      L23_2 = true
      L17_2(L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
      L17_2 = L11_2.z
      L17_2 = L17_2 + 0.75
      L11_2.z = L17_2
      L17_2 = ENTITY
      L17_2 = L17_2.FREEZE_ENTITY_POSITION
      L18_2 = L16_2
      L19_2 = true
      L17_2(L18_2, L19_2)
    end
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "jjglz"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "stt_prop_stunt_tube_s"
  L1_2 = L1_2(L2_2)
  L2_2 = request_model
  L3_2 = L1_2
  L2_2(L3_2)
  L2_2 = players
  L2_2 = L2_2.get_position
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = entities
  L3_2 = L3_2.create_object
  L4_2 = L1_2
  L5_2 = L2_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = ENTITY
  L4_2 = L4_2.GET_ENTITY_ROTATION
  L5_2 = L3_2
  L6_2 = 2
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_ROTATION
  L6_2 = L3_2
  L7_2 = L4_2.x
  L8_2 = 90.0
  L9_2 = L4_2.z
  L10_2 = 1
  L11_2 = true
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L5_2 = STREAMING
  L5_2 = L5_2.SET_MODEL_AS_NO_LONGER_NEEDED
  L6_2 = L1_2
  L5_2(L6_2)
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "gueencage"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  L1_2 = 6
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "prop_coffin_02b"
  L2_2 = L2_2(L3_2)
  L3_2 = PLAYER
  L3_2 = L3_2.GET_PLAYER_PED_SCRIPT_INDEX
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = ENTITY
  L4_2 = L4_2.GET_ENTITY_COORDS
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  L5_2 = request_model
  L6_2 = L2_2
  L5_2(L6_2)
  L5_2 = v3
  L5_2 = L5_2.new
  L6_2 = 0
  L7_2 = 0
  L8_2 = 0
  L5_2 = L5_2(L6_2, L7_2, L8_2)
  L6_2 = 1
  L7_2 = L1_2
  L8_2 = 1
  for L9_2 = L6_2, L7_2, L8_2 do
    L10_2 = L9_2 / L1_2
    L10_2 = L10_2 * 360
    L5_2.z = L10_2
    L12_2 = L5_2
    L11_2 = L5_2.toDir
    L11_2 = L11_2(L12_2)
    L13_2 = L11_2
    L12_2 = L11_2.mul
    L14_2 = 0.8
    L12_2(L13_2, L14_2)
    L13_2 = L11_2
    L12_2 = L11_2.add
    L14_2 = L4_2
    L12_2(L13_2, L14_2)
    L12_2 = L11_2.z
    L12_2 = L12_2 + 0.1
    L11_2.z = L12_2
    L12_2 = entities
    L12_2 = L12_2.create_object
    L13_2 = L2_2
    L14_2 = L11_2
    L12_2 = L12_2(L13_2, L14_2)
    L13_2 = ENTITY
    L13_2 = L13_2.SET_ENTITY_ROTATION
    L14_2 = L12_2
    L15_2 = 90.0
    L16_2 = 0.0
    L17_2 = L10_2
    L18_2 = 1
    L19_2 = true
    L13_2(L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
    L13_2 = ENTITY
    L13_2 = L13_2.FREEZE_ENTITY_POSITION
    L14_2 = L12_2
    L15_2 = true
    L13_2(L14_2, L15_2)
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "chestcage"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "prop_container_ld_pu"
  L1_2 = L1_2(L2_2)
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = ENTITY
  L3_2 = L3_2.GET_ENTITY_COORDS
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  L4_2 = request_model
  L5_2 = L1_2
  L4_2(L5_2)
  L4_2 = L3_2.z
  L4_2 = L4_2 - 1
  L3_2.z = L4_2
  L4_2 = entities
  L4_2 = L4_2.create_object
  L5_2 = L1_2
  L6_2 = L3_2
  L7_2 = 0
  L4_2 = L4_2(L5_2, L6_2, L7_2)
  L5_2 = ENTITY
  L5_2 = L5_2.FREEZE_ENTITY_POSITION
  L6_2 = L4_2
  L7_2 = true
  L5_2(L6_2, L7_2)
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "vehcagelol"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "boxville3"
  L1_2 = L1_2(L2_2)
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = ENTITY
  L3_2 = L3_2.GET_ENTITY_COORDS
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  L4_2 = request_model
  L5_2 = L1_2
  L4_2(L5_2)
  L4_2 = entities
  L4_2 = L4_2.create_vehicle
  L5_2 = L1_2
  L6_2 = ENTITY
  L6_2 = L6_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L7_2 = L2_2
  L8_2 = 0.0
  L9_2 = 2.0
  L10_2 = 0.0
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
  L7_2 = ENTITY
  L7_2 = L7_2.GET_ENTITY_HEADING
  L8_2 = L2_2
  L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_VISIBLE
  L6_2 = L4_2
  L7_2 = false
  L5_2(L6_2, L7_2)
  L5_2 = ENTITY
  L5_2 = L5_2.FREEZE_ENTITY_POSITION
  L6_2 = L4_2
  L7_2 = true
  L5_2(L6_2, L7_2)
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "gascage"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "prop_gascage01"
  L1_2 = L1_2(L2_2)
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = ENTITY
  L3_2 = L3_2.GET_ENTITY_COORDS
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  L4_2 = request_model
  L5_2 = L1_2
  L4_2(L5_2)
  L4_2 = L3_2.z
  L4_2 = L4_2 - 1
  L3_2.z = L4_2
  L4_2 = entities
  L4_2 = L4_2.create_object
  L5_2 = L1_2
  L6_2 = L3_2
  L7_2 = 0
  L4_2 = L4_2(L5_2, L6_2, L7_2)
  L5_2 = L3_2.z
  L5_2 = L5_2 + 1
  L3_2.z = L5_2
  L5_2 = entities
  L5_2 = L5_2.create_object
  L6_2 = L1_2
  L7_2 = L3_2
  L8_2 = 0
  L5_2 = L5_2(L6_2, L7_2, L8_2)
  L6_2 = ENTITY
  L6_2 = L6_2.FREEZE_ENTITY_POSITION
  L7_2 = L4_2
  L8_2 = true
  L6_2(L7_2, L8_2)
  L6_2 = ENTITY
  L6_2 = L6_2.FREEZE_ENTITY_POSITION
  L7_2 = L5_2
  L8_2 = true
  L6_2(L7_2, L8_2)
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "tpTableToPlayer"
function L62_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L2_2 = NETWORK
  L2_2 = L2_2.NETWORK_IS_PLAYER_CONNECTED
  L3_2 = A1_2
  L2_2 = L2_2(L3_2)
  if L2_2 then
    L2_2 = ENTITY
    L2_2 = L2_2.GET_ENTITY_COORDS
    L3_2 = PLAYER
    L3_2 = L3_2.GET_PLAYER_PED
    L4_2 = A1_2
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2 = L3_2(L4_2)
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
    L3_2 = pairs
    L4_2 = A0_2
    L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
    for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
      L9_2 = PED
      L9_2 = L9_2.IS_PED_A_PLAYER
      L10_2 = L8_2
      L9_2 = L9_2(L10_2)
      if not L9_2 then
        L9_2 = ENTITY
        L9_2 = L9_2.SET_ENTITY_COORDS_NO_OFFSET
        L10_2 = L8_2
        L11_2 = L2_2.x
        L12_2 = L2_2.y
        L13_2 = L2_2.z
        L14_2 = false
        L15_2 = false
        L16_2 = false
        L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
      end
    end
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "TpAllPeds"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = entities
  L1_2 = L1_2.get_all_peds_as_handles
  L1_2 = L1_2()
  L2_2 = tpTableToPlayer
  L3_2 = L1_2
  L4_2 = A0_2
  L2_2(L3_2, L4_2)
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "TpAllVehs"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = entities
  L1_2 = L1_2.get_all_vehicles_as_handles
  L1_2 = L1_2()
  L2_2 = tpTableToPlayer
  L3_2 = L1_2
  L4_2 = A0_2
  L2_2(L3_2, L4_2)
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "TpAllObjects"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = entities
  L1_2 = L1_2.get_all_objects_as_handles
  L1_2 = L1_2()
  L2_2 = tpTableToPlayer
  L3_2 = L1_2
  L4_2 = A0_2
  L2_2(L3_2, L4_2)
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "TpAllPickups"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = entities
  L1_2 = L1_2.get_all_pickups_as_handles
  L1_2 = L1_2()
  L2_2 = tpTableToPlayer
  L3_2 = L1_2
  L4_2 = A0_2
  L2_2(L3_2, L4_2)
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "GetTableFromV3Instance"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = {}
  L2_2 = v3
  L2_2 = L2_2.getX
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L1_2.x = L2_2
  L2_2 = v3
  L2_2 = L2_2.getY
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L1_2.y = L2_2
  L2_2 = v3
  L2_2 = L2_2.getZ
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L1_2.z = L2_2
  return L1_2
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "SE_add_owned_explosion"
function L62_1(A0_2, A1_2, A2_2, A3_2, A4_2, A5_2, A6_2, A7_2, A8_2)
  local L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  L9_2 = FIRE
  L9_2 = L9_2.ADD_OWNED_EXPLOSION
  L10_2 = A0_2
  L11_2 = A1_2
  L12_2 = A2_2
  L13_2 = A3_2
  L14_2 = A4_2
  L15_2 = A5_2
  L16_2 = A6_2
  L17_2 = A7_2
  L18_2 = A8_2
  L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "request_ptfx_asset_peeloop"
function L62_1(A0_2)
  local L1_2, L2_2
  L1_2 = STREAMING
  L1_2 = L1_2.REQUEST_NAMED_PTFX_ASSET
  L2_2 = A0_2
  L1_2(L2_2)
  while true do
    L1_2 = STREAMING
    L1_2 = L1_2.HAS_NAMED_PTFX_ASSET_LOADED
    L2_2 = A0_2
    L1_2 = L1_2(L2_2)
    if L1_2 then
      break
    end
    L1_2 = util
    L1_2 = L1_2.yield
    L1_2()
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "orbital"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2
  L1_2 = 0
  L2_2 = 30
  L3_2 = 1
  for L4_2 = L1_2, L2_2, L3_2 do
    L5_2 = ENTITY
    L5_2 = L5_2.GET_ENTITY_COORDS
    L6_2 = PLAYER
    L6_2 = L6_2.GET_PLAYER_PED_SCRIPT_INDEX
    L7_2 = A0_2
    L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2 = L6_2(L7_2)
    L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
    pos = L5_2
    L5_2 = -2
    L6_2 = 2
    L7_2 = 1
    for L8_2 = L5_2, L6_2, L7_2 do
      L9_2 = -2
      L10_2 = 2
      L11_2 = 1
      for L12_2 = L9_2, L10_2, L11_2 do
        L13_2 = ENTITY
        L13_2 = L13_2.GET_ENTITY_COORDS
        L14_2 = PLAYER
        L14_2 = L14_2.GET_PLAYER_PED_SCRIPT_INDEX
        L15_2 = A0_2
        L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2 = L14_2(L15_2)
        L13_2 = L13_2(L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
        L14_2 = FIRE
        L14_2 = L14_2.ADD_OWNED_EXPLOSION
        L15_2 = PLAYER
        L15_2 = L15_2.PLAYER_PED_ID
        L15_2 = L15_2()
        L16_2 = L13_2.x
        L16_2 = L16_2 + L8_2
        L17_2 = L13_2.y
        L17_2 = L17_2 + L8_2
        L18_2 = L13_2.z
        L19_2 = 30
        L19_2 = L19_2 - L4_2
        L18_2 = L18_2 + L19_2
        L19_2 = 29
        L20_2 = 999999.99
        L21_2 = true
        L22_2 = false
        L23_2 = 8
        L14_2(L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
      end
    end
    L5_2 = util
    L5_2 = L5_2.yield
    L6_2 = 20
    L5_2(L6_2)
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "rain_rockets"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = PLAYER
  L3_2 = L3_2.GET_PLAYER_PED_SCRIPT_INDEX
  L4_2 = A0_2
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L3_2(L4_2)
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  L3_2 = util
  L3_2 = L3_2.joaat
  L4_2 = "weapon_airstrike_rocket"
  L3_2 = L3_2(L4_2)
  L4_2 = WEAPON
  L4_2 = L4_2.HAS_WEAPON_ASSET_LOADED
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  if not L4_2 then
    L4_2 = WEAPON
    L4_2 = L4_2.REQUEST_WEAPON_ASSET
    L5_2 = L3_2
    L6_2 = 31
    L7_2 = 0
    L4_2(L5_2, L6_2, L7_2)
  end
  L4_2 = L2_2.x
  L5_2 = math
  L5_2 = L5_2.random
  L6_2 = -10
  L7_2 = 10
  L5_2 = L5_2(L6_2, L7_2)
  L4_2 = L4_2 + L5_2
  L2_2.x = L4_2
  L4_2 = L2_2.y
  L5_2 = math
  L5_2 = L5_2.random
  L6_2 = -10
  L7_2 = 10
  L5_2 = L5_2(L6_2, L7_2)
  L4_2 = L4_2 + L5_2
  L2_2.y = L4_2
  L4_2 = memory
  L4_2 = L4_2.alloc
  L5_2 = 32
  L4_2 = L4_2(L5_2)
  L5_2 = MISC
  L5_2 = L5_2.GET_GROUND_Z_FOR_3D_COORD
  L6_2 = L2_2.x
  L7_2 = L2_2.y
  L8_2 = L2_2.z
  L9_2 = L4_2
  L10_2 = false
  L11_2 = false
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L5_2 = memory
  L5_2 = L5_2.read_float
  L6_2 = L4_2
  L5_2 = L5_2(L6_2)
  L2_2.z = L5_2
  L5_2 = MISC
  L5_2 = L5_2.SHOOT_SINGLE_BULLET_BETWEEN_COORDS
  L6_2 = L2_2.x
  L7_2 = L2_2.y
  L8_2 = L2_2.z
  L8_2 = L8_2 + 50
  L9_2 = L2_2.x
  L10_2 = L2_2.y
  L11_2 = L2_2.z
  L12_2 = 200
  L13_2 = true
  L14_2 = L3_2
  L15_2 = owner
  L16_2 = true
  L17_2 = false
  L18_2 = 2500.0
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  L5_2 = util
  L5_2 = L5_2.yield
  L6_2 = 200
  L5_2(L6_2)
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "rain_bullet"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L1_2 = MISC
  L1_2 = L1_2.GET_HASH_KEY
  L2_2 = "weapon_machinepistol"
  L1_2 = L1_2(L2_2)
  L2_2 = WEAPON
  L2_2 = L2_2.HAS_WEAPON_ASSET_LOADED
  L3_2 = L1_2
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    L2_2 = WEAPON
    L2_2 = L2_2.REQUEST_WEAPON_ASSET
    L3_2 = L1_2
    L4_2 = 31
    L5_2 = 0
    L2_2(L3_2, L4_2, L5_2)
  end
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = PLAYER
  L3_2 = L3_2.GET_PLAYER_PED
  L4_2 = A0_2
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2 = L3_2(L4_2)
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  L3_2 = L2_2.z
  L3_2 = L3_2 + 10.0
  L2_2.z = L3_2
  L3_2 = MISC
  L3_2 = L3_2.SHOOT_SINGLE_BULLET_BETWEEN_COORDS
  L4_2 = L2_2.x
  L5_2 = L2_2.y
  L6_2 = L2_2.z
  L7_2 = L2_2.x
  L8_2 = L2_2.y
  L9_2 = L2_2.z
  L9_2 = L9_2 - 10
  L10_2 = 10000.0
  L11_2 = true
  L12_2 = L1_2
  L13_2 = 0
  L14_2 = true
  L15_2 = false
  L16_2 = 10000.0
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  L3_2 = L2_2.y
  L3_2 = L3_2 + 10.0
  L2_2.y = L3_2
  L3_2 = MISC
  L3_2 = L3_2.SHOOT_SINGLE_BULLET_BETWEEN_COORDS
  L4_2 = L2_2.x
  L5_2 = L2_2.y
  L6_2 = L2_2.z
  L7_2 = L2_2.x
  L8_2 = L2_2.y
  L8_2 = L8_2 - 10
  L9_2 = L2_2.z
  L9_2 = L9_2 - 10
  L10_2 = 10000.0
  L11_2 = true
  L12_2 = L1_2
  L13_2 = 0
  L14_2 = true
  L15_2 = false
  L16_2 = 10000.0
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  L3_2 = L2_2.x
  L3_2 = L3_2 + 10.0
  L2_2.x = L3_2
  L3_2 = MISC
  L3_2 = L3_2.SHOOT_SINGLE_BULLET_BETWEEN_COORDS
  L4_2 = L2_2.x
  L5_2 = L2_2.y
  L6_2 = L2_2.z
  L7_2 = L2_2.x
  L7_2 = L7_2 - 10
  L8_2 = L2_2.y
  L8_2 = L8_2 - 10
  L9_2 = L2_2.z
  L9_2 = L9_2 - 10
  L10_2 = 10000.0
  L11_2 = true
  L12_2 = L1_2
  L13_2 = 0
  L14_2 = true
  L15_2 = false
  L16_2 = 10000.0
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "custom_alert"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = os
  L1_2 = L1_2.time
  L1_2 = L1_2()
  poptime = L1_2
  while true do
    L1_2 = PAD
    L1_2 = L1_2.IS_CONTROL_JUST_RELEASED
    L2_2 = 18
    L3_2 = 18
    L1_2 = L1_2(L2_2, L3_2)
    if L1_2 then
      L1_2 = os
      L1_2 = L1_2.time
      L1_2 = L1_2()
      L2_2 = poptime
      L1_2 = L1_2 - L2_2
      L2_2 = 0.1
      if L1_2 > L2_2 then
        break
      end
    end
    L1_2 = native_invoker
    L1_2 = L1_2.begin_call
    L1_2()
    L1_2 = native_invoker
    L1_2 = L1_2.push_arg_string
    L2_2 = "ALERT"
    L1_2(L2_2)
    L1_2 = native_invoker
    L1_2 = L1_2.push_arg_string
    L2_2 = "JL_INVITE_ND"
    L1_2(L2_2)
    L1_2 = native_invoker
    L1_2 = L1_2.push_arg_int
    L2_2 = 2
    L1_2(L2_2)
    L1_2 = native_invoker
    L1_2 = L1_2.push_arg_string
    L2_2 = ""
    L1_2(L2_2)
    L1_2 = native_invoker
    L1_2 = L1_2.push_arg_bool
    L2_2 = true
    L1_2(L2_2)
    L1_2 = native_invoker
    L1_2 = L1_2.push_arg_int
    L2_2 = -1
    L1_2(L2_2)
    L1_2 = native_invoker
    L1_2 = L1_2.push_arg_int
    L2_2 = -1
    L1_2(L2_2)
    L1_2 = native_invoker
    L1_2 = L1_2.push_arg_string
    L2_2 = A0_2
    L1_2(L2_2)
    L1_2 = native_invoker
    L1_2 = L1_2.push_arg_int
    L2_2 = 0
    L1_2(L2_2)
    L1_2 = native_invoker
    L1_2 = L1_2.push_arg_bool
    L2_2 = true
    L1_2(L2_2)
    L1_2 = native_invoker
    L1_2 = L1_2.push_arg_int
    L2_2 = 0
    L1_2(L2_2)
    L1_2 = native_invoker
    L1_2 = L1_2.end_call
    L2_2 = "701919482C74B5AB"
    L1_2(L2_2)
    L1_2 = util
    L1_2 = L1_2.yield
    L1_2()
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "RequestNanoDrone"
function L62_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
  L0_2 = 1963795
  L1_2 = memory
  L1_2 = L1_2.script_global
  L2_2 = L0_2
  L1_2 = L1_2(L2_2)
  L2_2 = memory
  L2_2 = L2_2.write_int
  L3_2 = L1_2
  L4_2 = memory
  L4_2 = L4_2.read_int
  L5_2 = L1_2
  L4_2 = L4_2(L5_2)
  L4_2 = L4_2 | 29360128
  L2_2(L3_2, L4_2)
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "autoaccept"
function L62_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L0_2 = HUD
  L0_2 = L0_2.GET_WARNING_SCREEN_MESSAGE_HASH
  L0_2 = L0_2()
  L1_2 = HUD
  L1_2 = L1_2.IS_PAUSE_MENU_ACTIVE
  L1_2 = L1_2()
  L2_2 = ipairs
  L3_2 = invite_string
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = MISC
    L8_2 = L8_2.GET_HASH_KEY
    L9_2 = L7_2
    L8_2 = L8_2(L9_2)
    if L0_2 == L8_2 and not L1_2 then
      L8_2 = PAD
      L8_2 = L8_2.SET_CONTROL_VALUE_NEXT_FRAME
      L9_2 = 2
      L10_2 = 201
      L11_2 = 1.0
      L8_2(L9_2, L10_2, L11_2)
      L8_2 = yield
      L9_2 = 25
      L8_2(L9_2)
    end
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "autogethost"
function L62_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = players
  L0_2 = L0_2.get_host
  L0_2 = L0_2()
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2 = L1_2()
  if L0_2 ~= L1_2 then
    L0_2 = util
    L0_2 = L0_2.is_session_transition_active
    L0_2 = L0_2()
    if not L0_2 then
      L0_2 = PLAYER
      L0_2 = L0_2.GET_PLAYER_NAME
      L1_2 = players
      L1_2 = L1_2.get_host
      L1_2, L2_2, L3_2 = L1_2()
      L0_2 = L0_2(L1_2, L2_2, L3_2)
      if "**Invalid**" ~= L0_2 then
        L0_2 = menu
        L0_2 = L0_2.trigger_commands
        L1_2 = "kick "
        L2_2 = PLAYER
        L2_2 = L2_2.GET_PLAYER_NAME
        L3_2 = players
        L3_2 = L3_2.get_host
        L3_2 = L3_2()
        L2_2 = L2_2(L3_2)
        L1_2 = L1_2 .. L2_2
        L0_2(L1_2)
        L0_2 = util
        L0_2 = L0_2.yield
        L1_2 = 200
        L0_2(L1_2)
      end
    end
  end
  L0_2 = players
  L0_2 = L0_2.get_name
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2, L2_2, L3_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2)
  L1_2 = players
  L1_2 = L1_2.get_name
  L2_2 = players
  L2_2 = L2_2.get_host
  L2_2, L3_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2)
  if L0_2 == L1_2 then
    L0_2 = util
    L0_2 = L0_2.toast
    L1_2 = "获得主机,已禁用自动获取主机"
    L0_2(L1_2)
    L0_2 = menu
    L0_2 = L0_2.set_value
    L1_2 = auto_host
    L2_2 = false
    L0_2(L1_2, L2_2)
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "get_transition_state"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = memory
  L1_2 = L1_2.read_int
  L2_2 = memory
  L2_2 = L2_2.script_global
  L3_2 = A0_2 * 453
  L3_2 = 2689236 + L3_2
  L3_2 = L3_2 + 230
  L2_2, L3_2 = L2_2(L3_2)
  return L1_2(L2_2, L3_2)
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "get_interior_player_is_in"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = memory
  L1_2 = L1_2.read_int
  L2_2 = memory
  L2_2 = L2_2.script_global
  L3_2 = A0_2 * 453
  L3_2 = 2689236 + L3_2
  L3_2 = L3_2 + 243
  L2_2, L3_2 = L2_2(L3_2)
  return L1_2(L2_2, L3_2)
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "GetSpawnState"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = memory
  L1_2 = L1_2.read_int
  L2_2 = memory
  L2_2 = L2_2.script_global
  L3_2 = A0_2 * 466
  L3_2 = 2657590 + L3_2
  L3_2 = L3_2 + 232
  L2_2, L3_2 = L2_2(L3_2)
  return L1_2(L2_2, L3_2)
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "GetInteriorPlayerIsIn"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = memory
  L1_2 = L1_2.read_int
  L2_2 = memory
  L2_2 = L2_2.script_global
  L3_2 = A0_2 * 466
  L3_2 = 2657590 + L3_2
  L3_2 = L3_2 + 245
  L2_2, L3_2 = L2_2(L3_2)
  return L1_2(L2_2, L3_2)
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "god_detection"
function L62_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L0_2 = players
  L0_2 = L0_2.list
  L1_2 = false
  L2_2 = true
  L3_2 = true
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = PLAYER
    L6_2 = L6_2.GET_PLAYER_PED_SCRIPT_INDEX
    L7_2 = L5_2
    L6_2 = L6_2(L7_2)
    L7_2 = interior_stuff
    L8_2 = nil
    L9_2 = nil
    L10_2 = nil
    for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
      L13_2 = players
      L13_2 = L13_2.is_godmode
      L14_2 = L5_2
      L13_2 = L13_2(L14_2)
      if L13_2 then
        L13_2 = players
        L13_2 = L13_2.is_in_interior
        L14_2 = L5_2
        L13_2 = L13_2(L14_2)
        if not L13_2 then
          L13_2 = NETWORK
          L13_2 = L13_2.NETWORK_IS_PLAYER_FADING
          L14_2 = L5_2
          L13_2 = L13_2(L14_2)
          if not L13_2 then
            L13_2 = ENTITY
            L13_2 = L13_2.IS_ENTITY_VISIBLE
            L14_2 = L6_2
            L13_2 = L13_2(L14_2)
            if L13_2 then
              L13_2 = GetSpawnState
              L14_2 = L5_2
              L13_2 = L13_2(L14_2)
              if 99 == L13_2 then
                L13_2 = GetInteriorPlayerIsIn
                L14_2 = L5_2
                L13_2 = L13_2(L14_2)
                if L13_2 == L12_2 then
                  L13_2 = util
                  L13_2 = L13_2.draw_debug_text
                  L14_2 = players
                  L14_2 = L14_2.get_name
                  L15_2 = L5_2
                  L14_2 = L14_2(L15_2)
                  L15_2 = " 是无敌模式"
                  L14_2 = L14_2 .. L15_2
                  L13_2(L14_2)
                  break
                end
              end
            end
          end
        end
      end
    end
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "car_god_detection"
function L62_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L0_2 = ipairs
  L1_2 = players
  L1_2 = L1_2.list
  L2_2 = false
  L3_2 = true
  L4_2 = true
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L1_2(L2_2, L3_2, L4_2)
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = PLAYER
    L6_2 = L6_2.GET_PLAYER_PED_SCRIPT_INDEX
    L7_2 = L5_2
    L6_2 = L6_2(L7_2)
    L7_2 = ENTITY
    L7_2 = L7_2.GET_ENTITY_COORDS
    L8_2 = L6_2
    L9_2 = false
    L7_2 = L7_2(L8_2, L9_2)
    L8_2 = PED
    L8_2 = L8_2.GET_VEHICLE_PED_IS_USING
    L9_2 = L6_2
    L8_2 = L8_2(L9_2)
    L9_2 = PED
    L9_2 = L9_2.IS_PED_IN_ANY_VEHICLE
    L10_2 = L6_2
    L11_2 = false
    L9_2 = L9_2(L10_2, L11_2)
    if L9_2 then
      L9_2 = ipairs
      L10_2 = interior_stuff
      L9_2, L10_2, L11_2, L12_2 = L9_2(L10_2)
      for L13_2, L14_2 in L9_2, L10_2, L11_2, L12_2 do
        L15_2 = ENTITY
        L15_2 = L15_2.GET_ENTITY_CAN_BE_DAMAGED
        L16_2 = L8_2
        L15_2 = L15_2(L16_2)
        if not L15_2 then
          L15_2 = NETWORK
          L15_2 = L15_2.NETWORK_IS_PLAYER_FADING
          L16_2 = L5_2
          L15_2 = L15_2(L16_2)
          if not L15_2 then
            L15_2 = ENTITY
            L15_2 = L15_2.IS_ENTITY_VISIBLE
            L16_2 = L6_2
            L15_2 = L15_2(L16_2)
            if L15_2 then
              L15_2 = get_transition_state
              L16_2 = L5_2
              L15_2 = L15_2(L16_2)
              if 99 == L15_2 then
                L15_2 = get_interior_player_is_in
                L16_2 = L5_2
                L15_2 = L15_2(L16_2)
                if L15_2 == L14_2 then
                  L15_2 = util
                  L15_2 = L15_2.draw_debug_text
                  L16_2 = players
                  L16_2 = L16_2.get_name
                  L17_2 = L5_2
                  L16_2 = L16_2(L17_2)
                  L17_2 = "载具处于无敌模式"
                  L16_2 = L16_2 .. L17_2
                  L15_2(L16_2)
                  break
                end
              end
            end
          end
        end
      end
    end
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "unreleased_car_detection"
function L62_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L0_2 = ipairs
  L1_2 = players
  L1_2 = L1_2.list
  L2_2 = false
  L3_2 = true
  L4_2 = true
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L1_2(L2_2, L3_2, L4_2)
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = players
    L6_2 = L6_2.get_vehicle_model
    L7_2 = L5_2
    L6_2 = L6_2(L7_2)
    L7_2 = ipairs
    L8_2 = unreleased_vehicles
    L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
    for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
      L13_2 = util
      L13_2 = L13_2.joaat
      L14_2 = L12_2
      L13_2 = L13_2(L14_2)
      if L6_2 == L13_2 then
        L13_2 = util
        L13_2 = L13_2.draw_debug_text
        L14_2 = players
        L14_2 = L14_2.get_name
        L15_2 = L5_2
        L14_2 = L14_2(L15_2)
        L15_2 = "正在驾驶未发布的车辆"
        L14_2 = L14_2 .. L15_2
        L13_2(L14_2)
      end
    end
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "cantgetweapon_detection"
function L62_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L0_2 = ipairs
  L1_2 = players
  L1_2 = L1_2.list
  L2_2 = false
  L3_2 = true
  L4_2 = true
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L1_2(L2_2, L3_2, L4_2)
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = PLAYER
    L6_2 = L6_2.GET_PLAYER_PED_SCRIPT_INDEX
    L7_2 = L5_2
    L6_2 = L6_2(L7_2)
    L7_2 = ipairs
    L8_2 = modded_weapons
    L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
    for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
      L13_2 = util
      L13_2 = L13_2.joaat
      L14_2 = L12_2
      L13_2 = L13_2(L14_2)
      L14_2 = WEAPON
      L14_2 = L14_2.HAS_PED_GOT_WEAPON
      L15_2 = L6_2
      L16_2 = L13_2
      L17_2 = false
      L14_2 = L14_2(L15_2, L16_2, L17_2)
      if L14_2 then
        L14_2 = WEAPON
        L14_2 = L14_2.IS_PED_ARMED
        L15_2 = L6_2
        L16_2 = 7
        L14_2 = L14_2(L15_2, L16_2)
        if L14_2 then
          L14_2 = util
          L14_2 = L14_2.draw_debug_text
          L15_2 = players
          L15_2 = L15_2.get_name
          L16_2 = L5_2
          L15_2 = L15_2(L16_2)
          L16_2 = "正在使用无法获得武器"
          L15_2 = L15_2 .. L16_2
          L14_2(L15_2)
          break
        end
      end
    end
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "cantgetvar_detection"
function L62_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L0_2 = ipairs
  L1_2 = players
  L1_2 = L1_2.list
  L2_2 = false
  L3_2 = true
  L4_2 = true
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L1_2(L2_2, L3_2, L4_2)
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = players
    L6_2 = L6_2.get_vehicle_model
    L7_2 = L5_2
    L6_2 = L6_2(L7_2)
    L7_2 = ipairs
    L8_2 = modded_vehicles
    L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
    for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
      L13_2 = util
      L13_2 = L13_2.joaat
      L14_2 = L12_2
      L13_2 = L13_2(L14_2)
      if L6_2 == L13_2 then
        L13_2 = util
        L13_2 = L13_2.draw_debug_text
        L14_2 = players
        L14_2 = L14_2.get_name
        L15_2 = L5_2
        L14_2 = L14_2(L15_2)
        L15_2 = " 正在驾驶无法获得的载具,很有可能是作弊者"
        L14_2 = L14_2 .. L15_2
        L13_2(L14_2)
        break
      end
    end
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "usingweapon_detection"
function L62_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = ipairs
  L1_2 = players
  L1_2 = L1_2.list
  L2_2 = false
  L3_2 = true
  L4_2 = true
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L1_2(L2_2, L3_2, L4_2)
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = PLAYER
    L6_2 = L6_2.GET_PLAYER_PED_SCRIPT_INDEX
    L7_2 = L5_2
    L6_2 = L6_2(L7_2)
    L7_2 = players
    L7_2 = L7_2.is_in_interior
    L8_2 = L5_2
    L7_2 = L7_2(L8_2)
    if L7_2 then
      L7_2 = WEAPON
      L7_2 = L7_2.IS_PED_ARMED
      L8_2 = L6_2
      L9_2 = 7
      L7_2 = L7_2(L8_2, L9_2)
      if L7_2 then
        L7_2 = util
        L7_2 = L7_2.draw_debug_text
        L8_2 = players
        L8_2 = L8_2.get_name
        L9_2 = L5_2
        L8_2 = L8_2(L9_2)
        L9_2 = " 正在室内使用武器,极大可能是作弊者"
        L8_2 = L8_2 .. L9_2
        L7_2(L8_2)
        break
      end
    end
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "supercar_detection"
function L62_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L0_2 = ipairs
  L1_2 = players
  L1_2 = L1_2.list
  L2_2 = false
  L3_2 = true
  L4_2 = true
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L1_2(L2_2, L3_2, L4_2)
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = PLAYER
    L6_2 = L6_2.GET_PLAYER_PED_SCRIPT_INDEX
    L7_2 = L5_2
    L6_2 = L6_2(L7_2)
    L7_2 = PED
    L7_2 = L7_2.GET_VEHICLE_PED_IS_USING
    L8_2 = L6_2
    L7_2 = L7_2(L8_2)
    L8_2 = ENTITY
    L8_2 = L8_2.GET_ENTITY_SPEED
    L9_2 = L7_2
    L8_2 = L8_2(L9_2)
    L8_2 = L8_2 * 2.236936
    L9_2 = VEHICLE
    L9_2 = L9_2.GET_VEHICLE_CLASS
    L10_2 = L7_2
    L9_2 = L9_2(L10_2)
    if 15 ~= L9_2 and 16 ~= L9_2 then
      L10_2 = 180
      if L8_2 >= L10_2 then
        L10_2 = VEHICLE
        L10_2 = L10_2.GET_PED_IN_VEHICLE_SEAT
        L11_2 = L7_2
        L12_2 = -1
        L10_2 = L10_2(L11_2, L12_2)
        if L10_2 then
          L10_2 = players
          L10_2 = L10_2.get_vehicle_model
          L11_2 = L5_2
          L10_2 = L10_2(L11_2)
          L11_2 = util
          L11_2 = L11_2.joaat
          L12_2 = "oppressor"
          L11_2 = L11_2(L12_2)
          if L10_2 == L11_2 then
            L10_2 = players
            L10_2 = L10_2.get_vehicle_model
            L11_2 = L5_2
            L10_2 = L10_2(L11_2)
            L11_2 = util
            L11_2 = L11_2.joaat
            L12_2 = "oppressor2"
            L11_2 = L11_2(L12_2)
            if L10_2 == L11_2 then
              goto lbl_72
            end
          end
          L10_2 = util
          L10_2 = L10_2.toast
          L11_2 = players
          L11_2 = L11_2.get_name
          L12_2 = L5_2
          L11_2 = L11_2(L12_2)
          L12_2 = " 正在使用超级驾驶"
          L11_2 = L11_2 .. L12_2
          L10_2(L11_2)
          break
        end
      end
    end
    ::lbl_72::
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "superrun_detection"
function L62_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L0_2 = ipairs
  L1_2 = players
  L1_2 = L1_2.list
  L2_2 = true
  L3_2 = true
  L4_2 = true
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L1_2(L2_2, L3_2, L4_2)
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = PLAYER
    L6_2 = L6_2.GET_PLAYER_PED_SCRIPT_INDEX
    L7_2 = L5_2
    L6_2 = L6_2(L7_2)
    L7_2 = ENTITY
    L7_2 = L7_2.GET_ENTITY_SPEED
    L8_2 = L6_2
    L7_2 = L7_2(L8_2)
    L7_2 = L7_2 * 2.236936
    L8_2 = util
    L8_2 = L8_2.is_session_transition_active
    L8_2 = L8_2()
    if not L8_2 then
      L8_2 = get_interior_player_is_in
      L9_2 = L5_2
      L8_2 = L8_2(L9_2)
      if 0 == L8_2 then
        L8_2 = get_transition_state
        L9_2 = L5_2
        L8_2 = L8_2(L9_2)
        if 0 ~= L8_2 then
          L8_2 = NETWORK
          L8_2 = L8_2.NETWORK_IS_PLAYER_FADING
          L9_2 = L5_2
          L8_2 = L8_2(L9_2)
          if not L8_2 then
            L8_2 = ENTITY
            L8_2 = L8_2.IS_ENTITY_VISIBLE
            L9_2 = L6_2
            L8_2 = L8_2(L9_2)
            if L8_2 then
              L8_2 = PED
              L8_2 = L8_2.IS_PED_IN_ANY_VEHICLE
              L9_2 = L6_2
              L10_2 = false
              L8_2 = L8_2(L9_2, L10_2)
              if not L8_2 then
                L8_2 = TASK
                L8_2 = L8_2.IS_PED_STILL
                L9_2 = L6_2
                L8_2 = L8_2(L9_2)
                if not L8_2 then
                  L8_2 = PED
                  L8_2 = L8_2.IS_PED_JUMPING
                  L9_2 = L6_2
                  L8_2 = L8_2(L9_2)
                  if not L8_2 then
                    L8_2 = ENTITY
                    L8_2 = L8_2.IS_ENTITY_IN_AIR
                    L9_2 = L6_2
                    L8_2 = L8_2(L9_2)
                    if not L8_2 then
                      L8_2 = PED
                      L8_2 = L8_2.IS_PED_CLIMBING
                      L9_2 = L6_2
                      L8_2 = L8_2(L9_2)
                      if not L8_2 then
                        L8_2 = PED
                        L8_2 = L8_2.IS_PED_VAULTING
                        L9_2 = L6_2
                        L8_2 = L8_2(L9_2)
                        if not L8_2 then
                          L8_2 = v3
                          L8_2 = L8_2.distance
                          L9_2 = ENTITY
                          L9_2 = L9_2.GET_ENTITY_COORDS
                          L10_2 = PLAYER
                          L10_2 = L10_2.PLAYER_PED_ID
                          L10_2 = L10_2()
                          L11_2 = false
                          L9_2 = L9_2(L10_2, L11_2)
                          L10_2 = players
                          L10_2 = L10_2.get_position
                          L11_2 = L5_2
                          L10_2, L11_2 = L10_2(L11_2)
                          L8_2 = L8_2(L9_2, L10_2, L11_2)
                          L9_2 = 300.0
                          if L8_2 <= L9_2 and L7_2 > 25 then
                            L8_2 = util
                            L8_2 = L8_2.toast
                            L9_2 = players
                            L9_2 = L9_2.get_name
                            L10_2 = L5_2
                            L9_2 = L9_2(L10_2)
                            L10_2 = " 是超级跑"
                            L9_2 = L9_2 .. L10_2
                            L8_2(L9_2)
                            break
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "lookingyou_detection"
function L62_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L0_2 = ipairs
  L1_2 = players
  L1_2 = L1_2.list
  L2_2 = false
  L3_2 = true
  L4_2 = true
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L1_2(L2_2, L3_2, L4_2)
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = PLAYER
    L6_2 = L6_2.GET_PLAYER_PED_SCRIPT_INDEX
    L7_2 = L5_2
    L6_2 = L6_2(L7_2)
    L7_2 = v3
    L7_2 = L7_2.distance
    L8_2 = players
    L8_2 = L8_2.get_position
    L9_2 = PLAYER
    L9_2 = L9_2.PLAYER_ID
    L9_2, L10_2, L11_2 = L9_2()
    L8_2 = L8_2(L9_2, L10_2, L11_2)
    L9_2 = players
    L9_2 = L9_2.get_cam_pos
    L10_2 = L5_2
    L9_2, L10_2, L11_2 = L9_2(L10_2)
    L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2)
    L8_2 = v3
    L8_2 = L8_2.distance
    L9_2 = players
    L9_2 = L9_2.get_position
    L10_2 = PLAYER
    L10_2 = L10_2.PLAYER_ID
    L10_2, L11_2 = L10_2()
    L9_2 = L9_2(L10_2, L11_2)
    L10_2 = players
    L10_2 = L10_2.get_position
    L11_2 = L5_2
    L10_2, L11_2 = L10_2(L11_2)
    L8_2 = L8_2(L9_2, L10_2, L11_2)
    if L7_2 < 20.0 then
      L9_2 = PED
      L9_2 = L9_2.IS_PED_DEAD_OR_DYING
      L10_2 = L6_2
      L9_2 = L9_2(L10_2)
      if not L9_2 then
        L9_2 = NETWORK
        L9_2 = L9_2.NETWORK_IS_PLAYER_FADING
        L10_2 = L5_2
        L9_2 = L9_2(L10_2)
        if not L9_2 then
          L9_2 = PLAYER
          L9_2 = L9_2.PLAYER_ID
          L9_2 = L9_2()
          if L5_2 ~= L9_2 then
            goto lbl_68
          end
        end
      end
    end
    L9_2 = players
    L9_2 = L9_2.get_spectate_target
    L10_2 = L5_2
    L9_2 = L9_2(L10_2)
    L10_2 = PLAYER
    L10_2 = L10_2.PLAYER_ID
    L10_2 = L10_2()
    ::lbl_68::
    if L9_2 == L10_2 then
      L9_2 = yield
      L10_2 = 1000
      L9_2(L10_2)
      if not (L8_2 > 35.0) then
        L9_2 = players
        L9_2 = L9_2.get_spectate_target
        L10_2 = L5_2
        L9_2 = L9_2(L10_2)
        L10_2 = PLAYER
        L10_2 = L10_2.PLAYER_ID
        L10_2 = L10_2()
        if L9_2 ~= L10_2 then
          goto lbl_104
        end
      end
      L9_2 = players
      L9_2 = L9_2.get_name
      L10_2 = L5_2
      L9_2 = L9_2(L10_2)
      if "UndiscoveredPlayer" ~= L9_2 then
        L9_2 = PED
        L9_2 = L9_2.IS_PED_DEAD_OR_DYING
        L10_2 = L6_2
        L9_2 = L9_2(L10_2)
        if not L9_2 then
          L9_2 = util
          L9_2 = L9_2.toast
          L10_2 = players
          L10_2 = L10_2.get_name
          L11_2 = L5_2
          L10_2 = L10_2(L11_2)
          L11_2 = " 正在观看你"
          L10_2 = L10_2 .. L11_2
          L9_2(L10_2)
          break
        end
      end
    end
    ::lbl_104::
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "tp_detection"
function L62_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L0_2 = ipairs
  L1_2 = players
  L1_2 = L1_2.list
  L2_2 = false
  L3_2 = true
  L4_2 = true
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L1_2(L2_2, L3_2, L4_2)
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = PLAYER
    L6_2 = L6_2.GET_PLAYER_PED_SCRIPT_INDEX
    L7_2 = L5_2
    L6_2 = L6_2(L7_2)
    L7_2 = NETWORK
    L7_2 = L7_2.NETWORK_IS_PLAYER_FADING
    L8_2 = L5_2
    L7_2 = L7_2(L8_2)
    if not L7_2 then
      L7_2 = ENTITY
      L7_2 = L7_2.IS_ENTITY_VISIBLE
      L8_2 = L6_2
      L7_2 = L7_2(L8_2)
      if L7_2 then
        L7_2 = PED
        L7_2 = L7_2.IS_PED_DEAD_OR_DYING
        L8_2 = L6_2
        L7_2 = L7_2(L8_2)
        if not L7_2 then
          L7_2 = players
          L7_2 = L7_2.get_position
          L8_2 = L5_2
          L7_2 = L7_2(L8_2)
          L8_2 = util
          L8_2 = L8_2.yield
          L9_2 = 1000
          L8_2(L9_2)
          L8_2 = players
          L8_2 = L8_2.get_position
          L9_2 = L5_2
          L8_2 = L8_2(L9_2)
          L9_2 = ipairs
          L10_2 = interior_stuff
          L9_2, L10_2, L11_2, L12_2 = L9_2(L10_2)
          for L13_2, L14_2 in L9_2, L10_2, L11_2, L12_2 do
            L15_2 = v3
            L15_2 = L15_2.distance
            L16_2 = L7_2
            L17_2 = L8_2
            L15_2 = L15_2(L16_2, L17_2)
            L16_2 = 500
            if L15_2 > L16_2 then
              L15_2 = L7_2.x
              L16_2 = L8_2.x
              if L15_2 ~= L16_2 then
                L15_2 = L7_2.y
                L16_2 = L8_2.y
                if L15_2 ~= L16_2 then
                  L15_2 = L7_2.z
                  L16_2 = L8_2.z
                  if L15_2 ~= L16_2 then
                    L15_2 = get_transition_state
                    L16_2 = L5_2
                    L15_2 = L15_2(L16_2)
                    if 0 ~= L15_2 then
                      L15_2 = get_interior_player_is_in
                      L16_2 = L5_2
                      L15_2 = L15_2(L16_2)
                      if L15_2 == L14_2 then
                        L15_2 = PLAYER
                        L15_2 = L15_2.IS_PLAYER_PLAYING
                        L16_2 = L5_2
                        L15_2 = L15_2(L16_2)
                        if L15_2 then
                          L15_2 = players
                          L15_2 = L15_2.exists
                          L16_2 = L5_2
                          L15_2 = L15_2(L16_2)
                          if L15_2 then
                            L15_2 = util
                            L15_2 = L15_2.toast
                            L16_2 = players
                            L16_2 = L16_2.get_name
                            L17_2 = L5_2
                            L16_2 = L16_2(L17_2)
                            L17_2 = " 刚刚进行了传送"
                            L16_2 = L16_2 .. L17_2
                            L15_2(L16_2)
                          end
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "modified_weapon_detection"
function L62_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  L0_2 = ipairs
  L1_2 = players
  L1_2 = L1_2.list
  L2_2 = false
  L3_2 = true
  L4_2 = true
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L1_2(L2_2, L3_2, L4_2)
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = PLAYER
    L6_2 = L6_2.GET_PLAYER_PED_SCRIPT_INDEX
    L7_2 = L5_2
    L6_2 = L6_2(L7_2)
    L7_2 = ipairs
    L8_2 = modded_weapons
    L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
    for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
      L13_2 = util
      L13_2 = L13_2.joaat
      L14_2 = L12_2
      L13_2 = L13_2(L14_2)
      L14_2 = WEAPON
      L14_2 = L14_2.HAS_PED_GOT_WEAPON
      L15_2 = L6_2
      L16_2 = L13_2
      L17_2 = false
      L14_2 = L14_2(L15_2, L16_2, L17_2)
      if L14_2 then
        L14_2 = WEAPON
        L14_2 = L14_2.IS_PED_ARMED
        L15_2 = L6_2
        L16_2 = 7
        L14_2 = L14_2(L15_2, L16_2)
        if not L14_2 then
          L14_2 = TASK
          L14_2 = L14_2.GET_IS_TASK_ACTIVE
          L15_2 = L6_2
          L16_2 = 8
          L14_2 = L14_2(L15_2, L16_2)
          if not L14_2 then
            L14_2 = TASK
            L14_2 = L14_2.GET_IS_TASK_ACTIVE
            L15_2 = L6_2
            L16_2 = 9
            L14_2 = L14_2(L15_2, L16_2)
            if not L14_2 then
              goto lbl_64
            end
          end
        end
        L14_2 = util
        L14_2 = L14_2.toast
        L15_2 = players
        L15_2 = L15_2.get_name
        L16_2 = L5_2
        L15_2 = L15_2(L16_2)
        L16_2 = " 使用修改过的武器 "
        L17_2 = "("
        L18_2 = L12_2
        L19_2 = ")"
        L15_2 = L15_2 .. L16_2 .. L17_2 .. L18_2 .. L19_2
        L14_2(L15_2)
        break
      end
      ::lbl_64::
    end
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "modified_vehicles_detection"
function L62_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L0_2 = ipairs
  L1_2 = players
  L1_2 = L1_2.list
  L2_2 = false
  L3_2 = true
  L4_2 = true
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L1_2(L2_2, L3_2, L4_2)
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = players
    L6_2 = L6_2.get_vehicle_model
    L7_2 = L5_2
    L6_2 = L6_2(L7_2)
    L7_2 = ipairs
    L8_2 = modded_vehicles
    L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
    for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
      L13_2 = util
      L13_2 = L13_2.joaat
      L14_2 = L12_2
      L13_2 = L13_2(L14_2)
      if L6_2 == L13_2 then
        L13_2 = util
        L13_2 = L13_2.draw_debug_text
        L14_2 = players
        L14_2 = L14_2.get_name
        L15_2 = L5_2
        L14_2 = L14_2(L15_2)
        L15_2 = " 正在驾驶改装载具"
        L14_2 = L14_2 .. L15_2
        L13_2(L14_2)
        break
      end
    end
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "roundDecimals"
function L62_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = 10
  A1_2 = L2_2 ^ A1_2
  L2_2 = math
  L2_2 = L2_2.floor
  L3_2 = A0_2 * A1_2
  L2_2 = L2_2(L3_2)
  L2_2 = L2_2 / A1_2
  return L2_2
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "toggle_player_vehicle_engine"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = PED
  L2_2 = L2_2.GET_VEHICLE_PED_IS_IN
  L3_2 = L1_2
  L4_2 = _ENV
  L5_2 = "include_last_vehicle_for_player_functions"
  L4_2 = L4_2[L5_2]
  L2_2 = L2_2(L3_2, L4_2)
  if 0 == L2_2 then
    L3_2 = util
    L3_2 = L3_2.toast
    L4_2 = players
    L4_2 = L4_2.get_name
    L5_2 = A0_2
    L4_2 = L4_2(L5_2)
    L5_2 = "不在车里:D"
    L4_2 = L4_2 .. L5_2
    L3_2(L4_2)
  else
    L3_2 = VEHICLE
    L3_2 = L3_2.GET_IS_VEHICLE_ENGINE_RUNNING
    L4_2 = L2_2
    L3_2 = L3_2(L4_2)
    L4_2 = request_control
    L5_2 = L2_2
    L4_2 = L4_2(L5_2)
    if L4_2 then
      L4_2 = VEHICLE
      L4_2 = L4_2.SET_VEHICLE_ENGINE_ON
      L5_2 = L2_2
      L6_2 = not L3_2
      L7_2 = true
      L8_2 = true
      L4_2(L5_2, L6_2, L7_2, L8_2)
      L4_2 = util
      L4_2 = L4_2.toast
      L5_2 = players
      L5_2 = L5_2.get_name
      L6_2 = A0_2
      L5_2 = L5_2(L6_2)
      L6_2 = "发动机已切换"
      L5_2 = L5_2 .. L6_2
      L4_2(L5_2)
    else
      L4_2 = util
      L4_2 = L4_2.toast
      L5_2 = "无法控制车辆."
      L4_2(L5_2)
    end
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "break_player_vehicle_engine"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = PED
  L2_2 = L2_2.GET_VEHICLE_PED_IS_IN
  L3_2 = L1_2
  L4_2 = _ENV
  L5_2 = "include_last_vehicle_for_player_functions"
  L4_2 = L4_2[L5_2]
  L2_2 = L2_2(L3_2, L4_2)
  if 0 == L2_2 then
    L3_2 = util
    L3_2 = L3_2.toast
    L4_2 = players
    L4_2 = L4_2.get_name
    L5_2 = A0_2
    L4_2 = L4_2(L5_2)
    L5_2 = "不在车里:D"
    L4_2 = L4_2 .. L5_2
    L3_2(L4_2)
  else
    L3_2 = request_control
    L4_2 = L2_2
    L3_2 = L3_2(L4_2)
    if L3_2 then
      L3_2 = VEHICLE
      L3_2 = L3_2.SET_VEHICLE_ENGINE_HEALTH
      L4_2 = L2_2
      L5_2 = -10.0
      L3_2(L4_2, L5_2)
      L3_2 = util
      L3_2 = L3_2.toast
      L4_2 = players
      L4_2 = L4_2.get_name
      L5_2 = A0_2
      L4_2 = L4_2(L5_2)
      L5_2 = "他的引擎坏了"
      L4_2 = L4_2 .. L5_2
      L3_2(L4_2)
    else
      L3_2 = util
      L3_2 = L3_2.toast
      L4_2 = "无法控制他们的车辆"
      L3_2(L4_2)
    end
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "boost_player_vehicle_forward"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = PED
  L2_2 = L2_2.GET_VEHICLE_PED_IS_IN
  L3_2 = L1_2
  L4_2 = _ENV
  L5_2 = "include_last_vehicle_for_player_functions"
  L4_2 = L4_2[L5_2]
  L2_2 = L2_2(L3_2, L4_2)
  if 0 == L2_2 then
    L3_2 = util
    L3_2 = L3_2.toast
    L4_2 = players
    L4_2 = L4_2.get_name
    L5_2 = A0_2
    L4_2 = L4_2(L5_2)
    L5_2 = "不在车里:D"
    L4_2 = L4_2 .. L5_2
    L3_2(L4_2)
  else
    L3_2 = request_control
    L4_2 = L2_2
    L3_2(L4_2)
    L3_2 = ENTITY
    L3_2 = L3_2.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
    L4_2 = L2_2
    L5_2 = 1
    L6_2 = 0.0
    L7_2 = 1000.0
    L8_2 = 0.0
    L9_2 = true
    L10_2 = true
    L11_2 = true
    L12_2 = true
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
    L3_2 = util
    L3_2 = L3_2.toast
    L4_2 = players
    L4_2 = L4_2.get_name
    L5_2 = A0_2
    L4_2 = L4_2(L5_2)
    L5_2 = "车辆猛冲"
    L4_2 = L4_2 .. L5_2
    L3_2(L4_2)
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "stop_player_vehicle"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = PED
  L2_2 = L2_2.GET_VEHICLE_PED_IS_IN
  L3_2 = L1_2
  L4_2 = _ENV
  L5_2 = "include_last_vehicle_for_player_functions"
  L4_2 = L4_2[L5_2]
  L2_2 = L2_2(L3_2, L4_2)
  if 0 == L2_2 then
    L3_2 = util
    L3_2 = L3_2.toast
    L4_2 = players
    L4_2 = L4_2.get_name
    L5_2 = A0_2
    L4_2 = L4_2(L5_2)
    L5_2 = "不在车里:D"
    L4_2 = L4_2 .. L5_2
    L3_2(L4_2)
  else
    L3_2 = request_control
    L4_2 = L2_2
    L3_2(L4_2)
    L3_2 = VEHICLE
    L3_2 = L3_2.BRING_VEHICLE_TO_HALT
    L4_2 = L2_2
    L5_2 = 0.0
    L6_2 = 1
    L7_2 = false
    L3_2(L4_2, L5_2, L6_2, L7_2)
    L3_2 = util
    L3_2 = L3_2.toast
    L4_2 = players
    L4_2 = L4_2.get_name
    L5_2 = A0_2
    L4_2 = L4_2(L5_2)
    L5_2 = "车辆停止"
    L4_2 = L4_2 .. L5_2
    L3_2(L4_2)
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "flip_player_vehicle"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = PED
  L2_2 = L2_2.GET_VEHICLE_PED_IS_IN
  L3_2 = L1_2
  L4_2 = _ENV
  L5_2 = "include_last_vehicle_for_player_functions"
  L4_2 = L4_2[L5_2]
  L2_2 = L2_2(L3_2, L4_2)
  if 0 == L2_2 then
    L3_2 = util
    L3_2 = L3_2.toast
    L4_2 = players
    L4_2 = L4_2.get_name
    L5_2 = A0_2
    L4_2 = L4_2(L5_2)
    L5_2 = "不在车里:D"
    L4_2 = L4_2 .. L5_2
    L3_2(L4_2)
  else
    L3_2 = request_control
    L4_2 = L2_2
    L3_2(L4_2)
    L3_2 = ENTITY
    L3_2 = L3_2.GET_ENTITY_HEADING
    L4_2 = L2_2
    L3_2 = L3_2(L4_2)
    L4_2 = ENTITY
    L4_2 = L4_2.SET_ENTITY_ROTATION
    L5_2 = L2_2
    L6_2 = 0
    L7_2 = 180
    L8_2 = -L3_2
    L9_2 = 1
    L10_2 = true
    L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
    L4_2 = util
    L4_2 = L4_2.toast
    L5_2 = players
    L5_2 = L5_2.get_name
    L6_2 = A0_2
    L5_2 = L5_2(L6_2)
    L6_2 = "车辆翻转"
    L5_2 = L5_2 .. L6_2
    L4_2(L5_2)
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "turn_player_vehicle"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = PED
  L2_2 = L2_2.GET_VEHICLE_PED_IS_IN
  L3_2 = L1_2
  L4_2 = _ENV
  L5_2 = "include_last_vehicle_for_player_functions"
  L4_2 = L4_2[L5_2]
  L2_2 = L2_2(L3_2, L4_2)
  if 0 == L2_2 then
    L3_2 = util
    L3_2 = L3_2.toast
    L4_2 = players
    L4_2 = L4_2.get_name
    L5_2 = A0_2
    L4_2 = L4_2(L5_2)
    L5_2 = "不在车里:D"
    L4_2 = L4_2 .. L5_2
    L3_2(L4_2)
  else
    L3_2 = request_control
    L4_2 = L2_2
    L3_2(L4_2)
    L3_2 = ENTITY
    L3_2 = L3_2.GET_ENTITY_HEADING
    L4_2 = L2_2
    L3_2 = L3_2(L4_2)
    L4_2 = 180
    if L3_2 >= L4_2 then
      L4_2 = L3_2 - 180
      if L4_2 then
        goto lbl_40
      end
    end
    L4_2 = L3_2 + 180
    ::lbl_40::
    L5_2 = ENTITY
    L5_2 = L5_2.SET_ENTITY_ROTATION
    L6_2 = L2_2
    L7_2 = 0
    L8_2 = 0
    L9_2 = L4_2
    L10_2 = 2
    L11_2 = true
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    L5_2 = util
    L5_2 = L5_2.toast
    L6_2 = players
    L6_2 = L6_2.get_name
    L7_2 = A0_2
    L6_2 = L6_2(L7_2)
    L7_2 = "车辆转弯"
    L6_2 = L6_2 .. L7_2
    L5_2(L6_2)
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "repair_player_vehicle"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = PED
  L2_2 = L2_2.GET_VEHICLE_PED_IS_IN
  L3_2 = L1_2
  L4_2 = _ENV
  L5_2 = "include_last_vehicle_for_player_functions"
  L4_2 = L4_2[L5_2]
  L2_2 = L2_2(L3_2, L4_2)
  if 0 == L2_2 then
    L3_2 = util
    L3_2 = L3_2.toast
    L4_2 = players
    L4_2 = L4_2.get_name
    L5_2 = A0_2
    L4_2 = L4_2(L5_2)
    L5_2 = " 不在车里:D"
    L4_2 = L4_2 .. L5_2
    L3_2(L4_2)
  else
    L3_2 = request_control
    L4_2 = L2_2
    L3_2 = L3_2(L4_2)
    if L3_2 then
      L3_2 = VEHICLE
      L3_2 = L3_2.SET_VEHICLE_FIXED
      L4_2 = L2_2
      L3_2(L4_2)
      L3_2 = util
      L3_2 = L3_2.toast
      L4_2 = players
      L4_2 = L4_2.get_name
      L5_2 = A0_2
      L4_2 = L4_2(L5_2)
      L5_2 = "修理完成"
      L4_2 = L4_2 .. L5_2
      L3_2(L4_2)
    else
      L3_2 = util
      L3_2 = L3_2.toast
      L4_2 = "无法控制车辆"
      L3_2(L4_2)
    end
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "launch_up_player_vehicle"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = PED
  L2_2 = L2_2.GET_VEHICLE_PED_IS_IN
  L3_2 = L1_2
  L4_2 = _ENV
  L5_2 = "include_last_vehicle_for_player_functions"
  L4_2 = L4_2[L5_2]
  L2_2 = L2_2(L3_2, L4_2)
  if 0 == L2_2 then
    L3_2 = util
    L3_2 = L3_2.toast
    L4_2 = players
    L4_2 = L4_2.get_name
    L5_2 = A0_2
    L4_2 = L4_2(L5_2)
    L5_2 = " 不在车中:D"
    L4_2 = L4_2 .. L5_2
    L3_2(L4_2)
  else
    L3_2 = request_control
    L4_2 = L2_2
    L3_2 = L3_2(L4_2)
    if L3_2 then
      L3_2 = ENTITY
      L3_2 = L3_2.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
      L4_2 = L2_2
      L5_2 = 1
      L6_2 = 0.0
      L7_2 = 0.0
      L8_2 = 1000.0
      L9_2 = true
      L10_2 = true
      L11_2 = true
      L12_2 = true
      L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
      L3_2 = util
      L3_2 = L3_2.toast
      L4_2 = players
      L4_2 = L4_2.get_name
      L5_2 = A0_2
      L4_2 = L4_2(L5_2)
      L5_2 = "'已发射."
      L4_2 = L4_2 .. L5_2
      L3_2(L4_2)
    else
      L3_2 = util
      L3_2 = L3_2.toast
      L4_2 = "无法控制车辆"
      L3_2(L4_2)
    end
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "Demon_veh"
function L62_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2
  glitchVeh = A1_2
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = ENTITY
  L3_2 = L3_2.GET_ENTITY_COORDS
  L4_2 = L2_2
  L5_2 = false
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = PED
  L4_2 = L4_2.GET_VEHICLE_PED_IS_USING
  L5_2 = L2_2
  L4_2 = L4_2(L5_2)
  L5_2 = players
  L5_2 = L5_2.get_vehicle_model
  L6_2 = A0_2
  L5_2 = L5_2(L6_2)
  L6_2 = util
  L6_2 = L6_2.joaat
  L7_2 = "a_m_m_acult_01"
  L6_2 = L6_2(L7_2)
  L7_2 = util
  L7_2 = L7_2.joaat
  L8_2 = "prop_ld_ferris_wheel"
  L7_2 = L7_2(L8_2)
  L8_2 = request_model
  L9_2 = L6_2
  L8_2(L9_2)
  L8_2 = request_model
  L9_2 = L7_2
  L8_2(L9_2)
  while true do
    L8_2 = glitchVeh
    if not L8_2 then
      break
    end
    L8_2 = v3
    L8_2 = L8_2.distance
    L9_2 = ENTITY
    L9_2 = L9_2.GET_ENTITY_COORDS
    L10_2 = PLAYER
    L10_2 = L10_2.PLAYER_PED_ID
    L10_2 = L10_2()
    L11_2 = false
    L9_2 = L9_2(L10_2, L11_2)
    L10_2 = players
    L10_2 = L10_2.get_position
    L11_2 = A0_2
    L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2 = L10_2(L11_2)
    L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2)
    L9_2 = 1000.0
    if L8_2 > L9_2 then
      L8_2 = v3
      L8_2 = L8_2.distance
      L9_2 = L3_2
      L10_2 = players
      L10_2 = L10_2.get_cam_pos
      L11_2 = PLAYER
      L11_2 = L11_2.PLAYER_ID
      L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2 = L11_2()
      L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2 = L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2)
      L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2)
      L9_2 = 1000.0
      if L8_2 > L9_2 then
        L8_2 = util
        L8_2 = L8_2.toast
        L9_2 = "距离玩家太远了:/"
        L8_2(L9_2)
        L8_2 = menu
        L8_2 = L8_2.set_value
        L9_2 = glitchVehCmd
        L10_2 = false
        L8_2(L9_2, L10_2)
        break
      end
    end
    L8_2 = PED
    L8_2 = L8_2.IS_PED_IN_VEHICLE
    L9_2 = L2_2
    L10_2 = L4_2
    L11_2 = false
    L8_2 = L8_2(L9_2, L10_2, L11_2)
    if not L8_2 then
      L8_2 = util
      L8_2 = L8_2.toast
      L9_2 = "玩家不在车里"
      L8_2(L9_2)
      L8_2 = menu
      L8_2 = L8_2.set_value
      L9_2 = glitchVehCmd
      L10_2 = false
      L8_2(L9_2, L10_2)
      break
    end
    L8_2 = VEHICLE
    L8_2 = L8_2.ARE_ANY_VEHICLE_SEATS_FREE
    L9_2 = L4_2
    L8_2 = L8_2(L9_2)
    if not L8_2 then
      L8_2 = util
      L8_2 = L8_2.toast
      L9_2 = "车上没空位了"
      L8_2(L9_2)
      L8_2 = menu
      L8_2 = L8_2.set_value
      L9_2 = glitchVehCmd
      L10_2 = false
      L8_2(L9_2, L10_2)
      break
    end
    L8_2 = VEHICLE
    L8_2 = L8_2.GET_VEHICLE_MODEL_NUMBER_OF_SEATS
    L9_2 = L5_2
    L8_2 = L8_2(L9_2)
    L9_2 = entities
    L9_2 = L9_2.create_object
    L10_2 = L7_2
    L11_2 = L3_2
    L9_2 = L9_2(L10_2, L11_2)
    L10_2 = entities
    L10_2 = L10_2.create_ped
    L11_2 = 26
    L12_2 = L6_2
    L13_2 = L3_2
    L14_2 = 0
    L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2)
    L11_2 = {}
    L12_2 = L10_2
    L13_2 = L9_2
    L11_2[1] = L12_2
    L11_2[2] = L13_2
    L12_2 = NETWORK
    L12_2 = L12_2.NETWORK_REQUEST_CONTROL_OF_ENTITY
    L13_2 = L9_2
    L12_2(L13_2)
    L12_2 = NETWORK
    L12_2 = L12_2.NETWORK_REQUEST_CONTROL_OF_ENTITY
    L13_2 = L10_2
    L12_2(L13_2)
    L12_2 = ENTITY
    L12_2 = L12_2.ATTACH_ENTITY_TO_ENTITY
    L13_2 = L9_2
    L14_2 = L10_2
    L15_2 = 0
    L16_2 = 0
    L17_2 = 0
    L18_2 = 0
    L19_2 = 0
    L20_2 = 0
    L21_2 = 0
    L22_2 = true
    L23_2 = true
    L24_2 = false
    L25_2 = 0
    L26_2 = true
    L27_2 = 0
    L12_2(L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2)
    L12_2 = ipairs
    L13_2 = L11_2
    L12_2, L13_2, L14_2, L15_2 = L12_2(L13_2)
    for L16_2, L17_2 in L12_2, L13_2, L14_2, L15_2 do
      L18_2 = NETWORK
      L18_2 = L18_2.NETWORK_REQUEST_CONTROL_OF_ENTITY
      L19_2 = L17_2
      L18_2(L19_2)
      L18_2 = ENTITY
      L18_2 = L18_2.SET_ENTITY_VISIBLE
      L19_2 = L17_2
      L20_2 = false
      L18_2(L19_2, L20_2)
      L18_2 = ENTITY
      L18_2 = L18_2.SET_ENTITY_INVINCIBLE
      L19_2 = L17_2
      L20_2 = true
      L18_2(L19_2, L20_2)
    end
    L12_2 = 0
    L13_2 = L8_2 - 1
    L14_2 = 1
    for L15_2 = L12_2, L13_2, L14_2 do
      L16_2 = VEHICLE
      L16_2 = L16_2.ARE_ANY_VEHICLE_SEATS_FREE
      L17_2 = L4_2
      L16_2 = L16_2(L17_2)
      if L16_2 then
        L16_2 = L15_2
        L17_2 = 1
        L18_2 = 25
        L19_2 = 1
        for L20_2 = L17_2, L18_2, L19_2 do
          L21_2 = PED
          L21_2 = L21_2.SET_PED_INTO_VEHICLE
          L22_2 = L10_2
          L23_2 = L4_2
          L24_2 = L16_2
          L21_2(L22_2, L23_2, L24_2)
          L21_2 = ENTITY
          L21_2 = L21_2.SET_ENTITY_COLLISION
          L22_2 = L9_2
          L23_2 = true
          L24_2 = true
          L21_2(L22_2, L23_2, L24_2)
          L21_2 = util
          L21_2 = L21_2.yield
          L21_2()
        end
      end
    end
    if nil ~= L10_2 then
      L12_2 = delete_entity
      L13_2 = L10_2
      L12_2(L13_2)
    end
    if nil ~= L9_2 then
      L12_2 = delete_entity
      L13_2 = L9_2
      L12_2(L13_2)
    end
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "horn_boost"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = PED
  L2_2 = L2_2.GET_VEHICLE_PED_IS_IN
  L3_2 = L1_2
  L4_2 = false
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = request_control
  L4_2 = L2_2
  L3_2(L4_2)
  L3_2 = VEHICLE
  L3_2 = L3_2.SET_VEHICLE_MOD
  L4_2 = L2_2
  L5_2 = 14
  L6_2 = -1
  L7_2 = false
  L3_2(L4_2, L5_2, L6_2, L7_2)
  L3_2 = AUDIO
  L3_2 = L3_2.IS_HORN_ACTIVE
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  if L3_2 then
    L3_2 = VEHICLE
    L3_2 = L3_2.SET_VEHICLE_ALARM
    L4_2 = L2_2
    L5_2 = false
    L3_2(L4_2, L5_2)
    L3_2 = ENTITY
    L3_2 = L3_2.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
    L4_2 = L2_2
    L5_2 = 1
    L6_2 = 0.0
    L7_2 = 1.0
    L8_2 = 0.0
    L9_2 = true
    L10_2 = true
    L11_2 = true
    L12_2 = true
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "car_jump"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = PED
  L2_2 = L2_2.GET_VEHICLE_PED_IS_IN
  L3_2 = L1_2
  L4_2 = false
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = request_control
  L4_2 = L2_2
  L3_2(L4_2)
  L3_2 = VEHICLE
  L3_2 = L3_2.SET_VEHICLE_MOD
  L4_2 = L2_2
  L5_2 = 14
  L6_2 = -1
  L7_2 = false
  L3_2(L4_2, L5_2, L6_2, L7_2)
  L3_2 = AUDIO
  L3_2 = L3_2.IS_HORN_ACTIVE
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  if L3_2 then
    L3_2 = ENTITY
    L3_2 = L3_2.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
    L4_2 = L2_2
    L5_2 = 1
    L6_2 = 0.0
    L7_2 = 0.0
    L8_2 = 0.7
    L9_2 = true
    L10_2 = true
    L11_2 = true
    L12_2 = true
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "horn_tp"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  horn_boost_tpd = A0_2
  L1_2 = horn_boost_tpd
  if L1_2 then
    L1_2 = "按 ~%s~ 使用传送"
    L2_2 = util
    L2_2 = L2_2.show_corner_help
    L4_2 = L1_2
    L3_2 = L1_2.format
    L5_2 = "INPUT_VEH_HORN"
    L3_2, L4_2, L5_2 = L3_2(L4_2, L5_2)
    L2_2(L3_2, L4_2, L5_2)
    while true do
      L2_2 = horn_boost_tpd
      if not L2_2 then
        break
      end
      L2_2 = PAD
      L2_2 = L2_2.IS_CONTROL_PRESSED
      L3_2 = 0
      L4_2 = 46
      L2_2 = L2_2(L3_2, L4_2)
      if L2_2 then
        L2_2 = tp_closest_vehicle
        L2_2()
        L2_2 = util
        L2_2 = L2_2.yield
        L3_2 = 200
        L2_2(L3_2)
      end
      L2_2 = util
      L2_2 = L2_2.yield
      L2_2()
    end
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "is_player_modder"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = players
  L1_2 = L1_2.is_marked_as_modder
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L1_2 = "已触发作弊者检测"
    if L1_2 then
      goto lbl_11
    end
  end
  L1_2 = " 尚未触发作弊者检测"
  ::lbl_11::
  L2_2 = chat
  L2_2 = L2_2.send_message
  L3_2 = players
  L3_2 = L3_2.get_name
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = L1_2
  L3_2 = L3_2 .. L4_2
  L4_2 = true
  L5_2 = true
  L6_2 = false
  L2_2(L3_2, L4_2, L5_2, L6_2)
end
L60_1[L61_1] = L62_1
L60_1 = false
L61_1 = _ENV
L62_1 = "menu"
L61_1 = L61_1[L62_1]
L62_1 = "ref_by_path"
L61_1 = L61_1[L62_1]
L62_1 = "World>Atmosphere>Clock>Time"
L63_1 = 37
L61_1 = L61_1(L62_1, L63_1)
L62_1 = _ENV
L63_1 = "menu"
L62_1 = L62_1[L63_1]
L63_1 = "ref_by_path"
L62_1 = L62_1[L63_1]
L63_1 = "World>Atmosphere>Clock>Smooth Transition"
L64_1 = 37
L62_1 = L62_1(L63_1, L64_1)
L63_1 = _ENV
L64_1 = "Real_world_time"
function L65_1(A0_2)
  local L1_2, L2_2
  L60_1 = A0_2
  L1_2 = menu
  L1_2 = L1_2.get_value
  L2_2 = L62_1
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L1_2 = menu
    L1_2 = L1_2.trigger_command
    L2_2 = L62_1
    L1_2(L2_2)
  end
  L1_2 = util
  L1_2 = L1_2.create_tick_handler
  function L2_2()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = menu
    L0_3 = L0_3.trigger_command
    L1_3 = L61_1
    L2_3 = os
    L2_3 = L2_3.date
    L3_3 = "%H:%M:%S"
    L2_3, L3_3 = L2_3(L3_3)
    L0_3(L1_3, L2_3, L3_3)
    L0_3 = L60_1
    return L0_3
  end
  L1_2(L2_2)
end
L63_1[L64_1] = L65_1
L63_1 = _ENV
L64_1 = "veh_EMP"
function L65_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L0_2 = pairs
  L1_2 = players
  L1_2 = L1_2.list
  L2_2 = true
  L3_2 = true
  L4_2 = true
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2 = L1_2(L2_2, L3_2, L4_2)
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = PLAYER
    L6_2 = L6_2.GET_PLAYER_PED_SCRIPT_INDEX
    L7_2 = L5_2
    L6_2 = L6_2(L7_2)
    L7_2 = ENTITY
    L7_2 = L7_2.GET_ENTITY_COORDS
    L8_2 = L6_2
    L9_2 = true
    L7_2 = L7_2(L8_2, L9_2)
    L8_2 = FIRE
    L8_2 = L8_2.ADD_EXPLOSION
    L9_2 = L7_2.x
    L10_2 = L7_2.y
    L11_2 = L7_2.z
    L12_2 = 65
    L13_2 = 999
    L14_2 = false
    L15_2 = true
    L16_2 = 0
    L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  end
end
L63_1[L64_1] = L65_1
function L63_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = 0
  L2_2 = 49
  L3_2 = 1
  for L4_2 = L1_2, L2_2, L3_2 do
    L5_2 = VEHICLE
    L5_2 = L5_2.GET_NUM_VEHICLE_MODS
    L6_2 = A0_2
    L7_2 = L4_2
    L5_2 = L5_2(L6_2, L7_2)
    L6_2 = VEHICLE
    L6_2 = L6_2.SET_VEHICLE_MOD
    L7_2 = A0_2
    L8_2 = L4_2
    L9_2 = L5_2 - 1
    L10_2 = true
    L6_2(L7_2, L8_2, L9_2, L10_2)
  end
end
upgrade_vehicle = L63_1
L63_1 = _ENV
L64_1 = "jiasudian"
function L65_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = players
  L1_2 = L1_2.get_position
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = L1_2.z
  L2_2 = L2_2 - 0.3
  L1_2.z = L2_2
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = ENTITY
  L3_2 = L3_2.GET_ENTITY_HEADING
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  L4_2 = L3_2 + 80
  L5_2 = entities
  L5_2 = L5_2.create_object
  L6_2 = 3287988974
  L7_2 = L1_2
  L5_2 = L5_2(L6_2, L7_2)
  L6_2 = ENTITY
  L6_2 = L6_2.SET_ENTITY_HEADING
  L7_2 = L5_2
  L8_2 = L4_2
  L6_2(L7_2, L8_2)
end
L63_1[L64_1] = L65_1
L63_1 = _ENV
L64_1 = "sigejiasudian"
function L65_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = players
  L1_2 = L1_2.get_position
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = L1_2.z
  L2_2 = L2_2 - 0.3
  L1_2.z = L2_2
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = ENTITY
  L3_2 = L3_2.GET_ENTITY_HEADING
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  L4_2 = entities
  L4_2 = L4_2.create_object
  L5_2 = -388593496
  L6_2 = L1_2
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_HEADING
  L6_2 = L4_2
  L7_2 = L3_2
  L5_2(L6_2, L7_2)
end
L63_1[L64_1] = L65_1
L63_1 = _ENV
L64_1 = "jiansudai"
function L65_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = players
  L1_2 = L1_2.get_position
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = L1_2.z
  L2_2 = L2_2 - 0.6
  L1_2.z = L2_2
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = ENTITY
  L3_2 = L3_2.GET_ENTITY_HEADING
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  L4_2 = L3_2 + 80
  L5_2 = entities
  L5_2 = L5_2.create_object
  L6_2 = -227275508
  L7_2 = L1_2
  L5_2 = L5_2(L6_2, L7_2)
  L6_2 = ENTITY
  L6_2 = L6_2.SET_ENTITY_HEADING
  L7_2 = L5_2
  L8_2 = L4_2
  L6_2(L7_2, L8_2)
end
L63_1[L64_1] = L65_1
L63_1 = _ENV
L64_1 = "hostcrash"
function L65_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED_SCRIPT_INDEX
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_ID
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L2_2 = menu
  L2_2 = L2_2.trigger_commands
  L3_2 = "tpmazehelipad"
  L2_2(L3_2)
  L2_2 = ENTITY
  L2_2 = L2_2.SET_ENTITY_COORDS
  L3_2 = L1_2
  L4_2 = -6170
  L5_2 = 10837
  L6_2 = 40
  L7_2 = true
  L8_2 = false
  L9_2 = false
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L2_2 = util
  L2_2 = L2_2.yield
  L3_2 = 1000
  L2_2(L3_2)
  L2_2 = menu
  L2_2 = L2_2.trigger_commands
  L3_2 = "tpmazehelipad"
  L2_2(L3_2)
end
L63_1[L64_1] = L65_1
L63_1 = _ENV
L64_1 = "memory"
L63_1 = L63_1[L64_1]
L64_1 = "read_long"
L63_1 = L63_1[L64_1]
L64_1 = _ENV
L65_1 = "memory"
L64_1 = L64_1[L65_1]
L65_1 = "rip"
L64_1 = L64_1[L65_1]
L65_1 = _ENV
L66_1 = "memory"
L65_1 = L65_1[L66_1]
L66_1 = "scan"
L65_1 = L65_1[L66_1]
L66_1 = "48 8D 0D ? ? ? ? 48 8B D7 E8 ? ? ? ? 48 8D 0D ? ? ? ? 8A D8 E8 ? ? ? ? 84 DB 75 13 48 8D 0D"
L65_1 = L65_1(L66_1)
L65_1 = L65_1 + 3
L64_1, L65_1, L66_1, L67_1, L68_1, L69_1, L70_1, L71_1, L72_1, L73_1, L74_1, L75_1, L76_1, L77_1, L78_1, L79_1, L80_1, L81_1 = L64_1(L65_1)
L63_1 = L63_1(L64_1, L65_1, L66_1, L67_1, L68_1, L69_1, L70_1, L71_1, L72_1, L73_1, L74_1, L75_1, L76_1, L77_1, L78_1, L79_1, L80_1, L81_1)
L64_1 = _ENV
L65_1 = "memory"
L64_1 = L64_1[L65_1]
L65_1 = "read_long"
L64_1 = L64_1[L65_1]
L65_1 = L63_1 + 24
L64_1 = L64_1(L65_1)
L65_1 = _ENV
L66_1 = "shechuNPC"
function L67_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L0_2 = ENTITY
  L0_2 = L0_2.GET_ENTITY_COORDS
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L1_2 = CAM
  L1_2 = L1_2.GET_GAMEPLAY_CAM_ROT
  L2_2 = 0
  L1_2 = L1_2(L2_2)
  L2_2 = PED
  L2_2 = L2_2.IS_PED_SHOOTING
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L3_2()
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  if L2_2 then
    L2_2 = PED
    L2_2 = L2_2.CREATE_RANDOM_PED
    L3_2 = L0_2.x
    L4_2 = L0_2.y
    L5_2 = L0_2.z
    L2_2 = L2_2(L3_2, L4_2, L5_2)
    pedspawn = L2_2
    L2_2 = ENTITY
    L2_2 = L2_2.SET_ENTITY_ROTATION
    L3_2 = pedspawn
    L4_2 = L1_2.x
    L5_2 = L1_2.y
    L6_2 = L1_2.z
    L7_2 = 1
    L8_2 = false
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
    L2_2 = ENTITY
    L2_2 = L2_2.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
    L3_2 = pedspawn
    L4_2 = 1
    L5_2 = 0
    L6_2 = 1000
    L7_2 = 0
    L8_2 = false
    L9_2 = true
    L10_2 = true
    L11_2 = true
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  end
  L2_2 = memory
  L2_2 = L2_2.read_int
  L3_2 = L64_1
  L3_2 = L3_2 + 272
  L2_2 = L2_2(L3_2)
  L3_2 = 240
  if L2_2 > L3_2 then
    L3_2 = Normal_clearance
    L3_2()
  end
end
L65_1[L66_1] = L67_1
L65_1 = _ENV
L66_1 = "get_ground_z"
function L67_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = os
  L1_2 = L1_2.time
  L1_2 = L1_2()
  while true do
    L2_2 = os
    L2_2 = L2_2.time
    L2_2 = L2_2()
    L2_2 = L2_2 - L1_2
    if L2_2 >= 5 then
      L2_2 = nil
      return L2_2
    end
    L2_2 = util
    L2_2 = L2_2.get_ground_z
    L3_2 = A0_2.x
    L4_2 = A0_2.y
    L5_2 = A0_2.z
    L5_2 = L5_2 + 2000
    L2_2, L3_2 = L2_2(L3_2, L4_2, L5_2)
    if L2_2 then
      return L3_2
    end
    L4_2 = util
    L4_2 = L4_2.yield
    L4_2()
  end
end
L65_1[L66_1] = L67_1
L65_1 = _ENV
L66_1 = "get_waypoint_coords"
function L67_1()
  local L0_2, L1_2, L2_2
  L0_2 = HUD
  L0_2 = L0_2.GET_BLIP_COORDS
  L1_2 = HUD
  L1_2 = L1_2.GET_FIRST_BLIP_INFO_ID
  L2_2 = 8
  L1_2, L2_2 = L1_2(L2_2)
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = L0_2.x
  if 0 == L1_2 then
    L1_2 = L0_2.y
    if 0 == L1_2 then
      L1_2 = L0_2.z
      if 0 == L1_2 then
        L1_2 = nil
        return L1_2
    end
  end
  else
    L1_2 = get_ground_z
    L2_2 = L0_2
    L1_2 = L1_2(L2_2)
    if L1_2 then
      L0_2.z = L1_2
    end
    return L0_2
  end
end
L65_1[L66_1] = L67_1
L65_1 = _ENV
L66_1 = "tp_player_car_to_coords"
function L67_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_NAME
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = robustmode
  if L3_2 then
    L3_2 = menu
    L3_2 = L3_2.trigger_commands
    L4_2 = "spectate"
    L5_2 = L2_2
    L6_2 = " on"
    L4_2 = L4_2 .. L5_2 .. L6_2
    L3_2(L4_2)
    L3_2 = util
    L3_2 = L3_2.yield
    L4_2 = 1000
    L3_2(L4_2)
  end
  L3_2 = PED
  L3_2 = L3_2.GET_VEHICLE_PED_IS_IN
  L4_2 = PLAYER
  L4_2 = L4_2.GET_PLAYER_PED_SCRIPT_INDEX
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  L5_2 = true
  L3_2 = L3_2(L4_2, L5_2)
  if 0 ~= L3_2 then
    L4_2 = request_control
    L5_2 = L3_2
    L4_2(L5_2)
    L4_2 = NETWORK
    L4_2 = L4_2.NETWORK_HAS_CONTROL_OF_ENTITY
    L5_2 = L3_2
    L4_2 = L4_2(L5_2)
    if L4_2 then
      L4_2 = 1
      L5_2 = 3
      L6_2 = 1
      for L7_2 = L4_2, L5_2, L6_2 do
        L8_2 = ENTITY
        L8_2 = L8_2.SET_ENTITY_COORDS_NO_OFFSET
        L9_2 = L3_2
        L10_2 = A1_2.x
        L11_2 = A1_2.y
        L12_2 = A1_2.z
        L13_2 = false
        L14_2 = false
        L15_2 = false
        L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
      end
    end
  end
end
L65_1[L66_1] = L67_1
L65_1 = _ENV
L66_1 = "tpcartome"
function L67_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = tp_player_car_to_coords
  L2_2 = A0_2
  L3_2 = ENTITY
  L3_2 = L3_2.GET_ENTITY_COORDS
  L4_2 = PLAYER
  L4_2 = L4_2.PLAYER_PED_ID
  L4_2 = L4_2()
  L5_2 = true
  L3_2, L4_2, L5_2 = L3_2(L4_2, L5_2)
  L1_2(L2_2, L3_2, L4_2, L5_2)
end
L65_1[L66_1] = L67_1
L65_1 = _ENV
L66_1 = "tocartopoint"
function L67_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = get_waypoint_coords
  L1_2 = L1_2()
  if nil ~= L1_2 then
    L2_2 = tp_player_car_to_coords
    L3_2 = A0_2
    L4_2 = L1_2
    L2_2(L3_2, L4_2)
  end
end
L65_1[L66_1] = L67_1
L65_1 = _ENV
L66_1 = "tptomaze"
function L67_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = {}
  L1_2.x = -75.261375
  L1_2.y = -818.674
  L1_2.z = 326.17517
  L2_2 = tp_player_car_to_coords
  L3_2 = A0_2
  L4_2 = L1_2
  L2_2(L3_2, L4_2)
end
L65_1[L66_1] = L67_1
L65_1 = _ENV
L66_1 = "tptounderwater"
function L67_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = {}
  L1_2.x = 4497.2207
  L1_2.y = 8028.3086
  L1_2.z = -32.635174
  L2_2 = tp_player_car_to_coords
  L3_2 = A0_2
  L4_2 = L1_2
  L2_2(L3_2, L4_2)
end
L65_1[L66_1] = L67_1
L65_1 = _ENV
L66_1 = "tptohighair"
function L67_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = {}
  L1_2.x = -75
  L1_2.y = -818
  L1_2.z = 2400
  L2_2 = tp_player_car_to_coords
  L3_2 = A0_2
  L4_2 = L1_2
  L2_2(L3_2, L4_2)
end
L65_1[L66_1] = L67_1
L65_1 = _ENV
L66_1 = "tolsc"
function L67_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = {}
  L1_2.x = -353.84512
  L1_2.y = -135.59108
  L1_2.z = 39.009624
  L2_2 = tp_player_car_to_coords
  L3_2 = A0_2
  L4_2 = L1_2
  L2_2(L3_2, L4_2)
end
L65_1[L66_1] = L67_1
L65_1 = _ENV
L66_1 = "tpscp"
function L67_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = {}
  L1_2.x = 1642.8401
  L1_2.y = 2570.7695
  L1_2.z = 45.564854
  L2_2 = tp_player_car_to_coords
  L3_2 = A0_2
  L4_2 = L1_2
  L2_2(L3_2, L4_2)
end
L65_1[L66_1] = L67_1
L65_1 = _ENV
L66_1 = "tocell"
function L67_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = {}
  L1_2.x = 1737.1896
  L1_2.y = 2634.897
  L1_2.z = 45.56497
  L2_2 = tp_player_car_to_coords
  L3_2 = A0_2
  L4_2 = L1_2
  L2_2(L3_2, L4_2)
end
L65_1[L66_1] = L67_1
L65_1 = _ENV
L66_1 = "control_vehicle"
function L67_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2
  L3_2 = get_player_vehicle_in_control
  L4_2 = A0_2
  L5_2 = A2_2
  L3_2 = L3_2(L4_2, L5_2)
  if L3_2 > 0 then
    L4_2 = A1_2
    L5_2 = L3_2
    L4_2(L5_2)
  else
    if nil ~= A2_2 then
      L4_2 = A2_2.silent
      if true == L4_2 then
        goto lbl_20
      end
    end
    L4_2 = util
    L4_2 = L4_2.toast
    L5_2 = "玩家不在车内或不在范围内。"
    L4_2(L5_2)
  end
  ::lbl_20::
end
L65_1[L66_1] = L67_1
L65_1 = _ENV
L66_1 = "randomupdatcar"
function L67_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = control_vehicle
  L2_2 = A0_2
  function L3_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3
    L1_3 = VEHICLE
    L1_3 = L1_3.SET_VEHICLE_MOD_KIT
    L2_3 = A0_3
    L3_3 = 0
    L1_3(L2_3, L3_3)
    L1_3 = 0
    L2_3 = 49
    L3_3 = 1
    for L4_3 = L1_3, L2_3, L3_3 do
      L5_3 = VEHICLE
      L5_3 = L5_3.GET_NUM_VEHICLE_MODS
      L6_3 = A0_3
      L7_3 = L4_3
      L5_3 = L5_3(L6_3, L7_3)
      L6_3 = VEHICLE
      L6_3 = L6_3.SET_VEHICLE_MOD
      L7_3 = A0_3
      L8_3 = L4_3
      L9_3 = math
      L9_3 = L9_3.random
      L10_3 = -1
      L11_3 = L5_3
      L9_3, L10_3, L11_3 = L9_3(L10_3, L11_3)
      L6_3(L7_3, L8_3, L9_3, L10_3, L11_3)
    end
    L1_3 = VEHICLE
    L1_3 = L1_3.SET_VEHICLE_WINDOW_TINT
    L2_3 = A0_3
    L3_3 = math
    L3_3 = L3_3.random
    L4_3 = -1
    L5_3 = 5
    L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3 = L3_3(L4_3, L5_3)
    L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3)
    L1_3 = 17
    L2_3 = 22
    L3_3 = 1
    for L4_3 = L1_3, L2_3, L3_3 do
      L5_3 = VEHICLE
      L5_3 = L5_3.TOGGLE_VEHICLE_MOD
      L6_3 = A0_3
      L7_3 = L4_3
      L8_3 = math
      L8_3 = L8_3.random
      L8_3 = L8_3()
      L9_3 = 0.5
      L8_3 = L8_3 > L9_3
      L5_3(L6_3, L7_3, L8_3)
    end
    L1_3 = VEHICLE
    L1_3 = L1_3.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR
    L2_3 = A0_3
    L3_3 = math
    L3_3 = L3_3.random
    L4_3 = 0
    L5_3 = 255
    L3_3 = L3_3(L4_3, L5_3)
    L4_3 = math
    L4_3 = L4_3.random
    L5_3 = 0
    L6_3 = 255
    L4_3 = L4_3(L5_3, L6_3)
    L5_3 = math
    L5_3 = L5_3.random
    L6_3 = 0
    L7_3 = 255
    L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3 = L5_3(L6_3, L7_3)
    L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3)
    L1_3 = VEHICLE
    L1_3 = L1_3.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR
    L2_3 = A0_3
    L3_3 = math
    L3_3 = L3_3.random
    L4_3 = 0
    L5_3 = 255
    L3_3 = L3_3(L4_3, L5_3)
    L4_3 = math
    L4_3 = L4_3.random
    L5_3 = 0
    L6_3 = 255
    L4_3 = L4_3(L5_3, L6_3)
    L5_3 = math
    L5_3 = L5_3.random
    L6_3 = 0
    L7_3 = 255
    L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3 = L5_3(L6_3, L7_3)
    L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3)
  end
  L1_2(L2_2, L3_2)
end
L65_1[L66_1] = L67_1
L65_1 = _ENV
L66_1 = "request_control_of_entity_once"
function L67_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = NETWORK
  L1_2 = L1_2.NETWORK_HAS_CONTROL_OF_ENTITY
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if not L1_2 then
    L1_2 = util
    L1_2 = L1_2.is_session_started
    L1_2 = L1_2()
    if L1_2 then
      L1_2 = NETWORK
      L1_2 = L1_2.NETWORK_GET_NETWORK_ID_FROM_ENTITY
      L2_2 = A0_2
      L1_2 = L1_2(L2_2)
      L2_2 = NETWORK
      L2_2 = L2_2.SET_NETWORK_ID_CAN_MIGRATE
      L3_2 = L1_2
      L4_2 = true
      L2_2(L3_2, L4_2)
      L2_2 = NETWORK
      L2_2 = L2_2.NETWORK_REQUEST_CONTROL_OF_ENTITY
      L3_2 = A0_2
      L2_2(L3_2)
    end
  end
end
L65_1[L66_1] = L67_1
L65_1 = _ENV
L66_1 = "carspin"
function L67_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L1_2 = PED
  L1_2 = L1_2.GET_VEHICLE_PED_IS_IN
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = true
  L1_2 = L1_2(L2_2, L3_2)
  if 0 ~= L1_2 then
    L2_2 = request_control_of_entity_once
    L3_2 = L1_2
    L2_2(L3_2)
    L2_2 = ENTITY
    L2_2 = L2_2.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
    L3_2 = L1_2
    L4_2 = 4
    L5_2 = 0.0
    L6_2 = 0.0
    L7_2 = 300.0
    L8_2 = 0
    L9_2 = true
    L10_2 = true
    L11_2 = false
    L12_2 = true
    L13_2 = true
    L14_2 = true
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  end
end
L65_1[L66_1] = L67_1
L65_1 = _ENV
L66_1 = "caremp"
function L67_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L1_2 = PED
  L1_2 = L1_2.GET_VEHICLE_PED_IS_IN
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = true
  L1_2 = L1_2(L2_2, L3_2)
  if 0 ~= L1_2 then
    L2_2 = ENTITY
    L2_2 = L2_2.GET_ENTITY_COORDS
    L3_2 = L1_2
    L2_2 = L2_2(L3_2)
    L3_2 = FIRE
    L3_2 = L3_2.ADD_EXPLOSION
    L4_2 = L2_2.x
    L5_2 = L2_2.y
    L6_2 = L2_2.z
    L7_2 = 83
    L8_2 = 100.0
    L9_2 = false
    L10_2 = true
    L11_2 = 0.0
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  end
end
L65_1[L66_1] = L67_1
L65_1 = _ENV
L66_1 = "deleplayercar"
function L67_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED_SCRIPT_INDEX
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = PED
  L2_2 = L2_2.GET_VEHICLE_PED_IS_USING
  L3_2 = L1_2
  L2_2 = L2_2(L3_2)
  L3_2 = request_control
  L4_2 = vehicle
  L3_2(L4_2)
  L3_2 = NETWORK
  L3_2 = L3_2.NETWORK_HAS_CONTROL_OF_ENTITY
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  if L3_2 then
    L3_2 = ENTITY
    L3_2 = L3_2.SET_ENTITY_AS_MISSION_ENTITY
    L4_2 = L2_2
    L5_2 = false
    L6_2 = false
    L3_2(L4_2, L5_2, L6_2)
    L3_2 = delete_entity
    L4_2 = L2_2
    L3_2(L4_2)
  end
end
L65_1[L66_1] = L67_1
L65_1 = _ENV
L66_1 = "disable_vehicle"
function L67_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if 0 ~= L1_2 then
    L1_2 = PED
    L1_2 = L1_2.IS_PED_IN_ANY_VEHICLE
    L2_2 = PLAYER
    L2_2 = L2_2.GET_PLAYER_PED
    L3_2 = A0_2
    L2_2, L3_2, L4_2 = L2_2(L3_2)
    L1_2 = L1_2(L2_2, L3_2, L4_2)
    if L1_2 then
      L1_2 = PED
      L1_2 = L1_2.GET_VEHICLE_PED_IS_IN
      L2_2 = PLAYER
      L2_2 = L2_2.GET_PLAYER_PED
      L3_2 = A0_2
      L2_2 = L2_2(L3_2)
      L3_2 = false
      L1_2 = L1_2(L2_2, L3_2)
      L2_2 = TASK
      L2_2 = L2_2.CLEAR_PED_TASKS_IMMEDIATELY
      L3_2 = PLAYER
      L3_2 = L3_2.GET_PLAYER_PED
      L4_2 = A0_2
      L3_2, L4_2 = L3_2(L4_2)
      L2_2(L3_2, L4_2)
    else
      L1_2 = PED
      L1_2 = L1_2.GET_VEHICLE_PED_IS_TRYING_TO_ENTER
      L2_2 = PLAYER
      L2_2 = L2_2.GET_PLAYER_PED
      L3_2 = A0_2
      L2_2, L3_2, L4_2 = L2_2(L3_2)
      L1_2 = L1_2(L2_2, L3_2, L4_2)
      L2_2 = delete_entity
      L3_2 = L1_2
      L2_2(L3_2)
    end
  end
end
L65_1[L66_1] = L67_1
L65_1 = _ENV
L66_1 = "disable_drive"
function L67_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  L2_2 = PED
  L2_2 = L2_2.GET_VEHICLE_PED_IS_IN
  L3_2 = PLAYER
  L3_2 = L3_2.GET_PLAYER_PED
  L4_2 = A1_2
  L3_2 = L3_2(L4_2)
  L4_2 = false
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = request_control
  L4_2 = L2_2
  L3_2(L4_2)
  L3_2 = VEHICLE
  L3_2 = L3_2.SET_VEHICLE_UNDRIVEABLE
  L4_2 = L2_2
  L5_2 = A0_2
  L3_2(L4_2, L5_2)
end
L65_1[L66_1] = L67_1
L65_1 = _ENV
L66_1 = "soundcrashv1"
function L67_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L1_2 = util
  L1_2 = L1_2.current_time_millis
  L1_2 = L1_2()
  L1_2 = L1_2 + 2000
  while true do
    L2_2 = util
    L2_2 = L2_2.current_time_millis
    L2_2 = L2_2()
    if not (L1_2 > L2_2) then
      break
    end
    L2_2 = ENTITY
    L2_2 = L2_2.GET_ENTITY_COORDS
    L3_2 = PLAYER
    L3_2 = L3_2.GET_PLAYER_PED_SCRIPT_INDEX
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    L4_2 = true
    L2_2 = L2_2(L3_2, L4_2)
    L3_2 = 1
    L4_2 = 10
    L5_2 = 1
    for L6_2 = L3_2, L4_2, L5_2 do
      L7_2 = AUDIO
      L7_2 = L7_2.PLAY_SOUND_FROM_COORD
      L8_2 = -1
      L9_2 = "10s"
      L10_2 = L2_2.x
      L11_2 = L2_2.y
      L12_2 = L2_2.z
      L13_2 = "MP_MISSION_COUNTDOWN_SOUNDSET"
      L14_2 = true
      L15_2 = 70
      L16_2 = false
      L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
    end
    L3_2 = util
    L3_2 = L3_2.yield
    L4_2 = 0
    L3_2(L4_2)
  end
end
L65_1[L66_1] = L67_1
L65_1 = _ENV
L66_1 = "soundcrashv2"
function L67_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L1_2 = util
  L1_2 = L1_2.current_time_millis
  L1_2 = L1_2()
  L1_2 = L1_2 + 2000
  while true do
    L2_2 = util
    L2_2 = L2_2.current_time_millis
    L2_2 = L2_2()
    if not (L1_2 > L2_2) then
      break
    end
    L2_2 = ENTITY
    L2_2 = L2_2.GET_ENTITY_COORDS
    L3_2 = PLAYER
    L3_2 = L3_2.GET_PLAYER_PED_SCRIPT_INDEX
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    L4_2 = true
    L2_2 = L2_2(L3_2, L4_2)
    L3_2 = 1
    L4_2 = 20
    L5_2 = 1
    for L6_2 = L3_2, L4_2, L5_2 do
      L7_2 = AUDIO
      L7_2 = L7_2.PLAY_SOUND_FROM_COORD
      L8_2 = -1
      L9_2 = "Event_Message_Purple"
      L10_2 = L2_2.x
      L11_2 = L2_2.y
      L12_2 = L2_2.z
      L13_2 = "GTAO_FM_Events_Soundset"
      L14_2 = true
      L15_2 = 1000
      L16_2 = false
      L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
      L7_2 = AUDIO
      L7_2 = L7_2.PLAY_SOUND_FROM_COORD
      L8_2 = -1
      L9_2 = "5s"
      L10_2 = L2_2.x
      L11_2 = L2_2.y
      L12_2 = L2_2.z
      L13_2 = "GTAO_FM_Events_Soundset"
      L14_2 = true
      L15_2 = 1000
      L16_2 = false
      L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
    end
    L3_2 = util
    L3_2 = L3_2.yield
    L3_2()
  end
end
L65_1[L66_1] = L67_1
L65_1 = _ENV
L66_1 = "kickcar"
function L67_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED_SCRIPT_INDEX
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = PED
  L2_2 = L2_2.IS_PED_IN_ANY_VEHICLE
  L3_2 = L1_2
  L4_2 = false
  L2_2 = L2_2(L3_2, L4_2)
  if L2_2 then
    L2_2 = PED
    L2_2 = L2_2.GET_VEHICLE_PED_IS_USING
    L3_2 = L1_2
    L2_2 = L2_2(L3_2)
    player_veh = L2_2
    L2_2 = DECORATOR
    L2_2 = L2_2.DECOR_REGISTER
    L3_2 = "Player_Vehicle"
    L4_2 = 3
    L2_2(L3_2, L4_2)
    L2_2 = DECORATOR
    L2_2 = L2_2.DECOR_SET_INT
    L3_2 = player_veh
    L4_2 = "Player_Vehicle"
    L5_2 = 0
    L2_2(L3_2, L4_2, L5_2)
  else
    L2_2 = util
    L2_2 = L2_2.toast
    L3_2 = "玩家不在车内哦"
    L2_2(L3_2)
  end
end
L65_1[L66_1] = L67_1
L65_1 = _ENV
L66_1 = "diaoshepao"
function L67_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = os
  L1_2 = L1_2.time
  L1_2 = L1_2()
  L2_2 = STREAMING
  L2_2 = L2_2.REQUEST_NAMED_PTFX_ASSET
  L3_2 = A0_2
  L2_2(L3_2)
  while true do
    L2_2 = STREAMING
    L2_2 = L2_2.HAS_NAMED_PTFX_ASSET_LOADED
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    if L2_2 then
      break
    end
    L2_2 = os
    L2_2 = L2_2.time
    L2_2 = L2_2()
    L2_2 = L2_2 - L1_2
    if L2_2 >= 10 then
      break
    end
    L2_2 = util
    L2_2 = L2_2.yield
    L2_2()
  end
end
L65_1[L66_1] = L67_1
L65_1 = _ENV
L66_1 = "get_blip_coords"
function L67_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = HUD
  L1_2 = L1_2.GET_FIRST_BLIP_INFO_ID
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if 0 ~= L1_2 then
    L2_2 = HUD
    L2_2 = L2_2.GET_BLIP_COORDS
    L3_2 = L1_2
    return L2_2(L3_2)
  end
  L2_2 = v3
  L3_2 = 0
  L4_2 = 0
  L5_2 = 0
  return L2_2(L3_2, L4_2, L5_2)
end
L65_1[L66_1] = L67_1
L65_1 = _ENV
L66_1 = "player_toggle_loop"
function L67_1(A0_2, A1_2, A2_2, A3_2, A4_2, A5_2)
  local L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L6_2 = menu
  L6_2 = L6_2.toggle_loop
  L7_2 = A0_2
  L8_2 = A2_2
  L9_2 = A3_2
  L10_2 = A4_2
  function L11_2()
    local L0_3, L1_3
    L0_3 = players
    L0_3 = L0_3.exists
    L1_3 = A1_2
    L0_3 = L0_3(L1_3)
    if not L0_3 then
      L0_3 = util
      L0_3 = L0_3.stop_thread
      L0_3()
    end
    L0_3 = A5_2
    L0_3()
  end
  return L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
end
L65_1[L66_1] = L67_1
L65_1 = _ENV
L66_1 = "autoBloodReture"
function L67_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = ENTITY
  L0_2 = L0_2.GET_ENTITY_HEALTH
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2, L4_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2)
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_MAX_HEALTH
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2, L3_2, L4_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2)
  if L1_2 == L0_2 then
    return
  end
  L1_2 = ENTITY
  L1_2 = L1_2.SET_ENTITY_HEALTH
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = L0_2 + 5
  L4_2 = 0
  L1_2(L2_2, L3_2, L4_2)
  L1_2 = util
  L1_2 = L1_2.yield
  L2_2 = 255
  L1_2(L2_2)
end
L65_1[L66_1] = L67_1
L65_1 = _ENV
L66_1 = "healthincover"
function L67_1()
  local L0_2, L1_2, L2_2
  L0_2 = PED
  L0_2 = L0_2.IS_PED_IN_COVER
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = false
  L0_2 = L0_2(L1_2, L2_2)
  if L0_2 then
    L0_2 = PLAYER1
    L0_2 = L0_2._SET_PLAYER_HEALTH_RECHARGE_LIMIT
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_ID
    L1_2 = L1_2()
    L2_2 = 1.0
    L0_2(L1_2, L2_2)
    L0_2 = PLAYER
    L0_2 = L0_2.SET_PLAYER_HEALTH_RECHARGE_MULTIPLIER
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_ID
    L1_2 = L1_2()
    L2_2 = 15.0
    L0_2(L1_2, L2_2)
  else
    L0_2 = PLAYER1
    L0_2 = L0_2._SET_PLAYER_HEALTH_RECHARGE_LIMIT
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_ID
    L1_2 = L1_2()
    L2_2 = 0.5
    L0_2(L1_2, L2_2)
    L0_2 = PLAYER
    L0_2 = L0_2.SET_PLAYER_HEALTH_RECHARGE_MULTIPLIER
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_ID
    L1_2 = L1_2()
    L2_2 = 1.0
    L0_2(L1_2, L2_2)
  end
end
L65_1[L66_1] = L67_1
L65_1 = {}
L66_1 = _ENV
L67_1 = "get_friend_list"
function L68_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L0_2 = 0
  L1_2 = NETWORK
  L1_2 = L1_2.NETWORK_GET_FRIEND_COUNT
  L1_2 = L1_2()
  L2_2 = 1
  for L3_2 = L0_2, L1_2, L2_2 do
    L4_2 = NETWORK
    L4_2 = L4_2.NETWORK_GET_FRIEND_NAME
    L5_2 = L3_2
    L4_2 = L4_2(L5_2)
    if "*****" ~= L4_2 then
      L5_2 = NETWORK
      L5_2 = L5_2.NETWORK_IS_FRIEND_ONLINE
      L6_2 = L4_2
      L5_2 = L5_2(L6_2)
      if L5_2 then
        L5_2 = L4_2
        L6_2 = " [在线]"
        L5_2 = L5_2 .. L6_2
        stat_name = L5_2
      else
        stat_name = L4_2
      end
      L5_2 = L65_1
      L5_2 = L5_2[L3_2]
      if nil ~= L5_2 then
        L5_2 = menu
        L5_2 = L5_2.set_menu_name
        L6_2 = L65_1
        L6_2 = L6_2[L3_2]
        L7_2 = stat_name
        L5_2(L6_2, L7_2)
      else
        L5_2 = L65_1
        L6_2 = menu
        L6_2 = L6_2.list
        L7_2 = frendlist
        L8_2 = stat_name
        L9_2 = {}
        L10_2 = ""
        L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
        L5_2[L3_2] = L6_2
        L5_2 = L65_1
        L5_2 = L5_2[L3_2]
        if L5_2 then
          L5_2 = menu
          L5_2 = L5_2.divider
          L6_2 = L65_1
          L6_2 = L6_2[L3_2]
          L7_2 = NETWORK
          L7_2 = L7_2.NETWORK_GET_FRIEND_NAME
          L8_2 = L3_2
          L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
          L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
          L5_2 = menu
          L5_2 = L5_2.action
          L6_2 = L65_1
          L6_2 = L6_2[L3_2]
          L7_2 = "加入战局"
          L8_2 = {}
          L9_2 = ""
          function L10_2()
            local L0_3, L1_3, L2_3
            L0_3 = menu
            L0_3 = L0_3.trigger_commands
            L1_3 = "join "
            L2_3 = L4_2
            L1_3 = L1_3 .. L2_3
            L0_3(L1_3)
          end
          L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
          L5_2 = menu
          L5_2 = L5_2.action
          L6_2 = L65_1
          L6_2 = L6_2[L3_2]
          L7_2 = "观看玩家"
          L8_2 = {}
          L9_2 = ""
          function L10_2()
            local L0_3, L1_3, L2_3
            L0_3 = menu
            L0_3 = L0_3.trigger_commands
            L1_3 = "namespectate "
            L2_3 = L4_2
            L1_3 = L1_3 .. L2_3
            L0_3(L1_3)
          end
          L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
          L5_2 = menu
          L5_2 = L5_2.action
          L6_2 = L65_1
          L6_2 = L6_2[L3_2]
          L7_2 = "邀请玩家"
          L8_2 = {}
          L9_2 = ""
          function L10_2()
            local L0_3, L1_3, L2_3
            L0_3 = menu
            L0_3 = L0_3.trigger_commands
            L1_3 = "invite "
            L2_3 = L4_2
            L1_3 = L1_3 .. L2_3
            L0_3(L1_3)
          end
          L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
          L5_2 = menu
          L5_2 = L5_2.action
          L6_2 = L65_1
          L6_2 = L6_2[L3_2]
          L7_2 = "玩家档案"
          L8_2 = {}
          L9_2 = ""
          function L10_2()
            local L0_3, L1_3, L2_3
            L0_3 = menu
            L0_3 = L0_3.trigger_commands
            L1_3 = "nameprofile "
            L2_3 = L4_2
            L1_3 = L1_3 .. L2_3
            L0_3(L1_3)
          end
          L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
          L5_2 = menu
          L5_2 = L5_2.readonly
          L6_2 = L65_1
          L6_2 = L6_2[L3_2]
          L7_2 = "复制昵称: "
          L8_2 = L4_2
          L5_2(L6_2, L7_2, L8_2)
        end
      end
    end
  end
end
L66_1[L67_1] = L68_1
L66_1 = _ENV
L67_1 = "send_hooker"
function L68_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = ENTITY
  L1_2 = L1_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
  L3_2 = pid
  L2_2 = L2_2(L3_2)
  L3_2 = -5.0
  L4_2 = 0.0
  L5_2 = 0.0
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2)
  L2_2 = 0
  if 1 == A0_2 then
    L3_2 = PED
    L3_2 = L3_2.CLONE_PED
    L4_2 = PLAYER
    L4_2 = L4_2.GET_PLAYER_PED_SCRIPT_INDEX
    L5_2 = pid
    L4_2 = L4_2(L5_2)
    L5_2 = true
    L6_2 = false
    L7_2 = true
    L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
    L2_2 = L3_2
  elseif 2 == A0_2 then
    L3_2 = request_model
    L4_2 = util
    L4_2 = L4_2.joaat
    L5_2 = "cs_lestercrest"
    L4_2, L5_2, L6_2, L7_2, L8_2 = L4_2(L5_2)
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
    L3_2 = entities
    L3_2 = L3_2.create_ped
    L4_2 = 28
    L5_2 = util
    L5_2 = L5_2.joaat
    L6_2 = "cs_lestercrest"
    L5_2 = L5_2(L6_2)
    L6_2 = L1_2
    L7_2 = math
    L7_2 = L7_2.random
    L8_2 = 270
    L7_2, L8_2 = L7_2(L8_2)
    L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
    L2_2 = L3_2
  elseif 3 == A0_2 then
    L3_2 = request_model
    L4_2 = util
    L4_2 = L4_2.joaat
    L5_2 = "cs_tracydisanto"
    L4_2, L5_2, L6_2, L7_2, L8_2 = L4_2(L5_2)
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
    L3_2 = entities
    L3_2 = L3_2.create_ped
    L4_2 = 28
    L5_2 = util
    L5_2 = L5_2.joaat
    L6_2 = "cs_tracydisanto"
    L5_2 = L5_2(L6_2)
    L6_2 = L1_2
    L7_2 = math
    L7_2 = L7_2.random
    L8_2 = 270
    L7_2, L8_2 = L7_2(L8_2)
    L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
    L2_2 = L3_2
  elseif 4 == A0_2 then
    L3_2 = request_model
    L4_2 = util
    L4_2 = L4_2.joaat
    L5_2 = "csb_agatha"
    L4_2, L5_2, L6_2, L7_2, L8_2 = L4_2(L5_2)
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
    L3_2 = entities
    L3_2 = L3_2.create_ped
    L4_2 = 28
    L5_2 = util
    L5_2 = L5_2.joaat
    L6_2 = "csb_agatha"
    L5_2 = L5_2(L6_2)
    L6_2 = L1_2
    L7_2 = math
    L7_2 = L7_2.random
    L8_2 = 270
    L7_2, L8_2 = L7_2(L8_2)
    L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
    L2_2 = L3_2
  elseif 5 == A0_2 then
    L3_2 = request_model
    L4_2 = util
    L4_2 = L4_2.joaat
    L5_2 = "a_f_y_topless_01"
    L4_2, L5_2, L6_2, L7_2, L8_2 = L4_2(L5_2)
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
    L3_2 = entities
    L3_2 = L3_2.create_ped
    L4_2 = 28
    L5_2 = util
    L5_2 = L5_2.joaat
    L6_2 = "a_f_y_topless_01"
    L5_2 = L5_2(L6_2)
    L6_2 = L1_2
    L7_2 = math
    L7_2 = L7_2.random
    L8_2 = 270
    L7_2, L8_2 = L7_2(L8_2)
    L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
    L2_2 = L3_2
    L3_2 = PED
    L3_2 = L3_2.SET_PED_COMPONENT_VARIATION
    L4_2 = L2_2
    L5_2 = 8
    L6_2 = 1
    L7_2 = 1
    L8_2 = 1
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
  end
  L3_2 = ENTITY
  L3_2 = L3_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L4_2 = PLAYER
  L4_2 = L4_2.GET_PLAYER_PED_SCRIPT_INDEX
  L5_2 = pid
  L4_2 = L4_2(L5_2)
  L5_2 = -5.0
  L6_2 = 0.0
  L7_2 = 0.0
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
  L4_2 = ENTITY
  L4_2 = L4_2.SET_ENTITY_COORDS
  L5_2 = L2_2
  L6_2 = L3_2.x
  L7_2 = L3_2.y
  L8_2 = L3_2.z
  L4_2(L5_2, L6_2, L7_2, L8_2)
  L4_2 = TASK
  L4_2 = L4_2.TASK_START_SCENARIO_IN_PLACE
  L5_2 = L2_2
  L6_2 = "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS"
  L7_2 = 0
  L8_2 = false
  L4_2(L5_2, L6_2, L7_2, L8_2)
end
L66_1[L67_1] = L68_1
L66_1 = _ENV
L67_1 = "dd02"
function L68_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  if 1 == A0_2 then
    L3_2 = attach_to_player
    L4_2 = "prop_cs_dildo_01"
    L5_2 = 57597
    L6_2 = -0.1
    L7_2 = 0.15
    L8_2 = 0
    L9_2 = 0
    L10_2 = 90
    L11_2 = 90
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  elseif 2 == A0_2 then
    L3_2 = attach_to_player
    L4_2 = "prop_ld_bomb_01"
    L5_2 = 57597
    L6_2 = -0.1
    L7_2 = 0.6
    L8_2 = 0
    L9_2 = 0
    L10_2 = 180
    L11_2 = 180
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  elseif 3 == A0_2 then
    L3_2 = attach_to_player
    L4_2 = "prop_sam_01"
    L5_2 = 57597
    L6_2 = -0.1
    L7_2 = 1.7
    L8_2 = 0
    L9_2 = 0
    L10_2 = 180
    L11_2 = 180
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  elseif 4 == A0_2 then
    L3_2 = attach_to_player
    L4_2 = "h4_prop_h4_airmissile_01a"
    L5_2 = 57597
    L6_2 = -0.1
    L7_2 = 0
    L8_2 = 0
    L9_2 = 0
    L10_2 = 180
    L11_2 = 180
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  elseif 5 == A0_2 then
    L3_2 = pairs
    L4_2 = obj_pp
    L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
    for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
      L9_2 = delete_object
      L10_2 = L8_2
      L9_2(L10_2)
    end
  end
end
L66_1[L67_1] = L68_1
L66_1 = _ENV
L67_1 = "firewingscale"
function L68_1(A0_2)
  local L1_2, L2_2
  L1_2 = fireWings3Settings
  L2_2 = A0_2 / 10
  L1_2.scale = L2_2
end
L66_1[L67_1] = L68_1
L66_1 = _ENV
L67_1 = "firewingcolour"
function L68_1(A0_2)
  local L1_2
  L1_2 = fireWings3Settings
  L1_2.colour = A0_2
end
L66_1[L67_1] = L68_1
L66_1 = _ENV
L67_1 = "fireBreathSettings"
L68_1 = {}
L69_1 = "scale"
L70_1 = 0.3
L68_1[L69_1] = L70_1
L69_1 = "colour"
L70_1 = {}
L71_1 = "r"
L72_1 = 1
L70_1[L71_1] = L72_1
L71_1 = "g"
L72_1 = 0.4980392156862745
L70_1[L71_1] = L72_1
L71_1 = "b"
L72_1 = 0.4980392156862745
L70_1[L71_1] = L72_1
L71_1 = "a"
L72_1 = 1
L70_1[L71_1] = L72_1
L68_1[L69_1] = L70_1
L69_1 = "on"
L70_1 = false
L68_1[L69_1] = L70_1
L69_1 = "y"
L70_1 = {}
L71_1 = "value"
L72_1 = 0.12
L70_1[L71_1] = L72_1
L71_1 = "still"
L72_1 = 0.12
L70_1[L71_1] = L72_1
L71_1 = "walk"
L72_1 = 0.22
L70_1[L71_1] = L72_1
L71_1 = "sprint"
L72_1 = 0.32
L70_1[L71_1] = L72_1
L71_1 = "sneak"
L72_1 = 0.35
L70_1[L71_1] = L72_1
L68_1[L69_1] = L70_1
L69_1 = "z"
L70_1 = {}
L71_1 = "value"
L72_1 = 0.58
L70_1[L71_1] = L72_1
L71_1 = "still"
L72_1 = 0.58
L70_1[L71_1] = L72_1
L71_1 = "walk"
L72_1 = 0.45
L70_1[L71_1] = L72_1
L71_1 = "sprint"
L72_1 = 0.38
L70_1[L71_1] = L72_1
L71_1 = "sneak"
L72_1 = 0.35
L70_1[L71_1] = L72_1
L68_1[L69_1] = L70_1
L66_1[L67_1] = L68_1
L66_1 = _ENV
L67_1 = "transitionValue"
function L68_1(A0_2, A1_2, A2_2)
  local L3_2
  if A0_2 == A1_2 then
    return A0_2
  end
  if A1_2 < A0_2 then
    L3_2 = -1
    if L3_2 then
      goto lbl_10
    end
  end
  L3_2 = 1
  ::lbl_10::
  L3_2 = A2_2 * L3_2
  L3_2 = A0_2 + L3_2
  return L3_2
end
L66_1[L67_1] = L68_1
L66_1 = _ENV
L67_1 = "fireBreathSettings"
L66_1 = L66_1[L67_1]
L67_1 = "changePos"
function L68_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = A0_2.z
  L3_2 = transitionValue
  L4_2 = A0_2.z
  L4_2 = L4_2.value
  L5_2 = A0_2.z
  L5_2 = L5_2[A1_2]
  L6_2 = 0.01
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  L2_2.value = L3_2
  L2_2 = A0_2.y
  L3_2 = transitionValue
  L4_2 = A0_2.y
  L4_2 = L4_2.value
  L5_2 = A0_2.y
  L5_2 = L5_2[A1_2]
  L6_2 = 0.01
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  L2_2.value = L3_2
end
L66_1[L67_1] = L68_1
L66_1 = _ENV
L67_1 = "firebreathxxx"
function L68_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  if A0_2 then
    L1_2 = request_ptfx_asset
    L2_2 = "weap_xs_vehicle_weapons"
    L1_2(L2_2)
    L1_2 = GRAPHICS
    L1_2 = L1_2.USE_PARTICLE_FX_ASSET
    L2_2 = "weap_xs_vehicle_weapons"
    L1_2(L2_2)
    L1_2 = fireBreathSettings
    L2_2 = GRAPHICS
    L3_2 = "START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE"
    L2_2 = L2_2[L3_2]
    L3_2 = "muz_xs_turret_flamethrower_looping"
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2 = L4_2()
    L5_2 = 0
    L6_2 = 0.12
    L7_2 = 0.58
    L8_2 = 30
    L9_2 = 0
    L10_2 = 0
    L11_2 = 35731
    L12_2 = fireBreathSettings
    L12_2 = L12_2.scale
    L13_2 = false
    L14_2 = false
    L15_2 = false
    L16_2 = 0
    L17_2 = 0
    L18_2 = 0
    L19_2 = 0
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
    L1_2.ptfx = L2_2
    L1_2 = GRAPHICS
    L1_2 = L1_2.SET_PARTICLE_FX_LOOPED_COLOUR
    L2_2 = fireBreathSettings
    L2_2 = L2_2.ptfx
    L3_2 = fireBreathSettings
    L3_2 = L3_2.colour
    L3_2 = L3_2.r
    L4_2 = fireBreathSettings
    L4_2 = L4_2.colour
    L4_2 = L4_2.g
    L5_2 = fireBreathSettings
    L5_2 = L5_2.colour
    L5_2 = L5_2.b
    L6_2 = false
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
  else
    L1_2 = GRAPHICS
    L1_2 = L1_2.STOP_PARTICLE_FX_LOOPED
    L2_2 = fireBreathSettings
    L2_2 = L2_2.ptfx
    L3_2 = false
    L1_2(L2_2, L3_2)
    L1_2 = GRAPHICS
    L1_2 = L1_2.REMOVE_PARTICLE_FX
    L2_2 = fireBreathSettings
    L2_2 = L2_2.ptfx
    L3_2 = true
    L1_2(L2_2, L3_2)
    L1_2 = STREAMING
    L1_2 = L1_2.REMOVE_NAMED_PTFX_ASSET
    L2_2 = "weap_xs_vehicle_weapons"
    L1_2(L2_2)
  end
end
L66_1[L67_1] = L68_1
L66_1 = _ENV
L67_1 = "firebreathscale"
function L68_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = fireBreathSettings
  L2_2 = A0_2 / 10
  L1_2.scale = L2_2
  L1_2 = GRAPHICS
  L1_2 = L1_2.SET_PARTICLE_FX_LOOPED_SCALE
  L2_2 = fireBreathSettings
  L2_2 = L2_2.ptfx
  L3_2 = fireBreathSettings
  L3_2 = L3_2.scale
  L1_2(L2_2, L3_2)
end
L66_1[L67_1] = L68_1
L66_1 = _ENV
L67_1 = "firebreathcolour"
function L68_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = fireBreathSettings
  L1_2.colour = A0_2
  L1_2 = GRAPHICS
  L1_2 = L1_2.SET_PARTICLE_FX_LOOPED_COLOUR
  L2_2 = fireBreathSettings
  L2_2 = L2_2.ptfx
  L3_2 = fireBreathSettings
  L3_2 = L3_2.colour
  L3_2 = L3_2.r
  L4_2 = fireBreathSettings
  L4_2 = L4_2.colour
  L4_2 = L4_2.g
  L5_2 = fireBreathSettings
  L5_2 = L5_2.colour
  L5_2 = L5_2.b
  L6_2 = false
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
end
L66_1[L67_1] = L68_1
L66_1 = _ENV
L67_1 = "front_sight"
function L68_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = HUD
  L1_2 = L1_2.SET_TEXT_SCALE
  L2_2 = 1.0
  L3_2 = 0.5
  L1_2(L2_2, L3_2)
  L1_2 = HUD
  L1_2 = L1_2.SET_TEXT_FONT
  L2_2 = 0
  L1_2(L2_2)
  L1_2 = HUD
  L1_2 = L1_2.SET_TEXT_CENTRE
  L2_2 = 1
  L1_2(L2_2)
  L1_2 = HUD
  L1_2 = L1_2.SET_TEXT_OUTLINE
  L2_2 = 0
  L1_2(L2_2)
  L1_2 = HUD
  L1_2 = L1_2.SET_TEXT_COLOUR
  L2_2 = 255
  L3_2 = 255
  L4_2 = 255
  L5_2 = 180
  L1_2(L2_2, L3_2, L4_2, L5_2)
  L1_2 = util
  L1_2 = L1_2.BEGIN_TEXT_COMMAND_DISPLAY_TEXT
  L2_2 = A0_2
  L1_2(L2_2)
  L1_2 = HUD
  L1_2 = L1_2.END_TEXT_COMMAND_DISPLAY_TEXT
  L2_2 = 0.4999
  L3_2 = 0.486
  L4_2 = 0
  L1_2(L2_2, L3_2, L4_2)
end
L66_1[L67_1] = L68_1
L66_1 = _ENV
L67_1 = "getTotalDelayabcd"
function L68_1(A0_2)
  local L1_2, L2_2
  L1_2 = A0_2.ms
  L2_2 = A0_2.s
  L2_2 = L2_2 * 1000
  L1_2 = L1_2 + L2_2
  L2_2 = A0_2.min
  L2_2 = L2_2 * 1000
  L2_2 = L2_2 * 60
  L1_2 = L1_2 + L2_2
  return L1_2
end
L66_1[L67_1] = L68_1
L66_1 = _ENV
L67_1 = "getTotalDelay"
function L68_1(A0_2)
  local L1_2, L2_2
  L1_2 = A0_2.ms
  L2_2 = A0_2.s
  L2_2 = L2_2 * 1000
  L1_2 = L1_2 + L2_2
  L2_2 = A0_2.min
  L2_2 = L2_2 * 1000
  L2_2 = L2_2 * 60
  L1_2 = L1_2 + L2_2
  return L1_2
end
L66_1[L67_1] = L68_1
L66_1 = 1000
L67_1 = 1000
L68_1 = _ENV
L69_1 = "new"
L68_1 = L68_1[L69_1]
L68_1 = L68_1.delay
L69_1 = 1
L70_1 = 0
L71_1 = 0
L68_1 = L68_1(L69_1, L70_1, L71_1)
L69_1 = _ENV
L70_1 = "expSettings"
L71_1 = {}
L72_1 = "camShake"
L73_1 = 0
L71_1[L72_1] = L73_1
L72_1 = "invisible"
L73_1 = false
L71_1[L72_1] = L73_1
L72_1 = "audible"
L73_1 = true
L71_1[L72_1] = L73_1
L72_1 = "noDamage"
L73_1 = false
L71_1[L72_1] = L73_1
L72_1 = "owned"
L73_1 = false
L71_1[L72_1] = L73_1
L72_1 = "blamed"
L73_1 = false
L71_1[L72_1] = L73_1
L72_1 = "blamedPlayer"
L73_1 = false
L71_1[L72_1] = L73_1
L72_1 = "expType"
L73_1 = 0
L71_1[L72_1] = L73_1
L72_1 = "colour"
L73_1 = new_colour
L74_1 = 255
L75_1 = 0
L76_1 = 255
L73_1 = L73_1(L74_1, L75_1, L76_1)
L71_1[L72_1] = L73_1
L69_1[L70_1] = L71_1
L69_1 = _ENV
L70_1 = "explosion"
function L71_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L2_2 = A1_2.currentFx
  if L2_2 then
    L2_2 = A1_2.currentFx
    L2_2 = L2_2.exp
    if L2_2 then
      L2_2 = FIRE
      L2_2 = L2_2.ADD_EXPLOSION
      L3_2 = A0_2.x
      L4_2 = A0_2.y
      L5_2 = A0_2.z
      L6_2 = A1_2.currentFx
      L6_2 = L6_2.exp
      L7_2 = 10
      L8_2 = A1_2.audible
      L9_2 = true
      L10_2 = 0
      L11_2 = A1_2.noDamage
      L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
      L2_2 = FIRE
      L2_2 = L2_2.ADD_EXPLOSION
      L3_2 = A0_2.x
      L4_2 = A0_2.y
      L5_2 = A0_2.z
      L6_2 = 1
      L7_2 = 10
      L8_2 = false
      L9_2 = true
      L10_2 = A1_2.camShake
      L11_2 = A1_2.noDamage
      L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    else
      L2_2 = FIRE
      L2_2 = L2_2.ADD_EXPLOSION
      L3_2 = A0_2.x
      L4_2 = A0_2.y
      L5_2 = A0_2.z
      L6_2 = 1
      L7_2 = 10
      L8_2 = false
      L9_2 = true
      L10_2 = A1_2.camShake
      L11_2 = A1_2.noDamage
      L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    end
    L2_2 = A1_2.invisible
    if not L2_2 then
      L2_2 = addFx
      L3_2 = A0_2
      L4_2 = A1_2.currentFx
      L5_2 = A1_2.colour
      L2_2(L3_2, L4_2, L5_2)
    end
  else
    L2_2 = FIRE
    L2_2 = L2_2.ADD_EXPLOSION
    L3_2 = A0_2.x
    L4_2 = A0_2.y
    L5_2 = A0_2.z
    L6_2 = A1_2.expType
    L7_2 = 10
    L8_2 = A1_2.audible
    L9_2 = A1_2.invisible
    L10_2 = A1_2.camShake
    L11_2 = A1_2.noDamage
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  end
end
L69_1[L70_1] = L71_1
L69_1 = _ENV
L70_1 = "explodePlayer"
function L71_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L3_2 = ENTITY
  L3_2 = L3_2.GET_ENTITY_COORDS
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  pos = L3_2
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2 = L3_2()
  blamedPlayer = L3_2
  L3_2 = A2_2.blamedPlayer
  if L3_2 then
    L3_2 = A2_2.blamed
    if L3_2 then
      L3_2 = PLAYER
      L3_2 = L3_2.GET_PLAYER_PED_SCRIPT_INDEX
      L4_2 = A2_2.blamedPlayer
      L3_2 = L3_2(L4_2)
      blamedPlayer = L3_2
  end
  else
    L3_2 = A2_2.blamed
    if L3_2 then
      L3_2 = players
      L3_2 = L3_2.list
      L4_2 = true
      L5_2 = true
      L6_2 = true
      L3_2 = L3_2(L4_2, L5_2, L6_2)
      playerList = L3_2
      L3_2 = PLAYER
      L3_2 = L3_2.GET_PLAYER_PED_SCRIPT_INDEX
      L4_2 = playerList
      L5_2 = math
      L5_2 = L5_2.random
      L6_2 = 1
      L7_2 = playerList
      L7_2 = #L7_2
      L5_2 = L5_2(L6_2, L7_2)
      L4_2 = L4_2[L5_2]
      L3_2 = L3_2(L4_2)
      blamedPlayer = L3_2
    end
  end
  if not A1_2 then
    L3_2 = PED
    L3_2 = L3_2.IS_PED_IN_ANY_VEHICLE
    L4_2 = A0_2
    L5_2 = true
    L3_2 = L3_2(L4_2, L5_2)
    if L3_2 then
      L3_2 = 0
      L4_2 = 50
      L5_2 = 1
      for L6_2 = L3_2, L4_2, L5_2 do
        L7_2 = A2_2.owned
        if not L7_2 then
          L7_2 = A2_2.blamed
          if not L7_2 then
            goto lbl_69
          end
        end
        L7_2 = ownedExplosion
        L8_2 = blamedPlayer
        L9_2 = pos
        L10_2 = A2_2
        L7_2(L8_2, L9_2, L10_2)
        goto lbl_73
        ::lbl_69::
        L7_2 = explosion
        L8_2 = pos
        L9_2 = A2_2
        L7_2(L8_2, L9_2)
        ::lbl_73::
        L7_2 = util
        L7_2 = L7_2.yield
        L8_2 = 10
        L7_2(L8_2)
      end
  end
  else
    L3_2 = A2_2.owned
    if not L3_2 then
      L3_2 = A2_2.blamed
      if not L3_2 then
        goto lbl_91
      end
    end
    L3_2 = ownedExplosion
    L4_2 = blamedPlayer
    L5_2 = pos
    L6_2 = A2_2
    L3_2(L4_2, L5_2, L6_2)
    goto lbl_95
    ::lbl_91::
    L3_2 = explosion
    L4_2 = pos
    L5_2 = A2_2
    L3_2(L4_2, L5_2)
  end
  ::lbl_95::
  L3_2 = util
  L3_2 = L3_2.yield
  L4_2 = 10
  L3_2(L4_2)
end
L69_1[L70_1] = L71_1
L69_1 = _ENV
L70_1 = "getNonWhitelistedPlayers"
function L71_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L3_2 = players
  L3_2 = L3_2.list
  L4_2 = A1_2.user
  L5_2 = A1_2.friends
  L6_2 = A1_2.strangers
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  playerList = L3_2
  L3_2 = {}
  notWhitelisted = L3_2
  L3_2 = 1
  L4_2 = playerList
  L4_2 = #L4_2
  L5_2 = 1
  for L6_2 = L3_2, L4_2, L5_2 do
    L7_2 = playerList
    L7_2 = L7_2[L6_2]
    L7_2 = A0_2[L7_2]
    if not L7_2 then
      L7_2 = players
      L7_2 = L7_2.get_name
      L8_2 = playerList
      L8_2 = L8_2[L6_2]
      L7_2 = L7_2(L8_2)
      if L7_2 ~= A2_2 then
        L7_2 = notWhitelisted
        L8_2 = notWhitelisted
        L8_2 = #L8_2
        L8_2 = L8_2 + 1
        L9_2 = playerList
        L9_2 = L9_2[L6_2]
        L7_2[L8_2] = L9_2
      end
    end
  end
  L3_2 = notWhitelisted
  return L3_2
end
L69_1[L70_1] = L71_1
L69_1 = _ENV
L70_1 = "whitelistGroups"
L71_1 = {}
L72_1 = "user"
L73_1 = true
L71_1[L72_1] = L73_1
L72_1 = "friends"
L73_1 = true
L71_1[L72_1] = L73_1
L72_1 = "strangers"
L73_1 = true
L71_1[L72_1] = L73_1
L69_1[L70_1] = L71_1
L69_1 = _ENV
L70_1 = "whitelistListTable"
L71_1 = {}
L69_1[L70_1] = L71_1
L69_1 = _ENV
L70_1 = "whitelistedName"
L71_1 = false
L69_1[L70_1] = L71_1
L69_1 = _ENV
L70_1 = "karma"
L71_1 = {}
L69_1[L70_1] = L71_1
L69_1 = _ENV
L70_1 = "isAnyPlayerTargetingEntity"
function L71_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L1_2 = getNonWhitelistedPlayers
  L2_2 = whitelistListTable
  L3_2 = whitelistGroups
  L4_2 = whitelistedName
  L1_2 = L1_2(L2_2, L3_2, L4_2)
  L2_2 = pairs
  L3_2 = L1_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = PLAYER
    L8_2 = L8_2.IS_PLAYER_TARGETTING_ENTITY
    L9_2 = L7_2
    L10_2 = A0_2
    L8_2 = L8_2(L9_2, L10_2)
    if not L8_2 then
      L8_2 = PLAYER
      L8_2 = L8_2.IS_PLAYER_FREE_AIMING_AT_ENTITY
      L9_2 = L7_2
      L10_2 = A0_2
      L8_2 = L8_2(L9_2, L10_2)
      if not L8_2 then
        goto lbl_36
      end
    end
    L8_2 = karma
    L9_2 = {}
    L9_2.pid = L7_2
    L10_2 = PLAYER
    L10_2 = L10_2.GET_PLAYER_PED_SCRIPT_INDEX
    L11_2 = L7_2
    L10_2 = L10_2(L11_2)
    L9_2.ped = L10_2
    L8_2[A0_2] = L9_2
    L8_2 = true
    do return L8_2 end
    ::lbl_36::
  end
  L2_2 = karma
  L2_2[A0_2] = nil
  L2_2 = false
  return L2_2
end
L69_1[L70_1] = L71_1
L69_1 = _ENV
L70_1 = "playerIsTargetingEntity"
function L71_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L1_2 = getNonWhitelistedPlayers
  L2_2 = whitelistListTable
  L3_2 = whitelistGroups
  L4_2 = whitelistedName
  L1_2 = L1_2(L2_2, L3_2, L4_2)
  L2_2 = pairs
  L3_2 = L1_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = PLAYER
    L8_2 = L8_2.IS_PLAYER_TARGETTING_ENTITY
    L9_2 = L7_2
    L10_2 = A0_2
    L8_2 = L8_2(L9_2, L10_2)
    if not L8_2 then
      L8_2 = PLAYER
      L8_2 = L8_2.IS_PLAYER_FREE_AIMING_AT_ENTITY
      L9_2 = L7_2
      L10_2 = A0_2
      L8_2 = L8_2(L9_2, L10_2)
      if not L8_2 then
        goto lbl_36
      end
    end
    L8_2 = karma
    L9_2 = {}
    L9_2.pid = L7_2
    L10_2 = PLAYER
    L10_2 = L10_2.GET_PLAYER_PED_SCRIPT_INDEX
    L11_2 = L7_2
    L10_2 = L10_2(L11_2)
    L9_2.ped = L10_2
    L8_2[A0_2] = L9_2
    L8_2 = true
    do return L8_2 end
    ::lbl_36::
  end
  L2_2 = karma
  L2_2[A0_2] = nil
  L2_2 = false
  return L2_2
end
L69_1[L70_1] = L71_1
L69_1 = _ENV
L70_1 = "Effect"
L69_1 = L69_1[L70_1]
L70_1 = "new"
L69_1 = L69_1[L70_1]
L70_1 = "scr_rcpaparazzo1"
L71_1 = "scr_mich4_firework_sparkle_spawn"
L69_1 = L69_1(L70_1, L71_1)
L70_1 = {}
L71_1 = _ENV
L72_1 = "removeFxs"
function L73_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = ipairs
  L2_2 = A0_2
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = GRAPHICS
    L7_2 = L7_2.STOP_PARTICLE_FX_LOOPED
    L8_2 = L6_2
    L9_2 = 0
    L7_2(L8_2, L9_2)
    L7_2 = GRAPHICS
    L7_2 = L7_2.REMOVE_PARTICLE_FX
    L8_2 = L6_2
    L9_2 = 0
    L7_2(L8_2, L9_2)
  end
end
L71_1[L72_1] = L73_1
L71_1 = _ENV
L72_1 = "locus_color"
function L73_1(A0_2)
  local L1_2
  locus_colour = A0_2
end
L71_1[L72_1] = L73_1
L71_1 = _ENV
L72_1 = "Character_locus"
function L73_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2
  L0_2 = STREAMING
  L0_2 = L0_2.HAS_NAMED_PTFX_ASSET_LOADED
  L1_2 = L69_1.asset
  L0_2 = L0_2(L1_2)
  if not L0_2 then
    L0_2 = STREAMING
    L0_2 = L0_2.REQUEST_NAMED_PTFX_ASSET
    L1_2 = L69_1.asset
    L0_2(L1_2)
    return
  end
  L0_2 = timer
  L0_2 = L0_2.elapsed
  L0_2 = L0_2()
  L1_2 = 1000
  if L0_2 >= L1_2 then
    L0_2 = removeFxs
    L1_2 = L70_1
    L0_2(L1_2)
    L0_2 = {}
    L70_1 = L0_2
    L0_2 = timer
    L0_2 = L0_2.reset
    L0_2()
  end
  L0_2 = PED
  L0_2 = L0_2.IS_PED_IN_ANY_VEHICLE
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = true
  L0_2 = L0_2(L1_2, L2_2)
  if L0_2 then
    L0_2 = PED
    L0_2 = L0_2.GET_VEHICLE_PED_IS_IN
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_PED_ID
    L1_2 = L1_2()
    L2_2 = false
    L0_2 = L0_2(L1_2, L2_2)
    L1_2 = v3
    L1_2 = L1_2.new
    L1_2 = L1_2()
    L2_2 = v3
    L2_2 = L2_2.new
    L2_2 = L2_2()
    L3_2 = MISC
    L3_2 = L3_2.GET_MODEL_DIMENSIONS
    L4_2 = ENTITY
    L4_2 = L4_2.GET_ENTITY_MODEL
    L5_2 = L0_2
    L4_2 = L4_2(L5_2)
    L5_2 = L1_2
    L6_2 = L2_2
    L3_2(L4_2, L5_2, L6_2)
    L3_2 = {}
    L4_2 = v3
    L5_2 = L1_2.x
    L6_2 = L1_2.y
    L7_2 = 0.0
    L4_2 = L4_2(L5_2, L6_2, L7_2)
    L5_2 = v3
    L6_2 = L2_2.x
    L7_2 = L1_2.y
    L8_2 = 0.0
    L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2 = L5_2(L6_2, L7_2, L8_2)
    L3_2[1] = L4_2
    L3_2[2] = L5_2
    L3_2[3] = L6_2
    L3_2[4] = L7_2
    L3_2[5] = L8_2
    L3_2[6] = L9_2
    L3_2[7] = L10_2
    L3_2[8] = L11_2
    L3_2[9] = L12_2
    L3_2[10] = L13_2
    L3_2[11] = L14_2
    L3_2[12] = L15_2
    L3_2[13] = L16_2
    L3_2[14] = L17_2
    L3_2[15] = L18_2
    L3_2[16] = L19_2
    L3_2[17] = L20_2
    L3_2[18] = L21_2
    L3_2[19] = L22_2
    L3_2[20] = L23_2
    L3_2[21] = L24_2
    L3_2[22] = L25_2
    L3_2[23] = L26_2
    L4_2 = ipairs
    L5_2 = L3_2
    L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
    for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
      L10_2 = GRAPHICS
      L10_2 = L10_2.USE_PARTICLE_FX_ASSET
      L11_2 = L69_1.asset
      L10_2(L11_2)
      L10_2 = GRAPHICS
      L11_2 = "START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY"
      L10_2 = L10_2[L11_2]
      L11_2 = L69_1.name
      L12_2 = L0_2
      L13_2 = L9_2.x
      L14_2 = L9_2.y
      L15_2 = 0.0
      L16_2 = 0.0
      L17_2 = 0.0
      L18_2 = 0.0
      L19_2 = 0.7
      L20_2 = false
      L21_2 = false
      L22_2 = false
      L23_2 = 0
      L24_2 = 0
      L25_2 = 0
      L26_2 = 0
      L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
      L11_2 = GRAPHICS
      L11_2 = L11_2.SET_PARTICLE_FX_LOOPED_COLOUR
      L12_2 = L10_2
      L13_2 = locus_colour
      L13_2 = L13_2.r
      L14_2 = locus_colour
      L14_2 = L14_2.g
      L15_2 = locus_colour
      L15_2 = L15_2.b
      L16_2 = 0
      L11_2(L12_2, L13_2, L14_2, L15_2, L16_2)
      L11_2 = table
      L11_2 = L11_2.insert
      L12_2 = L70_1
      L13_2 = L10_2
      L11_2(L12_2, L13_2)
    end
  else
    L0_2 = ENTITY
    L0_2 = L0_2.DOES_ENTITY_EXIST
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_PED_ID
    L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2 = L1_2()
    L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
    if L0_2 then
      L0_2 = ipairs
      L1_2 = bones
      L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
      for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
        L6_2 = GRAPHICS
        L6_2 = L6_2.USE_PARTICLE_FX_ASSET
        L7_2 = L69_1.asset
        L6_2(L7_2)
        L6_2 = GRAPHICS
        L7_2 = "START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE"
        L6_2 = L6_2[L7_2]
        L7_2 = L69_1.name
        L8_2 = PLAYER
        L8_2 = L8_2.PLAYER_PED_ID
        L8_2 = L8_2()
        L9_2 = 0.0
        L10_2 = 0.0
        L11_2 = 0.0
        L12_2 = 0.0
        L13_2 = 0.0
        L14_2 = 0.0
        L15_2 = PED
        L15_2 = L15_2.GET_PED_BONE_INDEX
        L16_2 = PLAYER
        L16_2 = L16_2.PLAYER_PED_ID
        L16_2 = L16_2()
        L17_2 = L5_2
        L15_2 = L15_2(L16_2, L17_2)
        L16_2 = 0.7
        L17_2 = false
        L18_2 = false
        L19_2 = false
        L20_2 = 0
        L21_2 = 0
        L22_2 = 0
        L23_2 = 0
        L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
        L7_2 = GRAPHICS
        L7_2 = L7_2.SET_PARTICLE_FX_LOOPED_COLOUR
        L8_2 = L6_2
        L9_2 = locus_colour
        L9_2 = L9_2.r
        L10_2 = locus_colour
        L10_2 = L10_2.g
        L11_2 = locus_colour
        L11_2 = L11_2.b
        L12_2 = 0
        L7_2(L8_2, L9_2, L10_2, L11_2, L12_2)
        L7_2 = table
        L7_2 = L7_2.insert
        L8_2 = L70_1
        L9_2 = L6_2
        L7_2(L8_2, L9_2)
      end
    end
  end
end
L71_1[L72_1] = L73_1
L71_1 = _ENV
L72_1 = "stop_Character_locus"
function L73_1()
  local L0_2, L1_2
  L0_2 = removeFxs
  L1_2 = L70_1
  L0_2(L1_2)
  L0_2 = {}
  L70_1 = L0_2
end
L71_1[L72_1] = L73_1
L71_1 = _ENV
L72_1 = "create_small_entities"
function L73_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED_SCRIPT_INDEX
  L2_2 = pid
  L1_2 = L1_2(L2_2)
  if 1 == A0_2 then
    L2_2 = 2282807134
    L3_2 = request_model
    L4_2 = L2_2
    L3_2(L4_2)
    L3_2 = spawn_object_in_front_of_ped
    L4_2 = L1_2
    L5_2 = L2_2
    L6_2 = 90
    L7_2 = 50.0
    L8_2 = -1
    L9_2 = true
    L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    L4_2 = ENTITY
    L4_2 = L4_2.GET_ENTITY_COORDS
    L5_2 = L3_2
    L6_2 = true
    L4_2 = L4_2(L5_2, L6_2)
    L5_2 = ENTITY
    L5_2 = L5_2.SET_ENTITY_COORDS_NO_OFFSET
    L6_2 = L3_2
    L7_2 = L4_2.x
    L8_2 = L4_2.y
    L9_2 = L4_2.z
    L9_2 = L9_2 - 0.2
    L10_2 = false
    L11_2 = false
    L12_2 = false
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  elseif 2 == A0_2 then
    L2_2 = 3729169359
    L3_2 = spawn_object_in_front_of_ped
    L4_2 = L1_2
    L5_2 = L2_2
    L6_2 = 0
    L7_2 = 5.0
    L8_2 = -0.5
    L9_2 = false
    L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    L4_2 = ENTITY
    L4_2 = L4_2.FREEZE_ENTITY_POSITION
    L5_2 = L3_2
    L6_2 = true
    L4_2(L5_2, L6_2)
  elseif 3 == A0_2 then
    L2_2 = 1952396163
    L3_2 = spawn_object_in_front_of_ped
    L4_2 = L1_2
    L5_2 = L2_2
    L6_2 = 0
    L7_2 = 5.0
    L8_2 = -30
    L9_2 = false
    L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    L4_2 = ENTITY
    L4_2 = L4_2.FREEZE_ENTITY_POSITION
    L5_2 = L3_2
    L6_2 = true
    L4_2(L5_2, L6_2)
  elseif 4 == A0_2 then
    L2_2 = PLAYER
    L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
    L3_2 = pid
    L2_2 = L2_2(L3_2)
    L3_2 = 2306058344
    L4_2 = spawn_object_in_front_of_ped
    L5_2 = L2_2
    L6_2 = L3_2
    L7_2 = 0
    L8_2 = 0.0
    L9_2 = -5.0
    L10_2 = false
    L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
    L5_2 = ENTITY
    L5_2 = L5_2.FREEZE_ENTITY_POSITION
    L6_2 = L4_2
    L7_2 = true
    L5_2(L6_2, L7_2)
  end
end
L71_1[L72_1] = L73_1
L71_1 = _ENV
L72_1 = "request_ptfx_asset_lasereyes"
function L73_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = os
  L1_2 = L1_2.time
  L1_2 = L1_2()
  L2_2 = STREAMING
  L2_2 = L2_2.REQUEST_NAMED_PTFX_ASSET
  L3_2 = A0_2
  L2_2(L3_2)
  while true do
    L2_2 = STREAMING
    L2_2 = L2_2.HAS_NAMED_PTFX_ASSET_LOADED
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    if L2_2 then
      break
    end
    L2_2 = os
    L2_2 = L2_2.time
    L2_2 = L2_2()
    L2_2 = L2_2 - L1_2
    if L2_2 >= 10 then
      break
    end
    L2_2 = util
    L2_2 = L2_2.yield
    L2_2()
  end
end
L71_1[L72_1] = L73_1
L71_1 = _ENV
L72_1 = "laser_eyes"
function L73_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2
  L0_2 = util
  L0_2 = L0_2.joaat
  L1_2 = "weapon_heavysniper_mk2"
  L0_2 = L0_2(L1_2)
  L1_2 = "weap_xs_weapons"
  L2_2 = "bullet_tracer_xs_sr"
  L3_2 = CAM
  L3_2 = L3_2.GET_FINAL_RENDERED_CAM_ROT
  L4_2 = 2
  L3_2 = L3_2(L4_2)
  L4_2 = PAD
  L4_2 = L4_2.IS_CONTROL_PRESSED
  L5_2 = 0
  L6_2 = 51
  L4_2 = L4_2(L5_2, L6_2)
  if L4_2 then
    L4_2 = v3
    L4_2 = L4_2.new
    L4_2 = L4_2()
    L5_2 = v3
    L5_2 = L5_2.set
    L6_2 = L4_2
    L7_2 = CAM
    L7_2 = L7_2.GET_FINAL_RENDERED_CAM_ROT
    L8_2 = 2
    L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2 = L7_2(L8_2)
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
    L5_2 = v3
    L5_2 = L5_2.toDir
    L6_2 = L4_2
    L5_2 = L5_2(L6_2)
    L6_2 = v3
    L6_2 = L6_2.set
    L7_2 = L4_2
    L8_2 = v3
    L8_2 = L8_2.get
    L9_2 = L5_2
    L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2 = L8_2(L9_2)
    L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
    L6_2 = v3
    L6_2 = L6_2.mul
    L7_2 = L4_2
    L8_2 = 1000
    L6_2(L7_2, L8_2)
    L6_2 = v3
    L6_2 = L6_2.set
    L7_2 = L5_2
    L8_2 = CAM
    L8_2 = L8_2.GET_FINAL_RENDERED_CAM_COORD
    L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2 = L8_2()
    L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
    L6_2 = v3
    L6_2 = L6_2.add
    L7_2 = L4_2
    L8_2 = L5_2
    L6_2(L7_2, L8_2)
    L6_2 = v3
    L6_2 = L6_2.get
    L7_2 = L4_2
    L6_2, L7_2, L8_2 = L6_2(L7_2)
    camAim_z = L8_2
    camAim_y = L7_2
    camAim_x = L6_2
    L6_2 = ENTITY
    L6_2 = L6_2.GET_ENTITY_MODEL
    L7_2 = PLAYER
    L7_2 = L7_2.PLAYER_PED_ID
    L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2 = L7_2()
    L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
    L7_2 = 0
    L8_2 = 0
    L9_2 = MISC
    L9_2 = L9_2.GET_HASH_KEY
    L10_2 = "mp_f_freemode_01"
    L9_2 = L9_2(L10_2)
    if L6_2 ~= L9_2 then
      L9_2 = MISC
      L9_2 = L9_2.GET_HASH_KEY
      L10_2 = "mp_m_freemode_01"
      L9_2 = L9_2(L10_2)
      if L6_2 ~= L9_2 then
        goto lbl_88
      end
    end
    L7_2 = 25260
    L8_2 = 27474
    goto lbl_90
    ::lbl_88::
    L7_2 = 5956
    L8_2 = 6468
    ::lbl_90::
    L9_2 = ENTITY
    L9_2 = L9_2.GET_WORLD_POSITION_OF_ENTITY_BONE
    L10_2 = PLAYER
    L10_2 = L10_2.PLAYER_PED_ID
    L10_2 = L10_2()
    L11_2 = PED
    L11_2 = L11_2.GET_PED_BONE_INDEX
    L12_2 = PLAYER
    L12_2 = L12_2.PLAYER_PED_ID
    L12_2 = L12_2()
    L13_2 = L7_2
    L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2 = L11_2(L12_2, L13_2)
    L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
    L10_2 = ENTITY
    L10_2 = L10_2.GET_WORLD_POSITION_OF_ENTITY_BONE
    L11_2 = PLAYER
    L11_2 = L11_2.PLAYER_PED_ID
    L11_2 = L11_2()
    L12_2 = PED
    L12_2 = L12_2.GET_PED_BONE_INDEX
    L13_2 = PLAYER
    L13_2 = L13_2.PLAYER_PED_ID
    L13_2 = L13_2()
    L14_2 = L8_2
    L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2 = L12_2(L13_2, L14_2)
    L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
    L11_2 = util
    L11_2 = L11_2.joaat
    L12_2 = "mp_f_freemode_01"
    L11_2 = L11_2(L12_2)
    if L6_2 == L11_2 then
      L11_2 = L9_2.z
      L11_2 = L11_2 + 0.02
      L9_2.z = L11_2
      L11_2 = L10_2.z
      L11_2 = L11_2 + 0.02
      L10_2.z = L11_2
    end
    L11_2 = L3_2.x
    L11_2 = L11_2 + -90
    L3_2.x = L11_2
    L11_2 = request_ptfx_asset_lasereyes
    L12_2 = L1_2
    L11_2(L12_2)
    L11_2 = GRAPHICS
    L11_2 = L11_2.USE_PARTICLE_FX_ASSET
    L12_2 = L1_2
    L11_2(L12_2)
    L11_2 = GRAPHICS
    L12_2 = "START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD"
    L11_2 = L11_2[L12_2]
    L12_2 = L2_2
    L13_2 = L9_2.x
    L14_2 = L9_2.y
    L15_2 = L9_2.z
    L16_2 = L3_2.x
    L17_2 = L3_2.y
    L18_2 = L3_2.z
    L19_2 = 2
    L20_2 = 0
    L21_2 = 0
    L22_2 = 0
    L23_2 = false
    L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
    L11_2 = GRAPHICS
    L11_2 = L11_2.USE_PARTICLE_FX_ASSET
    L12_2 = L1_2
    L11_2(L12_2)
    L11_2 = GRAPHICS
    L12_2 = "START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD"
    L11_2 = L11_2[L12_2]
    L12_2 = L2_2
    L13_2 = L10_2.x
    L14_2 = L10_2.y
    L15_2 = L10_2.z
    L16_2 = L3_2.x
    L17_2 = L3_2.y
    L18_2 = L3_2.z
    L19_2 = 2
    L20_2 = 0
    L21_2 = 0
    L22_2 = 0
    L23_2 = false
    L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
    L11_2 = MISC
    L12_2 = "SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY"
    L11_2 = L11_2[L12_2]
    L12_2 = L9_2.x
    L13_2 = L9_2.y
    L14_2 = L9_2.z
    L15_2 = camAim_x
    L16_2 = camAim_y
    L17_2 = camAim_z
    L18_2 = 100
    L19_2 = true
    L20_2 = L0_2
    L21_2 = PLAYER
    L21_2 = L21_2.PLAYER_PED_ID
    L21_2 = L21_2()
    L22_2 = false
    L23_2 = true
    L24_2 = 100
    L25_2 = PLAYER
    L25_2 = L25_2.PLAYER_PED_ID
    L25_2 = L25_2()
    L26_2 = 0
    L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
    L11_2 = MISC
    L12_2 = "SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY"
    L11_2 = L11_2[L12_2]
    L12_2 = L10_2.x
    L13_2 = L10_2.y
    L14_2 = L10_2.z
    L15_2 = camAim_x
    L16_2 = camAim_y
    L17_2 = camAim_z
    L18_2 = 100
    L19_2 = true
    L20_2 = L0_2
    L21_2 = PLAYER
    L21_2 = L21_2.PLAYER_PED_ID
    L21_2 = L21_2()
    L22_2 = false
    L23_2 = true
    L24_2 = 100
    L25_2 = PLAYER
    L25_2 = L25_2.PLAYER_PED_ID
    L25_2 = L25_2()
    L26_2 = 0
    L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
  end
end
L71_1[L72_1] = L73_1
L71_1 = _ENV
L72_1 = "get_ped_nearby_vehicles"
function L73_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  if not A1_2 then
    A1_2 = 16
  end
  L2_2 = memory
  L2_2 = L2_2.alloc
  L3_2 = A1_2 + 1
  L3_2 = L3_2 * 8
  L2_2 = L2_2(L3_2)
  L3_2 = memory
  L3_2 = L3_2.write_int
  L4_2 = L2_2
  L5_2 = A1_2
  L3_2(L4_2, L5_2)
  L3_2 = {}
  L4_2 = 1
  L5_2 = PED
  L5_2 = L5_2.GET_PED_NEARBY_VEHICLES
  L6_2 = A0_2
  L7_2 = L2_2
  L5_2 = L5_2(L6_2, L7_2)
  L6_2 = 1
  for L7_2 = L4_2, L5_2, L6_2 do
    L8_2 = memory
    L8_2 = L8_2.read_int
    L9_2 = L7_2 * 8
    L9_2 = L2_2 + L9_2
    L8_2 = L8_2(L9_2)
    L3_2[L7_2] = L8_2
  end
  return L3_2
end
L71_1[L72_1] = L73_1
L71_1 = _ENV
L72_1 = "attachweapon"
function L73_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L1_2 = WEAPON
  L1_2 = L1_2.GET_WEAPONTYPE_GROUP
  L2_2 = HUD1
  L2_2 = L2_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
  L3_2 = plyped
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L3_2()
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  if 416676503 ~= L1_2 then
    L1_2 = WEAPON
    L1_2 = L1_2.GET_WEAPONTYPE_GROUP
    L2_2 = HUD1
    L2_2 = L2_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
    L3_2 = plyped
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L3_2()
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
    if 690389602 ~= L1_2 then
      goto lbl_46
    end
  end
  L1_2 = ENTITY
  L1_2 = L1_2.ATTACH_ENTITY_TO_ENTITY
  L2_2 = A0_2
  L3_2 = plyped
  L3_2 = L3_2()
  L4_2 = PED
  L4_2 = L4_2.GET_PED_BONE_INDEX
  L5_2 = plyped
  L5_2 = L5_2()
  L6_2 = 6442
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = 0.15
  L6_2 = 0
  L7_2 = 0.13
  L8_2 = 270
  L9_2 = 0
  L10_2 = 0
  L11_2 = false
  L12_2 = true
  L13_2 = false
  L14_2 = false
  L15_2 = 1
  L16_2 = true
  L17_2 = 0
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  ::lbl_46::
  L1_2 = WEAPON
  L1_2 = L1_2.GET_WEAPONTYPE_GROUP
  L2_2 = HUD1
  L2_2 = L2_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
  L3_2 = plyped
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L3_2()
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  if -728555052 ~= L1_2 then
    L1_2 = WEAPON
    L1_2 = L1_2.GET_WEAPONTYPE_GROUP
    L2_2 = HUD1
    L2_2 = L2_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
    L3_2 = plyped
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L3_2()
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
    if -1609580060 ~= L1_2 then
      goto lbl_467
    end
  end
  L1_2 = HUD1
  L1_2 = L1_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
  L2_2 = plyped
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "weapon_bat"
  L2_2 = L2_2(L3_2)
  if L1_2 == L2_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.ATTACH_ENTITY_TO_ENTITY
    L2_2 = A0_2
    L3_2 = plyped
    L3_2 = L3_2()
    L4_2 = PED
    L4_2 = L4_2.GET_PED_BONE_INDEX
    L5_2 = plyped
    L5_2 = L5_2()
    L6_2 = 24818
    L4_2 = L4_2(L5_2, L6_2)
    L5_2 = 0.3
    L6_2 = -0.18
    L7_2 = -0.15
    L8_2 = 0
    L9_2 = 300
    L10_2 = 0
    L11_2 = false
    L12_2 = true
    L13_2 = false
    L14_2 = false
    L15_2 = 1
    L16_2 = true
    L17_2 = 0
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  end
  L1_2 = HUD1
  L1_2 = L1_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
  L2_2 = plyped
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "weapon_crowbar"
  L2_2 = L2_2(L3_2)
  if L1_2 == L2_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.ATTACH_ENTITY_TO_ENTITY
    L2_2 = A0_2
    L3_2 = plyped
    L3_2 = L3_2()
    L4_2 = PED
    L4_2 = L4_2.GET_PED_BONE_INDEX
    L5_2 = plyped
    L5_2 = L5_2()
    L6_2 = 6442
    L4_2 = L4_2(L5_2, L6_2)
    L5_2 = 0.2
    L6_2 = 0
    L7_2 = 0.13
    L8_2 = 0
    L9_2 = 270
    L10_2 = 90
    L11_2 = false
    L12_2 = true
    L13_2 = false
    L14_2 = false
    L15_2 = 1
    L16_2 = true
    L17_2 = 0
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  end
  L1_2 = HUD1
  L1_2 = L1_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
  L2_2 = plyped
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "weapon_battleaxe"
  L2_2 = L2_2(L3_2)
  if L1_2 == L2_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.ATTACH_ENTITY_TO_ENTITY
    L2_2 = A0_2
    L3_2 = plyped
    L3_2 = L3_2()
    L4_2 = PED
    L4_2 = L4_2.GET_PED_BONE_INDEX
    L5_2 = plyped
    L5_2 = L5_2()
    L6_2 = 24818
    L4_2 = L4_2(L5_2, L6_2)
    L5_2 = 0.2
    L6_2 = -0.18
    L7_2 = -0.1
    L8_2 = 0
    L9_2 = 300
    L10_2 = 0
    L11_2 = false
    L12_2 = true
    L13_2 = false
    L14_2 = false
    L15_2 = 1
    L16_2 = true
    L17_2 = 0
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  end
  L1_2 = HUD1
  L1_2 = L1_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
  L2_2 = plyped
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "weapon_golfclub"
  L2_2 = L2_2(L3_2)
  if L1_2 == L2_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.ATTACH_ENTITY_TO_ENTITY
    L2_2 = A0_2
    L3_2 = plyped
    L3_2 = L3_2()
    L4_2 = PED
    L4_2 = L4_2.GET_PED_BONE_INDEX
    L5_2 = plyped
    L5_2 = L5_2()
    L6_2 = 24818
    L4_2 = L4_2(L5_2, L6_2)
    L5_2 = 0.2
    L6_2 = -0.18
    L7_2 = -0.1
    L8_2 = 0
    L9_2 = 300
    L10_2 = 0
    L11_2 = false
    L12_2 = true
    L13_2 = false
    L14_2 = false
    L15_2 = 1
    L16_2 = true
    L17_2 = 0
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  end
  L1_2 = HUD1
  L1_2 = L1_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
  L2_2 = plyped
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "weapon_hatchet"
  L2_2 = L2_2(L3_2)
  if L1_2 == L2_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.ATTACH_ENTITY_TO_ENTITY
    L2_2 = A0_2
    L3_2 = plyped
    L3_2 = L3_2()
    L4_2 = PED
    L4_2 = L4_2.GET_PED_BONE_INDEX
    L5_2 = plyped
    L5_2 = L5_2()
    L6_2 = 24818
    L4_2 = L4_2(L5_2, L6_2)
    L5_2 = 0.2
    L6_2 = -0.18
    L7_2 = -0.1
    L8_2 = 0
    L9_2 = 300
    L10_2 = 0
    L11_2 = false
    L12_2 = true
    L13_2 = false
    L14_2 = false
    L15_2 = 1
    L16_2 = true
    L17_2 = 0
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  end
  L1_2 = HUD1
  L1_2 = L1_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
  L2_2 = plyped
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "weapon_poolcue"
  L2_2 = L2_2(L3_2)
  if L1_2 == L2_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.ATTACH_ENTITY_TO_ENTITY
    L2_2 = A0_2
    L3_2 = plyped
    L3_2 = L3_2()
    L4_2 = PED
    L4_2 = L4_2.GET_PED_BONE_INDEX
    L5_2 = plyped
    L5_2 = L5_2()
    L6_2 = 24818
    L4_2 = L4_2(L5_2, L6_2)
    L5_2 = -0.2
    L6_2 = -0.18
    L7_2 = 0.1
    L8_2 = 0
    L9_2 = 120
    L10_2 = 0
    L11_2 = false
    L12_2 = true
    L13_2 = false
    L14_2 = false
    L15_2 = 1
    L16_2 = true
    L17_2 = 0
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  end
  L1_2 = HUD1
  L1_2 = L1_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
  L2_2 = plyped
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "weapon_stone_hatchet"
  L2_2 = L2_2(L3_2)
  if L1_2 == L2_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.ATTACH_ENTITY_TO_ENTITY
    L2_2 = A0_2
    L3_2 = plyped
    L3_2 = L3_2()
    L4_2 = PED
    L4_2 = L4_2.GET_PED_BONE_INDEX
    L5_2 = plyped
    L5_2 = L5_2()
    L6_2 = 24818
    L4_2 = L4_2(L5_2, L6_2)
    L5_2 = 0.2
    L6_2 = -0.18
    L7_2 = -0.1
    L8_2 = 0
    L9_2 = 300
    L10_2 = 0
    L11_2 = false
    L12_2 = true
    L13_2 = false
    L14_2 = false
    L15_2 = 1
    L16_2 = true
    L17_2 = 0
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  end
  L1_2 = HUD1
  L1_2 = L1_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
  L2_2 = plyped
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "weapon_knuckle"
  L2_2 = L2_2(L3_2)
  if L1_2 == L2_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.ATTACH_ENTITY_TO_ENTITY
    L2_2 = A0_2
    L3_2 = plyped
    L3_2 = L3_2()
    L4_2 = PED
    L4_2 = L4_2.GET_PED_BONE_INDEX
    L5_2 = plyped
    L5_2 = L5_2()
    L6_2 = 6442
    L4_2 = L4_2(L5_2, L6_2)
    L5_2 = 0.2
    L6_2 = 0
    L7_2 = 0.13
    L8_2 = 0
    L9_2 = 270
    L10_2 = 90
    L11_2 = false
    L12_2 = true
    L13_2 = false
    L14_2 = false
    L15_2 = 1
    L16_2 = true
    L17_2 = 0
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  end
  L1_2 = HUD1
  L1_2 = L1_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
  L2_2 = plyped
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "weapon_bat"
  L2_2 = L2_2(L3_2)
  if L1_2 ~= L2_2 then
    L1_2 = HUD1
    L1_2 = L1_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
    L2_2 = plyped
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2()
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
    L2_2 = util
    L2_2 = L2_2.joaat
    L3_2 = "weapon_crowbar"
    L2_2 = L2_2(L3_2)
    if L1_2 ~= L2_2 then
      L1_2 = HUD1
      L1_2 = L1_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
      L2_2 = plyped
      L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2()
      L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
      L2_2 = util
      L2_2 = L2_2.joaat
      L3_2 = "weapon_battleaxe"
      L2_2 = L2_2(L3_2)
      if L1_2 ~= L2_2 then
        L1_2 = HUD1
        L1_2 = L1_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
        L2_2 = plyped
        L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2()
        L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
        L2_2 = util
        L2_2 = L2_2.joaat
        L3_2 = "weapon_golfclub"
        L2_2 = L2_2(L3_2)
        if L1_2 ~= L2_2 then
          L1_2 = HUD1
          L1_2 = L1_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
          L2_2 = plyped
          L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2()
          L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
          L2_2 = util
          L2_2 = L2_2.joaat
          L3_2 = "weapon_hatchet"
          L2_2 = L2_2(L3_2)
          if L1_2 ~= L2_2 then
            L1_2 = HUD1
            L1_2 = L1_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
            L2_2 = plyped
            L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2()
            L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
            L2_2 = util
            L2_2 = L2_2.joaat
            L3_2 = "weapon_poolcue"
            L2_2 = L2_2(L3_2)
            if L1_2 ~= L2_2 then
              L1_2 = HUD1
              L1_2 = L1_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
              L2_2 = plyped
              L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2()
              L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
              L2_2 = util
              L2_2 = L2_2.joaat
              L3_2 = "weapon_stone_hatchet"
              L2_2 = L2_2(L3_2)
              if L1_2 ~= L2_2 then
                L1_2 = HUD1
                L1_2 = L1_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
                L2_2 = plyped
                L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2()
                L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
                L2_2 = util
                L2_2 = L2_2.joaat
                L3_2 = "weapon_knuckle"
                L2_2 = L2_2(L3_2)
                if L1_2 ~= L2_2 then
                  L1_2 = ENTITY
                  L1_2 = L1_2.ATTACH_ENTITY_TO_ENTITY
                  L2_2 = A0_2
                  L3_2 = plyped
                  L3_2 = L3_2()
                  L4_2 = PED
                  L4_2 = L4_2.GET_PED_BONE_INDEX
                  L5_2 = plyped
                  L5_2 = L5_2()
                  L6_2 = 6442
                  L4_2 = L4_2(L5_2, L6_2)
                  L5_2 = 0
                  L6_2 = 0
                  L7_2 = 0.13
                  L8_2 = 0
                  L9_2 = 90
                  L10_2 = 270
                  L11_2 = false
                  L12_2 = true
                  L13_2 = false
                  L14_2 = false
                  L15_2 = 1
                  L16_2 = true
                  L17_2 = 0
                  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
                end
              end
            end
          end
        end
      end
    end
  end
  ::lbl_467::
  L1_2 = WEAPON
  L1_2 = L1_2.GET_WEAPONTYPE_GROUP
  L2_2 = HUD1
  L2_2 = L2_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
  L3_2 = plyped
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L3_2()
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  if 1548507267 ~= L1_2 then
    L1_2 = WEAPON
    L1_2 = L1_2.GET_WEAPONTYPE_GROUP
    L2_2 = HUD1
    L2_2 = L2_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
    L3_2 = plyped
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L3_2()
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
    if -37788308 ~= L1_2 then
      L1_2 = WEAPON
      L1_2 = L1_2.GET_WEAPONTYPE_GROUP
      L2_2 = HUD1
      L2_2 = L2_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
      L3_2 = plyped
      L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L3_2()
      L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
      L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
      if 1595662460 ~= L1_2 then
        goto lbl_729
      end
    end
  end
  L1_2 = HUD1
  L1_2 = L1_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
  L2_2 = plyped
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "weapon_petrolcan"
  L2_2 = L2_2(L3_2)
  if L1_2 ~= L2_2 then
    L1_2 = HUD1
    L1_2 = L1_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
    L2_2 = plyped
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2()
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
    L2_2 = util
    L2_2 = L2_2.joaat
    L3_2 = "weapon_hazardcan"
    L2_2 = L2_2(L3_2)
    if L1_2 ~= L2_2 then
      L1_2 = HUD1
      L1_2 = L1_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
      L2_2 = plyped
      L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2()
      L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
      L2_2 = util
      L2_2 = L2_2.joaat
      L3_2 = "weapon_fertilizercan"
      L2_2 = L2_2(L3_2)
      if L1_2 ~= L2_2 then
        goto lbl_555
      end
    end
  end
  L1_2 = ENTITY
  L1_2 = L1_2.ATTACH_ENTITY_TO_ENTITY
  L2_2 = A0_2
  L3_2 = plyped
  L3_2 = L3_2()
  L4_2 = PED
  L4_2 = L4_2.GET_PED_BONE_INDEX
  L5_2 = plyped
  L5_2 = L5_2()
  L6_2 = 24818
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = 0
  L6_2 = -0.18
  L7_2 = 0
  L8_2 = 0
  L9_2 = 90
  L10_2 = 0
  L11_2 = false
  L12_2 = true
  L13_2 = false
  L14_2 = false
  L15_2 = 1
  L16_2 = true
  L17_2 = 0
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  ::lbl_555::
  L1_2 = HUD1
  L1_2 = L1_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
  L2_2 = plyped
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "weapon_proxmine"
  L2_2 = L2_2(L3_2)
  if L1_2 ~= L2_2 then
    L1_2 = HUD1
    L1_2 = L1_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
    L2_2 = plyped
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2()
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
    L2_2 = util
    L2_2 = L2_2.joaat
    L3_2 = "weapon_stickybomb"
    L2_2 = L2_2(L3_2)
    if L1_2 ~= L2_2 then
      goto lbl_602
    end
  end
  L1_2 = ENTITY
  L1_2 = L1_2.ATTACH_ENTITY_TO_ENTITY
  L2_2 = A0_2
  L3_2 = plyped
  L3_2 = L3_2()
  L4_2 = PED
  L4_2 = L4_2.GET_PED_BONE_INDEX
  L5_2 = plyped
  L5_2 = L5_2()
  L6_2 = 6442
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = 0.2
  L6_2 = 0
  L7_2 = 0.13
  L8_2 = 0
  L9_2 = 0
  L10_2 = 270
  L11_2 = false
  L12_2 = true
  L13_2 = false
  L14_2 = false
  L15_2 = 1
  L16_2 = true
  L17_2 = 0
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  ::lbl_602::
  L1_2 = HUD1
  L1_2 = L1_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
  L2_2 = plyped
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "weapon_fireextinguisher"
  L2_2 = L2_2(L3_2)
  if L1_2 == L2_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.ATTACH_ENTITY_TO_ENTITY
    L2_2 = A0_2
    L3_2 = plyped
    L3_2 = L3_2()
    L4_2 = PED
    L4_2 = L4_2.GET_PED_BONE_INDEX
    L5_2 = plyped
    L5_2 = L5_2()
    L6_2 = 6442
    L4_2 = L4_2(L5_2, L6_2)
    L5_2 = 0
    L6_2 = -0.05
    L7_2 = 0.13
    L8_2 = 0
    L9_2 = 270
    L10_2 = 90
    L11_2 = false
    L12_2 = true
    L13_2 = false
    L14_2 = false
    L15_2 = 1
    L16_2 = true
    L17_2 = 0
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  end
  L1_2 = HUD1
  L1_2 = L1_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
  L2_2 = plyped
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "weapon_petrolcan"
  L2_2 = L2_2(L3_2)
  if L1_2 ~= L2_2 then
    L1_2 = HUD1
    L1_2 = L1_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
    L2_2 = plyped
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2()
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
    L2_2 = util
    L2_2 = L2_2.joaat
    L3_2 = "weapon_hazardcan"
    L2_2 = L2_2(L3_2)
    if L1_2 ~= L2_2 then
      L1_2 = HUD1
      L1_2 = L1_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
      L2_2 = plyped
      L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2()
      L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
      L2_2 = util
      L2_2 = L2_2.joaat
      L3_2 = "weapon_fertilizercan"
      L2_2 = L2_2(L3_2)
      if L1_2 ~= L2_2 then
        L1_2 = HUD1
        L1_2 = L1_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
        L2_2 = plyped
        L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2()
        L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
        L2_2 = util
        L2_2 = L2_2.joaat
        L3_2 = "weapon_proxmine"
        L2_2 = L2_2(L3_2)
        if L1_2 ~= L2_2 then
          L1_2 = HUD1
          L1_2 = L1_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
          L2_2 = plyped
          L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2()
          L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
          L2_2 = util
          L2_2 = L2_2.joaat
          L3_2 = "weapon_stickybomb"
          L2_2 = L2_2(L3_2)
          if L1_2 ~= L2_2 then
            L1_2 = HUD1
            L1_2 = L1_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
            L2_2 = plyped
            L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2()
            L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
            L2_2 = util
            L2_2 = L2_2.joaat
            L3_2 = "weapon_fireextinguisher"
            L2_2 = L2_2(L3_2)
            if L1_2 ~= L2_2 then
              L1_2 = ENTITY
              L1_2 = L1_2.ATTACH_ENTITY_TO_ENTITY
              L2_2 = A0_2
              L3_2 = plyped
              L3_2 = L3_2()
              L4_2 = PED
              L4_2 = L4_2.GET_PED_BONE_INDEX
              L5_2 = plyped
              L5_2 = L5_2()
              L6_2 = 6442
              L4_2 = L4_2(L5_2, L6_2)
              L5_2 = 0.2
              L6_2 = 0
              L7_2 = 0.13
              L8_2 = 0
              L9_2 = 270
              L10_2 = 270
              L11_2 = false
              L12_2 = true
              L13_2 = false
              L14_2 = false
              L15_2 = 1
              L16_2 = true
              L17_2 = 0
              L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
            end
          end
        end
      end
    end
  end
  ::lbl_729::
  L1_2 = WEAPON
  L1_2 = L1_2.GET_WEAPONTYPE_GROUP
  L2_2 = HUD1
  L2_2 = L2_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
  L3_2 = plyped
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L3_2()
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  if 416676503 ~= L1_2 then
    L1_2 = WEAPON
    L1_2 = L1_2.GET_WEAPONTYPE_GROUP
    L2_2 = HUD1
    L2_2 = L2_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
    L3_2 = plyped
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L3_2()
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
    if 690389602 ~= L1_2 then
      L1_2 = WEAPON
      L1_2 = L1_2.GET_WEAPONTYPE_GROUP
      L2_2 = HUD1
      L2_2 = L2_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
      L3_2 = plyped
      L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L3_2()
      L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
      L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
      if -728555052 ~= L1_2 then
        L1_2 = WEAPON
        L1_2 = L1_2.GET_WEAPONTYPE_GROUP
        L2_2 = HUD1
        L2_2 = L2_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
        L3_2 = plyped
        L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L3_2()
        L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
        L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
        if -1609580060 ~= L1_2 then
          L1_2 = WEAPON
          L1_2 = L1_2.GET_WEAPONTYPE_GROUP
          L2_2 = HUD1
          L2_2 = L2_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
          L3_2 = plyped
          L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L3_2()
          L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
          L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
          if 1548507267 ~= L1_2 then
            L1_2 = WEAPON
            L1_2 = L1_2.GET_WEAPONTYPE_GROUP
            L2_2 = HUD1
            L2_2 = L2_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
            L3_2 = plyped
            L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L3_2()
            L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
            L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
            if -37788308 ~= L1_2 then
              L1_2 = WEAPON
              L1_2 = L1_2.GET_WEAPONTYPE_GROUP
              L2_2 = HUD1
              L2_2 = L2_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
              L3_2 = plyped
              L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L3_2()
              L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
              L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
              if 1595662460 ~= L1_2 then
                L1_2 = ENTITY
                L1_2 = L1_2.ATTACH_ENTITY_TO_ENTITY
                L2_2 = A0_2
                L3_2 = plyped
                L3_2 = L3_2()
                L4_2 = PED
                L4_2 = L4_2.GET_PED_BONE_INDEX
                L5_2 = plyped
                L5_2 = L5_2()
                L6_2 = 24818
                L4_2 = L4_2(L5_2, L6_2)
                L5_2 = 0
                L6_2 = -0.18
                L7_2 = 0
                L8_2 = 180
                L9_2 = 220
                L10_2 = 0
                L11_2 = false
                L12_2 = true
                L13_2 = false
                L14_2 = false
                L15_2 = 1
                L16_2 = true
                L17_2 = 0
                L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
              end
            end
          end
        end
      end
    end
  end
end
L71_1[L72_1] = L73_1
L71_1 = _ENV
L72_1 = "plyped"
function L73_1()
  local L0_2, L1_2
  L0_2 = PLAYER
  L0_2 = L0_2.PLAYER_PED_ID
  return L0_2()
end
L71_1[L72_1] = L73_1
L71_1 = _ENV
L72_1 = "flynotification123"
function L73_1(A0_2, A1_2, ...)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = assert
  L3_2 = type
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L3_2 = "string" == L3_2
  L4_2 = "msg must be a string, got "
  L5_2 = type
  L6_2 = A0_2
  L5_2 = L5_2(L6_2)
  L4_2 = L4_2 .. L5_2
  L2_2(L3_2, L4_2)
  L2_2 = string
  L2_2 = L2_2.format
  L3_2 = A0_2
  L4_2, L5_2, L6_2 = ...
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  L3_2 = HUD1
  L3_2 = L3_2._THEFEED_SET_NEXT_POST_BACKGROUND_COLOR
  L4_2 = A1_2 or L4_2
  if not A1_2 then
    L4_2 = self
    L4_2 = L4_2.defaultColour
  end
  L3_2(L4_2)
  L3_2 = util
  L3_2 = L3_2.BEGIN_TEXT_COMMAND_THEFEED_POST
  L4_2 = "~BLIP_INFO_ICON~ "
  L5_2 = L2_2
  L4_2 = L4_2 .. L5_2
  L3_2(L4_2)
  L3_2 = HUD
  L4_2 = "END_TEXT_COMMAND_THEFEED_POST_TICKER_WITH_TOKENS"
  L3_2 = L3_2[L4_2]
  L4_2 = true
  L5_2 = true
  L3_2(L4_2, L5_2)
end
L71_1[L72_1] = L73_1
L71_1 = 0
L72_1 = "按 ~%s~ ~%s~ ~%s~ ~%s~ 来使用地毯式骑行"
L73_1 = "按 ~%s~ 以移动得更快"
L74_1 = _ENV
L75_1 = "carpetridexx"
function L76_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  L0_2 = L71_1
  if 0 == L0_2 then
    L0_2 = util
    L0_2 = L0_2.joaat
    L1_2 = "p_cs_beachtowel_01_s"
    L0_2 = L0_2(L1_2)
    L1_2 = request_model
    L2_2 = L0_2
    L1_2(L2_2)
    L1_2 = request_anim_dict
    L2_2 = "rcmcollect_paperleadinout@"
    L1_2(L2_2)
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_PED_ID
    L1_2 = L1_2()
    L2_2 = ENTITY
    L2_2 = L2_2.GET_ENTITY_COORDS
    L3_2 = L1_2
    L4_2 = false
    L2_2 = L2_2(L3_2, L4_2)
    L3_2 = TASK
    L3_2 = L3_2.CLEAR_PED_TASKS_IMMEDIATELY
    L4_2 = L1_2
    L3_2(L4_2)
    L3_2 = entities
    L3_2 = L3_2.create_object
    L4_2 = L0_2
    L5_2 = L2_2
    L3_2 = L3_2(L4_2, L5_2)
    L38_1 = L3_2
    L3_2 = ENTITY
    L3_2 = L3_2.ATTACH_ENTITY_TO_ENTITY
    L4_2 = L1_2
    L5_2 = L38_1
    L6_2 = 0
    L7_2 = 0
    L8_2 = -0.2
    L9_2 = 1.0
    L10_2 = 1.0
    L11_2 = 1.0
    L12_2 = 1
    L13_2 = false
    L14_2 = true
    L15_2 = false
    L16_2 = false
    L17_2 = 0
    L18_2 = true
    L19_2 = 0
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
    L3_2 = ENTITY
    L3_2 = L3_2.SET_ENTITY_COMPLETELY_DISABLE_COLLISION
    L4_2 = L38_1
    L5_2 = false
    L6_2 = false
    L3_2(L4_2, L5_2, L6_2)
    L3_2 = TASK
    L3_2 = L3_2.TASK_PLAY_ANIM
    L4_2 = L1_2
    L5_2 = "rcmcollect_paperleadinout@"
    L6_2 = "meditiate_idle"
    L7_2 = 8.0
    L8_2 = -8.0
    L9_2 = -1
    L10_2 = 1
    L11_2 = 0.0
    L12_2 = false
    L13_2 = false
    L14_2 = false
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    L3_2 = flynotification123
    L4_2 = L72_1
    L5_2 = ".\n"
    L6_2 = L73_1
    L7_2 = "."
    L4_2 = L4_2 .. L5_2 .. L6_2 .. L7_2
    L5_2 = HudColour
    L5_2 = L5_2.black
    L6_2 = "INPUT_MOVE_UP_ONLY"
    L7_2 = "INPUT_MOVE_DOWN_ONLY"
    L8_2 = "INPUT_VEH_JUMP"
    L9_2 = "INPUT_DUCK"
    L10_2 = "INPUT_VEH_MOVE_UP_ONLY"
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
    L3_2 = 1
    L71_1 = L3_2
  else
    L0_2 = L71_1
    if 1 == L0_2 then
      L0_2 = HUD
      L0_2 = L0_2.DISPLAY_SNIPER_SCOPE_THIS_FRAME
      L0_2()
      L0_2 = ENTITY
      L0_2 = L0_2.GET_ENTITY_COORDS
      L1_2 = L38_1
      L2_2 = false
      L0_2 = L0_2(L1_2, L2_2)
      L1_2 = CAM
      L1_2 = L1_2.GET_GAMEPLAY_CAM_ROT
      L2_2 = 0
      L1_2 = L1_2(L2_2)
      L2_2 = ENTITY
      L2_2 = L2_2.SET_ENTITY_ROTATION
      L3_2 = L38_1
      L4_2 = 0
      L5_2 = 0
      L6_2 = L1_2.z
      L7_2 = 0
      L8_2 = true
      L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
      L2_2 = ENTITY
      L2_2 = L2_2.GET_ENTITY_FORWARD_VECTOR
      L3_2 = PLAYER
      L3_2 = L3_2.PLAYER_PED_ID
      L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L3_2()
      L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
      L2_2.z = 0.0
      L3_2 = v3
      L3_2 = L3_2.new
      L4_2 = 0
      L5_2 = 0
      L6_2 = 0
      L3_2 = L3_2(L4_2, L5_2, L6_2)
      L4_2 = 0.2
      L5_2 = PAD
      L5_2 = L5_2.IS_CONTROL_PRESSED
      L6_2 = 0
      L7_2 = 61
      L5_2 = L5_2(L6_2, L7_2)
      if L5_2 then
        L4_2 = 1.5
      end
      L5_2 = PAD
      L5_2 = L5_2.IS_CONTROL_PRESSED
      L6_2 = 0
      L7_2 = 32
      L5_2 = L5_2(L6_2, L7_2)
      if L5_2 then
        L5_2 = v3
        L5_2 = L5_2.new
        L6_2 = L2_2
        L5_2 = L5_2(L6_2)
        L3_2 = L5_2
        L6_2 = L3_2
        L5_2 = L3_2.mul
        L7_2 = L4_2
        L5_2(L6_2, L7_2)
      end
      L5_2 = PAD
      L5_2 = L5_2.IS_CONTROL_PRESSED
      L6_2 = 0
      L7_2 = 130
      L5_2 = L5_2(L6_2, L7_2)
      if L5_2 then
        L5_2 = v3
        L5_2 = L5_2.new
        L6_2 = L2_2
        L5_2 = L5_2(L6_2)
        L3_2 = L5_2
        L6_2 = L3_2
        L5_2 = L3_2.mul
        L7_2 = -L4_2
        L5_2(L6_2, L7_2)
      end
      L5_2 = PAD
      L5_2 = L5_2.IS_DISABLED_CONTROL_PRESSED
      L6_2 = 0
      L7_2 = 22
      L5_2 = L5_2(L6_2, L7_2)
      if L5_2 then
        L3_2.z = L4_2
      end
      L5_2 = PAD
      L5_2 = L5_2.IS_CONTROL_PRESSED
      L6_2 = 0
      L7_2 = 36
      L5_2 = L5_2(L6_2, L7_2)
      if L5_2 then
        L5_2 = -L4_2
        L3_2.z = L5_2
      end
      L5_2 = v3
      L5_2 = L5_2.new
      L6_2 = L0_2
      L5_2 = L5_2(L6_2)
      L7_2 = L5_2
      L6_2 = L5_2.add
      L8_2 = L3_2
      L6_2(L7_2, L8_2)
      L6_2 = ENTITY
      L6_2 = L6_2.SET_ENTITY_COORDS
      L7_2 = L38_1
      L8_2 = L5_2.x
      L9_2 = L5_2.y
      L10_2 = L5_2.z
      L11_2 = false
      L12_2 = false
      L13_2 = false
      L14_2 = false
      L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    end
  end
end
L74_1[L75_1] = L76_1
L74_1 = _ENV
L75_1 = "carpetridexx1"
function L76_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = TASK
  L0_2 = L0_2.CLEAR_PED_TASKS_IMMEDIATELY
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2 = L1_2()
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = ENTITY
  L0_2 = L0_2.DETACH_ENTITY
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = true
  L3_2 = false
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = ENTITY
  L0_2 = L0_2.DOES_ENTITY_EXIST
  L1_2 = L38_1
  L0_2 = L0_2(L1_2)
  if L0_2 then
    L0_2 = ENTITY
    L0_2 = L0_2.SET_ENTITY_VISIBLE
    L1_2 = L38_1
    L2_2 = false
    L3_2 = false
    L0_2(L1_2, L2_2, L3_2)
    L0_2 = delete_entity
    L1_2 = L38_1
    L0_2(L1_2)
  end
  L0_2 = 0
  L71_1 = L0_2
end
L74_1[L75_1] = L76_1
L74_1 = _ENV
L75_1 = "CARGO"
function L76_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2
  L0_2 = 0
  L1_2 = 31
  L2_2 = 1
  for L3_2 = L0_2, L1_2, L2_2 do
    L4_2 = PLAYER
    L4_2 = L4_2.GET_PLAYER_PED_SCRIPT_INDEX
    L5_2 = L3_2
    L4_2 = L4_2(L5_2)
    L5_2 = ENTITY
    L5_2 = L5_2.GET_ENTITY_COORDS
    L6_2 = L4_2
    L7_2 = true
    L5_2 = L5_2(L6_2, L7_2)
    L6_2 = CreateVehicle
    L7_2 = 4244420235
    L8_2 = L5_2
    L9_2 = ENTITY
    L9_2 = L9_2.GET_ENTITY_HEADING
    L10_2 = PLAYER
    L10_2 = L10_2.PLAYER_PED_ID
    L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2 = L10_2()
    L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2)
    L10_2 = true
    L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
    L7_2 = ENTITY
    L7_2 = L7_2.GET_ENTITY_COORDS
    L8_2 = L6_2
    L9_2 = true
    L7_2 = L7_2(L8_2, L9_2)
    L8_2 = CreateVehicle
    L9_2 = 410882957
    L10_2 = L5_2
    L11_2 = ENTITY
    L11_2 = L11_2.GET_ENTITY_HEADING
    L12_2 = PLAYER
    L12_2 = L12_2.PLAYER_PED_ID
    L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2 = L12_2()
    L11_2 = L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2)
    L12_2 = true
    L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2)
    L9_2 = ENTITY
    L9_2 = L9_2.GET_ENTITY_COORDS
    L10_2 = L8_2
    L11_2 = true
    L9_2 = L9_2(L10_2, L11_2)
    L10_2 = PHYSICS
    L10_2 = L10_2.ADD_ROPE
    L11_2 = L5_2.x
    L12_2 = L5_2.y
    L13_2 = L5_2.z
    L14_2 = 0
    L15_2 = 0
    L16_2 = 10
    L17_2 = 1
    L18_2 = 1
    L19_2 = 0
    L20_2 = 1
    L21_2 = 1
    L22_2 = false
    L23_2 = false
    L24_2 = false
    L25_2 = 1.0
    L26_2 = false
    L27_2 = 0
    L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2)
    L11_2 = PHYSICS
    L11_2 = L11_2.ATTACH_ENTITIES_TO_ROPE
    L12_2 = L10_2
    L13_2 = L6_2
    L14_2 = L8_2
    L15_2 = L7_2.x
    L16_2 = L7_2.y
    L17_2 = L7_2.z
    L18_2 = L9_2.x
    L19_2 = L9_2.y
    L20_2 = L9_2.z
    L21_2 = 2
    L22_2 = false
    L23_2 = false
    L24_2 = 0
    L25_2 = 0
    L26_2 = "Center"
    L27_2 = "Center"
    L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2)
    L11_2 = util
    L11_2 = L11_2.yield
    L12_2 = 2500
    L11_2(L12_2)
    L11_2 = delete_entity
    L12_2 = L6_2
    L11_2(L12_2)
    L11_2 = delete_entity
    L12_2 = L8_2
    L11_2(L12_2)
    L11_2 = PHYSICS
    L11_2 = L11_2.DELETE_CHILD_ROPE
    L12_2 = L10_2
    L11_2(L12_2)
  end
end
L74_1[L75_1] = L76_1
L74_1 = _ENV
L75_1 = "get_vehicles_in_player_range"
function L76_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L2_2 = {}
  L3_2 = players
  L3_2 = L3_2.get_position
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = ipairs
  L5_2 = entities
  L5_2 = L5_2.get_all_vehicles_as_handles
  L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L5_2()
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
    L10_2 = ENTITY
    L10_2 = L10_2.GET_ENTITY_COORDS
    L11_2 = L9_2
    L12_2 = true
    L10_2 = L10_2(L11_2, L12_2)
    L12_2 = L3_2
    L11_2 = L3_2.distance
    L13_2 = L10_2
    L11_2 = L11_2(L12_2, L13_2)
    if A1_2 >= L11_2 then
      L11_2 = table
      L11_2 = L11_2.insert
      L12_2 = L2_2
      L13_2 = L9_2
      L11_2(L12_2, L13_2)
    end
  end
  return L2_2
end
L74_1[L75_1] = L76_1
L74_1 = {}
L75_1 = "r"
L76_1 = 0
L74_1[L75_1] = L76_1
L75_1 = "g"
L76_1 = 255
L74_1[L75_1] = L76_1
L75_1 = "b"
L76_1 = 255
L74_1[L75_1] = L76_1
L75_1 = "a"
L76_1 = 255
L74_1[L75_1] = L76_1
L75_1 = _ENV
L76_1 = "draw_marker"
function L77_1(A0_2, A1_2, A2_2, A3_2, A4_2, A5_2)
  local L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2
  if not A5_2 then
    A5_2 = 0
  end
  L6_2 = GRAPHICS
  L6_2 = L6_2.DRAW_MARKER
  L7_2 = A0_2
  L8_2 = A1_2.x
  L9_2 = A1_2.y
  L10_2 = A1_2.z
  L11_2 = 0.0
  L12_2 = 0.0
  L13_2 = 0.0
  L14_2 = 0.0
  L15_2 = 0.0
  L16_2 = 0.0
  L17_2 = A2_2
  L18_2 = A2_2
  L19_2 = A2_2
  L20_2 = A3_2.r
  L21_2 = A3_2.g
  L22_2 = A3_2.b
  L23_2 = A3_2.a
  L24_2 = false
  L25_2 = false
  L26_2 = 0
  L27_2 = true
  L28_2 = A4_2
  L29_2 = A5_2
  L30_2 = false
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2)
end
L75_1[L76_1] = L77_1
L75_1 = _ENV
L76_1 = "rainbow_colour"
function L77_1(A0_2)
  local L1_2
  L1_2 = A0_2.r
  if L1_2 > 0 then
    L1_2 = A0_2.b
    if 0 == L1_2 then
      L1_2 = A0_2.r
      L1_2 = L1_2 - 1
      A0_2.r = L1_2
      L1_2 = A0_2.g
      L1_2 = L1_2 + 1
      A0_2.g = L1_2
    end
  end
  L1_2 = A0_2.g
  if L1_2 > 0 then
    L1_2 = A0_2.r
    if 0 == L1_2 then
      L1_2 = A0_2.g
      L1_2 = L1_2 - 1
      A0_2.g = L1_2
      L1_2 = A0_2.b
      L1_2 = L1_2 + 1
      A0_2.b = L1_2
    end
  end
  L1_2 = A0_2.b
  if L1_2 > 0 then
    L1_2 = A0_2.g
    if 0 == L1_2 then
      L1_2 = A0_2.r
      L1_2 = L1_2 + 1
      A0_2.r = L1_2
      L1_2 = A0_2.b
      L1_2 = L1_2 - 1
      A0_2.b = L1_2
    end
  end
end
L75_1[L76_1] = L77_1
L75_1 = _ENV
L76_1 = "selectedOpt"
L77_1 = 1
L75_1[L76_1] = L77_1
L75_1 = _ENV
L76_1 = "ciliqiang"
function L77_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2
  L0_2 = PLAYER
  L0_2 = L0_2.IS_PLAYER_FREE_AIMING
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
  if not L0_2 then
    return
  end
  L0_2 = 0
  L1_2 = get_offset_from_cam
  L2_2 = 30.0
  L1_2 = L1_2(L2_2)
  L2_2 = get_vehicles_in_player_range
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_ID
  L3_2 = L3_2()
  L4_2 = 70.0
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = rainbow_colour
  L4_2 = L74_1
  L3_2(L4_2)
  L3_2 = draw_marker
  L4_2 = 28
  L5_2 = L1_2
  L6_2 = 0.4
  L7_2 = L74_1
  L3_2(L4_2, L5_2, L6_2, L7_2)
  L3_2 = ipairs
  L4_2 = L2_2
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = PED
    L9_2 = L9_2.GET_VEHICLE_PED_IS_USING
    L10_2 = PLAYER
    L10_2 = L10_2.PLAYER_PED_ID
    L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2 = L10_2()
    L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
    if L9_2 ~= L8_2 and L0_2 < 20 then
      L9_2 = request_control
      L10_2 = L8_2
      L9_2 = L9_2(L10_2)
      if L9_2 then
        L0_2 = L0_2 + 1
        L9_2 = ENTITY
        L9_2 = L9_2.GET_ENTITY_COORDS
        L10_2 = L8_2
        L11_2 = false
        L9_2 = L9_2(L10_2, L11_2)
        L10_2 = v3
        L10_2 = L10_2.new
        L11_2 = L1_2
        L10_2 = L10_2(L11_2)
        L12_2 = L10_2
        L11_2 = L10_2.sub
        L13_2 = L9_2
        L11_2(L12_2, L13_2)
        L11_2 = selectedOpt
        if 1 == L11_2 then
          L11_2 = ENTITY
          L11_2 = L11_2.SET_ENTITY_VELOCITY
          L12_2 = L8_2
          L13_2 = L10_2.x
          L14_2 = L10_2.y
          L15_2 = L10_2.z
          L11_2(L12_2, L13_2, L14_2, L15_2)
        else
          L11_2 = selectedOpt
          if 2 == L11_2 then
            L12_2 = L10_2
            L11_2 = L10_2.mul
            L13_2 = 0.5
            L11_2(L12_2, L13_2)
            L11_2 = ENTITY
            L11_2 = L11_2.APPLY_FORCE_TO_ENTITY
            L12_2 = L8_2
            L13_2 = 1
            L14_2 = L10_2.x
            L15_2 = L10_2.y
            L16_2 = L10_2.z
            L17_2 = 0.0
            L18_2 = 0.0
            L19_2 = 0.5
            L20_2 = 0
            L21_2 = false
            L22_2 = false
            L23_2 = true
            L24_2 = false
            L25_2 = false
            L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
          end
        end
      end
    end
  end
end
L75_1[L76_1] = L77_1
L75_1 = _ENV
L76_1 = "szclq"
function L77_1(A0_2)
  local L1_2
  selectedOpt = A0_2
end
L75_1[L76_1] = L77_1
L75_1 = _ENV
L76_1 = "kxq"
function L77_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L0_2 = util
  L0_2 = L0_2.joaat
  L1_2 = "weapon_airstrike_rocket"
  L0_2 = L0_2(L1_2)
  L1_2 = WEAPON
  L1_2 = L1_2.REQUEST_WEAPON_ASSET
  L2_2 = L0_2
  L3_2 = 31
  L4_2 = 0
  L1_2(L2_2, L3_2, L4_2)
  L1_2 = get_raycast_result
  L2_2 = 1000.0
  L1_2 = L1_2(L2_2)
  L2_2 = L1_2.didHit
  if L2_2 then
    L2_2 = PED
    L2_2 = L2_2.IS_PED_SHOOTING
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2 = L3_2()
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
    if L2_2 then
      L2_2 = L1_2.endCoords
      L3_2 = MISC
      L3_2 = L3_2.SHOOT_SINGLE_BULLET_BETWEEN_COORDS
      L4_2 = L2_2.x
      L5_2 = L2_2.y
      L6_2 = L2_2.z
      L6_2 = L6_2 + 35.0
      L7_2 = L2_2.x
      L8_2 = L2_2.y
      L9_2 = L2_2.z
      L10_2 = 200
      L11_2 = true
      L12_2 = L0_2
      L13_2 = PLAYER
      L13_2 = L13_2.PLAYER_PED_ID
      L13_2 = L13_2()
      L14_2 = true
      L15_2 = false
      L16_2 = 2500.0
      L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
    end
  end
end
L75_1[L76_1] = L77_1
function L75_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = memory
  L2_2 = L2_2.write_float
  L3_2 = A0_2 + 0
  L4_2 = A1_2.x
  L2_2(L3_2, L4_2)
  L2_2 = memory
  L2_2 = L2_2.write_float
  L3_2 = A0_2 + 4
  L4_2 = A1_2.y
  L2_2(L3_2, L4_2)
  L2_2 = memory
  L2_2 = L2_2.write_float
  L3_2 = A0_2 + 8
  L4_2 = A1_2.z
  L2_2(L3_2, L4_2)
end
function L76_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = entities
  L2_2 = L2_2.handle_to_pointer
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = memory
  L3_2 = L3_2.read_long
  L4_2 = L2_2 + 48
  L3_2 = L3_2(L4_2)
  if 0 ~= L3_2 then
    L4_2 = L75_1
    L5_2 = L3_2 + 80
    L6_2 = A1_2
    L4_2(L5_2, L6_2)
    L4_2 = L75_1
    L5_2 = L2_2 + 144
    L6_2 = A1_2
    L4_2(L5_2, L6_2)
  end
end
L77_1 = _ENV
L78_1 = "csq"
function L79_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L0_2 = get_raycast_result
  L1_2 = 1000.0
  L0_2 = L0_2(L1_2)
  L1_2 = L0_2.didHit
  if L1_2 then
    L1_2 = PED
    L1_2 = L1_2.IS_PED_SHOOTING
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L2_2()
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
    if L1_2 then
      L1_2 = L0_2.endCoords
      L2_2 = PED
      L2_2 = L2_2.IS_PED_IN_ANY_VEHICLE
      L3_2 = PLAYER
      L3_2 = L3_2.PLAYER_PED_ID
      L3_2 = L3_2()
      L4_2 = false
      L2_2 = L2_2(L3_2, L4_2)
      if not L2_2 then
        L2_2 = L1_2.z
        L2_2 = L2_2 + 1.0
        L1_2.z = L2_2
        L2_2 = L76_1
        L3_2 = PLAYER
        L3_2 = L3_2.PLAYER_PED_ID
        L3_2 = L3_2()
        L4_2 = L1_2
        L2_2(L3_2, L4_2)
      else
        L2_2 = PED
        L2_2 = L2_2.GET_VEHICLE_PED_IS_IN
        L3_2 = PLAYER
        L3_2 = L3_2.PLAYER_PED_ID
        L3_2 = L3_2()
        L4_2 = false
        L2_2 = L2_2(L3_2, L4_2)
        L3_2 = ENTITY
        L3_2 = L3_2.GET_ENTITY_SPEED
        L4_2 = L2_2
        L3_2 = L3_2(L4_2)
        L4_2 = ENTITY
        L4_2 = L4_2.SET_ENTITY_COORDS
        L5_2 = L2_2
        L6_2 = L1_2.x
        L7_2 = L1_2.y
        L8_2 = L1_2.z
        L9_2 = false
        L10_2 = false
        L11_2 = false
        L12_2 = false
        L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
        L4_2 = ENTITY
        L4_2 = L4_2.SET_ENTITY_HEADING
        L5_2 = L2_2
        L6_2 = CAM
        L6_2 = L6_2.GET_GAMEPLAY_CAM_ROT
        L7_2 = 0
        L6_2 = L6_2(L7_2)
        L6_2 = L6_2.z
        L4_2(L5_2, L6_2)
        L4_2 = VEHICLE
        L4_2 = L4_2.SET_VEHICLE_FORWARD_SPEED
        L5_2 = L2_2
        L6_2 = L3_2 + 3.0
        L4_2(L5_2, L6_2)
      end
    end
  end
end
L77_1[L78_1] = L79_1
L77_1 = _ENV
L78_1 = "steal_car_gun"
function L79_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L0_2 = PED
  L0_2 = L0_2.IS_PED_SHOOTING
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2)
  if L0_2 then
    L0_2 = get_entity_player_is_aiming_at
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_ID
    L1_2, L2_2, L3_2, L4_2, L5_2, L6_2 = L1_2()
    L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2)
    L1_2 = ENTITY
    L1_2 = L1_2.IS_ENTITY_A_VEHICLE
    L2_2 = L0_2
    L1_2 = L1_2(L2_2)
    if L1_2 then
      L1_2 = VEHICLE
      L1_2 = L1_2.GET_PED_IN_VEHICLE_SEAT
      L2_2 = L0_2
      L3_2 = -1
      L1_2 = L1_2(L2_2, L3_2)
      L2_2 = PED
      L2_2 = L2_2.IS_PED_A_PLAYER
      L3_2 = L1_2
      L2_2 = L2_2(L3_2)
      if L2_2 then
        L2_2 = NETWORK
        L2_2 = L2_2.NETWORK_GET_PLAYER_INDEX_FROM_PED
        L3_2 = L1_2
        L2_2 = L2_2(L3_2)
        L3_2 = menu
        L3_2 = L3_2.trigger_commands
        L4_2 = "vehkick"
        L5_2 = players
        L5_2 = L5_2.get_name
        L6_2 = L2_2
        L5_2 = L5_2(L6_2)
        L4_2 = L4_2 .. L5_2
        L3_2(L4_2)
      else
        L2_2 = ENTITY
        L2_2 = L2_2.DOES_ENTITY_EXIST
        L3_2 = L1_2
        L2_2 = L2_2(L3_2)
        if L2_2 then
          L2_2 = PED
          L2_2 = L2_2.IS_PED_A_PLAYER
          L3_2 = L1_2
          L2_2 = L2_2(L3_2)
          if not L2_2 then
            L2_2 = request_control
            L3_2 = L1_2
            L2_2(L3_2)
            L2_2 = delete_entity
            L3_2 = L1_2
            L2_2(L3_2)
          end
        end
      end
      L2_2 = PED
      L2_2 = L2_2.SET_PED_INTO_VEHICLE
      L3_2 = PLAYER
      L3_2 = L3_2.PLAYER_PED_ID
      L3_2 = L3_2()
      L4_2 = L0_2
      L5_2 = -1
      L2_2(L3_2, L4_2, L5_2)
    end
  end
end
L77_1[L78_1] = L79_1
L77_1 = _ENV
L78_1 = "fghd"
function L79_1()
  local L0_2, L1_2, L2_2
  L0_2 = TASK
  L0_2 = L0_2.GET_IS_TASK_ACTIVE
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = 4
  L0_2 = L0_2(L1_2, L2_2)
  if L0_2 then
    L0_2 = PAD
    L0_2 = L0_2.IS_CONTROL_PRESSED
    L1_2 = 2
    L2_2 = 22
    L0_2 = L0_2(L1_2, L2_2)
    if L0_2 then
      L0_2 = PED
      L0_2 = L0_2.IS_PED_SHOOTING
      L1_2 = PLAYER
      L1_2 = L1_2.PLAYER_PED_ID
      L1_2, L2_2 = L1_2()
      L0_2 = L0_2(L1_2, L2_2)
      if not L0_2 then
        L0_2 = util
        L0_2 = L0_2.yield
        L1_2 = 900
        L0_2(L1_2)
        L0_2 = WEAPON
        L0_2 = L0_2.REFILL_AMMO_INSTANTLY
        L1_2 = PLAYER
        L1_2 = L1_2.PLAYER_PED_ID
        L1_2, L2_2 = L1_2()
        L0_2(L1_2, L2_2)
      end
    end
  end
end
L77_1[L78_1] = L79_1
L77_1 = _ENV
L78_1 = "shouzhiqiang"
function L79_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L0_2 = pairs
  L1_2 = weapon_stuff
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = L5_2[1]
    L7_2 = L5_2[2]
    L8_2 = util
    L8_2 = L8_2.joaat
    L9_2 = L7_2
    L8_2 = L8_2(L9_2)
    L9_2 = request_weapon_asset
    L10_2 = L8_2
    L9_2(L10_2)
    L9_2 = menu
    L9_2 = L9_2.toggle
    L10_2 = finger_thing
    L11_2 = L6_2
    L12_2 = {}
    L13_2 = ""
    function L14_2(A0_3)
      local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3
      finger_gund = A0_3
      while true do
        L1_3 = finger_gund
        if not L1_3 then
          break
        end
        L1_3 = memory
        L1_3 = L1_3.read_int
        L2_3 = memory
        L2_3 = L2_3.script_global
        L3_3 = 4522731
        L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3 = L2_3(L3_3)
        L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3)
        if 3 == L1_3 then
          L1_3 = memory
          L1_3 = L1_3.write_int
          L2_3 = memory
          L2_3 = L2_3.script_global
          L3_3 = 4522736
          L2_3 = L2_3(L3_3)
          L3_3 = NETWORK
          L3_3 = L3_3.GET_NETWORK_TIME
          L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3 = L3_3()
          L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3)
          L1_3 = v3
          L1_3 = L1_3.new
          L1_3 = L1_3()
          L2_3 = v3
          L2_3 = L2_3.set
          L3_3 = L1_3
          L4_3 = CAM
          L4_3 = L4_3.GET_FINAL_RENDERED_CAM_ROT
          L5_3 = 2
          L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3 = L4_3(L5_3)
          L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3)
          L2_3 = v3
          L2_3 = L2_3.toDir
          L3_3 = L1_3
          L2_3 = L2_3(L3_3)
          L3_3 = v3
          L3_3 = L3_3.set
          L4_3 = L1_3
          L5_3 = v3
          L5_3 = L5_3.get
          L6_3 = L2_3
          L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3 = L5_3(L6_3)
          L3_3(L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3)
          L3_3 = v3
          L3_3 = L3_3.mul
          L4_3 = L1_3
          L5_3 = 1000
          L3_3(L4_3, L5_3)
          L3_3 = v3
          L3_3 = L3_3.set
          L4_3 = L2_3
          L5_3 = CAM
          L5_3 = L5_3.GET_FINAL_RENDERED_CAM_COORD
          L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3 = L5_3()
          L3_3(L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3)
          L3_3 = v3
          L3_3 = L3_3.add
          L4_3 = L1_3
          L5_3 = L2_3
          L3_3(L4_3, L5_3)
          L3_3 = v3
          L3_3 = L3_3.get
          L4_3 = L1_3
          L3_3, L4_3, L5_3 = L3_3(L4_3)
          L6_3 = PED
          L6_3 = L6_3.GET_PED_BONE_COORDS
          L7_3 = PLAYER
          L7_3 = L7_3.PLAYER_PED_ID
          L7_3 = L7_3()
          L8_3 = 4089
          L9_3 = 1.0
          L10_3 = 0
          L11_3 = 0
          L6_3 = L6_3(L7_3, L8_3, L9_3, L10_3, L11_3)
          L7_3 = MISC
          L8_3 = "SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY"
          L7_3 = L7_3[L8_3]
          L8_3 = L6_3.x
          L9_3 = L6_3.y
          L10_3 = L6_3.z
          L11_3 = L3_3
          L12_3 = L4_3
          L13_3 = L5_3
          L14_3 = 1
          L15_3 = true
          L16_3 = L8_2
          L17_3 = 0
          L18_3 = true
          L19_3 = false
          L20_3 = 500.0
          L21_3 = PLAYER
          L21_3 = L21_3.PLAYER_PED_ID
          L21_3 = L21_3()
          L22_3 = 0
          L7_3(L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3)
        end
        L1_3 = util
        L1_3 = L1_3.yield
        L2_3 = 100
        L1_3(L2_3)
      end
      L1_3 = ENTITY
      L1_3 = L1_3.GET_ENTITY_COORDS
      L2_3 = PLAYER
      L2_3 = L2_3.PLAYER_PED_ID
      L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3 = L2_3()
      L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3)
      L2_3 = MISC
      L2_3 = L2_3.CLEAR_AREA_OF_PROJECTILES
      L3_3 = L1_3.x
      L4_3 = L1_3.y
      L5_3 = L1_3.z
      L6_3 = 999999
      L7_3 = 0
      L2_3(L3_3, L4_3, L5_3, L6_3, L7_3)
    end
    L9_2(L10_2, L11_2, L12_2, L13_2, L14_2)
  end
end
L77_1[L78_1] = L79_1
L77_1 = _ENV
L78_1 = "get_offset_from_cam"
function L79_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = CAM
  L1_2 = L1_2.GET_FINAL_RENDERED_CAM_ROT
  L2_2 = 2
  L1_2 = L1_2(L2_2)
  L2_2 = CAM
  L2_2 = L2_2.GET_FINAL_RENDERED_CAM_COORD
  L2_2 = L2_2()
  L4_2 = L1_2
  L3_2 = L1_2.toDir
  L3_2 = L3_2(L4_2)
  L5_2 = L3_2
  L4_2 = L3_2.mul
  L6_2 = A0_2
  L4_2(L5_2, L6_2)
  L4_2 = v3
  L4_2 = L4_2.new
  L5_2 = L2_2
  L4_2 = L4_2(L5_2)
  L6_2 = L4_2
  L5_2 = L4_2.add
  L7_2 = L3_2
  L5_2(L6_2, L7_2)
  return L4_2
end
L77_1[L78_1] = L79_1
L77_1 = _ENV
L78_1 = "get_raycast_result"
function L79_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  L2_2 = {}
  if not A1_2 then
    L3_2 = TraceFlag
    A1_2 = L3_2.everything
  end
  L3_2 = memory
  L3_2 = L3_2.alloc
  L4_2 = 1
  L3_2 = L3_2(L4_2)
  L4_2 = v3
  L4_2 = L4_2.new
  L4_2 = L4_2()
  L5_2 = v3
  L5_2 = L5_2.new
  L5_2 = L5_2()
  L6_2 = memory
  L6_2 = L6_2.alloc_int
  L6_2 = L6_2()
  L7_2 = CAM
  L7_2 = L7_2.GET_FINAL_RENDERED_CAM_COORD
  L7_2 = L7_2()
  L8_2 = get_offset_from_cam
  L9_2 = A0_2
  L8_2 = L8_2(L9_2)
  L9_2 = SHAPETEST
  L10_2 = "START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE"
  L9_2 = L9_2[L10_2]
  L10_2 = L7_2.x
  L11_2 = L7_2.y
  L12_2 = L7_2.z
  L13_2 = L8_2.x
  L14_2 = L8_2.y
  L15_2 = L8_2.z
  L16_2 = A1_2
  L17_2 = PLAYER
  L17_2 = L17_2.PLAYER_PED_ID
  L17_2 = L17_2()
  L18_2 = 7
  L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  L10_2 = SHAPETEST
  L10_2 = L10_2.GET_SHAPE_TEST_RESULT
  L11_2 = L9_2
  L12_2 = L3_2
  L13_2 = L4_2
  L14_2 = L5_2
  L15_2 = L6_2
  L10_2(L11_2, L12_2, L13_2, L14_2, L15_2)
  L10_2 = memory
  L10_2 = L10_2.read_byte
  L11_2 = L3_2
  L10_2 = L10_2(L11_2)
  L10_2 = 0 ~= L10_2
  L2_2.didHit = L10_2
  L2_2.endCoords = L4_2
  L2_2.surfaceNormal = L5_2
  L10_2 = memory
  L10_2 = L10_2.read_int
  L11_2 = L6_2
  L10_2 = L10_2(L11_2)
  L2_2.hitEntity = L10_2
  return L2_2
end
L77_1[L78_1] = L79_1
L77_1 = _ENV
L78_1 = "draw_line"
function L79_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L3_2 = GRAPHICS
  L3_2 = L3_2.DRAW_LINE
  L4_2 = A0_2.x
  L5_2 = A0_2.y
  L6_2 = A0_2.z
  L7_2 = A1_2.x
  L8_2 = A1_2.y
  L9_2 = A1_2.z
  L10_2 = A2_2.r
  L11_2 = A2_2.g
  L12_2 = A2_2.b
  L13_2 = A2_2.a
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
end
L77_1[L78_1] = L79_1
L77_1 = _ENV
L78_1 = "draw_rect"
function L79_1(A0_2, A1_2, A2_2, A3_2, A4_2)
  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  L5_2 = GRAPHICS
  L5_2 = L5_2.DRAW_POLY
  L6_2 = A0_2.x
  L7_2 = A0_2.y
  L8_2 = A0_2.z
  L9_2 = A1_2.x
  L10_2 = A1_2.y
  L11_2 = A1_2.z
  L12_2 = A3_2.x
  L13_2 = A3_2.y
  L14_2 = A3_2.z
  L15_2 = A4_2.r
  L16_2 = A4_2.g
  L17_2 = A4_2.b
  L18_2 = A4_2.a
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  L5_2 = GRAPHICS
  L5_2 = L5_2.DRAW_POLY
  L6_2 = A3_2.x
  L7_2 = A3_2.y
  L8_2 = A3_2.z
  L9_2 = A2_2.x
  L10_2 = A2_2.y
  L11_2 = A2_2.z
  L12_2 = A0_2.x
  L13_2 = A0_2.y
  L14_2 = A0_2.z
  L15_2 = A4_2.r
  L16_2 = A4_2.g
  L17_2 = A4_2.b
  L18_2 = A4_2.a
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
end
L77_1[L78_1] = L79_1
L77_1 = _ENV
L78_1 = "draw_bounding_box"
function L79_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  L3_2 = ENTITY
  L3_2 = L3_2.DOES_ENTITY_EXIST
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  if not L3_2 then
    return
  end
  if not A2_2 then
    L3_2 = {}
    L3_2.r = 255
    L3_2.g = 0
    L3_2.b = 0
    L3_2.a = 255
    A2_2 = L3_2
  end
  L3_2 = v3
  L3_2 = L3_2.new
  L3_2 = L3_2()
  L4_2 = v3
  L4_2 = L4_2.new
  L4_2 = L4_2()
  L5_2 = MISC
  L5_2 = L5_2.GET_MODEL_DIMENSIONS
  L6_2 = ENTITY
  L6_2 = L6_2.GET_ENTITY_MODEL
  L7_2 = A0_2
  L6_2 = L6_2(L7_2)
  L7_2 = L3_2
  L8_2 = L4_2
  L5_2(L6_2, L7_2, L8_2)
  L6_2 = L3_2
  L5_2 = L3_2.abs
  L5_2(L6_2)
  L6_2 = L4_2
  L5_2 = L4_2.abs
  L5_2(L6_2)
  L5_2 = ENTITY
  L5_2 = L5_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L6_2 = A0_2
  L7_2 = L4_2.x
  L7_2 = -L7_2
  L8_2 = L4_2.y
  L8_2 = -L8_2
  L9_2 = L4_2.z
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
  L6_2 = ENTITY
  L6_2 = L6_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L7_2 = A0_2
  L8_2 = L3_2.x
  L9_2 = L4_2.y
  L9_2 = -L9_2
  L10_2 = L4_2.z
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
  L7_2 = ENTITY
  L7_2 = L7_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L8_2 = A0_2
  L9_2 = L4_2.x
  L9_2 = -L9_2
  L10_2 = L4_2.y
  L10_2 = -L10_2
  L11_2 = L3_2.z
  L11_2 = -L11_2
  L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2)
  L8_2 = ENTITY
  L8_2 = L8_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L9_2 = A0_2
  L10_2 = L3_2.x
  L11_2 = L4_2.y
  L11_2 = -L11_2
  L12_2 = L3_2.z
  L12_2 = -L12_2
  L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2)
  L9_2 = draw_line
  L10_2 = L5_2
  L11_2 = L6_2
  L12_2 = A2_2
  L9_2(L10_2, L11_2, L12_2)
  L9_2 = draw_line
  L10_2 = L7_2
  L11_2 = L8_2
  L12_2 = A2_2
  L9_2(L10_2, L11_2, L12_2)
  L9_2 = draw_line
  L10_2 = L5_2
  L11_2 = L7_2
  L12_2 = A2_2
  L9_2(L10_2, L11_2, L12_2)
  L9_2 = draw_line
  L10_2 = L6_2
  L11_2 = L8_2
  L12_2 = A2_2
  L9_2(L10_2, L11_2, L12_2)
  L9_2 = ENTITY
  L9_2 = L9_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L10_2 = A0_2
  L11_2 = L4_2.x
  L11_2 = -L11_2
  L12_2 = L3_2.y
  L13_2 = L4_2.z
  L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2)
  L10_2 = ENTITY
  L10_2 = L10_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L11_2 = A0_2
  L12_2 = L3_2.x
  L13_2 = L3_2.y
  L14_2 = L4_2.z
  L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2)
  L11_2 = ENTITY
  L11_2 = L11_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L12_2 = A0_2
  L13_2 = L4_2.x
  L13_2 = -L13_2
  L14_2 = L3_2.y
  L15_2 = L3_2.z
  L15_2 = -L15_2
  L11_2 = L11_2(L12_2, L13_2, L14_2, L15_2)
  L12_2 = ENTITY
  L12_2 = L12_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L13_2 = A0_2
  L14_2 = L3_2.x
  L15_2 = L3_2.y
  L16_2 = L3_2.z
  L16_2 = -L16_2
  L12_2 = L12_2(L13_2, L14_2, L15_2, L16_2)
  L13_2 = draw_line
  L14_2 = L9_2
  L15_2 = L10_2
  L16_2 = A2_2
  L13_2(L14_2, L15_2, L16_2)
  L13_2 = draw_line
  L14_2 = L11_2
  L15_2 = L12_2
  L16_2 = A2_2
  L13_2(L14_2, L15_2, L16_2)
  L13_2 = draw_line
  L14_2 = L9_2
  L15_2 = L11_2
  L16_2 = A2_2
  L13_2(L14_2, L15_2, L16_2)
  L13_2 = draw_line
  L14_2 = L10_2
  L15_2 = L12_2
  L16_2 = A2_2
  L13_2(L14_2, L15_2, L16_2)
  L13_2 = draw_line
  L14_2 = L5_2
  L15_2 = L9_2
  L16_2 = A2_2
  L13_2(L14_2, L15_2, L16_2)
  L13_2 = draw_line
  L14_2 = L6_2
  L15_2 = L10_2
  L16_2 = A2_2
  L13_2(L14_2, L15_2, L16_2)
  L13_2 = draw_line
  L14_2 = L7_2
  L15_2 = L11_2
  L16_2 = A2_2
  L13_2(L14_2, L15_2, L16_2)
  L13_2 = draw_line
  L14_2 = L8_2
  L15_2 = L12_2
  L16_2 = A2_2
  L13_2(L14_2, L15_2, L16_2)
  L13_2 = type
  L14_2 = A1_2
  L13_2 = L13_2(L14_2)
  if "boolean" ~= L13_2 or A1_2 then
    L13_2 = draw_rect
    L14_2 = L7_2
    L15_2 = L5_2
    L16_2 = L11_2
    L17_2 = L9_2
    L18_2 = A2_2
    L13_2(L14_2, L15_2, L16_2, L17_2, L18_2)
    L13_2 = draw_rect
    L14_2 = L6_2
    L15_2 = L8_2
    L16_2 = L10_2
    L17_2 = L12_2
    L18_2 = A2_2
    L13_2(L14_2, L15_2, L16_2, L17_2, L18_2)
    L13_2 = draw_rect
    L14_2 = L11_2
    L15_2 = L9_2
    L16_2 = L12_2
    L17_2 = L10_2
    L18_2 = A2_2
    L13_2(L14_2, L15_2, L16_2, L17_2, L18_2)
    L13_2 = draw_rect
    L14_2 = L5_2
    L15_2 = L7_2
    L16_2 = L6_2
    L17_2 = L8_2
    L18_2 = A2_2
    L13_2(L14_2, L15_2, L16_2, L17_2, L18_2)
    L13_2 = draw_rect
    L14_2 = L6_2
    L15_2 = L10_2
    L16_2 = L5_2
    L17_2 = L9_2
    L18_2 = A2_2
    L13_2(L14_2, L15_2, L16_2, L17_2, L18_2)
    L13_2 = draw_rect
    L14_2 = L12_2
    L15_2 = L8_2
    L16_2 = L11_2
    L17_2 = L7_2
    L18_2 = A2_2
    L13_2(L14_2, L15_2, L16_2, L17_2, L18_2)
  end
end
L77_1[L78_1] = L79_1
L77_1 = _ENV
L78_1 = "NULL"
L77_1 = L77_1[L78_1]
L78_1 = false
L79_1 = _ENV
L80_1 = "is_player_pointing"
function L81_1()
  local L0_2, L1_2
  L0_2 = read_global
  L0_2 = L0_2.int
  L1_2 = 4522731
  L0_2 = L0_2(L1_2)
  L0_2 = 3 == L0_2
  return L0_2
end
L79_1[L80_1] = L81_1
L79_1 = _ENV
L80_1 = "godfinger"
function L81_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L0_2 = HUD
  L0_2 = L0_2.SET_TEXT_SCALE
  L1_2 = 1.0
  L2_2 = 0.5
  L0_2(L1_2, L2_2)
  L0_2 = HUD
  L0_2 = L0_2.SET_TEXT_FONT
  L1_2 = 0
  L0_2(L1_2)
  L0_2 = HUD
  L0_2 = L0_2.SET_TEXT_CENTRE
  L1_2 = 1
  L0_2(L1_2)
  L0_2 = HUD
  L0_2 = L0_2.SET_TEXT_OUTLINE
  L1_2 = 0
  L0_2(L1_2)
  L0_2 = HUD
  L0_2 = L0_2.SET_TEXT_COLOUR
  L1_2 = 255
  L2_2 = 255
  L3_2 = 255
  L4_2 = 180
  L0_2(L1_2, L2_2, L3_2, L4_2)
  L0_2 = util
  L0_2 = L0_2.BEGIN_TEXT_COMMAND_DISPLAY_TEXT
  L1_2 = "·"
  L0_2(L1_2)
  L0_2 = HUD
  L0_2 = L0_2.END_TEXT_COMMAND_DISPLAY_TEXT
  L1_2 = 0.49997
  L2_2 = 0.478
  L3_2 = 0
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = is_player_pointing
  L0_2 = L0_2()
  if L0_2 then
    L0_2 = write_global
    L0_2 = L0_2.int
    L1_2 = 4522736
    L2_2 = NETWORK
    L2_2 = L2_2.GET_NETWORK_TIME
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2 = L2_2()
    L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
    L0_2 = ENTITY
    L0_2 = L0_2.DOES_ENTITY_EXIST
    L1_2 = L77_1
    L0_2 = L0_2(L1_2)
    if not L0_2 then
      L0_2 = TraceFlag
      L0_2 = L0_2.peds
      L1_2 = TraceFlag
      L1_2 = L1_2.vehicles
      L0_2 = L0_2 | L1_2
      L1_2 = TraceFlag
      L1_2 = L1_2.pedsSimpleCollision
      L0_2 = L0_2 | L1_2
      L1_2 = TraceFlag
      L1_2 = L1_2.objects
      L0_2 = L0_2 | L1_2
      L1_2 = get_raycast_result
      L2_2 = 500.0
      L3_2 = L0_2
      L1_2 = L1_2(L2_2, L3_2)
      L2_2 = L1_2.didHit
      if L2_2 then
        L2_2 = ENTITY
        L2_2 = L2_2.DOES_ENTITY_EXIST
        L3_2 = L1_2.hitEntity
        L2_2 = L2_2(L3_2)
        if L2_2 then
          L2_2 = L1_2.hitEntity
          L77_1 = L2_2
        end
      end
    else
      L0_2 = players
      L0_2 = L0_2.get_position
      L1_2 = PLAYER
      L1_2 = L1_2.PLAYER_ID
      L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2 = L1_2()
      L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
      L1_2 = ENTITY
      L1_2 = L1_2.GET_ENTITY_COORDS
      L2_2 = L77_1
      L3_2 = true
      L1_2 = L1_2(L2_2, L3_2)
      L2_2 = CAM
      L2_2 = L2_2.GET_GAMEPLAY_CAM_ROT
      L3_2 = 0
      L2_2 = L2_2(L3_2)
      L3_2 = L2_2
      L2_2 = L2_2.toDir
      L2_2 = L2_2(L3_2)
      L4_2 = L0_2
      L3_2 = L0_2.distance
      L5_2 = L1_2
      L3_2 = L3_2(L4_2, L5_2)
      if L3_2 > 30.0 then
        L3_2 = 30.0
      elseif L3_2 < 10.0 then
        L3_2 = 10.0
      end
      L4_2 = v3
      L4_2 = L4_2.new
      L5_2 = L2_2
      L4_2 = L4_2(L5_2)
      L6_2 = L4_2
      L5_2 = L4_2.mul
      L7_2 = L3_2
      L5_2(L6_2, L7_2)
      L6_2 = L4_2
      L5_2 = L4_2.add
      L7_2 = L0_2
      L5_2(L6_2, L7_2)
      L5_2 = v3
      L5_2 = L5_2.new
      L6_2 = L4_2
      L5_2 = L5_2(L6_2)
      L7_2 = L5_2
      L6_2 = L5_2.sub
      L8_2 = L1_2
      L6_2(L7_2, L8_2)
      L7_2 = L5_2
      L6_2 = L5_2.normalise
      L6_2(L7_2)
      L6_2 = ENTITY
      L6_2 = L6_2.IS_ENTITY_A_PED
      L7_2 = L77_1
      L6_2 = L6_2(L7_2)
      if L6_2 then
        L7_2 = L5_2
        L6_2 = L5_2.mul
        L8_2 = 5.0
        L6_2(L7_2, L8_2)
        L6_2 = v3
        L6_2 = L6_2.new
        L7_2 = L1_2
        L6_2 = L6_2(L7_2)
        L8_2 = L6_2
        L7_2 = L6_2.sub
        L9_2 = L5_2
        L7_2(L8_2, L9_2)
        L7_2 = draw_bounding_box
        L8_2 = L77_1
        L9_2 = false
        L10_2 = {}
        L10_2.r = 255
        L10_2.g = 255
        L10_2.b = 255
        L10_2.a = 255
        L7_2(L8_2, L9_2, L10_2)
        L7_2 = set_explosion_proof
        L8_2 = PLAYER
        L8_2 = L8_2.PLAYER_PED_ID
        L8_2 = L8_2()
        L9_2 = true
        L7_2(L8_2, L9_2)
        L7_2 = true
        L78_1 = L7_2
        L7_2 = FIRE
        L7_2 = L7_2.ADD_EXPLOSION
        L8_2 = L6_2.x
        L9_2 = L6_2.y
        L10_2 = L6_2.z
        L11_2 = 29
        L12_2 = 25.0
        L13_2 = false
        L14_2 = true
        L15_2 = 0.0
        L16_2 = true
        L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
      else
        L6_2 = v3
        L6_2 = L6_2.new
        L7_2 = L5_2
        L6_2 = L6_2(L7_2)
        L8_2 = L1_2
        L7_2 = L1_2.distance
        L9_2 = L4_2
        L7_2 = L7_2(L8_2, L9_2)
        L9_2 = L6_2
        L8_2 = L6_2.mul
        L10_2 = L7_2
        L8_2(L9_2, L10_2)
        L8_2 = draw_bounding_box
        L9_2 = L77_1
        L10_2 = true
        L11_2 = {}
        L11_2.r = 255
        L11_2.g = 255
        L11_2.b = 255
        L11_2.a = 80
        L8_2(L9_2, L10_2, L11_2)
        L8_2 = request_control
        L9_2 = L77_1
        L8_2(L9_2)
        L8_2 = ENTITY
        L8_2 = L8_2.SET_ENTITY_VELOCITY
        L9_2 = L77_1
        L10_2 = L6_2.x
        L11_2 = L6_2.y
        L12_2 = L6_2.z
        L8_2(L9_2, L10_2, L11_2, L12_2)
      end
    end
  else
    L0_2 = L77_1
    L1_2 = NULL
    if L0_2 ~= L1_2 then
      L0_2 = timer
      L0_2 = L0_2.reset
      L0_2()
      L0_2 = NULL
      L77_1 = L0_2
    else
      L0_2 = L78_1
      if L0_2 then
        L0_2 = timer
        L0_2 = L0_2.elapsed
        L0_2 = L0_2()
        L1_2 = 500
        if L0_2 > L1_2 then
          L0_2 = false
          L78_1 = L0_2
          L0_2 = set_explosion_proof
          L1_2 = PLAYER
          L1_2 = L1_2.PLAYER_PED_ID
          L1_2 = L1_2()
          L2_2 = false
          L0_2(L1_2, L2_2)
        end
      end
    end
  end
end
L79_1[L80_1] = L81_1
L79_1 = _ENV
L80_1 = "Finely_chopped"
function L81_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED_SCRIPT_INDEX
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = L1_2
  L4_2 = false
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = L2_2.z
  L3_2 = L3_2 + 2.5
  L2_2.z = L3_2
  L3_2 = util
  L3_2 = L3_2.joaat
  L4_2 = "buzzard"
  L3_2 = L3_2(L4_2)
  L4_2 = request_model
  L5_2 = L3_2
  L4_2(L5_2)
  L4_2 = entities
  L4_2 = L4_2.create_vehicle
  L5_2 = L3_2
  L6_2 = L2_2
  L7_2 = ENTITY
  L7_2 = L7_2.GET_ENTITY_HEADING
  L8_2 = L1_2
  L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L7_2(L8_2)
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L5_2 = VEHICLE
  L5_2 = L5_2.SET_VEHICLE_ENGINE_ON
  L6_2 = L4_2
  L7_2 = true
  L8_2 = true
  L9_2 = false
  L5_2(L6_2, L7_2, L8_2, L9_2)
  L5_2 = VEHICLE
  L5_2 = L5_2.SET_HELI_BLADES_FULL_SPEED
  L6_2 = L4_2
  L5_2(L6_2)
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_INVINCIBLE
  L6_2 = L4_2
  L7_2 = true
  L5_2(L6_2, L7_2)
  L5_2 = ENTITY
  L5_2 = L5_2.FREEZE_ENTITY_POSITION
  L6_2 = L4_2
  L7_2 = true
  L5_2(L6_2, L7_2)
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_COMPLETELY_DISABLE_COLLISION
  L6_2 = L4_2
  L7_2 = true
  L8_2 = true
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_ROTATION
  L6_2 = L4_2
  L7_2 = 180
  L8_2 = 0.0
  L9_2 = ENTITY
  L9_2 = L9_2.GET_ENTITY_HEADING
  L10_2 = L1_2
  L9_2 = L9_2(L10_2)
  L10_2 = 1
  L11_2 = true
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_COORDS_NO_OFFSET
  L6_2 = L4_2
  L7_2 = L2_2.x
  L8_2 = L2_2.y
  L9_2 = L2_2.z
  L10_2 = true
  L11_2 = false
  L12_2 = false
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L5_2 = VEHICLE
  L5_2 = L5_2.SET_VEHICLE_ENGINE_ON
  L6_2 = L4_2
  L7_2 = true
  L8_2 = true
  L9_2 = true
  L5_2(L6_2, L7_2, L8_2, L9_2)
  L5_2 = util
  L5_2 = L5_2.yield
  L6_2 = 3000
  L5_2(L6_2)
  L5_2 = delete_entity
  L6_2 = L4_2
  L5_2(L6_2)
end
L79_1[L80_1] = L81_1
L79_1 = _ENV
L80_1 = "Child_Lock"
function L81_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2
  usingChildLock = A0_2
  L2_2 = usingChildLock
  if not L2_2 then
    return
  end
  while true do
    L2_2 = usingChildLock
    if not L2_2 then
      break
    end
    L2_2 = NETWORK
    L2_2 = L2_2.NETWORK_IS_PLAYER_ACTIVE
    L3_2 = A1_2
    L2_2 = L2_2(L3_2)
    if not L2_2 then
      break
    end
    L2_2 = util
    L2_2 = L2_2.is_session_transition_active
    L2_2 = L2_2()
    if L2_2 then
      break
    end
    L2_2 = get_vehicle_player_is_in
    L3_2 = A1_2
    L2_2 = L2_2(L3_2)
    L3_2 = ENTITY
    L3_2 = L3_2.DOES_ENTITY_EXIST
    L4_2 = L2_2
    L3_2 = L3_2(L4_2)
    if L3_2 then
      L3_2 = request_control
      L4_2 = L2_2
      L3_2 = L3_2(L4_2)
      if L3_2 then
        L3_2 = VEHICLE
        L3_2 = L3_2.SET_VEHICLE_DOORS_LOCKED
        L4_2 = L2_2
        L5_2 = 4
        L3_2(L4_2, L5_2)
      end
    end
    L3_2 = util
    L3_2 = L3_2.yield_once
    L3_2()
  end
  L2_2 = get_vehicle_player_is_in
  L3_2 = A1_2
  L2_2 = L2_2(L3_2)
  L3_2 = ENTITY
  L3_2 = L3_2.DOES_ENTITY_EXIST
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  if L3_2 then
    L3_2 = request_control
    L4_2 = L2_2
    L5_2 = 1000
    L3_2 = L3_2(L4_2, L5_2)
    if L3_2 then
      L3_2 = VEHICLE
      L3_2 = L3_2.SET_VEHICLE_DOORS_LOCKED
      L4_2 = L2_2
      L5_2 = 1
      L3_2(L4_2, L5_2)
    end
  end
end
L79_1[L80_1] = L81_1
L79_1 = _ENV
L80_1 = "Rocket_Man"
function L81_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2
  L0_2 = PED
  L0_2 = L0_2.SET_PED_TO_RAGDOLL
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = 2500
  L3_2 = 0
  L4_2 = 0
  L5_2 = false
  L6_2 = false
  L7_2 = false
  L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
  L0_2 = {}
  L1_2 = 10
  L2_2 = 15
  L3_2 = 20
  L4_2 = 20
  L5_2 = 20
  L6_2 = 10
  L7_2 = 10
  L8_2 = 10
  L9_2 = 10
  L10_2 = 10
  L11_2 = 10
  L0_2[1] = L1_2
  L0_2[2] = L2_2
  L0_2[3] = L3_2
  L0_2[4] = L4_2
  L0_2[5] = L5_2
  L0_2[6] = L6_2
  L0_2[7] = L7_2
  L0_2[8] = L8_2
  L0_2[9] = L9_2
  L0_2[10] = L10_2
  L0_2[11] = L11_2
  L1_2 = {}
  L2_2 = 1000
  L3_2 = 900
  L4_2 = 800
  L5_2 = 700
  L6_2 = 600
  L7_2 = 500
  L8_2 = 400
  L9_2 = 300
  L10_2 = 200
  L11_2 = 175
  L12_2 = 125
  L1_2[1] = L2_2
  L1_2[2] = L3_2
  L1_2[3] = L4_2
  L1_2[4] = L5_2
  L1_2[5] = L6_2
  L1_2[6] = L7_2
  L1_2[7] = L8_2
  L1_2[8] = L9_2
  L1_2[9] = L10_2
  L1_2[10] = L11_2
  L1_2[11] = L12_2
  L2_2 = 1
  L3_2 = #L0_2
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = ENTITY
    L6_2 = L6_2.APPLY_FORCE_TO_ENTITY
    L7_2 = PLAYER
    L7_2 = L7_2.PLAYER_PED_ID
    L7_2 = L7_2()
    L8_2 = 3
    L9_2 = 0.0
    L10_2 = 0.0
    L11_2 = L0_2[L5_2]
    L12_2 = 0.0
    L13_2 = 0.0
    L14_2 = 0.0
    L15_2 = 0
    L16_2 = false
    L17_2 = false
    L18_2 = true
    L19_2 = false
    L20_2 = false
    L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
    L6_2 = ENTITY
    L6_2 = L6_2.GET_ENTITY_COORDS
    L7_2 = PLAYER
    L7_2 = L7_2.PLAYER_PED_ID
    L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L7_2()
    L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
    L7_2 = request_ptfx_asset
    L8_2 = "cut_xm3"
    L7_2(L8_2)
    L7_2 = GRAPHICS
    L7_2 = L7_2.USE_PARTICLE_FX_ASSET
    L8_2 = "cut_xm3"
    L7_2(L8_2)
    L7_2 = GRAPHICS
    L8_2 = "START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD"
    L7_2 = L7_2[L8_2]
    L8_2 = "cut_xm3_rpg_explosion"
    L9_2 = L6_2.x
    L10_2 = L6_2.y
    L11_2 = L6_2.z
    L11_2 = L11_2 - 0.5
    L12_2 = 0
    L13_2 = 0
    L14_2 = 0
    L15_2 = 1.0
    L16_2 = true
    L17_2 = true
    L18_2 = true
    L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L7_2 = AUDIO
    L7_2 = L7_2.PLAY_SOUND_FROM_ENTITY
    L8_2 = -1
    L9_2 = "Bomb_Countdown_Beep"
    L10_2 = PLAYER
    L10_2 = L10_2.PLAYER_PED_ID
    L10_2 = L10_2()
    L11_2 = "DLC_MPSUM2_ULP2_Rogue_Drones"
    L12_2 = true
    L13_2 = 0
    L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
    L7_2 = util
    L7_2 = L7_2.yield
    L8_2 = L1_2[L5_2]
    L7_2(L8_2)
  end
  L2_2 = 1
  L3_2 = 2
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = util
    L6_2 = L6_2.current_time_millis
    L6_2 = L6_2()
    L6_2 = L6_2 + 500
    repeat
      L7_2 = ENTITY
      L7_2 = L7_2.APPLY_FORCE_TO_ENTITY
      L8_2 = PLAYER
      L8_2 = L8_2.PLAYER_PED_ID
      L8_2 = L8_2()
      L9_2 = 3
      L10_2 = 0.0
      L11_2 = 0.0
      L12_2 = 10
      L13_2 = 0.0
      L14_2 = 0.0
      L15_2 = 0.0
      L16_2 = 0
      L17_2 = false
      L18_2 = false
      L19_2 = true
      L20_2 = false
      L21_2 = false
      L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
      L7_2 = ENTITY
      L7_2 = L7_2.GET_ENTITY_COORDS
      L8_2 = PLAYER
      L8_2 = L8_2.PLAYER_PED_ID
      L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L8_2()
      L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
      pos = L7_2
      L7_2 = request_ptfx_asset
      L8_2 = "cut_xm3"
      L7_2(L8_2)
      L7_2 = GRAPHICS
      L7_2 = L7_2.USE_PARTICLE_FX_ASSET
      L8_2 = "cut_xm3"
      L7_2(L8_2)
      L7_2 = GRAPHICS
      L8_2 = "START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD"
      L7_2 = L7_2[L8_2]
      L8_2 = "cut_xm3_rpg_explosion"
      L9_2 = pos
      L9_2 = L9_2.x
      L10_2 = pos
      L10_2 = L10_2.y
      L11_2 = pos
      L11_2 = L11_2.z
      L11_2 = L11_2 - 0.5
      L12_2 = 0
      L13_2 = 0
      L14_2 = 0
      L15_2 = 1.0
      L16_2 = true
      L17_2 = true
      L18_2 = true
      L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
      L7_2 = AUDIO
      L7_2 = L7_2.PLAY_SOUND_FROM_ENTITY
      L8_2 = -1
      L9_2 = "Bomb_Countdown_Beep"
      L10_2 = PLAYER
      L10_2 = L10_2.PLAYER_PED_ID
      L10_2 = L10_2()
      L11_2 = "DLC_MPSUM2_ULP2_Rogue_Drones"
      L12_2 = true
      L13_2 = 0
      L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
      L7_2 = util
      L7_2 = L7_2.yield
      if 1 == L5_2 then
        L8_2 = 100
        if L8_2 then
          goto lbl_191
        end
      end
      L8_2 = 10
      ::lbl_191::
      L7_2(L8_2)
      L7_2 = util
      L7_2 = L7_2.current_time_millis
      L7_2 = L7_2()
    until L6_2 <= L7_2
  end
  L2_2 = AUDIO
  L2_2 = L2_2.PLAY_SOUND_FROM_ENTITY
  L3_2 = -1
  L4_2 = "Bomb_Detonate"
  L5_2 = PLAYER
  L5_2 = L5_2.PLAYER_PED_ID
  L5_2 = L5_2()
  L6_2 = "DLC_MPSUM2_ULP2_Rogue_Drones"
  L7_2 = true
  L8_2 = 0
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L3_2()
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
  pos = L2_2
  L2_2 = request_ptfx_asset
  L3_2 = "scr_xm_orbital"
  L2_2(L3_2)
  L2_2 = GRAPHICS
  L2_2 = L2_2.USE_PARTICLE_FX_ASSET
  L3_2 = "scr_xm_orbital"
  L2_2(L3_2)
  L2_2 = GRAPHICS
  L3_2 = "START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD"
  L2_2 = L2_2[L3_2]
  L3_2 = "scr_xm_orbital_blast"
  L4_2 = pos
  L4_2 = L4_2.x
  L5_2 = pos
  L5_2 = L5_2.y
  L6_2 = pos
  L6_2 = L6_2.z
  L7_2 = 0
  L8_2 = 180
  L9_2 = 0
  L10_2 = 1.0
  L11_2 = true
  L12_2 = true
  L13_2 = true
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L2_2 = STREAMING
  L2_2 = L2_2.REMOVE_NAMED_PTFX_ASSET
  L3_2 = "cut_xm3"
  L2_2(L3_2)
  L2_2 = STREAMING
  L2_2 = L2_2.REMOVE_NAMED_PTFX_ASSET
  L3_2 = "scr_xm_orbital"
  L2_2(L3_2)
end
L79_1[L80_1] = L81_1
