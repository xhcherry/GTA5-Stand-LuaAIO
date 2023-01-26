
util.require_natives(1651208000)
require("lib.baibailib.pvpandotherlib")
require("lib.baibailib.somelang")
util.keep_running()

CCAM = 0
STP_SPEED_MODIFIER = 0.02
STP_COORD_HEIGHT = 300

local getEntityCoords = ENTITY.GET_ENTITY_COORDS

local function onStartup()
    SE_LocalPed = GetLocalPed()
end

onStartup()


local toolFeats = menu.list(menu.my_root(), "拓展选项", {}, "", function(); end)

FRAME_STP = false

menu.action(toolFeats, KER_LANG_TABLE[84], {"stp"}, "在相机平稳的情况下将您传送到您的航点。", function ()
    SmoothTeleportToCord(Get_Waypoint_Pos2(), FRAME_STP)
end)

menu.toggle(toolFeats, KER_LANG_TABLE[85], {"stpv2"}, "使您或您的车辆与相机一起传送，以实现“更顺畅”的传送。", function(toggle)
    FRAME_STP = toggle
end)

menu.action(toolFeats, KER_LANG_TABLE[86], {"resetstp"}, "将脚本 cam 渲染为 false，同时销毁当前 cam。 因为如果你传送到海里，然后相机就死了。", function ()
    local renderingCam = CAM.GET_RENDERING_CAM()
    CAM.RENDER_SCRIPT_CAMS(false, false, 0, true, true, 0)
    CAM.DESTROY_CAM(renderingCam, true)
end)

local stpsettings = menu.list(toolFeats, KER_LANG_TABLE[87], {}, "")

menu.slider(stpsettings, KER_LANG_TABLE[88], {"stpspeed"}, "用于平滑 tp 的速度修改器，乘法。 这将除以 10，因为滑块不能采用非整数", 1, 100, 10, 1, function(value)
    local multiply = value / 10
    if SE_Notifications then
        util.toast("SmoothTP 速度倍增器设置为 " .. tostring(multiply) .. "!")
    end
    STP_SPEED_MODIFIER = 0.02 --set it again so it doesnt multiply over and over. This took too long to figure out....
    STP_SPEED_MODIFIER = STP_SPEED_MODIFIER * multiply
end)

menu.slider(stpsettings, KER_LANG_TABLE[89], {"stpheight"}, "在进行过渡时设置相机的高度。", 0, 10000, 300, 10, function (value)
    local height = value
    if SE_Notifications then
        util.toast("SmoothTP 高度设置为 " .. tostring(height) .. "!")
    end
    STP_COORD_HEIGHT = height
end)

menu.divider(toolFeats, "-=-=-=-绘制-=-=-=-")

--

--preload
DR_TXT_SCALE = 0.5


menu.toggle_loop(toolFeats, KER_LANG_TABLE[90], {"drawpos"},  "", function ()
    local pos = getEntityCoords(GetLocalPed())
    local cc = {r = 1.0, g = 1.0, b = 1.0, a = 1.0}
    directx.draw_text(0.0, 0.0, "x: " .. pos.x .. " // y: " .. pos.y .. " // z: " .. pos.z, ALIGN_TOP_LEFT, DR_TXT_SCALE, cc, false)
end)

menu.toggle_loop(toolFeats, "绘制旋转", {"drawrot"}, "", function ()
    local rot = ENTITY.GET_ENTITY_ROTATION(GetLocalPed(), 2)
    local cc = {r = 1.0, g = 1.0, b = 1.0, a = 1.0}
    directx.draw_text(0.5, 0.03, "pitch: " .. rot.x .. " // roll: " .. rot.y .. " // yaw: " .. rot.z, ALIGN_CENTRE, DR_TXT_SCALE, cc, false)
    local facingtowards
    if ((rot.z >= 135) or (rot.z < -135)) then facingtowards = "-Y"
    elseif ((rot.z < 135) and (rot.z >= 45)) then facingtowards = "-X"
    elseif ((rot.z >= -135) and (rot.z < -45)) then facingtowards = "+X"
    elseif ((rot.z >= -45) or (rot.z < 45)) then facingtowards = "+Y" end
    directx.draw_text(0.5, 0.07, "Facing towards " .. facingtowards, ALIGN_CENTRE, DR_TXT_SCALE, cc, false)
end)

--preload
EP_drawveh = true
EP_drawped = true
EP_drawobj = true
EP_drawpick = true
----
EPS_vehx = 0.0
EPS_vehy = 0.03
--
EPS_pedx = 0.0
EPS_pedy = 0.05
--
EPS_objx = 0.0
EPS_objy = 0.07
--
EPS_pickx = 0.0
EPS_picky = 0.09
--

menu.toggle_loop(toolFeats, KER_LANG_TABLE[91], {"drawentpool"}, "", function ()
    local cc = {r = 1.0, g = 1.0, b = 1.0, a = 1.0}
    if EP_drawveh then
        local vehpool = entities.get_all_vehicles_as_pointers()
        directx.draw_text(EPS_vehx, EPS_vehy, KER_LANG_TABLE[92] .. #vehpool, ALIGN_TOP_LEFT, DR_TXT_SCALE, cc, false)
    end
    if EP_drawped then
        local pedpool = entities.get_all_peds_as_pointers()
        directx.draw_text(EPS_pedx, EPS_pedy, KER_LANG_TABLE[93] .. #pedpool, ALIGN_TOP_LEFT, DR_TXT_SCALE, cc, false)
    end
    if EP_drawobj then
        local objpool = entities.get_all_objects_as_pointers()
        directx.draw_text(EPS_objx, EPS_objy, KER_LANG_TABLE[94] .. #objpool, ALIGN_TOP_LEFT, DR_TXT_SCALE, cc, false)
    end
    if EP_drawpick then
        local pickpool = entities.get_all_pickups_as_pointers()
        directx.draw_text(EPS_pickx, EPS_picky, KER_LANG_TABLE[95] .. #pickpool, ALIGN_TOP_LEFT, DR_TXT_SCALE, cc, false)
    end
end)

local ePS = menu.list(toolFeats, KER_LANG_TABLE[96], {}, "")
menu.toggle(ePS, KER_LANG_TABLE[97], {}, "", function (toggle)
    EP_drawveh = toggle
end, true)
menu.slider(ePS, KER_LANG_TABLE[98], {"epvehposx"}, "/100", 0, 100, 0, 1, function (value)
    EPS_vehx = value / 100
end) 
menu.slider(ePS, KER_LANG_TABLE[99], {"epvehposy"}, "/100", 0, 100, 3, 1, function (value)
    EPS_vehy = value / 100
end)
menu.toggle(ePS, KER_LANG_TABLE[100], {}, "", function (toggle)
    EP_drawped = toggle
end, true)
menu.slider(ePS, KER_LANG_TABLE[101], {"eppedposx"}, "/100", 0, 100, 0, 1, function (value)
    EPS_pedx = value / 100
end)
menu.slider(ePS, KER_LANG_TABLE[102], {"eppedposy"}, "/100", 0, 100, 5, 1, function (value)
    EPS_pedy = value / 100
end)
menu.toggle(ePS, KER_LANG_TABLE[103], {}, "", function (toggle)
    EP_drawobj = toggle
end, true)
menu.slider(ePS, KER_LANG_TABLE[104], {"epobjposx"}, "/100", 0, 100, 0, 1, function (value)
    EPS_objx = value / 100
end)
menu.slider(ePS, KER_LANG_TABLE[105], {"epobjposy"}, "/100", 0, 100, 7, 1, function (value)
    EPS_objy = value / 100
end)
menu.toggle(ePS, KER_LANG_TABLE[106], {}, "", function (toggle)
    EP_drawpick = toggle
end, true)
menu.slider(ePS, KER_LANG_TABLE[107], {"epickjposx"}, "/100", 0, 100, 0, 1, function (value)
    EPS_pickx = value / 100
end)
menu.slider(ePS, KER_LANG_TABLE[108], {"epickjposy"}, "/100", 0, 100, 9, 1, function (value)
    EPS_picky = value / 100
end)

menu.divider(toolFeats, KER_LANG_TABLE[109])
menu.slider(toolFeats, KER_LANG_TABLE[110], {"drscale"}, "将文本的比例设置为您指定的值，除以 10。这是因为它只采用整数值。", 1, 50, 5, 1, function (value)
    DR_TXT_SCALE = value / 10
end)

menu.divider(toolFeats, KER_LANG_TABLE[111])