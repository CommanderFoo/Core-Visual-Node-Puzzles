local YOOTIL = require(script:GetCustomProperty("YOOTIL"))

Events.Connect("apply_settings", function(speed, sfx_vol, music_vol, show_nodes)
	Events.Broadcast("set_speed", speed)
	
	Events.Broadcast("set_sfx_slider_amount", sfx_vol)
	Events.Broadcast("set_sfx_volume", sfx_vol)

	Events.Broadcast("set_music_slider_amount", music_vol)
	Events.Broadcast("set_music_volume", music_vol)
	
	if(show_nodes == 1) then
		Events.Broadcast("show_nodes")
	end
end)