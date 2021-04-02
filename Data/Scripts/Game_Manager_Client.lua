local local_player = Game.GetLocalPlayer()

Task.Spawn(function()
	Events.BroadcastToServer("init")
end)

Events.Connect("load_game", function(id, speed, sfx_vol, music_vol, show_nodes)
	Events.Broadcast("set_speed", speed)
	Events.Broadcast("set_sfx_slider_amount", sfx_vol)
	Events.Broadcast("set_music_slider_amount", music_vol)

	if(show_nodes == 1) then
		Events.Broadcast("show_nodes")
	end

	Events.Broadcast("load_puzzle", id)
	Events.Broadcast("transition_out")
end)