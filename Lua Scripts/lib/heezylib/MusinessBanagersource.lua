--[[ https://imgur.com/a/kchuhXW

Credits:
- https://www.unknowncheats.me/forum/3337151-post1560.html  <3 boredom1234

Script created by ICYPhoenix#0727 and Ren#5219
]]
--util.require_natives(1651208000)
local IS_RELEASE_VERSION <const> = false
local IS_BETA_VERSION <const> = false
local IGNORE_VERSION_DIFFERENCE <const> = false
local THIS_RELEASE_VERSION <const> = "1.0.1"
local STAND_RESOURCE_DIR = filesystem.scripts_dir().."/HeezyScript/"
local MB_RESOUCES_DIR = STAND_RESOURCE_DIR .. "Musiness Banager/"
local MB_TRANSLATIONS_DIR = MB_RESOUCES_DIR .. "Translations/"
local MBPrefix = "[MusinessBanager] "
local og_toast = util.toast
local og_log = util.log
local nullsub = function() --[[util.toast("nullsub")]] end
util.toast = function(str, flag) assert(str != nil, "No string given") if flag ~= nil then og_toast(MBPrefix .. tostring(str), flag) else og_toast(MBPrefix .. tostring(str)) end end
util.log = function(str) assert(str != nil, "No string given") og_log(MBPrefix .. tostring(str)) end
util.yield_x = function(int) for i = 1, int do util.yield() end end -- yields x amount of ticks
local menu, players, entities, directx, util, v3, lang, filesystem, async_http, memory = menu, players, entities, directx, util, v3, lang, filesystem, async_http, memory

--#region natives
-- regex for removing comments in the native arguments: --\[\[(?:(?:\w)|(?:\d)|\*)*(?: \((?:(?:\w)|(?:\d)|\*)*\))*\]\] 
-- regex for finding natives in the script that have not yet been converted to local-natives: [A-Z][A-Z][A-Z]\.(?:_|[A-Z][A-Z][A-Z][A-Z][A-Z])
local nv = native_invoker
local ENTITY_SET_ENTITY_COORDS_NO_OFFSET                                = function(entity,xPos,yPos,zPos,xAxis,yAxis,zAxis)nv.begin_call();nv.push_arg_int(entity);nv.push_arg_float(xPos);nv.push_arg_float(yPos);nv.push_arg_float(zPos);nv.push_arg_bool(xAxis);nv.push_arg_bool(yAxis);nv.push_arg_bool(zAxis);nv.end_call("239A3351AC1DA385");end
local ENTITY_GET_ENTITY_COORDS                                          = function(entity,alive)nv.begin_call();nv.push_arg_int(entity);nv.push_arg_bool(alive);nv.end_call("3FEF770D40960D5A");return nv.get_return_value_vector3();end
local ENTITY_FREEZE_ENTITY_POSITION                                     = function(entity,toggle)nv.begin_call();nv.push_arg_int(entity);nv.push_arg_bool(toggle);nv.end_call("428CA6DBD1094446");end
local CAM_CREATE_CAM_WITH_PARAMS                                        = function(camName,posX,posY,posZ,rotX,rotY,rotZ,fov,p8,p9)nv.begin_call();nv.push_arg_string(camName);nv.push_arg_float(posX);nv.push_arg_float(posY);nv.push_arg_float(posZ);nv.push_arg_float(rotX);nv.push_arg_float(rotY);nv.push_arg_float(rotZ);nv.push_arg_float(fov);nv.push_arg_bool(p8);nv.push_arg_int(p9);nv.end_call("B51194800B257161");return nv.get_return_value_int();end
local CAM_DESTROY_CAM                                                   = function(cam,bScriptHostCam)nv.begin_call();nv.push_arg_int(cam);nv.push_arg_bool(bScriptHostCam);nv.end_call("865908C81A2C22E9");end
local CAM_GET_FINAL_RENDERED_CAM_FOV                                    = function()nv.begin_call();nv.end_call("80EC114669DAEFF4");return nv.get_return_value_float();end
local CAM_GET_FINAL_RENDERED_CAM_ROT                                    = function(rotationOrder)nv.begin_call();nv.push_arg_int(rotationOrder);nv.end_call("5B4E4C817FCC2DFB");return nv.get_return_value_vector3();end
local CAM_SET_CAM_ACTIVE                                                = function(cam,active)nv.begin_call();nv.push_arg_int(cam);nv.push_arg_bool(active);nv.end_call("026FB97D0A425F84");end
local CAM_RENDER_SCRIPT_CAMS                                            = function(render,ease,easeTime,p3,p4,p5)nv.begin_call();nv.push_arg_bool(render);nv.push_arg_bool(ease);nv.push_arg_int(easeTime);nv.push_arg_bool(p3);nv.push_arg_bool(p4);nv.push_arg_int(p5);nv.end_call("07E5B515DB0636FC");end
local GRAPHICS_TOGGLE_PAUSED_RENDERPHASES                               = function(toggle)nv.begin_call();nv.push_arg_bool(toggle);nv.end_call("DFC252D8A3E15AB7");end
local GRAPHICS_DONT_RENDER_IN_GAME_UI                                   = function(p0)nv.begin_call();nv.push_arg_bool(p0);nv.end_call("22A249A53034450A");end
local PAD_SET_CONTROL_VALUE_NEXT_FRAME                                  = function(padIndex,control,amount)nv.begin_call();nv.push_arg_int(padIndex);nv.push_arg_int(control);nv.push_arg_float(amount);nv.end_call("E8A25867FBA3B05E");return nv.get_return_value_bool();end
local PAD_SET_CURSOR_POSITION                                           = function(x,y)nv.begin_call();nv.push_arg_float(x);nv.push_arg_float(y);nv.end_call("FC695459D4D0E219");return nv.get_return_value_bool();end
local PLAYER_PLAYER_PED_ID                                              = function()nv.begin_call();nv.end_call("D80958FC74E988A6");return nv.get_return_value_int();end
local SYSTEM_START_NEW_SCRIPT                                           = function(scriptName,stackSize)nv.begin_call();nv.push_arg_string(scriptName);nv.push_arg_int(stackSize);nv.end_call("E81651AD79516E48");return nv.get_return_value_int();end
local SCRIPT_GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH    = function(scriptHash)nv.begin_call();nv.push_arg_int(scriptHash);nv.end_call("2C83A9DA6BFFC4F9");return nv.get_return_value_int();end
local SCRIPT_DOES_SCRIPT_EXIST                                          = function(scriptName)nv.begin_call();nv.push_arg_string(scriptName);nv.end_call("FC04745FBE67C19A");return nv.get_return_value_bool();end
local SCRIPT_REQUEST_SCRIPT                                             = function(scriptName)nv.begin_call();nv.push_arg_string(scriptName);nv.end_call("6EB5F71AA68F2E8E");end
local SCRIPT_HAS_SCRIPT_LOADED                                          = function(scriptName)nv.begin_call();nv.push_arg_string(scriptName);nv.end_call("E6CC9F3BA0FB9EF1");return nv.get_return_value_bool();end
local SCRIPT_SET_SCRIPT_AS_NO_LONGER_NEEDED                             = function(scriptName)nv.begin_call();nv.push_arg_string(scriptName);nv.end_call("C90D2DCACD56184C");end
local STATS_STAT_GET_INT                                                = function(statHash,outValue,p2)nv.begin_call();nv.push_arg_int(statHash);nv.push_arg_pointer(outValue);nv.push_arg_int(p2);nv.end_call("767FBC2AC802EF3D");return nv.get_return_value_bool();end
local STATS_STAT_SET_INT                                                = function(statName,value,save)nv.begin_call();nv.push_arg_int(statName);nv.push_arg_int(value);nv.push_arg_bool(save);nv.end_call("B3271D7AB655B441");return nv.get_return_value_bool();end
local STATS_STAT_SET_BOOL                                               = function(statName,value,save)native_invoker.begin_call();native_invoker.push_arg_int(statName);native_invoker.push_arg_bool(value);native_invoker.push_arg_bool(save);native_invoker.end_call("4B33C4243DE0C432");return native_invoker.get_return_value_bool();end
local STATS_STAT_GET_BOOL                                               = function(statHash,outValue,p2)native_invoker.begin_call();native_invoker.push_arg_int(statHash);native_invoker.push_arg_pointer(outValue);native_invoker.push_arg_int(p2);native_invoker.end_call("11B5E6D2AE73F48E");return native_invoker.get_return_value_bool();end
local STATS_SET_PACKED_STAT_BOOL_CODE                                   = function(index,value,characterSlot)native_invoker.begin_call();native_invoker.push_arg_int(index);native_invoker.push_arg_bool(value);native_invoker.push_arg_int(characterSlot);native_invoker.end_call("DB8A58AEAA67CD07");end
local STATS_GET_PACKED_STAT_BOOL_CODE                                   = function(index,characterSlot)native_invoker.begin_call();native_invoker.push_arg_int(index);native_invoker.push_arg_int(characterSlot);native_invoker.end_call("DA7EBFC49AE3F1B0");return native_invoker.get_return_value_bool();end
local NETSHOPPING_NET_GAMESERVER_TRANSACTION_IN_PROGRESS                = function()native_invoker.begin_call()native_invoker.end_call_2(0x613F125BA3BD2EB9)return native_invoker.get_return_value_bool();end
local TERMINATE_ALL_SCRIPTS_WITH_THIS_NAME                              = function(scriptName)native_invoker.begin_call()native_invoker.push_arg_string(scriptName)native_invoker.end_call_2(0x9DC711BC69C548DF)end

--#endregion natives

local MenuLabels = {
	BUNKER="Bunker",
	BUSINESS="Business",
	MCBUSINESS="MC Business",
	WAREHOUSE="Warehouse",
	NIGHTCLUB="Nightclub",
	NIGHTCLUBSAFE="Nightclub Safe",
	SPECIALCARGO="Special Cargo",
	SELLMISSION="Sell Mission",
	BUYMISSION="Buy Mission",
	START="Start",
	MONEY="Money",
	STOCK="Stock",
	SUPPLIES="Supplies",
	CRATES="Crates",
	PRODUCT="Product",
	INFOOVERLAY="Info Overlay",
	TERRORBYTE="Terrorbyte",
	--! STOCK, SUPPLIES, PRODUCT should all be what the game calls it, or something equivalent
	--! You might want to leave TERRORBYTE the same, unless the game calls it something different

	HTTPGIVEUP="Failed to establish connection to remote.",
	HTTPINVALID="Received an invalid response from remote! This may be due to Cloudflare or your antivirus blocking the connection. Please either establish a new VPN connection, and or switch networks.",
	HTTPFAILSAFE="Activating Killswitches due to failsafe.",
	SCRIPTOUTOFDATE="Script is out of date! Please restart the script to get the latest from the repository!",

	KILLSWITCH_SAFELOOP="Killing Nightclub Safe AFK Money Loop due to killswitch",
	KILLSWITCH_SPECIALCARGO="Killing Special Cargo due to killswitch",
	KILLSWITCH_MAXSELLPRICE="Killing Max Sell Price due to killswitch",
	KILLSWITCH_AUTOCOMPLETE="Killing Auto Complete due to killswitch",

	TRANSACTIONSSTUCK_TOAST="It seems that your transactions are stuck. Please switch sessions or restart the game.",
	BEALONE_TOAST="There are too many players in your lobby! Triggering bealone",

	PREFIX_SAFELOOP="[Safe Loop] {1}",
	PREFIX_SPECIALCARGO="[Special Cargo] {1}",
	PREFIX_TOTALEARNED="Total Earned: {1}",
	PREFIX_MOTD="MOTD: {1}",
	--! {1} is a number, the amount of money earned in total.
	PREFIX="{1} {2}",
	--! This can be '[x1] x2' where x1 is the prefix, and x2 is the message. This might go unused though..

	INFO_SCWAREHOUSE="SC Warehouse {1}: {2}/{3}",
	--! {1} is slot {2} is amount {3} is capacity
	INFO_HUBBUSINESS="Hub {1}: {2}/{3}",
	--! {1} is name {2} is stock {3} is max capacity
	INFO_NCSAFE="Nightclub Safe $: {1}",
	--! {1} is value
	INFO_MCBUSINESS="MC {1}: {2}% | {3}/{4}",
	--! {1} is name {2} is supplies {3} is product {4} is capacity
	INFO_BUNKER="Bunker: {1}% | {2}/{3}",
	--! {1} is supplies {2} is product {3} is capacity

	FINDSAFERWAYS="Find safer ways to make money",
	FINDSAFERWAYS_DESC="Please at least read this before proceeding with the money options found below",
	RETREIVINGINFO="Retreiving Info...",

	SALESABUSE_DIVIDER="Sales Abuse",

	MAXSELLPRICE="Max Sell Price",
	MAXSELLPRICE_DESC="Sell your {1} for the maximum possible price no matter how much {2} you have",
	--! {1} and {2} are the same, and may be one of the following: [STOCK], [SUPPLIES], or [PRODUCT]

	MONITOR="Monitor",

	MONITOR_EXTRA="Monitor {1}",
	MONITOR_DESC="Shows you the amount of {1} you have in your {2}, using the {3}",
	--! {1} could be [STOCK], [SUPPLIES], [PRODUCT], or [MONEY] {2} could be [NIGHTCLUBSAFE], [BUSINESS], or [WAREHOUSE]. {3} is [INFOOVERLAY] for now, but could be changed in the future.

	BYPASSCOOLDOWN="Bypass {1} Cooldown",
	--! {1} may be one of the following: [SELLMISSION], [BUYMISSION]
	BYPASSCOOLDOWN_DESC="Allows you to {1} another {2} without having to wait on a cooldown",
	--! {1} is [START] for now, and {2} could be [SELLMISSION] or [BUYMISSION] for now.

	SETPRODUCT="Set Product",
	SETPRODUCT_DESC="Set how much product you have directly",
	SETPRODUCT_TOAST="Product set.",

	MAXPRODUCTALL="Max Product of All",
	MAXPRODUCTALL_DESC="Sets all of your product amount to max",
	MAXPRODUCTALL_TOAST="All product maxed.",

	MAXPRODUCTIONSPEED="Max Production Speed",
	MCMAXPRODUCTIONSPEED_DESC="Takes effect instantly",
	NCMAXPRODUCTIONSPEED_DESC="Takes effect after a unit finishes producing",
	MAXPRODUCTIONSPEED_TOAST="Production speed maxed.",
	MAXPRODUCTIONSPEEDSLOW_TOAST="Production speed maxed. It will take effect once a good has been produced.",

	MAXIMUMCAPACITY="Maximum Capacity",
	MAXIMUMCAPACITY_DESC="Affects how much stock you can potentially hold",
	MAXIMUMCAPACITY_TOAST="Capacity modified.",

	SUPPLYPRODUCTRATIO="Supply->Product Ratio",
	SUPPLYPRODUCTRATIO_DESC="Sets how much supply it takes to make one product. Lower values means better efficiency",
	SUPPLYPRODUCTRATIO_TOAST="Ratio modified.",

	RESUPPLY="Resupply",
	RESUPPLY_DESC="Will instantly deliver supplies to your business, free of charge",

	TRIGGERPRODUCTION="Trigger Production",
	TRIGGERPRODUCTION_DESC="Puts production into effect immediately",
	TRIGGERPRODUCTION_TOAST="Production Triggered.",

	ENFORCEEASIESTMISSION="Enforce Easiest Sell Mission",
	ENFORCEEASIESTMISSION_DESC="This will make sure you always get the quickest and easiest sell mission. Although, if you're too quick you may not get paid?",

	SPECIALCARGOLIST_DESC="Note that sell values cap out at $10m.",

	SPECIALCARGOWAREHOUSE_DESC="Select which warehouse to monitor and modify, since you can own five of them.",
	SPECIALCARGOMONITOR_DESC="Displays how many special cargo crates you have in the selected warehouse",
	SPECIALCARGONOWAREHOUSE="No Warehouse",
	SPECIALCARGONOWAREHOUSE_DESC="You don't have a warehouse in this slot!",
	SPECIALCARGOMAXSELLPRICE_DESC="Changes the sell price of your CEO's Special Cargo crates to $10m. Keep this enabled to ensure proper math on future sales",
	OPENSCREEN="Open {1} Screen",
	OPENSCREEN_DESC="Opens the {1} Screen",
	--! {1} could be [TERRORBYTE] or [WAREHOUSE]
    SELLACRATE="Press To Sell A Crate",
    SELLACRATE_DESC="Automatically sells one Special Cargo Crate",

	NOTINSELECTEDWAREHOUSE_TOAST="You are not at your currently selected warehouse!",

	AUTOCOMPLETE="Autocomplete {1}",
	AUTOCOMPLETE_DESC="Makes the {1} complete automatically",
	--! {1} could be [SELLMISSION] or [BUYMISSION]

	NCLIST_DESC="Note that sell values cap out at $4m.\nDO NOT attempt to 'sell all'",
	NCREVENUE="Revenue",
	NCREVENUE_DESC="Edits how much revenue your Nightclub gains, no matter how popular you are",
	NCREVENUE_TOAST="Revenue set.",

	NCMAXPOPULARITY="Max Nightclub Popularity",
	NCMAXPOPULARITY_DESC="Sets your Nightclub popularity to 100%",
	NCMAXPOPULARITY_TOAST="Maxed Nightclub popularity.",

	NCSAFELIST_DESC="",

	NCSAFELOOP="AFK Money Loop",
	NCSAFELOOP_DESC="Open your Nightclub safe before enabling this feature!\nWill allow you to passively gain $300k every ~4-5 seconds",

	NCSAFELOOPDELAY="Loop Delay",
	NCSAFELOOPDELAY_DESC="Will set how long the afk loop waits (in milliseconds) in between major steps",
	NCSAFELOOPDELAY_TOAST="Delay modified.",

	NCSAFELOOPTRANSACTIONTIMEOUT="Transaction Timeout",
	NCSAFELOOPTRANSACTIONTIMEOUT_DESC="Sets how long to wait for a transaction to process before giving up",
	NCSAFELOOPTIMEOUTMODIFIED_TOAST="Transaction Timeout modified.",

	NCSAFELOOPSTOP="Stop Loop After $x Amount",
	NCSAFELOOPSTOP_DESC="Will stop the AFK Money Loop after you earn the set amount",
	NCSAFELOOPSTOP_TOAST="Limit set.",

	NCRESETSAFEVALUE="Reset Safe Value",
	--! Referenced in [NCSAFELOOPSAFEOVERLIMIT_TOAST]
	NCRESETSAFEVALUE_DESC="If your Nightclub Safe is above $300k or below $0 then this should fix it.",
	NCRESETSAFEVALUEWAIT_TOAST="Please wait while your Nightclub Safe is being reset.",
	NCRESETSAFEVALUESUCCESS_TOAST="Your Nightclub Safe should be reset now.",
	NCRESETSAFEVALUESKIP_TOAST="Your Nightclub Safe appears to be fine",

	NCSAFELOOPMAXIMUMVALUEREACHED_TOAST="Maximum value has been reached!",
	NCSAFELOOPNOTINNIGHTCLUB_TOAST="You don't appear to be in your Nightclub. Make sure you are in your Nightclub with the safe open before using this feature!",
	NCSAFELOOPTIMEOUT_TOAST="Seems like you've hit transaction timeout.",
	NCSAFELOOPSAFEOVERLIMIT_TOAST="Uh oh, it seems like the safe went over the limit. Use 'Reset Safe Value' then try again",
	--! References [NCRESETSAFEVALUE]
	NCSAFELOOPSOMETHINGWENTWRONG_TOAST="Something didn't go as it should... if you can reproduce this issue, please report it.",

	MCLIST_DESC="Note that sell values cap out at $2.5m.",

	BUNKERLIST_DESC="Note that sell values cap out at $2.7m.",

	TELEPORTTO="Teleport to {1}",
	TELEPORTTO_DESC="Teleports you to your {1}",
	--! {1} may be one of the following: [PROPERTY], [WAREHOUSE], [NIGHTCLUB], or [NIGHTCLUBSAFE]

	NOTINNIGHTCLUB_TOAST="You are not in your Nightclub!",

	JOINDISCORD="Join the Discord",
	SHOWMOTD="Show MOTD",
	SHOWMOTDBLANK_TOAST="The MOTD is blank.",
	WARNINGRISKY_TOAST="WARNING: All features in this script are considered risky! There is a chance you will get banned within an unknown number of days (bans are delayed randomly). You have been warned.",

    --! Nightclub
    ALREADYINPROPERTY="You are already in your {1}!",
    --! {1} may be [NIGHTCLUB], [WAREHOUSE], [BUSINESS]
 
    --! Nightclub categories
    HUBCARGO="运输货物",
    HUBWEED="有机农产品",
    HUBWEAPONS="体育用品",
    HUBMETH="药学研究产品",
    HUBCOCAINE="南美进口货",
    HUBCASH="印钞",
    HUBFORGERY="印刷品",
 
    --! MC categories
    MCFORGERY="伪造证件",
    MCWEED="大麻",
    MCCASH="假钞",
    MCMETH="冰毒",
    MCCOCAINE="可卡因",
    MCBUNKER="地堡",

    --! Special Cargo
    SPECIALCARGONOMORECRATES="You have no more crates in your warehouse!",
    SPECIALCARGONEEDCEO="You are in an MC! You need to be in a CEO.",
    SPECIALCARGOMAXCRATESOURCE="Max Crate Sourcing Amount",
    SPECIALCARGOMAXCRATESOURCE_DESC="Sets the amount of crates your staff will deliver",
    SPECIALCARGOSETDELIVERTIME="Minimize Delivery Time",
    SPECIALCARGOSETDELIVERTIME_DESC="Sets the amount of time to pass before you staff will deliver, to zero",
}

local MCBusinessPropertyInfo = {
    [1]  = {name = "佩立托湾 冰毒实验室",                      coords = {x = 52.903,     y =  6338.585,  z = 31.35  }, type = 3},  -- "MP_BWH_METH_1",
    [2]  = {name = "乞力耶德山 大麻种植场",                  coords = {x = 416.7524,   y =  6520.753,  z = 27.7121}, type = 1},  -- "MP_BWH_WEED_1",
    [3]  = {name = "佩立托湾 可卡因作坊",                coords = {x = 51.7653,    y =  6486.163,  z = 31.428 }, type = 4},  -- "MP_BWH_CRACK_1",
    [4]  = {name = "佩立托湾 假钞工厂",      coords = {x = -413.6606,  y =  6171.938,  z = 31.4782}, type = 2},  -- "MP_BWH_CASH_1",
    [5]  = {name = "佩立托湾 证件伪造办公室",                coords = {x = -163.6828,  y =  6334.845,  z = 31.5808}, type = 0},  -- "MP_BWH_FAKEID_1",
    [6]  = {name = "布罗高地 冰毒实验室",                coords = {x = 1454.671,   y =  -1651.986, z = 67     }, type = 3},  -- "MP_BWH_METH_2",
    [7]  = {name = "好麦坞市区 大麻种植场",              coords = {x = 102.14,     y =  175.26,    z = 104.56 }, type = 1},  -- "MP_BWH_WEED_2",
    [8]  = {name = "摩宁坞 可卡因作坊",               coords = {x = -1462.622,  y =  -381.826,  z = 38.802 }, type = 4},  -- "MP_BWH_CRACK_2",
    [9]  = {name = "威斯普奇运河 假钞工厂", coords = {x = -1171.005,  y =  -1380.922, z = 4.937  }, type = 2},  -- "MP_BWH_CASH_2",
    [10] = {name = "纺织城 证件伪造办公室",              coords = {x = 299.071,    y =  -759.072,  z = 29.333 }, type = 0},  -- "MP_BWH_FAKEID_2",
    [11] = {name = "塞诺拉大沙漠 冰毒实验室",                   coords = {x = 201.8909,   y =  2461.782,  z = 55.6885}, type = 3},  -- "MP_BWH_METH_3",
    [12] = {name = "圣强斯基山脉 大麻种植场",                   coords = {x = 2848.369,   y =  4450.147,  z = 48.5139}, type = 1},  -- "MP_BWH_WEED_3",
    [13] = {name = "阿拉莫海 可卡因作坊",             coords = {x = 387.5332,   y =  3585.042,  z = 33.2922}, type = 4},  -- "MP_BWH_CRACK_3",
    [14] = {name = "塞诺拉大沙漠 假钞工厂",   coords = {x = 636.6344,   y =  2785.126,  z = 42.0111}, type = 2},  -- "MP_BWH_CASH_3",
    [15] = {name = "葡萄籽证件 伪造办公室",                 coords = {x = 1657.066,   y =  4851.732,  z = 41.9882}, type = 0},  -- "MP_BWH_FAKEID_3",
    [16] = {name = "港口区 冰毒实验室",                        coords = {x = 1181.44,    y =  -3113.82,  z = 6.03   }, type = 3},  -- "MP_BWH_METH_4",
    [17] = {name = "天堂岛 大麻种植场",                 coords = {x = 136.973,    y =  -2472.795, z = 5.98   }, type = 1},  -- "MP_BWH_WEED_4",
    [18] = {name = "天堂岛 可卡因作坊",            coords = {x = -253.31,    y =  -2591.15,  z = 5.97   }, type = 4},  -- "MP_BWH_CRACK_4",
    [19] = {name = "柏树公寓 假钞工厂",   coords = {x = 671.451,    y =  -2667.502, z = 6.0812 }, type = 2},  -- "MP_BWH_CASH_4",
    [20] = {name = "天堂岛 证件伪造办公室",            coords = {x = -331.52,    y =  -2778.97,  z = 5.12   }, type = 0},  -- "MP_BWH_FAKEID_4",
    [21] = {name = "塞诺拉大油田 地堡",            coords = {x = 492.8395,   y = 3014.057,   z = 39.9793}, type = 5},  -- "MP_BUNKER_1",
    [22] = {name = "塞诺拉大沙漠 地堡",               coords = {x = 849.603,    y = 3021.697,   z = 40.3076}, type = 5},  -- "MP_BUNKER_2",
    [23] = {name = "68号公路 地堡",                          coords = {x = 39.5967,    y = 2930.506,   z = 54.8034}, type = 5},  -- "MP_BUNKER_3",
    [24] = {name = "农舍 地堡",                         coords = {x = 1572.078,   y = 2226.001,   z = 77.2829}, type = 5},  -- "MP_BUNKER_4",
    [25] = {name = "黄栌路 地堡",                   coords = {x = 2110.019,   y = 3326.12,    z = 44.3526}, type = 5},  -- "MP_BUNKER_5",
    [26] = {name = "汤姆森废车场 地堡",                 coords = {x = 2489.36,    y = 3162.12,    z = 48.0015}, type = 5},  -- "MP_BUNKER_6",
    [27] = {name = "葡萄籽 地堡",                         coords = {x = 1801.273,   y = 4705.483,   z = 38.8253}, type = 5},  -- "MP_BUNKER_7",
    [28] = {name = "佩立托森林 地堡",                     coords = {x = -755.5687,  y = 5943.835,   z = 18.9008}, type = 5},  -- "MP_BUNKER_9",
    [29] = {name = "雷通峡谷 地堡",                      coords = {x = -388.8392,  y = 4340.109,   z = 55.1741}, type = 5},  -- "MP_BUNKER_10",
    [30] = {name = "桑库多 地堡",                      coords = {x = -3031.356,  y = 3334.059,   z = 9.1805 }, type = 5},  -- "MP_BUNKER_11",
    [31] = {name = "丘马什 地堡",                           coords = {x = -3157.599,  y = 1376.695,   z = 15.866 }, type = 5},  -- "MP_BUNKER_12",
}

local WarehousePropertyInfo = {
    [1]  = {name = "太平洋鱼饵仓储",      capacity = 16,      coords = {x = 54.191,    y = -2569.248,  z = 6.0046 }}, -- "MP_WHOUSE_0",
    [2]  = {name = "白寡妇车库",        capacity = 16,      coords = {x = -1083.054, y = -1261.893,  z = 5.534  }}, -- "MP_WHOUSE_1",
    [3]  = {name = "赛尔托瓦单元",             capacity = 16,      coords = {x = 896.3665,  y = -1035.749,  z = 35.1096}}, -- "MP_WHOUSE_2",
    [4]  = {name = "便利店车库",  capacity = 16,      coords = {x = 247.473,   y = -1956.943,  z = 23.1908}}, -- "MP_WHOUSE_3",
    [5]  = {name = "法拍车库",         capacity = 16,      coords = {x = -424.828,  y = 185.825,    z = 80.775 }}, -- "MP_WHOUSE_4",
    [6]  = {name = "希罗汽油工厂",          capacity = 111,     coords = {x = -1042.482, y = -2023.516,  z = 13.1616}}, -- "MP_WHOUSE_5",
    [7]  = {name = "翘臀内衣外景场地", capacity = 42,      coords = {x = -1268.119, y = -812.2741,  z = 17.1075}}, -- "MP_WHOUSE_6",
    [8]  = {name = "贝尔吉科仓库",         capacity = 111,     coords = {x = -873.65,   y = -2735.948,  z = 13.9438}}, -- "MP_WHOUSE_7",
    [9]  = {name = "码头400号工作仓库", capacity = 16,      coords = {x = 274.5224,  y = -3015.413,  z = 5.6993 }}, -- "MP_WHOUSE_8",
    [10] = {name = "GEE仓库",             capacity = 42,      coords = {x = 1569.69,   y = -2129.792,  z = 78.3351}}, -- "MP_WHOUSE_9",
    [11] = {name = "洛圣都海事大厦3号楼",      capacity = 42,      coords = {x = -315.551,  y = -2698.654,  z = 7.5495 }}, -- "MP_WHOUSE_10",
    [12] = {name = "火车站仓库",        capacity = 42,      coords = {x = 499.81,    y = -651.982,   z = 24.909 }}, -- "MP_WHOUSE_11",
    [13] = {name = "透心凉辅楼仓库",            capacity = 42,      coords = {x = -528.5296, y = -1784.573,  z = 21.5853}}, -- "MP_WHOUSE_12",
    [14] = {name = "废弃的工厂直销店",    capacity = 42,      coords = {x = -295.8596, y = -1353.238,  z = 31.3138}}, -- "MP_WHOUSE_13",
    [15] = {name = "折扣零售商店",      capacity = 42,      coords = {x = 349.839,   y = 328.889,    z = 104.272}}, -- "MP_WHOUSE_14",
    [16] = {name = "物流仓库",           capacity = 111,     coords = {x = 926.2818,  y = -1560.311,  z = 30.7404}}, -- "MP_WHOUSE_15",
    [17] = {name = "达内尔兄弟仓库",    capacity = 111,     coords = {x = 759.566,   y = -909.466,   z = 25.244 }}, -- "MP_WHOUSE_16",
    [18] = {name = "家具批发市场",       capacity = 111,     coords = {x = 1037.813,  y = -2173.062,  z = 31.5334}}, -- "MP_WHOUSE_17",
    [19] = {name = "柏树仓库",        capacity = 111,     coords = {x = 1019.116,  y = -2511.69,   z = 28.302 }}, -- "MP_WHOUSE_18",
    [20] = {name = "西好麦坞外景场地",     capacity = 111,     coords = {x = -245.3405, y = 203.3286,   z = 83.818 }}, -- "MP_WHOUSE_19",
    [21] = {name = "旧发电站",         capacity = 42,      coords = {x = 539.346,   y = -1945.682,  z = 24.984 }}, -- "MP_WHOUSE_20",
    [22] = {name = "沃克父子仓库",   capacity = 111,     coords = {x = 96.1538,   y = -2216.4,    z = 6.1712 }}, -- "MP_WHOUSE_21",
}

local NightclubPropertyInfo = {
    [1]  = {name = "梅萨 夜总会",           coords = {x = 757.009,   y =  -1332.32,  z = 27.1802 }},
    [2]  = {name = "密申罗 夜总会",       coords = {x = 345.7519,  y =  -978.8848, z = 29.2681 }},
    [3]  = {name = "斯卓贝利 夜总会",        coords = {x = -120.906,  y =  -1260.49,  z = 29.2088 }},
    [4]  = {name = "西好麦坞 夜总会",     coords = {x = 5.53709,   y =  221.35,    z = 107.6566}},
    [5]  = {name = "柏树公寓 夜总会",     coords = {x = 871.47,    y =  -2099.57,  z = 30.3768 }},
    [6]  = {name = "洛圣都国际机场 夜总会",              coords = {x = -676.625,  y =  -2458.15,  z = 13.8444 }},
    [7]  = {name = "天堂岛 夜总会",    coords = {x = 195.534,   y =  -3168.88,  z = 5.7903  }},
    [8]  = {name = "好麦坞市区 夜总会", coords = {x = 373.05,    y =  252.13,    z = 102.9097}},
    [9]  = {name = "佩罗 夜总会",         coords = {x = -1283.38,  y =  -649.916,  z = 26.5198 }},
    [10] = {name = "威斯普奇运河 夜总会",   coords = {x = -1174.85,  y =  -1152.3,   z = 5.56128 }},
}

local HubTypesOrderedWithLabels = {
    [0] = {name = "Cargo",      label = MenuLabels.HUBCARGO},
    [1] = {name = "Weapons",    label = MenuLabels.HUBWEAPONS},
    [2] = {name = "Cocaine",    label = MenuLabels.HUBCOCAINE},
    [3] = {name = "Meth",       label = MenuLabels.HUBMETH},
    [4] = {name = "Weed",       label = MenuLabels.HUBWEED},
    [5] = {name = "Forgery",    label = MenuLabels.HUBFORGERY},
    [6] = {name = "Cash",       label = MenuLabels.HUBCASH},
}

local MCBusinessTypesOrderedWithLabels = {
    [0] = {name = "Forgery",    label = MenuLabels.MCFORGERY},
    [1] = {name = "Weed",       label = MenuLabels.MCWEED},
    [2] = {name = "Cash",       label = MenuLabels.MCCASH},
    [3] = {name = "Meth",       label = MenuLabels.MCMETH},
    [4] = {name = "Cocaine",    label = MenuLabels.MCCOCAINE},
    [5] = {name = "Bunker",     label = MenuLabels.MCBUNKER},
}

local MyBusinesses = {
    [0] = {property = 0, type = "None"},
    [1] = {property = 0, type = "None"},
    [2] = {property = 0, type = "None"},
    [3] = {property = 0, type = "None"},
    [4] = {property = 0, type = "None"},
    [5] = {property = 0, type = "None"},

    ["Forgery"] = {slot = 0, property = 0, product = 0, supplies = 0, upgraded = false},
    ["Weed"]    = {slot = 0, property = 0, product = 0, supplies = 0, upgraded = false},
    ["Cash"]    = {slot = 0, property = 0, product = 0, supplies = 0, upgraded = false},
    ["Meth"]    = {slot = 0, property = 0, product = 0, supplies = 0, upgraded = false},
    ["Cocaine"] = {slot = 0, property = 0, product = 0, supplies = 0, upgraded = false},
    ["Bunker"]  = {slot = 0, property = 0, product = 0, supplies = 0, upgraded = false, research = 0},

    ["Hub"] = {
        ["Cargo"]   = 0, -- 0 -- CEO?
        ["Weapons"] = 0, -- 1
        ["Cocaine"] = 0, -- 2
        ["Meth"]    = 0, -- 3
        ["Weed"]    = 0, -- 4
        ["Forgery"] = 0, -- 5
        ["Cash"]    = 0, -- 6
    }
}

local MenuCurrentWarehouses = {
    [0] = {"Name", {}, ""},
    [1] = {"Name", {}, ""},
    [2] = {"Name", {}, ""},
    [3] = {"Name", {}, ""},
    [4] = {"Name", {}, ""},
}

local Selected_Warehouse = 0
local NCSafePos = {x = -1615.6832, y = -3015.7546, z = -75.204994}

local tunables_global = 262145
local globals = {
    Hub = {
        MaxSellPrice = 4000000 - 2100000,
        ProSpd = 1000,
        SellCooldownActive = 1958659+28+1, -- was 1958876+28+1

        Cargo = {
            Sell                = tunables_global+24387, -- 24387 was 24415
            SellDefaultValue    = 10000,
            ProSpd              = tunables_global+24372, -- 24372 was 24400
            ProSpdDefaultValue  = 8400000,
            Cap                 = tunables_global+24394, -- 24394 was 24422
            CapDefaultValue     = 50,
        },

        Weapons = {
            Sell                = tunables_global+24381, -- was 24409
            SellDefaultValue    = 5000,
            ProSpd              = tunables_global+24366, -- was 24394
            ProSpdDefaultValue  = 4800000,
            Cap                 = tunables_global+24388, -- was 24416
            CapDefaultValue     = 100,
        },

        Cocaine = {
            Sell                = tunables_global+24382, -- 24382 was 24410
            SellDefaultValue    = 27000,
            ProSpd              = tunables_global+24367, -- 24367 was 24395
            ProSpdDefaultValue  = 14400000,
            Cap                 = tunables_global+24389, -- 24389 was 24417
            CapDefaultValue     = 10,
        },

        Meth = {
            Sell                = tunables_global+24383, -- was 24411
            SellDefaultValue    = 11475,
            ProSpd              = tunables_global+24368, -- was 24396
            ProSpdDefaultValue  = 7200000,
            Cap                 = tunables_global+24390, -- was 24418
            CapDefaultValue     = 20,
        },

        Weed = {
            Sell                = tunables_global+24384, -- 24384 was 24412
            SellDefaultValue    = 2025,
            ProSpd              = tunables_global+24369, -- 24369 was 24397
            ProSpdDefaultValue  = 2400000,
            Cap                 = tunables_global+24391, -- 24391 was 24419
            CapDefaultValue     = 80,
        },

        Forgery = {
            Sell                = tunables_global+24385, -- was 24413
            SellDefaultValue    = 1350,
            ProSpd              = tunables_global+24370, -- was 24398
            ProSpdDefaultValue  = 1800000,
            Cap                 = tunables_global+24392, -- was 24420
            CapDefaultValue     = 60,
        },

        Cash = {
            Sell                = tunables_global+24386, -- was 24414
            SellDefaultValue    = 4725,
            ProSpd              = tunables_global+24371, -- was 24399
            ProSpdDefaultValue  = 3600000,
            Cap                 = tunables_global+24393, -- was 24421
            CapDefaultValue     = 40,
        },
    },

    MC = {
        MaxSellPrice = 2000000,

        Forgery = {
            Sell1               = tunables_global+17420, -- was 17471
            Sell1DefaultValue   = 1350,
            Sell2               = tunables_global+19067, -- was 19112
            Sell2DefaultValue   = 1.5,
            ProSpd1             = tunables_global+17394, -- was 17449
            ProSpd1DefaultValue = 300000,
            ProSpd2DefaultValue = 300000,
            Ratio1              = tunables_global+17408, -- was 17461
            Ratio1DefaultValue  = 4,
            Ratio2              = tunables_global+17414, -- was 17466
            Ratio2DefaultValue  = 2,
            Cap                 = tunables_global+18933, -- was 18980
            CapDefaultValue     = 60,
        },

        Cash = {
            Sell1               = tunables_global+17421, -- was 17472
            Sell1DefaultValue   = 4725,
            Sell2               = tunables_global+19067, -- was 19112
            Sell2DefaultValue   = 1.5,
            ProSpd1             = tunables_global+17395, -- was 17450
            ProSpd1DefaultValue = 720000,
            ProSpd2DefaultValue = 720000,
            Ratio1              = tunables_global+17409, -- was 17462
            Ratio1DefaultValue  = 10,
            Ratio2              = tunables_global+17415, -- was 17467
            Ratio2DefaultValue  = 5,
            Cap                 = tunables_global+18941, -- was 18988
            CapDefaultValue     = 40,
        },

        Cocaine = {
            Sell1               = tunables_global+17422, -- was 17473
            Sell1DefaultValue   = 27000,
            Sell2               = tunables_global+19067, -- was 19112
            Sell2DefaultValue   = 1.5,
            ProSpd1             = tunables_global+17393, -- was 17448
            ProSpd1DefaultValue = 3000000,
            ProSpd2DefaultValue = 3000000,
            Ratio1              = tunables_global+17410, -- was 17463
            Ratio1DefaultValue  = 50,
            Ratio2              = tunables_global+17416, -- was 17468
            Ratio2DefaultValue  = 25,
            Cap                 = tunables_global+18925, -- was 18972
            CapDefaultValue     = 10,
        },

        Meth = {
            Sell1               = tunables_global+17423, -- was 17474
            Sell1DefaultValue   = 11475,
            Sell2               = tunables_global+19067, -- was 19112
            Sell2DefaultValue   = 1.5,
            ProSpd1             = tunables_global+17392, -- was 17447
            ProSpd1DefaultValue = 1800000,
            ProSpd2DefaultValue = 1800000,
            Ratio1              = tunables_global+17411, -- was 17464
            Ratio1DefaultValue  = 24,
            Ratio2              = tunables_global+17417, -- was 17469
            Ratio2DefaultValue  = 12,
            Cap                 = tunables_global+18917, -- was 18964
            CapDefaultValue     = 20,
        },

        Weed = {
            Sell1               = tunables_global+17424, -- was 17475
            Sell1DefaultValue   = 2025,
            Sell2               = tunables_global+19067, -- was 19112
            Sell2DefaultValue   = 1.5,
            ProSpd1             = tunables_global+17391, -- was 17446
            ProSpd1DefaultValue = 360000,
            ProSpd2DefaultValue = 360000,
            Ratio1              = tunables_global+17412, -- was 17465
            Ratio1DefaultValue  = 4,
            Ratio2              = tunables_global+17418, -- was 17470
            Ratio2DefaultValue  = 2,
            Cap                 = tunables_global+18909, -- was 18956
            CapDefaultValue     = 80,
        },

        Bunker = {
            Sell1 = tunables_global+21537, -- was 21581
            Sell1DefaultValue = 5000,
            Sell2 = tunables_global+21510, -- was 21554
            Sell2DefaultValue = 1.5,
            ProSpd1 = tunables_global+21532, -- was 21576 -- base
            ProSpd1DefaultValue = 600000,
            ProSpd2 = tunables_global+21533, -- was 21577 -- equipment
            ProSpd2DefaultValue = 90000,
            ProSpd3 = tunables_global+21534, -- was 21578 -- staff upg
            ProSpd3DefaultValue = 90000,
            Ratio1 = tunables_global+21283, -- was 21327 -- no upgrade
            Ratio1DefaultValue = 10,
            Ratio2 = tunables_global+21284, -- was 21328 -- with upgrade
            Ratio2DefaultValue = 5,
            Cap = tunables_global+21531, -- was 21575
            CapDefaultValue = 100,
        },
    },

    SafeCap           = tunables_global+24045, -- was 24073 -- 250000, which is interesting because its actually set to 210k :thonk: 
    SafeRevenue       = tunables_global+24021, -- was 24049 keep in mind theres 20 different ones, this is just the first
    SafeLimit         = 300000,
    SafeStatus1       = 1648769, -- was 1640759
    SafeStatus2       = 2764411, -- was 2787714

    MCSupplyDelay   = tunables_global+18954, -- 600 -- was 18999
    MCSupplyTime    = 1648637+1, -- not a tunable, found in freemode.c func_16968. Now found in func_17804. was 1640642+1
    BunkSupplyDelay = tunables_global+21305, -- 600

    SpecialCargoMaxSellPriceValue   = 6000000,
    SpecialCargoBypassBuyCooldown   = tunables_global+15553, -- 300000  -- was 15608
    SpecialCargoBypassSellCooldown  = tunables_global+15554, -- 1800000 -- was 15609
    SpecialCargoCrateMaxThreshold   = tunables_global+15787, -- 111     -- was 15842
    SpecialCargoRewardPerCrate      = tunables_global+15808, -- 20000   -- was 15863
    SpecialCargoCrateMultiplier3    = tunables_global+16653, -- 100     -- was 16708
    SpecialCargoCrateMultiplier2    = tunables_global+16654, -- 50      -- was 16709
    SpecialCargoCrateMultiplier1    = tunables_global+16655, -- 20      -- was 16710
    SpecialCargoBonus               = tunables_global+15580, -- 9000    -- was 15635

    SpecialCargoSellFuncSomething   = 1949955, -- was 1946098
    SpecialCargoDeliveryTime        = tunables_global+32554,
    SpecialCargoDeliveryCrates      = 1890428+12,

    IsUsingComputerScreen = 75693, -- was 75485
}

local locals = {
    ----------------
    -- Special Cargo
    ----------------
    --appsecuroserv
    SpecialCargoSecuroString = "appsecuroserv",
    SpecialCargoSecuroArgs = 4592, -- not a local, just the arg count needed to properly start the script
    SpecialCargoCurrentProperty = 732, -- warehouse property id (non-global-index based)) -- was 730
    SpecialCargoScreenStatus = 555, -- status: 3011 = sold? 1 = error, 3012 = confirm? -- was 553
    SpecialCargoCratesToSell = 736, -- was 734
    SpecialCargoSellFromOption = 737, -- (not current property id, but buttons [1-3]) -- was 735
    SpecialCargoCurrentBitset = 556, -- bit 13 controls if it is warehouse or securoserv -- was 554
    SpecialCargoStartingPosX = 753, -- float  (if distance to this from self is greater than 5f to this local, kill script) -- was 751
    SpecialCargoStartingPosY = 754, -- float  (if distance to this from self is greater than 5f to this local, kill script) -- was 752?
    SpecialCargoStartingPosZ = 755, -- float  (if distance to this from self is greater than 5f to this local, kill script) -- was 753?

    --gb_contraband_sell
    SpecialCargoSellString = "gb_contraband_sell",
    SpecialCargoSellType = 540+583,
    SpecialCargoSellSubType = 540+7,
    SpecialCargoSellAmount = 540+57,
    SpecialCargoSellStatus = 540+583,

    --gb_contraband_buy
    SpecialCargoBuyString = "gb_contraband_buy",
    SpecialCargoBuyComplete = 598+192, -- was 596+192
    SpecialCargoBuyCollected = 598+186, -- was 596+186
    SpecialCargoBuyCollected2 = 473, -- was 471
    SpecialCargoBuyStatus = 264, -- was 262

    --appHackerTruck
    SpecialCargoBuyScreenString = "appHackerTruck",
    SpecialCargoBuyScreenArgs = 4592, -- outdated?
    SpecialCargoBuyScreenHasSelectedJobCategory = 305+1, -- outdated
    SpecialCargoBuyScreenCurrentPrompt = 115,  -- outdated
    SpecialCargoBuyScreenCurrentCategory = 116, -- outdated
    SpecialCargoBuyScreenWarehousePropertyId = 292, -- outdated
    SpecialCargoBuyScreenShipmentSize = 293, -- outdated
    SpecialCargoBuyScreenBitset = 107, -- outdated
    

    ----------------
    -- NightClub
    ----------------
    NCSafeScriptString = "freemode",
    NCSafeTransactionStatus = 19195+1, -- was 18992+1
    NCSafeAddMoneyAmount = 19195+2, -- was 18992+2
    NCSellMissionCooldown = 114, -- a bitset
    NCSellMissionCooldownBit = 27,

    NCHubScriptString = "appbusinesshub",
    NCHubSellCooldown = 114, -- a local
    NCHubSellCooldownBit = 27, -- a bitset bit

    ----EZNCMission = ,

    ----------------
    -- MC
    ----------------
    MCSellScriptString = "gb_biker_contraband_sell",
    MCEZMissionStarted = 698+122,
    MCEZMission = 698+17,

    MCLaptopString = "appbikerbusiness",
    MCLaptopCurrentProperty = 521,

    ----------------
    -- Bunker
    ----------------
    BunkScriptString = "gb_gunrunning",
    PeePeePooPoo = (1199 + 551 + 1 + 19), --! hmm yes, quite a descriptive name :) -- outdated
    BunkTimeRemaining = 1181, -- outdated
    BunkTimeTakenToDeliver = (1199 + 579), -- outdated
}

local TotalEarnedTypes = {
    --type   = {prefix = label, amount = 0}
    -- Do not use GetLabelText in here, these are prefixes and will be converted later
    safeloop = {prefix = MenuLabels.PREFIX_SAFELOOP, amount = 0},   
    specialcargo = {prefix = MenuLabels.PREFIX_SPECIALCARGO, amount = 0},
}

local I32_MAX = 2147483647

-----------------------------------
-- String Functions
-----------------------------------
--#region String Functions

local function ReplacePlaceholder(str, rep, num)
    local b, e = str:find("{"..num.."}")
    if b and e then
        return (str:sub(0, b-1) .. rep .. str:sub(e+1, -1))
    else
        util.log(string.format("Expected {%i} Placeholder in: %s", num, str))
        return str
    end
end

---@param label string
---@param ... string|integer
---@return string
local function GetLabelText(label, ...)
    -- Usage: GetLabelText("Press {1} to interact.", "E")                   -- Returns "Press E to interact."
    -- Usage: GetLabelText("Press {1} to open {2}.", "X", "the menu")       -- Returns "Press X to open the menu."
    -- Usage: GetLabelText("Press {2} to open {1}.", "in fullscreen", "F")  -- Returns "Press F to open in fullscreen."
    -- Note: NUMBER OF ARGS GIVEN TO FUNCTION AND ARGS IN LABEL MUST MATCH!
    -- Note: EMPTY ARGS OR DUPLICATE ARGS IN LABEL IS UNDEFINED BEHAVIOUR!
    local args = {...}
    local str = label
    for i = 1, #args do
        str = ReplacePlaceholder(str, args[i], i)
    end
    return str
end

local function GetKeyValueFromLine(line, size)
    local find = string.find(line, "=")
    if not find then return end
    size = size or 2
    local key = string.sub(line, 0, find-size)
    local value = string.sub(line, find+size, -1)
    return key, value
end

local function GetCharacterFromString(str, charpos)
    return str:sub(charpos, charpos)
    --return str[charpos] -- pluto only
end
--#endregion String Functions

-----------------------------------
-- Version Functions
-----------------------------------
--#region Version Functions

local function VersionStringToTable(str)
    local result = {}
    local s = str .. "."
    for match in string.gmatch(s, "(.-)%.") do
        table.insert(result, match)
    end
    return result
end

---@param lversion string
---@param rversion string
---@param vtypes table?
---@return boolean
---@return string
-- returns true if up to date or above date, false if out of date
local function VersionCheck(lversion, rversion, vtypes)
    local lvtable = VersionStringToTable(lversion)
    local rvtable = VersionStringToTable(rversion)
    for index in ipairs(lvtable) do
        if lvtable[index] < rvtable[index] then
            return false, "out of date by a " .. (vtypes and vtypes[index] or index) .. " version"
        elseif lvtable[index] > rvtable[index] then
            break
        end
    end
    return true, "is not out of date"
end
--#endregion Version Functions

-----------------------------------
-- Translation Functions
-----------------------------------
--#region Translation Functions

---@return boolean
---@return table
local function GetTranslationFileMetadata(path)
    local metadata = {}
    local file, err = io.open(path, "r")
    if file then
        local line = file:read("l")
        local iter = 0
        while GetCharacterFromString(line, 1) == "@" do
            local key, value = GetKeyValueFromLine(line:sub(2), 1)
            if key then
                metadata[key] = value
            else
                --util.log("Failure in getting key-value from line:\n"..line)
                if not SCRIPT_SILENT_START then
                    util.toast("Failure in reading translation file!")
                end
                break
            end
            if iter >= 10 then
                break
            end
            iter = iter + 1
            line = file:read("l")
        end
        file:close()
    else
        --util.log("Failure in opening:\n"..path.."\nReason: "..(err or "unspecified"))
        return false, metadata
    end
    return true, metadata
end

---@param language table|string
local function TranslateLabels(language)
    local path
    if type(language) == "table" then
        path = language["path"]
    elseif type(language) == "string" then
        path = language
    else
        error("TranslateLabels was not given a valid type!")
    end

    local lvalue, rvalue
    for line in io.lines(path) do
        local first_char = GetCharacterFromString(line, 1)
        if first_char == "!" or first_char == "#" or first_char == "@" then

        else
            lvalue, rvalue = GetKeyValueFromLine(line, 1)
            if lvalue then
                if MenuLabels[lvalue] ~= nil then
                    MenuLabels[lvalue] = rvalue:gsub("\\n", "\n") or "ERROR"
                else
                    util.toast("读取翻译文件时出错。翻译文件可能已损坏或过期.")
                    --util.log("Translation file attempted to assign a non-existant MenuLabel a value. $"..lvalue)
                end
            end
        end
    end
end

local Languages = {
    [1] = {"EN - English", {"en"}, ""},
}

if not filesystem.exists(MB_TRANSLATIONS_DIR) then
    filesystem.mkdirs(MB_TRANSLATIONS_DIR)
end

local dirlen = string.len(MB_TRANSLATIONS_DIR)
for index, filepath in ipairs(filesystem.list_files(MB_TRANSLATIONS_DIR)) do
    local success, metadata = GetTranslationFileMetadata(filepath) -- stuff like version, creator, etc.
    local filename = filepath:sub(dirlen + 1, -5):gsub("_", " ") -- transforms "_" to " ", because discord is stinky and replaces spaces with "_".
    local langcode = string.match(filename, "([%a-]+) - ")
    local author  = (success and metadata.Author ~= nil)  and "Author: " .. metadata.Author or "No author"
    local version = (success and metadata.Version ~= nil) and metadata.Version or "0.0.0"
    local uptodate, ood_msg

    if success and metadata.Version ~= nil then
        uptodate, ood_msg = VersionCheck(version, THIS_RELEASE_VERSION)
    else
        uptodate, ood_msg = false, "no msg"
    end

    Languages[#Languages+1] = {
        filename, {langcode}, author .. "\n" .. version,
        path = filepath, version = version, uptodate = uptodate, ood_msg = ood_msg, author = author, filename = filename, langcode = langcode,
    }
end

local SelectedLanguage
if #Languages > 1 then
    local LanguageSelector = menu.list_action(task_options, "Language", {"mblang"}, "", Languages, function(index, name)
        SelectedLanguage = name
        if index ~= 1 then
            if not Languages[index].uptodate then
                util.toast("翻译文件已过时!")
                util.log("Translation file is out of date!")
            end
            TranslateLabels(Languages[index])
        end
    end)
        
    while SelectedLanguage == nil do
        util.yield()
    end
        
    menu.delete(LanguageSelector)
else
    SelectedLangauge = Languages[1][1]
end
--#endregion Translation Functions

-----------------------------------
-- HTTP Functions
-----------------------------------
--#region HTTP Functions
local MOTD = ""

local HTTPHosts = {
    {HOST = "gist.githubusercontent.com", PATH = "/VSussyImpostor/8cf3bf39ae47218c4ee20a9ef96871ca/raw"},
    {HOST = "pastebin.com", PATH = "/raw/yaMG2Vz1"},
}

--HTTP Contents below
--[[
motd = ""
version = "0.3.2"
killswitch_safeloop = false
killswitch_specialcargo = false
killswitch_maxsellprice = false
killswitch_autocomplete = false
]]

local HTTP = {
    PENDING = false,
    SUCCESS = false,
    TRIES = 0,
    HOST = HTTPHosts[1].HOST,
    PATH = HTTPHosts[1].PATH,
    HOST_NUMBER = 1,
    SUCCESS_WAIT_TIME = (90 * 1000), -- 1 minute, 30 seconds
    GIVEUP_TIME = (30 * 1000), -- 30 seconds
    WAIT_TIME = (3 * 1000), -- 3 seconds
    FAILSAFE = false,
}

local remote = {
    motd = "",
    version = "",
    killswitches = {
        ["safeloop"] = false,
        ["specialcargo"] = false,
        ["maxsellprice"] = false,
        ["autocomplete"] = false,
    },
}

local function StringToBoolean(str)
    return str == "true"
end

local function LinesToTable(lines)
    local result = {}
    for s in lines:gmatch("[^\r\n]+") do
        table.insert(result, s)
    end
    return result
end

local function IsKeyKillswitch(key)
    return key:startswith("killswitch_")
end

local function GetKillswitchFromKey(key)
    -- 12 is the length of "killswitch_"
    return string.sub(key, 12, -1)
end

local function ActivateFailsafe()
    if not HTTP.FAILSAFE then
        util.toast(MenuLabels.HTTPFAILSAFE .. " (HTTP E3)")
        for name, value in pairs(remote.killswitches) do
            remote.killswitches[name] = true
        end
        HTTP.FAILSAFE = true -- in order to avoid this chunk of code running multiple times
    end
end

local function HandleHTTPResponse(response)
    for index, line in ipairs(LinesToTable(response)) do
        local key, value = GetKeyValueFromLine(line)
        if not key or not value then
            util.toast(MenuLabels.HTTPINVALID .. " (HTTP E2)")
            HTTP.SUCCESS = false -- don't immmediately trigger failsafe, treat this as a failed request
            return -- jump out of handling, try again
        end
        if IsKeyKillswitch(key) then
            remote.killswitches[GetKillswitchFromKey(key)] = StringToBoolean(value)
        else
            remote[key] = string.sub(value, 2, -2) -- drop the quotes
        end
    end

    HTTP.FAILSAFE = false -- reset failsafe if it triggered before

    if not IGNORE_VERSION_DIFFERENCE and IS_RELEASE_VERSION and not VersionCheck(THIS_RELEASE_VERSION, remote.version) then
        util.toast(MenuLabels.SCRIPTOUTOFDATE, TOAST_ALL)
    end

    if MOTD ~= remote.motd then
        MOTD = remote.motd
        if MOTD ~= "" then
            util.toast(GetLabelText(MenuLabels.PREFIX_MOTD, MOTD), TOAST_ALL) -- yeah i cant really think of a good way to only show this only after the script is "started". and a script "start" is a loose term here, so im going to base it on clicking the start button and thats it. any further input made by the user then causes those toasts to appear.
        end
    end
end

local function HTTPGiveUp()
    util.toast(MenuLabels.HTTPGIVEUP .. " (HTTP E1)", TOAST_ALL)
    ActivateFailsafe()
end

local function HTTPSwitchHost()
    HTTP.HOST_NUMBER = HTTP.HOST_NUMBER == #HTTPHosts and 1 or HTTP.HOST_NUMBER + 1
    HTTP.HOST = HTTPHosts[HTTP.HOST_NUMBER].HOST
    HTTP.PATH = HTTPHosts[HTTP.HOST_NUMBER].PATH
end

local function HTTPFail()
    -- if not IS_RELEASE_VERSION then
    --     util.toast("HTTP Attempt Failed.", TOAST_ALL)
    -- end
    HTTP.PENDING = false
    HTTP.SUCCESS = false
    HTTP.TRIES = HTTP.TRIES + 1
end

local function HTTPSuccess(response)
    -- if not IS_RELEASE_VERSION then
    --     util.toast("HTTP Attempt Succeeded.", TOAST_ALL)
    -- end
    HTTP.PENDING = false
    HTTP.SUCCESS = true
    HandleHTTPResponse(response)
end

local function HTTPTry()
    while HTTP.PENDING do -- prevent two http requests at once
        util.yield()
    end
    HTTP.PENDING = true
    async_http.init(HTTP.HOST, HTTP.PATH, HTTPSuccess, HTTPFail)
    async_http.dispatch()
    while HTTP.PENDING do
        util.yield()
    end
    return HTTP.SUCCESS
end

local function HTTPHeartbeat()
    HTTPTry()
    if HTTP.SUCCESS then
        util.yield(HTTP.SUCCESS_WAIT_TIME)
    elseif HTTP.TRIES == 1 then
        util.yield(HTTP.WAIT_TIME)
    elseif HTTP.TRIES == 2 then
        util.yield(HTTP.WAIT_TIME)
        HTTPSwitchHost()
    elseif HTTP.TRIES == 3 then
        util.yield(HTTP.WAIT_TIME)
    elseif HTTP.TRIES >= 4 then -- Forcing an HTTP connection by debug functions will increment the count, so we do >= to account for that case
        -- Our connection is fucked, give up
        HTTPGiveUp()
        util.yield(HTTP.GIVEUP_TIME)
        HTTP.TRIES = 0
    end
end

local loading_divider = menu.divider(task_options, MenuLabels.RETREIVINGINFO)
util.create_tick_handler(HTTPHeartbeat)

while not HTTP.SUCCESS and HTTP.TRIES < 4 do
    util.yield()
end

menu.delete(loading_divider)
--#endregion HTTP Functions

-----------------------------------
-- Custom Command Functions
-----------------------------------
--#region Custom Command Functions
local function RegisterUpdatingReadOnlyCommand(list, title, value_func)
    local command = menu.readonly(list, title, value_func())
    local handler = menu.on_tick_in_viewport(command, function() 
        menu.set_value(command, value_func())
    end)
    return command, handler
end
--#endregion Custom Command Functions

-----------------------------------
-- Basic Functions
-----------------------------------
--#region Basic Functions

local function SetBits(int, ...)
    local bits = {...}
    for ind, bit in ipairs(bits) do
        int = int | (1 << bit)
    end
    return int
end

local function ClearBits(int, ...)
    local bits = {...}
    for ind, bit in ipairs(bits) do
        int = int & ~(1 << bit)
    end
    return int
end

local function IsBitSet(int, offset)
    return ((int >> offset) & 1) == 1
end

local function IntToBitString(int)
    local bits = {}
    for i = 0, 31 do
        bits[31 - i] = IsBitSet(int, i) and 1 or 0
    end
    return table.concat(bits, "", 0)
end

local prefix = "MP" .. util.get_char_slot() .. "_"
local stat_ptr = memory.alloc(4)
---@return integer|nil
local function GetStatInt(stat)
    if STATS_STAT_GET_INT(util.joaat(stat), stat_ptr, -1) then
        return memory.read_int(stat_ptr)
    else
        --util.log("Failed to get stat " .. stat)
    end
    return nil
end

local function GetStatBool(stat)
    if STATS_STAT_GET_BOOL(util.joaat(stat), stat_ptr, -1) then
        return memory.read_bool(stat_ptr)
    else
        --util.log("Failed to get stat " .. stat)
    end
    return nil
end

local function GetPackedStatBool(stat)
    return STATS_GET_PACKED_STAT_BOOL_CODE(stat, util.get_char_slot())
end

local function SetStatInt(stat, value)
    if STATS_STAT_SET_INT(util.joaat(stat), value, true) then
        return true
    else
        --util.log("Failed to set stat "..stat.." to "..value)
    end
    return false
end

local function SetStatBool(stat, value)
    if STATS_STAT_SET_BOOL(util.joaat(stat), value, true) then
        return true
    else
        --util.log("Failed to set stat "..stat.." to "..value)
    end
    return false
end

local function SetPackedStatBool(stat, value)
    STATS_SET_PACKED_STAT_BOOL_CODE(stat, value, util.get_char_slot())
end

local function GetGlobalInt(address)
    return memory.read_int(memory.script_global(address))
end

local function GetGlobalFloat(address)
    return memory.read_float(memory.script_global(address))
end

local function SetGlobalInt(address, value)
    memory.write_int(memory.script_global(address), value)
end

local function SetGlobalFloat(address, value)
    memory.write_float(memory.script_global(address), value)
end

local function SetGlobalBits(address, ...)
    local value = GetGlobalInt(address)
    if value then
        return SetGlobalInt(address, SetBits(value, ...))
    end
end

local function GetLocalInt(script_str, script_local)
    local addr = memory.script_local(script_str, script_local)
    return addr ~= 0 and memory.read_int(addr) or nil
end

local function GetLocalFloat(script_str, script_local)
    local addr = memory.script_local(script_str, script_local)
    return addr ~= 0 and memory.read_float(addr) or nil
end

local function GetLocalString(script_str, script_local)
    local addr = memory.script_local(script_str, script_local)
    return addr ~= 0 and memory.read_string(addr) or nil
end

local function ClearGlobalBits(address, ...)
    local value = GetGlobalInt(address)
    if value then
        return SetGlobalInt(address, ClearBits(value, ...))
    end
end

local function SetLocalInt(script_str, script_local, value)
    local addr = memory.script_local(script_str, script_local)
    if addr ~= 0 then
        memory.write_int(addr, value)
    end
    return addr ~= 0
end

local function SetLocalFloat(script_str, script_local, value)
    local addr = memory.script_local(script_str, script_local)
    if addr ~= 0 then
        memory.write_float(addr, value)
    end
    return addr ~= 0
end

local function SetLocalString(script_str, script_local, value)
    local addr = memory.script_local(script_str, script_local)
    if addr ~= 0 then
        memory.write_string(addr, value)
    end
    return addr ~= 0
end

local function SetLocalBits(script_str, script_local, ...)
    local value = GetLocalInt(script_str, script_local)
    if value then
        return SetLocalInt(script_str, script_local, SetBits(value, ...))
    end
end

local function ClearLocalBits(script_str, script_local, ...)
    local value = GetLocalInt(script_str, script_local)
    if value then
        return SetLocalInt(script_str, script_local, ClearBits(value, ...))
    end
end

local function IsScriptRunning(str)
    return SCRIPT_GET_NUMBER_OF_THREADS_RUNNING_THE_SCRIPT_WITH_THIS_HASH(util.joaat(str)) > 0
end

local function StartScript(str, arg_count)
    if not SCRIPT_DOES_SCRIPT_EXIST(str) then
        return false
    end
    if IsScriptRunning(str) then
        return true
    end
    SCRIPT_REQUEST_SCRIPT(str)
    while not SCRIPT_HAS_SCRIPT_LOADED (str) do
        util.yield()
    end
    SYSTEM_START_NEW_SCRIPT(str, arg_count or 0)
    SCRIPT_SET_SCRIPT_AS_NO_LONGER_NEEDED(str)
    return true
end

local function IsInSession()
    return util.is_session_started() and not util.is_session_transition_active()
end

local function PressScaleformButton(buttonID)
    PAD_SET_CONTROL_VALUE_NEXT_FRAME(2, buttonID, 1)
    util.yield()
    PAD_SET_CONTROL_VALUE_NEXT_FRAME(2, buttonID, 0) -- this line is probably not needed but oh well
end


local function PressEnterOnScaleform()
    PressScaleformButton(201)
end

local function PressBackOnScaleform()
    PressScaleformButton(202)
end

local function SetEntityCoords(entity, coords)
    ENTITY_SET_ENTITY_COORDS_NO_OFFSET(entity, coords.x, coords.y, coords.z, false, false, false)
end

local function LoadArea(coords)
    local has_ground, ground_z = util.get_ground_z(coords.x, coords.y, coords.z)
    if not has_ground then
        local rot = CAM_GET_FINAL_RENDERED_CAM_ROT(2)
        local cam = CAM_CREATE_CAM_WITH_PARAMS("DEFAULT_SCRIPTED_CAMERA", coords.x, coords.y, coords.z+2, rot.x, rot.y, rot.z, CAM_GET_FINAL_RENDERED_CAM_FOV(), true, 2)
        CAM_SET_CAM_ACTIVE(cam, true)
        CAM_RENDER_SCRIPT_CAMS(true, false, 0, false, false, 0)
        local count = 0
        local max = 500
        while not has_ground and count < max do
            has_ground, ground_z = util.get_ground_z(coords.x, coords.y, coords.z+count)
            count = count + 1
            util.yield()
        end
        CAM_RENDER_SCRIPT_CAMS(false, false, 0, false, false, 0)
        CAM_SET_CAM_ACTIVE(cam, false)
        CAM_DESTROY_CAM(cam, false)
        return max > count
    end
    return true
end

local function AddToTotalEarned(amount, type)
    type.amount = type.amount + amount
    local str = type and GetLabelText(type.prefix, GetLabelText(MenuLabels.PREFIX_TOTALEARNED, type.amount)) or GetLabelText(MenuLabels.PREFIX_TOTALEARNED, type.amount)
    util.toast(str, TOAST_ABOVE_MAP | TOAST_LOGGER)
end
--#endregion Basic Functions

-----------------------------------
-- Global Functions
-----------------------------------
--#region Global Functions

local function GetOrgOffset()
    return (1894573 + 1 + (players.user() * 608) + 10)
end

local function IsInOrg()
    return GetGlobalInt(GetOrgOffset()) ~= -1
end

local function GetOrgType()
    -- Returns -1, 0, 1. None, CEO, MC. This will only work if you are the boss of the org
    return GetGlobalInt(GetOrgOffset() + 428)
end

local function RegisterAsCEO()
    if IsInSession() and not IsInOrg() then
        SetGlobalInt(GetOrgOffset(), players.user()) -- Set self as boss
        SetGlobalInt(GetOrgOffset() + 428, 0) -- Set type to CEO
    end
end

-- Business / Other Online Work Stuff
local function GetOnlineWorkOffset()
    return (1853910 + 1 + (players.user() * 862) + 267)
end

local function GetNightClubHubOffset()
    return (GetOnlineWorkOffset() + 310) -- 295
end

local function GetNightClubOffset()
    return (GetOnlineWorkOffset() + 353) -- 336
end

local function GetWarehouseOffset()
    return (GetOnlineWorkOffset() + 116) + 1 -- 114
end

local function GetMCBusinessOffset()
    return (GetOnlineWorkOffset() + 193) + 1 -- 191
end

-- Nightclub
local function GetHubValueOffsetFromSlot(slot) 
    return (GetNightClubHubOffset() + 8 + 1) + slot
end

local function GetHubValueFromSlot(slot)
    return GetGlobalInt(GetHubValueOffsetFromSlot(slot))
end

local function SetHubValueFromSlot(slot, value)
    SetGlobalInt(GetHubValueOffsetFromSlot(slot), value)
end

local function GetHubProductOfTypeFromStat(slot)
    return GetStatInt(prefix .. "HUB_PROD_TOTAL_" .. slot)
end

local function GetSafeCashValueFromStat()
    return GetStatInt(prefix .. "CLUB_SAFE_CASH_VALUE")
end

local function GetNightClubPropertyID()
    return GetGlobalInt(GetNightClubOffset())
end

-- MC Businesses
local function GetMCBusinessDataOffset(slot)
    return GetMCBusinessOffset() + (slot * 13)
end

local function GetMCBusinessProductionSpeed2(slot)
    return GetMCBusinessDataOffset(slot) + 9
end

local function GetBusinessSuppliesFromStat(slot)
    return GetStatInt(prefix .. "MATTOTALFORFACTORY" .. slot)
end

local function GetBusinessProductFromStat(slot)
    return GetStatInt(prefix .. "PRODTOTALFORFACTORY" .. slot)
end

local function GetBunkerResearchFromStat()
    return GetStatInt(prefix .. "RESEARCHTOTALFORFACTORY5")
end

local function GetMCBusinessEquipmentUpgradeStatusFromStat(slot)
    return GetStatInt(prefix .. "FACTORYUPGRADES" .. slot)
end

local function GetMCBusinessStaffUpgradeStatusFromStat(slot)
    return GetStatInt(prefix .. "FACTORYUPGRADES" .. slot .. "_1")
end

-- Special Cargo
local function GetSpecialCargoCrateAmountOffset(slot)
    return GetWarehouseOffset() + (slot * 3) + 1
end

local function GetSpecialCargoCrateAmount(warehouse)
    return GetGlobalInt(GetSpecialCargoCrateAmountOffset(warehouse))
end

local function SetSpecialCargoCrateAmount(warehouse, value)
    return SetGlobalInt(GetSpecialCargoCrateAmountOffset(warehouse), value)
end
--#endregion Global Functions

local function PopulateMyBusinessesTable()
    if util.is_session_started() then
        for slot = 0, 4 do
            local property      = GetStatInt(prefix .. "factoryslot" .. slot) -- returns a property ID number
            local property_info = MCBusinessPropertyInfo[property]
            local type_number   = property_info and property_info.type or -1
            local type_string   = property_info and MCBusinessTypesOrderedWithLabels[type_number].name or "None"
            

            MyBusinesses[slot]         = {property = property, type = type_number}
            MyBusinesses[type_string]  = {
                slot = slot,                        property = property,
                product = GetBusinessProductFromStat(slot), supplies = GetBusinessSuppliesFromStat(slot),
            }
        end

        do -- Bunker
            local slot_and_type = 5
            local property      = GetStatInt(prefix .. "factoryslot" .. slot_and_type) -- returns a property ID number
            local type_string   = MCBusinessTypesOrderedWithLabels[slot_and_type].name
            

            MyBusinesses[slot_and_type]    = {property = property, type = slot_and_type}
            MyBusinesses[type_string]       = {property = property, slot = 5,
                product = GetBusinessProductFromStat(slot_and_type), supplies = GetBusinessSuppliesFromStat(slot_and_type),
                research = GetBunkerResearchFromStat()
            }
        end

        for index, data in pairs(HubTypesOrderedWithLabels) do
            --MyBusinesses.Hub[data.name] = GetHubProductOfType(index) -- this reads the stat, Set Product manipluates the global only. Set Max Sell Price with this wont work.
            MyBusinesses.Hub[data.name] = GetHubValueFromSlot(index) -- however, this one will work since its reading the global.
        end
    end
end

-- returns true if already alone, false if it it had to bealone
local function CheckIfAlone()
    if #players.list() > 1 then
        util.toast(MenuLabels.BEALONE_TOAST)
        menu.trigger_commands("bealone")
        util.yield(1000)
        return false
    end
    return true
end

local function GetPlayerPropertyOffset()
    return (2657589 + 1 + (players.user() * 466) + 321 + 7)
end

local function GetPlayerPropertyID()
    return GetGlobalInt(GetPlayerPropertyOffset())
end

local function SetPlayerPropertyID(id)
    return SetGlobalInt(GetPlayerPropertyOffset(), id)
end

local function SetPlayerInOrgWork(work_id)
    if IsInSession() then
        SetGlobalInt(GetOrgOffset() + 33, work_id)
        SetGlobalInt(GetOrgOffset() + 35, work_id)
    end
end

local function GetPlayerInOrgWork()
    return IsInSession() and GetGlobalInt(GetOrgOffset() + 33) or -1
end

-- Special Cargo
local function GetWarehouseSlotFromProperty(warehouse)
    for slot = 0, 4 do
        if GetGlobalInt(GetWarehouseOffset() + (slot * 3)) == warehouse then
            return slot
        end
    end
    return -1
end

local function GetWarehousePropertyFromSlot(slot)
    return GetGlobalInt(GetWarehouseOffset() + (slot * 3))
end

local function SetSpecialCargoValues(state)
    local MaxSellPrice = globals.SpecialCargoMaxSellPriceValue
    if state then
        

        util.create_thread(function()
            local warehouse = GetLocalInt(locals.SpecialCargoSecuroString, locals.SpecialCargoCurrentProperty)
            if warehouse ~= nil then
                if warehouse ~= 0 and warehouse ~= GetWarehousePropertyFromSlot(Selected_Warehouse) then
                    util.toast(MenuLabels.NOTINSELECTEDWAREHOUSE_TOAST)
                end
            end
        end)

        local crate_amount = GetSpecialCargoCrateAmount(Selected_Warehouse)

        if crate_amount > 0 then
            SetGlobalInt(globals.SpecialCargoCrateMaxThreshold, 0)
            SetGlobalInt(globals.SpecialCargoRewardPerCrate, MaxSellPrice)
            local rounded = math.floor(100 / crate_amount)
            local ceiled  = math.ceil(100 / crate_amount)
            if (crate_amount <= 6) or (crate_amount >= 100) then
                SetGlobalInt(globals.SpecialCargoCrateMultiplier3, ceiled)
                SetGlobalInt(globals.SpecialCargoCrateMultiplier2, ceiled)
                SetGlobalInt(globals.SpecialCargoCrateMultiplier1, ceiled)
            else
                SetGlobalInt(globals.SpecialCargoCrateMultiplier3, rounded)
                SetGlobalInt(globals.SpecialCargoCrateMultiplier2, rounded)
                SetGlobalInt(globals.SpecialCargoCrateMultiplier1, rounded)
            end
        end
    else
        SetGlobalInt(globals.SpecialCargoCrateMaxThreshold, 111) -- 111
        SetGlobalInt(globals.SpecialCargoRewardPerCrate,    20000) -- 20000
        SetGlobalInt(globals.SpecialCargoCrateMultiplier3,  100) -- 100
        SetGlobalInt(globals.SpecialCargoCrateMultiplier2,  50) -- 50
        SetGlobalInt(globals.SpecialCargoCrateMultiplier1,  20) -- 20
    end
end

local function GetSpecialCargoCrateAmountFromStat(slot)
    return GetStatInt(prefix .. "contotalforwhouse" .. slot) or 0
end

-- Nightclub
local function GetSafeCashValueGlobal()
    return GetGlobalInt(GetNightClubOffset() + 5)
end

local function IsPlayerInNightclub()
    return (GetPlayerPropertyID() > 101) and (GetPlayerPropertyID() < 112)
end

local function TriggerNCSafeAddMoneyTransaction(amount, bypass_rollover_protection)
    if not IsInSession() then
        return
    end
    local aaa = GetLocalInt(locals.NCSafeScriptString, locals.NCSafeAddMoneyAmount)
    if not aaa then
        return
    end
    local SafeValue = GetSafeCashValueGlobal()
    local safemax = 300000

    if not bypass_rollover_protection then
        if (SafeValue > safemax) then
            amount = I32_MAX - SafeValue + 2
        elseif (SafeValue + amount) > safemax then
            util.toast("The amount given would put you over the maximum limit! Cancelling addition.", TOAST_ALL) --! Needs a label, but this should never be seen by the user anyways
            return
        elseif (SafeValue == -2147483648) then
            amount = 2147483647
        elseif (SafeValue < 0) then
            amount = math.abs(SafeValue)
        end
    end

    SetLocalInt(locals.NCSafeScriptString, locals.NCSafeAddMoneyAmount, amount)
    SetGlobalInt(globals.SafeStatus1, ClearBits(GetGlobalInt(globals.SafeStatus1), 1))
    SetLocalInt(locals.NCSafeScriptString, locals.NCSafeTransactionStatus, 2)
    SetGlobalInt(globals.SafeStatus2, 2)
    util.yield(3000)
end

local function FixNCSafe()
    local GetSafeValue = GetSafeCashValueFromStat
    if not (IsInSession() and (GetSafeValue() > 300000 or GetSafeValue() < 0)) then
        util.toast(MenuLabels.NCRESETSAFEVALUESKIP_TOAST)
        return
    end
    while IsInSession() and (GetSafeValue() > 300000 or GetSafeValue() < 0) do
        if IsPlayerInNightclub() then
            SetEntityCoords(PLAYER_PLAYER_PED_ID(), {x = -1620.5, y = -3014.9, z = -75.2})
        end
        local before = GetSafeValue()
        TriggerNCSafeAddMoneyTransaction(300000, false)
        local after = GetSafeValue()
        if before == after then
            util.toast(MenuLabels.TRANSACTIONSSTUCK_TOAST)
            return
        elseif (after <= 300000 and after >= 0) then
            util.toast(MenuLabels.NCRESETSAFEVALUESUCCESS_TOAST)
            return
        end
        util.yield()
    end
end

local function FixNCHubCapacities()
    SetGlobalBits((GetNightClubHubOffset() + 4), 0, 1, 2, 3, 4) -- This will correct your nightclub capacity values if for some reason rockstar decided to fuck you over, although its only a temp fix. thanks r*
end

local function SetNightclubPayTimeLeft(time)
    return SetStatInt(prefix .. "CLUB_PAY_TIME_LEFT", time or -1)
end

-- MC Business
local function ResupplyBusinessSlot(slot)
    SetGlobalInt(globals.MCSupplyTime + slot, 1)
end

local function TeleportToMCProperty(property_id)
    if property_id ~= 0 and IsInSession() then
        local coords = MCBusinessPropertyInfo[property_id].coords
        if LoadArea(coords) then
            SetEntityCoords(PLAYER_PLAYER_PED_ID(), coords)
        end
    end
end

----------------------------------
-- Start of menu options
----------------------------------

menu.divider(task_options, MenuLabels.SALESABUSE_DIVIDER)

----------------------------------
-- Special Cargo Shit
----------------------------------
--#region Special Cargo Shit
local SCMan = menu.list(task_options, MenuLabels.SPECIALCARGO, {}, MenuLabels.SPECIALCARGOLIST_DESC)

local WarehouseSelector = menu.list_select(SCMan, MenuLabels.WAREHOUSE, {"selectcargowarehouse"}, MenuLabels.SPECIALCARGOWAREHOUSE_DESC, MenuCurrentWarehouses, 0, function(value)
    Selected_Warehouse = value
end)

menu.action(SCMan, GetLabelText(MenuLabels.TELEPORTTO, MenuLabels.WAREHOUSE), {"tptocargowarehouse"}, GetLabelText(MenuLabels.TELEPORTTO_DESC, MenuLabels.WAREHOUSE), function()
    local tbl = WarehousePropertyInfo[GetWarehousePropertyFromSlot(Selected_Warehouse)]
    if tbl ~= nil then
        local pos = tbl.coords
        SetEntityCoords(PLAYER_PLAYER_PED_ID(), pos)
    end
end)

menu.toggle_loop(SCMan, MenuLabels.MONITOR, {"monitorcargo"}, GetLabelText(MenuLabels.MONITOR_DESC, MenuLabels.CRATES, MenuLabels.WAREHOUSE, MenuLabels.INFOOVERLAY), function()
    if IsInSession() then
        local crate_amount = GetSpecialCargoCrateAmountFromStat(Selected_Warehouse)
        local warehouse_property_info = WarehousePropertyInfo[GetWarehousePropertyFromSlot(Selected_Warehouse)]
        local capacity = warehouse_property_info and warehouse_property_info.capacity or "unk"
        util.draw_debug_text(GetLabelText(MenuLabels.INFO_SCWAREHOUSE, Selected_Warehouse+1, crate_amount, capacity))
    end
end)

local SCRefs = {}

SCRefs[#SCRefs+1] = menu.toggle_loop(SCMan, MenuLabels.MAXSELLPRICE, {"maxsellcargo"}, MenuLabels.SPECIALCARGOMAXSELLPRICE_DESC, function()
    if remote.killswitches.specialcargo or remote.killswitches.maxsellprice then
        util.toast(remote.killswitches.maxsellprice and MenuLabels.KILLSWITCH_MAXSELLPRICE or MenuLabels.KILLSWITCH_SPECIALCARGO)
        SetSpecialCargoValues(false)
        util.stop_thread()
        return
    end

    if IsInSession() then
        CheckIfAlone()
        SetSpecialCargoValues(true)
    end
end, function()
    SetSpecialCargoValues(false)
end)

SCRefs[#SCRefs+1] = menu.toggle_loop(SCMan, GetLabelText(MenuLabels.BYPASSCOOLDOWN, MenuLabels.BUYMISSION), {"nobuycdcargo"}, GetLabelText(MenuLabels.BYPASSCOOLDOWN_DESC, MenuLabels.START, MenuLabels.BUYMISSION), function()
    if remote.killswitches.specialcargo then
        util.toast(MenuLabels.KILLSWITCH_SPECIALCARGO)
        SetGlobalInt(globals.SpecialCargoBypassBuyCooldown, 300000)
        util.stop_thread()
        return
    end

    SetGlobalInt(globals.SpecialCargoBypassBuyCooldown, 0)
end, function()
    SetGlobalInt(globals.SpecialCargoBypassBuyCooldown, 300000)
end)

SCRefs[#SCRefs+1] = menu.toggle_loop(SCMan, GetLabelText(MenuLabels.BYPASSCOOLDOWN, MenuLabels.SELLMISSION), {"nosellcdcargo"}, GetLabelText(MenuLabels.BYPASSCOOLDOWN_DESC, MenuLabels.START, MenuLabels.SELLMISSION), function()
    if remote.killswitches.specialcargo then
        util.toast(MenuLabels.KILLSWITCH_SPECIALCARGO)
        SetGlobalInt(globals.SpecialCargoBypassSellCooldown, 1800000)
        util.stop_thread()
        return
    end

    SetGlobalInt(globals.SpecialCargoBypassSellCooldown, 0)
end, function()
    SetGlobalInt(globals.SpecialCargoBypassSellCooldown, 1800000)
end)

do
    local function sell_func_423()  -- sell_func_423
        local val = GetLocalInt(locals.SpecialCargoSellString, locals.SpecialCargoSellSubType)
        if val then
            if val == 8 or val == 11 or val == 7 then
                local val2 = GetGlobalInt(globals.SpecialCargoSellFuncSomething)
                if val2 <= 4 then
                    return 3
                elseif val2 <= 9 then
                    return 6
                else
                    return 10
                end
            elseif val == 1 or val == 2 or val == 10 then
                return 5
            end
        end
        return 1
    end

    local function get_sell_mission_goal() -- sell_func_422
        local val = GetLocalInt(locals.SpecialCargoSellString, locals.SpecialCargoSellType)
        if val then
            local ret = sell_func_423()
            if val == 0 or val == 2 or val == 3 or val == 4 then
                return ret
            elseif val == 1 or val == 5 then
                return ret * 2
            elseif val == 6 or val == 7 then
                return ret * 3
            end
        end
        return -1
    end

    SCRefs[#SCRefs+1] = menu.toggle_loop(SCMan, GetLabelText(MenuLabels.AUTOCOMPLETE, MenuLabels.BUYMISSION), {"autocompletespecialbuy"}, GetLabelText(MenuLabels.AUTOCOMPLETE_DESC, MenuLabels.BUYMISSION), function()
        if remote.killswitches.specialcargo or remote.killswitches.autocomplete then
            util.toast(remote.killswitches.autocomplete and MenuLabels.KILLSWITCH_AUTOCOMPLETE or  MenuLabels.KILLSWITCH_SPECIALCARGO)
            util.stop_thread()
            return
        end

        if GetLocalInt(locals.SpecialCargoBuyString, 1) then -- just checking local_1 to see if script is running
            if GetLocalInt(locals.SpecialCargoBuyString, locals.SpecialCargoBuyComplete) ~= 1 then
                SetLocalInt(locals.SpecialCargoBuyString, locals.SpecialCargoBuyCollected, SetBits(GetLocalInt(locals.SpecialCargoBuyString, locals.SpecialCargoBuyCollected), 23, 24, 25)) -- set crate slots
                SetLocalInt(locals.SpecialCargoBuyString, locals.SpecialCargoBuyCollected2, SetBits(GetLocalInt(locals.SpecialCargoBuyString, locals.SpecialCargoBuyCollected2), 0, 1, 2, 4, 5, 6)) -- set crate slots
                SetLocalInt(locals.SpecialCargoBuyString, locals.SpecialCargoBuyComplete, 1) -- mark mission complete
            end
        end
    end)

    local function AutoCompleteSellMission()
        if GetLocalInt(locals.SpecialCargoSellString, 1) then -- just checking local_1 to see if script is running
            -- Enforce easiest mission / enforce no enemies mission (aka the one that doesn't auotcomplete)
            SetLocalInt(locals.SpecialCargoSellString, locals.SpecialCargoSellType, 0)
            SetLocalInt(locals.SpecialCargoSellString, locals.SpecialCargoSellSubType, 2) -- 3
            if GetLocalInt(locals.SpecialCargoSellString, locals.SpecialCargoSellStatus) ~= -1 then
                -- Okay, value is no longer -1, script is ready, so set it to the max needed to complete
                SetLocalInt(locals.SpecialCargoSellString, locals.SpecialCargoSellAmount, get_sell_mission_goal())
                return true
            end
        end
    end

    local function StartSellMission()
        if IsInSession() then
            if GetLocalInt(locals.SpecialCargoSecuroString, 0) then
                SetLocalInt(locals.SpecialCargoSecuroString, locals.SpecialCargoCratesToSell, 1)
                SetLocalInt(locals.SpecialCargoSecuroString, locals.SpecialCargoSellFromOption, 1)
                SetLocalInt(locals.SpecialCargoSecuroString, locals.SpecialCargoScreenStatus, 3012)
                return true
            end
        end
    end

    local function OpenWarehouseScreen()
        if IsInSession() then
            if not IsScriptRunning(locals.SpecialCargoSecuroString) then
                if StartScript(locals.SpecialCargoSecuroString, locals.SpecialCargoSecuroArgs) then
                    if GetLocalInt(locals.SpecialCargoSecuroString, 0) then
                        SetPlayerPropertyID(GetWarehousePropertyFromSlot(Selected_Warehouse)-1) --set global current property to warehouse one
                        SetLocalBits(locals.SpecialCargoSecuroString, locals.SpecialCargoCurrentBitset, 13)
                        SetLocalInt(locals.SpecialCargoSecuroString, locals.SpecialCargoCurrentProperty, GetWarehousePropertyFromSlot(Selected_Warehouse)) --set this local to current selected warehouse property id (non-global-index based)
                        local pos = ENTITY_GET_ENTITY_COORDS(PLAYER_PLAYER_PED_ID())
                        SetLocalFloat(locals.SpecialCargoSecuroString, locals.SpecialCargoStartingPosX, pos.x) -- set this local to current location every tick (if self is greater than 5f to this local, kill script)
                        SetLocalFloat(locals.SpecialCargoSecuroString, locals.SpecialCargoStartingPosY, pos.y)
                        SetLocalFloat(locals.SpecialCargoSecuroString, locals.SpecialCargoStartingPosZ, pos.z)
                        util.yield()
                        return true
                    end
                end
            else
                --return true
            end
        end
    end

    local function OpenTerrorbyteScreen()
        if IsInSession() then
            SetGlobalInt(globals.IsUsingComputerScreen, 1)
            StartScript(locals.SpecialCargoBuyScreenString, locals.SpecialCargoBuyScreenArgs)
        end
    end

    SCRefs[#SCRefs+1] = menu.toggle_loop(SCMan, GetLabelText(MenuLabels.AUTOCOMPLETE, MenuLabels.SELLMISSION), {"autocompletespecialsell"}, GetLabelText(MenuLabels.AUTOCOMPLETE_DESC, MenuLabels.SELLMISSION), function()
        if remote.killswitches.specialcargo then
            util.toast(MenuLabels.KILLSWITCH_SPECIALCARGO)
            util.stop_thread()
            return
        end

        if IsInSession() then
            if AutoCompleteSellMission() then
                AddToTotalEarned(globals.SpecialCargoMaxSellPriceValue, TotalEarnedTypes.specialcargo)
                util.yield(1000)
                SetPlayerInOrgWork(-1)
            end
        end
    end)

    menu.action(SCMan, GetLabelText(MenuLabels.OPENSCREEN, MenuLabels.TERRORBYTE), {"openterrorbyte"}, GetLabelText(MenuLabels.OPENSCREEN_DESC, MenuLabels.TERRORBYTE), function()
        if remote.killswitches.specialcargo then
            util.toast(MenuLabels.KILLSWITCH_SPECIALCARGO)
            return
        end

        if IsInSession() then
            if not IsInOrg() then
                RegisterAsCEO()
            end
            OpenTerrorbyteScreen()
        end
    end)

    menu.action(SCMan, GetLabelText(MenuLabels.OPENSCREEN, MenuLabels.WAREHOUSE), {"openwarehouse"}, GetLabelText(MenuLabels.OPENSCREEN_DESC, MenuLabels.WAREHOUSE), function()
        if remote.killswitches.specialcargo then
            util.toast(MenuLabels.KILLSWITCH_SPECIALCARGO)
            return
        end

        if IsInSession() then
            if not IsInOrg() then
                RegisterAsCEO()
            end

            OpenWarehouseScreen()

            while IsScriptRunning(locals.SpecialCargoSecuroString) do
                local pos = ENTITY_GET_ENTITY_COORDS(PLAYER_PLAYER_PED_ID())
                SetLocalFloat(locals.SpecialCargoSecuroString, locals.SpecialCargoStartingPosX, pos.x)
                SetLocalFloat(locals.SpecialCargoSecuroString, locals.SpecialCargoStartingPosY, pos.y)
                SetLocalFloat(locals.SpecialCargoSecuroString, locals.SpecialCargoStartingPosZ, pos.z)
                util.yield()
            end
        end
    end)

    menu.action(SCMan, MenuLabels.SELLACRATE, {"sellacrate"}, MenuLabels.SELLACRATE_DESC, function()
        if remote.killswitches.specialcargo then
            util.toast(MenuLabels.KILLSWITCH_SPECIALCARGO)
            return
        end

        if IsInSession() then
            SetPlayerPropertyID(-1) -- I mean, the script will end up kicking you out of your interior to begin the sell mission anyways

            if not IsInOrg() then
                RegisterAsCEO()
                util.yield()
            end

            local crates_amount_offset = (GetWarehouseOffset() + (Selected_Warehouse * 3) + 1)
            local stat_amount = GetSpecialCargoCrateAmountFromStat(Selected_Warehouse) or 0
            SetGlobalInt(crates_amount_offset, stat_amount or 0)

            if OpenWarehouseScreen() or IsScriptRunning(locals.SpecialCargoSecuroString) then
                util.yield()
                if GetSpecialCargoCrateAmountFromStat(Selected_Warehouse) > 0 then
                    StartSellMission()
                    SetPlayerPropertyID(-1)
                else
                    util.toast(MenuLabels.SPECIALCARGONOMORECRATES)
                end
            end
        end
    end)

    local function SpecialCargoSourceNow()
        if IsInSession() then
            STATS_SET_PACKED_STAT_BOOL_CODE(32359 + Selected_Warehouse, true, util.get_char_slot())
            SetPlayerPropertyID(-1)
        end
    end

    menu.toggle_loop(SCMan, "挂机循环刷钱", {"scafkloop"}, "为了获得最佳效果,最好有一个稳定的网络和高的游戏帧数.", function() --! needs a label
        if remote.killswitches.specialcargo then
            util.toast(MenuLabels.KILLSWITCH_SPECIALCARGO)
            return
        end

        for index, ref in ipairs(SCRefs) do
            if not menu.get_value(ref) then
                menu.trigger_command(ref, "on")
            end
        end

        if not IsInOrg() then
            RegisterAsCEO()
            util.yield()
        elseif GetOrgType() == 1 then
            util.toast(MenuLabels.SPECIALCARGONEEDCEO)
            util.yield(200)
            return
        end

        local stat_amount = GetSpecialCargoCrateAmountFromStat(Selected_Warehouse) or 0
        SetGlobalInt(GetSpecialCargoCrateAmountOffset(Selected_Warehouse), stat_amount or 0)

        if GetSpecialCargoCrateAmountFromStat(Selected_Warehouse) == 0 then
            util.toast("Out of crates") --! needs a label
            TERMINATE_ALL_SCRIPTS_WITH_THIS_NAME(locals.SpecialCargoSecuroString)
            SpecialCargoSourceNow()
            -----------------------------
            -- This may or may not "out of crates" bugs
            SetSpecialCargoCrateAmount(Selected_Warehouse, GetSpecialCargoCrateAmountFromStat(Selected_Warehouse))
            -----------------------------
            SetPlayerInOrgWork(-1)
            util.yield(200)
        else
            if GetPlayerInOrgWork() == -1 and OpenWarehouseScreen() then
                if StartSellMission() then
                    local count = 0
                    local crates = GetSpecialCargoCrateAmountFromStat(Selected_Warehouse)
                    local crates2 = GetSpecialCargoCrateAmount(Selected_Warehouse)
                    while crates == GetSpecialCargoCrateAmountFromStat(Selected_Warehouse) or crates2 == GetSpecialCargoCrateAmount(Selected_Warehouse) do
                        count += 1

                        if count > 100 then
                            util.toast("stuck waiting")
                            PressBackOnScaleform()
                            return
                        end

                        util.toast("Waiting...")
                        util.yield(100)
                    end
                    util.yield_x(2)
                end
            end
        end
    end)

    --#region NON_RELEASE_VERSION
        if not IS_RELEASE_VERSION then

            menu.action(SCMan, "Trigger Technician Source", {"triggerscsource"}, "", function()
                SpecialCargoSourceNow()
            end)
        end
    --#endregion NON_RELEASE_VERSION 
end

SCRefs[#SCRefs+1] = menu.toggle_loop(SCMan, MenuLabels.SPECIALCARGOMAXCRATESOURCE, {}, MenuLabels.SPECIALCARGOMAXCRATESOURCE_DESC, function()
    if remote.killswitches.specialcargo then
        util.toast(MenuLabels.KILLSWITCH_SPECIALCARGO)
        util.stop_thread()
        return
    end

    if IsInSession() then
        local crate_amount = GetSpecialCargoCrateAmountFromStat(Selected_Warehouse)
        local warehouse_property_info = WarehousePropertyInfo[GetWarehousePropertyFromSlot(Selected_Warehouse)]
        if warehouse_property_info then
            local capacity = warehouse_property_info.capacity
            SetGlobalInt(globals.SpecialCargoDeliveryCrates, capacity - 1)
        end
    end
end)

SCRefs[#SCRefs+1] = menu.toggle_loop(SCMan, MenuLabels.SPECIALCARGOSETDELIVERTIME, {}, MenuLabels.SPECIALCARGOSETDELIVERTIME_DESC, function()
    if remote.killswitches.specialcargo then
        util.toast(MenuLabels.KILLSWITCH_SPECIALCARGO)
        SetGlobalInt(globals.SpecialCargoDeliveryTime, 48)
        util.stop_thread()
        return
    end

    if IsInSession() then
        SetGlobalInt(globals.SpecialCargoDeliveryTime, 0)
    end
end)
--#endregion Special Cargo Shit

----------------------------------
-- Nightclub Shit
----------------------------------
--#region Nightclub Shit
local NCMan = menu.list(task_options, MenuLabels.NIGHTCLUB, {}, MenuLabels.NCLIST_DESC)

    menu.action(NCMan, GetLabelText(MenuLabels.TELEPORTTO, MenuLabels.NIGHTCLUB), {"tpnightclub"}, GetLabelText(MenuLabels.TELEPORTTO_DESC, MenuLabels.NIGHTCLUB), function()
        if IsInSession() then
            local property = GetNightClubPropertyID()
            if property ~= 0 and IsInSession() then
                local coords = NightclubPropertyInfo[property].coords
                if LoadArea(coords) then
                    SetEntityCoords(PLAYER_PLAYER_PED_ID(), coords)
                end
            end
        end
    end)

    menu.toggle_loop(NCMan, GetLabelText(MenuLabels.BYPASSCOOLDOWN, MenuLabels.SELLMISSION), {}, GetLabelText(MenuLabels.BYPASSCOOLDOWN_DESC, MenuLabels.START, MenuLabels.SELLMISSION), function()
        if IsInSession() then
            SetGlobalInt(globals.Hub.SellCooldownActive, 0)

            if IsScriptRunning(locals.NCHubScriptString) then
                local int = GetLocalInt(locals.NCHubScriptString, locals.NCHubSellCooldown)
                if int then
                    ClearLocalBits(locals.NCHubScriptString, locals.NCHubSellCooldown, locals.NCHubSellCooldownBit)
                end
            end
        end
    end)

    -- Generate Nightclub options
    for index = 0, #HubTypesOrderedWithLabels do
        local name = HubTypesOrderedWithLabels[index].name
        local label = HubTypesOrderedWithLabels[index].label
        local list = menu.list(NCMan, label)

        menu.toggle_loop(list, MenuLabels.MONITOR, {"monitorhub"..name}, GetLabelText(MenuLabels.MONITOR_DESC, MenuLabels.STOCK, MenuLabels.NIGHTCLUB, MenuLabels.INFOOVERLAY), function()
            if IsInSession() then
                local value = GetGlobalInt(globals.Hub[name].Cap)
                util.draw_debug_text(GetLabelText(MenuLabels.INFO_HUBBUSINESS, label, MyBusinesses.Hub[name], value))
            end
        end)

        menu.toggle_loop(list, MenuLabels.MAXSELLPRICE, {"maxsellhub"..name}, GetLabelText(MenuLabels.MAXSELLPRICE_DESC, MenuLabels.STOCK, MenuLabels.STOCK), function()
            if remote.killswitches.maxsellprice then
                util.toast(MenuLabels.KILLSWITCH_MAXSELLPRICE)
                SetGlobalInt(globals.Hub[name].Sell, globals.Hub[name].SellDefaultValue)
                util.stop_thread()
                return
            end
    
            if IsInSession() then
                if MyBusinesses.Hub[name] ~= 0 then
                    CheckIfAlone()
                    SetGlobalInt(globals.Hub[name].Sell, globals.Hub.MaxSellPrice // MyBusinesses.Hub[name])
                end
            end
        end, function()
            SetGlobalInt(globals.Hub[name].Sell, globals.Hub[name].SellDefaultValue)
        end)

        local toggle_active
        menu.toggle(list, MenuLabels.MAXPRODUCTIONSPEED, {"maxprodhub"..name}, MenuLabels.NCMAXPRODUCTIONSPEED_DESC, function(toggle)
            toggle_active = toggle
            if toggle then
                --! Missing Global Here (one that goes into effect immediately)
                util.toast(MenuLabels.MAXPRODUCTIONSPEEDSLOW_TOAST)
            end
            while toggle_active do
                if IsInSession() then
                    SetGlobalInt(globals.Hub[name].ProSpd, globals.Hub.ProSpd)
                end
                util.yield()
            end
        end)

        menu.click_slider(list, MenuLabels.MAXIMUMCAPACITY, {"setcaphub"..name}, MenuLabels.MAXIMUMCAPACITY_DESC, 1, 999, GetGlobalInt(globals.Hub[name].Cap), 5, function(value)
            if IsInSession() then
                SetGlobalInt(globals.Hub[name].Cap, value)
                util.toast(MenuLabels.MAXIMUMCAPACITY_TOAST)
            end
        end)

        -- if not IS_RELEASE_VERSION then
        --!     this was probably patched by rockstar? cant be arsed to fix this, nobody really used it anyways?
        --     menu.click_slider(list, "[DEBUG] " .. MenuLabels.SETPRODUCT, {"setproducthub"..name}, MenuLabels.SETPRODUCT_DESC, 0, GetGlobalInt(globals.Hub[name].Cap), GetGlobalInt(globals.Hub[name].Cap), 1, function(value) --! implement default values for set product limits
        --         if IsInSession() then
        --             SetHubValueFromSlot(index, value)
        --             util.toast(MenuLabels.SETPRODUCT_TOAST)
        --         end
        --     end)
        -- end
    end

    ----------------------------------
    -- Nightclub Safes
    ----------------------------------

    local NCSafe = menu.list(NCMan, MenuLabels.NIGHTCLUBSAFE, {}, MenuLabels.NCSAFELIST_DESC)
        menu.toggle_loop(NCSafe, MenuLabels.MONITOR, {"monitorncsafe"}, GetLabelText(MenuLabels.MONITOR_DESC, MenuLabels.MONEY, MenuLabels.NIGHTCLUBSAFE, MenuLabels.INFOOVERLAY), function()
            if IsInSession() then
                local safeval = GetSafeCashValueFromStat()
                util.draw_debug_text(GetLabelText(MenuLabels.INFO_NCSAFE, safeval))
            end
        end)

        menu.action(NCSafe, GetLabelText(MenuLabels.TELEPORTTO, MenuLabels.NIGHTCLUBSAFE), {"tpncsafe"}, GetLabelText(MenuLabels.TELEPORTTO_DESC, MenuLabels.NIGHTCLUBSAFE), function()
            if IsInSession() then
                if IsPlayerInNightclub() then
                    SetEntityCoords(PLAYER_PLAYER_PED_ID(), NCSafePos)
                else
                    util.toast(MenuLabels.NOTINNIGHTCLUB_TOAST)
                    menu.trigger_commands("tpnightclub")
                end
            end
        end)

        menu.action(NCSafe, MenuLabels.NCMAXPOPULARITY, {"resupplyncsafe"}, MenuLabels.NCMAXPOPULARITY_DESC, function()
            if IsInSession() then
                menu.trigger_commands("clubpopularity 100")
                util.toast(MenuLabels.NCMAXPOPULARITY_TOAST)
            end
        end)

        menu.action(NCSafe, MenuLabels.TRIGGERPRODUCTION, {"triggerncsafe"}, MenuLabels.TRIGGERPRODUCTION_DESC, function()
            if IsInSession() then
                if SetNightclubPayTimeLeft(-1) then
                    util.toast(MenuLabels.TRIGGERPRODUCTION_TOAST)
                end
            end
        end)

        menu.click_slider(NCSafe, MenuLabels.MAXIMUMCAPACITY, {"setcapncsafe"}, MenuLabels.MAXIMUMCAPACITY_DESC, 1, 300000, 210000, 10000, function(value)
            if IsInSession() then
                local address = memory.script_global(globals.SafeCap)
                memory.write_int(address, value)
                util.toast(MenuLabels.MAXIMUMCAPACITY_TOAST)
            end
        end)

        menu.click_slider(NCSafe, MenuLabels.NCREVENUE, {"revenuencsafe"}, MenuLabels.NCREVENUE_DESC, 1, 300000, 50000, 10000, function(value)
            if IsInSession() then
                for i = 1, 20 do
                    SetGlobalInt(globals.SafeRevenue + i, globals.SafeLimit)
                end
            end
        end)

        local NCSafeLoopDelay = 200
        local NCSafeLoopTransactionTimeout = 30000
        local NCSafeLoopUserLimit = 0

        menu.toggle_loop(NCSafe, MenuLabels.NCSAFELOOP, {"ncafkloop"}, MenuLabels.NCSAFELOOP_DESC, function(toggle)
            if remote.killswitches.safeloop then
                util.toast(MenuLabels.KILLSWITCH_SAFELOOP, TOAST_ALL)
                util.stop_thread()
                return
            end

            if IsInSession() then

                local function StopSafeLoop(msg)
                    util.toast(msg, TOAST_ALL)
                    util.stop_thread()
                end

                if NCSafeLoopUserLimit ~= 0 and (TotalEarnedTypes.safeloop.amount >= NCSafeLoopUserLimit) then
                    StopSafeLoop(MenuLabels.NCSAFELOOPMAXIMUMVALUEREACHED_TOAST)
                elseif not IsPlayerInNightclub() then
                    StopSafeLoop(MenuLabels.NCSAFELOOPNOTINNIGHTCLUB_TOAST)
                end

                if GetGlobalInt(globals.SafeCap) ~= globals.SafeLimit then
                    SetGlobalInt(globals.SafeCap, globals.SafeLimit)
                    for i = 1, 20 do
                        SetGlobalInt(globals.SafeRevenue + i, globals.SafeLimit)
                    end
                end

                local MyPed = PLAYER_PLAYER_PED_ID()
                ENTITY_FREEZE_ENTITY_POSITION(MyPed, true)

                local ValueBeforeAdding = GetSafeCashValueFromStat()

                SetEntityCoords(MyPed, NCSafePos)

                if ValueBeforeAdding == globals.SafeLimit then
                    local timeout = util.current_time_millis() + NCSafeLoopTransactionTimeout
                    while timeout > util.current_time_millis() and ValueBeforeAdding == GetSafeCashValueFromStat() do
                        util.yield()
                    end
                    if ValueBeforeAdding > GetSafeCashValueFromStat() then
                        -- we've picked it up!
                        ValueBeforeAdding = GetSafeCashValueFromStat()
                    else
                        StopSafeLoop(GetLabelText(MenuLabels.PREFIX_SAFELOOP, MenuLabels.NCSAFELOOPTIMEOUT_TOAST) .. " (1)")
                    end
                elseif ValueBeforeAdding > globals.SafeLimit then
                    StopSafeLoop(MenuLabels.NCSAFELOOPSAFEOVERLIMIT_TOAST)
                end

                -- okay, so far so good, fill the safe
                SetNightclubPayTimeLeft(-1)

                -- check if the safe value changes
                local timeout = util.current_time_millis() + NCSafeLoopTransactionTimeout
                while timeout > util.current_time_millis() and ValueBeforeAdding == GetSafeCashValueFromStat() do
                    util.yield()
                end

                -- if the safe doesn't change
                if timeout < util.current_time_millis() and ValueBeforeAdding == GetSafeCashValueFromStat() then
                    -- we've hit transaction timeout... shit
                    StopSafeLoop(GetLabelText(MenuLabels.PREFIX_SAFELOOP, MenuLabels.NCSAFELOOPTIMEOUT_TOAST) .. " (2)")
                end

                local ValueAfterAdding = GetSafeCashValueFromStat()

                if ValueAfterAdding > globals.SafeLimit then
                    -- shit, its over 300k
                    StopSafeLoop(MenuLabels.NCSAFELOOPSAFEOVERLIMIT_TOAST)
                end

                SetEntityCoords(MyPed, NCSafePos)

                timeout = util.current_time_millis() + NCSafeLoopTransactionTimeout
                while timeout > util.current_time_millis() and ValueAfterAdding == GetSafeCashValueFromStat() do
                    -- wait for the user to collect the money
                    util.yield()
                end

                -- if the safe doesn't change
                if timeout < util.current_time_millis() and ValueAfterAdding == GetSafeCashValueFromStat() then
                    -- we've hit transaction timeout... shit
                    StopSafeLoop(GetLabelText(MenuLabels.PREFIX_SAFELOOP, MenuLabels.NCSAFELOOPTIMEOUT_TOAST) .. " (3)")
                end

                if ValueAfterAdding > GetSafeCashValueFromStat() then
                    -- success! user has collected the money
                    AddToTotalEarned(globals.SafeLimit, TotalEarnedTypes.safeloop)
                    if NCSafeLoopDelay and NCSafeLoopDelay > 0 then
                        util.yield(NCSafeLoopDelay)
                    end
                else
                    StopSafeLoop(MenuLabels.NCSAFELOOPSOMETHINGWENTWRONG_TOAST)
                end

                util.yield()
            end
        end, function()
            ENTITY_FREEZE_ENTITY_POSITION(PLAYER_PLAYER_PED_ID(), false)
            if remote.killswitches.safeloop then
                return
            end
            SetEntityCoords(PLAYER_PLAYER_PED_ID(), {x = -1615.86, y = -3015.5, z = -75.2})
        end)

        menu.slider(NCSafe, MenuLabels.NCSAFELOOPDELAY, {"ncafkloopdelay"}, MenuLabels.NCSAFELOOPDELAY_DESC, 0, 100000, NCSafeLoopDelay, 100, function(peepeepoopoo)
            NCSafeLoopDelay = peepeepoopoo -- clever
            util.toast(MenuLabels.NCSAFELOOPDELAY_TOAST)
        end)

        menu.slider(NCSafe, MenuLabels.NCSAFELOOPTRANSACTIONTIMEOUT, {"ncafktransactiontimeout"}, MenuLabels.NCSAFELOOPTRANSACTIONTIMEOUT_DESC, 1000, NCSafeLoopTransactionTimeout, NCSafeLoopTransactionTimeout, 100, function(peepeepoopoo)
            NCSafeLoopTransactionTimeout = peepeepoopoo -- clever
            util.toast(MenuLabels.NCSAFELOOPTIMEOUTMODIFIED_TOAST)
        end)

        menu.slider(NCSafe, MenuLabels.NCSAFELOOPSTOP, {"ncafkamount"}, MenuLabels.NCSAFELOOPSTOP_DESC, 0, 999999999, 0, 300000, function(value)
            NCSafeLoopUserLimit = value
            util.toast(MenuLabels.NCSAFELOOPSTOP_TOAST)
        end)

        menu.action(NCSafe, MenuLabels.NCRESETSAFEVALUE, {}, MenuLabels.NCRESETSAFEVALUE_DESC, FixNCSafe)

        if not IS_RELEASE_VERSION then
            menu.action(NCSafe, "[DEBUG] Fuck The Safe", {}, "", function()
                TriggerNCSafeAddMoneyTransaction(300000, true)
            end)

            menu.toggle(NCSafe, "[DEBUG] Disable Rendering", {}, "", function(toggle)
                GRAPHICS.TOGGLE_PAUSED_RENDERPHASES(not toggle)
                GRAPHICS.DONT_RENDER_IN_GAME_UI(toggle)
            end)
        end
--#endregion Nightclub Shit

----------------------------------
-- MC Club Shit
----------------------------------
--#region MC Club Shit
local MCMan = menu.list(task_options, GetLabelText(MenuLabels.MCBUSINESS), {}, MenuLabels.MCLIST_DESC)

    menu.toggle_loop(MCMan, MenuLabels.ENFORCEEASIESTMISSION, {}, MenuLabels.ENFORCEEASIESTMISSION_DESC, function()
        local value = GetLocalInt(locals.MCSellScriptString, locals.MCEZMission)
        if value and value ~= 0 then
            SetLocalInt(locals.MCSellScriptString, locals.MCEZMission, 0)
        end
    end)

    if not IS_RELEASE_VERSION and not IS_BETA_VERSION then
        menu.toggle_loop(MCMan, "[DEBUG] Autocomplete Sell Mission", {}, "This doesnt work too well lol", function()
            if GetLocalInt(locals.MCSellScriptString, 696) then
                util.toast("Script is running")
                if GetLocalInt(locals.MCSellScriptString, locals.MCEZMissionStarted) then
                    util.toast("mission started, waiting 30 secs")
                    util.yield(30000)
                    SetLocalInt(locals.MCSellScriptString, locals.MCEZMissionStarted, 1)
                else
                    util.toast(GetLocalInt(locals.MCSellScriptString, locals.MCEZMissionStarted))
                end
            end
        end)
    end

    -- Generate MC Business options
    for index = 0, 4 do
        local name = MCBusinessTypesOrderedWithLabels[index].name
        local label = MCBusinessTypesOrderedWithLabels[index].label
        

        local list = menu.list(MCMan, label)

        menu.toggle_loop(list, MenuLabels.MONITOR, {"monitor"..name}, GetLabelText(MenuLabels.MONITOR_DESC, MenuLabels.PRODUCT, MenuLabels.BUSINESS, MenuLabels.INFOOVERLAY), function()
            if IsInSession() then
                local capacity = GetGlobalInt(globals.MC[name].Cap)
                util.draw_debug_text(GetLabelText(MenuLabels.INFO_MCBUSINESS, label, MyBusinesses[name].supplies, MyBusinesses[name].product, capacity))
            end
        end)

        menu.toggle_loop(list, MenuLabels.RESUPPLY, {"resupply"..name}, MenuLabels.RESUPPLY_DESC, function()
            if IsInSession() then
                if MyBusinesses[name].property ~= 0 then
                    if MyBusinesses[name].supplies < 50 then
                        ResupplyBusinessSlot(MyBusinesses[name].slot)
                        util.yield(5000)
                    end
                end
            end
        end)

        menu.toggle_loop(list, MenuLabels.MAXSELLPRICE, {"maxsell"..name}, GetLabelText(MenuLabels.MAXSELLPRICE_DESC, MenuLabels.PRODUCT, MenuLabels.PRODUCT), function()
            if remote.killswitches.maxsellprice then
                util.toast(MenuLabels.KILLSWITCH_MAXSELLPRICE)
                SetGlobalInt(globals.MC[name].Sell1, globals.MC[name].Sell1DefaultValue)
                SetGlobalFloat(globals.MC[name].Sell2, globals.MC[name].Sell2DefaultValue)
                util.stop_thread()
                return
            end

            if IsInSession() then
                if MyBusinesses[name].property ~= 0 then
                    CheckIfAlone()
                    if MyBusinesses[name].product > 0 then
                        SetGlobalInt(globals.MC[name].Sell1, globals.MC.MaxSellPrice // MyBusinesses[name].product)
                        SetGlobalFloat(globals.MC[name].Sell2, 1)
                    end
                end
            end
        end, function()
            SetGlobalInt(globals.MC[name].Sell1, globals.MC[name].Sell1DefaultValue)
            SetGlobalFloat(globals.MC[name].Sell2, globals.MC[name].Sell2DefaultValue)
        end)

        local var
        menu.toggle(list, MenuLabels.MAXPRODUCTIONSPEED, {"maxprod"..name}, MenuLabels.MCMAXPRODUCTIONSPEED_DESC, function(toggle)
            var = toggle
            if var then
                SetGlobalInt(GetMCBusinessProductionSpeed2(MyBusinesses[name].slot), 0)
                util.toast(MenuLabels.MAXPRODUCTIONSPEED_TOAST)
            end
            while var do
                SetGlobalInt(globals.MC[name].ProSpd1, 500)
                util.yield()
            end
            SetGlobalInt(globals.MC[name].ProSpd1, globals.MC[name].ProSpd1DefaultValue)
        end)

        menu.click_slider(list, MenuLabels.SUPPLYPRODUCTRATIO, {"ratio"..name}, MenuLabels.SUPPLYPRODUCTRATIO_DESC, 1, 4, 1, 1, function(value)
            if IsInSession() then
                SetGlobalInt(globals.MC[name].Ratio1, value)
                SetGlobalInt(globals.MC[name].Ratio2, value)
                util.toast(MenuLabels.SUPPLYPRODUCTRATIO_TOAST)
            end
        end)

        menu.click_slider(list, MenuLabels.MAXIMUMCAPACITY, {"setcap"..name}, MenuLabels.MAXIMUMCAPACITY_DESC, 1, 999, globals.MC[name].CapDefaultValue, 1, function(value)
            if IsInSession() then
                SetGlobalInt(globals.MC[name].Cap, value)
                util.toast(MenuLabels.MAXIMUMCAPACITY_TOAST)
            end
        end)

        menu.action(list, GetLabelText(MenuLabels.TELEPORTTO, MenuLabels.BUSINESS), {"tpbusiness"..name}, GetLabelText(MenuLabels.TELEPORTTO_DESC, MenuLabels.BUSINESS), function()
            if IsInSession() then
                TeleportToMCProperty(MyBusinesses[name].property)
            end
        end)
    end
--#endregion MC Club Shit

--------------------------
-- Bunker Shit
--------------------------
--#region Bunker Shit
local BunkMan = menu.list(task_options, MenuLabels.BUNKER, {}, MenuLabels.BUNKERLIST_DESC)
    menu.toggle_loop(BunkMan, MenuLabels.MONITOR, {"monitorbunker"}, GetLabelText(MenuLabels.MONITOR_DESC, MenuLabels.PRODUCT, MenuLabels.BUNKER, MenuLabels.INFOOVERLAY), function()
        if IsInSession() then
            local capacity = GetGlobalInt(globals.MC.Bunker.Cap)
            util.draw_debug_text(GetLabelText(MenuLabels.INFO_BUNKER, MyBusinesses.Bunker.supplies, MyBusinesses.Bunker.product, capacity))
        end
    end)

    -- if not IS_RELEASE_VERSION then
    --     menu.toggle_loop(BunkMan, "[DEBUG] Monitor Autocomplete", {"autocompletebunkersell"}, "", function()
    --         if IsInSession() then
    --             local something = GetLocalInt(locals.BunkScriptString, locals.PeePeePooPoo)
    --             local time_remaining = GetLocalInt(locals.BunkScriptString, locals.BunkTimeRemaining)
    --             local time_deliver = GetLocalInt(locals.BunkScriptString, locals.BunkTimeTakenToDeliver)
    --             if something then
    --                 util.draw_debug_text(something)
    --             end
    --             if time_remaining then
    --                 util.draw_debug_text("Time Remaining: " .. time_remaining)
    --             end
    --             if time_deliver then
    --                 util.draw_debug_text("Time Taken To Deliver: " .. time_deliver)
    --             end
    --         end
    --     end)
    --     menu.toggle_loop(BunkMan, "[DEBUG] Finish Sell Mission (fail)", {"autocompletebunkersell"}, "This will cause a failure in the sell mission", function()
    --         if IsInSession() then
    --             local time_remaining = GetLocalInt(locals.BunkScriptString, locals.BunkTimeRemaining)
    --             local time_deliver = GetLocalInt(locals.BunkScriptString, locals.BunkTimeTakenToDeliver)
    --             if time_remaining and time_deliver then
    --                 SetLocalInt(locals.BunkScriptString, locals.BunkTimeTakenToDeliver, time_remaining)
    --             end
    --         end
    --     end)
    -- end

    menu.toggle_loop(BunkMan, MenuLabels.RESUPPLY, {"resupplybunker"}, MenuLabels.RESUPPLY_DESC, function()
        if IsInSession() then
            if MyBusinesses.Bunker.property ~= 0 then
                if MyBusinesses.Bunker.supplies <= 9 then
                    ResupplyBusinessSlot(MyBusinesses.Bunker.slot)
                    util.yield(5000)
                end
            end
        end
    end)

    menu.toggle_loop(BunkMan, MenuLabels.MAXSELLPRICE, {"maxsellbunker"}, GetLabelText(MenuLabels.MAXSELLPRICE_DESC, MenuLabels.PRODUCT, MenuLabels.PRODUCT), function()
        if remote.killswitches.maxsellprice then
            util.toast(MenuLabels.KILLSWITCH_MAXSELLPRICE)
            SetGlobalInt(globals.MC.Bunker.Sell1, globals.MC.Bunker.Sell1DefaultValue)
            SetGlobalFloat(globals.MC.Bunker.Sell2, globals.MC.Bunker.Sell2DefaultValue)
            util.stop_thread()
            return
        end

        if IsInSession() then
            if MyBusinesses.Bunker.product ~= 0 then
                CheckIfAlone()
                SetGlobalInt(globals.MC.Bunker.Sell1, 2500000 // MyBusinesses.Bunker.product)
                SetGlobalFloat(globals.MC.Bunker.Sell2, 1)
            end
        end
    end, function()
        SetGlobalInt(globals.MC.Bunker.Sell1, globals.MC.Bunker.Sell1DefaultValue)
        SetGlobalFloat(globals.MC.Bunker.Sell2, globals.MC.Bunker.Sell2DefaultValue)
    end)

    local BunkProSpdVar
    menu.toggle(BunkMan, MenuLabels.MAXPRODUCTIONSPEED, {"maxprodbunker"}, MenuLabels.MCMAXPRODUCTIONSPEED_DESC, function(peepeepoopoo)
        BunkProSpdVar = peepeepoopoo
        if BunkProSpdVar then
            SetGlobalInt(GetMCBusinessProductionSpeed2(MyBusinesses.Bunker.slot), 0)
            util.toast(MenuLabels.MAXPRODUCTIONSPEED_TOAST)
        else
            SetGlobalInt(globals.MC.Bunker.ProSpd1, 600000)
            SetGlobalInt(globals.MC.Bunker.ProSpd2, 90000)
            SetGlobalInt(globals.MC.Bunker.ProSpd3, 90000)
        end
        while BunkProSpdVar do
            if IsInSession() then
                SetGlobalInt(globals.MC.Bunker.ProSpd1, 1000) -- base
                SetGlobalInt(globals.MC.Bunker.ProSpd2, 1000) -- equipment
                SetGlobalInt(globals.MC.Bunker.ProSpd3, 1000) -- staff upg
            end
            util.yield()
        end
    end)

    menu.click_slider(BunkMan, MenuLabels.SUPPLYPRODUCTRATIO, {"ratiobunker"}, MenuLabels.SUPPLYPRODUCTRATIO_DESC, 1, 10, 10, 1, function(value)
        if IsInSession() then
            SetGlobalInt(globals.MC.Bunker.Ratio1, value) -- no upgrade
            SetGlobalInt(globals.MC.Bunker.Ratio2, value) -- with upgrade
            util.toast(MenuLabels.SUPPLYPRODUCTRATIO_TOAST)
        end
    end)

    menu.click_slider(BunkMan, MenuLabels.MAXIMUMCAPACITY, {"setcapbunker"}, MenuLabels.MAXIMUMCAPACITY_DESC, 1, 999, 100, 1, function(value)
        if IsInSession() then
            SetGlobalInt(globals.MC.Bunker.Cap, value)
            util.toast(MenuLabels.MAXIMUMCAPACITY_TOAST)
        end
    end)

    menu.action(BunkMan, GetLabelText(MenuLabels.TELEPORTTO, MenuLabels.BUNKER), {"tpbunker"}, GetLabelText(MenuLabels.TELEPORTTO_DESC, MenuLabels.BUNKER), function()
        TeleportToMCProperty(MyBusinesses.Bunker.property)
    end)
--#endregion Bunker Shit

--------------------------
-- Debug Shit
--------------------------
if not IS_RELEASE_VERSION then
    local MBDebug = menu.list(task_options, "Debug Shit", {"mbdebug"})
    local MBDebug_MC = menu.list(MBDebug, "MC Shit", {"mbdebugmc"})
    for i = 0, 5 do
        --local type = MCBusinessTypesInOrder[i]
        local type = MCBusinessTypesOrderedWithLabels[i].name
        local label = MCBusinessTypesOrderedWithLabels[i].label

        local thislist = menu.list(MBDebug_MC, label, {"mbdebugmc"..type})
        RegisterUpdatingReadOnlyCommand(thislist, "Slot"        , function() return MyBusinesses[type].slot end)
        RegisterUpdatingReadOnlyCommand(thislist, "Property"    , function() return MyBusinesses[type].property end)
        RegisterUpdatingReadOnlyCommand(thislist, "Product"     , function()
            return MyBusinesses[type].product
        end)
        RegisterUpdatingReadOnlyCommand(thislist, "Supplies "    , function() return MyBusinesses[type].supplies end)
        menu.action(thislist, GetLabelText(MenuLabels.TELEPORTTO, MenuLabels.BUSINESS), {}, GetLabelText(MenuLabels.TELEPORTTO_DESC, MenuLabels.BUSINESS), function()
            local coords = MCBusinessPropertyInfo[MyBusinesses[type].property].coords
            if coords then
                if LoadArea(coords) then
                    SetEntityCoords(PLAYER_PLAYER_PED_ID(), coords)
                end
            else
                util.toast("You do not have a "..type)
            end
        end)
    end

    local MBDebug_NC = menu.list(MBDebug, "NC Shit", {"mbdebugnc"})
    for i = 0, #HubTypesOrderedWithLabels do
        local name = HubTypesOrderedWithLabels[i].name
        local label = HubTypesOrderedWithLabels[i].label
        local thislist = menu.list(MBDebug_NC, label, {"mbdebugnc"..name})
        RegisterUpdatingReadOnlyCommand(thislist, "Product"     ,  function() return MyBusinesses.Hub[name] end)
        RegisterUpdatingReadOnlyCommand(thislist, "Capacity"     , function() return GetGlobalInt(globals.Hub[name].Cap) end)
    end
    menu.click_slider(MBDebug_NC, "Set Product All", {}, "Will not put it over your cap", 0, 100, 0, 1, function(value)
        for i = 0, #HubTypesOrderedWithLabels do
            local cap = GetGlobalInt(globals.Hub[HubTypesOrderedWithLabels[i].name].Cap)
            SetGlobalInt(GetHubValueOffsetFromSlot(i), value > cap and cap or value)
        end
    end)

    local MBDebug_CEO = menu.list(MBDebug, "CEO Shit", {"mbdebugceo"})
    for slot = 0, 4 do
        local property_id = GetWarehousePropertyFromSlot(slot)
        if property_id ~= 0 then
            local property_name = WarehousePropertyInfo[property_id].name
            MenuCurrentWarehouses[slot] = {property_name, {"warehouse"..property_name}, ""}
        else
            MenuCurrentWarehouses[slot] = {MenuLabels.SPECIALCARGONOWAREHOUSE, {"warehouse".."invalid"}, MenuLabels.SPECIALCARGONOWAREHOUSE_DESC}
        end
    end

    for slot = 0, 4 do
        local warehouse_list = menu.list(MBDebug_CEO, "Slot "..slot)
        RegisterUpdatingReadOnlyCommand(warehouse_list, "Property",        function() return MenuCurrentWarehouses[slot][4] or "" end)
        RegisterUpdatingReadOnlyCommand(warehouse_list, "Property Name",   function() return MenuCurrentWarehouses[slot][1] end)
        RegisterUpdatingReadOnlyCommand(warehouse_list, "Crates Global",   function() return GetGlobalInt(GetSpecialCargoCrateAmountOffset(slot)) end)
        RegisterUpdatingReadOnlyCommand(warehouse_list, "Crates Stat",     function() return GetSpecialCargoCrateAmountFromStat(slot) end)
    end

    --menu.action(MBDebug_CEO, "Sync Globals With Stats")
end
--------------------------
-- End Debug Shit
--------------------------

util.create_tick_handler(function()
    prefix = "MP" .. util.get_char_slot() .. "_" -- update our prefix live incase the user switches characters while script is running

    if IsInSession() then
        PopulateMyBusinessesTable()

        for slot = 0, 4 do
            local property_id = GetWarehousePropertyFromSlot(slot)
            if property_id ~= 0 then
                local property_name = WarehousePropertyInfo[property_id].name
                MenuCurrentWarehouses[slot] = {property_name, {"warehouse"..property_name}, "", property_id}
            else
                MenuCurrentWarehouses[slot] = {MenuLabels.SPECIALCARGONOWAREHOUSE, {"warehouse".."invalid"}, MenuLabels.SPECIALCARGONOWAREHOUSE_DESC}
            end
        end

        menu.set_list_action_options(WarehouseSelector, MenuCurrentWarehouses)

        FixNCHubCapacities()
    end
    return true
end)

menu.hyperlink(task_options, MenuLabels.JOINDISCORD, "https://discord.gg/mmxWwc5FCC")
menu.action(task_options, MenuLabels.SHOWMOTD, {}, tostring(THIS_RELEASE_VERSION) .. " / " .. remote.version, function()
    if remote.motd == "" then
        util.toast(MenuLabels.SHOWMOTDBLANK_TOAST)
    else
        util.toast(GetLabelText(MenuLabels.PREFIX_MOTD, remote.motd))
    end
end)