local API = require(script:GetCustomProperty("API"))

local triangle_count = script:GetCustomProperty("triangle_count"):WaitForObject()

local condition = script:GetCustomProperty("condition")

local evts = {}
local total = 0
local node = nil
local data = {}

local has_sent_exceeded_triangle_error = false
local has_sent_condition_not_met_error = false

function init(node_data)
	data = node_data
	
	node = API.Node_Type.Output:new(script.parent.parent, {

		on_data_received = function(data, node)
			local error = false

			if(data ~= nil and data.condition ~= nil and string.lower(data.condition) == condition) then
				total = total + data.count
				
				local total_str = tostring(total)
				local amount = data.total_count

				if(node_data.triangle_data_amount ~= nil and node_data.triangle_data_amount > 0) then
					amount = node_data.triangle_data_amount

					total_str = total_str .. " / " .. tostring(amount)
				end

				triangle_count.text = total_str

				if(total == amount) then
					API.Puzzle_Events.trigger("output_" .. data.condition .. "_complete")
				elseif(total > amount) then
					if(not has_sent_exceeded_triangle_error) then
						node:has_errors("Data (" .. data.condition .. ") has exceeded required amount.")
						has_sent_exceeded_triangle_error = true
					end

					error = true
				end
			else
				if(not has_sent_condition_not_met_error) then
					node:has_errors("Input data does not match required data.")
					has_sent_condition_not_met_error = true
				end

				error = true
			end

			if(error) then
				API.Puzzle_Events.trigger("output_error")
			end
		end

	})

	node:set_from_saved_data(node_data)
	
	API.set_bubble("triangle", node, data, true)
	API.register_node(node)
end

evts[#evts + 1] = Events.Connect("puzzle_edit", function()
	if(node == nil) then
		return
	end
	
	if(Object.IsValid(triangle_count)) then
		triangle_count.text = "0"
		total = 0

		has_sent_exceeded_triangle_error = false
		has_sent_condition_not_met_error = false

		API.set_bubble("triangle", node, data, false)

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