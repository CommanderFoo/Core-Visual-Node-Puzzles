local Localization = require(script:GetCustomProperty("Localization"))

local function set_language(index)
	Localization.set_language_from_index(index)
	Events.Broadcast("translate")
end

Events.Connect("apply_settings", function(speed, sfx_vol, music_vol, show_nodes, language_index)
	Events.Broadcast("set_speed", speed)
	
	Events.Broadcast("set_sfx_slider_amount", sfx_vol)
	Events.Broadcast("set_sfx_volume", sfx_vol)

	Events.Broadcast("set_music_slider_amount", music_vol)
	Events.Broadcast("set_music_volume", music_vol)
	
	Events.Broadcast("on_set_game_language_selected", language_index)

	if(show_nodes == 1) then
		Events.Broadcast("show_nodes")
	end

	set_language(language_index)
end)

Events.Connect("set_language", set_language)