local API = require(script:GetCustomProperty("API"))
local Localization = require(script:GetCustomProperty("Localization"))

local circle_count = script:GetCustomProperty("circle_count"):WaitForObject()
local square_count = script:GetCustomProperty("square_count"):WaitForObject()

local condition_circle = script:GetCustomProperty("condition_circle")
local condition_square = script:GetCustomProperty("condition_square")

local evts = {}
local total_circle = 0
local total_square = 0
local node = nil
local event = "circle_square"
local circle_complete = false
local square_complete = false
local data = {}

local has_sent_exceeded_circle_error = false
local has_sent_exceeded_square_error = false
local has_sent_condition_not_met_error = false

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
						if(not has_sent_exceeded_circle_error) then
							node:has_errors(Localization.get_text("Error_Exceeded_" .. data.condition))
							has_sent_exceeded_circle_error = true
						end

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
						if(not has_sent_exceeded_square_error) then
							node:has_errors(Localization.get_text("Error_Exceeded_" .. data.condition))
							has_sent_exceeded_square_error = true
						end

						error = true
					end
				else
					if(not has_sent_condition_not_met_error) then
						node:has_errors(Localization.get_text("Error_No_Match"))
						has_sent_condition_not_met_error = true
					end
					
					error = true
				end

				if(circle_complete and square_complete) then
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
	API.set_bubble("square", node, data, true)

	API.register_node(node)
end

evts[#evts + 1] = Events.Connect("puzzle_edit", function()
	if(node == nil) then
		return
	end
	
	if(Object.IsValid(circle_count) and Object.IsValid(square_count)) then
		circle_count.text = "0"
		square_count.text = "0"

		total_circle = 0
		total_square = 0
		
		circle_complete = false
		square_complete = false

		has_sent_exceeded_circle_error = false
		has_sent_exceeded_square_error = false
		has_sent_condition_not_met_error = false

		API.set_bubble("circle", node, data, false)
		API.set_bubble("square", node, data, false)

		node:reset()
		node:hide_error_info()
	end
end)

local d_evt = nil

d_evt = script.destroyEvent:Connect(function()
	for k, e in ipairs(evts) do
		if(e.isConnected) then
			e:Disconnect()
		end
	end

	if(d_evt.isConnected) then
		d_evt:Disconnect()
	end

	evts = nil
end)