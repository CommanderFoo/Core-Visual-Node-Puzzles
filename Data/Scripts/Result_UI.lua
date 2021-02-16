local title = script:GetCustomProperty("title"):WaitForObject()
local edit_button = script:GetCustomProperty("edit_button"):WaitForObject()
local next_button = script:GetCustomProperty("next_button"):WaitForObject()

Events.Connect("show_result", function()
	script.parent.parent.visibility = Visibility.FORCE_ON
end)

Events.Connect("hide_result", function()
	script.parent.parent.visibility = Visibility.FORCE_OFF
end)

edit_button.clickedEvent:Connect(function()
	Events.Broadcast("puzzle_edit")
	script.parent.parent.visibility = Visibility.FORCE_OFF
end)