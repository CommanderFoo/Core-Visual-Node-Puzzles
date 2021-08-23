local API, YOOTIL = require(script:GetCustomProperty("API"))

local first_number = script:GetCustomProperty("first_number"):WaitForObject()
local first_required = script:GetCustomProperty("first_required"):WaitForObject()

local conditions = {}

local evts = {}

local node = nil
local data = {}

function init(node_data)
	data = node_data
	
	conditions[data.first_number] = {

		required = data.first_required,
		required_txt = first_required,
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
							API.Puzzle_Events.trigger("output_one_number_complete")
						end
					end
				end

				if(not has_match) then
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

	first_number.text = string.format("%.0f", data.first_number)
	first_required.text = tostring(data.first_required)

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

		node:reset()
		node:hide_error_info()
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