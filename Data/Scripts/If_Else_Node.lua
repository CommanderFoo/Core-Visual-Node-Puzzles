local API = require(script:GetCustomProperty("API"))

local is_destroyed = false

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

Events.Connect("on_" .. script.parent.parent.id .. "_selected", function(index, option, value)
	if(is_destroyed or node == nil) then
		return
	end
	
	node:set_option("if_condition", string.lower(option:FindChildByName("Text").text))
end)

Events.Connect("puzzle_edit", function()
	if(is_destroyed or node == nil) then
		return
	end

	node:reset()
end)

script.destroyEvent:Connect(function()
	is_destroyed = true
end)