--Adapted version 110.6[stand]
local STOREDIR = filesystem.store_dir()
local LOADOUTDIR = STOREDIR .. "SakuraScript\\SakuraConfig\\loadouts\\"
local LIBDIR = filesystem.scripts_dir() .. "lib\\SakuraScript\\CustomWeapon\\"
local do_autoload = false
local wpcmpTable = {}
local weapons_table = {}
if filesystem.exists(LIBDIR .. "weaponlist.lua") then
    wpcmpTable = require("lib.SakuraScript.CustomWeapon.weaponlist")
    weapons_table = util.get_weapons()
else
    util.toast("您没有正确安装资源" .. LIBDIR .. " directory")
    util.stop_script()
end
local attachments_dict = wpcmpTable[1]
local liveries_dict = wpcmpTable[2]
if not filesystem.exists(LOADOUTDIR) then
    filesystem.mkdirs(LOADOUTDIR)
end

function getSPMPname(weapon)
    local weapon_name = util.get_label_text(weapon.label_key)
    local weapon_hash = weapon.hash
    switch weapon_hash do
        case 911657153:
        case 1834241177:
            weapon_name = weapon_name .. " (SP)"
            break
        case -22923932:
        case 1171102963:
            weapon_name = weapon_name .. " (MP)"
    end
    return weapon_name
end

function update_ListActionOptions(saved_loadouts, filename)
    local List_tbl = {}
    for i, path in ipairs(saved_loadouts) do
        local newname = {}
        newname[1] = i
        newname[2] = path
        List_tbl[i] = newname
    end
    select_loadout:setListActionOptions(List_tbl)--更新选择配置
    --选中更新后的配置
    for i, path in ipairs(List_tbl) do
        if path[2] == filename then
            select_loadout.value = i
        end
    end
    --select_loadout.value = table.contains(select_loadout, filename)--更新后选择配置
end

menu.action(weapon_save,"保存配置", {"saveloadout"}, "保存所有当前装备的武器及其附件和外观定制",function(click_type)
        menu.show_command_box_click_based(click_type, "saveloadout ")
    end,function(filename)
        local forbidden_chars = {'<', '>', ':', '\"', '/', '\\', '|', '?', '*'} -- at least SOME safety here.. idk, some people are weird
        for v, char in pairs(forbidden_chars) do
            if filename:contains(char) then
                util.toast("名称包含禁止使用的字符,请另选一个")
                return
            end
        end

        local charS,charE = "   ","\n"
        local player = players.user_ped()
        local file = io.open(LOADOUTDIR .. filename .. ".lua", "wb")
        file:write("return {" .. charE)
        local num_weapons = 0
        for _, weapon in weapons_table do
            local weapon_hash = weapon.hash

            if WEAPON.HAS_PED_GOT_WEAPON(player, weapon_hash, false) then
                num_weapons = num_weapons + 1
                if num_weapons > 1 then
                    file:write("," .. charE)
                end
                file:write(charS .. "[" .. weapon_hash .. "] = ")
                local num_attachments = 0
                for attachment_hash, __ in attachments_dict do
                    if WEAPON.DOES_WEAPON_TAKE_WEAPON_COMPONENT(weapon_hash, attachment_hash) and WEAPON.HAS_PED_GOT_WEAPON_COMPONENT(player, weapon_hash, attachment_hash) then
                        num_attachments = num_attachments + 1
                        if num_attachments == 1 then
                            file:write("{")
                            file:write(charE .. charS .. charS .. "[\"attachments\"] = {")
                        else
                            file:write(",")
                        end
                        file:write(charE .. charS .. charS .. charS .. "[" .. num_attachments .. "] = " .. attachment_hash)
                    end
                end
                local cur_tint = WEAPON.GET_PED_WEAPON_TINT_INDEX(player, weapon_hash)
                if num_attachments > 0 then
                    file:write(charE .. charS .. charS .. "},")
                else
                    file:write("{")
                end
                file:write(charE .. charS .. charS .. "[\"tint\"] = " .. cur_tint)
                --- Livery
                for livery_hash, __ in liveries_dict do
                    if WEAPON.HAS_PED_GOT_WEAPON_COMPONENT(player, weapon_hash, livery_hash) then
                        local colour = WEAPON.GET_PED_WEAPON_COMPONENT_TINT_INDEX(player, weapon_hash, livery_hash)
                        file:write("," .. charE .. charS .. charS .. "[\"livery\"] = {")
                        file:write(charE .. charS .. charS .. charS .. "[\"hash\"] = " .. livery_hash .. ",")
                        file:write(charE .. charS .. charS .. charS .. "[\"colour\"] = " .. colour)
                        file:write(charE .. charS .. charS .. "}")
                        break
                    end
                end
                file:write(charE .. charS .. "}")
            end
        end
        file:write(charE .. "}")
        file:close()
        util.toast("配置另存为 " .. filename)
        update_saved_loadouts()--更新一次保存的武器
        update_ListActionOptions(saved_loadouts, filename)--更新选择配置
    end
)

saved_loadouts = {}
function update_saved_loadouts()
    saved_loadouts = {}
    for i, path in ipairs(filesystem.list_files(LOADOUTDIR)) do
        local loadout_info = read_fileinfo(path)
        saved_loadouts[#saved_loadouts+1] = loadout_info.name
    end
    if #saved_loadouts == 0 then
        saved_loadouts = {"无配置"}
    end
end
update_saved_loadouts()

function menu_list_select(saved_loadouts)
    local List_tbl = {}
    for i, path in ipairs(saved_loadouts) do
        local newname = {}
        newname[1] = i
        newname[2] = path
        List_tbl[i] = newname
    end
    return List_tbl
end
select_loadout = menu.list_select(weapon_save,"选择配置", {}, "选择要使用的武器配置", menu_list_select(saved_loadouts), 1, function () end)
    function fileread(filepath, method, rtype)
    if filesystem.exists(filepath) then
        local file = io.open(filepath, method)
        local data = file:read(rtype)--'*all'从当前位置读取整个文件
        file:close()
        return data
    end
end

----加载武器
function load_weapon()
    local selected_loadout = saved_loadouts[select_loadout.value]
    local loadout_path = LOADOUTDIR .. selected_loadout .. ".lua"
    if filesystem.exists(loadout_path) then
        local player = players.user_ped()
        WEAPON.REMOVE_ALL_PED_WEAPONS(player, false)
        WEAPON.SET_CAN_PED_SELECT_ALL_WEAPONS(player, true)
        local loadout = dofile(filesystem.store_dir() .."SakuraScript/SakuraConfig/loadouts/" .. selected_loadout .. ".lua")
        --require("store.SakuraConfig.loadouts." .. selected_loadout)
        for w_hash, attach_dict in loadout do
            WEAPON.GIVE_WEAPON_TO_PED(player, w_hash, 9999, false, false)
            WEAPON.SET_PED_AMMO(player, w_hash, 9999, false)--补充弹药不完全(MK2卡宾步枪,)
            if attach_dict.attachments ~= nil then
                for _, hash in attach_dict.attachments do
                    WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(player, w_hash, hash)
                end
            end

            WEAPON.SET_PED_WEAPON_TINT_INDEX(player, w_hash, attach_dict.tint)
            if attach_dict.livery ~= nil then
                WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(player, w_hash, attach_dict.livery.hash)
                WEAPON.SET_PED_WEAPON_COMPONENT_TINT_INDEX(player, w_hash, attach_dict.livery.hash, attach_dict.livery.colour)
            end
        end
        regen_menu()
        --补充所有弹药
        --menu.trigger_commands("fillammo")
        util.toast(selected_loadout .. "配置已加载")
    else
        util.toast("这个配置似乎不存在*_*")
    end
end

    menu.action(weapon_save,"加载配置", {}, "装备您选择的武器",function()
        load_weapon()
    end)
    menu.action(weapon_save,"打开配置文件夹", {}, "",function()
        local path = filesystem.store_dir() .."SakuraScript/SakuraConfig/loadouts/"
        util.open_folder(path)
    end)


    menu.toggle(weapon_save,"自动加载", {}, "当加入新战局时自动装备所选配置",function(on)
        do_autoload = on
    end)
    util.on_transition_finished(function ()
        if do_autoload then
            util.yield(1500)
            load_weapon()
            util.toast("加载成功")
        end
    end)



from_scratch = menu.action(weapon_save,"删除武器", {}, "删除您当前所有的武器",function()
    WEAPON.REMOVE_ALL_PED_WEAPONS(players.user_ped(), false)
    regen_menu()
    util.toast("武器已被清除")
end)


menu.divider(weapon_save,"编辑武器")

function regen_menu()
    for _, weapon in weapons_table do
        if weapons_action[weapon.hash] ~= nil and weapons_action[weapon.hash]:isValid() then
            weapons_action[weapon.hash]:delete()
        end
    end
    weapons_action = {}
    attachments_action = {}
    weapon_deletes = {}
    cosmetics_list = {}
    tints_slider = {}
    livery_action_divider = {}
    livery_actions = {}
    livery_colour_slider = {}
    livery = {}

    for _, weapon in weapons_table do
        local category = weapon.category
        local weapon_name = getSPMPname(weapon)
        local weapon_hash = weapon.hash
        if WEAPON.HAS_PED_GOT_WEAPON(players.user_ped(), weapon_hash, false) then
            generate_for_new_weapon(category, weapon_name, weapon_hash, false)
        else
            weapons_action[weapon_hash] = categories[category]:action(weapon_name .. " [x]", {}, "配备 " .. weapon_name,
                function()
                    weapons_action[weapon_hash]:delete()
                    equip_weapon(category, weapon_name, weapon_hash)
                end
            )
        end
        WEAPON.ADD_AMMO_TO_PED(players.user_ped(), weapon_hash, 10) --- 如果配备了特殊弹药类型,它应该有一些弹药
    end
end

function equip_comp(weapon_hash, attachment_hash)
    WEAPON.GIVE_WEAPON_COMPONENT_TO_PED(players.user_ped(), weapon_hash, attachment_hash)
end

function equip_weapon(category, weapon_name, weapon_hash)
    WEAPON.GIVE_WEAPON_TO_PED(players.user_ped(), weapon_hash, 10, false, true)
    util.yield(10)
    weapon_deletes[weapon_name] = nil
    generate_for_new_weapon(category, weapon_name, weapon_hash, true)
end

function generate_for_new_weapon(category, weapon_name, weapon_hash, focus)
    weapons_action[weapon_hash] = categories[category]:list(weapon_name, {}, "编辑的附件 " .. weapon_name,function()
            WEAPON.SET_CURRENT_PED_WEAPON(players.user_ped(), weapon_hash, true)
            generate_attachments(category, weapon_name, weapon_hash)
    end)
    if focus then
        weapons_action[weapon_hash]:trigger()
    end
end

function generate_cosmetics(weapon_hash, weapon_name)
    -- clear old cosmetic stuff
    livery_action_divider = {}
    livery_colour_slider = {}
    livery = {}
    tints_slider = {}
    livery_actions = {}

    if cosmetics_list[weapon_hash] ~= nil then
        if cosmetics_list[weapon_hash]:isValid() then
            cosmetics_list[weapon_hash]:delete()
        end
        regenerated_cosmetics = true
    end
    cosmetics_list[weapon_hash] = weapons_action[weapon_hash]:list("外观", {}, "",function()
            local player = players.user_ped()
            local tint_count = WEAPON.GET_WEAPON_TINT_COUNT(weapon_hash)
            local cur_tint = WEAPON.GET_PED_WEAPON_TINT_INDEX(player, weapon_hash)

            if tints_slider[weapon_hash] == nil then
                tints_slider[weapon_hash] = cosmetics_list[weapon_hash]:slider("颜色", {}, "选择适合您的色调 " .. weapon_name.."\n请注意,这可能不适用于所有武器", 0, tint_count - 1, cur_tint, 1,
                    function(change)
                        WEAPON.SET_PED_WEAPON_TINT_INDEX(player, weapon_hash, change)
                    end
                )
            end

            --- livery colour
            local has_liveries = false
            for livery_hash, _ in liveries_dict do
                if WEAPON.DOES_WEAPON_TAKE_WEAPON_COMPONENT(weapon_hash, livery_hash) then
                    has_liveries = true
                    break
                end
            end


            if has_liveries then
                --- get current camo component
                for hash, _ in liveries_dict do
                    if WEAPON.HAS_PED_GOT_WEAPON_COMPONENT(player, weapon_hash, hash) then
                        livery[weapon_hash] = hash
                        break
                    end
                end
                --- livery colour slider
                if livery_colour_slider[weapon_hash] == nil then
                    local cur_ctint_colour = WEAPON.GET_PED_WEAPON_COMPONENT_TINT_INDEX(player, weapon_hash, livery[weapon_hash])
                    if cur_ctint_colour == -1 then cur_ctint_colour = 0 end
                    livery_colour_slider[weapon_hash] = cosmetics_list[weapon_hash]:slider("涂装颜色", {}, "", 0, 31, cur_ctint_colour, 1,
                        function(index)
                            if livery[weapon_hash] == nil then
                                util.toast("你的武器上没有涂装")
                            else
                                WEAPON.SET_PED_WEAPON_COMPONENT_TINT_INDEX(player, weapon_hash, livery[weapon_hash], index)
                            end
                        end
                    )
                end

                if livery_action_divider[weapon_hash] == nil then
                    livery_action_divider[weapon_hash] = cosmetics_list[weapon_hash]:divider("涂装")
                end
                --- livery equip actions
                for livery_hash, label in liveries_dict do
                    if WEAPON.DOES_WEAPON_TAKE_WEAPON_COMPONENT(weapon_hash, livery_hash) and livery_actions[weapon_hash .. livery_hash] == nil then
                        livery_actions[weapon_hash .. livery_hash] = cosmetics_list[weapon_hash]:action(util.get_label_text(label), {}, "",
                            function()
                                if WEAPON.HAS_PED_GOT_WEAPON_COMPONENT(player, weapon_hash, livery_hash) then
                                    WEAPON.REMOVE_WEAPON_COMPONENT_FROM_PED(player, weapon_hash, livery_hash)
                                    livery[weapon_hash] = nil
                                    return
                                end
                                livery[weapon_hash] = livery_hash
                                equip_comp(weapon_hash, livery_hash)
                                WEAPON.SET_PED_WEAPON_COMPONENT_TINT_INDEX(player, weapon_hash, livery[weapon_hash], livery_colour_slider[weapon_hash].value)
                            end
                        )
                    end
                end
            end
        end
    )
end

function generate_attachments(category, weapon_name, weapon_hash)
    if weapon_deletes[weapon_name] == nil then
        weapon_deletes[weapon_name] = weapons_action[weapon_hash]:action("删除 " .. weapon_name, {}, "",
            function()
                WEAPON.REMOVE_WEAPON_FROM_PED(players.user_ped(), weapon_hash)
                cosmetics_list[weapon_hash]:delete()
                cosmetics_list[weapon_hash] = nil
                livery_action_divider[weapon_hash] = nil
                weapons_action[weapon_hash]:delete()

                util.toast(weapon_name .. " 已被删除")
                weapons_action[weapon_hash] = categories[category]:action(weapon_name .. " [x]", {}, "配备 " .. weapon_name,
                    function()
                        for a_key, _ in attachments_action do
                            if string.find(a_key, weapon_hash) ~= nil then
                                attachments_action[a_key] = nil
                            end
                        end
                        menu.delete(weapons_action[weapon_hash])
                        equip_weapon(category, weapon_name, weapon_hash)
                        weapon_deletes[weapon_name] = nil
                    end
                )
                weapons_action[weapon_hash]:focus()
            end
        )
    end

    local has_attachments = false
    for livery_hash, _ in attachments_dict do
        if WEAPON.DOES_WEAPON_TAKE_WEAPON_COMPONENT(weapon_hash, livery_hash) then
            has_attachments = true
            break
        end
    end

    if cosmetics_list[weapon_hash] == nil then
        generate_cosmetics(weapon_hash, weapon_name)
        if has_attachments then
            weapons_action[weapon_hash]:divider("附件")
        end
    end

    for attachment_hash, attachment_label in attachments_dict do
        local attachment_name = util.get_label_text(attachment_label)
        if (WEAPON.DOES_WEAPON_TAKE_WEAPON_COMPONENT(weapon_hash, attachment_hash)) then
            if (attachments_action[weapon_hash .. " " .. attachment_hash] ~= nil) then attachments_action[weapon_hash .. " " .. attachment_hash]:delete() end
            attachments_action[weapon_hash .. " " .. attachment_hash] = weapons_action[weapon_hash]:action(attachment_name, {}, "Equip " .. attachment_name .. " on your " .. weapon_name,
                function()
                    local player = players.user_ped()
                    if WEAPON.HAS_PED_GOT_WEAPON_COMPONENT(player, weapon_hash, attachment_hash) then
                        WEAPON.REMOVE_WEAPON_COMPONENT_FROM_PED(player, weapon_hash, attachment_hash)
                        return
                    end
                    equip_comp(weapon_hash, attachment_hash)
                    if (string.find(attachment_label, "CLIP") ~= nil or string.find(attachment_label, "SHELL") ~= nil) then
                        --- if the type of rounds is changed, the player needs some bullets of the new type to be able to use them
                        WEAPON.ADD_AMMO_TO_PED(player, weapon_hash, 10)
                    end
                end
            )
        end
    end
end








categories = {}
weapons_action = {}
attachments_action = {}
weapon_deletes = {}
cosmetics_list = {}
tints_slider = {}
livery_action_divider = {}
livery_actions = {}
livery_colour_slider = {}
livery = {}
for _, weapon in weapons_table do
    local category = weapon.category
    if categories[category] == nil then
        categories[category] = menu.list(weapon_save, category, {}, "编辑的武器 " .. category .. " 类型")
    end
end
regen_menu()
