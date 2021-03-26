local local_player = Game.GetLocalPlayer()

Task.Spawn(function()
	Events.BroadcastToServer("init")
end)

Events.Connect("load_game", function()
	Events.Broadcast("set_speed", local_player:GetResource("speed"))
	Events.Broadcast("set_sfx_slider_amount", local_player:GetResource("sfx_volume"))
	Events.Broadcast("set_music_slider_amount", local_player:GetResource("music_volume"))

	if(local_player:GetResource("show_notifications") == 1) then
		Events.Broadcast("show_notifications_toggle_on")
	else
		Events.Broadcast("show_notifications_toggle_off")
	end

	if(local_player:GetResource("show_nodes") == 1) then
		Events.Broadcast("show_nodes")
	end
	
	Events.Broadcast("load_puzzle", local_player:GetResource("current_puzzle"))
	Events.Broadcast("transition_out")
end)