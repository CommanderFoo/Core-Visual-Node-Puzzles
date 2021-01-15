local API, YOOTIL = require(script:GetCustomProperty("API"))

local root = script:FindTemplateRoot()
local count = root:GetCustomProperty("count"):WaitForObject()

local node = API.Node:new(script)

local total = 0

node:data_received(function(data)
	if(data.color == "Red") then
		total = total + data.count
		count.text = tostring(total)
	else
		node:has_errors(true)
	end
end)

API.register_node(node)