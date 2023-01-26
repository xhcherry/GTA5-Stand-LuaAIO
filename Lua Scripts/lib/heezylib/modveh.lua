slaxdom = require("lib/heezylib/slaxdom")
slaxml = require("lib/heezylib/slaxml")
lunajson = require("lib/heezylib/lunajson")
local iniparser = require("lib/heezylib/iniparser")


function request_anim_dict(dict)
    request_time = os.time()
    if not STREAMING.DOES_ANIM_DICT_EXIST(dict) then
        return
    end
    STREAMING.REQUEST_ANIM_DICT(dict)
    while not STREAMING.HAS_ANIM_DICT_LOADED(dict) do
        if os.time() - request_time >= 10 then
            break
        end
        util.yield()
    end
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

function file_exists(path)
    local file = io.open(path, "rb")
    if file then file:close() end
    return file ~= nil
end

function hasValue( tbl, str )
    local f = false
    for i = 1, #tbl do
        if type( tbl[i] ) == "table" then
            f = hasValue( tbl[i], str )  --  return value from recursion
            if f then break end  --  if it returned true, break out of loop
        elseif tbl[i] == str then
            return true
        end
    end
    return f
end

-- credit to https://stackoverflow.com/questions/1426954/split-string-in-lua
function split_str(inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, str)
    end
    return t
end

function to_boolean(text)
    if text == 'true' or text == "1" then
        return true
    end
    return false
end

function get_element_text(el)
    local pieces = {}
    for _,n in ipairs(el.kids) do
      if n.type=='element' then pieces[#pieces+1] = get_element_text(n)
      elseif n.type=='text' then pieces[#pieces+1] = n.value
      end
    end
    return table.concat(pieces)
end


store_dir = filesystem.scripts_dir() .. '\\HeezyScript\\'

if not filesystem.is_dir(store_dir) then
    filesystem.mkdirs(store_dir)
    util.toast("欢迎来到模组创造器!")
    util.toast("将您的载具和地图放入Lua Scripts / HeezyScript / heezy vehicle 或 heezy map:)")
end

vehicles_dir = store_dir .. '\\heezy vehicles\\'
if not filesystem.is_dir(vehicles_dir) then
    filesystem.mkdir(vehicles_dir)
end


maps_dir = store_dir .. '\\heezy map\\'
if not filesystem.is_dir(maps_dir) then
    filesystem.mkdir(maps_dir)
end

function parse_xml(path)
    -- does this path even exist?
    if not file_exists(path) then
        util.toast("是的，伙计，那个文件不存在，真是尴尬")
        return
    end
    -- break file into string
    local xml = io.open(path):read('*all')
    -- dom that shit ;)
    local dom = slaxdom:dom(xml, {stripWhitespace=true})
    -- return our dominant superior ;)
    return dom
end

all_menyoo_vehicles = {}
all_menyoo_maps = {}
all_ini_vehicles = {}
all_json_vehicles = {}


function search_vehicle(query)
    local finds = {}
    for i, path in ipairs(filesystem.list_files(vehicles_dir)) do
        local v_name = path:gsub(vehicles_dir, '')
        if string.endswith(v_name, '.ini') or string.endswith(v_name, '.xml') or string.endswith(v_name, '.json') then
            if string.contains(string.lower(v_name), query) then
                finds[#finds + 1] = v_name
            end
        end
    end
    return finds
end

function search_map(query)
    local finds = {}
    for i, path in ipairs(filesystem.list_files(maps_dir)) do
        local m_name = path:gsub(maps_dir, '')
        if string.endswith(m_name, '.xml')then
            if string.contains(string.lower(m_name), query) then
                finds[#finds + 1] = m_name
            end
        end
    end
    return finds
end

v_search_results = {}
v_search_results_action = menu.list_action(xij, "搜索结果", {"lsvsearchresults"}, "", v_search_results, function(index, value)
    local path = vehicles_dir .. '\\' .. value
    if string.endswith(path, '.xml') then
        menyoo_load_vehicle(path)
    elseif string.endswith(path, '.ini') then 
        ini_load_vehicle(path)
    elseif string.endswith(path, '.json') then 
        json_load_vehicle(path)
    end 
end)

m_search_results = {}
m_search_results_action = menu.list_action(xij, "搜索结果", {"lsmsearchresults"}, "", m_search_results, function(index, value)
    local path = maps_dir .. '\\' .. value
    menyoo_load_map(path)
end)

menu.action(xij, "搜索载具", {"lssearchv"}, "", function(click_type)
    menu.show_command_box("lssearchv" .. " ")
    end, function(on_command)
        local results = search_vehicle(on_command)
        if #results == 0 then 
            util.toast("没有结果 :(")
        else
            menu.set_list_action_options(v_search_results_action, results)
            menu.trigger_commands("lsvsearchresults")
        end
end)



local load_menyoo_vehicle_action = menu.list_action(xij, "加载XML载具", {}, "加载一辆载具。按住shift键和ctrl键的同时单击一个选项以从目录中删除此载具。", all_menyoo_vehicles, function(index, value)
    local path = vehicles_dir .. '\\' .. value
    if util.is_key_down(0x10) and util.is_key_down(0x11) then
        os.remove(path)
        util.toast(value .. " 已删除! :)")
        get_all_vehicles_in_dir()
    else
        menyoo_load_vehicle(vehicles_dir .. '\\' .. value)
    end
end)

local load_ini_vehicle_action = menu.list_action(xij, "加载INI载具", {}, "加载一辆载具。按住shift键和ctrl键的同时单击一个选项以从目录中删除此载具。", all_ini_vehicles, function(index, value)
    local path = vehicles_dir .. '\\' .. value
    if util.is_key_down(0x10) and util.is_key_down(0x11) then
        os.remove(path)
        util.toast(value .. " 已删除! :)")
        get_all_vehicles_in_dir()
    else
        ini_load_vehicle(value)
    end
end)

local load_json_vehicle_action = menu.list_action(xij, "加载JSON/Jackz载具", {}, "加载一辆载具。按住shift键和ctrl键的同时单击一个选项以从目录中删除此载具。", all_ini_vehicles, function(index, value)
    local path = vehicles_dir .. '\\' .. value
    if util.is_key_down(0x10) and util.is_key_down(0x11) then
        os.remove(path)
        util.toast(value .. " 已删除! :)")
        get_all_vehicles_in_dir()
    else
        json_load_vehicle(path)
    end
end)

menu.action(xij, "搜索地图", {"lssearchmap"}, "", function(click_type)
    menu.show_command_box("lssearchmap" .. " ")
    end, function(on_command)
        local results = search_map(on_command)
        if #results == 0 then 
            util.toast("没有结果 :(")
        else
            menu.set_list_action_options(m_search_results_action, results)
            menu.trigger_commands("lsmsearchresults")
        end
end)


local load_menyoo_map_action = menu.list_action(xij, "加载XML地图", {}, "加载一个地图。按住shift键和ctrl键的同时单击一个选项以从目录中删除此载具。", all_menyoo_maps, function(index, value)
    local path = maps_dir .. '\\' .. value
    if util.is_key_down(0x10) and util.is_key_down(0x11) then
        os.remove(path)
        util.toast(value .. " 已删除! :)")
        get_all_maps_in_dir()
    else
        menyoo_load_map(path)
    end
end)

function get_all_vehicles_in_dir()
    local temp_xml_vehicles = {}
    local temp_ini_vehicles = {}
    local temp_json_vehicles = {}
    for i, path in ipairs(filesystem.list_files(vehicles_dir)) do
        if string.match(path:gsub(vehicles_dir, ''), '.xml') then
            temp_xml_vehicles[#temp_xml_vehicles + 1] = path:gsub(vehicles_dir, '')
        elseif string.match(path:gsub(vehicles_dir, ''), '.ini') then 
            temp_ini_vehicles[#temp_ini_vehicles+1] = path:gsub(vehicles_dir, '')
        elseif string.match(path:gsub(vehicles_dir, ''), '.json') then 
            temp_json_vehicles[#temp_json_vehicles+1] = path:gsub(vehicles_dir, '')
        end
    end
    all_menyoo_vehicles = temp_xml_vehicles
    all_ini_vehicles = temp_ini_vehicles
    all_json_vehicles = temp_json_vehicles
    menu.set_list_action_options(load_menyoo_vehicle_action, all_menyoo_vehicles)
    menu.set_list_action_options(load_ini_vehicle_action, all_ini_vehicles)
    menu.set_list_action_options(load_json_vehicle_action, all_json_vehicles)
end

function get_all_maps_in_dir()
    local temp_maps = {}
    for i, path in ipairs(filesystem.list_files(maps_dir)) do
        if string.match(path:gsub(maps_dir, ''), '.xml') then
            temp_maps[#temp_maps + 1] = path:gsub(maps_dir, '')
        end
    end
    all_menyoo_maps = temp_maps
    menu.set_list_action_options(load_menyoo_map_action, all_menyoo_maps)
end

get_all_vehicles_in_dir()
get_all_maps_in_dir()

util.create_thread(function()
    while true do
        get_all_vehicles_in_dir()
        get_all_maps_in_dir()
        util.yield(5000)
    end
end)

loaded_maps_root = menu.list(xij, "当前加载的地图", {"lancespoonerloadedmaps"}, "已加载的地图")
loaded_vehicles_root = menu.list(xij, "当前加载的载具", {"lancespoonerloadedvehicles"}, "你生成的载具")



function menyoo_preprocess_ped(ped, att_data, entity_initial_handles)
    local ped_data = {}
    isped = true
    entity = ped
    menyoo_preprocess_entity(ped, att_data)
    if #entity_initial_handles > 0 then
        entity_initial_handles[att_data['InitialHandle']] = ped
    end
    for a,b in pairs(att_data['PedProperties'].kids) do
        local name = b.name
        local val = get_element_text(b)
        if name == 'PedProps' or name == 'PedComps' or name == 'TaskSequence' then
            ped_data[name] = b 
        else
            ped_data[name] = val
        end
    end
    local task_data = {}
    if att_data['TaskSequence'] ~= nil then
        for a,b in pairs(att_data['TaskSequence'].kids) do
            for c,d in pairs(b.kids) do
                task_data[d.name] = get_element_text(d)
            end
        end
    end
    local props = menyoo_build_properties_table(ped_data['PedProps'].kids)
    for k,v in pairs(props) do
        k = k:gsub('_', '')
        v = split_str(v, ',')
        PED.SET_PED_PROP_INDEX(ped, k, tonumber(v[1]), tonumber(v[2]), true)
    end
    local comps = menyoo_build_properties_table(ped_data['PedComps'].kids)
    for k,v in pairs(comps) do
        k = k:gsub('_', '')
        v = split_str(v, ',')
        PED.SET_PED_COMPONENT_VARIATION(ped, k, tonumber(v[1]), tonumber(v[2]), tonumber(v[2]))
    end
    PED.SET_PED_CAN_RAGDOLL(ped, to_boolean(ped_data['CanRagdoll']))
    PED.SET_PED_ARMOUR(ped, ped_data['Armour'])
    WEAPON.GIVE_WEAPON_TO_PED(ped, ped_data['CurrentWeapon'], 999, false, true)
    -- skipping over relationship groups, fuck that shit, seriously
    -- anim shit
    if task_data['AnimDict'] ~= nil then
        request_anim_dict(task_data['AnimDict'])
        local duration = tonumber(task_data['Duration'])
        local flag = tonumber(task_data['Flag'])
        local speed = tonumber(task_data['Speed'])
        TASK.TASK_PLAY_ANIM(ped, task_data['AnimDict'], task_data['AnimName'], 8.0, 8.0, duration, flag, speed, false, false, false)
    elseif ped_data['AnimDict'] ~= nil then
        request_anim_dict(ped_data['AnimDict'])
        TASK.TASK_PLAY_ANIM(ped, ped_data['AnimDict'], ped_data['AnimName'], 8.0, 8.0, -1, 1, 1.0, false, false, false)
    end
end

function nil_handler(val, default)
    if val == nil then
        val = default
    end
    return val
end

function menyoo_preprocess_entity(entity, data)
    data['Dynamic'] = nil_handler(data['Dynamic'], true)
    data['FrozenPos'] = nil_handler(data['FrozenPos'], true)
    data['OpacityLevel'] = nil_handler(data['OpacityLevel'], 255)
    data['IsInvincible'] = nil_handler(data['IsInvincible'], false)
    data['IsVisible'] = nil_handler(data['IsVisible'], true)
    data['HasGravity'] = nil_handler(data['HasGravity'], false)
    data['IsBulletProof'] = nil_handler(data['IsBulletProof'], false)
    data['IsFireProof'] = nil_handler(data['IsFireProof'], false)
    data['IsExplosionProof'] = nil_handler(data['IsExplosionProof'], false)
    data['IsMeleeProof'] = nil_handler(data['IsMeleeProof'], false)
    ENTITY.FREEZE_ENTITY_POSITION(entity, to_boolean(data['FrozenPos']))
    ENTITY.SET_ENTITY_ALPHA(entity, tonumber(data['OpacityLevel']), false)
    ENTITY.SET_ENTITY_INVINCIBLE(entity, to_boolean(data['IsInvincible']))
    ENTITY.SET_ENTITY_VISIBLE(entity, to_boolean(data['IsVisible']), 0)
    ENTITY.SET_ENTITY_HAS_GRAVITY(entity, to_boolean(data['HasGravity']))
    ENTITY.SET_ENTITY_PROOFS(entity, to_boolean(data['IsBulletProof']), to_boolean(data['IsFireProof']), to_boolean(data['IsExplosionProof']), false, to_boolean(data['IsMeleeProof']), false, true, false)
end

function menyoo_preprocess_car(vehicle, data)
    local colors = menyoo_build_properties_table(data['Colours'].kids)
    local neons = menyoo_build_properties_table(data['Neons'].kids)
    local doorsopen = menyoo_build_properties_table(data['DoorsOpen'].kids)
    local doorsbroken = menyoo_build_properties_table(data['DoorsBroken'].kids)
    if data['TyresBursted'] ~= nil then
        local tyresbursted = menyoo_build_properties_table(data['TyresBursted'].kids)
        for k,v in pairs(tyresbursted) do
            -- fucking menyoo.. here they go mixing up wheel indexes with strings
            k = k:gsub('_', '')
            local cure_menyoo_aids = {['FrontLeft'] = 0, ['FrontRight'] = 1, [2] = 2, [3] = 3, ['BackLeft'] = 4, ['BackRight'] = 5, [6]=6, [7]=7, [8]=8}
            VEHICLE.SET_VEHICLE_TYRE_BURST(vehicle, cure_menyoo_aids[k], false, 0.0)
        end
    end
    local mods = menyoo_build_properties_table(data['Mods'].kids)
    local mod_extras = menyoo_build_properties_table(data['ModExtras'].kids)
    if mod_extras ~= nil then 
        for k,v in pairs(mod_extras) do
            k = k:gsub('_', '')
            VEHICLE.SET_VEHICLE_EXTRA(vehicle, k, not to_boolean(v))
        end
    end
    
    for k,v in pairs(neons) do
        local comp = {['Left']=0, ['Right']=1, ['Front']=2, ['Back']=3}
        VEHICLE._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, comp[k], to_boolean(v))
    end

    VEHICLE.SET_VEHICLE_WHEEL_TYPE(vehicle, tonumber(data['WheelType']))
    for k,v in pairs(mods) do
        k = k:gsub('_', '')
        v = split_str(v, ',')
        VEHICLE.SET_VEHICLE_MOD(vehicle, tonumber(k), tonumber(v[1]), to_boolean(v[2]))
    end


    for k,v in pairs(colors) do
        colors[k] = tonumber(v)
    end

    VEHICLE.SET_VEHICLE_COLOURS(vehicle, colors['Primary'], colors['Secondary'])
    VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicle, colors['Pearl'], colors['Rim'])
    VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, colors['tyreSmoke_R'], colors['tyreSmoke_G'], colors['tyreSmoke_B'])
    VEHICLE._SET_VEHICLE_INTERIOR_COLOR(vehicle, colors['LrInterior'])
    VEHICLE._SET_VEHICLE_DASHBOARD_COLOR(vehicle, colors['LrDashboard'])
    local livery = tonumber(data['Livery'])
    if livery == -1 then
        livery = 0
    end
    VEHICLE.SET_VEHICLE_LIVERY(vehicle, livery)
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, data['NumberPlateText'])
    VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle, tonumber(data['NumberPlateTextIndex']))
    -- wheel invis here
    -- engine sound name here
    VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, tonumber(data['WindowTint']))
    VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, to_boolean(data['BulletProofTyres']))
    VEHICLE. SET_VEHICLE_DIRT_LEVEL(vehicle, tonumber(data['DirtLevel']))
    VEHICLE.SET_VEHICLE_ENVEFF_SCALE(vehicle, tonumber(data['PaintFade']))
    VEHICLE.SET_CONVERTIBLE_ROOF_LATCH_STATE(vehicle, tonumber(data['RoofState']))
    VEHICLE.SET_VEHICLE_SIREN(vehicle, to_boolean(data['SirenActive']))
    VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, to_boolean(data['EngineOn']), true, false)
    -- not sure how to set lights on
    AUDIO.SET_VEHICLE_RADIO_LOUD(vehicle, to_boolean(data['IsRadioLoud']))
    VEHICLE.SET_VEHICLE_DOORS_LOCKED(vehicle, tonumber(data['LockStatus']))
    if data['EngineHealth'] ~= nil then
        VEHICLE.SET_VEHICLE_ENGINE_HEALTH(vehicle, tonumber(data['EngineHealth']))
    end
end

function menyoo_build_properties_table(kids)
    if kids ~= nil then
        local table = {}
        for k,v in pairs(kids) do
            local name = v.name
            local val = get_element_text(v)
            table[name] = val
        end
        return table
    end
    return nil
end

function menyoo_load_map(path)
    local all_entities = {}
    util.toast("您的地图正在加载！。。。")
    local entity_initial_handles = {}
    local xml_tbl = parse_xml(path).root
    -- n appears to be the enum of the kid, k is the actual kid table
    local data = {}
    for a,b in pairs(xml_tbl.kids) do
        local vproperties = {}
        local pproperties = {}
        local name = b.name
        local isvehicle = false
        local isped = false
        if name == 'ReferenceCoords' then
            for k,v in pairs(b.kids) do
                if v.name == 'X' then
                    mmblip_x = tonumber(get_element_text(v))
                elseif v.name == 'Y' then
                    mmblip_y = tonumber(get_element_text(v))
                elseif v.name == 'Z' then
                    mmblip_z = tonumber(get_element_text(v))
                end
            end
            mmblip = HUD.ADD_BLIP_FOR_COORD(mmblip_x, mmblip_y, mmblip_z)
            HUD.SET_BLIP_SPRITE(mmblip, 77)
            HUD.SET_BLIP_COLOUR(mmblip, 48)
        end
        if name == 'Placement' then
            for c,d in pairs(b.kids) do
                if d.name == 'PositionRotation' then
                    for e, f in pairs(d.kids) do
                        data[f.name] = get_element_text(f)
                    end
                elseif d.name == 'VehicleProperties' then
                    isvehicle = true
                    for n, p in pairs(d.kids) do
                        local prop_name = p.name
                        if prop_name == 'Colours' or prop_name == 'Neons' or prop_name == 'Mods' or prop_name == 'DoorsOpen' or prop_name == 'DoorsBroken' or prop_name == 'TyresBursted' then
                            vproperties[prop_name] = p
                        else
                            vproperties[prop_name]  = get_element_text(p)
                        end
                    end
                elseif d.name == 'PedProperties' then
                    isped = true
                    pproperties[d.name] = d
                else
                    data[d.name] = get_element_text(d)
                end
            end
            mmpos = {}
            mmpos.x = tonumber(data['X'])
            mmpos.y = tonumber(data['Y'])
            mmpos.z = tonumber(data['Z'])
            mmrot = {}
            mmrot.pi = tonumber(data['Pitch'])
            mmrot.ro = tonumber(data['Roll'])
            mmrot.ya = tonumber(data['Yaw'])
            if STREAMING.IS_MODEL_VALID(data['ModelHash']) then
                local mment = 0
                if isvehicle then
                    request_model_load(data['ModelHash'])
                    mment = entities.create_vehicle(data['ModelHash'], mmpos, mmrot.ya)
                    menyoo_preprocess_entity(mment, data)
                    menyoo_preprocess_car(mment, vproperties)
                elseif isped then
                    request_model_load(data['ModelHash'])
                    mment = entities.create_ped(0, data['ModelHash'], mmpos, mmrot.ya)
                    menyoo_preprocess_ped(mment, pproperties, {})
                    menyoo_preprocess_entity(mment, data)
                else
                    request_model_load(data['ModelHash'])
                    mment = entities.create_object(data['ModelHash'], mmpos)
                    menyoo_preprocess_entity(mment, data)
                end
                table.insert(all_entities, mment)
                ENTITY.SET_ENTITY_ROTATION(mment, mmrot.pi, mmrot.ro, mmrot.ya, 2, true)
            else
                util.toast("发现了一些无效的模型。确保您没有使用需要mods才能生成的XML。")
            end
        end
    end
    if mmblip == nil then 
        util.toast("加载此地图时出现问题。确保XML是Menyoo XML。")
        return 
    end
    mm_maproot = menu.list(loaded_maps_root, path:gsub(maps_dir, "") .. ' [' .. mmblip .. ']', {"lancespoonerloadedmaps" .. mmblip}, "已加载的地图")
    menu.action(mm_maproot, "传送到地图", {"menyoomteleportto" .. mmblip}, "传送到此地图。", function(on_click)
        ENTITY.SET_ENTITY_COORDS_NO_OFFSET(PLAYER.PLAYER_PED_ID(), mmpos.x, mmpos.y, mmpos.z, false, false, false)
    end)

    menu.action(mm_maproot, "删除地图", {"menyoomdelete" .. mmblip}, "", function(on_click)
        for k,v in pairs(all_entities) do
            entities.delete(v)
        end
        menu.delete(mm_maproot)
        -- apparently remove blip is fucked, so we set sprite to invis as a failsafe
        util.remove_blip(mmblip)
    end)
    util.toast("地图加载完成。在你的地图上找一个洋红色的L标志。")
end

function menyoo_load_vehicle(path)
    our_ped = players.user_ped()
    local all_entities = {}
    local entity_initial_handles = {}
    local data = {}
    local vproperties = {}
    local xml_tbl = parse_xml(path).root
    local initial_handle_index = 0
    -- n appears to be the enum of the kid, k is the actual kid table
    for k,v in pairs(xml_tbl.kids) do
        local name = v.name
        if name == 'VehicleProperties' then
            for n, p in pairs(v.kids) do
                local prop_name = p.name
                if prop_name == 'Colours' or prop_name == 'Neons' or prop_name == 'Mods' or prop_name == 'DoorsOpen' or prop_name == 'DoorsBroken' or prop_name == 'TyresBursted' then
                    vproperties[prop_name] = p
                else
                    vproperties[prop_name]  = get_element_text(p)
                end
            end
        else
            if name == 'SpoonerAttachments' then
                data[name] = v
            else
                local el_text = get_element_text(v)
                data[name] = el_text
            end
        end
    end
    request_model_load(data['ModelHash'])
    local coords = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(our_ped, 0.0, 5.0, 0.0)
    local vehicle = entities.create_vehicle(data['ModelHash'], coords, ENTITY.GET_ENTITY_HEADING(our_ped))
    table.insert(all_entities, vehicle)
    ENTITY.SET_ENTITY_INVINCIBLE(vehicle, true)
    PED.SET_PED_INTO_VEHICLE(our_ped, vehicle, -1)
    if data['InitialHandle'] == nil then
        initial_handle_index = initial_handle_index + 1
        data['InitialHandle'] = initial_handle_index
    end
    entity_initial_handles[data['InitialHandle']] = vehicle
    -- apply natives that can apply to any entity
    menyoo_preprocess_entity(vehicle, data)
    menyoo_preprocess_car(vehicle, vproperties)
    -- vehicle-specific natives
    -- now for the attachments...
    local attachments = data['SpoonerAttachments']
    all_attachments = {}
    if attachments ~= nil then
        for a,b in pairs(attachments.kids) do
            local vproperties = {}
            -- each item here should be "attachment" element
            local att_data = {}
            for c,d in pairs(b.kids) do
                local name = d.name
                local val = get_element_text(d)
                if name == 'PedProperties' or name == 'Attachment' or name == 'TaskSequence' then
                    att_data[name] = d
                elseif name == 'VehicleProperties' then
                    for n, p in pairs(d.kids) do
                        local prop_name = p.name
                        if prop_name == 'Colours' or prop_name == 'Neons' or prop_name == 'Mods' or prop_name == 'DoorsOpen' or prop_name == 'DoorsBroken' or prop_name == 'TyresBursted' then
                            vproperties[prop_name] = p
                        else
                            vproperties[prop_name]  = get_element_text(p)
                        end
                    end
                else
                    att_data[name] = val
                end
            end
            request_model_load(att_data['ModelHash'])
            -- 1 = ped, 2 = vehicle, 3 = object
            local attachment_info = menyoo_build_properties_table(att_data['Attachment'].kids)
            local entity = nil
            local isped = false
            if att_data['Type'] == '1' then
                local ped = entities.create_ped(0, att_data['ModelHash'], coords, ENTITY.GET_ENTITY_HEADING(ourped))
                menyoo_preprocess_ped(ped, att_data, entity_initial_handles)
                entity = ped
            elseif att_data['Type'] == '2' then
                local veh = entities.create_vehicle(att_data['ModelHash'], coords, ENTITY.GET_ENTITY_HEADING(ourped))
                entity = veh
                menyoo_preprocess_entity(veh, att_data)
                menyoo_preprocess_car(veh, vproperties)
            elseif att_data['Type'] == '3' then
                local obj = entities.create_object(att_data['ModelHash'], coords)
                entity = obj
                menyoo_preprocess_entity(obj, att_data)
                -- obj code
            end
            table.insert(all_entities, entity)
            ENTITY.SET_ENTITY_INVINCIBLE(entity, true)
            local bone = tonumber(attachment_info['BoneIndex'])
            local x = tonumber(attachment_info['X'])
            local y = tonumber(attachment_info['Y'])
            local z = tonumber(attachment_info['Z'])
            local pitch = tonumber(attachment_info['Pitch'])
            local yaw = tonumber(attachment_info['Yaw'])
            local roll = tonumber(attachment_info['Roll'])
            all_attachments[entity] = {}
            all_attachments[entity]['attachedto'] = attachment_info['AttachedTo']
            all_attachments[entity]['bone'] = bone
            all_attachments[entity]['x'] = x
            all_attachments[entity]['y'] = y
            all_attachments[entity]['z'] = z
            all_attachments[entity]['pitch'] = pitch
            all_attachments[entity]['yaw'] = yaw
            all_attachments[entity]['roll'] = roll
            all_attachments[entity]['isped'] = isped
        end
        for k, v in pairs(all_attachments) do
            ENTITY.ATTACH_ENTITY_TO_ENTITY(k, entity_initial_handles[v['attachedto']], v['bone'], v['x'], v['y'], v['z'], v['pitch'], v['roll'], v['yaw'], true, false, true, v['isped'], 2, true)
        end
    end
    local this_blip = HUD.ADD_BLIP_FOR_ENTITY(vehicle)
    HUD.SET_BLIP_SPRITE(this_blip, 77)
    HUD.SET_BLIP_COLOUR(this_blip, 47)
    local this_veh_root = menu.list(loaded_vehicles_root, path:gsub(vehicles_dir .. '\\', ''), {"lancespoonerv" .. vehicle}, "")
    menu.action(this_veh_root, "删除", {"deletelancespoonerv" .. vehicle}, "删除此载具。让它停止存在。", function(on_click)
        for k,v in pairs(all_entities) do
            entities.delete(v)
        end
        menu.delete(this_veh_root)
        util.remove_blip(this_blip)
    end)
    menu.action(this_veh_root, "传送到里面", {"teleportemenyoov" .. vehicle}, "", function(on_click)
        PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), vehicle, -1)
    end)
    return vehicle
end

function ini_preprocess_vehicle(vehicle, data, ini_type, veh_index) 
    -- vehicle is a handle to an already-spawned vehicle
    if ini_type == 1 then
        VEHICLE.SET_VEHICLE_COLOURS(vehicle, data.Primary or 0, data.Secondary or 0)
        VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, data.SmokeR or 0, data.SmokeG or 0, data.SmokeB or 0)
        VEHICLE._SET_VEHICLE_NEON_LIGHTS_COLOUR(vehicle, data.NeonR or 0, data.NeonG or 0, data.NeonB or 0)
        VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "LANCE")
        VEHICLE.SET_VEHICLE_DIRT_LEVEL(vehicle, data.Dirt or 0)
        VEHICLE.SET_VEHICLE_ENVEFF_SCALE(vehicle, data.PaintFade or 0)
        VEHICLE.SET_VEHICLE_WHEEL_TYPE(vehicle, data.Wheels or 0)
        VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicle, data.Pearl or 0, data.WheelColor or 0)
        VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, data.Tint or 0)

        if data['BulletProofTires'] == 1 then 
            VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, false)
        end
        for i=1, 4 do 
            if data['Neon' .. i] == 1 then 
                VEHICLE._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, i, true)
            end
        end

        for i=0, 48 do
            if data[i] ~= nil then 
                -- idk how we even determine if a car has custom tires in this format
                VEHICLE.SET_VEHICLE_MOD(vehicle, i, data[i], false)
            end
        end

        for i=1, 9 do 
            VEHICLE.SET_VEHICLE_EXTRA(vehicle, i, if data['extra' .. i] == 0 then true else false)
        end

    elseif ini_type == 2 then
        local v_mods = data['Vehicle Mods']
        local v_extras = data['Vehicle Extras']
        local v_toggles = data['Vehicle Toggles']
        local data = data.Vehicle 
        VEHICLE.SET_VEHICLE_COLOURS(vehicle, data['primary paint'] or 0, data['secondary paint'] or 0)
        VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, data['tyre smoke red'] or 0, data['tyre smoke green'] or 0, data['tyre smoke blue'] or 0)
        VEHICLE._SET_VEHICLE_NEON_LIGHTS_COLOUR(vehicle, data['neon red'] or 0, data['neon green'] or 0, data['neon blue'] or 0)
        VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "LANCE")
        VEHICLE.SET_VEHICLE_DIRT_LEVEL(vehicle, data['dirt level'] or 0)
        --VEHICLE.SET_VEHICLE_ENVEFF_SCALE(vehicle, data.PaintFade or 0)
        VEHICLE.SET_VEHICLE_WHEEL_TYPE(vehicle, data['wheel type'] or 0)
        VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicle, data['pearlescent colour'] or 0, data['wheel colour'] or 0)
        VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, data['window tint'] or 0)
        VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT_INDEX(vehicle, data['plate index'] or 0)

        if data['bulletproof tyres'] == 1 then 
            VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, false)
        end

        for i=1, 4 do 
            if data['neon ' .. i] == 1 then 
                VEHICLE._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, i, true)
            end
        end

        for i= 1, 7 do 
            if data['door ' .. i .. ' state'] == 1 then
                VEHICLE.SET_VEHICLE_DOOR_OPEN(vehicle, i, false, true)
            end
        end

        for i=0, 48 do
            if v_mods[i] ~= nil then 
                -- idk how we even determine if a car has custom tires in this format
                VEHICLE.SET_VEHICLE_MOD(vehicle, i, v_mods[i], false)
            end
        end

        for i=1, 9 do 
            VEHICLE.SET_VEHICLE_EXTRA(vehicle, i, if v_extras[i] == 0 then true else false)
        end

        for i=17, 22 do 
            VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, i, if v_toggles[i] == 1 then true else false)
        end

    elseif ini_type == 3 then
        VEHICLE.SET_VEHICLE_COLOURS(vehicle, data.PrimaryPaint or 0, data.SecondaryPaint or 0)
        if data.PrimaryPaint == -1 then 
            VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, data.PrimaryR or 0, data.PrimaryG or 0, data.PrimaryB or 0)
        end 
        if data.SecondaryPaint == -1 then 
            VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, data.SecondaryR, data.SecondaryG, data.SecondaryB)
        end
        VEHICLE.SET_VEHICLE_MOD_COLOR_1(vehicle, data.PrimaryPaintT or 0, data.PrimaryPaint or 0, data.Pearlescent or 0)
        VEHICLE.SET_VEHICLE_MOD_COLOR_2(vehicle, data.SecondaryPaintT or 0, data.SecondaryPaint or 0)
        VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, data.SmokeR or 0, data.SmokeG or 0, data.SmokeB or 0)
        VEHICLE._SET_VEHICLE_NEON_LIGHTS_COLOUR(vehicle, data.NeonR or 0, data.NeonG or 0, data.NeonB or 0)
        VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "LANCE")
        --VEHICLE.SET_VEHICLE_DIRT_LEVEL(vehicle, data.Dirt or 0)
        VEHICLE.SET_VEHICLE_ENVEFF_SCALE(vehicle, data.PaintFade or 0)
        VEHICLE.SET_VEHICLE_WHEEL_TYPE(vehicle, data.Wheels or 0)
        VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicle, data.Pearlescent or 0, data.WheelsColor or 0)
        VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, data.WindowTint or 0)
        VEHICLE._SET_VEHICLE_DASHBOARD_COLOR(vehicle, data.DashColor)
        VEHICLE._SET_VEHICLE_INTERIOR_COLOR(vehicle, data.DashLightColor)

        if data.BulletProof == 1 then 
            VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, false)
        end
        if data.NeonEnabled == 1 then
            for i=1, 4 do 
                VEHICLE._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, i, true)
            end
        end

        for i=0, 48 do
            if data[i] ~= nil then 
                VEHICLE.SET_VEHICLE_MOD(vehicle, i, data[i], data.CustomTyres)
            end
        end

        for i=17, 22 do 
            VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, i, if data['TOGGLE_' .. i] == 1 then true else false)
        end

        for i=1, 9 do 
            VEHICLE.SET_VEHICLE_EXTRA(vehicle, i, if data['Extra_' .. i] == 0 then true else false)
        end

    elseif ini_type == 4 then 
        util.toast("仅部分支持此INI。对不起,如果东西看起来很奇怪或有些东西丢失了。")
        local v_root = data['Vehicle' .. veh_index]
        local v_mods = data['Vehicle' .. veh_index .. "Mods"]
        local v_extras = data['Vehicle' .. veh_index .. "Extras"]
        local v_toggles = data['Vehicle' .. veh_index .. "Toggles"]
        local v_smoke = data['Vehicle' .. veh_index .. "TireSmoke"]
        local v_neon = data['Vehicle' .. veh_index .. "Neon"]
        local v_neon_color = data['Vehicle' .. veh_index .. "NeonColor"]
        local v_paintfade = data['Vehicle' .. veh_index .. "PaintFade"]
        local v_color_main = data['Vehicle' .. veh_index .. "VehicleColors"]
        local v_color_extra = data['Vehicle' .. veh_index .. "ExtraColors"]
        local v_color_custom_p = data['Vehicle' .. veh_index .. "CustomPrimaryColor"]
        local v_color_custom_s = data['Vehicle' .. veh_index .. "CustomSecondaryColor"]
        local v_wheel_type = data['Vehicle' .. veh_index .. "WheelType"]
        local v_plate = data['Vehicle' .. veh_index .. "Numberplate"]
        local v_window_tint = data['Vehicle' .. veh_index .. "WindowTint"]
        local v_is_custom_primary = data['Vehicle' .. veh_index .. "IsCustomPrimary"]
        local v_is_custom_secondary = data['Vehicle' .. veh_index .. "IsCustomSecondary"]
        local data = data['Vehicle' .. veh_index]

        for i=0, 49 do
            if data['M' .. tostring(i)] ~= nil then 
                VEHICLE.SET_VEHICLE_MOD(vehicle, i, v_mods['M' .. i], false)
            end
        end

        for i=0, 49 do 
            VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, i, v_toggles['T' .. i])
        end

        for i=1, 13 do 
            VEHICLE.SET_VEHICLE_EXTRA(vehicle, i, v_extras['E' .. i])
        end

        for i=1, 4 do 
            VEHICLE._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, i, v_neon["Enabled" .. i])
        end

        ENTITY.SET_ENTITY_DYNAMIC(vehicle, v_root.Dynamic)
        ENTITY.SET_ENTITY_VISIBLE(vehicle, v_root.Visible, 0)
        VEHICLE.SET_VEHICLE_COLOURS(vehicle, v_color_main.Primary or 0, v_color_main.Secondary or 0)
        if v_is_custom_primary['bool'] then 
            VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(v_color_custom_p.r or 0, v_color_custom_p.g or 0, v_color_custom_p.b or 0)
        end

        if v_is_custom_secondary['bool'] then 
            VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(v_color_custom_s.r or 0, v_color_custom_s.g or 0, v_color_custom_s.b or 0)
        end

        VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicle, v_color_extra.Pearl or 0, v_color_extra.Wheel or 0)

    
        VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, v_smoke.R or 0, v_smoke.G or 0, v_smoke.B or 0)
        VEHICLE._SET_VEHICLE_NEON_LIGHTS_COLOUR(vehicle, v_neon_color.R or 0, v_neon_color.G or 0, v_neon_color.B or 0)
        VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "LANCE")
        --VEHICLE.SET_VEHICLE_DIRT_LEVEL(vehicle, data.Dirt or 0)
        VEHICLE.SET_VEHICLE_ENVEFF_SCALE(vehicle, v_paintfade.PaintFade or 0)
        VEHICLE.SET_VEHICLE_WHEEL_TYPE(vehicle, v_wheel_type or 0)
        VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, v_window_tint or 0)
        ENTITY.SET_ENTITY_INVINCIBLE(vehicle, v_root.Invincible or false)
        ENTITY.SET_ENTITY_HAS_GRAVITY(vehicle, v_root.Gravity or true)
        ENTITY.FREEZE_ENTITY_POSITION(vehicle, v_root.Freeze or false)
        ENTITY.SET_ENTITY_RENDER_SCORCHED(vehicle, v_root.ScorchedRender or false)
        ENTITY.SET_ENTITY_ALPHA(vehicle, v_root.Alpha or 255, false) 
        VEHICLE.SET_VEHICLE_DIRT_LEVEL(vehicle, v_root.Dirt or 0.0) 
        VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, v_root.IsEngineOn, true, false)
        VEHICLE.SET_VEHICLE_LIGHT_MULTIPLIER(vehicle, v_root.HeadlightMultiplier or 1.0)
    end
end

function tprint (tbl, indent)
    if not indent then indent = 0 end
    for k, v in pairs(tbl) do
      formatting = string.rep("  ", indent) .. k .. ": "
      if type(v) == "table" then
        print(formatting)
        tprint(v, indent+1)
      elseif type(v) == 'boolean' then
        print(formatting .. tostring(v))      
      else
        print(formatting .. v)
      end
    end
  end

function ini_load_vehicle(file_name)
    --local data = LIP.load(vehicles_dir .. '\\' .. file_name)
    local data = iniparser.parse(file_name, vehicles_dir)
    local all_entities = {}
    local ini_type = -1
    -- determine type of ini file 
    -- type 1 has no spaces in it (i.e Airship.xml). 
    -- type 2 does and has  lowercase shit (420 Hydra.ini). it's also extremely stupid
    -- type 3 is extremely similar to type 1, but has values like PrimaryPaintT (BayWatch Blazer.xml)
    -- type 4 has an "AllObjects", "AllPeds", "AllVehicles" section in the ini (4tire_bike.ini)
    -- type 5 has AllObjects and AllVehicles (Boat-fsx.ini) (seems like theres an iniparser glitch in this one)
    -- type 6 is like type 2, but some keys are different, namely the numbers for attachments are called "Attached Object x" (Tankamid.ini)

    if data.Vehicle.model == nil and data.Vehicle.PrimaryPaintT == nil and data.AllVehicles.Count == nil then 
        ini_type = 1
    elseif data.Vehicle.model ~= nil and data['Attached Object 1'].model == nil then 
        ini_type = 2
    elseif data.Vehicle.model == nil and data.Vehicle.PrimaryPaintT ~= nil then 
        ini_type = 3
    elseif data.AllObjects.Count ~= nil and data.AllVehicles.Count ~= nil and data.AllPeds.Count ~= nil then 
        ini_type = 4
    elseif data.Vehicle.model ~= nil and data['Attached Object 1'].model ~= nil then 
        ini_type = 6
    end


    if ini_type == -1 then
        util.toast("不支持此ini类型 (纳尼??)! 很抱歉 :(")
        return
    end
    -- there is also an ini type 6...
    local initial_vehicle
    local v_count = 1
    local success = false
    if ini_type == 1 then 
        local v_hash = data['Vehicle']['Model']
        local c = players.get_position(players.user())
        request_model_load(v_hash)
        initial_vehicle = entities.create_vehicle(v_hash, c, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
        all_entities[#all_entities+1] = initial_vehicle
        ini_preprocess_vehicle(initial_vehicle, data['Vehicle'], ini_type)
        local attachment_index = 0
        while true do 
            if data[tostring(attachment_index)].Model == nil then 
                success = true
                break
            end
            local here = data[tostring(attachment_index)]
            request_model_load(here.Model)
            local this_ent = entities.create_object(here.Model, players.get_position(players.user()))
            all_entities[#all_entities+1] = this_ent
            ENTITY.ATTACH_ENTITY_TO_ENTITY(this_ent, initial_vehicle, here['Bone'], here['X'], here['Y'], here['Z'], here['RotX'], here['RotY'], here['RotZ'], true, if here['Collision'] == 1 then true else false, true, false, 2, true)
            if here['Froozen'] == 1 then 
                ENTITY.FREEZE_ENTITY_POSITION(this_ent, true)
            end

            if here['Lit'] == 1 then 
                FIRE.START_ENTITY_FIRE(this_ent)
            end
            attachment_index = attachment_index + 1
        end
    elseif ini_type == 2 then
        local v_hash = data.Vehicle.model
        local c = players.get_position(players.user())
        request_model_load(v_hash)
        initial_vehicle = entities.create_vehicle(v_hash, c, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
        all_entities[#all_entities+1] = initial_vehicle
        ini_preprocess_vehicle(initial_vehicle, data, ini_type)
        local attachment_index = 0
        while true do 
            if data[tostring(attachment_index)].model == nil then 
                success = true
                break
            end
            local here = data[tostring(attachment_index)]
            request_model_load(here.model)
            local this_ent = entities.create_object(here.model, players.get_position(players.user()))
            all_entities[#all_entities+1] = this_ent
            ENTITY.ATTACH_ENTITY_TO_ENTITY(this_ent, initial_vehicle, 0, here['x'], here['y'], here['z'], here['RotX'], here['RotY'], here['RotZ'], true, false, true, false, 2, true)
            attachment_index = attachment_index + 1
        end

    elseif ini_type == 3 then
        local v_hash = data.Vehicle.Model
        local c = players.get_position(players.user())
        request_model_load(v_hash)
        initial_vehicle = entities.create_vehicle(v_hash, c, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
        all_entities[#all_entities+1] = initial_vehicle
        ini_preprocess_vehicle(initial_vehicle, data.Vehicle, ini_type)
        local attachment_index = 0
        while true do 
            if data[tostring(attachment_index)].Model == nil then 
                success = true
                break
            end
            local here = data[tostring(attachment_index)]
            request_model_load(here.Model)
            local this_ent = entities.create_object(here.Model, players.get_position(players.user()))
            all_entities[#all_entities+1] = this_ent
            ENTITY.ATTACH_ENTITY_TO_ENTITY(this_ent, initial_vehicle, 0, here['X'], here['Y'], here['Z'], here['RotX'], here['RotY'], here['RotZ'], true, false, true, false, 2, true)
            attachment_index = attachment_index + 1
        end
    
    elseif ini_type == 4 then 
        local numerations = {}
        local attachments_data = {}
        local veh_index = 0
        local object_index = 0 
        local ped_index = 0
        while true do
            if data['Vehicle' .. tostring(veh_index)].Hash == nil then 
                success = true
                break
            end
            local here = data['Vehicle' .. tostring(veh_index)]
            request_model_load(here.Hash)
            local this_vehicle = entities.create_vehicle(here.Hash, players.get_position(players.user()), ENTITY.GET_ENTITY_HEADING(players.user_ped()))
            if veh_index == 0 then 
                initial_vehicle = this_vehicle
            end
            numerations[here.SelfNumeration] = this_vehicle
            if here.IsAttached then
                attachments_data[here.SelfNumeration] = {attachee = this_vehicle, attached_to = here.AttachNumeration, x = here.OffsetX, y = here.OffsetY, z = here.OffsetZ, pitch = here.Pitch, yaw = here.Yaw, roll = here.Roll, bone = here.Bone, collision = here.Collision}
            end
            all_entities[#all_entities+1] = this_vehicle
            ini_preprocess_vehicle(this_vehicle, data, ini_type, veh_index)
            veh_index = veh_index + 1
        end

        while true do
            if data['Object' .. tostring(object_index)].Hash == nil then 
                success = true
                break
            end
            local here = data['Object' .. tostring(object_index)]
            request_model_load(here.Hash)
            local this_object = entities.create_object(here.Hash, players.get_position(players.user()))
            numerations[here.SelfNumeration] = this_object
            if here.IsAttached then
                attachments_data[here.SelfNumeration] = {attachee = this_object, attached_to = here.AttachNumeration, x = here.OffsetX, y = here.OffsetY, z = here.OffsetZ, pitch = here.Pitch, yaw = here.Yaw, roll = here.Roll, bone = here.Bone, collision = here.Collision}
            end
            all_entities[#all_entities+1] = this_object
            ENTITY.SET_ENTITY_DYNAMIC(veh, here.Dynamic)
            ENTITY.SET_ENTITY_VISIBLE(veh, here.Visible) 
            ENTITY.SET_ENTITY_HAS_GRAVITY(veh, here.Gravity)
            ENTITY.FREEZE_ENTITY_POSITION(veh, here.Freeze)
            object_index = object_index + 1
        end

        for k,v in pairs(attachments_data) do
            ENTITY.ATTACH_ENTITY_TO_ENTITY(v.attachee, numerations[v.attached_to], v.Bone, v.x, v.y, v.z, v.pitch, v.roll, v.yaw, true, false, v.collision, false, 2, true)
        end

    elseif ini_type == 6 then 
        local v_hash = data.Vehicle.model
        local c = players.get_position(players.user())
        request_model_load(v_hash)
        initial_vehicle = entities.create_vehicle(v_hash, c, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
        all_entities[#all_entities+1] = initial_vehicle
        ini_preprocess_vehicle(initial_vehicle, data, ini_type)
        local attachment_index = 1
        while true do 
            if data['Attached Object ' .. tostring(attachment_index)].model == nil then 
                success = true
                break
            end
            local here = data['Attached Object ' .. tostring(attachment_index)]
            request_model_load(here.model)
            local this_ent = entities.create_object(here.model, players.get_position(players.user()))
            all_entities[#all_entities+1] = this_ent
            ENTITY.ATTACH_ENTITY_TO_ENTITY(this_ent, initial_vehicle, 0, here['x offset'], here['y offset'], here['z offset'], here['pitch'], here['roll'], here['yaw'], true, false, if here['collision'] == 1 then true else false, false, 2, true)
            attachment_index = attachment_index + 1
        end
    end

    if success then
        PED.SET_PED_INTO_VEHICLE(players.user_ped(), initial_vehicle, -1)
        local this_veh_root = menu.list(loaded_vehicles_root, file_name, {"lancespoonerv" .. initial_vehicle}, "")

        local this_blip = HUD.ADD_BLIP_FOR_ENTITY(initial_vehicle)
        HUD.SET_BLIP_SPRITE(this_blip, 77)
        HUD.SET_BLIP_COLOUR(this_blip, 47)

        menu.action(this_veh_root, "删除", {"deletelancespoonerv" .. initial_vehicle}, "删除此载具。让它停止存在。", function(on_click)
            for k,v in pairs(all_entities) do
            entities.delete(v)
        end
        menu.delete(this_veh_root)
        util.remove_blip(this_blip)
    end)

    menu.action(this_veh_root, "传送到里面", {"teleportemenyoov" .. initial_vehicle}, "", function(on_click)
        PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), initial_vehicle, -1)
    end)

else
    util.toast("有些糟糕的事情发生了!无法正确加载此INI。很抱歉:'(")
end
end

function json_preprocess_vehicle(vehicle, data, initial_vehicle)
ENTITY.SET_ENTITY_VISIBLE(vehicle, data.visible, 0)
local sd = data.savedata
local mods = sd.Mods
if sd.godmode ~= nil then
    ENTITY.SET_ENTITY_INVINCIBLE(vehicle, sd.godmode)
end

if vehicle ~= initial_vehicle then 
    ENTITY.ATTACH_ENTITY_TO_ENTITY(vehicle, initial_vehicle, 0, data.offset.x, data.offset.y, data.offset.z, data.rotation.x, data.rotation.y, data.rotation.z, true, false, true, false, 2, true)
end
-- for some reason jackz used the name of the mod instead of the mod index / mod type lol
-- otherwise, this code couldve taken up just 3 lines
-- not like i couldnt have used a table, but still, come on...
VEHICLE.SET_VEHICLE_TYRE_SMOKE_COLOR(vehicle, sd['Tire Smoke'].r, sd['Tire Smoke'].g, sd['Tire Smoke'].b)
VEHICLE.SET_VEHICLE_MOD(vehicle, 0, mods['Spoilers'], false)
VEHICLE.SET_VEHICLE_MOD(vehicle, 1, mods['Ornaments'], false)
VEHICLE.SET_VEHICLE_MOD(vehicle, 2, mods['Front Bumper'], false)
VEHICLE.SET_VEHICLE_MOD(vehicle, 3, mods['Side Skirt'], false)
VEHICLE.SET_VEHICLE_MOD(vehicle, 4, mods['Exhaust'], false)
VEHICLE.SET_VEHICLE_MOD(vehicle, 5, mods['Frame'], false)
VEHICLE.SET_VEHICLE_MOD(vehicle, 6, mods['Grille'], false)
VEHICLE.SET_VEHICLE_MOD(vehicle, 7, mods['Hood'], false)
VEHICLE.SET_VEHICLE_MOD(vehicle, 8, mods['Fender'], false)
VEHICLE.SET_VEHICLE_MOD(vehicle, 9, mods['Right Fender'], false)
VEHICLE.SET_VEHICLE_MOD(vehicle, 10, mods['Roof'], false)
VEHICLE.SET_VEHICLE_MOD(vehicle, 11, mods['Engine'], false)
VEHICLE.SET_VEHICLE_MOD(vehicle, 12, mods['Brakes'], false)
VEHICLE.SET_VEHICLE_MOD(vehicle, 13, mods['Transmission'], false)
VEHICLE.SET_VEHICLE_MOD(vehicle, 14, mods['Horns'], false)
VEHICLE.SET_VEHICLE_MOD(vehicle, 15, mods['Suspension'], false)
VEHICLE.SET_VEHICLE_MOD(vehicle, 16, mods['Armor'], false)
-- no front wheels in spec? lol?
--VEHICLE.SET_VEHICLE_MOD(vehicle, 23, mods['Front Wheels'], false)
VEHICLE.SET_VEHICLE_MOD(vehicle, 24, mods["Motorcycle Back Wheel Design"], false)
VEHICLE.SET_VEHICLE_MOD(vehicle, 25, mods['Plate Holders'], false)
VEHICLE.SET_VEHICLE_MOD(vehicle, 27, mods['Trim Design'], false)
VEHICLE.SET_VEHICLE_MOD(vehicle, 28, mods['Ornaments'], false)
VEHICLE.SET_VEHICLE_MOD(vehicle, 28, mods['Ornaments'], false)
VEHICLE.SET_VEHICLE_MOD(vehicle, 30, mods['Dial Design'], false)
VEHICLE.SET_VEHICLE_MOD(vehicle, 33, mods['Steering Wheel'], false)
VEHICLE.SET_VEHICLE_MOD(vehicle, 34, mods['Shifter Leavers'], false)
VEHICLE.SET_VEHICLE_MOD(vehicle, 35, mods['Plaques'], false)
VEHICLE.SET_VEHICLE_MOD(vehicle, 36, mods['Hydraulics'], false)
VEHICLE.SET_VEHICLE_MOD(vehicle, 48, mods['Livery'], false)

-- toggle 
VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 17, mods.Toggles.UNK17)
-- typo here in the jackz json spec btw, not my fault :|
VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 18, mods.Toggles['Turbo Turning'])
VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 19, mods.Toggles['UNK19'])
VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 20, mods.Toggles['Tire Smoke'])
VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 21, mods.Toggles['UNK21'])
VEHICLE.TOGGLE_VEHICLE_MOD(vehicle, 22, mods.Toggles['Xenon Headlights'])
-------
VEHICLE.SET_VEHICLE_TYRES_CAN_BURST(vehicle, not sd['Bulletproof Tires'])
VEHICLE.SET_VEHICLE_DIRT_LEVEL(vehicle, sd['Dirt Level'])
VEHICLE.SET_VEHICLE_WINDOW_TINT(vehicle, sd['Window Tint'])
VEHICLE._SET_VEHICLE_DASHBOARD_COLOR(vehicle, sd['Dashboard Color'])
for i=10, 11 do 
    VEHICLE.SET_VEHICLE_EXTRA(vehicle, i, not sd.Extras[i])
end
-- lights
VEHICLE._SET_VEHICLE_INTERIOR_COLOR(vehicle, sd['Interior Color'])
VEHICLE._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 0, sd.Lights.Neon.Left)
VEHICLE._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 1, sd.Lights.Neon.Right)
VEHICLE._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 2, sd.Lights.Neon.Front)
VEHICLE._SET_VEHICLE_NEON_LIGHT_ENABLED(vehicle, 3, sd.Lights.Neon.back)
VEHICLE._SET_VEHICLE_NEON_LIGHTS_COLOUR(vehicle, sd.Lights.Neon.Color.r, sd.Lights.Neon.Color.g, sd.Lights.Neon.Color.b) 
VEHICLE._SET_VEHICLE_XENON_LIGHTS_COLOR(vehicle, sd.Lights['Xenon Color'])
VEHICLE.SET_VEHICLE_ENGINE_ON(vehicle, sd['Engine Running'], true, false) 
-- colors 
local colors = sd.Colors
-- why is there a custom rgb color in the "vehicle" colors but also in both primary and secondary fields? what is the point?
VEHICLE.SET_VEHICLE_COLOURS(vehicle, colors.Vehicle.Primary, colors.Vehicle.Secondary)
if colors.Primary.Custom then 
    VEHICLE.SET_VEHICLE_CUSTOM_PRIMARY_COLOUR(vehicle, colors.Primary['Custom Color'].r, colors.Primary['Custom Color'].g, colors.Primary['Custom Color'].b)
end
if colors.Secondary.Custom then 
    VEHICLE.SET_VEHICLE_CUSTOM_SECONDARY_COLOUR(vehicle, colors.Secondary['Custom Color'].r, colors.Secondary['Custom Color'].g, colors.Secondary['Custom Color'].b)
end
VEHICLE.SET_VEHICLE_EXTRA_COLOURS(vehicle, colors.Extras.pearlescent, colors.Extras.wheel)
VEHICLE.SET_VEHICLE_ENVEFF_SCALE(vehicle, colors['Paint Fade'])
VEHICLE.SET_VEHICLE_NUMBER_PLATE_TEXT(vehicle, "LANCE")
end

function json_load_vehicle(path)
local all_entities = {}
local success = false
local fp = io.open(path, "r")
if not fp then 
    util.toast("错误打开 " .. path)
    return 
end
local json_string = fp:read("*all")
local json_tbl = lunajson.decode(json_string)
local base = json_tbl.base
local v_hash = base.model
request_model_load(v_hash)
local c = players.get_position(players.user())
local initial_vehicle = entities.create_vehicle(v_hash, c, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
all_entities[#all_entities + 1] = initial_vehicle
json_preprocess_vehicle(initial_vehicle, base, initial_vehicle)
for k,o in pairs(json_tbl.objects) do 
    all_entities[#all_entities + 1] = o
    request_model_load(o.model) 
    local this_obj = entities.create_object(o.model, c)
    ENTITY.SET_ENTITY_VISIBLE(this_obj, o.visible, 0)
    ENTITY.ATTACH_ENTITY_TO_ENTITY(this_obj, initial_vehicle, 0, o.offset.x, o.offset.y, o.offset.z, o.rotation.x, o.rotation.y, o.rotation.z, true, false, true, false, 2, true)
end

if json_tbl.vehicles ~= nil then 
    for k,veh in pairs(json_tbl.vehicles) do 
        all_entities[#all_entities + 1] = veh
        local v_hash = veh.model
        local this_veh = entities.create_vehicle(v_hash, c, ENTITY.GET_ENTITY_HEADING(players.user_ped()))
        json_preprocess_vehicle(this_veh, veh, initial_vehicle)
    end
end

--if json_tbl.peds ~= nil then
--    for k,ped in pairs(json_tbl.peds) do
--
--    end
--end

success = true 
if success then
    PED.SET_PED_INTO_VEHICLE(players.user_ped(), initial_vehicle, -1)
    local this_veh_root = menu.list(loaded_vehicles_root, path:gsub(vehicles_dir, ''), {"lancespoonerv" .. initial_vehicle}, "")

    local this_blip = HUD.ADD_BLIP_FOR_ENTITY(initial_vehicle)
    HUD.SET_BLIP_SPRITE(this_blip, 77)
    HUD.SET_BLIP_COLOUR(this_blip, 47)

    menu.action(this_veh_root, "删除", {"deletelancespoonerv" .. initial_vehicle}, "删除此载具。让它停止存在。", function(on_click)
        for k,v in pairs(all_entities) do
            entities.delete(v)
        end
        menu.delete(this_veh_root)
        util.remove_blip(this_blip)
    end)

        menu.action(this_veh_root, "传送到里面", {"teleportemenyoov" .. initial_vehicle}, "", function(on_click)
            PED.SET_PED_INTO_VEHICLE(PLAYER.PLAYER_PED_ID(), initial_vehicle, -1)
        end)

    else
        util.toast("有些糟糕的事情发生了!无法正确加载此INI。很抱歉 :'(")
    end
end

menu.set_visible(v_search_results_action, false)
menu.set_visible(m_search_results_action, false)

util.keep_running()