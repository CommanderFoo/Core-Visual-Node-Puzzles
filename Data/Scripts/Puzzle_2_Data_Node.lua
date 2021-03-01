local API, YOOTIL = require(script:GetCustomProperty("API"))

local square_count = script:GetCustomProperty("square_count"):WaitForObject()
local circle_count = script:GetCustomProperty("circle_count"):WaitForObject()
local triangle_count = script:GetCustomProperty("triangle_count"):WaitForObject()

local square_shape = script:GetCustomProperty("square_shape")
local circle_shape = script:GetCustomProperty("circle_shape")
local triangle_shape = script:GetCustomProperty("triangle_shape")

local data = {
	
	{ condition = "square", count = tonumber(square_count.text), ui = square_count, asset = square_shape },
	{ condition = "circle", count = tonumber(circle_count.text), ui = circle_count, asset = circle_shape },
	{ condition = "triangle", count = tonumber(triangle_count.text), ui = triangle_count, asset = triangle_shape }

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
	data_node:reset()

	for _, d in ipairs(data) do
		if(Object.IsValid(d.ui)) then
			d.ui.text = tostring(d.count)
		end
	end
end)

Events.Connect("puzzle_run", function(speed)
	data_node:set_speed(speed)
	data_node:tick()
end)