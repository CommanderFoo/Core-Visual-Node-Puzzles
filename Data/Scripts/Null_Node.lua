local API = require(script:GetCustomProperty("API"))

local total_data_received = 0

local node = API.Node:new(script.parent.parent, {

	on_data_received = function(data, node)
		total_data_received = total_data_received + 1

		if(total_data_received == 10) then
			API.Puzzle_Events.trigger("output_null_complete")
		end
	end

})

API.register_node(node)