local base_ui = script:GetCustomProperty("base_ui"):WaitForObject()
local node_ui = script:GetCustomProperty("node_ui"):WaitForObject()
local top_ui = script:GetCustomProperty("top_ui"):WaitForObject()

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

	base_ui.visibility = Visibility.FORCE_ON
	node_ui.visibility = Visibility.FORCE_ON
	top_ui.visibility = Visibility.FORCE_ON

	Events.Broadcast("stop_menu_music")
	
	Events.Broadcast("load_puzzle", id)
	Events.Broadcast("transition_out")
end)