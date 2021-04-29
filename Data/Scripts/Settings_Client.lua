local API, YOOTIL = require(script:GetCustomProperty("API"))

local save_button = script:GetCustomProperty("save_button"):WaitForObject()
local close_button = script:GetCustomProperty("close_button"):WaitForObject()
local sfx_folder = script:GetCustomProperty("sfx_folder"):WaitForObject()
local music_folder = script:GetCustomProperty("music_folder"):WaitForObject()

local sfx_amount = nil
local music_amount = nil
local notify_toggle = 1

local local_player = Game.GetLocalPlayer()

close_button.hoveredEvent:Connect(API.play_hover_sound)

close_button.clickedEvent:Connect(function()
	Events.Broadcast("slider_release_handle")
	Events.Broadcast("close_settings")
	
	API.play_click_sound()
end)

save_button.hoveredEvent:Connect(API.play_hover_sound)

save_button.clickedEvent:Connect(function()
	update_sfx_volume()
	update_music_volume()

	YOOTIL.Events.broadcast_to_server("update_settings", sfx_amount, music_amount, notify_toggle)
	Events.Broadcast("slider_release_handle")

	API.play_click_sound()

	save_button.isInteractable = false

	Task.Spawn(function()
		save_button.isInteractable = true
	end, 1)
end)

function update_sfx_volume(v)
	local fx_sounds = sfx_folder:GetChildren()

	sfx_amount = sfx_amount or local_player:GetResource("sfx_volume")

	for _, s in ipairs(fx_sounds) do
		s.volume = (v or sfx_amount) / 100
	end
end

function update_music_volume(v)
	local music = music_folder:GetChildren()

	music_amount = music_amount or local_player:GetResource("music_volume")

	for _, s in ipairs(music) do
		s.volume = (v or music_amount) / 100 / 10
	end
end

Events.Connect("on_sfx_slider_update", function(slider, amount, percent)
	sfx_amount = tonumber(string.format("%.0f", percent))
end)

Events.Connect("on_music_slider_update", function(slider, amount, percent)
	music_amount = tonumber(string.format("%.0f", percent))
end)

Events.Connect("on_show_notifications_toggled", function(t)
	notify_toggle = t
end)

Events.Connect("on_update_sfx_volume", update_sfx_volume)
Events.Connect("on_update_music_volume", update_music_volume)