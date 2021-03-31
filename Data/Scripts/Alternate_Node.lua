local API, YOOTIL = require(script:GetCustomProperty("API"))

local is_destroyed = false

local node = API.Node_Type.Alternate:new(script.parent.parent, {

	YOOTIL = YOOTIL,
	node_time = 0.1

})

API.register_node(node)

function Tick(dt)
	for _, i in ipairs(node:get_tweens()) do
		if(i.tween ~= nil) then
			i.tween:tween(dt)
		end
	end
end

Events.Connect("puzzle_edit", function()
	if(is_destroyed) then
		return
	end

	node:reset()
end)

script.destroyEvent:Connect(function()
	is_destroyed = true
end)