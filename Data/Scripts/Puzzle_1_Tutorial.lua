local next_button = script:GetCustomProperty("next_button"):WaitForObject()
local steps = script:GetCustomProperty("steps"):WaitForObject()
local header_highlight = script:GetCustomProperty("header_highlight"):WaitForObject()
local nodes_available_highlight = script:GetCustomProperty("nodes_available_highlight"):WaitForObject()

local children = steps:GetChildren()
local current_step = 1

Events.Broadcast("disable_available_nodes")

next_button.clickedEvent:Connect(function()
	children[current_step].visibility = Visibility.FORCE_OFF

	local got_header_highlight = false

	if(current_step == 5) then
		header_highlight.visibility = Visibility.FORCE_OFF
		nodes_available_highlight.visibility = Visibility.FORCE_ON
	elseif(current_step > 5) then
		header_highlight.visibility = Visibility.FORCE_OFF
		nodes_available_highlight.visibility = Visibility.FORCE_OFF
	elseif(current_step < 5) then
		header_highlight.visibility = Visibility.FORCE_ON
		got_header_highlight = true
	end

	if(current_step == 8) then
		Events.Broadcast("enable_available_nodes")
		Events.Broadcast("enable_header_ui")
		Events.BroadcastToServer("save_puzzle_tutorial_seen")

		script.parent.parent:Destroy()
	else
		current_step = current_step + 1

		children[current_step].visibility = Visibility.FORCE_ON

		if(got_header_highlight) then
			set_highlight(children[current_step])
		end
	end
end)

function set_highlight(c)
	if(c:GetCustomProperty("highlight_x") ~= 0) then
		header_highlight.x = c:GetCustomProperty("highlight_x")
		header_highlight.y = c:GetCustomProperty("highlight_y")
		header_highlight.width = c:GetCustomProperty("highlight_width")
		header_highlight.height = c:GetCustomProperty("highlight_height")
	end
end