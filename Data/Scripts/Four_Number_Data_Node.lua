local API, YOOTIL = require(script:GetCustomProperty("API"))

local evts = {}

local first_number = script:GetCustomProperty("first_number"):WaitForObject()
local first_count = script:GetCustomProperty("first_count"):WaitForObject()

local second_number = script:GetCustomProperty("second_number"):WaitForObject()
local second_count = script:GetCustomProperty("second_count"):WaitForObject()

local third_number = script:GetCustomProperty("third_number"):WaitForObject()
local third_count = script:GetCustomProperty("third_count"):WaitForObject()

local fourth_number = script:GetCustomProperty("fourth_number"):WaitForObject()
local fourth_count = script:GetCustomProperty("fourth_count"):WaitForObject()

local text_asset = script:GetCustomProperty("text_asset")

local node = nil
local data = nil
local paused = false

function init(node_data)
	first_number.text = string.format("%.02f", node_data.first_number)
	first_count.text = tostring(node_data.first_count)

	second_number.text = string.format("%.02f", node_data.second_number)
	second_count.text = tostring(node_data.second_count)

	third_number.text = string.format("%.02f", node_data.third_number)
	third_count.text = tostring(node_data.third_count)

	fourth_number.text = string.format("%.02f", node_data.fourth_number)
	fourth_count.text = tostring(node_data.fourth_count)

	data = {
	
		{ value = node_data.first_number, count = node_data.first_count, ui = first_count, asset = text_asset },
		{ value = node_data.second_number, count = node_data.second_count, ui = second_count, asset = text_asset },
		{ value = node_data.third_number, count = node_data.third_count, ui = third_count, asset = text_asset },
		{ value = node_data.fourth_number, count = node_data.fourth_count, ui = fourth_count, asset = text_asset }
	
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
	if(node ~= nil and not paused) then
		for _, i in ipairs(node:get_tweens()) do
			if(i.tween ~= nil) then
				i.tween:tween(dt)
			end
		end
	end
end

Events.Connect("pause", function()
	paused = true
end)

Events.Connect("unpause", function()
	paused = false
end)

evts[#evts + 1] = Events.Connect("puzzle_edit", function()
	if(node == nil) then
		return
	end

	for _, d in ipairs(data) do
		if(Object.IsValid(d.ui)) then
			d.ui.text = tostring(d.count)
		end
	end
	
	node:reset()
end)

evts[#evts + 1] = Events.Connect("puzzle_run", function(speed)
	if(node == nil) then
		return
	end

	node:set_speed(speed)
	node:tick()
end)

script.destroyEvent:Connect(function()
	for k, e in ipairs(evts) do
		if(e.isConnected) then
			e:Disconnect()
		end
	end

	evts = nil
end)