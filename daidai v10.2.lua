local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1
L0_1 = util
L0_1 = L0_1.keep_running
L0_1()
L0_1 = require
L1_1 = "lib.daidailib.Main.natives"
L0_1(L1_1)
L0_1 = require
L1_1 = "lib.daidailib.adwords"
L0_1(L1_1)
L0_1 = require
L1_1 = "lib.daidailib.location"
L0_1(L1_1)
L0_1 = require
L1_1 = "lib.daidailib.tables"
L0_1(L1_1)
L0_1 = require
L1_1 = "lib.daidailib.freetext"
L0_1(L1_1)
L0_1 = require
L1_1 = "lib.daidailib.daidailib"
L0_1(L1_1)
L0_1 = require
L1_1 = "lib.daidailib.daidailib1"
L0_1(L1_1)
L0_1 = require
L1_1 = "lib.daidailib.daidailib2"
L0_1(L1_1)
L0_1 = require
L1_1 = "lib.daidailib.bodyguards.bodyguard"
L0_1(L1_1)
L0_1 = require
L1_1 = "lib.daidailib.ScaleformLib"
L0_1 = L0_1(L1_1)
L1_1 = "multiplayer_chat"
L0_1 = L0_1(L1_1)
sfchat = L0_1
L0_1 = sfchat
L1_1 = L0_1
L0_1 = L0_1.draw_fullscreen
L0_1(L1_1)
L0_1 = check_access
L0_1()
L0_1 = require
L1_1 = "daidailib.ScaleformLib"
L0_1 = L0_1(L1_1)
scaleform = L0_1
L0_1 = scaleform
L1_1 = "instructional_buttons"
L0_1 = L0_1(L1_1)
sf = L0_1
L0_1 = require
L1_1 = "lib.daidailib.JSkeyLib"
L0_1 = L0_1(L1_1)
JSkey = L0_1
L0_1 = require
L1_1 = "lib.daidailib.ufo"
L0_1 = L0_1(L1_1)
L1_1 = require
L2_1 = "lib.daidailib.guided_missile"
L1_1 = L1_1(L2_1)
L2_1 = require
L3_1 = "lib.daidailib.homing_missiles"
L2_1 = L2_1(L3_1)
L3_1 = require
L4_1 = "lib.daidailib.orbital_cannon"
L3_1 = L3_1(L4_1)
L4_1 = menu
L4_1 = L4_1.list
L5_1 = self_option
L6_1 = "恢复"
L7_1 = {}
L8_1 = ""
L4_1 = L4_1(L5_1, L6_1, L7_1, L8_1)
health = L4_1
L4_1 = menu
L4_1 = L4_1.list
L5_1 = health
L6_1 = "设置最大生命值"
L7_1 = {}
L8_1 = ""
L4_1 = L4_1(L5_1, L6_1, L7_1, L8_1)
SetMaxHealth = L4_1
L4_1 = 328
L5_1 = menu
L5_1 = L5_1.toggle_loop
L6_1 = SetMaxHealth
L7_1 = "设置最大生命值"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = PED
  L0_2 = L0_2.SET_PED_MAX_HEALTH
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = L4_1
  L0_2(L1_2, L2_2)
  L0_2 = ENTITY
  L0_2 = L0_2.SET_ENTITY_HEALTH
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = L4_1
  L3_2 = 0
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = ENTITY
  L0_2 = L0_2.GET_ENTITY_HEALTH
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
  L1_2 = "~b~ HEALTH ~w~ "
  L2_2 = L0_2
  L1_2 = L1_2 .. L2_2
  L2_2 = draw_string
  L3_2 = L1_2
  L4_2 = 0.03
  L5_2 = 0.05
  L6_2 = 0.6
  L7_2 = 4
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.slider
L6_1 = SetMaxHealth
L7_1 = "设置数值"
L8_1 = {}
L9_1 = "moddedhealth"
L8_1[1] = L9_1
L9_1 = ""
L10_1 = 100
L11_1 = 9000
L12_1 = 328
L13_1 = 50
function L14_1(A0_2)
  local L1_2
  L4_1 = A0_2
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1)
L5_1 = menu
L5_1 = L5_1.toggle_loop
L6_1 = health
L7_1 = "半无敌"
L8_1 = {}
L9_1 = "不等于无敌,可由高致命性武器击杀"
function L10_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = ENTITY
  L0_2 = L0_2.SET_ENTITY_HEALTH
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = PED
  L2_2 = L2_2.GET_PED_MAX_HEALTH
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2 = L3_2()
  L2_2, L3_2 = L2_2(L3_2)
  L0_2(L1_2, L2_2, L3_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.slider
L6_1 = health
L7_1 = "自定义血量"
L8_1 = {}
L9_1 = "setblood"
L8_1[1] = L9_1
L9_1 = "血量低于100会死亡"
L10_1 = 1
L11_1 = 1000
L12_1 = 328
L13_1 = 1
function L14_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = ENTITY
  L1_2 = L1_2.SET_ENTITY_HEALTH
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1)
L5_1 = menu
L5_1 = L5_1.toggle_loop
L6_1 = health
L7_1 = "无限氧气"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2
  L0_2 = PLAYER
  L1_2 = "SET_PLAYER_UNDERWATER_BREATH_PERCENT_REMAINING"
  L0_2 = L0_2[L1_2]
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2 = L1_2()
  L2_2 = 1
  L0_2(L1_2, L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.action
L6_1 = health
L7_1 = "补充血量"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = ENTITY
  L0_2 = L0_2.SET_ENTITY_HEALTH
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = PED
  L2_2 = L2_2.GET_PED_MAX_HEALTH
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2 = L3_2()
  L2_2 = L2_2(L3_2)
  L3_2 = 0
  L0_2(L1_2, L2_2, L3_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.action
L6_1 = health
L7_1 = "补充护甲"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2
  L0_2 = util
  L0_2 = L0_2.is_session_started
  L0_2 = L0_2()
  if L0_2 then
    L0_2 = PED
    L0_2 = L0_2.SET_PED_ARMOUR
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_PED_ID
    L1_2 = L1_2()
    L2_2 = 50
    L0_2(L1_2, L2_2)
  else
    L0_2 = PED
    L0_2 = L0_2.SET_PED_ARMOUR
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_PED_ID
    L1_2 = L1_2()
    L2_2 = 100
    L0_2(L1_2, L2_2)
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle_loop
L6_1 = health
L7_1 = "自动复活"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = ENTITY
  L0_2 = L0_2.GET_ENTITY_HEALTH
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  if L0_2 < 1.0 then
    L0_2 = ENTITY
    L0_2 = L0_2.GET_ENTITY_COORDS
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_PED_ID
    L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2 = L1_2()
    L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
    L1_2 = PED
    L1_2 = L1_2.RESURRECT_PED
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2 = L2_2()
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
    L1_2 = ENTITY
    L1_2 = L1_2.SET_ENTITY_COORDS_NO_OFFSET
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = L0_2.x
    L4_2 = L0_2.y
    L5_2 = L0_2.z
    L6_2 = false
    L7_2 = false
    L8_2 = false
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle_loop
L6_1 = health
L7_1 = "在死亡点重生"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = PLAYER
  L0_2 = L0_2.PLAYER_PED_ID
  L0_2 = L0_2()
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_HEALTH
  L2_2 = L0_2
  L1_2 = L1_2(L2_2)
  if 0 == L1_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.GET_ENTITY_COORDS
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L2_2()
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    while L1_2 do
      L2_2 = util
      L2_2 = L2_2.yield
      L2_2()
      L2_2 = ENTITY
      L2_2 = L2_2.SET_ENTITY_COORDS_NO_OFFSET
      L3_2 = PLAYER
      L3_2 = L3_2.PLAYER_PED_ID
      L3_2 = L3_2()
      L4_2 = L1_2.x
      L5_2 = L1_2.y
      L6_2 = L1_2.z
      L7_2 = false
      L8_2 = false
      L9_2 = false
      L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
      break
    end
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.list
L6_1 = health
L7_1 = "零食编辑"
L8_1 = {}
L9_1 = ""
L5_1 = L5_1(L6_1, L7_1, L8_1, L9_1)
supplemental_snacks = L5_1
L5_1 = menu
L5_1 = L5_1.action
L6_1 = supplemental_snacks
L7_1 = "补满全部零食"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2
  L0_2 = STAT_SET_INT
  L1_2 = "NO_BOUGHT_YUM_SNACKS"
  L2_2 = 30
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "NO_BOUGHT_HEALTH_SNACKS"
  L2_2 = 15
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "NO_BOUGHT_EPIC_SNACKS"
  L2_2 = 5
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "NUMBER_OF_ORANGE_BOUGHT"
  L2_2 = 10
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "NUMBER_OF_BOURGE_BOUGHT"
  L2_2 = 10
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "NUMBER_OF_CHAMP_BOUGHT"
  L2_2 = 5
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "CIGARETTES_BOUGHT"
  L2_2 = 20
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "NUMBER_OF_SPRUNK_BOUGHT"
  L2_2 = 10
  L0_2(L1_2, L2_2)
  L0_2 = util
  L0_2 = L0_2.toast
  L1_2 = "完成！"
  L0_2(L1_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.action
L6_1 = supplemental_snacks
L7_1 = "补满全部护甲"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2
  L0_2 = STAT_SET_INT
  L1_2 = "MP_CHAR_ARMOUR_1_COUNT"
  L2_2 = 10
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "MP_CHAR_ARMOUR_2_COUNT"
  L2_2 = 10
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "MP_CHAR_ARMOUR_3_COUNT"
  L2_2 = 10
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "MP_CHAR_ARMOUR_4_COUNT"
  L2_2 = 10
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "MP_CHAR_ARMOUR_5_COUNT"
  L2_2 = 10
  L0_2(L1_2, L2_2)
  L0_2 = util
  L0_2 = L0_2.toast
  L1_2 = "完成！"
  L0_2(L1_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.action
L6_1 = supplemental_snacks
L7_1 = "补满呼吸器"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2
  L0_2 = STAT_SET_INT
  L1_2 = "BREATHING_APPAR_BOUGHT"
  L2_2 = 20
  L0_2(L1_2, L2_2)
  L0_2 = util
  L0_2 = L0_2.toast
  L1_2 = "完成！"
  L0_2(L1_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle_loop
L6_1 = health
L7_1 = "自动加血"
L8_1 = {}
L9_1 = "一直加血直到您的血被加满."
function L10_1()
  local L0_2, L1_2
  L0_2 = autoBloodReture
  L0_2()
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle_loop
L6_1 = health
L7_1 = "在掩体后时补充生命值"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2
  L0_2 = healthincover
  L0_2()
end
function L11_1()
  local L0_2, L1_2, L2_2
  L0_2 = PLAYER1
  L0_2 = L0_2._SET_PLAYER_HEALTH_RECHARGE_LIMIT
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2 = L1_2()
  L2_2 = 0.25
  L0_2(L1_2, L2_2)
  L0_2 = PLAYER
  L0_2 = L0_2.SET_PLAYER_HEALTH_RECHARGE_MULTIPLIER
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2 = L1_2()
  L2_2 = 1.0
  L0_2(L1_2, L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1, L11_1)
L5_1 = menu
L5_1 = L5_1.list
L6_1 = self_option
L7_1 = "移动选项"
L8_1 = {}
L9_1 = ""
L5_1 = L5_1(L6_1, L7_1, L8_1, L9_1)
movement_opt = L5_1
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = movement_opt
L7_1 = "蜘蛛侠飞行"
L8_1 = {}
L9_1 = ""
function L10_1(A0_2)
  local L1_2, L2_2
  L1_2 = superman_fly
  L2_2 = A0_2
  L1_2(L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = movement_opt
L7_1 = "在水上行走"
L8_1 = {}
L9_1 = ""
function L10_1(A0_2)
  local L1_2, L2_2, L3_2
  walkonwater = A0_2
  if A0_2 then
    L1_2 = menu
    L1_2 = L1_2.set_value
    L2_2 = ls_driveonwater
    L3_2 = false
    L1_2(L2_2, L3_2)
    L1_2 = menu
    L1_2 = L1_2.set_value
    L2_2 = ls_driveonair
    L3_2 = false
    L1_2(L2_2, L3_2)
  end
end
L5_1 = L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
ls_walkwater = L5_1
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = movement_opt
L7_1 = "空中行走"
L8_1 = {}
L9_1 = "仅适用于线上默认角色"
function L10_1(A0_2)
  local L1_2, L2_2
  L1_2 = walk_on_air
  L2_2 = A0_2
  L1_2(L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = movement_opt
L7_1 = "丝滑移动"
L8_1 = {}
L9_1 = ""
function L10_1(A0_2)
  local L1_2, L2_2
  L1_2 = Silky_movement
  L2_2 = A0_2
  L1_2(L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.list
L6_1 = movement_opt
L7_1 = "无碰撞"
L8_1 = {}
L9_1 = ""
L5_1 = L5_1(L6_1, L7_1, L8_1, L9_1)
no_clip_lt = L5_1
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = no_clip_lt
L7_1 = "开启"
L8_1 = {}
L9_1 = ""
function L10_1(A0_2)
  local L1_2, L2_2
  L1_2 = no_clip
  L2_2 = A0_2
  L1_2(L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.slider
L6_1 = no_clip_lt
L7_1 = "移动速度"
L8_1 = {}
L9_1 = "Speed multiplier"
L10_1 = 1
L11_1 = 100
L12_1 = 1
L13_1 = 1
function L14_1(A0_2)
  local L1_2, L2_2
  L1_2 = no_clip_speed
  L2_2 = A0_2
  L1_2(L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1)
L5_1 = menu
L5_1 = L5_1.list
L6_1 = self_option
L7_1 = "外观选项"
L8_1 = {}
L9_1 = ""
L5_1 = L5_1(L6_1, L7_1, L8_1, L9_1)
aspect_opt = L5_1
L5_1 = menu
L5_1 = L5_1.action
L6_1 = aspect_opt
L7_1 = "读取外观"
L8_1 = {}
L9_1 = "将保存一个A-test.txt文件位于预设服装库,供给服装制作使用"
function L10_1()
  local L0_2, L1_2
  L0_2 = read_appearance
  L0_2()
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle_loop
L6_1 = aspect_opt
L7_1 = "清洁自己"
L8_1 = {}
L9_1 = "保持自身清洁"
function L10_1()
  local L0_2, L1_2
  L0_2 = PED
  L0_2 = L0_2.CLEAR_PED_BLOOD_DAMAGE
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L0_2(L1_2)
  L0_2 = PED
  L0_2 = L0_2.CLEAR_PED_WETNESS
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L0_2(L1_2)
  L0_2 = PED
  L0_2 = L0_2.CLEAR_PED_ENV_DIRT
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L0_2(L1_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle_loop
L6_1 = aspect_opt
L7_1 = "全身湿透"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2
  L0_2 = PED
  L0_2 = L0_2.SET_PED_WETNESS_HEIGHT
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = 1
  L0_2(L1_2, L2_2)
  L0_2 = PED
  L0_2 = L0_2.SET_PED_WETNESS_ENABLED_THIS_FRAME
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2 = L1_2()
  L0_2(L1_2, L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.action
L6_1 = aspect_opt
L7_1 = "随机外观"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2
  L0_2 = PED
  L0_2 = L0_2.SET_PED_RANDOM_COMPONENT_VARIATION
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = true
  L0_2(L1_2, L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.list
L6_1 = aspect_opt
L7_1 = "预设模型"
L8_1 = {}
L9_1 = ""
L5_1 = L5_1(L6_1, L7_1, L8_1, L9_1)
changemodel_list = L5_1
L5_1 = pairs
L6_1 = my_model_list
L5_1, L6_1, L7_1, L8_1 = L5_1(L6_1)
for L9_1, L10_1 in L5_1, L6_1, L7_1, L8_1 do
  L11_1 = menu
  L11_1 = L11_1.action
  L12_1 = changemodel_list
  L13_1 = L10_1[1]
  L14_1 = {}
  L15_1 = ""
  function L16_1()
    local L0_2, L1_2, L2_2
    L0_2 = change_model
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_ID
    L1_2 = L1_2()
    L2_2 = L10_1
    L2_2 = L2_2[2]
    L0_2(L1_2, L2_2)
  end
  L11_1(L12_1, L13_1, L14_1, L15_1, L16_1)
end
L5_1 = menu
L5_1 = L5_1.action
L6_1 = changemodel_list
L7_1 = "胡桃"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2
  L0_2 = become_walnuts
  L0_2()
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.list
L6_1 = aspect_opt
L7_1 = "预设服装"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2
  L0_2 = Preset_outfits
  L0_2()
end
function L11_1()
  local L0_2, L1_2
  L0_2 = endPreset_outfits
  L0_2()
end
L5_1 = L5_1(L6_1, L7_1, L8_1, L9_1, L10_1, L11_1)
my_cloth = L5_1
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = aspect_opt
L7_1 = "人物缩小"
L8_1 = {}
L9_1 = ""
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED_SCRIPT_INDEX
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_ID
  L2_2, L3_2, L4_2, L5_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2)
  if A0_2 then
    L2_2 = PED
    L2_2 = L2_2.SET_PED_CONFIG_FLAG
    L3_2 = L1_2
    L4_2 = 223
    L5_2 = true
    L2_2(L3_2, L4_2, L5_2)
  else
    L2_2 = PED
    L2_2 = L2_2.SET_PED_CONFIG_FLAG
    L3_2 = L1_2
    L4_2 = 223
    L5_2 = false
    L2_2(L3_2, L4_2, L5_2)
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle_loop
L6_1 = aspect_opt
L7_1 = "彩虹头发"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
  L0_2 = PED1
  L0_2 = L0_2._SET_PED_HAIR_COLOR
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = math
  L2_2 = L2_2.random
  L3_2 = 33
  L4_2 = 53
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = math
  L3_2 = L3_2.random
  L4_2 = 33
  L5_2 = 53
  L3_2, L4_2, L5_2 = L3_2(L4_2, L5_2)
  L0_2(L1_2, L2_2, L3_2, L4_2, L5_2)
  L0_2 = util
  L0_2 = L0_2.yield
  L1_2 = 100
  L0_2(L1_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.list
L6_1 = self_option
L7_1 = "人物行为"
L8_1 = {}
L9_1 = ""
L5_1 = L5_1(L6_1, L7_1, L8_1, L9_1)
action_list = L5_1
L5_1 = menu
L5_1 = L5_1.toggle_loop
L6_1 = action_list
L7_1 = "自转"
L8_1 = {}
L9_1 = ""
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L1_2 = ENTITY
  L1_2 = L1_2.APPLY_FORCE_TO_ENTITY
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = 5
  L4_2 = 200
  L5_2 = 8200
  L6_2 = 89000
  L7_2 = 10
  L8_2 = 10
  L9_2 = 100
  L10_2 = 10000
  L11_2 = false
  L12_2 = true
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L1_2 = TASK
  L1_2 = L1_2.CLEAR_PED_TASKS_IMMEDIATELY
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L2_2()
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle_loop
L6_1 = action_list
L7_1 = "超级跳跃"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = PAD
  L0_2 = L0_2.IS_CONTROL_PRESSED
  L1_2 = 0
  L2_2 = 22
  L0_2 = L0_2(L1_2, L2_2)
  if L0_2 then
    L0_2 = PAD
    L0_2 = L0_2.IS_CONTROL_PRESSED
    L1_2 = 0
    L2_2 = 32
    L0_2 = L0_2(L1_2, L2_2)
    if L0_2 then
      L0_2 = PED
      L0_2 = L0_2.IS_PED_IN_ANY_VEHICLE
      L1_2 = PLAYER
      L1_2 = L1_2.PLAYER_PED_ID
      L1_2 = L1_2()
      L2_2 = false
      L0_2 = L0_2(L1_2, L2_2)
      if not L0_2 then
        L0_2 = ENTITY
        L0_2 = L0_2.IS_ENTITY_IN_AIR
        L1_2 = PLAYER
        L1_2 = L1_2.PLAYER_PED_ID
        L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L1_2()
        L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
        if not L0_2 then
          L0_2 = WEAPON
          L0_2 = L0_2.GET_SELECTED_PED_WEAPON
          L1_2 = PLAYER
          L1_2 = L1_2.PLAYER_PED_ID
          L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L1_2()
          L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
          if 1119849093 ~= L0_2 then
            L0_2 = ENTITY
            L0_2 = L0_2.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
            L1_2 = PLAYER
            L1_2 = L1_2.PLAYER_PED_ID
            L1_2 = L1_2()
            L2_2 = 0
            L3_2 = 0
            L4_2 = 500
            L5_2 = 500
            L6_2 = false
            L7_2 = true
            L8_2 = true
            L9_2 = false
            L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
          end
        end
      end
    end
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle_loop
L6_1 = action_list
L7_1 = "野兽跳跃"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2
  L0_2 = MISC
  L0_2 = L0_2.SET_SUPER_JUMP_THIS_FRAME
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2 = L1_2()
  L0_2(L1_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle_loop
L6_1 = action_list
L7_1 = "抽搐野兽跳跃"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2
  L0_2 = MISC
  L0_2 = L0_2.SET_BEAST_JUMP_THIS_FRAME
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2 = L1_2()
  L0_2(L1_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle_loop
L6_1 = action_list
L7_1 = "快速上下车"
L8_1 = {}
L9_1 = "更快地进入/离开车辆."
function L10_1()
  local L0_2, L1_2, L2_2
  L0_2 = TASK
  L0_2 = L0_2.GET_IS_TASK_ACTIVE
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = 160
  L0_2 = L0_2(L1_2, L2_2)
  if not L0_2 then
    L0_2 = TASK
    L0_2 = L0_2.GET_IS_TASK_ACTIVE
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_PED_ID
    L1_2 = L1_2()
    L2_2 = 167
    L0_2 = L0_2(L1_2, L2_2)
    if not L0_2 then
      L0_2 = TASK
      L0_2 = L0_2.GET_IS_TASK_ACTIVE
      L1_2 = PLAYER
      L1_2 = L1_2.PLAYER_PED_ID
      L1_2 = L1_2()
      L2_2 = 165
      L0_2 = L0_2(L1_2, L2_2)
      if not L0_2 then
        goto lbl_43
      end
    end
  end
  L0_2 = TASK
  L0_2 = L0_2.GET_IS_TASK_ACTIVE
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = 195
  L0_2 = L0_2(L1_2, L2_2)
  if not L0_2 then
    L0_2 = PED
    L0_2 = L0_2.FORCE_PED_AI_AND_ANIMATION_UPDATE
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_PED_ID
    L1_2, L2_2 = L1_2()
    L0_2(L1_2, L2_2)
  end
  ::lbl_43::
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle_loop
L6_1 = action_list
L7_1 = "快速翻越"
L8_1 = {}
L9_1 = "更快的翻越一些东西\n例如: 汽车、障碍物等."
function L10_1()
  local L0_2, L1_2, L2_2
  L0_2 = TASK
  L0_2 = L0_2.GET_IS_TASK_ACTIVE
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = 50
  L0_2 = L0_2(L1_2, L2_2)
  if not L0_2 then
    L0_2 = TASK
    L0_2 = L0_2.GET_IS_TASK_ACTIVE
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_PED_ID
    L1_2 = L1_2()
    L2_2 = 51
    L0_2 = L0_2(L1_2, L2_2)
    if not L0_2 then
      goto lbl_25
    end
  end
  L0_2 = PED
  L0_2 = L0_2.FORCE_PED_AI_AND_ANIMATION_UPDATE
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2 = L1_2()
  L0_2(L1_2, L2_2)
  ::lbl_25::
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle_loop
L6_1 = action_list
L7_1 = "空中游泳"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = PED
  L0_2 = L0_2.SET_PED_CONFIG_FLAG
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = 65
  L3_2 = 81
  L0_2(L1_2, L2_2, L3_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle_loop
L6_1 = action_list
L7_1 = "太空步"
L8_1 = {}
L9_1 = ""
function L10_1(A0_2)
  local L1_2, L2_2
  L1_2 = Space_walk
  L2_2 = A0_2
  L1_2(L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = action_list
L7_1 = "忍者跑"
L8_1 = {}
L9_1 = "忍者跑步动作"
function L10_1(A0_2)
  local L1_2, L2_2
  L1_2 = renzhepao
  L2_2 = A0_2
  L1_2(L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.list
L6_1 = action_list
L7_1 = "预设动作"
L8_1 = {}
L9_1 = ""
L5_1 = L5_1(L6_1, L7_1, L8_1, L9_1)
presets_action = L5_1
L5_1 = menu
L5_1 = L5_1.action
L6_1 = presets_action
L7_1 = "前空翻"
L8_1 = {}
L9_1 = "表演一个前空翻"
function L10_1()
  local L0_2, L1_2
  L0_2 = forward_somersault
  L0_2()
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = presets_action
L7_1 = "弹吉他"
L8_1 = {}
L9_1 = ""
function L10_1(A0_2)
  local L1_2, L2_2
  L1_2 = Play_guitar
  L2_2 = A0_2
  L1_2(L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = presets_action
L7_1 = "掌旋球"
L8_1 = {}
L9_1 = ""
function L10_1(A0_2)
  local L1_2, L2_2
  L1_2 = Palm_spin_ball
  L2_2 = A0_2
  L1_2(L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = presets_action
L7_1 = "乞求"
L8_1 = {}
L9_1 = ""
function L10_1(A0_2)
  local L1_2, L2_2
  L1_2 = seek_help
  L2_2 = A0_2
  L1_2(L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = presets_action
L7_1 = "献花"
L8_1 = {}
L9_1 = ""
function L10_1(A0_2)
  local L1_2, L2_2
  L1_2 = offer_flower
  L2_2 = A0_2
  L1_2(L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = presets_action
L7_1 = "打伞"
L8_1 = {}
L9_1 = ""
function L10_1(A0_2)
  local L1_2, L2_2
  L1_2 = hold_umbrella
  L2_2 = A0_2
  L1_2(L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle_loop
L6_1 = presets_action
L7_1 = "前滚翻"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2
  L0_2 = forward_roll
  L0_2()
end
function L11_1()
  local L0_2, L1_2
  L0_2 = end_forward_roll
  L0_2()
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1, L11_1)
L5_1 = menu
L5_1 = L5_1.toggle_loop
L6_1 = presets_action
L7_1 = "街舞"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2
  L0_2 = breakdance
  L0_2()
end
function L11_1()
  local L0_2, L1_2
  L0_2 = end_breakdance
  L0_2()
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1, L11_1)
L5_1 = menu
L5_1 = L5_1.textslider
L6_1 = presets_action
L7_1 = "表演"
L8_1 = {}
L9_1 = ""
L10_1 = {}
L11_1 = "翻跟斗"
L12_1 = "后空翻"
L13_1 = "飞腿"
L10_1[1] = L11_1
L10_1[2] = L12_1
L10_1[3] = L13_1
function L11_1(A0_2)
  local L1_2, L2_2
  L1_2 = Performing_actions
  L2_2 = A0_2
  L1_2(L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1, L11_1)
L5_1 = menu
L5_1 = L5_1.list
L6_1 = action_list
L7_1 = "动作选项"
L8_1 = {}
L9_1 = ""
L5_1 = L5_1(L6_1, L7_1, L8_1, L9_1)
action_list_lua = L5_1
L5_1 = require
L6_1 = "lib.daidailib.actions"
L5_1(L6_1)
L5_1 = menu
L5_1 = L5_1.toggle_loop
L6_1 = self_option
L7_1 = "快速重生"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = memory
  L0_2 = L0_2.script_global
  L1_2 = 2674965
  L0_2 = L0_2(L1_2)
  L1_2 = PED
  L1_2 = L1_2.IS_PED_DEAD_OR_DYING
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
  if L1_2 then
    L1_2 = GRAPHICS
    L1_2 = L1_2.ANIMPOSTFX_STOP_ALL
    L1_2()
    L1_2 = memory
    L1_2 = L1_2.write_int
    L2_2 = L0_2
    L3_2 = bit33
    L3_2 = L3_2.bitor
    L4_2 = memory
    L4_2 = L4_2.read_int
    L5_2 = L0_2
    L4_2 = L4_2(L5_2)
    L5_2 = SYSTEM
    L5_2 = L5_2.SHIFT_LEFT
    L6_2 = 1
    L7_2 = 1
    L5_2, L6_2, L7_2 = L5_2(L6_2, L7_2)
    L3_2, L4_2, L5_2, L6_2, L7_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
  end
end
function L11_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = memory
  L0_2 = L0_2.script_global
  L1_2 = 2674946
  L0_2 = L0_2(L1_2)
  L1_2 = memory
  L1_2 = L1_2.write_int
  L2_2 = L0_2
  L3_2 = bit33
  L3_2 = L3_2.bitand
  L4_2 = memory
  L4_2 = L4_2.read_int
  L5_2 = L0_2
  L4_2 = L4_2(L5_2)
  L5_2 = SYSTEM
  L5_2 = L5_2.SHIFT_LEFT
  L6_2 = 1
  L7_2 = 1
  L5_2, L6_2, L7_2 = L5_2(L6_2, L7_2)
  L3_2, L4_2, L5_2, L6_2, L7_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1, L11_1)
L5_1 = menu
L5_1 = L5_1.toggle_loop
L6_1 = self_option
L7_1 = "超级飞行"
L8_1 = {}
L9_1 = "按下跳跃的时间越长,继续走得更高（也可用于飞行）"
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L0_2 = PAD
  L0_2 = L0_2.IS_CONTROL_PRESSED
  L1_2 = 0
  L2_2 = 22
  L0_2 = L0_2(L1_2, L2_2)
  if L0_2 then
    L0_2 = PAD
    L0_2 = L0_2.IS_CONTROL_PRESSED
    L1_2 = 0
    L2_2 = 32
    L0_2 = L0_2(L1_2, L2_2)
    if L0_2 then
      L0_2 = PED
      L0_2 = L0_2.SET_PED_CAN_RAGDOLL
      L1_2 = PLAYER
      L1_2 = L1_2.PLAYER_PED_ID
      L1_2 = L1_2()
      L2_2 = false
      L0_2(L1_2, L2_2)
      L0_2 = ENTITY
      L0_2 = L0_2.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
      L1_2 = PLAYER
      L1_2 = L1_2.PLAYER_PED_ID
      L1_2 = L1_2()
      L2_2 = 1
      L3_2 = 0
      L4_2 = 0.6
      L5_2 = 0.6
      L6_2 = 0
      L7_2 = true
      L8_2 = true
      L9_2 = true
      L10_2 = true
      L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
      L0_2 = ENTITY
      L0_2 = L0_2.IS_ENTITY_IN_AIR
      L1_2 = PLAYER
      L1_2 = L1_2.PLAYER_PED_ID
      L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L1_2()
      L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
      if L0_2 then
        L0_2 = ENTITY
        L0_2 = L0_2.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
        L1_2 = PLAYER
        L1_2 = L1_2.PLAYER_PED_ID
        L1_2 = L1_2()
        L2_2 = 1
        L3_2 = 0
        L4_2 = 0
        L5_2 = 0.6
        L6_2 = 0
        L7_2 = true
        L8_2 = true
        L9_2 = true
        L10_2 = true
        L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
      end
    end
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = self_option
L7_1 = "火人"
L8_1 = {}
L9_1 = ""
function L10_1(A0_2)
  local L1_2, L2_2
  L1_2 = fireself
  L2_2 = A0_2
  L1_2(L2_2)
end
L5_1 = L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
Burning_Man = L5_1
L5_1 = menu
L5_1 = L5_1.toggle_loop
L6_1 = self_option
L7_1 = "光环"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2
  L0_2 = personllight
  L0_2()
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.list
L6_1 = self_option
L7_1 = "附加"
L8_1 = {}
L5_1 = L5_1(L6_1, L7_1, L8_1)
attach_self = L5_1
L5_1 = menu
L5_1 = L5_1.list
L6_1 = attach_self
L7_1 = "雪人"
L8_1 = {}
L5_1 = L5_1(L6_1, L7_1, L8_1)
attach_snowman = L5_1
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = attach_snowman
L7_1 = "雪人v1"
L8_1 = {}
L9_1 = ""
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L1_2 = "prop_gumball_03"
  L2_2 = "prop_prlg_snowpile"
  if A0_2 then
    L3_2 = attach_to_player
    L4_2 = L2_2
    L5_2 = 0
    L6_2 = 0.0
    L7_2 = 0
    L8_2 = 0
    L9_2 = 0
    L10_2 = 0
    L11_2 = 0
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    L3_2 = attach_to_player
    L4_2 = L2_2
    L5_2 = 0
    L6_2 = 0.0
    L7_2 = 0
    L8_2 = -0.5
    L9_2 = 0
    L10_2 = 0
    L11_2 = 0
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    L3_2 = attach_to_player
    L4_2 = L2_2
    L5_2 = 0
    L6_2 = 0.0
    L7_2 = 0
    L8_2 = -1
    L9_2 = 0
    L10_2 = 0
    L11_2 = 0
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    L3_2 = attach_to_player
    L4_2 = L1_2
    L5_2 = 0
    L6_2 = 0.0
    L7_2 = 0
    L8_2 = 0
    L9_2 = 0
    L10_2 = 50
    L11_2 = 0
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    L3_2 = attach_to_player
    L4_2 = L1_2
    L5_2 = 0
    L6_2 = 0.0
    L7_2 = 0
    L8_2 = 0
    L9_2 = 0
    L10_2 = 125
    L11_2 = 0
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    L3_2 = attach_to_player
    L4_2 = L1_2
    L5_2 = 0
    L6_2 = 0.0
    L7_2 = 0
    L8_2 = 0
    L9_2 = 0
    L10_2 = -50
    L11_2 = 0
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    L3_2 = attach_to_player
    L4_2 = L1_2
    L5_2 = 0
    L6_2 = 0.0
    L7_2 = 0
    L8_2 = 0
    L9_2 = 0
    L10_2 = -125
    L11_2 = 0
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  else
    L3_2 = delete_object
    L4_2 = L2_2
    L3_2(L4_2)
    L3_2 = delete_object
    L4_2 = L1_2
    L3_2(L4_2)
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = attach_snowman
L7_1 = "雪人v2"
L8_1 = {}
L9_1 = ""
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = "xm3_prop_xm3_snowman_01b"
  if A0_2 then
    L2_2 = attach_to_player
    L3_2 = L1_2
    L4_2 = 0
    L5_2 = 0
    L6_2 = 0
    L7_2 = -0.7
    L8_2 = 0
    L9_2 = 0
    L10_2 = 180
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
    L2_2 = ENTITY
    L2_2 = L2_2.SET_ENTITY_ALPHA
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2 = L3_2()
    L4_2 = 0
    L5_2 = false
    L2_2(L3_2, L4_2, L5_2)
  else
    L2_2 = delete_object
    L3_2 = L1_2
    L2_2(L3_2)
    L2_2 = ENTITY
    L2_2 = L2_2.SET_ENTITY_ALPHA
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2 = L3_2()
    L4_2 = 255
    L5_2 = false
    L2_2(L3_2, L4_2, L5_2)
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = attach_snowman
L7_1 = "雪人v3"
L8_1 = {}
L9_1 = ""
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = "xm3_prop_xm3_snowman_01c"
  if A0_2 then
    L2_2 = attach_to_player
    L3_2 = L1_2
    L4_2 = 0
    L5_2 = 0
    L6_2 = 0
    L7_2 = -0.7
    L8_2 = 0
    L9_2 = 0
    L10_2 = 180
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
    L2_2 = ENTITY
    L2_2 = L2_2.SET_ENTITY_ALPHA
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2 = L3_2()
    L4_2 = 0
    L5_2 = false
    L2_2(L3_2, L4_2, L5_2)
  else
    L2_2 = delete_object
    L3_2 = L1_2
    L2_2(L3_2)
    L2_2 = ENTITY
    L2_2 = L2_2.SET_ENTITY_ALPHA
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2 = L3_2()
    L4_2 = 255
    L5_2 = false
    L2_2(L3_2, L4_2, L5_2)
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = attach_snowman
L7_1 = "雪人v4"
L8_1 = {}
L9_1 = ""
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = "xm3_prop_xm3_snowman_01a"
  if A0_2 then
    L2_2 = attach_to_player
    L3_2 = L1_2
    L4_2 = 0
    L5_2 = 0
    L6_2 = 0
    L7_2 = -0.7
    L8_2 = 0
    L9_2 = 0
    L10_2 = 180
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
    L2_2 = ENTITY
    L2_2 = L2_2.SET_ENTITY_ALPHA
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2 = L3_2()
    L4_2 = 0
    L5_2 = false
    L2_2(L3_2, L4_2, L5_2)
  else
    L2_2 = delete_object
    L3_2 = L1_2
    L2_2(L3_2)
    L2_2 = ENTITY
    L2_2 = L2_2.SET_ENTITY_ALPHA
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2 = L3_2()
    L4_2 = 255
    L5_2 = false
    L2_2(L3_2, L4_2, L5_2)
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = attach_self
L7_1 = "娃娃熊挂件"
L8_1 = {}
L9_1 = ""
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  obj = "v_ilev_mr_rasberryclean"
  if A0_2 then
    L1_2 = attach_to_player
    L2_2 = obj
    L3_2 = 0
    L4_2 = 0
    L5_2 = -0.2
    L6_2 = 0.25
    L7_2 = 0
    L8_2 = 30
    L9_2 = 0
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  else
    L1_2 = delete_object
    L2_2 = obj
    L1_2(L2_2)
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = attach_self
L7_1 = "剑圣"
L8_1 = {}
L9_1 = ""
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = "prop_cs_katana_01"
  if A0_2 then
    L2_2 = attach_to_player
    L3_2 = L1_2
    L4_2 = 0
    L5_2 = 0
    L6_2 = -0.13
    L7_2 = 0.5
    L8_2 = 0
    L9_2 = -150
    L10_2 = 0
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
    L2_2 = attach_to_player
    L3_2 = L1_2
    L4_2 = 0
    L5_2 = 0
    L6_2 = -0.13
    L7_2 = 0.5
    L8_2 = 0
    L9_2 = 150
    L10_2 = 0
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
    L2_2 = attach_to_player
    L3_2 = L1_2
    L4_2 = 0
    L5_2 = 0.23
    L6_2 = 0
    L7_2 = 0
    L8_2 = 0
    L9_2 = -180
    L10_2 = 100
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  else
    L2_2 = delete_object
    L3_2 = L1_2
    L2_2(L3_2)
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = attach_self
L7_1 = "666"
L8_1 = {}
L9_1 = ""
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  obj = "prop_mp_num_6"
  if A0_2 then
    L1_2 = attach_to_player
    L2_2 = obj
    L3_2 = 0
    L4_2 = 0
    L5_2 = 0
    L6_2 = 1.7
    L7_2 = 0
    L8_2 = 0
    L9_2 = 180
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    L1_2 = attach_to_player
    L2_2 = obj
    L3_2 = 0
    L4_2 = 1
    L5_2 = 0
    L6_2 = 1.7
    L7_2 = 0
    L8_2 = 0
    L9_2 = 180
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    L1_2 = attach_to_player
    L2_2 = obj
    L3_2 = 0
    L4_2 = -1
    L5_2 = 0
    L6_2 = 1.7
    L7_2 = 0
    L8_2 = 0
    L9_2 = 180
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  else
    L1_2 = delete_object
    L2_2 = obj
    L1_2(L2_2)
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = attach_self
L7_1 = "冲浪板"
L8_1 = {}
L9_1 = ""
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  obj = "prop_surf_board_ldn_03"
  if A0_2 then
    L1_2 = attach_to_player
    L2_2 = obj
    L3_2 = 0
    L4_2 = 0
    L5_2 = -0.2
    L6_2 = 0.25
    L7_2 = 0
    L8_2 = -30
    L9_2 = 0
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  else
    L1_2 = delete_object
    L2_2 = obj
    L1_2(L2_2)
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = attach_self
L7_1 = "小书包"
L8_1 = {}
L9_1 = ""
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  obj = "tr_prop_tr_bag_djlp_01a"
  if A0_2 then
    L1_2 = attach_to_player
    L2_2 = obj
    L3_2 = 0
    L4_2 = 0
    L5_2 = -0.2
    L6_2 = 0.1
    L7_2 = 0
    L8_2 = 0
    L9_2 = 0
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  else
    L1_2 = delete_object
    L2_2 = obj
    L1_2(L2_2)
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = attach_self
L7_1 = "泳圈"
L8_1 = {}
L9_1 = ""
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  obj = "prop_beach_ring_01"
  if A0_2 then
    L1_2 = attach_to_player
    L2_2 = obj
    L3_2 = 0
    L4_2 = 0
    L5_2 = 0
    L6_2 = 0
    L7_2 = 0
    L8_2 = 0
    L9_2 = 0
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  else
    L1_2 = delete_object
    L2_2 = obj
    L1_2(L2_2)
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.list
L6_1 = attach_self
L7_1 = "吉他"
L5_1 = L5_1(L6_1, L7_1)
guitar_obj = L5_1
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = guitar_obj
L7_1 = "吉他1"
L8_1 = {}
L9_1 = ""
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = "prop_acc_guitar_01"
  if A0_2 then
    L2_2 = attach_to_player
    L3_2 = L1_2
    L4_2 = 0
    L5_2 = 0
    L6_2 = -0.15
    L7_2 = 0.25
    L8_2 = 0
    L9_2 = -50
    L10_2 = 0
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  else
    L2_2 = delete_object
    L3_2 = L1_2
    L2_2(L3_2)
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = guitar_obj
L7_1 = "吉他2"
L8_1 = {}
L9_1 = ""
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = "prop_el_guitar_03"
  if A0_2 then
    L2_2 = attach_to_player
    L3_2 = L1_2
    L4_2 = 0
    L5_2 = 0
    L6_2 = -0.15
    L7_2 = 0.25
    L8_2 = 0
    L9_2 = -50
    L10_2 = 0
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  else
    L2_2 = delete_object
    L3_2 = L1_2
    L2_2(L3_2)
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = guitar_obj
L7_1 = "吉他3"
L8_1 = {}
L9_1 = ""
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = "prop_el_guitar_01"
  if A0_2 then
    L2_2 = attach_to_player
    L3_2 = L1_2
    L4_2 = 0
    L5_2 = 0
    L6_2 = -0.15
    L7_2 = 0.25
    L8_2 = 0
    L9_2 = -50
    L10_2 = 0
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  else
    L2_2 = delete_object
    L3_2 = L1_2
    L2_2(L3_2)
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = guitar_obj
L7_1 = "吉他4"
L8_1 = {}
L9_1 = ""
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = "prop_el_guitar_02"
  if A0_2 then
    L2_2 = attach_to_player
    L3_2 = L1_2
    L4_2 = 0
    L5_2 = 0
    L6_2 = -0.15
    L7_2 = 0.25
    L8_2 = 0
    L9_2 = -50
    L10_2 = 0
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  else
    L2_2 = delete_object
    L3_2 = L1_2
    L2_2(L3_2)
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle_loop
L6_1 = attach_self
L7_1 = "镜子"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L0_2 = GRAPHICS
  L0_2 = L0_2.UI3DSCENE_IS_AVAILABLE
  L0_2 = L0_2()
  if L0_2 then
    L0_2 = GRAPHICS
    L0_2 = L0_2.UI3DSCENE_PUSH_PRESET
    L1_2 = "CELEBRATION_WINNER"
    L0_2 = L0_2(L1_2)
    if L0_2 then
      L0_2 = GRAPHICS
      L0_2 = L0_2.UI3DSCENE_ASSIGN_PED_TO_SLOT
      L1_2 = "CELEBRATION_WINNER"
      L2_2 = PLAYER
      L2_2 = L2_2.PLAYER_PED_ID
      L2_2 = L2_2()
      L3_2 = 0
      L4_2 = 0.0
      L5_2 = 0.0
      L6_2 = 0.0
      L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2)
    end
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle_loop
L6_1 = self_option
L7_1 = "金钱追踪"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L0_2 = PLAYER
  L0_2 = L0_2.GET_PLAYER_PED_SCRIPT_INDEX
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_COORDS
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = true
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = request_ptfx_asset
  L3_2 = "scr_exec_ambient_fm"
  L2_2(L3_2)
  L2_2 = GRAPHICS
  L2_2 = L2_2.USE_PARTICLE_FX_ASSET
  L3_2 = "scr_exec_ambient_fm"
  L2_2(L3_2)
  L2_2 = TASK
  L2_2 = L2_2.IS_PED_WALKING
  L3_2 = L0_2
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    L2_2 = TASK
    L2_2 = L2_2.IS_PED_RUNNING
    L3_2 = L0_2
    L2_2 = L2_2(L3_2)
    if not L2_2 then
      L2_2 = TASK
      L2_2 = L2_2.IS_PED_SPRINTING
      L3_2 = L0_2
      L2_2 = L2_2(L3_2)
      if not L2_2 then
        goto lbl_56
      end
    end
  end
  L2_2 = GRAPHICS
  L3_2 = "START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD"
  L2_2 = L2_2[L3_2]
  L3_2 = "scr_ped_foot_banknotes"
  L4_2 = L1_2.x
  L5_2 = L1_2.y
  L6_2 = L1_2.z
  L6_2 = L6_2 - 1
  L7_2 = 0
  L8_2 = 0
  L9_2 = 0
  L10_2 = 1.0
  L11_2 = true
  L12_2 = true
  L13_2 = true
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  ::lbl_56::
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.list
L6_1 = self_option
L7_1 = "摔倒"
L8_1 = {}
L9_1 = ""
L5_1 = L5_1(L6_1, L7_1, L8_1, L9_1)
tripped = L5_1
L5_1 = menu
L5_1 = L5_1.toggle_loop
L6_1 = tripped
L7_1 = "笨拙"
L8_1 = {}
L9_1 = "让您的人物很容易摔倒."
function L10_1()
  local L0_2, L1_2
  L0_2 = clumsy
  L0_2()
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.action
L6_1 = tripped
L7_1 = "绊倒"
L8_1 = {}
L9_1 = "让你绊倒,很可能会摔倒."
function L10_1()
  local L0_2, L1_2
  L0_2 = stumble
  L0_2()
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = tripped
L7_1 = "摔倒v1"
L8_1 = {}
L9_1 = ""
function L10_1(A0_2)
  local L1_2, L2_2
  L1_2 = tripped1
  L2_2 = A0_2
  L1_2(L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle_loop
L6_1 = tripped
L7_1 = "摔倒v2"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2
  L0_2 = tripped2
  L0_2()
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.list
L6_1 = self_option
L7_1 = "轨迹"
L8_1 = {}
L9_1 = ""
L5_1 = L5_1(L6_1, L7_1, L8_1, L9_1)
trailsOpt = L5_1
L5_1 = menu
L5_1 = L5_1.toggle_loop
L6_1 = trailsOpt
L7_1 = "轨迹"
L8_1 = {}
L9_1 = "trails"
L8_1[1] = L9_1
L9_1 = ""
function L10_1()
  local L0_2, L1_2
  L0_2 = Character_locus
  L0_2()
end
function L11_1()
  local L0_2, L1_2
  L0_2 = stop_Character_locus
  L0_2()
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1, L11_1)
L5_1 = menu
L5_1 = L5_1.rainbow
L6_1 = menu
L6_1 = L6_1.colour
L7_1 = trailsOpt
L8_1 = "颜色"
L9_1 = {}
L10_1 = "trailcolour"
L9_1[1] = L10_1
L10_1 = ""
L11_1 = locus_colour
L12_1 = false
function L13_1(A0_2)
  local L1_2, L2_2
  L1_2 = locus_color
  L2_2 = A0_2
  L1_2(L2_2)
end
L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1 = L6_1(L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1)
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1)
L5_1 = menu
L5_1 = L5_1.list
L6_1 = self_option
L7_1 = "翅膀"
L8_1 = {}
L5_1 = L5_1(L6_1, L7_1, L8_1)
fire_wings = L5_1
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = fire_wings
L7_1 = "金色翅膀"
L8_1 = {}
L9_1 = ""
function L10_1(A0_2)
  local L1_2, L2_2
  L1_2 = Golden_wings
  L2_2 = A0_2
  L1_2(L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = fire_wings
L7_1 = "银色翅膀"
L8_1 = {}
L9_1 = ""
function L10_1(A0_2)
  local L1_2, L2_2
  L1_2 = argent_wings
  L2_2 = A0_2
  L1_2(L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = fire_wings
L7_1 = "火翅膀"
L8_1 = {}
L9_1 = "2t同款翅膀"
function L10_1(A0_2)
  local L1_2, L2_2
  L1_2 = fireWing
  L2_2 = A0_2
  L1_2(L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = fire_wings
L7_1 = "彩色翅膀"
L8_1 = {}
L9_1 = ""
function L10_1(A0_2)
  local L1_2, L2_2
  L1_2 = colorful_fireWing
  L2_2 = A0_2
  L1_2(L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.list
L6_1 = self_option
L7_1 = "喷火"
L8_1 = {}
L9_1 = ""
L5_1 = L5_1(L6_1, L7_1, L8_1, L9_1)
firebreath = L5_1
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = firebreath
L7_1 = "喷火"
L8_1 = {}
L9_1 = ""
function L10_1(A0_2)
  local L1_2, L2_2
  L1_2 = firebreathxxx
  L2_2 = A0_2
  L1_2(L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.slider
L6_1 = firebreath
L7_1 = "喷火比例"
L8_1 = {}
L9_1 = "JSfireBreathScale"
L8_1[1] = L9_1
L9_1 = ""
L10_1 = 1
L11_1 = 100
L12_1 = fireBreathSettings
L12_1 = L12_1.scale
L12_1 = L12_1 * 10
L13_1 = 1
function L14_1(A0_2)
  local L1_2, L2_2
  L1_2 = firebreathscale
  L2_2 = A0_2
  L1_2(L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1)
L5_1 = menu
L5_1 = L5_1.rainbow
L6_1 = menu
L6_1 = L6_1.colour
L7_1 = firebreath
L8_1 = "喷火颜色"
L9_1 = {}
L10_1 = "JSfireBreathColour"
L9_1[1] = L10_1
L10_1 = ""
L11_1 = fireBreathSettings
L11_1 = L11_1.colour
L12_1 = 1
function L13_1(A0_2)
  local L1_2, L2_2
  L1_2 = firebreathcolour
  L2_2 = A0_2
  L1_2(L2_2)
end
L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1 = L6_1(L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1)
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1)
L5_1 = menu
L5_1 = L5_1.action
L6_1 = self_option
L7_1 = "拉便便"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2
  L0_2 = personlshit
  L0_2()
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.action
L6_1 = self_option
L7_1 = "打飞机"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2
  L0_2 = personlhitplane
  L0_2()
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.action
L6_1 = self_option
L7_1 = "起飞"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = ENTITY
  L0_2 = L0_2.GET_ENTITY_COORDS
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = false
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = ENTITY
  L1_2 = L1_2.SET_ENTITY_COORDS
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = L0_2.x
  L4_2 = L0_2.y
  L5_2 = L0_2.z
  L5_2 = L5_2 + 250.0
  L6_2 = 1
  L7_2 = 0
  L8_2 = 0
  L9_2 = 1
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.action
L6_1 = self_option
L7_1 = "强制打开降落伞"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2
  L0_2 = PED
  L0_2 = L0_2.FORCE_PED_TO_OPEN_PARACHUTE
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_ID
  L2_2 = L2_2()
  L1_2, L2_2 = L1_2(L2_2)
  L0_2(L1_2, L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.action
L6_1 = self_option
L7_1 = "给予降落伞"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = WEAPON
  L0_2 = L0_2.GIVE_DELAYED_WEAPON_TO_PED
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "gadget_parachute"
  L2_2 = L2_2(L3_2)
  L3_2 = 1
  L4_2 = 0
  L0_2(L1_2, L2_2, L3_2, L4_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.slider
L6_1 = self_option
L7_1 = "幽灵"
L8_1 = {}
L9_1 = "修改您人物的不透明度."
L10_1 = 0
L11_1 = 255
L12_1 = 255
L13_1 = 51
function L14_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = ENTITY
  L1_2 = L1_2.SET_ENTITY_ALPHA
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = A0_2
  L4_2 = false
  L1_2(L2_2, L3_2, L4_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1)
L5_1 = menu
L5_1 = L5_1.list
L6_1 = self_option
L7_1 = "通缉选项"
L8_1 = {}
L9_1 = ""
L5_1 = L5_1(L6_1, L7_1, L8_1, L9_1)
wanted_level = L5_1
L5_1 = menu
L5_1 = L5_1.slider
L6_1 = wanted_level
L7_1 = "通缉等级"
L8_1 = {}
L9_1 = ""
L10_1 = 0
L11_1 = 5
L12_1 = 0
L13_1 = 1
function L14_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = PLAYER
  L1_2 = L1_2.SET_PLAYER_WANTED_LEVEL
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_ID
  L2_2 = L2_2()
  L3_2 = A0_2
  L4_2 = false
  L1_2(L2_2, L3_2, L4_2)
  L1_2 = PLAYER
  L1_2 = L1_2.SET_PLAYER_WANTED_LEVEL_NOW
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_ID
  L2_2 = L2_2()
  L3_2 = false
  L1_2(L2_2, L3_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1)
L5_1 = menu
L5_1 = L5_1.toggle_loop
L6_1 = wanted_level
L7_1 = "永不通缉"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = PLAYER
  L0_2 = L0_2.SET_PLAYER_WANTED_LEVEL
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2 = L1_2()
  L2_2 = 0
  L3_2 = false
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = PLAYER
  L0_2 = L0_2.SET_PLAYER_WANTED_LEVEL_NOW
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2 = L1_2()
  L2_2 = false
  L0_2(L1_2, L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.slider
L6_1 = wanted_level
L7_1 = "虚假通缉等级"
L8_1 = {}
L9_1 = ""
L10_1 = 0
L11_1 = 6
L12_1 = 0
L13_1 = 1
function L14_1(A0_2)
  local L1_2, L2_2
  L1_2 = MISC
  L1_2 = L1_2.SET_FAKE_WANTED_LEVEL
  L2_2 = A0_2
  L1_2(L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1)
L5_1 = menu
L5_1 = L5_1.list_action
L6_1 = self_option
L7_1 = "获取导弹"
L8_1 = {}
L9_1 = "选择导弹"
L10_1 = opt_pp
function L11_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2
  L3_2 = dd02
  L4_2 = A0_2
  L5_2 = A1_2
  L6_2 = A2_2
  L3_2(L4_2, L5_2, L6_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1, L11_1)
L5_1 = menu
L5_1 = L5_1.action
L6_1 = self_option
L7_1 = "低射炮"
L8_1 = {}
L9_1 = "从某个位置发射一枚火炮"
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L0_2 = "scr_indep_fireworks"
  L1_2 = "scr_indep_firework_trailburst"
  L2_2 = diaoshepao
  L3_2 = L0_2
  L2_2(L3_2)
  L2_2 = GRAPHICS
  L2_2 = L2_2.USE_PARTICLE_FX_ASSET
  L3_2 = L0_2
  L2_2(L3_2)
  L2_2 = GRAPHICS
  L3_2 = "START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY"
  L2_2 = L2_2[L3_2]
  L3_2 = L1_2
  L4_2 = PLAYER
  L4_2 = L4_2.PLAYER_PED_ID
  L4_2 = L4_2()
  L5_2 = 0.0
  L6_2 = 0.0
  L7_2 = -0.3
  L8_2 = -90.0
  L9_2 = 0.0
  L10_2 = 0.0
  L11_2 = 1.0
  L12_2 = 0.0
  L13_2 = 0.0
  L14_2 = 0.0
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  L2_2 = 1
  L3_2 = 10
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = ENTITY
    L6_2 = L6_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
    L7_2 = PLAYER
    L7_2 = L7_2.PLAYER_PED_ID
    L7_2 = L7_2()
    L8_2 = 0.0
    L9_2 = L5_2
    L10_2 = 0.0
    L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
    L7_2 = FIRE
    L7_2 = L7_2.ADD_EXPLOSION
    L8_2 = L6_2.x
    L9_2 = L6_2.y
    L10_2 = L6_2.z
    L11_2 = 67
    L12_2 = 0.0
    L13_2 = false
    L14_2 = false
    L15_2 = 0.0
    L16_2 = true
    L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = self_option
L7_1 = "启用脚印"
L8_1 = {}
L9_1 = "在所有表面上留下脚印"
function L10_1(A0_2)
  local L1_2, L2_2
  L1_2 = GRAPHICS1
  L1_2 = L1_2._SET_FORCE_PED_FOOTSTEPS_TRACKS
  L2_2 = A0_2
  L1_2(L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = self_option
L7_1 = "禁用脚步声"
L8_1 = {}
L9_1 = ""
function L10_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = AUDIO1
  L1_2 = L1_2.SET_PED_AUDIO_FOOTSTEP_LOUD
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = not A0_2
  L1_2(L2_2, L3_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = self_option
L7_1 = "假死"
L8_1 = {}
L9_1 = "地图上不会出现你"
function L10_1(A0_2)
  local L1_2, L2_2, L3_2
  if A0_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.SET_ENTITY_MAX_HEALTH
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = 0
    L1_2(L2_2, L3_2)
  else
    L1_2 = ENTITY
    L1_2 = L1_2.SET_ENTITY_MAX_HEALTH
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = 328
    L1_2(L2_2, L3_2)
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.action
L6_1 = self_option
L7_1 = "自杀"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = ENTITY
  L0_2 = L0_2.SET_ENTITY_HEALTH
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = 0
  L3_2 = 0
  L0_2(L1_2, L2_2, L3_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.list
L6_1 = online
L7_1 = "在线玩家"
L8_1 = {}
L9_1 = ""
L5_1 = L5_1(L6_1, L7_1, L8_1, L9_1)
players_list = L5_1
L5_1 = players
L5_1 = L5_1.on_join
L6_1 = player_list
L5_1(L6_1)
L5_1 = players
L5_1 = L5_1.on_leave
L6_1 = handle_player_list
L5_1(L6_1)
L5_1 = menu
L5_1 = L5_1.list
L6_1 = online
L7_1 = "好友列表"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2
  L0_2 = get_friend_list
  L0_2()
end
L5_1 = L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
frendlist = L5_1
L5_1 = menu
L5_1 = L5_1.list
L6_1 = online
L7_1 = "新的战局"
L8_1 = {}
L9_1 = ""
L5_1 = L5_1(L6_1, L7_1, L8_1, L9_1)
new_session = L5_1
L5_1 = pairs
L6_1 = session_name
L5_1, L6_1, L7_1, L8_1 = L5_1(L6_1)
for L9_1, L10_1 in L5_1, L6_1, L7_1, L8_1 do
  L11_1 = new_session
  L12_1 = L11_1
  L11_1 = L11_1.action
  L13_1 = L10_1.name
  L14_1 = {}
  L15_1 = ""
  function L16_1()
    local L0_2, L1_2, L2_2
    L0_2 = SET_INT_GLOBAL
    L1_2 = Global_Base
    L1_2 = L1_2.SessionSwitchType
    L2_2 = L10_1.session_id
    L0_2(L1_2, L2_2)
    L0_2 = SET_INT_GLOBAL
    L1_2 = Global_Base
    L1_2 = L1_2.SessionSwitchState
    L2_2 = 1
    L0_2(L1_2, L2_2)
    L0_2 = util
    L0_2 = L0_2.yield
    L1_2 = 200
    L0_2(L1_2)
    L0_2 = SET_INT_GLOBAL
    L1_2 = Global_Base
    L1_2 = L1_2.SessionSwitchState
    L2_2 = 0
    L0_2(L1_2, L2_2)
  end
  L11_1(L12_1, L13_1, L14_1, L15_1, L16_1)
end
L5_1 = menu
L5_1 = L5_1.list
L6_1 = online
L7_1 = "战局信息"
L8_1 = {}
L9_1 = ""
L5_1 = L5_1(L6_1, L7_1, L8_1, L9_1)
online_other = L5_1
L5_1 = menu
L5_1 = L5_1.list
L6_1 = online_other
L7_1 = "玩家信息"
L8_1 = {}
L9_1 = ""
L5_1 = L5_1(L6_1, L7_1, L8_1, L9_1)
play_info = L5_1
L5_1 = require
L6_1 = "lib.daidailib.InfOverlay"
L5_1(L6_1)
L5_1 = menu
L5_1 = L5_1.toggle_loop
L6_1 = play_info
L7_1 = "绘制玩家模型"
L8_1 = {}
L9_1 = "当选中玩家时预览玩家模型"
function L10_1()
  local L0_2, L1_2
  L0_2 = Draw_player_model
  L0_2()
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle_loop
L6_1 = online_other
L7_1 = "关闭电台"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2
  L0_2 = AUDIO
  L0_2 = L0_2.SET_MOBILE_RADIO_ENABLED_DURING_GAMEPLAY
  L1_2 = false
  L0_2(L1_2)
  L0_2 = AUDIO
  L0_2 = L0_2.SET_RADIO_TO_STATION_NAME
  L1_2 = "OFF"
  L0_2(L1_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = online_other
L7_1 = "移动电台"
L8_1 = {}
L9_1 = "让你步行的时候也能听电台"
function L10_1(A0_2)
  local L1_2, L2_2
  L1_2 = AUDIO
  L1_2 = L1_2.SET_MOBILE_RADIO_ENABLED_DURING_GAMEPLAY
  L2_2 = A0_2
  L1_2(L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = online_other
L7_1 = "同步时间"
L8_1 = {}
L9_1 = "与现实时间同步"
function L10_1(A0_2)
  local L1_2, L2_2
  L1_2 = Real_world_time
  L2_2 = A0_2
  L1_2(L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = online_other
L7_1 = "显示时间"
L8_1 = {}
L9_1 = "配置[√]\n请于其他选项使用[保存配置]"
function L10_1(A0_2)
  local L1_2, L2_2
  L1_2 = daidaishijian
  L2_2 = A0_2
  L1_2(L2_2)
end
L5_1 = L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
show_time = L5_1
L5_1 = menu
L5_1 = L5_1.set_value
L6_1 = show_time
L7_1 = config_active2
L5_1(L6_1, L7_1)
L5_1 = menu
L5_1 = L5_1.list
L6_1 = online_other
L7_1 = "主机序列"
L8_1 = {}
L9_1 = ""
L5_1 = L5_1(L6_1, L7_1, L8_1, L9_1)
host_sequence_list = L5_1
L5_1 = menu
L5_1 = L5_1.toggle_loop
L6_1 = host_sequence_list
L7_1 = "主机序列"
L8_1 = {}
L9_1 = "配置[√]\n请于其他选项使用[保存配置]"
function L10_1()
  local L0_2, L1_2
  L0_2 = zhujixvlie
  L0_2()
end
L5_1 = L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
host_sequence = L5_1
L5_1 = menu
L5_1 = L5_1.set_value
L6_1 = host_sequence
L7_1 = config_active1
L5_1(L6_1, L7_1)
L5_1 = menu
L5_1 = L5_1.slider
L6_1 = host_sequence_list
L7_1 = "x坐标"
L8_1 = {}
L9_1 = "watermark-x"
L8_1[1] = L9_1
L9_1 = "配置[√]\n请于其他选项使用[保存配置]"
L10_1 = -1000
L11_1 = 1000
L12_1 = config_active1_x
L13_1 = 10
function L14_1(A0_2)
  local L1_2, L2_2
  L1_2 = zhujixvlie_x
  L2_2 = A0_2
  L1_2(L2_2)
end
L5_1 = L5_1(L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1)
host_sequence_x = L5_1
L5_1 = menu
L5_1 = L5_1.slider
L6_1 = host_sequence_list
L7_1 = "y坐标"
L8_1 = {}
L9_1 = "watermark-y"
L8_1[1] = L9_1
L9_1 = "配置[√]\n请于其他选项使用[保存配置]"
L10_1 = -1000
L11_1 = 1000
L12_1 = config_active1_y
L13_1 = 10
function L14_1(A0_2)
  local L1_2, L2_2
  L1_2 = zhujixvlie_y
  L2_2 = A0_2
  L1_2(L2_2)
end
L5_1 = L5_1(L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1)
host_sequence_y = L5_1
L5_1 = menu
L5_1 = L5_1.toggle
L6_1 = online_other
L7_1 = "显示fps"
L8_1 = {}
L9_1 = "配置[√]\n请于其他选项使用[保存配置]"
function L10_1(A0_2)
  local L1_2, L2_2
  L1_2 = fps
  L2_2 = A0_2
  L1_2(L2_2)
end
L5_1 = L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
numfps = L5_1
L5_1 = menu
L5_1 = L5_1.set_value
L6_1 = numfps
L7_1 = config_active4
L5_1(L6_1, L7_1)
L5_1 = menu
L5_1 = L5_1.toggle_loop
L6_1 = online_other
L7_1 = "实体池信息"
L8_1 = {}
L9_1 = "配置[√]\n请于其他选项使用[保存配置]"
function L10_1()
  local L0_2, L1_2
  L0_2 = entityinfo
  L0_2()
end
L5_1 = L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
show_entityinfo = L5_1
L5_1 = menu
L5_1 = L5_1.set_value
L6_1 = show_entityinfo
L7_1 = config_active5
L5_1(L6_1, L7_1)
L5_1 = _ENV
L6_1 = "script_name"
L7_1 = menu
L7_1 = L7_1.toggle_loop
L8_1 = online_other
L9_1 = "显示脚本名称"
L10_1 = {}
L11_1 = "配置[√]\n请于其他选项使用[保存配置]"
function L12_1()
  local L0_2, L1_2
  L0_2 = scriptname
  L0_2()
end
L7_1 = L7_1(L8_1, L9_1, L10_1, L11_1, L12_1)
L5_1[L6_1] = L7_1
L5_1 = menu
L5_1 = L5_1.set_value
L6_1 = _ENV
L7_1 = "script_name"
L6_1 = L6_1[L7_1]
L7_1 = _ENV
L8_1 = "config_active3"
L7_1 = L7_1[L8_1]
L5_1(L6_1, L7_1)
L5_1 = _ENV
L6_1 = "players_bar"
L7_1 = menu
L7_1 = L7_1.toggle_loop
L8_1 = online_other
L9_1 = "玩家栏"
L10_1 = {}
L11_1 = "配置[√]\n请于其他选项使用[保存配置]"
function L12_1()
  local L0_2, L1_2
  L0_2 = player_bar
  L0_2()
end
L7_1 = L7_1(L8_1, L9_1, L10_1, L11_1, L12_1)
L5_1[L6_1] = L7_1
L5_1 = menu
L5_1 = L5_1.set_value
L6_1 = _ENV
L7_1 = "players_bar"
L6_1 = L6_1[L7_1]
L7_1 = _ENV
L8_1 = "config_active8"
L7_1 = L7_1[L8_1]
L5_1(L6_1, L7_1)
L5_1 = _ENV
L6_1 = "all_opt"
L7_1 = menu
L7_1 = L7_1.list
L8_1 = online
L9_1 = "全局选项"
L10_1 = {}
L7_1 = L7_1(L8_1, L9_1, L10_1)
L5_1[L6_1] = L7_1
L5_1 = _ENV
L6_1 = "all_happy"
L7_1 = menu
L7_1 = L7_1.list
L8_1 = _ENV
L9_1 = "all_opt"
L8_1 = L8_1[L9_1]
L9_1 = "全局娱乐"
L10_1 = {}
L7_1 = L7_1(L8_1, L9_1, L10_1)
L5_1[L6_1] = L7_1
L5_1 = _ENV
L6_1 = "sn"
L7_1 = menu
L7_1 = L7_1.list
L8_1 = _ENV
L9_1 = "all_opt"
L8_1 = L8_1[L9_1]
L9_1 = "全局恶搞"
L10_1 = {}
L11_1 = ""
L7_1 = L7_1(L8_1, L9_1, L10_1, L11_1)
L5_1[L6_1] = L7_1
L5_1 = _ENV
L6_1 = "sk"
L7_1 = menu
L7_1 = L7_1.list
L8_1 = _ENV
L9_1 = "all_opt"
L8_1 = L8_1[L9_1]
L9_1 = "全局崩溃"
L10_1 = {}
L11_1 = ""
L7_1 = L7_1(L8_1, L9_1, L10_1, L11_1)
L5_1[L6_1] = L7_1
L5_1 = _ENV
L6_1 = "kickall_list"
L7_1 = menu
L7_1 = L7_1.list
L8_1 = _ENV
L9_1 = "all_opt"
L8_1 = L8_1[L9_1]
L9_1 = "全局踢出"
L10_1 = {}
L11_1 = ""
L7_1 = L7_1(L8_1, L9_1, L10_1, L11_1)
L5_1[L6_1] = L7_1
L5_1 = _ENV
L6_1 = "request_services"
L7_1 = menu
L7_1 = L7_1.list
L8_1 = online
L9_1 = "请求服务"
L10_1 = {}
L11_1 = ""
L7_1 = L7_1(L8_1, L9_1, L10_1, L11_1)
L5_1[L6_1] = L7_1
L5_1 = _ENV
L6_1 = "weather"
L7_1 = menu
L7_1 = L7_1.list
L8_1 = _ENV
L9_1 = "request_services"
L8_1 = L8_1[L9_1]
L9_1 = "请求天气"
L10_1 = {}
L11_1 = ""
L7_1 = L7_1(L8_1, L9_1, L10_1, L11_1)
L5_1[L6_1] = L7_1
L5_1 = menu
L5_1 = L5_1.action
L6_1 = _ENV
L7_1 = "weather"
L6_1 = L6_1[L7_1]
L7_1 = "请求雷雨天气"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2
  L0_2 = menu
  L0_2 = L0_2.trigger_commands
  L1_2 = "thunderon"
  L0_2(L1_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.action
L6_1 = _ENV
L7_1 = "weather"
L6_1 = L6_1[L7_1]
L7_1 = "关闭雷雨天气"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2
  L0_2 = menu
  L0_2 = L0_2.trigger_commands
  L1_2 = "thunderoff"
  L0_2(L1_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.action
L6_1 = _ENV
L7_1 = "request_services"
L6_1 = L6_1[L7_1]
L7_1 = "纳米无人机"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2
  L0_2 = RequestNanoDrone
  L0_2()
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.action
L6_1 = _ENV
L7_1 = "request_services"
L6_1 = L6_1[L7_1]
L7_1 = "RC匪徒"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2
  L0_2 = SET_INT_GLOBAL
  L1_2 = Global_Base
  L1_2 = L1_2.Default
  L1_2 = L1_2 + 6879
  L2_2 = 1
  L0_2(L1_2, L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.action
L6_1 = _ENV
L7_1 = "request_services"
L6_1 = L6_1[L7_1]
L7_1 = "RC坦克"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2
  L0_2 = SET_INT_GLOBAL
  L1_2 = Global_Base
  L1_2 = L1_2.Default
  L1_2 = L1_2 + 6880
  L2_2 = 1
  L0_2(L1_2, L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.action
L6_1 = _ENV
L7_1 = "request_services"
L6_1 = L6_1[L7_1]
L7_1 = "请求出租车"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2
  L0_2 = SET_INT_GLOBAL
  L1_2 = Global_Base
  L1_2 = L1_2.Default
  L1_2 = L1_2 + 853
  L2_2 = 1
  L0_2(L1_2, L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.action
L6_1 = _ENV
L7_1 = "request_services"
L6_1 = L6_1[L7_1]
L7_1 = "请求小艇"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2
  L0_2 = SET_INT_GLOBAL
  L1_2 = Global_Base
  L1_2 = L1_2.Default
  L1_2 = L1_2 + 972
  L2_2 = 1
  L0_2(L1_2, L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.action
L6_1 = _ENV
L7_1 = "request_services"
L6_1 = L6_1[L7_1]
L7_1 = "机动作战中心"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2
  L0_2 = SET_INT_GLOBAL
  L1_2 = Global_Base
  L1_2 = L1_2.Default
  L1_2 = L1_2 + 930
  L2_2 = 1
  L0_2(L1_2, L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.action
L6_1 = _ENV
L7_1 = "request_services"
L6_1 = L6_1[L7_1]
L7_1 = "复仇者"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2
  L0_2 = SET_INT_GLOBAL
  L1_2 = Global_Base
  L1_2 = L1_2.Default
  L1_2 = L1_2 + 938
  L2_2 = 1
  L0_2(L1_2, L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.action
L6_1 = _ENV
L7_1 = "request_services"
L6_1 = L6_1[L7_1]
L7_1 = "恐霸"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2
  L0_2 = SET_INT_GLOBAL
  L1_2 = Global_Base
  L1_2 = L1_2.Default
  L1_2 = L1_2 + 943
  L2_2 = 1
  L0_2(L1_2, L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.action
L6_1 = _ENV
L7_1 = "request_services"
L6_1 = L6_1[L7_1]
L7_1 = "重型防弹装甲"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2
  L0_2 = SET_INT_GLOBAL
  L1_2 = Global_Base
  L1_2 = L1_2.Default
  L1_2 = L1_2 + 901
  L2_2 = 1
  L0_2(L1_2, L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.action
L6_1 = _ENV
L7_1 = "request_services"
L6_1 = L6_1[L7_1]
L7_1 = "请求空袭"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2
  L0_2 = SET_INT_GLOBAL
  L1_2 = Global_Base
  L1_2 = L1_2.oVMYCar
  L1_2 = L1_2 + 4492
  L2_2 = 1
  L0_2(L1_2, L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.action
L6_1 = _ENV
L7_1 = "request_services"
L6_1 = L6_1[L7_1]
L7_1 = "请求弹药空投"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2
  L0_2 = SET_INT_GLOBAL
  L1_2 = Global_Base
  L1_2 = L1_2.oVMYCar
  L1_2 = L1_2 + 891
  L2_2 = 1
  L0_2(L1_2, L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.action
L6_1 = _ENV
L7_1 = "request_services"
L6_1 = L6_1[L7_1]
L7_1 = "请求直升机接送"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2
  L0_2 = SET_INT_GLOBAL
  L1_2 = Global_Base
  L1_2 = L1_2.oVMYCar
  L1_2 = L1_2 + 4491
  L2_2 = 1
  L0_2(L1_2, L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.action
L6_1 = _ENV
L7_1 = "request_services"
L6_1 = L6_1[L7_1]
L7_1 = "请求直升机支援"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2
  L0_2 = menu
  L0_2 = L0_2.trigger_commands
  L1_2 = "helibackup"
  L0_2(L1_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "online_services"
L7_1 = _ENV
L8_1 = "menu"
L7_1 = L7_1[L8_1]
L7_1 = L7_1.list
L8_1 = online
L9_1 = "线上服务"
L10_1 = {}
L11_1 = ""
L7_1 = L7_1(L8_1, L9_1, L10_1, L11_1)
L5_1[L6_1] = L7_1
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.toggle_loop
L6_1 = _ENV
L7_1 = "online_services"
L6_1 = L6_1[L7_1]
L7_1 = "强制可见"
L8_1 = {}
L9_1 = "强制玩家可见"
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = players
  L0_2 = L0_2.list
  L1_2 = false
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = PLAYER
    L6_2 = L6_2.GET_PLAYER_PED
    L7_2 = L5_2
    L6_2 = L6_2(L7_2)
    L7_2 = ENTITY
    L7_2 = L7_2.IS_ENTITY_VISIBLE
    L8_2 = L6_2
    L7_2 = L7_2(L8_2)
    if not L7_2 then
      L7_2 = ENTITY
      L7_2 = L7_2.SET_ENTITY_VISIBLE
      L8_2 = L6_2
      L9_2 = true
      L7_2(L8_2, L9_2)
    end
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.action
L6_1 = _ENV
L7_1 = "online_services"
L6_1 = L6_1[L7_1]
L7_1 = "免费更改角色外观"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2
  L0_2 = SET_INT_GLOBAL
  L1_2 = Global_Base
  L1_2 = L1_2.Default
  L1_2 = L1_2 + 19290
  L2_2 = 1
  L0_2(L1_2, L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.action
L6_1 = _ENV
L7_1 = "online_services"
L6_1 = L6_1[L7_1]
L7_1 = "移除恶意玩家(白帽子)"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = STAT_SET_INT
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "MPPLY_BADSPORT_MESSAGE"
  L1_2 = L1_2(L2_2)
  L2_2 = 0
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "MPPLY_BECAME_BADSPORT_NUM"
  L1_2 = L1_2(L2_2)
  L2_2 = 0
  L0_2(L1_2, L2_2)
  L0_2 = SET_FLOAT_LOCAL
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "MPPLY_OVERALL_BADSPORT"
  L1_2 = L1_2(L2_2)
  L2_2 = 0
  L3_2 = true
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = STAT_SET_BOOL
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "MPPLY_CHAR_IS_BADSPORT"
  L1_2 = L1_2(L2_2)
  L2_2 = false
  L0_2(L1_2, L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.action
L6_1 = _ENV
L7_1 = "online_services"
L6_1 = L6_1[L7_1]
L7_1 = "随机名字"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = random_string
  L1_2 = math
  L1_2 = L1_2.random
  L2_2 = 1
  L3_2 = 16
  L1_2, L2_2, L3_2 = L1_2(L2_2, L3_2)
  L0_2 = L0_2(L1_2, L2_2, L3_2)
  L1_2 = menu
  L1_2 = L1_2.trigger_commands
  L2_2 = "spoofedname "
  L3_2 = L0_2
  L2_2 = L2_2 .. L3_2
  L1_2(L2_2)
  L1_2 = menu
  L1_2 = L1_2.trigger_commands
  L2_2 = "spoofname on"
  L1_2(L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.slider
L6_1 = _ENV
L7_1 = "online_services"
L6_1 = L6_1[L7_1]
L7_1 = "设置精神状态"
L8_1 = {}
L9_1 = "切换战局生效"
L10_1 = 0
L11_1 = 100
L12_1 = 0
L13_1 = 1
function L14_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = STATS
  L1_2 = L1_2.STAT_SET_FLOAT
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "MPPLY_PLAYER_MENTAL_STATE"
  L2_2 = L2_2(L3_2)
  L3_2 = A0_2
  L4_2 = true
  L1_2(L2_2, L3_2, L4_2)
  L1_2 = STATS
  L1_2 = L1_2.STAT_SET_FLOAT
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "MP0_PLAYER_MENTAL_STATE"
  L2_2 = L2_2(L3_2)
  L3_2 = A0_2
  L4_2 = true
  L1_2(L2_2, L3_2, L4_2)
  L1_2 = STATS
  L1_2 = L1_2.STAT_SET_FLOAT
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "MP1_PLAYER_MENTAL_STATE"
  L2_2 = L2_2(L3_2)
  L3_2 = A0_2
  L4_2 = true
  L1_2(L2_2, L3_2, L4_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1)
L5_1 = _ENV
L6_1 = "money_remove"
L7_1 = _ENV
L8_1 = "menu"
L7_1 = L7_1[L8_1]
L8_1 = "list"
L7_1 = L7_1[L8_1]
L8_1 = _ENV
L9_1 = "online_services"
L8_1 = L8_1[L9_1]
L9_1 = "自定义金钱删除"
L10_1 = {}
L11_1 = ""
L7_1 = L7_1(L8_1, L9_1, L10_1, L11_1)
L5_1[L6_1] = L7_1
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.action
L6_1 = _ENV
L7_1 = "money_remove"
L6_1 = L6_1[L7_1]
L7_1 = "删除金钱"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2
  L0_2 = remove_money
  L0_2()
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.slider
L6_1 = _ENV
L7_1 = "money_remove"
L6_1 = L6_1[L7_1]
L7_1 = "金钱数额"
L8_1 = {}
L9_1 = "hcmoneyremove"
L8_1[1] = L9_1
L9_1 = ""
L10_1 = 0
L11_1 = 2000000000
L12_1 = 10000
L13_1 = 10000
function L14_1(A0_2)
  local L1_2, L2_2
  L1_2 = set_remove_money_acc
  L2_2 = A0_2
  L1_2(L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.toggle
L6_1 = _ENV
L7_1 = "online_services"
L6_1 = L6_1[L7_1]
L7_1 = "显示余额"
L8_1 = {}
L9_1 = ""
function L10_1(A0_2)
  local L1_2
  if A0_2 then
    L1_2 = HUD
    L1_2 = L1_2.SET_MULTIPLAYER_WALLET_CASH
    L1_2()
    L1_2 = HUD
    L1_2 = L1_2.SET_MULTIPLAYER_BANK_CASH
    L1_2()
  else
    L1_2 = HUD
    L1_2 = L1_2.REMOVE_MULTIPLAYER_WALLET_CASH
    L1_2()
    L1_2 = HUD
    L1_2 = L1_2.REMOVE_MULTIPLAYER_BANK_CASH
    L1_2()
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.toggle_loop
L6_1 = _ENV
L7_1 = "online_services"
L6_1 = L6_1[L7_1]
L7_1 = "虚假金钱"
L8_1 = {}
L9_1 = "100%的假钱"
function L10_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = math
  L0_2 = L0_2.random
  L1_2 = 10000000
  L2_2 = 30000000
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = HUD
  L1_2 = L1_2.CHANGE_FAKE_MP_CASH
  L2_2 = 0
  L3_2 = L0_2
  L1_2(L2_2, L3_2)
  L1_2 = util
  L1_2 = L1_2.yield
  L2_2 = 500
  L1_2(L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.action
L6_1 = _ENV
L7_1 = "online_services"
L6_1 = L6_1[L7_1]
L7_1 = "从银行取出钱"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2
  L0_2 = bank_to_wallet
  L0_2()
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.action
L6_1 = _ENV
L7_1 = "online_services"
L6_1 = L6_1[L7_1]
L7_1 = "将钱存入银行"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2
  L0_2 = wallet_to_bank
  L0_2()
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.toggle_loop
L6_1 = _ENV
L7_1 = "online_services"
L6_1 = L6_1[L7_1]
L7_1 = "自动存款"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2
  L0_2 = auto_deposit
  L0_2()
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.toggle
L6_1 = _ENV
L7_1 = "online_services"
L6_1 = L6_1[L7_1]
L7_1 = "获得牛鲨睾酮"
L8_1 = {}
L9_1 = ""
function L10_1(A0_2)
  local L1_2, L2_2
  if A0_2 then
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "bst on"
    L1_2(L2_2)
  else
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "bst off"
    L1_2(L2_2)
  end
  L1_2 = util
  L1_2 = L1_2.yield
  L2_2 = 5000
  L1_2(L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.action
L6_1 = _ENV
L7_1 = "online_services"
L6_1 = L6_1[L7_1]
L7_1 = "移除精神值"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2
  L0_2 = menu
  L0_2 = L0_2.trigger_commands
  L1_2 = "mentalstate 0"
  L0_2(L1_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.action
L6_1 = _ENV
L7_1 = "online_services"
L6_1 = L6_1[L7_1]
L7_1 = "移除悬赏"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2
  L0_2 = menu
  L0_2 = L0_2.trigger_commands
  L1_2 = "removebounty"
  L0_2(L1_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.toggle_loop
L6_1 = _ENV
L7_1 = "online_services"
L6_1 = L6_1[L7_1]
L7_1 = "自动移除悬赏"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2
  L0_2 = players
  L0_2 = L0_2.get_bounty
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2, L2_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2)
  if nil ~= L0_2 then
    L1_2 = util
    L1_2 = L1_2.yield
    L2_2 = 2000
    L1_2(L2_2)
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "removebounty"
    L1_2(L2_2)
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.toggle
L6_1 = _ENV
L7_1 = "online_services"
L6_1 = L6_1[L7_1]
L7_1 = "人间蒸发"
L8_1 = {}
L9_1 = ""
function L10_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = menu
  L1_2 = L1_2.set_value
  L2_2 = menu
  L2_2 = L2_2.ref_by_path
  L3_2 = "Online>Off The Radar"
  L4_2 = 38
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.action
L6_1 = _ENV
L7_1 = "online_services"
L6_1 = L6_1[L7_1]
L7_1 = "立刻完成刑事破坏"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = SCRIPT
  L1_2 = "GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH"
  L0_2 = L0_2[L1_2]
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "am_criminal_damage"
  L1_2, L2_2, L3_2 = L1_2(L2_2)
  L0_2 = L0_2(L1_2, L2_2, L3_2)
  if 0 ~= L0_2 then
    L0_2 = SET_INT_LOCAL
    L1_2 = "am_criminal_damage"
    L2_2 = 105
    L3_2 = 10000
    L0_2(L1_2, L2_2, L3_2)
    L0_2 = util
    L0_2 = L0_2.yield
    L1_2 = 3000
    L0_2(L1_2)
    L0_2 = SET_INT_LOCAL
    L1_2 = "am_criminal_damage"
    L2_2 = 149
    L3_2 = 0
    L0_2(L1_2, L2_2, L3_2)
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.action
L6_1 = _ENV
L7_1 = "online_services"
L6_1 = L6_1[L7_1]
L7_1 = "立刻完成检查点"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = SCRIPT
  L1_2 = "GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH"
  L0_2 = L0_2[L1_2]
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "am_cp_collection"
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2)
  if 0 ~= L0_2 then
    L0_2 = SET_INT_LOCAL
    L1_2 = "am_cp_collection"
    L2_2 = NETWORK
    L2_2 = L2_2.PARTICIPANT_ID_TO_INT
    L2_2 = L2_2()
    L2_2 = L2_2 + 5
    L2_2 = 3456 + L2_2
    L2_2 = L2_2 + 4
    L2_2 = L2_2 + 1
    L3_2 = 120
    L0_2(L1_2, L2_2, L3_2)
    L0_2 = GET_INT_LOCAL
    L1_2 = "am_cp_collection"
    L2_2 = NETWORK
    L2_2 = L2_2.PARTICIPANT_ID_TO_INT
    L2_2 = L2_2()
    L2_2 = L2_2 + 5
    L2_2 = 3456 + L2_2
    L2_2 = L2_2 + 4
    L2_2 = L2_2 + 1
    L0_2 = L0_2(L1_2, L2_2)
    L1_2 = util
    L1_2 = L1_2.yield
    L2_2 = 10000
    L1_2(L2_2)
    L1_2 = SET_INT_LOCAL
    L2_2 = "am_cp_collection"
    L3_2 = 1523
    L4_2 = 0
    L1_2(L2_2, L3_2, L4_2)
    L1_2 = SET_INT_LOCAL
    L2_2 = "am_cp_collection"
    L3_2 = 1476
    L4_2 = 0
    L1_2(L2_2, L3_2, L4_2)
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "musiclist"
L7_1 = _ENV
L8_1 = "menu"
L7_1 = L7_1[L8_1]
L8_1 = "list"
L7_1 = L7_1[L8_1]
L8_1 = online
L9_1 = "音乐"
L10_1 = {}
L11_1 = ""
L7_1 = L7_1(L8_1, L9_1, L10_1, L11_1)
L5_1[L6_1] = L7_1
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.toggle
L6_1 = _ENV
L7_1 = "musiclist"
L6_1 = L6_1[L7_1]
L7_1 = "播放"
L8_1 = {}
L9_1 = "音乐文件放置: '文档\\Rockstar Games\\GTA V\\User Music'中"
function L10_1(A0_2)
  local L1_2, L2_2
  L1_2 = music
  L2_2 = A0_2
  L1_2(L2_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.toggle_loop
L6_1 = _ENV
L7_1 = "musiclist"
L6_1 = L6_1[L7_1]
L7_1 = "蹦迪"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2
  L0_2 = HUD
  L0_2 = L0_2.FLASH_MINIMAP_DISPLAY_WITH_COLOR
  L1_2 = hud_rgb_colors
  L2_2 = hud_rgb_index
  L1_2 = L1_2[L2_2]
  L0_2(L1_2)
  L0_2 = hud_rgb_index
  L0_2 = L0_2 + 1
  hud_rgb_index = L0_2
  L0_2 = hud_rgb_index
  if 4 == L0_2 then
    hud_rgb_index = 1
  end
  L0_2 = util
  L0_2 = L0_2.yield
  L1_2 = 200
  L0_2(L1_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "personal_vehicle"
L7_1 = _ENV
L8_1 = "menu"
L7_1 = L7_1[L8_1]
L8_1 = "list"
L7_1 = L7_1[L8_1]
L8_1 = online
L9_1 = "个人载具"
L10_1 = {}
L11_1 = ""
L7_1 = L7_1(L8_1, L9_1, L10_1, L11_1)
L5_1[L6_1] = L7_1
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.action
L6_1 = _ENV
L7_1 = "personal_vehicle"
L6_1 = L6_1[L7_1]
L7_1 = "传送载具到我"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L0_2 = ENTITY
  L0_2 = L0_2.GET_ENTITY_COORDS
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L1_2 = entities
  L1_2 = L1_2.get_user_personal_vehicle_as_handle
  L1_2 = L1_2()
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = L1_2
  L2_2 = L2_2(L3_2)
  L3_2 = request_control
  L4_2 = L1_2
  L3_2(L4_2)
  L3_2 = L2_2.x
  if 0 == L3_2 then
    L3_2 = L2_2.y
    if 0 == L3_2 then
      L3_2 = L2_2.z
      if 0 == L3_2 then
        L3_2 = util
        L3_2 = L3_2.toast
        L4_2 = "未找到个人载具"
        L3_2(L4_2)
    end
  end
  else
    L3_2 = ENTITY
    L3_2 = L3_2.SET_ENTITY_COORDS_NO_OFFSET
    L4_2 = L1_2
    L5_2 = L0_2.x
    L6_2 = L0_2.y
    L7_2 = L0_2.z
    L8_2 = true
    L9_2 = false
    L10_2 = false
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.action
L6_1 = _ENV
L7_1 = "personal_vehicle"
L6_1 = L6_1[L7_1]
L7_1 = "传送我到载具"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = entities
  L0_2 = L0_2.get_user_personal_vehicle_as_handle
  L0_2 = L0_2()
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_COORDS
  L2_2 = L0_2
  L1_2 = L1_2(L2_2)
  L2_2 = L1_2.x
  if 0 == L2_2 then
    L2_2 = L1_2.y
    if 0 == L2_2 then
      L2_2 = L1_2.z
      if 0 == L2_2 then
        L2_2 = util
        L2_2 = L2_2.toast
        L3_2 = "未找到个人载具"
        L2_2(L3_2)
    end
  end
  else
    L2_2 = ENTITY
    L2_2 = L2_2.SET_ENTITY_COORDS_NO_OFFSET
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2 = L3_2()
    L4_2 = L1_2.x
    L5_2 = L1_2.y
    L6_2 = L1_2.z
    L7_2 = true
    L8_2 = false
    L9_2 = false
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.action
L6_1 = _ENV
L7_1 = "personal_vehicle"
L6_1 = L6_1[L7_1]
L7_1 = "驾驶个人载具"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
  L0_2 = entities
  L0_2 = L0_2.get_user_personal_vehicle_as_handle
  L0_2 = L0_2()
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_COORDS
  L2_2 = L0_2
  L1_2 = L1_2(L2_2)
  L2_2 = L1_2.x
  if 0 == L2_2 then
    L2_2 = L1_2.y
    if 0 == L2_2 then
      L2_2 = L1_2.z
      if 0 == L2_2 then
        L2_2 = util
        L2_2 = L2_2.toast
        L3_2 = "未找到个人载具"
        L2_2(L3_2)
    end
  end
  else
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
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.action
L6_1 = _ENV
L7_1 = "personal_vehicle"
L6_1 = L6_1[L7_1]
L7_1 = "索赔所有车辆"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2
  L0_2 = reclaimVehicles
  L0_2()
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "auto_host"
L7_1 = _ENV
L8_1 = "menu"
L7_1 = L7_1[L8_1]
L7_1 = L7_1.toggle_loop
L8_1 = online
L9_1 = "自动获取主机"
L10_1 = {}
L11_1 = ""
function L12_1()
  local L0_2, L1_2
  L0_2 = autogethost
  L0_2()
end
L7_1 = L7_1(L8_1, L9_1, L10_1, L11_1, L12_1)
L5_1[L6_1] = L7_1
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.action
L6_1 = online
L7_1 = "获得脚本主机"
L8_1 = {}
L9_1 = "获取脚本主机(加载战局会变快)"
function L10_1()
  local L0_2, L1_2
  L0_2 = menu
  L0_2 = L0_2.trigger_commands
  L1_2 = "scripthost"
  L0_2(L1_2)
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.toggle_loop
L6_1 = online
L7_1 = "自动获取脚本主机"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2
  L0_2 = players
  L0_2 = L0_2.get_script_host
  L0_2 = L0_2()
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2 = L1_2()
  if L0_2 ~= L1_2 then
    L0_2 = menu
    L0_2 = L0_2.trigger_commands
    L1_2 = "scripthost"
    L0_2(L1_2)
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.toggle_loop
L6_1 = online
L7_1 = "自动加入游戏"
L8_1 = {}
L9_1 = "将自动接受加入任务"
function L10_1()
  local L0_2, L1_2
  L0_2 = autoaccept
  L0_2()
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.action
L6_1 = _ENV
L7_1 = "all_happy"
L6_1 = L6_1[L7_1]
L7_1 = "雪球大战"
L8_1 = {}
L9_1 = "圣诞快乐"
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L0_2 = players
  L0_2 = L0_2.list
  L0_2 = L0_2()
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "WEAPON_SNOWBALL"
  L1_2 = L1_2(L2_2)
  L2_2 = 1
  L3_2 = #L0_2
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = PLAYER
    L6_2 = L6_2.GET_PLAYER_PED_SCRIPT_INDEX
    L7_2 = L0_2[L5_2]
    L6_2 = L6_2(L7_2)
    L7_2 = WEAPON
    L7_2 = L7_2.GIVE_DELAYED_WEAPON_TO_PED
    L8_2 = L6_2
    L9_2 = L1_2
    L10_2 = 20
    L11_2 = true
    L7_2(L8_2, L9_2, L10_2, L11_2)
    L7_2 = WEAPON
    L7_2 = L7_2.SET_PED_AMMO
    L8_2 = L6_2
    L9_2 = L1_2
    L10_2 = 20
    L7_2(L8_2, L9_2, L10_2)
    L7_2 = players
    L7_2 = L7_2.send_sms
    L8_2 = L0_2[L5_2]
    L9_2 = PLAYER
    L9_2 = L9_2.PLAYER_ID
    L9_2 = L9_2()
    L10_2 = "雪球大战!你获得了雪球"
    L7_2(L8_2, L9_2, L10_2)
    L7_2 = util
    L7_2 = L7_2.yield
    L7_2()
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.action
L6_1 = _ENV
L7_1 = "all_happy"
L6_1 = L6_1[L7_1]
L7_1 = "烟花大战"
L8_1 = {}
L9_1 = "新年快乐"
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L0_2 = players
  L0_2 = L0_2.list
  L0_2 = L0_2()
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "weapon_firework"
  L1_2 = L1_2(L2_2)
  L2_2 = 1
  L3_2 = #L0_2
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = PLAYER
    L6_2 = L6_2.GET_PLAYER_PED_SCRIPT_INDEX
    L7_2 = L0_2[L5_2]
    L6_2 = L6_2(L7_2)
    L7_2 = WEAPON
    L7_2 = L7_2.GIVE_DELAYED_WEAPON_TO_PED
    L8_2 = L6_2
    L9_2 = L1_2
    L10_2 = 20
    L11_2 = true
    L7_2(L8_2, L9_2, L10_2, L11_2)
    L7_2 = WEAPON
    L7_2 = L7_2.SET_PED_AMMO
    L8_2 = L6_2
    L9_2 = L1_2
    L10_2 = 20
    L7_2(L8_2, L9_2, L10_2)
    L7_2 = players
    L7_2 = L7_2.send_sms
    L8_2 = L0_2[L5_2]
    L9_2 = PLAYER
    L9_2 = L9_2.PLAYER_ID
    L9_2 = L9_2()
    L10_2 = "烟花大战!你获得了烟花"
    L7_2(L8_2, L9_2, L10_2)
    L7_2 = util
    L7_2 = L7_2.yield
    L7_2()
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.action
L6_1 = _ENV
L7_1 = "all_happy"
L6_1 = L6_1[L7_1]
L7_1 = "给予所有玩家MK-2"
L8_1 = {}
L9_1 = ""
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = pairs
  L1_2 = players
  L1_2 = L1_2.list
  L2_2 = true
  L3_2 = true
  L4_2 = true
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2 = L1_2(L2_2, L3_2, L4_2)
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = give_oppressor
    L7_2 = L5_2
    L6_2(L7_2)
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L6_1 = "divider"
L5_1 = L5_1[L6_1]
L6_1 = _ENV
L7_1 = "sn"
L6_1 = L6_1[L7_1]
L7_1 = "全局恶搞"
L5_1(L6_1, L7_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.toggle_loop
L6_1 = _ENV
L7_1 = "sn"
L6_1 = L6_1[L7_1]
L7_1 = "禁止进入天基炮室"
L8_1 = {}
L9_1 = "生成一个物体 挡住天基炮的门"
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L0_2 = util
  L0_2 = L0_2.joaat
  L1_2 = "h4_prop_h4_garage_door_01a"
  L0_2 = L0_2(L1_2)
  L1_2 = orb_obj_smc
  if nil ~= L1_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.DOES_ENTITY_EXIST
    L2_2 = orb_obj_smc
    L1_2 = L1_2(L2_2)
    if L1_2 then
      goto lbl_34
    end
  end
  L1_2 = entities
  L1_2 = L1_2.create_object
  L2_2 = L0_2
  L3_2 = v3
  L4_2 = 335.9
  L5_2 = 4833.9
  L6_2 = -59.0
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2, L5_2, L6_2)
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
  orb_obj_smc = L1_2
  L1_2 = ENTITY
  L1_2 = L1_2.SET_ENTITY_HEADING
  L2_2 = orb_obj_smc
  L3_2 = 125.0
  L1_2(L2_2, L3_2)
  L1_2 = ENTITY
  L1_2 = L1_2.FREEZE_ENTITY_POSITION
  L2_2 = orb_obj_smc
  L3_2 = true
  L1_2(L2_2, L3_2)
  ::lbl_34::
end
function L11_1()
  local L0_2, L1_2
  L0_2 = orb_obj_smc
  if nil ~= L0_2 then
    L0_2 = delete_entity
    L1_2 = orb_obj_smc
    L0_2(L1_2)
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1, L11_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.toggle_loop
L6_1 = _ENV
L7_1 = "sn"
L6_1 = L6_1[L7_1]
L7_1 = "禁止进入高跟鞋"
L8_1 = {}
L9_1 = "生成一个物体 挡住高跟鞋的门"
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = util
  L0_2 = L0_2.joaat
  L1_2 = "h4_prop_h4_garage_door_01a"
  L0_2 = L0_2(L1_2)
  L1_2 = players
  L1_2 = L1_2.get_position
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_ID
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  L2_2 = orb_obj_hh
  if nil ~= L2_2 then
    L2_2 = ENTITY
    L2_2 = L2_2.DOES_ENTITY_EXIST
    L3_2 = orb_obj_hh
    L2_2 = L2_2(L3_2)
    if L2_2 then
      goto lbl_44
    end
  end
  L2_2 = entities
  L2_2 = L2_2.create_object
  L3_2 = L0_2
  L4_2 = v3
  L5_2 = 128
  L6_2 = -1298.5
  L7_2 = 29.5
  L4_2, L5_2, L6_2, L7_2, L8_2 = L4_2(L5_2, L6_2, L7_2)
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  orb_obj_hh = L2_2
  L2_2 = ENTITY
  L2_2 = L2_2.SET_ENTITY_ROTATION
  L3_2 = orb_obj_hh
  L4_2 = 0.0
  L5_2 = 0.0
  L6_2 = 30
  L7_2 = 1
  L8_2 = true
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  L2_2 = ENTITY
  L2_2 = L2_2.FREEZE_ENTITY_POSITION
  L3_2 = orb_obj_hh
  L4_2 = true
  L2_2(L3_2, L4_2)
  ::lbl_44::
end
function L11_1()
  local L0_2, L1_2
  L0_2 = orb_obj_hh
  if nil ~= L0_2 then
    L0_2 = delete_entity
    L1_2 = orb_obj_hh
    L0_2(L1_2)
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1, L11_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.toggle_loop
L6_1 = _ENV
L7_1 = "sn"
L6_1 = L6_1[L7_1]
L7_1 = "脚本主机轮盘"
L8_1 = {}
L9_1 = "循环给予所有人脚本主机\n可能破坏战局"
function L10_1()
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
    L6_2 = menu
    L6_2 = L6_2.trigger_commands
    L7_2 = "givesh"
    L8_2 = players
    L8_2 = L8_2.get_name
    L9_2 = L5_2
    L8_2 = L8_2(L9_2)
    L7_2 = L7_2 .. L8_2
    L6_2(L7_2)
    L6_2 = util
    L6_2 = L6_2.yield
    L7_2 = 1500
    L6_2(L7_2)
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.action
L6_1 = _ENV
L7_1 = "sn"
L6_1 = L6_1[L7_1]
L7_1 = "发送到介绍界面"
L8_1 = {}
L9_1 = "将战局中的每个人都送到GTAOnline的介绍动画中去."
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2
  L0_2 = 0
  L1_2 = 31
  L2_2 = 1
  for L3_2 = L0_2, L1_2, L2_2 do
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_ID
    L4_2 = L4_2()
    if L3_2 ~= L4_2 then
      L4_2 = memory
      L4_2 = L4_2.read_int
      L5_2 = memory
      L5_2 = L5_2.script_global
      L6_2 = Global_Base
      L6_2 = L6_2.gpbd_fm_3
      L6_2 = L6_2 + 1
      L7_2 = L3_2 * 609
      L6_2 = L6_2 + L7_2
      L6_2 = L6_2 + 511
      L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2 = L5_2(L6_2)
      L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2)
      L5_2 = util
      L5_2 = L5_2.trigger_script_event
      L6_2 = SYSTEM
      L6_2 = L6_2.SHIFT_LEFT
      L7_2 = L3_2
      L8_2 = 1
      L6_2 = L6_2(L7_2, L8_2)
      L7_2 = {}
      L8_2 = -366707054
      L9_2 = PLAYER
      L9_2 = L9_2.PLAYER_ID
      L9_2 = L9_2()
      L10_2 = 20
      L11_2 = 0
      L12_2 = 0
      L13_2 = 48
      L14_2 = 0
      L15_2 = 0
      L16_2 = 0
      L17_2 = 0
      L18_2 = 0
      L19_2 = 0
      L20_2 = 0
      L21_2 = 0
      L22_2 = 0
      L23_2 = 0
      L24_2 = 0
      L25_2 = 0
      L26_2 = -1
      L27_2 = 0
      L28_2 = 0
      L29_2 = 0
      L30_2 = 0
      L31_2 = 0
      L32_2 = L4_2
      L7_2[1] = L8_2
      L7_2[2] = L9_2
      L7_2[3] = L10_2
      L7_2[4] = L11_2
      L7_2[5] = L12_2
      L7_2[6] = L13_2
      L7_2[7] = L14_2
      L7_2[8] = L15_2
      L7_2[9] = L16_2
      L7_2[10] = L17_2
      L7_2[11] = L18_2
      L7_2[12] = L19_2
      L7_2[13] = L20_2
      L7_2[14] = L21_2
      L7_2[15] = L22_2
      L7_2[16] = L23_2
      L7_2[17] = L24_2
      L7_2[18] = L25_2
      L7_2[19] = L26_2
      L7_2[20] = L27_2
      L7_2[21] = L28_2
      L7_2[22] = L29_2
      L7_2[23] = L30_2
      L7_2[24] = L31_2
      L7_2[25] = L32_2
      L5_2(L6_2, L7_2)
      L5_2 = util
      L5_2 = L5_2.trigger_script_event
      L6_2 = SYSTEM
      L6_2 = L6_2.SHIFT_LEFT
      L7_2 = L3_2
      L8_2 = 1
      L6_2 = L6_2(L7_2, L8_2)
      L7_2 = {}
      L8_2 = 1757622014
      L9_2 = PLAYER
      L9_2 = L9_2.PLAYER_ID
      L9_2 = L9_2()
      L10_2 = 0
      L11_2 = 0
      L12_2 = 0
      L13_2 = 0
      L14_2 = 0
      L15_2 = 0
      L16_2 = 0
      L17_2 = 0
      L18_2 = 0
      L19_2 = 0
      L20_2 = 0
      L21_2 = 0
      L22_2 = 0
      L23_2 = 0
      L24_2 = 0
      L25_2 = 0
      L26_2 = 0
      L27_2 = 0
      L28_2 = 0
      L29_2 = 0
      L30_2 = 0
      L31_2 = 0
      L32_2 = 0
      L7_2[1] = L8_2
      L7_2[2] = L9_2
      L7_2[3] = L10_2
      L7_2[4] = L11_2
      L7_2[5] = L12_2
      L7_2[6] = L13_2
      L7_2[7] = L14_2
      L7_2[8] = L15_2
      L7_2[9] = L16_2
      L7_2[10] = L17_2
      L7_2[11] = L18_2
      L7_2[12] = L19_2
      L7_2[13] = L20_2
      L7_2[14] = L21_2
      L7_2[15] = L22_2
      L7_2[16] = L23_2
      L7_2[17] = L24_2
      L7_2[18] = L25_2
      L7_2[19] = L26_2
      L7_2[20] = L27_2
      L7_2[21] = L28_2
      L7_2[22] = L29_2
      L7_2[23] = L30_2
      L7_2[24] = L31_2
      L7_2[25] = L32_2
      L5_2(L6_2, L7_2)
    end
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "menu"
L5_1 = L5_1[L6_1]
L5_1 = L5_1.action
L6_1 = _ENV
L7_1 = "sn"
L6_1 = L6_1[L7_1]
L7_1 = "发送到高尔夫俱乐部"
L8_1 = {}
L9_1 = "让战局中所有人都去打高尔夫."
function L10_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2
  L0_2 = 0
  L1_2 = 31
  L2_2 = 1
  for L3_2 = L0_2, L1_2, L2_2 do
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_ID
    L4_2 = L4_2()
    if L3_2 ~= L4_2 then
      L4_2 = memory
      L4_2 = L4_2.read_int
      L5_2 = memory
      L5_2 = L5_2.script_global
      L6_2 = L3_2 * 608
      L6_2 = 1894574 + L6_2
      L6_2 = L6_2 + 510
      L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2 = L5_2(L6_2)
      L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2)
      L5_2 = util
      L5_2 = L5_2.trigger_script_event
      L6_2 = SYSTEM
      L6_2 = L6_2.SHIFT_LEFT
      L7_2 = L3_2
      L8_2 = 1
      L6_2 = L6_2(L7_2, L8_2)
      L7_2 = {}
      L8_2 = -95341040
      L9_2 = PLAYER
      L9_2 = L9_2.PLAYER_ID
      L9_2 = L9_2()
      L10_2 = 193
      L11_2 = 0
      L12_2 = 0
      L13_2 = 48
      L14_2 = 0
      L15_2 = 0
      L16_2 = 0
      L17_2 = 0
      L18_2 = 0
      L19_2 = 0
      L20_2 = 0
      L21_2 = 0
      L22_2 = 0
      L23_2 = 0
      L24_2 = 0
      L25_2 = 0
      L26_2 = -1
      L27_2 = 0
      L28_2 = 0
      L29_2 = 0
      L30_2 = 0
      L31_2 = 0
      L32_2 = L4_2
      L7_2[1] = L8_2
      L7_2[2] = L9_2
      L7_2[3] = L10_2
      L7_2[4] = L11_2
      L7_2[5] = L12_2
      L7_2[6] = L13_2
      L7_2[7] = L14_2
      L7_2[8] = L15_2
      L7_2[9] = L16_2
      L7_2[10] = L17_2
      L7_2[11] = L18_2
      L7_2[12] = L19_2
      L7_2[13] = L20_2
      L7_2[14] = L21_2
      L7_2[15] = L22_2
      L7_2[16] = L23_2
      L7_2[17] = L24_2
      L7_2[18] = L25_2
      L7_2[19] = L26_2
      L7_2[20] = L27_2
      L7_2[21] = L28_2
      L7_2[22] = L29_2
      L7_2[23] = L30_2
      L7_2[24] = L31_2
      L7_2[25] = L32_2
      L5_2(L6_2, L7_2)
      L5_2 = util
      L5_2 = L5_2.trigger_script_event
      L6_2 = SYSTEM
      L6_2 = L6_2.SHIFT_LEFT
      L7_2 = L3_2
      L8_2 = 1
      L6_2 = L6_2(L7_2, L8_2)
      L7_2 = {}
      L8_2 = 1742713914
      L9_2 = PLAYER
      L9_2 = L9_2.PLAYER_ID
      L9_2 = L9_2()
      L10_2 = 0
      L11_2 = 0
      L12_2 = 0
      L13_2 = 0
      L14_2 = 0
      L15_2 = 0
      L16_2 = 0
      L17_2 = 0
      L18_2 = 0
      L19_2 = 0
      L20_2 = 0
      L21_2 = 0
      L22_2 = 0
      L23_2 = 0
      L24_2 = 0
      L25_2 = 0
      L26_2 = 0
      L27_2 = 0
      L28_2 = 0
      L29_2 = 0
      L30_2 = 0
      L31_2 = 0
      L32_2 = 0
      L7_2[1] = L8_2
      L7_2[2] = L9_2
      L7_2[3] = L10_2
      L7_2[4] = L11_2
      L7_2[5] = L12_2
      L7_2[6] = L13_2
      L7_2[7] = L14_2
      L7_2[8] = L15_2
      L7_2[9] = L16_2
      L7_2[10] = L17_2
      L7_2[11] = L18_2
      L7_2[12] = L19_2
      L7_2[13] = L20_2
      L7_2[14] = L21_2
      L7_2[15] = L22_2
      L7_2[16] = L23_2
      L7_2[17] = L24_2
      L7_2[18] = L25_2
      L7_2[19] = L26_2
      L7_2[20] = L27_2
      L7_2[21] = L28_2
      L7_2[22] = L29_2
      L7_2[23] = L30_2
      L7_2[24] = L31_2
      L7_2[25] = L32_2
      L5_2(L6_2, L7_2)
    end
  end
end
L5_1(L6_1, L7_1, L8_1, L9_1, L10_1)
L5_1 = _ENV
L6_1 = "auto_bounty"
L7_1 = _ENV
L8_1 = "menu"
L7_1 = L7_1[L8_1]
L8_1 = "list"
L7_1 = L7_1[L8_1]
L8_1 = _ENV
L9_1 = "sn"
L8_1 = L8_1[L9_1]
L9_1 = "全局悬赏"
L10_1 = {}
L11_1 = ""
L7_1 = L7_1(L8_1, L9_1, L10_1, L11_1)
L5_1[L6_1] = L7_1
L5_1 = 10000
L6_1 = _ENV
L7_1 = "menu"
L6_1 = L6_1[L7_1]
L6_1 = L6_1.toggle_loop
L7_1 = _ENV
L8_1 = "auto_bounty"
L7_1 = L7_1[L8_1]
L8_1 = "自动悬赏"
L9_1 = {}
L10_1 = "循环向每个人提供悬赏"
function L11_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = 0
  L1_2 = 31
  L2_2 = 1
  for L3_2 = L0_2, L1_2, L2_2 do
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_ID
    L4_2 = L4_2()
    if L3_2 ~= L4_2 then
      L4_2 = players
      L4_2 = L4_2.get_bounty
      L5_2 = L3_2
      L4_2 = L4_2(L5_2)
      L5_2 = L5_1
      if L4_2 ~= L5_2 then
        L4_2 = PLAYER
        L4_2 = L4_2.GET_PLAYER_PED
        L5_2 = L3_2
        L4_2 = L4_2(L5_2)
        if 0 ~= L4_2 then
          L4_2 = menu
          L4_2 = L4_2.trigger_commands
          L5_2 = "bounty"
          L6_2 = players
          L6_2 = L6_2.get_name
          L7_2 = L3_2
          L6_2 = L6_2(L7_2)
          L7_2 = " "
          L8_2 = L5_1
          L5_2 = L5_2 .. L6_2 .. L7_2 .. L8_2
          L4_2(L5_2)
        end
      end
    end
  end
  L0_2 = util
  L0_2 = L0_2.yield
  L1_2 = 5000
  L0_2(L1_2)
end
L6_1(L7_1, L8_1, L9_1, L10_1, L11_1)
L6_1 = _ENV
L7_1 = "auto_bounty"
L6_1 = L6_1[L7_1]
L7_1 = L6_1
L6_1 = L6_1.slider
L8_1 = "悬赏金额"
L9_1 = {}
L10_1 = "autobountyamount"
L9_1[1] = L10_1
L10_1 = "选择自动提供的赏金金额"
L11_1 = 1
L12_1 = 10000
L13_1 = 10000
L14_1 = 1000
function L15_1(A0_2)
  local L1_2
  L5_1 = A0_2
end
L6_1(L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1)
L6_1 = _ENV
L7_1 = "menu"
L6_1 = L6_1[L7_1]
L6_1 = L6_1.action
L7_1 = _ENV
L8_1 = "sn"
L7_1 = L7_1[L8_1]
L8_1 = "劫持所有载具"
L9_1 = {}
L10_1 = "生成一个劫匪NPC,把他们从车里带出来并开走开."
function L11_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
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
    L7_2 = players
    L7_2 = L7_2.get_position
    L8_2 = L5_2
    L7_2 = L7_2(L8_2)
    L8_2 = v3
    L8_2 = L8_2.distance
    L9_2 = players
    L9_2 = L9_2.get_position
    L10_2 = PLAYER
    L10_2 = L10_2.PLAYER_ID
    L10_2, L11_2, L12_2, L13_2 = L10_2()
    L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2)
    L10_2 = players
    L10_2 = L10_2.get_position
    L11_2 = L5_2
    L10_2, L11_2, L12_2, L13_2 = L10_2(L11_2)
    L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2, L13_2)
    L9_2 = v3
    L9_2 = L9_2.distance
    L10_2 = L7_2
    L11_2 = players
    L11_2 = L11_2.get_cam_pos
    L12_2 = PLAYER
    L12_2 = L12_2.PLAYER_ID
    L12_2, L13_2 = L12_2()
    L11_2, L12_2, L13_2 = L11_2(L12_2, L13_2)
    L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2)
    L10_2 = 1000.0
    if L8_2 < L10_2 then
      L10_2 = 1000.0
      if L9_2 < L10_2 then
        L10_2 = PED
        L10_2 = L10_2.IS_PED_IN_ANY_VEHICLE
        L11_2 = L6_2
        L12_2 = false
        L10_2 = L10_2(L11_2, L12_2)
        if L10_2 then
          L10_2 = menu
          L10_2 = L10_2.trigger_commands
          L11_2 = "hijack "
          L12_2 = players
          L12_2 = L12_2.get_name
          L13_2 = L5_2
          L12_2 = L12_2(L13_2)
          L11_2 = L11_2 .. L12_2
          L10_2(L11_2)
        end
      end
    end
  end
end
L6_1(L7_1, L8_1, L9_1, L10_1, L11_1)
L6_1 = _ENV
L7_1 = "menu"
L6_1 = L6_1[L7_1]
L6_1 = L6_1.toggle_loop
L7_1 = _ENV
L8_1 = "sn"
L7_1 = L7_1[L8_1]
L8_1 = "赌场陷阱"
L9_1 = {}
L10_1 = ""
function L11_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L0_2 = util
  L0_2 = L0_2.joaat
  L1_2 = "hei_prop_ss1_mpint_garage2"
  L0_2 = L0_2(L1_2)
  L1_2 = request_model
  L2_2 = L0_2
  L1_2(L2_2)
  L1_2 = trap_obj
  if nil ~= L1_2 then
    L1_2 = trap_obj2
    if nil ~= L1_2 then
      L1_2 = ENTITY
      L1_2 = L1_2.DOES_ENTITY_EXIST
      L2_2 = trap_obj
      L1_2 = L1_2(L2_2)
      if L1_2 then
        L1_2 = ENTITY
        L1_2 = L1_2.DOES_ENTITY_EXIST
        L2_2 = trap_obj2
        L1_2 = L1_2(L2_2)
        if L1_2 then
          goto lbl_83
        end
      end
    end
  end
  L1_2 = entities
  L1_2 = L1_2.create_object
  L2_2 = L0_2
  L3_2 = v3
  L4_2 = 1089.62
  L5_2 = 206.334
  L6_2 = -48.473
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L3_2(L4_2, L5_2, L6_2)
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  trap_obj = L1_2
  L1_2 = entities
  L1_2 = L1_2.create_object
  L2_2 = L0_2
  L3_2 = v3
  L4_2 = 1090.0166
  L5_2 = 213.826
  L6_2 = -48.473
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L3_2(L4_2, L5_2, L6_2)
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  trap_obj2 = L1_2
  L1_2 = ENTITY
  L1_2 = L1_2.SET_ENTITY_HEADING
  L2_2 = trap_obj2
  L3_2 = 31.0
  L1_2(L2_2, L3_2)
  L1_2 = {}
  L2_2 = trap_obj
  L3_2 = trap_obj2
  L1_2[1] = L2_2
  L1_2[2] = L3_2
  L2_2 = L1_2
  L3_2 = nil
  L4_2 = nil
  L5_2 = nil
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = entities
    L8_2 = L8_2.set_can_migrate
    L9_2 = entities
    L9_2 = L9_2.handle_to_pointer
    L10_2 = L7_2
    L9_2 = L9_2(L10_2)
    L10_2 = false
    L8_2(L9_2, L10_2)
    L8_2 = ENTITY
    L8_2 = L8_2.FREEZE_ENTITY_POSITION
    L9_2 = L7_2
    L10_2 = true
    L8_2(L9_2, L10_2)
    L8_2 = ENTITY
    L8_2 = L8_2.SET_ENTITY_NO_COLLISION_ENTITY
    L9_2 = PLAYER
    L9_2 = L9_2.PLAYER_PED_ID
    L9_2 = L9_2()
    L10_2 = L7_2
    L11_2 = false
    L8_2(L9_2, L10_2, L11_2)
  end
  ::lbl_83::
  L1_2 = util
  L1_2 = L1_2.yield
  L1_2()
end
function L12_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = {}
  L1_2 = trap_obj
  L2_2 = trap_obj2
  L0_2[1] = L1_2
  L0_2[2] = L2_2
  L1_2 = L0_2
  L2_2 = nil
  L3_2 = nil
  L4_2 = nil
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    if nil ~= L6_2 then
      L7_2 = NETWORK
      L7_2 = L7_2.NETWORK_REQUEST_CONTROL_OF_ENTITY
      L8_2 = L6_2
      L7_2(L8_2)
      L7_2 = delete_entity
      L8_2 = L6_2
      L7_2(L8_2)
    end
  end
end
L6_1(L7_1, L8_1, L9_1, L10_1, L11_1, L12_1)
L6_1 = _ENV
L7_1 = "penitentiary"
L8_1 = _ENV
L9_1 = "menu"
L8_1 = L8_1[L9_1]
L9_1 = "list"
L8_1 = L8_1[L9_1]
L9_1 = _ENV
L10_1 = "sn"
L9_1 = L9_1[L10_1]
L10_1 = "监狱"
L8_1 = L8_1(L9_1, L10_1)
L6_1[L7_1] = L8_1
L6_1 = _ENV
L7_1 = "menu"
L6_1 = L6_1[L7_1]
L6_1 = L6_1.action
L7_1 = _ENV
L8_1 = "penitentiary"
L7_1 = L7_1[L8_1]
L8_1 = "创建监狱"
L9_1 = {}
L10_1 = "仿2t监狱"
function L11_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = 779277682
  L1_2 = OBJECT
  L1_2 = L1_2.CREATE_OBJECT_NO_OFFSET
  L2_2 = L0_2
  L3_2 = 970
  L4_2 = -1020
  L5_2 = 40
  L6_2 = true
  L7_2 = false
  L8_2 = false
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  L2_2 = ENTITY
  L2_2 = L2_2.SET_ENTITY_ROTATION
  L3_2 = L1_2
  L4_2 = 0.0
  L5_2 = -90.0
  L6_2 = 0.0
  L7_2 = 1
  L8_2 = true
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
end
L6_1(L7_1, L8_1, L9_1, L10_1, L11_1)
L6_1 = _ENV
L7_1 = "menu"
L6_1 = L6_1[L7_1]
L6_1 = L6_1.action
L7_1 = _ENV
L8_1 = "penitentiary"
L7_1 = L7_1[L8_1]
L8_1 = "创建监狱2"
L9_1 = {}
L10_1 = "2t监狱"
function L11_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L0_2 = 267648181
  L1_2 = OBJECT
  L1_2 = L1_2.CREATE_OBJECT_NO_OFFSET
  L2_2 = L0_2
  L3_2 = 980
  L4_2 = -1025
  L5_2 = 41.5
  L6_2 = true
  L7_2 = false
  L8_2 = false
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  L2_2 = ENTITY
  L2_2 = L2_2.SET_ENTITY_ROTATION
  L3_2 = L1_2
  L4_2 = 0.0
  L5_2 = 0.0
  L6_2 = -88.0
  L7_2 = 1
  L8_2 = true
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  L2_2 = ENTITY
  L2_2 = L2_2.FREEZE_ENTITY_POSITION
  L3_2 = L1_2
  L4_2 = true
  L2_2(L3_2, L4_2)
  L2_2 = OBJECT
  L2_2 = L2_2.CREATE_OBJECT_NO_OFFSET
  L3_2 = L0_2
  L4_2 = 976
  L5_2 = -1033
  L6_2 = 41.5
  L7_2 = true
  L8_2 = false
  L9_2 = false
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L3_2 = ENTITY
  L3_2 = L3_2.SET_ENTITY_ROTATION
  L4_2 = L2_2
  L5_2 = 0.0
  L6_2 = 0.0
  L7_2 = -143.0
  L8_2 = 1
  L9_2 = true
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L3_2 = ENTITY
  L3_2 = L3_2.FREEZE_ENTITY_POSITION
  L4_2 = L2_2
  L5_2 = true
  L3_2(L4_2, L5_2)
  L3_2 = OBJECT
  L3_2 = L3_2.CREATE_OBJECT_NO_OFFSET
  L4_2 = L0_2
  L5_2 = 967
  L6_2 = -1035
  L7_2 = 41.5
  L8_2 = true
  L9_2 = false
  L10_2 = false
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L4_2 = ENTITY
  L4_2 = L4_2.SET_ENTITY_ROTATION
  L5_2 = L3_2
  L6_2 = 0.0
  L7_2 = 0.0
  L8_2 = 170.0
  L9_2 = 1
  L10_2 = true
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L4_2 = ENTITY
  L4_2 = L4_2.FREEZE_ENTITY_POSITION
  L5_2 = L3_2
  L6_2 = true
  L4_2(L5_2, L6_2)
  L4_2 = OBJECT
  L4_2 = L4_2.CREATE_OBJECT_NO_OFFSET
  L5_2 = L0_2
  L6_2 = 976
  L7_2 = -1016
  L8_2 = 41.5
  L9_2 = true
  L10_2 = false
  L11_2 = false
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_ROTATION
  L6_2 = L4_2
  L7_2 = 0.0
  L8_2 = 0.0
  L9_2 = -44
  L10_2 = 1
  L11_2 = true
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L5_2 = ENTITY
  L5_2 = L5_2.FREEZE_ENTITY_POSITION
  L6_2 = L4_2
  L7_2 = true
  L5_2(L6_2, L7_2)
  L5_2 = OBJECT
  L5_2 = L5_2.CREATE_OBJECT_NO_OFFSET
  L6_2 = L0_2
  L7_2 = 967
  L8_2 = -1012
  L9_2 = 41.5
  L10_2 = true
  L11_2 = false
  L12_2 = false
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L6_2 = ENTITY
  L6_2 = L6_2.SET_ENTITY_ROTATION
  L7_2 = L5_2
  L8_2 = 0.0
  L9_2 = 0.0
  L10_2 = -5
  L11_2 = 1
  L12_2 = true
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L6_2 = ENTITY
  L6_2 = L6_2.FREEZE_ENTITY_POSITION
  L7_2 = L5_2
  L8_2 = true
  L6_2(L7_2, L8_2)
end
L6_1(L7_1, L8_1, L9_1, L10_1, L11_1)
L6_1 = _ENV
L7_1 = "menu"
L6_1 = L6_1[L7_1]
L6_1 = L6_1.action
L7_1 = _ENV
L8_1 = "penitentiary"
L7_1 = L7_1[L8_1]
L8_1 = "发送所有玩家到监狱"
L9_1 = {}
L10_1 = ""
function L11_1()
  local L0_2, L1_2
  L0_2 = menu
  L0_2 = L0_2.trigger_commands
  L1_2 = "apt24all"
  L0_2(L1_2)
end
L6_1(L7_1, L8_1, L9_1, L10_1, L11_1)
L6_1 = _ENV
L7_1 = "menu"
L6_1 = L6_1[L7_1]
L6_1 = L6_1.action
L7_1 = _ENV
L8_1 = "penitentiary"
L7_1 = L7_1[L8_1]
L8_1 = "将自己传送到监狱外侧"
L9_1 = {}
L10_1 = ""
function L11_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = teleport
  L1_2 = 994
  L2_2 = -1013
  L3_2 = 42
  L0_2(L1_2, L2_2, L3_2)
end
L6_1(L7_1, L8_1, L9_1, L10_1, L11_1)
L6_1 = _ENV
L7_1 = "menu"
L6_1 = L6_1[L7_1]
L6_1 = L6_1.action
L7_1 = _ENV
L8_1 = "sn"
L7_1 = L7_1[L8_1]
L8_1 = "匿名杀人"
L9_1 = {}
L10_1 = "匿名杀死所有人"
function L11_1()
  local L0_2, L1_2
  L0_2 = nimingsharen
  L0_2()
end
L6_1(L7_1, L8_1, L9_1, L10_1, L11_1)
L6_1 = _ENV
L7_1 = "menu"
L6_1 = L6_1[L7_1]
L6_1 = L6_1.action
L7_1 = _ENV
L8_1 = "sn"
L7_1 = L7_1[L8_1]
L8_1 = "爆炸所有人"
L9_1 = {}
L10_1 = "爆炸所有玩家."
function L11_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L0_2 = getNonWhitelistedPlayers
  L1_2 = whitelistListTable
  L2_2 = whitelistGroups
  L3_2 = whitelistedName
  L0_2 = L0_2(L1_2, L2_2, L3_2)
  L1_2 = pairs
  L2_2 = L0_2
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = PLAYER
    L7_2 = L7_2.GET_PLAYER_PED_SCRIPT_INDEX
    L8_2 = L6_2
    L7_2 = L7_2(L8_2)
    L8_2 = explodePlayer
    L9_2 = L7_2
    L10_2 = false
    L11_2 = expSettings
    L8_2(L9_2, L10_2, L11_2)
  end
end
L6_1(L7_1, L8_1, L9_1, L10_1, L11_1)
L6_1 = _ENV
L7_1 = "explodeLoopAll"
L8_1 = _ENV
L9_1 = "menu"
L8_1 = L8_1[L9_1]
L8_1 = L8_1.toggle_loop
L9_1 = _ENV
L10_1 = "sn"
L9_1 = L9_1[L10_1]
L10_1 = "循环爆炸所有人"
L11_1 = {}
L12_1 = "不断的爆炸所有玩家."
function L13_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L0_2 = getNonWhitelistedPlayers
  L1_2 = whitelistListTable
  L2_2 = whitelistGroups
  L3_2 = whitelistedName
  L0_2 = L0_2(L1_2, L2_2, L3_2)
  L1_2 = pairs
  L2_2 = L0_2
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = PLAYER
    L7_2 = L7_2.GET_PLAYER_PED_SCRIPT_INDEX
    L8_2 = L6_2
    L7_2 = L7_2(L8_2)
    L8_2 = explodePlayer
    L9_2 = L7_2
    L10_2 = true
    L11_2 = expSettings
    L8_2(L9_2, L10_2, L11_2)
  end
  L1_2 = util
  L1_2 = L1_2.yield
  L1_2()
end
L8_1 = L8_1(L9_1, L10_1, L11_1, L12_1, L13_1)
L6_1[L7_1] = L8_1
L6_1 = _ENV
L7_1 = "menu"
L6_1 = L6_1[L7_1]
L6_1 = L6_1.action
L7_1 = _ENV
L8_1 = "sn"
L7_1 = L7_1[L8_1]
L8_1 = "车辆电磁脉冲"
L9_1 = {}
L10_1 = "让每个人的车都熄火"
function L11_1()
  local L0_2, L1_2
  L0_2 = veh_EMP
  L0_2()
end
L6_1(L7_1, L8_1, L9_1, L10_1, L11_1)
L6_1 = _ENV
L7_1 = "menu"
L6_1 = L6_1[L7_1]
L6_1 = L6_1.toggle_loop
L7_1 = _ENV
L8_1 = "sn"
L7_1 = L7_1[L8_1]
L8_1 = "禁飞区"
L9_1 = {}
L10_1 = "强迫所有乘坐飞行载具的玩家回到地面."
function L11_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2
  L0_2 = getNonWhitelistedPlayers
  L1_2 = whitelistListTable
  L2_2 = whitelistGroups
  L3_2 = whitelistedName
  L0_2 = L0_2(L1_2, L2_2, L3_2)
  L1_2 = pairs
  L2_2 = L0_2
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = PLAYER
    L7_2 = L7_2.GET_PLAYER_PED_SCRIPT_INDEX
    L8_2 = L6_2
    L7_2 = L7_2(L8_2)
    L8_2 = PED
    L8_2 = L8_2.GET_VEHICLE_PED_IS_IN
    L9_2 = L7_2
    L10_2 = false
    L8_2 = L8_2(L9_2, L10_2)
    L9_2 = ENTITY
    L9_2 = L9_2.IS_ENTITY_IN_AIR
    L10_2 = L8_2
    L9_2 = L9_2(L10_2)
    if L9_2 then
      L9_2 = NETWORK
      L9_2 = L9_2.NETWORK_REQUEST_CONTROL_OF_ENTITY
      L10_2 = L8_2
      L9_2(L10_2)
      L9_2 = ENTITY
      L9_2 = L9_2.APPLY_FORCE_TO_ENTITY
      L10_2 = L8_2
      L11_2 = 1
      L12_2 = 0
      L13_2 = 0
      L14_2 = -0.8
      L15_2 = 0
      L16_2 = 0
      L17_2 = 0.5
      L18_2 = 0
      L19_2 = false
      L20_2 = false
      L21_2 = true
      L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
      L9_2 = menu
      L9_2 = L9_2.toast
      L10_2 = "已应用强制返回地面"
      L9_2(L10_2)
    end
  end
end
L6_1(L7_1, L8_1, L9_1, L10_1, L11_1)
L6_1 = _ENV
L7_1 = "menu"
L6_1 = L6_1[L7_1]
L6_1 = L6_1.action
L7_1 = _ENV
L8_1 = "sn"
L7_1 = L7_1[L8_1]
L8_1 = "困住所有玩家"
L9_1 = {}
L10_1 = ""
function L11_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L0_2 = 0
  L1_2 = 31
  L2_2 = 1
  for L3_2 = L0_2, L1_2, L2_2 do
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_ID
    L4_2 = L4_2()
    if L3_2 ~= L4_2 then
      L4_2 = players
      L4_2 = L4_2.exists
      L5_2 = L3_2
      L4_2 = L4_2(L5_2)
      if L4_2 then
        L4_2 = ENTITY
        L4_2 = L4_2.GET_ENTITY_COORDS
        L5_2 = PLAYER
        L5_2 = L5_2.GET_PLAYER_PED
        L6_2 = L3_2
        L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L5_2(L6_2)
        L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
        L5_2 = L4_2.z
        L5_2 = L5_2 + 0.95
        L4_2.z = L5_2
        L5_2 = ENTITY
        L5_2 = L5_2.GET_ENTITY_COORDS
        L6_2 = PLAYER
        L6_2 = L6_2.GET_PLAYER_PED
        L7_2 = L3_2
        L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L6_2(L7_2)
        L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
        L6_2 = L5_2.z
        L6_2 = L6_2 - 0.9
        L5_2.z = L6_2
        L6_2 = util
        L6_2 = L6_2.joaat
        L7_2 = "prop_feeder1_cr"
        L6_2 = L6_2(L7_2)
        L7_2 = request_model
        L8_2 = L6_2
        L7_2(L8_2)
        L7_2 = OBJECT
        L7_2 = L7_2.CREATE_OBJECT_NO_OFFSET
        L8_2 = L6_2
        L9_2 = L4_2.x
        L10_2 = L4_2.y
        L11_2 = L4_2.z
        L12_2 = true
        L13_2 = true
        L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
        L7_2 = OBJECT
        L7_2 = L7_2.CREATE_OBJECT_NO_OFFSET
        L8_2 = L6_2
        L9_2 = L5_2.x
        L10_2 = L5_2.y
        L11_2 = L5_2.z
        L12_2 = true
        L13_2 = true
        L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
      end
    end
  end
end
L6_1(L7_1, L8_1, L9_1, L10_1, L11_1)
L6_1 = _ENV
L7_1 = "menu"
L6_1 = L6_1[L7_1]
L6_1 = L6_1.toggle_loop
L7_1 = _ENV
L8_1 = "kickall_list"
L7_1 = L7_1[L8_1]
L8_1 = "自动踢出无敌玩家"
L9_1 = {}
L10_1 = ""
function L11_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = 0
  L1_2 = 31
  L2_2 = 1
  for L3_2 = L0_2, L1_2, L2_2 do
    L4_2 = players
    L4_2 = L4_2.is_godmode
    L5_2 = L3_2
    L4_2 = L4_2(L5_2)
    if L4_2 then
      L4_2 = players
      L4_2 = L4_2.get_name
      L5_2 = L3_2
      L4_2 = L4_2(L5_2)
      L5_2 = players
      L5_2 = L5_2.get_name
      L6_2 = PLAYER
      L6_2 = L6_2.PLAYER_ID
      L6_2, L7_2 = L6_2()
      L5_2 = L5_2(L6_2, L7_2)
      if L4_2 ~= L5_2 then
        L4_2 = menu
        L4_2 = L4_2.trigger_commands
        L5_2 = "kick"
        L6_2 = players
        L6_2 = L6_2.get_name
        L7_2 = L3_2
        L6_2 = L6_2(L7_2)
        L5_2 = L5_2 .. L6_2
        L4_2(L5_2)
        L4_2 = util
        L4_2 = L4_2.toast
        L5_2 = "已踢出 "
        L6_2 = players
        L6_2 = L6_2.get_name
        L7_2 = L3_2
        L6_2 = L6_2(L7_2)
        L7_2 = " 无敌 :D"
        L5_2 = L5_2 .. L6_2 .. L7_2
        L4_2(L5_2)
      end
    end
  end
end
L6_1(L7_1, L8_1, L9_1, L10_1, L11_1)
L6_1 = _ENV
L7_1 = "menu"
L6_1 = L6_1[L7_1]
L6_1 = L6_1.action
L7_1 = _ENV
L8_1 = "kickall_list"
L7_1 = L7_1[L8_1]
L8_1 = "踢出所有玩家"
L9_1 = {}
L10_1 = ""
function L11_1()
  local L0_2, L1_2
  L0_2 = menu
  L0_2 = L0_2.trigger_commands
  L1_2 = "kickall"
  L0_2(L1_2)
end
L6_1(L7_1, L8_1, L9_1, L10_1, L11_1)
L6_1 = _ENV
L7_1 = "menu"
L6_1 = L6_1[L7_1]
L6_1 = L6_1.action
L7_1 = _ENV
L8_1 = "chat_msg"
L7_1 = L7_1[L8_1]
L8_1 = "全局聊天"
L9_1 = {}
L10_1 = "全部聊天"
function L11_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L0_2 = util
  L0_2 = L0_2.register_label
  L1_2 = "输入文本"
  L0_2 = L0_2(L1_2)
  L1_2 = get_input_from_screen_keyboard
  L2_2 = L0_2
  L3_2 = 254
  L4_2 = ""
  L1_2 = L1_2(L2_2, L3_2, L4_2)
  if "" == L1_2 then
    return
  end
  L2_2 = chat
  L2_2 = L2_2.send_message
  L3_2 = L1_2
  L4_2 = false
  L5_2 = true
  L6_2 = true
  L2_2(L3_2, L4_2, L5_2, L6_2)
end
L6_1(L7_1, L8_1, L9_1, L10_1, L11_1)
L6_1 = _ENV
L7_1 = "Advanced_chat"
L8_1 = _ENV
L9_1 = "menu"
L8_1 = L8_1[L9_1]
L9_1 = "list"
L8_1 = L8_1[L9_1]
L9_1 = _ENV
L10_1 = "chat_msg"
L9_1 = L9_1[L10_1]
L10_1 = "高级聊天"
L11_1 = {}
L12_1 = ""
L8_1 = L8_1(L9_1, L10_1, L11_1, L12_1)
L6_1[L7_1] = L8_1
L6_1 = require
L7_1 = "lib.daidailib.chatPlus"
L6_1(L7_1)
L6_1 = _ENV
L7_1 = "chat_transl"
L8_1 = _ENV
L9_1 = "menu"
L8_1 = L8_1[L9_1]
L9_1 = "list"
L8_1 = L8_1[L9_1]
L9_1 = _ENV
L10_1 = "chat_msg"
L9_1 = L9_1[L10_1]
L10_1 = "聊天翻译"
L11_1 = {}
L12_1 = ""
L8_1 = L8_1(L9_1, L10_1, L11_1, L12_1)
L6_1[L7_1] = L8_1
L6_1 = require
L7_1 = "lib.daidailib.translator"
L6_1(L7_1)
L6_1 = _ENV
L7_1 = "menu"
L6_1 = L6_1[L7_1]
L6_1 = L6_1.textslider
L7_1 = _ENV
L8_1 = "chat_msg"
L7_1 = L7_1[L8_1]
L8_1 = "便捷聊天"
L9_1 = {}
L10_1 = ""
L11_1 = {}
L12_1 = "R星认证已通过"
L13_1 = "Rockstar"
L11_1[1] = L12_1
L11_1[2] = L13_1
function L12_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = "¦"
  if 2 == A0_2 then
    L1_2 = "∑"
  end
  L2_2 = chat
  L2_2 = L2_2.ensure_open_with_empty_draft
  L3_2 = false
  L2_2(L3_2)
  L2_2 = chat
  L2_2 = L2_2.add_to_draft
  L3_2 = L1_2
  L4_2 = " "
  L3_2 = L3_2 .. L4_2
  L2_2(L3_2)
end
L6_1(L7_1, L8_1, L9_1, L10_1, L11_1, L12_1)
L6_1 = _ENV
L7_1 = "chatspamtrash"
L8_1 = _ENV
L9_1 = "menu"
L8_1 = L8_1[L9_1]
L9_1 = "list"
L8_1 = L8_1[L9_1]
L9_1 = _ENV
L10_1 = "chat_msg"
L9_1 = L9_1[L10_1]
L10_1 = "聊天刷屏"
L8_1 = L8_1(L9_1, L10_1)
L6_1[L7_1] = L8_1
L6_1 = _ENV
L7_1 = "taunt"
L8_1 = _ENV
L9_1 = "menu"
L8_1 = L8_1[L9_1]
L9_1 = "list"
L8_1 = L8_1[L9_1]
L9_1 = _ENV
L10_1 = "chatspamtrash"
L9_1 = L9_1[L10_1]
L10_1 = "嘲讽"
L8_1 = L8_1(L9_1, L10_1)
L6_1[L7_1] = L8_1
L6_1 = _ENV
L7_1 = "menu"
L6_1 = L6_1[L7_1]
L6_1 = L6_1.action
L7_1 = _ENV
L8_1 = "taunt"
L7_1 = L7_1[L8_1]
L8_1 = "嘲讽v1"
L9_1 = {}
L10_1 = ": u cant crash 2stand1 SakuraScript user XD"
function L11_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = chat
  L0_2 = L0_2.send_message
  L1_2 = "u cant crash 2stand1 SakuraScript user XD"
  L2_2 = false
  L3_2 = true
  L4_2 = true
  L0_2(L1_2, L2_2, L3_2, L4_2)
end
L6_1(L7_1, L8_1, L9_1, L10_1, L11_1)
L6_1 = _ENV
L7_1 = "menu"
L6_1 = L6_1[L7_1]
L6_1 = L6_1.action
L7_1 = _ENV
L8_1 = "taunt"
L7_1 = L7_1[L8_1]
L8_1 = "嘲讽v2"
L9_1 = {}
L10_1 = ": u cant crash GTA5 Online assistant user XD"
function L11_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = chat
  L0_2 = L0_2.send_message
  L1_2 = "u cant crash GTA5 Online assistant user XD"
  L2_2 = false
  L3_2 = true
  L4_2 = true
  L0_2(L1_2, L2_2, L3_2, L4_2)
end
L6_1(L7_1, L8_1, L9_1, L10_1, L11_1)
L6_1 = _ENV
L7_1 = "custom_taunt"
L8_1 = _ENV
L9_1 = "menu"
L8_1 = L8_1[L9_1]
L9_1 = "list"
L8_1 = L8_1[L9_1]
L9_1 = _ENV
L10_1 = "chatspamtrash"
L9_1 = L9_1[L10_1]
L10_1 = "自定义"
L8_1 = L8_1(L9_1, L10_1)
L6_1[L7_1] = L8_1
L6_1 = _ENV
L7_1 = "menu"
L6_1 = L6_1[L7_1]
L6_1 = L6_1.action
L7_1 = _ENV
L8_1 = "custom_taunt"
L7_1 = L7_1[L8_1]
L8_1 = _ENV
L9_1 = "tauntname1"
L8_1 = L8_1[L9_1]
L9_1 = {}
L10_1 = "内容可在lib/daidailib/freetext中修改"
function L11_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = chat
  L0_2 = L0_2.send_message
  L1_2 = custom_taunt_sentence1
  L2_2 = false
  L3_2 = true
  L4_2 = true
  L0_2(L1_2, L2_2, L3_2, L4_2)
end
L6_1(L7_1, L8_1, L9_1, L10_1, L11_1)
L6_1 = _ENV
L7_1 = "menu"
L6_1 = L6_1[L7_1]
L6_1 = L6_1.action
L7_1 = _ENV
L8_1 = "custom_taunt"
L7_1 = L7_1[L8_1]
L8_1 = _ENV
L9_1 = "tauntname2"
L8_1 = L8_1[L9_1]
L9_1 = {}
L10_1 = "内容可在lib/daidailib/freetext中修改"
function L11_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = chat
  L0_2 = L0_2.send_message
  L1_2 = custom_taunt_sentence2
  L2_2 = false
  L3_2 = true
  L4_2 = true
  L0_2(L1_2, L2_2, L3_2, L4_2)
end
L6_1(L7_1, L8_1, L9_1, L10_1, L11_1)
L6_1 = _ENV
L7_1 = "menu"
L6_1 = L6_1[L7_1]
L6_1 = L6_1.action
L7_1 = _ENV
L8_1 = "chat_msg"
L7_1 = L7_1[L8_1]
L8_1 = "清除聊天历史"
L9_1 = {}
L10_1 = ""
function L11_1()
  local L0_2, L1_2
  L0_2 = sfchat
  L0_2 = L0_2.RESET
  L0_2()
end
L6_1(L7_1, L8_1, L9_1, L10_1, L11_1)
L6_1 = _ENV
L7_1 = "veh_movement"
L8_1 = _ENV
L9_1 = "menu"
L8_1 = L8_1[L9_1]
L9_1 = "list"
L8_1 = L8_1[L9_1]
L9_1 = _ENV
L10_1 = "vehicle"
L9_1 = L9_1[L10_1]
L10_1 = "移动选项"
L11_1 = {}
L12_1 = ""
L8_1 = L8_1(L9_1, L10_1, L11_1, L12_1)
L6_1[L7_1] = L8_1
L6_1 = _ENV
L7_1 = "menu"
L6_1 = L6_1[L7_1]
L6_1 = L6_1.toggle
L7_1 = _ENV
L8_1 = "veh_movement"
L7_1 = L7_1[L8_1]
L8_1 = "失控驾驶"
L9_1 = {}
L10_1 = ""
function L11_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = PED
  L1_2 = L1_2.GET_VEHICLE_PED_IS_IN
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = true
  L1_2 = L1_2(L2_2, L3_2)
  if A0_2 then
    L2_2 = VEHICLE
    L2_2 = L2_2.SET_VEHICLE_REDUCE_GRIP
    L3_2 = L1_2
    L4_2 = true
    L2_2(L3_2, L4_2)
    L2_2 = VEHICLE1
    L2_2 = L2_2._SET_VEHICLE_REDUCE_TRACTION
    L3_2 = L1_2
    L4_2 = 50
    L2_2(L3_2, L4_2)
  else
    L2_2 = VEHICLE
    L2_2 = L2_2.SET_VEHICLE_REDUCE_GRIP
    L3_2 = L1_2
    L4_2 = false
    L2_2(L3_2, L4_2)
    L2_2 = VEHICLE1
    L2_2 = L2_2._SET_VEHICLE_REDUCE_TRACTION
    L3_2 = L1_2
    L4_2 = 100
    L2_2(L3_2, L4_2)
  end
end
L6_1(L7_1, L8_1, L9_1, L10_1, L11_1)
L6_1 = _ENV
L7_1 = "cruise_control"
L8_1 = _ENV
L9_1 = "menu"
L8_1 = L8_1[L9_1]
L9_1 = "list"
L8_1 = L8_1[L9_1]
L9_1 = _ENV
L10_1 = "veh_movement"
L9_1 = L9_1[L10_1]
L10_1 = "定速巡航"
L11_1 = {}
L12_1 = ""
L8_1 = L8_1(L9_1, L10_1, L11_1, L12_1)
L6_1[L7_1] = L8_1
L6_1 = 30
L7_1 = _ENV
L8_1 = "menu"
L7_1 = L7_1[L8_1]
L7_1 = L7_1.toggle_loop
L8_1 = _ENV
L9_1 = "cruise_control"
L8_1 = L8_1[L9_1]
L9_1 = "开启"
L10_1 = {}
L11_1 = ""
function L12_1()
  local L0_2, L1_2, L2_2
  L0_2 = VEHICLE
  L0_2 = L0_2.SET_VEHICLE_FORWARD_SPEED
  L1_2 = entities
  L1_2 = L1_2.get_user_vehicle_as_handle
  L1_2 = L1_2()
  L2_2 = L6_1
  L2_2 = L2_2 / 3.6
  L0_2(L1_2, L2_2)
end
L7_1(L8_1, L9_1, L10_1, L11_1, L12_1)
L7_1 = _ENV
L8_1 = "menu"
L7_1 = L7_1[L8_1]
L7_1 = L7_1.slider
L8_1 = _ENV
L9_1 = "cruise_control"
L8_1 = L8_1[L9_1]
L9_1 = "速度设置"
L10_1 = {}
L11_1 = ""
L12_1 = 0
L13_1 = 300
L14_1 = 30
L15_1 = 10
function L16_1(A0_2)
  local L1_2
  L6_1 = A0_2
end
L7_1(L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1)
L7_1 = _ENV
L8_1 = "veh_max_speed"
L9_1 = _ENV
L10_1 = "menu"
L9_1 = L9_1[L10_1]
L10_1 = "list"
L9_1 = L9_1[L10_1]
L10_1 = _ENV
L11_1 = "veh_movement"
L10_1 = L10_1[L11_1]
L11_1 = "最大速度限制"
L12_1 = {}
L13_1 = ""
L9_1 = L9_1(L10_1, L11_1, L12_1, L13_1)
L7_1[L8_1] = L9_1
L7_1 = 200
L8_1 = _ENV
L9_1 = "menu"
L8_1 = L8_1[L9_1]
L8_1 = L8_1.toggle_loop
L9_1 = _ENV
L10_1 = "veh_max_speed"
L9_1 = L9_1[L10_1]
L10_1 = "开启"
L11_1 = {}
L12_1 = ""
function L13_1()
  local L0_2, L1_2, L2_2
  L0_2 = ENTITY
  L0_2 = L0_2.SET_ENTITY_MAX_SPEED
  L1_2 = entities
  L1_2 = L1_2.get_user_vehicle_as_handle
  L1_2 = L1_2()
  L2_2 = L7_1
  L2_2 = L2_2 / 3.6
  L0_2(L1_2, L2_2)
end
L8_1(L9_1, L10_1, L11_1, L12_1, L13_1)
L8_1 = _ENV
L9_1 = "menu"
L8_1 = L8_1[L9_1]
L8_1 = L8_1.slider
L9_1 = _ENV
L10_1 = "veh_max_speed"
L9_1 = L9_1[L10_1]
L10_1 = "速度设置"
L11_1 = {}
L12_1 = ""
L13_1 = 0
L14_1 = 300
L15_1 = 200
L16_1 = 10
function L17_1(A0_2)
  local L1_2
  L7_1 = A0_2
end
L8_1(L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1)
L8_1 = _ENV
L9_1 = "Torque_switching"
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L11_1 = "list"
L10_1 = L10_1[L11_1]
L11_1 = _ENV
L12_1 = "veh_movement"
L11_1 = L11_1[L12_1]
L12_1 = "扭矩切换"
L13_1 = {}
L14_1 = ""
L10_1 = L10_1(L11_1, L12_1, L13_1, L14_1)
L8_1[L9_1] = L10_1
L8_1 = 51
L9_1 = _ENV
L10_1 = "menu"
L9_1 = L9_1[L10_1]
L9_1 = L9_1.slider
L10_1 = _ENV
L11_1 = "Torque_switching"
L10_1 = L10_1[L11_1]
L11_1 = "扭矩速度"
L12_1 = {}
L13_1 = "torquespeed"
L12_1[1] = L13_1
L13_1 = ""
L14_1 = 1
L15_1 = 500
L16_1 = 51
L17_1 = 1
function L18_1(A0_2)
  local L1_2
  L8_1 = A0_2
end
L9_1(L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1)
L9_1 = _ENV
L10_1 = "menu"
L9_1 = L9_1[L10_1]
L9_1 = L9_1.toggle_loop
L10_1 = _ENV
L11_1 = "Torque_switching"
L10_1 = L10_1[L11_1]
L11_1 = "开启"
L12_1 = {}
L13_1 = ""
function L14_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = entities
  L0_2 = L0_2.get_user_vehicle_as_handle
  L0_2 = L0_2()
  if nil ~= L0_2 then
    L1_2 = NETWORK
    L1_2 = L1_2.NETWORK_HAS_CONTROL_OF_ENTITY
    L2_2 = L0_2
    L1_2 = L1_2(L2_2)
    if not L1_2 then
      L1_2 = NETWORK
      L1_2 = L1_2.NETWORK_REQUEST_CONTROL_OF_ENTITY
      L2_2 = L0_2
      L1_2(L2_2)
    end
    L1_2 = VEHICLE
    L1_2 = L1_2.MODIFY_VEHICLE_TOP_SPEED
    L2_2 = L0_2
    L3_2 = L8_1
    L1_2(L2_2, L3_2)
    L1_2 = ENTITY
    L1_2 = L1_2.SET_ENTITY_MAX_SPEED
    L2_2 = L0_2
    L3_2 = L8_1
    L1_2(L2_2, L3_2)
  end
end
L9_1(L10_1, L11_1, L12_1, L13_1, L14_1)
L9_1 = _ENV
L10_1 = "nitrogen_acceleration"
L11_1 = _ENV
L12_1 = "menu"
L11_1 = L11_1[L12_1]
L12_1 = "list"
L11_1 = L11_1[L12_1]
L12_1 = _ENV
L13_1 = "veh_movement"
L12_1 = L12_1[L13_1]
L13_1 = "氮气加速"
L14_1 = {}
L15_1 = ""
L11_1 = L11_1(L12_1, L13_1, L14_1, L15_1)
L9_1[L10_1] = L11_1
L9_1 = _ENV
L10_1 = "menu"
L9_1 = L9_1[L10_1]
L9_1 = L9_1.toggle_loop
L10_1 = _ENV
L11_1 = "nitrogen_acceleration"
L10_1 = L10_1[L11_1]
L11_1 = "氮气加速"
L12_1 = {}
L13_1 = "按X使用"
function L14_1()
  local L0_2, L1_2
  L0_2 = nnitrogen_acceleration
  L0_2()
end
L9_1(L10_1, L11_1, L12_1, L13_1, L14_1)
L9_1 = _ENV
L10_1 = "menu"
L9_1 = L9_1[L10_1]
L9_1 = L9_1.slider
L10_1 = _ENV
L11_1 = "nitrogen_acceleration"
L10_1 = L10_1[L11_1]
L11_1 = "氮气时间"
L12_1 = {}
L13_1 = "nitroduration"
L12_1[1] = L13_1
L13_1 = ""
L14_1 = 1
L15_1 = 20
L16_1 = 2
L17_1 = 1
function L18_1(A0_2)
  local L1_2, L2_2
  L1_2 = nnitro_duration
  L2_2 = A0_2
  L1_2(L2_2)
end
L9_1(L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1)
L9_1 = _ENV
L10_1 = "menu"
L9_1 = L9_1[L10_1]
L9_1 = L9_1.slider
L10_1 = _ENV
L11_1 = "nitrogen_acceleration"
L10_1 = L10_1[L11_1]
L11_1 = "氮气速度"
L12_1 = {}
L13_1 = "nitropower"
L12_1[1] = L13_1
L13_1 = ""
L14_1 = 1
L15_1 = 10000
L16_1 = 2000
L17_1 = 50
function L18_1(A0_2)
  local L1_2, L2_2
  L1_2 = nnitro_power
  L2_2 = A0_2
  L1_2(L2_2)
end
L9_1(L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1)
L9_1 = _ENV
L10_1 = "menu"
L9_1 = L9_1[L10_1]
L9_1 = L9_1.toggle_loop
L10_1 = _ENV
L11_1 = "nitrogen_acceleration"
L10_1 = L10_1[L11_1]
L11_1 = "排气管喷火"
L12_1 = {}
L13_1 = ""
function L14_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = PED
  L0_2 = L0_2.GET_VEHICLE_PED_IS_IN
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = false
  L0_2 = L0_2(L1_2, L2_2)
  if 0 ~= L0_2 then
    L1_2 = entities
    L1_2 = L1_2.handle_to_pointer
    L2_2 = L0_2
    L1_2 = L1_2(L2_2)
    L2_2 = entities
    L2_2 = L2_2.set_rpm
    L3_2 = L1_2
    L4_2 = 2.0
    L2_2(L3_2, L4_2)
  end
  L1_2 = util
  L1_2 = L1_2.yield
  L2_2 = 100
  L1_2(L2_2)
end
L9_1(L10_1, L11_1, L12_1, L13_1, L14_1)
L9_1 = _ENV
L10_1 = "menu"
L9_1 = L9_1[L10_1]
L9_1 = L9_1.toggle
L10_1 = _ENV
L11_1 = "veh_movement"
L10_1 = L10_1[L11_1]
L11_1 = "反向控制"
L12_1 = {}
L13_1 = ""
function L14_1(A0_2)
  local L1_2, L2_2
  L1_2 = car_crash
  L2_2 = A0_2
  L1_2(L2_2)
end
L9_1(L10_1, L11_1, L12_1, L13_1, L14_1)
L9_1 = _ENV
L10_1 = "dow_block"
L11_1 = 0
L9_1[L10_1] = L11_1
L9_1 = _ENV
L10_1 = "driveonwater"
L11_1 = false
L9_1[L10_1] = L11_1
L9_1 = _ENV
L10_1 = "ls_driveonwater"
L11_1 = _ENV
L12_1 = "menu"
L11_1 = L11_1[L12_1]
L11_1 = L11_1.toggle
L12_1 = _ENV
L13_1 = "veh_movement"
L12_1 = L12_1[L13_1]
L13_1 = "水上驾驶"
L14_1 = {}
L15_1 = "driveonwater"
L14_1[1] = L15_1
L15_1 = ""
function L16_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  driveonwater = A0_2
  if A0_2 then
    L1_2 = menu
    L1_2 = L1_2.set_value
    L2_2 = ls_driveonair
    L3_2 = false
    L1_2(L2_2, L3_2)
    L1_2 = menu
    L1_2 = L1_2.set_value
    L2_2 = ls_walkwater
    L3_2 = false
    L1_2(L2_2, L3_2)
  else
    L1_2 = driveonair
    if not L1_2 then
      L1_2 = walkonwater
      if not L1_2 then
        L1_2 = ENTITY
        L1_2 = L1_2.SET_ENTITY_COORDS_NO_OFFSET
        L2_2 = dow_block
        L3_2 = 0
        L4_2 = 0
        L5_2 = 0
        L6_2 = false
        L7_2 = false
        L8_2 = false
        L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
      end
    end
  end
end
L11_1 = L11_1(L12_1, L13_1, L14_1, L15_1, L16_1)
L9_1[L10_1] = L11_1
L9_1 = _ENV
L10_1 = "doa_ht"
L11_1 = 0
L9_1[L10_1] = L11_1
L9_1 = _ENV
L10_1 = "driveonair"
L11_1 = false
L9_1[L10_1] = L11_1
L9_1 = _ENV
L10_1 = "ls_driveonair"
L11_1 = _ENV
L12_1 = "menu"
L11_1 = L11_1[L12_1]
L11_1 = L11_1.toggle
L12_1 = _ENV
L13_1 = "veh_movement"
L12_1 = L12_1[L13_1]
L13_1 = "空中驾驶"
L14_1 = {}
L15_1 = "driveonair"
L14_1[1] = L15_1
L15_1 = ""
function L16_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  driveonair = A0_2
  if A0_2 then
    L1_2 = players
    L1_2 = L1_2.get_position
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_ID
    L2_2, L3_2, L4_2 = L2_2()
    L1_2 = L1_2(L2_2, L3_2, L4_2)
    L2_2 = L1_2.z
    doa_ht = L2_2
    L2_2 = notification
    L3_2 = "~y~~bold~使用空格键和ctrl键微调驾驶高度!"
    L4_2 = HudColour
    L4_2 = L4_2.blue
    L2_2(L3_2, L4_2)
    L2_2 = driveonwater
    if not L2_2 then
      L2_2 = walkonwater
      if not L2_2 then
        goto lbl_33
      end
    end
    L2_2 = menu
    L2_2 = L2_2.set_value
    L3_2 = ls_driveonwater
    L4_2 = false
    L2_2(L3_2, L4_2)
    L2_2 = menu
    L2_2 = L2_2.set_value
    L3_2 = ls_walkwater
    L4_2 = false
    L2_2(L3_2, L4_2)
  end
  ::lbl_33::
end
L11_1 = L11_1(L12_1, L13_1, L14_1, L15_1, L16_1)
L9_1[L10_1] = L11_1
L9_1 = _ENV
L10_1 = "menu"
L9_1 = L9_1[L10_1]
L9_1 = L9_1.toggle_loop
L10_1 = _ENV
L11_1 = "veh_movement"
L10_1 = L10_1[L11_1]
L11_1 = "水下驾驶"
L12_1 = {}
L13_1 = ""
function L14_1()
  local L0_2, L1_2
  L0_2 = menu
  L0_2 = L0_2.trigger_commands
  L1_2 = "waterwheels"
  L0_2(L1_2)
end
L9_1(L10_1, L11_1, L12_1, L13_1, L14_1)
L9_1 = _ENV
L10_1 = "menu"
L9_1 = L9_1[L10_1]
L9_1 = L9_1.toggle_loop
L10_1 = _ENV
L11_1 = "veh_movement"
L10_1 = L10_1[L11_1]
L11_1 = "载具平移"
L12_1 = {}
L13_1 = "使用左右箭头键使车辆水平移动"
function L14_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L1_2 = entities
  L1_2 = L1_2.get_user_vehicle_as_handle
  L1_2 = L1_2()
  if 0 ~= L1_2 then
    L2_2 = ENTITY
    L2_2 = L2_2.GET_ENTITY_ROTATION
    L3_2 = L1_2
    L4_2 = 0
    L2_2 = L2_2(L3_2, L4_2)
    L3_2 = PAD
    L3_2 = L3_2.IS_CONTROL_PRESSED
    L4_2 = 0
    L5_2 = 175
    L3_2 = L3_2(L4_2, L5_2)
    if L3_2 then
      L3_2 = ENTITY
      L3_2 = L3_2.APPLY_FORCE_TO_ENTITY
      L4_2 = L1_2
      L5_2 = 1
      L6_2 = 1.0
      L7_2 = 0.0
      L8_2 = 0.0
      L9_2 = 0.0
      L10_2 = 0.0
      L11_2 = 0.0
      L12_2 = 0
      L13_2 = true
      L14_2 = true
      L15_2 = true
      L16_2 = false
      L17_2 = true
      L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
      L3_2 = ENTITY
      L3_2 = L3_2.SET_ENTITY_ROTATION
      L4_2 = L1_2
      L5_2 = L2_2.x
      L6_2 = L2_2.y
      L7_2 = L2_2.z
      L8_2 = 0
      L9_2 = true
      L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    end
    L3_2 = PAD
    L3_2 = L3_2.IS_CONTROL_PRESSED
    L4_2 = 0
    L5_2 = 174
    L3_2 = L3_2(L4_2, L5_2)
    if L3_2 then
      L3_2 = ENTITY
      L3_2 = L3_2.APPLY_FORCE_TO_ENTITY
      L4_2 = L1_2
      L5_2 = 1
      L6_2 = -1.0
      L7_2 = 0.0
      L8_2 = 0.0
      L9_2 = 0.0
      L10_2 = 0.0
      L11_2 = 0.0
      L12_2 = 0
      L13_2 = true
      L14_2 = true
      L15_2 = true
      L16_2 = false
      L17_2 = true
      L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
      L3_2 = ENTITY
      L3_2 = L3_2.SET_ENTITY_ROTATION
      L4_2 = L1_2
      L5_2 = L2_2.x
      L6_2 = L2_2.y
      L7_2 = L2_2.z
      L8_2 = 0
      L9_2 = true
      L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    end
  end
end
L9_1(L10_1, L11_1, L12_1, L13_1, L14_1)
L9_1 = _ENV
L10_1 = "menu"
L9_1 = L9_1[L10_1]
L9_1 = L9_1.toggle_loop
L10_1 = _ENV
L11_1 = "veh_movement"
L10_1 = L10_1[L11_1]
L11_1 = "车辆下降"
L12_1 = {}
L13_1 = "按ctrl"
function L14_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L1_2 = entities
  L1_2 = L1_2.get_user_vehicle_as_handle
  L1_2 = L1_2()
  if 0 ~= L1_2 then
    L2_2 = PAD
    L2_2 = L2_2.IS_CONTROL_JUST_PRESSED
    L3_2 = 36
    L4_2 = 36
    L2_2 = L2_2(L3_2, L4_2)
    if L2_2 then
      L2_2 = ENTITY
      L2_2 = L2_2.APPLY_FORCE_TO_ENTITY
      L3_2 = L1_2
      L4_2 = 1
      L5_2 = 0.0
      L6_2 = 0.0
      L7_2 = -20
      L8_2 = 0.0
      L9_2 = 0.0
      L10_2 = 0.0
      L11_2 = 0
      L12_2 = true
      L13_2 = true
      L14_2 = true
      L15_2 = false
      L16_2 = true
      L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
    end
  end
end
L9_1(L10_1, L11_1, L12_1, L13_1, L14_1)
L9_1 = _ENV
L10_1 = "menu"
L9_1 = L9_1[L10_1]
L9_1 = L9_1.toggle_loop
L10_1 = _ENV
L11_1 = "veh_movement"
L10_1 = L10_1[L11_1]
L11_1 = "喇叭加速"
L12_1 = {}
L13_1 = ""
function L14_1()
  local L0_2, L1_2
  L0_2 = horn_boost
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2 = L1_2()
  L0_2(L1_2)
end
L9_1(L10_1, L11_1, L12_1, L13_1, L14_1)
L9_1 = _ENV
L10_1 = "menu"
L9_1 = L9_1[L10_1]
L9_1 = L9_1.toggle_loop
L10_1 = _ENV
L11_1 = "veh_movement"
L10_1 = L10_1[L11_1]
L11_1 = "喇叭跳跳车"
L12_1 = {}
L13_1 = ""
function L14_1()
  local L0_2, L1_2
  L0_2 = car_jump
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2 = L1_2()
  L0_2(L1_2)
end
L9_1(L10_1, L11_1, L12_1, L13_1, L14_1)
L9_1 = _ENV
L10_1 = "veh_performance"
L11_1 = _ENV
L12_1 = "menu"
L11_1 = L11_1[L12_1]
L12_1 = "list"
L11_1 = L11_1[L12_1]
L12_1 = _ENV
L13_1 = "vehicle"
L12_1 = L12_1[L13_1]
L13_1 = "外观和性能"
L14_1 = {}
L15_1 = ""
L11_1 = L11_1(L12_1, L13_1, L14_1, L15_1)
L9_1[L10_1] = L11_1
L9_1 = _ENV
L10_1 = "menu"
L9_1 = L9_1[L10_1]
L9_1 = L9_1.action
L10_1 = _ENV
L11_1 = "veh_performance"
L10_1 = L10_1[L11_1]
L11_1 = "满改载具"
L12_1 = {}
L13_1 = ""
function L14_1()
  local L0_2, L1_2, L2_2
  L0_2 = PED
  L0_2 = L0_2.GET_VEHICLE_PED_IS_IN
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = false
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = upgrade_vehicle
  L2_2 = L0_2
  L1_2(L2_2)
end
L9_1(L10_1, L11_1, L12_1, L13_1, L14_1)
L9_1 = _ENV
L10_1 = "menu"
L9_1 = L9_1[L10_1]
L9_1 = L9_1.action
L10_1 = _ENV
L11_1 = "veh_performance"
L10_1 = L10_1[L11_1]
L11_1 = "随机轮胎"
L12_1 = {}
L13_1 = ""
function L14_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L0_2 = PED
  L0_2 = L0_2.GET_VEHICLE_PED_IS_IN
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = false
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = VEHICLE
  L1_2 = L1_2.SET_VEHICLE_WHEEL_TYPE
  L2_2 = L0_2
  L3_2 = math
  L3_2 = L3_2.random
  L4_2 = 0
  L5_2 = 7
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2, L5_2)
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
  L1_2 = VEHICLE
  L1_2 = L1_2.SET_VEHICLE_MOD
  L2_2 = L0_2
  L3_2 = 23
  L4_2 = math
  L4_2 = L4_2.random
  L5_2 = -1
  L6_2 = 50
  L4_2, L5_2, L6_2 = L4_2(L5_2, L6_2)
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
end
L9_1(L10_1, L11_1, L12_1, L13_1, L14_1)
L9_1 = _ENV
L10_1 = "menu"
L9_1 = L9_1[L10_1]
L9_1 = L9_1.toggle_loop
L10_1 = _ENV
L11_1 = "veh_performance"
L10_1 = L10_1[L11_1]
L11_1 = "清洁载具"
L12_1 = {}
L13_1 = ""
function L14_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = PED
  L0_2 = L0_2.GET_VEHICLE_PED_IS_IN
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_ID
  L2_2, L3_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = false
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = request_control
  L2_2 = L0_2
  L1_2(L2_2)
  L1_2 = VEHICLE
  L1_2 = L1_2.SET_VEHICLE_DIRT_LEVEL
  L2_2 = L0_2
  L3_2 = 0
  L1_2(L2_2, L3_2)
  L1_2 = VEHICLE
  L1_2 = L1_2.SET_VEHICLE_ENVEFF_SCALE
  L2_2 = L0_2
  L3_2 = 0
  L1_2(L2_2, L3_2)
end
L9_1(L10_1, L11_1, L12_1, L13_1, L14_1)
L9_1 = _ENV
L10_1 = "menu"
L9_1 = L9_1[L10_1]
L9_1 = L9_1.toggle_loop
L10_1 = _ENV
L11_1 = "veh_performance"
L10_1 = L10_1[L11_1]
L11_1 = "自动充能"
L12_1 = {}
L13_1 = ""
function L14_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = PED
  L0_2 = L0_2.GET_VEHICLE_PED_IS_IN
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = false
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = VEHICLE
  L1_2 = L1_2.IS_ROCKET_BOOST_ACTIVE
  L2_2 = L0_2
  L1_2 = L1_2(L2_2)
  if not L1_2 then
    L1_2 = request_control
    L2_2 = L0_2
    L1_2(L2_2)
    L1_2 = VEHICLE
    L1_2 = L1_2.SET_ROCKET_BOOST_FILL
    L2_2 = L0_2
    L3_2 = 100.0
    L1_2(L2_2, L3_2)
  end
end
L9_1(L10_1, L11_1, L12_1, L13_1, L14_1)
L9_1 = _ENV
L10_1 = "menu"
L9_1 = L9_1[L10_1]
L9_1 = L9_1.toggle_loop
L10_1 = _ENV
L11_1 = "veh_performance"
L10_1 = L10_1[L11_1]
L11_1 = "指示灯"
L12_1 = {}
L13_1 = "载具的一些指示灯光"
function L14_1()
  local L0_2, L1_2
  L0_2 = pilot_lamp
  L0_2()
end
L9_1(L10_1, L11_1, L12_1, L13_1, L14_1)
L9_1 = _ENV
L10_1 = "menu"
L9_1 = L9_1[L10_1]
L9_1 = L9_1.toggle_loop
L10_1 = _ENV
L11_1 = "veh_performance"
L10_1 = L10_1[L11_1]
L11_1 = "3D环绕灯"
L12_1 = {}
L13_1 = "让霓虹灯绕着汽车转一圈"
function L14_1()
  local L0_2, L1_2
  L0_2 = veh_circle_light
  L0_2()
end
L9_1(L10_1, L11_1, L12_1, L13_1, L14_1)
L9_1 = _ENV
L10_1 = "carcolor"
L11_1 = _ENV
L12_1 = "menu"
L11_1 = L11_1[L12_1]
L12_1 = "list"
L11_1 = L11_1[L12_1]
L12_1 = _ENV
L13_1 = "veh_performance"
L12_1 = L12_1[L13_1]
L13_1 = "随机变色"
L14_1 = {}
L15_1 = ""
L11_1 = L11_1(L12_1, L13_1, L14_1, L15_1)
L9_1[L10_1] = L11_1
L9_1 = _ENV
L10_1 = "menu"
L9_1 = L9_1[L10_1]
L9_1 = L9_1.toggle_loop
L10_1 = _ENV
L11_1 = "carcolor"
L10_1 = L10_1[L11_1]
L11_1 = "载具颜色"
L12_1 = {}
L13_1 = "可使车辆变色"
function L14_1()
  local L0_2, L1_2
  L0_2 = zjbs
  L0_2()
end
L9_1(L10_1, L11_1, L12_1, L13_1, L14_1)
L9_1 = _ENV
L10_1 = "menu"
L9_1 = L9_1[L10_1]
L9_1 = L9_1.slider
L10_1 = _ENV
L11_1 = "carcolor"
L10_1 = L10_1[L11_1]
L11_1 = "变色速度"
L12_1 = {}
L13_1 = ""
L12_1[1] = L13_1
L13_1 = "改变变色速度"
L14_1 = 10
L15_1 = 200
L16_1 = 100
L17_1 = 10
function L18_1(A0_2)
  local L1_2, L2_2
  L1_2 = colorspeed
  L2_2 = A0_2
  L1_2(L2_2)
end
L9_1(L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1)
L9_1 = _ENV
L10_1 = "menu"
L9_1 = L9_1[L10_1]
L9_1 = L9_1.toggle_loop
L10_1 = _ENV
L11_1 = "carcolor"
L10_1 = L10_1[L11_1]
L11_1 = "前照灯"
L12_1 = {}
L13_1 = "改变前灯"
function L14_1()
  local L0_2, L1_2
  L0_2 = qzd
  L0_2()
end
L9_1(L10_1, L11_1, L12_1, L13_1, L14_1)
L9_1 = _ENV
L10_1 = "menu"
L9_1 = L9_1[L10_1]
L9_1 = L9_1.slider
L10_1 = _ENV
L11_1 = "carcolor"
L10_1 = L10_1[L11_1]
L11_1 = "前照灯速度"
L12_1 = {}
L13_1 = ""
L12_1[1] = L13_1
L13_1 = "前照灯速度"
L14_1 = 10
L15_1 = 200
L16_1 = 100
L17_1 = 10
function L18_1(A0_2)
  local L1_2, L2_2
  L1_2 = qzdcolorspeed
  L2_2 = A0_2
  L1_2(L2_2)
end
L9_1(L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1)
L9_1 = _ENV
L10_1 = "menu"
L9_1 = L9_1[L10_1]
L9_1 = L9_1.toggle_loop
L10_1 = _ENV
L11_1 = "veh_performance"
L10_1 = L10_1[L11_1]
L11_1 = "彩虹轮胎烟雾"
L12_1 = {}
L13_1 = ""
function L14_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = PED
  L0_2 = L0_2.GET_VEHICLE_PED_IS_IN
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = false
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = MISC
  L1_2 = L1_2.GET_GAME_TIMER
  L1_2 = L1_2()
  L2_2 = gradient_colour
  L3_2 = L1_2
  L4_2 = 2
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = VEHICLE
  L3_2 = L3_2.SET_VEHICLE_TYRE_SMOKE_COLOR
  L4_2 = L0_2
  L5_2 = L2_2.r
  L6_2 = L2_2.g
  L7_2 = L2_2.b
  L3_2(L4_2, L5_2, L6_2, L7_2)
end
L9_1(L10_1, L11_1, L12_1, L13_1, L14_1)
L9_1 = _ENV
L10_1 = "menu"
L9_1 = L9_1[L10_1]
L9_1 = L9_1.toggle_loop
L10_1 = _ENV
L11_1 = "veh_performance"
L10_1 = L10_1[L11_1]
L11_1 = "彩虹霓虹灯"
L12_1 = {}
L13_1 = ""
function L14_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L0_2 = PED
  L0_2 = L0_2.GET_VEHICLE_PED_IS_IN
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = false
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = MISC
  L1_2 = L1_2.GET_GAME_TIMER
  L1_2 = L1_2()
  L2_2 = gradient_colour
  L3_2 = L1_2
  L4_2 = 2
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = 0
  L4_2 = 3
  L5_2 = 1
  for L6_2 = L3_2, L4_2, L5_2 do
    L7_2 = VEHICLE
    L7_2 = L7_2.SET_VEHICLE_NEON_INDEX_COLOUR
    L8_2 = veh
    L9_2 = L6_2
    L7_2(L8_2, L9_2)
    L7_2 = VEHICLE
    L7_2 = L7_2.SET_VEHICLE_NEON_COLOUR
    L8_2 = L0_2
    L9_2 = L2_2.r
    L10_2 = L2_2.g
    L11_2 = L2_2.b
    L7_2(L8_2, L9_2, L10_2, L11_2)
  end
end
L9_1(L10_1, L11_1, L12_1, L13_1, L14_1)
L9_1 = _ENV
L10_1 = "menu"
L9_1 = L9_1[L10_1]
L9_1 = L9_1.toggle_loop
L10_1 = _ENV
L11_1 = "veh_performance"
L10_1 = L10_1[L11_1]
L11_1 = "彩虹载具"
L12_1 = {}
L13_1 = ""
function L14_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = PED
  L0_2 = L0_2.GET_VEHICLE_PED_IS_IN
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = false
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = MISC
  L1_2 = L1_2.GET_GAME_TIMER
  L1_2 = L1_2()
  L2_2 = gradient_colour
  L3_2 = L1_2
  L4_2 = 2
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = VEHICLE
  L3_2 = L3_2.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR
  L4_2 = L0_2
  L5_2 = L2_2.r
  L6_2 = L2_2.g
  L7_2 = L2_2.b
  L3_2(L4_2, L5_2, L6_2, L7_2)
  L3_2 = VEHICLE
  L3_2 = L3_2.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR
  L4_2 = L0_2
  L5_2 = L2_2.r
  L6_2 = L2_2.g
  L7_2 = L2_2.b
  L3_2(L4_2, L5_2, L6_2, L7_2)
end
L9_1(L10_1, L11_1, L12_1, L13_1, L14_1)
L9_1 = _ENV
L10_1 = "menu"
L9_1 = L9_1[L10_1]
L9_1 = L9_1.toggle
L10_1 = _ENV
L11_1 = "veh_performance"
L10_1 = L10_1[L11_1]
L11_1 = "烧焦外形"
L12_1 = {}
L13_1 = "使你的车烧焦"
function L14_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = entities
  L1_2 = L1_2.get_user_vehicle_as_handle
  L1_2 = L1_2()
  if 0 ~= L1_2 then
    L2_2 = ENTITY
    L2_2 = L2_2.SET_ENTITY_RENDER_SCORCHED
    L3_2 = L1_2
    L4_2 = A0_2
    L2_2(L3_2, L4_2)
  end
end
L9_1(L10_1, L11_1, L12_1, L13_1, L14_1)
L9_1 = _ENV
L10_1 = "menu"
L9_1 = L9_1[L10_1]
L9_1 = L9_1.slider
L10_1 = _ENV
L11_1 = "veh_performance"
L10_1 = L10_1[L11_1]
L11_1 = "设置污垢等级"
L12_1 = {}
L13_1 = ""
L14_1 = 0
L15_1 = 15
L16_1 = 0
L17_1 = 1
function L18_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = PED
  L1_2 = L1_2.GET_VEHICLE_PED_IS_IN
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = true
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = VEHICLE
  L2_2 = L2_2.SET_VEHICLE_DIRT_LEVEL
  L3_2 = L1_2
  L4_2 = A0_2
  L2_2(L3_2, L4_2)
end
L9_1(L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1)
L9_1 = _ENV
L10_1 = "menu"
L9_1 = L9_1[L10_1]
L9_1 = L9_1.slider
L10_1 = _ENV
L11_1 = "veh_performance"
L10_1 = L10_1[L11_1]
L11_1 = "载具透明度"
L12_1 = {}
L13_1 = ""
L14_1 = 0
L15_1 = 255
L16_1 = 255
L17_1 = 51
function L18_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = ENTITY
  L1_2 = L1_2.SET_ENTITY_ALPHA
  L2_2 = entities
  L2_2 = L2_2.get_user_vehicle_as_handle
  L2_2 = L2_2()
  L3_2 = A0_2
  L4_2 = false
  L1_2(L2_2, L3_2, L4_2)
end
L9_1(L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1)
L9_1 = _ENV
L10_1 = "set_self_license"
L11_1 = _ENV
L12_1 = "menu"
L11_1 = L11_1[L12_1]
L12_1 = "list"
L11_1 = L11_1[L12_1]
L12_1 = _ENV
L13_1 = "veh_performance"
L12_1 = L12_1[L13_1]
L13_1 = "自定义车牌"
L14_1 = {}
L15_1 = ""
L11_1 = L11_1(L12_1, L13_1, L14_1, L15_1)
L9_1[L10_1] = L11_1
L9_1 = "Sakura"
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L11_1 = "text_input"
L10_1 = L10_1[L11_1]
L11_1 = _ENV
L12_1 = "set_self_license"
L11_1 = L11_1[L12_1]
L12_1 = "自定义车牌"
L13_1 = {}
L14_1 = "setcarlicense"
L13_1[1] = L14_1
L14_1 = ""
function L15_1(A0_2)
  local L1_2
  L9_1 = A0_2
end
L16_1 = "Sakura"
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1, L16_1)
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.toggle_loop
L11_1 = _ENV
L12_1 = "set_self_license"
L11_1 = L11_1[L12_1]
L12_1 = "设置车牌"
L13_1 = {}
L14_1 = ""
function L15_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = PED
  L0_2 = L0_2.GET_VEHICLE_PED_IS_IN
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED_SCRIPT_INDEX
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_ID
  L2_2, L3_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = true
  L0_2 = L0_2(L1_2, L2_2)
  if 0 ~= L0_2 then
    L1_2 = request_control
    L2_2 = L0_2
    L1_2(L2_2)
    L1_2 = VEHICLE
    L1_2 = L1_2.SET_VEHICLE_NUMBER_PLATE_TEXT
    L2_2 = L0_2
    L3_2 = L9_1
    L1_2(L2_2, L3_2)
  end
end
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1)
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.toggle_loop
L11_1 = _ENV
L12_1 = "set_self_license"
L11_1 = L11_1[L12_1]
L12_1 = "渐变车牌"
L13_1 = {}
L14_1 = ""
function L15_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = {}
  L1_2 = "l"
  L2_2 = "lu"
  L3_2 = "luc"
  L4_2 = "luck"
  L5_2 = "lucky"
  L0_2[1] = L1_2
  L0_2[2] = L2_2
  L0_2[3] = L3_2
  L0_2[4] = L4_2
  L0_2[5] = L5_2
  L1_2 = 1
  L2_2 = #L0_2
  L3_2 = 1
  for L4_2 = L1_2, L2_2, L3_2 do
    L5_2 = PED
    L5_2 = L5_2.GET_VEHICLE_PED_IS_IN
    L6_2 = PLAYER
    L6_2 = L6_2.GET_PLAYER_PED_SCRIPT_INDEX
    L7_2 = PLAYER
    L7_2 = L7_2.PLAYER_ID
    L7_2, L8_2 = L7_2()
    L6_2 = L6_2(L7_2, L8_2)
    L7_2 = true
    L5_2 = L5_2(L6_2, L7_2)
    if 0 ~= L5_2 then
      L6_2 = request_control
      L7_2 = L5_2
      L6_2(L7_2)
      L6_2 = VEHICLE
      L6_2 = L6_2.SET_VEHICLE_NUMBER_PLATE_TEXT
      L7_2 = L5_2
      L8_2 = L0_2[L4_2]
      L6_2(L7_2, L8_2)
    end
    L6_2 = util
    L6_2 = L6_2.yield
    L7_2 = 100
    L6_2(L7_2)
  end
  L1_2 = util
  L1_2 = L1_2.yield
  L2_2 = 200
  L1_2(L2_2)
end
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1)
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.toggle_loop
L11_1 = _ENV
L12_1 = "set_self_license"
L11_1 = L11_1[L12_1]
L12_1 = "速度车牌"
L13_1 = {}
L14_1 = "显示速度"
function L15_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L0_2 = PED
  L0_2 = L0_2.GET_VEHICLE_PED_IS_IN
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED_SCRIPT_INDEX
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_ID
  L2_2, L3_2, L4_2, L5_2, L6_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
  L2_2 = true
  L0_2 = L0_2(L1_2, L2_2)
  if 0 ~= L0_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.GET_ENTITY_SPEED
    L2_2 = L0_2
    L1_2 = L1_2(L2_2)
    L1_2 = L1_2 * 3.6
    L2_2 = math
    L2_2 = L2_2.ceil
    L3_2 = L1_2
    L2_2 = L2_2(L3_2)
    L3_2 = VEHICLE
    L3_2 = L3_2.SET_VEHICLE_NUMBER_PLATE_TEXT
    L4_2 = L0_2
    L5_2 = L2_2
    L6_2 = " kmh"
    L5_2 = L5_2 .. L6_2
    L3_2(L4_2, L5_2)
  end
end
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1)
L10_1 = _ENV
L11_1 = "veh_UI"
L12_1 = _ENV
L13_1 = "menu"
L12_1 = L12_1[L13_1]
L13_1 = "list"
L12_1 = L12_1[L13_1]
L13_1 = _ENV
L14_1 = "vehicle"
L13_1 = L13_1[L14_1]
L14_1 = "载具UI"
L15_1 = {}
L16_1 = ""
L12_1 = L12_1(L13_1, L14_1, L15_1, L16_1)
L10_1[L11_1] = L12_1
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.toggle
L11_1 = _ENV
L12_1 = "veh_UI"
L11_1 = L11_1[L12_1]
L12_1 = "绘制时速"
L13_1 = {}
L14_1 = ""
function L15_1(A0_2)
  local L1_2, L2_2
  L1_2 = vehicle_speedometer
  L2_2 = A0_2
  L1_2(L2_2)
end
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1)
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.toggle_loop
L11_1 = _ENV
L12_1 = "veh_UI"
L11_1 = L11_1[L12_1]
L12_1 = "AR导航"
L13_1 = {}
L14_1 = ""
function L15_1()
  local L0_2, L1_2
  L0_2 = AR_navigation
  L0_2()
end
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1)
L10_1 = _ENV
L11_1 = "speedometer_car"
L12_1 = _ENV
L13_1 = "menu"
L12_1 = L12_1[L13_1]
L13_1 = "list"
L12_1 = L12_1[L13_1]
L13_1 = _ENV
L14_1 = "veh_UI"
L13_1 = L13_1[L14_1]
L14_1 = "速度表"
L15_1 = {}
L16_1 = ""
L12_1 = L12_1(L13_1, L14_1, L15_1, L16_1)
L10_1[L11_1] = L12_1
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.toggle_loop
L11_1 = _ENV
L12_1 = "speedometer_car"
L11_1 = L11_1[L12_1]
L12_1 = "开启"
L13_1 = {}
L14_1 = ""
function L15_1()
  local L0_2, L1_2
  L0_2 = speedometer
  L0_2()
end
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1)
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L11_1 = "divider"
L10_1 = L10_1[L11_1]
L11_1 = _ENV
L12_1 = "speedometer_car"
L11_1 = L11_1[L12_1]
L12_1 = "位置"
L10_1(L11_1, L12_1)
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.slider
L11_1 = _ENV
L12_1 = "speedometer_car"
L11_1 = L11_1[L12_1]
L12_1 = "位置X"
L13_1 = {}
L14_1 = "spX"
L13_1[1] = L14_1
L14_1 = ""
L15_1 = 1
L16_1 = 100
L17_1 = 84
L18_1 = 1
function L19_1(A0_2)
  local L1_2, L2_2
  L1_2 = speedometer_X
  L2_2 = A0_2
  L1_2(L2_2)
end
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1)
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.slider
L11_1 = _ENV
L12_1 = "speedometer_car"
L11_1 = L11_1[L12_1]
L12_1 = "位置Y"
L13_1 = {}
L14_1 = "spY"
L13_1[1] = L14_1
L14_1 = ""
L15_1 = 1
L16_1 = 100
L17_1 = 75
L18_1 = 1
function L19_1(A0_2)
  local L1_2, L2_2
  L1_2 = speedometer_Y
  L2_2 = A0_2
  L1_2(L2_2)
end
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1)
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.toggle_loop
L11_1 = _ENV
L12_1 = "veh_UI"
L11_1 = L11_1[L12_1]
L12_1 = "载具识别"
L13_1 = {}
L14_1 = ""
function L15_1(A0_2)
  local L1_2
  L1_2 = Vehicle_identify
  L1_2()
end
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1)
L10_1 = _ENV
L11_1 = "planehud"
L12_1 = _ENV
L13_1 = "menu"
L12_1 = L12_1[L13_1]
L13_1 = "list"
L12_1 = L12_1[L13_1]
L13_1 = _ENV
L14_1 = "veh_UI"
L13_1 = L13_1[L14_1]
L14_1 = "飞机HUD"
L15_1 = {}
L12_1 = L12_1(L13_1, L14_1, L15_1)
L10_1[L11_1] = L12_1
L10_1 = require
L11_1 = "lib.daidailib.flightredux"
L10_1(L11_1)
L10_1 = _ENV
L11_1 = "getentityinfo"
L10_1 = L10_1[L11_1]
L10_1()
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.toggle_loop
L11_1 = _ENV
L12_1 = "veh_UI"
L11_1 = L11_1[L12_1]
L12_1 = "显示车辆角度"
L13_1 = {}
L14_1 = ""
function L15_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = entities
  L0_2 = L0_2.get_user_vehicle_as_handle
  L0_2 = L0_2()
  if 0 ~= L0_2 then
    L1_2 = PED
    L1_2 = L1_2.IS_PED_IN_ANY_VEHICLE
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = true
    L1_2 = L1_2(L2_2, L3_2)
    if L1_2 then
      L1_2 = math
      L1_2 = L1_2.abs
      L2_2 = math
      L2_2 = L2_2.ceil
      L3_2 = math
      L3_2 = L3_2.abs
      L4_2 = ENTITY
      L4_2 = L4_2.GET_ENTITY_ROTATION
      L5_2 = L0_2
      L6_2 = 0
      L4_2 = L4_2(L5_2, L6_2)
      L4_2 = L4_2.z
      L5_2 = 0
      L3_2 = L3_2(L4_2, L5_2)
      L4_2 = math
      L4_2 = L4_2.abs
      L5_2 = CAM
      L5_2 = L5_2.GET_GAMEPLAY_CAM_ROT
      L6_2 = 0
      L5_2 = L5_2(L6_2)
      L5_2 = L5_2.z
      L4_2 = L4_2(L5_2)
      L3_2 = L3_2 - L4_2
      L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L2_2(L3_2)
      L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
      L2_2 = directx
      L2_2 = L2_2.draw_text
      L3_2 = 0.5
      L4_2 = 1.0
      L5_2 = tostring
      L6_2 = L1_2
      L5_2 = L5_2(L6_2)
      L6_2 = "°"
      L5_2 = L5_2 .. L6_2
      L6_2 = 5
      L7_2 = 1.4
      L8_2 = {}
      L8_2.r = 1
      L8_2.g = 1
      L8_2.b = 1
      L8_2.a = 1
      L9_2 = true
      L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    end
  end
end
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1)
L10_1 = _ENV
L11_1 = "workshop"
L12_1 = _ENV
L13_1 = "menu"
L12_1 = L12_1[L13_1]
L13_1 = "list"
L12_1 = L12_1[L13_1]
L13_1 = _ENV
L14_1 = "vehicle"
L13_1 = L13_1[L14_1]
L14_1 = "洛圣都改车王"
L15_1 = {}
L16_1 = ""
L12_1 = L12_1(L13_1, L14_1, L15_1, L16_1)
L10_1[L11_1] = L12_1
L10_1 = require
L11_1 = "lib.daidailib.Repairshop"
L10_1(L11_1)
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.toggle
L11_1 = _ENV
L12_1 = "vehicle"
L11_1 = L11_1[L12_1]
L12_1 = "自动锁门"
L13_1 = {}
L14_1 = "当你进入载具后自动上锁,下车不受影响"
function L15_1(A0_2)
  local L1_2, L2_2
  L1_2 = auto_locked
  L2_2 = A0_2
  L1_2(L2_2)
end
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1)
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.toggle
L11_1 = _ENV
L12_1 = "vehicle"
L11_1 = L11_1[L12_1]
L12_1 = "禁用驾驶"
L13_1 = {}
L14_1 = ""
function L15_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = PED
  L1_2 = L1_2.GET_VEHICLE_PED_IS_IN
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = false
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = VEHICLE
  L2_2 = L2_2.SET_VEHICLE_UNDRIVEABLE
  L3_2 = L1_2
  L4_2 = A0_2
  L2_2(L3_2, L4_2)
end
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1)
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.toggle
L11_1 = _ENV
L12_1 = "vehicle"
L11_1 = L11_1[L12_1]
L12_1 = "战损载具"
L13_1 = {}
L14_1 = "能够被明显损坏"
function L15_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = PED
  L1_2 = L1_2.GET_VEHICLE_PED_IS_IN
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = false
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = VEHICLE
  L2_2 = L2_2.SET_VEHICLE_CAN_BE_VISIBLY_DAMAGED
  L3_2 = L1_2
  L4_2 = A0_2
  L2_2(L3_2, L4_2)
end
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1)
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.toggle
L11_1 = _ENV
L12_1 = "vehicle"
L11_1 = L11_1[L12_1]
L12_1 = "载具内不可被射击"
L13_1 = {}
L14_1 = "防止在载具内被击杀或恶搞"
function L15_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = PED
  L1_2 = L1_2.SET_PED_CAN_BE_SHOT_IN_VEHICLE
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = not A0_2
  L1_2(L2_2, L3_2)
end
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1)
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.action
L11_1 = _ENV
L12_1 = "vehicle"
L11_1 = L11_1[L12_1]
L12_1 = "颠倒载具"
L13_1 = {}
L14_1 = ""
function L15_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = PED
  L0_2 = L0_2.GET_VEHICLE_PED_IS_IN
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = false
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_ROTATION
  L2_2 = L0_2
  L3_2 = 2
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = ENTITY
  L2_2 = L2_2.SET_ENTITY_ROTATION
  L3_2 = L0_2
  L4_2 = L1_2.x
  L5_2 = L1_2.y
  L5_2 = L5_2 + 180
  L6_2 = L1_2.z
  L7_2 = 2
  L8_2 = true
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
end
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1)
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.list_action
L11_1 = _ENV
L12_1 = "vehicle"
L11_1 = L11_1[L12_1]
L12_1 = "广播电台"
L13_1 = {}
L14_1 = ""
L15_1 = _ENV
L16_1 = "radio_name"
L15_1 = L15_1[L16_1]
function L16_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = PED
  L1_2 = L1_2.GET_VEHICLE_PED_IS_IN
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = false
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = AUDIO
  L2_2 = L2_2.SET_VEH_RADIO_STATION
  L3_2 = L1_2
  L4_2 = station_name
  L4_2 = L4_2[A0_2]
  L2_2(L3_2, L4_2)
end
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1, L16_1)
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.toggle_loop
L11_1 = _ENV
L12_1 = "vehicle"
L11_1 = L11_1[L12_1]
L12_1 = "禁用载具碰撞"
L13_1 = {}
L14_1 = "禁止与其他载具发生碰撞"
function L15_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L0_2 = PED
  L0_2 = L0_2.GET_VEHICLE_PED_IS_IN
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = false
  L0_2 = L0_2(L1_2, L2_2)
  if 0 ~= L0_2 then
    L1_2 = pairs
    L2_2 = entities
    L2_2 = L2_2.get_all_vehicles_as_handles
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L2_2()
    L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
    for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
      L7_2 = ENTITY
      L7_2 = L7_2.SET_ENTITY_NO_COLLISION_ENTITY
      L8_2 = L6_2
      L9_2 = L0_2
      L10_2 = true
      L7_2(L8_2, L9_2, L10_2)
    end
  end
end
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1)
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.list_action
L11_1 = _ENV
L12_1 = "vehicle"
L11_1 = L11_1[L12_1]
L12_1 = "附加国旗"
L13_1 = {}
L14_1 = ""
L15_1 = _ENV
L16_1 = "country_flags_name"
L15_1 = L15_1[L16_1]
function L16_1(A0_2)
  local L1_2, L2_2
  L1_2 = attach_flag
  L2_2 = A0_2
  L1_2(L2_2)
end
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1, L16_1)
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.textslider
L11_1 = _ENV
L12_1 = "vehicle"
L11_1 = L11_1[L12_1]
L12_1 = "载具降落伞"
L13_1 = {}
L14_1 = ""
L15_1 = _ENV
L16_1 = "Vparachute_name"
L15_1 = L15_1[L16_1]
function L16_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = PED
  L1_2 = L1_2.GET_VEHICLE_PED_IS_IN
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_ID
  L3_2, L4_2, L5_2 = L3_2()
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = false
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = Vparachute_list
  L3_2 = L3_2[A0_2]
  L2_2 = L2_2(L3_2)
  L3_2 = request_model
  L4_2 = L2_2
  L3_2(L4_2)
  L3_2 = VEHICLE
  L3_2 = L3_2.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE
  L4_2 = L1_2
  L5_2 = L2_2
  L3_2(L4_2, L5_2)
end
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1, L16_1)
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.toggle
L11_1 = _ENV
L12_1 = "vehicle"
L11_1 = L11_1[L12_1]
L12_1 = "防止载具被锁定"
L13_1 = {}
L14_1 = ""
function L15_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = PED
  L1_2 = L1_2.GET_VEHICLE_PED_IS_IN
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_ID
  L3_2, L4_2, L5_2 = L3_2()
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = false
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = VEHICLE1
  L2_2 = L2_2._SET_VEHICLE_CAN_BE_LOCKED_ON
  L3_2 = L1_2
  L4_2 = not A0_2
  L5_2 = false
  L2_2(L3_2, L4_2, L5_2)
end
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1)
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.toggle_loop
L11_1 = _ENV
L12_1 = "vehicle"
L11_1 = L11_1[L12_1]
L12_1 = "漂移模式"
L13_1 = {}
L14_1 = "按住shift键进行漂移"
function L15_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = PED
  L0_2 = L0_2.GET_VEHICLE_PED_IS_IN
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_ID
  L2_2, L3_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = false
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = PAD
  L1_2 = L1_2.IS_CONTROL_PRESSED
  L2_2 = 0
  L3_2 = 21
  L1_2 = L1_2(L2_2, L3_2)
  if L1_2 then
    L1_2 = VEHICLE
    L1_2 = L1_2.SET_VEHICLE_REDUCE_GRIP
    L2_2 = L0_2
    L3_2 = true
    L1_2(L2_2, L3_2)
    L1_2 = VEHICLE
    L1_2 = L1_2.SET_VEHICLE_REDUCE_GRIP_LEVEL
    L2_2 = L0_2
    L3_2 = 0.0
    L1_2(L2_2, L3_2)
  else
    L1_2 = VEHICLE
    L1_2 = L1_2.SET_VEHICLE_REDUCE_GRIP
    L2_2 = L0_2
    L3_2 = false
    L1_2(L2_2, L3_2)
  end
end
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1)
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.toggle_loop
L11_1 = _ENV
L12_1 = "vehicle"
L11_1 = L11_1[L12_1]
L12_1 = "载具快速射击"
L13_1 = {}
L14_1 = ""
function L15_1()
  local L0_2, L1_2, L2_2
  L0_2 = PED
  L0_2 = L0_2.GET_VEHICLE_PED_IS_IN
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_ID
  L2_2 = L2_2()
  L1_2 = L1_2(L2_2)
  L2_2 = false
  L0_2 = L0_2(L1_2, L2_2)
  if nil ~= L0_2 then
    L1_2 = request_control
    L2_2 = L0_2
    L1_2(L2_2)
  end
  L1_2 = VEHICLE
  L1_2 = L1_2.SET_VEHICLE_FIXED
  L2_2 = L0_2
  L1_2(L2_2)
  L1_2 = VEHICLE
  L1_2 = L1_2.SET_VEHICLE_DEFORMATION_FIXED
  L2_2 = L0_2
  L1_2(L2_2)
end
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1)
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.toggle_loop
L11_1 = _ENV
L12_1 = "vehicle"
L11_1 = L11_1[L12_1]
L12_1 = "喇叭爆炸"
L13_1 = {}
L14_1 = ""
function L15_1()
  local L0_2, L1_2
  L0_2 = horn_bomb
  L0_2()
end
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1)
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.toggle_loop
L11_1 = _ENV
L12_1 = "vehicle"
L11_1 = L11_1[L12_1]
L12_1 = "载具自动无敌"
L13_1 = {}
L14_1 = "自动设置驾驶载具无敌,下车关闭无敌"
function L15_1()
  local L0_2, L1_2, L2_2, L3_2
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
    L1_2 = L1_2.GET_PLAYER_PED
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_ID
    L2_2, L3_2 = L2_2()
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = false
    L0_2 = L0_2(L1_2, L2_2)
    L1_2 = ENTITY
    L1_2 = L1_2.SET_ENTITY_INVINCIBLE
    L2_2 = L0_2
    L3_2 = true
    L1_2(L2_2, L3_2)
  else
    L0_2 = PLAYER
    L0_2 = L0_2.GET_PLAYERS_LAST_VEHICLE
    L0_2 = L0_2()
    L1_2 = ENTITY
    L1_2 = L1_2.SET_ENTITY_INVINCIBLE
    L2_2 = L0_2
    L3_2 = false
    L1_2(L2_2, L3_2)
  end
end
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1)
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.toggle_loop
L11_1 = _ENV
L12_1 = "vehicle"
L11_1 = L11_1[L12_1]
L12_1 = "下车不熄火"
L13_1 = {}
L14_1 = ""
function L15_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
  L0_2 = PLAYER
  L0_2 = L0_2.GET_PLAYERS_LAST_VEHICLE
  L0_2 = L0_2()
  L1_2 = VEHICLE
  L1_2 = L1_2.SET_VEHICLE_ENGINE_ON
  L2_2 = L0_2
  L3_2 = true
  L4_2 = true
  L5_2 = false
  L1_2(L2_2, L3_2, L4_2, L5_2)
end
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1)
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.toggle_loop
L11_1 = _ENV
L12_1 = "vehicle"
L11_1 = L11_1[L12_1]
L12_1 = "禁用载具喇叭"
L13_1 = {}
L14_1 = ""
function L15_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = entities
  L0_2 = L0_2.get_user_vehicle_as_handle
  L0_2 = L0_2()
  L1_2 = AUDIO
  L1_2 = L1_2.SET_HORN_ENABLED
  L2_2 = L0_2
  L3_2 = false
  L1_2(L2_2, L3_2)
end
function L16_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = entities
  L0_2 = L0_2.get_user_vehicle_as_handle
  L0_2 = L0_2()
  L1_2 = AUDIO
  L1_2 = L1_2.SET_HORN_ENABLED
  L2_2 = L0_2
  L3_2 = true
  L1_2(L2_2, L3_2)
end
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1, L16_1)
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.toggle
L11_1 = _ENV
L12_1 = "vehicle"
L11_1 = L11_1[L12_1]
L12_1 = "减少翘头"
L13_1 = {}
L14_1 = "使载具不容易翘头,主要针对于肌肉车的翘头减速"
function L15_1(A0_2)
  local L1_2, L2_2
  L1_2 = PHYSICS
  L1_2 = L1_2.SET_IN_ARENA_MODE
  L2_2 = A0_2
  L1_2(L2_2)
end
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1)
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.toggle_loop
L11_1 = _ENV
L12_1 = "vehicle"
L11_1 = L11_1[L12_1]
L12_1 = "载具引擎快速开启"
L13_1 = {}
L14_1 = "减少载具启动引擎时间"
function L15_1()
  local L0_2, L1_2
  L0_2 = fastoncar
  L0_2()
end
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1)
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.toggle_loop
L11_1 = _ENV
L12_1 = "vehicle"
L11_1 = L11_1[L12_1]
L12_1 = "解锁正在进入的载具"
L13_1 = {}
L14_1 = "解锁你正在进入的载具。对于锁住的玩家载具也有效果。"
function L15_1()
  local L0_2, L1_2
  L0_2 = unlockcar
  L0_2()
end
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1)
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.action
L11_1 = _ENV
L12_1 = "vehicle"
L11_1 = L11_1[L12_1]
L12_1 = "复制载具"
L13_1 = {}
L14_1 = "复制当前载具并驾驶"
function L15_1()
  local L0_2, L1_2
  L0_2 = copy_vehicle
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2 = L1_2()
  L0_2(L1_2)
end
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1)
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.toggle_loop
L11_1 = _ENV
L12_1 = "vehicle"
L11_1 = L11_1[L12_1]
L12_1 = "自动翻转"
L13_1 = {}
L14_1 = "如果你的车辆颠倒或侧面将自动翻转回正"
function L15_1()
  local L0_2, L1_2
  L0_2 = vehicle_automatically
  L0_2()
end
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1)
L10_1 = _ENV
L11_1 = "vehicleWeaponRoot"
L12_1 = _ENV
L13_1 = "menu"
L12_1 = L12_1[L13_1]
L13_1 = "list"
L12_1 = L12_1[L13_1]
L13_1 = _ENV
L14_1 = "vehicle"
L13_1 = L13_1[L14_1]
L14_1 = "载具武器"
L15_1 = {}
L16_1 = ""
L12_1 = L12_1(L13_1, L14_1, L15_1, L16_1)
L10_1[L11_1] = L12_1
L10_1 = _ENV
L11_1 = "vehicleWeaponmissile"
L12_1 = _ENV
L13_1 = "menu"
L12_1 = L12_1[L13_1]
L13_1 = "list"
L12_1 = L12_1[L13_1]
L13_1 = _ENV
L14_1 = "vehicleWeaponRoot"
L13_1 = L13_1[L14_1]
L14_1 = "载具导弹"
L15_1 = {}
L16_1 = ""
L12_1 = L12_1(L13_1, L14_1, L15_1, L16_1)
L10_1[L11_1] = L12_1
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.toggle_loop
L11_1 = _ENV
L12_1 = "vehicleWeaponmissile"
L11_1 = L11_1[L12_1]
L12_1 = "载具导弹"
L13_1 = {}
L14_1 = ""
function L15_1()
  local L0_2, L1_2
  L0_2 = vehweapon_veh
  L0_2()
end
function L16_1()
  local L0_2, L1_2
  Vw_state = 0
end
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1, L16_1)
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.toggle_loop
L11_1 = _ENV
L12_1 = "vehicleWeaponmissile"
L11_1 = L11_1[L12_1]
L12_1 = "载具激光"
L13_1 = {}
L14_1 = ""
function L15_1()
  local L0_2, L1_2
  L0_2 = vehlaser
  L0_2()
end
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1)
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L11_1 = "list_select"
L10_1 = L10_1[L11_1]
L11_1 = _ENV
L12_1 = "vehicleWeaponmissile"
L11_1 = L11_1[L12_1]
L12_1 = "设置载具武器"
L13_1 = {}
L14_1 = ""
L15_1 = {}
L16_1 = {}
L17_1 = _ENV
L18_1 = "util"
L17_1 = L17_1[L18_1]
L18_1 = "get_label_text"
L17_1 = L17_1[L18_1]
L18_1 = "WT_V_SPACERKT"
L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1 = L17_1(L18_1)
L16_1[1] = L17_1
L16_1[2] = L18_1
L16_1[3] = L19_1
L16_1[4] = L20_1
L16_1[5] = L21_1
L16_1[6] = L22_1
L16_1[7] = L23_1
L16_1[8] = L24_1
L16_1[9] = L25_1
L16_1[10] = L26_1
L16_1[11] = L27_1
L16_1[12] = L28_1
L16_1[13] = L29_1
L16_1[14] = L30_1
L16_1[15] = L31_1
L16_1[16] = L32_1
L16_1[17] = L33_1
L16_1[18] = L34_1
L16_1[19] = L35_1
L16_1[20] = L36_1
L16_1[21] = L37_1
L16_1[22] = L38_1
L16_1[23] = L39_1
L16_1[24] = L40_1
L16_1[25] = L41_1
L16_1[26] = L42_1
L16_1[27] = L43_1
L16_1[28] = L44_1
L16_1[29] = L45_1
L16_1[30] = L46_1
L16_1[31] = L47_1
L16_1[32] = L48_1
L17_1 = {}
L18_1 = _ENV
L19_1 = "util"
L18_1 = L18_1[L19_1]
L19_1 = "get_label_text"
L18_1 = L18_1[L19_1]
L19_1 = "WT_RAYPISTOL"
L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1 = L18_1(L19_1)
L17_1[1] = L18_1
L17_1[2] = L19_1
L17_1[3] = L20_1
L17_1[4] = L21_1
L17_1[5] = L22_1
L17_1[6] = L23_1
L17_1[7] = L24_1
L17_1[8] = L25_1
L17_1[9] = L26_1
L17_1[10] = L27_1
L17_1[11] = L28_1
L17_1[12] = L29_1
L17_1[13] = L30_1
L17_1[14] = L31_1
L17_1[15] = L32_1
L17_1[16] = L33_1
L17_1[17] = L34_1
L17_1[18] = L35_1
L17_1[19] = L36_1
L17_1[20] = L37_1
L17_1[21] = L38_1
L17_1[22] = L39_1
L17_1[23] = L40_1
L17_1[24] = L41_1
L17_1[25] = L42_1
L17_1[26] = L43_1
L17_1[27] = L44_1
L17_1[28] = L45_1
L17_1[29] = L46_1
L17_1[30] = L47_1
L17_1[31] = L48_1
L18_1 = {}
L19_1 = _ENV
L20_1 = "util"
L19_1 = L19_1[L20_1]
L20_1 = "get_label_text"
L19_1 = L19_1[L20_1]
L20_1 = "WT_FWRKLNCHR"
L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1 = L19_1(L20_1)
L18_1[1] = L19_1
L18_1[2] = L20_1
L18_1[3] = L21_1
L18_1[4] = L22_1
L18_1[5] = L23_1
L18_1[6] = L24_1
L18_1[7] = L25_1
L18_1[8] = L26_1
L18_1[9] = L27_1
L18_1[10] = L28_1
L18_1[11] = L29_1
L18_1[12] = L30_1
L18_1[13] = L31_1
L18_1[14] = L32_1
L18_1[15] = L33_1
L18_1[16] = L34_1
L18_1[17] = L35_1
L18_1[18] = L36_1
L18_1[19] = L37_1
L18_1[20] = L38_1
L18_1[21] = L39_1
L18_1[22] = L40_1
L18_1[23] = L41_1
L18_1[24] = L42_1
L18_1[25] = L43_1
L18_1[26] = L44_1
L18_1[27] = L45_1
L18_1[28] = L46_1
L18_1[29] = L47_1
L18_1[30] = L48_1
L19_1 = {}
L20_1 = _ENV
L21_1 = "util"
L20_1 = L20_1[L21_1]
L21_1 = "get_label_text"
L20_1 = L20_1[L21_1]
L21_1 = "WT_V_TANK"
L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1 = L20_1(L21_1)
L19_1[1] = L20_1
L19_1[2] = L21_1
L19_1[3] = L22_1
L19_1[4] = L23_1
L19_1[5] = L24_1
L19_1[6] = L25_1
L19_1[7] = L26_1
L19_1[8] = L27_1
L19_1[9] = L28_1
L19_1[10] = L29_1
L19_1[11] = L30_1
L19_1[12] = L31_1
L19_1[13] = L32_1
L19_1[14] = L33_1
L19_1[15] = L34_1
L19_1[16] = L35_1
L19_1[17] = L36_1
L19_1[18] = L37_1
L19_1[19] = L38_1
L19_1[20] = L39_1
L19_1[21] = L40_1
L19_1[22] = L41_1
L19_1[23] = L42_1
L19_1[24] = L43_1
L19_1[25] = L44_1
L19_1[26] = L45_1
L19_1[27] = L46_1
L19_1[28] = L47_1
L19_1[29] = L48_1
L20_1 = {}
L21_1 = _ENV
L22_1 = "util"
L21_1 = L21_1[L22_1]
L22_1 = "get_label_text"
L21_1 = L21_1[L22_1]
L22_1 = "WT_V_PLRBUL"
L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1 = L21_1(L22_1)
L20_1[1] = L21_1
L20_1[2] = L22_1
L20_1[3] = L23_1
L20_1[4] = L24_1
L20_1[5] = L25_1
L20_1[6] = L26_1
L20_1[7] = L27_1
L20_1[8] = L28_1
L20_1[9] = L29_1
L20_1[10] = L30_1
L20_1[11] = L31_1
L20_1[12] = L32_1
L20_1[13] = L33_1
L20_1[14] = L34_1
L20_1[15] = L35_1
L20_1[16] = L36_1
L20_1[17] = L37_1
L20_1[18] = L38_1
L20_1[19] = L39_1
L20_1[20] = L40_1
L20_1[21] = L41_1
L20_1[22] = L42_1
L20_1[23] = L43_1
L20_1[24] = L44_1
L20_1[25] = L45_1
L20_1[26] = L46_1
L20_1[27] = L47_1
L20_1[28] = L48_1
L15_1[1] = L16_1
L15_1[2] = L17_1
L15_1[3] = L18_1
L15_1[4] = L19_1
L15_1[5] = L20_1
L16_1 = 1
function L17_1(A0_2)
  local L1_2, L2_2
  L1_2 = setvehweapon
  L2_2 = A0_2
  L1_2(L2_2)
end
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1)
L10_1 = _ENV
L11_1 = "vehicleWeaponsControl"
L12_1 = _ENV
L13_1 = "menu"
L12_1 = L12_1[L13_1]
L13_1 = "list"
L12_1 = L12_1[L13_1]
L13_1 = _ENV
L14_1 = "vehicleWeaponmissile"
L13_1 = L13_1[L14_1]
L14_1 = "更改按键"
L15_1 = {}
L16_1 = ""
L12_1 = L12_1(L13_1, L14_1, L15_1, L16_1)
L10_1[L11_1] = L12_1
L10_1 = _ENV
L11_1 = "pairs"
L10_1 = L10_1[L11_1]
L11_1 = _ENV
L12_1 = "Imputs_vehweapon"
L11_1 = L11_1[L12_1]
L10_1, L11_1, L12_1, L13_1 = L10_1(L11_1)
for L14_1, L15_1 in L10_1, L11_1, L12_1, L13_1 do
  L16_1 = L15_1[1]
  L18_1 = "match"
  L17_1 = L16_1
  L16_1 = L16_1[L18_1]
  L18_1 = "^(.+)%s?;%s?(.+)$"
  L16_1, L17_1 = L16_1(L17_1, L18_1)
  L18_1 = "%s: %s, %s: %s"
  L20_1 = "format"
  L19_1 = L18_1
  L18_1 = L18_1[L20_1]
  L20_1 = _ENV
  L21_1 = "trans_plane"
  L20_1 = L20_1[L21_1]
  L21_1 = "Keyboard"
  L20_1 = L20_1[L21_1]
  L21_1 = L16_1
  L22_1 = _ENV
  L23_1 = "trans_plane"
  L22_1 = L22_1[L23_1]
  L23_1 = "Controller"
  L22_1 = L22_1[L23_1]
  L23_1 = L17_1
  L18_1 = L18_1(L19_1, L20_1, L21_1, L22_1, L23_1)
  L19_1 = _ENV
  L20_1 = "menu"
  L19_1 = L19_1[L20_1]
  L19_1 = L19_1.action
  L20_1 = _ENV
  L21_1 = "vehicleWeaponsControl"
  L20_1 = L20_1[L21_1]
  L21_1 = L18_1
  L22_1 = {}
  L23_1 = ""
  function L24_1()
    local L0_2, L1_2, L2_2, L3_2
    L0_2 = Config
    L0_2 = L0_2.controls
    L1_2 = L15_1
    L1_2 = L1_2[2]
    L0_2.vehicleweapons = L1_2
    L0_2 = util
    L0_2 = L0_2.show_corner_help
    L1_2 = trans_plane
    L1_2 = L1_2.VehicleWeapons
    L2_2 = L1_2
    L1_2 = L1_2.format
    L3_2 = L14_1
    L1_2, L2_2, L3_2 = L1_2(L2_2, L3_2)
    L0_2(L1_2, L2_2, L3_2)
  end
  L19_1(L20_1, L21_1, L22_1, L23_1, L24_1)
end
L10_1 = _ENV
L11_1 = "list_homingMissiles"
L12_1 = _ENV
L13_1 = "menu"
L12_1 = L12_1[L13_1]
L13_1 = "list"
L12_1 = L12_1[L13_1]
L13_1 = _ENV
L14_1 = "vehicleWeaponRoot"
L13_1 = L13_1[L14_1]
L14_1 = "先进追踪导弹"
L15_1 = {}
L16_1 = "允许您在任何载具上使用追踪导弹,并一次射出最多六个目标 .."
L12_1 = L12_1(L13_1, L14_1, L15_1, L16_1)
L10_1[L11_1] = L12_1
L10_1 = _ENV
L11_1 = "mistoggle"
L12_1 = _ENV
L13_1 = "menu"
L12_1 = L12_1[L13_1]
L12_1 = L12_1.toggle_loop
L13_1 = _ENV
L14_1 = "list_homingMissiles"
L13_1 = L13_1[L14_1]
L14_1 = "先进追踪导弹"
L15_1 = {}
L16_1 = ""
function L17_1()
  local L0_2, L1_2, L2_2
  L0_2 = L0_1.exists
  L0_2 = L0_2()
  if not L0_2 then
    L0_2 = L1_1.exists
    L0_2 = L0_2()
    if not L0_2 then
      L0_2 = L2_1.mainLoop
      L0_2()
  end
  else
    L0_2 = menu
    L0_2 = L0_2.set_value
    L1_2 = mistoggle
    L2_2 = false
    L0_2(L1_2, L2_2)
  end
end
L12_1 = L12_1(L13_1, L14_1, L15_1, L16_1, L17_1)
L10_1[L11_1] = L12_1
L10_1 = _ENV
L11_1 = "whiteList"
L12_1 = _ENV
L13_1 = "menu"
L12_1 = L12_1[L13_1]
L13_1 = "list"
L12_1 = L12_1[L13_1]
L13_1 = _ENV
L14_1 = "list_homingMissiles"
L13_1 = L13_1[L14_1]
L14_1 = "白名单"
L15_1 = {}
L16_1 = ""
L12_1 = L12_1(L13_1, L14_1, L15_1, L16_1)
L10_1[L11_1] = L12_1
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.toggle
L11_1 = _ENV
L12_1 = "whiteList"
L11_1 = L11_1[L12_1]
L12_1 = "朋友"
L13_1 = {}
L14_1 = ""
L15_1 = "SetIgnoreFriends"
L15_1 = L2_1[L15_1]
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1)
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.toggle
L11_1 = _ENV
L12_1 = "whiteList"
L11_1 = L11_1[L12_1]
L12_1 = "组织成员"
L13_1 = {}
L14_1 = ""
L15_1 = "SetIgnoreOrgMembers"
L15_1 = L2_1[L15_1]
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1)
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.toggle
L11_1 = _ENV
L12_1 = "whiteList"
L11_1 = L11_1[L12_1]
L12_1 = "帮会成员"
L13_1 = {}
L14_1 = ""
L15_1 = "SetIgnoreCrewMembers"
L15_1 = L2_1[L15_1]
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1)
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.slider
L11_1 = _ENV
L12_1 = "list_homingMissiles"
L11_1 = L11_1[L12_1]
L12_1 = "最大目标数"
L13_1 = {}
L14_1 = ""
L15_1 = 1
L16_1 = 6
L17_1 = 6
L18_1 = 1
L19_1 = "SetMaxTargets"
L19_1 = L2_1[L19_1]
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1)
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.toggle_loop
L11_1 = _ENV
L12_1 = "vehicleWeaponRoot"
L11_1 = L11_1[L12_1]
L12_1 = "空袭飞机"
L13_1 = {}
L14_1 = "使用任何飞机或直升机进行空袭"
function L15_1()
  local L0_2, L1_2
  L0_2 = air_strike_plane
  L0_2()
end
function L16_1()
  local L0_2, L1_2
  air_strike_state = 0
end
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1, L16_1)
L10_1 = _ENV
L11_1 = "menu"
L10_1 = L10_1[L11_1]
L10_1 = L10_1.toggle_loop
L11_1 = _ENV
L12_1 = "vehicle"
L11_1 = L11_1[L12_1]
L12_1 = "随机升级"
L13_1 = {}
L14_1 = ""
function L15_1()
  local L0_2, L1_2
  L0_2 = randomupdatcar_self
  L0_2()
  L0_2 = util
  L0_2 = L0_2.yield
  L1_2 = 500
  L0_2(L1_2)
end
L10_1(L11_1, L12_1, L13_1, L14_1, L15_1)
L10_1 = _ENV
L11_1 = "V_horn_music"
L12_1 = _ENV
L13_1 = "menu"
L12_1 = L12_1[L13_1]
L13_1 = "list"
L12_1 = L12_1[L13_1]
L13_1 = _ENV
L14_1 = "vehicle"
L13_1 = L13_1[L14_1]
L14_1 = "载具喇叭音乐"
L15_1 = {}
L16_1 = ""
L12_1 = L12_1(L13_1, L14_1, L15_1, L16_1)
L10_1[L11_1] = L12_1
L10_1 = _ENV
L11_1 = "filesystem"
L10_1 = L10_1[L11_1]
L11_1 = "store_dir"
L10_1 = L10_1[L11_1]
L10_1 = L10_1()
L11_1 = "SakuraAudio/HornSongs"
L12_1 = "\\"
L10_1 = L10_1 .. L11_1 .. L12_1
L11_1 = _ENV
L12_1 = "load_songs"
L11_1 = L11_1[L12_1]
L12_1 = L10_1
L11_1 = L11_1(L12_1)
L12_1 = _ENV
L13_1 = "pairs"
L12_1 = L12_1[L13_1]
L13_1 = L11_1
L12_1, L13_1, L14_1, L15_1 = L12_1(L13_1)
for L16_1, L17_1 in L12_1, L13_1, L14_1, L15_1 do
  L18_1 = _ENV
  L19_1 = "menu"
  L18_1 = L18_1[L19_1]
  L18_1 = L18_1.action
  L19_1 = _ENV
  L20_1 = "V_horn_music"
  L19_1 = L19_1[L20_1]
  L20_1 = "播放 "
  L21_1 = L17_1.name
  L20_1 = L20_1 .. L21_1
  L21_1 = {}
  L22_1 = "description"
  L22_1 = L17_1[L22_1]
  L23_1 = "\n音乐速度: "
  L24_1 = "bpm"
  L24_1 = L17_1[L24_1]
  L22_1 = L22_1 .. L23_1 .. L24_1
  function L23_1()
    local L0_2, L1_2
    L0_2 = play_song
    L1_2 = L17_1
    L0_2(L1_2)
  end
  L18_1(L19_1, L20_1, L21_1, L22_1, L23_1)
end
L12_1 = _ENV
L13_1 = "menu"
L12_1 = L12_1[L13_1]
L12_1 = L12_1.toggle_loop
L13_1 = _ENV
L14_1 = "vehicle"
L13_1 = L13_1[L14_1]
L14_1 = "锁定全部载具"
L15_1 = {}
L16_1 = ""
function L17_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L0_2 = players
  L0_2 = L0_2.list
  L1_2 = false
  L2_2 = true
  L3_2 = true
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = entities
    L6_2 = L6_2.get_all_vehicles_as_handles
    L6_2, L7_2, L8_2, L9_2 = L6_2()
    for L10_2, L11_2 in L6_2, L7_2, L8_2, L9_2 do
      L12_2 = VEHICLE
      L12_2 = L12_2.SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER
      L13_2 = L11_2
      L14_2 = L5_2
      L15_2 = true
      L12_2(L13_2, L14_2, L15_2)
      L12_2 = util
      L12_2 = L12_2.yield
      L12_2()
    end
  end
end
L12_1(L13_1, L14_1, L15_1, L16_1, L17_1)
L12_1 = _ENV
L13_1 = "menu"
L12_1 = L12_1[L13_1]
L12_1 = L12_1.toggle_loop
L13_1 = _ENV
L14_1 = "vehicle"
L13_1 = L13_1[L14_1]
L14_1 = "Mk2自瞄玩家"
L15_1 = {}
L16_1 = "当玩家在可视范围内发射导弹自动锁定玩家"
function L17_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
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
    L7_2 = v3
    L7_2 = L7_2.distance
    L8_2 = players
    L8_2 = L8_2.get_position
    L9_2 = PLAYER
    L9_2 = L9_2.PLAYER_ID
    L9_2, L10_2, L11_2, L12_2 = L9_2()
    L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2)
    L9_2 = players
    L9_2 = L9_2.get_position
    L10_2 = L5_2
    L9_2, L10_2, L11_2, L12_2 = L9_2(L10_2)
    L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2)
    L8_2 = PED
    L8_2 = L8_2.IS_PED_DEAD_OR_DYING
    L9_2 = L6_2
    L8_2 = L8_2(L9_2)
    if not L8_2 then
      L8_2 = PAD
      L8_2 = L8_2.IS_CONTROL_PRESSED
      L9_2 = 0
      L10_2 = 70
      L8_2 = L8_2(L9_2, L10_2)
      if L8_2 then
        L8_2 = 200.0
        if L7_2 < L8_2 then
          L8_2 = VEHICLE1
          L8_2 = L8_2.SET_VEHICLE_SHOOT_AT_TARGET
          L9_2 = PLAYER
          L9_2 = L9_2.PLAYER_PED_ID
          L9_2 = L9_2()
          L10_2 = L6_2
          L11_2 = players
          L11_2 = L11_2.get_position
          L12_2 = L5_2
          L11_2, L12_2 = L11_2(L12_2)
          L8_2(L9_2, L10_2, L11_2, L12_2)
        end
      end
    end
  end
end
L12_1(L13_1, L14_1, L15_1, L16_1, L17_1)
L12_1 = _ENV
L13_1 = "menu"
L12_1 = L12_1[L13_1]
L12_1 = L12_1.toggle
L13_1 = _ENV
L14_1 = "vehicle"
L13_1 = L13_1[L14_1]
L14_1 = "启用车辆轨迹"
L15_1 = {}
L16_1 = "在所有表面上留下车辆的轨迹"
function L17_1(A0_2)
  local L1_2, L2_2
  L1_2 = GRAPHICS1
  L1_2 = L1_2._SET_FORCE_VEHICLE_TRAILS
  L2_2 = A0_2
  L1_2(L2_2)
end
L12_1(L13_1, L14_1, L15_1, L16_1, L17_1)
L12_1 = _ENV
L13_1 = "menu"
L12_1 = L12_1[L13_1]
L12_1 = L12_1.action
L13_1 = _ENV
L14_1 = "vehicle"
L13_1 = L13_1[L14_1]
L14_1 = "允许当前车辆进入车库"
L15_1 = {}
L16_1 = "允许您将任何车辆驶入车库"
function L17_1()
  local L0_2, L1_2
  L0_2 = carinto
  L0_2()
end
L12_1(L13_1, L14_1, L15_1, L16_1, L17_1)
L12_1 = _ENV
L13_1 = "menu"
L12_1 = L12_1[L13_1]
L12_1 = L12_1.toggle_loop
L13_1 = _ENV
L14_1 = "vehicle"
L13_1 = L13_1[L14_1]
L14_1 = "引擎始终启动"
L15_1 = {}
L16_1 = ""
function L17_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
  L0_2 = PED
  L0_2 = L0_2.IS_PED_IN_ANY_VEHICLE
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = false
  L0_2 = L0_2(L1_2, L2_2)
  if L0_2 then
    L0_2 = PED
    L0_2 = L0_2.GET_VEHICLE_PED_IS_IN
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_PED_ID
    L1_2 = L1_2()
    L2_2 = false
    L0_2 = L0_2(L1_2, L2_2)
    L1_2 = VEHICLE
    L1_2 = L1_2.SET_VEHICLE_ENGINE_ON
    L2_2 = L0_2
    L3_2 = true
    L4_2 = true
    L5_2 = true
    L1_2(L2_2, L3_2, L4_2, L5_2)
    L1_2 = VEHICLE
    L1_2 = L1_2.SET_VEHICLE_LIGHTS
    L2_2 = L0_2
    L3_2 = 0
    L1_2(L2_2, L3_2)
    L1_2 = VEHICLE
    L1_2 = L1_2.SET_VEHICLE_HEADLIGHT_SHADOWS
    L2_2 = L0_2
    L3_2 = 2
    L1_2(L2_2, L3_2)
  end
end
L12_1(L13_1, L14_1, L15_1, L16_1, L17_1)
L12_1 = _ENV
L13_1 = "menu"
L12_1 = L12_1[L13_1]
L12_1 = L12_1.toggle_loop
L13_1 = _ENV
L14_1 = "vehicle"
L13_1 = L13_1[L14_1]
L14_1 = "自定义转弯"
L15_1 = {}
L16_1 = "用A/D键快速转动载具."
function L17_1()
  local L0_2, L1_2
  L0_2 = custom_TurnVehicle
  L0_2()
end
L12_1(L13_1, L14_1, L15_1, L16_1, L17_1)
L12_1 = _ENV
L13_1 = "chauffeur_root"
L14_1 = _ENV
L15_1 = "menu"
L14_1 = L14_1[L15_1]
L15_1 = "list"
L14_1 = L14_1[L15_1]
L15_1 = _ENV
L16_1 = "vehicle"
L15_1 = L15_1[L16_1]
L16_1 = "司机服务"
L17_1 = {}
L18_1 = "呼叫您的私人司机."
L14_1 = L14_1(L15_1, L16_1, L17_1, L18_1)
L12_1[L13_1] = L14_1
L12_1 = _ENV
L13_1 = "menu"
L12_1 = L12_1[L13_1]
L12_1 = L12_1.list_action
L13_1 = _ENV
L14_1 = "chauffeur_root"
L13_1 = L13_1[L14_1]
L14_1 = "传唤司机"
L15_1 = {}
L16_1 = "summonchauffeur"
L15_1[1] = L16_1
L16_1 = ""
L17_1 = {}
L18_1 = "Stretch"
L19_1 = "T20"
L20_1 = "Kuruma"
L17_1[1] = L18_1
L17_1[2] = L19_1
L17_1[3] = L20_1
function L18_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2
  L3_2 = summ_car
  L4_2 = A0_2
  L5_2 = A1_2
  L3_2(L4_2, L5_2)
end
L12_1(L13_1, L14_1, L15_1, L16_1, L17_1, L18_1)
L12_1 = _ENV
L13_1 = "menu"
L12_1 = L12_1[L13_1]
L12_1 = L12_1.action
L13_1 = _ENV
L14_1 = "chauffeur_root"
L13_1 = L13_1[L14_1]
L14_1 = "驾车前往航点"
L15_1 = {}
L16_1 = ""
function L17_1()
  local L0_2, L1_2
  L0_2 = summ_car_topoint
  L0_2()
end
L12_1(L13_1, L14_1, L15_1, L16_1, L17_1)
L12_1 = _ENV
L13_1 = "menu"
L12_1 = L12_1[L13_1]
L12_1 = L12_1.action
L13_1 = _ENV
L14_1 = "chauffeur_root"
L13_1 = L13_1[L14_1]
L14_1 = "传送到驾驶室"
L15_1 = {}
L16_1 = ""
function L17_1()
  local L0_2, L1_2
  L0_2 = summ_car_tp
  L0_2()
end
L12_1(L13_1, L14_1, L15_1, L16_1, L17_1)
L12_1 = _ENV
L13_1 = "menu"
L12_1 = L12_1[L13_1]
L12_1 = L12_1.action
L13_1 = _ENV
L14_1 = "chauffeur_root"
L13_1 = L13_1[L14_1]
L14_1 = "自我毁灭"
L15_1 = {}
L16_1 = ""
function L17_1()
  local L0_2, L1_2
  L0_2 = summ_car_bmob
  L0_2()
end
L12_1(L13_1, L14_1, L15_1, L16_1, L17_1)
L12_1 = _ENV
L13_1 = "menu"
L12_1 = L12_1[L13_1]
L13_1 = "click_slider"
L12_1 = L12_1[L13_1]
L13_1 = _ENV
L14_1 = "vehicle"
L13_1 = L13_1[L14_1]
L14_1 = "垂直堆叠"
L15_1 = {}
L16_1 = ""
L17_1 = 1
L18_1 = 10
L19_1 = 3
L20_1 = 1
function L21_1(A0_2)
  local L1_2, L2_2
  L1_2 = setstacky
  L2_2 = A0_2
  L1_2(L2_2)
end
L12_1(L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1)
L12_1 = _ENV
L13_1 = "menu"
L12_1 = L12_1[L13_1]
L13_1 = "click_slider"
L12_1 = L12_1[L13_1]
L13_1 = _ENV
L14_1 = "vehicle"
L13_1 = L13_1[L14_1]
L14_1 = "水平堆叠"
L15_1 = {}
L16_1 = ""
L17_1 = 1
L18_1 = 10
L19_1 = 3
L20_1 = 1
function L21_1(A0_2)
  local L1_2, L2_2
  L1_2 = setstackx
  L2_2 = A0_2
  L1_2(L2_2)
end
L12_1(L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1)
L12_1 = _ENV
L13_1 = "menu"
L12_1 = L12_1[L13_1]
L12_1 = L12_1.toggle_loop
L13_1 = _ENV
L14_1 = "vehicle"
L13_1 = L13_1[L14_1]
L14_1 = "贴地/贴墙行驶"
L15_1 = {}
L16_1 = "车辆粘在地上/墙上行驶"
function L17_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L0_2 = entities
  L0_2 = L0_2.get_user_vehicle_as_handle
  L0_2 = L0_2()
  L1_2 = PED
  L1_2 = L1_2.IS_PED_IN_ANY_VEHICLE
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  if L1_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
    L2_2 = L0_2
    L3_2 = 1
    L4_2 = 0
    L5_2 = 0
    L6_2 = -0.5
    L7_2 = 0
    L8_2 = true
    L9_2 = true
    L10_2 = true
    L11_2 = true
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    L1_2 = VEHICLE
    L1_2 = L1_2.MODIFY_VEHICLE_TOP_SPEED
    L2_2 = L0_2
    L3_2 = 40
    L1_2(L2_2, L3_2)
  end
end
L12_1(L13_1, L14_1, L15_1, L16_1, L17_1)
L12_1 = _ENV
L13_1 = "menu"
L12_1 = L12_1[L13_1]
L12_1 = L12_1.toggle
L13_1 = _ENV
L14_1 = "vehicle"
L13_1 = L13_1[L14_1]
L14_1 = "更高的跳跃"
L15_1 = {}
L16_1 = "载具需支持竞技场跳跃"
function L17_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = PED
  L1_2 = L1_2.GET_VEHICLE_PED_IS_IN
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = false
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = VEHICLE
  L2_2 = L2_2.SET_USE_HIGHER_CAR_JUMP
  L3_2 = L1_2
  L4_2 = A0_2
  L2_2(L3_2, L4_2)
end
L12_1(L13_1, L14_1, L15_1, L16_1, L17_1)
L12_1 = _ENV
L13_1 = "menu"
L12_1 = L12_1[L13_1]
L13_1 = "list"
L12_1 = L12_1[L13_1]
L13_1 = _ENV
L14_1 = "vehicle"
L13_1 = L13_1[L14_1]
L14_1 = "载具跳跃"
L12_1 = L12_1(L13_1, L14_1)
L13_1 = 25.0
L14_1 = _ENV
L15_1 = "menu"
L14_1 = L14_1[L15_1]
L15_1 = "slider_float"
L14_1 = L14_1[L15_1]
L15_1 = L12_1
L16_1 = "跳跃倍率"
L17_1 = {}
L18_1 = "jumpiness"
L17_1[1] = L18_1
L18_1 = ""
L19_1 = 0
L20_1 = 10000
L21_1 = 2500
L22_1 = 100
function L23_1(A0_2)
  local L1_2
  L1_2 = A0_2 / 100
  L13_1 = L1_2
end
L14_1(L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1)
L14_1 = _ENV
L15_1 = "menu"
L14_1 = L14_1[L15_1]
L14_1 = L14_1.toggle_loop
L15_1 = L12_1
L16_1 = "启动"
L17_1 = {}
L18_1 = "按空格键跳跃."
function L19_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L0_2 = entities
  L0_2 = L0_2.get_user_vehicle_as_handle
  L0_2 = L0_2()
  if 0 ~= L0_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.DOES_ENTITY_EXIST
    L2_2 = L0_2
    L1_2 = L1_2(L2_2)
    if L1_2 then
      L1_2 = PAD
      L1_2 = L1_2.IS_CONTROL_JUST_RELEASED
      L2_2 = 0
      L3_2 = 102
      L1_2 = L1_2(L2_2, L3_2)
      if L1_2 then
        L1_2 = ENTITY
        L1_2 = L1_2.APPLY_FORCE_TO_ENTITY
        L2_2 = L0_2
        L3_2 = 1
        L4_2 = 0.0
        L5_2 = L13_1
        L5_2 = L5_2 / 1.5
        L6_2 = L13_1
        L7_2 = 0.0
        L8_2 = 0.0
        L9_2 = 0.0
        L10_2 = 0
        L11_2 = 1
        L12_2 = 1
        L13_2 = 1
        L14_2 = 0
        L15_2 = 1
        L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
        repeat
          L1_2 = util
          L1_2 = L1_2.yield
          L1_2()
          L1_2 = ENTITY
          L1_2 = L1_2.IS_ENTITY_IN_AIR
          L2_2 = L0_2
          L1_2 = L1_2(L2_2)
        until not L1_2
      end
    end
  end
end
L14_1(L15_1, L16_1, L17_1, L18_1, L19_1)
L14_1 = _ENV
L15_1 = "ff9car"
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L17_1 = "list"
L16_1 = L16_1[L17_1]
L17_1 = _ENV
L18_1 = "vehicle"
L17_1 = L17_1[L18_1]
L18_1 = "道奇战马"
L19_1 = {}
L20_1 = ""
L16_1 = L16_1(L17_1, L18_1, L19_1, L20_1)
L14_1[L15_1] = L16_1
L14_1 = _ENV
L15_1 = "Spawn"
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "ff9car"
L17_1 = L17_1[L18_1]
L18_1 = "道奇战马"
L19_1 = {}
L20_1 = "按E使用"
function L21_1()
  local L0_2, L1_2
  L0_2 = daoqizhanma
  L0_2()
end
function L22_1()
  local L0_2, L1_2
  L0_2 = stop_daoqizhanma
  L0_2()
end
L16_1 = L16_1(L17_1, L18_1, L19_1, L20_1, L21_1, L22_1)
L14_1[L15_1] = L16_1
L14_1 = _ENV
L15_1 = "menu"
L14_1 = L14_1[L15_1]
L15_1 = "list_select"
L14_1 = L14_1[L15_1]
L15_1 = _ENV
L16_1 = "ff9car"
L15_1 = L15_1[L16_1]
L16_1 = "电磁脉冲样式"
L17_1 = {}
L18_1 = "更改样式为推开或炸毁"
L19_1 = _ENV
L20_1 = "maglist"
L19_1 = L19_1[L20_1]
L20_1 = 1
function L21_1(A0_2)
  local L1_2, L2_2
  L1_2 = daoqizhanma_style
  L2_2 = A0_2
  L1_2(L2_2)
end
L14_1(L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1)
L14_1 = _ENV
L15_1 = "sdroot"
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L17_1 = "list"
L16_1 = L16_1[L17_1]
L17_1 = _ENV
L18_1 = "vehicle"
L17_1 = L17_1[L18_1]
L18_1 = "魔幻激光战马"
L19_1 = {}
L20_1 = ""
L16_1 = L16_1(L17_1, L18_1, L19_1, L20_1)
L14_1[L15_1] = L16_1
L14_1 = _ENV
L15_1 = "SDspawn"
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "sdroot"
L17_1 = L17_1[L18_1]
L18_1 = "生成魔幻激光战马"
L19_1 = {}
L20_1 = "魔幻战马可以发出激光"
function L21_1()
  local L0_2, L1_2
  L0_2 = Lazer_Space_Car
  L0_2()
end
function L22_1()
  local L0_2, L1_2
  L0_2 = stop_Magic_w_w
  L0_2()
end
L16_1 = L16_1(L17_1, L18_1, L19_1, L20_1, L21_1, L22_1)
L14_1[L15_1] = L16_1
L14_1 = _ENV
L15_1 = "menu"
L14_1 = L14_1[L15_1]
L15_1 = "list_select"
L14_1 = L14_1[L15_1]
L15_1 = _ENV
L16_1 = "sdroot"
L15_1 = L15_1[L16_1]
L16_1 = "魔幻战马武器"
L17_1 = {}
L18_1 = "更改魔幻激光战马的武器"
L19_1 = _ENV
L20_1 = "lsdweap"
L19_1 = L19_1[L20_1]
L20_1 = 1
function L21_1(A0_2)
  local L1_2, L2_2
  L1_2 = Magic_Warhorse_W
  L2_2 = A0_2
  L1_2(L2_2)
end
L14_1(L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1)
L14_1 = _ENV
L15_1 = "menu"
L14_1 = L14_1[L15_1]
L14_1 = L14_1.slider
L15_1 = _ENV
L16_1 = "vehicle"
L15_1 = L15_1[L16_1]
L16_1 = "换座位"
L17_1 = {}
L18_1 = ""
L19_1 = 1
L20_1 = 6
L21_1 = 1
L22_1 = 1
function L23_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
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
    L2_2 = L2_2(L3_2, L4_2)
    L3_2 = PED
    L3_2 = L3_2.SET_PED_INTO_VEHICLE
    L4_2 = L1_2
    L5_2 = L2_2
    L6_2 = A0_2 - 2
    L3_2(L4_2, L5_2, L6_2)
  else
    L2_2 = util
    L2_2 = L2_2.toast
    L3_2 = "你还没上车呢"
    L2_2(L3_2)
  end
end
L14_1(L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1)
L14_1 = _ENV
L15_1 = "menu"
L14_1 = L14_1[L15_1]
L14_1 = L14_1.toggle_loop
L15_1 = _ENV
L16_1 = "vehicle"
L15_1 = L15_1[L16_1]
L16_1 = "粘在地上"
L17_1 = {}
L18_1 = ""
function L19_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2
  L0_2 = PED
  L0_2 = L0_2.GET_VEHICLE_PED_IS_USING
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_VELOCITY
  L2_2 = L0_2
  L1_2 = L1_2(L2_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_HEIGHT_ABOVE_GROUND
  L3_2 = L0_2
  L2_2 = L2_2(L3_2)
  L3_2 = {}
  L4_2 = 32
  L5_2 = 33
  L6_2 = 34
  L7_2 = 35
  L3_2[1] = L4_2
  L3_2[2] = L5_2
  L3_2[3] = L6_2
  L3_2[4] = L7_2
  if L2_2 < 5.0 then
    L4_2 = ENTITY
    L4_2 = L4_2.IS_ENTITY_IN_AIR
    L5_2 = L0_2
    L4_2 = L4_2(L5_2)
    if L4_2 then
      L4_2 = VEHICLE1
      L4_2 = L4_2.SET_VEHICLE_ON_GROUND_PROPERLY
      L5_2 = L0_2
      L4_2(L5_2)
    end
  else
    L4_2 = ipairs
    L5_2 = L3_2
    L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
    for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
      if 0 ~= L0_2 then
        L10_2 = PAD
        L10_2 = L10_2.IS_CONTROL_PRESSED
        L11_2 = 0
        L12_2 = L9_2
        L10_2 = L10_2(L11_2, L12_2)
        if L10_2 then
          while true do
            L10_2 = PAD
            L10_2 = L10_2.IS_CONTROL_RELEASED
            L11_2 = 0
            L12_2 = L9_2
            L10_2 = L10_2(L11_2, L12_2)
            if L10_2 then
              break
            end
            L10_2 = ENTITY
            L10_2 = L10_2.IS_ENTITY_IN_AIR
            L11_2 = L0_2
            L10_2 = L10_2(L11_2)
            if not L10_2 then
              break
            end
            L10_2 = ENTITY
            L10_2 = L10_2.APPLY_FORCE_TO_ENTITY
            L11_2 = L0_2
            L12_2 = 2
            L13_2 = 0
            L14_2 = 0
            L15_2 = L1_2.z
            L16_2 = -500
            L15_2 = L16_2 - L15_2
            L16_2 = 0
            L17_2 = 0
            L18_2 = 0
            L19_2 = 0
            L20_2 = true
            L21_2 = false
            L22_2 = true
            L23_2 = false
            L24_2 = true
            L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
            L10_2 = util
            L10_2 = L10_2.yield
            L10_2()
          end
        end
      end
    end
  end
end
L14_1(L15_1, L16_1, L17_1, L18_1, L19_1)
L14_1 = _ENV
L15_1 = "menu"
L14_1 = L14_1[L15_1]
L14_1 = L14_1.toggle_loop
L15_1 = _ENV
L16_1 = "vehicle"
L15_1 = L15_1[L16_1]
L16_1 = "部分载具无限海底挤压深度"
L17_1 = {}
L18_1 = "潜水艇,虎鲸..."
function L19_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L0_2 = {}
  L1_2 = "submersible"
  L2_2 = "submersible2"
  L3_2 = "avisa"
  L4_2 = "kosatka"
  L5_2 = "toreador"
  L0_2[1] = L1_2
  L0_2[2] = L2_2
  L0_2[3] = L3_2
  L0_2[4] = L4_2
  L0_2[5] = L5_2
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_MODEL
  L2_2 = entities
  L2_2 = L2_2.get_user_vehicle_as_handle
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L2_2 = ipairs
  L3_2 = L0_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = util
    L8_2 = L8_2.joaat
    L9_2 = L7_2
    L8_2 = L8_2(L9_2)
    if L1_2 == L8_2 then
      L8_2 = VEHICLE
      L8_2 = L8_2.SET_SUBMARINE_CRUSH_DEPTHS
      L9_2 = entities
      L9_2 = L9_2.get_user_vehicle_as_handle
      L9_2 = L9_2()
      L10_2 = false
      L11_2 = 2000
      L12_2 = 2000
      L13_2 = 2000
      L8_2(L9_2, L10_2, L11_2, L12_2, L13_2)
    end
  end
end
L14_1(L15_1, L16_1, L17_1, L18_1, L19_1)
L14_1 = _ENV
L15_1 = "car_part"
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L17_1 = "list"
L16_1 = L16_1[L17_1]
L17_1 = _ENV
L18_1 = "vehicle"
L17_1 = L17_1[L18_1]
L18_1 = "配件控制"
L19_1 = {}
L20_1 = ""
L16_1 = L16_1(L17_1, L18_1, L19_1, L20_1)
L14_1[L15_1] = L16_1
L14_1 = _ENV
L15_1 = "menu"
L14_1 = L14_1[L15_1]
L14_1 = L14_1.textslider
L15_1 = _ENV
L16_1 = "car_part"
L15_1 = L15_1[L16_1]
L16_1 = "打开车门"
L17_1 = {}
L18_1 = ""
L19_1 = {}
L20_1 = "左前门"
L21_1 = "右前门"
L22_1 = "后左门"
L23_1 = "后右门"
L24_1 = "引擎盖"
L25_1 = "后备箱"
L19_1[1] = L20_1
L19_1[2] = L21_1
L19_1[3] = L22_1
L19_1[4] = L23_1
L19_1[5] = L24_1
L19_1[6] = L25_1
function L20_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = PED
  L1_2 = L1_2.GET_VEHICLE_PED_IS_IN
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = false
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = VEHICLE
  L2_2 = L2_2.SET_VEHICLE_DOOR_OPEN
  L3_2 = L1_2
  L4_2 = A0_2 - 1
  L5_2 = false
  L6_2 = false
  L2_2(L3_2, L4_2, L5_2, L6_2)
end
L14_1(L15_1, L16_1, L17_1, L18_1, L19_1, L20_1)
L14_1 = _ENV
L15_1 = "menu"
L14_1 = L14_1[L15_1]
L14_1 = L14_1.toggle
L15_1 = _ENV
L16_1 = "car_part"
L15_1 = L15_1[L16_1]
L16_1 = "所有门"
L17_1 = {}
L18_1 = ""
function L19_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = PED
  L1_2 = L1_2.GET_VEHICLE_PED_IS_IN
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = false
  L1_2 = L1_2(L2_2, L3_2)
  if A0_2 then
    L2_2 = 0
    L3_2 = 5
    L4_2 = 1
    for L5_2 = L2_2, L3_2, L4_2 do
      L6_2 = VEHICLE
      L6_2 = L6_2.SET_VEHICLE_DOOR_OPEN
      L7_2 = L1_2
      L8_2 = L5_2
      L9_2 = false
      L10_2 = false
      L6_2(L7_2, L8_2, L9_2, L10_2)
    end
  else
    L2_2 = VEHICLE
    L2_2 = L2_2.SET_VEHICLE_DOORS_SHUT
    L3_2 = L1_2
    L4_2 = false
    L2_2(L3_2, L4_2)
  end
end
L14_1(L15_1, L16_1, L17_1, L18_1, L19_1)
L14_1 = _ENV
L15_1 = "menu"
L14_1 = L14_1[L15_1]
L14_1 = L14_1.textslider
L15_1 = _ENV
L16_1 = "car_part"
L15_1 = L15_1[L16_1]
L16_1 = "打开车窗"
L17_1 = {}
L18_1 = ""
L19_1 = {}
L20_1 = "左前窗"
L21_1 = "右前窗"
L22_1 = "后左窗"
L23_1 = "后右窗"
L24_1 = "左中"
L25_1 = "右中"
L19_1[1] = L20_1
L19_1[2] = L21_1
L19_1[3] = L22_1
L19_1[4] = L23_1
L19_1[5] = L24_1
L19_1[6] = L25_1
function L20_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = PED
  L1_2 = L1_2.GET_VEHICLE_PED_IS_IN
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = false
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = VEHICLE
  L2_2 = L2_2.ROLL_DOWN_WINDOW
  L3_2 = L1_2
  L4_2 = A0_2 - 1
  L2_2(L3_2, L4_2)
end
L14_1(L15_1, L16_1, L17_1, L18_1, L19_1, L20_1)
L14_1 = _ENV
L15_1 = "menu"
L14_1 = L14_1[L15_1]
L14_1 = L14_1.toggle
L15_1 = _ENV
L16_1 = "car_part"
L15_1 = L15_1[L16_1]
L16_1 = "所有窗"
L17_1 = {}
L18_1 = ""
function L19_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = PED
  L1_2 = L1_2.GET_VEHICLE_PED_IS_IN
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = false
  L1_2 = L1_2(L2_2, L3_2)
  if A0_2 then
    L2_2 = VEHICLE
    L2_2 = L2_2.ROLL_DOWN_WINDOWS
    L3_2 = L1_2
    L2_2(L3_2)
  else
    L2_2 = 0
    L3_2 = 7
    L4_2 = 1
    for L5_2 = L2_2, L3_2, L4_2 do
      L6_2 = VEHICLE
      L6_2 = L6_2.ROLL_UP_WINDOW
      L7_2 = L1_2
      L8_2 = L5_2
      L6_2(L7_2, L8_2)
    end
  end
end
L14_1(L15_1, L16_1, L17_1, L18_1, L19_1)
L14_1 = _ENV
L15_1 = "menu"
L14_1 = L14_1[L15_1]
L14_1 = L14_1.toggle
L15_1 = _ENV
L16_1 = "vehicle"
L15_1 = L15_1[L16_1]
L16_1 = "关闭湍流"
L17_1 = {}
L18_1 = ""
function L19_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  if A0_2 then
    L1_2 = VEHICLE
    L1_2 = L1_2.SET_PLANE_TURBULENCE_MULTIPLIER
    L2_2 = PED
    L2_2 = L2_2.GET_VEHICLE_PED_IS_IN
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2 = L3_2()
    L4_2 = 0
    L2_2 = L2_2(L3_2, L4_2)
    L3_2 = 0.0
    L1_2(L2_2, L3_2)
  else
    L1_2 = VEHICLE
    L1_2 = L1_2.SET_PLANE_TURBULENCE_MULTIPLIER
    L2_2 = PED
    L2_2 = L2_2.GET_VEHICLE_PED_IS_IN
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2 = L3_2()
    L4_2 = 0
    L2_2 = L2_2(L3_2, L4_2)
    L3_2 = 1.0
    L1_2(L2_2, L3_2)
  end
end
L14_1(L15_1, L16_1, L17_1, L18_1, L19_1)
L14_1 = _ENV
L15_1 = "menu"
L14_1 = L14_1[L15_1]
L14_1 = L14_1.action
L15_1 = _ENV
L16_1 = "vehicle"
L15_1 = L15_1[L16_1]
L16_1 = "强制离开载具"
L17_1 = {}
L18_1 = ""
function L19_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = TASK
  L0_2 = L0_2.CLEAR_PED_TASKS_IMMEDIATELY
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2 = L1_2()
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = TASK
  L0_2 = L0_2.TASK_LEAVE_ANY_VEHICLE
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = 0
  L3_2 = 16
  L0_2(L1_2, L2_2, L3_2)
end
L14_1(L15_1, L16_1, L17_1, L18_1, L19_1)
L14_1 = _ENV
L15_1 = "acceleration_pads"
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L17_1 = "list"
L16_1 = L16_1[L17_1]
L17_1 = _ENV
L18_1 = "vehicle"
L17_1 = L17_1[L18_1]
L18_1 = "加(减)速带"
L19_1 = {}
L20_1 = ""
L16_1 = L16_1(L17_1, L18_1, L19_1, L20_1)
L14_1[L15_1] = L16_1
L14_1 = _ENV
L15_1 = "menu"
L14_1 = L14_1[L15_1]
L14_1 = L14_1.action
L15_1 = _ENV
L16_1 = "acceleration_pads"
L15_1 = L15_1[L16_1]
L16_1 = "单个加速带"
L17_1 = {}
L18_1 = ""
function L19_1()
  local L0_2, L1_2
  L0_2 = jiasudian
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2 = L1_2()
  L0_2(L1_2)
end
L14_1(L15_1, L16_1, L17_1, L18_1, L19_1)
L14_1 = _ENV
L15_1 = "menu"
L14_1 = L14_1[L15_1]
L14_1 = L14_1.action
L15_1 = _ENV
L16_1 = "acceleration_pads"
L15_1 = L15_1[L16_1]
L16_1 = "四个加速带"
L17_1 = {}
L18_1 = ""
function L19_1()
  local L0_2, L1_2
  L0_2 = sigejiasudian
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2 = L1_2()
  L0_2(L1_2)
end
L14_1(L15_1, L16_1, L17_1, L18_1, L19_1)
L14_1 = _ENV
L15_1 = "menu"
L14_1 = L14_1[L15_1]
L14_1 = L14_1.action
L15_1 = _ENV
L16_1 = "acceleration_pads"
L15_1 = L15_1[L16_1]
L16_1 = "单个减速带"
L17_1 = {}
L18_1 = ""
function L19_1()
  local L0_2, L1_2
  L0_2 = jiansudai
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2 = L1_2()
  L0_2(L1_2)
end
L14_1(L15_1, L16_1, L17_1, L18_1, L19_1)
L14_1 = _ENV
L15_1 = "vehicle_effect"
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L17_1 = "list"
L16_1 = L16_1[L17_1]
L17_1 = _ENV
L18_1 = "vehicle"
L17_1 = L17_1[L18_1]
L18_1 = "载具效果"
L19_1 = {}
L20_1 = ""
L16_1 = L16_1(L17_1, L18_1, L19_1, L20_1)
L14_1[L15_1] = L16_1
L14_1 = _ENV
L15_1 = "menu"
L14_1 = L14_1[L15_1]
L14_1 = L14_1.toggle_loop
L15_1 = _ENV
L16_1 = "vehicle_effect"
L15_1 = L15_1[L16_1]
L16_1 = "开关"
L17_1 = {}
L18_1 = ""
function L19_1()
  local L0_2, L1_2
  L0_2 = vehicle_effectt
  L0_2()
end
L14_1(L15_1, L16_1, L17_1, L18_1, L19_1)
L14_1 = _ENV
L15_1 = "menu"
L14_1 = L14_1[L15_1]
L15_1 = "list_select"
L14_1 = L14_1[L15_1]
L15_1 = _ENV
L16_1 = "vehicle_effect"
L15_1 = L15_1[L16_1]
L16_1 = "设置载具效果"
L17_1 = {}
L18_1 = ""
L19_1 = _ENV
L20_1 = "v_eff_options"
L19_1 = L19_1[L20_1]
L20_1 = 1
function L21_1(A0_2)
  local L1_2, L2_2
  L1_2 = selectedOptt
  L2_2 = A0_2
  L1_2(L2_2)
end
L14_1(L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1)
L14_1 = _ENV
L15_1 = "ptfx_trails_lt"
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L17_1 = "list"
L16_1 = L16_1[L17_1]
L17_1 = _ENV
L18_1 = "vehicle_effect"
L17_1 = L17_1[L18_1]
L18_1 = "粒子拖尾"
L16_1 = L16_1(L17_1, L18_1)
L14_1[L15_1] = L16_1
L14_1 = _ENV
L15_1 = "menu"
L14_1 = L14_1[L15_1]
L14_1 = L14_1.toggle_loop
L15_1 = _ENV
L16_1 = "ptfx_trails_lt"
L15_1 = L15_1[L16_1]
L16_1 = "粒子拖尾"
L17_1 = {}
L18_1 = ""
function L19_1()
  local L0_2, L1_2
  L0_2 = particle_tail
  L0_2()
end
function L20_1()
  local L0_2, L1_2
  L0_2 = STREAMING
  L0_2 = L0_2.REMOVE_NAMED_PTFX_ASSET
  L1_2 = "scr_rcpaparazzo1"
  L0_2(L1_2)
end
L14_1(L15_1, L16_1, L17_1, L18_1, L19_1, L20_1)
L14_1 = _ENV
L15_1 = "menu"
L14_1 = L14_1[L15_1]
L15_1 = "list_select"
L14_1 = L14_1[L15_1]
L15_1 = _ENV
L16_1 = "ptfx_trails_lt"
L15_1 = L15_1[L16_1]
L16_1 = "设置拖尾效果"
L17_1 = {}
L18_1 = ""
L19_1 = _ENV
L20_1 = "vehparticle_name"
L19_1 = L19_1[L20_1]
L20_1 = 1
function L21_1(A0_2)
  local L1_2, L2_2
  L1_2 = selectparticle
  L2_2 = A0_2
  L1_2(L2_2)
end
L14_1(L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1)
L14_1 = _ENV
L15_1 = "jesus_main"
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L17_1 = "list"
L16_1 = L16_1[L17_1]
L17_1 = _ENV
L18_1 = "vehicle"
L17_1 = L17_1[L18_1]
L18_1 = "自动驾驶"
L19_1 = {}
L20_1 = ""
L16_1 = L16_1(L17_1, L18_1, L19_1, L20_1)
L14_1[L15_1] = L16_1
L14_1 = _ENV
L15_1 = "jesus_toggle"
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle
L17_1 = _ENV
L18_1 = "jesus_main"
L17_1 = L17_1[L18_1]
L18_1 = "启用"
L19_1 = {}
L20_1 = ""
function L21_1(A0_2)
  local L1_2, L2_2
  L1_2 = Auto_driving
  L2_2 = A0_2
  L1_2(L2_2)
end
L16_1 = L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L14_1[L15_1] = L16_1
L14_1 = _ENV
L15_1 = "menu"
L14_1 = L14_1[L15_1]
L15_1 = "list_select"
L14_1 = L14_1[L15_1]
L15_1 = _ENV
L16_1 = "jesus_main"
L15_1 = L15_1[L16_1]
L16_1 = "驾驶风格"
L17_1 = {}
L18_1 = "点击以切换风格"
L19_1 = _ENV
L20_1 = "style_names"
L19_1 = L19_1[L20_1]
L20_1 = 1
function L21_1(A0_2)
  local L1_2, L2_2
  L1_2 = drivestylee
  L2_2 = A0_2
  L1_2(L2_2)
end
L14_1(L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1)
L14_1 = _ENV
L15_1 = "menu"
L14_1 = L14_1[L15_1]
L15_1 = "slider_float"
L14_1 = L14_1[L15_1]
L15_1 = _ENV
L16_1 = "jesus_main"
L15_1 = L15_1[L16_1]
L16_1 = "驾驶速度"
L17_1 = {}
L18_1 = "调整自动驾驶的速度"
L19_1 = 0
L20_1 = 10000
L21_1 = 2000
L22_1 = 100
function L23_1(A0_2)
  local L1_2, L2_2
  L1_2 = drivespeedd
  L2_2 = A0_2
  L1_2(L2_2)
end
L14_1(L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1)
L14_1 = _ENV
L15_1 = "menu"
L14_1 = L14_1[L15_1]
L14_1 = L14_1.toggle
L15_1 = _ENV
L16_1 = "vehicle"
L15_1 = L15_1[L16_1]
L16_1 = "特斯拉自动驾驶"
L17_1 = {}
L18_1 = ""
function L19_1(A0_2)
  local L1_2, L2_2
  L1_2 = Tesla_Autopilot
  L2_2 = A0_2
  L1_2(L2_2)
end
L14_1(L15_1, L16_1, L17_1, L18_1, L19_1)
L14_1 = _ENV
L15_1 = "menu"
L14_1 = L14_1[L15_1]
L14_1 = L14_1.toggle_loop
L15_1 = _ENV
L16_1 = "vehicle"
L15_1 = L15_1[L16_1]
L16_1 = "强制生成反制系统"
L17_1 = {}
L18_1 = "让所有载具都有反制系统"
function L19_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L1_2 = PAD
  L1_2 = L1_2.IS_CONTROL_PRESSED
  L2_2 = 0
  L3_2 = 46
  L1_2 = L1_2(L2_2, L3_2)
  if L1_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = math
    L3_2 = L3_2.random
    L4_2 = -5
    L5_2 = 5
    L3_2 = L3_2(L4_2, L5_2)
    L4_2 = -30.0
    L5_2 = math
    L5_2 = L5_2.random
    L6_2 = -5
    L7_2 = 5
    L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L5_2(L6_2, L7_2)
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
    L2_2 = MISC
    L2_2 = L2_2.SHOOT_SINGLE_BULLET_BETWEEN_COORDS
    L3_2 = L1_2.x
    L4_2 = L1_2.y
    L5_2 = L1_2.z
    L6_2 = L1_2.x
    L7_2 = L1_2.y
    L8_2 = L1_2.z
    L9_2 = 100.0
    L10_2 = true
    L11_2 = 1198879012
    L12_2 = PLAYER
    L12_2 = L12_2.PLAYER_PED_ID
    L12_2 = L12_2()
    L13_2 = true
    L14_2 = false
    L15_2 = 100.0
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  end
end
L14_1(L15_1, L16_1, L17_1, L18_1, L19_1)
L14_1 = _ENV
L15_1 = "vehflyroot"
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L17_1 = "list"
L16_1 = L16_1[L17_1]
L17_1 = _ENV
L18_1 = "vehicle"
L17_1 = L17_1[L18_1]
L18_1 = "载具飞行模式"
L19_1 = {}
L20_1 = "自由控制你的载具再天上飞行"
L16_1 = L16_1(L17_1, L18_1, L19_1, L20_1)
L14_1[L15_1] = L16_1
L14_1 = _ENV
L15_1 = "menu"
L14_1 = L14_1[L15_1]
L14_1 = L14_1.toggle_loop
L15_1 = _ENV
L16_1 = "vehflyroot"
L15_1 = L15_1[L16_1]
L16_1 = "开启"
L17_1 = {}
L18_1 = ""
function L19_1()
  local L0_2, L1_2
  L0_2 = veh_fly
  L0_2()
end
function L20_1()
  local L0_2, L1_2
  L0_2 = close_veh_fly
  L0_2()
end
L14_1(L15_1, L16_1, L17_1, L18_1, L19_1, L20_1)
L14_1 = _ENV
L15_1 = "menu"
L14_1 = L14_1[L15_1]
L14_1 = L14_1.slider
L15_1 = _ENV
L16_1 = "vehflyroot"
L15_1 = L15_1[L16_1]
L16_1 = "改变飞行速度"
L17_1 = {}
L18_1 = "vehflyspeed"
L17_1[1] = L18_1
L18_1 = "改变载具飞行的速度"
L19_1 = 10
L20_1 = 1000
L21_1 = 150
L22_1 = 10
function L23_1(A0_2)
  local L1_2, L2_2
  L1_2 = veh_fly_speed
  L2_2 = A0_2
  L1_2(L2_2)
end
L14_1(L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1)
L14_1 = _ENV
L15_1 = "menu"
L14_1 = L14_1[L15_1]
L14_1 = L14_1.toggle
L15_1 = _ENV
L16_1 = "vehflyroot"
L15_1 = L15_1[L16_1]
L16_1 = "无碰撞"
L17_1 = {}
L18_1 = "飞行时禁止与其他物体产生碰撞"
function L19_1(A0_2)
  local L1_2, L2_2
  L1_2 = veh_fly_coll
  L2_2 = A0_2
  L1_2(L2_2)
end
L14_1(L15_1, L16_1, L17_1, L18_1, L19_1)
L14_1 = _ENV
L15_1 = "menu"
L14_1 = L14_1[L15_1]
L14_1 = L14_1.toggle
L15_1 = _ENV
L16_1 = "vehflyroot"
L15_1 = L15_1[L16_1]
L16_1 = "禁用停止"
L17_1 = {}
L18_1 = "放开按键后禁止停止载具"
function L19_1(A0_2)
  local L1_2, L2_2
  L1_2 = veh_fly_stop
  L2_2 = A0_2
  L1_2(L2_2)
end
L14_1(L15_1, L16_1, L17_1, L18_1, L19_1)
L14_1 = _ENV
L15_1 = "vf"
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L17_1 = "list"
L16_1 = L16_1[L17_1]
L17_1 = _ENV
L18_1 = "vehicle"
L17_1 = L17_1[L18_1]
L18_1 = "冻结选项"
L19_1 = {}
L20_1 = ""
L16_1 = L16_1(L17_1, L18_1, L19_1, L20_1)
L14_1[L15_1] = L16_1
L14_1 = _ENV
L15_1 = "menu"
L14_1 = L14_1[L15_1]
L14_1 = L14_1.action
L15_1 = _ENV
L16_1 = "vf"
L15_1 = L15_1[L16_1]
L16_1 = "冻结载具"
L17_1 = {}
L18_1 = "冻结当前载具"
function L19_1()
  local L0_2, L1_2, L2_2
  L0_2 = PED
  L0_2 = L0_2.GET_VEHICLE_PED_IS_IN
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = false
  L0_2 = L0_2(L1_2, L2_2)
  if L0_2 then
    L1_2 = add_frozen_vehicle
    L2_2 = L0_2
    L1_2(L2_2)
  end
end
L14_1(L15_1, L16_1, L17_1, L18_1, L19_1)
L14_1 = _ENV
L15_1 = "frozen_vehicles_menu_list"
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L17_1 = "list"
L16_1 = L16_1[L17_1]
L17_1 = _ENV
L18_1 = "vf"
L17_1 = L17_1[L18_1]
L18_1 = "已冻结的载具"
L16_1 = L16_1(L17_1, L18_1)
L14_1[L15_1] = L16_1
L14_1 = 0
L15_1 = _ENV
L16_1 = "util"
L15_1 = L15_1[L16_1]
L16_1 = "create_tick_handler"
L15_1 = L15_1[L16_1]
function L16_1()
  local L0_2, L1_2
  L0_2 = L14_1
  L0_2 = L0_2 % 1000
  if 0 == L0_2 then
    L0_2 = update_frozen_vehicles
    L0_2()
  end
  L0_2 = L14_1
  L0_2 = L0_2 + 1
  L14_1 = L0_2
  L0_2 = true
  return L0_2
end
L15_1(L16_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "vehicle"
L16_1 = L16_1[L17_1]
L17_1 = "摧毁载具"
L18_1 = {}
L19_1 = ""
function L20_1()
  local L0_2, L1_2
  L0_2 = menu
  L0_2 = L0_2.trigger_commands
  L1_2 = "destroyvehicle"
  L0_2(L1_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = require
L16_1 = "lib.daidailib.Constructor"
L15_1(L16_1)
L15_1 = _ENV
L16_1 = "perrico_island"
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L18_1 = "list"
L17_1 = L17_1[L18_1]
L18_1 = _ENV
L19_1 = "Task_robbery"
L18_1 = L18_1[L19_1]
L19_1 = "佩里科岛"
L20_1 = {}
L21_1 = ""
L17_1 = L17_1(L18_1, L19_1, L20_1, L21_1)
L15_1[L16_1] = L17_1
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "perrico_island"
L16_1 = L16_1[L17_1]
L17_1 = "呼叫虎鲸"
L18_1 = {}
L19_1 = ""
function L20_1()
  local L0_2, L1_2, L2_2
  L0_2 = SET_INT_GLOBAL
  L1_2 = Global_Base
  L1_2 = L1_2.Default
  L1_2 = L1_2 + 960
  L2_2 = 1
  L0_2(L1_2, L2_2)
  L0_2 = notification
  L1_2 = "~y~~bold~呼叫ing~"
  L2_2 = HudColour
  L2_2 = L2_2.blue
  L0_2(L1_2, L2_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "island_casino_Task_setting"
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L18_1 = "list"
L17_1 = L17_1[L18_1]
L18_1 = _ENV
L19_1 = "perrico_island"
L18_1 = L18_1[L19_1]
L19_1 = "任务设定"
L20_1 = {}
L21_1 = ""
L17_1 = L17_1(L18_1, L19_1, L20_1, L21_1)
L15_1[L16_1] = L17_1
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "island_casino_Task_setting"
L16_1 = L16_1[L17_1]
L17_1 = "跳过准备任务"
L18_1 = {}
L19_1 = ""
function L20_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = STAT_SET_INT
  L1_2 = "H4CNF_TARGET"
  L2_2 = 5
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H4_MISSIONS"
  L2_2 = 65413
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H4_PROGRESS"
  L2_2 = 126823
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H4CNF_APPROACH"
  L2_2 = -1
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H4CNF_BS_ENTR"
  L2_2 = 63
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H4CNF_BS_GEN"
  L2_2 = 63
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H4CNF_WEP_DISRP"
  L2_2 = 3
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H4CNF_ARM_DISRP"
  L2_2 = 3
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H4CNF_HEL_DISRP"
  L2_2 = 3
  L0_2(L1_2, L2_2)
  L0_2 = SET_INT_LOCAL
  L1_2 = "heist_island_planning"
  L2_2 = 1526
  L3_2 = 2
  L0_2(L1_2, L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "island_casino_Task_setting"
L16_1 = L16_1[L17_1]
L17_1 = "重置面板"
L18_1 = {}
L19_1 = ""
function L20_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = STAT_SET_INT
  L1_2 = "H4_MISSIONS"
  L2_2 = 0
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H4_PROGRESS"
  L2_2 = 0
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H4CNF_APPROACH"
  L2_2 = 0
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H4CNF_BS_ENTR"
  L2_2 = 0
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H4CNF_BS_GEN"
  L2_2 = 0
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H4_PLAYTHROUGH_STATUS"
  L2_2 = 0
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H4CNF_TARGET"
  L2_2 = -1
  L0_2(L1_2, L2_2)
  L0_2 = SET_INT_LOCAL
  L1_2 = "heist_island_planning"
  L2_2 = 1526
  L3_2 = 2
  L0_2(L1_2, L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "TELEPORT_island"
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L18_1 = "list"
L17_1 = L17_1[L18_1]
L18_1 = _ENV
L19_1 = "perrico_island"
L18_1 = L18_1[L19_1]
L19_1 = "地点传送"
L20_1 = {}
L21_1 = ""
L17_1 = L17_1(L18_1, L19_1, L20_1, L21_1)
L15_1[L16_1] = L17_1
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "TELEPORT_island"
L16_1 = L16_1[L17_1]
L17_1 = "任务面板(虎鲸)"
L18_1 = {}
L19_1 = "先呼叫潜艇"
function L20_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = STAT_GET_INT
  L1_2 = "IH_SUB_OWNED"
  L0_2 = L0_2(L1_2)
  if 0 == L0_2 then
  else
    L0_2 = teleport
    L1_2 = 1561.2369
    L2_2 = 385.8771
    L3_2 = -49.689915
    L0_2(L1_2, L2_2, L3_2)
    L0_2 = ENTITY
    L0_2 = L0_2.SET_ENTITY_HEADING
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_PED_ID
    L1_2 = L1_2()
    L2_2 = 175
    L0_2(L1_2, L2_2)
    L0_2 = STAT_SET_INT
    L1_2 = "H4_PROGRESS"
    L2_2 = 131055
    L0_2(L1_2, L2_2)
  end
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "TELEPORT_island"
L16_1 = L16_1[L17_1]
L17_1 = "传送到大门(外侧)"
L18_1 = {}
L19_1 = ""
function L20_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = teleport
  L1_2 = 4974.189
  L2_2 = -5703.279
  L3_2 = 19.898539
  L0_2(L1_2, L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "TELEPORT_island"
L16_1 = L16_1[L17_1]
L17_1 = "传送到大门(内测)"
L18_1 = {}
L19_1 = ""
function L20_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = teleport
  L1_2 = 4993.189
  L2_2 = -5720.279
  L3_2 = 19.898539
  L0_2(L1_2, L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "TELEPORT_island"
L16_1 = L16_1[L17_1]
L17_1 = "主要目标"
L18_1 = {}
L19_1 = ""
function L20_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = teleport
  L1_2 = 5006.7
  L2_2 = -5756.2
  L3_2 = 14.8
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = ENTITY
  L0_2 = L0_2.SET_ENTITY_HEADING
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = 145
  L0_2(L1_2, L2_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "TELEPORT_island"
L16_1 = L16_1[L17_1]
L17_1 = "次要目标"
L18_1 = {}
L19_1 = ""
function L20_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = teleport
  L1_2 = 4999.76416
  L2_2 = -5749.86377
  L3_2 = 14.84
  L0_2(L1_2, L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "TELEPORT_island"
L16_1 = L16_1[L17_1]
L17_1 = "机场(逃离)"
L18_1 = {}
L19_1 = ""
function L20_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = teleport
  L1_2 = 4443.189
  L2_2 = -4510.279
  L3_2 = 4.898539
  L0_2(L1_2, L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.toggle_loop
L16_1 = _ENV
L17_1 = "TELEPORT_island"
L16_1 = L16_1[L17_1]
L17_1 = "传送到大海"
L18_1 = {}
L19_1 = ""
function L20_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = teleport
  L1_2 = 3235
  L2_2 = -4938
  L3_2 = 56
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = util
  L0_2 = L0_2.yield
  L1_2 = 1000
  L0_2(L1_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "island_cut"
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L18_1 = "list"
L17_1 = L17_1[L18_1]
L18_1 = _ENV
L19_1 = "perrico_island"
L18_1 = L18_1[L19_1]
L19_1 = "分红调整"
L20_1 = {}
L21_1 = "分红界面出现时再修改"
L17_1 = L17_1(L18_1, L19_1, L20_1, L21_1)
L15_1[L16_1] = L17_1
L15_1 = _ENV
L16_1 = "cayo_cut"
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L18_1 = "list"
L17_1 = L17_1[L18_1]
L18_1 = _ENV
L19_1 = "island_cut"
L18_1 = L18_1[L19_1]
L19_1 = "玩家[1-4]"
L20_1 = {}
L21_1 = ""
L17_1 = L17_1(L18_1, L19_1, L20_1, L21_1)
L15_1[L16_1] = L17_1
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.slider
L16_1 = _ENV
L17_1 = "cayo_cut"
L16_1 = L16_1[L17_1]
L17_1 = "玩家1"
L18_1 = {}
L19_1 = "(%)"
L20_1 = 0
L21_1 = 1000
L22_1 = 25
L23_1 = 5
function L24_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = SET_INT_GLOBAL
  L2_2 = 1979377
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.slider
L16_1 = _ENV
L17_1 = "cayo_cut"
L16_1 = L16_1[L17_1]
L17_1 = "玩家2"
L18_1 = {}
L19_1 = "(%)"
L20_1 = 0
L21_1 = 1000
L22_1 = 25
L23_1 = 5
function L24_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = SET_INT_GLOBAL
  L2_2 = 1979378
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.slider
L16_1 = _ENV
L17_1 = "cayo_cut"
L16_1 = L16_1[L17_1]
L17_1 = "玩家3"
L18_1 = {}
L19_1 = "(%)"
L20_1 = 0
L21_1 = 1000
L22_1 = 25
L23_1 = 5
function L24_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = SET_INT_GLOBAL
  L2_2 = 1979379
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.slider
L16_1 = _ENV
L17_1 = "cayo_cut"
L16_1 = L16_1[L17_1]
L17_1 = "玩家4"
L18_1 = {}
L19_1 = "(%)"
L20_1 = 0
L21_1 = 1000
L22_1 = 25
L23_1 = 5
function L24_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = SET_INT_GLOBAL
  L2_2 = 1979380
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "island_cut"
L16_1 = L16_1[L17_1]
L17_1 = "自保分红"
L18_1 = {}
L19_1 = "全员135%,自己60%"
function L20_1()
  local L0_2, L1_2, L2_2
  L0_2 = SET_INT_GLOBAL
  L1_2 = 1979377
  L2_2 = 60
  L0_2(L1_2, L2_2)
  L0_2 = SET_INT_GLOBAL
  L1_2 = 1979378
  L2_2 = 135
  L0_2(L1_2, L2_2)
  L0_2 = SET_INT_GLOBAL
  L1_2 = 1979379
  L2_2 = 135
  L0_2(L1_2, L2_2)
  L0_2 = SET_INT_GLOBAL
  L1_2 = 1979380
  L2_2 = 135
  L0_2(L1_2, L2_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.slider
L16_1 = _ENV
L17_1 = "island_cut"
L16_1 = L16_1[L17_1]
L17_1 = "全员分红"
L18_1 = {}
L19_1 = "(%)"
L20_1 = 0
L21_1 = 1000
L22_1 = 25
L23_1 = 5
function L24_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = SET_INT_GLOBAL
  L2_2 = 1979377
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
  L1_2 = SET_INT_GLOBAL
  L2_2 = 1979378
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
  L1_2 = SET_INT_GLOBAL
  L2_2 = 1979379
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
  L1_2 = SET_INT_GLOBAL
  L2_2 = 1979380
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.list_action
L16_1 = _ENV
L17_1 = "perrico_island"
L16_1 = L16_1[L17_1]
L17_1 = "抢劫难度"
L18_1 = {}
L19_1 = ""
L20_1 = {}
L21_1 = "正常"
L22_1 = "困难"
L20_1[1] = L21_1
L20_1[2] = L22_1
function L21_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  if 1 == A0_2 then
    L1_2 = STAT_SET_INT
    L2_2 = "H4_PROGRESS"
    L3_2 = 126823
    L1_2(L2_2, L3_2)
    L1_2 = SET_INT_LOCAL
    L2_2 = "heist_island_planning"
    L3_2 = 1526
    L4_2 = 2
    L1_2(L2_2, L3_2, L4_2)
  elseif 2 == A0_2 then
    L1_2 = STAT_SET_INT
    L2_2 = "H4_PROGRESS"
    L3_2 = 131055
    L1_2(L2_2, L3_2)
    L1_2 = SET_INT_LOCAL
    L2_2 = "heist_island_planning"
    L3_2 = 1526
    L4_2 = 2
    L1_2(L2_2, L3_2, L4_2)
  end
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1, L21_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.toggle_loop
L16_1 = _ENV
L17_1 = "perrico_island"
L16_1 = L16_1[L17_1]
L17_1 = "跳过下水道切割"
L18_1 = {}
L19_1 = ""
function L20_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = IS_HELP_MSG_DISPLAYED
  L1_2 = "UT_WELD_PROMPT"
  L0_2 = L0_2(L1_2)
  if L0_2 then
    L0_2 = PAD2
    L0_2 = L0_2._SET_CONTROL_NORMAL
    L1_2 = 2
    L2_2 = 51
    L3_2 = 1
    L0_2(L1_2, L2_2, L3_2)
  else
    L0_2 = GET_INT_LOCAL
    L1_2 = "fm_mission_controller_2020"
    L2_2 = 26746
    L0_2 = L0_2(L1_2, L2_2)
    if 4 == L0_2 then
      L0_2 = SET_INT_LOCAL
      L1_2 = "fm_mission_controller_2020"
      L2_2 = 26746
      L3_2 = 6
      L0_2(L1_2, L2_2, L3_2)
    end
  end
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "perrico_island"
L16_1 = L16_1[L17_1]
L17_1 = "删除排水管"
L18_1 = {}
L19_1 = ""
function L20_1()
  local L0_2, L1_2
  L0_2 = DELETE_OBJECT_BY_HASH
  L1_2 = -1297635988
  L0_2(L1_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.toggle_loop
L16_1 = _ENV
L17_1 = "perrico_island"
L16_1 = L16_1[L17_1]
L17_1 = "跳过指纹锁"
L18_1 = {}
L19_1 = ""
function L20_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = GET_INT_LOCAL
  L1_2 = "fm_mission_controller_2020"
  L2_2 = 23669
  L0_2 = L0_2(L1_2, L2_2)
  if 4 == L0_2 then
    L0_2 = SET_INT_LOCAL
    L1_2 = "fm_mission_controller_2020"
    L2_2 = 23669
    L3_2 = 5
    L0_2(L1_2, L2_2, L3_2)
  end
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "perrico_island"
L16_1 = L16_1[L17_1]
L17_1 = "快速切开玻璃"
L18_1 = {}
L19_1 = "切割时使用"
function L20_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = SET_FLOAT_LOCAL
  L1_2 = "fm_mission_controller_2020"
  L2_2 = 29688
  L3_2 = 100
  L0_2(L1_2, L2_2, L3_2)
end
function L21_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = SET_FLOAT_LOCAL
  L1_2 = "fm_mission_controller_2020"
  L2_2 = 29688
  L3_2 = 0
  L0_2(L1_2, L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1, L21_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.toggle_loop
L16_1 = _ENV
L17_1 = "perrico_island"
L16_1 = L16_1[L17_1]
L17_1 = "绕过切割机发热"
L18_1 = {}
L19_1 = "切割前开启"
function L20_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = SET_FLOAT_LOCAL
  L1_2 = "fm_mission_controller_2020"
  L2_2 = 29689
  L3_2 = 0
  L0_2(L1_2, L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "perrico_island"
L16_1 = L16_1[L17_1]
L17_1 = "杀死队友"
L18_1 = {}
L19_1 = "炸死队友,包括自己(无敌可免疫)"
function L20_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L0_2 = getNonWhitelistedPlayers
  L1_2 = whitelistListTable
  L2_2 = whitelistGroups
  L3_2 = whitelistedName
  L0_2 = L0_2(L1_2, L2_2, L3_2)
  L1_2 = pairs
  L2_2 = L0_2
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = PLAYER
    L7_2 = L7_2.GET_PLAYER_PED_SCRIPT_INDEX
    L8_2 = L6_2
    L7_2 = L7_2(L8_2)
    L8_2 = explodePlayer
    L9_2 = L7_2
    L10_2 = false
    L11_2 = expSettings
    L8_2(L9_2, L10_2, L11_2)
  end
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "advanced_options_island"
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L18_1 = "list"
L17_1 = L17_1[L18_1]
L18_1 = _ENV
L19_1 = "perrico_island"
L18_1 = L18_1[L19_1]
L19_1 = "高级选项"
L20_1 = {}
L21_1 = ""
L17_1 = L17_1(L18_1, L19_1, L20_1, L21_1)
L15_1[L16_1] = L17_1
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L16_1 = "click_slider"
L15_1 = L15_1[L16_1]
L16_1 = _ENV
L17_1 = "advanced_options_island"
L16_1 = L16_1[L17_1]
L17_1 = "增加任务生命数"
L18_1 = {}
L19_1 = "只有是战局主机时才会生效"
L20_1 = 0
L21_1 = 100
L22_1 = 3
L23_1 = 1
function L24_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = SET_INT_LOCAL
  L2_2 = "fm_mission_controller_2020"
  L3_2 = 52774
  L4_2 = A0_2 + 2
  L1_2(L2_2, L3_2, L4_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "advanced_options_island"
L16_1 = L16_1[L17_1]
L17_1 = "快速完成"
L18_1 = {}
L19_1 = ""
function L20_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = menu
  L0_2 = L0_2.trigger_commands
  L1_2 = "scripthost"
  L0_2(L1_2)
  L0_2 = SET_INT_LOCAL
  L1_2 = "fm_mission_controller_2020"
  L2_2 = 45451
  L3_2 = 51338752
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = SET_INT_LOCAL
  L1_2 = "fm_mission_controller_2020"
  L2_2 = 46829
  L3_2 = 50
  L0_2(L1_2, L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "advanced_options_island"
L16_1 = L16_1[L17_1]
L17_1 = "一键结束动画"
L18_1 = {}
L19_1 = "仅限单人上岛使用"
function L20_1()
  local L0_2, L1_2
  L0_2 = menu
  L0_2 = L0_2.trigger_commands
  L1_2 = "skipcutscene"
  L0_2(L1_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "casino"
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L18_1 = "list"
L17_1 = L17_1[L18_1]
L18_1 = _ENV
L19_1 = "Task_robbery"
L18_1 = L18_1[L19_1]
L19_1 = "名钻赌场"
L20_1 = {}
L21_1 = ""
L17_1 = L17_1(L18_1, L19_1, L20_1, L21_1)
L15_1[L16_1] = L17_1
L15_1 = _ENV
L16_1 = "casino_Task_setting"
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L18_1 = "list"
L17_1 = L17_1[L18_1]
L18_1 = _ENV
L19_1 = "casino"
L18_1 = L18_1[L19_1]
L19_1 = "任务设定"
L20_1 = {}
L21_1 = ""
L17_1 = L17_1(L18_1, L19_1, L20_1, L21_1)
L15_1[L16_1] = L17_1
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "casino_Task_setting"
L16_1 = L16_1[L17_1]
L17_1 = "跳过准备任务"
L18_1 = {}
L19_1 = "目标：钻石\n方式:气势汹汹"
function L20_1()
  local L0_2, L1_2, L2_2
  L0_2 = STAT_SET_INT
  L1_2 = "CAS_HEIST_FLOW"
  L2_2 = -1
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H3_LAST_APPROACH"
  L2_2 = 0
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H3OPT_APPROACH"
  L2_2 = 3
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H3_HARD_APPROACH"
  L2_2 = 0
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H3OPT_TARGET"
  L2_2 = 3
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H3OPT_POI"
  L2_2 = 1023
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H3OPT_ACCESSPOINTS"
  L2_2 = 2047
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H3OPT_CREWWEAP"
  L2_2 = 4
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H3OPT_CREWDRIVER"
  L2_2 = 3
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H3OPT_CREWHACKER"
  L2_2 = 4
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H3OPT_DISRUPTSHIP"
  L2_2 = 3
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H3OPT_BODYARMORLVL"
  L2_2 = -1
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H3OPT_KEYLEVELS"
  L2_2 = 2
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H3OPT_BITSET1"
  L2_2 = 799
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H3OPT_BITSET0"
  L2_2 = 3670102
  L0_2(L1_2, L2_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "casino_Task_setting"
L16_1 = L16_1[L17_1]
L17_1 = "重置面板"
L18_1 = {}
L19_1 = ""
function L20_1()
  local L0_2, L1_2, L2_2
  L0_2 = STAT_SET_INT
  L1_2 = "H3_LAST_APPROACH"
  L2_2 = 0
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H3OPT_APPROACH"
  L2_2 = 0
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H3_HARD_APPROACH"
  L2_2 = 0
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H3OPT_TARGET"
  L2_2 = 0
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H3OPT_POI"
  L2_2 = 0
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H3OPT_ACCESSPOINTS"
  L2_2 = 0
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H3OPT_BITSET1"
  L2_2 = 0
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H3OPT_CREWWEAP"
  L2_2 = 0
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H3OPT_CREWDRIVER"
  L2_2 = 0
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H3OPT_CREWHACKER"
  L2_2 = 0
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H3OPT_WEAPS"
  L2_2 = 0
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H3OPT_VEHS"
  L2_2 = 0
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H3OPT_DISRUPTSHIP"
  L2_2 = 0
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H3OPT_BODYARMORLVL"
  L2_2 = 0
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H3OPT_KEYLEVELS"
  L2_2 = 0
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H3OPT_MASKS"
  L2_2 = 0
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "H3OPT_BITSET0"
  L2_2 = 0
  L0_2(L1_2, L2_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "TELEPORT_casino"
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L18_1 = "list"
L17_1 = L17_1[L18_1]
L18_1 = _ENV
L19_1 = "casino"
L18_1 = L18_1[L19_1]
L19_1 = "地点传送"
L20_1 = {}
L21_1 = ""
L17_1 = L17_1(L18_1, L19_1, L20_1, L21_1)
L15_1[L16_1] = L17_1
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "TELEPORT_casino"
L16_1 = L16_1[L17_1]
L17_1 = "计划面板(游戏厅)"
L18_1 = {}
L19_1 = "先进游戏厅"
function L20_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = teleport
  L1_2 = 2711.773
  L2_2 = -369.458
  L3_2 = -54.781
  L0_2(L1_2, L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "TELEPORT_casino"
L16_1 = L16_1[L17_1]
L17_1 = "车库出口(游戏厅)"
L18_1 = {}
L19_1 = "先进游戏厅"
function L20_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = teleport
  L1_2 = 2677.237
  L2_2 = -361.494
  L3_2 = -55.187
  L0_2(L1_2, L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "TELEPORT_casino"
L16_1 = L16_1[L17_1]
L17_1 = "门口(赌场)"
L18_1 = {}
L19_1 = ""
function L20_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = teleport
  L1_2 = 917.24634
  L2_2 = 48.989567
  L3_2 = 80.89892
  L0_2(L1_2, L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "TELEPORT_casino"
L16_1 = L16_1[L17_1]
L17_1 = "员工大厅(赌场)"
L18_1 = {}
L19_1 = ""
function L20_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = teleport
  L1_2 = 965.14856
  L2_2 = -9.05023
  L3_2 = 80.63045
  L0_2(L1_2, L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "TELEPORT_casino"
L16_1 = L16_1[L17_1]
L17_1 = "音乐柜"
L18_1 = {}
L19_1 = ""
function L20_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = teleport
  L1_2 = 997.5346
  L2_2 = 84.51491
  L3_2 = 80.990555
  L0_2(L1_2, L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "TELEPORT_casino"
L16_1 = L16_1[L17_1]
L17_1 = "废物处理间(赌场)"
L18_1 = {}
L19_1 = ""
function L20_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = teleport
  L1_2 = 2542.052
  L2_2 = -214.3084
  L3_2 = -58.722965
  L0_2(L1_2, L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "TELEPORT_casino"
L16_1 = L16_1[L17_1]
L17_1 = "员工大门(赌场)"
L18_1 = {}
L19_1 = ""
function L20_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = teleport
  L1_2 = 2547.9192
  L2_2 = -273.16754
  L3_2 = -58.723003
  L0_2(L1_2, L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "TELEPORT_casino"
L16_1 = L16_1[L17_1]
L17_1 = "双人刷卡点(赌场)"
L18_1 = {}
L19_1 = ""
function L20_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = teleport
  L1_2 = 2465.4746
  L2_2 = -279.2276
  L3_2 = -70.694145
  L0_2(L1_2, L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "TELEPORT_casino"
L16_1 = L16_1[L17_1]
L17_1 = "金库内部(赌场)"
L18_1 = {}
L19_1 = ""
function L20_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = teleport
  L1_2 = 2515.1252
  L2_2 = -238.91661
  L3_2 = -70.73713
  L0_2(L1_2, L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "TELEPORT_casino"
L16_1 = L16_1[L17_1]
L17_1 = "库外部(赌场)"
L18_1 = {}
L19_1 = ""
function L20_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = teleport
  L1_2 = 2497.5098
  L2_2 = -238.50768
  L3_2 = -70.7388
  L0_2(L1_2, L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "TELEPORT_casino"
L16_1 = L16_1[L17_1]
L17_1 = "小金库(赌场)"
L18_1 = {}
L19_1 = ""
function L20_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = teleport
  L1_2 = 2520.8645
  L2_2 = -286.30685
  L3_2 = -58.723007
  L0_2(L1_2, L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "casino_fenhong"
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L18_1 = "list"
L17_1 = L17_1[L18_1]
L18_1 = _ENV
L19_1 = "casino"
L18_1 = L18_1[L19_1]
L19_1 = "分红调整"
L20_1 = {}
L21_1 = ""
L17_1 = L17_1(L18_1, L19_1, L20_1, L21_1)
L15_1[L16_1] = L17_1
L15_1 = _ENV
L16_1 = "casino_cut"
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L18_1 = "list"
L17_1 = L17_1[L18_1]
L18_1 = _ENV
L19_1 = "casino_fenhong"
L18_1 = L18_1[L19_1]
L19_1 = "玩家[1-4]"
L20_1 = {}
L21_1 = ""
L17_1 = L17_1(L18_1, L19_1, L20_1, L21_1)
L15_1[L16_1] = L17_1
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.slider
L16_1 = _ENV
L17_1 = "casino_cut"
L16_1 = L16_1[L17_1]
L17_1 = "玩家1"
L18_1 = {}
L19_1 = "(%)"
L20_1 = 0
L21_1 = 1000
L22_1 = 25
L23_1 = 5
function L24_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = SET_INT_GLOBAL
  L2_2 = 1974022
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.slider
L16_1 = _ENV
L17_1 = "casino_cut"
L16_1 = L16_1[L17_1]
L17_1 = "玩家2"
L18_1 = {}
L19_1 = "(%)"
L20_1 = 0
L21_1 = 1000
L22_1 = 25
L23_1 = 5
function L24_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = SET_INT_GLOBAL
  L2_2 = 1974023
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.slider
L16_1 = _ENV
L17_1 = "casino_cut"
L16_1 = L16_1[L17_1]
L17_1 = "玩家3"
L18_1 = {}
L19_1 = "(%)"
L20_1 = 0
L21_1 = 1000
L22_1 = 25
L23_1 = 5
function L24_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = SET_INT_GLOBAL
  L2_2 = 1974024
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.slider
L16_1 = _ENV
L17_1 = "casino_cut"
L16_1 = L16_1[L17_1]
L17_1 = "玩家4"
L18_1 = {}
L19_1 = "(%)"
L20_1 = 0
L21_1 = 1000
L22_1 = 25
L23_1 = 5
function L24_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = SET_INT_GLOBAL
  L2_2 = 1974025
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "casino_fenhong"
L16_1 = L16_1[L17_1]
L17_1 = "自保分红"
L18_1 = {}
L19_1 = "全员146%, 自己60%"
function L20_1()
  local L0_2, L1_2, L2_2
  L0_2 = SET_INT_GLOBAL
  L1_2 = 1974022
  L2_2 = 60
  L0_2(L1_2, L2_2)
  L0_2 = SET_INT_GLOBAL
  L1_2 = 1974023
  L2_2 = 146
  L0_2(L1_2, L2_2)
  L0_2 = SET_INT_GLOBAL
  L1_2 = 1974024
  L2_2 = 146
  L0_2(L1_2, L2_2)
  L0_2 = SET_INT_GLOBAL
  L1_2 = 1974025
  L2_2 = 146
  L0_2(L1_2, L2_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.slider
L16_1 = _ENV
L17_1 = "casino_fenhong"
L16_1 = L16_1[L17_1]
L17_1 = "自定义分红"
L18_1 = {}
L19_1 = "(%)"
L20_1 = 0
L21_1 = 1000
L22_1 = 25
L23_1 = 5
function L24_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = SET_INT_GLOBAL
  L2_2 = 1974022
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
  L1_2 = SET_INT_GLOBAL
  L2_2 = 1974023
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
  L1_2 = SET_INT_GLOBAL
  L2_2 = 1974024
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
  L1_2 = SET_INT_GLOBAL
  L2_2 = 1974025
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "casino"
L16_1 = L16_1[L17_1]
L17_1 = "杀死队友"
L18_1 = {}
L19_1 = "炸死队友,包括自己(无敌可免疫)"
function L20_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L0_2 = getNonWhitelistedPlayers
  L1_2 = whitelistListTable
  L2_2 = whitelistGroups
  L3_2 = whitelistedName
  L0_2 = L0_2(L1_2, L2_2, L3_2)
  L1_2 = pairs
  L2_2 = L0_2
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = PLAYER
    L7_2 = L7_2.GET_PLAYER_PED_SCRIPT_INDEX
    L8_2 = L6_2
    L7_2 = L7_2(L8_2)
    L8_2 = explodePlayer
    L9_2 = L7_2
    L10_2 = false
    L11_2 = expSettings
    L8_2(L9_2, L10_2, L11_2)
  end
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "advanced_options_casino"
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L18_1 = "list"
L17_1 = L17_1[L18_1]
L18_1 = _ENV
L19_1 = "casino"
L18_1 = L18_1[L19_1]
L19_1 = "高级选项"
L20_1 = {}
L21_1 = ""
L17_1 = L17_1(L18_1, L19_1, L20_1, L21_1)
L15_1[L16_1] = L17_1
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "advanced_options_casino"
L16_1 = L16_1[L17_1]
L17_1 = "强制启动"
L18_1 = {}
L19_1 = "当你在计划面板上选择玩家时，这个功能将允许你强制开始，即使其他玩家没有准备好。收入会显示错误"
function L20_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L0_2 = 0
  L1_2 = 3
  L2_2 = 1
  for L3_2 = L0_2, L1_2, L2_2 do
    L4_2 = SET_INT_GLOBAL
    L5_2 = 1974016 + L3_2
    L6_2 = -1
    L4_2(L5_2, L6_2)
  end
  L0_2 = STAT_GET_INT
  L1_2 = "H3OPT_BITSET0"
  L0_2 = L0_2(L1_2)
  L1_2 = STAT_GET_INT
  L2_2 = "H3OPT_BITSET1"
  L1_2 = L1_2(L2_2)
  L2_2 = STAT_SET_INT
  L3_2 = "H3OPT_BITSET0"
  L4_2 = math
  L4_2 = L4_2.random
  L5_2 = 2147483647
  L4_2, L5_2, L6_2 = L4_2(L5_2)
  L2_2(L3_2, L4_2, L5_2, L6_2)
  L2_2 = STAT_SET_INT
  L3_2 = "H3OPT_BITSET1"
  L4_2 = math
  L4_2 = L4_2.random
  L5_2 = 2147483647
  L4_2, L5_2, L6_2 = L4_2(L5_2)
  L2_2(L3_2, L4_2, L5_2, L6_2)
  L2_2 = util
  L2_2 = L2_2.yield_once
  L2_2()
  L2_2 = STAT_SET_INT
  L3_2 = "H3OPT_BITSET0"
  L4_2 = L0_2
  L2_2(L3_2, L4_2)
  L2_2 = STAT_SET_INT
  L3_2 = "H3OPT_BITSET1"
  L4_2 = L1_2
  L2_2(L3_2, L4_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L16_1 = "click_slider"
L15_1 = L15_1[L16_1]
L16_1 = _ENV
L17_1 = "advanced_options_casino"
L16_1 = L16_1[L17_1]
L17_1 = "增加任务生命数"
L18_1 = {}
L19_1 = "只有是战局主机时才会生效"
L20_1 = 0
L21_1 = 100
L22_1 = 0
L23_1 = 1
function L24_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = SET_INT_LOCAL
  L2_2 = "fm_mission_controller"
  L3_2 = 27462
  L4_2 = A0_2
  L1_2(L2_2, L3_2, L4_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "advanced_options_casino"
L16_1 = L16_1[L17_1]
L17_1 = "快速完成"
L18_1 = {}
L19_1 = ""
function L20_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = menu
  L0_2 = L0_2.trigger_commands
  L1_2 = "scripthost"
  L0_2(L1_2)
  L0_2 = SET_INT_LOCAL
  L1_2 = "fm_mission_controller"
  L2_2 = 21451
  L3_2 = 80
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = SET_INT_LOCAL
  L1_2 = "fm_mission_controller"
  L2_2 = 22396
  L3_2 = 10000000
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = SET_INT_LOCAL
  L1_2 = "fm_mission_controller"
  L2_2 = 28332
  L3_2 = 99999
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = SET_INT_LOCAL
  L1_2 = "fm_mission_controller"
  L2_2 = 31656
  L3_2 = 99999
  L0_2(L1_2, L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "doomsday"
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L18_1 = "list"
L17_1 = L17_1[L18_1]
L18_1 = _ENV
L19_1 = "Task_robbery"
L18_1 = L18_1[L19_1]
L19_1 = "末日豪杰"
L20_1 = {}
L21_1 = ""
L17_1 = L17_1(L18_1, L19_1, L20_1, L21_1)
L15_1[L16_1] = L17_1
L15_1 = _ENV
L16_1 = "doomsday_Task_setting"
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L18_1 = "list"
L17_1 = L17_1[L18_1]
L18_1 = _ENV
L19_1 = "doomsday"
L18_1 = L18_1[L19_1]
L19_1 = "任务设定"
L20_1 = {}
L21_1 = ""
L17_1 = L17_1(L18_1, L19_1, L20_1, L21_1)
L15_1[L16_1] = L17_1
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "doomsday_Task_setting"
L16_1 = L16_1[L17_1]
L17_1 = "数据泄露 I"
L18_1 = {}
L19_1 = ""
function L20_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = STAT_SET_INT
  L1_2 = "GANGOPS_FLOW_MISSION_PROG"
  L2_2 = 503
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "GANGOPS_HEIST_STATUS"
  L2_2 = -229383
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "GANGOPS_FLOW_NOTIFICATIONS"
  L2_2 = 1557
  L0_2(L1_2, L2_2)
  L0_2 = SET_INT_LOCAL
  L1_2 = "gb_gang_ops_planning"
  L2_2 = 179
  L3_2 = 6
  L0_2(L1_2, L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "doomsday_Task_setting"
L16_1 = L16_1[L17_1]
L17_1 = "波格丹危机 II"
L18_1 = {}
L19_1 = ""
function L20_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = STAT_SET_INT
  L1_2 = "GANGOPS_FLOW_MISSION_PROG"
  L2_2 = 240
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "GANGOPS_HEIST_STATUS"
  L2_2 = -229378
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "GANGOPS_FLOW_NOTIFICATIONS"
  L2_2 = 1557
  L0_2(L1_2, L2_2)
  L0_2 = SET_INT_LOCAL
  L1_2 = "gb_gang_ops_planning"
  L2_2 = 179
  L3_2 = 6
  L0_2(L1_2, L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "doomsday_Task_setting"
L16_1 = L16_1[L17_1]
L17_1 = "末日降临 III"
L18_1 = {}
L19_1 = ""
function L20_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = STAT_SET_INT
  L1_2 = "GANGOPS_FLOW_MISSION_PROG"
  L2_2 = 16368
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "GANGOPS_HEIST_STATUS"
  L2_2 = -229380
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "GANGOPS_FLOW_NOTIFICATIONS"
  L2_2 = 1557
  L0_2(L1_2, L2_2)
  L0_2 = SET_INT_LOCAL
  L1_2 = "gb_gang_ops_planning"
  L2_2 = 179
  L3_2 = 6
  L0_2(L1_2, L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "doomsday_Task_setting"
L16_1 = L16_1[L17_1]
L17_1 = "重置任务面板"
L18_1 = {}
L19_1 = ""
function L20_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = STAT_SET_INT
  L1_2 = "GANGOPS_FLOW_MISSION_PROG"
  L2_2 = 240
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "GANGOPS_HEIST_STATUS"
  L2_2 = 0
  L0_2(L1_2, L2_2)
  L0_2 = STAT_SET_INT
  L1_2 = "GANGOPS_FLOW_NOTIFICATIONS"
  L2_2 = 1557
  L0_2(L1_2, L2_2)
  L0_2 = SET_INT_LOCAL
  L1_2 = "gb_gang_ops_planning"
  L2_2 = 179
  L3_2 = 6
  L0_2(L1_2, L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "doomsday_Task_tp"
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L18_1 = "list"
L17_1 = L17_1[L18_1]
L18_1 = _ENV
L19_1 = "doomsday"
L18_1 = L18_1[L19_1]
L19_1 = "地点传送"
L20_1 = {}
L21_1 = ""
L17_1 = L17_1(L18_1, L19_1, L20_1, L21_1)
L15_1[L16_1] = L17_1
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "doomsday_Task_tp"
L16_1 = L16_1[L17_1]
L17_1 = "抢劫屏幕"
L18_1 = {}
L19_1 = ""
function L20_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = teleport
  L1_2 = 350.69284
  L2_2 = 4872.308
  L3_2 = -60.794243
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = ENTITY
  L0_2 = L0_2.SET_ENTITY_HEADING
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = -50
  L0_2(L1_2, L2_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "doomsday_cut"
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L18_1 = "list"
L17_1 = L17_1[L18_1]
L18_1 = _ENV
L19_1 = "doomsday"
L18_1 = L18_1[L19_1]
L19_1 = "分红设置"
L20_1 = {}
L21_1 = ""
L17_1 = L17_1(L18_1, L19_1, L20_1, L21_1)
L15_1[L16_1] = L17_1
L15_1 = _ENV
L16_1 = "doomsday_cut1"
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L18_1 = "list"
L17_1 = L17_1[L18_1]
L18_1 = _ENV
L19_1 = "doomsday_cut"
L18_1 = L18_1[L19_1]
L19_1 = "末日分红"
L20_1 = {}
L21_1 = ""
L17_1 = L17_1(L18_1, L19_1, L20_1, L21_1)
L15_1[L16_1] = L17_1
L15_1 = _ENV
L16_1 = "doomsday_cut_p"
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L18_1 = "list"
L17_1 = L17_1[L18_1]
L18_1 = _ENV
L19_1 = "doomsday_cut1"
L18_1 = L18_1[L19_1]
L19_1 = "玩家[1-4]"
L20_1 = {}
L21_1 = ""
L17_1 = L17_1(L18_1, L19_1, L20_1, L21_1)
L15_1[L16_1] = L17_1
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.slider
L16_1 = _ENV
L17_1 = "doomsday_cut_p"
L16_1 = L16_1[L17_1]
L17_1 = "玩家1"
L18_1 = {}
L19_1 = "(%)"
L20_1 = 0
L21_1 = 1000
L22_1 = 25
L23_1 = 5
function L24_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = SET_INT_GLOBAL
  L2_2 = 1968493
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.slider
L16_1 = _ENV
L17_1 = "doomsday_cut_p"
L16_1 = L16_1[L17_1]
L17_1 = "玩家2"
L18_1 = {}
L19_1 = "(%)"
L20_1 = 0
L21_1 = 1000
L22_1 = 25
L23_1 = 5
function L24_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = SET_INT_GLOBAL
  L2_2 = 1968494
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.slider
L16_1 = _ENV
L17_1 = "doomsday_cut_p"
L16_1 = L16_1[L17_1]
L17_1 = "玩家3"
L18_1 = {}
L19_1 = "(%)"
L20_1 = 0
L21_1 = 1000
L22_1 = 25
L23_1 = 5
function L24_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = SET_INT_GLOBAL
  L2_2 = 1968495
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.slider
L16_1 = _ENV
L17_1 = "doomsday_cut_p"
L16_1 = L16_1[L17_1]
L17_1 = "玩家4"
L18_1 = {}
L19_1 = "(%)"
L20_1 = 0
L21_1 = 1000
L22_1 = 25
L23_1 = 5
function L24_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = SET_INT_GLOBAL
  L2_2 = 1968496
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.slider
L16_1 = _ENV
L17_1 = "doomsday_cut1"
L16_1 = L16_1[L17_1]
L17_1 = "全员分红"
L18_1 = {}
L19_1 = "(%)"
L20_1 = 0
L21_1 = 1000
L22_1 = 25
L23_1 = 5
function L24_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = SET_INT_GLOBAL
  L2_2 = 1968493
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
  L1_2 = SET_INT_GLOBAL
  L2_2 = 1968494
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
  L1_2 = SET_INT_GLOBAL
  L2_2 = 1968495
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
  L1_2 = SET_INT_GLOBAL
  L2_2 = 1968496
  L3_2 = A0_2
  L1_2(L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1)
L15_1 = _ENV
L16_1 = "advanced_options_doomsday"
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L18_1 = "list"
L17_1 = L17_1[L18_1]
L18_1 = _ENV
L19_1 = "doomsday"
L18_1 = L18_1[L19_1]
L19_1 = "高级选项"
L20_1 = {}
L21_1 = ""
L17_1 = L17_1(L18_1, L19_1, L20_1, L21_1)
L15_1[L16_1] = L17_1
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "advanced_options_doomsday"
L16_1 = L16_1[L17_1]
L17_1 = "快速完成"
L18_1 = {}
L19_1 = "末日降临"
function L20_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = menu
  L0_2 = L0_2.trigger_commands
  L1_2 = "scripthost"
  L0_2(L1_2)
  L0_2 = SET_INT_LOCAL
  L1_2 = "fm_mission_controller"
  L2_2 = 19710
  L3_2 = 12
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = SET_INT_LOCAL
  L1_2 = "fm_mission_controller"
  L2_2 = 21451
  L3_2 = 150
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = SET_INT_LOCAL
  L1_2 = "fm_mission_controller"
  L2_2 = 28332
  L3_2 = 99999
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = SET_INT_LOCAL
  L1_2 = "fm_mission_controller"
  L2_2 = 31656
  L3_2 = 99999
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = SET_INT_LOCAL
  L1_2 = "fm_mission_controller"
  L2_2 = 31684
  L3_2 = 80
  L0_2(L1_2, L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.toggle_loop
L16_1 = _ENV
L17_1 = "Task_robbery"
L16_1 = L16_1[L17_1]
L17_1 = "达克斯冷却"
L18_1 = {}
L19_1 = "移除达克斯工作的冷却时间"
function L20_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = STATS
  L0_2 = L0_2.STAT_SET_INT
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "MP"
  L3_2 = util
  L3_2 = L3_2.get_char_slot
  L3_2 = L3_2()
  L4_2 = "_XM22JUGGALOWORKCDTIMER"
  L2_2 = L2_2 .. L3_2 .. L4_2
  L1_2 = L1_2(L2_2)
  L2_2 = -1
  L3_2 = true
  L0_2(L1_2, L2_2, L3_2)
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.toggle_loop
L16_1 = _ENV
L17_1 = "Task_robbery"
L16_1 = L16_1[L17_1]
L17_1 = "立刻完成刑事破坏"
L18_1 = {}
L19_1 = ""
function L20_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = SCRIPT
  L1_2 = "GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH"
  L0_2 = L0_2[L1_2]
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "am_criminal_damage"
  L1_2, L2_2, L3_2 = L1_2(L2_2)
  L0_2 = L0_2(L1_2, L2_2, L3_2)
  if 0 ~= L0_2 then
    L0_2 = SET_INT_LOCAL
    L1_2 = "am_criminal_damage"
    L2_2 = 105
    L3_2 = 2147483647
    L0_2(L1_2, L2_2, L3_2)
    L0_2 = util
    L0_2 = L0_2.yield
    L1_2 = 3000
    L0_2(L1_2)
    L0_2 = SET_INT_LOCAL
    L1_2 = "am_criminal_damage"
    L2_2 = 149
    L3_2 = 0
    L0_2(L1_2, L2_2, L3_2)
  end
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = _ENV
L16_1 = "casino_brush_money"
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L18_1 = "list"
L17_1 = L17_1[L18_1]
L18_1 = _ENV
L19_1 = "Task_robbery"
L18_1 = L18_1[L19_1]
L19_1 = "全自动赌场刷钱"
L20_1 = {}
L21_1 = ""
L17_1 = L17_1(L18_1, L19_1, L20_1, L21_1)
L15_1[L16_1] = L17_1
L15_1 = require
L16_1 = "lib.daidailib.SlotBot"
L15_1(L16_1)
L15_1 = _ENV
L16_1 = "menu"
L15_1 = L15_1[L16_1]
L15_1 = L15_1.action
L16_1 = _ENV
L17_1 = "Task_robbery"
L16_1 = L16_1[L17_1]
L17_1 = "将拾取物传送到自己"
L18_1 = {}
L19_1 = ""
function L20_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L0_2 = 0
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_COORDS
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  L2_2 = entities
  L2_2 = L2_2.get_all_pickups_as_handles
  L2_2, L3_2, L4_2, L5_2 = L2_2()
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = ENTITY
    L8_2 = L8_2.SET_ENTITY_COORDS
    L9_2 = L7_2
    L10_2 = L1_2.x
    L11_2 = L1_2.y
    L12_2 = L1_2.z
    L13_2 = false
    L14_2 = false
    L15_2 = false
    L16_2 = false
    L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
    L0_2 = L0_2 + 1
    L8_2 = util
    L8_2 = L8_2.yield
    L8_2()
  end
  if 0 == L0_2 then
    L2_2 = util
    L2_2 = L2_2.toast
    L3_2 = "没有发现可捡拾物. :/"
    L2_2(L3_2)
  else
    L2_2 = util
    L2_2 = L2_2.toast
    L3_2 = "已传送 "
    L4_2 = tostring
    L5_2 = L0_2
    L4_2 = L4_2(L5_2)
    L5_2 = " 个拾取物."
    L3_2 = L3_2 .. L4_2 .. L5_2
    L2_2(L3_2)
  end
end
L15_1(L16_1, L17_1, L18_1, L19_1, L20_1)
L15_1 = {}
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "Task_robbery"
L17_1 = L17_1[L18_1]
L18_1 = "自动出租车"
L19_1 = {}
L20_1 = "自动传送到出租车接送人员,接他们并放下他们,直到你不再在出租车上"
function L21_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L0_2 = L15_1.x
  if nil == L0_2 then
    L0_2 = ENTITY
    L0_2 = L0_2.GET_ENTITY_COORDS
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_PED_ID
    L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L1_2()
    L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
    L15_1 = L0_2
    L0_2 = L15_1
    return L0_2
  end
  L0_2 = PED
  L0_2 = L0_2.GET_VEHICLE_PED_IS_IN
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = false
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_MODEL
  L2_2 = L0_2
  L1_2 = L1_2(L2_2)
  if 0 ~= L0_2 then
    L2_2 = util
    L2_2 = L2_2.reverse_joaat
    L3_2 = L1_2
    L2_2 = L2_2(L3_2)
    if "taxi" == L2_2 then
      goto lbl_59
    end
  end
  L2_2 = ENTITY
  L2_2 = L2_2.SET_ENTITY_COORDS
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2 = L3_2()
  L4_2 = 895.1739
  L5_2 = -179.2708
  L6_2 = 74.70049
  L7_2 = false
  L8_2 = true
  L9_2 = true
  L10_2 = false
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L2_2 = util
  L2_2 = L2_2.yield
  L3_2 = 2500
  L2_2(L3_2)
  L2_2 = PAD
  L2_2 = L2_2.SET_CONTROL_VALUE_NEXT_FRAME
  L3_2 = 0
  L4_2 = 51
  L5_2 = 1
  L2_2(L3_2, L4_2, L5_2)
  L2_2 = util
  L2_2 = L2_2.yield
  L3_2 = 10000
  L2_2(L3_2)
  ::lbl_59::
  L2_2 = HUD
  L2_2 = L2_2.GET_CLOSEST_BLIP_INFO_ID
  L3_2 = 280
  L2_2 = L2_2(L3_2)
  L3_2 = HUD
  L3_2 = L3_2.GET_BLIP_INFO_ID_ENTITY_INDEX
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  L4_2 = ENTITY
  L4_2 = L4_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L5_2 = L3_2
  L6_2 = 0
  L7_2 = 6
  L8_2 = 0
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  L5_2 = HUD
  L5_2 = L5_2.DOES_BLIP_EXIST
  L6_2 = HUD
  L6_2 = L6_2.GET_CLOSEST_BLIP_INFO_ID
  L7_2 = 280
  L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L6_2(L7_2)
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  if L5_2 then
    L5_2 = L4_2.x
    if 0 == L5_2 then
      goto lbl_144
    end
    L5_2 = L4_2.y
    if 0 == L5_2 then
      goto lbl_144
    end
    L5_2 = L4_2.z
    if 0 == L5_2 then
      goto lbl_144
    end
    L5_2 = util
    L5_2 = L5_2.yield
    L6_2 = 500
    L5_2(L6_2)
    L5_2 = PED
    L5_2 = L5_2.SET_PED_COORDS_KEEP_VEHICLE
    L6_2 = PLAYER
    L6_2 = L6_2.PLAYER_PED_ID
    L6_2 = L6_2()
    L7_2 = L4_2.x
    L8_2 = L4_2.y
    L9_2 = L4_2.z
    L10_2 = false
    L11_2 = false
    L12_2 = false
    L13_2 = false
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
    L5_2 = util
    L5_2 = L5_2.yield
    L6_2 = 1500
    L5_2(L6_2)
    L5_2 = PAD
    L5_2 = L5_2.SET_CONTROL_VALUE_NEXT_FRAME
    L6_2 = 0
    L7_2 = 86
    L8_2 = 1
    L5_2(L6_2, L7_2, L8_2)
    while true do
      L5_2 = HUD
      L5_2 = L5_2.DOES_BLIP_EXIST
      L6_2 = HUD
      L6_2 = L6_2.GET_CLOSEST_BLIP_INFO_ID
      L7_2 = 280
      L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L6_2(L7_2)
      L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
      if not L5_2 then
        break
      end
      L5_2 = util
      L5_2 = L5_2.yield
      L5_2()
    end
    L5_2 = util
    L5_2 = L5_2.yield
    L6_2 = 500
    L5_2(L6_2)
    L5_2 = menu
    L5_2 = L5_2.trigger_commands
    L6_2 = "tpobjective"
    L5_2(L6_2)
  else
    L5_2 = util
    L5_2 = L5_2.yield
    L5_2()
  end
  ::lbl_144::
end
function L22_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = ENTITY
  L0_2 = L0_2.SET_ENTITY_COORDS
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = L15_1.x
  L3_2 = L15_1.y
  L4_2 = L15_1.z
  L5_2 = false
  L6_2 = true
  L7_2 = true
  L8_2 = false
  L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  L0_2 = util
  L0_2 = L0_2.toast
  L1_2 = "已结束出租车工作"
  L0_2(L1_2)
  L0_2 = {}
  L15_1 = L0_2
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1, L22_1)
L16_1 = _ENV
L17_1 = "unlocks"
L18_1 = _ENV
L19_1 = "menu"
L18_1 = L18_1[L19_1]
L19_1 = "list"
L18_1 = L18_1[L19_1]
L19_1 = _ENV
L20_1 = "Task_robbery"
L19_1 = L19_1[L20_1]
L20_1 = "解锁选项"
L18_1 = L18_1(L19_1, L20_1)
L16_1[L17_1] = L18_1
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "unlocks"
L17_1 = L17_1[L18_1]
L18_1 = "50辆载具车库"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2, L2_2
  L0_2 = memory
  L0_2 = L0_2.read_byte
  L1_2 = memory
  L1_2 = L1_2.script_global
  L2_2 = 294833
  L1_2, L2_2 = L1_2(L2_2)
  L0_2 = L0_2(L1_2, L2_2)
  if 0 ~= L0_2 then
    L0_2 = memory
    L0_2 = L0_2.write_byte
    L1_2 = memory
    L1_2 = L1_2.script_global
    L2_2 = 294833
    L1_2 = L1_2(L2_2)
    L2_2 = 0
    L0_2(L1_2, L2_2)
  end
  L0_2 = memory
  L0_2 = L0_2.read_byte
  L1_2 = memory
  L1_2 = L1_2.script_global
  L2_2 = 294847
  L1_2, L2_2 = L1_2(L2_2)
  L0_2 = L0_2(L1_2, L2_2)
  if 1 ~= L0_2 then
    L0_2 = memory
    L0_2 = L0_2.write_byte
    L1_2 = memory
    L1_2 = L1_2.script_global
    L2_2 = 294847
    L1_2 = L1_2(L2_2)
    L2_2 = 1
    L0_2(L1_2, L2_2)
  end
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.action
L17_1 = _ENV
L18_1 = "unlocks"
L17_1 = L17_1[L18_1]
L18_1 = "毒品战争内容"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L0_2 = 33974
  L1_2 = 34112
  L2_2 = 1
  for L3_2 = L0_2, L1_2, L2_2 do
    L4_2 = memory
    L4_2 = L4_2.write_byte
    L5_2 = memory
    L5_2 = L5_2.script_global
    L6_2 = 262145 + L3_2
    L5_2 = L5_2(L6_2)
    L6_2 = 1
    L4_2(L5_2, L6_2)
  end
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.action
L17_1 = _ENV
L18_1 = "unlocks"
L17_1 = L17_1[L18_1]
L18_1 = "圣诞和新年礼物"
L19_1 = {}
L20_1 = "Change sessions for the gifts to be awarded."
function L21_1()
  local L0_2, L1_2, L2_2
  L0_2 = memory
  L0_2 = L0_2.write_byte
  L1_2 = memory
  L1_2 = L1_2.script_global
  L2_2 = 296060
  L1_2 = L1_2(L2_2)
  L2_2 = 1
  L0_2(L1_2, L2_2)
  L0_2 = memory
  L0_2 = L0_2.write_byte
  L1_2 = memory
  L1_2 = L1_2.script_global
  L2_2 = 296061
  L1_2 = L1_2(L2_2)
  L2_2 = 1
  L0_2(L1_2, L2_2)
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "talk_opt"
L18_1 = _ENV
L19_1 = "menu"
L18_1 = L18_1[L19_1]
L19_1 = "list"
L18_1 = L18_1[L19_1]
L19_1 = _ENV
L20_1 = "Task_robbery"
L19_1 = L19_1[L20_1]
L20_1 = "对话选项"
L21_1 = {}
L22_1 = ""
L18_1 = L18_1(L19_1, L20_1, L21_1, L22_1)
L16_1[L17_1] = L18_1
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.action
L17_1 = _ENV
L18_1 = "talk_opt"
L17_1 = L17_1[L18_1]
L18_1 = "跳过一句NPC对话"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2
  L0_2 = AUDIO
  L0_2 = L0_2.SKIP_TO_NEXT_SCRIPTED_CONVERSATION_LINE
  L0_2()
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "talk_opt"
L17_1 = L17_1[L18_1]
L18_1 = "自动跳过NPC对话"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2
  L0_2 = AUDIO
  L0_2 = L0_2.IS_SCRIPTED_CONVERSATION_ONGOING
  L0_2 = L0_2()
  if L0_2 then
    L0_2 = AUDIO
    L0_2 = L0_2.STOP_SCRIPTED_CONVERSATION
    L1_2 = false
    L0_2(L1_2)
    L0_2 = AUDIO
    L0_2 = L0_2.SKIP_TO_NEXT_SCRIPTED_CONVERSATION_LINE
    L0_2()
  end
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "talk_opt"
L17_1 = L17_1[L18_1]
L18_1 = "自动跳过过场动画"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2
  L0_2 = CUTSCENE
  L0_2 = L0_2.IS_CUTSCENE_ACTIVE
  L0_2 = L0_2()
  if not L0_2 then
    L0_2 = CUTSCENE
    L0_2 = L0_2.IS_CUTSCENE_PLAYING
    L0_2 = L0_2()
    if not L0_2 then
      goto lbl_17
    end
  end
  L0_2 = CUTSCENE
  L0_2 = L0_2.STOP_CUTSCENE_IMMEDIATELY
  L0_2()
  L0_2 = CUTSCENE
  L0_2 = L0_2.REMOVE_CUTSCENE
  L0_2()
  ::lbl_17::
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "Task_robbery"
L17_1 = L17_1[L18_1]
L18_1 = "自动CEO/首领"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = util
  L0_2 = L0_2.is_session_started
  L0_2 = L0_2()
  if not L0_2 then
    return
  end
  L0_2 = pairs
  L1_2 = CEOLabels
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = IS_HELP_MSG_DISPLAYED
    L7_2 = L5_2
    L6_2 = L6_2(L7_2)
    if L6_2 then
      L6_2 = players
      L6_2 = L6_2.get_boss
      L7_2 = PLAYER
      L7_2 = L7_2.PLAYER_ID
      L7_2 = L7_2()
      L6_2 = L6_2(L7_2)
      if -1 == L6_2 then
        L6_2 = menu
        L6_2 = L6_2.trigger_commands
        L7_2 = "ceostart"
        L6_2(L7_2)
      end
      L6_2 = players
      L6_2 = L6_2.get_org_type
      L7_2 = PLAYER
      L7_2 = L7_2.PLAYER_ID
      L7_2 = L7_2()
      L6_2 = L6_2(L7_2)
      if 1 == L6_2 then
        L6_2 = menu
        L6_2 = L6_2.trigger_commands
        L7_2 = "ceotomc"
        L6_2(L7_2)
      end
      L6_2 = util
      L6_2 = L6_2.toast
      L7_2 = "看起来你需要成为一个CEO"
      L6_2(L7_2)
    end
  end
  L0_2 = pairs
  L1_2 = MCLabels
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = IS_HELP_MSG_DISPLAYED
    L7_2 = L5_2
    L6_2 = L6_2(L7_2)
    if L6_2 then
      L6_2 = players
      L6_2 = L6_2.get_boss
      L7_2 = PLAYER
      L7_2 = L7_2.PLAYER_ID
      L7_2 = L7_2()
      L6_2 = L6_2(L7_2)
      if -1 == L6_2 then
        L6_2 = menu
        L6_2 = L6_2.trigger_commands
        L7_2 = "mcstart"
        L6_2(L7_2)
      end
      L6_2 = players
      L6_2 = L6_2.get_org_type
      L7_2 = PLAYER
      L7_2 = L7_2.PLAYER_ID
      L7_2 = L7_2()
      L6_2 = L6_2(L7_2)
      if 0 == L6_2 then
        L6_2 = menu
        L6_2 = L6_2.trigger_commands
        L7_2 = "ceotomc"
        L6_2(L7_2)
      end
      L6_2 = util
      L6_2 = L6_2.toast
      L7_2 = "看起来你需要成为一个首领"
      L6_2(L7_2)
    end
  end
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "weaponsetting"
L18_1 = _ENV
L19_1 = "menu"
L18_1 = L18_1[L19_1]
L19_1 = "list"
L18_1 = L18_1[L19_1]
L19_1 = _ENV
L20_1 = "weapons"
L19_1 = L19_1[L20_1]
L20_1 = "武器设置"
L21_1 = {}
L22_1 = ""
L18_1 = L18_1(L19_1, L20_1, L21_1, L22_1)
L16_1[L17_1] = L18_1
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.action
L17_1 = _ENV
L18_1 = "weaponsetting"
L17_1 = L17_1[L18_1]
L18_1 = "补充弹夹弹药"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2
  L0_2 = WEAPON
  L0_2 = L0_2.REFILL_AMMO_INSTANTLY
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L0_2(L1_2)
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.action
L17_1 = _ENV
L18_1 = "weaponsetting"
L17_1 = L17_1[L18_1]
L18_1 = "补充所有弹药"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L0_2 = ipairs
  L1_2 = util
  L1_2 = L1_2.get_weapons
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L1_2()
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = WEAPON
    L6_2 = L6_2.SET_PED_AMMO
    L7_2 = PLAYER
    L7_2 = L7_2.PLAYER_PED_ID
    L7_2 = L7_2()
    L8_2 = L5_2.hash
    L9_2 = 9999
    L10_2 = false
    L6_2(L7_2, L8_2, L9_2, L10_2)
  end
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "weaponsetting"
L17_1 = L17_1[L18_1]
L18_1 = "锁定弹药数量"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
  L0_2 = PED
  L0_2 = L0_2.IS_PED_SHOOTING
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2, L4_2, L5_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2)
  if L0_2 then
    L0_2 = WEAPON
    L0_2 = L0_2.GET_SELECTED_PED_WEAPON
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_PED_ID
    L1_2, L2_2, L3_2, L4_2, L5_2 = L1_2()
    L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2)
    L1_2 = WEAPON
    L1_2 = L1_2.SET_PED_AMMO
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = L0_2
    L4_2 = 9999
    L5_2 = false
    L1_2(L2_2, L3_2, L4_2, L5_2)
    L1_2 = WEAPON
    L1_2 = L1_2.REFILL_AMMO_INSTANTLY
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2, L3_2, L4_2, L5_2 = L2_2()
    L1_2(L2_2, L3_2, L4_2, L5_2)
  end
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L17_1 = "click_slider"
L16_1 = L16_1[L17_1]
L17_1 = _ENV
L18_1 = "weaponsetting"
L17_1 = L17_1[L18_1]
L18_1 = "添加弹药"
L19_1 = {}
L20_1 = "添加指定武器弹药"
L21_1 = 1
L22_1 = 9999
L23_1 = 1
L24_1 = 20
function L25_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = WEAPON
  L1_2 = L1_2.GET_SELECTED_PED_WEAPON
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2, L3_2, L4_2, L5_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2)
  L2_2 = WEAPON
  L2_2 = L2_2.ADD_AMMO_TO_PED
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2 = L3_2()
  L4_2 = L1_2
  L5_2 = A0_2
  L2_2(L3_2, L4_2, L5_2)
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "weaponsetting"
L17_1 = L17_1[L18_1]
L18_1 = "无后坐力"
L19_1 = {}
L20_1 = "使用武器射击时不会抖动游戏画面."
function L21_1()
  local L0_2, L1_2
  L0_2 = gunpro
  L0_2()
end
function L22_1()
  local L0_2, L1_2
  L0_2 = resetWeapons
  L1_2 = modifiedRecoil
  L0_2(L1_2)
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1, L22_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "weaponsetting"
L17_1 = L17_1[L18_1]
L18_1 = "无限范围"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2
  L0_2 = maxrange
  L0_2()
end
function L22_1()
  local L0_2, L1_2
  L0_2 = endmaxrange
  L0_2()
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1, L22_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "weaponsetting"
L17_1 = L17_1[L18_1]
L18_1 = "无扩散"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2
  L0_2 = nospread
  L0_2()
end
function L22_1()
  local L0_2, L1_2
  L0_2 = resetWeapons
  L1_2 = modifiedSpread
  L0_2(L1_2)
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1, L22_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "weaponsetting"
L17_1 = L17_1[L18_1]
L18_1 = "移除前摇"
L19_1 = {}
L20_1 = "移除加特林和寡妇制造者的前摇."
function L21_1()
  local L0_2, L1_2
  L0_2 = nospinup
  L0_2()
end
function L22_1()
  local L0_2, L1_2
  L0_2 = endnospinup
  L0_2()
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1, L22_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "weaponsetting"
L17_1 = L17_1[L18_1]
L18_1 = "子弹伤害修改"
L19_1 = {}
L20_1 = "从正面射击载具时效果最佳.\n显示的值以百分比为单位."
function L21_1()
  local L0_2, L1_2
  L0_2 = damagemoded
  L0_2()
end
function L22_1()
  local L0_2, L1_2
  L0_2 = resetWeapons
  L1_2 = modifiedCarForce
  L0_2(L1_2)
  L0_2 = resetWeapons
  L1_2 = modifiedHeliForce
  L0_2(L1_2)
  L0_2 = resetWeapons
  L1_2 = modifiedPedForce
  L0_2(L1_2)
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1, L22_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L17_1 = "divider"
L16_1 = L16_1[L17_1]
L17_1 = _ENV
L18_1 = "weaponsetting"
L17_1 = L17_1[L18_1]
L18_1 = "瞄准视野"
L16_1(L17_1, L18_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "weaponsetting"
L17_1 = L17_1[L18_1]
L18_1 = "启用瞄准视野缩放"
L19_1 = {}
L20_1 = "让您在瞄准时修改视野大小."
function L21_1()
  local L0_2, L1_2
  L0_2 = gunzoom
  L0_2()
end
function L22_1()
  local L0_2, L1_2
  L0_2 = resetWeapons
  L1_2 = modifiedAimFov
  L0_2(L1_2)
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1, L22_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L17_1 = "divider"
L16_1 = L16_1[L17_1]
L17_1 = _ENV
L18_1 = "weaponsetting"
L17_1 = L17_1[L18_1]
L18_1 = "放大瞄准视野"
L16_1(L17_1, L18_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "weaponsetting"
L17_1 = L17_1[L18_1]
L18_1 = "启用放大瞄准视野缩放"
L19_1 = {}
L20_1 = "让您在瞄准放大时修改视野大小."
function L21_1()
  local L0_2, L1_2
  L0_2 = enablezoomfov
  L0_2()
end
function L22_1()
  local L0_2, L1_2
  L0_2 = resetWeapons
  L1_2 = modifiedZoomFov
  L0_2(L1_2)
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1, L22_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L17_1 = "slider_float"
L16_1 = L16_1[L17_1]
L17_1 = _ENV
L18_1 = "weaponsetting"
L17_1 = L17_1[L18_1]
L18_1 = "放大瞄准视野"
L19_1 = {}
L20_1 = "AimFov"
L19_1[1] = L20_1
L20_1 = ""
L21_1 = 100
L22_1 = 100000000
L23_1 = 100
L24_1 = 1
function L25_1(A0_2)
  local L1_2, L2_2
  L1_2 = zoomaimfov
  L2_2 = A0_2
  L1_2(L2_2)
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1)
L16_1 = _ENV
L17_1 = "weapon_save"
L18_1 = _ENV
L19_1 = "menu"
L18_1 = L18_1[L19_1]
L19_1 = "list"
L18_1 = L18_1[L19_1]
L19_1 = _ENV
L20_1 = "weapons"
L19_1 = L19_1[L20_1]
L20_1 = "武器编辑"
L21_1 = {}
L22_1 = ""
L18_1 = L18_1(L19_1, L20_1, L21_1, L22_1)
L16_1[L17_1] = L18_1
L16_1 = _ENV
L17_1 = "dofile"
L16_1 = L16_1[L17_1]
L17_1 = _ENV
L18_1 = "filesystem"
L17_1 = L17_1[L18_1]
L18_1 = "scripts_dir"
L17_1 = L17_1[L18_1]
L17_1 = L17_1()
L18_1 = "lib/daidailib/CustomWeapon/customweapon.lua"
L17_1 = L17_1 .. L18_1
L16_1(L17_1)
L16_1 = _ENV
L17_1 = "weapon_hud"
L18_1 = _ENV
L19_1 = "menu"
L18_1 = L18_1[L19_1]
L19_1 = "list"
L18_1 = L18_1[L19_1]
L19_1 = _ENV
L20_1 = "weapons"
L19_1 = L19_1[L20_1]
L20_1 = "武器HUD"
L21_1 = {}
L22_1 = ""
L18_1 = L18_1(L19_1, L20_1, L21_1, L22_1)
L16_1[L17_1] = L18_1
L16_1 = require
L17_1 = "lib.daidailib.WeaponHUD"
L16_1(L17_1)
L16_1 = _ENV
L17_1 = "special_weapons"
L18_1 = _ENV
L19_1 = "menu"
L18_1 = L18_1[L19_1]
L19_1 = "list"
L18_1 = L18_1[L19_1]
L19_1 = _ENV
L20_1 = "weapons"
L19_1 = L19_1[L20_1]
L20_1 = "特殊武器"
L21_1 = {}
L22_1 = ""
L18_1 = L18_1(L19_1, L20_1, L21_1, L22_1)
L16_1[L17_1] = L18_1
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle
L17_1 = _ENV
L18_1 = "special_weapons"
L17_1 = L17_1[L18_1]
L18_1 = "大锤"
L19_1 = {}
L20_1 = ""
function L21_1(A0_2)
  local L1_2, L2_2
  L1_2 = hammer
  L2_2 = A0_2
  L1_2(L2_2)
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle
L17_1 = _ENV
L18_1 = "special_weapons"
L17_1 = L17_1[L18_1]
L18_1 = "雷神锤"
L19_1 = {}
L20_1 = ""
function L21_1(A0_2)
  local L1_2, L2_2
  L1_2 = thunder_hammer
  L2_2 = A0_2
  L1_2(L2_2)
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle
L17_1 = _ENV
L18_1 = "special_weapons"
L17_1 = L17_1[L18_1]
L18_1 = "流星锤"
L19_1 = {}
L20_1 = ""
function L21_1(A0_2)
  local L1_2, L2_2
  L1_2 = meteorhammer
  L2_2 = A0_2
  L1_2(L2_2)
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle
L17_1 = _ENV
L18_1 = "special_weapons"
L17_1 = L17_1[L18_1]
L18_1 = "原子锤"
L19_1 = {}
L20_1 = ""
function L21_1(A0_2)
  local L1_2, L2_2
  L1_2 = atomhammer
  L2_2 = A0_2
  L1_2(L2_2)
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle
L17_1 = _ENV
L18_1 = "special_weapons"
L17_1 = L17_1[L18_1]
L18_1 = "小熊"
L19_1 = {}
L20_1 = ""
function L21_1(A0_2)
  local L1_2, L2_2
  L1_2 = bearhammer
  L2_2 = A0_2
  L1_2(L2_2)
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle
L17_1 = _ENV
L18_1 = "special_weapons"
L17_1 = L17_1[L18_1]
L18_1 = "独角兽"
L19_1 = {}
L20_1 = ""
function L21_1(A0_2)
  local L1_2, L2_2
  L1_2 = unicorn
  L2_2 = A0_2
  L1_2(L2_2)
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle
L17_1 = _ENV
L18_1 = "special_weapons"
L17_1 = L17_1[L18_1]
L18_1 = "太刀"
L19_1 = {}
L20_1 = ""
function L21_1(A0_2)
  local L1_2, L2_2
  L1_2 = knife
  L2_2 = A0_2
  L1_2(L2_2)
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "entity_control"
L18_1 = _ENV
L19_1 = "menu"
L18_1 = L18_1[L19_1]
L19_1 = "list"
L18_1 = L18_1[L19_1]
L19_1 = _ENV
L20_1 = "weapons"
L19_1 = L19_1[L20_1]
L20_1 = "实体控制枪"
L21_1 = {}
L22_1 = "控制你所瞄准的实体"
L18_1 = L18_1(L19_1, L20_1, L21_1, L22_1)
L16_1[L17_1] = L18_1
L16_1 = require
L17_1 = "lib.daidailib.Entity_control"
L16_1(L17_1)
L16_1 = _ENV
L17_1 = "weapon_fun"
L18_1 = _ENV
L19_1 = "menu"
L18_1 = L18_1[L19_1]
L19_1 = "list"
L18_1 = L18_1[L19_1]
L19_1 = _ENV
L20_1 = "weapons"
L19_1 = L19_1[L20_1]
L20_1 = "武器娱乐"
L21_1 = {}
L22_1 = ""
L18_1 = L18_1(L19_1, L20_1, L21_1, L22_1)
L16_1[L17_1] = L18_1
L16_1 = _ENV
L17_1 = "magnetic_gun"
L18_1 = _ENV
L19_1 = "menu"
L18_1 = L18_1[L19_1]
L19_1 = "list"
L18_1 = L18_1[L19_1]
L19_1 = _ENV
L20_1 = "weapon_fun"
L19_1 = L19_1[L20_1]
L20_1 = "磁力枪"
L21_1 = {}
L22_1 = ""
L18_1 = L18_1(L19_1, L20_1, L21_1, L22_1)
L16_1[L17_1] = L18_1
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "magnetic_gun"
L17_1 = L17_1[L18_1]
L18_1 = "磁力枪"
L19_1 = {}
L20_1 = "具有磁力的枪,可控制车辆去向"
function L21_1()
  local L0_2, L1_2
  L0_2 = ciliqiang
  L0_2()
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L17_1 = "list_select"
L16_1 = L16_1[L17_1]
L17_1 = _ENV
L18_1 = "magnetic_gun"
L17_1 = L17_1[L18_1]
L18_1 = "设置磁力枪"
L19_1 = {}
L20_1 = "选择后才生效"
L21_1 = {}
L22_1 = "平滑模式"
L23_1 = "混沌模式"
L21_1[1] = L22_1
L21_1[2] = L23_1
L22_1 = 1
function L23_1(A0_2)
  local L1_2, L2_2
  L1_2 = szclq
  L2_2 = A0_2
  L1_2(L2_2)
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "weapon_fun"
L17_1 = L17_1[L18_1]
L18_1 = "彩弹枪"
L19_1 = {}
L20_1 = "射击更改载具颜色"
function L21_1()
  local L0_2, L1_2
  L0_2 = Paintball_gun
  L0_2()
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "particle_gun_list"
L18_1 = _ENV
L19_1 = "menu"
L18_1 = L18_1[L19_1]
L19_1 = "list"
L18_1 = L18_1[L19_1]
L19_1 = _ENV
L20_1 = "weapon_fun"
L19_1 = L19_1[L20_1]
L20_1 = "粒子枪"
L21_1 = {}
L22_1 = ""
L18_1 = L18_1(L19_1, L20_1, L21_1, L22_1)
L16_1[L17_1] = L18_1
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "particle_gun_list"
L17_1 = L17_1[L18_1]
L18_1 = "粒子枪"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2
  L0_2 = particle_gun
  L0_2()
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L17_1 = "list_select"
L16_1 = L16_1[L17_1]
L17_1 = _ENV
L18_1 = "particle_gun_list"
L17_1 = L17_1[L18_1]
L18_1 = "设置粒子"
L19_1 = {}
L20_1 = "选择后才生效"
L21_1 = _ENV
L22_1 = "particle_gun_name"
L21_1 = L21_1[L22_1]
L22_1 = 1
function L23_1(A0_2)
  local L1_2, L2_2
  L1_2 = selete_particle_gun
  L2_2 = A0_2
  L1_2(L2_2)
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "weapon_fun"
L17_1 = L17_1[L18_1]
L18_1 = "端粒枪"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2
  L0_2 = Telomere_gun
  L0_2()
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "weapon_fun"
L17_1 = L17_1[L18_1]
L18_1 = "空袭枪"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2
  L0_2 = kxq
  L0_2()
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "weapon_fun"
L17_1 = L17_1[L18_1]
L18_1 = "传送枪"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2
  L0_2 = csq
  L0_2()
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "weapon_fun"
L17_1 = L17_1[L18_1]
L18_1 = "偷车枪"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2
  L0_2 = steal_car_gun
  L0_2()
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "weapon_fun"
L17_1 = L17_1[L18_1]
L18_1 = "死亡之眼"
L19_1 = {}
L20_1 = "当然,这对玩家无效"
function L21_1()
  local L0_2, L1_2
  L0_2 = dead_eye
  L0_2()
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "graffiti"
L18_1 = _ENV
L19_1 = "menu"
L18_1 = L18_1[L19_1]
L19_1 = "list"
L18_1 = L18_1[L19_1]
L19_1 = _ENV
L20_1 = "weapon_fun"
L19_1 = L19_1[L20_1]
L20_1 = "涂鸦枪"
L21_1 = {}
L22_1 = ""
L18_1 = L18_1(L19_1, L20_1, L21_1, L22_1)
L16_1[L17_1] = L18_1
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle
L17_1 = _ENV
L18_1 = "graffiti"
L17_1 = L17_1[L18_1]
L18_1 = "开启"
L19_1 = {}
L20_1 = ""
function L21_1(A0_2)
  local L1_2, L2_2
  L1_2 = Graffiti_weapon
  L2_2 = A0_2
  L1_2(L2_2)
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.slider
L17_1 = _ENV
L18_1 = "graffiti"
L17_1 = L17_1[L18_1]
L18_1 = "亮度"
L19_1 = {}
L20_1 = "graffitiness"
L19_1[1] = L20_1
L20_1 = "光亮强度."
L21_1 = 0
L22_1 = 1000
L23_1 = 100
L24_1 = 10
function L25_1(A0_2)
  local L1_2, L2_2
  L1_2 = graffiti_bright
  L2_2 = A0_2
  L1_2(L2_2)
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.slider
L17_1 = _ENV
L18_1 = "graffiti"
L17_1 = L17_1[L18_1]
L18_1 = "半径"
L19_1 = {}
L20_1 = "graffitiradius"
L19_1[1] = L20_1
L20_1 = "光束半径."
L21_1 = 0
L22_1 = 20
L23_1 = 5
L24_1 = 1
function L25_1(A0_2)
  local L1_2, L2_2
  L1_2 = graffiti_radiu
  L2_2 = A0_2
  L1_2(L2_2)
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.rainbow
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.colour
L18_1 = _ENV
L19_1 = "graffiti"
L18_1 = L18_1[L19_1]
L19_1 = "颜色"
L20_1 = {}
L21_1 = "graffiticolour"
L20_1[1] = L21_1
L21_1 = ""
L22_1 = {}
L23_1 = "r"
L24_1 = 0
L22_1[L23_1] = L24_1
L23_1 = "g"
L24_1 = 0
L22_1[L23_1] = L24_1
L23_1 = "b"
L24_1 = 1
L22_1[L23_1] = L24_1
L23_1 = "a"
L24_1 = 0
L22_1[L23_1] = L24_1
L23_1 = true
function L24_1(A0_2)
  local L1_2, L2_2
  L1_2 = graffiti_color
  L2_2 = A0_2
  L1_2(L2_2)
end
L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1 = L17_1(L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1)
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "weapon_fun"
L17_1 = L17_1[L18_1]
L18_1 = "目标靶"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
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
    L2_2, L3_2, L4_2 = L2_2()
    L1_2 = L1_2(L2_2, L3_2, L4_2)
    if not L1_2 then
      L1_2 = create_shooting_target
      L2_2 = L0_2.x
      L3_2 = L0_2.y
      L4_2 = L0_2.z
      L1_2(L2_2, L3_2, L4_2)
    end
  end
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "weapon_fun"
L17_1 = L17_1[L18_1]
L18_1 = "喷火枪"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
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
    L1_2 = FIRE
    L1_2 = L1_2.ADD_EXPLOSION
    L2_2 = L0_2.x
    L3_2 = L0_2.y
    L4_2 = L0_2.z
    L5_2 = 12
    L6_2 = 1
    L7_2 = true
    L8_2 = false
    L9_2 = 0
    L10_2 = false
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  end
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "weapon_fun"
L17_1 = L17_1[L18_1]
L18_1 = "喷水枪"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
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
    L1_2 = FIRE
    L1_2 = L1_2.ADD_EXPLOSION
    L2_2 = L0_2.x
    L3_2 = L0_2.y
    L4_2 = L0_2.z
    L5_2 = 13
    L6_2 = 1
    L7_2 = true
    L8_2 = false
    L9_2 = 0
    L10_2 = false
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  end
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "weapon_fun"
L17_1 = L17_1[L18_1]
L18_1 = "手办枪"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
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
    L1_2 = create_ambient_pickup
    L2_2 = L0_2.x
    L3_2 = L0_2.y
    L4_2 = L0_2.z
    L5_2 = -1009939663
    L6_2 = MISC
    L6_2 = L6_2.GET_HASH_KEY
    L7_2 = "vw_prop_vw_colle_prbubble"
    L6_2, L7_2 = L6_2(L7_2)
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
  end
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "weapon_fun"
L17_1 = L17_1[L18_1]
L18_1 = "卡片枪"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
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
    L1_2 = create_ambient_pickup
    L2_2 = L0_2.x
    L3_2 = L0_2.y
    L4_2 = L0_2.z
    L5_2 = -1009939663
    L6_2 = 3030532197
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
  end
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "weapon_fun"
L17_1 = L17_1[L18_1]
L18_1 = "粑粑枪"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
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
    L1_2 = create_object
    L2_2 = -2071359746
    L3_2 = L0_2.x
    L4_2 = L0_2.y
    L5_2 = L0_2.z
    L1_2(L2_2, L3_2, L4_2, L5_2)
  end
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "weapon_fun"
L17_1 = L17_1[L18_1]
L18_1 = "陨石枪"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
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
    L1_2 = create_object
    L2_2 = 3751297495
    L3_2 = L0_2.x
    L4_2 = L0_2.y
    L5_2 = L0_2.z
    L1_2(L2_2, L3_2, L4_2, L5_2)
  end
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "weapon_fun"
L17_1 = L17_1[L18_1]
L18_1 = "神风炮"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2
  L0_2 = Kamikaze_Gun
  L0_2()
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "weapon_fun"
L17_1 = L17_1[L18_1]
L18_1 = "烟花枪"
L19_1 = {}
L20_1 = "拿着烟花发射器时将发射自定义载具烟花"
function L21_1()
  local L0_2, L1_2
  L0_2 = Firework_Gun
  L0_2()
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "weapon_fun"
L17_1 = L17_1[L18_1]
L18_1 = "抓钩枪"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2
  L0_2 = grappling_gun
  L0_2()
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "weapon_fun"
L17_1 = L17_1[L18_1]
L18_1 = "鲨鱼枪"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2
  L0_2 = Shark_gun
  L0_2()
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "weapon_fun"
L17_1 = L17_1[L18_1]
L18_1 = "实体引力"
L19_1 = {}
L20_1 = "射击两个实体以让它们互相吸引"
function L21_1()
  local L0_2, L1_2
  L0_2 = ctst
  L0_2()
end
function L22_1()
  local L0_2, L1_2
  L0_2 = ctst_stop
  L0_2()
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1, L22_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle
L17_1 = _ENV
L18_1 = "weapon_fun"
L17_1 = L17_1[L18_1]
L18_1 = "RPG自动瞄准器"
L19_1 = {}
L20_1 = "发射后自动追踪视野内玩家"
function L21_1(A0_2)
  local L1_2, L2_2
  L1_2 = RPG_Automatic_sight
  L2_2 = A0_2
  L1_2(L2_2)
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "nuclear_weapon"
L18_1 = _ENV
L19_1 = "menu"
L18_1 = L18_1[L19_1]
L19_1 = "list"
L18_1 = L18_1[L19_1]
L19_1 = _ENV
L20_1 = "weapon_fun"
L19_1 = L19_1[L20_1]
L20_1 = "核武器"
L21_1 = {}
L22_1 = ""
L18_1 = L18_1(L19_1, L20_1, L21_1, L22_1)
L16_1[L17_1] = L18_1
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "nuclear_weapon"
L17_1 = L17_1[L18_1]
L18_1 = "天基炮"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2
  L0_2 = nuclear_weapon1
  L0_2()
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "nuclear_weapon"
L17_1 = L17_1[L18_1]
L18_1 = "核弹枪"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2
  L0_2 = nukegunmode
  L0_2()
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "nuclear_weapon"
L17_1 = L17_1[L18_1]
L18_1 = "超级核弹"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2
  L0_2 = nuclear_weapon2
  L0_2()
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "weapon_fun"
L17_1 = L17_1[L18_1]
L18_1 = "推进载具"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = PED
  L0_2 = L0_2.IS_PED_SHOOTING
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2)
  if L0_2 then
    L0_2 = get_entity_player_is_aiming_at
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_ID
    L1_2, L2_2, L3_2 = L1_2()
    L0_2 = L0_2(L1_2, L2_2, L3_2)
    if 0 ~= L0_2 then
      L1_2 = ENTITY
      L1_2 = L1_2.IS_ENTITY_A_VEHICLE
      L2_2 = L0_2
      L1_2 = L1_2(L2_2)
      if L1_2 then
        L1_2 = VEHICLE
        L1_2 = L1_2.SET_VEHICLE_FORWARD_SPEED
        L2_2 = L0_2
        L3_2 = 100
        L1_2(L2_2, L3_2)
      end
    end
  end
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "weapon_fun"
L17_1 = L17_1[L18_1]
L18_1 = "冻结实体"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = PED
  L0_2 = L0_2.IS_PED_SHOOTING
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2)
  if L0_2 then
    L0_2 = get_entity_player_is_aiming_at
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_ID
    L1_2, L2_2, L3_2 = L1_2()
    L0_2 = L0_2(L1_2, L2_2, L3_2)
    if 0 ~= L0_2 then
      L1_2 = ENTITY
      L1_2 = L1_2.FREEZE_ENTITY_POSITION
      L2_2 = L0_2
      L3_2 = true
      L1_2(L2_2, L3_2)
    end
  end
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "weapon_fun"
L17_1 = L17_1[L18_1]
L18_1 = "转魂枪"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2
  L0_2 = Soul_Gun
  L0_2()
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "entity_gun"
L18_1 = _ENV
L19_1 = "menu"
L18_1 = L18_1[L19_1]
L19_1 = "list"
L18_1 = L18_1[L19_1]
L19_1 = _ENV
L20_1 = "weapon_fun"
L19_1 = L19_1[L20_1]
L20_1 = "实体枪"
L21_1 = {}
L22_1 = ""
L18_1 = L18_1(L19_1, L20_1, L21_1, L22_1)
L16_1[L17_1] = L18_1
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "entity_gun"
L17_1 = L17_1[L18_1]
L18_1 = "重力实体枪"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2
  L0_2 = eentity_gun
  L0_2()
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L17_1 = "list_select"
L16_1 = L16_1[L17_1]
L17_1 = _ENV
L18_1 = "entity_gun"
L17_1 = L17_1[L18_1]
L18_1 = "选择实体"
L19_1 = {}
L20_1 = "选择重力实体枪的模型"
L21_1 = _ENV
L22_1 = "entity_options"
L21_1 = L21_1[L22_1]
L22_1 = 1
function L23_1(A0_2)
  local L1_2
  L1_2 = entity_hashes
  L1_2 = L1_2[A0_2]
  shootent = L1_2
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "entity_gun"
L17_1 = L17_1[L18_1]
L18_1 = "实体枪"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2
  L0_2 = minecraftgun
  L0_2()
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "attach_entity_fun"
L18_1 = _ENV
L19_1 = "menu"
L18_1 = L18_1[L19_1]
L19_1 = "list"
L18_1 = L18_1[L19_1]
L19_1 = _ENV
L20_1 = "weapon_fun"
L19_1 = L19_1[L20_1]
L20_1 = "实体附加枪"
L21_1 = {}
L22_1 = ""
L18_1 = L18_1(L19_1, L20_1, L21_1, L22_1)
L16_1[L17_1] = L18_1
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "attach_entity_fun"
L17_1 = L17_1[L18_1]
L18_1 = "开启"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2
  L0_2 = attach_entity_gun
  L0_2()
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L17_1 = "list_select"
L16_1 = L16_1[L17_1]
L17_1 = _ENV
L18_1 = "attach_entity_fun"
L17_1 = L17_1[L18_1]
L18_1 = "选择实体"
L19_1 = {}
L20_1 = ""
L21_1 = _ENV
L22_1 = "Objn"
L21_1 = L21_1[L22_1]
L22_1 = 1
function L23_1(A0_2)
  local L1_2, L2_2
  L1_2 = selete_attach_entity_gun
  L2_2 = A0_2
  L1_2(L2_2)
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.action
L17_1 = _ENV
L18_1 = "weapon_fun"
L17_1 = L17_1[L18_1]
L18_1 = "发射引导导弹"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2
  L0_2 = L0_1.exists
  L0_2 = L0_2()
  if not L0_2 then
    L0_2 = L1_1.create
    L0_2()
  end
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle
L17_1 = _ENV
L18_1 = "weapon_fun"
L17_1 = L17_1[L18_1]
L18_1 = "背藏武器"
L19_1 = {}
L20_1 = "按Tab键"
function L21_1(A0_2)
  local L1_2, L2_2
  L1_2 = Back_weapons
  L2_2 = A0_2
  L1_2(L2_2)
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "vehicleGun"
L18_1 = _ENV
L19_1 = "menu"
L18_1 = L18_1[L19_1]
L19_1 = "list"
L18_1 = L18_1[L19_1]
L19_1 = _ENV
L20_1 = "weapon_fun"
L19_1 = L19_1[L20_1]
L20_1 = "载具枪"
L21_1 = {}
L22_1 = ""
L18_1 = L18_1(L19_1, L20_1, L21_1, L22_1)
L16_1[L17_1] = L18_1
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "vehicleGun"
L17_1 = L17_1[L18_1]
L18_1 = "开启"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2
  L0_2 = Vehicle_gun
  L0_2()
end
function L22_1()
  local L0_2, L1_2
  L0_2 = Vehicle_gun_stop
  L0_2()
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1, L22_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L17_1 = "list_select"
L16_1 = L16_1[L17_1]
L17_1 = _ENV
L18_1 = "vehicleGun"
L17_1 = L17_1[L18_1]
L18_1 = "选择载具"
L19_1 = {}
L20_1 = ""
L21_1 = _ENV
L22_1 = "Objoptions_all"
L21_1 = L21_1[L22_1]
L22_1 = 1
function L23_1(A0_2)
  local L1_2, L2_2
  L1_2 = Vehicle_gun_opt
  L2_2 = A0_2
  L1_2(L2_2)
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle
L17_1 = _ENV
L18_1 = "vehicleGun"
L17_1 = L17_1[L18_1]
L18_1 = "进入车辆"
L19_1 = {}
L20_1 = ""
function L21_1(A0_2)
  local L1_2, L2_2
  L1_2 = Vehicle_gun_into
  L2_2 = A0_2
  L1_2(L2_2)
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle
L17_1 = _ENV
L18_1 = "weapon_fun"
L17_1 = L17_1[L18_1]
L18_1 = "女武神导弹"
L19_1 = {}
L20_1 = ""
function L21_1(A0_2)
  local L1_2, L2_2
  L1_2 = nvwushen
  L2_2 = A0_2
  L1_2(L2_2)
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "silent_aimbotroot"
L18_1 = _ENV
L19_1 = "menu"
L18_1 = L18_1[L19_1]
L19_1 = "list"
L18_1 = L18_1[L19_1]
L19_1 = _ENV
L20_1 = "weapons"
L19_1 = L19_1[L20_1]
L20_1 = "武器自瞄"
L21_1 = {}
L22_1 = ""
L18_1 = L18_1(L19_1, L20_1, L21_1, L22_1)
L16_1[L17_1] = L18_1
L16_1 = require
L17_1 = "lib.daidailib.Aimbot"
L16_1(L17_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "weapons"
L17_1 = L17_1[L18_1]
L18_1 = "双发"
L19_1 = {}
L20_1 = "在同一时间内射出两枪"
function L21_1()
  local L0_2, L1_2
  L0_2 = PED
  L0_2 = L0_2.IS_PED_SHOOTING
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L0_2 = L0_2(L1_2)
  if L0_2 then
    L0_2 = PED
    L0_2 = L0_2.FORCE_PED_AI_AND_ANIMATION_UPDATE
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_PED_ID
    L1_2 = L1_2()
    L0_2(L1_2)
  end
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "weapons"
L17_1 = L17_1[L18_1]
L18_1 = "导弹雷达"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2
  L0_2 = Missile_radar
  L0_2()
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "weapons"
L17_1 = L17_1[L18_1]
L18_1 = "近战爆炸"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L0_2 = v3
  L0_2 = L0_2.new
  L0_2 = L0_2()
  L1_2 = WEAPON
  L1_2 = L1_2.GET_SELECTED_PED_WEAPON
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  if -1569615261 == L1_2 then
    L1_2 = WEAPON
    L1_2 = L1_2.GET_PED_LAST_WEAPON_IMPACT_COORD
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = L0_2
    L1_2 = L1_2(L2_2, L3_2)
    if L1_2 then
      L1_2 = FIRE
      L1_2 = L1_2.ADD_EXPLOSION
      L2_2 = L0_2.x
      L3_2 = L0_2.y
      L4_2 = L0_2.z
      L5_2 = 18
      L6_2 = 100
      L7_2 = true
      L8_2 = false
      L9_2 = 0
      L10_2 = false
      L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
    end
  end
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "weapons"
L17_1 = L17_1[L18_1]
L18_1 = "瞄准信息"
L19_1 = {}
L20_1 = "显示您瞄准的实体的信息"
function L21_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L0_2 = get_entity_player_is_aiming_at
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L1_2 = get_entity_info
  L2_2 = L0_2
  L1_2 = L1_2(L2_2)
  if 0 ~= L1_2 then
    L2_2 = "哈希: "
    L3_2 = L1_2.hash
    L4_2 = "\n生命值: "
    L5_2 = L1_2.health
    L6_2 = "\n类型: "
    L7_2 = L1_2.type_name
    L8_2 = "\n速度: "
    L9_2 = L1_2.speed
    L2_2 = L2_2 .. L3_2 .. L4_2 .. L5_2 .. L6_2 .. L7_2 .. L8_2 .. L9_2
    L3_2 = directx
    L3_2 = L3_2.draw_text
    L4_2 = 0.5
    L5_2 = 0.3
    L6_2 = L2_2
    L7_2 = 5
    L8_2 = 0.5
    L9_2 = {}
    L9_2.r = 1
    L9_2.g = 1
    L9_2.b = 1
    L9_2.a = 1
    L10_2 = true
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  end
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "crosshair"
L18_1 = _ENV
L19_1 = "menu"
L18_1 = L18_1[L19_1]
L19_1 = "list"
L18_1 = L18_1[L19_1]
L19_1 = _ENV
L20_1 = "weapons"
L19_1 = L19_1[L20_1]
L20_1 = "准星"
L21_1 = {}
L22_1 = ""
L18_1 = L18_1(L19_1, L20_1, L21_1, L22_1)
L16_1[L17_1] = L18_1
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "crosshair"
L17_1 = L17_1[L18_1]
L18_1 = "瞄准准星 (^)"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2
  L0_2 = front_sight
  L1_2 = "^"
  L0_2(L1_2)
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "crosshair"
L17_1 = L17_1[L18_1]
L18_1 = "瞄准准星 (*)"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2
  L0_2 = front_sight
  L1_2 = "*"
  L0_2(L1_2)
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "crosshair"
L17_1 = L17_1[L18_1]
L18_1 = "瞄准准星 (+)"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2
  L0_2 = front_sight
  L1_2 = "+"
  L0_2(L1_2)
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "crosshair"
L17_1 = L17_1[L18_1]
L18_1 = "瞄准准星 (·)"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2
  L0_2 = front_sight
  L1_2 = "·"
  L0_2(L1_2)
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L17_1 = "slider_float"
L16_1 = L16_1[L17_1]
L17_1 = _ENV
L18_1 = "weapons"
L17_1 = L17_1[L18_1]
L18_1 = "近战伤害修改"
L19_1 = {}
L20_1 = "meleedamage"
L19_1[1] = L20_1
L20_1 = ""
L21_1 = 100
L22_1 = 1000
L23_1 = 100
L24_1 = 10
function L25_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = PLAYER
  L1_2 = L1_2.SET_PLAYER_MELEE_WEAPON_DAMAGE_MODIFIER
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_ID
  L2_2 = L2_2()
  L3_2 = A0_2 / 100
  L1_2(L2_2, L3_2)
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "weapons"
L17_1 = L17_1[L18_1]
L18_1 = "无爆炸物"
L19_1 = {}
L20_1 = "移除玩家所有爆炸性弹药,甚至是火箭弹"
function L21_1()
  local L0_2, L1_2
  L0_2 = remove_explosive
  L0_2()
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "weapons"
L17_1 = L17_1[L18_1]
L18_1 = "随机武器色调"
L19_1 = {}
L20_1 = ""
function L21_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = WEAPON
  L1_2 = L1_2.GET_PED_WEAPON_TINT_INDEX
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = WEAPON
  L3_2 = L3_2.GET_SELECTED_PED_WEAPON
  L4_2 = PLAYER
  L4_2 = L4_2.PLAYER_PED_ID
  L4_2, L5_2, L6_2, L7_2 = L4_2()
  L3_2, L4_2, L5_2, L6_2, L7_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = WEAPON
  L2_2 = L2_2.SET_PED_WEAPON_TINT_INDEX
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2 = L3_2()
  L4_2 = WEAPON
  L4_2 = L4_2.GET_SELECTED_PED_WEAPON
  L5_2 = PLAYER
  L5_2 = L5_2.PLAYER_PED_ID
  L5_2, L6_2, L7_2 = L5_2()
  L4_2 = L4_2(L5_2, L6_2, L7_2)
  L5_2 = math
  L5_2 = L5_2.random
  L6_2 = 0
  L7_2 = 7
  L5_2, L6_2, L7_2 = L5_2(L6_2, L7_2)
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "damage_numbers_list"
L18_1 = _ENV
L19_1 = "menu"
L18_1 = L18_1[L19_1]
L19_1 = "list"
L18_1 = L18_1[L19_1]
L19_1 = _ENV
L20_1 = "weapons"
L19_1 = L19_1[L20_1]
L20_1 = "伤害数字"
L18_1 = L18_1(L19_1, L20_1)
L16_1[L17_1] = L18_1
L16_1 = require
L17_1 = "lib.daidailib.damage_numbers"
L16_1(L17_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "weapons"
L17_1 = L17_1[L18_1]
L18_1 = "踢出枪"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
  L0_2 = get_entity_player_is_aiming_at
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2, L2_2, L3_2, L4_2, L5_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2)
  L1_2 = PED
  L1_2 = L1_2.IS_PED_SHOOTING
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2, L3_2, L4_2, L5_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2)
  if L1_2 then
    L1_2 = PED
    L1_2 = L1_2.IS_PED_A_PLAYER
    L2_2 = L0_2
    L1_2 = L1_2(L2_2)
    if L1_2 then
      L1_2 = NETWORK
      L1_2 = L1_2.NETWORK_GET_PLAYER_INDEX_FROM_PED
      L2_2 = L0_2
      L1_2 = L1_2(L2_2)
      L2_2 = players
      L2_2 = L2_2.get_host
      L2_2 = L2_2()
      if L2_2 == L1_2 then
        L2_2 = util
        L2_2 = L2_2.toast
        L3_2 = "您正试图踢出的玩家是主机"
        L2_2(L3_2)
        return
      end
      L2_2 = menu
      L2_2 = L2_2.trigger_commands
      L3_2 = "kick"
      L4_2 = players
      L4_2 = L4_2.get_name
      L5_2 = L1_2
      L4_2 = L4_2(L5_2)
      L3_2 = L3_2 .. L4_2
      L2_2(L3_2)
    end
  end
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "weapons"
L17_1 = L17_1[L18_1]
L18_1 = "崩溃枪"
L19_1 = {}
L20_1 = ""
function L21_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
  L0_2 = get_entity_player_is_aiming_at
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2, L2_2, L3_2, L4_2, L5_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2)
  L1_2 = PED
  L1_2 = L1_2.IS_PED_SHOOTING
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2, L3_2, L4_2, L5_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2)
  if L1_2 then
    L1_2 = PED
    L1_2 = L1_2.IS_PED_A_PLAYER
    L2_2 = L0_2
    L1_2 = L1_2(L2_2)
    if L1_2 then
      L1_2 = NETWORK
      L1_2 = L1_2.NETWORK_GET_PLAYER_INDEX_FROM_PED
      L2_2 = L0_2
      L1_2 = L1_2(L2_2)
      L2_2 = menu
      L2_2 = L2_2.trigger_commands
      L3_2 = "crash"
      L4_2 = players
      L4_2 = L4_2.get_name
      L5_2 = L1_2
      L4_2 = L4_2(L5_2)
      L3_2 = L3_2 .. L4_2
      L2_2(L3_2)
    end
  end
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = _ENV
L17_1 = "sticky_bomb_explosion"
L18_1 = _ENV
L19_1 = "menu"
L18_1 = L18_1[L19_1]
L19_1 = "list"
L18_1 = L18_1[L19_1]
L19_1 = _ENV
L20_1 = "weapons"
L19_1 = L19_1[L20_1]
L20_1 = "粘弹自动爆炸"
L21_1 = {}
L22_1 = ""
L18_1 = L18_1(L19_1, L20_1, L21_1, L22_1)
L16_1[L17_1] = L18_1
L16_1 = _ENV
L17_1 = "menu"
L16_1 = L16_1[L17_1]
L16_1 = L16_1.toggle_loop
L17_1 = _ENV
L18_1 = "sticky_bomb_explosion"
L17_1 = L17_1[L18_1]
L18_1 = "粘弹自动爆炸"
L19_1 = {}
L20_1 = "使您的粘弹在玩家或NPC附近时自动引爆."
function L21_1()
  local L0_2, L1_2
  L0_2 = proxyStickys
  L0_2()
end
L16_1(L17_1, L18_1, L19_1, L20_1, L21_1)
L16_1 = true
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle
L18_1 = _ENV
L19_1 = "sticky_bomb_explosion"
L18_1 = L18_1[L19_1]
L19_1 = "引爆附近的玩家"
L20_1 = {}
L21_1 = ""
function L22_1(A0_2)
  local L1_2
  L16_1 = A0_2
end
L23_1 = true
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1, L23_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle
L18_1 = _ENV
L19_1 = "sticky_bomb_explosion"
L18_1 = L18_1[L19_1]
L19_1 = "引爆附近的NPC"
L20_1 = {}
L21_1 = ""
function L22_1(A0_2)
  local L1_2
  detonate_npcs = A0_2
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.slider
L18_1 = _ENV
L19_1 = "sticky_bomb_explosion"
L18_1 = L18_1[L19_1]
L19_1 = "触发半径"
L20_1 = {}
L21_1 = ""
L22_1 = 1
L23_1 = 10
L24_1 = 2
L25_1 = 1
function L26_1(A0_2)
  local L1_2
  detonate_radius = A0_2
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "sticky_bomb_explosion"
L18_1 = L18_1[L19_1]
L19_1 = "移除所有粘性炸弹"
L20_1 = {}
L21_1 = "移除所有存在的粘性炸弹"
function L22_1()
  local L0_2, L1_2, L2_2
  L0_2 = WEAPON
  L0_2 = L0_2.REMOVE_ALL_PROJECTILES_OF_TYPE
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "weapon_stickybomb"
  L1_2, L2_2 = L1_2(L2_2)
  L0_2(L1_2, L2_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle
L18_1 = _ENV
L19_1 = "weapons"
L18_1 = L18_1[L19_1]
L19_1 = "隐形武器"
L20_1 = {}
L21_1 = "换枪后失效"
function L22_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = WEAPON
  L1_2 = L1_2.SET_PED_CURRENT_WEAPON_VISIBLE
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = not A0_2
  L4_2 = false
  L5_2 = false
  L6_2 = false
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "weapon_thing"
L19_1 = _ENV
L20_1 = "menu"
L19_1 = L19_1[L20_1]
L20_1 = "list"
L19_1 = L19_1[L20_1]
L20_1 = _ENV
L21_1 = "weapons"
L20_1 = L20_1[L21_1]
L21_1 = "更改子弹"
L22_1 = {}
L23_1 = ""
L19_1 = L19_1(L20_1, L21_1, L22_1, L23_1)
L17_1[L18_1] = L19_1
L17_1 = _ENV
L18_1 = "zidanleixing"
L17_1 = L17_1[L18_1]
L17_1()
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.list_action
L18_1 = _ENV
L19_1 = "weapons"
L18_1 = L18_1[L19_1]
L19_1 = "更改弹药效果"
L20_1 = {}
L21_1 = ""
L22_1 = _ENV
L23_1 = "explosion_names"
L22_1 = L22_1[L23_1]
function L23_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = change_ammo_effect
  L2_2 = A0_2
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_ID
  L3_2 = L3_2()
  L1_2(L2_2, L3_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1, L23_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle_loop
L18_1 = _ENV
L19_1 = "weapons"
L18_1 = L18_1[L19_1]
L19_1 = "快速更换武器"
L20_1 = {}
L21_1 = "武器更换速度更快."
function L22_1()
  local L0_2, L1_2, L2_2
  L0_2 = TASK
  L0_2 = L0_2.GET_IS_TASK_ACTIVE
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = 56
  L0_2 = L0_2(L1_2, L2_2)
  if L0_2 then
    L0_2 = PED
    L0_2 = L0_2.FORCE_PED_AI_AND_ANIMATION_UPDATE
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_PED_ID
    L1_2, L2_2 = L1_2()
    L0_2(L1_2, L2_2)
  end
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle_loop
L18_1 = _ENV
L19_1 = "weapons"
L18_1 = L18_1[L19_1]
L19_1 = "热成像枪"
L20_1 = {}
L21_1 = "当您瞄准时按\"E\"可以启用热成像功能."
function L22_1()
  local L0_2, L1_2
  L0_2 = thermalgun
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle_loop
L18_1 = _ENV
L19_1 = "weapons"
L18_1 = L18_1[L19_1]
L19_1 = "快速热成像"
L20_1 = {}
L21_1 = "更快地在热成像之间进行切换."
function L22_1()
  local L0_2, L1_2, L2_2
  L0_2 = TASK
  L0_2 = L0_2.GET_IS_TASK_ACTIVE
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = 92
  L0_2 = L0_2(L1_2, L2_2)
  if L0_2 then
    L0_2 = PED
    L0_2 = L0_2.FORCE_PED_AI_AND_ANIMATION_UPDATE
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_PED_ID
    L1_2, L2_2 = L1_2()
    L0_2(L1_2, L2_2)
  end
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle_loop
L18_1 = _ENV
L19_1 = "weapons"
L18_1 = L18_1[L19_1]
L19_1 = "快速近战"
L20_1 = {}
L21_1 = "近战速度更快."
function L22_1()
  local L0_2, L1_2, L2_2
  L0_2 = TASK
  L0_2 = L0_2.GET_IS_TASK_ACTIVE
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = 130
  L0_2 = L0_2(L1_2, L2_2)
  if L0_2 then
    L0_2 = PED
    L0_2 = L0_2.FORCE_PED_AI_AND_ANIMATION_UPDATE
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_PED_ID
    L1_2, L2_2 = L1_2()
    L0_2(L1_2, L2_2)
  end
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle_loop
L18_1 = _ENV
L19_1 = "weapons"
L18_1 = L18_1[L19_1]
L19_1 = "NPC枪"
L20_1 = {}
L21_1 = "随机射出NPC"
function L22_1()
  local L0_2, L1_2
  L0_2 = shechuNPC
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle_loop
L18_1 = _ENV
L19_1 = "weapons"
L18_1 = L18_1[L19_1]
L19_1 = "喷火器"
L20_1 = {}
L21_1 = "将加特林改为喷火枪"
function L22_1()
  local L0_2, L1_2
  L0_2 = flamegun
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle
L18_1 = _ENV
L19_1 = "weapons"
L18_1 = L18_1[L19_1]
L19_1 = "允许射击队友"
L20_1 = {}
L21_1 = "使你在游戏中能够射击队友"
function L22_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = PED
  L1_2 = L1_2.SET_CAN_ATTACK_FRIENDLY
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = A0_2
  L4_2 = false
  L1_2(L2_2, L3_2, L4_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "shooting_effects"
L19_1 = _ENV
L20_1 = "menu"
L19_1 = L19_1[L20_1]
L20_1 = "list"
L19_1 = L19_1[L20_1]
L20_1 = _ENV
L21_1 = "weapons"
L20_1 = L20_1[L21_1]
L21_1 = "射击特效"
L22_1 = {}
L23_1 = ""
L19_1 = L19_1(L20_1, L21_1, L22_1, L23_1)
L17_1[L18_1] = L19_1
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle_loop
L18_1 = _ENV
L19_1 = "shooting_effects"
L18_1 = L18_1[L19_1]
L19_1 = "射击效果"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2
  L0_2 = Shoot_effect
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L18_1 = "list_select"
L17_1 = L17_1[L18_1]
L18_1 = _ENV
L19_1 = "shooting_effects"
L18_1 = L18_1[L19_1]
L19_1 = "设置效果"
L20_1 = {}
L21_1 = ""
L22_1 = _ENV
L23_1 = "Shoot_effect_options"
L22_1 = L22_1[L23_1]
L23_1 = 1
function L24_1(A0_2)
  local L1_2, L2_2
  L1_2 = Shoot_effect_option
  L2_2 = A0_2
  L1_2(L2_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1)
L17_1 = _ENV
L18_1 = "hitEffectRoot"
L19_1 = _ENV
L20_1 = "menu"
L19_1 = L19_1[L20_1]
L20_1 = "list"
L19_1 = L19_1[L20_1]
L20_1 = _ENV
L21_1 = "weapons"
L20_1 = L20_1[L21_1]
L21_1 = "命中效果"
L22_1 = {}
L23_1 = ""
L19_1 = L19_1(L20_1, L21_1, L22_1, L23_1)
L17_1[L18_1] = L19_1
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle_loop
L18_1 = _ENV
L19_1 = "hitEffectRoot"
L18_1 = L18_1[L19_1]
L19_1 = "开启效果"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2
  L0_2 = Hit_effect
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L18_1 = "list_select"
L17_1 = L17_1[L18_1]
L18_1 = _ENV
L19_1 = "hitEffectRoot"
L18_1 = L18_1[L19_1]
L19_1 = "设置效果"
L20_1 = {}
L21_1 = ""
L22_1 = _ENV
L23_1 = "hit_effect_options"
L22_1 = L22_1[L23_1]
L23_1 = 1
function L24_1(A0_2)
  local L1_2, L2_2
  L1_2 = hit_effect_option
  L2_2 = A0_2
  L1_2(L2_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1)
L17_1 = _ENV
L18_1 = "hit_menuColour"
L19_1 = _ENV
L20_1 = "menu"
L19_1 = L19_1[L20_1]
L19_1 = L19_1.colour
L20_1 = _ENV
L21_1 = "hitEffectRoot"
L20_1 = L20_1[L21_1]
L21_1 = "设置颜色"
L22_1 = {}
L23_1 = "dwuahjudhau"
L22_1[1] = L23_1
L23_1 = "仅对某些效果有效"
L24_1 = _ENV
L25_1 = "hiteffectColour"
L24_1 = L24_1[L25_1]
L25_1 = false
function L26_1(A0_2)
  local L1_2, L2_2
  L1_2 = set_effectColour
  L2_2 = A0_2
  L1_2(L2_2)
end
L19_1 = L19_1(L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1)
L17_1[L18_1] = L19_1
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.rainbow
L18_1 = _ENV
L19_1 = "hit_menuColour"
L18_1 = L18_1[L19_1]
L17_1(L18_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle_loop
L18_1 = _ENV
L19_1 = "weapons"
L18_1 = L18_1[L19_1]
L19_1 = "删除枪"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2
  L0_2 = delete_gun
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle_loop
L18_1 = _ENV
L19_1 = "weapons"
L18_1 = L18_1[L19_1]
L19_1 = "翻滚换弹"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2
  L0_2 = fghd
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "911事件"
L20_1 = {}
L21_1 = "让它成为GTA宇宙中的经典\n一架飞机撞向花园银行"
function L22_1()
  local L0_2, L1_2
  L0_2 = attacks_911
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle_loop
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "鱼雨"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2
  L0_2 = fish_rain
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "通往天堂"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2
  L0_2 = To_Heaven
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle_loop
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "军演轰炸"
L20_1 = {}
L21_1 = "射击你要轰炸的地点"
function L22_1()
  local L0_2, L1_2
  L0_2 = Military_exercises
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.list_action
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "骑乘动物"
L20_1 = {}
L21_1 = ""
L22_1 = {}
L23_1 = "鹿"
L24_1 = "公猪"
L25_1 = "牛"
L22_1[1] = L23_1
L22_1[2] = L24_1
L22_1[3] = L25_1
function L23_1(A0_2)
  local L1_2, L2_2
  L1_2 = riding_animals
  L2_2 = A0_2
  L1_2(L2_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1, L23_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "牛车"
L20_1 = {}
L21_1 = ""
function L22_1(A0_2)
  local L1_2, L2_2
  L1_2 = ride_cow
  L2_2 = A0_2
  L1_2(L2_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "police_vehicle"
L19_1 = _ENV
L20_1 = "menu"
L19_1 = L19_1[L20_1]
L20_1 = "list"
L19_1 = L19_1[L20_1]
L20_1 = _ENV
L21_1 = "funfeatures"
L20_1 = L20_1[L21_1]
L21_1 = "警车模式"
L22_1 = {}
L23_1 = ""
L19_1 = L19_1(L20_1, L21_1, L22_1, L23_1)
L17_1[L18_1] = L19_1
L17_1 = require
L18_1 = "lib.daidailib.Policify"
L17_1(L18_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "世界轰炸"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2
  L0_2 = World_Bombing
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "冲浪"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2
  L0_2 = surf
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "猴王"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2
  L0_2 = monkey_king
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "驾驶购物车"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2
  L0_2 = drive_shopping_cart
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "洛奇斯怪兽mk2"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2
  L0_2 = lochness_mk2
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "驾驶超级游艇"
L20_1 = {}
L21_1 = "在水面上生成"
function L22_1()
  local L0_2, L1_2
  L0_2 = super_yacht
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.textslider
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "极限跳跃"
L20_1 = {}
L21_1 = "从飞机上一跃而下"
L22_1 = {}
L23_1 = "低"
L24_1 = "中"
L25_1 = "高"
L22_1[1] = L23_1
L22_1[2] = L24_1
L22_1[3] = L25_1
function L23_1(A0_2)
  local L1_2, L2_2
  L1_2 = extreme_jump
  L2_2 = A0_2
  L1_2(L2_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1, L23_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "炸弹车"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2
  L0_2 = bomb_car
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = require
L18_1 = "lib.daidailib.WatchDogs"
L17_1(L18_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle_loop
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "空中梯队"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2
  L0_2 = escort
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "p_eff_fun"
L19_1 = _ENV
L20_1 = "menu"
L19_1 = L19_1[L20_1]
L20_1 = "list"
L19_1 = L19_1[L20_1]
L20_1 = _ENV
L21_1 = "funfeatures"
L20_1 = L20_1[L21_1]
L21_1 = "娱乐粒子效果"
L22_1 = {}
L23_1 = ""
L19_1 = L19_1(L20_1, L21_1, L22_1, L23_1)
L17_1[L18_1] = L19_1
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle_loop
L18_1 = _ENV
L19_1 = "p_eff_fun"
L18_1 = L18_1[L19_1]
L19_1 = "开启"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2
  L0_2 = ptfx_fun
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L18_1 = "list_select"
L17_1 = L17_1[L18_1]
L18_1 = _ENV
L19_1 = "p_eff_fun"
L18_1 = L18_1[L19_1]
L19_1 = "设置粒子效果"
L20_1 = {}
L21_1 = "发送您选择的粒子效果"
L22_1 = _ENV
L23_1 = "funptfxlist"
L22_1 = L22_1[L23_1]
L23_1 = 1
function L24_1(A0_2)
  local L1_2, L2_2
  L1_2 = sel_ptfx_fun
  L2_2 = A0_2
  L1_2(L2_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle_loop
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "避免事故"
L20_1 = {}
L21_1 = "可避免车祸,仍然需要具备一定的驾驶能力"
function L22_1()
  local L0_2, L1_2
  L0_2 = aa_thread
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "地雷"
L20_1 = {}
L21_1 = "对导弹尾部进行射击以触发"
function L22_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = 1246158990
  L1_2 = request_model
  L2_2 = L0_2
  L1_2(L2_2)
  L1_2 = ENTITY
  L1_2 = L1_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_ID
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L3_2()
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L3_2 = 0
  L4_2 = 4
  L5_2 = 0
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2)
  L2_2 = OBJECT
  L2_2 = L2_2.CREATE_OBJECT_NO_OFFSET
  L3_2 = L0_2
  L4_2 = L1_2.x
  L5_2 = L1_2.y
  L6_2 = L1_2.z
  L6_2 = L6_2 - 1
  L7_2 = true
  L8_2 = false
  L9_2 = true
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L3_2 = PLAYER
  L3_2 = L3_2.GET_PLAYER_PED_SCRIPT_INDEX
  L4_2 = PLAYER
  L4_2 = L4_2.PLAYER_ID
  L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L4_2()
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = ENTITY
  L4_2 = L4_2.SET_ENTITY_HEADING
  L5_2 = L2_2
  L6_2 = ENTITY
  L6_2 = L6_2.GET_ENTITY_HEADING
  L7_2 = L3_2
  L6_2 = L6_2(L7_2)
  L6_2 = L6_2 - 90
  L4_2(L5_2, L6_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "运输核弹"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2
  L0_2 = transport_nuke
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "传送到最近玩家"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2
  L0_2 = tp_closest_player
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "tpnearcar_list"
L19_1 = _ENV
L20_1 = "menu"
L19_1 = L19_1[L20_1]
L20_1 = "list"
L19_1 = L19_1[L20_1]
L20_1 = _ENV
L21_1 = "funfeatures"
L20_1 = L20_1[L21_1]
L21_1 = "传送到最近载具"
L22_1 = {}
L23_1 = ""
L19_1 = L19_1(L20_1, L21_1, L22_1, L23_1)
L17_1[L18_1] = L19_1
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "tpnearcar_list"
L18_1 = L18_1[L19_1]
L19_1 = "传送一次"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2
  L0_2 = tp_closest_vehicle
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle
L18_1 = _ENV
L19_1 = "tpnearcar_list"
L18_1 = L18_1[L19_1]
L19_1 = "按E传送"
L20_1 = {}
L21_1 = ""
function L22_1(A0_2)
  local L1_2, L2_2
  L1_2 = horn_tp
  L2_2 = A0_2
  L1_2(L2_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "召回载具"
L20_1 = {}
L21_1 = "让你的载具自动驶向你"
function L22_1()
  local L0_2, L1_2
  L0_2 = recall_vehicle
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "gridspawn"
L19_1 = _ENV
L20_1 = "menu"
L19_1 = L19_1[L20_1]
L20_1 = "list"
L19_1 = L19_1[L20_1]
L20_1 = _ENV
L21_1 = "funfeatures"
L20_1 = L20_1[L21_1]
L21_1 = "批量载具生成"
L22_1 = {}
L23_1 = ""
L19_1 = L19_1(L20_1, L21_1, L22_1, L23_1)
L17_1[L18_1] = L19_1
L17_1 = _ENV
L18_1 = "dofile"
L17_1 = L17_1[L18_1]
L18_1 = _ENV
L19_1 = "filesystem"
L18_1 = L18_1[L19_1]
L19_1 = "scripts_dir"
L18_1 = L18_1[L19_1]
L18_1 = L18_1()
L19_1 = "lib/daidailib/GridSpawn.lua"
L18_1 = L18_1 .. L19_1
L17_1(L18_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "火箭人"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2
  L0_2 = Rocket_Man
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "黑人抬棺"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2
  L0_2 = blacks_coffins
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle_loop
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "罪城的水"
L20_1 = {}
L21_1 = "碰水就死"
function L22_1()
  local L0_2, L1_2
  L0_2 = VicecityWater
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "堆叠行人"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2
  L0_2 = stack_npc
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "bodyguardMenu"
L19_1 = _ENV
L20_1 = "BodyguardMenu"
L19_1 = L19_1[L20_1]
L20_1 = "new"
L19_1 = L19_1[L20_1]
L20_1 = _ENV
L21_1 = "funfeatures"
L20_1 = L20_1[L21_1]
L21_1 = "生成保镖"
L22_1 = {}
L19_1 = L19_1(L20_1, L21_1, L22_1)
L17_1[L18_1] = L19_1
L17_1 = _ENV
L18_1 = "bodyguard_heli_options"
L19_1 = _ENV
L20_1 = "menu"
L19_1 = L19_1[L20_1]
L20_1 = "list"
L19_1 = L19_1[L20_1]
L20_1 = _ENV
L21_1 = "funfeatures"
L20_1 = L20_1[L21_1]
L21_1 = "保镖直升机"
L22_1 = {}
L23_1 = ""
L19_1 = L19_1(L20_1, L21_1, L22_1, L23_1)
L17_1[L18_1] = L19_1
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L18_1 = "list_select"
L17_1 = L17_1[L18_1]
L18_1 = _ENV
L19_1 = "bodyguard_heli_options"
L18_1 = L18_1[L19_1]
L19_1 = "直升机类型"
L20_1 = {}
L21_1 = ""
L22_1 = _ENV
L23_1 = "sel_heli_name_list"
L22_1 = L22_1[L23_1]
L23_1 = 1
function L24_1(A0_2)
  local L1_2, L2_2
  L1_2 = Bodyguard_helicopter
  L2_2 = A0_2
  L1_2(L2_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle
L18_1 = _ENV
L19_1 = "bodyguard_heli_options"
L18_1 = L18_1[L19_1]
L19_1 = "直升机无敌"
L20_1 = {}
L21_1 = ""
function L22_1(A0_2)
  local L1_2, L2_2
  L1_2 = Bodyguard_helicopter_invincible
  L2_2 = A0_2
  L1_2(L2_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "bodyguard_heli_options"
L18_1 = L18_1[L19_1]
L19_1 = "生成保镖直升机"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2
  L0_2 = Spawn_bodyguard_helicopter
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "bodyguard_heli_options"
L18_1 = L18_1[L19_1]
L19_1 = "删除所有保镖直升机"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2
  L0_2 = delete_bodyguard_helicopter
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "天空岛"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
  L0_2 = {}
  L0_2.x = 0
  L0_2.y = 0
  L0_2.z = 500
  L1_2 = ENTITY
  L1_2 = L1_2.DOES_ENTITY_EXIST
  L2_2 = island_block
  L1_2 = L1_2(L2_2)
  if not L1_2 then
    L1_2 = create_object
    L2_2 = 1054678467
    L3_2 = L0_2.x
    L4_2 = L0_2.y
    L5_2 = L0_2.z
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2)
    island_block = L1_2
  end
  L1_2 = PED
  L1_2 = L1_2.SET_PED_COORDS_KEEP_VEHICLE
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = 0
  L4_2 = 0
  L5_2 = 503
  L1_2(L2_2, L3_2, L4_2, L5_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "flappygame"
L19_1 = _ENV
L20_1 = "menu"
L19_1 = L19_1[L20_1]
L20_1 = "list"
L19_1 = L19_1[L20_1]
L20_1 = _ENV
L21_1 = "funfeatures"
L20_1 = L20_1[L21_1]
L21_1 = "flappybird"
L19_1 = L19_1(L20_1, L21_1)
L17_1[L18_1] = L19_1
L17_1 = require
L18_1 = "lib.daidailib.flappybird"
L17_1(L18_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "保护球"
L20_1 = {}
L21_1 = ""
function L22_1(A0_2)
  local L1_2, L2_2
  L1_2 = Protect_ball
  L2_2 = A0_2
  L1_2(L2_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "仓鼠球"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2
  L0_2 = Hamster_Ball
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2 = L1_2()
  L0_2(L1_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "UFO_vehicles"
L19_1 = _ENV
L20_1 = "menu"
L19_1 = L19_1[L20_1]
L20_1 = "list"
L19_1 = L19_1[L20_1]
L20_1 = _ENV
L21_1 = "funfeatures"
L20_1 = L20_1[L21_1]
L21_1 = "UFO载具"
L22_1 = {}
L23_1 = ""
L19_1 = L19_1(L20_1, L21_1, L22_1, L23_1)
L17_1[L18_1] = L19_1
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.textslider
L18_1 = _ENV
L19_1 = "UFO_vehicles"
L18_1 = L18_1[L19_1]
L19_1 = "UFO"
L20_1 = {}
L21_1 = "驾驶UFO,使用牵引光束和大炮"
L22_1 = _ENV
L23_1 = "ufo_name"
L22_1 = L22_1[L23_1]
function L23_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = objModels
  L1_2 = L1_2[A0_2]
  L2_2 = L0_1.setObjModel
  L3_2 = L1_2
  L2_2(L3_2)
  L2_2 = L1_1.exists
  L2_2 = L2_2()
  if not L2_2 then
    L2_2 = L0_1.exists
    L2_2 = L2_2()
    if not L2_2 then
      L2_2 = L0_1.create
      L2_2()
    end
  end
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1, L23_1)
L17_1 = _ENV
L18_1 = "ufoSettings"
L19_1 = _ENV
L20_1 = "menu"
L19_1 = L19_1[L20_1]
L20_1 = "list"
L19_1 = L19_1[L20_1]
L20_1 = _ENV
L21_1 = "UFO_vehicles"
L20_1 = L20_1[L21_1]
L21_1 = "设置"
L22_1 = {}
L23_1 = ""
L19_1 = L19_1(L20_1, L21_1, L22_1, L23_1)
L17_1[L18_1] = L19_1
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle
L18_1 = _ENV
L19_1 = "ufoSettings"
L18_1 = L18_1[L19_1]
L19_1 = "禁用玩家框"
L20_1 = {}
L21_1 = ""
function L22_1(A0_2)
  local L1_2
  L1_2 = Config
  L1_2 = L1_2.ufo
  L1_2.disableboxes = A0_2
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle
L18_1 = _ENV
L19_1 = "ufoSettings"
L18_1 = L18_1[L19_1]
L19_1 = "仅吸引玩家载具"
L20_1 = {}
L21_1 = "使牵引光束忽略带有非玩家驾驶员的车辆"
function L22_1(A0_2)
  local L1_2
  L1_2 = Config
  L1_2 = L1_2.ufo
  L1_2.targetplayer = A0_2
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle_loop
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "抛掷载具"
L20_1 = {}
L21_1 = "在载具附近按E将载具抬起来,在按E将载具投掷出去."
function L22_1(A0_2)
  local L1_2
  L1_2 = throwvehs
  L1_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle_loop
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "抛掷NPC"
L20_1 = {}
L21_1 = "在NPC附近按E将NPC抬起来,在按E将NPC投掷出去."
function L22_1(A0_2)
  local L1_2
  L1_2 = throwpeds
  L1_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "Shooting_practice"
L19_1 = _ENV
L20_1 = "menu"
L19_1 = L19_1[L20_1]
L20_1 = "list"
L19_1 = L19_1[L20_1]
L20_1 = _ENV
L21_1 = "funfeatures"
L20_1 = L20_1[L21_1]
L21_1 = "射击馆"
L19_1 = L19_1(L20_1, L21_1)
L17_1[L18_1] = L19_1
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L18_1 = "divider"
L17_1 = L17_1[L18_1]
L18_1 = _ENV
L19_1 = "Shooting_practice"
L18_1 = L18_1[L19_1]
L19_1 = "射击训练场"
L17_1(L18_1, L19_1)
L17_1 = _ENV
L18_1 = "create_lab"
L19_1 = _ENV
L20_1 = "menu"
L19_1 = L19_1[L20_1]
L19_1 = L19_1.action
L20_1 = _ENV
L21_1 = "Shooting_practice"
L20_1 = L20_1[L21_1]
L21_1 = "创建训练场"
L22_1 = {}
L23_1 = ""
function L24_1()
  local L0_2, L1_2
  L0_2 = load_lab
  L0_2()
end
L19_1 = L19_1(L20_1, L21_1, L22_1, L23_1, L24_1)
L17_1[L18_1] = L19_1
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "Shooting_practice"
L18_1 = L18_1[L19_1]
L19_1 = "传送到训练场"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2
  L0_2 = teleport_to_lab
  L0_2()
  L0_2 = clear_all_peds
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "Shooting_practice"
L18_1 = L18_1[L19_1]
L19_1 = "结束训练"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2
  L0_2 = Clean_training_ground
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L18_1 = "divider"
L17_1 = L17_1[L18_1]
L18_1 = _ENV
L19_1 = "Shooting_practice"
L18_1 = L18_1[L19_1]
L19_1 = "射击类型"
L17_1(L18_1, L19_1)
L17_1 = _ENV
L18_1 = "simple_3d"
L19_1 = _ENV
L20_1 = "menu"
L19_1 = L19_1[L20_1]
L20_1 = "list"
L19_1 = L19_1[L20_1]
L20_1 = _ENV
L21_1 = "Shooting_practice"
L20_1 = L20_1[L21_1]
L21_1 = "3D射击"
L22_1 = {}
L23_1 = ""
L19_1 = L19_1(L20_1, L21_1, L22_1, L23_1)
L17_1[L18_1] = L19_1
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L18_1 = "divider"
L17_1 = L17_1[L18_1]
L18_1 = _ENV
L19_1 = "simple_3d"
L18_1 = L18_1[L19_1]
L19_1 = "3D射击"
L17_1(L18_1, L19_1)
L17_1 = _ENV
L18_1 = "simple_3d_toggle"
L19_1 = _ENV
L20_1 = "menu"
L19_1 = L19_1[L20_1]
L19_1 = L19_1.toggle
L20_1 = _ENV
L21_1 = "simple_3d"
L20_1 = L20_1[L21_1]
L21_1 = "开始"
L22_1 = {}
L23_1 = ""
function L24_1(A0_2)
  local L1_2, L2_2
  L1_2 = Shooting_simulation_3D
  L2_2 = A0_2
  L1_2(L2_2)
end
L19_1 = L19_1(L20_1, L21_1, L22_1, L23_1, L24_1)
L17_1[L18_1] = L19_1
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L18_1 = "divider"
L17_1 = L17_1[L18_1]
L18_1 = _ENV
L19_1 = "simple_3d"
L18_1 = L18_1[L19_1]
L19_1 = "游戏设置"
L17_1(L18_1, L19_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.list_action
L18_1 = _ENV
L19_1 = "simple_3d"
L18_1 = L18_1[L19_1]
L19_1 = "设定状况"
L20_1 = {}
L21_1 = ""
L22_1 = _ENV
L23_1 = "ped_health_selector"
L22_1 = L22_1[L23_1]
L23_1 = "display_options"
L22_1 = L22_1[L23_1]
function L23_1(A0_2)
  local L1_2, L2_2
  L1_2 = Set_condition_3D
  L2_2 = A0_2
  L1_2(L2_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1, L23_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.list_action
L18_1 = _ENV
L19_1 = "simple_3d"
L18_1 = L18_1[L19_1]
L19_1 = "游戏时间"
L20_1 = {}
L21_1 = ""
L22_1 = _ENV
L23_1 = "time_selector"
L22_1 = L22_1[L23_1]
L23_1 = "display_options"
L22_1 = L22_1[L23_1]
function L23_1(A0_2)
  local L1_2, L2_2
  L1_2 = Set_shoot_time_3D
  L2_2 = A0_2
  L1_2(L2_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1, L23_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.list_action
L18_1 = _ENV
L19_1 = "simple_3d"
L18_1 = L18_1[L19_1]
L19_1 = "目标最大生成高度"
L20_1 = {}
L21_1 = ""
L22_1 = _ENV
L23_1 = "simple3d_target_max_height"
L22_1 = L22_1[L23_1]
L23_1 = "display_options"
L22_1 = L22_1[L23_1]
function L23_1(A0_2)
  local L1_2, L2_2
  L1_2 = Target_build_height_3D
  L2_2 = A0_2
  L1_2(L2_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1, L23_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle
L18_1 = _ENV
L19_1 = "simple_3d"
L18_1 = L18_1[L19_1]
L19_1 = "允许PED移动"
L20_1 = {}
L21_1 = ""
function L22_1(A0_2)
  local L1_2, L2_2
  L1_2 = target_move
  L2_2 = A0_2
  L1_2(L2_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "simple_2d"
L19_1 = _ENV
L20_1 = "Shooting_practice"
L19_1 = L19_1[L20_1]
L21_1 = "list"
L20_1 = L19_1
L19_1 = L19_1[L21_1]
L21_1 = "2D射击"
L22_1 = {}
L23_1 = ""
L19_1 = L19_1(L20_1, L21_1, L22_1, L23_1)
L17_1[L18_1] = L19_1
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L18_1 = "divider"
L17_1 = L17_1[L18_1]
L18_1 = _ENV
L19_1 = "simple_2d"
L18_1 = L18_1[L19_1]
L19_1 = "2D射击"
L17_1(L18_1, L19_1)
L17_1 = _ENV
L18_1 = "simple_2d_toggle"
L19_1 = _ENV
L20_1 = "menu"
L19_1 = L19_1[L20_1]
L19_1 = L19_1.toggle
L20_1 = _ENV
L21_1 = "simple_2d"
L20_1 = L20_1[L21_1]
L21_1 = "开始"
L22_1 = {}
L23_1 = ""
function L24_1(A0_2)
  local L1_2, L2_2
  L1_2 = Shooting_simulation_2D
  L2_2 = A0_2
  L1_2(L2_2)
end
L19_1 = L19_1(L20_1, L21_1, L22_1, L23_1, L24_1)
L17_1[L18_1] = L19_1
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L18_1 = "divider"
L17_1 = L17_1[L18_1]
L18_1 = _ENV
L19_1 = "simple_2d"
L18_1 = L18_1[L19_1]
L19_1 = "游戏设置"
L17_1(L18_1, L19_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.list_action
L18_1 = _ENV
L19_1 = "simple_2d"
L18_1 = L18_1[L19_1]
L19_1 = "设定状况"
L20_1 = {}
L21_1 = ""
L22_1 = _ENV
L23_1 = "ped_health_selector"
L22_1 = L22_1[L23_1]
L23_1 = "display_options"
L22_1 = L22_1[L23_1]
function L23_1(A0_2)
  local L1_2, L2_2
  L1_2 = Set_condition_2D
  L2_2 = A0_2
  L1_2(L2_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1, L23_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.list_action
L18_1 = _ENV
L19_1 = "simple_2d"
L18_1 = L18_1[L19_1]
L19_1 = "游戏时间"
L20_1 = {}
L21_1 = ""
L22_1 = _ENV
L23_1 = "time_selector"
L22_1 = L22_1[L23_1]
L23_1 = "display_options"
L22_1 = L22_1[L23_1]
function L23_1(A0_2)
  local L1_2, L2_2
  L1_2 = Set_shoot_time_2D
  L2_2 = A0_2
  L1_2(L2_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1, L23_1)
L17_1 = _ENV
L18_1 = "green_soda"
L19_1 = _ENV
L20_1 = "menu"
L19_1 = L19_1[L20_1]
L20_1 = "list"
L19_1 = L19_1[L20_1]
L20_1 = _ENV
L21_1 = "funfeatures"
L20_1 = L20_1[L21_1]
L21_1 = "绿汽水"
L19_1 = L19_1(L20_1, L21_1)
L17_1[L18_1] = L19_1
L17_1 = require
L18_1 = "lib.daidailib.SprunkStop"
L17_1(L18_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "灵魂出窍"
L20_1 = {}
L21_1 = ""
function L22_1(A0_2)
  local L1_2, L2_2
  L1_2 = Out_body
  L2_2 = A0_2
  L1_2(L2_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle_loop
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "homer粒子"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L0_2 = players
  L0_2 = L0_2.get_position
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L1_2 = request_ptfx_asset
  L2_2 = "scr_sum2_hal"
  L1_2(L2_2)
  L1_2 = GRAPHICS
  L1_2 = L1_2.USE_PARTICLE_FX_ASSET
  L2_2 = "scr_sum2_hal"
  L1_2(L2_2)
  L1_2 = GRAPHICS
  L2_2 = "START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD"
  L1_2 = L1_2[L2_2]
  L2_2 = suijijianqi
  L3_2 = jianqi
  L2_2 = L2_2(L3_2)
  L3_2 = L0_2.x
  L4_2 = L0_2.y
  L5_2 = L0_2.z
  L6_2 = 0
  L7_2 = 0
  L8_2 = 0
  L9_2 = 2.5
  L10_2 = false
  L11_2 = false
  L12_2 = false
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L1_2 = util
  L1_2 = L1_2.yield
  L2_2 = 200
  L1_2(L2_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "火拳"
L20_1 = {}
L21_1 = ""
function L22_1(A0_2)
  local L1_2, L2_2
  L1_2 = Fire_Fist
  L2_2 = A0_2
  L1_2(L2_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "血拳"
L20_1 = {}
L21_1 = ""
function L22_1(A0_2)
  local L1_2, L2_2
  L1_2 = Blood_Fist
  L2_2 = A0_2
  L1_2(L2_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "雷电拳"
L20_1 = {}
L21_1 = ""
function L22_1(A0_2)
  local L1_2, L2_2
  L1_2 = Raiden_Fist
  L2_2 = A0_2
  L1_2(L2_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "spawn_truck"
L19_1 = _ENV
L20_1 = "menu"
L19_1 = L19_1[L20_1]
L20_1 = "list"
L19_1 = L19_1[L20_1]
L20_1 = _ENV
L21_1 = "funfeatures"
L20_1 = L20_1[L21_1]
L21_1 = "拉车"
L19_1 = L19_1(L20_1, L21_1)
L17_1[L18_1] = L19_1
L17_1 = _ENV
L18_1 = "spawn_truck_car"
L19_1 = _ENV
L20_1 = "menu"
L19_1 = L19_1[L20_1]
L20_1 = "list"
L19_1 = L19_1[L20_1]
L20_1 = _ENV
L21_1 = "spawn_truck"
L20_1 = L20_1[L21_1]
L21_1 = "货运载具"
L19_1 = L19_1(L20_1, L21_1)
L17_1[L18_1] = L19_1
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "spawn_truck_car"
L18_1 = L18_1[L19_1]
L19_1 = "废土"
L20_1 = {}
L21_1 = "生成一个废土人进行拖曳"
function L22_1()
  local L0_2, L1_2
  L0_2 = menu
  L0_2 = L0_2.trigger_commands
  L1_2 = "wastelander"
  L0_2(L1_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "spawn_truck_car"
L18_1 = L18_1[L19_1]
L19_1 = "猛击卡车"
L20_1 = {}
L21_1 = "生成一辆猛击卡车进行牵引"
function L22_1()
  local L0_2, L1_2
  L0_2 = menu
  L0_2 = L0_2.trigger_commands
  L1_2 = "slamtruck"
  L0_2(L1_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle
L18_1 = _ENV
L19_1 = "spawn_truck_car"
L18_1 = L18_1[L19_1]
L19_1 = "附加"
L20_1 = {}
L21_1 = "任何近距离车辆都将连接到您当前的车辆上"
function L22_1(A0_2)
  local L1_2
  if A0_2 then
    L1_2 = attach_nearest_vehicle
    L1_2()
  else
    L1_2 = detach_attached_vehicle
    L1_2()
  end
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "cargobobMenu"
L19_1 = _ENV
L20_1 = "menu"
L19_1 = L19_1[L20_1]
L20_1 = "list"
L19_1 = L19_1[L20_1]
L20_1 = _ENV
L21_1 = "spawn_truck"
L20_1 = L20_1[L21_1]
L21_1 = "货运直升机"
L22_1 = {}
L19_1 = L19_1(L20_1, L21_1, L22_1)
L17_1[L18_1] = L19_1
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "cargobobMenu"
L18_1 = L18_1[L19_1]
L19_1 = "运兵直升机"
L20_1 = {}
L21_1 = "按E使用吊挂"
function L22_1()
  local L0_2, L1_2
  L0_2 = spawn_cargobob_with_magnet
  L0_2 = L0_2()
  currentCargobob = L0_2
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "cargobobMenu"
L18_1 = L18_1[L19_1]
L19_1 = "吊挂直升机"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2
  L0_2 = spawn_skylift
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "cargobobMenu"
L18_1 = L18_1[L19_1]
L19_1 = "附加/分离"
L20_1 = {}
L21_1 = "将最近的车辆连接/分离到吊挂直升机"
function L22_1()
  local L0_2, L1_2
  L0_2 = attachedVehicle
  if L0_2 then
    L0_2 = detach_vehicle_from_skylift
    L1_2 = attachedVehicle
    L0_2(L1_2)
    attachedVehicle = nil
  else
    L0_2 = attach_vehicle_to_skylift
    L0_2()
  end
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "Hell_Undead"
L19_1 = _ENV
L20_1 = "menu"
L19_1 = L19_1[L20_1]
L20_1 = "list"
L19_1 = L19_1[L20_1]
L20_1 = _ENV
L21_1 = "funfeatures"
L20_1 = L20_1[L21_1]
L21_1 = "地狱亡灵"
L22_1 = {}
L23_1 = ""
L19_1 = L19_1(L20_1, L21_1, L22_1, L23_1)
L17_1[L18_1] = L19_1
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle
L18_1 = _ENV
L19_1 = "Hell_Undead"
L18_1 = L18_1[L19_1]
L19_1 = "地狱亡灵"
L20_1 = {}
L21_1 = ""
function L22_1(A0_2)
  local L1_2, L2_2, L3_2
  if A0_2 then
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "grace on"
    L1_2(L2_2)
    L1_2 = menu
    L1_2 = L1_2.set_value
    L2_2 = Burning_Man
    L3_2 = true
    L1_2(L2_2, L3_2)
    L1_2 = menu
    L1_2 = L1_2.set_value
    L2_2 = runspeed
    L3_2 = true
    L1_2(L2_2, L3_2)
    L1_2 = menu
    L1_2 = L1_2.set_value
    L2_2 = superjump
    L3_2 = true
    L1_2(L2_2, L3_2)
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "trails on"
    L1_2(L2_2)
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "trailcolourrainbow 1"
    L1_2(L2_2)
  else
    L1_2 = menu
    L1_2 = L1_2.set_value
    L2_2 = Burning_Man
    L3_2 = false
    L1_2(L2_2, L3_2)
    L1_2 = menu
    L1_2 = L1_2.set_value
    L2_2 = runspeed
    L3_2 = false
    L1_2(L2_2, L3_2)
    L1_2 = menu
    L1_2 = L1_2.set_value
    L2_2 = superjump
    L3_2 = false
    L1_2(L2_2, L3_2)
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "trails off"
    L1_2(L2_2)
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "trailcolourrainbow 0"
    L1_2(L2_2)
  end
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L18_1 = "divider"
L17_1 = L17_1[L18_1]
L18_1 = _ENV
L19_1 = "Hell_Undead"
L18_1 = L18_1[L19_1]
L19_1 = "设置"
L17_1(L18_1, L19_1)
L17_1 = _ENV
L18_1 = "runspeed"
L19_1 = _ENV
L20_1 = "menu"
L19_1 = L19_1[L20_1]
L19_1 = L19_1.toggle
L20_1 = _ENV
L21_1 = "Hell_Undead"
L20_1 = L20_1[L21_1]
L21_1 = "奔跑速度"
L22_1 = {}
L23_1 = ""
function L24_1(A0_2)
  local L1_2, L2_2
  if A0_2 then
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "walkspeed 1.5"
    L1_2(L2_2)
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "gracefullanding on"
    L1_2(L2_2)
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "superrun 1.2"
    L1_2(L2_2)
  else
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "walkspeed 1"
    L1_2(L2_2)
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "gracefullanding off"
    L1_2(L2_2)
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "superrun 0"
    L1_2(L2_2)
  end
end
L19_1 = L19_1(L20_1, L21_1, L22_1, L23_1, L24_1)
L17_1[L18_1] = L19_1
L17_1 = _ENV
L18_1 = "superjump"
L19_1 = _ENV
L20_1 = "menu"
L19_1 = L19_1[L20_1]
L19_1 = L19_1.toggle_loop
L20_1 = _ENV
L21_1 = "Hell_Undead"
L20_1 = L20_1[L21_1]
L21_1 = "亡灵跳跃"
L22_1 = {}
L23_1 = ""
function L24_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L0_2 = PAD
  L0_2 = L0_2.IS_CONTROL_PRESSED
  L1_2 = 1
  L2_2 = 22
  L0_2 = L0_2(L1_2, L2_2)
  if L0_2 then
    L0_2 = ENTITY
    L0_2 = L0_2.APPLY_FORCE_TO_ENTITY
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_PED_ID
    L1_2 = L1_2()
    L2_2 = 1
    L3_2 = 0.0
    L4_2 = 0.0
    L5_2 = 1.5
    L6_2 = 0.0
    L7_2 = 0.0
    L8_2 = 0.0
    L9_2 = 0
    L10_2 = true
    L11_2 = true
    L12_2 = true
    L13_2 = false
    L14_2 = true
    L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  end
end
L19_1 = L19_1(L20_1, L21_1, L22_1, L23_1, L24_1)
L17_1[L18_1] = L19_1
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "GPS导航"
L20_1 = {}
L21_1 = ""
function L22_1(A0_2)
  local L1_2, L2_2
  L1_2 = GPS_navigation
  L2_2 = A0_2
  L1_2(L2_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "headlamp"
L19_1 = _ENV
L20_1 = "menu"
L19_1 = L19_1[L20_1]
L20_1 = "list"
L19_1 = L19_1[L20_1]
L20_1 = _ENV
L21_1 = "funfeatures"
L20_1 = L20_1[L21_1]
L21_1 = "头灯"
L22_1 = {}
L23_1 = "仅本地可见"
L19_1 = L19_1(L20_1, L21_1, L22_1, L23_1)
L17_1[L18_1] = L19_1
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle_loop
L18_1 = _ENV
L19_1 = "headlamp"
L18_1 = L18_1[L19_1]
L19_1 = "开启"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L0_2 = PED
  L0_2 = L0_2.GET_PED_BONE_COORDS
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = 31086
  L3_2 = 0.0
  L4_2 = 0.0
  L5_2 = 0.0
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2)
  L1_2 = players
  L1_2 = L1_2.get_cam_rot
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_ID
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L2_2 = GRAPHICS1
  L2_2 = L2_2.DRAW_SPOT_LIGHT
  L3_2 = L0_2
  L5_2 = L1_2
  L4_2 = L1_2.toDir
  L4_2 = L4_2(L5_2)
  L5_2 = math
  L5_2 = L5_2.floor
  L6_2 = headlamp_color
  L6_2 = L6_2.r
  L6_2 = L6_2 * 255
  L5_2 = L5_2(L6_2)
  L6_2 = math
  L6_2 = L6_2.floor
  L7_2 = headlamp_color
  L7_2 = L7_2.g
  L7_2 = L7_2 * 255
  L6_2 = L6_2(L7_2)
  L7_2 = math
  L7_2 = L7_2.floor
  L8_2 = headlamp_color
  L8_2 = L8_2.b
  L8_2 = L8_2 * 255
  L7_2 = L7_2(L8_2)
  L8_2 = distance
  L8_2 = L8_2 * 1.5
  L9_2 = brightness
  L10_2 = 0.0
  L11_2 = radius
  L12_2 = distance
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "distance"
L19_1 = 25.0
L17_1[L18_1] = L19_1
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L18_1 = "slider_float"
L17_1 = L17_1[L18_1]
L18_1 = _ENV
L19_1 = "headlamp"
L18_1 = L18_1[L19_1]
L19_1 = "距离"
L20_1 = {}
L21_1 = "distance"
L20_1[1] = L21_1
L21_1 = "光照距离."
L22_1 = 100
L23_1 = 10000
L24_1 = 1500
L25_1 = 100
function L26_1(A0_2)
  local L1_2
  L1_2 = A0_2 / 100
  distance = L1_2
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1)
L17_1 = _ENV
L18_1 = "brightness"
L19_1 = 10.0
L17_1[L18_1] = L19_1
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L18_1 = "slider_float"
L17_1 = L17_1[L18_1]
L18_1 = _ENV
L19_1 = "headlamp"
L18_1 = L18_1[L19_1]
L19_1 = "亮度"
L20_1 = {}
L21_1 = "brightness"
L20_1[1] = L21_1
L21_1 = "光亮强度."
L22_1 = 100
L23_1 = 10000
L24_1 = 1000
L25_1 = 100
function L26_1(A0_2)
  local L1_2
  L1_2 = A0_2 / 100
  brightness = L1_2
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1)
L17_1 = _ENV
L18_1 = "radius"
L19_1 = 15.0
L17_1[L18_1] = L19_1
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L18_1 = "slider_float"
L17_1 = L17_1[L18_1]
L18_1 = _ENV
L19_1 = "headlamp"
L18_1 = L18_1[L19_1]
L19_1 = "半径"
L20_1 = {}
L21_1 = "radius"
L20_1[1] = L21_1
L21_1 = "光束半径."
L22_1 = 100
L23_1 = 5000
L24_1 = 2000
L25_1 = 100
function L26_1(A0_2)
  local L1_2
  L1_2 = A0_2 / 100
  radius = L1_2
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1)
L17_1 = _ENV
L18_1 = "headlamp_color"
L19_1 = {}
L20_1 = "r"
L21_1 = 0
L19_1[L20_1] = L21_1
L20_1 = "g"
L21_1 = 1
L19_1[L20_1] = L21_1
L20_1 = "b"
L21_1 = 1
L19_1[L20_1] = L21_1
L20_1 = "a"
L21_1 = 0
L19_1[L20_1] = L21_1
L17_1[L18_1] = L19_1
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.rainbow
L18_1 = _ENV
L19_1 = "menu"
L18_1 = L18_1[L19_1]
L18_1 = L18_1.colour
L19_1 = _ENV
L20_1 = "headlamp"
L19_1 = L19_1[L20_1]
L20_1 = "颜色"
L21_1 = {}
L22_1 = "colour"
L21_1[1] = L22_1
L22_1 = ""
L23_1 = _ENV
L24_1 = "headlamp_color"
L23_1 = L23_1[L24_1]
L24_1 = true
function L25_1(A0_2)
  local L1_2
  headlamp_color = A0_2
end
L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1 = L18_1(L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1)
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "移除交通"
L20_1 = {}
L21_1 = "对其它玩家生效"
function L22_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  if A0_2 then
    L1_2 = MISC
    L1_2 = L1_2.ADD_POP_MULTIPLIER_SPHERE
    L2_2 = 1.1
    L3_2 = 1.1
    L4_2 = 1.1
    L5_2 = 15000.0
    L6_2 = 0
    L7_2 = 0
    L8_2 = false
    L9_2 = true
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    pop_multiplier_id = L1_2
    L1_2 = MISC
    L1_2 = L1_2.CLEAR_AREA
    L2_2 = 1.1
    L3_2 = 1.1
    L4_2 = 1.1
    L5_2 = 19999.9
    L6_2 = true
    L7_2 = false
    L8_2 = false
    L9_2 = true
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  else
    L1_2 = MISC
    L1_2 = L1_2.REMOVE_POP_MULTIPLIER_SPHERE
    L2_2 = pop_multiplier_id
    L3_2 = false
    L1_2(L2_2, L3_2)
  end
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "appearance"
L19_1 = _ENV
L20_1 = "menu"
L19_1 = L19_1[L20_1]
L20_1 = "list"
L19_1 = L19_1[L20_1]
L20_1 = _ENV
L21_1 = "funfeatures"
L20_1 = L20_1[L21_1]
L21_1 = "伪装"
L19_1 = L19_1(L20_1, L21_1)
L17_1[L18_1] = L19_1
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle
L18_1 = _ENV
L19_1 = "appearance"
L18_1 = L18_1[L19_1]
L19_1 = "开始伪装"
L20_1 = {}
L21_1 = ""
function L22_1(A0_2)
  local L1_2, L2_2
  L1_2 = player_disguise
  L2_2 = A0_2
  L1_2(L2_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L18_1 = "list_select"
L17_1 = L17_1[L18_1]
L18_1 = _ENV
L19_1 = "appearance"
L18_1 = L18_1[L19_1]
L19_1 = "伪装选择"
L20_1 = {}
L21_1 = ""
L22_1 = _ENV
L23_1 = "disguise_names"
L22_1 = L22_1[L23_1]
L23_1 = 0
function L24_1(A0_2)
  local L1_2, L2_2
  L1_2 = player_disguise_select
  L2_2 = A0_2
  L1_2(L2_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "恶灵骑士"
L20_1 = {}
L21_1 = ""
function L22_1(A0_2)
  local L1_2, L2_2
  L1_2 = elqss
  L2_2 = A0_2
  L1_2(L2_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "驾驶飞天扫帚"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2
  L0_2 = flying_broom
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "acrobatics"
L19_1 = _ENV
L20_1 = "menu"
L19_1 = L19_1[L20_1]
L20_1 = "list"
L19_1 = L19_1[L20_1]
L20_1 = _ENV
L21_1 = "funfeatures"
L20_1 = L20_1[L21_1]
L21_1 = "车辆跳跃"
L22_1 = {}
L23_1 = ""
L19_1 = L19_1(L20_1, L21_1, L22_1, L23_1)
L17_1[L18_1] = L19_1
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "acrobatics"
L18_1 = L18_1[L19_1]
L19_1 = "豚跳"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L0_2 = get_vehicle_player_is_in
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  L1_2 = ENTITY
  L1_2 = L1_2.DOES_ENTITY_EXIST
  L2_2 = L0_2
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L1_2 = VEHICLE
    L1_2 = L1_2.IS_VEHICLE_ON_ALL_WHEELS
    L2_2 = L0_2
    L1_2 = L1_2(L2_2)
    if L1_2 then
      L1_2 = request_control
      L2_2 = L0_2
      L3_2 = 1000
      L1_2 = L1_2(L2_2, L3_2)
      if L1_2 then
        L1_2 = ENTITY
        L1_2 = L1_2.APPLY_FORCE_TO_ENTITY
        L2_2 = L0_2
        L3_2 = 1
        L4_2 = 0.0
        L5_2 = 0.0
        L6_2 = 10.0
        L7_2 = 0.0
        L8_2 = 0.0
        L9_2 = 0.0
        L10_2 = 1
        L11_2 = false
        L12_2 = true
        L13_2 = true
        L14_2 = true
        L15_2 = true
        L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
      end
    end
  end
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "acrobatics"
L18_1 = L18_1[L19_1]
L19_1 = "左侧空翻"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L0_2 = get_vehicle_player_is_in
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  L1_2 = ENTITY
  L1_2 = L1_2.DOES_ENTITY_EXIST
  L2_2 = L0_2
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L1_2 = VEHICLE
    L1_2 = L1_2.IS_VEHICLE_ON_ALL_WHEELS
    L2_2 = L0_2
    L1_2 = L1_2(L2_2)
    if L1_2 then
      L1_2 = request_control
      L2_2 = L0_2
      L3_2 = 1000
      L1_2 = L1_2(L2_2, L3_2)
      if L1_2 then
        L1_2 = ENTITY
        L1_2 = L1_2.APPLY_FORCE_TO_ENTITY
        L2_2 = L0_2
        L3_2 = 1
        L4_2 = 0.0
        L5_2 = 0.0
        L6_2 = 10.71
        L7_2 = 5.0
        L8_2 = 0.0
        L9_2 = 0.0
        L10_2 = 1
        L11_2 = false
        L12_2 = true
        L13_2 = true
        L14_2 = true
        L15_2 = true
        L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
      end
    end
  end
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "acrobatics"
L18_1 = L18_1[L19_1]
L19_1 = "双左侧空翻"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L0_2 = get_vehicle_player_is_in
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  L1_2 = ENTITY
  L1_2 = L1_2.DOES_ENTITY_EXIST
  L2_2 = L0_2
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L1_2 = VEHICLE
    L1_2 = L1_2.IS_VEHICLE_ON_ALL_WHEELS
    L2_2 = L0_2
    L1_2 = L1_2(L2_2)
    if L1_2 then
      L1_2 = request_control
      L2_2 = L0_2
      L3_2 = 1000
      L1_2 = L1_2(L2_2, L3_2)
      if L1_2 then
        L1_2 = ENTITY
        L1_2 = L1_2.APPLY_FORCE_TO_ENTITY
        L2_2 = L0_2
        L3_2 = 1
        L4_2 = 0.0
        L5_2 = 0.0
        L6_2 = 21.43
        L7_2 = 20.0
        L8_2 = 0.0
        L9_2 = 0.0
        L10_2 = 1
        L11_2 = false
        L12_2 = true
        L13_2 = true
        L14_2 = true
        L15_2 = true
        L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
      end
    end
  end
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "acrobatics"
L18_1 = L18_1[L19_1]
L19_1 = "右侧空翻"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L0_2 = get_vehicle_player_is_in
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  L1_2 = ENTITY
  L1_2 = L1_2.DOES_ENTITY_EXIST
  L2_2 = L0_2
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L1_2 = VEHICLE
    L1_2 = L1_2.IS_VEHICLE_ON_ALL_WHEELS
    L2_2 = L0_2
    L1_2 = L1_2(L2_2)
    if L1_2 then
      L1_2 = request_control
      L2_2 = L0_2
      L3_2 = 1000
      L1_2 = L1_2(L2_2, L3_2)
      if L1_2 then
        L1_2 = ENTITY
        L1_2 = L1_2.APPLY_FORCE_TO_ENTITY
        L2_2 = L0_2
        L3_2 = 1
        L4_2 = 0.0
        L5_2 = 0.0
        L6_2 = 10.71
        L7_2 = -5.0
        L8_2 = 0.0
        L9_2 = 0.0
        L10_2 = 1
        L11_2 = false
        L12_2 = true
        L13_2 = true
        L14_2 = true
        L15_2 = true
        L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
      end
    end
  end
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "black_hole_lt"
L19_1 = _ENV
L20_1 = "menu"
L19_1 = L19_1[L20_1]
L20_1 = "list"
L19_1 = L19_1[L20_1]
L20_1 = _ENV
L21_1 = "funfeatures"
L20_1 = L20_1[L21_1]
L21_1 = "黑洞"
L22_1 = {}
L23_1 = ""
L19_1 = L19_1(L20_1, L21_1, L22_1, L23_1)
L17_1[L18_1] = L19_1
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle_loop
L18_1 = _ENV
L19_1 = "black_hole_lt"
L18_1 = L18_1[L19_1]
L19_1 = "黑洞"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2
  L0_2 = black_hole
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle_loop
L18_1 = _ENV
L19_1 = "black_hole_lt"
L18_1 = L18_1[L19_1]
L19_1 = "视觉帮助"
L20_1 = {}
L21_1 = "绘制一个黑洞圈"
function L22_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = GRAPHICS
  L0_2 = L0_2.DRAW_MARKER_SPHERE
  L1_2 = blackHolePos
  L1_2 = L1_2.x
  L2_2 = blackHolePos
  L2_2 = L2_2.y
  L3_2 = blackHolePos
  L3_2 = L3_2.z
  L4_2 = 1
  L5_2 = 0
  L6_2 = 0
  L7_2 = 0
  L8_2 = 0.8
  L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L18_1 = "list_select"
L17_1 = L17_1[L18_1]
L18_1 = _ENV
L19_1 = "black_hole_lt"
L18_1 = L18_1[L19_1]
L19_1 = "黑洞类型"
L20_1 = {}
L21_1 = ""
L22_1 = _ENV
L23_1 = "tableBlackHole"
L22_1 = L22_1[L23_1]
L23_1 = 1
function L24_1(A0_2)
  local L1_2, L2_2
  L1_2 = black_hole_type
  L2_2 = A0_2
  L1_2(L2_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.slider
L18_1 = _ENV
L19_1 = "black_hole_lt"
L18_1 = L18_1[L19_1]
L19_1 = "设置黑洞强度"
L20_1 = {}
L21_1 = ""
L22_1 = 1
L23_1 = 100
L24_1 = 1
L25_1 = 1
function L26_1(A0_2)
  local L1_2, L2_2
  L1_2 = black_hole_Sth
  L2_2 = A0_2
  L1_2(L2_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1)
L17_1 = _ENV
L18_1 = "black_hole_coord"
L19_1 = _ENV
L20_1 = "menu"
L19_1 = L19_1[L20_1]
L20_1 = "list"
L19_1 = L19_1[L20_1]
L20_1 = _ENV
L21_1 = "black_hole_lt"
L20_1 = L20_1[L21_1]
L21_1 = "设定位置"
L22_1 = {}
L23_1 = ""
L19_1 = L19_1(L20_1, L21_1, L22_1, L23_1)
L17_1[L18_1] = L19_1
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "black_hole_coord"
L18_1 = L18_1[L19_1]
L19_1 = "在自身处设置黑洞位置"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2
  L0_2 = black_hole_posuser
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "blackHolePosX"
L19_1 = _ENV
L20_1 = "menu"
L19_1 = L19_1[L20_1]
L19_1 = L19_1.slider
L20_1 = _ENV
L21_1 = "black_hole_coord"
L20_1 = L20_1[L21_1]
L21_1 = "黑洞位置 X"
L22_1 = {}
L23_1 = "coordBlackHoleX"
L22_1[1] = L23_1
L23_1 = ""
L24_1 = -100000
L25_1 = 100000
L26_1 = 0
L27_1 = 1
function L28_1(A0_2)
  local L1_2, L2_2
  L1_2 = black_hole_posx
  L2_2 = A0_2
  L1_2(L2_2)
end
L19_1 = L19_1(L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1)
L17_1[L18_1] = L19_1
L17_1 = _ENV
L18_1 = "blackHolePosY"
L19_1 = _ENV
L20_1 = "menu"
L19_1 = L19_1[L20_1]
L19_1 = L19_1.slider
L20_1 = _ENV
L21_1 = "black_hole_coord"
L20_1 = L20_1[L21_1]
L21_1 = "黑洞位置 Y"
L22_1 = {}
L23_1 = "coordBlackHoleY"
L22_1[1] = L23_1
L23_1 = ""
L24_1 = -100000
L25_1 = 100000
L26_1 = 0
L27_1 = 1
function L28_1(A0_2)
  local L1_2, L2_2
  L1_2 = black_hole_posy
  L2_2 = A0_2
  L1_2(L2_2)
end
L19_1 = L19_1(L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1)
L17_1[L18_1] = L19_1
L17_1 = _ENV
L18_1 = "blackHolePosZ"
L19_1 = _ENV
L20_1 = "menu"
L19_1 = L19_1[L20_1]
L19_1 = L19_1.slider
L20_1 = _ENV
L21_1 = "black_hole_coord"
L20_1 = L20_1[L21_1]
L21_1 = "黑洞位置 Z"
L22_1 = {}
L23_1 = "coordBlackHoleZ"
L22_1[1] = L23_1
L23_1 = ""
L24_1 = -100000
L25_1 = 100000
L26_1 = 0
L27_1 = 1
function L28_1(A0_2)
  local L1_2, L2_2
  L1_2 = black_hole_posz
  L2_2 = A0_2
  L1_2(L2_2)
end
L19_1 = L19_1(L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1)
L17_1[L18_1] = L19_1
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle_loop
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "神指"
L20_1 = {}
L21_1 = "godfinger"
L20_1[1] = L21_1
L21_1 = "按B使用"
function L22_1()
  local L0_2, L1_2
  L0_2 = godfinger
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle_loop
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "NPC雨"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2
  L0_2 = Npc_Rain
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle_loop
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "载具雨"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2
  L0_2 = Vehicle_Rain
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle_loop
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "陨落的飞机"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2
  L0_2 = start_angryplanes_thread
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "生成多米诺骨牌"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L0_2 = util
  L0_2 = L0_2.joaat
  L1_2 = "prop_boogieboard_01"
  L0_2 = L0_2(L1_2)
  L1_2 = request_model
  L2_2 = L0_2
  L1_2(L2_2)
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = 2
  L3_2 = 25
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = ENTITY
    L6_2 = L6_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
    L7_2 = L1_2
    L8_2 = 0
    L9_2 = L5_2
    L10_2 = 0
    L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
    L7_2 = entities
    L7_2 = L7_2.create_object
    L8_2 = L0_2
    L9_2 = L6_2
    L7_2 = L7_2(L8_2, L9_2)
    L8_2 = ENTITY
    L8_2 = L8_2.SET_ENTITY_HEADING
    L9_2 = L7_2
    L10_2 = ENTITY
    L10_2 = L10_2.GET_ENTITY_HEADING
    L11_2 = L1_2
    L10_2, L11_2 = L10_2(L11_2)
    L8_2(L9_2, L10_2, L11_2)
    L8_2 = OBJECT
    L8_2 = L8_2.PLACE_OBJECT_ON_GROUND_PROPERLY
    L9_2 = L7_2
    L8_2(L9_2)
  end
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "drop_soccer"
L19_1 = _ENV
L20_1 = "menu"
L19_1 = L19_1[L20_1]
L20_1 = "list"
L19_1 = L19_1[L20_1]
L20_1 = _ENV
L21_1 = "funfeatures"
L20_1 = L20_1[L21_1]
L21_1 = "足球"
L22_1 = {}
L23_1 = ""
L19_1 = L19_1(L20_1, L21_1, L22_1, L23_1)
L17_1[L18_1] = L19_1
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "drop_soccer"
L18_1 = L18_1[L19_1]
L19_1 = "掉落足球"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2, L2_2
  L0_2 = ball_drop
  L1_2 = players
  L1_2 = L1_2.get_position
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_ID
  L2_2 = L2_2()
  L1_2, L2_2 = L1_2(L2_2)
  L0_2(L1_2, L2_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle_loop
L18_1 = _ENV
L19_1 = "drop_soccer"
L18_1 = L18_1[L19_1]
L19_1 = "混乱足球"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2, L2_2
  L0_2 = ball_drop
  L1_2 = players
  L1_2 = L1_2.get_position
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_ID
  L2_2 = L2_2()
  L1_2, L2_2 = L1_2(L2_2)
  L0_2(L1_2, L2_2)
  L0_2 = util
  L0_2 = L0_2.yield
  L1_2 = 250
  L0_2(L1_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "drop_soccer"
L18_1 = L18_1[L19_1]
L19_1 = "清理"
L20_1 = {}
L21_1 = "Clean up your mess"
function L22_1()
  local L0_2, L1_2
  L0_2 = delete_all_soccer
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle_loop
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "一拳超人"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2
  L0_2 = supermanpersonl
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "原力"
L20_1 = {}
L21_1 = "通过鼠标左键或右键来控制"
function L22_1(A0_2)
  local L1_2, L2_2
  L1_2 = atom_force
  L2_2 = A0_2
  L1_2(L2_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "定点打击"
L20_1 = {}
L21_1 = "打击指定地点"
function L22_1()
  local L0_2, L1_2
  L0_2 = targeted_strike
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle_loop
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "定点循环轰炸"
L20_1 = {}
L21_1 = "标点指定轰炸"
function L22_1()
  local L0_2, L1_2
  L0_2 = targeted_loop_strike
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle_loop
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "地毯飞行"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2
  L0_2 = carpetridexx
  L0_2()
end
function L23_1()
  local L0_2, L1_2
  L0_2 = carpetridexx1
  L0_2()
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1, L23_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.toggle
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "举起手来"
L20_1 = {}
L21_1 = "长按x"
function L22_1(A0_2)
  local L1_2
  handsup = A0_2
  while true do
    L1_2 = handsup
    if not L1_2 then
      break
    end
    L1_2 = juqishoulai
    L1_2()
    L1_2 = util
    L1_2 = L1_2.yield
    L1_2()
  end
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = _ENV
L18_1 = "menu"
L17_1 = L17_1[L18_1]
L17_1 = L17_1.action
L18_1 = _ENV
L19_1 = "funfeatures"
L18_1 = L18_1[L19_1]
L19_1 = "自定义假R*警告"
L20_1 = {}
L21_1 = ""
function L22_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = util
  L0_2 = L0_2.register_label
  L1_2 = "输入自定义文本"
  L0_2 = L0_2(L1_2)
  L1_2 = get_input_from_screen_keyboard
  L2_2 = L0_2
  L3_2 = 254
  L4_2 = ""
  L1_2 = L1_2(L2_2, L3_2, L4_2)
  if "" == L1_2 then
    return
  end
  L2_2 = custom_alert
  L3_2 = L1_2
  L2_2(L3_2)
end
L17_1(L18_1, L19_1, L20_1, L21_1, L22_1)
L17_1 = 0
L18_1 = _ENV
L19_1 = "menu"
L18_1 = L18_1[L19_1]
L18_1 = L18_1.toggle_loop
L19_1 = _ENV
L20_1 = "funfeatures"
L19_1 = L19_1[L20_1]
L20_1 = "爆炸圈"
L21_1 = {}
L22_1 = "在周围生成爆炸圈"
function L23_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = PLAYER
  L0_2 = L0_2.GET_PLAYER_PED_SCRIPT_INDEX
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2, L2_2, L3_2, L4_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2)
  L1_2 = explosion_circle
  L2_2 = L0_2
  L3_2 = L17_1
  L4_2 = 25
  L1_2(L2_2, L3_2, L4_2)
  L1_2 = L17_1
  L1_2 = L1_2 + 0.15
  L17_1 = L1_2
  L1_2 = util
  L1_2 = L1_2.yield
  L2_2 = 50
  L1_2(L2_2)
end
L18_1(L19_1, L20_1, L21_1, L22_1, L23_1)
L18_1 = _ENV
L19_1 = "menu"
L18_1 = L18_1[L19_1]
L18_1 = L18_1.toggle_loop
L19_1 = _ENV
L20_1 = "funfeatures"
L19_1 = L19_1[L20_1]
L20_1 = "钢铁侠"
L21_1 = {}
L22_1 = ""
function L23_1()
  local L0_2, L1_2
  L0_2 = Iron_Man
  L0_2()
end
function L24_1()
  local L0_2, L1_2
  L0_2 = Iron_Man_stop
  L0_2()
end
L18_1(L19_1, L20_1, L21_1, L22_1, L23_1, L24_1)
L18_1 = _ENV
L19_1 = "menu"
L18_1 = L18_1[L19_1]
L18_1 = L18_1.toggle_loop
L19_1 = _ENV
L20_1 = "funfeatures"
L19_1 = L19_1[L20_1]
L20_1 = "UFO勇闯洛城"
L21_1 = {}
L22_1 = "在你的周围随机生成UFO"
function L23_1(A0_2)
  local L1_2, L2_2
  L1_2 = UFO_Los_Angeles
  L2_2 = A0_2
  L1_2(L2_2)
end
L18_1(L19_1, L20_1, L21_1, L22_1, L23_1)
L18_1 = _ENV
L19_1 = "menu"
L18_1 = L18_1[L19_1]
L18_1 = L18_1.toggle
L19_1 = _ENV
L20_1 = "funfeatures"
L19_1 = L19_1[L20_1]
L20_1 = "洛城暴乱"
L21_1 = {}
L22_1 = "开启后,周围的npc会进入无差别攻击模式!"
function L23_1(A0_2)
  local L1_2, L2_2
  L1_2 = MISC
  L1_2 = L1_2.SET_RIOT_MODE_ENABLED
  L2_2 = A0_2
  L1_2(L2_2)
end
L18_1(L19_1, L20_1, L21_1, L22_1, L23_1)
L18_1 = _ENV
L19_1 = "ped_cats"
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "list"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "funfeatures"
L21_1 = L21_1[L22_1]
L22_1 = "宠物猫"
L23_1 = {}
L24_1 = ""
L20_1 = L20_1(L21_1, L22_1, L23_1, L24_1)
L18_1[L19_1] = L20_1
L18_1 = _ENV
L19_1 = "menu"
L18_1 = L18_1[L19_1]
L18_1 = L18_1.toggle_loop
L19_1 = _ENV
L20_1 = "ped_cats"
L19_1 = L19_1[L20_1]
L20_1 = "宠物猫"
L21_1 = {}
L22_1 = "招一只可爱的小猫咪\n跟着你喵喵叫!"
function L23_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = cat_pedp
  if L0_2 then
    L0_2 = ENTITY
    L0_2 = L0_2.DOES_ENTITY_EXIST
    L1_2 = cat_pedp
    L0_2 = L0_2(L1_2)
    if L0_2 then
      goto lbl_44
    end
  end
  L0_2 = util
  L0_2 = L0_2.joaat
  L1_2 = "a_c_cat_01"
  L0_2 = L0_2(L1_2)
  L1_2 = request_model
  L2_2 = L0_2
  L1_2(L2_2)
  L1_2 = players
  L1_2 = L1_2.get_position
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_ID
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L2_2 = entities
  L2_2 = L2_2.create_ped
  L3_2 = 28
  L4_2 = L0_2
  L5_2 = L1_2
  L6_2 = 0
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  cat_pedp = L2_2
  L2_2 = PED
  L2_2 = L2_2.SET_PED_COMPONENT_VARIATION
  L3_2 = cat_pedp
  L4_2 = 0
  L5_2 = 0
  L6_2 = 1
  L7_2 = 0
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = ENTITY
  L2_2 = L2_2.SET_ENTITY_INVINCIBLE
  L3_2 = cat_pedp
  L4_2 = true
  L2_2(L3_2, L4_2)
  ::lbl_44::
  L0_2 = NETWORK
  L0_2 = L0_2.NETWORK_REQUEST_CONTROL_OF_ENTITY
  L1_2 = cat_pedp
  L0_2(L1_2)
  L0_2 = TASK
  L0_2 = L0_2.TASK_FOLLOW_TO_OFFSET_OF_ENTITY
  L1_2 = cat_pedp
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = 0
  L4_2 = -0.3
  L5_2 = 0
  L6_2 = 7.0
  L7_2 = -1
  L8_2 = 1.5
  L9_2 = true
  L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L0_2 = util
  L0_2 = L0_2.yield
  L1_2 = 2500
  L0_2(L1_2)
end
function L24_1()
  local L0_2, L1_2
  L0_2 = delete_entity
  L1_2 = cat_pedp
  L0_2(L1_2)
end
L18_1(L19_1, L20_1, L21_1, L22_1, L23_1, L24_1)
L18_1 = _ENV
L19_1 = "menu"
L18_1 = L18_1[L19_1]
L18_1 = L18_1.action
L19_1 = _ENV
L20_1 = "ped_cats"
L19_1 = L19_1[L20_1]
L20_1 = "找到猫猫"
L21_1 = {}
L22_1 = "将猫猫传送到你身边"
function L23_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = PLAYER
  L0_2 = L0_2.PLAYER_PED_ID
  L0_2 = L0_2()
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_COORDS
  L2_2 = L0_2
  L3_2 = false
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = ENTITY
  L2_2 = L2_2.SET_ENTITY_COORDS_NO_OFFSET
  L3_2 = cat_pedp
  L4_2 = L1_2.x
  L5_2 = L1_2.y
  L6_2 = L1_2.z
  L7_2 = false
  L8_2 = false
  L9_2 = false
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
end
L18_1(L19_1, L20_1, L21_1, L22_1, L23_1)
L18_1 = {}
L19_1 = _ENV
L20_1 = "menu"
L19_1 = L19_1[L20_1]
L20_1 = "list"
L19_1 = L19_1[L20_1]
L20_1 = _ENV
L21_1 = "ped_cats"
L20_1 = L20_1[L21_1]
L21_1 = "宠物猫猫军队"
L22_1 = {}
L23_1 = "哈哈哈,一群小猫猫"
L19_1 = L19_1(L20_1, L21_1, L22_1, L23_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "click_slider"
L20_1 = L20_1[L21_1]
L21_1 = L19_1
L22_1 = "生成数量"
L23_1 = {}
L24_1 = "选吧,多生成点,最多256只"
L25_1 = 1
L26_1 = 256
L27_1 = 30
L28_1 = 1
function L29_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = L1_2
  L4_2 = false
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = L2_2.y
  L3_2 = L3_2 - 5
  L2_2.y = L3_2
  L3_2 = L2_2.z
  L3_2 = L3_2 + 1
  L2_2.z = L3_2
  L3_2 = util
  L3_2 = L3_2.joaat
  L4_2 = "a_c_cat_01"
  L3_2 = L3_2(L4_2)
  L4_2 = request_model
  L5_2 = L3_2
  L4_2(L5_2)
  L4_2 = 1
  L5_2 = A0_2
  L6_2 = 1
  for L7_2 = L4_2, L5_2, L6_2 do
    L8_2 = L18_1
    L9_2 = entities
    L9_2 = L9_2.create_ped
    L10_2 = 28
    L11_2 = L3_2
    L12_2 = L2_2
    L13_2 = 0
    L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2)
    L8_2[L7_2] = L9_2
    L8_2 = ENTITY
    L8_2 = L8_2.SET_ENTITY_INVINCIBLE
    L9_2 = L18_1
    L9_2 = L9_2[L7_2]
    L10_2 = true
    L8_2(L9_2, L10_2)
    L8_2 = PED
    L8_2 = L8_2.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS
    L9_2 = L18_1
    L9_2 = L9_2[L7_2]
    L10_2 = true
    L8_2(L9_2, L10_2)
    L8_2 = PED
    L8_2 = L8_2.SET_PED_COMPONENT_VARIATION
    L9_2 = L18_1
    L9_2 = L9_2[L7_2]
    L10_2 = 0
    L11_2 = 0
    L12_2 = 1
    L13_2 = 0
    L8_2(L9_2, L10_2, L11_2, L12_2, L13_2)
    L8_2 = TASK
    L8_2 = L8_2.TASK_FOLLOW_TO_OFFSET_OF_ENTITY
    L9_2 = L18_1
    L9_2 = L9_2[L7_2]
    L10_2 = L1_2
    L11_2 = 0
    L12_2 = -0.3
    L13_2 = 0
    L14_2 = 7.0
    L15_2 = -1
    L16_2 = 10
    L17_2 = true
    L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
    L8_2 = util
    L8_2 = L8_2.yield
    L8_2()
  end
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L20_1 = L20_1.action
L21_1 = L19_1
L22_1 = "清除宠物猫"
L23_1 = {}
L24_1 = ""
function L25_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = ipairs
  L1_2 = entities
  L1_2 = L1_2.get_all_peds_as_handles
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L1_2()
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = PED
    L6_2 = L6_2.IS_PED_MODEL
    L7_2 = L5_2
    L8_2 = util
    L8_2 = L8_2.joaat
    L9_2 = "a_c_cat_01"
    L8_2, L9_2 = L8_2(L9_2)
    L6_2 = L6_2(L7_2, L8_2, L9_2)
    if L6_2 then
      L6_2 = delete_entity
      L7_2 = L5_2
      L6_2(L7_2)
    end
  end
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L20_1 = L20_1.toggle_loop
L21_1 = _ENV
L22_1 = "funfeatures"
L21_1 = L21_1[L22_1]
L22_1 = "激光眼"
L23_1 = {}
L24_1 = "按住E键"
function L25_1(A0_2)
  local L1_2
  L1_2 = laser_eyes
  L1_2()
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L20_1 = L20_1.toggle_loop
L21_1 = _ENV
L22_1 = "funfeatures"
L21_1 = L21_1[L22_1]
L22_1 = "镭射炮"
L23_1 = {}
L24_1 = ""
function L25_1()
  local L0_2, L1_2
  L0_2 = Laser_cannon
  L0_2()
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "finger_thing"
L22_1 = _ENV
L23_1 = "menu"
L22_1 = L22_1[L23_1]
L23_1 = "list"
L22_1 = L22_1[L23_1]
L23_1 = _ENV
L24_1 = "funfeatures"
L23_1 = L23_1[L24_1]
L24_1 = "手指枪"
L25_1 = {}
L26_1 = "按B键"
L22_1 = L22_1(L23_1, L24_1, L25_1, L26_1)
L20_1[L21_1] = L22_1
L20_1 = _ENV
L21_1 = "shouzhiqiang"
L20_1 = L20_1[L21_1]
L20_1()
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L20_1 = L20_1.toggle
L21_1 = _ENV
L22_1 = "funfeatures"
L21_1 = L21_1[L22_1]
L22_1 = "力场"
L23_1 = {}
L24_1 = ""
function L25_1(A0_2)
  local L1_2, L2_2
  L1_2 = force_Field
  L2_2 = A0_2
  L1_2(L2_2)
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "force_field"
L22_1 = _ENV
L23_1 = "menu"
L22_1 = L22_1[L23_1]
L23_1 = "list"
L22_1 = L22_1[L23_1]
L23_1 = _ENV
L24_1 = "funfeatures"
L23_1 = L23_1[L24_1]
L24_1 = "力场Pro"
L25_1 = {}
L26_1 = ""
L22_1 = L22_1(L23_1, L24_1, L25_1, L26_1)
L20_1[L21_1] = L22_1
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L20_1 = L20_1.toggle_loop
L21_1 = _ENV
L22_1 = "force_field"
L21_1 = L21_1[L22_1]
L22_1 = "开启"
L23_1 = {}
L24_1 = ""
function L25_1()
  local L0_2, L1_2
  L0_2 = force_Field_pro
  L0_2()
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "list_select"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "force_field"
L21_1 = L21_1[L22_1]
L22_1 = "力场方向"
L23_1 = {}
L24_1 = ""
L25_1 = _ENV
L26_1 = "s_forcefield_names"
L25_1 = L25_1[L26_1]
L26_1 = 0
function L27_1(A0_2)
  local L1_2, L2_2
  L1_2 = force_Field_direction
  L2_2 = A0_2
  L1_2(L2_2)
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "slider_float"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "force_field"
L21_1 = L21_1[L22_1]
L22_1 = "力场范围"
L23_1 = {}
L24_1 = "sforcefieldrange"
L23_1[1] = L24_1
L24_1 = ""
L25_1 = 100
L26_1 = 10000
L27_1 = 2000
L28_1 = 100
function L29_1(A0_2)
  local L1_2, L2_2
  L1_2 = force_Field_range
  L2_2 = A0_2
  L1_2(L2_2)
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L20_1 = L20_1.toggle_loop
L21_1 = _ENV
L22_1 = "force_field"
L21_1 = L21_1[L22_1]
L22_1 = "绘制力场范围"
L23_1 = {}
L24_1 = ""
function L25_1()
  local L0_2, L1_2
  L0_2 = Plot_force_field_range
  L0_2()
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L20_1 = L20_1.action
L21_1 = _ENV
L22_1 = "sk"
L21_1 = L21_1[L22_1]
L22_1 = "无效降落伞"
L23_1 = {}
L24_1 = ""
function L25_1()
  local L0_2, L1_2
  L0_2 = Invalid_parachute
  L0_2()
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L20_1 = L20_1.action
L21_1 = _ENV
L22_1 = "sk"
L21_1 = L21_1[L22_1]
L22_1 = "载具伞崩全局"
L23_1 = {}
L24_1 = "崩溃全局"
function L25_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L0_2 = ENTITY
  L0_2 = L0_2.GET_ENTITY_COORDS
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = true
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = 0
  L2_2 = 31
  L3_2 = 1
  for L4_2 = L1_2, L2_2, L3_2 do
    L5_2 = ENTITY
    L5_2 = L5_2.GET_ENTITY_COORDS
    L6_2 = PLAYER
    L6_2 = L6_2.PLAYER_PED_ID
    L6_2 = L6_2()
    L7_2 = true
    L5_2 = L5_2(L6_2, L7_2)
    L6_2 = PLAYER
    L6_2 = L6_2.GET_PLAYER_PED
    L7_2 = L4_2
    L6_2 = L6_2(L7_2)
    L7_2 = create_vehicle
    L8_2 = util
    L8_2 = L8_2.joaat
    L9_2 = "Ruiner2"
    L8_2 = L8_2(L9_2)
    L9_2 = L5_2.x
    L10_2 = L5_2.y
    L11_2 = L5_2.z
    L12_2 = ENTITY
    L12_2 = L12_2.GET_ENTITY_HEADING
    L13_2 = L6_2
    L12_2, L13_2, L14_2, L15_2 = L12_2(L13_2)
    L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
    L8_2 = PED
    L8_2 = L8_2.SET_PED_INTO_VEHICLE
    L9_2 = PLAYER
    L9_2 = L9_2.PLAYER_PED_ID
    L9_2 = L9_2()
    L10_2 = L7_2
    L11_2 = -1
    L8_2(L9_2, L10_2, L11_2)
    L8_2 = ENTITY
    L8_2 = L8_2.SET_ENTITY_COORDS_NO_OFFSET
    L9_2 = L7_2
    L10_2 = L5_2.x
    L11_2 = L5_2.y
    L12_2 = 1000
    L13_2 = false
    L14_2 = true
    L15_2 = true
    L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
    L8_2 = util
    L8_2 = L8_2.yield
    L9_2 = 200
    L8_2(L9_2)
    L8_2 = VEHICLE1
    L8_2 = L8_2._SET_VEHICLE_PARACHUTE_MODEL
    L9_2 = L7_2
    L10_2 = util
    L10_2 = L10_2.joaat
    L11_2 = "prop_beach_parasol_05"
    L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L10_2(L11_2)
    L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
    L8_2 = VEHICLE1
    L8_2 = L8_2._SET_VEHICLE_PARACHUTE_ACTIVE
    L9_2 = L7_2
    L10_2 = true
    L8_2(L9_2, L10_2)
    L8_2 = util
    L8_2 = L8_2.yield
    L9_2 = 200
    L8_2(L9_2)
    L8_2 = delete_entity
    L9_2 = L7_2
    L8_2(L9_2)
  end
  L1_2 = ENTITY
  L1_2 = L1_2.SET_ENTITY_COORDS_NO_OFFSET
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = L0_2.x
  L4_2 = L0_2.y
  L5_2 = L0_2.z
  L6_2 = false
  L7_2 = true
  L8_2 = true
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L20_1 = L20_1.toggle_loop
L21_1 = _ENV
L22_1 = "sk"
L21_1 = L21_1[L22_1]
L22_1 = "飞机模型崩溃"
L23_1 = {}
L24_1 = ""
function L25_1()
  local L0_2, L1_2
  L0_2 = airplane_collapsed1
  L0_2()
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L20_1 = L20_1.action
L21_1 = _ENV
L22_1 = "sk"
L21_1 = L21_1[L22_1]
L22_1 = "崩溃主机"
L23_1 = {}
L24_1 = "使用前请确认自己是否为主机"
function L25_1(A0_2)
  local L1_2, L2_2
  L1_2 = hostcrash
  L2_2 = A0_2
  L1_2(L2_2)
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L20_1 = L20_1.action
L21_1 = _ENV
L22_1 = "sk"
L21_1 = L21_1[L22_1]
L22_1 = "人物伞崩V1"
L23_1 = {}
L24_1 = ""
function L25_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L0_2 = PLAYER
  L0_2 = L0_2.GET_PLAYER_PED_SCRIPT_INDEX
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_COORDS
  L2_2 = L0_2
  L3_2 = true
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = 0
  L3_2 = 3
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = util
    L6_2 = L6_2.joaat
    L7_2 = "prop_logpile_06b"
    L6_2 = L6_2(L7_2)
    L7_2 = request_model
    L8_2 = L6_2
    L7_2(L8_2)
    L7_2 = PLAYER
    L7_2 = L7_2.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE
    L8_2 = PLAYER
    L8_2 = L8_2.PLAYER_ID
    L8_2 = L8_2()
    L9_2 = L6_2
    L7_2(L8_2, L9_2)
    L7_2 = ENTITY
    L7_2 = L7_2.SET_ENTITY_COORDS_NO_OFFSET
    L8_2 = L0_2
    L9_2 = 0
    L10_2 = 0
    L11_2 = 500
    L12_2 = false
    L13_2 = true
    L14_2 = true
    L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    L7_2 = WEAPON
    L7_2 = L7_2.GIVE_DELAYED_WEAPON_TO_PED
    L8_2 = L0_2
    L9_2 = 4222310262
    L10_2 = 1000
    L11_2 = false
    L7_2(L8_2, L9_2, L10_2, L11_2)
    L7_2 = util
    L7_2 = L7_2.yield
    L8_2 = 1000
    L7_2(L8_2)
    L7_2 = 0
    L8_2 = 20
    L9_2 = 1
    for L10_2 = L7_2, L8_2, L9_2 do
      L11_2 = PED
      L11_2 = L11_2.FORCE_PED_TO_OPEN_PARACHUTE
      L12_2 = L0_2
      L11_2(L12_2)
    end
    L7_2 = util
    L7_2 = L7_2.yield
    L8_2 = 1000
    L7_2(L8_2)
    L7_2 = ENTITY
    L7_2 = L7_2.SET_ENTITY_COORDS_NO_OFFSET
    L8_2 = L0_2
    L9_2 = L1_2.x
    L10_2 = L1_2.y
    L11_2 = L1_2.z
    L12_2 = false
    L13_2 = true
    L14_2 = true
    L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    L7_2 = util
    L7_2 = L7_2.joaat
    L8_2 = "prop_beach_parasol_03"
    L7_2 = L7_2(L8_2)
    L8_2 = request_model
    L9_2 = L7_2
    L8_2(L9_2)
    L8_2 = PLAYER
    L8_2 = L8_2.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE
    L9_2 = PLAYER
    L9_2 = L9_2.PLAYER_ID
    L9_2 = L9_2()
    L10_2 = L7_2
    L8_2(L9_2, L10_2)
    L8_2 = ENTITY
    L8_2 = L8_2.SET_ENTITY_COORDS_NO_OFFSET
    L9_2 = L0_2
    L10_2 = 0
    L11_2 = 0
    L12_2 = 500
    L13_2 = 0
    L14_2 = 0
    L15_2 = 1
    L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
    L8_2 = WEAPON
    L8_2 = L8_2.GIVE_DELAYED_WEAPON_TO_PED
    L9_2 = L0_2
    L10_2 = 4222310262
    L11_2 = 1000
    L12_2 = false
    L8_2(L9_2, L10_2, L11_2, L12_2)
    L8_2 = util
    L8_2 = L8_2.yield
    L9_2 = 1000
    L8_2(L9_2)
    L8_2 = 0
    L9_2 = 20
    L10_2 = 1
    for L11_2 = L8_2, L9_2, L10_2 do
      L12_2 = PED
      L12_2 = L12_2.FORCE_PED_TO_OPEN_PARACHUTE
      L13_2 = L0_2
      L12_2(L13_2)
    end
    L8_2 = util
    L8_2 = L8_2.yield
    L9_2 = 1000
    L8_2(L9_2)
    L8_2 = ENTITY
    L8_2 = L8_2.SET_ENTITY_COORDS_NO_OFFSET
    L9_2 = L0_2
    L10_2 = L1_2.x
    L11_2 = L1_2.y
    L12_2 = L1_2.z
    L13_2 = false
    L14_2 = true
    L15_2 = true
    L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  end
  L2_2 = ENTITY
  L2_2 = L2_2.SET_ENTITY_COORDS_NO_OFFSET
  L3_2 = L0_2
  L4_2 = L1_2.x
  L5_2 = L1_2.y
  L6_2 = L1_2.z
  L7_2 = false
  L8_2 = true
  L9_2 = true
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L20_1 = L20_1.action
L21_1 = _ENV
L22_1 = "sk"
L21_1 = L21_1[L22_1]
L22_1 = "人物伞崩V2"
L23_1 = {}
L24_1 = ""
function L25_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L0_2 = 0
  L1_2 = 5
  L2_2 = 1
  for L3_2 = L0_2, L1_2, L2_2 do
    L4_2 = PLAYER
    L4_2 = L4_2.GET_PLAYER_PED_SCRIPT_INDEX
    L5_2 = PLAYER
    L5_2 = L5_2.PLAYER_ID
    L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L5_2()
    L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    PEDP = L4_2
    object_hash = 1381105889
    L4_2 = STREAMING
    L4_2 = L4_2.REQUEST_MODEL
    L5_2 = object_hash
    L4_2(L5_2)
    while true do
      L4_2 = STREAMING
      L4_2 = L4_2.HAS_MODEL_LOADED
      L5_2 = object_hash
      L4_2 = L4_2(L5_2)
      if L4_2 then
        break
      end
      L4_2 = util
      L4_2 = L4_2.yield
      L4_2()
    end
    L4_2 = PLAYER
    L4_2 = L4_2.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE
    L5_2 = PLAYER
    L5_2 = L5_2.PLAYER_ID
    L5_2 = L5_2()
    L6_2 = object_hash
    L4_2(L5_2, L6_2)
    L4_2 = ENTITY
    L4_2 = L4_2.SET_ENTITY_COORDS_NO_OFFSET
    L5_2 = PEDP
    L6_2 = 0
    L7_2 = 0
    L8_2 = 500
    L9_2 = 0
    L10_2 = 0
    L11_2 = 1
    L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    L4_2 = WEAPON
    L4_2 = L4_2.GIVE_DELAYED_WEAPON_TO_PED
    L5_2 = PEDP
    L6_2 = 4222310262
    L7_2 = 1000
    L8_2 = false
    L4_2(L5_2, L6_2, L7_2, L8_2)
    L4_2 = util
    L4_2 = L4_2.yield
    L5_2 = 1000
    L4_2(L5_2)
    L4_2 = 0
    L5_2 = 20
    L6_2 = 1
    for L7_2 = L4_2, L5_2, L6_2 do
      L8_2 = PED
      L8_2 = L8_2.FORCE_PED_TO_OPEN_PARACHUTE
      L9_2 = PEDP
      L8_2(L9_2)
    end
    L4_2 = util
    L4_2 = L4_2.yield
    L5_2 = 1000
    L4_2(L5_2)
    L4_2 = menu
    L4_2 = L4_2.trigger_commands
    L5_2 = "tplsia"
    L4_2(L5_2)
    bush_hash = 720581693
    L4_2 = STREAMING
    L4_2 = L4_2.REQUEST_MODEL
    L5_2 = bush_hash
    L4_2(L5_2)
    while true do
      L4_2 = STREAMING
      L4_2 = L4_2.HAS_MODEL_LOADED
      L5_2 = bush_hash
      L4_2 = L4_2(L5_2)
      if L4_2 then
        break
      end
      L4_2 = util
      L4_2 = L4_2.yield
      L4_2()
    end
    L4_2 = PLAYER
    L4_2 = L4_2.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE
    L5_2 = PLAYER
    L5_2 = L5_2.PLAYER_ID
    L5_2 = L5_2()
    L6_2 = bush_hash
    L4_2(L5_2, L6_2)
    L4_2 = ENTITY
    L4_2 = L4_2.SET_ENTITY_COORDS_NO_OFFSET
    L5_2 = PEDP
    L6_2 = 0
    L7_2 = 0
    L8_2 = 500
    L9_2 = 0
    L10_2 = 0
    L11_2 = 1
    L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    L4_2 = WEAPON
    L4_2 = L4_2.GIVE_DELAYED_WEAPON_TO_PED
    L5_2 = PEDP
    L6_2 = 4222310262
    L7_2 = 1000
    L8_2 = false
    L4_2(L5_2, L6_2, L7_2, L8_2)
    L4_2 = util
    L4_2 = L4_2.yield
    L5_2 = 1000
    L4_2(L5_2)
    L4_2 = 0
    L5_2 = 20
    L6_2 = 1
    for L7_2 = L4_2, L5_2, L6_2 do
      L8_2 = PED
      L8_2 = L8_2.FORCE_PED_TO_OPEN_PARACHUTE
      L9_2 = PEDP
      L8_2(L9_2)
    end
    L4_2 = util
    L4_2 = L4_2.yield
    L5_2 = 1000
    L4_2(L5_2)
    L4_2 = menu
    L4_2 = L4_2.trigger_commands
    L5_2 = "tplsia"
    L4_2(L5_2)
  end
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L20_1 = L20_1.action
L21_1 = _ENV
L22_1 = "sk"
L21_1 = L21_1[L22_1]
L22_1 = "人物伞崩V3"
L23_1 = {}
L24_1 = ""
function L25_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L0_2 = 0
  L1_2 = 5
  L2_2 = 1
  for L3_2 = L0_2, L1_2, L2_2 do
    L4_2 = PLAYER
    L4_2 = L4_2.GET_PLAYER_PED_SCRIPT_INDEX
    L5_2 = PLAYER
    L5_2 = L5_2.PLAYER_ID
    L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L5_2()
    L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    PEDP = L4_2
    object_hash = 192829538
    L4_2 = STREAMING
    L4_2 = L4_2.REQUEST_MODEL
    L5_2 = object_hash
    L4_2(L5_2)
    while true do
      L4_2 = STREAMING
      L4_2 = L4_2.HAS_MODEL_LOADED
      L5_2 = object_hash
      L4_2 = L4_2(L5_2)
      if L4_2 then
        break
      end
      L4_2 = util
      L4_2 = L4_2.yield
      L4_2()
    end
    L4_2 = PLAYER
    L4_2 = L4_2.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE
    L5_2 = PLAYER
    L5_2 = L5_2.PLAYER_ID
    L5_2 = L5_2()
    L6_2 = object_hash
    L4_2(L5_2, L6_2)
    L4_2 = ENTITY
    L4_2 = L4_2.SET_ENTITY_COORDS_NO_OFFSET
    L5_2 = PEDP
    L6_2 = 0
    L7_2 = 0
    L8_2 = 500
    L9_2 = 0
    L10_2 = 0
    L11_2 = 1
    L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    L4_2 = WEAPON
    L4_2 = L4_2.GIVE_DELAYED_WEAPON_TO_PED
    L5_2 = PEDP
    L6_2 = 4222310262
    L7_2 = 1000
    L8_2 = false
    L4_2(L5_2, L6_2, L7_2, L8_2)
    L4_2 = util
    L4_2 = L4_2.yield
    L5_2 = 1000
    L4_2(L5_2)
    L4_2 = 0
    L5_2 = 20
    L6_2 = 1
    for L7_2 = L4_2, L5_2, L6_2 do
      L8_2 = PED
      L8_2 = L8_2.FORCE_PED_TO_OPEN_PARACHUTE
      L9_2 = PEDP
      L8_2(L9_2)
    end
    L4_2 = util
    L4_2 = L4_2.yield
    L5_2 = 1000
    L4_2(L5_2)
    L4_2 = menu
    L4_2 = L4_2.trigger_commands
    L5_2 = "tplsia"
    L4_2(L5_2)
    bush_hash = 192829538
    L4_2 = STREAMING
    L4_2 = L4_2.REQUEST_MODEL
    L5_2 = bush_hash
    L4_2(L5_2)
    while true do
      L4_2 = STREAMING
      L4_2 = L4_2.HAS_MODEL_LOADED
      L5_2 = bush_hash
      L4_2 = L4_2(L5_2)
      if L4_2 then
        break
      end
      L4_2 = util
      L4_2 = L4_2.yield
      L4_2()
    end
    L4_2 = PLAYER
    L4_2 = L4_2.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE
    L5_2 = PLAYER
    L5_2 = L5_2.PLAYER_ID
    L5_2 = L5_2()
    L6_2 = bush_hash
    L4_2(L5_2, L6_2)
    L4_2 = ENTITY
    L4_2 = L4_2.SET_ENTITY_COORDS_NO_OFFSET
    L5_2 = PEDP
    L6_2 = 0
    L7_2 = 0
    L8_2 = 500
    L9_2 = 0
    L10_2 = 0
    L11_2 = 1
    L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    L4_2 = WEAPON
    L4_2 = L4_2.GIVE_DELAYED_WEAPON_TO_PED
    L5_2 = PEDP
    L6_2 = 4222310262
    L7_2 = 1000
    L8_2 = false
    L4_2(L5_2, L6_2, L7_2, L8_2)
    L4_2 = util
    L4_2 = L4_2.yield
    L5_2 = 1000
    L4_2(L5_2)
    L4_2 = 0
    L5_2 = 20
    L6_2 = 1
    for L7_2 = L4_2, L5_2, L6_2 do
      L8_2 = PED
      L8_2 = L8_2.FORCE_PED_TO_OPEN_PARACHUTE
      L9_2 = PEDP
      L8_2(L9_2)
    end
    L4_2 = util
    L4_2 = L4_2.yield
    L5_2 = 1000
    L4_2(L5_2)
    L4_2 = menu
    L4_2 = L4_2.trigger_commands
    L5_2 = "tplsia"
    L4_2(L5_2)
  end
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L20_1 = L20_1.action
L21_1 = _ENV
L22_1 = "sk"
L21_1 = L21_1[L22_1]
L22_1 = "人物伞崩V4"
L23_1 = {}
L24_1 = ""
function L25_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L0_2 = 0
  L1_2 = 5
  L2_2 = 1
  for L3_2 = L0_2, L1_2, L2_2 do
    L4_2 = PLAYER
    L4_2 = L4_2.GET_PLAYER_PED_SCRIPT_INDEX
    L5_2 = PLAYER
    L5_2 = L5_2.PLAYER_ID
    L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L5_2()
    L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    PEDP = L4_2
    object_hash = 1117917059
    L4_2 = STREAMING
    L4_2 = L4_2.REQUEST_MODEL
    L5_2 = object_hash
    L4_2(L5_2)
    while true do
      L4_2 = STREAMING
      L4_2 = L4_2.HAS_MODEL_LOADED
      L5_2 = object_hash
      L4_2 = L4_2(L5_2)
      if L4_2 then
        break
      end
      L4_2 = util
      L4_2 = L4_2.yield
      L4_2()
    end
    L4_2 = PLAYER
    L4_2 = L4_2.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE
    L5_2 = PLAYER
    L5_2 = L5_2.PLAYER_ID
    L5_2 = L5_2()
    L6_2 = object_hash
    L4_2(L5_2, L6_2)
    L4_2 = ENTITY
    L4_2 = L4_2.SET_ENTITY_COORDS_NO_OFFSET
    L5_2 = PEDP
    L6_2 = 0
    L7_2 = 0
    L8_2 = 500
    L9_2 = 0
    L10_2 = 0
    L11_2 = 1
    L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    L4_2 = WEAPON
    L4_2 = L4_2.GIVE_DELAYED_WEAPON_TO_PED
    L5_2 = PEDP
    L6_2 = 4222310262
    L7_2 = 1000
    L8_2 = false
    L4_2(L5_2, L6_2, L7_2, L8_2)
    L4_2 = util
    L4_2 = L4_2.yield
    L5_2 = 1000
    L4_2(L5_2)
    L4_2 = 0
    L5_2 = 20
    L6_2 = 1
    for L7_2 = L4_2, L5_2, L6_2 do
      L8_2 = PED
      L8_2 = L8_2.FORCE_PED_TO_OPEN_PARACHUTE
      L9_2 = PEDP
      L8_2(L9_2)
    end
    L4_2 = util
    L4_2 = L4_2.yield
    L5_2 = 1000
    L4_2(L5_2)
    L4_2 = menu
    L4_2 = L4_2.trigger_commands
    L5_2 = "tplsia"
    L4_2(L5_2)
    bush_hash = 1117917059
    L4_2 = STREAMING
    L4_2 = L4_2.REQUEST_MODEL
    L5_2 = bush_hash
    L4_2(L5_2)
    while true do
      L4_2 = STREAMING
      L4_2 = L4_2.HAS_MODEL_LOADED
      L5_2 = bush_hash
      L4_2 = L4_2(L5_2)
      if L4_2 then
        break
      end
      L4_2 = util
      L4_2 = L4_2.yield
      L4_2()
    end
    L4_2 = PLAYER
    L4_2 = L4_2.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE
    L5_2 = PLAYER
    L5_2 = L5_2.PLAYER_ID
    L5_2 = L5_2()
    L6_2 = bush_hash
    L4_2(L5_2, L6_2)
    L4_2 = ENTITY
    L4_2 = L4_2.SET_ENTITY_COORDS_NO_OFFSET
    L5_2 = PEDP
    L6_2 = 0
    L7_2 = 0
    L8_2 = 500
    L9_2 = 0
    L10_2 = 0
    L11_2 = 1
    L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    L4_2 = WEAPON
    L4_2 = L4_2.GIVE_DELAYED_WEAPON_TO_PED
    L5_2 = PEDP
    L6_2 = 4222310262
    L7_2 = 1000
    L8_2 = false
    L4_2(L5_2, L6_2, L7_2, L8_2)
    L4_2 = util
    L4_2 = L4_2.yield
    L5_2 = 1000
    L4_2(L5_2)
    L4_2 = 0
    L5_2 = 20
    L6_2 = 1
    for L7_2 = L4_2, L5_2, L6_2 do
      L8_2 = PED
      L8_2 = L8_2.FORCE_PED_TO_OPEN_PARACHUTE
      L9_2 = PEDP
      L8_2(L9_2)
    end
    L4_2 = util
    L4_2 = L4_2.yield
    L5_2 = 1000
    L4_2(L5_2)
    L4_2 = menu
    L4_2 = L4_2.trigger_commands
    L5_2 = "tplsia"
    L4_2(L5_2)
  end
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L20_1 = L20_1.action
L21_1 = _ENV
L22_1 = "sk"
L21_1 = L21_1[L22_1]
L22_1 = "CARGO崩溃"
L23_1 = {}
L24_1 = "崩溃所有玩家"
function L25_1()
  local L0_2, L1_2
  L0_2 = CARGO
  L0_2()
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L20_1 = L20_1.action
L21_1 = _ENV
L22_1 = "sk"
L21_1 = L21_1[L22_1]
L22_1 = "大自然全局崩溃"
L23_1 = {}
L24_1 = ""
function L25_1()
  local L0_2, L1_2
  L0_2 = nature
  L0_2()
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L20_1 = L20_1.action
L21_1 = _ENV
L22_1 = "sk"
L21_1 = L21_1[L22_1]
L22_1 = "懂哥崩溃"
L23_1 = {}
L24_1 = ""
function L25_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L0_2 = 0
  L1_2 = 31
  L2_2 = 1
  for L3_2 = L0_2, L1_2, L2_2 do
    L4_2 = PLAYER
    L4_2 = L4_2.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE
    L5_2 = PLAYER
    L5_2 = L5_2.PLAYER_ID
    L5_2 = L5_2()
    L6_2 = 3842125059
    L4_2(L5_2, L6_2)
    L4_2 = TASK
    L4_2 = L4_2.CLEAR_PED_TASKS_IMMEDIATELY
    L5_2 = PLAYER
    L5_2 = L5_2.GET_PLAYER_PED_SCRIPT_INDEX
    L6_2 = PLAYER
    L6_2 = L6_2.PLAYER_ID
    L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L6_2()
    L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
    L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
    L4_2 = util
    L4_2 = L4_2.yield
    L5_2 = 20
    L4_2(L5_2)
    L4_2 = ENTITY
    L4_2 = L4_2.GET_ENTITY_COORDS
    L5_2 = PLAYER
    L5_2 = L5_2.GET_PLAYER_PED_SCRIPT_INDEX
    L6_2 = L3_2
    L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L5_2(L6_2)
    L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
    L5_2 = ENTITY
    L5_2 = L5_2.SET_ENTITY_COORDS_NO_OFFSET
    L6_2 = PLAYER
    L6_2 = L6_2.GET_PLAYER_PED_SCRIPT_INDEX
    L7_2 = PLAYER
    L7_2 = L7_2.PLAYER_ID
    L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L7_2()
    L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
    L7_2 = L4_2.x
    L8_2 = L4_2.y
    L9_2 = L4_2.z
    L10_2 = false
    L11_2 = true
    L12_2 = true
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
    L5_2 = WEAPON
    L5_2 = L5_2.GIVE_DELAYED_WEAPON_TO_PED
    L6_2 = PLAYER
    L6_2 = L6_2.GET_PLAYER_PED_SCRIPT_INDEX
    L7_2 = PLAYER
    L7_2 = L7_2.PLAYER_ID
    L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L7_2()
    L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
    L7_2 = 4222310262
    L8_2 = 1000
    L9_2 = false
    L5_2(L6_2, L7_2, L8_2, L9_2)
    L5_2 = TASK
    L5_2 = L5_2.TASK_PARACHUTE_TO_TARGET
    L6_2 = PLAYER
    L6_2 = L6_2.GET_PLAYER_PED_SCRIPT_INDEX
    L7_2 = PLAYER
    L7_2 = L7_2.PLAYER_ID
    L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L7_2()
    L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
    L7_2 = -1087
    L8_2 = -3012
    L9_2 = 13.94
    L5_2(L6_2, L7_2, L8_2, L9_2)
    L5_2 = util
    L5_2 = L5_2.yield
    L6_2 = 500
    L5_2(L6_2)
    L5_2 = TASK
    L5_2 = L5_2.CLEAR_PED_TASKS_IMMEDIATELY
    L6_2 = PLAYER
    L6_2 = L6_2.GET_PLAYER_PED_SCRIPT_INDEX
    L7_2 = PLAYER
    L7_2 = L7_2.PLAYER_ID
    L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L7_2()
    L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
    L5_2 = util
    L5_2 = L5_2.yield
    L6_2 = 1000
    L5_2(L6_2)
    L5_2 = PLAYER
    L6_2 = "CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE"
    L5_2 = L5_2[L6_2]
    L6_2 = PLAYER
    L6_2 = L6_2.PLAYER_ID
    L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L6_2()
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
    L5_2 = TASK
    L5_2 = L5_2.CLEAR_PED_TASKS_IMMEDIATELY
    L6_2 = PLAYER
    L6_2 = L6_2.GET_PLAYER_PED_SCRIPT_INDEX
    L7_2 = PLAYER
    L7_2 = L7_2.PLAYER_ID
    L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L7_2()
    L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  end
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L20_1 = L20_1.action
L21_1 = _ENV
L22_1 = "sk"
L21_1 = L21_1[L22_1]
L22_1 = "全局顶崩"
L23_1 = {}
L24_1 = ""
function L25_1()
  local L0_2, L1_2
  L0_2 = unknown
  L0_2()
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L20_1 = L20_1.action
L21_1 = _ENV
L22_1 = "sk"
L21_1 = L21_1[L22_1]
L22_1 = "5G崩溃"
L23_1 = {}
L24_1 = ""
function L25_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
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
    L6_2 = L5_2.z
    L6_2 = L6_2 + 10
    L5_2.z = L6_2
    L6_2 = entities
    L6_2 = L6_2.get_all_vehicles_as_handles
    L6_2 = L6_2()
    veh = L6_2
    L6_2 = 1
    L7_2 = veh
    L7_2 = #L7_2
    L8_2 = 1
    for L9_2 = L6_2, L7_2, L8_2 do
      L10_2 = NETWORK
      L10_2 = L10_2.NETWORK_REQUEST_CONTROL_OF_ENTITY
      L11_2 = veh
      L11_2 = L11_2[L9_2]
      L10_2(L11_2)
      L10_2 = ENTITY
      L10_2 = L10_2.SET_ENTITY_COORDS_NO_OFFSET
      L11_2 = veh
      L11_2 = L11_2[L9_2]
      L12_2 = L5_2.x
      L13_2 = L5_2.y
      L14_2 = L5_2.z
      L15_2 = ENTITY
      L15_2 = L15_2.GET_ENTITY_HEADING
      L16_2 = L4_2
      L15_2 = L15_2(L16_2)
      L16_2 = 10
      L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
      L10_2 = TASK
      L10_2 = L10_2.TASK_VEHICLE_TEMP_ACTION
      L11_2 = L4_2
      L12_2 = veh
      L12_2 = L12_2[L9_2]
      L13_2 = 18
      L14_2 = 999
      L10_2(L11_2, L12_2, L13_2, L14_2)
      L10_2 = TASK
      L10_2 = L10_2.TASK_VEHICLE_TEMP_ACTION
      L11_2 = L4_2
      L12_2 = veh
      L12_2 = L12_2[L9_2]
      L13_2 = 16
      L14_2 = 999
      L10_2(L11_2, L12_2, L13_2, L14_2)
    end
  end
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L20_1 = L20_1.action
L21_1 = _ENV
L22_1 = "sk"
L21_1 = L21_1[L22_1]
L22_1 = "冷战崩溃"
L23_1 = {}
L24_1 = "崩崩崩"
function L25_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L0_2 = 0
  L1_2 = 5
  L2_2 = 1
  for L3_2 = L0_2, L1_2, L2_2 do
    L4_2 = PLAYER
    L4_2 = L4_2.GET_PLAYER_PED_SCRIPT_INDEX
    L5_2 = PLAYER
    L5_2 = L5_2.PLAYER_ID
    L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L5_2()
    L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    PEDP = L4_2
    object_hash = 1117917059
    L4_2 = STREAMING
    L4_2 = L4_2.REQUEST_MODEL
    L5_2 = object_hash
    L4_2(L5_2)
    while true do
      L4_2 = STREAMING
      L4_2 = L4_2.HAS_MODEL_LOADED
      L5_2 = object_hash
      L4_2 = L4_2(L5_2)
      if L4_2 then
        break
      end
      L4_2 = util
      L4_2 = L4_2.yield
      L4_2()
    end
    L4_2 = PLAYER
    L4_2 = L4_2.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE
    L5_2 = PLAYER
    L5_2 = L5_2.PLAYER_ID
    L5_2 = L5_2()
    L6_2 = object_hash
    L4_2(L5_2, L6_2)
    L4_2 = ENTITY
    L4_2 = L4_2.SET_ENTITY_COORDS_NO_OFFSET
    L5_2 = PEDP
    L6_2 = 0
    L7_2 = 0
    L8_2 = 500
    L9_2 = 0
    L10_2 = 0
    L11_2 = 1
    L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    L4_2 = WEAPON
    L4_2 = L4_2.GIVE_DELAYED_WEAPON_TO_PED
    L5_2 = PEDP
    L6_2 = 4222310262
    L7_2 = 1000
    L8_2 = false
    L4_2(L5_2, L6_2, L7_2, L8_2)
    L4_2 = util
    L4_2 = L4_2.yield
    L5_2 = 1000
    L4_2(L5_2)
    L4_2 = 0
    L5_2 = 20
    L6_2 = 1
    for L7_2 = L4_2, L5_2, L6_2 do
      L8_2 = PED
      L8_2 = L8_2.FORCE_PED_TO_OPEN_PARACHUTE
      L9_2 = PEDP
      L8_2(L9_2)
    end
    L4_2 = util
    L4_2 = L4_2.yield
    L5_2 = 1000
    L4_2(L5_2)
    L4_2 = menu
    L4_2 = L4_2.trigger_commands
    L5_2 = "tplsia"
    L4_2(L5_2)
    bush_hash = -908104950
    L4_2 = STREAMING
    L4_2 = L4_2.REQUEST_MODEL
    L5_2 = bush_hash
    L4_2(L5_2)
    while true do
      L4_2 = STREAMING
      L4_2 = L4_2.HAS_MODEL_LOADED
      L5_2 = bush_hash
      L4_2 = L4_2(L5_2)
      if L4_2 then
        break
      end
      L4_2 = util
      L4_2 = L4_2.yield
      L4_2()
    end
    L4_2 = PLAYER
    L4_2 = L4_2.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE
    L5_2 = PLAYER
    L5_2 = L5_2.PLAYER_ID
    L5_2 = L5_2()
    L6_2 = bush_hash
    L4_2(L5_2, L6_2)
    L4_2 = ENTITY
    L4_2 = L4_2.SET_ENTITY_COORDS_NO_OFFSET
    L5_2 = PEDP
    L6_2 = 0
    L7_2 = 0
    L8_2 = 500
    L9_2 = 0
    L10_2 = 0
    L11_2 = 1
    L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    L4_2 = WEAPON
    L4_2 = L4_2.GIVE_DELAYED_WEAPON_TO_PED
    L5_2 = PEDP
    L6_2 = 4222310262
    L7_2 = 1000
    L8_2 = false
    L4_2(L5_2, L6_2, L7_2, L8_2)
    L4_2 = util
    L4_2 = L4_2.yield
    L5_2 = 1000
    L4_2(L5_2)
    L4_2 = 0
    L5_2 = 20
    L6_2 = 1
    for L7_2 = L4_2, L5_2, L6_2 do
      L8_2 = PED
      L8_2 = L8_2.FORCE_PED_TO_OPEN_PARACHUTE
      L9_2 = PEDP
      L8_2(L9_2)
    end
    L4_2 = util
    L4_2 = L4_2.yield
    L5_2 = 1000
    L4_2(L5_2)
    L4_2 = menu
    L4_2 = L4_2.trigger_commands
    L5_2 = "tplsia"
    L4_2(L5_2)
  end
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L20_1 = L20_1.action
L21_1 = _ENV
L22_1 = "sk"
L21_1 = L21_1[L22_1]
L22_1 = "声音崩溃战局"
L23_1 = {}
L24_1 = ""
function L25_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2
  L0_2 = 0
  L1_2 = 31
  L2_2 = 1
  for L3_2 = L0_2, L1_2, L2_2 do
    L4_2 = PLAYER
    L4_2 = L4_2.GET_PLAYER_PED_SCRIPT_INDEX
    L5_2 = L3_2
    L4_2 = L4_2(L5_2)
    L5_2 = util
    L5_2 = L5_2.current_time_millis
    L5_2 = L5_2()
    L5_2 = L5_2 + 2000
    while true do
      L6_2 = util
      L6_2 = L6_2.current_time_millis
      L6_2 = L6_2()
      if not (L5_2 > L6_2) then
        break
      end
      L6_2 = ENTITY
      L6_2 = L6_2.GET_ENTITY_COORDS
      L7_2 = L4_2
      L8_2 = true
      L6_2 = L6_2(L7_2, L8_2)
      L7_2 = 1
      L8_2 = 20
      L9_2 = 1
      for L10_2 = L7_2, L8_2, L9_2 do
        L11_2 = AUDIO
        L11_2 = L11_2.PLAY_SOUND_FROM_COORD
        L12_2 = -1
        L13_2 = "Event_Message_Purple"
        L14_2 = L6_2.x
        L15_2 = L6_2.y
        L16_2 = L6_2.z
        L17_2 = "GTAO_FM_Events_Soundset"
        L18_2 = true
        L19_2 = 100000
        L20_2 = false
        L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
      end
      L7_2 = util
      L7_2 = L7_2.yield
      L7_2()
      L7_2 = 1
      L8_2 = 20
      L9_2 = 1
      for L10_2 = L7_2, L8_2, L9_2 do
        L11_2 = AUDIO
        L11_2 = L11_2.PLAY_SOUND_FROM_COORD
        L12_2 = -1
        L13_2 = "5s"
        L14_2 = L6_2.x
        L15_2 = L6_2.y
        L16_2 = L6_2.z
        L17_2 = "GTAO_FM_Events_Soundset"
        L18_2 = true
        L19_2 = 100000
        L20_2 = false
        L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
      end
      L7_2 = util
      L7_2 = L7_2.yield
      L7_2()
    end
  end
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "players"
L20_1 = L20_1[L21_1]
L20_1 = L20_1.on_join
function L21_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L1_2 = menu
  L1_2 = L1_2.divider
  L2_2 = menu
  L2_2 = L2_2.player_root
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = "Sakura"
  L1_2(L2_2, L3_2)
  L1_2 = menu
  L1_2 = L1_2.list
  L2_2 = menu
  L2_2 = L2_2.player_root
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = "daidai脚本"
  L4_2 = {}
  L5_2 = ""
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2)
  L2_2 = menu
  L2_2 = L2_2.toggle
  L3_2 = L1_2
  L4_2 = "观看玩家"
  L5_2 = {}
  L6_2 = ""
  function L7_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3
    L1_3 = menu
    L1_3 = L1_3.trigger_commands
    L2_3 = "spectate"
    L3_3 = players
    L3_3 = L3_3.get_name
    L4_3 = A0_2
    L3_3 = L3_3(L4_3)
    L2_3 = L2_3 .. L3_3
    L3_3 = A0_3
    L1_3(L2_3, L3_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.toggle
  L3_2 = L1_2
  L4_2 = "上帝视角"
  L5_2 = {}
  L6_2 = ""
  function L7_2(A0_3)
    local L1_3, L2_3, L3_3
    L1_3 = god_cam
    L2_3 = A0_3
    L3_3 = A0_2
    L1_3(L2_3, L3_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = L1_2
  L4_2 = "宣布玩家"
  L5_2 = {}
  L6_2 = "公宣布玩家信息"
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3
    L0_3 = chat
    L0_3 = L0_3.send_message
    L1_3 = "玩家"
    L2_3 = PLAYER
    L2_3 = L2_3.GET_PLAYER_NAME
    L3_3 = A0_2
    L2_3 = L2_3(L3_3)
    L3_3 = ": "
    L4_3 = [[

RID: ]]
    L5_3 = players
    L5_3 = L5_3.get_rockstar_id
    L6_3 = A0_2
    L5_3 = L5_3(L6_3)
    L6_3 = [[

PID: ]]
    L7_3 = A0_2
    L8_3 = [[

IP: ]]
    L9_3 = intToIp
    L10_3 = players
    L10_3 = L10_3.get_connect_ip
    L11_3 = A0_2
    L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3 = L10_3(L11_3)
    L9_3 = L9_3(L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3)
    L10_3 = "\n主机令牌: "
    L11_3 = players
    L11_3 = L11_3.get_host_token
    L12_3 = A0_2
    L11_3 = L11_3(L12_3)
    L12_3 = "\n人物模型: "
    L13_3 = int_to_uint
    L14_3 = ENTITY
    L14_3 = L14_3.GET_ENTITY_MODEL
    L15_3 = PLAYER
    L15_3 = L15_3.GET_PLAYER_PED
    L16_3 = A0_2
    L15_3, L16_3, L17_3 = L15_3(L16_3)
    L14_3, L15_3, L16_3, L17_3 = L14_3(L15_3, L16_3, L17_3)
    L13_3 = L13_3(L14_3, L15_3, L16_3, L17_3)
    L14_3 = "\n生命值: "
    L15_3 = ENTITY
    L15_3 = L15_3.GET_ENTITY_HEALTH
    L16_3 = PLAYER
    L16_3 = L16_3.GET_PLAYER_PED
    L17_3 = A0_2
    L16_3, L17_3 = L16_3(L17_3)
    L15_3 = L15_3(L16_3, L17_3)
    L1_3 = L1_3 .. L2_3 .. L3_3 .. L4_3 .. L5_3 .. L6_3 .. L7_3 .. L8_3 .. L9_3 .. L10_3 .. L11_3 .. L12_3 .. L13_3 .. L14_3 .. L15_3
    L2_3 = false
    L3_3 = true
    L4_3 = true
    L0_3(L1_3, L2_3, L3_3, L4_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = L1_2
  L4_2 = "IP查询"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3, L2_3
    L0_3 = intToIp
    L1_3 = players
    L1_3 = L1_3.get_connect_ip
    L2_3 = A0_2
    L1_3, L2_3 = L1_3(L2_3)
    L0_3 = L0_3(L1_3, L2_3)
    L1_3 = QueryIP
    L2_3 = L0_3
    L1_3(L2_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.toggle_loop
  L3_2 = L1_2
  L4_2 = "自动传送到玩家"
  L5_2 = {}
  L6_2 = "当与玩家的距离大于3时自动传送到玩家"
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3
    L0_3 = players
    L0_3 = L0_3.get_position
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = players
    L1_3 = L1_3.get_position
    L2_3 = PLAYER
    L2_3 = L2_3.PLAYER_ID
    L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3 = L2_3()
    L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3)
    L2_3 = math
    L2_3 = L2_3.ceil
    L3_3 = MISC
    L3_3 = L3_3.GET_DISTANCE_BETWEEN_COORDS
    L4_3 = L0_3.x
    L5_3 = L0_3.y
    L6_3 = L0_3.z
    L7_3 = L1_3.x
    L8_3 = L1_3.y
    L9_3 = L1_3.z
    L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3 = L3_3(L4_3, L5_3, L6_3, L7_3, L8_3, L9_3)
    L2_3 = L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3)
    if L2_3 > 3 then
      L3_3 = PLAYER
      L3_3 = L3_3.GET_PLAYER_PED
      L4_3 = A0_2
      L3_3 = L3_3(L4_3)
      if 0 ~= L3_3 then
        L3_3 = teleport
        L4_3 = L0_3.x
        L5_3 = L0_3.y
        L6_3 = L0_3.z
        L3_3(L4_3, L5_3, L6_3)
      end
    end
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.list
  L3_2 = L1_2
  L4_2 = "友好选项"
  L5_2 = {}
  L6_2 = ""
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  friendly = L2_2
  L2_2 = menu
  L2_2 = L2_2.list
  L3_2 = L1_2
  L4_2 = "恶搞选项"
  L5_2 = {}
  L6_2 = ""
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  trolling = L2_2
  L2_2 = menu
  L2_2 = L2_2.list
  L3_2 = L1_2
  L4_2 = "踢出玩家"
  L5_2 = {}
  L6_2 = ""
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  kickplayer = L2_2
  L2_2 = menu
  L2_2 = L2_2.list
  L3_2 = L1_2
  L4_2 = "崩溃玩家"
  L5_2 = {}
  L6_2 = ""
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  crashplayer = L2_2
  L2_2 = menu
  L2_2 = L2_2.list
  L3_2 = L1_2
  L4_2 = "猛怼玩家"
  L5_2 = {}
  L6_2 = "使劲骂他"
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  cussinglayer = L2_2
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = L1_2
  L4_2 = "玩家自检"
  L5_2 = {}
  L6_2 = "检测玩家是否触发作弊者检测"
  function L7_2()
    local L0_3, L1_3
    L0_3 = is_player_modder
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = friendly
  L4_2 = "降落到玩家"
  L5_2 = {}
  L6_2 = "全自动跳伞"
  function L7_2()
    local L0_3, L1_3
    L0_3 = landing_on_player
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.toggle_loop
  L3_2 = friendly
  L4_2 = "导航锁定"
  L5_2 = {}
  L6_2 = "玩家移动时导航条会闪烁"
  function L7_2()
    local L0_3, L1_3
    L0_3 = set_waypoint
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = friendly
  L4_2 = "保存玩家信息"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3
    L0_3 = save_player_info
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = friendly
  L4_2 = "掉落足球"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3, L2_3
    L0_3 = ball_drop
    L1_3 = players
    L1_3 = L1_3.get_position
    L2_3 = A0_2
    L1_3, L2_3 = L1_3(L2_3)
    L0_3(L1_3, L2_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.toggle_loop
  L3_2 = friendly
  L4_2 = "混乱足球"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3, L2_3
    L0_3 = ball_drop
    L1_3 = players
    L1_3 = L1_3.get_position
    L2_3 = A0_2
    L1_3, L2_3 = L1_3(L2_3)
    L0_3(L1_3, L2_3)
    L0_3 = util
    L0_3 = L0_3.yield
    L1_3 = 250
    L0_3(L1_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = friendly
  L4_2 = "传送到他的载具"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3
    L0_3 = tp_p_car
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = friendly
  L4_2 = "给予所有武器"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3
    L0_3 = give_all_weapon
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.toggle
  L3_2 = friendly
  L4_2 = "护送核弹车"
  L5_2 = {}
  L6_2 = "将生成一辆装有核弹的卡车,当卡车爆炸时核弹也会爆炸,这样任何玩家都可以引爆核弹"
  function L7_2(A0_3)
    local L1_3, L2_3, L3_3
    L1_3 = escort_nuke
    L2_3 = A0_3
    L3_3 = A0_2
    L1_3(L2_3, L3_3)
  end
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  safe_nuke = L2_2
  L2_2 = menu
  L2_2 = L2_2.toggle_loop
  L3_2 = friendly
  L4_2 = "自动充能"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED_SCRIPT_INDEX
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = PED
    L1_3 = L1_3.GET_VEHICLE_PED_IS_USING
    L2_3 = L0_3
    L1_3 = L1_3(L2_3)
    L2_3 = VEHICLE
    L2_3 = L2_3.IS_ROCKET_BOOST_ACTIVE
    L3_3 = L1_3
    L2_3 = L2_3(L3_3)
    if L2_3 then
      repeat
        L2_3 = util
        L2_3 = L2_3.yield
        L2_3()
        L2_3 = VEHICLE
        L2_3 = L2_3.IS_ROCKET_BOOST_ACTIVE
        L3_3 = L1_3
        L2_3 = L2_3(L3_3)
      until not L2_3
      L2_3 = NETWORK
      L2_3 = L2_3.NETWORK_REQUEST_CONTROL_OF_ENTITY
      L3_3 = L1_3
      L2_3(L3_3)
      L2_3 = VEHICLE
      L2_3 = L2_3.SET_ROCKET_BOOST_FILL
      L3_3 = L1_3
      L4_3 = 100.0
      L2_3(L3_3, L4_3)
    end
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = friendly
  L4_2 = "送只猫"
  L5_2 = {}
  L6_2 = "送一只猫一直跟着他"
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = util
    L1_3 = L1_3.joaat
    L2_3 = "a_c_cat_01"
    L1_3 = L1_3(L2_3)
    L2_3 = ENTITY
    L2_3 = L2_3.GET_ENTITY_COORDS
    L3_3 = L0_3
    L2_3 = L2_3(L3_3)
    L3_3 = create_ped
    L4_3 = 28
    L5_3 = L1_3
    L6_3 = L2_3.x
    L7_3 = L2_3.y
    L8_3 = L2_3.z
    L9_3 = 1
    L3_3 = L3_3(L4_3, L5_3, L6_3, L7_3, L8_3, L9_3)
    L4_3 = ENTITY
    L4_3 = L4_3.SET_ENTITY_INVINCIBLE
    L5_3 = L3_3
    L6_3 = true
    L4_3(L5_3, L6_3)
    L4_3 = TASK
    L4_3 = L4_3.TASK_FOLLOW_TO_OFFSET_OF_ENTITY
    L5_3 = L3_3
    L6_3 = L0_3
    L7_3 = 0
    L8_3 = -0.3
    L9_3 = 0
    L10_3 = 7.0
    L11_3 = -1
    L12_3 = 1.5
    L13_3 = true
    L4_3(L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = friendly
  L4_2 = "复制服饰"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3
    L0_3 = copy_outfit
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = friendly
  L4_2 = "复制载具"
  L5_2 = {}
  L6_2 = "复制玩家载具并驾驶"
  function L7_2()
    local L0_3, L1_3
    L0_3 = copy_vehicle
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.toggle_loop
  L3_2 = friendly
  L4_2 = "自动给予脚本主机"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3
    while true do
      L0_3 = players
      L0_3 = L0_3.get_script_host
      L0_3 = L0_3()
      L1_3 = A0_2
      if L0_3 == L1_3 then
        break
      end
      L0_3 = menu
      L0_3 = L0_3.trigger_commands
      L1_3 = "givesh"
      L2_3 = players
      L2_3 = L2_3.get_name
      L3_3 = A0_2
      L2_3 = L2_3(L3_3)
      L1_3 = L1_3 .. L2_3
      L0_3(L1_3)
      L0_3 = util
      L0_3 = L0_3.yield
      L1_3 = 10
      L0_3(L1_3)
    end
    L0_3 = util
    L0_3 = L0_3.yield
    L1_3 = 500
    L0_3(L1_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = friendly
  L4_2 = "升级车辆"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED_SCRIPT_INDEX
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = PED
    L1_3 = L1_3.GET_VEHICLE_PED_IS_USING
    L2_3 = L0_3
    L1_3 = L1_3(L2_3)
    L2_3 = request_control
    L3_3 = L1_3
    L2_3(L3_3)
    L2_3 = upgrade_vehicle
    L3_3 = L1_3
    L2_3(L3_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.list
  L3_2 = friendly
  L4_2 = "绿汽水"
  L5_2 = {}
  L6_2 = ""
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  green_soda_player = L2_2
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = green_soda_player
  L4_2 = "绿~汽水！"
  L5_2 = {}
  L6_2 = "生成随机一辆绿载具和少数的汽水罐"
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
    L0_3 = random_spawn_vehicles
    L1_3 = math
    L1_3 = L1_3.random
    L2_3 = 1
    L3_3 = random_spawn_vehicles
    L3_3 = #L3_3
    L1_3 = L1_3(L2_3, L3_3)
    L0_3 = L0_3[L1_3]
    L1_3 = spawn_vehicle_for_player
    L2_3 = A0_2
    L3_3 = L0_3.model
    L1_3 = L1_3(L2_3, L3_3)
    if L1_3 then
      L2_3 = sprunkify_vehicle
      L3_3 = L1_3
      L2_3(L3_3)
      L2_3 = 1
      L3_3 = 10
      L4_3 = 1
      for L5_3 = L2_3, L3_3, L4_3 do
        L6_3 = sprunk_raindrop_vehicle
        L7_3 = L1_3
        L6_3(L7_3)
      end
    end
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = green_soda_player
  L4_2 = "喷上绿漆"
  L5_2 = {}
  L6_2 = "把他的载具染成绿色!"
  function L7_2()
    local L0_3, L1_3, L2_3
    L0_3 = get_player_vehicle_in_control
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    if L0_3 then
      L1_3 = sprunkify_vehicle
      L2_3 = L0_3
      L1_3(L2_3)
    end
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = green_soda_player
  L4_2 = "汽水罐"
  L5_2 = {}
  L6_2 = "在玩家附近掉落一罐汽水"
  function L7_2()
    local L0_3, L1_3
    L0_3 = sprunk_raindrop_player
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.toggle_loop
  L3_2 = green_soda_player
  L4_2 = "汽水暴雨"
  L5_2 = {}
  L6_2 = "在玩家附近下起汽水暴雨"
  function L7_2()
    local L0_3, L1_3
    L0_3 = sprunk_raindrop_player
    L1_3 = A0_2
    L0_3(L1_3)
    L0_3 = util
    L0_3 = L0_3.yield
    L1_3 = sodaconfig
    L1_3 = L1_3.can_rain_delay
    L0_3(L1_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = green_soda_player
  L4_2 = "倾倒垃圾罐"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3
    L0_3 = trash_dump_player
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.list_action
  L3_2 = friendly
  L4_2 = "更改弹药效果"
  L5_2 = {}
  L6_2 = ""
  L7_2 = explosion_names
  function L8_2(A0_3)
    local L1_3, L2_3, L3_3
    L1_3 = change_ammo_effect
    L2_3 = A0_3
    L3_3 = A0_2
    L1_3(L2_3, L3_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  L2_2 = menu
  L2_2 = L2_2.list
  L3_2 = friendly
  L4_2 = "天降RP值"
  L5_2 = {}
  L6_2 = ""
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  dropRP = L2_2
  rpdropDelay = 1500
  L2_2 = menu
  L2_2 = L2_2.slider
  L3_2 = dropRP
  L4_2 = "RP天降延迟"
  L5_2 = {}
  L6_2 = "RP天降延迟"
  L7_2 = 100
  L8_2 = 10000
  L9_2 = 1500
  L10_2 = 100
  function L11_2(A0_3)
    local L1_3
    rpDropDelay = A0_3
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L2_2 = menu
  L2_2 = L2_2.toggle_loop
  L3_2 = dropRP
  L4_2 = "天降RP"
  L5_2 = {}
  L6_2 = "RP天降,但延迟可调"
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3
    L0_3 = players
    L0_3 = L0_3.get_position
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = L0_3.z
    L1_3 = L1_3 + 1.5
    L0_3.z = L1_3
    L1_3 = MISC
    L1_3 = L1_3.GET_HASH_KEY
    L2_3 = "vw_prop_vw_colle_prbubble"
    L1_3 = L1_3(L2_3)
    L2_3 = STREAMING
    L2_3 = L2_3.REQUEST_MODEL
    L3_3 = L1_3
    L2_3(L3_3)
    L2_3 = STREAMING
    L2_3 = L2_3.HAS_MODEL_LOADED
    L3_3 = L1_3
    L2_3 = L2_3(L3_3)
    if false == L2_3 then
      L2_3 = STREAMING
      L2_3 = L2_3.REQUEST_MODEL
      L3_3 = L1_3
      L2_3(L3_3)
    end
    L2_3 = OBJECT
    L2_3 = L2_3.CREATE_AMBIENT_PICKUP
    L3_3 = -1009939663
    L4_3 = L0_3.x
    L5_3 = L0_3.y
    L6_3 = L0_3.z
    L7_3 = 0
    L8_3 = 1
    L9_3 = L1_3
    L10_3 = false
    L11_3 = true
    L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3)
    L2_3 = util
    L2_3 = L2_3.yield
    L3_3 = rpDropDelay
    L2_3(L3_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.list
  L3_2 = friendly
  L4_2 = "天降收集牌"
  L5_2 = {}
  L6_2 = ""
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  dropCard = L2_2
  cardDropDelay = 1500
  L2_2 = menu
  L2_2 = L2_2.slider
  L3_2 = dropCard
  L4_2 = "收集牌延迟"
  L5_2 = {}
  L6_2 = "延迟收集牌"
  L7_2 = 100
  L8_2 = 10000
  L9_2 = 1500
  L10_2 = 100
  function L11_2(A0_3)
    local L1_3
    cardDropDelay = A0_3
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L2_2 = menu
  L2_2 = L2_2.toggle_loop
  L3_2 = dropCard
  L4_2 = "天降收集牌"
  L5_2 = {}
  L6_2 = "玩家每次只能拾取54张牌,请注意,这还没有测试过禁令,但应该是安全的"
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3
    L0_3 = players
    L0_3 = L0_3.get_position
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = L0_3.z
    L1_3 = L1_3 + 1.5
    L0_3.z = L1_3
    L1_3 = MISC
    L1_3 = L1_3.GET_HASH_KEY
    L2_3 = "vw_prop_vw_lux_card_01a"
    L1_3 = L1_3(L2_3)
    L2_3 = STREAMING
    L2_3 = L2_3.REQUEST_MODEL
    L3_3 = L1_3
    L2_3(L3_3)
    L2_3 = STREAMING
    L2_3 = L2_3.HAS_MODEL_LOADED
    L3_3 = L1_3
    L2_3 = L2_3(L3_3)
    if false == L2_3 then
      L2_3 = STREAMING
      L2_3 = L2_3.REQUEST_MODEL
      L3_3 = L1_3
      L2_3(L3_3)
    end
    L2_3 = OBJECT
    L2_3 = L2_3.CREATE_AMBIENT_PICKUP
    L3_3 = -1009939663
    L4_3 = L0_3.x
    L5_3 = L0_3.y
    L6_3 = L0_3.z
    L7_3 = 0
    L8_3 = 1
    L9_3 = L1_3
    L10_3 = false
    L11_3 = true
    L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3)
    L2_3 = util
    L2_3 = L2_3.yield
    L3_3 = cardDropDelay
    L2_3(L3_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.list
  L3_2 = trolling
  L4_2 = "击杀玩家"
  L5_2 = {}
  L6_2 = ""
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  kill_godmode = L2_2
  L2_2 = menu
  L2_2 = L2_2.list
  L3_2 = trolling
  L4_2 = "经典恶搞"
  L5_2 = {}
  L6_2 = ""
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  classic_trolling = L2_2
  L2_2 = menu
  L2_2 = L2_2.list
  L3_2 = trolling
  L4_2 = "套笼子"
  L5_2 = {}
  L6_2 = ""
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  lz = L2_2
  L2_2 = menu
  L2_2 = L2_2.list
  L3_2 = trolling
  L4_2 = "NPC恶搞"
  L5_2 = {}
  L6_2 = ""
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  npc_trolling = L2_2
  L2_2 = menu
  L2_2 = L2_2.list
  L3_2 = trolling
  L4_2 = "武器恶搞"
  L5_2 = {}
  L6_2 = ""
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  weapon_trolling = L2_2
  L2_2 = menu
  L2_2 = L2_2.list
  L3_2 = trolling
  L4_2 = "载具恶搞"
  L5_2 = {}
  L6_2 = ""
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  vehicle_car = L2_2
  L2_2 = menu
  L2_2 = L2_2.list
  L3_2 = trolling
  L4_2 = "发送玩家"
  L5_2 = {}
  L6_2 = ""
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  tp_player_trolling = L2_2
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = kill_godmode
  L4_2 = "用天基炮杀死玩家"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3
    L0_3 = L3_1.exists
    L0_3 = L0_3()
    if not L0_3 then
      L0_3 = PLAYER
      L0_3 = L0_3.IS_PLAYER_PLAYING
      L1_3 = A0_2
      L0_3 = L0_3(L1_3)
      if L0_3 then
        L0_3 = L3_1.create
        L1_3 = A0_2
        L0_3(L1_3)
      end
    end
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = kill_godmode
  L4_2 = "nigger爆炸"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3
    L0_3 = niggers_bomb
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = kill_godmode
  L4_2 = "鲨鱼吃掉玩家"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3
    L0_3 = Shark_eating
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = kill_godmode
  L4_2 = "集束炸弹"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3
    L0_3 = cluster_bomb
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = kill_godmode
  L4_2 = "杀死被动"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3
    L0_3 = players
    L0_3 = L0_3.get_position
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = PLAYER
    L1_3 = L1_3.GET_PLAYER_PED_SCRIPT_INDEX
    L2_3 = A0_2
    L1_3 = L1_3(L2_3)
    L2_3 = L0_3.z
    L2_3 = L2_3 + 5
    L0_3.z = L2_3
    L2_3 = PED
    L2_3 = L2_3.GET_VEHICLE_PED_IS_IN
    L3_3 = L1_3
    L4_3 = false
    L2_3 = L2_3(L3_3, L4_3)
    if L2_3 > 0 then
      L3_3 = delete_entity
      L4_3 = L2_3
      L3_3(L4_3)
    end
    L3_3 = util
    L3_3 = L3_3.joaat
    L4_3 = "dukes2"
    L3_3 = L3_3(L4_3)
    L4_3 = request_model
    L5_3 = L3_3
    L4_3(L5_3)
    L4_3 = entities
    L4_3 = L4_3.create_vehicle
    L5_3 = L3_3
    L6_3 = L0_3
    L7_3 = 0
    L4_3 = L4_3(L5_3, L6_3, L7_3)
    L5_3 = ENTITY
    L5_3 = L5_3.SET_ENTITY_VISIBLE
    L6_3 = L4_3
    L7_3 = false
    L8_3 = 0
    L5_3(L6_3, L7_3, L8_3)
    L5_3 = ENTITY
    L5_3 = L5_3.APPLY_FORCE_TO_ENTITY
    L6_3 = L4_3
    L7_3 = 1
    L8_3 = 0.0
    L9_3 = 0.0
    L10_3 = -65
    L11_3 = 0.0
    L12_3 = 0.0
    L13_3 = 0.0
    L14_3 = 1
    L15_3 = false
    L16_3 = true
    L17_3 = true
    L18_3 = true
    L19_3 = true
    L5_3(L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = kill_godmode
  L4_2 = "死亡屏障击杀"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3
    L0_3 = Death_barrier
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.toggle_loop
  L3_2 = kill_godmode
  L4_2 = "移除玩家无敌"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3
    L0_3 = util
    L0_3 = L0_3.trigger_script_event
    L1_3 = SYSTEM
    L1_3 = L1_3.SHIFT_LEFT
    L2_3 = A0_2
    L3_3 = 1
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = {}
    L3_3 = 2906040919
    L4_3 = A0_2
    L5_3 = 2532159791
    L6_3 = math
    L6_3 = L6_3.random
    L7_3 = 0
    L8_3 = 9999
    L6_3, L7_3, L8_3 = L6_3(L7_3, L8_3)
    L2_3[1] = L3_3
    L2_3[2] = L4_3
    L2_3[3] = L5_3
    L2_3[4] = L6_3
    L2_3[5] = L7_3
    L2_3[6] = L8_3
    L0_3(L1_3, L2_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = kill_godmode
  L4_2 = "杀死无敌玩家v1"
  L5_2 = {}
  L6_2 = "普通击杀"
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED_SCRIPT_INDEX
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = ENTITY
    L1_3 = L1_3.GET_ENTITY_COORDS
    L2_3 = L0_3
    L1_3 = L1_3(L2_3)
    L2_3 = MISC
    L2_3 = L2_3.SHOOT_SINGLE_BULLET_BETWEEN_COORDS
    L3_3 = L1_3.x
    L4_3 = L1_3.y
    L5_3 = L1_3.z
    L5_3 = L5_3 + 1
    L6_3 = L1_3.x
    L7_3 = L1_3.y
    L8_3 = L1_3.z
    L9_3 = 99999
    L10_3 = true
    L11_3 = util
    L11_3 = L11_3.joaat
    L12_3 = "weapon_stungun"
    L11_3 = L11_3(L12_3)
    L12_3 = PLAYER
    L12_3 = L12_3.PLAYER_PED_ID
    L12_3 = L12_3()
    L13_3 = false
    L14_3 = true
    L15_3 = 1.0
    L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.textslider
  L3_2 = kill_godmode
  L4_2 = "杀死无敌玩家v2"
  L5_2 = {}
  L6_2 = "强制击杀"
  L7_2 = {}
  L8_2 = "Khanjali"
  L9_2 = "APC"
  L7_2[1] = L8_2
  L7_2[2] = L9_2
  function L8_2(A0_3, A1_3)
    local L2_3, L3_3, L4_3, L5_3
    L2_3 = Force_kill
    L3_3 = A0_3
    L4_3 = A1_3
    L5_3 = A0_2
    L2_3(L3_3, L4_3, L5_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  L2_2 = menu
  L2_2 = L2_2.toggle_loop
  L3_2 = kill_godmode
  L4_2 = "炸死无敌玩家"
  L5_2 = {}
  L6_2 = "被大多数菜单拦截"
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED_SCRIPT_INDEX
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = ENTITY
    L1_3 = L1_3.GET_ENTITY_COORDS
    L2_3 = L0_3
    L1_3 = L1_3(L2_3)
    L2_3 = PED
    L2_3 = L2_3.IS_PED_DEAD_OR_DYING
    L3_3 = L0_3
    L2_3 = L2_3(L3_3)
    if not L2_3 then
      L2_3 = NETWORK
      L2_3 = L2_3.NETWORK_IS_PLAYER_FADING
      L3_3 = A0_2
      L2_3 = L2_3(L3_3)
      if not L2_3 then
        L2_3 = util
        L2_3 = L2_3.trigger_script_event
        L3_3 = SYSTEM
        L3_3 = L3_3.SHIFT_LEFT
        L4_3 = A0_2
        L5_3 = 1
        L3_3 = L3_3(L4_3, L5_3)
        L4_3 = {}
        L5_3 = 2906040919
        L6_3 = A0_2
        L7_3 = 2532159791
        L8_3 = math
        L8_3 = L8_3.random
        L9_3 = 0
        L10_3 = 9999
        L8_3, L9_3, L10_3, L11_3 = L8_3(L9_3, L10_3)
        L4_3[1] = L5_3
        L4_3[2] = L6_3
        L4_3[3] = L7_3
        L4_3[4] = L8_3
        L4_3[5] = L9_3
        L4_3[6] = L10_3
        L4_3[7] = L11_3
        L2_3(L3_3, L4_3)
        L2_3 = FIRE
        L2_3 = L2_3.ADD_OWNED_EXPLOSION
        L3_3 = PLAYER
        L3_3 = L3_3.PLAYER_PED_ID
        L3_3 = L3_3()
        L4_3 = L1_3.x
        L5_3 = L1_3.y
        L6_3 = L1_3.z
        L7_3 = 2
        L8_3 = 50
        L9_3 = true
        L10_3 = false
        L11_3 = 0.0
        L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3)
      end
    end
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.list
  L3_2 = classic_trolling
  L4_2 = "虚假通知"
  L5_2 = {}
  L6_2 = ""
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  False_notification = L2_2
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = False_notification
  L4_2 = "注册CEO"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3
    L0_3 = util
    L0_3 = L0_3.trigger_script_event
    L1_3 = SYSTEM
    L1_3 = L1_3.SHIFT_LEFT
    L2_3 = A0_2
    L3_3 = 1
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = {}
    L3_3 = -642704387
    L4_3 = 0
    L5_3 = 514341487
    L6_3 = 100
    L7_3 = 0
    L8_3 = 0
    L9_3 = 0
    L10_3 = 0
    L11_3 = 0
    L12_3 = 0
    L13_3 = 0
    L14_3 = 0
    L15_3 = 0
    L16_3 = 0
    L2_3[1] = L3_3
    L2_3[2] = L4_3
    L2_3[3] = L5_3
    L2_3[4] = L6_3
    L2_3[5] = L7_3
    L2_3[6] = L8_3
    L2_3[7] = L9_3
    L2_3[8] = L10_3
    L2_3[9] = L11_3
    L2_3[10] = L12_3
    L2_3[11] = L13_3
    L2_3[12] = L14_3
    L2_3[13] = L15_3
    L2_3[14] = L16_3
    L0_3(L1_3, L2_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = False_notification
  L4_2 = "注册VIP"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3
    L0_3 = util
    L0_3 = L0_3.trigger_script_event
    L1_3 = SYSTEM
    L1_3 = L1_3.SHIFT_LEFT
    L2_3 = A0_2
    L3_3 = 1
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = {}
    L3_3 = -642704387
    L4_3 = 0
    L5_3 = 514341487
    L6_3 = 0
    L7_3 = 0
    L8_3 = 0
    L9_3 = 0
    L10_3 = 0
    L11_3 = 0
    L12_3 = 0
    L13_3 = 0
    L14_3 = 0
    L15_3 = 0
    L16_3 = 0
    L2_3[1] = L3_3
    L2_3[2] = L4_3
    L2_3[3] = L5_3
    L2_3[4] = L6_3
    L2_3[5] = L7_3
    L2_3[6] = L8_3
    L2_3[7] = L9_3
    L2_3[8] = L10_3
    L2_3[9] = L11_3
    L2_3[10] = L12_3
    L2_3[11] = L13_3
    L2_3[12] = L14_3
    L2_3[13] = L15_3
    L2_3[14] = L16_3
    L0_3(L1_3, L2_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = False_notification
  L4_2 = "注册摩托帮"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3
    L0_3 = util
    L0_3 = L0_3.trigger_script_event
    L1_3 = SYSTEM
    L1_3 = L1_3.SHIFT_LEFT
    L2_3 = A0_2
    L3_3 = 1
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = {}
    L3_3 = -642704387
    L4_3 = 0
    L5_3 = 514341487
    L6_3 = 1
    L7_3 = 0
    L8_3 = 0
    L9_3 = 0
    L10_3 = 0
    L11_3 = 0
    L12_3 = 0
    L13_3 = 0
    L14_3 = 0
    L15_3 = 0
    L16_3 = 0
    L2_3[1] = L3_3
    L2_3[2] = L4_3
    L2_3[3] = L5_3
    L2_3[4] = L6_3
    L2_3[5] = L7_3
    L2_3[6] = L8_3
    L2_3[7] = L9_3
    L2_3[8] = L10_3
    L2_3[9] = L11_3
    L2_3[10] = L12_3
    L2_3[11] = L13_3
    L2_3[12] = L14_3
    L2_3[13] = L15_3
    L2_3[14] = L16_3
    L0_3(L1_3, L2_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = False_notification
  L4_2 = "隐藏标记点"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3
    L0_3 = util
    L0_3 = L0_3.trigger_script_event
    L1_3 = SYSTEM
    L1_3 = L1_3.SHIFT_LEFT
    L2_3 = A0_2
    L3_3 = 1
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = {}
    L3_3 = -642704387
    L4_3 = 1
    L5_3 = -1496350145
    L6_3 = amount
    if not L6_3 then
      L6_3 = 500
    end
    L7_3 = 0
    L8_3 = 0
    L9_3 = 0
    L10_3 = 0
    L11_3 = 0
    L12_3 = 0
    L13_3 = 0
    L14_3 = 0
    L15_3 = 0
    L16_3 = 0
    L2_3[1] = L3_3
    L2_3[2] = L4_3
    L2_3[3] = L5_3
    L2_3[4] = L6_3
    L2_3[5] = L7_3
    L2_3[6] = L8_3
    L2_3[7] = L9_3
    L2_3[8] = L10_3
    L2_3[9] = L11_3
    L2_3[10] = L12_3
    L2_3[11] = L13_3
    L2_3[12] = L14_3
    L2_3[13] = L15_3
    L2_3[14] = L16_3
    L0_3(L1_3, L2_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = False_notification
  L4_2 = "激活幽灵组织"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3
    L0_3 = util
    L0_3 = L0_3.trigger_script_event
    L1_3 = SYSTEM
    L1_3 = L1_3.SHIFT_LEFT
    L2_3 = A0_2
    L3_3 = 1
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = {}
    L3_3 = -642704387
    L4_3 = 1
    L5_3 = 688031806
    L6_3 = 0
    L7_3 = 0
    L8_3 = 0
    L9_3 = 7953752157564464705
    L10_3 = 31084746152966761
    L11_3 = 0
    L12_3 = 0
    L13_3 = 0
    L14_3 = 0
    L15_3 = 0
    L16_3 = 0
    L2_3[1] = L3_3
    L2_3[2] = L4_3
    L2_3[3] = L5_3
    L2_3[4] = L6_3
    L2_3[5] = L7_3
    L2_3[6] = L8_3
    L2_3[7] = L9_3
    L2_3[8] = L10_3
    L2_3[9] = L11_3
    L2_3[10] = L12_3
    L2_3[11] = L13_3
    L2_3[12] = L14_3
    L2_3[13] = L15_3
    L2_3[14] = L16_3
    L0_3(L1_3, L2_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = False_notification
  L4_2 = "被劫匪打劫"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3
    L0_3 = util
    L0_3 = L0_3.trigger_script_event
    L1_3 = SYSTEM
    L1_3 = L1_3.SHIFT_LEFT
    L2_3 = A0_2
    L3_3 = 1
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = {}
    L3_3 = -642704387
    L4_3 = 0
    L5_3 = -1079941038
    L6_3 = amount
    if not L6_3 then
      L6_3 = 10000
    end
    L7_3 = 0
    L8_3 = 0
    L9_3 = 0
    L10_3 = 0
    L11_3 = 0
    L12_3 = 0
    L13_3 = 2954937499648
    L14_3 = 0
    L15_3 = 0
    L16_3 = 0
    L2_3[1] = L3_3
    L2_3[2] = L4_3
    L2_3[3] = L5_3
    L2_3[4] = L6_3
    L2_3[5] = L7_3
    L2_3[6] = L8_3
    L2_3[7] = L9_3
    L2_3[8] = L10_3
    L2_3[9] = L11_3
    L2_3[10] = L12_3
    L2_3[11] = L13_3
    L2_3[12] = L14_3
    L2_3[13] = L15_3
    L2_3[14] = L16_3
    L0_3(L1_3, L2_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = False_notification
  L4_2 = "劫匪被杀死"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3
    L0_3 = util
    L0_3 = L0_3.trigger_script_event
    L1_3 = SYSTEM
    L1_3 = L1_3.SHIFT_LEFT
    L2_3 = A0_2
    L3_3 = 1
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = {}
    L3_3 = -642704387
    L4_3 = 0
    L5_3 = -578453253
    L6_3 = 0
    L7_3 = 0
    L8_3 = 0
    L9_3 = 0
    L10_3 = 0
    L11_3 = 0
    L12_3 = 0
    L13_3 = 2954937499648
    L14_3 = 0
    L15_3 = 0
    L16_3 = 0
    L2_3[1] = L3_3
    L2_3[2] = L4_3
    L2_3[3] = L5_3
    L2_3[4] = L6_3
    L2_3[5] = L7_3
    L2_3[6] = L8_3
    L2_3[7] = L9_3
    L2_3[8] = L10_3
    L2_3[9] = L11_3
    L2_3[10] = L12_3
    L2_3[11] = L13_3
    L2_3[12] = L14_3
    L2_3[13] = L15_3
    L2_3[14] = L16_3
    L0_3(L1_3, L2_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = False_notification
  L4_2 = "袭击装甲运钞车"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3
    L0_3 = util
    L0_3 = L0_3.trigger_script_event
    L1_3 = SYSTEM
    L1_3 = L1_3.SHIFT_LEFT
    L2_3 = A0_2
    L3_3 = 1
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = {}
    L3_3 = -642704387
    L4_3 = 0
    L5_3 = 1964206081
    L6_3 = 0
    L7_3 = 0
    L8_3 = 0
    L9_3 = 0
    L10_3 = 0
    L11_3 = 0
    L12_3 = 0
    L13_3 = 0
    L14_3 = 0
    L15_3 = 0
    L16_3 = 0
    L2_3[1] = L3_3
    L2_3[2] = L4_3
    L2_3[3] = L5_3
    L2_3[4] = L6_3
    L2_3[5] = L7_3
    L2_3[6] = L8_3
    L2_3[7] = L9_3
    L2_3[8] = L10_3
    L2_3[9] = L11_3
    L2_3[10] = L12_3
    L2_3[11] = L13_3
    L2_3[12] = L14_3
    L2_3[13] = L15_3
    L2_3[14] = L16_3
    L0_3(L1_3, L2_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = False_notification
  L4_2 = "存入现金"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3
    L0_3 = util
    L0_3 = L0_3.trigger_script_event
    L1_3 = SYSTEM
    L1_3 = L1_3.SHIFT_LEFT
    L2_3 = A0_2
    L3_3 = 1
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = {}
    L3_3 = -642704387
    L4_3 = 0
    L5_3 = 94410750
    L6_3 = 10000000
    L7_3 = 0
    L8_3 = 0
    L9_3 = 0
    L10_3 = 0
    L11_3 = 0
    L12_3 = 0
    L13_3 = 0
    L14_3 = 0
    L15_3 = 0
    L16_3 = 0
    L2_3[1] = L3_3
    L2_3[2] = L4_3
    L2_3[3] = L5_3
    L2_3[4] = L6_3
    L2_3[5] = L7_3
    L2_3[6] = L8_3
    L2_3[7] = L9_3
    L2_3[8] = L10_3
    L2_3[9] = L11_3
    L2_3[10] = L12_3
    L2_3[11] = L13_3
    L2_3[12] = L14_3
    L2_3[13] = L15_3
    L2_3[14] = L16_3
    L0_3(L1_3, L2_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = False_notification
  L4_2 = "窃取现金"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3
    L0_3 = util
    L0_3 = L0_3.trigger_script_event
    L1_3 = SYSTEM
    L1_3 = L1_3.SHIFT_LEFT
    L2_3 = A0_2
    L3_3 = 1
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = {}
    L3_3 = -642704387
    L4_3 = 0
    L5_3 = -295926414
    L6_3 = 10000000
    L7_3 = 0
    L8_3 = 0
    L9_3 = 0
    L10_3 = 0
    L11_3 = 0
    L12_3 = 0
    L13_3 = 0
    L14_3 = 0
    L15_3 = 0
    L16_3 = 0
    L2_3[1] = L3_3
    L2_3[2] = L4_3
    L2_3[3] = L5_3
    L2_3[4] = L6_3
    L2_3[5] = L7_3
    L2_3[6] = L8_3
    L2_3[7] = L9_3
    L2_3[8] = L10_3
    L2_3[9] = L11_3
    L2_3[10] = L12_3
    L2_3[11] = L13_3
    L2_3[12] = L14_3
    L2_3[13] = L15_3
    L2_3[14] = L16_3
    L0_3(L1_3, L2_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = False_notification
  L4_2 = "移除现金"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3
    L0_3 = util
    L0_3 = L0_3.trigger_script_event
    L1_3 = SYSTEM
    L1_3 = L1_3.SHIFT_LEFT
    L2_3 = A0_2
    L3_3 = 1
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = {}
    L3_3 = -642704387
    L4_3 = 0
    L5_3 = -242911964
    L6_3 = 10000000
    L7_3 = 0
    L8_3 = 0
    L9_3 = 0
    L10_3 = 0
    L11_3 = 0
    L12_3 = 0
    L13_3 = 0
    L14_3 = 0
    L15_3 = 0
    L16_3 = 0
    L2_3[1] = L3_3
    L2_3[2] = L4_3
    L2_3[3] = L5_3
    L2_3[4] = L6_3
    L2_3[5] = L7_3
    L2_3[6] = L8_3
    L2_3[7] = L9_3
    L2_3[8] = L10_3
    L2_3[9] = L11_3
    L2_3[10] = L12_3
    L2_3[11] = L13_3
    L2_3[12] = L14_3
    L2_3[13] = L15_3
    L2_3[14] = L16_3
    L0_3(L1_3, L2_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = False_notification
  L4_2 = "激活导弹锁定干扰器"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3
    L0_3 = util
    L0_3 = L0_3.trigger_script_event
    L1_3 = SYSTEM
    L1_3 = L1_3.SHIFT_LEFT
    L2_3 = A0_2
    L3_3 = 1
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = {}
    L3_3 = -642704387
    L4_3 = 0
    L5_3 = -1957780196
    L6_3 = 0
    L7_3 = 0
    L8_3 = 0
    L9_3 = 0
    L10_3 = 0
    L11_3 = 0
    L12_3 = 0
    L13_3 = 0
    L14_3 = 0
    L15_3 = 0
    L16_3 = 0
    L2_3[1] = L3_3
    L2_3[2] = L4_3
    L2_3[3] = L5_3
    L2_3[4] = L6_3
    L2_3[5] = L7_3
    L2_3[6] = L8_3
    L2_3[7] = L9_3
    L2_3[8] = L10_3
    L2_3[9] = L11_3
    L2_3[10] = L12_3
    L2_3[11] = L13_3
    L2_3[12] = L14_3
    L2_3[13] = L15_3
    L2_3[14] = L16_3
    L0_3(L1_3, L2_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = False_notification
  L4_2 = "取得车主证明文件"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3
    L0_3 = util
    L0_3 = L0_3.trigger_script_event
    L1_3 = SYSTEM
    L1_3 = L1_3.SHIFT_LEFT
    L2_3 = A0_2
    L3_3 = 1
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = {}
    L3_3 = -642704387
    L4_3 = 0
    L5_3 = 1919354072
    L6_3 = 0
    L7_3 = 0
    L8_3 = 0
    L9_3 = 0
    L10_3 = 0
    L11_3 = 0
    L12_3 = 0
    L13_3 = A0_2
    L14_3 = 0
    L15_3 = 0
    L16_3 = 0
    L2_3[1] = L3_3
    L2_3[2] = L4_3
    L2_3[3] = L5_3
    L2_3[4] = L6_3
    L2_3[5] = L7_3
    L2_3[6] = L8_3
    L2_3[7] = L9_3
    L2_3[8] = L10_3
    L2_3[9] = L11_3
    L2_3[10] = L12_3
    L2_3[11] = L13_3
    L2_3[12] = L14_3
    L2_3[13] = L15_3
    L2_3[14] = L16_3
    L0_3(L1_3, L2_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = False_notification
  L4_2 = "开启幽灵模式"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3
    L0_3 = util
    L0_3 = L0_3.trigger_script_event
    L1_3 = SYSTEM
    L1_3 = L1_3.SHIFT_LEFT
    L2_3 = A0_2
    L3_3 = 1
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = {}
    L3_3 = -642704387
    L4_3 = 0
    L5_3 = -1233120647
    L6_3 = 0
    L7_3 = 0
    L8_3 = 0
    L9_3 = 0
    L10_3 = 0
    L11_3 = 0
    L12_3 = 0
    L13_3 = A0_2
    L14_3 = 0
    L15_3 = 0
    L16_3 = 0
    L2_3[1] = L3_3
    L2_3[2] = L4_3
    L2_3[3] = L5_3
    L2_3[4] = L6_3
    L2_3[5] = L7_3
    L2_3[6] = L8_3
    L2_3[7] = L9_3
    L2_3[8] = L10_3
    L2_3[9] = L11_3
    L2_3[10] = L12_3
    L2_3[11] = L13_3
    L2_3[12] = L14_3
    L2_3[13] = L15_3
    L2_3[14] = L16_3
    L0_3(L1_3, L2_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.list
  L3_2 = classic_trolling
  L4_2 = "传送玩家"
  L5_2 = {}
  L6_2 = ""
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  player_teleport = L2_2
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = player_teleport
  L4_2 = "传送玩家到我"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = request_control
    L2_3 = L0_3
    L1_3(L2_3)
    L1_3 = ENTITY
    L1_3 = L1_3.GET_ENTITY_COORDS
    L2_3 = PLAYER
    L2_3 = L2_3.PLAYER_PED_ID
    L2_3, L3_3, L4_3, L5_3, L6_3 = L2_3()
    L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3)
    L2_3 = ENTITY
    L2_3 = L2_3.SET_ENTITY_COORDS
    L3_3 = L0_3
    L4_3 = L1_3.x
    L5_3 = L1_3.y
    L6_3 = L1_3.z
    L2_3(L3_3, L4_3, L5_3, L6_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = player_teleport
  L4_2 = "传送玩家到花园银行停机坪"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = request_control
    L2_3 = L0_3
    L1_3(L2_3)
    L1_3 = ENTITY
    L1_3 = L1_3.SET_ENTITY_COORDS
    L2_3 = L0_3
    L3_3 = -75.261375
    L4_3 = -818.674
    L5_3 = 326.17517
    L1_3(L2_3, L3_3, L4_3, L5_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.toggle_loop
  L3_2 = classic_trolling
  L4_2 = "循环爬楼梯"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3
    L0_3 = 1122863164
    L1_3 = PLAYER
    L1_3 = L1_3.GET_PLAYER_PED_SCRIPT_INDEX
    L2_3 = A0_2
    L1_3 = L1_3(L2_3)
    L2_3 = ENTITY
    L2_3 = L2_3.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
    L3_3 = L1_3
    L4_3 = 0
    L5_3 = 2
    L6_3 = 2.5
    L2_3 = L2_3(L3_3, L4_3, L5_3, L6_3)
    L3_3 = ENTITY
    L3_3 = L3_3.DOES_ENTITY_EXIST
    L4_3 = staircas_loop
    L3_3 = L3_3(L4_3)
    if not L3_3 then
      L3_3 = entities
      L3_3 = L3_3.create_object
      L4_3 = L0_3
      L5_3 = L2_3
      L3_3 = L3_3(L4_3, L5_3)
      staircas_loop = L3_3
    end
    L3_3 = ENTITY
    L3_3 = L3_3.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
    L4_3 = L1_3
    L5_3 = 0
    L6_3 = 2
    L7_3 = 2.5
    L3_3 = L3_3(L4_3, L5_3, L6_3, L7_3)
    L4_3 = ENTITY
    L4_3 = L4_3.GET_ENTITY_ROTATION
    L5_3 = L1_3
    L6_3 = 2
    L4_3 = L4_3(L5_3, L6_3)
    L5_3 = ENTITY
    L5_3 = L5_3.SET_ENTITY_COORDS_NO_OFFSET
    L6_3 = staircas_loop
    L7_3 = L3_3.x
    L8_3 = L3_3.y
    L9_3 = L3_3.z
    L10_3 = false
    L11_3 = false
    L12_3 = false
    L5_3(L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3)
    L5_3 = ENTITY
    L5_3 = L5_3.SET_ENTITY_ROTATION
    L6_3 = staircas_loop
    L7_3 = L4_3.x
    L8_3 = L4_3.y
    L9_3 = L4_3.z
    L10_3 = 2
    L11_3 = true
    L5_3(L6_3, L7_3, L8_3, L9_3, L10_3, L11_3)
  end
  function L8_2()
    local L0_3, L1_3
    L0_3 = delete_entity
    L1_3 = staircas_loop
    L0_3(L1_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = classic_trolling
  L4_2 = "B-11攻击"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3
    L0_3 = B11_attack
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = classic_trolling
  L4_2 = "发送神风炮"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3
    L0_3 = Send_Kamikaze_Gun
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = classic_trolling
  L4_2 = "派遣警车"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3
    L0_3 = spawn_police_car
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = classic_trolling
  L4_2 = "仓鼠球"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3
    L0_3 = Hamster_Ball
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = classic_trolling
  L4_2 = "粉碎机"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3
    L0_3 = shredder
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.toggle
  L3_2 = classic_trolling
  L4_2 = "升天电梯"
  L5_2 = {}
  L6_2 = ""
  function L7_2(A0_3)
    local L1_3, L2_3, L3_3
    L1_3 = biker_lift
    L2_3 = A0_3
    L3_3 = A0_2
    L1_3(L2_3, L3_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.toggle_loop
  L3_2 = classic_trolling
  L4_2 = "Mk2 自瞄"
  L5_2 = {}
  L6_2 = "MK-2导弹自动瞄准玩家"
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED_SCRIPT_INDEX
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = v3
    L1_3 = L1_3.distance
    L2_3 = players
    L2_3 = L2_3.get_position
    L3_3 = PLAYER
    L3_3 = L3_3.PLAYER_ID
    L3_3, L4_3, L5_3, L6_3 = L3_3()
    L2_3 = L2_3(L3_3, L4_3, L5_3, L6_3)
    L3_3 = players
    L3_3 = L3_3.get_position
    L4_3 = A0_2
    L3_3, L4_3, L5_3, L6_3 = L3_3(L4_3)
    L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3)
    L2_3 = PED
    L2_3 = L2_3.IS_PED_DEAD_OR_DYING
    L3_3 = L0_3
    L2_3 = L2_3(L3_3)
    if not L2_3 then
      L2_3 = PAD
      L2_3 = L2_3.IS_CONTROL_PRESSED
      L3_3 = 0
      L4_3 = 70
      L2_3 = L2_3(L3_3, L4_3)
      if L2_3 then
        L2_3 = 200.0
        if L1_3 < L2_3 then
          L2_3 = VEHICLE1
          L2_3 = L2_3.SET_VEHICLE_SHOOT_AT_TARGET
          L3_3 = PLAYER
          L3_3 = L3_3.PLAYER_PED_ID
          L3_3 = L3_3()
          L4_3 = L0_3
          L5_3 = players
          L5_3 = L5_3.get_position
          L6_3 = A0_2
          L5_3, L6_3 = L5_3(L6_3)
          L2_3(L3_3, L4_3, L5_3, L6_3)
        end
      end
    end
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.list
  L3_2 = classic_trolling
  L4_2 = "粒子效果轰炸"
  L5_2 = {}
  L6_2 = ""
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  p_eff_troll = L2_2
  L2_2 = menu
  L2_2 = L2_2.toggle_loop
  L3_2 = p_eff_troll
  L4_2 = "开启"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3
    L0_3 = p_eff_bomb
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.list_select
  L3_2 = p_eff_troll
  L4_2 = "设置粒子效果"
  L5_2 = {}
  L6_2 = "发送您选择的粒子效果"
  L7_2 = Fxcorelist
  L8_2 = 1
  function L9_2(A0_3)
    local L1_3, L2_3
    L1_3 = sel_p_eff_bomb
    L2_3 = A0_3
    L1_3(L2_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = classic_trolling
  L4_2 = "金钱掉落"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3
    L0_3 = players
    L0_3 = L0_3.get_position
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = util
    L1_3 = L1_3.joaat
    L2_3 = "prop_cash_pile_01"
    L1_3 = L1_3(L2_3)
    L2_3 = request_model
    L3_3 = L1_3
    L2_3(L3_3)
    L2_3 = 4263048111
    L3_3 = OBJECT
    L3_3 = L3_3.CREATE_PICKUP
    L4_3 = L2_3
    L5_3 = L0_3.x
    L6_3 = L0_3.y
    L7_3 = L0_3.z
    L7_3 = L7_3 + 1
    L8_3 = 1
    L9_3 = 100
    L10_3 = false
    L11_3 = L1_3
    L3_3 = L3_3(L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3)
    L4_3 = util
    L4_3 = L4_3.yield
    L5_3 = 100
    L4_3(L5_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = classic_trolling
  L4_2 = "公寓邀请通知"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3
    L0_3 = util
    L0_3 = L0_3.trigger_script_event
    L1_3 = SYSTEM
    L1_3 = L1_3.SHIFT_LEFT
    L2_3 = A0_2
    L3_3 = 1
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = {}
    L3_3 = 996099702
    L4_3 = 0
    L5_3 = 0
    L2_3[1] = L3_3
    L2_3[2] = L4_3
    L2_3[3] = L5_3
    L0_3(L1_3, L2_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.toggle_loop
  L3_2 = classic_trolling
  L4_2 = "烟雾屏幕"
  L5_2 = {}
  L6_2 = "让黑色烟雾布满他们的屏幕."
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED_SCRIPT_INDEX
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = STREAMING
    L1_3 = L1_3.REQUEST_NAMED_PTFX_ASSET
    L2_3 = "scr_as_trans"
    L1_3(L2_3)
    L1_3 = GRAPHICS
    L1_3 = L1_3.USE_PARTICLE_FX_ASSET
    L2_3 = "scr_as_trans"
    L1_3(L2_3)
    L1_3 = ptfx
    if nil ~= L1_3 then
      L1_3 = GRAPHICS
      L1_3 = L1_3.DOES_PARTICLE_FX_LOOPED_EXIST
      L2_3 = ptfx
      L1_3 = L1_3(L2_3)
      if L1_3 then
        goto lbl_43
      end
    end
    L1_3 = GRAPHICS
    L2_3 = "START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY"
    L1_3 = L1_3[L2_3]
    L2_3 = "scr_as_trans_smoke"
    L3_3 = L0_3
    L4_3 = 0.0
    L5_3 = 0.0
    L6_3 = 0.0
    L7_3 = 0.0
    L8_3 = 0.0
    L9_3 = 0.0
    L10_3 = 5.0
    L11_3 = false
    L12_3 = false
    L13_3 = false
    L14_3 = 0
    L15_3 = 0
    L16_3 = 0
    L17_3 = 255
    L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3)
    ptfx = L1_3
    ::lbl_43::
  end
  function L8_2()
    local L0_3, L1_3, L2_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED_SCRIPT_INDEX
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = GRAPHICS
    L1_3 = L1_3.REMOVE_PARTICLE_FX
    L2_3 = ptfx
    L1_3(L2_3)
    L1_3 = STREAMING
    L1_3 = L1_3.REMOVE_NAMED_PTFX_ASSET
    L2_3 = "scr_as_trans"
    L1_3(L2_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = classic_trolling
  L4_2 = "消防栓大喷水"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3
    L0_3 = firefighting
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = classic_trolling
  L4_2 = "强制打开降落伞"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3, L2_3
    L0_3 = PED
    L0_3 = L0_3.FORCE_PED_TO_OPEN_PARACHUTE
    L1_3 = PLAYER
    L1_3 = L1_3.GET_PLAYER_PED
    L2_3 = A0_2
    L1_3, L2_3 = L1_3(L2_3)
    L0_3(L1_3, L2_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.list
  L3_2 = classic_trolling
  L4_2 = "恶搞载具"
  L5_2 = {}
  L6_2 = ""
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  trolly_Vehicles = L2_2
  L2_2 = menu
  L2_2 = L2_2.textslider
  L3_2 = trolly_Vehicles
  L4_2 = "发送恶搞载具"
  L5_2 = {}
  L6_2 = ""
  L7_2 = {}
  L8_2 = "Bandito"
  L9_2 = "Go-Kart"
  L7_2[1] = L8_2
  L7_2[2] = L9_2
  function L8_2(A0_3, A1_3)
    local L2_3, L3_3, L4_3, L5_3
    L2_3 = send_veh_attack
    L3_3 = A1_3
    L4_3 = A0_3
    L5_3 = A0_2
    L2_3(L3_3, L4_3, L5_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  L2_2 = menu
  L2_2 = L2_2.toggle
  L3_2 = trolly_Vehicles
  L4_2 = "设置无敌"
  L5_2 = {}
  L6_2 = ""
  function L7_2(A0_3)
    local L1_3, L2_3
    L1_3 = send_veh_attack_god
    L2_3 = A0_3
    L1_3(L2_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = trolly_Vehicles
  L4_2 = "派武装匪徒"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3
    L0_3 = send_veh_attacker
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.textslider_stateful
  L3_2 = trolly_Vehicles
  L4_2 = "武装匪徒武器"
  L5_2 = {}
  L6_2 = ""
  L7_2 = {}
  L8_2 = util
  L8_2 = L8_2.get_label_text
  L9_2 = "BAND_BOMB"
  L8_2 = L8_2(L9_2)
  L9_2 = util
  L9_2 = L9_2.get_label_text
  L10_2 = "TOP_MINE"
  L9_2, L10_2, L11_2, L12_2, L13_2 = L9_2(L10_2)
  L7_2[1] = L8_2
  L7_2[2] = L9_2
  L7_2[3] = L10_2
  L7_2[4] = L11_2
  L7_2[5] = L12_2
  L7_2[6] = L13_2
  function L8_2(A0_3, A1_3)
    local L2_3, L3_3, L4_3
    L2_3 = send_veh_attacker_weapon
    L3_3 = A0_3
    L4_3 = A1_3
    L2_3(L3_3, L4_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  L2_2 = menu
  L2_2 = L2_2.textslider_stateful
  L3_2 = trolly_Vehicles
  L4_2 = "地雷"
  L5_2 = {}
  L6_2 = ""
  L7_2 = {}
  L8_2 = util
  L8_2 = L8_2.get_label_text
  L9_2 = "KINET_MINE"
  L8_2 = L8_2(L9_2)
  L9_2 = util
  L9_2 = L9_2.get_label_text
  L10_2 = "EMP_MINE"
  L9_2, L10_2, L11_2, L12_2, L13_2 = L9_2(L10_2)
  L7_2[1] = L8_2
  L7_2[2] = L9_2
  L7_2[3] = L10_2
  L7_2[4] = L11_2
  L7_2[5] = L12_2
  L7_2[6] = L13_2
  function L8_2(A0_3, A1_3)
    local L2_3, L3_3, L4_3
    L2_3 = send_veh_attacker_weapon_mine
    L3_3 = A0_3
    L4_3 = A1_3
    L2_3(L3_3, L4_3)
  end
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  mineSlider = L2_2
  L2_2 = menu
  L2_2 = L2_2.slider
  L3_2 = trolly_Vehicles
  L4_2 = "数量"
  L5_2 = {}
  L6_2 = ""
  L7_2 = 1
  L8_2 = 10
  L9_2 = 1
  L10_2 = 1
  function L11_2(A0_3)
    local L1_3, L2_3
    L1_3 = send_veh_attacker_number
    L2_3 = A0_3
    L1_3(L2_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = trolly_Vehicles
  L4_2 = "删除"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3
    L0_3 = dele_all_veh_attacker
    L0_3()
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.list
  L3_2 = classic_trolling
  L4_2 = "敌对载具"
  L5_2 = {}
  L6_2 = ""
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  enemyVehiclesOpt = L2_2
  L2_2 = menu
  L2_2 = L2_2.textslider
  L3_2 = enemyVehiclesOpt
  L4_2 = "生成敌对载具"
  L5_2 = {}
  L6_2 = ""
  L7_2 = enemy_options
  function L8_2(A0_3, A1_3)
    local L2_3, L3_3, L4_3, L5_3
    L2_3 = send_enemy_veh
    L3_3 = A0_3
    L4_3 = A1_3
    L5_3 = A0_2
    L2_3(L3_3, L4_3, L5_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  L2_2 = menu
  L2_2 = L2_2.list_select
  L3_2 = enemyVehiclesOpt
  L4_2 = "迷你坦克武器"
  L5_2 = {}
  L6_2 = ""
  L7_2 = gunnerWeaponNames
  L8_2 = 1
  function L9_2(A0_3)
    local L1_3, L2_3
    L1_3 = mini_tank_weapon
    L2_3 = A0_3
    L1_3(L2_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L2_2 = menu
  L2_2 = L2_2.list_select
  L3_2 = enemyVehiclesOpt
  L4_2 = "枪手的武器"
  L5_2 = {}
  L6_2 = ""
  L7_2 = enemVehOptions
  L8_2 = 1
  function L9_2(A0_3)
    local L1_3, L2_3
    L1_3 = enemy_gunman_weapon
    L2_3 = A0_3
    L1_3(L2_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L2_2 = menu
  L2_2 = L2_2.slider
  L3_2 = enemyVehiclesOpt
  L4_2 = "生成数量"
  L5_2 = {}
  L6_2 = ""
  L7_2 = 1
  L8_2 = 10
  L9_2 = 1
  L10_2 = 1
  function L11_2(A0_3)
    local L1_3, L2_3
    L1_3 = set_enemy_count
    L2_3 = A0_3
    L1_3(L2_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L2_2 = menu
  L2_2 = L2_2.toggle
  L3_2 = enemyVehiclesOpt
  L4_2 = "无敌"
  L5_2 = {}
  L6_2 = ""
  function L7_2(A0_3)
    local L1_3, L2_3
    L1_3 = set_enemy_Godmode
    L2_3 = A0_3
    L1_3(L2_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = enemyVehiclesOpt
  L4_2 = "删除"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3
    L0_3 = delete_enemy_veh
    L0_3()
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.toggle_loop
  L3_2 = classic_trolling
  L4_2 = "摇晃镜头"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
    L0_3 = NETWORK
    L0_3 = L0_3.NETWORK_IS_PLAYER_ACTIVE
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    if L0_3 then
      L0_3 = PLAYER
      L0_3 = L0_3.GET_PLAYER_PED
      L1_3 = A0_2
      L0_3 = L0_3(L1_3)
      if 0 ~= L0_3 then
        L0_3 = players
        L0_3 = L0_3.get_position
        L1_3 = A0_2
        L0_3 = L0_3(L1_3)
        L1_3 = FIRE
        L1_3 = L1_3.ADD_OWNED_EXPLOSION
        L2_3 = PLAYER
        L2_3 = L2_3.GET_PLAYER_PED
        L3_3 = A0_2
        L2_3 = L2_3(L3_3)
        L3_3 = L0_3.x
        L4_3 = L0_3.y
        L5_3 = L0_3.z
        L6_3 = 0
        L7_3 = 0.0
        L8_3 = false
        L9_3 = true
        L10_3 = 80.0
        L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3)
        L1_3 = util
        L1_3 = L1_3.yield
        L2_3 = 150
        L1_3(L2_3)
      end
    end
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = classic_trolling
  L4_2 = "清除任务"
  L5_2 = {}
  L6_2 = "可将玩家踢出载具"
  function L7_2()
    local L0_3, L1_3, L2_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = TASK
    L1_3 = L1_3.CLEAR_PED_TASKS_IMMEDIATELY
    L2_3 = L0_3
    L1_3(L2_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = classic_trolling
  L4_2 = "炸鱼"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3
    L0_3 = fried_fish
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = classic_trolling
  L4_2 = "泰坦号轰炸"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3
    L0_3 = Titan_bombing
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.toggle_loop
  L3_2 = classic_trolling
  L4_2 = "渲染粒子"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3
    L0_3 = Render_particles
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.list
  L3_2 = classic_trolling
  L4_2 = "传送实体"
  L5_2 = {}
  L6_2 = ""
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  tp_entity = L2_2
  L2_2 = menu
  L2_2 = L2_2.toggle_loop
  L3_2 = tp_entity
  L4_2 = "传送所有PED给玩家"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3
    L0_3 = TpAllPeds
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.toggle_loop
  L3_2 = tp_entity
  L4_2 = "传送所有载具给玩家"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3
    L0_3 = TpAllVehs
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.toggle_loop
  L3_2 = tp_entity
  L4_2 = "传送所有物体给玩家"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3
    L0_3 = TpAllObjects
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = classic_trolling
  L4_2 = "生成怪兽军队"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3
    L0_3 = Create_Monster_Army
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.list
  L3_2 = classic_trolling
  L4_2 = "鬼畜玩家"
  L5_2 = {}
  L6_2 = ""
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  glitch_player = L2_2
  L2_2 = menu
  L2_2 = L2_2.list_select
  L3_2 = glitch_player
  L4_2 = "物体"
  L5_2 = {}
  L6_2 = "选择鬼畜玩家使用的物体."
  L7_2 = object_stuff
  L7_2 = L7_2.names
  L8_2 = 1
  function L9_2(A0_3)
    local L1_3, L2_3
    L1_3 = obj_creat
    L2_3 = A0_3
    L1_3(L2_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L2_2 = menu
  L2_2 = L2_2.slider
  L3_2 = glitch_player
  L4_2 = "物体生成延迟"
  L5_2 = {}
  L6_2 = "spawndelay"
  L5_2[1] = L6_2
  L6_2 = ""
  L7_2 = 0
  L8_2 = 3000
  L9_2 = 150
  L10_2 = 10
  function L11_2(A0_3)
    local L1_3, L2_3
    L1_3 = obj_creat_speed
    L2_3 = A0_3
    L1_3(L2_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L2_2 = menu
  L2_2 = L2_2.toggle_loop
  L3_2 = glitch_player
  L4_2 = "鬼畜玩家"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3
    L0_3 = Ghost_Beast_Player
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  glitchplayer = L2_2
  L2_2 = menu
  L2_2 = L2_2.toggle_loop
  L3_2 = classic_trolling
  L4_2 = "电击玩家"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED_SCRIPT_INDEX
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = players
    L1_3 = L1_3.get_position
    L2_3 = A0_2
    L1_3 = L1_3(L2_3)
    L2_3 = MISC
    L2_3 = L2_3.SHOOT_SINGLE_BULLET_BETWEEN_COORDS
    L3_3 = L1_3.x
    L4_3 = L1_3.y
    L5_3 = L1_3.z
    L5_3 = L5_3 + 1
    L6_3 = L1_3.x
    L7_3 = L1_3.y
    L8_3 = L1_3.z
    L9_3 = 1000
    L10_3 = true
    L11_3 = util
    L11_3 = L11_3.joaat
    L12_3 = "weapon_stungun"
    L11_3 = L11_3(L12_3)
    L12_3 = false
    L13_3 = false
    L14_3 = true
    L15_3 = 1.0
    L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = classic_trolling
  L4_2 = "核弹1"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3
    L0_3 = nuclear_bomb_player
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.action
  L3_2 = classic_trolling
  L4_2 = "核弹2"
  L5_2 = {}
  L6_2 = ""
  function L7_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3
    L0_3 = util
    L0_3 = L0_3.joaat
    L1_3 = "prop_military_pickup_01"
    L0_3 = L0_3(L1_3)
    L1_3 = request_model
    L2_3 = L0_3
    L1_3(L2_3)
    L1_3 = players
    L1_3 = L1_3.get_position
    L2_3 = A0_2
    L1_3 = L1_3(L2_3)
    L2_3 = OBJECT
    L2_3 = L2_3.CREATE_OBJECT_NO_OFFSET
    L3_3 = L0_3
    L4_3 = L1_3.x
    L5_3 = L1_3.y
    L6_3 = L1_3.z
    L6_3 = L6_3 + 20
    L7_3 = true
    L8_3 = false
    L9_3 = true
    L2_3 = L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3)
    L3_3 = ENTITY
    L3_3 = L3_3.APPLY_FORCE_TO_ENTITY
    L4_3 = L2_3
    L5_3 = 3
    L6_3 = 0.0
    L7_3 = 0.0
    L8_3 = -50
    L9_3 = 0.0
    L10_3 = 0.0
    L11_3 = 0.0
    L12_3 = 0
    L13_3 = true
    L14_3 = false
    L15_3 = true
    L16_3 = false
    L17_3 = true
    L3_3(L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3)
    L3_3 = ENTITY
    L3_3 = L3_3.SET_ENTITY_HAS_GRAVITY
    L4_3 = L2_3
    L5_3 = true
    L3_3(L4_3, L5_3)
    while true do
      L3_3 = ENTITY
      L3_3 = L3_3.HAS_ENTITY_COLLIDED_WITH_ANYTHING
      L4_3 = L2_3
      L3_3 = L3_3(L4_3)
      if L3_3 then
        break
      end
      L3_3 = ENTITY
      L3_3 = L3_3.IS_ENTITY_IN_WATER
      L4_3 = L2_3
      L3_3 = L3_3(L4_3)
      if L3_3 then
        break
      end
      L3_3 = util
      L3_3 = L3_3.yield
      L4_3 = 0
      L3_3(L4_3)
    end
    L3_3 = ENTITY
    L3_3 = L3_3.GET_ENTITY_COORDS
    L4_3 = L2_3
    L5_3 = true
    L3_3 = L3_3(L4_3, L5_3)
    L4_3 = delete_entity
    L5_3 = L2_3
    L4_3(L5_3)
    L4_3 = create_nuke_explosion
    L5_3 = L3_3
    L4_3(L5_3)
  end
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = menu
  L2_2 = L2_2.list
  L3_2 = classic_trolling
  L4_2 = "给予悬赏"
  L5_2 = {}
  L6_2 = ""
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  bountyplayer = L2_2
  L2_2 = 10000
  L3_2 = menu
  L3_2 = L3_2.action
  L4_2 = bountyplayer
  L5_2 = "悬赏"
  L6_2 = {}
  L7_2 = ""
  function L8_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_NAME
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = menu
    L1_3 = L1_3.trigger_commands
    L2_3 = "bounty"
    L3_3 = L0_3
    L4_3 = " "
    L5_3 = L2_2
    L2_3 = L2_3 .. L3_3 .. L4_3 .. L5_3
    L1_3(L2_3)
  end
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
  L3_2 = bountyplayer
  L4_2 = L3_2
  L3_2 = L3_2.slider
  L5_2 = "悬赏金额"
  L6_2 = {}
  L7_2 = "Bountyamountplayer"
  L6_2[1] = L7_2
  L7_2 = ""
  L8_2 = 1
  L9_2 = 10000
  L10_2 = 10000
  L11_2 = 1000
  function L12_2(A0_3)
    local L1_3
    L2_2 = A0_3
  end
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L3_2 = menu
  L3_2 = L3_2.action
  L4_2 = classic_trolling
  L5_2 = "踢出室内"
  L6_2 = {}
  L7_2 = "强制将玩家踢出室内."
  function L8_2()
    local L0_3, L1_3
    L0_3 = Kick_room
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
  L3_2 = menu
  L3_2 = L3_2.toggle
  L4_2 = classic_trolling
  L5_2 = "撒尿"
  L6_2 = {}
  L7_2 = "随地大小便应该遭到谴责"
  function L8_2(A0_3)
    local L1_3, L2_3, L3_3
    L1_3 = peeloop_player
    L2_3 = A0_2
    L3_3 = A0_3
    L1_3(L2_3, L3_3)
  end
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
  L3_2 = menu
  L3_2 = L3_2.toggle
  L4_2 = classic_trolling
  L5_2 = "骑乘玩家1"
  L6_2 = {}
  L7_2 = "仅本地有效"
  function L8_2(A0_3)
    local L1_3, L2_3, L3_3
    L1_3 = ride_player1
    L2_3 = A0_2
    L3_3 = A0_3
    L1_3(L2_3, L3_3)
  end
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
  L3_2 = menu
  L3_2 = L3_2.toggle
  L4_2 = classic_trolling
  L5_2 = "骑乘玩家2"
  L6_2 = {}
  L7_2 = "仅本地有效"
  function L8_2(A0_3)
    local L1_3, L2_3, L3_3
    L1_3 = ride_player2
    L2_3 = A0_2
    L3_3 = A0_3
    L1_3(L2_3, L3_3)
  end
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
  L3_2 = menu
  L3_2 = L3_2.action
  L4_2 = classic_trolling
  L5_2 = "UFO引力"
  L6_2 = {}
  L7_2 = "使用UFO将它们拉起一秒钟"
  function L8_2()
    local L0_3, L1_3
    L0_3 = UFO_gravitation
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
  L3_2 = menu
  L3_2 = L3_2.action
  L4_2 = weapon_trolling
  L5_2 = "移除玩家武器"
  L6_2 = {}
  L7_2 = ""
  function L8_2()
    local L0_3, L1_3
    L0_3 = remove_all_weapon
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
  L3_2 = menu
  L3_2 = L3_2.toggle_loop
  L4_2 = weapon_trolling
  L5_2 = "重型狙击枪攻击"
  L6_2 = {}
  L7_2 = ""
  function L8_2()
    local L0_3, L1_3
    L0_3 = Heavy_gun_to_player
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
  L3_2 = menu
  L3_2 = L3_2.toggle_loop
  L4_2 = weapon_trolling
  L5_2 = "烟花攻击"
  L6_2 = {}
  L7_2 = "Fireworksdownward"
  L6_2[1] = L7_2
  L7_2 = ""
  function L8_2()
    local L0_3, L1_3
    L0_3 = firework_to_player
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
  L3_2 = menu
  L3_2 = L3_2.toggle_loop
  L4_2 = weapon_trolling
  L5_2 = "原子波攻击"
  L6_2 = {}
  L7_2 = ""
  function L8_2()
    local L0_3, L1_3
    L0_3 = atom_waves_to_player
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
  L3_2 = menu
  L3_2 = L3_2.toggle_loop
  L4_2 = weapon_trolling
  L5_2 = "燃烧弹攻击"
  L6_2 = {}
  L7_2 = ""
  function L8_2()
    local L0_3, L1_3
    L0_3 = Incendiary_to_player
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
  L3_2 = menu
  L3_2 = L3_2.toggle_loop
  L4_2 = weapon_trolling
  L5_2 = "电磁脉冲攻击"
  L6_2 = {}
  L7_2 = ""
  function L8_2()
    local L0_3, L1_3
    L0_3 = ElectroMagnetic_Pulse_to_player
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
  L3_2 = menu
  L3_2 = L3_2.toggle_loop
  L4_2 = trolling
  L5_2 = "烟花发射玩家"
  L6_2 = {}
  L7_2 = ""
  function L8_2()
    local L0_3, L1_3
    L0_3 = firework_send_player
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
  L3_2 = menu
  L3_2 = L3_2.list
  L4_2 = trolling
  L5_2 = "烟火秀"
  L6_2 = {}
  L7_2 = ""
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
  fire_work_show = L3_2
  L3_2 = {}
  L3_2.speed = 1000
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = fire_work_show
  L6_2 = "头顶烟火"
  L7_2 = {}
  L8_2 = "开始一场烟火秀"
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED_SCRIPT_INDEX
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = ENTITY
    L1_3 = L1_3.GET_ENTITY_COORDS
    L2_3 = L0_3
    L3_3 = true
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = util
    L2_3 = L2_3.joaat
    L3_3 = "weapon_firework"
    L2_3 = L2_3(L3_3)
    L3_3 = WEAPON
    L3_3 = L3_3.REQUEST_WEAPON_ASSET
    L4_3 = L2_3
    L3_3(L4_3)
    L3_3 = 0
    L4_3 = 1
    L5_3 = 1
    for L6_3 = L3_3, L4_3, L5_3 do
      L7_3 = MISC
      L7_3 = L7_3.SHOOT_SINGLE_BULLET_BETWEEN_COORDS
      L8_3 = L1_3.x
      L9_3 = L1_3.y
      L10_3 = L1_3.z
      L10_3 = L10_3 + 4.0
      L11_3 = L1_3.x
      L12_3 = math
      L12_3 = L12_3.random
      L13_3 = -100
      L14_3 = 100
      L12_3 = L12_3(L13_3, L14_3)
      L11_3 = L11_3 - L12_3
      L12_3 = L1_3.y
      L13_3 = math
      L13_3 = L13_3.random
      L14_3 = -100
      L15_3 = 100
      L13_3 = L13_3(L14_3, L15_3)
      L12_3 = L12_3 - L13_3
      L13_3 = L1_3.z
      L14_3 = math
      L14_3 = L14_3.random
      L15_3 = 10
      L16_3 = 15
      L14_3 = L14_3(L15_3, L16_3)
      L13_3 = L13_3 + L14_3
      L14_3 = 200
      L15_3 = 0
      L16_3 = L2_3
      L17_3 = 0
      L18_3 = false
      L19_3 = false
      L20_3 = L3_2.speed
      L7_3(L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3)
      L7_3 = MISC
      L7_3 = L7_3.SHOOT_SINGLE_BULLET_BETWEEN_COORDS
      L8_3 = L1_3.x
      L9_3 = L1_3.y
      L10_3 = L1_3.z
      L10_3 = L10_3 + 4.0
      L11_3 = L1_3.x
      L12_3 = math
      L12_3 = L12_3.random
      L13_3 = -100
      L14_3 = 100
      L12_3 = L12_3(L13_3, L14_3)
      L11_3 = L11_3 + L12_3
      L12_3 = L1_3.y
      L13_3 = math
      L13_3 = L13_3.random
      L14_3 = -100
      L15_3 = 100
      L13_3 = L13_3(L14_3, L15_3)
      L12_3 = L12_3 + L13_3
      L13_3 = L1_3.z
      L14_3 = math
      L14_3 = L14_3.random
      L15_3 = 10
      L16_3 = 15
      L14_3 = L14_3(L15_3, L16_3)
      L13_3 = L13_3 + L14_3
      L14_3 = 200
      L15_3 = 0
      L16_3 = L2_3
      L17_3 = 0
      L18_3 = false
      L19_3 = false
      L20_3 = L3_2.speed
      L7_3(L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3)
      L7_3 = FIRE
      L7_3 = L7_3.ADD_EXPLOSION
      L8_3 = L1_3.x
      L9_3 = math
      L9_3 = L9_3.random
      L10_3 = -100
      L11_3 = 100
      L9_3 = L9_3(L10_3, L11_3)
      L8_3 = L8_3 + L9_3
      L9_3 = L1_3.y
      L10_3 = math
      L10_3 = L10_3.random
      L11_3 = -100
      L12_3 = 100
      L10_3 = L10_3(L11_3, L12_3)
      L9_3 = L9_3 + L10_3
      L10_3 = L1_3.z
      L11_3 = math
      L11_3 = L11_3.random
      L12_3 = 50
      L13_3 = 75
      L11_3 = L11_3(L12_3, L13_3)
      L10_3 = L10_3 + L11_3
      L11_3 = 38
      L12_3 = 1
      L13_3 = false
      L14_3 = false
      L15_3 = 0
      L16_3 = false
      L7_3(L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3)
      L7_3 = FIRE
      L7_3 = L7_3.ADD_EXPLOSION
      L8_3 = L1_3.x
      L9_3 = math
      L9_3 = L9_3.random
      L10_3 = -100
      L11_3 = 100
      L9_3 = L9_3(L10_3, L11_3)
      L8_3 = L8_3 - L9_3
      L9_3 = L1_3.y
      L10_3 = math
      L10_3 = L10_3.random
      L11_3 = -100
      L12_3 = 100
      L10_3 = L10_3(L11_3, L12_3)
      L9_3 = L9_3 - L10_3
      L10_3 = L1_3.z
      L11_3 = math
      L11_3 = L11_3.random
      L12_3 = 50
      L13_3 = 75
      L11_3 = L11_3(L12_3, L13_3)
      L10_3 = L10_3 + L11_3
      L11_3 = 38
      L12_3 = 1
      L13_3 = false
      L14_3 = false
      L15_3 = 0
      L16_3 = false
      L7_3(L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3)
    end
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = fire_work_show
  L6_2 = "脚下烟火"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED_SCRIPT_INDEX
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = ENTITY
    L1_3 = L1_3.GET_ENTITY_COORDS
    L2_3 = L0_3
    L3_3 = true
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = util
    L2_3 = L2_3.joaat
    L3_3 = "weapon_firework"
    L2_3 = L2_3(L3_3)
    L3_3 = WEAPON
    L3_3 = L3_3.REQUEST_WEAPON_ASSET
    L4_3 = L2_3
    L3_3(L4_3)
    L3_3 = 0
    L4_3 = 1
    L5_3 = 1
    for L6_3 = L3_3, L4_3, L5_3 do
      L7_3 = MISC
      L7_3 = L7_3.SHOOT_SINGLE_BULLET_BETWEEN_COORDS
      L8_3 = L1_3.x
      L9_3 = L1_3.y
      L10_3 = L1_3.z
      L10_3 = L10_3 + -1.0
      L11_3 = L1_3.x
      L12_3 = math
      L12_3 = L12_3.random
      L13_3 = -100
      L14_3 = 100
      L12_3 = L12_3(L13_3, L14_3)
      L11_3 = L11_3 - L12_3
      L12_3 = L1_3.y
      L13_3 = math
      L13_3 = L13_3.random
      L14_3 = -100
      L15_3 = 100
      L13_3 = L13_3(L14_3, L15_3)
      L12_3 = L12_3 - L13_3
      L13_3 = L1_3.z
      L14_3 = math
      L14_3 = L14_3.random
      L15_3 = 10
      L16_3 = 15
      L14_3 = L14_3(L15_3, L16_3)
      L13_3 = L13_3 + L14_3
      L14_3 = 200
      L15_3 = 0
      L16_3 = L2_3
      L17_3 = 0
      L18_3 = false
      L19_3 = false
      L20_3 = L3_2.speed
      L7_3(L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3)
      L7_3 = FIRE
      L7_3 = L7_3.ADD_EXPLOSION
      L8_3 = L1_3.x
      L9_3 = math
      L9_3 = L9_3.random
      L10_3 = -100
      L11_3 = 100
      L9_3 = L9_3(L10_3, L11_3)
      L8_3 = L8_3 + L9_3
      L9_3 = L1_3.y
      L10_3 = math
      L10_3 = L10_3.random
      L11_3 = -100
      L12_3 = 100
      L10_3 = L10_3(L11_3, L12_3)
      L9_3 = L9_3 + L10_3
      L10_3 = L1_3.z
      L11_3 = math
      L11_3 = L11_3.random
      L12_3 = 50
      L13_3 = 75
      L11_3 = L11_3(L12_3, L13_3)
      L10_3 = L10_3 + L11_3
      L11_3 = 38
      L12_3 = 1
      L13_3 = false
      L14_3 = false
      L15_3 = 0
      L16_3 = false
      L7_3(L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3)
      L7_3 = FIRE
      L7_3 = L7_3.ADD_EXPLOSION
      L8_3 = L1_3.x
      L9_3 = math
      L9_3 = L9_3.random
      L10_3 = -100
      L11_3 = 100
      L9_3 = L9_3(L10_3, L11_3)
      L8_3 = L8_3 - L9_3
      L9_3 = L1_3.y
      L10_3 = math
      L10_3 = L10_3.random
      L11_3 = -100
      L12_3 = 100
      L10_3 = L10_3(L11_3, L12_3)
      L9_3 = L9_3 - L10_3
      L10_3 = L1_3.z
      L11_3 = math
      L11_3 = L11_3.random
      L12_3 = 50
      L13_3 = 75
      L11_3 = L11_3(L12_3, L13_3)
      L10_3 = L10_3 + L11_3
      L11_3 = 38
      L12_3 = 1
      L13_3 = false
      L14_3 = false
      L15_3 = 0
      L16_3 = false
      L7_3(L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3)
    end
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = trolling
  L6_2 = "假钱雨"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED_SCRIPT_INDEX
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = ENTITY
    L1_3 = L1_3.GET_ENTITY_COORDS
    L2_3 = L0_3
    L3_3 = true
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = request_ptfx_asset
    L3_3 = "core"
    L2_3(L3_3)
    L2_3 = GRAPHICS
    L3_3 = "START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD"
    L2_3 = L2_3[L3_3]
    L3_3 = "ent_brk_banknotes"
    L4_3 = L1_3.x
    L5_3 = L1_3.y
    L6_3 = L1_3.z
    L6_3 = L6_3 + 1
    L7_3 = 0
    L8_3 = 0
    L9_3 = 0
    L10_3 = 3.0
    L11_3 = true
    L12_3 = true
    L13_3 = true
    L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3)
    L2_3 = players
    L2_3 = L2_3.exists
    L3_3 = A0_2
    L2_3 = L2_3(L3_3)
    if not L2_3 then
      L2_3 = util
      L2_3 = L2_3.stop_thread
      L2_3()
    end
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.list
  L5_2 = lz
  L6_2 = "Ped笼子"
  L7_2 = {}
  L8_2 = ""
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  ped_cage_lt = L4_2
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = ped_cage_lt
  L6_2 = "开启"
  L7_2 = {}
  L8_2 = "将玩家困在Ped笼子里"
  function L9_2()
    local L0_3, L1_3
    L0_3 = auto_ped_cage
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.list_select
  L5_2 = ped_cage_lt
  L6_2 = "选择Ped笼子"
  L7_2 = {}
  L8_2 = ""
  L9_2 = pedset_opt
  L10_2 = 1
  function L11_2(A0_3)
    local L1_3, L2_3
    L1_3 = select_ped_cage
    L2_3 = A0_3
    L1_3(L2_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L4_2 = menu
  L4_2 = L4_2.list
  L5_2 = lz
  L6_2 = "物体笼子"
  L7_2 = {}
  L8_2 = ""
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  obj_cage_lt = L4_2
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = obj_cage_lt
  L6_2 = "开启"
  L7_2 = {}
  L8_2 = "将玩家困在物体笼子里"
  function L9_2()
    local L0_3, L1_3
    L0_3 = auto_obj_cage
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.list_select
  L5_2 = obj_cage_lt
  L6_2 = "选择物体笼子"
  L7_2 = {}
  L8_2 = ""
  L9_2 = objsetcage_name
  L10_2 = 1
  function L11_2(A0_3)
    local L1_3, L2_3
    L1_3 = select_obj_cage
    L2_3 = A0_3
    L1_3(L2_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = lz
  L6_2 = "试验升降机"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = test_elevator
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = lz
  L6_2 = "柱形笼"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = pillar_cage
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = lz
  L6_2 = "栅栏"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = fence_cage
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = lz
  L6_2 = "地狱笼子"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = hell_cage
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.list_action
  L5_2 = lz
  L6_2 = "移动笼子"
  L7_2 = {}
  L8_2 = ""
  L9_2 = kidnap_types
  function L10_2(A0_3, A1_3)
    local L2_3, L3_3, L4_3, L5_3
    L2_3 = kidnapplayer
    L3_3 = A0_2
    L4_3 = A0_3
    L5_3 = A1_3
    L2_3(L3_3, L4_3, L5_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = lz
  L6_2 = "缆车笼子"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = tramway_cage
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = lz
  L6_2 = "小桶笼子"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = Kegs_cage
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = lz
  L6_2 = "电击笼子"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = Shock_cage
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = lz
  L6_2 = "集装箱笼子"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = Container_cage
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = lz
  L6_2 = "隐形笼子"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = Vehicle_cage
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = lz
  L6_2 = "树木笼子"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED_SCRIPT_INDEX
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = spam_entity_on_player
    L2_3 = L0_3
    L3_3 = -37176073
    L1_3(L2_3, L3_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = lz
  L6_2 = "关门放狗"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = Close_dog
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = lz
  L6_2 = "恐怖之牢"
  L7_2 = {}
  L8_2 = "听说半夜能吓死人"
  function L9_2()
    local L0_3, L1_3
    L0_3 = Terror_Prison
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = lz
  L6_2 = "普通笼子"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = ptlz
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = lz
  L6_2 = "小的竞技管"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = Small_athletics
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = lz
  L6_2 = "竖向货机笼子"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = Vertical_freighter_cage
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = lz
  L6_2 = "横行货机笼子"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = Rampage_plane_cage
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = lz
  L6_2 = "支柱笼子"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = rub_cage
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = lz
  L6_2 = "全自动笼子"
  L7_2 = {}
  L8_2 = "每一秒套一次"
  function L9_2()
    local L0_3, L1_3
    L0_3 = rub_cage
    L1_3 = A0_2
    L0_3(L1_3)
    L0_3 = util
    L0_3 = L0_3.yield
    L1_3 = 1000
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = lz
  L6_2 = "英国女王笼子"
  L7_2 = {}
  L8_2 = ""
  function L9_2(A0_3)
    local L1_3, L2_3
    L1_3 = gueencage
    L2_3 = A0_2
    L1_3(L2_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = lz
  L6_2 = "燃气笼"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = gascage
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = lz
  L6_2 = "七度空间"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = qdkj
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = lz
  L6_2 = "钱笼子"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = zdlz
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = lz
  L6_2 = "垃圾箱"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = yylz
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = lz
  L6_2 = "小车车"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = cclz
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = lz
  L6_2 = "圣诞树"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = sdkl1
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = lz
  L6_2 = "圣诞快乐pro"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = sdkl2
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = lz
  L6_2 = "圣诞快乐promax"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = sdkl3
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = lz
  L6_2 = "竞技管"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = jjglz
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = npc_trolling
  L6_2 = "消防车攻击"
  L7_2 = {}
  L8_2 = "消防车对着玩家一直洒水"
  function L9_2()
    local L0_3, L1_3
    L0_3 = Firetruck_attack
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.list_action
  L5_2 = npc_trolling
  L6_2 = "NPC在玩家面前自杀"
  L7_2 = {}
  L8_2 = "在玩家面前生成一个自杀的ped"
  L9_2 = _ENV
  L10_2 = "traumatize_options"
  L9_2 = L9_2[L10_2]
  function L10_2(A0_3)
    local L1_3, L2_3, L3_3
    L1_3 = npc_suicide
    L2_3 = A0_3
    L3_3 = A0_2
    L1_3(L2_3, L3_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = npc_trolling
  L6_2 = "敌对行人"
  L7_2 = {}
  L8_2 = "周围的npc干他"
  function L9_2()
    local L0_3, L1_3
    L0_3 = Enemy_NPCS
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = npc_trolling
  L6_2 = "NPC杀"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = NPC_kill
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = npc_trolling
  L6_2 = "派遣劫匪"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = sendmugger_npc
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = npc_trolling
  L6_2 = "苦力怕小丑(MC里的爬行者)"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = creep
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = npc_trolling
  L6_2 = "发送崔佛"
  L7_2 = {}
  L8_2 = "派崔佛去撞他们或碾压他们"
  function L9_2()
    local L0_3, L1_3
    L0_3 = send_Angry_Trevor
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = _ENV
  L5_2 = "attackers_root"
  L6_2 = menu
  L6_2 = L6_2.list
  L7_2 = npc_trolling
  L8_2 = "攻击者"
  L9_2 = {}
  L10_2 = ""
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
  L4_2[L5_2] = L6_2
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "attackers_root"
  L5_2 = L5_2[L6_2]
  L6_2 = "狗子攻击者"
  L7_2 = {}
  L8_2 = "arf uwu"
  function L9_2()
    local L0_3, L1_3, L2_3
    L0_3 = send_attacker
    L1_3 = -1788665315
    L2_3 = A0_2
    L0_3(L1_3, L2_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "attackers_root"
  L5_2 = L5_2[L6_2]
  L6_2 = "丧尸攻击者"
  L7_2 = {}
  L8_2 = "rawr"
  function L9_2()
    local L0_3, L1_3, L2_3
    L0_3 = send_attacker
    L1_3 = -1404353274
    L2_3 = A0_2
    L0_3(L1_3, L2_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "attackers_root"
  L5_2 = L5_2[L6_2]
  L6_2 = "布拉德攻击者"
  L7_2 = {}
  L8_2 = "恐怖的\n没有下体"
  function L9_2()
    local L0_3, L1_3, L2_3
    L0_3 = send_attacker
    L1_3 = util
    L1_3 = L1_3.joaat
    L2_3 = "CS_BradCadaver"
    L1_3 = L1_3(L2_3)
    L2_3 = A0_2
    L0_3(L1_3, L2_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "attackers_root"
  L5_2 = L5_2[L6_2]
  L6_2 = "悲伤的耶稣"
  L7_2 = {}
  L8_2 = "产生一个不可战胜的耶稣和一个轨道枪,将不断攻击玩家,即使他们死后。如果他们太远,传送到他们。这有时会非常容易出错,但通常是由于网络"
  function L9_2()
    local L0_3, L1_3
    L0_3 = dispatch_griefer_jesus
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "attackers_root"
  L5_2 = L5_2[L6_2]
  L6_2 = "天煞战斗机"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = Celestial_Fighter
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "attackers_root"
  L5_2 = L5_2[L6_2]
  L6_2 = "A10轰炸机"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = send_aircraft_attacker
    L1_3 = 1692272545
    L2_3 = -163714847
    L3_3 = A0_2
    L0_3(L1_3, L2_3, L3_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "attackers_root"
  L5_2 = L5_2[L6_2]
  L6_2 = "派货机"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = send_aircraft_attacker
    L1_3 = util
    L1_3 = L1_3.joaat
    L2_3 = "cargoplane"
    L1_3 = L1_3(L2_3)
    L2_3 = -163714847
    L3_3 = A0_2
    L0_3(L1_3, L2_3, L3_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = _ENV
  L5_2 = "create_garbage_entities"
  L6_2 = menu
  L6_2 = L6_2.list
  L7_2 = trolling
  L8_2 = "生成实体"
  L9_2 = {}
  L10_2 = ""
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
  L4_2[L5_2] = L6_2
  L4_2 = _ENV
  L5_2 = "attach_entity_obj"
  L6_2 = {}
  L7_2 = "-1268267712"
  L8_2 = "148511758"
  L6_2[1] = L7_2
  L6_2[2] = L8_2
  L4_2[L5_2] = L6_2
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "create_garbage_entities"
  L5_2 = L5_2[L6_2]
  L6_2 = "生成UFO"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3
    L0_3 = players
    L0_3 = L0_3.get_position
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = -1268267712
    L2_3 = 1
    L3_3 = 30
    L4_3 = 1
    for L5_3 = L2_3, L3_3, L4_3 do
      L6_3 = OBJECT
      L6_3 = L6_3.CREATE_OBJECT_NO_OFFSET
      L7_3 = L1_3
      L8_3 = L0_3.x
      L9_3 = math
      L9_3 = L9_3.random
      L10_3 = 0
      L11_3 = 5
      L9_3 = L9_3(L10_3, L11_3)
      L8_3 = L8_3 + L9_3
      L9_3 = L0_3.y
      L10_3 = math
      L10_3 = L10_3.random
      L11_3 = 0
      L12_3 = 5
      L10_3 = L10_3(L11_3, L12_3)
      L9_3 = L9_3 + L10_3
      L10_3 = L0_3.z
      L11_3 = math
      L11_3 = L11_3.random
      L12_3 = 0
      L13_3 = 5
      L11_3 = L11_3(L12_3, L13_3)
      L10_3 = L10_3 + L11_3
      L11_3 = true
      L12_3 = false
      L13_3 = false
      L6_3 = L6_3(L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3)
      L7_3 = FIRE
      L7_3 = L7_3.ADD_EXPLOSION
      L8_3 = L0_3.x
      L9_3 = math
      L9_3 = L9_3.random
      L10_3 = 0
      L11_3 = 5
      L9_3 = L9_3(L10_3, L11_3)
      L8_3 = L8_3 + L9_3
      L9_3 = L0_3.y
      L10_3 = math
      L10_3 = L10_3.random
      L11_3 = 0
      L12_3 = 5
      L10_3 = L10_3(L11_3, L12_3)
      L9_3 = L9_3 + L10_3
      L10_3 = L0_3.z
      L11_3 = math
      L11_3 = L11_3.random
      L12_3 = 0
      L13_3 = 5
      L11_3 = L11_3(L12_3, L13_3)
      L10_3 = L10_3 + L11_3
      L11_3 = 4
      L12_3 = 100
      L13_3 = true
      L14_3 = false
      L15_3 = 1
      L16_3 = false
      L7_3(L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3)
      L7_3 = util
      L7_3 = L7_3.yield
      L8_3 = 100
      L7_3(L8_3)
    end
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.textslider
  L5_2 = _ENV
  L6_2 = "create_garbage_entities"
  L5_2 = L5_2[L6_2]
  L6_2 = "冰淇凌盛宴"
  L7_2 = {}
  L8_2 = "在他们面前生成一个类似冰淇凌的实体"
  L9_2 = _ENV
  L10_2 = "ice_entity_name"
  L9_2 = L9_2[L10_2]
  function L10_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3
    L1_3 = ice_entity
    L1_3 = L1_3[A0_3]
    L2_3 = util
    L2_3 = L2_3.joaat
    L3_3 = L1_3
    L2_3 = L2_3(L3_3)
    L3_3 = ENTITY
    L3_3 = L3_3.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
    L4_3 = PLAYER
    L4_3 = L4_3.GET_PLAYER_PED
    L5_3 = A0_2
    L4_3 = L4_3(L5_3)
    L5_3 = 0
    L6_3 = 4
    L7_3 = 0
    L3_3 = L3_3(L4_3, L5_3, L6_3, L7_3)
    L4_3 = entities
    L4_3 = L4_3.create_object
    L5_3 = L2_3
    L6_3 = v3
    L7_3 = L3_3.x
    L8_3 = L3_3.y
    L9_3 = L3_3.z
    L9_3 = L9_3 - 1
    L6_3, L7_3, L8_3, L9_3 = L6_3(L7_3, L8_3, L9_3)
    L4_3(L5_3, L6_3, L7_3, L8_3, L9_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "create_garbage_entities"
  L5_2 = L5_2[L6_2]
  L6_2 = "生成竞技场"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3
    L0_3 = players
    L0_3 = L0_3.get_position
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = util
    L1_3 = L1_3.joaat
    L2_3 = "xs_terrain_set_dystopian_06"
    L1_3 = L1_3(L2_3)
    L2_3 = request_model
    L3_3 = L1_3
    L2_3(L3_3)
    L2_3 = OBJECT
    L2_3 = L2_3.CREATE_OBJECT_NO_OFFSET
    L3_3 = L1_3
    L4_3 = L0_3.x
    L5_3 = L0_3.y
    L6_3 = L0_3.z
    L6_3 = L6_3 - 4
    L7_3 = true
    L8_3 = false
    L9_3 = false
    L2_3 = L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3)
    L3_3 = ENTITY
    L3_3 = L3_3.FREEZE_ENTITY_POSITION
    L4_3 = L2_3
    L5_3 = true
    L3_3(L4_3, L5_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "create_garbage_entities"
  L5_2 = L5_2[L6_2]
  L6_2 = "生成黄土高坡"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3
    L0_3 = players
    L0_3 = L0_3.get_position
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = util
    L1_3 = L1_3.joaat
    L2_3 = "xs_terrain_dyst_ground_07"
    L1_3 = L1_3(L2_3)
    L2_3 = request_model
    L3_3 = L1_3
    L2_3(L3_3)
    L2_3 = OBJECT
    L2_3 = L2_3.CREATE_OBJECT_NO_OFFSET
    L3_3 = L1_3
    L4_3 = L0_3.x
    L5_3 = L0_3.y
    L6_3 = L0_3.z
    L6_3 = L6_3 - 36
    L7_3 = true
    L8_3 = false
    L9_3 = false
    L2_3 = L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3)
    L3_3 = util
    L3_3 = L3_3.joaat
    L4_3 = "apa_prop_flag_brazil"
    L3_3 = L3_3(L4_3)
    L4_3 = request_model
    L5_3 = L3_3
    L4_3(L5_3)
    L4_3 = OBJECT
    L4_3 = L4_3.CREATE_OBJECT_NO_OFFSET
    L5_3 = L3_3
    L6_3 = L0_3.x
    L7_3 = L0_3.y
    L8_3 = L0_3.z
    L9_3 = true
    L10_3 = false
    L11_3 = false
    L4_3 = L4_3(L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3)
    L5_3 = ENTITY
    L5_3 = L5_3.FREEZE_ENTITY_POSITION
    L6_3 = L2_3
    L7_3 = true
    L5_3(L6_3, L7_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.list_action
  L5_2 = _ENV
  L6_2 = "create_garbage_entities"
  L5_2 = L5_2[L6_2]
  L6_2 = "生成小实体"
  L7_2 = {}
  L8_2 = ""
  L9_2 = {}
  L10_2 = "斜坡"
  L11_2 = "路障"
  L12_2 = "风车"
  L13_2 = "卫星"
  L9_2[1] = L10_2
  L9_2[2] = L11_2
  L9_2[3] = L12_2
  L9_2[4] = L13_2
  function L10_2(A0_3)
    local L1_3, L2_3
    L1_3 = create_small_entities
    L2_3 = A0_3
    L1_3(L2_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "create_garbage_entities"
  L5_2 = L5_2[L6_2]
  L6_2 = "肿瘤"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED_SCRIPT_INDEX
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = spam_entity_on_player
    L2_3 = L0_3
    L3_3 = 148511758
    L1_3(L2_3, L3_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "create_garbage_entities"
  L5_2 = L5_2[L6_2]
  L6_2 = "肿瘤2"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED_SCRIPT_INDEX
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = spam_entity_on_player
    L2_3 = L0_3
    L3_3 = -26957549
    L1_3(L2_3, L3_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "create_garbage_entities"
  L5_2 = L5_2[L6_2]
  L6_2 = "肿瘤3"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED_SCRIPT_INDEX
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = spam_entity_on_player
    L2_3 = L0_3
    L3_3 = 1467574459
    L1_3(L2_3, L3_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "create_garbage_entities"
  L5_2 = L5_2[L6_2]
  L6_2 = "树木"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED_SCRIPT_INDEX
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = spam_entity_on_player
    L2_3 = L0_3
    L3_3 = -37176073
    L1_3(L2_3, L3_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "create_garbage_entities"
  L5_2 = L5_2[L6_2]
  L6_2 = "交通锥"
  L7_2 = {}
  L8_2 = "生成交通锥"
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED_SCRIPT_INDEX
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = spam_entity_on_player
    L2_3 = L0_3
    L3_3 = 3760607069
    L1_3(L2_3, L3_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "create_garbage_entities"
  L5_2 = L5_2[L6_2]
  L6_2 = "假鸡巴"
  L7_2 = {}
  L8_2 = "给爷冲"
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED_SCRIPT_INDEX
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = spam_entity_on_player
    L2_3 = L0_3
    L3_3 = 3872089630
    L1_3(L2_3, L3_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "create_garbage_entities"
  L5_2 = L5_2[L6_2]
  L6_2 = "热狗"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED_SCRIPT_INDEX
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = spam_entity_on_player
    L2_3 = L0_3
    L3_3 = 2565741261
    L1_3(L2_3, L3_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "create_garbage_entities"
  L5_2 = L5_2[L6_2]
  L6_2 = "热狗摊"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED_SCRIPT_INDEX
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = spam_entity_on_player
    L2_3 = L0_3
    L3_3 = 2713464726
    L1_3(L2_3, L3_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "create_garbage_entities"
  L5_2 = L5_2[L6_2]
  L6_2 = "摩天轮"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED_SCRIPT_INDEX
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = spam_entity_on_player
    L2_3 = L0_3
    L3_3 = 3291218330
    L1_3(L2_3, L3_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "create_garbage_entities"
  L5_2 = L5_2[L6_2]
  L6_2 = "过山车"
  L7_2 = {}
  L8_2 = "欢乐时光"
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED_SCRIPT_INDEX
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = spam_entity_on_player
    L2_3 = L0_3
    L3_3 = 3413442113
    L1_3(L2_3, L3_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "create_garbage_entities"
  L5_2 = L5_2[L6_2]
  L6_2 = "空中雷达"
  L7_2 = {}
  L8_2 = "让他们旋转"
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED_SCRIPT_INDEX
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = spam_entity_on_player
    L2_3 = L0_3
    L3_3 = 2306058344
    L1_3(L2_3, L3_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = _ENV
  L5_2 = "pteleportEntities"
  L6_2 = menu
  L6_2 = L6_2.list
  L7_2 = trolling
  L8_2 = "发送垃圾"
  L9_2 = {}
  L10_2 = "给他生成一推垃圾玩意"
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
  L4_2[L5_2] = L6_2
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "pteleportEntities"
  L5_2 = L5_2[L6_2]
  L6_2 = "NPC"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = TpAllPeds
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "pteleportEntities"
  L5_2 = L5_2[L6_2]
  L6_2 = "载具"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = TpAllVehs
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "pteleportEntities"
  L5_2 = L5_2[L6_2]
  L6_2 = "实体"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = TpAllObjects
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "pteleportEntities"
  L5_2 = L5_2[L6_2]
  L6_2 = "拾取物"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = TpAllPickups
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = trolling
  L6_2 = "送进监狱"
  L7_2 = {}
  L8_2 = "将此玩家传送到博林布鲁克监狱"
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3, L29_3, L30_3, L31_3, L32_3, L33_3, L34_3, L35_3, L36_3, L37_3, L38_3, L39_3
    L0_3 = util
    L0_3 = L0_3.trigger_script_event
    L1_3 = SYSTEM
    L1_3 = L1_3.SHIFT_LEFT
    L2_3 = A0_2
    L3_3 = 1
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = {}
    L3_3 = 1103127469
    L4_3 = PLAYER
    L4_3 = L4_3.PLAYER_ID
    L4_3 = L4_3()
    L5_3 = 1
    L6_3 = 32
    L7_3 = NETWORK
    L7_3 = L7_3.NETWORK_HASH_FROM_PLAYER_HANDLE
    L8_3 = A0_2
    L7_3 = L7_3(L8_3)
    L8_3 = 0
    L9_3 = 0
    L10_3 = 0
    L11_3 = 0
    L12_3 = 0
    L13_3 = 0
    L14_3 = 0
    L15_3 = 0
    L16_3 = 0
    L17_3 = 0
    L18_3 = 0
    L19_3 = 0
    L20_3 = 0
    L21_3 = 0
    L22_3 = 0
    L23_3 = 0
    L24_3 = 0
    L25_3 = 0
    L26_3 = 0
    L27_3 = 0
    L28_3 = 0
    L29_3 = 0
    L30_3 = 0
    L31_3 = 0
    L32_3 = 0
    L33_3 = 0
    L34_3 = 0
    L35_3 = 0
    L36_3 = 0
    L37_3 = 0
    L38_3 = 0
    L39_3 = 1
    L2_3[1] = L3_3
    L2_3[2] = L4_3
    L2_3[3] = L5_3
    L2_3[4] = L6_3
    L2_3[5] = L7_3
    L2_3[6] = L8_3
    L2_3[7] = L9_3
    L2_3[8] = L10_3
    L2_3[9] = L11_3
    L2_3[10] = L12_3
    L2_3[11] = L13_3
    L2_3[12] = L14_3
    L2_3[13] = L15_3
    L2_3[14] = L16_3
    L2_3[15] = L17_3
    L2_3[16] = L18_3
    L2_3[17] = L19_3
    L2_3[18] = L20_3
    L2_3[19] = L21_3
    L2_3[20] = L22_3
    L2_3[21] = L23_3
    L2_3[22] = L24_3
    L2_3[23] = L25_3
    L2_3[24] = L26_3
    L2_3[25] = L27_3
    L2_3[26] = L28_3
    L2_3[27] = L29_3
    L2_3[28] = L30_3
    L2_3[29] = L31_3
    L2_3[30] = L32_3
    L2_3[31] = L33_3
    L2_3[32] = L34_3
    L2_3[33] = L35_3
    L2_3[34] = L36_3
    L2_3[35] = L37_3
    L2_3[36] = L38_3
    L2_3[37] = L39_3
    L0_3(L1_3, L2_3)
    L0_3 = util
    L0_3 = L0_3.yield
    L1_3 = 2000
    L0_3(L1_3)
    L0_3 = PED
    L0_3 = L0_3.GET_VEHICLE_PED_IS_IN
    L1_3 = PLAYER
    L1_3 = L1_3.GET_PLAYER_PED_SCRIPT_INDEX
    L2_3 = A0_2
    L1_3 = L1_3(L2_3)
    L2_3 = true
    L0_3 = L0_3(L1_3, L2_3)
    if 0 ~= L0_3 then
      L1_3 = request_control
      L2_3 = L0_3
      L1_3(L2_3)
      L1_3 = ENTITY
      L1_3 = L1_3.SET_ENTITY_COORDS_NO_OFFSET
      L2_3 = L0_3
      L3_3 = 1628.5234
      L4_3 = 2570.5613
      L5_3 = 45.56485
      L6_3 = false
      L7_3 = false
      L8_3 = false
      L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3)
    end
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = trolling
  L6_2 = "喷射"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED_SCRIPT_INDEX
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = PED
    L1_3 = L1_3.GET_PED_BONE_INDEX
    L2_3 = L0_3
    L3_3 = 11816
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = request_ptfx_asset_peeloop
    L3_3 = "core_snow"
    L2_3(L3_3)
    L2_3 = GRAPHICS
    L2_3 = L2_3.USE_PARTICLE_FX_ASSET
    L3_3 = "core_snow"
    L2_3(L3_3)
    L2_3 = GRAPHICS
    L3_3 = "START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE"
    L2_3 = L2_3[L3_3]
    L3_3 = "cs_mich1_spade_dirt_throw"
    L4_3 = L0_3
    L5_3 = 0
    L6_3 = 0
    L7_3 = 0
    L8_3 = -90
    L9_3 = 0
    L10_3 = 0
    L11_3 = L1_3
    L12_3 = 2
    L13_3 = false
    L14_3 = false
    L15_3 = false
    L16_3 = 0
    L17_3 = 0
    L18_3 = 0
    L19_3 = 0
    L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = trolling
  L6_2 = "范围删除"
  L7_2 = {}
  L8_2 = "将玩家附近的模型删除"
  function L9_2()
    local L0_3, L1_3
    L0_3 = Scope_deletion
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = trolling
  L6_2 = "弹飞玩家"
  L7_2 = {}
  L8_2 = "也适用于载具"
  function L9_2()
    local L0_3, L1_3
    L0_3 = Bounce_Flying_Player
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = vehicle_car
  L6_2 = "载具沥青"
  L7_2 = {}
  L8_2 = "使玩家载具打滑"
  function L9_2()
    local L0_3, L1_3
    L0_3 = Vehicle_asphalt
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = vehicle_car
  L6_2 = "屠杀载具"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = massacre_vehicle
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = vehicle_car
  L6_2 = "漂移轮胎"
  L7_2 = {}
  L8_2 = "车辆漂移"
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED_SCRIPT_INDEX
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = PED
    L1_3 = L1_3.GET_VEHICLE_PED_IS_USING
    L2_3 = L0_3
    L1_3 = L1_3(L2_3)
    L2_3 = NETWORK
    L2_3 = L2_3.NETWORK_REQUEST_CONTROL_OF_ENTITY
    L3_3 = L1_3
    L2_3(L3_3)
    L2_3 = VEHICLE
    L2_3 = L2_3.SET_DRIFT_TYRES
    L3_3 = L1_3
    L4_3 = true
    L2_3(L3_3, L4_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = vehicle_car
  L6_2 = "劫持载具"
  L7_2 = {}
  L8_2 = "生成一个劫匪NPC,把他们从车里扔出来,锁上车,然后开走。(注意:在高ping的玩家身上也可能不一致)"
  function L9_2()
    local L0_3, L1_3
    L0_3 = hijacking_vehicles
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.list_action
  L5_2 = vehicle_car
  L6_2 = "载具附加"
  L7_2 = {}
  L8_2 = ""
  L9_2 = _ENV
  L10_2 = "veh_attach_options"
  L9_2 = L9_2[L10_2]
  function L10_2(A0_3)
    local L1_3, L2_3, L3_3
    L1_3 = vehicle_attach
    L2_3 = A0_3
    L3_3 = A0_2
    L1_3(L2_3, L3_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L4_2 = menu
  L4_2 = L4_2.toggle
  L5_2 = vehicle_car
  L6_2 = "儿童锁"
  L7_2 = {}
  L8_2 = ""
  function L9_2(A0_3)
    local L1_3, L2_3, L3_3
    L1_3 = Child_Lock
    L2_3 = A0_3
    L3_3 = A0_2
    L1_3(L2_3, L3_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = vehicle_car
  L6_2 = "敌对交通"
  L7_2 = {}
  L8_2 = "使附近NPC载具恶意撞击玩家载具"
  function L9_2()
    local L0_3, L1_3
    L0_3 = Hostile_traffic
    L0_3()
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = vehicle_car
  L6_2 = "变成恐龙"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = changemodel
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = vehicle_car
  L6_2 = "给载具套笼子"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = longzi_veh
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = vehicle_car
  L6_2 = "放置墙壁"
  L7_2 = {}
  L8_2 = "在玩家前面放置墙壁,半秒后删除"
  function L9_2()
    local L0_3, L1_3
    L0_3 = Place_wall
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.list_action
  L5_2 = vehicle_car
  L6_2 = "在车内生成NPC"
  L7_2 = {}
  L8_2 = "用附近的行人填充玩家的车"
  L9_2 = _ENV
  L10_2 = "full_with_options"
  L9_2 = L9_2[L10_2]
  function L10_2(A0_3, A1_3, A2_3)
    local L3_3, L4_3, L5_3, L6_3
    L3_3 = npcfillthecar
    L4_3 = A0_2
    L5_3 = A0_3
    L6_3 = A1_3
    L3_3(L4_3, L5_3, L6_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L4_2 = menu
  L4_2 = L4_2.list_action
  L5_2 = vehicle_car
  L6_2 = "拖车"
  L7_2 = {}
  L8_2 = "将他们的车拖走"
  L9_2 = {}
  L10_2 = "从前面"
  L11_2 = "从后面"
  L9_2[1] = L10_2
  L9_2[2] = L11_2
  function L10_2(A0_3, A1_3, A2_3)
    local L3_3, L4_3, L5_3, L6_3
    L3_3 = towcarpro
    L4_3 = A0_2
    L5_3 = A0_3
    L6_3 = A1_3
    L3_3(L4_3, L5_3, L6_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = vehicle_car
  L6_2 = "分离载具零件"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = detach_vehicle_parts
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.textslider
  L5_2 = vehicle_car
  L6_2 = "生成普通坡道"
  L7_2 = {}
  L8_2 = ""
  L9_2 = _ENV
  L10_2 = "ramps_names"
  L9_2 = L9_2[L10_2]
  function L10_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3
    L1_3 = ramps_hashes
    L1_3 = L1_3[A0_3]
    L2_3 = PED
    L2_3 = L2_3.GET_VEHICLE_PED_IS_IN
    L3_3 = PLAYER
    L3_3 = L3_3.GET_PLAYER_PED
    L4_3 = A0_2
    L3_3 = L3_3(L4_3)
    L4_3 = false
    L2_3 = L2_3(L3_3, L4_3)
    L3_3 = ENTITY
    L3_3 = L3_3.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
    L4_3 = L2_3
    L5_3 = 0
    L6_3 = 5
    L7_3 = 0
    L3_3 = L3_3(L4_3, L5_3, L6_3, L7_3)
    L4_3 = ENTITY
    L4_3 = L4_3.GET_ENTITY_HEADING
    L5_3 = L2_3
    L4_3 = L4_3(L5_3)
    L5_3 = create_object
    L6_3 = L1_3
    L7_3 = L3_3.x
    L8_3 = L3_3.y
    L9_3 = L3_3.z
    L9_3 = L9_3 - 0.8
    L5_3 = L5_3(L6_3, L7_3, L8_3, L9_3)
    L6_3 = ENTITY
    L6_3 = L6_3.SET_ENTITY_HEADING
    L7_3 = L5_3
    L8_3 = L4_3
    L6_3(L7_3, L8_3)
    L6_3 = ENTITY
    L6_3 = L6_3.FREEZE_ENTITY_POSITION
    L7_3 = L5_3
    L8_3 = true
    L6_3(L7_3, L8_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L4_2 = menu
  L4_2 = L4_2.textslider
  L5_2 = vehicle_car
  L6_2 = "生成竞技坡道"
  L7_2 = {}
  L8_2 = ""
  L9_2 = _ENV
  L10_2 = "ramps_names1"
  L9_2 = L9_2[L10_2]
  function L10_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3
    L1_3 = ramps_hashes
    L2_3 = A0_3 + 3
    L1_3 = L1_3[L2_3]
    L2_3 = PED
    L2_3 = L2_3.GET_VEHICLE_PED_IS_IN
    L3_3 = PLAYER
    L3_3 = L3_3.GET_PLAYER_PED
    L4_3 = A0_2
    L3_3 = L3_3(L4_3)
    L4_3 = false
    L2_3 = L2_3(L3_3, L4_3)
    L3_3 = ENTITY
    L3_3 = L3_3.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
    L4_3 = L2_3
    L5_3 = 0
    L6_3 = 30
    L7_3 = 0
    L3_3 = L3_3(L4_3, L5_3, L6_3, L7_3)
    L4_3 = ENTITY
    L4_3 = L4_3.GET_ENTITY_HEADING
    L5_3 = L2_3
    L4_3 = L4_3(L5_3)
    L5_3 = create_object
    L6_3 = L1_3
    L7_3 = L3_3.x
    L8_3 = L3_3.y
    L9_3 = L3_3.z
    L9_3 = L9_3 - 0.8
    L5_3 = L5_3(L6_3, L7_3, L8_3, L9_3)
    L6_3 = ENTITY
    L6_3 = L6_3.SET_ENTITY_HEADING
    L7_3 = L5_3
    L8_3 = L4_3 + 90
    L6_3(L7_3, L8_3)
    L6_3 = ENTITY
    L6_3 = L6_3.FREEZE_ENTITY_POSITION
    L7_3 = L5_3
    L8_3 = true
    L6_3(L7_3, L8_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = vehicle_car
  L6_2 = "载具爆炸"
  L7_2 = {}
  L8_2 = "爆炸目标进入的任何车辆"
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED_SCRIPT_INDEX
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = PED
    L1_3 = L1_3.GET_VEHICLE_PED_IS_IN
    L2_3 = L0_3
    L3_3 = false
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = PED
    L2_3 = L2_3.IS_PED_IN_VEHICLE
    L3_3 = L0_3
    L4_3 = L1_3
    L5_3 = false
    L2_3 = L2_3(L3_3, L4_3, L5_3)
    if L2_3 then
      L2_3 = ENTITY
      L2_3 = L2_3.IS_ENTITY_DEAD
      L3_3 = L0_3
      L4_3 = false
      L2_3 = L2_3(L3_3, L4_3)
      if false == L2_3 then
        L2_3 = players
        L2_3 = L2_3.get_position
        L3_3 = A0_2
        L2_3 = L2_3(L3_3)
        L3_3 = FIRE
        L3_3 = L3_3.ADD_EXPLOSION
        L4_3 = L2_3.x
        L5_3 = L2_3.y
        L6_3 = L2_3.z
        L7_3 = 0
        L8_3 = 100
        L9_3 = true
        L10_3 = false
        L11_3 = 1
        L12_3 = false
        L3_3(L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3)
      end
    end
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = _ENV
  L5_2 = "acrobatics"
  L6_2 = menu
  L6_2 = L6_2.list
  L7_2 = vehicle_car
  L8_2 = "车辆跳跃"
  L9_2 = {}
  L10_2 = ""
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
  L4_2[L5_2] = L6_2
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "acrobatics"
  L5_2 = L5_2[L6_2]
  L6_2 = "豚跳"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3
    L0_3 = get_vehicle_player_is_in
    L1_3 = pId
    L0_3 = L0_3(L1_3)
    L1_3 = ENTITY
    L1_3 = L1_3.DOES_ENTITY_EXIST
    L2_3 = L0_3
    L1_3 = L1_3(L2_3)
    if L1_3 then
      L1_3 = VEHICLE
      L1_3 = L1_3.IS_VEHICLE_ON_ALL_WHEELS
      L2_3 = L0_3
      L1_3 = L1_3(L2_3)
      if L1_3 then
        L1_3 = request_control
        L2_3 = L0_3
        L3_3 = 1000
        L1_3 = L1_3(L2_3, L3_3)
        if L1_3 then
          L1_3 = ENTITY
          L1_3 = L1_3.APPLY_FORCE_TO_ENTITY
          L2_3 = L0_3
          L3_3 = 1
          L4_3 = 0.0
          L5_3 = 0.0
          L6_3 = 10.0
          L7_3 = 0.0
          L8_3 = 0.0
          L9_3 = 0.0
          L10_3 = 1
          L11_3 = false
          L12_3 = true
          L13_3 = true
          L14_3 = true
          L15_3 = true
          L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3)
        end
      end
    end
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "acrobatics"
  L5_2 = L5_2[L6_2]
  L6_2 = "左侧空翻"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3
    L0_3 = get_vehicle_player_is_in
    L1_3 = pId
    L0_3 = L0_3(L1_3)
    L1_3 = ENTITY
    L1_3 = L1_3.DOES_ENTITY_EXIST
    L2_3 = L0_3
    L1_3 = L1_3(L2_3)
    if L1_3 then
      L1_3 = VEHICLE
      L1_3 = L1_3.IS_VEHICLE_ON_ALL_WHEELS
      L2_3 = L0_3
      L1_3 = L1_3(L2_3)
      if L1_3 then
        L1_3 = request_control
        L2_3 = L0_3
        L3_3 = 1000
        L1_3 = L1_3(L2_3, L3_3)
        if L1_3 then
          L1_3 = ENTITY
          L1_3 = L1_3.APPLY_FORCE_TO_ENTITY
          L2_3 = L0_3
          L3_3 = 1
          L4_3 = 0.0
          L5_3 = 0.0
          L6_3 = 10.71
          L7_3 = 5.0
          L8_3 = 0.0
          L9_3 = 0.0
          L10_3 = 1
          L11_3 = false
          L12_3 = true
          L13_3 = true
          L14_3 = true
          L15_3 = true
          L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3)
        end
      end
    end
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "acrobatics"
  L5_2 = L5_2[L6_2]
  L6_2 = "双左侧空翻"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3
    L0_3 = get_vehicle_player_is_in
    L1_3 = pId
    L0_3 = L0_3(L1_3)
    L1_3 = ENTITY
    L1_3 = L1_3.DOES_ENTITY_EXIST
    L2_3 = L0_3
    L1_3 = L1_3(L2_3)
    if L1_3 then
      L1_3 = VEHICLE
      L1_3 = L1_3.IS_VEHICLE_ON_ALL_WHEELS
      L2_3 = L0_3
      L1_3 = L1_3(L2_3)
      if L1_3 then
        L1_3 = request_control
        L2_3 = L0_3
        L3_3 = 1000
        L1_3 = L1_3(L2_3, L3_3)
        if L1_3 then
          L1_3 = ENTITY
          L1_3 = L1_3.APPLY_FORCE_TO_ENTITY
          L2_3 = L0_3
          L3_3 = 1
          L4_3 = 0.0
          L5_3 = 0.0
          L6_3 = 21.43
          L7_3 = 20.0
          L8_3 = 0.0
          L9_3 = 0.0
          L10_3 = 1
          L11_3 = false
          L12_3 = true
          L13_3 = true
          L14_3 = true
          L15_3 = true
          L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3)
        end
      end
    end
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "acrobatics"
  L5_2 = L5_2[L6_2]
  L6_2 = "右侧空翻"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3
    L0_3 = get_vehicle_player_is_in
    L1_3 = pId
    L0_3 = L0_3(L1_3)
    L1_3 = ENTITY
    L1_3 = L1_3.DOES_ENTITY_EXIST
    L2_3 = L0_3
    L1_3 = L1_3(L2_3)
    if L1_3 then
      L1_3 = VEHICLE
      L1_3 = L1_3.IS_VEHICLE_ON_ALL_WHEELS
      L2_3 = L0_3
      L1_3 = L1_3(L2_3)
      if L1_3 then
        L1_3 = request_control
        L2_3 = L0_3
        L3_3 = 1000
        L1_3 = L1_3(L2_3, L3_3)
        if L1_3 then
          L1_3 = ENTITY
          L1_3 = L1_3.APPLY_FORCE_TO_ENTITY
          L2_3 = L0_3
          L3_3 = 1
          L4_3 = 0.0
          L5_3 = 0.0
          L6_3 = 10.71
          L7_3 = -5.0
          L8_3 = 0.0
          L9_3 = 0.0
          L10_3 = 1
          L11_3 = false
          L12_3 = true
          L13_3 = true
          L14_3 = true
          L15_3 = true
          L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3)
        end
      end
    end
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = _ENV
  L5_2 = "set_license_plates"
  L6_2 = menu
  L6_2 = L6_2.list
  L7_2 = vehicle_car
  L8_2 = "设置车牌"
  L9_2 = {}
  L10_2 = ""
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
  L4_2[L5_2] = L6_2
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "set_license_plates"
  L5_2 = L5_2[L6_2]
  L6_2 = "将车牌设置为Sakura"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = PED
    L0_3 = L0_3.GET_VEHICLE_PED_IS_IN
    L1_3 = PLAYER
    L1_3 = L1_3.GET_PLAYER_PED_SCRIPT_INDEX
    L2_3 = A0_2
    L1_3 = L1_3(L2_3)
    L2_3 = true
    L0_3 = L0_3(L1_3, L2_3)
    if 0 ~= L0_3 then
      L1_3 = request_control
      L2_3 = L0_3
      L1_3(L2_3)
      L1_3 = VEHICLE
      L1_3 = L1_3.SET_VEHICLE_NUMBER_PLATE_TEXT
      L2_3 = L0_3
      L3_3 = "Sakura"
      L1_3(L2_3, L3_3)
    end
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "set_license_plates"
  L5_2 = L5_2[L6_2]
  L6_2 = "将车牌设置为i am SB"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = PED
    L0_3 = L0_3.GET_VEHICLE_PED_IS_IN
    L1_3 = PLAYER
    L1_3 = L1_3.GET_PLAYER_PED_SCRIPT_INDEX
    L2_3 = A0_2
    L1_3 = L1_3(L2_3)
    L2_3 = true
    L0_3 = L0_3(L1_3, L2_3)
    if 0 ~= L0_3 then
      L1_3 = request_control
      L2_3 = L0_3
      L1_3(L2_3)
      L1_3 = VEHICLE
      L1_3 = L1_3.SET_VEHICLE_NUMBER_PLATE_TEXT
      L2_3 = L0_3
      L3_3 = "i am SB"
      L1_3(L2_3, L3_3)
    end
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.toggle
  L5_2 = vehicle_car
  L6_2 = "手刹"
  L7_2 = {}
  L8_2 = ""
  function L9_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3
    L1_3 = PED
    L1_3 = L1_3.GET_VEHICLE_PED_IS_IN
    L2_3 = PLAYER
    L2_3 = L2_3.GET_PLAYER_PED_SCRIPT_INDEX
    L3_3 = A0_2
    L2_3 = L2_3(L3_3)
    L3_3 = true
    L1_3 = L1_3(L2_3, L3_3)
    if 0 ~= L1_3 then
      L2_3 = request_control
      L3_3 = L1_3
      L2_3(L3_3)
      L2_3 = VEHICLE
      L2_3 = L2_3.SET_VEHICLE_HANDBRAKE
      L3_3 = L1_3
      L4_3 = A0_3
      L2_3(L3_3, L4_3)
    end
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = vehicle_car
  L6_2 = "随机制动"
  L7_2 = {}
  L8_2 = ""
  function L9_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3
    L1_3 = PED
    L1_3 = L1_3.GET_VEHICLE_PED_IS_IN
    L2_3 = PLAYER
    L2_3 = L2_3.GET_PLAYER_PED_SCRIPT_INDEX
    L3_3 = A0_2
    L2_3 = L2_3(L3_3)
    L3_3 = true
    L1_3 = L1_3(L2_3, L3_3)
    if 0 ~= L1_3 then
      L2_3 = request_control
      L3_3 = L1_3
      L2_3(L3_3)
      L2_3 = VEHICLE
      L2_3 = L2_3.SET_VEHICLE_HANDBRAKE
      L3_3 = L1_3
      L4_3 = true
      L2_3(L3_3, L4_3)
      L2_3 = util
      L2_3 = L2_3.yield
      L3_3 = 1000
      L2_3(L3_3)
      L2_3 = request_control
      L3_3 = L1_3
      L2_3(L3_3)
      L2_3 = VEHICLE
      L2_3 = L2_3.SET_VEHICLE_HANDBRAKE
      L3_3 = L1_3
      L4_3 = false
      L2_3(L3_3, L4_3)
      L2_3 = util
      L2_3 = L2_3.yield
      L3_3 = math
      L3_3 = L3_3.random
      L4_3 = 3000
      L5_3 = 15000
      L3_3, L4_3, L5_3 = L3_3(L4_3, L5_3)
      L2_3(L3_3, L4_3, L5_3)
    end
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = vehicle_car
  L6_2 = "冻结"
  L7_2 = {}
  L8_2 = ""
  function L9_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3
    L1_3 = PED
    L1_3 = L1_3.GET_VEHICLE_PED_IS_IN
    L2_3 = PLAYER
    L2_3 = L2_3.GET_PLAYER_PED_SCRIPT_INDEX
    L3_3 = A0_2
    L2_3 = L2_3(L3_3)
    L3_3 = true
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = ENTITY
    L2_3 = L2_3.SET_ENTITY_MAX_SPEED
    L3_3 = L1_3
    L4_3 = 0
    L2_3(L3_3, L4_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = _ENV
  L5_2 = "player_toggle_loop"
  L4_2 = L4_2[L5_2]
  L5_2 = vehicle_car
  L6_2 = A0_2
  L7_2 = "移除载具无敌"
  L8_2 = {}
  L9_2 = "removevgm"
  L8_2[1] = L9_2
  L9_2 = ""
  function L10_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED_SCRIPT_INDEX
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = PED
    L1_3 = L1_3.IS_PED_IN_ANY_VEHICLE
    L2_3 = L0_3
    L3_3 = false
    L1_3 = L1_3(L2_3, L3_3)
    if L1_3 then
      L1_3 = PED
      L1_3 = L1_3.IS_PED_DEAD_OR_DYING
      L2_3 = L0_3
      L1_3 = L1_3(L2_3)
      if not L1_3 then
        L1_3 = PED
        L1_3 = L1_3.GET_VEHICLE_PED_IS_IN
        L2_3 = L0_3
        L3_3 = false
        L1_3 = L1_3(L2_3, L3_3)
        L2_3 = ENTITY
        L2_3 = L2_3.SET_ENTITY_CAN_BE_DAMAGED
        L3_3 = L1_3
        L4_3 = true
        L2_3(L3_3, L4_3)
        L2_3 = ENTITY
        L2_3 = L2_3.SET_ENTITY_INVINCIBLE
        L3_3 = L1_3
        L4_3 = false
        L2_3(L3_3, L4_3)
        L2_3 = ENTITY
        L2_3 = L2_3.SET_ENTITY_PROOFS
        L3_3 = L1_3
        L4_3 = false
        L5_3 = false
        L6_3 = false
        L7_3 = false
        L8_3 = false
        L9_3 = 0
        L10_3 = 0
        L11_3 = false
        L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3)
      end
    end
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = trolling
  L6_2 = "外星人爆炸"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3
    L0_3 = ENTITY
    L0_3 = L0_3.GET_ENTITY_COORDS
    L1_3 = PLAYER
    L1_3 = L1_3.GET_PLAYER_PED_SCRIPT_INDEX
    L2_3 = A0_2
    L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3 = L1_3(L2_3)
    L0_3 = L0_3(L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3)
    L1_3 = util
    L1_3 = L1_3.joaat
    L2_3 = "sum_prop_dufocore_01a"
    L1_3 = L1_3(L2_3)
    L2_3 = request_model
    L3_3 = L1_3
    L2_3(L3_3)
    L2_3 = menu
    L2_3 = L2_3.trigger_commands
    L3_3 = "freeze"
    L4_3 = players
    L4_3 = L4_3.get_name
    L5_3 = A0_2
    L4_3 = L4_3(L5_3)
    L5_3 = " on"
    L3_3 = L3_3 .. L4_3 .. L5_3
    L2_3(L3_3)
    L2_3 = L0_3.z
    L2_3 = L2_3 + 10
    L0_3.z = L2_3
    L2_3 = entities
    L2_3 = L2_3.create_object
    L3_3 = L1_3
    L4_3 = L0_3
    L2_3 = L2_3(L3_3, L4_3)
    L3_3 = util
    L3_3 = L3_3.yield
    L4_3 = 2000
    L3_3(L4_3)
    L3_3 = ENTITY
    L3_3 = L3_3.GET_ENTITY_COORDS
    L4_3 = PLAYER
    L4_3 = L4_3.GET_PLAYER_PED_SCRIPT_INDEX
    L5_3 = A0_2
    L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3 = L4_3(L5_3)
    L3_3 = L3_3(L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3)
    L4_3 = FIRE
    L4_3 = L4_3.ADD_EXPLOSION
    L5_3 = L3_3.x
    L6_3 = L3_3.y
    L7_3 = L3_3.z
    L8_3 = 1
    L9_3 = 100.0
    L10_3 = true
    L11_3 = false
    L12_3 = 3.0
    L13_3 = false
    L4_3(L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3)
    L4_3 = util
    L4_3 = L4_3.yield
    L5_3 = 1000
    L4_3(L5_3)
    L4_3 = delete_entity
    L5_3 = L2_3
    L4_3(L5_3)
    L4_3 = menu
    L4_3 = L4_3.trigger_commands
    L5_3 = "freeze"
    L6_3 = players
    L6_3 = L6_3.get_name
    L7_3 = A0_2
    L6_3 = L6_3(L7_3)
    L7_3 = " off"
    L5_3 = L5_3 .. L6_3 .. L7_3
    L4_3(L5_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = _ENV
  L5_2 = "kick_car"
  L6_2 = _ENV
  L7_2 = "menu"
  L6_2 = L6_2[L7_2]
  L6_2 = L6_2.list
  L7_2 = vehicle_car
  L8_2 = "踢出载具"
  L9_2 = {}
  L10_2 = ""
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
  L4_2[L5_2] = L6_2
  L4_2 = _ENV
  L5_2 = "menu"
  L4_2 = L4_2[L5_2]
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "kick_car"
  L5_2 = L5_2[L6_2]
  L6_2 = "踢出载具v1"
  L7_2 = {}
  L8_2 = "踢出当前载具所有人\n且当前载具不能再上"
  function L9_2()
    local L0_3, L1_3
    L0_3 = kickcar
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = _ENV
  L5_2 = "menu"
  L4_2 = L4_2[L5_2]
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "kick_car"
  L5_2 = L5_2[L6_2]
  L6_2 = "踢出载具v2"
  L7_2 = {}
  L8_2 = "从载具里踢出玩家"
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = menu
    L0_3 = L0_3.trigger_commands
    L1_3 = "vehkick"
    L2_3 = players
    L2_3 = L2_3.get_name
    L3_3 = A0_2
    L2_3 = L2_3(L3_3)
    L1_3 = L1_3 .. L2_3
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "kick_car"
  L5_2 = L5_2[L6_2]
  L6_2 = "踢出载具v3"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3
    L0_3 = TASK
    L0_3 = L0_3.CLEAR_PED_TASKS_IMMEDIATELY
    L1_3 = PLAYER
    L1_3 = L1_3.GET_PLAYER_PED
    L2_3 = A0_2
    L1_3, L2_3 = L1_3(L2_3)
    L0_3(L1_3, L2_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = vehicle_car
  L6_2 = "删除载具"
  L7_2 = {}
  L8_2 = "删除此玩家正在驾驶的载具"
  function L9_2()
    local L0_3, L1_3
    L0_3 = deleplayercar
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = vehicle_car
  L6_2 = "禁用载具"
  L7_2 = {}
  L8_2 = "当玩家打开车门时删除载具"
  function L9_2()
    local L0_3, L1_3
    L0_3 = disable_vehicle
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.toggle
  L5_2 = vehicle_car
  L6_2 = "禁用驾驶"
  L7_2 = {}
  L8_2 = ""
  function L9_2(A0_3)
    local L1_3, L2_3, L3_3
    L1_3 = disable_drive
    L2_3 = A0_3
    L3_3 = A0_2
    L1_3(L2_3, L3_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = vehicle_car
  L6_2 = "喇叭加速"
  L7_2 = {}
  L8_2 = "当他们按喇叭时,推动汽车前进."
  function L9_2()
    local L0_3, L1_3
    L0_3 = horn_boost
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = vehicle_car
  L6_2 = "喇叭跳跳车"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = car_jump
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = vehicle_car
  L6_2 = "修复载具"
  L7_2 = {}
  L8_2 = "给他们修车."
  function L9_2()
    local L0_3, L1_3
    L0_3 = repair_player_vehicle
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = vehicle_car
  L6_2 = "爆胎"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = menu
    L0_3 = L0_3.trigger_commands
    L1_3 = "poptires"
    L2_3 = players
    L2_3 = L2_3.get_name
    L3_3 = A0_2
    L2_3 = L2_3(L3_3)
    L1_3 = L1_3 .. L2_3
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = vehicle_car
  L6_2 = "移除车门"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = menu
    L0_3 = L0_3.trigger_commands
    L1_3 = "removedoors"
    L2_3 = players
    L2_3 = L2_3.get_name
    L3_3 = A0_2
    L2_3 = L2_3(L3_3)
    L1_3 = L1_3 .. L2_3
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = vehicle_car
  L6_2 = "摧毁螺旋桨"
  L7_2 = {}
  L8_2 = "使螺旋桨失效"
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = menu
    L0_3 = L0_3.trigger_commands
    L1_3 = "destroyprop"
    L2_3 = players
    L2_3 = L2_3.get_name
    L3_3 = A0_2
    L2_3 = L2_3(L3_3)
    L1_3 = L1_3 .. L2_3
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = vehicle_car
  L6_2 = "引擎控制"
  L7_2 = {}
  L8_2 = "如果他们的发动机打开,它就会关闭,反之亦然."
  function L9_2()
    local L0_3, L1_3
    L0_3 = toggle_player_vehicle_engine
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = vehicle_car
  L6_2 = "摧毁引擎"
  L7_2 = {}
  L8_2 = "让他们的引擎起火."
  function L9_2()
    local L0_3, L1_3
    L0_3 = break_player_vehicle_engine
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = vehicle_car
  L6_2 = "向前推进"
  L7_2 = {}
  L8_2 = "大力推动车辆前进."
  function L9_2()
    local L0_3, L1_3
    L0_3 = boost_player_vehicle_forward
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = vehicle_car
  L6_2 = "弹飞载具"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = launch_up_player_vehicle
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = vehicle_car
  L6_2 = "停止车辆"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = stop_player_vehicle
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = vehicle_car
  L6_2 = "倒置车辆"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = flip_player_vehicle
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = vehicle_car
  L6_2 = "车辆翻转180度"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = turn_player_vehicle
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = trolling
  L6_2 = "爆炸圈"
  L7_2 = {}
  L8_2 = "在他周围生成爆炸圈"
  function L9_2()
    local L0_3, L1_3
    L0_3 = explosion_range
    L0_3()
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = trolling
  L6_2 = "爆炸"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = menu
    L0_3 = L0_3.trigger_commands
    L1_3 = "explode"
    L2_3 = players
    L2_3 = L2_3.get_name
    L3_3 = A0_2
    L2_3 = L2_3(L3_3)
    L1_3 = L1_3 .. L2_3
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = trolling
  L6_2 = "循环爆炸"
  L7_2 = {}
  L8_2 = ""
  L7_2[1] = L8_2
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = menu
    L0_3 = L0_3.trigger_commands
    L1_3 = "explode"
    L2_3 = players
    L2_3 = L2_3.get_name
    L3_3 = A0_2
    L2_3 = L2_3(L3_3)
    L1_3 = L1_3 .. L2_3
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = trolling
  L6_2 = "无损伤爆炸"
  L7_2 = {}
  L8_2 = "tossplayers"
  L7_2[1] = L8_2
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
    L0_3 = ENTITY
    L0_3 = L0_3.GET_ENTITY_COORDS
    L1_3 = PLAYER
    L1_3 = L1_3.GET_PLAYER_PED
    L2_3 = A0_2
    L1_3 = L1_3(L2_3)
    L2_3 = true
    L0_3 = L0_3(L1_3, L2_3)
    L1_3 = FIRE
    L1_3 = L1_3.ADD_EXPLOSION
    L2_3 = L0_3.x
    L3_3 = L0_3.y
    L4_3 = L0_3.z
    L5_3 = 1
    L6_3 = 1
    L7_3 = true
    L8_3 = false
    L9_3 = 0
    L10_3 = true
    L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = trolling
  L6_2 = "原子弹轰炸"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = orbital
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = trolling
  L6_2 = "火箭雨"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = rain_rockets
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = trolling
  L6_2 = "子弹雨"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = rain_bullet
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = trolling
  L6_2 = "火箭撞击"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3
    L0_3 = players
    L0_3 = L0_3.get_position
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = PLAYER
    L1_3 = L1_3.GET_PLAYER_PED_SCRIPT_INDEX
    L2_3 = A0_2
    L1_3 = L1_3(L2_3)
    L2_3 = MISC
    L2_3 = L2_3.SHOOT_SINGLE_BULLET_BETWEEN_COORDS
    L3_3 = L0_3.x
    L4_3 = L0_3.y
    L5_3 = L0_3.z
    L5_3 = L5_3 + 10
    L6_3 = L0_3.x
    L7_3 = L0_3.y
    L8_3 = L0_3.z
    L9_3 = 1
    L10_3 = true
    L11_3 = -1312131151
    L12_3 = L1_3
    L13_3 = true
    L14_3 = false
    L15_3 = 50
    L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3)
    L2_3 = util
    L2_3 = L2_3.yield
    L3_3 = 1500
    L2_3(L3_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.textslider
  L5_2 = trolling
  L6_2 = "神风敢死队"
  L7_2 = {}
  L8_2 = ""
  L9_2 = {}
  L10_2 = "天煞"
  L11_2 = "天行巨兽"
  L12_2 = "古邦800"
  L9_2[1] = L10_2
  L9_2[2] = L11_2
  L9_2[3] = L12_2
  function L10_2(A0_3)
    local L1_3, L2_3, L3_3
    L1_3 = kamikaze_dare
    L2_3 = A0_3
    L3_3 = A0_2
    L1_3(L2_3, L3_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L4_2 = menu
  L4_2 = L4_2.textslider
  L5_2 = trolling
  L6_2 = "撞击玩家"
  L7_2 = {}
  L8_2 = ""
  L9_2 = {}
  L10_2 = "叛乱"
  L11_2 = "幻影楔形"
  L12_2 = "蝰蛇"
  L9_2[1] = L10_2
  L9_2[2] = L11_2
  L9_2[3] = L12_2
  function L10_2(A0_3)
    local L1_3, L2_3, L3_3
    L1_3 = Impact_player
    L2_3 = A0_3
    L3_3 = A0_2
    L1_3(L2_3, L3_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L4_2 = menu
  L4_2 = L4_2.toggle
  L5_2 = trolling
  L6_2 = "粒子轰炸"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = menu
    L0_3 = L0_3.trigger_commands
    L1_3 = "particlespam"
    L2_3 = players
    L2_3 = L2_3.get_name
    L3_3 = A0_2
    L2_3 = L2_3(L3_3)
    L1_3 = L1_3 .. L2_3
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = _ENV
  L5_2 = "mrplaym"
  L6_2 = menu
  L6_2 = L6_2.list
  L7_2 = trolling
  L8_2 = "在玩家身上下雨"
  L9_2 = {}
  L10_2 = ""
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
  L4_2[L5_2] = L6_2
  L4_2 = _ENV
  L5_2 = "mirloop"
  L6_2 = menu
  L6_2 = L6_2.toggle_loop
  L7_2 = _ENV
  L8_2 = "mrplaym"
  L7_2 = L7_2[L8_2]
  L8_2 = "类型:雪球"
  L9_2 = {}
  L10_2 = "启用下雨"
  function L11_2()
    local L0_3, L1_3
    L0_3 = Rain_on_players
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
  L4_2[L5_2] = L6_2
  L4_2 = menu
  L4_2 = L4_2.list_action
  L5_2 = _ENV
  L6_2 = "mrplaym"
  L5_2 = L5_2[L6_2]
  L6_2 = "类型"
  L7_2 = {}
  L8_2 = ""
  L7_2[1] = L8_2
  L8_2 = "更改在玩家身上下雨的类型"
  L9_2 = _ENV
  L10_2 = "Weaplist"
  L9_2 = L9_2[L10_2]
  function L10_2(A0_3, A1_3)
    local L2_3, L3_3, L4_3
    L2_3 = Rain_on_players_type
    L3_3 = A0_3
    L4_3 = A1_3
    L2_3(L3_3, L4_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = vehicle_car
  L6_2 = "传送到地下"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED_SCRIPT_INDEX
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = ENTITY
    L1_3 = L1_3.GET_ENTITY_COORDS
    L2_3 = L0_3
    L1_3 = L1_3(L2_3)
    L2_3 = PED
    L2_3 = L2_3.GET_VEHICLE_PED_IS_IN
    L3_3 = L0_3
    L4_3 = false
    L2_3 = L2_3(L3_3, L4_3)
    L3_3 = L1_3.z
    L3_3 = L3_3 - 100
    L1_3.z = L3_3
    L3_3 = PED
    L3_3 = L3_3.IS_PED_IN_ANY_VEHICLE
    L4_3 = L0_3
    L5_3 = false
    L3_3 = L3_3(L4_3, L5_3)
    if L3_3 then
      L3_3 = {}
      L4_3 = {}
      repeat
        L5_3 = util
        L5_3 = L5_3.get_ground_z
        L6_3 = L1_3.x
        L7_3 = L1_3.y
        L5_3, L6_3 = L5_3(L6_3, L7_3)
        L4_3.floorcoords = L6_3
        L3_3.success = L5_3
        L5_3 = util
        L5_3 = L5_3.yield
        L5_3()
        L5_3 = L3_3.success
      until L5_3
      L5_3 = request_control
      L6_3 = L2_3
      L5_3(L6_3)
      L5_3 = L4_3.floorcoords
      L5_3 = L5_3 - 50
      L4_3.floorcoords = L5_3
      L5_3 = ENTITY
      L5_3 = L5_3.SET_ENTITY_COORDS
      L6_3 = L2_3
      L7_3 = L1_3.x
      L8_3 = L1_3.y
      L9_3 = L4_3.floorcoords
      L10_3 = false
      L11_3 = false
      L12_3 = false
      L13_3 = false
      L5_3(L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3)
    else
      L3_3 = util
      L3_3 = L3_3.toast
      L4_3 = "玩家不在载具"
      L3_3(L4_3)
    end
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = vehicle_car
  L6_2 = "加速带"
  L7_2 = {}
  L8_2 = "在他们面前产生车辆加速带"
  function L9_2()
    local L0_3, L1_3
    L0_3 = jiasudian
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = vehicle_car
  L6_2 = "减速带"
  L7_2 = {}
  L8_2 = "在他们面前产生车辆减速带"
  function L9_2()
    local L0_3, L1_3
    L0_3 = jiansudai
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = _ENV
  L5_2 = "vehicle_impact"
  L6_2 = menu
  L6_2 = L6_2.list
  L7_2 = trolling
  L8_2 = "载具压倒"
  L9_2 = {}
  L10_2 = ""
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
  L4_2[L5_2] = L6_2
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "vehicle_impact"
  L5_2 = L5_2[L6_2]
  L6_2 = "小丑车"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED_SCRIPT_INDEX
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = ENTITY
    L1_3 = L1_3.GET_ENTITY_COORDS
    L2_3 = L0_3
    L3_3 = false
    L1_3 = L1_3(L2_3, L3_3)
    coords = L1_3
    L1_3 = coords
    L2_3 = coords
    L2_3 = L2_3.x
    L1_3.x = L2_3
    L1_3 = coords
    L2_3 = coords
    L2_3 = L2_3.y
    L1_3.y = L2_3
    L1_3 = coords
    L2_3 = coords
    L2_3 = L2_3.z
    L2_3 = L2_3 + 20.0
    L1_3.z = L2_3
    L1_3 = request_model
    L2_3 = util
    L2_3 = L2_3.joaat
    L3_3 = "speedo2"
    L2_3, L3_3, L4_3, L5_3, L6_3, L7_3 = L2_3(L3_3)
    L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3)
    L1_3 = entities
    L1_3 = L1_3.create_vehicle
    L2_3 = util
    L2_3 = L2_3.joaat
    L3_3 = "speedo2"
    L2_3 = L2_3(L3_3)
    L3_3 = coords
    L4_3 = 0.0
    L1_3 = L1_3(L2_3, L3_3, L4_3)
    L2_3 = ENTITY
    L2_3 = L2_3.GET_ENTITY_VELOCITY
    L3_3 = vel
    L2_3 = L2_3(L3_3)
    L3_3 = ENTITY
    L3_3 = L3_3.SET_ENTITY_VELOCITY
    L4_3 = L1_3
    L5_3 = L2_3.x
    L6_3 = L2_3.y
    L7_3 = -200.0
    L3_3(L4_3, L5_3, L6_3, L7_3)
    L3_3 = VEHICLE
    L3_3 = L3_3.SET_VEHICLE_DOORS_LOCKED
    L4_3 = L1_3
    L5_3 = 3
    L3_3(L4_3, L5_3)
    L3_3 = VEHICLE
    L4_3 = "SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS"
    L3_3 = L3_3[L4_3]
    L4_3 = L1_3
    L5_3 = true
    L3_3(L4_3, L5_3)
    L3_3 = util
    L3_3 = L3_3.yield
    L4_3 = 700
    L3_3(L4_3)
    L3_3 = delete_entity
    L4_3 = L1_3
    L3_3(L4_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "vehicle_impact"
  L5_2 = L5_2[L6_2]
  L6_2 = "隐形车"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED_SCRIPT_INDEX
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = ENTITY
    L1_3 = L1_3.GET_ENTITY_COORDS
    L2_3 = L0_3
    L3_3 = false
    L1_3 = L1_3(L2_3, L3_3)
    coords = L1_3
    L1_3 = coords
    L2_3 = coords
    L2_3 = L2_3.x
    L1_3.x = L2_3
    L1_3 = coords
    L2_3 = coords
    L2_3 = L2_3.y
    L1_3.y = L2_3
    L1_3 = coords
    L2_3 = coords
    L2_3 = L2_3.z
    L2_3 = L2_3 + 20.0
    L1_3.z = L2_3
    L1_3 = request_model
    L2_3 = 1917016601
    L1_3(L2_3)
    L1_3 = entities
    L1_3 = L1_3.create_vehicle
    L2_3 = 1917016601
    L3_3 = coords
    L4_3 = 0.0
    L1_3 = L1_3(L2_3, L3_3, L4_3)
    L2_3 = ENTITY
    L2_3 = L2_3.GET_ENTITY_VELOCITY
    L3_3 = vel
    L2_3 = L2_3(L3_3)
    L3_3 = ENTITY
    L3_3 = L3_3.SET_ENTITY_VELOCITY
    L4_3 = L1_3
    L5_3 = L2_3.x
    L6_3 = L2_3.y
    L7_3 = -200.0
    L3_3(L4_3, L5_3, L6_3, L7_3)
    L3_3 = VEHICLE
    L3_3 = L3_3.SET_VEHICLE_DOORS_LOCKED
    L4_3 = L1_3
    L5_3 = 3
    L3_3(L4_3, L5_3)
    L3_3 = ENTITY
    L3_3 = L3_3.SET_ENTITY_VISIBLE
    L4_3 = L1_3
    L5_3 = false
    L6_3 = 0
    L3_3(L4_3, L5_3, L6_3)
    L3_3 = VEHICLE
    L4_3 = "SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS"
    L3_3 = L3_3[L4_3]
    L4_3 = L1_3
    L5_3 = true
    L3_3(L4_3, L5_3)
    L3_3 = util
    L3_3 = L3_3.yield
    L4_3 = 2000
    L3_3(L4_3)
    L3_3 = delete_entity
    L4_3 = L1_3
    L3_3(L4_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "vehicle_impact"
  L5_2 = L5_2[L6_2]
  L6_2 = "直接压倒"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED_SCRIPT_INDEX
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = ENTITY
    L1_3 = L1_3.GET_ENTITY_COORDS
    L2_3 = L0_3
    L3_3 = false
    L1_3 = L1_3(L2_3, L3_3)
    coords = L1_3
    L1_3 = coords
    L2_3 = coords
    L2_3 = L2_3.x
    L1_3.x = L2_3
    L1_3 = coords
    L2_3 = coords
    L2_3 = L2_3.y
    L1_3.y = L2_3
    L1_3 = coords
    L2_3 = coords
    L2_3 = L2_3.z
    L2_3 = L2_3 + 20.0
    L1_3.z = L2_3
    L1_3 = request_model
    L2_3 = util
    L2_3 = L2_3.joaat
    L3_3 = "faggio2"
    L2_3, L3_3, L4_3, L5_3, L6_3, L7_3 = L2_3(L3_3)
    L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3)
    L1_3 = entities
    L1_3 = L1_3.create_vehicle
    L2_3 = util
    L2_3 = L2_3.joaat
    L3_3 = "faggio2"
    L2_3 = L2_3(L3_3)
    L3_3 = coords
    L4_3 = 0.0
    L1_3 = L1_3(L2_3, L3_3, L4_3)
    L2_3 = ENTITY
    L2_3 = L2_3.GET_ENTITY_VELOCITY
    L3_3 = vel
    L2_3 = L2_3(L3_3)
    L3_3 = ENTITY
    L3_3 = L3_3.SET_ENTITY_VELOCITY
    L4_3 = L1_3
    L5_3 = L2_3.x
    L6_3 = L2_3.y
    L7_3 = -200.0
    L3_3(L4_3, L5_3, L6_3, L7_3)
    L3_3 = VEHICLE
    L3_3 = L3_3.SET_VEHICLE_DOORS_LOCKED
    L4_3 = L1_3
    L5_3 = 3
    L3_3(L4_3, L5_3)
    L3_3 = ENTITY
    L3_3 = L3_3.SET_ENTITY_VISIBLE
    L4_3 = L1_3
    L5_3 = false
    L6_3 = 0
    L3_3(L4_3, L5_3, L6_3)
    L3_3 = VEHICLE
    L4_3 = "SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS"
    L3_3 = L3_3[L4_3]
    L4_3 = L1_3
    L5_3 = true
    L3_3(L4_3, L5_3)
    L3_3 = util
    L3_3 = L3_3.yield
    L4_3 = 2000
    L3_3(L4_3)
    L3_3 = delete_entity
    L4_3 = L1_3
    L3_3(L4_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "vehicle_impact"
  L5_2 = L5_2[L6_2]
  L6_2 = "大卡车"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED_SCRIPT_INDEX
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = ENTITY
    L1_3 = L1_3.GET_ENTITY_COORDS
    L2_3 = L0_3
    L3_3 = false
    L1_3 = L1_3(L2_3, L3_3)
    coords = L1_3
    L1_3 = coords
    L2_3 = coords
    L2_3 = L2_3.x
    L1_3.x = L2_3
    L1_3 = coords
    L2_3 = coords
    L2_3 = L2_3.y
    L1_3.y = L2_3
    L1_3 = coords
    L2_3 = coords
    L2_3 = L2_3.z
    L2_3 = L2_3 + 20.0
    L1_3.z = L2_3
    L1_3 = request_model
    L2_3 = 1917016601
    L1_3(L2_3)
    L1_3 = entities
    L1_3 = L1_3.create_vehicle
    L2_3 = 1917016601
    L3_3 = coords
    L4_3 = 0.0
    L1_3 = L1_3(L2_3, L3_3, L4_3)
    L2_3 = ENTITY
    L2_3 = L2_3.GET_ENTITY_VELOCITY
    L3_3 = vel
    L2_3 = L2_3(L3_3)
    L3_3 = ENTITY
    L3_3 = L3_3.SET_ENTITY_VELOCITY
    L4_3 = L1_3
    L5_3 = L2_3.x
    L6_3 = L2_3.y
    L7_3 = -100.0
    L3_3(L4_3, L5_3, L6_3, L7_3)
    L3_3 = VEHICLE
    L3_3 = L3_3.SET_VEHICLE_DOORS_LOCKED
    L4_3 = L1_3
    L5_3 = 3
    L3_3(L4_3, L5_3)
    L3_3 = VEHICLE
    L4_3 = "SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS"
    L3_3 = L3_3[L4_3]
    L4_3 = L1_3
    L5_3 = true
    L3_3(L4_3, L5_3)
    L3_3 = util
    L3_3 = L3_3.yield
    L4_3 = 700
    L3_3(L4_3)
    L3_3 = delete_entity
    L4_3 = L1_3
    L3_3(L4_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "vehicle_impact"
  L5_2 = L5_2[L6_2]
  L6_2 = "小绵羊"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED_SCRIPT_INDEX
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    L1_3 = ENTITY
    L1_3 = L1_3.GET_ENTITY_COORDS
    L2_3 = L0_3
    L3_3 = false
    L1_3 = L1_3(L2_3, L3_3)
    coords = L1_3
    L1_3 = coords
    L2_3 = coords
    L2_3 = L2_3.x
    L1_3.x = L2_3
    L1_3 = coords
    L2_3 = coords
    L2_3 = L2_3.y
    L1_3.y = L2_3
    L1_3 = coords
    L2_3 = coords
    L2_3 = L2_3.z
    L2_3 = L2_3 + 20.0
    L1_3.z = L2_3
    L1_3 = request_model
    L2_3 = util
    L2_3 = L2_3.joaat
    L3_3 = "faggio2"
    L2_3, L3_3, L4_3, L5_3, L6_3, L7_3 = L2_3(L3_3)
    L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3)
    L1_3 = entities
    L1_3 = L1_3.create_vehicle
    L2_3 = util
    L2_3 = L2_3.joaat
    L3_3 = "faggio2"
    L2_3 = L2_3(L3_3)
    L3_3 = coords
    L4_3 = 0.0
    L1_3 = L1_3(L2_3, L3_3, L4_3)
    L2_3 = ENTITY
    L2_3 = L2_3.GET_ENTITY_VELOCITY
    L3_3 = vel
    L2_3 = L2_3(L3_3)
    L3_3 = ENTITY
    L3_3 = L3_3.SET_ENTITY_VELOCITY
    L4_3 = L1_3
    L5_3 = L2_3.x
    L6_3 = L2_3.y
    L7_3 = -200.0
    L3_3(L4_3, L5_3, L6_3, L7_3)
    L3_3 = VEHICLE
    L3_3 = L3_3.SET_VEHICLE_DOORS_LOCKED
    L4_3 = L1_3
    L5_3 = 3
    L3_3(L4_3, L5_3)
    L3_3 = VEHICLE
    L4_3 = "SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS"
    L3_3 = L3_3[L4_3]
    L4_3 = L1_3
    L5_3 = true
    L3_3(L4_3, L5_3)
    L3_3 = util
    L3_3 = L3_3.yield
    L4_3 = 700
    L3_3(L4_3)
    L3_3 = delete_entity
    L4_3 = L1_3
    L3_3(L4_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = _ENV
  L5_2 = "player_veh_teleport"
  L6_2 = menu
  L6_2 = L6_2.list
  L7_2 = vehicle_car
  L8_2 = "传送载具"
  L9_2 = {}
  L10_2 = ""
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
  L4_2[L5_2] = L6_2
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "player_veh_teleport"
  L5_2 = L5_2[L6_2]
  L6_2 = "传送载具到我"
  L7_2 = {}
  L8_2 = "传送玩家最后一个载具\n或当前乘坐的载具"
  function L9_2()
    local L0_3, L1_3
    L0_3 = tpcartome
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "player_veh_teleport"
  L5_2 = L5_2[L6_2]
  L6_2 = "传送载具到导航点"
  L7_2 = {}
  L8_2 = "传送玩家最后一个载具\n或当前乘坐的载具"
  function L9_2()
    local L0_3, L1_3
    L0_3 = tocartopoint
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "player_veh_teleport"
  L5_2 = L5_2[L6_2]
  L6_2 = "传送载具到花园银行停机坪"
  L7_2 = {}
  L8_2 = "传送玩家最后一个载具\n或当前乘坐的载具"
  function L9_2()
    local L0_3, L1_3
    L0_3 = tptomaze
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "player_veh_teleport"
  L5_2 = L5_2[L6_2]
  L6_2 = "传送载具到深海底"
  L7_2 = {}
  L8_2 = "传送玩家最后一个载具\n或当前乘坐的载具"
  function L9_2()
    local L0_3, L1_3
    L0_3 = tptounderwater
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "player_veh_teleport"
  L5_2 = L5_2[L6_2]
  L6_2 = "传送载具到高空"
  L7_2 = {}
  L8_2 = "传送玩家最后一个载具\n或当前乘坐的载具"
  function L9_2()
    local L0_3, L1_3
    L0_3 = tptohighair
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "player_veh_teleport"
  L5_2 = L5_2[L6_2]
  L6_2 = "传送载具到洛圣都改车王"
  L7_2 = {}
  L8_2 = "传送玩家最后一个载具\n或当前乘坐的载具"
  function L9_2()
    local L0_3, L1_3
    L0_3 = tolsc
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "player_veh_teleport"
  L5_2 = L5_2[L6_2]
  L6_2 = "传送载具到监狱SCP-173单元"
  L7_2 = {}
  L8_2 = "传送玩家最后一个载具\n或当前乘坐的载具"
  function L9_2()
    local L0_3, L1_3
    L0_3 = tpscp
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = _ENV
  L6_2 = "player_veh_teleport"
  L5_2 = L5_2[L6_2]
  L6_2 = "传送载具到大牢房中"
  L7_2 = {}
  L8_2 = "传送玩家最后一个载具\n或当前乘坐的载具"
  function L9_2()
    local L0_3, L1_3
    L0_3 = tocell
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = vehicle_car
  L6_2 = "随机升级"
  L7_2 = {}
  L8_2 = "玩家必须有乘坐过的载具"
  function L9_2(A0_3)
    local L1_3, L2_3
    L1_3 = randomupdatcar
    L2_3 = A0_2
    L1_3(L2_3)
    L1_3 = util
    L1_3 = L1_3.yield
    L2_3 = 500
    L1_3(L2_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = vehicle_car
  L6_2 = "电磁脉冲炸弹"
  L7_2 = {}
  L8_2 = ""
  function L9_2(A0_3)
    local L1_3, L2_3
    L1_3 = caremp
    L2_3 = A0_2
    L1_3(L2_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = vehicle_car
  L6_2 = "快乐的小陀螺"
  L7_2 = {}
  L8_2 = ""
  function L9_2(A0_3)
    local L1_3, L2_3
    L1_3 = carspin
    L2_3 = A0_2
    L1_3(L2_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = _ENV
  L5_2 = "glitchVehCmd"
  L6_2 = menu
  L6_2 = L6_2.toggle
  L7_2 = vehicle_car
  L8_2 = "鬼畜载具"
  L9_2 = {}
  L10_2 = ""
  function L11_2(A0_3)
    local L1_3, L2_3, L3_3
    L1_3 = Demon_veh
    L2_3 = A0_2
    L3_3 = A0_3
    L1_3(L2_3, L3_3)
  end
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
  L4_2[L5_2] = L6_2
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = trolling
  L6_2 = "冻结玩家"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    if 0 ~= L0_3 then
      L0_3 = PLAYER
      L0_3 = L0_3.GET_PLAYER_PED_SCRIPT_INDEX
      L1_3 = A0_2
      L0_3 = L0_3(L1_3)
      L1_3 = TASK
      L1_3 = L1_3.CLEAR_PED_TASKS_IMMEDIATELY
      L2_3 = L0_3
      L1_3(L2_3)
    end
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = trolling
  L6_2 = "无限加载屏幕"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3, L29_3, L30_3, L31_3, L32_3, L33_3, L34_3, L35_3, L36_3, L37_3, L38_3, L39_3
    L0_3 = util
    L0_3 = L0_3.trigger_script_event
    L1_3 = SYSTEM
    L1_3 = L1_3.SHIFT_LEFT
    L2_3 = A0_2
    L3_3 = 1
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = {}
    L3_3 = 1103127469
    L4_3 = PLAYER
    L4_3 = L4_3.PLAYER_ID
    L4_3 = L4_3()
    L5_3 = 0
    L6_3 = 32
    L7_3 = NETWORK
    L7_3 = L7_3.NETWORK_HASH_FROM_PLAYER_HANDLE
    L8_3 = A0_2
    L7_3 = L7_3(L8_3)
    L8_3 = 0
    L9_3 = 0
    L10_3 = 0
    L11_3 = 0
    L12_3 = 0
    L13_3 = 0
    L14_3 = 0
    L15_3 = 0
    L16_3 = 0
    L17_3 = 0
    L18_3 = 0
    L19_3 = 0
    L20_3 = 0
    L21_3 = 0
    L22_3 = 0
    L23_3 = 0
    L24_3 = 0
    L25_3 = 0
    L26_3 = 0
    L27_3 = 0
    L28_3 = 0
    L29_3 = 0
    L30_3 = 0
    L31_3 = 0
    L32_3 = 0
    L33_3 = 0
    L34_3 = 0
    L35_3 = 0
    L36_3 = 0
    L37_3 = 0
    L38_3 = 0
    L39_3 = 0
    L2_3[1] = L3_3
    L2_3[2] = L4_3
    L2_3[3] = L5_3
    L2_3[4] = L6_3
    L2_3[5] = L7_3
    L2_3[6] = L8_3
    L2_3[7] = L9_3
    L2_3[8] = L10_3
    L2_3[9] = L11_3
    L2_3[10] = L12_3
    L2_3[11] = L13_3
    L2_3[12] = L14_3
    L2_3[13] = L15_3
    L2_3[14] = L16_3
    L2_3[15] = L17_3
    L2_3[16] = L18_3
    L2_3[17] = L19_3
    L2_3[18] = L20_3
    L2_3[19] = L21_3
    L2_3[20] = L22_3
    L2_3[21] = L23_3
    L2_3[22] = L24_3
    L2_3[23] = L25_3
    L2_3[24] = L26_3
    L2_3[25] = L27_3
    L2_3[26] = L28_3
    L2_3[27] = L29_3
    L2_3[28] = L30_3
    L2_3[29] = L31_3
    L2_3[30] = L32_3
    L2_3[31] = L33_3
    L2_3[32] = L34_3
    L2_3[33] = L35_3
    L2_3[34] = L36_3
    L2_3[35] = L37_3
    L2_3[36] = L38_3
    L2_3[37] = L39_3
    L0_3(L1_3, L2_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = trolling
  L6_2 = "推动玩家"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = Driving_Player
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = trolling
  L6_2 = "小行星攻击"
  L7_2 = {}
  L8_2 = "用小行星来攻击他"
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3
    L0_3 = 3751297495
    L1_3 = request_model
    L2_3 = L0_3
    L1_3(L2_3)
    L1_3 = players
    L1_3 = L1_3.get_position
    L2_3 = A0_2
    L1_3 = L1_3(L2_3)
    L2_3 = L1_3.z
    L2_3 = L2_3 + 15.0
    L1_3.z = L2_3
    L2_3 = entities
    L2_3 = L2_3.create_object
    L3_3 = 3751297495
    L4_3 = L1_3
    L2_3 = L2_3(L3_3, L4_3)
    L3_3 = ENTITY
    L3_3 = L3_3.SET_ENTITY_DYNAMIC
    L4_3 = L2_3
    L5_3 = true
    L3_3(L4_3, L5_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = trolling
  L6_2 = "向Ta发送垃圾邮件"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = menu
    L0_3 = L0_3.trigger_commands
    L1_3 = "commendfriendly"
    L2_3 = PLAYER
    L2_3 = L2_3.GET_PLAYER_NAME
    L3_3 = A0_2
    L2_3 = L2_3(L3_3)
    L1_3 = L1_3 .. L2_3
    L0_3(L1_3)
    L0_3 = util
    L0_3 = L0_3.yield
    L1_3 = 250
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = tp_player_trolling
  L6_2 = "发送到GTA5介绍界面"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3
    L0_3 = memory
    L0_3 = L0_3.read_int
    L1_3 = memory
    L1_3 = L1_3.script_global
    L2_3 = Global_Base
    L2_3 = L2_3.gpbd_fm_3
    L2_3 = L2_3 + 1
    L3_3 = A0_2
    L3_3 = L3_3 * 609
    L2_3 = L2_3 + L3_3
    L2_3 = L2_3 + 511
    L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3 = L1_3(L2_3)
    L0_3 = L0_3(L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3)
    L1_3 = util
    L1_3 = L1_3.trigger_script_event
    L2_3 = SYSTEM
    L2_3 = L2_3.SHIFT_LEFT
    L3_3 = A0_2
    L4_3 = 1
    L2_3 = L2_3(L3_3, L4_3)
    L3_3 = {}
    L4_3 = -366707054
    L5_3 = PLAYER
    L5_3 = L5_3.PLAYER_ID
    L5_3 = L5_3()
    L6_3 = 20
    L7_3 = 0
    L8_3 = 0
    L9_3 = 48
    L10_3 = 0
    L11_3 = 0
    L12_3 = 0
    L13_3 = 0
    L14_3 = 0
    L15_3 = 0
    L16_3 = 0
    L17_3 = 0
    L18_3 = 0
    L19_3 = 0
    L20_3 = 0
    L21_3 = 0
    L22_3 = -1
    L23_3 = 0
    L24_3 = 0
    L25_3 = 0
    L26_3 = 0
    L27_3 = 0
    L28_3 = L0_3
    L3_3[1] = L4_3
    L3_3[2] = L5_3
    L3_3[3] = L6_3
    L3_3[4] = L7_3
    L3_3[5] = L8_3
    L3_3[6] = L9_3
    L3_3[7] = L10_3
    L3_3[8] = L11_3
    L3_3[9] = L12_3
    L3_3[10] = L13_3
    L3_3[11] = L14_3
    L3_3[12] = L15_3
    L3_3[13] = L16_3
    L3_3[14] = L17_3
    L3_3[15] = L18_3
    L3_3[16] = L19_3
    L3_3[17] = L20_3
    L3_3[18] = L21_3
    L3_3[19] = L22_3
    L3_3[20] = L23_3
    L3_3[21] = L24_3
    L3_3[22] = L25_3
    L3_3[23] = L26_3
    L3_3[24] = L27_3
    L3_3[25] = L28_3
    L1_3(L2_3, L3_3)
    L1_3 = util
    L1_3 = L1_3.trigger_script_event
    L2_3 = SYSTEM
    L2_3 = L2_3.SHIFT_LEFT
    L3_3 = A0_2
    L4_3 = 1
    L2_3 = L2_3(L3_3, L4_3)
    L3_3 = {}
    L4_3 = 1757622014
    L5_3 = PLAYER
    L5_3 = L5_3.PLAYER_ID
    L5_3 = L5_3()
    L6_3 = 0
    L7_3 = 0
    L8_3 = 0
    L9_3 = 0
    L10_3 = 0
    L11_3 = 0
    L12_3 = 0
    L13_3 = 0
    L14_3 = 0
    L15_3 = 0
    L16_3 = 0
    L17_3 = 0
    L18_3 = 0
    L19_3 = 0
    L20_3 = 0
    L21_3 = 0
    L22_3 = 0
    L23_3 = 0
    L24_3 = 0
    L25_3 = 0
    L26_3 = 0
    L27_3 = 0
    L28_3 = 0
    L3_3[1] = L4_3
    L3_3[2] = L5_3
    L3_3[3] = L6_3
    L3_3[4] = L7_3
    L3_3[5] = L8_3
    L3_3[6] = L9_3
    L3_3[7] = L10_3
    L3_3[8] = L11_3
    L3_3[9] = L12_3
    L3_3[10] = L13_3
    L3_3[11] = L14_3
    L3_3[12] = L15_3
    L3_3[13] = L16_3
    L3_3[14] = L17_3
    L3_3[15] = L18_3
    L3_3[16] = L19_3
    L3_3[17] = L20_3
    L3_3[18] = L21_3
    L3_3[19] = L22_3
    L3_3[20] = L23_3
    L3_3[21] = L24_3
    L3_3[22] = L25_3
    L3_3[23] = L26_3
    L3_3[24] = L27_3
    L3_3[25] = L28_3
    L1_3(L2_3, L3_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = tp_player_trolling
  L6_2 = "发送到高尔夫"
  L7_2 = {}
  L8_2 = "派遣玩家去打高尔夫."
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3
    L0_3 = memory
    L0_3 = L0_3.read_int
    L1_3 = memory
    L1_3 = L1_3.script_global
    L2_3 = Global_Base
    L2_3 = L2_3.gpbd_fm_3
    L2_3 = L2_3 + 1
    L3_3 = A0_2
    L3_3 = L3_3 * 609
    L2_3 = L2_3 + L3_3
    L2_3 = L2_3 + 511
    L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3 = L1_3(L2_3)
    L0_3 = L0_3(L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3)
    L1_3 = util
    L1_3 = L1_3.trigger_script_event
    L2_3 = SYSTEM
    L2_3 = L2_3.SHIFT_LEFT
    L3_3 = A0_2
    L4_3 = 1
    L2_3 = L2_3(L3_3, L4_3)
    L3_3 = {}
    L4_3 = -366707054
    L5_3 = PLAYER
    L5_3 = L5_3.PLAYER_ID
    L5_3 = L5_3()
    L6_3 = 193
    L7_3 = 0
    L8_3 = 0
    L9_3 = 48
    L10_3 = 0
    L11_3 = 0
    L12_3 = 0
    L13_3 = 0
    L14_3 = 0
    L15_3 = 0
    L16_3 = 0
    L17_3 = 0
    L18_3 = 0
    L19_3 = 0
    L20_3 = 0
    L21_3 = 0
    L22_3 = -1
    L23_3 = 0
    L24_3 = 0
    L25_3 = 0
    L26_3 = 0
    L27_3 = 0
    L28_3 = L0_3
    L3_3[1] = L4_3
    L3_3[2] = L5_3
    L3_3[3] = L6_3
    L3_3[4] = L7_3
    L3_3[5] = L8_3
    L3_3[6] = L9_3
    L3_3[7] = L10_3
    L3_3[8] = L11_3
    L3_3[9] = L12_3
    L3_3[10] = L13_3
    L3_3[11] = L14_3
    L3_3[12] = L15_3
    L3_3[13] = L16_3
    L3_3[14] = L17_3
    L3_3[15] = L18_3
    L3_3[16] = L19_3
    L3_3[17] = L20_3
    L3_3[18] = L21_3
    L3_3[19] = L22_3
    L3_3[20] = L23_3
    L3_3[21] = L24_3
    L3_3[22] = L25_3
    L3_3[23] = L26_3
    L3_3[24] = L27_3
    L3_3[25] = L28_3
    L1_3(L2_3, L3_3)
    L1_3 = util
    L1_3 = L1_3.trigger_script_event
    L2_3 = SYSTEM
    L2_3 = L2_3.SHIFT_LEFT
    L3_3 = A0_2
    L4_3 = 1
    L2_3 = L2_3(L3_3, L4_3)
    L3_3 = {}
    L4_3 = 1757622014
    L5_3 = PLAYER
    L5_3 = L5_3.PLAYER_ID
    L5_3 = L5_3()
    L6_3 = 0
    L7_3 = 0
    L8_3 = 0
    L9_3 = 0
    L10_3 = 0
    L11_3 = 0
    L12_3 = 0
    L13_3 = 0
    L14_3 = 0
    L15_3 = 0
    L16_3 = 0
    L17_3 = 0
    L18_3 = 0
    L19_3 = 0
    L20_3 = 0
    L21_3 = 0
    L22_3 = 0
    L23_3 = 0
    L24_3 = 0
    L25_3 = 0
    L26_3 = 0
    L27_3 = 0
    L28_3 = 0
    L3_3[1] = L4_3
    L3_3[2] = L5_3
    L3_3[3] = L6_3
    L3_3[4] = L7_3
    L3_3[5] = L8_3
    L3_3[6] = L9_3
    L3_3[7] = L10_3
    L3_3[8] = L11_3
    L3_3[9] = L12_3
    L3_3[10] = L13_3
    L3_3[11] = L14_3
    L3_3[12] = L15_3
    L3_3[13] = L16_3
    L3_3[14] = L17_3
    L3_3[15] = L18_3
    L3_3[16] = L19_3
    L3_3[17] = L20_3
    L3_3[18] = L21_3
    L3_3[19] = L22_3
    L3_3[20] = L23_3
    L3_3[21] = L24_3
    L3_3[22] = L25_3
    L3_3[23] = L26_3
    L3_3[24] = L27_3
    L3_3[25] = L28_3
    L1_3(L2_3, L3_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = tp_player_trolling
  L6_2 = "发送到飞镖"
  L7_2 = {}
  L8_2 = "派遣玩家去玩飞镖"
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3
    L0_3 = memory
    L0_3 = L0_3.read_int
    L1_3 = memory
    L1_3 = L1_3.script_global
    L2_3 = Global_Base
    L2_3 = L2_3.gpbd_fm_3
    L2_3 = L2_3 + 1
    L3_3 = A0_2
    L3_3 = L3_3 * 609
    L2_3 = L2_3 + L3_3
    L2_3 = L2_3 + 511
    L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3 = L1_3(L2_3)
    L0_3 = L0_3(L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3)
    L1_3 = util
    L1_3 = L1_3.trigger_script_event
    L2_3 = SYSTEM
    L2_3 = L2_3.SHIFT_LEFT
    L3_3 = A0_2
    L4_3 = 1
    L2_3 = L2_3(L3_3, L4_3)
    L3_3 = {}
    L4_3 = -366707054
    L5_3 = PLAYER
    L5_3 = L5_3.PLAYER_ID
    L5_3 = L5_3()
    L6_3 = 192
    L7_3 = 0
    L8_3 = 0
    L9_3 = 48
    L10_3 = 0
    L11_3 = 0
    L12_3 = 0
    L13_3 = 0
    L14_3 = 0
    L15_3 = 0
    L16_3 = 0
    L17_3 = 0
    L18_3 = 0
    L19_3 = 0
    L20_3 = 0
    L21_3 = 0
    L22_3 = -1
    L23_3 = 0
    L24_3 = 0
    L25_3 = 0
    L26_3 = 0
    L27_3 = 0
    L28_3 = L0_3
    L3_3[1] = L4_3
    L3_3[2] = L5_3
    L3_3[3] = L6_3
    L3_3[4] = L7_3
    L3_3[5] = L8_3
    L3_3[6] = L9_3
    L3_3[7] = L10_3
    L3_3[8] = L11_3
    L3_3[9] = L12_3
    L3_3[10] = L13_3
    L3_3[11] = L14_3
    L3_3[12] = L15_3
    L3_3[13] = L16_3
    L3_3[14] = L17_3
    L3_3[15] = L18_3
    L3_3[16] = L19_3
    L3_3[17] = L20_3
    L3_3[18] = L21_3
    L3_3[19] = L22_3
    L3_3[20] = L23_3
    L3_3[21] = L24_3
    L3_3[22] = L25_3
    L3_3[23] = L26_3
    L3_3[24] = L27_3
    L3_3[25] = L28_3
    L1_3(L2_3, L3_3)
    L1_3 = util
    L1_3 = L1_3.trigger_script_event
    L2_3 = SYSTEM
    L2_3 = L2_3.SHIFT_LEFT
    L3_3 = A0_2
    L4_3 = 1
    L2_3 = L2_3(L3_3, L4_3)
    L3_3 = {}
    L4_3 = 1757622014
    L5_3 = PLAYER
    L5_3 = L5_3.PLAYER_ID
    L5_3 = L5_3()
    L6_3 = 0
    L7_3 = 0
    L8_3 = 0
    L9_3 = 0
    L10_3 = 0
    L11_3 = 0
    L12_3 = 0
    L13_3 = 0
    L14_3 = 0
    L15_3 = 0
    L16_3 = 0
    L17_3 = 0
    L18_3 = 0
    L19_3 = 0
    L20_3 = 0
    L21_3 = 0
    L22_3 = 0
    L23_3 = 0
    L24_3 = 0
    L25_3 = 0
    L26_3 = 0
    L27_3 = 0
    L28_3 = 0
    L3_3[1] = L4_3
    L3_3[2] = L5_3
    L3_3[3] = L6_3
    L3_3[4] = L7_3
    L3_3[5] = L8_3
    L3_3[6] = L9_3
    L3_3[7] = L10_3
    L3_3[8] = L11_3
    L3_3[9] = L12_3
    L3_3[10] = L13_3
    L3_3[11] = L14_3
    L3_3[12] = L15_3
    L3_3[13] = L16_3
    L3_3[14] = L17_3
    L3_3[15] = L18_3
    L3_3[16] = L19_3
    L3_3[17] = L20_3
    L3_3[18] = L21_3
    L3_3[19] = L22_3
    L3_3[20] = L23_3
    L3_3[21] = L24_3
    L3_3[22] = L25_3
    L3_3[23] = L26_3
    L3_3[24] = L27_3
    L3_3[25] = L28_3
    L1_3(L2_3, L3_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = tp_player_trolling
  L6_2 = "强制1V1"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3
    L0_3 = memory
    L0_3 = L0_3.read_int
    L1_3 = memory
    L1_3 = L1_3.script_global
    L2_3 = Global_Base
    L2_3 = L2_3.gpbd_fm_3
    L2_3 = L2_3 + 1
    L3_3 = A0_2
    L3_3 = L3_3 * 609
    L2_3 = L2_3 + L3_3
    L2_3 = L2_3 + 511
    L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3 = L1_3(L2_3)
    L0_3 = L0_3(L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3)
    L1_3 = util
    L1_3 = L1_3.trigger_script_event
    L2_3 = SYSTEM
    L2_3 = L2_3.SHIFT_LEFT
    L3_3 = A0_2
    L4_3 = 1
    L2_3 = L2_3(L3_3, L4_3)
    L3_3 = {}
    L4_3 = -366707054
    L5_3 = PLAYER
    L5_3 = L5_3.PLAYER_ID
    L5_3 = L5_3()
    L6_3 = 197
    L7_3 = 0
    L8_3 = 0
    L9_3 = 48
    L10_3 = 0
    L11_3 = 0
    L12_3 = 0
    L13_3 = 0
    L14_3 = 0
    L15_3 = 0
    L16_3 = 0
    L17_3 = 0
    L18_3 = 0
    L19_3 = 0
    L20_3 = 0
    L21_3 = 0
    L22_3 = -1
    L23_3 = 0
    L24_3 = 0
    L25_3 = 0
    L26_3 = 0
    L27_3 = 0
    L28_3 = L0_3
    L3_3[1] = L4_3
    L3_3[2] = L5_3
    L3_3[3] = L6_3
    L3_3[4] = L7_3
    L3_3[5] = L8_3
    L3_3[6] = L9_3
    L3_3[7] = L10_3
    L3_3[8] = L11_3
    L3_3[9] = L12_3
    L3_3[10] = L13_3
    L3_3[11] = L14_3
    L3_3[12] = L15_3
    L3_3[13] = L16_3
    L3_3[14] = L17_3
    L3_3[15] = L18_3
    L3_3[16] = L19_3
    L3_3[17] = L20_3
    L3_3[18] = L21_3
    L3_3[19] = L22_3
    L3_3[20] = L23_3
    L3_3[21] = L24_3
    L3_3[22] = L25_3
    L3_3[23] = L26_3
    L3_3[24] = L27_3
    L3_3[25] = L28_3
    L1_3(L2_3, L3_3)
    L1_3 = util
    L1_3 = L1_3.trigger_script_event
    L2_3 = SYSTEM
    L2_3 = L2_3.SHIFT_LEFT
    L3_3 = A0_2
    L4_3 = 1
    L2_3 = L2_3(L3_3, L4_3)
    L3_3 = {}
    L4_3 = 1757622014
    L5_3 = PLAYER
    L5_3 = L5_3.PLAYER_ID
    L5_3 = L5_3()
    L6_3 = 0
    L7_3 = 0
    L8_3 = 0
    L9_3 = 0
    L10_3 = 0
    L11_3 = 0
    L12_3 = 0
    L13_3 = 0
    L14_3 = 0
    L15_3 = 0
    L16_3 = 0
    L17_3 = 0
    L18_3 = 0
    L19_3 = 0
    L20_3 = 0
    L21_3 = 0
    L22_3 = 0
    L23_3 = 0
    L24_3 = 0
    L25_3 = 0
    L26_3 = 0
    L27_3 = 0
    L28_3 = 0
    L3_3[1] = L4_3
    L3_3[2] = L5_3
    L3_3[3] = L6_3
    L3_3[4] = L7_3
    L3_3[5] = L8_3
    L3_3[6] = L9_3
    L3_3[7] = L10_3
    L3_3[8] = L11_3
    L3_3[9] = L12_3
    L3_3[10] = L13_3
    L3_3[11] = L14_3
    L3_3[12] = L15_3
    L3_3[13] = L16_3
    L3_3[14] = L17_3
    L3_3[15] = L18_3
    L3_3[16] = L19_3
    L3_3[17] = L20_3
    L3_3[18] = L21_3
    L3_3[19] = L22_3
    L3_3[20] = L23_3
    L3_3[21] = L24_3
    L3_3[22] = L25_3
    L3_3[23] = L26_3
    L3_3[24] = L27_3
    L3_3[25] = L28_3
    L1_3(L2_3, L3_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = tp_player_trolling
  L6_2 = "强制传送到佩里科岛"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3
    L0_3 = util
    L0_3 = L0_3.trigger_script_event
    L1_3 = SYSTEM
    L1_3 = L1_3.SHIFT_LEFT
    L2_3 = A0_2
    L3_3 = 1
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = {}
    L3_3 = 373376135
    L4_3 = PLAYER
    L4_3 = L4_3.PLAYER_ID
    L4_3 = L4_3()
    L5_3 = 1
    L2_3[1] = L3_3
    L2_3[2] = L4_3
    L2_3[3] = L5_3
    L0_3(L1_3, L2_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = tp_player_trolling
  L6_2 = "驾驶摩托车"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3, L29_3, L30_3, L31_3, L32_3, L33_3, L34_3, L35_3, L36_3, L37_3, L38_3, L39_3
    L0_3 = util
    L0_3 = L0_3.trigger_script_event
    L1_3 = SYSTEM
    L1_3 = L1_3.SHIFT_LEFT
    L2_3 = A0_2
    L3_3 = 1
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = {}
    L3_3 = 1103127469
    L4_3 = PLAYER
    L4_3 = L4_3.PLAYER_ID
    L4_3 = L4_3()
    L5_3 = 1
    L6_3 = 32
    L7_3 = NETWORK
    L7_3 = L7_3.NETWORK_HASH_FROM_PLAYER_HANDLE
    L8_3 = A0_2
    L7_3 = L7_3(L8_3)
    L8_3 = 0
    L9_3 = 0
    L10_3 = 0
    L11_3 = 0
    L12_3 = 0
    L13_3 = 0
    L14_3 = 0
    L15_3 = 0
    L16_3 = 0
    L17_3 = 0
    L18_3 = 0
    L19_3 = 0
    L20_3 = 0
    L21_3 = 0
    L22_3 = 0
    L23_3 = 0
    L24_3 = 0
    L25_3 = 0
    L26_3 = 0
    L27_3 = 0
    L28_3 = 0
    L29_3 = 0
    L30_3 = 0
    L31_3 = 0
    L32_3 = 0
    L33_3 = 0
    L34_3 = 0
    L35_3 = 0
    L36_3 = 0
    L37_3 = 0
    L38_3 = 0
    L39_3 = 1
    L2_3[1] = L3_3
    L2_3[2] = L4_3
    L2_3[3] = L5_3
    L2_3[4] = L6_3
    L2_3[5] = L7_3
    L2_3[6] = L8_3
    L2_3[7] = L9_3
    L2_3[8] = L10_3
    L2_3[9] = L11_3
    L2_3[10] = L12_3
    L2_3[11] = L13_3
    L2_3[12] = L14_3
    L2_3[13] = L15_3
    L2_3[14] = L16_3
    L2_3[15] = L17_3
    L2_3[16] = L18_3
    L2_3[17] = L19_3
    L2_3[18] = L20_3
    L2_3[19] = L21_3
    L2_3[20] = L22_3
    L2_3[21] = L23_3
    L2_3[22] = L24_3
    L2_3[23] = L25_3
    L2_3[24] = L26_3
    L2_3[25] = L27_3
    L2_3[26] = L28_3
    L2_3[27] = L29_3
    L2_3[28] = L30_3
    L2_3[29] = L31_3
    L2_3[30] = L32_3
    L2_3[31] = L33_3
    L2_3[32] = L34_3
    L2_3[33] = L35_3
    L2_3[34] = L36_3
    L2_3[35] = L37_3
    L2_3[36] = L38_3
    L2_3[37] = L39_3
    L0_3(L1_3, L2_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = tp_player_trolling
  L6_2 = "强制进入自由模式任务"
  L7_2 = {}
  L8_2 = "强制玩家进入自由模式任务"
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = menu
    L0_3 = L0_3.trigger_commands
    L1_3 = "mission"
    L2_3 = players
    L2_3 = L2_3.get_name
    L3_3 = A0_2
    L2_3 = L2_3(L3_3)
    L1_3 = L1_3 .. L2_3
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = npc_trolling
  L6_2 = "猫猫炸弹"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = cat_bomb
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = npc_trolling
  L6_2 = "墨西哥乐队"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = dispatch_mariachi
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = npc_trolling
  L6_2 = "克隆玩家"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3
    L0_3 = PED
    L0_3 = L0_3.CLONE_PED
    L1_3 = PLAYER
    L1_3 = L1_3.GET_PLAYER_PED_SCRIPT_INDEX
    L2_3 = A0_2
    L1_3 = L1_3(L2_3)
    L2_3 = true
    L3_3 = false
    L4_3 = true
    L0_3 = L0_3(L1_3, L2_3, L3_3, L4_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.list_action
  L5_2 = npc_trolling
  L6_2 = "发送妓女"
  L7_2 = {}
  L8_2 = ""
  L9_2 = _ENV
  L10_2 = "custom_hooker_options"
  L9_2 = L9_2[L10_2]
  function L10_2(A0_3)
    local L1_3, L2_3
    L1_3 = send_hooker
    L2_3 = A0_3
    L1_3(L2_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = trolling
  L6_2 = "切碎"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = Finely_chopped
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = trolling
  L6_2 = "玩偶循环"
  L7_2 = {}
  L8_2 = "目标会保持"
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    if 0 ~= L0_3 then
      L0_3 = players
      L0_3 = L0_3.get_position
      L1_3 = A0_2
      L0_3 = L0_3(L1_3)
      L1_3 = L0_3.z
      L1_3 = L1_3 - 2.0
      L0_3.z = L1_3
      L1_3 = FIRE
      L1_3 = L1_3.ADD_EXPLOSION
      L2_3 = L0_3.x
      L3_3 = L0_3.y
      L4_3 = L0_3.z
      L5_3 = 11
      L6_3 = 1
      L7_3 = false
      L8_3 = true
      L9_3 = 0
      L10_3 = true
      L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3)
      L1_3 = util
      L1_3 = L1_3.yield
      L2_3 = 10
      L1_3(L2_3)
    end
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = trolling
  L6_2 = "烟雾掉帧"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3
    L0_3 = fumes
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = trolling
  L6_2 = "将附近载具吸到他身上"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    if 0 ~= L0_3 then
      L0_3 = players
      L0_3 = L0_3.get_position
      L1_3 = A0_2
      L0_3 = L0_3(L1_3)
      L1_3 = pairs
      L2_3 = entities
      L2_3 = L2_3.get_all_vehicles_as_handles
      L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3 = L2_3()
      L1_3, L2_3, L3_3, L4_3 = L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3)
      for L5_3, L6_3 in L1_3, L2_3, L3_3, L4_3 do
        L7_3 = PED
        L7_3 = L7_3.IS_PED_A_PLAYER
        L8_3 = VEHICLE
        L8_3 = L8_3.GET_PED_IN_VEHICLE_SEAT
        L9_3 = L6_3
        L10_3 = -1
        L11_3 = false
        L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3 = L8_3(L9_3, L10_3, L11_3)
        L7_3 = L7_3(L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3)
        if not L7_3 then
          L7_3 = ENTITY
          L7_3 = L7_3.GET_ENTITY_COORDS
          L8_3 = L6_3
          L7_3 = L7_3(L8_3)
          L8_3 = {}
          L9_3 = L0_3.x
          L10_3 = L7_3.x
          L9_3 = L9_3 - L10_3
          L9_3 = L9_3 * 2
          L8_3.x = L9_3
          L9_3 = L0_3.y
          L10_3 = L7_3.y
          L9_3 = L9_3 - L10_3
          L9_3 = L9_3 * 2
          L8_3.y = L9_3
          L9_3 = L0_3.z
          L10_3 = L7_3.z
          L9_3 = L9_3 - L10_3
          L9_3 = L9_3 * 2
          L8_3.z = L9_3
          L9_3 = ENTITY
          L9_3 = L9_3.APPLY_FORCE_TO_ENTITY
          L10_3 = L6_3
          L11_3 = 1
          L12_3 = L8_3.x
          L13_3 = L8_3.y
          L14_3 = L8_3.z
          L15_3 = 0
          L16_3 = 0
          L17_3 = 0
          L18_3 = 0
          L19_3 = false
          L20_3 = false
          L21_3 = true
          L22_3 = false
          L23_3 = false
          L9_3(L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3)
        end
      end
    end
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = _ENV
  L5_2 = "firepillar"
  L6_2 = menu
  L6_2 = L6_2.list
  L7_2 = trolling
  L8_2 = "火柱"
  L9_2 = {}
  L10_2 = ""
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
  L4_2[L5_2] = L6_2
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = _ENV
  L6_2 = "firepillar"
  L5_2 = L5_2[L6_2]
  L6_2 = "循环喷火v1"
  L7_2 = {}
  L8_2 = "flameloop"
  L7_2[1] = L8_2
  L8_2 = "火焰攻击！！！"
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    if 0 ~= L0_3 then
      L0_3 = PLAYER
      L0_3 = L0_3.GET_PLAYER_PED_SCRIPT_INDEX
      L1_3 = A0_2
      L0_3 = L0_3(L1_3)
      L1_3 = ENTITY
      L1_3 = L1_3.GET_ENTITY_COORDS
      L2_3 = L0_3
      L3_3 = false
      L1_3 = L1_3(L2_3, L3_3)
      L2_3 = FIRE
      L2_3 = L2_3.ADD_EXPLOSION
      L3_3 = L1_3.x
      L4_3 = L1_3.y
      L5_3 = L1_3.z
      L6_3 = 12
      L7_3 = 100.0
      L8_3 = true
      L9_3 = false
      L10_3 = 0.0
      L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3)
    end
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = _ENV
  L6_2 = "firepillar"
  L5_2 = L5_2[L6_2]
  L6_2 = "循环喷火v2"
  L7_2 = {}
  L8_2 = "火焰攻击！！！"
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    if 0 ~= L0_3 then
      L0_3 = players
      L0_3 = L0_3.get_position
      L1_3 = A0_2
      L0_3 = L0_3(L1_3)
      L1_3 = L0_3.z
      L1_3 = L1_3 - 2.0
      L0_3.z = L1_3
      L1_3 = FIRE
      L1_3 = L1_3.ADD_EXPLOSION
      L2_3 = L0_3.x
      L3_3 = L0_3.y
      L4_3 = L0_3.z
      L5_3 = 12
      L6_3 = 1
      L7_3 = true
      L8_3 = false
      L9_3 = 0
      L10_3 = false
      L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3)
      L1_3 = util
      L1_3 = L1_3.yield
      L2_3 = 25
      L1_3(L2_3)
    end
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = _ENV
  L5_2 = "waterpillar"
  L6_2 = menu
  L6_2 = L6_2.list
  L7_2 = trolling
  L8_2 = "水柱"
  L9_2 = {}
  L10_2 = ""
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
  L4_2[L5_2] = L6_2
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = _ENV
  L6_2 = "waterpillar"
  L5_2 = L5_2[L6_2]
  L6_2 = "循环喷水1"
  L7_2 = {}
  L8_2 = "水柱攻击！！！"
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    if 0 ~= L0_3 then
      L0_3 = players
      L0_3 = L0_3.get_position
      L1_3 = A0_2
      L0_3 = L0_3(L1_3)
      L1_3 = L0_3.z
      L1_3 = L1_3 - 2.0
      L0_3.z = L1_3
      L1_3 = FIRE
      L1_3 = L1_3.ADD_EXPLOSION
      L2_3 = L0_3.x
      L3_3 = L0_3.y
      L4_3 = L0_3.z
      L5_3 = 13
      L6_3 = 1
      L7_3 = true
      L8_3 = false
      L9_3 = 0
      L10_3 = false
      L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3)
      L1_3 = util
      L1_3 = L1_3.yield
      L2_3 = 25
      L1_3(L2_3)
    end
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = _ENV
  L6_2 = "waterpillar"
  L5_2 = L5_2[L6_2]
  L6_2 = "循环喷水2"
  L7_2 = {}
  L8_2 = "waterloop"
  L7_2[1] = L8_2
  L8_2 = "水柱攻击！！！"
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    if 0 ~= L0_3 then
      L0_3 = PLAYER
      L0_3 = L0_3.GET_PLAYER_PED_SCRIPT_INDEX
      L1_3 = A0_2
      L0_3 = L0_3(L1_3)
      L1_3 = ENTITY
      L1_3 = L1_3.GET_ENTITY_COORDS
      L2_3 = L0_3
      L3_3 = false
      L1_3 = L1_3(L2_3, L3_3)
      L2_3 = FIRE
      L2_3 = L2_3.ADD_EXPLOSION
      L3_3 = L1_3.x
      L4_3 = L1_3.y
      L5_3 = L1_3.z
      L6_3 = 13
      L7_3 = 100.0
      L8_3 = true
      L9_3 = false
      L10_3 = 0.0
      L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3)
    end
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = trolling
  L6_2 = "追踪"
  L7_2 = {}
  L8_2 = "地下有痕迹"
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    if 0 ~= L0_3 then
      L0_3 = players
      L0_3 = L0_3.get_position
      L1_3 = A0_2
      L0_3 = L0_3(L1_3)
      L1_3 = L0_3.z
      L1_3 = L1_3 + 1.5
      L0_3.z = L1_3
      L1_3 = FIRE
      L1_3 = L1_3.ADD_EXPLOSION
      L2_3 = L0_3.x
      L3_3 = L0_3.y
      L4_3 = L0_3.z
      L5_3 = 35
      L6_3 = 0
      L7_3 = false
      L8_3 = false
      L9_3 = 0
      L10_3 = false
      L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3)
      L1_3 = util
      L1_3 = L1_3.yield
      L2_3 = 65
      L1_3(L2_3)
    end
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = trolling
  L6_2 = "让他走路带火"
  L7_2 = {}
  L8_2 = "跑起来吧！！!"
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    if 0 ~= L0_3 then
      L0_3 = players
      L0_3 = L0_3.get_position
      L1_3 = A0_2
      L0_3 = L0_3(L1_3)
      L1_3 = FIRE
      L1_3 = L1_3.ADD_EXPLOSION
      L2_3 = L0_3.x
      L3_3 = L0_3.y
      L4_3 = L0_3.z
      L5_3 = 38
      L6_3 = 0
      L7_3 = false
      L8_3 = false
      L9_3 = 0
      L10_3 = false
      L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3)
      L1_3 = util
      L1_3 = L1_3.yield
      L2_3 = 65
      L1_3(L2_3)
    end
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.toggle_loop
  L5_2 = trolling
  L6_2 = "在他头上浇水"
  L7_2 = {}
  L8_2 = ""
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    if 0 ~= L0_3 then
      L0_3 = players
      L0_3 = L0_3.get_position
      L1_3 = A0_2
      L0_3 = L0_3(L1_3)
      L1_3 = L0_3.z
      L1_3 = L1_3 + 1
      L0_3.z = L1_3
      L1_3 = util
      L1_3 = L1_3.yield
      L2_3 = 65
      L1_3(L2_3)
      L1_3 = FIRE
      L1_3 = L1_3.ADD_EXPLOSION
      L2_3 = L0_3.x
      L3_3 = L0_3.y
      L4_3 = L0_3.z
      L5_3 = 79
      L6_3 = 0
      L7_3 = false
      L8_3 = false
      L9_3 = 0
      L10_3 = false
      L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3)
    end
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.action
  L5_2 = trolling
  L6_2 = "发射玩家"
  L7_2 = {}
  L8_2 = "launch"
  L7_2[1] = L8_2
  L8_2 = "适用于大多数菜单."
  function L9_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3
    L0_3 = util
    L0_3 = L0_3.joaat
    L1_3 = "boxville3"
    L0_3 = L0_3(L1_3)
    L1_3 = PLAYER
    L1_3 = L1_3.GET_PLAYER_PED_SCRIPT_INDEX
    L2_3 = A0_2
    L1_3 = L1_3(L2_3)
    L2_3 = ENTITY
    L2_3 = L2_3.GET_ENTITY_COORDS
    L3_3 = L1_3
    L2_3 = L2_3(L3_3)
    L3_3 = request_model
    L4_3 = L0_3
    L3_3(L4_3)
    L3_3 = PED
    L3_3 = L3_3.IS_PED_IN_ANY_VEHICLE
    L4_3 = L1_3
    L5_3 = false
    L3_3 = L3_3(L4_3, L5_3)
    if L3_3 then
      L3_3 = util
      L3_3 = L3_3.toast
      L4_3 = players
      L4_3 = L4_3.get_name
      L5_3 = A0_2
      L4_3 = L4_3(L5_3)
      L5_3 = " 在载具中. :/"
      L4_3 = L4_3 .. L5_3
      L3_3(L4_3)
      return
    end
    L3_3 = entities
    L3_3 = L3_3.create_vehicle
    L4_3 = L0_3
    L5_3 = ENTITY
    L5_3 = L5_3.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
    L6_3 = L1_3
    L7_3 = 0.0
    L8_3 = 2.0
    L9_3 = 0.0
    L5_3 = L5_3(L6_3, L7_3, L8_3, L9_3)
    L6_3 = ENTITY
    L6_3 = L6_3.GET_ENTITY_HEADING
    L7_3 = L1_3
    L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3 = L6_3(L7_3)
    L3_3 = L3_3(L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3)
    boxville = L3_3
    L3_3 = ENTITY
    L3_3 = L3_3.SET_ENTITY_VISIBLE
    L4_3 = boxville
    L5_3 = false
    L3_3(L4_3, L5_3)
    L3_3 = util
    L3_3 = L3_3.yield
    L4_3 = 250
    L3_3(L4_3)
    repeat
      L3_3 = v3
      L3_3 = L3_3.distance
      L4_3 = players
      L4_3 = L4_3.get_position
      L5_3 = A0_2
      L4_3 = L4_3(L5_3)
      L5_3 = ENTITY
      L5_3 = L5_3.GET_ENTITY_COORDS
      L6_3 = boxville
      L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3 = L5_3(L6_3)
      L3_3 = L3_3(L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3)
      if L3_3 < 10.0 then
        L3_3 = boxville
        if 0 ~= L3_3 then
          L3_3 = ENTITY
          L3_3 = L3_3.DOES_ENTITY_EXIST
          L4_3 = boxville
          L3_3 = L3_3(L4_3)
          if L3_3 then
            L3_3 = ENTITY
            L3_3 = L3_3.APPLY_FORCE_TO_ENTITY
            L4_3 = boxville
            L5_3 = 1
            L6_3 = 0.0
            L7_3 = 0.0
            L8_3 = 25.0
            L9_3 = 0.0
            L10_3 = 0.0
            L11_3 = 0.0
            L12_3 = 0
            L13_3 = 1
            L14_3 = 1
            L15_3 = 1
            L16_3 = 0
            L17_3 = 1
            L3_3(L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3)
          end
        end
        L3_3 = util
        L3_3 = L3_3.yield
        L3_3()
      else
        L3_3 = delete_entity
        L4_3 = boxville
        L3_3(L4_3)
      end
      L3_3 = util
      L3_3 = L3_3.yield
      L3_3()
      L3_3 = ENTITY
      L3_3 = L3_3.GET_ENTITY_COORDS
      L4_3 = L1_3
      L3_3 = L3_3(L4_3)
      L2_3 = L3_3
      L3_3 = L2_3.z
      L4_3 = 10000.0
    until L3_3 > L4_3
    L3_3 = util
    L3_3 = L3_3.yield
    L4_3 = 100
    L3_3(L4_3)
    L3_3 = boxville
    if 0 ~= L3_3 then
      L3_3 = ENTITY
      L3_3 = L3_3.DOES_ENTITY_EXIST
      L4_3 = boxville
      L3_3 = L3_3(L4_3)
      if L3_3 then
        L3_3 = delete_entity
        L4_3 = boxville
        L3_3(L4_3)
      end
    end
  end
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L4_2 = menu
  L4_2 = L4_2.list
  L5_2 = trolling
  L6_2 = "声音恶搞"
  L7_2 = {}
  L8_2 = ""
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  L5_2 = menu
  L5_2 = L5_2.toggle_loop
  L6_2 = L4_2
  L7_2 = "让他听到循环爆炸死亡声音"
  L8_2 = {}
  L9_2 = "吵死了"
  function L10_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    if 0 ~= L0_3 then
      L0_3 = players
      L0_3 = L0_3.get_position
      L1_3 = A0_2
      L0_3 = L0_3(L1_3)
      L1_3 = AUDIO
      L1_3 = L1_3.PLAY_SOUND_FROM_COORD
      L2_3 = -1
      L3_3 = "BED"
      L4_3 = L0_3.x
      L5_3 = L0_3.y
      L6_3 = L0_3.z
      L7_3 = "WASTEDSOUNDS"
      L8_3 = true
      L9_3 = 5
      L10_3 = false
      L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3)
      L1_3 = AUDIO
      L1_3 = L1_3.PLAY_SOUND_FROM_COORD
      L2_3 = -1
      L3_3 = "Crash"
      L4_3 = L0_3.x
      L5_3 = L0_3.y
      L6_3 = L0_3.z
      L7_3 = "DLC_HEIST_HACKING_SNAKE_SOUNDS"
      L8_3 = true
      L9_3 = 5
      L10_3 = false
      L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3)
      L1_3 = AUDIO
      L1_3 = L1_3.PLAY_SOUND_FROM_COORD
      L2_3 = -1
      L3_3 = "BASE_JUMP_PASSED"
      L4_3 = L0_3.x
      L5_3 = L0_3.y
      L6_3 = L0_3.z
      L7_3 = "HUD_AWARDS"
      L8_3 = true
      L9_3 = 5
      L10_3 = false
      L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3)
      L1_3 = util
      L1_3 = L1_3.yield
      L2_3 = 20
      L1_3(L2_3)
    end
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = menu
  L5_2 = L5_2.toggle_loop
  L6_2 = L4_2
  L7_2 = "循环死亡的声音"
  L8_2 = {}
  L9_2 = ""
  function L10_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    if 0 ~= L0_3 then
      L0_3 = players
      L0_3 = L0_3.get_position
      L1_3 = A0_2
      L0_3 = L0_3(L1_3)
      L1_3 = AUDIO
      L1_3 = L1_3.PLAY_SOUND_FROM_COORD
      L2_3 = 1
      L3_3 = "BED"
      L4_3 = L0_3.x
      L5_3 = L0_3.y
      L6_3 = L0_3.z
      L7_3 = "WASTEDSOUNDS"
      L8_3 = true
      L9_3 = 5
      L10_3 = false
      L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3)
      L1_3 = util
      L1_3 = L1_3.yield
      L2_3 = 5800
      L1_3(L2_3)
    end
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = menu
  L5_2 = L5_2.toggle_loop
  L6_2 = L4_2
  L7_2 = "循环游艇声音"
  L8_2 = {}
  L9_2 = ""
  function L10_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    if 0 ~= L0_3 then
      L0_3 = players
      L0_3 = L0_3.get_position
      L1_3 = A0_2
      L0_3 = L0_3(L1_3)
      L1_3 = AUDIO
      L1_3 = L1_3.PLAY_SOUND_FROM_COORD
      L2_3 = -1
      L3_3 = "Horn"
      L4_3 = L0_3.x
      L5_3 = L0_3.y
      L6_3 = L0_3.z
      L7_3 = "DLC_Apt_Yacht_Ambient_Soundset"
      L8_3 = true
      L9_3 = 5
      L10_3 = false
      L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3)
      L1_3 = util
      L1_3 = L1_3.yield
      L2_3 = 3000
      L1_3(L2_3)
    end
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = menu
  L5_2 = L5_2.toggle_loop
  L6_2 = L4_2
  L7_2 = "嗡嗡声"
  L8_2 = {}
  L9_2 = ""
  function L10_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    if 0 ~= L0_3 then
      L0_3 = players
      L0_3 = L0_3.get_position
      L1_3 = A0_2
      L0_3 = L0_3(L1_3)
      L1_3 = AUDIO
      L1_3 = L1_3.PLAY_SOUND_FROM_COORD
      L2_3 = -1
      L3_3 = "Crash"
      L4_3 = L0_3.x
      L5_3 = L0_3.y
      L6_3 = L0_3.z
      L7_3 = "DLC_HEIST_HACKING_SNAKE_SOUNDS"
      L8_3 = true
      L9_3 = 5
      L10_3 = false
      L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3)
      L1_3 = util
      L1_3 = L1_3.yield
      L2_3 = 1700
      L1_3(L2_3)
    end
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = menu
  L5_2 = L5_2.toggle_loop
  L6_2 = L4_2
  L7_2 = "任务成功声音"
  L8_2 = {}
  L9_2 = ""
  function L10_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
    L0_3 = PLAYER
    L0_3 = L0_3.GET_PLAYER_PED
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    if 0 ~= L0_3 then
      L0_3 = players
      L0_3 = L0_3.get_position
      L1_3 = A0_2
      L0_3 = L0_3(L1_3)
      L1_3 = AUDIO
      L1_3 = L1_3.PLAY_SOUND_FROM_COORD
      L2_3 = 1
      L3_3 = "BASE_JUMP_PASSED"
      L4_3 = L0_3.x
      L5_3 = L0_3.y
      L6_3 = L0_3.z
      L7_3 = "HUD_AWARDS"
      L8_3 = true
      L9_3 = 5
      L10_3 = false
      L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3)
      L1_3 = util
      L1_3 = L1_3.yield
      L2_3 = 1250
      L1_3(L2_3)
    end
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = menu
  L5_2 = L5_2.action
  L6_2 = kickplayer
  L7_2 = "智能踢"
  L8_2 = {}
  L9_2 = ""
  function L10_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3
    L0_3 = util
    L0_3 = L0_3.trigger_script_event
    L1_3 = SYSTEM
    L1_3 = L1_3.SHIFT_LEFT
    L2_3 = A0_2
    L3_3 = 1
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = {}
    L3_3 = 3115994416
    L4_3 = A0_2
    L5_3 = 4
    L6_3 = -1
    L7_3 = 1
    L8_3 = 1
    L9_3 = 1
    L2_3[1] = L3_3
    L2_3[2] = L4_3
    L2_3[3] = L5_3
    L2_3[4] = L6_3
    L2_3[5] = L7_3
    L2_3[6] = L8_3
    L2_3[7] = L9_3
    L0_3(L1_3, L2_3)
    L0_3 = util
    L0_3 = L0_3.trigger_script_event
    L1_3 = SYSTEM
    L1_3 = L1_3.SHIFT_LEFT
    L2_3 = A0_2
    L3_3 = 1
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = {}
    L3_3 = 111242367
    L4_3 = A0_2
    L5_3 = memory
    L5_3 = L5_3.script_global
    L6_3 = A0_2
    L6_3 = L6_3 * 453
    L6_3 = 2689236 + L6_3
    L6_3 = L6_3 + 318
    L6_3 = L6_3 + 7
    L5_3, L6_3, L7_3, L8_3, L9_3 = L5_3(L6_3)
    L2_3[1] = L3_3
    L2_3[2] = L4_3
    L2_3[3] = L5_3
    L2_3[4] = L6_3
    L2_3[5] = L7_3
    L2_3[6] = L8_3
    L2_3[7] = L9_3
    L0_3(L1_3, L2_3)
    L0_3 = util
    L0_3 = L0_3.trigger_script_event
    L1_3 = SYSTEM
    L1_3 = L1_3.SHIFT_LEFT
    L2_3 = A0_2
    L3_3 = 1
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = {}
    L3_3 = 1674887089
    L4_3 = PLAYER
    L4_3 = L4_3.PLAYER_ID
    L4_3 = L4_3()
    L5_3 = memory
    L5_3 = L5_3.read_int
    L6_3 = memory
    L6_3 = L6_3.script_global
    L7_3 = A0_2
    L7_3 = L7_3 * 599
    L7_3 = 1892704 + L7_3
    L7_3 = L7_3 + 510
    L6_3, L7_3, L8_3, L9_3 = L6_3(L7_3)
    L5_3, L6_3, L7_3, L8_3, L9_3 = L5_3(L6_3, L7_3, L8_3, L9_3)
    L2_3[1] = L3_3
    L2_3[2] = L4_3
    L2_3[3] = L5_3
    L2_3[4] = L6_3
    L2_3[5] = L7_3
    L2_3[6] = L8_3
    L2_3[7] = L9_3
    L0_3(L1_3, L2_3)
    L0_3 = menu
    L0_3 = L0_3.trigger_commands
    L1_3 = "kick"
    L2_3 = players
    L2_3 = L2_3.get_name
    L3_3 = A0_2
    L2_3 = L2_3(L3_3)
    L1_3 = L1_3 .. L2_3
    L0_3(L1_3)
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = _ENV
  L6_2 = "menu"
  L5_2 = L5_2[L6_2]
  L5_2 = L5_2.action
  L6_2 = kickplayer
  L7_2 = "阻止加入踢"
  L8_2 = {}
  L9_2 = "将该玩家踢出后加入到stand阻止加入的列表中."
  function L10_2()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = menu
    L0_3 = L0_3.trigger_commands
    L1_3 = "historyblock "
    L2_3 = players
    L2_3 = L2_3.get_name
    L3_3 = A0_2
    L2_3 = L2_3(L3_3)
    L1_3 = L1_3 .. L2_3
    L0_3(L1_3)
    L0_3 = menu
    L0_3 = L0_3.trigger_commands
    L1_3 = "kick"
    L2_3 = players
    L2_3 = L2_3.get_name
    L3_3 = A0_2
    L2_3 = L2_3(L3_3)
    L1_3 = L1_3 .. L2_3
    L0_3(L1_3)
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = menu
  L5_2 = L5_2.action
  L6_2 = kickplayer
  L7_2 = "主机踢"
  L8_2 = {}
  L9_2 = ""
  function L10_2()
    local L0_3, L1_3
    L0_3 = NETWORK
    L0_3 = L0_3.NETWORK_SESSION_KICK_PLAYER
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = menu
  L5_2 = L5_2.action
  L6_2 = crashplayer
  L7_2 = "任务载具崩溃"
  L8_2 = {}
  L9_2 = ""
  function L10_2()
    local L0_3, L1_3
    L0_3 = task_veh_crash
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = menu
  L5_2 = L5_2.action
  L6_2 = crashplayer
  L7_2 = "道具草崩溃"
  L8_2 = {}
  L9_2 = ""
  function L10_2()
    local L0_3, L1_3
    L0_3 = prop_grass
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = menu
  L5_2 = L5_2.action
  L6_2 = crashplayer
  L7_2 = "PED崩溃"
  L8_2 = {}
  L9_2 = ""
  function L10_2()
    local L0_3, L1_3
    L0_3 = PED_crash
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = menu
  L5_2 = L5_2.action
  L6_2 = crashplayer
  L7_2 = "无效绳索崩溃"
  L8_2 = {}
  L9_2 = ""
  function L10_2()
    local L0_3, L1_3
    L0_3 = Invalid_rope
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = menu
  L5_2 = L5_2.action
  L6_2 = crashplayer
  L7_2 = "新鬼崩"
  L8_2 = {}
  L9_2 = ""
  function L10_2()
    local L0_3, L1_3
    L0_3 = new_guibeng
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = menu
  L5_2 = L5_2.action
  L6_2 = crashplayer
  L7_2 = "鬼崩"
  L8_2 = {}
  L9_2 = ""
  function L10_2()
    local L0_3, L1_3
    L0_3 = guibeng
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = menu
  L5_2 = L5_2.action
  L6_2 = crashplayer
  L7_2 = "XF崩溃"
  L8_2 = {}
  L9_2 = ""
  function L10_2()
    local L0_3, L1_3
    L0_3 = XF_crash
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = menu
  L5_2 = L5_2.action
  L6_2 = crashplayer
  L7_2 = "布尔值崩溃"
  L8_2 = {}
  L9_2 = ""
  function L10_2()
    local L0_3, L1_3
    L0_3 = boolean_crash
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = menu
  L5_2 = L5_2.toggle_loop
  L6_2 = crashplayer
  L7_2 = "无效载具崩溃"
  L8_2 = {}
  L9_2 = ""
  function L10_2()
    local L0_3, L1_3
    L0_3 = Invalid_vehicle_crashes
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = menu
  L5_2 = L5_2.action
  L6_2 = crashplayer
  L7_2 = "XP终结者"
  L8_2 = {}
  L9_2 = ""
  function L10_2()
    local L0_3, L1_3
    L0_3 = xp_over
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = menu
  L5_2 = L5_2.action
  L6_2 = crashplayer
  L7_2 = "AIO崩"
  L8_2 = {}
  L9_2 = ""
  function L10_2()
    local L0_3, L1_3
    L0_3 = aaaio
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = menu
  L5_2 = L5_2.action
  L6_2 = crashplayer
  L7_2 = "OX崩"
  L8_2 = {}
  L9_2 = ""
  function L10_2()
    local L0_3, L1_3
    L0_3 = OXcrashgg
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = menu
  L5_2 = L5_2.action
  L6_2 = crashplayer
  L7_2 = "北域崩溃"
  L8_2 = {}
  L9_2 = ""
  function L10_2()
    local L0_3, L1_3
    L0_3 = Northern_crash
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = menu
  L5_2 = L5_2.action
  L6_2 = crashplayer
  L7_2 = "回弹崩溃"
  L8_2 = {}
  L9_2 = ""
  function L10_2()
    local L0_3, L1_3
    L0_3 = Rebound_crash
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = menu
  L5_2 = L5_2.action
  L6_2 = crashplayer
  L7_2 = "黄昏崩溃"
  L8_2 = {}
  L9_2 = ""
  function L10_2()
    local L0_3, L1_3
    L0_3 = nightfull_crash
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = menu
  L5_2 = L5_2.action
  L6_2 = crashplayer
  L7_2 = "Inshallah crash"
  L8_2 = {}
  L9_2 = ""
  function L10_2()
    local L0_3, L1_3
    L0_3 = Inshallah_crash
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = menu
  L5_2 = L5_2.action
  L6_2 = crashplayer
  L7_2 = "碎片崩溃"
  L8_2 = {}
  L9_2 = ""
  function L10_2()
    local L0_3, L1_3
    L0_3 = v1_frag
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = menu
  L5_2 = L5_2.action
  L6_2 = crashplayer
  L7_2 = "大自然崩溃"
  L8_2 = {}
  L9_2 = ""
  function L10_2()
    local L0_3, L1_3
    L0_3 = naturecrashv1
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = menu
  L5_2 = L5_2.action
  L6_2 = crashplayer
  L7_2 = "悲伤的耶稣崩溃"
  L8_2 = {}
  L9_2 = ""
  function L10_2()
    local L0_3, L1_3
    L0_3 = Jesus_crash
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = menu
  L5_2 = L5_2.action
  L6_2 = crashplayer
  L7_2 = "崩溃v3"
  L8_2 = {}
  L9_2 = ""
  function L10_2()
    local L0_3, L1_3
    L0_3 = Memoir
    L1_3 = A0_2
    L0_3(L1_3)
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = menu
  L5_2 = L5_2.divider
  L6_2 = cussinglayer
  L7_2 = "快捷怼人"
  L5_2(L6_2, L7_2)
  L5_2 = menu
  L5_2 = L5_2.action
  L6_2 = cussinglayer
  L7_2 = "怼人1"
  L8_2 = {}
  L9_2 = "公屏上骂他"
  function L10_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3
    L0_3 = chat
    L0_3 = L0_3.send_message
    L1_3 = PLAYER
    L1_3 = L1_3.GET_PLAYER_NAME
    L2_3 = A0_2
    L1_3 = L1_3(L2_3)
    L2_3 = cussing1
    L1_3 = L1_3 .. L2_3
    L2_3 = false
    L3_3 = true
    L4_3 = true
    L0_3(L1_3, L2_3, L3_3, L4_3)
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = menu
  L5_2 = L5_2.action
  L6_2 = cussinglayer
  L7_2 = "怼人2"
  L8_2 = {}
  L9_2 = "公屏上骂他"
  function L10_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3
    L0_3 = chat
    L0_3 = L0_3.send_message
    L1_3 = cussing2
    L2_3 = PLAYER
    L2_3 = L2_3.GET_PLAYER_NAME
    L3_3 = A0_2
    L2_3 = L2_3(L3_3)
    L3_3 = cussing2_1
    L1_3 = L1_3 .. L2_3 .. L3_3
    L2_3 = false
    L3_3 = true
    L4_3 = true
    L0_3(L1_3, L2_3, L3_3, L4_3)
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = menu
  L5_2 = L5_2.action
  L6_2 = cussinglayer
  L7_2 = "怼人3"
  L8_2 = {}
  L9_2 = "公屏上骂他"
  function L10_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3
    L0_3 = chat
    L0_3 = L0_3.send_message
    L1_3 = cussing3
    L2_3 = PLAYER
    L2_3 = L2_3.GET_PLAYER_NAME
    L3_3 = A0_2
    L2_3 = L2_3(L3_3)
    L1_3 = L1_3 .. L2_3
    L2_3 = false
    L3_3 = true
    L4_3 = true
    L0_3(L1_3, L2_3, L3_3, L4_3)
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = menu
  L5_2 = L5_2.action
  L6_2 = cussinglayer
  L7_2 = "怼人4"
  L8_2 = {}
  L9_2 = "公屏上骂他"
  function L10_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3
    L0_3 = chat
    L0_3 = L0_3.send_message
    L1_3 = cussing4
    L2_3 = PLAYER
    L2_3 = L2_3.GET_PLAYER_NAME
    L3_3 = A0_2
    L2_3 = L2_3(L3_3)
    L3_3 = cussing4_1
    L1_3 = L1_3 .. L2_3 .. L3_3
    L2_3 = false
    L3_3 = true
    L4_3 = true
    L0_3(L1_3, L2_3, L3_3, L4_3)
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = menu
  L5_2 = L5_2.action
  L6_2 = cussinglayer
  L7_2 = "怼人5"
  L8_2 = {}
  L9_2 = "公屏上骂他"
  function L10_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3
    L0_3 = chat
    L0_3 = L0_3.send_message
    L1_3 = cussing5
    L2_3 = false
    L3_3 = true
    L4_3 = true
    L0_3(L1_3, L2_3, L3_3, L4_3)
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = menu
  L5_2 = L5_2.action
  L6_2 = cussinglayer
  L7_2 = "怼人6"
  L8_2 = {}
  L9_2 = "公屏上骂他"
  function L10_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3
    L0_3 = chat
    L0_3 = L0_3.send_message
    L1_3 = PLAYER
    L1_3 = L1_3.GET_PLAYER_NAME
    L2_3 = A0_2
    L1_3 = L1_3(L2_3)
    L2_3 = cussing6
    L1_3 = L1_3 .. L2_3
    L2_3 = false
    L3_3 = true
    L4_3 = true
    L0_3(L1_3, L2_3, L3_3, L4_3)
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = menu
  L5_2 = L5_2.action
  L6_2 = cussinglayer
  L7_2 = "怼人7"
  L8_2 = {}
  L9_2 = "公屏上骂他"
  function L10_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3
    L0_3 = chat
    L0_3 = L0_3.send_message
    L1_3 = cussing7
    L2_3 = false
    L3_3 = true
    L4_3 = true
    L0_3(L1_3, L2_3, L3_3, L4_3)
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = menu
  L5_2 = L5_2.action
  L6_2 = cussinglayer
  L7_2 = "怼人8"
  L8_2 = {}
  L9_2 = "公屏上骂他"
  function L10_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3
    L0_3 = chat
    L0_3 = L0_3.send_message
    L1_3 = cussing8
    L2_3 = false
    L3_3 = true
    L4_3 = true
    L0_3(L1_3, L2_3, L3_3, L4_3)
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = menu
  L5_2 = L5_2.action
  L6_2 = cussinglayer
  L7_2 = "怼人9"
  L8_2 = {}
  L9_2 = "公屏上骂他"
  function L10_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3
    L0_3 = chat
    L0_3 = L0_3.send_message
    L1_3 = cussing9
    L2_3 = false
    L3_3 = true
    L4_3 = true
    L0_3(L1_3, L2_3, L3_3, L4_3)
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
  L5_2 = menu
  L5_2 = L5_2.action
  L6_2 = cussinglayer
  L7_2 = "怼人10"
  L8_2 = {}
  L9_2 = "公屏上骂他"
  function L10_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3
    L0_3 = chat
    L0_3 = L0_3.send_message
    L1_3 = cussing10
    L2_3 = false
    L3_3 = true
    L4_3 = true
    L0_3(L1_3, L2_3, L3_3, L4_3)
  end
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
end
L20_1(L21_1)
L20_1 = _ENV
L21_1 = "clear_list"
L22_1 = _ENV
L23_1 = "menu"
L22_1 = L22_1[L23_1]
L23_1 = "list"
L22_1 = L22_1[L23_1]
L23_1 = _ENV
L24_1 = "protection"
L23_1 = L23_1[L24_1]
L24_1 = "清除选项"
L25_1 = {}
L26_1 = ""
L22_1 = L22_1(L23_1, L24_1, L25_1, L26_1)
L20_1[L21_1] = L22_1
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "textslider"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "clear_list"
L21_1 = L21_1[L22_1]
L22_1 = "清理实体"
L23_1 = {}
L24_1 = ""
L25_1 = {}
L26_1 = "PED"
L27_1 = "载具"
L28_1 = "物体"
L29_1 = "拾取物"
L30_1 = "绳索"
L31_1 = "投掷物"
L25_1[1] = L26_1
L25_1[2] = L27_1
L25_1[3] = L28_1
L25_1[4] = L29_1
L25_1[5] = L30_1
L25_1[6] = L31_1
function L26_1(A0_2)
  local L1_2, L2_2
  L1_2 = clean_select_entities
  L2_2 = A0_2
  L1_2(L2_2)
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1, L26_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "action"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "clear_list"
L21_1 = L21_1[L22_1]
L22_1 = "普通清除"
L23_1 = {}
L24_1 = "只清除PED和载具"
function L25_1()
  local L0_2, L1_2
  L0_2 = Normal_clearance
  L0_2()
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "action"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "clear_list"
L21_1 = L21_1[L22_1]
L22_1 = "超级清除"
L23_1 = {}
L24_1 = "清除所有"
function L25_1()
  local L0_2, L1_2
  L0_2 = super_clear
  L0_2()
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "toggle_loop"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "clear_list"
L21_1 = L21_1[L22_1]
L22_1 = "循环清理实体"
L23_1 = {}
L24_1 = ""
function L25_1()
  local L0_2, L1_2
  L0_2 = loop_clear_entity
  L0_2()
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "action"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "protection"
L21_1 = L21_1[L22_1]
L22_1 = "分离元素"
L23_1 = {}
L24_1 = "分离所有附加元素"
function L25_1()
  local L0_2, L1_2
  L0_2 = detach_all_entities
  L0_2()
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "action"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "protection"
L21_1 = L21_1[L22_1]
L22_1 = "恢复形态"
L23_1 = {}
L24_1 = "恢复玩家正常状态,姿势等"
function L25_1()
  local L0_2, L1_2
  L0_2 = TASK
  L0_2 = L0_2.CLEAR_PED_TASKS_IMMEDIATELY
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L0_2(L1_2)
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "deathlog_lt"
L22_1 = _ENV
L23_1 = "menu"
L22_1 = L22_1[L23_1]
L23_1 = "list"
L22_1 = L22_1[L23_1]
L23_1 = _ENV
L24_1 = "protection"
L23_1 = L23_1[L24_1]
L24_1 = "死亡日志"
L25_1 = {}
L26_1 = "记录谁杀了你"
L22_1 = L22_1(L23_1, L24_1, L25_1, L26_1)
L20_1[L21_1] = L22_1
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "toggle_loop"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "deathlog_lt"
L21_1 = L21_1[L22_1]
L22_1 = "开启"
L23_1 = {}
L24_1 = ""
function L25_1()
  local L0_2, L1_2
  L0_2 = death_log
  L0_2()
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "action"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "deathlog_lt"
L21_1 = L21_1[L22_1]
L22_1 = "打开文件夹"
L23_1 = {}
L24_1 = ""
function L25_1()
  local L0_2, L1_2
  L0_2 = open_dea_log
  L0_2()
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "action"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "deathlog_lt"
L21_1 = L21_1[L22_1]
L22_1 = "清除日志"
L23_1 = {}
L24_1 = ""
function L25_1()
  local L0_2, L1_2
  L0_2 = clear_dea_log
  L0_2()
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "toggle"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "protection"
L21_1 = L21_1[L22_1]
L22_1 = "防崩视角"
L23_1 = {}
L24_1 = ""
function L25_1(A0_2)
  local L1_2, L2_2
  L1_2 = anti_crash_cam
  L2_2 = A0_2
  L1_2(L2_2)
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "protex"
L22_1 = _ENV
L23_1 = "menu"
L22_1 = L22_1[L23_1]
L23_1 = "list"
L22_1 = L22_1[L23_1]
L23_1 = _ENV
L24_1 = "protection"
L23_1 = L23_1[L24_1]
L24_1 = "事件保护"
L25_1 = {}
L26_1 = ""
L22_1 = L22_1(L23_1, L24_1, L25_1, L26_1)
L20_1[L21_1] = L22_1
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "action"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "protex"
L21_1 = L21_1[L22_1]
L22_1 = "清除火焰效果"
L23_1 = {}
L24_1 = ""
function L25_1()
  local L0_2, L1_2
  L0_2 = blockfireeffect
  L0_2()
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "toggle_loop"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "protex"
L21_1 = L21_1[L22_1]
L22_1 = "拦截粒子效果"
L23_1 = {}
L24_1 = ""
function L25_1()
  local L0_2, L1_2
  L0_2 = blockcrasheffect
  L0_2()
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "toggle_loop"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "protex"
L21_1 = L21_1[L22_1]
L22_1 = "阻止交易错误"
L23_1 = {}
L24_1 = "阻止一些脚本,利用破坏车辆的方法,让你出现交易错误"
function L25_1()
  local L0_2, L1_2, L2_2
  L0_2 = util
  L0_2 = L0_2.spoof_script
  L1_2 = "am_destroy_veh"
  L2_2 = TERMINATE_THIS_THREAD
  L0_2 = L0_2(L1_2, L2_2)
  if L0_2 then
    L0_2 = util
    L0_2 = L0_2.toast
    L1_2 = "检测到销毁车辆脚本. 正在阻止..."
    L0_2(L1_2)
  end
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "toggle"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "protex"
L21_1 = L21_1[L22_1]
L22_1 = "防止爆头"
L23_1 = {}
L24_1 = ""
function L25_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = PED
  L1_2 = L1_2.SET_PED_SUFFERS_CRITICAL_HITS
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = not A0_2
  L1_2(L2_2, L3_2)
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "auto_kick_adBot"
L22_1 = _ENV
L23_1 = "menu"
L22_1 = L22_1[L23_1]
L23_1 = "toggle"
L22_1 = L22_1[L23_1]
L23_1 = _ENV
L24_1 = "protection"
L23_1 = L23_1[L24_1]
L24_1 = "自动踢出广告机"
L25_1 = {}
L26_1 = "配置[√]\n自动踢出广告机/事件检测玩家"
function L27_1(A0_2)
  local L1_2
  kick_adBot = A0_2
end
L22_1 = L22_1(L23_1, L24_1, L25_1, L26_1, L27_1)
L20_1[L21_1] = L22_1
L20_1 = _ENV
L21_1 = "chat"
L20_1 = L20_1[L21_1]
L21_1 = "on_message"
L20_1 = L20_1[L21_1]
function L21_1(A0_2, A1_2, A2_2, A3_2, A4_2, A5_2)
  local L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L6_2 = string
  L6_2 = L6_2.lower
  L7_2 = A2_2
  L6_2 = L6_2(L7_2)
  L7_2 = players
  L7_2 = L7_2.get_name
  L8_2 = A0_2
  L7_2 = L7_2(L8_2)
  L8_2 = kick_adBot
  if L8_2 then
    L8_2 = pairs
    L9_2 = Bot_adwords
    L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2)
    for L12_2, L13_2 in L8_2, L9_2, L10_2, L11_2 do
      L14_2 = string
      L14_2 = L14_2.contains
      L15_2 = L6_2
      L16_2 = L13_2
      L14_2 = L14_2(L15_2, L16_2)
      if L14_2 then
        L14_2 = util
        L14_2 = L14_2.toast
        L15_2 = "检测到广告机"
        L16_2 = L7_2
        L15_2 = L15_2 .. L16_2
        L14_2(L15_2)
        L14_2 = util
        L14_2 = L14_2.log
        L15_2 = "检测到广告机"
        L16_2 = L7_2
        L15_2 = L15_2 .. L16_2
        L14_2(L15_2)
        L14_2 = menu
        L14_2 = L14_2.trigger_commands
        L15_2 = "kick "
        L16_2 = L7_2
        L15_2 = L15_2 .. L16_2
        L14_2(L15_2)
      end
    end
  end
end
L20_1(L21_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "set_value"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "auto_kick_adBot"
L21_1 = L21_1[L22_1]
L22_1 = _ENV
L23_1 = "config_active7"
L22_1 = L22_1[L23_1]
L20_1(L21_1, L22_1)
L20_1 = _ENV
L21_1 = "ridicule_list"
L22_1 = _ENV
L23_1 = "menu"
L22_1 = L22_1[L23_1]
L23_1 = "list"
L22_1 = L22_1[L23_1]
L23_1 = _ENV
L24_1 = "protex"
L23_1 = L23_1[L24_1]
L24_1 = "攻击嘲讽"
L25_1 = {}
L26_1 = ""
L22_1 = L22_1(L23_1, L24_1, L25_1, L26_1)
L20_1[L21_1] = L22_1
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "action"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "ridicule_list"
L21_1 = L21_1[L22_1]
L22_1 = "修改内容"
L23_1 = {}
L24_1 = ""
function L25_1()
  local L0_2, L1_2
  L0_2 = change_ridicule
  L0_2()
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "toggle_loop"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "ridicule_list"
L21_1 = L21_1[L22_1]
L22_1 = "攻击嘲讽"
L23_1 = {}
L24_1 = "在同一战局只会对同一玩家触发一次"
function L25_1()
  local L0_2, L1_2
  L0_2 = Attack_ridicule
  L0_2()
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "action"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "protex"
L21_1 = L21_1[L22_1]
L22_1 = "强制停止所有声音"
L23_1 = {}
L24_1 = ""
function L25_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
  L0_2 = -1
  L1_2 = 100
  L2_2 = 1
  for L3_2 = L0_2, L1_2, L2_2 do
    L4_2 = AUDIO
    L4_2 = L4_2.STOP_SOUND
    L5_2 = L3_2
    L4_2(L5_2)
    L4_2 = AUDIO
    L4_2 = L4_2.RELEASE_SOUND_ID
    L5_2 = L3_2
    L4_2(L5_2)
  end
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "toggle_loop"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "protex"
L21_1 = L21_1[L22_1]
L22_1 = "阻止附加模型"
L23_1 = {}
L24_1 = "分离所有附加到当前载具的模型"
function L25_1()
  local L0_2, L1_2
  L0_2 = Block_attached_models
  L0_2()
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "throttler"
L22_1 = _ENV
L23_1 = "menu"
L22_1 = L22_1[L23_1]
L23_1 = "list"
L22_1 = L22_1[L23_1]
L23_1 = _ENV
L24_1 = "protex"
L23_1 = L23_1[L24_1]
L24_1 = "自动节流器"
L25_1 = {}
L26_1 = ""
L22_1 = L22_1(L23_1, L24_1, L25_1, L26_1)
L20_1[L21_1] = L22_1
L20_1 = require
L21_1 = "lib.daidailib.restrictor"
L20_1(L21_1)
L20_1 = _ENV
L21_1 = "pool_limiter"
L22_1 = _ENV
L23_1 = "menu"
L22_1 = L22_1[L23_1]
L23_1 = "list"
L22_1 = L22_1[L23_1]
L23_1 = _ENV
L24_1 = "protex"
L23_1 = L23_1[L24_1]
L24_1 = "实体池限制"
L25_1 = {}
L26_1 = ""
L22_1 = L22_1(L23_1, L24_1, L25_1, L26_1)
L20_1[L21_1] = L22_1
L20_1 = _ENV
L21_1 = "ped_limit"
L22_1 = 175
L20_1[L21_1] = L22_1
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "slider"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "pool_limiter"
L21_1 = L21_1[L22_1]
L22_1 = "Ped池限制"
L23_1 = {}
L24_1 = "pedslimit"
L23_1[1] = L24_1
L24_1 = "默认为175"
L25_1 = 0
L26_1 = 256
L27_1 = 175
L28_1 = 1
function L29_1(A0_2)
  local L1_2
  ped_limit = A0_2
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1)
L20_1 = _ENV
L21_1 = "veh_limit"
L22_1 = 127
L20_1[L21_1] = L22_1
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "slider"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "pool_limiter"
L21_1 = L21_1[L22_1]
L22_1 = "载具池限制"
L23_1 = {}
L24_1 = "vehlimit"
L23_1[1] = L24_1
L24_1 = "默认为127"
L25_1 = 0
L26_1 = 300
L27_1 = 127
L28_1 = 1
function L29_1(A0_2)
  local L1_2
  veh_limit = A0_2
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1)
L20_1 = _ENV
L21_1 = "obj_limit"
L22_1 = 500
L20_1[L21_1] = L22_1
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "slider"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "pool_limiter"
L21_1 = L21_1[L22_1]
L22_1 = "物体池限制"
L23_1 = {}
L24_1 = "objlimit"
L23_1[1] = L24_1
L24_1 = "默认为500"
L25_1 = 0
L26_1 = 2300
L27_1 = 500
L28_1 = 1
function L29_1(A0_2)
  local L1_2
  obj_limit = A0_2
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "toggle_loop"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "pool_limiter"
L21_1 = L21_1[L22_1]
L22_1 = "启用实体池限制"
L23_1 = {}
L24_1 = ""
function L25_1()
  local L0_2, L1_2
  L0_2 = entity_limit
  L0_2()
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "mk2"
L22_1 = _ENV
L23_1 = "menu"
L22_1 = L22_1[L23_1]
L23_1 = "list"
L22_1 = L22_1[L23_1]
L23_1 = _ENV
L24_1 = "protex"
L23_1 = L23_1[L24_1]
L24_1 = "MK-2拦截"
L25_1 = {}
L26_1 = ""
L22_1 = L22_1(L23_1, L24_1, L25_1, L26_1)
L20_1[L21_1] = L22_1
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "toggle"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "mk2"
L21_1 = L21_1[L22_1]
L22_1 = "开启报应"
L23_1 = {}
L24_1 = "自动处理附近mk2用户载具"
function L25_1(A0_2)
  local L1_2
  if A0_2 then
    oppressorKarma = true
    L1_2 = oppKarma
    L1_2()
  else
    oppressorKarma = false
  end
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "toggle"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "mk2"
L21_1 = L21_1[L22_1]
L22_1 = "目标朋友"
L23_1 = {}
L24_1 = "这也将针对你的朋友."
function L25_1(A0_2)
  local L1_2
  oppressorFriendKarma = A0_2
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "toggle"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "mk2"
L21_1 = L21_1[L22_1]
L22_1 = "目标你自己"
L23_1 = {}
L24_1 = "这也将针对你自己."
function L25_1(A0_2)
  local L1_2
  oppressorYourselfKarma = A0_2
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "list_select"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "mk2"
L21_1 = L21_1[L22_1]
L22_1 = "报应方式"
L23_1 = {}
L24_1 = "选择一种方式"
L25_1 = _ENV
L26_1 = "optionsMK2Karma"
L25_1 = L25_1[L26_1]
L26_1 = 1
function L27_1(A0_2)
  local L1_2
  L1_2 = gm
  L1_2 = L1_2[A0_2]
  selectedKarmaMK2 = L1_2
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1)
L20_1 = _ENV
L21_1 = "r_admin"
L22_1 = _ENV
L23_1 = "menu"
L22_1 = L22_1[L23_1]
L23_1 = "list"
L22_1 = L22_1[L23_1]
L23_1 = _ENV
L24_1 = "protex"
L23_1 = L23_1[L24_1]
L24_1 = "R*管理人员加入反应"
L25_1 = {}
L26_1 = ""
L22_1 = L22_1(L23_1, L24_1, L25_1, L26_1)
L20_1[L21_1] = L22_1
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "toggle_loop"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "r_admin"
L21_1 = L21_1[L22_1]
L22_1 = "R*管理人员加入提示"
L23_1 = {}
L24_1 = ""
function L25_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = util
  L0_2 = L0_2.is_session_started
  L0_2 = L0_2()
  if L0_2 then
    L0_2 = players
    L0_2 = L0_2.list
    L1_2 = false
    L2_2 = true
    L3_2 = true
    L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2)
    for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
      L6_2 = players
      L6_2 = L6_2.is_marked_as_admin
      L7_2 = L5_2
      L6_2 = L6_2(L7_2)
      if L6_2 then
        L6_2 = util
        L6_2 = L6_2.toast
        L7_2 = "检测到管理员加入哦！"
        L6_2(L7_2)
      end
    end
  end
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "toggle_loop"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "r_admin"
L21_1 = L21_1[L22_1]
L22_1 = "R*管理人员加入反应"
L23_1 = {}
L24_1 = "当管理员加入时自动加入新战局"
function L25_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = util
  L0_2 = L0_2.is_session_started
  L0_2 = L0_2()
  if L0_2 then
    L0_2 = players
    L0_2 = L0_2.list
    L1_2 = false
    L2_2 = true
    L3_2 = true
    L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2)
    for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
      L6_2 = players
      L6_2 = L6_2.is_marked_as_admin
      L7_2 = L5_2
      L6_2 = L6_2(L7_2)
      if L6_2 then
        L6_2 = util
        L6_2 = L6_2.toast
        L7_2 = "检测到管理员!5秒后加入新战局!"
        L6_2(L7_2)
        L6_2 = util
        L6_2 = L6_2.yield
        L7_2 = 5000
        L6_2(L7_2)
        L6_2 = menu
        L6_2 = L6_2.trigger_commands
        L7_2 = "go public"
        L6_2(L7_2)
      end
    end
  end
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "toggle_loop"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "protex"
L21_1 = L21_1[L22_1]
L22_1 = "禁用阻止实体轰炸"
L23_1 = {}
L24_1 = "将在任务中自动禁用阻止实体轰炸,防止任务卡关."
function L25_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = menu
  L0_2 = L0_2.ref_by_path
  L1_2 = "Online>Protections>Block Entity Spam>Block Entity Spam"
  L0_2 = L0_2(L1_2)
  L1_2 = NETWORK
  L1_2 = L1_2.NETWORK_IS_ACTIVITY_SESSION
  L1_2 = L1_2()
  if true == L1_2 then
    L1_2 = menu
    L1_2 = L1_2.get_value
    L2_2 = L0_2
    L1_2 = L1_2(L2_2)
    if not L1_2 then
      return
    end
    L1_2 = menu
    L1_2 = L1_2.trigger_command
    L2_2 = L0_2
    L3_2 = "off"
    L1_2(L2_2, L3_2)
  else
    L1_2 = menu
    L1_2 = L1_2.get_value
    L2_2 = L0_2
    L1_2 = L1_2(L2_2)
    if L1_2 then
      return
    end
    L1_2 = menu
    L1_2 = L1_2.trigger_command
    L2_2 = L0_2
    L3_2 = "on"
    L1_2(L2_2, L3_2)
  end
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "toggle_loop"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "protex"
L21_1 = L21_1[L22_1]
L22_1 = "阻止过场动画"
L23_1 = {}
L24_1 = ""
function L25_1()
  local L0_2, L1_2
  L0_2 = CUTSCENE
  L0_2 = L0_2.IS_CUTSCENE_PLAYING
  L0_2 = L0_2()
  if L0_2 then
    L0_2 = CUTSCENE
    L0_2 = L0_2.STOP_CUTSCENE_IMMEDIATELY
    L0_2()
    L0_2 = CUTSCENE
    L0_2 = L0_2.REMOVE_CUTSCENE
    L0_2()
  end
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "toggle_loop"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "protex"
L21_1 = L21_1[L22_1]
L22_1 = "阻止玩家观看"
L23_1 = {}
L24_1 = "阻止所有观看你的人的同步."
function L25_1()
  local L0_2, L1_2
  L0_2 = block_spectate
  L0_2()
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "toggle_loop"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "protex"
L21_1 = L21_1[L22_1]
L22_1 = "野兽防护"
L23_1 = {}
L24_1 = "防止你被变成野兽,但也会阻止其他人的战局事件."
function L25_1()
  local L0_2, L1_2, L2_2
  L0_2 = util
  L0_2 = L0_2.spoof_script
  L1_2 = "am_hunt_the_beast"
  L2_2 = SCRIPT1
  L2_2 = L2_2.TERMINATE_THIS_THREAD
  L0_2 = L0_2(L1_2, L2_2)
  if L0_2 then
    L0_2 = util
    L0_2 = L0_2.toast
    L1_2 = "检测到《 猎杀野兽 》事件生成。已终止事件..."
    L0_2(L1_2)
  end
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "divider"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "protex"
L21_1 = L21_1[L22_1]
L22_1 = "网络事件"
L20_1(L21_1, L22_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "toggle"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "protex"
L21_1 = L21_1[L22_1]
L22_1 = "阻止网络事件"
L23_1 = {}
L24_1 = "阻止网络事件传输"
function L25_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = menu
  L1_2 = L1_2.ref_by_path
  L2_2 = "Online>Protections>Events>Raw Network Events>Any Event>Block>Enabled"
  L1_2 = L1_2(L2_2)
  L2_2 = menu
  L2_2 = L2_2.ref_by_path
  L3_2 = "Online>Protections>Events>Raw Network Events>Any Event>Block>Disabled"
  L2_2 = L2_2(L3_2)
  if A0_2 then
    L3_2 = menu
    L3_2 = L3_2.trigger_command
    L4_2 = L1_2
    L3_2(L4_2)
  else
    L3_2 = menu
    L3_2 = L3_2.trigger_command
    L4_2 = L2_2
    L3_2(L4_2)
  end
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "toggle"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "protex"
L21_1 = L21_1[L22_1]
L22_1 = "阻止传入"
L23_1 = {}
L24_1 = "阻止网络事件传入"
function L25_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = menu
  L1_2 = L1_2.ref_by_path
  L2_2 = "Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Enabled"
  L1_2 = L1_2(L2_2)
  L2_2 = menu
  L2_2 = L2_2.ref_by_path
  L3_2 = "Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Disabled"
  L2_2 = L2_2(L3_2)
  if A0_2 then
    L3_2 = menu
    L3_2 = L3_2.trigger_command
    L4_2 = L1_2
    L3_2(L4_2)
  else
    L3_2 = menu
    L3_2 = L3_2.trigger_command
    L4_2 = L2_2
    L3_2(L4_2)
  end
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "toggle"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "protex"
L21_1 = L21_1[L22_1]
L22_1 = "阻止传出"
L23_1 = {}
L24_1 = "阻止网络事件传出"
function L25_1(A0_2)
  local L1_2, L2_2
  if A0_2 then
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "desyncall on"
    L1_2(L2_2)
  else
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "desyncall off"
    L1_2(L2_2)
  end
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "toggle_loop"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "protection"
L21_1 = L21_1[L22_1]
L22_1 = "防笼子"
L23_1 = {}
L24_1 = "你不该长时间开启此功能"
function L25_1()
  local L0_2, L1_2
  L0_2 = Cage_proof
  L0_2()
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "anti_mugger"
L22_1 = _ENV
L23_1 = "menu"
L22_1 = L22_1[L23_1]
L23_1 = "list"
L22_1 = L22_1[L23_1]
L23_1 = _ENV
L24_1 = "protection"
L23_1 = L23_1[L24_1]
L24_1 = "拦截劫匪"
L22_1 = L22_1(L23_1, L24_1)
L20_1[L21_1] = L22_1
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "toggle_loop"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "anti_mugger"
L21_1 = L21_1[L22_1]
L22_1 = "拦截劫匪"
L23_1 = {}
L24_1 = "防止被抢劫"
function L25_1()
  local L0_2, L1_2
  L0_2 = block_mugger
  L0_2()
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "toggle_loop"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "anti_mugger"
L21_1 = L21_1[L22_1]
L22_1 = "劫匪检测"
L23_1 = {}
L24_1 = "给劫匪绘制2D方框"
function L25_1()
  local L0_2, L1_2
  L0_2 = show_mugger
  L0_2()
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "toggle"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "protection"
L21_1 = L21_1[L22_1]
L22_1 = "自闭模式"
L23_1 = {}
L24_1 = "没错就是自闭"
function L25_1(A0_2)
  local L1_2, L2_2
  L1_2 = chickenmode
  L2_2 = A0_2
  L1_2(L2_2)
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "aimkarma"
L22_1 = _ENV
L23_1 = "menu"
L22_1 = L22_1[L23_1]
L23_1 = "list"
L22_1 = L22_1[L23_1]
L23_1 = _ENV
L24_1 = "protection"
L23_1 = L23_1[L24_1]
L24_1 = "瞄准惩罚"
L25_1 = {}
L26_1 = "对瞄准您的玩家做一些事情."
L22_1 = L22_1(L23_1, L24_1, L25_1, L26_1)
L20_1[L21_1] = L22_1
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "toggle_loop"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "aimkarma"
L21_1 = L21_1[L22_1]
L22_1 = "套笼子"
L23_1 = {}
L24_1 = "打你就关起来"
function L25_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
  L0_2 = PLAYER
  L0_2 = L0_2.PLAYER_PED_ID
  L0_2 = L0_2()
  L1_2 = playerIsTargetingEntity
  L2_2 = L0_2
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L1_2 = karma
    L1_2 = L1_2[L0_2]
    if L1_2 then
      L1_2 = karma
      L1_2 = L1_2[L0_2]
      L1_2 = L1_2.pid
      L2_2 = menu
      L2_2 = L2_2.trigger_commands
      L3_2 = "cage"
      L4_2 = players
      L4_2 = L4_2.get_name
      L5_2 = L1_2
      L4_2 = L4_2(L5_2)
      L3_2 = L3_2 .. L4_2
      L2_2(L3_2)
    end
  end
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "toggle_loop"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "aimkarma"
L21_1 = L21_1[L22_1]
L22_1 = "射击"
L23_1 = {}
L24_1 = "射击瞄准您的玩家."
function L25_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L0_2 = PLAYER
  L0_2 = L0_2.PLAYER_PED_ID
  L0_2 = L0_2()
  L1_2 = isAnyPlayerTargetingEntity
  L2_2 = L0_2
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L1_2 = karma
    L1_2 = L1_2[L0_2]
    if L1_2 then
      L1_2 = ENTITY
      L1_2 = L1_2.GET_ENTITY_COORDS
      L2_2 = karma
      L2_2 = L2_2[L0_2]
      L2_2 = L2_2.ped
      L1_2 = L1_2(L2_2)
      L2_2 = MISC
      L2_2 = L2_2.SHOOT_SINGLE_BULLET_BETWEEN_COORDS
      L3_2 = L1_2.x
      L4_2 = L1_2.y
      L5_2 = L1_2.z
      L6_2 = L1_2.x
      L7_2 = L1_2.y
      L8_2 = L1_2.z
      L8_2 = L8_2 + 0.1
      L9_2 = 100
      L10_2 = true
      L11_2 = 100416529
      L12_2 = L0_2
      L13_2 = true
      L14_2 = false
      L15_2 = 100.0
      L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
      L2_2 = util
      L2_2 = L2_2.yield
      L2_2()
    end
  end
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "toggle_loop"
L20_1 = L20_1[L21_1]
L21_1 = _ENV
L22_1 = "aimkarma"
L21_1 = L21_1[L22_1]
L22_1 = "爆炸"
L23_1 = {}
L24_1 = "使用您的自定义爆炸设置爆炸玩家."
function L25_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = PLAYER
  L0_2 = L0_2.PLAYER_PED_ID
  L0_2 = L0_2()
  L1_2 = isAnyPlayerTargetingEntity
  L2_2 = L0_2
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L1_2 = karma
    L1_2 = L1_2[L0_2]
    if L1_2 then
      L1_2 = explodePlayer
      L2_2 = karma
      L2_2 = L2_2[L0_2]
      L2_2 = L2_2.ped
      L3_2 = true
      L4_2 = expSettings
      L1_2(L2_2, L3_2, L4_2)
    end
  end
end
L20_1(L21_1, L22_1, L23_1, L24_1, L25_1)
L20_1 = _ENV
L21_1 = "proofsList"
L22_1 = _ENV
L23_1 = "menu"
L22_1 = L22_1[L23_1]
L23_1 = "list"
L22_1 = L22_1[L23_1]
L23_1 = _ENV
L24_1 = "protection"
L23_1 = L23_1[L24_1]
L24_1 = "免疫伤害"
L25_1 = {}
L26_1 = "无敌类型自定义选项"
L22_1 = L22_1(L23_1, L24_1, L25_1, L26_1)
L20_1[L21_1] = L22_1
L20_1 = _ENV
L21_1 = "menu"
L20_1 = L20_1[L21_1]
L21_1 = "ref_by_path"
L20_1 = L20_1[L21_1]
L21_1 = "Self>Immortality"
L20_1 = L20_1(L21_1)
L21_1 = _ENV
L22_1 = "pairs"
L21_1 = L21_1[L22_1]
L22_1 = _ENV
L23_1 = "proofs"
L22_1 = L22_1[L23_1]
L21_1, L22_1, L23_1, L24_1 = L21_1(L22_1)
for L25_1, L26_1 in L21_1, L22_1, L23_1, L24_1 do
  L27_1 = _ENV
  L28_1 = "menu"
  L27_1 = L27_1[L28_1]
  L28_1 = "toggle"
  L27_1 = L27_1[L28_1]
  L28_1 = _ENV
  L29_1 = "proofsList"
  L28_1 = L28_1[L29_1]
  L29_1 = L26_1.name
  L30_1 = {}
  L31_1 = L26_1.name
  L33_1 = "lower"
  L32_1 = L31_1
  L31_1 = L31_1[L33_1]
  L31_1 = L31_1(L32_1)
  L32_1 = "proof"
  L31_1 = L31_1 .. L32_1
  L30_1[1] = L31_1
  L31_1 = "让您对"
  L32_1 = L26_1.name
  L34_1 = "lower"
  L33_1 = L32_1
  L32_1 = L32_1[L34_1]
  L32_1 = L32_1(L33_1)
  L33_1 = "伤害避免"
  L31_1 = L31_1 .. L32_1 .. L33_1
  function L32_1(A0_2)
    local L1_2
    L26_1.on = A0_2
  end
  L27_1(L28_1, L29_1, L30_1, L31_1, L32_1)
end
L21_1 = _ENV
L22_1 = "util"
L21_1 = L21_1[L22_1]
L22_1 = "create_tick_handler"
L21_1 = L21_1[L22_1]
function L22_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L0_2 = PLAYER
  L0_2 = L0_2.PLAYER_PED_ID
  L0_2 = L0_2()
  L1_2 = menu
  L1_2 = L1_2.get_value
  L2_2 = L20_1
  L1_2 = L1_2(L2_2)
  if not L1_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.SET_ENTITY_PROOFS
    L2_2 = L0_2
    L3_2 = proofs
    L3_2 = L3_2.bullet
    L3_2 = L3_2.on
    L4_2 = proofs
    L4_2 = L4_2.fire
    L4_2 = L4_2.on
    L5_2 = proofs
    L5_2 = L5_2.explosion
    L5_2 = L5_2.on
    L6_2 = proofs
    L6_2 = L6_2.collision
    L6_2 = L6_2.on
    L7_2 = proofs
    L7_2 = L7_2.melee
    L7_2 = L7_2.on
    L8_2 = proofs
    L8_2 = L8_2.steam
    L8_2 = L8_2.on
    L9_2 = false
    L10_2 = proofs
    L10_2 = L10_2.drown
    L10_2 = L10_2.on
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  end
end
L21_1(L22_1)
L21_1 = _ENV
L22_1 = "menu"
L21_1 = L21_1[L22_1]
L22_1 = "action"
L21_1 = L21_1[L22_1]
L22_1 = _ENV
L23_1 = "tp_world"
L22_1 = L22_1[L23_1]
L23_1 = "传送到标记点"
L24_1 = {}
L25_1 = ""
function L26_1()
  local L0_2, L1_2
  L0_2 = tp_waypoint
  L0_2()
end
L21_1(L22_1, L23_1, L24_1, L25_1, L26_1)
L21_1 = _ENV
L22_1 = "menu"
L21_1 = L21_1[L22_1]
L22_1 = "action"
L21_1 = L21_1[L22_1]
L22_1 = _ENV
L23_1 = "tp_world"
L22_1 = L22_1[L23_1]
L23_1 = "过渡传送"
L24_1 = {}
L25_1 = ""
function L26_1()
  local L0_2, L1_2
  L0_2 = transit_tp
  L0_2()
end
L21_1(L22_1, L23_1, L24_1, L25_1, L26_1)
L21_1 = _ENV
L22_1 = "menu"
L21_1 = L21_1[L22_1]
L22_1 = "action"
L21_1 = L21_1[L22_1]
L22_1 = _ENV
L23_1 = "tp_world"
L22_1 = L22_1[L23_1]
L23_1 = "随机位置"
L24_1 = {}
L25_1 = ""
function L26_1()
  local L0_2, L1_2
  L0_2 = random_position
  L0_2()
end
L21_1(L22_1, L23_1, L24_1, L25_1, L26_1)
L21_1 = _ENV
L22_1 = "menu"
L21_1 = L21_1[L22_1]
L22_1 = "action"
L21_1 = L21_1[L22_1]
L22_1 = _ENV
L23_1 = "tp_world"
L22_1 = L22_1[L23_1]
L23_1 = "自定义传送"
L24_1 = {}
L25_1 = "分隔符为英式格式"
function L26_1()
  local L0_2, L1_2
  L0_2 = Custom_teleport
  L0_2()
end
L21_1(L22_1, L23_1, L24_1, L25_1, L26_1)
L21_1 = _ENV
L22_1 = "menu"
L21_1 = L21_1[L22_1]
L22_1 = "toggle_loop"
L21_1 = L21_1[L22_1]
L22_1 = _ENV
L23_1 = "tp_world"
L22_1 = L22_1[L23_1]
L23_1 = "自动传送到标记点"
L24_1 = {}
L25_1 = ""
function L26_1()
  local L0_2, L1_2
  L0_2 = tp_waypoint
  L0_2()
end
L21_1(L22_1, L23_1, L24_1, L25_1, L26_1)
L21_1 = _ENV
L22_1 = "menu"
L21_1 = L21_1[L22_1]
L22_1 = "toggle_loop"
L21_1 = L21_1[L22_1]
L22_1 = _ENV
L23_1 = "tp_world"
L22_1 = L22_1[L23_1]
L23_1 = "自动传送到任务点"
L24_1 = {}
L25_1 = ""
function L26_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = HUD
  L0_2 = L0_2.DOES_BLIP_EXIST
  L1_2 = HUD
  L1_2 = L1_2.GET_FIRST_BLIP_INFO_ID
  L2_2 = 1
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2)
  if L0_2 then
    L0_2 = HUD
    L0_2 = L0_2.GET_BLIP_COORDS
    L1_2 = HUD
    L1_2 = L1_2.GET_FIRST_BLIP_INFO_ID
    L2_2 = 1
    L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
    L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2)
    L1_2 = teleport
    L2_2 = L0_2.x
    L3_2 = L0_2.y
    L4_2 = L0_2.z
    L1_2(L2_2, L3_2, L4_2)
  end
end
L21_1(L22_1, L23_1, L24_1, L25_1, L26_1)
L21_1 = _ENV
L22_1 = "save_pos"
L23_1 = _ENV
L24_1 = "menu"
L23_1 = L23_1[L24_1]
L24_1 = "list"
L23_1 = L23_1[L24_1]
L24_1 = _ENV
L25_1 = "tp_world"
L24_1 = L24_1[L25_1]
L25_1 = "保存坐标传送"
L26_1 = {}
L27_1 = ""
L23_1 = L23_1(L24_1, L25_1, L26_1, L27_1)
L21_1[L22_1] = L23_1
L21_1 = {}
L22_1 = {}
L23_1 = _ENV
L24_1 = "menu"
L23_1 = L23_1[L24_1]
L24_1 = "action"
L23_1 = L23_1[L24_1]
L24_1 = _ENV
L25_1 = "save_pos"
L24_1 = L24_1[L25_1]
L25_1 = "保存当前坐标"
L26_1 = {}
L27_1 = "仅供临时使用"
function L28_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L0_2 = ENTITY
  L0_2 = L0_2.GET_ENTITY_COORDS
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L1_2 = L21_1
  L1_2 = #L1_2
  L2_2 = L1_2 + 1
  L1_2 = L21_1
  L1_2[L2_2] = L0_2
  L1_2 = L21_1
  L1_2 = #L1_2
  L2_2 = L22_1
  L3_2 = menu
  L3_2 = L3_2.textslider
  L4_2 = save_pos
  L5_2 = "坐标 "
  L6_2 = L1_2
  L5_2 = L5_2 .. L6_2
  L6_2 = {}
  L7_2 = ""
  L8_2 = {}
  L9_2 = "传送"
  L10_2 = "删除"
  L8_2[1] = L9_2
  L8_2[2] = L10_2
  function L9_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3
    if 1 == A0_3 then
      L1_3 = teleport
      L3_3 = L1_2
      L2_3 = L21_1
      L2_3 = L2_3[L3_3]
      L2_3 = L2_3.x
      L4_3 = L1_2
      L3_3 = L21_1
      L3_3 = L3_3[L4_3]
      L3_3 = L3_3.y
      L5_3 = L1_2
      L4_3 = L21_1
      L4_3 = L4_3[L5_3]
      L4_3 = L4_3.z
      L1_3(L2_3, L3_3, L4_3)
    elseif 2 == A0_3 then
      L1_3 = menu
      L1_3 = L1_3.delete
      L3_3 = L1_2
      L2_3 = L22_1
      L2_3 = L2_3[L3_3]
      L1_3(L2_3)
      L2_3 = L1_2
      L1_3 = L21_1
      L1_3[L2_3] = nil
    end
  end
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L2_2[L1_2] = L3_2
end
L23_1(L24_1, L25_1, L26_1, L27_1, L28_1)
L23_1 = _ENV
L24_1 = "TP_movement"
L25_1 = _ENV
L26_1 = "menu"
L25_1 = L25_1[L26_1]
L26_1 = "list"
L25_1 = L25_1[L26_1]
L26_1 = _ENV
L27_1 = "tp_world"
L26_1 = L26_1[L27_1]
L27_1 = "方向移动"
L28_1 = {}
L29_1 = ""
L25_1 = L25_1(L26_1, L27_1, L28_1, L29_1)
L23_1[L24_1] = L25_1
L23_1 = 1
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "action"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "TP_movement"
L25_1 = L25_1[L26_1]
L26_1 = "向前移动"
L27_1 = {}
L28_1 = "向前移动~个单位"
function L29_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = ENTITY
  L0_2 = L0_2.GET_ENTITY_COORDS
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_HEADING
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L2_2 = math
  L2_2 = L2_2.rad
  L3_2 = L1_2 - 180
  L3_2 = L3_2 * -1
  L2_2 = L2_2(L3_2)
  L1_2 = L2_2
  L2_2 = L0_2.x
  L3_2 = math
  L3_2 = L3_2.sin
  L4_2 = L1_2
  L3_2 = L3_2(L4_2)
  L4_2 = L23_1
  L4_2 = -L4_2
  L3_2 = L3_2 * L4_2
  L2_2 = L2_2 + L3_2
  L0_2.x = L2_2
  L2_2 = L0_2.y
  L3_2 = math
  L3_2 = L3_2.cos
  L4_2 = L1_2
  L3_2 = L3_2(L4_2)
  L4_2 = L23_1
  L4_2 = -L4_2
  L3_2 = L3_2 * L4_2
  L2_2 = L2_2 + L3_2
  L0_2.y = L2_2
  L2_2 = ENTITY
  L2_2 = L2_2.SET_ENTITY_COORDS_NO_OFFSET
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2 = L3_2()
  L4_2 = L0_2.x
  L5_2 = L0_2.y
  L6_2 = L0_2.z
  L7_2 = true
  L8_2 = false
  L9_2 = false
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1)
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "action"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "TP_movement"
L25_1 = L25_1[L26_1]
L26_1 = "向后移动"
L27_1 = {}
L28_1 = "向前移动~个单位"
function L29_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = ENTITY
  L0_2 = L0_2.GET_ENTITY_COORDS
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_HEADING
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L2_2 = math
  L2_2 = L2_2.rad
  L3_2 = L1_2 - 360
  L3_2 = L3_2 * -1
  L2_2 = L2_2(L3_2)
  L1_2 = L2_2
  L2_2 = L0_2.x
  L3_2 = math
  L3_2 = L3_2.sin
  L4_2 = L1_2
  L3_2 = L3_2(L4_2)
  L4_2 = L23_1
  L4_2 = -L4_2
  L3_2 = L3_2 * L4_2
  L2_2 = L2_2 + L3_2
  L0_2.x = L2_2
  L2_2 = L0_2.y
  L3_2 = math
  L3_2 = L3_2.cos
  L4_2 = L1_2
  L3_2 = L3_2(L4_2)
  L4_2 = L23_1
  L4_2 = -L4_2
  L3_2 = L3_2 * L4_2
  L2_2 = L2_2 + L3_2
  L0_2.y = L2_2
  L2_2 = ENTITY
  L2_2 = L2_2.SET_ENTITY_COORDS_NO_OFFSET
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2 = L3_2()
  L4_2 = L0_2.x
  L5_2 = L0_2.y
  L6_2 = L0_2.z
  L7_2 = true
  L8_2 = false
  L9_2 = false
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1)
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "action"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "TP_movement"
L25_1 = L25_1[L26_1]
L26_1 = "向左移动"
L27_1 = {}
L28_1 = "向前移动~个单位"
function L29_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = ENTITY
  L0_2 = L0_2.GET_ENTITY_COORDS
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_HEADING
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L2_2 = math
  L2_2 = L2_2.rad
  L3_2 = L1_2 - 90
  L3_2 = L3_2 * -1
  L2_2 = L2_2(L3_2)
  L1_2 = L2_2
  L2_2 = L0_2.x
  L3_2 = math
  L3_2 = L3_2.sin
  L4_2 = L1_2
  L3_2 = L3_2(L4_2)
  L4_2 = L23_1
  L4_2 = -L4_2
  L3_2 = L3_2 * L4_2
  L2_2 = L2_2 + L3_2
  L0_2.x = L2_2
  L2_2 = L0_2.y
  L3_2 = math
  L3_2 = L3_2.cos
  L4_2 = L1_2
  L3_2 = L3_2(L4_2)
  L4_2 = L23_1
  L4_2 = -L4_2
  L3_2 = L3_2 * L4_2
  L2_2 = L2_2 + L3_2
  L0_2.y = L2_2
  L2_2 = ENTITY
  L2_2 = L2_2.SET_ENTITY_COORDS_NO_OFFSET
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2 = L3_2()
  L4_2 = L0_2.x
  L5_2 = L0_2.y
  L6_2 = L0_2.z
  L7_2 = true
  L8_2 = false
  L9_2 = false
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1)
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "action"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "TP_movement"
L25_1 = L25_1[L26_1]
L26_1 = "向右移动"
L27_1 = {}
L28_1 = "向前移动~个单位"
function L29_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = ENTITY
  L0_2 = L0_2.GET_ENTITY_COORDS
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_HEADING
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L2_2 = math
  L2_2 = L2_2.rad
  L3_2 = L1_2 + 90
  L3_2 = L3_2 * -1
  L2_2 = L2_2(L3_2)
  L1_2 = L2_2
  L2_2 = L0_2.x
  L3_2 = math
  L3_2 = L3_2.sin
  L4_2 = L1_2
  L3_2 = L3_2(L4_2)
  L4_2 = L23_1
  L4_2 = -L4_2
  L3_2 = L3_2 * L4_2
  L2_2 = L2_2 + L3_2
  L0_2.x = L2_2
  L2_2 = L0_2.y
  L3_2 = math
  L3_2 = L3_2.cos
  L4_2 = L1_2
  L3_2 = L3_2(L4_2)
  L4_2 = L23_1
  L4_2 = -L4_2
  L3_2 = L3_2 * L4_2
  L2_2 = L2_2 + L3_2
  L0_2.y = L2_2
  L2_2 = ENTITY
  L2_2 = L2_2.SET_ENTITY_COORDS_NO_OFFSET
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2 = L3_2()
  L4_2 = L0_2.x
  L5_2 = L0_2.y
  L6_2 = L0_2.z
  L7_2 = true
  L8_2 = false
  L9_2 = false
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1)
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "action"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "TP_movement"
L25_1 = L25_1[L26_1]
L26_1 = "向上移动"
L27_1 = {}
L28_1 = "向前移动~个单位"
function L29_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = ENTITY
  L0_2 = L0_2.GET_ENTITY_COORDS
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  L1_2 = L0_2.z
  L2_2 = L23_1
  L1_2 = L1_2 + L2_2
  L0_2.z = L1_2
  L1_2 = ENTITY
  L1_2 = L1_2.SET_ENTITY_COORDS_NO_OFFSET
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = L0_2.x
  L4_2 = L0_2.y
  L5_2 = L0_2.z
  L6_2 = true
  L7_2 = false
  L8_2 = false
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1)
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "action"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "TP_movement"
L25_1 = L25_1[L26_1]
L26_1 = "向下移动"
L27_1 = {}
L28_1 = "向前移动~个单位"
function L29_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = ENTITY
  L0_2 = L0_2.GET_ENTITY_COORDS
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  L1_2 = L0_2.z
  L2_2 = L23_1
  L1_2 = L1_2 - L2_2
  L0_2.z = L1_2
  L1_2 = ENTITY
  L1_2 = L1_2.SET_ENTITY_COORDS_NO_OFFSET
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = L0_2.x
  L4_2 = L0_2.y
  L5_2 = L0_2.z
  L6_2 = true
  L7_2 = false
  L8_2 = false
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1)
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "slider"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "TP_movement"
L25_1 = L25_1[L26_1]
L26_1 = "移动距离"
L27_1 = {}
L28_1 = "向前传送的距离"
L29_1 = 1
L30_1 = 100
L31_1 = 1
L32_1 = 1
function L33_1(A0_2)
  local L1_2
  L23_1 = A0_2
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1)
L24_1 = _ENV
L25_1 = "Property_pos"
L26_1 = _ENV
L27_1 = "menu"
L26_1 = L26_1[L27_1]
L27_1 = "list"
L26_1 = L26_1[L27_1]
L27_1 = _ENV
L28_1 = "tp_world"
L27_1 = L27_1[L28_1]
L28_1 = "资产传送"
L29_1 = {}
L30_1 = ""
L26_1 = L26_1(L27_1, L28_1, L29_1, L30_1)
L24_1[L25_1] = L26_1
L24_1 = 1
L25_1 = _ENV
L26_1 = "ownedprops"
L25_1 = L25_1[L26_1]
L25_1 = #L25_1
L26_1 = 1
for L27_1 = L24_1, L25_1, L26_1 do
  L28_1 = _ENV
  L29_1 = "menu"
  L28_1 = L28_1[L29_1]
  L29_1 = "action"
  L28_1 = L28_1[L29_1]
  L29_1 = _ENV
  L30_1 = "Property_pos"
  L29_1 = L29_1[L30_1]
  L30_1 = _ENV
  L31_1 = "ownedprops"
  L30_1 = L30_1[L31_1]
  L30_1 = L30_1[L27_1]
  L30_1 = L30_1.name
  L31_1 = {}
  L32_1 = ""
  function L33_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
    L0_2 = HUD
    L0_2 = L0_2.GET_BLIP_COORDS
    L1_2 = HUD
    L1_2 = L1_2.GET_FIRST_BLIP_INFO_ID
    L2_2 = ownedprops
    L3_2 = L27_1
    L2_2 = L2_2[L3_2]
    L2_2 = L2_2.blid
    L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L1_2(L2_2)
    L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    L1_2 = L0_2.x
    if 0 == L1_2 then
      L1_2 = L0_2.y
      if 0 == L1_2 then
        L1_2 = L0_2.z
        if 0 == L1_2 then
          L1_2 = util
          L1_2 = L1_2.toast
          L2_2 = "未找到坐标"
          L1_2(L2_2)
      end
    end
    else
      L1_2 = ENTITY
      L1_2 = L1_2.SET_ENTITY_COORDS
      L2_2 = PLAYER
      L2_2 = L2_2.PLAYER_PED_ID
      L2_2 = L2_2()
      L3_2 = L0_2.x
      L4_2 = L0_2.y
      L5_2 = L0_2.z
      L6_2 = false
      L7_2 = false
      L8_2 = false
      L9_2 = false
      L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    end
  end
  L28_1(L29_1, L30_1, L31_1, L32_1, L33_1)
end
L24_1 = _ENV
L25_1 = "scene_place"
L26_1 = _ENV
L27_1 = "menu"
L26_1 = L26_1[L27_1]
L27_1 = "list"
L26_1 = L26_1[L27_1]
L27_1 = _ENV
L28_1 = "tp_world"
L27_1 = L27_1[L28_1]
L28_1 = "场景地点"
L29_1 = {}
L30_1 = ""
L26_1 = L26_1(L27_1, L28_1, L29_1, L30_1)
L24_1[L25_1] = L26_1
L24_1 = _ENV
L25_1 = "scene_tp"
L26_1 = _ENV
L27_1 = "menu"
L26_1 = L26_1[L27_1]
L27_1 = "list"
L26_1 = L26_1[L27_1]
L27_1 = _ENV
L28_1 = "scene_place"
L27_1 = L27_1[L28_1]
L28_1 = "场景"
L29_1 = {}
L30_1 = "故事模式场景区域"
L26_1 = L26_1(L27_1, L28_1, L29_1, L30_1)
L24_1[L25_1] = L26_1
L24_1 = _ENV
L25_1 = "pairs"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "interiors"
L25_1 = L25_1[L26_1]
L24_1, L25_1, L26_1, L27_1 = L24_1(L25_1)
for L28_1, L29_1 in L24_1, L25_1, L26_1, L27_1 do
  L30_1 = L29_1[1]
  L31_1 = L29_1[2]
  L32_1 = _ENV
  L33_1 = "menu"
  L32_1 = L32_1[L33_1]
  L33_1 = "action"
  L32_1 = L32_1[L33_1]
  L33_1 = _ENV
  L34_1 = "scene_tp"
  L33_1 = L33_1[L34_1]
  L34_1 = L30_1
  L35_1 = {}
  L36_1 = ""
  function L37_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
    L0_2 = menu
    L0_2 = L0_2.trigger_commands
    L1_2 = "doors on"
    L0_2(L1_2)
    L0_2 = menu
    L0_2 = L0_2.trigger_commands
    L1_2 = "nodeathbarriers on"
    L0_2(L1_2)
    L0_2 = ENTITY
    L0_2 = L0_2.SET_ENTITY_COORDS_NO_OFFSET
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_PED_ID
    L1_2 = L1_2()
    L2_2 = L31_1.x
    L3_2 = L31_1.y
    L4_2 = L31_1.z
    L5_2 = false
    L6_2 = false
    L7_2 = false
    L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
  end
  L32_1(L33_1, L34_1, L35_1, L36_1, L37_1)
end
L24_1 = _ENV
L25_1 = "IPL_tp"
L26_1 = _ENV
L27_1 = "menu"
L26_1 = L26_1[L27_1]
L27_1 = "list"
L26_1 = L26_1[L27_1]
L27_1 = _ENV
L28_1 = "scene_place"
L27_1 = L27_1[L28_1]
L28_1 = "IPL地点"
L29_1 = {}
L30_1 = ""
L26_1 = L26_1(L27_1, L28_1, L29_1, L30_1)
L24_1[L25_1] = L26_1
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "textslider"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "IPL_tp"
L25_1 = L25_1[L26_1]
L26_1 = "北杨克顿"
L27_1 = {}
L28_1 = ""
L29_1 = {}
L30_1 = "加载"
L31_1 = "卸载"
L29_1[1] = L30_1
L29_1[2] = L31_1
function L30_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = load_IPL
  L2_2 = North_Yankton
  L3_2 = 3360.1
  L4_2 = -4849.67
  L5_2 = 111.8
  L6_2 = A0_2
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1, L30_1)
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "textslider"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "IPL_tp"
L25_1 = L25_1[L26_1]
L26_1 = "UFO"
L27_1 = {}
L28_1 = ""
L29_1 = {}
L30_1 = "加载"
L31_1 = "卸载"
L29_1[1] = L30_1
L29_1[2] = L31_1
function L30_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = {}
  L2_2 = "UFO"
  L1_2[1] = L2_2
  L2_2 = load_IPL
  L3_2 = L1_2
  L4_2 = 2490.47729
  L5_2 = 3774.84351
  L6_2 = 2414.035
  L7_2 = A0_2
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1, L30_1)
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "textslider"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "IPL_tp"
L25_1 = L25_1[L26_1]
L26_1 = "堡垒UFO"
L27_1 = {}
L28_1 = ""
L29_1 = {}
L30_1 = "加载"
L31_1 = "卸载"
L29_1[1] = L30_1
L29_1[2] = L31_1
function L30_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = {}
  L2_2 = "UFO"
  L1_2[1] = L2_2
  L2_2 = load_IPL
  L3_2 = L1_2
  L4_2 = -2051.99463
  L5_2 = 3237.05835
  L6_2 = 1456.97021
  L7_2 = A0_2
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1, L30_1)
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "textslider"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "IPL_tp"
L25_1 = L25_1[L26_1]
L26_1 = "货船"
L27_1 = {}
L28_1 = ""
L29_1 = {}
L30_1 = "加载"
L31_1 = "卸载"
L29_1[1] = L30_1
L29_1[2] = L31_1
function L30_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = {}
  L2_2 = "cargoship"
  L1_2[1] = L2_2
  L2_2 = load_IPL
  L3_2 = L1_2
  L4_2 = -90.0
  L5_2 = -2365.8
  L6_2 = 14.3
  L7_2 = A0_2
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1, L30_1)
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "textslider"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "IPL_tp"
L25_1 = L25_1[L26_1]
L26_1 = "航空母舰"
L27_1 = {}
L28_1 = ""
L29_1 = {}
L30_1 = "加载"
L31_1 = "卸载"
L29_1[1] = L30_1
L29_1[2] = L31_1
function L30_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = {}
  L2_2 = "hei_carrier"
  L3_2 = "hei_carrier_DistantLights"
  L4_2 = "hei_Carrier_int1"
  L5_2 = "hei_Carrier_int2"
  L6_2 = "hei_Carrier_int3"
  L7_2 = "hei_Carrier_int4"
  L8_2 = "hei_Carrier_int5"
  L9_2 = "hei_Carrier_int6"
  L10_2 = "hei_carrier_LODLights"
  L1_2[1] = L2_2
  L1_2[2] = L3_2
  L1_2[3] = L4_2
  L1_2[4] = L5_2
  L1_2[5] = L6_2
  L1_2[6] = L7_2
  L1_2[7] = L8_2
  L1_2[8] = L9_2
  L1_2[9] = L10_2
  L2_2 = load_IPL
  L3_2 = L1_2
  L4_2 = 3016.46
  L5_2 = -4534.09
  L6_2 = 14.84
  L7_2 = A0_2
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1, L30_1)
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "textslider"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "IPL_tp"
L25_1 = L25_1[L26_1]
L26_1 = "失事的飞机"
L27_1 = {}
L28_1 = ""
L29_1 = {}
L30_1 = "加载"
L31_1 = "卸载"
L29_1[1] = L30_1
L29_1[2] = L31_1
function L30_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = {}
  L2_2 = "Plane_crash_trench"
  L1_2[1] = L2_2
  L2_2 = load_IPL
  L3_2 = L1_2
  L4_2 = 2814.7
  L5_2 = 4758.5
  L6_2 = 50.0
  L7_2 = A0_2
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1, L30_1)
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "textslider"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "IPL_tp"
L25_1 = L25_1[L26_1]
L26_1 = "色情游艇"
L27_1 = {}
L28_1 = ""
L29_1 = {}
L30_1 = "加载"
L31_1 = "卸载"
L29_1[1] = L30_1
L29_1[2] = L31_1
function L30_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = {}
  L2_2 = "smboat"
  L3_2 = "hei_yacht_heist"
  L4_2 = "hei_yacht_heist_Bar"
  L5_2 = "hei_yacht_heist_Bedrm"
  L6_2 = "hei_yacht_heist_Bridge"
  L7_2 = "hei_yacht_heist_DistantLights"
  L8_2 = "hei_yacht_heist_enginrm"
  L9_2 = "hei_yacht_heist_LODLights"
  L10_2 = "hei_yacht_heist_Lounge"
  L1_2[1] = L2_2
  L1_2[2] = L3_2
  L1_2[3] = L4_2
  L1_2[4] = L5_2
  L1_2[5] = L6_2
  L1_2[6] = L7_2
  L1_2[7] = L8_2
  L1_2[8] = L9_2
  L1_2[9] = L10_2
  L2_2 = load_IPL
  L3_2 = L1_2
  L4_2 = -2045.8
  L5_2 = -1031.2
  L6_2 = 11.9
  L7_2 = A0_2
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1, L30_1)
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "textslider"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "IPL_tp"
L25_1 = L25_1[L26_1]
L26_1 = "火车撞车"
L27_1 = {}
L28_1 = ""
L29_1 = {}
L30_1 = "加载"
L31_1 = "卸载"
L29_1[1] = L30_1
L29_1[2] = L31_1
function L30_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = {}
  L2_2 = "canyonriver01_traincrash"
  L3_2 = "railing_end"
  L1_2[1] = L2_2
  L1_2[2] = L3_2
  L2_2 = load_IPL
  L3_2 = L1_2
  L4_2 = -532.1309
  L5_2 = 4526.187
  L6_2 = 88.7955
  L7_2 = A0_2
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1, L30_1)
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "textslider"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "IPL_tp"
L25_1 = L25_1[L26_1]
L26_1 = "停尸房"
L27_1 = {}
L28_1 = ""
L29_1 = {}
L30_1 = "加载"
L31_1 = "卸载"
L29_1[1] = L30_1
L29_1[2] = L31_1
function L30_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = {}
  L2_2 = "Coroner_Int_on"
  L1_2[1] = L2_2
  L2_2 = load_IPL
  L3_2 = L1_2
  L4_2 = 244.9
  L5_2 = -1374.7
  L6_2 = 39.5
  L7_2 = A0_2
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1, L30_1)
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "textslider"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "IPL_tp"
L25_1 = L25_1[L26_1]
L26_1 = "被毁的医院"
L27_1 = {}
L28_1 = ""
L29_1 = {}
L30_1 = "加载"
L31_1 = "卸载"
L29_1[1] = L30_1
L29_1[2] = L31_1
function L30_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = {}
  L2_2 = "RC12B_Destroyed"
  L3_2 = "RC12B_HospitalInterior"
  L1_2[1] = L2_2
  L1_2[2] = L3_2
  L2_2 = load_IPL
  L3_2 = L1_2
  L4_2 = 356.8
  L5_2 = -590.1
  L6_2 = 43.3
  L7_2 = A0_2
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1, L30_1)
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "textslider"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "IPL_tp"
L25_1 = L25_1[L26_1]
L26_1 = "LifeInvader"
L27_1 = {}
L28_1 = ""
L29_1 = {}
L30_1 = "加载"
L31_1 = "卸载"
L29_1[1] = L30_1
L29_1[2] = L31_1
function L30_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = {}
  L2_2 = "facelobby"
  L3_2 = "facelobbyfake"
  L4_2 = "facelobbyfake"
  L1_2[1] = L2_2
  L1_2[2] = L3_2
  L1_2[3] = L4_2
  L2_2 = load_IPL
  L3_2 = L1_2
  L4_2 = -1082.77
  L5_2 = -258.67
  L6_2 = 37.76
  L7_2 = A0_2
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1, L30_1)
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "textslider"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "IPL_tp"
L25_1 = L25_1[L26_1]
L26_1 = "珠宝店"
L27_1 = {}
L28_1 = ""
L29_1 = {}
L30_1 = "加载"
L31_1 = "卸载"
L29_1[1] = L30_1
L29_1[2] = L31_1
function L30_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = {}
  L2_2 = "post_hiest_unload"
  L3_2 = "jewel2fake"
  L4_2 = "jewel2fake"
  L5_2 = "bh1_16_refurb"
  L1_2[1] = L2_2
  L1_2[2] = L3_2
  L1_2[3] = L4_2
  L1_2[4] = L5_2
  L2_2 = load_IPL
  L3_2 = L1_2
  L4_2 = -630.4
  L5_2 = -236.7
  L6_2 = 40.0
  L7_2 = A0_2
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1, L30_1)
L24_1 = _ENV
L25_1 = "pump_list"
L26_1 = _ENV
L27_1 = "menu"
L26_1 = L26_1[L27_1]
L27_1 = "list"
L26_1 = L26_1[L27_1]
L27_1 = _ENV
L28_1 = "scene_place"
L27_1 = L27_1[L28_1]
L28_1 = "南瓜"
L29_1 = {}
L30_1 = "万圣节南瓜头"
L26_1 = L26_1(L27_1, L28_1, L29_1, L30_1)
L24_1[L25_1] = L26_1
L24_1 = _ENV
L25_1 = "pairs"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "pumps_from_gtaweb_eu"
L25_1 = L25_1[L26_1]
L24_1, L25_1, L26_1, L27_1 = L24_1(L25_1)
for L28_1, L29_1 in L24_1, L25_1, L26_1, L27_1 do
  L30_1 = _ENV
  L31_1 = "pump_list"
  L30_1 = L30_1[L31_1]
  L32_1 = "action"
  L31_1 = L30_1
  L30_1 = L30_1[L32_1]
  L32_1 = "南瓜头 "
  L33_1 = L28_1
  L32_1 = L32_1 .. L33_1
  L33_1 = {}
  L34_1 = "传送到南瓜"
  function L35_1()
    local L0_2, L1_2, L2_2, L3_2
    L0_2 = teleport
    L1_2 = L29_1
    L1_2 = L1_2[1]
    L2_2 = L29_1
    L2_2 = L2_2[2]
    L3_2 = L29_1
    L3_2 = L3_2[3]
    L0_2(L1_2, L2_2, L3_2)
  end
  L30_1(L31_1, L32_1, L33_1, L34_1, L35_1)
end
L24_1 = _ENV
L25_1 = "slumber_askari"
L26_1 = _ENV
L27_1 = "menu"
L26_1 = L26_1[L27_1]
L27_1 = "list"
L26_1 = L26_1[L27_1]
L27_1 = _ENV
L28_1 = "scene_place"
L27_1 = L27_1[L28_1]
L28_1 = "沉睡的保安"
L29_1 = {}
L30_1 = ""
L26_1 = L26_1(L27_1, L28_1, L29_1, L30_1)
L24_1[L25_1] = L26_1
L24_1 = _ENV
L25_1 = "pairs"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "slumber_askari_list"
L25_1 = L25_1[L26_1]
L24_1, L25_1, L26_1, L27_1 = L24_1(L25_1)
for L28_1, L29_1 in L24_1, L25_1, L26_1, L27_1 do
  L30_1 = _ENV
  L31_1 = "slumber_askari"
  L30_1 = L30_1[L31_1]
  L32_1 = "action"
  L31_1 = L30_1
  L30_1 = L30_1[L32_1]
  L32_1 = "保安 "
  L33_1 = L28_1
  L32_1 = L32_1 .. L33_1
  L33_1 = {}
  L34_1 = "传送到保安"
  function L35_1()
    local L0_2, L1_2, L2_2, L3_2
    L0_2 = teleport
    L1_2 = L29_1.x
    L2_2 = L29_1.y
    L3_2 = L29_1.z
    L0_2(L1_2, L2_2, L3_2)
  end
  L30_1(L31_1, L32_1, L33_1, L34_1, L35_1)
end
L24_1 = _ENV
L25_1 = "ghost_exposure"
L26_1 = _ENV
L27_1 = "menu"
L26_1 = L26_1[L27_1]
L27_1 = "list"
L26_1 = L26_1[L27_1]
L27_1 = _ENV
L28_1 = "scene_place"
L27_1 = L27_1[L28_1]
L28_1 = "幽灵曝光"
L29_1 = {}
L30_1 = ""
L26_1 = L26_1(L27_1, L28_1, L29_1, L30_1)
L24_1[L25_1] = L26_1
L24_1 = _ENV
L25_1 = "pairs"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "ghost_exposure_list"
L25_1 = L25_1[L26_1]
L24_1, L25_1, L26_1, L27_1 = L24_1(L25_1)
for L28_1, L29_1 in L24_1, L25_1, L26_1, L27_1 do
  L30_1 = _ENV
  L31_1 = "ghost_exposure"
  L30_1 = L30_1[L31_1]
  L32_1 = "action"
  L31_1 = L30_1
  L30_1 = L30_1[L32_1]
  L32_1 = "幽灵 "
  L33_1 = L28_1
  L32_1 = L32_1 .. L33_1
  L33_1 = {}
  L34_1 = ""
  function L35_1()
    local L0_2, L1_2, L2_2, L3_2
    L0_2 = teleport
    L1_2 = L29_1
    L1_2 = L1_2[1]
    L2_2 = L29_1
    L2_2 = L2_2[2]
    L3_2 = L29_1
    L3_2 = L3_2[3]
    L0_2(L1_2, L2_2, L3_2)
  end
  L30_1(L31_1, L32_1, L33_1, L34_1, L35_1)
end
L24_1 = _ENV
L25_1 = "Halloween_UFO"
L26_1 = _ENV
L27_1 = "menu"
L26_1 = L26_1[L27_1]
L27_1 = "list"
L26_1 = L26_1[L27_1]
L27_1 = _ENV
L28_1 = "scene_place"
L27_1 = L27_1[L28_1]
L28_1 = "UFO"
L29_1 = {}
L30_1 = ""
L26_1 = L26_1(L27_1, L28_1, L29_1, L30_1)
L24_1[L25_1] = L26_1
L24_1 = _ENV
L25_1 = "pairs"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "Halloween_UFO_list"
L25_1 = L25_1[L26_1]
L24_1, L25_1, L26_1, L27_1 = L24_1(L25_1)
for L28_1, L29_1 in L24_1, L25_1, L26_1, L27_1 do
  L30_1 = _ENV
  L31_1 = "Halloween_UFO"
  L30_1 = L30_1[L31_1]
  L32_1 = "action"
  L31_1 = L30_1
  L30_1 = L30_1[L32_1]
  L32_1 = "UFO "
  L33_1 = L28_1
  L32_1 = L32_1 .. L33_1
  L33_1 = {}
  L34_1 = ""
  function L35_1()
    local L0_2, L1_2, L2_2, L3_2
    L0_2 = teleport
    L1_2 = L29_1
    L1_2 = L1_2[1]
    L2_2 = L29_1
    L2_2 = L2_2[2]
    L3_2 = L29_1
    L3_2 = L3_2[3]
    L0_2(L1_2, L2_2, L3_2)
  end
  L30_1(L31_1, L32_1, L33_1, L34_1, L35_1)
end
L24_1 = _ENV
L25_1 = "nuclear_waste"
L26_1 = _ENV
L27_1 = "menu"
L26_1 = L26_1[L27_1]
L27_1 = "list"
L26_1 = L26_1[L27_1]
L27_1 = _ENV
L28_1 = "scene_place"
L27_1 = L27_1[L28_1]
L28_1 = "核废料"
L29_1 = {}
L30_1 = ""
L26_1 = L26_1(L27_1, L28_1, L29_1, L30_1)
L24_1[L25_1] = L26_1
L24_1 = _ENV
L25_1 = "pairs"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "nuclear_waste_list"
L25_1 = L25_1[L26_1]
L24_1, L25_1, L26_1, L27_1 = L24_1(L25_1)
for L28_1, L29_1 in L24_1, L25_1, L26_1, L27_1 do
  L30_1 = _ENV
  L31_1 = "nuclear_waste"
  L30_1 = L30_1[L31_1]
  L32_1 = "action"
  L31_1 = L30_1
  L30_1 = L30_1[L32_1]
  L32_1 = "核废料 "
  L33_1 = L28_1
  L32_1 = L32_1 .. L33_1
  L33_1 = {}
  L34_1 = ""
  function L35_1()
    local L0_2, L1_2, L2_2, L3_2
    L0_2 = teleport
    L1_2 = L29_1
    L1_2 = L1_2[1]
    L2_2 = L29_1
    L2_2 = L2_2[2]
    L3_2 = L29_1
    L3_2 = L3_2[3]
    L0_2(L1_2, L2_2, L3_2)
  end
  L30_1(L31_1, L32_1, L33_1, L34_1, L35_1)
end
L24_1 = _ENV
L25_1 = "snow_loca"
L26_1 = _ENV
L27_1 = "menu"
L26_1 = L26_1[L27_1]
L27_1 = "list"
L26_1 = L26_1[L27_1]
L27_1 = _ENV
L28_1 = "scene_place"
L27_1 = L27_1[L28_1]
L28_1 = "雪人"
L29_1 = {}
L30_1 = ""
L26_1 = L26_1(L27_1, L28_1, L29_1, L30_1)
L24_1[L25_1] = L26_1
L24_1 = _ENV
L25_1 = "pairs"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "snowmens"
L25_1 = L25_1[L26_1]
L24_1, L25_1, L26_1, L27_1 = L24_1(L25_1)
for L28_1, L29_1 in L24_1, L25_1, L26_1, L27_1 do
  L30_1 = _ENV
  L31_1 = "snow_loca"
  L30_1 = L30_1[L31_1]
  L32_1 = "action"
  L31_1 = L30_1
  L30_1 = L30_1[L32_1]
  L32_1 = "雪人 "
  L33_1 = L28_1
  L32_1 = L32_1 .. L33_1
  L33_1 = {}
  L34_1 = "传送到圣诞节"
  function L35_1()
    local L0_2, L1_2, L2_2, L3_2
    L0_2 = teleport
    L1_2 = L29_1
    L1_2 = L1_2[1]
    L2_2 = L29_1
    L2_2 = L2_2[2]
    L3_2 = L29_1
    L3_2 = L3_2[3]
    L0_2(L1_2, L2_2, L3_2)
  end
  L30_1(L31_1, L32_1, L33_1, L34_1, L35_1)
end
L24_1 = _ENV
L25_1 = "revolver_loca"
L26_1 = _ENV
L27_1 = "menu"
L26_1 = L26_1[L27_1]
L27_1 = "list"
L26_1 = L26_1[L27_1]
L27_1 = _ENV
L28_1 = "scene_place"
L27_1 = L27_1[L28_1]
L28_1 = "左轮手枪"
L29_1 = {}
L30_1 = ""
L26_1 = L26_1(L27_1, L28_1, L29_1, L30_1)
L24_1[L25_1] = L26_1
L24_1 = _ENV
L25_1 = "pairs"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "revolver"
L25_1 = L25_1[L26_1]
L24_1, L25_1, L26_1, L27_1 = L24_1(L25_1)
for L28_1, L29_1 in L24_1, L25_1, L26_1, L27_1 do
  L30_1 = _ENV
  L31_1 = "revolver_loca"
  L30_1 = L30_1[L31_1]
  L32_1 = "action"
  L31_1 = L30_1
  L30_1 = L30_1[L32_1]
  L32_1 = "左轮 "
  L33_1 = L28_1
  L32_1 = L32_1 .. L33_1
  L33_1 = {}
  L34_1 = ""
  function L35_1()
    local L0_2, L1_2, L2_2, L3_2
    L0_2 = teleport
    L1_2 = L29_1
    L1_2 = L1_2[1]
    L2_2 = L29_1
    L2_2 = L2_2[2]
    L3_2 = L29_1
    L3_2 = L3_2[3]
    L0_2(L1_2, L2_2, L3_2)
  end
  L30_1(L31_1, L32_1, L33_1, L34_1, L35_1)
end
L24_1 = _ENV
L25_1 = "snow_loca"
L26_1 = _ENV
L27_1 = "menu"
L26_1 = L26_1[L27_1]
L27_1 = "list"
L26_1 = L26_1[L27_1]
L27_1 = _ENV
L28_1 = "scene_place"
L27_1 = L27_1[L28_1]
L28_1 = "武器厢型车购买"
L29_1 = {}
L30_1 = ""
L26_1 = L26_1(L27_1, L28_1, L29_1, L30_1)
L24_1[L25_1] = L26_1
L24_1 = _ENV
L25_1 = "pairs"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "weaponvan"
L25_1 = L25_1[L26_1]
L24_1, L25_1, L26_1, L27_1 = L24_1(L25_1)
for L28_1, L29_1 in L24_1, L25_1, L26_1, L27_1 do
  L30_1 = _ENV
  L31_1 = "snow_loca"
  L30_1 = L30_1[L31_1]
  L32_1 = "action"
  L31_1 = L30_1
  L30_1 = L30_1[L32_1]
  L32_1 = "厢型车 "
  L33_1 = L28_1
  L32_1 = L32_1 .. L33_1
  L33_1 = {}
  L34_1 = "传送到厢型车"
  function L35_1()
    local L0_2, L1_2, L2_2, L3_2
    L0_2 = teleport
    L1_2 = L29_1
    L1_2 = L1_2[1]
    L2_2 = L29_1
    L2_2 = L2_2[2]
    L3_2 = L29_1
    L3_2 = L3_2[3]
    L0_2(L1_2, L2_2, L3_2)
  end
  L30_1(L31_1, L32_1, L33_1, L34_1, L35_1)
end
L24_1 = _ENV
L25_1 = "figures_loca"
L26_1 = _ENV
L27_1 = "menu"
L26_1 = L26_1[L27_1]
L27_1 = "list"
L26_1 = L26_1[L27_1]
L27_1 = _ENV
L28_1 = "scene_place"
L27_1 = L27_1[L28_1]
L28_1 = "手办"
L29_1 = {}
L30_1 = ""
L26_1 = L26_1(L27_1, L28_1, L29_1, L30_1)
L24_1[L25_1] = L26_1
L24_1 = _ENV
L25_1 = "pairs"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "figures"
L25_1 = L25_1[L26_1]
L24_1, L25_1, L26_1, L27_1 = L24_1(L25_1)
for L28_1, L29_1 in L24_1, L25_1, L26_1, L27_1 do
  L30_1 = _ENV
  L31_1 = "figures_loca"
  L30_1 = L30_1[L31_1]
  L32_1 = "action"
  L31_1 = L30_1
  L30_1 = L30_1[L32_1]
  L32_1 = "手办 "
  L33_1 = L28_1
  L32_1 = L32_1 .. L33_1
  L33_1 = {}
  L34_1 = "传送到手办"
  function L35_1()
    local L0_2, L1_2, L2_2, L3_2
    L0_2 = teleport
    L1_2 = L29_1
    L1_2 = L1_2[1]
    L2_2 = L29_1
    L2_2 = L2_2[2]
    L3_2 = L29_1
    L3_2 = L3_2[3]
    L0_2(L1_2, L2_2, L3_2)
  end
  L30_1(L31_1, L32_1, L33_1, L34_1, L35_1)
end
L24_1 = _ENV
L25_1 = "jammers_loca"
L26_1 = _ENV
L27_1 = "menu"
L26_1 = L26_1[L27_1]
L27_1 = "list"
L26_1 = L26_1[L27_1]
L27_1 = _ENV
L28_1 = "scene_place"
L27_1 = L27_1[L28_1]
L28_1 = "信号干扰器"
L29_1 = {}
L30_1 = ""
L26_1 = L26_1(L27_1, L28_1, L29_1, L30_1)
L24_1[L25_1] = L26_1
L24_1 = _ENV
L25_1 = "pairs"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "jammers"
L25_1 = L25_1[L26_1]
L24_1, L25_1, L26_1, L27_1 = L24_1(L25_1)
for L28_1, L29_1 in L24_1, L25_1, L26_1, L27_1 do
  L30_1 = _ENV
  L31_1 = "jammers_loca"
  L30_1 = L30_1[L31_1]
  L32_1 = "action"
  L31_1 = L30_1
  L30_1 = L30_1[L32_1]
  L32_1 = "信号干扰器 "
  L33_1 = L28_1
  L32_1 = L32_1 .. L33_1
  L33_1 = {}
  L34_1 = "传送到信号干扰器"
  function L35_1()
    local L0_2, L1_2, L2_2, L3_2
    L0_2 = teleport
    L1_2 = L29_1
    L1_2 = L1_2[1]
    L2_2 = L29_1
    L2_2 = L2_2[2]
    L3_2 = L29_1
    L3_2 = L3_2[3]
    L0_2(L1_2, L2_2, L3_2)
  end
  L30_1(L31_1, L32_1, L33_1, L34_1, L35_1)
end
L24_1 = _ENV
L25_1 = "movie_props"
L26_1 = _ENV
L27_1 = "menu"
L26_1 = L26_1[L27_1]
L27_1 = "list"
L26_1 = L26_1[L27_1]
L27_1 = _ENV
L28_1 = "scene_place"
L27_1 = L27_1[L28_1]
L28_1 = "电影道具"
L29_1 = {}
L30_1 = ""
L26_1 = L26_1(L27_1, L28_1, L29_1, L30_1)
L24_1[L25_1] = L26_1
L24_1 = _ENV
L25_1 = "pairs"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "movie_prop1"
L25_1 = L25_1[L26_1]
L24_1, L25_1, L26_1, L27_1 = L24_1(L25_1)
for L28_1, L29_1 in L24_1, L25_1, L26_1, L27_1 do
  L30_1 = _ENV
  L31_1 = "movie_props"
  L30_1 = L30_1[L31_1]
  L32_1 = "action"
  L31_1 = L30_1
  L30_1 = L30_1[L32_1]
  L32_1 = "电影道具 "
  L33_1 = L28_1
  L32_1 = L32_1 .. L33_1
  L33_1 = {}
  L34_1 = "传送到电影道具"
  function L35_1()
    local L0_2, L1_2, L2_2, L3_2
    L0_2 = teleport
    L1_2 = L29_1
    L1_2 = L1_2[1]
    L2_2 = L29_1
    L2_2 = L2_2[2]
    L3_2 = L29_1
    L3_2 = L3_2[3]
    L0_2(L1_2, L2_2, L3_2)
  end
  L30_1(L31_1, L32_1, L33_1, L34_1, L35_1)
end
L24_1 = _ENV
L25_1 = "workshop_products"
L26_1 = _ENV
L27_1 = "menu"
L26_1 = L26_1[L27_1]
L27_1 = "list"
L26_1 = L26_1[L27_1]
L27_1 = _ENV
L28_1 = "scene_place"
L27_1 = L27_1[L28_1]
L28_1 = "拉玛有机作坊产品"
L29_1 = {}
L30_1 = ""
L26_1 = L26_1(L27_1, L28_1, L29_1, L30_1)
L24_1[L25_1] = L26_1
L24_1 = _ENV
L25_1 = "pairs"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "ld_product"
L25_1 = L25_1[L26_1]
L24_1, L25_1, L26_1, L27_1 = L24_1(L25_1)
for L28_1, L29_1 in L24_1, L25_1, L26_1, L27_1 do
  L30_1 = _ENV
  L31_1 = "workshop_products"
  L30_1 = L30_1[L31_1]
  L32_1 = "action"
  L31_1 = L30_1
  L30_1 = L30_1[L32_1]
  L32_1 = "产品 "
  L33_1 = L28_1
  L32_1 = L32_1 .. L33_1
  L33_1 = {}
  L34_1 = "传送到产品"
  function L35_1()
    local L0_2, L1_2, L2_2, L3_2
    L0_2 = teleport
    L1_2 = L29_1
    L1_2 = L1_2[1]
    L2_2 = L29_1
    L2_2 = L2_2[2]
    L3_2 = L29_1
    L3_2 = L3_2[3]
    L0_2(L1_2, L2_2, L3_2)
  end
  L30_1(L31_1, L32_1, L33_1, L34_1, L35_1)
end
L24_1 = _ENV
L25_1 = "tp_card"
L26_1 = _ENV
L27_1 = "menu"
L26_1 = L26_1[L27_1]
L27_1 = "list"
L26_1 = L26_1[L27_1]
L27_1 = _ENV
L28_1 = "scene_place"
L27_1 = L27_1[L28_1]
L28_1 = "纸牌"
L29_1 = {}
L30_1 = ""
L26_1 = L26_1(L27_1, L28_1, L29_1, L30_1)
L24_1[L25_1] = L26_1
L24_1 = _ENV
L25_1 = "pairs"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "cards1"
L25_1 = L25_1[L26_1]
L24_1, L25_1, L26_1, L27_1 = L24_1(L25_1)
for L28_1, L29_1 in L24_1, L25_1, L26_1, L27_1 do
  L30_1 = _ENV
  L31_1 = "tp_card"
  L30_1 = L30_1[L31_1]
  L32_1 = "action"
  L31_1 = L30_1
  L30_1 = L30_1[L32_1]
  L32_1 = "纸牌 "
  L33_1 = L28_1
  L32_1 = L32_1 .. L33_1
  L33_1 = {}
  L34_1 = "传送到纸牌"
  function L35_1()
    local L0_2, L1_2, L2_2, L3_2
    L0_2 = teleport
    L1_2 = L29_1
    L1_2 = L1_2[1]
    L2_2 = L29_1
    L2_2 = L2_2[2]
    L3_2 = L29_1
    L3_2 = L3_2[3]
    L0_2(L1_2, L2_2, L3_2)
  end
  L30_1(L31_1, L32_1, L33_1, L34_1, L35_1)
end
L24_1 = _ENV
L25_1 = "tp_address"
L26_1 = _ENV
L27_1 = "menu"
L26_1 = L26_1[L27_1]
L27_1 = "list"
L26_1 = L26_1[L27_1]
L27_1 = _ENV
L28_1 = "tp_world"
L27_1 = L27_1[L28_1]
L28_1 = "地点传送"
L29_1 = {}
L30_1 = ""
L26_1 = L26_1(L27_1, L28_1, L29_1, L30_1)
L24_1[L25_1] = L26_1
L24_1 = 1
L25_1 = _ENV
L26_1 = "address_pos"
L25_1 = L25_1[L26_1]
L25_1 = #L25_1
L26_1 = 1
for L27_1 = L24_1, L25_1, L26_1 do
  L28_1 = _ENV
  L29_1 = "menu"
  L28_1 = L28_1[L29_1]
  L29_1 = "action"
  L28_1 = L28_1[L29_1]
  L29_1 = _ENV
  L30_1 = "tp_address"
  L29_1 = L29_1[L30_1]
  L30_1 = _ENV
  L31_1 = "address_pos"
  L30_1 = L30_1[L31_1]
  L30_1 = L30_1[L27_1]
  L31_1 = "Name"
  L30_1 = L30_1[L31_1]
  L31_1 = {}
  L32_1 = ""
  function L33_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2
    L0_2 = teleport
    L1_2 = address_pos
    L2_2 = L27_1
    L1_2 = L1_2[L2_2]
    L1_2 = L1_2.x
    L2_2 = address_pos
    L3_2 = L27_1
    L2_2 = L2_2[L3_2]
    L2_2 = L2_2.y
    L3_2 = address_pos
    L4_2 = L27_1
    L3_2 = L3_2[L4_2]
    L3_2 = L3_2.z
    L0_2(L1_2, L2_2, L3_2)
  end
  L28_1(L29_1, L30_1, L31_1, L32_1, L33_1)
end
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "toggle_loop"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "worldlist"
L25_1 = L25_1[L26_1]
L26_1 = "反向驾驶"
L27_1 = {}
L28_1 = "强制所有NPC反向行驶"
function L29_1()
  local L0_2, L1_2
  L0_2 = force_npc_reverse_travel
  L0_2()
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1)
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "toggle"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "worldlist"
L25_1 = L25_1[L26_1]
L26_1 = "上帝视角"
L27_1 = {}
L28_1 = ""
function L29_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = god_cam
  L2_2 = A0_2
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_ID
  L3_2 = L3_2()
  L1_2(L2_2, L3_2)
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1)
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "slider"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "worldlist"
L25_1 = L25_1[L26_1]
L26_1 = "神奇的水坑"
L27_1 = {}
L28_1 = ""
L29_1 = 0
L30_1 = 10
L31_1 = 0
L32_1 = 1
function L33_1(A0_2)
  local L1_2, L2_2
  L1_2 = MISC
  L1_2 = L1_2.SET_RAIN
  L2_2 = A0_2
  L1_2(L2_2)
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1)
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "action"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "worldlist"
L25_1 = L25_1[L26_1]
L26_1 = "移除所有摄像头"
L27_1 = {}
L28_1 = ""
function L29_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L0_2 = pairs
  L1_2 = entities
  L1_2 = L1_2.get_all_objects_as_handles
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L1_2()
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = pairs
    L7_2 = CamList
    L6_2, L7_2, L8_2, L9_2 = L6_2(L7_2)
    for L10_2, L11_2 in L6_2, L7_2, L8_2, L9_2 do
      L12_2 = ENTITY
      L12_2 = L12_2.GET_ENTITY_MODEL
      L13_2 = L5_2
      L12_2 = L12_2(L13_2)
      if L12_2 == L11_2 then
        L12_2 = ENTITY
        L12_2 = L12_2.SET_ENTITY_AS_MISSION_ENTITY
        L13_2 = L5_2
        L14_2 = true
        L15_2 = true
        L12_2(L13_2, L14_2, L15_2)
        L12_2 = delete_entity
        L13_2 = L5_2
        L12_2(L13_2)
      end
    end
  end
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1)
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "toggle_loop"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "worldlist"
L25_1 = L25_1[L26_1]
L26_1 = "移除所有防空领域"
L27_1 = {}
L28_1 = ""
function L29_1()
  local L0_2, L1_2
  L0_2 = WEAPON
  L0_2 = L0_2.REMOVE_ALL_AIR_DEFENCE_SPHERES
  L0_2()
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1)
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "toggle_loop"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "worldlist"
L25_1 = L25_1[L26_1]
L26_1 = "水体漩涡"
L27_1 = {}
L28_1 = ""
function L29_1()
  local L0_2, L1_2
  L0_2 = water_vortex
  L0_2()
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1)
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "toggle"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "worldlist"
L25_1 = L25_1[L26_1]
L26_1 = "暂停世界"
L27_1 = {}
L28_1 = ""
function L29_1(A0_2)
  local L1_2, L2_2
  L1_2 = MISC
  L1_2 = L1_2.SET_GAME_PAUSED
  L2_2 = A0_2
  L1_2(L2_2)
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1)
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "action"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "worldlist"
L25_1 = L25_1[L26_1]
L26_1 = "导航至最近的加油站"
L27_1 = {}
L28_1 = ""
function L29_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = GetClosestGasStation
  L0_2 = L0_2()
  L1_2 = HUD
  L1_2 = L1_2.SET_NEW_WAYPOINT
  L2_2 = L0_2[1]
  L3_2 = L0_2[2]
  L1_2(L2_2, L3_2)
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1)
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "toggle_loop"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "worldlist"
L25_1 = L25_1[L26_1]
L26_1 = "同步时间"
L27_1 = {}
L28_1 = "目前仅适用于故事模式"
function L29_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L0_2 = os
  L0_2 = L0_2.date
  L1_2 = "%H"
  L0_2 = L0_2(L1_2)
  L1_2 = os
  L1_2 = L1_2.date
  L2_2 = "%M"
  L1_2 = L1_2(L2_2)
  L2_2 = os
  L2_2 = L2_2.date
  L3_2 = "%S"
  L2_2 = L2_2(L3_2)
  L3_2 = CLOCK
  L3_2 = L3_2.SET_CLOCK_TIME
  L4_2 = L0_2
  L5_2 = L1_2
  L6_2 = L2_2
  L3_2(L4_2, L5_2, L6_2)
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1)
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "toggle_loop"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "worldlist"
L25_1 = L25_1[L26_1]
L26_1 = "锁定游戏视角"
L27_1 = {}
L28_1 = ""
function L29_1()
  local L0_2, L1_2
  L0_2 = CAM
  L0_2 = L0_2.SET_GAMEPLAY_CAM_RELATIVE_HEADING
  L1_2 = 0
  L0_2(L1_2)
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1)
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "slider"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "worldlist"
L25_1 = L25_1[L26_1]
L26_1 = "设置时间刻度"
L27_1 = {}
L28_1 = ""
L29_1 = 0
L30_1 = 10
L31_1 = 10
L32_1 = 1
function L33_1(A0_2)
  local L1_2, L2_2
  L1_2 = MISC
  L1_2 = L1_2.SET_TIME_SCALE
  L2_2 = A0_2 / 10
  L1_2(L2_2)
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1)
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "slider"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "worldlist"
L25_1 = L25_1[L26_1]
L26_1 = "距离比例尺"
L27_1 = {}
L28_1 = ""
L29_1 = 0
L30_1 = 200
L31_1 = 1
L32_1 = 1
function L33_1(A0_2)
  local L1_2, L2_2
  L1_2 = override_lodscale
  L2_2 = A0_2
  L1_2(L2_2)
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1)
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "toggle_loop"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "worldlist"
L25_1 = L25_1[L26_1]
L26_1 = "绘制海拔"
L27_1 = {}
L28_1 = ""
function L29_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = ENTITY
  L0_2 = L0_2.GET_ENTITY_COORDS
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = true
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = "~b~ Elevation ~w~"
  L2_2 = math
  L2_2 = L2_2.ceil
  L3_2 = L0_2.z
  L2_2 = L2_2(L3_2)
  L2_2 = L2_2 / 1000
  L3_2 = "KM"
  L1_2 = L1_2 .. L2_2 .. L3_2
  L2_2 = draw_string
  L3_2 = L1_2
  L4_2 = 0.03
  L5_2 = 0.1
  L6_2 = 0.6
  L7_2 = 4
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1)
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "toggle_loop"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "worldlist"
L25_1 = L25_1[L26_1]
L26_1 = "绘制到导航点的距离"
L27_1 = {}
L28_1 = ""
function L29_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = HUD
  L0_2 = L0_2.IS_WAYPOINT_ACTIVE
  L0_2 = L0_2()
  if L0_2 then
    L0_2 = ENTITY
    L0_2 = L0_2.GET_ENTITY_COORDS
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_PED_ID
    L1_2 = L1_2()
    L2_2 = true
    L0_2 = L0_2(L1_2, L2_2)
    L1_2 = HUD
    L1_2 = L1_2.GET_BLIP_INFO_ID_COORD
    L2_2 = HUD
    L2_2 = L2_2.GET_FIRST_BLIP_INFO_ID
    L3_2 = HUD
    L3_2 = L3_2.GET_WAYPOINT_BLIP_ENUM_ID
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L3_2()
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    L2_2 = MISC
    L2_2 = L2_2.GET_DISTANCE_BETWEEN_COORDS
    L3_2 = L0_2.x
    L4_2 = L0_2.y
    L5_2 = 0
    L6_2 = L1_2.x
    L7_2 = L1_2.y
    L8_2 = 0
    L9_2 = true
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    L3_2 = "~b~ Distance ~w~"
    L4_2 = math
    L4_2 = L4_2.ceil
    L5_2 = L2_2
    L4_2 = L4_2(L5_2)
    L5_2 = " m"
    L3_2 = L3_2 .. L4_2 .. L5_2
    L4_2 = draw_string
    L5_2 = L3_2
    L6_2 = 0.03
    L7_2 = 0.15
    L8_2 = 0.6
    L9_2 = 4
    L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  else
    L0_2 = "~b~ Distance ~w~ -N-"
    L1_2 = draw_string
    L2_2 = L0_2
    L3_2 = 0.03
    L4_2 = 0.15
    L5_2 = 0.6
    L6_2 = 4
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
  end
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1)
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "toggle_loop"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "worldlist"
L25_1 = L25_1[L26_1]
L26_1 = "绘制游戏时间"
L27_1 = {}
L28_1 = ""
function L29_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L0_2 = CLOCK
  L0_2 = L0_2.GET_CLOCK_HOURS
  L0_2 = L0_2()
  L1_2 = CLOCK
  L1_2 = L1_2.GET_CLOCK_MINUTES
  L1_2 = L1_2()
  L2_2 = string
  L2_2 = L2_2.format
  L3_2 = "%02d"
  L4_2 = L0_2
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = string
  L3_2 = L3_2.format
  L4_2 = "%02d"
  L5_2 = L1_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = "~b~ Time ~w~"
  L5_2 = L2_2
  L6_2 = " : "
  L7_2 = L3_2
  L4_2 = L4_2 .. L5_2 .. L6_2 .. L7_2
  L5_2 = draw_string
  L6_2 = L4_2
  L7_2 = 0.03
  L8_2 = 0.2
  L9_2 = 0.6
  L10_2 = 4
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1)
L24_1 = _ENV
L25_1 = "cus_respawn"
L26_1 = _ENV
L27_1 = "menu"
L26_1 = L26_1[L27_1]
L27_1 = "list"
L26_1 = L26_1[L27_1]
L27_1 = _ENV
L28_1 = "worldlist"
L27_1 = L27_1[L28_1]
L28_1 = "自定义复活位置"
L29_1 = {}
L30_1 = ""
L26_1 = L26_1(L27_1, L28_1, L29_1, L30_1)
L24_1[L25_1] = L26_1
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "toggle_loop"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "cus_respawn"
L25_1 = L25_1[L26_1]
L26_1 = "开启"
L27_1 = {}
L28_1 = "设置你死后重生的位置"
function L29_1()
  local L0_2, L1_2
  L0_2 = custom_respawn
  L0_2()
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1)
L24_1 = _ENV
L25_1 = "custom_respawn_location"
L26_1 = _ENV
L27_1 = "menu"
L26_1 = L26_1[L27_1]
L27_1 = "action"
L26_1 = L26_1[L27_1]
L27_1 = _ENV
L28_1 = "cus_respawn"
L27_1 = L27_1[L28_1]
L28_1 = "保存位置"
L29_1 = {}
L30_1 = "未设置位置"
function L31_1()
  local L0_2, L1_2
  L0_2 = save_custom_respawn
  L0_2()
end
L26_1 = L26_1(L27_1, L28_1, L29_1, L30_1, L31_1)
L24_1[L25_1] = L26_1
L24_1 = _ENV
L25_1 = "world_veh"
L26_1 = _ENV
L27_1 = "menu"
L26_1 = L26_1[L27_1]
L27_1 = "list"
L26_1 = L26_1[L27_1]
L27_1 = _ENV
L28_1 = "worldlist"
L27_1 = L27_1[L28_1]
L28_1 = "世界载具"
L29_1 = {}
L30_1 = ""
L26_1 = L26_1(L27_1, L28_1, L29_1, L30_1)
L24_1[L25_1] = L26_1
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "toggle_loop"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "world_veh"
L25_1 = L25_1[L26_1]
L26_1 = "彩虹渐变所有载具"
L27_1 = {}
L28_1 = ""
function L29_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L0_2 = pairs
  L1_2 = entities
  L1_2 = L1_2.get_all_vehicles_as_handles
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L1_2()
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = VEHICLE
    L6_2 = L6_2.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR
    L7_2 = L5_2
    L8_2 = math
    L8_2 = L8_2.random
    L9_2 = 0
    L10_2 = 255
    L8_2 = L8_2(L9_2, L10_2)
    L9_2 = math
    L9_2 = L9_2.random
    L10_2 = 0
    L11_2 = 255
    L9_2 = L9_2(L10_2, L11_2)
    L10_2 = math
    L10_2 = L10_2.random
    L11_2 = 0
    L12_2 = 255
    L10_2, L11_2, L12_2 = L10_2(L11_2, L12_2)
    L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
    L6_2 = VEHICLE
    L6_2 = L6_2.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR
    L7_2 = L5_2
    L8_2 = math
    L8_2 = L8_2.random
    L9_2 = 0
    L10_2 = 255
    L8_2 = L8_2(L9_2, L10_2)
    L9_2 = math
    L9_2 = L9_2.random
    L10_2 = 0
    L11_2 = 255
    L9_2 = L9_2(L10_2, L11_2)
    L10_2 = math
    L10_2 = L10_2.random
    L11_2 = 0
    L12_2 = 255
    L10_2, L11_2, L12_2 = L10_2(L11_2, L12_2)
    L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
    L6_2 = VEHICLE
    L6_2 = L6_2.SET_VEHICLE_XENON_LIGHT_COLOR_INDEX
    L7_2 = L5_2
    L8_2 = math
    L8_2 = L8_2.random
    L9_2 = 0
    L10_2 = 255
    L8_2 = L8_2(L9_2, L10_2)
    L9_2 = math
    L9_2 = L9_2.random
    L10_2 = 0
    L11_2 = 255
    L9_2 = L9_2(L10_2, L11_2)
    L10_2 = math
    L10_2 = L10_2.random
    L11_2 = 0
    L12_2 = 255
    L10_2, L11_2, L12_2 = L10_2(L11_2, L12_2)
    L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  end
  L0_2 = util
  L0_2 = L0_2.yield
  L1_2 = 100
  L0_2(L1_2)
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1)
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "toggle_loop"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "world_veh"
L25_1 = L25_1[L26_1]
L26_1 = "爆炸所有载具"
L27_1 = {}
L28_1 = ""
function L29_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L0_2 = PED
  L0_2 = L0_2.GET_VEHICLE_PED_IS_IN
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = true
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = pairs
  L2_2 = entities
  L2_2 = L2_2.get_all_vehicles_as_handles
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2()
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    if L6_2 ~= L0_2 then
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
      L12_2 = 0
      L13_2 = 1
      L14_2 = true
      L15_2 = false
      L16_2 = 0
      L17_2 = false
      L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
    end
  end
  L1_2 = util
  L1_2 = L1_2.yield
  L2_2 = 100
  L1_2(L2_2)
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1)
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "toggle_loop"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "world_veh"
L25_1 = L25_1[L26_1]
L26_1 = "冻结所有载具"
L27_1 = {}
L28_1 = ""
function L29_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = PED
  L0_2 = L0_2.GET_VEHICLE_PED_IS_IN
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = true
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = pairs
  L2_2 = entities
  L2_2 = L2_2.get_all_vehicles_as_handles
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L2_2()
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    if L6_2 ~= L0_2 then
      L7_2 = ENTITY
      L7_2 = L7_2.FREEZE_ENTITY_POSITION
      L8_2 = L6_2
      L9_2 = true
      L7_2(L8_2, L9_2)
    end
  end
end
function L30_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = entities
  L0_2 = L0_2.get_all_vehicles_as_handles
  L0_2 = L0_2()
  L1_2 = pairs
  L2_2 = entities
  L2_2 = L2_2.get_all_vehicles_as_handles
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L2_2()
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = ENTITY
    L7_2 = L7_2.FREEZE_ENTITY_POSITION
    L8_2 = L6_2
    L9_2 = false
    L7_2(L8_2, L9_2)
  end
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1, L30_1)
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "toggle_loop"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "world_veh"
L25_1 = L25_1[L26_1]
L26_1 = "倒置所有载具"
L27_1 = {}
L28_1 = ""
function L29_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L0_2 = entities
  L0_2 = L0_2.get_all_vehicles_as_handles
  L0_2 = L0_2()
  L1_2 = PED
  L1_2 = L1_2.GET_VEHICLE_PED_IS_IN
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = true
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = pairs
  L3_2 = entities
  L3_2 = L3_2.get_all_vehicles_as_handles
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2 = L3_2()
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    if L7_2 ~= L1_2 then
      L8_2 = ENTITY
      L8_2 = L8_2.SET_ENTITY_ROTATION
      L9_2 = L7_2
      L10_2 = 0
      L11_2 = 180
      L12_2 = 0
      L13_2 = 1
      L14_2 = true
      L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    end
  end
end
function L30_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L0_2 = entities
  L0_2 = L0_2.get_all_vehicles_as_handles
  L0_2 = L0_2()
  L1_2 = PED
  L1_2 = L1_2.GET_VEHICLE_PED_IS_IN
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = true
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = pairs
  L3_2 = entities
  L3_2 = L3_2.get_all_vehicles_as_handles
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2 = L3_2()
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    if L7_2 ~= L1_2 then
      L8_2 = ENTITY
      L8_2 = L8_2.SET_ENTITY_ROTATION
      L9_2 = L7_2
      L10_2 = 0
      L11_2 = 0
      L12_2 = 0
      L13_2 = 1
      L14_2 = true
      L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    end
  end
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1, L30_1)
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "toggle_loop"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "world_veh"
L25_1 = L25_1[L26_1]
L26_1 = "世界跳跳车"
L27_1 = {}
L28_1 = ""
function L29_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  L0_2 = GET_NEARBY_VEHICLES
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2 = L1_2()
  L2_2 = 150
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = ipairs
  L2_2 = L0_2
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = request_control
    L8_2 = L6_2
    L7_2(L8_2)
    L7_2 = ENTITY
    L7_2 = L7_2.APPLY_FORCE_TO_ENTITY
    L8_2 = L6_2
    L9_2 = 1
    L10_2 = 0
    L11_2 = 0
    L12_2 = 6.5
    L13_2 = 0
    L14_2 = 0
    L15_2 = 0
    L16_2 = 0
    L17_2 = false
    L18_2 = false
    L19_2 = true
    L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
  end
  L1_2 = util
  L1_2 = L1_2.yield
  L2_2 = 1500
  L1_2(L2_2)
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1)
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "toggle_loop"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "world_veh"
L25_1 = L25_1[L26_1]
L26_1 = "喇叭轰炸"
L27_1 = {}
L28_1 = "使附近的所有车辆激活喇叭"
function L29_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L0_2 = AUDIO
  L0_2 = L0_2.SET_AGGRESSIVE_HORNS
  L1_2 = true
  L0_2(L1_2)
  L0_2 = pairs
  L1_2 = entities
  L1_2 = L1_2.get_all_vehicles_as_handles
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L1_2()
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = VEHICLE
    L6_2 = L6_2.START_VEHICLE_HORN
    L7_2 = L5_2
    L8_2 = 1000
    L9_2 = 0
    L10_2 = false
    L6_2(L7_2, L8_2, L9_2, L10_2)
  end
  L0_2 = util
  L0_2 = L0_2.yield
  L1_2 = 1000
  L0_2(L1_2)
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1)
L24_1 = _ENV
L25_1 = "menu"
L24_1 = L24_1[L25_1]
L25_1 = "toggle_loop"
L24_1 = L24_1[L25_1]
L25_1 = _ENV
L26_1 = "world_veh"
L25_1 = L25_1[L26_1]
L26_1 = "删除所有载具"
L27_1 = {}
L28_1 = ""
function L29_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L0_2 = players
  L0_2 = L0_2.get_position
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L1_2 = MISC
  L1_2 = L1_2.CLEAR_AREA_OF_VEHICLES
  L2_2 = L0_2.x
  L3_2 = L0_2.y
  L4_2 = L0_2.z
  L5_2 = 10000
  L6_2 = false
  L7_2 = false
  L8_2 = false
  L9_2 = false
  L10_2 = false
  L11_2 = false
  L12_2 = false
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L1_2 = util
  L1_2 = L1_2.yield
  L2_2 = 1000
  L1_2(L2_2)
end
L24_1(L25_1, L26_1, L27_1, L28_1, L29_1)
L24_1 = _ENV
L25_1 = "misclightmenu"
L26_1 = _ENV
L27_1 = "menu"
L26_1 = L26_1[L27_1]
L27_1 = "list"
L26_1 = L26_1[L27_1]
L27_1 = _ENV
L28_1 = "worldlist"
L27_1 = L27_1[L28_1]
L28_1 = "环境光"
L26_1 = L26_1(L27_1, L28_1)
L24_1[L25_1] = L26_1
L24_1 = 100
L25_1 = 100
L26_1 = _ENV
L27_1 = "menu"
L26_1 = L26_1[L27_1]
L27_1 = "toggle_loop"
L26_1 = L26_1[L27_1]
L27_1 = _ENV
L28_1 = "misclightmenu"
L27_1 = L27_1[L28_1]
L28_1 = "开启"
L29_1 = {}
L30_1 = ""
function L31_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = ENTITY
  L0_2 = L0_2.GET_ENTITY_COORDS
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L1_2 = GRAPHICS
  L1_2 = L1_2.DRAW_LIGHT_WITH_RANGE
  L2_2 = L0_2.x
  L3_2 = L0_2.y
  L4_2 = L0_2.z
  L5_2 = glow_color
  L5_2 = L5_2.r
  L6_2 = glow_color
  L6_2 = L6_2.g
  L7_2 = glow_color
  L7_2 = L7_2.b
  L8_2 = L24_1
  L9_2 = L25_1
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
end
L26_1(L27_1, L28_1, L29_1, L30_1, L31_1)
L26_1 = _ENV
L27_1 = "menu"
L26_1 = L26_1[L27_1]
L27_1 = "slider"
L26_1 = L26_1[L27_1]
L27_1 = _ENV
L28_1 = "misclightmenu"
L27_1 = L27_1[L28_1]
L28_1 = "设置半径"
L29_1 = {}
L30_1 = ""
L31_1 = 0
L32_1 = 200
L33_1 = 100
L34_1 = 5
function L35_1(A0_2)
  local L1_2
  L24_1 = A0_2
end
L26_1(L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1)
L26_1 = _ENV
L27_1 = "menu"
L26_1 = L26_1[L27_1]
L27_1 = "slider"
L26_1 = L26_1[L27_1]
L27_1 = _ENV
L28_1 = "misclightmenu"
L27_1 = L27_1[L28_1]
L28_1 = "设置强度"
L29_1 = {}
L30_1 = ""
L31_1 = 0
L32_1 = 200
L33_1 = 100
L34_1 = 5
function L35_1(A0_2)
  local L1_2
  L25_1 = A0_2
end
L26_1(L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1)
L26_1 = _ENV
L27_1 = "menu"
L26_1 = L26_1[L27_1]
L27_1 = "divider"
L26_1 = L26_1[L27_1]
L27_1 = _ENV
L28_1 = "misclightmenu"
L27_1 = L27_1[L28_1]
L28_1 = "颜色"
L26_1(L27_1, L28_1)
L26_1 = _ENV
L27_1 = "menu"
L26_1 = L26_1[L27_1]
L26_1 = L26_1.rainbow
L27_1 = _ENV
L28_1 = "menu"
L27_1 = L27_1[L28_1]
L27_1 = L27_1.colour
L28_1 = _ENV
L29_1 = "misclightmenu"
L28_1 = L28_1[L29_1]
L29_1 = "颜色"
L30_1 = {}
L31_1 = "glowcolour"
L30_1[1] = L31_1
L31_1 = ""
L32_1 = _ENV
L33_1 = "glow_color"
L32_1 = L32_1[L33_1]
L33_1 = false
function L34_1(A0_2)
  local L1_2
  glow_color = A0_2
end
L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1 = L27_1(L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1)
L26_1(L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1)
L26_1 = _ENV
L27_1 = "menu"
L26_1 = L26_1[L27_1]
L27_1 = "toggle_loop"
L26_1 = L26_1[L27_1]
L27_1 = _ENV
L28_1 = "worldlist"
L27_1 = L27_1[L28_1]
L28_1 = "红绿灯混乱"
L29_1 = {}
L30_1 = ""
function L31_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L0_2 = pairs
  L1_2 = entities
  L1_2 = L1_2.get_all_objects_as_handles
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L1_2()
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    if 1043035044 ~= L5_2 then
      L6_2 = 862871082
      if not L6_2 then
      end
    end
    L6_2 = ENTITY
    L6_2 = L6_2.SET_ENTITY_TRAFFICLIGHT_OVERRIDE
    L7_2 = L5_2
    L8_2 = math
    L8_2 = L8_2.random
    L9_2 = 0
    L10_2 = 2
    L8_2, L9_2, L10_2 = L8_2(L9_2, L10_2)
    L6_2(L7_2, L8_2, L9_2, L10_2)
  end
end
L26_1(L27_1, L28_1, L29_1, L30_1, L31_1)
L26_1 = _ENV
L27_1 = "menu"
L26_1 = L26_1[L27_1]
L27_1 = "list_select"
L26_1 = L26_1[L27_1]
L27_1 = _ENV
L28_1 = "worldlist"
L27_1 = L27_1[L28_1]
L28_1 = "世界重力"
L29_1 = {}
L30_1 = "改变世界的引力"
L31_1 = _ENV
L32_1 = "World_gravity_option"
L31_1 = L31_1[L32_1]
L32_1 = 1
function L33_1(A0_2)
  local L1_2, L2_2
  L1_2 = World_gravity
  L2_2 = A0_2
  L1_2(L2_2)
end
L26_1(L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1)
L26_1 = _ENV
L27_1 = "menu"
L26_1 = L26_1[L27_1]
L27_1 = "toggle_loop"
L26_1 = L26_1[L27_1]
L27_1 = _ENV
L28_1 = "worldlist"
L27_1 = L27_1[L28_1]
L28_1 = "世界混乱"
L29_1 = {}
L30_1 = "使附近的汽车进入哥布林-妖精模式"
function L31_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L0_2 = ipairs
  L1_2 = entities
  L1_2 = L1_2.get_all_vehicles_as_handles
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L1_2()
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = NETWORK
    L6_2 = L6_2.NETWORK_REQUEST_CONTROL_OF_ENTITY
    L7_2 = L5_2
    L6_2(L7_2)
    L6_2 = ENTITY
    L6_2 = L6_2.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
    L7_2 = L5_2
    L8_2 = 1
    L9_2 = 0.0
    L10_2 = 10.0
    L11_2 = 0.0
    L12_2 = true
    L13_2 = true
    L14_2 = true
    L15_2 = true
    L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  end
end
L26_1(L27_1, L28_1, L29_1, L30_1, L31_1)
L26_1 = _ENV
L27_1 = "menu"
L26_1 = L26_1[L27_1]
L27_1 = "toggle_loop"
L26_1 = L26_1[L27_1]
L27_1 = _ENV
L28_1 = "worldlist"
L27_1 = L27_1[L28_1]
L28_1 = "蹦床"
L29_1 = {}
L30_1 = "在水上蹦蹦乐"
function L31_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
  L0_2 = PED
  L0_2 = L0_2.IS_PED_IN_ANY_VEHICLE
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = false
  L0_2 = L0_2(L1_2, L2_2)
  if L0_2 then
    L0_2 = ENTITY
    L0_2 = L0_2.IS_ENTITY_IN_WATER
    L1_2 = entities
    L1_2 = L1_2.get_user_vehicle_as_handle
    L2_2 = false
    L1_2, L2_2, L3_2, L4_2, L5_2 = L1_2(L2_2)
    L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2)
    if L0_2 then
      L0_2 = v3
      L0_2 = L0_2.new
      L1_2 = ENTITY
      L1_2 = L1_2.GET_ENTITY_VELOCITY
      L2_2 = entities
      L2_2 = L2_2.get_user_vehicle_as_handle
      L3_2 = false
      L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
      L1_2, L2_2, L3_2, L4_2, L5_2 = L1_2(L2_2, L3_2, L4_2, L5_2)
      L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2)
      L1_2 = ENTITY
      L1_2 = L1_2.SET_ENTITY_VELOCITY
      L2_2 = entities
      L2_2 = L2_2.get_user_vehicle_as_handle
      L3_2 = false
      L2_2 = L2_2(L3_2)
      L3_2 = L0_2.x
      L4_2 = L0_2.y
      L5_2 = 15
      L1_2(L2_2, L3_2, L4_2, L5_2)
    end
  else
    L0_2 = ENTITY
    L0_2 = L0_2.IS_ENTITY_IN_WATER
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_PED_ID
    L1_2, L2_2, L3_2, L4_2, L5_2 = L1_2()
    L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2)
    if L0_2 then
      L0_2 = v3
      L0_2 = L0_2.new
      L1_2 = ENTITY
      L1_2 = L1_2.GET_ENTITY_VELOCITY
      L2_2 = entities
      L2_2 = L2_2.get_user_vehicle_as_handle
      L3_2 = false
      L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
      L1_2, L2_2, L3_2, L4_2, L5_2 = L1_2(L2_2, L3_2, L4_2, L5_2)
      L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2)
      L1_2 = ENTITY
      L1_2 = L1_2.SET_ENTITY_VELOCITY
      L2_2 = PLAYER
      L2_2 = L2_2.PLAYER_PED_ID
      L2_2 = L2_2()
      L3_2 = L0_2.x
      L4_2 = L0_2.y
      L5_2 = 15
      L1_2(L2_2, L3_2, L4_2, L5_2)
    end
  end
end
L26_1(L27_1, L28_1, L29_1, L30_1, L31_1)
L26_1 = _ENV
L27_1 = "menu"
L26_1 = L26_1[L27_1]
L27_1 = "action"
L26_1 = L26_1[L27_1]
L27_1 = _ENV
L28_1 = "worldlist"
L27_1 = L27_1[L28_1]
L28_1 = "爆炸动物"
L29_1 = {}
L30_1 = "炸毁所有附近的动物"
function L31_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  animalFound = false
  L0_2 = pairs
  L1_2 = entities
  L1_2 = L1_2.get_all_peds_as_handles
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2 = L1_2()
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = PED
    L6_2 = L6_2.IS_PED_HUMAN
    L7_2 = L5_2
    L6_2 = L6_2(L7_2)
    if true ~= L6_2 then
      animalFound = true
      L6_2 = ENTITY
      L6_2 = L6_2.GET_ENTITY_COORDS
      L7_2 = L5_2
      L6_2 = L6_2(L7_2)
      L7_2 = FIRE
      L7_2 = L7_2.ADD_EXPLOSION
      L8_2 = L6_2.x
      L9_2 = L6_2.y
      L10_2 = L6_2.z
      L11_2 = 0
      L12_2 = 1
      L13_2 = true
      L14_2 = false
      L15_2 = 0
      L16_2 = false
      L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
    end
  end
  L0_2 = animalFound
  if false == L0_2 then
    L0_2 = util
    L0_2 = L0_2.toast
    L1_2 = "附近没有动物"
    L0_2(L1_2)
  end
end
L26_1(L27_1, L28_1, L29_1, L30_1, L31_1)
L26_1 = _ENV
L27_1 = "phonefix"
L28_1 = _ENV
L29_1 = "menu"
L28_1 = L28_1[L29_1]
L29_1 = "list"
L28_1 = L28_1[L29_1]
L29_1 = _ENV
L30_1 = "worldlist"
L29_1 = L29_1[L30_1]
L30_1 = "电话修复"
L31_1 = {}
L32_1 = ""
L28_1 = L28_1(L29_1, L30_1, L31_1, L32_1)
L26_1[L27_1] = L28_1
L26_1 = _ENV
L27_1 = "menu"
L26_1 = L26_1[L27_1]
L27_1 = "toggle"
L26_1 = L26_1[L27_1]
L27_1 = _ENV
L28_1 = "phonefix"
L27_1 = L27_1[L28_1]
L28_1 = "开启"
L29_1 = {}
L30_1 = ""
function L31_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  if A0_2 then
    L1_2 = util
    L1_2 = L1_2.create_thread
    function L2_2()
      local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3
      while true do
        L0_3 = PAD
        L0_3 = L0_3.IS_CONTROL_JUST_PRESSED
        L1_3 = 0
        L2_3 = 27
        L0_3 = L0_3(L1_3, L2_3)
        if L0_3 then
          L0_3 = PLAYER
          L0_3 = L0_3.PLAYER_PED_ID
          L0_3 = L0_3()
          L1_3 = PED
          L1_3 = L1_3.SET_PED_CONFIG_FLAG
          L2_3 = L0_3
          L3_3 = 242
          L4_3 = false
          L1_3(L2_3, L3_3, L4_3)
          L1_3 = PED
          L1_3 = L1_3.SET_PED_CONFIG_FLAG
          L2_3 = L0_3
          L3_3 = 243
          L4_3 = false
          L1_3(L2_3, L3_3, L4_3)
          L1_3 = PED
          L1_3 = L1_3.SET_PED_CONFIG_FLAG
          L2_3 = L0_3
          L3_3 = 244
          L4_3 = false
          L1_3(L2_3, L3_3, L4_3)
          L1_3 = removePhoneGUI
          if L1_3 then
            L1_3 = util
            L1_3 = L1_3.yield
            L2_3 = 500
            L1_3(L2_3)
            L1_3 = v3
            L1_3 = L1_3.new
            L1_3 = L1_3()
            L2_3 = MOBILE
            L2_3 = L2_3.GET_MOBILE_PHONE_POSITION
            L3_3 = L1_3
            L2_3(L3_3)
            L2_3 = {}
            L3_3 = v3
            L3_3 = L3_3.getX
            L4_3 = L1_3
            L3_3 = L3_3(L4_3)
            L2_3.x = L3_3
            L3_3 = v3
            L3_3 = L3_3.getY
            L4_3 = L1_3
            L3_3 = L3_3(L4_3)
            L2_3.y = L3_3
            L3_3 = v3
            L3_3 = L3_3.getZ
            L4_3 = L1_3
            L3_3 = L3_3(L4_3)
            L2_3.z = L3_3
            L3_3 = MOBILE
            L3_3 = L3_3.SET_MOBILE_PHONE_POSITION
            L4_3 = L2_3.x
            L4_3 = L4_3 - 10000
            L5_3 = L2_3.y
            L6_3 = L2_3.z
            L3_3(L4_3, L5_3, L6_3)
          end
          L1_3 = util
          L1_3 = L1_3.yield
          L1_3()
        end
        L0_3 = util
        L0_3 = L0_3.yield
        L0_3()
      end
      L0_3 = util
      L0_3 = L0_3.yield
      L0_3()
    end
    L1_2(L2_2)
  else
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_PED_ID
    L1_2 = L1_2()
    L2_2 = PED
    L2_2 = L2_2.SET_PED_CONFIG_FLAG
    L3_2 = L1_2
    L4_2 = 242
    L5_2 = true
    L2_2(L3_2, L4_2, L5_2)
    L2_2 = PED
    L2_2 = L2_2.SET_PED_CONFIG_FLAG
    L3_2 = L1_2
    L4_2 = 243
    L5_2 = true
    L2_2(L3_2, L4_2, L5_2)
    L2_2 = PED
    L2_2 = L2_2.SET_PED_CONFIG_FLAG
    L3_2 = L1_2
    L4_2 = 244
    L5_2 = true
    L2_2(L3_2, L4_2, L5_2)
  end
end
L26_1(L27_1, L28_1, L29_1, L30_1, L31_1)
L26_1 = _ENV
L27_1 = "menu"
L26_1 = L26_1[L27_1]
L27_1 = "toggle"
L26_1 = L26_1[L27_1]
L27_1 = _ENV
L28_1 = "phonefix"
L27_1 = L27_1[L28_1]
L28_1 = "移除电话图形界面"
L29_1 = {}
L30_1 = ""
function L31_1(A0_2)
  local L1_2
  removePhoneGUI = A0_2
end
L26_1(L27_1, L28_1, L29_1, L30_1, L31_1)
L26_1 = _ENV
L27_1 = "Plot_health"
L28_1 = _ENV
L29_1 = "menu"
L28_1 = L28_1[L29_1]
L29_1 = "list"
L28_1 = L28_1[L29_1]
L29_1 = _ENV
L30_1 = "worldlist"
L29_1 = L29_1[L30_1]
L30_1 = "绘制血量条"
L31_1 = {}
L28_1 = L28_1(L29_1, L30_1, L31_1)
L26_1[L27_1] = L28_1
L26_1 = _ENV
L27_1 = "menu"
L26_1 = L26_1[L27_1]
L27_1 = "toggle_loop"
L26_1 = L26_1[L27_1]
L27_1 = _ENV
L28_1 = "Plot_health"
L27_1 = L27_1[L28_1]
L28_1 = "开启"
L29_1 = {}
L30_1 = ""
function L31_1()
  local L0_2, L1_2
  L0_2 = PedHealthBarmainLoop
  L0_2()
end
L26_1(L27_1, L28_1, L29_1, L30_1, L31_1)
L26_1 = _ENV
L27_1 = "menu"
L26_1 = L26_1[L27_1]
L27_1 = "list_select"
L26_1 = L26_1[L27_1]
L27_1 = _ENV
L28_1 = "Plot_health"
L27_1 = L27_1[L28_1]
L28_1 = "绘制方式"
L29_1 = {}
L30_1 = ""
L31_1 = _ENV
L32_1 = "drawoptions"
L31_1 = L31_1[L32_1]
L32_1 = 1
function L33_1(A0_2)
  local L1_2, L2_2
  L1_2 = ped_draw_method
  L2_2 = A0_2
  L1_2(L2_2)
end
L26_1(L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1)
L26_1 = _ENV
L27_1 = "menu"
L26_1 = L26_1[L27_1]
L27_1 = "toggle_loop"
L26_1 = L26_1[L27_1]
L27_1 = _ENV
L28_1 = "worldlist"
L27_1 = L27_1[L28_1]
L28_1 = "愤怒的飞机"
L29_1 = {}
L30_1 = ""
function L31_1()
  local L0_2, L1_2
  L0_2 = Angry_plane
  L0_2()
end
function L32_1()
  local L0_2, L1_2
  L0_2 = clear_Angry_plane
  L0_2()
end
L26_1(L27_1, L28_1, L29_1, L30_1, L31_1, L32_1)
L26_1 = _ENV
L27_1 = "ped_cash"
L28_1 = _ENV
L29_1 = "menu"
L28_1 = L28_1[L29_1]
L29_1 = "list"
L28_1 = L28_1[L29_1]
L29_1 = _ENV
L30_1 = "worldlist"
L29_1 = L29_1[L30_1]
L30_1 = "NPC金钱掉落"
L31_1 = {}
L28_1 = L28_1(L29_1, L30_1, L31_1)
L26_1[L27_1] = L28_1
L26_1 = _ENV
L27_1 = "PED"
L26_1 = L26_1[L27_1]
L27_1 = "SET_AMBIENT_PEDS_DROP_MONEY"
L26_1 = L26_1[L27_1]
L27_1 = true
L26_1(L27_1)
L26_1 = 520
L27_1 = _ENV
L28_1 = "menu"
L27_1 = L27_1[L28_1]
L28_1 = "slider"
L27_1 = L27_1[L28_1]
L28_1 = _ENV
L29_1 = "ped_cash"
L28_1 = L28_1[L29_1]
L29_1 = "修改金额"
L30_1 = {}
L31_1 = "pcfixed"
L30_1[1] = L31_1
L31_1 = "NPC现金掉落数量"
L32_1 = 1
L33_1 = 2000
L34_1 = 520
L35_1 = 1
function L36_1(A0_2)
  local L1_2
  L26_1 = A0_2
end
L27_1(L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1)
L27_1 = _ENV
L28_1 = "menu"
L27_1 = L27_1[L28_1]
L28_1 = "toggle_loop"
L27_1 = L27_1[L28_1]
L28_1 = _ENV
L29_1 = "ped_cash"
L28_1 = L28_1[L29_1]
L29_1 = "启用"
L30_1 = {}
L31_1 = "修改击杀NPC后可拾取的金钱数量"
function L32_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = entities
  L0_2 = L0_2.get_all_peds_as_handles
  L0_2 = L0_2()
  L1_2 = pairs
  L2_2 = L0_2
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = PED
    L7_2 = L7_2.SET_PED_MONEY
    L8_2 = L6_2
    L9_2 = L26_1
    L7_2(L8_2, L9_2)
  end
end
L27_1(L28_1, L29_1, L30_1, L31_1, L32_1)
L27_1 = _ENV
L28_1 = "custom_fireworks"
L29_1 = _ENV
L30_1 = "menu"
L29_1 = L29_1[L30_1]
L30_1 = "list"
L29_1 = L29_1[L30_1]
L30_1 = _ENV
L31_1 = "worldlist"
L30_1 = L30_1[L31_1]
L31_1 = "烟花"
L32_1 = {}
L29_1 = L29_1(L30_1, L31_1, L32_1)
L27_1[L28_1] = L29_1
L27_1 = _ENV
L28_1 = "menu"
L27_1 = L27_1[L28_1]
L28_1 = "action"
L27_1 = L27_1[L28_1]
L28_1 = _ENV
L29_1 = "custom_fireworks"
L28_1 = L28_1[L29_1]
L29_1 = "珍珠烟花"
L30_1 = {}
L31_1 = ""
function L32_1()
  local L0_2, L1_2
  L0_2 = Pearl_fireworks
  L0_2()
end
L27_1(L28_1, L29_1, L30_1, L31_1, L32_1)
L27_1 = _ENV
L28_1 = "fireworks_bucket"
L29_1 = _ENV
L30_1 = "menu"
L29_1 = L29_1[L30_1]
L30_1 = "list"
L29_1 = L29_1[L30_1]
L30_1 = _ENV
L31_1 = "custom_fireworks"
L30_1 = L30_1[L31_1]
L31_1 = "烟花桶"
L32_1 = {}
L33_1 = ""
L29_1 = L29_1(L30_1, L31_1, L32_1, L33_1)
L27_1[L28_1] = L29_1
L27_1 = _ENV
L28_1 = "menu"
L27_1 = L27_1[L28_1]
L28_1 = "action"
L27_1 = L27_1[L28_1]
L28_1 = _ENV
L29_1 = "fireworks_bucket"
L28_1 = L28_1[L29_1]
L29_1 = "安放烟花桶"
L30_1 = {}
L31_1 = ""
function L32_1()
  local L0_2, L1_2
  L0_2 = anfangyanhua
  L0_2()
end
L27_1(L28_1, L29_1, L30_1, L31_1, L32_1)
L27_1 = _ENV
L28_1 = "menu"
L27_1 = L27_1[L28_1]
L28_1 = "action"
L27_1 = L27_1[L28_1]
L28_1 = _ENV
L29_1 = "fireworks_bucket"
L28_1 = L28_1[L29_1]
L29_1 = "发射烟花"
L30_1 = {}
L31_1 = ""
function L32_1()
  local L0_2, L1_2
  L0_2 = yanhuafashe
  L0_2()
end
L27_1(L28_1, L29_1, L30_1, L31_1, L32_1)
L27_1 = _ENV
L28_1 = "menu"
L27_1 = L27_1[L28_1]
L28_1 = "toggle_loop"
L27_1 = L27_1[L28_1]
L28_1 = _ENV
L29_1 = "custom_fireworks"
L28_1 = L28_1[L29_1]
L29_1 = "满天烟花"
L30_1 = {}
L31_1 = ""
function L32_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = ENTITY
  L0_2 = L0_2.GET_ENTITY_COORDS
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = true
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = L0_2.x
  L2_2 = math
  L2_2 = L2_2.random
  L3_2 = -100
  L4_2 = 100
  L2_2 = L2_2(L3_2, L4_2)
  L1_2 = L1_2 + L2_2
  L0_2.x = L1_2
  L1_2 = L0_2.y
  L2_2 = math
  L2_2 = L2_2.random
  L3_2 = -100
  L4_2 = 100
  L2_2 = L2_2(L3_2, L4_2)
  L1_2 = L1_2 + L2_2
  L0_2.y = L1_2
  L1_2 = L0_2.z
  L2_2 = math
  L2_2 = L2_2.random
  L3_2 = 30
  L4_2 = 100
  L2_2 = L2_2(L3_2, L4_2)
  L1_2 = L1_2 + L2_2
  L0_2.z = L1_2
  L1_2 = FIRE
  L1_2 = L1_2.ADD_EXPLOSION
  L2_2 = L0_2.x
  L3_2 = L0_2.y
  L4_2 = L0_2.z
  L5_2 = 38
  L6_2 = 100.0
  L7_2 = true
  L8_2 = false
  L9_2 = 0.0
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L1_2 = util
  L1_2 = L1_2.yield
  L2_2 = 100
  L1_2(L2_2)
end
L27_1(L28_1, L29_1, L30_1, L31_1, L32_1)
L27_1 = _ENV
L28_1 = "menu"
L27_1 = L27_1[L28_1]
L28_1 = "toggle_loop"
L27_1 = L27_1[L28_1]
L28_1 = _ENV
L29_1 = "custom_fireworks"
L28_1 = L28_1[L29_1]
L29_1 = "大烟花"
L30_1 = {}
L31_1 = ""
function L32_1()
  local L0_2, L1_2
  L0_2 = big_fireworks
  L0_2()
end
L27_1(L28_1, L29_1, L30_1, L31_1, L32_1)
L27_1 = _ENV
L28_1 = "menu"
L27_1 = L27_1[L28_1]
L28_1 = "toggle_loop"
L27_1 = L27_1[L28_1]
L28_1 = _ENV
L29_1 = "custom_fireworks"
L28_1 = L28_1[L29_1]
L29_1 = "炫彩烟花"
L30_1 = {}
L31_1 = ""
function L32_1()
  local L0_2, L1_2
  L0_2 = new_firework
  L0_2()
end
L27_1(L28_1, L29_1, L30_1, L31_1, L32_1)
L27_1 = _ENV
L28_1 = "menu"
L27_1 = L27_1[L28_1]
L28_1 = "toggle_loop"
L27_1 = L27_1[L28_1]
L28_1 = _ENV
L29_1 = "custom_fireworks"
L28_1 = L28_1[L29_1]
L29_1 = "礼花桶"
L30_1 = {}
L31_1 = ""
function L32_1()
  local L0_2, L1_2
  L0_2 = new_firework2
  L0_2()
end
L27_1(L28_1, L29_1, L30_1, L31_1, L32_1)
L27_1 = _ENV
L28_1 = "menu"
L27_1 = L27_1[L28_1]
L28_1 = "toggle_loop"
L27_1 = L27_1[L28_1]
L28_1 = _ENV
L29_1 = "custom_fireworks"
L28_1 = L28_1[L29_1]
L29_1 = "头顶烟花"
L30_1 = {}
L31_1 = "抬头看看~"
function L32_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L0_2 = players
  L0_2 = L0_2.get_position
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED_SCRIPT_INDEX
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_ID
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  L2_2 = MISC
  L2_2 = L2_2.SHOOT_SINGLE_BULLET_BETWEEN_COORDS
  L3_2 = L0_2.x
  L4_2 = L0_2.y
  L5_2 = L0_2.z
  L5_2 = L5_2 + 1
  L6_2 = L0_2.x
  L7_2 = L0_2.y
  L8_2 = L0_2.z
  L8_2 = L8_2 + 10
  L9_2 = 1
  L10_2 = true
  L11_2 = 2138347493
  L12_2 = L1_2
  L13_2 = true
  L14_2 = false
  L15_2 = 50
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  L2_2 = util
  L2_2 = L2_2.yield
  L3_2 = 1500
  L2_2(L3_2)
end
L27_1(L28_1, L29_1, L30_1, L31_1, L32_1)
L27_1 = _ENV
L28_1 = "menu"
L27_1 = L27_1[L28_1]
L28_1 = "toggle"
L27_1 = L27_1[L28_1]
L28_1 = _ENV
L29_1 = "worldlist"
L28_1 = L28_1[L29_1]
L29_1 = "圣诞树"
L30_1 = {}
L31_1 = "面向目标按B可以移动目标位置"
function L32_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  if A0_2 then
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "godfinger on"
    L1_2(L2_2)
    L1_2 = ENTITY
    L1_2 = L1_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
    L2_2 = PLAYER
    L2_2 = L2_2.GET_PLAYER_PED
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_ID
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L3_2()
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
    L3_2 = 0
    L4_2 = 8
    L5_2 = -1
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2)
    L2_2 = util
    L2_2 = L2_2.joaat
    L3_2 = "prop_xmas_ext"
    L2_2 = L2_2(L3_2)
    L3_2 = request_model
    L4_2 = L2_2
    L3_2(L4_2)
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
    xmas_obj = L3_2
  else
    L1_2 = delete_entity
    L2_2 = xmas_obj
    L1_2(L2_2)
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "godfinger off"
    L1_2(L2_2)
  end
end
L27_1(L28_1, L29_1, L30_1, L31_1, L32_1)
L27_1 = _ENV
L28_1 = "menu"
L27_1 = L27_1[L28_1]
L28_1 = "toggle"
L27_1 = L27_1[L28_1]
L28_1 = _ENV
L29_1 = "worldlist"
L28_1 = L28_1[L29_1]
L29_1 = "小圣诞树"
L30_1 = {}
L31_1 = "面向目标按B可以移动目标位置"
function L32_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  if A0_2 then
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "godfinger on"
    L1_2(L2_2)
    L1_2 = ENTITY
    L1_2 = L1_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
    L2_2 = PLAYER
    L2_2 = L2_2.GET_PLAYER_PED
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_ID
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L3_2()
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
    L3_2 = 0
    L4_2 = 4
    L5_2 = -1
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2)
    L2_2 = util
    L2_2 = L2_2.joaat
    L3_2 = "prop_xmas_tree_int"
    L2_2 = L2_2(L3_2)
    L3_2 = request_model
    L4_2 = L2_2
    L3_2(L4_2)
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
    mas_obj = L3_2
  else
    L1_2 = delete_entity
    L2_2 = mas_obj
    L1_2(L2_2)
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "godfinger off"
    L1_2(L2_2)
  end
end
L27_1(L28_1, L29_1, L30_1, L31_1, L32_1)
L27_1 = _ENV
L28_1 = "weatherlist"
L29_1 = _ENV
L30_1 = "menu"
L29_1 = L29_1[L30_1]
L30_1 = "list"
L29_1 = L29_1[L30_1]
L30_1 = _ENV
L31_1 = "worldlist"
L30_1 = L30_1[L31_1]
L31_1 = "天气"
L32_1 = {}
L33_1 = ""
L29_1 = L29_1(L30_1, L31_1, L32_1, L33_1)
L27_1[L28_1] = L29_1
L27_1 = _ENV
L28_1 = "menu"
L27_1 = L27_1[L28_1]
L28_1 = "toggle"
L27_1 = L27_1[L28_1]
L28_1 = _ENV
L29_1 = "weatherlist"
L28_1 = L28_1[L29_1]
L29_1 = "禁用雾"
L30_1 = {}
L31_1 = ""
function L32_1(A0_2)
  local L1_2, L2_2
  L1_2 = disable_fog
  L2_2 = A0_2
  L1_2(L2_2)
end
L27_1(L28_1, L29_1, L30_1, L31_1, L32_1)
L27_1 = _ENV
L28_1 = "menu"
L27_1 = L27_1[L28_1]
L28_1 = "textslider"
L27_1 = L27_1[L28_1]
L28_1 = _ENV
L29_1 = "weatherlist"
L28_1 = L28_1[L29_1]
L29_1 = "设置天气"
L30_1 = {}
L31_1 = "仅本地更改"
L32_1 = _ENV
L33_1 = "weather_name"
L32_1 = L32_1[L33_1]
function L33_1(A0_2)
  local L1_2, L2_2
  L1_2 = MISC
  L1_2 = L1_2.SET_OVERRIDE_WEATHER
  L2_2 = weather_val
  L2_2 = L2_2[A0_2]
  L1_2(L2_2)
end
L27_1(L28_1, L29_1, L30_1, L31_1, L32_1, L33_1)
L27_1 = _ENV
L28_1 = "menu"
L27_1 = L27_1[L28_1]
L28_1 = "toggle_loop"
L27_1 = L27_1[L28_1]
L28_1 = _ENV
L29_1 = "weatherlist"
L28_1 = L28_1[L29_1]
L29_1 = "随机天气"
L30_1 = {}
L31_1 = ""
function L32_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = MISC
  L0_2 = L0_2.SET_OVERRIDE_WEATHER
  L1_2 = weather_val
  L2_2 = math
  L2_2 = L2_2.random
  L3_2 = 1
  L4_2 = 15
  L2_2 = L2_2(L3_2, L4_2)
  L1_2 = L1_2[L2_2]
  L0_2(L1_2)
end
L27_1(L28_1, L29_1, L30_1, L31_1, L32_1)
L27_1 = _ENV
L28_1 = "menu"
L27_1 = L27_1[L28_1]
L28_1 = "toggle_loop"
L27_1 = L27_1[L28_1]
L28_1 = _ENV
L29_1 = "weatherlist"
L28_1 = L28_1[L29_1]
L29_1 = "闪电生成"
L30_1 = {}
L31_1 = ""
function L32_1()
  local L0_2, L1_2
  L0_2 = MISC
  L0_2 = L0_2.FORCE_LIGHTNING_FLASH
  L0_2()
end
L27_1(L28_1, L29_1, L30_1, L31_1, L32_1)
L27_1 = _ENV
L28_1 = "menu"
L27_1 = L27_1[L28_1]
L28_1 = "toggle"
L27_1 = L27_1[L28_1]
L28_1 = _ENV
L29_1 = "weatherlist"
L28_1 = L28_1[L29_1]
L29_1 = "雪天"
L30_1 = {}
L31_1 = "仅本地更改"
function L32_1(A0_2)
  local L1_2, L2_2
  if A0_2 then
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "weather xmas"
    L1_2(L2_2)
  else
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "weather normal"
    L1_2(L2_2)
  end
end
L27_1(L28_1, L29_1, L30_1, L31_1, L32_1)
L27_1 = _ENV
L28_1 = "menu"
L27_1 = L27_1[L28_1]
L28_1 = "toggle_loop"
L27_1 = L27_1[L28_1]
L28_1 = _ENV
L29_1 = "weatherlist"
L28_1 = L28_1[L29_1]
L29_1 = "局部下雨"
L30_1 = {}
L31_1 = ""
function L32_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L0_2 = players
  L0_2 = L0_2.get_position
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L1_2 = request_ptfx_asset
  L2_2 = "core"
  L1_2(L2_2)
  L1_2 = GRAPHICS
  L1_2 = L1_2.USE_PARTICLE_FX_ASSET
  L2_2 = "core"
  L1_2(L2_2)
  L1_2 = GRAPHICS
  L2_2 = "START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD"
  L1_2 = L1_2[L2_2]
  L2_2 = "water_boat_exit"
  L3_2 = L0_2.x
  L4_2 = L0_2.y
  L5_2 = L0_2.z
  L5_2 = L5_2 + 5
  L6_2 = 0
  L7_2 = 0
  L8_2 = 0
  L9_2 = 2.5
  L10_2 = false
  L11_2 = false
  L12_2 = false
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
end
L27_1(L28_1, L29_1, L30_1, L31_1, L32_1)
L27_1 = _ENV
L28_1 = "menu"
L27_1 = L27_1[L28_1]
L28_1 = "toggle"
L27_1 = L27_1[L28_1]
L28_1 = _ENV
L29_1 = "worldlist"
L28_1 = L28_1[L29_1]
L29_1 = "土豆模式"
L30_1 = {}
L31_1 = "fpsnsboost"
L30_1[1] = L31_1
L31_1 = "提高FPS"
function L32_1(A0_2)
  local L1_2, L2_2, L3_2
  if A0_2 then
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "weather"
    L3_2 = " extrasunny"
    L2_2 = L2_2 .. L3_2
    L1_2(L2_2)
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "clouds"
    L3_2 = " clear01"
    L2_2 = L2_2 .. L3_2
    L1_2(L2_2)
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "potatomode "
    L1_2(L2_2)
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "nosky "
    L1_2(L2_2)
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "noidlecam "
    L1_2(L2_2)
  else
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "weather"
    L3_2 = " normal"
    L2_2 = L2_2 .. L3_2
    L1_2(L2_2)
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "clouds"
    L3_2 = " normal"
    L2_2 = L2_2 .. L3_2
    L1_2(L2_2)
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "potatomode "
    L1_2(L2_2)
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "nosky "
    L1_2(L2_2)
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "noidlecam "
    L1_2(L2_2)
  end
end
L27_1(L28_1, L29_1, L30_1, L31_1, L32_1)
L27_1 = _ENV
L28_1 = "menu"
L27_1 = L27_1[L28_1]
L28_1 = "toggle_loop"
L27_1 = L27_1[L28_1]
L28_1 = _ENV
L29_1 = "worldlist"
L28_1 = L28_1[L29_1]
L29_1 = "轰炸区"
L30_1 = {}
L31_1 = ""
function L32_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L0_2 = util
  L0_2 = L0_2.joaat
  L1_2 = "imp_prop_bomb_ball"
  L0_2 = L0_2(L1_2)
  L1_2 = request_model
  L2_2 = L0_2
  L1_2(L2_2)
  L1_2 = active_bowling_balls
  if L1_2 <= 15 then
    L1_2 = ENTITY
    L1_2 = L1_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = math
    L3_2 = L3_2.random
    L4_2 = -200
    L5_2 = 200
    L3_2 = L3_2(L4_2, L5_2)
    L4_2 = math
    L4_2 = L4_2.random
    L5_2 = -200
    L6_2 = 200
    L4_2 = L4_2(L5_2, L6_2)
    L5_2 = math
    L5_2 = L5_2.random
    L6_2 = 100
    L7_2 = 300
    L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L5_2(L6_2, L7_2)
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
    L2_2 = entities
    L2_2 = L2_2.create_object
    L3_2 = L0_2
    L4_2 = L1_2
    L2_2 = L2_2(L3_2, L4_2)
    L3_2 = ENTITY
    L3_2 = L3_2.FREEZE_ENTITY_POSITION
    L4_2 = L2_2
    L5_2 = false
    L3_2(L4_2, L5_2)
    L3_2 = ENTITY
    L3_2 = L3_2.SET_ENTITY_DYNAMIC
    L4_2 = L2_2
    L5_2 = true
    L3_2(L4_2, L5_2)
    L3_2 = ENTITY
    L3_2 = L3_2.APPLY_FORCE_TO_ENTITY
    L4_2 = L2_2
    L5_2 = 1
    L6_2 = math
    L6_2 = L6_2.random
    L7_2 = -300
    L8_2 = 300
    L6_2 = L6_2(L7_2, L8_2)
    L7_2 = math
    L7_2 = L7_2.random
    L8_2 = -300
    L9_2 = 300
    L7_2 = L7_2(L8_2, L9_2)
    L8_2 = -300
    L9_2 = 0
    L10_2 = 0
    L11_2 = 0
    L12_2 = 0
    L13_2 = true
    L14_2 = false
    L15_2 = true
    L16_2 = true
    L17_2 = true
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
    L3_2 = bomb_shower_tick_handler
    L4_2 = L2_2
    L3_2(L4_2)
  end
  L1_2 = util
  L1_2 = L1_2.yield
  L2_2 = 500
  L1_2(L2_2)
end
L27_1(L28_1, L29_1, L30_1, L31_1, L32_1)
L27_1 = _ENV
L28_1 = "train_list"
L29_1 = _ENV
L30_1 = "menu"
L29_1 = L29_1[L30_1]
L30_1 = "list"
L29_1 = L29_1[L30_1]
L30_1 = _ENV
L31_1 = "worldlist"
L30_1 = L30_1[L31_1]
L31_1 = "列车选项"
L32_1 = {}
L33_1 = ""
L29_1 = L29_1(L30_1, L31_1, L32_1, L33_1)
L27_1[L28_1] = L29_1
L27_1 = _ENV
L28_1 = "train_build"
L29_1 = _ENV
L30_1 = "menu"
L29_1 = L29_1[L30_1]
L30_1 = "list"
L29_1 = L29_1[L30_1]
L30_1 = _ENV
L31_1 = "train_list"
L30_1 = L30_1[L31_1]
L31_1 = "火车生成"
L32_1 = {}
L33_1 = "如附近未找到火车,可前往铁轨附近重新生成"
L29_1 = L29_1(L30_1, L31_1, L32_1, L33_1)
L27_1[L28_1] = L29_1
L27_1 = _ENV
L28_1 = "menu"
L27_1 = L27_1[L28_1]
L28_1 = "click_slider"
L27_1 = L27_1[L28_1]
L28_1 = _ENV
L29_1 = "train_build"
L28_1 = L28_1[L29_1]
L29_1 = "火车生成类型"
L30_1 = {}
L31_1 = "点击生成不同类型火车"
L32_1 = 1
L33_1 = 23
L34_1 = 1
L35_1 = 1
function L36_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_ID
  L2_2, L3_2, L4_2, L5_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = L1_2
  L4_2 = 1
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = spawn_train
  L4_2 = A0_2 - 1
  L5_2 = L2_2
  L3_2(L4_2, L5_2)
end
L27_1(L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1)
L27_1 = _ENV
L28_1 = "menu"
L27_1 = L27_1[L28_1]
L28_1 = "action"
L27_1 = L27_1[L28_1]
L28_1 = _ENV
L29_1 = "train_build"
L28_1 = L28_1[L29_1]
L29_1 = "生成地铁"
L30_1 = {}
L31_1 = ""
function L32_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = PLAYER
  L0_2 = L0_2.GET_PLAYER_PED
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2, L2_2, L3_2, L4_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2)
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_COORDS
  L2_2 = L0_2
  L3_2 = 1
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = spawn_train
  L3_2 = 21
  L4_2 = L1_2
  L2_2(L3_2, L4_2)
end
L27_1(L28_1, L29_1, L30_1, L31_1, L32_1)
L27_1 = _ENV
L28_1 = "menu"
L27_1 = L27_1[L28_1]
L28_1 = "action"
L27_1 = L27_1[L28_1]
L28_1 = _ENV
L29_1 = "train_build"
L28_1 = L28_1[L29_1]
L29_1 = "删除所有火车"
L30_1 = {}
L31_1 = ""
function L32_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = entities
  L0_2 = L0_2.get_all_vehicles_as_handles
  L0_2 = L0_2()
  L1_2 = pairs
  L2_2 = L0_2
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = delete_entity
    L8_2 = L6_2
    L7_2(L8_2)
  end
end
L27_1(L28_1, L29_1, L30_1, L31_1, L32_1)
L27_1 = _ENV
L28_1 = "menu"
L27_1 = L27_1[L28_1]
L28_1 = "action"
L27_1 = L27_1[L28_1]
L28_1 = _ENV
L29_1 = "train_list"
L28_1 = L28_1[L29_1]
L29_1 = "驾驶附近的火车"
L30_1 = {}
L31_1 = ""
function L32_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = get_closest_train
  L0_2 = L0_2()
  if 0 ~= L0_2 then
    L1_2 = delete_entity
    L2_2 = VEHICLE
    L2_2 = L2_2.GET_PED_IN_VEHICLE_SEAT
    L3_2 = L0_2
    L4_2 = -1
    L2_2, L3_2, L4_2 = L2_2(L3_2, L4_2)
    L1_2(L2_2, L3_2, L4_2)
    L1_2 = PED
    L1_2 = L1_2.SET_PED_INTO_VEHICLE
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = L0_2
    L4_2 = -1
    L1_2(L2_2, L3_2, L4_2)
    L1_2 = AUDIO
    L1_2 = L1_2.SET_VEHICLE_RADIO_ENABLED
    L2_2 = L0_2
    L3_2 = true
    L1_2(L2_2, L3_2)
  end
end
L27_1(L28_1, L29_1, L30_1, L31_1, L32_1)
L27_1 = _ENV
L28_1 = "set_train_speed"
L29_1 = _ENV
L30_1 = "menu"
L29_1 = L29_1[L30_1]
L30_1 = "list"
L29_1 = L29_1[L30_1]
L30_1 = _ENV
L31_1 = "train_list"
L30_1 = L30_1[L31_1]
L31_1 = "设置列车速度"
L32_1 = {}
L33_1 = ""
L29_1 = L29_1(L30_1, L31_1, L32_1, L33_1)
L27_1[L28_1] = L29_1
L27_1 = 15.277777777777777
L28_1 = _ENV
L29_1 = "menu"
L28_1 = L28_1[L29_1]
L29_1 = "toggle_loop"
L28_1 = L28_1[L29_1]
L29_1 = _ENV
L30_1 = "set_train_speed"
L29_1 = L29_1[L30_1]
L30_1 = "设置列车速度"
L31_1 = {}
L32_1 = ""
function L33_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = pairs
  L1_2 = entities
  L1_2 = L1_2.get_all_vehicles_as_pointers
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2 = L1_2()
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = entities
    L6_2 = L6_2.get_model_hash
    L7_2 = L5_2
    L6_2 = L6_2(L7_2)
    L7_2 = util
    L7_2 = L7_2.joaat
    L8_2 = "freight"
    L7_2 = L7_2(L8_2)
    if L6_2 == L7_2 then
      L6_2 = entities
      L6_2 = L6_2.pointer_to_handle
      L7_2 = L5_2
      L6_2 = L6_2(L7_2)
      train_hdl = L6_2
      L6_2 = request_control
      L7_2 = train_hdl
      L6_2(L7_2)
      L6_2 = VEHICLE
      L6_2 = L6_2.SET_TRAIN_SPEED
      L7_2 = train_hdl
      L8_2 = L27_1
      L6_2(L7_2, L8_2)
      L6_2 = VEHICLE
      L6_2 = L6_2.SET_TRAIN_CRUISE_SPEED
      L7_2 = train_hdl
      L8_2 = L27_1
      L6_2(L7_2, L8_2)
    end
  end
end
L28_1(L29_1, L30_1, L31_1, L32_1, L33_1)
L28_1 = _ENV
L29_1 = "menu"
L28_1 = L28_1[L29_1]
L29_1 = "slider"
L28_1 = L28_1[L29_1]
L29_1 = _ENV
L30_1 = "set_train_speed"
L29_1 = L29_1[L30_1]
L30_1 = "设置列车速度"
L31_1 = {}
L32_1 = ""
L33_1 = -100
L34_1 = 290
L35_1 = 55
L36_1 = 10
function L37_1(A0_2)
  local L1_2
  L1_2 = A0_2 / 3.6
  L27_1 = L1_2
end
L28_1(L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1)
L28_1 = _ENV
L29_1 = "menu"
L28_1 = L28_1[L29_1]
L29_1 = "action"
L28_1 = L28_1[L29_1]
L29_1 = _ENV
L30_1 = "train_list"
L29_1 = L29_1[L30_1]
L30_1 = "下车"
L31_1 = {}
L32_1 = ""
function L33_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = TASK
  L0_2 = L0_2.CLEAR_PED_TASKS_IMMEDIATELY
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2 = L1_2()
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = TASK
  L0_2 = L0_2.TASK_LEAVE_ANY_VEHICLE
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = 0
  L3_2 = 16
  L0_2(L1_2, L2_2, L3_2)
end
L28_1(L29_1, L30_1, L31_1, L32_1, L33_1)
L28_1 = _ENV
L29_1 = "menu"
L28_1 = L28_1[L29_1]
L29_1 = "toggle"
L28_1 = L28_1[L29_1]
L29_1 = _ENV
L30_1 = "train_list"
L29_1 = L29_1[L30_1]
L30_1 = "脱轨"
L31_1 = {}
L32_1 = ""
function L33_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = entities
  L1_2 = L1_2.get_all_vehicles_as_handles
  L1_2 = L1_2()
  L2_2 = pairs
  L3_2 = L1_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = VEHICLE
    L8_2 = L8_2.SET_RENDER_TRAIN_AS_DERAILED
    L9_2 = L7_2
    L10_2 = A0_2
    L8_2(L9_2, L10_2)
  end
end
L28_1(L29_1, L30_1, L31_1, L32_1, L33_1)
L28_1 = _ENV
L29_1 = "train_position"
L30_1 = _ENV
L31_1 = "menu"
L30_1 = L30_1[L31_1]
L31_1 = "list"
L30_1 = L30_1[L31_1]
L31_1 = _ENV
L32_1 = "train_list"
L31_1 = L31_1[L32_1]
L32_1 = "列车站点传送"
L33_1 = {}
L34_1 = ""
L30_1 = L30_1(L31_1, L32_1, L33_1, L34_1)
L28_1[L29_1] = L30_1
L28_1 = _ENV
L29_1 = "menu"
L28_1 = L28_1[L29_1]
L29_1 = "action"
L28_1 = L28_1[L29_1]
L29_1 = _ENV
L30_1 = "train_position"
L29_1 = L29_1[L30_1]
L30_1 = "大洋公路站点"
L31_1 = {}
L32_1 = ""
function L33_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = teleport
  L1_2 = -86
  L2_2 = 6198
  L3_2 = 31
  L0_2(L1_2, L2_2, L3_2)
end
L28_1(L29_1, L30_1, L31_1, L32_1, L33_1)
L28_1 = _ENV
L29_1 = "menu"
L28_1 = L28_1[L29_1]
L29_1 = "action"
L28_1 = L28_1[L29_1]
L29_1 = _ENV
L30_1 = "train_position"
L29_1 = L29_1[L30_1]
L30_1 = "维斯普奇大道站点"
L31_1 = {}
L32_1 = ""
function L33_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = teleport
  L1_2 = 674
  L2_2 = -1048
  L3_2 = 22
  L0_2(L1_2, L2_2, L3_2)
end
L28_1(L29_1, L30_1, L31_1, L32_1, L33_1)
L28_1 = _ENV
L29_1 = "hudminimapmenu"
L30_1 = _ENV
L31_1 = "menu"
L30_1 = L30_1[L31_1]
L31_1 = "list"
L30_1 = L30_1[L31_1]
L31_1 = _ENV
L32_1 = "worldlist"
L31_1 = L31_1[L32_1]
L32_1 = "小地图"
L30_1 = L30_1(L31_1, L32_1)
L28_1[L29_1] = L30_1
L28_1 = 1
L29_1 = _ENV
L30_1 = "menu"
L29_1 = L29_1[L30_1]
L30_1 = "slider"
L29_1 = L29_1[L30_1]
L30_1 = _ENV
L31_1 = "hudminimapmenu"
L30_1 = L30_1[L31_1]
L31_1 = "小地图缩放"
L32_1 = {}
L33_1 = "minimapzoom"
L32_1[1] = L33_1
L33_1 = ""
L34_1 = 0
L35_1 = 100
L36_1 = 0
L37_1 = 1
function L38_1(A0_2)
  local L1_2, L2_2
  L1_2 = HUD
  L1_2 = L1_2.SET_RADAR_ZOOM_PRECISE
  L2_2 = A0_2
  L1_2(L2_2)
end
L29_1(L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1)
L29_1 = 0
L30_1 = _ENV
L31_1 = "menu"
L30_1 = L30_1[L31_1]
L31_1 = "slider"
L30_1 = L30_1[L31_1]
L31_1 = _ENV
L32_1 = "hudminimapmenu"
L31_1 = L31_1[L32_1]
L32_1 = "小地图角度"
L33_1 = {}
L34_1 = "minimapanglme"
L33_1[1] = L34_1
L34_1 = ""
L35_1 = 0
L36_1 = 360
L37_1 = 0
L38_1 = 1
function L39_1(A0_2)
  local L1_2
  L29_1 = A0_2
end
L30_1(L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1)
L30_1 = _ENV
L31_1 = "mapanglet"
L32_1 = _ENV
L33_1 = "off"
L32_1 = L32_1[L33_1]
L30_1[L31_1] = L32_1
L30_1 = _ENV
L31_1 = "menu"
L30_1 = L30_1[L31_1]
L31_1 = "toggle"
L30_1 = L30_1[L31_1]
L31_1 = _ENV
L32_1 = "hudminimapmenu"
L31_1 = L31_1[L32_1]
L32_1 = "锁定地图角度"
L33_1 = {}
L34_1 = "lockminimapangle"
L33_1[1] = L34_1
L34_1 = ""
function L35_1(A0_2)
  local L1_2, L2_2
  mapanglet = A0_2
  while true do
    L1_2 = mapanglet
    if not L1_2 then
      break
    end
    L1_2 = HUD
    L1_2 = L1_2.LOCK_MINIMAP_ANGLE
    L2_2 = L29_1
    L1_2(L2_2)
    L1_2 = util
    L1_2 = L1_2.yield
    L1_2()
  end
  L1_2 = HUD
  L1_2 = L1_2.UNLOCK_MINIMAP_ANGLE
  L1_2()
end
L30_1(L31_1, L32_1, L33_1, L34_1, L35_1)
L30_1 = _ENV
L31_1 = "menu"
L30_1 = L30_1[L31_1]
L31_1 = "toggle"
L30_1 = L30_1[L31_1]
L31_1 = _ENV
L32_1 = "hudminimapmenu"
L31_1 = L31_1[L32_1]
L32_1 = "显示声呐"
L33_1 = {}
L34_1 = ""
function L35_1(A0_2)
  local L1_2, L2_2
  L1_2 = HUD1
  L1_2 = L1_2._SET_MINIMAP_SONAR_ENABLED
  L2_2 = A0_2
  L1_2(L2_2)
end
L30_1(L31_1, L32_1, L33_1, L34_1, L35_1)
L30_1 = _ENV
L31_1 = "menu"
L30_1 = L30_1[L31_1]
L31_1 = "toggle"
L30_1 = L30_1[L31_1]
L31_1 = _ENV
L32_1 = "hudminimapmenu"
L31_1 = L31_1[L32_1]
L32_1 = "显示佩里科岛地图"
L33_1 = {}
L34_1 = ""
function L35_1(A0_2)
  local L1_2, L2_2
  L1_2 = HUD1
  L1_2 = L1_2._SET_TOGGLE_MINIMAP_HEIST_ISLAND
  L2_2 = A0_2
  L1_2(L2_2)
end
L30_1(L31_1, L32_1, L33_1, L34_1, L35_1)
L30_1 = _ENV
L31_1 = "menu"
L30_1 = L30_1[L31_1]
L31_1 = "toggle"
L30_1 = L30_1[L31_1]
L31_1 = _ENV
L32_1 = "hudminimapmenu"
L31_1 = L31_1[L32_1]
L32_1 = "显示北扬克顿地图"
L33_1 = {}
L34_1 = ""
function L35_1(A0_2)
  local L1_2, L2_2
  L1_2 = HUD
  L1_2 = L1_2.SET_MINIMAP_IN_PROLOGUE
  L2_2 = A0_2
  L1_2(L2_2)
end
L30_1(L31_1, L32_1, L33_1, L34_1, L35_1)
L30_1 = _ENV
L31_1 = "menu"
L30_1 = L30_1[L31_1]
L31_1 = "toggle_loop"
L30_1 = L30_1[L31_1]
L31_1 = _ENV
L32_1 = "hudminimapmenu"
L31_1 = L31_1[L32_1]
L32_1 = "以你为中心的地图"
L33_1 = {}
L34_1 = ""
function L35_1()
  local L0_2, L1_2
  L0_2 = HUD
  L0_2 = L0_2.DONT_TILT_MINIMAP_THIS_FRAME
  L0_2()
end
L30_1(L31_1, L32_1, L33_1, L34_1, L35_1)
L30_1 = _ENV
L31_1 = "menu"
L30_1 = L30_1[L31_1]
L31_1 = "toggle"
L30_1 = L30_1[L31_1]
L31_1 = _ENV
L32_1 = "worldlist"
L31_1 = L31_1[L32_1]
L32_1 = "哲学的美"
L33_1 = {}
L34_1 = ""
function L35_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = menu
  L1_2 = L1_2.ref_by_path
  L2_2 = "World>Aesthetic Light>Aesthetic Light"
  L1_2 = L1_2(L2_2)
  if A0_2 then
    L2_2 = menu
    L2_2 = L2_2.trigger_commands
    L3_2 = "shader glasses_purple"
    L2_2(L3_2)
    L2_2 = menu
    L2_2 = L2_2.trigger_commands
    L3_2 = "aestheticcolourred 255"
    L2_2(L3_2)
    L2_2 = menu
    L2_2 = L2_2.trigger_commands
    L3_2 = "aestheticcolourgreen 0"
    L2_2(L3_2)
    L2_2 = menu
    L2_2 = L2_2.trigger_commands
    L3_2 = "aestheticcolourblue 255"
    L2_2(L3_2)
    L2_2 = menu
    L2_2 = L2_2.trigger_commands
    L3_2 = "aestheticrange 10000"
    L2_2(L3_2)
    L2_2 = menu
    L2_2 = L2_2.trigger_commands
    L3_2 = "aestheticintensity 30"
    L2_2(L3_2)
    L2_2 = menu
    L2_2 = L2_2.trigger_commands
    L3_2 = "time 0"
    L2_2(L3_2)
    L2_2 = menu
    L2_2 = L2_2.set_value
    L3_2 = L1_2
    L4_2 = true
    L2_2(L3_2, L4_2)
  else
    L2_2 = menu
    L2_2 = L2_2.set_value
    L3_2 = L1_2
    L4_2 = false
    L2_2(L3_2, L4_2)
    L2_2 = menu
    L2_2 = L2_2.trigger_commands
    L3_2 = "shader off"
    L2_2(L3_2)
  end
end
L30_1(L31_1, L32_1, L33_1, L34_1, L35_1)
L30_1 = _ENV
L31_1 = "menu"
L30_1 = L30_1[L31_1]
L31_1 = "action"
L30_1 = L30_1[L31_1]
L31_1 = _ENV
L32_1 = "worldlist"
L31_1 = L31_1[L32_1]
L32_1 = "时间流逝"
L33_1 = {}
L34_1 = ""
function L35_1()
  local L0_2, L1_2
  L0_2 = menu
  L0_2 = L0_2.trigger_commands
  L1_2 = "timesmoothing on"
  L0_2(L1_2)
  L0_2 = menu
  L0_2 = L0_2.trigger_commands
  L1_2 = "time 0"
  L0_2(L1_2)
  L0_2 = util
  L0_2 = L0_2.yield
  L1_2 = 1000
  L0_2(L1_2)
  L0_2 = menu
  L0_2 = L0_2.trigger_commands
  L1_2 = "time 12"
  L0_2(L1_2)
end
L30_1(L31_1, L32_1, L33_1, L34_1, L35_1)
L30_1 = _ENV
L31_1 = "all_npc"
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L33_1 = "list"
L32_1 = L32_1[L33_1]
L33_1 = _ENV
L34_1 = "worldlist"
L33_1 = L33_1[L34_1]
L34_1 = "NPC选项"
L35_1 = {}
L32_1 = L32_1(L33_1, L34_1, L35_1)
L30_1[L31_1] = L32_1
L30_1 = _ENV
L31_1 = "menu"
L30_1 = L30_1[L31_1]
L31_1 = "toggle_loop"
L30_1 = L30_1[L31_1]
L31_1 = _ENV
L32_1 = "all_npc"
L31_1 = L31_1[L32_1]
L32_1 = "禁用帮派骚扰"
L33_1 = {}
L34_1 = ""
function L35_1()
  local L0_2, L1_2, L2_2
  L0_2 = PLAYER
  L0_2 = L0_2.SET_PLAYER_CAN_BE_HASSLED_BY_GANGS
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2 = L1_2()
  L2_2 = false
  L0_2(L1_2, L2_2)
end
L30_1(L31_1, L32_1, L33_1, L34_1, L35_1)
L30_1 = _ENV
L31_1 = "menu"
L30_1 = L30_1[L31_1]
L31_1 = "action"
L30_1 = L30_1[L31_1]
L31_1 = _ENV
L32_1 = "all_npc"
L31_1 = L31_1[L32_1]
L32_1 = "移除尸体"
L33_1 = {}
L34_1 = ""
function L35_1()
  local L0_2, L1_2
  L0_2 = Remove_dead_body
  L0_2()
end
L30_1(L31_1, L32_1, L33_1, L34_1, L35_1)
L30_1 = _ENV
L31_1 = "menu"
L30_1 = L30_1[L31_1]
L31_1 = "action"
L30_1 = L30_1[L31_1]
L31_1 = _ENV
L32_1 = "all_npc"
L31_1 = L31_1[L32_1]
L32_1 = "移除丧尸"
L33_1 = {}
L34_1 = ""
function L35_1()
  local L0_2, L1_2
  L0_2 = Remove_zombies
  L0_2()
end
L30_1(L31_1, L32_1, L33_1, L34_1, L35_1)
L30_1 = _ENV
L31_1 = "menu"
L30_1 = L30_1[L31_1]
L31_1 = "toggle_loop"
L30_1 = L30_1[L31_1]
L31_1 = _ENV
L32_1 = "all_npc"
L31_1 = L31_1[L32_1]
L32_1 = "NPC无视玩家"
L33_1 = {}
L34_1 = ""
function L35_1()
  local L0_2, L1_2
  L0_2 = NPC_Ignore_player
  L0_2()
end
L30_1(L31_1, L32_1, L33_1, L34_1, L35_1)
L30_1 = _ENV
L31_1 = "menu"
L30_1 = L30_1[L31_1]
L31_1 = "toggle_loop"
L30_1 = L30_1[L31_1]
L31_1 = _ENV
L32_1 = "all_npc"
L31_1 = L31_1[L32_1]
L32_1 = "友好的NPC"
L33_1 = {}
L34_1 = "NPC不会攻击你."
function L35_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = PED
  L0_2 = L0_2.SET_PED_RESET_FLAG
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = 124
  L3_2 = true
  L0_2(L1_2, L2_2, L3_2)
end
L30_1(L31_1, L32_1, L33_1, L34_1, L35_1)
L30_1 = _ENV
L31_1 = "menu"
L30_1 = L30_1[L31_1]
L31_1 = "toggle_loop"
L30_1 = L30_1[L31_1]
L31_1 = _ENV
L32_1 = "all_npc"
L31_1 = L31_1[L32_1]
L32_1 = "自动杀死附近NPC"
L33_1 = {}
L34_1 = ""
function L35_1()
  local L0_2, L1_2
  L0_2 = auto_kill_NPC
  L0_2()
end
L30_1(L31_1, L32_1, L33_1, L34_1, L35_1)
L30_1 = _ENV
L31_1 = "menu"
L30_1 = L30_1[L31_1]
L31_1 = "toggle_loop"
L30_1 = L30_1[L31_1]
L31_1 = _ENV
L32_1 = "all_npc"
L31_1 = L31_1[L32_1]
L32_1 = "自动杀死敌人"
L33_1 = {}
L34_1 = ""
function L35_1()
  local L0_2, L1_2
  L0_2 = auto_kill_enemy
  L0_2()
end
L30_1(L31_1, L32_1, L33_1, L34_1, L35_1)
L30_1 = _ENV
L31_1 = "menu"
L30_1 = L30_1[L31_1]
L31_1 = "toggle"
L30_1 = L30_1[L31_1]
L31_1 = _ENV
L32_1 = "all_npc"
L31_1 = L31_1[L32_1]
L32_1 = "缩小NPC"
L33_1 = {}
L34_1 = ""
function L35_1(A0_2)
  local L1_2, L2_2
  L1_2 = shrink_peds
  L2_2 = A0_2
  L1_2(L2_2)
end
L30_1(L31_1, L32_1, L33_1, L34_1, L35_1)
L30_1 = _ENV
L31_1 = "pedToggleLoops"
L32_1 = {}
L33_1 = {}
L34_1 = "摔倒NPC"
L33_1.name = L34_1
L34_1 = "command"
L35_1 = "ragdollPeds"
L33_1[L34_1] = L35_1
L34_1 = "description"
L35_1 = "让附近的所有NPC都摔倒."
L33_1[L34_1] = L35_1
L34_1 = "action"
function L35_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = PED
  L1_2 = L1_2.IS_PED_A_PLAYER
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if L1_2 then
    return
  end
  L1_2 = PED
  L1_2 = L1_2.SET_PED_TO_RAGDOLL
  L2_2 = A0_2
  L3_2 = 2000
  L4_2 = 2000
  L5_2 = 0
  L6_2 = true
  L7_2 = true
  L8_2 = true
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
end
L33_1[L34_1] = L35_1
L34_1 = {}
L35_1 = "死亡接触"
L34_1.name = L35_1
L35_1 = "command"
L36_1 = "deathTouch"
L34_1[L35_1] = L36_1
L35_1 = "description"
L36_1 = "杀死所有碰到您的NPC"
L34_1[L35_1] = L36_1
L35_1 = "action"
function L36_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = PED
  L1_2 = L1_2.IS_PED_A_PLAYER
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if not L1_2 then
    L1_2 = PED
    L1_2 = L1_2.IS_PED_IN_ANY_VEHICLE
    L2_2 = A0_2
    L3_2 = true
    L1_2 = L1_2(L2_2, L3_2)
    if not L1_2 then
      L1_2 = ENTITY
      L1_2 = L1_2.IS_ENTITY_TOUCHING_ENTITY
      L2_2 = A0_2
      L3_2 = PLAYER
      L3_2 = L3_2.PLAYER_PED_ID
      L3_2, L4_2 = L3_2()
      L1_2 = L1_2(L2_2, L3_2, L4_2)
      if L1_2 then
        goto lbl_24
      end
    end
  end
  do return end
  ::lbl_24::
  L1_2 = ENTITY
  L1_2 = L1_2.SET_ENTITY_HEALTH
  L2_2 = A0_2
  L3_2 = 0
  L4_2 = 0
  L1_2(L2_2, L3_2, L4_2)
end
L34_1[L35_1] = L36_1
L35_1 = {}
L36_1 = "寒冷NPC"
L35_1.name = L36_1
L36_1 = "command"
L37_1 = "coldPeds"
L35_1[L36_1] = L37_1
L36_1 = "description"
L37_1 = "移除附近NPC的热特征"
L35_1[L36_1] = L37_1
L36_1 = "action"
function L37_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = PED
  L1_2 = L1_2.IS_PED_A_PLAYER
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if L1_2 then
    return
  end
  L1_2 = PED
  L1_2 = L1_2.SET_PED_HEATSCALE_OVERRIDE
  L2_2 = A0_2
  L3_2 = 0
  L1_2(L2_2, L3_2)
end
L35_1[L36_1] = L37_1
L36_1 = {}
L37_1 = "NPC喇叭加速"
L36_1.name = L37_1
L37_1 = "command"
L38_1 = "npcHornBoost"
L36_1[L37_1] = L38_1
L37_1 = "description"
L38_1 = "当NPC按喇叭的时候加速它们的载具."
L36_1[L37_1] = L38_1
L37_1 = "action"
function L38_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = PED
  L1_2 = L1_2.GET_VEHICLE_PED_IS_IN
  L2_2 = A0_2
  L3_2 = false
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = PED
  L2_2 = L2_2.IS_PED_A_PLAYER
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    L2_2 = PED
    L2_2 = L2_2.IS_PED_IN_ANY_VEHICLE
    L3_2 = A0_2
    L4_2 = true
    L2_2 = L2_2(L3_2, L4_2)
    if L2_2 then
      L2_2 = AUDIO
      L2_2 = L2_2.IS_HORN_ACTIVE
      L3_2 = L1_2
      L2_2 = L2_2(L3_2)
      if L2_2 then
        goto lbl_26
      end
    end
  end
  do return end
  ::lbl_26::
  L2_2 = AUDIO
  L2_2 = L2_2.SET_AGGRESSIVE_HORNS
  L3_2 = true
  L2_2(L3_2)
  L2_2 = VEHICLE
  L2_2 = L2_2.SET_VEHICLE_FORWARD_SPEED
  L3_2 = L1_2
  L4_2 = ENTITY
  L4_2 = L4_2.GET_ENTITY_SPEED
  L5_2 = L1_2
  L4_2 = L4_2(L5_2)
  L4_2 = L4_2 + 1.2
  L2_2(L3_2, L4_2)
end
L36_1[L37_1] = L38_1
L37_1 = "onStop"
function L38_1()
  local L0_2, L1_2
  L0_2 = AUDIO
  L0_2 = L0_2.SET_AGGRESSIVE_HORNS
  L1_2 = false
  L0_2(L1_2)
end
L36_1[L37_1] = L38_1
L37_1 = {}
L38_1 = "NPC警笛加速"
L37_1.name = L38_1
L38_1 = "command"
L39_1 = "npcSirenBoost"
L37_1[L38_1] = L39_1
L38_1 = "description"
L39_1 = "当NPC响起警车的警笛的时候加速它们的载具."
L37_1[L38_1] = L39_1
L38_1 = "action"
function L39_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = PED
  L1_2 = L1_2.GET_VEHICLE_PED_IS_IN
  L2_2 = A0_2
  L3_2 = false
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = PED
  L2_2 = L2_2.IS_PED_A_PLAYER
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    L2_2 = PED
    L2_2 = L2_2.IS_PED_IN_ANY_VEHICLE
    L3_2 = A0_2
    L4_2 = true
    L2_2 = L2_2(L3_2, L4_2)
    if L2_2 then
      L2_2 = VEHICLE
      L2_2 = L2_2.IS_VEHICLE_SIREN_ON
      L3_2 = L1_2
      L2_2 = L2_2(L3_2)
      if L2_2 then
        goto lbl_26
      end
    end
  end
  do return end
  ::lbl_26::
  L2_2 = VEHICLE
  L2_2 = L2_2.SET_VEHICLE_FORWARD_SPEED
  L3_2 = L1_2
  L4_2 = ENTITY
  L4_2 = L4_2.GET_ENTITY_SPEED
  L5_2 = L1_2
  L4_2 = L4_2(L5_2)
  L4_2 = L4_2 + 1.2
  L2_2(L3_2, L4_2)
end
L37_1[L38_1] = L39_1
L32_1[1] = L33_1
L32_1[2] = L34_1
L32_1[3] = L35_1
L32_1[4] = L36_1
L32_1[5] = L37_1
L30_1[L31_1] = L32_1
L30_1 = 1
L31_1 = _ENV
L32_1 = "pedToggleLoops"
L31_1 = L31_1[L32_1]
L31_1 = #L31_1
L32_1 = 1
for L33_1 = L30_1, L31_1, L32_1 do
  L34_1 = _ENV
  L35_1 = "menu"
  L34_1 = L34_1[L35_1]
  L35_1 = "toggle_loop"
  L34_1 = L34_1[L35_1]
  L35_1 = _ENV
  L36_1 = "all_npc"
  L35_1 = L35_1[L36_1]
  L36_1 = _ENV
  L37_1 = "pedToggleLoops"
  L36_1 = L36_1[L37_1]
  L36_1 = L36_1[L33_1]
  L36_1 = L36_1.name
  L37_1 = {}
  L38_1 = _ENV
  L39_1 = "pedToggleLoops"
  L38_1 = L38_1[L39_1]
  L38_1 = L38_1[L33_1]
  L39_1 = "command"
  L38_1 = L38_1[L39_1]
  L37_1[1] = L38_1
  L38_1 = _ENV
  L39_1 = "pedToggleLoops"
  L38_1 = L38_1[L39_1]
  L38_1 = L38_1[L33_1]
  L39_1 = "description"
  L38_1 = L38_1[L39_1]
  function L39_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
    L0_2 = entities
    L0_2 = L0_2.get_all_peds_as_handles
    L0_2 = L0_2()
    L1_2 = 1
    L2_2 = #L0_2
    L3_2 = 1
    for L4_2 = L1_2, L2_2, L3_2 do
      L5_2 = pedToggleLoops
      L6_2 = L33_1
      L5_2 = L5_2[L6_2]
      L5_2 = L5_2.action
      L6_2 = L0_2[L4_2]
      L5_2(L6_2)
    end
    L1_2 = util
    L1_2 = L1_2.yield
    L2_2 = 10
    L1_2(L2_2)
  end
  function L40_1()
    local L0_2, L1_2
    L0_2 = pedToggleLoops
    L1_2 = L33_1
    L0_2 = L0_2[L1_2]
    L0_2 = L0_2.onStop
    if L0_2 then
      L0_2 = pedToggleLoops
      L1_2 = L33_1
      L0_2 = L0_2[L1_2]
      L0_2 = L0_2.onStop
      L0_2()
    end
  end
  L34_1(L35_1, L36_1, L37_1, L38_1, L39_1, L40_1)
end
L30_1 = _ENV
L31_1 = "menu"
L30_1 = L30_1[L31_1]
L31_1 = "toggle"
L30_1 = L30_1[L31_1]
L31_1 = _ENV
L32_1 = "worldlist"
L31_1 = L31_1[L32_1]
L32_1 = "停电"
L33_1 = {}
L34_1 = ""
function L35_1(A0_2)
  local L1_2, L2_2
  L1_2 = GRAPHICS
  L1_2 = L1_2.SET_ARTIFICIAL_LIGHTS_STATE
  L2_2 = A0_2
  L1_2(L2_2)
end
L30_1(L31_1, L32_1, L33_1, L34_1, L35_1)
L30_1 = _ENV
L31_1 = "menu"
L30_1 = L30_1[L31_1]
L31_1 = "toggle"
L30_1 = L30_1[L31_1]
L31_1 = _ENV
L32_1 = "worldlist"
L31_1 = L31_1[L32_1]
L32_1 = "世界末日"
L33_1 = {}
L34_1 = ""
function L35_1(A0_2)
  local L1_2, L2_2
  L1_2 = menu
  L1_2 = L1_2.trigger_commands
  L2_2 = "time 1"
  L1_2(L2_2)
  L1_2 = GRAPHICS
  L1_2 = L1_2.SET_ARTIFICIAL_LIGHTS_STATE
  L2_2 = A0_2
  L1_2(L2_2)
  if A0_2 then
    L1_2 = GRAPHICS
    L1_2 = L1_2.SET_TIMECYCLE_MODIFIER
    L2_2 = "dlc_island_vault"
    L1_2(L2_2)
  else
    L1_2 = GRAPHICS
    L1_2 = L1_2.SET_TIMECYCLE_MODIFIER
    L2_2 = "DEFAULT"
    L1_2(L2_2)
  end
end
L30_1(L31_1, L32_1, L33_1, L34_1, L35_1)
L30_1 = _ENV
L31_1 = "visuallist"
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L33_1 = "list"
L32_1 = L32_1[L33_1]
L33_1 = _ENV
L34_1 = "worldlist"
L33_1 = L33_1[L34_1]
L34_1 = "视觉效果"
L35_1 = {}
L32_1 = L32_1(L33_1, L34_1, L35_1)
L30_1[L31_1] = L32_1
L30_1 = _ENV
L31_1 = "menu"
L30_1 = L30_1[L31_1]
L31_1 = "click_slider"
L30_1 = L30_1[L31_1]
L31_1 = _ENV
L32_1 = "visuallist"
L31_1 = L31_1[L32_1]
L32_1 = "醉酒模式"
L33_1 = {}
L34_1 = ""
L35_1 = 0
L36_1 = 5
L37_1 = 0
L38_1 = 1
function L39_1(A0_2)
  local L1_2, L2_2, L3_2
  if A0_2 > 0 then
    L1_2 = CAM
    L1_2 = L1_2.SHAKE_GAMEPLAY_CAM
    L2_2 = "DRUNK_SHAKE"
    L3_2 = A0_2
    L1_2(L2_2, L3_2)
    L1_2 = GRAPHICS
    L1_2 = L1_2.SET_TIMECYCLE_MODIFIER
    L2_2 = "Drunk"
    L1_2(L2_2)
  else
    L1_2 = GRAPHICS
    L1_2 = L1_2.SET_TIMECYCLE_MODIFIER
    L2_2 = "DEFAULT"
    L1_2(L2_2)
    L1_2 = CAM
    L1_2 = L1_2.SHAKE_GAMEPLAY_CAM
    L2_2 = "DRUNK_SHAKE"
    L3_2 = 0
    L1_2(L2_2, L3_2)
  end
end
L30_1(L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1)
L30_1 = _ENV
L31_1 = "visual_fidelity"
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L33_1 = "list"
L32_1 = L32_1[L33_1]
L33_1 = _ENV
L34_1 = "visuallist"
L33_1 = L33_1[L34_1]
L34_1 = "视觉增强"
L35_1 = {}
L36_1 = ""
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L30_1[L31_1] = L32_1
L30_1 = _ENV
L31_1 = "pairs"
L30_1 = L30_1[L31_1]
L31_1 = _ENV
L32_1 = "visual_stuff"
L31_1 = L31_1[L32_1]
L30_1, L31_1, L32_1, L33_1 = L30_1(L31_1)
for L34_1, L35_1 in L30_1, L31_1, L32_1, L33_1 do
  L36_1 = L35_1[1]
  L37_1 = L35_1[2]
  L38_1 = false
  L39_1 = nil
  L40_1 = _ENV
  L41_1 = "menu"
  L40_1 = L40_1[L41_1]
  L41_1 = "toggle"
  L40_1 = L40_1[L41_1]
  L41_1 = _ENV
  L42_1 = "visual_fidelity"
  L41_1 = L41_1[L42_1]
  L42_1 = L36_1
  L43_1 = {}
  L44_1 = ""
  function L45_1(A0_2)
    local L1_2, L2_2
    L38_1 = A0_2
    L1_2 = menu
    L1_2 = L1_2.get_value
    L2_2 = L39_1
    L1_2 = L1_2(L2_2)
    if not L1_2 then
      L1_2 = GRAPHICS
      L1_2 = L1_2.ANIMPOSTFX_STOP_ALL
      L1_2()
      return
    end
    while true do
      L1_2 = L38_1
      if not L1_2 then
        break
      end
      L1_2 = GRAPHICS
      L1_2 = L1_2.SET_TIMECYCLE_MODIFIER
      L2_2 = L37_1
      L1_2(L2_2)
      L1_2 = menu
      L1_2 = L1_2.trigger_commands
      L2_2 = "shader off"
      L1_2(L2_2)
      L1_2 = util
      L1_2 = L1_2.yield
      L2_2 = 250
      L1_2(L2_2)
    end
    L1_2 = GRAPHICS
    L1_2 = L1_2.SET_TIMECYCLE_MODIFIER
    L2_2 = "DEFAULT"
    L1_2(L2_2)
  end
  L40_1 = L40_1(L41_1, L42_1, L43_1, L44_1, L45_1)
  L39_1 = L40_1
end
L30_1 = _ENV
L31_1 = "drug_mode"
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L33_1 = "list"
L32_1 = L32_1[L33_1]
L33_1 = _ENV
L34_1 = "visuallist"
L33_1 = L33_1[L34_1]
L34_1 = "药物过滤器"
L35_1 = {}
L36_1 = ""
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L30_1[L31_1] = L32_1
L30_1 = _ENV
L31_1 = "pairs"
L30_1 = L30_1[L31_1]
L31_1 = _ENV
L32_1 = "drugged_effects"
L31_1 = L31_1[L32_1]
L30_1, L31_1, L32_1, L33_1 = L30_1(L31_1)
for L34_1, L35_1 in L30_1, L31_1, L32_1, L33_1 do
  L36_1 = _ENV
  L37_1 = "menu"
  L36_1 = L36_1[L37_1]
  L37_1 = "toggle"
  L36_1 = L36_1[L37_1]
  L37_1 = _ENV
  L38_1 = "drug_mode"
  L37_1 = L37_1[L38_1]
  L38_1 = L35_1
  L39_1 = {}
  L40_1 = ""
  function L41_1(A0_2)
    local L1_2, L2_2
    if A0_2 then
      L1_2 = GRAPHICS
      L1_2 = L1_2.SET_TIMECYCLE_MODIFIER
      L2_2 = L35_1
      L1_2(L2_2)
      L1_2 = menu
      L1_2 = L1_2.trigger_commands
      L2_2 = "shader off"
      L1_2(L2_2)
    else
      L1_2 = GRAPHICS
      L1_2 = L1_2.SET_TIMECYCLE_MODIFIER
      L2_2 = "DEFAULT"
      L1_2(L2_2)
    end
  end
  L36_1(L37_1, L38_1, L39_1, L40_1, L41_1)
end
L30_1 = _ENV
L31_1 = "visions"
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L33_1 = "list"
L32_1 = L32_1[L33_1]
L33_1 = _ENV
L34_1 = "visuallist"
L33_1 = L33_1[L34_1]
L34_1 = "屏幕效果"
L35_1 = {}
L36_1 = ""
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L30_1[L31_1] = L32_1
L30_1 = _ENV
L31_1 = "pairs"
L30_1 = L30_1[L31_1]
L31_1 = _ENV
L32_1 = "effect_stuff"
L31_1 = L31_1[L32_1]
L30_1, L31_1, L32_1, L33_1 = L30_1(L31_1)
for L34_1, L35_1 in L30_1, L31_1, L32_1, L33_1 do
  L36_1 = L35_1[1]
  L37_1 = L35_1[2]
  L38_1 = false
  L39_1 = nil
  L40_1 = _ENV
  L41_1 = "menu"
  L40_1 = L40_1[L41_1]
  L41_1 = "toggle"
  L40_1 = L40_1[L41_1]
  L41_1 = _ENV
  L42_1 = "visions"
  L41_1 = L41_1[L42_1]
  L42_1 = L36_1
  L43_1 = {}
  L44_1 = ""
  function L45_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2
    L38_1 = A0_2
    L1_2 = menu
    L1_2 = L1_2.get_value
    L2_2 = L39_1
    L1_2 = L1_2(L2_2)
    if not L1_2 then
      L1_2 = GRAPHICS
      L1_2 = L1_2.ANIMPOSTFX_STOP_ALL
      L1_2()
      return
    end
    while true do
      L1_2 = L38_1
      if not L1_2 then
        break
      end
      L1_2 = GRAPHICS
      L1_2 = L1_2.ANIMPOSTFX_PLAY
      L2_2 = L37_1
      L3_2 = 5
      L4_2 = true
      L1_2(L2_2, L3_2, L4_2)
      L1_2 = util
      L1_2 = L1_2.yield
      L2_2 = 1000
      L1_2(L2_2)
    end
  end
  L40_1 = L40_1(L41_1, L42_1, L43_1, L44_1, L45_1)
  L39_1 = L40_1
end
L30_1 = _ENV
L31_1 = "menu"
L30_1 = L30_1[L31_1]
L31_1 = "divider"
L30_1 = L30_1[L31_1]
L31_1 = _ENV
L32_1 = "cheater_detection"
L31_1 = L31_1[L32_1]
L32_1 = "检测列表"
L30_1(L31_1, L32_1)
L30_1 = _ENV
L31_1 = "pin1"
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L33_1 = "toggle_loop"
L32_1 = L32_1[L33_1]
L33_1 = _ENV
L34_1 = "cheater_detection"
L33_1 = L33_1[L34_1]
L34_1 = "玩家无敌检测"
L35_1 = {}
L36_1 = "检测是否在使用无敌."
function L37_1()
  local L0_2, L1_2
  L0_2 = god_detection
  L0_2()
end
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1, L37_1)
L30_1[L31_1] = L32_1
L30_1 = _ENV
L31_1 = "pin2"
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L33_1 = "toggle_loop"
L32_1 = L32_1[L33_1]
L33_1 = _ENV
L34_1 = "cheater_detection"
L33_1 = L33_1[L34_1]
L34_1 = "载具无敌检测"
L35_1 = {}
L36_1 = "检测载具是否在使用无敌."
function L37_1()
  local L0_2, L1_2
  L0_2 = car_god_detection
  L0_2()
end
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1, L37_1)
L30_1[L31_1] = L32_1
L30_1 = _ENV
L31_1 = "pin3"
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L33_1 = "toggle_loop"
L32_1 = L32_1[L33_1]
L33_1 = _ENV
L34_1 = "cheater_detection"
L33_1 = L33_1[L34_1]
L34_1 = "未发布载具检测"
L35_1 = {}
L36_1 = "检测是否有人在驾使尚未发布的车辆."
function L37_1()
  local L0_2, L1_2
  L0_2 = unreleased_car_detection
  L0_2()
end
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1, L37_1)
L30_1[L31_1] = L32_1
L30_1 = _ENV
L31_1 = "pin4"
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L33_1 = "toggle_loop"
L32_1 = L32_1[L33_1]
L33_1 = _ENV
L34_1 = "cheater_detection"
L33_1 = L33_1[L34_1]
L34_1 = "无法获得武器检测"
L35_1 = {}
L36_1 = "检测是否有人使用无法在线获得的武器."
function L37_1()
  local L0_2, L1_2
  L0_2 = cantgetweapon_detection
  L0_2()
end
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1, L37_1)
L30_1[L31_1] = L32_1
L30_1 = _ENV
L31_1 = "pin5"
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L33_1 = "toggle_loop"
L32_1 = L32_1[L33_1]
L33_1 = _ENV
L34_1 = "cheater_detection"
L33_1 = L33_1[L34_1]
L34_1 = "无法获得载具检测"
L35_1 = {}
L36_1 = "检测是否有人正在使用无法在线获得的车辆."
function L37_1()
  local L0_2, L1_2
  L0_2 = cantgetvar_detection
  L0_2()
end
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1, L37_1)
L30_1[L31_1] = L32_1
L30_1 = _ENV
L31_1 = "pin6"
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L33_1 = "toggle_loop"
L32_1 = L32_1[L33_1]
L33_1 = _ENV
L34_1 = "cheater_detection"
L33_1 = L33_1[L34_1]
L34_1 = "室内使用武器检测"
L35_1 = {}
L36_1 = "检测玩家是否在室内使用武器."
function L37_1()
  local L0_2, L1_2
  L0_2 = usingweapon_detection
  L0_2()
end
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1, L37_1)
L30_1[L31_1] = L32_1
L30_1 = _ENV
L31_1 = "pin7"
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L33_1 = "toggle_loop"
L32_1 = L32_1[L33_1]
L33_1 = _ENV
L34_1 = "cheater_detection"
L33_1 = L33_1[L34_1]
L34_1 = "超级驾驶检测"
L35_1 = {}
L36_1 = "检测是否有在修改载具车速."
function L37_1()
  local L0_2, L1_2
  L0_2 = supercar_detection
  L0_2()
end
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1, L37_1)
L30_1[L31_1] = L32_1
L30_1 = _ENV
L31_1 = "pin8"
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L33_1 = "toggle_loop"
L32_1 = L32_1[L33_1]
L33_1 = _ENV
L34_1 = "cheater_detection"
L33_1 = L33_1[L34_1]
L34_1 = "超级跑检测"
L35_1 = {}
L36_1 = "检测玩家是否在使用超级跑（奔跑速度不合常理）"
function L37_1()
  local L0_2, L1_2
  L0_2 = superrun_detection
  L0_2()
end
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1, L37_1)
L30_1[L31_1] = L32_1
L30_1 = _ENV
L31_1 = "pin9"
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L33_1 = "toggle_loop"
L32_1 = L32_1[L33_1]
L33_1 = _ENV
L34_1 = "cheater_detection"
L33_1 = L33_1[L34_1]
L34_1 = "观看检测"
L35_1 = {}
L36_1 = "检测是否有人在观看你."
function L37_1()
  local L0_2, L1_2
  L0_2 = lookingyou_detection
  L0_2()
end
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1, L37_1)
L30_1[L31_1] = L32_1
L30_1 = _ENV
L31_1 = "pin10"
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L33_1 = "toggle_loop"
L32_1 = L32_1[L33_1]
L33_1 = _ENV
L34_1 = "cheater_detection"
L33_1 = L33_1[L34_1]
L34_1 = "传送检测"
L35_1 = {}
L36_1 = "检测玩家是否使用了传送"
function L37_1()
  local L0_2, L1_2
  L0_2 = tp_detection
  L0_2()
end
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1, L37_1)
L30_1[L31_1] = L32_1
L30_1 = _ENV
L31_1 = "pin11"
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L33_1 = "toggle_loop"
L32_1 = L32_1[L33_1]
L33_1 = _ENV
L34_1 = "cheater_detection"
L33_1 = L33_1[L34_1]
L34_1 = "改装武器检测"
L35_1 = {}
L36_1 = "检测玩家是否使用了改装武器"
function L37_1()
  local L0_2, L1_2
  L0_2 = modified_weapon_detection
  L0_2()
end
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1, L37_1)
L30_1[L31_1] = L32_1
L30_1 = _ENV
L31_1 = "pin12"
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L33_1 = "toggle_loop"
L32_1 = L32_1[L33_1]
L33_1 = _ENV
L34_1 = "cheater_detection"
L33_1 = L33_1[L34_1]
L34_1 = "改装载具检测"
L35_1 = {}
L36_1 = "检测玩家是否使用了改装载具"
function L37_1()
  local L0_2, L1_2
  L0_2 = modified_vehicles_detection
  L0_2()
end
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1, L37_1)
L30_1[L31_1] = L32_1
L30_1 = _ENV
L31_1 = "menu"
L30_1 = L30_1[L31_1]
L31_1 = "toggle_loop"
L30_1 = L30_1[L31_1]
L31_1 = _ENV
L32_1 = "otherlist"
L31_1 = L31_1[L32_1]
L32_1 = "死亡警告"
L33_1 = {}
L34_1 = "当你死亡时触发警告"
function L35_1()
  local L0_2, L1_2
  L0_2 = dead_warning
  L0_2()
end
L30_1(L31_1, L32_1, L33_1, L34_1, L35_1)
L30_1 = _ENV
L31_1 = "menu"
L30_1 = L30_1[L31_1]
L31_1 = "toggle_loop"
L30_1 = L30_1[L31_1]
L31_1 = _ENV
L32_1 = "otherlist"
L31_1 = L31_1[L32_1]
L32_1 = "禁用通知"
L33_1 = {}
L34_1 = "将禁止小地图上方通知"
function L35_1()
  local L0_2, L1_2
  L0_2 = HUD
  L0_2 = L0_2.THEFEED_HIDE_THIS_FRAME
  L0_2()
end
L30_1(L31_1, L32_1, L33_1, L34_1, L35_1)
L30_1 = _ENV
L31_1 = "menu"
L30_1 = L30_1[L31_1]
L31_1 = "toggle"
L30_1 = L30_1[L31_1]
L31_1 = _ENV
L32_1 = "otherlist"
L31_1 = L31_1[L32_1]
L32_1 = "隐藏GUI"
L33_1 = {}
L34_1 = ""
function L35_1(A0_2)
  local L1_2, L2_2
  if A0_2 then
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "screenshot on"
    L1_2(L2_2)
  else
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "screenshot off"
    L1_2(L2_2)
  end
end
L30_1(L31_1, L32_1, L33_1, L34_1, L35_1)
L30_1 = _ENV
L31_1 = "menu"
L30_1 = L30_1[L31_1]
L31_1 = "action"
L30_1 = L30_1[L31_1]
L31_1 = _ENV
L32_1 = "otherlist"
L31_1 = L31_1[L32_1]
L32_1 = "强制云保存"
L33_1 = {}
L34_1 = "强制云MP统计数据下载并覆盖本地保存"
function L35_1()
  local L0_2, L1_2
  L0_2 = STATS
  L1_2 = "FORCE_CLOUD_MP_STATS_DOWNLOAD_AND_OVERWRITE_LOCAL_SAVE"
  L0_2 = L0_2[L1_2]
  L0_2()
end
L30_1(L31_1, L32_1, L33_1, L34_1, L35_1)
L30_1 = _ENV
L31_1 = "watermark"
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L33_1 = "list"
L32_1 = L32_1[L33_1]
L33_1 = _ENV
L34_1 = "otherlist"
L33_1 = L33_1[L34_1]
L34_1 = "游戏水印"
L35_1 = {}
L36_1 = "为视频图片添加水印保护你的成果"
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L30_1[L31_1] = L32_1
L30_1 = _ENV
L31_1 = "menu"
L30_1 = L30_1[L31_1]
L31_1 = "toggle_loop"
L30_1 = L30_1[L31_1]
L31_1 = _ENV
L32_1 = "watermark"
L31_1 = L31_1[L32_1]
L32_1 = "开启"
L33_1 = {}
L34_1 = ""
function L35_1()
  local L0_2, L1_2
  L0_2 = watermark_toggle
  L0_2()
end
L30_1(L31_1, L32_1, L33_1, L34_1, L35_1)
L30_1 = _ENV
L31_1 = "menu"
L30_1 = L30_1[L31_1]
L31_1 = "divider"
L30_1 = L30_1[L31_1]
L31_1 = _ENV
L32_1 = "watermark"
L31_1 = L31_1[L32_1]
L32_1 = "设置"
L30_1(L31_1, L32_1)
L30_1 = _ENV
L31_1 = "pos_settings"
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L33_1 = "list"
L32_1 = L32_1[L33_1]
L33_1 = _ENV
L34_1 = "watermark"
L33_1 = L33_1[L34_1]
L34_1 = "位置"
L35_1 = {}
L36_1 = ""
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L30_1[L31_1] = L32_1
L30_1 = _ENV
L31_1 = "menu"
L30_1 = L30_1[L31_1]
L31_1 = "slider"
L30_1 = L30_1[L31_1]
L31_1 = _ENV
L32_1 = "pos_settings"
L31_1 = L31_1[L32_1]
L32_1 = "x坐标"
L33_1 = {}
L34_1 = "watermark-x"
L33_1[1] = L34_1
L34_1 = ""
L35_1 = -100000
L36_1 = 100000
L37_1 = _ENV
L38_1 = "watermark_pos"
L37_1 = L37_1[L38_1]
L38_1 = "x"
L37_1 = L37_1[L38_1]
L38_1 = 10000
L37_1 = L37_1 * L38_1
L38_1 = 10
function L39_1(A0_2)
  local L1_2, L2_2
  L1_2 = watermark_x
  L2_2 = A0_2
  L1_2(L2_2)
end
L30_1(L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1)
L30_1 = _ENV
L31_1 = "menu"
L30_1 = L30_1[L31_1]
L31_1 = "slider"
L30_1 = L30_1[L31_1]
L31_1 = _ENV
L32_1 = "pos_settings"
L31_1 = L31_1[L32_1]
L32_1 = "y坐标"
L33_1 = {}
L34_1 = "watermark-y"
L33_1[1] = L34_1
L34_1 = ""
L35_1 = -100000
L36_1 = 100000
L37_1 = _ENV
L38_1 = "watermark_pos"
L37_1 = L37_1[L38_1]
L38_1 = "y"
L37_1 = L37_1[L38_1]
L38_1 = 10000
L37_1 = L37_1 * L38_1
L38_1 = 10
function L39_1(A0_2)
  local L1_2, L2_2
  L1_2 = watermark_y
  L2_2 = A0_2
  L1_2(L2_2)
end
L30_1(L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1)
L30_1 = _ENV
L31_1 = "menu"
L30_1 = L30_1[L31_1]
L31_1 = "slider"
L30_1 = L30_1[L31_1]
L31_1 = _ENV
L32_1 = "pos_settings"
L31_1 = L31_1[L32_1]
L32_1 = "背景长度"
L33_1 = {}
L34_1 = "watermark-addx"
L33_1[1] = L34_1
L34_1 = ""
L35_1 = -100000
L36_1 = 100000
L37_1 = _ENV
L38_1 = "watermark_settings"
L37_1 = L37_1[L38_1]
L38_1 = "add_x"
L37_1 = L37_1[L38_1]
L38_1 = 10000
L37_1 = L37_1 * L38_1
L38_1 = 10
function L39_1(A0_2)
  local L1_2, L2_2
  L1_2 = watermark_bgx
  L2_2 = A0_2
  L1_2(L2_2)
end
L30_1(L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1)
L30_1 = _ENV
L31_1 = "menu"
L30_1 = L30_1[L31_1]
L31_1 = "slider"
L30_1 = L30_1[L31_1]
L31_1 = _ENV
L32_1 = "pos_settings"
L31_1 = L31_1[L32_1]
L32_1 = "背景宽度"
L33_1 = {}
L34_1 = "watermark-addy"
L33_1[1] = L34_1
L34_1 = ""
L35_1 = -100000
L36_1 = 100000
L37_1 = _ENV
L38_1 = "watermark_settings"
L37_1 = L37_1[L38_1]
L38_1 = "add_y"
L37_1 = L37_1[L38_1]
L38_1 = 10000
L37_1 = L37_1 * L38_1
L38_1 = 10
function L39_1(A0_2)
  local L1_2, L2_2
  L1_2 = watermark_bgy
  L2_2 = A0_2
  L1_2(L2_2)
end
L30_1(L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1)
L30_1 = _ENV
L31_1 = "watermarkcolor_settings"
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L33_1 = "list"
L32_1 = L32_1[L33_1]
L33_1 = _ENV
L34_1 = "watermark"
L33_1 = L33_1[L34_1]
L34_1 = "颜色"
L35_1 = {}
L36_1 = ""
L32_1 = L32_1(L33_1, L34_1, L35_1, L36_1)
L30_1[L31_1] = L32_1
L30_1 = _ENV
L31_1 = "menu"
L30_1 = L30_1[L31_1]
L30_1 = L30_1.colour
L31_1 = _ENV
L32_1 = "watermarkcolor_settings"
L31_1 = L31_1[L32_1]
L32_1 = "背景颜色"
L33_1 = {}
L34_1 = "watermark-bg_color"
L33_1[1] = L34_1
L34_1 = ""
L35_1 = _ENV
L36_1 = "watermark_settings"
L35_1 = L35_1[L36_1]
L36_1 = "bg_color"
L35_1 = L35_1[L36_1]
L36_1 = true
function L37_1(A0_2)
  local L1_2, L2_2
  L1_2 = watermark_bgc
  L2_2 = A0_2
  L1_2(L2_2)
end
L30_1 = L30_1(L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1)
L31_1 = _ENV
L32_1 = "menu"
L31_1 = L31_1[L32_1]
L31_1 = L31_1.colour
L32_1 = _ENV
L33_1 = "watermarkcolor_settings"
L32_1 = L32_1[L33_1]
L33_1 = "文本颜色"
L34_1 = {}
L35_1 = "watermark-tx_color"
L34_1[1] = L35_1
L35_1 = ""
L36_1 = _ENV
L37_1 = "watermark_settings"
L36_1 = L36_1[L37_1]
L37_1 = "tx_color"
L36_1 = L36_1[L37_1]
L37_1 = true
function L38_1(A0_2)
  local L1_2, L2_2
  L1_2 = watermark_txtc
  L2_2 = A0_2
  L1_2(L2_2)
end
L31_1 = L31_1(L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1)
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L33_1 = "divider"
L32_1 = L32_1[L33_1]
L33_1 = _ENV
L34_1 = "watermark"
L33_1 = L33_1[L34_1]
L34_1 = "附加"
L32_1(L33_1, L34_1)
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L33_1 = "list_select"
L32_1 = L32_1[L33_1]
L33_1 = _ENV
L34_1 = "watermark"
L33_1 = L33_1[L34_1]
L34_1 = "第一标签"
L35_1 = {}
L36_1 = "更改水线中的第一个标签"
L37_1 = {}
L38_1 = "无"
L39_1 = "Sakura"
L40_1 = "Version"
L41_1 = "Stand"
L42_1 = "^_-"
L43_1 = "OwO"
L37_1[1] = L38_1
L37_1[2] = L39_1
L37_1[3] = L40_1
L37_1[4] = L41_1
L37_1[5] = L42_1
L37_1[6] = L43_1
L38_1 = _ENV
L39_1 = "watermark_settings"
L38_1 = L38_1[L39_1]
L39_1 = "show_firstl"
L38_1 = L38_1[L39_1]
function L39_1(A0_2)
  local L1_2, L2_2
  L1_2 = watermark_lable
  L2_2 = A0_2
  L1_2(L2_2)
end
L32_1(L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1)
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L33_1 = "toggle"
L32_1 = L32_1[L33_1]
L33_1 = _ENV
L34_1 = "watermark"
L33_1 = L33_1[L34_1]
L34_1 = "昵称"
L35_1 = {}
L36_1 = "在水印中显示您的昵称"
function L37_1(A0_2)
  local L1_2, L2_2
  L1_2 = watermark_name
  L2_2 = A0_2
  L1_2(L2_2)
end
L38_1 = _ENV
L39_1 = "watermark_settings"
L38_1 = L38_1[L39_1]
L39_1 = "show_name"
L38_1 = L38_1[L39_1]
L32_1(L33_1, L34_1, L35_1, L36_1, L37_1, L38_1)
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L33_1 = "toggle"
L32_1 = L32_1[L33_1]
L33_1 = _ENV
L34_1 = "watermark"
L33_1 = L33_1[L34_1]
L34_1 = "玩家人数"
L35_1 = {}
L36_1 = "在水印中显示玩家人数"
function L37_1(A0_2)
  local L1_2, L2_2
  L1_2 = watermark_players
  L2_2 = A0_2
  L1_2(L2_2)
end
L38_1 = _ENV
L39_1 = "watermark_settings"
L38_1 = L38_1[L39_1]
L39_1 = "show_players"
L38_1 = L38_1[L39_1]
L32_1(L33_1, L34_1, L35_1, L36_1, L37_1, L38_1)
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L33_1 = "toggle"
L32_1 = L32_1[L33_1]
L33_1 = _ENV
L34_1 = "watermark"
L33_1 = L33_1[L34_1]
L34_1 = "时间"
L35_1 = {}
L36_1 = "在水印中显示系统时间"
function L37_1(A0_2)
  local L1_2, L2_2
  L1_2 = watermark_time
  L2_2 = A0_2
  L1_2(L2_2)
end
L38_1 = _ENV
L39_1 = "watermark_settings"
L38_1 = L38_1[L39_1]
L39_1 = "show_date"
L38_1 = L38_1[L39_1]
L32_1(L33_1, L34_1, L35_1, L36_1, L37_1, L38_1)
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L33_1 = "action"
L32_1 = L32_1[L33_1]
L33_1 = _ENV
L34_1 = "otherlist"
L33_1 = L33_1[L34_1]
L34_1 = "IP查询"
L35_1 = {}
L36_1 = ""
function L37_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = util
  L0_2 = L0_2.register_label
  L1_2 = "请正确输入IP地址"
  L0_2 = L0_2(L1_2)
  L1_2 = get_input_from_screen_keyboard
  L2_2 = L0_2
  L3_2 = 16
  L4_2 = ""
  L1_2 = L1_2(L2_2, L3_2, L4_2)
  if "" == L1_2 then
    return
  end
  L2_2 = QueryIP
  L3_2 = L1_2
  L2_2(L3_2)
end
L32_1(L33_1, L34_1, L35_1, L36_1, L37_1)
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L33_1 = "toggle_loop"
L32_1 = L32_1[L33_1]
L33_1 = _ENV
L34_1 = "otherlist"
L33_1 = L33_1[L34_1]
L34_1 = "显示轴向"
L35_1 = {}
L36_1 = ""
function L37_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L0_2 = ENTITY
  L0_2 = L0_2.GET_ENTITY_COORDS
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L1_2 = GRAPHICS
  L1_2 = L1_2.DRAW_LINE
  L2_2 = L0_2.x
  L3_2 = L0_2.y
  L4_2 = L0_2.z
  L5_2 = L0_2.x
  L5_2 = L5_2 + 2
  L6_2 = L0_2.y
  L7_2 = L0_2.z
  L8_2 = 255
  L9_2 = 0
  L10_2 = 0
  L11_2 = 255
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L1_2 = GRAPHICS
  L1_2 = L1_2.DRAW_LINE
  L2_2 = L0_2.x
  L3_2 = L0_2.y
  L4_2 = L0_2.z
  L5_2 = L0_2.x
  L6_2 = L0_2.y
  L6_2 = L6_2 + 2
  L7_2 = L0_2.z
  L8_2 = 0
  L9_2 = 255
  L10_2 = 0
  L11_2 = 255
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L1_2 = GRAPHICS
  L1_2 = L1_2.DRAW_LINE
  L2_2 = L0_2.x
  L3_2 = L0_2.y
  L4_2 = L0_2.z
  L5_2 = L0_2.x
  L6_2 = L0_2.y
  L7_2 = L0_2.z
  L7_2 = L7_2 + 2
  L8_2 = 0
  L9_2 = 0
  L10_2 = 255
  L11_2 = 255
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
end
L32_1(L33_1, L34_1, L35_1, L36_1, L37_1)
L32_1 = _ENV
L33_1 = "wasdww"
L34_1 = _ENV
L35_1 = "menu"
L34_1 = L34_1[L35_1]
L35_1 = "list"
L34_1 = L34_1[L35_1]
L35_1 = _ENV
L36_1 = "otherlist"
L35_1 = L35_1[L36_1]
L36_1 = "按键显示"
L37_1 = {}
L38_1 = ""
L34_1 = L34_1(L35_1, L36_1, L37_1, L38_1)
L32_1[L33_1] = L34_1
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L33_1 = "toggle_loop"
L32_1 = L32_1[L33_1]
L33_1 = _ENV
L34_1 = "wasdww"
L33_1 = L33_1[L34_1]
L34_1 = "打开"
L35_1 = {}
L36_1 = ""
function L37_1()
  local L0_2, L1_2
  L0_2 = key_display
  L0_2()
end
L32_1(L33_1, L34_1, L35_1, L36_1, L37_1)
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L33_1 = "slider"
L32_1 = L32_1[L33_1]
L33_1 = _ENV
L34_1 = "wasdww"
L33_1 = L33_1[L34_1]
L34_1 = "X轴"
L35_1 = {}
L36_1 = ""
L35_1[1] = L36_1
L36_1 = ""
L37_1 = 1
L38_1 = 10000
L39_1 = _ENV
L40_1 = "overlay_x"
L39_1 = L39_1[L40_1]
L40_1 = 10000
L39_1 = L39_1 * L40_1
L40_1 = 20
function L41_1(A0_2)
  local L1_2
  L1_2 = A0_2 / 10000
  overlay_x = L1_2
end
L32_1(L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1)
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L33_1 = "slider"
L32_1 = L32_1[L33_1]
L33_1 = _ENV
L34_1 = "wasdww"
L33_1 = L33_1[L34_1]
L34_1 = "Y轴"
L35_1 = {}
L36_1 = ""
L35_1[1] = L36_1
L36_1 = ""
L37_1 = 1
L38_1 = 10000
L39_1 = _ENV
L40_1 = "overlay_y"
L39_1 = L39_1[L40_1]
L40_1 = 10000
L39_1 = L39_1 * L40_1
L40_1 = 20
function L41_1(A0_2)
  local L1_2
  L1_2 = A0_2 / 10000
  overlay_y = L1_2
end
L32_1(L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1)
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L33_1 = "slider"
L32_1 = L32_1[L33_1]
L33_1 = _ENV
L34_1 = "wasdww"
L33_1 = L33_1[L34_1]
L34_1 = "大小"
L35_1 = {}
L36_1 = ""
L35_1[1] = L36_1
L36_1 = ""
L37_1 = 1
L38_1 = 10000
L39_1 = 300
L40_1 = 20
function L41_1(A0_2)
  local L1_2
  L1_2 = A0_2 / 10000
  size = L1_2
  L1_2 = size
  L1_2 = L1_2 / 7
  boxMargin = L1_2
end
L32_1(L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1)
L32_1 = _ENV
L33_1 = "kongzhitai"
L34_1 = _ENV
L35_1 = "menu"
L34_1 = L34_1[L35_1]
L35_1 = "list"
L34_1 = L34_1[L35_1]
L35_1 = _ENV
L36_1 = "otherlist"
L35_1 = L35_1[L36_1]
L36_1 = "控制台"
L37_1 = {}
L38_1 = ""
L34_1 = L34_1(L35_1, L36_1, L37_1, L38_1)
L32_1[L33_1] = L34_1
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L33_1 = "toggle_loop"
L32_1 = L32_1[L33_1]
L33_1 = _ENV
L34_1 = "kongzhitai"
L33_1 = L33_1[L34_1]
L34_1 = "绘制控制台"
L35_1 = {}
L36_1 = ""
function L37_1()
  local L0_2, L1_2
  L0_2 = Draw_console
  L0_2()
end
L32_1(L33_1, L34_1, L35_1, L36_1, L37_1)
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L33_1 = "slider"
L32_1 = L32_1[L33_1]
L33_1 = _ENV
L34_1 = "kongzhitai"
L33_1 = L33_1[L34_1]
L34_1 = "最大显示字数"
L35_1 = {}
L36_1 = ""
L37_1 = 1
L38_1 = 200
L39_1 = 110
L40_1 = 1
function L41_1(A0_2)
  local L1_2, L2_2
  L1_2 = console_max_chars
  L2_2 = A0_2
  L1_2(L2_2)
end
L32_1(L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1)
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L33_1 = "slider"
L32_1 = L32_1[L33_1]
L33_1 = _ENV
L34_1 = "kongzhitai"
L33_1 = L33_1[L34_1]
L34_1 = "最大显示行数"
L35_1 = {}
L36_1 = ""
L37_1 = 1
L38_1 = 60
L39_1 = 25
L40_1 = 1
function L41_1(A0_2)
  local L1_2, L2_2
  L1_2 = console_max_lines
  L2_2 = A0_2
  L1_2(L2_2)
end
L32_1(L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1)
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L33_1 = "slider_float"
L32_1 = L32_1[L33_1]
L33_1 = _ENV
L34_1 = "kongzhitai"
L33_1 = L33_1[L34_1]
L34_1 = "字体大小"
L35_1 = {}
L36_1 = ""
L37_1 = 1
L38_1 = 100
L39_1 = 45
L40_1 = 1
function L41_1(A0_2)
  local L1_2, L2_2
  L1_2 = console_font_size
  L2_2 = A0_2
  L1_2(L2_2)
end
L32_1(L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1)
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L32_1 = L32_1.colour
L33_1 = _ENV
L34_1 = "kongzhitai"
L33_1 = L33_1[L34_1]
L34_1 = "字体颜色"
L35_1 = {}
L36_1 = "nconsoletextcolor"
L35_1[1] = L36_1
L36_1 = ""
L37_1 = 0.27
L38_1 = 1
L39_1 = 1
L40_1 = 1
L41_1 = true
function L42_1(A0_2)
  local L1_2
  console_text_color = A0_2
end
L32_1(L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1, L42_1)
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L32_1 = L32_1.colour
L33_1 = _ENV
L34_1 = "kongzhitai"
L33_1 = L33_1[L34_1]
L34_1 = "背景颜色"
L35_1 = {}
L36_1 = "nconsolebgcolor"
L35_1[1] = L36_1
L36_1 = ""
L37_1 = 0
L38_1 = 0
L39_1 = 0
L40_1 = 0.5
L41_1 = true
function L42_1(A0_2)
  local L1_2
  console_bg_color = A0_2
end
L32_1(L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1, L42_1)
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L33_1 = "toggle_loop"
L32_1 = L32_1[L33_1]
L33_1 = _ENV
L34_1 = "otherlist"
L33_1 = L33_1[L34_1]
L34_1 = "显示logo"
L35_1 = {}
L36_1 = ""
function L37_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L0_2 = directx
  L0_2 = L0_2.create_texture
  L1_2 = filesystem
  L1_2 = L1_2.resources_dir
  L1_2 = L1_2()
  L2_2 = "/SakuraImg/Img/"
  L3_2 = "banner.png"
  L1_2 = L1_2 .. L2_2 .. L3_2
  L0_2 = L0_2(L1_2)
  L1_2 = directx
  L1_2 = L1_2.draw_texture
  L2_2 = L0_2
  L3_2 = 0.06
  L4_2 = 0.1
  L5_2 = 0.0
  L6_2 = 0.0
  L7_2 = 0.86
  L8_2 = 0.57
  L9_2 = 0
  L10_2 = 1
  L11_2 = 1
  L12_2 = 1
  L13_2 = 1
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
end
L32_1(L33_1, L34_1, L35_1, L36_1, L37_1)
L32_1 = _ENV
L33_1 = "pendants"
L34_1 = _ENV
L35_1 = "menu"
L34_1 = L34_1[L35_1]
L35_1 = "list"
L34_1 = L34_1[L35_1]
L35_1 = _ENV
L36_1 = "otherlist"
L35_1 = L35_1[L36_1]
L36_1 = "小挂件"
L37_1 = {}
L38_1 = ""
L34_1 = L34_1(L35_1, L36_1, L37_1, L38_1)
L32_1[L33_1] = L34_1
L32_1 = _ENV
L33_1 = "menu"
L32_1 = L32_1[L33_1]
L33_1 = "toggle_loop"
L32_1 = L32_1[L33_1]
L33_1 = _ENV
L34_1 = "pendants"
L33_1 = L33_1[L34_1]
L34_1 = "猫和老鼠"
L35_1 = {}
L36_1 = ""
function L37_1()
  local L0_2, L1_2
  L0_2 = dd_showpng
  L0_2()
end
L32_1(L33_1, L34_1, L35_1, L36_1, L37_1)
L32_1 = _ENV
L33_1 = "illustration"
L34_1 = _ENV
L35_1 = "menu"
L34_1 = L34_1[L35_1]
L35_1 = "list"
L34_1 = L34_1[L35_1]
L35_1 = _ENV
L36_1 = "pendants"
L35_1 = L35_1[L36_1]
L36_1 = "插图"
L37_1 = {}
L38_1 = ""
L34_1 = L34_1(L35_1, L36_1, L37_1, L38_1)
L32_1[L33_1] = L34_1
L32_1 = 1
L33_1 = 0.5
L34_1 = 0.5
L35_1 = 0.1
L36_1 = _ENV
L37_1 = "directx"
L36_1 = L36_1[L37_1]
L37_1 = "get_client_size"
L36_1 = L36_1[L37_1]
L36_1, L37_1 = L36_1()
L38_1 = _ENV
L39_1 = "directx"
L38_1 = L38_1[L39_1]
L39_1 = "create_texture"
L38_1 = L38_1[L39_1]
L39_1 = _ENV
L40_1 = "filesystem"
L39_1 = L39_1[L40_1]
L40_1 = "resources_dir"
L39_1 = L39_1[L40_1]
L39_1 = L39_1()
L40_1 = "/SakuraImg/illustrations/1.png"
L39_1 = L39_1 .. L40_1
L38_1 = L38_1(L39_1)
L39_1 = _ENV
L40_1 = "menu"
L39_1 = L39_1[L40_1]
L40_1 = "toggle_loop"
L39_1 = L39_1[L40_1]
L40_1 = _ENV
L41_1 = "illustration"
L40_1 = L40_1[L41_1]
L41_1 = "开启"
L42_1 = {}
L43_1 = ""
function L44_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L0_2 = directx
  L0_2 = L0_2.draw_texture
  L1_2 = L38_1
  L2_2 = L35_1
  L3_2 = L35_1
  L4_2 = 0.5
  L5_2 = 0.5
  L6_2 = L33_1
  L7_2 = L34_1
  L8_2 = 0
  L9_2 = 1
  L10_2 = 1
  L11_2 = 1
  L12_2 = 1
  L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
end
L39_1(L40_1, L41_1, L42_1, L43_1, L44_1)
L39_1 = _ENV
L40_1 = "menu"
L39_1 = L39_1[L40_1]
L40_1 = "slider"
L39_1 = L39_1[L40_1]
L40_1 = _ENV
L41_1 = "illustration"
L40_1 = L40_1[L41_1]
L41_1 = "X位置"
L42_1 = {}
L43_1 = "illx"
L42_1[1] = L43_1
L43_1 = ""
L44_1 = 0
L45_1 = _ENV
L46_1 = "math"
L45_1 = L45_1[L46_1]
L46_1 = "floor"
L45_1 = L45_1[L46_1]
L46_1 = L36_1
L45_1 = L45_1(L46_1)
L46_1 = _ENV
L47_1 = "math"
L46_1 = L46_1[L47_1]
L47_1 = "floor"
L46_1 = L46_1[L47_1]
L47_1 = 2
L47_1 = L36_1 / L47_1
L46_1 = L46_1(L47_1)
L47_1 = 10
function L48_1(A0_2)
  local L1_2
  L1_2 = L36_1
  L1_2 = A0_2 / L1_2
  L33_1 = L1_2
end
L39_1(L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1)
L39_1 = _ENV
L40_1 = "menu"
L39_1 = L39_1[L40_1]
L40_1 = "slider"
L39_1 = L39_1[L40_1]
L40_1 = _ENV
L41_1 = "illustration"
L40_1 = L40_1[L41_1]
L41_1 = "Y位置"
L42_1 = {}
L43_1 = "illy"
L42_1[1] = L43_1
L43_1 = ""
L44_1 = 0
L45_1 = _ENV
L46_1 = "math"
L45_1 = L45_1[L46_1]
L46_1 = "floor"
L45_1 = L45_1[L46_1]
L46_1 = L37_1
L45_1 = L45_1(L46_1)
L46_1 = _ENV
L47_1 = "math"
L46_1 = L46_1[L47_1]
L47_1 = "floor"
L46_1 = L46_1[L47_1]
L47_1 = 2
L47_1 = L37_1 / L47_1
L46_1 = L46_1(L47_1)
L47_1 = 10
function L48_1(A0_2)
  local L1_2
  L1_2 = L37_1
  L1_2 = A0_2 / L1_2
  L34_1 = L1_2
end
L39_1(L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1)
L39_1 = _ENV
L40_1 = "menu"
L39_1 = L39_1[L40_1]
L40_1 = "slider_float"
L39_1 = L39_1[L40_1]
L40_1 = _ENV
L41_1 = "illustration"
L40_1 = L40_1[L41_1]
L41_1 = "尺寸"
L42_1 = {}
L43_1 = "illsize"
L42_1[1] = L43_1
L43_1 = ""
L44_1 = 0
L45_1 = 200
L46_1 = 80
L47_1 = 1
function L48_1(A0_2)
  local L1_2
  L1_2 = A0_2 / 800
  L35_1 = L1_2
end
L39_1(L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1)
L39_1 = _ENV
L40_1 = "menu"
L39_1 = L39_1[L40_1]
L40_1 = "slider"
L39_1 = L39_1[L40_1]
L40_1 = _ENV
L41_1 = "illustration"
L40_1 = L40_1[L41_1]
L41_1 = "序号"
L42_1 = {}
L43_1 = ""
L44_1 = 1
L45_1 = 14
L46_1 = 1
L47_1 = 1
function L48_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = directx
  L1_2 = L1_2.create_texture
  L2_2 = filesystem
  L2_2 = L2_2.resources_dir
  L2_2 = L2_2()
  L3_2 = "/SakuraImg/illustrations/"
  L4_2 = A0_2
  L5_2 = ".png"
  L2_2 = L2_2 .. L3_2 .. L4_2 .. L5_2
  L1_2 = L1_2(L2_2)
  L38_1 = L1_2
end
L39_1(L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1)
L39_1 = _ENV
L40_1 = "kanalogo"
L41_1 = _ENV
L42_1 = "menu"
L41_1 = L41_1[L42_1]
L42_1 = "list"
L41_1 = L41_1[L42_1]
L42_1 = _ENV
L43_1 = "pendants"
L42_1 = L42_1[L43_1]
L43_1 = "康娜"
L44_1 = {}
L45_1 = ""
L41_1 = L41_1(L42_1, L43_1, L44_1, L45_1)
L39_1[L40_1] = L41_1
L39_1 = _ENV
L40_1 = "menu"
L39_1 = L39_1[L40_1]
L40_1 = "toggle"
L39_1 = L39_1[L40_1]
L40_1 = _ENV
L41_1 = "kanalogo"
L40_1 = L40_1[L41_1]
L41_1 = "开启"
L42_1 = {}
L43_1 = ""
function L44_1(A0_2)
  local L1_2, L2_2
  L1_2 = GIF_kana
  L2_2 = A0_2
  L1_2(L2_2)
end
L39_1(L40_1, L41_1, L42_1, L43_1, L44_1)
L39_1 = _ENV
L40_1 = "menu"
L39_1 = L39_1[L40_1]
L40_1 = "slider"
L39_1 = L39_1[L40_1]
L40_1 = _ENV
L41_1 = "kanalogo"
L40_1 = L40_1[L41_1]
L41_1 = "x坐标"
L42_1 = {}
L43_1 = "logocoord-x"
L42_1[1] = L43_1
L43_1 = ""
L44_1 = -100
L45_1 = 100
L46_1 = 86
L47_1 = 1
function L48_1(A0_2)
  local L1_2, L2_2
  L1_2 = logocoord
  L2_2 = A0_2 / 100
  L1_2.x = L2_2
end
L39_1(L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1)
L39_1 = _ENV
L40_1 = "menu"
L39_1 = L39_1[L40_1]
L40_1 = "slider"
L39_1 = L39_1[L40_1]
L40_1 = _ENV
L41_1 = "kanalogo"
L40_1 = L40_1[L41_1]
L41_1 = "y坐标"
L42_1 = {}
L43_1 = "logocoord-y"
L42_1[1] = L43_1
L43_1 = ""
L44_1 = -100
L45_1 = 100
L46_1 = 57
L47_1 = 1
function L48_1(A0_2)
  local L1_2, L2_2
  L1_2 = logocoord
  L2_2 = A0_2 / 100
  L1_2.y = L2_2
end
L39_1(L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1)
L39_1 = _ENV
L40_1 = "menu"
L39_1 = L39_1[L40_1]
L40_1 = "slider"
L39_1 = L39_1[L40_1]
L40_1 = _ENV
L41_1 = "kanalogo"
L40_1 = L40_1[L41_1]
L41_1 = "图标过渡帧率"
L42_1 = {}
L43_1 = ""
L44_1 = 1
L45_1 = 60
L46_1 = 10
L47_1 = 1
function L48_1(A0_2)
  local L1_2, L2_2
  L1_2 = logocoord
  L2_2 = 1000
  L2_2 = L2_2 / A0_2
  L1_2.fps = L2_2
end
L39_1(L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1)
L39_1 = _ENV
L40_1 = "xiaohuangrenlogo"
L41_1 = _ENV
L42_1 = "menu"
L41_1 = L41_1[L42_1]
L42_1 = "list"
L41_1 = L41_1[L42_1]
L42_1 = _ENV
L43_1 = "pendants"
L42_1 = L42_1[L43_1]
L43_1 = "小黄人"
L44_1 = {}
L45_1 = ""
L41_1 = L41_1(L42_1, L43_1, L44_1, L45_1)
L39_1[L40_1] = L41_1
L39_1 = _ENV
L40_1 = "menu"
L39_1 = L39_1[L40_1]
L40_1 = "toggle"
L39_1 = L39_1[L40_1]
L40_1 = _ENV
L41_1 = "xiaohuangrenlogo"
L40_1 = L40_1[L41_1]
L41_1 = "开启"
L42_1 = {}
L43_1 = ""
function L44_1(A0_2)
  local L1_2, L2_2
  L1_2 = GIF_xiaohuangren
  L2_2 = A0_2
  L1_2(L2_2)
end
L39_1(L40_1, L41_1, L42_1, L43_1, L44_1)
L39_1 = _ENV
L40_1 = "menu"
L39_1 = L39_1[L40_1]
L40_1 = "slider"
L39_1 = L39_1[L40_1]
L40_1 = _ENV
L41_1 = "xiaohuangrenlogo"
L40_1 = L40_1[L41_1]
L41_1 = "x坐标"
L42_1 = {}
L43_1 = "logocoord1-x"
L42_1[1] = L43_1
L43_1 = ""
L44_1 = -100
L45_1 = 100
L46_1 = 86
L47_1 = 1
function L48_1(A0_2)
  local L1_2, L2_2
  L1_2 = logocoord1
  L2_2 = A0_2 / 100
  L1_2.x = L2_2
end
L39_1(L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1)
L39_1 = _ENV
L40_1 = "menu"
L39_1 = L39_1[L40_1]
L40_1 = "slider"
L39_1 = L39_1[L40_1]
L40_1 = _ENV
L41_1 = "xiaohuangrenlogo"
L40_1 = L40_1[L41_1]
L41_1 = "y坐标"
L42_1 = {}
L43_1 = "logocoord1-y"
L42_1[1] = L43_1
L43_1 = ""
L44_1 = -100
L45_1 = 100
L46_1 = 57
L47_1 = 1
function L48_1(A0_2)
  local L1_2, L2_2
  L1_2 = logocoord1
  L2_2 = A0_2 / 100
  L1_2.y = L2_2
end
L39_1(L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1)
L39_1 = _ENV
L40_1 = "menu"
L39_1 = L39_1[L40_1]
L40_1 = "slider"
L39_1 = L39_1[L40_1]
L40_1 = _ENV
L41_1 = "xiaohuangrenlogo"
L40_1 = L40_1[L41_1]
L41_1 = "图标过渡帧率"
L42_1 = {}
L43_1 = ""
L44_1 = 1
L45_1 = 60
L46_1 = 15
L47_1 = 1
function L48_1(A0_2)
  local L1_2, L2_2
  L1_2 = logocoord1
  L2_2 = 1000
  L2_2 = L2_2 / A0_2
  L1_2.fps = L2_2
end
L39_1(L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1)
L39_1 = _ENV
L40_1 = "back_story"
L41_1 = _ENV
L42_1 = "menu"
L41_1 = L41_1[L42_1]
L42_1 = "list"
L41_1 = L41_1[L42_1]
L42_1 = _ENV
L43_1 = "otherlist"
L42_1 = L42_1[L43_1]
L43_1 = "故事模式"
L44_1 = {}
L45_1 = ""
L41_1 = L41_1(L42_1, L43_1, L44_1, L45_1)
L39_1[L40_1] = L41_1
L39_1 = _ENV
L40_1 = "menu"
L39_1 = L39_1[L40_1]
L40_1 = "action"
L39_1 = L39_1[L40_1]
L40_1 = _ENV
L41_1 = "back_story"
L40_1 = L40_1[L41_1]
L41_1 = "退回故事模式"
L42_1 = {}
L43_1 = ""
function L44_1()
  local L0_2, L1_2
  L0_2 = menu
  L0_2 = L0_2.trigger_commands
  L1_2 = "quittosp"
  L0_2(L1_2)
end
L39_1(L40_1, L41_1, L42_1, L43_1, L44_1)
L39_1 = _ENV
L40_1 = "menu"
L39_1 = L39_1[L40_1]
L40_1 = "action"
L39_1 = L39_1[L40_1]
L40_1 = _ENV
L41_1 = "back_story"
L40_1 = L40_1[L41_1]
L41_1 = "卡回故事模式"
L42_1 = {}
L43_1 = ""
function L44_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = NETWORK
  L0_2 = L0_2.NETWORK_BAIL
  L1_2 = 0
  L2_2 = 0
  L3_2 = 0
  L0_2(L1_2, L2_2, L3_2)
end
L39_1(L40_1, L41_1, L42_1, L43_1, L44_1)
L39_1 = _ENV
L40_1 = "menu"
L39_1 = L39_1[L40_1]
L40_1 = "action"
L39_1 = L39_1[L40_1]
L40_1 = _ENV
L41_1 = "back_story"
L40_1 = L40_1[L41_1]
L41_1 = "强制退回故事模式"
L42_1 = {}
L43_1 = ""
function L44_1()
  local L0_2, L1_2
  L0_2 = NETWORK1
  L0_2 = L0_2._SHUTDOWN_AND_LOAD_MOST_RECENT_SAVE
  L0_2()
end
L39_1(L40_1, L41_1, L42_1, L43_1, L44_1)
L39_1 = _ENV
L40_1 = "menu"
L39_1 = L39_1[L40_1]
L40_1 = "action"
L39_1 = L39_1[L40_1]
L40_1 = _ENV
L41_1 = "otherlist"
L40_1 = L40_1[L41_1]
L41_1 = "重启GTAV"
L42_1 = {}
L43_1 = ""
function L44_1()
  local L0_2, L1_2
  L0_2 = MISC1
  L0_2 = L0_2._RESTART_GAME
  L0_2()
end
L39_1(L40_1, L41_1, L42_1, L43_1, L44_1)
L39_1 = _ENV
L40_1 = "menu"
L39_1 = L39_1[L40_1]
L40_1 = "action"
L39_1 = L39_1[L40_1]
L40_1 = _ENV
L41_1 = "otherlist"
L40_1 = L40_1[L41_1]
L41_1 = "快速关闭GTAV"
L42_1 = {}
L43_1 = "正如你所见,秒关GTA5"
function L44_1()
  local L0_2, L1_2
  L0_2 = exit_game
  L0_2()
end
L39_1(L40_1, L41_1, L42_1, L43_1, L44_1)
L39_1 = _ENV
L40_1 = "menu"
L39_1 = L39_1[L40_1]
L40_1 = "toggle_loop"
L39_1 = L39_1[L40_1]
L40_1 = _ENV
L41_1 = "otherlist"
L40_1 = L40_1[L41_1]
L41_1 = "绘制坐标"
L42_1 = {}
L43_1 = ""
function L44_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = ENTITY
  L0_2 = L0_2.GET_ENTITY_COORDS
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = true
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = "~b~ pos x:  ~w~"
  L2_2 = L0_2.x
  L3_2 = [[

~b~ pos y:  ~w~]]
  L4_2 = L0_2.y
  L5_2 = [[

~b~ pos z:  ~w~]]
  L6_2 = L0_2.z
  L1_2 = L1_2 .. L2_2 .. L3_2 .. L4_2 .. L5_2 .. L6_2
  L2_2 = draw_string
  L3_2 = L1_2
  L4_2 = 0.85
  L5_2 = 0.1
  L6_2 = 0.5
  L7_2 = 4
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
end
L39_1(L40_1, L41_1, L42_1, L43_1, L44_1)
L39_1 = _ENV
L40_1 = "menu"
L39_1 = L39_1[L40_1]
L40_1 = "hyperlink"
L39_1 = L39_1[L40_1]
L40_1 = _ENV
L41_1 = "otherlist"
L40_1 = L40_1[L41_1]
L41_1 = "加入群聊"
L42_1 = "http://qm.qq.com/cgi-bin/qm/qr?_wv=1027&k=yWvVaHDSQ_nlZBvi9LGG1m8-W0iimfC7&authKey=MPSJ77fLN%2FO4XKiIbKHieSYCZbrw4PTvylOwHbZX4PnjctBMo0ocv4EE%2FdEGkVRy&noverify=0&group_code=343798401"
L43_1 = "daidaiLua官方群"
L39_1(L40_1, L41_1, L42_1, L43_1)
L39_1 = _ENV
L40_1 = "menu"
L39_1 = L39_1[L40_1]
L40_1 = "action"
L39_1 = L39_1[L40_1]
L40_1 = _ENV
L41_1 = "otherlist"
L40_1 = L40_1[L41_1]
L41_1 = "保存配置"
L42_1 = {}
L43_1 = "仅支持部分功能(即帮助文本中包含'配置[√]')"
function L44_1()
  local L0_2, L1_2
  L0_2 = save_config
  L0_2()
end
L39_1(L40_1, L41_1, L42_1, L43_1, L44_1)
L39_1 = _ENV
L40_1 = "players"
L39_1 = L39_1[L40_1]
L40_1 = "dispatch_on_join"
L39_1 = L39_1[L40_1]
L39_1()
L39_1 = _ENV
L40_1 = "menu"
L39_1 = L39_1[L40_1]
L40_1 = "apply_command_states"
L39_1 = L39_1[L40_1]
L39_1()
L39_1 = util
L40_1 = "on_stop"
L39_1 = L39_1[L40_1]
function L40_1()
  local L0_2, L1_2
  L0_2 = L0_1.exists
  L0_2 = L0_2()
  if L0_2 then
    L0_2 = L0_1.destroy
    L0_2()
  end
  L0_2 = L1_1.exists
  L0_2 = L0_2()
  if L0_2 then
    L0_2 = L1_1.destroy
    L0_2()
  end
  L0_2 = L3_1.exists
  L0_2 = L0_2()
  if L0_2 then
    L0_2 = L3_1.destroy
    L0_2()
  end
  L0_2 = blurrect_free
  L0_2()
  L0_2 = util
  L0_2 = L0_2.log
  L1_2 = "[Sakura] 脚本已关闭"
  L0_2(L1_2)
end
L39_1(L40_1)
while true do
  L39_1 = _ENV
  L40_1 = "bodyguardMenu"
  L39_1 = L39_1[L40_1]
  L41_1 = "onTick"
  L40_1 = L39_1
  L39_1 = L39_1[L41_1]
  L39_1(L40_1)
  L39_1 = _ENV
  L40_1 = "Black_list"
  L39_1 = L39_1[L40_1]
  L39_1()
  L39_1 = _ENV
  L40_1 = "Black_self"
  L39_1 = L39_1[L40_1]
  L39_1()
  L39_1 = "mainLoop"
  L39_1 = L1_1[L39_1]
  L39_1()
  L39_1 = "mainLoop"
  L39_1 = L0_1[L39_1]
  L39_1()
  L39_1 = "mainLoop"
  L39_1 = L3_1[L39_1]
  L39_1()
  L39_1 = _ENV
  L40_1 = "all_drive_style"
  L39_1 = L39_1[L40_1]
  L39_1()
  L39_1 = _ENV
  L40_1 = "util"
  L39_1 = L39_1[L40_1]
  L40_1 = "yield"
  L39_1 = L39_1[L40_1]
  L39_1()
end
