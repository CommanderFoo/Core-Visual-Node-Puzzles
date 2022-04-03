local API = require(script:GetCustomProperty("API"))

local count = script:GetCustomProperty("count"):WaitForObject()
local condition = script:GetCustomProperty("condition")

local total = 0

API.register_node(API.Node_Type.Output:new(script.parent.parent, {

	on_data_received = function(data, node)
		
	end

}))