local API, YOOTIL = require(script:GetCustomProperty("API"))

local first_number = script:GetCustomProperty("first_number"):WaitForObject()
local first_required = script:GetCustomProperty("first_required"):WaitForObject()

local second_number = script:GetCustomProperty("second_number"):WaitForObject()
local second_required = script:GetCustomProperty("second_required"):WaitForObject()

local third_number = script:GetCustomProperty("third_number"):WaitForObject()
local third_required = script:GetCustomProperty("third_required"):WaitForObject()

local conditions = {}

local evts = {}

local node = nil
local data = {}

local has_sent_no_number_match = false

function init(node_data)
	data = node_data
	
	conditions[data.first_number] = {

		required = data.first_required,
		required_txt = first_required,
		received = 0
		
	}

	conditions[data.second_number] = {

		required = data.second_required,
		required_txt = second_required,
		received = 0
		
	}

	conditions[data.third_number] = {

		required = data.third_required,
		required_txt = third_required,
		received = 0
		
	}

	node = API.Node_Type.Output:new(script.parent.parent, {

		on_data_received = function(data, node)
			local error = false

			if(data ~= nil) then
				local has_match = false

				for n, o in pairs(conditions) do
					if(n == data.value and o.required ~= o.received) then
						has_match = true

						o.received = o.received + 1
						o.required_txt.text = tostring(math.max(0, o.required - o.received))

						if(o.received == o.required) then
							API.Puzzle_Events.trigger("output_three_number_complete")
						end
					end
				end

				if(not has_match) then
					if(not has_sent_no_number_match) then
						node:has_errors("Input data does not match required data.")
						has_sent_no_number_match = true
					end

					error = true
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

	first_number.text = string.format("%.0f", data.first_number)
	first_required.text = tostring(data.first_required)

	second_number.text = string.format("%.0f", data.second_number)
	second_required.text = tostring(data.second_required)

	third_number.text = string.format("%.0f", data.third_number)
	third_required.text = tostring(data.third_required)

	node:set_from_saved_data(node_data)
	API.register_node(node)
end

evts[#evts + 1] = Events.Connect("puzzle_edit", function()
	if(node == nil) then
		return
	end
	
	if(Object.IsValid(first_number)) then
		for n, o in pairs(conditions) do
			o.received = 0
			o.required_txt.text = tostring(o.required)
		end

		has_sent_no_number_match = false
		
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