local API, YOOTIL = require(script:GetCustomProperty("API"))

local root = script.parent.parent
local node = API.Node:new(root)

API.register_node(node)