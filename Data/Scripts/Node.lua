-- No comments, sorry :O lol

local YOOTIL = require(script:GetCustomProperty("YOOTIL"))

local Node_Events = {}

local floor = math.floor
local abs = math.abs
local sqrt = math.sqrt
local cos = math.cos
local sin = math.sin
local deg = math.deg
local pi = math.pi
local atan = math.atan

local local_player = Game.GetLocalPlayer()

local Puzzle_Type = {

	LOGIC = 1,
	MATH = 2

}

-- Node Events

local Node_Events = {

	events = {},
	id = 0

}

function Node_Events.on(evt, fn)
	Node_Events.id = Node_Events.id + 1

	Node_Events.events[tostring(Node_Events.id)] = {

		event = evt,
		func = fn,
		id = Node_Events.id

	}

	return Node_Events.id
end

function Node_Events.off(event_id)
	local to_remove = {}

	for k, v in pairs(Node_Events.events) do
		if(v.id ~= nil and event_id == v.id) then
			Node_Events.events[k] = nil
		end
	end
end

function Node_Events.trigger(...)
	local args = {...}

	for i, e in pairs(Node_Events.events) do
		if(e.event == args[1]) then
			e.func(args[2], args[3], args[4], args[5])
		end
	end
end

-- Node class

local Node = {

	distance = function(a, b)
		local dx = a.x - b.x
		local dy = a.y - b.y

		return floor(abs(sqrt(dx * dx + dy * dy)))
	end,

	angle_to = function(a, b)
		if(b) then
			return deg(atan(a.y - b.y, a.x - b.x))
		end

		return deg(atan(a.y, a.x))
	end

}

function Node:setup(r)
	self.debug_node = false
	self.moving = false
	self.offset = Vector2.New(0, 0)
	self.active_connection = nil
	self.output_connections = {}
	self.input_connections = {}
	self.output_connected_to = {}
	self.input_connected_to = {}
	self.output_data = {}
	self.input_data = {}
	self.ticking_task = nil
	self.data_received_func = nil
	self.default_connector_color = Color.New(0.215861, 0.215861, 0.215861)
	self.error_task = nil
	self.on_connection_func = nil
	self.tweens = {}
	self.can_edit_nodes = true
	self.puzzle_type = Puzzle_Type.LOGIC
	self.paused = false

	self.n_evts = {}
	self.evts = {}

	self.internal_node_id = 0
	self.unique_id = 0

	self.options.tween_duration = self.options.tween_duration or 1.5
	self.options.speed = self.options.speed or 1

	self.OFFSETS = {

		TOP_OFFSET = 0,
		BOTTOM_OFFSET = 25

	}

	self.root = r

	self:setup_node()
	self:setup_output_connections()
	self:setup_input_connections()

	self.shift_pressed = false

	self.n_evts[#self.n_evts + 1] = Node_Events.on("key_shift_pressed", function()
		self.shift_pressed = true
	end)

	self.n_evts[#self.n_evts + 1] = Node_Events.on("key_shift_released", function()
		self.shift_pressed = false
	end)

	self.n_evts[#self.n_evts + 1] = Node_Events.on("pause", function()
		self.paused = true
	end)

	self.n_evts[#self.n_evts + 1] = Node_Events.on("unpause", function()
		self.paused = false
	end)

	self.n_evts[#self.n_evts + 1] = Node_Events.on("begin_drag_node", function(node)
		if(node.id ~= self.id) then
			self:stop_all_drag()
		end
	end)

	self.n_evts[#self.n_evts + 1] = Node_Events.on("dragging_node", function()
		self:move_connections()
	end)

	self.n_evts[#self.n_evts + 1] = Node_Events.on("break_connection", function(connection_id, stop_drag)
		self:clear_input_connection(connection_id)
		self:clear_output_connection(connection_id)

		if(stop_drag) then
			self:stop_all_drag()
		end
	end)

	self.n_evts[#self.n_evts + 1] = Node_Events.on("edit", function(can_edit)
		self.can_edit_nodes = can_edit

		if(Object.IsValid(self.delete_button)) then
			if(can_edit) then
				self.delete_button.isInteractable = true
			else
				self.delete_button.isInteractable = false
			end
		end
	end)

	self.n_evts[#self.n_evts + 1] = Node_Events.on("node_input_update", function(node_id)
		if(node_id ~= self:get_id()) then
			for k, v in pairs(self.input_connected_to) do
				for i, c in ipairs(v) do
					if(c.connected_from_node:get_id() == node_id) then
						v[i] = nil
					end
				end
			end
		end
	end)

	self.n_evts[#self.n_evts + 1] = Node_Events.on("node_output_update", function(node_id)
		if(node_id ~= self:get_id()) then
			for k, v in pairs(self.output_connected_to) do
				for i, c in ipairs(v) do
					if(c.connected_to_node:get_id() == node_id) then
						if(Object.IsValid(c.connection.line)) then
							c.connection.line.width = 0
						end

						v[i] = nil
					end
				end
			end
		end
	end)
end

function Node:get_position_as_string()
	return string.format("%.2f,%.2f", self.root.x, self.root.y)
end

function Node:get_internal_id()
	return self.internal_node_id
end

function Node:set_internal_id(id)
	self.internal_node_id = id
end

function Node:tick()
	if(self.options.tick and self.ticking_task == nil) then
		self.ticking_task = Task.Spawn(function()
			self.options.tick(self)
		end)

		self.ticking_task.repeatCount = self.options.repeat_count
		self.ticking_task.repeatInterval = (self.options.repeat_interval or 0.1) / self:get_speed()
	end
end

function Node:cancel_tick()
	if(self.ticking_task ~= nil) then
		self.ticking_task:Cancel()
		self.ticking_task = nil
	end
end

function Node:get_tick()
	return self.ticking_task
end

function Node:stop_ticking()
	if(self.ticking_task ~= nil) then
		self.ticking_task:Cancel()
		self.ticking_task = nil
	end
end

function Node:receive_data(data, from_node)
	if(self.options.on_data_received ~= nil) then
		self.options.on_data_received(data, self, from_node)

		Node_Events.trigger("received_data", self)
	end
end

function Node:setup_node(root)
	self.handle = self.root:FindDescendantByName("Node Handle")
	self.highlight = self.root:FindDescendantByName("Highlight Border")
	self.id = self.handle.id
	self.error_warning = self.root:FindDescendantByName("Error Warning")
	self.delete_button = self.root:FindDescendantByName("Delete Node")
	self.items_container = self.root:FindDescendantByName("Items Container")
	self.node_ui = self.root:FindAncestorByName("Root"):FindDescendantByName("Node UI")
	self.body = self.root:FindDescendantByName("Body Background")

	self.circle_bubble = self.body:FindDescendantByName("Circle Bubble")
	self.square_bubble = self.body:FindDescendantByName("Square Bubble")
	self.triangle_bubble = self.body:FindDescendantByName("Triangle Bubble")
	self.plus_bubble = self.body:FindDescendantByName("Plus Bubble")

	self.info_button = self.handle:FindChildByName("Info")
	self.info_data = self.root:FindDescendantByName("Node_Information_Data")

	if(self.options.node_time) then
		local node_time_ui = self.root:FindDescendantByName("Node Time")

		if(Object.IsValid(node_time_ui)) then
			node_time_ui.visibility = Visibility.FORCE_ON

			node_time_ui.text = string.format("%.2fs", self.options.node_time)
		end
	end

	local_player.bindingReleasedEvent:Connect(function(p, binding)
		if(binding == YOOTIL.Input.left_button) then
			if(self.moving) then
				self.moving = false
				self.highlight.visibility = Visibility.FORCE_OFF

				Node_Events.trigger("end_drag_node", self)
			end
		end
	end)

	self.evts[#self.evts + 1] = self.handle.pressedEvent:Connect(function(obj)
		self:debug()

		if(not self.can_edit_nodes) then
			return
		end

		self:clear_active_connection()

		local pos = UI.GetCursorPosition()

		self.offset.x = pos.x - self.root.x
		self.offset.y = pos.y - self.root.y

		self.moving = true

		self:move_to_front()
		self:move_connections()

		self.highlight.visibility = Visibility.FORCE_ON

		Node_Events.trigger("begin_drag_node", self)
	end)

	self.evts[#self.evts + 1] = self.delete_button.pressedEvent:Connect(function(obj)
		if(not self.can_edit_nodes) then
			return
		end

		self:clear_active_connection()

		Node_Events.trigger("node_input_update", self:get_id(), self:get_type(), self:get_unique_id())
		Node_Events.trigger("node_output_update", self:get_id(), self:get_type(), self:get_unique_id())

		Node_Events.trigger("late_node_input_update", self:get_id(), self:get_type(), self:get_unique_id())
		Node_Events.trigger("late_node_output_update", self:get_id(), self:get_type(), self:get_unique_id())

		self:remove()
	end)

	if(self.info_button ~= nil and self.info_data ~= nil) then
		self.evts[#self.evts + 1] = self.info_button.clickedEvent:Connect(function()
			Node_Events.trigger("node_info_click")
			Events.Broadcast("show_node_information", self.info_data)
		end)

		self.evts[#self.evts + 1] = self.info_button.hoveredEvent:Connect(function()
			self.info_button:SetFontColor(self.delete_button:GetHoveredColor())
		end)

		self.evts[#self.evts + 1] = self.info_button.unhoveredEvent:Connect(function()
			self.info_button:SetFontColor(self.delete_button:GetButtonColor())
		end)
	end
end

function Node:remove()
	if(self.ticking_task ~= nil) then
		self.ticking_task:Cancel()
		self.ticking_task = nil
	end

	if(self.error_task ~= nil) then
		self.error_task:Cancel()
		self.error_task = nil
	end

	if(self.options.queue_task ~= nil) then
		self.options.queue_task:Cancel()
		self.options.queue_task = nil
	end

	Node_Events.trigger("node_destroyed", self:get_id(), self.root.sourceTemplateId, self:get_internal_id())

	for k, e in ipairs(self.n_evts) do
		Node_Events.off(e)
	end

	for k, e in ipairs(self.evts) do
		if(e.isConnected) then
			e:Disconnect()
		end
	end

	self.root:Destroy()
end

function Node:debug()
	if(not self.debug_node) then
		return
	end

	local handle_text = self.handle:FindChildByName("Node Name")

	if(not string.find(handle_text.text, "%[")) then
		handle_text.text = handle_text.text .. "[" .. tostring(self.unique_id) .. "]"
	end

	local inputs = 0
	local outputs = 0

	for k, v in pairs(self.input_connected_to) do
		for i, c in pairs(v) do
			inputs = inputs + 1
		end
	end

	for k, v in pairs(self.output_connected_to) do
		for i, c in pairs(v) do
			outputs = outputs + 1
		end
	end

	print("Inputs: " .. tostring(inputs))
	print("Outputs: " .. tostring(outputs))
	print("Events: " .. tostring(#self.n_evts) .. " / " .. tostring(#self.evts))
end

function Node:setup_output_connections()
	self.output_container = self.root:FindDescendantByName("Output Connections")

	if(self.output_container ~= nil and #self.output_container:GetChildren() > 0) then
		local connections = self.output_container:GetChildren()

		for c = 1, #connections do
			self.output_connections[connections[c].id] = {

				id = connections[c].id,
				connector = connections[c],
				moving = false,
				line = connections[c]:FindDescendantByName("Line"),
				connector_image = connections[c]:FindDescendantByName("Connector"),
				can_be_connected_to = false

			}

			self.evts[#self.evts + 1] = connections[c].pressedEvent:Connect(function(obj)
				if(not self.can_edit_nodes) then
					return
				end

				Node_Events.trigger("break_connection", connections[c].id, true, self)

				self.active_connection = self.output_connections[connections[c].id]
				self.active_connection.moving = true

				self.active_connection.connector_image:SetColor(Color.YELLOW)

				Node_Events.trigger("begin_drag_connection", self, self.active_connection)
			end)
		end
	end
end

function Node:clear_output_connection(id)
	if(self.output_connected_to[id]) then
		self.output_connected_to[id] = nil
	end
end

function Node:clear_input_connection(id)
	for k, v in pairs(self.input_connected_to) do
		for i, j in pairs(v) do
			if(j.connected_from_connection.id == id) then
				self.input_connected_to[k][i] = nil
			end
		end
	end
end

function Node:setup_input_connections()
	self.input_container = self.root:FindDescendantByName("Input Connections")

	if(self.input_container ~= nil and #self.input_container:GetChildren() > 0) then
		local connections = self.input_container:GetChildren()

		for c = 1, #connections do
			self.input_connections[connections[c].id] = {

				id = connections[c].id,
				connection = connections[c],
				can_be_connected_to = true,
				line = connections[c]:FindDescendantByName("Line")

			}

			self.evts[#self.evts + 1] = connections[c].pressedEvent:Connect(function(obj)
				if(not self.can_edit_nodes) then
					return
				end

				Node_Events.trigger("input_connect", self, self.input_connections[connections[c].id])
			end)
		end
	end
end

function Node:do_output_connect(connected_to_node, connected_to_connection, the_connection)
	if(not the_connection) then
		return
	end

	if(self.output_connected_to[the_connection.id] == nil) then
		self.output_connected_to[the_connection.id] = {}
	end

	table.insert(self.output_connected_to[the_connection.id], #self.output_connected_to[the_connection.id] + 1, {

		connected_to_node = connected_to_node,
		connected_to_connection = connected_to_connection,
		connection = the_connection

	})
end

function Node:output_connect_to(connected_to_node, connected_to_connection)
	if(not self.active_connection) then
		return
	end

	self:do_output_connect(connected_to_node, connected_to_connection, self.active_connection)

	self.active_connection.moving = false
	self.active_connection.connector_image:SetColor(self.default_connector_color)

	Node_Events.trigger("output_connected_to", connected_to_node, self)
end

function Node:do_input_connect(connected_from_node, connected_from_connection, connected_to_connection)
	if(connected_to_connection == nil) then
		return
	end

	if(self.input_connected_to[connected_to_connection.id] == nil) then
		self.input_connected_to[connected_to_connection.id] = {}
	end

	table.insert(self.input_connected_to[connected_to_connection.id], #self.input_connected_to[connected_to_connection.id] + 1, {

		connected_from_node = connected_from_node,
		connected_from_connection = connected_from_connection,
		connected_to_connection = connected_to_connection

	})
end

function Node:input_connect_to(connected_from_node, connected_from_connection, connected_to_connection, set_order)
	if(self.input_connected_to[connected_to_connection.id] == nil) then
		self.input_connected_to[connected_to_connection.id] = {}
	end

	table.insert(self.input_connected_to[connected_to_connection.id], #self.input_connected_to[connected_to_connection.id] + 1, {

		connected_from_node = connected_from_node,
		connected_from_connection = connected_from_connection,
		connected_to_connection = connected_to_connection

	})

	Node_Events.trigger("input_connected_to", connected_from_node, self, set_order)
end

function Node:move_connections()
	for _, c in pairs(self.output_connected_to) do
		for i, e in ipairs(c) do
			if(e.connected_to_connection and Object.IsValid(e.connected_to_connection.connection) and Object.IsValid(e.connection.connector)) then
				local from_handle_y = e.connected_to_connection.connection.y + 30
				local to_handle_y = e.connection.connector.y + 30

				local from = Vector2.New(e.connected_to_node.root.x - (e.connected_to_node.root.width / 2) - 10, e.connected_to_node.root.y + from_handle_y)
				local to = Vector2.New(self.root.x + self.output_container.x, self.root.y + self.output_container.y + to_handle_y)

				e.connection.line.width = Node.distance(from, to)
				e.connection.line.rotationAngle = Node.angle_to(from, to)
			end
		end
	end
end

function Node:is_moving_connection()
	if(self.active_connection ~= nil and self.active_connection.moving) then
		return true
	end

	return false
end

function Node:get_current_connection()
	if(self.active_connection ~= nil) then
		return self.active_connection
	end

	return nil
end

function Node:get_input_connection(id)
	return self.input_connections[id]
end

function Node:move_to_front()
	self.root.parent = self.node_ui
end

function Node:drag_node()
	local screen_size = UI.GetScreenSize()

	if(self.moving) then
		local pos = UI.GetCursorPosition()

		if(Object.IsValid(self.root)) then
			if(pos.x >= 0) then
				self.root.x = pos.x - self.offset.x

				if(pos.x <= 0) then
					self.root.x = 0
				elseif(self.root.x >= screen_size.x) then
					self.root.x = screen_size.x
				end
			end

			if(pos.y >= 0) then
				self.root.y = pos.y - self.offset.y

				if(pos.y < 0) then
					self.root.y = self.root.height
				elseif(self.root.y >= screen_size.y) then
					self.root.y = screen_size.y
				end
			end
		end

		Node_Events.trigger("dragging_node", self)
	end
end

function Node:drag_connection()
	if(self.active_connection ~= nil and self.active_connection.moving) then
		local handle_y = self.active_connection.connector.y

		local a = UI.GetCursorPosition() - (UI.GetScreenSize() / 2)
		local b = Vector2.New(self.root.x + self.output_container.x - self.active_connection.line.x, self.root.y + self.output_container.y + handle_y)

		self.active_connection.line.width = Node.distance(a, b)
		self.active_connection.line.rotationAngle = Node.angle_to(a, b)

		Node_Events.trigger("dragging_connection", self, self.active_connection)
	end
end

function Node:clear_active_connection()
	if(self.active_connection ~= nil and self.active_connection.moving) then
		self.active_connection.connector_image:SetColor(self.default_connector_color)
		self.active_connection.line.width = 0
		self.active_connection.moving = false
		self.active_connection = nil
	end
end

function Node:stop_all_drag()
	self:clear_active_connection()
	self.moving = false

	if(Object.IsValid(self.highlight)) then
		self.highlight.visibility = Visibility.FORCE_OFF
	end
end

function Node:get_output_connector_by_index(index)
	if(index == 2) then
		return self:get_bottom_connector()
	end

	return self:get_top_connector()
end

function Node:get_input_connector()
	for i, c in pairs(self.input_connections) do
		return c
	end
end

function Node:get_top_input_connector()
	for i, c in pairs(self.input_connections) do
		if(string.find(i, "Top") or string.match(i, "Handle$")) then
			return c
		end
	end
end

function Node:get_middle_input_connector()
	for i, c in pairs(self.input_connections) do
		if(string.find(i, "Middle")) then
			return c
		end
	end
end

function Node:get_bottom_input_connector()
	for i, c in pairs(self.input_connections) do
		if(string.find(i, "Bottom")) then
			return c
		end
	end
end

function Node:get_id()
	return self.id
end

function Node:get_root()
	return self.root
end

function Node:get_body()
	return self.body
end

function Node:get_circle_bubble()
	return self.circle_bubble
end

function Node:get_square_bubble()
	return self.square_bubble
end

function Node:get_triangle_bubble()
	return self.triangle_bubble
end

function Node:get_plus_bubble()
	return self.plus_bubble
end

function Node:has_input_connection(ignore_id)
	for id, c in pairs(self.input_connected_to) do
		if(id ~= ignore_id) then
			return true
		end
	end

	return false
end

function Node:has_connection()
	for _, c in pairs(self.output_connected_to) do
		for i, e in ipairs(c) do
			if(e.connected_to_connection and self.id ~= e.connected_to_node.id) then
				return e.connected_to_connection.id
			end
		end
	end

	return false
end

function Node:show_error_info()
	if(self.error_task == nil) then
		self.error_task = Task.Spawn(function()
			if(not Object.IsValid(self.error_warning)) then
				self.error_task:Cancel()
				self.error_task = nil

				return
			end

			if(self.error_warning.visibility == Visibility.FORCE_ON) then
				self.error_warning.visibility = Visibility.FORCE_OFF
			else
				self.error_warning.visibility = Visibility.FORCE_ON
			end
		end)

		self.error_task.repeatCount = -1
		self.error_task.repeatInterval = 0.6
	end
end

function Node:hide_error_info()
	if(self.error_task ~= nil) then
		self.error_task:Cancel()
		self.error_task = nil

		if(Object.IsValid(self.error_warning)) then
			self.error_warning.visibility = Visibility.FORCE_OFF
		end
	end
end

function Node:has_errors(b)
	if(b) then
		self:show_error_info()
	else
		self:hide_error_info()
	end
end

function Node:has_top_connection()
	for _, c in pairs(self.output_connected_to) do
		for i, cs in pairs(c) do
			if(cs.connected_to_connection and cs.connection.connector.name == "Connection Handle Top") then
				return cs.connected_to_connection.id
			end
		end
	end

	return false
end

function Node:has_middle_connection()
	for _, c in pairs(self.output_connected_to) do
		for i, cs in pairs(c) do
			if(cs.connected_to_connection and cs.connection.connector.name == "Connection Handle Middle") then
				return cs.connected_to_connection.id
			end
		end
	end

	return false
end

function Node:has_bottom_connection()
	for _, c in pairs(self.output_connected_to) do
		for i, cs in pairs(c) do
			if(cs.connected_to_connection and cs.connection.connector.name == "Connection Handle Bottom") then
				return cs.connected_to_connection.id
			end
		end
	end

	return false
end

function Node:send_data_top(data)
	for _, c in pairs(self.output_connected_to) do
		for i, e in ipairs(c) do
			if(e.connection.connector.name == "Connection Handle Top") then
				e.connected_to_node:receive_data(data, self)
			end
		end
	end
end

function Node:send_data_middle(data)
	for _, c in pairs(self.output_connected_to) do
		for i, e in ipairs(c) do
			if(e.connection.connector.name == "Connection Handle Middle") then
				e.connected_to_node:receive_data(data, self)
			end
		end
	end
end

function Node:send_data_bottom(data)
	for _, c in pairs(self.output_connected_to) do
		for i, e in ipairs(c) do
			if(e.connection.connector.name == "Connection Handle Bottom") then
				e.connected_to_node:receive_data(data, self)
			end
		end
	end
end

function Node:send_data(data)
	for _, c in pairs(self.output_connected_to) do
		for i, e in ipairs(c) do
			e.connected_to_node:receive_data(data, self)
		end
	end
end

function Node:on_connection(func)
	self.on_connection_func = func
end

function Node:get_top_connector(ret_table)
	for _, c in pairs(self.output_connections) do
		if(c.connector.name == "Connection Handle Top") then
			if(ret_table) then
				return c
			else
				return c.connector
			end
		end
	end
end

function Node:get_middle_connector(ret_table)
	for _, c in pairs(self.output_connections) do
		if(c.connector.name == "Connection Handle Middle") then
			if(ret_table) then
				return c
			else
				return c.connector
			end
		end
	end
end

function Node:get_bottom_connector(ret_table)
	for _, c in pairs(self.output_connections) do
		if(c.connector.name == "Connection Handle Bottom") then
			if(ret_table) then
				return c
			else
				return c.connector
			end
		end
	end
end

function Node:get_top_connector_line()
	for _, c in pairs(self.output_connected_to) do
		for i, cs in pairs(c) do
			if(cs.connection.connector.name == "Connection Handle Top") then
				return cs.connection.line
			end
		end
	end
end

function Node:get_middle_connector_line()
	for _, c in pairs(self.output_connected_to) do
		for i, cs in pairs(c) do
			if(cs.connection.connector.name == "Connection Handle Middle") then
				return cs.connection.line
			end
		end
	end
end

function Node:get_bottom_connector_line()
	for _, c in pairs(self.output_connected_to) do
		for i, cs in pairs(c) do
			if(cs.connection.connector.name == "Connection Handle Bottom") then
				return cs.connection.line
			end
		end
	end
end

function Node:get_input_connections()
	return self.input_connected_to
end

function Node:get_output_connections()
	return self.output_connected_to
end

function Node:get_connector_line(condition)
	if(condition) then
		return self:get_top_connector_line()
	end

	return self:get_bottom_connector_line()
end

function Node:create_tween(line)
	if(not line) then
		return nil
	end

	local t = YOOTIL.Tween:new(self:get_tween_duration(), {a = 0}, {a = line.width})

	if(self.options.tween_delay) then
		t:set_delay(self.options.tween_delay / self.options.speed)

		Events.Broadcast("score", self.options.tween_delay or 0)
	end

	if(not self.options.added_tween) then
		Events.Broadcast("score", self.options.tween_duration)
		self.options.added_tween = true
	end

	return t
end

function Node:get_path(obj, line, changed, offset)
	if(not Object.IsValid(obj) or not Object.IsValid(line)) then
		return
	end

	local angle = line.rotationAngle
	local rad = angle * (pi / 180)

	return (changed.a * cos(rad)), ((changed.a * sin(rad)) -(obj.height / 2)) + (offset or 0)
end

function Node:get_bottom_offset()
	return self:get_bottom_connector().y / 2
end

function Node:get_top_offset()
	if(self.puzzle_type == Puzzle_Type.MATH) then
		return -10
	end

	return 0
end

function Node:insert_tween(obj)
	table.insert(self.tweens, #self.tweens + 1, obj)
end

function Node:set_option(opt, val)
	self.options[opt] = val
end

function Node:spawn_asset(asset, x, y, value)
	local obj = World.SpawnAsset(asset, {parent = self.items_container})

	if(self.puzzle_type == Puzzle_Type.MATH) then
		obj.text = tostring(value)
	end

	obj.x = x
	obj.y = y

	obj.visibility = Visibility.FORCE_OFF

	return obj
end

function Node:set_puzzle_type(type)
	self.puzzle_type = type
end

function Node:clear_items_container()
	if(Object.IsValid(self.items_container) and #self.items_container:GetChildren() > 0) then
		for i, c in pairs(self.items_container:GetChildren()) do
			c:Destroy()
		end
	end
end

function Node:get_tweens()
	if(self.paused) then
		return {}
	end

	return self.tweens
end

function Node:clear_tweens()
	self.tweens = {}
end

function Node:set_speed(speed)
	self.options.speed = tonumber(speed)
end

function Node:get_speed()
	return self.options.speed or 1
end

function Node:set_tween_duration(speed)
	self.options.tween_duration = tonumber(speed)
end

function Node:get_tween_duration()
	return self.options.tween_duration / self:get_speed()
end

function Node:get_type()
	return self.node_type
end

function Node:get_condition()
	return ""
end

function Node:get_limit()
	return ""
end

function Node:get_amount()
	return ""
end

function Node:get_order()
	return ""
end

function Node:set_unique_id(id)
	self.unique_id = id
end

function Node:get_unique_id()
	return self.unique_id
end

function Node:set_from_saved_data(data)
	if(data.id ~= nil) then
		self:set_internal_id(data.id)
	end

	if(data.uid ~= nil) then
		self:set_unique_id(data.uid)
	end

	if(data.order ~= nil and data.order > 0) then
		self:set_order(data.order)
	end
end

function Node:get_output_connections_as_string()
	local out_connections = {}

	for k, c in pairs(self.output_connected_to) do
		for i, n in ipairs(c) do
			local index = 1

			if(string.find(n.connection.id, "Bottom")) then
				index = 2
			end

			local to_index = 0

			if(n.connected_to_connection ~= nil) then
				if(string.find(n.connected_to_connection.id, "Top") or string.match(n.connected_to_connection.id, "Handle$")) then
					to_index = 1
				elseif(string.find(n.connected_to_connection.id, "Bottom")) then
					to_index = 2
				end
			end

			table.insert(out_connections, tostring(index) .. ";" .. tostring(n.connected_to_node:get_unique_id() .. "~" .. tostring(to_index)))
		end
	end

	--print(self:get_type(), table.concat(out_connections, ","))

	return table.concat(out_connections, ",")
end

function Node:is_receiving_top(id)
	if(string.find(id, "Top")) then
		return true
	end

	return false
end

function Node:is_receiving_middle(id)
	if(string.find(id, "Middle")) then
		return true
	end

	return false
end

function Node:is_receiving_bottom(id)
	if(string.find(id, "Bottom")) then
		return true
	end

	return false
end

function Node:new(r, options)
	self.__index = self

	local o = setmetatable({

		options = options or {}

	}, self)

	self.node_type = "Node"

	o:setup(r)

	return o
end

-- Data Node

local Node_Data = {}

function Node_Data:new(r, options)
	self.__index = self

	local this = setmetatable({

		options = options or {}

	}, self)

	setmetatable(this, {__index = Node})

	this.node_type = "Data"

	this:setup(r)

	if(not this.options.repeat_count) then
		this.options.repeat_count = -1
	end

	if(not this.options.repeat_interval) then
		this.options.repeat_interval = .4
	end

	this.options.total_data_items = 0
	this.options.index = 1
	this.options.count = 0
	this.options.added_tween = false

	function setup_data()
		this.options.total_data_items = 0

		for _, d in pairs(this.options.data_items) do
			d.data_count = d.count
			this.options.total_data_items = this.options.total_data_items + d.count
		end
	end

	setup_data()

	function this:reset()
		this:stop_ticking()
		this:clear_items_container()
		this:hide_error_info()

		setup_data()

		this.options.added_tween = false
		this.options.index = 1
		this.options.count = 0
		this.tweens = {}
	end

	this.options.tick = function()
		if(this.paused) then
			return
		end

		local connection_to_id = this:has_connection()

		if(connection_to_id) then
			if(this.options.count == this.options.total_data_items) then
				this:stop_ticking()
				return
			else
				Events.Broadcast("score", (this.options.repeat_interval or 0.1))
			end

			if(this.options.index == (#this.options.data_items + 1)) then
				this.options.index = 1
			end

			if(not Object.IsValid(this.options.data_items[this.options.index].ui)) then
				return
			end

			local item = this.options.data_items[this.options.index]

			if(item.data_count > 0) then
				item.data_count = item.data_count - 1
				item.ui.text = tostring(item.data_count)

				local line = this:get_top_connector_line()
				local obj = this:spawn_asset(item.asset, line.x, line.y, item.value)
				local tween = this:create_tween(line)
				local offset = this:get_top_offset()

				tween:on_start(function()
					obj.visibility = Visibility.FORCE_ON
				end)

				tween:on_complete(function()
					this:send_data({

						asset = item.asset,
						condition = item.condition or nil,
						count = 1,
						total_count = item.count,
						value = item.value or nil,
						connection_to_id = connection_to_id

					})

					if(Object.IsValid(obj)) then
						obj:Destroy()
					end

					tween = nil
				end)

				tween:on_change(function(changed)
					local x, y = this:get_path(obj, line, changed, offset)

					if(x == nil or y == nil) then
						return
					end

					obj.x = x
					obj.y = y
				end)

				this:insert_tween({

					obj = obj,
					tween = tween

				})

				this.options.count = this.options.count + 1
			end

			this.options.index = this.options.index + 1
		end
	end

	return this
end

-- End Data Node

-- Output Node

local Node_Output = {}

function Node_Output:new(r, options)
	self.__index = self

	local this = setmetatable({

		options = options or {}

	}, self)

	setmetatable(this, {__index = Node})

	this:setup(r)

	this.node_type = "Output"
	this.halt_order = 1

	function this:get_halt_nodes(cur_id)
		local halt_nodes = {}

		for k, v in pairs(this.input_connected_to) do
			for a, j in pairs(v) do
				if(j.connected_from_node:get_type() == "Halt" and j.connected_from_node:get_unique_id() ~= cur_id) then
					table.insert(halt_nodes, #halt_nodes + 1, j.connected_from_node)
				end
			end
		end

		return halt_nodes
	end

	function this:check_halting()
		local use_node = nil

		for k, n in ipairs(this:get_halt_nodes()) do
			if(n:get_order() == self.halt_order) then
				use_node = n
			end
		end

		if(use_node ~= nil) then
			use_node:unhalt()
			this.halt_order = this.halt_order + 1
		end
	end

	function this:get_next_halt_order(cur_id)
		local total = 0
		local nums = {}

		for k, n in ipairs(this:get_halt_nodes(cur_id)) do
			table.insert(nums, #nums + 1, n:get_order())
			total = total + 1
		end

		if(total > 0) then
			local free = {}

			for i = 1, (total + 1) do
				free[i] = true
			end

			for i, n in ipairs(nums) do
				free[n] = false
			end

			for i, n in ipairs(free) do
				if(n) then
					return i
				end
			end
		else
			return 1
		end
	end

	function this:reset()
		this.halt_order = 1
	end

	return this
end

-- End Output Node

-- If Node

local Node_If = {}

function Node_If:new(r, options)
	self.__index = self

	local this = setmetatable({

		options = options or {}

	}, self)

	setmetatable(this, {__index = Node})

	if(not this.options_if_condition) then
		this.options.if_condition = nil
	end

	this:setup(r)

	this.node_type = "If"

	this.options.queue_task = nil

	local queue = YOOTIL.Utils.Queue:new()
	local monitor_started = false

	function this:monitor_queue(speed)
		if(this.options.node_time ~= nil and this.options.node_time > 0) then
			this.options.queue_task = Task.Spawn(function()
				if(not queue:is_empty()) then
					queue:pop()()
				end
			end, this.options.node_time / speed)

			this.options.queue_task.repeatCount = -1
			this.options.queue_task.repeatInterval = (this.options.node_time / speed)
		end
	end

	this.options.on_data_received = function(data, node, from_node)
		if(not monitor_started) then
			monitor_started = true

			this:set_speed(from_node:get_speed())
			this:monitor_queue(from_node:get_speed())
		end

		local queue_func = function()
			Events.Broadcast("score", this.options.node_time or 0)

			local top_connection = this:has_top_connection()
			local bottom_connection = this:has_bottom_connection()

			if(top_connection or bottom_connection) then
				local condition = (data.condition == this.options.if_condition)
				local obj = nil
				local line = this:get_connector_line(condition)
				local tween = this:create_tween(line)
				local connection_method = nil
				local offset = this:get_top_offset()

				if(condition and top_connection) then
					data.connection_to_id = top_connection
					obj = this:spawn_asset(data.asset, line.x, line.y, data.value)
					connection_method = "send_data_top"

					this:insert_tween({

						obj = obj,
						tween = tween

					})
				elseif(bottom_connection) then
					data.connection_to_id = bottom_connection
					offset = this:get_bottom_offset()

					if(Object.IsValid(line)) then
						obj = this:spawn_asset(data.asset, line.x, line.y, data.value)
						connection_method = "send_data_bottom"

						this:insert_tween({

							obj = obj,
							tween = tween

						})
					end
				else
					this:has_errors(true)
				end

				if(tween ~= nil and connection_method ~= nil) then
					tween:on_start(function()
						obj.visibility = Visibility.FORCE_ON
					end)

					tween:on_complete(function()
						this[connection_method](this, data)

						if(Object.IsValid(obj)) then
							obj:Destroy()
						end

						tween = nil
					end)

					tween:on_change(function(changed)
						local x, y = this:get_path(obj, line, changed, offset)

						if(x == nil or y == nil) then
							return
						end

						obj.x = x
						obj.y = y
					end)
				end
			else
				this:has_errors(true)
			end
		end

		if(this.options.node_time ~= nil and this.options.node_time > 0) then
			queue:push(queue_func)
		else
			queue_func()
		end
	end

	function this:reset()
		this.options.added_tween = false

		if(this.options.queue_task ~= nil) then
			this.options.queue_task:Cancel()
			this.options.queue_task = nil
		end

		monitor_started = false
		queue = YOOTIL.Utils.Queue:new()
		this.tweens = {}

		this:clear_items_container()
		this:hide_error_info()
	end

	function this:get_condition()
		if(this.options.if_condition ~= nil) then
			return this.options.if_condition:sub(1, 1)
		end

		return ""
	end

	this.n_evts[#this.n_evts + 1] = Node_Events.on("node_destroyed", function()
		if(this.options.queue_task ~= nil) then
			this.options.queue_task:Cancel()
			this.options.queue_task = nil
		end
	end)

	return this
end

-- End If Node

-- Alternate Node

local Node_Alternate = {}

function Node_Alternate:new(r, options)
	self.__index = self

	local this = setmetatable({

		options = options or {}

	}, self)

	setmetatable(this, {__index = Node})

	this:setup(r)

	this.node_type = "Alternate"

	this.options.queue_task = nil

	local queue = YOOTIL.Utils.Queue:new()
	local monitor_started = false

	local switch = true

	function this:monitor_queue(speed)
		if(this.options.node_time ~= nil and this.options.node_time > 0) then
			this.options.queue_task = Task.Spawn(function()
				if(not queue:is_empty()) then
					queue:pop()()
				end
			end, this.options.node_time / speed)

			this.options.queue_task.repeatCount = -1
			this.options.queue_task.repeatInterval = (this.options.node_time / speed)
		end
	end

	this.options.on_data_received = function(data, node, from_node)
		if(not monitor_started) then
			monitor_started = true

			this:set_speed(from_node:get_speed())
			this:monitor_queue(from_node:get_speed())
		end

		local queue_func = function()
			Events.Broadcast("score", this.options.node_time or 0)

			local top_connection = this:has_top_connection()
			local bottom_connection = this:has_bottom_connection()

			if(top_connection or bottom_connection) then
				local obj = nil
				local line = this:get_connector_line(switch)
				local tween = this:create_tween(line)
				local connection_method = nil
				local offset = this:get_top_offset()
				local connection_to_top_id = this:has_top_connection()
				local connection_to_bottom_id = this:has_bottom_connection()
				local connection_to_id = nil

				if(switch and top_connection) then
					data.connection_to_id = top_connection
					obj = this:spawn_asset(data.asset, line.x, line.y, data.value)
					connection_method = "send_data_top"
					connection_to_id = connection_to_top_id

					this:insert_tween({

						obj = obj,
						tween = tween

					})
				elseif(bottom_connection) then
					data.connection_to_id = bottom_connection
					offset = this:get_bottom_offset()

					if(Object.IsValid(line)) then
						obj = this:spawn_asset(data.asset, line.x, line.y, data.value)
						connection_method = "send_data_bottom"

						this:insert_tween({

							obj = obj,
							tween = tween

						})
					end
				else
					this:has_errors(true)
				end

				if(tween ~= nil and connection_method ~= nil) then
					tween:on_start(function()
						obj.visibility = Visibility.FORCE_ON
					end)

					tween:on_complete(function()
						this[connection_method](this, data)

						if(Object.IsValid(obj)) then
							obj:Destroy()
						end

						tween = nil
					end)

					tween:on_change(function(changed)
						local x, y = this:get_path(obj, line, changed, offset)

						if(x == nil or y == nil) then
							return
						end

						obj.x = x
						obj.y = y
					end)
				end
			else
				this:has_errors(true)
			end

			if(switch) then
				switch = false
			else
				switch = true
			end
		end

		if(this.options.node_time ~= nil and this.options.node_time > 0) then
			queue:push(queue_func)
		else
			queue_func()
		end
	end

	function this:reset()
		this.options.added_tween = false

		if(this.options.queue_task ~= nil) then
			this.options.queue_task:Cancel()
			this.options.queue_task = nil
		end

		monitor_started = false
		queue = YOOTIL.Utils.Queue:new()
		this.tweens = {}

		this:clear_items_container()
		this:hide_error_info()
	end

	this.n_evts[#this.n_evts + 1] = Node_Events.on("node_destroyed", function()
		if(this.options.queue_task ~= nil) then
			this.options.queue_task:Cancel()
			this.options.queue_task = nil
		end
	end)

	return this
end

-- End Alternate Node

-- Limit Node

local Node_Limit = {}

function Node_Limit:new(r, options)
	self.__index = self

	local this = setmetatable({

		options = options or {}

	}, self)

	setmetatable(this, {__index = Node})

	this:setup(r)

	this.node_type = "Limit"

	this.options.queue_task = nil

	local queue = YOOTIL.Utils.Queue:new()
	local monitor_started = false
	local sending = 0
	local limit_count = this.body:FindDescendantByName("Limit Count")
	local orig_sending = 0
	local minus_button = this.body:FindDescendantByName("Minus")
	local plus_button = this.body:FindDescendantByName("Plus")

	this.evts[#this.evts + 1] = minus_button.clickedEvent:Connect(function()
		if(sending > 0) then
			sending = sending - 1
		end

		limit_count.text = tostring(sending)
		orig_sending = sending
	end)

	this.evts[#this.evts + 1] = plus_button.clickedEvent:Connect(function()
		if(sending < 9999) then
			sending = sending + 1
		end

		limit_count.text = tostring(sending)
		orig_sending = sending
	end)

	this.n_evts[#this.n_evts + 1] = Node_Events.on("edit", function(can_edit)
		if(Object.IsValid(minus_button)) then
			if(can_edit) then
				minus_button.isInteractable = true
			else
				minus_button.isInteractable = false
			end
		end

		if(Object.IsValid(plus_button)) then
			if(can_edit) then
				plus_button.isInteractable = true
			else
				plus_button.isInteractable = false
			end
		end
	end)

	function this:monitor_queue(speed)
		if(this.options.node_time ~= nil and this.options.node_time > 0) then
			this.options.queue_task = Task.Spawn(function()
				if(not queue:is_empty()) then
					queue:pop()()
				end
			end, this.options.node_time / speed)

			this.options.queue_task.repeatCount = -1
			this.options.queue_task.repeatInterval = (this.options.node_time / speed)
		end
	end

	this.options.on_data_received = function(data, node, from_node)
		if(not monitor_started) then
			monitor_started = true

			this:set_speed(from_node:get_speed())
			this:monitor_queue(from_node:get_speed())
		end

		local queue_func = function()
			Events.Broadcast("score", this.options.node_time or 0)

			local top_connection = this:has_top_connection()
			local bottom_connection = this:has_bottom_connection()

			if(top_connection or bottom_connection) then
				local obj = nil
				local line = this:get_connector_line(sending > 0)
				local tween = this:create_tween(line)
				local connection_method = nil
				local offset = this:get_top_offset()

				if(top_connection and sending > 0) then
					data.connection_to_id = top_connection
					obj = this:spawn_asset(data.asset, line.x, line.y, data.value)
					connection_method = "send_data_top"

					this:insert_tween({

						obj = obj,
						tween = tween

					})

					sending = sending - 1
					limit_count.text = tostring(sending)
				elseif(bottom_connection) then
					data.connection_to_id = bottom_connection
					offset = this:get_bottom_offset()

					if(Object.IsValid(line)) then
						obj = this:spawn_asset(data.asset, line.x, line.y, data.value)
						connection_method = "send_data_bottom"

						this:insert_tween({

							obj = obj,
							tween = tween

						})
					end
				else
					this:has_errors(true)
				end

				if(tween ~= nil and connection_method ~= nil) then
					tween:on_start(function()
						obj.visibility = Visibility.FORCE_ON
					end)

					tween:on_complete(function()
						this[connection_method](this, data)

						if(Object.IsValid(obj)) then
							obj:Destroy()
						end

						tween = nil
					end)

					tween:on_change(function(changed)
						local x, y = this:get_path(obj, line, changed, offset)

						if(x == nil or y == nil) then
							return
						end

						obj.x = x
						obj.y = y
					end)
				end
			else
				this:has_errors(true)
			end
		end

		if(this.options.node_time ~= nil and this.options.node_time > 0) then
			queue:push(queue_func)
		else
			queue_func()
		end
	end

	function this:reset()
		this.options.added_tween = false

		if(this.options.queue_task ~= nil) then
			this.options.queue_task:Cancel()
			this.options.queue_task = nil
		end

		monitor_started = false
		queue = YOOTIL.Utils.Queue:new()
		this.tweens = {}
		sending = orig_sending
		limit_count.text = tostring(sending)

		this:clear_items_container()
		this:hide_error_info()
	end

	function this:get_limit()
		return sending
	end

	function this:set_limit(l)
		if(l ~= nil and l > 0 and l < 100) then
			sending = l
			limit_count.text = tostring(l)
			orig_sending = sending
		end
	end

	this.n_evts[#this.n_evts + 1] = Node_Events.on("node_destroyed", function()
		if(this.options.queue_task ~= nil) then
			this.options.queue_task:Cancel()
			this.options.queue_task = nil
		end
	end)

	return this
end

-- End Limit Node

-- Halt Node

local Node_Halt = {}

function Node_Halt:new(r, options)
	self.__index = self

	local this = setmetatable({

		options = options or {}

	}, self)

	setmetatable(this, {__index = Node})

	this:setup(r)

	this.node_type = "Halt"

	this.options.queue_task = nil

	local queue = YOOTIL.Utils.Queue:new()
	local monitor_started = false
	local from_speed = 1
	local order = 0
	local halting_data_type = nil
	local count = this.body:FindDescendantByName("Count")
	local active_shape = nil

	function this:monitor_queue(speed)
		if(this.options.node_time ~= nil and this.options.node_time > 0) then
			this.options.queue_task = Task.Spawn(function()
				if(not queue:is_empty()) then
					queue:pop()()
				end
			end, this.options.node_time / speed)

			this.options.queue_task.repeatCount = -1
			this.options.queue_task.repeatInterval = (this.options.node_time / speed)
		end
	end

	function this:unhalt()
		if(not monitor_started) then
			monitor_started = true

			this:set_speed(from_speed)
			this:monitor_queue(from_speed)
		end
	end

	this.n_evts[#this.n_evts + 1] = Node_Events.on("late_node_output_update", function(id, type, uid)
		if(type ~= "Output") then
			return
		end

		local has_output = true

		for k, v in pairs(this.output_connected_to) do
			if(#v == 0) then
				has_output = false
			end
		end

		if(not has_output) then
			order = 0
			this:set_order(0)
		end
	end)

	this.n_evts[#this.n_evts + 1] = Node_Events.on("output_connected_to", function(to_node, from_node)
		if(from_node:get_unique_id() == this:get_unique_id() and to_node:get_type() == "Output") then
			this:set_order(to_node:get_next_halt_order(this:get_unique_id()))
		end
	end)

	this.options.on_data_received = function(data, node, from_node)
		if(halting_data_type == nil) then
			halting_data_type = data.condition
			active_shape = this.body:FindDescendantByName(data.condition:gsub("^%l", string.upper))
			active_shape.visibility = Visibility.FORCE_ON
			this.body:FindDescendantByName("None").visibility = Visibility.FORCE_OFF
		elseif(halting_data_type ~= data.condition) then
			this:has_errors(true)

			return
		end

		count.text = tostring(tonumber(count.text) + 1)

		from_speed = from_node:get_speed()

		local queue_func = function()
			Events.Broadcast("score", this.options.node_time or 0)

			local top_connection = this:has_top_connection()

			if(top_connection) then
				data.connection_to_id = top_connection

				local line = this:get_connector_line(true)
				local obj = this:spawn_asset(data.asset, line.x, line.y, data.value)
				local tween = this:create_tween(line)
				local offset = this:get_top_offset()

				this:insert_tween({

					obj = obj,
					tween = tween

				})

				if(tween ~= nil) then
					tween:on_start(function()
						count.text = tostring(tonumber(count.text) - 1)
						obj.visibility = Visibility.FORCE_ON
					end)

					tween:on_complete(function()
						this["send_data_top"](this, data)

						if(Object.IsValid(obj)) then
							obj:Destroy()
						end

						tween = nil
					end)

					tween:on_change(function(changed)
						local x, y = this:get_path(obj, line, changed, offset)

						if(x == nil or y == nil) then
							return
						end

						obj.x = x
						obj.y = y
					end)
				end
			else
				this:has_errors(true)
			end
		end

		if(this.options.node_time ~= nil and this.options.node_time > 0) then
			queue:push(queue_func)
		else
			queue_func()
		end
	end

	function this:set_order(ord)
		if(not Object.IsValid(this.body)) then
			return
		end

		this.order = ord
		this.body:FindDescendantByName("Order").text = tostring(this.order)
	end

	function this:get_order()
		return this.order
	end

	function this:reset()
		this.options.added_tween = false

		if(this.options.queue_task ~= nil) then
			this.options.queue_task:Cancel()
			this.options.queue_task = nil
		end

		monitor_started = false
		queue = YOOTIL.Utils.Queue:new()
		this.tweens = {}

		count.text = "0"
		halting_data_type = nil

		if(active_shape ~= nil) then
			active_shape.visibility = Visibility.FORCE_OFF
		end

		this.body:FindDescendantByName("None").visibility = Visibility.FORCE_ON

		this:clear_items_container()
		this:hide_error_info()
	end

	this.n_evts[#this.n_evts + 1] = Node_Events.on("node_destroyed", function()
		if(this.options.queue_task ~= nil) then
			this.options.queue_task:Cancel()
			this.options.queue_task = nil
		end
	end)

	return this
end

-- End Halt Node

-- Add Node

local Node_Add = {}

function Node_Add:new(r, options)
	self.__index = self

	local this = setmetatable({

		options = options or {}

	}, self)

	setmetatable(this, {__index = Node})

	this:setup(r)

	this.node_type = "Add"

	local top_queue_count = this.body:FindDescendantByName("Total Queued Top")
	local bottom_queue_count = this.body:FindDescendantByName("Total Queued Bottom")
	local top_number = this.body:FindChildByName("Top Number")
	local bottom_number = this.body:FindChildByName("Bottom Number")

	local top_queue = YOOTIL.Utils.Queue:new()
	local bottom_queue = YOOTIL.Utils.Queue:new()

	local queue = YOOTIL.Utils.Queue:new()
	local monitor_started = false

	local top_item = nil
	local bottom_item = nil

	function this:monitor_queue(speed)
		if(this.options.node_time ~= nil and this.options.node_time > 0) then
			this.options.queue_task = Task.Spawn(function()
				if(top_item == nil and not top_queue:is_empty()) then
					top_item = top_queue:pop()
					top_queue_count.text = tostring(top_queue:length())
					top_number.text = tostring(top_item)
				end

				if(bottom_item == nil and not bottom_queue:is_empty()) then
					bottom_item = bottom_queue:pop()
					bottom_queue_count.text = tostring(bottom_queue:length())
					bottom_number.text = tostring(bottom_item)
				end

				if(top_item ~= nil and bottom_item ~= nil) then
					if(not queue:is_empty() and this:has_connection()) then
						queue:pop()(top_item, bottom_item)

						top_item = nil
						bottom_item = nil

						top_number.text = "-"
						bottom_number.text = "-"
					end
				end
			end, this.options.node_time / speed)

			this.options.queue_task.repeatCount = -1
			this.options.queue_task.repeatInterval = (this.options.node_time / speed)
		end
	end

	this.options.on_data_received = function(data, node, from_node)
		if(not monitor_started) then
			monitor_started = true

			this:set_speed(from_node:get_speed())
			this:monitor_queue(from_node:get_speed())
		end

		local has_connection = false

		if(this:is_receiving_top(data.connection_to_id)) then
			top_queue:push(data.value)
			top_queue_count.text = tostring(top_queue:length())
			has_connection = true
		else
			bottom_queue:push(data.value)
			bottom_queue_count.text = tostring(bottom_queue:length())
			has_connection = true
		end

		if(has_connection) then
			local queue_func = function(top_value, bottom_value)
				Events.Broadcast("score", this.options.node_time or 0)

				local connection_to_id = this:has_top_connection()

				if(connection_to_id) then
					data.connection_to_id = connection_to_id
					data.value = tonumber(string.format("%.02f", top_value + bottom_value))

					local line = this:get_connector_line(true)
					local obj = this:spawn_asset(data.asset, line.x, line.y, data.value)
					local tween = this:create_tween(line)
					local offset = this:get_top_offset()

					this:insert_tween({

						obj = obj,
						tween = tween

					})

					if(tween ~= nil) then
						tween:on_start(function()
							obj.visibility = Visibility.FORCE_ON
						end)

						tween:on_complete(function()
							this["send_data_top"](this, data)

							if(Object.IsValid(obj)) then
								obj:Destroy()
							end

							tween = nil
						end)

						tween:on_change(function(changed)
							local x, y = this:get_path(obj, line, changed, offset)

							if(x == nil or y == nil) then
								return
							end

							obj.x = x
							obj.y = y
						end)
					end
				else
					this:has_errors(true)
				end
			end

			if(this.options.node_time ~= nil and this.options.node_time > 0) then
				queue:push(queue_func)
			else
				queue_func()
			end
		end
	end

	function this:reset()
		this.options.added_tween = false

		if(this.options.queue_task ~= nil) then
			this.options.queue_task:Cancel()
			this.options.queue_task = nil
		end

		monitor_started = false
		this.tweens = {}

		top_queue = YOOTIL.Utils.Queue:new()
		bottom_queue = YOOTIL.Utils.Queue:new()

		queue = YOOTIL.Utils.Queue:new()

		top_item = nil
		bottom_item = nil

		top_queue_count.text = "0"
		bottom_queue_count.text = "0"
		top_number.text = "-"
		bottom_number.text = "-"

		this:clear_items_container()
		this:hide_error_info()
	end

	this.n_evts[#this.n_evts + 1] = Node_Events.on("node_destroyed", function()
		if(this.options.queue_task ~= nil) then
			this.options.queue_task:Cancel()
			this.options.queue_task = nil
		end
	end)

	return this
end

-- End Add Node

-- Substract Node

local Node_Substract = {}

function Node_Substract:new(r, options)
	self.__index = self

	local this = setmetatable({

		options = options or {}

	}, self)

	setmetatable(this, {__index = Node})

	this:setup(r)

	this.node_type = "Substract"

	local top_queue_count = this.body:FindDescendantByName("Total Queued Top")
	local bottom_queue_count = this.body:FindDescendantByName("Total Queued Bottom")
	local top_number = this.body:FindChildByName("Top Number")
	local bottom_number = this.body:FindChildByName("Bottom Number")

	local top_queue = YOOTIL.Utils.Queue:new()
	local bottom_queue = YOOTIL.Utils.Queue:new()

	local queue = YOOTIL.Utils.Queue:new()
	local monitor_started = false

	local top_item = nil
	local bottom_item = nil

	function this:monitor_queue(speed)
		if(this.options.node_time ~= nil and this.options.node_time > 0) then
			this.options.queue_task = Task.Spawn(function()
				if(top_item == nil and not top_queue:is_empty()) then
					top_item = top_queue:pop()
					top_queue_count.text = tostring(top_queue:length())
					top_number.text = tostring(top_item)
				end

				if(bottom_item == nil and not bottom_queue:is_empty()) then
					bottom_item = bottom_queue:pop()
					bottom_queue_count.text = tostring(bottom_queue:length())
					bottom_number.text = tostring(bottom_item)
				end

				if(top_item ~= nil and bottom_item ~= nil) then
					if(not queue:is_empty() and this:has_connection()) then
						queue:pop()(top_item, bottom_item)

						top_item = nil
						bottom_item = nil

						top_number.text = "-"
						bottom_number.text = "-"
					end
				end
			end, this.options.node_time / speed)

			this.options.queue_task.repeatCount = -1
			this.options.queue_task.repeatInterval = (this.options.node_time / speed)
		end
	end

	this.options.on_data_received = function(data, node, from_node)
		if(not monitor_started) then
			monitor_started = true

			this:set_speed(from_node:get_speed())
			this:monitor_queue(from_node:get_speed())
		end

		if(this:is_receiving_top(data.connection_to_id)) then
			top_queue:push(data.value)
			top_queue_count.text = tostring(top_queue:length())

			local queue_func = function(top_value, bottom_value)
				Events.Broadcast("score", this.options.node_time or 0)

				local connection_to_id = this:has_top_connection()

				if(connection_to_id) then
					data.connection_to_id = connection_to_id
					data.value = tonumber(string.format("%.02f", top_value - bottom_value))

					local line = this:get_connector_line(true)
					local obj = this:spawn_asset(data.asset, line.x, line.y, data.value)
					local tween = this:create_tween(line)
					local offset = this:get_top_offset()

					this:insert_tween({

						obj = obj,
						tween = tween

					})

					if(tween ~= nil) then
						tween:on_start(function()
							obj.visibility = Visibility.FORCE_ON
						end)

						tween:on_complete(function()
							this["send_data_top"](this, data)

							if(Object.IsValid(obj)) then
								obj:Destroy()
							end

							tween = nil
						end)

						tween:on_change(function(changed)
							local x, y = this:get_path(obj, line, changed, offset)

							if(x == nil or y == nil) then
								return
							end

							obj.x = x
							obj.y = y
						end)
					end
				else
					this:has_errors(true)
				end
			end

			if(this.options.node_time ~= nil and this.options.node_time > 0) then
				queue:push(queue_func)
			else
				queue_func()
			end
		else
			bottom_queue:push(data.value)
			bottom_queue_count.text = tostring(bottom_queue:length())
		end
	end

	function this:reset()
		this.options.added_tween = false

		if(this.options.queue_task ~= nil) then
			this.options.queue_task:Cancel()
			this.options.queue_task = nil
		end

		monitor_started = false
		this.tweens = {}

		top_queue = YOOTIL.Utils.Queue:new()
		bottom_queue = YOOTIL.Utils.Queue:new()

		queue = YOOTIL.Utils.Queue:new()

		top_item = nil
		bottom_item = nil

		top_queue_count.text = "0"
		bottom_queue_count.text = "0"
		top_number.text = "-"
		bottom_number.text = "-"

		this:clear_items_container()
		this:hide_error_info()
	end

	this.n_evts[#this.n_evts + 1] = Node_Events.on("node_destroyed", function()
		if(this.options.queue_task ~= nil) then
			this.options.queue_task:Cancel()
			this.options.queue_task = nil
		end
	end)

	return this
end

-- End Substract Node

-- Multiply Node

local Node_Multiply = {}

function Node_Multiply:new(r, options)
	self.__index = self

	local this = setmetatable({

		options = options or {}

	}, self)

	setmetatable(this, {__index = Node})

	this:setup(r)

	this.node_type = "Multiply"

	local top_queue_count = this.body:FindDescendantByName("Total Queued Top")
	local bottom_queue_count = this.body:FindDescendantByName("Total Queued Bottom")
	local top_number = this.body:FindChildByName("Top Number")
	local bottom_number = this.body:FindChildByName("Bottom Number")

	local top_queue = YOOTIL.Utils.Queue:new()
	local bottom_queue = YOOTIL.Utils.Queue:new()

	local queue = YOOTIL.Utils.Queue:new()
	local monitor_started = false

	local top_item = nil
	local bottom_item = nil

	function this:monitor_queue(speed)
		if(this.options.node_time ~= nil and this.options.node_time > 0) then
			this.options.queue_task = Task.Spawn(function()
				if(top_item == nil and not top_queue:is_empty()) then
					top_item = top_queue:pop()
					top_queue_count.text = tostring(top_queue:length())
					top_number.text = tostring(top_item)
				end

				if(bottom_item == nil and not bottom_queue:is_empty()) then
					bottom_item = bottom_queue:pop()
					bottom_queue_count.text = tostring(bottom_queue:length())
					bottom_number.text = tostring(bottom_item)
				end

				if(top_item ~= nil and bottom_item ~= nil) then
					if(not queue:is_empty() and this:has_connection()) then
						queue:pop()(top_item, bottom_item)

						top_item = nil
						bottom_item = nil

						top_number.text = "-"
						bottom_number.text = "-"
					end
				end
			end, this.options.node_time / speed)

			this.options.queue_task.repeatCount = -1
			this.options.queue_task.repeatInterval = (this.options.node_time / speed)
		end
	end

	this.options.on_data_received = function(data, node, from_node)
		if(not monitor_started) then
			monitor_started = true

			this:set_speed(from_node:get_speed())
			this:monitor_queue(from_node:get_speed())
		end

		if(this:is_receiving_top(data.connection_to_id)) then
			top_queue:push(data.value)
			top_queue_count.text = tostring(top_queue:length())

			local queue_func = function(top_value, bottom_value)
				Events.Broadcast("score", this.options.node_time or 0)

				local connection_to_id = this:has_top_connection()

				if(connection_to_id) then
					data.connection_to_id = connection_to_id
					data.value = tonumber(string.format("%.02f", top_value * bottom_value))

					local line = this:get_connector_line(true)
					local obj = this:spawn_asset(data.asset, line.x, line.y, data.value)
					local tween = this:create_tween(line)
					local offset = this:get_top_offset()

					this:insert_tween({

						obj = obj,
						tween = tween

					})

					if(tween ~= nil) then
						tween:on_start(function()
							obj.visibility = Visibility.FORCE_ON
						end)

						tween:on_complete(function()
							this["send_data_top"](this, data)

							if(Object.IsValid(obj)) then
								obj:Destroy()
							end

							tween = nil
						end)

						tween:on_change(function(changed)
							local x, y = this:get_path(obj, line, changed, offset)

							if(x == nil or y == nil) then
								return
							end

							obj.x = x
							obj.y = y
						end)
					end
				else
					this:has_errors(true)
				end
			end

			if(this.options.node_time ~= nil and this.options.node_time > 0) then
				queue:push(queue_func)
			else
				queue_func()
			end
		else
			bottom_queue:push(data.value)
			bottom_queue_count.text = tostring(bottom_queue:length())
		end
	end

	function this:reset()
		this.options.added_tween = false

		if(this.options.queue_task ~= nil) then
			this.options.queue_task:Cancel()
			this.options.queue_task = nil
		end

		monitor_started = false
		this.tweens = {}

		top_queue = YOOTIL.Utils.Queue:new()
		bottom_queue = YOOTIL.Utils.Queue:new()

		queue = YOOTIL.Utils.Queue:new()

		top_item = nil
		bottom_item = nil

		top_queue_count.text = "0"
		bottom_queue_count.text = "0"
		top_number.text = "-"
		bottom_number.text = "-"

		this:clear_items_container()
		this:hide_error_info()
	end

	this.n_evts[#this.n_evts + 1] = Node_Events.on("node_destroyed", function()
		if(this.options.queue_task ~= nil) then
			this.options.queue_task:Cancel()
			this.options.queue_task = nil
		end
	end)

	return this
end

-- End Multiply Node

-- Divide Node

local Node_Divide = {}

function Node_Divide:new(r, options)
	self.__index = self

	local this = setmetatable({

		options = options or {}

	}, self)

	setmetatable(this, {__index = Node})

	this:setup(r)

	this.node_type = "Divide"

	local top_queue_count = this.body:FindDescendantByName("Total Queued Top")
	local bottom_queue_count = this.body:FindDescendantByName("Total Queued Bottom")
	local top_number = this.body:FindChildByName("Top Number")
	local bottom_number = this.body:FindChildByName("Bottom Number")

	local top_queue = YOOTIL.Utils.Queue:new()
	local bottom_queue = YOOTIL.Utils.Queue:new()

	local queue = YOOTIL.Utils.Queue:new()
	local monitor_started = false

	local top_item = nil
	local bottom_item = nil

	function this:monitor_queue(speed)
		if(this.options.node_time ~= nil and this.options.node_time > 0) then
			this.options.queue_task = Task.Spawn(function()
				if(top_item == nil and not top_queue:is_empty()) then
					top_item = top_queue:pop()
					top_queue_count.text = tostring(top_queue:length())
					top_number.text = tostring(top_item)
				end

				if(bottom_item == nil and not bottom_queue:is_empty()) then
					bottom_item = bottom_queue:pop()
					bottom_queue_count.text = tostring(bottom_queue:length())
					bottom_number.text = tostring(bottom_item)
				end

				if(top_item ~= nil and bottom_item ~= nil) then
					if(not queue:is_empty() and this:has_connection()) then
						queue:pop()(top_item, bottom_item)

						top_item = nil
						bottom_item = nil

						top_number.text = "-"
						bottom_number.text = "-"
					end
				end
			end, this.options.node_time / speed)

			this.options.queue_task.repeatCount = -1
			this.options.queue_task.repeatInterval = (this.options.node_time / speed)
		end
	end

	this.options.on_data_received = function(data, node, from_node)
		if(not monitor_started) then
			monitor_started = true

			this:set_speed(from_node:get_speed())
			this:monitor_queue(from_node:get_speed())
		end

		if(this:is_receiving_top(data.connection_to_id)) then
			top_queue:push(data.value)
			top_queue_count.text = tostring(top_queue:length())

			local queue_func = function(top_value, bottom_value)
				Events.Broadcast("score", this.options.node_time or 0)

				local connection_to_id = this:has_top_connection()

				if(connection_to_id) then
					data.connection_to_id = connection_to_id
					data.value = tonumber(string.format("%.02f", top_value / bottom_value))

					local line = this:get_connector_line(true)
					local obj = this:spawn_asset(data.asset, line.x, line.y, data.value)
					local tween = this:create_tween(line)
					local offset = this:get_top_offset()

					this:insert_tween({

						obj = obj,
						tween = tween

					})

					if(tween ~= nil) then
						tween:on_start(function()
							obj.visibility = Visibility.FORCE_ON
						end)

						tween:on_complete(function()
							this["send_data_top"](this, data)

							if(Object.IsValid(obj)) then
								obj:Destroy()
							end

							tween = nil
						end)

						tween:on_change(function(changed)
							local x, y = this:get_path(obj, line, changed, offset)

							if(x == nil or y == nil) then
								return
							end

							obj.x = x
							obj.y = y
						end)
					end
				else
					this:has_errors(true)
				end
			end

			if(this.options.node_time ~= nil and this.options.node_time > 0) then
				queue:push(queue_func)
			else
				queue_func()
			end
		else
			bottom_queue:push(data.value)
			bottom_queue_count.text = tostring(bottom_queue:length())
		end
	end

	function this:reset()
		this.options.added_tween = false

		if(this.options.queue_task ~= nil) then
			this.options.queue_task:Cancel()
			this.options.queue_task = nil
		end

		monitor_started = false
		this.tweens = {}

		top_queue = YOOTIL.Utils.Queue:new()
		bottom_queue = YOOTIL.Utils.Queue:new()

		queue = YOOTIL.Utils.Queue:new()

		top_item = nil
		bottom_item = nil

		top_queue_count.text = "0"
		bottom_queue_count.text = "0"
		top_number.text = "-"
		bottom_number.text = "-"

		this:clear_items_container()
		this:hide_error_info()
	end

	this.n_evts[#this.n_evts + 1] = Node_Events.on("node_destroyed", function()
		if(this.options.queue_task ~= nil) then
			this.options.queue_task:Cancel()
			this.options.queue_task = nil
		end
	end)

	return this
end

-- End Divide Node

-- Greater Than Node

local Node_Greater_Than = {}

function Node_Greater_Than:new(r, options)
	self.__index = self

	local this = setmetatable({

		options = options or {}

	}, self)

	setmetatable(this, {__index = Node})

	this:setup(r)

	this.node_type = "Greater_Than"

	this.options.queue_task = nil

	local queue = YOOTIL.Utils.Queue:new()
	local monitor_started = false
	local amount = 0
	local orig_amount = 0
	local amount_txt = this.body:FindDescendantByName("Amount")
	local minus_button = this.body:FindDescendantByName("Minus")
	local plus_button = this.body:FindDescendantByName("Plus")

	this.evts[#this.evts + 1] = minus_button.clickedEvent:Connect(function()
		if(amount > -100) then
			local val = 0.50

			if(this.shift_pressed) then
				val = 1
			end

			amount = amount - val
		end

		amount_txt.text = string.format("%0.2f", amount)
		orig_amount = amount
	end)

	this.evts[#this.evts + 1] = plus_button.clickedEvent:Connect(function()
		if(amount < 100) then
			local val = 0.50

			if(this.shift_pressed) then
				val = 1
			end

			amount = amount + val
		end

		amount_txt.text = string.format("%0.2f", amount)
		orig_amount = amount
	end)

	this.n_evts[#this.n_evts + 1] = Node_Events.on("edit", function(can_edit)
		if(Object.IsValid(minus_button)) then
			if(can_edit) then
				minus_button.isInteractable = true
			else
				minus_button.isInteractable = false
			end
		end

		if(Object.IsValid(plus_button)) then
			if(can_edit) then
				plus_button.isInteractable = true
			else
				plus_button.isInteractable = false
			end
		end
	end)

	function this:monitor_queue(speed)
		if(this.options.node_time ~= nil and this.options.node_time > 0) then
			this.options.queue_task = Task.Spawn(function()
				if(not queue:is_empty()) then
					queue:pop()()
				end
			end, this.options.node_time / speed)

			this.options.queue_task.repeatCount = -1
			this.options.queue_task.repeatInterval = (this.options.node_time / speed)
		end
	end

	this.options.on_data_received = function(data, node, from_node)
		if(not monitor_started) then
			monitor_started = true

			this:set_speed(from_node:get_speed())
			this:monitor_queue(from_node:get_speed())
		end

		local queue_func = function()
			Events.Broadcast("score", this.options.node_time or 0)

			local top_connection = this:has_top_connection()
			local bottom_connection = this:has_bottom_connection()

			if(top_connection or bottom_connection) then
				local obj = nil

				local line = this:get_connector_line(data.value > amount)
				local tween = this:create_tween(line)
				local connection_method = nil
				local offset = this:get_top_offset()

				if(top_connection and data.value > amount) then
					data.connection_to_id = top_connection

					obj = this:spawn_asset(data.asset, line.x, line.y, data.value)
					connection_method = "send_data_top"

					this:insert_tween({

						obj = obj,
						tween = tween

					})
				elseif(bottom_connection) then
					data.connection_to_id = bottom_connection

					offset = this:get_bottom_offset()

					if(Object.IsValid(line)) then
						obj = this:spawn_asset(data.asset, line.x, line.y, data.value)
						connection_method = "send_data_bottom"

						this:insert_tween({

							obj = obj,
							tween = tween

						})
					end
				else
					this:has_errors(true)
				end

				if(tween ~= nil and connection_method ~= nil) then
					tween:on_start(function()
						obj.visibility = Visibility.FORCE_ON
					end)

					tween:on_complete(function()
						this[connection_method](this, data)

						if(Object.IsValid(obj)) then
							obj:Destroy()
						end

						tween = nil
					end)

					tween:on_change(function(changed)
						local x, y = this:get_path(obj, line, changed, offset)

						if(x == nil or y == nil) then
							return
						end

						obj.x = x
						obj.y = y
					end)
				end
			else
				this:has_errors(true)
			end
		end

		if(this.options.node_time ~= nil and this.options.node_time > 0) then
			queue:push(queue_func)
		else
			queue_func()
		end
	end

	function this:reset()
		this.options.added_tween = false

		if(this.options.queue_task ~= nil) then
			this.options.queue_task:Cancel()
			this.options.queue_task = nil
		end

		monitor_started = false
		queue = YOOTIL.Utils.Queue:new()
		this.tweens = {}
		amount = orig_amount
		amount_txt.text = string.format("%.02f", amount)

		this:clear_items_container()
		this:hide_error_info()
	end

	function this:get_amount()
		return amount
	end

	function this:set_amount(a)
		if(a ~= nil and a > -100 and a < 100) then
			amount = tonumber(string.format("%.02f", a))
			amount_txt.text = string.format("%.02f", amount)
			orig_amount = amount
		end
	end

	this.n_evts[#this.n_evts + 1] = Node_Events.on("node_destroyed", function()
		if(this.options.queue_task ~= nil) then
			this.options.queue_task:Cancel()
			this.options.queue_task = nil
		end
	end)

	return this
end

-- End Greater Than Node

-- Less Than Node

local Node_Less_Than = {}

function Node_Less_Than:new(r, options)
	self.__index = self

	local this = setmetatable({

		options = options or {}

	}, self)

	setmetatable(this, {__index = Node})

	this:setup(r)

	this.node_type = "Less_Than"

	this.options.queue_task = nil

	local queue = YOOTIL.Utils.Queue:new()
	local monitor_started = false
	local amount = 0
	local orig_amount = 0
	local amount_txt = this.body:FindDescendantByName("Amount")
	local minus_button = this.body:FindDescendantByName("Minus")
	local plus_button = this.body:FindDescendantByName("Plus")

	this.evts[#this.evts + 1] = minus_button.clickedEvent:Connect(function()
		if(amount > -100) then
			local val = 0.5

			if(this.shift_pressed) then
				val = 1
			end

			amount = amount - val
		end

		amount_txt.text = string.format("%0.2f", amount)
		orig_amount = amount
	end)

	this.evts[#this.evts + 1] = plus_button.clickedEvent:Connect(function()
		if(amount < 100) then
			local val = 0.5

			if(this.shift_pressed) then
				val = 1
			end

			amount = amount + val
		end

		amount_txt.text = string.format("%0.2f", amount)
		orig_amount = amount
	end)

	this.n_evts[#this.n_evts + 1] = Node_Events.on("edit", function(can_edit)
		if(Object.IsValid(minus_button)) then
			if(can_edit) then
				minus_button.isInteractable = true
			else
				minus_button.isInteractable = false
			end
		end

		if(Object.IsValid(plus_button)) then
			if(can_edit) then
				plus_button.isInteractable = true
			else
				plus_button.isInteractable = false
			end
		end
	end)

	function this:monitor_queue(speed)
		if(this.options.node_time ~= nil and this.options.node_time > 0) then
			this.options.queue_task = Task.Spawn(function()
				if(not queue:is_empty()) then
					queue:pop()()
				end
			end, this.options.node_time / speed)

			this.options.queue_task.repeatCount = -1
			this.options.queue_task.repeatInterval = (this.options.node_time / speed)
		end
	end

	this.options.on_data_received = function(data, node, from_node)
		if(not monitor_started) then
			monitor_started = true

			this:set_speed(from_node:get_speed())
			this:monitor_queue(from_node:get_speed())
		end

		local queue_func = function()
			Events.Broadcast("score", this.options.node_time or 0)

			local top_connection = this:has_top_connection()
			local bottom_connection = this:has_bottom_connection()

			if(top_connection or bottom_connection) then
				local obj = nil

				local line = this:get_connector_line(data.value > amount)
				local tween = this:create_tween(line)
				local connection_method = nil
				local offset = this:get_top_offset()

				if(top_connection and data.value < amount) then
					data.connection_to_id = top_connection

					obj = this:spawn_asset(data.asset, line.x, line.y, data.value)
					connection_method = "send_data_top"

					this:insert_tween({

						obj = obj,
						tween = tween

					})
				elseif(bottom_connection) then
					data.connection_to_id = bottom_connection

					offset = this:get_bottom_offset()

					if(Object.IsValid(line)) then
						obj = this:spawn_asset(data.asset, line.x, line.y, data.value)
						connection_method = "send_data_bottom"

						this:insert_tween({

							obj = obj,
							tween = tween

						})
					end
				else
					this:has_errors(true)
				end

				if(tween ~= nil and connection_method ~= nil) then
					tween:on_start(function()
						obj.visibility = Visibility.FORCE_ON
					end)

					tween:on_complete(function()
						this[connection_method](this, data)

						if(Object.IsValid(obj)) then
							obj:Destroy()
						end

						tween = nil
					end)

					tween:on_change(function(changed)
						local x, y = this:get_path(obj, line, changed, offset)

						if(x == nil or y == nil) then
							return
						end

						obj.x = x
						obj.y = y
					end)
				end
			else
				this:has_errors(true)
			end
		end

		if(this.options.node_time ~= nil and this.options.node_time > 0) then
			queue:push(queue_func)
		else
			queue_func()
		end
	end

	function this:reset()
		this.options.added_tween = false

		if(this.options.queue_task ~= nil) then
			this.options.queue_task:Cancel()
			this.options.queue_task = nil
		end

		monitor_started = false
		queue = YOOTIL.Utils.Queue:new()
		this.tweens = {}
		amount = orig_amount
		amount_txt.text = string.format("%.02f", amount)

		this:clear_items_container()
		this:hide_error_info()
	end

	function this:get_amount()
		return amount
	end

	function this:set_amount(a)
		if(a ~= nil and a > -100 and a < 100) then
			amount = tonumber(string.format("%.02f", a))
			amount_txt.text = string.format("%.02f", amount)
			orig_amount = amount
		end
	end

	this.n_evts[#this.n_evts + 1] = Node_Events.on("node_destroyed", function()
		if(this.options.queue_task ~= nil) then
			this.options.queue_task:Cancel()
			this.options.queue_task = nil
		end
	end)

	return this
end

-- End Less Than Node

-- Equal Node

local Node_Equal = {}

function Node_Equal:new(r, options)
	self.__index = self

	local this = setmetatable({

		options = options or {}

	}, self)

	setmetatable(this, {__index = Node})

	this:setup(r)

	this.node_type = "Equal"

	this.options.queue_task = nil

	local queue = YOOTIL.Utils.Queue:new()
	local monitor_started = false
	local amount = 0
	local orig_amount = 0
	local amount_txt = this.body:FindDescendantByName("Amount")
	local minus_button = this.body:FindDescendantByName("Minus")
	local plus_button = this.body:FindDescendantByName("Plus")

	this.evts[#this.evts + 1] = minus_button.clickedEvent:Connect(function()
		if(amount > -99.9) then
			local val = 0.05

			if(this.shift_pressed) then
				val = 0.5
			end

			amount = amount - val
		end

		amount_txt.text = string.format("%0.2f", amount)
		orig_amount = amount
	end)

	this.evts[#this.evts + 1] = plus_button.clickedEvent:Connect(function()
		if(amount < 99.9) then
			local val = 0.05

			if(this.shift_pressed) then
				val = 0.5
			end

			amount = amount + val
		end

		amount_txt.text = string.format("%0.2f", amount)
		orig_amount = amount
	end)

	this.n_evts[#this.n_evts + 1] = Node_Events.on("edit", function(can_edit)
		if(Object.IsValid(minus_button)) then
			if(can_edit) then
				minus_button.isInteractable = true
			else
				minus_button.isInteractable = false
			end
		end

		if(Object.IsValid(plus_button)) then
			if(can_edit) then
				plus_button.isInteractable = true
			else
				plus_button.isInteractable = false
			end
		end
	end)

	function this:monitor_queue(speed)
		if(this.options.node_time ~= nil and this.options.node_time > 0) then
			this.options.queue_task = Task.Spawn(function()
				if(not queue:is_empty()) then
					queue:pop()()
				end
			end, this.options.node_time / speed)

			this.options.queue_task.repeatCount = -1
			this.options.queue_task.repeatInterval = (this.options.node_time / speed)
		end
	end

	this.options.on_data_received = function(data, node, from_node)
		if(not monitor_started) then
			monitor_started = true

			this:set_speed(from_node:get_speed())
			this:monitor_queue(from_node:get_speed())
		end

		local queue_func = function()
			Events.Broadcast("score", this.options.node_time or 0)

			local top_connection = this:has_top_connection()
			local bottom_connection = this:has_bottom_connection()

			if(top_connection or bottom_connection) then
				local obj = nil
				local line = this:get_connector_line(data.value == amount)
				local tween = this:create_tween(line)
				local connection_method = nil
				local offset = this:get_top_offset()

				if(top_connection and data.value == amount) then
					data.connection_to_id = top_connection
					obj = this:spawn_asset(data.asset, line.x, line.y, data.value)
					connection_method = "send_data_top"

					this:insert_tween({

						obj = obj,
						tween = tween

					})
				elseif(bottom_connection) then
					data.connection_to_id = bottom_connection
					offset = this:get_bottom_offset()

					if(Object.IsValid(line)) then
						obj = this:spawn_asset(data.asset, line.x, line.y, data.value)
						connection_method = "send_data_bottom"

						this:insert_tween({

							obj = obj,
							tween = tween

						})
					end
				else
					this:has_errors(true)
				end

				if(tween ~= nil and connection_method ~= nil) then
					tween:on_start(function()
						obj.visibility = Visibility.FORCE_ON
					end)

					tween:on_complete(function()
						this[connection_method](this, data)

						if(Object.IsValid(obj)) then
							obj:Destroy()
						end

						tween = nil
					end)

					tween:on_change(function(changed)
						local x, y = this:get_path(obj, line, changed, offset)

						if(x == nil or y == nil) then
							return
						end

						obj.x = x
						obj.y = y
					end)
				end
			else
				this:has_errors(true)
			end
		end

		if(this.options.node_time ~= nil and this.options.node_time > 0) then
			queue:push(queue_func)
		else
			queue_func()
		end
	end

	function this:reset()
		this.options.added_tween = false

		if(this.options.queue_task ~= nil) then
			this.options.queue_task:Cancel()
			this.options.queue_task = nil
		end

		monitor_started = false
		queue = YOOTIL.Utils.Queue:new()
		this.tweens = {}
		amount = orig_amount
		amount_txt.text = string.format("%.02f", amount)

		this:clear_items_container()
		this:hide_error_info()
	end

	function this:get_amount()
		return amount
	end

	function this:set_amount(a)
		if(a ~= nil and a > -99.9 and a < 99.9) then
			amount = tonumber(string.format("%.02f", a))
			amount_txt.text = string.format("%.02f", amount)
			orig_amount = amount
		end
	end

	this.n_evts[#this.n_evts + 1] = Node_Events.on("node_destroyed", function()
		if(this.options.queue_task ~= nil) then
			this.options.queue_task:Cancel()
			this.options.queue_task = nil
		end
	end)

	return this
end

-- End Equal Node

-- Absolute Node

local Node_Absolute = {}

function Node_Absolute:new(r, options)
	self.__index = self

	local this = setmetatable({

		options = options or {}

	}, self)

	setmetatable(this, {__index = Node})

	this:setup(r)

	this.node_type = "Absolute"

	this.options.queue_task = nil

	local queue = YOOTIL.Utils.Queue:new()
	local monitor_started = false

	function this:monitor_queue(speed)
		if(this.options.node_time ~= nil and this.options.node_time > 0) then
			this.options.queue_task = Task.Spawn(function()
				if(not queue:is_empty()) then
					queue:pop()()
				end
			end, this.options.node_time / speed)

			this.options.queue_task.repeatCount = -1
			this.options.queue_task.repeatInterval = (this.options.node_time / speed)
		end
	end

	this.options.on_data_received = function(data, node, from_node)
		if(not monitor_started) then
			monitor_started = true

			this:set_speed(from_node:get_speed())
			this:monitor_queue(from_node:get_speed())
		end

		local queue_func = function()
			Events.Broadcast("score", this.options.node_time or 0)

			local top_connection = this:has_top_connection()

			if(top_connection) then
				data.value = math.abs(data.value)
				data.connection_to_id = top_connection

				local line = this:get_connector_line(true)
				local tween = this:create_tween(line)
				local connection_method = "send_data_top"
				local offset = this:get_top_offset()
				local obj = this:spawn_asset(data.asset, line.x, line.y, data.value)

				this:insert_tween({

					obj = obj,
					tween = tween

				})

				if(tween ~= nil and connection_method ~= nil) then
					tween:on_start(function()
						obj.visibility = Visibility.FORCE_ON
					end)

					tween:on_complete(function()
						this[connection_method](this, data)

						if(Object.IsValid(obj)) then
							obj:Destroy()
						end

						tween = nil
					end)

					tween:on_change(function(changed)
						local x, y = this:get_path(obj, line, changed, offset)

						if(x == nil or y == nil) then
							return
						end

						obj.x = x
						obj.y = y
					end)
				end
			else
				this:has_errors(true)
			end
		end

		if(this.options.node_time ~= nil and this.options.node_time > 0) then
			queue:push(queue_func)
		else
			queue_func()
		end
	end

	function this:reset()
		this.options.added_tween = false

		if(this.options.queue_task ~= nil) then
			this.options.queue_task:Cancel()
			this.options.queue_task = nil
		end

		monitor_started = false
		queue = YOOTIL.Utils.Queue:new()
		this.tweens = {}

		this:clear_items_container()
		this:hide_error_info()
	end

	this.n_evts[#this.n_evts + 1] = Node_Events.on("node_destroyed", function()
		if(this.options.queue_task ~= nil) then
			this.options.queue_task:Cancel()
			this.options.queue_task = nil
		end
	end)

	return this
end

-- End Absolute Node

return Node, Node_Events, {

	Output = Node_Output,
	If = Node_If,
	Data = Node_Data,
	Alternate = Node_Alternate,
	Limit = Node_Limit,
	Halt = Node_Halt,
	Add = Node_Add,
	Substract = Node_Substract,
	Multiply = Node_Multiply,
	Divide = Node_Divide,
	Greater_Than = Node_Greater_Than,
	Less_Than = Node_Less_Than,
	Equal = Node_Equal,
	Absolute = Node_Absolute

}