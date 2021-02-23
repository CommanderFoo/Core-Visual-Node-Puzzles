local API, YOOTIL = require(script:GetCustomProperty("API"))

local slow_down_button = script:GetCustomProperty("slow_down_button"):WaitForObject()
local speed_up_button = script:GetCustomProperty("speed_up_button"):WaitForObject()
local current_speed = script:GetCustomProperty("current_speed"):WaitForObject()
local run_edit_button = script:GetCustomProperty("run_edit_button"):WaitForObject()

local available_nodes_button = script:GetCustomProperty("available_nodes_button"):WaitForObject()
local available_nodes_container = script:GetCustomProperty("available_nodes_container"):WaitForObject()

local gold_award = script:GetCustomProperty("gold_award"):WaitForObject()
local silver_award = script:GetCustomProperty("silver_award"):WaitForObject()
local bronze_award = script:GetCustomProperty("bronze_award"):WaitForObject()

local settings_button = script:GetCustomProperty("settings_button"):WaitForObject()
local settings = script:GetCustomProperty("settings"):WaitForObject()

local settings_open = false

local gold_color = gold_award:GetColor()
local silver_color = silver_award:GetColor()
local bronze_color = bronze_award:GetColor()

local running = false
local speed = 1

local showing_nodes = false
local tween = nil
local errors = 0

local total_puzzle_time = 0
local time_conditions = nil

local floor = math.floor

function Tick(dt)
	if(tween ~= nil) then
		tween:tween(dt)
	end

	if(running and time_conditions) then
		--if(floor(total_puzzle_time) > time_conditions.bronze) then
		--	print("too long")
		--else
			if(floor(total_puzzle_time) <= time_conditions.gold) then
				API.set_award(gold_award, 1)
				API.set_award(silver_award, .2)
				API.set_award(bronze_award, .2)
			elseif(floor(total_puzzle_time) <= time_conditions.silver) then
				API.set_award(gold_award, .2)
				API.set_award(silver_award, 1)
				API.set_award(bronze_award, .2)
			else
				API.set_award(gold_award, .2)
				API.set_award(silver_award, .2)
				API.set_award(bronze_award, 1)
			end
		--end
	end
end

available_nodes_button.hoveredEvent:Connect(API.play_hover_sound)

available_nodes_button.clickedEvent:Connect(function()
	if(tween ~= nil) then
		tween:stop()
		tween = nil		
	end

	if(showing_nodes) then	
		tween = YOOTIL.Tween:new(.7, {v = available_nodes_container.x}, {v = 400})
		available_nodes_button.text = "Show Available Nodes"
		showing_nodes = false
	else
		tween = YOOTIL.Tween:new(.7, {v = available_nodes_container.x}, {v = -30})
		available_nodes_button.text = "Hide Available Nodes"
		showing_nodes = true
	end

	tween:on_start(function()
		available_nodes_container.visibility = Visibility.FORCE_ON
	end)

	tween:on_complete(function()
		tween = nil
	end)

	tween:set_easing("inOutBack")

	tween:on_change(function(changed)
		available_nodes_container.x = changed.v
	end)

	Events.BroadcastToServer("update_player_prefs", speed, showing_nodes)
	API.play_click_sound()
end)

run_edit_button.hoveredEvent:Connect(API.play_hover_sound)

run_edit_button.clickedEvent:Connect(function()
	if(running) then
		reset_award()	
		enable_ui()

		Events.Broadcast("puzzle_edit")
	else
		run_edit_button.text = "Edit Program"
		running = true
		timer_run = true

		disable_ui(false)

		Events.Broadcast("puzzle_run", speed)
	end

	API.play_click_sound()
end)

speed_up_button.hoveredEvent:Connect(API.play_hover_sound)

speed_up_button.clickedEvent:Connect(function()
	if(speed < 10) then
		speed = speed + 1
	end

	current_speed.text = tostring(speed)

	Events.BroadcastToServer("update_player_prefs", speed, showing_nodes)
	API.play_click_sound()
end)

slow_down_button.hoveredEvent:Connect(API.play_hover_sound)

slow_down_button.clickedEvent:Connect(function()
	if(speed > 1) then
		speed = speed - 1
	end

	current_speed.text = tostring(speed)

	Events.BroadcastToServer("update_player_prefs", speed, showing_nodes)
	API.play_click_sound()
end)

function reset_award()
	API.set_award(gold_award, 1)
	API.set_award(silver_award, .2)
	API.set_award(bronze_award, .2)
end

function disable_ui(disable_run_edit, ignore_settings)
	slow_down_button.isInteractable = false
	speed_up_button.isInteractable = false
	available_nodes_button.isInteractable = false

	if(disable_run_edit) then
		run_edit_button.isInteractable = false
	end

	if(not ignore_settings) then
		settings_button.isInteractable = false
	end

	Events.Broadcast("disable_available_nodes")
end

function enable_ui()
	slow_down_button.isInteractable = true
	speed_up_button.isInteractable = true
	available_nodes_button.isInteractable = true
	run_edit_button.isInteractable = true
	settings_button.isInteractable = true

	Events.Broadcast("enable_available_nodes")
end

settings_button.hoveredEvent:Connect(function()
	settings_button:GetChildren()[1]:SetColor(settings_button:GetHoveredColor())
	API.play_hover_sound()
end)

settings_button.unhoveredEvent:Connect(function()
	settings_button:GetChildren()[1]:SetColor(settings_button:GetPressedColor())
	API.play_hover_sound()
end)

function close_settings()
	enable_ui()
		
	settings.visibility = Visibility.FORCE_OFF
	settings_open = false

	API.enable_nodes()
	Events.Broadcast("on_enable_all_dropdowns")
	Events.Broadcast("slider_release_handle")
end

settings_button.clickedEvent:Connect(function()
	if(settings_open) then
		close_settings()
	else
		disable_ui(true, true)

		settings.visibility = Visibility.FORCE_ON
		settings_open = true
		
		API.disable_nodes()
		Events.Broadcast("on_disable_all_dropdowns")
	end

	API.play_click_sound()
end)

Events.Connect("disable_header_ui", disable_ui)
Events.Connect("enable_header_ui", enable_ui)

Events.Connect("puzzle_edit", function()
	run_edit_button.text = "Run Program"
	running = false

	if(time_conditions ~= nil) then
		total_time_allowed = time_conditions.gold + time_conditions.silver + time_conditions.bronze
	else
		total_time_allowed = 0
	end

	errors = 0
	total_puzzle_time = 0

	enable_ui()
	reset_award()
end)

Events.Connect("puzzle_complete", function()
	running = false
end)

Events.Connect("timer", function(t)
	total_puzzle_time = total_puzzle_time + t
end)

Events.Connect("time_conditions", function(c)
	total_time_allowed = c.gold + c.silver
	time_conditions = c
end)

Events.Connect("show_nodes", function()
	tween = YOOTIL.Tween:new(.7, {v = available_nodes_container.x}, {v = -30})
	available_nodes_button.text = "Hide Available Nodes"
	showing_nodes = true

	tween:on_start(function()
		available_nodes_container.visibility = Visibility.FORCE_ON
	end)

	tween:on_complete(function()
		tween = nil
	end)

	tween:set_easing("inOutBack")

	tween:on_change(function(changed)
		available_nodes_container.x = changed.v
	end)
end)

Events.Connect("set_speed", function(s)
	speed = s
	current_speed.text = tostring(speed)
end)

Events.Connect("close_settings", close_settings)