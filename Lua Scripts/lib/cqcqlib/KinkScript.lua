util.require_natives("1660775568")
resources_dir = filesystem.resources_dir() .. '/kinkscript/'
if not filesystem.is_dir(resources_dir) then
    util.toast("ALERT: resources dir is missing! Please make sure you installed KinkScript properly.")
end

logo = directx.create_texture(resources_dir .. 'logo.png')

function request_model_load(hash)
    request_time = os.time()
    if not STREAMING.IS_MODEL_VALID(hash) then
        return
    end
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do
        if os.time() - request_time >= 10 then
            break
        end
        util.yield()
    end
end


all_female_sex_voicenames = {
    "S_F_Y_HOOKER_01_WHITE_FULL_01",
    "S_F_Y_HOOKER_01_WHITE_FULL_02",
    "S_F_Y_HOOKER_01_WHITE_FULL_03",
    "S_F_Y_HOOKER_02_WHITE_FULL_01",
    "S_F_Y_HOOKER_02_WHITE_FULL_02",
    "S_F_Y_HOOKER_02_WHITE_FULL_03",
    "S_F_Y_HOOKER_03_BLACK_FULL_01",
    "S_F_Y_HOOKER_03_BLACK_FULL_03",
}

local female_speeches = {
    "SEX_GENERIC_FEM",
    "SEX_HJ",
    "SEX_ORAL_FEM",
    "SEX_CLIMAX",
    "SEX_GENERIC"
}

function moan(pos, gender)
    util.create_thread(function()
        local hash = util.joaat('s_f_y_hooker_01')
        request_model_load(hash)
        local new_ped = entities.create_ped(28, hash, pos, 0)
        ENTITY.SET_ENTITY_VISIBLE(new_ped, false, 0)
        ENTITY.SET_ENTITY_INVINCIBLE(new_ped, true)
        local voice_name
        local speech_nam
        if gender == 'f' then
            voice_name = all_female_sex_voicenames[math.random(#all_female_sex_voicenames)]
            speech_name = female_speeches[math.random(#female_speeches)]
        else
            voice_name = "MICHAEL_NORMAL"
            speech_name = "SEX_GENERIC"
        end
        AUDIO.PLAY_PED_AMBIENT_SPEECH_WITH_VOICE_NATIVE(new_ped, speech_name, voice_name, "SPEECH_PARAMS_FORCE", 0)
        local st_time = os.time()
        while true do 
            if os.time() - st_time >= 5 then 
                entities.delete(new_ped)
                util.stop_thread()
            end
            local c = players.get_position(players.user())
            ENTITY.SET_ENTITY_COORDS(new_ped, c.x, c.y, c.z+3, false, false, false, false)
            util.yield()
        end
    end)
end

if SCRIPT_MANUAL_START then
    moan(players.get_position(players.user()), 'f')
    logo_alpha = 0
    logo_alpha_incr = 0.01
    logo_alpha_thread = util.create_thread(function (thr)
        while true do
            logo_alpha = logo_alpha + logo_alpha_incr
            if logo_alpha > 1 then
                logo_alpha = 1
            elseif logo_alpha < 0 then 
                logo_alpha = 0
                util.stop_thread()
            end
            util.yield()
        end
    end)

    logo_thread = util.create_thread(function (thr)
        starttime = os.clock()
        local alpha = 0
        while true do
            directx.draw_texture(logo, 0.14, 0.14, 0.5, 0.5, 0.5, 0.5, 0, 1, 1, 1, logo_alpha)
            timepassed = os.clock() - starttime
            if timepassed > 3 then
                logo_alpha_incr = -0.01
            end
            if logo_alpha == 0 then
                util.stop_thread()
            end
            util.yield()
        end
    end)
end

function request_ptfx_asset(asset)
    local request_time = os.time()
    STREAMING.REQUEST_NAMED_PTFX_ASSET(asset)
    while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(asset) do
        if os.time() - request_time >= 10 then
            break
        end
        util.yield()
    end
end



attire_root = menu.list(KinkScript, "服装选项", {"sexluaattire"}, "")


escort_root = menu.list(KinkScript, "护送服务", {"sexluaescorts"}, "")

local custom_hooker_model = 'ig_lestercrest'
menu.text_input(escort_root, "定制护送模型", {"customescortmdl"}, "输入型号，然后前往请求护送>定制.", function(on_input)
    custom_hooker_model = on_input
end, 'ig_lestercrest')

local custom_hooker_options = {"我的克隆", "特雷西", "佩奇", "酒保", "袒胸女孩", "妹子嘿嘿嘿", "风俗"}
menu.list_action(escort_root, "请求护送", {"requestescort"}, "Request the most high-end escorts in Los Santos", custom_hooker_options, function(index)
    local hooker
    local c
    pluto_switch index do
        case 1:
            hooker = PED.CLONE_PED(players.user_ped(), true, true, true)
            break
        case 2:
            c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), -5.0, 0.0, 0.0)
            request_model_load(util.joaat('cs_tracydisanto'))
            hooker = entities.create_ped(28, util.joaat('cs_tracydisanto'), c, math.random(270))
            break
        case 3:
            c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), -5.0, 0.0, 0.0)
            request_model_load(util.joaat('ig_paige'))
            hooker = entities.create_ped(28, util.joaat('ig_paige'), c, math.random(270))
            break
        case 4:
            c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), -5.0, 0.0, 0.0)
            request_model_load(util.joaat('s_f_y_bartender_01'))
            hooker = entities.create_ped(28, util.joaat('s_f_y_bartender_01'), c, math.random(270))
            break
        case 5:
            c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), -5.0, 0.0, 0.0)
            request_model_load(util.joaat('a_f_y_topless_01'))
            hooker = entities.create_ped(28, util.joaat('a_f_y_topless_01'), c, math.random(270))
            break
        case 6:
            c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), -5.0, 0.0, 0.0)
            request_model_load(util.joaat('u_m_y_staggrm_01'))
            hooker = entities.create_ped(28, util.joaat('u_m_y_staggrm_01'), c, math.random(270))
            break
        case 7:
            c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), -5.0, 0.0, 0.0)
            request_model_load(util.joaat(custom_hooker_model))
            hooker = entities.create_ped(28, util.joaat(custom_hooker_model), c, math.random(270))
            break
    end
    local c = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(players.user_ped(), -5.0, 0.0, 0.0)
    ENTITY.SET_ENTITY_COORDS(hooker, c.x, c.y, c.z)
    TASK.TASK_START_SCENARIO_IN_PLACE(hooker, "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS", 0, false)
    util.toast("Your escort has arrived to your left.")
end)

locations_root = menu.list(KinkScript, "位置", {"sexlualocations"}, "")
music_root = menu.list(KinkScript, "音乐", {"sexluamusic"}, "")
anims_root = menu.list(KinkScript, "动画", {"sexluaanims"}, "")
moans_root = menu.list(KinkScript, "呻吟", {"sexluamoans"}, "")


menu.action(anims_root, "停止所有动画", {"sexstopanims"}, "", function(on_click)
    TASK.CLEAR_PED_TASKS_IMMEDIATELY(PLAYER.PLAYER_PED_ID())
end)

dances_root = menu.list(anims_root, "膝上舞蹈", {"sexanimslapdance"}, "")
pole_root = menu.list(anims_root, "钢管舞", {"sexanimspoledance"}, "")
anims_vroot = menu.list(anims_root, "交通工具", {"sexanimsveh"}, "")
anims_vroot_receiver = menu.list(anims_vroot, "接受者", {"sexanimsvehreceiver"}, "")
anims_vroot_giver = menu.list(anims_vroot, "给予者", {"sexanimsvehgiver"}, "")

anims_nroot = menu.list(anims_root, "典型的", {"sexanimsnormal"}, "")
anims_nroot_self = menu.list(anims_nroot, "自己", {"sexanimsnormalself"}, "")
anims_nroot_receiver = menu.list(anims_nroot, "接受者", {"sexanimsnormalreceiver"}, "")
anims_nroot_giver = menu.list(anims_nroot, "给予者", {"sexanimsnormalgiver"}, "")

function play_anim(dict, name, duration)
    ped = PLAYER.PLAYER_PED_ID()
    while not STREAMING.HAS_ANIM_DICT_LOADED(dict) do
        STREAMING.REQUEST_ANIM_DICT(dict)
        util.yield()
    end
    TASK.TASK_PLAY_ANIM(ped, dict, name, 1.0, 1.0, duration, 3, 0.5, false, false, false)
    --TASK_PLAY_ANIM(Ped ped, char* animDictionary, char* animationName, float blendInSpeed, float blendOutSpeed, int duration, int flag, float playbackRate, BOOL lockX, BOOL lockY, BOOL lockZ)
end
function request_model_load(hash)
    request_time = os.time()
    if not STREAMING.IS_MODEL_VALID(hash) then
        return
    end
    STREAMING.REQUEST_MODEL(hash)
    while not STREAMING.HAS_MODEL_LOADED(hash) do
        if os.time() - request_time >= 10 then
            break
        end
        util.yield()
    end
end

function attachto(offx, offy, offz, pid, angx, angy, angz, hash, bone, isnpc, isveh)
    local ped = PLAYER.GET_PLAYER_PED_SCRIPT_INDEX(pid)
    local bone = PED.GET_PED_BONE_INDEX(ped, bone)
    local coords = ENTITY.GET_ENTITY_COORDS(ped, true)
    coords.x = coords['x']
    coords.y = coords['y']
    coords.z = coords['z']
    if isnpc then
        obj = entities.create_ped(1, hash, coords, 90.0)
    elseif isveh then
        obj = entities.create_vehicle(hash, coords, 90.0)
    else
        obj = OBJECT.CREATE_OBJECT_NO_OFFSET(hash, coords['x'], coords['y'], coords['z'], true, false, false)
    end
    ENTITY.SET_ENTITY_INVINCIBLE(obj, true)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(obj, ped, bone, offx, offy, offz, angx, angy, angz, false, false, true, false, 0, true)
    ENTITY.SET_ENTITY_COMPLETELY_DISABLE_COLLISION(obj, false, true)
end

menu.action(moans_root, "女性呻吟", {"sexmoanfsex"}, "", function(on_click)
    moan(players.get_position(players.user()), 'f')
end)

menu.action(moans_root, "男性呻吟", {"sexmoanfsex"}, "", function(on_click)
    moan(players.get_position(players.user()), 'm')
end)

menu.action(attire_root, "无上装女性", {"sextoplessf"}, "", function(on_click)
    menu.trigger_commands("toplessfemale")
end)

menu.action(attire_root, "特雷西", {"sextracy"}, "", function(on_click)
    menu.trigger_commands("igtracydisanto")
end)

menu.action(attire_root, "Penis伙计", {"penisguy"}, "", function(on_click)
    menu.trigger_commands("amyacult01")
end)


menu.action(attire_root, "系上皮带", {"sexstrapon"}, "", function(on_click)
    request_model_load(-422877666)
    attachto(0.15, 0.15, 0.0, players.user(), -90.0, 0.0, 0.0, -422877666, 11816, false, false)
end)

menu.action(locations_root, "汽车旅馆房间", {"sexinmotel"}, "", function(on_click)																
    menu.trigger_commands("tpmotelroom")
end)

menu.action(locations_root, "巴哈马乳房", {"sexinbahamasmamas"}, "", function(on_click)
    menu.trigger_commands("tpbahamamamas")
end)

menu.action(locations_root, "酷刑室", {"sexintorturerooms"}, "", function(on_click)
    menu.trigger_commands("tptortureroom")
end)

menu.action(locations_root, "电影院", {"sexincinema"}, "", function(on_click)
    menu.trigger_commands("tpcinema")
end)


menu.action(locations_root, "弗洛伊德的房子", {"sexinfloydhouse"}, "", function(on_click)
    menu.trigger_commands("tpfloyd")
end)


menu.action(dances_root, "拉普丹斯1", {"sexanimlapdance1"}, "", function(on_click)
    play_anim("mini@strip_club@private_dance@part1", "priv_dance_p1", -1)
end)

menu.action(dances_root, "拉普丹斯2", {"sexanimlapdance1"}, "", function(on_click)
    play_anim("mini@strip_club@private_dance@part2", "priv_dance_p2", -1)
end)

menu.action(dances_root, "拉普丹斯3", {"sexanimlapdance1"}, "", function(on_click)
    play_anim("mini@strip_club@private_dance@part3", "priv_dance_p3", -1)
end)

menu.action(pole_root, "钢管舞1", {"sexanimpoledance1"}, "", function(on_click)
    play_anim("mini@strip_club@pole_dance@pole_a_2_stage", "pole_a_2_stage", -1)
end)

menu.action(pole_root, "钢管舞2", {"sexanimpoledance2"}, "", function(on_click)
    play_anim("mini@strip_club@pole_dance@pole_b_2_stage", "pole_b_2_stage", -1)
end)


menu.action(pole_root, "钢管舞3", {"sexanimpoledance3"}, "", function(on_click)
    play_anim("mini@strip_club@pole_dance@pole_c_2_prvd_a", "pole_c_2_prvd_a", -1)
end)


menu.action(pole_root, "钢管舞4", {"sexanimpoledance4"}, "", function(on_click)
    play_anim("mini@strip_club@pole_dance@pole_c_2_prvd_b", "pole_c_2_prvd_b", -1)
end)

menu.action(pole_root, "钢管舞5", {"sexanimpoledance5"}, "", function(on_click)
    play_anim("mini@strip_club@pole_dance@pole_c_2_prvd_c", "pole_c_2_prvd_c", -1)
end)


menu.action(pole_root, "钢管舞6", {"sexanimpoledance6"}, "", function(on_click)
    play_anim("mini@strip_club@pole_dance@pole_c_2_stage", "pole_c_2_stage", -1)
end)


menu.action(pole_root, "钢管舞7", {"sexanimpoledance7"}, "", function(on_click)
    play_anim("mini@strip_club@pole_dance@pole_dance1", "pd_dance_01", -1)
end)

menu.action(pole_root, "钢管舞8", {"sexanimpoledance8"}, "", function(on_click)
    play_anim("mini@strip_club@pole_dance@pole_dance2", "pd_dance_02", -1)
end)

menu.action(pole_root, "撸管舞9", {"sexanimpoledance9"}, "", function(on_click)
    play_anim("mini@strip_club@pole_dance@pole_dance3", "pd_dance_03", -1)
end)





menu.action(anims_vroot_receiver, "汽车吹扫", {"sexanimcarblowjobr"}, "", function(on_click)
    play_anim("mini@prostitutes@sexlow_veh", "low_car_bj_loop_player", -1)
end)

menu.action(anims_vroot_giver, "汽车吹扫", {"sexanimcarblowjobg"}, "", function(on_click)
    play_anim("mini@prostitutes@sexlow_veh", "low_car_bj_loop_female", -1)
end)

menu.action(anims_vroot_receiver, "汽车性爱", {"sexanimcarsexr"}, "", function(on_click)
    play_anim("mini@prostitutes@sexlow_veh", "low_car_sex_loop_player", -1)
end)

menu.action(anims_vroot_giver, "汽车性爱", {"sexanimcarsexg"}, "", function(on_click)
    play_anim("mini@prostitutes@sexlow_veh", "low_car_sex_loop_female", -1)
end)

menu.action(anims_nroot_self, "打管子", {"sexanimmasturbation"}, "", function(on_click)
    play_anim("switch@trevor@jerking_off", "trev_jerking_off_loop", -1)
end)

menu.action(anims_nroot_giver, "肛门", {"sexanimnanalg"}, "", function(on_click)
    play_anim("rcmpaparazzo_2", "shag_loop_a", -1)
end)

menu.action(anims_nroot_receiver, "肛门", {"sexanimnanalr"}, "", function(on_click)
    play_anim("rcmpaparazzo_2", "shag_loop_poppy", -1)
end)


menu.hyperlink(music_root, "Rezz-甜蜜梦想", "https://www.youtube.com/watch?v=vQloPg7_cfI", "")
menu.hyperlink(music_root, "Ghost Data - Melody项目", "https://www.youtube.com/watch?v=mqoEplBvXkI", "")
menu.hyperlink(music_root, "Ghost Data - 全身式", "https://www.youtube.com/watch?v=yahcmltC3ZA", "")
menu.hyperlink(music_root, "One True God - 上瘾的", "https://youtu.be/dfwofTtASo4", "")
menu.hyperlink(music_root, "The Weeknd - 星闻人物", "https://www.youtube.com/watch?v=34Na4j8AVgA", "")
menu.hyperlink(music_root, "The Weeknd - 无情", "https://www.youtube.com/watch?v=1DpH-icPpl0", "")
menu.hyperlink(music_root, "One True God - 淡漠", "https://www.youtube.com/watch?v=8zik3_lBH8g", "")
menu.hyperlink(music_root, "福特商业音乐", "https://youtu.be/bpOSxM0rNPM", "")
menu.hyperlink(music_root, "Tank - 和我做爱", "https://www.youtube.com/watch?v=HCEdRI5smm4", "")
menu.hyperlink(music_root, "Ty Dolla $ign - 喊不", "https://www.youtube.com/watch?v=Xx8EC34j3yE", "")
menu.hyperlink(music_root, "胡闹", "https://youtu.be/zZMg9ryeWOw", "")

while true do
    util.yield()
end