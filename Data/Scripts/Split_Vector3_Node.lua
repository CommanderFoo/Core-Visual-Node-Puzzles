local API = require(script:GetCustomProperty("API"))

local ui_x = script:GetCustomProperty("ui_x"):WaitForObject()
local ui_y = script:GetCustomProperty("ui_y"):WaitForObject()
local ui_z = script:GetCustomProperty("ui_z"):WaitForObject()

local node = API.Node.Split_Vector3_Node:new(script)

node:data_received(function()
	local pos = node:get_input_data()
	
	ui_x.text = string.format("X: %.3s", pos.x)
	ui_y.text = string.format("X: %.3s", pos.y)
	ui_z.text = string.format("X: %.3s", pos.z)
end)

API.register_node(node)