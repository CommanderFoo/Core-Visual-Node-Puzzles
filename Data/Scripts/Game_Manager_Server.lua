﻿local YOOTIL = require(script:GetCustomProperty("YOOTIL"))

local data_holder = script:GetCustomProperty("data"):WaitForObject()
local clear_player_data = script:GetCustomProperty("clear_player_data")

Events.ConnectForPlayer("init", function(player)
	YOOTIL.Events.broadcast_to_player(player, "show_main_menu")
end)

-- Prefetch node data and send early.

function on_join(player)
	player.serverUserData.node_data = {}

	local player_data = Storage.GetPlayerData(player)
	local data = player_data.nd

	if(clear_player_data or (data == nil or string.len(data) < 3)) then
		data = "--"
	else
		local parts = {CoreString.Split(data, ":")}

		for i, p in ipairs(parts) do
			player.serverUserData.node_data[i] = p
		end
	end

	Events.Broadcast("set_node_data", data)
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

	-- @TODO: Remove
	player_data.cp = 1

	player:SetResource("speed", player_data.cs)
	player:SetResource("sfx_volume", player_data.sv)
	player:SetResource("music_volume", player_data.mv)
	player:SetResource("show_notifications", player_data.sn)
	player:SetResource("show_nodes", player_data.an)
	player:SetResource("current_puzzle", player_data.cp)

	--YOOTIL.Utils.dump(player_data)

	YOOTIL.Events.broadcast_to_player(player, "load_game", player_data.cp, player_data.cs, player_data.sv, player_data.mv, player_data.an)
end

function save_data(player)
	local data = {

		cp = player:GetResource("current_puzzle"),
		cs = player:GetResource("speed"),
		sv = player:GetResource("sfx_volume"),
		mv = player:GetResource("music_volume"),
		sn = player:GetResource("show_notifications"),
		an = player:GetResource("show_nodes")

	}

	if(player.serverUserData.node_data) then
		data.nd = table.concat(player.serverUserData.node_data, ":")
	end

	if(clear_player_data) then
		data = {}
	end

	--YOOTIL.Utils.dump(data)

	Storage.SetPlayerData(player, data)
end

Events.ConnectForPlayer("load_game", load_game)

Game.playerJoinedEvent:Connect(function(player)
	player:SetVisibility(false)
	player.movementControlMode = MovementControlMode.NONE
	player.lookControlMode = LookControlMode.NONE
	player.maxJumpCount = 0
	player.isCrouchEnabled = false
end)

Game.playerLeftEvent:Connect(save_data)
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