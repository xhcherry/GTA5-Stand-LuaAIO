util.require_natives(1651208000)
require("lib.baibailib.somelang")
util.keep_running()
AIM_WHITELIST = {}

local getEntityCoords = ENTITY.GET_ENTITY_COORDS
local pvphelp = menu.list(menu.my_root(), KER_LANG_TABLE[45], {"pvphelp"}, "")

menu.divider(pvphelp, "Silent Aimbot")

Silent_Aimbot = {
    hitboxes = {
        head = {hash = 12844, toggled = false},
        spine = {hash = 24817, toggled = false},
        pelvis = {hash = 11816, toggled = false},
    },

    fov = 2,
    dist = 300,
    dmg = 100,

    los_check = true,
    fov_check = true,

    hash = 177293209, --heavy sniper mk2 hash
    advanced = {
        speed = -1
    }
}

menu.toggle_loop(pvphelp, "静默自瞄2.0", {}, "", function ()
    if PED.IS_PED_SHOOTING(GetLocalPed()) then --main start, checking.


        Silent_Aimbot.hash = WEAPON.GET_SELECTED_PED_WEAPON(GetLocalPed())
        local suitable = GetSuitableAimbotTarget(Silent_Aimbot.fov, Silent_Aimbot.fov_check,
            Silent_Aimbot.dist, Silent_Aimbot.los_check)

        if suitable ~= nil then
            local hitboxesCheckCount = 0
            for i, v in pairs(Silent_Aimbot.hitboxes) do
                if (v.toggled) then
                    ShootBulletAtPedBone(suitable, v.hash, Silent_Aimbot.dmg,
                        Silent_Aimbot.hash, Silent_Aimbot.advanced.speed)
                        if SE_Notifications then util.toast("Shot " .. i .. " of player " .. GetPlayerName_ped(suitable)) end
                        break;
                else
                    hitboxesCheckCount = hitboxesCheckCount + 1
                end
            end
            if (hitboxesCheckCount == 3) then --if all 3 are disabled
                util.toast("No hitboxes selected!")
            end
        end


    end
end)

local aimbot_settings = menu.list(pvphelp, "静默自瞄2.0设置", {}, "")
menu.divider(aimbot_settings, "---Settings---")
menu.slider(aimbot_settings, "伤害", {"saimdmg", "silentdamage"}, "伤害。 可能不准确。", 1, 10000, 100, 10, function (v) Silent_Aimbot.dmg = v end)
menu.slider(aimbot_settings, "范围", {"saimrange", "silentrange"}, "静默自瞄范围", 1, 10000, 300, 100, function (v) Silent_Aimbot.dist = v end)
menu.slider(aimbot_settings, "视野", {"saimfov", "silentfov"}, "静默自瞄视野", 1, 1000, 20, 1, function (v) Silent_Aimbot.fov = v/10 end)
menu.toggle(aimbot_settings, "视野检查", {}, "禁用视野检查。", function (toggle) Silent_Aimbot.fov_check = toggle end, true)
menu.toggle(aimbot_settings, "视线检查", {}, "禁用视线检查。", function (toggle) Silent_Aimbot.los_check = toggle end, true)
menu.divider(aimbot_settings, "---打击点---")
menu.toggle(aimbot_settings, "头", {"saimhead", "silenthead"}, "切换头部打击点。", function (toggle) Silent_Aimbot.hitboxes.head.toggled = toggle end)
menu.toggle(aimbot_settings, "脊柱/身体", {"saimspine", "saimbody", "silentbody"}, "切换身体打击点。", function (toggle) Silent_Aimbot.hitboxes.spine.toggled = toggle end)
menu.toggle(aimbot_settings, "骨盆", {"saimpelvis", "silentpelvis"}, "切换骨盆打击点。", function (toggle) Silent_Aimbot.hitboxes.pelvis.toggled = toggle end)
menu.divider(aimbot_settings, "---额外功能---")
menu.slider(aimbot_settings, "设定速度", {"silentspeed"}, "设置子弹的速度。 默认值为 -1。", -1, 2147483647, -1, 10, function (v) Silent_Aimbot.advanced.speed = v end)

--GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS --for shooting the kneecaps
--https://wiki.gtanet.work/index.php?title=Bones
--IK_Head 	12844
--SKEL_Spine2 	24817
--SKEL_Pelvis 	11816
--SKEL_R_Toe0 	20781
--IK_R_Hand 	6286

----------------------------------------------------------------------------------------------------

menu.divider(pvphelp, KER_LANG_TABLE[61])
--TYSM NOWIRY AND AARON!

VEH_MISSILE_SPEED = 10000

menu.toggle_loop(pvphelp, KER_LANG_TABLE[62], {}, "使直升机瞄准最近的玩家。 将其与“静默自瞄”结合使用，让您看起来超级棒 :)", function ()
    local p = GetClosestPlayerWithRange_Whitelist(200)
    local localped = GetLocalPed()
    local localcoords2 = getEntityCoords(localped)
    if p ~= nil and not PED.IS_PED_DEAD_OR_DYING(p) and ENTITY.HAS_ENTITY_CLEAR_LOS_TO_ENTITY(localped, p, 17) and not AIM_WHITELIST[NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(p)] and (not players.is_in_interior(NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(p))) and (not players.is_godmode(NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(p))) then
        if PED.IS_PED_IN_ANY_VEHICLE(localped) then
            local veh = PED.GET_VEHICLE_PED_IS_IN(localped, false)
            if VEHICLE.GET_VEHICLE_CLASS(veh) == 15 or VEHICLE.GET_VEHICLE_CLASS(veh) == 16 then --vehicle class of heli
                --did all prechecks, time to actually face them
                -- local pcoords = PED.GET_PED_BONE_COORDS(p, 24817, 0, 0, 0)
                -- local look = util.v3_look_at(localCoords, pcoords) --x = pitch (vertical), y = roll (fuck no), z = heading (horizontal)
                local pcoords2 = PED.GET_PED_BONE_COORDS(p, 24817, 0, 0, 0)
                local look2 = v3.lookAt(localcoords2, pcoords2)
                local look = GetTableFromV3Instance(look2)
                ENTITY.SET_ENTITY_ROTATION(veh, look.x, look.y, look.z, 1, true)
            end
        end
    end
end)

menu.action(pvphelp, KER_LANG_TABLE[63], {}, "", function ()
    local localped = GetLocalPed()
    if PED.IS_PED_IN_ANY_VEHICLE(localped) then
        local veh = PED.GET_VEHICLE_PED_IS_IN(localped, false)
        if VEHICLE.GET_VEHICLE_CLASS(veh) == 15 or VEHICLE.GET_VEHICLE_CLASS(veh) == 16 then --vehicle class of heli
            SetVehicleMissileSpeed(VEH_MISSILE_SPEED)
        end
    end
end)

menu.slider(pvphelp, KER_LANG_TABLE[64], {"vehmissilespeed"}, "设置导弹的速度。", 1, 2147483647, 10000, 100, function (value)
    VEH_MISSILE_SPEED = value
end)

----------------------------------------------------------------------------------------------------

menu.divider(pvphelp, KER_LANG_TABLE[65])

MISL_AIM = false
local missile_settings = {
    radius = 300,
    speed = 100,
    los = true,
    cam = false,
    ptfx = true,
    ptfx_scale = 1,
    air_target = false,
    multitarget = false,
    multiped = false
}
local missile_particles = {
    name = "exp_grd_rpg_lod",
    dictionary = "core"
}

--Later: block rockets (spawn walls when detecting they are in range)

ATTACH_CAM_TO_ENTITY_WITH_FIXED_DIRECTION = function (--[[Cam (int)]] cam, --[[Entity (int)]] entity, --[[float]] xRot, --[[float]] yRot, --[[float]] zRot, --[[float]] xOffset, --[[float]] yOffset, --[[float]] zOffset, --[[BOOL (bool)]] isRelative)
    native_invoker.begin_call()
    native_invoker.push_arg_int(cam)
    native_invoker.push_arg_int(entity)
    native_invoker.push_arg_float(xRot); native_invoker.push_arg_float(yRot); native_invoker.push_arg_float(zRot)
    native_invoker.push_arg_float(xOffset); native_invoker.push_arg_float(yOffset); native_invoker.push_arg_float(zOffset)
    native_invoker.push_arg_bool(isRelative)
    native_invoker.end_call("202A5ED9CE01D6E7")
end

--https://github.com/Sainan/gta-v-joaat-hash-db/blob/senpai/out/objects-hex.csv

Rocket_Hashes = {
    {"rpg", util.joaat("w_lr_rpg_rocket")},
    {"homingrpg", util.joaat("w_lr_homing_rocket")},
    {"oppressor2", util.joaat("w_ex_vehiclemissile_3")},
    {"b11barrage", util.joaat("w_smug_airmissile_01b")},
    {"b11regular", util.joaat("w_battle_airmissile_01")},
    {"chernobog", util.joaat("w_ex_vehiclemissile_4")},
    {"grenadelauncher", util.joaat("w_lr_40mm")}, --grenade launcher lmfao
    {"compactemplauncher", util.joaat("w_lr_ml_40mm")}, --compact emp launhcer lmao
    {"teargas", util.joaat("w_ex_grenadesmoke")} --tear gas grenade lmfao
}

Chosen_Rocket_Hash = Rocket_Hashes[1][2] --default is the regular RPG
MISSILE_ENTITY_TABLE = {}
menu.toggle(pvphelp, KER_LANG_TABLE[66], {"rpgaim"}, "更准确地说，火箭自瞄。 将与火箭设置列表中提供的火箭一起使用。 默认为 RPG。", function (on)
    if on then
        MISL_AIM = true
        while MISL_AIM do
            local localped = GetLocalPed()
            local localcoords = getEntityCoords(GetLocalPed())
            local forOffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(localped, 0, 5, 0)
            RRocket = OBJECT.GET_CLOSEST_OBJECT_OF_TYPE(forOffset.x, forOffset.y, forOffset.z, 10, Chosen_Rocket_Hash, false, true, true, true)
            local p
            if missile_settings.multitarget then
                if missile_settings.air_target then
                    p = GetClosestPlayerWithRange_Whitelist_DisallowEntities(missile_settings.radius, MISSILE_ENTITY_TABLE, true)
                else
                    p = GetClosestPlayerWithRange_Whitelist_DisallowEntities(missile_settings.radius, MISSILE_ENTITY_TABLE, false)
                end
            elseif missile_settings.multiped then
                if missile_settings.air_target then
                    p = GetClosestNonPlayerPedWithRange_DisallowedEntities(missile_settings.radius, MISSILE_ENTITY_TABLE, true)
                else
                    p = GetClosestNonPlayerPedWithRange_DisallowedEntities(missile_settings.radius, MISSILE_ENTITY_TABLE, false)
                end
            elseif not missile_settings.multitarget then
                if missile_settings.air_target then
                    p = GetClosestPlayerWithRange_Whitelist(missile_settings.radius, true)
                else
                    p = GetClosestPlayerWithRange_Whitelist(missile_settings.radius, false)
                end
            end
            local ppcoords = getEntityCoords(p)
            ----
            if (RRocket ~= 0) and (p ~= nil) and (not PED.IS_PED_DEAD_OR_DYING(p)) and (not AIM_WHITELIST[NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(p)]) and (PED.IS_PED_SHOOTING(localped)) and (not players.is_in_interior(NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(p))) and (ppcoords.z > 1) then
                util.create_thread(function ()
                    local plocalized = p
                    local msl = RRocket
                    if missile_settings.multitarget then
                        MISSILE_ENTITY_TABLE[#MISSILE_ENTITY_TABLE+1] = plocalized
                    end
                    if (ENTITY.HAS_ENTITY_CLEAR_LOS_TO_ENTITY(localped, plocalized, 17) and missile_settings.los) or not missile_settings.los or MISL_AIR then
                        if SE_Notifications then
                            util.toast("Precusors done!")
                        end
                        NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(msl)
                        if not NETWORK.NETWORK_HAS_CONTROL_OF_ENTITY(msl) then
                            for i = 1, 10 do
                                NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(msl)
                            end
                        else
                            if SE_Notifications then
                                util.toast("has control")
                            end
                        end
                        local aircount = 1
                        ----
                        Missile_Camera = 0

                        --preload the fake rocket and the particle fx
                        -- > -- Load the particleFX for the fakerocket so it networks to other players
                        STREAMING.REQUEST_NAMED_PTFX_ASSET(missile_particles.dictionary)
                        while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(missile_particles.dictionary) do
                            STREAMING.REQUEST_NAMED_PTFX_ASSET(missile_particles.dictionary)
                            wait()
                        end
                        GRAPHICS.USE_PARTICLE_FX_ASSET(missile_particles.dictionary)
                        -- > -- we now have loaded our PTFX for our fake rocket.
                        --GRAPHICS.START_PARTICLE_FX_NON_LOOPED_ON_ENTITY("exp_grd_rpg_lod", msl, 0, 0, 0, 0, 0, 0, 2, false, false, false)
                        --while the rocket exists, we do this vvvv
                        while ENTITY.DOES_ENTITY_EXIST(msl) do
                            if SE_Notifications then
                                util.toast("rocket exists")
                            end
                            -- NEW CODE W/O DEPRECATION:
                            --local pcoords2 = v3.new(PED.GET_PED_BONE_COORDS(plocalized, 20781, 0, 0, 0))
                            local pcoords2 = getEntityCoords(plocalized)
                            local pcoords = GetTableFromV3Instance(pcoords2)
                            local lc2 = getEntityCoords(msl)
                            local lc = GetTableFromV3Instance(lc2)
                            local look2 = v3.lookAt(lc2, pcoords2)
                            local look = GetTableFromV3Instance(look2)
                            local dir2 = v3.toDir(look2)
                            local dir = GetTableFromV3Instance(dir2)
                            --didn't wanna make new fuckin variables/replace old ones, so we're multiplying the code by 2 because fuck you.
                            -- // -- // --
                            -- // -- // --
                            if missile_settings.ptfx then
                                STREAMING.REQUEST_NAMED_PTFX_ASSET(missile_particles.dictionary)
                                while not STREAMING.HAS_NAMED_PTFX_ASSET_LOADED(missile_particles.dictionary) do
                                    STREAMING.REQUEST_NAMED_PTFX_ASSET(missile_particles.dictionary)
                                    wait()
                                end
                                GRAPHICS.USE_PARTICLE_FX_ASSET(missile_particles.dictionary)
                                -- > -- we now have loaded our PTFX for our fake rocket.
                                --(​const char* effectName, float xPos, float yPos, float zPos, float xRot, float yRot, float zRot, float scale, BOOL xAxis, BOOL yAxis, BOOL zAxis, BOOL p11)
                                GRAPHICS.START_NETWORKED_PARTICLE_FX_NON_LOOPED_AT_COORD(missile_particles.name, lc.x, lc.y, lc.z, 0, 0, 0, 0.4 * missile_settings.ptfx_scale, false, false, false, true)
                            end
                            -- // -- // --
                            -- // -- // --
                            --airstrike air
                            if aircount < 2 and MISL_AIR then
                                if ENTITY.DOES_ENTITY_EXIST(msl) then
                                    --thanks ren!
                                    ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(msl, 1, 0, 0, 2700, true, false, true, true)
                                    aircount = aircount + 1
                                    wait(1100)
                                end
                            end
                            local lookCountD = 0
                            if MISL_AIR then
                                if missile_settings.cam then
                                    if not CAM.DOES_CAM_EXIST(Missile_Camera) then
                                        if SE_Notifications then
                                            util.toast("camera setup")
                                        end
                                        CAM.DESTROY_ALL_CAMS(true)
                                        Missile_Camera = CAM.CREATE_CAM("DEFAULT_SCRIPTED_CAMERA", true)
                                        --ATTACH_CAM_TO_ENTITY_WITH_FIXED_DIRECTION(Missile_Camera, msl, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1)
                                        CAM.SET_CAM_ACTIVE(Missile_Camera, true)
                                        CAM.RENDER_SCRIPT_CAMS(true, false, 0, true, true, 0)
                                    end
                                end
                                local distx = math.abs(lc.x - pcoords.x)
                                local disty = math.abs(lc.y - pcoords.y)
                                local distz = math.abs(lc.z - pcoords.z)
                                if missile_settings.cam then
                                    local ddisst = SYSTEM.VDIST(pcoords.x, pcoords.y, pcoords.z, lc.x, lc.y, lc.z)
                                    if ddisst > 50 then
                                        local camcoordv3 = CAM.GET_CAM_COORD(Missile_Camera)
                                        local look3 = v3.lookAt(camcoordv3, lc2)
                                        local look4 = GetTableFromV3Instance(look3)
                                        --local look2 = util.v3_look_at(CAM.GET_CAM_COORD(Missile_Camera), lc)
                                        --local backoffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(p, 0, -30, 10)
                                        local backoffset = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(msl, 10, 10, -2)
                                        CAM.SET_CAM_COORD(Missile_Camera, backoffset.x, backoffset.y, backoffset.z)
                                        if lookCountD < 1 then
                                            CAM.SET_CAM_ROT(Missile_Camera, look4.x, look4.y, look4.z, 2)
                                            lookCountD = lookCountD + 1
                                        end
                                    else
                                        local camcoordv3 = CAM.GET_CAM_COORD(Missile_Camera)
                                        local look3 = v3.lookAt(camcoordv3, lc2)
                                        local look4 = GetTableFromV3Instance(look3)
                                        CAM.SET_CAM_ROT(Missile_Camera, look4.x, look4.y, look4.z, 2)
                                    end
                                end
                                --CAM.SET_CAM_PARAMS(Missile_Camera, lc.x, lc.y, lc.z + 1, look.x, look.y, look.z, 100, 0, 0, 0, 0) --(​Cam cam, float posX, float posY, float posZ, float rotX, float rotY, float rotZ, float fieldOfView, Any p8, int p9, int p10, int p11)
                                ENTITY.SET_ENTITY_ROTATION(msl, look.x, look.y, look.z, 2, true)
                                ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(msl, 1, dir.x * missile_settings.speed * distx, dir.y * missile_settings.speed * disty, dir.z * missile_settings.speed * distz, true, false, true, true)
                                wait()
                            else
                                -- vanilla "aimbot"
                                ENTITY.SET_ENTITY_ROTATION(msl, look.x, look.y, look.z, 2, true)
                                ENTITY.APPLY_FORCE_TO_ENTITY_CENTER_OF_MASS(msl, 1, dir.x * missile_settings.speed, dir.y * missile_settings.speed, dir.z * missile_settings.speed, true, false, true, true)
                                wait()
                            end
                            --free all our v3 instances
                        end

                        --rocket has stopped existing
                        if missile_settings.cam then
                            wait(2000)
                            if SE_Notifications then
                                util.toast("cam remove")
                            end
                            CAM.RENDER_SCRIPT_CAMS(false, false, 0, true, true, 0)
                            if CAM.IS_CAM_ACTIVE(Missile_Camera) then
                                CAM.SET_CAM_ACTIVE(Missile_Camera, false)
                            end
                            CAM.DESTROY_CAM(Missile_Camera, true)
                        end
                    end
                    --improve this logic lmfao
                    if missile_settings.multitarget then
                        table.remove(MISSILE_ENTITY_TABLE, GetValueIndexFromTable(MISSILE_ENTITY_TABLE, plocalized))
                        util.toast("Removed value " .. tostring(plocalized) .. " at index " .. tostring(GetValueIndexFromTable(MISSILE_ENTITY_TABLE, p)))
                    end
                end)
            end
            wait()
        end
    else
        MISL_AIM = false
    end
end)

MISL_AIR = false

local rpgrockets = menu.list(pvphelp, "火箭炮类型设置", {}, "")

local function generateRockets()
for i = 1, #Rocket_Hashes do
    menu.action(rpgrockets, "Rocket " .. Rocket_Hashes[i][1], {"rocket " .. Rocket_Hashes[i][1]}, "", function ()
        Chosen_Rocket_Hash = Rocket_Hashes[i][2]
        util.toast("Set chosen rocket to " .. Rocket_Hashes[i][1] .. " || " .. Rocket_Hashes[i][2])
    end)
end
end
generateRockets()

local rpgsettings = menu.list(pvphelp, KER_LANG_TABLE[67], {"rpgsettings"}, "")

menu.toggle(rpgsettings, KER_LANG_TABLE[68], {"rpgjavelin"}, "让火箭飞得很高，杀死离你最近的玩家 :) | 建议：结合“RPG LOS Remove”，向你看不到的目标开火。", function (on)
    if on then
        MISL_AIR = true
    else
        MISL_AIR = false
    end
end)

menu.slider(rpgsettings, KER_LANG_TABLE[69], {"msl_frc_rad"}, "导弹自瞄的射程，例如 人可以离开多远。", 1, 10000, 300, 10, function (value)
    missile_settings.radius = value
end)

menu.slider(rpgsettings, KER_LANG_TABLE[70], {"msl_spd_mult"}, "速度乘数。 默认是100，很好。", 1, 10000, 100, 10, function (value)
    missile_settings.speed = value
end)

menu.toggle(rpgsettings, KER_LANG_TABLE[71], {}, "删除视线检查。 除非您知道自己在做什么，否则不要打开它。", function (on)
    missile_settings.los = not on
end)

menu.toggle(rpgsettings, KER_LANG_TABLE[72], {"rpgcamera"}, "现在有了行车记录仪，如果你使用标枪模式，你终于可以知道你的火箭到底去哪儿了。", function (on)
    missile_settings.cam = on
end)

menu.toggle(rpgsettings, "启用 PTFX", {}, "启用导弹的粒子效果，使它们看起来更合法。 默认启用。", function (toggle)
    missile_settings.ptfx = toggle
end, true)

menu.toggle(rpgsettings, "只针对空中目标", {}, "使自瞄只瞄准那些在空中的人。", function (toggle)
    missile_settings.air_target = toggle
end)

menu.toggle(rpgsettings, "多目标", {}, "将使导弹瞄准不同的实体。 如果一枚导弹已经飞向一个实体，其他导弹将飞向其他实体。 对多人有用。", function (toggle)
    missile_settings.multitarget = toggle
end)

menu.toggle(rpgsettings, "目标 Peds（多目标）", {}, "将针对peds而不是玩家。 在这个上启用了多目标，因为如果不是这样就没有用。", function (toggle)
    missile_settings.multiped = toggle
end)

menu.divider(rpgsettings, "------- PTFX（高级） -------")

menu.slider(rpgsettings, "PTFX 比例", {"rpgparscale"}, "粒子效果的比例。", 1, 10, 1, 1, function (scale)
    missile_settings.ptfx_scale = scale
end)

menu.text_input(rpgsettings, "PTFX 名称", {"rpgptfx"}, "粒子效果名称。 仅限高级用户。", function (text)
    missile_particles.name = text
end, "exp_grd_rpg_lod")

menu.text_input(rpgsettings, "PTFX 字典", {"rpgdictionary"}, "使用 PTFX 的粒子效果字典。 仅限高级！！", function (text)
    missile_particles.dictionary = text
end, "core")

----------------------------------------------------------------------------------------------------

menu.divider(pvphelp, KER_LANG_TABLE[73])

--preload
ORB_Sneaky = false

menu.action(pvphelp, KER_LANG_TABLE[74], {"orbway", "orbwp"}, "轨道炮您选择的航点。", function ()
    local wpos = Get_Waypoint_Pos2()
    if SE_Notifications then
        util.toast("Selected Waypoint Coordinates: " .. wpos.x .. " " .. wpos.y .. " " .. wpos.z)
    end
    if ORB_Sneaky then
        for a = 1, 30 do
            SE_add_explosion(wpos.x, wpos.y, wpos.z + 30 - a, 29, 10, true, false, 1, false)
            SE_add_explosion(wpos.x, wpos.y, wpos.z + 30 - a, 59, 10, true, false, 1, false)
            wait(30)
        end
    else
        for i = 1, 30 do
            SE_add_owned_explosion(GetLocalPed(), wpos.x, wpos.y, wpos.z + 30 - i, 29, 10, true, false, 1)
            SE_add_owned_explosion(GetLocalPed(), wpos.x, wpos.y, wpos.z + 30 - i, 59, 10, true, false, 1)
            wait(30)
        end
    end
end)

menu.toggle(pvphelp, KER_LANG_TABLE[75], {}, "使轨道不归咎于你。", function (on)
    ORB_Sneaky = on
end)

----------------------------------------------------------------------------------------------------

menu.divider(pvphelp, KER_LANG_TABLE[76])

--preload
CAR_S_sneaky = false
CAR_S_BLACKLIST = {}

menu.toggle_loop(pvphelp, KER_LANG_TABLE[77], {"carexplode"}, "当您在玩家旁边时自动引爆您的汽车。", function()
    local ourped = GetLocalPed()
    if PED.IS_PED_IN_ANY_VEHICLE(ourped, false) then
        local pedTable = entities.get_all_peds_as_pointers()
        local ourCoords = getEntityCoords(ourped)
        for i = 1, #pedTable do
            local handle = entities.pointer_to_handle(pedTable[i])
            if PED.IS_PED_A_PLAYER(handle) then
                local playerID = NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(handle)
                local v3 = entities.get_position(pedTable[i])
                local dist = DistanceBetweenTwoCoords(ourCoords, v3)
                if dist < 5 and handle ~= GetLocalPed() and not CAR_S_BLACKLIST[playerID] then
                    if CAR_S_sneaky then
                        SE_add_explosion(ourCoords.x, ourCoords.y, ourCoords.z, 2, 10, true, false, 0.1, false)
                        SE_add_explosion(ourCoords.x - 4, ourCoords.y, ourCoords.z, 2, 20, false, true, 0.1, false)
                        SE_add_explosion(ourCoords.x + 4, ourCoords.y, ourCoords.z, 2, 20, false, true, 0.1, false)
                        SE_add_explosion(ourCoords.x, ourCoords.y - 4, ourCoords.z, 2, 20, false, true, 0.1, false)
                        SE_add_explosion(ourCoords.x, ourCoords.y + 4, ourCoords.z, 2, 20, false, true, 0.1, false)
                    else
                        SE_add_owned_explosion(ourped, ourCoords.x, ourCoords.y, ourCoords.z, 2, 10, true, false, 0.1)
                        SE_add_owned_explosion(ourped, ourCoords.x - 4, ourCoords.y, ourCoords.z, 2, 20, false, true, 0.1)
                        SE_add_owned_explosion(ourped, ourCoords.x + 4, ourCoords.y, ourCoords.z, 2, 20, false, true, 0.1)
                        SE_add_owned_explosion(ourped, ourCoords.x, ourCoords.y - 4, ourCoords.z, 2, 20, false, true, 0.1)
                        SE_add_owned_explosion(ourped, ourCoords.x, ourCoords.y + 4, ourCoords.z, 2, 20, false, true, 0.1)
                    end
                end
            end
        end
    end
end)

menu.toggle(pvphelp, KER_LANG_TABLE[78], {"carexplodesneaky"}, "使汽车炸弹的爆炸不怪你。", function(on)
    CAR_S_sneaky = on
end)

----------------------------------------------------------------------------------------------------

menu.divider(pvphelp, KER_LANG_TABLE[79])

LegitRapidFire = false
LegitRapidMS = 100

menu.toggle(pvphelp, KER_LANG_TABLE[80], {"legitrapidfire"}, "射击后快速切换到手榴弹并返回武器。 对狙击手、角色扮演游戏、榴弹发射器很有用。", function(on)
    local localped = GetLocalPed()
    if on then
        LegitRapidFire = true
        util.create_thread(function ()
            while LegitRapidFire do
                if PED.IS_PED_SHOOTING(localped) then
                    local currentWpMem = memory.alloc()
                    local junk = WEAPON.GET_CURRENT_PED_WEAPON(localped, currentWpMem, 1)
                    local currentWP = memory.read_int(currentWpMem)
                    memory.free(currentWpMem)
                    WEAPON.SET_CURRENT_PED_WEAPON(localped, 2481070269, true) --2481070269 is grenade
                    wait(LegitRapidMS)
                    WEAPON.SET_CURRENT_PED_WEAPON(localped, currentWP, true)
                end
                wait()
            end
            util.stop_thread()
        end)
    else
        LegitRapidFire = false
    end
end)

menu.slider(pvphelp, KER_LANG_TABLE[81], {"legitrapiddelay"}, "切换到手榴弹并返回武器所需的延迟。", 1, 1000, 100, 50, function (value)
    LegitRapidMS = value
end)