local API, YOOTIL = require(script:GetCustomProperty("API"))

local is_destroyed = false

local limiter_node = API.Node_Type.Limiter:new(script.parent.parent, {

	YOOTIL = YOOTIL,
	node_time = 0.4

})

API.register_node(limiter_node)

function Tick(dt)
	for _, i in ipairs(limiter_node:get_tweens()) do
		if(i.tween ~= nil) then
			i.tween:tween(dt)
		end
	end
end

Events.Connect("puzzle_edit", function()
	if(is_destroyed) then
		return
	end

	limiter_node:reset()
end)

script.destroyEvent:Connect(function()
	is_destroyed = true
end)