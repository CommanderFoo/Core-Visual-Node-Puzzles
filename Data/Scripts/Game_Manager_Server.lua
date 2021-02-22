local data_holder = script:GetCustomProperty("data"):WaitForObject()
local clear_player_data = script:GetCustomProperty("clear_player_data")

local data = {
	
	current_puzzle = 0,
	showing_nodes = false,
	current_speed = 1

}

function on_player_joined(player)
	local player_data = Storage.GetPlayerData(player)
	
	if(player_data and player_data.current_puzzle and not clear_player_data) then
		data = player_data

		local counter = 1

		for k, v in pairs(player_data) do
			local key = "p" .. counter .. "t"
			
			if(k == key) then
				player:SetResource(k, v)
			end
		end
	end

	load_puzzle(data.current_puzzle)
end

function on_player_left(player)
	if(clear_player_data) then
		data = {}
	end

	Storage.SetPlayerData(player, data)
end

function load_puzzle(id, force_show_nodes)
	data.current_puzzle = id

	data_holder:SetNetworkedCustomProperty("puzzle_id", data.current_puzzle)

	if(id > 0) then
		if(force_show_nodes) then
			data.showing_nodes = true
		end

		data_holder:SetNetworkedCustomProperty("show_nodes", data.showing_nodes)
	end

	data_holder:SetNetworkedCustomProperty("speed", data.current_speed)
end

Game.playerJoinedEvent:Connect(on_player_joined)
Game.playerLeftEvent:Connect(on_player_left)

Events.Connect("update_player_prefs", function(speed, show_nodes)
	data.current_speed = speed
	data.showing_nodes = show_nodes
end)

Events.Connect("save_puzzle_tutorial_seen", function()
	data["p" .. data.current_puzzle .. "t"] = 1
end)

Events.Connect("load_puzzle", load_puzzle)