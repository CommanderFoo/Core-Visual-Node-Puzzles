local data = script:GetCustomProperty("data"):WaitForObject()

data.networkedPropertyChangedEvent:Connect(function(obj, prop)
	if(prop == "puzzle_id") then
		Events.Broadcast("puzzle_load", data:GetCustomProperty(prop))
	end
end)

Game.playerJoinedEvent:Connect(function()
	UI.SetCursorVisible(true)
	UI.SetCanCursorInteractWithUI(true)
end)

