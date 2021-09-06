local API = require(script:GetCustomProperty("API"))

local plus_count = script:GetCustomProperty("plus_count"):WaitForObject()
local square_count = script:GetCustomProperty("square_count"):WaitForObject()

local condition_plus = script:GetCustomProperty("condition_plus")
local condition_square = script:GetCustomProperty("condition_square")

local evts = {}
local total_plus = 0
local total_square = 0
local node = nil
local event = "ordered_plus_square"
local plus_complete = false
local square_complete = false
local data = {}

function init(node_data)
	data = node_data

	node = API.Node_Type.Output:new(script.parent.parent, {

		sub_type = "Ordered",
		on_data_received = function(data, node)
			local error = false

			if(data ~= nil and data.condition ~= nil) then
				local c = string.lower(data.condition)
				
				if(c == condition_plus) then
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
						node:has_errors()
						error = true
					end
				elseif(c == condition_square and plus_complete) then
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
						node:has_errors()
						error = true
					end
				else
					node:has_errors()
					error = true
				end

				if(plus_complete and square_complete) then
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
	
	API.set_bubble("plus", node, data, true)
	API.set_bubble("square", node, data, true)
	API.register_node(node)
end

evts[#evts + 1] = Events.Connect("puzzle_edit", function()
	if(node == nil) then
		return
	end
	
	if(Object.IsValid(plus_count) and Object.IsValid(square_count)) then
		plus_count.text = "0"
		square_count.text = "0"

		total_plus = 0
		total_square = 0

		plus_complete = false
		square_complete = false

		API.set_bubble("plus", node, data, false)
		API.set_bubble("square", node, data, false)
		
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