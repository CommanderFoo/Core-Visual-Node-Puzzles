local API = require(script:GetCustomProperty("API"))
local Localization = require(script:GetCustomProperty("Localization"))

local circle_count = script:GetCustomProperty("circle_count"):WaitForObject()
local plus_count = script:GetCustomProperty("plus_count"):WaitForObject()

local condition_circle = script:GetCustomProperty("condition_circle")
local condition_plus = script:GetCustomProperty("condition_plus")

local evts = {}
local total_circle = 0
local total_plus = 0
local node = nil
local event = "ordered_circle_plus"
local circle_complete = false
local plus_complete = false
local data = {}

local has_sent_exceeded_circle_error = false
local has_sent_exceeded_plus_error = false
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
							node:has_errors(Localization.get_text("Error_Exceeded_" .. data.condition))
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
							node:has_errors(Localization.get_text("Error_Exceeded_" .. data.condition))
							has_sent_exceeded_plus_error = true
						end

						error = true
					end
				else
					if(not has_sent_order_error) then
						node:has_errors(Localization.get_text("Error_Wrong_Order"))
						has_sent_order_error = true
					end
					
					error = true
				end

				if(circle_complete and plus_complete) then
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

	API.register_node(node)
end

evts[#evts + 1] = Events.Connect("puzzle_edit", function()
	if(node == nil) then
		return
	end
	
	if(Object.IsValid(circle_count) and Object.IsValid(plus_count)) then
		circle_count.text = "0"
		plus_count.text = "0"

		total_circle = 0
		total_plus = 0

		circle_complete = false
		plus_complete = false

		has_sent_exceeded_circle_error = false
		has_sent_exceeded_plus_error = false
		has_sent_order_error = false

		API.set_bubble("circle", node, data, false)
		API.set_bubble("plus", node, data, false)

		node:hide_error_info()
		node:reset()
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