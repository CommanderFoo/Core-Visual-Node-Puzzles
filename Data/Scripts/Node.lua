local Node_Events = {}

function Node_Events.on(event, fn)
	if(Node_Events[event] == nil) then
		Node_Events[event] = {}
	end

	table.insert(Node_Events[event], #Node_Events[event] + 1, fn)
end

function Node_Events.trigger(...)
	local args = {...}

	if(Node_Events[args[1]] ~= nil) then
		for _, f in ipairs(Node_Events[args[1]]) do
			f(args[2], args[3], args[4], args[5])
		end
	end
end

local Node = {

	distance = function(a, b)
		local dx = a.x - b.x
		local dy = a.y - b.y
	
		return math.floor(math.abs(math.sqrt(dx * dx + dy * dy)))
	end,
	
	angle_to = function(a, b)
		if(b) then
			return math.deg(math.atan(a.y - b.y, a.x - b.x))
		end
	
		return math.deg(math.atan(a.y, a.x))
	end

}

function Node:setup(r)
	self.moving = false
	self.offset = Vector2.New(0, 0)
	self.active_connection = nil
	self.output_connections = {}
	self.input_connections = {}
	self.output_connected_to = {}
	self.input_connected_to = {}
	self.output_data = {}
	self.input_data = {}
	self.can_tick = false
	self.data_received_func = nil
	self.default_connector_color = Color.New(0.215861, 0.215861, 0.215861)
	self.error_task = nil
	self.can_flow_data = true
	self.on_connection_func = nil

	self.root = r

	self:setup_node()
	self:setup_output_connections()
	self:setup_input_connections()

	Node_Events.on("begin_drag_node", function(node)
		if(node.id ~= self.id) then
			self:stop_all_drag()
		end
	end)

	Node_Events.on("dragging_node", function()
		self:move_connections()
	end)

	Node_Events.on("break_connection", function(connection_id, stop_drag)
		self:clear_input_connection(connection_id)
		self:clear_output_connection(connection_id)

		if(stop_drag) then
			self:stop_all_drag()
		end
	end)
end

function Node:setup_node(root)
	self.handle = self.root:FindDescendantByName("Node Handle")
	self.highlight = self.root:FindDescendantByName("Highlight Border")
	self.id = self.handle.id
	self.error_warning = self.root:FindDescendantByName("Error Warning")
	self.delete_button = self.root:FindDescendantByName("Delete Node")

	self.handle.pressedEvent:Connect(function(obj)
		self:clear_active_connection()

		if(self.moving) then
			self.moving = false
			self.highlight.visibility = Visibility.FORCE_OFF

			Node_Events.trigger("end_drag_node", self)
		else
			local pos = UI.GetCursorPosition()
	
			self.offset.x = pos.x - self.root.x
			self.offset.y = pos.y - self.root.y
	
			self.moving = true

			self:move_to_front()
			self:move_connections()

			self.highlight.visibility = Visibility.FORCE_ON

			Node_Events.trigger("begin_drag_node", self)
		end
	end)

	self.delete_button.pressedEvent:Connect(function(obj)
		self:clear_active_connection()

		-- Need a break all connections method.

		--Node_Events.trigger("break_connection", connections[c].id, true)

		self.root:Destroy()
	end)
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

			connections[c].pressedEvent:Connect(function(obj)
				Node_Events.trigger("break_connection", connections[c].id, true)

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
	if(self.input_connected_to[id]) then
		self.input_connected_to[id] = nil
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
				can_be_connected_to = true

			}

			connections[c].pressedEvent:Connect(function(obj)
				Node_Events.trigger("input_connect", self, self.input_connections[connections[c].id])
			end)
		end
	end
end

function Node:output_connect_to(connected_to_node, connected_to_connection)
	if(not self.active_connection) then
		return
	end

	if(self.output_connected_to[self.active_connection.id] == nil) then
		self.output_connected_to[self.active_connection.id] = {}
	end

	table.insert(self.output_connected_to[self.active_connection.id], #self.output_connected_to[self.active_connection.id] + 1, {

		connected_to_node = connected_to_node,
		connected_to_connection = connected_to_connection,
		connection = self.active_connection

	})

	self.active_connection.moving = false
	self.active_connection.connector_image:SetColor(self.default_connector_color)
end

function Node:input_connect_to(connected_from_node, connected_from_connection, connected_to_connection)
	if(self.input_connected_to[connected_to_connection.id]) then
		-- TODO break connections if only 1 is allowed
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

function Node:move_connections()
	for _, c in pairs(self.output_connected_to) do
		for i, e in ipairs(c) do
			if(Object.IsValid(e.connected_to_connection.connection)) then
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
	self.root.parent = self.root.parent
end

function Node:drag_node()
	local screen_size = UI.GetScreenSize()
	
	if(self.moving) then
		local pos = UI.GetCursorPosition()

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

function Node:get_id()
	return self.id
end

function Node:get_root()
	return self.root
end

function Node:get_input_data()
	return self.input_data
end

function Node:get_output_data()
	return self.output_data
end

function Node:set_output_data(data)
	self.output_data = data
end

function Node:set_input_data(data)
	self.input_data = data

	if(self.data_received_func ~= nil) then
		self.data_received_func(self.input_data)
	end
end

function Node:data_received(func)
	self.data_received_func = func
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
			if(self.id ~= e.connected_to_node.id) then
				return true
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
		self.error_warning.visibility = Visibility.FORCE_OFF
	end
end

function Node:has_errors(b)
	if(b) then
		self:show_error_info()
	else
		self:hide_error_info()
	end
end

function Node:stop_data_flow()
	self.can_flow_data = false
end

function Node:start_data_flow()
	self.can_flow_data = true
end

function Node:can_auto_flow_data()
	return self.can_flow_data
end

function Node:has_top_connection()
	for _, c in pairs(self.output_connected_to) do
		for i, cs in pairs(c) do
			if(cs.connection.connector.name == "Connection Handle Top") then
				return true
			end
		end
	end

	return false
end

function Node:has_middle_connection()
	for _, c in pairs(self.output_connected_to) do
		for i, cs in pairs(c) do
			if(cs.connection.connector.name == "Connection Handle Middle") then
				return true
			end
		end
	end

	return false
end

function Node:has_bottom_connection()
	for _, c in pairs(self.output_connected_to) do
		for i, cs in pairs(c) do
			if(cs.connection.connector.name == "Connection Handle Bottom") then
				return true
			end
		end
	end

	return false
end

function Node:send_data_top_connection(data)
	for _, c in pairs(self.output_connected_to) do
		for i, cs in pairs(c) do
			if(cs.connection.connector.name == "Connection Handle Top") then
				cs.connected_to_node:set_input_data(data)
				cs.connected_to_node:send_data()
				break
			end
		end
	end
end

function Node:send_data_middle_connection(data)
	for _, c in pairs(self.output_connected_to) do
		for i, cs in pairs(c) do
			if(cs.connection.connector.name == "Connection Handle Middle") then
				cs.connected_to_node:set_input_data(data)
				cs.connected_to_node:send_data()
				break
			end
		end
	end
end

function Node:send_data_bottom_connection(data)
	for _, c in pairs(self.output_connected_to) do
		for i, cs in pairs(c) do
			if(cs.connection.connector.name == "Connection Handle Bottom") then
				cs.connected_to_node:set_input_data(data)
				cs.connected_to_node:send_data()
				break
			end
		end
	end
end

function Node:send_data()
	for _, c in pairs(self.output_connected_to) do
		for i, e in ipairs(c) do
			e.connected_to_node:set_input_data(self.output_data)

			if(self.id ~= e.connected_to_node.id and e.connected_to_node:can_auto_flow_data()) then
				e.connected_to_node:send_data()
			end
		end
	end
end

function Node:on_connection(func)
	self.on_connection_func = func
end

function Node:get_top_connector()
	for _, c in pairs(self.output_connections) do
		if(c.connector.name == "Connection Handle Top") then
			return c.connector
		end
	end
end

function Node:get_middle_connector()
	for _, c in pairs(self.output_connections) do
		if(c.connector.name == "Connection Handle Middle") then
			return c.connector
		end
	end
end

function Node:get_bottom_connector()
	for _, c in pairs(self.output_connections) do
		if(c.connector.name == "Connection Handle Bottom") then
			return c.connector
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

function Node:new(r)
	self.__index = self
	
	local o = setmetatable({}, self)

	 o:setup(r)

	 return o
end

return Node, Node_Events