--[[
    example use of JSlangLib:

    LOADING_SCRIPT = true

    -- needs to be a global
    LANG_SETTINGS = {}

    -- if the lib should generate a template.lua in your LANG_DIR for translation templates on startup, this will log all the menu options, and after the main script had loaded the lib will check your STRING_FILES for unregistered strings
    LANG_SETTINGS.GENERATE_TEMPLATE = true

    -- the dir lang files are stored in
    LANG_SETTINGS.LANG_DIR = filesystem.store_dir() .. 'JerryScript\\Language\\'

    -- files to search for JSlang.toast and JSlang.str_trans in when generating a template
    LANG_SETTINGS.STRING_FILES = {
        filesystem.scripts_dir() ..'JerryScript.lua',
    }

    -- what you call of the variable that contains the scripts lang functions
    LANG_SETTINGS.VAR_NAME = 'JSlang'

    -- make this a local if you only have one file
    local JSlang = require 'JSlangLib'

    -- insert script code

    LOADING_SCRIPT = false
]]

local GENERATE_TEMPLATE = LANG_SETTINGS.GENERATE_TEMPLATE
local LANG_DIR = LANG_SETTINGS.LANG_DIR
local STRING_FILES = LANG_SETTINGS.STRING_FILES
local VAR_NAME = LANG_SETTINGS.VAR_NAME

if not LANG_SETTINGS then
    util.toast('You have to define the LANG_SETTINGS table in your main script in order to use JSlangLib')
    return
end

if not filesystem.is_dir(LANG_DIR) then
    filesystem.mkdirs(LANG_DIR)
end

local function getPathPart(fullPath, remove)
    local path = string.sub(fullPath, #remove + 1)
    return string.gsub(path, '.lua', '')
end
util.create_thread(function()

    --wait for all lang labels to get registered when loading the script to avoid errors when registering translations for those labels
    while LOADING_SCRIPT do
        util.yield_once()
    end

    local lang_load = util.current_time_millis()

    for _, profilePath in pairs(filesystem.list_files(LANG_DIR)) do
        if not string.contains(profilePath, 'template') then
            util.require_no_lag(getPathPart(profilePath, filesystem.scripts_dir()))
        end
    end

    util.log('Loaded lang files in '.. util.current_time_millis() - lang_load ..' ms.')
end)

--add lang functions
local JSlang = {}

function JSlang.trans(txt)
    if txt == nil or #txt < 1 then return '' end

    local label = lang.find(txt)
    if label == 0 then
        label = lang.register(txt)
    end
    return label
end

local function readAll(file)
    local f = assert(io.open(file, 'rb'))
    local content = f:read('*all')
    f:close()
    return content
end

if GENERATE_TEMPLATE then

    if not filesystem.exists(LANG_DIR .. 'template.lua') then
        local f = assert(io.open(LANG_DIR .. 'template.lua', 'a'))
        f:write('lang.set_translate(\'\') --insert lang code here e.x. fr en or de\n\nlocal f = lang.find\nlocal t = lang.translate\n\n')
        f:close()
    end

    function JSlang.trans(txt)
        if txt == nil or #txt < 1 then return '' end

        local label = lang.find(txt, 'en')
        if label == 0 then
            local f = assert(io.open(LANG_DIR .. 'template.lua', 'a'))
            local fileTxt = string.gsub(txt, '\'', '\\\'')
            fileTxt = string.gsub(fileTxt, '\n', '\\n')
            fileTxt = string.gsub(fileTxt, '\\\\', '\\')
            f:write('t(f(\''.. fileTxt ..'\'), \'\')' ..'\n')
            f:close()

            label = lang.register(txt)
        end
        return label
    end
end

-- register strings that aren't in menu options
local registeredStrings = {}
for _, filePath in pairs(STRING_FILES) do
    local script_file = readAll(filePath)


    for text in string.gmatch(script_file, VAR_NAME ..'.toast%(.-%)') do
        text = string.gsub(text, VAR_NAME ..'.toast%(.', '')
        text = string.gsub(text, '\'%)', '')
        text = string.gsub(text, '"%)', '')
        text = string.gsub(text, '\\\'', '\'')
        text = string.gsub(text, '\\"', '\"')
        text = string.gsub(text, '\\\n', '\n')
        if registeredStrings[text] == nil then
            registeredStrings[text] = true
            JSlang.trans(text)
        end
    end

    for text in string.gmatch(script_file, VAR_NAME ..'.str_trans%(.-%)') do
        text = string.gsub(text, VAR_NAME ..'.str_trans%(.', '')
        text = string.gsub(text, '\'%)', '')
        text = string.gsub(text, '"%)', '')
        text = string.gsub(text, '\\\'', '\'')
        text = string.gsub(text, '\\"', '\"')
        text = string.gsub(text, '\\\n', '\n')
        if registeredStrings[text] == nil then
            registeredStrings[text] = true
            JSlang.trans(text)
        end
    end

end

function JSlang.str_trans(string)
    return lang.get_string(JSlang.trans(string), lang.get_current())
end

function JSlang.toast(string, ...)
    util.toast(JSlang.str_trans(string), ...)
end

function JSlang.log(string)
    util.log(JSlang.str_trans(string))
end

function JSlang.list(root, name, tableCommands, description, ...)
    return menu.list(root, JSlang.trans(name), if tableCommands then tableCommands else {}, JSlang.trans(description), ...)
end

function JSlang.action(root, name, tableCommands, description, ...)
    return menu.action(root, JSlang.trans(name), tableCommands, JSlang.trans(description), ...)
end

function JSlang.toggle(root, name, tableCommands, description, ...)
    return menu.toggle(root, JSlang.trans(name), tableCommands, JSlang.trans(description), ...)
end

function JSlang.toggle_loop(root, name, tableCommands, description, ...)
    return menu.toggle_loop(root, JSlang.trans(name), tableCommands, JSlang.trans(description), ...)
end

function JSlang.slider(root, name, tableCommands, description, ...)
    return menu.slider(root, JSlang.trans(name), tableCommands, JSlang.trans(description), ...)
end

function JSlang.slider_float(root, name, tableCommands, description, ...)
    return menu.slider_float(root, JSlang.trans(name), tableCommands, JSlang.trans(description), ...)
end

function JSlang.click_slider(root, name, tableCommands, description, ...)
    return menu.click_slider(root, JSlang.trans(name), tableCommands, JSlang.trans(description), ...)
end

function JSlang.click_slider_float(root, name, tableCommands, description, ...)
    return menu.click_slider_float(root, JSlang.trans(name), tableCommands, JSlang.trans(description), ...)
end

function JSlang.list_select(root, name, tableCommands, description, ...)
    return menu.list_select(root, JSlang.trans(name), tableCommands, JSlang.trans(description), ...)
end

function JSlang.list_action(root, name, tableCommands, description, ...)
    return menu.list_action(root, JSlang.trans(name), tableCommands, JSlang.trans(description), ...)
end

function JSlang.text_input(root, name, tableCommands, description, ...)
    return menu.text_input(root, JSlang.trans(name), tableCommands, JSlang.trans(description), ...)
end

function JSlang.colour(root, name, tableCommands, description, ...)
    return menu.colour(root, JSlang.trans(name), tableCommands, JSlang.trans(description), ...)
end

-- menu.rainbow(int colour_command)

function JSlang.divider(root, name)
    return menu.divider(root, JSlang.trans(name))
end

function JSlang.hyperlink(root, name, link, description)
    return menu.hyperlink(root, JSlang.trans(name), link, JSlang.trans(description))
end

function JSlang.action_slider(root, name, link, description, ...)
    return menu.action_slider(root, JSlang.trans(name), link, JSlang.trans(description), ...)
end

function JSlang.slider_text(root, name, tableCommands, description, ...)
    return menu.slider_text(root, JSlang.trans(name), tableCommands, JSlang.trans(description), ...)
end

return JSlang
