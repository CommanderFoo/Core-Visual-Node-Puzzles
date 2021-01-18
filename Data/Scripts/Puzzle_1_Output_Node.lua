local API, YOOTIL = require(script:GetCustomProperty("API"))

local count = script:GetCustomProperty("count"):WaitForObject()
local color = script:GetCustomProperty("color")

local node = API.Node:new(script.parent.parent)

local total = 0

node:stop_data_flow()

node:data_received(function(data)
	if(string.lower(data.color) == color) then
		total = total + data.count
		count.text = tostring(total)
	else
		node:has_errors(true)
	end
end)

API.register_node(node)