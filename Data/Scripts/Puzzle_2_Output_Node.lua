local API, YOOTIL = require(script:GetCustomProperty("API"))

local count = script:GetCustomProperty("count"):WaitForObject()
local condition = script:GetCustomProperty("condition")

local total = 0

API.register_node(API.Node:new(script.parent.parent, {

	on_data_received = function(data, node)
		if(data ~= nil and data.condition ~= nil and string.lower(data.condition) == condition) then
			total = total + data.count
			count.text = tostring(total)

			if(total == data.total_count) then
				API.Puzzle_Events.trigger("output_2_complete")
			end
		else
			node:has_errors(true)
		end
	end

}))