   --credits to Keramis for the tutorial
   --credits to Jerry123 for major help with multiple portions of the script and his LangLib for translations
   --credits to Sapphire for the help in programming they are the real MVP for helping everyone
   --credits to Vsus and ghozt for pointing me in the right direction
   --credits to Nowiry for their script it was a heavy influence on the Charger weapon
   --credits to aaronlink127#0127 for the ScaleformLib script and help with executing it
   --Script made by acjoker8818
   -------------------------------------------------------------------------



require"lib.baibailib.natives165"
--util.ensure_package_is_installed('lua/ScaleformLib')
SEC = ENTITY.SET_ENTITY_COORDS
 ------------------

---------------------Functions-------------------------------------


function PFP(pedm, playerm)--Ped Facing Player adapted from PhoenixScript
    local ppos = ENTITY.GET_ENTITY_COORDS(playerm)
    local pmpos = ENTITY.GET_ENTITY_COORDS(pedm)
    local hx = ppos.x - pmpos.x
    local hy = ppos.y - pmpos.y
    local head = MISC.GET_HEADING_FROM_VECTOR_2D(hx, hy)
    return ENTITY.SET_ENTITY_HEADING(pedm, head)
end

function Streament(hash) --Streaming Model
    STREAMING.REQUEST_MODEL(hash)
    while STREAMING.HAS_MODEL_LOADED(hash) ==false do
    util.yield()
    end
end

function Streamanim(anim) --Streaming Model
    STREAMING.REQUEST_ANIM_DICT(anim)
    while STREAMING.HAS_ANIM_DICT_LOADED(anim) ==false do
        STREAMING.REQUEST_ANIM_DICT(anim)
        util.yield()
    end
end

function Runanim(ent, animdict, anim)
    TASK.TASK_PLAY_ANIM(ent, animdict, anim, 1.0, 1.0, -1, 3, 0.5, false, false, false)
    while ENTITY.IS_ENTITY_PLAYING_ANIM(ent, animdict, anim, 3) ==false do
        TASK.TASK_PLAY_ANIM(ent, animdict, anim, 1.0, 1.0, -1, 3, 0.5, false, false, false)
        util.yield()
    end
end


function Pedspawn(tar1)
    Ped_mdl = Ped_mdl or 'ig_lestercrest'
    Pedhash = util.joaat(Ped_mdl)
    Streament(Pedhash)
    local pedS = entities.create_ped(1, Pedhash, tar1, 0)
    ENTITY.SET_ENTITY_INVINCIBLE(pedS, true)
    ENTITY.FREEZE_ENTITY_POSITION(pedS, true)
    PED.SET_BLOCKING_OF_NON_TEMPORARY_EVENTS(pedS, true)
    PED.SET_PED_CAN_LOSE_PROPS_ON_DAMAGE(pedS, false)
    if Pedhash == util.joaat('ig_lestercrest') then
        PED.SET_PED_PROP_INDEX(pedS, 1)
    end

    return pedS
end


function SetPedCoor(pedS, tarx, tary, tarz)
    SEC(pedS, tarx, tary, tarz, false, true, true, false)
end


function Teabagtime(p1, p2, p3, p4, p5, p6, p7, p8)
    util.create_tick_handler (function ()
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p1, 'LES1A_DHAC', 'LESTER', 'SPEECH_PARAMS_FORCE_SHOUTED', 1)
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p2, 'TUSCO_AHAD', 'LESTER', 'SPEECH_PARAMS_FORCE_SHOUTED', 1)
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p3, 'LES1A_DHAC', 'LESTER', 'SPEECH_PARAMS_FORCE_SHOUTED', 1)
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p4, 'TUSCO_AHAD', 'LESTER', 'SPEECH_PARAMS_FORCE_SHOUTED', 1)
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p5, 'LES1A_DHAC', 'LESTER', 'SPEECH_PARAMS_FORCE_SHOUTED', 1)
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p6, 'TUSCO_AHAD', 'LESTER', 'SPEECH_PARAMS_FORCE_SHOUTED', 1)
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p7, 'LES1A_DHAC', 'LESTER', 'SPEECH_PARAMS_FORCE_SHOUTED', 1)
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p8, 'TUSCO_AHAD', 'LESTER', 'SPEECH_PARAMS_FORCE_SHOUTED', 1)
--AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p1, 'HS3LE_ANAB', 'LESTER', 'SPEECH_PARAMS_FORCE_SHOUTED', 1)
        util.yield(100)
        end)
end

function Trevortime(p1, p2, p3, p4, p5, p6, p7, p8)
    util.create_tick_handler (function ()
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p1, 'TR2_ABAJ', 'TREVOR', 'SPEECH_PARAMS_FORCE', 1)
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p2, 'TR2_ABAJ', 'TREVOR', 'SPEECH_PARAMS_FORCE', 1)
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p3, 'TR2_ABAJ', 'TREVOR', 'SPEECH_PARAMS_FORCE', 1)
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p4, 'TR2_ABAJ', 'TREVOR', 'SPEECH_PARAMS_FORCE', 1)
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p5, 'TR2_ABAJ', 'TREVOR', 'SPEECH_PARAMS_FORCE', 1)
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p6, 'TR2_ABAJ', 'TREVOR', 'SPEECH_PARAMS_FORCE', 1)
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p7, 'TR2_ABAJ', 'TREVOR', 'SPEECH_PARAMS_FORCE', 1)
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p8, 'TR2_ABAJ', 'TREVOR', 'SPEECH_PARAMS_FORCE', 1)
--AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(p1, 'HS3LE_ANAB', 'LESTER', 'SPEECH_PARAMS_FORCE_SHOUTED', 1)
        util.yield(100)
    end)
end

function Fuckyou(ped_tab)
util.create_tick_handler (function ()

    for _, pi in ipairs(ped_tab) do
        AUDIO.PLAY_PED_AMBIENT_SPEECH_NATIVE(pi, 'GENERIC_FUCK_YOU', 'SPEECH_PARAMS_FORCE', 1)
        util.yield(100)
    end
    end)
end

function Insulthigh(ped_tab)
    util.create_tick_handler (function ()

        for _, pi in ipairs(ped_tab) do
            AUDIO.PLAY_PED_AMBIENT_SPEECH_NATIVE(pi, 'Generic_Insult_High', 'SPEECH_PARAMS_FORCE', 1)
            util.yield(100)
        end
    end)
end

function Warcry(ped_tab)
    util.create_tick_handler (function ()
        for _, pi in ipairs(ped_tab) do
            AUDIO.PLAY_PED_AMBIENT_SPEECH_NATIVE(pi, 'GENERIC_WAR_CRY', 'SPEECH_PARAMS_FORCE', 1)
            util.yield(100)
        end

    end)
end

function Provoke(ped_tab)
    util.create_tick_handler (function ()
        for _, pi in ipairs(ped_tab) do
            AUDIO.PLAY_PED_AMBIENT_SPEECH_NATIVE(pi, 'Provoke_Trespass', 'Speech_Params_Force_Shouted_Critical', 1)
            util.yield(100)
        end

    end)
end


function DelEnt(ped_tab)
    for _, Pedm in ipairs(ped_tab) do
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(Pedm)
        entities.delete_by_handle(Pedm)
    end
end

function Stopsound()
    for i = 0, 99 do
        AUDIO.STOP_SOUND(i)
    end
end

local set = {alert = true}
function IPM(targets, tar1, set, pname, cage_table, pid)
            local tar2 = ENTITY.GET_ENTITY_COORDS(targets)
            local disbet = SYSTEM.VDIST2(tar2.x, tar2.y, tar2.z, tar1.x, tar1.y, tar1.z)
            if disbet <= 0.5  then
            if set.alert then
                util.toast(pname..' 在笼中')
            end
            util.yield(800)

            elseif disbet >= 0.5  then
            util.yield(800)
            if set.alert then
                util.toast(pname..' 挣脱了')
            end
            DelEnt(cage_table[pid])
            cage_table[pid] = false
            Stopsound()
            end
end


function ObjSpawn(hsel, tar1)
    local objHash = hsel
  local objS =  OBJECT.CREATE_OBJECT(objHash, tar1.x, tar1.y, tar1.z, true, true, true)
  ENTITY.FREEZE_ENTITY_POSITION(objS, true)
  return objS
end

function SetObjCo(objS, tarx, tary, tarz)
    SEC(objS, tarx, tary, tarz, false, true, true, false)
end

function Vspawn(mod, pCoor, pedSi, plate)
   local vmod = VEHICLE.CREATE_VEHICLE(mod, pCoor.x, pCoor.y, pCoor.z, 0, true, true, false)
    PED.SET_PED_INTO_VEHICLE(pedSi, vmod, -1)
    VEHICLE.SET_VEHICLE_COLOURS(vmod, 118, 0)
    for M=0, 49 do
        local modn = VEHICLE.GET_NUM_VEHICLE_MODS(vmod, M)
        VEHICLE.SET_VEHICLE_MOD(vmod, M, modn -1, false)
        VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vmod, plate)
        VEHICLE.GET_VEHICLE_MOD_KIT(vmod, 0)
        VEHICLE.SET_VEHICLE_MOD_KIT(vmod, 0)
        VEHICLE.SET_VEHICLE_MOD(vmod, 14, 0)
        VEHICLE.TOGGLE_VEHICLE_MOD(vmod, 22, true)
        VEHICLE.TOGGLE_VEHICLE_MOD(vmod, 18, true)
        VEHICLE.TOGGLE_VEHICLE_MOD(vmod, 20, true)
        VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vmod, 0, 0, 0)
        VEHICLE.SET_VEHICLE_WHEEL_TYPE(vmod, 7)
        VEHICLE.SET_VEHICLE_MOD(vmod, 23, 26)
        VEHICLE._SET_VEHICLE_MAX_SPEED(vmod, 100)
        VEHICLE.MODIFY_VEHICLE_TOP_SPEED(vmod, 40)
        VEHICLE.SET_VEHICLE_BURNOUT(vmod, false)
    end
end

function Delcar(vic, set)
    if PED.IS_PED_IN_ANY_VEHICLE(vic) ==true then
        local tarcar = PED.GET_VEHICLE_PED_IS_IN(vic, true)
        GetControl(tarcar, set)
        ENTITY.SET_ENTITY_AS_MISSION_ENTITY(tarcar)
        entities.delete_by_handle(tarcar)
    end
end

function SmashCar(Veh_h, tar1,  invis_aveh, rate)
   local  CC = VEHICLE.CREATE_VEHICLE(Veh_h, tar1.x, tar1.y, tar1.z + 5.0, 0, true, true, false)
   if invis_aveh then
    ENTITY.SET_ENTITY_VISIBLE(CC, false, 0)
end
    ENTITY.SET_ENTITY_INVINCIBLE(CC, true)
    ENTITY.SET_ENTITY_VELOCITY(CC, 0, 0, -1000)
    VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(CC, true)
    VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS(CC, true)
    util.yield(rate)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(CC)
    entities.delete_by_handle(CC)
end

function RamCar(Veh_h, tar1x, tar1y, tar1z, invis_aveh, targets, rate)
    local RC = VEHICLE.CREATE_VEHICLE(Veh_h, tar1x, tar1y, tar1z, 0, true, true, false)
    if invis_aveh then
        ENTITY.SET_ENTITY_VISIBLE(RC, false, 0)
    end
    PFP(RC, targets)
    ENTITY.SET_ENTITY_INVINCIBLE(RC, true)
    VEHICLE.SET_VEHICLE_FORWARD_SPEED(RC, 1000)
    VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(RC, true)
    VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS(RC, true)
    util.yield(rate)
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(RC)
    entities.delete_by_handle(RC)
end

function JuggleCar(Vehj_h, tar1,  invisjugc, jugr)
    local  CC = VEHICLE.CREATE_VEHICLE(Vehj_h, tar1.x, tar1.y, tar1.z - 5.0, 0, true, true, false)
    if invisjugc then
     ENTITY.SET_ENTITY_VISIBLE(CC, false, 0)
 end
     ENTITY.SET_ENTITY_INVINCIBLE(CC, true)
     ENTITY.SET_ENTITY_VELOCITY(CC, 0, 0, 1000)
     VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_ALL_PLAYERS(CC, true)
     VEHICLE.SET_VEHICLE_DOORS_LOCKED_FOR_NON_SCRIPT_PLAYERS(CC, true)
     util.yield(jugr)
     ENTITY.SET_ENTITY_AS_MISSION_ENTITY(CC)
     entities.delete_by_handle(CC)
end

function GetControl(vic, set)
    while not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vic) do
        local nid = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(vic)
        NETWORK.SET_NETWORK_ID_CAN_MIGRATE(nid, true)
        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(vic)
        util.yield()
    end
    if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(vic) then
    if set.alert then
        util.toast('Could not gain control')
    end
    else
    end
end

Siglist = {
    'Stop Sign Wrong Way',
    'Do Not Enter Wrong Way',
    'Airport Hanger Sale Sign',
    'Towed',
    'No Loud Stereos',
    'No Stopping Zone',
    'No Parking Zone',
    'Prison Area',
    'No Trespassing',
    }
    
    Sigha = {
    'prop_sign_road_01b',
    'prop_sign_road_03b',
    'prop_airport_sale_sign',
    'poro_06_sig1_c_source',
    'prop_sign_road_03w',
    'prop_sign_road_04zb',
    'prop_sign_road_04za',
    'prop_sign_road_06s',
    'prop_sign_road_restriction_10',
    }
    
    ------------------Doors-----------------------
    
    Dolist = {
    'Mine Shaft Door',
    'Tunnel Door',
    'Garage Gated Door',
    'Vault Slide Door Large',
    'Vault Slide Door Small',
    'Car Mod Garage Door',
    'Sliding Glass Door',
    'Windowed Garage Door',
    'LS Garage Door',
    'Revolving Door',
    'Garage Gate',
    'Union Depository Garage Door',
    'Bunker Door (Sometimes slowly moves them upwards and tosses them around)',
    'Fencing',
    'Arcade Fortune Door',
    'Hanger Door',
    'Office Elevator Door',
    'Prison Gate',
    'Iron Gate Large',
    }
    
    
    Doha = {
    'prop_mineshaft_door',
    'ch_prop_ch_tunnel_door01a',
    'apa_prop_ss1_mpint_garage2',
    'ch_prop_ch_vault_slide_door_lrg',
    'ch_prop_ch_vault_slide_door_sm',
    'v_ilev_carmod3door',
    'v_ilev_fh_slidingdoor',
    'prop_ch2_05d_g_door',
    'prop_com_ls_door_01',
    'prop_ql_revolving_door',
    'prop_sc1_06_gate_l',
    'prop_sec_gate_01d',
    'gr_prop_gr_doorpart',
    'gr_prop_gr_fnclink_03e',
    'ch_prop_arcade_fortune_door_01a',
    'sum_prop_hangerdoor_01a',
    'h4_prop_office_elevator_door_01',
    'p_gate_prison_01_s',
    'prop_lrggate_02',
    }
    
    ------------------Interior----------------------
    Interlist = {
    '420 Display',
    'Gas Cylinder',
    'Crate Pile (Sometimes forces them upwards)',
    'Storage Locker',
    'Speakers',
    'Epsilon TV stand',
    'Wood Cabinet',
    'Bean Machine Vending Machine',
    'TV and Speakers',
    'Xmas Tree',
    }
    
    Intob = {
    'prop_disp_cabinet_01',
    'prop_gascyl_02a',
    'prop_cratepile_02a',
    'p_cs_locker_01_s',
    'prop_speaker_01',
    'prop_tv_stand_01',
    'prop_rub_cabinet02',
    'prop_vend_coffe_01',
    'apa_mp_h_str_avunitm_01',
    'prop_xmas_tree_int',
    }
    
    ----------------------------Exterior-----------------
    Extlist = {
    'Flat Ramp',
    'Carrier Radar (Sometimes sends them spinning upward)',
    'Carrier Defense Minigun (Will sometimes kill player even if invulnerable if they move out of it)',
    'Electrical Transformer',
    'Phone Booth',
    'Phone Box',
    'Inflatable Dancer',
    'Post Box',
    'Vintage Gas Pump',
    'Gravestone',
    
    }
    
    Extob = {
    'prop_skate_flatramp',
    'hei_prop_carrier_radar_1',
    'hei_prop_carrier_defense_02',
    'prop_sub_trans_02a',
    'prop_phonebox_04',
    'prop_phonebox_01a',
    'p_airdancer_01_s',
    'prop_postbox_ss_01a',
    'prop_vintage_pump',
    'prop_gravestones_07a',
    
    
    }
    
    
    
    
    --------------------------NPCS-----------
    
    ----------------------------------Ambient Females-------------------------------
    
    AfClist = {
    'Beach Bikini',--1
    'Beverly Hills 1',--2
    'Beverly Hills 2',--3
    'Bodybuilder',--4
    'Business',--5
    'Downtown 1',--6
    'East SA',--7
    'East SA 2',--8
    'Fat Black 1',--9
    'Fat Cult',--10
    'Fat White',--11
    'K town 1',--12
    'K Town 2',--13
    'Prologue Hostage',--14
    'Salton',--15
    'Skidrow ',--16
    'South Central',--17
    'South Central 2',--18
    'South Central MC',--19
    'Tourist',--20
    'Tramp',--21
    'Tramp Beach', --22
    'Older General Street Female',--23
    'Older Indian',--24
    'Older Ktown',--25
    'Older Salton',--26
    'Older South Central 1',--27
    'Older South Central 2',--28
    'Young Beach',--29
    'Young Beverly Hills 1',--30
    'Young Beverly Hills 2',--31
    'Young Beverly Hills 3',--32
    'Young Beverly Hills 4' ,--33
    'Young Business 1',--34
    'Young Business 2',--35
    'Young Business 3',--36
    'Young Business 4',--37
    'Young East SA 1',--38 
    'Young East SA 2',--39
    'Young East SA 3',--40
    'Young Epsilon',--41
    'Young Agent',--42
    'Young Fitness 1',--43
    'Young Fitness 2',--44
    'General Female',--45
    'Golfer',--46
    'Hiker',--47
    'Young Hippe',--48
    'Young Hipster 1',--49
    'Young Hipster 2',--50
    'Young Hipster 3',--51
    'Young Hipster 4',--52
    'Young Indian',--53
    'Young Juggalo',--54
    'Runner',--55
    'Rural Meth',--56
    'Dressy',--57
    'Skater',--58
    'Young South Central 1',--59
    'Young South Central 2',--60
    'Young South Central 3',--61
    ' Tennis Player',--62
    'Topless ',--63
    'Young  Tourist 1',--64
    'Young  Tourist 2',--65
    ' Vinewood 1',--66
    ' Vinewood 2',--67
    ' Vinewood 3',--68
    ' Vinewood 4',--69
    ' Yoga'--70
    }
    
    AfC = {
    'a_f_m_beach_01',--1
    'a_f_m_bevhills_01',--2
    'a_f_m_bevhills_02',--3
    'a_f_m_bodybuild_01',--4
    'a_f_m_business_02',--5
    'a_f_m_downtown_01',--6
    'a_f_m_eastsa_01',--7
    'a_f_m_eastsa_02',--8
    'a_f_m_fatbla_01',--9
    'a_f_m_fatcult_01',--10
    'a_f_m_fatwhite_01',--11
    'a_f_m_ktown_01',--12
    'a_f_m_ktown_02',--13
    'a_f_m_prolhost_01',--14
    'a_f_m_salton_01',--15
    'a_f_m_skidrow_01',--16
    'a_f_m_soucent_01',--17
    'a_f_m_soucent_02',--18
    'a_f_m_soucentmc_01',--19
    'a_f_m_tourist_01',--20
    'a_f_m_tramp_01',--21
    'a_f_m_trampbeac_01',--22
    'a_f_o_genstreet_01',--23
    'a_f_o_indian_01',--24
    'a_f_o_ktown_01',--25
    'a_f_o_salton_01',--26
    'a_f_o_soucent_01',--27
    'a_f_o_soucent_02',--28
    'a_f_y_beach_01',--29
    'a_f_y_bevhills_01',--30
    'a_f_y_bevhills_02',--31
    'a_f_y_bevhills_03',--32
    'a_f_y_bevhills_04' ,--33
    'a_f_y_business_01',--34
    'a_f_y_business_02',--35
    'a_f_y_business_03',--36
    'a_f_y_business_04',--37
    'a_f_y_eastsa_01',--38 
    'a_f_y_eastsa_02',--39
    'a_f_y_eastsa_03',--40
    'a_f_y_epsilon_01',--41
    'a_f_y_femaleagent',--42
    'a_f_y_fitness_01',--43
    'a_f_y_fitness_02',--44
    'a_f_y_genhot_01',--45
    'a_f_y_golfer_01',--46
    'a_f_y_hiker_01',--47
    'a_f_y_hippie_01',--48
    'a_f_y_hipster_01',--49
    'a_f_y_hipster_02',--50
    'a_f_y_hipster_03',--51
    'a_f_y_hipster_04',--52
    'a_f_y_indian_01',--53
    'a_f_y_juggalo_01',--54
    'a_f_y_runner_01',--55
    'a_f_y_rurmeth_01',--56
    'a_f_y_scdressy_01',--57
    'a_f_y_skater_01',--58
    'a_f_y_soucent_01',--59
    'a_f_y_soucent_02',--60
    'a_f_y_soucent_03',--61
    'a_f_y_tennis_01',--62
    'a_f_y_topless_01',--63
    'a_f_y_tourist_01',--64
    'a_f_y_tourist_02',--65
    'a_f_y_vinewood_01',--66
    'a_f_y_vinewood_02',--67
    'a_f_y_vinewood_03',--68
    'a_f_y_vinewood_04',--69
    'a_f_y_yoga_01'--70
    }
    
    ------------------------------------------Ambient Males-----------------------------------------------------------
    
    AMClist = {
    'Naked Altruist Cult',
    'African American',
    'Beach 1',
    'Beach 2',
    'Beverly hills 1',
    'Beverly hills 2',
    'Business 1',
    'East SA 1',
    'East SA 2',
    'Farmer',
    'Fat Latino',
    'Generic Fat 1',
    'Generic Fat 2',
    'Golfer',
    'Rabbi',
    'Hillbilly 1',
    'Hillbilly 2',
    'Indian 1',
    'Ktown 1',
    'Malibu 1',
    'Mexican Country',
    'Mexican Laborer',
    'a_m_m_og_boss_01',
    'Paparazzi',
    'Polynesian',
    'Prologue Hostage',
    'Rural Meth Head',
    'Salton 1',
    'Salton 2',
    'Salton 3',
    'Salton 4',
    'Skater',
    'Skid Row',
    'South Central Latino',
    'South Central 1',
    'South Central 2',
    'South Central 3',
    'South Central 4',
    'Latino 2',
    'Tennis',
    'Yourist',
    'Tramp',
    'Tramp Beach',
    'Tranvest',
    'Tranvest 2',
    'Old Altruist Cult 1',
    'Old Altruist Cult 2',
    'Old Beach',
    'Old Generic Street',
    'Old Ktown 2',
    'Old Salton ',
    'Old South Central 1',
    'Old South Central 2',
    'Old South Central 3',
    'Old Tramp 1',
    'Young Altruist Cult 1',
    'Young Altruist Cult 2',
    'Young Beach_01',
    'Young Beach_02',
    'Young Beach_03',
    'Young Beach Vesp 1',
    'Young Beach Vesp 2',
    'Young Beverly Hills 1',
    'Young Beverly Hills 2',
    'Breakdance',
    'Young Business',
    'Young Business 1',
    'Young Business 2',
    'Young Business 3',
    'Cyclist',
    'Cyclist 2',
    'Young Downtown',
    'Young East SA 1',
    'Young East SA 2',
    'Young Epsilon 1',
    'Young Epsilon 2',
    'Gay 1',
    'Gay 2',
    'Young Generic Street 1',
    'Young Generic Street 2',
    'Young golfer 1',
    'Young Rabbi',
    'Young Hiker',
    'Young Hippy',
    'Young Hipster 1',
    'Young Hipster 2',
    'Young Hipster 3',
    'a_m_y_indian_01',
    'a_m_y_jetski_01',
    'a_m_y_juggalo_01',
    'a_m_y_ktown_01',
    'a_m_y_ktown_02',
    'a_m_y_latino_01',
    'Young Meth Head',
    'Young Mexican',
    'a_m_y_motox_01',
    'a_m_y_motox_02',
    'a_m_y_musclbeac_01',
    'a_m_y_musclbeac_02',
    'a_m_y_polynesian_01',
    'a_m_y_roadcyc_01',
    'Young Runner 1',
    'Young Runner 2',
    'Young Salton',
    'Young Skater 1',
    'Young Skater 2',
    'Young South Central 1',
    'Young South Central 2',
    'Young South Central 3',
    'Young South Central 4',
    'a_m_y_stbla_01',
    'a_m_y_stbla_02',
    'a_m_y_stlat_01',
    'a_m_y_stwhi_01',
    'a_m_y_stwhi_02',
    'Sunbather',
    'Surfer',
    'Vinewood Douche',
    'Vinewood 1',
    'Vinewood 2',
    'Vinewood 3',
    'Vinewood 4',
    'Yoga',
    }
    
    AMC = {
    'a_m_m_acult_01',
    'a_m_m_afriamer_01',
    'a_m_m_beach_01',
    'a_m_m_beach_02',
    'a_m_m_bevhills_01',
    'a_m_m_bevhills_02',
    'a_m_m_business_01',
    'a_m_m_eastsa_01',
    'a_m_m_eastsa_02',
    'a_m_m_farmer_01',
    'a_m_m_fatlatin_01',
    'a_m_m_genfat_01',
    'a_m_m_genfat_02',
    'a_m_m_golfer_01',
    'a_m_m_hasjew_01',
    'a_m_m_hillbilly_01',
    'a_m_m_hillbilly_02',
    'a_m_m_indian_01',
    'a_m_m_ktown_01',
    'a_m_m_malibu_01',
    'a_m_m_mexcntry_01',
    'a_m_m_mexlabor_01',
    'a_m_m_og_boss_01',
    'a_m_m_paparazzi_01',
    'a_m_m_polynesian_01',
    'a_m_m_prolhost_01',
    'a_m_m_rurmeth_01',
    'a_m_m_salton_01',
    'a_m_m_salton_02',
    'a_m_m_salton_03',
    'a_m_m_salton_04',
    'a_m_m_skater_01',
    'a_m_m_skidrow_01',
    'a_m_m_socenlat_01',
    'a_m_m_soucent_01',
    'a_m_m_soucent_02',
    'a_m_m_soucent_03',
    'a_m_m_soucent_04',
    'a_m_m_stlat_02',
    'a_m_m_tennis_01',
    'a_m_m_tourist_01',
    'a_m_m_tramp_01',
    'a_m_m_trampbeac_01',
    'a_m_m_tranvest_01',
    'a_m_m_tranvest_02',
    'a_m_o_acult_01',
    'a_m_o_acult_02',
    'a_m_o_beach_01',
    'a_m_o_genstreet_01',
    'a_m_o_ktown_01',
    'a_m_o_salton_01',
    'a_m_o_soucent_01',
    'a_m_o_soucent_02',
    'a_m_o_soucent_03',
    'a_m_o_tramp_01',
    'a_m_y_acult_01',
    'a_m_y_acult_02',
    'a_m_y_beach_01',
    'a_m_y_beach_02',
    'a_m_y_beach_03',
    'a_m_y_beachvesp_01',
    'a_m_y_beachvesp_02',
    'a_m_y_bevhills_01',
    'a_m_y_bevhills_02',
    'a_m_y_breakdance_01',
    'a_m_y_busicas_01',
    'a_m_y_business_01',
    'a_m_y_business_02',
    'a_m_y_business_03',
    'a_m_y_cyclist_01',
    'a_m_y_dhill_01',
    'a_m_y_downtown_01',
    'a_m_y_eastsa_01',
    'a_m_y_eastsa_02',
    'a_m_y_epsilon_01',
    'a_m_y_epsilon_02',
    'a_m_y_gay_01',
    'a_m_y_gay_02',
    'a_m_y_genstreet_01',
    'a_m_y_genstreet_02',
    'a_m_y_golfer_01',
    'a_m_y_hasjew_01',
    'a_m_y_hiker_01',
    'a_m_y_hippy_01',
    'a_m_y_hipster_01',
    'a_m_y_hipster_02',
    'a_m_y_hipster_03',
    'a_m_y_indian_01',
    'a_m_y_jetski_01',
    'a_m_y_juggalo_01',
    'a_m_y_ktown_01',
    'a_m_y_ktown_02',
    'a_m_y_latino_01',
    'a_m_y_methhead_01',
    'a_m_y_mexthug_01',
    'a_m_y_motox_01',
    'a_m_y_motox_02',
    'a_m_y_musclbeac_01',
    'a_m_y_musclbeac_02',
    'a_m_y_polynesian_01',
    'a_m_y_roadcyc_01',
    'a_m_y_runner_01',
    'a_m_y_runner_02',
    'a_m_y_salton_01',
    'a_m_y_skater_01',
    'a_m_y_skater_02',
    'a_m_y_soucent_01',
    'a_m_y_soucent_02',
    'a_m_y_soucent_03',
    'a_m_y_soucent_04',
    'a_m_y_stbla_01',
    'a_m_y_stbla_02',
    'a_m_y_stlat_01',
    'a_m_y_stwhi_01',
    'a_m_y_stwhi_02',
    'a_m_y_sunbathe_01',
    'a_m_y_surfer_01',
    'a_m_y_vindouche_01',
    'a_m_y_vinewood_01',
    'a_m_y_vinewood_02',
    'a_m_y_vinewood_03',
    'a_m_y_vinewood_04',
    'a_m_y_yoga_01',
    }
    
    -----------------------------------Cutscene Peds--------------------------------------------------------------
    
    Csplist = {
        'Amanda Townley',
        'Andreas',
        'Ashley',
        'Bank Manager',
        'Barry',
        'Beverly',
        'Brad',
        'Brad Cadaver',
        'Car Buyer',
        'Casey',
        'Cheng SR',
        'Chris Formage',
        'Clay',
        'Dale',
        'Dave Norton',
        'Debra',
        'Denise',
        'Devin',
        'Dom',
        'Peter Dreyfuss',
        'Dr Friedlander',
        'Fabien',
        'FBI Suit',
        'Floyd',
        'Guadalope',
        'Gurk',
        'Hunter',
        'Janet',
        'Jewelery Assistant',
        'Jimmy Boston',
        'Jimmy Disanto',
        'Joe Minuteman',
        'Johnny Klebitz',
        'Josef',
        'Josh',
        'Karen Daniels',
        'Lamar Davis',
        'Lazlow',
        'Lester Crest',
        'Lester Crest 2',
        'Rickie Lukens',
        'Magenta',
        'Manuel',
        'Marnie',
        'Martin Madrazo',
        'Mary Ann',
        'Michelle',
        'Milton',
        'Molly',
        'Movie Premier Female',
        'Movie Premier Male',
        'Mark',
        'Mrs Thornhill',
        'Mrs Phillips',
        'Natalia',
        'Nervous Ron',
        'Nigel',
        'Old Man 1',
        'Old Man 2',
        'Omega',
        'Bigfoot',
        'Agent ULP',
        'Patricia',
        'Priest',
        'Prologue Security 2',
        'Russian Drunk',
        'Simeon Yetarian',
        'Solomon',
        'Steve Hains',
        'Stretch',
        'Tanisha',
        'Tao Cheng',
        'Taos Translator',
        'Tennis Coach',
        'Terry',
        'Tom',
        'Tom Epsilon',
        'Tracy Disanto',
        'Wade',
        'Zimbor',
        'Abigail',
        'Agent',
        'Alan',
        'Anita',
        'Anton',
        'Avon',
        'Ballas OG',
        'Bogdan',
        'Bride',
        'BurgerShot Drug Dealer',
        'Bryony',
        'Car guy 1',
        'Car guy 2',
        'Chef',
        'Chef2',
        'Chinese Goon',
        'Cletus',
        'Cop',
        'Customer',
        'Denise Friend',
        'FOS Rep',
        'csb_g',
        'Groom',
        'Grove Street Dealer',
        'Hao',
        'Hugh',
        'csb_imran',
        'Jack Howitzer',
        'Janitor',
        'Maude',
        'Money',
        'Agent 14',
        'Phoenicia Rackman',
        'Merryweather',
        'Ortega',
        'Oscar',
        'Paige',
        'Dimitri Popov',
        'Porn Dudes',
        'Prologue Driver',
        'prologue Security',
        'Rampage Gang',
        'Rampage Hics',
        'Rampage Hipster',
        'Rampage Marine',
        'Ramage Mexicans',
        'Rashcosvki',
        'Reporter',
        'Roccope Pelosi',
        'Screen Writer',
        'Stripper 1',
        'Stripper 2',
        'Tonya',
        'Traffic Warden',
        'Undercover',
        'Vagos Funeral Speaker',
    }
    
    CSP = {
        'cs_amandatownley',
        'cs_andreas',
        'cs_ashley',
        'cs_bankman',
        'cs_barry',
        'cs_beverly',
        'cs_brad',
        'cs_bradcadaver',
        'cs_carbuyer',
        'cs_casey',
        'cs_chengsr',
        'cs_chrisformage',
        'cs_clay',
        'cs_dale',
        'cs_davenorton',
        'cs_debra',
        'cs_denise',
        'cs_devin',
        'cs_dom',
        'cs_dreyfuss',
        'cs_drfriedlander',
        'cs_fabien',
        'cs_fbisuit_01',
        'cs_floyd',
        'cs_guadalope',
        'cs_gurk',
        'cs_hunter',
        'cs_janet',
        'cs_jewelass',
        'cs_jimmyboston',
        'cs_jimmydisanto',
        'cs_joeminuteman',
        'cs_johnnyklebitz',
        'cs_josef',
        'cs_josh',
        'cs_karen_daniels',
        'cs_lamardavis',
        'cs_lazlow',
        'cs_lestercrest',
        'cs_lestercrest_2',
        'cs_lifeinvad_01',
        'cs_magenta',
        'cs_manuel',
        'cs_marnie',
        'cs_martinmadrazo',
        'cs_maryann',
        'cs_michelle',
        'cs_milton',
        'cs_molly',
        'cs_movpremf_01',
        'cs_movpremmale',
        'cs_mrk',
        'cs_mrs_thornhill',
        'cs_mrsphillips',
        'cs_natalia',
        'cs_nervousron',
        'cs_nigel',
        'cs_old_man1a',
        'cs_old_man2',
        'cs_omega',
        'cs_orleans',
        'cs_paper',
        'cs_patricia',
        'cs_priest',
        'cs_prolsec_02',
        'cs_russiandrunk',
        'cs_siemonyetarian',
        'cs_solomon',
        'cs_stevehains',
        'cs_stretch',
        'cs_tanisha',
        'cs_taocheng',
        'cs_taostranslator',
        'cs_tenniscoach',
        'cs_terry',
        'cs_tom',
        'cs_tomepsilon',
        'cs_tracydisanto',
        'cs_wade',
        'cs_zimbor',
        'csb_abigail',
        'csb_agent',
        'csb_alan',
        'csb_anita',
        'csb_anton',
        'csb_avon',
        'csb_ballasog',
        'csb_bogdan',
        'csb_bride',
        'csb_burgerdrug',
        'csb_bryony',
        'csb_car3guy,1',
        'csb_car3guy2',
        'csb_chef',
        'csb_chef2',
        'csb_chin_goon',
        'csb_cletus',
        'csb_cop',
        'csb_customer',
        'csb_denise_friend',
        'csb_fos_rep',
        'csb_g',
        'csb_groom',
        'csb_grove_str_dlr',
        'csb_hao',
        'csb_hugh',
        'csb_imran',
        'csb_jackhowitzer',
        'csb_janitor',
        'csb_maude',
        'csb_money',
        'csb_mp_agent14',
        'csb_mrs_r',
        'csb_mweather',
        'csb_ortega',
        'csb_oscar',
        'csb_paige',
        'csb_popov',
        'csb_porndudes',
        'csb_prologuedriver',
        'csb_prolsec',
        'csb_ramp_gang',
        'csb_ramp_hic',
        'csb_ramp_hipster',
        'csb_ramp_marine',
        'csb_ramp_mex',
        'csb_rashcosvki',
        'csb_reporter',
        'csb_roccopelosi',
        'csb_screen_writer',
        'csb_stripper_01',
        'csb_stripper_02',
        'csb_tonya',
        'csb_trafficwarden',
        'csb_undercover',
        'csb_vagspeak',
    
    }
    
    -------------------------------------Gang Members--------------------------------------------------------
    
    GMlist = {
    'Female Import Export',
    'Ballas Female',
    'Grove Street Female',
    'Lost MC Female',
    'Vagos Female',
    'Male Import Export',
    'Armenian Boss',
    'Armenian Goon 1',
    'Armenian Lieutenant',
    'Chem Plant Worker',
    'Chinese Boss',
    'Older Chinese Goon ',
    'Chinese Goon 1',
    'Chinese Goon 2',
    'Korean Boss 1',
    'Mexican Boss 1',
    'Mexican Boss 2',
    'Armenian Goon 2',
    'Azteca',
    'Ballas Easy',
    'Ballas Original',
    'Ballas South',
    'Grove Street 1',
    'Grove Street 2',
    'Grove Street 3',
    'Korean Goon 1',
    'Korean Goon ',
    'Korean Lieutenant',
    'Lost 1',
    'Lost 2',
    'Lost 3',
    'Mexican Gang',
    'Mexican Goon 1',
    'Mexican Goon 2',
    'Mexican Goon 3',
    'Polynesian Goon 1',
    'Polynesian Goon 2',
    'Salvadoran Boss',
    'Salvadoran Goon 1',
    'Salvadoran Goon 2',
    'Salvadoran Goon 3',
    'Street Punk 1',
    'Street Punk 2',
    }
    
    GM = {
    'g_f_importexport_01',
    'g_f_y_ballas_01',
    'g_f_y_families_01',
    'g_f_y_lost_01',
    'g_f_y_vagos_01',
    'g_m_importexport_01',
    'g_m_m_armboss_01',
    'g_m_m_armgoon_01',
    'g_m_m_armlieut_01',
    'g_m_m_chemwork_01',
    'g_m_m_chiboss_01',
    'g_m_m_chicold_01',
    'g_m_m_chigoon_01',
    'g_m_m_chigoon_02',
    'g_m_m_korboss_01',
    'g_m_m_mexboss_01',
    'g_m_m_mexboss_02',
    'g_m_y_armgoon_02',
    'g_m_y_azteca_01',
    'g_m_y_ballaeast_01',
    'g_m_y_ballaorig_01',
    'g_m_y_ballasout_01',
    'g_m_y_famca_01',
    'g_m_y_famdnf_01',
    'g_m_y_famfor_01',
    'g_m_y_korean_01',
    'g_m_y_korean_02',
    'g_m_y_korlieut_01',
    'g_m_y_lost_01',
    'g_m_y_lost_02',
    'g_m_y_lost_03',
    'g_m_y_mexgang_01',
    'g_m_y_mexgoon_01',
    'g_m_y_mexgoon_02',
    'g_m_y_mexgoon_03',
    'g_m_y_pologoon_01',
    'g_m_y_pologoon_02',
    'g_m_y_salvaboss_01',
    'g_m_y_salvagoon_01',
    'g_m_y_salvagoon_02',
    'g_m_y_salvagoon_03',
    'g_m_y_strpunk_01',
    'g_m_y_strpunk_02',
    }
    
    ----------------------------------------Multiplayer------------------------------------------------------------
    
    Mpplist = {
    'Benny Mechanic',
    'Female Boat Staff',
    'Female Car Designer',
    'Female Bartender',
    'Female Cocaine Worker',
    'Female Counterfeit Worker',
    'Dead Hooker',
    'Female Executive Assistant 1',
    'Female Executive Assistant 2',
    'Female Forgery Worker',
    'Female Freemode',
    'Female Helistaff',
    'Female Meth Worker',
    'Misty',
    'Stripper',
    'Female Weed Worker',
    'Heist Goons',
    'Avon Goon',
    'Male Boat Staff',
    'Bogdan Goon',
    'Claude',
    'Male Cocaine Worker',
    'Male Counterfeit Worker',
    'Ex Army Vet',
    'Male exec PA ',
    'Grove Street',
    'Male FIB Secretary',
    'Male Forgery Worker',
    'Male Freemode',
    'John Marston',
    'Male Meth Worker',
    'Niko Belic',
    'Securo Guard',
    'Male Shopkeep',
    'Warehouse Mechanic',
    'Male Weed Worker',
    'Vagos Funeral',
    'Male Armoured',
    'Weapons Expert',
    'Weapons Worker',
    }
    
    Mpp = {
    'mp_f_bennymech_01',
    'mp_f_boatstaff_01',
    'mp_f_cardesign_01',
    'mp_f_chbar_01',
    'mp_f_cocaine_01',
    'mp_f_counterfeit_01',
    'mp_f_deadhooker',
    'mp_f_execpa_01',
    'mp_f_execpa_02',
    'mp_f_forgery_01',
    'mp_f_freemode_01',
    'mp_f_helistaff_01',
    'mp_f_meth_01',
    'mp_f_misty_01',
    'mp_f_stripperlite',
    'mp_f_weed_01',
    'mp_g_m_pros_01',
    'mp_m_avongoon',
    'mp_m_boatstaff_01',
    'mp_m_bogdangoon',
    'mp_m_claude_01',
    'mp_m_cocaine_01',
    'mp_m_counterfeit_01',
    'mp_m_exarmy_01',
    'mp_m_execpa_01',
    'mp_m_famdd_01',
    'mp_m_fibsec_01',
    'mp_m_forgery_01',
    'mp_m_freemode_01',
    'mp_m_marston_01',
    'mp_m_meth_01',
    'mp_m_niko_01',
    'mp_m_securoguard_01',
    'mp_m_shopkeep_01',
    'mp_m_waremech_01',
    'mp_m_weed_01',
    'mp_m_g_vagfun_01',
    'mp_s_m_armoured_01',
    'mp_m_weapexp_01',
    'mp_m_weapwork_01',
    }
    
    ------------------------------MP Scenario Females----------------------------------------
    
    
    MSFlist = {
    'Barber',
    'Maid',
    'Highend Shop Keeper',
    'Sweatshop Worker',
    'Air Hostess',
    'Bartender',
    'Lifguard',
    'Cop',
    'Factory Worker',
    'Hooker 1',
    'Hooker 2',
    'Hooker 3',
    'Migrant',
    'Movie Premier',
    'Ranger',
    'Nurse Scrubs',
    'Sheriff',
    'Low End Shop Keeper',
    'Mid Level Shop Keeper',
    'Stripper 1',
    'Stripper 2',
    'Stripper 3',
    'Sweat Shop 2',
    }
    
    MSF = {
    's_f_m_fembarber',
    's_f_m_maid_01',
    's_f_m_shop_high',
    's_f_m_sweatshop_01',
    's_f_y_airhostess_01',
    's_f_y_bartender_01',
    's_f_y_baywatch_01',
    's_f_y_cop_01',
    's_f_y_factory_01',
    's_f_y_hooker_01',
    's_f_y_hooker_02',
    's_f_y_hooker_03',
    's_f_y_migrant_01',
    's_f_y_movprem_01',
    's_f_y_ranger_01',
    's_f_y_scrubs_01',
    's_f_y_sheriff_01',
    's_f_y_shop_low',
    's_f_y_shop_mid',
    's_f_y_stripper_01',
    's_f_y_stripper_02',
    's_f_y_stripperlite',
    's_f_y_sweatshop_01',
    }
    
    ----------------------------------MP Scenario Males-------------------------------------------------------
    
    MCMlist = {
    'Male Ammunation Clerk 1',
    'Armoured Male 1',
    'Armoured Male 2',
    'Autoshop 1',
    'Autoshop 2',
    'Bouncer',
    'Aircraft Carrier Crew',
    'Chem Plant Security',
    'CIA Security',
    'Country Bartender',
    'Dock Worker',
    'Doctor',
    'FIB Office Worker 1',
    'FIB Office Worker 2',
    'FIB Security',
    'Gaffer',
    'Gardener',
    'General Transport Worker',
    'Hair dresser',
    'Highend Security 1',
    'Highend security 2',
    'Janitor',
    'Latino Handyman',
    'Life Invader',
    'Line Cook',
    'LS metro',
    'Mariachi Band',
    'Marine 1',
    'Marine 2',
    'Migrant',
    'Alien Costume',
    'Movie Premier',
    'Movie Astronaut',
    'Paramedic',
    'Pilot 1',
    'Pilot 2',
    'Postal 1',
    'Postal 2',
    'Prison Guard',
    'Scientist',
    'Security Guard',
    'Snow Cop',
    'Street Performer',
    'Street Preacher',
    'Street Vendor',
    'Trucker',
    'Ups 1',
    'Ups 2',
    'Busker',
    'Airline Worker',
    'Ammunation City',
    'Army Mechanic',
    'Autopsy Doc',
    'Bartender',
    'Lifguard',
    'Blackops 1',
    'Blackops 2',
    'Blackops 3',
    'Busboy',
    'Chef',
    'Clown',
    'Construction 1',
    'Construction 2',
    'Cop',
    'Dealer',
    'Devin Security',
    'Dock Worker',
    'Doorman',
    'Airport Service 1',
    'Airport Service 2',
    'Factory Worker',
    'Fireman',
    'Garbage Collector',
    'Vinewood Grip',
    'Highway Cop',
    'Young Marine 1',
    'Young Marine 2',
    'Young Marine 3',
    'Mime',
    'Pest Control',
    'Pilot',
    'Prisoner muscular',
    'Prisoner',
    'Ranger',
    'Robber',
    'Sheriff',
    'Shop Mask Vendor',
    'Young street Vendor',
    'SWAT',
    'US Coast Guard',
    'Valet',
    'Waiter',
    'Window Cleaner',
    'Mechanic',
    'Mechanic MP'
    }
    
    MCM = {
    's_m_m_ammucountry',
    's_m_m_armoured_01',
    's_m_m_armoured_02',
    's_m_m_autoshop_01',
    's_m_m_autoshop_02',
    's_m_m_bouncer_01',
    's_m_m_ccrew_01',
    's_m_m_chemsec_01',
    's_m_m_ciasec_01',
    's_m_m_cntrybar_01',
    's_m_m_dockwork_01',
    's_m_m_doctor_01',
    's_m_m_fiboffice_01',
    's_m_m_fiboffice_02',
    's_m_m_fibsec_01',
    's_m_m_gaffer_01',
    's_m_m_gardener_01',
    's_m_m_gentransport',
    's_m_m_hairdress_01',
    's_m_m_highsec_01',
    's_m_m_highsec_02',
    's_m_m_janitor',
    's_m_m_lathandy_01',
    's_m_m_lifeinvad_01',
    's_m_m_linecook',
    's_m_m_lsmetro_01',
    's_m_m_mariachi_01',
    's_m_m_marine_01',
    's_m_m_marine_02',
    's_m_m_migrant_01',
    's_m_m_movalien_01',
    's_m_m_movprem_01',
    's_m_m_movspace_01',
    's_m_m_paramedic_01',
    's_m_m_pilot_01',
    's_m_m_pilot_02',
    's_m_m_postal_01',
    's_m_m_postal_02',
    's_m_m_prisguard_01',
    's_m_m_scientist_01',
    's_m_m_security_01',
    's_m_m_snowcop_01',
    's_m_m_strperf_01',
    's_m_m_strpreach_01',
    's_m_m_strvend_01',
    's_m_m_trucker_01',
    's_m_m_ups_01',
    's_m_m_ups_02',
    's_m_o_busker_01',
    's_m_y_airworker',
    's_m_y_ammucity_01',
    's_m_y_armymech_01',
    's_m_y_autopsy_01',
    's_m_y_barman_01',
    's_m_y_baywatch_01',
    's_m_y_blackops_01',
    's_m_y_blackops_02',
    's_m_y_blackops_03',
    's_m_y_busboy_01',
    's_m_y_chef_01',
    's_m_y_clown_01',
    's_m_y_construct_01',
    's_m_y_construct_02',
    's_m_y_cop_01',
    's_m_y_dealer_01',
    's_m_y_devinsec_01',
    's_m_y_dockwork_01',
    's_m_y_doorman_01',
    's_m_y_dwservice_01',
    's_m_y_dwservice_02',
    's_m_y_factory_01',
    's_m_y_fireman_01',
    's_m_y_garbage',
    's_m_y_grip_01',
    's_m_y_hwaycop_01',
    's_m_y_marine_01',
    's_m_y_marine_02',
    's_m_y_marine_03',
    's_m_y_mime',
    's_m_y_pestcont_01',
    's_m_y_pilot_01',
    's_m_y_prismuscl_01',
    's_m_y_prisoner_01',
    's_m_y_ranger_01',
    's_m_y_robber_01',
    's_m_y_sheriff_01',
    's_m_y_shop_mask',
    's_m_y_strvend_01',
    's_m_y_swat_01',
    's_m_y_uscg_01',
    's_m_y_valet_01',
    's_m_y_waiter_01',
    's_m_y_winclean_01',
    's_m_y_xmech_01',
    's_m_y_xmech_02_mp'
    }
    
    -----------------------------------------Story Mode---------------------------------------------------
    
    SMClist = {
    'Heist Crew Driver',--1
    'Heist Crew Gunman',--2
    'Heist Crew Hacker',--3
    'Abigail',--4
    'Agent',--5
    'Amanda Townley',--6
    'Andreas',--7
    'Ashley',--8
    'Avon',--9
    'Ballas OG',--10
    'Bankman',--11
    'Barry',--12
    'Benny ',--13
    'Bestmen Wedding',
    'Beverly',
    'Brad',
    'Bride',
    'Car Guy 1',
    'Car Guy 2',
    'Casey',
    'Chef',
    'Chef2',
    'Cheng SR',
    'Chris Formage',
    'Clay',
    'Clay Pain',
    'Cletus',
    'Dale',
    'Dave Norton',
    'Denise',
    'Devin',
    'Dom',
    'Peter Dreyfuss',
    'Dr Friedlander',
    'Fabien',
    'Fbi Suit',
    'Floyd',
    'Franklin',
    'Gerald',
    'Groom',
    'Hao',
    'Hunter',
    'Janet',
    'Jay Norris',
    'Jewel Assitant',
    'Jimmy Boston',
    'Jimmy Disanto',
    'Joe Minuteman',
    'Johnny Klebitz',
    'Jose',
    'Josh',
    'Karen Daniels',
    'Kerry Mcintosh',
    'Lamar Davis',
    'Lazlow',
    'Lestercrest',
    'Lestercrest 2',
    'Rickie Lukens',
    'Lifeinvader Employee',
    'Magenta',
    'Malc',
    'Manuel',
    'Marnie',
    'Mary Ann',
    'Maude',
    'Michael',
    'Michelle',
    'Milton',
    'Molly',
    'Money',
    'MP Agent 14',
    'Torture Victim',
    'Mrs Thornhill',
    'Mrs Phillips',
    'Natalia',
    'Nervous Ron',
    'Nigel',
    'Old Man 1',
    'Old Man 2',
    'Omega',
    'Oneil Brothers',
    'Bigfoot',
    'Ortega',
    'Paige',
    'Agent ULP',
    'Patricia',
    'Dima Popov',
    'Priest',
    'Prologue Security',
    'Rampage Gang',
    'Rampage Hics',
    'Rampage Hipsters',
    'Rampage Vagos',
    'Rashcosvki',
    'Rocco Pelosi',
    'Russian Drunk',
    'Sacha',
    'Screen Writer',
    'Simeon Yetarian',
    'Solomon',
    'Steve Hains',
    'Stretch',
    'Talina',
    'Tanisha',
    'Tao Cheng',
    'Taos Translator',
    'Tennis Coach',
    'Terry',
    'Tom Epsilon',
    'Tonya',
    'Tracy Disanto',
    'Traffic Warden',
    'Trevor',
    'Tyler Dix',
    'Vagos Funeral',
    'Wade',
    'Zimbor',
    }
    
    SMC = {
    'hc_driver',--1
    'hc_gunman',--2
    'hc_hacker',--3
    'ig_abigail',--4
    'ig_agent',--5
    'ig_amandatownley',--6
    'ig_andreas',--7
    'ig_ashley',--8
    'ig_avon',--9
    'ig_ballasog',--10
    'ig_bankman',--11
    'ig_barry',--12
    'ig_benny ',--13
    'ig_bestmen',
    'ig_beverly',
    'ig_brad',
    'ig_bride',
    'ig_car3guy1',
    'ig_car3guy2',
    'ig_casey',
    'ig_chef',
    'ig_chef2',
    'ig_chengsr',
    'ig_chrisformage',
    'ig_clay',
    'ig_claypain',
    'ig_cletus',
    'ig_dale',
    'ig_davenorton',
    'ig_denise',
    'ig_devin',
    'ig_dom',
    'ig_dreyfuss',
    'ig_drfriedlander',
    'ig_fabien',
    'ig_fbisuit_01',
    'ig_floyd',
    'player_one',
    'ig_g',
    'ig_groom',
    'ig_hao',
    'ig_hunter',
    'ig_janet',
    'ig_jay_norris',
    'ig_jewelass',
    'ig_jimmyboston',
    'ig_jimmydisanto',
    'ig_joeminuteman',
    'ig_johnnyklebitz',
    'ig_josef',
    'ig_josh',
    'ig_karen_daniels',
    'ig_kerrymcintosh',
    'ig_lamardavis',
    'ig_lazlow',
    'ig_lestercrest',
    'ig_lestercrest_2',
    'ig_lifeinvad_01',
    'ig_lifeinvad_02',
    'ig_magenta',
    'ig_malc',
    'ig_manuel',
    'ig_marnie',
    'ig_maryann',
    'ig_maude',
    'player_zero',
    'ig_michelle',
    'ig_milton',
    'ig_molly',
    'ig_money',
    'ig_mp_agent14',
    'ig_mrk',
    'ig_mrs_thornhill',
    'ig_mrsphillips',
    'ig_natalia',
    'ig_nervousron',
    'ig_nigel',
    'ig_old_man1a',
    'ig_old_man2',
    'ig_omega',
    'ig_oneil',
    'ig_orleans',
    'ig_ortega',
    'ig_paige',
    'ig_paper',
    'ig_patricia',
    'ig_popov',
    'ig_priest',
    'ig_prolsec_02',
    'ig_ramp_gang',
    'ig_ramp_hic',
    'ig_ramp_hipster',
    'ig_ramp_mex',
    'ig_rashcosvki',
    'ig_roccopelosi',
    'ig_russiandrunk',
    'ig_sacha',
    'ig_screen_writer',
    'ig_siemonyetarian',
    'ig_solomon',
    'ig_stevehains',
    'ig_stretch',
    'ig_talina',
    'ig_tanisha',
    'ig_taocheng',
    'ig_taostranslator',
    'ig_tenniscoach',
    'ig_terry',
    'ig_tomepsilon',
    'ig_tonya',
    'ig_tracydisanto',
    'ig_trafficwarden',
    'player_two',
    'ig_tylerdix',
    'ig_vagspeak',
    'ig_wade',
    'ig_zimbor',
    }
    
    --------------------------------Story Scenario Females-------------------------------------------------------
    
    Ssflist = {
        'Corpse 1',
        'Drowned Body',
        'Miranda',
        'Mourner',
        'Movie Star',
        'Prologue Hostage',
        'Biker Chic',
        'Jane',
        'Corpse 2',
        'Corpse 3',
        'Posh Female',
        'Jewel Store Assistant',
        'Mistress',
        'Poppy Mitchell',
        'Princess',
        'Spy Actress',
    }
    
    Ssf = {
        'u_f_m_corpse_01',
        'u_f_m_drowned_01',
        'u_f_m_miranda',
        'u_f_m_promourn_01',
        'u_f_o_moviestar',
        'u_f_o_prolhost_01',
        'u_f_y_bikerchic',
        'u_f_y_comjane',
        'u_f_y_corpse_01',
        'u_f_y_corpse_02',
        'u_f_y_hotposh_01',
        'u_f_y_jewelass_01',
        'u_f_y_mistress',
        'u_f_y_poppymich',
        'u_f_y_princess',
        'u_f_y_spyactress',
    }
    
    -------------------------------------------Story Scenario Males---------------------------------------------------------
    
    Ssmlist = {
        'Al Di Napoli',
        'Bank Manager',
        'Bike Hire',
        'DOA Agent',
        'Eddie Toh',
        'FIB Architect',
        'Film Director',
        'Glen Stank',
        'Griff_01',
        'Jesus',
        'Jewelery Security',
        'Jewel Thief',
        'Mark Fostenburg',
        'Party Target',
        'Prologue Security',
        'Prologue Mourn Male',
        'Rival Paparazzo',
        'Spy Actor',
        'Street Artist',
        'Love Fist Willy',
        'Film Noir',
        'Financial Guru',
        'Tap Dancing Hillbilly',
        'Old Male Tramp',
        'Abner',
        'Anton Beaudelaire',
        'Baby D',
        'Baygor(kifflom)',
        'Burgershot Drug Dealer',
        'Chip',
        'Male Corpse 1',
        'Male Cyclist',
        'FIB Mugger',
        'Guido',
        'Gun Vendor',
        'Hippie',
        'Impotent Rage',
        'Juggernaut',
        'Justin',
        'Mani',
        'Military Bum',
        'Paparazzi',
        'Party',
        'Pogo',
        'Prisoner',
        'Prologue Driver',
        'Republican Space Ranger',
        'Sports Bike Rider',
        'Hanger Mechanic',
        'Groom Stag Party',
        'Tattoo Artist',
        'Zombie',
    }
    
    Ssm = {
        'u_m_m_aldinapoli',
        'u_m_m_bankman',
        'u_m_m_bikehire_01',
        'u_m_m_doa_01',
        'u_m_m_edtoh',
        'u_m_m_fibarchitect',
        'u_m_m_filmdirector',
        'u_m_m_glenstank_01',
        'u_m_m_griff_01',
        'u_m_m_jesus_01',
        'u_m_m_jewelsec_01',
        'u_m_m_jewelthief',
        'u_m_m_markfost',
        'u_m_m_partytarget',
        'u_m_m_prolsec_01',
        'u_m_m_promourn_01',
        'u_m_m_rivalpap',
        'u_m_m_spyactor',
        'u_m_m_streetart_01',
        'u_m_m_willyfist',
        'u_m_o_filmnoir',
        'u_m_o_finguru_01',
        'u_m_o_taphillbilly',
        'u_m_o_tramp_01',
        'u_m_y_abner',
        'u_m_y_antonb',
        'u_m_y_babyd',
        'u_m_y_baygor',
        'u_m_y_burgerdrug_01',
        'u_m_y_chip',
        'u_m_y_corpse_01',
        'u_m_y_cyclist_01',
        'u_m_y_fibmugger_01',
        'u_m_y_guido_01',
        'u_m_y_gunvend_01',
        'u_m_y_hippie_01',
        'u_m_y_imporage',
        'u_m_y_juggernaut_01',
        'u_m_y_justin',
        'u_m_y_mani',
        'u_m_y_militarybum',
        'u_m_y_paparazzi',
        'u_m_y_party_01',
        'u_m_y_pogo_01',
        'u_m_y_prisoner_01',
        'u_m_y_proldriver_01',
        'u_m_y_rsranger_01',
        'u_m_y_sbike',
        'u_m_y_smugmech_01',
        'u_m_y_staggrm_01',
        'u_m_y_tattoo_01',
        'u_m_y_zombie_01',
    }
    
    -----------------------------------DLC Peds------------------------------------------------------------
    
    Dlcplist = {
        'Female Club Customer 1',
        'Female Club Customer 2',
        'Female Club Customer 3',
        'Male Club Customer 1',
        'Male Club Customer 2',
        'Male Club Customer 3',
        'Dixon',
        'DJ the Black Madonna',
        'ig_djblamrupert',
        'ig_djblamryanh',
        'ig_djblamryans',
        'Dixon Manager',
        'ig_djgeneric_01',
        'ig_djsolfotios',
        'ig_djsoljakob',
        'DJ Solomun Manager',
        'ig_djsolmike',
        'ig_djsolrobt',
        'ig_djtalaurelia',
        'ig_djtalignazio',
        'English Dave',
        'Jimmy Boston 2',
        'Kerry Mcintosh 2',
        'Lacey Jones 2',
        'Lazlow 2',
        'Solomun',
        'ig_talcc',
        'ig_talmm',
        'Tony Prince',
        'Tyler Dix',
        'Female Club Bar',
        'Male Club Bar',
        'Warehouse Tech',
        'Miranda 2',
        'u_f_y_danceburl_01',
        'u_f_y_dancelthr_01',
        'u_f_y_dancerave_01',
        'Poppy Mitchell',
        'u_m_y_danceburl_01',
        'u_m_y_dancelthr_01',
        'u_m_y_dancerave_01',
        'Agatha',
        'Avery',
        'Brucie 2',
        'Tao Cheng 2',
        'Taos Translator 2',
        'Thornton',
        'Tom Connors',
        'Vincent',
        'Female General Casino',
        'Female Smart Casino',
        'A_M_M_MLCrisis_01',
        'Male General Casino',
        'Male Smart Casino',
        'G_M_M_CasRN_01',
        'S_M_Y_WestSec_01',
        'Female Casino',
        'Male Casino',
        'Carol',
        'Eileen',
        'Casino Cashier',
        'Casino Shop Clerk',
        'Debbie',
        'Beth',
        'Lauren',
        'Taylor',
        'Blane',
        'Curtis',
        'Vince',
        'Dean',
        'Caleb',
        'CroupThief_01',
        'Gabriel',
        'Ushi',
        'a_f_y_bevhills_05',
        'ig_celeb_01',
        'Georgina Cheng',
        'Huang',
        'Jimmy Disanto 2',
        'Lester Crest 3',
        'Vincent',
        'Wendy',
        'Highend Security 3',
        'West Security 2',
        'Female Beach 2',
        'Club customer 3',
        'Male Beach 1',
        'Male Beach 2',
        'Club Customer 4',
        'Cartel Guards 1',
        'Cartel Guards 2',
        'Dre (better)',
        'English Dave 2',
        'Gustavo',
        'Helmsman Pavel',
        'ig_isldj_00',
        'ig_isldj_01',
        'ig_isldj_02',
        'ig_isldj_03',
        'ig_isldj_04',
        'ig_isldj_04_d_01',
        'ig_isldj_04_d_02',
        'ig_isldj_04_e_01',
        'Jackie',
        'Jimmy Iovine (better)',
        'Juan Strickler(El Rubio)',
        'Kaylee',
        'Miguel Madrazo',
        'DJ Pooh (better)',
        'Old Rich Guy',
        'Patricia 2',
        'Pilot',
        'ig_sss',
        'Beach Bar Staff',
        'Female Club Bar 2',
        'Bouncer 2',
        'Drug Processor',
        'Fieldworker',
        'Highend Security 4',
        'Female Car Club 1',
        'Male Car Club 1',
        'Tattoo Customer',
        'Prisoners 1',
        'Slasher 1',
        'Avi Schwartzman 2',
        'Benny 2',
        'Drug Dealer',
        'Hao 2',
        'Lil Dee',
        'Mimi',
        'Moodyman 2',
        'Sessanta',
        'Female Autoshop 1',
        'Retail Staff',
        'Male Autoshop 3',
        'Race Organizer 1',
        'Tattoo Artist',
        'Female Studio Party 1',
        'Female Studio Party 2',
        'Male Studio Party 1',
        'Male Studio Party 2',
        'Goons 1',
        'Dre',
        'Ballas Leader',
        'Billionaire',
        'Entourage A',
        'Entourage B',
        'Golfer A',
        'Golfer B',
        'Imani',
        'Jimmy Iovine',
        'Johnny Guns',
        'Lamar Davis 2',
        'DJ Pooh',
        'Musician',
        'Party Promoter',
        'Requisition Officer',
        'Security A',
        'Sound Engineer',
        'Vagos Leader',
        'Vernon',
        'Vincent 3',
        'Franklin 2',
        'Female Studio Assist',
        'Highend Security',
        'Male Studio Assist',
        'Studio Producer',
        'Studio Sound Engineer',
    }
    
    Dlcp = {
       'a_f_y_clubcust_01',
        'a_f_y_clubcust_02',
        'a_f_y_clubcust_03',
        'a_m_y_clubcust_01',
        'a_m_y_clubcust_02',
        'a_m_y_clubcust_03',
        'ig_dix',
        'ig_djblamadon',
        'ig_djblamrupert',
        'ig_djblamryanh',
        'ig_djblamryans',
        'ig_djdixmanager',
        'ig_djgeneric_01',
        'ig_djsolfotios',
        'ig_djsoljakob',
        'ig_djsolmanager',
        'ig_djsolmike',
        'ig_djsolrobt',
        'ig_djtalaurelia',
        'ig_djtalignazio',
        'ig_englishdave',
        'ig_jimmyboston_02',
        'ig_kerrymcintosh_02',
        'ig_lacey_jones_02',
        'ig_lazlow_2',
        'ig_sol',
        'ig_talcc',
        'ig_talmm',
        'ig_tonyprince',
        'ig_tylerdix_02',
        's_f_y_clubbar_01',
        's_m_y_clubbar_01',
        's_m_y_waretech_01',
        'u_f_m_miranda_02',
        'u_f_y_danceburl_01',
        'u_f_y_dancelthr_01',
        'u_f_y_dancerave_01',
        'u_f_y_poppymich_02',
        'u_m_y_danceburl_01',
        'u_m_y_dancelthr_01',
        'u_m_y_dancerave_01',
        'IG_Agatha',
        'IG_Avery',
        'IG_Brucie2',
        'IG_TaoCheng2',
        'IG_TaosTranslator2',
        'IG_Thornton',
        'IG_TomCasino',
        'IG_Vincent',
        'A_F_Y_GenCasPat_01',
        'A_F_Y_SmartCasPat_01',
        'A_M_M_MLCrisis_01',
        'A_M_Y_GenCasPat_01',
        'A_M_Y_SmartCasPat_01',
        'G_M_M_CasRN_01',
        'S_M_Y_WestSec_01',
        'S_F_Y_Casino_01',
        'S_M_Y_Casino_01',
        'U_F_O_Carol',
        'U_F_O_Eileen',
        'U_F_M_CasinoCash_01',
        'U_F_M_CasinoShop_01',
        'U_F_M_Debbie_01',
        'U_F_Y_Beth',
        'U_F_Y_Lauren',
        'U_F_Y_Taylor',
        'U_M_M_Blane',
        'U_M_M_Curtis',
        'U_M_M_Vince',
        'U_M_O_Dean',
        'U_M_Y_Caleb',
        'U_M_Y_CroupThief_01',
        'U_M_Y_Gabriel',
        'U_M_Y_Ushi',
        'a_f_y_bevhills_05',
        'ig_celeb_01',
        'ig_georginacheng',
        'ig_huang',
        'ig_jimmydisanto2',
        'ig_lestercrest_3',
        'ig_vincent_2',
        'ig_wendy',
        's_m_m_highsec_03',
        's_m_y_westsec_02',
        'a_f_y_beach_02',
        'a_f_y_clubcust_04',
        'a_m_o_beach_02',
        'a_m_y_beach_04',
        'a_m_y_clubcust_04',
        'g_m_m_cartelguards_01',
        'g_m_m_cartelguards_02',
        'ig_ary',
        'ig_englishdave_02',
        'ig_gustavo',
        'ig_helmsmanpavel',
        'ig_isldj_00',
        'ig_isldj_01',
        'ig_isldj_02',
        'ig_isldj_03',
        'ig_isldj_04',
        'ig_isldj_04_d_01',
        'ig_isldj_04_d_02',
        'ig_isldj_04_e_01',
        'ig_jackie',
        'ig_jio',
        'ig_juanstrickler',
        'ig_kaylee',
        'ig_miguelmadrazo',
        'ig_mjo',
        'ig_oldrichguy',
        'ig_patricia_02',
        'ig_pilot',
        'ig_sss',
        's_f_y_beachbarstaff_01',
        's_f_y_clubbar_02',
        's_m_m_bouncer_02',
        's_m_m_drugprocess_01',
        's_m_m_fieldworker_01',
        's_m_m_highsec_04',
        'A_F_Y_CarClub_01',
        'A_M_Y_CarClub_01',
        'A_M_Y_TattooCust_01',
        'G_M_M_Prisoners_01',
        'G_M_M_Slasher_01',
        'IG_AviSchwartzman_02',
        'IG_Benny_02',
        'IG_DrugDealer',
        'IG_Hao_02',
        'IG_LilDee',
        'IG_Mimi',
        'IG_Moodyman_02',
        'IG_Sessanta',
        'S_F_M_Autoshop_01',
        'S_F_M_RetailStaff_01',
        'S_M_M_Autoshop_03',
        'S_M_M_RaceOrg_01',
        'S_M_M_Tattoo_01',
        'A_F_Y_StudioParty_01',
        'A_F_Y_StudioParty_02',
        'A_M_M_StudioParty_01',
        'A_M_Y_StudioParty_01',
        'G_M_M_Goons_01',
        'IG_ARY_02',
        'IG_Ballas_Leader',
        'IG_Billionaire',
        'IG_Entourage_A',
        'IG_Entourage_B',
        'IG_Golfer_A',
        'IG_Golfer_B',
        'IG_Imani',
        'IG_JIO_02',
        'IG_Johnny_Guns',
        'IG_LamarDavis_02',
        'IG_MJO_02',
        'IG_Musician_00',
        'IG_Party_Promo',
        'IG_Req_Officer',
        'IG_Security_A',
        'IG_SoundEng_00',
        'IG_Vagos_Leader',
        'IG_Vernon',
        'IG_Vincent_3',
        'P_Franklin_02',
        'S_F_M_StudioAssist_01',
        'S_M_M_HighSec_05',
        'S_M_M_StudioAssist_02',
        'S_M_M_StudioProd_01',
        'S_M_M_StudioSouEng_02',
    }
    




    

objset = {mdl = 'prop_mineshaft_door'}





-------------------------------Player Options-----------------------------------------------
local cage_table = {}
function pedcageg(pid)
    local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
    local pname = PLAYER.GET_PLAYER_NAME(pid)
    if not cage_table[pid] then
        local peds = {}
        local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Ninja Method"))
        Delcar(targets, spec, pid)
        
    
    local p1 = Pedspawn(tar1)
    local p2 = Pedspawn(tar1)
    local p3 = Pedspawn(tar1)
    local p4 = Pedspawn(tar1)
    local p5 = Pedspawn(tar1)
    local p6 = Pedspawn(tar1)
    local p7 = Pedspawn(tar1)
    local p8 = Pedspawn(tar1)
    
    SetPedCoor(p1, tar1.x, tar1.y - 0.5, tar1.z - 1.0)
    SetPedCoor(p2, tar1.x - 0.5, tar1.y - 0.5, tar1.z - 1.0)
    SetPedCoor(p3, tar1.x - 0.5, tar1.y, tar1.z - 1.0)
    SetPedCoor(p4, tar1.x - 0.5, tar1.y + 0.5, tar1.z - 1.0)
    SetPedCoor(p5, tar1.x, tar1.y + 0.5, tar1.z - 1.0)
    SetPedCoor(p6, tar1.x + 0.5, tar1.y + 0.5, tar1.z - 1.0)
    SetPedCoor(p7, tar1.x + 0.5, tar1.y, tar1.z - 1.0)
    SetPedCoor(p8, tar1.x + 0.5, tar1.y - 0.5, tar1.z - 1.0)
    
    ---------Audio--------------
    if Pedhash == util.joaat('IG_LesterCrest')  then
        Teabagtime(p1, p2, p3, p4, p5, p6, p7, p8)
    elseif Pedhash == util.joaat('player_two') then
        Trevortime(p1, p2, p3, p4, p5, p6, p7, p8)
    elseif Pedhash ~= util.joaat('IG_LesterCrest') or util.joaat('player_two') then
    if AUDIO.DOES_CONTEXT_EXIST_FOR_THIS_PED(p1, 'GENERIC_FUCK_YOU') ==true 
    then Fuckyou(peds)
    
    elseif AUDIO.DOES_CONTEXT_EXIST_FOR_THIS_PED(p1, 'Provoke_Trespass')
    then Provoke(peds)
    
    elseif AUDIO.DOES_CONTEXT_EXIST_FOR_THIS_PED(p1, 'Generic_Insult_High')
    then Insulthigh(peds)
    
    elseif AUDIO.DOES_CONTEXT_EXIST_FOR_THIS_PED(p1, 'GENERIC_WAR_CRY')
    then Warcry(peds) 
    else
    end
    end
    
          -----------Anim-------------------------
        Streamanim('rcmpaparazzo_2')
        Streamanim('mp_player_int_upperfinger')
        Streamanim('switch@trevor@jerking_off')
        local ped_anim = {p2, p3, p4, p5, p6, p7, p8}
        for _, Pedanim in ipairs(ped_anim) do
            if Pedhash == util.joaat('player_two') then
                Runanim(Pedanim, 'switch@trevor@jerking_off','trev_jerking_off_loop')
            else Runanim(Pedanim, 'mp_player_int_upperfinger', 'mp_player_int_finger_02_fp')
            end
    
            Runanim(p1, 'rcmpaparazzo_2', 'shag_loop_a')
    end
        local ped_tab = {p1, p2, p3, p4, p5, p6, p7, p8}
        for _, spawned_ped in ipairs(ped_tab) do
            table.insert(peds,  spawned_ped)
        end
    
    
    
    for _, Pedm in ipairs(peds) do
        PFP(Pedm, targets) --- ped facing player
    end
    
    
    cage_table[pid] = peds
    end --if not cage_table[pid] end
    
    while cage_table[pid] do
    IPM(targets, tar1, pname, cage_table, pid)
    
    
    end
    
    
    if not players.exists(pid) then
        
        util.toast('你让他们怒不可遏')
        util.stop_thread()
    
        cage_table[pid] = nil
    end
    end


    function freecageg(pid)
        if cage_table[pid] then
            DelEnt(cage_table[pid])
            menu.trigger_commands("PCAGE" .. PLAYER.GET_PLAYER_NAME(pid))
            cage_table[pid] = false
            else
                 if set.alert then
                    util.toast('未找到Ped笼子')
                 end
        end
    end



    local obj_table = {}
    function objsetcage(pid)
    local targets = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local tar1 = ENTITY.GET_ENTITY_COORDS(targets, true)
    local pname = PLAYER.GET_PLAYER_NAME(pid)

    if not obj_table[pid] then
        local objs = {}

        local spec = menu.get_value(menu.ref_by_rel_path(menu.player_root(pid), "Spectate>Ninja Method"))
        Delcar(targets, spec, pid)
        
local hsel = util.joaat(objset.mdl)
        Streament(hsel)
        local o1 = ObjSpawn(hsel, tar1)
        local o2 = ObjSpawn(hsel, tar1)
        local o3 = ObjSpawn(hsel, tar1)
        local o4 = ObjSpawn(hsel, tar1)
        local o5 = ObjSpawn(hsel, tar1)
        local o6 = ObjSpawn(hsel, tar1)
        local o7 = ObjSpawn(hsel, tar1)
        local o8 = ObjSpawn(hsel, tar1)

        SetObjCo(o1, tar1.x, tar1.y - 0.5, tar1.z - 1.0)
        SetObjCo(o2, tar1.x - 0.5, tar1.y - 0.5, tar1.z - 1.0)
        SetObjCo(o3, tar1.x - 0.5, tar1.y, tar1.z - 1.0)
        SetObjCo(o4, tar1.x - 0.5, tar1.y + 0.5, tar1.z - 1.0)
        SetObjCo(o5, tar1.x, tar1.y + 0.5, tar1.z - 1.0)
        SetObjCo(o6, tar1.x + 0.5, tar1.y + 0.5, tar1.z - 1.0)
        SetObjCo(o7, tar1.x + 0.5, tar1.y, tar1.z - 1.0)
        SetObjCo(o8, tar1.x + 0.5, tar1.y - 0.5, tar1.z - 1.0)

        ENTITY.SET_ENTITY_ROTATION(o1, 0, 0, 180, 1, true)
        ENTITY.SET_ENTITY_ROTATION(o2, 0, 0, 135, 1, true)
        ENTITY.SET_ENTITY_ROTATION(o3, 0, 0, 90, 1, true)
        ENTITY.SET_ENTITY_ROTATION(o4, 0, 0, 45, 1, true)
        ENTITY.SET_ENTITY_ROTATION(o6, 0, 0, 315, 1, true)
        ENTITY.SET_ENTITY_ROTATION(o7, 0, 0, 270, 1, true)
        ENTITY.SET_ENTITY_ROTATION(o8, 0, 0, 225, 1, true)

        local obj_tab = {o1, o2, o3, o4, o5, o6, o7, o8}

        for _, horn in ipairs(obj_tab) do
            AUDIO.PLAY_SOUND_FROM_ENTITY(-1, 'Alarm_Interior', horn, 'DLC_H3_FM_FIB_Raid_Sounds', 0, 0)
        end

        for _, spawned_obj in ipairs(obj_tab) do
            table.insert(objs,  spawned_obj)
        end

        obj_table[pid] = objs
    end
while obj_table[pid] do
    IPM(targets, tar1, set, pname, obj_table, pid)
end

if not players.exists(pid) then

    if set.alert then
        util.toast('你让他们怒不可遏')
    end
    util.stop_thread()

    obj_table[pid] = nil
end

 end


function freeobjsetcage(pid)
    if obj_table[pid] then
        DelEnt(obj_table[pid])
        menu.trigger_commands("ObjCage" .. PLAYER.GET_PLAYER_NAME(pid))
        Stopsound()
        obj_table[pid] = false
        else
            if set.alert then
                util.toast('未找到物体笼子')    
            end
    end
end

 
 


 

