AUDIO1={
    ["SET_PED_AUDIO_FOOTSTEP_LOUD"]=--[[void]] function(--[[Ped (int)]] ped,--[[BOOL (bool)]] toggle)native_invoker.begin_call();native_invoker.push_arg_int(ped);native_invoker.push_arg_bool(toggle);native_invoker.end_call("0653B735BFBDFE87");end,
}

VEHICLE1={
    ["_SET_VEHICLE_CAN_BE_LOCKED_ON"]=--[[void]] function(--[[Vehicle (int)]] vehicle,--[[BOOL (bool)]] canBeLockedOn,--[[BOOL (bool)]] unk)native_invoker.begin_call()native_invoker.push_arg_int(vehicle)native_invoker.push_arg_bool(canBeLockedOn)native_invoker.push_arg_bool(unk)native_invoker.end_call_2(0x1DDA078D12879EEE)end,
    ["_SET_VEHICLE_REDUCE_TRACTION"]=--[[void]] function(--[[Vehicle (int)]] vehicle,--[[int]] val)native_invoker.begin_call()native_invoker.push_arg_int(vehicle)native_invoker.push_arg_int(val)native_invoker.end_call_2(0x6DEE944E1EE90CFB)end,
    ["_SET_VEHICLE_CONTROLS_INVERTED"]=function(--[[Vehicle (int)]] vehicle,--[[BOOL (bool)]] state)native_invoker.begin_call();native_invoker.push_arg_int(vehicle);native_invoker.push_arg_bool(state);native_invoker.end_call("5B91B229243351A8");end,
    ["SET_VEHICLE_SHOOT_AT_TARGET"]=function(...)return native_invoker.uno_void(0x74CD9A9327A282EA,...)end,
    ["_SET_VEHICLE_XENON_LIGHTS_COLOR"]=--[[void]] function(--[[Vehicle (int)]] vehicle,--[[int]] colorIndex)native_invoker.begin_call();native_invoker.push_arg_int(vehicle);native_invoker.push_arg_int(colorIndex);native_invoker.end_call("E41033B25D003A07");end,
    ["_SET_VEHICLE_NEON_LIGHTS_COLOUR"]=--[[void]] function(--[[Vehicle (int)]] vehicle,--[[int]] r,--[[int]] g,--[[int]] b)native_invoker.begin_call();native_invoker.push_arg_int(vehicle);native_invoker.push_arg_int(r);native_invoker.push_arg_int(g);native_invoker.push_arg_int(b);native_invoker.end_call("8E0A582209A62695");end,
    ["_SET_VEHICLE_PARACHUTE_MODEL"]=--[[void]] function(--[[Vehicle (int)]] vehicle,--[[Hash (int)]] modelHash)native_invoker.begin_call();native_invoker.push_arg_int(vehicle);native_invoker.push_arg_int(modelHash);native_invoker.end_call("4D610C6B56031351");end,
    ["_SET_VEHICLE_PARACHUTE_ACTIVE"]=--[[void]] function(--[[Vehicle (int)]] vehicle,--[[BOOL (bool)]] active)native_invoker.begin_call();native_invoker.push_arg_int(vehicle);native_invoker.push_arg_bool(active);native_invoker.end_call("0BFFB028B3DD0A97");end,
    ["_SET_VEHICLE_DASHBOARD_COLOR"]=--[[void]] function(--[[Vehicle (int)]] vehicle,--[[int]] color)native_invoker.begin_call();native_invoker.push_arg_int(vehicle);native_invoker.push_arg_int(color);native_invoker.end_call("6089CDF6A57F326C");end,
    ["_SET_VEHICLE_INTERIOR_COLOR"]=--[[void]] function(--[[Vehicle (int)]] vehicle,--[[int]] color)native_invoker.begin_call();native_invoker.push_arg_int(vehicle);native_invoker.push_arg_int(color);native_invoker.end_call("F40DD601A65F7F19");end,
    ["_SET_VEHICLE_NEON_LIGHT_ENABLED"]=--[[void]] function(--[[Vehicle (int)]] vehicle,--[[int]] index,--[[BOOL (bool)]] toggle)native_invoker.begin_call();native_invoker.push_arg_int(vehicle);native_invoker.push_arg_int(index);native_invoker.push_arg_bool(toggle);native_invoker.end_call("2AA720E4287BF269");end,
    ["SET_VEHICLE_ON_GROUND_PROPERLY"]=function(...)return native_invoker.uno_bool(0x49733E92263139D1,...)end,
    ["SET_VEHICLE_MAX_SPEED"]=--[[void]] function(--[[Vehicle (int)]] vehicle,--[[float]] speed)native_invoker.begin_call()native_invoker.push_arg_int(vehicle)native_invoker.push_arg_float(speed)native_invoker.end_call_2(0xBAA045B4E42F3C06)end,
    ["SET_OVERRIDE_NITROUS_LEVEL"]=--[[void]] function(--[[Vehicle (int)]] vehicle,--[[BOOL (bool)]] toggle,--[[float]] level,--[[float]] power,--[[float]] rechargeTime,--[[BOOL (bool)]] disableSound)native_invoker.begin_call()native_invoker.push_arg_int(vehicle)native_invoker.push_arg_bool(toggle)native_invoker.push_arg_float(level)native_invoker.push_arg_float(power)native_invoker.push_arg_float(rechargeTime)native_invoker.push_arg_bool(disableSound)native_invoker.end_call_2(0xC8E9B6B71B8E660D)end,
}

WEAPON1={
    ["GET_WEAPON_TIME_BETWEEN_SHOTS"]=function(...)return native_invoker.uno_float(0x065D2AACAD8CF7A4,...)end,
}

ENTITY1={
    ["SET_ENTITY_COORDS_NO_OFFSET"]=function(...)return native_invoker.uno_void(0x239A3351AC1DA385,...)end,
    ["_SET_ENTITY_CLEANUP_BY_ENGINE"]=--[[void]] function(--[[Entity (int)]] entity,--[[BOOL (bool)]] toggle)native_invoker.begin_call();native_invoker.push_arg_int(entity);native_invoker.push_arg_bool(toggle);native_invoker.end_call("3910051CCECDB00C");end,
    ["_ATTACH_ENTITY_BONE_TO_ENTITY_BONE"]=function(--[[Entity (int)]] entity1,--[[Entity (int)]] entity2,--[[int]] boneIndex1,--[[int]] boneIndex2,--[[BOOL (bool)]] p4,--[[BOOL (bool)]] p5)native_invoker.begin_call();native_invoker.push_arg_int(entity1);native_invoker.push_arg_int(entity2);native_invoker.push_arg_int(boneIndex1);native_invoker.push_arg_int(boneIndex2);native_invoker.push_arg_bool(p4);native_invoker.push_arg_bool(p5);native_invoker.end_call("5C48B75732C8456C");end,
    ["DOES_ENTITY_EXIST"]=--[[BOOL (bool)]] function(--[[Entity (int)]] entity)native_invoker.begin_call()native_invoker.push_arg_int(entity)native_invoker.end_call_2(0x7239B21A38F536BA)return native_invoker.get_return_value_bool()end,
    ["_GET_ENTITY_BONE_POSITION_2"]=--[[Vector3 (vector3)]] function(--[[Entity (int)]] entity,--[[int]] boneIndex)native_invoker.begin_call();native_invoker.push_arg_int(entity);native_invoker.push_arg_int(boneIndex);native_invoker.end_call("46F8696933A63C9B");return native_invoker.get_return_value_vector3();end,
    ["SET_ENTITY_COORDS"]=function(...)return native_invoker.uno_void(0x06843DA7060A026B,...)end,
    ["ATTACH_ENTITY_BONE_TO_ENTITY_BONE_Y_FORWARD"]=--[[void]] function(--[[Entity (int)]] entity1,--[[Entity (int)]] entity2,--[[int]] boneIndex1,--[[int]] boneIndex2,--[[BOOL (bool)]] p4,--[[BOOL (bool)]] p5)native_invoker.begin_call()native_invoker.push_arg_int(entity1)native_invoker.push_arg_int(entity2)native_invoker.push_arg_int(boneIndex1)native_invoker.push_arg_int(boneIndex2)native_invoker.push_arg_bool(p4)native_invoker.push_arg_bool(p5)native_invoker.end_call_2(0xFD1695C5D3B05439)end,
    ["GET_ENTITY_BONE_POSTION"]=function(...)return native_invoker.uno_vector3(0x46F8696933A63C9B,...)end,
}

MISC1={
    ["_RESTART_GAME"]=--[[void]] function()native_invoker.begin_call();native_invoker.end_call("E574A662ACAEFBB1");end,
    ["SHOOT_SINGLE_BULLET_BETWEEN_COORDS"]=function(...)return native_invoker.uno_void(0x867654CBC7606F2C,...)end,
}

PAD2={
    ["_SET_CONTROL_NORMAL"]=--[[BOOL (bool)]] function(--[[int]] padIndex,--[[int]] control,--[[float]] amount)native_invoker.begin_call()native_invoker.push_arg_int(padIndex)native_invoker.push_arg_int(control)native_invoker.push_arg_float(amount)native_invoker.end_call_2(0xE8A25867FBA3B05E)return native_invoker.get_return_value_bool()end,
    ["SET_SCALEFORM_MOVIE_AS_NO_LONGER_NEEDED"]=--[[void]] function(--[[int* (pointer)]] scaleformHandle)native_invoker.begin_call()native_invoker.push_arg_pointer(scaleformHandle)native_invoker.end_call_2(0x1D132D614DD86811)end,
    ["GET_CONTROL_GROUP_INSTRUCTIONAL_BUTTON"]=--[[string]] function(--[[int]] padIndex,--[[int]] controlGroup,--[[BOOL (bool)]] p2)native_invoker.begin_call();native_invoker.push_arg_int(padIndex);native_invoker.push_arg_int(controlGroup);native_invoker.push_arg_bool(p2);native_invoker.end_call("80C2FD58D720C801");return native_invoker.get_return_value_string();end,
    ["GET_CONTROL_INSTRUCTIONAL_BUTTON"]=--[[string]] function(--[[int]] padIndex,--[[int]] control,--[[BOOL (bool)]] p2)native_invoker.begin_call();native_invoker.push_arg_int(padIndex);native_invoker.push_arg_int(control);native_invoker.push_arg_bool(p2);native_invoker.end_call("0499D7B09FC9B407");return native_invoker.get_return_value_string();end,
    ["SET_CONTROL_VALUE_NEXT_FRAME"]=function(...)return native_invoker.uno_bool(0xE8A25867FBA3B05E,...)end,
}

PED1={
    ["_SET_PED_HAIR_COLOR"]=--[[void]] function(--[[Ped (int)]] ped,--[[int]] colorID,--[[int]] highlightColorID)native_invoker.begin_call()native_invoker.push_arg_int(ped)native_invoker.push_arg_int(colorID)native_invoker.push_arg_int(highlightColorID)native_invoker.end_call_2(0x4CFFC65454C93A49)end,
    ["CREATE_RANDOM_PED"]=function(...)return native_invoker.uno_int(0xB4AC7D0CF06BFE8F,...)end,
}

NETWORK1={
    ["_NETWORK_SET_ENTITY_INVISIBLE_TO_NETWORK"]=function(--[[Entity (int)]] entity,--[[BOOL (bool)]] toggle)native_invoker.begin_call();native_invoker.push_arg_int(entity);native_invoker.push_arg_bool(toggle);native_invoker.end_call("F1CA12B18AEF5298");end,
    ["_GET_ONLINE_VERSION"]=function()native_invoker.begin_call();native_invoker.end_call("FCA9373EF340AC0A");return native_invoker.get_return_value_string();end,
    ["_NETWORK_GET_AVERAGE_LATENCY_FOR_PLAYER"]=--[[float]] function(--[[Player (int)]] player)native_invoker.begin_call();native_invoker.push_arg_int(player);native_invoker.end_call("D414BE129BB81B32");return native_invoker.get_return_value_float();end,
    ["_SHUTDOWN_AND_LOAD_MOST_RECENT_SAVE"]=--[[BOOL (bool)]] function()native_invoker.begin_call();native_invoker.end_call("9ECA15ADFE141431");return native_invoker.get_return_value_bool();end,
    ["NETWORK_GET_AVERAGE_LATENCY"]=function(...)return native_invoker.uno_float(0xD414BE129BB81B32,...)end,
}

GRAPHICS1={
    ["_DRAW_SPHERE"]=--[[void]] function(--[[float]] x,--[[float]] y,--[[float]] z,--[[float]] radius,--[[int]] red,--[[int]] green,--[[int]] blue,--[[float]] alpha)native_invoker.begin_call();native_invoker.push_arg_float(x);native_invoker.push_arg_float(y);native_invoker.push_arg_float(z);native_invoker.push_arg_float(radius);native_invoker.push_arg_int(red);native_invoker.push_arg_int(green);native_invoker.push_arg_int(blue);native_invoker.push_arg_float(alpha);native_invoker.end_call("799017F9E3B10112");end,
    ["_SET_FORCE_VEHICLE_TRAILS"]=--[[void]] function(--[[BOOL (bool)]] toggle)native_invoker.begin_call();native_invoker.push_arg_bool(toggle);native_invoker.end_call("4CC7F0FEA5283FE0");end,
    ["_SET_FORCE_PED_FOOTSTEPS_TRACKS"]=--[[void]] function(--[[BOOL (bool)]] toggle)native_invoker.begin_call();native_invoker.push_arg_bool(toggle);native_invoker.end_call("AEEDAD1420C65CC0");end,
    ["REQUEST_NAMED_PTFX_ASSET"]=function(...)return native_invoker.uno_void(0xB80D8756B4668AB6,...)end,
    ["DRAW_MARKER"]=function(...)return native_invoker.uno_void(0x28477EC23D892089,...)end,
    ["_SEETHROUGH_SET_MAX_THICKNESS"]=--[[void]] function(--[[float]] thickness)native_invoker.begin_call();native_invoker.push_arg_float(thickness);native_invoker.end_call("0C8FAC83902A62DF");end,
    ["DRAW_SPOT_LIGHT"]=function(...)return native_invoker.uno_void(0xD0F64B265C8C8B33,...)end,
}

CAM1={
    ["_GET_CAM_ACTIVE_VIEW_MODE_CONTEXT"]=--[[int]] function()native_invoker.begin_call();native_invoker.end_call("19CAFA3C87F7C2FF");return native_invoker.get_return_value_int();end,
    ["HARD_ATTACH_CAM_TO_ENTITY"]=--[[void]] function(--[[Cam (int)]] cam,--[[Entity (int)]] entity,--[[float]] xRot,--[[float]] yRot,--[[float]] zRot,--[[float]] xOffset,--[[float]] yOffset,--[[float]] zOffset,--[[BOOL (bool)]] isRelative)native_invoker.begin_call()native_invoker.push_arg_int(cam)native_invoker.push_arg_int(entity)native_invoker.push_arg_float(xRot)native_invoker.push_arg_float(yRot)native_invoker.push_arg_float(zRot)native_invoker.push_arg_float(xOffset)native_invoker.push_arg_float(yOffset)native_invoker.push_arg_float(zOffset)native_invoker.push_arg_bool(isRelative)native_invoker.end_call_2(0x202A5ED9CE01D6E7)end,
}

HUD1={
    ["_SET_MINIMAP_SONAR_ENABLED"]=--[[void]] function(--[[BOOL (bool)]] toggle)native_invoker.begin_call();native_invoker.push_arg_bool(toggle);native_invoker.end_call("6B50FC8749632EC1");end,
    ["_HUD_WEAPON_WHEEL_IGNORE_CONTROL_INPUT"]=--[[void]] function(--[[BOOL (bool)]] toggle)native_invoker.begin_call();native_invoker.push_arg_bool(toggle);native_invoker.end_call("14C9FDCC41F81F63");end,
    ["_THEFEED_SET_NEXT_POST_BACKGROUND_COLOR"]=--[[void]] function(--[[int]] hudColorIndex)native_invoker.begin_call();native_invoker.push_arg_int(hudColorIndex);native_invoker.end_call("92F0DA1E27DB96DC");end,
    ["_HUD_WEAPON_WHEEL_GET_SELECTED_HASH"]=--[[Hash (int)]] function()native_invoker.begin_call();native_invoker.end_call("A48931185F0536FE");return native_invoker.get_return_value_int();end,
    ["HUD_SUPPRESS_WEAPON_WHEEL_RESULTS_THIS_FRAME"]=--[[void]] function()native_invoker.begin_call()native_invoker.end_call_2(0x0AFC4AF510774B47)end,
}

PLAYER1={
    ["_SET_PLAYER_HEALTH_RECHARGE_LIMIT"]=function(--[[Player (int)]] player,--[[float]] limit)native_invoker.begin_call();native_invoker.push_arg_int(player);native_invoker.push_arg_float(limit);native_invoker.end_call("C388A0F065F5BC34");end,
}

TASK1={
    ["TASK_ENTER_VEHICLE"]=function(...)return native_invoker.uno_void(0xC20E50AA46D09CA8,...)end,
    ["TASK_VEHICLE_DRIVE_TO_COORD_LONGRANGE"]=function(...)return native_invoker.uno_void(0x158BB33F920D360C,...)end,
}

NETSHOPPING1={
    ["_NET_GAMESERVER_TRANSFER_WALLET_TO_BANK"]=--[[BOOL (bool)]] function(--[[int]] charSlot,--[[int]] amount)native_invoker.begin_call()native_invoker.push_arg_int(charSlot)native_invoker.push_arg_int(amount)native_invoker.end_call_2(0xC2F7FE5309181C7D)return native_invoker.get_return_value_bool()end,
    ["_NET_GAMESERVER_TRANSFER_BANK_TO_WALLET"]=--[[BOOL (bool)]] function(--[[int]] charSlot,--[[int]] amount)native_invoker.begin_call()native_invoker.push_arg_int(charSlot)native_invoker.push_arg_int(amount)native_invoker.end_call_2(0xD47A2C1BA117471D)return native_invoker.get_return_value_bool()end,
}

SCRIPT1={
    ["TERMINATE_THIS_THREAD"]=--[[void]] function()native_invoker.begin_call()native_invoker.end_call_2(0x1090044AD1DA76FA)end,
    ["REQUEST_SCRIPT"]=function(...)return native_invoker.uno_void(0x6EB5F71AA68F2E8E,...)end,
    ["SET_SCRIPT_AS_NO_LONGER_NEEDED"]=function(...)return native_invoker.uno_void(0xC90D2DCACD56184C,...)end,
    ["HAS_SCRIPT_LOADED"]=function(...)return native_invoker.uno_bool(0xE6CC9F3BA0FB9EF1,...)end,
}