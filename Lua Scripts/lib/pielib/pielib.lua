
util.log("█████████  ███  █████████")
util.log("███   ███  ███  ███      ")
util.log("█████████  ███  █████████")
util.log("███        ███  ███      ")
util.log("███        ███  ███      ")
util.log("███        ███  █████████")

-----钢铁侠
function getOffsetFromCam(dist)
    local pos = CAM.GET_FINAL_RENDERED_CAM_COORD()
    local dir = v3.toDir(CAM.GET_FINAL_RENDERED_CAM_ROT(2))
    local offset = {
        x = pos.x + dir.x * dist,
        y = pos.y + dir.y * dist,
        z = pos.z + dir.z * dist
    }
    return offset
end


---------派遣劫匪
function SetBit(bits, place)
    return (bits | (1 << place))
end
write_global = {
    byte = function(global, value)
        local address = memory.script_global(global)
        memory.write_byte(address, value)
    end,
    int = function(global, value)
        local address = memory.script_global(global)
        memory.write_int(address, value)
    end,
    float = function(global, value)
        local address = memory.script_global(global)
        memory.write_float(address, value)
    end
}
function sendmugger_npc(player_id)
    if NETWORK.NETWORK_IS_SCRIPT_ACTIVE("am_gang_call", 0, true, 0) then
        util.toast("当前劫匪活动还未结束哦")
    else
        local bits_addr = memory.script_global(1853910 + (players.user() * 862 + 1) + 140)
            memory.write_int(bits_addr, SetBit(memory.read_int(bits_addr), 0))
            write_global.int(1853910 + (players.user() * 862 + 1) + 141, player_id)
        util.toast("劫匪已出动")
    end
end