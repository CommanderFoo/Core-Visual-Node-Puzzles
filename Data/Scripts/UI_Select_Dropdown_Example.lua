local fruit_text = script:GetCustomProperty("fruit_text"):WaitForObject()
local apple_text = script:GetCustomProperty("apple_text"):WaitForObject()

Events.Connect("on_fruit_option_selected", function(index, option, value)
	fruit_text.text = "You picked " .. option.text .. "!"

	if(option.text == "Apple") then
		Events.Broadcast("on_apple_type_select_enable")
	else
		Events.Broadcast("on_apple_type_select_disable", true)
		apple_text.text = ""
	end
end)

Events.Connect("on_apple_type_option_selected", function(index, option, value)
	apple_text.text = "You picked " .. option.text .. "!"
end)

local local_player = Game.GetLocalPlayer()

Game.playerJoinedEvent:Connect(function()
	UI.SetCursorVisible(true)
	UI.SetCanCursorInteractWithUI(true)
end)