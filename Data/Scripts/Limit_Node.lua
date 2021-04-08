local API = require(script:GetCustomProperty("API"))

local is_destroyed = false

local node = nil

function init(node_data)
	node = API.Node_Type.Limit:new(script.parent.parent, {

		node_time = 0.4

	})

	node:set_from_saved_data(node_data)
	node:set_limit(node_data.limit)
	
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

script.destroyEvent:Connect(function()
	is_destroyed = true
end)