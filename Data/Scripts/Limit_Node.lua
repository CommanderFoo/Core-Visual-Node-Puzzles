local API = require(script:GetCustomProperty("API"))

local is_destroyed = false

local limit_node = API.Node_Type.Limit:new(script.parent.parent, {

	node_time = 0.4

})

API.register_node(limit_node)

function Tick(dt)
	for _, i in ipairs(limit_node:get_tweens()) do
		if(i.tween ~= nil) then
			i.tween:tween(dt)
		end
	end
end

Events.Connect("puzzle_edit", function()
	if(is_destroyed) then
		return
	end

	limit_node:reset()
end)

script.destroyEvent:Connect(function()
	is_destroyed = true
end)