local YOOTIL = require(script:GetCustomProperty("YOOTIL"))

local puzzle_data = script:GetCustomProperty("puzzle_data"):WaitForObject()

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
		data.nd = tostring(data.cp) .. "@"
		
		for k, v in pairs(player.serverUserData.node_data) do
			data.nd = data.nd .. v .. ":"
		end
	end

	if(clear_player_data) then
		data = {}
	end

	Storage.SetPlayerData(player, data)
end

function set_networked_data(player)
	if(player.serverUserData.node_data == nil) then
		player.serverUserData.node_data = {}
	end

	local player_data = Storage.GetPlayerData(player)
	local data = player_data.nd

	if(force_load_puzzle) then
		player_data.cp = force_load_puzzle
	end

	if(clear_player_data or (data == nil or string.len(data) < 3)) then
		data = "--"
	else
		local puzzle_id, node_data = CoreString.Split(data, "@")

		if(tonumber(puzzle_id) ~= tonumber(player_data.cp)) then
			data = "--"
		else
			local parts = {CoreString.Split(node_data, ":")}

			for i, p in ipairs(parts) do
				player.serverUserData.node_data[i] = p
			end
		end
	end

	puzzle_data:SetNetworkedCustomProperty("node_data", data)
end

Events.ConnectForPlayer("save_node", function(player, index, id, uid, pos, condition, limit, connections, order)
	player.serverUserData.node_data[index] = tostring(id) .. "|" .. tostring(uid) .. "|" .. pos .. "|" .. (condition or "") .. "|" .. (limit or "") .. "|" .. (connections or "") .. "|" .. (order or "")
end)

Events.ConnectForPlayer("save_puzzle_progress", function(player, id)
	player:SetResource("current_puzzle", id)
	player.serverUserData.node_data = {}
	
	save_data(player)
end)

Events.ConnectForPlayer("has_saved", function(p, had_data)
	if(not had_data) then
		p.serverUserData.node_data = {}
	end

	save_data(p)
	set_networked_data(p)

	YOOTIL.Events.broadcast_to_player(p, "save_complete")
end)

Events.ConnectForPlayer("save_init", function(player)
	player.serverUserData.node_data = {}
end)

Events.Connect("save_data", save_data)
Events.Connect("set_networked_data", set_networked_data)