local API, YOOTIL = require(script:GetCustomProperty("API"))

local container = script:GetCustomProperty("container"):WaitForObject()
local dropdown_event = script:GetCustomProperty("dropdown_event")

local tween_items = {}

local if_node = API.Node_Type.If:new(script.parent.parent, {

	tween_items = tween_items,
	container = container,
	YOOTIL = YOOTIL

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