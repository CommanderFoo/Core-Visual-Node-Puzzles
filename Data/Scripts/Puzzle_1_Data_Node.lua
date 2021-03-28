﻿local API, YOOTIL = require(script:GetCustomProperty("API"))

local is_destroyed = false

local circle_count = script:GetCustomProperty("circle_count"):WaitForObject()
local circle_shape = script:GetCustomProperty("circle_shape")

local data = {
	
	{ condition = "circle", count = tonumber(circle_count.text), ui = circle_count, asset = circle_shape }

}

local data_node = API.Node_Type.Data:new(script.parent.parent, {

	data_items = data,
	YOOTIL = YOOTIL,
	repeat_interval = 0.25

})

API.register_node(data_node)

function Tick(dt)
	for _, i in ipairs(data_node:get_tweens()) do
		if(i.tween ~= nil) then
			i.tween:tween(dt)
		end
	end
end

Events.Connect("puzzle_edit", function()
	if(is_destroyed) then
		return
	end

	data_node:reset()

	for _, d in ipairs(data) do
		if(Object.IsValid(d.ui)) then
			d.ui.text = tostring(d.count)
		end
	end
end)

Events.Connect("puzzle_run", function(speed)
	if(is_destroyed) then
		return
	end

	data_node:set_speed(speed)
	data_node:tick()
end)

script.destroyEvent:Connect(function()
	is_destroyed = true
end)