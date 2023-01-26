-- Undefined
--==============狗白又看你爹脚本是吧
local CONSTANTS<const> = require "undefined.constants"

local Utils = {}
math.randomseed(util.current_time_millis())
math.random()
math.random()
math.random()

---@param min? integer
---@param max? integer
---@return number
function Utils.rand(min, max)
    min = min or 0
    max = max or 1
    return math.random(min, max)
end

---@param message string
---@param dontAddScriptName? boolean
function Utils.showToast(message, dontAddScriptName)
    local msg = message
    if not dontAddScriptName then
        msg = "[" .. CONSTANTS.SCRIPT.NAME .. "] " .. msg
    end
    util.toast(msg)
end

---@param commandName? string
---@return string
function Utils.getCommandName(commandName)
    commandName = commandName or ""
    return CONSTANTS.SCRIPT.COMMAND_PREFIX .. commandName
end

---@param message string
function Utils.logToFile(message)
    util.log(CONSTANTS.SCRIPT.NAME .. ": " .. message, 8)
end

---@param addTimeInMs? integer
function Utils.getTime(addTimeInMs)
    local addTimeInMs = addTimeInMs or 0
    return os.millis() + addTimeInMs
end

---@param position v3
---@return v3
function Utils.getGroundZPosition(position)
    local tick = 0
    local success, groundZ = util.get_ground_z(position.x, position.y)
    while not success and tick < 10 do
        util.yield_once()
        success, groundZ = util.get_ground_z(position.x, position.y)
        tick = tick + 1
    end
    if success then
        position.z = groundZ
    end
    return position
end

---@param blip Blip
---@return v3
function Utils.getBlipCoords(blip)
    local pos = HUD.GET_BLIP_COORDS(blip)
    pos = Utils.getGroundZPosition(pos)
    return pos
end

function Utils.emptyFunction()
end

---@param hash string
---@return Hash
function Utils.requestWeaponAsset(hash)
    local weaponHash<const> = util.joaat(hash)
    WEAPON.REQUEST_WEAPON_ASSET(weaponHash, 31, 0)
    while not WEAPON.HAS_WEAPON_ASSET_LOADED(weaponHash) do
        util.yield_once()
    end
    return weaponHash
end

---@param color Color
---@return GameColor
function Utils.convertColorToGame(color)
    return {
        r = math.floor(color.r * 255),
        g = math.floor(color.g * 255),
        b = math.floor(color.b * 255),
        a = math.floor(color.a * 255)
    }
end

-- from GridSpawn
local minimum<const> = memory.alloc()
local maximum<const> = memory.alloc()
local upVector_pointer<const> = memory.alloc()
local rightVector_pointer<const> = memory.alloc()
local forwardVector_pointer<const> = memory.alloc()
local position_pointer<const> = memory.alloc()
function Utils.drawBox(entity, color)
    ENTITY.GET_ENTITY_MATRIX(entity, rightVector_pointer, forwardVector_pointer, upVector_pointer, position_pointer);
    local forward_vector<const> = v3.new(forwardVector_pointer)
    local right_vector<const> = v3.new(rightVector_pointer)
    local up_vector<const> = v3.new(upVector_pointer)

    MISC.GET_MODEL_DIMENSIONS(ENTITY.GET_ENTITY_MODEL(entity), minimum, maximum)
    local minimum_vec<const> = v3.new(minimum)
    local maximum_vec<const> = v3.new(maximum)
    local dimensions<const> = {
        x = maximum_vec.y - minimum_vec.y,
        y = maximum_vec.x - minimum_vec.x,
        z = maximum_vec.z - minimum_vec.z
    }

    local top_right<const> = ENTITY.GET_OFFSET_FROM_ENTITY_IN_WORLD_COORDS(entity, maximum_vec.x, maximum_vec.y, maximum_vec.z)
    local top_right_back<const> = {
        x = forward_vector.x * -dimensions.y + top_right.x,
        y = forward_vector.y * -dimensions.y + top_right.y,
        z = forward_vector.z * -dimensions.y + top_right.z
    }
    local bottom_right_back<const> = {
        x = up_vector.x * -dimensions.z + top_right_back.x,
        y = up_vector.y * -dimensions.z + top_right_back.y,
        z = up_vector.z * -dimensions.z + top_right_back.z
    }
    local bottom_left_back<const> = {
        x = -right_vector.x * dimensions.x + bottom_right_back.x,
        y = -right_vector.y * dimensions.x + bottom_right_back.y,
        z = -right_vector.z * dimensions.x + bottom_right_back.z
    }
    local top_left<const> = {
        x = -right_vector.x * dimensions.x + top_right.x,
        y = -right_vector.y * dimensions.x + top_right.y,
        z = -right_vector.z * dimensions.x + top_right.z
    }
    local bottom_right<const> = {
        x = -up_vector.x * dimensions.z + top_right.x,
        y = -up_vector.y * dimensions.z + top_right.y,
        z = -up_vector.z * dimensions.z + top_right.z
    }
    local bottom_left<const> = {
        x = forward_vector.x * dimensions.y + bottom_left_back.x,
        y = forward_vector.y * dimensions.y + bottom_left_back.y,
        z = forward_vector.z * dimensions.y + bottom_left_back.z
    }
    local top_left_back<const> = {
        x = up_vector.x * dimensions.z + bottom_left_back.x,
        y = up_vector.y * dimensions.z + bottom_left_back.y,
        z = up_vector.z * dimensions.z + bottom_left_back.z
    }

    GRAPHICS.DRAW_LINE(top_right.x, top_right.y, top_right.z, top_right_back.x, top_right_back.y, top_right_back.z, color.r, color.g, color.b, color.a)
    GRAPHICS.DRAW_LINE(top_right.x, top_right.y, top_right.z, top_left.x, top_left.y, top_left.z, color.r, color.g, color.b, color.a)
    GRAPHICS.DRAW_LINE(top_right.x, top_right.y, top_right.z, bottom_right.x, bottom_right.y, bottom_right.z, color.r, color.g, color.b, color.a)
    GRAPHICS.DRAW_LINE(bottom_left_back.x, bottom_left_back.y, bottom_left_back.z, bottom_right_back.x, bottom_right_back.y, bottom_right_back.z, color.r, color.g, color.b,
        color.a)
    GRAPHICS.DRAW_LINE(bottom_left_back.x, bottom_left_back.y, bottom_left_back.z, bottom_left.x, bottom_left.y, bottom_left.z, color.r, color.g, color.b, color.a)
    GRAPHICS.DRAW_LINE(bottom_left_back.x, bottom_left_back.y, bottom_left_back.z, top_left_back.x, top_left_back.y, top_left_back.z, color.r, color.g, color.b, color.a)
    GRAPHICS.DRAW_LINE(top_left_back.x, top_left_back.y, top_left_back.z, top_right_back.x, top_right_back.y, top_right_back.z, color.r, color.g, color.b, color.a)
    GRAPHICS.DRAW_LINE(top_left_back.x, top_left_back.y, top_left_back.z, top_left.x, top_left.y, top_left.z, color.r, color.g, color.b, color.a)
    GRAPHICS.DRAW_LINE(bottom_right_back.x, bottom_right_back.y, bottom_right_back.z, top_right_back.x, top_right_back.y, top_right_back.z, color.r, color.g, color.b, color.a)
    GRAPHICS.DRAW_LINE(bottom_left.x, bottom_left.y, bottom_left.z, top_left.x, top_left.y, top_left.z, color.r, color.g, color.b, color.a)
    GRAPHICS.DRAW_LINE(bottom_left.x, bottom_left.y, bottom_left.z, bottom_right.x, bottom_right.y, bottom_right.z, color.r, color.g, color.b, color.a)
    GRAPHICS.DRAW_LINE(bottom_right_back.x, bottom_right_back.y, bottom_right_back.z, bottom_right.x, bottom_right.y, bottom_right.z, color.r, color.g, color.b, color.a)
end

---@return Player
function Utils.getRandomPlayer()
    local allPlayers = players.list(false)
    local randPid = allPlayers[Utils.rand(1, #allPlayers)]
    return randPid
end

return Utils
