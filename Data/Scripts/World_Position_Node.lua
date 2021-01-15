local API = require(script:GetCustomProperty("API"))
local ui_text = script:GetCustomProperty("ui_text"):WaitForObject()

local node = API.Node.World_Position_Node:new(script)

node:data_received(function()
	local pos = node:get_output_data()

	ui_text.text = string.format("X: %.3s, Y: %.3s, Z: %.3s", pos.x, pos.y, pos.z)
end)

API.register_node(node)