local slow_down_button = script:GetCustomProperty("slow_down_button"):WaitForObject()
local speed_up_button = script:GetCustomProperty("speed_up_button"):WaitForObject()
local current_speed = script:GetCustomProperty("current_speed"):WaitForObject()
local run_edit_button = script:GetCustomProperty("run_edit_button"):WaitForObject()

local running = false
local speed = 1

run_edit_button.clickedEvent:Connect(function()
	if(running) then
		run_edit_button.text = "Run Solution"
		running = false

		Events.Broadcast("puzzle_edit")
	else
		run_edit_button.text = "Edit Solution"
		running = true

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