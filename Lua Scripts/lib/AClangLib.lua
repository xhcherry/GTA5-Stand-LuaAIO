--all credits to Jerry123 for the lang lib just renamed



LOADING_SCRIPT = true
    LANG_SETTINGS = {}
    LANG_SETTINGS.GENERATE_TEMPLATE = false
    LANG_SETTINGS.LANG_DIR = filesystem.store_dir() .. 'AcjokerScript\\Languages\\'
    LANG_SETTINGS.STRING_FILES = {
        filesystem.scripts_dir() ..'AcjokerScript.lua',
    }
    LANG_SETTINGS.VAR_NAME = 'AClang'

local GENERATE_TEMPLATE = LANG_SETTINGS.GENERATE_TEMPLATE
local LANG_DIR = LANG_SETTINGS.LANG_DIR
local STRING_FILES = LANG_SETTINGS.STRING_FILES
local VAR_NAME = LANG_SETTINGS.VAR_NAME

if not LANG_SETTINGS then
    util.toast('You have to define the LANG_SETTINGS table in your main script in order to use AClangLib')
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
    while LOADING_SCRIPT do
        util.yield_once()
    end

    local lang_load = util.current_time_millis()

    for _, profilePath in pairs(filesystem.list_files(LANG_DIR)) do
        if string.find(profilePath, 'template') == nil and string.find(profilePath, 'translated') == nil and string.find(profilePath, 'result') == nil  then
            util.require_no_lag(getPathPart(profilePath, filesystem.scripts_dir()))
        end
    end

    util.log('Loaded ACJlang files in '.. util.current_time_millis() - lang_load ..' ms.')
end)

local AClang = {}

function AClang.trans(txt)
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

    function AClang.trans(txt)
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
            AClang.trans(text)
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
            AClang.trans(text)
        end
    end

end

function AClang.str_trans(string)
    return lang.get_string(AClang.trans(string), lang.get_current())
end

function AClang.toast(string)
    util.toast(AClang.str_trans(string))
end

function AClang.list(root, name, tableCommands, description, ...)
    return menu.list(root, AClang.trans(name), tableCommands, AClang.trans(description), ...)
end

function AClang.action(root, name, tableCommands, description, ...)
    return menu.action(root, AClang.trans(name), tableCommands, AClang.trans(description), ...)
end

function AClang.toggle(root, name, tableCommands, description, ...)
    return menu.toggle(root, AClang.trans(name), tableCommands, AClang.trans(description), ...)
end

function AClang.toggle_loop(root, name, tableCommands, description, ...)
    return menu.toggle_loop(root, AClang.trans(name), tableCommands, AClang.trans(description), ...)
end

function AClang.slider(root, name, tableCommands, description, ...)
    return menu.slider(root, AClang.trans(name), tableCommands, AClang.trans(description), ...)
end

function AClang.slider_float(root, name, tableCommands, description, ...)
    return menu.slider_float(root, AClang.trans(name), tableCommands, AClang.trans(description), ...)
end

function AClang.click_slider(root, name, tableCommands, description, ...)
    return menu.click_slider(root, AClang.trans(name), tableCommands, AClang.trans(description), ...)
end

function AClang.click_slider_float(root, name, tableCommands, description, ...)
    return menu.click_slider_float(root, AClang.trans(name), tableCommands, AClang.trans(description), ...)
end

function AClang.list_select(root, name, tableCommands, description, ...)
    return menu.list_select(root, AClang.trans(name), tableCommands, AClang.trans(description), ...)
end

function AClang.list_action(root, name, tableCommands, description, ...)
    return menu.list_action(root, AClang.trans(name), tableCommands, AClang.trans(description), ...)
end

function AClang.text_input(root, name, tableCommands, description, ...)
    return menu.text_input(root, AClang.trans(name), tableCommands, AClang.trans(description), ...)
end

function AClang.colour(root, name, tableCommands, description, ...)
    return menu.colour(root, AClang.trans(name), tableCommands, AClang.trans(description), ...)
end

-- menu.rainbow(int colour_command)

function AClang.divider(root, name)
    return menu.divider(root, AClang.trans(name))
end

function AClang.hyperlink(root, name, link, description)
    return menu.hyperlink(root, AClang.trans(name), link, AClang.trans(description))
end

function AClang.action_slider(root, name, link, description, ...)
    return menu.action_slider(root, AClang.trans(name), link, AClang.trans(description), ...)
end

function AClang.slider_text(root, name, tableCommands, description, ...)
    return menu.slider_text(root, AClang.trans(name), tableCommands, AClang.trans(description), ...)
end

LOADING_SCRIPT = false

return AClang


