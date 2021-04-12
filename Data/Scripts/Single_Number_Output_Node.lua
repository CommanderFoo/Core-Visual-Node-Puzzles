local API, YOOTIL = require(script:GetCustomProperty("API"))

local first_total = script:GetCustomProperty("first_total"):WaitForObject()
local first_final_total = script:GetCustomProperty("first_final_total"):WaitForObject()

local is_destroyed = false

local node = nil
local data = {}

local first_total_value = 0

function init(node_data)
	data = node_data
	
	node = API.Node_Type.Output:new(script.parent.parent, {

		on_data_received = function(data, node)
			local error = false

			if(data ~= nil) then
				first_total_value = first_total_value + data.value
				first_total.text = tostring(first_total_value)

				if(first_total_value == data.final_total) then
					API.Puzzle_Events.trigger("output_first_complete")
				elseif(first_total_value > data.final_total) then
					node:has_errors(true)
					error = true
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

	first_final_total.text = tostring(node_data.first_final_total)

	node:set_from_saved_data(node_data)
	API.register_node(node)
end

Events.Connect("puzzle_edit", function()
	if(is_destroyed or node == nil) then
		return
	end
	
	if(Object.IsValid(first_total)) then
		first_total.text = "0"
		first_total_value = 0

		node:hide_error_info()
	end
end)

script.destroyEvent:Connect(function()
	is_destroyed = true
end)