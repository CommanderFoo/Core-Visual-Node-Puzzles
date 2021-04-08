local YOOTIL = require(script:GetCustomProperty("YOOTIL"))

local puzzle_data = script:GetCustomProperty("puzzle_data"):WaitForObject()

Events.ConnectForPlayer("save_node", function(player, index, id, pos, condition)
	player.serverUserData.node_data[index] = tostring(id) .. "|" .. pos .. "|" .. (condition or "")
end)

Events.Connect("set_node_data", function(data)
	puzzle_data:SetNetworkedCustomProperty("node_data", data)
end)

Events.ConnectForPlayer("save_puzzle_progress", function(player, id)
	player:SetResource("current_puzzle", id)
	player.serverUserData.node_data = {}
end)

Events.ConnectForPlayer("has_saved", function(p, had_data)
	if(not had_data) then
		p.serverUserData.node_data = {}
	end

	YOOTIL.Events.broadcast_to_player(p, "save_complete")
end)

Events.ConnectForPlayer("save_init", function(player)
	player.serverUserData.node_data = {}
end)