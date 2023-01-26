-- Undefined
--==============狗白又看你爹脚本是吧
local Utils<const> = require "undefined.utils"

local Player = {}

---@param pid Player
---@return number
function Player.getPlayerWantedLevel(pid)
    return PLAYER.GET_PLAYER_WANTED_LEVEL(pid)
end

---@param pid Player
---@return boolean
function Player.isPlayerNeverWanted(pid)
    local menuRef = menu.ref_by_command_name("bail" .. Player.getPlayerName(pid))
    return players.exists(pid) and menu.is_ref_valid(menuRef) and menu.get_value(menuRef)
end

---@param pid Player
---@param lowercase? boolean
---@param addTags? boolean
---@return string
function Player.getPlayerName(pid, lowercase, addTags)
    local name
    if addTags then
        name = players.get_name_with_tags(pid)
    else
        name = players.get_name(pid)
    end

    if lowercase then
        return string.lower(name)
    end
    return name
end

---@return boolean
function Player.isUserAiming()
    if not util.is_key_down(0x02) then -- right mouse button
        return false
    end

    return true
end

---@param pid? Player
---@return Ped
function Player.getPlayerPed(pid)
    if not pid then
        return players.user_ped()
    end
    return PLAYER.GET_PLAYER_PED(pid)
end

---@return Player
function Player.getUserPlayer()
    return players.user()
end

---@param pid? Player
---@return v3
function Player.getPlayerPosition(pid)
    pid = pid or Player.getUserPlayer()
    return players.get_position(pid)
end

---@param pid? Player
---@return number
function Player.getPlayerRank(pid)
    pid = pid or Player.getUserPlayer()
    return players.get_rank(pid)
end

---@param pid? Player
---@return boolean
function Player.isInInterior(pid)
    pid = pid or Player.getUserPlayer()
    return players.is_in_interior(pid)
end

---@param pid? Player
---@return boolean
function Player.isModder(pid)
    pid = pid or Player.getUserPlayer()
    return players.is_marked_as_modder(pid)
end

---@param pid? Player
---@return boolean
function Player.isDead(pid)
    pid = pid or Player.getUserPlayer()
    return PLAYER.IS_PLAYER_DEAD(pid)
end

---@param pid? Player
---@return boolean
function Player.isOTR(pid)
    pid = pid or Player.getUserPlayer()
    return players.is_otr(pid)
end

---@param pid? Player
---@param shorten? boolean
---@return number | string
function Player.getMoney(pid, shorten)
    pid = pid or Player.getUserPlayer()
    local money = players.get_money(pid)
    if not shorten then
        return money
    end

    local length = string.len(tostring(money))

    if length < 4 then
        return money
    elseif length < 7 then
        return string.format("%.2fK", money / 1000)
    elseif length < 10 then
        return string.format("%.2fM", money / 1000000)
    end

    return string.format("%.2fB", money / 1000000000)
end

---@param pid? Player
---@return number
function Player.getOrgColor(pid)
    pid = pid or Player.getUserPlayer()
    local orgColorIdx = players.get_org_colour(pid)
    if orgColorIdx == -1 then
        return -1
    end

    local r = memory.alloc_int()
    local g = memory.alloc_int()
    local b = memory.alloc_int()
    local a = memory.alloc_int()
    HUD.GET_HUD_COLOUR(orgColorIdx + 192, r, g, b, a)
    local color = {
        r = memory.read_int(r) / 255,
        g = memory.read_int(g) / 255,
        b = memory.read_int(b) / 255,
        a = 1
    }
    return color
end

---@param ped Ped
function Player.burn(ped)
    local pedCoords = ENTITY.GET_ENTITY_COORDS(ped)
    FIRE.ADD_EXPLOSION(pedCoords.x, pedCoords.y, pedCoords.z - 1, 12, 3.0, true, true, 1.0, false)
end

---@param player Player
---@param ped Ped
function Player.cage(player, ped)
    Player.freeze(player, true)
    local pedCoords = ENTITY.GET_ENTITY_COORDS(ped)
    local objHash<const> = util.joaat("prop_gold_cont_01")
    util.request_model(objHash)
    local obj = entities.create_object(objHash, pedCoords)
    ENTITY.FREEZE_ENTITY_POSITION(obj, true)
    util.yield(1000)
    Player.freeze(player, false)
end

---@param player Player
function Player.disarm(player)
    menu.trigger_commands("disarm" .. Player.getPlayerName(player, true))
end

---@param player Player
function Player.kick(player)
    menu.trigger_commands("kick" .. Player.getPlayerName(player, true))
end

---@param player Player
function Player.heal(player)
    menu.trigger_commands("autoheal" .. Player.getPlayerName(player, true))
    util.yield(1000)
    menu.trigger_commands("autoheal" .. Player.getPlayerName(player, true))
end

---@param player Player
---@param enabled boolean
function Player.freeze(player, enabled)
    local value = "off"
    if enabled then
        value = "on"
    end
    menu.trigger_commands("freeze" .. Player.getPlayerName(player, true) .. " " .. value)
end

return Player
