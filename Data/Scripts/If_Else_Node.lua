﻿local API, YOOTIL = require(script:GetCustomProperty("API"))

local dropdown_event = script.parent.parent.id

local if_node = API.Node_Type.If:new(script.parent.parent, {

	YOOTIL = YOOTIL,
	node_time = 0.3

})

API.register_node(if_node)

function Tick(dt)
	for _, i in ipairs(if_node:get_tweens()) do
		if(i.tween ~= nil) then
			i.tween:tween(dt)
		end
	end
end

Events.Connect("on_" .. dropdown_event .. "_selected", function(index, option, value)
	if_node:set_option("if_condition", string.lower(option.text))
end)

Events.Connect("puzzle_edit", function()
	if_node:reset()
end)