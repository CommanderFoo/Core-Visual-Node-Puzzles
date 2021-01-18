local YOOTIL = require(script:GetCustomProperty("YOOTIL"))
local Node, Node_Events = require(script:GetCustomProperty("Node"))

local API = {

	TOP_OFFSET = 0,
	BOTTOM_OFFSET = 25

}

API.Node = Node
API.Node_Events = Node_Events

API.ticking_nodes = {}
API.nodes = {}
API.active_node = nil

function API.register_node(node)
	table.insert(API.nodes, #API.nodes + 1, node)
end

--[[function API.register_ticking_node(node)
	API.register_node(node)
	API.ticking_nodes[node:get_id()] = {
		
		node:get_ticking_task()
		node = node

	}
end--]]

API.Node_Events.on("begin_drag_node", function(node)
	API.active_node = node
end)

API.Node_Events.on("begin_drag_connection", function(node, connection)
	API.active_node = node
end)

API.Node_Events.on("input_connect", function(node_connected, node_connection)
	if(API.active_node ~= nil and API.active_node:get_id() ~= node_connected:get_id() and API.active_node:is_moving_connection()) then
		API.active_node:output_connect_to(node_connected, node_connection)
		node_connected:input_connect_to(API.active_node, API.active_node:get_current_connection(), node_connection)

		API.Node_Events.trigger("node_connected", API.active_node)
	end
end)

--[[
function API.tick_nodes()
	for _, n in pairs(API.ticking_nodes) do
		if(n.task == nil) then
			n.task = Task.Spawn(function()
				n.node:tick()
			end)


		end
	end
end
--]]

function API.get_path(obj, line, changed, offset)
	local angle = line.rotationAngle
	local rad = angle * (math.pi / 180)

	return (changed.a * math.cos(rad)), ((changed.a * math.sin(rad)) -(obj.height / 2)) + (offset or 0)
end

function API.get_connector_line(node, condition)
	if(condition) then
		return node:get_top_connector_line()
	end

	return node:get_bottom_connector_line()
end

function API.create_tween(line)
	if(not line) then
		return nil
	end

	return YOOTIL.Tween:new(1.8, {a = 0}, {a = line.width})
end

function API.get_bottom_offset(node)
	 return node:get_bottom_connector().y / 2
end

local ticking_task = Task.Spawn(function()
	if(API.active_node ~= nil) then
		API.active_node:drag_node()
		API.active_node:drag_connection()
	end
end)

ticking_task.repeatCount = -1

Game.GetLocalPlayer().bindingPressedEvent:Connect(function(obj, binding)
	if(binding == "ability_secondary") then
		if(API.active_node ~= nil) then
			API.active_node:stop_all_drag()
			API.active_node = nil
		end
	end
end)

return API, YOOTIL