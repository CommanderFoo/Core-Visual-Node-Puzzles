﻿local API, YOOTIL = require(script:GetCustomProperty("API"))

local circle_count = script:GetCustomProperty("circle_count"):WaitForObject()

local condition = script:GetCustomProperty("condition")

local is_destroyed = false
local total = 0
local node = nil

function init(data_amounts)
	node = API.Node:new(script.parent.parent, {

		on_data_received = function(data, node)
			local error = false

			if(data ~= nil and data.condition ~= nil and string.lower(data.condition) == condition) then
				total = total + data.count
				
				local total_str = tostring(total)
				local amount = data.total_count

				if(data_amounts.required ~= nil and data_amounts.required > 0) then
					amount = data_amounts.required

					total_str = total_str .. " / " .. tostring(amount)
				end

				circle_count.text = total_str

				if(total == amount) then
					API.Puzzle_Events.trigger("output_" .. data.condition .. "_complete")
				elseif(total > amount) then
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

	if(data_amounts.required ~= nil and data_amounts.required > 0) then
		local bubble = node:get_bubble()
		local txt = "0 / " .. tostring(data_amounts.required)

		bubble:FindChildByName("Count").text = txt

		if(string.len(txt) > 5) then
			bubble.width = bubble.width + 20
		end
	end

	API.register_node(node)
end

Events.Connect("puzzle_edit", function()
	if(is_destroyed or node == nil) then
		return
	end
	
	if(Object.IsValid(circle_count)) then
		circle_count.text = "0"
		total = 0
		node:hide_error_info()
	end
end)

script.destroyEvent:Connect(function()
	is_destroyed = true
end)