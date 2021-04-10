local YOOTIL = require(script:GetCustomProperty("YOOTIL"))

local data_holder = script:GetCustomProperty("data"):WaitForObject()
local clear_player_data = script:GetCustomProperty("clear_player_data")

Events.ConnectForPlayer("init", function(player)
	YOOTIL.Events.broadcast_to_player(player, "show_main_menu")
end)

--@TODO: REMOVE
local force_load_puzzle = 11

-- Prefetch node data and send early.

function on_join(player)
	Events.Broadcast("set_networked_data", player)
end

function load_game(player)
	local player_data = Storage.GetPlayerData(player)
	
	if(clear_player_data) then
		player_data = {}
	end

	if(player_data.cp == nil or player_data.cp < 1) then
		player_data.cp = 1 -- Current Puzzle
	end
	
	if(player_data.cs == nil or player_data.cs < 1) then
		player_data.cs = 1 -- Current Speed
	end

	player_data.sv = player_data.sv or 100 -- Sound FX Volume
	player_data.mv = player_data.mv or 100 -- Music Volume
	player_data.an = player_data.an or 1 -- Nodes Show / Hide
	player_data.sn = player_data.sn or 0 -- Show / Hide Notifications

	if(force_load_puzzle) then
		player_data.cp = force_load_puzzle
	end

	player:SetResource("speed", player_data.cs)
	player:SetResource("sfx_volume", player_data.sv)
	player:SetResource("music_volume", player_data.mv)
	player:SetResource("show_notifications", player_data.sn)
	player:SetResource("show_nodes", player_data.an)
	player:SetResource("current_puzzle", player_data.cp)

	YOOTIL.Events.broadcast_to_player(player, "load_game", player_data.cp, player_data.cs, player_data.sv, player_data.mv, player_data.an)
end

Events.ConnectForPlayer("load_game", load_game)

Game.playerJoinedEvent:Connect(function(player)
	player:SetVisibility(false)
	player.movementControlMode = MovementControlMode.NONE
	player.lookControlMode = LookControlMode.NONE
	player.maxJumpCount = 0
	player.isCrouchEnabled = false
end)

Game.playerLeftEvent:Connect(function(p)
	Events.Broadcast("save_data", p)
end)

Game.playerJoinedEvent:Connect(on_join)

Events.ConnectForPlayer("update_player_prefs", function(player, speed, show_nodes)
	player:SetResource("speed", speed)

	if(not show_nodes) then
		player:SetResource("show_nodes", 0)
	else
		player:SetResource("show_nodes", 1)
	end
end)

Events.ConnectForPlayer("update_settings", function(player, sfx_vol, music_vol, notify)
	player:SetResource("sfx_volume", sfx_vol)
	player:SetResource("music_volume", music_vol)

	if(not notify) then
		player:SetResource("show_notifications", 0)
	else
		player:SetResource("show_notifications", 1)
	end
end)