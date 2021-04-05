local API, YOOTIL = require(script:GetCustomProperty("API"))

local is_destroyed = false

local halt_node = API.Node_Type.Halt:new(script.parent.parent, {

	YOOTIL = YOOTIL,
	node_time = 0.05

})

API.register_node(halt_node)

function Tick(dt)
	for _, i in ipairs(halt_node:get_tweens()) do
		if(i.tween ~= nil) then
			i.tween:tween(dt)
		end
	end
end

Events.Connect("puzzle_edit", function()
	if(is_destroyed) then
		return
	end

	halt_node:reset()
end)

script.destroyEvent:Connect(function()
	is_destroyed = true
end)