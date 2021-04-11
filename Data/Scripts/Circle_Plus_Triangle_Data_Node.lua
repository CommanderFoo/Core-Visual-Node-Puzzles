local API = require(script:GetCustomProperty("API"))

local is_destroyed = false

local plus_count = script:GetCustomProperty("plus_count"):WaitForObject()
local circle_count = script:GetCustomProperty("circle_count"):WaitForObject()
local triangle_count = script:GetCustomProperty("triangle_count"):WaitForObject()

local plus_shape = script:GetCustomProperty("plus_shape")
local circle_shape = script:GetCustomProperty("circle_shape")
local triangle_shape = script:GetCustomProperty("triangle_shape")

local node = nil
local data = nil

function init(node_data)
	circle_count.text = tostring(node_data.circle_data_amount)
	plus_count.text = tostring(node_data.plus_data_amount)
	triangle_count.text = tostring(node_data.triangle_data_amount)

	data = {
		
		{ condition = "plus", count = node_data.plus_data_amount, ui = plus_count, asset = plus_shape },
		{ condition = "circle", count = node_data.circle_data_amount, ui = circle_count, asset = circle_shape },
		{ condition = "triangle", count = node_data.triangle_data_amount, ui = triangle_count, asset = triangle_shape }

	}

	node = API.Node_Type.Data:new(script.parent.parent, {

		data_items = data,
		repeat_interval = 0.25

	})

	node:set_from_saved_data(node_data)
	
	API.register_node(node)
end

function Tick(dt)
	if(node ~= nil) then
		for _, i in ipairs(node:get_tweens()) do
			if(i.tween ~= nil) then
				i.tween:tween(dt)
			end
		end
	end
end

Events.Connect("puzzle_edit", function()
	if(is_destroyed or node == nil) then
		return
	end

	node:reset()

	for _, d in ipairs(data) do
		if(Object.IsValid(d.ui)) then
			d.ui.text = tostring(d.count)
		end
	end
end)

Events.Connect("puzzle_run", function(speed)
	if(is_destroyed or node == nil) then
		return
	end

	node:set_speed(speed)
	node:tick()
end)

script.destroyEvent:Connect(function()
	is_destroyed = true
end)