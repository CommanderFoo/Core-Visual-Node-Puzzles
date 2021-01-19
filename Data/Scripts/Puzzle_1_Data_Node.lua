local API, YOOTIL = require(script:GetCustomProperty("API"))

local red_count = script:GetCustomProperty("red_count"):WaitForObject()
local green_count = script:GetCustomProperty("green_count"):WaitForObject()

local red_apple = script:GetCustomProperty("red_apple")
local green_apple = script:GetCustomProperty("green_apple")

local data = {
	
	{ condition = "red", count = 10, ui = red_count, asset = red_apple },
	{ condition = "green", count = 10, ui = green_count, asset = green_apple }

}

local data_node = API.Node_Type.Data:new(script.parent.parent, {

	data_items = data,
	YOOTIL = YOOTIL,
	repeat_interval = 0.25

})

API.register_node(data_node)

function Tick(dt)
	for _, i in ipairs(data_node:get_tweens()) do
		if(i.tween ~= nil) then
			i.tween:tween(dt)
		end
	end
end

Events.Connect("puzzle_edit", function()
	data_node:reset()

	for _, d in ipairs(data) do
		d.ui.text = tostring(d.count)
	end
end)

Events.Connect("puzzle_run", function(speed)
	data_node:set_speed(speed)
	data_node:tick()
end)