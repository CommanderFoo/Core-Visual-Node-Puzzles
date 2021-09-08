local API = require(script:GetCustomProperty("API"))

local circle_count = script:GetCustomProperty("circle_count"):WaitForObject()
local plus_count = script:GetCustomProperty("plus_count"):WaitForObject()
local triangle_count = script:GetCustomProperty("triangle_count"):WaitForObject()

local condition_circle = script:GetCustomProperty("condition_circle")
local condition_plus = script:GetCustomProperty("condition_plus")
local condition_triangle = script:GetCustomProperty("condition_triangle")

local evts = {}
local total_circle = 0
local total_plus = 0
local total_triangle = 0
local node = nil
local event = "ordered_circle_plus_triangle"
local circle_complete = false
local plus_complete = false
local triangle_complete = false
local data = {}

local has_sent_exceeded_circle_error = false
local has_sent_exceeded_plus_error = false
local has_sent_exceeded_triangle_error = false
local has_sent_order_error = false

function init(node_data)
	data = node_data

	node = API.Node_Type.Output:new(script.parent.parent, {

		sub_type = "Ordered",
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
						
						node:check_halting()
					elseif(total_circle > amount) then
						if(not has_sent_exceeded_circle_error) then
							node:has_errors("Data (" .. data.condition .. ") has exceeded required amount.")
							has_sent_exceeded_circle_error = true
						end
						
						error = true
					end
				elseif(c == condition_plus and circle_complete) then
					total_plus = total_plus + data.count
				
					local total_str = tostring(total_plus)
					local amount = data.total_count

					if(node_data.plus_data_amount ~= nil and node_data.plus_data_amount > 0) then
						amount = node_data.plus_data_amount

						total_str = total_str .. " / " .. tostring(amount)
					end

					plus_count.text = total_str

					if(total_plus == amount) then
						plus_complete = true

						node:check_halting()
					elseif(total_plus > amount) then
						if(not has_sent_exceeded_plus_error) then
							node:has_errors("Data (" .. data.condition .. ") has exceeded required amount.")
							has_sent_exceeded_plus_error = true
						end

						error = true
					end
				elseif(c == condition_triangle and circle_complete and plus_complete) then
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
						if(not has_sent_exceeded_triangle_error) then
							node:has_errors("Data (" .. data.condition .. ") has exceeded required amount.")
							has_sent_exceeded_triangle_error = true
						end

						error = true
					end
				else
					if(not has_sent_order_error) then
						node:has_errors("Input data is not in the correct order.")
						has_sent_order_error = true
					end
					
					error = true
				end

				if(circle_complete and plus_complete and triangle_complete) then
					API.Puzzle_Events.trigger("output_" .. event .. "_complete")
				end
			else
				node:has_errors()
				error = true
			end

			if(error) then
				API.Puzzle_Events.trigger("output_error")
			end
		end

	})

	node:set_from_saved_data(node_data)
	
	API.set_bubble("circle", node, data, true)
	API.set_bubble("plus", node, data, true)
	API.set_bubble("triangle", node, data, true)

	API.register_node(node)
end

evts[#evts + 1] = Events.Connect("puzzle_edit", function()
	if(node == nil) then
		return
	end
	
	if(Object.IsValid(circle_count) and Object.IsValid(plus_count) and Object.IsValid(triangle_count)) then
		circle_count.text = "0"
		plus_count.text = "0"
		triangle_count.text = "0"

		total_circle = 0
		total_plus = 0
		total_triangle = 0

		circle_complete = false
		plus_complete = false
		triangle_complete = false

		has_sent_exceeded_circle_error = false
		has_sent_exceeded_plus_error = false
		has_sent_exceeded_triangle_error = false
		has_sent_order_error = false

		API.set_bubble("circle", node, data, false)
		API.set_bubble("plus", node, data, false)
		API.set_bubble("triangle", node, data, false)

		node:hide_error_info()
		node:reset()
	end
end)

script.destroyEvent:Connect(function()
	for k, e in ipairs(evts) do
		if(e.isConnected) then
			e:Disconnect()
		end
	end

	evts = nil
end)