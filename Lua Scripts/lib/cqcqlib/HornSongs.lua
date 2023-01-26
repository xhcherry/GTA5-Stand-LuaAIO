-- HornSongs
-- by Hexarobi
-- Install in `Stand/Lua Scripts`

local SCRIPT_NAME = "HornSongs"
local SCRIPT_VERSION = "1.2"
local SOURCE_URL = "https://github.com/hexarobi/stand-lua-hornsongs"
local AUTO_UPDATE_HOST = "raw.githubusercontent.com"
local AUTO_UPDATE_PATH = "/hexarobi/stand-lua-hornsongs/main/HornSongs.lua"

util.require_natives(1660775568)
C_PAD={
    ["_SET_CONTROL_NORMAL"]=--[[BOOL (bool)]] function(--[[int]] padIndex,--[[int]] control,--[[float]] amount)native_invoker.begin_call();native_invoker.push_arg_int(padIndex);native_invoker.push_arg_int(control);native_invoker.push_arg_float(amount);native_invoker.end_call("E8A25867FBA3B05E");return native_invoker.get_return_value_bool();end,
}
local pitch_map = {
    rest = 0,
    C = 16,
    D = 17,
    E = 18,
    F = 19,
    G = 20,
    A = 21,
    B = 22,
    C2 = 23,
}

local rest = 0

local double = 2
local whole = 1
local half = 0.5
local quarter = 0.25
local eighth = 0.125
local sixteenth = 0.0625

local MOD_HORN = 14

local horn_on = false

local script_store_dir = filesystem.store_dir() .. SCRIPT_NAME .. '\\'
if not filesystem.is_dir(script_store_dir) then
    filesystem.mkdirs(script_store_dir)
end

local function join_path(parent, child)
    local sub = parent:sub(-1)
    if sub == "/" or sub == "\\" then
        return parent .. child
    else
        return parent .. "/" .. child
    end
end

---
--- Play Music
---

local function get_note(note)
    if type(note) ~= "table" then
        note = {pitch=note}
    end
    if type(note.pitch) ~= "number" then
        note.pitch = pitch_map[note.pitch]
    end
    if note.length == nil then
        note.length = quarter
    end
    return note
end

local function play_note(vehicle, song, note, index)
    note = get_note(note)
    local note_playtime = math.floor(song.beat_length * note.length)
    if note.pitch ~= rest then
        horn_on = true
        --VEHICLE.START_VEHICLE_HORN(vehicle, note_delay, util.joaat("HELDDOWN"), false)
    end
    util.yield(note_playtime)
    horn_on = false
    -- Que up pitch for next note
    if song.notes[index+1] ~= nil then
        local next_note = get_note(song.notes[index+1])
        if next_note.pitch ~= rest then
            VEHICLE.SET_VEHICLE_MOD(vehicle, MOD_HORN, next_note.pitch)
        end
    end
    util.yield(song.beat_length - note_playtime)
    end

local function play_song(song)
    song.beat_length = math.floor(60000 / song.bpm)
    if not PED.IS_PED_IN_ANY_VEHICLE(PLAYER.PLAYER_PED_ID(), true) then
        util.toast("除非在车内，否则不能播放")
        return
    end
    local vehicle = PED.GET_VEHICLE_PED_IS_IN(PLAYER.PLAYER_PED_ID(), false)
    if vehicle then
        local original_horn = VEHICLE.GET_VEHICLE_MOD(vehicle, MOD_HORN)
        play_note(vehicle, song, rest, 0)
        for index, note in pairs(song.notes) do
            play_note(vehicle, song, note, index)
        end
        VEHICLE.SET_VEHICLE_MOD(vehicle, MOD_HORN, original_horn)
    end
end

---
--- Songs Menu
---

local songs_menu = menu.list(HornSongsCq, "播放歌曲")

local status, json = pcall(require, "Musicjson")
local function load_song_from_file(filepath)
    local file = io.open(filepath, "r")
    if file then
        local data = json.decode(file:read("*a"))
        if not data.target_version then
            util.toast("无效的歌曲文件格式。缺少target_version.")
            return nil
        end
        file:close()
        return data
    else
        error("无法读取文件 '" .. filepath .. "'")
    end
end

local function load_songs(directory)
    local loaded_songs = {}
    for _, filepath in ipairs(filesystem.list_files(directory)) do
        local _, filename, ext = string.match(filepath, "(.-)([^\\/]-%.?([^%.\\/]*))$")
        if not filesystem.is_dir(filepath) and ext == "horn" then
            table.insert(loaded_songs, load_song_from_file(filepath))
        end
    end
    return loaded_songs
end

local songs_dir = join_path(script_store_dir, "songs")
songs = load_songs(songs_dir)
for _, song in pairs(songs) do
    menu.action(songs_menu, "播放 "..song.name, {}, song.description .. "\nBPM: " .. song.bpm, function()
        play_song(song)
    end)
end


util.create_tick_handler(function()
    if horn_on then
        C_PAD._SET_CONTROL_NORMAL(0, 86, 1)
    end
    return true
end)