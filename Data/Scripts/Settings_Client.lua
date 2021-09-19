local API, YOOTIL = require(script:GetCustomProperty("API"))

local save_button = script:GetCustomProperty("save_button"):WaitForObject()
local close_button = script:GetCustomProperty("close_button"):WaitForObject()

local sfx_amount = nil
local music_amount = nil
local language_index = 1

close_button.hoveredEvent:Connect(API.play_hover_sound)

close_button.clickedEvent:Connect(function()
	Events.Broadcast("slider_release_handle")
	Events.Broadcast("close_settings")
	
	API.play_click_sound()
end)

save_button.hoveredEvent:Connect(API.play_hover_sound)

save_button.clickedEvent:Connect(function()
	Events.Broadcast("set_sfx_volume", sfx_amount)
	Events.Broadcast("set_music_volume", music_amount)

	YOOTIL.Events.broadcast_to_server("update_misc_settings", sfx_amount, music_amount, language_index)
	
	Events.Broadcast("slider_release_handle")

	API.play_click_sound()

	save_button.isInteractable = false

	Task.Spawn(function()
		save_button.isInteractable = true
	end, 1)
end)

Events.Connect("on_sfx_slider_update", function(slider, amount, percent)
	sfx_amount = tonumber(string.format("%.0f", percent))
	Events.Broadcast("set_sfx_slider_amount", sfx_amount)
end)

Events.Connect("on_music_slider_update", function(slider, amount, percent)
	music_amount = tonumber(string.format("%.0f", percent))
	Events.Broadcast("set_music_slider_amount", music_amount)
end)

Events.Connect("on_game_language_selected", function(index)
	language_index = index

	Events.Broadcast("set_language", index)
	Events.Broadcast("on_set_game_language_selected", index)
end)

Events.Connect("set_sfx_volume", function(v)
	sfx_amount = v
end)

Events.Connect("set_music_volume", function(v)
	music_amount = v
end)

Events.Connect("set_language_index", function(index)
	language_index = index
end)