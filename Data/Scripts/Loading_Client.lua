local YOOTIL = require(script:GetCustomProperty("YOOTIL"))

local progress = script:GetCustomProperty("progress"):WaitForObject()

local x_time = 1
local y_time = .5

local left_right_tween = YOOTIL.Tween:new(x_time, {x = -219}, {x = 218})
local right_down_tween = YOOTIL.Tween:new(y_time, {y = -24}, {y = 24})
local right_left_tween = YOOTIL.Tween:new(x_time, {x = 218}, {x = -219})
local left_up_tween = YOOTIL.Tween:new(y_time, {y = 44}, {y = -43})

local active_tween = left_right_tween

-- Left to right

left_right_tween:on_start(function()
	progress.y = -45
end)

left_right_tween:on_complete(function()
	active_tween = right_down_tween
	left_right_tween:reset()
end)

left_right_tween:on_change(function(v)
	progress.x = v.x
end)

-- Right to down

right_down_tween:on_start(function()
	progress.x = 221
end)

right_down_tween:on_complete(function()
	active_tween = right_left_tween
	right_down_tween:reset()
end)

right_down_tween:on_change(function(v)
	progress.y = v.y
end)

-- Right to left

right_left_tween:on_start(function()
	progress.y = 45
end)

right_left_tween:on_complete(function()
	active_tween = left_up_tween
	right_left_tween:reset()
end)

right_left_tween:on_change(function(v)
	progress.x = v.x
end)

-- Left to up

left_up_tween:on_start(function()
	progress.x = -221
end)

left_up_tween:on_complete(function()
	active_tween = left_right_tween
	left_up_tween:reset()
end)

left_up_tween:on_change(function(v)
	progress.y = v.y
end)

function Tick(dt)
	if(active_tween ~= nil) then
		--active_tween:tween(dt)
	end
end