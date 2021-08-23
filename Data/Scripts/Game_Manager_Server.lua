local YOOTIL = require(script:GetCustomProperty("YOOTIL"))

local data_holder = script:GetCustomProperty("data"):WaitForObject()
local clear_player_data = script:GetCustomProperty("clear_player_data")

Events.ConnectForPlayer("init", function(player)
	YOOTIL.Events.broadcast_to_player(player, "show_main_menu")
end)

--@TODO: REMOVE

local load_solutions = true
local force_load_logic_puzzle = 1
local force_load_math_puzzle = 1

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
	
	if(clear_player_data) then
		player_data = {}
	end

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
	
	if(player_data.cs == nil or player_data.cs < 1) then
		player_data.cs = 1 -- Current Speed
	end

	player_data.sv = player_data.sv or 100 -- Sound FX Volume
	player_data.mv = player_data.mv or 100 -- Music Volume
	player_data.an = player_data.an or 1 -- Nodes Show / Hide
	player_data.sn = player_data.sn or 0 -- Show / Hide Notifications

	-- if(force_load_logic_puzzle) then
	-- 	player_data.clp = force_load_logic_puzzle
	-- end

	-- if(force_load_math_puzzle) then
	-- 	player_data.cmp = force_load_math_puzzle
	-- end

	--player_data.cs = 20
	
	player:SetResource("speed", player_data.cs)
	player:SetResource("sfx_volume", player_data.sv)
	player:SetResource("music_volume", player_data.mv)
	player:SetResource("show_notifications", player_data.sn)
	player:SetResource("show_nodes", player_data.an)
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

	YOOTIL.Events.broadcast_to_player(player, "load_game", is_math,  player_data.clp, player_data.cmp, player_data.cs, player_data.sv, player_data.mv, player_data.an)
end)