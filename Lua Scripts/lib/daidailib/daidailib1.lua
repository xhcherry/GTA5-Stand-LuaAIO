local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1, L49_1, L50_1, L51_1, L52_1, L53_1, L54_1, L55_1, L56_1, L57_1, L58_1, L59_1, L60_1, L61_1, L62_1, L63_1, L64_1, L65_1, L66_1, L67_1, L68_1, L69_1, L70_1, L71_1, L72_1, L73_1, L74_1, L75_1, L76_1, L77_1, L78_1, L79_1, L80_1, L81_1, L82_1, L83_1, L84_1, L85_1, L86_1, L87_1, L88_1, L89_1, L90_1, L91_1, L92_1, L93_1, L94_1, L95_1, L96_1, L97_1, L98_1, L99_1, L100_1, L101_1, L102_1, L103_1, L104_1, L105_1, L106_1, L107_1, L108_1, L109_1, L110_1, L111_1, L112_1, L113_1, L114_1, L115_1, L116_1, L117_1, L118_1, L119_1, L120_1, L121_1, L122_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L1_2 = {}
  L2_2 = {}
  L1_2.components = L2_2
  L2_2 = {}
  L1_2.props = L2_2
  L2_2 = 0
  L3_2 = 11
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = L1_2.components
    L7_2 = {}
    L8_2 = PED
    L8_2 = L8_2.GET_PED_DRAWABLE_VARIATION
    L9_2 = A0_2
    L10_2 = L5_2
    L8_2 = L8_2(L9_2, L10_2)
    L9_2 = PED
    L9_2 = L9_2.GET_PED_TEXTURE_VARIATION
    L10_2 = A0_2
    L11_2 = L5_2
    L9_2, L10_2, L11_2 = L9_2(L10_2, L11_2)
    L7_2[1] = L8_2
    L7_2[2] = L9_2
    L7_2[3] = L10_2
    L7_2[4] = L11_2
    L6_2[L5_2] = L7_2
  end
  L2_2 = 0
  L3_2 = 9
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = L1_2.props
    L7_2 = {}
    L8_2 = PED
    L8_2 = L8_2.GET_PED_PROP_INDEX
    L9_2 = A0_2
    L10_2 = L5_2
    L8_2 = L8_2(L9_2, L10_2)
    L9_2 = PED
    L9_2 = L9_2.GET_PED_PROP_TEXTURE_INDEX
    L10_2 = A0_2
    L11_2 = L5_2
    L9_2, L10_2, L11_2 = L9_2(L10_2, L11_2)
    L7_2[1] = L8_2
    L7_2[2] = L9_2
    L7_2[3] = L10_2
    L7_2[4] = L11_2
    L6_2[L5_2] = L7_2
  end
  return L1_2
end
get_outfit = L0_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L2_2 = pairs
  L3_2 = A0_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = PED
    L8_2 = L8_2.SET_PED_COMPONENT_VARIATION
    L9_2 = PLAYER
    L9_2 = L9_2.PLAYER_PED_ID
    L9_2 = L9_2()
    L10_2 = tonumber
    L11_2 = L6_2
    L10_2 = L10_2(L11_2)
    L11_2 = L7_2[1]
    L12_2 = L7_2[2]
    L13_2 = 0
    L8_2(L9_2, L10_2, L11_2, L12_2, L13_2)
  end
  L2_2 = pairs
  L3_2 = A1_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = L7_2[1]
    if -1 == L8_2 then
      L8_2 = PED
      L8_2 = L8_2.CLEAR_PED_PROP
      L9_2 = PLAYER
      L9_2 = L9_2.PLAYER_PED_ID
      L9_2 = L9_2()
      L10_2 = tonumber
      L11_2 = L6_2
      L10_2, L11_2, L12_2, L13_2 = L10_2(L11_2)
      L8_2(L9_2, L10_2, L11_2, L12_2, L13_2)
    else
      L8_2 = PED
      L8_2 = L8_2.SET_PED_PROP_INDEX
      L9_2 = PLAYER
      L9_2 = L9_2.PLAYER_PED_ID
      L9_2 = L9_2()
      L10_2 = tonumber
      L11_2 = L6_2
      L10_2 = L10_2(L11_2)
      L11_2 = L7_2[1]
      L12_2 = L7_2[2]
      L13_2 = true
      L8_2(L9_2, L10_2, L11_2, L12_2, L13_2)
    end
  end
end
apply_outfit = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L1_2 = NETWORK
  L1_2 = L1_2.NETWORK_IS_PLAYER_CONNECTED
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if 0 == L1_2 then
    return
  end
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_MODEL
  L3_2 = L1_2
  L2_2 = L2_2(L3_2)
  L3_2 = get_outfit
  L4_2 = L1_2
  L3_2 = L3_2(L4_2)
  L4_2 = ENTITY
  L4_2 = L4_2.GET_ENTITY_MODEL
  L5_2 = PLAYER
  L5_2 = L5_2.PLAYER_PED_ID
  L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L5_2()
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  if L2_2 ~= L4_2 then
    L4_2 = change_model
    L5_2 = PLAYER
    L5_2 = L5_2.PLAYER_ID
    L5_2 = L5_2()
    L6_2 = L2_2
    L4_2(L5_2, L6_2)
    L4_2 = PED1
    L4_2 = L4_2._SET_PED_EYE_COLOR
    L5_2 = PLAYER
    L5_2 = L5_2.PLAYER_ID
    L5_2 = L5_2()
    L6_2 = PED1
    L6_2 = L6_2._GET_PED_EYE_COLOR
    L7_2 = L1_2
    L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L6_2(L7_2)
    L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
    L4_2 = 0
    L5_2 = 12
    L6_2 = 1
    for L7_2 = L4_2, L5_2, L6_2 do
      L8_2 = PED
      L8_2 = L8_2.SET_PED_HEAD_OVERLAY
      L9_2 = PLAYER
      L9_2 = L9_2.PLAYER_PED_ID
      L9_2 = L9_2()
      L10_2 = L7_2
      L11_2 = PED1
      L11_2 = L11_2._GET_PED_HEAD_OVERLAY_VALUE
      L12_2 = L1_2
      L13_2 = L7_2
      L11_2 = L11_2(L12_2, L13_2)
      L12_2 = 0
      L8_2(L9_2, L10_2, L11_2, L12_2)
    end
    L4_2 = apply_outfit
    L5_2 = L3_2.components
    L6_2 = L3_2.props
    L4_2(L5_2, L6_2)
  else
    L4_2 = apply_outfit
    L5_2 = L3_2.components
    L6_2 = L3_2.props
    L4_2(L5_2, L6_2)
  end
end
copy_outfit = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L1_2 = {}
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_MODEL
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L1_2.hash = L2_2
  L2_2 = VEHICLE
  L2_2 = L2_2.GET_VEHICLE_WHEEL_TYPE
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L1_2.wheelType = L2_2
  L2_2 = {}
  L1_2.mods = L2_2
  L2_2 = 0
  L3_2 = 49
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = L1_2.mods
    L7_2 = VEHICLE
    L7_2 = L7_2.GET_VEHICLE_MOD
    L8_2 = A0_2
    L9_2 = L5_2
    L7_2 = L7_2(L8_2, L9_2)
    L6_2[L5_2] = L7_2
  end
  L2_2 = VEHICLE
  L2_2 = L2_2.GET_VEHICLE_TYRES_CAN_BURST
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L2_2 = 1 == L2_2
  L1_2.tyresCanBurst = L2_2
  L2_2 = memory
  L2_2 = L2_2.alloc
  L3_2 = 4
  L2_2 = L2_2(L3_2)
  L3_2 = memory
  L3_2 = L3_2.alloc
  L4_2 = 4
  L3_2 = L3_2(L4_2)
  L4_2 = memory
  L4_2 = L4_2.alloc
  L5_2 = 4
  L4_2 = L4_2(L5_2)
  L5_2 = VEHICLE
  L5_2 = L5_2.GET_VEHICLE_CUSTOM_PRIMARY_COLOUR
  L6_2 = A0_2
  L7_2 = L2_2
  L8_2 = L3_2
  L9_2 = L4_2
  L5_2(L6_2, L7_2, L8_2, L9_2)
  L5_2 = {}
  L1_2.colors = L5_2
  L5_2 = L1_2.colors
  L6_2 = {}
  L7_2 = memory
  L7_2 = L7_2.read_int
  L8_2 = L2_2
  L7_2 = L7_2(L8_2)
  L6_2.r = L7_2
  L7_2 = memory
  L7_2 = L7_2.read_int
  L8_2 = L3_2
  L7_2 = L7_2(L8_2)
  L6_2.g = L7_2
  L7_2 = memory
  L7_2 = L7_2.read_int
  L8_2 = L4_2
  L7_2 = L7_2(L8_2)
  L6_2.b = L7_2
  L5_2.prim = L6_2
  L5_2 = VEHICLE
  L5_2 = L5_2.GET_VEHICLE_CUSTOM_SECONDARY_COLOUR
  L6_2 = A0_2
  L7_2 = L2_2
  L8_2 = L3_2
  L9_2 = L4_2
  L5_2(L6_2, L7_2, L8_2, L9_2)
  L5_2 = L1_2.colors
  L6_2 = {}
  L7_2 = memory
  L7_2 = L7_2.read_int
  L8_2 = L2_2
  L7_2 = L7_2(L8_2)
  L6_2.r = L7_2
  L7_2 = memory
  L7_2 = L7_2.read_int
  L8_2 = L3_2
  L7_2 = L7_2(L8_2)
  L6_2.g = L7_2
  L7_2 = memory
  L7_2 = L7_2.read_int
  L8_2 = L4_2
  L7_2 = L7_2(L8_2)
  L6_2.b = L7_2
  L5_2.sec = L6_2
  L5_2 = VEHICLE
  L5_2 = L5_2.GET_VEHICLE_EXTRA_COLOURS
  L6_2 = A0_2
  L7_2 = L2_2
  L8_2 = L3_2
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = {}
  L6_2 = memory
  L6_2 = L6_2.read_int
  L7_2 = L2_2
  L6_2 = L6_2(L7_2)
  L5_2.pearl = L6_2
  L6_2 = memory
  L6_2 = L6_2.read_int
  L7_2 = L3_2
  L6_2 = L6_2(L7_2)
  L5_2.wheels = L6_2
  L1_2.extraColors = L5_2
  L5_2 = VEHICLE
  L5_2 = L5_2.GET_VEHICLE_LIVERY
  L6_2 = A0_2
  L5_2 = L5_2(L6_2)
  L1_2.livery = L5_2
  L5_2 = VEHICLE
  L5_2 = L5_2.GET_VEHICLE_NUMBER_PLATE_TEXT
  L6_2 = A0_2
  L5_2 = L5_2(L6_2)
  L1_2.plateText = L5_2
  L5_2 = VEHICLE
  L5_2 = L5_2.GET_VEHICLE_PLATE_TYPE
  L6_2 = A0_2
  L5_2 = L5_2(L6_2)
  L1_2.plateType = L5_2
  L5_2 = VEHICLE
  L5_2 = L5_2.GET_CONVERTIBLE_ROOF_STATE
  L6_2 = A0_2
  L5_2 = L5_2(L6_2)
  L1_2.roofState = L5_2
  L5_2 = {}
  L1_2.neonColors = L5_2
  L5_2 = L1_2.neonColors
  L6_2 = L1_2.neonColors
  L7_2 = L1_2.neonColors
  L8_2 = memory
  L8_2 = L8_2.read_int
  L9_2 = L2_2
  L8_2 = L8_2(L9_2)
  L9_2 = memory
  L9_2 = L9_2.read_int
  L10_2 = L3_2
  L9_2 = L9_2(L10_2)
  L10_2 = memory
  L10_2 = L10_2.read_int
  L11_2 = L4_2
  L10_2 = L10_2(L11_2)
  L7_2.blue = L10_2
  L6_2.green = L9_2
  L5_2.red = L8_2
  L5_2 = VEHICLE
  L5_2 = L5_2.GET_VEHICLE_TYRE_SMOKE_COLOR
  L6_2 = A0_2
  L7_2 = L2_2
  L8_2 = L3_2
  L9_2 = L4_2
  L5_2(L6_2, L7_2, L8_2, L9_2)
  L5_2 = {}
  L1_2.tyreSmoke = L5_2
  L5_2 = L1_2.tyreSmoke
  L6_2 = L1_2.tyreSmoke
  L7_2 = L1_2.tyreSmoke
  L8_2 = memory
  L8_2 = L8_2.read_int
  L9_2 = L2_2
  L8_2 = L8_2(L9_2)
  L9_2 = memory
  L9_2 = L9_2.read_int
  L10_2 = L3_2
  L9_2 = L9_2(L10_2)
  L10_2 = memory
  L10_2 = L10_2.read_int
  L11_2 = L4_2
  L10_2 = L10_2(L11_2)
  L7_2.blue = L10_2
  L6_2.green = L9_2
  L5_2.red = L8_2
  L5_2 = VEHICLE
  L5_2 = L5_2.GET_VEHICLE_WINDOW_TINT
  L6_2 = A0_2
  L5_2 = L5_2(L6_2)
  L1_2.windowTint = L5_2
  L5_2 = {}
  L1_2.extras = L5_2
  L5_2 = 1
  L6_2 = 9
  L7_2 = 1
  for L8_2 = L5_2, L6_2, L7_2 do
    L9_2 = VEHICLE
    L9_2 = L9_2.DOES_EXTRA_EXIST
    L10_2 = A0_2
    L11_2 = L8_2
    L9_2 = L9_2(L10_2, L11_2)
    if 1 == L9_2 then
      L9_2 = table
      L9_2 = L9_2.insert
      L10_2 = L1_2.extras
      L11_2 = L8_2
      L9_2(L10_2, L11_2)
    end
  end
  return L1_2
end
get_vehicle_info = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L1_2 = PED
  L1_2 = L1_2.IS_PED_IN_ANY_VEHICLE
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED
  L3_2 = A0_2
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L2_2(L3_2)
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  if L1_2 then
    L1_2 = PED
    L1_2 = L1_2.GET_VEHICLE_PED_IS_IN
    L2_2 = PLAYER
    L2_2 = L2_2.GET_PLAYER_PED
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    L3_2 = false
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = get_vehicle_info
    L3_2 = L1_2
    L2_2 = L2_2(L3_2)
    L3_2 = ENTITY
    L3_2 = L3_2.GET_ENTITY_COORDS
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2 = L4_2()
    L5_2 = true
    L3_2 = L3_2(L4_2, L5_2)
    L4_2 = create_vehicle
    L5_2 = L2_2.hash
    L6_2 = L3_2.x
    L7_2 = L3_2.y
    L8_2 = L3_2.z
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
    L5_2 = VEHICLE
    L5_2 = L5_2.SET_VEHICLE_MOD_KIT
    L6_2 = L4_2
    L7_2 = 0
    L5_2(L6_2, L7_2)
    L5_2 = VEHICLE
    L5_2 = L5_2.SET_VEHICLE_WHEEL_TYPE
    L6_2 = L4_2
    L7_2 = L2_2.wheelType
    L5_2(L6_2, L7_2)
    L5_2 = pairs
    L6_2 = L2_2.mods
    L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
    for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
      L11_2 = VEHICLE
      L11_2 = L11_2.SET_VEHICLE_MOD
      L12_2 = L4_2
      L13_2 = tonumber
      L14_2 = L9_2
      L13_2 = L13_2(L14_2)
      L14_2 = tonumber
      L15_2 = L10_2
      L14_2 = L14_2(L15_2)
      L15_2 = false
      L11_2(L12_2, L13_2, L14_2, L15_2)
    end
    L5_2 = VEHICLE
    L5_2 = L5_2.SET_VEHICLE_TYRES_CAN_BURST
    L6_2 = L4_2
    L7_2 = L2_2.tyresCanBurst
    L5_2(L6_2, L7_2)
    L5_2 = VEHICLE
    L5_2 = L5_2.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR
    L6_2 = L4_2
    L7_2 = L2_2.colors
    L7_2 = L7_2.prim
    L7_2 = L7_2.r
    L8_2 = L2_2.colors
    L8_2 = L8_2.prim
    L8_2 = L8_2.g
    L9_2 = L2_2.colors
    L9_2 = L9_2.prim
    L9_2 = L9_2.b
    L5_2(L6_2, L7_2, L8_2, L9_2)
    L5_2 = VEHICLE
    L5_2 = L5_2.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR
    L6_2 = L4_2
    L7_2 = L2_2.colors
    L7_2 = L7_2.sec
    L7_2 = L7_2.r
    L8_2 = L2_2.colors
    L8_2 = L8_2.sec
    L8_2 = L8_2.g
    L9_2 = L2_2.colors
    L9_2 = L9_2.sec
    L9_2 = L9_2.b
    L5_2(L6_2, L7_2, L8_2, L9_2)
    L5_2 = VEHICLE
    L5_2 = L5_2.SET_VEHICLE_EXTRA_COLOURS
    L6_2 = L4_2
    L7_2 = L2_2.extraColors
    L7_2 = L7_2.pearl
    L8_2 = L2_2.extraColors
    L8_2 = L8_2.wheels
    L5_2(L6_2, L7_2, L8_2)
    L5_2 = VEHICLE
    L5_2 = L5_2.SET_VEHICLE_LIVERY
    L6_2 = L4_2
    L7_2 = L2_2.livery
    L5_2(L6_2, L7_2)
    L5_2 = VEHICLE
    L5_2 = L5_2.SET_VEHICLE_NUMBER_PLATE_TEXT
    L6_2 = L4_2
    L7_2 = L2_2.plateText
    L5_2(L6_2, L7_2)
    L5_2 = VEHICLE
    L5_2 = L5_2.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX
    L6_2 = L4_2
    L7_2 = L2_2.plateType
    L5_2(L6_2, L7_2)
    L5_2 = VEHICLE
    L5_2 = L5_2.SET_CONVERTIBLE_ROOF_LATCH_STATE
    L6_2 = L4_2
    L7_2 = L2_2.roofState
    L5_2(L6_2, L7_2)
    L5_2 = VEHICLE
    L5_2 = L5_2.SET_VEHICLE_TYRE_SMOKE_COLOR
    L6_2 = L4_2
    L7_2 = L2_2.tyreSmoke
    L7_2 = L7_2.red
    L8_2 = L2_2.tyreSmoke
    L8_2 = L8_2.green
    L9_2 = L2_2.tyreSmoke
    L9_2 = L9_2.blue
    L5_2(L6_2, L7_2, L8_2, L9_2)
    L5_2 = VEHICLE
    L5_2 = L5_2.SET_VEHICLE_WINDOW_TINT
    L6_2 = L4_2
    L7_2 = L2_2.windowTint
    L5_2(L6_2, L7_2)
    L5_2 = ipairs
    L6_2 = L2_2.extras
    L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
    for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
      L11_2 = VEHICLE
      L11_2 = L11_2.SET_VEHICLE_EXTRA
      L12_2 = L4_2
      L13_2 = L10_2
      L14_2 = false
      L11_2(L12_2, L13_2, L14_2)
    end
  end
end
copy_vehicle = L0_1
L0_1 = {}
modifiedRecoil = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = memory
  L1_2 = L1_2.alloc_int
  L1_2 = L1_2()
  L2_2 = WEAPON
  L2_2 = L2_2.GET_CURRENT_PED_VEHICLE_WEAPON
  L3_2 = A0_2
  L4_2 = L1_2
  L2_2 = L2_2(L3_2, L4_2)
  if L2_2 then
    L2_2 = memory
    L2_2 = L2_2.read_int
    L3_2 = L1_2
    L2_2 = L2_2(L3_2)
    L3_2 = true
    return L2_2, L3_2
  end
  L2_2 = WEAPON
  L2_2 = L2_2.GET_SELECTED_PED_WEAPON
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = false
  return L2_2, L3_2
end
getWeaponHash = L0_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L2_2 = A0_2
  L3_2 = 1
  L4_2 = #A1_2
  L4_2 = L4_2 - 1
  L5_2 = 1
  for L6_2 = L3_2, L4_2, L5_2 do
    L7_2 = memory
    L7_2 = L7_2.read_long
    L8_2 = A1_2[L6_2]
    L8_2 = L2_2 + L8_2
    L7_2 = L7_2(L8_2)
    L2_2 = L7_2
    if 0 == L2_2 then
      L7_2 = 0
      return L7_2
    end
  end
  L3_2 = #A1_2
  L3_2 = A1_2[L3_2]
  L2_2 = L2_2 + L3_2
  return L2_2
end
address_from_pointer_chain = L0_1
function L0_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L3_2 = util
  L3_2 = L3_2.is_session_transition_active
  L3_2 = L3_2()
  if L3_2 then
    L3_2 = 0
    return L3_2
  end
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2 = L3_2()
  L4_2 = getWeaponHash
  L5_2 = L3_2
  L4_2, L5_2 = L4_2(L5_2)
  if A2_2 then
    L6_2 = A0_2[L4_2]
    if L6_2 then
      L6_2 = 0
      return L6_2
    end
  end
  if L5_2 then
    L6_2 = 112
    if L6_2 then
      goto lbl_27
    end
  end
  L6_2 = 32
  ::lbl_27::
  L7_2 = address_from_pointer_chain
  L8_2 = entities
  L8_2 = L8_2.handle_to_pointer
  L9_2 = L3_2
  L8_2 = L8_2(L9_2)
  L9_2 = {}
  L10_2 = 4280
  L11_2 = L6_2
  L12_2 = A1_2
  L9_2[1] = L10_2
  L9_2[2] = L11_2
  L9_2[3] = L12_2
  L7_2 = L7_2(L8_2, L9_2)
  if 0 == L7_2 then
    L8_2 = menu
    L8_2 = L8_2.toast
    L9_2 = "Failed to find memory address."
    L8_2(L9_2)
    L8_2 = 0
    return L8_2
  end
  L8_2 = A0_2[L4_2]
  if nil == L8_2 then
    L8_2 = {}
    L8_2.address = L7_2
    L9_2 = memory
    L9_2 = L9_2.read_float
    L10_2 = L7_2
    L9_2 = L9_2(L10_2)
    L8_2.original = L9_2
    A0_2[L4_2] = L8_2
  end
  return L4_2
end
readWeaponAddress = L0_1
function L0_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = pairs
  L2_2 = A0_2
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = memory
    L7_2 = L7_2.write_float
    L8_2 = A0_2[L5_2]
    L8_2 = L8_2.address
    L9_2 = A0_2[L5_2]
    L9_2 = L9_2.original
    L7_2(L8_2, L9_2)
    A0_2[L5_2] = nil
  end
end
resetWeapons = L0_1
function L0_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = readWeaponAddress
  L1_2 = modifiedRecoil
  L2_2 = 756
  L3_2 = true
  L0_2 = L0_2(L1_2, L2_2, L3_2)
  if 0 == L0_2 then
    return
  end
  L1_2 = memory
  L1_2 = L1_2.write_float
  L2_2 = modifiedRecoil
  L2_2 = L2_2[L0_2]
  L2_2 = L2_2.address
  L3_2 = 0
  L1_2(L2_2, L3_2)
end
gunpro = L0_1
L0_1 = {}
modifiedRange = L0_1
function L0_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L0_2 = util
  L0_2 = L0_2.is_session_transition_active
  L0_2 = L0_2()
  if L0_2 then
    return
  end
  L0_2 = PLAYER
  L0_2 = L0_2.PLAYER_PED_ID
  L0_2 = L0_2()
  L1_2 = getWeaponHash
  L2_2 = L0_2
  L1_2, L2_2 = L1_2(L2_2)
  L3_2 = modifiedRange
  L3_2 = L3_2[L1_2]
  if L3_2 then
    return
  end
  if L2_2 then
    L3_2 = 112
    if L3_2 then
      goto lbl_24
    end
  end
  L3_2 = 32
  ::lbl_24::
  L4_2 = entities
  L4_2 = L4_2.handle_to_pointer
  L5_2 = L0_2
  L4_2 = L4_2(L5_2)
  L5_2 = modifiedRange
  L6_2 = {}
  L7_2 = address_from_pointer_chain
  L8_2 = L4_2
  L9_2 = {}
  L10_2 = 4280
  L11_2 = L3_2
  L12_2 = 664
  L9_2[1] = L10_2
  L9_2[2] = L11_2
  L9_2[3] = L12_2
  L7_2 = L7_2(L8_2, L9_2)
  L6_2.minAddress = L7_2
  L7_2 = address_from_pointer_chain
  L8_2 = L4_2
  L9_2 = {}
  L10_2 = 4280
  L11_2 = L3_2
  L12_2 = 668
  L9_2[1] = L10_2
  L9_2[2] = L11_2
  L9_2[3] = L12_2
  L7_2 = L7_2(L8_2, L9_2)
  L6_2.maxAddress = L7_2
  L7_2 = address_from_pointer_chain
  L8_2 = L4_2
  L9_2 = {}
  L10_2 = 4280
  L11_2 = L3_2
  L12_2 = 652
  L9_2[1] = L10_2
  L9_2[2] = L11_2
  L9_2[3] = L12_2
  L7_2 = L7_2(L8_2, L9_2)
  L6_2.rangeAddress = L7_2
  L5_2[L1_2] = L6_2
  L5_2 = modifiedRange
  L5_2 = L5_2[L1_2]
  L5_2 = L5_2.minAddress
  if 0 ~= L5_2 then
    L5_2 = modifiedRange
    L5_2 = L5_2[L1_2]
    L5_2 = L5_2.maxAddress
    if 0 ~= L5_2 then
      L5_2 = modifiedRange
      L5_2 = L5_2[L1_2]
      L5_2 = L5_2.rangeAddress
      if 0 ~= L5_2 then
        goto lbl_82
      end
    end
  end
  L5_2 = menu
  L5_2 = L5_2.toast
  L6_2 = "Failed to find memory address."
  L5_2(L6_2)
  do return end
  ::lbl_82::
  L5_2 = modifiedRange
  L5_2 = L5_2[L1_2]
  L6_2 = memory
  L6_2 = L6_2.read_float
  L7_2 = modifiedRange
  L7_2 = L7_2[L1_2]
  L7_2 = L7_2.minAddress
  L6_2 = L6_2(L7_2)
  L5_2.originalMin = L6_2
  L5_2 = modifiedRange
  L5_2 = L5_2[L1_2]
  L6_2 = memory
  L6_2 = L6_2.read_float
  L7_2 = modifiedRange
  L7_2 = L7_2[L1_2]
  L7_2 = L7_2.maxAddress
  L6_2 = L6_2(L7_2)
  L5_2.originalMax = L6_2
  L5_2 = modifiedRange
  L5_2 = L5_2[L1_2]
  L6_2 = memory
  L6_2 = L6_2.read_float
  L7_2 = modifiedRange
  L7_2 = L7_2[L1_2]
  L7_2 = L7_2.rangeAddress
  L6_2 = L6_2(L7_2)
  L5_2.originalRange = L6_2
  L5_2 = memory
  L5_2 = L5_2.write_float
  L6_2 = modifiedRange
  L6_2 = L6_2[L1_2]
  L6_2 = L6_2.minAddress
  L7_2 = 150000
  L5_2(L6_2, L7_2)
  L5_2 = memory
  L5_2 = L5_2.write_float
  L6_2 = modifiedRange
  L6_2 = L6_2[L1_2]
  L6_2 = L6_2.maxAddress
  L7_2 = 150000
  L5_2(L6_2, L7_2)
  L5_2 = memory
  L5_2 = L5_2.write_float
  L6_2 = modifiedRange
  L6_2 = L6_2[L1_2]
  L6_2 = L6_2.rangeAddress
  L7_2 = 150000
  L5_2(L6_2, L7_2)
end
maxrange = L0_1
function L0_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = pairs
  L1_2 = modifiedRange
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = memory
    L6_2 = L6_2.write_float
    L7_2 = modifiedRange
    L7_2 = L7_2[L4_2]
    L7_2 = L7_2.minAddress
    L8_2 = modifiedRange
    L8_2 = L8_2[L4_2]
    L8_2 = L8_2.originalMin
    L6_2(L7_2, L8_2)
    L6_2 = memory
    L6_2 = L6_2.write_float
    L7_2 = modifiedRange
    L7_2 = L7_2[L4_2]
    L7_2 = L7_2.maxAddress
    L8_2 = modifiedRange
    L8_2 = L8_2[L4_2]
    L8_2 = L8_2.originalMax
    L6_2(L7_2, L8_2)
    L6_2 = memory
    L6_2 = L6_2.write_float
    L7_2 = modifiedRange
    L7_2 = L7_2[L4_2]
    L7_2 = L7_2.rangeAddress
    L8_2 = modifiedRange
    L8_2 = L8_2[L4_2]
    L8_2 = L8_2.originalRange
    L6_2(L7_2, L8_2)
    L6_2 = modifiedRange
    L6_2[L4_2] = nil
  end
end
endmaxrange = L0_1
L0_1 = {}
modifiedSpread = L0_1
function L0_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = readWeaponAddress
  L1_2 = modifiedSpread
  L2_2 = 116
  L3_2 = true
  L0_2 = L0_2(L1_2, L2_2, L3_2)
  if 0 == L0_2 then
    return
  end
  L1_2 = memory
  L1_2 = L1_2.write_float
  L2_2 = modifiedSpread
  L2_2 = L2_2[L0_2]
  L2_2 = L2_2.address
  L3_2 = 0
  L1_2(L2_2, L3_2)
end
nospread = L0_1
L0_1 = {}
L1_1 = {}
L2_1 = util
L2_1 = L2_1.joaat
L3_1 = "weapon_minigun"
L2_1 = L2_1(L3_1)
L1_1.hash = L2_1
L0_1[1] = L1_1
L1_1 = {}
L2_1 = util
L2_1 = L2_1.joaat
L3_1 = "weapon_rayminigun"
L2_1 = L2_1(L3_1)
L1_1.hash = L2_1
L0_1[2] = L1_1
modifiedSpinup = L0_1
function L0_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L0_2 = WEAPON
  L0_2 = L0_2.GET_SELECTED_PED_WEAPON
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L1_2 = 1
  L2_2 = modifiedSpinup
  L2_2 = #L2_2
  L3_2 = 1
  for L4_2 = L1_2, L2_2, L3_2 do
    L5_2 = modifiedSpinup
    L5_2 = L5_2[L4_2]
    L5_2 = L5_2.hash
    if L0_2 == L5_2 then
      L5_2 = modifiedSpinup
      L5_2 = L5_2[L4_2]
      L6_2 = address_from_pointer_chain
      L7_2 = entities
      L7_2 = L7_2.handle_to_pointer
      L8_2 = PLAYER
      L8_2 = L8_2.PLAYER_PED_ID
      L8_2, L9_2, L10_2, L11_2 = L8_2()
      L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2)
      L8_2 = {}
      L9_2 = 4280
      L10_2 = 32
      L11_2 = 324
      L8_2[1] = L9_2
      L8_2[2] = L10_2
      L8_2[3] = L11_2
      L6_2 = L6_2(L7_2, L8_2)
      L5_2.address = L6_2
      L5_2 = modifiedSpinup
      L5_2 = L5_2[L4_2]
      L5_2 = L5_2.address
      if 0 == L5_2 then
        return
      end
      L5_2 = memory
      L5_2 = L5_2.write_float
      L6_2 = modifiedSpinup
      L6_2 = L6_2[L4_2]
      L6_2 = L6_2.address
      L7_2 = 0
      L5_2(L6_2, L7_2)
    end
  end
end
nospinup = L0_1
function L0_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L0_2 = 1
  L1_2 = modifiedSpinup
  L1_2 = #L1_2
  L2_2 = 1
  for L3_2 = L0_2, L1_2, L2_2 do
    L4_2 = modifiedSpinup
    L4_2 = L4_2[L3_2]
    L4_2 = L4_2.address
    if L4_2 then
      L4_2 = memory
      L4_2 = L4_2.write_float
      L5_2 = modifiedSpinup
      L5_2 = L5_2[L3_2]
      L5_2 = L5_2.address
      L6_2 = 0.5
      L4_2(L5_2, L6_2)
    end
  end
end
endnospinup = L0_1
L0_1 = {}
modifiedCarForce = L0_1
L0_1 = {}
modifiedHeliForce = L0_1
L0_1 = {}
modifiedPedForce = L0_1
function L0_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = readWeaponAddress
  L1_2 = modifiedCarForce
  L2_2 = 224
  L3_2 = false
  L0_2 = L0_2(L1_2, L2_2, L3_2)
  if 0 == L0_2 then
    return
  end
  L1_2 = memory
  L1_2 = L1_2.write_float
  L2_2 = modifiedCarForce
  L2_2 = L2_2[L0_2]
  L2_2 = L2_2.address
  L3_2 = modifiedCarForce
  L3_2 = L3_2[L0_2]
  L3_2 = L3_2.original
  L3_2 = L3_2 * 99999999999999
  L1_2(L2_2, L3_2)
  L1_2 = readWeaponAddress
  L2_2 = modifiedHeliForce
  L3_2 = 228
  L4_2 = false
  L1_2 = L1_2(L2_2, L3_2, L4_2)
  L0_2 = L1_2
  if 0 == L0_2 then
    return
  end
  L1_2 = memory
  L1_2 = L1_2.write_float
  L2_2 = modifiedHeliForce
  L2_2 = L2_2[L0_2]
  L2_2 = L2_2.address
  L3_2 = modifiedHeliForce
  L3_2 = L3_2[L0_2]
  L3_2 = L3_2.original
  L3_2 = L3_2 * 99999999999999
  L1_2(L2_2, L3_2)
  L1_2 = readWeaponAddress
  L2_2 = modifiedPedForce
  L3_2 = 220
  L4_2 = false
  L1_2 = L1_2(L2_2, L3_2, L4_2)
  L0_2 = L1_2
  if 0 == L0_2 then
    return
  end
  L1_2 = memory
  L1_2 = L1_2.write_float
  L2_2 = modifiedPedForce
  L2_2 = L2_2[L0_2]
  L2_2 = L2_2.address
  L3_2 = modifiedPedForce
  L3_2 = L3_2[L0_2]
  L3_2 = L3_2.original
  L3_2 = L3_2 * 99999999999999
  L1_2(L2_2, L3_2)
end
damagemoded = L0_1
L0_1 = 0
L1_1 = {}
modifiedAimFov = L1_1
function L1_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
  L0_2 = JSkey
  L0_2 = L0_2.disable_control_action
  L1_2 = 0
  L2_2 = "INPUT_SNIPER_ZOOM_IN_ONLY"
  L0_2(L1_2, L2_2)
  L0_2 = JSkey
  L0_2 = L0_2.disable_control_action
  L1_2 = 0
  L2_2 = "INPUT_SNIPER_ZOOM_OUT_ONLY"
  L0_2(L1_2, L2_2)
  L0_2 = JSkey
  L0_2 = L0_2.is_control_pressed
  L1_2 = 0
  L2_2 = "INPUT_AIM"
  L0_2 = L0_2(L1_2, L2_2)
  if not L0_2 then
    L0_2 = 0
    L0_1 = L0_2
    return
  end
  L0_2 = 0
  L1_2 = L0_1
  if not (L1_2 > 60) then
    L1_2 = L0_1
    if not (L1_2 < -5) then
      goto lbl_30
    end
  end
  L0_2 = 3
  goto lbl_31
  ::lbl_30::
  L0_2 = 6
  ::lbl_31::
  L1_2 = L0_1
  if not (L1_2 <= -35) then
    L1_2 = JSkey
    L1_2 = L1_2.is_disabled_control_just_pressed
    L2_2 = 0
    L3_2 = "INPUT_SNIPER_ZOOM_IN_ONLY"
    L1_2 = L1_2(L2_2, L3_2)
    if L1_2 then
      L1_2 = L0_1
      L1_2 = L1_2 - L0_2
      L0_1 = L1_2
  end
  else
    L1_2 = L0_1
    if not (L1_2 >= 100) then
      L1_2 = JSkey
      L1_2 = L1_2.is_disabled_control_just_pressed
      L2_2 = 0
      L3_2 = "INPUT_SNIPER_ZOOM_OUT_ONLY"
      L1_2 = L1_2(L2_2, L3_2)
      if L1_2 then
        L1_2 = L0_1
        L1_2 = L1_2 + L0_2
        L0_1 = L1_2
      end
    end
  end
  L1_2 = readWeaponAddress
  L2_2 = modifiedAimFov
  L3_2 = 764
  L4_2 = false
  L1_2 = L1_2(L2_2, L3_2, L4_2)
  if 0 == L1_2 then
    return
  end
  L2_2 = memory
  L2_2 = L2_2.write_float
  L3_2 = modifiedAimFov
  L3_2 = L3_2[L1_2]
  L3_2 = L3_2.address
  L4_2 = modifiedAimFov
  L4_2 = L4_2[L1_2]
  L4_2 = L4_2.original
  L5_2 = L0_1
  L4_2 = L4_2 + L5_2
  L2_2(L3_2, L4_2)
end
gunzoom = L1_1
L1_1 = 0
L2_1 = {}
modifiedZoomFov = L2_1
function L2_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = readWeaponAddress
  L1_2 = modifiedZoomFov
  L2_2 = 1040
  L3_2 = false
  L0_2 = L0_2(L1_2, L2_2, L3_2)
  if 0 == L0_2 then
    return
  end
  L1_2 = memory
  L1_2 = L1_2.write_float
  L2_2 = modifiedZoomFov
  L2_2 = L2_2[L0_2]
  L2_2 = L2_2.address
  L3_2 = modifiedZoomFov
  L3_2 = L3_2[L0_2]
  L3_2 = L3_2.original
  L4_2 = L1_1
  L3_2 = L3_2 + L4_2
  L1_2(L2_2, L3_2)
end
enablezoomfov = L2_1
function L2_1(A0_2)
  local L1_2
  L1_2 = A0_2 - 100
  L1_2 = L1_2 / 100
  L1_1 = L1_2
  modifiedZoomWeapon = nil
end
zoomaimfov = L2_1
L2_1 = false
function L3_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L0_2 = respawnPos
  if nil == L0_2 then
    return
  end
  L0_2 = PLAYER
  L0_2 = L0_2.IS_PLAYER_DEAD
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L1_2 = L2_1
  if L1_2 and not L0_2 then
    while true do
      L1_2 = PLAYER
      L1_2 = L1_2.IS_PLAYER_DEAD
      L2_2 = PLAYER
      L2_2 = L2_2.PLAYER_ID
      L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L2_2()
      L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
      if not L1_2 then
        break
      end
      L1_2 = util
      L1_2 = L1_2.yield
      L1_2()
    end
    L1_2 = 0
    L2_2 = 30
    L3_2 = 1
    for L4_2 = L1_2, L2_2, L3_2 do
      L5_2 = ENTITY
      L5_2 = L5_2.SET_ENTITY_COORDS_NO_OFFSET
      L6_2 = PLAYER
      L6_2 = L6_2.PLAYER_PED_ID
      L6_2 = L6_2()
      L7_2 = respawnPos
      L7_2 = L7_2.x
      L8_2 = respawnPos
      L8_2 = L8_2.y
      L9_2 = respawnPos
      L9_2 = L9_2.z
      L10_2 = false
      L11_2 = false
      L12_2 = false
      L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
      L5_2 = ENTITY
      L5_2 = L5_2.SET_ENTITY_ROTATION
      L6_2 = PLAYER
      L6_2 = L6_2.PLAYER_PED_ID
      L6_2 = L6_2()
      L7_2 = respawnRot
      L7_2 = L7_2.x
      L8_2 = respawnRot
      L8_2 = L8_2.y
      L9_2 = respawnRot
      L9_2 = L9_2.z
      L10_2 = 2
      L11_2 = true
      L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
      L5_2 = util
      L5_2 = L5_2.yield
      L5_2()
    end
  end
  L2_1 = L0_2
end
custom_respawn = L3_1
function L3_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L0_2 = players
  L0_2 = L0_2.get_position
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2)
  respawnPos = L0_2
  L0_2 = ENTITY
  L0_2 = L0_2.GET_ENTITY_ROTATION
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = 2
  L0_2 = L0_2(L1_2, L2_2)
  respawnRot = L0_2
  L0_2 = "X: "
  L1_2 = respawnPos
  L1_2 = L1_2.x
  L2_2 = [[

Y: ]]
  L3_2 = respawnPos
  L3_2 = L3_2.y
  L4_2 = [[

Z: ]]
  L5_2 = respawnPos
  L5_2 = L5_2.z
  L0_2 = L0_2 .. L1_2 .. L2_2 .. L3_2 .. L4_2 .. L5_2
  L1_2 = util
  L1_2 = L1_2.get_label_text
  L2_2 = ZONE
  L2_2 = L2_2.GET_NAME_OF_ZONE
  L3_2 = v3
  L3_2 = L3_2.get
  L4_2 = respawnPos
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  L2_2, L3_2, L4_2, L5_2, L6_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
  L2_2 = menu
  L2_2 = L2_2.set_menu_name
  L3_2 = custom_respawn_location
  L4_2 = "更新位置("
  L5_2 = L1_2
  L6_2 = ")"
  L4_2 = L4_2 .. L5_2 .. L6_2
  L2_2(L3_2, L4_2)
  L2_2 = menu
  L2_2 = L2_2.set_help_text
  L3_2 = custom_respawn_location
  L4_2 = "当前坐标:\n"
  L5_2 = L0_2
  L4_2 = L4_2 .. L5_2
  L2_2(L3_2, L4_2)
  L2_2 = notification
  L3_2 = "~bold~~y~位置已更新"
  L4_2 = HudColour
  L4_2 = L4_2.blue
  L2_2(L3_2, L4_2)
end
save_custom_respawn = L3_1
function L3_1()
  local L0_2, L1_2, L2_2
  L0_2 = PED
  L0_2 = L0_2.IS_PED_RAGDOLL
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2)
  if L0_2 then
    L0_2 = util
    L0_2 = L0_2.yield
    L1_2 = 3000
    L0_2(L1_2)
    return
  end
  L0_2 = PED
  L0_2 = L0_2.SET_PED_RAGDOLL_ON_COLLISION
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = true
  L0_2(L1_2, L2_2)
end
clumsy = L3_1
function L3_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L0_2 = ENTITY
  L0_2 = L0_2.GET_ENTITY_FORWARD_VECTOR
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  L1_2 = PED
  L1_2 = L1_2.SET_PED_TO_RAGDOLL_WITH_FALL
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = 1500
  L4_2 = 2000
  L5_2 = 2
  L6_2 = L0_2.x
  L7_2 = L0_2.y
  L7_2 = -L7_2
  L8_2 = L0_2.z
  L9_2 = 1
  L10_2 = 0
  L11_2 = 0
  L12_2 = 0
  L13_2 = 0
  L14_2 = 0
  L15_2 = 0
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
end
stumble = L3_1
function L3_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L1_2 = soccerball_models
  L2_2 = math
  L2_2 = L2_2.random
  L3_2 = 1
  L4_2 = soccerball_models
  L4_2 = #L4_2
  L2_2 = L2_2(L3_2, L4_2)
  L1_2 = L1_2[L2_2]
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = L1_2
  L2_2 = L2_2(L3_2)
  L3_2 = request_model
  L4_2 = L2_2
  L3_2(L4_2)
  L3_2 = A0_2.x
  L4_2 = math
  L4_2 = L4_2.random
  L5_2 = -3
  L6_2 = 3
  L4_2 = L4_2(L5_2, L6_2)
  L3_2 = L3_2 + L4_2
  A0_2.x = L3_2
  L3_2 = A0_2.y
  L4_2 = math
  L4_2 = L4_2.random
  L5_2 = -3
  L6_2 = 3
  L4_2 = L4_2(L5_2, L6_2)
  L3_2 = L3_2 + L4_2
  A0_2.y = L3_2
  L3_2 = A0_2.z
  L4_2 = math
  L4_2 = L4_2.random
  L5_2 = 5
  L6_2 = 30
  L4_2 = L4_2(L5_2, L6_2)
  L3_2 = L3_2 + L4_2
  A0_2.z = L3_2
  L3_2 = v3
  L3_2 = L3_2.new
  L4_2 = A0_2.x
  L5_2 = A0_2.y
  L6_2 = A0_2.z
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  L4_2 = entities
  L4_2 = L4_2.create_object
  L5_2 = L2_2
  L6_2 = L3_2
  L7_2 = true
  L4_2 = L4_2(L5_2, L6_2, L7_2)
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_COLLISION
  L6_2 = L4_2
  L7_2 = true
  L8_2 = true
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = ENTITY
  L5_2 = L5_2.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
  L6_2 = L4_2
  L7_2 = 5
  L8_2 = 0
  L9_2 = 0
  L10_2 = 1
  L11_2 = true
  L12_2 = false
  L13_2 = true
  L14_2 = true
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
end
ball_drop = L3_1
function L3_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L0_2 = 0
  L1_2 = entities
  L1_2 = L1_2.get_all_objects_as_handles
  L1_2 = L1_2()
  L2_2 = pairs
  L3_2 = soccerball_models
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = util
    L8_2 = L8_2.joaat
    L9_2 = L7_2
    L8_2 = L8_2(L9_2)
    L9_2 = pairs
    L10_2 = L1_2
    L9_2, L10_2, L11_2, L12_2 = L9_2(L10_2)
    for L13_2, L14_2 in L9_2, L10_2, L11_2, L12_2 do
      L15_2 = ENTITY
      L15_2 = L15_2.GET_ENTITY_MODEL
      L16_2 = L14_2
      L15_2 = L15_2(L16_2)
      if L15_2 == L8_2 then
        L16_2 = delete_entity
        L17_2 = L14_2
        L16_2(L17_2)
        L0_2 = L0_2 + 1
      end
    end
  end
  L2_2 = util
  L2_2 = L2_2.toast
  L3_2 = "已清理 "
  L4_2 = L0_2
  L5_2 = " 个球"
  L3_2 = L3_2 .. L4_2 .. L5_2
  L2_2(L3_2)
end
delete_all_soccer = L3_1
L3_1 = "scr_mich4_firework_trail_spawn"
function L4_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = memory
  L1_2 = L1_2.alloc
  L2_2 = 24
  L1_2 = L1_2(L2_2)
  L2_2 = memory
  L2_2 = L2_2.alloc
  L3_2 = 24
  L2_2 = L2_2(L3_2)
  L3_2 = {}
  L4_2 = {}
  L5_2 = MISC
  L5_2 = L5_2.GET_MODEL_DIMENSIONS
  L6_2 = A0_2
  L7_2 = L1_2
  L8_2 = L2_2
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = v3
  L5_2 = L5_2.get
  L6_2 = L1_2
  L5_2, L6_2, L7_2 = L5_2(L6_2)
  L3_2.z = L7_2
  L3_2.y = L6_2
  L3_2.x = L5_2
  L5_2 = v3
  L5_2 = L5_2.get
  L6_2 = L2_2
  L5_2, L6_2, L7_2 = L5_2(L6_2)
  L4_2.z = L7_2
  L4_2.y = L6_2
  L4_2.x = L5_2
  L5_2 = {}
  L6_2 = L4_2.x
  L7_2 = L3_2.x
  L6_2 = L6_2 - L7_2
  L5_2.x = L6_2
  L6_2 = L4_2.y
  L7_2 = L3_2.y
  L6_2 = L6_2 - L7_2
  L5_2.y = L6_2
  L6_2 = L4_2.z
  L7_2 = L3_2.z
  L6_2 = L6_2 - L7_2
  L5_2.z = L6_2
  return L5_2
end
get_model_dimensions = L4_1
function L4_1(A0_2)
  local L1_2
  L1_2 = vehparticle_tb
  L1_2 = L1_2[A0_2]
  L3_1 = L1_2
end
selectparticle = L4_1
function L4_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2
  L0_2 = entities
  L0_2 = L0_2.get_user_vehicle_as_handle
  L1_2 = false
  L0_2 = L0_2(L1_2)
  L1_2 = get_model_dimensions
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_MODEL
  L3_2 = L0_2
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2 = L2_2(L3_2)
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
  L2_2 = L1_2.x
  L2_2 = -L2_2
  L2_2 = L2_2 / 3
  L3_2 = L1_2.x
  L3_2 = L3_2 / 3
  L4_2 = L1_2.y
  L4_2 = -L4_2
  L4_2 = L4_2 / 3
  L5_2 = {}
  L6_2 = L2_2
  L7_2 = L3_2
  L5_2[1] = L6_2
  L5_2[2] = L7_2
  L6_2 = nil
  L7_2 = nil
  L8_2 = nil
  for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
    L11_2 = request_ptfx_asset
    L12_2 = "scr_rcpaparazzo1"
    L11_2(L12_2)
    L11_2 = GRAPHICS
    L11_2 = L11_2.USE_PARTICLE_FX_ASSET
    L12_2 = "scr_rcpaparazzo1"
    L11_2(L12_2)
    L11_2 = GRAPHICS
    L12_2 = "START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY"
    L11_2 = L11_2[L12_2]
    L12_2 = L3_1
    L13_2 = L0_2
    L14_2 = L10_2
    L15_2 = L4_2
    L16_2 = 0.0
    L17_2 = 0.0
    L18_2 = 0.0
    L19_2 = 0.0
    L20_2 = 1.0
    L21_2 = false
    L22_2 = false
    L23_2 = false
    L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
  end
end
particle_tail = L4_1
function L4_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = {}
  L1_2 = {}
  L2_2 = 0
  L1_2[1] = L2_2
  L0_2[1] = L1_2
  while true do
    L1_2 = ipairs
    L2_2 = L0_2
    L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
    for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
      L7_2 = players
      L7_2 = L7_2.get_rockstar_id
      L8_2 = PLAYER
      L8_2 = L8_2.PLAYER_ID
      L8_2 = L8_2()
      L7_2 = L7_2(L8_2)
      L8_2 = L6_2.id
      if L8_2 == L7_2 then
        return
      else
        break
      end
    end
  end
end
exit_game = L4_1
function L4_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L1_2 = 0
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = players
  L3_2 = L3_2.get_position
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = PED
  L4_2 = L4_2.GET_VEHICLE_PED_IS_USING
  L5_2 = L2_2
  L4_2 = L4_2(L5_2)
  L5_2 = NETWORK
  L5_2 = L5_2.NETWORK_GET_PLAYER_INDEX_FROM_PED
  L6_2 = VEHICLE
  L6_2 = L6_2.GET_PED_IN_VEHICLE_SEAT
  L7_2 = L4_2
  L8_2 = -1
  L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2 = L6_2(L7_2, L8_2)
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  L6_2 = NETWORK
  L6_2 = L6_2.NETWORK_GET_PLAYER_INDEX_FROM_PED
  L7_2 = VEHICLE
  L7_2 = L7_2.GET_PED_IN_VEHICLE_SEAT
  L8_2 = L4_2
  L9_2 = -2
  L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2 = L7_2(L8_2, L9_2)
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  L7_2 = L3_2.z
  L7_2 = L7_2 - 50
  L3_2.z = L7_2
  L7_2 = PED
  L7_2 = L7_2.IS_PED_IN_ANY_VEHICLE
  L8_2 = L2_2
  L9_2 = false
  L7_2 = L7_2(L8_2, L9_2)
  if not L7_2 then
    L7_2 = util
    L7_2 = L7_2.toast
    L8_2 = lang
    L8_2 = L8_2.get_localised
    L9_2 = 1067523721
    L8_2 = L8_2(L9_2)
    L9_2 = L8_2
    L8_2 = L8_2.gsub
    L10_2 = "{}"
    L11_2 = players
    L11_2 = L11_2.get_name
    L12_2 = A0_2
    L11_2, L12_2, L13_2, L14_2 = L11_2(L12_2)
    L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2 = L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    return
  end
  L7_2 = PED
  L7_2 = L7_2.IS_PED_A_PLAYER
  L8_2 = VEHICLE
  L8_2 = L8_2.GET_PED_IN_VEHICLE_SEAT
  L9_2 = L4_2
  L10_2 = -1
  L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2 = L8_2(L9_2, L10_2)
  L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  if not L7_2 then
    L7_2 = util
    L7_2 = L7_2.toast
    L8_2 = "车辆已被成功劫持:D"
    L7_2(L8_2)
    return
  end
  L7_2 = PED1
  L7_2 = L7_2.CREATE_RANDOM_PED
  L8_2 = L3_2
  L7_2 = L7_2(L8_2)
  L8_2 = ENTITY
  L8_2 = L8_2.SET_ENTITY_INVINCIBLE
  L9_2 = L7_2
  L10_2 = true
  L8_2(L9_2, L10_2)
  L8_2 = ENTITY
  L8_2 = L8_2.SET_ENTITY_VISIBLE
  L9_2 = L7_2
  L10_2 = false
  L8_2(L9_2, L10_2)
  L8_2 = PED
  L8_2 = L8_2.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS
  L9_2 = L7_2
  L10_2 = true
  L8_2(L9_2, L10_2)
  L8_2 = TASK1
  L8_2 = L8_2.TASK_ENTER_VEHICLE
  L9_2 = L7_2
  L10_2 = L4_2
  L11_2 = 1000
  L12_2 = -1
  L13_2 = 1.0
  L14_2 = 538
  L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  L8_2 = entities
  L8_2 = L8_2.give_control_by_handle
  L9_2 = L7_2
  L10_2 = A0_2
  L8_2(L9_2, L10_2)
  repeat
    L1_2 = L1_2 + 1
    L8_2 = 300
    if L1_2 > L8_2 then
      L8_2 = PED
      L8_2 = L8_2.IS_PED_IN_ANY_VEHICLE
      L9_2 = L7_2
      L10_2 = false
      L8_2 = L8_2(L9_2, L10_2)
      if not L8_2 then
        L8_2 = players
        L8_2 = L8_2.get_name
        L9_2 = L5_2
        L8_2 = L8_2(L9_2)
        if "InvalidPlayer" ~= L8_2 then
          L8_2 = util
          L8_2 = L8_2.toast
          L9_2 = "未能成功劫持 "
          L10_2 = players
          L10_2 = L10_2.get_name
          L11_2 = L5_2
          L10_2 = L10_2(L11_2)
          L11_2 = "的载具. :/"
          L9_2 = L9_2 .. L10_2 .. L11_2
          L8_2(L9_2)
        else
          L8_2 = util
          L8_2 = L8_2.toast
          L9_2 = "未能成功劫持 "
          L10_2 = players
          L10_2 = L10_2.get_name
          L11_2 = A0_2
          L10_2 = L10_2(L11_2)
          L11_2 = "的载具. :/"
          L9_2 = L9_2 .. L10_2 .. L11_2
          L8_2(L9_2)
        end
        L8_2 = delete_entity
        L9_2 = L7_2
        L8_2(L9_2)
        L1_2 = 0
        break
      end
    end
    L8_2 = util
    L8_2 = L8_2.yield
    L8_2()
    L8_2 = TASK
    L8_2 = L8_2.GET_IS_TASK_ACTIVE
    L9_2 = L2_2
    L10_2 = 2
    L8_2 = L8_2(L9_2, L10_2)
  until L8_2
  L8_2 = TASK
  L8_2 = L8_2.GET_IS_TASK_ACTIVE
  L9_2 = L2_2
  L10_2 = 2
  L8_2 = L8_2(L9_2, L10_2)
  if L8_2 then
    repeat
      L8_2 = util
      L8_2 = L8_2.yield
      L8_2()
      L8_2 = TASK
      L8_2 = L8_2.GET_IS_TASK_ACTIVE
      L9_2 = L2_2
      L10_2 = 2
      L8_2 = L8_2(L9_2, L10_2)
      if not L8_2 then
        break
      end
      L8_2 = PED
      L8_2 = L8_2.IS_PED_IN_ANY_VEHICLE
      L9_2 = L7_2
      L10_2 = false
      L8_2 = L8_2(L9_2, L10_2)
    until L8_2
    L8_2 = TASK
    L8_2 = L8_2.TASK_VEHICLE_DRIVE_WANDER
    L9_2 = L7_2
    L10_2 = L4_2
    L11_2 = 9999.0
    L12_2 = 6
    L8_2(L9_2, L10_2, L11_2, L12_2)
    L8_2 = VEHICLE
    L8_2 = L8_2.SET_VEHICLE_DOORS_LOCKED_FOR_PLAYER
    L9_2 = L4_2
    L10_2 = A0_2
    L11_2 = true
    L8_2(L9_2, L10_2, L11_2)
    L8_2 = util
    L8_2 = L8_2.toast
    L9_2 = "他们的载具现在是你的了"
    L8_2(L9_2)
    L8_2 = util
    L8_2 = L8_2.yield
    L9_2 = 1000
    L8_2(L9_2)
  end
  L8_2 = TASK
  L8_2 = L8_2.GET_IS_TASK_ACTIVE
  L9_2 = L7_2
  L8_2 = L8_2(L9_2)
  if L8_2 then
    L8_2 = TASK
    L8_2 = L8_2.GET_IS_TASK_ACTIVE
    L9_2 = L7_2
    L10_2 = 15
    L8_2 = L8_2(L9_2, L10_2)
    if not L8_2 then
      goto lbl_233
    end
  end
  repeat
    L8_2 = TASK
    L8_2 = L8_2.TASK_VEHICLE_DRIVE_WANDER
    L9_2 = L7_2
    L10_2 = L4_2
    L11_2 = 9999.0
    L12_2 = 6
    L8_2(L9_2, L10_2, L11_2, L12_2)
    L8_2 = util
    L8_2 = L8_2.yield
    L8_2()
    L8_2 = TASK
    L8_2 = L8_2.GET_IS_TASK_ACTIVE
    L9_2 = L7_2
    L10_2 = 151
    L8_2 = L8_2(L9_2, L10_2)
  until L8_2
  ::lbl_233::
  L8_2 = util
  L8_2 = L8_2.yield
  L9_2 = 5000
  L8_2(L9_2)
  if nil ~= L7_2 then
    L8_2 = PED
    L8_2 = L8_2.IS_PED_IN_ANY_VEHICLE
    L9_2 = L7_2
    L10_2 = false
    L8_2 = L8_2(L9_2, L10_2)
    if not L8_2 then
      L8_2 = NETWORK
      L8_2 = L8_2.NETWORK_HAS_CONTROL_OF_ENTITY
      L9_2 = L7_2
      L8_2 = L8_2(L9_2)
      if not L8_2 then
        repeat
          L8_2 = NETWORK
          L8_2 = L8_2.NETWORK_REQUEST_CONTROL_OF_ENTITY
          L9_2 = L7_2
          L8_2(L9_2)
          L8_2 = util
          L8_2 = L8_2.yield
          L8_2()
          L8_2 = NETWORK
          L8_2 = L8_2.NETWORK_HAS_CONTROL_OF_ENTITY
          L9_2 = L7_2
          L8_2 = L8_2(L9_2)
        until L8_2
        repeat
          L8_2 = delete_entity
          L9_2 = L7_2
          L8_2(L9_2)
          L8_2 = util
          L8_2 = L8_2.yield
          L8_2()
          L8_2 = ENTITY
          L8_2 = L8_2.DOES_ENTITY_EXIST
          L9_2 = L7_2
          L8_2 = L8_2(L9_2)
        until not L8_2
      end
    end
  end
end
hijacking_vehicles = L4_1
L4_1 = 10000
function L5_1(A0_2)
  local L1_2
  L4_1 = A0_2
end
set_remove_money_acc = L5_1
function L5_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = SET_INT_GLOBAL
  L1_2 = 282613
  L2_2 = L4_1
  L0_2(L1_2, L2_2)
  L0_2 = STATS
  L0_2 = L0_2.SET_PACKED_STAT_BOOL_CODE
  L1_2 = 15382
  L2_2 = true
  L3_2 = 0
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = STATS
  L0_2 = L0_2.SET_PACKED_STAT_BOOL_CODE
  L1_2 = 9461
  L2_2 = true
  L3_2 = 0
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = menu
  L0_2 = L0_2.trigger_commands
  L1_2 = "nopimenugrey on"
  L0_2(L1_2)
  L0_2 = util
  L0_2 = L0_2.is_interaction_menu_open
  L0_2 = L0_2()
  if L0_2 then
    L0_2 = PAD
    L0_2 = L0_2.SET_CONTROL_VALUE_NEXT_FRAME
    L1_2 = 0
    L2_2 = 244
    L3_2 = 1
    L0_2(L1_2, L2_2, L3_2)
  end
  L0_2 = SET_INT_GLOBAL
  L1_2 = 2766622
  L2_2 = 85
  L0_2(L1_2, L2_2)
  L0_2 = PAD
  L0_2 = L0_2.SET_CONTROL_VALUE_NEXT_FRAME
  L1_2 = 0
  L2_2 = 244
  L3_2 = 1
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = PAD
  L0_2 = L0_2.SET_CONTROL_VALUE_NEXT_FRAME
  L1_2 = 0
  L2_2 = 176
  L3_2 = 1
  L0_2(L1_2, L2_2, L3_2)
end
remove_money = L5_1
function L5_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2
  L3_2 = PLAYER
  L3_2 = L3_2.GET_PLAYER_PED_SCRIPT_INDEX
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = PED
  L4_2 = L4_2.GET_VEHICLE_PED_IS_IN
  L5_2 = L3_2
  L6_2 = true
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = PED
  L5_2 = L5_2.GET_VEHICLE_PED_IS_IN
  L6_2 = L3_2
  L7_2 = false
  L5_2 = L5_2(L6_2, L7_2)
  if 0 ~= L4_2 then
    L6_2 = request_control
    L7_2 = L4_2
    L6_2(L7_2)
    tow_hash = -1323100960
    L6_2 = request_model
    L7_2 = tow_hash
    L6_2(L7_2)
    tower_hash = 2627665880
    L6_2 = request_model
    L7_2 = tower_hash
    L6_2(L7_2)
    L6_2 = ENTITY
    L6_2 = L6_2.GET_ENTITY_ROTATION
    L7_2 = L4_2
    L8_2 = 0
    L6_2 = L6_2(L7_2, L8_2)
    L7_2 = 5.0
    L8_2 = ENTITY
    L8_2 = L8_2.GET_ENTITY_HEADING
    L9_2 = L4_2
    L8_2 = L8_2(L9_2)
    hdg = L8_2
    if 2 == A1_2 then
      L7_2 = -5.0
      L8_2 = hdg
      L8_2 = L8_2 + 180
      hdg = L8_2
    end
    L8_2 = ENTITY
    L8_2 = L8_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
    L9_2 = L4_2
    L10_2 = 0.0
    L11_2 = L7_2
    L12_2 = 0.0
    L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2)
    L9_2 = entities
    L9_2 = L9_2.create_ped
    L10_2 = 28
    L11_2 = tower_hash
    L12_2 = L8_2
    L13_2 = 30.0
    L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2)
    L10_2 = entities
    L10_2 = L10_2.create_vehicle
    L11_2 = tow_hash
    L12_2 = L8_2
    L13_2 = hdg
    L10_2 = L10_2(L11_2, L12_2, L13_2)
    L11_2 = ENTITY
    L11_2 = L11_2.SET_ENTITY_HEADING
    L12_2 = L10_2
    L13_2 = hdg
    L11_2(L12_2, L13_2)
    L11_2 = ENTITY
    L11_2 = L11_2.SET_ENTITY_INVINCIBLE
    L12_2 = L10_2
    L13_2 = true
    L11_2(L12_2, L13_2)
    L11_2 = PED
    L11_2 = L11_2.SET_PED_INTO_VEHICLE
    L12_2 = L9_2
    L13_2 = L10_2
    L14_2 = -1
    L11_2(L12_2, L13_2, L14_2)
    L11_2 = request_control
    L12_2 = L4_2
    L11_2(L12_2)
    L11_2 = VEHICLE
    L11_2 = L11_2.ATTACH_VEHICLE_TO_TOW_TRUCK
    L12_2 = L10_2
    L13_2 = L4_2
    L14_2 = false
    L15_2 = 0
    L16_2 = 0
    L17_2 = 0
    L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
    L11_2 = TASK
    L11_2 = L11_2.TASK_VEHICLE_DRIVE_TO_COORD
    L12_2 = L9_2
    L13_2 = L10_2
    L14_2 = math
    L14_2 = L14_2.random
    L15_2 = 1000
    L14_2 = L14_2(L15_2)
    L15_2 = math
    L15_2 = L15_2.random
    L16_2 = 1000
    L15_2 = L15_2(L16_2)
    L16_2 = math
    L16_2 = L16_2.random
    L17_2 = 100
    L16_2 = L16_2(L17_2)
    L17_2 = 100
    L18_2 = 1
    L19_2 = ENTITY
    L19_2 = L19_2.GET_ENTITY_MODEL
    L20_2 = L4_2
    L19_2 = L19_2(L20_2)
    L20_2 = 4
    L21_2 = 5
    L22_2 = 0
    L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
  end
end
towcarpro = L5_1
function L5_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L1_2 = NETWORK
  L1_2 = L1_2.NETWORK_IS_PLAYER_ACTIVE
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if not L1_2 then
    L1_2 = util
    L1_2 = L1_2.stop_thread
    return L1_2()
  end
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED_SCRIPT_INDEX
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = memory
  L2_2 = L2_2.alloc_int
  L2_2 = L2_2()
  L3_2 = TASK
  L3_2 = L3_2.OPEN_SEQUENCE_TASK
  L4_2 = L2_2
  L3_2(L4_2)
  L3_2 = TASK
  L3_2 = L3_2.TASK_LEAVE_ANY_VEHICLE
  L4_2 = 0
  L5_2 = 0
  L6_2 = 256
  L3_2(L4_2, L5_2, L6_2)
  L3_2 = TASK
  L3_2 = L3_2.TASK_COMBAT_PED
  L4_2 = 0
  L5_2 = L1_2
  L6_2 = 0
  L7_2 = 0
  L3_2(L4_2, L5_2, L6_2, L7_2)
  L3_2 = TASK
  L3_2 = L3_2.TASK_GO_TO_ENTITY
  L4_2 = 0
  L5_2 = L1_2
  L6_2 = -1
  L7_2 = 80.0
  L8_2 = 3.0
  L9_2 = 0.0
  L10_2 = 0
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L3_2 = TASK
  L3_2 = L3_2.CLOSE_SEQUENCE_TASK
  L4_2 = memory
  L4_2 = L4_2.read_int
  L5_2 = L2_2
  L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L4_2(L5_2)
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  L3_2 = ipairs
  L4_2 = get_peds_in_player_range
  L5_2 = A0_2
  L6_2 = 70.0
  L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L4_2(L5_2, L6_2)
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = PED
    L9_2 = L9_2.IS_PED_A_PLAYER
    L10_2 = L8_2
    L9_2 = L9_2(L10_2)
    if not L9_2 then
      L9_2 = TASK
      L9_2 = L9_2.GET_SEQUENCE_PROGRESS
      L10_2 = L8_2
      L9_2 = L9_2(L10_2)
      if -1 == L9_2 then
        L9_2 = request_control
        L10_2 = L8_2
        L9_2(L10_2)
        L9_2 = table
        L9_2 = L9_2.random
        L10_2 = Enemy_Weapons
        L9_2 = L9_2(L10_2)
        L10_2 = PED
        L10_2 = L10_2.SET_PED_COMBAT_ATTRIBUTES
        L11_2 = L8_2
        L12_2 = 46
        L13_2 = true
        L10_2(L11_2, L12_2, L13_2)
        L10_2 = PED
        L10_2 = L10_2.SET_PED_MAX_HEALTH
        L11_2 = L8_2
        L12_2 = 300
        L10_2(L11_2, L12_2)
        L10_2 = ENTITY
        L10_2 = L10_2.SET_ENTITY_HEALTH
        L11_2 = L8_2
        L12_2 = 300
        L13_2 = 0
        L10_2(L11_2, L12_2, L13_2)
        L10_2 = WEAPON
        L10_2 = L10_2.GIVE_WEAPON_TO_PED
        L11_2 = L8_2
        L12_2 = util
        L12_2 = L12_2.joaat
        L13_2 = L9_2
        L12_2 = L12_2(L13_2)
        L13_2 = -1
        L14_2 = false
        L15_2 = true
        L10_2(L11_2, L12_2, L13_2, L14_2, L15_2)
        L10_2 = WEAPON
        L10_2 = L10_2.SET_PED_DROPS_WEAPONS_WHEN_DEAD
        L11_2 = L8_2
        L12_2 = false
        L10_2(L11_2, L12_2)
        L10_2 = TASK
        L10_2 = L10_2.CLEAR_PED_TASKS
        L11_2 = L8_2
        L10_2(L11_2)
        L10_2 = TASK
        L10_2 = L10_2.TASK_PERFORM_SEQUENCE
        L11_2 = L8_2
        L12_2 = memory
        L12_2 = L12_2.read_int
        L13_2 = L2_2
        L12_2, L13_2, L14_2, L15_2 = L12_2(L13_2)
        L10_2(L11_2, L12_2, L13_2, L14_2, L15_2)
      end
    end
  end
  L3_2 = TASK
  L3_2 = L3_2.CLEAR_SEQUENCE_TASK
  L4_2 = L2_2
  L3_2(L4_2)
end
Enemy_NPCS = L5_1
L5_1 = false
L6_1 = util
L6_1 = L6_1.joaat
L7_1 = "weapon_mg"
L6_1 = L6_1(L7_1)
L7_1 = -1
L8_1 = 1
DecorFlag_isEnemyVehicle = 2
function L9_1(A0_2)
  local L1_2
  L5_1 = A0_2
end
set_enemy_Godmode = L9_1
function L9_1(A0_2)
  local L1_2
  L8_1 = A0_2
end
set_enemy_count = L9_1
function L9_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2
  L3_2 = 0
  L4_2 = enemy_veh
  L4_2 = L4_2[A0_2]
  veh_select = L4_2
  while true do
    L4_2 = L8_1
    if not (L3_2 < L4_2) then
      break
    end
    L4_2 = players
    L4_2 = L4_2.exists
    L5_2 = A2_2
    L4_2 = L4_2(L5_2)
    if not L4_2 then
      break
    end
    L4_2 = veh_select
    if "Minitank" == L4_2 then
      L4_2 = spawn_minitank
      L5_2 = A2_2
      L4_2(L5_2)
    else
      L4_2 = veh_select
      if "Lazer" == L4_2 then
        L4_2 = spawn_lazer
        L5_2 = A2_2
        L4_2(L5_2)
      else
        L4_2 = veh_select
        if "Buzzard" == L4_2 then
          L4_2 = spawn_buzzard
          L5_2 = A2_2
          L4_2(L5_2)
        end
      end
    end
    L3_2 = L3_2 + 1
    L4_2 = util
    L4_2 = L4_2.yield
    L5_2 = 150
    L4_2(L5_2)
  end
end
send_enemy_veh = L9_1
function L9_1(A0_2)
  local L1_2
  if 1 == A0_2 then
    L1_2 = minitankModIds
    L1_2 = L1_2.stockWeapon
    L7_1 = L1_2
  elseif 2 == A0_2 then
    L1_2 = minitankModIds
    L1_2 = L1_2.plasmaCannon
    L7_1 = L1_2
  elseif 3 == A0_2 then
    L1_2 = minitankModIds
    L1_2 = L1_2.rocket
    L7_1 = L1_2
  end
end
mini_tank_weapon = L9_1
function L9_1(A0_2)
  local L1_2, L2_2
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = gunnerWeapons
  L2_2 = L2_2[A0_2]
  L1_2 = L1_2(L2_2)
  L6_1 = L1_2
end
enemy_gunman_weapon = L9_1
function L9_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "minitank"
  L1_2 = L1_2(L2_2)
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "s_m_y_blackops_01"
  L2_2 = L2_2(L3_2)
  L3_2 = request_model
  L4_2 = L1_2
  L3_2(L4_2)
  L3_2 = request_model
  L4_2 = L2_2
  L3_2(L4_2)
  L3_2 = players
  L3_2 = L3_2.get_position
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = entities
  L4_2 = L4_2.create_vehicle
  L5_2 = L1_2
  L6_2 = L3_2
  L7_2 = 0.0
  L4_2 = L4_2(L5_2, L6_2, L7_2)
  L5_2 = ENTITY
  L5_2 = L5_2.DOES_ENTITY_EXIST
  L6_2 = L4_2
  L5_2 = L5_2(L6_2)
  if not L5_2 then
    return
  end
  L5_2 = NETWORK
  L5_2 = L5_2.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES
  L6_2 = NETWORK
  L6_2 = L6_2.VEH_TO_NET
  L7_2 = L4_2
  L6_2 = L6_2(L7_2)
  L7_2 = true
  L5_2(L6_2, L7_2)
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_AS_MISSION_ENTITY
  L6_2 = L4_2
  L7_2 = false
  L8_2 = true
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = NETWORK
  L5_2 = L5_2.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER
  L6_2 = NETWORK
  L6_2 = L6_2.VEH_TO_NET
  L7_2 = L4_2
  L6_2 = L6_2(L7_2)
  L7_2 = PLAYER
  L7_2 = L7_2.PLAYER_ID
  L7_2 = L7_2()
  L8_2 = true
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_LOAD_COLLISION_FLAG
  L6_2 = L4_2
  L7_2 = true
  L8_2 = 1
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = set_decor_flag
  L6_2 = L4_2
  L7_2 = DecorFlag_isEnemyVehicle
  L5_2(L6_2, L7_2)
  L5_2 = get_random_offset_from_entity
  L6_2 = L4_2
  L7_2 = 35.0
  L8_2 = 50.0
  L5_2 = L5_2(L6_2, L7_2, L8_2)
  L6_2 = memory
  L6_2 = L6_2.alloc
  L7_2 = 4
  L6_2 = L6_2(L7_2)
  L7_2 = v3
  L7_2 = L7_2.new
  L7_2 = L7_2()
  L8_2 = PATHFIND
  L8_2 = L8_2.GET_CLOSEST_VEHICLE_NODE_WITH_HEADING
  L9_2 = L5_2.x
  L10_2 = L5_2.y
  L11_2 = L5_2.z
  L12_2 = L7_2
  L13_2 = L6_2
  L14_2 = 1
  L15_2 = 3.0
  L16_2 = 0
  L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  if L8_2 then
    L8_2 = entities
    L8_2 = L8_2.create_ped
    L9_2 = 5
    L10_2 = L2_2
    L11_2 = L5_2
    L12_2 = 0.0
    L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2)
    L9_2 = NETWORK
    L9_2 = L9_2.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES
    L10_2 = NETWORK
    L10_2 = L10_2.PED_TO_NET
    L11_2 = L8_2
    L10_2 = L10_2(L11_2)
    L11_2 = true
    L9_2(L10_2, L11_2)
    L9_2 = ENTITY
    L9_2 = L9_2.SET_ENTITY_AS_MISSION_ENTITY
    L10_2 = L8_2
    L11_2 = false
    L12_2 = true
    L9_2(L10_2, L11_2, L12_2)
    L9_2 = NETWORK
    L9_2 = L9_2.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER
    L10_2 = NETWORK
    L10_2 = L10_2.PED_TO_NET
    L11_2 = L8_2
    L10_2 = L10_2(L11_2)
    L11_2 = PLAYER
    L11_2 = L11_2.PLAYER_ID
    L11_2 = L11_2()
    L12_2 = true
    L9_2(L10_2, L11_2, L12_2)
    L9_2 = ENTITY
    L9_2 = L9_2.SET_ENTITY_LOAD_COLLISION_FLAG
    L10_2 = L8_2
    L11_2 = true
    L12_2 = 1
    L9_2(L10_2, L11_2, L12_2)
    L9_2 = ENTITY
    L9_2 = L9_2.SET_ENTITY_INVINCIBLE
    L10_2 = L8_2
    L11_2 = true
    L9_2(L10_2, L11_2)
    L9_2 = PED
    L9_2 = L9_2.SET_PED_INTO_VEHICLE
    L10_2 = L8_2
    L11_2 = L4_2
    L12_2 = -1
    L9_2(L10_2, L11_2, L12_2)
    L9_2 = AUDIO
    L9_2 = L9_2.STOP_PED_SPEAKING
    L10_2 = L8_2
    L11_2 = true
    L9_2(L10_2, L11_2)
    L9_2 = PED
    L9_2 = L9_2.SET_PED_COMBAT_ATTRIBUTES
    L10_2 = L8_2
    L11_2 = 46
    L12_2 = true
    L9_2(L10_2, L11_2, L12_2)
    L9_2 = PED
    L9_2 = L9_2.SET_PED_COMBAT_ATTRIBUTES
    L10_2 = L8_2
    L11_2 = 1
    L12_2 = true
    L9_2(L10_2, L11_2, L12_2)
    L9_2 = PED
    L9_2 = L9_2.SET_PED_COMBAT_ATTRIBUTES
    L10_2 = L8_2
    L11_2 = 3
    L12_2 = false
    L9_2(L10_2, L11_2, L12_2)
    L9_2 = PED
    L9_2 = L9_2.SET_PED_COMBAT_RANGE
    L10_2 = L8_2
    L11_2 = 2
    L9_2(L10_2, L11_2)
    L9_2 = PED
    L9_2 = L9_2.SET_PED_SEEING_RANGE
    L10_2 = L8_2
    L11_2 = 1000.0
    L9_2(L10_2, L11_2)
    L9_2 = PED
    L9_2 = L9_2.SET_PED_SHOOT_RATE
    L10_2 = L8_2
    L11_2 = 1000
    L9_2(L10_2, L11_2)
    L9_2 = PED
    L9_2 = L9_2.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS
    L10_2 = L8_2
    L11_2 = true
    L9_2(L10_2, L11_2)
    L9_2 = TASK
    L9_2 = L9_2.SET_DRIVE_TASK_DRIVING_STYLE
    L10_2 = L8_2
    L11_2 = 786468
    L9_2(L10_2, L11_2)
    L9_2 = ENTITY
    L9_2 = L9_2.SET_ENTITY_COORDS
    L10_2 = L4_2
    L11_2 = L7_2.x
    L12_2 = L7_2.y
    L13_2 = L7_2.z
    L14_2 = false
    L15_2 = false
    L16_2 = false
    L17_2 = false
    L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
    L9_2 = ENTITY
    L9_2 = L9_2.SET_ENTITY_HEADING
    L10_2 = L4_2
    L11_2 = memory
    L11_2 = L11_2.read_float
    L12_2 = L6_2
    L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L11_2(L12_2)
    L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
    L9_2 = ENTITY
    L9_2 = L9_2.SET_ENTITY_INVINCIBLE
    L10_2 = L4_2
    L11_2 = L5_1
    L9_2(L10_2, L11_2)
    L9_2 = VEHICLE
    L9_2 = L9_2.SET_VEHICLE_MOD_KIT
    L10_2 = L4_2
    L11_2 = 0
    L9_2(L10_2, L11_2)
    L9_2 = VEHICLE
    L9_2 = L9_2.SET_VEHICLE_MOD
    L10_2 = L4_2
    L11_2 = 10
    L12_2 = L7_1
    L13_2 = false
    L9_2(L10_2, L11_2, L12_2, L13_2)
    L9_2 = VEHICLE
    L9_2 = L9_2.SET_VEHICLE_ENGINE_ON
    L10_2 = L4_2
    L11_2 = true
    L12_2 = true
    L13_2 = true
    L9_2(L10_2, L11_2, L12_2, L13_2)
    L9_2 = add_blip_for_entity
    L10_2 = L4_2
    L11_2 = 742
    L12_2 = 4
    L9_2 = L9_2(L10_2, L11_2, L12_2)
    L10_2 = util
    L10_2 = L10_2.create_tick_handler
    function L11_2()
      local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3
      L0_3 = PLAYER
      L0_3 = L0_3.GET_PLAYER_PED_SCRIPT_INDEX
      L1_3 = A0_2
      L0_3 = L0_3(L1_3)
      L1_3 = ENTITY
      L1_3 = L1_3.GET_ENTITY_COORDS
      L2_3 = L4_2
      L3_3 = false
      L1_3 = L1_3(L2_3, L3_3)
      L2_3 = ENTITY
      L2_3 = L2_3.DOES_ENTITY_EXIST
      L3_3 = L4_2
      L2_3 = L2_3(L3_3)
      if L2_3 then
        L2_3 = ENTITY
        L2_3 = L2_3.IS_ENTITY_DEAD
        L3_3 = L4_2
        L4_3 = false
        L2_3 = L2_3(L3_3, L4_3)
        if not L2_3 then
          L2_3 = ENTITY
          L2_3 = L2_3.DOES_ENTITY_EXIST
          L3_3 = L8_2
          L2_3 = L2_3(L3_3)
          if L2_3 then
            L2_3 = PED
            L2_3 = L2_3.IS_PED_INJURED
            L3_3 = L8_2
            L2_3 = L2_3(L3_3)
            if not L2_3 then
              goto lbl_38
            end
          end
        end
      end
      L2_3 = false
      do return L2_3 end
      goto lbl_127
      ::lbl_38::
      L2_3 = PED
      L2_3 = L2_3.IS_PED_IN_COMBAT
      L3_3 = L8_2
      L4_3 = L0_3
      L2_3 = L2_3(L3_3, L4_3)
      if not L2_3 then
        L2_3 = PED
        L2_3 = L2_3.IS_PED_INJURED
        L3_3 = L0_3
        L2_3 = L2_3(L3_3)
        if not L2_3 then
          L2_3 = TASK
          L2_3 = L2_3.CLEAR_PED_TASKS
          L3_3 = L8_2
          L2_3(L3_3)
          L2_3 = TASK
          L2_3 = L2_3.TASK_COMBAT_PED
          L3_3 = L8_2
          L4_3 = L0_3
          L5_3 = 0
          L6_3 = 16
          L2_3(L3_3, L4_3, L5_3, L6_3)
          L2_3 = PED
          L2_3 = L2_3.SET_PED_KEEP_TASK
          L3_3 = L8_2
          L4_3 = true
          L2_3(L3_3, L4_3)
      end
      else
        L2_3 = NETWORK
        L2_3 = L2_3.NETWORK_IS_PLAYER_ACTIVE
        L3_3 = A0_2
        L2_3 = L2_3(L3_3)
        if L2_3 then
          L2_3 = players
          L2_3 = L2_3.get_position
          L3_3 = A0_2
          L2_3 = L2_3(L3_3)
          L3_3 = L2_3
          L2_3 = L2_3.distance
          L4_3 = L1_3
          L2_3 = L2_3(L3_3, L4_3)
          L3_3 = 1000.0
          if not (L2_3 > L3_3) then
            goto lbl_127
          end
        end
        L2_3 = TASK
        L2_3 = L2_3.CLEAR_PED_TASKS
        L3_3 = L8_2
        L2_3(L3_3)
        L2_3 = PED
        L2_3 = L2_3.SET_PED_COMBAT_ATTRIBUTES
        L3_3 = L8_2
        L4_3 = 46
        L5_3 = false
        L2_3(L3_3, L4_3, L5_3)
        L2_3 = TASK
        L2_3 = L2_3.TASK_VEHICLE_DRIVE_WANDER
        L3_3 = L8_2
        L4_3 = L4_2
        L5_3 = 10.0
        L6_3 = 786603
        L2_3(L3_3, L4_3, L5_3, L6_3)
        L2_3 = PED
        L2_3 = L2_3.SET_PED_KEEP_TASK
        L3_3 = L8_2
        L4_3 = true
        L2_3(L3_3, L4_3)
        L2_3 = remove_decor
        L3_3 = L4_2
        L2_3(L3_3)
        L2_3 = util
        L2_3 = L2_3.remove_blip
        L3_3 = L9_2
        L2_3(L3_3)
        L2_3 = memory
        L2_3 = L2_3.alloc_int
        L2_3 = L2_3()
        L3_3 = memory
        L3_3 = L3_3.write_int
        L4_3 = L2_3
        L5_3 = L4_2
        L3_3(L4_3, L5_3)
        L3_3 = ENTITY
        L3_3 = L3_3.SET_VEHICLE_AS_NO_LONGER_NEEDED
        L4_3 = L2_3
        L3_3(L4_3)
        L3_3 = false
        return L3_3
      end
      ::lbl_127::
    end
    L10_2(L11_2)
  end
  L8_2 = STREAMING
  L8_2 = L8_2.SET_MODEL_AS_NO_LONGER_NEEDED
  L9_2 = L1_2
  L8_2(L9_2)
  L8_2 = STREAMING
  L8_2 = L8_2.SET_MODEL_AS_NO_LONGER_NEEDED
  L9_2 = L2_2
  L8_2(L9_2)
end
spawn_minitank = L9_1
function L9_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "buzzard"
  L1_2 = L1_2(L2_2)
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "s_m_y_blackops_01"
  L2_2 = L2_2(L3_2)
  L3_2 = request_model
  L4_2 = L1_2
  L3_2(L4_2)
  L3_2 = request_model
  L4_2 = L2_2
  L3_2(L4_2)
  L3_2 = PLAYER
  L3_2 = L3_2.GET_PLAYER_PED_SCRIPT_INDEX
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = PED
  L4_2 = L4_2.GET_PED_RELATIONSHIP_GROUP_HASH
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  L5_2 = PED
  L5_2 = L5_2.SET_RELATIONSHIP_BETWEEN_GROUPS
  L6_2 = 5
  L7_2 = util
  L7_2 = L7_2.joaat
  L8_2 = "ARMY"
  L7_2 = L7_2(L8_2)
  L8_2 = L4_2
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = PED
  L5_2 = L5_2.SET_RELATIONSHIP_BETWEEN_GROUPS
  L6_2 = 5
  L7_2 = L4_2
  L8_2 = util
  L8_2 = L8_2.joaat
  L9_2 = "ARMY"
  L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2 = L8_2(L9_2)
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
  L5_2 = PED
  L5_2 = L5_2.SET_RELATIONSHIP_BETWEEN_GROUPS
  L6_2 = 0
  L7_2 = util
  L7_2 = L7_2.joaat
  L8_2 = "ARMY"
  L7_2 = L7_2(L8_2)
  L8_2 = util
  L8_2 = L8_2.joaat
  L9_2 = "ARMY"
  L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2 = L8_2(L9_2)
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
  L5_2 = players
  L5_2 = L5_2.get_position
  L6_2 = A0_2
  L5_2 = L5_2(L6_2)
  L6_2 = entities
  L6_2 = L6_2.create_vehicle
  L7_2 = L1_2
  L8_2 = L5_2
  L9_2 = CAM
  L9_2 = L9_2.GET_GAMEPLAY_CAM_ROT
  L10_2 = 0
  L9_2 = L9_2(L10_2)
  L9_2 = L9_2.z
  L6_2 = L6_2(L7_2, L8_2, L9_2)
  L7_2 = ENTITY
  L7_2 = L7_2.DOES_ENTITY_EXIST
  L8_2 = L6_2
  L7_2 = L7_2(L8_2)
  if L7_2 then
    L7_2 = NETWORK
    L7_2 = L7_2.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES
    L8_2 = NETWORK
    L8_2 = L8_2.VEH_TO_NET
    L9_2 = L6_2
    L8_2 = L8_2(L9_2)
    L9_2 = true
    L7_2(L8_2, L9_2)
    L7_2 = ENTITY
    L7_2 = L7_2.SET_ENTITY_AS_MISSION_ENTITY
    L8_2 = L6_2
    L9_2 = false
    L10_2 = true
    L7_2(L8_2, L9_2, L10_2)
    L7_2 = NETWORK
    L7_2 = L7_2.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER
    L8_2 = NETWORK
    L8_2 = L8_2.VEH_TO_NET
    L9_2 = L6_2
    L8_2 = L8_2(L9_2)
    L9_2 = PLAYER
    L9_2 = L9_2.PLAYER_ID
    L9_2 = L9_2()
    L10_2 = true
    L7_2(L8_2, L9_2, L10_2)
    L7_2 = ENTITY
    L7_2 = L7_2.SET_ENTITY_LOAD_COLLISION_FLAG
    L8_2 = L6_2
    L9_2 = true
    L10_2 = 1
    L7_2(L8_2, L9_2, L10_2)
    L7_2 = set_decor_flag
    L8_2 = L6_2
    L9_2 = DecorFlag_isEnemyVehicle
    L7_2(L8_2, L9_2)
    L7_2 = get_random_offset_from_entity
    L8_2 = L3_2
    L9_2 = 20.0
    L10_2 = 40.0
    L7_2 = L7_2(L8_2, L9_2, L10_2)
    L8_2 = L7_2.z
    L8_2 = L8_2 + 20.0
    L7_2.z = L8_2
    L8_2 = ENTITY
    L8_2 = L8_2.SET_ENTITY_COORDS
    L9_2 = L6_2
    L10_2 = L7_2.x
    L11_2 = L7_2.y
    L12_2 = L7_2.z
    L13_2 = false
    L14_2 = false
    L15_2 = false
    L16_2 = false
    L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
    L8_2 = NETWORK
    L8_2 = L8_2.SET_NETWORK_ID_CAN_MIGRATE
    L9_2 = NETWORK
    L9_2 = L9_2.VEH_TO_NET
    L10_2 = L6_2
    L9_2 = L9_2(L10_2)
    L10_2 = false
    L8_2(L9_2, L10_2)
    L8_2 = ENTITY
    L8_2 = L8_2.SET_ENTITY_INVINCIBLE
    L9_2 = L6_2
    L10_2 = L5_1
    L8_2(L9_2, L10_2)
    L8_2 = VEHICLE
    L8_2 = L8_2.SET_VEHICLE_ENGINE_ON
    L9_2 = L6_2
    L10_2 = true
    L11_2 = true
    L12_2 = true
    L8_2(L9_2, L10_2, L11_2, L12_2)
    L8_2 = VEHICLE
    L8_2 = L8_2.SET_HELI_BLADES_FULL_SPEED
    L9_2 = L6_2
    L8_2(L9_2)
    L8_2 = add_blip_for_entity
    L9_2 = L6_2
    L10_2 = 422
    L11_2 = 4
    L8_2 = L8_2(L9_2, L10_2, L11_2)
    L9_2 = set_blip_name
    L10_2 = L8_2
    L11_2 = "buzzard2"
    L12_2 = true
    L9_2(L10_2, L11_2, L12_2)
    L9_2 = entities
    L9_2 = L9_2.create_ped
    L10_2 = 29
    L11_2 = L2_2
    L12_2 = L7_2
    L13_2 = CAM
    L13_2 = L13_2.GET_GAMEPLAY_CAM_ROT
    L14_2 = 0
    L13_2 = L13_2(L14_2)
    L13_2 = L13_2.z
    L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2)
    L10_2 = PED
    L10_2 = L10_2.SET_PED_INTO_VEHICLE
    L11_2 = L9_2
    L12_2 = L6_2
    L13_2 = -1
    L10_2(L11_2, L12_2, L13_2)
    L10_2 = PED
    L10_2 = L10_2.SET_PED_MAX_HEALTH
    L11_2 = L9_2
    L12_2 = 500
    L10_2(L11_2, L12_2)
    L10_2 = ENTITY
    L10_2 = L10_2.SET_ENTITY_HEALTH
    L11_2 = L9_2
    L12_2 = 500
    L13_2 = 0
    L10_2(L11_2, L12_2, L13_2)
    L10_2 = ENTITY
    L10_2 = L10_2.SET_ENTITY_INVINCIBLE
    L11_2 = L9_2
    L12_2 = L5_1
    L10_2(L11_2, L12_2)
    L10_2 = PED
    L10_2 = L10_2.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS
    L11_2 = L9_2
    L12_2 = true
    L10_2(L11_2, L12_2)
    L10_2 = PED
    L10_2 = L10_2.SET_PED_KEEP_TASK
    L11_2 = L9_2
    L12_2 = true
    L10_2(L11_2, L12_2)
    L10_2 = TASK
    L10_2 = L10_2.TASK_HELI_MISSION
    L11_2 = L9_2
    L12_2 = L6_2
    L13_2 = 0
    L14_2 = L3_2
    L15_2 = 0.0
    L16_2 = 0.0
    L17_2 = 0.0
    L18_2 = 23
    L19_2 = 40.0
    L20_2 = 40.0
    L21_2 = -1.0
    L22_2 = 0
    L23_2 = 10
    L24_2 = -1.0
    L25_2 = 0
    L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
    L10_2 = 1
    L11_2 = 2
    L12_2 = 1
    for L13_2 = L10_2, L11_2, L12_2 do
      L14_2 = entities
      L14_2 = L14_2.create_ped
      L15_2 = 29
      L16_2 = L2_2
      L17_2 = L7_2
      L18_2 = CAM
      L18_2 = L18_2.GET_GAMEPLAY_CAM_ROT
      L19_2 = 0
      L18_2 = L18_2(L19_2)
      L18_2 = L18_2.z
      L14_2 = L14_2(L15_2, L16_2, L17_2, L18_2)
      L15_2 = PED
      L15_2 = L15_2.SET_PED_INTO_VEHICLE
      L16_2 = L14_2
      L17_2 = L6_2
      L18_2 = L13_2
      L15_2(L16_2, L17_2, L18_2)
      L15_2 = WEAPON
      L15_2 = L15_2.GIVE_WEAPON_TO_PED
      L16_2 = L14_2
      L17_2 = L6_1
      L18_2 = -1
      L19_2 = false
      L20_2 = true
      L15_2(L16_2, L17_2, L18_2, L19_2, L20_2)
      L15_2 = PED
      L15_2 = L15_2.SET_PED_COMBAT_ATTRIBUTES
      L16_2 = L14_2
      L17_2 = 20
      L18_2 = true
      L15_2(L16_2, L17_2, L18_2)
      L15_2 = PED
      L15_2 = L15_2.SET_PED_MAX_HEALTH
      L16_2 = L14_2
      L17_2 = 500
      L15_2(L16_2, L17_2)
      L15_2 = ENTITY
      L15_2 = L15_2.SET_ENTITY_HEALTH
      L16_2 = L14_2
      L17_2 = 500
      L18_2 = 0
      L15_2(L16_2, L17_2, L18_2)
      L15_2 = ENTITY
      L15_2 = L15_2.SET_ENTITY_INVINCIBLE
      L16_2 = L14_2
      L17_2 = L5_1
      L15_2(L16_2, L17_2)
      L15_2 = PED
      L15_2 = L15_2.SET_PED_SHOOT_RATE
      L16_2 = L14_2
      L17_2 = 1000
      L15_2(L16_2, L17_2)
      L15_2 = PED
      L15_2 = L15_2.SET_PED_RELATIONSHIP_GROUP_HASH
      L16_2 = L14_2
      L17_2 = util
      L17_2 = L17_2.joaat
      L18_2 = "ARMY"
      L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2 = L17_2(L18_2)
      L15_2(L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
      L15_2 = TASK
      L15_2 = L15_2.TASK_COMBAT_HATED_TARGETS_AROUND_PED
      L16_2 = L14_2
      L17_2 = 200.0
      L18_2 = 0
      L15_2(L16_2, L17_2, L18_2)
    end
  end
  L7_2 = STREAMING
  L7_2 = L7_2.SET_MODEL_AS_NO_LONGER_NEEDED
  L8_2 = L2_2
  L7_2(L8_2)
  L7_2 = STREAMING
  L7_2 = L7_2.SET_MODEL_AS_NO_LONGER_NEEDED
  L8_2 = L1_2
  L7_2(L8_2)
end
spawn_buzzard = L9_1
function L9_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "lazer"
  L1_2 = L1_2(L2_2)
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "s_m_y_blackops_01"
  L2_2 = L2_2(L3_2)
  L3_2 = request_model
  L4_2 = L1_2
  L3_2(L4_2)
  L3_2 = request_model
  L4_2 = L2_2
  L3_2(L4_2)
  L3_2 = PLAYER
  L3_2 = L3_2.GET_PLAYER_PED_SCRIPT_INDEX
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = players
  L4_2 = L4_2.get_position
  L5_2 = A0_2
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
  if L6_2 then
    L6_2 = NETWORK
    L6_2 = L6_2.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES
    L7_2 = NETWORK
    L7_2 = L7_2.VEH_TO_NET
    L8_2 = L5_2
    L7_2 = L7_2(L8_2)
    L8_2 = true
    L6_2(L7_2, L8_2)
    L6_2 = ENTITY
    L6_2 = L6_2.SET_ENTITY_AS_MISSION_ENTITY
    L7_2 = L5_2
    L8_2 = false
    L9_2 = true
    L6_2(L7_2, L8_2, L9_2)
    L6_2 = NETWORK
    L6_2 = L6_2.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER
    L7_2 = NETWORK
    L7_2 = L7_2.VEH_TO_NET
    L8_2 = L5_2
    L7_2 = L7_2(L8_2)
    L8_2 = PLAYER
    L8_2 = L8_2.PLAYER_ID
    L8_2 = L8_2()
    L9_2 = true
    L6_2(L7_2, L8_2, L9_2)
    L6_2 = ENTITY
    L6_2 = L6_2.SET_ENTITY_LOAD_COLLISION_FLAG
    L7_2 = L5_2
    L8_2 = true
    L9_2 = 1
    L6_2(L7_2, L8_2, L9_2)
    L6_2 = set_decor_flag
    L7_2 = L5_2
    L8_2 = DecorFlag_isEnemyVehicle
    L6_2(L7_2, L8_2)
    L6_2 = get_random_offset_from_entity
    L7_2 = L5_2
    L8_2 = 30.0
    L9_2 = 80.0
    L6_2 = L6_2(L7_2, L8_2, L9_2)
    L7_2 = L6_2.z
    L7_2 = L7_2 + 500.0
    L6_2.z = L7_2
    L7_2 = ENTITY
    L7_2 = L7_2.SET_ENTITY_COORDS
    L8_2 = L5_2
    L9_2 = L6_2.x
    L10_2 = L6_2.y
    L11_2 = L6_2.z
    L12_2 = false
    L13_2 = false
    L14_2 = false
    L15_2 = false
    L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
    L7_2 = set_entity_face_entity
    L8_2 = L5_2
    L9_2 = L3_2
    L10_2 = false
    L7_2(L8_2, L9_2, L10_2)
    L7_2 = add_blip_for_entity
    L8_2 = L5_2
    L9_2 = 16
    L10_2 = 4
    L7_2 = L7_2(L8_2, L9_2, L10_2)
    L8_2 = set_blip_name
    L9_2 = L7_2
    L10_2 = "blip_4xz66m0"
    L11_2 = true
    L8_2(L9_2, L10_2, L11_2)
    L8_2 = VEHICLE
    L8_2 = L8_2.CONTROL_LANDING_GEAR
    L9_2 = L5_2
    L10_2 = 3
    L8_2(L9_2, L10_2)
    L8_2 = ENTITY
    L8_2 = L8_2.SET_ENTITY_INVINCIBLE
    L9_2 = L5_2
    L10_2 = L5_1
    L8_2(L9_2, L10_2)
    L8_2 = VEHICLE
    L8_2 = L8_2.SET_VEHICLE_FORCE_AFTERBURNER
    L9_2 = L5_2
    L10_2 = true
    L8_2(L9_2, L10_2)
    L8_2 = entities
    L8_2 = L8_2.create_ped
    L9_2 = 5
    L10_2 = L2_2
    L11_2 = L6_2
    L12_2 = CAM
    L12_2 = L12_2.GET_GAMEPLAY_CAM_ROT
    L13_2 = 0
    L12_2 = L12_2(L13_2)
    L12_2 = L12_2.z
    L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2)
    L9_2 = ENTITY
    L9_2 = L9_2.SET_ENTITY_AS_MISSION_ENTITY
    L10_2 = L8_2
    L11_2 = false
    L12_2 = true
    L9_2(L10_2, L11_2, L12_2)
    L9_2 = PED
    L9_2 = L9_2.SET_PED_INTO_VEHICLE
    L10_2 = L8_2
    L11_2 = L5_2
    L12_2 = -1
    L9_2(L10_2, L11_2, L12_2)
    L9_2 = TASK
    L9_2 = L9_2.TASK_PLANE_MISSION
    L10_2 = L8_2
    L11_2 = L5_2
    L12_2 = 0
    L13_2 = L3_2
    L14_2 = 0.0
    L15_2 = 0.0
    L16_2 = 0.0
    L17_2 = 6
    L18_2 = 100.0
    L19_2 = 0.0
    L20_2 = 0.0
    L21_2 = 80.0
    L22_2 = 50.0
    L23_2 = false
    L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
    L9_2 = PED
    L9_2 = L9_2.SET_PED_COMBAT_ATTRIBUTES
    L10_2 = L8_2
    L11_2 = 1
    L12_2 = true
    L9_2(L10_2, L11_2, L12_2)
    L9_2 = VEHICLE
    L9_2 = L9_2.SET_VEHICLE_FORWARD_SPEED
    L10_2 = L5_2
    L11_2 = 60.0
    L9_2(L10_2, L11_2)
  end
  L6_2 = STREAMING
  L6_2 = L6_2.SET_MODEL_AS_NO_LONGER_NEEDED
  L7_2 = L1_2
  L6_2(L7_2)
  L6_2 = STREAMING
  L6_2 = L6_2.SET_MODEL_AS_NO_LONGER_NEEDED
  L7_2 = L2_2
  L6_2(L7_2)
end
spawn_lazer = L9_1
function L9_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = -1
  L2_2 = VEHICLE
  L2_2 = L2_2.GET_VEHICLE_MAX_NUMBER_OF_PASSENGERS
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L2_2 = L2_2 - 1
  L3_2 = 1
  for L4_2 = L1_2, L2_2, L3_2 do
    L5_2 = VEHICLE
    L5_2 = L5_2.IS_VEHICLE_SEAT_FREE
    L6_2 = A0_2
    L7_2 = L4_2
    L8_2 = false
    L5_2 = L5_2(L6_2, L7_2, L8_2)
    if not L5_2 then
      L5_2 = VEHICLE
      L5_2 = L5_2.GET_PED_IN_VEHICLE_SEAT
      L6_2 = A0_2
      L7_2 = L4_2
      L8_2 = false
      L5_2 = L5_2(L6_2, L7_2, L8_2)
      L6_2 = delete_entity
      L7_2 = L5_2
      L6_2(L7_2)
    end
  end
end
deleteVehiclePassengers = L9_1
function L9_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = ipairs
  L1_2 = entities
  L1_2 = L1_2.get_all_vehicles_as_handles
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2 = L1_2()
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = is_decor_flag_set
    L7_2 = L5_2
    L8_2 = DecorFlag_isEnemyVehicle
    L6_2 = L6_2(L7_2, L8_2)
    if L6_2 then
      L6_2 = request_control
      L7_2 = L5_2
      L8_2 = 1000
      L6_2 = L6_2(L7_2, L8_2)
      if L6_2 then
        L6_2 = deleteVehiclePassengers
        L7_2 = L5_2
        L6_2(L7_2)
        L6_2 = delete_entity
        L7_2 = L5_2
        L6_2(L7_2)
      end
    end
  end
end
delete_enemy_veh = L9_1
L9_1 = false
L10_1 = 1
L11_1 = {}
L11_1.explode = 0
L11_1.dropMine = 1
L12_1 = 0
L13_1 = 1
L14_1 = nil
function L15_1(A0_2)
  local L1_2
  L9_1 = A0_2
end
send_veh_attack_god = L15_1
function L15_1(A0_2)
  local L1_2
  L10_1 = A0_2
end
send_veh_attacker_number = L15_1
L15_1 = 1
function L16_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = ipairs
  L1_2 = entities
  L1_2 = L1_2.get_all_vehicles_as_handles
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L1_2()
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = is_decor_flag_set
    L7_2 = L5_2
    L8_2 = L15_1
    L6_2 = L6_2(L7_2, L8_2)
    if L6_2 then
      L6_2 = VEHICLE
      L6_2 = L6_2.GET_PED_IN_VEHICLE_SEAT
      L7_2 = L5_2
      L8_2 = -1
      L9_2 = false
      L6_2 = L6_2(L7_2, L8_2, L9_2)
      L7_2 = delete_entity
      L8_2 = L6_2
      L7_2(L8_2)
      L7_2 = delete_entity
      L8_2 = L5_2
      L7_2(L8_2)
    end
  end
end
dele_all_veh_attacker = L16_1
function L16_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  L3_2 = request_model
  L4_2 = A1_2
  L3_2(L4_2)
  L3_2 = request_model
  L4_2 = A2_2
  L3_2(L4_2)
  L3_2 = PLAYER
  L3_2 = L3_2.GET_PLAYER_PED_SCRIPT_INDEX
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = ENTITY
  L4_2 = L4_2.GET_ENTITY_COORDS
  L5_2 = L3_2
  L6_2 = false
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = 0
  L6_2 = entities
  L6_2 = L6_2.create_vehicle
  L7_2 = A1_2
  L8_2 = L4_2
  L9_2 = 0.0
  L6_2 = L6_2(L7_2, L8_2, L9_2)
  L7_2 = NETWORK
  L7_2 = L7_2.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES
  L8_2 = NETWORK
  L8_2 = L8_2.VEH_TO_NET
  L9_2 = L6_2
  L8_2 = L8_2(L9_2)
  L9_2 = true
  L7_2(L8_2, L9_2)
  L7_2 = ENTITY
  L7_2 = L7_2.SET_ENTITY_AS_MISSION_ENTITY
  L8_2 = L6_2
  L9_2 = false
  L10_2 = true
  L7_2(L8_2, L9_2, L10_2)
  L7_2 = NETWORK
  L7_2 = L7_2.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER
  L8_2 = NETWORK
  L8_2 = L8_2.VEH_TO_NET
  L9_2 = L6_2
  L8_2 = L8_2(L9_2)
  L9_2 = PLAYER
  L9_2 = L9_2.PLAYER_ID
  L9_2 = L9_2()
  L10_2 = true
  L7_2(L8_2, L9_2, L10_2)
  L7_2 = ENTITY
  L7_2 = L7_2.SET_ENTITY_LOAD_COLLISION_FLAG
  L8_2 = L6_2
  L9_2 = true
  L10_2 = 1
  L7_2(L8_2, L9_2, L10_2)
  L7_2 = set_decor_flag
  L8_2 = L6_2
  L9_2 = L15_1
  L7_2(L8_2, L9_2)
  L7_2 = VEHICLE
  L7_2 = L7_2.SET_VEHICLE_MOD_KIT
  L8_2 = L6_2
  L9_2 = 0
  L7_2(L8_2, L9_2)
  L7_2 = 0
  L8_2 = 50
  L9_2 = 1
  for L10_2 = L7_2, L8_2, L9_2 do
    L11_2 = VEHICLE
    L11_2 = L11_2.SET_VEHICLE_MOD
    L12_2 = L6_2
    L13_2 = L10_2
    L14_2 = VEHICLE
    L14_2 = L14_2.GET_NUM_VEHICLE_MODS
    L15_2 = L6_2
    L16_2 = L10_2
    L14_2 = L14_2(L15_2, L16_2)
    L14_2 = L14_2 - 1
    L15_2 = false
    L11_2(L12_2, L13_2, L14_2, L15_2)
  end
  L7_2 = get_random_offset_from_entity
  L8_2 = L6_2
  L9_2 = 25.0
  L10_2 = 25.0
  L7_2 = L7_2(L8_2, L9_2, L10_2)
  L8_2 = v3
  L8_2 = L8_2.new
  L8_2 = L8_2()
  L9_2 = PATHFIND
  L9_2 = L9_2.GET_CLOSEST_VEHICLE_NODE
  L10_2 = L7_2.x
  L11_2 = L7_2.y
  L12_2 = L7_2.z
  L13_2 = L8_2
  L14_2 = 1
  L15_2 = 3.0
  L16_2 = 0.0
  L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  if L9_2 then
    L9_2 = entities
    L9_2 = L9_2.create_ped
    L10_2 = 5
    L11_2 = A2_2
    L12_2 = L4_2
    L13_2 = 0.0
    L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2)
    L5_2 = L9_2
    L9_2 = NETWORK
    L9_2 = L9_2.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES
    L10_2 = NETWORK
    L10_2 = L10_2.PED_TO_NET
    L11_2 = L5_2
    L10_2 = L10_2(L11_2)
    L11_2 = true
    L9_2(L10_2, L11_2)
    L9_2 = ENTITY
    L9_2 = L9_2.SET_ENTITY_AS_MISSION_ENTITY
    L10_2 = L5_2
    L11_2 = true
    L12_2 = true
    L9_2(L10_2, L11_2, L12_2)
    L9_2 = NETWORK
    L9_2 = L9_2.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER
    L10_2 = NETWORK
    L10_2 = L10_2.PED_TO_NET
    L11_2 = L5_2
    L10_2 = L10_2(L11_2)
    L11_2 = PLAYER
    L11_2 = L11_2.PLAYER_ID
    L11_2 = L11_2()
    L12_2 = true
    L9_2(L10_2, L11_2, L12_2)
    L9_2 = ENTITY
    L9_2 = L9_2.SET_ENTITY_LOAD_COLLISION_FLAG
    L10_2 = L5_2
    L11_2 = true
    L12_2 = 1
    L9_2(L10_2, L11_2, L12_2)
    L9_2 = PED
    L9_2 = L9_2.SET_PED_INTO_VEHICLE
    L10_2 = L5_2
    L11_2 = L6_2
    L12_2 = -1
    L9_2(L10_2, L11_2, L12_2)
    L9_2 = ENTITY
    L9_2 = L9_2.SET_ENTITY_COORDS
    L10_2 = L6_2
    L11_2 = L8_2.x
    L12_2 = L8_2.y
    L13_2 = L8_2.z
    L14_2 = false
    L15_2 = false
    L16_2 = false
    L17_2 = true
    L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
    L9_2 = set_entity_face_entity
    L10_2 = L6_2
    L11_2 = L3_2
    L12_2 = false
    L9_2(L10_2, L11_2, L12_2)
    L9_2 = VEHICLE
    L9_2 = L9_2.SET_VEHICLE_ENGINE_ON
    L10_2 = L6_2
    L11_2 = true
    L12_2 = true
    L13_2 = true
    L9_2(L10_2, L11_2, L12_2, L13_2)
    L9_2 = VEHICLE
    L9_2 = L9_2.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS
    L10_2 = L6_2
    L11_2 = true
    L9_2(L10_2, L11_2)
    L9_2 = VEHICLE
    L9_2 = L9_2.SET_VEHICLE_IS_CONSIDERED_BY_PLAYER
    L10_2 = L6_2
    L11_2 = false
    L9_2(L10_2, L11_2)
    L9_2 = PED
    L9_2 = L9_2.SET_PED_COMBAT_ATTRIBUTES
    L10_2 = L5_2
    L11_2 = 1
    L12_2 = true
    L9_2(L10_2, L11_2, L12_2)
    L9_2 = PED
    L9_2 = L9_2.SET_PED_COMBAT_ATTRIBUTES
    L10_2 = L5_2
    L11_2 = 3
    L12_2 = false
    L9_2(L10_2, L11_2, L12_2)
    L9_2 = PED
    L9_2 = L9_2.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS
    L10_2 = L5_2
    L11_2 = true
    L9_2(L10_2, L11_2)
    L9_2 = TASK
    L9_2 = L9_2.TASK_VEHICLE_MISSION_PED_TARGET
    L10_2 = L5_2
    L11_2 = L6_2
    L12_2 = L3_2
    L13_2 = 6
    L14_2 = 500.0
    L15_2 = 786988
    L16_2 = 0.0
    L17_2 = 0.0
    L18_2 = true
    L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L9_2 = PED
    L9_2 = L9_2.SET_PED_CAN_BE_KNOCKED_OFF_VEHICLE
    L10_2 = L5_2
    L11_2 = 1
    L9_2(L10_2, L11_2)
    L9_2 = STREAMING
    L9_2 = L9_2.SET_MODEL_AS_NO_LONGER_NEEDED
    L10_2 = A2_2
    L9_2(L10_2)
    L9_2 = STREAMING
    L9_2 = L9_2.SET_MODEL_AS_NO_LONGER_NEEDED
    L10_2 = A1_2
    L9_2(L10_2)
  end
  L9_2 = L6_2
  L10_2 = L5_2
  return L9_2, L10_2
end
create_trolly_vehicle = L16_1
function L16_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L3_2 = util
  L3_2 = L3_2.joaat
  L4_2 = "mp_m_freemode_01"
  L3_2 = L3_2(L4_2)
  L4_2 = 0
  repeat
    if "Bandito" == A0_2 then
      L5_2 = util
      L5_2 = L5_2.joaat
      L6_2 = "rcbandito"
      L5_2 = L5_2(L6_2)
      L6_2 = util
      L6_2 = L6_2.joaat
      L7_2 = "mp_m_freemode_01"
      L6_2 = L6_2(L7_2)
      L7_2 = create_trolly_vehicle
      L8_2 = A2_2
      L9_2 = L5_2
      L10_2 = L6_2
      L7_2, L8_2 = L7_2(L8_2, L9_2, L10_2)
      L9_2 = add_blip_for_entity
      L10_2 = L7_2
      L11_2 = 646
      L12_2 = 4
      L9_2(L10_2, L11_2, L12_2)
      L9_2 = ENTITY
      L9_2 = L9_2.SET_ENTITY_INVINCIBLE
      L10_2 = L7_2
      L11_2 = L9_1
      L9_2(L10_2, L11_2)
      L9_2 = ENTITY
      L9_2 = L9_2.SET_ENTITY_VISIBLE
      L10_2 = L8_2
      L11_2 = false
      L12_2 = false
      L9_2(L10_2, L11_2, L12_2)
    elseif "Go-Kart" == A0_2 then
      L5_2 = util
      L5_2 = L5_2.joaat
      L6_2 = "veto2"
      L5_2 = L5_2(L6_2)
      L6_2 = create_trolly_vehicle
      L7_2 = A2_2
      L8_2 = L5_2
      L9_2 = L3_2
      L6_2, L7_2 = L6_2(L7_2, L8_2, L9_2)
      L8_2 = ENTITY
      L8_2 = L8_2.SET_ENTITY_INVINCIBLE
      L9_2 = L6_2
      L10_2 = L9_1
      L8_2(L9_2, L10_2)
      L8_2 = VEHICLE
      L8_2 = L8_2.SET_VEHICLE_COLOURS
      L9_2 = L6_2
      L10_2 = 89
      L11_2 = 0
      L8_2(L9_2, L10_2, L11_2)
      L8_2 = VEHICLE
      L8_2 = L8_2.TOGGLE_VEHICLE_MOD
      L9_2 = L6_2
      L10_2 = 18
      L11_2 = true
      L8_2(L9_2, L10_2, L11_2)
      L8_2 = ENTITY
      L8_2 = L8_2.SET_ENTITY_INVINCIBLE
      L9_2 = L7_2
      L10_2 = L9_1
      L8_2(L9_2, L10_2)
      L8_2 = PED
      L8_2 = L8_2.SET_PED_COMPONENT_VARIATION
      L9_2 = L7_2
      L10_2 = 3
      L11_2 = 111
      L12_2 = 13
      L13_2 = 2
      L8_2(L9_2, L10_2, L11_2, L12_2, L13_2)
      L8_2 = PED
      L8_2 = L8_2.SET_PED_COMPONENT_VARIATION
      L9_2 = L7_2
      L10_2 = 4
      L11_2 = 67
      L12_2 = 5
      L13_2 = 2
      L8_2(L9_2, L10_2, L11_2, L12_2, L13_2)
      L8_2 = PED
      L8_2 = L8_2.SET_PED_COMPONENT_VARIATION
      L9_2 = L7_2
      L10_2 = 6
      L11_2 = 101
      L12_2 = 1
      L13_2 = 2
      L8_2(L9_2, L10_2, L11_2, L12_2, L13_2)
      L8_2 = PED
      L8_2 = L8_2.SET_PED_COMPONENT_VARIATION
      L9_2 = L7_2
      L10_2 = 8
      L11_2 = -1
      L12_2 = -1
      L13_2 = 2
      L8_2(L9_2, L10_2, L11_2, L12_2, L13_2)
      L8_2 = PED
      L8_2 = L8_2.SET_PED_COMPONENT_VARIATION
      L9_2 = L7_2
      L10_2 = 11
      L11_2 = 148
      L12_2 = 5
      L13_2 = 2
      L8_2(L9_2, L10_2, L11_2, L12_2, L13_2)
      L8_2 = PED
      L8_2 = L8_2.SET_PED_PROP_INDEX
      L9_2 = L7_2
      L10_2 = 0
      L11_2 = 91
      L12_2 = 0
      L13_2 = true
      L8_2(L9_2, L10_2, L11_2, L12_2, L13_2)
      L8_2 = add_blip_for_entity
      L9_2 = L6_2
      L10_2 = 748
      L11_2 = 5
      L8_2(L9_2, L10_2, L11_2)
    end
    L4_2 = L4_2 + 1
    L5_2 = util
    L5_2 = L5_2.yield
    L6_2 = 150
    L5_2(L6_2)
    L5_2 = L10_1
  until L4_2 == L5_2
end
send_veh_attack = L16_1
function L16_1()
  local L0_2, L1_2
  L0_2 = L13_1
  if 1 == L0_2 then
    L0_2 = util
    L0_2 = L0_2.joaat
    L1_2 = "vehicle_weapon_mine_kinetic_rc"
    return L0_2(L1_2)
  else
    L0_2 = L13_1
    if 2 == L0_2 then
      L0_2 = util
      L0_2 = L0_2.joaat
      L1_2 = "vehicle_weapon_mine_emp_rc"
      return L0_2(L1_2)
    end
  end
end
GetMineHash = L16_1
function L16_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "rcbandito"
  L1_2 = L1_2(L2_2)
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "mp_m_freemode_01"
  L2_2 = L2_2(L3_2)
  L3_2 = newTimer
  L3_2 = L3_2()
  L4_2 = create_trolly_vehicle
  L5_2 = A0_2
  L6_2 = L1_2
  L7_2 = L2_2
  L4_2, L5_2 = L4_2(L5_2, L6_2, L7_2)
  L6_2 = VEHICLE
  L6_2 = L6_2.SET_VEHICLE_MOD
  L7_2 = L4_2
  L8_2 = 5
  L9_2 = 3
  L10_2 = false
  L6_2(L7_2, L8_2, L9_2, L10_2)
  L6_2 = VEHICLE
  L6_2 = L6_2.SET_VEHICLE_MOD
  L7_2 = L4_2
  L8_2 = 48
  L9_2 = 5
  L10_2 = false
  L6_2(L7_2, L8_2, L9_2, L10_2)
  L6_2 = VEHICLE
  L6_2 = L6_2.SET_VEHICLE_MOD
  L7_2 = L4_2
  L8_2 = 9
  L9_2 = 0
  L10_2 = false
  L6_2(L7_2, L8_2, L9_2, L10_2)
  L6_2 = VEHICLE
  L6_2 = L6_2.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR
  L7_2 = L4_2
  L8_2 = 128
  L9_2 = 0
  L10_2 = 128
  L6_2(L7_2, L8_2, L9_2, L10_2)
  L6_2 = VEHICLE
  L6_2 = L6_2.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR
  L7_2 = L4_2
  L8_2 = 128
  L9_2 = 0
  L10_2 = 128
  L6_2(L7_2, L8_2, L9_2, L10_2)
  L6_2 = ENTITY
  L6_2 = L6_2.SET_ENTITY_VISIBLE
  L7_2 = L5_2
  L8_2 = false
  L9_2 = false
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = add_blip_for_entity
  L7_2 = L4_2
  L8_2 = 646
  L9_2 = 27
  L6_2 = L6_2(L7_2, L8_2, L9_2)
  L7_2 = util
  L7_2 = L7_2.create_tick_handler
  function L8_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3, L29_3
    L0_3 = ENTITY
    L0_3 = L0_3.DOES_ENTITY_EXIST
    L1_3 = L4_2
    L0_3 = L0_3(L1_3)
    if L0_3 then
      L0_3 = ENTITY
      L0_3 = L0_3.IS_ENTITY_DEAD
      L1_3 = L4_2
      L2_3 = false
      L0_3 = L0_3(L1_3, L2_3)
      if not L0_3 then
        L0_3 = ENTITY
        L0_3 = L0_3.DOES_ENTITY_EXIST
        L1_3 = L5_2
        L0_3 = L0_3(L1_3)
        if L0_3 then
          L0_3 = ENTITY
          L0_3 = L0_3.IS_ENTITY_DEAD
          L1_3 = L5_2
          L2_3 = false
          L0_3 = L0_3(L1_3, L2_3)
          if not L0_3 then
            goto lbl_36
          end
        end
      end
    end
    L0_3 = set_entity_as_no_longer_needed
    L1_3 = L4_2
    L0_3(L1_3)
    L0_3 = set_entity_as_no_longer_needed
    L1_3 = L5_2
    L0_3(L1_3)
    L0_3 = false
    do return L0_3 end
    goto lbl_228
    ::lbl_36::
    L0_3 = NETWORK
    L0_3 = L0_3.NETWORK_IS_PLAYER_ACTIVE
    L1_3 = A0_2
    L0_3 = L0_3(L1_3)
    if L0_3 then
      L0_3 = players
      L0_3 = L0_3.get_position
      L1_3 = A0_2
      L0_3 = L0_3(L1_3)
      L1_3 = ENTITY
      L1_3 = L1_3.GET_ENTITY_COORDS
      L2_3 = L4_2
      L3_3 = true
      L1_3 = L1_3(L2_3, L3_3)
      L3_3 = L0_3
      L2_3 = L0_3.distance
      L4_3 = L1_3
      L2_3 = L2_3(L3_3, L4_3)
      if not (L2_3 > 3.0) then
        L2_3 = request_control
        L3_3 = L4_2
        L2_3 = L2_3(L3_3)
        if L2_3 then
          L2_3 = request_control
          L3_3 = L5_2
          L2_3 = L2_3(L3_3)
          if L2_3 then
            goto lbl_67
          end
        end
      end
      do return end
      ::lbl_67::
      L2_3 = L12_1
      L3_3 = L11_1.explode
      if L2_3 == L3_3 then
        L2_3 = NETWORK
        L2_3 = L2_3.NETWORK_EXPLODE_VEHICLE
        L3_3 = L4_2
        L4_3 = true
        L5_3 = false
        L6_3 = NETWORK
        L6_3 = L6_3.PARTICIPANT_ID_TO_INT
        L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3, L29_3 = L6_3()
        L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3, L29_3)
        L2_3 = ENTITY
        L2_3 = L2_3.SET_ENTITY_HEALTH
        L3_3 = L5_2
        L4_3 = 0
        L5_3 = 0
        L2_3(L3_3, L4_3, L5_3)
      else
        L2_3 = L12_1
        L3_3 = L11_1.dropMine
        if L2_3 == L3_3 then
          L2_3 = L3_2.isEnabled
          L2_3 = L2_3()
          if L2_3 then
            L2_3 = L3_2.elapsed
            L2_3 = L2_3()
            L3_3 = 1000
          end
          if L2_3 > L3_3 then
            L2_3 = MISC
            L2_3 = L2_3.IS_PROJECTILE_TYPE_WITHIN_DISTANCE
            L3_3 = L1_3.x
            L4_3 = L1_3.y
            L5_3 = L1_3.z
            L6_3 = GetMineHash
            L6_3 = L6_3()
            L7_3 = 3.0
            L8_3 = true
            L2_3 = L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3)
            if not L2_3 then
              L2_3 = GetMineHash
              L2_3 = L2_3()
              L3_3 = WEAPON
              L3_3 = L3_3.HAS_WEAPON_ASSET_LOADED
              L4_3 = L2_3
              L3_3 = L3_3(L4_3)
              if not L3_3 then
                L3_3 = WEAPON
                L3_3 = L3_3.REQUEST_WEAPON_ASSET
                L4_3 = L2_3
                L5_3 = 31
                L6_3 = 26
                L3_3(L4_3, L5_3, L6_3)
                return
              end
              L3_3 = v3
              L3_3 = L3_3.new
              L3_3 = L3_3()
              L4_3 = v3
              L4_3 = L4_3.new
              L4_3 = L4_3()
              L5_3 = ENTITY
              L5_3 = L5_3.GET_ENTITY_MODEL
              L6_3 = L4_2
              L5_3 = L5_3(L6_3)
              L6_3 = MISC
              L6_3 = L6_3.GET_MODEL_DIMENSIONS
              L7_3 = L5_3
              L8_3 = L3_3
              L9_3 = L4_3
              L6_3(L7_3, L8_3, L9_3)
              L6_3 = ENTITY
              L6_3 = L6_3.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
              L7_3 = L4_2
              L8_3 = 0.0
              L9_3 = L3_3.y
              L10_3 = 0.2
              L6_3 = L6_3(L7_3, L8_3, L9_3, L10_3)
              L7_3 = ENTITY
              L7_3 = L7_3.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
              L8_3 = L4_2
              L9_3 = 0.0
              L10_3 = L3_3.y
              L11_3 = L3_3.z
              L7_3 = L7_3(L8_3, L9_3, L10_3, L11_3)
              L8_3 = MISC
              L9_3 = "SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY_NEW"
              L8_3 = L8_3[L9_3]
              L9_3 = L6_3.x
              L10_3 = L6_3.y
              L11_3 = L6_3.z
              L12_3 = L7_3.x
              L13_3 = L7_3.y
              L14_3 = L7_3.z
              L15_3 = 0
              L16_3 = true
              L17_3 = L2_3
              L18_3 = PLAYER
              L18_3 = L18_3.PLAYER_ID
              L18_3 = L18_3()
              L19_3 = true
              L20_3 = false
              L21_3 = -1.0
              L22_3 = 0
              L23_3 = false
              L24_3 = false
              L25_3 = 0
              L26_3 = true
              L27_3 = 1
              L28_3 = 0
              L29_3 = 0
              L8_3(L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3, L26_3, L27_3, L28_3, L29_3)
              L8_3 = L3_2.reset
              L8_3()
            end
          end
        end
      end
    else
      L0_3 = request_control
      L1_3 = L4_2
      L0_3 = L0_3(L1_3)
      if L0_3 then
        L0_3 = request_control
        L1_3 = L5_2
        L0_3 = L0_3(L1_3)
        if L0_3 then
          L0_3 = TASK
          L0_3 = L0_3.CLEAR_PED_TASKS
          L1_3 = L5_2
          L0_3(L1_3)
          L0_3 = TASK
          L0_3 = L0_3.TASK_VEHICLE_DRIVE_WANDER
          L1_3 = L5_2
          L2_3 = L4_2
          L3_3 = 10.0
          L4_3 = 786603
          L0_3(L1_3, L2_3, L3_3, L4_3)
          L0_3 = PED
          L0_3 = L0_3.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS
          L1_3 = L5_2
          L2_3 = true
          L0_3(L1_3, L2_3)
          L0_3 = remove_decor
          L1_3 = L4_2
          L0_3(L1_3)
          L0_3 = util
          L0_3 = L0_3.remove_blip
          L1_3 = L6_2
          L0_3(L1_3)
          L0_3 = set_entity_as_no_longer_needed
          L1_3 = L4_2
          L0_3(L1_3)
          L0_3 = set_entity_as_no_longer_needed
          L1_3 = L5_2
          L0_3(L1_3)
          L0_3 = false
          return L0_3
        end
      end
    end
    ::lbl_228::
  end
  L7_2(L8_2)
end
send_veh_attacker = L16_1
function L16_1(A0_2, A1_2)
  local L2_2
  if 1 == A0_2 then
    L2_2 = L11_1.explode
    L12_1 = L2_2
  elseif 2 == A0_2 then
    L2_2 = L11_1.dropMine
    L12_1 = L2_2
  end
end
send_veh_attacker_weapon = L16_1
function L16_1(A0_2, A1_2)
  L13_1 = A0_2
end
send_veh_attacker_weapon_mine = L16_1
L16_1 = 1
L17_1 = {}
L17_1.x = 0.86
L17_1.y = 0.57
L17_1.fps = 100
logocoord = L17_1
function L17_1(A0_2)
  local L1_2, L2_2
  if A0_2 then
    showlogo = 1
    L1_2 = util
    L1_2 = L1_2.create_thread
    function L2_2()
      local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3
      while true do
        L0_3 = showlogo
        if 1 ~= L0_3 then
          break
        end
        L0_3 = directx
        L0_3 = L0_3.create_texture
        L1_3 = filesystem
        L1_3 = L1_3.resources_dir
        L1_3 = L1_3()
        L2_3 = "/SakuraImg/GIF/kana/"
        L3_3 = L16_1
        L4_3 = ".png"
        L1_3 = L1_3 .. L2_3 .. L3_3 .. L4_3
        L0_3 = L0_3(L1_3)
        L1_3 = directx
        L1_3 = L1_3.draw_texture
        L2_3 = L0_3
        L3_3 = 0.06
        L4_3 = 0.1
        L5_3 = 0.0
        L6_3 = 0.0
        L7_3 = logocoord
        L7_3 = L7_3.x
        L8_3 = logocoord
        L8_3 = L8_3.y
        L9_3 = 0
        L10_3 = 1
        L11_3 = 1
        L12_3 = 1
        L13_3 = 1
        L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3)
        L1_3 = util
        L1_3 = L1_3.yield
        L1_3()
      end
    end
    L1_2(L2_2)
    L1_2 = util
    L1_2 = L1_2.create_thread
    function L2_2()
      local L0_3, L1_3
      while true do
        L0_3 = showlogo
        if 1 ~= L0_3 then
          break
        end
        L0_3 = L16_1
        if L0_3 < 12 then
          L0_3 = L16_1
          L0_3 = L0_3 + 1
          L16_1 = L0_3
        else
          L0_3 = 1
          L16_1 = L0_3
        end
        L0_3 = util
        L0_3 = L0_3.yield
        L1_3 = logocoord
        L1_3 = L1_3.fps
        L0_3(L1_3)
      end
    end
    L1_2(L2_2)
  else
    showlogo = 0
  end
end
GIF_kana = L17_1
L17_1 = 1
L18_1 = {}
L18_1.x = 0.86
L18_1.y = 0.57
L18_1.fps = 150
logocoord1 = L18_1
function L18_1(A0_2)
  local L1_2, L2_2
  if A0_2 then
    showlogo1 = 1
    L1_2 = util
    L1_2 = L1_2.create_thread
    function L2_2()
      local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3
      while true do
        L0_3 = showlogo1
        if 1 ~= L0_3 then
          break
        end
        L0_3 = directx
        L0_3 = L0_3.create_texture
        L1_3 = filesystem
        L1_3 = L1_3.resources_dir
        L1_3 = L1_3()
        L2_3 = "/SakuraImg/GIF/xiaohuangren/"
        L3_3 = L17_1
        L4_3 = ".png"
        L1_3 = L1_3 .. L2_3 .. L3_3 .. L4_3
        L0_3 = L0_3(L1_3)
        L1_3 = directx
        L1_3 = L1_3.draw_texture
        L2_3 = L0_3
        L3_3 = 0.06
        L4_3 = 0.1
        L5_3 = 0.0
        L6_3 = 0.0
        L7_3 = logocoord1
        L7_3 = L7_3.x
        L8_3 = logocoord1
        L8_3 = L8_3.y
        L9_3 = 0
        L10_3 = 1
        L11_3 = 1
        L12_3 = 1
        L13_3 = 1
        L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3)
        L1_3 = util
        L1_3 = L1_3.yield
        L1_3()
      end
    end
    L1_2(L2_2)
    L1_2 = util
    L1_2 = L1_2.create_thread
    function L2_2()
      local L0_3, L1_3
      while true do
        L0_3 = showlogo1
        if 1 ~= L0_3 then
          break
        end
        L0_3 = L17_1
        if L0_3 < 22 then
          L0_3 = L17_1
          L0_3 = L0_3 + 1
          L17_1 = L0_3
        else
          L0_3 = 1
          L17_1 = L0_3
        end
        L0_3 = util
        L0_3 = L0_3.yield
        L1_3 = logocoord1
        L1_3 = L1_3.fps
        L0_3(L1_3)
      end
    end
    L1_2(L2_2)
  else
    showlogo1 = 0
  end
end
GIF_xiaohuangren = L18_1
function L18_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  L0_2 = {}
  L1_2 = players
  L1_2 = L1_2.get_position
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_ID
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
  L2_2 = L1_2.z
  L2_2 = L2_2 + 0.6
  L1_2.z = L2_2
  L2_2 = create_object
  L3_2 = 2193278353
  L4_2 = L1_2.x
  L5_2 = L1_2.y
  L6_2 = L1_2.z
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  L3_2 = ENTITY
  L3_2 = L3_2.ATTACH_ENTITY_TO_ENTITY
  L4_2 = L2_2
  L5_2 = PLAYER
  L5_2 = L5_2.PLAYER_PED_ID
  L5_2 = L5_2()
  L6_2 = 0
  L7_2 = 0
  L8_2 = 0
  L9_2 = 0.8
  L10_2 = 0.0
  L11_2 = 0
  L12_2 = 0.0
  L13_2 = true
  L14_2 = true
  L15_2 = false
  L16_2 = true
  L17_2 = 0
  L18_2 = true
  L19_2 = 0
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
  L3_2 = create_ped
  L4_2 = 26
  L5_2 = 2602752943
  L6_2 = L1_2.x
  L7_2 = L1_2.y
  L8_2 = L1_2.z
  L9_2 = 0
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L0_2[1] = L3_2
  L3_2 = ENTITY
  L3_2 = L3_2.ATTACH_ENTITY_TO_ENTITY
  L4_2 = L0_2[1]
  L5_2 = L2_2
  L6_2 = 0
  L7_2 = 0.55
  L8_2 = 0
  L9_2 = -0.6
  L10_2 = 0.0
  L11_2 = 0
  L12_2 = 0.0
  L13_2 = true
  L14_2 = true
  L15_2 = false
  L16_2 = true
  L17_2 = 0
  L18_2 = true
  L19_2 = 0
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
  L3_2 = ENTITY
  L3_2 = L3_2.FREEZE_ENTITY_POSITION
  L4_2 = L0_2[1]
  L5_2 = true
  L3_2(L4_2, L5_2)
  L3_2 = create_ped
  L4_2 = 26
  L5_2 = 2602752943
  L6_2 = L1_2.x
  L7_2 = L1_2.y
  L8_2 = L1_2.z
  L9_2 = 0
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L0_2[2] = L3_2
  L3_2 = ENTITY
  L3_2 = L3_2.ATTACH_ENTITY_TO_ENTITY
  L4_2 = L0_2[2]
  L5_2 = L2_2
  L6_2 = 0
  L7_2 = -0.55
  L8_2 = 0
  L9_2 = -0.6
  L10_2 = 0.0
  L11_2 = 0
  L12_2 = 0.0
  L13_2 = true
  L14_2 = true
  L15_2 = false
  L16_2 = true
  L17_2 = 0
  L18_2 = true
  L19_2 = 0
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
  L3_2 = ENTITY
  L3_2 = L3_2.FREEZE_ENTITY_POSITION
  L4_2 = L0_2[2]
  L5_2 = true
  L3_2(L4_2, L5_2)
  L3_2 = create_ped
  L4_2 = 26
  L5_2 = 2602752943
  L6_2 = L1_2.x
  L7_2 = L1_2.y
  L8_2 = L1_2.z
  L9_2 = 0
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L0_2[3] = L3_2
  L3_2 = ENTITY
  L3_2 = L3_2.ATTACH_ENTITY_TO_ENTITY
  L4_2 = L0_2[3]
  L5_2 = L2_2
  L6_2 = 0
  L7_2 = 0.55
  L8_2 = 0.5
  L9_2 = -0.6
  L10_2 = 0.0
  L11_2 = 0
  L12_2 = 0.0
  L13_2 = true
  L14_2 = true
  L15_2 = false
  L16_2 = true
  L17_2 = 0
  L18_2 = true
  L19_2 = 0
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
  L3_2 = ENTITY
  L3_2 = L3_2.FREEZE_ENTITY_POSITION
  L4_2 = L0_2[3]
  L5_2 = true
  L3_2(L4_2, L5_2)
  L3_2 = create_ped
  L4_2 = 26
  L5_2 = 2602752943
  L6_2 = L1_2.x
  L7_2 = L1_2.y
  L8_2 = L1_2.z
  L9_2 = 0
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L0_2[4] = L3_2
  L3_2 = ENTITY
  L3_2 = L3_2.ATTACH_ENTITY_TO_ENTITY
  L4_2 = L0_2[4]
  L5_2 = L2_2
  L6_2 = 0
  L7_2 = -0.55
  L8_2 = 0.5
  L9_2 = -0.6
  L10_2 = 0.0
  L11_2 = 0
  L12_2 = 0.0
  L13_2 = true
  L14_2 = true
  L15_2 = false
  L16_2 = true
  L17_2 = 0
  L18_2 = true
  L19_2 = 0
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
  L3_2 = ENTITY
  L3_2 = L3_2.FREEZE_ENTITY_POSITION
  L4_2 = L0_2[4]
  L5_2 = true
  L3_2(L4_2, L5_2)
  L3_2 = create_ped
  L4_2 = 26
  L5_2 = 2602752943
  L6_2 = L1_2.x
  L7_2 = L1_2.y
  L8_2 = L1_2.z
  L9_2 = 0
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L0_2[5] = L3_2
  L3_2 = ENTITY
  L3_2 = L3_2.ATTACH_ENTITY_TO_ENTITY
  L4_2 = L0_2[5]
  L5_2 = L2_2
  L6_2 = 0
  L7_2 = 0.55
  L8_2 = -0.5
  L9_2 = -0.6
  L10_2 = 0.0
  L11_2 = 0
  L12_2 = 0.0
  L13_2 = true
  L14_2 = true
  L15_2 = false
  L16_2 = true
  L17_2 = 0
  L18_2 = true
  L19_2 = 0
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
  L3_2 = ENTITY
  L3_2 = L3_2.FREEZE_ENTITY_POSITION
  L4_2 = L0_2[5]
  L5_2 = true
  L3_2(L4_2, L5_2)
  L3_2 = create_ped
  L4_2 = 26
  L5_2 = 2602752943
  L6_2 = L1_2.x
  L7_2 = L1_2.y
  L8_2 = L1_2.z
  L9_2 = 0
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L0_2[6] = L3_2
  L3_2 = ENTITY
  L3_2 = L3_2.ATTACH_ENTITY_TO_ENTITY
  L4_2 = L0_2[6]
  L5_2 = L2_2
  L6_2 = 0
  L7_2 = -0.55
  L8_2 = -0.5
  L9_2 = -0.6
  L10_2 = 0.0
  L11_2 = 0
  L12_2 = 0.0
  L13_2 = true
  L14_2 = true
  L15_2 = false
  L16_2 = true
  L17_2 = 0
  L18_2 = true
  L19_2 = 0
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
  L3_2 = ENTITY
  L3_2 = L3_2.FREEZE_ENTITY_POSITION
  L4_2 = L0_2[6]
  L5_2 = true
  L3_2(L4_2, L5_2)
  L3_2 = ipairs
  L4_2 = L0_2
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = calm_ped
    L10_2 = L8_2
    L11_2 = true
    L9_2(L10_2, L11_2)
  end
end
blacks_coffins = L18_1
function L18_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_COORDS
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  weaponback = A0_2
  L2_2 = weaponback
  if L2_2 then
    spawnweapon = 0
  end
  L2_2 = HUD1
  L2_2 = L2_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L3_2()
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  curweap = L2_2
  L2_2 = HUD1
  L2_2 = L2_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L3_2()
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  if -1569615261 ~= L2_2 then
    L2_2 = weaponback
    if L2_2 then
      L2_2 = WEAPON
      L2_2 = L2_2.CREATE_WEAPON_OBJECT
      L3_2 = curweap
      L4_2 = 1
      L5_2 = L1_2.x
      L6_2 = L1_2.y
      L7_2 = L1_2.z
      L8_2 = true
      L9_2 = 1
      L10_2 = 0
      L11_2 = 0
      L12_2 = 0
      L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
      spawnweapon = L2_2
      L2_2 = attachweapon
      L3_2 = spawnweapon
      L2_2(L3_2)
    end
  end
  while true do
    L2_2 = weaponback
    if not L2_2 then
      break
    end
    L2_2 = WEAPON
    L2_2 = L2_2.GET_CURRENT_PED_WEAPON_ENTITY_INDEX
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2 = L3_2()
    L4_2 = 0
    L2_2 = L2_2(L3_2, L4_2)
    if 0 == L2_2 then
      L2_2 = spawnweapon
      if 0 ~= L2_2 then
        L2_2 = ENTITY
        L2_2 = L2_2.SET_ENTITY_VISIBLE
        L3_2 = spawnweapon
        L4_2 = true
        L5_2 = false
        L2_2(L3_2, L4_2, L5_2)
      end
    else
      L2_2 = ENTITY
      L2_2 = L2_2.SET_ENTITY_VISIBLE
      L3_2 = spawnweapon
      L4_2 = false
      L5_2 = false
      L2_2(L3_2, L4_2, L5_2)
    end
    L2_2 = HUD1
    L2_2 = L2_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L3_2()
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
    L3_2 = curweap
    if L2_2 ~= L3_2 then
      L2_2 = HUD1
      L2_2 = L2_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
      L3_2 = PLAYER
      L3_2 = L3_2.PLAYER_PED_ID
      L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L3_2()
      L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
      if -1569615261 ~= L2_2 then
        L2_2 = spawnweapon
        if 0 ~= L2_2 then
          L2_2 = delete_entity
          L3_2 = spawnweapon
          L2_2(L3_2)
        end
        L2_2 = HUD1
        L2_2 = L2_2._HUD_WEAPON_WHEEL_GET_SELECTED_HASH
        L3_2 = PLAYER
        L3_2 = L3_2.PLAYER_PED_ID
        L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L3_2()
        L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
        curweap = L2_2
        L2_2 = requestweapon
        L3_2 = curweap
        L2_2(L3_2)
        L2_2 = WEAPON
        L2_2 = L2_2.CREATE_WEAPON_OBJECT
        L3_2 = curweap
        L4_2 = 1
        L5_2 = L1_2.x
        L6_2 = L1_2.y
        L7_2 = L1_2.z
        L8_2 = true
        L9_2 = 1
        L10_2 = 0
        L11_2 = 0
        L12_2 = 0
        L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
        spawnweapon = L2_2
        L2_2 = WEAPON
        L2_2 = L2_2.GET_CURRENT_PED_WEAPON_ENTITY_INDEX
        L3_2 = PLAYER
        L3_2 = L3_2.PLAYER_PED_ID
        L3_2 = L3_2()
        L4_2 = 0
        L2_2 = L2_2(L3_2, L4_2)
        if 0 == L2_2 then
          L2_2 = ENTITY
          L2_2 = L2_2.SET_ENTITY_VISIBLE
          L3_2 = spawnweapon
          L4_2 = true
          L5_2 = false
          L2_2(L3_2, L4_2, L5_2)
        else
          L2_2 = ENTITY
          L2_2 = L2_2.SET_ENTITY_VISIBLE
          L3_2 = spawnweapon
          L4_2 = false
          L5_2 = false
          L2_2(L3_2, L4_2, L5_2)
        end
        L2_2 = attachweapon
        L3_2 = spawnweapon
        L2_2(L3_2)
      end
    end
    L2_2 = util
    L2_2 = L2_2.yield
    L2_2()
  end
  L2_2 = delete_entity
  L3_2 = spawnweapon
  L2_2(L3_2)
end
Back_weapons = L18_1
L18_1 = {}
L18_1.speed = 100
L18_1.coll = false
L18_1.stop = true
vehfly = L18_1
function L18_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
  L0_2 = sf
  L0_2 = L0_2.SET_DATA_SLOT
  L1_2 = 6
  L2_2 = PAD
  L2_2 = L2_2.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING
  L3_2 = 0
  L4_2 = 36
  L5_2 = true
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = "向下"
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = sf
  L0_2 = L0_2.SET_DATA_SLOT
  L1_2 = 5
  L2_2 = PAD
  L2_2 = L2_2.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING
  L3_2 = 0
  L4_2 = 21
  L5_2 = true
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = "向上"
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = sf
  L0_2 = L0_2.SET_DATA_SLOT
  L1_2 = 4
  L2_2 = PAD
  L2_2 = L2_2.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING
  L3_2 = 0
  L4_2 = 34
  L5_2 = true
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = "向左"
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = sf
  L0_2 = L0_2.SET_DATA_SLOT
  L1_2 = 3
  L2_2 = PAD
  L2_2 = L2_2.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING
  L3_2 = 0
  L4_2 = 35
  L5_2 = true
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = "向右"
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = sf
  L0_2 = L0_2.SET_DATA_SLOT
  L1_2 = 2
  L2_2 = PAD
  L2_2 = L2_2.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING
  L3_2 = 0
  L4_2 = 22
  L5_2 = true
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = "加速飞行"
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = sf
  L0_2 = L0_2.SET_DATA_SLOT
  L1_2 = 1
  L2_2 = PAD
  L2_2 = L2_2.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING
  L3_2 = 0
  L4_2 = 33
  L5_2 = true
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = "向后"
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = sf
  L0_2 = L0_2.SET_DATA_SLOT
  L1_2 = 0
  L2_2 = PAD
  L2_2 = L2_2.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING
  L3_2 = 0
  L4_2 = 32
  L5_2 = true
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = "向前"
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = sf
  L0_2 = L0_2.DRAW_INSTRUCTIONAL_BUTTONS
  L0_2()
  L0_2 = sf
  L1_2 = L0_2
  L0_2 = L0_2.draw_fullscreen
  L0_2(L1_2)
end
SFfly = L18_1
function L18_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L2_2 = show_button
  L2_2()
  L2_2 = SFfly
  L2_2()
  L2_2 = vehfly
  L2_2 = L2_2.stop
  if L2_2 then
    L2_2 = ENTITY
    L2_2 = L2_2.FREEZE_ENTITY_POSITION
    L3_2 = A0_2
    L4_2 = true
    L2_2(L3_2, L4_2)
  end
  L2_2 = NETWORK
  L2_2 = L2_2.NETWORK_REQUEST_CONTROL_OF_ENTITY
  L3_2 = A0_2
  L2_2(L3_2)
  L2_2 = CAM
  L2_2 = L2_2.GET_GAMEPLAY_CAM_ROT
  L3_2 = 0
  L2_2 = L2_2(L3_2)
  L3_2 = ENTITY
  L3_2 = L3_2.SET_ENTITY_ROTATION
  L4_2 = A0_2
  L5_2 = L2_2.x
  L6_2 = L2_2.y
  L7_2 = L2_2.z
  L8_2 = 1
  L9_2 = true
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L3_2 = PAD
  L3_2 = L3_2.IS_CONTROL_PRESSED
  L4_2 = 0
  L5_2 = 32
  L3_2 = L3_2(L4_2, L5_2)
  if L3_2 then
    L3_2 = ENTITY
    L3_2 = L3_2.FREEZE_ENTITY_POSITION
    L4_2 = A0_2
    L5_2 = false
    L3_2(L4_2, L5_2)
    L3_2 = VEHICLE
    L3_2 = L3_2.SET_VEHICLE_FORWARD_SPEED
    L4_2 = A0_2
    L5_2 = A1_2
    L3_2(L4_2, L5_2)
    L3_2 = PAD
    L3_2 = L3_2.IS_CONTROL_PRESSED
    L4_2 = 0
    L5_2 = 22
    L3_2 = L3_2(L4_2, L5_2)
    if L3_2 then
      L3_2 = ENTITY
      L3_2 = L3_2.FREEZE_ENTITY_POSITION
      L4_2 = A0_2
      L5_2 = false
      L3_2(L4_2, L5_2)
      L3_2 = VEHICLE
      L3_2 = L3_2.SET_VEHICLE_FORWARD_SPEED
      L4_2 = A0_2
      L5_2 = 2 * A1_2
      L3_2(L4_2, L5_2)
    end
  else
    L3_2 = PAD
    L3_2 = L3_2.IS_CONTROL_PRESSED
    L4_2 = 0
    L5_2 = 33
    L3_2 = L3_2(L4_2, L5_2)
    if L3_2 then
      L3_2 = ENTITY
      L3_2 = L3_2.FREEZE_ENTITY_POSITION
      L4_2 = A0_2
      L5_2 = false
      L3_2(L4_2, L5_2)
      L3_2 = VEHICLE
      L3_2 = L3_2.SET_VEHICLE_FORWARD_SPEED
      L4_2 = A0_2
      L5_2 = -A1_2
      L3_2(L4_2, L5_2)
      L3_2 = PAD
      L3_2 = L3_2.IS_CONTROL_PRESSED
      L4_2 = 0
      L5_2 = 22
      L3_2 = L3_2(L4_2, L5_2)
      if L3_2 then
        L3_2 = ENTITY
        L3_2 = L3_2.FREEZE_ENTITY_POSITION
        L4_2 = A0_2
        L5_2 = false
        L3_2(L4_2, L5_2)
        L3_2 = VEHICLE
        L3_2 = L3_2.SET_VEHICLE_FORWARD_SPEED
        L4_2 = A0_2
        L5_2 = -2 * A1_2
        L3_2(L4_2, L5_2)
      end
    end
  end
  L3_2 = PAD
  L3_2 = L3_2.IS_CONTROL_PRESSED
  L4_2 = 0
  L5_2 = 21
  L3_2 = L3_2(L4_2, L5_2)
  if L3_2 then
    L3_2 = ENTITY
    L3_2 = L3_2.FREEZE_ENTITY_POSITION
    L4_2 = A0_2
    L5_2 = false
    L3_2(L4_2, L5_2)
    L3_2 = ENTITY
    L3_2 = L3_2.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
    L4_2 = A0_2
    L5_2 = 1
    L6_2 = 0
    L7_2 = 0
    L8_2 = A1_2
    L9_2 = 0
    L10_2 = true
    L11_2 = true
    L12_2 = true
    L13_2 = true
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  else
    L3_2 = PAD
    L3_2 = L3_2.IS_CONTROL_PRESSED
    L4_2 = 0
    L5_2 = 36
    L3_2 = L3_2(L4_2, L5_2)
    if L3_2 then
      L3_2 = ENTITY
      L3_2 = L3_2.FREEZE_ENTITY_POSITION
      L4_2 = A0_2
      L5_2 = false
      L3_2(L4_2, L5_2)
      L3_2 = ENTITY
      L3_2 = L3_2.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
      L4_2 = A0_2
      L5_2 = 1
      L6_2 = 0
      L7_2 = 0
      L8_2 = -A1_2
      L9_2 = 0
      L10_2 = true
      L11_2 = true
      L12_2 = true
      L13_2 = true
      L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
    else
      L3_2 = PAD
      L3_2 = L3_2.IS_CONTROL_PRESSED
      L4_2 = 0
      L5_2 = 35
      L3_2 = L3_2(L4_2, L5_2)
      if L3_2 then
        L3_2 = ENTITY
        L3_2 = L3_2.FREEZE_ENTITY_POSITION
        L4_2 = A0_2
        L5_2 = false
        L3_2(L4_2, L5_2)
        L3_2 = ENTITY
        L3_2 = L3_2.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
        L4_2 = A0_2
        L5_2 = 1
        L6_2 = A1_2
        L7_2 = 0
        L8_2 = 0
        L9_2 = 0
        L10_2 = true
        L11_2 = true
        L12_2 = true
        L13_2 = true
        L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
      else
        L3_2 = PAD
        L3_2 = L3_2.IS_CONTROL_PRESSED
        L4_2 = 0
        L5_2 = 34
        L3_2 = L3_2(L4_2, L5_2)
        if L3_2 then
          L3_2 = ENTITY
          L3_2 = L3_2.FREEZE_ENTITY_POSITION
          L4_2 = A0_2
          L5_2 = false
          L3_2(L4_2, L5_2)
          L3_2 = ENTITY
          L3_2 = L3_2.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
          L4_2 = A0_2
          L5_2 = 1
          L6_2 = -A1_2
          L7_2 = 0
          L8_2 = 0
          L9_2 = 0
          L10_2 = true
          L11_2 = true
          L12_2 = true
          L13_2 = true
          L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
        end
      end
    end
  end
end
vehflight = L18_1
function L18_1(A0_2)
  local L1_2
  L1_2 = vehfly
  L1_2.speed = A0_2
end
veh_fly_speed = L18_1
function L18_1(A0_2)
  local L1_2
  L1_2 = vehfly
  L1_2.coll = A0_2
end
veh_fly_coll = L18_1
function L18_1(A0_2)
  local L1_2, L2_2
  L1_2 = vehfly
  L2_2 = not A0_2
  L1_2.stop = L2_2
end
veh_fly_stop = L18_1
function L18_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = PED
  L0_2 = L0_2.GET_VEHICLE_PED_IS_IN
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2, L4_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2)
  L1_2 = vehfly
  L1_2 = L1_2.coll
  if L1_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.SET_ENTITY_COMPLETELY_DISABLE_COLLISION
    L2_2 = L0_2
    L3_2 = false
    L4_2 = true
    L1_2(L2_2, L3_2, L4_2)
  else
    L1_2 = ENTITY
    L1_2 = L1_2.SET_ENTITY_COMPLETELY_DISABLE_COLLISION
    L2_2 = L0_2
    L3_2 = true
    L4_2 = true
    L1_2(L2_2, L3_2, L4_2)
  end
  L1_2 = PED
  L1_2 = L1_2.IS_PED_IN_ANY_VEHICLE
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2, L3_2, L4_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2)
  if L1_2 then
    if 0 ~= L0_2 then
      L1_2 = vehflight
      L2_2 = L0_2
      L3_2 = vehfly
      L3_2 = L3_2.speed
      L1_2(L2_2, L3_2)
    end
  else
    L1_2 = util
    L1_2 = L1_2.toast
    L2_2 = "你没有乘坐载具"
    L1_2(L2_2)
    L1_2 = ENTITY
    L1_2 = L1_2.FREEZE_ENTITY_POSITION
    L2_2 = L0_2
    L3_2 = false
    L1_2(L2_2, L3_2)
  end
end
veh_fly = L18_1
function L18_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = PED
  L0_2 = L0_2.GET_VEHICLE_PED_IS_IN
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2)
  L1_2 = NETWORK
  L1_2 = L1_2.NETWORK_REQUEST_CONTROL_OF_ENTITY
  L2_2 = L0_2
  L1_2(L2_2)
  L1_2 = ENTITY
  L1_2 = L1_2.FREEZE_ENTITY_POSITION
  L2_2 = L0_2
  L3_2 = false
  L1_2(L2_2, L3_2)
  L1_2 = ENTITY
  L1_2 = L1_2.SET_ENTITY_HAS_GRAVITY
  L2_2 = L0_2
  L3_2 = true
  L1_2(L2_2, L3_2)
end
close_veh_fly = L18_1
function L18_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L2_2 = NETWORK
  L2_2 = L2_2.NETWORK_GET_NETWORK_ID_FROM_ENTITY
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = NETWORK
  L3_2 = L3_2.NETWORK_REQUEST_CONTROL_OF_ENTITY
  L4_2 = A0_2
  L3_2(L4_2)
  L3_2 = NETWORK
  L3_2 = L3_2.NETWORK_HAS_CONTROL_OF_ENTITY
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  if not L3_2 then
    L3_2 = 1
    L4_2 = 30
    L5_2 = 1
    for L6_2 = L3_2, L4_2, L5_2 do
      L7_2 = NETWORK
      L7_2 = L7_2.NETWORK_HAS_CONTROL_OF_ENTITY
      L8_2 = A0_2
      L7_2 = L7_2(L8_2)
      if not L7_2 then
        L7_2 = NETWORK
        L7_2 = L7_2.NETWORK_REQUEST_CONTROL_OF_ENTITY
        L8_2 = A0_2
        L7_2(L8_2)
        L7_2 = util
        L7_2 = L7_2.yield
        L8_2 = 10
        L7_2(L8_2)
      end
    end
  end
  L3_2 = NETWORK
  L3_2 = L3_2.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID
  L4_2 = L2_2
  L3_2(L4_2)
  L3_2 = util
  L3_2 = L3_2.yield
  L4_2 = 10
  L3_2(L4_2)
  L3_2 = NETWORK
  L3_2 = L3_2.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES
  L4_2 = L2_2
  L3_2(L4_2)
  L3_2 = util
  L3_2 = L3_2.yield
  L4_2 = 10
  L3_2(L4_2)
  L3_2 = NETWORK
  L3_2 = L3_2.SET_NETWORK_ID_CAN_MIGRATE
  L4_2 = L2_2
  L5_2 = false
  L3_2(L4_2, L5_2)
  L3_2 = util
  L3_2 = L3_2.yield
  L4_2 = 10
  L3_2(L4_2)
  L3_2 = NETWORK
  L3_2 = L3_2.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER
  L4_2 = L2_2
  L5_2 = A1_2
  L6_2 = true
  L3_2(L4_2, L5_2, L6_2)
  L3_2 = util
  L3_2 = L3_2.yield
  L4_2 = 10
  L3_2(L4_2)
  L3_2 = ENTITY
  L3_2 = L3_2.SET_ENTITY_AS_MISSION_ENTITY
  L4_2 = A0_2
  L5_2 = true
  L6_2 = false
  L3_2(L4_2, L5_2, L6_2)
  L3_2 = util
  L3_2 = L3_2.yield
  L4_2 = 10
  L3_2(L4_2)
  L3_2 = ENTITY1
  L3_2 = L3_2._SET_ENTITY_CLEANUP_BY_ENGINE
  L4_2 = A0_2
  L5_2 = false
  L3_2(L4_2, L5_2)
  L3_2 = util
  L3_2 = L3_2.yield
  L4_2 = 10
  L3_2(L4_2)
  L3_2 = ENTITY
  L3_2 = L3_2.IS_ENTITY_AN_OBJECT
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  if L3_2 then
    L3_2 = NETWORK
    L3_2 = L3_2.OBJ_TO_NET
    L4_2 = A0_2
    L3_2(L4_2)
  end
  L3_2 = util
  L3_2 = L3_2.yield
  L4_2 = 10
  L3_2(L4_2)
  L3_2 = ENTITY
  L3_2 = L3_2.SET_ENTITY_VISIBLE
  L4_2 = A0_2
  L5_2 = false
  L6_2 = 0
  L3_2(L4_2, L5_2, L6_2)
end
fastNet = L18_1
function L18_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L3_2 = L1_2
  L4_2 = 0
  L5_2 = 4
  L6_2 = 0
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  L3_2 = ENTITY
  L3_2 = L3_2.GET_ENTITY_HEADING
  L4_2 = L1_2
  L3_2 = L3_2(L4_2)
  L4_2 = 309416120
  L5_2 = STREAMING
  L5_2 = L5_2.REQUEST_MODEL
  L6_2 = L4_2
  L5_2(L6_2)
  while true do
    L5_2 = STREAMING
    L5_2 = L5_2.HAS_MODEL_LOADED
    L6_2 = L4_2
    L5_2 = L5_2(L6_2)
    if L5_2 then
      break
    end
    L5_2 = util
    L5_2 = L5_2.yield
    L5_2()
  end
  L5_2 = OBJECT
  L5_2 = L5_2.CREATE_OBJECT
  L6_2 = L4_2
  L7_2 = L2_2.x
  L8_2 = L2_2.y
  L9_2 = L2_2.z
  L9_2 = L9_2 - 1
  L10_2 = true
  L11_2 = true
  L12_2 = true
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L6_2 = ENTITY
  L6_2 = L6_2.SET_ENTITY_HEADING
  L7_2 = L5_2
  L8_2 = L3_2 + 90
  L6_2(L7_2, L8_2)
  L6_2 = fastNet
  L7_2 = L5_2
  L8_2 = A0_2
  L6_2(L7_2, L8_2)
  L6_2 = OBJECT
  L6_2 = L6_2.CREATE_OBJECT
  L7_2 = L4_2
  L8_2 = L2_2.x
  L9_2 = L2_2.y
  L10_2 = L2_2.z
  L10_2 = L10_2 + 1
  L11_2 = true
  L12_2 = true
  L13_2 = true
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L7_2 = ENTITY
  L7_2 = L7_2.SET_ENTITY_HEADING
  L8_2 = L6_2
  L9_2 = L3_2 + 90
  L7_2(L8_2, L9_2)
  L7_2 = fastNet
  L8_2 = L6_2
  L9_2 = A0_2
  L7_2(L8_2, L9_2)
  L7_2 = util
  L7_2 = L7_2.yield
  L8_2 = 500
  L7_2(L8_2)
  L7_2 = delete_entity
  L8_2 = L5_2
  L7_2(L8_2)
  L7_2 = delete_entity
  L8_2 = L6_2
  L7_2(L8_2)
end
Place_wall = L18_1
function L18_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L2_2 = {}
  L3_2 = PLAYER
  L3_2 = L3_2.GET_PLAYER_PED_SCRIPT_INDEX
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = ENTITY
  L4_2 = L4_2.GET_ENTITY_COORDS
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  L5_2 = PED
  L5_2 = L5_2.GET_VEHICLE_PED_IS_IN
  L6_2 = L3_2
  L7_2 = false
  L5_2 = L5_2(L6_2, L7_2)
  L6_2 = ipairs
  L7_2 = entities
  L7_2 = L7_2.get_all_vehicles_as_handles
  L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L7_2()
  L6_2, L7_2, L8_2, L9_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  for L10_2, L11_2 in L6_2, L7_2, L8_2, L9_2 do
    L12_2 = ENTITY
    L12_2 = L12_2.GET_ENTITY_COORDS
    L13_2 = L11_2
    L12_2 = L12_2(L13_2)
    if L11_2 ~= L5_2 then
      L13_2 = vect
      L13_2 = L13_2.dist
      L14_2 = L4_2
      L15_2 = L12_2
      L13_2 = L13_2(L14_2, L15_2)
      if A1_2 >= L13_2 then
        L13_2 = table
        L13_2 = L13_2.insert
        L14_2 = L2_2
        L15_2 = L11_2
        L13_2(L14_2, L15_2)
      end
    end
  end
  return L2_2
end
GET_NEARBY_VEHICLES = L18_1
function L18_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = 0
  while true do
    L2_2 = NETWORK
    L2_2 = L2_2.NETWORK_HAS_CONTROL_OF_ENTITY
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    if not (not L2_2 and L1_2 < 25) then
      break
    end
    L2_2 = util
    L2_2 = L2_2.yield
    L2_2()
    L2_2 = NETWORK
    L2_2 = L2_2.NETWORK_REQUEST_CONTROL_OF_ENTITY
    L3_2 = A0_2
    L2_2(L3_2)
    L1_2 = L1_2 + 1
  end
  L2_2 = NETWORK
  L2_2 = L2_2.NETWORK_IS_SESSION_STARTED
  L2_2 = L2_2()
  if L2_2 then
    L2_2 = NETWORK
    L2_2 = L2_2.NETWORK_GET_NETWORK_ID_FROM_ENTITY
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    L3_2 = NETWORK
    L3_2 = L3_2.NETWORK_REQUEST_CONTROL_OF_ENTITY
    L4_2 = A0_2
    L3_2(L4_2)
    L3_2 = NETWORK
    L3_2 = L3_2.SET_NETWORK_ID_CAN_MIGRATE
    L4_2 = L2_2
    L5_2 = true
    L3_2(L4_2, L5_2)
  end
end
REQUEST_CONTROL_LOOP = L18_1
function L18_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L0_2 = PLAYER
  L0_2 = L0_2.GET_PLAYER_PED_SCRIPT_INDEX
  L1_2 = pid
  L0_2 = L0_2(L1_2)
  L1_2 = pairs
  L2_2 = GET_NEARBY_VEHICLES
  L3_2 = pid
  L4_2 = 2000
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L2_2(L3_2, L4_2)
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = VEHICLE
    L7_2 = L7_2.IS_VEHICLE_SEAT_FREE
    L8_2 = L6_2
    L9_2 = -1
    L7_2 = L7_2(L8_2, L9_2)
    if not L7_2 then
      L7_2 = VEHICLE
      L7_2 = L7_2.GET_PED_IN_VEHICLE_SEAT
      L8_2 = L6_2
      L9_2 = -1
      L7_2 = L7_2(L8_2, L9_2)
      L8_2 = PED
      L8_2 = L8_2.IS_PED_A_PLAYER
      L9_2 = L7_2
      L8_2 = L8_2(L9_2)
      if not L8_2 then
        L8_2 = REQUEST_CONTROL_LOOP
        L9_2 = L7_2
        L8_2(L9_2)
        L8_2 = PED
        L8_2 = L8_2.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS
        L9_2 = L7_2
        L10_2 = true
        L8_2(L9_2, L10_2)
        L8_2 = PED
        L8_2 = L8_2.SET_PED_MAX_HEALTH
        L9_2 = L7_2
        L10_2 = 300
        L8_2(L9_2, L10_2)
        L8_2 = ENTITY
        L8_2 = L8_2.SET_ENTITY_INVINCIBLE
        L9_2 = L7_2
        L10_2 = true
        L8_2(L9_2, L10_2)
        L8_2 = ENTITY
        L8_2 = L8_2.SET_ENTITY_INVINCIBLE
        L9_2 = L6_2
        L10_2 = true
        L8_2(L9_2, L10_2)
        L8_2 = VEHICLE
        L8_2 = L8_2.MODIFY_VEHICLE_TOP_SPEED
        L9_2 = L6_2
        L10_2 = 50
        L8_2(L9_2, L10_2)
        L8_2 = VEHICLE
        L8_2 = L8_2.SET_VEHICLE_DOORS_LOCKED
        L9_2 = L6_2
        L10_2 = -1
        L11_2 = 3
        L8_2(L9_2, L10_2, L11_2)
        L8_2 = TASK
        L8_2 = L8_2.CLEAR_PED_TASKS_IMMEDIATELY
        L9_2 = L7_2
        L8_2(L9_2)
        L8_2 = PED
        L8_2 = L8_2.SET_PED_INTO_VEHICLE
        L9_2 = L7_2
        L10_2 = L6_2
        L11_2 = -1
        L8_2(L9_2, L10_2, L11_2)
        L8_2 = PED
        L8_2 = L8_2.SET_PED_COMBAT_ATTRIBUTES
        L9_2 = L7_2
        L10_2 = 46
        L11_2 = true
        L8_2(L9_2, L10_2, L11_2)
        L8_2 = TASK
        L8_2 = L8_2.TASK_COMBAT_PED
        L9_2 = L7_2
        L10_2 = L0_2
        L11_2 = 0
        L12_2 = 0
        L8_2(L9_2, L10_2, L11_2, L12_2)
        L8_2 = TASK
        L8_2 = L8_2.TASK_VEHICLE_MISSION_PED_TARGET
        L9_2 = L7_2
        L10_2 = L6_2
        L11_2 = L0_2
        L12_2 = 6
        L13_2 = 100
        L14_2 = 0
        L15_2 = 0
        L16_2 = 0
        L17_2 = true
        L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
        L8_2 = util
        L8_2 = L8_2.yield
        L9_2 = 10
        L8_2(L9_2)
      end
    end
  end
end
Hostile_traffic = L18_1
function L18_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2
  L4_2 = PED
  L4_2 = L4_2.GET_VEHICLE_PED_IS_IN
  L5_2 = PLAYER
  L5_2 = L5_2.GET_PLAYER_PED_SCRIPT_INDEX
  L6_2 = A0_2
  L5_2 = L5_2(L6_2)
  L6_2 = true
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = ENTITY
  L5_2 = L5_2.GET_ENTITY_COORDS
  L6_2 = L4_2
  L7_2 = true
  L5_2 = L5_2(L6_2, L7_2)
  L6_2 = L5_2.x
  L5_2.x = L6_2
  L6_2 = L5_2.y
  L5_2.y = L6_2
  L6_2 = L5_2.z
  L5_2.z = L6_2
  L6_2 = request_model
  L7_2 = A1_2
  L6_2(L7_2)
  L6_2 = OBJECT
  L6_2 = L6_2.CREATE_OBJECT_NO_OFFSET
  L7_2 = A1_2
  L8_2 = L5_2.x
  L9_2 = L5_2.y
  L10_2 = L5_2.z
  L11_2 = true
  L12_2 = false
  L13_2 = false
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L7_2 = get_model_size
  L8_2 = ENTITY
  L8_2 = L8_2.GET_ENTITY_MODEL
  L9_2 = L4_2
  L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2 = L8_2(L9_2)
  L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
  if A2_2 then
    L8_2 = ENTITY
    L8_2 = L8_2.ATTACH_ENTITY_TO_ENTITY
    L9_2 = L6_2
    L10_2 = L4_2
    L11_2 = 0
    L12_2 = 0.0
    L13_2 = 0.0
    L14_2 = 0.0
    L15_2 = 0.0
    L16_2 = 0.0
    L17_2 = A3_2
    L18_2 = true
    L19_2 = true
    L20_2 = true
    L21_2 = false
    L22_2 = 0
    L23_2 = true
    L24_2 = 0
    L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
  else
    L8_2 = ENTITY
    L8_2 = L8_2.ATTACH_ENTITY_TO_ENTITY
    L9_2 = L6_2
    L10_2 = L4_2
    L11_2 = 0
    L12_2 = 0.0
    L13_2 = L7_2.y
    L13_2 = L13_2 + 1.0
    L14_2 = 0.0
    L15_2 = 0.0
    L16_2 = 0.0
    L17_2 = A3_2
    L18_2 = true
    L19_2 = true
    L20_2 = true
    L21_2 = false
    L22_2 = 0
    L23_2 = true
    L24_2 = 0
    L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
  end
end
give_car_addon = L18_1
function L18_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = give_car_addon
  L2_2 = A0_2
  L3_2 = util
  L3_2 = L3_2.joaat
  L4_2 = "h4_prop_h4_loch_monster"
  L3_2 = L3_2(L4_2)
  L4_2 = true
  L5_2 = -90.0
  L1_2(L2_2, L3_2, L4_2, L5_2)
end
changemodel = L18_1
function L18_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = give_car_addon
  L2_2 = A0_2
  L3_2 = util
  L3_2 = L3_2.joaat
  L4_2 = "prop_gold_cont_01b"
  L3_2 = L3_2(L4_2)
  L4_2 = true
  L5_2 = -90.0
  L1_2(L2_2, L3_2, L4_2, L5_2)
end
longzi_veh = L18_1
function L18_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  L3_2 = PLAYER
  L3_2 = L3_2.GET_PLAYER_PED_SCRIPT_INDEX
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = PED
  L4_2 = L4_2.IS_PED_IN_ANY_VEHICLE
  L5_2 = L3_2
  L6_2 = true
  L4_2 = L4_2(L5_2, L6_2)
  if L4_2 then
    L4_2 = PED
    L4_2 = L4_2.GET_VEHICLE_PED_IS_IN
    L5_2 = L3_2
    L6_2 = false
    L4_2 = L4_2(L5_2, L6_2)
    L5_2 = true
    L6_2 = 0
    L7_2 = VEHICLE
    L7_2 = L7_2.GET_VEHICLE_MODEL_NUMBER_OF_SEATS
    L8_2 = ENTITY
    L8_2 = L8_2.GET_ENTITY_MODEL
    L9_2 = L4_2
    L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L8_2(L9_2)
    L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
    L8_2 = 1
    for L9_2 = L6_2, L7_2, L8_2 do
      L10_2 = VEHICLE
      L10_2 = L10_2.IS_VEHICLE_SEAT_FREE
      L11_2 = L4_2
      L12_2 = L9_2
      L10_2 = L10_2(L11_2, L12_2)
      if L10_2 then
        L10_2 = ENTITY
        L10_2 = L10_2.GET_ENTITY_COORDS
        L11_2 = L4_2
        L10_2 = L10_2(L11_2)
        L11_2 = 0
        if 1 == A1_2 then
          L12_2 = PED
          L12_2 = L12_2.CREATE_RANDOM_PED
          L13_2 = L10_2.x
          L14_2 = L10_2.y
          L15_2 = L10_2.z
          L12_2 = L12_2(L13_2, L14_2, L15_2)
          L11_2 = L12_2
        elseif 2 == A1_2 then
          L12_2 = {}
          L13_2 = "s_f_y_cop_01"
          L14_2 = "s_m_m_snowcop_0"
          L15_2 = "s_m_y_hwaycop_01"
          L16_2 = "csb_cop"
          L17_2 = "s_m_y_cop_01"
          L12_2[1] = L13_2
          L12_2[2] = L14_2
          L12_2[3] = L15_2
          L12_2[4] = L16_2
          L12_2[5] = L17_2
          L13_2 = math
          L13_2 = L13_2.random
          L14_2 = 1
          L15_2 = #L12_2
          L13_2 = L13_2(L14_2, L15_2)
          L13_2 = L12_2[L13_2]
          L14_2 = request_model
          L15_2 = util
          L15_2 = L15_2.joaat
          L16_2 = L13_2
          L15_2, L16_2, L17_2, L18_2, L19_2 = L15_2(L16_2)
          L14_2(L15_2, L16_2, L17_2, L18_2, L19_2)
          L14_2 = entities
          L14_2 = L14_2.create_ped
          L15_2 = 6
          L16_2 = util
          L16_2 = L16_2.joaat
          L17_2 = L13_2
          L16_2 = L16_2(L17_2)
          L17_2 = L10_2
          L18_2 = 0
          L14_2 = L14_2(L15_2, L16_2, L17_2, L18_2)
          L11_2 = L14_2
          L14_2 = PED
          L14_2 = L14_2.SET_PED_AS_COP
          L15_2 = L11_2
          L16_2 = true
          L14_2(L15_2, L16_2)
          L14_2 = WEAPON
          L14_2 = L14_2.GIVE_WEAPON_TO_PED
          L15_2 = L11_2
          L16_2 = util
          L16_2 = L16_2.joaat
          L17_2 = "weapon_pistol"
          L16_2 = L16_2(L17_2)
          L17_2 = 1000
          L18_2 = false
          L19_2 = false
          L14_2(L15_2, L16_2, L17_2, L18_2, L19_2)
        elseif 3 == A1_2 then
          L12_2 = {}
          L13_2 = "csb_stripper_01"
          L14_2 = "csb_stripper_02"
          L15_2 = "s_f_y_stripper_01"
          L16_2 = "s_f_y_stripper_02"
          L17_2 = "s_f_y_stripperlite"
          L12_2[1] = L13_2
          L12_2[2] = L14_2
          L12_2[3] = L15_2
          L12_2[4] = L16_2
          L12_2[5] = L17_2
          L13_2 = math
          L13_2 = L13_2.random
          L14_2 = 1
          L15_2 = #L12_2
          L13_2 = L13_2(L14_2, L15_2)
          L13_2 = L12_2[L13_2]
          L14_2 = request_model
          L15_2 = util
          L15_2 = L15_2.joaat
          L16_2 = L13_2
          L15_2, L16_2, L17_2, L18_2, L19_2 = L15_2(L16_2)
          L14_2(L15_2, L16_2, L17_2, L18_2, L19_2)
          L14_2 = entities
          L14_2 = L14_2.create_ped
          L15_2 = 6
          L16_2 = util
          L16_2 = L16_2.joaat
          L17_2 = L13_2
          L16_2 = L16_2(L17_2)
          L17_2 = L10_2
          L18_2 = 0
          L14_2 = L14_2(L15_2, L16_2, L17_2, L18_2)
          L11_2 = L14_2
        elseif 4 == A1_2 then
          L12_2 = request_model
          L13_2 = util
          L13_2 = L13_2.joaat
          L14_2 = "ig_lestercrest"
          L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L13_2(L14_2)
          L12_2(L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
          L12_2 = entities
          L12_2 = L12_2.create_ped
          L13_2 = 6
          L14_2 = util
          L14_2 = L14_2.joaat
          L15_2 = "ig_lestercrest"
          L14_2 = L14_2(L15_2)
          L15_2 = L10_2
          L16_2 = 0
          L12_2 = L12_2(L13_2, L14_2, L15_2, L16_2)
          L11_2 = L12_2
        elseif 5 == A1_2 then
          L12_2 = request_model
          L13_2 = util
          L13_2 = L13_2.joaat
          L14_2 = "ig_lestercrest"
          L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L13_2(L14_2)
          L12_2(L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
          L12_2 = entities
          L12_2 = L12_2.create_ped
          L13_2 = 6
          L14_2 = util
          L14_2 = L14_2.joaat
          L15_2 = "ig_lestercrest"
          L14_2 = L14_2(L15_2)
          L15_2 = L10_2
          L16_2 = 0
          L12_2 = L12_2(L13_2, L14_2, L15_2, L16_2)
          L11_2 = L12_2
        end
        L12_2 = PED
        L12_2 = L12_2.SET_PED_INTO_VEHICLE
        L13_2 = L11_2
        L14_2 = L4_2
        L15_2 = L9_2
        L12_2(L13_2, L14_2, L15_2)
        L12_2 = PED
        L12_2 = L12_2.SET_PED_COMBAT_ATTRIBUTES
        L13_2 = L11_2
        L14_2 = 5
        L15_2 = true
        L12_2(L13_2, L14_2, L15_2)
        L12_2 = PED
        L12_2 = L12_2.SET_PED_FLEE_ATTRIBUTES
        L13_2 = L11_2
        L14_2 = 0
        L15_2 = false
        L12_2(L13_2, L14_2, L15_2)
        L12_2 = PED
        L12_2 = L12_2.SET_PED_COMBAT_ATTRIBUTES
        L13_2 = L11_2
        L14_2 = 46
        L15_2 = true
        L12_2(L13_2, L14_2, L15_2)
        L12_2 = PED
        L12_2 = L12_2.SET_PED_CAN_BE_DRAGGED_OUT
        L13_2 = L11_2
        L14_2 = false
        L12_2(L13_2, L14_2)
        L12_2 = PED
        L12_2 = L12_2.SET_PED_CAN_BE_KNOCKED_OFF_VEHICLE
        L13_2 = L11_2
        L14_2 = false
        L12_2(L13_2, L14_2)
      end
    end
  end
end
npcfillthecar = L18_1
function L18_1()
  local L0_2, L1_2
  L0_2 = ENTITY
  L0_2 = L0_2.IS_ENTITY_IN_WATER
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L0_2 = L0_2(L1_2)
  if L0_2 then
    L0_2 = PED
    L0_2 = L0_2.IS_PED_DEAD_OR_DYING
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_PED_ID
    L1_2 = L1_2()
    L0_2 = L0_2(L1_2)
    if not L0_2 then
      L0_2 = menu
      L0_2 = L0_2.trigger_commands
      L1_2 = "ewo"
      L0_2(L1_2)
    end
  end
end
VicecityWater = L18_1
function L18_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "p_spinning_anus_s"
  L1_2 = L1_2(L2_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2 = L3_2()
  L4_2 = false
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = request_model
  L4_2 = L1_2
  L3_2(L4_2)
  if A0_2 then
    L3_2 = entities
    L3_2 = L3_2.create_object
    L4_2 = L1_2
    L5_2 = L2_2
    L3_2 = L3_2(L4_2, L5_2)
    obj = L3_2
    L3_2 = ENTITY
    L3_2 = L3_2.SET_ENTITY_VISIBLE
    L4_2 = obj
    L5_2 = false
    L3_2(L4_2, L5_2)
    L3_2 = ENTITY
    L3_2 = L3_2.ATTACH_ENTITY_TO_ENTITY
    L4_2 = obj
    L5_2 = PLAYER
    L5_2 = L5_2.PLAYER_PED_ID
    L5_2 = L5_2()
    L6_2 = 0
    L7_2 = 0
    L8_2 = 0
    L9_2 = 0
    L10_2 = 0
    L11_2 = 0
    L12_2 = 0
    L13_2 = false
    L14_2 = false
    L15_2 = true
    L16_2 = false
    L17_2 = 0
    L18_2 = false
    L19_2 = 0
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
  else
    L3_2 = delete_entity
    L4_2 = obj
    L3_2(L4_2)
  end
end
force_Field = L18_1
L18_1 = 0
L19_1 = 20
function L20_1(A0_2)
  local L1_2
  L18_1 = A0_2
end
force_Field_direction = L20_1
function L20_1(A0_2)
  local L1_2
  L1_2 = A0_2 / 100
  L19_1 = L1_2
end
force_Field_range = L20_1
function L20_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2
  L0_2 = {}
  L1_2 = players
  L1_2 = L1_2.get_position
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_ID
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
  L2_2 = pairs
  L3_2 = entities
  L3_2 = L3_2.get_all_vehicles_as_handles
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2 = L3_2()
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = ENTITY
    L8_2 = L8_2.GET_ENTITY_COORDS
    L9_2 = L7_2
    L10_2 = false
    L8_2 = L8_2(L9_2, L10_2)
    L9_2 = v3
    L9_2 = L9_2.distance
    L10_2 = L1_2
    L11_2 = L8_2
    L9_2 = L9_2(L10_2, L11_2)
    L10_2 = L19_1
    if L9_2 <= L10_2 then
      L9_2 = table
      L9_2 = L9_2.insert
      L10_2 = L0_2
      L11_2 = L7_2
      L9_2(L10_2, L11_2)
    end
  end
  L2_2 = pairs
  L3_2 = entities
  L3_2 = L3_2.get_all_peds_as_handles
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2 = L3_2()
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = ENTITY
    L8_2 = L8_2.GET_ENTITY_COORDS
    L9_2 = L7_2
    L10_2 = false
    L8_2 = L8_2(L9_2, L10_2)
    L9_2 = v3
    L9_2 = L9_2.distance
    L10_2 = L1_2
    L11_2 = L8_2
    L9_2 = L9_2(L10_2, L11_2)
    L10_2 = L19_1
    if L9_2 <= L10_2 then
      L9_2 = PED
      L9_2 = L9_2.IS_PED_A_PLAYER
      L10_2 = L7_2
      L9_2 = L9_2(L10_2)
      if not L9_2 then
        L9_2 = table
        L9_2 = L9_2.insert
        L10_2 = L0_2
        L11_2 = L7_2
        L9_2(L10_2, L11_2)
      end
    end
  end
  L2_2 = pairs
  L3_2 = L0_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = PED
    L8_2 = L8_2.GET_VEHICLE_PED_IS_IN
    L9_2 = PLAYER
    L9_2 = L9_2.PLAYER_PED_ID
    L9_2 = L9_2()
    L10_2 = true
    L8_2 = L8_2(L9_2, L10_2)
    L9_2 = ENTITY
    L9_2 = L9_2.GET_ENTITY_TYPE
    L10_2 = L7_2
    L9_2 = L9_2(L10_2)
    L10_2 = NETWORK
    L10_2 = L10_2.NETWORK_REQUEST_CONTROL_OF_ENTITY
    L11_2 = L7_2
    L10_2 = L10_2(L11_2)
    if L10_2 and L8_2 ~= L7_2 then
      if 1 == L9_2 then
        L10_2 = PED
        L10_2 = L10_2.SET_PED_TO_RAGDOLL
        L11_2 = L7_2
        L12_2 = 500
        L13_2 = 0
        L14_2 = 0
        L15_2 = false
        L16_2 = false
        L17_2 = false
        L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
      end
      L10_2 = L18_1
      if 1 == L10_2 then
        L10_2 = ENTITY
        L10_2 = L10_2.APPLY_FORCE_TO_ENTITY
        L11_2 = L7_2
        L12_2 = 3
        L13_2 = 0
        L14_2 = 0
        L15_2 = 1
        L16_2 = 0
        L17_2 = 0
        L18_2 = 0.5
        L19_2 = 0
        L20_2 = false
        L21_2 = false
        L22_2 = true
        L23_2 = false
        L24_2 = false
        L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
      else
        L10_2 = ENTITY
        L10_2 = L10_2.GET_ENTITY_COORDS
        L11_2 = L7_2
        L10_2 = L10_2(L11_2)
        L11_2 = v3
        L11_2 = L11_2.sub
        L12_2 = L10_2
        L13_2 = L1_2
        L11_2(L12_2, L13_2)
        L11_2 = v3
        L11_2 = L11_2.normalise
        L12_2 = L10_2
        L11_2(L12_2)
        L11_2 = L18_1
        if 2 == L11_2 then
          L11_2 = v3
          L11_2 = L11_2.mul
          L12_2 = L10_2
          L13_2 = -1
          L11_2(L12_2, L13_2)
        end
        L11_2 = ENTITY
        L11_2 = L11_2.APPLY_FORCE_TO_ENTITY
        L12_2 = L7_2
        L13_2 = 3
        L14_2 = L10_2.x
        L15_2 = L10_2.y
        L16_2 = L10_2.z
        L17_2 = 0
        L18_2 = 0
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
force_Field_pro = L20_1
function L20_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = players
  L0_2 = L0_2.get_position
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L1_2 = GRAPHICS1
  L1_2 = L1_2._DRAW_SPHERE
  L2_2 = L0_2.x
  L3_2 = L0_2.y
  L4_2 = L0_2.z
  L5_2 = L19_1
  L6_2 = 223
  L7_2 = 99
  L8_2 = 231
  L9_2 = 0.5
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
end
Plot_force_field_range = L20_1
function L20_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2
  L0_2 = ENTITY
  L0_2 = L0_2.GET_ENTITY_COORDS
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
  L1_2 = entities
  L1_2 = L1_2.get_all_peds_as_handles
  L1_2 = L1_2()
  all_peds = L1_2
  L1_2 = 0
  L2_2 = 0
  L3_2 = pairs
  L4_2 = all_peds
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = PED
    L9_2 = L9_2.IS_PED_A_PLAYER
    L10_2 = L8_2
    L9_2 = L9_2(L10_2)
    if not L9_2 then
      L9_2 = PED
      L9_2 = L9_2.IS_PED_FATALLY_INJURED
      L10_2 = L8_2
      L9_2 = L9_2(L10_2)
      if not L9_2 then
        L9_2 = request_control
        L10_2 = L8_2
        L9_2(L10_2)
        L9_2 = PED
        L9_2 = L9_2.IS_PED_IN_ANY_VEHICLE
        L10_2 = L8_2
        L11_2 = true
        L9_2 = L9_2(L10_2, L11_2)
        if L9_2 then
          L9_2 = TASK
          L9_2 = L9_2.CLEAR_PED_TASKS_IMMEDIATELY
          L10_2 = L8_2
          L9_2(L10_2)
          L9_2 = TASK
          L9_2 = L9_2.TASK_LEAVE_ANY_VEHICLE
          L10_2 = L8_2
          L11_2 = 0
          L12_2 = 16
          L9_2(L10_2, L11_2, L12_2)
        end
        L9_2 = ENTITY
        L9_2 = L9_2.DETACH_ENTITY
        L10_2 = L8_2
        L11_2 = false
        L12_2 = false
        L9_2(L10_2, L11_2, L12_2)
        if 0 ~= L1_2 then
          L9_2 = ENTITY
          L9_2 = L9_2.ATTACH_ENTITY_TO_ENTITY
          L10_2 = L8_2
          L11_2 = L1_2
          L12_2 = 0
          L13_2 = 0.0
          L14_2 = 0.0
          L15_2 = L2_2 - 0.5
          L16_2 = 0.0
          L17_2 = 0.0
          L18_2 = 0.0
          L19_2 = false
          L20_2 = false
          L21_2 = false
          L22_2 = false
          L23_2 = 0
          L24_2 = true
          L25_2 = 0
          L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
        else
          L9_2 = ENTITY
          L9_2 = L9_2.SET_ENTITY_COORDS
          L10_2 = L8_2
          L11_2 = L0_2.x
          L12_2 = L0_2.y
          L13_2 = L0_2.z
          L9_2(L10_2, L11_2, L12_2, L13_2)
        end
        L1_2 = L8_2
        L9_2 = get_model_size
        L10_2 = ENTITY
        L10_2 = L10_2.GET_ENTITY_MODEL
        L11_2 = L8_2
        L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2 = L10_2(L11_2)
        L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
        L2_2 = L9_2.z
      end
    end
  end
end
stack_npc = L20_1
function L20_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L0_2 = pairs
  L1_2 = entities
  L1_2 = L1_2.get_all_peds_as_handles
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L1_2()
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = PED
    L6_2 = L6_2.IS_PED_A_PLAYER
    L7_2 = L5_2
    L6_2 = L6_2(L7_2)
    if not L6_2 then
      L6_2 = ENTITY
      L6_2 = L6_2.IS_ENTITY_IN_AIR
      L7_2 = L5_2
      L6_2 = L6_2(L7_2)
      if not L6_2 then
        L6_2 = ENTITY
        L6_2 = L6_2.GET_ENTITY_COORDS
        L7_2 = PLAYER
        L7_2 = L7_2.PLAYER_PED_ID
        L7_2, L8_2, L9_2, L10_2, L11_2 = L7_2()
        L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
        L7_2 = L6_2.x
        L8_2 = math
        L8_2 = L8_2.random
        L9_2 = -50
        L10_2 = 50
        L8_2 = L8_2(L9_2, L10_2)
        L7_2 = L7_2 + L8_2
        L6_2.x = L7_2
        L7_2 = L6_2.y
        L8_2 = math
        L8_2 = L8_2.random
        L9_2 = -50
        L10_2 = 50
        L8_2 = L8_2(L9_2, L10_2)
        L7_2 = L7_2 + L8_2
        L6_2.y = L7_2
        L7_2 = L6_2.z
        L8_2 = math
        L8_2 = L8_2.random
        L9_2 = 50
        L10_2 = 100
        L8_2 = L8_2(L9_2, L10_2)
        L7_2 = L7_2 + L8_2
        L6_2.z = L7_2
        L7_2 = ENTITY
        L7_2 = L7_2.SET_ENTITY_COORDS
        L8_2 = L5_2
        L9_2 = L6_2.x
        L10_2 = L6_2.y
        L11_2 = L6_2.z
        L7_2(L8_2, L9_2, L10_2, L11_2)
        L7_2 = ENTITY
        L7_2 = L7_2.SET_ENTITY_VELOCITY
        L8_2 = L5_2
        L9_2 = 0.0
        L10_2 = 0.0
        L11_2 = -1.0
        L7_2(L8_2, L9_2, L10_2, L11_2)
      end
    end
  end
end
Npc_Rain = L20_1
function L20_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L0_2 = pairs
  L1_2 = entities
  L1_2 = L1_2.get_all_vehicles_as_handles
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L1_2()
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = PED
    L6_2 = L6_2.GET_VEHICLE_PED_IS_IN
    L7_2 = PLAYER
    L7_2 = L7_2.PLAYER_PED_ID
    L7_2 = L7_2()
    L8_2 = false
    L6_2 = L6_2(L7_2, L8_2)
    if L6_2 ~= L5_2 then
      L7_2 = ENTITY
      L7_2 = L7_2.IS_ENTITY_IN_AIR
      L8_2 = L5_2
      L7_2 = L7_2(L8_2)
      if not L7_2 then
        L7_2 = ENTITY
        L7_2 = L7_2.GET_ENTITY_COORDS
        L8_2 = PLAYER
        L8_2 = L8_2.PLAYER_PED_ID
        L8_2, L9_2, L10_2, L11_2, L12_2 = L8_2()
        L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2)
        L8_2 = L7_2.x
        L9_2 = math
        L9_2 = L9_2.random
        L10_2 = -50
        L11_2 = 50
        L9_2 = L9_2(L10_2, L11_2)
        L8_2 = L8_2 + L9_2
        L7_2.x = L8_2
        L8_2 = L7_2.y
        L9_2 = math
        L9_2 = L9_2.random
        L10_2 = -50
        L11_2 = 50
        L9_2 = L9_2(L10_2, L11_2)
        L8_2 = L8_2 + L9_2
        L7_2.y = L8_2
        L8_2 = L7_2.z
        L9_2 = math
        L9_2 = L9_2.random
        L10_2 = 100
        L11_2 = 120
        L9_2 = L9_2(L10_2, L11_2)
        L8_2 = L8_2 + L9_2
        L7_2.z = L8_2
        L8_2 = ENTITY
        L8_2 = L8_2.SET_ENTITY_COORDS
        L9_2 = L5_2
        L10_2 = L7_2.x
        L11_2 = L7_2.y
        L12_2 = L7_2.z
        L8_2(L9_2, L10_2, L11_2, L12_2)
      end
    end
  end
end
Vehicle_Rain = L20_1
L20_1 = {}
function L21_1()
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
  L3_2 = L20_1
  L3_2 = #L3_2
  L4_2 = L3_2 + 1
  L3_2 = L20_1
  L5_2 = create_ped
  L6_2 = 28
  L7_2 = L1_2
  L8_2 = L2_2.x
  L9_2 = L2_2.y
  L10_2 = L2_2.z
  L11_2 = math
  L11_2 = L11_2.random
  L12_2 = 0
  L13_2 = 360
  L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L11_2(L12_2, L13_2)
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L3_2[L4_2] = L5_2
  L3_2 = ENTITY
  L3_2 = L3_2.SET_ENTITY_HEALTH
  L4_2 = L20_1
  L4_2 = #L4_2
  L5_2 = L4_2 + 1
  L4_2 = L20_1
  L4_2 = L4_2[L5_2]
  L5_2 = 0.0
  L6_2 = 1
  L3_2(L4_2, L5_2, L6_2)
  L3_2 = ENTITY
  L3_2 = L3_2.APPLY_FORCE_TO_ENTITY
  L4_2 = L20_1
  L4_2 = #L4_2
  L5_2 = L4_2 + 1
  L4_2 = L20_1
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
  L3_2 = L20_1
  L3_2 = #L3_2
  if L3_2 > 50 then
    L3_2 = delete_entity
    L4_2 = L20_1
    L4_2 = L4_2[1]
    L3_2(L4_2)
    L3_2 = table
    L3_2 = L3_2.remove
    L4_2 = L20_1
    L5_2 = 1
    L3_2(L4_2, L5_2)
  end
  L3_2 = util
  L3_2 = L3_2.yield
  L4_2 = 100
  L3_2(L4_2)
end
fish_rain = L21_1
function L21_1()
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
Dominoes = L21_1
L21_1 = {}
entityPairs = L21_1
L21_1 = {}
shotEntities = L21_1
counter = 0
L21_1 = {}
L21_1.ent1 = 0
L21_1.ent2 = 0
EntityPair = L21_1
L21_1 = EntityPair
L22_1 = EntityPair
L21_1.__index = L22_1
L21_1 = EntityPair
function L22_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = setmetatable
  L3_2 = {}
  L4_2 = EntityPair
  L2_2 = L2_2(L3_2, L4_2)
  L2_2.ent1 = A0_2
  L2_2.ent2 = A1_2
  return L2_2
end
L21_1.new = L22_1
L21_1 = EntityPair
function L22_1(A0_2)
  local L1_2, L2_2
  L1_2 = ENTITY
  L1_2 = L1_2.DOES_ENTITY_EXIST
  L2_2 = A0_2.ent1
  L1_2 = L1_2(L2_2)
  if L1_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.DOES_ENTITY_EXIST
    L2_2 = A0_2.ent2
    L1_2 = L1_2(L2_2)
  end
  return L1_2
end
L21_1.exists = L22_1
function L21_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L3_2 = ENTITY
  L3_2 = L3_2.IS_ENTITY_A_PED
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  if L3_2 then
    L3_2 = PED
    L3_2 = L3_2.IS_PED_A_PLAYER
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    if L3_2 then
      return
    end
    L3_2 = PED
    L3_2 = L3_2.SET_PED_TO_RAGDOLL
    L4_2 = A0_2
    L5_2 = 1000
    L6_2 = 1000
    L7_2 = 0
    L8_2 = false
    L9_2 = false
    L10_2 = false
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  end
  L3_2 = request_control
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  if L3_2 then
    L3_2 = ENTITY
    L3_2 = L3_2.APPLY_FORCE_TO_ENTITY
    L4_2 = A0_2
    L5_2 = A2_2 or L5_2
    if not A2_2 then
      L5_2 = 1
    end
    L6_2 = A1_2.x
    L7_2 = A1_2.y
    L8_2 = A1_2.z
    L9_2 = 0.0
    L10_2 = 0.0
    L11_2 = 0.0
    L12_2 = 0
    L13_2 = false
    L14_2 = false
    L15_2 = true
    L16_2 = false
    L17_2 = false
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  end
end
apply_force_to_ent = L21_1
L21_1 = EntityPair
function L22_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_COORDS
  L2_2 = A0_2.ent1
  L3_2 = false
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = A0_2.ent2
  L4_2 = false
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = v3
  L3_2 = L3_2.new
  L4_2 = L2_2
  L3_2 = L3_2(L4_2)
  L5_2 = L3_2
  L4_2 = L3_2.sub
  L6_2 = L1_2
  L4_2(L5_2, L6_2)
  L5_2 = L3_2
  L4_2 = L3_2.mul
  L6_2 = 0.05
  L4_2(L5_2, L6_2)
  L4_2 = apply_force_to_ent
  L5_2 = A0_2.ent1
  L6_2 = L3_2
  L4_2(L5_2, L6_2)
  L5_2 = L3_2
  L4_2 = L3_2.mul
  L6_2 = -1
  L4_2(L5_2, L6_2)
  L4_2 = apply_force_to_ent
  L5_2 = A0_2.ent2
  L6_2 = L3_2
  L4_2(L5_2, L6_2)
end
L21_1.attract = L22_1
L21_1 = table
function L22_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L2_2 = pairs
  L3_2 = A0_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    if A1_2 == L7_2 then
      return L6_2
    end
  end
  L2_2 = nil
  return L2_2
end
L21_1.find = L22_1
L21_1 = table
function L22_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = table
  L2_2 = L2_2.find
  L3_2 = A0_2
  L4_2 = A1_2
  L2_2 = L2_2(L3_2, L4_2)
  if not L2_2 then
    L2_2 = table
    L2_2 = L2_2.insert
    L3_2 = A0_2
    L4_2 = A1_2
    L2_2(L3_2, L4_2)
  end
end
L21_1.insert_once = L22_1
function L21_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = setmetatable
  L3_2 = {}
  L4_2 = EntityPair
  L2_2 = L2_2(L3_2, L4_2)
  L2_2.ent1 = A0_2
  L2_2.ent2 = A1_2
  return L2_2
end
EntityPair_new = L21_1
function L21_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = get_entity_player_is_aiming_at
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  if 0 ~= L0_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.DOES_ENTITY_EXIST
    L2_2 = L0_2
    L1_2 = L1_2(L2_2)
    if L1_2 then
      L1_2 = draw_bounding_box
      L2_2 = L0_2
      L3_2 = true
      L4_2 = {}
      L4_2.r = 255
      L4_2.g = 255
      L4_2.b = 255
      L4_2.a = 81
      L1_2(L2_2, L3_2, L4_2)
      L1_2 = PED
      L1_2 = L1_2.IS_PED_SHOOTING
      L2_2 = PLAYER
      L2_2 = L2_2.PLAYER_PED_ID
      L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2 = L2_2()
      L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
      if L1_2 then
        L1_2 = shotEntities
        L1_2 = L1_2[1]
        if L1_2 then
          L1_2 = shotEntities
          L1_2 = L1_2[1]
          if L1_2 == L0_2 then
            goto lbl_47
          end
        end
        L1_2 = counter
        L1_2 = L1_2 + 1
        counter = L1_2
        L1_2 = shotEntities
        L2_2 = counter
        L1_2[L2_2] = L0_2
      end
      ::lbl_47::
      L1_2 = counter
      if 2 == L1_2 then
        L1_2 = EntityPair_new
        L2_2 = table
        L2_2 = L2_2.unpack
        L3_2 = shotEntities
        L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2 = L2_2(L3_2)
        L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
        L2_2 = table
        L2_2 = L2_2.insert_once
        L3_2 = entityPairs
        L4_2 = L1_2
        L2_2(L3_2, L4_2)
        counter = 0
        L2_2 = {}
        shotEntities = L2_2
      end
    end
  end
  L1_2 = entityPairs
  L1_2 = #L1_2
  L2_2 = 1
  L3_2 = -1
  for L4_2 = L1_2, L2_2, L3_2 do
    L5_2 = entityPairs
    L5_2 = L5_2[L4_2]
    L7_2 = L5_2
    L6_2 = L5_2.exists
    L6_2 = L6_2(L7_2)
    if L6_2 then
      L7_2 = L5_2
      L6_2 = L5_2.attract
      L6_2(L7_2)
    else
      L6_2 = table
      L6_2 = L6_2.remove
      L7_2 = entityPairs
      L8_2 = L4_2
      L6_2(L7_2, L8_2)
    end
  end
end
ctst = L21_1
function L21_1()
  local L0_2, L1_2
  counter = 0
  L0_2 = {}
  shotEntities = L0_2
  L0_2 = {}
  entityPairs = L0_2
end
ctst_stop = L21_1
function L21_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = memory
  L1_2 = L1_2.alloc_int
  L1_2 = L1_2()
  L2_2 = PED
  L2_2 = L2_2.ADD_RELATIONSHIP_GROUP
  L3_2 = A0_2
  L4_2 = L1_2
  L2_2(L3_2, L4_2)
  L2_2 = memory
  L2_2 = L2_2.read_int
  L3_2 = L1_2
  L2_2 = L2_2(L3_2)
  return L2_2
end
addRelationshipGroup = L21_1
L21_1 = {}
relationship = L21_1
L21_1 = relationship
function L22_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = nil
  if nil == L2_2 then
    L3_2 = addRelationshipGroup
    L4_2 = "friendly_group"
    L3_2 = L3_2(L4_2)
    L2_2 = L3_2
    L3_2 = PED
    L3_2 = L3_2.SET_RELATIONSHIP_BETWEEN_GROUPS
    L4_2 = 0
    L5_2 = L2_2
    L6_2 = L2_2
    L3_2(L4_2, L5_2, L6_2)
  end
  L3_2 = PED
  L3_2 = L3_2.SET_PED_RELATIONSHIP_GROUP_HASH
  L4_2 = A1_2
  L5_2 = L2_2
  L3_2(L4_2, L5_2)
end
L21_1.friendly = L22_1
function L21_1(A0_2)
  local L1_2, L2_2
  L1_2 = bodyguard_heli
  L2_2 = sel_heli_model_list
  L2_2 = L2_2[A0_2]
  L1_2.name = L2_2
end
Bodyguard_helicopter = L21_1
function L21_1(A0_2)
  local L1_2
  L1_2 = bodyguard_heli
  L1_2.heli_godmode = A0_2
end
Bodyguard_helicopter_invincible = L21_1
function L21_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2
  L0_2 = util
  L0_2 = L0_2.joaat
  L1_2 = bodyguard_heli
  L1_2 = L1_2.name
  L0_2 = L0_2(L1_2)
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "s_m_y_blackops_01"
  L1_2 = L1_2(L2_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2 = L3_2()
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
  L3_2 = L2_2.x
  L4_2 = math
  L4_2 = L4_2.random
  L5_2 = -10
  L6_2 = 10
  L4_2 = L4_2(L5_2, L6_2)
  L3_2 = L3_2 + L4_2
  L2_2.x = L3_2
  L3_2 = L2_2.y
  L4_2 = math
  L4_2 = L4_2.random
  L5_2 = -10
  L6_2 = 10
  L4_2 = L4_2(L5_2, L6_2)
  L3_2 = L3_2 + L4_2
  L2_2.y = L3_2
  L3_2 = L2_2.z
  L3_2 = L3_2 + 30
  L2_2.z = L3_2
  L3_2 = request_models
  L4_2 = L1_2
  L5_2 = L0_2
  L3_2(L4_2, L5_2)
  L3_2 = relationship
  L4_2 = L3_2
  L3_2 = L3_2.friendly
  L5_2 = PLAYER
  L5_2 = L5_2.PLAYER_PED_ID
  L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2 = L5_2()
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
  L3_2 = entities
  L3_2 = L3_2.create_vehicle
  L4_2 = L0_2
  L5_2 = L2_2
  L6_2 = CAM
  L6_2 = L6_2.GET_GAMEPLAY_CAM_ROT
  L7_2 = 0
  L6_2 = L6_2(L7_2)
  L6_2 = L6_2.z
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  L4_2 = ENTITY
  L4_2 = L4_2.DOES_ENTITY_EXIST
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  if not L4_2 then
    L4_2 = util
    L4_2 = L4_2.toast
    L5_2 = "Failed to create vehicle. Please try again"
    L4_2(L5_2)
    return
  else
    L4_2 = NETWORK
    L4_2 = L4_2.VEH_TO_NET
    L5_2 = L3_2
    L4_2 = L4_2(L5_2)
    L5_2 = NETWORK
    L5_2 = L5_2.NETWORK_GET_ENTITY_IS_NETWORKED
    L6_2 = NETWORK
    L6_2 = L6_2.NET_TO_PED
    L7_2 = L4_2
    L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2 = L6_2(L7_2)
    L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
    if L5_2 then
      L5_2 = NETWORK
      L5_2 = L5_2.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES
      L6_2 = L4_2
      L7_2 = true
      L5_2(L6_2, L7_2)
    end
    L5_2 = NETWORK
    L5_2 = L5_2.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER
    L6_2 = L4_2
    L7_2 = PLAYER
    L7_2 = L7_2.PLAYER_ID
    L7_2 = L7_2()
    L8_2 = true
    L5_2(L6_2, L7_2, L8_2)
    L5_2 = VEHICLE
    L5_2 = L5_2.SET_VEHICLE_ENGINE_ON
    L6_2 = L3_2
    L7_2 = true
    L8_2 = true
    L9_2 = true
    L5_2(L6_2, L7_2, L8_2, L9_2)
    L5_2 = VEHICLE
    L5_2 = L5_2.SET_HELI_BLADES_FULL_SPEED
    L6_2 = L3_2
    L5_2(L6_2)
    L5_2 = VEHICLE
    L5_2 = L5_2.SET_VEHICLE_SEARCHLIGHT
    L6_2 = L3_2
    L7_2 = true
    L8_2 = true
    L5_2(L6_2, L7_2, L8_2)
    L5_2 = addBlipForEntity
    L6_2 = L3_2
    L7_2 = 422
    L8_2 = 26
    L5_2(L6_2, L7_2, L8_2)
    L5_2 = ENTITY
    L5_2 = L5_2.SET_ENTITY_INVINCIBLE
    L6_2 = L3_2
    L7_2 = bodyguard_heli
    L7_2 = L7_2.heli_godmode
    L5_2(L6_2, L7_2)
    L5_2 = ENTITY
    L5_2 = L5_2.SET_ENTITY_MAX_HEALTH
    L6_2 = L3_2
    L7_2 = 10000
    L5_2(L6_2, L7_2)
    L5_2 = ENTITY
    L5_2 = L5_2.SET_ENTITY_HEALTH
    L6_2 = L3_2
    L7_2 = 10000
    L8_2 = 0
    L5_2(L6_2, L7_2, L8_2)
    L5_2 = table
    L5_2 = L5_2.insert
    L6_2 = heli_list
    L7_2 = L3_2
    L5_2(L6_2, L7_2)
  end
  L4_2 = entities
  L4_2 = L4_2.create_ped
  L5_2 = 29
  L6_2 = L1_2
  L7_2 = L2_2
  L8_2 = CAM
  L8_2 = L8_2.GET_GAMEPLAY_CAM_ROT
  L9_2 = 0
  L8_2 = L8_2(L9_2)
  L8_2 = L8_2.z
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  L5_2 = PED
  L5_2 = L5_2.SET_PED_INTO_VEHICLE
  L6_2 = L4_2
  L7_2 = L3_2
  L8_2 = -1
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = PED
  L5_2 = L5_2.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS
  L6_2 = L4_2
  L7_2 = true
  L5_2(L6_2, L7_2)
  L5_2 = TASK
  L5_2 = L5_2.TASK_HELI_MISSION
  L6_2 = L4_2
  L7_2 = L3_2
  L8_2 = 0
  L9_2 = PLAYER
  L9_2 = L9_2.PLAYER_PED_ID
  L9_2 = L9_2()
  L10_2 = 0.0
  L11_2 = 0.0
  L12_2 = 0.0
  L13_2 = 23
  L14_2 = 80.0
  L15_2 = 50.0
  L16_2 = -1.0
  L17_2 = 0
  L18_2 = 10
  L19_2 = -1.0
  L20_2 = 0
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
  L5_2 = PED
  L5_2 = L5_2.SET_PED_KEEP_TASK
  L6_2 = L4_2
  L7_2 = true
  L5_2(L6_2, L7_2)
  L5_2 = PED
  L5_2 = L5_2.SET_PED_MAX_HEALTH
  L6_2 = L4_2
  L7_2 = 1000
  L5_2(L6_2, L7_2)
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_HEALTH
  L6_2 = L4_2
  L7_2 = 1000
  L8_2 = 0
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_INVINCIBLE
  L6_2 = L4_2
  L7_2 = bodyguard_heli
  L7_2 = L7_2.ped_godmode
  L5_2(L6_2, L7_2)
  L5_2 = table
  L5_2 = L5_2.insert
  L6_2 = heli_ped_list
  L7_2 = L4_2
  L5_2(L6_2, L7_2)
  L5_2 = 0
  L6_2 = 2
  L7_2 = 1
  for L8_2 = L5_2, L6_2, L7_2 do
    L9_2 = entities
    L9_2 = L9_2.create_ped
    L10_2 = 29
    L11_2 = L1_2
    L12_2 = L2_2
    L13_2 = CAM
    L13_2 = L13_2.GET_GAMEPLAY_CAM_ROT
    L14_2 = 0
    L13_2 = L13_2(L14_2)
    L13_2 = L13_2.z
    L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2)
    L10_2 = NETWORK
    L10_2 = L10_2.PED_TO_NET
    L11_2 = L9_2
    L10_2 = L10_2(L11_2)
    L11_2 = NETWORK
    L11_2 = L11_2.NETWORK_GET_ENTITY_IS_NETWORKED
    L12_2 = L9_2
    L11_2 = L11_2(L12_2)
    if L11_2 then
      L11_2 = NETWORK
      L11_2 = L11_2.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES
      L12_2 = L10_2
      L13_2 = true
      L11_2(L12_2, L13_2)
    end
    L11_2 = NETWORK
    L11_2 = L11_2.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER
    L12_2 = L10_2
    L13_2 = PLAYER
    L13_2 = L13_2.PLAYER_ID
    L13_2 = L13_2()
    L14_2 = true
    L11_2(L12_2, L13_2, L14_2)
    L11_2 = PED
    L11_2 = L11_2.SET_PED_INTO_VEHICLE
    L12_2 = L9_2
    L13_2 = L3_2
    L14_2 = L8_2
    L11_2(L12_2, L13_2, L14_2)
    L11_2 = WEAPON
    L11_2 = L11_2.GIVE_WEAPON_TO_PED
    L12_2 = L9_2
    L13_2 = util
    L13_2 = L13_2.joaat
    L14_2 = "weapon_mg"
    L13_2 = L13_2(L14_2)
    L14_2 = -1
    L15_2 = false
    L16_2 = true
    L11_2(L12_2, L13_2, L14_2, L15_2, L16_2)
    L11_2 = WEAPON
    L11_2 = L11_2.SET_PED_INFINITE_AMMO_CLIP
    L12_2 = L9_2
    L13_2 = true
    L11_2(L12_2, L13_2)
    L11_2 = PED
    L11_2 = L11_2.SET_PED_COMBAT_ATTRIBUTES
    L12_2 = L9_2
    L13_2 = 5
    L14_2 = true
    L11_2(L12_2, L13_2, L14_2)
    L11_2 = PED
    L11_2 = L11_2.SET_PED_COMBAT_ATTRIBUTES
    L12_2 = L9_2
    L13_2 = 3
    L14_2 = false
    L11_2(L12_2, L13_2, L14_2)
    L11_2 = PED
    L11_2 = L11_2.SET_PED_COMBAT_MOVEMENT
    L12_2 = L9_2
    L13_2 = 2
    L11_2(L12_2, L13_2)
    L11_2 = PED
    L11_2 = L11_2.SET_PED_COMBAT_ABILITY
    L12_2 = L9_2
    L13_2 = 2
    L11_2(L12_2, L13_2)
    L11_2 = PED
    L11_2 = L11_2.SET_PED_COMBAT_RANGE
    L12_2 = L9_2
    L13_2 = 2
    L11_2(L12_2, L13_2)
    L11_2 = PED
    L11_2 = L11_2.SET_PED_SEEING_RANGE
    L12_2 = L9_2
    L13_2 = 500.0
    L11_2(L12_2, L13_2)
    L11_2 = PED
    L11_2 = L11_2.SET_PED_HEARING_RANGE
    L12_2 = L9_2
    L13_2 = 500.0
    L11_2(L12_2, L13_2)
    L11_2 = PED
    L11_2 = L11_2.SET_PED_TARGET_LOSS_RESPONSE
    L12_2 = L9_2
    L13_2 = 1
    L11_2(L12_2, L13_2)
    L11_2 = PED
    L11_2 = L11_2.SET_PED_HIGHLY_PERCEPTIVE
    L12_2 = L9_2
    L13_2 = true
    L11_2(L12_2, L13_2)
    L11_2 = PED
    L11_2 = L11_2.SET_PED_VISUAL_FIELD_PERIPHERAL_RANGE
    L12_2 = L9_2
    L13_2 = 500.0
    L11_2(L12_2, L13_2)
    L11_2 = PED
    L11_2 = L11_2.SET_COMBAT_FLOAT
    L12_2 = L9_2
    L13_2 = 10
    L14_2 = 500.0
    L11_2(L12_2, L13_2, L14_2)
    L11_2 = PED
    L11_2 = L11_2.SET_PED_SHOOT_RATE
    L12_2 = L9_2
    L13_2 = 1000.0
    L11_2(L12_2, L13_2)
    L11_2 = PED
    L11_2 = L11_2.SET_PED_ACCURACY
    L12_2 = L9_2
    L13_2 = 100.0
    L11_2(L12_2, L13_2)
    L11_2 = PED
    L11_2 = L11_2.SET_PED_CAN_BE_SHOT_IN_VEHICLE
    L12_2 = L9_2
    L13_2 = true
    L11_2(L12_2, L13_2)
    L11_2 = PED
    L11_2 = L11_2.SET_PED_MAX_HEALTH
    L12_2 = L9_2
    L13_2 = 1000
    L11_2(L12_2, L13_2)
    L11_2 = ENTITY
    L11_2 = L11_2.SET_ENTITY_HEALTH
    L12_2 = L9_2
    L13_2 = 1000
    L14_2 = 0
    L11_2(L12_2, L13_2, L14_2)
    L11_2 = ENTITY
    L11_2 = L11_2.SET_ENTITY_INVINCIBLE
    L12_2 = L9_2
    L13_2 = bodyguard_heli
    L13_2 = L13_2.ped_godmode
    L11_2(L12_2, L13_2)
    L11_2 = relationship
    L12_2 = L11_2
    L11_2 = L11_2.friendly
    L13_2 = L9_2
    L11_2(L12_2, L13_2)
    L11_2 = table
    L11_2 = L11_2.insert
    L12_2 = heli_ped_list
    L13_2 = L9_2
    L11_2(L12_2, L13_2)
  end
  L5_2 = STREAMING
  L5_2 = L5_2.SET_MODEL_AS_NO_LONGER_NEEDED
  L6_2 = L0_2
  L5_2(L6_2)
  L5_2 = STREAMING
  L5_2 = L5_2.SET_MODEL_AS_NO_LONGER_NEEDED
  L6_2 = L1_2
  L5_2(L6_2)
end
Spawn_bodyguard_helicopter = L21_1
function L21_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = pairs
  L1_2 = heli_ped_list
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = delete_entity
    L7_2 = L5_2
    L6_2(L7_2)
  end
  L0_2 = pairs
  L1_2 = heli_list
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = delete_entity
    L7_2 = L5_2
    L6_2(L7_2)
  end
end
delete_bodyguard_helicopter = L21_1
function L21_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  L1_2 = {}
  L2_2 = 1
  L3_2 = PLAYER
  L3_2 = L3_2.GET_PLAYER_PED
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = ENTITY
  L4_2 = L4_2.GET_ENTITY_COORDS
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  L5_2 = util
  L5_2 = L5_2.joaat
  L6_2 = "tug"
  L5_2 = L5_2(L6_2)
  L6_2 = request_model
  L7_2 = L5_2
  L6_2(L7_2)
  L6_2 = 1
  L7_2 = 20
  L8_2 = 1
  for L9_2 = L6_2, L7_2, L8_2 do
    L10_2 = VEHICLE
    L10_2 = L10_2.CREATE_VEHICLE
    L11_2 = L5_2
    L12_2 = L4_2.x
    L13_2 = L4_2.y
    L14_2 = L4_2.z
    L15_2 = 0
    L16_2 = true
    L17_2 = true
    L18_2 = true
    L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L1_2[L2_2] = L10_2
    L10_2 = NETWORK
    L10_2 = L10_2.NETWORK_GET_NETWORK_ID_FROM_ENTITY
    L11_2 = L1_2[L2_2]
    L10_2 = L10_2(L11_2)
    L11_2 = NETWORK
    L11_2 = L11_2.NETWORK_REQUEST_CONTROL_OF_ENTITY
    L12_2 = L1_2[L2_2]
    L11_2(L12_2)
    L11_2 = NETWORK
    L11_2 = L11_2.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID
    L12_2 = L10_2
    L11_2(L12_2)
    L11_2 = NETWORK
    L11_2 = L11_2.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES
    L12_2 = L10_2
    L11_2(L12_2)
    L11_2 = NETWORK
    L11_2 = L11_2.SET_NETWORK_ID_CAN_MIGRATE
    L12_2 = L10_2
    L13_2 = false
    L11_2(L12_2, L13_2)
    L11_2 = NETWORK
    L11_2 = L11_2.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER
    L12_2 = L10_2
    L13_2 = A0_2
    L14_2 = true
    L11_2(L12_2, L13_2, L14_2)
    L11_2 = ENTITY
    L11_2 = L11_2.SET_ENTITY_AS_MISSION_ENTITY
    L12_2 = L1_2[L2_2]
    L13_2 = true
    L14_2 = false
    L11_2(L12_2, L13_2, L14_2)
    L11_2 = ENTITY
    L11_2 = L11_2.SET_ENTITY_VISIBLE
    L12_2 = L1_2[L2_2]
    L13_2 = false
    L14_2 = 0
    L11_2(L12_2, L13_2, L14_2)
    L2_2 = L2_2 + 1
  end
end
fried_fish = L21_1
function L21_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED_SCRIPT_INDEX
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = L1_2
  L4_2 = true
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = request_model
  L4_2 = 447548909
  L3_2(L4_2)
  L3_2 = 300
  while L3_2 >= 1 do
    L4_2 = entities
    L4_2 = L4_2.create_vehicle
    L5_2 = 447548909
    L6_2 = L2_2
    L7_2 = 0
    L4_2(L5_2, L6_2, L7_2)
    L3_2 = L3_2 - 1
    L4_2 = util
    L4_2 = L4_2.yield
    L5_2 = 10
    L4_2(L5_2)
  end
end
Titan_bombing = L21_1
function L21_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L1_2 = players
  L1_2 = L1_2.get_position
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = request_ptfx_asset
  L3_2 = "scr_rcbarry2"
  L2_2(L3_2)
  L2_2 = GRAPHICS
  L2_2 = L2_2.USE_PARTICLE_FX_ASSET
  L3_2 = "scr_rcbarry2"
  L2_2(L3_2)
  L2_2 = GRAPHICS
  L3_2 = "START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD"
  L2_2 = L2_2[L3_2]
  L3_2 = "scr_clown_death"
  L4_2 = L1_2.x
  L5_2 = L1_2.y
  L6_2 = L1_2.z
  L7_2 = 0
  L8_2 = 0
  L9_2 = 0
  L10_2 = 2.5
  L11_2 = false
  L12_2 = false
  L13_2 = false
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L2_2 = GRAPHICS
  L2_2 = L2_2.USE_PARTICLE_FX_ASSET
  L3_2 = "scr_rcbarry2"
  L2_2(L3_2)
  L2_2 = GRAPHICS
  L3_2 = "START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD"
  L2_2 = L2_2[L3_2]
  L3_2 = "scr_exp_clown"
  L4_2 = L1_2.x
  L5_2 = L1_2.y
  L6_2 = L1_2.z
  L7_2 = 0
  L8_2 = 0
  L9_2 = 0
  L10_2 = 2.5
  L11_2 = false
  L12_2 = false
  L13_2 = false
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L2_2 = request_ptfx_asset
  L3_2 = "scr_ch_finale"
  L2_2(L3_2)
  L2_2 = GRAPHICS
  L2_2 = L2_2.USE_PARTICLE_FX_ASSET
  L3_2 = "scr_ch_finale"
  L2_2(L3_2)
  L2_2 = GRAPHICS
  L3_2 = "START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD"
  L2_2 = L2_2[L3_2]
  L3_2 = "scr_ch_finale_drill_sparks"
  L4_2 = L1_2.x
  L5_2 = L1_2.y
  L6_2 = L1_2.z
  L7_2 = 0
  L8_2 = 0
  L9_2 = 0
  L10_2 = 2.5
  L11_2 = false
  L12_2 = false
  L13_2 = false
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L2_2 = util
  L2_2 = L2_2.yield
  L3_2 = 100
  L2_2(L3_2)
end
Render_particles = L21_1
function L21_1(A0_2, A1_2)
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
tpTableToPlayer = L21_1
function L21_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = entities
  L1_2 = L1_2.get_all_peds_as_handles
  L1_2 = L1_2()
  L2_2 = tpTableToPlayer
  L3_2 = L1_2
  L4_2 = A0_2
  L2_2(L3_2, L4_2)
end
TpAllPeds = L21_1
function L21_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = entities
  L1_2 = L1_2.get_all_vehicles_as_handles
  L1_2 = L1_2()
  L2_2 = tpTableToPlayer
  L3_2 = L1_2
  L4_2 = A0_2
  L2_2(L3_2, L4_2)
end
TpAllVehs = L21_1
function L21_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = entities
  L1_2 = L1_2.get_all_objects_as_handles
  L1_2 = L1_2()
  L2_2 = tpTableToPlayer
  L3_2 = L1_2
  L4_2 = A0_2
  L2_2(L3_2, L4_2)
end
TpAllObjects = L21_1
L21_1 = util
L21_1 = L21_1.joaat
L22_1 = "VEHICLE_WEAPON_PLAYER_LAZER"
L21_1 = L21_1(L22_1)
L22_1 = Sound_new
L23_1 = "Fire_Loop"
L24_1 = "DLC_IE_VV_Gun_Player_Sounds"
L22_1 = L22_1(L23_1, L24_1)
function L23_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = PAD
  L0_2 = L0_2.DISABLE_CONTROL_ACTION
  L1_2 = 0
  L2_2 = 106
  L3_2 = true
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = PAD
  L0_2 = L0_2.DISABLE_CONTROL_ACTION
  L1_2 = 0
  L2_2 = 122
  L3_2 = true
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = PAD
  L0_2 = L0_2.DISABLE_CONTROL_ACTION
  L1_2 = 0
  L2_2 = 135
  L3_2 = true
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = PAD
  L0_2 = L0_2.DISABLE_CONTROL_ACTION
  L1_2 = 0
  L2_2 = 140
  L3_2 = true
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = PAD
  L0_2 = L0_2.DISABLE_CONTROL_ACTION
  L1_2 = 0
  L2_2 = 141
  L3_2 = true
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = PAD
  L0_2 = L0_2.DISABLE_CONTROL_ACTION
  L1_2 = 0
  L2_2 = 142
  L3_2 = true
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = PAD
  L0_2 = L0_2.DISABLE_CONTROL_ACTION
  L1_2 = 0
  L2_2 = 263
  L3_2 = true
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = PAD
  L0_2 = L0_2.DISABLE_CONTROL_ACTION
  L1_2 = 0
  L2_2 = 264
  L3_2 = true
  L0_2(L1_2, L2_2, L3_2)
end
DisableControlActions = L23_1
function L23_1(A0_2)
  local L1_2, L2_2
  L1_2 = AUDIO
  L1_2 = L1_2.HAS_SOUND_FINISHED
  L2_2 = A0_2.Id
  return L1_2(L2_2)
end
L22_1.hasFinished = L23_1
function L23_1(A0_2)
  local L1_2, L2_2
  L1_2 = A0_2.Id
  if -1 ~= L1_2 then
    L1_2 = AUDIO
    L1_2 = L1_2.STOP_SOUND
    L2_2 = A0_2.Id
    L1_2(L2_2)
    L1_2 = AUDIO
    L1_2 = L1_2.RELEASE_SOUND_ID
    L2_2 = A0_2.Id
    L1_2(L2_2)
    A0_2.Id = -1
  end
end
L22_1.stop = L23_1
function L23_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L2_2 = A0_2.Id
  if -1 == L2_2 then
    L2_2 = AUDIO
    L2_2 = L2_2.GET_SOUND_ID
    L2_2 = L2_2()
    A0_2.Id = L2_2
    L2_2 = AUDIO
    L2_2 = L2_2.PLAY_SOUND_FROM_ENTITY
    L3_2 = A0_2.Id
    L4_2 = A0_2.name
    L5_2 = A1_2
    L6_2 = A0_2.reference
    L7_2 = true
    L8_2 = 0
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  end
end
L22_1.playFromEntity = L23_1
function L23_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L0_2 = show_button
  L0_2()
  L0_2 = sf
  L0_2 = L0_2.SET_DATA_SLOT
  L1_2 = 0
  L2_2 = PAD
  L2_2 = L2_2.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING
  L3_2 = 0
  L4_2 = 46
  L5_2 = true
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = "镭射炮"
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = show_button2
  L0_2()
  L0_2 = HUD
  L0_2 = L0_2.DISPLAY_SNIPER_SCOPE_THIS_FRAME
  L0_2()
  L0_2 = DisableControlActions
  L0_2()
  L0_2 = WEAPON
  L0_2 = L0_2.HAS_WEAPON_ASSET_LOADED
  L1_2 = L21_1
  L0_2 = L0_2(L1_2)
  if not L0_2 then
    L0_2 = WEAPON
    L0_2 = L0_2.REQUEST_WEAPON_ASSET
    L1_2 = L21_1
    L2_2 = 31
    L3_2 = 26
    L0_2(L1_2, L2_2, L3_2)
  end
  L0_2 = PAD
  L0_2 = L0_2.IS_DISABLED_CONTROL_PRESSED
  L1_2 = 51
  L2_2 = 51
  L0_2 = L0_2(L1_2, L2_2)
  if not L0_2 then
    L0_2 = L22_1
    L1_2 = L0_2
    L0_2 = L0_2.hasFinished
    L0_2 = L0_2(L1_2)
    if not L0_2 then
      L0_2 = L22_1
      L1_2 = L0_2
      L0_2 = L0_2.stop
      L0_2(L1_2)
    end
  else
    L0_2 = timer
    L0_2 = L0_2.elapsed
    L0_2 = L0_2()
    if L0_2 > 100 then
      L0_2 = PED
      L0_2 = L0_2.GET_PED_BONE_COORDS
      L1_2 = PLAYER
      L1_2 = L1_2.PLAYER_PED_ID
      L1_2 = L1_2()
      L2_2 = 12844
      L3_2 = 0.0
      L4_2 = 0.0
      L5_2 = 0.0
      L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2)
      L1_2 = get_offset_from_cam
      L2_2 = 80
      L1_2 = L1_2(L2_2)
      L2_2 = L22_1
      L3_2 = L2_2
      L2_2 = L2_2.hasFinished
      L2_2 = L2_2(L3_2)
      if L2_2 then
        L2_2 = L22_1
        L3_2 = L2_2
        L2_2 = L2_2.playFromEntity
        L4_2 = PLAYER
        L4_2 = L4_2.PLAYER_PED_ID
        L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L4_2()
        L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
        L2_2 = AUDIO
        L2_2 = L2_2.SET_VARIABLE_ON_SOUND
        L3_2 = L22_1.Id
        L4_2 = "fireRate"
        L5_2 = 10.0
        L2_2(L3_2, L4_2, L5_2)
      end
      L2_2 = MISC
      L2_2 = L2_2.SHOOT_SINGLE_BULLET_BETWEEN_COORDS
      L3_2 = L0_2.x
      L4_2 = L0_2.y
      L5_2 = L0_2.z
      L6_2 = L1_2.x
      L7_2 = L1_2.y
      L8_2 = L1_2.z
      L9_2 = 200
      L10_2 = true
      L11_2 = L21_1
      L12_2 = PLAYER
      L12_2 = L12_2.PLAYER_PED_ID
      L12_2 = L12_2()
      L13_2 = true
      L14_2 = true
      L15_2 = -1.0
      L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
      L2_2 = timer
      L2_2 = L2_2.reset
      L2_2()
    end
  end
end
Laser_cannon = L23_1
function L23_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  L2_2 = entities
  L2_2 = L2_2.get_all_peds_as_pointers
  L2_2 = L2_2()
  L3_2 = A0_2 * A0_2
  L4_2 = ENTITY
  L4_2 = L4_2.GET_ENTITY_COORDS
  L5_2 = PLAYER
  L5_2 = L5_2.PLAYER_PED_ID
  L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L5_2()
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
  L5_2 = {}
  L6_2 = 0
  L7_2 = 1
  L8_2 = #L2_2
  L9_2 = 1
  for L10_2 = L7_2, L8_2, L9_2 do
    L11_2 = entities
    L11_2 = L11_2.get_position
    L12_2 = L2_2[L10_2]
    L11_2 = L11_2(L12_2)
    L12_2 = SYSTEM
    L12_2 = L12_2.VDIST2
    L13_2 = L4_2.x
    L14_2 = L4_2.y
    L15_2 = L4_2.z
    L16_2 = L11_2.x
    L17_2 = L11_2.y
    L18_2 = L11_2.z
    L12_2 = L12_2(L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    if L3_2 >= L12_2 then
      L13_2 = entities
      L13_2 = L13_2.pointer_to_handle
      L14_2 = L2_2[L10_2]
      L13_2 = L13_2(L14_2)
      if A1_2 then
        L14_2 = ENTITY
        L14_2 = L14_2.GET_ENTITY_HEIGHT_ABOVE_GROUND
        L15_2 = L13_2
        L14_2 = L14_2(L15_2)
      end
      if L14_2 >= 9 or not A1_2 then
        L14_2 = NETWORK
        L14_2 = L14_2.NETWORK_GET_PLAYER_INDEX_FROM_PED
        L15_2 = L13_2
        L14_2 = L14_2(L15_2)
        L15_2 = AIM_WHITELIST
        L15_2 = L15_2[L14_2]
        if not L15_2 then
          L15_2 = #L5_2
          L15_2 = L15_2 + 1
          L5_2[L15_2] = L13_2
        end
      end
    end
  end
  if nil ~= L5_2 then
    L7_2 = 999999
    L8_2 = 1
    L9_2 = #L5_2
    L10_2 = 1
    for L11_2 = L8_2, L9_2, L10_2 do
      L12_2 = L5_2[L11_2]
      L13_2 = PLAYER
      L13_2 = L13_2.PLAYER_PED_ID
      L13_2 = L13_2()
      if L12_2 ~= L13_2 then
        L12_2 = PED
        L12_2 = L12_2.IS_PED_A_PLAYER
        L13_2 = L5_2[L11_2]
        L12_2 = L12_2(L13_2)
        if L12_2 then
          L12_2 = ENTITY
          L12_2 = L12_2.GET_ENTITY_COORDS
          L13_2 = L5_2[L11_2]
          L12_2 = L12_2(L13_2)
          L13_2 = SYSTEM
          L13_2 = L13_2.VDIST2
          L14_2 = L4_2.x
          L15_2 = L4_2.y
          L16_2 = L4_2.z
          L17_2 = L12_2.x
          L18_2 = L12_2.y
          L19_2 = L12_2.z
          L13_2 = L13_2(L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
          if L7_2 > L13_2 then
            L7_2 = L13_2
            L6_2 = L5_2[L11_2]
          end
        end
      end
    end
  end
  if 0 ~= L6_2 then
    return L6_2
  else
    L7_2 = nil
    return L7_2
  end
end
GetClosestPlayerWithRange_Whitelist = L23_1
function L23_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  if A0_2 then
    L1_2 = "-1707997257"
    while true do
      L2_2 = PLAYER
      L2_2 = L2_2.PLAYER_PED_ID
      L2_2 = L2_2()
      L3_2 = ENTITY
      L3_2 = L3_2.GET_ENTITY_COORDS
      L4_2 = PLAYER
      L4_2 = L4_2.PLAYER_PED_ID
      L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2 = L4_2()
      L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
      L4_2 = ENTITY
      L4_2 = L4_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
      L5_2 = L2_2
      L6_2 = 0
      L7_2 = 5
      L8_2 = 0
      L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
      L5_2 = OBJECT
      L5_2 = L5_2.GET_CLOSEST_OBJECT_OF_TYPE
      L6_2 = L4_2.x
      L7_2 = L4_2.y
      L8_2 = L4_2.z
      L9_2 = 10
      L10_2 = L1_2
      L11_2 = false
      L12_2 = true
      L13_2 = true
      L14_2 = true
      L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
      RRocket = L5_2
      L5_2 = nil
      L6_2 = missile_settings
      L6_2 = L6_2.multitarget
      if L6_2 then
        L6_2 = missile_settings
        L6_2 = L6_2.air_target
        if L6_2 then
          L6_2 = _ENV
          L7_2 = "GetClosestPlayerWithRange_Whitelist_DisallowEntities"
          L6_2 = L6_2[L7_2]
          L7_2 = missile_settings
          L7_2 = L7_2.radius
          L8_2 = MISSILE_ENTITY_TABLE
          L9_2 = true
          L6_2 = L6_2(L7_2, L8_2, L9_2)
          L5_2 = L6_2
        else
          L6_2 = _ENV
          L7_2 = "GetClosestPlayerWithRange_Whitelist_DisallowEntities"
          L6_2 = L6_2[L7_2]
          L7_2 = missile_settings
          L7_2 = L7_2.radius
          L8_2 = MISSILE_ENTITY_TABLE
          L9_2 = false
          L6_2 = L6_2(L7_2, L8_2, L9_2)
          L5_2 = L6_2
        end
      else
        L6_2 = missile_settings
        L6_2 = L6_2.multiped
        if L6_2 then
          L6_2 = missile_settings
          L6_2 = L6_2.air_target
          if L6_2 then
            L6_2 = _ENV
            L7_2 = "GetClosestNonPlayerPedWithRange_DisallowedEntities"
            L6_2 = L6_2[L7_2]
            L7_2 = missile_settings
            L7_2 = L7_2.radius
            L8_2 = MISSILE_ENTITY_TABLE
            L9_2 = true
            L6_2 = L6_2(L7_2, L8_2, L9_2)
            L5_2 = L6_2
          else
            L6_2 = _ENV
            L7_2 = "GetClosestNonPlayerPedWithRange_DisallowedEntities"
            L6_2 = L6_2[L7_2]
            L7_2 = missile_settings
            L7_2 = L7_2.radius
            L8_2 = MISSILE_ENTITY_TABLE
            L9_2 = false
            L6_2 = L6_2(L7_2, L8_2, L9_2)
            L5_2 = L6_2
          end
        else
          L6_2 = missile_settings
          L6_2 = L6_2.multitarget
          if not L6_2 then
            L6_2 = missile_settings
            L6_2 = L6_2.air_target
            if L6_2 then
              L6_2 = GetClosestPlayerWithRange_Whitelist
              L7_2 = missile_settings
              L7_2 = L7_2.radius
              L8_2 = true
              L6_2 = L6_2(L7_2, L8_2)
              L5_2 = L6_2
            else
              L6_2 = GetClosestPlayerWithRange_Whitelist
              L7_2 = missile_settings
              L7_2 = L7_2.radius
              L8_2 = false
              L6_2 = L6_2(L7_2, L8_2)
              L5_2 = L6_2
            end
          end
        end
      end
      L6_2 = ENTITY
      L6_2 = L6_2.GET_ENTITY_COORDS
      L7_2 = L5_2
      L8_2 = false
      L6_2 = L6_2(L7_2, L8_2)
      L7_2 = RRocket
      if 0 ~= L7_2 and nil ~= L5_2 then
        L7_2 = PED
        L7_2 = L7_2.IS_PED_DEAD_OR_DYING
        L8_2 = L5_2
        L7_2 = L7_2(L8_2)
        if not L7_2 then
          L7_2 = AIM_WHITELIST
          L8_2 = NETWORK
          L8_2 = L8_2.NETWORK_GET_PLAYER_INDEX_FROM_PED
          L9_2 = L5_2
          L8_2 = L8_2(L9_2)
          L7_2 = L7_2[L8_2]
          if not L7_2 then
            L7_2 = PED
            L7_2 = L7_2.IS_PED_SHOOTING
            L8_2 = L2_2
            L7_2 = L7_2(L8_2)
            if L7_2 then
              L7_2 = players
              L7_2 = L7_2.is_in_interior
              L8_2 = NETWORK
              L8_2 = L8_2.NETWORK_GET_PLAYER_INDEX_FROM_PED
              L9_2 = L5_2
              L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2 = L8_2(L9_2)
              L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
              if not L7_2 then
                L7_2 = L6_2.z
                if L7_2 > 1 then
                  L7_2 = util
                  L7_2 = L7_2.create_thread
                  function L8_2()
                    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3
                    L0_3 = L5_2
                    L1_3 = RRocket
                    L2_3 = missile_settings
                    L2_3 = L2_3.multitarget
                    if L2_3 then
                      L2_3 = MISSILE_ENTITY_TABLE
                      L3_3 = MISSILE_ENTITY_TABLE
                      L3_3 = #L3_3
                      L3_3 = L3_3 + 1
                      L2_3[L3_3] = L0_3
                    end
                    L2_3 = ENTITY
                    L2_3 = L2_3.HAS_ENTITY_CLEAR_LOS_TO_ENTITY
                    L3_3 = L2_2
                    L4_3 = L0_3
                    L5_3 = 17
                    L2_3 = L2_3(L3_3, L4_3, L5_3)
                    if L2_3 then
                      L2_3 = missile_settings
                      L2_3 = L2_3.los
                      if L2_3 then
                        goto lbl_32
                      end
                    end
                    L2_3 = missile_settings
                    L2_3 = L2_3.los
                    if L2_3 then
                      L2_3 = MISL_AIR
                      if not L2_3 then
                        goto lbl_460
                      end
                    end
                    ::lbl_32::
                    L2_3 = util
                    L2_3 = L2_3.toast
                    L3_3 = "前兆完成！"
                    L2_3(L3_3)
                    L2_3 = NETWORK
                    L2_3 = L2_3.NETWORK_REQUEST_CONTROL_OF_ENTITY
                    L3_3 = L1_3
                    L2_3(L3_3)
                    L2_3 = NETWORK
                    L2_3 = L2_3.NETWORK_HAS_CONTROL_OF_ENTITY
                    L3_3 = L1_3
                    L2_3 = L2_3(L3_3)
                    if not L2_3 then
                      L2_3 = 1
                      L3_3 = 10
                      L4_3 = 1
                      for L5_3 = L2_3, L3_3, L4_3 do
                        L6_3 = NETWORK
                        L6_3 = L6_3.NETWORK_REQUEST_CONTROL_OF_ENTITY
                        L7_3 = L1_3
                        L6_3(L7_3)
                      end
                    else
                      L2_3 = util
                      L2_3 = L2_3.toast
                      L3_3 = "有控制权"
                      L2_3(L3_3)
                    end
                    L2_3 = 1
                    Missile_Camera = 0
                    L3_3 = STREAMING
                    L3_3 = L3_3.REQUEST_NAMED_PTFX_ASSET
                    L4_3 = missile_particles
                    L4_3 = L4_3.dictionary
                    L3_3(L4_3)
                    while true do
                      L3_3 = STREAMING
                      L3_3 = L3_3.HAS_NAMED_PTFX_ASSET_LOADED
                      L4_3 = missile_particles
                      L4_3 = L4_3.dictionary
                      L3_3 = L3_3(L4_3)
                      if L3_3 then
                        break
                      end
                      L3_3 = STREAMING
                      L3_3 = L3_3.REQUEST_NAMED_PTFX_ASSET
                      L4_3 = missile_particles
                      L4_3 = L4_3.dictionary
                      L3_3(L4_3)
                      L3_3 = util
                      L3_3 = L3_3.yield
                      L3_3()
                    end
                    L3_3 = GRAPHICS
                    L3_3 = L3_3.USE_PARTICLE_FX_ASSET
                    L4_3 = missile_particles
                    L4_3 = L4_3.dictionary
                    L3_3(L4_3)
                    while true do
                      L3_3 = ENTITY
                      L3_3 = L3_3.DOES_ENTITY_EXIST
                      L4_3 = L1_3
                      L3_3 = L3_3(L4_3)
                      if not L3_3 then
                        break
                      end
                      L3_3 = util
                      L3_3 = L3_3.toast
                      L4_3 = "火箭存在"
                      L3_3(L4_3)
                      L3_3 = ENTITY
                      L3_3 = L3_3.GET_ENTITY_COORDS
                      L4_3 = L0_3
                      L3_3 = L3_3(L4_3)
                      L4_3 = GetTableFromV3Instance
                      L5_3 = L3_3
                      L4_3 = L4_3(L5_3)
                      L5_3 = ENTITY
                      L5_3 = L5_3.GET_ENTITY_COORDS
                      L6_3 = L1_3
                      L5_3 = L5_3(L6_3)
                      L6_3 = GetTableFromV3Instance
                      L7_3 = L5_3
                      L6_3 = L6_3(L7_3)
                      L7_3 = v3
                      L7_3 = L7_3.lookAt
                      L8_3 = L5_3
                      L9_3 = L3_3
                      L7_3 = L7_3(L8_3, L9_3)
                      L8_3 = GetTableFromV3Instance
                      L9_3 = L7_3
                      L8_3 = L8_3(L9_3)
                      L9_3 = v3
                      L9_3 = L9_3.toDir
                      L10_3 = L7_3
                      L9_3 = L9_3(L10_3)
                      L10_3 = GetTableFromV3Instance
                      L11_3 = L9_3
                      L10_3 = L10_3(L11_3)
                      L11_3 = missile_settings
                      L11_3 = L11_3.ptfx
                      if L11_3 then
                        L11_3 = STREAMING
                        L11_3 = L11_3.REQUEST_NAMED_PTFX_ASSET
                        L12_3 = missile_particles
                        L12_3 = L12_3.dictionary
                        L11_3(L12_3)
                        while true do
                          L11_3 = STREAMING
                          L11_3 = L11_3.HAS_NAMED_PTFX_ASSET_LOADED
                          L12_3 = missile_particles
                          L12_3 = L12_3.dictionary
                          L11_3 = L11_3(L12_3)
                          if L11_3 then
                            break
                          end
                          L11_3 = STREAMING
                          L11_3 = L11_3.REQUEST_NAMED_PTFX_ASSET
                          L12_3 = missile_particles
                          L12_3 = L12_3.dictionary
                          L11_3(L12_3)
                          L11_3 = util
                          L11_3 = L11_3.yield
                          L11_3()
                        end
                        L11_3 = GRAPHICS
                        L11_3 = L11_3.USE_PARTICLE_FX_ASSET
                        L12_3 = missile_particles
                        L12_3 = L12_3.dictionary
                        L11_3(L12_3)
                        L11_3 = GRAPHICS
                        L12_3 = "START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD"
                        L11_3 = L11_3[L12_3]
                        L12_3 = missile_particles
                        L12_3 = L12_3.name
                        L13_3 = L6_3.x
                        L14_3 = L6_3.y
                        L15_3 = L6_3.z
                        L16_3 = 0
                        L17_3 = 0
                        L18_3 = 0
                        L19_3 = missile_settings
                        L19_3 = L19_3.ptfx_scale
                        L19_3 = 0.4 * L19_3
                        L20_3 = false
                        L21_3 = false
                        L22_3 = false
                        L23_3 = true
                        L11_3(L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3)
                      end
                      if L2_3 < 2 then
                        L11_3 = MISL_AIR
                        if L11_3 then
                          L11_3 = ENTITY
                          L11_3 = L11_3.DOES_ENTITY_EXIST
                          L12_3 = L1_3
                          L11_3 = L11_3(L12_3)
                          if L11_3 then
                            L11_3 = ENTITY
                            L11_3 = L11_3.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
                            L12_3 = L1_3
                            L13_3 = 1
                            L14_3 = 0
                            L15_3 = 0
                            L16_3 = 2700
                            L17_3 = true
                            L18_3 = false
                            L19_3 = true
                            L20_3 = true
                            L11_3(L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3)
                            L2_3 = L2_3 + 1
                            L11_3 = util
                            L11_3 = L11_3.yield
                            L12_3 = 1100
                            L11_3(L12_3)
                          end
                        end
                      end
                      L11_3 = 0
                      L12_3 = MISL_AIR
                      if L12_3 then
                        L12_3 = missile_settings
                        L12_3 = L12_3.cam
                        if L12_3 then
                          L12_3 = CAM
                          L12_3 = L12_3.DOES_CAM_EXIST
                          L13_3 = Missile_Camera
                          L12_3 = L12_3(L13_3)
                          if not L12_3 then
                            L12_3 = util
                            L12_3 = L12_3.toast
                            L13_3 = "相机设置"
                            L12_3(L13_3)
                            L12_3 = CAM
                            L12_3 = L12_3.DESTROY_ALL_CAMS
                            L13_3 = true
                            L12_3(L13_3)
                            L12_3 = CAM
                            L12_3 = L12_3.CREATE_CAM
                            L13_3 = "DEFAULT_SCRIPTED_CAMERA"
                            L14_3 = true
                            L12_3 = L12_3(L13_3, L14_3)
                            Missile_Camera = L12_3
                            L12_3 = CAM
                            L12_3 = L12_3.SET_CAM_ACTIVE
                            L13_3 = Missile_Camera
                            L14_3 = true
                            L12_3(L13_3, L14_3)
                            L12_3 = CAM
                            L12_3 = L12_3.RENDER_SCRIPT_CAMS
                            L13_3 = true
                            L14_3 = false
                            L15_3 = 0
                            L16_3 = true
                            L17_3 = true
                            L18_3 = 0
                            L12_3(L13_3, L14_3, L15_3, L16_3, L17_3, L18_3)
                          end
                        end
                        L12_3 = math
                        L12_3 = L12_3.abs
                        L13_3 = L6_3.x
                        L14_3 = L4_3.x
                        L13_3 = L13_3 - L14_3
                        L12_3 = L12_3(L13_3)
                        L13_3 = math
                        L13_3 = L13_3.abs
                        L14_3 = L6_3.y
                        L15_3 = L4_3.y
                        L14_3 = L14_3 - L15_3
                        L13_3 = L13_3(L14_3)
                        L14_3 = math
                        L14_3 = L14_3.abs
                        L15_3 = L6_3.z
                        L16_3 = L4_3.z
                        L15_3 = L15_3 - L16_3
                        L14_3 = L14_3(L15_3)
                        L15_3 = missile_settings
                        L15_3 = L15_3.cam
                        if L15_3 then
                          L15_3 = GENERIC_SYSTEM
                          L15_3 = L15_3.VDIST
                          L16_3 = L4_3.x
                          L17_3 = L4_3.y
                          L18_3 = L4_3.z
                          L19_3 = L6_3.x
                          L20_3 = L6_3.y
                          L21_3 = L6_3.z
                          L15_3 = L15_3(L16_3, L17_3, L18_3, L19_3, L20_3, L21_3)
                          if L15_3 > 50 then
                            L16_3 = CAM
                            L16_3 = L16_3.GET_CAM_COORD
                            L17_3 = Missile_Camera
                            L16_3 = L16_3(L17_3)
                            L17_3 = v3
                            L17_3 = L17_3.lookAt
                            L18_3 = L16_3
                            L19_3 = L5_3
                            L17_3 = L17_3(L18_3, L19_3)
                            L18_3 = GetTableFromV3Instance
                            L19_3 = L17_3
                            L18_3 = L18_3(L19_3)
                            L19_3 = ENTITY
                            L19_3 = L19_3.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
                            L20_3 = L1_3
                            L21_3 = 10
                            L22_3 = 10
                            L23_3 = -2
                            L19_3 = L19_3(L20_3, L21_3, L22_3, L23_3)
                            L20_3 = CAM
                            L20_3 = L20_3.SET_CAM_COORD
                            L21_3 = Missile_Camera
                            L22_3 = L19_3.x
                            L23_3 = L19_3.y
                            L24_3 = L19_3.z
                            L20_3(L21_3, L22_3, L23_3, L24_3)
                            if L11_3 < 1 then
                              L20_3 = CAM
                              L20_3 = L20_3.SET_CAM_ROT
                              L21_3 = Missile_Camera
                              L22_3 = L18_3.x
                              L23_3 = L18_3.y
                              L24_3 = L18_3.z
                              L25_3 = 2
                              L20_3(L21_3, L22_3, L23_3, L24_3, L25_3)
                              L11_3 = L11_3 + 1
                            end
                          else
                            L16_3 = CAM
                            L16_3 = L16_3.GET_CAM_COORD
                            L17_3 = Missile_Camera
                            L16_3 = L16_3(L17_3)
                            L17_3 = v3
                            L17_3 = L17_3.lookAt
                            L18_3 = L16_3
                            L19_3 = L5_3
                            L17_3 = L17_3(L18_3, L19_3)
                            L18_3 = GetTableFromV3Instance
                            L19_3 = L17_3
                            L18_3 = L18_3(L19_3)
                            L19_3 = CAM
                            L19_3 = L19_3.SET_CAM_ROT
                            L20_3 = Missile_Camera
                            L21_3 = L18_3.x
                            L22_3 = L18_3.y
                            L23_3 = L18_3.z
                            L24_3 = 2
                            L19_3(L20_3, L21_3, L22_3, L23_3, L24_3)
                          end
                        end
                        L15_3 = ENTITY
                        L15_3 = L15_3.SET_ENTITY_ROTATION
                        L16_3 = L1_3
                        L17_3 = L8_3.x
                        L18_3 = L8_3.y
                        L19_3 = L8_3.z
                        L20_3 = 2
                        L21_3 = true
                        L15_3(L16_3, L17_3, L18_3, L19_3, L20_3, L21_3)
                        L15_3 = ENTITY
                        L15_3 = L15_3.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
                        L16_3 = L1_3
                        L17_3 = 1
                        L18_3 = L10_3.x
                        L19_3 = missile_settings
                        L19_3 = L19_3.speed
                        L18_3 = L18_3 * L19_3
                        L18_3 = L18_3 * L12_3
                        L19_3 = L10_3.y
                        L20_3 = missile_settings
                        L20_3 = L20_3.speed
                        L19_3 = L19_3 * L20_3
                        L19_3 = L19_3 * L13_3
                        L20_3 = L10_3.z
                        L21_3 = missile_settings
                        L21_3 = L21_3.speed
                        L20_3 = L20_3 * L21_3
                        L20_3 = L20_3 * L14_3
                        L21_3 = true
                        L22_3 = false
                        L23_3 = true
                        L24_3 = true
                        L15_3(L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3)
                        L15_3 = util
                        L15_3 = L15_3.yield
                        L15_3()
                      else
                        L12_3 = ENTITY
                        L12_3 = L12_3.SET_ENTITY_ROTATION
                        L13_3 = L1_3
                        L14_3 = L8_3.x
                        L15_3 = L8_3.y
                        L16_3 = L8_3.z
                        L17_3 = 2
                        L18_3 = true
                        L12_3(L13_3, L14_3, L15_3, L16_3, L17_3, L18_3)
                        L12_3 = ENTITY
                        L12_3 = L12_3.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS
                        L13_3 = L1_3
                        L14_3 = 1
                        L15_3 = L10_3.x
                        L16_3 = missile_settings
                        L16_3 = L16_3.speed
                        L15_3 = L15_3 * L16_3
                        L16_3 = L10_3.y
                        L17_3 = missile_settings
                        L17_3 = L17_3.speed
                        L16_3 = L16_3 * L17_3
                        L17_3 = L10_3.z
                        L18_3 = missile_settings
                        L18_3 = L18_3.speed
                        L17_3 = L17_3 * L18_3
                        L18_3 = true
                        L19_3 = false
                        L20_3 = true
                        L21_3 = true
                        L12_3(L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3)
                        L12_3 = util
                        L12_3 = L12_3.yield
                        L12_3()
                      end
                    end
                    L3_3 = missile_settings
                    L3_3 = L3_3.cam
                    if L3_3 then
                      L3_3 = util
                      L3_3 = L3_3.yield
                      L4_3 = 2000
                      L3_3(L4_3)
                      L3_3 = util
                      L3_3 = L3_3.toast
                      L4_3 = "相机删除"
                      L3_3(L4_3)
                      L3_3 = CAM
                      L3_3 = L3_3.RENDER_SCRIPT_CAMS
                      L4_3 = false
                      L5_3 = false
                      L6_3 = 0
                      L7_3 = true
                      L8_3 = true
                      L9_3 = 0
                      L3_3(L4_3, L5_3, L6_3, L7_3, L8_3, L9_3)
                      L3_3 = CAM
                      L3_3 = L3_3.IS_CAM_ACTIVE
                      L4_3 = Missile_Camera
                      L3_3 = L3_3(L4_3)
                      if L3_3 then
                        L3_3 = CAM
                        L3_3 = L3_3.SET_CAM_ACTIVE
                        L4_3 = Missile_Camera
                        L5_3 = false
                        L3_3(L4_3, L5_3)
                      end
                      L3_3 = CAM
                      L3_3 = L3_3.DESTROY_CAM
                      L4_3 = Missile_Camera
                      L5_3 = true
                      L3_3(L4_3, L5_3)
                    end
                    ::lbl_460::
                    L2_3 = missile_settings
                    L2_3 = L2_3.multitarget
                    if L2_3 then
                      L2_3 = table
                      L2_3 = L2_3.remove
                      L3_3 = MISSILE_ENTITY_TABLE
                      L4_3 = GetValueIndexFromTable
                      L5_3 = MISSILE_ENTITY_TABLE
                      L6_3 = L0_3
                      L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3 = L4_3(L5_3, L6_3)
                      L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3)
                      L2_3 = util
                      L2_3 = L2_3.toast
                      L3_3 = "已删除的值"
                      L4_3 = tostring
                      L5_3 = L0_3
                      L4_3 = L4_3(L5_3)
                      L5_3 = " at index "
                      L6_3 = tostring
                      L7_3 = GetValueIndexFromTable
                      L8_3 = MISSILE_ENTITY_TABLE
                      L9_3 = L5_2
                      L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3 = L7_3(L8_3, L9_3)
                      L6_3 = L6_3(L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3, L19_3, L20_3, L21_3, L22_3, L23_3, L24_3, L25_3)
                      L3_3 = L3_3 .. L4_3 .. L5_3 .. L6_3
                      L2_3(L3_3)
                    end
                  end
                  L7_2(L8_2)
                end
              end
            end
          end
        end
      end
      L7_2 = util
      L7_2 = L7_2.yield
      L7_2()
    end
  end
end
RPG_Automatic_sight = L23_1
L23_1 = 786603
L24_1 = 20.0
function L25_1(A0_2)
  local L1_2
  L1_2 = drivestyletables
  L1_2 = L1_2[A0_2]
  L23_1 = L1_2
end
drivestylee = L25_1
function L25_1(A0_2)
  local L1_2
  L1_2 = A0_2 / 100
  L24_1 = L1_2
end
drivespeedd = L25_1
function L25_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  Auto_drived = A0_2
  L1_2 = players
  L1_2 = L1_2.get_position
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_ID
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
  L2_2 = entities
  L2_2 = L2_2.get_user_vehicle_as_handle
  L2_2 = L2_2()
  L3_2 = util
  L3_2 = L3_2.joaat
  L4_2 = "u_m_m_jesus_01"
  L3_2 = L3_2(L4_2)
  jesus = L3_2
  L3_2 = request_model
  L4_2 = jesus
  L3_2(L4_2)
  L3_2 = Auto_drived
  if L3_2 then
    L3_2 = PED
    L3_2 = L3_2.IS_PED_IN_ANY_VEHICLE
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2 = L4_2()
    L5_2 = false
    L3_2 = L3_2(L4_2, L5_2)
    if not L3_2 then
      L3_2 = util
      L3_2 = L3_2.toast
      L4_2 = "请先进入载具"
      L3_2(L4_2)
      L3_2 = menu
      L3_2 = L3_2.set_value
      L4_2 = jesus_toggle
      L5_2 = false
      L3_2(L4_2, L5_2)
      return
    else
      L3_2 = VEHICLE
      L3_2 = L3_2.GET_VEHICLE_MODEL_NUMBER_OF_SEATS
      L4_2 = ENTITY
      L4_2 = L4_2.GET_ENTITY_MODEL
      L5_2 = L2_2
      L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L4_2(L5_2)
      L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
      if L3_2 < 2 then
        L3_2 = util
        L3_2 = L3_2.toast
        L4_2 = "自动驾驶仅适用于多座位载具"
        L3_2(L4_2)
        L3_2 = menu
        L3_2 = L3_2.set_value
        L4_2 = jesus_toggle
        L5_2 = false
        L3_2(L4_2, L5_2)
        return
      end
    end
    L3_2 = entities
    L3_2 = L3_2.create_ped
    L4_2 = 26
    L5_2 = jesus
    L6_2 = L1_2
    L7_2 = 0
    L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
    jesus_ped = L3_2
    L3_2 = ENTITY
    L3_2 = L3_2.SET_ENTITY_INVINCIBLE
    L4_2 = jesus_ped
    L5_2 = true
    L3_2(L4_2, L5_2)
    L3_2 = ENTITY
    L3_2 = L3_2.SET_ENTITY_VISIBLE
    L4_2 = jesus_ped
    L5_2 = false
    L6_2 = false
    L3_2(L4_2, L5_2, L6_2)
    L3_2 = PED
    L3_2 = L3_2.SET_PED_INTO_VEHICLE
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2 = L4_2()
    L5_2 = L2_2
    L6_2 = -2
    L3_2(L4_2, L5_2, L6_2)
    L3_2 = PED
    L3_2 = L3_2.SET_PED_INTO_VEHICLE
    L4_2 = jesus_ped
    L5_2 = L2_2
    L6_2 = -1
    L3_2(L4_2, L5_2, L6_2)
    L3_2 = PED
    L3_2 = L3_2.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS
    L4_2 = jesus_ped
    L5_2 = true
    L3_2(L4_2, L5_2)
    L3_2 = PED
    L3_2 = L3_2.SET_PED_KEEP_TASK
    L4_2 = jesus_ped
    L5_2 = true
    L3_2(L4_2, L5_2)
    L3_2 = HUD
    L3_2 = L3_2.IS_WAYPOINT_ACTIVE
    L3_2 = L3_2()
    if L3_2 then
      L3_2 = HUD
      L3_2 = L3_2.GET_BLIP_COORDS
      L4_2 = HUD
      L4_2 = L4_2.GET_FIRST_BLIP_INFO_ID
      L5_2 = 8
      L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L4_2(L5_2)
      L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
      L4_2 = VEHICLE
      L4_2 = L4_2.IS_THIS_MODEL_A_HELI
      L5_2 = ENTITY
      L5_2 = L5_2.GET_ENTITY_MODEL
      L6_2 = L2_2
      L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L5_2(L6_2)
      L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
      if L4_2 then
        L4_2 = PED
        L4_2 = L4_2.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS
        L5_2 = jesus_ped
        L6_2 = true
        L4_2(L5_2, L6_2)
        L4_2 = TASK
        L4_2 = L4_2.TASK_HELI_MISSION
        L5_2 = jesus_ped
        L6_2 = L2_2
        L7_2 = 0
        L8_2 = 0
        L9_2 = L3_2.x
        L10_2 = L3_2.y
        L11_2 = L3_2.z
        L12_2 = 4
        L13_2 = 80.0
        L14_2 = 50.0
        L15_2 = -1.0
        L16_2 = 900.0
        L17_2 = 500.0
        L18_2 = 0
        L19_2 = 0
        L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
        L4_2 = PED
        L4_2 = L4_2.SET_PED_KEEP_TASK
        L5_2 = jesus_ped
        L6_2 = true
        L4_2(L5_2, L6_2)
      else
        L4_2 = VEHICLE
        L4_2 = L4_2.IS_THIS_MODEL_A_PLANE
        L5_2 = ENTITY
        L5_2 = L5_2.GET_ENTITY_MODEL
        L6_2 = L2_2
        L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L5_2(L6_2)
        L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
        if L4_2 then
          L4_2 = PED
          L4_2 = L4_2.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS
          L5_2 = jesus_ped
          L6_2 = true
          L4_2(L5_2, L6_2)
          L4_2 = TASK
          L4_2 = L4_2.TASK_PLANE_MISSION
          L5_2 = jesus_ped
          L6_2 = L2_2
          L7_2 = 0
          L8_2 = 0
          L9_2 = L3_2.x
          L10_2 = L3_2.y
          L11_2 = L3_2.z
          L12_2 = 4
          L13_2 = 80.0
          L14_2 = 50.0
          L15_2 = -1.0
          L16_2 = 900.0
          L17_2 = 500.0
          L18_2 = true
          L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
          L4_2 = PED
          L4_2 = L4_2.SET_PED_KEEP_TASK
          L5_2 = jesus_ped
          L6_2 = true
          L4_2(L5_2, L6_2)
        else
          L4_2 = VEHICLE
          L4_2 = L4_2.IS_THIS_MODEL_A_BOAT
          L5_2 = ENTITY
          L5_2 = L5_2.GET_ENTITY_MODEL
          L6_2 = L2_2
          L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L5_2(L6_2)
          L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
          if L4_2 then
            L4_2 = PED
            L4_2 = L4_2.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS
            L5_2 = jesus_ped
            L6_2 = true
            L4_2(L5_2, L6_2)
            L4_2 = TASK
            L4_2 = L4_2.TASK_BOAT_MISSION
            L5_2 = jesus_ped
            L6_2 = L2_2
            L7_2 = 0
            L8_2 = 0
            L9_2 = L3_2.x
            L10_2 = L3_2.y
            L11_2 = L3_2.z
            L12_2 = 4
            L13_2 = L24_1
            L14_2 = L23_1
            L15_2 = 0
            L16_2 = 0
            L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
            L4_2 = PED
            L4_2 = L4_2.SET_PED_KEEP_TASK
            L5_2 = jesus_ped
            L6_2 = true
            L4_2(L5_2, L6_2)
          else
            L4_2 = TASK1
            L4_2 = L4_2.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE
            L5_2 = jesus_ped
            L6_2 = L2_2
            L7_2 = L3_2
            L8_2 = L24_1
            L9_2 = L23_1
            L10_2 = 0.0
            L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
          end
        end
      end
      while true do
        L4_2 = Auto_drived
        if not L4_2 then
          break
        end
        L4_2 = HUD
        L4_2 = L4_2.IS_WAYPOINT_ACTIVE
        L4_2 = L4_2()
        if not L4_2 then
          L4_2 = util
          L4_2 = L4_2.toast
          L5_2 = "自动驾驶结束"
          L4_2(L5_2)
          L4_2 = menu
          L4_2 = L4_2.set_value
          L5_2 = jesus_toggle
          L6_2 = false
          L4_2(L5_2, L6_2)
        end
        L4_2 = util
        L4_2 = L4_2.yield
        L4_2()
      end
    else
      L3_2 = util
      L3_2 = L3_2.toast
      L4_2 = "请先设置一个导航点. :)"
      L3_2(L4_2)
      L3_2 = menu
      L3_2 = L3_2.set_value
      L4_2 = jesus_toggle
      L5_2 = false
      L3_2(L4_2, L5_2)
    end
    L3_2 = util
    L3_2 = L3_2.yield
    L3_2()
  else
    L3_2 = jesus_ped
    if nil ~= L3_2 then
      L3_2 = delete_entity
      L4_2 = jesus_ped
      L3_2(L4_2)
      L3_2 = ENTITY
      L3_2 = L3_2.GET_ENTITY_HEALTH
      L4_2 = L2_2
      L3_2 = L3_2(L4_2)
      if L3_2 > 0 then
        L3_2 = PED
        L3_2 = L3_2.IS_PED_IN_VEHICLE
        L4_2 = PLAYER
        L4_2 = L4_2.PLAYER_PED_ID
        L4_2 = L4_2()
        L5_2 = L2_2
        L6_2 = false
        L3_2 = L3_2(L4_2, L5_2, L6_2)
        if L3_2 then
          L3_2 = PED
          L3_2 = L3_2.SET_PED_INTO_VEHICLE
          L4_2 = PLAYER
          L4_2 = L4_2.PLAYER_PED_ID
          L4_2 = L4_2()
          L5_2 = L2_2
          L6_2 = -1
          L3_2(L4_2, L5_2, L6_2)
        end
      end
    end
  end
  while true do
    L3_2 = Auto_drived
    if not L3_2 then
      break
    end
    L3_2 = ENTITY
    L3_2 = L3_2.GET_ENTITY_HEIGHT_ABOVE_GROUND
    L4_2 = L2_2
    L3_2 = L3_2(L4_2)
    L4_2 = ENTITY
    L4_2 = L4_2.GET_ENTITY_UPRIGHT_VALUE
    L5_2 = L2_2
    L4_2 = L4_2(L5_2)
    if L3_2 < 5.0 and L4_2 < 0.0 then
      L5_2 = VEHICLE
      L5_2 = L5_2.SET_VEHICLE_ON_GROUND_PROPERLY
      L6_2 = L2_2
      L5_2(L6_2)
    end
    L5_2 = util
    L5_2 = L5_2.yield
    L5_2()
  end
end
Auto_driving = L25_1
function L25_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = L1_2
  L4_2 = false
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = util
  L3_2 = L3_2.joaat
  L4_2 = "u_m_y_baygor"
  L3_2 = L3_2(L4_2)
  L4_2 = util
  L4_2 = L4_2.joaat
  L5_2 = "raiden"
  L4_2 = L4_2(L5_2)
  L5_2 = request_model
  L6_2 = L3_2
  L5_2(L6_2)
  L5_2 = request_model
  L6_2 = L4_2
  L5_2(L6_2)
  if A0_2 then
    L5_2 = PED
    L5_2 = L5_2.IS_PED_IN_ANY_VEHICLE
    L6_2 = L1_2
    L7_2 = true
    L5_2 = L5_2(L6_2, L7_2)
    if L5_2 then
      L5_2 = PED
      L5_2 = L5_2.GET_VEHICLE_PED_IS_IN
      L6_2 = L1_2
      L7_2 = false
      L5_2 = L5_2(L6_2, L7_2)
      L6_2 = delete_entity
      L7_2 = L5_2
      L6_2(L7_2)
    end
    L5_2 = entities
    L5_2 = L5_2.create_ped
    L6_2 = 26
    L7_2 = L3_2
    L8_2 = L2_2
    L9_2 = 0
    L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
    tesla_ai_ped = L5_2
    L5_2 = entities
    L5_2 = L5_2.create_vehicle
    L6_2 = L4_2
    L7_2 = L2_2
    L8_2 = 0
    L5_2 = L5_2(L6_2, L7_2, L8_2)
    tesla_vehicle = L5_2
    L5_2 = ENTITY
    L5_2 = L5_2.SET_ENTITY_INVINCIBLE
    L6_2 = tesla_ai_ped
    L7_2 = true
    L5_2(L6_2, L7_2)
    L5_2 = ENTITY
    L5_2 = L5_2.SET_ENTITY_VISIBLE
    L6_2 = tesla_ai_ped
    L7_2 = false
    L5_2(L6_2, L7_2)
    L5_2 = PED
    L5_2 = L5_2.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS
    L6_2 = tesla_ai_ped
    L7_2 = true
    L5_2(L6_2, L7_2)
    L5_2 = PED
    L5_2 = L5_2.SET_PED_INTO_VEHICLE
    L6_2 = L1_2
    L7_2 = tesla_vehicle
    L8_2 = -2
    L5_2(L6_2, L7_2, L8_2)
    L5_2 = PED
    L5_2 = L5_2.SET_PED_INTO_VEHICLE
    L6_2 = tesla_ai_ped
    L7_2 = tesla_vehicle
    L8_2 = -1
    L5_2(L6_2, L7_2, L8_2)
    L5_2 = PED
    L5_2 = L5_2.SET_PED_KEEP_TASK
    L6_2 = tesla_ai_ped
    L7_2 = true
    L5_2(L6_2, L7_2)
    L5_2 = VEHICLE
    L5_2 = L5_2.SET_VEHICLE_COLOURS
    L6_2 = tesla_vehicle
    L7_2 = 111
    L8_2 = 111
    L5_2(L6_2, L7_2, L8_2)
    L5_2 = VEHICLE
    L5_2 = L5_2.SET_VEHICLE_MOD
    L6_2 = tesla_vehicle
    L7_2 = 23
    L8_2 = 8
    L9_2 = false
    L5_2(L6_2, L7_2, L8_2, L9_2)
    L5_2 = VEHICLE
    L5_2 = L5_2.SET_VEHICLE_MOD
    L6_2 = tesla_vehicle
    L7_2 = 15
    L8_2 = 1
    L9_2 = false
    L5_2(L6_2, L7_2, L8_2, L9_2)
    L5_2 = VEHICLE
    L5_2 = L5_2.SET_VEHICLE_EXTRA_COLOURS
    L6_2 = tesla_vehicle
    L7_2 = 111
    L8_2 = 147
    L5_2(L6_2, L7_2, L8_2)
    L5_2 = HUD
    L5_2 = L5_2.IS_WAYPOINT_ACTIVE
    L5_2 = L5_2()
    if L5_2 then
      L5_2 = HUD
      L5_2 = L5_2.GET_BLIP_COORDS
      L6_2 = HUD
      L6_2 = L6_2.GET_FIRST_BLIP_INFO_ID
      L7_2 = 8
      L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2 = L6_2(L7_2)
      L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
      L6_2 = TASK
      L6_2 = L6_2.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE
      L7_2 = tesla_ai_ped
      L8_2 = tesla_vehicle
      L9_2 = L5_2.x
      L10_2 = L5_2.y
      L11_2 = L5_2.z
      L12_2 = 20
      L13_2 = 786603
      L14_2 = 0
      L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    else
      L5_2 = TASK
      L5_2 = L5_2.TASK_VEHICLE_DRIVE_WANDER
      L6_2 = tesla_ai_ped
      L7_2 = tesla_vehicle
      L8_2 = 20
      L9_2 = 786603
      L5_2(L6_2, L7_2, L8_2, L9_2)
    end
  else
    L5_2 = tesla_ai_ped
    if nil ~= L5_2 then
      L5_2 = delete_entity
      L6_2 = tesla_ai_ped
      L5_2(L6_2)
    end
    L5_2 = tesla_vehicle
    if nil ~= L5_2 then
      L5_2 = delete_entity
      L6_2 = tesla_vehicle
      L5_2(L6_2)
    end
  end
end
Tesla_Autopilot = L25_1
L25_1 = 1
function L26_1(A0_2)
  local L1_2
  L25_1 = A0_2
end
selectedOptt = L26_1
function L26_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2
  L0_2 = veffects
  L1_2 = L25_1
  L0_2 = L0_2[L1_2]
  L1_2 = PED
  L1_2 = L1_2.GET_VEHICLE_PED_IS_IN
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = false
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = ENTITY
  L2_2 = L2_2.DOES_ENTITY_EXIST
  L3_2 = L1_2
  L2_2 = L2_2(L3_2)
  if L2_2 then
    L2_2 = ENTITY
    L2_2 = L2_2.IS_ENTITY_DEAD
    L3_2 = L1_2
    L4_2 = false
    L2_2 = L2_2(L3_2, L4_2)
    if not L2_2 then
      L2_2 = VEHICLE
      L2_2 = L2_2.IS_VEHICLE_DRIVEABLE
      L3_2 = L1_2
      L4_2 = false
      L2_2 = L2_2(L3_2, L4_2)
      if L2_2 then
        L2_2 = timer
        L2_2 = L2_2.elapsed
        L2_2 = L2_2()
        L3_2 = L0_2[4]
        if L2_2 > L3_2 then
          L2_2 = request_ptfx_asset
          L3_2 = L0_2[1]
          L2_2(L3_2)
          L2_2 = pairs
          L3_2 = {}
          L4_2 = "wheel_lf"
          L5_2 = "wheel_lr"
          L6_2 = "wheel_rf"
          L7_2 = "wheel_rr"
          L3_2[1] = L4_2
          L3_2[2] = L5_2
          L3_2[3] = L6_2
          L3_2[4] = L7_2
          L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
          for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
            L8_2 = ENTITY
            L8_2 = L8_2.GET_ENTITY_BONE_INDEX_BY_NAME
            L9_2 = L1_2
            L10_2 = L7_2
            L8_2 = L8_2(L9_2, L10_2)
            L9_2 = GRAPHICS
            L9_2 = L9_2.USE_PARTICLE_FX_ASSET
            L10_2 = L0_2[1]
            L9_2(L10_2)
            L9_2 = GRAPHICS
            L10_2 = "START_PARTICLE_FX_NON_LOOPED_ON_ENTITY_BONE"
            L9_2 = L9_2[L10_2]
            L10_2 = L0_2[2]
            L11_2 = L1_2
            L12_2 = 0.0
            L13_2 = 0.0
            L14_2 = 0.0
            L15_2 = 0.0
            L16_2 = 0.0
            L17_2 = 0.0
            L18_2 = L8_2
            L19_2 = L0_2[3]
            L20_2 = false
            L21_2 = false
            L22_2 = false
            L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
          end
          L2_2 = timer
          L2_2 = L2_2.reset
          L2_2()
        end
      end
    end
  end
end
vehicle_effectt = L26_1
function L26_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2
  L4_2 = get_player_vehicle_in_control
  L5_2 = A0_2
  L6_2 = A3_2
  L4_2 = L4_2(L5_2, L6_2)
  if 0 ~= L4_2 then
    L5_2 = A2_2
    L6_2 = L4_2
    L5_2(L6_2)
    L5_2 = true
    return L5_2
  else
    if A1_2 then
      L5_2 = util
      L5_2 = L5_2.toast
      L6_2 = "玩家不在车内"
      L5_2(L6_2)
    end
    L5_2 = false
    return L5_2
  end
end
control_vehicle1 = L26_1
function L26_1()
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
    L1_2 = request_ptfx_asset
    L2_2 = "scr_xm_orbital"
    L1_2(L2_2)
    L1_2 = GRAPHICS
    L1_2 = L1_2.USE_PARTICLE_FX_ASSET
    L2_2 = "scr_xm_orbital"
    L1_2(L2_2)
    L1_2 = FIRE
    L1_2 = L1_2.ADD_EXPLOSION
    L2_2 = L0_2.x
    L3_2 = L0_2.y
    L4_2 = L0_2.z
    L5_2 = 59
    L6_2 = 1
    L7_2 = true
    L8_2 = false
    L9_2 = 1.0
    L10_2 = false
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
    L1_2 = GRAPHICS
    L2_2 = "START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD"
    L1_2 = L1_2[L2_2]
    L2_2 = "scr_xm_orbital_blast"
    L3_2 = L0_2.x
    L4_2 = L0_2.y
    L5_2 = L0_2.z
    L6_2 = 0
    L7_2 = 180
    L8_2 = 0
    L9_2 = 1.0
    L10_2 = true
    L11_2 = true
    L12_2 = true
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
    L1_2 = 1
    L2_2 = 4
    L3_2 = 1
    for L4_2 = L1_2, L2_2, L3_2 do
      L5_2 = AUDIO
      L5_2 = L5_2.PLAY_SOUND_FROM_ENTITY
      L6_2 = -1
      L7_2 = "DLC_XM_Explosions_Orbital_Cannon"
      L8_2 = PLAYER
      L8_2 = L8_2.PLAYER_PED_ID
      L8_2 = L8_2()
      L9_2 = 0
      L10_2 = true
      L11_2 = 0
      L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    end
  end
end
nuclear_weapon1 = L26_1
function L26_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = math
  L2_2 = L2_2.type
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if "integer" == L2_2 then
    L2_2 = ENTITY
    L2_2 = L2_2.GET_ENTITY_COORDS
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    A0_2 = L2_2
  end
  L2_2 = math
  L2_2 = L2_2.type
  L3_2 = A1_2
  L2_2 = L2_2(L3_2)
  if "integer" == L2_2 then
    L2_2 = ENTITY
    L2_2 = L2_2.GET_ENTITY_COORDS
    L3_2 = A1_2
    L2_2 = L2_2(L3_2)
    A1_2 = L2_2
  end
  L3_2 = A0_2
  L2_2 = A0_2.distance
  L4_2 = A1_2
  return L2_2(L3_2, L4_2)
end
get_distance_between = L26_1
function L26_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2, L38_2, L39_2, L40_2
  L1_2 = {}
  L2_2 = {}
  L3_2 = 10
  L4_2 = 0
  L5_2 = 0
  L2_2[1] = L3_2
  L2_2[2] = L4_2
  L2_2[3] = L5_2
  L3_2 = {}
  L4_2 = 0
  L5_2 = 10
  L6_2 = 0
  L3_2[1] = L4_2
  L3_2[2] = L5_2
  L3_2[3] = L6_2
  L4_2 = {}
  L5_2 = 10
  L6_2 = 10
  L7_2 = 0
  L4_2[1] = L5_2
  L4_2[2] = L6_2
  L4_2[3] = L7_2
  L5_2 = {}
  L6_2 = -10
  L7_2 = 0
  L8_2 = 0
  L5_2[1] = L6_2
  L5_2[2] = L7_2
  L5_2[3] = L8_2
  L6_2 = {}
  L7_2 = 0
  L8_2 = -10
  L9_2 = 0
  L6_2[1] = L7_2
  L6_2[2] = L8_2
  L6_2[3] = L9_2
  L7_2 = {}
  L8_2 = -10
  L9_2 = -10
  L10_2 = 0
  L7_2[1] = L8_2
  L7_2[2] = L9_2
  L7_2[3] = L10_2
  L8_2 = {}
  L9_2 = 10
  L10_2 = -10
  L11_2 = 0
  L8_2[1] = L9_2
  L8_2[2] = L10_2
  L8_2[3] = L11_2
  L9_2 = {}
  L10_2 = -10
  L11_2 = 10
  L12_2 = 0
  L9_2[1] = L10_2
  L9_2[2] = L11_2
  L9_2[3] = L12_2
  L10_2 = {}
  L11_2 = 20
  L12_2 = 0
  L13_2 = 0
  L10_2[1] = L11_2
  L10_2[2] = L12_2
  L10_2[3] = L13_2
  L11_2 = {}
  L12_2 = 0
  L13_2 = 20
  L14_2 = 0
  L11_2[1] = L12_2
  L11_2[2] = L13_2
  L11_2[3] = L14_2
  L12_2 = {}
  L13_2 = 20
  L14_2 = 20
  L15_2 = 0
  L12_2[1] = L13_2
  L12_2[2] = L14_2
  L12_2[3] = L15_2
  L13_2 = {}
  L14_2 = -20
  L15_2 = 0
  L16_2 = 0
  L13_2[1] = L14_2
  L13_2[2] = L15_2
  L13_2[3] = L16_2
  L14_2 = {}
  L15_2 = 0
  L16_2 = -20
  L17_2 = 0
  L14_2[1] = L15_2
  L14_2[2] = L16_2
  L14_2[3] = L17_2
  L15_2 = {}
  L16_2 = -20
  L17_2 = -20
  L18_2 = 0
  L15_2[1] = L16_2
  L15_2[2] = L17_2
  L15_2[3] = L18_2
  L16_2 = {}
  L17_2 = 20
  L18_2 = -20
  L19_2 = 0
  L16_2[1] = L17_2
  L16_2[2] = L18_2
  L16_2[3] = L19_2
  L17_2 = {}
  L18_2 = -20
  L19_2 = 10
  L20_2 = 0
  L17_2[1] = L18_2
  L17_2[2] = L19_2
  L17_2[3] = L20_2
  L18_2 = {}
  L19_2 = 30
  L20_2 = 0
  L21_2 = 0
  L18_2[1] = L19_2
  L18_2[2] = L20_2
  L18_2[3] = L21_2
  L19_2 = {}
  L20_2 = 0
  L21_2 = 30
  L22_2 = 0
  L19_2[1] = L20_2
  L19_2[2] = L21_2
  L19_2[3] = L22_2
  L20_2 = {}
  L21_2 = 30
  L22_2 = 30
  L23_2 = 0
  L20_2[1] = L21_2
  L20_2[2] = L22_2
  L20_2[3] = L23_2
  L21_2 = {}
  L22_2 = -30
  L23_2 = 0
  L24_2 = 0
  L21_2[1] = L22_2
  L21_2[2] = L23_2
  L21_2[3] = L24_2
  L22_2 = {}
  L23_2 = 0
  L24_2 = -30
  L25_2 = 0
  L22_2[1] = L23_2
  L22_2[2] = L24_2
  L22_2[3] = L25_2
  L23_2 = {}
  L24_2 = -30
  L25_2 = -30
  L26_2 = 0
  L23_2[1] = L24_2
  L23_2[2] = L25_2
  L23_2[3] = L26_2
  L24_2 = {}
  L25_2 = 30
  L26_2 = -30
  L27_2 = 0
  L24_2[1] = L25_2
  L24_2[2] = L26_2
  L24_2[3] = L27_2
  L25_2 = {}
  L26_2 = -30
  L27_2 = 10
  L28_2 = 0
  L25_2[1] = L26_2
  L25_2[2] = L27_2
  L25_2[3] = L28_2
  L26_2 = {}
  L27_2 = 10
  L28_2 = 30
  L29_2 = 0
  L26_2[1] = L27_2
  L26_2[2] = L28_2
  L26_2[3] = L29_2
  L27_2 = {}
  L28_2 = 30
  L29_2 = 10
  L30_2 = 0
  L27_2[1] = L28_2
  L27_2[2] = L29_2
  L27_2[3] = L30_2
  L28_2 = {}
  L29_2 = -30
  L30_2 = -10
  L31_2 = 0
  L28_2[1] = L29_2
  L28_2[2] = L30_2
  L28_2[3] = L31_2
  L29_2 = {}
  L30_2 = -10
  L31_2 = -30
  L32_2 = 0
  L29_2[1] = L30_2
  L29_2[2] = L31_2
  L29_2[3] = L32_2
  L30_2 = {}
  L31_2 = -10
  L32_2 = 30
  L33_2 = 0
  L30_2[1] = L31_2
  L30_2[2] = L32_2
  L30_2[3] = L33_2
  L31_2 = {}
  L32_2 = -30
  L33_2 = 10
  L34_2 = 0
  L31_2[1] = L32_2
  L31_2[2] = L33_2
  L31_2[3] = L34_2
  L32_2 = {}
  L33_2 = 30
  L34_2 = -10
  L35_2 = 0
  L32_2[1] = L33_2
  L32_2[2] = L34_2
  L32_2[3] = L35_2
  L33_2 = {}
  L34_2 = 10
  L35_2 = -30
  L36_2 = 0
  L33_2[1] = L34_2
  L33_2[2] = L35_2
  L33_2[3] = L36_2
  L34_2 = {}
  L35_2 = 0
  L36_2 = 0
  L37_2 = 10
  L34_2[1] = L35_2
  L34_2[2] = L36_2
  L34_2[3] = L37_2
  L35_2 = {}
  L36_2 = 0
  L37_2 = 0
  L38_2 = -10
  L35_2[1] = L36_2
  L35_2[2] = L37_2
  L35_2[3] = L38_2
  L36_2 = {}
  L37_2 = 0
  L38_2 = 0
  L39_2 = 20
  L36_2[1] = L37_2
  L36_2[2] = L38_2
  L36_2[3] = L39_2
  L37_2 = {}
  L38_2 = 0
  L39_2 = 0
  L40_2 = -20
  L37_2[1] = L38_2
  L37_2[2] = L39_2
  L37_2[3] = L40_2
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
  L1_2[27] = L28_2
  L1_2[28] = L29_2
  L1_2[29] = L30_2
  L1_2[30] = L31_2
  L1_2[31] = L32_2
  L1_2[32] = L33_2
  L1_2[33] = L34_2
  L1_2[34] = L35_2
  L1_2[35] = L36_2
  L1_2[36] = L37_2
  L2_2 = ipairs
  L3_2 = L1_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = FIRE
    L8_2 = L8_2.ADD_EXPLOSION
    L9_2 = A0_2.x
    L10_2 = L7_2[1]
    L9_2 = L9_2 + L10_2
    L10_2 = A0_2.y
    L11_2 = L7_2[2]
    L10_2 = L10_2 + L11_2
    L11_2 = A0_2.z
    L12_2 = L7_2[3]
    L11_2 = L11_2 + L12_2
    L12_2 = 59
    L13_2 = 1.0
    L14_2 = true
    L15_2 = false
    L16_2 = 1.0
    L17_2 = false
    L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  end
end
nuke_expl1 = L26_1
function L26_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L1_2 = {}
  L2_2 = {}
  L3_2 = 0
  L4_2 = 0
  L5_2 = -10
  L2_2[1] = L3_2
  L2_2[2] = L4_2
  L2_2[3] = L5_2
  L3_2 = {}
  L4_2 = 10
  L5_2 = 0
  L6_2 = -10
  L3_2[1] = L4_2
  L3_2[2] = L5_2
  L3_2[3] = L6_2
  L4_2 = {}
  L5_2 = 0
  L6_2 = 10
  L7_2 = -10
  L4_2[1] = L5_2
  L4_2[2] = L6_2
  L4_2[3] = L7_2
  L5_2 = {}
  L6_2 = 10
  L7_2 = 10
  L8_2 = -10
  L5_2[1] = L6_2
  L5_2[2] = L7_2
  L5_2[3] = L8_2
  L6_2 = {}
  L7_2 = -10
  L8_2 = 0
  L9_2 = -10
  L6_2[1] = L7_2
  L6_2[2] = L8_2
  L6_2[3] = L9_2
  L7_2 = {}
  L8_2 = 0
  L9_2 = -10
  L10_2 = -10
  L7_2[1] = L8_2
  L7_2[2] = L9_2
  L7_2[3] = L10_2
  L8_2 = {}
  L9_2 = -10
  L10_2 = -10
  L11_2 = -10
  L8_2[1] = L9_2
  L8_2[2] = L10_2
  L8_2[3] = L11_2
  L9_2 = {}
  L10_2 = 10
  L11_2 = -10
  L12_2 = -10
  L9_2[1] = L10_2
  L9_2[2] = L11_2
  L9_2[3] = L12_2
  L10_2 = {}
  L11_2 = -10
  L12_2 = 10
  L13_2 = -10
  L10_2[1] = L11_2
  L10_2[2] = L12_2
  L10_2[3] = L13_2
  L1_2[1] = L2_2
  L1_2[2] = L3_2
  L1_2[3] = L4_2
  L1_2[4] = L5_2
  L1_2[5] = L6_2
  L1_2[6] = L7_2
  L1_2[7] = L8_2
  L1_2[8] = L9_2
  L1_2[9] = L10_2
  L2_2 = ipairs
  L3_2 = L1_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = FIRE
    L8_2 = L8_2.ADD_EXPLOSION
    L9_2 = A0_2.x
    L10_2 = L7_2[1]
    L9_2 = L9_2 + L10_2
    L10_2 = A0_2.y
    L11_2 = L7_2[2]
    L10_2 = L10_2 + L11_2
    L11_2 = A0_2.z
    L12_2 = L7_2[3]
    L11_2 = L11_2 + L12_2
    L12_2 = 59
    L13_2 = 1.0
    L14_2 = true
    L15_2 = false
    L16_2 = 1.0
    L17_2 = false
    L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  end
end
nuke_expl2 = L26_1
function L26_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L1_2 = {}
  L2_2 = {}
  L3_2 = 10
  L4_2 = 0
  L5_2 = 0
  L2_2[1] = L3_2
  L2_2[2] = L4_2
  L2_2[3] = L5_2
  L3_2 = {}
  L4_2 = 0
  L5_2 = 10
  L6_2 = 0
  L3_2[1] = L4_2
  L3_2[2] = L5_2
  L3_2[3] = L6_2
  L4_2 = {}
  L5_2 = 10
  L6_2 = 10
  L7_2 = 0
  L4_2[1] = L5_2
  L4_2[2] = L6_2
  L4_2[3] = L7_2
  L5_2 = {}
  L6_2 = -10
  L7_2 = 0
  L8_2 = 0
  L5_2[1] = L6_2
  L5_2[2] = L7_2
  L5_2[3] = L8_2
  L6_2 = {}
  L7_2 = 0
  L8_2 = -10
  L9_2 = 0
  L6_2[1] = L7_2
  L6_2[2] = L8_2
  L6_2[3] = L9_2
  L7_2 = {}
  L8_2 = -10
  L9_2 = -10
  L10_2 = 0
  L7_2[1] = L8_2
  L7_2[2] = L9_2
  L7_2[3] = L10_2
  L8_2 = {}
  L9_2 = 10
  L10_2 = -10
  L11_2 = 0
  L8_2[1] = L9_2
  L8_2[2] = L10_2
  L8_2[3] = L11_2
  L9_2 = {}
  L10_2 = -10
  L11_2 = 10
  L12_2 = 0
  L9_2[1] = L10_2
  L9_2[2] = L11_2
  L9_2[3] = L12_2
  L10_2 = {}
  L11_2 = 0
  L12_2 = 0
  L13_2 = 0
  L10_2[1] = L11_2
  L10_2[2] = L12_2
  L10_2[3] = L13_2
  L1_2[1] = L2_2
  L1_2[2] = L3_2
  L1_2[3] = L4_2
  L1_2[4] = L5_2
  L1_2[5] = L6_2
  L1_2[6] = L7_2
  L1_2[7] = L8_2
  L1_2[8] = L9_2
  L1_2[9] = L10_2
  L2_2 = ipairs
  L3_2 = L1_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = FIRE
    L8_2 = L8_2.ADD_EXPLOSION
    L9_2 = A0_2.x
    L10_2 = L7_2[1]
    L9_2 = L9_2 + L10_2
    L10_2 = A0_2.y
    L11_2 = L7_2[2]
    L10_2 = L10_2 + L11_2
    L11_2 = A0_2.z
    L12_2 = L7_2[3]
    L11_2 = L11_2 + L12_2
    L12_2 = 59
    L13_2 = 1.0
    L14_2 = true
    L15_2 = false
    L16_2 = 1.0
    L17_2 = false
    L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  end
end
nuke_expl3 = L26_1
function L26_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2
  L1_2 = 1
  L2_2 = 17
  L3_2 = 1
  for L4_2 = L1_2, L2_2, L3_2 do
    if 1 == L4_2 then
      L5_2 = FIRE
      L5_2 = L5_2.ADD_EXPLOSION
      L6_2 = A0_2.x
      L7_2 = A0_2.y
      L8_2 = A0_2.z
      L9_2 = 59
      L10_2 = 1
      L11_2 = true
      L12_2 = false
      L13_2 = 5.0
      L14_2 = false
      L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    elseif 2 == L4_2 then
      L5_2 = FIRE
      L5_2 = L5_2.ADD_EXPLOSION
      L6_2 = A0_2.x
      L7_2 = A0_2.y
      L8_2 = A0_2.z
      L9_2 = 59
      L10_2 = 1
      L11_2 = true
      L12_2 = false
      L13_2 = 1.0
      L14_2 = false
      L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    end
    L5_2 = request_ptfx_asset
    L6_2 = "scr_xm_orbital"
    L5_2(L6_2)
    L5_2 = GRAPHICS
    L5_2 = L5_2.USE_PARTICLE_FX_ASSET
    L6_2 = "scr_xm_orbital"
    L5_2(L6_2)
    L5_2 = GRAPHICS
    L6_2 = "START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD"
    L5_2 = L5_2[L6_2]
    L6_2 = "scr_xm_orbital_blast"
    L7_2 = A0_2.x
    L8_2 = A0_2.y
    L9_2 = A0_2.z
    L10_2 = 0
    L11_2 = 180
    L12_2 = 0
    L13_2 = 4.5
    L14_2 = true
    L15_2 = true
    L16_2 = true
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  end
  L1_2 = nuke_expl1
  L2_2 = A0_2
  L1_2(L2_2)
  L1_2 = 1
  L2_2 = 4
  L3_2 = 1
  for L4_2 = L1_2, L2_2, L3_2 do
    L5_2 = AUDIO
    L5_2 = L5_2.PLAY_SOUND_FROM_ENTITY
    L6_2 = -1
    L7_2 = "DLC_XM_Explosions_Orbital_Cannon"
    L8_2 = PLAYER
    L8_2 = L8_2.PLAYER_PED_ID
    L8_2 = L8_2()
    L9_2 = 0
    L10_2 = true
    L11_2 = 0
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  end
  L1_2 = 1
  L2_2 = 2
  L3_2 = 1
  for L4_2 = L1_2, L2_2, L3_2 do
    if 1 == L4_2 then
      L5_2 = FIRE
      L5_2 = L5_2.ADD_EXPLOSION
      L6_2 = A0_2.x
      L7_2 = A0_2.y
      L8_2 = A0_2.z
      L8_2 = L8_2 - 10
      L9_2 = 59
      L10_2 = 1
      L11_2 = true
      L12_2 = false
      L13_2 = 5.0
      L14_2 = false
      L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    end
    L5_2 = request_ptfx_asset
    L6_2 = "scr_xm_orbital"
    L5_2(L6_2)
    L5_2 = GRAPHICS
    L5_2 = L5_2.USE_PARTICLE_FX_ASSET
    L6_2 = "scr_xm_orbital"
    L5_2(L6_2)
    L5_2 = GRAPHICS
    L6_2 = "START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD"
    L5_2 = L5_2[L6_2]
    L6_2 = "scr_xm_orbital_blast"
    L7_2 = A0_2.x
    L8_2 = A0_2.y
    L9_2 = A0_2.z
    L9_2 = L9_2 - 10
    L10_2 = 0
    L11_2 = 180
    L12_2 = 0
    L13_2 = 4.5
    L14_2 = true
    L15_2 = true
    L16_2 = true
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  end
  L1_2 = nuke_expl2
  L2_2 = A0_2
  L1_2(L2_2)
  L1_2 = 1.5
  L2_2 = {}
  L3_2 = 1
  L4_2 = 3
  L5_2 = 5
  L6_2 = 7
  L7_2 = 10
  L8_2 = 12
  L9_2 = 15
  L10_2 = 17
  L11_2 = 20
  L12_2 = 22
  L13_2 = 25
  L14_2 = 27
  L15_2 = 30
  L16_2 = 32
  L17_2 = 35
  L18_2 = 37
  L19_2 = 40
  L20_2 = 42
  L21_2 = 45
  L22_2 = 47
  L23_2 = 50
  L24_2 = 52
  L25_2 = 55
  L26_2 = 57
  L27_2 = 59
  L28_2 = 61
  L29_2 = 63
  L30_2 = 65
  L31_2 = 70
  L32_2 = 75
  L33_2 = 75
  L34_2 = 75
  L35_2 = 75
  L36_2 = 80
  L37_2 = 80
  L2_2[1] = L3_2
  L2_2[2] = L4_2
  L2_2[3] = L5_2
  L2_2[4] = L6_2
  L2_2[5] = L7_2
  L2_2[6] = L8_2
  L2_2[7] = L9_2
  L2_2[8] = L10_2
  L2_2[9] = L11_2
  L2_2[10] = L12_2
  L2_2[11] = L13_2
  L2_2[12] = L14_2
  L2_2[13] = L15_2
  L2_2[14] = L16_2
  L2_2[15] = L17_2
  L2_2[16] = L18_2
  L2_2[17] = L19_2
  L2_2[18] = L20_2
  L2_2[19] = L21_2
  L2_2[20] = L22_2
  L2_2[21] = L23_2
  L2_2[22] = L24_2
  L2_2[23] = L25_2
  L2_2[24] = L26_2
  L2_2[25] = L27_2
  L2_2[26] = L28_2
  L2_2[27] = L29_2
  L2_2[28] = L30_2
  L2_2[29] = L31_2
  L2_2[30] = L32_2
  L2_2[31] = L33_2
  L2_2[32] = L34_2
  L2_2[33] = L35_2
  L2_2[34] = L36_2
  L2_2[35] = L37_2
  L3_2 = ipairs
  L4_2 = L2_2
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    if 3 == L7_2 or 5 == L7_2 or 7 == L7_2 or 9 == L7_2 or 11 == L7_2 or 13 == L7_2 or 15 == L7_2 or 17 == L7_2 or 19 == L7_2 or 21 == L7_2 or 23 == L7_2 or 25 == L7_2 or 29 == L7_2 or 30 == L7_2 then
      L9_2 = FIRE
      L9_2 = L9_2.ADD_EXPLOSION
      L10_2 = A0_2.x
      L11_2 = A0_2.y
      L12_2 = A0_2.z
      L12_2 = L12_2 + L8_2
      L13_2 = 59
      L14_2 = 1.0
      L15_2 = true
      L16_2 = false
      L17_2 = 1.0
      L18_2 = false
      L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    end
    L9_2 = request_ptfx_asset
    L10_2 = "scr_xm_orbital"
    L9_2(L10_2)
    L9_2 = GRAPHICS
    L9_2 = L9_2.USE_PARTICLE_FX_ASSET
    L10_2 = "scr_xm_orbital"
    L9_2(L10_2)
    L9_2 = GRAPHICS
    L10_2 = "START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD"
    L9_2 = L9_2[L10_2]
    L10_2 = "scr_xm_orbital_blast"
    L11_2 = A0_2.x
    L12_2 = A0_2.y
    L13_2 = A0_2.z
    L13_2 = L13_2 + L8_2
    L14_2 = 0
    L15_2 = 180
    L16_2 = 0
    L17_2 = L1_2
    L18_2 = true
    L19_2 = true
    L20_2 = true
    L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
    if L7_2 >= 30 and L7_2 <= 33 then
      L1_2 = 3.5
    elseif L7_2 >= 34 and L7_2 <= 35 then
      L1_2 = 3.0
    else
      L1_2 = 1.5
    end
    L9_2 = util
    L9_2 = L9_2.yield
    L10_2 = 10
    L9_2(L10_2)
  end
  L3_2 = nuke_expl3
  L4_2 = A0_2
  L3_2(L4_2)
  L3_2 = pairs
  L4_2 = players
  L4_2 = L4_2.list
  L5_2 = false
  L6_2 = true
  L7_2 = true
  L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2 = L4_2(L5_2, L6_2, L7_2)
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2, L37_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = get_distance_between
    L10_2 = players
    L10_2 = L10_2.get_position
    L11_2 = L8_2
    L10_2 = L10_2(L11_2)
    L11_2 = A0_2
    L9_2 = L9_2(L10_2, L11_2)
    L10_2 = 200
    if L9_2 < L10_2 then
      L10_2 = players
      L10_2 = L10_2.get_position
      L11_2 = L8_2
      L10_2 = L10_2(L11_2)
      L11_2 = FIRE
      L11_2 = L11_2.ADD_EXPLOSION
      L12_2 = L10_2.x
      L13_2 = L10_2.y
      L14_2 = L10_2.z
      L15_2 = 59
      L16_2 = 1.0
      L17_2 = true
      L18_2 = false
      L19_2 = 1.0
      L20_2 = false
      L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
    end
  end
  L3_2 = entities
  L3_2 = L3_2.get_all_peds_as_handles
  L3_2 = L3_2()
  L4_2 = pairs
  L5_2 = L3_2
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
    L10_2 = get_distance_between
    L11_2 = L9_2
    L12_2 = A0_2
    L10_2 = L10_2(L11_2, L12_2)
    L11_2 = 200
    if L10_2 > L11_2 then
      L10_2 = get_distance_between
      L11_2 = L9_2
      L12_2 = A0_2
      L10_2 = L10_2(L11_2, L12_2)
      L11_2 = 400
      if L10_2 < L11_2 then
        L10_2 = PLAYER
        L10_2 = L10_2.PLAYER_PED_ID
        L10_2 = L10_2()
        if L9_2 ~= L10_2 then
          L10_2 = ENTITY
          L10_2 = L10_2.GET_ENTITY_COORDS
          L11_2 = L9_2
          L10_2 = L10_2(L11_2)
          L11_2 = FIRE
          L11_2 = L11_2.ADD_EXPLOSION
          L12_2 = L10_2.x
          L13_2 = L10_2.y
          L14_2 = L10_2.z
          L15_2 = 3
          L16_2 = 1.0
          L17_2 = true
          L18_2 = true
          L19_2 = 0.1
          L20_2 = false
          L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
        end
      end
    end
  end
  L4_2 = entities
  L4_2 = L4_2.get_all_vehicles_as_handles
  L4_2 = L4_2()
  L5_2 = pairs
  L6_2 = L4_2
  L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
  for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
    L11_2 = get_distance_between
    L12_2 = L10_2
    L13_2 = A0_2
    L11_2 = L11_2(L12_2, L13_2)
    L12_2 = 400
    if L11_2 < L12_2 then
      L11_2 = VEHICLE
      L11_2 = L11_2.EXPLODE_VEHICLE
      L12_2 = L10_2
      L13_2 = true
      L14_2 = false
      L11_2(L12_2, L13_2, L14_2)
    else
      L11_2 = get_distance_between
      L12_2 = L10_2
      L13_2 = A0_2
      L11_2 = L11_2(L12_2, L13_2)
      L12_2 = 200
      if L11_2 > L12_2 then
        L11_2 = get_distance_between
        L12_2 = L10_2
        L13_2 = A0_2
        L11_2 = L11_2(L12_2, L13_2)
        L12_2 = 400
        if L11_2 < L12_2 then
          L11_2 = VEHICLE
          L11_2 = L11_2.EXPLODE_VEHICLE
          L12_2 = L10_2
          L13_2 = true
          L14_2 = false
          L11_2(L12_2, L13_2, L14_2)
        end
      end
    end
  end
end
create_nuke_explosion = L26_1
function L26_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  L0_2 = PED
  L0_2 = L0_2.IS_PED_SHOOTING
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
  if L0_2 then
    L0_2 = util
    L0_2 = L0_2.joaat
    L1_2 = "prop_military_pickup_01"
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
    L4_2 = 5.0
    L5_2 = 3.0
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2)
    L2_2 = {}
    L3_2 = {}
    L4_2 = get_offset_from_gameplay_camera
    L5_2 = 1000
    L4_2 = L4_2(L5_2)
    L3_2 = L4_2
    L4_2 = L3_2.x
    L5_2 = L1_2.x
    L4_2 = L4_2 - L5_2
    L4_2 = L4_2 * 1000
    L2_2.x = L4_2
    L4_2 = L3_2.y
    L5_2 = L1_2.y
    L4_2 = L4_2 - L5_2
    L4_2 = L4_2 * 1000
    L2_2.y = L4_2
    L4_2 = L3_2.z
    L5_2 = L1_2.z
    L4_2 = L4_2 - L5_2
    L4_2 = L4_2 * 1000
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
    L5_2 = ENTITY
    L5_2 = L5_2.SET_ENTITY_NO_COLLISION_ENTITY
    L6_2 = L4_2
    L7_2 = PLAYER
    L7_2 = L7_2.PLAYER_PED_ID
    L7_2 = L7_2()
    L8_2 = false
    L5_2(L6_2, L7_2, L8_2)
    L5_2 = ENTITY
    L5_2 = L5_2.APPLY_FORCE_TO_ENTITY
    L6_2 = L4_2
    L7_2 = 0
    L8_2 = L2_2.x
    L9_2 = L2_2.y
    L10_2 = L2_2.z
    L11_2 = 0.0
    L12_2 = 0.0
    L13_2 = 0.0
    L14_2 = 0
    L15_2 = true
    L16_2 = false
    L17_2 = true
    L18_2 = false
    L19_2 = true
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
    L5_2 = ENTITY
    L5_2 = L5_2.SET_ENTITY_HAS_GRAVITY
    L6_2 = L4_2
    L7_2 = true
    L5_2(L6_2, L7_2)
    while true do
      L5_2 = ENTITY
      L5_2 = L5_2.HAS_ENTITY_COLLIDED_WITH_ANYTHING
      L6_2 = L4_2
      L5_2 = L5_2(L6_2)
      if L5_2 then
        break
      end
      L5_2 = ENTITY
      L5_2 = L5_2.IS_ENTITY_IN_WATER
      L6_2 = L4_2
      L5_2 = L5_2(L6_2)
      if L5_2 then
        break
      end
      L5_2 = util
      L5_2 = L5_2.yield
      L6_2 = 0
      L5_2(L6_2)
    end
    L5_2 = ENTITY
    L5_2 = L5_2.GET_ENTITY_COORDS
    L6_2 = L4_2
    L7_2 = true
    L5_2 = L5_2(L6_2, L7_2)
    L6_2 = delete_entity
    L7_2 = L4_2
    L6_2(L7_2)
    L6_2 = create_nuke_explosion
    L7_2 = L5_2
    L6_2(L7_2)
  end
end
nuclear_weapon2 = L26_1
function L26_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2
  if A0_2 then
    L2_2 = PLAYER
    L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
    L3_2 = A1_2
    L2_2 = L2_2(L3_2)
    L3_2 = ENTITY
    L3_2 = L3_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
    L4_2 = L2_2
    L5_2 = 0.0
    L6_2 = 5.0
    L7_2 = 0.0
    L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
    L4_2 = util
    L4_2 = L4_2.joaat
    L5_2 = "tiptruck"
    L4_2 = L4_2(L5_2)
    L5_2 = request_model
    L6_2 = L4_2
    L5_2(L6_2)
    L5_2 = VEHICLE
    L5_2 = L5_2.CREATE_VEHICLE
    L6_2 = L4_2
    L7_2 = L3_2.x
    L8_2 = L3_2.y
    L9_2 = L3_2.z
    L10_2 = ENTITY
    L10_2 = L10_2.GET_ENTITY_HEADING
    L11_2 = L2_2
    L10_2 = L10_2(L11_2)
    L11_2 = true
    L12_2 = false
    L13_2 = true
    L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
    nuketruck = L5_2
    L5_2 = util
    L5_2 = L5_2.joaat
    L6_2 = "prop_military_pickup_01"
    L5_2 = L5_2(L6_2)
    L6_2 = request_model
    L7_2 = L5_2
    L6_2(L7_2)
    L6_2 = ENTITY
    L6_2 = L6_2.GET_ENTITY_COORDS
    L7_2 = nuketruck
    L8_2 = true
    L6_2 = L6_2(L7_2, L8_2)
    L7_2 = ENTITY
    L7_2 = L7_2.GET_ENTITY_ROTATION
    L8_2 = nuketruck
    L9_2 = 0
    L7_2 = L7_2(L8_2, L9_2)
    L8_2 = OBJECT
    L8_2 = L8_2.CREATE_OBJECT_NO_OFFSET
    L9_2 = L5_2
    L10_2 = L6_2.x
    L11_2 = L6_2.y
    L12_2 = L6_2.z
    L12_2 = L12_2 + 2
    L13_2 = true
    L14_2 = false
    L15_2 = true
    L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
    esnuke = L8_2
    L8_2 = ENTITY
    L8_2 = L8_2.SET_ENTITY_HAS_GRAVITY
    L9_2 = esnuke
    L10_2 = true
    L8_2(L9_2, L10_2)
    L8_2 = ENTITY
    L8_2 = L8_2.SET_ENTITY_ROTATION
    L9_2 = esnuke
    L10_2 = L7_2.x
    L11_2 = L7_2.y
    L12_2 = L7_2.z
    L12_2 = L12_2 + 90
    L13_2 = 0
    L14_2 = true
    L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    L8_2 = ENTITY
    L8_2 = L8_2.ATTACH_ENTITY_TO_ENTITY
    L9_2 = esnuke
    L10_2 = nuketruck
    L11_2 = 0
    L12_2 = 0.0
    L13_2 = -1.5
    L14_2 = 1.7
    L15_2 = 0.0
    L16_2 = 0.0
    L17_2 = 90.0
    L18_2 = false
    L19_2 = false
    L20_2 = false
    L21_2 = false
    L22_2 = 2
    L23_2 = true
    L24_2 = 0
    L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
    L8_2 = util
    L8_2 = L8_2.create_tick_handler
    function L9_2()
      local L0_3, L1_3, L2_3, L3_3
      L0_3 = VEHICLE
      L0_3 = L0_3.GET_VEHICLE_ENGINE_HEALTH
      L1_3 = nuketruck
      L0_3 = L0_3(L1_3)
      if L0_3 <= 0 then
        L0_3 = ENTITY
        L0_3 = L0_3.DOES_ENTITY_EXIST
        L1_3 = esnuke
        L0_3 = L0_3(L1_3)
        if L0_3 then
          L0_3 = ENTITY
          L0_3 = L0_3.GET_ENTITY_COORDS
          L1_3 = esnuke
          L2_3 = true
          L0_3 = L0_3(L1_3, L2_3)
          L1_3 = delete_entity
          L2_3 = esnuke
          L1_3(L2_3)
          L1_3 = create_nuke_explosion
          L2_3 = L0_3
          L1_3(L2_3)
          L1_3 = menu
          L1_3 = L1_3.set_value
          L2_3 = safe_nuke
          L3_3 = false
          L1_3(L2_3, L3_3)
          L1_3 = util
          L1_3 = L1_3.toast
          L2_3 = "核弹已被引爆"
          L1_3(L2_3)
        end
      end
    end
    L8_2(L9_2)
  else
    L2_2 = ENTITY
    L2_2 = L2_2.DOES_ENTITY_EXIST
    L3_2 = esnuke
    L2_2 = L2_2(L3_2)
    if L2_2 then
      L2_2 = delete_entity
      L3_2 = esnuke
      L2_2(L3_2)
    end
    L2_2 = ENTITY
    L2_2 = L2_2.DOES_ENTITY_EXIST
    L3_2 = nuketruck
    L2_2 = L2_2(L3_2)
    if L2_2 then
      L2_2 = delete_entity
      L3_2 = nuketruck
      L2_2(L3_2)
    end
  end
end
escort_nuke = L26_1
function L26_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2
  L0_2 = "~y~按 ~%s~ 投掷核弹"
  L1_2 = util
  L1_2 = L1_2.show_corner_help
  L3_2 = L0_2
  L2_2 = L0_2.format
  L4_2 = "INPUT_VEH_HORN"
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L2_2(L3_2, L4_2)
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "prop_military_pickup_01"
  L2_2 = L2_2(L3_2)
  L3_2 = players
  L3_2 = L3_2.get_position
  L4_2 = PLAYER
  L4_2 = L4_2.PLAYER_ID
  L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L4_2()
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
  L4_2 = request_model
  L5_2 = util
  L5_2 = L5_2.joaat
  L6_2 = "skylift"
  L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L5_2(L6_2)
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
  L4_2 = request_model
  L5_2 = L2_2
  L4_2(L5_2)
  L4_2 = VEHICLE
  L4_2 = L4_2.CREATE_VEHICLE
  L5_2 = util
  L5_2 = L5_2.joaat
  L6_2 = "skylift"
  L5_2 = L5_2(L6_2)
  L6_2 = L3_2.x
  L7_2 = L3_2.y
  L8_2 = L3_2.z
  L9_2 = ENTITY
  L9_2 = L9_2.GET_ENTITY_HEADING
  L10_2 = L1_2
  L9_2 = L9_2(L10_2)
  L10_2 = true
  L11_2 = false
  L12_2 = false
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L5_2 = PED
  L5_2 = L5_2.SET_PED_INTO_VEHICLE
  L6_2 = L1_2
  L7_2 = L4_2
  L8_2 = -1
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = OBJECT
  L5_2 = L5_2.CREATE_OBJECT_NO_OFFSET
  L6_2 = L2_2
  L7_2 = L3_2.x
  L8_2 = L3_2.y
  L9_2 = L3_2.z
  L10_2 = true
  L11_2 = false
  L12_2 = true
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L6_2 = ENTITY
  L6_2 = L6_2.SET_ENTITY_AS_MISSION_ENTITY
  L7_2 = L5_2
  L8_2 = true
  L9_2 = true
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = ENTITY
  L6_2 = L6_2.ATTACH_ENTITY_TO_ENTITY
  L7_2 = L5_2
  L8_2 = L4_2
  L9_2 = 0
  L10_2 = 0
  L11_2 = -2.8
  L12_2 = -1.0
  L13_2 = 0.0
  L14_2 = 0.0
  L15_2 = 0.0
  L16_2 = true
  L17_2 = true
  L18_2 = true
  L19_2 = false
  L20_2 = 0
  L21_2 = true
  L22_2 = 0
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
  while true do
    L6_2 = ENTITY
    L6_2 = L6_2.GET_ENTITY_COORDS
    L7_2 = L4_2
    L8_2 = true
    L6_2 = L6_2(L7_2, L8_2)
    L7_2 = "~b~ Elevation ~w~"
    L8_2 = math
    L8_2 = L8_2.ceil
    L9_2 = L6_2.z
    L8_2 = L8_2(L9_2)
    L7_2 = L7_2 .. L8_2
    L8_2 = draw_string
    L9_2 = L7_2
    L10_2 = 0.03
    L11_2 = 0.1
    L12_2 = 0.6
    L13_2 = 4
    L8_2(L9_2, L10_2, L11_2, L12_2, L13_2)
    L8_2 = PAD
    L8_2 = L8_2.IS_CONTROL_PRESSED
    L9_2 = 0
    L10_2 = 46
    L8_2 = L8_2(L9_2, L10_2)
    if L8_2 then
      L8_2 = ENTITY
      L8_2 = L8_2.IS_ENTITY_ATTACHED
      L9_2 = L5_2
      L8_2 = L8_2(L9_2)
      if L8_2 then
        L8_2 = ENTITY
        L8_2 = L8_2.DETACH_ENTITY
        L9_2 = L5_2
        L10_2 = true
        L11_2 = true
        L8_2(L9_2, L10_2, L11_2)
        L8_2 = notification
        L9_2 = "~bold~~y~炸弹已投放"
        L10_2 = HudColour
        L10_2 = L10_2.blue
        L8_2(L9_2, L10_2)
      end
      L8_2 = ENTITY
      L8_2 = L8_2.APPLY_FORCE_TO_ENTITY
      L9_2 = L5_2
      L10_2 = 3
      L11_2 = 0.0
      L12_2 = 0.0
      L13_2 = -50
      L14_2 = 0.0
      L15_2 = 0.0
      L16_2 = 0.0
      L17_2 = 0
      L18_2 = true
      L19_2 = false
      L20_2 = true
      L21_2 = false
      L22_2 = true
      L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
      L8_2 = ENTITY
      L8_2 = L8_2.SET_ENTITY_HAS_GRAVITY
      L9_2 = L5_2
      L10_2 = true
      L8_2(L9_2, L10_2)
      while true do
        L8_2 = ENTITY
        L8_2 = L8_2.HAS_ENTITY_COLLIDED_WITH_ANYTHING
        L9_2 = L5_2
        L8_2 = L8_2(L9_2)
        if L8_2 then
          break
        end
        L8_2 = ENTITY
        L8_2 = L8_2.IS_ENTITY_IN_WATER
        L9_2 = L5_2
        L8_2 = L8_2(L9_2)
        if L8_2 then
          break
        end
        L8_2 = util
        L8_2 = L8_2.yield
        L9_2 = 0
        L8_2(L9_2)
      end
      L8_2 = ENTITY
      L8_2 = L8_2.DOES_ENTITY_EXIST
      L9_2 = L5_2
      L8_2 = L8_2(L9_2)
      if L8_2 then
        L8_2 = ENTITY
        L8_2 = L8_2.GET_ENTITY_COORDS
        L9_2 = L5_2
        L10_2 = true
        L8_2 = L8_2(L9_2, L10_2)
        L9_2 = delete_entity
        L10_2 = L5_2
        L9_2(L10_2)
        L9_2 = create_nuke_explosion
        L10_2 = L8_2
        L9_2(L10_2)
        L9_2 = notification
        L10_2 = "~bold~~y~核弹已爆炸"
        L11_2 = HudColour
        L11_2 = L11_2.blue
        L9_2(L10_2, L11_2)
        break
      end
    end
    L8_2 = util
    L8_2 = L8_2.yield
    L8_2()
  end
end
transport_nuke = L26_1
L26_1 = 360
function L27_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  L0_2 = request_anim_dict
  L1_2 = "misschinese2_crystalmaze"
  L0_2(L1_2)
  L0_2 = TASK
  L0_2 = L0_2.TASK_PLAY_ANIM
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = "misschinese2_crystalmaze"
  L3_2 = "2int_loop_a_taotranslator"
  L4_2 = 8.0
  L5_2 = 8.0
  L6_2 = -1
  L7_2 = 0
  L8_2 = 0.0
  L9_2 = 0
  L10_2 = 0
  L11_2 = 0
  L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L0_2 = CAM
  L0_2 = L0_2.GET_GAMEPLAY_CAM_ROT
  L1_2 = 0
  L0_2 = L0_2(L1_2)
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_ROTATION
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = 0
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_FORWARD_VECTOR
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L3_2()
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  L3_2 = ENTITY
  L3_2 = L3_2.GET_ENTITY_SPEED
  L4_2 = PLAYER
  L4_2 = L4_2.PLAYER_PED_ID
  L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L4_2()
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  L3_2 = L3_2 * 2.236936
  L4_2 = PED
  L4_2 = L4_2.SET_PED_CAN_RAGDOLL
  L5_2 = PLAYER
  L5_2 = L5_2.PLAYER_PED_ID
  L5_2 = L5_2()
  L6_2 = false
  L4_2(L5_2, L6_2)
  L4_2 = ENTITY
  L4_2 = L4_2.SET_ENTITY_ROTATION
  L5_2 = PLAYER
  L5_2 = L5_2.PLAYER_PED_ID
  L5_2 = L5_2()
  L6_2 = L26_1
  L7_2 = L1_2.y
  L8_2 = L0_2.z
  L9_2 = 2
  L10_2 = true
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  if L3_2 <= 70 then
    L4_2 = ENTITY
    L4_2 = L4_2.APPLY_FORCE_TO_ENTITY
    L5_2 = PLAYER
    L5_2 = L5_2.PLAYER_PED_ID
    L5_2 = L5_2()
    L6_2 = 3
    L7_2 = L2_2.x
    L8_2 = L2_2.y
    L9_2 = 0.0
    L10_2 = 0.0
    L11_2 = 0.0
    L12_2 = 0.0
    L13_2 = 0.0
    L14_2 = false
    L15_2 = false
    L16_2 = true
    L17_2 = false
    L18_2 = false
    L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  end
  L4_2 = L26_1
  if L4_2 <= 0 then
    L4_2 = 360
    L26_1 = L4_2
  else
    L4_2 = L26_1
    L4_2 = L4_2 - 6
    L26_1 = L4_2
  end
end
forward_roll = L27_1
function L27_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = util
  L0_2 = L0_2.yield
  L1_2 = 100
  L0_2(L1_2)
  L0_2 = PED
  L0_2 = L0_2.SET_PED_CAN_RAGDOLL
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = true
  L0_2(L1_2, L2_2)
  L0_2 = TASK
  L0_2 = L0_2.STOP_ANIM_TASK
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = "misschinese2_crystalmaze"
  L3_2 = "2int_loop_a_taotranslator"
  L4_2 = 1
  L0_2(L1_2, L2_2, L3_2, L4_2)
end
end_forward_roll = L27_1
L27_1 = 0
L28_1 = 0
L29_1 = nil
L30_1 = nil
function L31_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L0_2 = L28_1
  L1_2 = 200
  if L0_2 <= L1_2 then
    L0_2 = "missfbi5ig_20b"
    L29_1 = L0_2
    L0_2 = "hands_up_scientist"
    L30_1 = L0_2
  else
    L0_2 = L28_1
    L1_2 = 400
    if L0_2 <= L1_2 then
      L0_2 = "nm@hands"
      L29_1 = L0_2
      L0_2 = "hands_up"
      L30_1 = L0_2
    else
      L0_2 = L28_1
      L1_2 = 600
      if L0_2 <= L1_2 then
        L0_2 = "missheist_agency2ahands_up"
        L29_1 = L0_2
        L0_2 = "handsup_anxious"
        L30_1 = L0_2
      else
        L0_2 = L28_1
        L1_2 = 800
        if L0_2 <= L1_2 then
          L0_2 = "missheist_agency2ahands_up"
          L29_1 = L0_2
          L0_2 = "handsup_loop"
          L30_1 = L0_2
        end
      end
    end
  end
  L0_2 = ENTITY
  L0_2 = L0_2.SET_ENTITY_ROTATION
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = 180
  L3_2 = 0
  L4_2 = L27_1
  L5_2 = 1
  L6_2 = true
  L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2)
  L0_2 = request_anim_dict
  L1_2 = L29_1
  L0_2(L1_2)
  L0_2 = TASK
  L0_2 = L0_2.TASK_PLAY_ANIM
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = L29_1
  L3_2 = L30_1
  L4_2 = 8.0
  L5_2 = 0
  L6_2 = -1
  L7_2 = 0
  L8_2 = 0.0
  L9_2 = 0
  L10_2 = 0
  L11_2 = 0
  L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L0_2 = L27_1
  L0_2 = L0_2 + 5
  L27_1 = L0_2
  L0_2 = L28_1
  L1_2 = 1000
  if L0_2 < L1_2 then
    L0_2 = L28_1
    L0_2 = L0_2 + 1
    L28_1 = L0_2
  else
    L0_2 = 0
    L28_1 = L0_2
  end
end
breakdance = L31_1
function L31_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = util
  L0_2 = L0_2.yield
  L1_2 = 100
  L0_2(L1_2)
  L0_2 = TASK
  L0_2 = L0_2.STOP_ANIM_TASK
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = L29_1
  L3_2 = L30_1
  L4_2 = 1
  L0_2(L1_2, L2_2, L3_2, L4_2)
end
end_breakdance = L31_1
function L31_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L1_2 = 1000000
  L2_2 = nil
  L3_2 = PED
  L3_2 = L3_2.GET_VEHICLE_PED_IS_IN
  L4_2 = PLAYER
  L4_2 = L4_2.PLAYER_PED_ID
  L4_2 = L4_2()
  L5_2 = false
  L3_2 = L3_2(L4_2, L5_2)
  if 0 == L3_2 then
    L3_2 = 1
  end
  L4_2 = 0
  L5_2 = 31
  L6_2 = 1
  for L7_2 = L4_2, L5_2, L6_2 do
    L8_2 = PLAYER
    L8_2 = L8_2.GET_PLAYER_PED_SCRIPT_INDEX
    L9_2 = L7_2
    L8_2 = L8_2(L9_2)
    L9_2 = ENTITY
    L9_2 = L9_2.IS_ENTITY_DEAD
    L10_2 = L8_2
    L9_2 = L9_2(L10_2)
    if not L9_2 then
      L9_2 = players
      L9_2 = L9_2.get_position
      L10_2 = L7_2
      L9_2 = L9_2(L10_2)
      L11_2 = A0_2
      L10_2 = A0_2.distance
      L12_2 = L9_2
      L10_2 = L10_2(L11_2, L12_2)
      L11_2 = PED
      L11_2 = L11_2.GET_VEHICLE_PED_IS_IN
      L12_2 = PLAYER
      L12_2 = L12_2.PLAYER_PED_ID
      L12_2 = L12_2()
      L13_2 = false
      L11_2 = L11_2(L12_2, L13_2)
      if L1_2 > L10_2 and L11_2 ~= L3_2 then
        L12_2 = players
        L12_2 = L12_2.is_in_interior
        L13_2 = L7_2
        L12_2 = L12_2(L13_2)
        if not L12_2 then
          L1_2 = L10_2
          L2_2 = L7_2
        end
      end
    end
  end
  if nil ~= L2_2 then
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_ID
    L4_2 = L4_2()
    if L2_2 ~= L4_2 then
      return L2_2
    end
  end
end
getClosestPlayer = L31_1
function L31_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L0_2 = players
  L0_2 = L0_2.get_position
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L1_2 = getClosestPlayer
  L2_2 = L0_2
  L1_2 = L1_2(L2_2)
  if nil ~= L1_2 then
    L2_2 = PED
    L2_2 = L2_2.IS_PED_IN_ANY_VEHICLE
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2 = L3_2()
    L4_2 = false
    L2_2 = L2_2(L3_2, L4_2)
    if not L2_2 then
      L2_2 = players
      L2_2 = L2_2.get_position
      L3_2 = L1_2
      L2_2 = L2_2(L3_2)
      L3_2 = ENTITY
      L3_2 = L3_2.SET_ENTITY_COORDS
      L4_2 = PLAYER
      L4_2 = L4_2.PLAYER_PED_ID
      L4_2 = L4_2()
      L5_2 = L2_2.x
      L6_2 = L2_2.y
      L7_2 = L2_2.z
      L8_2 = false
      L9_2 = false
      L10_2 = false
      L11_2 = false
      L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    else
      L2_2 = players
      L2_2 = L2_2.get_position
      L3_2 = L1_2
      L2_2 = L2_2(L3_2)
      L3_2 = PED
      L3_2 = L3_2.GET_VEHICLE_PED_IS_IN
      L4_2 = PLAYER
      L4_2 = L4_2.PLAYER_PED_ID
      L4_2 = L4_2()
      L5_2 = false
      L3_2 = L3_2(L4_2, L5_2)
      if 0 ~= L3_2 then
        L4_2 = ENTITY
        L4_2 = L4_2.SET_ENTITY_COORDS
        L5_2 = L3_2
        L6_2 = L2_2.x
        L7_2 = L2_2.y
        L8_2 = L2_2.z
        L9_2 = false
        L10_2 = false
        L11_2 = false
        L12_2 = false
        L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
      end
    end
  end
end
tp_closest_player = L31_1
function L31_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_COORDS
  L2_2 = A0_2
  L3_2 = true
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = entities
  L2_2 = L2_2.get_all_vehicles_as_handles
  L2_2 = L2_2()
  L3_2 = 1000000
  L4_2 = 0
  L5_2 = pairs
  L6_2 = L2_2
  L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
  for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
    L11_2 = PLAYER
    L11_2 = L11_2.GET_PLAYER_PED_SCRIPT_INDEX
    L12_2 = PLAYER
    L12_2 = L12_2.PLAYER_ID
    L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2 = L12_2()
    L11_2 = L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
    L12_2 = PED
    L12_2 = L12_2.IS_PED_IN_ANY_VEHICLE
    L13_2 = L11_2
    L14_2 = false
    L12_2 = L12_2(L13_2, L14_2)
    if L12_2 then
      L12_2 = PED
      L12_2 = L12_2.GET_VEHICLE_PED_IS_IN
      L13_2 = PLAYER
      L13_2 = L13_2.PLAYER_PED_ID
      L13_2 = L13_2()
      L14_2 = false
      L12_2 = L12_2(L13_2, L14_2)
      if L10_2 ~= L12_2 then
        L12_2 = ENTITY
        L12_2 = L12_2.GET_ENTITY_COORDS
        L13_2 = L10_2
        L14_2 = true
        L12_2 = L12_2(L13_2, L14_2)
        L13_2 = MISC
        L13_2 = L13_2.GET_DISTANCE_BETWEEN_COORDS
        L14_2 = L1_2.x
        L15_2 = L1_2.y
        L16_2 = L1_2.z
        L17_2 = L12_2.x
        L18_2 = L12_2.y
        L19_2 = L12_2.z
        L20_2 = true
        L13_2 = L13_2(L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
        if L3_2 > L13_2 then
          L3_2 = L13_2
          L4_2 = L10_2
        end
      end
    else
      L12_2 = ENTITY
      L12_2 = L12_2.GET_ENTITY_COORDS
      L13_2 = L10_2
      L14_2 = true
      L12_2 = L12_2(L13_2, L14_2)
      L13_2 = MISC
      L13_2 = L13_2.GET_DISTANCE_BETWEEN_COORDS
      L14_2 = L1_2.x
      L15_2 = L1_2.y
      L16_2 = L1_2.z
      L17_2 = L12_2.x
      L18_2 = L12_2.y
      L19_2 = L12_2.z
      L20_2 = true
      L13_2 = L13_2(L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
      if L3_2 > L13_2 then
        L3_2 = L13_2
        L4_2 = L10_2
      end
    end
  end
  return L4_2
end
get_closest_vehicle = L31_1
function L31_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = get_closest_vehicle
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L1_2 = VEHICLE
  L1_2 = L1_2.GET_PED_IN_VEHICLE_SEAT
  L2_2 = L0_2
  L3_2 = -1
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = VEHICLE
  L2_2 = L2_2.IS_VEHICLE_SEAT_FREE
  L3_2 = L0_2
  L4_2 = -1
  L2_2 = L2_2(L3_2, L4_2)
  if L2_2 then
    L2_2 = PED
    L2_2 = L2_2.SET_PED_INTO_VEHICLE
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2 = L3_2()
    L4_2 = L0_2
    L5_2 = -1
    L2_2(L3_2, L4_2, L5_2)
  else
    L2_2 = PED
    L2_2 = L2_2.IS_PED_A_PLAYER
    L3_2 = L1_2
    L2_2 = L2_2(L3_2)
    if not L2_2 then
      L2_2 = delete_entity
      L3_2 = L1_2
      L2_2(L3_2)
      L2_2 = PED
      L2_2 = L2_2.SET_PED_INTO_VEHICLE
      L3_2 = PLAYER
      L3_2 = L3_2.PLAYER_PED_ID
      L3_2 = L3_2()
      L4_2 = L0_2
      L5_2 = -1
      L2_2(L3_2, L4_2, L5_2)
    else
      L2_2 = VEHICLE
      L2_2 = L2_2.ARE_ANY_VEHICLE_SEATS_FREE
      L3_2 = L0_2
      L2_2 = L2_2(L3_2)
      if L2_2 then
        L2_2 = 0
        L3_2 = 10
        L4_2 = 1
        for L5_2 = L2_2, L3_2, L4_2 do
          L6_2 = VEHICLE
          L6_2 = L6_2.IS_VEHICLE_SEAT_FREE
          L7_2 = L0_2
          L8_2 = L5_2
          L6_2 = L6_2(L7_2, L8_2)
          if L6_2 then
            L6_2 = PED
            L6_2 = L6_2.SET_PED_INTO_VEHICLE
            L7_2 = PLAYER
            L7_2 = L7_2.PLAYER_PED_ID
            L7_2 = L7_2()
            L8_2 = L0_2
            L9_2 = L5_2
            L6_2(L7_2, L8_2, L9_2)
            break
          end
        end
      else
        L2_2 = util
        L2_2 = L2_2.toast
        L3_2 = "传送到最近车辆错误"
        L2_2(L3_2)
      end
    end
  end
end
tp_closest_vehicle = L31_1
function L31_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  if A0_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.GET_ENTITY_COORDS
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = true
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = OBJECT
    L2_2 = L2_2.CREATE_OBJECT
    L3_2 = util
    L3_2 = L3_2.joaat
    L4_2 = "vw_prop_art_wings_01a"
    L3_2 = L3_2(L4_2)
    L4_2 = L1_2.x
    L5_2 = L1_2.y
    L6_2 = L1_2.z
    L7_2 = true
    L8_2 = true
    L9_2 = true
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    Gowings = L2_2
    L2_2 = STREAMING
    L2_2 = L2_2.SET_MODEL_AS_NO_LONGER_NEEDED
    L3_2 = util
    L3_2 = L3_2.joaat
    L4_2 = "vw_prop_art_wings_01a"
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L3_2(L4_2)
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L2_2 = ENTITY
    L2_2 = L2_2.ATTACH_ENTITY_TO_ENTITY
    L3_2 = Gowings
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2 = L4_2()
    L5_2 = PED
    L5_2 = L5_2.GET_PED_BONE_INDEX
    L6_2 = PLAYER
    L6_2 = L6_2.PLAYER_PED_ID
    L6_2 = L6_2()
    L7_2 = 23553
    L5_2 = L5_2(L6_2, L7_2)
    L6_2 = -1.0
    L7_2 = 0.0
    L8_2 = 0.0
    L9_2 = 0.0
    L10_2 = 90.0
    L11_2 = 0.0
    L12_2 = false
    L13_2 = true
    L14_2 = false
    L15_2 = true
    L16_2 = 0
    L17_2 = true
    L18_2 = 0
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  else
    L1_2 = delete_entity
    L2_2 = Gowings
    L1_2(L2_2)
  end
end
Golden_wings = L31_1
function L31_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  if A0_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.GET_ENTITY_COORDS
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = true
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = OBJECT
    L2_2 = L2_2.CREATE_OBJECT
    L3_2 = -112384661
    L4_2 = L1_2.x
    L5_2 = L1_2.y
    L6_2 = L1_2.z
    L7_2 = true
    L8_2 = true
    L9_2 = true
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    argwings = L2_2
    L2_2 = STREAMING
    L2_2 = L2_2.SET_MODEL_AS_NO_LONGER_NEEDED
    L3_2 = -112384661
    L2_2(L3_2)
    L2_2 = ENTITY
    L2_2 = L2_2.ATTACH_ENTITY_TO_ENTITY
    L3_2 = argwings
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2 = L4_2()
    L5_2 = PED
    L5_2 = L5_2.GET_PED_BONE_INDEX
    L6_2 = PLAYER
    L6_2 = L6_2.PLAYER_PED_ID
    L6_2 = L6_2()
    L7_2 = 23553
    L5_2 = L5_2(L6_2, L7_2)
    L6_2 = -1.0
    L7_2 = 0.0
    L8_2 = 0.0
    L9_2 = 0.0
    L10_2 = 90.0
    L11_2 = 0.0
    L12_2 = false
    L13_2 = true
    L14_2 = false
    L15_2 = true
    L16_2 = 0
    L17_2 = true
    L18_2 = 0
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  else
    L1_2 = delete_entity
    L2_2 = argwings
    L1_2(L2_2)
  end
end
argent_wings = L31_1
L31_1 = {}
function L32_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2
  if A0_2 then
    L1_2 = L31_1
    L1_2 = L1_2[1]
    if L1_2 then
      return
    end
    L1_2 = 255
    L2_2 = 165
    L3_2 = 50
    L4_2 = 1
    L5_2 = fireWings
    L5_2 = #L5_2
    L6_2 = 1
    for L7_2 = L4_2, L5_2, L6_2 do
      L8_2 = request_ptfx_asset
      L9_2 = "weap_xs_vehicle_weapons"
      L8_2(L9_2)
      L8_2 = GRAPHICS
      L8_2 = L8_2.USE_PARTICLE_FX_ASSET
      L9_2 = "weap_xs_vehicle_weapons"
      L8_2(L9_2)
      L8_2 = L31_1
      L9_2 = GRAPHICS
      L10_2 = "START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY"
      L9_2 = L9_2[L10_2]
      L10_2 = "muz_xs_turret_flamethrower_looping"
      L11_2 = PLAYER
      L11_2 = L11_2.PLAYER_PED_ID
      L11_2 = L11_2()
      L12_2 = 0
      L13_2 = 0
      L14_2 = 0.1
      L15_2 = fireWings
      L15_2 = L15_2[L7_2]
      L15_2 = L15_2.pos
      L15_2 = L15_2[1]
      L16_2 = 0
      L17_2 = fireWings
      L17_2 = L17_2[L7_2]
      L17_2 = L17_2.pos
      L17_2 = L17_2[2]
      L18_2 = 1
      L19_2 = false
      L20_2 = false
      L21_2 = false
      L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
      L8_2[L7_2] = L9_2
      L8_2 = GRAPHICS
      L8_2 = L8_2.SET_PARTICLE_FX_LOOPED_SCALE
      L9_2 = L31_1
      L9_2 = L9_2[L7_2]
      L10_2 = 0.3
      L8_2(L9_2, L10_2)
      L8_2 = GRAPHICS
      L8_2 = L8_2.SET_PARTICLE_FX_LOOPED_COLOUR
      L9_2 = L31_1
      L9_2 = L9_2[L7_2]
      L10_2 = L1_2
      L11_2 = L2_2
      L12_2 = L3_2
      L13_2 = false
      L8_2(L9_2, L10_2, L11_2, L12_2, L13_2)
    end
  else
    L1_2 = 1
    L2_2 = fireWings
    L2_2 = #L2_2
    L3_2 = 1
    for L4_2 = L1_2, L2_2, L3_2 do
      L5_2 = L31_1
      L5_2 = L5_2[L4_2]
      if L5_2 then
        L5_2 = GRAPHICS
        L5_2 = L5_2.STOP_PARTICLE_FX_LOOPED
        L6_2 = L31_1
        L6_2 = L6_2[L4_2]
        L7_2 = false
        L5_2(L6_2, L7_2)
        L5_2 = GRAPHICS
        L5_2 = L5_2.REMOVE_PARTICLE_FX
        L6_2 = L31_1
        L6_2 = L6_2[L4_2]
        L7_2 = false
        L5_2(L6_2, L7_2)
        L5_2 = L31_1
        L5_2[L4_2] = nil
      end
    end
    L1_2 = GRAPHICS
    L1_2 = L1_2.REMOVE_PARTICLE_FX_FROM_ENTITY
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L2_2()
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
  end
end
fireWing = L32_1
L32_1 = {}
function L33_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  if A0_2 then
    L1_2 = 1
    L2_2 = fireWings
    L2_2 = #L2_2
    L3_2 = 1
    for L4_2 = L1_2, L2_2, L3_2 do
      L5_2 = request_ptfx_asset
      L6_2 = "weap_xs_vehicle_weapons"
      L5_2(L6_2)
      L5_2 = GRAPHICS
      L5_2 = L5_2.USE_PARTICLE_FX_ASSET
      L6_2 = "weap_xs_vehicle_weapons"
      L5_2(L6_2)
      L5_2 = L32_1
      L6_2 = GRAPHICS
      L7_2 = "START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY"
      L6_2 = L6_2[L7_2]
      L7_2 = "muz_xs_turret_flamethrower_looping"
      L8_2 = PLAYER
      L8_2 = L8_2.PLAYER_PED_ID
      L8_2 = L8_2()
      L9_2 = 0
      L10_2 = 0
      L11_2 = 0.1
      L12_2 = fireWings
      L12_2 = L12_2[L4_2]
      L12_2 = L12_2.pos
      L12_2 = L12_2[1]
      L13_2 = 0
      L14_2 = fireWings
      L14_2 = L14_2[L4_2]
      L14_2 = L14_2.pos
      L14_2 = L14_2[2]
      L15_2 = 1
      L16_2 = false
      L17_2 = false
      L18_2 = false
      L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
      L5_2[L4_2] = L6_2
      L5_2 = util
      L5_2 = L5_2.create_tick_handler
      function L6_2()
        local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3
        L0_3 = 1
        L1_3 = fireWings
        L1_3 = #L1_3
        L2_3 = 1
        for L3_3 = L0_3, L1_3, L2_3 do
          L4_3 = GRAPHICS
          L4_3 = L4_3.SET_PARTICLE_FX_LOOPED_SCALE
          L5_3 = L32_1
          L5_3 = L5_3[L3_3]
          L6_3 = 0.3
          L4_3(L5_3, L6_3)
          L4_3 = MISC
          L4_3 = L4_3.GET_GAME_TIMER
          L4_3 = L4_3()
          L5_3 = gradient_colour
          L6_3 = L4_3
          L7_3 = 1
          L5_3 = L5_3(L6_3, L7_3)
          L6_3 = GRAPHICS
          L6_3 = L6_3.SET_PARTICLE_FX_LOOPED_COLOUR
          L7_3 = L32_1
          L7_3 = L7_3[L3_3]
          L8_3 = L5_3.r
          L8_3 = L8_3 / 255
          L9_3 = L5_3.g
          L9_3 = L9_3 / 255
          L10_3 = L5_3.b
          L10_3 = L10_3 / 255
          L11_3 = false
          L6_3(L7_3, L8_3, L9_3, L10_3, L11_3)
        end
      end
      L5_2(L6_2)
    end
  else
    L1_2 = 1
    L2_2 = fireWings
    L2_2 = #L2_2
    L3_2 = 1
    for L4_2 = L1_2, L2_2, L3_2 do
      L5_2 = L32_1
      L5_2 = L5_2[L4_2]
      if L5_2 then
        L5_2 = GRAPHICS
        L5_2 = L5_2.STOP_PARTICLE_FX_LOOPED
        L6_2 = L32_1
        L6_2 = L6_2[L4_2]
        L7_2 = false
        L5_2(L6_2, L7_2)
        L5_2 = GRAPHICS
        L5_2 = L5_2.REMOVE_PARTICLE_FX
        L6_2 = L32_1
        L6_2 = L6_2[L4_2]
        L7_2 = false
        L5_2(L6_2, L7_2)
        L5_2 = L32_1
        L5_2[L4_2] = nil
      end
    end
    L1_2 = GRAPHICS
    L1_2 = L1_2.REMOVE_PARTICLE_FX_FROM_ENTITY
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L2_2()
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  end
end
colorful_fireWing = L33_1
function L33_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = CAM
  L1_2 = L1_2.GET_FINAL_RENDERED_CAM_COORD
  L1_2 = L1_2()
  L2_2 = v3
  L2_2 = L2_2.toDir
  L3_2 = CAM
  L3_2 = L3_2.GET_FINAL_RENDERED_CAM_ROT
  L4_2 = 2
  L3_2, L4_2, L5_2 = L3_2(L4_2)
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = {}
  L4_2 = L1_2.x
  L5_2 = L2_2.x
  L5_2 = L5_2 * A0_2
  L4_2 = L4_2 + L5_2
  L3_2.x = L4_2
  L4_2 = L1_2.y
  L5_2 = L2_2.y
  L5_2 = L5_2 * A0_2
  L4_2 = L4_2 + L5_2
  L3_2.y = L4_2
  L4_2 = L1_2.z
  L5_2 = L2_2.z
  L5_2 = L5_2 * A0_2
  L4_2 = L4_2 + L5_2
  L3_2.z = L4_2
  return L3_2
end
getOffsetFromCam = L33_1
function L33_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  L0_2 = menu
  L0_2 = L0_2.trigger_commands
  L1_2 = "levitate on"
  L0_2(L1_2)
  L0_2 = WEAPON
  L0_2 = L0_2.GIVE_WEAPON_TO_PED
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED_SCRIPT_INDEX
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_ID
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  L2_2 = -1569615261
  L3_2 = 15
  L4_2 = true
  L5_2 = true
  L0_2(L1_2, L2_2, L3_2, L4_2, L5_2)
  L0_2 = PED
  L0_2 = L0_2.IS_PED_WEARING_HELMET
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  if not L0_2 then
    L0_2 = PED
    L0_2 = L0_2.GIVE_PED_HELMET
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_PED_ID
    L1_2 = L1_2()
    L2_2 = true
    L3_2 = 4096
    L4_2 = -1
    L0_2(L1_2, L2_2, L3_2, L4_2)
  end
  L0_2 = CAM1
  L0_2 = L0_2._GET_CAM_ACTIVE_VIEW_MODE_CONTEXT
  L0_2 = L0_2()
  L1_2 = startViewMode
  if nil == L1_2 then
    L1_2 = CAM
    L1_2 = L1_2.GET_CAM_VIEW_MODE_FOR_CONTEXT
    L2_2 = L0_2
    L1_2 = L1_2(L2_2)
    startViewMode = L1_2
  end
  L1_2 = CAM
  L1_2 = L1_2.GET_CAM_VIEW_MODE_FOR_CONTEXT
  L2_2 = L0_2
  L1_2 = L1_2(L2_2)
  if 4 ~= L1_2 then
    L1_2 = CAM
    L1_2 = L1_2.SET_CAM_VIEW_MODE_FOR_CONTEXT
    L2_2 = L0_2
    L3_2 = 4
    L1_2(L2_2, L3_2)
  end
  L1_2 = GRAPHICS
  L1_2 = L1_2.REQUEST_SCALEFORM_MOVIE
  L2_2 = "REMOTE_SNIPER_HUD"
  L1_2 = L1_2(L2_2)
  scope_scaleform = L1_2
  L1_2 = GRAPHICS
  L1_2 = L1_2.BEGIN_SCALEFORM_MOVIE_METHOD
  L2_2 = scope_scaleform
  L3_2 = "REMOTE_SNIPER_HUD"
  L1_2(L2_2, L3_2)
  L1_2 = GRAPHICS
  L1_2 = L1_2.DRAW_SCALEFORM_MOVIE_FULLSCREEN
  L2_2 = scope_scaleform
  L3_2 = 255
  L4_2 = 255
  L5_2 = 255
  L6_2 = 255
  L7_2 = 0
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
  L1_2 = GRAPHICS
  L1_2 = L1_2.END_SCALEFORM_MOVIE_METHOD
  L1_2()
  L1_2 = "INPUT_PICKUP"
  L2_2 = PAD
  L2_2 = L2_2.IS_USING_KEYBOARD_AND_MOUSE
  L3_2 = 0
  L2_2 = L2_2(L3_2)
  if not L2_2 then
    L1_2 = "INPUT_COVER"
  end
  L2_2 = show_button
  L2_2()
  L2_2 = sf
  L2_2 = L2_2.SET_DATA_SLOT
  L3_2 = 0
  L4_2 = PAD
  L4_2 = L4_2.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING
  L5_2 = 0
  L6_2 = 46
  L7_2 = true
  L4_2 = L4_2(L5_2, L6_2, L7_2)
  L5_2 = "火箭弹"
  L2_2(L3_2, L4_2, L5_2)
  L2_2 = sf
  L2_2 = L2_2.SET_DATA_SLOT
  L3_2 = 1
  L4_2 = PAD
  L4_2 = L4_2.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING
  L5_2 = 0
  L6_2 = 25
  L7_2 = true
  L4_2 = L4_2(L5_2, L6_2, L7_2)
  L5_2 = "原子枪"
  L2_2(L3_2, L4_2, L5_2)
  L2_2 = sf
  L2_2 = L2_2.SET_DATA_SLOT
  L3_2 = 2
  L4_2 = PAD
  L4_2 = L4_2.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING
  L5_2 = 0
  L6_2 = 18
  L7_2 = true
  L4_2 = L4_2(L5_2, L6_2, L7_2)
  L5_2 = "机炮"
  L2_2(L3_2, L4_2, L5_2)
  L2_2 = show_button2
  L2_2()
  L2_2 = JSkey
  L2_2 = L2_2.disable_control_action
  L3_2 = 2
  L4_2 = "INPUT_VEH_MOUSE_CONTROL_OVERRIDE"
  L2_2(L3_2, L4_2)
  L2_2 = JSkey
  L2_2 = L2_2.disable_control_action
  L3_2 = 2
  L4_2 = "INPUT_VEH_FLY_MOUSE_CONTROL_OVERRIDE"
  L2_2(L3_2, L4_2)
  L2_2 = JSkey
  L2_2 = L2_2.disable_control_action
  L3_2 = 2
  L4_2 = "INPUT_VEH_SUB_MOUSE_CONTROL_OVERRIDE"
  L2_2(L3_2, L4_2)
  L2_2 = JSkey
  L2_2 = L2_2.disable_control_action
  L3_2 = 0
  L4_2 = "INPUT_ATTACK"
  L2_2(L3_2, L4_2)
  L2_2 = JSkey
  L2_2 = L2_2.disable_control_action
  L3_2 = 0
  L4_2 = "INPUT_AIM"
  L2_2(L3_2, L4_2)
  L2_2 = JSkey
  L2_2 = L2_2.is_disabled_control_pressed
  L3_2 = 0
  L4_2 = "INPUT_ATTACK"
  L2_2 = L2_2(L3_2, L4_2)
  if not L2_2 then
    L2_2 = JSkey
    L2_2 = L2_2.is_disabled_control_pressed
    L3_2 = 0
    L4_2 = "INPUT_AIM"
    L2_2 = L2_2(L3_2, L4_2)
    if not L2_2 then
      L2_2 = JSkey
      L2_2 = L2_2.is_disabled_control_pressed
      L3_2 = 0
      L4_2 = L1_2
      L2_2 = L2_2(L3_2, L4_2)
      if not L2_2 then
        return
      end
    end
  end
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L3_2()
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  L3_2 = getOffsetFromCam
  L4_2 = 80
  L3_2 = L3_2(L4_2)
  L4_2 = nil
  L5_2 = JSkey
  L5_2 = L5_2.is_disabled_control_pressed
  L6_2 = 0
  L7_2 = "INPUT_ATTACK"
  L5_2 = L5_2(L6_2, L7_2)
  if L5_2 then
    L5_2 = util
    L5_2 = L5_2.joaat
    L6_2 = "VEHICLE_WEAPON_PLAYER_LAZER"
    L5_2 = L5_2(L6_2)
    L4_2 = L5_2
    L5_2 = WEAPON
    L5_2 = L5_2.HAS_WEAPON_ASSET_LOADED
    L6_2 = L4_2
    L5_2 = L5_2(L6_2)
    if not L5_2 then
      L5_2 = WEAPON
      L5_2 = L5_2.REQUEST_WEAPON_ASSET
      L6_2 = L4_2
      L7_2 = 31
      L8_2 = 26
      L5_2(L6_2, L7_2, L8_2)
      while true do
        L5_2 = WEAPON
        L5_2 = L5_2.HAS_WEAPON_ASSET_LOADED
        L6_2 = L4_2
        L5_2 = L5_2(L6_2)
        if L5_2 then
          break
        end
        L5_2 = util
        L5_2 = L5_2.yield
        L5_2()
      end
    end
  else
    L5_2 = JSkey
    L5_2 = L5_2.is_disabled_control_pressed
    L6_2 = 0
    L7_2 = "INPUT_AIM"
    L5_2 = L5_2(L6_2, L7_2)
    if L5_2 then
      L5_2 = util
      L5_2 = L5_2.joaat
      L6_2 = "WEAPON_RAYPISTOL"
      L5_2 = L5_2(L6_2)
      L4_2 = L5_2
      L5_2 = WEAPON
      L5_2 = L5_2.HAS_PED_GOT_WEAPON
      L6_2 = PLAYER
      L6_2 = L6_2.PLAYER_PED_ID
      L6_2 = L6_2()
      L7_2 = L4_2
      L8_2 = false
      L5_2 = L5_2(L6_2, L7_2, L8_2)
      if not L5_2 then
        L5_2 = WEAPON
        L5_2 = L5_2.GIVE_WEAPON_TO_PED
        L6_2 = PLAYER
        L6_2 = L6_2.PLAYER_PED_ID
        L6_2 = L6_2()
        L7_2 = L4_2
        L8_2 = 9999
        L9_2 = false
        L10_2 = false
        L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
      end
    else
      L5_2 = util
      L5_2 = L5_2.joaat
      L6_2 = "WEAPON_RPG"
      L5_2 = L5_2(L6_2)
      L4_2 = L5_2
      L5_2 = WEAPON
      L5_2 = L5_2.HAS_PED_GOT_WEAPON
      L6_2 = PLAYER
      L6_2 = L6_2.PLAYER_PED_ID
      L6_2 = L6_2()
      L7_2 = L4_2
      L8_2 = false
      L5_2 = L5_2(L6_2, L7_2, L8_2)
      if not L5_2 then
        L5_2 = WEAPON
        L5_2 = L5_2.GIVE_WEAPON_TO_PED
        L6_2 = PLAYER
        L6_2 = L6_2.PLAYER_PED_ID
        L6_2 = L6_2()
        L7_2 = L4_2
        L8_2 = 9999
        L9_2 = false
        L10_2 = false
        L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
      end
      L5_2 = L2_2.x
      L6_2 = math
      L6_2 = L6_2.random
      L7_2 = 0
      L8_2 = 100
      L6_2 = L6_2(L7_2, L8_2)
      L6_2 = L6_2 / 100
      L5_2 = L5_2 + L6_2
      L2_2.x = L5_2
      L5_2 = L2_2.y
      L6_2 = math
      L6_2 = L6_2.random
      L7_2 = 0
      L8_2 = 100
      L6_2 = L6_2(L7_2, L8_2)
      L6_2 = L6_2 / 100
      L5_2 = L5_2 + L6_2
      L2_2.y = L5_2
      L5_2 = L2_2.z
      L6_2 = math
      L6_2 = L6_2.random
      L7_2 = 0
      L8_2 = 100
      L6_2 = L6_2(L7_2, L8_2)
      L6_2 = L6_2 / 100
      L5_2 = L5_2 + L6_2
      L2_2.z = L5_2
    end
  end
  L5_2 = WEAPON
  L5_2 = L5_2.SET_CURRENT_PED_WEAPON
  L6_2 = PLAYER
  L6_2 = L6_2.PLAYER_PED_ID
  L6_2 = L6_2()
  L7_2 = util
  L7_2 = L7_2.joaat
  L8_2 = "WEAPON_UNARMED"
  L7_2 = L7_2(L8_2)
  L8_2 = true
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = MISC
  L5_2 = L5_2.SHOOT_SINGLE_BULLET_BETWEEN_COORDS
  L6_2 = L2_2.x
  L7_2 = L2_2.y
  L8_2 = L2_2.z
  L9_2 = L3_2.x
  L10_2 = L3_2.y
  L11_2 = L3_2.z
  L12_2 = 200
  L13_2 = true
  L14_2 = L4_2
  L15_2 = PLAYER
  L15_2 = L15_2.PLAYER_PED_ID
  L15_2 = L15_2()
  L16_2 = true
  L17_2 = true
  L18_2 = -1.0
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
end
Iron_Man = L33_1
function L33_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = PED
  L0_2 = L0_2.REMOVE_PED_HELMET
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = true
  L0_2(L1_2, L2_2)
  L0_2 = HUD1
  L0_2 = L0_2._HUD_WEAPON_WHEEL_IGNORE_CONTROL_INPUT
  L1_2 = false
  L0_2(L1_2)
  L0_2 = memory
  L0_2 = L0_2.alloc_int
  L0_2 = L0_2()
  L1_2 = memory
  L1_2 = L1_2.write_int
  L2_2 = L0_2
  L3_2 = scope_scaleform
  L1_2(L2_2, L3_2)
  L1_2 = GRAPHICS
  L1_2 = L1_2.SET_SCALEFORM_MOVIE_AS_NO_LONGER_NEEDED
  L2_2 = L0_2
  L1_2(L2_2)
  L1_2 = menu
  L1_2 = L1_2.trigger_commands
  L2_2 = "levitate off"
  L1_2(L2_2)
  L1_2 = util
  L1_2 = L1_2.yield
  L1_2()
  L1_2 = CAM
  L1_2 = L1_2.SET_CAM_VIEW_MODE_FOR_CONTEXT
  L2_2 = CAM1
  L2_2 = L2_2._GET_CAM_ACTIVE_VIEW_MODE_CONTEXT
  L2_2 = L2_2()
  L3_2 = startViewMode
  L1_2(L2_2, L3_2)
  startViewMode = nil
end
Iron_Man_stop = L33_1
L33_1 = filesystem
L33_1 = L33_1.stand_dir
L33_1 = L33_1()
L34_1 = "\\Log.txt"
L33_1 = L33_1 .. L34_1
L34_1 = ""
L35_1 = ""
L36_1 = 110
L37_1 = 25
L38_1 = 0.45
function L39_1(A0_2)
  local L1_2
  L36_1 = A0_2
end
console_max_chars = L39_1
function L39_1(A0_2)
  local L1_2
  L37_1 = A0_2
end
console_max_lines = L39_1
function L39_1(A0_2)
  local L1_2
  L1_2 = A0_2 * 0.01
  L38_1 = L1_2
end
console_font_size = L39_1
function L39_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L2_2 = {}
  L3_2 = {}
  L4_2 = #A0_2
  L5_2 = 1
  if A1_2 <= L4_2 then
    L6_2 = #A0_2
    L5_2 = L6_2 - A1_2
  end
  L6_2 = L5_2
  L7_2 = L4_2
  L8_2 = 1
  for L9_2 = L6_2, L7_2, L8_2 do
    L10_2 = A0_2[L9_2]
    L11_2 = L10_2
    if "" ~= L10_2 and "\n" ~= L10_2 then
      L12_2 = #L2_2
      L12_2 = L12_2 + 1
      L2_2[L12_2] = L10_2
      L12_2 = string
      L12_2 = L12_2.len
      L13_2 = L10_2
      L12_2 = L12_2(L13_2)
      L13_2 = L36_1
      if L12_2 > L13_2 then
        L12_2 = #L3_2
        L12_2 = L12_2 + 1
        L14_2 = L10_2
        L13_2 = L10_2.sub
        L15_2 = 1
        L16_2 = L36_1
        L13_2 = L13_2(L14_2, L15_2, L16_2)
        L14_2 = " ..."
        L13_2 = L13_2 .. L14_2
        L3_2[L12_2] = L13_2
      else
        L12_2 = #L3_2
        L12_2 = L12_2 + 1
        L3_2[L12_2] = L10_2
      end
    end
  end
  L6_2 = table
  L6_2 = L6_2.concat
  L7_2 = L2_2
  L8_2 = "\n"
  L6_2 = L6_2(L7_2, L8_2)
  L34_1 = L6_2
  L6_2 = table
  L6_2 = L6_2.concat
  L7_2 = L3_2
  L8_2 = "\n"
  L6_2 = L6_2(L7_2, L8_2)
  L35_1 = L6_2
end
get_stand_stdout = L39_1
function L39_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = io
  L1_2 = L1_2.open
  L2_2 = A0_2
  L3_2 = "r"
  L1_2 = L1_2(L2_2, L3_2)
  L3_2 = L1_2
  L2_2 = L1_2.seek
  L4_2 = "end"
  L2_2 = L2_2(L3_2, L4_2)
  L4_2 = L1_2
  L3_2 = L1_2.seek
  L5_2 = "set"
  L6_2 = L37_1
  L6_2 = L6_2 * 1000
  L6_2 = L2_2 - L6_2
  L3_2(L4_2, L5_2, L6_2)
  L4_2 = L1_2
  L3_2 = L1_2.read
  L5_2 = "*a"
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = string
  L4_2 = L4_2.split
  L5_2 = L3_2
  L6_2 = "\n"
  L4_2 = L4_2(L5_2, L6_2)
  lines = L4_2
  L5_2 = L1_2
  L4_2 = L1_2.close
  L4_2(L5_2)
  L4_2 = get_stand_stdout
  L5_2 = lines
  L6_2 = L37_1
  L4_2(L5_2, L6_2)
end
get_last_lines = L39_1
L39_1 = {}
L39_1.r = 0
L39_1.g = 0
L39_1.b = 0
L39_1.a = 0.5
console_bg_color = L39_1
L39_1 = {}
L39_1.r = 0.28
L39_1.g = 1
L39_1.b = 1
L39_1.a = 1
console_text_color = L39_1
function L39_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L0_2 = get_last_lines
  L1_2 = L33_1
  L0_2 = L0_2(L1_2)
  L1_2 = directx
  L1_2 = L1_2.get_text_size
  L2_2 = L35_1
  L3_2 = L38_1
  L1_2, L2_2 = L1_2(L2_2, L3_2)
  L1_2 = L1_2 + 0.01
  L2_2 = L2_2 + 0.01
  L3_2 = directx
  L3_2 = L3_2.draw_rect
  L4_2 = 0.0
  L5_2 = 0.05
  L6_2 = L1_2
  L7_2 = L2_2
  L8_2 = console_bg_color
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
  L3_2 = directx
  L3_2 = L3_2.draw_text
  L4_2 = 0.0
  L5_2 = 0.05
  L6_2 = L35_1
  L7_2 = 0
  L8_2 = L38_1
  L9_2 = console_text_color
  L10_2 = true
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
end
Draw_console = L39_1
L39_1 = directx
L39_1 = L39_1.create_texture
L40_1 = filesystem
L40_1 = L40_1.resources_dir
L40_1 = L40_1()
L41_1 = "SakuraImg\\watermark\\icon.jpg"
L40_1 = L40_1 .. L41_1
L39_1 = L39_1(L40_1)
function L40_1(A0_2)
  local L1_2, L2_2
  L1_2 = watermark_pos
  L2_2 = A0_2 / 10000
  L1_2.x = L2_2
end
watermark_x = L40_1
function L40_1(A0_2)
  local L1_2, L2_2
  L1_2 = watermark_pos
  L2_2 = A0_2 / 10000
  L1_2.y = L2_2
end
watermark_y = L40_1
function L40_1(A0_2)
  local L1_2, L2_2
  L1_2 = watermark_settings
  L2_2 = A0_2 / 10000
  L1_2.add_x = L2_2
end
watermark_bgx = L40_1
function L40_1(A0_2)
  local L1_2, L2_2
  L1_2 = watermark_settings
  L2_2 = A0_2 / 10000
  L1_2.add_y = L2_2
end
watermark_bgy = L40_1
function L40_1(A0_2)
  local L1_2
  L1_2 = watermark_settings
  L1_2.bg_color = A0_2
end
watermark_bgc = L40_1
function L40_1(A0_2)
  local L1_2
  L1_2 = watermark_settings
  L1_2.tx_color = A0_2
end
watermark_txtc = L40_1
function L40_1(A0_2)
  local L1_2
  L1_2 = watermark_settings
  L1_2.show_firstl = A0_2
end
watermark_lable = L40_1
function L40_1(A0_2)
  local L1_2
  L1_2 = watermark_settings
  L1_2.show_name = A0_2
end
watermark_name = L40_1
function L40_1(A0_2)
  local L1_2
  L1_2 = watermark_settings
  L1_2.show_players = A0_2
end
watermark_players = L40_1
function L40_1(A0_2)
  local L1_2
  L1_2 = watermark_settings
  L1_2.show_date = A0_2
end
watermark_time = L40_1
function L40_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L0_2 = watermark_settings
  L0_2 = L0_2.show_firstl
  if 2 == L0_2 then
    L0_2 = "Sakura"
    if L0_2 then
      goto lbl_43
    end
  end
  L0_2 = watermark_settings
  L0_2 = L0_2.show_firstl
  if 5 == L0_2 then
    L0_2 = "^_-"
    if L0_2 then
      goto lbl_43
    end
  end
  L0_2 = watermark_settings
  L0_2 = L0_2.show_firstl
  if 6 == L0_2 then
    L0_2 = "OwO"
    if L0_2 then
      goto lbl_43
    end
  end
  L0_2 = watermark_settings
  L0_2 = L0_2.show_firstl
  if 4 == L0_2 then
    L0_2 = "Stand"
    if L0_2 then
      goto lbl_43
    end
  end
  L0_2 = watermark_settings
  L0_2 = L0_2.show_firstl
  if 3 == L0_2 then
    L0_2 = stand_version
    L0_2 = L0_2.editions
    L1_2 = stand_version
    L1_2 = L1_2.edition
    L1_2 = L1_2 + 1
    L0_2 = L0_2[L1_2]
    if L0_2 then
      goto lbl_43
    end
  end
  L0_2 = ""
  ::lbl_43::
  L1_2 = watermark_settings
  L1_2 = L1_2.show_name
  if L1_2 then
    L1_2 = " | "
    L2_2 = players
    L2_2 = L2_2.get_name
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_ID
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L3_2()
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    L1_2 = L1_2 .. L2_2
    if L1_2 then
      goto lbl_58
    end
  end
  L1_2 = ""
  ::lbl_58::
  L2_2 = watermark_settings
  L2_2 = L2_2.show_players
  if L2_2 then
    L2_2 = NETWORK
    L2_2 = L2_2.NETWORK_IS_SESSION_STARTED
    L2_2 = L2_2()
    if L2_2 then
      L2_2 = " | Players: "
      L3_2 = players
      L3_2 = L3_2.list
      L4_2 = true
      L5_2 = true
      L6_2 = true
      L3_2 = L3_2(L4_2, L5_2, L6_2)
      L3_2 = #L3_2
      L2_2 = L2_2 .. L3_2
      if L2_2 then
        goto lbl_79
      end
    end
  end
  L2_2 = ""
  ::lbl_79::
  L3_2 = watermark_settings
  L3_2 = L3_2.show_date
  if L3_2 then
    L3_2 = os
    L3_2 = L3_2.date
    L4_2 = " | %H:%M:%S "
    L3_2 = L3_2(L4_2)
    if L3_2 then
      goto lbl_90
    end
  end
  L3_2 = ""
  ::lbl_90::
  L0_2 = L0_2 .. L1_2 .. L2_2 .. L3_2
  L1_2 = directx
  L1_2 = L1_2.get_text_size
  L2_2 = L0_2
  L3_2 = 0.52
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = directx
  L2_2 = L2_2.draw_rect
  L3_2 = watermark_pos
  L3_2 = L3_2.x
  L4_2 = watermark_settings
  L4_2 = L4_2.add_x
  L4_2 = L4_2 * 0.5
  L3_2 = L3_2 + L4_2
  L4_2 = watermark_pos
  L4_2 = L4_2.y
  L5_2 = L1_2 + 0.0105
  L6_2 = watermark_settings
  L6_2 = L6_2.add_x
  L5_2 = L5_2 + L6_2
  L5_2 = -L5_2
  L6_2 = watermark_settings
  L6_2 = L6_2.add_y
  L6_2 = 0.025 + L6_2
  L7_2 = watermark_settings
  L7_2 = L7_2.bg_color
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = directx
  L2_2 = L2_2.draw_texture
  L3_2 = L39_1
  L4_2 = 0.0055
  L5_2 = 0.0055
  L6_2 = 0.5
  L7_2 = 0.5
  L8_2 = watermark_pos
  L8_2 = L8_2.x
  L8_2 = L8_2 - L1_2
  L8_2 = L8_2 - 0.0055
  L9_2 = watermark_pos
  L9_2 = L9_2.y
  L9_2 = L9_2 + 0.013
  L10_2 = 0
  L11_2 = {}
  L11_2.r = 1.0
  L11_2.g = 1.0
  L11_2.b = 1.0
  L11_2.a = 1.0
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L2_2 = directx
  L2_2 = L2_2.draw_text
  L3_2 = watermark_pos
  L3_2 = L3_2.x
  L4_2 = watermark_pos
  L4_2 = L4_2.y
  L4_2 = L4_2 + 0.004
  L5_2 = L0_2
  L6_2 = ALIGN_TOP_RIGHT
  L7_2 = 0.5
  L8_2 = watermark_settings
  L8_2 = L8_2.tx_color
  L9_2 = false
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
end
watermark_toggle = L40_1
function L40_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2
  L3_2 = A0_2
  if true == A2_2 then
    L4_2 = L3_2
    L5_2 = "var"
    L4_2 = L4_2 .. L5_2
    L3_2 = L4_2
  end
  L4_2 = menu
  L4_2 = L4_2.trigger_commands
  L5_2 = L3_2
  L6_2 = " "
  L7_2 = A1_2
  L5_2 = L5_2 .. L6_2 .. L7_2
  L4_2(L5_2)
end
SET_OUTFIT_VALUE = L40_1
function L40_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = menu
  L0_2 = L0_2.trigger_commands
  L1_2 = "mpmale"
  L0_2(L1_2)
  L0_2 = SET_OUTFIT_VALUE
  L1_2 = "head"
  L2_2 = 32
  L0_2(L1_2, L2_2)
  L0_2 = SET_OUTFIT_VALUE
  L1_2 = "head"
  L2_2 = 0
  L3_2 = true
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = SET_OUTFIT_VALUE
  L1_2 = "mask"
  L2_2 = 215
  L0_2(L1_2, L2_2)
  L0_2 = SET_OUTFIT_VALUE
  L1_2 = "mask"
  L2_2 = 0
  L3_2 = true
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = SET_OUTFIT_VALUE
  L1_2 = "hair"
  L2_2 = 0
  L0_2(L1_2, L2_2)
  L0_2 = SET_OUTFIT_VALUE
  L1_2 = "hair"
  L2_2 = 58
  L3_2 = true
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = SET_OUTFIT_VALUE
  L1_2 = "top"
  L2_2 = 446
  L0_2(L1_2, L2_2)
  L0_2 = SET_OUTFIT_VALUE
  L1_2 = "top"
  L2_2 = 0
  L3_2 = true
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = SET_OUTFIT_VALUE
  L1_2 = "gloves"
  L2_2 = 0
  L0_2(L1_2, L2_2)
  L0_2 = SET_OUTFIT_VALUE
  L1_2 = "gloves"
  L2_2 = 0
  L3_2 = true
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = SET_OUTFIT_VALUE
  L1_2 = "top2"
  L2_2 = -1
  L0_2(L1_2, L2_2)
  L0_2 = SET_OUTFIT_VALUE
  L1_2 = "top2"
  L2_2 = 0
  L3_2 = true
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = SET_OUTFIT_VALUE
  L1_2 = "top3"
  L2_2 = -1
  L0_2(L1_2, L2_2)
  L0_2 = SET_OUTFIT_VALUE
  L1_2 = "top3"
  L2_2 = 0
  L3_2 = true
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = SET_OUTFIT_VALUE
  L1_2 = "parachute"
  L2_2 = 0
  L0_2(L1_2, L2_2)
  L0_2 = SET_OUTFIT_VALUE
  L1_2 = "parachute"
  L2_2 = 0
  L3_2 = true
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = SET_OUTFIT_VALUE
  L1_2 = "pants"
  L2_2 = 160
  L0_2(L1_2, L2_2)
  L0_2 = SET_OUTFIT_VALUE
  L1_2 = "pants"
  L2_2 = 0
  L3_2 = true
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = SET_OUTFIT_VALUE
  L1_2 = "shoes"
  L2_2 = 119
  L0_2(L1_2, L2_2)
  L0_2 = menu
  L0_2 = L0_2.trigger_commands
  L1_2 = "feetvar 0"
  L0_2(L1_2)
  L0_2 = SET_OUTFIT_VALUE
  L1_2 = "accessories"
  L2_2 = -1
  L0_2(L1_2, L2_2)
  L0_2 = SET_OUTFIT_VALUE
  L1_2 = "accessories"
  L2_2 = 0
  L3_2 = true
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = SET_OUTFIT_VALUE
  L1_2 = "decals"
  L2_2 = -1
  L0_2(L1_2, L2_2)
  L0_2 = SET_OUTFIT_VALUE
  L1_2 = "decals"
  L2_2 = 0
  L3_2 = true
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = SET_OUTFIT_VALUE
  L1_2 = "hat"
  L2_2 = 193
  L0_2(L1_2, L2_2)
  L0_2 = SET_OUTFIT_VALUE
  L1_2 = "hat"
  L2_2 = 0
  L3_2 = true
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = SET_OUTFIT_VALUE
  L1_2 = "glasses"
  L2_2 = -1
  L0_2(L1_2, L2_2)
  L0_2 = SET_OUTFIT_VALUE
  L1_2 = "glasses"
  L2_2 = -1
  L3_2 = true
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = SET_OUTFIT_VALUE
  L1_2 = "ears"
  L2_2 = -1
  L0_2(L1_2, L2_2)
  L0_2 = SET_OUTFIT_VALUE
  L1_2 = "ears"
  L2_2 = -1
  L3_2 = true
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = SET_OUTFIT_VALUE
  L1_2 = "watch"
  L2_2 = -1
  L0_2(L1_2, L2_2)
  L0_2 = SET_OUTFIT_VALUE
  L1_2 = "watch"
  L2_2 = -1
  L3_2 = true
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = SET_OUTFIT_VALUE
  L1_2 = "bracelet"
  L2_2 = -1
  L0_2(L1_2, L2_2)
  L0_2 = SET_OUTFIT_VALUE
  L1_2 = "bracelet"
  L2_2 = -1
  L3_2 = true
  L0_2(L1_2, L2_2, L3_2)
end
become_walnuts = L40_1
function L40_1(A0_2)
  local L1_2
  if 0 ~= A0_2 then
  end
end
on_user_change_vehicle = L40_1
L40_1 = 0
function L41_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L0_2 = entities
  L0_2 = L0_2.get_user_vehicle_as_handle
  L0_2 = L0_2()
  L1_2 = L40_1
  if L1_2 ~= L0_2 and 0 ~= L0_2 then
    L1_2 = on_user_change_vehicle
    L2_2 = L0_2
    L1_2(L2_2)
    L40_1 = L0_2
  end
  L1_2 = renderscorched
  if L1_2 and 0 ~= L0_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.SET_ENTITY_RENDER_SCORCHED
    L2_2 = L0_2
    L3_2 = true
    L1_2(L2_2, L3_2)
  end
  L1_2 = walkonwater
  if not L1_2 then
    L1_2 = driveonwater
    if not L1_2 then
      L1_2 = driveonair
      if not L1_2 then
        goto lbl_75
      end
    end
  end
  L1_2 = dow_block
  if 0 ~= L1_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.DOES_ENTITY_EXIST
    L2_2 = dow_block
    L1_2 = L1_2(L2_2)
    if L1_2 then
      goto lbl_75
    end
  end
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "stt_prop_stunt_bblock_mdm3"
  L1_2 = L1_2(L2_2)
  L2_2 = request_model
  L3_2 = L1_2
  L2_2(L3_2)
  L2_2 = {}
  L2_2.x = 0
  L2_2.y = 0
  L2_2.z = 0
  L3_2 = OBJECT
  L3_2 = L3_2.CREATE_OBJECT_NO_OFFSET
  L4_2 = L1_2
  L5_2 = L2_2.x
  L6_2 = L2_2.y
  L7_2 = L2_2.z
  L8_2 = true
  L9_2 = false
  L10_2 = false
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  dow_block = L3_2
  L3_2 = ENTITY
  L3_2 = L3_2.SET_ENTITY_ALPHA
  L4_2 = dow_block
  L5_2 = 0
  L3_2(L4_2, L5_2)
  L3_2 = ENTITY
  L3_2 = L3_2.SET_ENTITY_VISIBLE
  L4_2 = dow_block
  L5_2 = false
  L6_2 = 0
  L3_2(L4_2, L5_2, L6_2)
  ::lbl_75::
  L1_2 = dow_block
  if 0 ~= L1_2 then
    L1_2 = walkonwater
    if not L1_2 then
      L1_2 = driveonwater
      if not L1_2 then
        L1_2 = driveonair
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
  L1_2 = walkonwater
  if L1_2 then
    L1_2 = PED
    L1_2 = L1_2.GET_VEHICLE_PED_IS_IN
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = false
    L1_2 = L1_2(L2_2, L3_2)
    vehicle = L1_2
    L1_2 = ENTITY
    L1_2 = L1_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = 0.0
    L4_2 = 2.0
    L5_2 = 0.0
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2)
    L2_2 = memory
    L2_2 = L2_2.alloc
    L3_2 = 4
    L2_2 = L2_2(L3_2)
    L3_2 = WATER
    L3_2 = L3_2.GET_WATER_HEIGHT
    L4_2 = L1_2.x
    L5_2 = L1_2.y
    L6_2 = L1_2.z
    L7_2 = L2_2
    L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
    if L3_2 then
      L3_2 = ENTITY
      L3_2 = L3_2.SET_ENTITY_COORDS_NO_OFFSET
      L4_2 = dow_block
      L5_2 = L1_2.x
      L6_2 = L1_2.y
      L7_2 = memory
      L7_2 = L7_2.read_float
      L8_2 = L2_2
      L7_2 = L7_2(L8_2)
      L8_2 = false
      L9_2 = false
      L10_2 = false
      L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
      L3_2 = ENTITY
      L3_2 = L3_2.SET_ENTITY_HEADING
      L4_2 = dow_block
      L5_2 = ENTITY
      L5_2 = L5_2.GET_ENTITY_HEADING
      L6_2 = PLAYER
      L6_2 = L6_2.PLAYER_PED_ID
      L6_2, L7_2, L8_2, L9_2, L10_2 = L6_2()
      L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
      L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
    end
  end
  L1_2 = driveonwater
  if L1_2 then
    if 0 ~= L0_2 then
      L1_2 = ENTITY
      L1_2 = L1_2.GET_ENTITY_COORDS
      L2_2 = L0_2
      L3_2 = true
      L1_2 = L1_2(L2_2, L3_2)
      L2_2 = memory
      L2_2 = L2_2.alloc
      L3_2 = 4
      L2_2 = L2_2(L3_2)
      L3_2 = WATER
      L3_2 = L3_2.GET_WATER_HEIGHT
      L4_2 = L1_2.x
      L5_2 = L1_2.y
      L6_2 = L1_2.z
      L7_2 = L2_2
      L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
      if L3_2 then
        L3_2 = ENTITY
        L3_2 = L3_2.SET_ENTITY_COORDS_NO_OFFSET
        L4_2 = dow_block
        L5_2 = L1_2.x
        L6_2 = L1_2.y
        L7_2 = memory
        L7_2 = L7_2.read_float
        L8_2 = L2_2
        L7_2 = L7_2(L8_2)
        L8_2 = false
        L9_2 = false
        L10_2 = false
        L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
        L3_2 = ENTITY
        L3_2 = L3_2.SET_ENTITY_HEADING
        L4_2 = dow_block
        L5_2 = ENTITY
        L5_2 = L5_2.GET_ENTITY_HEADING
        L6_2 = L0_2
        L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L5_2(L6_2)
        L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
      end
    else
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
  L1_2 = driveonair
  if L1_2 and 0 ~= L0_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.GET_ENTITY_COORDS
    L2_2 = L0_2
    L3_2 = true
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = ENTITY
    L2_2 = L2_2.GET_ENTITY_COORDS
    L3_2 = dow_block
    L4_2 = true
    L2_2 = L2_2(L3_2, L4_2)
    L3_2 = MISC
    L3_2 = L3_2.GET_DISTANCE_BETWEEN_COORDS
    L4_2 = L1_2.x
    L5_2 = L1_2.y
    L6_2 = L1_2.z
    L7_2 = L2_2.x
    L8_2 = L2_2.y
    L9_2 = L2_2.z
    L10_2 = true
    L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
    if L3_2 >= 5 then
      L3_2 = ENTITY
      L3_2 = L3_2.SET_ENTITY_COORDS_NO_OFFSET
      L4_2 = dow_block
      L5_2 = L1_2.x
      L6_2 = L1_2.y
      L7_2 = doa_ht
      L8_2 = false
      L9_2 = false
      L10_2 = false
      L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
      L3_2 = ENTITY
      L3_2 = L3_2.SET_ENTITY_HEADING
      L4_2 = dow_block
      L5_2 = ENTITY
      L5_2 = L5_2.GET_ENTITY_HEADING
      L6_2 = car_hdl
      L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L5_2(L6_2)
      L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
    end
    L3_2 = PAD
    L3_2 = L3_2.IS_CONTROL_PRESSED
    L4_2 = 0
    L5_2 = 22
    L3_2 = L3_2(L4_2, L5_2)
    if L3_2 then
      L3_2 = doa_ht
      L3_2 = L3_2 + 0.1
      doa_ht = L3_2
      L3_2 = ENTITY
      L3_2 = L3_2.SET_ENTITY_COORDS_NO_OFFSET
      L4_2 = dow_block
      L5_2 = L1_2.x
      L6_2 = L1_2.y
      L7_2 = doa_ht
      L8_2 = false
      L9_2 = false
      L10_2 = false
      L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
      L3_2 = ENTITY
      L3_2 = L3_2.SET_ENTITY_COORDS
      L4_2 = L0_2
      L5_2 = L1_2.x
      L6_2 = L1_2.y
      L7_2 = doa_ht
      L7_2 = L7_2 + 1
      L8_2 = false
      L9_2 = false
      L10_2 = false
      L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
      L3_2 = ENTITY
      L3_2 = L3_2.SET_ENTITY_HEADING
      L4_2 = dow_block
      L5_2 = ENTITY
      L5_2 = L5_2.GET_ENTITY_HEADING
      L6_2 = car_hdl
      L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L5_2(L6_2)
      L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
    end
    L3_2 = PAD
    L3_2 = L3_2.IS_CONTROL_PRESSED
    L4_2 = 0
    L5_2 = 36
    L3_2 = L3_2(L4_2, L5_2)
    if L3_2 then
      L3_2 = doa_ht
      L3_2 = L3_2 - 0.1
      doa_ht = L3_2
      L3_2 = ENTITY
      L3_2 = L3_2.SET_ENTITY_COORDS_NO_OFFSET
      L4_2 = dow_block
      L5_2 = L1_2.x
      L6_2 = L1_2.y
      L7_2 = doa_ht
      L8_2 = false
      L9_2 = false
      L10_2 = false
      L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
      L3_2 = ENTITY
      L3_2 = L3_2.SET_ENTITY_COORDS
      L4_2 = L0_2
      L5_2 = L1_2.x
      L6_2 = L1_2.y
      L7_2 = doa_ht
      L7_2 = L7_2 + 1
      L8_2 = false
      L9_2 = false
      L10_2 = false
      L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
      L3_2 = ENTITY
      L3_2 = L3_2.SET_ENTITY_HEADING
      L4_2 = dow_block
      L5_2 = ENTITY
      L5_2 = L5_2.GET_ENTITY_HEADING
      L6_2 = car_hdl
      L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L5_2(L6_2)
      L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
    end
  end
end
all_drive_style = L41_1
function L41_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2
  L3_2 = memory
  L3_2 = L3_2.scan
  L4_2 = A1_2
  L3_2 = L3_2(L4_2)
  L4_2 = assert
  L5_2 = NULL
  L5_2 = L3_2 ~= L5_2
  L6_2 = "内存扫描失败： "
  L7_2 = A0_2
  L6_2 = L6_2 .. L7_2
  L4_2(L5_2, L6_2)
  L4_2 = A2_2
  L5_2 = L3_2
  L4_2(L5_2)
end
memoryScan = L41_1
L41_1 = memoryScan
L42_1 = "GetNetGamePlayer"
L43_1 = "48 83 EC ? 33 C0 38 05 ? ? ? ? 74 ? 83 F9"
function L44_1(A0_2)
  local L1_2
  GetNetGamePlayer_addr = A0_2
end
L41_1(L42_1, L43_1, L44_1)
function L41_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = util
  L1_2 = L1_2.call_foreign_function
  L2_2 = GetNetGamePlayer_addr
  L3_2 = A0_2
  return L1_2(L2_2, L3_2)
end
GetNetGamePlayer = L41_1
function L41_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = CAM
  L1_2 = L1_2.GET_GAMEPLAY_CAM_ROT
  L2_2 = 0
  L1_2 = L1_2(L2_2)
  L2_2 = L1_2
  L1_2 = L1_2.toDir
  L1_2 = L1_2(L2_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_FORWARD_VECTOR
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = 0.0
  L2_2.z = 0.0
  L1_2.z = L3_2
  L3_2 = math
  L3_2 = L3_2.acos
  L5_2 = L2_2
  L4_2 = L2_2.dot
  L6_2 = L1_2
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = #L1_2
  L6_2 = #L2_2
  L5_2 = L5_2 * L6_2
  L4_2 = L4_2 / L5_2
  L3_2 = L3_2(L4_2)
  L4_2 = math
  L4_2 = L4_2.deg
  L5_2 = L3_2
  return L4_2(L5_2)
end
function L42_1(A0_2, A1_2, A2_2, A3_2, A4_2, A5_2, A6_2, A7_2, A8_2)
  local L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2
  L9_2 = v3
  L9_2 = L9_2.new
  L9_2 = L9_2()
  L10_2 = v3
  L10_2 = L10_2.new
  L10_2 = L10_2()
  L11_2 = nil
  L12_2 = MISC
  L12_2 = L12_2.GET_MODEL_DIMENSIONS
  L13_2 = ENTITY
  L13_2 = L13_2.GET_ENTITY_MODEL
  L14_2 = A0_2
  L13_2 = L13_2(L14_2)
  L14_2 = L9_2
  L15_2 = L10_2
  L12_2(L13_2, L14_2, L15_2)
  if 0 == A8_2 then
    L12_2 = v3
    L12_2 = L12_2.new
    L13_2 = L9_2.x
    L14_2 = L10_2.y
    L14_2 = L14_2 + 0.25
    L15_2 = 0.3
    L12_2 = L12_2(L13_2, L14_2, L15_2)
    L11_2 = L12_2
  elseif 1 == A8_2 then
    L12_2 = v3
    L12_2 = L12_2.new
    L13_2 = L9_2.x
    L14_2 = L9_2.y
    L15_2 = 0.3
    L12_2 = L12_2(L13_2, L14_2, L15_2)
    L11_2 = L12_2
  elseif 2 == A8_2 then
    L12_2 = v3
    L12_2 = L12_2.new
    L13_2 = L10_2.x
    L14_2 = L10_2.y
    L14_2 = L14_2 + 0.25
    L15_2 = 0.3
    L12_2 = L12_2(L13_2, L14_2, L15_2)
    L11_2 = L12_2
  elseif 3 == A8_2 then
    L12_2 = v3
    L12_2 = L12_2.new
    L13_2 = L10_2.x
    L14_2 = L9_2.y
    L15_2 = 0.3
    L12_2 = L12_2(L13_2, L14_2, L15_2)
    L11_2 = L12_2
  else
    L12_2 = error
    L13_2 = "得到了意想不到的位置"
    L12_2(L13_2)
  end
  L12_2 = ENTITY
  L12_2 = L12_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L13_2 = A0_2
  L14_2 = L11_2.x
  L15_2 = L11_2.y
  L16_2 = L11_2.z
  L12_2 = L12_2(L13_2, L14_2, L15_2, L16_2)
  L13_2 = ENTITY
  L13_2 = L13_2.GET_ENTITY_ROTATION
  L14_2 = A0_2
  L15_2 = 2
  L13_2 = L13_2(L14_2, L15_2)
  L14_2 = L13_2
  L13_2 = L13_2.toDir
  L13_2 = L13_2(L14_2)
  L14_2 = L41_1
  L15_2 = A0_2
  L14_2 = L14_2(L15_2)
  if L14_2 > 95.0 then
    L15_2 = L13_2
    L14_2 = L13_2.mul
    L16_2 = -1
    L14_2(L15_2, L16_2)
  end
  L14_2 = v3
  L14_2 = L14_2.new
  L15_2 = L13_2
  L14_2 = L14_2(L15_2)
  L16_2 = L14_2
  L15_2 = L14_2.mul
  L17_2 = 300.0
  L15_2(L16_2, L17_2)
  L16_2 = L14_2
  L15_2 = L14_2.add
  L17_2 = L12_2
  L15_2(L16_2, L17_2)
  L15_2 = MISC
  L16_2 = "SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY_NEW"
  L15_2 = L15_2[L16_2]
  L16_2 = L12_2.x
  L17_2 = L12_2.y
  L18_2 = L12_2.z
  L19_2 = L14_2.x
  L20_2 = L14_2.y
  L21_2 = L14_2.z
  L22_2 = A1_2
  L23_2 = true
  L24_2 = A2_2
  L25_2 = A3_2
  L26_2 = A4_2
  L27_2 = not A5_2
  L28_2 = A6_2
  L29_2 = A0_2
  L30_2 = false
  L31_2 = false
  L32_2 = A7_2
  L33_2 = false
  L34_2 = 0
  L35_2 = 0
  L36_2 = 0
  L15_2(L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2)
end
function L43_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L0_2 = PED
  L0_2 = L0_2.IS_PED_IN_ANY_VEHICLE
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = false
  L0_2 = L0_2(L1_2, L2_2)
  if L0_2 then
    L0_2 = get_vehicle_player_is_in
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_ID
    L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L1_2()
    L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
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
    L3_2 = ENTITY
    L3_2 = L3_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
    L4_2 = L0_2
    L5_2 = L1_2.x
    L6_2 = L2_2.y
    L7_2 = 0.0
    L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
    L4_2 = ENTITY
    L4_2 = L4_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
    L5_2 = L0_2
    L6_2 = L1_2.x
    L7_2 = L2_2.y
    L7_2 = L7_2 + 25.0
    L8_2 = 0.0
    L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
    L5_2 = GRAPHICS
    L5_2 = L5_2.DRAW_LINE
    L6_2 = L3_2.x
    L7_2 = L3_2.y
    L8_2 = L3_2.z
    L9_2 = L4_2.x
    L10_2 = L4_2.y
    L11_2 = L4_2.z
    L12_2 = 255
    L13_2 = 0
    L14_2 = 0
    L15_2 = 150
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
    L5_2 = ENTITY
    L5_2 = L5_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
    L6_2 = L0_2
    L7_2 = L2_2.x
    L8_2 = L2_2.y
    L9_2 = 0.0
    L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
    L6_2 = ENTITY
    L6_2 = L6_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
    L7_2 = L0_2
    L8_2 = L2_2.x
    L9_2 = L2_2.y
    L9_2 = L9_2 + 25.0
    L10_2 = 0
    L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
    L7_2 = GRAPHICS
    L7_2 = L7_2.DRAW_LINE
    L8_2 = L5_2.x
    L9_2 = L5_2.y
    L10_2 = L5_2.z
    L11_2 = L6_2.x
    L12_2 = L6_2.y
    L13_2 = L6_2.z
    L14_2 = 255
    L15_2 = 0
    L16_2 = 0
    L17_2 = 150
    L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  end
end
vehlaser = L43_1
L43_1 = {}
L43_1.modelName = ""
L43_1.timeBetweenShots = 0
VehicleWeapon = L43_1
L43_1 = VehicleWeapon
L44_1 = VehicleWeapon
L43_1.__index = L44_1
L43_1 = VehicleWeapon
function L44_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2
  L2_2 = setmetatable
  L3_2 = {}
  L4_2 = VehicleWeapon
  L2_2 = L2_2(L3_2, L4_2)
  L2_2.modelName = A0_2
  L2_2.timeBetweenShots = A1_2
  return L2_2
end
L43_1.new = L44_1
L43_1 = {}
L44_1 = VehicleWeapon
L44_1 = L44_1.new
L45_1 = "weapon_vehicle_rocket"
L46_1 = 220
L44_1 = L44_1(L45_1, L46_1)
L45_1 = VehicleWeapon
L45_1 = L45_1.new
L46_1 = "weapon_raypistol"
L47_1 = 50
L45_1 = L45_1(L46_1, L47_1)
L46_1 = VehicleWeapon
L46_1 = L46_1.new
L47_1 = "weapon_firework"
L48_1 = 220
L46_1 = L46_1(L47_1, L48_1)
L47_1 = VehicleWeapon
L47_1 = L47_1.new
L48_1 = "vehicle_weapon_tank"
L49_1 = 220
L47_1 = L47_1(L48_1, L49_1)
L48_1 = VehicleWeapon
L48_1 = L48_1.new
L49_1 = "vehicle_weapon_player_lazer"
L50_1 = 30
L48_1, L49_1, L50_1, L51_1, L52_1, L53_1, L54_1, L55_1, L56_1, L57_1, L58_1, L59_1, L60_1, L61_1, L62_1, L63_1, L64_1, L65_1, L66_1, L67_1, L68_1, L69_1, L70_1, L71_1, L72_1, L73_1, L74_1, L75_1, L76_1, L77_1, L78_1, L79_1, L80_1, L81_1, L82_1, L83_1, L84_1, L85_1, L86_1, L87_1, L88_1, L89_1, L90_1, L91_1, L92_1, L93_1, L94_1, L95_1, L96_1, L97_1, L98_1, L99_1, L100_1, L101_1, L102_1, L103_1, L104_1, L105_1, L106_1, L107_1, L108_1, L109_1, L110_1, L111_1, L112_1, L113_1, L114_1, L115_1, L116_1, L117_1, L118_1, L119_1, L120_1, L121_1, L122_1 = L48_1(L49_1, L50_1)
L43_1[1] = L44_1
L43_1[2] = L45_1
L43_1[3] = L46_1
L43_1[4] = L47_1
L43_1[5] = L48_1
L43_1[6] = L49_1
L43_1[7] = L50_1
L43_1[8] = L51_1
L43_1[9] = L52_1
L43_1[10] = L53_1
L43_1[11] = L54_1
L43_1[12] = L55_1
L43_1[13] = L56_1
L43_1[14] = L57_1
L43_1[15] = L58_1
L43_1[16] = L59_1
L43_1[17] = L60_1
L43_1[18] = L61_1
L43_1[19] = L62_1
L43_1[20] = L63_1
L43_1[21] = L64_1
L43_1[22] = L65_1
L43_1[23] = L66_1
L43_1[24] = L67_1
L43_1[25] = L68_1
L43_1[26] = L69_1
L43_1[27] = L70_1
L43_1[28] = L71_1
L43_1[29] = L72_1
L43_1[30] = L73_1
L43_1[31] = L74_1
L43_1[32] = L75_1
L43_1[33] = L76_1
L43_1[34] = L77_1
L43_1[35] = L78_1
L43_1[36] = L79_1
L43_1[37] = L80_1
L43_1[38] = L81_1
L43_1[39] = L82_1
L43_1[40] = L83_1
L43_1[41] = L84_1
L43_1[42] = L85_1
L43_1[43] = L86_1
L43_1[44] = L87_1
L43_1[45] = L88_1
L43_1[46] = L89_1
L43_1[47] = L90_1
L43_1[48] = L91_1
L43_1[49] = L92_1
L43_1[50] = L93_1
L43_1[51] = L94_1
L43_1[52] = L95_1
L43_1[53] = L96_1
L43_1[54] = L97_1
L43_1[55] = L98_1
L43_1[56] = L99_1
L43_1[57] = L100_1
L43_1[58] = L101_1
L43_1[59] = L102_1
L43_1[60] = L103_1
L43_1[61] = L104_1
L43_1[62] = L105_1
L43_1[63] = L106_1
L43_1[64] = L107_1
L43_1[65] = L108_1
L43_1[66] = L109_1
L43_1[67] = L110_1
L43_1[68] = L111_1
L43_1[69] = L112_1
L43_1[70] = L113_1
L43_1[71] = L114_1
L43_1[72] = L115_1
L43_1[73] = L116_1
L43_1[74] = L117_1
L43_1[75] = L118_1
L43_1[76] = L119_1
L43_1[77] = L120_1
L43_1[78] = L121_1
L43_1[79] = L122_1
vehicleWeaponList = L43_1
L43_1 = _ENV
L44_1 = "Imputs_vehweapon"
L45_1 = {}
L46_1 = "INPUT_JUMP"
L47_1 = {}
L48_1 = "Spacebar; X"
L49_1 = 22
L47_1[1] = L48_1
L47_1[2] = L49_1
L45_1[L46_1] = L47_1
L46_1 = "INPUT_VEH_ATTACK"
L47_1 = {}
L48_1 = "Mouse L; RB"
L49_1 = 69
L47_1[1] = L48_1
L47_1[2] = L49_1
L45_1[L46_1] = L47_1
L46_1 = "INPUT_VEH_AIM"
L47_1 = {}
L48_1 = "Mouse R; LB"
L49_1 = 68
L47_1[1] = L48_1
L47_1[2] = L49_1
L45_1[L46_1] = L47_1
L46_1 = "INPUT_VEH_DUCK"
L47_1 = {}
L48_1 = "X; A"
L49_1 = 73
L47_1[1] = L48_1
L47_1[2] = L49_1
L45_1[L46_1] = L47_1
L46_1 = "INPUT_VEH_HORN"
L47_1 = {}
L48_1 = "E; L3"
L49_1 = 86
L47_1[1] = L48_1
L47_1[2] = L49_1
L45_1[L46_1] = L47_1
L46_1 = "INPUT_VEH_CINEMATIC_UP_ONLY"
L47_1 = {}
L48_1 = "Numpad +; none"
L49_1 = 96
L47_1[1] = L48_1
L47_1[2] = L49_1
L45_1[L46_1] = L47_1
L46_1 = "INPUT_VEH_CINEMATIC_DOWN_ONLY"
L47_1 = {}
L48_1 = "Numpad -; none"
L49_1 = 97
L47_1[1] = L48_1
L47_1[2] = L49_1
L45_1[L46_1] = L47_1
L43_1[L44_1] = L45_1
L43_1 = _ENV
L44_1 = "trans_plane"
L45_1 = {}
L46_1 = "AirstrikeAircraft"
L47_1 = "按 ~%s~ 以使用空袭飞机"
L45_1[L46_1] = L47_1
L46_1 = "Keyboard"
L47_1 = "键盘"
L45_1[L46_1] = L47_1
L46_1 = "Controller"
L47_1 = "手柄"
L45_1[L46_1] = L47_1
L46_1 = "VehicleWeapons"
L47_1 = "按 ~%s~ 使用载具武器"
L45_1[L46_1] = L47_1
L43_1[L44_1] = L45_1
L43_1 = 0
L44_1 = "按 ~%s~ 使用载具武器"
L45_1 = _ENV
L46_1 = "vehweapon_veh"
function L47_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L0_2 = Config
  L0_2 = L0_2.controls
  L0_2 = L0_2.vehicleweapons
  L1_2 = L43_1
  if 0 ~= L1_2 then
    L1_2 = timer
    L1_2 = L1_2.elapsed
    L1_2 = L1_2()
    L2_2 = 120000
    if not (L1_2 > L2_2) then
      goto lbl_34
    end
  end
  L1_2 = table
  L1_2 = L1_2.find_if
  L2_2 = Imputs_vehweapon
  function L3_2(A0_3, A1_3)
    local L2_3, L3_3
    L2_3 = A1_3[2]
    L3_3 = L0_2
    L2_3 = L2_3 == L3_3
    return L2_3
  end
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = assert
  L3_2 = L1_2
  L4_2 = "未找到控件名称"
  L2_2(L3_2, L4_2)
  L2_2 = util
  L2_2 = L2_2.show_corner_help
  L3_2 = L44_1
  L4_2 = L3_2
  L3_2 = L3_2.format
  L5_2 = L1_2
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L3_2(L4_2, L5_2)
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L2_2 = 1
  L43_1 = L2_2
  L2_2 = timer
  L2_2 = L2_2.reset
  L2_2()
  ::lbl_34::
  L1_2 = vehicleWeaponList
  L2_2 = L25_1
  L1_2 = L1_2[L2_2]
  L2_2 = get_vehicle_player_is_in
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_ID
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L3_2()
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L3_2 = util
  L3_2 = L3_2.joaat
  L4_2 = L1_2.modelName
  L3_2 = L3_2(L4_2)
  L4_2 = request_weapon_asset
  L5_2 = L3_2
  L4_2(L5_2)
  L4_2 = ENTITY
  L4_2 = L4_2.DOES_ENTITY_EXIST
  L5_2 = L2_2
  L4_2 = L4_2(L5_2)
  if L4_2 then
    L4_2 = PAD
    L4_2 = L4_2.IS_CONTROL_PRESSED
    L5_2 = 0
    L6_2 = L0_2
    L4_2 = L4_2(L5_2, L6_2)
    if L4_2 then
      L4_2 = timer
      L4_2 = L4_2.elapsed
      L4_2 = L4_2()
      L5_2 = L1_2.timeBetweenShots
      if not (L4_2 < L5_2) then
        goto lbl_70
      end
    end
  end
  do return end
  goto lbl_134
  ::lbl_70::
  L4_2 = L41_1
  L5_2 = L2_2
  L4_2 = L4_2(L5_2)
  if L4_2 < 95.0 then
    L4_2 = L42_1
    L5_2 = L2_2
    L6_2 = 200
    L7_2 = L3_2
    L8_2 = PLAYER
    L8_2 = L8_2.PLAYER_PED_ID
    L8_2 = L8_2()
    L9_2 = true
    L10_2 = true
    L11_2 = 2000.0
    L12_2 = 0
    L13_2 = 0
    L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
    L4_2 = L42_1
    L5_2 = L2_2
    L6_2 = 200
    L7_2 = L3_2
    L8_2 = PLAYER
    L8_2 = L8_2.PLAYER_PED_ID
    L8_2 = L8_2()
    L9_2 = true
    L10_2 = true
    L11_2 = 2000.0
    L12_2 = 0
    L13_2 = 2
    L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
    L4_2 = timer
    L4_2 = L4_2.reset
    L4_2()
  else
    L4_2 = L42_1
    L5_2 = L2_2
    L6_2 = 200
    L7_2 = L3_2
    L8_2 = PLAYER
    L8_2 = L8_2.PLAYER_PED_ID
    L8_2 = L8_2()
    L9_2 = true
    L10_2 = true
    L11_2 = 2000.0
    L12_2 = 0
    L13_2 = 1
    L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
    L4_2 = L42_1
    L5_2 = L2_2
    L6_2 = 200
    L7_2 = L3_2
    L8_2 = PLAYER
    L8_2 = L8_2.PLAYER_PED_ID
    L8_2 = L8_2()
    L9_2 = true
    L10_2 = true
    L11_2 = 2000.0
    L12_2 = 0
    L13_2 = 3
    L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
    L4_2 = timer
    L4_2 = L4_2.reset
    L4_2()
  end
  ::lbl_134::
end
L45_1[L46_1] = L47_1
L45_1 = _ENV
L46_1 = "setvehweapon"
function L47_1(A0_2)
  local L1_2
  L25_1 = A0_2
end
L45_1[L46_1] = L47_1
L45_1 = _ENV
L46_1 = "lsdweap"
L47_1 = {}
L48_1 = "邪恶冥王"
L49_1 = "原子能枪"
L47_1[1] = L48_1
L47_1[2] = L49_1
L45_1[L46_1] = L47_1
L45_1 = _ENV
L46_1 = "lsdh"
L47_1 = {}
L48_1 = "weapon_raycarbine"
L49_1 = "weapon_raypistol"
L47_1[1] = L48_1
L47_1[2] = L49_1
L45_1[L46_1] = L47_1
L45_1 = _ENV
L46_1 = "lsd"
L47_1 = {}
L48_1 = "weap"
L49_1 = "WEAPON_RAYCARBINE"
L47_1[L48_1] = L49_1
L48_1 = "hash"
L49_1 = _ENV
L50_1 = "util"
L49_1 = L49_1[L50_1]
L49_1 = L49_1.joaat
L50_1 = "dune2"
L49_1 = L49_1(L50_1)
L47_1[L48_1] = L49_1
L45_1[L46_1] = L47_1
function L45_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = CAM
  L1_2 = L1_2.GET_GAMEPLAY_CAM_ROT
  L2_2 = 0
  L1_2 = L1_2(L2_2)
  L2_2 = L1_2
  L1_2 = L1_2.toDir
  L1_2 = L1_2(L2_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_FORWARD_VECTOR
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = 0.0
  L2_2.z = 0.0
  L1_2.z = L3_2
  L3_2 = math
  L3_2 = L3_2.acos
  L5_2 = L2_2
  L4_2 = L2_2.dot
  L6_2 = L1_2
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = #L1_2
  L6_2 = #L2_2
  L5_2 = L5_2 * L6_2
  L4_2 = L4_2 / L5_2
  L3_2 = L3_2(L4_2)
  L4_2 = math
  L4_2 = L4_2.deg
  L5_2 = L3_2
  return L4_2(L5_2)
end
L41_1 = L45_1
L45_1 = _ENV
L46_1 = "SFlsd"
function L47_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
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
  L0_2 = L0_2.SET_DATA_SLOT
  L1_2 = 0
  L2_2 = PAD
  L2_2 = L2_2.GET_CONTROL_INSTRUCTIONAL_BUTTONS_STRING
  L3_2 = 0
  L4_2 = 86
  L5_2 = true
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = "镭射"
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = sf
  L0_2 = L0_2.DRAW_INSTRUCTIONAL_BUTTONS
  L0_2()
  L0_2 = sf
  L1_2 = L0_2
  L0_2 = L0_2.draw_fullscreen
  L0_2(L1_2)
end
L45_1[L46_1] = L47_1
L45_1 = _ENV
L46_1 = "Vmod"
function L47_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L2_2 = VEHICLE
  L2_2 = L2_2.SET_VEHICLE_FIXED
  L3_2 = A0_2
  L2_2(L3_2)
  L2_2 = 0
  L3_2 = 49
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = VEHICLE
    L6_2 = L6_2.GET_NUM_VEHICLE_MODS
    L7_2 = A0_2
    L8_2 = L5_2
    L6_2 = L6_2(L7_2, L8_2)
    L7_2 = VEHICLE
    L7_2 = L7_2.SET_VEHICLE_MOD
    L8_2 = A0_2
    L9_2 = L5_2
    L10_2 = L6_2 - 1
    L11_2 = false
    L7_2(L8_2, L9_2, L10_2, L11_2)
    L7_2 = VEHICLE
    L7_2 = L7_2.SET_VEHICLE_NUMBER_PLATE_TEXT
    L8_2 = A0_2
    L9_2 = A1_2
    L7_2(L8_2, L9_2)
    L7_2 = VEHICLE
    L7_2 = L7_2.GET_VEHICLE_MOD_KIT
    L8_2 = A0_2
    L9_2 = 0
    L7_2(L8_2, L9_2)
    L7_2 = VEHICLE
    L7_2 = L7_2.SET_VEHICLE_MOD_KIT
    L8_2 = A0_2
    L9_2 = 0
    L7_2(L8_2, L9_2)
    L7_2 = VEHICLE
    L7_2 = L7_2.SET_VEHICLE_MOD
    L8_2 = A0_2
    L9_2 = 14
    L10_2 = 0
    L7_2(L8_2, L9_2, L10_2)
    L7_2 = VEHICLE
    L7_2 = L7_2.TOGGLE_VEHICLE_MOD
    L8_2 = A0_2
    L9_2 = 22
    L10_2 = true
    L7_2(L8_2, L9_2, L10_2)
    L7_2 = VEHICLE
    L7_2 = L7_2.TOGGLE_VEHICLE_MOD
    L8_2 = A0_2
    L9_2 = 18
    L10_2 = true
    L7_2(L8_2, L9_2, L10_2)
    L7_2 = VEHICLE
    L7_2 = L7_2.TOGGLE_VEHICLE_MOD
    L8_2 = A0_2
    L9_2 = 20
    L10_2 = true
    L7_2(L8_2, L9_2, L10_2)
    L7_2 = VEHICLE
    L7_2 = L7_2.SET_VEHICLE_TYRE_SMOKE_COLOR
    L8_2 = A0_2
    L9_2 = 0
    L10_2 = 0
    L11_2 = 0
    L7_2(L8_2, L9_2, L10_2, L11_2)
    L7_2 = VEHICLE
    L7_2 = L7_2.SET_VEHICLE_MAX_SPEED
    L8_2 = A0_2
    L9_2 = 100
    L7_2(L8_2, L9_2)
    L7_2 = VEHICLE
    L7_2 = L7_2.MODIFY_VEHICLE_TOP_SPEED
    L8_2 = A0_2
    L9_2 = 40
    L7_2(L8_2, L9_2)
    L7_2 = VEHICLE
    L7_2 = L7_2.SET_VEHICLE_BURNOUT
    L8_2 = A0_2
    L9_2 = false
    L7_2(L8_2, L9_2)
  end
end
L45_1[L46_1] = L47_1
L45_1 = _ENV
L46_1 = "Magic_Warhorse_W"
function L47_1(A0_2)
  local L1_2, L2_2
  L1_2 = lsd
  L2_2 = lsdh
  L2_2 = L2_2[A0_2]
  L1_2.weap = L2_2
end
L45_1[L46_1] = L47_1
L45_1 = _ENV
L46_1 = "SDcreate"
function L47_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L2_2 = VEHICLE
  L2_2 = L2_2.CREATE_VEHICLE
  L3_2 = lsd
  L3_2 = L3_2.hash
  L4_2 = A0_2.x
  L5_2 = A0_2.y
  L6_2 = A0_2.z
  L7_2 = 0
  L8_2 = true
  L9_2 = true
  L10_2 = false
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  Lsdcar = L2_2
  L2_2 = PED
  L2_2 = L2_2.SET_PED_INTO_VEHICLE
  L3_2 = A1_2
  L4_2 = Lsdcar
  L5_2 = -1
  L2_2(L3_2, L4_2, L5_2)
  L2_2 = Vmod
  L3_2 = Lsdcar
  L4_2 = "镭射"
  L2_2(L3_2, L4_2)
  L2_2 = CAM
  L2_2 = L2_2.GET_GAMEPLAY_CAM_RELATIVE_HEADING
  L2_2 = L2_2()
  L3_2 = ENTITY
  L3_2 = L3_2.SET_ENTITY_HEADING
  L4_2 = Lsdcar
  L5_2 = L2_2
  L3_2(L4_2, L5_2)
  L3_2 = util
  L3_2 = L3_2.create_tick_handler
  function L4_2()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = PED
    L0_3 = L0_3.IS_PED_IN_VEHICLE
    L1_3 = PLAYER
    L1_3 = L1_3.PLAYER_PED_ID
    L1_3 = L1_3()
    L2_3 = Lsdcar
    L3_3 = false
    L0_3 = L0_3(L1_3, L2_3, L3_3)
    if true == L0_3 then
      L0_3 = VEHICLE
      L0_3 = L0_3.SET_VEHICLE_DIRT_LEVEL
      L1_3 = Lsdcar
      L2_3 = 0
      L0_3(L1_3, L2_3)
      L0_3 = ENTITY
      L0_3 = L0_3.SET_ENTITY_INVINCIBLE
      L1_3 = Lsdcar
      L2_3 = true
      L0_3(L1_3, L2_3)
      L0_3 = VEHICLE
      L0_3 = L0_3.SET_VEHICLE_CAN_BE_VISIBLY_DAMAGED
      L1_3 = Lsdcar
      L2_3 = false
      L0_3(L1_3, L2_3)
      L0_3 = SFlsd
      L0_3()
    end
  end
  L3_2(L4_2)
end
L45_1[L46_1] = L47_1
function L45_1(A0_2, A1_2, A2_2, A3_2, A4_2, A5_2, A6_2, A7_2, A8_2)
  local L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2
  L9_2 = v3
  L9_2 = L9_2.new
  L9_2 = L9_2()
  L10_2 = v3
  L10_2 = L10_2.new
  L10_2 = L10_2()
  L11_2 = nil
  L12_2 = MISC
  L12_2 = L12_2.GET_MODEL_DIMENSIONS
  L13_2 = ENTITY
  L13_2 = L13_2.GET_ENTITY_MODEL
  L14_2 = A0_2
  L13_2 = L13_2(L14_2)
  L14_2 = L9_2
  L15_2 = L10_2
  L12_2(L13_2, L14_2, L15_2)
  if 0 == A8_2 then
    L12_2 = v3
    L12_2 = L12_2.new
    L13_2 = L9_2.x
    L13_2 = L13_2 + 0.3
    L14_2 = L10_2.y
    L14_2 = L14_2 + 0.25
    L15_2 = 0.5
    L12_2 = L12_2(L13_2, L14_2, L15_2)
    L11_2 = L12_2
  elseif 1 == A8_2 then
    L12_2 = v3
    L12_2 = L12_2.new
    L13_2 = L9_2.x
    L13_2 = L13_2 + 0.3
    L14_2 = L9_2.y
    L14_2 = L14_2 + 4
    L15_2 = 0.5
    L12_2 = L12_2(L13_2, L14_2, L15_2)
    L11_2 = L12_2
  elseif 2 == A8_2 then
    L12_2 = v3
    L12_2 = L12_2.new
    L13_2 = L10_2.x
    L13_2 = L13_2 - 0.3
    L14_2 = L10_2.y
    L14_2 = L14_2 + 0.25
    L15_2 = 0.5
    L12_2 = L12_2(L13_2, L14_2, L15_2)
    L11_2 = L12_2
  elseif 3 == A8_2 then
    L12_2 = v3
    L12_2 = L12_2.new
    L13_2 = L10_2.x
    L13_2 = L13_2 - 0.3
    L14_2 = L9_2.y
    L14_2 = L14_2 + 4
    L15_2 = 0.5
    L12_2 = L12_2(L13_2, L14_2, L15_2)
    L11_2 = L12_2
  else
    L12_2 = error
    L13_2 = "got unexpected position"
    L12_2(L13_2)
    L12_2 = v3
    L12_2 = L12_2.new
    L13_2 = L9_2.x
    L13_2 = L13_2 + 0.25
    L14_2 = L10_2.y
    L15_2 = 0.5
    L12_2 = L12_2(L13_2, L14_2, L15_2)
    L11_2 = L12_2
  end
  L12_2 = ENTITY
  L12_2 = L12_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L13_2 = A0_2
  L14_2 = L11_2.x
  L15_2 = L11_2.y
  L15_2 = L15_2 - 3.15
  L16_2 = L11_2.z
  L16_2 = L16_2 + 1.05
  L12_2 = L12_2(L13_2, L14_2, L15_2, L16_2)
  L13_2 = ENTITY
  L13_2 = L13_2.GET_ENTITY_ROTATION
  L14_2 = A0_2
  L15_2 = 2
  L13_2 = L13_2(L14_2, L15_2)
  L14_2 = L13_2
  L13_2 = L13_2.toDir
  L13_2 = L13_2(L14_2)
  L14_2 = L41_1
  L15_2 = A0_2
  L14_2 = L14_2(L15_2)
  if L14_2 > 95.0 then
    L15_2 = L13_2
    L14_2 = L13_2.mul
    L16_2 = -1
    L14_2(L15_2, L16_2)
  end
  L14_2 = v3
  L14_2 = L14_2.new
  L15_2 = L13_2
  L14_2 = L14_2(L15_2)
  L16_2 = L14_2
  L15_2 = L14_2.mul
  L17_2 = 300.0
  L15_2(L16_2, L17_2)
  L16_2 = L14_2
  L15_2 = L14_2.add
  L17_2 = L12_2
  L15_2(L16_2, L17_2)
  L15_2 = MISC
  L16_2 = "SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY_NEW"
  L15_2 = L15_2[L16_2]
  L16_2 = L12_2.x
  L17_2 = L12_2.y
  L18_2 = L12_2.z
  L19_2 = L14_2.x
  L20_2 = L14_2.y
  L21_2 = L14_2.z
  L21_2 = L21_2 - 15
  L22_2 = A1_2
  L23_2 = true
  L24_2 = A2_2
  L25_2 = A3_2
  L26_2 = A4_2
  L27_2 = not A5_2
  L28_2 = A6_2
  L29_2 = A0_2
  L30_2 = false
  L31_2 = false
  L32_2 = A7_2
  L33_2 = false
  L34_2 = 0
  L35_2 = 0
  L36_2 = 0
  L15_2(L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2, L28_2, L29_2, L30_2, L31_2, L32_2, L33_2, L34_2, L35_2, L36_2)
end
L46_1 = _ENV
L47_1 = "Lazer_Space_Car"
function L48_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L0_2 = request_model
  L1_2 = lsd
  L1_2 = L1_2.hash
  L0_2(L1_2)
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
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_HEADING
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L3_2()
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L3_2 = players
  L3_2 = L3_2.is_in_interior
  L4_2 = PLAYER
  L4_2 = L4_2.PLAYER_ID
  L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L4_2()
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  if true == L3_2 then
    L3_2 = util
    L3_2 = L3_2.toast
    L4_2 = "无法在室内生成战马"
    L3_2(L4_2)
    L3_2 = menu
    L3_2 = L3_2.set_value
    L4_2 = SDspawn
    L5_2 = false
    L3_2(L4_2, L5_2)
    return
  end
  L3_2 = PED
  L3_2 = L3_2.IS_PED_IN_VEHICLE
  L4_2 = PLAYER
  L4_2 = L4_2.PLAYER_PED_ID
  L4_2 = L4_2()
  L5_2 = Lsdcar
  L6_2 = true
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  if false == L3_2 then
    L3_2 = PED
    L3_2 = L3_2.IS_PED_IN_ANY_VEHICLE
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L4_2()
    L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
    if true == L3_2 then
      L3_2 = entities
      L3_2 = L3_2.get_user_vehicle_as_handle
      L3_2 = L3_2()
      L4_2 = ENTITY
      L4_2 = L4_2.SET_ENTITY_AS_MISSION_ENTITY
      L5_2 = L3_2
      L4_2(L5_2)
      L4_2 = delete_entity
      L5_2 = L3_2
      L4_2(L5_2)
      L4_2 = util
      L4_2 = L4_2.toast
      L5_2 = "已为您更换新的战马"
      L4_2(L5_2)
      L4_2 = 1
      L5_2 = 1
      L6_2 = 1
      for L7_2 = L4_2, L5_2, L6_2 do
        L8_2 = SDcreate
        L9_2 = L1_2
        L10_2 = L0_2
        L8_2(L9_2, L10_2)
      end
  end
  else
    L3_2 = PED
    L3_2 = L3_2.IS_PED_IN_VEHICLE
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2 = L4_2()
    L5_2 = Lsdcar
    L6_2 = true
    L3_2 = L3_2(L4_2, L5_2, L6_2)
    if true == L3_2 then
      L3_2 = util
      L3_2 = L3_2.joaat
      L4_2 = lsd
      L4_2 = L4_2.weap
      L3_2 = L3_2(L4_2)
      L4_2 = request_weapon_asset
      L5_2 = L3_2
      L4_2(L5_2)
      L4_2 = ENTITY
      L4_2 = L4_2.DOES_ENTITY_EXIST
      L5_2 = Lsdcar
      L4_2 = L4_2(L5_2)
      if L4_2 then
        L4_2 = PAD
        L4_2 = L4_2.IS_CONTROL_PRESSED
        L5_2 = 0
        L6_2 = 86
        L4_2 = L4_2(L5_2, L6_2)
        if L4_2 then
          goto lbl_116
        end
      end
      do return end
      goto lbl_166
      ::lbl_116::
      L4_2 = L41_1
      L5_2 = Lsdcar
      L4_2 = L4_2(L5_2)
      if L4_2 < 95.0 then
        L4_2 = L45_1
        L5_2 = Lsdcar
        L6_2 = 200
        L7_2 = L3_2
        L8_2 = PLAYER
        L8_2 = L8_2.PLAYER_PED_ID
        L8_2 = L8_2()
        L9_2 = true
        L10_2 = true
        L11_2 = 2000.0
        L12_2 = 0
        L13_2 = 0
        L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
        L4_2 = L45_1
        L5_2 = Lsdcar
        L6_2 = 200
        L7_2 = L3_2
        L8_2 = PLAYER
        L8_2 = L8_2.PLAYER_PED_ID
        L8_2 = L8_2()
        L9_2 = true
        L10_2 = true
        L11_2 = 2000.0
        L12_2 = 0
        L13_2 = 2
        L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
      end
    else
      L3_2 = PED
      L3_2 = L3_2.IS_PED_IN_ANY_VEHICLE
      L4_2 = PLAYER
      L4_2 = L4_2.PLAYER_PED_ID
      L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L4_2()
      L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
      if false == L3_2 then
        L3_2 = ENTITY
        L3_2 = L3_2.DOES_ENTITY_EXIST
        L4_2 = Lsdcar
        L3_2 = L3_2(L4_2)
        if not L3_2 then
          L3_2 = SDcreate
          L4_2 = L1_2
          L5_2 = L0_2
          L3_2(L4_2, L5_2)
        end
      end
    end
  end
  ::lbl_166::
  L3_2 = PED
  L3_2 = L3_2.IS_PED_GETTING_INTO_A_VEHICLE
  L4_2 = PLAYER
  L4_2 = L4_2.PLAYER_PED_ID
  L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L4_2()
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  if false == L3_2 then
    L3_2 = PED
    L3_2 = L3_2.IS_PED_IN_VEHICLE
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2 = L4_2()
    L5_2 = Lsdcar
    L6_2 = false
    L3_2 = L3_2(L4_2, L5_2, L6_2)
    if false == L3_2 then
      L3_2 = util
      L3_2 = L3_2.toast
      L4_2 = "已离开战马，战马已被删除"
      L3_2(L4_2)
      L3_2 = menu
      L3_2 = L3_2.set_value
      L4_2 = SDspawn
      L5_2 = false
      L3_2(L4_2, L5_2)
      L3_2 = STREAMING
      L3_2 = L3_2.SET_MODEL_AS_NO_LONGER_NEEDED
      L4_2 = lsd
      L4_2 = L4_2.hash
      L3_2(L4_2)
      L3_2 = ENTITY
      L3_2 = L3_2.SET_ENTITY_AS_MISSION_ENTITY
      L4_2 = Lsdcar
      L3_2(L4_2)
      L3_2 = delete_entity
      L4_2 = Lsdcar
      L3_2(L4_2)
      L3_2 = util
      L3_2 = L3_2.stop_thread
      L3_2()
    end
  end
end
L46_1[L47_1] = L48_1
L46_1 = _ENV
L47_1 = "stop_Magic_w_w"
function L48_1()
  local L0_2, L1_2
  L0_2 = delete_entity
  L1_2 = Lsdcar
  L0_2(L1_2)
end
L46_1[L47_1] = L48_1
L46_1 = _ENV
L47_1 = "SF_ff9"
function L48_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
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
  L0_2 = L0_2.SET_DATA_SLOT
  L1_2 = 0
  L2_2 = PAD2
  L2_2 = L2_2.GET_CONTROL_INSTRUCTIONAL_BUTTON
  L3_2 = 0
  L4_2 = 86
  L5_2 = true
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  L3_2 = "电磁脉冲"
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = sf
  L0_2 = L0_2.DRAW_INSTRUCTIONAL_BUTTONS
  L0_2()
  L0_2 = sf
  L1_2 = L0_2
  L0_2 = L0_2.draw_fullscreen
  L0_2(L1_2)
end
L46_1[L47_1] = L48_1
L46_1 = _ENV
L47_1 = "magtf"
L48_1 = {}
L49_1 = true
L50_1 = false
L48_1[1] = L49_1
L48_1[2] = L50_1
L46_1[L47_1] = L48_1
L46_1 = _ENV
L47_1 = "maglist"
L48_1 = {}
L49_1 = "推开"
L50_1 = "爆炸"
L48_1[1] = L49_1
L48_1[2] = L50_1
L46_1[L47_1] = L48_1
L46_1 = _ENV
L47_1 = "magval_style"
L48_1 = true
L46_1[L47_1] = L48_1
L46_1 = _ENV
L47_1 = "daoqizhanma_style"
function L48_1(A0_2)
  local L1_2
  L1_2 = magtf
  L1_2 = L1_2[A0_2]
  magval_style = L1_2
end
L46_1[L47_1] = L48_1
L46_1 = _ENV
L47_1 = "charger"
L48_1 = {}
L49_1 = "charg"
L50_1 = _ENV
L51_1 = "util"
L50_1 = L50_1[L51_1]
L51_1 = "joaat"
L50_1 = L50_1[L51_1]
L51_1 = "dukes2"
L50_1 = L50_1(L51_1)
L48_1[L49_1] = L50_1
L49_1 = "emp"
L50_1 = _ENV
L51_1 = "util"
L50_1 = L50_1[L51_1]
L51_1 = "joaat"
L50_1 = L50_1[L51_1]
L51_1 = "hei_prop_heist_emp"
L50_1 = L50_1(L51_1)
L48_1[L49_1] = L50_1
L46_1[L47_1] = L48_1
L46_1 = _ENV
L47_1 = "Ccreate"
function L48_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  L2_2 = VEHICLE
  L2_2 = L2_2.CREATE_VEHICLE
  L3_2 = charger
  L3_2 = L3_2.charg
  L4_2 = A0_2.x
  L5_2 = A0_2.y
  L6_2 = A0_2.z
  L7_2 = 0
  L8_2 = true
  L9_2 = true
  L10_2 = false
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  FFchar = L2_2
  L2_2 = PED
  L2_2 = L2_2.SET_PED_INTO_VEHICLE
  L3_2 = A1_2
  L4_2 = FFchar
  L5_2 = -1
  L2_2(L3_2, L4_2, L5_2)
  L2_2 = VEHICLE
  L2_2 = L2_2.SET_VEHICLE_COLOURS
  L3_2 = FFchar
  L4_2 = 118
  L5_2 = 0
  L2_2(L3_2, L4_2, L5_2)
  L2_2 = 0
  L3_2 = 49
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = VEHICLE
    L6_2 = L6_2.GET_NUM_VEHICLE_MODS
    L7_2 = FFchar
    L8_2 = L5_2
    L6_2 = L6_2(L7_2, L8_2)
    L7_2 = VEHICLE
    L7_2 = L7_2.SET_VEHICLE_MOD
    L8_2 = FFchar
    L9_2 = L5_2
    L10_2 = L6_2 - 1
    L11_2 = false
    L7_2(L8_2, L9_2, L10_2, L11_2)
    L7_2 = VEHICLE
    L7_2 = L7_2.SET_VEHICLE_NUMBER_PLATE_TEXT
    L8_2 = FFchar
    L9_2 = "MOPAR"
    L7_2(L8_2, L9_2)
    L7_2 = VEHICLE
    L7_2 = L7_2.GET_VEHICLE_MOD_KIT
    L8_2 = FFchar
    L9_2 = 0
    L7_2(L8_2, L9_2)
    L7_2 = VEHICLE
    L7_2 = L7_2.SET_VEHICLE_MOD_KIT
    L8_2 = FFchar
    L9_2 = 0
    L7_2(L8_2, L9_2)
    L7_2 = VEHICLE
    L7_2 = L7_2.SET_VEHICLE_MOD
    L8_2 = FFchar
    L9_2 = 14
    L10_2 = 0
    L7_2(L8_2, L9_2, L10_2)
    L7_2 = VEHICLE
    L7_2 = L7_2.TOGGLE_VEHICLE_MOD
    L8_2 = FFchar
    L9_2 = 22
    L10_2 = true
    L7_2(L8_2, L9_2, L10_2)
    L7_2 = VEHICLE
    L7_2 = L7_2.TOGGLE_VEHICLE_MOD
    L8_2 = FFchar
    L9_2 = 18
    L10_2 = true
    L7_2(L8_2, L9_2, L10_2)
    L7_2 = VEHICLE
    L7_2 = L7_2.TOGGLE_VEHICLE_MOD
    L8_2 = FFchar
    L9_2 = 20
    L10_2 = true
    L7_2(L8_2, L9_2, L10_2)
    L7_2 = VEHICLE
    L7_2 = L7_2.SET_VEHICLE_TYRE_SMOKE_COLOR
    L8_2 = FFchar
    L9_2 = 0
    L10_2 = 0
    L11_2 = 0
    L7_2(L8_2, L9_2, L10_2, L11_2)
    L7_2 = VEHICLE
    L7_2 = L7_2.SET_VEHICLE_WHEEL_TYPE
    L8_2 = FFchar
    L9_2 = 7
    L7_2(L8_2, L9_2)
    L7_2 = VEHICLE
    L7_2 = L7_2.SET_VEHICLE_MOD
    L8_2 = FFchar
    L9_2 = 23
    L10_2 = 26
    L7_2(L8_2, L9_2, L10_2)
    L7_2 = VEHICLE
    L7_2 = L7_2.SET_VEHICLE_MAX_SPEED
    L8_2 = FFchar
    L9_2 = 100
    L7_2(L8_2, L9_2)
    L7_2 = VEHICLE
    L7_2 = L7_2.MODIFY_VEHICLE_TOP_SPEED
    L8_2 = FFchar
    L9_2 = 40
    L7_2(L8_2, L9_2)
    L7_2 = VEHICLE
    L7_2 = L7_2.SET_VEHICLE_BURNOUT
    L8_2 = FFchar
    L9_2 = false
    L7_2(L8_2, L9_2)
  end
  L2_2 = util
  L2_2 = L2_2.yield
  L3_2 = 150
  L2_2(L3_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = FFchar
  L2_2 = L2_2(L3_2)
  L3_2 = OBJECT
  L3_2 = L3_2.CREATE_OBJECT
  L4_2 = charger
  L4_2 = L4_2.emp
  L5_2 = L2_2.x
  L6_2 = L2_2.y
  L6_2 = L6_2 - 1
  L7_2 = L2_2.z
  L7_2 = L7_2 - 1
  L8_2 = true
  L9_2 = true
  L10_2 = true
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  Empa = L3_2
  L3_2 = ENTITY
  L3_2 = L3_2.ATTACH_ENTITY_TO_ENTITY
  L4_2 = Empa
  L5_2 = FFchar
  L6_2 = 0
  L7_2 = 0.0
  L8_2 = -2.0
  L9_2 = 0.5
  L10_2 = 0.0
  L11_2 = 0.0
  L12_2 = 0.0
  L13_2 = false
  L14_2 = true
  L15_2 = false
  L16_2 = false
  L17_2 = 0
  L18_2 = true
  L19_2 = 0
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
  L3_2 = CAM
  L3_2 = L3_2.GET_GAMEPLAY_CAM_RELATIVE_HEADING
  L3_2 = L3_2()
  L4_2 = ENTITY
  L4_2 = L4_2.SET_ENTITY_HEADING
  L5_2 = FFchar
  L6_2 = L3_2
  L4_2(L5_2, L6_2)
  L4_2 = util
  L4_2 = L4_2.yield
  L4_2()
  function L4_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
    L0_3 = PAD
    L0_3 = L0_3.IS_CONTROL_PRESSED
    L1_3 = 0
    L2_3 = 86
    L0_3 = L0_3(L1_3, L2_3)
    if L0_3 then
      L0_3 = ENTITY
      L0_3 = L0_3.GET_ENTITY_COORDS
      L1_3 = PLAYER
      L1_3 = L1_3.PLAYER_PED_ID
      L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3 = L1_3()
      L0_3 = L0_3(L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3)
      L1_3 = FIRE
      L1_3 = L1_3.ADD_EXPLOSION
      L2_3 = L0_3.x
      L3_3 = L0_3.y
      L4_3 = L0_3.z
      L5_3 = 81
      L6_3 = 5000.0
      L7_3 = false
      L8_3 = true
      L9_3 = 0.0
      L10_3 = magval_style
      L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3)
    end
    L0_3 = util
    L0_3 = L0_3.yield
    L0_3()
  end
  Magout = L4_2
  L4_2 = util
  L4_2 = L4_2.create_tick_handler
  function L5_2()
    local L0_3, L1_3, L2_3, L3_3
    L0_3 = PED
    L0_3 = L0_3.IS_PED_IN_VEHICLE
    L1_3 = PLAYER
    L1_3 = L1_3.PLAYER_PED_ID
    L1_3 = L1_3()
    L2_3 = FFchar
    L3_3 = false
    L0_3 = L0_3(L1_3, L2_3, L3_3)
    if true == L0_3 then
      L0_3 = VEHICLE
      L0_3 = L0_3.SET_VEHICLE_DIRT_LEVEL
      L1_3 = FFchar
      L2_3 = 0
      L0_3(L1_3, L2_3)
      L0_3 = ENTITY
      L0_3 = L0_3.SET_ENTITY_INVINCIBLE
      L1_3 = FFchar
      L2_3 = true
      L0_3(L1_3, L2_3)
      L0_3 = VEHICLE
      L0_3 = L0_3.SET_VEHICLE_CAN_BE_VISIBLY_DAMAGED
      L1_3 = FFchar
      L2_3 = false
      L0_3(L1_3, L2_3)
      L0_3 = SF_ff9
      L0_3()
    end
  end
  L4_2(L5_2)
end
L46_1[L47_1] = L48_1
L46_1 = _ENV
L47_1 = "daoqizhanma"
function L48_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L0_2 = request_model
  L1_2 = charger
  L1_2 = L1_2.charg
  L0_2(L1_2)
  L0_2 = request_model
  L1_2 = charger
  L1_2 = L1_2.emp
  L0_2(L1_2)
  L0_2 = PLAYER
  L0_2 = L0_2.GET_PLAYER_PED_SCRIPT_INDEX
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2)
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_COORDS
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2, L3_2, L4_2, L5_2, L6_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_HEADING
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2, L4_2, L5_2, L6_2 = L3_2()
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  L3_2 = players
  L3_2 = L3_2.is_in_interior
  L4_2 = PLAYER
  L4_2 = L4_2.PLAYER_ID
  L4_2, L5_2, L6_2 = L4_2()
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  if true == L3_2 then
    L3_2 = util
    L3_2 = L3_2.toast
    L4_2 = "无法在室内生成道奇战马"
    L3_2(L4_2)
    L3_2 = menu
    L3_2 = L3_2.set_value
    L4_2 = Spawn
    L5_2 = false
    L3_2(L4_2, L5_2)
    return
  end
  L3_2 = PED
  L3_2 = L3_2.IS_PED_IN_VEHICLE
  L4_2 = PLAYER
  L4_2 = L4_2.PLAYER_PED_ID
  L4_2 = L4_2()
  L5_2 = FFchar
  L6_2 = true
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  if false == L3_2 then
    L3_2 = PED
    L3_2 = L3_2.IS_PED_IN_ANY_VEHICLE
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2, L5_2, L6_2 = L4_2()
    L3_2 = L3_2(L4_2, L5_2, L6_2)
    if true == L3_2 then
      L3_2 = entities
      L3_2 = L3_2.get_user_vehicle_as_handle
      L3_2 = L3_2()
      L4_2 = ENTITY
      L4_2 = L4_2.SET_ENTITY_AS_MISSION_ENTITY
      L5_2 = L3_2
      L4_2(L5_2)
      L4_2 = delete_entity
      L5_2 = L3_2
      L4_2(L5_2)
      L4_2 = util
      L4_2 = L4_2.toast
      L5_2 = "已为您更换新的"
      L4_2(L5_2)
      L4_2 = Ccreate
      L5_2 = L1_2
      L6_2 = L0_2
      L4_2(L5_2, L6_2)
  end
  else
    L3_2 = PED
    L3_2 = L3_2.IS_PED_IN_VEHICLE
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2 = L4_2()
    L5_2 = FFchar
    L6_2 = true
    L3_2 = L3_2(L4_2, L5_2, L6_2)
    if true == L3_2 then
      L3_2 = Magout
      L3_2()
    else
      L3_2 = PED
      L3_2 = L3_2.IS_PED_IN_ANY_VEHICLE
      L4_2 = PLAYER
      L4_2 = L4_2.PLAYER_PED_ID
      L4_2, L5_2, L6_2 = L4_2()
      L3_2 = L3_2(L4_2, L5_2, L6_2)
      if false == L3_2 then
        L3_2 = Ccreate
        L4_2 = L1_2
        L5_2 = L0_2
        L3_2(L4_2, L5_2)
      end
    end
  end
  L3_2 = PED
  L3_2 = L3_2.IS_PED_GETTING_INTO_A_VEHICLE
  L4_2 = PLAYER
  L4_2 = L4_2.PLAYER_PED_ID
  L4_2, L5_2, L6_2 = L4_2()
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  if false == L3_2 then
    L3_2 = PED
    L3_2 = L3_2.IS_PED_IN_VEHICLE
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2 = L4_2()
    L5_2 = FFchar
    L6_2 = false
    L3_2 = L3_2(L4_2, L5_2, L6_2)
    if false == L3_2 then
      L3_2 = util
      L3_2 = L3_2.toast
      L4_2 = "已离开战马,战马已被删除"
      L3_2(L4_2)
      L3_2 = menu
      L3_2 = L3_2.set_value
      L4_2 = Spawn
      L5_2 = false
      L3_2(L4_2, L5_2)
      L3_2 = ENTITY
      L3_2 = L3_2.SET_ENTITY_AS_MISSION_ENTITY
      L4_2 = FFchar
      L3_2(L4_2)
      L3_2 = delete_entity
      L4_2 = FFchar
      L3_2(L4_2)
      L3_2 = ENTITY
      L3_2 = L3_2.SET_ENTITY_AS_MISSION_ENTITY
      L4_2 = Empa
      L3_2(L4_2)
      L3_2 = delete_entity
      L4_2 = Empa
      L3_2(L4_2)
      L3_2 = STREAMING
      L3_2 = L3_2.SET_MODEL_AS_NO_LONGER_NEEDED
      L4_2 = charger
      L4_2 = L4_2.charg
      L3_2(L4_2)
      L3_2 = STREAMING
      L3_2 = L3_2.SET_MODEL_AS_NO_LONGER_NEEDED
      L4_2 = charger
      L4_2 = L4_2.emp
      L3_2(L4_2)
      L3_2 = util
      L3_2 = L3_2.stop_thread
      L3_2()
    end
  end
end
L46_1[L47_1] = L48_1
L46_1 = _ENV
L47_1 = "stop_daoqizhanma"
function L48_1()
  local L0_2, L1_2
  L0_2 = FFchar
  if not L0_2 then
    L0_2 = Empa
    if not L0_2 then
      goto lbl_13
    end
  end
  L0_2 = delete_entity
  L1_2 = FFchar
  L0_2(L1_2)
  L0_2 = delete_entity
  L1_2 = Empa
  L0_2(L1_2)
  ::lbl_13::
end
L46_1[L47_1] = L48_1
L46_1 = _ENV
L47_1 = "shoot_text_colour"
L48_1 = {}
L49_1 = "r"
L50_1 = 1.0
L48_1[L49_1] = L50_1
L49_1 = "g"
L50_1 = 1.0
L48_1[L49_1] = L50_1
L49_1 = "b"
L50_1 = 1.0
L48_1[L49_1] = L50_1
L49_1 = "a"
L50_1 = 1.0
L48_1[L49_1] = L50_1
L46_1[L47_1] = L48_1
L46_1 = _ENV
L47_1 = "shoot_bg_colour"
L48_1 = {}
L49_1 = "r"
L50_1 = 0.75
L48_1[L49_1] = L50_1
L49_1 = "g"
L50_1 = 0.82
L48_1[L49_1] = L50_1
L49_1 = "b"
L50_1 = 0.94
L48_1[L49_1] = L50_1
L49_1 = "a"
L48_1[L49_1] = 1
L46_1[L47_1] = L48_1
L46_1 = _ENV
L47_1 = "shoot_pos"
L48_1 = {}
L49_1 = "x"
L50_1 = -2983.3865
L48_1[L49_1] = L50_1
L49_1 = "y"
L50_1 = -5147.5
L48_1[L49_1] = L50_1
L49_1 = "z"
L50_1 = 437.15488
L48_1[L49_1] = L50_1
L46_1[L47_1] = L48_1
L46_1 = _ENV
L47_1 = "time_selector"
L48_1 = {}
L49_1 = "display_options"
L50_1 = {}
L51_1 = "无限制"
L52_1 = "30s"
L53_1 = "60s"
L54_1 = "90s"
L55_1 = "120s"
L56_1 = "180s"
L57_1 = "300s"
L50_1[1] = L51_1
L50_1[2] = L52_1
L50_1[3] = L53_1
L50_1[4] = L54_1
L50_1[5] = L55_1
L50_1[6] = L56_1
L50_1[7] = L57_1
L48_1[L49_1] = L50_1
L49_1 = "value"
L50_1 = {}
L51_1 = 0
L52_1 = 30000
L53_1 = 60000
L54_1 = 90000
L55_1 = 120000
L56_1 = 180000
L57_1 = 300000
L50_1[1] = L51_1
L50_1[2] = L52_1
L50_1[3] = L53_1
L50_1[4] = L54_1
L50_1[5] = L55_1
L50_1[6] = L56_1
L50_1[7] = L57_1
L48_1[L49_1] = L50_1
L46_1[L47_1] = L48_1
L46_1 = 5
L47_1 = _ENV
L48_1 = "simple3d_target_max_height"
L49_1 = {}
L50_1 = "display_options"
L51_1 = {}
L52_1 = "地面"
L53_1 = "低"
L54_1 = "中"
L55_1 = "高"
L56_1 = "巅峰"
L51_1[1] = L52_1
L51_1[2] = L53_1
L51_1[3] = L54_1
L51_1[4] = L55_1
L51_1[5] = L56_1
L49_1[L50_1] = L51_1
L50_1 = "height_value"
L51_1 = {}
L52_1 = 0
L53_1 = 3
L54_1 = 5
L55_1 = 7
L56_1 = 9
L51_1[1] = L52_1
L51_1[2] = L53_1
L51_1[3] = L54_1
L51_1[4] = L55_1
L51_1[5] = L56_1
L49_1[L50_1] = L51_1
L47_1[L48_1] = L49_1
L47_1 = 200
L48_1 = _ENV
L49_1 = "ped_health_selector"
L50_1 = {}
L51_1 = "display_options"
L52_1 = {}
L53_1 = "NPC"
L54_1 = "Player"
L55_1 = "一枪击杀"
L56_1 = "仅爆头[狙击手MKII]"
L52_1[1] = L53_1
L52_1[2] = L54_1
L52_1[3] = L55_1
L52_1[4] = L56_1
L50_1[L51_1] = L52_1
L51_1 = "healh_values"
L52_1 = {}
L53_1 = 200
L54_1 = 328
L55_1 = 105
L56_1 = 100000
L52_1[1] = L53_1
L52_1[2] = L54_1
L52_1[3] = L55_1
L52_1[4] = L56_1
L50_1[L51_1] = L52_1
L48_1[L49_1] = L50_1
L48_1 = _ENV
L49_1 = "clear_all_peds"
function L50_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = ipairs
  L1_2 = entities
  L1_2 = L1_2.get_all_peds_as_handles
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2 = L1_2()
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = PLAYER
    L6_2 = L6_2.PLAYER_PED_ID
    L6_2 = L6_2()
    if L5_2 ~= L6_2 then
      L6_2 = PED
      L6_2 = L6_2.IS_PED_A_PLAYER
      L7_2 = L5_2
      L6_2 = L6_2(L7_2)
      if not L6_2 then
        L6_2 = delete_entity
        L7_2 = L5_2
        L6_2(L7_2)
        L6_2 = util
        L6_2 = L6_2.yield
        L6_2()
      end
    end
  end
end
L48_1[L49_1] = L50_1
L48_1 = _ENV
L49_1 = "clear_dead_peds"
function L50_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = ipairs
  L1_2 = entities
  L1_2 = L1_2.get_all_peds_as_handles
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2 = L1_2()
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = PLAYER
    L6_2 = L6_2.PLAYER_PED_ID
    L6_2 = L6_2()
    if L5_2 ~= L6_2 then
      L6_2 = PED
      L6_2 = L6_2.IS_PED_A_PLAYER
      L7_2 = L5_2
      L6_2 = L6_2(L7_2)
      if not L6_2 then
        L6_2 = ENTITY
        L6_2 = L6_2.IS_ENTITY_DEAD
        L7_2 = L5_2
        L6_2 = L6_2(L7_2)
        if L6_2 then
          L6_2 = delete_entity
          L7_2 = L5_2
          L6_2(L7_2)
        end
      end
    end
  end
end
L48_1[L49_1] = L50_1
L48_1 = false
L49_1 = _ENV
L50_1 = "target_move"
function L51_1(A0_2)
  local L1_2
  L48_1 = A0_2
end
L49_1[L50_1] = L51_1
L49_1 = _ENV
L50_1 = "create_ped_simple_3d"
function L51_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  if 0 ~= A0_2 then
    L2_2 = math
    L2_2 = L2_2.random
    L3_2 = 0
    L4_2 = A0_2
    L2_2 = L2_2(L3_2, L4_2)
    zrandom = L2_2
  else
    zrandom = 0
  end
  L2_2 = math
  L2_2 = L2_2.random
  L3_2 = 0
  L4_2 = 63
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = math
  L3_2 = L3_2.random
  L4_2 = 0
  L5_2 = 82
  L3_2 = L3_2(L4_2, L5_2)
  yrandom = L3_2
  xrandom = L2_2
  L2_2 = PED
  L2_2 = L2_2.CREATE_RANDOM_PED
  L3_2 = xrandom
  L4_2 = -2951.51345
  L3_2 = L4_2 - L3_2
  L4_2 = yrandom
  L4_2 = -5188.895345 + L4_2
  L5_2 = zrandom
  L5_2 = 437.353345 + L5_2
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  target_ped = L2_2
  L2_2 = L48_1
  if true == L2_2 then
    L2_2 = PED
    L2_2 = L2_2.CREATE_RANDOM_PED
    L3_2 = math
    L3_2 = L3_2.random
    L4_2 = 0
    L5_2 = 63
    L3_2 = L3_2(L4_2, L5_2)
    L4_2 = -2951.51345
    L3_2 = L4_2 - L3_2
    L4_2 = math
    L4_2 = L4_2.random
    L5_2 = 0
    L6_2 = 82
    L4_2 = L4_2(L5_2, L6_2)
    L4_2 = -5188.895345 + L4_2
    L5_2 = zrandom
    L5_2 = 437.353345 + L5_2
    L2_2 = L2_2(L3_2, L4_2, L5_2)
    L3_2 = ENTITY
    L3_2 = L3_2.SET_ENTITY_ALPHA
    L4_2 = L2_2
    L5_2 = 0
    L6_2 = false
    L3_2(L4_2, L5_2, L6_2)
    L3_2 = ENTITY
    L3_2 = L3_2.SET_ENTITY_HEALTH
    L4_2 = target_ped
    L5_2 = A1_2
    L6_2 = 0
    L3_2(L4_2, L5_2, L6_2)
    L3_2 = TASK
    L3_2 = L3_2.TASK_COMBAT_PED
    L4_2 = target_ped
    L5_2 = L2_2
    L6_2 = 0
    L7_2 = 16
    L3_2(L4_2, L5_2, L6_2, L7_2)
  else
    L2_2 = ENTITY
    L2_2 = L2_2.SET_ENTITY_HEALTH
    L3_2 = target_ped
    L4_2 = A1_2
    L5_2 = 0
    L2_2(L3_2, L4_2, L5_2)
    L2_2 = ENTITY
    L2_2 = L2_2.FREEZE_ENTITY_POSITION
    L3_2 = target_ped
    L4_2 = true
    L2_2(L3_2, L4_2)
  end
  L2_2 = target_ped
  return L2_2
end
L49_1[L50_1] = L51_1
L49_1 = _ENV
L50_1 = "create_ped_simple_2d"
function L51_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = math
  L1_2 = L1_2.random
  L2_2 = 0
  L3_2 = 63
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = 0
  L3_2 = math
  L3_2 = L3_2.random
  L4_2 = 0
  L5_2 = 10
  L3_2 = L3_2(L4_2, L5_2)
  zrandom = L3_2
  yrandom = L2_2
  xrandom = L1_2
  L1_2 = PED
  L1_2 = L1_2.CREATE_RANDOM_PED
  L2_2 = xrandom
  L3_2 = -2951.51345
  L2_2 = L3_2 - L2_2
  L3_2 = yrandom
  L3_2 = -5188.895345 + L3_2
  L4_2 = zrandom
  L4_2 = 437.353345 + L4_2
  L1_2 = L1_2(L2_2, L3_2, L4_2)
  target_ped = L1_2
  L1_2 = ENTITY
  L1_2 = L1_2.SET_ENTITY_HEALTH
  L2_2 = target_ped
  L3_2 = A0_2
  L4_2 = 0
  L1_2(L2_2, L3_2, L4_2)
  L1_2 = ENTITY
  L1_2 = L1_2.FREEZE_ENTITY_POSITION
  L2_2 = target_ped
  L3_2 = true
  L1_2(L2_2, L3_2)
  L1_2 = target_ped
  return L1_2
end
L49_1[L50_1] = L51_1
L49_1 = _ENV
L50_1 = "teleport_to_lab"
function L51_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = ENTITY
  L0_2 = L0_2.SET_ENTITY_COORDS_NO_OFFSET
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = shoot_pos
  L2_2 = L2_2.x
  L3_2 = shoot_pos
  L3_2 = L3_2.y
  L3_2 = L3_2 + 20
  L4_2 = shoot_pos
  L4_2 = L4_2.z
  L4_2 = L4_2 + 2
  L5_2 = 0
  L6_2 = 0
  L7_2 = 1
  L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
end
L49_1[L50_1] = L51_1
L49_1 = _ENV
L50_1 = "toint"
function L51_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = tostring
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L3_2 = L1_2
  L2_2 = L1_2.find
  L4_2 = "%."
  L2_2, L3_2 = L2_2(L3_2, L4_2)
  if L2_2 then
    L4_2 = tonumber
    L6_2 = L1_2
    L5_2 = L1_2.sub
    L7_2 = 1
    L8_2 = L2_2 - 1
    L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2, L7_2, L8_2)
    return L4_2(L5_2, L6_2, L7_2, L8_2)
  else
    return A0_2
  end
end
L49_1[L50_1] = L51_1
L49_1 = _ENV
L50_1 = "end_minigame"
function L51_1(A0_2)
  local L1_2, L2_2, L3_2
  L2_2 = A0_2
  L1_2 = A0_2.trigger
  L3_2 = false
  L1_2(L2_2, L3_2)
  L1_2 = util
  L1_2 = L1_2.yield
  L2_2 = 1000
  L1_2(L2_2)
  L1_2 = clear_all_peds
  L1_2()
end
L49_1[L50_1] = L51_1
L49_1 = _ENV
L50_1 = "objects"
L51_1 = {}
L49_1[L50_1] = L51_1
L49_1 = _ENV
L50_1 = "load_lab"
function L51_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L0_2 = {}
  objects = L0_2
  L0_2 = util
  L0_2 = L0_2.joaat
  L1_2 = "stt_prop_stunt_bblock_huge_03"
  L0_2 = L0_2(L1_2)
  prop_hash = L0_2
  L0_2 = ENTITY
  L0_2 = L0_2.GET_ENTITY_COORDS
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = true
  L0_2 = L0_2(L1_2, L2_2)
  ped_shoot_pos = L0_2
  L0_2 = STREAMING
  L0_2 = L0_2.REQUEST_MODEL
  L1_2 = prop_hash
  L0_2(L1_2)
  L0_2 = OBJECT
  L0_2 = L0_2.CREATE_OBJECT_NO_OFFSET
  L1_2 = prop_hash
  L2_2 = shoot_pos
  L2_2 = L2_2.x
  L3_2 = shoot_pos
  L3_2 = L3_2.y
  L4_2 = shoot_pos
  L4_2 = L4_2.z
  L5_2 = true
  L6_2 = true
  L7_2 = false
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
  L1_2 = objects
  L2_2 = objects
  L2_2 = #L2_2
  L2_2 = L2_2 + 1
  L1_2[L2_2] = L0_2
  L1_2 = OBJECT
  L1_2 = L1_2.CREATE_OBJECT_NO_OFFSET
  L2_2 = prop_hash
  L3_2 = shoot_pos
  L3_2 = L3_2.x
  L4_2 = shoot_pos
  L4_2 = L4_2.y
  L5_2 = shoot_pos
  L5_2 = L5_2.z
  L5_2 = L5_2 + 15
  L6_2 = true
  L7_2 = true
  L8_2 = false
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  L2_2 = objects
  L3_2 = objects
  L3_2 = #L3_2
  L3_2 = L3_2 + 1
  L2_2[L3_2] = L1_2
  L2_2 = OBJECT
  L2_2 = L2_2.CREATE_OBJECT_NO_OFFSET
  L3_2 = prop_hash
  L4_2 = shoot_pos
  L4_2 = L4_2.x
  L5_2 = shoot_pos
  L5_2 = L5_2.y
  L5_2 = L5_2 + 42
  L6_2 = shoot_pos
  L6_2 = L6_2.z
  L6_2 = L6_2 - 2.6
  L7_2 = true
  L8_2 = true
  L9_2 = false
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L3_2 = objects
  L4_2 = objects
  L4_2 = #L4_2
  L4_2 = L4_2 + 1
  L3_2[L4_2] = L2_2
  L3_2 = OBJECT
  L3_2 = L3_2.CREATE_OBJECT_NO_OFFSET
  L4_2 = prop_hash
  L5_2 = shoot_pos
  L5_2 = L5_2.x
  L6_2 = shoot_pos
  L6_2 = L6_2.y
  L6_2 = L6_2 - 42
  L7_2 = shoot_pos
  L7_2 = L7_2.z
  L7_2 = L7_2 - 2.6
  L8_2 = true
  L9_2 = true
  L10_2 = false
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L4_2 = objects
  L5_2 = objects
  L5_2 = #L5_2
  L5_2 = L5_2 + 1
  L4_2[L5_2] = L3_2
  L4_2 = OBJECT
  L4_2 = L4_2.CREATE_OBJECT_NO_OFFSET
  L5_2 = prop_hash
  L6_2 = shoot_pos
  L6_2 = L6_2.x
  L6_2 = L6_2 - 32.5
  L7_2 = shoot_pos
  L7_2 = L7_2.y
  L8_2 = shoot_pos
  L8_2 = L8_2.z
  L9_2 = true
  L10_2 = true
  L11_2 = false
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L5_2 = objects
  L6_2 = objects
  L6_2 = #L6_2
  L6_2 = L6_2 + 1
  L5_2[L6_2] = L4_2
  L5_2 = OBJECT
  L5_2 = L5_2.CREATE_OBJECT_NO_OFFSET
  L6_2 = prop_hash
  L7_2 = shoot_pos
  L7_2 = L7_2.x
  L7_2 = L7_2 + 32.5
  L8_2 = shoot_pos
  L8_2 = L8_2.y
  L9_2 = shoot_pos
  L9_2 = L9_2.z
  L10_2 = true
  L11_2 = true
  L12_2 = false
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L6_2 = objects
  L7_2 = objects
  L7_2 = #L7_2
  L7_2 = L7_2 + 1
  L6_2[L7_2] = L5_2
  L6_2 = util
  L6_2 = L6_2.yield
  L7_2 = 50
  L6_2(L7_2)
  L6_2 = ENTITY
  L6_2 = L6_2.GET_ENTITY_ROTATION
  L7_2 = objects
  L7_2 = L7_2[3]
  L8_2 = 0
  L6_2 = L6_2(L7_2, L8_2)
  rot = L6_2
  L6_2 = rot
  L6_2.x = 90
  L6_2 = ENTITY
  L6_2 = L6_2.SET_ENTITY_ROTATION
  L7_2 = objects
  L7_2 = L7_2[3]
  L8_2 = rot
  L8_2 = L8_2.x
  L9_2 = rot
  L9_2 = L9_2.y
  L10_2 = rot
  L10_2 = L10_2.z
  L11_2 = 1
  L12_2 = true
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L6_2 = ENTITY
  L6_2 = L6_2.GET_ENTITY_ROTATION
  L7_2 = objects
  L7_2 = L7_2[4]
  L8_2 = 0
  L6_2 = L6_2(L7_2, L8_2)
  rot = L6_2
  L6_2 = rot
  L6_2.x = 90
  L6_2 = ENTITY
  L6_2 = L6_2.SET_ENTITY_ROTATION
  L7_2 = objects
  L7_2 = L7_2[4]
  L8_2 = rot
  L8_2 = L8_2.x
  L9_2 = rot
  L9_2 = L9_2.y
  L10_2 = rot
  L10_2 = L10_2.z
  L11_2 = 1
  L12_2 = true
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L6_2 = ENTITY
  L6_2 = L6_2.GET_ENTITY_ROTATION
  L7_2 = objects
  L7_2 = L7_2[5]
  L8_2 = 0
  L6_2 = L6_2(L7_2, L8_2)
  rot = L6_2
  L6_2 = rot
  L6_2.y = 90
  L6_2 = ENTITY
  L6_2 = L6_2.SET_ENTITY_ROTATION
  L7_2 = objects
  L7_2 = L7_2[5]
  L8_2 = rot
  L8_2 = L8_2.x
  L9_2 = rot
  L9_2 = L9_2.y
  L10_2 = rot
  L10_2 = L10_2.z
  L11_2 = 1
  L12_2 = true
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L6_2 = ENTITY
  L6_2 = L6_2.GET_ENTITY_ROTATION
  L7_2 = objects
  L7_2 = L7_2[6]
  L8_2 = 0
  L6_2 = L6_2(L7_2, L8_2)
  rot = L6_2
  L6_2 = rot
  L6_2.y = -90
  L6_2 = ENTITY
  L6_2 = L6_2.SET_ENTITY_ROTATION
  L7_2 = objects
  L7_2 = L7_2[6]
  L8_2 = rot
  L8_2 = L8_2.x
  L9_2 = rot
  L9_2 = L9_2.y
  L10_2 = rot
  L10_2 = L10_2.z
  L11_2 = 1
  L12_2 = true
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L6_2 = util
  L6_2 = L6_2.yield
  L7_2 = 500
  L6_2(L7_2)
  L6_2 = teleport_to_lab
  L6_2()
  L6_2 = clear_all_peds
  L6_2()
end
L49_1[L50_1] = L51_1
L49_1 = _ENV
L50_1 = "Clean_training_ground"
function L51_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = teleport
  L1_2 = -1314
  L2_2 = -3057
  L3_2 = 13
  L0_2(L1_2, L2_2, L3_2)
  L0_2 = util
  L0_2 = L0_2.yield
  L1_2 = 500
  L0_2(L1_2)
  L0_2 = ipairs
  L1_2 = entities
  L1_2 = L1_2.get_all_peds_as_handles
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2 = L1_2()
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = PLAYER
    L6_2 = L6_2.PLAYER_PED_ID
    L6_2 = L6_2()
    if L5_2 ~= L6_2 then
      L6_2 = PED
      L6_2 = L6_2.IS_PED_A_PLAYER
      L7_2 = L5_2
      L6_2 = L6_2(L7_2)
      if not L6_2 then
        L6_2 = delete_entity
        L7_2 = L5_2
        L6_2(L7_2)
      end
    end
  end
  L0_2 = pairs
  L1_2 = objects
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = delete_entity
    L7_2 = L5_2
    L6_2(L7_2)
  end
end
L49_1[L50_1] = L51_1
L49_1 = _ENV
L50_1 = "ped_health_3d"
L49_1[L50_1] = L47_1
L49_1 = 0
L50_1 = _ENV
L51_1 = "Shooting_simulation_3D"
function L52_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  on = A0_2
  L1_2 = ped_health_3d
  ped_health_3d = L1_2
  simple_3d_started = true
  L1_2 = simple_2d_toggle
  L2_2 = L1_2
  L1_2 = L1_2.trigger
  L3_2 = false
  L1_2(L2_2, L3_2)
  L1_2 = L49_1
  time = L1_2
  L1_2 = menu
  L1_2 = L1_2.trigger_commands
  L2_2 = "time 11; locktime on"
  L1_2(L2_2)
  L1_2 = util
  L1_2 = L1_2.yield
  L2_2 = 1000
  L1_2(L2_2)
  L1_2 = clear_all_peds
  L1_2()
  L1_2 = util
  L1_2 = L1_2.yield
  L2_2 = 100
  L1_2(L2_2)
  L1_2 = create_ped_simple_3d
  L2_2 = L46_1
  L3_2 = ped_health_3d
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = HUD
  L2_2 = L2_2.ADD_BLIP_FOR_ENTITY
  L3_2 = L1_2
  L2_2(L3_2)
  L2_2 = 0
  L3_2 = util
  L3_2 = L3_2.current_time_millis
  L3_2 = L3_2()
  L4_2 = time
  L3_2 = L3_2 + L4_2
  while true do
    L4_2 = on
    if not L4_2 then
      break
    end
    L4_2 = L48_1
    if false == L4_2 then
      L4_2 = TASK
      L4_2 = L4_2.TASK_STAND_STILL
      L5_2 = L1_2
      L6_2 = 1000000
      L4_2(L5_2, L6_2)
    end
    L4_2 = util
    L4_2 = L4_2.current_time_millis
    L4_2 = L4_2()
    L5_2 = L3_2 - L4_2
    L5_2 = L5_2 / 1000
    L6_2 = time
    if L6_2 > 0 then
      L6_2 = "得分: "
      L7_2 = L2_2
      L8_2 = " | 时间: "
      L9_2 = toint
      L10_2 = L5_2
      L9_2 = L9_2(L10_2)
      L6_2 = L6_2 .. L7_2 .. L8_2 .. L9_2
      txt = L6_2
    else
      L6_2 = "得分: "
      L7_2 = L2_2
      L8_2 = " | 时间: ∞"
      L6_2 = L6_2 .. L7_2 .. L8_2
      txt = L6_2
    end
    L6_2 = directx
    L6_2 = L6_2.get_text_size
    L7_2 = txt
    L8_2 = 0.7
    L6_2, L7_2 = L6_2(L7_2, L8_2)
    L8_2 = L6_2 / 2
    L9_2 = 0.5
    L8_2 = L9_2 - L8_2
    L9_2 = 0.015
    L10_2 = directx
    L10_2 = L10_2.draw_rect
    L11_2 = L8_2 - 0.01
    L12_2 = L9_2 - 0.01
    L13_2 = L6_2 + 0.02
    L14_2 = L7_2 + 0.02
    L15_2 = shoot_bg_colour
    L10_2(L11_2, L12_2, L13_2, L14_2, L15_2)
    L10_2 = directx
    L10_2 = L10_2.draw_text
    L11_2 = L8_2
    L12_2 = L9_2
    L13_2 = txt
    L14_2 = 0
    L15_2 = 0.7
    L16_2 = shoot_text_colour
    L17_2 = true
    L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
    if L5_2 <= 0 then
      L10_2 = time
      if L10_2 > 0 then
        L10_2 = util
        L10_2 = L10_2.toast
        L11_2 = "3D射击已经结束 | 得分: "
        L12_2 = L2_2
        L13_2 = " | 时间: "
        L14_2 = toint
        L15_2 = time
        L15_2 = L15_2 / 1000
        L14_2 = L14_2(L15_2)
        L15_2 = "s."
        L11_2 = L11_2 .. L12_2 .. L13_2 .. L14_2 .. L15_2
        L10_2(L11_2)
        simple_3d_started = false
        L10_2 = end_minigame
        L11_2 = simple_3d_toggle
        L10_2(L11_2)
      end
    end
    L10_2 = ENTITY
    L10_2 = L10_2.IS_ENTITY_DEAD
    L11_2 = L1_2
    L10_2 = L10_2(L11_2)
    if L10_2 then
      L10_2 = clear_dead_peds
      L10_2()
      if not (L5_2 > 0) then
        L10_2 = time
        if 0 ~= L10_2 then
          goto lbl_154
        end
      end
      L2_2 = L2_2 + 1
      L10_2 = create_ped_simple_3d
      L11_2 = L46_1
      L12_2 = ped_health_3d
      L10_2 = L10_2(L11_2, L12_2)
      L1_2 = L10_2
      L10_2 = HUD
      L10_2 = L10_2.ADD_BLIP_FOR_ENTITY
      L11_2 = L1_2
      L10_2(L11_2)
    end
    ::lbl_154::
    L10_2 = util
    L10_2 = L10_2.yield
    L10_2()
  end
  L4_2 = on
  if not L4_2 then
    L4_2 = clear_all_peds
    L4_2()
    simple_3d_started = false
  end
end
L50_1[L51_1] = L52_1
L50_1 = _ENV
L51_1 = "Set_condition_3D"
function L52_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = ped_health_selector
  L1_2 = L1_2.healh_values
  L1_2 = L1_2[A0_2]
  ped_health_3d = L1_2
  L1_2 = simple_3d_started
  if L1_2 then
    L1_2 = util
    L1_2 = L1_2.toast
    L2_2 = "将设定状况修改为>"
    L3_2 = ped_health_selector
    L3_2 = L3_2.display_options
    L3_2 = L3_2[A0_2]
    L4_2 = "< 更改将应用于下一场比赛"
    L2_2 = L2_2 .. L3_2 .. L4_2
    L1_2(L2_2)
  else
    L1_2 = util
    L1_2 = L1_2.toast
    L2_2 = "将设定状况修改为>"
    L3_2 = ped_health_selector
    L3_2 = L3_2.display_options
    L3_2 = L3_2[A0_2]
    L4_2 = "<"
    L2_2 = L2_2 .. L3_2 .. L4_2
    L1_2(L2_2)
  end
end
L50_1[L51_1] = L52_1
L50_1 = _ENV
L51_1 = "Set_shoot_time_3D"
function L52_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = time_selector
  L1_2 = L1_2.value
  L1_2 = L1_2[A0_2]
  L49_1 = L1_2
  L1_2 = simple_3d_started
  if L1_2 then
    L1_2 = util
    L1_2 = L1_2.toast
    L2_2 = "修改游戏时间至>"
    L3_2 = time_selector
    L3_2 = L3_2.display_options
    L3_2 = L3_2[A0_2]
    L4_2 = "< 更改将应用于下一场比赛"
    L2_2 = L2_2 .. L3_2 .. L4_2
    L1_2(L2_2)
  else
    L1_2 = util
    L1_2 = L1_2.toast
    L2_2 = "修改游戏时间至>"
    L3_2 = time_selector
    L3_2 = L3_2.display_options
    L3_2 = L3_2[A0_2]
    L4_2 = "<"
    L2_2 = L2_2 .. L3_2 .. L4_2
    L1_2(L2_2)
  end
end
L50_1[L51_1] = L52_1
L50_1 = _ENV
L51_1 = "Target_build_height_3D"
function L52_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = simple3d_target_max_height
  L1_2 = L1_2.height_value
  L1_2 = L1_2[A0_2]
  L46_1 = L1_2
  L1_2 = simple_3d_started
  if L1_2 then
    L1_2 = util
    L1_2 = L1_2.toast
    L2_2 = "将简单3D生成高度修改为 >"
    L3_2 = simple3d_target_max_height
    L3_2 = L3_2.display_options
    L3_2 = L3_2[A0_2]
    L4_2 = "< 更改将应用于下一场比赛"
    L2_2 = L2_2 .. L3_2 .. L4_2
    L1_2(L2_2)
  else
    L1_2 = util
    L1_2 = L1_2.toast
    L2_2 = "将简单3D生成高度修改为 >"
    L3_2 = simple3d_target_max_height
    L3_2 = L3_2.display_options
    L3_2 = L3_2[A0_2]
    L4_2 = "<"
    L2_2 = L2_2 .. L3_2 .. L4_2
    L1_2(L2_2)
  end
end
L50_1[L51_1] = L52_1
L50_1 = _ENV
L51_1 = "ped_health_2d"
L50_1[L51_1] = L47_1
L50_1 = 0
L51_1 = _ENV
L52_1 = "Shooting_simulation_2D"
function L53_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  on = A0_2
  simple_2d_started = true
  L1_2 = simple_3d_toggle
  L2_2 = L1_2
  L1_2 = L1_2.trigger
  L3_2 = false
  L1_2(L2_2, L3_2)
  L1_2 = L50_1
  time = L1_2
  L1_2 = menu
  L1_2 = L1_2.trigger_commands
  L2_2 = "time 11; locktime on"
  L1_2(L2_2)
  L1_2 = util
  L1_2 = L1_2.yield
  L2_2 = 1000
  L1_2(L2_2)
  L1_2 = clear_all_peds
  L1_2()
  L1_2 = util
  L1_2 = L1_2.yield
  L2_2 = 100
  L1_2(L2_2)
  L1_2 = create_ped_simple_2d
  L2_2 = ped_health_2d
  L1_2 = L1_2(L2_2)
  L2_2 = HUD
  L2_2 = L2_2.ADD_BLIP_FOR_ENTITY
  L3_2 = L1_2
  L2_2(L3_2)
  L2_2 = 0
  L3_2 = util
  L3_2 = L3_2.current_time_millis
  L3_2 = L3_2()
  L4_2 = time
  L3_2 = L3_2 + L4_2
  while true do
    L4_2 = on
    if not L4_2 then
      break
    end
    L4_2 = TASK
    L4_2 = L4_2.TASK_STAND_STILL
    L5_2 = L1_2
    L6_2 = 1000000
    L4_2(L5_2, L6_2)
    L4_2 = util
    L4_2 = L4_2.current_time_millis
    L4_2 = L4_2()
    L5_2 = L3_2 - L4_2
    L5_2 = L5_2 / 1000
    L6_2 = time
    if L6_2 > 0 then
      L6_2 = "得分: "
      L7_2 = L2_2
      L8_2 = " | 时间: "
      L9_2 = toint
      L10_2 = L5_2
      L9_2 = L9_2(L10_2)
      L6_2 = L6_2 .. L7_2 .. L8_2 .. L9_2
      txt = L6_2
    else
      L6_2 = "得分: "
      L7_2 = L2_2
      L8_2 = " | 时间: ∞"
      L6_2 = L6_2 .. L7_2 .. L8_2
      txt = L6_2
    end
    L6_2 = directx
    L6_2 = L6_2.get_text_size
    L7_2 = txt
    L8_2 = 0.7
    L6_2, L7_2 = L6_2(L7_2, L8_2)
    L8_2 = L6_2 / 2
    L9_2 = 0.5
    L8_2 = L9_2 - L8_2
    L9_2 = 0.015
    L10_2 = directx
    L10_2 = L10_2.draw_rect
    L11_2 = L8_2 - 0.01
    L12_2 = L9_2 - 0.01
    L13_2 = L6_2 + 0.02
    L14_2 = L7_2 + 0.02
    L15_2 = shoot_bg_colour
    L10_2(L11_2, L12_2, L13_2, L14_2, L15_2)
    L10_2 = directx
    L10_2 = L10_2.draw_text
    L11_2 = L8_2
    L12_2 = L9_2
    L13_2 = txt
    L14_2 = 0
    L15_2 = 0.7
    L16_2 = shoot_text_colour
    L17_2 = true
    L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
    if L5_2 <= 0 then
      L10_2 = time
      if L10_2 > 0 then
        L10_2 = util
        L10_2 = L10_2.toast
        L11_2 = "2D射击已经结束 | 得分: "
        L12_2 = L2_2
        L13_2 = " | 时间: "
        L14_2 = toint
        L15_2 = time
        L15_2 = L15_2 / 1000
        L14_2 = L14_2(L15_2)
        L15_2 = "s."
        L11_2 = L11_2 .. L12_2 .. L13_2 .. L14_2 .. L15_2
        L10_2(L11_2)
        simple_2d_started = false
        L10_2 = end_minigame
        L11_2 = simple_2d_toggle
        L10_2(L11_2)
      end
    end
    L10_2 = ENTITY
    L10_2 = L10_2.IS_ENTITY_DEAD
    L11_2 = L1_2
    L10_2 = L10_2(L11_2)
    if L10_2 then
      L10_2 = clear_dead_peds
      L10_2()
      if not (L5_2 > 0) then
        L10_2 = time
        if 0 ~= L10_2 then
          goto lbl_147
        end
      end
      L2_2 = L2_2 + 1
      L10_2 = create_ped_simple_2d
      L11_2 = ped_health_2d
      L10_2 = L10_2(L11_2)
      L1_2 = L10_2
      L10_2 = HUD
      L10_2 = L10_2.ADD_BLIP_FOR_ENTITY
      L11_2 = L1_2
      L10_2(L11_2)
    end
    ::lbl_147::
    L10_2 = util
    L10_2 = L10_2.yield
    L10_2()
  end
  L4_2 = on
  if not L4_2 then
    simple_2d_started = false
    L4_2 = clear_all_peds
    L4_2()
  end
end
L51_1[L52_1] = L53_1
L51_1 = _ENV
L52_1 = "Set_condition_2D"
function L53_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = ped_health_selector
  L1_2 = L1_2.healh_values
  L1_2 = L1_2[A0_2]
  ped_health_2d = L1_2
  L1_2 = simple_2d_started
  if L1_2 then
    L1_2 = util
    L1_2 = L1_2.toast
    L2_2 = "将设定状况修改为>"
    L3_2 = ped_health_selector
    L3_2 = L3_2.display_options
    L3_2 = L3_2[A0_2]
    L4_2 = "<更改将在下一场比赛中应用"
    L2_2 = L2_2 .. L3_2 .. L4_2
    L1_2(L2_2)
  else
    L1_2 = util
    L1_2 = L1_2.toast
    L2_2 = "将设定状况修改为>"
    L3_2 = ped_health_selector
    L3_2 = L3_2.display_options
    L3_2 = L3_2[A0_2]
    L4_2 = "<"
    L2_2 = L2_2 .. L3_2 .. L4_2
    L1_2(L2_2)
  end
end
L51_1[L52_1] = L53_1
L51_1 = _ENV
L52_1 = "Set_shoot_time_2D"
function L53_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = time_selector
  L1_2 = L1_2.value
  L1_2 = L1_2[A0_2]
  L50_1 = L1_2
  L1_2 = simple_2d_started
  if L1_2 then
    L1_2 = util
    L1_2 = L1_2.toast
    L2_2 = "修改游戏时间至>"
    L3_2 = time_selector
    L3_2 = L3_2.display_options
    L3_2 = L3_2[A0_2]
    L4_2 = "< 更改将在下一场比赛中应用。"
    L2_2 = L2_2 .. L3_2 .. L4_2
    L1_2(L2_2)
  else
    L1_2 = util
    L1_2 = L1_2.toast
    L2_2 = "修改游戏时间至>"
    L3_2 = time_selector
    L3_2 = L3_2.display_options
    L3_2 = L3_2[A0_2]
    L4_2 = "<"
    L2_2 = L2_2 .. L3_2 .. L4_2
    L1_2(L2_2)
  end
end
L51_1[L52_1] = L53_1
L51_1 = _ENV
L52_1 = "randomupdatcar_self"
function L53_1()
  local L0_2, L1_2, L2_2
  L0_2 = control_vehicle
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2 = L1_2()
  function L2_2(A0_3)
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
  L0_2(L1_2, L2_2)
end
L51_1[L52_1] = L53_1
L51_1 = {}
L52_1 = "rest"
L53_1 = 0
L51_1[L52_1] = L53_1
L52_1 = "C"
L53_1 = 16
L51_1[L52_1] = L53_1
L52_1 = "D"
L53_1 = 17
L51_1[L52_1] = L53_1
L52_1 = "E"
L53_1 = 18
L51_1[L52_1] = L53_1
L52_1 = "F"
L53_1 = 19
L51_1[L52_1] = L53_1
L52_1 = "G"
L53_1 = 20
L51_1[L52_1] = L53_1
L52_1 = "A"
L53_1 = 21
L51_1[L52_1] = L53_1
L52_1 = "B"
L53_1 = 22
L51_1[L52_1] = L53_1
L52_1 = "C2"
L53_1 = 23
L51_1[L52_1] = L53_1
L52_1 = 0
L53_1 = 0.25
L54_1 = 14
L55_1 = false
L56_1 = _ENV
L57_1 = "get_note"
function L58_1(A0_2)
  local L1_2, L2_2
  L1_2 = type
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if "table" ~= L1_2 then
    L1_2 = {}
    L1_2.pitch = A0_2
    A0_2 = L1_2
  end
  L1_2 = type
  L2_2 = A0_2.pitch
  L1_2 = L1_2(L2_2)
  if "number" ~= L1_2 then
    L2_2 = A0_2.pitch
    L1_2 = L51_1
    L1_2 = L1_2[L2_2]
    A0_2.pitch = L1_2
  end
  L1_2 = A0_2.length
  if nil == L1_2 then
    L1_2 = L53_1
    A0_2.length = L1_2
  end
  return A0_2
end
L56_1[L57_1] = L58_1
L56_1 = _ENV
L57_1 = "play_note"
function L58_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L4_2 = get_note
  L5_2 = A2_2
  L4_2 = L4_2(L5_2)
  A2_2 = L4_2
  L4_2 = math
  L4_2 = L4_2.floor
  L5_2 = A1_2.beat_length
  L6_2 = A2_2.length
  L5_2 = L5_2 * L6_2
  L4_2 = L4_2(L5_2)
  L5_2 = A2_2.pitch
  L6_2 = L52_1
  if L5_2 ~= L6_2 then
    L5_2 = true
    L55_1 = L5_2
  end
  L5_2 = util
  L5_2 = L5_2.yield
  L6_2 = L4_2
  L5_2(L6_2)
  L5_2 = false
  L55_1 = L5_2
  L5_2 = A1_2.notes
  L6_2 = A3_2 + 1
  L5_2 = L5_2[L6_2]
  if nil ~= L5_2 then
    L5_2 = get_note
    L6_2 = A1_2.notes
    L7_2 = A3_2 + 1
    L6_2 = L6_2[L7_2]
    L5_2 = L5_2(L6_2)
    L6_2 = L5_2.pitch
    L7_2 = L52_1
    if L6_2 ~= L7_2 then
      L6_2 = VEHICLE
      L6_2 = L6_2.SET_VEHICLE_MOD
      L7_2 = A0_2
      L8_2 = L54_1
      L9_2 = L5_2.pitch
      L6_2(L7_2, L8_2, L9_2)
    end
  end
  L5_2 = util
  L5_2 = L5_2.yield
  L6_2 = A1_2.beat_length
  L6_2 = L6_2 - L4_2
  L5_2(L6_2)
end
L56_1[L57_1] = L58_1
L56_1 = _ENV
L57_1 = "play_song"
function L58_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L1_2 = math
  L1_2 = L1_2.floor
  L2_2 = A0_2.bpm
  L3_2 = 60000
  L2_2 = L3_2 / L2_2
  L1_2 = L1_2(L2_2)
  A0_2.beat_length = L1_2
  L1_2 = PED
  L1_2 = L1_2.IS_PED_IN_ANY_VEHICLE
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = true
  L1_2 = L1_2(L2_2, L3_2)
  if not L1_2 then
    L1_2 = util
    L1_2 = L1_2.toast
    L2_2 = "你必须在车内,否则无法开启喇叭音乐."
    L1_2(L2_2)
    return
  end
  L1_2 = PED
  L1_2 = L1_2.GET_VEHICLE_PED_IS_IN
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = false
  L1_2 = L1_2(L2_2, L3_2)
  if L1_2 then
    L2_2 = VEHICLE
    L2_2 = L2_2.GET_VEHICLE_MOD
    L3_2 = L1_2
    L4_2 = L54_1
    L2_2 = L2_2(L3_2, L4_2)
    L3_2 = play_note
    L4_2 = L1_2
    L5_2 = A0_2
    L6_2 = L52_1
    L7_2 = 0
    L3_2(L4_2, L5_2, L6_2, L7_2)
    L3_2 = pairs
    L4_2 = A0_2.notes
    L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
    for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
      L9_2 = play_note
      L10_2 = L1_2
      L11_2 = A0_2
      L12_2 = L8_2
      L13_2 = L7_2
      L9_2(L10_2, L11_2, L12_2, L13_2)
    end
    L3_2 = VEHICLE
    L3_2 = L3_2.SET_VEHICLE_MOD
    L4_2 = L1_2
    L5_2 = L54_1
    L6_2 = L2_2
    L3_2(L4_2, L5_2, L6_2)
  end
end
L56_1[L57_1] = L58_1
L56_1 = _ENV
L57_1 = "load_song_from_file"
function L58_1(A0_2)
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
    L3_2 = L2_2.target_version
    if not L3_2 then
      L3_2 = util
      L3_2 = L3_2.toast
      L4_2 = "无效的喇叭文件格式.\n缺少了目标版本."
      L3_2(L4_2)
      L3_2 = 0
      return L3_2
    end
    L4_2 = L1_2
    L3_2 = L1_2.close
    L3_2(L4_2)
    return L2_2
  else
    L2_2 = error
    L3_2 = "无法读取文件"
    L4_2 = A0_2
    L5_2 = "'"
    L3_2 = L3_2 .. L4_2 .. L5_2
    L2_2(L3_2)
  end
  L2_2 = 0
  return L2_2
end
L56_1[L57_1] = L58_1
L56_1 = _ENV
L57_1 = "load_songs"
function L58_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L1_2 = {}
  L2_2 = ipairs
  L3_2 = filesystem
  L3_2 = L3_2.list_files
  L4_2 = A0_2
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L3_2(L4_2)
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = string
    L8_2 = L8_2.match
    L9_2 = L7_2
    L10_2 = ".+%.(%w+)$"
    L8_2 = L8_2(L9_2, L10_2)
    L9_2 = filesystem
    L9_2 = L9_2.is_dir
    L10_2 = L7_2
    L9_2 = L9_2(L10_2)
    if not L9_2 and "horn" == L8_2 then
      L9_2 = load_song_from_file
      L10_2 = L7_2
      L9_2 = L9_2(L10_2)
      if 0 ~= L9_2 then
        L10_2 = table
        L10_2 = L10_2.insert
        L11_2 = L1_2
        L12_2 = L9_2
        L10_2(L11_2, L12_2)
      end
    end
  end
  return L1_2
end
L56_1[L57_1] = L58_1
L56_1 = _ENV
L57_1 = "util"
L56_1 = L56_1[L57_1]
L57_1 = "create_tick_handler"
L56_1 = L56_1[L57_1]
function L57_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = L55_1
  if L0_2 then
    L0_2 = PAD2
    L0_2 = L0_2._SET_CONTROL_NORMAL
    L1_2 = 0
    L2_2 = 86
    L3_2 = 1
    L0_2(L1_2, L2_2, L3_2)
  end
  L0_2 = true
  return L0_2
end
L56_1(L57_1)
L56_1 = _ENV
L57_1 = "clean_select_entities"
function L58_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  if 1 == A0_2 then
    L1_2 = pairs
    L2_2 = entities
    L2_2 = L2_2.get_all_peds_as_handles
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L2_2()
    L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
      L7_2 = PED
      L7_2 = L7_2.IS_PED_A_PLAYER
      L8_2 = L6_2
      L7_2 = L7_2(L8_2)
      if not L7_2 then
        L7_2 = ENTITY
        L7_2 = L7_2.SET_ENTITY_AS_MISSION_ENTITY
        L8_2 = L6_2
        L9_2 = false
        L10_2 = false
        L7_2(L8_2, L9_2, L10_2)
        L7_2 = delete_entity
        L8_2 = L6_2
        L7_2(L8_2)
      end
    end
    L1_2 = util
    L1_2 = L1_2.toast
    L2_2 = "NPC清除完成"
    L1_2(L2_2)
    return
  end
  if 2 == A0_2 then
    L1_2 = pairs
    L2_2 = entities
    L2_2 = L2_2.get_all_vehicles_as_handles
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L2_2()
    L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
      L7_2 = VEHICLE
      L7_2 = L7_2.GET_PED_IN_VEHICLE_SEAT
      L8_2 = L6_2
      L9_2 = -1
      L10_2 = false
      L7_2 = L7_2(L8_2, L9_2, L10_2)
      L8_2 = PED
      L8_2 = L8_2.IS_PED_A_PLAYER
      L9_2 = L7_2
      L8_2 = L8_2(L9_2)
      if not L8_2 then
        L8_2 = ENTITY
        L8_2 = L8_2.SET_ENTITY_AS_MISSION_ENTITY
        L9_2 = L6_2
        L10_2 = false
        L11_2 = false
        L8_2(L9_2, L10_2, L11_2)
        L8_2 = delete_entity
        L9_2 = L6_2
        L8_2(L9_2)
      end
    end
    L1_2 = util
    L1_2 = L1_2.toast
    L2_2 = "载具清除完成"
    L1_2(L2_2)
    return
  end
  if 3 == A0_2 then
    L1_2 = pairs
    L2_2 = entities
    L2_2 = L2_2.get_all_objects_as_handles
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L2_2()
    L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
      L7_2 = ENTITY
      L7_2 = L7_2.SET_ENTITY_AS_MISSION_ENTITY
      L8_2 = L6_2
      L9_2 = false
      L10_2 = false
      L7_2(L8_2, L9_2, L10_2)
      L7_2 = delete_entity
      L8_2 = L6_2
      L7_2(L8_2)
    end
    L1_2 = util
    L1_2 = L1_2.toast
    L2_2 = "物体已清除"
    L1_2(L2_2)
    return
  end
  if 4 == A0_2 then
    L1_2 = pairs
    L2_2 = entities
    L2_2 = L2_2.get_all_pickups_as_handles
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L2_2()
    L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
      L7_2 = ENTITY
      L7_2 = L7_2.SET_ENTITY_AS_MISSION_ENTITY
      L8_2 = L6_2
      L9_2 = false
      L10_2 = false
      L7_2(L8_2, L9_2, L10_2)
      L7_2 = delete_entity
      L8_2 = L6_2
      L7_2(L8_2)
    end
    L1_2 = util
    L1_2 = L1_2.toast
    L2_2 = "拾取物已清除"
    L1_2(L2_2)
    return
  end
  if 5 == A0_2 then
    L1_2 = memory
    L1_2 = L1_2.alloc
    L2_2 = 4
    L1_2 = L1_2(L2_2)
    L2_2 = 0
    L3_2 = 100
    L4_2 = 1
    for L5_2 = L2_2, L3_2, L4_2 do
      L6_2 = memory
      L6_2 = L6_2.write_int
      L7_2 = L1_2
      L8_2 = L5_2
      L6_2(L7_2, L8_2)
      L6_2 = PHYSICS
      L6_2 = L6_2.DELETE_ROPE
      L7_2 = L1_2
      L6_2(L7_2)
    end
    L2_2 = util
    L2_2 = L2_2.toast
    L3_2 = "绳索已清除"
    L2_2(L3_2)
    return
  end
  if 6 == A0_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.GET_ENTITY_COORDS
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = false
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = MISC
    L2_2 = L2_2.CLEAR_AREA_OF_PROJECTILES
    L3_2 = L1_2.x
    L4_2 = L1_2.y
    L5_2 = L1_2.z
    L6_2 = 400
    L7_2 = 0
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
    L2_2 = util
    L2_2 = L2_2.toast
    L3_2 = "投掷物已清除"
    L2_2(L3_2)
    return
  end
end
L56_1[L57_1] = L58_1
L56_1 = _ENV
L57_1 = "Normal_clearance"
function L58_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L0_2 = 0
  L1_2 = pairs
  L2_2 = entities
  L2_2 = L2_2.get_all_vehicles_as_handles
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L2_2()
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = ENTITY
    L7_2 = L7_2.SET_ENTITY_AS_MISSION_ENTITY
    L8_2 = L6_2
    L9_2 = false
    L10_2 = false
    L7_2(L8_2, L9_2, L10_2)
    L7_2 = delete_entity
    L8_2 = L6_2
    L7_2(L8_2)
    L0_2 = L0_2 + 1
  end
  L1_2 = pairs
  L2_2 = entities
  L2_2 = L2_2.get_all_peds_as_handles
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L2_2()
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = PED
    L7_2 = L7_2.IS_PED_A_PLAYER
    L8_2 = L6_2
    L7_2 = L7_2(L8_2)
    if not L7_2 then
      L7_2 = ENTITY
      L7_2 = L7_2.SET_ENTITY_AS_MISSION_ENTITY
      L8_2 = L6_2
      L9_2 = false
      L10_2 = false
      L7_2(L8_2, L9_2, L10_2)
      L7_2 = delete_entity
      L8_2 = L6_2
      L7_2(L8_2)
    end
    L0_2 = L0_2 + 1
  end
end
L56_1[L57_1] = L58_1
L56_1 = _ENV
L57_1 = "super_clear"
function L58_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = 0
  L1_2 = pairs
  L2_2 = entities
  L2_2 = L2_2.get_all_peds_as_handles
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L2_2()
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = PLAYER
    L7_2 = L7_2.PLAYER_PED_ID
    L7_2 = L7_2()
    if L6_2 ~= L7_2 then
      L7_2 = PED
      L7_2 = L7_2.IS_PED_A_PLAYER
      L8_2 = L6_2
      L7_2 = L7_2(L8_2)
      if not L7_2 then
        L7_2 = NETWORK
        L7_2 = L7_2.NETWORK_HAS_CONTROL_OF_ENTITY
        L8_2 = L6_2
        L7_2 = L7_2(L8_2)
        if L7_2 then
          L7_2 = NETWORK
          L7_2 = L7_2.NETWORK_IS_ACTIVITY_SESSION
          L7_2 = L7_2()
          if L7_2 then
            L7_2 = NETWORK
            L7_2 = L7_2.NETWORK_IS_ACTIVITY_SESSION
            L7_2 = L7_2()
            if not L7_2 then
              goto lbl_49
            end
            L7_2 = ENTITY
            L7_2 = L7_2.IS_ENTITY_A_MISSION_ENTITY
            L8_2 = L6_2
            L7_2 = L7_2(L8_2)
            if L7_2 then
              goto lbl_49
            end
          end
          L7_2 = delete_entity
          L8_2 = L6_2
          L7_2(L8_2)
          L0_2 = L0_2 + 1
          L7_2 = util
          L7_2 = L7_2.yield_once
          L7_2()
        end
      end
    end
    ::lbl_49::
  end
  L1_2 = util
  L1_2 = L1_2.toast
  L2_2 = "已清除 "
  L3_2 = L0_2
  L4_2 = " Peds"
  L2_2 = L2_2 .. L3_2 .. L4_2
  L1_2(L2_2)
  L0_2 = 0
  L1_2 = ipairs
  L2_2 = entities
  L2_2 = L2_2.get_all_vehicles_as_handles
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L2_2()
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = PED
    L7_2 = L7_2.GET_VEHICLE_PED_IS_IN
    L8_2 = PLAYER
    L8_2 = L8_2.PLAYER_PED_ID
    L8_2 = L8_2()
    L9_2 = false
    L7_2 = L7_2(L8_2, L9_2)
    if L6_2 ~= L7_2 then
      L7_2 = DECORATOR
      L7_2 = L7_2.DECOR_GET_INT
      L8_2 = L6_2
      L9_2 = "Player_Vehicle"
      L7_2 = L7_2(L8_2, L9_2)
      if 0 == L7_2 then
        L7_2 = NETWORK
        L7_2 = L7_2.NETWORK_HAS_CONTROL_OF_ENTITY
        L8_2 = L6_2
        L7_2 = L7_2(L8_2)
        if L7_2 then
          L7_2 = delete_entity
          L8_2 = L6_2
          L7_2(L8_2)
          L0_2 = L0_2 + 1
          L7_2 = util
          L7_2 = L7_2.yield_once
          L7_2()
        end
      end
    end
  end
  L1_2 = util
  L1_2 = L1_2.toast
  L2_2 = "已清除 "
  L3_2 = L0_2
  L4_2 = " 载具"
  L2_2 = L2_2 .. L3_2 .. L4_2
  L1_2(L2_2)
  L0_2 = 0
  L1_2 = pairs
  L2_2 = entities
  L2_2 = L2_2.get_all_objects_as_handles
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L2_2()
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = delete_entity
    L8_2 = L6_2
    L7_2(L8_2)
    L0_2 = L0_2 + 1
    L7_2 = util
    L7_2 = L7_2.yield_once
    L7_2()
  end
  L1_2 = util
  L1_2 = L1_2.toast
  L2_2 = "已清除 "
  L3_2 = L0_2
  L4_2 = " 物体"
  L2_2 = L2_2 .. L3_2 .. L4_2
  L1_2(L2_2)
  L0_2 = 0
  L1_2 = pairs
  L2_2 = entities
  L2_2 = L2_2.get_all_pickups_as_handles
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L2_2()
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = delete_entity
    L8_2 = L6_2
    L7_2(L8_2)
    L0_2 = L0_2 + 1
    L7_2 = util
    L7_2 = L7_2.yield_once
    L7_2()
  end
  L1_2 = util
  L1_2 = L1_2.toast
  L2_2 = "已清除 "
  L3_2 = L0_2
  L4_2 = " 可拾取物体"
  L2_2 = L2_2 .. L3_2 .. L4_2
  L1_2(L2_2)
  L1_2 = memory
  L1_2 = L1_2.alloc
  L2_2 = 4
  L1_2 = L1_2(L2_2)
  L2_2 = 0
  L3_2 = 100
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = memory
    L6_2 = L6_2.write_int
    L7_2 = L1_2
    L8_2 = L5_2
    L6_2(L7_2, L8_2)
    L6_2 = PHYSICS
    L6_2 = L6_2.DELETE_ROPE
    L7_2 = L1_2
    L6_2(L7_2)
  end
  L2_2 = util
  L2_2 = L2_2.toast
  L3_2 = "已清除所有绳索"
  L2_2(L3_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L3_2()
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
  L3_2 = MISC
  L3_2 = L3_2.CLEAR_AREA_OF_PROJECTILES
  L4_2 = L2_2.x
  L5_2 = L2_2.y
  L6_2 = L2_2.z
  L7_2 = 400
  L8_2 = 0
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
  L3_2 = util
  L3_2 = L3_2.toast
  L4_2 = "已清除所有投掷物"
  L3_2(L4_2)
end
L56_1[L57_1] = L58_1
L56_1 = _ENV
L57_1 = "Delcar"
function L58_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = PED
  L1_2 = L1_2.IS_PED_IN_ANY_VEHICLE
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if true == L1_2 then
    L1_2 = PED
    L1_2 = L1_2.GET_VEHICLE_PED_IS_IN
    L2_2 = A0_2
    L3_2 = true
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = NETWORK
    L2_2 = L2_2.NETWORK_REQUEST_CONTROL_OF_ENTITY
    L3_2 = L1_2
    L2_2(L3_2)
    L2_2 = ENTITY
    L2_2 = L2_2.SET_ENTITY_AS_MISSION_ENTITY
    L3_2 = L1_2
    L2_2(L3_2)
    L2_2 = delete_entity
    L3_2 = L1_2
    L2_2(L3_2)
  end
end
L56_1[L57_1] = L58_1
L56_1 = {}
L57_1 = "weap"
L58_1 = "WEAPON_SNOWBALL"
L56_1[L57_1] = L58_1
L57_1 = _ENV
L58_1 = "Rain_on_players"
function L59_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED_SCRIPT_INDEX
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = L1_2
  L4_2 = true
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = util
  L3_2 = L3_2.joaat
  L4_2 = L56_1.weap
  L3_2 = L3_2(L4_2)
  L4_2 = Delcar
  L5_2 = L1_2
  L4_2(L5_2)
  L4_2 = WEAPON
  L4_2 = L4_2.REQUEST_WEAPON_ASSET
  L5_2 = L3_2
  L4_2(L5_2)
  L4_2 = MISC
  L4_2 = L4_2.SHOOT_SINGLE_BULLET_BETWEEN_COORDS
  L5_2 = L2_2.x
  L6_2 = L2_2.y
  L7_2 = L2_2.z
  L8_2 = L2_2.x
  L9_2 = L2_2.y
  L10_2 = L2_2.z
  L10_2 = L10_2 - 2.0
  L11_2 = 200
  L12_2 = 0
  L13_2 = L3_2
  L14_2 = 0
  L15_2 = true
  L16_2 = false
  L17_2 = 1000
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L4_2 = MISC
  L4_2 = L4_2.SHOOT_SINGLE_BULLET_BETWEEN_COORDS
  L5_2 = L2_2.x
  L6_2 = L2_2.y
  L7_2 = L2_2.z
  L7_2 = L7_2 + 1.0
  L8_2 = L2_2.x
  L9_2 = L2_2.y
  L10_2 = L2_2.z
  L11_2 = 200
  L12_2 = 0
  L13_2 = L3_2
  L14_2 = 0
  L15_2 = true
  L16_2 = false
  L17_2 = 1000
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L4_2 = MISC
  L4_2 = L4_2.SHOOT_SINGLE_BULLET_BETWEEN_COORDS
  L5_2 = L2_2.x
  L6_2 = L2_2.y
  L6_2 = L6_2 + 1.0
  L7_2 = L2_2.z
  L8_2 = L2_2.x
  L9_2 = L2_2.y
  L10_2 = L2_2.z
  L11_2 = 200
  L12_2 = 0
  L13_2 = L3_2
  L14_2 = 0
  L15_2 = true
  L16_2 = false
  L17_2 = 1000
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L4_2 = MISC
  L4_2 = L4_2.SHOOT_SINGLE_BULLET_BETWEEN_COORDS
  L5_2 = L2_2.x
  L5_2 = L5_2 + 1.0
  L6_2 = L2_2.y
  L7_2 = L2_2.z
  L8_2 = L2_2.x
  L9_2 = L2_2.y
  L10_2 = L2_2.z
  L11_2 = 200
  L12_2 = 0
  L13_2 = L3_2
  L14_2 = 0
  L15_2 = true
  L16_2 = false
  L17_2 = 1000
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L4_2 = MISC
  L4_2 = L4_2.SHOOT_SINGLE_BULLET_BETWEEN_COORDS
  L5_2 = L2_2.x
  L5_2 = L5_2 + 1.0
  L6_2 = L2_2.y
  L6_2 = L6_2 + 1.0
  L7_2 = L2_2.z
  L8_2 = L2_2.x
  L9_2 = L2_2.y
  L10_2 = L2_2.z
  L11_2 = 200
  L12_2 = 0
  L13_2 = L3_2
  L14_2 = 0
  L15_2 = true
  L16_2 = false
  L17_2 = 1000
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L4_2 = MISC
  L4_2 = L4_2.SHOOT_SINGLE_BULLET_BETWEEN_COORDS
  L5_2 = L2_2.x
  L5_2 = L5_2 - 1.0
  L6_2 = L2_2.y
  L7_2 = L2_2.z
  L8_2 = L2_2.x
  L9_2 = L2_2.y
  L10_2 = L2_2.z
  L11_2 = 200
  L12_2 = 0
  L13_2 = L3_2
  L14_2 = 0
  L15_2 = true
  L16_2 = false
  L17_2 = 1000
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L4_2 = MISC
  L4_2 = L4_2.SHOOT_SINGLE_BULLET_BETWEEN_COORDS
  L5_2 = L2_2.x
  L6_2 = L2_2.y
  L6_2 = L6_2 - 1.0
  L7_2 = L2_2.z
  L8_2 = L2_2.x
  L9_2 = L2_2.y
  L10_2 = L2_2.z
  L11_2 = 200
  L12_2 = 0
  L13_2 = L3_2
  L14_2 = 0
  L15_2 = true
  L16_2 = false
  L17_2 = 1000
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L4_2 = MISC
  L4_2 = L4_2.SHOOT_SINGLE_BULLET_BETWEEN_COORDS
  L5_2 = L2_2.x
  L5_2 = L5_2 - 1.0
  L6_2 = L2_2.y
  L6_2 = L6_2 - 1.0
  L7_2 = L2_2.z
  L8_2 = L2_2.x
  L9_2 = L2_2.y
  L10_2 = L2_2.z
  L11_2 = 200
  L12_2 = 0
  L13_2 = L3_2
  L14_2 = 0
  L15_2 = true
  L16_2 = false
  L17_2 = 1000
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
end
L57_1[L58_1] = L59_1
L57_1 = _ENV
L58_1 = "Rain_on_players_type"
function L59_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  L2_2 = Weap
  L2_2 = L2_2[A0_2]
  L56_1.weap = L2_2
  L2_2 = menu
  L2_2 = L2_2.set_menu_name
  L3_2 = mirloop
  L4_2 = "在玩家身上下雨 "
  L5_2 = ": "
  L6_2 = A1_2
  L4_2 = L4_2 .. L5_2 .. L6_2
  L2_2(L3_2, L4_2)
end
L57_1[L58_1] = L59_1
L57_1 = _ENV
L58_1 = "get_model_size"
function L59_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
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
  L4_2 = memory
  L4_2 = L4_2.read_vector3
  L5_2 = L2_2
  L4_2 = L4_2(L5_2)
  L5_2 = {}
  L6_2 = L4_2.x
  L7_2 = L3_2.x
  L6_2 = L6_2 - L7_2
  L5_2.x = L6_2
  L6_2 = L4_2.y
  L7_2 = L3_2.y
  L6_2 = L6_2 - L7_2
  L5_2.y = L6_2
  L6_2 = L4_2.z
  L7_2 = L3_2.z
  L6_2 = L6_2 - L7_2
  L5_2.z = L6_2
  L6_2 = math
  L6_2 = L6_2.max
  L7_2 = L5_2.x
  L8_2 = L5_2.y
  L9_2 = L5_2.z
  L6_2 = L6_2(L7_2, L8_2, L9_2)
  L5_2.max = L6_2
  return L5_2
end
L57_1[L58_1] = L59_1
L57_1 = _ENV
L58_1 = "setstacky"
function L59_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2
  L1_2 = entities
  L1_2 = L1_2.get_user_vehicle_as_handle
  L1_2 = L1_2()
  if 0 ~= L1_2 then
    old_veh = L1_2
    L2_2 = 1
    L3_2 = A0_2
    L4_2 = 1
    for L5_2 = L2_2, L3_2, L4_2 do
      L6_2 = ENTITY
      L6_2 = L6_2.GET_ENTITY_COORDS
      L7_2 = old_veh
      L8_2 = false
      L6_2 = L6_2(L7_2, L8_2)
      L7_2 = ENTITY
      L7_2 = L7_2.GET_ENTITY_MODEL
      L8_2 = L1_2
      L7_2 = L7_2(L8_2)
      L8_2 = get_model_size
      L9_2 = L7_2
      L8_2 = L8_2(L9_2)
      L9_2 = ENTITY
      L9_2 = L9_2.GET_ENTITY_ROTATION
      L10_2 = old_veh
      L11_2 = 0
      L9_2 = L9_2(L10_2, L11_2)
      L10_2 = entities
      L10_2 = L10_2.create_vehicle
      L11_2 = L7_2
      L12_2 = players
      L12_2 = L12_2.get_position
      L13_2 = PLAYER
      L13_2 = L13_2.PLAYER_ID
      L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2 = L13_2()
      L12_2 = L12_2(L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
      L13_2 = ENTITY
      L13_2 = L13_2.GET_ENTITY_HEADING
      L14_2 = old_veh
      L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2 = L13_2(L14_2)
      L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
      new_veh = L10_2
      L10_2 = ENTITY
      L10_2 = L10_2.ATTACH_ENTITY_TO_ENTITY
      L11_2 = new_veh
      L12_2 = old_veh
      L13_2 = 0
      L14_2 = 0.0
      L15_2 = 0.0
      L16_2 = L8_2.z
      L17_2 = 0.0
      L18_2 = 0.0
      L19_2 = 0.0
      L20_2 = true
      L21_2 = false
      L22_2 = false
      L23_2 = false
      L24_2 = 0
      L25_2 = true
      L26_2 = 0
      L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
      L10_2 = new_veh
      old_veh = L10_2
    end
  end
end
L57_1[L58_1] = L59_1
L57_1 = _ENV
L58_1 = "setstackx"
function L59_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2
  L1_2 = entities
  L1_2 = L1_2.get_user_vehicle_as_handle
  L1_2 = L1_2()
  if 0 ~= L1_2 then
    L2_2 = 1
    L3_2 = A0_2
    L4_2 = 1
    for L5_2 = L2_2, L3_2, L4_2 do
      main_veh = L1_2
      L6_2 = ENTITY
      L6_2 = L6_2.GET_ENTITY_COORDS
      L7_2 = main_veh
      L8_2 = false
      L6_2 = L6_2(L7_2, L8_2)
      L7_2 = ENTITY
      L7_2 = L7_2.GET_ENTITY_MODEL
      L8_2 = main_veh
      L7_2 = L7_2(L8_2)
      L8_2 = get_model_size
      L9_2 = L7_2
      L8_2 = L8_2(L9_2)
      L9_2 = ENTITY
      L9_2 = L9_2.GET_ENTITY_ROTATION
      L10_2 = main_veh
      L11_2 = 0
      L9_2 = L9_2(L10_2, L11_2)
      L10_2 = entities
      L10_2 = L10_2.create_vehicle
      L11_2 = L7_2
      L12_2 = players
      L12_2 = L12_2.get_position
      L13_2 = PLAYER
      L13_2 = L13_2.PLAYER_ID
      L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2 = L13_2()
      L12_2 = L12_2(L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
      L13_2 = ENTITY
      L13_2 = L13_2.GET_ENTITY_HEADING
      L14_2 = main_veh
      L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2 = L13_2(L14_2)
      L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
      left_new = L10_2
      L10_2 = ENTITY
      L10_2 = L10_2.ATTACH_ENTITY_TO_ENTITY
      L11_2 = left_new
      L12_2 = main_veh
      L13_2 = 0
      L14_2 = L8_2.x
      L14_2 = -L14_2
      L14_2 = L14_2 * L5_2
      L15_2 = 0.0
      L16_2 = 0.0
      L17_2 = 0.0
      L18_2 = 0.0
      L19_2 = 0.0
      L20_2 = true
      L21_2 = false
      L22_2 = false
      L23_2 = false
      L24_2 = 0
      L25_2 = true
      L26_2 = 0
      L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
      L10_2 = entities
      L10_2 = L10_2.create_vehicle
      L11_2 = L7_2
      L12_2 = players
      L12_2 = L12_2.get_position
      L13_2 = PLAYER
      L13_2 = L13_2.PLAYER_ID
      L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2 = L13_2()
      L12_2 = L12_2(L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
      L13_2 = ENTITY
      L13_2 = L13_2.GET_ENTITY_HEADING
      L14_2 = main_veh
      L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2 = L13_2(L14_2)
      L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
      right_new = L10_2
      L10_2 = ENTITY
      L10_2 = L10_2.ATTACH_ENTITY_TO_ENTITY
      L11_2 = right_new
      L12_2 = main_veh
      L13_2 = 0
      L14_2 = L8_2.x
      L14_2 = L14_2 * L5_2
      L15_2 = 0.0
      L16_2 = 0.0
      L17_2 = 0.0
      L18_2 = 0.0
      L19_2 = 0.0
      L20_2 = true
      L21_2 = false
      L22_2 = false
      L23_2 = false
      L24_2 = 0
      L25_2 = true
      L26_2 = 0
      L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2)
    end
  end
end
L57_1[L58_1] = L59_1
L57_1 = _ENV
L58_1 = "get_closest_veh"
function L59_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L1_2 = nil
  L2_2 = 1000000
  L3_2 = 0
  L4_2 = pairs
  L5_2 = entities
  L5_2 = L5_2.get_all_vehicles_as_handles
  L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L5_2()
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
    L10_2 = v3
    L10_2 = L10_2.distance
    L11_2 = A0_2
    L12_2 = ENTITY
    L12_2 = L12_2.GET_ENTITY_COORDS
    L13_2 = L9_2
    L12_2, L13_2 = L12_2(L13_2)
    L10_2 = L10_2(L11_2, L12_2, L13_2)
    L3_2 = L10_2
    if L2_2 > L3_2 then
      L10_2 = ENTITY
      L10_2 = L10_2.GET_ENTITY_HEALTH
      L11_2 = L9_2
      L10_2 = L10_2(L11_2)
      if L10_2 > 0 then
        L1_2 = L9_2
        L2_2 = L3_2
      end
    end
  end
  if nil ~= L1_2 then
    L4_2 = {}
    L5_2 = L1_2
    L6_2 = L2_2
    L4_2[1] = L5_2
    L4_2[2] = L6_2
    return L4_2
  else
    L4_2 = nil
    return L4_2
  end
end
L57_1[L58_1] = L59_1
L57_1 = _ENV
L58_1 = "request_control_of_entity_once"
function L59_1(A0_2)
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
L57_1[L58_1] = L59_1
L57_1 = 0
L58_1 = false
L59_1 = 0
L60_1 = _ENV
L61_1 = "throwvehs"
function L62_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  L0_2 = PAD
  L0_2 = L0_2.IS_CONTROL_JUST_RELEASED
  L1_2 = 38
  L2_2 = 38
  L0_2 = L0_2(L1_2, L2_2)
  if L0_2 then
    L0_2 = PED
    L0_2 = L0_2.IS_PED_IN_ANY_VEHICLE
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_PED_ID
    L1_2 = L1_2()
    L2_2 = true
    L0_2 = L0_2(L1_2, L2_2)
    if not L0_2 then
      L0_2 = L57_1
      if 0 == L0_2 then
        L0_2 = L58_1
        if not L0_2 then
          L0_2 = get_closest_veh
          L1_2 = ENTITY
          L1_2 = L1_2.GET_ENTITY_COORDS
          L2_2 = PLAYER
          L2_2 = L2_2.PLAYER_PED_ID
          L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L2_2()
          L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
          L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
          L1_2 = L0_2[1]
          if nil ~= L1_2 then
            L2_2 = L0_2[2]
            if L2_2 <= 5 then
              L3_2 = request_anim_dict
              L4_2 = "missminuteman_1ig_2"
              L3_2(L4_2)
              L3_2 = TASK
              L3_2 = L3_2.TASK_PLAY_ANIM
              L4_2 = PLAYER
              L4_2 = L4_2.PLAYER_PED_ID
              L4_2 = L4_2()
              L5_2 = "missminuteman_1ig_2"
              L6_2 = "handsup_enter"
              L7_2 = 8.0
              L8_2 = 0.0
              L9_2 = -1
              L10_2 = 50
              L11_2 = 0
              L12_2 = false
              L13_2 = false
              L14_2 = false
              L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
              L3_2 = util
              L3_2 = L3_2.yield
              L4_2 = 500
              L3_2(L4_2)
              L3_2 = true
              L58_1 = L3_2
              L3_2 = ENTITY
              L3_2 = L3_2.SET_ENTITY_ALPHA
              L4_2 = L1_2
              L5_2 = 100
              L3_2(L4_2, L5_2)
              L3_2 = ENTITY
              L3_2 = L3_2.SET_ENTITY_HEADING
              L4_2 = L1_2
              L5_2 = ENTITY
              L5_2 = L5_2.GET_ENTITY_HEADING
              L6_2 = PLAYER
              L6_2 = L6_2.PLAYER_PED_ID
              L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L6_2()
              L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
              L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
              L3_2 = ENTITY
              L3_2 = L3_2.SET_ENTITY_INVINCIBLE
              L4_2 = L1_2
              L5_2 = true
              L3_2(L4_2, L5_2)
              L3_2 = request_control_of_entity_once
              L4_2 = L1_2
              L3_2(L4_2)
              L3_2 = ENTITY
              L3_2 = L3_2.ATTACH_ENTITY_TO_ENTITY
              L4_2 = L1_2
              L5_2 = PLAYER
              L5_2 = L5_2.PLAYER_PED_ID
              L5_2 = L5_2()
              L6_2 = 0
              L7_2 = 0
              L8_2 = 0
              L9_2 = get_model_size
              L10_2 = ENTITY
              L10_2 = L10_2.GET_ENTITY_MODEL
              L11_2 = L1_2
              L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L10_2(L11_2)
              L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
              L9_2 = L9_2.z
              L9_2 = L9_2 / 2
              L10_2 = 180
              L11_2 = 180
              L12_2 = -180
              L13_2 = true
              L14_2 = false
              L15_2 = true
              L16_2 = false
              L17_2 = 0
              L18_2 = true
              L19_2 = 0
              L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
              L57_1 = L1_2
            end
          end
        else
          L0_2 = TASK
          L0_2 = L0_2.CLEAR_PED_TASKS_IMMEDIATELY
          L1_2 = PLAYER
          L1_2 = L1_2.PLAYER_PED_ID
          L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L1_2()
          L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
          L0_2 = false
          L58_1 = L0_2
        end
      else
        L0_2 = ENTITY
        L0_2 = L0_2.IS_ENTITY_A_VEHICLE
        L1_2 = L57_1
        L0_2 = L0_2(L1_2)
        if L0_2 then
          L0_2 = ENTITY
          L0_2 = L0_2.DETACH_ENTITY
          L1_2 = L57_1
          L0_2(L1_2)
          L0_2 = VEHICLE
          L0_2 = L0_2.SET_VEHICLE_FORWARD_SPEED
          L1_2 = L57_1
          L2_2 = 100.0
          L0_2(L1_2, L2_2)
          L0_2 = VEHICLE
          L0_2 = L0_2.SET_VEHICLE_OUT_OF_CONTROL
          L1_2 = L57_1
          L2_2 = true
          L3_2 = true
          L0_2(L1_2, L2_2, L3_2)
          L0_2 = ENTITY
          L0_2 = L0_2.SET_ENTITY_ALPHA
          L1_2 = L57_1
          L2_2 = 255
          L0_2(L1_2, L2_2)
          L0_2 = ENTITY
          L0_2 = L0_2.SET_ENTITY_INVINCIBLE
          L1_2 = L57_1
          L2_2 = false
          L0_2(L1_2, L2_2)
          L0_2 = TASK
          L0_2 = L0_2.CLEAR_PED_TASKS_IMMEDIATELY
          L1_2 = PLAYER
          L1_2 = L1_2.PLAYER_PED_ID
          L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L1_2()
          L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
          L0_2 = ENTITY
          L0_2 = L0_2.FREEZE_ENTITY_POSITION
          L1_2 = PLAYER
          L1_2 = L1_2.PLAYER_PED_ID
          L1_2 = L1_2()
          L2_2 = true
          L0_2(L1_2, L2_2)
          L0_2 = ENTITY
          L0_2 = L0_2.SET_ENTITY_NO_COLLISION_ENTITY
          L1_2 = L57_1
          L2_2 = PLAYER
          L2_2 = L2_2.PLAYER_PED_ID
          L2_2 = L2_2()
          L3_2 = false
          L0_2(L1_2, L2_2, L3_2)
          L0_2 = request_anim_dict
          L1_2 = "melee@unarmed@streamed_core"
          L0_2(L1_2)
          L0_2 = TASK
          L0_2 = L0_2.TASK_PLAY_ANIM
          L1_2 = PLAYER
          L1_2 = L1_2.PLAYER_PED_ID
          L1_2 = L1_2()
          L2_2 = "melee@unarmed@streamed_core"
          L3_2 = "heavy_punch_a"
          L4_2 = 8.0
          L5_2 = 8.0
          L6_2 = -1
          L7_2 = 0
          L8_2 = 0.3
          L9_2 = false
          L10_2 = false
          L11_2 = false
          L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
          L0_2 = util
          L0_2 = L0_2.yield
          L1_2 = 500
          L0_2(L1_2)
          L0_2 = ENTITY
          L0_2 = L0_2.FREEZE_ENTITY_POSITION
          L1_2 = PLAYER
          L1_2 = L1_2.PLAYER_PED_ID
          L1_2 = L1_2()
          L2_2 = false
          L0_2(L1_2, L2_2)
          L0_2 = 0
          L57_1 = L0_2
          L0_2 = false
          L58_1 = L0_2
        end
      end
    end
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "get_closest_ped_new"
function L62_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L1_2 = nil
  L2_2 = 1000000
  L3_2 = 0
  L4_2 = pairs
  L5_2 = entities
  L5_2 = L5_2.get_all_peds_as_handles
  L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L5_2()
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
    L10_2 = v3
    L10_2 = L10_2.distance
    L11_2 = A0_2
    L12_2 = ENTITY
    L12_2 = L12_2.GET_ENTITY_COORDS
    L13_2 = L9_2
    L12_2, L13_2 = L12_2(L13_2)
    L10_2 = L10_2(L11_2, L12_2, L13_2)
    L3_2 = L10_2
    if L2_2 > L3_2 then
      L10_2 = PED
      L10_2 = L10_2.IS_PED_A_PLAYER
      L11_2 = L9_2
      L10_2 = L10_2(L11_2)
      if not L10_2 then
        L10_2 = PED
        L10_2 = L10_2.IS_PED_FATALLY_INJURED
        L11_2 = L9_2
        L10_2 = L10_2(L11_2)
        if not L10_2 then
          L10_2 = PED
          L10_2 = L10_2.IS_PED_IN_ANY_VEHICLE
          L11_2 = L9_2
          L12_2 = true
          L10_2 = L10_2(L11_2, L12_2)
          if not L10_2 then
            L1_2 = L9_2
            L2_2 = L3_2
          end
        end
      end
    end
  end
  if nil ~= L1_2 then
    L4_2 = {}
    L5_2 = L1_2
    L6_2 = L2_2
    L4_2[1] = L5_2
    L4_2[2] = L6_2
    return L4_2
  else
    L4_2 = nil
    return L4_2
  end
end
L60_1[L61_1] = L62_1
L60_1 = _ENV
L61_1 = "throwpeds"
function L62_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  L0_2 = PAD
  L0_2 = L0_2.IS_CONTROL_JUST_RELEASED
  L1_2 = 38
  L2_2 = 38
  L0_2 = L0_2(L1_2, L2_2)
  if L0_2 then
    L0_2 = PED
    L0_2 = L0_2.IS_PED_IN_ANY_VEHICLE
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_PED_ID
    L1_2 = L1_2()
    L2_2 = true
    L0_2 = L0_2(L1_2, L2_2)
    if not L0_2 then
      L0_2 = L57_1
      if 0 == L0_2 then
        L0_2 = L58_1
        if not L0_2 then
          L0_2 = get_closest_ped_new
          L1_2 = ENTITY
          L1_2 = L1_2.GET_ENTITY_COORDS
          L2_2 = PLAYER
          L2_2 = L2_2.PLAYER_PED_ID
          L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L2_2()
          L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
          L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
          if nil ~= L0_2 then
            L1_2 = L0_2[1]
            if nil ~= L1_2 then
              L2_2 = L0_2[2]
              if L2_2 <= 5 then
                L3_2 = request_anim_dict
                L4_2 = "missminuteman_1ig_2"
                L3_2(L4_2)
                L3_2 = TASK
                L3_2 = L3_2.TASK_PLAY_ANIM
                L4_2 = PLAYER
                L4_2 = L4_2.PLAYER_PED_ID
                L4_2 = L4_2()
                L5_2 = "missminuteman_1ig_2"
                L6_2 = "handsup_enter"
                L7_2 = 8.0
                L8_2 = 0.0
                L9_2 = -1
                L10_2 = 50
                L11_2 = 0
                L12_2 = false
                L13_2 = false
                L14_2 = false
                L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
                L3_2 = util
                L3_2 = L3_2.yield
                L4_2 = 500
                L3_2(L4_2)
                L3_2 = true
                L58_1 = L3_2
                L3_2 = ENTITY
                L3_2 = L3_2.SET_ENTITY_ALPHA
                L4_2 = L1_2
                L5_2 = 100
                L3_2(L4_2, L5_2)
                L3_2 = ENTITY
                L3_2 = L3_2.SET_ENTITY_HEADING
                L4_2 = L1_2
                L5_2 = ENTITY
                L5_2 = L5_2.GET_ENTITY_HEADING
                L6_2 = PLAYER
                L6_2 = L6_2.PLAYER_PED_ID
                L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L6_2()
                L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
                L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
                L3_2 = request_control_of_entity_once
                L4_2 = L1_2
                L3_2(L4_2)
                L3_2 = ENTITY
                L3_2 = L3_2.ATTACH_ENTITY_TO_ENTITY
                L4_2 = L1_2
                L5_2 = PLAYER
                L5_2 = L5_2.PLAYER_PED_ID
                L5_2 = L5_2()
                L6_2 = 0
                L7_2 = 0
                L8_2 = 0
                L9_2 = 1.3
                L10_2 = 180
                L11_2 = 180
                L12_2 = -180
                L13_2 = true
                L14_2 = false
                L15_2 = true
                L16_2 = true
                L17_2 = 0
                L18_2 = true
                L19_2 = 0
                L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
                L57_1 = L1_2
              end
            end
          end
        else
          L0_2 = TASK
          L0_2 = L0_2.CLEAR_PED_TASKS_IMMEDIATELY
          L1_2 = PLAYER
          L1_2 = L1_2.PLAYER_PED_ID
          L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L1_2()
          L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
          L0_2 = false
          L58_1 = L0_2
        end
      else
        L0_2 = ENTITY
        L0_2 = L0_2.IS_ENTITY_A_PED
        L1_2 = L57_1
        L0_2 = L0_2(L1_2)
        if L0_2 then
          L0_2 = ENTITY
          L0_2 = L0_2.DETACH_ENTITY
          L1_2 = L57_1
          L0_2(L1_2)
          L0_2 = ENTITY
          L0_2 = L0_2.SET_ENTITY_ALPHA
          L1_2 = L57_1
          L2_2 = 255
          L0_2(L1_2, L2_2)
          L0_2 = PED
          L0_2 = L0_2.SET_PED_TO_RAGDOLL
          L1_2 = L57_1
          L2_2 = 10
          L3_2 = 10
          L4_2 = 0
          L5_2 = false
          L6_2 = false
          L7_2 = false
          L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
          L0_2 = ENTITY
          L0_2 = L0_2.SET_ENTITY_MAX_SPEED
          L1_2 = L57_1
          L2_2 = 100.0
          L0_2(L1_2, L2_2)
          L0_2 = ENTITY
          L0_2 = L0_2.APPLY_FORCE_TO_ENTITY
          L1_2 = L57_1
          L2_2 = 1
          L3_2 = 0
          L4_2 = 100
          L5_2 = 0
          L6_2 = 0
          L7_2 = 0
          L8_2 = 0
          L9_2 = 0
          L10_2 = true
          L11_2 = false
          L12_2 = true
          L13_2 = false
          L14_2 = false
          L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
          L0_2 = AUDIO
          L0_2 = L0_2.PLAY_PAIN
          L1_2 = L57_1
          L2_2 = 7
          L3_2 = 0
          L4_2 = 0
          L0_2(L1_2, L2_2, L3_2, L4_2)
          L0_2 = TASK
          L0_2 = L0_2.CLEAR_PED_TASKS_IMMEDIATELY
          L1_2 = PLAYER
          L1_2 = L1_2.PLAYER_PED_ID
          L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L1_2()
          L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
          L0_2 = ENTITY
          L0_2 = L0_2.FREEZE_ENTITY_POSITION
          L1_2 = PLAYER
          L1_2 = L1_2.PLAYER_PED_ID
          L1_2 = L1_2()
          L2_2 = true
          L0_2(L1_2, L2_2)
          L0_2 = ENTITY
          L0_2 = L0_2.SET_ENTITY_NO_COLLISION_ENTITY
          L1_2 = L57_1
          L2_2 = PLAYER
          L2_2 = L2_2.PLAYER_PED_ID
          L2_2 = L2_2()
          L3_2 = false
          L0_2(L1_2, L2_2, L3_2)
          L0_2 = request_anim_dict
          L1_2 = "melee@unarmed@streamed_core"
          L0_2(L1_2)
          L0_2 = TASK
          L0_2 = L0_2.TASK_PLAY_ANIM
          L1_2 = PLAYER
          L1_2 = L1_2.PLAYER_PED_ID
          L1_2 = L1_2()
          L2_2 = "melee@unarmed@streamed_core"
          L3_2 = "heavy_punch_a"
          L4_2 = 8.0
          L5_2 = 8.0
          L6_2 = -1
          L7_2 = 0
          L8_2 = 0.3
          L9_2 = false
          L10_2 = false
          L11_2 = false
          L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
          L0_2 = util
          L0_2 = L0_2.yield
          L1_2 = 500
          L0_2(L1_2)
          L0_2 = ENTITY
          L0_2 = L0_2.FREEZE_ENTITY_POSITION
          L1_2 = PLAYER
          L1_2 = L1_2.PLAYER_PED_ID
          L1_2 = L1_2()
          L2_2 = false
          L0_2(L1_2, L2_2)
          L0_2 = 0
          L57_1 = L0_2
          L0_2 = false
          L58_1 = L0_2
        end
      end
    end
  end
end
L60_1[L61_1] = L62_1
L60_1 = 0
L61_1 = 0
L62_1 = -1
L63_1 = _ENV
L64_1 = "max_out_car"
function L65_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = 0
  L2_2 = 49
  L3_2 = 1
  for L4_2 = L1_2, L2_2, L3_2 do
    L5_2 = VEHICLE
    L5_2 = L5_2.GET_NUM_VEHICLE_MODS
    L6_2 = A0_2
    L7_2 = L4_2
    L5_2 = L5_2(L6_2, L7_2)
    num = L5_2
    L5_2 = VEHICLE
    L5_2 = L5_2.SET_VEHICLE_MOD
    L6_2 = A0_2
    L7_2 = L4_2
    L8_2 = num
    L8_2 = L8_2 - 1
    L9_2 = true
    L5_2(L6_2, L7_2, L8_2, L9_2)
  end
end
L63_1[L64_1] = L65_1
L63_1 = _ENV
L64_1 = "summ_car"
function L65_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = A1_2
  L2_2 = L2_2(L3_2)
  L3_2 = util
  L3_2 = L3_2.joaat
  L4_2 = "s_m_y_casino_01"
  L3_2 = L3_2(L4_2)
  L4_2 = L61_1
  if 0 ~= L4_2 then
    L4_2 = delete_entity
    L5_2 = L61_1
    L4_2(L5_2)
  end
  L4_2 = L60_1
  if 0 ~= L4_2 then
    L4_2 = util
    L4_2 = L4_2.remove_blip
    L5_2 = L62_1
    L4_2(L5_2)
    L4_2 = delete_entity
    L5_2 = L60_1
    L4_2(L5_2)
  end
  L4_2 = PLAYER
  L4_2 = L4_2.PLAYER_PED_ID
  L4_2 = L4_2()
  L5_2 = ENTITY
  L5_2 = L5_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L6_2 = L4_2
  L7_2 = 0.0
  L8_2 = 5.0
  L9_2 = 0.0
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
  L6_2 = request_model
  L7_2 = L2_2
  L6_2(L7_2)
  L6_2 = request_model
  L7_2 = L3_2
  L6_2(L7_2)
  L6_2 = entities
  L6_2 = L6_2.create_vehicle
  L7_2 = L2_2
  L8_2 = L5_2
  L9_2 = ENTITY
  L9_2 = L9_2.GET_ENTITY_HEADING
  L10_2 = L4_2
  L9_2, L10_2, L11_2 = L9_2(L10_2)
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
  L61_1 = L6_2
  L6_2 = max_out_car
  L7_2 = L61_1
  L6_2(L7_2)
  L6_2 = VEHICLE
  L6_2 = L6_2.SET_VEHICLE_NUMBER_PLATE_TEXT
  L7_2 = L61_1
  L8_2 = "LANCE"
  L6_2(L7_2, L8_2)
  L6_2 = VEHICLE
  L6_2 = L6_2.SET_VEHICLE_COLOURS
  L7_2 = L61_1
  L8_2 = 145
  L9_2 = 145
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = ENTITY
  L6_2 = L6_2.SET_ENTITY_INVINCIBLE
  L7_2 = L61_1
  L8_2 = true
  L6_2(L7_2, L8_2)
  L6_2 = entities
  L6_2 = L6_2.create_ped
  L7_2 = 32
  L8_2 = L3_2
  L9_2 = L5_2
  L10_2 = ENTITY
  L10_2 = L10_2.GET_ENTITY_HEADING
  L11_2 = L4_2
  L10_2, L11_2 = L10_2(L11_2)
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
  L60_1 = L6_2
  L6_2 = PED
  L6_2 = L6_2.SET_PED_RELATIONSHIP_GROUP_HASH
  L7_2 = L60_1
  L8_2 = util
  L8_2 = L8_2.joaat
  L9_2 = "rgFM_AiLike"
  L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2)
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
  L6_2 = HUD
  L6_2 = L6_2.ADD_BLIP_FOR_ENTITY
  L7_2 = L60_1
  L6_2 = L6_2(L7_2)
  L62_1 = L6_2
  L6_2 = HUD
  L6_2 = L6_2.SET_BLIP_COLOUR
  L7_2 = L62_1
  L8_2 = 7
  L6_2(L7_2, L8_2)
  L6_2 = ENTITY
  L6_2 = L6_2.SET_ENTITY_INVINCIBLE
  L7_2 = L60_1
  L8_2 = true
  L6_2(L7_2, L8_2)
  L6_2 = PED
  L6_2 = L6_2.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS
  L7_2 = L60_1
  L8_2 = true
  L6_2(L7_2, L8_2)
  L6_2 = PED
  L6_2 = L6_2.SET_PED_FLEE_ATTRIBUTES
  L7_2 = L60_1
  L8_2 = 0
  L9_2 = false
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = PED
  L6_2 = L6_2.SET_PED_CAN_BE_DRAGGED_OUT
  L7_2 = L60_1
  L8_2 = false
  L6_2(L7_2, L8_2)
  L6_2 = VEHICLE
  L6_2 = L6_2.SET_VEHICLE_EXCLUSIVE_DRIVER
  L7_2 = L61_1
  L8_2 = L60_1
  L9_2 = -1
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = PED
  L6_2 = L6_2.SET_PED_INTO_VEHICLE
  L7_2 = L60_1
  L8_2 = L61_1
  L9_2 = -1
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = ENTITY
  L6_2 = L6_2.SET_ENTITY_INVINCIBLE
  L7_2 = L60_1
  L8_2 = true
  L6_2(L7_2, L8_2)
  L6_2 = PED
  L6_2 = L6_2.SET_PED_INTO_VEHICLE
  L7_2 = PLAYER
  L7_2 = L7_2.PLAYER_PED_ID
  L7_2 = L7_2()
  L8_2 = L61_1
  L9_2 = 0
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = util
  L6_2 = L6_2.toast
  L7_2 = "您的司机已创建！"
  L6_2(L7_2)
end
L63_1[L64_1] = L65_1
L63_1 = _ENV
L64_1 = "summ_car_topoint"
function L65_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = L60_1
  if 0 == L0_2 then
    L0_2 = util
    L0_2 = L0_2.toast
    L1_2 = "你没有生成司机"
    L0_2(L1_2)
  else
    L0_2 = get_waypoint_coords
    L0_2 = L0_2()
    if nil ~= L0_2 then
      L1_2 = TASK
      L1_2 = L1_2.TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE
      L2_2 = L60_1
      L3_2 = L61_1
      L4_2 = L0_2.x
      L5_2 = L0_2.y
      L6_2 = L0_2.z
      L7_2 = 300.0
      L8_2 = 786996
      L9_2 = 5
      L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    end
  end
end
L63_1[L64_1] = L65_1
L63_1 = _ENV
L64_1 = "summ_car_tp"
function L65_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = L60_1
  if 0 == L0_2 then
    L0_2 = util
    L0_2 = L0_2.toast
    L1_2 = "你没有生成司机."
    L0_2(L1_2)
  else
    L0_2 = PED
    L0_2 = L0_2.SET_PED_INTO_VEHICLE
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_PED_ID
    L1_2 = L1_2()
    L2_2 = L61_1
    L3_2 = 0
    L0_2(L1_2, L2_2, L3_2)
  end
end
L63_1[L64_1] = L65_1
L63_1 = _ENV
L64_1 = "summ_car_bmob"
function L65_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L0_2 = L60_1
  if 0 == L0_2 then
    L0_2 = util
    L0_2 = L0_2.toast
    L1_2 = "你没有生成司机."
    L0_2(L1_2)
  else
    L0_2 = L60_1
    L1_2 = L61_1
    L2_2 = 0
    L60_1 = L2_2
    L2_2 = 0
    L61_1 = L2_2
    L2_2 = ENTITY
    L2_2 = L2_2.GET_ENTITY_COORDS
    L3_2 = L1_2
    L2_2 = L2_2(L3_2)
    L3_2 = ENTITY
    L3_2 = L3_2.SET_ENTITY_INVINCIBLE
    L4_2 = L1_2
    L5_2 = false
    L3_2(L4_2, L5_2)
    L3_2 = FIRE
    L3_2 = L3_2.ADD_EXPLOSION
    L4_2 = L2_2.x
    L5_2 = L2_2.y
    L6_2 = L2_2.z
    L7_2 = 7
    L8_2 = 100.0
    L9_2 = true
    L10_2 = false
    L11_2 = 1.0
    L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    L3_2 = ENTITY
    L3_2 = L3_2.SET_ENTITY_HEALTH
    L4_2 = L1_2
    L5_2 = 0
    L3_2(L4_2, L5_2)
    L3_2 = ENTITY
    L3_2 = L3_2.SET_ENTITY_INVINCIBLE
    L4_2 = L0_2
    L5_2 = false
    L3_2(L4_2, L5_2)
    L3_2 = ENTITY
    L3_2 = L3_2.SET_ENTITY_HEALTH
    L4_2 = L0_2
    L5_2 = 0
    L3_2(L4_2, L5_2)
    L3_2 = math
    L3_2 = L3_2.random
    L4_2 = 5
    L3_2 = L3_2(L4_2)
    if 3 == L3_2 then
      L3_2 = util
      L3_2 = L3_2.toast
      L4_2 = "他有老婆孩子..."
      L3_2(L4_2)
    end
    L3_2 = util
    L3_2 = L3_2.yield
    L4_2 = 3000
    L3_2(L4_2)
    L3_2 = delete_entity
    L4_2 = L0_2
    L3_2(L4_2)
    L3_2 = delete_entity
    L4_2 = L1_2
    L3_2(L4_2)
  end
end
L63_1[L64_1] = L65_1
L63_1 = _ENV
L64_1 = "custom_TurnVehicle"
function L65_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
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
  L2_2 = PAD
  L2_2 = L2_2.IS_CONTROL_PRESSED
  L3_2 = 0
  L4_2 = 63
  L2_2 = L2_2(L3_2, L4_2)
  if L2_2 then
    L2_2 = L1_2.z
    L2_2 = L2_2 + 3
    L3_2 = 180
    if L2_2 > L3_2 then
      L3_2 = math
      L3_2 = L3_2.abs
      L4_2 = L1_2.z
      L3_2 = L3_2(L4_2)
      L3_2 = L3_2 * -1
      L4_2 = L3_2 + 3
      L5_2 = ENTITY
      L5_2 = L5_2.SET_ENTITY_ROTATION
      L6_2 = L0_2
      L7_2 = L1_2.x
      L8_2 = L1_2.y
      L9_2 = L4_2
      L10_2 = 2
      L11_2 = true
      L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    else
      L3_2 = ENTITY
      L3_2 = L3_2.SET_ENTITY_ROTATION
      L4_2 = L0_2
      L5_2 = L1_2.x
      L6_2 = L1_2.y
      L7_2 = L2_2
      L8_2 = 2
      L9_2 = true
      L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    end
  else
    L2_2 = PAD
    L2_2 = L2_2.IS_CONTROL_PRESSED
    L3_2 = 0
    L4_2 = 64
    L2_2 = L2_2(L3_2, L4_2)
    if L2_2 then
      L2_2 = L1_2.z
      L2_2 = L2_2 - 3
      L3_2 = -180
      if L2_2 < L3_2 then
        L3_2 = math
        L3_2 = L3_2.abs
        L4_2 = L1_2.z
        L3_2 = L3_2(L4_2)
        L4_2 = L3_2 - 3
        L5_2 = ENTITY
        L5_2 = L5_2.SET_ENTITY_ROTATION
        L6_2 = L0_2
        L7_2 = L1_2.x
        L8_2 = L1_2.y
        L9_2 = L4_2
        L10_2 = 2
        L11_2 = true
        L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
      else
        L3_2 = ENTITY
        L3_2 = L3_2.SET_ENTITY_ROTATION
        L4_2 = L0_2
        L5_2 = L1_2.x
        L6_2 = L1_2.y
        L7_2 = L2_2
        L8_2 = 2
        L9_2 = true
        L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
      end
    end
  end
end
L63_1[L64_1] = L65_1
L63_1 = _ENV
L64_1 = "test_elevator"
function L65_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "prop_test_elevator"
  L1_2 = L1_2(L2_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = PLAYER
  L3_2 = L3_2.GET_PLAYER_PED
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = false
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = 0
  L4_2 = 90
  L5_2 = 90
  for L6_2 = L3_2, L4_2, L5_2 do
    L7_2 = create_object
    L8_2 = L1_2
    L9_2 = L2_2.x
    L10_2 = L2_2.y
    L11_2 = L2_2.z
    L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2)
    L8_2 = ENTITY
    L8_2 = L8_2.SET_ENTITY_HEADING
    L9_2 = L7_2
    L10_2 = L6_2
    L8_2(L9_2, L10_2)
    L8_2 = ENTITY
    L8_2 = L8_2.SET_ENTITY_INVINCIBLE
    L9_2 = L7_2
    L10_2 = true
    L8_2(L9_2, L10_2)
    L8_2 = ENTITY
    L8_2 = L8_2.FREEZE_ENTITY_POSITION
    L9_2 = L7_2
    L10_2 = true
    L8_2(L9_2, L10_2)
  end
end
L63_1[L64_1] = L65_1
L63_1 = _ENV
L64_1 = "pillar_cage"
function L65_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "v_ret_fh_doorframe"
  L1_2 = L1_2(L2_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = PLAYER
  L3_2 = L3_2.GET_PLAYER_PED
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = false
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = 0
  L4_2 = 135
  L5_2 = 45
  for L6_2 = L3_2, L4_2, L5_2 do
    L7_2 = create_object
    L8_2 = L1_2
    L9_2 = L2_2.x
    L10_2 = L2_2.y
    L11_2 = L2_2.z
    L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2)
    L8_2 = ENTITY
    L8_2 = L8_2.SET_ENTITY_HEADING
    L9_2 = L7_2
    L10_2 = L6_2
    L8_2(L9_2, L10_2)
    L8_2 = ENTITY
    L8_2 = L8_2.SET_ENTITY_INVINCIBLE
    L9_2 = L7_2
    L10_2 = true
    L8_2(L9_2, L10_2)
    L8_2 = ENTITY
    L8_2 = L8_2.FREEZE_ENTITY_POSITION
    L9_2 = L7_2
    L10_2 = true
    L8_2(L9_2, L10_2)
  end
end
L63_1[L64_1] = L65_1
L63_1 = _ENV
L64_1 = "fence_cage"
function L65_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "prop_fnclink_03e"
  L1_2 = L1_2(L2_2)
  L2_2 = request_model
  L3_2 = L1_2
  L2_2(L3_2)
  L2_2 = players
  L2_2 = L2_2.get_position
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = L2_2.z
  L3_2 = L3_2 - 1.0
  L2_2.z = L3_2
  L3_2 = {}
  L4_2 = entities
  L4_2 = L4_2.create_object
  L5_2 = L1_2
  L6_2 = v3
  L6_2 = L6_2.new
  L7_2 = L2_2.x
  L7_2 = L7_2 - 1.5
  L8_2 = L2_2.y
  L8_2 = L8_2 + 1.5
  L9_2 = L2_2.z
  L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L6_2(L7_2, L8_2, L9_2)
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L3_2[1] = L4_2
  L4_2 = entities
  L4_2 = L4_2.create_object
  L5_2 = L1_2
  L6_2 = v3
  L6_2 = L6_2.new
  L7_2 = L2_2.x
  L7_2 = L7_2 - 1.5
  L8_2 = L2_2.y
  L8_2 = L8_2 - 1.5
  L9_2 = L2_2.z
  L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L6_2(L7_2, L8_2, L9_2)
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L3_2[2] = L4_2
  L4_2 = entities
  L4_2 = L4_2.create_object
  L5_2 = L1_2
  L6_2 = v3
  L6_2 = L6_2.new
  L7_2 = L2_2.x
  L7_2 = L7_2 + 1.5
  L8_2 = L2_2.y
  L8_2 = L8_2 + 1.5
  L9_2 = L2_2.z
  L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L6_2(L7_2, L8_2, L9_2)
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L3_2[3] = L4_2
  L4_2 = ENTITY
  L4_2 = L4_2.GET_ENTITY_ROTATION
  L5_2 = L3_2[3]
  L6_2 = 2
  L4_2 = L4_2(L5_2, L6_2)
  L4_2.z = -90.0
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_ROTATION
  L6_2 = L3_2[3]
  L7_2 = L4_2.x
  L8_2 = L4_2.y
  L9_2 = L4_2.z
  L10_2 = 1
  L11_2 = true
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L5_2 = entities
  L5_2 = L5_2.create_object
  L6_2 = L1_2
  L7_2 = v3
  L7_2 = L7_2.new
  L8_2 = L2_2.x
  L8_2 = L8_2 - 1.5
  L9_2 = L2_2.y
  L9_2 = L9_2 + 1.5
  L10_2 = L2_2.z
  L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L7_2(L8_2, L9_2, L10_2)
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L3_2[4] = L5_2
  L5_2 = ENTITY
  L5_2 = L5_2.GET_ENTITY_ROTATION
  L6_2 = L3_2[4]
  L7_2 = 2
  L5_2 = L5_2(L6_2, L7_2)
  L5_2.z = -90.0
  L6_2 = ENTITY
  L6_2 = L6_2.SET_ENTITY_ROTATION
  L7_2 = L3_2[4]
  L8_2 = L5_2.x
  L9_2 = L5_2.y
  L10_2 = L5_2.z
  L11_2 = 1
  L12_2 = true
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L6_2 = 1
  L7_2 = 4
  L8_2 = 1
  for L9_2 = L6_2, L7_2, L8_2 do
    L10_2 = ENTITY
    L10_2 = L10_2.FREEZE_ENTITY_POSITION
    L11_2 = L3_2[L9_2]
    L12_2 = true
    L10_2(L11_2, L12_2)
  end
  L6_2 = STREAMING
  L6_2 = L6_2.SET_MODEL_AS_NO_LONGER_NEEDED
  L7_2 = L1_2
  L6_2(L7_2)
end
L63_1[L64_1] = L65_1
L63_1 = _ENV
L64_1 = "hell_cage"
function L65_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "hei_prop_station_gate"
  L1_2 = L1_2(L2_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = PLAYER
  L3_2 = L3_2.GET_PLAYER_PED
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = false
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = L2_2.z
  L3_2 = L3_2 - 1.0
  L2_2.z = L3_2
  L3_2 = {}
  L4_2 = create_object
  L5_2 = L1_2
  L6_2 = L2_2.x
  L6_2 = L6_2 + 2.75
  L7_2 = L2_2.y
  L7_2 = L7_2 + 2.75
  L8_2 = L2_2.z
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  L3_2[1] = L4_2
  L4_2 = create_object
  L5_2 = L1_2
  L6_2 = L2_2.x
  L6_2 = L6_2 + 2.75
  L7_2 = L2_2.y
  L7_2 = L7_2 + 2.75
  L8_2 = L2_2.z
  L8_2 = L8_2 + 2
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  L3_2[2] = L4_2
  L4_2 = create_object
  L5_2 = L1_2
  L6_2 = L2_2.x
  L6_2 = L6_2 + 2.75
  L7_2 = L2_2.y
  L7_2 = L7_2 - 2.75
  L8_2 = L2_2.z
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  L3_2[3] = L4_2
  L4_2 = create_object
  L5_2 = L1_2
  L6_2 = L2_2.x
  L6_2 = L6_2 + 2.75
  L7_2 = L2_2.y
  L7_2 = L7_2 - 2.75
  L8_2 = L2_2.z
  L8_2 = L8_2 + 2
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  L3_2[4] = L4_2
  L4_2 = create_object
  L5_2 = L1_2
  L6_2 = L2_2.x
  L6_2 = L6_2 + 2.75
  L7_2 = L2_2.y
  L7_2 = L7_2 - 2.75
  L8_2 = L2_2.z
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  L3_2[5] = L4_2
  L4_2 = create_object
  L5_2 = L1_2
  L6_2 = L2_2.x
  L6_2 = L6_2 + 2.75
  L7_2 = L2_2.y
  L7_2 = L7_2 - 2.75
  L8_2 = L2_2.z
  L8_2 = L8_2 + 2
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  L3_2[6] = L4_2
  L4_2 = ENTITY
  L4_2 = L4_2.GET_ENTITY_ROTATION
  L5_2 = L3_2[5]
  L6_2 = 2
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_ROTATION
  L6_2 = L3_2[5]
  L7_2 = L4_2.x
  L8_2 = L4_2.y
  L9_2 = -90.0
  L10_2 = 2
  L11_2 = true
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_ROTATION
  L6_2 = L3_2[6]
  L7_2 = L4_2.x
  L8_2 = L4_2.y
  L9_2 = -90.0
  L10_2 = 2
  L11_2 = true
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L5_2 = create_object
  L6_2 = L1_2
  L7_2 = L2_2.x
  L7_2 = L7_2 - 2.75
  L8_2 = L2_2.y
  L8_2 = L8_2 - 2.75
  L9_2 = L2_2.z
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
  L3_2[7] = L5_2
  L5_2 = create_object
  L6_2 = L1_2
  L7_2 = L2_2.x
  L7_2 = L7_2 - 2.75
  L8_2 = L2_2.y
  L8_2 = L8_2 - 2.75
  L9_2 = L2_2.z
  L9_2 = L9_2 + 2
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
  L3_2[8] = L5_2
  L5_2 = ENTITY
  L5_2 = L5_2.GET_ENTITY_ROTATION
  L6_2 = L3_2[7]
  L7_2 = 2
  L5_2 = L5_2(L6_2, L7_2)
  L6_2 = ENTITY
  L6_2 = L6_2.SET_ENTITY_ROTATION
  L7_2 = L3_2[7]
  L8_2 = L5_2.x
  L9_2 = L5_2.y
  L10_2 = -90.0
  L11_2 = 2
  L12_2 = true
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L6_2 = ENTITY
  L6_2 = L6_2.SET_ENTITY_ROTATION
  L7_2 = L3_2[8]
  L8_2 = L5_2.x
  L9_2 = L5_2.y
  L10_2 = -90.0
  L11_2 = 2
  L12_2 = true
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L6_2 = create_object
  L7_2 = L1_2
  L8_2 = L2_2.x
  L9_2 = L2_2.y
  L9_2 = L9_2 + 2.75
  L10_2 = L2_2.z
  L10_2 = L10_2 + 5
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
  L3_2[9] = L6_2
  L6_2 = ENTITY
  L6_2 = L6_2.GET_ENTITY_ROTATION
  L7_2 = L3_2[9]
  L8_2 = 2
  L6_2 = L6_2(L7_2, L8_2)
  L7_2 = ENTITY
  L7_2 = L7_2.SET_ENTITY_ROTATION
  L8_2 = L3_2[9]
  L9_2 = 90
  L10_2 = 90
  L11_2 = L6_2.z
  L12_2 = 2
  L13_2 = true
  L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L7_2 = create_object
  L8_2 = L1_2
  L9_2 = L2_2.x
  L10_2 = L2_2.y
  L10_2 = L10_2 + 2.75
  L11_2 = L2_2.z
  L11_2 = L11_2 + 5
  L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2)
  L3_2[10] = L7_2
  L7_2 = ENTITY
  L7_2 = L7_2.GET_ENTITY_ROTATION
  L8_2 = L3_2[9]
  L9_2 = 2
  L7_2 = L7_2(L8_2, L9_2)
  L8_2 = ENTITY
  L8_2 = L8_2.SET_ENTITY_ROTATION
  L9_2 = L3_2[10]
  L10_2 = -90
  L11_2 = -90
  L12_2 = L7_2.z
  L13_2 = 2
  L14_2 = true
  L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  L8_2 = create_object
  L9_2 = L1_2
  L10_2 = L2_2.x
  L11_2 = L2_2.y
  L11_2 = L11_2 + 2.75
  L12_2 = L2_2.z
  L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2)
  L3_2[11] = L8_2
  L8_2 = ENTITY
  L8_2 = L8_2.SET_ENTITY_ROTATION
  L9_2 = L3_2[11]
  L10_2 = 90
  L11_2 = 90
  L12_2 = L6_2.z
  L13_2 = 2
  L14_2 = true
  L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  L8_2 = create_object
  L9_2 = L1_2
  L10_2 = L2_2.x
  L11_2 = L2_2.y
  L11_2 = L11_2 + 2.75
  L12_2 = L2_2.z
  L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2)
  L3_2[12] = L8_2
  L8_2 = ENTITY
  L8_2 = L8_2.SET_ENTITY_ROTATION
  L9_2 = L3_2[12]
  L10_2 = -90
  L11_2 = -90
  L12_2 = L7_2.z
  L13_2 = 2
  L14_2 = true
  L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  L8_2 = 1
  L9_2 = 12
  L10_2 = 1
  for L11_2 = L8_2, L9_2, L10_2 do
    L12_2 = ENTITY
    L12_2 = L12_2.FREEZE_ENTITY_POSITION
    L13_2 = L3_2[L11_2]
    L14_2 = true
    L12_2(L13_2, L14_2)
    L12_2 = ENTITY
    L12_2 = L12_2.SET_ENTITY_VISIBLE
    L13_2 = L3_2[L11_2]
    L14_2 = true
    L12_2(L13_2, L14_2)
  end
end
L63_1[L64_1] = L65_1
L63_1 = _ENV
L64_1 = "kidnapplayer"
function L65_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2
  L3_2 = util
  L3_2 = L3_2.joaat
  L4_2 = "s_m_y_factory_01"
  L3_2 = L3_2(L4_2)
  L4_2 = 0
  if 1 == A1_2 then
    L5_2 = util
    L5_2 = L5_2.joaat
    L6_2 = "boxville3"
    L5_2 = L5_2(L6_2)
    L4_2 = L5_2
  elseif 2 == A1_2 then
    L5_2 = util
    L5_2 = L5_2.joaat
    L6_2 = "cargobob"
    L5_2 = L5_2(L6_2)
    L4_2 = L5_2
  end
  L5_2 = PLAYER
  L5_2 = L5_2.GET_PLAYER_PED_SCRIPT_INDEX
  L6_2 = A0_2
  L5_2 = L5_2(L6_2)
  L6_2 = request_model
  L7_2 = L4_2
  L6_2(L7_2)
  L6_2 = request_model
  L7_2 = L3_2
  L6_2(L7_2)
  L6_2 = ENTITY
  L6_2 = L6_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L7_2 = L5_2
  L8_2 = 0.0
  L9_2 = 2.0
  L10_2 = 0.0
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
  L7_2 = entities
  L7_2 = L7_2.create_vehicle
  L8_2 = L4_2
  L9_2 = L6_2
  L10_2 = ENTITY
  L10_2 = L10_2.GET_ENTITY_HEADING
  L11_2 = L5_2
  L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2 = L10_2(L11_2)
  L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
  L8_2 = entities
  L8_2 = L8_2.create_ped
  L9_2 = 5
  L10_2 = L3_2
  L11_2 = L6_2
  L12_2 = 0
  L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2)
  L9_2 = PED
  L9_2 = L9_2.SET_PED_INTO_VEHICLE
  L10_2 = L8_2
  L11_2 = L7_2
  L12_2 = -1
  L9_2(L10_2, L11_2, L12_2)
  L9_2 = PED
  L9_2 = L9_2.SET_PED_FLEE_ATTRIBUTES
  L10_2 = L8_2
  L11_2 = 0
  L12_2 = false
  L9_2(L10_2, L11_2, L12_2)
  L9_2 = ENTITY
  L9_2 = L9_2.SET_ENTITY_INVINCIBLE
  L10_2 = L8_2
  L11_2 = true
  L9_2(L10_2, L11_2)
  L9_2 = ENTITY
  L9_2 = L9_2.SET_ENTITY_INVINCIBLE
  L10_2 = L7_2
  L11_2 = true
  L9_2(L10_2, L11_2)
  L9_2 = request_model
  L10_2 = prop_hash
  L9_2(L10_2)
  L9_2 = PED
  L9_2 = L9_2.SET_PED_CAN_BE_DRAGGED_OUT
  L10_2 = L8_2
  L11_2 = false
  L9_2(L10_2, L11_2)
  L9_2 = PED
  L9_2 = L9_2.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS
  L10_2 = L8_2
  L11_2 = true
  L9_2(L10_2, L11_2)
  L9_2 = util
  L9_2 = L9_2.yield
  L10_2 = 2000
  L9_2(L10_2)
  if 1 == A1_2 then
    L9_2 = TASK
    L9_2 = L9_2.TASK_VEHICLE_DRIVE_TO_COORD
    L10_2 = L8_2
    L11_2 = L7_2
    L12_2 = math
    L12_2 = L12_2.random
    L13_2 = 1000
    L12_2 = L12_2(L13_2)
    L13_2 = math
    L13_2 = L13_2.random
    L14_2 = 1000
    L13_2 = L13_2(L14_2)
    L14_2 = math
    L14_2 = L14_2.random
    L15_2 = 100
    L14_2 = L14_2(L15_2)
    L15_2 = 100
    L16_2 = 1
    L17_2 = ENTITY
    L17_2 = L17_2.GET_ENTITY_MODEL
    L18_2 = L7_2
    L17_2 = L17_2(L18_2)
    L18_2 = 786996
    L19_2 = 5
    L20_2 = 0
    L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
  elseif 2 == A1_2 then
    L9_2 = TASK
    L9_2 = L9_2.TASK_HELI_MISSION
    L10_2 = L8_2
    L11_2 = L7_2
    L12_2 = 0
    L13_2 = 0
    L14_2 = math
    L14_2 = L14_2.random
    L15_2 = 1000
    L14_2 = L14_2(L15_2)
    L15_2 = math
    L15_2 = L15_2.random
    L16_2 = 1000
    L15_2 = L15_2(L16_2)
    L16_2 = 1500
    L17_2 = 4
    L18_2 = 200.0
    L19_2 = 0.0
    L20_2 = 0
    L21_2 = 100
    L22_2 = 1000
    L23_2 = 0.0
    L24_2 = 16
    L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
  end
end
L63_1[L64_1] = L65_1
L63_1 = _ENV
L64_1 = "tramway_cage"
function L65_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "p_cablecar_s"
  L1_2 = L1_2(L2_2)
  L2_2 = players
  L2_2 = L2_2.get_position
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = OBJECT
  L3_2 = L3_2.CREATE_OBJECT_NO_OFFSET
  L4_2 = L1_2
  L5_2 = L2_2.x
  L6_2 = L2_2.y
  L6_2 = L6_2 - 0.1
  L7_2 = L2_2.z
  L7_2 = L7_2 + 4.2
  L8_2 = true
  L9_2 = false
  L10_2 = false
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  L4_2 = ENTITY
  L4_2 = L4_2.FREEZE_ENTITY_POSITION
  L5_2 = L3_2
  L6_2 = true
  L4_2(L5_2, L6_2)
end
L63_1[L64_1] = L65_1
L63_1 = _ENV
L64_1 = "Kegs_cage"
function L65_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "prop_feeder1_cr"
  L1_2 = L1_2(L2_2)
  L2_2 = players
  L2_2 = L2_2.get_position
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = entities
  L3_2 = L3_2.create_object
  L4_2 = L1_2
  L5_2 = v3
  L6_2 = L2_2.x
  L7_2 = L2_2.y
  L8_2 = L2_2.z
  L8_2 = L8_2 - 1
  L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2, L7_2, L8_2)
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
  L3_2 = entities
  L3_2 = L3_2.create_object
  L4_2 = L1_2
  L5_2 = v3
  L6_2 = L2_2.x
  L7_2 = L2_2.y
  L8_2 = L2_2.z
  L8_2 = L8_2 + 1
  L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2, L7_2, L8_2)
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
end
L63_1[L64_1] = L65_1
L63_1 = _ENV
L64_1 = "Shock_cage"
function L65_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2
  L1_2 = 6
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "prop_elecbox_12"
  L2_2 = L2_2(L3_2)
  L3_2 = players
  L3_2 = L3_2.get_position
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = L3_2.z
  L4_2 = L4_2 - 0.5
  L3_2.z = L4_2
  L4_2 = request_model
  L5_2 = L2_2
  L4_2(L5_2)
  L4_2 = v3
  L4_2 = L4_2.new
  L5_2 = 0
  L6_2 = 0
  L7_2 = 0
  L4_2 = L4_2(L5_2, L6_2, L7_2)
  L5_2 = 1
  L6_2 = L1_2
  L7_2 = 1
  for L8_2 = L5_2, L6_2, L7_2 do
    L9_2 = L8_2 / L1_2
    L9_2 = L9_2 * 360
    L4_2.z = L9_2
    L11_2 = L4_2
    L10_2 = L4_2.toDir
    L10_2 = L10_2(L11_2)
    L12_2 = L10_2
    L11_2 = L10_2.mul
    L13_2 = 2.5
    L11_2(L12_2, L13_2)
    L12_2 = L10_2
    L11_2 = L10_2.add
    L13_2 = L3_2
    L11_2(L12_2, L13_2)
    L11_2 = 1
    L12_2 = 5
    L13_2 = 1
    for L14_2 = L11_2, L12_2, L13_2 do
      L15_2 = entities
      L15_2 = L15_2.create_object
      L16_2 = L2_2
      L17_2 = L10_2
      L15_2 = L15_2(L16_2, L17_2)
      L16_2 = ENTITY
      L16_2 = L16_2.SET_ENTITY_ROTATION
      L17_2 = L15_2
      L18_2 = 90.0
      L19_2 = 0.0
      L20_2 = L9_2
      L21_2 = 2
      L22_2 = 0
      L16_2(L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
      L16_2 = L10_2.z
      L16_2 = L16_2 + 0.75
      L10_2.z = L16_2
      L16_2 = ENTITY
      L16_2 = L16_2.FREEZE_ENTITY_POSITION
      L17_2 = L15_2
      L18_2 = true
      L16_2(L17_2, L18_2)
    end
  end
end
L63_1[L64_1] = L65_1
L63_1 = _ENV
L64_1 = "gueencage"
function L65_1(A0_2)
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
    L18_2 = 2
    L19_2 = 0
    L13_2(L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
    L13_2 = ENTITY
    L13_2 = L13_2.FREEZE_ENTITY_POSITION
    L14_2 = L12_2
    L15_2 = true
    L13_2(L14_2, L15_2)
  end
end
L63_1[L64_1] = L65_1
L63_1 = _ENV
L64_1 = "gascage"
function L65_1(A0_2)
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
L63_1[L64_1] = L65_1
L63_1 = _ENV
L64_1 = "Container_cage"
function L65_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "prop_container_ld_pu"
  L1_2 = L1_2(L2_2)
  L2_2 = players
  L2_2 = L2_2.get_position
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = request_model
  L4_2 = L1_2
  L3_2(L4_2)
  L3_2 = L2_2.z
  L3_2 = L3_2 - 1
  L2_2.z = L3_2
  L3_2 = entities
  L3_2 = L3_2.create_object
  L4_2 = L1_2
  L5_2 = L2_2
  L6_2 = 0
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  L4_2 = ENTITY
  L4_2 = L4_2.FREEZE_ENTITY_POSITION
  L5_2 = L3_2
  L6_2 = true
  L4_2(L5_2, L6_2)
end
L63_1[L64_1] = L65_1
L63_1 = _ENV
L64_1 = "Vehicle_cage"
function L65_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "boxville3"
  L1_2 = L1_2(L2_2)
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = players
  L3_2 = L3_2.get_position
  L4_2 = A0_2
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
L63_1[L64_1] = L65_1
L63_1 = _ENV
L64_1 = "Close_dog"
function L65_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED_SCRIPT_INDEX
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = L1_2
  L4_2 = true
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = L2_2.x
  L2_2.x = L3_2
  L3_2 = L2_2.y
  L2_2.y = L3_2
  L3_2 = L2_2.z
  L2_2.z = L3_2
  L3_2 = 779277682
  L4_2 = request_model
  L5_2 = L3_2
  L4_2(L5_2)
  L4_2 = OBJECT
  L4_2 = L4_2.CREATE_OBJECT_NO_OFFSET
  L5_2 = L3_2
  L6_2 = L2_2.x
  L7_2 = L2_2.y
  L8_2 = L2_2.z
  L9_2 = true
  L10_2 = false
  L11_2 = false
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_ROTATION
  L6_2 = L4_2
  L7_2 = 0.0
  L8_2 = -90.0
  L9_2 = 0.0
  L10_2 = 1
  L11_2 = true
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L5_2 = OBJECT
  L5_2 = L5_2.CREATE_OBJECT_NO_OFFSET
  L6_2 = L3_2
  L7_2 = L2_2.x
  L8_2 = L2_2.y
  L9_2 = L2_2.z
  L10_2 = true
  L11_2 = false
  L12_2 = false
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L6_2 = ENTITY
  L6_2 = L6_2.SET_ENTITY_ROTATION
  L7_2 = L5_2
  L8_2 = 0.0
  L9_2 = 90.0
  L10_2 = 0.0
  L11_2 = 1
  L12_2 = true
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L6_2 = util
  L6_2 = L6_2.yield
  L7_2 = 100
  L6_2(L7_2)
  L6_2 = 1
  L7_2 = 20
  L8_2 = 1
  for L9_2 = L6_2, L7_2, L8_2 do
    L10_2 = send_attacker
    L11_2 = -1788665315
    L12_2 = A0_2
    L13_2 = false
    L10_2(L11_2, L12_2, L13_2)
    L10_2 = util
    L10_2 = L10_2.yield
    L11_2 = 1
    L10_2(L11_2)
  end
end
L63_1[L64_1] = L65_1
L63_1 = _ENV
L64_1 = "Terror_Prison"
function L65_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED_SCRIPT_INDEX
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = L1_2
  L4_2 = true
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = L2_2.x
  L2_2.x = L3_2
  L3_2 = L2_2.y
  L2_2.y = L3_2
  L3_2 = L2_2.z
  L2_2.z = L3_2
  L3_2 = 779277682
  L4_2 = request_model
  L5_2 = L3_2
  L4_2(L5_2)
  L4_2 = OBJECT
  L4_2 = L4_2.CREATE_OBJECT_NO_OFFSET
  L5_2 = L3_2
  L6_2 = L2_2.x
  L7_2 = L2_2.y
  L8_2 = L2_2.z
  L9_2 = true
  L10_2 = false
  L11_2 = false
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_ROTATION
  L6_2 = L4_2
  L7_2 = 0.0
  L8_2 = -90.0
  L9_2 = 0.0
  L10_2 = 1
  L11_2 = true
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L5_2 = OBJECT
  L5_2 = L5_2.CREATE_OBJECT_NO_OFFSET
  L6_2 = L3_2
  L7_2 = L2_2.x
  L8_2 = L2_2.y
  L9_2 = L2_2.z
  L10_2 = true
  L11_2 = false
  L12_2 = false
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L6_2 = ENTITY
  L6_2 = L6_2.SET_ENTITY_ROTATION
  L7_2 = L5_2
  L8_2 = 0.0
  L9_2 = 90.0
  L10_2 = 0.0
  L11_2 = 1
  L12_2 = true
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L6_2 = util
  L6_2 = L6_2.yield
  L7_2 = 100
  L6_2(L7_2)
  L6_2 = 1
  L7_2 = 20
  L8_2 = 1
  for L9_2 = L6_2, L7_2, L8_2 do
    L10_2 = send_attacker
    L11_2 = util
    L11_2 = L11_2.joaat
    L12_2 = "CS_BradCadaver"
    L11_2 = L11_2(L12_2)
    L12_2 = A0_2
    L13_2 = false
    L10_2(L11_2, L12_2, L13_2)
    L10_2 = util
    L10_2 = L10_2.yield
    L11_2 = 1
    L10_2(L11_2)
  end
end
L63_1[L64_1] = L65_1
L63_1 = _ENV
L64_1 = "Small_athletics"
function L65_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED_SCRIPT_INDEX
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = L1_2
  L4_2 = true
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = L2_2.x
  L2_2.x = L3_2
  L3_2 = L2_2.y
  L2_2.y = L3_2
  L3_2 = L2_2.z
  L2_2.z = L3_2
  L3_2 = 779277682
  L4_2 = request_model
  L5_2 = L3_2
  L4_2(L5_2)
  L4_2 = OBJECT
  L4_2 = L4_2.CREATE_OBJECT_NO_OFFSET
  L5_2 = L3_2
  L6_2 = L2_2.x
  L7_2 = L2_2.y
  L8_2 = L2_2.z
  L9_2 = true
  L10_2 = false
  L11_2 = false
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_ROTATION
  L6_2 = L4_2
  L7_2 = 0.0
  L8_2 = -90.0
  L9_2 = 0.0
  L10_2 = 1
  L11_2 = true
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L5_2 = OBJECT
  L5_2 = L5_2.CREATE_OBJECT_NO_OFFSET
  L6_2 = L3_2
  L7_2 = L2_2.x
  L8_2 = L2_2.y
  L9_2 = L2_2.z
  L10_2 = true
  L11_2 = false
  L12_2 = false
  L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L6_2 = ENTITY
  L6_2 = L6_2.SET_ENTITY_ROTATION
  L7_2 = L5_2
  L8_2 = 0.0
  L9_2 = 90.0
  L10_2 = 0.0
  L11_2 = 1
  L12_2 = true
  L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
end
L63_1[L64_1] = L65_1
L63_1 = _ENV
L64_1 = "Vertical_freighter_cage"
function L65_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED_SCRIPT_INDEX
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L3_2 = L1_2
  L4_2 = 0.0
  L5_2 = 0.0
  L6_2 = 5.0
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  L3_2 = util
  L3_2 = L3_2.joaat
  L4_2 = "titan"
  L3_2 = L3_2(L4_2)
  L4_2 = request_model
  L5_2 = L3_2
  L4_2(L5_2)
  L4_2 = entities
  L4_2 = L4_2.create_vehicle
  L5_2 = L3_2
  L6_2 = L2_2
  L7_2 = 0
  L4_2 = L4_2(L5_2, L6_2, L7_2)
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_ROTATION
  L6_2 = L4_2
  L7_2 = 90
  L8_2 = 0
  L9_2 = 0
  L10_2 = 1
  L11_2 = true
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
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
end
L63_1[L64_1] = L65_1
L63_1 = _ENV
L64_1 = "Rampage_plane_cage"
function L65_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED_SCRIPT_INDEX
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L3_2 = L1_2
  L4_2 = 0.0
  L5_2 = 0.0
  L6_2 = 0.0
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  L3_2 = util
  L3_2 = L3_2.joaat
  L4_2 = "cargoplane"
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
  L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2 = L7_2(L8_2)
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  L5_2 = ENTITY
  L5_2 = L5_2.FREEZE_ENTITY_POSITION
  L6_2 = L4_2
  L7_2 = true
  L5_2(L6_2, L7_2)
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_COORDS_NO_OFFSET
  L6_2 = L4_2
  L7_2 = L2_2.x
  L8_2 = L2_2.y
  L9_2 = L2_2.z
  L9_2 = L9_2 - 0.1
  L10_2 = true
  L11_2 = false
  L12_2 = false
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_INVINCIBLE
  L6_2 = L4_2
  L7_2 = true
  L5_2(L6_2, L7_2)
  L5_2 = 1
  L6_2 = 5
  L7_2 = 1
  for L8_2 = L5_2, L6_2, L7_2 do
    L9_2 = VEHICLE
    L9_2 = L9_2.SET_VEHICLE_DOOR_LATCHED
    L10_2 = L4_2
    L11_2 = L8_2
    L12_2 = true
    L13_2 = true
    L14_2 = true
    L9_2(L10_2, L11_2, L12_2, L13_2, L14_2)
  end
end
L63_1[L64_1] = L65_1
L63_1 = _ENV
L64_1 = "rub_cage"
function L65_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_COORDS
  L2_2 = PLAYER
  L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
  L3_2 = A0_2
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L2_2(L3_2)
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L2_2 = 2063962179
  L3_2 = L1_2.z
  L3_2 = L3_2 - 1
  L1_2.z = L3_2
  L3_2 = create_object
  L4_2 = L2_2
  L5_2 = L1_2.x
  L6_2 = L1_2.y
  L7_2 = L1_2.z
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
  L4_2 = create_object
  L5_2 = L2_2
  L6_2 = L1_2.x
  L7_2 = L1_2.y
  L8_2 = L1_2.z
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_ROTATION
  L6_2 = L3_2
  L7_2 = 0
  L8_2 = 0
  L9_2 = 0
  L10_2 = 1
  L11_2 = true
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_ROTATION
  L6_2 = L4_2
  L7_2 = 0
  L8_2 = 0
  L9_2 = 90
  L10_2 = 1
  L11_2 = true
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
  L5_2 = ENTITY
  L5_2 = L5_2.FREEZE_ENTITY_POSITION
  L6_2 = L3_2
  L7_2 = true
  L5_2(L6_2, L7_2)
  L5_2 = ENTITY
  L5_2 = L5_2.FREEZE_ENTITY_POSITION
  L6_2 = L4_2
  L7_2 = true
  L5_2(L6_2, L7_2)
end
L63_1[L64_1] = L65_1
L63_1 = _ENV
L64_1 = "Celestial_Fighter"
function L65_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED_SCRIPT_INDEX
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L3_2 = L1_2
  L4_2 = 1.0
  L5_2 = 0.0
  L6_2 = 500.0
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  coords = L2_2
  L2_2 = coords
  L3_2 = coords
  L3_2 = L3_2.x
  L2_2.x = L3_2
  L2_2 = coords
  L3_2 = coords
  L3_2 = L3_2.y
  L2_2.y = L3_2
  L2_2 = coords
  L3_2 = coords
  L3_2 = L3_2.z
  L2_2.z = L3_2
  L2_2 = util
  L2_2 = L2_2.joaat
  L3_2 = "lazer"
  L2_2 = L2_2(L3_2)
  L3_2 = request_model
  L4_2 = L2_2
  L3_2(L4_2)
  L3_2 = request_model
  L4_2 = -163714847
  L3_2(L4_2)
  L3_2 = coords
  L4_2 = coords
  L4_2 = L4_2.x
  L4_2 = L4_2 + 2
  L3_2.x = L4_2
  L3_2 = coords
  L4_2 = coords
  L4_2 = L4_2.y
  L4_2 = L4_2 + 2
  L3_2.y = L4_2
  L3_2 = entities
  L3_2 = L3_2.create_vehicle
  L4_2 = L2_2
  L5_2 = coords
  L6_2 = 0.0
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  L4_2 = VEHICLE
  L4_2 = L4_2.CONTROL_LANDING_GEAR
  L5_2 = L3_2
  L6_2 = 3
  L4_2(L5_2, L6_2)
  L4_2 = VEHICLE
  L4_2 = L4_2.SET_HELI_BLADES_FULL_SPEED
  L5_2 = L3_2
  L4_2(L5_2)
  L4_2 = VEHICLE
  L4_2 = L4_2.SET_VEHICLE_FORWARD_SPEED
  L5_2 = L3_2
  L6_2 = VEHICLE
  L6_2 = L6_2.GET_VEHICLE_ESTIMATED_MAX_SPEED
  L7_2 = L3_2
  L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L6_2(L7_2)
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  L4_2 = ENTITY
  L4_2 = L4_2.SET_ENTITY_INVINCIBLE
  L5_2 = L3_2
  L6_2 = true
  L4_2(L5_2, L6_2)
  L4_2 = entities
  L4_2 = L4_2.create_ped
  L5_2 = 28
  L6_2 = -163714847
  L7_2 = coords
  L8_2 = 30.0
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  L5_2 = PED
  L5_2 = L5_2.SET_PED_COMBAT_ATTRIBUTES
  L6_2 = L4_2
  L7_2 = 5
  L8_2 = true
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = PED
  L5_2 = L5_2.SET_PED_COMBAT_ATTRIBUTES
  L6_2 = L4_2
  L7_2 = 46
  L8_2 = true
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = PED
  L5_2 = L5_2.SET_PED_INTO_VEHICLE
  L6_2 = L4_2
  L7_2 = L3_2
  L8_2 = -1
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = TASK
  L5_2 = L5_2.TASK_PLANE_MISSION
  L6_2 = L4_2
  L7_2 = L3_2
  L8_2 = 0
  L9_2 = L1_2
  L10_2 = 0
  L11_2 = 0
  L12_2 = 0
  L13_2 = 6
  L14_2 = 0.0
  L15_2 = 0
  L16_2 = 0.0
  L17_2 = 50.0
  L18_2 = 40.0
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  L5_2 = TASK
  L5_2 = L5_2.TASK_COMBAT_PED
  L6_2 = L4_2
  L7_2 = L1_2
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
end
L63_1[L64_1] = L65_1
L63_1 = _ENV
L64_1 = "XF_crash"
function L65_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L1_2 = 1
  L2_2 = 10
  L3_2 = 1
  for L4_2 = L1_2, L2_2, L3_2 do
    L5_2 = PLAYER
    L5_2 = L5_2.GET_PLAYER_PED_SCRIPT_INDEX
    L6_2 = A0_2
    L5_2 = L5_2(L6_2)
    L6_2 = ENTITY
    L6_2 = L6_2.GET_ENTITY_COORDS
    L7_2 = L5_2
    L8_2 = true
    L6_2 = L6_2(L7_2, L8_2)
    L7_2 = STREAMING
    L7_2 = L7_2.REQUEST_MODEL
    L8_2 = -930879665
    L7_2(L8_2)
    L7_2 = util
    L7_2 = L7_2.yield
    L8_2 = 10
    L7_2(L8_2)
    L7_2 = STREAMING
    L7_2 = L7_2.REQUEST_MODEL
    L8_2 = 3613262246
    L7_2(L8_2)
    L7_2 = util
    L7_2 = L7_2.yield
    L8_2 = 10
    L7_2(L8_2)
    L7_2 = STREAMING
    L7_2 = L7_2.REQUEST_MODEL
    L8_2 = 452618762
    L7_2(L8_2)
    L7_2 = util
    L7_2 = L7_2.yield
    L8_2 = 10
    L7_2(L8_2)
    L7_2 = entities
    L7_2 = L7_2.create_object
    L8_2 = -930879665
    L9_2 = L6_2
    L7_2 = L7_2(L8_2, L9_2)
    L8_2 = util
    L8_2 = L8_2.yield
    L9_2 = 10
    L8_2(L9_2)
    L8_2 = entities
    L8_2 = L8_2.create_object
    L9_2 = 3613262246
    L10_2 = L6_2
    L8_2 = L8_2(L9_2, L10_2)
    L9_2 = util
    L9_2 = L9_2.yield
    L10_2 = 10
    L9_2(L10_2)
    L9_2 = entities
    L9_2 = L9_2.create_object
    L10_2 = 452618762
    L11_2 = L6_2
    L9_2 = L9_2(L10_2, L11_2)
    L10_2 = util
    L10_2 = L10_2.yield
    L11_2 = 10
    L10_2(L11_2)
    L10_2 = entities
    L10_2 = L10_2.create_object
    L11_2 = 3613262246
    L12_2 = L6_2
    L10_2 = L10_2(L11_2, L12_2)
    L11_2 = util
    L11_2 = L11_2.yield
    L12_2 = 300
    L11_2(L12_2)
    L11_2 = delete_entity
    L12_2 = L7_2
    L11_2(L12_2)
    L11_2 = delete_entity
    L12_2 = L8_2
    L11_2(L12_2)
    L11_2 = delete_entity
    L12_2 = L9_2
    L11_2(L12_2)
    L11_2 = delete_entity
    L12_2 = L10_2
    L11_2(L12_2)
    L11_2 = STREAMING
    L11_2 = L11_2.SET_MODEL_AS_NO_LONGER_NEEDED
    L12_2 = 452618762
    L11_2(L12_2)
    L11_2 = util
    L11_2 = L11_2.yield
    L12_2 = 10
    L11_2(L12_2)
    L11_2 = STREAMING
    L11_2 = L11_2.SET_MODEL_AS_NO_LONGER_NEEDED
    L12_2 = 3613262246
    L11_2(L12_2)
    L11_2 = util
    L11_2 = L11_2.yield
    L12_2 = 10
    L11_2(L12_2)
    L11_2 = STREAMING
    L11_2 = L11_2.SET_MODEL_AS_NO_LONGER_NEEDED
    L12_2 = -930879665
    L11_2(L12_2)
    L11_2 = util
    L11_2 = L11_2.yield
    L12_2 = 10
    L11_2(L12_2)
  end
end
L63_1[L64_1] = L65_1
L63_1 = _ENV
L64_1 = "boolean_crash"
function L65_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED_SCRIPT_INDEX
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = L1_2
  L2_2 = L2_2(L3_2)
  L3_2 = util
  L3_2 = L3_2.joaat
  L4_2 = "banshee"
  L3_2 = L3_2(L4_2)
  L4_2 = request_model
  L5_2 = L3_2
  L4_2(L5_2)
  L4_2 = entities
  L4_2 = L4_2.create_vehicle
  L5_2 = L3_2
  L6_2 = L2_2
  L7_2 = 0
  L4_2 = L4_2(L5_2, L6_2, L7_2)
  L5_2 = VEHICLE
  L5_2 = L5_2.SET_VEHICLE_MOD_KIT
  L6_2 = L4_2
  L7_2 = 0
  L5_2(L6_2, L7_2)
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_COLLISION
  L6_2 = L4_2
  L7_2 = false
  L8_2 = true
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = VEHICLE
  L5_2 = L5_2.SET_VEHICLE_GRAVITY
  L6_2 = L4_2
  L7_2 = 0
  L5_2(L6_2, L7_2)
  L5_2 = 0
  L6_2 = 49
  L7_2 = 1
  for L8_2 = L5_2, L6_2, L7_2 do
    L9_2 = VEHICLE
    L9_2 = L9_2.GET_NUM_VEHICLE_MODS
    L10_2 = L4_2
    L11_2 = L8_2
    L9_2 = L9_2(L10_2, L11_2)
    L9_2 = L9_2 - 1
    L10_2 = VEHICLE
    L10_2 = L10_2.SET_VEHICLE_MOD
    L11_2 = L4_2
    L12_2 = L8_2
    L13_2 = L9_2
    L14_2 = false
    L10_2(L11_2, L12_2, L13_2, L14_2)
  end
end
L63_1[L64_1] = L65_1
L63_1 = _ENV
L64_1 = "clone"
function L65_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_HEADING
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_MODEL
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = ENTITY
  L3_2 = L3_2.GET_ENTITY_COORDS
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = ENTITY
  L4_2 = L4_2.SET_ENTITY_AS_MISSION_ENTITY
  L5_2 = A0_2
  L4_2(L5_2)
  L4_2 = v3
  L4_2 = L4_2.toDir
  L5_2 = ENTITY
  L5_2 = L5_2.GET_ENTITY_ROTATION
  L6_2 = A0_2
  L7_2 = 2
  L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2, L7_2)
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  L5_2 = v3
  L5_2 = L5_2.mul
  L6_2 = L4_2
  L7_2 = getDimensions
  L8_2 = A0_2
  L7_2 = L7_2(L8_2)
  L7_2 = L7_2.x
  L7_2 = -L7_2
  L7_2 = L7_2 - 2
  L5_2(L6_2, L7_2)
  L5_2 = v3
  L5_2 = L5_2.add
  L6_2 = L3_2
  L7_2 = L4_2
  L5_2(L6_2, L7_2)
  L5_2 = entities
  L5_2 = L5_2.create_vehicle
  L6_2 = L2_2
  L7_2 = L3_2
  L8_2 = L1_2
  L5_2 = L5_2(L6_2, L7_2, L8_2)
  L6_2 = copyVehicleData
  L7_2 = A0_2
  L8_2 = L5_2
  L6_2(L7_2, L8_2)
  return L5_2
end
L63_1[L64_1] = L65_1
L63_1 = _ENV
L64_1 = "memory"
L63_1 = L63_1[L64_1]
L64_1 = "alloc"
L63_1 = L63_1[L64_1]
L63_1 = L63_1()
L64_1 = _ENV
L65_1 = "memory"
L64_1 = L64_1[L65_1]
L65_1 = "alloc"
L64_1 = L64_1[L65_1]
L64_1 = L64_1()
L65_1 = _ENV
L66_1 = "getDimensions"
function L67_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2
  L1_2 = MISC
  L1_2 = L1_2.GET_MODEL_DIMENSIONS
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_MODEL
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = L63_1
  L4_2 = L64_1
  L1_2(L2_2, L3_2, L4_2)
  L1_2 = v3
  L1_2 = L1_2.new
  L2_2 = L63_1
  L1_2 = L1_2(L2_2)
  L2_2 = v3
  L2_2 = L2_2.new
  L3_2 = L64_1
  L2_2 = L2_2(L3_2)
  L3_2 = {}
  L4_2 = L2_2.y
  L5_2 = L1_2.y
  L4_2 = L4_2 - L5_2
  L3_2.x = L4_2
  L4_2 = L2_2.x
  L5_2 = L1_2.x
  L4_2 = L4_2 - L5_2
  L3_2.y = L4_2
  L4_2 = L2_2.z
  L5_2 = L1_2.z
  L4_2 = L4_2 - L5_2
  L3_2.z = L4_2
  return L3_2
end
L65_1[L66_1] = L67_1
L65_1 = _ENV
L66_1 = "memory"
L65_1 = L65_1[L66_1]
L66_1 = "alloc"
L65_1 = L65_1[L66_1]
L66_1 = 1
L65_1 = L65_1(L66_1)
L66_1 = _ENV
L67_1 = "memory"
L66_1 = L66_1[L67_1]
L67_1 = "alloc"
L66_1 = L66_1[L67_1]
L67_1 = 1
L66_1 = L66_1(L67_1)
L67_1 = _ENV
L68_1 = "memory"
L67_1 = L67_1[L68_1]
L68_1 = "alloc"
L67_1 = L67_1[L68_1]
L68_1 = 1
L67_1 = L67_1(L68_1)
L68_1 = _ENV
L69_1 = "copyVehicleData"
function L70_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L2_2 = VEHICLE
  L2_2 = L2_2.SET_VEHICLE_MOD_KIT
  L3_2 = A1_2
  L4_2 = 0
  L2_2(L3_2, L4_2)
  L2_2 = 17
  L3_2 = 22
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = VEHICLE
    L6_2 = L6_2.TOGGLE_VEHICLE_MOD
    L7_2 = A1_2
    L8_2 = L5_2
    L9_2 = VEHICLE
    L9_2 = L9_2.IS_TOGGLE_MOD_ON
    L10_2 = A0_2
    L11_2 = L5_2
    L9_2, L10_2, L11_2, L12_2, L13_2 = L9_2(L10_2, L11_2)
    L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  end
  L2_2 = 0
  L3_2 = 49
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = VEHICLE
    L6_2 = L6_2.GET_VEHICLE_MOD
    L7_2 = A0_2
    L8_2 = L5_2
    L6_2 = L6_2(L7_2, L8_2)
    L7_2 = VEHICLE
    L7_2 = L7_2.SET_VEHICLE_MOD
    L8_2 = A1_2
    L9_2 = L5_2
    L10_2 = L6_2
    L7_2(L8_2, L9_2, L10_2)
  end
  L2_2 = VEHICLE
  L2_2 = L2_2.GET_IS_VEHICLE_PRIMARY_COLOUR_CUSTOM
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if L2_2 then
    L2_2 = VEHICLE
    L2_2 = L2_2.GET_VEHICLE_CUSTOM_PRIMARY_COLOUR
    L3_2 = A0_2
    L4_2 = L65_1
    L5_2 = L66_1
    L6_2 = L67_1
    L2_2(L3_2, L4_2, L5_2, L6_2)
    L2_2 = VEHICLE
    L2_2 = L2_2.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR
    L3_2 = A1_2
    L4_2 = memory
    L4_2 = L4_2.read_ubyte
    L5_2 = L65_1
    L4_2 = L4_2(L5_2)
    L5_2 = memory
    L5_2 = L5_2.read_ubyte
    L6_2 = L66_1
    L5_2 = L5_2(L6_2)
    L6_2 = memory
    L6_2 = L6_2.read_ubyte
    L7_2 = L67_1
    L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L6_2(L7_2)
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  else
    L2_2 = VEHICLE
    L2_2 = L2_2.GET_VEHICLE_MOD_COLOR_1
    L3_2 = A0_2
    L4_2 = L65_1
    L5_2 = L66_1
    L6_2 = L67_1
    L2_2(L3_2, L4_2, L5_2, L6_2)
    L2_2 = VEHICLE
    L2_2 = L2_2.SET_VEHICLE_MOD_COLOR_1
    L3_2 = A1_2
    L4_2 = memory
    L4_2 = L4_2.read_ubyte
    L5_2 = L65_1
    L4_2 = L4_2(L5_2)
    L5_2 = memory
    L5_2 = L5_2.read_ubyte
    L6_2 = L66_1
    L5_2 = L5_2(L6_2)
    L6_2 = memory
    L6_2 = L6_2.read_ubyte
    L7_2 = L67_1
    L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L6_2(L7_2)
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  end
  L2_2 = VEHICLE
  L2_2 = L2_2.GET_IS_VEHICLE_SECONDARY_COLOUR_CUSTOM
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if L2_2 then
    L2_2 = VEHICLE
    L2_2 = L2_2.GET_VEHICLE_CUSTOM_SECONDARY_COLOUR
    L3_2 = A0_2
    L4_2 = L65_1
    L5_2 = L66_1
    L6_2 = L67_1
    L2_2(L3_2, L4_2, L5_2, L6_2)
    L2_2 = VEHICLE
    L2_2 = L2_2.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR
    L3_2 = A1_2
    L4_2 = memory
    L4_2 = L4_2.read_ubyte
    L5_2 = L65_1
    L4_2 = L4_2(L5_2)
    L5_2 = memory
    L5_2 = L5_2.read_ubyte
    L6_2 = L66_1
    L5_2 = L5_2(L6_2)
    L6_2 = memory
    L6_2 = L6_2.read_ubyte
    L7_2 = L67_1
    L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L6_2(L7_2)
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  else
    L2_2 = VEHICLE
    L2_2 = L2_2.GET_VEHICLE_MOD_COLOR_2
    L3_2 = A0_2
    L4_2 = L65_1
    L5_2 = L66_1
    L2_2(L3_2, L4_2, L5_2)
    L2_2 = VEHICLE
    L2_2 = L2_2.SET_VEHICLE_MOD_COLOR_2
    L3_2 = A1_2
    L4_2 = memory
    L4_2 = L4_2.read_ubyte
    L5_2 = L65_1
    L4_2 = L4_2(L5_2)
    L5_2 = memory
    L5_2 = L5_2.read_ubyte
    L6_2 = L66_1
    L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L5_2(L6_2)
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  end
  L2_2 = VEHICLE
  L2_2 = L2_2.GET_VEHICLE_COLOURS
  L3_2 = A0_2
  L4_2 = L65_1
  L5_2 = L66_1
  L2_2(L3_2, L4_2, L5_2)
  L2_2 = VEHICLE
  L2_2 = L2_2.SET_VEHICLE_COLOURS
  L3_2 = A1_2
  L4_2 = memory
  L4_2 = L4_2.read_ubyte
  L5_2 = L65_1
  L4_2 = L4_2(L5_2)
  L5_2 = memory
  L5_2 = L5_2.read_ubyte
  L6_2 = L66_1
  L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L5_2(L6_2)
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L2_2 = VEHICLE
  L2_2 = L2_2.GET_VEHICLE_EXTRA_COLOURS
  L3_2 = A0_2
  L4_2 = L65_1
  L5_2 = L66_1
  L2_2(L3_2, L4_2, L5_2)
  L2_2 = VEHICLE
  L2_2 = L2_2.SET_VEHICLE_EXTRA_COLOURS
  L3_2 = A1_2
  L4_2 = memory
  L4_2 = L4_2.read_ubyte
  L5_2 = L65_1
  L4_2 = L4_2(L5_2)
  L5_2 = memory
  L5_2 = L5_2.read_ubyte
  L6_2 = L66_1
  L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L5_2(L6_2)
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L2_2 = VEHICLE
  L2_2 = L2_2.GET_VEHICLE_EXTRA_COLOUR_5
  L3_2 = A0_2
  L4_2 = L65_1
  L2_2(L3_2, L4_2)
  L2_2 = VEHICLE
  L2_2 = L2_2.GET_VEHICLE_EXTRA_COLOUR_6
  L3_2 = A0_2
  L4_2 = L66_1
  L2_2(L3_2, L4_2)
  L2_2 = VEHICLE
  L2_2 = L2_2.SET_VEHICLE_EXTRA_COLOUR_5
  L3_2 = A1_2
  L4_2 = memory
  L4_2 = L4_2.read_ubyte
  L5_2 = L65_1
  L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L4_2(L5_2)
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L2_2 = VEHICLE
  L2_2 = L2_2.SET_VEHICLE_EXTRA_COLOUR_6
  L3_2 = A1_2
  L4_2 = memory
  L4_2 = L4_2.read_ubyte
  L5_2 = L66_1
  L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L4_2(L5_2)
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L2_2 = VEHICLE
  L2_2 = L2_2.GET_VEHICLE_TYRE_SMOKE_COLOR
  L3_2 = A0_2
  L4_2 = L65_1
  L5_2 = L66_1
  L6_2 = L67_1
  L2_2(L3_2, L4_2, L5_2, L6_2)
  L2_2 = VEHICLE
  L2_2 = L2_2.SET_VEHICLE_TYRE_SMOKE_COLOR
  L3_2 = A1_2
  L4_2 = memory
  L4_2 = L4_2.read_ubyte
  L5_2 = L65_1
  L4_2 = L4_2(L5_2)
  L5_2 = memory
  L5_2 = L5_2.read_ubyte
  L6_2 = L66_1
  L5_2 = L5_2(L6_2)
  L6_2 = memory
  L6_2 = L6_2.read_ubyte
  L7_2 = L67_1
  L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L6_2(L7_2)
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L2_2 = VEHICLE
  L2_2 = L2_2.GET_VEHICLE_NEON_COLOUR
  L3_2 = A0_2
  L4_2 = L65_1
  L5_2 = L66_1
  L6_2 = L67_1
  L2_2(L3_2, L4_2, L5_2, L6_2)
  L2_2 = VEHICLE
  L2_2 = L2_2.SET_VEHICLE_NEON_COLOUR
  L3_2 = A1_2
  L4_2 = memory
  L4_2 = L4_2.read_ubyte
  L5_2 = L65_1
  L4_2 = L4_2(L5_2)
  L5_2 = memory
  L5_2 = L5_2.read_ubyte
  L6_2 = L66_1
  L5_2 = L5_2(L6_2)
  L6_2 = memory
  L6_2 = L6_2.read_ubyte
  L7_2 = L67_1
  L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L6_2(L7_2)
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L2_2 = 0
  L3_2 = 3
  L4_2 = 1
  for L5_2 = L2_2, L3_2, L4_2 do
    L6_2 = VEHICLE
    L6_2 = L6_2.SET_VEHICLE_NEON_ENABLED
    L7_2 = A1_2
    L8_2 = L5_2
    L9_2 = VEHICLE
    L9_2 = L9_2.GET_VEHICLE_NEON_ENABLED
    L10_2 = A0_2
    L11_2 = L5_2
    L9_2, L10_2, L11_2, L12_2, L13_2 = L9_2(L10_2, L11_2)
    L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  end
  L2_2 = VEHICLE
  L2_2 = L2_2.GET_VEHICLE_WINDOW_TINT
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = VEHICLE
  L3_2 = L3_2.SET_VEHICLE_WINDOW_TINT
  L4_2 = A1_2
  L5_2 = L2_2
  L3_2(L4_2, L5_2)
  L3_2 = VEHICLE
  L3_2 = L3_2.GET_VEHICLE_XENON_LIGHT_COLOR_INDEX
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = VEHICLE
  L4_2 = L4_2.SET_VEHICLE_XENON_LIGHT_COLOR_INDEX
  L5_2 = A1_2
  L6_2 = L3_2
  L4_2(L5_2, L6_2)
  L4_2 = VEHICLE
  L4_2 = L4_2.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX
  L5_2 = A1_2
  L6_2 = VEHICLE
  L6_2 = L6_2.GET_VEHICLE_NUMBER_PLATE_TEXT_INDEX
  L7_2 = A0_2
  L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L6_2(L7_2)
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L4_2 = VEHICLE
  L4_2 = L4_2.SET_VEHICLE_NUMBER_PLATE_TEXT
  L5_2 = A1_2
  L6_2 = VEHICLE
  L6_2 = L6_2.GET_VEHICLE_NUMBER_PLATE_TEXT
  L7_2 = A0_2
  L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L6_2(L7_2)
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L4_2 = VEHICLE
  L4_2 = L4_2.SET_VEHICLE_TYRES_CAN_BURST
  L5_2 = A1_2
  L6_2 = VEHICLE
  L6_2 = L6_2.GET_VEHICLE_TYRES_CAN_BURST
  L7_2 = A0_2
  L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L6_2(L7_2)
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L4_2 = VEHICLE
  L4_2 = L4_2.SET_VEHICLE_DIRT_LEVEL
  L5_2 = A1_2
  L6_2 = VEHICLE
  L6_2 = L6_2.GET_VEHICLE_DIRT_LEVEL
  L7_2 = A0_2
  L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L6_2(L7_2)
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L4_2 = 1
  L5_2 = 14
  L6_2 = 1
  for L7_2 = L4_2, L5_2, L6_2 do
    L8_2 = VEHICLE
    L8_2 = L8_2.SET_VEHICLE_EXTRA
    L9_2 = A1_2
    L10_2 = L7_2
    L11_2 = VEHICLE
    L11_2 = L11_2.IS_VEHICLE_EXTRA_TURNED_ON
    L12_2 = A0_2
    L13_2 = L7_2
    L11_2 = L11_2(L12_2, L13_2)
    L11_2 = not L11_2
    L8_2(L9_2, L10_2, L11_2)
  end
  L4_2 = VEHICLE
  L4_2 = L4_2.GET_CONVERTIBLE_ROOF_STATE
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  if 1 == L4_2 or 2 == L4_2 then
    L5_2 = VEHICLE
    L5_2 = L5_2.LOWER_CONVERTIBLE_ROOF
    L6_2 = A1_2
    L7_2 = true
    L5_2(L6_2, L7_2)
  end
  L5_2 = VEHICLE
  L5_2 = L5_2.SET_VEHICLE_ENGINE_ON
  L6_2 = A1_2
  L7_2 = VEHICLE
  L7_2 = L7_2.GET_IS_VEHICLE_ENGINE_RUNNING
  L8_2 = A0_2
  L7_2 = L7_2(L8_2)
  L8_2 = true
  L9_2 = true
  L5_2(L6_2, L7_2, L8_2, L9_2)
end
L68_1[L69_1] = L70_1
L68_1 = _ENV
L69_1 = "Invalid_vehicle_crashes"
function L70_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L1_2 = players
  L1_2 = L1_2.get_position
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = {}
  L3_2 = util
  L3_2 = L3_2.request_model
  L4_2 = -655644382
  L3_2(L4_2)
  L3_2 = 1
  L4_2 = 20
  L5_2 = 1
  for L6_2 = L3_2, L4_2, L5_2 do
    L7_2 = entities
    L7_2 = L7_2.create_object
    L8_2 = -655644382
    L9_2 = v3
    L9_2 = L9_2.new
    L10_2 = L1_2.x
    L11_2 = math
    L11_2 = L11_2.random
    L12_2 = -5
    L13_2 = 5
    L11_2 = L11_2(L12_2, L13_2)
    L10_2 = L10_2 + L11_2
    L11_2 = L1_2.y
    L12_2 = math
    L12_2 = L12_2.random
    L13_2 = -5
    L14_2 = 5
    L12_2 = L12_2(L13_2, L14_2)
    L11_2 = L11_2 + L12_2
    L12_2 = L1_2.z
    L13_2 = math
    L13_2 = L13_2.random
    L14_2 = -1
    L15_2 = 0
    L13_2 = L13_2(L14_2, L15_2)
    L12_2 = L12_2 + L13_2
    L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L9_2(L10_2, L11_2, L12_2)
    L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
    L8_2 = ENTITY
    L8_2 = L8_2.SET_ENTITY_ROTATION
    L9_2 = L7_2
    L10_2 = 0
    L11_2 = 0
    L12_2 = math
    L12_2 = L12_2.random
    L13_2 = 0
    L14_2 = 360
    L12_2 = L12_2(L13_2, L14_2)
    L13_2 = 1
    L14_2 = true
    L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    L8_2 = #L2_2
    L8_2 = L8_2 + 1
    L2_2[L8_2] = L7_2
  end
  L3_2 = false
  L4_2 = util
  L4_2 = L4_2.create_tick_handler
  function L5_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3
    L0_3 = L3_2
    if L0_3 then
      L0_3 = false
      return L0_3
    end
    L0_3 = ENTITY
    L0_3 = L0_3.SET_ENTITY_TRAFFICLIGHT_OVERRIDE
    L1_3 = math
    L1_3 = L1_3.random
    L2_3 = 1
    L3_3 = L2_2
    L3_3 = #L3_3
    L1_3 = L1_3(L2_3, L3_3)
    L2_3 = L2_2
    L1_3 = L2_3[L1_3]
    L2_3 = math
    L2_3 = L2_3.random
    L3_3 = 0
    L4_3 = 3
    L2_3, L3_3, L4_3 = L2_3(L3_3, L4_3)
    L0_3(L1_3, L2_3, L3_3, L4_3)
  end
  L4_2(L5_2)
  L4_2 = util
  L4_2 = L4_2.request_model
  L5_2 = 3253274834
  L4_2(L5_2)
  L4_2 = {}
  L5_2 = entities
  L5_2 = L5_2.create_vehicle
  L6_2 = 3253274834
  L7_2 = L1_2
  L8_2 = 0
  L5_2 = L5_2(L6_2, L7_2, L8_2)
  L6_2 = #L4_2
  L6_2 = L6_2 + 1
  L4_2[L6_2] = L5_2
  L6_2 = VEHICLE
  L6_2 = L6_2.SET_VEHICLE_MOD_KIT
  L7_2 = L5_2
  L8_2 = 0
  L6_2(L7_2, L8_2)
  L6_2 = VEHICLE
  L6_2 = L6_2.SET_VEHICLE_NUMBER_PLATE_TEXT
  L7_2 = L5_2
  L8_2 = "ICRASHU"
  L6_2(L7_2, L8_2)
  L6_2 = VEHICLE
  L6_2 = L6_2.SET_VEHICLE_MOD
  L7_2 = L5_2
  L8_2 = 34
  L9_2 = 3
  L6_2(L7_2, L8_2, L9_2)
  L6_2 = 1
  L7_2 = 10
  L8_2 = 1
  for L9_2 = L6_2, L7_2, L8_2 do
    L10_2 = #L4_2
    L10_2 = L10_2 + 1
    L11_2 = clone
    L12_2 = L5_2
    L11_2 = L11_2(L12_2)
    L4_2[L10_2] = L11_2
  end
  L6_2 = util
  L6_2 = L6_2.yield
  L7_2 = 500
  L6_2(L7_2)
  L6_2 = 1
  L7_2 = #L4_2
  L8_2 = 1
  for L9_2 = L6_2, L7_2, L8_2 do
    L10_2 = delete_entity
    L11_2 = L4_2[L9_2]
    L10_2(L11_2)
  end
  L6_2 = util
  L6_2 = L6_2.yield
  L7_2 = 500
  L6_2(L7_2)
  L3_2 = true
  L6_2 = util
  L6_2 = L6_2.yield
  L7_2 = 500
  L6_2(L7_2)
  L6_2 = 1
  L7_2 = #L2_2
  L8_2 = 1
  for L9_2 = L6_2, L7_2, L8_2 do
    L10_2 = delete_entity
    L11_2 = L2_2[L9_2]
    L10_2(L11_2)
  end
  L6_2 = STREAMING
  L6_2 = L6_2.SET_MODEL_AS_NO_LONGER_NEEDED
  L7_2 = 3253274834
  L6_2(L7_2)
  L6_2 = STREAMING
  L6_2 = L6_2.SET_MODEL_AS_NO_LONGER_NEEDED
  L7_2 = -655644382
  L6_2(L7_2)
end
L68_1[L69_1] = L70_1
L68_1 = _ENV
L69_1 = "rotatePoint"
function L70_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L4_2 = math
  L4_2 = L4_2.rad
  L5_2 = A3_2
  L4_2 = L4_2(L5_2)
  L5_2 = A2_2.x
  L5_2 = A0_2 - L5_2
  L6_2 = math
  L6_2 = L6_2.cos
  L7_2 = L4_2
  L6_2 = L6_2(L7_2)
  L5_2 = L5_2 * L6_2
  L6_2 = A2_2.y
  L6_2 = A1_2 - L6_2
  L7_2 = math
  L7_2 = L7_2.sin
  L8_2 = L4_2
  L7_2 = L7_2(L8_2)
  L6_2 = L6_2 * L7_2
  L5_2 = L5_2 - L6_2
  L6_2 = A2_2.x
  L6_2 = A0_2 - L6_2
  L7_2 = math
  L7_2 = L7_2.sin
  L8_2 = L4_2
  L7_2 = L7_2(L8_2)
  L6_2 = L6_2 * L7_2
  L7_2 = A2_2.y
  L7_2 = A1_2 - L7_2
  L8_2 = math
  L8_2 = L8_2.cos
  L9_2 = L4_2
  L8_2 = L8_2(L9_2)
  L7_2 = L7_2 * L8_2
  L6_2 = L6_2 + L7_2
  L7_2 = A2_2.x
  L7_2 = L7_2 + L5_2
  L8_2 = A2_2.y
  L9_2 = L6_2 * 1920
  L9_2 = L9_2 / 1080
  L8_2 = L8_2 + L9_2
  return L7_2, L8_2
end
L68_1[L69_1] = L70_1
L68_1 = _ENV
L69_1 = "Invalid_parachute"
function L70_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2
  L0_2 = 0
  L1_2 = 31
  L2_2 = 1
  for L3_2 = L0_2, L1_2, L2_2 do
    L4_2 = PLAYER
    L4_2 = L4_2.GET_PLAYER_PED_SCRIPT_INDEX
    L5_2 = L3_2
    L4_2 = L4_2(L5_2)
    L5_2 = PLAYER
    L5_2 = L5_2.GET_PLAYER_PED_SCRIPT_INDEX
    L6_2 = PLAYER
    L6_2 = L6_2.PLAYER_ID
    L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2 = L6_2()
    L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
    L6_2 = ENTITY
    L6_2 = L6_2.GET_ENTITY_COORDS
    L7_2 = L5_2
    L8_2 = true
    L6_2 = L6_2(L7_2, L8_2)
    L7_2 = PLAYER
    L7_2 = L7_2.PLAYER_ID
    L7_2 = L7_2()
    L8_2 = PLAYER
    L8_2 = L8_2.PLAYER_PED_ID
    L8_2 = L8_2()
    L9_2 = players
    L9_2 = L9_2.get_position
    L10_2 = L7_2
    L9_2 = L9_2(L10_2)
    L10_2 = PLAYER
    L10_2 = L10_2.PLAYER_PED_ID
    L10_2 = L10_2()
    L11_2 = ENTITY
    L11_2 = L11_2.GET_ENTITY_COORDS
    L12_2 = L10_2
    L13_2 = true
    L11_2 = L11_2(L12_2, L13_2)
    L12_2 = 1
    L13_2 = 5
    L14_2 = 1
    for L15_2 = L12_2, L13_2, L14_2 do
      L16_2 = ENTITY
      L16_2 = L16_2.GET_ENTITY_COORDS
      L17_2 = L10_2
      L18_2 = true
      L16_2 = L16_2(L17_2, L18_2)
      L17_2 = CreateVehicle
      L18_2 = util
      L18_2 = L18_2.joaat
      L19_2 = "Ruiner2"
      L18_2 = L18_2(L19_2)
      L19_2 = L16_2
      L20_2 = ENTITY
      L20_2 = L20_2.GET_ENTITY_HEADING
      L21_2 = L4_2
      L20_2 = L20_2(L21_2)
      L21_2 = true
      L17_2 = L17_2(L18_2, L19_2, L20_2, L21_2)
      L18_2 = PED
      L18_2 = L18_2.SET_PED_INTO_VEHICLE
      L19_2 = L10_2
      L20_2 = L17_2
      L21_2 = -1
      L18_2(L19_2, L20_2, L21_2)
      L18_2 = ENTITY
      L18_2 = L18_2.SET_ENTITY_COORDS_NO_OFFSET
      L19_2 = L17_2
      L20_2 = L16_2.x
      L21_2 = L16_2.y
      L22_2 = 200
      L23_2 = false
      L24_2 = true
      L25_2 = true
      L18_2(L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
      L18_2 = util
      L18_2 = L18_2.yield
      L19_2 = 100
      L18_2(L19_2)
      L18_2 = VEHICLE1
      L18_2 = L18_2._SET_VEHICLE_PARACHUTE_MODEL
      L19_2 = L17_2
      L20_2 = 3235319999
      L18_2(L19_2, L20_2)
      L18_2 = VEHICLE1
      L18_2 = L18_2._SET_VEHICLE_PARACHUTE_ACTIVE
      L19_2 = L17_2
      L20_2 = true
      L18_2(L19_2, L20_2)
      L18_2 = util
      L18_2 = L18_2.yield
      L19_2 = 100
      L18_2(L19_2)
      L18_2 = delete_entity
      L19_2 = L17_2
      L18_2(L19_2)
    end
    L12_2 = 1
    L13_2 = 10
    L14_2 = 1
    for L15_2 = L12_2, L13_2, L14_2 do
      L16_2 = ENTITY
      L16_2 = L16_2.GET_ENTITY_COORDS
      L17_2 = L10_2
      L18_2 = true
      L16_2 = L16_2(L17_2, L18_2)
      L17_2 = CreateVehicle
      L18_2 = util
      L18_2 = L18_2.joaat
      L19_2 = "Ruiner2"
      L18_2 = L18_2(L19_2)
      L19_2 = L16_2
      L20_2 = ENTITY
      L20_2 = L20_2.GET_ENTITY_HEADING
      L21_2 = L4_2
      L20_2 = L20_2(L21_2)
      L21_2 = true
      L17_2 = L17_2(L18_2, L19_2, L20_2, L21_2)
      L18_2 = PED
      L18_2 = L18_2.SET_PED_INTO_VEHICLE
      L19_2 = L10_2
      L20_2 = L17_2
      L21_2 = -1
      L18_2(L19_2, L20_2, L21_2)
      L18_2 = ENTITY
      L18_2 = L18_2.SET_ENTITY_COORDS_NO_OFFSET
      L19_2 = L17_2
      L20_2 = L16_2.x
      L21_2 = L16_2.y
      L22_2 = 2000
      L23_2 = false
      L24_2 = true
      L25_2 = true
      L18_2(L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
      L18_2 = util
      L18_2 = L18_2.yield
      L19_2 = 120
      L18_2(L19_2)
      L18_2 = VEHICLE1
      L18_2 = L18_2._SET_VEHICLE_PARACHUTE_MODEL
      L19_2 = L17_2
      L20_2 = 260873931
      L18_2(L19_2, L20_2)
      L18_2 = VEHICLE1
      L18_2 = L18_2._SET_VEHICLE_PARACHUTE_ACTIVE
      L19_2 = L17_2
      L20_2 = true
      L18_2(L19_2, L20_2)
      L18_2 = util
      L18_2 = L18_2.yield
      L19_2 = 120
      L18_2(L19_2)
      L18_2 = delete_entity
      L19_2 = L17_2
      L18_2(L19_2)
    end
    L12_2 = 1
    L13_2 = 10
    L14_2 = 1
    for L15_2 = L12_2, L13_2, L14_2 do
      L16_2 = ENTITY
      L16_2 = L16_2.GET_ENTITY_COORDS
      L17_2 = L10_2
      L18_2 = true
      L16_2 = L16_2(L17_2, L18_2)
      L17_2 = CreateVehicle
      L18_2 = util
      L18_2 = L18_2.joaat
      L19_2 = "Ruiner2"
      L18_2 = L18_2(L19_2)
      L19_2 = L16_2
      L20_2 = ENTITY
      L20_2 = L20_2.GET_ENTITY_HEADING
      L21_2 = L4_2
      L20_2 = L20_2(L21_2)
      L21_2 = true
      L17_2 = L17_2(L18_2, L19_2, L20_2, L21_2)
      L18_2 = PED
      L18_2 = L18_2.SET_PED_INTO_VEHICLE
      L19_2 = L10_2
      L20_2 = L17_2
      L21_2 = -1
      L18_2(L19_2, L20_2, L21_2)
      L18_2 = ENTITY
      L18_2 = L18_2.SET_ENTITY_COORDS_NO_OFFSET
      L19_2 = L17_2
      L20_2 = L16_2.x
      L21_2 = L16_2.y
      L22_2 = 1000
      L23_2 = false
      L24_2 = true
      L25_2 = true
      L18_2(L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
      L18_2 = util
      L18_2 = L18_2.yield
      L19_2 = 100
      L18_2(L19_2)
      L18_2 = VEHICLE1
      L18_2 = L18_2._SET_VEHICLE_PARACHUTE_MODEL
      L19_2 = L17_2
      L20_2 = 546252211
      L18_2(L19_2, L20_2)
      L18_2 = VEHICLE1
      L18_2 = L18_2._SET_VEHICLE_PARACHUTE_ACTIVE
      L19_2 = L17_2
      L20_2 = true
      L18_2(L19_2, L20_2)
      L18_2 = util
      L18_2 = L18_2.yield
      L19_2 = 100
      L18_2(L19_2)
      L18_2 = delete_entity
      L19_2 = L17_2
      L18_2(L19_2)
    end
    L12_2 = 1
    L13_2 = 8
    L14_2 = 1
    for L15_2 = L12_2, L13_2, L14_2 do
      L16_2 = ENTITY
      L16_2 = L16_2.GET_ENTITY_COORDS
      L17_2 = L10_2
      L18_2 = true
      L16_2 = L16_2(L17_2, L18_2)
      L17_2 = CreateVehicle
      L18_2 = util
      L18_2 = L18_2.joaat
      L19_2 = "Ruiner2"
      L18_2 = L18_2(L19_2)
      L19_2 = L16_2
      L20_2 = ENTITY
      L20_2 = L20_2.GET_ENTITY_HEADING
      L21_2 = L4_2
      L20_2 = L20_2(L21_2)
      L21_2 = true
      L17_2 = L17_2(L18_2, L19_2, L20_2, L21_2)
      L18_2 = PED
      L18_2 = L18_2.SET_PED_INTO_VEHICLE
      L19_2 = L10_2
      L20_2 = L17_2
      L21_2 = -1
      L18_2(L19_2, L20_2, L21_2)
      L18_2 = ENTITY
      L18_2 = L18_2.SET_ENTITY_COORDS_NO_OFFSET
      L19_2 = L17_2
      L20_2 = L16_2.x
      L21_2 = L16_2.y
      L22_2 = 800
      L23_2 = false
      L24_2 = true
      L25_2 = true
      L18_2(L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
      L18_2 = util
      L18_2 = L18_2.yield
      L19_2 = 200
      L18_2(L19_2)
      L18_2 = VEHICLE1
      L18_2 = L18_2._SET_VEHICLE_PARACHUTE_MODEL
      L19_2 = L17_2
      L20_2 = 148511758
      L18_2(L19_2, L20_2)
      L18_2 = VEHICLE1
      L18_2 = L18_2._SET_VEHICLE_PARACHUTE_ACTIVE
      L19_2 = L17_2
      L20_2 = true
      L18_2(L19_2, L20_2)
      L18_2 = util
      L18_2 = L18_2.yield
      L19_2 = 200
      L18_2(L19_2)
      L18_2 = delete_entity
      L19_2 = L17_2
      L18_2(L19_2)
    end
    L12_2 = 1
    L13_2 = 10
    L14_2 = 1
    for L15_2 = L12_2, L13_2, L14_2 do
      L16_2 = ENTITY
      L16_2 = L16_2.GET_ENTITY_COORDS
      L17_2 = L10_2
      L18_2 = true
      L16_2 = L16_2(L17_2, L18_2)
      L17_2 = CreateVehicle
      L18_2 = util
      L18_2 = L18_2.joaat
      L19_2 = "Ruiner2"
      L18_2 = L18_2(L19_2)
      L19_2 = L16_2
      L20_2 = ENTITY
      L20_2 = L20_2.GET_ENTITY_HEADING
      L21_2 = L4_2
      L20_2 = L20_2(L21_2)
      L21_2 = true
      L17_2 = L17_2(L18_2, L19_2, L20_2, L21_2)
      L18_2 = PED
      L18_2 = L18_2.SET_PED_INTO_VEHICLE
      L19_2 = L10_2
      L20_2 = L17_2
      L21_2 = -1
      L18_2(L19_2, L20_2, L21_2)
      L18_2 = ENTITY
      L18_2 = L18_2.SET_ENTITY_COORDS_NO_OFFSET
      L19_2 = L17_2
      L20_2 = L16_2.x
      L21_2 = L16_2.y
      L22_2 = 500
      L23_2 = false
      L24_2 = true
      L25_2 = true
      L18_2(L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
      L18_2 = util
      L18_2 = L18_2.yield
      L19_2 = 100
      L18_2(L19_2)
      L18_2 = VEHICLE1
      L18_2 = L18_2._SET_VEHICLE_PARACHUTE_MODEL
      L19_2 = L17_2
      L20_2 = 260873931
      L18_2(L19_2, L20_2)
      L18_2 = VEHICLE1
      L18_2 = L18_2._SET_VEHICLE_PARACHUTE_ACTIVE
      L19_2 = L17_2
      L20_2 = true
      L18_2(L19_2, L20_2)
      L18_2 = util
      L18_2 = L18_2.yield
      L19_2 = 100
      L18_2(L19_2)
      L18_2 = delete_entity
      L19_2 = L17_2
      L18_2(L19_2)
    end
    L12_2 = util
    L12_2 = L12_2.yield
    L13_2 = 200
    L12_2(L13_2)
    L12_2 = 1
    L13_2 = 5
    L14_2 = 1
    for L15_2 = L12_2, L13_2, L14_2 do
      L16_2 = ENTITY
      L16_2 = L16_2.GET_ENTITY_COORDS
      L17_2 = L10_2
      L18_2 = true
      L16_2 = L16_2(L17_2, L18_2)
      L17_2 = CreateVehicle
      L18_2 = util
      L18_2 = L18_2.joaat
      L19_2 = "Ruiner2"
      L18_2 = L18_2(L19_2)
      L19_2 = L16_2
      L20_2 = ENTITY
      L20_2 = L20_2.GET_ENTITY_HEADING
      L21_2 = L4_2
      L20_2 = L20_2(L21_2)
      L21_2 = true
      L17_2 = L17_2(L18_2, L19_2, L20_2, L21_2)
      L18_2 = PED
      L18_2 = L18_2.SET_PED_INTO_VEHICLE
      L19_2 = L10_2
      L20_2 = L17_2
      L21_2 = -1
      L18_2(L19_2, L20_2, L21_2)
      L18_2 = ENTITY
      L18_2 = L18_2.SET_ENTITY_COORDS_NO_OFFSET
      L19_2 = L17_2
      L20_2 = L16_2.x
      L21_2 = L16_2.y
      L22_2 = 300
      L23_2 = false
      L24_2 = true
      L25_2 = true
      L18_2(L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
      L18_2 = util
      L18_2 = L18_2.yield
      L19_2 = 500
      L18_2(L19_2)
      L18_2 = VEHICLE1
      L18_2 = L18_2._SET_VEHICLE_PARACHUTE_MODEL
      L19_2 = L17_2
      L20_2 = 1381105889
      L18_2(L19_2, L20_2)
      L18_2 = VEHICLE1
      L18_2 = L18_2._SET_VEHICLE_PARACHUTE_ACTIVE
      L19_2 = L17_2
      L20_2 = true
      L18_2(L19_2, L20_2)
      L18_2 = util
      L18_2 = L18_2.yield
      L19_2 = 500
      L18_2(L19_2)
      L18_2 = delete_entity
      L19_2 = L17_2
      L18_2(L19_2)
    end
    L12_2 = 1
    L13_2 = 25
    L14_2 = 1
    for L15_2 = L12_2, L13_2, L14_2 do
      L16_2 = ENTITY
      L16_2 = L16_2.GET_ENTITY_COORDS
      L17_2 = L10_2
      L18_2 = true
      L16_2 = L16_2(L17_2, L18_2)
      L17_2 = CreateVehicle
      L18_2 = util
      L18_2 = L18_2.joaat
      L19_2 = "Ruiner2"
      L18_2 = L18_2(L19_2)
      L19_2 = L16_2
      L20_2 = ENTITY
      L20_2 = L20_2.GET_ENTITY_HEADING
      L21_2 = L4_2
      L20_2 = L20_2(L21_2)
      L21_2 = true
      L17_2 = L17_2(L18_2, L19_2, L20_2, L21_2)
      L18_2 = PED
      L18_2 = L18_2.SET_PED_INTO_VEHICLE
      L19_2 = L10_2
      L20_2 = L17_2
      L21_2 = -1
      L18_2(L19_2, L20_2, L21_2)
      L18_2 = ENTITY
      L18_2 = L18_2.SET_ENTITY_COORDS_NO_OFFSET
      L19_2 = L17_2
      L20_2 = L16_2.x
      L21_2 = L16_2.y
      L22_2 = 200
      L23_2 = false
      L24_2 = true
      L25_2 = true
      L18_2(L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
      L18_2 = util
      L18_2 = L18_2.yield
      L19_2 = 150
      L18_2(L19_2)
      L18_2 = VEHICLE1
      L18_2 = L18_2._SET_VEHICLE_PARACHUTE_MODEL
      L19_2 = L17_2
      L20_2 = 1500925016
      L18_2(L19_2, L20_2)
      L18_2 = VEHICLE1
      L18_2 = L18_2._SET_VEHICLE_PARACHUTE_ACTIVE
      L19_2 = L17_2
      L20_2 = true
      L18_2(L19_2, L20_2)
      L18_2 = util
      L18_2 = L18_2.yield
      L19_2 = 150
      L18_2(L19_2)
      L18_2 = delete_entity
      L19_2 = L17_2
      L18_2(L19_2)
    end
    L12_2 = ENTITY
    L12_2 = L12_2.SET_ENTITY_COORDS_NO_OFFSET
    L13_2 = L10_2
    L14_2 = L11_2.x
    L15_2 = L11_2.y
    L16_2 = L11_2.z
    L17_2 = false
    L18_2 = true
    L19_2 = true
    L12_2(L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
    L12_2 = 0
    L13_2 = 2
    L14_2 = 1
    for L15_2 = L12_2, L13_2, L14_2 do
      L16_2 = util
      L16_2 = L16_2.joaat
      L17_2 = "prop_logpile_06b"
      L16_2 = L16_2(L17_2)
      L17_2 = STREAMING
      L17_2 = L17_2.REQUEST_MODEL
      L18_2 = L16_2
      L17_2(L18_2)
      while true do
        L17_2 = STREAMING
        L17_2 = L17_2.HAS_MODEL_LOADED
        L18_2 = L16_2
        L17_2 = L17_2(L18_2)
        if L17_2 then
          break
        end
        L17_2 = util
        L17_2 = L17_2.yield
        L17_2()
      end
      L17_2 = PLAYER
      L17_2 = L17_2.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE
      L18_2 = PLAYER
      L18_2 = L18_2.PLAYER_ID
      L18_2 = L18_2()
      L19_2 = L16_2
      L17_2(L18_2, L19_2)
      L17_2 = ENTITY
      L17_2 = L17_2.SET_ENTITY_COORDS_NO_OFFSET
      L18_2 = L5_2
      L19_2 = 0
      L20_2 = 0
      L21_2 = 100
      L22_2 = false
      L23_2 = true
      L24_2 = true
      L17_2(L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
      L17_2 = WEAPON
      L17_2 = L17_2.GIVE_DELAYED_WEAPON_TO_PED
      L18_2 = L5_2
      L19_2 = 4222310262
      L20_2 = 100
      L21_2 = false
      L17_2(L18_2, L19_2, L20_2, L21_2)
      L17_2 = util
      L17_2 = L17_2.yield
      L18_2 = 800
      L17_2(L18_2)
      L17_2 = 0
      L18_2 = 1
      L19_2 = 1
      for L20_2 = L17_2, L18_2, L19_2 do
        L21_2 = PED
        L21_2 = L21_2.FORCE_PED_TO_OPEN_PARACHUTE
        L22_2 = L5_2
        L21_2(L22_2)
      end
      L17_2 = util
      L17_2 = L17_2.yield
      L18_2 = 800
      L17_2(L18_2)
      L17_2 = ENTITY
      L17_2 = L17_2.SET_ENTITY_COORDS_NO_OFFSET
      L18_2 = L5_2
      L19_2 = L6_2.x
      L20_2 = L6_2.y
      L21_2 = L6_2.z
      L22_2 = false
      L23_2 = true
      L24_2 = true
      L17_2(L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
      L17_2 = util
      L17_2 = L17_2.joaat
      L18_2 = "prop_beach_parasol_03"
      L17_2 = L17_2(L18_2)
      L18_2 = STREAMING
      L18_2 = L18_2.REQUEST_MODEL
      L19_2 = L17_2
      L18_2(L19_2)
      while true do
        L18_2 = STREAMING
        L18_2 = L18_2.HAS_MODEL_LOADED
        L19_2 = L17_2
        L18_2 = L18_2(L19_2)
        if L18_2 then
          break
        end
        L18_2 = util
        L18_2 = L18_2.yield
        L18_2()
      end
      L18_2 = PLAYER
      L18_2 = L18_2.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE
      L19_2 = PLAYER
      L19_2 = L19_2.PLAYER_ID
      L19_2 = L19_2()
      L20_2 = L17_2
      L18_2(L19_2, L20_2)
      L18_2 = ENTITY
      L18_2 = L18_2.SET_ENTITY_COORDS_NO_OFFSET
      L19_2 = L5_2
      L20_2 = 0
      L21_2 = 0
      L22_2 = 100
      L23_2 = 0
      L24_2 = 0
      L25_2 = 1
      L18_2(L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
      L18_2 = WEAPON
      L18_2 = L18_2.GIVE_DELAYED_WEAPON_TO_PED
      L19_2 = L5_2
      L20_2 = 4222310262
      L21_2 = 100
      L22_2 = false
      L18_2(L19_2, L20_2, L21_2, L22_2)
      L18_2 = util
      L18_2 = L18_2.yield
      L19_2 = 800
      L18_2(L19_2)
      L18_2 = 0
      L19_2 = 1
      L20_2 = 1
      for L21_2 = L18_2, L19_2, L20_2 do
        L22_2 = PED
        L22_2 = L22_2.FORCE_PED_TO_OPEN_PARACHUTE
        L23_2 = L5_2
        L22_2(L23_2)
      end
      L18_2 = util
      L18_2 = L18_2.yield
      L19_2 = 800
      L18_2(L19_2)
      L18_2 = ENTITY
      L18_2 = L18_2.SET_ENTITY_COORDS_NO_OFFSET
      L19_2 = L5_2
      L20_2 = L6_2.x
      L21_2 = L6_2.y
      L22_2 = L6_2.z
      L23_2 = false
      L24_2 = true
      L25_2 = true
      L18_2(L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
    end
    L12_2 = ENTITY
    L12_2 = L12_2.SET_ENTITY_COORDS_NO_OFFSET
    L13_2 = L5_2
    L14_2 = L6_2.x
    L15_2 = L6_2.y
    L16_2 = L6_2.z
    L17_2 = false
    L18_2 = true
    L19_2 = true
    L12_2(L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
    L12_2 = PLAYER
    L12_2 = L12_2.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE
    L13_2 = PLAYER
    L13_2 = L13_2.PLAYER_ID
    L13_2 = L13_2()
    L14_2 = 4227322399
    L12_2(L13_2, L14_2)
    L12_2 = WEAPON
    L12_2 = L12_2.GIVE_DELAYED_WEAPON_TO_PED
    L13_2 = L8_2
    L14_2 = 4222310262
    L15_2 = 100
    L16_2 = false
    L12_2(L13_2, L14_2, L15_2, L16_2)
    L12_2 = TASK
    L12_2 = L12_2.TASK_PARACHUTE_TO_TARGET
    L13_2 = L8_2
    L14_2 = L9_2.x
    L15_2 = L9_2.y
    L16_2 = L9_2.z
    L12_2(L13_2, L14_2, L15_2, L16_2)
    L12_2 = util
    L12_2 = L12_2.yield
    L12_2()
    L12_2 = TASK
    L12_2 = L12_2.CLEAR_PED_TASKS_IMMEDIATELY
    L13_2 = L8_2
    L12_2(L13_2)
    L12_2 = util
    L12_2 = L12_2.yield
    L13_2 = 300
    L12_2(L13_2)
    L12_2 = WEAPON
    L12_2 = L12_2.GIVE_DELAYED_WEAPON_TO_PED
    L13_2 = L8_2
    L14_2 = 4222310262
    L15_2 = 100
    L16_2 = false
    L12_2(L13_2, L14_2, L15_2, L16_2)
    L12_2 = PLAYER
    L13_2 = "CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE"
    L12_2 = L12_2[L13_2]
    L13_2 = L7_2
    L12_2(L13_2)
    L12_2 = util
    L12_2 = L12_2.yield
    L13_2 = 1000
    L12_2(L13_2)
    L12_2 = 1
    L13_2 = 10
    L14_2 = 1
    for L15_2 = L12_2, L13_2, L14_2 do
      L16_2 = util
      L16_2 = L16_2.spoof_script
      L17_2 = "freemode"
      L18_2 = SYSTEM
      L18_2 = L18_2.WAIT
      L16_2(L17_2, L18_2)
    end
    L12_2 = ENTITY
    L12_2 = L12_2.SET_ENTITY_HEALTH
    L13_2 = L8_2
    L14_2 = 0
    L12_2(L13_2, L14_2)
    L12_2 = NETWORK
    L12_2 = L12_2.NETWORK_RESURRECT_LOCAL_PLAYER
    L13_2 = L9_2.x
    L14_2 = L9_2.y
    L15_2 = L9_2.z
    L16_2 = 0
    L17_2 = false
    L18_2 = false
    L19_2 = 0
    L12_2(L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
    L12_2 = 1
    L13_2 = 2
    L14_2 = 1
    for L15_2 = L12_2, L13_2, L14_2 do
      L16_2 = ENTITY
      L16_2 = L16_2.GET_ENTITY_COORDS
      L17_2 = L10_2
      L18_2 = true
      L16_2 = L16_2(L17_2, L18_2)
      L17_2 = CreateVehicle
      L18_2 = util
      L18_2 = L18_2.joaat
      L19_2 = "Ruiner2"
      L18_2 = L18_2(L19_2)
      L19_2 = L16_2
      L20_2 = ENTITY
      L20_2 = L20_2.GET_ENTITY_HEADING
      L21_2 = L4_2
      L20_2 = L20_2(L21_2)
      L21_2 = true
      L17_2 = L17_2(L18_2, L19_2, L20_2, L21_2)
      L18_2 = PED
      L18_2 = L18_2.SET_PED_INTO_VEHICLE
      L19_2 = L10_2
      L20_2 = L17_2
      L21_2 = -1
      L18_2(L19_2, L20_2, L21_2)
      L18_2 = ENTITY
      L18_2 = L18_2.SET_ENTITY_COORDS_NO_OFFSET
      L19_2 = L17_2
      L20_2 = L16_2.x
      L21_2 = L16_2.y
      L22_2 = 150
      L23_2 = false
      L24_2 = true
      L25_2 = true
      L18_2(L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
      L18_2 = util
      L18_2 = L18_2.yield
      L19_2 = 200
      L18_2(L19_2)
      L18_2 = VEHICLE1
      L18_2 = L18_2._SET_VEHICLE_PARACHUTE_MODEL
      L19_2 = L17_2
      L20_2 = 1500925016
      L18_2(L19_2, L20_2)
      L18_2 = VEHICLE1
      L18_2 = L18_2._SET_VEHICLE_PARACHUTE_ACTIVE
      L19_2 = L17_2
      L20_2 = true
      L18_2(L19_2, L20_2)
      L18_2 = util
      L18_2 = L18_2.yield
      L19_2 = 200
      L18_2(L19_2)
      L18_2 = delete_entity
      L19_2 = L17_2
      L18_2(L19_2)
    end
    L12_2 = ENTITY
    L12_2 = L12_2.SET_ENTITY_COORDS_NO_OFFSET
    L13_2 = L10_2
    L14_2 = L11_2.x
    L15_2 = L11_2.y
    L16_2 = L11_2.z
    L17_2 = false
    L18_2 = true
    L19_2 = true
    L12_2(L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
    L12_2 = 1
    L13_2 = 2
    L14_2 = 1
    for L15_2 = L12_2, L13_2, L14_2 do
      L16_2 = PLAYER
      L16_2 = L16_2.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE
      L17_2 = PLAYER
      L17_2 = L17_2.PLAYER_ID
      L17_2 = L17_2()
      L18_2 = 4227322399
      L16_2(L17_2, L18_2)
      L16_2 = WEAPON
      L16_2 = L16_2.GIVE_DELAYED_WEAPON_TO_PED
      L17_2 = L8_2
      L18_2 = 4222310262
      L19_2 = 100
      L20_2 = false
      L16_2(L17_2, L18_2, L19_2, L20_2)
      L16_2 = TASK
      L16_2 = L16_2.TASK_PARACHUTE_TO_TARGET
      L17_2 = L8_2
      L18_2 = L9_2.x
      L19_2 = L9_2.y
      L20_2 = L9_2.z
      L16_2(L17_2, L18_2, L19_2, L20_2)
      L16_2 = util
      L16_2 = L16_2.yield
      L16_2()
      L16_2 = TASK
      L16_2 = L16_2.CLEAR_PED_TASKS_IMMEDIATELY
      L17_2 = L8_2
      L16_2(L17_2)
      L16_2 = util
      L16_2 = L16_2.yield
      L17_2 = 200
      L16_2(L17_2)
      L16_2 = WEAPON
      L16_2 = L16_2.GIVE_DELAYED_WEAPON_TO_PED
      L17_2 = L8_2
      L18_2 = 4222310262
      L19_2 = 100
      L20_2 = false
      L16_2(L17_2, L18_2, L19_2, L20_2)
      L16_2 = PLAYER
      L17_2 = "CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE"
      L16_2 = L16_2[L17_2]
      L17_2 = L7_2
      L16_2(L17_2)
      L16_2 = util
      L16_2 = L16_2.yield
      L17_2 = 4500
      L16_2(L17_2)
      L16_2 = 1
      L17_2 = 2
      L18_2 = 1
      for L19_2 = L16_2, L17_2, L18_2 do
        L20_2 = util
        L20_2 = L20_2.spoof_script
        L21_2 = "freemode"
        L22_2 = SYSTEM
        L22_2 = L22_2.WAIT
        L20_2(L21_2, L22_2)
      end
      L16_2 = ENTITY
      L16_2 = L16_2.SET_ENTITY_HEALTH
      L17_2 = L8_2
      L18_2 = 0
      L16_2(L17_2, L18_2)
      L16_2 = NETWORK
      L16_2 = L16_2.NETWORK_RESURRECT_LOCAL_PLAYER
      L17_2 = L9_2.x
      L18_2 = L9_2.y
      L19_2 = L9_2.z
      L20_2 = 0
      L21_2 = false
      L22_2 = false
      L23_2 = 0
      L16_2(L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
    end
  end
end
L68_1[L69_1] = L70_1
L68_1 = _ENV
L69_1 = "Kick_room"
function L70_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2
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
  L4_2 = "p_spinning_anus_s"
  L3_2 = L3_2(L4_2)
  L4_2 = util
  L4_2 = L4_2.joaat
  L5_2 = "brickade2"
  L4_2 = L4_2(L5_2)
  L5_2 = request_model
  L6_2 = L3_2
  L5_2(L6_2)
  L5_2 = request_model
  L6_2 = L4_2
  L5_2(L6_2)
  L5_2 = 1
  L6_2 = 5
  L7_2 = 1
  for L8_2 = L5_2, L6_2, L7_2 do
    L9_2 = entities
    L9_2 = L9_2.create_object
    L10_2 = L3_2
    L11_2 = L2_2
    L9_2 = L9_2(L10_2, L11_2)
    L10_2 = entities
    L10_2 = L10_2.create_vehicle
    L11_2 = L4_2
    L12_2 = L2_2
    L13_2 = 0
    L10_2 = L10_2(L11_2, L12_2, L13_2)
    L11_2 = ENTITY
    L11_2 = L11_2.SET_ENTITY_VISIBLE
    L12_2 = L9_2
    L13_2 = false
    L11_2(L12_2, L13_2)
    L11_2 = ENTITY
    L11_2 = L11_2.SET_ENTITY_VISIBLE
    L12_2 = L10_2
    L13_2 = false
    L11_2(L12_2, L13_2)
    L11_2 = ENTITY
    L11_2 = L11_2.SET_ENTITY_INVINCIBLE
    L12_2 = L10_2
    L13_2 = true
    L11_2(L12_2, L13_2)
    L11_2 = ENTITY
    L11_2 = L11_2.SET_ENTITY_COLLISION
    L12_2 = L9_2
    L13_2 = true
    L14_2 = true
    L11_2(L12_2, L13_2, L14_2)
    L11_2 = ENTITY
    L11_2 = L11_2.APPLY_FORCE_TO_ENTITY
    L12_2 = L10_2
    L13_2 = 1
    L14_2 = 0.0
    L15_2 = 10
    L16_2 = 10
    L17_2 = 0.0
    L18_2 = 0.0
    L19_2 = 0.0
    L20_2 = 0
    L21_2 = 1
    L22_2 = 1
    L23_2 = 1
    L24_2 = 0
    L25_2 = 1
    L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
    L11_2 = util
    L11_2 = L11_2.yield
    L12_2 = 500
    L11_2(L12_2)
    L11_2 = delete_entity
    L12_2 = L9_2
    L11_2(L12_2)
    L11_2 = delete_entity
    L12_2 = L10_2
    L11_2(L12_2)
    L11_2 = util
    L11_2 = L11_2.yield
    L12_2 = 500
    L11_2(L12_2)
  end
end
L68_1[L69_1] = L70_1
L68_1 = _ENV
L69_1 = "nuclear_bomb_player"
function L70_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED_SCRIPT_INDEX
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_COORDS
  L3_2 = L1_2
  L4_2 = true
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = CreateVehicle
  L4_2 = 1131912276
  L5_2 = L2_2
  L6_2 = 0
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  L4_2 = CreateObject
  L5_2 = 253279588
  L6_2 = L2_2
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = L2_2.y
  L5_2 = L5_2 + 2
  L2_2.y = L5_2
  L5_2 = L2_2.z
  L5_2 = L5_2 + 70
  L2_2.z = L5_2
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_ALPHA
  L6_2 = L3_2
  L7_2 = 255
  L5_2(L6_2, L7_2)
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_VISIBLE
  L6_2 = L3_2
  L7_2 = false
  L8_2 = 0
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_COORDS_NO_OFFSET
  L6_2 = L3_2
  L7_2 = L2_2.x
  L8_2 = L2_2.y
  L9_2 = L2_2.z
  L10_2 = false
  L11_2 = true
  L12_2 = true
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L5_2 = ENTITY
  L5_2 = L5_2.ATTACH_ENTITY_TO_ENTITY
  L6_2 = L4_2
  L7_2 = L3_2
  L8_2 = 0
  L9_2 = 0.0
  L10_2 = 0.0
  L11_2 = 0.0
  L12_2 = 1.0
  L13_2 = 1.0
  L14_2 = 1
  L15_2 = true
  L16_2 = false
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
  L5_2 = orbital
  L6_2 = A0_2
  L5_2(L6_2)
  L5_2 = delete_entity
  L6_2 = L3_2
  L5_2(L6_2)
  L5_2 = delete_entity
  L6_2 = L4_2
  L5_2(L6_2)
end
L68_1[L69_1] = L70_1
L68_1 = _ENV
L69_1 = "util"
L68_1 = L68_1[L69_1]
L69_1 = "joaat"
L68_1 = L68_1[L69_1]
L69_1 = "prop_ld_ferris_wheel"
L68_1 = L68_1(L69_1)
L69_1 = _ENV
L70_1 = "obj_creat"
function L71_1(A0_2)
  local L1_2, L2_2
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = object_stuff
  L2_2 = L2_2.objects
  L2_2 = L2_2[A0_2]
  L1_2 = L1_2(L2_2)
  L68_1 = L1_2
end
L69_1[L70_1] = L71_1
L69_1 = 150
L70_1 = _ENV
L71_1 = "obj_creat_speed"
function L72_1(A0_2)
  local L1_2
  L69_1 = A0_2
end
L70_1[L71_1] = L72_1
L70_1 = _ENV
L71_1 = "Ghost_Beast_Player"
function L72_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if 0 ~= L1_2 then
    L1_2 = PLAYER
    L1_2 = L1_2.GET_PLAYER_PED_SCRIPT_INDEX
    L2_2 = A0_2
    L1_2 = L1_2(L2_2)
    L2_2 = players
    L2_2 = L2_2.get_position
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    L3_2 = L68_1
    L4_2 = util
    L4_2 = L4_2.joaat
    L5_2 = "rallytruck"
    L4_2 = L4_2(L5_2)
    L5_2 = request_model
    L6_2 = L3_2
    L5_2(L6_2)
    L5_2 = request_model
    L6_2 = L4_2
    L5_2(L6_2)
    L5_2 = entities
    L5_2 = L5_2.create_object
    L6_2 = L3_2
    L7_2 = L2_2
    L5_2 = L5_2(L6_2, L7_2)
    L6_2 = entities
    L6_2 = L6_2.create_vehicle
    L7_2 = L4_2
    L8_2 = L2_2
    L9_2 = 0
    L6_2 = L6_2(L7_2, L8_2, L9_2)
    L7_2 = ENTITY
    L7_2 = L7_2.SET_ENTITY_VISIBLE
    L8_2 = L5_2
    L9_2 = false
    L7_2(L8_2, L9_2)
    L7_2 = ENTITY
    L7_2 = L7_2.SET_ENTITY_VISIBLE
    L8_2 = L6_2
    L9_2 = false
    L7_2(L8_2, L9_2)
    L7_2 = ENTITY
    L7_2 = L7_2.SET_ENTITY_INVINCIBLE
    L8_2 = L5_2
    L9_2 = true
    L7_2(L8_2, L9_2)
    L7_2 = ENTITY
    L7_2 = L7_2.SET_ENTITY_COLLISION
    L8_2 = L5_2
    L9_2 = true
    L10_2 = true
    L7_2(L8_2, L9_2, L10_2)
    L7_2 = ENTITY
    L7_2 = L7_2.APPLY_FORCE_TO_ENTITY
    L8_2 = L6_2
    L9_2 = 1
    L10_2 = 0.0
    L11_2 = 10.0
    L12_2 = 10.0
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
    L8_2 = L69_1
    L7_2(L8_2)
    L7_2 = delete_entity
    L8_2 = L5_2
    L7_2(L8_2)
    L7_2 = delete_entity
    L8_2 = L6_2
    L7_2(L8_2)
  end
end
L70_1[L71_1] = L72_1
L70_1 = _ENV
L71_1 = "Death_barrier"
function L72_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2
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
  L4_2 = "prop_windmill_01"
  L3_2 = L3_2(L4_2)
  L4_2 = util
  L4_2 = L4_2.joaat
  L5_2 = "rallytruck"
  L4_2 = L4_2(L5_2)
  L5_2 = request_model
  L6_2 = L3_2
  L5_2(L6_2)
  L5_2 = request_model
  L6_2 = L4_2
  L5_2(L6_2)
  L5_2 = 0
  L6_2 = 5
  L7_2 = 1
  for L8_2 = L5_2, L6_2, L7_2 do
    L9_2 = TASK
    L9_2 = L9_2.IS_PED_WALKING
    L10_2 = L1_2
    L9_2 = L9_2(L10_2)
    if L9_2 then
      L9_2 = ENTITY
      L9_2 = L9_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
      L10_2 = L1_2
      L11_2 = 0.0
      L12_2 = 1.3
      L13_2 = 0.0
      L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2)
      spawn_pos = L9_2
    else
      L9_2 = players
      L9_2 = L9_2.get_position
      L10_2 = A0_2
      L9_2 = L9_2(L10_2)
      spawn_pos = L9_2
    end
    L9_2 = entities
    L9_2 = L9_2.create_object
    L10_2 = L3_2
    L11_2 = spawn_pos
    L9_2 = L9_2(L10_2, L11_2)
    L10_2 = entities
    L10_2 = L10_2.create_vehicle
    L11_2 = L4_2
    L12_2 = spawn_pos
    L13_2 = 0
    L10_2 = L10_2(L11_2, L12_2, L13_2)
    L11_2 = ENTITY
    L11_2 = L11_2.SET_ENTITY_VISIBLE
    L12_2 = L9_2
    L13_2 = false
    L11_2(L12_2, L13_2)
    L11_2 = ENTITY
    L11_2 = L11_2.SET_ENTITY_VISIBLE
    L12_2 = L10_2
    L13_2 = false
    L11_2(L12_2, L13_2)
    L11_2 = ENTITY
    L11_2 = L11_2.SET_ENTITY_INVINCIBLE
    L12_2 = L9_2
    L13_2 = true
    L11_2(L12_2, L13_2)
    L11_2 = ENTITY
    L11_2 = L11_2.SET_ENTITY_COLLISION
    L12_2 = L9_2
    L13_2 = true
    L14_2 = true
    L11_2(L12_2, L13_2, L14_2)
    L11_2 = ENTITY
    L11_2 = L11_2.APPLY_FORCE_TO_ENTITY
    L12_2 = L10_2
    L13_2 = 1
    L14_2 = 0.0
    L15_2 = 10
    L16_2 = 10
    L17_2 = 0.0
    L18_2 = 0.0
    L19_2 = 0.0
    L20_2 = 0
    L21_2 = 1
    L22_2 = 1
    L23_2 = 1
    L24_2 = 0
    L25_2 = 1
    L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2)
    L11_2 = util
    L11_2 = L11_2.yield
    L12_2 = 150
    L11_2(L12_2)
    L11_2 = delete_entity
    L12_2 = L9_2
    L11_2(L12_2)
    L11_2 = delete_entity
    L12_2 = L10_2
    L11_2(L12_2)
  end
end
L70_1[L71_1] = L72_1
L70_1 = _ENV
L71_1 = "Force_kill"
function L72_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2
  L3_2 = PLAYER
  L3_2 = L3_2.GET_PLAYER_PED_SCRIPT_INDEX
  L4_2 = A2_2
  L3_2 = L3_2(L4_2)
  L4_2 = ENTITY
  L4_2 = L4_2.GET_ENTITY_COORDS
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  L5_2 = util
  L5_2 = L5_2.joaat
  L6_2 = A1_2
  L5_2 = L5_2(L6_2)
  L6_2 = request_model
  L7_2 = L5_2
  L6_2(L7_2)
  if "Khanjali" == A1_2 then
    height = 2.8
    offset = 0
  elseif "APC" == A1_2 then
    height = 3.4
    offset = -1.5
  end
  L6_2 = TASK
  L6_2 = L6_2.IS_PED_STILL
  L7_2 = L3_2
  L6_2 = L6_2(L7_2)
  if L6_2 then
    distance = 0
  else
    L6_2 = TASK
    L6_2 = L6_2.IS_PED_STILL
    L7_2 = L3_2
    L6_2 = L6_2(L7_2)
    if not L6_2 then
      distance = 3
    end
  end
  L6_2 = entities
  L6_2 = L6_2.create_vehicle
  L7_2 = L5_2
  L8_2 = ENTITY
  L8_2 = L8_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L9_2 = L3_2
  L10_2 = offset
  L11_2 = distance
  L12_2 = height
  L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2)
  L9_2 = ENTITY
  L9_2 = L9_2.GET_ENTITY_HEADING
  L10_2 = L3_2
  L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2 = L9_2(L10_2)
  L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2)
  L7_2 = entities
  L7_2 = L7_2.create_vehicle
  L8_2 = L5_2
  L9_2 = L4_2
  L10_2 = 0
  L7_2 = L7_2(L8_2, L9_2, L10_2)
  L8_2 = entities
  L8_2 = L8_2.create_vehicle
  L9_2 = L5_2
  L10_2 = L4_2
  L11_2 = 0
  L8_2 = L8_2(L9_2, L10_2, L11_2)
  L9_2 = entities
  L9_2 = L9_2.create_vehicle
  L10_2 = L5_2
  L11_2 = L4_2
  L12_2 = 0
  L9_2 = L9_2(L10_2, L11_2, L12_2)
  L10_2 = {}
  L11_2 = L9_2
  L12_2 = L8_2
  L13_2 = L7_2
  L14_2 = L6_2
  L10_2[1] = L11_2
  L10_2[2] = L12_2
  L10_2[3] = L13_2
  L10_2[4] = L14_2
  L11_2 = ENTITY
  L11_2 = L11_2.ATTACH_ENTITY_TO_ENTITY
  L12_2 = L7_2
  L13_2 = L6_2
  L14_2 = 0
  L15_2 = 0
  L16_2 = 3
  L17_2 = 0
  L18_2 = 0
  L19_2 = 0
  L20_2 = -180
  L21_2 = true
  L22_2 = false
  L23_2 = true
  L24_2 = false
  L25_2 = 0
  L26_2 = true
  L27_2 = 0
  L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2)
  L11_2 = ENTITY
  L11_2 = L11_2.ATTACH_ENTITY_TO_ENTITY
  L12_2 = L8_2
  L13_2 = L6_2
  L14_2 = 0
  L15_2 = 3
  L16_2 = 3
  L17_2 = 0
  L18_2 = 0
  L19_2 = 0
  L20_2 = -180
  L21_2 = true
  L22_2 = false
  L23_2 = true
  L24_2 = false
  L25_2 = 0
  L26_2 = true
  L27_2 = 0
  L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2)
  L11_2 = ENTITY
  L11_2 = L11_2.ATTACH_ENTITY_TO_ENTITY
  L12_2 = L9_2
  L13_2 = L6_2
  L14_2 = 0
  L15_2 = 3
  L16_2 = 0
  L17_2 = 0
  L18_2 = 0
  L19_2 = 0
  L20_2 = 0
  L21_2 = true
  L22_2 = false
  L23_2 = true
  L24_2 = false
  L25_2 = 0
  L26_2 = true
  L27_2 = 0
  L11_2(L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2)
  L11_2 = ENTITY
  L11_2 = L11_2.SET_ENTITY_VISIBLE
  L12_2 = L6_2
  L13_2 = false
  L11_2(L12_2, L13_2)
  L11_2 = util
  L11_2 = L11_2.yield
  L12_2 = 5000
  L11_2(L12_2)
  L11_2 = 1
  L12_2 = #L10_2
  L13_2 = 1
  for L14_2 = L11_2, L12_2, L13_2 do
    L15_2 = delete_entity
    L16_2 = L10_2[L14_2]
    L15_2(L16_2)
  end
end
L70_1[L71_1] = L72_1
L70_1 = _ENV
L71_1 = "big_fireworks"
function L72_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L0_2 = ENTITY
  L0_2 = L0_2.GET_ENTITY_COORDS
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = false
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "weapon_firework"
  L1_2 = L1_2(L2_2)
  L2_2 = request_weapon_asset
  L3_2 = L1_2
  L2_2(L3_2)
  L2_2 = WEAPON
  L2_2 = L2_2.GIVE_WEAPON_TO_PED
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2 = L3_2()
  L4_2 = L1_2
  L5_2 = 120
  L6_2 = true
  L7_2 = false
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  L2_2 = MISC
  L2_2 = L2_2.SHOOT_SINGLE_BULLET_BETWEEN_COORDS
  L3_2 = L0_2.x
  L3_2 = L3_2 - 90
  L4_2 = math
  L4_2 = L4_2.random
  L5_2 = 0
  L6_2 = 40
  L4_2 = L4_2(L5_2, L6_2)
  L3_2 = L3_2 - L4_2
  L4_2 = L0_2.y
  L4_2 = L4_2 - 90
  L5_2 = L0_2.z
  L6_2 = L0_2.x
  L6_2 = L6_2 - 90
  L7_2 = math
  L7_2 = L7_2.random
  L8_2 = 0
  L9_2 = 40
  L7_2 = L7_2(L8_2, L9_2)
  L6_2 = L6_2 - L7_2
  L7_2 = L0_2.y
  L7_2 = L7_2 - 90
  L8_2 = L0_2.z
  L8_2 = L8_2 + 20
  L9_2 = 200
  L10_2 = false
  L11_2 = L1_2
  L12_2 = 0
  L13_2 = true
  L14_2 = false
  L15_2 = 150
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  L2_2 = util
  L2_2 = L2_2.yield
  L3_2 = 500
  L2_2(L3_2)
  L2_2 = MISC
  L2_2 = L2_2.SHOOT_SINGLE_BULLET_BETWEEN_COORDS
  L3_2 = L0_2.x
  L3_2 = L3_2 - 90
  L4_2 = math
  L4_2 = L4_2.random
  L5_2 = 0
  L6_2 = 40
  L4_2 = L4_2(L5_2, L6_2)
  L3_2 = L3_2 - L4_2
  L4_2 = L0_2.y
  L4_2 = L4_2 - 90
  L5_2 = L0_2.z
  L6_2 = L0_2.x
  L6_2 = L6_2 - 90
  L7_2 = math
  L7_2 = L7_2.random
  L8_2 = 0
  L9_2 = 40
  L7_2 = L7_2(L8_2, L9_2)
  L6_2 = L6_2 - L7_2
  L7_2 = L0_2.y
  L7_2 = L7_2 - 90
  L8_2 = L0_2.z
  L8_2 = L8_2 + 20
  L9_2 = 200
  L10_2 = false
  L11_2 = L1_2
  L12_2 = 0
  L13_2 = true
  L14_2 = false
  L15_2 = 150
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  L2_2 = util
  L2_2 = L2_2.yield
  L3_2 = 500
  L2_2(L3_2)
  L2_2 = MISC
  L2_2 = L2_2.SHOOT_SINGLE_BULLET_BETWEEN_COORDS
  L3_2 = L0_2.x
  L3_2 = L3_2 - 90
  L4_2 = math
  L4_2 = L4_2.random
  L5_2 = 0
  L6_2 = 40
  L4_2 = L4_2(L5_2, L6_2)
  L3_2 = L3_2 - L4_2
  L4_2 = L0_2.y
  L4_2 = L4_2 - 90
  L5_2 = L0_2.z
  L6_2 = L0_2.x
  L6_2 = L6_2 - 90
  L7_2 = math
  L7_2 = L7_2.random
  L8_2 = 0
  L9_2 = 40
  L7_2 = L7_2(L8_2, L9_2)
  L6_2 = L6_2 - L7_2
  L7_2 = L0_2.y
  L7_2 = L7_2 - 90
  L8_2 = L0_2.z
  L8_2 = L8_2 + 20
  L9_2 = 200
  L10_2 = false
  L11_2 = L1_2
  L12_2 = 0
  L13_2 = true
  L14_2 = false
  L15_2 = 150
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  L2_2 = util
  L2_2 = L2_2.yield
  L3_2 = 500
  L2_2(L3_2)
  L2_2 = MISC
  L2_2 = L2_2.SHOOT_SINGLE_BULLET_BETWEEN_COORDS
  L3_2 = L0_2.x
  L3_2 = L3_2 - 90
  L4_2 = math
  L4_2 = L4_2.random
  L5_2 = 0
  L6_2 = 40
  L4_2 = L4_2(L5_2, L6_2)
  L3_2 = L3_2 - L4_2
  L4_2 = L0_2.y
  L4_2 = L4_2 - 90
  L5_2 = L0_2.z
  L6_2 = L0_2.x
  L6_2 = L6_2 - 90
  L7_2 = math
  L7_2 = L7_2.random
  L8_2 = 0
  L9_2 = 40
  L7_2 = L7_2(L8_2, L9_2)
  L6_2 = L6_2 - L7_2
  L7_2 = L0_2.y
  L7_2 = L7_2 - 90
  L8_2 = L0_2.z
  L8_2 = L8_2 + 20
  L9_2 = 200
  L10_2 = false
  L11_2 = L1_2
  L12_2 = 0
  L13_2 = true
  L14_2 = false
  L15_2 = 150
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  L2_2 = util
  L2_2 = L2_2.yield
  L3_2 = 500
  L2_2(L3_2)
  L2_2 = MISC
  L2_2 = L2_2.SHOOT_SINGLE_BULLET_BETWEEN_COORDS
  L3_2 = L0_2.x
  L3_2 = L3_2 - 90
  L4_2 = math
  L4_2 = L4_2.random
  L5_2 = 0
  L6_2 = 40
  L4_2 = L4_2(L5_2, L6_2)
  L3_2 = L3_2 - L4_2
  L4_2 = L0_2.y
  L4_2 = L4_2 - 90
  L5_2 = L0_2.z
  L6_2 = L0_2.x
  L6_2 = L6_2 - 90
  L7_2 = math
  L7_2 = L7_2.random
  L8_2 = 0
  L9_2 = 40
  L7_2 = L7_2(L8_2, L9_2)
  L6_2 = L6_2 - L7_2
  L7_2 = L0_2.y
  L7_2 = L7_2 - 90
  L8_2 = L0_2.z
  L8_2 = L8_2 + 20
  L9_2 = 200
  L10_2 = false
  L11_2 = L1_2
  L12_2 = 0
  L13_2 = true
  L14_2 = false
  L15_2 = 150
  L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  L2_2 = util
  L2_2 = L2_2.yield
  L3_2 = 500
  L2_2(L3_2)
end
L70_1[L71_1] = L72_1
L70_1 = _ENV
L71_1 = "new_firework"
function L72_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L0_2 = "scr_indep_fireworks"
  L1_2 = "scr_indep_firework_starburst"
  L2_2 = request_ptfx_asset
  L3_2 = L0_2
  L2_2(L3_2)
  L2_2 = GRAPHICS
  L2_2 = L2_2.USE_PARTICLE_FX_ASSET
  L3_2 = L0_2
  L2_2(L3_2)
  L2_2 = math
  L2_2 = L2_2.random
  L3_2 = 0
  L4_2 = 255
  L2_2 = L2_2(L3_2, L4_2)
  L2_2 = L2_2 / 255
  indep_fireworks_r = L2_2
  L2_2 = math
  L2_2 = L2_2.random
  L3_2 = 0
  L4_2 = 255
  L2_2 = L2_2(L3_2, L4_2)
  L2_2 = L2_2 / 255
  indep_fireworks_g = L2_2
  L2_2 = math
  L2_2 = L2_2.random
  L3_2 = 0
  L4_2 = 255
  L2_2 = L2_2(L3_2, L4_2)
  L2_2 = L2_2 / 255
  indep_fireworks_b = L2_2
  L2_2 = ENTITY
  L2_2 = L2_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2 = L3_2()
  L4_2 = math
  L4_2 = L4_2.random
  L5_2 = -15
  L6_2 = 15
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = math
  L5_2 = L5_2.random
  L6_2 = 0
  L7_2 = 10
  L5_2 = L5_2(L6_2, L7_2)
  L5_2 = 50 + L5_2
  L6_2 = 0
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  L3_2 = GRAPHICS
  L4_2 = "START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD"
  L3_2 = L3_2[L4_2]
  L4_2 = L1_2
  L5_2 = L2_2.x
  L6_2 = L2_2.y
  L7_2 = L2_2.z
  L8_2 = 0
  L9_2 = 0
  L10_2 = 0
  L11_2 = 1.0
  L12_2 = false
  L13_2 = false
  L14_2 = false
  L15_2 = false
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  L3_2 = GRAPHICS
  L3_2 = L3_2.SET_PARTICLE_FX_NON_LOOPED_COLOUR
  L4_2 = indep_fireworks_r
  L5_2 = indep_fireworks_g
  L6_2 = indep_fireworks_b
  L3_2(L4_2, L5_2, L6_2)
  L3_2 = util
  L3_2 = L3_2.yield
  L4_2 = math
  L4_2 = L4_2.random
  L5_2 = 500
  L6_2 = 2000
  L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L4_2(L5_2, L6_2)
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
end
L70_1[L71_1] = L72_1
L70_1 = _ENV
L71_1 = "new_firework2"
function L72_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L0_2 = "scr_indep_fireworks"
  L1_2 = "scr_indep_firework_fountain"
  L2_2 = request_ptfx_asset
  L3_2 = L0_2
  L2_2(L3_2)
  L2_2 = GRAPHICS
  L2_2 = L2_2.USE_PARTICLE_FX_ASSET
  L3_2 = L0_2
  L2_2(L3_2)
  L2_2 = math
  L2_2 = L2_2.random
  L3_2 = 0
  L4_2 = 255
  L2_2 = L2_2(L3_2, L4_2)
  L2_2 = L2_2 / 255
  indep_fireworks_r = L2_2
  L2_2 = math
  L2_2 = L2_2.random
  L3_2 = 0
  L4_2 = 255
  L2_2 = L2_2(L3_2, L4_2)
  L2_2 = L2_2 / 255
  indep_fireworks_g = L2_2
  L2_2 = math
  L2_2 = L2_2.random
  L3_2 = 0
  L4_2 = 255
  L2_2 = L2_2(L3_2, L4_2)
  L2_2 = L2_2 / 255
  indep_fireworks_b = L2_2
  L2_2 = ENTITY
  L2_2 = L2_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_PED_ID
  L3_2 = L3_2()
  L4_2 = math
  L4_2 = L4_2.random
  L5_2 = -15
  L6_2 = 15
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = math
  L5_2 = L5_2.random
  L6_2 = 0
  L7_2 = 10
  L5_2 = L5_2(L6_2, L7_2)
  L5_2 = 50 + L5_2
  L6_2 = 0
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  L3_2 = GRAPHICS
  L4_2 = "START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD"
  L3_2 = L3_2[L4_2]
  L4_2 = L1_2
  L5_2 = L2_2.x
  L6_2 = L2_2.y
  L7_2 = L2_2.z
  L8_2 = 0
  L9_2 = 0
  L10_2 = 0
  L11_2 = 1.0
  L12_2 = false
  L13_2 = false
  L14_2 = false
  L15_2 = false
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  L3_2 = GRAPHICS
  L3_2 = L3_2.SET_PARTICLE_FX_NON_LOOPED_COLOUR
  L4_2 = indep_fireworks_r
  L5_2 = indep_fireworks_g
  L6_2 = indep_fireworks_b
  L3_2(L4_2, L5_2, L6_2)
  L3_2 = util
  L3_2 = L3_2.yield
  L4_2 = math
  L4_2 = L4_2.random
  L5_2 = 500
  L6_2 = 2000
  L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L4_2(L5_2, L6_2)
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
end
L70_1[L71_1] = L72_1
L70_1 = 0
L71_1 = _ENV
L72_1 = "Angry_plane"
function L73_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2
  L0_2 = L70_1
  if L0_2 < 15 then
    L0_2 = timer
    L0_2 = L0_2.elapsed
    L0_2 = L0_2()
    L1_2 = 300
    if L0_2 > L1_2 then
      L0_2 = util
      L0_2 = L0_2.joaat
      L1_2 = "s_m_y_blackops_01"
      L0_2 = L0_2(L1_2)
      L1_2 = planes
      L2_2 = math
      L2_2 = L2_2.random
      L3_2 = planes
      L3_2 = #L3_2
      L2_2 = L2_2(L3_2)
      L1_2 = L1_2[L2_2]
      L2_2 = util
      L2_2 = L2_2.joaat
      L3_2 = L1_2
      L2_2 = L2_2(L3_2)
      L3_2 = request_model
      L4_2 = L2_2
      L3_2(L4_2)
      L3_2 = request_model
      L4_2 = L0_2
      L3_2(L4_2)
      L3_2 = players
      L3_2 = L3_2.get_position
      L4_2 = PLAYER
      L4_2 = L4_2.PLAYER_ID
      L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L4_2()
      L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
      L4_2 = VEHICLE
      L4_2 = L4_2.CREATE_VEHICLE
      L5_2 = L2_2
      L6_2 = L3_2.x
      L7_2 = L3_2.y
      L8_2 = L3_2.z
      L9_2 = CAM
      L9_2 = L9_2.GET_GAMEPLAY_CAM_ROT
      L10_2 = 0
      L9_2 = L9_2(L10_2)
      L9_2 = L9_2.z
      L10_2 = true
      L11_2 = false
      L12_2 = false
      L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
      L5_2 = set_decor_flag
      L6_2 = L4_2
      L7_2 = DecorFlag_isAngryPlane
      L5_2(L6_2, L7_2)
      L5_2 = ENTITY
      L5_2 = L5_2.DOES_ENTITY_EXIST
      L6_2 = L4_2
      L5_2 = L5_2(L6_2)
      if L5_2 then
        L5_2 = NETWORK
        L5_2 = L5_2.SET_NETWORK_ID_CAN_MIGRATE
        L6_2 = NETWORK
        L6_2 = L6_2.VEH_TO_NET
        L7_2 = L4_2
        L6_2 = L6_2(L7_2)
        L7_2 = false
        L5_2(L6_2, L7_2)
        L5_2 = entities
        L5_2 = L5_2.create_ped
        L6_2 = 26
        L7_2 = L0_2
        L8_2 = L3_2
        L9_2 = 0
        L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2)
        L6_2 = PED
        L6_2 = L6_2.SET_PED_INTO_VEHICLE
        L7_2 = L5_2
        L8_2 = L4_2
        L9_2 = -1
        L6_2(L7_2, L8_2, L9_2)
        L6_2 = get_random_offset_from_entity
        L7_2 = PLAYER
        L7_2 = L7_2.PLAYER_PED_ID
        L7_2 = L7_2()
        L8_2 = 50.0
        L9_2 = 150.0
        L6_2 = L6_2(L7_2, L8_2, L9_2)
        L3_2 = L6_2
        L6_2 = L3_2.z
        L6_2 = L6_2 + 75.0
        L3_2.z = L6_2
        L6_2 = ENTITY
        L6_2 = L6_2.SET_ENTITY_COORDS
        L7_2 = L4_2
        L8_2 = L3_2.x
        L9_2 = L3_2.y
        L10_2 = L3_2.z
        L11_2 = false
        L12_2 = false
        L13_2 = false
        L14_2 = false
        L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
        L6_2 = random_float
        L7_2 = 0
        L8_2 = math
        L8_2 = L8_2.pi
        L8_2 = 2 * L8_2
        L6_2 = L6_2(L7_2, L8_2)
        L7_2 = ENTITY
        L7_2 = L7_2.SET_ENTITY_HEADING
        L8_2 = L4_2
        L9_2 = math
        L9_2 = L9_2.deg
        L10_2 = L6_2
        L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L9_2(L10_2)
        L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
        L7_2 = VEHICLE
        L7_2 = L7_2.SET_VEHICLE_FORWARD_SPEED
        L8_2 = L4_2
        L9_2 = 60.0
        L7_2(L8_2, L9_2)
        L7_2 = VEHICLE
        L7_2 = L7_2.SET_HELI_BLADES_FULL_SPEED
        L8_2 = L4_2
        L7_2(L8_2)
        L7_2 = VEHICLE
        L7_2 = L7_2.CONTROL_LANDING_GEAR
        L8_2 = L4_2
        L9_2 = 3
        L7_2(L8_2, L9_2)
        L7_2 = VEHICLE
        L7_2 = L7_2.SET_VEHICLE_FORCE_AFTERBURNER
        L8_2 = L4_2
        L9_2 = true
        L7_2(L8_2, L9_2)
        L7_2 = TASK
        L7_2 = L7_2.TASK_PLANE_MISSION
        L8_2 = L5_2
        L9_2 = L4_2
        L10_2 = 0
        L11_2 = PLAYER
        L11_2 = L11_2.PLAYER_PED_ID
        L11_2 = L11_2()
        L12_2 = 0.0
        L13_2 = 0.0
        L14_2 = 0.0
        L15_2 = 6
        L16_2 = 100.0
        L17_2 = 0.0
        L18_2 = 0.0
        L19_2 = 80.0
        L20_2 = 50.0
        L21_2 = false
        L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
        L7_2 = L70_1
        L7_2 = L7_2 + 1
        L70_1 = L7_2
        L7_2 = timer
        L7_2 = L7_2.reset
        L7_2()
      end
    end
  end
end
L71_1[L72_1] = L73_1
L71_1 = _ENV
L72_1 = "clear_Angry_plane"
function L73_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L0_2 = ipairs
  L1_2 = entities
  L1_2 = L1_2.get_all_vehicles_as_handles
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L1_2()
  L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
    L6_2 = delete_entity
    L7_2 = VEHICLE
    L7_2 = L7_2.GET_PED_IN_VEHICLE_SEAT
    L8_2 = L5_2
    L9_2 = -1
    L10_2 = false
    L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2, L9_2, L10_2)
    L6_2(L7_2, L8_2, L9_2, L10_2)
    L6_2 = delete_entity
    L7_2 = L5_2
    L6_2(L7_2)
    L6_2 = L70_1
    L6_2 = L6_2 - 1
    L70_1 = L6_2
  end
end
L71_1[L72_1] = L73_1
L71_1 = 1
L72_1 = 0
L73_1 = _ENV
L74_1 = "ped_draw_method"
function L75_1(A0_2)
  local L1_2
  L71_1 = A0_2
end
L73_1[L74_1] = L75_1
L73_1 = _ENV
L74_1 = "PedHealthBarmainLoop"
function L75_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L0_2 = L71_1
  if 4 == L0_2 then
    L0_2 = PLAYER
    L0_2 = L0_2.IS_PLAYER_FREE_AIMING
    L1_2 = PLAYER
    L1_2 = L1_2.PLAYER_ID
    L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L1_2()
    L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    if not L0_2 then
      L0_2 = 0
      L72_1 = L0_2
      return
    end
    L0_2 = memory
    L0_2 = L0_2.alloc_int
    L0_2 = L0_2()
    L1_2 = PLAYER
    L1_2 = L1_2.GET_ENTITY_PLAYER_IS_FREE_AIMING_AT
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_ID
    L2_2 = L2_2()
    L3_2 = L0_2
    L1_2 = L1_2(L2_2, L3_2)
    if L1_2 then
      L1_2 = memory
      L1_2 = L1_2.read_int
      L2_2 = L0_2
      L1_2 = L1_2(L2_2)
      L2_2 = ENTITY
      L2_2 = L2_2.IS_ENTITY_A_PED
      L3_2 = L1_2
      L2_2 = L2_2(L3_2)
      if L2_2 then
        L72_1 = L1_2
      end
    end
    L1_2 = draw_health_bar
    L2_2 = L72_1
    L3_2 = 1000.0
    L1_2(L2_2, L3_2)
  else
    L0_2 = ipairs
    L1_2 = get_peds_in_player_range
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_ID
    L2_2 = L2_2()
    L3_2 = 500.0
    L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L1_2(L2_2, L3_2)
    L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
      L6_2 = ENTITY
      L6_2 = L6_2.IS_ENTITY_ON_SCREEN
      L7_2 = L5_2
      L6_2 = L6_2(L7_2)
      if not L6_2 then
        L6_2 = ENTITY
        L6_2 = L6_2.HAS_ENTITY_CLEAR_LOS_TO_ENTITY
        L7_2 = PLAYER
        L7_2 = L7_2.PLAYER_PED_ID
        L7_2 = L7_2()
        L8_2 = L5_2
        L9_2 = TraceFlag
        L9_2 = L9_2.world
        L6_2 = L6_2(L7_2, L8_2, L9_2)
        if not L6_2 then
          goto lbl_104
        end
      end
      L6_2 = L71_1
      if 1 == L6_2 then
        L6_2 = PED
        L6_2 = L6_2.IS_PED_A_PLAYER
        L7_2 = L5_2
        L6_2 = L6_2(L7_2)
        if L6_2 then
          L6_2 = draw_health_bar
          L7_2 = L5_2
          L8_2 = 350.0
          L6_2(L7_2, L8_2)
      end
      else
        L6_2 = L71_1
        if 2 == L6_2 then
          L6_2 = PED
          L6_2 = L6_2.IS_PED_A_PLAYER
          L7_2 = L5_2
          L6_2 = L6_2(L7_2)
          if not L6_2 then
            L6_2 = draw_health_bar
            L7_2 = L5_2
            L8_2 = 350.0
            L6_2(L7_2, L8_2)
        end
        else
          L6_2 = L71_1
          if 3 == L6_2 then
            L6_2 = draw_health_bar
            L7_2 = L5_2
            L8_2 = 350.0
            L6_2(L7_2, L8_2)
          end
        end
      end
      ::lbl_104::
    end
  end
end
L73_1[L74_1] = L75_1
L73_1 = _ENV
L74_1 = "Play_guitar"
function L75_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  if A0_2 then
    L1_2 = request_anim_dict
    L2_2 = "amb@world_human_musician@guitar@male@idle_a"
    L1_2(L2_2)
    L1_2 = ENTITY
    L1_2 = L1_2.GET_ENTITY_COORDS
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = true
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = create_object
    L3_2 = util
    L3_2 = L3_2.joaat
    L4_2 = "prop_acc_guitar_01"
    L3_2 = L3_2(L4_2)
    L4_2 = L1_2.x
    L5_2 = L1_2.y
    L6_2 = L1_2.z
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
    pguitar = L2_2
    L2_2 = TASK
    L2_2 = L2_2.TASK_PLAY_ANIM
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2 = L3_2()
    L4_2 = "amb@world_human_musician@guitar@male@idle_a"
    L5_2 = "idle_b"
    L6_2 = 3
    L7_2 = 3
    L8_2 = -1
    L9_2 = 51
    L10_2 = 0
    L11_2 = false
    L12_2 = false
    L13_2 = false
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
    L2_2 = ENTITY
    L2_2 = L2_2.ATTACH_ENTITY_TO_ENTITY
    L3_2 = pguitar
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2 = L4_2()
    L5_2 = PED
    L5_2 = L5_2.GET_PED_BONE_INDEX
    L6_2 = PLAYER
    L6_2 = L6_2.PLAYER_PED_ID
    L6_2 = L6_2()
    L7_2 = 24818
    L5_2 = L5_2(L6_2, L7_2)
    L6_2 = -0.1
    L7_2 = 0.31
    L8_2 = 0.1
    L9_2 = 0.0
    L10_2 = 20.0
    L11_2 = 150.0
    L12_2 = false
    L13_2 = true
    L14_2 = false
    L15_2 = true
    L16_2 = 1
    L17_2 = true
    L18_2 = 0
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L2_2 = PED
    L2_2 = L2_2.SET_ENABLE_HANDCUFFS
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2 = L3_2()
    L4_2 = true
    L2_2(L3_2, L4_2)
  else
    L1_2 = TASK
    L1_2 = L1_2.CLEAR_PED_TASKS_IMMEDIATELY
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L2_2()
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L1_2 = PED
    L1_2 = L1_2.SET_ENABLE_HANDCUFFS
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = false
    L1_2(L2_2, L3_2)
    L1_2 = delete_entity
    L2_2 = pguitar
    L1_2(L2_2)
  end
end
L73_1[L74_1] = L75_1
L73_1 = _ENV
L74_1 = "Palm_spin_ball"
function L75_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  if A0_2 then
    L1_2 = request_anim_dict
    L2_2 = "anim@mp_player_intincarfreakoutstd@ps@"
    L1_2(L2_2)
    L1_2 = ENTITY
    L1_2 = L1_2.GET_ENTITY_COORDS
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = true
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = create_object
    L3_2 = util
    L3_2 = L3_2.joaat
    L4_2 = "prop_bowling_ball"
    L3_2 = L3_2(L4_2)
    L4_2 = L1_2.x
    L5_2 = L1_2.y
    L6_2 = L1_2.z
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
    hand_boll = L2_2
    L2_2 = TASK
    L2_2 = L2_2.TASK_PLAY_ANIM
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2 = L3_2()
    L4_2 = "anim@mp_player_intincarfreakoutstd@ps@"
    L5_2 = "idle_a_fp"
    L6_2 = 10
    L7_2 = 3
    L8_2 = -1
    L9_2 = 51
    L10_2 = 5
    L11_2 = false
    L12_2 = false
    L13_2 = false
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
    L2_2 = ENTITY
    L2_2 = L2_2.ATTACH_ENTITY_TO_ENTITY
    L3_2 = hand_boll
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2 = L4_2()
    L5_2 = PED
    L5_2 = L5_2.GET_PED_BONE_INDEX
    L6_2 = PLAYER
    L6_2 = L6_2.PLAYER_PED_ID
    L6_2 = L6_2()
    L7_2 = 24818
    L5_2 = L5_2(L6_2, L7_2)
    L6_2 = 0.3
    L7_2 = 0.53
    L8_2 = 0
    L9_2 = 0.2
    L10_2 = 70
    L11_2 = 340
    L12_2 = false
    L13_2 = true
    L14_2 = false
    L15_2 = true
    L16_2 = 1
    L17_2 = true
    L18_2 = 0
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L2_2 = PED
    L2_2 = L2_2.SET_ENABLE_HANDCUFFS
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2 = L3_2()
    L4_2 = true
    L2_2(L3_2, L4_2)
  else
    L1_2 = TASK
    L1_2 = L1_2.CLEAR_PED_TASKS_IMMEDIATELY
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L2_2()
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L1_2 = PED
    L1_2 = L1_2.SET_ENABLE_HANDCUFFS
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = false
    L1_2(L2_2, L3_2)
    L1_2 = delete_entity
    L2_2 = hand_boll
    L1_2(L2_2)
  end
end
L73_1[L74_1] = L75_1
L73_1 = _ENV
L74_1 = "seek_help"
function L75_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  if A0_2 then
    L1_2 = request_anim_dict
    L2_2 = "amb@world_human_bum_freeway@male@base"
    L1_2(L2_2)
    L1_2 = ENTITY
    L1_2 = L1_2.GET_ENTITY_COORDS
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = true
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = create_object
    L3_2 = util
    L3_2 = L3_2.joaat
    L4_2 = "prop_beggers_sign_03"
    L3_2 = L3_2(L4_2)
    L4_2 = L1_2.x
    L5_2 = L1_2.y
    L6_2 = L1_2.z
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
    beggers = L2_2
    L2_2 = TASK
    L2_2 = L2_2.TASK_PLAY_ANIM
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2 = L3_2()
    L4_2 = "amb@world_human_bum_freeway@male@base"
    L5_2 = "base"
    L6_2 = 3
    L7_2 = 3
    L8_2 = -1
    L9_2 = 51
    L10_2 = 0
    L11_2 = false
    L12_2 = false
    L13_2 = false
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
    L2_2 = ENTITY
    L2_2 = L2_2.ATTACH_ENTITY_TO_ENTITY
    L3_2 = beggers
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2 = L4_2()
    L5_2 = PED
    L5_2 = L5_2.GET_PED_BONE_INDEX
    L6_2 = PLAYER
    L6_2 = L6_2.PLAYER_PED_ID
    L6_2 = L6_2()
    L7_2 = 58868
    L5_2 = L5_2(L6_2, L7_2)
    L6_2 = 0.19
    L7_2 = 0.18
    L8_2 = 0.0
    L9_2 = 5.0
    L10_2 = 0.0
    L11_2 = 40.0
    L12_2 = false
    L13_2 = true
    L14_2 = false
    L15_2 = true
    L16_2 = 1
    L17_2 = true
    L18_2 = 0
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L2_2 = PED
    L2_2 = L2_2.SET_ENABLE_HANDCUFFS
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2 = L3_2()
    L4_2 = true
    L2_2(L3_2, L4_2)
  else
    L1_2 = TASK
    L1_2 = L1_2.CLEAR_PED_TASKS_IMMEDIATELY
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L2_2()
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L1_2 = PED
    L1_2 = L1_2.SET_ENABLE_HANDCUFFS
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = false
    L1_2(L2_2, L3_2)
    L1_2 = delete_entity
    L2_2 = beggers
    L1_2(L2_2)
  end
end
L73_1[L74_1] = L75_1
L73_1 = _ENV
L74_1 = "offer_flower"
function L75_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  if A0_2 then
    L1_2 = request_anim_dict
    L2_2 = "anim@heists@humane_labs@finale@keycards"
    L1_2(L2_2)
    L1_2 = ENTITY
    L1_2 = L1_2.GET_ENTITY_COORDS
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = true
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = create_object
    L3_2 = util
    L3_2 = L3_2.joaat
    L4_2 = "prop_single_rose"
    L3_2 = L3_2(L4_2)
    L4_2 = L1_2.x
    L5_2 = L1_2.y
    L6_2 = L1_2.z
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
    rose = L2_2
    L2_2 = TASK
    L2_2 = L2_2.TASK_PLAY_ANIM
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2 = L3_2()
    L4_2 = "anim@heists@humane_labs@finale@keycards"
    L5_2 = "ped_a_enter_loop"
    L6_2 = 3
    L7_2 = 3
    L8_2 = -1
    L9_2 = 51
    L10_2 = 0
    L11_2 = false
    L12_2 = false
    L13_2 = false
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
    L2_2 = ENTITY
    L2_2 = L2_2.ATTACH_ENTITY_TO_ENTITY
    L3_2 = rose
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2 = L4_2()
    L5_2 = PED
    L5_2 = L5_2.GET_PED_BONE_INDEX
    L6_2 = PLAYER
    L6_2 = L6_2.PLAYER_PED_ID
    L6_2 = L6_2()
    L7_2 = 18905
    L5_2 = L5_2(L6_2, L7_2)
    L6_2 = 0.13
    L7_2 = 0.15
    L8_2 = 0.0
    L9_2 = -100.0
    L10_2 = 0.0
    L11_2 = -20.0
    L12_2 = false
    L13_2 = true
    L14_2 = false
    L15_2 = true
    L16_2 = 1
    L17_2 = true
    L18_2 = 0
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L2_2 = PED
    L2_2 = L2_2.SET_ENABLE_HANDCUFFS
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2 = L3_2()
    L4_2 = true
    L2_2(L3_2, L4_2)
  else
    L1_2 = TASK
    L1_2 = L1_2.CLEAR_PED_TASKS_IMMEDIATELY
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L2_2()
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L1_2 = PED
    L1_2 = L1_2.SET_ENABLE_HANDCUFFS
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = false
    L1_2(L2_2, L3_2)
    L1_2 = delete_entity
    L2_2 = rose
    L1_2(L2_2)
  end
end
L73_1[L74_1] = L75_1
L73_1 = _ENV
L74_1 = "hold_umbrella"
function L75_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  if A0_2 then
    L1_2 = request_anim_dict
    L2_2 = "rcmnigel1d"
    L1_2(L2_2)
    L1_2 = ENTITY
    L1_2 = L1_2.GET_ENTITY_COORDS
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = true
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = create_object
    L3_2 = util
    L3_2 = L3_2.joaat
    L4_2 = "p_amb_brolly_01"
    L3_2 = L3_2(L4_2)
    L4_2 = L1_2.x
    L5_2 = L1_2.y
    L6_2 = L1_2.z
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
    myumbrella = L2_2
    L2_2 = TASK
    L2_2 = L2_2.TASK_PLAY_ANIM
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2 = L3_2()
    L4_2 = "rcmnigel1d"
    L5_2 = "base_club_shoulder"
    L6_2 = 3
    L7_2 = 3
    L8_2 = -1
    L9_2 = 51
    L10_2 = 0
    L11_2 = false
    L12_2 = false
    L13_2 = false
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
    L2_2 = ENTITY
    L2_2 = L2_2.ATTACH_ENTITY_TO_ENTITY
    L3_2 = myumbrella
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2 = L4_2()
    L5_2 = PED
    L5_2 = L5_2.GET_PED_BONE_INDEX
    L6_2 = PLAYER
    L6_2 = L6_2.PLAYER_PED_ID
    L6_2 = L6_2()
    L7_2 = 28422
    L5_2 = L5_2(L6_2, L7_2)
    L6_2 = 0.07
    L7_2 = 0.01
    L8_2 = 0.11
    L9_2 = 2.3402393
    L10_2 = -150.9605721
    L11_2 = 57.3374916
    L12_2 = false
    L13_2 = true
    L14_2 = false
    L15_2 = true
    L16_2 = 1
    L17_2 = true
    L18_2 = 0
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L2_2 = PED
    L2_2 = L2_2.SET_ENABLE_HANDCUFFS
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2 = L3_2()
    L4_2 = true
    L2_2(L3_2, L4_2)
  else
    L1_2 = TASK
    L1_2 = L1_2.CLEAR_PED_TASKS_IMMEDIATELY
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L2_2()
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L1_2 = PED
    L1_2 = L1_2.SET_ENABLE_HANDCUFFS
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = false
    L1_2(L2_2, L3_2)
    L1_2 = delete_entity
    L2_2 = myumbrella
    L1_2(L2_2)
  end
end
L73_1[L74_1] = L75_1
L73_1 = _ENV
L74_1 = "Out_body"
function L75_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  if A0_2 then
    L1_2 = PED
    L1_2 = L1_2.CLONE_PED
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = true
    L4_2 = true
    L5_2 = true
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2)
    soul_clone = L1_2
    L1_2 = ENTITY
    L1_2 = L1_2.GET_ENTITY_COORDS
    L2_2 = soul_clone
    L3_2 = false
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = ENTITY
    L2_2 = L2_2.SET_ENTITY_COORDS
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2 = L3_2()
    L4_2 = L1_2.x
    L4_2 = L4_2 - 2
    L5_2 = L1_2.y
    L6_2 = L1_2.z
    L2_2(L3_2, L4_2, L5_2, L6_2)
    L2_2 = ENTITY
    L2_2 = L2_2.SET_ENTITY_ALPHA
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2 = L3_2()
    L4_2 = 87
    L5_2 = false
    L2_2(L3_2, L4_2, L5_2)
    L2_2 = ENTITY
    L2_2 = L2_2.SET_ENTITY_INVINCIBLE
    L3_2 = soul_clone
    L4_2 = true
    L2_2(L3_2, L4_2)
    L2_2 = request_anim_dict
    L3_2 = "move_crawl"
    L2_2(L3_2)
    L2_2 = calm_ped
    L3_2 = soul_clone
    L4_2 = true
    L2_2(L3_2, L4_2)
  else
    L1_2 = ENTITY
    L1_2 = L1_2.GET_ENTITY_COORDS
    L2_2 = soul_clone
    L3_2 = false
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = ENTITY
    L2_2 = L2_2.SET_ENTITY_COORDS
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2 = L3_2()
    L4_2 = L1_2.x
    L5_2 = L1_2.y
    L6_2 = L1_2.z
    L7_2 = false
    L8_2 = false
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
    L2_2 = delete_entity
    L3_2 = soul_clone
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
L73_1[L74_1] = L75_1
L73_1 = _ENV
L74_1 = "attach_flag"
function L75_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2
  L1_2 = PED
  L1_2 = L1_2.GET_VEHICLE_PED_IS_IN
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = false
  L1_2 = L1_2(L2_2, L3_2)
  if 0 ~= L1_2 then
    L2_2 = util
    L2_2 = L2_2.joaat
    L3_2 = country_flags
    L3_2 = L3_2[A0_2]
    L2_2 = L2_2(L3_2)
    L3_2 = ENTITY
    L3_2 = L3_2.GET_ENTITY_COORDS
    L4_2 = soul_clone
    L5_2 = false
    L3_2 = L3_2(L4_2, L5_2)
    L4_2 = create_object
    L5_2 = L2_2
    L6_2 = L3_2.x
    L7_2 = L3_2.y
    L8_2 = L3_2.z
    L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
    L5_2 = get_model_size
    L6_2 = ENTITY
    L6_2 = L6_2.GET_ENTITY_MODEL
    L7_2 = L1_2
    L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L6_2(L7_2)
    L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
    L5_2 = L5_2.z
    L6_2 = ENTITY
    L6_2 = L6_2.ATTACH_ENTITY_TO_ENTITY
    L7_2 = L4_2
    L8_2 = L1_2
    L9_2 = 0
    L10_2 = 0
    L11_2 = 0
    L12_2 = L5_2
    L13_2 = 0
    L14_2 = 0
    L15_2 = 0
    L16_2 = true
    L17_2 = false
    L18_2 = false
    L19_2 = false
    L20_2 = 0
    L21_2 = true
    L22_2 = 0
    L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
  end
end
L73_1[L74_1] = L75_1
L73_1 = _ENV
L74_1 = "suijijianqi"
function L75_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = math
  L1_2 = L1_2.random
  L2_2 = 1
  L3_2 = 5
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = A0_2[L1_2]
  return L2_2
end
L73_1[L74_1] = L75_1
L73_1 = _ENV
L74_1 = "Soul_Gun"
function L75_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = get_aim_info
  L0_2 = L0_2()
  L0_2 = L0_2.ent
  L1_2 = PED
  L1_2 = L1_2.IS_PED_SHOOTING
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  if L1_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.IS_ENTITY_A_PED
    L2_2 = L0_2
    L1_2 = L1_2(L2_2)
    if L1_2 then
      L1_2 = ENTITY
      L1_2 = L1_2.GET_ENTITY_COORDS
      L2_2 = L0_2
      L3_2 = false
      L1_2 = L1_2(L2_2, L3_2)
      pos = L1_2
      L1_2 = ENTITY
      L1_2 = L1_2.SET_ENTITY_COORDS_NO_OFFSET
      L2_2 = PLAYER
      L2_2 = L2_2.PLAYER_PED_ID
      L2_2 = L2_2()
      L3_2 = pos
      L3_2 = L3_2.x
      L4_2 = pos
      L4_2 = L4_2.y
      L5_2 = pos
      L5_2 = L5_2.z
      L6_2 = false
      L7_2 = false
      L8_2 = false
      L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
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
        L3_2 = "copyoutfit "
        L4_2 = players
        L4_2 = L4_2.get_name
        L5_2 = L1_2
        L4_2 = L4_2(L5_2)
        L3_2 = L3_2 .. L4_2
        L2_2(L3_2)
      else
        L1_2 = ENTITY
        L1_2 = L1_2.GET_ENTITY_MODEL
        L2_2 = L0_2
        L1_2 = L1_2(L2_2)
        L2_2 = STREAMING
        L2_2 = L2_2.REQUEST_MODEL
        L3_2 = L1_2
        L2_2(L3_2)
        while true do
          L2_2 = STREAMING
          L2_2 = L2_2.HAS_MODEL_LOADED
          L3_2 = L1_2
          L2_2 = L2_2(L3_2)
          if L2_2 then
            break
          end
          L2_2 = util
          L2_2 = L2_2.yield
          L3_2 = 10
          L2_2(L3_2)
        end
        L2_2 = PLAYER
        L2_2 = L2_2.SET_PLAYER_MODEL
        L3_2 = PLAYER
        L3_2 = L3_2.PLAYER_ID
        L3_2 = L3_2()
        L4_2 = L1_2
        L2_2(L3_2, L4_2)
        L2_2 = STREAMING
        L2_2 = L2_2.SET_MODEL_AS_NO_LONGER_NEEDED
        L3_2 = L1_2
        L2_2(L3_2)
        L2_2 = PED
        L2_2 = L2_2.IS_PED_A_PLAYER
        L3_2 = L0_2
        L2_2 = L2_2(L3_2)
        if not L2_2 then
          L2_2 = delete_entity
          L3_2 = L0_2
          L2_2(L3_2)
        end
        L2_2 = util
        L2_2 = L2_2.yield
        L3_2 = 10
        L2_2(L3_2)
        L2_2 = menu
        L2_2 = L2_2.trigger_commands
        L3_2 = "allguns"
        L2_2(L3_2)
      end
    end
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
      L2_2 = VEHICLE
      L2_2 = L2_2.GET_VEHICLE_NUMBER_OF_PASSENGERS
      L3_2 = L0_2
      L4_2 = true
      L5_2 = false
      L2_2 = L2_2(L3_2, L4_2, L5_2)
      if L2_2 >= 1 then
        L2_2 = ENTITY
        L2_2 = L2_2.GET_ENTITY_MODEL
        L3_2 = L1_2
        L2_2 = L2_2(L3_2)
        L3_2 = PED
        L3_2 = L3_2.IS_PED_A_PLAYER
        L4_2 = L1_2
        L3_2 = L3_2(L4_2)
        if not L3_2 then
          L3_2 = delete_entity
          L4_2 = L1_2
          L3_2(L4_2)
        end
        L3_2 = STREAMING
        L3_2 = L3_2.REQUEST_MODEL
        L4_2 = L2_2
        L3_2(L4_2)
        while true do
          L3_2 = STREAMING
          L3_2 = L3_2.HAS_MODEL_LOADED
          L4_2 = L2_2
          L3_2 = L3_2(L4_2)
          if L3_2 then
            break
          end
          L3_2 = util
          L3_2 = L3_2.yield
          L4_2 = 10
          L3_2(L4_2)
        end
        L3_2 = PLAYER
        L3_2 = L3_2.SET_PLAYER_MODEL
        L4_2 = PLAYER
        L4_2 = L4_2.PLAYER_ID
        L4_2 = L4_2()
        L5_2 = L2_2
        L3_2(L4_2, L5_2)
        L3_2 = STREAMING
        L3_2 = L3_2.SET_MODEL_AS_NO_LONGER_NEEDED
        L4_2 = L2_2
        L3_2(L4_2)
        L3_2 = util
        L3_2 = L3_2.yield
        L4_2 = 10
        L3_2(L4_2)
        L3_2 = PED
        L3_2 = L3_2.SET_PED_INTO_VEHICLE
        L4_2 = PLAYER
        L4_2 = L4_2.PLAYER_PED_ID
        L4_2 = L4_2()
        L5_2 = L0_2
        L6_2 = -1
        L3_2(L4_2, L5_2, L6_2)
        L3_2 = menu
        L3_2 = L3_2.trigger_commands
        L4_2 = "allguns"
        L3_2(L4_2)
      end
    end
  end
end
L73_1[L74_1] = L75_1
L73_1 = _ENV
L74_1 = "require"
L73_1 = L73_1[L74_1]
L74_1 = "lib.daidailib.Config.blacklist"
L73_1(L74_1)
L73_1 = _ENV
L74_1 = "Black_list"
function L75_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L0_2 = 0
  L1_2 = 31
  L2_2 = 1
  for L3_2 = L0_2, L1_2, L2_2 do
    L4_2 = players
    L4_2 = L4_2.get_name
    L5_2 = L3_2
    L4_2 = L4_2(L5_2)
    Blacklist_player = L4_2
    L4_2 = 1
    L5_2 = blacklistplayers
    L5_2 = #L5_2
    L6_2 = 1
    for L7_2 = L4_2, L5_2, L6_2 do
      L8_2 = blacklistplayers
      L8_2 = L8_2[L7_2]
      L9_2 = Blacklist_player
      if L8_2 == L9_2 then
        L8_2 = Blacklist_player
        L9_2 = players
        L9_2 = L9_2.get_name
        L10_2 = players
        L10_2 = L10_2.get_host
        L10_2, L11_2 = L10_2()
        L9_2 = L9_2(L10_2, L11_2)
        if L8_2 ~= L9_2 then
          L8_2 = Blacklist_player
          L9_2 = players
          L9_2 = L9_2.get_name
          L10_2 = PLAYER
          L10_2 = L10_2.PLAYER_ID
          L10_2, L11_2 = L10_2()
          L9_2 = L9_2(L10_2, L11_2)
          if L8_2 ~= L9_2 then
            L8_2 = util
            L8_2 = L8_2.toast
            L9_2 = "检测到黑名单玩家: "
            L10_2 = Blacklist_player
            L11_2 = "\n已执行踢出"
            L9_2 = L9_2 .. L10_2 .. L11_2
            L8_2(L9_2)
            L8_2 = menu
            L8_2 = L8_2.trigger_commands
            L9_2 = "kick "
            L10_2 = Blacklist_player
            L9_2 = L9_2 .. L10_2
            L8_2(L9_2)
          end
        end
      end
    end
  end
end
L73_1[L74_1] = L75_1
L73_1 = _ENV
L74_1 = "Black_self"
function L75_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
  L0_2 = players
  L0_2 = L0_2.get_name
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2, L2_2, L3_2, L4_2, L5_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2)
  Blacklist_self = L0_2
  L0_2 = 0
  L1_2 = blacklistplayers
  L1_2 = #L1_2
  L2_2 = 1
  for L3_2 = L0_2, L1_2, L2_2 do
    L4_2 = blacklistplayers
    L4_2 = L4_2[L3_2]
    L5_2 = Blacklist_self
    if L4_2 == L5_2 then
      L4_2 = exit_game
      L4_2()
    end
  end
end
L73_1[L74_1] = L75_1
L73_1 = _ENV
L74_1 = "v3"
L73_1 = L73_1[L74_1]
L74_1 = "new"
L73_1 = L73_1[L74_1]
L73_1 = L73_1()
L74_1 = {}
L75_1 = _ENV
L76_1 = "minecraftgun"
function L77_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
  L0_2 = WEAPON
  L0_2 = L0_2.GET_PED_LAST_WEAPON_IMPACT_COORD
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = L73_1
  L0_2 = L0_2(L1_2, L2_2)
  if L0_2 then
    L0_2 = util
    L0_2 = L0_2.joaat
    L1_2 = "prop_mb_sandblock_01"
    L0_2 = L0_2(L1_2)
    L1_2 = request_model
    L2_2 = L0_2
    L1_2(L2_2)
    L1_2 = L74_1
    L1_2 = #L1_2
    L2_2 = L1_2 + 1
    L1_2 = L74_1
    L3_2 = entities
    L3_2 = L3_2.create_object
    L4_2 = L0_2
    L5_2 = L73_1
    L3_2 = L3_2(L4_2, L5_2)
    L1_2[L2_2] = L3_2
  end
end
L75_1[L76_1] = L77_1
L75_1 = _ENV
L76_1 = "playerslist"
L77_1 = {}
L75_1[L76_1] = L77_1
L75_1 = _ENV
L76_1 = "join_blacklist2"
function L77_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L1_2 = filesystem
  L1_2 = L1_2.scripts_dir
  L1_2 = L1_2()
  L2_2 = "lib/daidailib/Config/blacklist.lua"
  L1_2 = L1_2 .. L2_2
  L2_2 = players
  L2_2 = L2_2.get_name
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = io
  L3_2 = L3_2.open
  L4_2 = L1_2
  L5_2 = "r+"
  L3_2 = L3_2(L4_2, L5_2)
  L5_2 = L3_2
  L4_2 = L3_2.read
  L6_2 = "*all"
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = string
  L5_2 = L5_2.gmatch
  L6_2 = L4_2
  L7_2 = [[
([^
]+)[
]*$]]
  L5_2 = L5_2(L6_2, L7_2)
  L5_2 = L5_2()
  L6_2 = string
  L6_2 = L6_2.len
  L7_2 = L4_2
  L6_2 = L6_2(L7_2)
  L7_2 = string
  L7_2 = L7_2.len
  L8_2 = L5_2
  L7_2 = L7_2(L8_2)
  L9_2 = L3_2
  L8_2 = L3_2.close
  L8_2(L9_2)
  L8_2 = string
  L8_2 = L8_2.sub
  L9_2 = L4_2
  L10_2 = 0
  L11_2 = L6_2 - L7_2
  L11_2 = L11_2 - 1
  L8_2 = L8_2(L9_2, L10_2, L11_2)
  L9_2 = io
  L9_2 = L9_2.open
  L10_2 = L1_2
  L11_2 = "w"
  L9_2 = L9_2(L10_2, L11_2)
  L3_2 = L9_2
  L10_2 = L3_2
  L9_2 = L3_2.write
  L11_2 = L8_2
  L9_2(L10_2, L11_2)
  L10_2 = L3_2
  L9_2 = L3_2.close
  L9_2(L10_2)
  L9_2 = io
  L9_2 = L9_2.open
  L10_2 = L1_2
  L11_2 = "a"
  L9_2 = L9_2(L10_2, L11_2)
  L3_2 = L9_2
  L10_2 = L3_2
  L9_2 = L3_2.write
  L11_2 = [[
,
    "]]
  L12_2 = L2_2
  L13_2 = "\""
  L11_2 = L11_2 .. L12_2 .. L13_2
  L9_2(L10_2, L11_2)
  L10_2 = L3_2
  L9_2 = L3_2.write
  L11_2 = [[

}]]
  L9_2(L10_2, L11_2)
  L10_2 = L3_2
  L9_2 = L3_2.close
  L9_2(L10_2)
end
L75_1[L76_1] = L77_1
L75_1 = _ENV
L76_1 = "join_blacklist"
function L77_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = 0
  L2_2 = players
  L2_2 = L2_2.get_name
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = 1
  L4_2 = blacklistplayers
  L4_2 = #L4_2
  L5_2 = 1
  for L6_2 = L3_2, L4_2, L5_2 do
    L7_2 = blacklistplayers
    L7_2 = L7_2[L6_2]
    if L7_2 == L2_2 then
      L7_2 = util
      L7_2 = L7_2.toast
      L8_2 = "玩家已存在"
      L7_2(L8_2)
      L1_2 = 1
    end
  end
  if 1 ~= L1_2 and "UndiscoveredPlayer" ~= L2_2 then
    L3_2 = players
    L3_2 = L3_2.get_name
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_ID
    L4_2, L5_2, L6_2, L7_2, L8_2 = L4_2()
    L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
    if L2_2 ~= L3_2 then
      L3_2 = notification
      L4_2 = "~y~~bold~添加成功"
      L5_2 = HudColour
      L5_2 = L5_2.blue
      L3_2(L4_2, L5_2)
      L3_2 = join_blacklist2
      L4_2 = A0_2
      L3_2(L4_2)
      L3_2 = table
      L3_2 = L3_2.insert
      L4_2 = blacklistplayers
      L5_2 = players
      L5_2 = L5_2.get_name
      L6_2 = A0_2
      L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
      L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
  end
  else
    L3_2 = notification
    L4_2 = "~y~~bold~添加失败"
    L5_2 = HudColour
    L5_2 = L5_2.blue
    L3_2(L4_2, L5_2)
  end
end
L75_1[L76_1] = L77_1
L75_1 = {}
L76_1 = _ENV
L77_1 = "player_list"
function L78_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = NETWORK
  L1_2 = L1_2.NETWORK_IS_SESSION_ACTIVE
  L1_2 = L1_2()
  if L1_2 then
    L1_2 = L75_1
    L2_2 = NETWORK
    L2_2 = L2_2.NETWORK_GET_PLAYER_ACCOUNT_ID
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    L1_2[A0_2] = L2_2
    L1_2 = pairs
    L2_2 = L75_1
    L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
    for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
      L7_2 = NETWORK
      L7_2 = L7_2.NETWORK_GET_PLAYER_ACCOUNT_ID
      L8_2 = A0_2
      L7_2 = L7_2(L8_2)
      if L6_2 == L7_2 then
        L8_2 = playerslist
        L8_2 = L8_2[A0_2]
        if nil ~= L8_2 then
          L8_2 = PLAYER
          L8_2 = L8_2.GET_PLAYER_PED
          L9_2 = A0_2
          L8_2 = L8_2(L9_2)
          if 0 ~= L8_2 then
            L8_2 = menu
            L8_2 = L8_2.delete
            L9_2 = playerslist
            L9_2 = L9_2[A0_2]
            L8_2(L9_2)
            L8_2 = playerslist
            L8_2[A0_2] = nil
          end
        end
      end
    end
    L1_2 = playerslist
    L2_2 = menu
    L2_2 = L2_2.list
    L3_2 = players_list
    L4_2 = players
    L4_2 = L4_2.get_name
    L5_2 = A0_2
    L4_2 = L4_2(L5_2)
    L5_2 = {}
    L6_2 = ""
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
    L1_2[A0_2] = L2_2
  end
  L1_2 = playerslist
  L1_2 = L1_2[A0_2]
  if L1_2 then
    L1_2 = menu
    L1_2 = L1_2.divider
    L2_2 = playerslist
    L2_2 = L2_2[A0_2]
    L3_2 = "玩家信息"
    L1_2(L2_2, L3_2)
    L1_2 = menu
    L1_2 = L1_2.readonly
    L2_2 = playerslist
    L2_2 = L2_2[A0_2]
    L3_2 = "玩家昵称: "
    L4_2 = players
    L4_2 = L4_2.get_name
    L5_2 = A0_2
    L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L4_2(L5_2)
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    L1_2 = menu
    L1_2 = L1_2.readonly
    L2_2 = playerslist
    L2_2 = L2_2[A0_2]
    L3_2 = "玩家rid: "
    L4_2 = players
    L4_2 = L4_2.get_rockstar_id
    L5_2 = A0_2
    L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L4_2(L5_2)
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    L1_2 = menu
    L1_2 = L1_2.readonly
    L2_2 = playerslist
    L2_2 = L2_2[A0_2]
    L3_2 = "玩家金钱: "
    L4_2 = players
    L4_2 = L4_2.get_money
    L5_2 = A0_2
    L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L4_2(L5_2)
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    L1_2 = menu
    L1_2 = L1_2.readonly
    L2_2 = playerslist
    L2_2 = L2_2[A0_2]
    L3_2 = "玩家kd: "
    L4_2 = string
    L4_2 = L4_2.format
    L5_2 = "%.2f"
    L6_2 = players
    L6_2 = L6_2.get_kd
    L7_2 = A0_2
    L6_2, L7_2, L8_2, L9_2 = L6_2(L7_2)
    L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    L1_2 = menu
    L1_2 = L1_2.divider
    L2_2 = playerslist
    L2_2 = L2_2[A0_2]
    L3_2 = "其他选项"
    L1_2(L2_2, L3_2)
    L1_2 = menu
    L1_2 = L1_2.action
    L2_2 = playerslist
    L2_2 = L2_2[A0_2]
    L3_2 = "踢出玩家"
    L4_2 = {}
    L5_2 = ""
    function L6_2()
      local L0_3, L1_3, L2_3, L3_3
      L0_3 = menu
      L0_3 = L0_3.trigger_commands
      L1_3 = "kick "
      L2_3 = players
      L2_3 = L2_3.get_name
      L3_3 = A0_2
      L2_3 = L2_3(L3_3)
      L1_3 = L1_3 .. L2_3
      L0_3(L1_3)
    end
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
    L1_2 = 0
    L2_2 = menu
    L2_2 = L2_2.action
    L3_2 = playerslist
    L3_2 = L3_2[A0_2]
    L4_2 = "标记玩家"
    L5_2 = {}
    L6_2 = "标记或者取消标记玩家\n标记后会超时玩家"
    function L7_2()
      local L0_3, L1_3, L2_3, L3_3
      L0_3 = L1_2
      if 0 == L0_3 then
        L0_3 = menu
        L0_3 = L0_3.set_menu_name
        L1_3 = playerslist
        L2_3 = A0_2
        L1_3 = L1_3[L2_3]
        L2_3 = players
        L2_3 = L2_3.get_name
        L3_3 = A0_2
        L2_3 = L2_3(L3_3)
        L3_3 = " [标记]"
        L2_3 = L2_3 .. L3_3
        L0_3(L1_3, L2_3)
        L0_3 = menu
        L0_3 = L0_3.trigger_commands
        L1_3 = "timeout "
        L2_3 = players
        L2_3 = L2_3.get_name
        L3_3 = A0_2
        L2_3 = L2_3(L3_3)
        L3_3 = " on"
        L1_3 = L1_3 .. L2_3 .. L3_3
        L0_3(L1_3)
        L0_3 = 1
        L1_2 = L0_3
      else
        L0_3 = menu
        L0_3 = L0_3.set_menu_name
        L1_3 = playerslist
        L2_3 = A0_2
        L1_3 = L1_3[L2_3]
        L2_3 = players
        L2_3 = L2_3.get_name
        L3_3 = A0_2
        L2_3, L3_3 = L2_3(L3_3)
        L0_3(L1_3, L2_3, L3_3)
        L0_3 = menu
        L0_3 = L0_3.trigger_commands
        L1_3 = "timeout "
        L2_3 = players
        L2_3 = L2_3.get_name
        L3_3 = A0_2
        L2_3 = L2_3(L3_3)
        L3_3 = " off"
        L1_3 = L1_3 .. L2_3 .. L3_3
        L0_3(L1_3)
        L0_3 = 0
        L1_2 = L0_3
      end
    end
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
    L2_2 = menu
    L2_2 = L2_2.action
    L3_2 = playerslist
    L3_2 = L3_2[A0_2]
    L4_2 = "加入黑名单"
    L5_2 = {}
    L6_2 = ""
    function L7_2()
      local L0_3, L1_3
      L0_3 = join_blacklist
      L1_3 = A0_2
      L0_3(L1_3)
    end
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  end
end
L76_1[L77_1] = L78_1
L76_1 = _ENV
L77_1 = "handle_player_list"
function L78_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = playerslist
  L1_2 = L1_2[A0_2]
  L2_2 = players
  L2_2 = L2_2.exists
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  if not L2_2 and L1_2 then
    L2_2 = menu
    L2_2 = L2_2.delete
    L3_2 = L1_2
    L2_2(L3_2)
    L2_2 = playerslist
    L2_2[A0_2] = nil
    L2_2 = pairs
    L3_2 = L75_1
    L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
    for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
      L8_2 = NETWORK
      L8_2 = L8_2.NETWORK_GET_PLAYER_ACCOUNT_ID
      L9_2 = A0_2
      L8_2 = L8_2(L9_2)
      if L7_2 == L8_2 then
        L9_2 = L75_1
        L9_2[A0_2] = nil
      end
    end
  end
end
L76_1[L77_1] = L78_1
L76_1 = _ENV
L77_1 = "carinto"
function L78_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2
  L0_2 = PLAYER
  L0_2 = L0_2.PLAYER_PED_ID
  L0_2 = L0_2()
  L1_2 = NETWORK
  L1_2 = L1_2.NETWORK_HASH_FROM_PLAYER_HANDLE
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_ID
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
  L2_2 = PED
  L2_2 = L2_2.IS_PED_IN_ANY_VEHICLE
  L3_2 = L0_2
  L2_2 = L2_2(L3_2)
  if L2_2 then
    L2_2 = PED
    L2_2 = L2_2.GET_VEHICLE_PED_IS_IN
    L3_2 = L0_2
    L4_2 = false
    L2_2 = L2_2(L3_2, L4_2)
    L3_2 = os
    L3_2 = L3_2.time
    L3_2 = L3_2()
    L3_2 = L3_2 + 15
    if 0 ~= L2_2 then
      L4_2 = util
      L4_2 = L4_2.reverse_joaat
      L5_2 = ENTITY
      L5_2 = L5_2.GET_ENTITY_MODEL
      L6_2 = L2_2
      L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2 = L5_2(L6_2)
      L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
      if 0 ~= L1_2 then
        L5_2 = memory
        L5_2 = L5_2.write_int
        L6_2 = memory
        L6_2 = L6_2.script_global
        L7_2 = 78558
        L6_2 = L6_2(L7_2)
        L7_2 = 0
        L5_2(L6_2, L7_2)
        L5_2 = DECORATOR
        L5_2 = L5_2.DECOR_GET_INT
        L6_2 = L2_2
        L7_2 = "MPBitset"
        L5_2 = L5_2(L6_2, L7_2)
        L6_2 = ClearBit
        L7_2 = L5_2
        L8_2 = 3
        L6_2 = L6_2(L7_2, L8_2)
        L5_2 = L6_2
        L6_2 = SetBit
        L7_2 = L5_2
        L8_2 = 24
        L6_2 = L6_2(L7_2, L8_2)
        L5_2 = L6_2
        L6_2 = DECORATOR
        L6_2 = L6_2.DECOR_SET_INT
        L7_2 = L2_2
        L8_2 = "MPBitset"
        L9_2 = L5_2
        L6_2(L7_2, L8_2, L9_2)
        L6_2 = DECORATOR
        L6_2 = L6_2.DECOR_SET_INT
        L7_2 = L2_2
        L8_2 = "Previous_Owner"
        L9_2 = 0
        L6_2(L7_2, L8_2, L9_2)
        L6_2 = DECORATOR
        L6_2 = L6_2.DECOR_SET_INT
        L7_2 = L2_2
        L8_2 = "PV_Slot"
        L9_2 = 0
        L6_2(L7_2, L8_2, L9_2)
        L6_2 = DECORATOR
        L6_2 = L6_2.DECOR_SET_INT
        L7_2 = L2_2
        L8_2 = "Player_Vehicle"
        L9_2 = L1_2
        L6_2(L7_2, L8_2, L9_2)
        L6_2 = DECORATOR
        L6_2 = L6_2.DECOR_SET_INT
        L7_2 = L2_2
        L8_2 = "Veh_Modded_By_Player"
        L9_2 = L1_2
        L6_2(L7_2, L8_2, L9_2)
        L6_2 = INTERIOR
        L6_2 = L6_2.GET_INTERIOR_FROM_ENTITY
        L7_2 = L0_2
        L6_2 = L6_2(L7_2)
        L7_2 = ENTITY
        L7_2 = L7_2.GET_ENTITY_COORDS
        L8_2 = L0_2
        L9_2 = true
        L7_2 = L7_2(L8_2, L9_2)
        L8_2 = util
        L8_2 = L8_2.toast
        L9_2 = "完成"
        L8_2(L9_2)
        while 0 == L6_2 do
          L8_2 = INTERIOR
          L8_2 = L8_2.GET_INTERIOR_FROM_ENTITY
          L9_2 = L0_2
          L8_2 = L8_2(L9_2)
          L6_2 = L8_2
          L8_2 = util
          L8_2 = L8_2.yield_once
          L8_2()
        end
        L8_2 = memory
        L8_2 = L8_2.write_int
        L9_2 = memory
        L9_2 = L9_2.script_global
        L10_2 = 78558
        L9_2 = L9_2(L10_2)
        L10_2 = 1
        L8_2(L9_2, L10_2)
        while 0 ~= L6_2 do
          L8_2 = INTERIOR
          L8_2 = L8_2.GET_INTERIOR_FROM_ENTITY
          L9_2 = L0_2
          L8_2 = L8_2(L9_2)
          L6_2 = L8_2
          L8_2 = util
          L8_2 = L8_2.yield_once
          L8_2()
        end
        L8_2 = pairs
        L9_2 = entities
        L9_2 = L9_2.get_all_vehicles_as_handles
        L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2 = L9_2()
        L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
        for L12_2, L13_2 in L8_2, L9_2, L10_2, L11_2 do
          L14_2 = util
          L14_2 = L14_2.reverse_joaat
          L15_2 = ENTITY
          L15_2 = L15_2.GET_ENTITY_MODEL
          L16_2 = L13_2
          L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2 = L15_2(L16_2)
          L14_2 = L14_2(L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
          L16_2 = L14_2
          L15_2 = L14_2.find
          L17_2 = L4_2
          L15_2 = L15_2(L16_2, L17_2)
          if L15_2 then
            L15_2 = ENTITY
            L15_2 = L15_2.GET_ENTITY_COORDS
            L16_2 = L13_2
            L17_2 = true
            L15_2 = L15_2(L16_2, L17_2)
            L16_2 = MISC
            L16_2 = L16_2.GET_DISTANCE_BETWEEN_COORDS
            L17_2 = L7_2.x
            L18_2 = L7_2.y
            L19_2 = L7_2.z
            L20_2 = L15_2.x
            L21_2 = L15_2.y
            L22_2 = L15_2.z
            L23_2 = true
            L16_2 = L16_2(L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
            if L16_2 < 5.0 then
              L16_2 = delete_entity
              L17_2 = L13_2
              L16_2(L17_2)
              break
            end
          end
        end
      end
    end
  else
    L2_2 = util
    L2_2 = L2_2.toast
    L3_2 = "你还没进载具呢"
    L2_2(L3_2)
  end
end
L76_1[L77_1] = L78_1
L76_1 = _ENV
L77_1 = "util"
L76_1 = L76_1[L77_1]
L77_1 = "joaat"
L76_1 = L76_1[L77_1]
L77_1 = "sum_prop_dufocore_01a"
L76_1 = L76_1(L77_1)
L77_1 = _ENV
L78_1 = "UFO_Los_Angeles"
function L79_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_COORDS
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  L2_2 = ufonum
  L3_2 = math
  L3_2 = L3_2.random
  L4_2 = ufonum
  L4_2 = #L4_2
  L3_2 = L3_2(L4_2)
  L2_2 = L2_2[L3_2]
  L3_2 = math
  L3_2 = L3_2.random
  L4_2 = 0.0
  L5_2 = 1.0
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = 0.5
  if L3_2 >= L4_2 then
    L3_2 = L1_2.x
    L3_2 = L3_2 + L2_2
    L3_2 = L3_2 + 5
    if L3_2 then
      goto lbl_34
    end
  end
  L3_2 = L1_2.x
  L3_2 = L3_2 - L2_2
  L3_2 = L3_2 - 5
  ::lbl_34::
  L1_2.x = L3_2
  L3_2 = math
  L3_2 = L3_2.random
  L4_2 = 0.0
  L5_2 = 1.0
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = 0.5
  if L3_2 >= L4_2 then
    L3_2 = L1_2.y
    L3_2 = L3_2 + L2_2
    L3_2 = L3_2 + 5
    if L3_2 then
      goto lbl_55
    end
  end
  L3_2 = L1_2.y
  L3_2 = L3_2 - L2_2
  L3_2 = L3_2 - 5
  ::lbl_55::
  L1_2.y = L3_2
  L3_2 = L1_2.z
  L3_2 = L3_2 + L2_2
  L3_2 = L3_2 + 8
  L1_2.z = L3_2
  L3_2 = request_model
  L4_2 = L76_1
  L3_2(L4_2)
  L3_2 = util
  L3_2 = L3_2.yield
  L4_2 = 2500
  L3_2(L4_2)
  L3_2 = entities
  L3_2 = L3_2.create_object
  L4_2 = L76_1
  L5_2 = L1_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = util
  L4_2 = L4_2.yield
  L5_2 = 500
  L4_2(L5_2)
  L4_2 = ENTITY
  L4_2 = L4_2.GET_ENTITY_COORDS
  L5_2 = L3_2
  L4_2 = L4_2(L5_2)
  L5_2 = nil
  L6_2 = nil
  repeat
    L7_2 = util
    L7_2 = L7_2.get_ground_z
    L8_2 = L4_2.x
    L9_2 = L4_2.y
    L7_2, L8_2 = L7_2(L8_2, L9_2)
    L6_2 = L8_2
    L5_2 = L7_2
    L7_2 = util
    L7_2 = L7_2.yield
    L7_2()
  until L5_2
  L7_2 = FIRE
  L7_2 = L7_2.ADD_EXPLOSION
  L8_2 = L4_2.x
  L9_2 = L4_2.y
  L10_2 = L6_2
  L11_2 = exp
  L12_2 = 100.0
  L13_2 = true
  L14_2 = false
  L15_2 = 1.0
  L16_2 = false
  L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  L7_2 = util
  L7_2 = L7_2.yield
  L8_2 = 1500
  L7_2(L8_2)
  L7_2 = delete_entity
  L8_2 = L3_2
  L7_2(L8_2)
end
L77_1[L78_1] = L79_1
L77_1 = _ENV
L78_1 = "author"
L79_1 = "\n--------¦Sakura"
L77_1[L78_1] = L79_1
L77_1 = _ENV
L78_1 = "music"
function L79_1(A0_2)
  local L1_2, L2_2
  if A0_2 then
    L1_2 = AUDIO
    L1_2 = L1_2.SET_MOBILE_RADIO_ENABLED_DURING_GAMEPLAY
    L2_2 = true
    L1_2(L2_2)
    L1_2 = AUDIO
    L1_2 = L1_2.SET_RADIO_TO_STATION_NAME
    L2_2 = "RADIO_19_USER"
    L1_2(L2_2)
  else
    L1_2 = AUDIO
    L1_2 = L1_2.SET_MOBILE_RADIO_ENABLED_DURING_GAMEPLAY
    L2_2 = false
    L1_2(L2_2)
    L1_2 = AUDIO
    L1_2 = L1_2.SET_RADIO_TO_STATION_NAME
    L2_2 = "OFF"
    L1_2(L2_2)
  end
end
L77_1[L78_1] = L79_1
L77_1 = 0
L78_1 = _ENV
L79_1 = "explosion_circle"
function L80_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L3_2 = ENTITY
  L3_2 = L3_2.GET_ENTITY_COORDS
  L4_2 = A0_2
  L3_2 = L3_2(L4_2)
  L4_2 = L3_2.x
  L5_2 = L3_2.y
  L6_2 = math
  L6_2 = L6_2.cos
  L7_2 = A1_2
  L6_2 = L6_2(L7_2)
  L6_2 = A2_2 * L6_2
  L6_2 = L4_2 + L6_2
  L7_2 = math
  L7_2 = L7_2.sin
  L8_2 = A1_2
  L7_2 = L7_2(L8_2)
  L7_2 = A2_2 * L7_2
  L7_2 = L5_2 + L7_2
  L8_2 = FIRE
  L8_2 = L8_2.ADD_EXPLOSION
  L9_2 = L6_2
  L10_2 = L7_2
  L11_2 = L3_2.z
  L12_2 = 4
  L13_2 = 1
  L14_2 = true
  L15_2 = false
  L16_2 = 0
  L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
end
L78_1[L79_1] = L80_1
L78_1 = _ENV
L79_1 = "explosion_range"
function L80_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = PLAYER
  L0_2 = L0_2.GET_PLAYER_PED_SCRIPT_INDEX
  L1_2 = pid
  L0_2 = L0_2(L1_2)
  L1_2 = explosion_circle
  L2_2 = L0_2
  L3_2 = L77_1
  L4_2 = 25
  L1_2(L2_2, L3_2, L4_2)
  L1_2 = L77_1
  L1_2 = L1_2 + 0.15
  L77_1 = L1_2
  L1_2 = util
  L1_2 = L1_2.yield
  L2_2 = 50
  L1_2(L2_2)
end
L78_1[L79_1] = L80_1
L78_1 = 0
L79_1 = _ENV
L80_1 = "fps"
function L81_1(A0_2)
  local L1_2, L2_2, L3_2
  if A0_2 then
    L1_2 = menu
    L1_2 = L1_2.get_value
    L2_2 = host_sequence
    L1_2 = L1_2(L2_2)
    if true == L1_2 then
      L1_2 = 1
      L78_1 = L1_2
    else
      L1_2 = util
      L1_2 = L1_2.toast
      L2_2 = "请先开启主机序列"
      L1_2(L2_2)
      L1_2 = menu
      L1_2 = L1_2.set_value
      L2_2 = numfps
      L3_2 = false
      L1_2(L2_2, L3_2)
    end
  else
    L1_2 = 0
    L78_1 = L1_2
  end
end
L79_1[L80_1] = L81_1
L79_1 = 0
L80_1 = _ENV
L81_1 = "util"
L80_1 = L80_1[L81_1]
L81_1 = "create_thread"
L80_1 = L80_1[L81_1]
function L81_1()
  local L0_2, L1_2, L2_2
  while true do
    L0_2 = math
    L0_2 = L0_2.ceil
    L1_2 = SYSTEM
    L1_2 = L1_2.TIMESTEP
    L1_2 = L1_2()
    L2_2 = 1
    L1_2 = L2_2 / L1_2
    L0_2 = L0_2(L1_2)
    L79_1 = L0_2
    L0_2 = util
    L0_2 = L0_2.yield
    L1_2 = 500
    L0_2(L1_2)
  end
end
L80_1(L81_1)
L80_1 = _ENV
L81_1 = "memory"
L80_1 = L80_1[L81_1]
L81_1 = "read_long"
L80_1 = L80_1[L81_1]
L81_1 = _ENV
L82_1 = "memory"
L81_1 = L81_1[L82_1]
L82_1 = "rip"
L81_1 = L81_1[L82_1]
L82_1 = _ENV
L83_1 = "memory"
L82_1 = L82_1[L83_1]
L83_1 = "scan"
L82_1 = L82_1[L83_1]
L83_1 = "48 8D 0D ? ? ? ? 48 8B D7 E8 ? ? ? ? 48 8D 0D ? ? ? ? 8A D8 E8 ? ? ? ? 84 DB 75 13 48 8D 0D"
L82_1 = L82_1(L83_1)
L82_1 = L82_1 + 3
L81_1, L82_1, L83_1, L84_1, L85_1, L86_1, L87_1, L88_1, L89_1, L90_1, L91_1, L92_1, L93_1, L94_1, L95_1, L96_1, L97_1, L98_1, L99_1, L100_1, L101_1, L102_1, L103_1, L104_1, L105_1, L106_1, L107_1, L108_1, L109_1, L110_1, L111_1, L112_1, L113_1, L114_1, L115_1, L116_1, L117_1, L118_1, L119_1, L120_1, L121_1, L122_1 = L81_1(L82_1)
L80_1 = L80_1(L81_1, L82_1, L83_1, L84_1, L85_1, L86_1, L87_1, L88_1, L89_1, L90_1, L91_1, L92_1, L93_1, L94_1, L95_1, L96_1, L97_1, L98_1, L99_1, L100_1, L101_1, L102_1, L103_1, L104_1, L105_1, L106_1, L107_1, L108_1, L109_1, L110_1, L111_1, L112_1, L113_1, L114_1, L115_1, L116_1, L117_1, L118_1, L119_1, L120_1, L121_1, L122_1)
L81_1 = _ENV
L82_1 = "memory"
L81_1 = L81_1[L82_1]
L82_1 = "read_long"
L81_1 = L81_1[L82_1]
L82_1 = L80_1 + 24
L81_1 = L81_1(L82_1)
L82_1 = _ENV
L83_1 = "memory"
L82_1 = L82_1[L83_1]
L83_1 = "read_long"
L82_1 = L82_1[L83_1]
L83_1 = L80_1 + 16
L82_1 = L82_1(L83_1)
L83_1 = _ENV
L84_1 = "memory"
L83_1 = L83_1[L84_1]
L84_1 = "read_long"
L83_1 = L83_1[L84_1]
L84_1 = L80_1 + 40
L83_1 = L83_1(L84_1)
L84_1 = _ENV
L85_1 = "memory"
L84_1 = L84_1[L85_1]
L85_1 = "read_long"
L84_1 = L84_1[L85_1]
L85_1 = L80_1 + 32
L84_1 = L84_1(L85_1)
L85_1 = _ENV
L86_1 = "config_active1_x"
L85_1 = L85_1[L86_1]
L86_1 = 1000
L85_1 = L85_1 / L86_1
L86_1 = _ENV
L87_1 = "config_active1_y"
L86_1 = L86_1[L87_1]
L87_1 = 1000
L86_1 = L86_1 / L87_1
L87_1 = _ENV
L88_1 = "zhujixvlie_x"
function L89_1(A0_2)
  local L1_2
  L1_2 = A0_2 / 1000
  L85_1 = L1_2
end
L87_1[L88_1] = L89_1
L87_1 = _ENV
L88_1 = "zhujixvlie_y"
function L89_1(A0_2)
  local L1_2
  L1_2 = A0_2 / 1000
  L86_1 = L1_2
end
L87_1[L88_1] = L89_1
L87_1 = _ENV
L88_1 = "zhujixvlie"
function L89_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L0_2 = 0
  L1_2 = 31
  L2_2 = 1
  for L3_2 = L0_2, L1_2, L2_2 do
    L4_2 = players
    L4_2 = L4_2.get_host_queue_position
    L5_2 = L3_2
    L4_2 = L4_2(L5_2)
    nexthostxulie = L4_2
    L4_2 = players
    L4_2 = L4_2.list
    L4_2 = L4_2()
    L4_2 = #L4_2
    if L4_2 > 1 then
      L4_2 = nexthostxulie
      if 1 == L4_2 then
        L4_2 = players
        L4_2 = L4_2.get_name
        L5_2 = L3_2
        L4_2 = L4_2(L5_2)
        if "UndiscoveredPlayer" ~= L4_2 then
          L4_2 = players
          L4_2 = L4_2.get_name
          L5_2 = L3_2
          L4_2 = L4_2(L5_2)
          nexthost_name = L4_2
        end
      end
    else
      nexthost_name = "不可用"
    end
  end
  L0_2 = 0
  L1_2 = 0
  L2_2 = 31
  L3_2 = 1
  for L4_2 = L1_2, L2_2, L3_2 do
    L5_2 = players
    L5_2 = L5_2.exists
    L6_2 = L4_2
    L5_2 = L5_2(L6_2)
    if L5_2 then
      L5_2 = PLAYER
      L5_2 = L5_2.PLAYER_ID
      L5_2 = L5_2()
      if L4_2 ~= L5_2 then
        L5_2 = players
        L5_2 = L5_2.is_marked_as_modder
        L6_2 = L4_2
        L5_2 = L5_2(L6_2)
        if L5_2 then
          L0_2 = L0_2 + 1
        end
      end
    end
    L5_2 = PLAYER
    L5_2 = L5_2.PLAYER_PED_ID
    L5_2 = L5_2()
    L6_2 = PED
    L6_2 = L6_2.GET_VEHICLE_PED_IS_USING
    L7_2 = PLAYER
    L7_2 = L7_2.PLAYER_PED_ID
    L7_2, L8_2, L9_2, L10_2 = L7_2()
    L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2)
    L7_2 = PED
    L7_2 = L7_2.IS_PED_IN_ANY_VEHICLE
    L8_2 = L5_2
    L9_2 = true
    L7_2 = L7_2(L8_2, L9_2)
    if L7_2 then
      ente = L6_2
    else
      ente = L5_2
    end
    L7_2 = ENTITY
    L7_2 = L7_2.GET_ENTITY_SPEED
    L8_2 = ente
    L7_2 = L7_2(L8_2)
    L8_2 = L7_2 * 3.6
    L9_2 = math
    L9_2 = L9_2.ceil
    L10_2 = L8_2
    L9_2 = L9_2(L10_2)
    myspeed1e = L9_2
  end
  L1_2 = L78_1
  if 1 == L1_2 then
    L1_2 = draw_string
    L2_2 = string
    L2_2 = L2_2.format
    L3_2 = "~bold~~o~FPS: ~b~"
    L4_2 = L79_1
    L3_2 = L3_2 .. L4_2
    L2_2 = L2_2(L3_2)
    L3_2 = L85_1
    L4_2 = L86_1
    L5_2 = 0.3
    L6_2 = 1
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
  end
  L1_2 = draw_string
  L2_2 = string
  L2_2 = L2_2.format
  L3_2 = "~bold~~b~"
  L4_2 = myspeed1e
  L5_2 = " ~g~km/h"
  L3_2 = L3_2 .. L4_2 .. L5_2
  L2_2 = L2_2(L3_2)
  L3_2 = L85_1
  L4_2 = L86_1
  L4_2 = L4_2 + 0.03
  L5_2 = 0.3
  L6_2 = 1
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
  L1_2 = draw_string
  L2_2 = string
  L2_2 = L2_2.format
  L3_2 = "~bold~~y~"
  L4_2 = os
  L4_2 = L4_2.date
  L5_2 = "%X"
  L4_2 = L4_2(L5_2)
  L3_2 = L3_2 .. L4_2
  L2_2 = L2_2(L3_2)
  L3_2 = L85_1
  L4_2 = L86_1
  L4_2 = L4_2 + 0.06
  L5_2 = 0.3
  L6_2 = 1
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
  L1_2 = draw_string
  L2_2 = string
  L2_2 = L2_2.format
  L3_2 = "~bold~战局人数: ~g~"
  L4_2 = players
  L4_2 = L4_2.list
  L4_2 = L4_2()
  L4_2 = #L4_2
  L3_2 = L3_2 .. L4_2
  L2_2 = L2_2(L3_2)
  L3_2 = L85_1
  L4_2 = L86_1
  L4_2 = L4_2 + 0.09
  L5_2 = 0.3
  L6_2 = 1
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
  L1_2 = draw_string
  L2_2 = string
  L2_2 = L2_2.format
  L3_2 = "~bold~作弊人数: ~r~"
  L4_2 = L0_2
  L3_2 = L3_2 .. L4_2
  L2_2 = L2_2(L3_2)
  L3_2 = L85_1
  L4_2 = L86_1
  L4_2 = L4_2 + 0.12
  L5_2 = 0.3
  L6_2 = 1
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_NAME
  L2_2 = players
  L2_2 = L2_2.get_host
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  if "**Invalid**" == L1_2 then
    L1_2 = draw_string
    L2_2 = string
    L2_2 = L2_2.format
    L3_2 = "~bold~战局主机: ~y~不可用"
    L4_2 = ALIGN_TOP_LEFT
    L2_2 = L2_2(L3_2, L4_2)
    L3_2 = L85_1
    L4_2 = L86_1
    L4_2 = L4_2 + 0.15
    L5_2 = 0.3
    L6_2 = 1
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
  else
    L1_2 = draw_string
    L2_2 = string
    L2_2 = L2_2.format
    L3_2 = "~bold~战局主机: ~y~"
    L4_2 = players
    L4_2 = L4_2.get_name
    L5_2 = players
    L5_2 = L5_2.get_host
    L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L5_2()
    L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
    L3_2 = L3_2 .. L4_2
    L2_2 = L2_2(L3_2)
    L3_2 = L85_1
    L4_2 = L86_1
    L4_2 = L4_2 + 0.15
    L5_2 = 0.3
    L6_2 = 1
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
  end
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_NAME
  L2_2 = players
  L2_2 = L2_2.get_script_host
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  if "**Invalid**" == L1_2 then
    L1_2 = draw_string
    L2_2 = string
    L2_2 = L2_2.format
    L3_2 = "~bold~脚本主机: ~b~不可用"
    L4_2 = ALIGN_TOP_LEFT
    L2_2 = L2_2(L3_2, L4_2)
    L3_2 = L85_1
    L4_2 = L86_1
    L4_2 = L4_2 + 0.18
    L5_2 = 0.3
    L6_2 = 1
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
  else
    L1_2 = draw_string
    L2_2 = string
    L2_2 = L2_2.format
    L3_2 = "~bold~脚本主机: ~b~"
    L4_2 = players
    L4_2 = L4_2.get_name
    L5_2 = players
    L5_2 = L5_2.get_script_host
    L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L5_2()
    L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
    L3_2 = L3_2 .. L4_2
    L2_2 = L2_2(L3_2)
    L3_2 = L85_1
    L4_2 = L86_1
    L4_2 = L4_2 + 0.18
    L5_2 = 0.3
    L6_2 = 1
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
  end
  L1_2 = draw_string
  L2_2 = string
  L2_2 = L2_2.format
  L3_2 = "~bold~~g~下一位主机: ~p~"
  L4_2 = nexthost_name
  L3_2 = L3_2 .. L4_2
  L2_2 = L2_2(L3_2)
  L3_2 = L85_1
  L4_2 = L86_1
  L4_2 = L4_2 + 0.21
  L5_2 = 0.3
  L6_2 = 1
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
  L1_2 = players
  L1_2 = L1_2.get_host_queue_position
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_ID
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  if 0 == L1_2 then
    L2_2 = draw_string
    L3_2 = string
    L3_2 = L3_2.format
    L4_2 = "~bold~~o~你现在是战局主机"
    L3_2 = L3_2(L4_2)
    L4_2 = L85_1
    L5_2 = L86_1
    L5_2 = L5_2 + 0.24
    L6_2 = 0.3
    L7_2 = 1
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  else
    L2_2 = draw_string
    L3_2 = string
    L3_2 = L3_2.format
    L4_2 = "~bold~~q~你的主机优先度:~q~ "
    L5_2 = L1_2
    L4_2 = L4_2 .. L5_2
    L3_2 = L3_2(L4_2)
    L4_2 = L85_1
    L5_2 = L86_1
    L5_2 = L5_2 + 0.24
    L6_2 = 0.3
    L7_2 = 1
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
  end
end
L87_1[L88_1] = L89_1
L87_1 = _ENV
L88_1 = "entityinfo"
function L89_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  L0_2 = draw_string
  L1_2 = string
  L1_2 = L1_2.format
  L2_2 = "~h~~f~实体池Info~"
  L3_2 = memory
  L3_2 = L3_2.read_int
  L4_2 = L81_1
  L3_2 = L3_2(L4_2)
  L4_2 = "/"
  L5_2 = memory
  L5_2 = L5_2.read_int
  L6_2 = L81_1
  L5_2 = L5_2(L6_2)
  L2_2 = L2_2 .. L3_2 .. L4_2 .. L5_2
  L1_2 = L1_2(L2_2)
  L2_2 = 0
  L3_2 = 0
  L4_2 = 0.32
  L5_2 = 1
  L0_2(L1_2, L2_2, L3_2, L4_2, L5_2)
  L0_2 = draw_string
  L1_2 = string
  L1_2 = L1_2.format
  L2_2 = "~h~PED: ~g~"
  L3_2 = memory
  L3_2 = L3_2.read_int
  L4_2 = L81_1
  L4_2 = L4_2 + 272
  L3_2 = L3_2(L4_2)
  L4_2 = "/"
  L5_2 = memory
  L5_2 = L5_2.read_int
  L6_2 = L81_1
  L6_2 = L6_2 + 264
  L5_2 = L5_2(L6_2)
  L2_2 = L2_2 .. L3_2 .. L4_2 .. L5_2
  L1_2 = L1_2(L2_2)
  L2_2 = 0
  L3_2 = 0.03
  L4_2 = 0.3
  L5_2 = 1
  L0_2(L1_2, L2_2, L3_2, L4_2, L5_2)
  L0_2 = draw_string
  L1_2 = string
  L1_2 = L1_2.format
  L2_2 = "~h~载具: ~y~"
  L3_2 = memory
  L3_2 = L3_2.read_int
  L4_2 = L82_1
  L4_2 = L4_2 + 400
  L3_2 = L3_2(L4_2)
  L4_2 = "/"
  L5_2 = memory
  L5_2 = L5_2.read_int
  L6_2 = L82_1
  L6_2 = L6_2 + 392
  L5_2 = L5_2(L6_2)
  L2_2 = L2_2 .. L3_2 .. L4_2 .. L5_2
  L1_2 = L1_2(L2_2)
  L2_2 = 0
  L3_2 = 0.06
  L4_2 = 0.3
  L5_2 = 1
  L0_2(L1_2, L2_2, L3_2, L4_2, L5_2)
  L0_2 = draw_string
  L1_2 = string
  L1_2 = L1_2.format
  L2_2 = "~h~实体: ~r~"
  L3_2 = memory
  L3_2 = L3_2.read_int
  L4_2 = L83_1
  L4_2 = L4_2 + 360
  L3_2 = L3_2(L4_2)
  L4_2 = "/"
  L5_2 = memory
  L5_2 = L5_2.read_int
  L6_2 = L83_1
  L6_2 = L6_2 + 352
  L5_2 = L5_2(L6_2)
  L2_2 = L2_2 .. L3_2 .. L4_2 .. L5_2
  L1_2 = L1_2(L2_2)
  L2_2 = 0
  L3_2 = 0.09
  L4_2 = 0.3
  L5_2 = 1
  L0_2(L1_2, L2_2, L3_2, L4_2, L5_2)
  L0_2 = draw_string
  L1_2 = string
  L1_2 = L1_2.format
  L2_2 = "~h~拾取物: ~q~ "
  L3_2 = memory
  L3_2 = L3_2.read_int
  L4_2 = L84_1
  L4_2 = L4_2 + 272
  L3_2 = L3_2(L4_2)
  L4_2 = "/"
  L5_2 = memory
  L5_2 = L5_2.read_int
  L6_2 = L84_1
  L6_2 = L6_2 + 264
  L5_2 = L5_2(L6_2)
  L2_2 = L2_2 .. L3_2 .. L4_2 .. L5_2
  L1_2 = L1_2(L2_2)
  L2_2 = 0
  L3_2 = 0.12
  L4_2 = 0.3
  L5_2 = 1
  L0_2(L1_2, L2_2, L3_2, L4_2, L5_2)
end
L87_1[L88_1] = L89_1
L87_1 = _ENV
L88_1 = "scriptname"
function L89_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = MISC
  L1_2 = L1_2.GET_GAME_TIMER
  L1_2 = L1_2()
  L2_2 = gradient_colour
  L3_2 = L1_2
  L4_2 = 0.5
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = HUD
  L3_2 = L3_2.SET_TEXT_COLOUR
  L4_2 = L2_2.r
  L5_2 = L2_2.g
  L6_2 = L2_2.b
  L7_2 = 255
  L3_2(L4_2, L5_2, L6_2, L7_2)
  L3_2 = draw_string
  L4_2 = string
  L4_2 = L4_2.format
  L5_2 = "~italic~¦~bold~Sakura Script v10.2"
  L4_2 = L4_2(L5_2)
  L5_2 = 0.38
  L6_2 = 0.1
  L7_2 = 0.6
  L8_2 = 5
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2)
end
L87_1[L88_1] = L89_1
L87_1 = _ENV
L88_1 = "hammer"
function L89_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  if A0_2 then
    L1_2 = PED
    L1_2 = L1_2.SET_PED_CAN_SWITCH_WEAPON
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = false
    L1_2(L2_2, L3_2)
    L1_2 = WEAPON
    L1_2 = L1_2.GIVE_WEAPON_TO_PED
    L2_2 = PLAYER
    L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_ID
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L3_2()
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L3_2 = -1810795771
    L4_2 = 15
    L5_2 = true
    L6_2 = true
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
    L1_2 = WEAPON
    L1_2 = L1_2.SET_PED_CURRENT_WEAPON_VISIBLE
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = false
    L4_2 = false
    L5_2 = false
    L6_2 = false
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
    L1_2 = ENTITY
    L1_2 = L1_2.GET_ENTITY_COORDS
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = true
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = OBJECT
    L2_2 = L2_2.CREATE_OBJECT
    L3_2 = util
    L3_2 = L3_2.joaat
    L4_2 = "prop_bollard_02a"
    L3_2 = L3_2(L4_2)
    L4_2 = L1_2.x
    L5_2 = L1_2.y
    L6_2 = L1_2.z
    L7_2 = true
    L8_2 = true
    L9_2 = false
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    handlebar = L2_2
    L2_2 = OBJECT
    L2_2 = L2_2.CREATE_OBJECT
    L3_2 = util
    L3_2 = L3_2.joaat
    L4_2 = "prop_barrel_02a"
    L3_2 = L3_2(L4_2)
    L4_2 = L1_2.x
    L5_2 = L1_2.y
    L6_2 = L1_2.z
    L7_2 = true
    L8_2 = true
    L9_2 = false
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    dachui = L2_2
    L2_2 = menu
    L2_2 = L2_2.trigger_commands
    L3_2 = "damagemultiplier 1000"
    L2_2(L3_2)
    L2_2 = menu
    L2_2 = L2_2.trigger_commands
    L3_2 = "rangemultiplier 1.5"
    L2_2(L3_2)
    L2_2 = ENTITY
    L2_2 = L2_2.ATTACH_ENTITY_TO_ENTITY
    L3_2 = handlebar
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2 = L4_2()
    L5_2 = PED
    L5_2 = L5_2.GET_PED_BONE_INDEX
    L6_2 = PLAYER
    L6_2 = L6_2.PLAYER_PED_ID
    L6_2 = L6_2()
    L7_2 = 28422
    L5_2 = L5_2(L6_2, L7_2)
    L6_2 = 0.2
    L7_2 = 0.95
    L8_2 = 0.2
    L9_2 = 105
    L10_2 = 30.0
    L11_2 = 0
    L12_2 = true
    L13_2 = true
    L14_2 = false
    L15_2 = false
    L16_2 = 0
    L17_2 = true
    L18_2 = 0
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L2_2 = ENTITY
    L2_2 = L2_2.ATTACH_ENTITY_TO_ENTITY
    L3_2 = dachui
    L4_2 = handlebar
    L5_2 = 0
    L6_2 = 0
    L7_2 = 0
    L8_2 = -0.2
    L9_2 = -35.0
    L10_2 = 100.0
    L11_2 = 0
    L12_2 = true
    L13_2 = true
    L14_2 = false
    L15_2 = false
    L16_2 = 0
    L17_2 = true
    L18_2 = 0
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  else
    L1_2 = PED
    L1_2 = L1_2.SET_PED_CAN_SWITCH_WEAPON
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = true
    L1_2(L2_2, L3_2)
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "damagemultiplier 1"
    L1_2(L2_2)
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "rangemultiplier 1"
    L1_2(L2_2)
    L1_2 = delete_entity
    L2_2 = handlebar
    L1_2(L2_2)
    L1_2 = delete_entity
    L2_2 = dachui
    L1_2(L2_2)
    L1_2 = WEAPON
    L1_2 = L1_2.GIVE_WEAPON_TO_PED
    L2_2 = PLAYER
    L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_ID
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L3_2()
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L3_2 = -1569615261
    L4_2 = 15
    L5_2 = true
    L6_2 = true
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
  end
end
L87_1[L88_1] = L89_1
L87_1 = _ENV
L88_1 = "thunder_hammer"
function L89_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  if A0_2 then
    L1_2 = PED
    L1_2 = L1_2.SET_PED_CAN_SWITCH_WEAPON
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = false
    L1_2(L2_2, L3_2)
    L1_2 = WEAPON
    L1_2 = L1_2.GIVE_WEAPON_TO_PED
    L2_2 = PLAYER
    L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_ID
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L3_2()
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L3_2 = -1810795771
    L4_2 = 15
    L5_2 = true
    L6_2 = true
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
    L1_2 = WEAPON
    L1_2 = L1_2.SET_PED_CURRENT_WEAPON_VISIBLE
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = false
    L4_2 = false
    L5_2 = false
    L6_2 = false
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
    L1_2 = ENTITY
    L1_2 = L1_2.GET_ENTITY_COORDS
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = true
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = OBJECT
    L2_2 = L2_2.CREATE_OBJECT
    L3_2 = -1924271972
    L4_2 = L1_2.x
    L5_2 = L1_2.y
    L6_2 = L1_2.z
    L7_2 = true
    L8_2 = true
    L9_2 = false
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    thunderlebar = L2_2
    L2_2 = menu
    L2_2 = L2_2.trigger_commands
    L3_2 = "damagemultiplier 1000"
    L2_2(L3_2)
    L2_2 = menu
    L2_2 = L2_2.trigger_commands
    L3_2 = "rangemultiplier 1.5"
    L2_2(L3_2)
    L2_2 = ENTITY
    L2_2 = L2_2.ATTACH_ENTITY_TO_ENTITY
    L3_2 = thunderlebar
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2 = L4_2()
    L5_2 = PED
    L5_2 = L5_2.GET_PED_BONE_INDEX
    L6_2 = PLAYER
    L6_2 = L6_2.PLAYER_PED_ID
    L6_2 = L6_2()
    L7_2 = 28422
    L5_2 = L5_2(L6_2, L7_2)
    L6_2 = 0.08
    L7_2 = 0.22
    L8_2 = 0.05
    L9_2 = -75
    L10_2 = 45.0
    L11_2 = 0
    L12_2 = true
    L13_2 = true
    L14_2 = false
    L15_2 = false
    L16_2 = 0
    L17_2 = true
    L18_2 = 0
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  else
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "damagemultiplier 1"
    L1_2(L2_2)
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "rangemultiplier 1"
    L1_2(L2_2)
    L1_2 = delete_entity
    L2_2 = thunderlebar
    L1_2(L2_2)
    L1_2 = PED
    L1_2 = L1_2.SET_PED_CAN_SWITCH_WEAPON
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = true
    L1_2(L2_2, L3_2)
    L1_2 = WEAPON
    L1_2 = L1_2.SET_PED_CURRENT_WEAPON_VISIBLE
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = true
    L4_2 = false
    L5_2 = false
    L6_2 = false
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
    L1_2 = WEAPON
    L1_2 = L1_2.GIVE_WEAPON_TO_PED
    L2_2 = PLAYER
    L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_ID
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L3_2()
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L3_2 = -1569615261
    L4_2 = 15
    L5_2 = true
    L6_2 = true
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
  end
end
L87_1[L88_1] = L89_1
L87_1 = _ENV
L88_1 = "meteorhammer"
function L89_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  if A0_2 then
    L1_2 = PED
    L1_2 = L1_2.SET_PED_CAN_SWITCH_WEAPON
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = false
    L1_2(L2_2, L3_2)
    L1_2 = WEAPON
    L1_2 = L1_2.GIVE_WEAPON_TO_PED
    L2_2 = PLAYER
    L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_ID
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L3_2()
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L3_2 = -1810795771
    L4_2 = 15
    L5_2 = true
    L6_2 = true
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
    L1_2 = ENTITY
    L1_2 = L1_2.GET_ENTITY_COORDS
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = true
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = OBJECT
    L2_2 = L2_2.CREATE_OBJECT
    L3_2 = util
    L3_2 = L3_2.joaat
    L4_2 = "prop_glass_stack_03"
    L3_2 = L3_2(L4_2)
    L4_2 = L1_2.x
    L5_2 = L1_2.y
    L6_2 = L1_2.z
    L7_2 = true
    L8_2 = true
    L9_2 = false
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    meteorhandlebar = L2_2
    L2_2 = OBJECT
    L2_2 = L2_2.CREATE_OBJECT
    L3_2 = util
    L3_2 = L3_2.joaat
    L4_2 = "prop_barrel_pile_03"
    L3_2 = L3_2(L4_2)
    L4_2 = L1_2.x
    L5_2 = L1_2.y
    L6_2 = L1_2.z
    L7_2 = true
    L8_2 = true
    L9_2 = false
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    meteordachui = L2_2
    L2_2 = menu
    L2_2 = L2_2.trigger_commands
    L3_2 = "damagemultiplier 1000"
    L2_2(L3_2)
    L2_2 = menu
    L2_2 = L2_2.trigger_commands
    L3_2 = "rangemultiplier 1.5"
    L2_2(L3_2)
    L2_2 = ENTITY
    L2_2 = L2_2.ATTACH_ENTITY_TO_ENTITY
    L3_2 = meteorhandlebar
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2 = L4_2()
    L5_2 = PED
    L5_2 = L5_2.GET_PED_BONE_INDEX
    L6_2 = PLAYER
    L6_2 = L6_2.PLAYER_PED_ID
    L6_2 = L6_2()
    L7_2 = 28422
    L5_2 = L5_2(L6_2, L7_2)
    L6_2 = 0.2
    L7_2 = 0.95
    L8_2 = 0.2
    L9_2 = 115
    L10_2 = 30.0
    L11_2 = 0
    L12_2 = true
    L13_2 = true
    L14_2 = false
    L15_2 = false
    L16_2 = 0
    L17_2 = true
    L18_2 = 0
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L2_2 = ENTITY
    L2_2 = L2_2.ATTACH_ENTITY_TO_ENTITY
    L3_2 = meteordachui
    L4_2 = meteorhandlebar
    L5_2 = 0
    L6_2 = 0
    L7_2 = 0
    L8_2 = -0.2
    L9_2 = -35.0
    L10_2 = 100.0
    L11_2 = 0
    L12_2 = true
    L13_2 = true
    L14_2 = false
    L15_2 = false
    L16_2 = 0
    L17_2 = true
    L18_2 = 0
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  else
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "damagemultiplier 1"
    L1_2(L2_2)
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "rangemultiplier 1"
    L1_2(L2_2)
    L1_2 = delete_entity
    L2_2 = meteorhandlebar
    L1_2(L2_2)
    L1_2 = delete_entity
    L2_2 = meteordachui
    L1_2(L2_2)
    L1_2 = PED
    L1_2 = L1_2.SET_PED_CAN_SWITCH_WEAPON
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = true
    L1_2(L2_2, L3_2)
    L1_2 = WEAPON
    L1_2 = L1_2.GIVE_WEAPON_TO_PED
    L2_2 = PLAYER
    L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_ID
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L3_2()
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L3_2 = -1569615261
    L4_2 = 15
    L5_2 = true
    L6_2 = true
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
  end
end
L87_1[L88_1] = L89_1
L87_1 = _ENV
L88_1 = "atomhammer"
function L89_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  if A0_2 then
    L1_2 = PED
    L1_2 = L1_2.SET_PED_CAN_SWITCH_WEAPON
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = false
    L1_2(L2_2, L3_2)
    L1_2 = WEAPON
    L1_2 = L1_2.GIVE_WEAPON_TO_PED
    L2_2 = PLAYER
    L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_ID
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L3_2()
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L3_2 = -1810795771
    L4_2 = 15
    L5_2 = true
    L6_2 = true
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
    L1_2 = WEAPON
    L1_2 = L1_2.SET_PED_CURRENT_WEAPON_VISIBLE
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = false
    L4_2 = false
    L5_2 = false
    L6_2 = false
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
    L1_2 = ENTITY
    L1_2 = L1_2.GET_ENTITY_COORDS
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = true
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = OBJECT
    L2_2 = L2_2.CREATE_OBJECT
    L3_2 = util
    L3_2 = L3_2.joaat
    L4_2 = "prop_bollard_04"
    L3_2 = L3_2(L4_2)
    L4_2 = L1_2.x
    L5_2 = L1_2.y
    L6_2 = L1_2.z
    L7_2 = true
    L8_2 = true
    L9_2 = false
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    atomhandlebar = L2_2
    L2_2 = OBJECT
    L2_2 = L2_2.CREATE_OBJECT
    L3_2 = util
    L3_2 = L3_2.joaat
    L4_2 = "prop_barrel_03d"
    L3_2 = L3_2(L4_2)
    L4_2 = L1_2.x
    L5_2 = L1_2.y
    L6_2 = L1_2.z
    L7_2 = true
    L8_2 = true
    L9_2 = false
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    atomdachui = L2_2
    L2_2 = OBJECT
    L2_2 = L2_2.CREATE_OBJECT
    L3_2 = util
    L3_2 = L3_2.joaat
    L4_2 = "prop_barrel_03d"
    L3_2 = L3_2(L4_2)
    L4_2 = L1_2.x
    L5_2 = L1_2.y
    L6_2 = L1_2.z
    L7_2 = true
    L8_2 = true
    L9_2 = false
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    atomdachui1 = L2_2
    L2_2 = menu
    L2_2 = L2_2.trigger_commands
    L3_2 = "damagemultiplier 1000"
    L2_2(L3_2)
    L2_2 = menu
    L2_2 = L2_2.trigger_commands
    L3_2 = "rangemultiplier 1.5"
    L2_2(L3_2)
    L2_2 = ENTITY
    L2_2 = L2_2.ATTACH_ENTITY_TO_ENTITY
    L3_2 = atomhandlebar
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2 = L4_2()
    L5_2 = PED
    L5_2 = L5_2.GET_PED_BONE_INDEX
    L6_2 = PLAYER
    L6_2 = L6_2.PLAYER_PED_ID
    L6_2 = L6_2()
    L7_2 = 28422
    L5_2 = L5_2(L6_2, L7_2)
    L6_2 = 0.2
    L7_2 = 0.95
    L8_2 = 0.2
    L9_2 = 105
    L10_2 = 30.0
    L11_2 = 0
    L12_2 = true
    L13_2 = true
    L14_2 = false
    L15_2 = false
    L16_2 = 0
    L17_2 = true
    L18_2 = 0
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L2_2 = ENTITY
    L2_2 = L2_2.ATTACH_ENTITY_TO_ENTITY
    L3_2 = atomdachui
    L4_2 = atomhandlebar
    L5_2 = 0
    L6_2 = 0
    L7_2 = 0
    L8_2 = -0.2
    L9_2 = -35.0
    L10_2 = 100.0
    L11_2 = 0
    L12_2 = true
    L13_2 = true
    L14_2 = false
    L15_2 = false
    L16_2 = 0
    L17_2 = true
    L18_2 = 0
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L2_2 = ENTITY
    L2_2 = L2_2.ATTACH_ENTITY_TO_ENTITY
    L3_2 = atomdachui1
    L4_2 = atomhandlebar
    L5_2 = 0
    L6_2 = 0
    L7_2 = 0
    L8_2 = -0.201
    L9_2 = 145
    L10_2 = 100.0
    L11_2 = 0
    L12_2 = true
    L13_2 = true
    L14_2 = false
    L15_2 = false
    L16_2 = 0
    L17_2 = true
    L18_2 = 0
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  else
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "damagemultiplier 1"
    L1_2(L2_2)
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "rangemultiplier 1"
    L1_2(L2_2)
    L1_2 = delete_entity
    L2_2 = atomhandlebar
    L1_2(L2_2)
    L1_2 = delete_entity
    L2_2 = atomdachui
    L1_2(L2_2)
    L1_2 = delete_entity
    L2_2 = atomdachui1
    L1_2(L2_2)
    L1_2 = PED
    L1_2 = L1_2.SET_PED_CAN_SWITCH_WEAPON
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = true
    L1_2(L2_2, L3_2)
    L1_2 = WEAPON
    L1_2 = L1_2.SET_PED_CURRENT_WEAPON_VISIBLE
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = true
    L4_2 = false
    L5_2 = false
    L6_2 = false
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
    L1_2 = WEAPON
    L1_2 = L1_2.GIVE_WEAPON_TO_PED
    L2_2 = PLAYER
    L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_ID
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L3_2()
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L3_2 = -1569615261
    L4_2 = 15
    L5_2 = true
    L6_2 = true
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
  end
end
L87_1[L88_1] = L89_1
L87_1 = _ENV
L88_1 = "bearhammer"
function L89_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  if A0_2 then
    L1_2 = PED
    L1_2 = L1_2.SET_PED_CAN_SWITCH_WEAPON
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = false
    L1_2(L2_2, L3_2)
    L1_2 = WEAPON
    L1_2 = L1_2.GIVE_WEAPON_TO_PED
    L2_2 = PLAYER
    L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_ID
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L3_2()
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L3_2 = -1810795771
    L4_2 = 15
    L5_2 = true
    L6_2 = true
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
    L1_2 = ENTITY
    L1_2 = L1_2.GET_ENTITY_COORDS
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = true
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = OBJECT
    L2_2 = L2_2.CREATE_OBJECT
    L3_2 = util
    L3_2 = L3_2.joaat
    L4_2 = "ba_prop_battle_cameradrone"
    L3_2 = L3_2(L4_2)
    L4_2 = L1_2.x
    L5_2 = L1_2.y
    L6_2 = L1_2.z
    L7_2 = true
    L8_2 = true
    L9_2 = false
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    bearhandlebar = L2_2
    L2_2 = OBJECT
    L2_2 = L2_2.CREATE_OBJECT
    L3_2 = util
    L3_2 = L3_2.joaat
    L4_2 = "prop_mr_raspberry_01"
    L3_2 = L3_2(L4_2)
    L4_2 = L1_2.x
    L5_2 = L1_2.y
    L6_2 = L1_2.z
    L7_2 = true
    L8_2 = true
    L9_2 = false
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    beardachui = L2_2
    L2_2 = menu
    L2_2 = L2_2.trigger_commands
    L3_2 = "damagemultiplier 1000"
    L2_2(L3_2)
    L2_2 = menu
    L2_2 = L2_2.trigger_commands
    L3_2 = "rangemultiplier 1.5"
    L2_2(L3_2)
    L2_2 = ENTITY
    L2_2 = L2_2.ATTACH_ENTITY_TO_ENTITY
    L3_2 = bearhandlebar
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2 = L4_2()
    L5_2 = PED
    L5_2 = L5_2.GET_PED_BONE_INDEX
    L6_2 = PLAYER
    L6_2 = L6_2.PLAYER_PED_ID
    L6_2 = L6_2()
    L7_2 = 28422
    L5_2 = L5_2(L6_2, L7_2)
    L6_2 = 0.2
    L7_2 = 0.95
    L8_2 = 0.2
    L9_2 = 105
    L10_2 = 30.0
    L11_2 = 0
    L12_2 = true
    L13_2 = true
    L14_2 = false
    L15_2 = false
    L16_2 = 0
    L17_2 = true
    L18_2 = 0
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L2_2 = ENTITY
    L2_2 = L2_2.ATTACH_ENTITY_TO_ENTITY
    L3_2 = beardachui
    L4_2 = bearhandlebar
    L5_2 = 0
    L6_2 = 0
    L7_2 = 0
    L8_2 = 0.15
    L9_2 = 0
    L10_2 = 180
    L11_2 = 180
    L12_2 = true
    L13_2 = true
    L14_2 = false
    L15_2 = false
    L16_2 = 0
    L17_2 = true
    L18_2 = 0
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  else
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "damagemultiplier 1"
    L1_2(L2_2)
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "rangemultiplier 1"
    L1_2(L2_2)
    L1_2 = delete_entity
    L2_2 = bearhandlebar
    L1_2(L2_2)
    L1_2 = delete_entity
    L2_2 = beardachui
    L1_2(L2_2)
    L1_2 = PED
    L1_2 = L1_2.SET_PED_CAN_SWITCH_WEAPON
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = true
    L1_2(L2_2, L3_2)
    L1_2 = WEAPON
    L1_2 = L1_2.GIVE_WEAPON_TO_PED
    L2_2 = PLAYER
    L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_ID
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L3_2()
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L3_2 = -1569615261
    L4_2 = 15
    L5_2 = true
    L6_2 = true
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
  end
end
L87_1[L88_1] = L89_1
L87_1 = _ENV
L88_1 = "unicorn"
function L89_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  if A0_2 then
    L1_2 = PED
    L1_2 = L1_2.SET_PED_CAN_SWITCH_WEAPON
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = false
    L1_2(L2_2, L3_2)
    L1_2 = WEAPON
    L1_2 = L1_2.GIVE_WEAPON_TO_PED
    L2_2 = PLAYER
    L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_ID
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L3_2()
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L3_2 = -1810795771
    L4_2 = 15
    L5_2 = true
    L6_2 = true
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
    L1_2 = WEAPON
    L1_2 = L1_2.SET_PED_CURRENT_WEAPON_VISIBLE
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = false
    L4_2 = false
    L5_2 = false
    L6_2 = false
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
    L1_2 = ENTITY
    L1_2 = L1_2.GET_ENTITY_COORDS
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = true
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = OBJECT
    L2_2 = L2_2.CREATE_OBJECT
    L3_2 = util
    L3_2 = L3_2.joaat
    L4_2 = "ba_prop_battle_cameradrone"
    L3_2 = L3_2(L4_2)
    L4_2 = L1_2.x
    L5_2 = L1_2.y
    L6_2 = L1_2.z
    L7_2 = true
    L8_2 = true
    L9_2 = false
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    unicornhandlebar = L2_2
    L2_2 = ENTITY
    L2_2 = L2_2.SET_ENTITY_VISIBLE
    L3_2 = unicornhandlebar
    L4_2 = false
    L5_2 = 0
    L2_2(L3_2, L4_2, L5_2)
    L2_2 = OBJECT
    L2_2 = L2_2.CREATE_OBJECT
    L3_2 = util
    L3_2 = L3_2.joaat
    L4_2 = "ba_prop_battle_hobby_horse"
    L3_2 = L3_2(L4_2)
    L4_2 = L1_2.x
    L5_2 = L1_2.y
    L6_2 = L1_2.z
    L7_2 = true
    L8_2 = true
    L9_2 = false
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    unicorndachui = L2_2
    L2_2 = menu
    L2_2 = L2_2.trigger_commands
    L3_2 = "damagemultiplier 1000"
    L2_2(L3_2)
    L2_2 = menu
    L2_2 = L2_2.trigger_commands
    L3_2 = "rangemultiplier 1.5"
    L2_2(L3_2)
    L2_2 = ENTITY
    L2_2 = L2_2.ATTACH_ENTITY_TO_ENTITY
    L3_2 = unicornhandlebar
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2 = L4_2()
    L5_2 = PED
    L5_2 = L5_2.GET_PED_BONE_INDEX
    L6_2 = PLAYER
    L6_2 = L6_2.PLAYER_PED_ID
    L6_2 = L6_2()
    L7_2 = 28422
    L5_2 = L5_2(L6_2, L7_2)
    L6_2 = 0.165
    L7_2 = 0.9
    L8_2 = 0.205
    L9_2 = 105
    L10_2 = 30
    L11_2 = 1
    L12_2 = true
    L13_2 = true
    L14_2 = false
    L15_2 = false
    L16_2 = 0
    L17_2 = true
    L18_2 = 0
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L2_2 = ENTITY
    L2_2 = L2_2.ATTACH_ENTITY_TO_ENTITY
    L3_2 = unicorndachui
    L4_2 = unicornhandlebar
    L5_2 = 0
    L6_2 = 0
    L7_2 = 0
    L8_2 = 0.74
    L9_2 = -1.9
    L10_2 = 184
    L11_2 = 233
    L12_2 = true
    L13_2 = true
    L14_2 = false
    L15_2 = false
    L16_2 = 0
    L17_2 = true
    L18_2 = 0
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  else
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "damagemultiplier 1"
    L1_2(L2_2)
    L1_2 = menu
    L1_2 = L1_2.trigger_commands
    L2_2 = "rangemultiplier 1"
    L1_2(L2_2)
    L1_2 = delete_entity
    L2_2 = unicornhandlebar
    L1_2(L2_2)
    L1_2 = delete_entity
    L2_2 = unicorndachui
    L1_2(L2_2)
    L1_2 = PED
    L1_2 = L1_2.SET_PED_CAN_SWITCH_WEAPON
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = true
    L1_2(L2_2, L3_2)
    L1_2 = WEAPON
    L1_2 = L1_2.SET_PED_CURRENT_WEAPON_VISIBLE
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = true
    L4_2 = false
    L5_2 = false
    L6_2 = false
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
    L1_2 = WEAPON
    L1_2 = L1_2.GIVE_WEAPON_TO_PED
    L2_2 = PLAYER
    L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_ID
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L3_2()
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L3_2 = -1569615261
    L4_2 = 15
    L5_2 = true
    L6_2 = true
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
  end
end
L87_1[L88_1] = L89_1
L87_1 = _ENV
L88_1 = "knife"
function L89_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  if A0_2 then
    L1_2 = PED
    L1_2 = L1_2.SET_PED_CAN_SWITCH_WEAPON
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = false
    L1_2(L2_2, L3_2)
    L1_2 = ENTITY
    L1_2 = L1_2.GET_ENTITY_COORDS
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L2_2()
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L2_2 = OBJECT
    L2_2 = L2_2.CREATE_OBJECT
    L3_2 = util
    L3_2 = L3_2.joaat
    L4_2 = "prop_cs_katana_01"
    L3_2 = L3_2(L4_2)
    L4_2 = L1_2.x
    L5_2 = L1_2.y
    L6_2 = L1_2.z
    L7_2 = true
    L8_2 = true
    L9_2 = false
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    saber = L2_2
    L2_2 = WEAPON
    L2_2 = L2_2.GIVE_WEAPON_TO_PED
    L3_2 = PLAYER
    L3_2 = L3_2.GET_PLAYER_PED_SCRIPT_INDEX
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_ID
    L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L4_2()
    L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L4_2 = 1317494643
    L5_2 = 15
    L6_2 = true
    L7_2 = true
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
    L2_2 = WEAPON
    L2_2 = L2_2.SET_PED_CURRENT_WEAPON_VISIBLE
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2 = L3_2()
    L4_2 = not A0_2
    L5_2 = false
    L6_2 = false
    L7_2 = false
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
    L2_2 = ENTITY
    L2_2 = L2_2.ATTACH_ENTITY_TO_ENTITY
    L3_2 = saber
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2 = L4_2()
    L5_2 = PED
    L5_2 = L5_2.GET_PED_BONE_INDEX
    L6_2 = PLAYER
    L6_2 = L6_2.PLAYER_PED_ID
    L6_2 = L6_2()
    L7_2 = 28422
    L5_2 = L5_2(L6_2, L7_2)
    L6_2 = 0.07
    L7_2 = 0
    L8_2 = 0
    L9_2 = -100
    L10_2 = 0.0
    L11_2 = 0
    L12_2 = true
    L13_2 = true
    L14_2 = true
    L15_2 = true
    L16_2 = 0
    L17_2 = true
    L18_2 = 0
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
  else
    L1_2 = PED
    L1_2 = L1_2.SET_PED_CAN_SWITCH_WEAPON
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = true
    L1_2(L2_2, L3_2)
    L1_2 = delete_entity
    L2_2 = saber
    L1_2(L2_2)
    L1_2 = WEAPON
    L1_2 = L1_2.GIVE_WEAPON_TO_PED
    L2_2 = PLAYER
    L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_ID
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L3_2()
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L3_2 = -1569615261
    L4_2 = 15
    L5_2 = true
    L6_2 = true
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
  end
end
L87_1[L88_1] = L89_1
L87_1 = _ENV
L88_1 = "main_icon"
L89_1 = _ENV
L90_1 = "filesystem"
L89_1 = L89_1[L90_1]
L89_1 = L89_1.resources_dir
L89_1 = L89_1()
L90_1 = "SakuraImg\\"
L89_1 = L89_1 .. L90_1
L87_1[L88_1] = L89_1
L87_1 = _ENV
L88_1 = "main_icon"
L87_1 = L87_1[L88_1]
L88_1 = "Img\\"
L87_1 = L87_1 .. L88_1
L88_1 = _ENV
L89_1 = "dd_showpng"
function L90_1()
  local L0_2, L1_2, L2_2
  function L0_2(A0_3, A1_3)
    local L2_3, L3_3, L4_3, L5_3, L6_3, L7_3
    L2_3 = filesystem
    L2_3 = L2_3.exists
    L3_3 = L87_1
    L4_3 = A0_3
    L3_3 = L3_3 .. L4_3
    L2_3 = L2_3(L3_3)
    if L2_3 then
      L2_3 = directx
      L2_3 = L2_3.create_texture
      L3_3 = L87_1
      L4_3 = A0_3
      L3_3 = L3_3 .. L4_3
      L2_3 = L2_3(L3_3)
      L3_3 = 0
      L4_3 = 0.01
      L5_3 = os
      L5_3 = L5_3.clock
      L5_3 = L5_3()
      L6_3 = util
      L6_3 = L6_3.create_tick_handler
      function L7_3()
        local L0_4, L1_4
        L0_4 = L3_3
        L1_4 = L4_3
        L0_4 = L0_4 + L1_4
        L3_3 = L0_4
        L0_4 = L3_3
        if L0_4 > 1 then
          L0_4 = 1
          L3_3 = L0_4
        else
          L0_4 = L3_3
          if L0_4 < 0 then
            L0_4 = 0
            L3_3 = L0_4
            L0_4 = false
            return L0_4
          end
        end
      end
      L6_3(L7_3)
      L6_3 = util
      L6_3 = L6_3.create_tick_handler
      function L7_3()
        local L0_4, L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4
        L0_4 = directx
        L0_4 = L0_4.draw_texture
        L1_4 = L2_3
        L2_4 = 0.1
        L3_4 = 0.1
        L4_4 = 1.3
        L5_4 = -1.1
        L6_4 = 0.5
        L7_4 = 0.5
        L8_4 = 0
        L9_4 = 1
        L10_4 = 1
        L11_4 = 1
        L12_4 = L3_3
        L0_4(L1_4, L2_4, L3_4, L4_4, L5_4, L6_4, L7_4, L8_4, L9_4, L10_4, L11_4, L12_4)
        L0_4 = os
        L0_4 = L0_4.clock
        L0_4 = L0_4()
        L1_4 = L5_3
        L0_4 = L0_4 - L1_4
        L1_4 = A1_3
        if L0_4 > L1_4 then
          L1_4 = -0.01
          L4_3 = L1_4
        end
        L1_4 = L3_3
        if 0 == L1_4 then
          L1_4 = false
          return L1_4
        end
      end
      L6_3(L7_3)
    end
  end
  SHOW_IMG = L0_2
  L0_2 = SHOW_IMG
  L1_2 = "1.png"
  L2_2 = 4
  L0_2(L1_2, L2_2)
  L0_2 = util
  L0_2 = L0_2.yield
  L1_2 = 3000
  L0_2(L1_2)
end
L88_1[L89_1] = L90_1
L88_1 = _ENV
L89_1 = "flamemildOrangeFire"
L90_1 = _ENV
L91_1 = "new_colour"
L90_1 = L90_1[L91_1]
L91_1 = 255
L92_1 = 127
L93_1 = 80
L90_1 = L90_1(L91_1, L92_1, L93_1)
L88_1[L89_1] = L90_1
L88_1 = _ENV
L89_1 = "flameThrower"
L90_1 = {}
L91_1 = "colour"
L92_1 = _ENV
L93_1 = "flamemildOrangeFire"
L92_1 = L92_1[L93_1]
L90_1[L91_1] = L92_1
L88_1[L89_1] = L90_1
L88_1 = _ENV
L89_1 = "flamegun"
function L90_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
  L0_2 = require
  L1_2 = "lib.daidailib.JSkeyLib"
  L0_2 = L0_2(L1_2)
  L1_2 = WEAPON
  L1_2 = L1_2.GET_SELECTED_PED_WEAPON
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L2_2()
  L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
  if 1119849093 == L1_2 then
    L1_2 = L0_2.is_control_pressed
    L2_2 = 2
    L3_2 = "INPUT_AIM"
    L1_2 = L1_2(L2_2, L3_2)
    if L1_2 then
      goto lbl_36
    end
  end
  L1_2 = flameThrower
  L1_2 = L1_2.ptfx
  if not L1_2 then
    return
  end
  L1_2 = GRAPHICS
  L1_2 = L1_2.REMOVE_PARTICLE_FX
  L2_2 = flameThrower
  L2_2 = L2_2.ptfx
  L3_2 = false
  L1_2(L2_2, L3_2)
  L1_2 = STREAMING
  L1_2 = L1_2.REMOVE_NAMED_PTFX_ASSET
  L2_2 = "weap_xs_vehicle_weapons"
  L1_2(L2_2)
  L1_2 = flameThrower
  L1_2.ptfx = nil
  do return end
  ::lbl_36::
  L1_2 = PLAYER
  L1_2 = L1_2.DISABLE_PLAYER_FIRING
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = true
  L1_2(L2_2, L3_2)
  while true do
    L1_2 = STREAMING
    L1_2 = L1_2.HAS_NAMED_PTFX_ASSET_LOADED
    L2_2 = "weap_xs_vehicle_weapons"
    L1_2 = L1_2(L2_2)
    if L1_2 then
      break
    end
    L1_2 = STREAMING
    L1_2 = L1_2.REQUEST_NAMED_PTFX_ASSET
    L2_2 = "weap_xs_vehicle_weapons"
    L1_2(L2_2)
    L1_2 = util
    L1_2 = L1_2.yield
    L1_2()
  end
  L1_2 = GRAPHICS
  L1_2 = L1_2.USE_PARTICLE_FX_ASSET
  L2_2 = "weap_xs_vehicle_weapons"
  L1_2(L2_2)
  L1_2 = flameThrower
  L1_2 = L1_2.ptfx
  if nil == L1_2 then
    L1_2 = flameThrower
    L2_2 = GRAPHICS
    L3_2 = "START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE"
    L2_2 = L2_2[L3_2]
    L3_2 = "muz_xs_turret_flamethrower_looping"
    L4_2 = WEAPON
    L4_2 = L4_2.GET_CURRENT_PED_WEAPON_ENTITY_INDEX
    L5_2 = PLAYER
    L5_2 = L5_2.PLAYER_PED_ID
    L5_2 = L5_2()
    L6_2 = 0
    L4_2 = L4_2(L5_2, L6_2)
    L5_2 = 0.8
    L6_2 = 0
    L7_2 = 0
    L8_2 = 0
    L9_2 = 0
    L10_2 = 270
    L11_2 = ENTITY
    L11_2 = L11_2.GET_ENTITY_BONE_INDEX_BY_NAME
    L12_2 = WEAPON
    L12_2 = L12_2.GET_CURRENT_PED_WEAPON_ENTITY_INDEX
    L13_2 = PLAYER
    L13_2 = L13_2.PLAYER_PED_ID
    L13_2 = L13_2()
    L14_2 = 0
    L12_2 = L12_2(L13_2, L14_2)
    L13_2 = "Gun_Nuzzle"
    L11_2 = L11_2(L12_2, L13_2)
    L12_2 = 0.5
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
    L2_2 = flameThrower
    L2_2 = L2_2.ptfx
    L3_2 = flameThrower
    L3_2 = L3_2.colour
    L3_2 = L3_2.r
    L4_2 = flameThrower
    L4_2 = L4_2.colour
    L4_2 = L4_2.g
    L5_2 = flameThrower
    L5_2 = L5_2.colour
    L5_2 = L5_2.b
    L6_2 = false
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
  end
end
L88_1[L89_1] = L90_1
L88_1 = {}
L89_1 = 26612
L90_1 = 58868
L88_1[1] = L89_1
L88_1[2] = L90_1
L89_1 = _ENV
L90_1 = "Fire_Fist"
function L91_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2
  if A0_2 then
    L1_2 = ipairs
    L2_2 = L88_1
    L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
    for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
      L7_2 = request_ptfx_asset
      L8_2 = "core"
      L7_2(L8_2)
      L7_2 = GRAPHICS
      L7_2 = L7_2.USE_PARTICLE_FX_ASSET
      L8_2 = "core"
      L7_2(L8_2)
      L7_2 = GRAPHICS
      L8_2 = "START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE"
      L7_2 = L7_2[L8_2]
      L8_2 = "fire_wrecked_plane_cockpit"
      L9_2 = PLAYER
      L9_2 = L9_2.PLAYER_PED_ID
      L9_2 = L9_2()
      L10_2 = 0
      L11_2 = 0
      L12_2 = 0
      L13_2 = 0
      L14_2 = 0
      L15_2 = 0
      L16_2 = PED
      L16_2 = L16_2.GET_PED_BONE_INDEX
      L17_2 = PLAYER
      L17_2 = L17_2.PLAYER_PED_ID
      L17_2 = L17_2()
      L18_2 = L6_2
      L16_2 = L16_2(L17_2, L18_2)
      L17_2 = 0.35
      L18_2 = false
      L19_2 = false
      L20_2 = false
      L21_2 = 0
      L22_2 = 0
      L23_2 = 0
      L24_2 = 0
      L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
    end
  else
    L1_2 = GRAPHICS
    L1_2 = L1_2.REMOVE_PARTICLE_FX_FROM_ENTITY
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2 = L2_2()
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
  end
end
L89_1[L90_1] = L91_1
L89_1 = _ENV
L90_1 = "Blood_Fist"
function L91_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2
  if A0_2 then
    L1_2 = ipairs
    L2_2 = L88_1
    L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
    for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
      L7_2 = request_ptfx_asset
      L8_2 = "core"
      L7_2(L8_2)
      L7_2 = GRAPHICS
      L7_2 = L7_2.USE_PARTICLE_FX_ASSET
      L8_2 = "core"
      L7_2(L8_2)
      L7_2 = GRAPHICS
      L8_2 = "START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE"
      L7_2 = L7_2[L8_2]
      L8_2 = "scrape_blood_car"
      L9_2 = PLAYER
      L9_2 = L9_2.PLAYER_PED_ID
      L9_2 = L9_2()
      L10_2 = 0
      L11_2 = 0
      L12_2 = 0
      L13_2 = 0
      L14_2 = 0
      L15_2 = 0
      L16_2 = PED
      L16_2 = L16_2.GET_PED_BONE_INDEX
      L17_2 = PLAYER
      L17_2 = L17_2.PLAYER_PED_ID
      L17_2 = L17_2()
      L18_2 = L6_2
      L16_2 = L16_2(L17_2, L18_2)
      L17_2 = 0.35
      L18_2 = false
      L19_2 = false
      L20_2 = false
      L21_2 = 0
      L22_2 = 0
      L23_2 = 0
      L24_2 = 0
      L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
    end
  else
    L1_2 = GRAPHICS
    L1_2 = L1_2.REMOVE_PARTICLE_FX_FROM_ENTITY
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2 = L2_2()
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
  end
end
L89_1[L90_1] = L91_1
L89_1 = _ENV
L90_1 = "Raiden_Fist"
function L91_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2
  if A0_2 then
    L1_2 = ipairs
    L2_2 = L88_1
    L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
    for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
      L7_2 = request_ptfx_asset
      L8_2 = "scr_reconstructionaccident"
      L7_2(L8_2)
      L7_2 = GRAPHICS
      L7_2 = L7_2.USE_PARTICLE_FX_ASSET
      L8_2 = "scr_reconstructionaccident"
      L7_2(L8_2)
      L7_2 = GRAPHICS
      L8_2 = "START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE"
      L7_2 = L7_2[L8_2]
      L8_2 = "scr_sparking_generator"
      L9_2 = PLAYER
      L9_2 = L9_2.PLAYER_PED_ID
      L9_2 = L9_2()
      L10_2 = 0
      L11_2 = 0
      L12_2 = 0
      L13_2 = 0
      L14_2 = 0
      L15_2 = 0
      L16_2 = PED
      L16_2 = L16_2.GET_PED_BONE_INDEX
      L17_2 = PLAYER
      L17_2 = L17_2.PLAYER_PED_ID
      L17_2 = L17_2()
      L18_2 = L6_2
      L16_2 = L16_2(L17_2, L18_2)
      L17_2 = 2
      L18_2 = false
      L19_2 = false
      L20_2 = false
      L21_2 = 0
      L22_2 = 0
      L23_2 = 0
      L24_2 = 0
      L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
    end
  else
    L1_2 = GRAPHICS
    L1_2 = L1_2.REMOVE_PARTICLE_FX_FROM_ENTITY
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2 = L2_2()
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
  end
end
L89_1[L90_1] = L91_1
L89_1 = _ENV
L90_1 = "entity_limit"
function L91_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  L0_2 = 0
  L1_2 = pairs
  L2_2 = entities
  L2_2 = L2_2.get_all_peds_as_handles
  L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2 = L2_2()
  L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
    L7_2 = PLAYER
    L7_2 = L7_2.PLAYER_PED_ID
    L7_2 = L7_2()
    if L6_2 ~= L7_2 then
      L0_2 = L0_2 + 1
    end
    L7_2 = ped_limit
    if L0_2 >= L7_2 then
      L7_2 = pairs
      L8_2 = entities
      L8_2 = L8_2.get_all_peds_as_handles
      L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2 = L8_2()
      L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
      for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
        L13_2 = delete_entity
        L14_2 = L12_2
        L13_2(L14_2)
      end
      L7_2 = util
      L7_2 = L7_2.toast
      L8_2 = "Ped池达到上限,正在清理..."
      L7_2(L8_2)
    end
  end
  L1_2 = 0
  L2_2 = ipairs
  L3_2 = entities
  L3_2 = L3_2.get_all_vehicles_as_handles
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2 = L3_2()
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L1_2 = L1_2 + 1
    L8_2 = veh_limit
    if L1_2 >= L8_2 then
      L8_2 = ipairs
      L9_2 = entities
      L9_2 = L9_2.get_all_vehicles_as_handles
      L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2 = L9_2()
      L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
      for L12_2, L13_2 in L8_2, L9_2, L10_2, L11_2 do
        L14_2 = delete_entity
        L15_2 = L13_2
        L14_2(L15_2)
      end
      L8_2 = util
      L8_2 = L8_2.toast
      L9_2 = "载具池达到上限,正在清理..."
      L8_2(L9_2)
    end
  end
  L2_2 = 0
  L3_2 = pairs
  L4_2 = entities
  L4_2 = L4_2.get_all_objects_as_handles
  L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2 = L4_2()
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L2_2 = L2_2 + 1
    L9_2 = obj_limit
    if L2_2 >= L9_2 then
      L9_2 = pairs
      L10_2 = entities
      L10_2 = L10_2.get_all_objects_as_handles
      L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2 = L10_2()
      L9_2, L10_2, L11_2, L12_2 = L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
      for L13_2, L14_2 in L9_2, L10_2, L11_2, L12_2 do
        L15_2 = delete_entity
        L16_2 = L14_2
        L15_2(L16_2)
      end
      L9_2 = util
      L9_2 = L9_2.toast
      L10_2 = "物体池达到上限,正在清理..."
      L9_2(L10_2)
    end
  end
end
L89_1[L90_1] = L91_1
L89_1 = _ENV
L90_1 = "get_offset_from_gameplay_camera"
function L91_1(A0_2)
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
L89_1[L90_1] = L91_1
L89_1 = _ENV
L90_1 = "shootent"
L91_1 = -422877666
L89_1[L90_1] = L91_1
L89_1 = _ENV
L90_1 = "eentity_gun"
function L91_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2
  L0_2 = PED
  L0_2 = L0_2.IS_PED_SHOOTING
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
  if L0_2 then
    L0_2 = shootent
    L1_2 = request_model
    L2_2 = L0_2
    L1_2(L2_2)
    L1_2 = ENTITY
    L1_2 = L1_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = 0.0
    L4_2 = 5.0
    L5_2 = 0.0
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2)
    L2_2 = raycast_gameplay_cam
    L3_2 = -1
    L4_2 = 1000.0
    L2_2 = L2_2(L3_2, L4_2)
    L3_2 = {}
    L4_2 = {}
    L5_2 = L2_2[1]
    if 0 ~= L5_2 then
      L4_2 = L2_2[2]
      L5_2 = L4_2.x
      L6_2 = L1_2.x
      L5_2 = L5_2 - L6_2
      L5_2 = L5_2 * 1000
      L3_2.x = L5_2
      L5_2 = L4_2.y
      L6_2 = L1_2.y
      L5_2 = L5_2 - L6_2
      L5_2 = L5_2 * 1000
      L3_2.y = L5_2
      L5_2 = L4_2.z
      L6_2 = L1_2.z
      L5_2 = L5_2 - L6_2
      L5_2 = L5_2 * 1000
      L3_2.z = L5_2
    else
      L5_2 = get_offset_from_gameplay_camera
      L6_2 = 1000
      L5_2 = L5_2(L6_2)
      L4_2 = L5_2
      L5_2 = L4_2.x
      L6_2 = L1_2.x
      L5_2 = L5_2 - L6_2
      L5_2 = L5_2 * 1000
      L3_2.x = L5_2
      L5_2 = L4_2.y
      L6_2 = L1_2.y
      L5_2 = L5_2 - L6_2
      L5_2 = L5_2 * 1000
      L3_2.y = L5_2
      L5_2 = L4_2.z
      L6_2 = L1_2.z
      L5_2 = L5_2 - L6_2
      L5_2 = L5_2 * 1000
      L3_2.z = L5_2
    end
    L5_2 = OBJECT
    L5_2 = L5_2.CREATE_OBJECT_NO_OFFSET
    L6_2 = L0_2
    L7_2 = L1_2.x
    L8_2 = L1_2.y
    L9_2 = L1_2.z
    L10_2 = true
    L11_2 = false
    L12_2 = false
    L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
    L6_2 = ENTITY
    L6_2 = L6_2.SET_ENTITY_NO_COLLISION_ENTITY
    L7_2 = L5_2
    L8_2 = PLAYER
    L8_2 = L8_2.PLAYER_PED_ID
    L8_2 = L8_2()
    L9_2 = false
    L6_2(L7_2, L8_2, L9_2)
    L6_2 = ENTITY
    L6_2 = L6_2.APPLY_FORCE_TO_ENTITY
    L7_2 = L5_2
    L8_2 = 0
    L9_2 = L3_2.x
    L10_2 = L3_2.y
    L11_2 = L3_2.z
    L12_2 = 0.0
    L13_2 = 0.0
    L14_2 = 0.0
    L15_2 = 0
    L16_2 = true
    L17_2 = false
    L18_2 = true
    L19_2 = false
    L20_2 = true
    L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
  end
end
L89_1[L90_1] = L91_1
L89_1 = _ENV
L90_1 = "car_crash"
function L91_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = entities
  L1_2 = L1_2.get_user_vehicle_as_handle
  L1_2 = L1_2()
  veh = L1_2
  if A0_2 then
    L1_2 = VEHICLE1
    L1_2 = L1_2._SET_VEHICLE_CONTROLS_INVERTED
    L2_2 = veh
    L3_2 = true
    L1_2(L2_2, L3_2)
  else
    L1_2 = VEHICLE1
    L1_2 = L1_2._SET_VEHICLE_CONTROLS_INVERTED
    L2_2 = veh
    L3_2 = false
    L1_2(L2_2, L3_2)
  end
end
L89_1[L90_1] = L91_1
L89_1 = 2000
L90_1 = 2000
L91_1 = _ENV
L92_1 = "nnitrogen_acceleration"
function L93_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = entities
  L0_2 = L0_2.get_user_vehicle_as_handle
  L0_2 = L0_2()
  L1_2 = PED
  L1_2 = L1_2.IS_PED_IN_ANY_VEHICLE
  L2_2 = PLAYER
  L2_2 = L2_2.PLAYER_PED_ID
  L2_2 = L2_2()
  L3_2 = true
  L1_2 = L1_2(L2_2, L3_2)
  if L1_2 and 0 ~= L0_2 then
    L1_2 = PAD
    L1_2 = L1_2.IS_CONTROL_JUST_PRESSED
    L2_2 = 357
    L3_2 = 357
    L1_2 = L1_2(L2_2, L3_2)
    if L1_2 then
      L1_2 = request_ptfx_asset
      L2_2 = "veh_xs_vehicle_mods"
      L1_2(L2_2)
      L1_2 = GRAPHICS
      L1_2 = L1_2.USE_PARTICLE_FX_ASSET
      L2_2 = "veh_xs_vehicle_mods"
      L1_2(L2_2)
      L1_2 = VEHICLE1
      L1_2 = L1_2.SET_OVERRIDE_NITROUS_LEVEL
      L2_2 = L0_2
      L3_2 = true
      L4_2 = 100
      L5_2 = L90_1
      L6_2 = 99999999999
      L7_2 = false
      L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
      L1_2 = ENTITY
      L1_2 = L1_2.SET_ENTITY_MAX_SPEED
      L2_2 = L0_2
      L3_2 = 2000
      L1_2(L2_2, L3_2)
      L1_2 = VEHICLE1
      L1_2 = L1_2.SET_VEHICLE_MAX_SPEED
      L2_2 = L0_2
      L3_2 = 2000
      L1_2(L2_2, L3_2)
      L1_2 = util
      L1_2 = L1_2.yield
      L2_2 = L89_1
      L1_2(L2_2)
      L1_2 = VEHICLE1
      L1_2 = L1_2.SET_OVERRIDE_NITROUS_LEVEL
      L2_2 = L0_2
      L3_2 = false
      L4_2 = 0
      L5_2 = 0
      L6_2 = 0
      L7_2 = false
      L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
      L1_2 = VEHICLE1
      L1_2 = L1_2.SET_VEHICLE_MAX_SPEED
      L2_2 = L0_2
      L3_2 = 0.0
      L1_2(L2_2, L3_2)
    end
  end
end
L91_1[L92_1] = L93_1
L91_1 = _ENV
L92_1 = "nnitro_duration"
function L93_1(A0_2)
  local L1_2
  L1_2 = A0_2 * 1000
  L89_1 = L1_2
end
L91_1[L92_1] = L93_1
L91_1 = _ENV
L92_1 = "nnitro_power"
function L93_1(A0_2)
  local L1_2
  L90_1 = A0_2
end
L91_1[L92_1] = L93_1
L91_1 = _ENV
L92_1 = "initial_d_mode"
L93_1 = false
L91_1[L92_1] = L93_1
L91_1 = _ENV
L92_1 = "initial_d_score"
L93_1 = false
L91_1[L92_1] = L93_1
L91_1 = _ENV
L92_1 = "on_user_change_vehicle"
function L93_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  if 0 ~= A0_2 then
    L1_2 = initial_d_mode
    if L1_2 then
      L1_2 = set_vehicle_into_drift_mode
      L2_2 = A0_2
      L1_2(L2_2)
    end
    L1_2 = {}
    L2_2 = VEHICLE
    L2_2 = L2_2.GET_VEHICLE_MODEL_NUMBER_OF_SEATS
    L3_2 = ENTITY
    L3_2 = L3_2.GET_ENTITY_MODEL
    L4_2 = A0_2
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L3_2(L4_2)
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
    L3_2 = 1
    L4_2 = L2_2
    L5_2 = 1
    for L6_2 = L3_2, L4_2, L5_2 do
      if L2_2 >= 2 then
        L7_2 = #L1_2
        L7_2 = L7_2 + 1
        L8_2 = tostring
        L9_2 = L6_2 - 2
        L8_2 = L8_2(L9_2)
        L1_2[L7_2] = L8_2
      else
        L7_2 = #L1_2
        L7_2 = L7_2 + 1
        L8_2 = tostring
        L9_2 = L6_2
        L8_2 = L8_2(L9_2)
        L1_2[L7_2] = L8_2
      end
    end
    L3_2 = native_invoker
    L3_2 = L3_2.begin_call
    L3_2()
    L3_2 = native_invoker
    L3_2 = L3_2.push_arg_int
    L4_2 = A0_2
    L3_2(L4_2)
    L3_2 = native_invoker
    L3_2 = L3_2.end_call
    L4_2 = "76D26A22750E849E"
    L3_2(L4_2)
  end
end
L91_1[L92_1] = L93_1
L91_1 = _ENV
L92_1 = "update_attachment_position"
function L93_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L1_2 = A0_2.offset
  if nil == L1_2 then
    L1_2 = {}
    L1_2.x = 0
    L1_2.y = 0
    L1_2.z = 0
    A0_2.offset = L1_2
  end
  L1_2 = A0_2.rotation
  if nil == L1_2 then
    L1_2 = {}
    L1_2.x = 0
    L1_2.y = 0
    L1_2.z = 0
    A0_2.rotation = L1_2
  end
  L1_2 = A0_2.collision
  if nil == L1_2 then
    A0_2.collision = true
  end
  L1_2 = ENTITY
  L1_2 = L1_2.ATTACH_ENTITY_TO_ENTITY
  L2_2 = A0_2.handle
  L3_2 = A0_2.root
  L4_2 = A0_2.bone_index
  if not L4_2 then
    L4_2 = 0
  end
  L5_2 = A0_2.offset
  L5_2 = L5_2.x
  if not L5_2 then
    L5_2 = 0
  end
  L6_2 = A0_2.offset
  L6_2 = L6_2.y
  if not L6_2 then
    L6_2 = 0
  end
  L7_2 = A0_2.offset
  L7_2 = L7_2.z
  if not L7_2 then
    L7_2 = 0
  end
  L8_2 = A0_2.rotation
  L8_2 = L8_2.x
  if not L8_2 then
    L8_2 = 0
  end
  L9_2 = A0_2.rotation
  L9_2 = L9_2.y
  if not L9_2 then
    L9_2 = 0
  end
  L10_2 = A0_2.rotation
  L10_2 = L10_2.z
  if not L10_2 then
    L10_2 = 0
  end
  L11_2 = false
  L12_2 = true
  L13_2 = A0_2.collision
  L14_2 = false
  L15_2 = 2
  L16_2 = true
  L17_2 = 0
  L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
end
L91_1[L92_1] = L93_1
L91_1 = _ENV
L92_1 = "get_vehicle_dimension"
function L93_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L1_2 = memory
  L1_2 = L1_2.alloc
  L1_2 = L1_2()
  L2_2 = memory
  L2_2 = L2_2.alloc
  L2_2 = L2_2()
  L3_2 = MISC
  L3_2 = L3_2.GET_MODEL_DIMENSIONS
  L4_2 = ENTITY
  L4_2 = L4_2.GET_ENTITY_MODEL
  L5_2 = A0_2
  L4_2 = L4_2(L5_2)
  L5_2 = L1_2
  L6_2 = L2_2
  L3_2(L4_2, L5_2, L6_2)
  L3_2 = v3
  L3_2 = L3_2.new
  L4_2 = L1_2
  L3_2 = L3_2(L4_2)
  L4_2 = v3
  L4_2 = L4_2.new
  L5_2 = L2_2
  L4_2 = L4_2(L5_2)
  L5_2 = {}
  L6_2 = L4_2.y
  L7_2 = L3_2.y
  L6_2 = L6_2 - L7_2
  L5_2.x = L6_2
  L6_2 = L4_2.x
  L7_2 = L3_2.x
  L6_2 = L6_2 - L7_2
  L5_2.y = L6_2
  L6_2 = L4_2.z
  L7_2 = L3_2.z
  L6_2 = L6_2 - L7_2
  L5_2.z = L6_2
  return L5_2
end
L91_1[L92_1] = L93_1
L91_1 = _ENV
L92_1 = "set_attachment_offset_for_root"
function L93_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = util
  L1_2 = L1_2.reverse_joaat
  L2_2 = ENTITY
  L2_2 = L2_2.GET_ENTITY_MODEL
  L3_2 = A0_2.root
  L2_2, L3_2, L4_2 = L2_2(L3_2)
  L1_2 = L1_2(L2_2, L3_2, L4_2)
  L2_2 = get_vehicle_dimension
  L3_2 = A0_2.handle
  L2_2 = L2_2(L3_2)
  if "wastelander" == L1_2 then
    L3_2 = {}
    L3_2.x = 0
    L4_2 = L2_2.y
    L4_2 = L4_2 / 2
    L4_2 = L4_2 - 2
    L3_2.y = L4_2
    L4_2 = L2_2.z
    L4_2 = L4_2 / 2
    L4_2 = L4_2 + 0.8
    L3_2.z = L4_2
    A0_2.offset = L3_2
  end
  if "slamtruck" == L1_2 then
    L3_2 = {}
    L3_2.x = 0
    L4_2 = L2_2.y
    L4_2 = L4_2 / 2
    L4_2 = L4_2 - 3
    L3_2.y = L4_2
    L4_2 = L2_2.z
    L4_2 = L4_2 / 2
    L4_2 = L4_2 + 0.3
    L3_2.z = L4_2
    A0_2.offset = L3_2
    L3_2 = {}
    L3_2.x = 8
    L3_2.y = 0
    L3_2.z = 0
    A0_2.rotation = L3_2
  end
end
L91_1[L92_1] = L93_1
L91_1 = _ENV
L92_1 = "attach"
function L93_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_COORDS
  L2_2 = A0_2.root
  L1_2 = L1_2(L2_2)
  A0_2.position = L1_2
  L1_2 = ENTITY
  L1_2 = L1_2.SET_ENTITY_HAS_GRAVITY
  L2_2 = A0_2.handle
  L3_2 = false
  L1_2(L2_2, L3_2)
  L1_2 = set_attachment_offset_for_root
  L2_2 = A0_2
  L1_2(L2_2)
  L1_2 = update_attachment_position
  L2_2 = A0_2
  L1_2(L2_2)
  L1_2 = ENTITY
  L1_2 = L1_2.SET_ENTITY_NO_COLLISION_ENTITY
  L2_2 = A0_2.root
  L3_2 = A0_2.handle
  L1_2(L2_2, L3_2)
  return A0_2
end
L91_1[L92_1] = L93_1
L91_1 = _ENV
L92_1 = "statecar"
L93_1 = {}
L91_1[L92_1] = L93_1
L91_1 = _ENV
L92_1 = "detach_attached_vehicle"
function L93_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = statecar
  L0_2 = L0_2.attached_vehicle
  if nil ~= L0_2 then
    L0_2 = util
    L0_2 = L0_2.toast
    L1_2 = "已分离 "
    L2_2 = statecar
    L2_2 = L2_2.attached_vehicle
    L2_2 = L2_2.name
    L1_2 = L1_2 .. L2_2
    L0_2(L1_2)
    L0_2 = ENTITY
    L0_2 = L0_2.DETACH_ENTITY
    L1_2 = statecar
    L1_2 = L1_2.attached_vehicle
    L1_2 = L1_2.handle
    L2_2 = true
    L3_2 = true
    L0_2(L1_2, L2_2, L3_2)
    L0_2 = statecar
    L0_2.attached_vehicle = nil
  end
end
L91_1[L92_1] = L93_1
L91_1 = _ENV
L92_1 = "attach_nearest_vehicle"
function L93_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
  L0_2 = entities
  L0_2 = L0_2.get_user_vehicle_as_handle
  L0_2 = L0_2()
  if not L0_2 then
    L1_2 = util
    L1_2 = L1_2.toast
    L2_2 = "您必须在车辆中才能附加"
    L1_2(L2_2)
    return
  end
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_COORDS
  L2_2 = L0_2
  L3_2 = 1
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = 20
  L3_2 = entities
  L3_2 = L3_2.get_all_vehicles_as_handles
  L3_2 = L3_2()
  L4_2 = 0
  L5_2 = ipairs
  L6_2 = L3_2
  L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
  for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
    if L10_2 ~= L0_2 then
      L11_2 = {}
      L11_2.handle = L10_2
      L11_2.root = L0_2
      L12_2 = ENTITY
      L12_2 = L12_2.GET_ENTITY_COORDS
      L13_2 = L11_2.handle
      L14_2 = 1
      L12_2 = L12_2(L13_2, L14_2)
      L11_2.position = L12_2
      L12_2 = SYSTEM
      L12_2 = L12_2.VDIST
      L13_2 = L1_2.x
      L14_2 = L1_2.y
      L15_2 = L1_2.z
      L16_2 = L11_2.position
      L16_2 = L16_2.x
      L17_2 = L11_2.position
      L17_2 = L17_2.y
      L18_2 = L11_2.position
      L18_2 = L18_2.z
      L12_2 = L12_2(L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
      L11_2.distance = L12_2
      L12_2 = L11_2.distance
      if L2_2 >= L12_2 then
        L12_2 = detach_attached_vehicle
        L12_2()
        L12_2 = VEHICLE
        L12_2 = L12_2.GET_DISPLAY_NAME_FROM_VEHICLE_MODEL
        L13_2 = ENTITY
        L13_2 = L13_2.GET_ENTITY_MODEL
        L14_2 = L11_2.handle
        L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L13_2(L14_2)
        L12_2 = L12_2(L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
        L11_2.name = L12_2
        L12_2 = util
        L12_2 = L12_2.toast
        L13_2 = "已附加 "
        L14_2 = L11_2.name
        L13_2 = L13_2 .. L14_2
        L12_2(L13_2)
        L12_2 = attach
        L13_2 = L11_2
        L12_2(L13_2)
        L12_2 = statecar
        L12_2.attached_vehicle = L11_2
        return
      end
    end
  end
end
L91_1[L92_1] = L93_1
L91_1 = _ENV
L92_1 = "fumes"
function L93_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L1_2 = menu
  L1_2 = L1_2.ref_by_rel_path
  L2_2 = menu
  L2_2 = L2_2.player_root
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = "Trolling>Freeze"
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = players
  L2_2 = L2_2.get_position
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = menu
  L3_2 = L3_2.set_value
  L4_2 = L1_2
  L5_2 = true
  L3_2(L4_2, L5_2)
  L3_2 = request_ptfx_asset
  L4_2 = "core"
  L3_2(L4_2)
  L3_2 = GRAPHICS
  L3_2 = L3_2.USE_PARTICLE_FX_ASSET
  L4_2 = "core"
  L3_2(L4_2)
  L3_2 = GRAPHICS
  L4_2 = "START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD"
  L3_2 = L3_2[L4_2]
  L4_2 = "exp_extinguisher"
  L5_2 = L2_2.x
  L6_2 = L2_2.y
  L7_2 = L2_2.z
  L8_2 = 0
  L9_2 = 0
  L10_2 = 0
  L11_2 = 2.5
  L12_2 = false
  L13_2 = false
  L14_2 = false
  L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
  L3_2 = menu
  L3_2 = L3_2.set_value
  L4_2 = L1_2
  L5_2 = false
  L3_2(L4_2, L5_2)
end
L91_1[L92_1] = L93_1
L91_1 = _ENV
L92_1 = "newColor"
function L93_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2
  L4_2 = {}
  L4_2.r = A0_2
  L4_2.g = A1_2
  L4_2.b = A2_2
  L4_2.a = A3_2
  return L4_2
end
L91_1[L92_1] = L93_1
L91_1 = _ENV
L92_1 = "size"
L93_1 = 0.03
L91_1[L92_1] = L93_1
L91_1 = _ENV
L92_1 = "boxMargin"
L93_1 = _ENV
L94_1 = "size"
L93_1 = L93_1[L94_1]
L94_1 = 7
L93_1 = L93_1 / L94_1
L91_1[L92_1] = L93_1
L91_1 = _ENV
L92_1 = "overlay_x"
L93_1 = 0.04
L91_1[L92_1] = L93_1
L91_1 = _ENV
L92_1 = "overlay_y"
L93_1 = 0.185
L91_1[L92_1] = L93_1
L91_1 = _ENV
L92_1 = "directx"
L91_1 = L91_1[L92_1]
L92_1 = "get_client_size"
L91_1 = L91_1[L92_1]
L91_1, L92_1 = L91_1()
L93_1 = L91_1 / L92_1
L94_1 = 3
L95_1 = 1
L96_1 = 0
L97_1 = _ENV
L98_1 = "newColor"
L97_1 = L97_1[L98_1]
L98_1 = 1
L99_1 = 1
L100_1 = 1
L101_1 = 1
L97_1 = L97_1(L98_1, L99_1, L100_1, L101_1)
L98_1 = _ENV
L99_1 = "newColor"
L98_1 = L98_1[L99_1]
L99_1 = 0
L100_1 = 0
L101_1 = 0
L102_1 = 0.2
L98_1 = L98_1(L99_1, L100_1, L101_1, L102_1)
L99_1 = _ENV
L100_1 = "newColor"
L99_1 = L99_1[L100_1]
L100_1 = 0.009999999999999998
L101_1 = 0.009999999999999998
L102_1 = 0.009999999999999998
L103_1 = 0.5490196078431373
L99_1 = L99_1(L100_1, L101_1, L102_1, L103_1)
L100_1 = {}
L101_1 = {}
L102_1 = "keys"
L103_1 = {}
L104_1 = 44
L105_1 = 52
L106_1 = 85
L107_1 = 138
L108_1 = 141
L109_1 = 152
L110_1 = 205
L111_1 = 264
L103_1[1] = L104_1
L103_1[2] = L105_1
L103_1[3] = L106_1
L103_1[4] = L107_1
L103_1[5] = L108_1
L103_1[6] = L109_1
L103_1[7] = L110_1
L103_1[8] = L111_1
L101_1[L102_1] = L103_1
L102_1 = "pressed"
L103_1 = false
L101_1[L102_1] = L103_1
L102_1 = "key"
L103_1 = "Q"
L101_1[L102_1] = L103_1
L102_1 = "show"
L103_1 = true
L101_1[L102_1] = L103_1
L100_1[1] = L101_1
L101_1 = {}
L102_1 = "keys"
L103_1 = {}
L104_1 = 32
L105_1 = 71
L106_1 = 77
L107_1 = 87
L108_1 = 129
L109_1 = 136
L110_1 = 150
L111_1 = 232
L103_1[1] = L104_1
L103_1[2] = L105_1
L103_1[3] = L106_1
L103_1[4] = L107_1
L103_1[5] = L108_1
L103_1[6] = L109_1
L103_1[7] = L110_1
L103_1[8] = L111_1
L101_1[L102_1] = L103_1
L102_1 = "pressed"
L103_1 = false
L101_1[L102_1] = L103_1
L102_1 = "key"
L103_1 = "W"
L101_1[L102_1] = L103_1
L102_1 = "show"
L103_1 = true
L101_1[L102_1] = L103_1
L100_1[2] = L101_1
L101_1 = {}
L102_1 = "keys"
L103_1 = {}
L104_1 = 38
L105_1 = 46
L106_1 = 51
L107_1 = 54
L108_1 = 86
L109_1 = 103
L110_1 = 119
L111_1 = 153
L112_1 = 184
L113_1 = 206
L114_1 = 350
L115_1 = 351
L116_1 = 355
L117_1 = 356
L103_1[1] = L104_1
L103_1[2] = L105_1
L103_1[3] = L106_1
L103_1[4] = L107_1
L103_1[5] = L108_1
L103_1[6] = L109_1
L103_1[7] = L110_1
L103_1[8] = L111_1
L103_1[9] = L112_1
L103_1[10] = L113_1
L103_1[11] = L114_1
L103_1[12] = L115_1
L103_1[13] = L116_1
L103_1[14] = L117_1
L101_1[L102_1] = L103_1
L102_1 = "pressed"
L103_1 = false
L101_1[L102_1] = L103_1
L102_1 = "key"
L103_1 = "E"
L101_1[L102_1] = L103_1
L102_1 = "show"
L103_1 = true
L101_1[L102_1] = L103_1
L100_1[3] = L101_1
L101_1 = {}
L102_1 = "keys"
L103_1 = {}
L104_1 = 45
L105_1 = 80
L106_1 = 140
L107_1 = 250
L108_1 = 263
L109_1 = 310
L103_1[1] = L104_1
L103_1[2] = L105_1
L103_1[3] = L106_1
L103_1[4] = L107_1
L103_1[5] = L108_1
L103_1[6] = L109_1
L101_1[L102_1] = L103_1
L102_1 = "pressed"
L103_1 = false
L101_1[L102_1] = L103_1
L102_1 = "key"
L103_1 = "R"
L101_1[L102_1] = L103_1
L102_1 = "show"
L103_1 = true
L101_1[L102_1] = L103_1
L100_1[4] = L101_1
L101_1 = {}
L102_1 = "keys"
L103_1 = {}
L104_1 = 34
L105_1 = 63
L106_1 = 89
L107_1 = 133
L108_1 = 147
L109_1 = 234
L110_1 = 338
L103_1[1] = L104_1
L103_1[2] = L105_1
L103_1[3] = L106_1
L103_1[4] = L107_1
L103_1[5] = L108_1
L103_1[6] = L109_1
L103_1[7] = L110_1
L101_1[L102_1] = L103_1
L102_1 = "pressed"
L103_1 = false
L101_1[L102_1] = L103_1
L102_1 = "key"
L103_1 = "A"
L101_1[L102_1] = L103_1
L102_1 = "show"
L103_1 = true
L101_1[L102_1] = L103_1
L100_1[5] = L101_1
L101_1 = {}
L102_1 = "keys"
L103_1 = {}
L104_1 = 8
L105_1 = 31
L106_1 = 33
L107_1 = 72
L108_1 = 78
L109_1 = 88
L110_1 = 130
L111_1 = 139
L112_1 = 149
L113_1 = 151
L114_1 = 196
L115_1 = 219
L116_1 = 233
L117_1 = 268
L118_1 = 269
L119_1 = 302
L103_1[1] = L104_1
L103_1[2] = L105_1
L103_1[3] = L106_1
L103_1[4] = L107_1
L103_1[5] = L108_1
L103_1[6] = L109_1
L103_1[7] = L110_1
L103_1[8] = L111_1
L103_1[9] = L112_1
L103_1[10] = L113_1
L103_1[11] = L114_1
L103_1[12] = L115_1
L103_1[13] = L116_1
L103_1[14] = L117_1
L103_1[15] = L118_1
L103_1[16] = L119_1
L101_1[L102_1] = L103_1
L102_1 = "pressed"
L103_1 = false
L101_1[L102_1] = L103_1
L102_1 = "key"
L103_1 = "S"
L101_1[L102_1] = L103_1
L102_1 = "show"
L103_1 = true
L101_1[L102_1] = L103_1
L100_1[6] = L101_1
L101_1 = {}
L102_1 = "keys"
L103_1 = {}
L104_1 = 9
L105_1 = 30
L106_1 = 35
L107_1 = 59
L108_1 = 64
L109_1 = 90
L110_1 = 134
L111_1 = 146
L112_1 = 148
L113_1 = 195
L114_1 = 218
L115_1 = 235
L116_1 = 266
L117_1 = 267
L118_1 = 278
L119_1 = 279
L120_1 = 339
L121_1 = 342
L103_1[1] = L104_1
L103_1[2] = L105_1
L103_1[3] = L106_1
L103_1[4] = L107_1
L103_1[5] = L108_1
L103_1[6] = L109_1
L103_1[7] = L110_1
L103_1[8] = L111_1
L103_1[9] = L112_1
L103_1[10] = L113_1
L103_1[11] = L114_1
L103_1[12] = L115_1
L103_1[13] = L116_1
L103_1[14] = L117_1
L103_1[15] = L118_1
L103_1[16] = L119_1
L103_1[17] = L120_1
L103_1[18] = L121_1
L101_1[L102_1] = L103_1
L102_1 = "pressed"
L103_1 = false
L101_1[L102_1] = L103_1
L102_1 = "key"
L103_1 = "D"
L101_1[L102_1] = L103_1
L102_1 = "show"
L103_1 = true
L101_1[L102_1] = L103_1
L100_1[7] = L101_1
L101_1 = {}
L102_1 = "keys"
L103_1 = {}
L104_1 = 23
L105_1 = 49
L106_1 = 75
L107_1 = 145
L108_1 = 185
L109_1 = 251
L103_1[1] = L104_1
L103_1[2] = L105_1
L103_1[3] = L106_1
L103_1[4] = L107_1
L103_1[5] = L108_1
L103_1[6] = L109_1
L101_1[L102_1] = L103_1
L102_1 = "pressed"
L103_1 = false
L101_1[L102_1] = L103_1
L102_1 = "key"
L103_1 = "F"
L101_1[L102_1] = L103_1
L102_1 = "show"
L103_1 = true
L101_1[L102_1] = L103_1
L100_1[8] = L101_1
L101_1 = {}
L102_1 = "keys"
L103_1 = {}
L104_1 = 21
L105_1 = 61
L106_1 = 131
L107_1 = 155
L108_1 = 209
L109_1 = 254
L110_1 = 340
L111_1 = 352
L103_1[1] = L104_1
L103_1[2] = L105_1
L103_1[3] = L106_1
L103_1[4] = L107_1
L103_1[5] = L108_1
L103_1[6] = L109_1
L103_1[7] = L110_1
L103_1[8] = L111_1
L101_1[L102_1] = L103_1
L102_1 = "pressed"
L103_1 = false
L101_1[L102_1] = L103_1
L102_1 = "key"
L103_1 = "Shift"
L101_1[L102_1] = L103_1
L102_1 = "show"
L103_1 = true
L101_1[L102_1] = L103_1
L100_1[9] = L101_1
L101_1 = {}
L102_1 = "keys"
L103_1 = {}
L104_1 = 36
L105_1 = 60
L106_1 = 62
L107_1 = 132
L108_1 = 224
L109_1 = 280
L110_1 = 281
L111_1 = 326
L112_1 = 341
L113_1 = 343
L103_1[1] = L104_1
L103_1[2] = L105_1
L103_1[3] = L106_1
L103_1[4] = L107_1
L103_1[5] = L108_1
L103_1[6] = L109_1
L103_1[7] = L110_1
L103_1[8] = L111_1
L103_1[9] = L112_1
L103_1[10] = L113_1
L101_1[L102_1] = L103_1
L102_1 = "pressed"
L103_1 = false
L101_1[L102_1] = L103_1
L102_1 = "key"
L103_1 = "Ctrl"
L101_1[L102_1] = L103_1
L102_1 = "show"
L103_1 = true
L101_1[L102_1] = L103_1
L100_1[10] = L101_1
L101_1 = {}
L102_1 = "keys"
L103_1 = {}
L104_1 = 18
L105_1 = 22
L106_1 = 55
L107_1 = 76
L108_1 = 102
L109_1 = 143
L110_1 = 179
L111_1 = 203
L112_1 = 216
L113_1 = 255
L114_1 = 298
L115_1 = 321
L116_1 = 328
L117_1 = 353
L103_1[1] = L104_1
L103_1[2] = L105_1
L103_1[3] = L106_1
L103_1[4] = L107_1
L103_1[5] = L108_1
L103_1[6] = L109_1
L103_1[7] = L110_1
L103_1[8] = L111_1
L103_1[9] = L112_1
L103_1[10] = L113_1
L103_1[11] = L114_1
L103_1[12] = L115_1
L103_1[13] = L116_1
L103_1[14] = L117_1
L101_1[L102_1] = L103_1
L102_1 = "pressed"
L103_1 = false
L101_1[L102_1] = L103_1
L102_1 = "key"
L103_1 = "Space"
L101_1[L102_1] = L103_1
L102_1 = "show"
L103_1 = true
L101_1[L102_1] = L103_1
L100_1[11] = L101_1
L101_1 = _ENV
L102_1 = "key_display"
function L103_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L0_2 = 1
  L1_2 = L100_1
  L1_2 = #L1_2
  L2_2 = 1
  for L3_2 = L0_2, L1_2, L2_2 do
    L4_2 = L100_1
    L4_2 = L4_2[L3_2]
    L4_2.pressed = false
    L4_2 = 1
    L5_2 = L100_1
    L5_2 = L5_2[L3_2]
    L5_2 = L5_2.keys
    L5_2 = #L5_2
    L6_2 = 1
    for L7_2 = L4_2, L5_2, L6_2 do
      L8_2 = PAD
      L8_2 = L8_2.IS_CONTROL_PRESSED
      L9_2 = 2
      L10_2 = L100_1
      L10_2 = L10_2[L3_2]
      L10_2 = L10_2.keys
      L10_2 = L10_2[L7_2]
      L8_2 = L8_2(L9_2, L10_2)
      if L8_2 then
        L8_2 = L100_1
        L8_2 = L8_2[L3_2]
        L8_2.pressed = true
      end
    end
  end
  L0_2 = 1
  L1_2 = L100_1
  L1_2 = #L1_2
  L1_2 = L1_2 - 3
  L2_2 = 1
  for L3_2 = L0_2, L1_2, L2_2 do
    L4_2 = L100_1
    L4_2 = L4_2[L3_2]
    L4_2 = L4_2.show
    if L4_2 then
      L4_2 = directx
      L4_2 = L4_2.draw_rect
      L5_2 = overlay_x
      L6_2 = boxMargin
      L7_2 = size
      L6_2 = L6_2 + L7_2
      if L3_2 > 4 then
        L7_2 = L3_2 - 5
        if L7_2 then
          goto lbl_58
        end
      end
      L7_2 = L3_2 - 1
      ::lbl_58::
      L6_2 = L6_2 * L7_2
      L5_2 = L5_2 + L6_2
      L6_2 = overlay_y
      if L3_2 > 4 then
        L7_2 = boxMargin
        L8_2 = size
        L9_2 = L93_1
        L8_2 = L8_2 * L9_2
        L7_2 = L7_2 + L8_2
        if L7_2 then
          goto lbl_75
        end
      end
      L7_2 = 0
      ::lbl_75::
      L7_2 = L7_2 * 1.05
      L6_2 = L6_2 + L7_2
      L7_2 = size
      L8_2 = size
      L9_2 = L93_1
      L8_2 = L8_2 * L9_2
      L9_2 = L100_1
      L9_2 = L9_2[L3_2]
      L9_2 = L9_2.pressed
      if L9_2 then
        L9_2 = L99_1
        if L9_2 then
          goto lbl_93
        end
      end
      L9_2 = L98_1
      ::lbl_93::
      L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
      L4_2 = hideKey
      if not L4_2 then
        L4_2 = directx
        L4_2 = L4_2.draw_text
        L5_2 = overlay_x
        L6_2 = boxMargin
        L7_2 = size
        L6_2 = L6_2 + L7_2
        if L3_2 > 4 then
          L7_2 = L3_2 - 5
          if L7_2 then
            goto lbl_112
          end
        end
        L7_2 = L3_2 - 1
        ::lbl_112::
        L6_2 = L6_2 * L7_2
        L5_2 = L5_2 + L6_2
        L6_2 = size
        L6_2 = L6_2 * 0.45
        L5_2 = L5_2 + L6_2
        if L3_2 > 4 then
          L6_2 = overlay_y
          L7_2 = boxMargin
          L8_2 = size
          L9_2 = L93_1
          L8_2 = L8_2 * L9_2
          L7_2 = L7_2 + L8_2
          L7_2 = L7_2 * 1.2
          L6_2 = L6_2 + L7_2
          if L6_2 then
            goto lbl_140
          end
        end
        L6_2 = overlay_y
        L6_2 = L6_2 * 1.07
        ::lbl_140::
        L7_2 = L100_1
        L7_2 = L7_2[L3_2]
        L7_2 = L7_2.key
        L8_2 = 1
        L9_2 = size
        L9_2 = L9_2 * 20
        L10_2 = L97_1
        L11_2 = false
        L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
      end
    end
  end
  L0_2 = altShiftCtrl
  if L0_2 then
    L0_2 = L100_1
    L0_2 = #L0_2
    L1_2 = L0_2 - 2
    L0_2 = L100_1
    L0_2 = L0_2[L1_2]
    L0_2 = L0_2.show
    if L0_2 then
      L0_2 = directx
      L0_2 = L0_2.draw_rect
      L1_2 = overlay_x
      L2_2 = overlay_y
      L3_2 = boxMargin
      L4_2 = size
      L3_2 = L3_2 + L4_2
      L4_2 = L93_1
      L3_2 = L3_2 * L4_2
      L3_2 = L3_2 * 2
      L2_2 = L2_2 + L3_2
      L3_2 = boxMargin
      L4_2 = size
      L3_2 = L3_2 + L4_2
      L4_2 = boxMargin
      L3_2 = L3_2 - L4_2
      L4_2 = size
      L5_2 = L93_1
      L4_2 = L4_2 * L5_2
      L4_2 = L4_2 / 2
      L5_2 = L100_1
      L5_2 = #L5_2
      L6_2 = L5_2 - 2
      L5_2 = L100_1
      L5_2 = L5_2[L6_2]
      L5_2 = L5_2.pressed
      if L5_2 then
        L5_2 = L99_1
        if L5_2 then
          goto lbl_204
        end
      end
      L5_2 = L98_1
      ::lbl_204::
      L0_2(L1_2, L2_2, L3_2, L4_2, L5_2)
    end
    L0_2 = L100_1
    L0_2 = #L0_2
    L1_2 = L0_2 - 1
    L0_2 = L100_1
    L0_2 = L0_2[L1_2]
    L0_2 = L0_2.show
    if not L0_2 then
      goto lbl_357
    end
    L0_2 = directx
    L0_2 = L0_2.draw_rect
    L1_2 = overlay_x
    L2_2 = overlay_y
    L3_2 = boxMargin
    L4_2 = size
    L3_2 = L3_2 + L4_2
    L4_2 = L93_1
    L3_2 = L3_2 * L4_2
    L3_2 = L3_2 * 2.5
    L2_2 = L2_2 + L3_2
    L3_2 = boxMargin
    L4_2 = size
    L3_2 = L3_2 + L4_2
    L4_2 = boxMargin
    L3_2 = L3_2 - L4_2
    L4_2 = size
    L5_2 = L93_1
    L4_2 = L4_2 * L5_2
    L4_2 = L4_2 / 2
    L5_2 = L100_1
    L5_2 = #L5_2
    L6_2 = L5_2 - 1
    L5_2 = L100_1
    L5_2 = L5_2[L6_2]
    L5_2 = L5_2.pressed
    if L5_2 then
      L5_2 = L99_1
      if L5_2 then
        goto lbl_255
      end
    end
    L5_2 = L98_1
    ::lbl_255::
    L0_2(L1_2, L2_2, L3_2, L4_2, L5_2)
  else
    L0_2 = 9
    L1_2 = 10
    L2_2 = 1
    for L3_2 = L0_2, L1_2, L2_2 do
      L4_2 = L100_1
      L4_2 = L4_2[L3_2]
      L4_2 = L4_2.show
      if L4_2 then
        L4_2 = directx
        L4_2 = L4_2.draw_rect
        L5_2 = overlay_x
        L6_2 = boxMargin
        L7_2 = size
        L6_2 = L6_2 + L7_2
        L5_2 = L5_2 - L6_2
        L6_2 = overlay_y
        L7_2 = boxMargin
        L8_2 = size
        L9_2 = L93_1
        L8_2 = L8_2 * L9_2
        L7_2 = L7_2 + L8_2
        L8_2 = L3_2 - 8
        L7_2 = L7_2 * L8_2
        L7_2 = L7_2 * 1.05
        L6_2 = L6_2 + L7_2
        L7_2 = size
        L8_2 = size
        L9_2 = L93_1
        L8_2 = L8_2 * L9_2
        L9_2 = L100_1
        L9_2 = L9_2[L3_2]
        L9_2 = L9_2.pressed
        if L9_2 then
          L9_2 = L99_1
          if L9_2 then
            goto lbl_305
          end
        end
        L9_2 = L98_1
        ::lbl_305::
        L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
        L4_2 = hideKey
        if not L4_2 then
          L4_2 = directx
          L4_2 = L4_2.draw_text
          L5_2 = overlay_x
          L6_2 = boxMargin
          L7_2 = size
          L6_2 = L6_2 + L7_2
          L5_2 = L5_2 - L6_2
          L6_2 = size
          L6_2 = L6_2 * 0.45
          L5_2 = L5_2 + L6_2
          if L3_2 > 4 then
            L6_2 = overlay_y
            L7_2 = boxMargin
            L8_2 = size
            L9_2 = L93_1
            L8_2 = L8_2 * L9_2
            L7_2 = L7_2 + L8_2
            L8_2 = L3_2 - 8
            L7_2 = L7_2 * L8_2
            L7_2 = L7_2 * 1.2
            L6_2 = L6_2 + L7_2
            if L6_2 then
              goto lbl_346
            end
          end
          L6_2 = overlay_y
          L6_2 = L6_2 * 1.07
          ::lbl_346::
          L7_2 = L100_1
          L7_2 = L7_2[L3_2]
          L7_2 = L7_2.key
          L8_2 = 1
          L9_2 = size
          L9_2 = L9_2 * 20
          L10_2 = L97_1
          L11_2 = false
          L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
        end
      end
    end
  end
  ::lbl_357::
  L0_2 = L100_1
  L1_2 = #L0_2
  L0_2 = L100_1
  L0_2 = L0_2[L1_2]
  L0_2 = L0_2.show
  if L0_2 then
    L0_2 = directx
    L0_2 = L0_2.draw_rect
    L1_2 = overlay_x
    L2_2 = boxMargin
    L3_2 = size
    L2_2 = L2_2 + L3_2
    L3_2 = L96_1
    L2_2 = L2_2 * L3_2
    L1_2 = L1_2 + L2_2
    L2_2 = overlay_y
    L3_2 = boxMargin
    L4_2 = size
    L3_2 = L3_2 + L4_2
    L4_2 = L93_1
    L3_2 = L3_2 * L4_2
    L3_2 = L3_2 * 2
    L2_2 = L2_2 + L3_2
    L3_2 = boxMargin
    L4_2 = size
    L3_2 = L3_2 + L4_2
    L4_2 = L94_1
    L3_2 = L3_2 * L4_2
    L4_2 = boxMargin
    L3_2 = L3_2 - L4_2
    L4_2 = size
    L5_2 = L93_1
    L4_2 = L4_2 * L5_2
    L5_2 = L95_1
    L4_2 = L4_2 / L5_2
    L5_2 = L100_1
    L6_2 = #L5_2
    L5_2 = L100_1
    L5_2 = L5_2[L6_2]
    L5_2 = L5_2.pressed
    if L5_2 then
      L5_2 = L99_1
      if L5_2 then
        goto lbl_416
      end
    end
    L5_2 = L98_1
    ::lbl_416::
    L0_2(L1_2, L2_2, L3_2, L4_2, L5_2)
  end
end
L101_1[L102_1] = L103_1
L101_1 = _ENV
L102_1 = "draw_rect"
function L103_1(A0_2, A1_2, A2_2, A3_2, A4_2)
  local L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  L5_2 = GRAPHICS
  L5_2 = L5_2.DRAW_RECT
  L6_2 = A0_2
  L7_2 = A1_2
  L8_2 = A2_2
  L9_2 = A3_2
  L10_2 = A4_2.r
  L11_2 = A4_2.g
  L12_2 = A4_2.b
  L13_2 = A4_2.a
  L14_2 = false
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
end
L101_1[L102_1] = L103_1
L101_1 = _ENV
L102_1 = "draw_health_bar"
function L103_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2
  L2_2 = players
  L2_2 = L2_2.get_position
  L3_2 = PLAYER
  L3_2 = L3_2.PLAYER_ID
  L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2 = L3_2()
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2)
  L3_2 = ENTITY
  L3_2 = L3_2.GET_ENTITY_COORDS
  L4_2 = A0_2
  L5_2 = true
  L3_2 = L3_2(L4_2, L5_2)
  L5_2 = L2_2
  L4_2 = L2_2.distance
  L6_2 = L3_2
  L4_2 = L4_2(L5_2, L6_2)
  if A1_2 <= L4_2 then
    return
  end
  L5_2 = L4_2 / A1_2
  L6_2 = 1.0
  L5_2 = L6_2 - L5_2
  L6_2 = 0.0
  L7_2 = 0.0
  L8_2 = PED
  L8_2 = L8_2.IS_PED_FATALLY_INJURED
  L9_2 = A0_2
  L8_2 = L8_2(L9_2)
  if not L8_2 then
    L8_2 = PED
    L8_2 = L8_2.GET_PED_ARMOUR
    L9_2 = A0_2
    L8_2 = L8_2(L9_2)
    L7_2 = L8_2 / 100.0
    if L7_2 > 1.0 then
      L7_2 = 1.0
    end
    L9_2 = ENTITY
    L9_2 = L9_2.GET_ENTITY_HEALTH
    L10_2 = A0_2
    L9_2 = L9_2(L10_2)
    L9_2 = L9_2 - 100.0
    L10_2 = PED
    L10_2 = L10_2.GET_PED_MAX_HEALTH
    L11_2 = A0_2
    L10_2 = L10_2(L11_2)
    L10_2 = L10_2 - 100.0
    L6_2 = L9_2 / L10_2
    if L6_2 > 1.0 then
      L6_2 = 1.0
    end
  end
  L8_2 = L5_2 ^ 3
  L8_2 = 0.05 * L8_2
  L9_2 = L5_2 ^ 1.5
  L9_2 = 0.008 * L9_2
  L10_2 = PED
  L10_2 = L10_2.GET_PED_BONE_COORDS
  L11_2 = A0_2
  L12_2 = 12844
  L13_2 = 0.35
  L14_2 = 0.0
  L15_2 = 0.0
  L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2, L15_2)
  L11_2 = memory
  L11_2 = L11_2.alloc
  L12_2 = 4
  L11_2 = L11_2(L12_2)
  L12_2 = memory
  L12_2 = L12_2.alloc
  L13_2 = 4
  L12_2 = L12_2(L13_2)
  L13_2 = GRAPHICS
  L13_2 = L13_2.GET_SCREEN_COORD_FROM_WORLD_COORD
  L14_2 = L10_2.x
  L15_2 = L10_2.y
  L16_2 = L10_2.z
  L17_2 = L11_2
  L18_2 = L12_2
  L13_2 = L13_2(L14_2, L15_2, L16_2, L17_2, L18_2)
  if not L13_2 then
    return
  end
  L13_2 = memory
  L13_2 = L13_2.read_float
  L14_2 = L11_2
  L13_2 = L13_2(L14_2)
  L14_2 = memory
  L14_2 = L14_2.read_float
  L15_2 = L12_2
  L14_2 = L14_2(L15_2)
  L15_2 = interpolate
  L16_2 = 0.0
  L17_2 = L8_2
  L18_2 = L6_2
  L15_2 = L15_2(L16_2, L17_2, L18_2)
  L16_2 = get_blended_colour
  L17_2 = L6_2
  L16_2 = L16_2(L17_2)
  L17_2 = draw_rect
  L18_2 = L13_2
  L19_2 = L14_2
  L20_2 = L8_2 + 0.002
  L21_2 = L9_2 + 0.002
  L22_2 = {}
  L22_2.r = 0
  L22_2.g = 0
  L22_2.b = 0
  L22_2.a = 120
  L17_2(L18_2, L19_2, L20_2, L21_2, L22_2)
  L17_2 = draw_rect
  L18_2 = L8_2 / 2
  L18_2 = L13_2 - L18_2
  L19_2 = L15_2 / 2
  L18_2 = L18_2 + L19_2
  L19_2 = L14_2
  L20_2 = L15_2
  L21_2 = L9_2
  L22_2 = L16_2
  L17_2(L18_2, L19_2, L20_2, L21_2, L22_2)
  L17_2 = interpolate
  L18_2 = 0.0
  L19_2 = L8_2
  L20_2 = L7_2
  L17_2 = L17_2(L18_2, L19_2, L20_2)
  L18_2 = get_hud_colour
  L19_2 = HudColour
  L19_2 = L19_2.radarArmour
  L18_2 = L18_2(L19_2)
  L19_2 = draw_rect
  L20_2 = L13_2
  L21_2 = 1.5 * L9_2
  L21_2 = L14_2 + L21_2
  L22_2 = L8_2 + 0.002
  L23_2 = L9_2 + 0.002
  L24_2 = {}
  L24_2.r = 0
  L24_2.g = 0
  L24_2.b = 0
  L24_2.a = 120
  L19_2(L20_2, L21_2, L22_2, L23_2, L24_2)
  L19_2 = draw_rect
  L20_2 = L8_2 / 2
  L20_2 = L13_2 - L20_2
  L21_2 = L17_2 / 2
  L20_2 = L20_2 + L21_2
  L21_2 = 1.5 * L9_2
  L21_2 = L14_2 + L21_2
  L22_2 = L17_2
  L23_2 = L9_2
  L24_2 = L18_2
  L19_2(L20_2, L21_2, L22_2, L23_2, L24_2)
end
L101_1[L102_1] = L103_1
L101_1 = _ENV
L102_1 = "b_common_funcs"
L103_1 = {}
L101_1[L102_1] = L103_1
L101_1 = _ENV
L102_1 = "b_common_funcs"
L101_1 = L101_1[L102_1]
L102_1 = "new"
function L103_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = {}
  function L1_2(A0_3, A1_3)
    local L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3
    L2_3 = memory
    L2_3 = L2_3.read_long
    L3_3 = A0_3
    L2_3 = L2_3(L3_3)
    L3_3 = 1
    L4_3 = #A1_3
    L4_3 = L4_3 - 1
    L5_3 = 1
    for L6_3 = L3_3, L4_3, L5_3 do
      L7_3 = memory
      L7_3 = L7_3.read_long
      L8_3 = A1_3[L6_3]
      L8_3 = L2_3 + L8_3
      L7_3 = L7_3(L8_3)
      L2_3 = L7_3
      if 0 == L2_3 then
        L7_3 = 0
        return L7_3
      end
    end
    L3_3 = #A1_3
    L3_3 = A1_3[L3_3]
    L2_3 = L2_3 + L3_3
    return L2_3
  end
  L0_2.address_from_pointer_chain = L1_2
  function L1_2()
    local L0_3, L1_3, L2_3
    L0_3 = entities
    L0_3 = L0_3.get_user_vehicle_as_handle
    L0_3 = L0_3()
    L1_3 = VEHICLE
    L1_3 = L1_3.GET_VEHICLE_CLASS
    L2_3 = L0_3
    return L1_3(L2_3)
  end
  L0_2.get_player_vehicle_class = L1_2
  function L1_2()
    local L0_3, L1_3, L2_3
    L0_3 = directx
    L0_3 = L0_3.get_client_size
    L0_3, L1_3 = L0_3()
    L2_3 = L0_3 / L1_3
    return L2_3
  end
  L0_2.get_ascpect_ratio = L1_2
  function L1_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3
    L1_3 = {}
    while A0_3 > 0 do
      L2_3 = math
      L2_3 = L2_3.fmod
      L3_3 = A0_3
      L4_3 = 2
      L2_3 = L2_3(L3_3, L4_3)
      L52_1 = L2_3
      L2_3 = #L1_3
      L2_3 = L2_3 + 1
      L3_3 = L52_1
      L1_3[L2_3] = L3_3
      L2_3 = L52_1
      L2_3 = A0_3 - L2_3
      A0_3 = L2_3 / 2
    end
    return L1_3
  end
  L0_2.to_bits = L1_2
  function L1_2(A0_3, A1_3)
    local L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
    L2_3 = {}
    L3_3 = string
    L3_3 = L3_3.gmatch
    L4_3 = A0_3
    L5_3 = "([^"
    L6_3 = A1_3
    L7_3 = "]+)"
    L5_3 = L5_3 .. L6_3 .. L7_3
    L3_3, L4_3, L5_3, L6_3 = L3_3(L4_3, L5_3)
    for L7_3 in L3_3, L4_3, L5_3, L6_3 do
      L8_3 = table
      L8_3 = L8_3.insert
      L9_3 = L2_3
      L10_3 = L7_3
      L8_3(L9_3, L10_3)
    end
    return L2_3
  end
  L0_2.split = L1_2
  L1_2 = memory
  L1_2 = L1_2.alloc
  L1_2 = L1_2()
  L2_2 = memory
  L2_2 = L2_2.alloc
  L2_2 = L2_2()
  function L3_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3, L5_3, L6_3
    L1_3 = MISC
    L1_3 = L1_3.GET_MODEL_DIMENSIONS
    L2_3 = ENTITY
    L2_3 = L2_3.GET_ENTITY_MODEL
    L3_3 = A0_3
    L2_3 = L2_3(L3_3)
    L3_3 = L1_2
    L4_3 = L2_2
    L1_3(L2_3, L3_3, L4_3)
    L1_3 = memory
    L1_3 = L1_3.read_vector3
    L2_3 = L2_2
    L1_3 = L1_3(L2_3)
    L2_3 = ENTITY
    L2_3 = L2_3.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
    L3_3 = A0_3
    L4_3 = 0
    L5_3 = 0
    L6_3 = L1_3.z
    return L2_3(L3_3, L4_3, L5_3, L6_3)
  end
  L0_2.get_pos_above_entity = L3_2
  function L3_2(A0_3, A1_3)
    local L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3
    L2_3 = io
    L2_3 = L2_3.open
    L3_3 = A0_3
    L4_3 = "rb"
    L2_3 = L2_3(L3_3, L4_3)
    L3_3 = io
    L3_3 = L3_3.open
    L4_3 = A1_3
    L5_3 = "wb"
    L3_3 = L3_3(L4_3, L5_3)
    L4_3 = 0
    L5_3 = 0
    if not L2_3 or not L3_3 then
      L6_3 = false
      return L6_3
    end
    while true do
      L7_3 = L2_3
      L6_3 = L2_3.read
      L8_3 = 8192.0
      L6_3 = L6_3(L7_3, L8_3)
      if not L6_3 then
        L8_3 = L2_3
        L7_3 = L2_3.seek
        L9_3 = "end"
        L7_3 = L7_3(L8_3, L9_3)
        L4_3 = L7_3
        break
      end
      L8_3 = L3_3
      L7_3 = L3_3.write
      L9_3 = L6_3
      L7_3(L8_3, L9_3)
    end
    L7_3 = L2_3
    L6_3 = L2_3.close
    L6_3(L7_3)
    L7_3 = L3_3
    L6_3 = L3_3.seek
    L8_3 = "end"
    L6_3 = L6_3(L7_3, L8_3)
    L5_3 = L6_3
    L7_3 = L3_3
    L6_3 = L3_3.close
    L6_3(L7_3)
    L6_3 = L5_3 == L4_3
    return L6_3
  end
  L0_2.copy_File = L3_2
  return L0_2
end
L101_1[L102_1] = L103_1
L101_1 = _ENV
L102_1 = "b_math_funcs"
L103_1 = {}
L101_1[L102_1] = L103_1
L101_1 = _ENV
L102_1 = "b_math_funcs"
L101_1 = L101_1[L102_1]
L102_1 = "new"
function L103_1()
  local L0_2, L1_2, L2_2
  L0_2 = {}
  function L1_2(A0_3, A1_3, A2_3)
    local L3_3
    L3_3 = A1_3 - A0_3
    L3_3 = L3_3 * A2_3
    L3_3 = A0_3 + L3_3
    return L3_3
  end
  L0_2.lerp = L1_2
  L1_2 = 1.0E-7
  function L2_2(A0_3, A1_3, A2_3, A3_3, A4_3)
    local L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3, L17_3, L18_3
    L5_3 = nil
    L6_3 = nil
    L7_3 = nil
    L8_3 = nil
    L9_3 = nil
    L10_3 = nil
    L11_3 = nil
    L12_3 = nil
    L13_3 = nil
    L14_3 = {}
    L15_3 = A3_3.x
    L16_3 = A2_3.x
    L15_3 = L15_3 - L16_3
    L14_3.x = L15_3
    L15_3 = A3_3.y
    L16_3 = A2_3.y
    L15_3 = L15_3 - L16_3
    L14_3.y = L15_3
    L15_3 = A3_3.z
    L16_3 = A2_3.z
    L15_3 = L15_3 - L16_3
    L14_3.z = L15_3
    L5_3 = L14_3
    L14_3 = {}
    L15_3 = A4_3.x
    L16_3 = A2_3.x
    L15_3 = L15_3 - L16_3
    L14_3.x = L15_3
    L15_3 = A4_3.y
    L16_3 = A2_3.y
    L15_3 = L15_3 - L16_3
    L14_3.y = L15_3
    L15_3 = A4_3.z
    L16_3 = A2_3.z
    L15_3 = L15_3 - L16_3
    L14_3.z = L15_3
    L6_3 = L14_3
    L14_3 = {}
    L15_3 = L6_3.y
    L16_3 = A1_3.z
    L15_3 = L15_3 * L16_3
    L16_3 = L6_3.z
    L17_3 = A1_3.y
    L16_3 = L16_3 * L17_3
    L15_3 = L15_3 - L16_3
    L14_3.x = L15_3
    L15_3 = L6_3.z
    L16_3 = A1_3.x
    L15_3 = L15_3 * L16_3
    L16_3 = L6_3.x
    L17_3 = A1_3.z
    L16_3 = L16_3 * L17_3
    L15_3 = L15_3 - L16_3
    L14_3.y = L15_3
    L15_3 = L6_3.x
    L16_3 = A1_3.y
    L15_3 = L15_3 * L16_3
    L16_3 = L6_3.y
    L17_3 = A1_3.x
    L16_3 = L16_3 * L17_3
    L15_3 = L15_3 - L16_3
    L14_3.z = L15_3
    L7_3 = L14_3
    L14_3 = L7_3.x
    L15_3 = L5_3.x
    L14_3 = L14_3 * L15_3
    L15_3 = L7_3.y
    L16_3 = L5_3.y
    L15_3 = L15_3 * L16_3
    L14_3 = L14_3 + L15_3
    L15_3 = L7_3.z
    L16_3 = L5_3.z
    L15_3 = L15_3 * L16_3
    L10_3 = L14_3 + L15_3
    L14_3 = L1_2
    L14_3 = -L14_3
    if L10_3 > L14_3 then
      L14_3 = L1_2
      if L10_3 < L14_3 then
        L14_3 = false
        return L14_3
      end
    end
    L14_3 = 1.0
    L11_3 = L14_3 / L10_3
    L14_3 = {}
    L15_3 = A0_3.x
    L16_3 = A2_3.x
    L15_3 = L15_3 - L16_3
    L14_3.x = L15_3
    L15_3 = A0_3.y
    L16_3 = A2_3.y
    L15_3 = L15_3 - L16_3
    L14_3.y = L15_3
    L15_3 = A0_3.z
    L16_3 = A2_3.z
    L15_3 = L15_3 - L16_3
    L14_3.z = L15_3
    L8_3 = L14_3
    L14_3 = L7_3.x
    L15_3 = L8_3.x
    L14_3 = L14_3 * L15_3
    L15_3 = L7_3.y
    L16_3 = L8_3.y
    L15_3 = L15_3 * L16_3
    L14_3 = L14_3 + L15_3
    L15_3 = L7_3.z
    L16_3 = L8_3.z
    L15_3 = L15_3 * L16_3
    L14_3 = L14_3 + L15_3
    L12_3 = L11_3 * L14_3
    if L12_3 < 0.0 or L12_3 > 1.0 then
      L14_3 = false
      return L14_3
    end
    L14_3 = {}
    L15_3 = L5_3.y
    L16_3 = L8_3.z
    L15_3 = L15_3 * L16_3
    L16_3 = L5_3.z
    L17_3 = L8_3.y
    L16_3 = L16_3 * L17_3
    L15_3 = L15_3 - L16_3
    L14_3.x = L15_3
    L15_3 = L5_3.z
    L16_3 = L8_3.x
    L15_3 = L15_3 * L16_3
    L16_3 = L5_3.x
    L17_3 = L8_3.z
    L16_3 = L16_3 * L17_3
    L15_3 = L15_3 - L16_3
    L14_3.y = L15_3
    L15_3 = L5_3.x
    L16_3 = L8_3.y
    L15_3 = L15_3 * L16_3
    L16_3 = L5_3.y
    L17_3 = L8_3.x
    L16_3 = L16_3 * L17_3
    L15_3 = L15_3 - L16_3
    L14_3.z = L15_3
    L9_3 = L14_3
    L14_3 = A1_3.x
    L15_3 = L9_3.x
    L14_3 = L14_3 * L15_3
    L15_3 = A1_3.y
    L16_3 = L9_3.y
    L15_3 = L15_3 * L16_3
    L14_3 = L14_3 + L15_3
    L15_3 = A1_3.z
    L16_3 = L9_3.z
    L15_3 = L15_3 * L16_3
    L14_3 = L14_3 + L15_3
    L13_3 = L11_3 * L14_3
    if not (L13_3 < 0.0) then
      L14_3 = L12_3 + L13_3
      if not (L14_3 > 1.0) then
        goto lbl_206
      end
    end
    L14_3 = false
    do return L14_3 end
    ::lbl_206::
    L14_3 = L6_3.x
    L15_3 = L9_3.x
    L14_3 = L14_3 * L15_3
    L15_3 = L6_3.y
    L16_3 = L9_3.y
    L15_3 = L15_3 * L16_3
    L14_3 = L14_3 + L15_3
    L15_3 = L6_3.z
    L16_3 = L9_3.z
    L15_3 = L15_3 * L16_3
    L14_3 = L14_3 + L15_3
    L14_3 = L11_3 * L14_3
    t = L14_3
    L14_3 = t
    L15_3 = L1_2
    if L14_3 > L15_3 then
      L14_3 = true
      L15_3 = {}
      L16_3 = A0_3.x
      L17_3 = A1_3.x
      L18_3 = t
      L17_3 = L17_3 * L18_3
      L16_3 = L16_3 + L17_3
      L15_3.x = L16_3
      L16_3 = A0_3.y
      L17_3 = A1_3.y
      L18_3 = t
      L17_3 = L17_3 * L18_3
      L16_3 = L16_3 + L17_3
      L15_3.y = L16_3
      L16_3 = A0_3.z
      L17_3 = A1_3.z
      L18_3 = t
      L17_3 = L17_3 * L18_3
      L16_3 = L16_3 + L17_3
      L15_3.z = L16_3
      return L14_3, L15_3
    else
      L14_3 = false
      return L14_3
    end
  end
  L0_2.RayIntersectsTriangle = L2_2
  return L0_2
end
L101_1[L102_1] = L103_1
L101_1 = _ENV
L102_1 = "b_vectors"
L103_1 = {}
L101_1[L102_1] = L103_1
L101_1 = _ENV
L102_1 = "b_vectors"
L101_1 = L101_1[L102_1]
L102_1 = "new"
function L103_1()
  local L0_2, L1_2, L2_2
  L0_2 = {}
  L1_2 = {}
  L0_2.vector2 = L1_2
  L1_2 = L0_2.vector2
  function L2_2(A0_3, A1_3)
    local L2_3
    L2_3 = {}
    L2_3.x = A0_3
    L2_3.y = A1_3
    return L2_3
  end
  L1_2.new = L2_2
  L1_2 = L0_2.vector2
  function L2_2(A0_3, A1_3)
    local L2_3, L3_3, L4_3
    L2_3 = A0_3.x
    L3_3 = A1_3.x
    L2_3 = L2_3 * L3_3
    L3_3 = A0_3.y
    L4_3 = A1_3.y
    L3_3 = L3_3 * L4_3
    L2_3 = L2_3 + L3_3
    return L2_3
  end
  L1_2.dot = L2_2
  L1_2 = L0_2.vector2
  function L2_2(A0_3)
    local L1_3, L2_3, L3_3, L4_3
    L1_3 = math
    L1_3 = L1_3.sqrt
    L2_3 = A0_3.x
    L3_3 = A0_3.x
    L2_3 = L2_3 * L3_3
    L3_3 = A0_3.y
    L4_3 = A0_3.y
    L3_3 = L3_3 * L4_3
    L2_3 = L2_3 + L3_3
    return L1_3(L2_3)
  end
  L1_2.magnitude = L2_2
  L1_2 = L0_2.vector2
  function L2_2(A0_3, A1_3)
    local L2_3, L3_3, L4_3, L5_3
    L2_3 = math
    L2_3 = L2_3.acos
    L3_3 = L0_2.vector2
    L3_3 = L3_3.dot
    L4_3 = A0_3
    L5_3 = A1_3
    L3_3 = L3_3(L4_3, L5_3)
    L4_3 = L0_2.vector2
    L4_3 = L4_3.magnitude
    L5_3 = A0_3
    L4_3 = L4_3(L5_3)
    L3_3 = L3_3 / L4_3
    L4_3 = L0_2.vector2
    L4_3 = L4_3.magnitude
    L5_3 = A1_3
    L4_3 = L4_3(L5_3)
    L3_3 = L3_3 / L4_3
    return L2_3(L3_3)
  end
  L1_2.get_angle = L2_2
  L1_2 = {}
  L0_2.vector3 = L1_2
  L1_2 = L0_2.vector3
  function L2_2(A0_3, A1_3, A2_3)
    local L3_3
    L3_3 = {}
    L3_3.x = A0_3
    L3_3.y = A1_3
    L3_3.z = A2_3
    return L3_3
  end
  L1_2.new = L2_2
  L1_2 = L0_2.vector3
  function L2_2(A0_3, A1_3)
    local L2_3, L3_3, L4_3, L5_3, L6_3
    L2_3 = L0_2.vector3
    L2_3 = L2_3.new
    L3_3 = A0_3.x
    L4_3 = A1_3.x
    L3_3 = L3_3 + L4_3
    L4_3 = A0_3.y
    L5_3 = A1_3.y
    L4_3 = L4_3 + L5_3
    L5_3 = A0_3.z
    L6_3 = A1_3.z
    L5_3 = L5_3 + L6_3
    return L2_3(L3_3, L4_3, L5_3)
  end
  L1_2.add = L2_2
  L1_2 = L0_2.vector3
  function L2_2(A0_3, A1_3)
    local L2_3, L3_3, L4_3, L5_3, L6_3
    L2_3 = L0_2.vector3
    L2_3 = L2_3.new
    L3_3 = A0_3.x
    L4_3 = A1_3.x
    L3_3 = L3_3 - L4_3
    L4_3 = A0_3.y
    L5_3 = A1_3.y
    L4_3 = L4_3 - L5_3
    L5_3 = A0_3.z
    L6_3 = A1_3.z
    L5_3 = L5_3 - L6_3
    return L2_3(L3_3, L4_3, L5_3)
  end
  L1_2.sub = L2_2
  L1_2 = L0_2.vector3
  function L2_2(A0_3, A1_3)
    local L2_3, L3_3
    L2_3 = {}
    L3_3 = A0_3.x
    L3_3 = L3_3 * A1_3
    L2_3.x = L3_3
    L3_3 = A0_3.y
    L3_3 = L3_3 * A1_3
    L2_3.y = L3_3
    L3_3 = A0_3.z
    L3_3 = L3_3 * A1_3
    L2_3.z = L3_3
    return L2_3
  end
  L1_2.multiply = L2_2
  return L0_2
end
L101_1[L102_1] = L103_1
L101_1 = _ENV
L102_1 = "get_waypoint_coords"
function L103_1()
  local L0_2, L1_2, L2_2
  L0_2 = HUD
  L0_2 = L0_2.GET_BLIP_INFO_ID_COORD
  L1_2 = HUD
  L1_2 = L1_2.GET_FIRST_BLIP_INFO_ID
  L2_2 = HUD
  L2_2 = L2_2.GET_WAYPOINT_BLIP_ENUM_ID
  L2_2 = L2_2()
  L1_2, L2_2 = L1_2(L2_2)
  return L0_2(L1_2, L2_2)
end
L101_1[L102_1] = L103_1
L101_1 = nil
L102_1 = nil
L103_1 = nil
L104_1 = _ENV
L105_1 = "util"
L104_1 = L104_1[L105_1]
L105_1 = "create_tick_handler"
L104_1 = L104_1[L105_1]
function L105_1()
  local L0_2, L1_2
  L0_2 = PLAYER
  L0_2 = L0_2.PLAYER_PED_ID
  L0_2 = L0_2()
  L101_1 = L0_2
  L0_2 = MISC
  L0_2 = L0_2.GET_FRAME_TIME
  L0_2 = L0_2()
  L102_1 = L0_2
  L0_2 = ENTITY
  L0_2 = L0_2.GET_ENTITY_COORDS
  L1_2 = L101_1
  L0_2 = L0_2(L1_2)
  L103_1 = L0_2
  L0_2 = true
  return L0_2
end
L104_1(L105_1)
L104_1 = _ENV
L105_1 = "b_math_funcs"
L104_1 = L104_1[L105_1]
L105_1 = "new"
L104_1 = L104_1[L105_1]
L104_1 = L104_1()
L105_1 = {}
L106_1 = "r"
L107_1 = 255
L105_1[L106_1] = L107_1
L106_1 = "g"
L107_1 = 0
L105_1[L106_1] = L107_1
L106_1 = "b"
L107_1 = 255
L105_1[L106_1] = L107_1
L106_1 = "a"
L107_1 = 255
L105_1[L106_1] = L107_1
L106_1 = {}
L107_1 = "r"
L108_1 = 255
L106_1[L107_1] = L108_1
L107_1 = "g"
L108_1 = 255
L106_1[L107_1] = L108_1
L107_1 = "b"
L108_1 = 255
L106_1[L107_1] = L108_1
L107_1 = "a"
L108_1 = 255
L106_1[L107_1] = L108_1
L107_1 = false
L108_1 = _ENV
L109_1 = "GPS_navigation"
function L110_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = memory
  L1_2 = L1_2.alloc
  L2_2 = 1
  L1_2 = L1_2(L2_2)
  L2_2 = memory
  L2_2 = L2_2.alloc
  L3_2 = 4
  L2_2 = L2_2(L3_2)
  L3_2 = memory
  L3_2 = L3_2.alloc
  L4_2 = 4
  L3_2 = L3_2(L4_2)
  L4_2 = memory
  L4_2 = L4_2.alloc
  L5_2 = 4
  L4_2 = L4_2(L5_2)
  L5_2 = memory
  L5_2 = L5_2.alloc
  L6_2 = 4
  L5_2 = L5_2(L6_2)
  L6_2 = 0
  L107_1 = A0_2
  if A0_2 then
    L7_2 = util
    L7_2 = L7_2.create_tick_handler
    function L8_2()
      local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3
      L0_3 = PED
      L0_3 = L0_3.GET_VEHICLE_PED_IS_IN
      L1_3 = PLAYER
      L1_3 = L1_3.PLAYER_PED_ID
      L1_3 = L1_3()
      L2_3 = false
      L0_3 = L0_3(L1_3, L2_3)
      L1_3 = get_waypoint_coords
      L1_3 = L1_3()
      L2_3 = L1_3.x
      L3_3 = L1_3.y
      L2_3 = L2_3 + L3_3
      L3_3 = L1_3.z
      L2_3 = L2_3 + L3_3
      if 0 ~= L2_3 then
        L3_3 = ENTITY
        L3_3 = L3_3.IS_ENTITY_A_VEHICLE
        L4_3 = L0_3
        L3_3 = L3_3(L4_3)
        if L3_3 then
          L3_3 = ENTITY
          L3_3 = L3_3.GET_ENTITY_HEIGHT
          L4_3 = L0_3
          L5_3 = L103_1.x
          L6_3 = L103_1.y
          L7_3 = L103_1.z
          L8_3 = true
          L9_3 = false
          L3_3 = L3_3(L4_3, L5_3, L6_3, L7_3, L8_3, L9_3)
          L4_3 = PATHFIND
          L4_3 = L4_3.GENERATE_DIRECTIONS_TO_COORD
          L5_3 = L1_3.x
          L6_3 = L1_3.y
          L7_3 = L1_3.z
          L8_3 = 0
          L9_3 = L1_2
          L10_3 = L2_2
          L11_3 = L3_2
          L4_3(L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3)
          L4_3 = memory
          L4_3 = L4_3.read_byte
          L5_3 = L1_2
          L4_3 = L4_3(L5_3)
          L5_3 = memory
          L5_3 = L5_3.read_float
          L6_3 = L3_2
          L5_3 = L5_3(L6_3)
          L5_3 = L5_3 - 18
          L6_3 = GRAPHICS
          L6_3 = L6_3.GET_SCREEN_COORD_FROM_WORLD_COORD
          L7_3 = L103_1.x
          L8_3 = L103_1.y
          L9_3 = L103_1.z
          L9_3 = L9_3 + 1.5
          L9_3 = L9_3 + L3_3
          L10_3 = L4_2
          L11_3 = L5_2
          L6_3(L7_3, L8_3, L9_3, L10_3, L11_3)
          L6_3 = memory
          L6_3 = L6_3.read_float
          L7_3 = L4_2
          L6_3 = L6_3(L7_3)
          L7_3 = memory
          L7_3 = L7_3.read_float
          L8_3 = L5_2
          L7_3 = L7_3(L8_3)
          if 1 == L4_3 then
            L8_3 = L104_1.lerp
            L9_3 = L6_2
            L10_3 = 180
            L11_3 = L102_1
            L11_3 = 5 * L11_3
            L8_3 = L8_3(L9_3, L10_3, L11_3)
            L6_2 = L8_3
            L8_3 = directx
            L8_3 = L8_3.draw_text
            L9_3 = L6_3
            L10_3 = L7_3
            L11_3 = "请在前方路口调头"
            L12_3 = ALIGN_CENTRE
            L13_3 = 1
            L14_3 = L105_1
            L8_3(L9_3, L10_3, L11_3, L12_3, L13_3, L14_3)
          elseif 3 == L4_3 then
            L8_3 = L104_1.lerp
            L9_3 = L6_2
            L10_3 = -90
            L11_3 = L102_1
            L11_3 = 5 * L11_3
            L8_3 = L8_3(L9_3, L10_3, L11_3)
            L6_2 = L8_3
            L8_3 = math
            L8_3 = L8_3.floor
            L9_3 = L5_3
            L8_3 = L8_3(L9_3)
            if L8_3 > -1 then
              L8_3 = directx
              L8_3 = L8_3.draw_text
              L9_3 = L6_3
              L10_3 = L7_3
              L11_3 = "请在前方路口"
              L12_3 = math
              L12_3 = L12_3.floor
              L13_3 = L5_3
              L12_3 = L12_3(L13_3)
              L13_3 = " 米后左转 "
              L11_3 = L11_3 .. L12_3 .. L13_3
              L12_3 = ALIGN_CENTRE
              L13_3 = 1
              L14_3 = L105_1
              L8_3(L9_3, L10_3, L11_3, L12_3, L13_3, L14_3)
            end
          elseif 6 == L4_3 then
            L8_3 = L104_1.lerp
            L9_3 = L6_2
            L10_3 = -145
            L11_3 = L102_1
            L11_3 = 5 * L11_3
            L8_3 = L8_3(L9_3, L10_3, L11_3)
            L6_2 = L8_3
            L8_3 = math
            L8_3 = L8_3.floor
            L9_3 = L5_3
            L8_3 = L8_3(L9_3)
            if L8_3 > -1 then
              L8_3 = directx
              L8_3 = L8_3.draw_text
              L9_3 = L6_3
              L10_3 = L7_3
              L11_3 = math
              L11_3 = L11_3.floor
              L12_3 = L5_3
              L11_3 = L11_3(L12_3)
              L12_3 = " 米后向左急转弯 "
              L11_3 = L11_3 .. L12_3
              L12_3 = ALIGN_CENTRE
              L13_3 = 1
              L14_3 = L105_1
              L8_3(L9_3, L10_3, L11_3, L12_3, L13_3, L14_3)
            end
          elseif 4 == L4_3 then
            L8_3 = L104_1.lerp
            L9_3 = L6_2
            L10_3 = 90
            L11_3 = L102_1
            L11_3 = 5 * L11_3
            L8_3 = L8_3(L9_3, L10_3, L11_3)
            L6_2 = L8_3
            L8_3 = math
            L8_3 = L8_3.floor
            L9_3 = L5_3
            L8_3 = L8_3(L9_3)
            if L8_3 > -1 then
              L8_3 = directx
              L8_3 = L8_3.draw_text
              L9_3 = L6_3
              L10_3 = L7_3
              L11_3 = "请在前方路口 "
              L12_3 = math
              L12_3 = L12_3.floor
              L13_3 = L5_3
              L12_3 = L12_3(L13_3)
              L13_3 = " 米后右转"
              L11_3 = L11_3 .. L12_3 .. L13_3
              L12_3 = ALIGN_CENTRE
              L13_3 = 1
              L14_3 = L105_1
              L8_3(L9_3, L10_3, L11_3, L12_3, L13_3, L14_3)
            end
          elseif 7 == L4_3 then
            L8_3 = L104_1.lerp
            L9_3 = L6_2
            L10_3 = 145
            L11_3 = L102_1
            L11_3 = 5 * L11_3
            L8_3 = L8_3(L9_3, L10_3, L11_3)
            L6_2 = L8_3
            L8_3 = math
            L8_3 = L8_3.floor
            L9_3 = L5_3
            L8_3 = L8_3(L9_3)
            if L8_3 > -1 then
              L8_3 = directx
              L8_3 = L8_3.draw_text
              L9_3 = L6_3
              L10_3 = L7_3
              L11_3 = math
              L11_3 = L11_3.floor
              L12_3 = L5_3
              L11_3 = L11_3(L12_3)
              L12_3 = " 米后向右急转弯 "
              L11_3 = L11_3 .. L12_3
              L12_3 = ALIGN_CENTRE
              L13_3 = 1
              L14_3 = L105_1
              L8_3(L9_3, L10_3, L11_3, L12_3, L13_3, L14_3)
            end
          elseif 8 == L4_3 then
            L8_3 = L104_1.lerp
            L9_3 = L6_2
            L10_3 = 0
            L11_3 = L102_1
            L11_3 = 5 * L11_3
            L8_3 = L8_3(L9_3, L10_3, L11_3)
            L6_2 = L8_3
            L8_3 = directx
            L8_3 = L8_3.draw_text
            L9_3 = L6_3
            L10_3 = L7_3
            L11_3 = "正在重新规划路线    "
            L12_3 = ALIGN_CENTRE
            L13_3 = 1
            L14_3 = L105_1
            L8_3(L9_3, L10_3, L11_3, L12_3, L13_3, L14_3)
          else
            L8_3 = L104_1.lerp
            L9_3 = L6_2
            L10_3 = 0
            L11_3 = L102_1
            L11_3 = 5 * L11_3
            L8_3 = L8_3(L9_3, L10_3, L11_3)
            L6_2 = L8_3
          end
          L8_3 = ENTITY
          L8_3 = L8_3.GET_ENTITY_FORWARD_VECTOR
          L9_3 = L101_1
          L8_3 = L8_3(L9_3)
          L9_3 = b_vectors
          L9_3 = L9_3.new
          L9_3 = L9_3()
          L9_3 = L9_3.vector2
          L9_3 = L9_3.get_angle
          L10_3 = L8_3
          L11_3 = {}
          L11_3.x = 0
          L11_3.y = 1
          L9_3 = L9_3(L10_3, L11_3)
          L10_3 = b_vectors
          L10_3 = L10_3.new
          L10_3 = L10_3()
          L10_3 = L10_3.vector2
          L10_3 = L10_3.dot
          L11_3 = {}
          L12_3 = L8_3.x
          L11_3.x = L12_3
          L12_3 = L8_3.y
          L11_3.y = L12_3
          L12_3 = {}
          L12_3.x = 1
          L12_3.y = 0
          L10_3 = L10_3(L11_3, L12_3)
          if L10_3 > 0 then
            L9_3 = -L9_3
          end
          L10_3 = b_common_funcs
          L10_3 = L10_3.new
          L10_3 = L10_3()
          L10_3 = L10_3.get_pos_above_entity
          L11_3 = L0_3
          L10_3 = L10_3(L11_3)
          L11_3 = L10_3.z
          L11_3 = L11_3 + 0.4
          L10_3.z = L11_3
          L11_3 = drawing_funcs
          L11_3 = L11_3.draw_arrow
          L12_3 = L10_3
          L13_3 = math
          L13_3 = L13_3.rad
          L14_3 = L6_2
          L13_3 = L13_3(L14_3)
          L13_3 = L9_3 - L13_3
          L14_3 = 1
          L15_3 = L105_1
          L16_3 = L106_1
          L11_3(L12_3, L13_3, L14_3, L15_3, L16_3)
        end
      end
      L3_3 = L107_1
      return L3_3
    end
    L7_2(L8_2)
  end
end
L108_1[L109_1] = L110_1
L108_1 = _ENV
L109_1 = "upgrade_vehicle"
function L110_1(A0_2)
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
L108_1[L109_1] = L110_1
L108_1 = _ENV
L109_1 = "give_oppressor"
function L110_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = PLAYER
  L1_2 = L1_2.GET_PLAYER_PED_SCRIPT_INDEX
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = ENTITY
  L2_2 = L2_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L3_2 = L1_2
  L4_2 = 0.0
  L5_2 = 5.0
  L6_2 = 0.0
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2)
  L3_2 = util
  L3_2 = L3_2.joaat
  L4_2 = "oppressor2"
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
  L7_2, L8_2 = L7_2(L8_2)
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_INVINCIBLE
  L6_2 = L4_2
  L5_2(L6_2)
  L5_2 = upgrade_vehicle
  L6_2 = L4_2
  L5_2(L6_2)
end
L108_1[L109_1] = L110_1
L108_1 = _ENV
L109_1 = "CreateVehicle"
function L110_1(A0_2, A1_2, A2_2, A3_2)
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
L108_1[L109_1] = L110_1
L108_1 = _ENV
L109_1 = "CreateObject"
function L110_1(A0_2, A1_2, A2_2)
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
L108_1[L109_1] = L110_1
L108_1 = _ENV
L109_1 = "CreatePed"
function L110_1(A0_2, A1_2, A2_2, A3_2)
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
L108_1[L109_1] = L110_1
L108_1 = _ENV
L109_1 = "xp_over"
function L110_1(A0_2)
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
        L21_2 = ENTITY1
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
    L9_2 = 500
    L8_2(L9_2)
    L8_2 = menu
    L8_2 = L8_2.trigger_commands
    L9_2 = "explode"
    L10_2 = players
    L10_2 = L10_2.get_name
    L11_2 = A0_2
    L10_2 = L10_2(L11_2)
    L9_2 = L9_2 .. L10_2
    L8_2(L9_2)
  end
end
L108_1[L109_1] = L110_1
L108_1 = {}
L109_1 = "microlight"
L110_1 = "cuban800"
L111_1 = "tula"
L112_1 = "alphaz1"
L113_1 = "velum2"
L114_1 = "nimbus"
L115_1 = "seabreeze"
L108_1[1] = L109_1
L108_1[2] = L110_1
L108_1[3] = L111_1
L108_1[4] = L112_1
L108_1[5] = L113_1
L108_1[6] = L114_1
L108_1[7] = L115_1
L109_1 = {}
L110_1 = {}
L111_1 = -1718.5878
L112_1 = -982.02405
L113_1 = 322.83115
L110_1[1] = L111_1
L110_1[2] = L112_1
L110_1[3] = L113_1
L111_1 = {}
L112_1 = -2671.5007
L113_1 = 3404.2637
L114_1 = 455.1972
L111_1[1] = L112_1
L111_1[2] = L113_1
L111_1[3] = L114_1
L112_1 = {}
L113_1 = 9.977266
L114_1 = 6621.406
L115_1 = 306.46536
L112_1[1] = L113_1
L112_1[2] = L114_1
L112_1[3] = L115_1
L113_1 = {}
L114_1 = 3529.1458
L115_1 = 3754.5452
L116_1 = 109.96472
L113_1[1] = L114_1
L113_1[2] = L115_1
L113_1[3] = L116_1
L114_1 = {}
L115_1 = 252
L116_1 = 2815
L117_1 = 120
L114_1[1] = L115_1
L114_1[2] = L116_1
L114_1[3] = L117_1
L109_1[1] = L110_1
L109_1[2] = L111_1
L109_1[3] = L112_1
L109_1[4] = L113_1
L109_1[5] = L114_1
L110_1 = 1
L111_1 = _ENV
L112_1 = "airplane_collapsed1"
function L113_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2
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
    L1_2 = ENTITY
    L1_2 = L1_2.SET_ENTITY_PROOFS
    L2_2 = L0_2
    L3_2 = true
    L4_2 = true
    L5_2 = true
    L6_2 = true
    L7_2 = true
    L8_2 = true
    L9_2 = true
    L10_2 = true
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
    L1_2 = players
    L1_2 = L1_2.exists
    L2_2 = L110_1
    L1_2 = L1_2(L2_2)
    if L1_2 then
      L1_2 = ENTITY
      L1_2 = L1_2.GET_ENTITY_COORDS
      L2_2 = PLAYER
      L2_2 = L2_2.GET_PLAYER_PED_SCRIPT_INDEX
      L3_2 = L110_1
      L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2 = L2_2(L3_2)
      L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2)
      L2_2 = util
      L2_2 = L2_2.toast
      L3_2 = "Player ID: "
      L4_2 = L110_1
      L5_2 = " | asda.x: "
      L6_2 = L1_2.x
      L7_2 = "asda.y: "
      L8_2 = L1_2.y
      L9_2 = "asda.z: "
      L10_2 = L1_2.z
      L3_2 = L3_2 .. L4_2 .. L5_2 .. L6_2 .. L7_2 .. L8_2 .. L9_2 .. L10_2
      L2_2(L3_2)
      L2_2 = ENTITY
      L2_2 = L2_2.SET_ENTITY_COORDS
      L3_2 = L0_2
      L4_2 = L1_2.x
      L5_2 = L1_2.y
      L6_2 = L1_2.z
      L6_2 = L6_2 + 50
      L7_2 = false
      L8_2 = false
      L9_2 = false
      L10_2 = true
      L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
      L2_2 = L110_1
      L2_2 = L2_2 + 1
      L110_1 = L2_2
    else
      L1_2 = L110_1
      if L1_2 >= 32 then
        L1_2 = 0
        L110_1 = L1_2
      end
      L1_2 = L110_1
      L1_2 = L1_2 + 1
      L110_1 = L1_2
      L1_2 = math
      L1_2 = L1_2.random
      L2_2 = 1
      L3_2 = L109_1
      L3_2 = #L3_2
      L1_2 = L1_2(L2_2, L3_2)
      L2_2 = L109_1
      L1_2 = L2_2[L1_2]
      L2_2 = ENTITY
      L2_2 = L2_2.SET_ENTITY_COORDS
      L3_2 = L0_2
      L4_2 = L1_2[1]
      L5_2 = L1_2[2]
      L6_2 = L1_2[3]
      L7_2 = false
      L8_2 = false
      L9_2 = false
      L10_2 = true
      L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
    end
    L1_2 = ENTITY
    L1_2 = L1_2.SET_ENTITY_VELOCITY
    L2_2 = L0_2
    L3_2 = 0
    L4_2 = 0
    L5_2 = 0
    L1_2(L2_2, L3_2, L4_2, L5_2)
    L1_2 = ENTITY
    L1_2 = L1_2.SET_ENTITY_ROTATION
    L2_2 = L0_2
    L3_2 = 0
    L4_2 = 0
    L5_2 = 0
    L6_2 = 2
    L7_2 = true
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
    L1_2 = ENTITY
    L1_2 = L1_2.GET_ENTITY_COORDS
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2 = L2_2()
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2)
    L2_2 = L1_2.z
    L2_2 = L2_2 + 10
    L1_2.z = L2_2
    L2_2 = 1
    L3_2 = 2
    L4_2 = 1
    for L5_2 = L2_2, L3_2, L4_2 do
      L6_2 = math
      L6_2 = L6_2.random
      L7_2 = 1
      L8_2 = L108_1
      L8_2 = #L8_2
      L6_2 = L6_2(L7_2, L8_2)
      L7_2 = L108_1
      L6_2 = L7_2[L6_2]
      L7_2 = request_model
      L8_2 = util
      L8_2 = L8_2.joaat
      L9_2 = L6_2
      L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2 = L8_2(L9_2)
      L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2)
      L7_2 = entities
      L7_2 = L7_2.create_vehicle
      L8_2 = util
      L8_2 = L8_2.joaat
      L9_2 = L6_2
      L8_2 = L8_2(L9_2)
      L9_2 = L1_2
      L10_2 = 0
      L7_2 = L7_2(L8_2, L9_2, L10_2)
      L8_2 = ENTITY
      L8_2 = L8_2.ATTACH_ENTITY_TO_ENTITY_PHYSICALLY
      L9_2 = L7_2
      L10_2 = L0_2
      L11_2 = 0
      L12_2 = 0
      L13_2 = 0
      L14_2 = 0
      L15_2 = 2 * L5_2
      L15_2 = 5 + L15_2
      L16_2 = 0
      L17_2 = 0
      L18_2 = 0
      L19_2 = 0
      L20_2 = 0
      L21_2 = 0
      L22_2 = 1000
      L23_2 = true
      L24_2 = true
      L25_2 = true
      L26_2 = true
      L27_2 = 2
      L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2)
    end
    L2_2 = util
    L2_2 = L2_2.yield
    L3_2 = 100
    L2_2(L3_2)
    L2_2 = 1
    L3_2 = 25
    L4_2 = 1
    for L5_2 = L2_2, L3_2, L4_2 do
      L6_2 = ENTITY
      L6_2 = L6_2.SET_ENTITY_COORDS_NO_OFFSET
      L7_2 = L0_2
      L8_2 = math
      L8_2 = L8_2.random
      L9_2 = 0
      L10_2 = 2555
      L8_2 = L8_2(L9_2, L10_2)
      L9_2 = math
      L9_2 = L9_2.random
      L10_2 = 0
      L11_2 = 2815
      L9_2 = L9_2(L10_2, L11_2)
      L10_2 = math
      L10_2 = L10_2.random
      L11_2 = 1
      L12_2 = 1232
      L10_2 = L10_2(L11_2, L12_2)
      L11_2 = false
      L12_2 = false
      L13_2 = false
      L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
      L6_2 = util
      L6_2 = L6_2.yield
      L6_2()
    end
  else
    L0_2 = request_model
    L1_2 = util
    L1_2 = L1_2.joaat
    L2_2 = "hydra"
    L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2 = L1_2(L2_2)
    L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2)
    L0_2 = entities
    L0_2 = L0_2.create_vehicle
    L1_2 = util
    L1_2 = L1_2.joaat
    L2_2 = "hydra"
    L1_2 = L1_2(L2_2)
    L2_2 = ENTITY
    L2_2 = L2_2.GET_ENTITY_COORDS
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2 = L3_2()
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2, L24_2, L25_2, L26_2, L27_2)
    L3_2 = 0.0
    L0_2 = L0_2(L1_2, L2_2, L3_2)
    L1_2 = PED
    L1_2 = L1_2.SET_PED_INTO_VEHICLE
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = L0_2
    L4_2 = -1
    L1_2(L2_2, L3_2, L4_2)
  end
end
L111_1[L112_1] = L113_1
L111_1 = _ENV
L112_1 = "bitTest"
function L113_1(A0_2, A1_2)
  local L2_2, L3_2
  L2_2 = memory
  L2_2 = L2_2.read_int
  L3_2 = A0_2
  L2_2 = L2_2(L3_2)
  L3_2 = 1 << A1_2
  L2_2 = L2_2 & L3_2
  L2_2 = 0 ~= L2_2
  return L2_2
end
L111_1[L112_1] = L113_1
L111_1 = _ENV
L112_1 = "reclaimVehicles"
function L113_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = memory
  L0_2 = L0_2.read_int
  L1_2 = memory
  L1_2 = L1_2.script_global
  L2_2 = 1586488
  L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2 = L1_2(L2_2)
  L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  L1_2 = 0
  L2_2 = L0_2
  L3_2 = 1
  for L4_2 = L1_2, L2_2, L3_2 do
    L5_2 = bitTest
    L6_2 = memory
    L6_2 = L6_2.script_global
    L7_2 = L4_2 * 142
    L7_2 = 1586489 + L7_2
    L7_2 = L7_2 + 103
    L6_2 = L6_2(L7_2)
    L7_2 = 1
    L5_2 = L5_2(L6_2, L7_2)
    if L5_2 then
      L5_2 = bitTest
      L6_2 = memory
      L6_2 = L6_2.script_global
      L7_2 = L4_2 * 142
      L7_2 = 1586489 + L7_2
      L7_2 = L7_2 + 103
      L6_2 = L6_2(L7_2)
      L7_2 = 2
      L5_2 = L5_2(L6_2, L7_2)
    end
    if L5_2 then
      L6_2 = MISC
      L6_2 = L6_2.CLEAR_BIT
      L7_2 = memory
      L7_2 = L7_2.script_global
      L8_2 = L4_2 * 142
      L8_2 = 1586489 + L8_2
      L8_2 = L8_2 + 103
      L7_2 = L7_2(L8_2)
      L8_2 = 1
      L6_2(L7_2, L8_2)
      L6_2 = MISC
      L6_2 = L6_2.CLEAR_BIT
      L7_2 = memory
      L7_2 = L7_2.script_global
      L8_2 = L4_2 * 142
      L8_2 = 1586489 + L8_2
      L8_2 = L8_2 + 103
      L7_2 = L7_2(L8_2)
      L8_2 = 3
      L6_2(L7_2, L8_2)
      L6_2 = MISC
      L6_2 = L6_2.CLEAR_BIT
      L7_2 = memory
      L7_2 = L7_2.script_global
      L8_2 = L4_2 * 142
      L8_2 = 1586489 + L8_2
      L8_2 = L8_2 + 103
      L7_2 = L7_2(L8_2)
      L8_2 = 16
      L6_2(L7_2, L8_2)
      L6_2 = notification
      L7_2 = "~bold~~y~索赔完成"
      L8_2 = HudColour
      L8_2 = L8_2.blue
      L6_2(L7_2, L8_2)
    end
  end
end
L111_1[L112_1] = L113_1
L111_1 = _ENV
L112_1 = "flying_broom"
function L113_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2
  L0_2 = ENTITY
  L0_2 = L0_2.GET_ENTITY_COORDS
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = false
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = util
  L1_2 = L1_2.joaat
  L2_2 = "prop_tool_broom"
  L1_2 = L1_2(L2_2)
  L2_2 = util
  L2_2 = L2_2.joaat
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
  L5_2 = ENTITY
  L5_2 = L5_2.SET_ENTITY_VISIBLE
  L6_2 = L4_2
  L7_2 = false
  L8_2 = false
  L5_2(L6_2, L7_2, L8_2)
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
  L9_2 = 0
  L10_2 = 0
  L11_2 = 0.3
  L12_2 = -80.0
  L13_2 = 0
  L14_2 = 0
  L15_2 = true
  L16_2 = false
  L17_2 = false
  L18_2 = false
  L19_2 = 0
  L20_2 = true
  L21_2 = 0
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
end
L111_1[L112_1] = L113_1
L111_1 = _ENV
L112_1 = "detach_all_entities"
function L113_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L0_2 = entities
  L0_2 = L0_2.get_all_vehicles_as_handles
  L0_2 = L0_2()
  L1_2 = entities
  L1_2 = L1_2.get_all_objects_as_handles
  L1_2 = L1_2()
  L2_2 = entities
  L2_2 = L2_2.get_all_peds_as_handles
  L2_2 = L2_2()
  L3_2 = pairs
  L4_2 = L0_2
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = ENTITY
    L9_2 = L9_2.IS_ENTITY_ATTACHED
    L10_2 = L8_2
    L9_2 = L9_2(L10_2)
    if L9_2 then
      L9_2 = request_control
      L10_2 = L8_2
      L9_2(L10_2)
      L9_2 = ENTITY
      L9_2 = L9_2.DETACH_ENTITY
      L10_2 = L8_2
      L11_2 = false
      L12_2 = false
      L9_2(L10_2, L11_2, L12_2)
      L9_2 = ENTITY
      L9_2 = L9_2.SET_ENTITY_COLLISION
      L10_2 = L8_2
      L11_2 = false
      L12_2 = true
      L9_2(L10_2, L11_2, L12_2)
    end
  end
  L3_2 = pairs
  L4_2 = L1_2
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = ENTITY
    L9_2 = L9_2.IS_ENTITY_ATTACHED
    L10_2 = L8_2
    L9_2 = L9_2(L10_2)
    if L9_2 then
      L9_2 = request_control
      L10_2 = L8_2
      L9_2(L10_2)
      L9_2 = ENTITY
      L9_2 = L9_2.DETACH_ENTITY
      L10_2 = L8_2
      L11_2 = false
      L12_2 = false
      L9_2(L10_2, L11_2, L12_2)
      L9_2 = ENTITY
      L9_2 = L9_2.SET_ENTITY_COLLISION
      L10_2 = L8_2
      L11_2 = false
      L12_2 = true
      L9_2(L10_2, L11_2, L12_2)
    end
  end
  L3_2 = pairs
  L4_2 = L2_2
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    L9_2 = ENTITY
    L9_2 = L9_2.IS_ENTITY_ATTACHED
    L10_2 = L8_2
    L9_2 = L9_2(L10_2)
    if L9_2 then
      L9_2 = request_control
      L10_2 = L8_2
      L9_2(L10_2)
      L9_2 = ENTITY
      L9_2 = L9_2.DETACH_ENTITY
      L10_2 = L8_2
      L11_2 = false
      L12_2 = false
      L9_2(L10_2, L11_2, L12_2)
      L9_2 = ENTITY
      L9_2 = L9_2.SET_ENTITY_COLLISION
      L10_2 = L8_2
      L11_2 = false
      L12_2 = true
      L9_2(L10_2, L11_2, L12_2)
    end
  end
end
L111_1[L112_1] = L113_1
L111_1 = _ENV
L112_1 = "Block_attached_models"
function L113_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L0_2 = PED
  L0_2 = L0_2.GET_VEHICLE_PED_IS_IN
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = false
  L0_2 = L0_2(L1_2, L2_2)
  L1_2 = entities
  L1_2 = L1_2.get_all_vehicles_as_handles
  L1_2 = L1_2()
  L2_2 = entities
  L2_2 = L2_2.get_all_objects_as_handles
  L2_2 = L2_2()
  L3_2 = entities
  L3_2 = L3_2.get_all_peds_as_handles
  L3_2 = L3_2()
  L4_2 = pairs
  L5_2 = L1_2
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
    L10_2 = ENTITY
    L10_2 = L10_2.IS_ENTITY_ATTACHED_TO_ENTITY
    L11_2 = L9_2
    L12_2 = L0_2
    L10_2 = L10_2(L11_2, L12_2)
    if L10_2 then
      L10_2 = request_control
      L11_2 = L9_2
      L10_2(L11_2)
      L10_2 = ENTITY
      L10_2 = L10_2.DETACH_ENTITY
      L11_2 = L9_2
      L12_2 = false
      L13_2 = false
      L10_2(L11_2, L12_2, L13_2)
      L10_2 = ENTITY
      L10_2 = L10_2.SET_ENTITY_COLLISION
      L11_2 = L9_2
      L12_2 = false
      L13_2 = true
      L10_2(L11_2, L12_2, L13_2)
    end
  end
  L4_2 = pairs
  L5_2 = L2_2
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
    L10_2 = ENTITY
    L10_2 = L10_2.IS_ENTITY_ATTACHED_TO_ENTITY
    L11_2 = L9_2
    L12_2 = L0_2
    L10_2 = L10_2(L11_2, L12_2)
    if L10_2 then
      L10_2 = request_control
      L11_2 = L9_2
      L10_2(L11_2)
      L10_2 = ENTITY
      L10_2 = L10_2.DETACH_ENTITY
      L11_2 = L9_2
      L12_2 = false
      L13_2 = false
      L10_2(L11_2, L12_2, L13_2)
      L10_2 = ENTITY
      L10_2 = L10_2.SET_ENTITY_COLLISION
      L11_2 = L9_2
      L12_2 = false
      L13_2 = true
      L10_2(L11_2, L12_2, L13_2)
    end
  end
  L4_2 = pairs
  L5_2 = L3_2
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
    L10_2 = ENTITY
    L10_2 = L10_2.IS_ENTITY_ATTACHED_TO_ENTITY
    L11_2 = L9_2
    L12_2 = L0_2
    L10_2 = L10_2(L11_2, L12_2)
    if L10_2 then
      L10_2 = request_control
      L11_2 = L9_2
      L10_2(L11_2)
      L10_2 = ENTITY
      L10_2 = L10_2.DETACH_ENTITY
      L11_2 = L9_2
      L12_2 = false
      L13_2 = false
      L10_2(L11_2, L12_2, L13_2)
      L10_2 = ENTITY
      L10_2 = L10_2.SET_ENTITY_COLLISION
      L11_2 = L9_2
      L12_2 = false
      L13_2 = true
      L10_2(L11_2, L12_2, L13_2)
    end
  end
end
L111_1[L112_1] = L113_1
L111_1 = _ENV
L112_1 = "menu"
L111_1 = L111_1[L112_1]
L112_1 = "ref_by_path"
L111_1 = L111_1[L112_1]
L112_1 = "Game>Rendering>Thermal Vision"
L111_1 = L111_1(L112_1)
L112_1 = _ENV
L113_1 = "thermalgun"
function L114_1()
  local L0_2, L1_2, L2_2, L3_2
  L0_2 = PLAYER
  L0_2 = L0_2.IS_PLAYER_FREE_AIMING
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_ID
  L1_2, L2_2, L3_2 = L1_2()
  L0_2 = L0_2(L1_2, L2_2, L3_2)
  L1_2 = GRAPHICS
  L1_2 = L1_2.GET_USINGSEETHROUGH
  L1_2 = L1_2()
  if L1_2 and not L0_2 then
    L1_2 = menu
    L1_2 = L1_2.trigger_command
    L2_2 = L111_1
    L3_2 = "off"
    L1_2(L2_2, L3_2)
    L1_2 = GRAPHICS1
    L1_2 = L1_2._SEETHROUGH_SET_MAX_THICKNESS
    L2_2 = 1
    L1_2(L2_2)
  else
    L1_2 = PAD
    L1_2 = L1_2.IS_CONTROL_JUST_PRESSED
    L2_2 = 38
    L3_2 = 38
    L1_2 = L1_2(L2_2, L3_2)
    if L1_2 then
      L1_2 = menu
      L1_2 = L1_2.get_value
      L2_2 = L111_1
      L1_2 = L1_2(L2_2)
      if L1_2 or not L0_2 then
        L1_2 = menu
        L1_2 = L1_2.trigger_command
        L2_2 = L111_1
        L3_2 = "off"
        L1_2(L2_2, L3_2)
        L1_2 = GRAPHICS1
        L1_2 = L1_2._SEETHROUGH_SET_MAX_THICKNESS
        L2_2 = 1
        L1_2(L2_2)
      else
        L1_2 = menu
        L1_2 = L1_2.trigger_command
        L2_2 = L111_1
        L3_2 = "on"
        L1_2(L2_2, L3_2)
        L1_2 = GRAPHICS1
        L1_2 = L1_2._SEETHROUGH_SET_MAX_THICKNESS
        L2_2 = 50
        L1_2(L2_2)
      end
    end
  end
end
L112_1[L113_1] = L114_1
L112_1 = _ENV
L113_1 = "elqss"
function L114_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2
  if A0_2 then
    L1_2 = notification
    L2_2 = "~bold~~y~按E使用战车技能"
    L3_2 = HudColour
    L3_2 = L3_2.blue
    L1_2(L2_2, L3_2)
    L1_2 = ENTITY
    L1_2 = L1_2.GET_ENTITY_COORDS
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2 = L2_2()
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
    L2_2 = 1491277511
    L3_2 = 1793667637
    L4_2 = request_model
    L5_2 = L2_2
    L4_2(L5_2)
    L4_2 = request_model
    L5_2 = L3_2
    L4_2(L5_2)
    L4_2 = entities
    L4_2 = L4_2.create_vehicle
    L5_2 = 1491277511
    L6_2 = L1_2
    L7_2 = 0
    L4_2 = L4_2(L5_2, L6_2, L7_2)
    ghost_car = L4_2
    L4_2 = ENTITY
    L4_2 = L4_2.SET_ENTITY_INVINCIBLE
    L5_2 = ghost_car
    L6_2 = true
    L4_2(L5_2, L6_2)
    L4_2 = OBJECT
    L4_2 = L4_2.CREATE_OBJECT
    L5_2 = 1793667637
    L6_2 = L1_2.x
    L7_2 = L1_2.y
    L8_2 = L1_2.z
    L9_2 = true
    L10_2 = false
    L11_2 = true
    L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    ghost_nuts = L4_2
    L4_2 = ENTITY
    L4_2 = L4_2.ATTACH_ENTITY_TO_ENTITY
    L5_2 = ghost_nuts
    L6_2 = ghost_car
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
    L4_2 = "scr_martin1"
    L5_2 = "scr_sol1_plane_engine_fire"
    L6_2 = request_ptfx_asset
    L7_2 = L4_2
    L6_2(L7_2)
    L6_2 = GRAPHICS
    L6_2 = L6_2.USE_PARTICLE_FX_ASSET
    L7_2 = L4_2
    L6_2(L7_2)
    L6_2 = GRAPHICS
    L6_2 = L6_2.START_PARTICLE_FX_LOOPED_ON_ENTITY
    L7_2 = L5_2
    L8_2 = ghost_nuts
    L9_2 = 0
    L10_2 = 0.1
    L11_2 = -0.3
    L12_2 = 180
    L13_2 = 0
    L14_2 = 0
    L15_2 = 0.5
    L16_2 = 1
    L17_2 = 1
    L18_2 = 1
    L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L6_2 = SYSTEM
    L6_2 = L6_2.WAIT
    L7_2 = 500
    L6_2(L7_2)
    L6_2 = PED
    L6_2 = L6_2.SET_PED_INTO_VEHICLE
    L7_2 = PLAYER
    L7_2 = L7_2.PLAYER_PED_ID
    L7_2 = L7_2()
    L8_2 = ghost_car
    L9_2 = -1
    L6_2(L7_2, L8_2, L9_2)
    while true do
      L6_2 = ghost_car
      if not L6_2 then
        break
      end
      L6_2 = PAD
      L6_2 = L6_2.IS_CONTROL_PRESSED
      L7_2 = 0
      L8_2 = 46
      L6_2 = L6_2(L7_2, L8_2)
      if L6_2 then
        L6_2 = "weap_xs_vehicle_weapons"
        L7_2 = "muz_xs_turret_flamethrower_looping"
        L8_2 = request_ptfx_asset
        L9_2 = L6_2
        L8_2(L9_2)
        L8_2 = GRAPHICS
        L8_2 = L8_2.USE_PARTICLE_FX_ASSET
        L9_2 = L6_2
        L8_2(L9_2)
        L8_2 = GRAPHICS
        L8_2 = L8_2.START_PARTICLE_FX_LOOPED_ON_ENTITY
        L9_2 = L7_2
        L10_2 = ghost_car
        L11_2 = 0
        L12_2 = 1
        L13_2 = 0.5
        L14_2 = 180
        L15_2 = 0
        L16_2 = 0
        L17_2 = 1
        L18_2 = 1
        L19_2 = 1
        L20_2 = 1
        L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
        L8_2 = util
        L8_2 = L8_2.yield
        L9_2 = 500
        L8_2(L9_2)
      else
        L6_2 = GRAPHICS
        L6_2 = L6_2.REMOVE_PARTICLE_FX_FROM_ENTITY
        L7_2 = ghost_car
        L6_2(L7_2)
      end
      L6_2 = util
      L6_2 = L6_2.yield
      L6_2()
    end
  else
    L1_2 = ENTITY
    L1_2 = L1_2.DOES_ENTITY_EXIST
    L2_2 = ghost_car
    L1_2 = L1_2(L2_2)
    if L1_2 then
      L1_2 = ENTITY
      L1_2 = L1_2.DOES_ENTITY_EXIST
      L2_2 = ghost_nuts
      L1_2 = L1_2(L2_2)
      if L1_2 then
        L1_2 = delete_entity
        L2_2 = ghost_car
        L1_2(L2_2)
        L1_2 = delete_entity
        L2_2 = ghost_nuts
        L1_2(L2_2)
      end
    end
  end
end
L112_1[L113_1] = L114_1
L112_1 = _ENV
L113_1 = "Colour"
L114_1 = {}
L112_1[L113_1] = L114_1
L112_1 = _ENV
L113_1 = "Colour"
L112_1 = L112_1[L113_1]
L113_1 = "new"
function L114_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2
  L4_2 = {}
  L5_2 = A0_2 or L5_2
  if not A0_2 then
    L5_2 = 0
  end
  L4_2.r = L5_2
  L5_2 = A1_2 or L5_2
  if not A1_2 then
    L5_2 = 0
  end
  L4_2.g = L5_2
  L5_2 = A2_2 or L5_2
  if not A2_2 then
    L5_2 = 0
  end
  L4_2.b = L5_2
  L5_2 = A3_2 or L5_2
  if not A3_2 then
    L5_2 = 0
  end
  L4_2.a = L5_2
  return L4_2
end
L112_1[L113_1] = L114_1
L112_1 = _ENV
L113_1 = "personllight"
function L114_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
  L0_2 = PLAYER
  L0_2 = L0_2.PLAYER_PED_ID
  L0_2 = L0_2()
  L1_2 = Effect
  L1_2 = L1_2.new
  L2_2 = "scr_xm_farm"
  L3_2 = "scr_xm_dst_elec_crackle"
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = Effect
  L2_2 = L2_2.new
  L3_2 = "scr_ie_tw"
  L4_2 = "scr_impexp_tw_take_zone"
  L2_2 = L2_2(L3_2, L4_2)
  L3_2 = Colour
  L3_2 = L3_2.new
  L4_2 = 5
  L5_2 = 0
  L6_2 = 0
  L7_2 = 30
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
  L4_2 = Colour
  L4_2 = L4_2.new
  L5_2 = 5
  L6_2 = 50
  L7_2 = 10
  L8_2 = 30
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
  L5_2 = request_ptfx_asset
  L6_2 = L2_2.asset
  L5_2(L6_2)
  L5_2 = GRAPHICS
  L5_2 = L5_2.USE_PARTICLE_FX_ASSET
  L6_2 = L2_2.asset
  L5_2(L6_2)
  L5_2 = GRAPHICS
  L5_2 = L5_2.SET_PARTICLE_FX_NON_LOOPED_COLOUR
  L6_2 = L3_2.r
  L7_2 = L3_2.g
  L8_2 = L3_2.b
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = GRAPHICS
  L6_2 = "START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY"
  L5_2 = L5_2[L6_2]
  L6_2 = L2_2.name
  L7_2 = L0_2
  L8_2 = 0.0
  L9_2 = 0.0
  L10_2 = 0.75
  L11_2 = 0.0
  L12_2 = 0.0
  L13_2 = 0.0
  L14_2 = 0.09
  L15_2 = false
  L16_2 = false
  L17_2 = false
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
  L5_2 = GRAPHICS
  L5_2 = L5_2.USE_PARTICLE_FX_ASSET
  L6_2 = L2_2.asset
  L5_2(L6_2)
  L5_2 = GRAPHICS
  L5_2 = L5_2.SET_PARTICLE_FX_NON_LOOPED_COLOUR
  L6_2 = L4_2.r
  L7_2 = L4_2.g
  L8_2 = L4_2.b
  L5_2(L6_2, L7_2, L8_2)
  L5_2 = GRAPHICS
  L6_2 = "START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY"
  L5_2 = L5_2[L6_2]
  L6_2 = L2_2.name
  L7_2 = L0_2
  L8_2 = 0.0
  L9_2 = 0.0
  L10_2 = -2.9
  L11_2 = 0.0
  L12_2 = 0.0
  L13_2 = 0.0
  L14_2 = 1.0
  L15_2 = false
  L16_2 = false
  L17_2 = false
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
end
L112_1[L113_1] = L114_1
L112_1 = "missfbi3ig_0"
L113_1 = _ENV
L114_1 = "util"
L113_1 = L113_1[L114_1]
L114_1 = "joaat"
L113_1 = L113_1[L114_1]
L114_1 = "prop_big_shit_02"
L113_1 = L113_1(L114_1)
L114_1 = "switch@trevor@jerking_off"
L115_1 = _ENV
L116_1 = "util"
L115_1 = L115_1[L116_1]
L116_1 = "joaat"
L115_1 = L115_1[L116_1]
L116_1 = "p_oil_slick_01"
L115_1 = L115_1(L116_1)
L116_1 = "trev_jerking_off_loop"
L117_1 = "shit_loop_trev"
L118_1 = _ENV
L119_1 = "personlshit"
function L120_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L0_2 = "missfbi3ig_0"
  L1_2 = "shit_loop_trev"
  L2_2 = MISC
  L2_2 = L2_2.GET_HASH_KEY
  L3_2 = "prop_big_shit_02"
  L2_2 = L2_2(L3_2)
  L3_2 = ENTITY
  L3_2 = L3_2.GET_ENTITY_COORDS
  L4_2 = PLAYER
  L4_2 = L4_2.PLAYER_PED_ID
  L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L4_2()
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  L4_2 = request_anim_dict
  L5_2 = L0_2
  L4_2(L5_2)
  L4_2 = TASK
  L4_2 = L4_2.TASK_PLAY_ANIM
  L5_2 = PLAYER
  L5_2 = L5_2.PLAYER_PED_ID
  L5_2 = L5_2()
  L6_2 = L0_2
  L7_2 = L1_2
  L8_2 = 8.0
  L9_2 = 8.0
  L10_2 = 3000
  L11_2 = 0
  L12_2 = 0
  L13_2 = true
  L14_2 = true
  L15_2 = true
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  L4_2 = util
  L4_2 = L4_2.yield
  L5_2 = 1000
  L4_2(L5_2)
  L4_2 = create_object
  L5_2 = L2_2
  L6_2 = L3_2.x
  L7_2 = L3_2.y
  L8_2 = L3_2.z
  L8_2 = L8_2 - 1
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
end
L118_1[L119_1] = L120_1
L118_1 = _ENV
L119_1 = "personlhitplane"
function L120_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
  L0_2 = "switch@trevor@jerking_off"
  L1_2 = "trev_jerking_off_loop"
  L2_2 = MISC
  L2_2 = L2_2.GET_HASH_KEY
  L3_2 = "p_oil_slick_01"
  L2_2 = L2_2(L3_2)
  L3_2 = ENTITY
  L3_2 = L3_2.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS
  L4_2 = PLAYER
  L4_2 = L4_2.PLAYER_PED_ID
  L4_2 = L4_2()
  L5_2 = 0
  L6_2 = 1
  L7_2 = 0
  L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
  L4_2 = request_anim_dict
  L5_2 = L0_2
  L4_2(L5_2)
  L4_2 = TASK
  L4_2 = L4_2.TASK_PLAY_ANIM
  L5_2 = PLAYER
  L5_2 = L5_2.PLAYER_PED_ID
  L5_2 = L5_2()
  L6_2 = L0_2
  L7_2 = L1_2
  L8_2 = 8.0
  L9_2 = 8.0
  L10_2 = 5000
  L11_2 = 1
  L12_2 = 0
  L13_2 = true
  L14_2 = true
  L15_2 = true
  L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
  L4_2 = util
  L4_2 = L4_2.yield
  L5_2 = 4500
  L4_2(L5_2)
  L4_2 = create_object
  L5_2 = L2_2
  L6_2 = L3_2.x
  L7_2 = L3_2.y
  L8_2 = L3_2.z
  L8_2 = L8_2 - 1
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2)
end
L118_1[L119_1] = L120_1
L118_1 = 2
L119_1 = _ENV
L120_1 = "autoExplodeStickys"
function L121_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = ENTITY
  L1_2 = L1_2.GET_ENTITY_COORDS
  L2_2 = A0_2
  L3_2 = true
  L1_2 = L1_2(L2_2, L3_2)
  L2_2 = MISC
  L2_2 = L2_2.IS_PROJECTILE_TYPE_WITHIN_DISTANCE
  L3_2 = L1_2.x
  L4_2 = L1_2.y
  L5_2 = L1_2.z
  L6_2 = util
  L6_2 = L6_2.joaat
  L7_2 = "weapon_stickybomb"
  L6_2 = L6_2(L7_2)
  L7_2 = L118_1
  L8_2 = true
  L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  if L2_2 then
    L2_2 = WEAPON
    L2_2 = L2_2.EXPLODE_PROJECTILES
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2 = L3_2()
    L4_2 = util
    L4_2 = L4_2.joaat
    L5_2 = "weapon_stickybomb"
    L4_2, L5_2, L6_2, L7_2, L8_2 = L4_2(L5_2)
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2)
  end
end
L119_1[L120_1] = L121_1
L119_1 = _ENV
L120_1 = "proxyStickys"
function L121_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L0_2 = detonate_players
  if L0_2 then
    L0_2 = {}
    L0_2.user = false
    L1_2 = whitelistGroups
    L1_2 = L1_2.friends
    L0_2.friends = L1_2
    L1_2 = whitelistGroups
    L1_2 = L1_2.strangers
    L0_2.strangers = L1_2
    L1_2 = getNonWhitelistedPlayers
    L2_2 = whitelistListTable
    L3_2 = L0_2
    L4_2 = whitelistedName
    L1_2 = L1_2(L2_2, L3_2, L4_2)
    L2_2 = pairs
    L3_2 = L1_2
    L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
    for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
      L8_2 = PLAYER
      L8_2 = L8_2.GET_PLAYER_PED_SCRIPT_INDEX
      L9_2 = L7_2
      L8_2 = L8_2(L9_2)
      L9_2 = autoExplodeStickys
      L10_2 = L8_2
      L9_2(L10_2)
    end
  end
  L0_2 = detonate_npcs
  if L0_2 then
    L0_2 = entities
    L0_2 = L0_2.get_all_peds_as_handles
    L0_2 = L0_2()
    L1_2 = pairs
    L2_2 = L0_2
    L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
    for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
      L7_2 = PED
      L7_2 = L7_2.IS_PED_A_PLAYER
      L8_2 = L6_2
      L7_2 = L7_2(L8_2)
      if not L7_2 then
        L7_2 = autoExplodeStickys
        L8_2 = L6_2
        L7_2(L8_2)
      end
    end
  end
end
L119_1[L120_1] = L121_1
L119_1 = _ENV
L120_1 = "vehicle_speedometer"
function L121_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  speedm = A0_2
  while true do
    L1_2 = speedm
    if not L1_2 then
      break
    end
    L1_2 = nil
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2 = L2_2()
    L3_2 = PED
    L3_2 = L3_2.GET_VEHICLE_PED_IS_USING
    L4_2 = PLAYER
    L4_2 = L4_2.PLAYER_PED_ID
    L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L4_2()
    L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    L4_2 = PED
    L4_2 = L4_2.IS_PED_IN_ANY_VEHICLE
    L5_2 = L2_2
    L6_2 = true
    L4_2 = L4_2(L5_2, L6_2)
    if L4_2 then
      L1_2 = L3_2
    else
      L1_2 = L2_2
    end
    L4_2 = ENTITY
    L4_2 = L4_2.GET_ENTITY_SPEED
    L5_2 = L1_2
    L4_2 = L4_2(L5_2)
    L5_2 = L4_2 * 3.6
    L6_2 = math
    L6_2 = L6_2.ceil
    L7_2 = L5_2
    L6_2 = L6_2(L7_2)
    myspeed1 = L6_2
    L6_2 = util
    L6_2 = L6_2.yield
    L6_2()
    L6_2 = draw_string
    L7_2 = string
    L7_2 = L7_2.format
    L8_2 = "~bold~~italic~~o~"
    L9_2 = myspeed1
    L10_2 = "  ~w~KM/H"
    L8_2 = L8_2 .. L9_2 .. L10_2
    L7_2 = L7_2(L8_2)
    L8_2 = 0.76
    L9_2 = 0.8
    L10_2 = 1
    L11_2 = 6
    L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
  end
end
L119_1[L120_1] = L121_1
L119_1 = false
L120_1 = _ENV
L121_1 = "tripped1"
function L122_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  if A0_2 then
    L1_2 = ENTITY
    L1_2 = L1_2.GET_ENTITY_FORWARD_VECTOR
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2 = L2_2()
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
    L2_2 = PED
    L2_2 = L2_2.SET_PED_TO_RAGDOLL_WITH_FALL
    L3_2 = PLAYER
    L3_2 = L3_2.PLAYER_PED_ID
    L3_2 = L3_2()
    L4_2 = 1500
    L5_2 = 2000
    L6_2 = 2
    L7_2 = L1_2.x
    L8_2 = L1_2.y
    L8_2 = -L8_2
    L9_2 = L1_2.z
    L10_2 = 1
    L11_2 = 0
    L12_2 = 0
    L13_2 = 0
    L14_2 = 0
    L15_2 = 0
    L16_2 = 0
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
  end
  L119_1 = A0_2
  while true do
    L1_2 = L119_1
    if not L1_2 then
      break
    end
    L1_2 = PED
    L1_2 = L1_2.RESET_PED_RAGDOLL_TIMER
    L2_2 = PLAYER
    L2_2 = L2_2.PLAYER_PED_ID
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2 = L2_2()
    L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
    L1_2 = util
    L1_2 = L1_2.yield_once
    L1_2()
  end
end
L120_1[L121_1] = L122_1
L120_1 = _ENV
L121_1 = "tripped2"
function L122_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L0_2 = PED
  L0_2 = L0_2.SET_PED_TO_RAGDOLL
  L1_2 = PLAYER
  L1_2 = L1_2.PLAYER_PED_ID
  L1_2 = L1_2()
  L2_2 = 2000
  L3_2 = 2000
  L4_2 = 0
  L5_2 = true
  L6_2 = true
  L7_2 = true
  L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2)
end
L120_1[L121_1] = L122_1
