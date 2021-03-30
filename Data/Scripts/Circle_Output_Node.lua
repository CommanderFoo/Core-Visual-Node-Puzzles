local API, YOOTIL = require(script:GetCustomProperty("API"))

local is_destroyed = false

local circle_count = script:GetCustomProperty("circle_count"):WaitForObject()

local condition = script:GetCustomProperty("condition")

local total = 0

local node = API.Node:new(script.parent.parent, {

	on_data_received = function(data, node)
		local error = false

		if(data ~= nil and data.condition ~= nil and string.lower(data.condition) == condition) then
			total = total + data.count
			circle_count.text = tostring(total)

			if(total == data.total_count) then
				API.Puzzle_Events.trigger("output_" .. data.condition .. "_complete")
			end
		else
			node:has_errors(true)
			error = true
		end

		if(error) then
			API.Puzzle_Events.trigger("output_error")
		end
	end

})

API.register_node(node)

Events.Connect("puzzle_edit", function()
	if(is_destroyed) then
		return
	end
	
	if(Object.IsValid(circle_count)) then
		circle_count.text = "0"
		total = 0
		node:hide_error_info()
	end
end)

script.destroyEvent:Connect(function()
	is_destroyed = true
end)