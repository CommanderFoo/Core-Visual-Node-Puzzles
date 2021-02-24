local data_holder = script:GetCustomProperty("data"):WaitForObject()
local clear_player_data = script:GetCustomProperty("clear_player_data")

local tutorial_data = {}

function init(player)
	local player_data = Storage.GetPlayerData(player)
	
	player_data.cp = player_data.cp or 0
	player_data.cs = player_data.cs or 1
	player_data.s = player_data.s or 100
	player_data.m = player_data.m or 100
	player_data.n = player_data.n or 1
	player_data.sn = player_data.sn or 0
	
	if(player_data.cp and not clear_player_data) then
		data = player_data

		local counter = 1

		for k, v in pairs(player_data) do
			local key = "p" .. counter .. "t"
			
			if(k == key) then
				player:SetResource(k, v)

				tutorial_data[k] = v
			end
		end
	end

	print("---------")
	for k, v in pairs(player_data) do
		print(k, v)
	end
	print("---------")
	
	player:SetResource("speed", player_data.cs)
	player:SetResource("sfx_volume", player_data.s)
	player:SetResource("music_volume", player_data.m)
	player:SetResource("show_notifications", player_data.n)

	if(player_data.cp > 0) then
		player:SetResource("show_nodes", player_data.sn)
	end

	load_puzzle(player, player_data.cp)
end

function on_player_left(player)
	local data = {

		cp = player:GetResource("puzzle_id"),
		cs = player:GetResource("speed"),
		s = player:GetResource("sfx_volume"),
		m = player:GetResource("music_volume"),
		n = player:GetResource("show_notifications"),
		sn = player:GetResource("show_nodes")

	}

	for k, v in pairs(tutorial_data) do
		data[k] = v
	end

	if(clear_player_data) then
		data = {}
	end

	Storage.SetPlayerData(player, data)
end

function load_puzzle(player, puzzle_id, force_show_nodes)
	player:SetResource("puzzle_id", puzzle_id)

	if(force_show_nodes) then
		player:SetResource("show_nodes", 1)
	end
end

Game.playerLeftEvent:Connect(on_player_left)

Events.ConnectForPlayer("update_player_prefs", function(player, speed, show_nodes)
	player:SetResource("speed", speed)
	player:SetResource("show_nodes", (show_nodes and 1) or (not show_nodes and 0))
end)

Events.ConnectForPlayer("update_settings", function(player, sfx_vol, music_vol, notify)
	player:SetResource("sfx_volume", sfx_vol)
	player:SetResource("music_volume", music_vol)
	player:SetResource("show_notifications", (notify and 1) or (not notify and 0))
end)

Events.ConnectForPlayer("save_puzzle_tutorial_seen", function(player)
	player:SetResource("p" .. player:GetResource("puzzle_id") .. "t", 1)
	tutorial_data["p" .. player:GetResource("puzzle_id") .. "t"] = 1
end)

Events.ConnectForPlayer("load_puzzle", load_puzzle)
Events.ConnectForPlayer("game_ready", init)