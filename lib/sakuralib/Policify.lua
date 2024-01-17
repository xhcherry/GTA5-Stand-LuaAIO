local policified_vehicles = {}
local police_toggle = false

local function attach_attachment(attachment)
    if attachment.children == nil then
        attachment.children = {}
    end
    request_model(util.joaat(attachment.model))
    local heading = ENTITY.GET_ENTITY_HEADING(attachment.root.handle)
    --只有当警报开启时才会生成(可以防止脚本关闭时生成新的东西)
    if police_toggle then
        attachment.handle = entities.create_vehicle(util.joaat(attachment.model), { x = 0, y = 0, z = 0 }, heading)
    end
    STREAMING.SET_MODEL_AS_NO_LONGER_NEEDED(util.joaat(attachment.model))
    ENTITY.SET_ENTITY_INVINCIBLE(attachment.handle, true)
    ENTITY.SET_ENTITY_VISIBLE(attachment.handle, false, 0)
    ENTITY.SET_ENTITY_ALPHA(attachment.handle, 0, false)
    ENTITY.SET_ENTITY_HAS_GRAVITY(attachment.handle, false)
    if attachment.parent.handle == attachment.handle then
        ENTITY.SET_ENTITY_ROTATION(attachment.handle, 0, 0, 0)
    else
        ENTITY.ATTACH_ENTITY_TO_ENTITY(attachment.handle, attachment.parent.handle, 0, 0, 0, 0, 0, 0, 0, false, true, false, false, 2, true)
    end
    return attachment
end
local function attach_attachment_with_children(new_attachment, child_counter)
    if child_counter == nil then child_counter = 0 end
    child_counter = child_counter + 1
    new_attachment.name = new_attachment.model
    local attachment = attach_attachment(new_attachment)
    if attachment.children then
        for _, child_attachment in pairs(attachment.children) do
            attach_attachment_with_children(child_attachment, child_counter)
        end
    end
    if new_attachment.parent == new_attachment.root then
        table.insert(new_attachment.root.children, new_attachment)
    end
    return attachment
end
local function refresh_invis_police_sirens(policified_vehicle)
    for _, child_attachment in policified_vehicle.children do
        if child_attachment ~= child_attachment.root then
            delete_entity(child_attachment.handle)
        end
    end
    attach_attachment_with_children({
        root = policified_vehicle,
        parent = policified_vehicle,
        name = policified_vehicle.options.siren_attachment.name,
        model = policified_vehicle.options.siren_attachment.model,
    })
end
local function refresh_siren_status(policified_vehicle)

        VEHICLE.SET_VEHICLE_HAS_MUTED_SIRENS(policified_vehicle.handle, false)
        VEHICLE.SET_VEHICLE_SIREN(policified_vehicle.handle, true)
        AUDIO1._TRIGGER_SIREN(policified_vehicle.handle, true)
        AUDIO1._SET_SIREN_KEEP_ON(policified_vehicle.handle, true)

    for _, child_attachment in pairs(policified_vehicle.children) do
            VEHICLE.SET_VEHICLE_HAS_MUTED_SIRENS(child_attachment.handle, false)
            VEHICLE.SET_VEHICLE_SIREN(child_attachment.handle, true)
            AUDIO1._TRIGGER_SIREN(child_attachment.handle, true)
            AUDIO1._SET_SIREN_KEEP_ON(child_attachment.handle, true)
    end
end

local siren_types_name = {
    {1, "警用巡逻车"},
    {2, "警用摩托车"},
    {3, "救护车"},
    {4, "消防车"},
}
local siren_types = {
    { "警用巡逻车", {}, "警用巡逻车的标准警笛声", "police", },
    { "警用摩托车", {}, "警用摩托车的快速鸣笛声", "policeb", },
    { "救护车", {}, "救护车发出的警笛声", "ambulance", },
    { "消防车", {}, "消防车发出的警报声", "firetruk", }
}
local siren_type = siren_types[1]
local function policify_vehicle(vehicle)
    local policified_vehicle = {
        children = {},
        options = {
            siren_attachment = {name = siren_type[1],model = siren_type[4]}
        }
    }
    policified_vehicle.handle = vehicle
    policified_vehicle.root = policified_vehicle
    policified_vehicle.hash = ENTITY.GET_ENTITY_MODEL(vehicle)
    policified_vehicle.model = VEHICLE.GET_DISPLAY_NAME_FROM_VEHICLE_MODEL(policified_vehicle.hash)
    policified_vehicle.name = policified_vehicle.model
    table.insert(policified_vehicles, policified_vehicle)
    last_policified_vehicle = policified_vehicle
    return policified_vehicle
end


----变成警车
function Become_police_car()
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.GET_PLAYER_PED(PLAYER.PLAYER_ID()), false)

    VEHICLE.SET_VEHICLE_LIGHTS(vehicle, 2)
    VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 22, true)
    VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, true, true, true)
    VEHICLE.SET_VEHICLE_LIGHT_MULTIPLIER(vehicle, 1)

    VEHICLE.SET_VEHICLE_MOD(vehicle, 14, 1)
    -- 涂成哑光黑色
    VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, 0, 0, 0)
    VEHICLE.SET_VEHICLE_MOD_COLOR_1(vehicle, 3, 0, 0)
    VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, 0, 0, 0)
    VEHICLE.SET_VEHICLE_MOD_COLOR_2(vehicle, 3, 0, 0)
    -- Clear livery
    VEHICLE.SET_VEHICLE_MOD(vehicle, 48, -1)
    -- 设置车牌
    ENTITY.SET_ENTITY_AS_MISSION_ENTITY(vehicle, true, true)
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle, 4)
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "FBI")
end


----main
    menu.action(police_vehicle, "变成警车", {}, "针对载具", function()
        Become_police_car()
    end)
    menu.action(police_vehicle, "呼叫支援", {}, "呼叫附近单位支援", function()
        local incident_id = memory.alloc(8)
        MISC.CREATE_INCIDENT_WITH_ENTITY(7, PLAYER.PLAYER_PED_ID(), 3, 3, incident_id, 0, 0)
        AUDIO.PLAY_POLICE_REPORT("SCRIPTED_SCANNER_REPORT_PS_2A_01", 0)
        util.toast("已呼叫指挥中心")
    end)
    menu.toggle(police_vehicle, "启用警报器", {}, "", function(toggle)
        police_toggle = toggle
        if police_toggle then
            --获取新载具信息
            policified_vehicles = {}
            policified_vehicle = policify_vehicle(entities.get_user_vehicle_as_handle())
            refresh_invis_police_sirens(policified_vehicle)
            refresh_siren_status(policified_vehicle)
            ----当更换载具时同警报一起更换
            while police_toggle do
                local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
                --判断当前载具是否与上一辆载具相同
                if vehicle ~= vehicle2 then
                    vehicle2 = vehicle
                    for _, child_attachment in policified_vehicle.children do
                        if ENTITY.IS_ENTITY_A_VEHICLE(vehicle) then
                            ENTITY.ATTACH_ENTITY_TO_ENTITY(child_attachment.handle, vehicle, 0, 0, 0, 0, 0, 0, 0, false, true, false, false, 2, true)
                        end
                    end
                end
                util.yield()
            end
        else
            for _, child_attachment in policified_vehicle.children do
                delete_entity(child_attachment.handle)
            end
        end
    end)
    menu.list_action(police_vehicle, "警报器类型", {}, "不同的警笛类型有稍微不同的声音", siren_types_name, function(index, value, click_type)
        siren_type = siren_types[index]
        policified_vehicle.options.siren_attachment = {
            name = siren_type[1],
            model = siren_type[4]
        }
        refresh_invis_police_sirens(policified_vehicle)
        refresh_siren_status(policified_vehicle)
        --------当更换载具时同警报一起更换
        local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
        for _, child_attachment in policified_vehicle.children do
            if ENTITY.IS_ENTITY_A_VEHICLE(vehicle) then
                ENTITY.ATTACH_ENTITY_TO_ENTITY(child_attachment.handle, vehicle, 0, 0, 0, 0, 0, 0, 0, false, true, false, false, 2, true)
            end
        end
    end)


