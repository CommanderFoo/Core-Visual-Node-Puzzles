local API, YOOTIL = require(script:GetCustomProperty("API"))

local error_log_panel = script:GetCustomProperty("error_log_panel"):WaitForObject()
local button = script:GetCustomProperty("button"):WaitForObject()
local scroll_panel = script:GetCustomProperty("scroll_panel"):WaitForObject()
local clear_button = script:GetCustomProperty("clear_button"):WaitForObject()
local info_entry = script:GetCustomProperty("info_entry")
local error_entry = script:GetCustomProperty("error_entry")
local auto_scroll = script:GetCustomProperty("auto_scroll"):WaitForObject()
local resize_handle = script:GetCustomProperty("resize_handle"):WaitForObject()

local is_showing = false
local y_offset = 0
local active_node = nil
local program_running = false
local can_auto_scroll = true

local function clear_message_log()
	if(active_node ~= nil) then
		active_node:clear_error_log_highlight()
	end

	for i, c in pairs(scroll_panel:GetChildren()) do
		c:Destroy()
	end

	y_offset = 0
	active_node = nil
	scroll_panel.scrollPosition = 0
end

button.clickedEvent:Connect(function()
	if(is_showing) then
		button.text = "Show Error Log"
		error_log_panel.visibility = Visibility.FORCE_OFF
		is_showing = false
	else
		button.text = "Hide Error Log"
		error_log_panel.visibility = Visibility.FORCE_ON
		is_showing = true
	end

	API.play_click_sound()
end)

button.hoveredEvent:Connect(function()
	API.play_hover_sound()
end)

-- Clear button

auto_scroll.clickedEvent:Connect(function()
	if(can_auto_scroll) then
		can_auto_scroll = false
		auto_scroll.text = "Enable Auto Scroll"
	else
		can_auto_scroll = true
		auto_scroll.text = "Disable Auto Scroll"
	end

	API.play_click_sound()
end)

auto_scroll.hoveredEvent:Connect(function()
	API.play_hover_sound()
end)

-- Auto scroll

clear_button.clickedEvent:Connect(function()
	clear_message_log()
	API.play_click_sound()
end)

clear_button.hoveredEvent:Connect(function()
	API.play_hover_sound()
end)

Events.Connect("show_error_log", function()
	button.text = "Hide Error Log"
	error_log_panel.visibility = Visibility.FORCE_OFF
	is_showing = true
end)

local function add_log_message(msg, node, is_error)
	local asset = info_entry

	if(is_error) then
		asset = error_entry
	end

	local entry = World.SpawnAsset(asset, { parent = scroll_panel })

	entry.y = y_offset
	y_offset = y_offset + 50

	entry:FindDescendantByName("Time").text = os.date("%H:%M:%S")
	entry:FindDescendantByName("Text").text = msg

	if(not is_error) then
		entry:FindDescendantByName("Button").isInteractable = false
		entry.name = node
	else
		entry:FindDescendantByName("ID").text = "ID#" .. tostring(node:get_unique_id())
		entry.name = node:get_root().id
		entry:FindDescendantByName("Button").clickedEvent:Connect(function(b)
			if(active_node ~= nil) then
				active_node:clear_error_log_highlight(program_running)
			end

			if(active_node == node) then
				active_node = nil
			else
				active_node = node
				node:set_error_log_highlight()
			end
		end)
	end

	if(can_auto_scroll) then
		Task.Spawn(function()
			scroll_panel.scrollPosition = scroll_panel.contentLength + 50
		end)
	end
end

-- Resize

local is_dragging = false

resize_handle.pressedEvent:Connect(function()
	is_dragging = true
end)

resize_handle.releasedEvent:Connect(function()
	is_dragging = false
end)

resize_handle.clickedEvent:Connect(API.play_click_sound)
--resize_handle.hoveredEvent:Connect(API.play_hover_sound)

function Tick()
	if(is_dragging) then
		local mouse_pos = UI.GetCursorPosition()
		local screen = UI.GetScreenSize()

		error_log_panel.parent.height = math.max(100, math.min(800, math.floor(screen.y - mouse_pos.y))) + 7
	end
end

Events.Connect("clear_message_log", clear_message_log)
Events.Connect("add_log_message", add_log_message)
Events.Connect("highlight_reset", function()
	active_node = nil
end)

Events.Connect("program_running", function(is_running)
	program_running = is_running

	if(not is_running) then
		active_node = nil
	else
		API.Node_Events.trigger("clear_highlight")
	end
end)

Events.Connect("node_deleted", function(id)
	for i, c in ipairs(scroll_panel:GetChildren()) do
		if(c.name == id) then
			c.opacity = .3
			c:FindDescendantByName("Button").isInteractable = false
		end
	end
end)

Events.Connect("graph_cleared", function()
	for i, c in ipairs(scroll_panel:GetChildren()) do
		if(c.name ~= "Info Log Entry" and c.name ~= "Info" and c.name ~= "Puzzle Info") then
			c:FindDescendantByName("Button").isInteractable = false
			c.opacity = .3
		end
	end

	add_log_message("Node graph cleared.", "Info", false)
end)