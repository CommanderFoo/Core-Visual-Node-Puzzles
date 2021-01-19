local data = script:GetCustomProperty("data"):WaitForObject()

function on_player_joined(player)
	local player_data = Storage.GetPlayerData(player)
	
	local puzzle_id = 1
	
	if(player_data["pid"]) then
		puzzle_id = player_data["pid"]
	end

	data:SetNetworkedCustomProperty("puzzle_id", puzzle_id)
end

function on_player_left(player)

end

Game.playerJoinedEvent:Connect(on_player_joined)
Game.playerLeftEvent:Connect(on_player_left)