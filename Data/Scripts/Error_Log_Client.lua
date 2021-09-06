local API, YOOTIL = require(script:GetCustomProperty("API"))

local error_log_panel = script:GetCustomProperty("error_log_panel"):WaitForObject()
local button = script:GetCustomProperty("button"):WaitForObject()
local scroll_panel = script:GetCustomProperty("scroll_panel"):WaitForObject()

local is_showing = false

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

Events.Connect("show_error_log", function()
	button.text = "Hide Error Log"
	error_log_panel.visibility = Visibility.FORCE_OFF
	is_showing = true
end)

local function clear_error_log()
	for i, c in pairs(scroll_panel:GetChildren()) do
		c:Destroy()
	end
end

local function add_error_log(error, node)
	
end

Events.Connect("clear_error_log", clear_error_log)
Events.Connect("add_error_log", add_error_log)