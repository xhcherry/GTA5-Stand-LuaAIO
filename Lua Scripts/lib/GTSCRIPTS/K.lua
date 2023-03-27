local JSkey = {}

----------------------------------
-- System input functions
----------------------------------

local keyLookupTable = {
    ['VK_LBUTTON']              =  0x01,	--Left mouse button
    ['VK_RBUTTON']              =  0x02,	--Right mouse button
    ['VK_CANCEL']               =  0x03,	--Control-break processing
    ['VK_MBUTTON']              =  0x04,	--Middle mouse button (three-button mouse)
    ['VK_XBUTTON1']             =  0x05,	--X1 mouse button
    ['VK_XBUTTON2']             =  0x06,	--X2 mouse button
    -- -	0x07	Undefined
    ['VK_BACK']	                =  0x08,	--BACKSPACE key
    ['VK_TAB']                  =  0x09,	--TAB key
    -- -	0x0A-0B	Reserved
    ['VK_CLEAR']                =  0x0C,	--CLEAR key
    ['VK_RETURN']	            =  0x0D,	--ENTER key
    -- -	0x0E-0F	Undefined
    ['VK_SHIFT']                =  0x10,	--SHIFT key
    ['VK_CONTROL']	            =  0x11,	--CTRL key
    ['VK_MENU']	                =  0x12,	--ALT key
    ['VK_PAUSE']	            =  0x13, 	--PAUSE key
    ['VK_CAPITAL']	            =  0x14,	--CAPS LOCK key
    ['VK_KANA']	                =  0x15, 	--IME Kana mode
    ['VK_HANGUEL']	            =  0x15,	--IME Hanguel mode (maintained for compatibility; use VK_HANGUL)
    ['VK_HANGUL']	            =  0x15,	--IME Hangul mode
    ['VK_IME_ON']	            =  0x16,	--IME On
    ['VK_JUNJA']	            =  0x17,	--IME Junja mode
    ['VK_FINAL']	            =  0x18,	--IME final mode
    ['VK_HANJA']	            =  0x19,	--IME Hanja mode
    ['VK_KANJI']	            =  0x19,	--IME Kanji mode
    ['VK_IME_OFF']	            =  0x1A,	--IME Off
    ['VK_ESCAPE']	            =  0x1B,	--ESC key
    ['VK_CONVERT']	            =  0x1C,	--IME convert
    ['VK_NONCONVERT']           =  0x1D,	--IME nonconvert
    ['VK_ACCEPT']	            =  0x1E,	--IME accept
    ['VK_MODECHANGE']           =  0x1F,	--IME mode change request
    ['VK_SPACE']	            =  0x20,	--SPACEBAR
    ['VK_PRIOR']	            =  0x21,	--PAGE UP key
    ['VK_NEXT']	                =  0x22,	--PAGE DOWN key
    ['VK_END']	                =  0x23,	--END key
    ['VK_HOME']	                =  0x24,	--HOME key
    ['VK_LEFT']	                =  0x25,	--LEFT ARROW key
    ['VK_UP']	                =  0x26,	--UP ARROW key
    ['VK_RIGHT']	            =  0x27,	--RIGHT ARROW key
    ['VK_DOWN']	                =  0x28,	--DOWN ARROW key
    ['VK_SELECT']	            =  0x29,	--SELECT key
    ['VK_PRINT']	            =  0x2A,	--PRINT key
    ['VK_EXECUTE']	            =  0x2B,	--EXECUTE key
    ['VK_SNAPSHOT']	            =  0x2C,	--PRINT SCREEN key
    ['VK_INSERT']	            =  0x2D,	--INS key
    ['VK_DELETE']	            =  0x2E,	--DEL key
    ['VK_HELP']	                =  0x2F,	--HELP key
    ['VK_0']                    =  0x30,	--0 key
    ['VK_1']                    =  0x31,	--1 key
    ['VK_2']                    =  0x32,	--2 key
    ['VK_3']                    =  0x33,	--3 key
    ['VK_4']                    =  0x34,	--4 key
    ['VK_5']                    =  0x35,	--5 key
    ['VK_6']                    =  0x36,	--6 key
    ['VK_7']                    =  0x37,	--7 key
    ['VK_8']                    =  0x38,	--8 key
    ['VK_9']                    =  0x39,	--9 key
    -- -	0x3A-40	Undefined
    ['VK_A']                    =  0x41,	--A key
    ['VK_B']                    =  0x42,	--B key
    ['VK_C']                    =  0x43,	--C key
    ['VK_D']                    =  0x44,	--D key
    ['VK_E']                    =  0x45,	--E key
    ['VK_F']                    =  0x46,	--F key
    ['VK_G']                    =  0x47,	--G key
    ['VK_H']                    =  0x48,	--H key
    ['VK_I']                    =  0x49,	--I key
    ['VK_J']                    =  0x4A,	--J key
    ['VK_K']                    =  0x4B,	--K key
    ['VK_L']                    =  0x4C,	--L key
    ['VK_M']                    =  0x4D,	--M key
    ['VK_N']                    =  0x4E,	--N key
    ['VK_O']                    =  0x4F,	--O key
    ['VK_P']                    =  0x50,	--P key
    ['VK_Q']                    =  0x51,	--Q key
    ['VK_R']                    =  0x52,	--R key
    ['VK_S']                    =  0x53,	--S key
    ['VK_T']                    =  0x54,	--T key
    ['VK_U']                    =  0x55,	--U key
    ['VK_V']                    =  0x56,	--V key
    ['VK_W']                    =  0x57,	--W key
    ['VK_X']                    =  0x58,	--X key
    ['VK_Y']                    =  0x59,	--Y key
    ['VK_Z']                    =  0x5A,	--Z key
    ['VK_LWIN']	                =  0x5B,	--Left Windows key (Natural keyboard)
    ['VK_RWIN']	                =  0x5C,	--Right Windows key (Natural keyboard)
    ['VK_APPS']	                =  0x5D,	--Applications key (Natural keyboard)
    -- -	0x5E	Reserved
    ['VK_SLEEP']	            =  0x5F,	--Computer Sleep key
    ['VK_NUMPAD0']	            =  0x60,	--Numeric keypad 0 key
    ['VK_NUMPAD1']	            =  0x61,	--Numeric keypad 1 key
    ['VK_NUMPAD2']	            =  0x62,	--Numeric keypad 2 key
    ['VK_NUMPAD3']	            =  0x63,	--Numeric keypad 3 key
    ['VK_NUMPAD4']	            =  0x64,	--Numeric keypad 4 key
    ['VK_NUMPAD5']	            =  0x65,	--Numeric keypad 5 key
    ['VK_NUMPAD6']	            =  0x66,	--Numeric keypad 6 key
    ['VK_NUMPAD7']	            =  0x67,	--Numeric keypad 7 key
    ['VK_NUMPAD8']	            =  0x68,	--Numeric keypad 8 key
    ['VK_NUMPAD9']	            =  0x69,	--Numeric keypad 9 key
    ['VK_MULTIPLY']	            =  0x6A,	--Multiply key
    ['VK_ADD']	                =  0x6B,	--Add key
    ['VK_SEPARATOR']            =  0x6C,	--Separator key
    ['VK_SUBTRACT']	            =  0x6D,	--Subtract key
    ['VK_DECIMAL']	            =  0x6E,	--Decimal key
    ['VK_DIVIDE']	            =  0x6F,	--Divide key
    ['VK_F1']	                =  0x70,	--F1 key
    ['VK_F2']	                =  0x71,	--F2 key
    ['VK_F3']	                =  0x72,	--F3 key
    ['VK_F4']	                =  0x73,	--F4 key
    ['VK_F5']	                =  0x74,	--F5 key
    ['VK_F6']	                =  0x75,	--F6 key
    ['VK_F7']	                =  0x76,	--F7 key
    ['VK_F8']	                =  0x77,	--F8 key
    ['VK_F9']	                =  0x78,	--F9 key
    ['VK_F10']	                =  0x79,	--F10 key
    ['VK_F11']	                =  0x7A,	--F11 key
    ['VK_F12']	                =  0x7B,	--F12 key
    ['VK_F13']	                =  0x7C,	--F13 key
    ['VK_F14']	                =  0x7D,	--F14 key
    ['VK_F15']	                =  0x7E,	--F15 key
    ['VK_F16']	                =  0x7F,	--F16 key
    ['VK_F17']	                =  0x80,	--F17 key
    ['VK_F18']	                =  0x81,	--F18 key
    ['VK_F19']	                =  0x82,	--F19 key
    ['VK_F20']	                =  0x83,	--F20 key
    ['VK_F21']	                =  0x84,	--F21 key
    ['VK_F22']	                =  0x85,	--F22 key
    ['VK_F23']	                =  0x86,	--F23 key
    ['VK_F24']	                =  0x87,	--F24 key
    -- -	0x88-8F	Unassigned
    ['VK_NUMLOCK']	            =  0x90,	--NUM LOCK key
    ['VK_SCROLL']	            =  0x91,	--SCROLL LOCK key
    -- 0x92-96	OEM specific
    -- -	0x97-9F	Unassigned
    ['VK_LSHIFT']	            =  0xA0,    --Left SHIFT key
    ['VK_RSHIFT']	            =  0xA1,    --Right SHIFT key
    ['VK_LCONTROL']	            =  0xA2,    --Left CONTROL key
    ['VK_RCONTROL']	            =  0xA3,    --Right CONTROL key
    ['VK_LMENU']	            =  0xA4,    --Left MENU key
    ['VK_RMENU']	            =  0xA5,    --Right MENU key
    ['VK_BROWSER_BACK']	        =  0xA6,	--Browser Back key
    ['VK_BROWSER_FORWARD']	    =  0xA7,	--Browser Forward key
    ['VK_BROWSER_REFRESH']	    =  0xA8,	--Browser Refresh key
    ['VK_BROWSER_STOP']	        =  0xA9,	--Browser Stop key
    ['VK_BROWSER_SEARCH']	    =  0xAA,	--Browser Search key
    ['VK_BROWSER_FAVORITES']	=  0xAB,	--Browser Favorites key
    ['VK_BROWSER_HOME']	        =  0xAC,	--Browser Start and Home key
    ['VK_VOLUME_MUTE']	        =  0xAD,	--Volume Mute key
    ['VK_VOLUME_DOWN']	        =  0xAE,	--Volume Down key
    ['VK_VOLUME_UP']	        =  0xAF,	--Volume Up key
    ['VK_MEDIA_NEXT_TRACK']	    =  0xB0,	--Next Track key
    ['VK_MEDIA_PREV_TRACK']	    =  0xB1,	--Previous Track key
    ['VK_MEDIA_STOP']	        =  0xB2,	--Stop Media key
    ['VK_MEDIA_PLAY_PAUSE']	    =  0xB3,	--Play/Pause Media key
    ['VK_LAUNCH_MAIL']	        =  0xB4,	--Start Mail key
    ['VK_LAUNCH_MEDIA_SELECT']	=  0xB5,	--Select Media key
    ['VK_LAUNCH_APP1']	        =  0xB6,	--Start Application 1 key
    ['VK_LAUNCH_APP2']	        =  0xB7,	--Start Application 2 key
    -- -	0xB8-B9	Reserved
    ['VK_OEM_1']	            =  0xBA,	--Used for miscellaneous characters; it can vary by keyboard. For the US standard keyboard, the ';:' key
    ['VK_OEM_PLUS']	            =  0xBB,	--For any country/region, the '+' key
    ['VK_OEM_COMMA']	        =  0xBC,	--For any country/region, the ',' key
    ['VK_OEM_MINUS']	        =  0xBD,	--For any country/region, the '-' key
    ['VK_OEM_PERIOD']	        =  0xBE,	--For any country/region, the '.' key
    ['VK_OEM_2']	            =  0xBF,	--Used for miscellaneous characters; it can vary by keyboard. For the US standard keyboard, the '/?' key
    ['VK_OEM_3']	            =  0xC0,	--Used for miscellaneous characters; it can vary by keyboard. For the US standard keyboard, the '`~' key
    -- -	0xC1-D7	Reserved
    -- -	0xD8-DA	Unassigned
    ['VK_OEM_4']	            =  0xDB,	--Used for miscellaneous characters; it can vary by keyboard. For the US standard keyboard, the '[{' key
    ['VK_OEM_5']	            =  0xDC,	--Used for miscellaneous characters; it can vary by keyboard. For the US standard keyboard, the '\|' key
    ['VK_OEM_6']	            =  0xDD,	--Used for miscellaneous characters; it can vary by keyboard. For the US standard keyboard, the ']}' key
    ['VK_OEM_7']	            =  0xDE,	--Used for miscellaneous characters; it can vary by keyboard. For the US standard keyboard, the 'single-quote/double-quote' key
    ['VK_OEM_8']	            =  0xDF,	--Used for miscellaneous characters; it can vary by keyboard.
    -- -	0xE0	Reserved
    --0xE1	OEM specific
    ['VK_OEM_102']              =  0xE2,	--The <> keys on the US standard keyboard, or the \\| key on the non-US 102-key keyboard
    -- 0xE3-E4	OEM specific
    ['VK_PROCESSKEY']	        =  0xE5,	--IME PROCESS key
    -- 0xE6	OEM specific
    ['VK_PACKET']	            =  0xE7, 	--Used to pass Unicode characters as if they were keystrokes. The VK_PACKET key is the low word of a 32-bit Virtual Key value used for non-keyboard input methods. For more information, see Remark in KEYBDINPUT, SendInput, WM_KEYDOWN, and WM_KEYUP
    -- -	0xE8	Unassigned
    -- 0xE9-F5	OEM specific
    ['VK_ATTN']	                =  0xF6,	--Attn key
    ['VK_CRSEL']	            =  0xF7,	--CrSel key
    ['VK_EXSEL']	            =  0xF8,	--ExSel key
    ['VK_EREOF']	            =  0xF9,	--Erase EOF key
    ['VK_PLAY']	                =  0xFA,	--Play key
    ['VK_ZOOM']	                =  0xFB,	--Zoom key
    ['VK_NONAME']	            =  0xFC,	--Reserved
    ['VK_PA1']	                =  0xFD,	--PA1 key
    ['VK_OEM_CLEAR']	        =  0xFE,	--Clear key
}
local justPressed = {}
local lastPressMS = {}

local function getKeyCode(string_or_int)
    local lookup = keyLookupTable[string_or_int]
    return (lookup and lookup or string_or_int)
end

function JSkey.is_key_down(string_or_int)
    local keyCode = getKeyCode(string_or_int)
    return util.is_key_down(keyCode)
end

function JSkey.is_key_just_down(string_or_int)
    local keyCode = getKeyCode(string_or_int)
    local isDown = util.is_key_down(keyCode)

    if isDown and not justPressed[keyCode] then
        justPressed[keyCode] = true
        return true
    elseif not isDown then
        justPressed[keyCode] = false
    end
    return false
end

--if the key is currently pressed this returns the time the previous last press and not 0, -1 if never pressed
function JSkey.get_ms_since_last_press(string_or_int)
    local keyCode = getKeyCode(string_or_int)
    local isDown = util.is_key_down(keyCode)
    if lastPressMS[keyCode] == nil then
        if isDown then
            lastPressMS[keyCode] = util.current_time_millis()
        end
        return -1
    end
    local prevPress = lastPressMS[keyCode]
    if isDown then
        lastPressMS[keyCode] = util.current_time_millis()
        return prevPress != nil and util.current_time_millis() - prevPress or -1
    end
    return util.current_time_millis() - lastPressMS[keyCode]
end


----------------------------------
-- Native control functions
----------------------------------

local controlTypes = {
    ['PLAYER_CONTROL'] = 0,
    ['FRONTEND_CONTROL'] = 2,
}

local controls = {
    ['INPUT_NEXT_CAMERA'] = 0,	--V	BACK
    ['INPUT_LOOK_LR'] = 1,	--MOUSE RIGHT	RIGHT STICK
    ['INPUT_LOOK_UD'] = 2,	--MOUSE DOWN	RIGHT STICK
    ['INPUT_LOOK_UP_ONLY'] = 3,	--(NONE)	RIGHT STICK
    ['INPUT_LOOK_DOWN_ONLY'] = 4,	--MOUSE DOWN	RIGHT STICK
    ['INPUT_LOOK_LEFT_ONLY'] = 5,	--(NONE)	RIGHT STICK
    ['INPUT_LOOK_RIGHT_ONLY'] = 6,	--MOUSE RIGHT	RIGHT STICK
    ['INPUT_CINEMATIC_SLOWMO'] = 7,	--(NONE)	R3
    ['INPUT_SCRIPTED_FLY_UD'] = 8,	--S	LEFT STICK
    ['INPUT_SCRIPTED_FLY_LR'] = 9,	--D	LEFT STICK
    ['INPUT_SCRIPTED_FLY_ZUP'] = 10,	--PAGEUP	LT
    ['INPUT_SCRIPTED_FLY_ZDOWN'] = 11,	--PAGEDOWN	RT
    ['INPUT_WEAPON_WHEEL_UD'] = 12,	--MOUSE DOWN	RIGHT STICK
    ['INPUT_WEAPON_WHEEL_LR'] = 13,	--MOUSE RIGHT	RIGHT STICK
    ['INPUT_WEAPON_WHEEL_NEXT'] = 14,	--SCROLLWHEEL DOWN	DPAD RIGHT
    ['INPUT_WEAPON_WHEEL_PREV'] = 15,	--SCROLLWHEEL UP	DPAD LEFT
    ['INPUT_SELECT_NEXT_WEAPON'] = 16,	--SCROLLWHEEL DOWN	(NONE)
    ['INPUT_SELECT_PREV_WEAPON'] = 17,	--SCROLLWHEEL UP	(NONE)
    ['INPUT_SKIP_CUTSCENE'] = 18,	--ENTER / LEFT MOUSE BUTTON / SPACEBAR	A
    ['INPUT_CHARACTER_WHEEL'] = 19,	--LEFT ALT	DPAD DOWN
    ['INPUT_MULTIPLAYER_INFO'] = 20,	--Z	DPAD DOWN
    ['INPUT_SPRINT'] = 21,	--LEFT SHIFT	A
    ['INPUT_JUMP'] = 22,	--SPACEBAR	X
    ['INPUT_ENTER'] = 23,	--F	Y
    ['INPUT_ATTACK'] = 24,	--LEFT MOUSE BUTTON	RT
    ['INPUT_AIM'] = 25,	--RIGHT MOUSE BUTTON	LT
    ['INPUT_LOOK_BEHIND'] = 26,	--C	R3
    ['INPUT_PHONE'] = 27,	--ARROW UP / SCROLLWHEEL BUTTON (PRESS)	DPAD UP
    ['INPUT_SPECIAL_ABILITY'] = 28,	--(NONE)	L3
    ['INPUT_SPECIAL_ABILITY_SECONDARY'] = 29,	--B	R3
    ['INPUT_MOVE_LR'] = 30,	--D	LEFT STICK
    ['INPUT_MOVE_UD'] = 31,	--S	LEFT STICK
    ['INPUT_MOVE_UP_ONLY'] = 32,	--W	LEFT STICK
    ['INPUT_MOVE_DOWN_ONLY'] = 33,	--S	LEFT STICK
    ['INPUT_MOVE_LEFT_ONLY'] = 34,	--A	LEFT STICK
    ['INPUT_MOVE_RIGHT_ONLY'] = 35,	--D	LEFT STICK
    ['INPUT_DUCK'] = 36,	--LEFT CTRL	L3
    ['INPUT_SELECT_WEAPON'] = 37,	--TAB	LB
    ['INPUT_PICKUP'] = 38,	--E	LB
    ['INPUT_SNIPER_ZOOM'] = 39,	--[	LEFT STICK
    ['INPUT_SNIPER_ZOOM_IN_ONLY'] = 40,	--]	LEFT STICK
    ['INPUT_SNIPER_ZOOM_OUT_ONLY'] = 41,	--[	LEFT STICK
    ['INPUT_SNIPER_ZOOM_IN_SECONDARY'] = 42,	--]	DPAD UP
    ['INPUT_SNIPER_ZOOM_OUT_SECONDARY'] = 43,	--[	DPAD DOWN
    ['INPUT_COVER'] = 44,	--Q	RB
    ['INPUT_RELOAD'] = 45,	--R	B
    ['INPUT_TALK'] = 46,	--E	DPAD RIGHT
    ['INPUT_DETONATE'] = 47,	--G	DPAD LEFT
    ['INPUT_HUD_SPECIAL'] = 48,	--Z	DPAD DOWN
    ['INPUT_ARREST'] = 49,	--F	Y
    ['INPUT_ACCURATE_AIM'] = 50,	--SCROLLWHEEL DOWN	R3
    ['INPUT_CONTEXT'] = 51,	--E	DPAD RIGHT
    ['INPUT_CONTEXT_SECONDARY'] = 52,	--Q	DPAD LEFT
    ['INPUT_WEAPON_SPECIAL'] = 53,	--(NONE)	Y
    ['INPUT_WEAPON_SPECIAL_TWO'] = 54,	--E	DPAD RIGHT
    ['INPUT_DIVE'] = 55,	--SPACEBAR	RB
    ['INPUT_DROP_WEAPON'] = 56,	--F9	Y
    ['INPUT_DROP_AMMO'] = 57,	--F10	B
    ['INPUT_THROW_GRENADE'] = 58,	--G	DPAD LEFT
    ['INPUT_VEH_MOVE_LR'] = 59,	--D	LEFT STICK
    ['INPUT_VEH_MOVE_UD'] = 60,	--LEFT CTRL	LEFT STICK
    ['INPUT_VEH_MOVE_UP_ONLY'] = 61,	--LEFT SHIFT	LEFT STICK
    ['INPUT_VEH_MOVE_DOWN_ONLY'] = 62,	--LEFT CTRL	LEFT STICK
    ['INPUT_VEH_MOVE_LEFT_ONLY'] = 63,	--A	LEFT STICK
    ['INPUT_VEH_MOVE_RIGHT_ONLY'] = 64,	--D	LEFT STICK
    ['INPUT_VEH_SPECIAL'] = 65,	--(NONE)	(NONE)
    ['INPUT_VEH_GUN_LR'] = 66,	--MOUSE RIGHT	RIGHT STICK
    ['INPUT_VEH_GUN_UD'] = 67,	--MOUSE DOWN	RIGHT STICK
    ['INPUT_VEH_AIM'] = 68,	--RIGHT MOUSE BUTTON	LB
    ['INPUT_VEH_ATTACK'] = 69,	--LEFT MOUSE BUTTON	RB
    ['INPUT_VEH_ATTACK2'] = 70,	--RIGHT MOUSE BUTTON	A
    ['INPUT_VEH_ACCELERATE'] = 71,	--W	RT
    ['INPUT_VEH_BRAKE'] = 72,	--S	LT
    ['INPUT_VEH_DUCK'] = 73,	--X	A
    ['INPUT_VEH_HEADLIGHT'] = 74,	--H	DPAD RIGHT
    ['INPUT_VEH_EXIT'] = 75,	--F	Y
    ['INPUT_VEH_HANDBRAKE'] = 76,	--SPACEBAR	RB
    ['INPUT_VEH_HOTWIRE_LEFT'] = 77,	--W	LT
    ['INPUT_VEH_HOTWIRE_RIGHT'] = 78,	--S	RT
    ['INPUT_VEH_LOOK_BEHIND'] = 79,	--C	R3
    ['INPUT_VEH_CIN_CAM'] = 80,	--R	B
    ['INPUT_VEH_NEXT_RADIO'] = 81,	--.	(NONE)
    ['INPUT_VEH_PREV_RADIO'] = 82,	--,	(NONE)
    ['INPUT_VEH_NEXT_RADIO_TRACK'] = 83,	--=	(NONE)
    ['INPUT_VEH_PREV_RADIO_TRACK'] = 84,	-- -	(NONE)
    ['INPUT_VEH_RADIO_WHEEL'] = 85,	--Q	DPAD LEFT
    ['INPUT_VEH_HORN'] = 86,	--E	L3
    ['INPUT_VEH_FLY_THROTTLE_UP'] = 87,	--W	RT
    ['INPUT_VEH_FLY_THROTTLE_DOWN'] = 88,	--S	LT
    ['INPUT_VEH_FLY_YAW_LEFT'] = 89,	--A	LB
    ['INPUT_VEH_FLY_YAW_RIGHT'] = 90,	--D	RB
    ['INPUT_VEH_PASSENGER_AIM'] = 91,	--RIGHT MOUSE BUTTON	LT
    ['INPUT_VEH_PASSENGER_ATTACK'] = 92,	--LEFT MOUSE BUTTON	RT
    ['INPUT_VEH_SPECIAL_ABILITY_FRANKLIN'] = 93,	--(NONE)	R3
    ['INPUT_VEH_STUNT_UD'] = 94,	--(NONE)	(NONE)
    ['INPUT_VEH_CINEMATIC_UD'] = 95,	--MOUSE DOWN	RIGHT STICK
    ['INPUT_VEH_CINEMATIC_UP_ONLY'] = 96,	--NUMPAD- / SCROLLWHEEL UP	(NONE)
    ['INPUT_VEH_CINEMATIC_DOWN_ONLY'] = 97,	--NUMPAD+ / SCROLLWHEEL DOWN	(NONE)
    ['INPUT_VEH_CINEMATIC_LR'] = 98,	--MOUSE RIGHT	RIGHT STICK
    ['INPUT_VEH_SELECT_NEXT_WEAPON'] = 99,	--SCROLLWHEEL UP	X
    ['INPUT_VEH_SELECT_PREV_WEAPON'] = 100,	--[	(NONE)
    ['INPUT_VEH_ROOF'] = 101,	--H	DPAD RIGHT
    ['INPUT_VEH_JUMP'] = 102,	--SPACEBAR	RB
    ['INPUT_VEH_GRAPPLING_HOOK'] = 103,	--E	DPAD RIGHT
    ['INPUT_VEH_SHUFFLE'] = 104,	--H	DPAD RIGHT
    ['INPUT_VEH_DROP_PROJECTILE'] = 105,	--X	A
    ['INPUT_VEH_MOUSE_CONTROL_OVERRIDE'] = 106,	--LEFT MOUSE BUTTON	(NONE)
    ['INPUT_VEH_FLY_ROLL_LR'] = 107,	--NUMPAD 6	LEFT STICK
    ['INPUT_VEH_FLY_ROLL_LEFT_ONLY'] = 108,	--NUMPAD 4	LEFT STICK
    ['INPUT_VEH_FLY_ROLL_RIGHT_ONLY'] = 109,	--NUMPAD 6	LEFT STICK
    ['INPUT_VEH_FLY_PITCH_UD'] = 110,	--NUMPAD 5	LEFT STICK
    ['INPUT_VEH_FLY_PITCH_UP_ONLY'] = 111,	--NUMPAD 8	LEFT STICK
    ['INPUT_VEH_FLY_PITCH_DOWN_ONLY'] = 112,	--NUMPAD 5	LEFT STICK
    ['INPUT_VEH_FLY_UNDERCARRIAGE'] = 113,	--G	L3
    ['INPUT_VEH_FLY_ATTACK'] = 114,	--RIGHT MOUSE BUTTON	A
    ['INPUT_VEH_FLY_SELECT_NEXT_WEAPON'] = 115,	--SCROLLWHEEL UP	DPAD LEFT
    ['INPUT_VEH_FLY_SELECT_PREV_WEAPON'] = 116,	--[	(NONE)
    ['INPUT_VEH_FLY_SELECT_TARGET_LEFT'] = 117,	--NUMPAD 7	LB
    ['INPUT_VEH_FLY_SELECT_TARGET_RIGHT'] = 118,	--NUMPAD 9	RB
    ['INPUT_VEH_FLY_VERTICAL_FLIGHT_MODE'] = 119,	--E	DPAD RIGHT
    ['INPUT_VEH_FLY_DUCK'] = 120,	--X	A
    ['INPUT_VEH_FLY_ATTACK_CAMERA'] = 121,	--INSERT	R3
    ['INPUT_VEH_FLY_MOUSE_CONTROL_OVERRIDE'] = 122,	--LEFT MOUSE BUTTON	(NONE)
    ['INPUT_VEH_SUB_TURN_LR'] = 123,	--NUMPAD 6	LEFT STICK
    ['INPUT_VEH_SUB_TURN_LEFT_ONLY'] = 124,	--NUMPAD 4	LEFT STICK
    ['INPUT_VEH_SUB_TURN_RIGHT_ONLY'] = 125,	--NUMPAD 6	LEFT STICK
    ['INPUT_VEH_SUB_PITCH_UD'] = 126,	--NUMPAD 5	LEFT STICK
    ['INPUT_VEH_SUB_PITCH_UP_ONLY'] = 127,	--NUMPAD 8	LEFT STICK
    ['INPUT_VEH_SUB_PITCH_DOWN_ONLY'] = 128,	--NUMPAD 5	LEFT STICK
    ['INPUT_VEH_SUB_THROTTLE_UP'] = 129,	--W	RT
    ['INPUT_VEH_SUB_THROTTLE_DOWN'] = 130,	--S	LT
    ['INPUT_VEH_SUB_ASCEND'] = 131,	--LEFT SHIFT	X
    ['INPUT_VEH_SUB_DESCEND'] = 132,	--LEFT CTRL	A
    ['INPUT_VEH_SUB_TURN_HARD_LEFT'] = 133,	--A	LB
    ['INPUT_VEH_SUB_TURN_HARD_RIGHT'] = 134,	--D	RB
    ['INPUT_VEH_SUB_MOUSE_CONTROL_OVERRIDE'] = 135,	--LEFT MOUSE BUTTON	(NONE)
    ['INPUT_VEH_PUSHBIKE_PEDAL'] = 136,	--W	A
    ['INPUT_VEH_PUSHBIKE_SPRINT'] = 137,	--CAPSLOCK	A
    ['INPUT_VEH_PUSHBIKE_FRONT_BRAKE'] = 138,	--Q	LT
    ['INPUT_VEH_PUSHBIKE_REAR_BRAKE'] = 139,	--S	RT
    ['INPUT_MELEE_ATTACK_LIGHT'] = 140,	--R	B
    ['INPUT_MELEE_ATTACK_HEAVY'] = 141,	--Q	A
    ['INPUT_MELEE_ATTACK_ALTERNATE'] = 142,	--LEFT MOUSE BUTTON	RT
    ['INPUT_MELEE_BLOCK'] = 143,	--SPACEBAR	X
    ['INPUT_PARACHUTE_DEPLOY'] = 144,	--F / LEFT MOUSE BUTTON	Y
    ['INPUT_PARACHUTE_DETACH'] = 145,	--F	Y
    ['INPUT_PARACHUTE_TURN_LR'] = 146,	--D	LEFT STICK
    ['INPUT_PARACHUTE_TURN_LEFT_ONLY'] = 147,	--A	LEFT STICK
    ['INPUT_PARACHUTE_TURN_RIGHT_ONLY'] = 148,	--D	LEFT STICK
    ['INPUT_PARACHUTE_PITCH_UD'] = 149,	--S	LEFT STICK
    ['INPUT_PARACHUTE_PITCH_UP_ONLY'] = 150,	--W	LEFT STICK
    ['INPUT_PARACHUTE_PITCH_DOWN_ONLY'] = 151,	--S	LEFT STICK
    ['INPUT_PARACHUTE_BRAKE_LEFT'] = 152,	--Q	LB
    ['INPUT_PARACHUTE_BRAKE_RIGHT'] = 153,	--E	RB
    ['INPUT_PARACHUTE_SMOKE'] = 154,	--X	A
    ['INPUT_PARACHUTE_PRECISION_LANDING'] = 155,	--LEFT SHIFT	(NONE)
    ['INPUT_MAP'] = 156,	--(NONE)	(NONE)
    ['INPUT_SELECT_WEAPON_UNARMED'] = 157,	--1	(NONE)
    ['INPUT_SELECT_WEAPON_MELEE'] = 158,	--2	(NONE)
    ['INPUT_SELECT_WEAPON_HANDGUN'] = 159,	--6	(NONE)
    ['INPUT_SELECT_WEAPON_SHOTGUN'] = 160,	--3	(NONE)
    ['INPUT_SELECT_WEAPON_SMG'] = 161,	--7	(NONE)
    ['INPUT_SELECT_WEAPON_AUTO_RIFLE'] = 162,	--8	(NONE)
    ['INPUT_SELECT_WEAPON_SNIPER'] = 163,	--9	(NONE)
    ['INPUT_SELECT_WEAPON_HEAVY'] = 164,	--4	(NONE)
    ['INPUT_SELECT_WEAPON_SPECIAL'] = 165,	--5	(NONE)
    ['INPUT_SELECT_CHARACTER_MICHAEL'] = 166,	--F5	(NONE)
    ['INPUT_SELECT_CHARACTER_FRANKLIN'] = 167,	--F6	(NONE)
    ['INPUT_SELECT_CHARACTER_TREVOR'] = 168,	--F7	(NONE)
    ['INPUT_SELECT_CHARACTER_MULTIPLAYER'] = 169,	--F8 (CONSOLE)	(NONE)
    ['INPUT_SAVE_REPLAY_CLIP'] = 170,	--F3	B
    ['INPUT_SPECIAL_ABILITY_PC'] = 171,	--CAPSLOCK	(NONE)
    ['INPUT_CELLPHONE_UP'] = 172,	--ARROW UP	DPAD UP
    ['INPUT_CELLPHONE_DOWN'] = 173,	--ARROW DOWN	DPAD DOWN
    ['INPUT_CELLPHONE_LEFT'] = 174,	--ARROW LEFT	DPAD LEFT
    ['INPUT_CELLPHONE_RIGHT'] = 175,	--ARROW RIGHT	DPAD RIGHT
    ['INPUT_CELLPHONE_SELECT'] = 176,	--ENTER / LEFT MOUSE BUTTON	A
    ['INPUT_CELLPHONE_CANCEL'] = 177,	--BACKSPACE / ESC / RIGHT MOUSE BUTTON	B
    ['INPUT_CELLPHONE_OPTION'] = 178,	--DELETE	Y
    ['INPUT_CELLPHONE_EXTRA_OPTION'] = 179,	--SPACEBAR	X
    ['INPUT_CELLPHONE_SCROLL_FORWARD'] = 180,	--SCROLLWHEEL DOWN	(NONE)
    ['INPUT_CELLPHONE_SCROLL_BACKWARD'] = 181,	--SCROLLWHEEL UP	(NONE)
    ['INPUT_CELLPHONE_CAMERA_FOCUS_LOCK'] = 182,	--L	RT
    ['INPUT_CELLPHONE_CAMERA_GRID'] = 183,	--G	RB
    ['INPUT_CELLPHONE_CAMERA_SELFIE'] = 184,	--E	R3
    ['INPUT_CELLPHONE_CAMERA_DOF'] = 185,	--F	LB
    ['INPUT_CELLPHONE_CAMERA_EXPRESSION'] = 186,	--X	L3
    ['INPUT_FRONTEND_DOWN'] = 187,	--ARROW DOWN	DPAD DOWN
    ['INPUT_FRONTEND_UP'] = 188,	--ARROW UP	DPAD UP
    ['INPUT_FRONTEND_LEFT'] = 189,	--ARROW LEFT	DPAD LEFT
    ['INPUT_FRONTEND_RIGHT'] = 190,	--ARROW RIGHT	DPAD RIGHT
    ['INPUT_FRONTEND_RDOWN'] = 191,	--ENTER	A
    ['INPUT_FRONTEND_RUP'] = 192,	--TAB	Y
    ['INPUT_FRONTEND_RLEFT'] = 193,	--(NONE)	X
    ['INPUT_FRONTEND_RRIGHT'] = 194,	--BACKSPACE	B
    ['INPUT_FRONTEND_AXIS_X'] = 195,	--D	LEFT STICK
    ['INPUT_FRONTEND_AXIS_Y'] = 196,	--S	LEFT STICK
    ['INPUT_FRONTEND_RIGHT_AXIS_X'] = 197,	--]	RIGHT STICK
    ['INPUT_FRONTEND_RIGHT_AXIS_Y'] = 198,	--SCROLLWHEEL DOWN	RIGHT STICK
    ['INPUT_FRONTEND_PAUSE'] = 199,	--P	START
    ['INPUT_FRONTEND_PAUSE_ALTERNATE'] = 200,	--ESC	(NONE)
    ['INPUT_FRONTEND_ACCEPT'] = 201,	--ENTER / NUMPAD ENTER	A
    ['INPUT_FRONTEND_CANCEL'] = 202,	--BACKSPACE / ESC	B
    ['INPUT_FRONTEND_X'] = 203,	--SPACEBAR	X
    ['INPUT_FRONTEND_Y'] = 204,	--TAB	Y
    ['INPUT_FRONTEND_LB'] = 205,	--Q	LB
    ['INPUT_FRONTEND_RB'] = 206,	--E	RB
    ['INPUT_FRONTEND_LT'] = 207,	--PAGE DOWN	LT
    ['INPUT_FRONTEND_RT'] = 208,	--PAGE UP	RT
    ['INPUT_FRONTEND_LS'] = 209,	--LEFT SHIFT	L3
    ['INPUT_FRONTEND_RS'] = 210,	--LEFT CONTROL	R3
    ['INPUT_FRONTEND_LEADERBOARD'] = 211,	--TAB	RB
    ['INPUT_FRONTEND_SOCIAL_CLUB'] = 212,	--HOME	BACK
    ['INPUT_FRONTEND_SOCIAL_CLUB_SECONDARY'] = 213,	--HOME	RB
    ['INPUT_FRONTEND_DELETE'] = 214,	--DELETE	X
    ['INPUT_FRONTEND_ENDSCREEN_ACCEPT'] = 215,	--ENTER	A
    ['INPUT_FRONTEND_ENDSCREEN_EXPAND'] = 216,	--SPACEBAR	X
    ['INPUT_FRONTEND_SELECT'] = 217,	--CAPSLOCK	BACK
    ['INPUT_SCRIPT_LEFT_AXIS_X'] = 218,	--D	LEFT STICK
    ['INPUT_SCRIPT_LEFT_AXIS_Y'] = 219,	--S	LEFT STICK
    ['INPUT_SCRIPT_RIGHT_AXIS_X'] = 220,	--MOUSE RIGHT	RIGHT STICK
    ['INPUT_SCRIPT_RIGHT_AXIS_Y'] = 221,	--MOUSE DOWN	RIGHT STICK
    ['INPUT_SCRIPT_RUP'] = 222,	--RIGHT MOUSE BUTTON	Y
    ['INPUT_SCRIPT_RDOWN'] = 223,	--LEFT MOUSE BUTTON	A
    ['INPUT_SCRIPT_RLEFT'] = 224,	--LEFT CTRL	X
    ['INPUT_SCRIPT_RRIGHT'] = 225,	--RIGHT MOUSE BUTTON	B
    ['INPUT_SCRIPT_LB'] = 226,	--(NONE)	LB
    ['INPUT_SCRIPT_RB'] = 227,	--(NONE)	RB
    ['INPUT_SCRIPT_LT'] = 228,	--(NONE)	LT
    ['INPUT_SCRIPT_RT'] = 229,	--LEFT MOUSE BUTTON	RT
    ['INPUT_SCRIPT_LS'] = 230,	--(NONE)	L3
    ['INPUT_SCRIPT_RS'] = 231,	--(NONE)	R3
    ['INPUT_SCRIPT_PAD_UP'] = 232,	--W	DPAD UP
    ['INPUT_SCRIPT_PAD_DOWN'] = 233,	--S	DPAD DOWN
    ['INPUT_SCRIPT_PAD_LEFT'] = 234,	--A	DPAD LEFT
    ['INPUT_SCRIPT_PAD_RIGHT'] = 235,	--D	DPAD RIGHT
    ['INPUT_SCRIPT_SELECT'] = 236,	--V	BACK
    ['INPUT_CURSOR_ACCEPT'] = 237,	--LEFT MOUSE BUTTON	(NONE)
    ['INPUT_CURSOR_CANCEL'] = 238,	--RIGHT MOUSE BUTTON	(NONE)
    ['INPUT_CURSOR_X'] = 239,	--(NONE)	(NONE)
    ['INPUT_CURSOR_Y'] = 240,	--(NONE)	(NONE)
    ['INPUT_CURSOR_SCROLL_UP'] = 241,	--SCROLLWHEEL UP	(NONE)
    ['INPUT_CURSOR_SCROLL_DOWN'] = 242,	--SCROLLWHEEL DOWN	(NONE)
    ['INPUT_ENTER_CHEAT_CODE'] = 243,	--~ / `	(NONE)
    ['INPUT_INTERACTION_MENU'] = 244,	--M	BACK
    ['INPUT_MP_TEXT_CHAT_ALL'] = 245,	--T	(NONE)
    ['INPUT_MP_TEXT_CHAT_TEAM'] = 246,	--Y	(NONE)
    ['INPUT_MP_TEXT_CHAT_FRIENDS'] = 247,	--(NONE)	(NONE)
    ['INPUT_MP_TEXT_CHAT_CREW'] = 248,	--(NONE)	(NONE)
    ['INPUT_PUSH_TO_TALK'] = 249,	--N	(NONE)
    ['INPUT_CREATOR_LS'] = 250,	--R	L3
    ['INPUT_CREATOR_RS'] = 251,	--F	R3
    ['INPUT_CREATOR_LT'] = 252,	--X	LT
    ['INPUT_CREATOR_RT'] = 253,	--C	RT
    ['INPUT_CREATOR_MENU_TOGGLE'] = 254,	--LEFT SHIFT	(NONE)
    ['INPUT_CREATOR_ACCEPT'] = 255,	--SPACEBAR	A
    ['INPUT_CREATOR_DELETE'] = 256,	--DELETE	X
    ['INPUT_ATTACK2'] = 257,	--LEFT MOUSE BUTTON	RT
    ['INPUT_RAPPEL_JUMP'] = 258,	--(NONE)	A
    ['INPUT_RAPPEL_LONG_JUMP'] = 259,	--(NONE)	X
    ['INPUT_RAPPEL_SMASH_WINDOW'] = 260,	--(NONE)	RT
    ['INPUT_PREV_WEAPON'] = 261,	--SCROLLWHEEL UP	DPAD LEFT
    ['INPUT_NEXT_WEAPON'] = 262,	--SCROLLWHEEL DOWN	DPAD RIGHT
    ['INPUT_MELEE_ATTACK1'] = 263,	--R	B
    ['INPUT_MELEE_ATTACK2'] = 264,	--Q	A
    ['INPUT_WHISTLE'] = 265,	--(NONE)	(NONE)
    ['INPUT_MOVE_LEFT'] = 266,	--D	LEFT STICK
    ['INPUT_MOVE_RIGHT'] = 267,	--D	LEFT STICK
    ['INPUT_MOVE_UP'] = 268,	--S	LEFT STICK
    ['INPUT_MOVE_DOWN'] = 269,	--S	LEFT STICK
    ['INPUT_LOOK_LEFT'] = 270,	--MOUSE RIGHT	RIGHT STICK
    ['INPUT_LOOK_RIGHT'] = 271,	--MOUSE RIGHT	RIGHT STICK
    ['INPUT_LOOK_UP'] = 272,	--MOUSE DOWN	RIGHT STICK
    ['INPUT_LOOK_DOWN'] = 273,	--MOUSE DOWN	RIGHT STICK
    ['INPUT_SNIPER_ZOOM_IN'] = 274,	--[	RIGHT STICK
    ['INPUT_SNIPER_ZOOM_OUT'] = 275,	--[	RIGHT STICK
    ['INPUT_SNIPER_ZOOM_IN_ALTERNATE'] = 276,	--[	LEFT STICK
    ['INPUT_SNIPER_ZOOM_OUT_ALTERNATE'] = 277,	--[	LEFT STICK
    ['INPUT_VEH_MOVE_LEFT'] = 278,	--D	LEFT STICK
    ['INPUT_VEH_MOVE_RIGHT'] = 279,	--D	LEFT STICK
    ['INPUT_VEH_MOVE_UP'] = 280,	--LEFT CTRL	LEFT STICK
    ['INPUT_VEH_MOVE_DOWN'] = 281,	--LEFT CTRL	LEFT STICK
    ['INPUT_VEH_GUN_LEFT'] = 282,	--MOUSE RIGHT	RIGHT STICK
    ['INPUT_VEH_GUN_RIGHT'] = 283,	--MOUSE RIGHT	RIGHT STICK
    ['INPUT_VEH_GUN_UP'] = 284,	--MOUSE RIGHT	RIGHT STICK
    ['INPUT_VEH_GUN_DOWN'] = 285,	--MOUSE RIGHT	RIGHT STICK
    ['INPUT_VEH_LOOK_LEFT'] = 286,	--MOUSE RIGHT	RIGHT STICK
    ['INPUT_VEH_LOOK_RIGHT'] = 287,	--MOUSE RIGHT	RIGHT STICK
    ['INPUT_REPLAY_START_STOP_RECORDING'] = 288,	--F1	A
    ['INPUT_REPLAY_START_STOP_RECORDING_SECONDARY'] = 289,	--F2	X
    ['INPUT_SCALED_LOOK_LR'] = 290,	--MOUSE RIGHT	RIGHT STICK
    ['INPUT_SCALED_LOOK_UD'] = 291,	--MOUSE DOWN	RIGHT STICK
    ['INPUT_SCALED_LOOK_UP_ONLY'] = 292,	--(NONE)	RIGHT STICK
    ['INPUT_SCALED_LOOK_DOWN_ONLY'] = 293,	--(NONE)	RIGHT STICK
    ['INPUT_SCALED_LOOK_LEFT_ONLY'] = 294,	--(NONE)	RIGHT STICK
    ['INPUT_SCALED_LOOK_RIGHT_ONLY'] = 295,	--(NONE)	RIGHT STICK
    ['INPUT_REPLAY_MARKER_DELETE'] = 296,	--DELETE	X
    ['INPUT_REPLAY_CLIP_DELETE'] = 297,	--DELETE	Y
    ['INPUT_REPLAY_PAUSE'] = 298,	--SPACEBAR	A
    ['INPUT_REPLAY_REWIND'] = 299,	--ARROW DOWN	LB
    ['INPUT_REPLAY_FFWD'] = 300,	--ARROW UP	RB
    ['INPUT_REPLAY_NEWMARKER'] = 301,	--M	A
    ['INPUT_REPLAY_RECORD'] = 302,	--S	(NONE)
    ['INPUT_REPLAY_SCREENSHOT'] = 303,	--U	DPAD UP
    ['INPUT_REPLAY_HIDEHUD'] = 304,	--H	R3
    ['INPUT_REPLAY_STARTPOINT'] = 305,	--B	(NONE)
    ['INPUT_REPLAY_ENDPOINT'] = 306,	--N	(NONE)
    ['INPUT_REPLAY_ADVANCE'] = 307,	--ARROW RIGHT	DPAD RIGHT
    ['INPUT_REPLAY_BACK'] = 308,	--ARROW LEFT	DPAD LEFT
    ['INPUT_REPLAY_TOOLS'] = 309,	--T	DPAD DOWN
    ['INPUT_REPLAY_RESTART'] = 310,	--R	BACK
    ['INPUT_REPLAY_SHOWHOTKEY'] = 311,	--K	DPAD DOWN
    ['INPUT_REPLAY_CYCLEMARKERLEFT'] = 312,	--[	DPAD LEFT
    ['INPUT_REPLAY_CYCLEMARKERRIGHT'] = 313,	--]	DPAD RIGHT
    ['INPUT_REPLAY_FOVINCREASE'] = 314,	--NUMPAD +	RB
    ['INPUT_REPLAY_FOVDECREASE'] = 315,	--NUMPAD -	LB
    ['INPUT_REPLAY_CAMERAUP'] = 316,	--PAGE UP	(NONE)
    ['INPUT_REPLAY_CAMERADOWN'] = 317,	--PAGE DOWN	(NONE)
    ['INPUT_REPLAY_SAVE'] = 318,	--F5	START
    ['INPUT_REPLAY_TOGGLETIME'] = 319,	--C	(NONE)
    ['INPUT_REPLAY_TOGGLETIPS'] = 320,	--V	(NONE)
    ['INPUT_REPLAY_PREVIEW'] = 321,	--SPACEBAR	(NONE)
    ['INPUT_REPLAY_TOGGLE_TIMELINE'] = 322,	--ESC	(NONE)
    ['INPUT_REPLAY_TIMELINE_PICKUP_CLIP'] = 323,	--X	(NONE)
    ['INPUT_REPLAY_TIMELINE_DUPLICATE_CLIP'] = 324,	--C	(NONE)
    ['INPUT_REPLAY_TIMELINE_PLACE_CLIP'] = 325,	--V	(NONE)
    ['INPUT_REPLAY_CTRL'] = 326,	--LEFT CTRL	(NONE)
    ['INPUT_REPLAY_TIMELINE_SAVE'] = 327,	--F5	(NONE)
    ['INPUT_REPLAY_PREVIEW_AUDIO'] = 328,	--SPACEBAR	RT
    ['INPUT_VEH_DRIVE_LOOK'] = 329,	--LEFT MOUSE BUTTON	(NONE)
    ['INPUT_VEH_DRIVE_LOOK2'] = 330,	--RIGHT MOUSE BUTTON	(NONE)
    ['INPUT_VEH_FLY_ATTACK2'] = 331,	--RIGHT MOUSE BUTTON	(NONE)
    ['INPUT_RADIO_WHEEL_UD'] = 332,	--MOUSE DOWN	RIGHT STICK
    ['INPUT_RADIO_WHEEL_LR'] = 333,	--MOUSE RIGHT	RIGHT STICK
    ['INPUT_VEH_SLOWMO_UD'] = 334,	--SCROLLWHEEL DOWN	LEFT STICK
    ['INPUT_VEH_SLOWMO_UP_ONLY'] = 335,	--SCROLLWHEEL UP	LEFT STICK
    ['INPUT_VEH_SLOWMO_DOWN_ONLY'] = 336,	--SCROLLWHEEL DOWN	LEFT STICK
    ['INPUT_VEH_HYDRAULICS_CONTROL_TOGGLE'] = 337,	--X	A
    ['INPUT_VEH_HYDRAULICS_CONTROL_LEFT'] = 338,	--A	LEFT STICK
    ['INPUT_VEH_HYDRAULICS_CONTROL_RIGHT'] = 339,	--D	LEFT STICK
    ['INPUT_VEH_HYDRAULICS_CONTROL_UP'] = 340,	--LEFT SHIFT	LEFT STICK
    ['INPUT_VEH_HYDRAULICS_CONTROL_DOWN'] = 341,	--LEFT CTRL	LEFT STICK
    ['INPUT_VEH_HYDRAULICS_CONTROL_UD'] = 342,	--D	LEFT STICK
    ['INPUT_VEH_HYDRAULICS_CONTROL_LR'] = 343,	--LEFT CTRL	LEFT STICK
    ['INPUT_SWITCH_VISOR'] = 344,	--F11	DPAD RIGHT
    ['INPUT_VEH_MELEE_HOLD'] = 345,	--X	A
    ['INPUT_VEH_MELEE_LEFT'] = 346,	--LEFT MOUSE BUTTON	LB
    ['INPUT_VEH_MELEE_RIGHT'] = 347,	--RIGHT MOUSE BUTTON	RB
    ['INPUT_MAP_POI'] = 348,	--SCROLLWHEEL BUTTON (PRESS)	Y
    ['INPUT_REPLAY_SNAPMATIC_PHOTO'] = 349,	--TAB	X
    ['INPUT_VEH_CAR_JUMP'] = 350,	--E	L3
    ['INPUT_VEH_ROCKET_BOOST'] = 351,	--E	L3
    ['INPUT_VEH_FLY_BOOST'] = 352,	--LEFT SHIFT	L3
    ['INPUT_VEH_PARACHUTE'] = 353,	--SPACEBAR	A
    ['INPUT_VEH_BIKE_WINGS'] = 354,	--X	A
    ['INPUT_VEH_FLY_BOMB_BAY'] = 355,	--E	DPAD RIGHT
    ['INPUT_VEH_FLY_COUNTER'] = 356,	--E	DPAD RIGHT
    ['INPUT_VEH_TRANSFORM'] = 357,	--X	A
    ['INPUT_QUAD_LOCO_REVERSE'] = 358,		--RB
    ['INPUT_RESPAWN_FASTER'] = 359,
    ['INPUT_HUDMARKER_SELECT'] = 360,
}

function JSkey.is_control_enabled(controlType, control)
    return PAD.IS_CONTROL_ENABLED(controlTypes[controlType] or controlType, controls[control] or control)
end

function JSkey.is_control_pressed(controlType, control)
    return PAD.IS_CONTROL_PRESSED(controlTypes[controlType] or controlType, controls[control] or control)
end

function JSkey.is_control_released(controlType, control)
    return PAD.IS_CONTROL_RELEASED(controlTypes[controlType] or controlType, controls[control] or control)
end

function JSkey.is_control_just_pressed(controlType, control)
    return PAD.IS_CONTROL_JUST_PRESSED(controlTypes[controlType] or controlType, controls[control] or control)
end

function JSkey.is_control_just_released(controlType, control)
    return PAD.IS_CONTROL_JUST_RELEASED(controlTypes[controlType] or controlType, controls[control] or control)
end

function JSkey.get_control_value(controlType, control, amount)
    return PAD.GET_CONTROL_VALUE(controlTypes[controlType] or controlType, controls[control] or control, amount)
end

function JSkey.get_control_normal(controlType, control, amount)
    return PAD.GET_CONTROL_NORMAL(controlTypes[controlType] or controlType, controls[control] or control, amount)
end

function JSkey.get_control_unbound_normal(controlType, control)
    return PAD.GET_CONTROL_UNBOUND_NORMAL(controlTypes[controlType] or controlType, controls[control] or control)
end

function JSkey.set_control_normal(controlType, control, amount)
    return PAD._SET_CONTROL_NORMAL(controlTypes[controlType] or controlType, controls[control] or control, amount)
end

function JSkey.is_disabled_control_pressed(controlType, control)
    return PAD.IS_DISABLED_CONTROL_PRESSED(controlTypes[controlType] or controlType, controls[control] or control)
end

function JSkey.is_disabled_control_released(controlType, control)
    return PAD.IS_DISABLED_CONTROL_RELEASED(controlTypes[controlType] or controlType, controls[control] or control)
end

function JSkey.is_disabled_control_just_pressed(controlType, control)
    return PAD.IS_DISABLED_CONTROL_JUST_PRESSED(controlTypes[controlType] or controlType, controls[control] or control)
end

function JSkey.is_disabled_control_just_released(controlType, control)
    return PAD.IS_DISABLED_CONTROL_JUST_RELEASED(controlTypes[controlType] or controlType, controls[control] or control)
end

function JSkey.get_disabled_control_normal(controlType, control)
    return PAD.GET_DISABLED_CONTROL_NORMAL(controlTypes[controlType] or controlType, controls[control] or control)
end

function JSkey.get_disabled_control_unbound_normal(controlType, control)
    return PAD.GET_DISABLED_CONTROL_UNBOUND_NORMAL(controlTypes[controlType] or controlType, controls[control] or control)
end

function JSkey.get_control_instructional_button(controlType, control)
    return PAD.GET_CONTROL_INSTRUCTIONAL_BUTTON(controlTypes[controlType] or controlType, controls[control] or control, true --[[unused variable]])
end

function JSkey.get_control_group_instructional_button(controlType, control)
    return PAD.GET_CONTROL_GROUP_INSTRUCTIONAL_BUTTON(controlTypes[controlType] or controlType, controls[control] or control, true --[[unused variable]])
end

function JSkey.set_input_exclusive(controlType, control)
    PAD.SET_INPUT_EXCLUSIVE(controlTypes[controlType] or controlType, controls[control] or control)
end

function JSkey.disable_control_action(controlType, control, disable)
    PAD.DISABLE_CONTROL_ACTION(controlTypes[controlType] or controlType, controls[control] or control, disable)
end

function JSkey.enable_control_action(controlType, control, enable)
    PAD.ENABLE_CONTROL_ACTION(controlTypes[controlType] or controlType, controls[control] or control, enable)
end

function JSkey.disable_all_control_actions(controlType)
    PAD.DISABLE_ALL_CONTROL_ACTIONS(controlTypes[controlType] or controlType)
end

function JSkey.enable_all_control_actions(controlType)
    PAD.ENABLE_ALL_CONTROL_ACTIONS(controlTypes[controlType] or controlType)
end

local lastControlPressMS = {}

--the same as get_ms_since_last_press but for controls
function JSkey.get_ms_since_control_last_pressed(controlType, control)
    local isDown = PAD.IS_CONTROL_PRESSED(controlTypes[controlType] or controlType, controls[control] or control)
    if not lastControlPressMS[controlType] then
        lastControlPressMS[controlType] = {}
    end
    if lastControlPressMS[controlType][control] == nil then
        if isDown then
            lastControlPressMS[controlType][control] = util.current_time_millis()
        end
        return -1
    end
    local prevPress = lastControlPressMS[controlType][control]
    if isDown then
        lastControlPressMS[controlType][control] = util.current_time_millis()
        return prevPress != nil and util.current_time_millis() - prevPress or -1
    end
    return util.current_time_millis() - lastControlPressMS[controlType][control]
end

return JSkey
