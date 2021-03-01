local API, YOOTIL = require(script:GetCustomProperty("API"))

local node = API.Node:new(script.parent.parent)

API.register_node(node)