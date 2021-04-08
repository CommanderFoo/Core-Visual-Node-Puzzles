local API, YOOTIL = require(script:GetCustomProperty("API"))

local circle_count = script:GetCustomProperty("circle_count"):WaitForObject()
local square_count = script:GetCustomProperty("square_count"):WaitForObject()
local triangle_count = script:GetCustomProperty("triangle_count"):WaitForObject()

local condition_circle = script:GetCustomProperty("condition_circle")
local condition_square = script:GetCustomProperty("condition_square")
local condition_triangle = script:GetCustomProperty("condition_triangle")

local is_destroyed = false
local total_circle = 0
local total_square = 0
local total_triangle = 0
local node = nil
local event = "circle_square_triangle"
local circle_complete = false
local square_complete = false
local triangle_complete = false
local data = {}

function init(node_data)
	data = node_data

	node = API.Node_Type.Output:new(script.parent.parent, {

		on_data_received = function(data, node)
			local error = false

			if(data ~= nil and data.condition ~= nil) then
				local c = string.lower(data.condition)
				
				if(c == condition_circle) then
					total_circle = total_circle + data.count
				
					local total_str = tostring(total_circle)
					local amount = data.total_count

					if(node_data.circle_data_amount ~= nil and node_data.circle_data_amount > 0) then
						amount = node_data.circle_data_amount

						total_str = total_str .. " / " .. tostring(amount)
					end

					circle_count.text = total_str

					if(total_circle == amount) then
						circle_complete = true
					elseif(total_circle > amount) then
						node:has_errors(true)
						error = true
					end
				elseif(c == condition_square) then
					total_square = total_square + data.count
				
					local total_str = tostring(total_square)
					local amount = data.total_count

					if(node_data.square_data_amount ~= nil and node_data.square_data_amount > 0) then
						amount = node_data.square_data_amount

						total_str = total_str .. " / " .. tostring(amount)
					end

					square_count.text = total_str

					if(total_square == amount) then
						square_complete = true
					elseif(total_square > amount) then
						node:has_errors(true)
						error = true
					end
				elseif(c == condition_triangle) then
					total_triangle = total_triangle + data.count
				
					local total_str = tostring(total_triangle)
					local amount = data.total_count

					if(node_data.triangle_data_amount ~= nil and node_data.triangle_data_amount > 0) then
						amount = node_data.triangle_data_amount

						total_str = total_str .. " / " .. tostring(amount)
					end

					triangle_count.text = total_str

					if(total_triangle == amount) then
						triangle_complete = true
					elseif(total_triangle > amount) then
						node:has_errors(true)
						error = true
					end
				end

				if(circle_complete and square_complete and triangle_complete) then
					print("ok 3")
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

	node:set_internal_id(node_data.id)

	API.set_bubble("circle", node, data, true)
	API.set_bubble("square", node, data, true)
	API.set_bubble("triangle", node, data, true)
	API.register_node(node)
end

Events.Connect("puzzle_edit", function()
	if(is_destroyed or node == nil) then
		return
	end
	
	if(Object.IsValid(circle_count) and Object.IsValid(square_count) and Object.IsValid(triangle_count)) then
		circle_count.text = "0"
		square_count.text = "0"
		triangle_count.text = "0"

		total_circle = 0
		total_square = 0
		total_triangle = 0

		circle_complete = false
		square_complete = false
		triangle_complete = false

		API.set_bubble("circle", node, data, false)
		API.set_bubble("square", node, data, false)
		API.set_bubble("triangle", node, data, false)
		
		node:hide_error_info()
	end
end)

script.destroyEvent:Connect(function()
	is_destroyed = true
end)