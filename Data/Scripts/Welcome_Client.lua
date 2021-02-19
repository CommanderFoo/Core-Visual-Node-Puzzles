local welcome = script:GetCustomProperty("welcome"):WaitForObject()
local ready = script:GetCustomProperty("ready"):WaitForObject()

Events.Connect("show_welcome", function()
	welcome.visibility = Visibility.FORCE_ON
end)

ready.clickedEvent:Connect(function()
	welcome.visibility = Visibility.FORCE_OFF
	
	Events.Broadcast("enable_header_ui")
	Events.BroadcastToServer("load_puzzle", 1)
end)