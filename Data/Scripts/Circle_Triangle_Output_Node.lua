local API = require(script:GetCustomProperty("API"))

local triangle_count = script:GetCustomProperty("triangle_count"):WaitForObject()
local circle_count = script:GetCustomProperty("circle_count"):WaitForObject()

local condition_triangle = script:GetCustomProperty("condition_triangle")
local condition_circle = script:GetCustomProperty("condition_circle")

local is_destroyed = false
local total_triangle = 0
local total_circle = 0
local node = nil
local event = "triangle_circle"
local triangle_complete = false
local circle_complete = false
local data = {}

function init(data_amounts)
	data = data_amounts

	node = API.Node_Type.Output:new(script.parent.parent, {

		on_data_received = function(data, node)
			local error = false

			if(data ~= nil and data.condition ~= nil) then
				local c = string.lower(data.condition)
				
				if(c == condition_triangle) then
					total_triangle = total_triangle + data.count
				
					local total_str = tostring(total_triangle)
					local amount = data.total_count

					if(data_amounts.triangle_data_amount ~= nil and data_amounts.triangle_data_amount > 0) then
						amount = data_amounts.triangle_data_amount

						total_str = total_str .. " / " .. tostring(amount)
					end

					triangle_count.text = total_str

					if(total_triangle == amount) then
						triangle_complete = true
					elseif(total_triangle > amount) then
						node:has_errors(true)
						error = true
					end
				elseif(c == condition_circle) then
					total_circle = total_circle + data.count
				
					local total_str = tostring(total_circle)
					local amount = data.total_count

					if(data_amounts.circle_data_amount ~= nil and data_amounts.circle_data_amount > 0) then
						amount = data_amounts.circle_data_amount

						total_str = total_str .. " / " .. tostring(amount)
					end

					circle_count.text = total_str

					if(total_circle == amount) then
						circle_complete = true
					elseif(total_circle > amount) then
						node:has_errors(true)
						error = true
					end
				end

				if(triangle_complete and circle_complete) then
					API.Puzzle_Events.trigger("output_" .. event .. "_complete")
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

	API.set_bubble("triangle", node, data, true)
	API.set_bubble("circle", node, data, true)
	API.register_node(node)
end

Events.Connect("puzzle_edit", function()
	if(is_destroyed or node == nil) then
		return
	end
	
	if(Object.IsValid(triangle_count) and Object.IsValid(circle_count)) then
		triangle_count.text = "0"
		circle_count.text = "0"

		total_triangle = 0
		total_circle = 0

		triangle_complete = false
		circle_complete = false

		API.set_bubble("triangle", node, data, false)
		API.set_bubble("circle", node, data, false)
		node:hide_error_info()
	end
end)

script.destroyEvent:Connect(function()
	is_destroyed = true
end)