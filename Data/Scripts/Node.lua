local Node_Events = {}

local floor = math.floor
local abs = math.abs
local sqrt = math.sqrt
local cos = math.cos
local sin = math.sin
local deg = math.deg
local pi = math.pi
local atan = math.atan

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

	Node_Events.on("edit", function(can_edit)
		self.can_edit_nodes = can_edit

		if(Object.IsValid(self.delete_button)) then
			if(can_edit) then
				self.delete_button.isInteractable = true
			else
				self.delete_button.isInteractable = false
			end
		end
	end)

	Node_Events.on("node_input_update", function(node_id)
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

	Node_Events.on("node_output_update", function(node_id)
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
	self.bubble = self.body:FindDescendantByName("Bubble")
	self.info_button = self.handle:FindChildByName("Info")
	self.info_data = self.root:FindDescendantByName("Node_Information_Data")

	if(self.options.node_time) then
		local node_time_ui = self.root:FindDescendantByName("Node Time")

		if(Object.IsValid(node_time_ui)) then
			node_time_ui.visibility = Visibility.FORCE_ON
			
			node_time_ui.text = string.format("%.2fs", self.options.node_time)
		end
	end

	self.handle.pressedEvent:Connect(function(obj)
		self:debug()

		if(not self.can_edit_nodes) then
			return
		end

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
		if(not self.can_edit_nodes) then
			return
		end

		self:clear_active_connection()

		Node_Events.trigger("node_input_update", self:get_id())
		Node_Events.trigger("node_output_update", self:get_id())
		Node_Events.trigger("node_destroyed", self:get_id(), self.root.sourceTemplateId)

		self:remove()
	end)

	if(self.info_button ~= nil and self.info_data ~= nil) then
		self.info_button.clickedEvent:Connect(function()
			Node_Events.trigger("node_info_click")
			Events.Broadcast("show_node_information", self.info_data)
		end)

		self.info_button.hoveredEvent:Connect(function()
			self.info_button:SetFontColor(self.delete_button:GetHoveredColor())
		end)

		self.info_button.unhoveredEvent:Connect(function()
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

	self.root:Destroy()
end

function Node:debug()
	if(not self.debug_node) then
		return
	end

	local inputs = 0
	local outputs = 0

	for k, v in pairs(self.input_connected_to) do
		for i, c in ipairs(v) do
			inputs = inputs + 1
		end
	end

	for k, v in pairs(self.output_connected_to) do
		for i, c in ipairs(v) do
			outputs = outputs + 1
		end
	end

	print("Inputs: " .. tostring(inputs))
	print("Outputs: " .. tostring(outputs))
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
				if(not self.can_edit_nodes) then
					return
				end

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
				can_be_connected_to = true,
				line = connections[c]:FindDescendantByName("Line")

			}

			connections[c].pressedEvent:Connect(function(obj)
				if(not self.can_edit_nodes) then
					return
				end

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
			if(Object.IsValid(e.connected_to_connection.connection) and Object.IsValid(e.connection.connector)) then
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

function Node:get_id()
	return self.id
end

function Node:get_root()
	return self.root
end

function Node:get_body()
	return self.body
end

function Node:get_bubble()
	return self.bubble
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

	local t = self.options.YOOTIL.Tween:new(self:get_tween_duration(), {a = 0}, {a = line.width})
	
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

function Node:insert_tween(obj)
	table.insert(self.tweens, #self.tweens + 1, obj)
end

function Node:set_option(opt, val)
	self.options[opt] = val
end

function Node:spawn_asset(asset, x, y)
	local obj = World.SpawnAsset(asset, {parent = self.items_container})

	obj.x = x
	obj.y = y

	obj.visibility = Visibility.FORCE_OFF

	return obj
end

function Node:clear_items_container()
	if(Object.IsValid(self.items_container) and #self.items_container:GetChildren() > 0) then
		for i, c in pairs(self.items_container:GetChildren()) do
			c:Destroy()
		end
	end
end

function Node:get_tweens()
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

function Node:new(r, options)
	self.__index = self

	local o = setmetatable({

		options = options or {}

	}, self)

	o:setup(r)

	return o
end

function Node:test()
	return self.options.a
end

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

	this.options.queue_task = nil

	local queue = this.options.YOOTIL.Utils.Queue:new()
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

			if(this:has_top_connection() or this:has_bottom_connection()) then
				local condition = (data.condition == this.options.if_condition)
				local obj = nil
				local line = this:get_connector_line(condition)
				local tween = this:create_tween(line)
				local connection_method = nil
				local offset = 0
		
				if(condition and this:has_top_connection()) then
					obj = this:spawn_asset(data.asset, line.x, line.y)
					connection_method = "send_data_top"
		
					this:insert_tween({
						
						obj = obj,
						tween = tween
					
					})
				elseif(this:has_bottom_connection()) then
					offset = this:get_bottom_offset()

					if(Object.IsValid(line)) then
						obj = this:spawn_asset(data.asset, line.x, line.y)
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
		queue = this.options.YOOTIL.Utils.Queue:new()
		this.tweens = {}

		this:clear_items_container()
		this:hide_error_info()
	end

	Node_Events.on("node_destroyed", function()
		if(this.options.queue_task ~= nil) then
			this.options.queue_task:Cancel()
			this.options.queue_task = nil
		end
	end)

	return this
end

-- End If Node

-- Data Node

local Node_Data = {}

function Node_Data:new(r, options)
	self.__index = self
	
	local this = setmetatable({

		options = options or {}

	}, self)

	setmetatable(this, {__index = Node})

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
		if(this:has_connection()) then
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
				local obj = this:spawn_asset(item.asset, line.x, line.y)
				local tween = this:create_tween(line)

				tween:on_start(function()
					obj.visibility = Visibility.FORCE_ON
				end)

				tween:on_complete(function()
					this:send_data({
						
						asset = item.asset,
						condition = item.condition,
						count = 1,
						total_count = item.count

					})

					if(Object.IsValid(obj)) then
						obj:Destroy()
					end

					tween = nil
				end)

				tween:on_change(function(changed)
					local x, y = this:get_path(obj, line, changed, -obj.height / 2)
			
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

-- End Output Node

-- Alternate Node

local Node_Alternate = {}

function Node_Alternate:new(r, options)
	self.__index = self
	
	local this = setmetatable({

		options = options or {}

	}, self)

	setmetatable(this, {__index = Node})

	this:setup(r)

	this.options.queue_task = nil

	local queue = this.options.YOOTIL.Utils.Queue:new()
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

			if(this:has_top_connection() or this:has_bottom_connection()) then
				local obj = nil
				local line = this:get_connector_line(switch)
				local tween = this:create_tween(line)
				local connection_method = nil
				local offset = 0
		
				if(switch and this:has_top_connection()) then
					obj = this:spawn_asset(data.asset, line.x, line.y)
					connection_method = "send_data_top"
		
					this:insert_tween({
						
						obj = obj,
						tween = tween
					
					})
				elseif(this:has_bottom_connection()) then
					offset = this:get_bottom_offset()

					if(Object.IsValid(line)) then
						obj = this:spawn_asset(data.asset, line.x, line.y)
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
		queue = this.options.YOOTIL.Utils.Queue:new()
		this.tweens = {}

		this:clear_items_container()
		this:hide_error_info()
	end

	Node_Events.on("node_destroyed", function()
		if(this.options.queue_task ~= nil) then
			this.options.queue_task:Cancel()
			this.options.queue_task = nil
		end
	end)

	return this
end

-- End Alternate Node

-- Limiter Node

local Node_Limiter = {}

function Node_Limiter:new(r, options)
	self.__index = self
	
	local this = setmetatable({

		options = options or {}

	}, self)

	setmetatable(this, {__index = Node})

	this:setup(r)

	this.options.queue_task = nil

	local queue = this.options.YOOTIL.Utils.Queue:new()
	local monitor_started = false
	local sending = 0
	local limit_count = this.body:FindDescendantByName("Limit Count")
	local orig_sending = 0
	local minus_button = this.body:FindDescendantByName("Minus")
	local plus_button = this.body:FindDescendantByName("Plus")

	minus_button.clickedEvent:Connect(function()
		if(sending > 0) then
			sending = sending - 1
		end

		limit_count.text = tostring(sending)
		orig_sending = sending
	end)

	plus_button.clickedEvent:Connect(function()
		if(sending < 9999) then
			sending = sending + 1
		end

		limit_count.text = tostring(sending)
		orig_sending = sending
	end)

	Node_Events.on("edit", function(can_edit)
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

			if(this:has_top_connection() or this:has_bottom_connection()) then
				local obj = nil
				local line = this:get_connector_line(sending > 0)
				local tween = this:create_tween(line)
				local connection_method = nil
				local offset = 0
		
				if(this:has_top_connection() and sending > 0) then
					obj = this:spawn_asset(data.asset, line.x, line.y)
					connection_method = "send_data_top"
		
					this:insert_tween({
						
						obj = obj,
						tween = tween
					
					})

					sending = sending - 1
					limit_count.text = tostring(sending)
				elseif(this:has_bottom_connection()) then
					offset = this:get_bottom_offset()

					if(Object.IsValid(line)) then
						obj = this:spawn_asset(data.asset, line.x, line.y)
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
		queue = this.options.YOOTIL.Utils.Queue:new()
		this.tweens = {}
		sending = orig_sending
		limit_count.text = tostring(sending)

		this:clear_items_container()
		this:hide_error_info()
	end

	Node_Events.on("node_destroyed", function()
		if(this.options.queue_task ~= nil) then
			this.options.queue_task:Cancel()
			this.options.queue_task = nil
		end
	end)

	return this
end

-- End Limiter Node

return Node, Node_Events, {

	If = Node_If,
	Data = Node_Data,
	Alternate = Node_Alternate,
	Limiter = Node_Limiter

}