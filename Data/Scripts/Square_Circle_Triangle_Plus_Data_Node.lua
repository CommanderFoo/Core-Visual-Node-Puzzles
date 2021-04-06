local API = require(script:GetCustomProperty("API"))

local is_destroyed = false

local square_count = script:GetCustomProperty("square_count"):WaitForObject()
local circle_count = script:GetCustomProperty("circle_count"):WaitForObject()
local triangle_count = script:GetCustomProperty("triangle_count"):WaitForObject()
local plus_count = script:GetCustomProperty("plus_count"):WaitForObject()

local square_shape = script:GetCustomProperty("square_shape")
local circle_shape = script:GetCustomProperty("circle_shape")
local triangle_shape = script:GetCustomProperty("triangle_shape")
local plus_shape = script:GetCustomProperty("plus_shape")

local data_node = nil
local data = nil

function init(data_amounts)
	circle_count.text = tostring(data_amounts.circle_data_amount)
	square_count.text = tostring(data_amounts.square_data_amount)
	triangle_count.text = tostring(data_amounts.triangle_data_amount)
	plus_count.text = tostring(data_amounts.plus_data_amount)

	data = {
		
		{ condition = "square", count = data_amounts.square_data_amount, ui = square_count, asset = square_shape },
		{ condition = "circle", count = data_amounts.circle_data_amount, ui = circle_count, asset = circle_shape },
		{ condition = "triangle", count = data_amounts.triangle_data_amount, ui = triangle_count, asset = triangle_shape },
		{ condition = "plus", count = data_amounts.plus_data_amount, ui = plus_count, asset = plus_shape }

	}

	data_node = API.Node_Type.Data:new(script.parent.parent, {

		data_items = data,
		repeat_interval = 0.25

	})

	API.register_node(data_node)
end

function Tick(dt)
	if(data_node ~= nil) then
		for _, i in ipairs(data_node:get_tweens()) do
			if(i.tween ~= nil) then
				i.tween:tween(dt)
			end
		end
	end
end

Events.Connect("puzzle_edit", function()
	if(is_destroyed or data_node == nil) then
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
	if(is_destroyed or data_node == nil) then
		return
	end

	data_node:set_speed(speed)
	data_node:tick()
end)

script.destroyEvent:Connect(function()
	is_destroyed = true
end)

--init({ circle_data_amount = 10, square_data_amount = 10, triangle_data_amount = 10, plus_data_amount = 10 })