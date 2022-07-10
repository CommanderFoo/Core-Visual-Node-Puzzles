local TOTAL_PLAYERS_KEY = script:GetCustomProperty("NodeLinkTotalPlayers")
local DATA = script:GetCustomProperty("Data"):WaitForObject()

local function update_clients(key, data)
	DATA:SetCustomProperty("total_players", data.count or 1)
end

local function on_player_joined(player)
	Storage.SetConcurrentCreatorData(TOTAL_PLAYERS_KEY, function(data)
		if(not data.count or data.count < 0) then
			data.count = 0
		end
	
		data.count = data.count + 1
	
		return data
	end)

	update_clients(nil, Storage.GetConcurrentCreatorData(TOTAL_PLAYERS_KEY))
end

local function on_player_left(player)
	Storage.SetConcurrentCreatorData(TOTAL_PLAYERS_KEY, function(data)
		if(not data.count or data.count < 0) then
			data.count = 0
		else
			data.count = math.max(0, data.count - 1)
		end
	
		return data
	end)
end

Storage.ConnectToConcurrentCreatorDataChanged(TOTAL_PLAYERS_KEY, update_clients)

Game.playerJoinedEvent:Connect(on_player_joined)
Game.playerLeftEvent:Connect(on_player_left)

Chat.receiveMessageHook:Connect(function(speaker, params)
	if(speaker.name == "CommanderFoo" and params.message == "/clear") then
		Task.Spawn(function()
			Storage.SetConcurrentCreatorData(TOTAL_PLAYERS_KEY, function(data)
				data.count = 1
				return data
			end)
		end)

		params.message = ""
	end
end)