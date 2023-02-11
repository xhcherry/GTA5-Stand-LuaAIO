----载具
VEHICLE1={
["SET_VEHICLE_ON_GROUND_PROPERLY"]=function(...)return native_invoker.uno_bool(0x49733E92263139D1,...)end,
}
-----武器
WEAPON1={
    ["GET_WEAPON_TIME_BETWEEN_SHOTS"]=function(...)return native_invoker.uno_float(0x065D2AACAD8CF7A4,...)end,
}
-----实体
ENTITY1={
    ["ATTACH_ENTITY_BONE_TO_ENTITY_BONE_Y_FORWARD"]=--[[void]] function(--[[Entity (int)]] entity1,--[[Entity (int)]] entity2,--[[int]] boneIndex1,--[[int]] boneIndex2,--[[BOOL (bool)]] p4,--[[BOOL (bool)]] p5)native_invoker.begin_call()native_invoker.push_arg_int(entity1)native_invoker.push_arg_int(entity2)native_invoker.push_arg_int(boneIndex1)native_invoker.push_arg_int(boneIndex2)native_invoker.push_arg_bool(p4)native_invoker.push_arg_bool(p5)native_invoker.end_call_2(0xFD1695C5D3B05439)end,
    ["GET_ENTITY_BONE_POSTION"]=function(...)return native_invoker.uno_vector3(0x46F8696933A63C9B,...)end,

}
-----杂项
MISC1={
    ["SHOOT_SINGLE_BULLET_BETWEEN_COORDS"]=function(...)return native_invoker.uno_void(0x867654CBC7606F2C,...)end,
}
-----pad
PADdaidai={
    ["SET_CONTROL_VALUE_NEXT_FRAME"]=function(...)return native_invoker.uno_bool(0xE8A25867FBA3B05E,...)end,
}
NETWORKdaidai={
    ["NETWORK_GET_AVERAGE_LATENCY"]=function(...)return native_invoker.uno_float(0xD414BE129BB81B32,...)end,
}
GRAPHICSdaidai={
    ["DRAW_SPOT_LIGHT"]=function(...)return native_invoker.uno_void(0xD0F64B265C8C8B33,...)end,
}
CAMdaidai={
    ["HARD_ATTACH_CAM_TO_ENTITY"]=--[[void]] function(--[[Cam (int)]] cam,--[[Entity (int)]] entity,--[[float]] xRot,--[[float]] yRot,--[[float]] zRot,--[[float]] xOffset,--[[float]] yOffset,--[[float]] zOffset,--[[BOOL (bool)]] isRelative)native_invoker.begin_call()native_invoker.push_arg_int(cam)native_invoker.push_arg_int(entity)native_invoker.push_arg_float(xRot)native_invoker.push_arg_float(yRot)native_invoker.push_arg_float(zRot)native_invoker.push_arg_float(xOffset)native_invoker.push_arg_float(yOffset)native_invoker.push_arg_float(zOffset)native_invoker.push_arg_bool(isRelative)native_invoker.end_call_2(0x202A5ED9CE01D6E7)end,
}
HUDdaidai={
    ["HUD_SUPPRESS_WEAPON_WHEEL_RESULTS_THIS_FRAME"]=--[[void]] function()native_invoker.begin_call()native_invoker.end_call_2(0x0AFC4AF510774B47)end,
}