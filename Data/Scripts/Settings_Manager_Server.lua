local YOOTIL = require(script:GetCustomProperty("YOOTIL"))

Events.Connect("send_settings", function(player)
	local player_data = Storage.GetPlayerData(player)

	if(player_data.cs == nil or player_data.cs < 1) then
		player_data.cs = 1 -- Current Speed
	end

	player_data.sv = player_data.sv or 100 -- Sound FX Volume
	player_data.mv = player_data.mv or 100 -- Music Volume
	player_data.li = player_data.li or 1 -- Language

	if(player_data.cs == nil or player_data.cs < 1) then
		player_data.cs = 1 -- Current Speed
	end

	player_data.an = player_data.an or 1 -- Nodes Show / Hide

	player:SetResource("speed", player_data.cs)
	player:SetResource("sfx_volume", player_data.sv)
	player:SetResource("music_volume", player_data.mv)
	player:SetResource("show_nodes", player_data.an)
	player:SetResource("language_index", player_data.li)

	YOOTIL.Events.broadcast_to_player(player, "apply_settings", player_data.cs, player_data.sv, player_data.mv, player_data.an, player_data.li)
end)

Events.ConnectForPlayer("update_misc_settings", function(player, sfx_amount, music_amount, language_index)
	player:SetResource("sfx_volume", sfx_amount or player:GetResource("sfx_volume"))
	player:SetResource("music_volume", music_amount or player:GetResource("music_volume"))
	player:SetResource("language_index", language_index or 1)
end)

Events.ConnectForPlayer("update_game_settings", function(player, speed, show_nodes)
	player:SetResource("speed", speed or player:GetResource("speed"))
	player:SetResource("show_nodes", show_nodes or player:GetResource("show_nodes"))
end)