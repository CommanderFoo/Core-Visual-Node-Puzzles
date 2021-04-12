local API = require(script:GetCustomProperty("API"))

local is_destroyed = false

local first = script:GetCustomProperty("first"):WaitForObject()
local first_data_amount = script:GetCustomProperty("first_data_amount"):WaitForObject()

local text_asset = script:GetCustomProperty("text_asset")

local node = nil
local data = nil

function init(node_data)
	first.text = tostring(node_data.first)
	first_data_amount.text = tostring(node_data.first_data_amount)

	data = {
	
		{ value = node_data.first, count = node_data.first_data_amount, final_total = node_data.first_final_total, ui = first_data_amount, asset = text_asset }
	
	}

	node = API.Node_Type.Data:new(script.parent.parent, {

		data_items = data,
		repeat_interval = 0.25
	
	})
	
	node:set_puzzle_type(API.Puzzle_Type.MATH)
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