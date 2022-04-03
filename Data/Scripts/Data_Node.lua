local API = require(script:GetCustomProperty("API"))

local data = {
	
	--{ condition = "red", count = 10, ui = red_count, asset = red_apple },
	
}

local tween_items = {}

API.register_node(API.Node_Type.Data:new(script.parent.parent, {

	tween_items = tween_items,
	data_items = data,
	repeat_interval = 0.1,
	tween_duration = .8

}))

function Tick(dt)
	for _, i in ipairs(tween_items) do
		if(i.tween ~= nil) then
			i.tween:tween(dt)
		end
	end
end