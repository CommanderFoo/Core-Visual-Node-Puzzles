local API = require(script:GetCustomProperty("API"))

local evts = {}

local node = nil

function init(node_data)
	
	node = API.Node_Type.If:new(script.parent.parent, {

		node_time = 0.3
	
	})

	node:set_from_saved_data(node_data)

	if(node_data.condition) then
		if(node_data.condition == "s") then
			node:set_option("if_condition", "square")
		elseif(node_data.condition == "c") then
			node:set_option("if_condition", "circle")
		elseif(node_data.condition == "t") then
			node:set_option("if_condition", "triangle")
		elseif(node_data.condition == "p") then
			node:set_option("if_condition", "plus")
		end

		Events.Broadcast("on_set_" .. script.parent.parent.id .. "_selected", node_data.condition)
	end

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

evts[#evts + 1] = Events.Connect("on_" .. script.parent.parent.id .. "_selected", function(index, option, value)
	if(node == nil) then
		return
	end
	
	node:set_option("if_condition", string.lower(option:FindChildByName("Text").text))
end)

evts[#evts + 1] = Events.Connect("puzzle_edit", function()
	if(node == nil) then
		return
	end

	node:reset()
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