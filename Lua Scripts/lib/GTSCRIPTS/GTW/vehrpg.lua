HomingMissiles = require "lib.GTSCRIPTS.H"
GuidedMissile = require "lib.GTSCRIPTS.M"

local toggle = menu.toggle_loop(list_homingMissiles, "先进追踪导弹", {"homingmissiles"}, "鼠标右键射击出的才是追踪导弹哦!", function ()
	if not UFO.exists() and not GuidedMissile.exists() then
		HomingMissiles.mainLoop()
	else
		menu.set_value(toggle, false)
	end
end, HomingMissiles.reset)