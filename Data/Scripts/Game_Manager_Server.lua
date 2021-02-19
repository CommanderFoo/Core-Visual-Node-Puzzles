local data = script:GetCustomProperty("data"):WaitForObject()

local current_puzzle = 0
local showing_nodes = false
local current_speed = 1

function on_player_joined(player)
	local player_data = Storage.GetPlayerData(player)
	
	-- Puzzle ID last played

	if(player_data["pid"]) then
		current_puzzle = player_data["pid"]
	end

	-- Nodes panel state

	if(player_data["sn"]) then
		showing_nodes = player_data["sn"]
	end

	-- Speed

	if(player_data["s"]) then
		current_speed = player_data["s"]
	end

	load_puzzle(current_puzzle)
end

function on_player_left(player)
	Storage.SetPlayerData(player, {

		pid = current_puzzle,
		sn = showing_nodes,
		s = current_speed

	})
end

function load_puzzle(id)
	current_puzzle = id

	data:SetNetworkedCustomProperty("puzzle_id", current_puzzle)

	if(id > 0) then
		data:SetNetworkedCustomProperty("show_nodes", showing_nodes)
	end

	data:SetNetworkedCustomProperty("speed", current_speed)
end

Game.playerJoinedEvent:Connect(on_player_joined)
Game.playerLeftEvent:Connect(on_player_left)

Events.Connect("update_player_prefs", function(speed, show_nodes)
	current_speed = speed
	showing_nodes = show_nodes
end)

Events.Connect("load_puzzle", load_puzzle)