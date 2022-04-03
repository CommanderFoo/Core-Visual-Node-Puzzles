local TOTAL_PLAYERS_KEY = script:GetCustomProperty("NodeLinkTotalPlayers")
local DATA = script:GetCustomProperty("Data"):WaitForObject()

local delta_players = 0
local wait_time = 5

local function update_clients(key, data)
	DATA:SetCustomProperty("total_players", data.count or 1)
end

local function on_player_joined(player)
	delta_players = delta_players + 1
	update_clients(nil, Storage.GetConcurrentCreatorData(TOTAL_PLAYERS_KEY))
end

local function on_player_left(player)
	delta_players = delta_players - 1
end

local function update_total_players(data)
	if(not data.count) then
		data.count = 0
	end

	data.count = data.count + delta_players

	return data
end

function Tick()
	Task.Wait(wait_time)

	if delta_players == 0 or Storage.HasPendingSetConcurrentCreatorData(TOTAL_PLAYERS_KEY) then
		return
	end

	Storage.SetConcurrentCreatorData(TOTAL_PLAYERS_KEY, update_total_players)
	
	delta_players = 0
end

Storage.ConnectToConcurrentCreatorDataChanged(TOTAL_PLAYERS_KEY, update_clients)

Game.playerJoinedEvent:Connect(on_player_joined)
Game.playerLeftEvent:Connect(on_player_left)
