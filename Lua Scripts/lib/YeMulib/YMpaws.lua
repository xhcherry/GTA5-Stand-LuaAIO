local animations = {
    jump = {1, 11},
    idle = {14, 18},
    idle_excited = {27, 31},
    sit = {40, 48},
    walk = {53, 57},
    run = {66, 73},
    sniff = {79, 86},
    sniff_and_walk = {92, 99}
}


local anim_names = {"jump", "idle", "idle_excited", "sit", "walk", "run", "sniff", "sniff_and_walk"}

local active_skin = 'regular'
local resources_dir =  filesystem.resources_dir() .. 'YMIMG/YMpaws/'
if not filesystem.is_dir(resources_dir) then
    util.toast("[夜幕提示]缺少资源目录")
    util.stop_script()
end

local skin_folders = {'regular', 'dark'}

local textures = {}
local flipped_textures = {}

local corgi_home_x = 0.02
local max_dist = 0.1
local corgi_x = 0.02
local corgi_y = 0.79
local corgi_dir = 1
local preserve_last_frame = false
local preserve_amt = 100
local cur_frame = 0
local do_bark = true 
local mood = "sit"

YMpaws:toggle("声音", {}, "", function(on)
    do_bark = on
end, true)

YMpaws:slider_float('小狗位置Y', {}, "", -100, 100, 79, 1, function(value)
    corgi_y = value * 0.01
end)

YMpaws:slider_float("小狗位置X", {}, "如果你的小狗离家太远，或者落后于它，他们会纠正他们的路线并返回", -100, 100, 2, 1, function(value)
    corgi_home_x = value * 0.01
    corgi_x = corgi_home_x
end)


YMpaws:slider_float("最远距离地图位置", {}, "", -100, 100, 10, 1, function(value)
    max_dist = value * 0.01
end)


local function move_dog_x(units) 
    if corgi_home_x > corgi_x or corgi_x - corgi_home_x > max_dist then 
        util.draw_debug_text("BOUND")
        corgi_dir = -corgi_dir
    end 

    corgi_x = corgi_x + (corgi_dir == 1 and units or -units)
end


local function update_to_skin(skin_name)
    textures = {}
    local level = resources_dir .. '\\' .. skin_name .. '\\'
    for anim, frames in pairs(animations) do
        for i = frames[1], frames[2] do 
            local prefix = i > 9 and "corgi_" or "corgi_0"
            textures[i] = directx.create_texture(level .. prefix .. i .. '.png')
        end
    end

    for anim, frames in pairs(animations) do
        for i = frames[1], frames[2] do 
            local prefix = i > 9 and "corgi_" or "corgi_0"
            flipped_textures[i] = directx.create_texture(level .. 'flipped_' ..  prefix .. i .. '.png')
        end
    end
end

local function animate_frame()
    if preserve_last_frame and cur_frame == animations[mood][2] then
        util.yield(preserve_amt)
        cur_frame = animations[mood][1]
    else
        cur_frame = (cur_frame % (animations[mood][2] - animations[mood][1] + 1)) + animations[mood][1]
    end
end

YMpaws:list_select("改变小狗类型", {}, "为小狗选择一个皮肤", skin_folders, 1, function(index, value)
    update_to_skin(value)
end)
update_to_skin('regular')

local last_mood = 'walk'

local function playWav(wav)
    local fr = soup.FileReader(wav)
    local wav = soup.audWav(fr)
    local dev = soup.audDevice.getDefault()
    local pb = dev:open(wav.channels)
    local mix = soup.audMixer()
    mix.stop_playback_when_done = true
    mix:setOutput(pb)
    mix:playSound(wav)
    while pb:isPlaying() do util.yield() end
end

local function bark()
    playWav(resources_dir .. '\\bark.wav')
end
util.create_tick_handler(function()
    mood = anim_names[math.random(#anim_names)]
    pluto_switch mood do
        case "jump":
            for _ = 1, 50 do 
                move_dog_x(0.0011)
                local rand = math.random(-3, 3)*0.0001
                util.yield(10)
            end
            --local delay = math.random(1000, 5000)
            --preserve_last_frame = true 
            --preserve_amt = delay
            --util.yield(delay)
            --preserve_last_frame = false 
            mood = 'idle'
            break
        case "walk": 
            for _ = 1, 50 do 
                move_dog_x(0.0003)
                util.yield(10)
            end
            mood = anim_names[math.random(#anim_names)]
            break
        case "sniff_and_walk": 
            for _ = 1, 50 do 
                move_dog_x(0.0003)
                util.yield(10)
            end
            mood = 'idle'
            break
        case "run": 
            for i = 1, 50 do 
                move_dog_x(0.0010)
                util.yield(10)
            end
            mood = anim_names[math.random(#anim_names)]
            break
        case "sit": 
            local delay = math.random(1000, 5000)
            preserve_last_frame = true 
            preserve_amt = delay
            util.yield(delay)
            preserve_last_frame = false
            mood = anim_names[math.random(#anim_names)]
            break
        case "sniff": 
            util.yield(math.random(1000, 5000))
            mood = anim_names[math.random(#anim_names)]
            break
        case "idle": 
            util.yield(math.random(1000, 5000))
            mood = anim_names[math.random(#anim_names)]
            break 
        case "idle_excited": 
            util.yield(math.random(1000, 5000))
            mood = anim_names[math.random(#anim_names)]
            break
            
    end

    if math.random(0, 4) == 3 then 
        corgi_dir = -corgi_dir
    end

    if math.random(0, 6) == 5 then 
        if do_bark then 
            bark()
        end
    end
end)

util.create_tick_handler(function()
    animate_frame()
    util.yield(100)
end)

util.create_tick_handler(function()
    if corgi_dir == 1 then 
        directx.draw_texture(textures[cur_frame], 0.015, 0.015, 0.5, 0.5, corgi_x, corgi_y, 0, {r = 1, g = 1, b = 1, a = 0.999})
    else
        directx.draw_texture(flipped_textures[cur_frame], 0.015, 0.015, 0.5, 0.5, corgi_x, corgi_y, 0, {r = 1, g = 1, b = 1, a = 0.999})
    end
end)


YMpaws:divider('功能作者:Lance')