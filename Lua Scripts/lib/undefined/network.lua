-- Undefined
--==============狗白又看你爹脚本是吧
local Utils<const> = require "undefined.utils"

local Network = {}

---@param ped Ped
---@return Player
function Network.getPlayerFromPed(ped)
    return NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(ped)
end

---@param entity Entity
---@return boolean
function Network.requestControlOnce(entity)
    if not NETWORK.NETWORK_IS_IN_SESSION() then
        return true
    end
    local netId = NETWORK.NETWORK_GET_NETWORK_ID_FROM_ENTITY(entity)
    NETWORK.SET_NETWORK_ID_CAN_MIGRATE(netId, true)
    return NETWORK.NETWORK_REQUEST_CONTROL_OF_ENTITY(entity)
end

---@param entity Entity
---@param timeout? integer
---@param dontShowError? boolean
---@return boolean
function Network.requestControl(entity, timeout, dontShowError)
    if not ENTITY.DOES_ENTITY_EXIST(entity) then
        Utils.showToast("实体不存在.")
        return false
    end

    timeout = timeout or 1000
    local endTime = Utils.getTime(timeout)
    while not Network.requestControlOnce(entity) and Utils.getTime() < endTime do
        util.yield_once()
    end

    local success = Utils.getTime() < endTime
    if not success and not dontShowError then
        Utils.showToast("无法访问车辆.")
    end
    return success
end

return Network
