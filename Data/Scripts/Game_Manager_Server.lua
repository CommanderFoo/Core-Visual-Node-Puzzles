local YOOTIL = require(script:GetCustomProperty("YOOTIL"))

local data_holder = script:GetCustomProperty("data"):WaitForObject()
local clear_player_data = script:GetCustomProperty("clear_player_data")

Events.ConnectForPlayer("init", function(player)
	Events.Broadcast("send_settings", player)
	YOOTIL.Events.broadcast_to_player(player, "show_main_menu")
end)

--@TODO: REMOVE

local load_solutions = false
local force_load_logic_puzzle = 25
local force_load_math_puzzle = 25

-- Prefetch node data and send early.

local function on_join(player)
	player.isVisible = false
	player.movementControlMode = MovementControlMode.NONE
	player.lookControlMode = LookControlMode.NONE
	player.maxJumpCount = 0
	player.isCrouchEnabled = false

	Task.Wait()
	Events.Broadcast("set_networked_data", player, true, load_solutions)
	Events.Broadcast("set_networked_data", player, false, load_solutions)
end

local function load_data(player)
	local player_data = Storage.GetPlayerData(player)

	if(load_solutions) then
		player_data.clp = force_load_logic_puzzle
	elseif(player_data.clp == nil or player_data.clp < 1) then
		player_data.clp = 1 -- Current Logic Puzzle
	end

	if(load_solutions) then
		player_data.cmp = force_load_math_puzzle
	elseif(player_data.cmp == nil or player_data.cmp < 1) then
		player_data.cmp = 1 -- Current Math Puzzle
	end

	player:SetResource("current_logic_puzzle", player_data.clp)
	player:SetResource("current_math_puzzle", player_data.cmp)

	return player_data
end

local function load_game(player, math)
	local player_data = load_data(player)

	YOOTIL.Events.broadcast_to_player(player, "load_game", math, player_data.clp, player_data.cmp, player_data.cs, player_data.sv, player_data.mv, player_data.an)
end

Events.ConnectForPlayer("load_game", load_game)

Game.playerJoinedEvent:Connect(on_join)

Game.playerLeftEvent:Connect(function(p)
	Events.Broadcast("save_data", p)
end)

Events.ConnectForPlayer("load_puzzle_id", function(player, id, is_math)
	local player_data = load_data(player)
	
	if(not is_math) then
		player:SetResource("current_logic_puzzle", id)
		player_data.clp = id

		if(load_solutions) then
			Events.Broadcast("set_networked_data", player, true, load_solutions, id)
		end
	else
		player:SetResource("current_math_puzzle", id)
		player_data.cmp = id

		if(load_solutions) then
			Events.Broadcast("set_networked_data", player, false, load_solutions, id)
		end
	end

	YOOTIL.Events.broadcast_to_player(player, "load_game", is_math, player_data.clp, player_data.cmp)
end)