local API = require(script:GetCustomProperty("API"))

local evts = {}

local circle_count = script:GetCustomProperty("circle_count"):WaitForObject()
local circle_shape = script:GetCustomProperty("circle_shape")

local node = nil
local data = nil

function init(node_data)
	circle_count.text = tostring(node_data.circle_data_amount)

	data = {
	
		{ condition = "circle", count = node_data.circle_data_amount, ui = circle_count, asset = circle_shape }
	
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

evts[#evts + 1] = Events.Connect("puzzle_edit", function()
	if(node == nil) then
		return
	end

	node:reset()

	for _, d in ipairs(data) do
		if(Object.IsValid(d.ui)) then
			d.ui.text = tostring(d.count)
		end
	end
end)

evts[#evts + 1] = Events.Connect("puzzle_run", function(speed)
	if(node == nil) then
		return
	end

	node:set_speed(speed)
	node:tick()
end)

local d_evt = nil

d_evt = script.destroyEvent:Connect(function()
	for k, e in ipairs(evts) do
		if(e.isConnected) then
			e:Disconnect()
		end
	end

	if(d_evt.isConnected) then
		d_evt:Disconnect()
	end

	evts = nil
end)