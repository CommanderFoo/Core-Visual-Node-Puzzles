local YOOTIL = require(script:GetCustomProperty("YOOTIL"))
local Node, Node_Events, Node_Type = require(script:GetCustomProperty("Node"))
local Puzzle_Events = require(script:GetCustomProperty("Puzzle_Events"))

local click_sound = script:GetCustomProperty("click_sound"):WaitForObject()
local connect_sound = script:GetCustomProperty("connect_sound"):WaitForObject()
local hover_sound = script:GetCustomProperty("hover_sound"):WaitForObject()
local delete_sound = script:GetCustomProperty("delete_sound"):WaitForObject()

local random = math.random
local cos = math.cos
local sin = math.cos
local pi = math.pi

local API = {

	TOP_OFFSET = 0,
	BOTTOM_OFFSET = 25

}

API.Node = Node
API.Node_Type = Node_Type
API.Node_Events = Node_Events
API.Puzzle_Events = Puzzle_Events

API.ticking_nodes = {}
API.nodes = {}
API.active_node = nil
API.can_edit_nodes = true

function API.register_node(node)
	table.insert(API.nodes, #API.nodes + 1, node)
end

API.Node_Events.on("begin_drag_node", function(node)
	API.active_node = node
	API.play_click_sound()
end)

API.Node_Events.on("end_drag_node", function()
	API.play_click_sound()
end)

API.Node_Events.on("begin_drag_connection", function(node, connection)
	API.active_node = node
	API.play_click_sound()
end)

API.Node_Events.on("node_destroyed", function(node_id)
	for k, v in pairs(API.nodes) do
		if(v:get_id() == node_id) then
			API.nodes[k] = nil
			API.play_delete_sound()

			break
		end
	end
end)

API.Node_Events.on("input_connect", function(node_connected, node_connection)
	if(API.active_node ~= nil and API.active_node:get_id() ~= node_connected:get_id() and API.active_node:is_moving_connection()) then
		API.active_node:output_connect_to(node_connected, node_connection)
		node_connected:input_connect_to(API.active_node, API.active_node:get_current_connection(), node_connection)

		API.Node_Events.trigger("node_connected", API.active_node)
	end
end)

API.Node_Events.on("node_connected", function()
	API.change_sound_pitch(connect_sound)

	connect_sound:Play()
end)

function API.play_click_sound()
	API.change_sound_pitch(click_sound)

	click_sound:Play()
end

function API.play_hover_sound()
	API.change_sound_pitch(hover_sound)

	hover_sound:Play()
end

function API.play_delete_sound()
	API.change_sound_pitch(delete_sound)

	delete_sound:Play()
end

function API.change_sound_pitch(snd)
	snd.pitch = random(-150, 150)
end

function API.get_path(obj, line, changed, offset)
	local angle = line.rotationAngle
	local rad = angle * (pi / 180)

	return (changed.a * cos(rad)), ((changed.a * sin(rad)) -(obj.height / 2)) + (offset or 0)
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

function API.insert(obj, t)
	table.insert(t, #t + 1, obj)
end

function API.get_total_nodes()
	return #API.nodes
end

function API.set_award(award, alpha)
	local c = award:GetColor()

	c.a = alpha

	award:SetColor(c)
end

function API.disable_nodes()
	API.can_edit_nodes = false
	API.Node_Events.trigger("edit", API.can_edit_nodes)
end

function API.enable_nodes()
	API.can_edit_nodes = true
	API.Node_Events.trigger("edit", API.can_edit_nodes)
end

local ticking_task = Task.Spawn(function()
	if(API.active_node ~= nil and API.can_edit_nodes) then
		API.active_node:drag_node()
		API.active_node:drag_connection()
	end
end)

ticking_task.repeatCount = -1

Game.GetLocalPlayer().bindingPressedEvent:Connect(function(obj, binding)
	if(binding == "ability_secondary" and API.can_edit_nodes) then
		if(API.active_node ~= nil) then
			API.active_node:stop_all_drag()
			API.active_node = nil
		end
	end
end)


Events.Connect("puzzle_run", function()
	API.disable_nodes()

	Events.Broadcast("on_disable_all_dropdowns")
end)

Events.Connect("puzzle_edit", function()
	API.enable_nodes()

	Events.Broadcast("on_enable_all_dropdowns")
end)

return API, YOOTIL