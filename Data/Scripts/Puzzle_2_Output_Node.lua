local API, YOOTIL = require(script:GetCustomProperty("API"))

local count = script:GetCustomProperty("count"):WaitForObject()
local color = script:GetCustomProperty("color")

local total = 0

API.register_node(API.Node:new(script.parent.parent, {

	on_data_received = function(data, node)
		if(data ~= nil and data.color ~= nil and string.lower(data.color) == color) then
			total = total + data.count
			count.text = tostring(total)
		else
			node:has_errors(true)
		end
	end

}))