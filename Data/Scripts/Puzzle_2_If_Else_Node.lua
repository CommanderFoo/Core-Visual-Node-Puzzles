local API, YOOTIL = require(script:GetCustomProperty("API"))

local dropdown_event = script:GetCustomProperty("dropdown_event")

local tween_items = {}

local if_node = API.Node_Type.If:new(script.parent.parent, {

	tween_items = tween_items,
	YOOTIL = YOOTIL,
	tween_duration = .8

})

API.register_node(if_node)

function Tick(dt)
	for _, i in ipairs(tween_items) do
		if(i.tween ~= nil) then
			i.tween:tween(dt)
		end
	end
end

Events.Connect("on_" .. dropdown_event .. "_selected", function(index, option, value)
	if_node:set_option("if_condition", string.lower(option.text))
end)

Events.Connect("on_" .. dropdown_event .. "_focused", function()
	if_node:move_to_front()
end)