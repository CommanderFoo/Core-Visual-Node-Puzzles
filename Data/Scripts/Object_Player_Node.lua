local API = require(script:GetCustomProperty("API"))
local node = API.Node:new(script)

node:data_received(function(data)
	print(data)
end)

API.register_node(node)