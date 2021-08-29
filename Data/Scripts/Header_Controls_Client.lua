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

local save_button = script:GetCustomProperty("save_button"):WaitForObject()
local main_menu_button = script:GetCustomProperty("main_menu_button"):WaitForObject()
local clear_button = script:GetCustomProperty("clear_button"):WaitForObject()
local center_graph_button = script:GetCustomProperty("center_graph_button"):WaitForObject()

local help_button = script:GetCustomProperty("help_button"):WaitForObject()
local help = script:GetCustomProperty("help"):WaitForObject()
local close_help_button = script:GetCustomProperty("close_help_button"):WaitForObject()

local settings_open = false
local help_open = false

local gold_color = gold_award:GetColor()
local silver_color = silver_award:GetColor()
local bronze_color = bronze_award:GetColor()

local running = false
local speed = 1

local showing_nodes = false
local orig_showing_nodes = false
local tween = nil
local errors = 0

local total_puzzle_score = 0
local score_conditions = nil

local ui_is_disabled = false

local floor = math.floor

function Tick(dt)
	if(tween ~= nil) then
		tween:tween(dt)
	end

	if(running and score_conditions) then
		local score = math.max(0, 20000 - math.floor(((total_puzzle_score / 4) + ((API.get_total_nodes(true) - 2) * 25))))

		if(score >= score_conditions.gold) then
			API.set_award(gold_award, 1)
			API.set_award(silver_award, .2)
			API.set_award(bronze_award, .2)
		elseif(score >= score_conditions.silver) then
			API.set_award(gold_award, .2)
			API.set_award(silver_award, 1)
			API.set_award(bronze_award, .2)
		elseif(score >= score_conditions.bronze) then
			API.set_award(gold_award, .2)
			API.set_award(silver_award, .2)
			API.set_award(bronze_award, 1)
		else
			API.set_award(gold_award, .2)
			API.set_award(silver_award, .2)
			API.set_award(bronze_award, .2)
		end
	end
end

-- Center graph

center_graph_button.hoveredEvent:Connect(API.play_hover_sound)

center_graph_button.clickedEvent:Connect(function()
	Events.Broadcast("reset_graph", true)
end)

-- Clear

clear_button.hoveredEvent:Connect(API.play_hover_sound)

clear_button.clickedEvent:Connect(function()
	API.clear_graph()
	Events.Broadcast("reset_graph")
end)

-- Main Menu

main_menu_button.hoveredEvent:Connect(API.play_hover_sound)

main_menu_button.clickedEvent:Connect(function()
	disable_ui(true)
	API.disable_nodes()

	Events.Broadcast("disable_graph_mover")
	Events.Broadcast("on_disable_all_dropdowns")
	Events.Broadcast("stop_auto_save")

	Events.Broadcast("transition_in", function()
		Events.Broadcast("reset_graph")
		Events.Broadcast("clear_puzzle")
		Events.Broadcast("show_main_menu")
	end)
end)

-- Nodes

available_nodes_button.hoveredEvent:Connect(API.play_hover_sound)

function show_hide_nodes()
	if(tween ~= nil) then
		tween:stop()
		tween = nil		
	end

	if(showing_nodes) then	
		tween = YOOTIL.Tween:new(.7, {v = available_nodes_container.x}, {v = 400})
		available_nodes_button.text = "Show Nodes"
		
		showing_nodes = false
	else
		tween = YOOTIL.Tween:new(.7, {v = available_nodes_container.x}, {v = -20})
		available_nodes_button.text = "Hide Nodes"
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

	YOOTIL.Events.broadcast_to_server("update_player_prefs", speed, showing_nodes)

	API.play_click_sound()
end

available_nodes_button.clickedEvent:Connect(show_hide_nodes)

-- Run Edit

run_edit_button.hoveredEvent:Connect(API.play_hover_sound)

run_edit_button.clickedEvent:Connect(function()
	if(running) then
		reset_award()	
		enable_ui()

		Events.Broadcast("puzzle_edit")

		if(orig_showing_nodes) then
			show_hide_nodes()
		end

		Events.Broadcast("start_auto_save")
		Events.Broadcast("unpause") -- Make sure we aren't paused for some reason.

		Events.Broadcast("enable_graph_mover")
	else
		run_edit_button.text = "Edit Program"
		running = true

		disable_ui(false)

		orig_showing_nodes = showing_nodes

		if(showing_nodes) then
			show_hide_nodes()
		end

		Events.Broadcast("puzzle_run", speed)
		Events.Broadcast("stop_auto_save")
	end

	API.play_click_sound()
end)

-- Speed

speed_up_button.hoveredEvent:Connect(API.play_hover_sound)

speed_up_button.clickedEvent:Connect(function()
	if(speed < 20) then
		speed = speed + 1
	end

	current_speed.text = tostring(speed)

	YOOTIL.Events.broadcast_to_server("update_player_prefs", speed, showing_nodes)

	API.play_click_sound()
end)

slow_down_button.hoveredEvent:Connect(API.play_hover_sound)

slow_down_button.clickedEvent:Connect(function()
	if(speed > 1) then
		speed = speed - 1
	end

	current_speed.text = tostring(speed)

	YOOTIL.Events.broadcast_to_server("update_player_prefs", speed, showing_nodes)
	
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
	save_button.isInteractable = false
	main_menu_button.isInteractable = false
	clear_button.isInteractable = false
	center_graph_button.isInteractable = false
	help_button.isInteractable = false

	if(disable_run_edit) then
		run_edit_button.isInteractable = false
	end

	if(not ignore_settings) then
		settings_button.isInteractable = false
	end

	Events.Broadcast("disable_available_nodes")
	Events.Broadcast("disable_graph_mover")

	ui_is_disabled = true
end

function enable_ui()
	slow_down_button.isInteractable = true
	speed_up_button.isInteractable = true
	available_nodes_button.isInteractable = true
	run_edit_button.isInteractable = true
	settings_button.isInteractable = true
	save_button.isInteractable = true
	main_menu_button.isInteractable = true
	clear_button.isInteractable = true
	center_graph_button.isInteractable = true
	help_button.isInteractable = true

	Events.Broadcast("enable_available_nodes")

	ui_is_disabled = false
end

-- Settings

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
	Events.Broadcast("enable_graph_mover")	
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

-- Help

help_button.hoveredEvent:Connect(API.play_hover_sound)
help_button.unhoveredEvent:Connect(API.play_hover_sound)

function close_help()
	enable_ui()
	Events.Broadcast("enable_graph_mover")	
	help.visibility = Visibility.FORCE_OFF
	help_open = false

	API.enable_nodes()
	Events.Broadcast("on_enable_all_dropdowns")
	API.play_click_sound()
end

help_button.clickedEvent:Connect(function()
	if(help_open) then
		close_help()
	else
		disable_ui(true, true)

		help.visibility = Visibility.FORCE_ON
		help_open = true
		
		API.disable_nodes()
		Events.Broadcast("on_disable_all_dropdowns")
	end

	API.play_click_sound()
end)

close_help_button.hoveredEvent:Connect(API.play_hover_sound)
close_help_button.clickedEvent:Connect(close_help)

-- Save

save_button.hoveredEvent:Connect(API.play_hover_sound)

save_button.clickedEvent:Connect(function()
	save_button.isInteractable = false
	save_button.text = "Saving..."
	Events.Broadcast("save")

	API.play_click_sound()
end)

Events.Connect("saving", function()
	save_button.isInteractable = false
	save_button.text = "Saving..."
end)

Events.Connect("saved", function()
	Task.Wait(2)
	if(not ui_is_disabled) then
		save_button.isInteractable = true
	end

	save_button.text = "Save"
end)

Events.Connect("disable_header_ui", disable_ui)
Events.Connect("enable_header_ui", enable_ui)

Events.Connect("puzzle_edit", function()
	run_edit_button.text = "Run Program"
	running = false

	if(score_conditions ~= nil) then
		total_score_allowed = score_conditions.gold + score_conditions.silver + score_conditions.bronze
	else
		total_score_allowed = 0
	end

	errors = 0
	total_puzzle_score = 0

	enable_ui()
	reset_award()
end)

Events.Connect("puzzle_complete", function()
	running = false
end)

Events.Connect("score", function(t)
	total_puzzle_score = total_puzzle_score + (t * 100)
end)

Events.Connect("score_conditions", function(c)
	total_score_allowed = c.gold + c.silver
	score_conditions = c
end)

Events.Connect("show_nodes", function()
	tween = YOOTIL.Tween:new(.7, {v = available_nodes_container.x}, {v = -30})
	available_nodes_button.text = "Hide Nodes"
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