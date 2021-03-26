local YOOTIL = require(script:GetCustomProperty("YOOTIL"))

local menu_container = script:GetCustomProperty("menu_container"):WaitForObject()
local play_button = script:GetCustomProperty("play_button"):WaitForObject()

play_button.clickedEvent:Connect(function()
	Events.Broadcast("transition_in", function()
		menu_container.visibility = Visibility.FORCE_OFF
		Events.BroadcastToServer("load_game")
	end)

end)

Events.Connect("show_main_menu", function()
	menu_container.visibility = Visibility.FORCE_ON
	Events.Broadcast("transition_out")
end)