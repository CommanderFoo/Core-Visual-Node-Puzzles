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

local gold_color = gold_award:GetColor()
local silver_color = silver_award:GetColor()
local bronze_color = bronze_award:GetColor()

local timer = script:GetCustomProperty("timer"):WaitForObject()

local running = false
local speed = 1

local showing_nodes = true
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
		if(floor(total_puzzle_time) > time_conditions.silver) then
			gold_color.a = 0.3
			gold_award:SetColor(gold_color)

			silver_color.a = .3
			silver_award:SetColor(silver_color)

			bronze_color.a = 1
			bronze_award:SetColor(bronze_color)
		elseif(floor(total_puzzle_time) > time_conditions.gold) then
			gold_color.a = 0.3
			gold_award:SetColor(gold_color)

			silver_color.a = 1
			silver_award:SetColor(silver_color)

			bronze_color.a = .3
		else
			reset_award()
		end
	end
end

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
end)

run_edit_button.clickedEvent:Connect(function()
	if(running) then
		reset_award()	
		enable_ui()

		Events.Broadcast("puzzle_edit")
	else
		run_edit_button.text = "Edit Solution"
		running = true
		timer_run = true

		disable_ui(false)

		Events.Broadcast("puzzle_run", speed)
	end
end)

speed_up_button.clickedEvent:Connect(function()
	if(speed < 5) then
		speed = speed + 1
	end

	current_speed.text = tostring(speed)
end)

slow_down_button.clickedEvent:Connect(function()
	if(speed > 1) then
		speed = speed - 1
	end

	current_speed.text = tostring(speed)
end)

API.Puzzle_Events.on("node_total_change", function()
	local total_nodes = API.get_total_nodes()

	if(total_nodes > 141) then
		gold_color.a = 0.3
		gold_award:SetColor(gold_color)

		if(total_nodes > 6) then
			silver_color.a = .3
			silver_award:SetColor(silver_color)

			bronze_color.a = 1
			bronze_award:SetColor(bronze_color)
		else
			silver_color.a = 1
			silver_award:SetColor(silver_color)
		end
	end
end)

function reset_award()
	gold_color.a = 1
	gold_award:SetColor(gold_color)

	silver_color.a = .3
	silver_award:SetColor(silver_color)

	bronze_color.a = .3
	bronze_award:SetColor(bronze_color)
end

function disable_ui(disable_run_edit)
	slow_down_button.isInteractable = false
	speed_up_button.isInteractable = false
	available_nodes_button.isInteractable = false

	if(disable_run_edit) then
		run_edit_button.isInteractable = false
	end
end

function enable_ui()
	slow_down_button.isInteractable = true
	speed_up_button.isInteractable = true
	available_nodes_button.isInteractable = true
	run_edit_button.isInteractable = true
end

Events.Connect("disable_header_ui", disable_ui)
Events.Connect("enable_header_ui", enable_ui)

Events.Connect("puzzle_edit", function()
	run_edit_button.text = "Run Solution"
	running = false
	total_time_allowed = time_conditions.gold + time_conditions.silver + time_conditions.bronze
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
	total_time_allowed = c.gold + c.silver + c.bronze
	time_conditions = c
end)