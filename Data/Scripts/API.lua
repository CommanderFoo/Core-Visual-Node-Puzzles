local YOOTIL = require(script:GetCustomProperty("YOOTIL"))
local Node, Node_Events = require(script:GetCustomProperty("Node"))

local API = {}

API.Node = Node
API.Node_Events = Node_Events

local nodes = {}
local active_node = nil

function API.register_node(node)
	table.insert(nodes, #nodes + 1, node)
end

API.Node_Events.on("begin_drag_node", function(node)
	active_node = node
end)

API.Node_Events.on("begin_drag_connection", function(node, connection)
	active_node = node
end)

API.Node_Events.on("input_connect", function(node_connected, node_connection)
	if(active_node ~= nil and active_node:get_id() ~= node_connected:get_id()) then
		active_node:output_connect_to(node_connected, node_connection)
		node_connected:input_connect_to(active_node, active_node:get_current_connection(), node_connection)

		API.Node_Events.trigger("node_connected", active_node)
	end
end)

local ticking_task = Task.Spawn(function()
	if(active_node ~= nil) then
		active_node:drag_node()
		active_node:drag_connection()
	end
end)

ticking_task.repeatCount = -1

Game.GetLocalPlayer().bindingPressedEvent:Connect(function(obj, binding)
	if(binding == "ability_secondary") then
		if(active_node ~= nil) then
			active_node:stop_all_drag()
			active_node = nil
		end
	end
end)

return API, YOOTIL