local main_menu = script:GetCustomProperty("main_menu"):WaitForObject()
local sfx = script:GetCustomProperty("sfx"):WaitForObject()

Events.Connect("set_sfx_volume", function(v)
	local fx_sounds = sfx:GetChildren()

	for _, s in ipairs(fx_sounds) do
		s.volume = v / 100
	end
end)

Events.Connect("stop_menu_music", function()
	main_menu:Stop()
end)

Events.Connect("play_menu_music", function()
	main_menu:Play()
end)

Events.Connect("set_music_volume", function(v)
	main_menu.volume = v / 100
end)