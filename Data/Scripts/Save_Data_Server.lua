local YOOTIL = require(script:GetCustomProperty("YOOTIL"))

local puzzle_data = script:GetCustomProperty("puzzle_data"):WaitForObject()

function save_data(player)
	local data = {

		clp = player:GetResource("current_logic_puzzle"),
		cmp = player:GetResource("current_math_puzzle"),
		cs = player:GetResource("speed"),
		sv = player:GetResource("sfx_volume"),
		mv = player:GetResource("music_volume"),
		sn = player:GetResource("show_notifications"),
		an = player:GetResource("show_nodes")

	}

	if(player.serverUserData.logic_node_data) then
		data.lnd = tostring(data.clp) .. "@"
		
		for k, v in pairs(player.serverUserData.logic_node_data) do
			data.lnd = data.lnd .. v .. ":"
		end
	end

	if(player.serverUserData.math_node_data) then
		data.mnd = tostring(data.cmp) .. "@"
		
		for k, v in pairs(player.serverUserData.math_node_data) do
			data.mnd = data.mnd .. v .. ":"
		end
	end

	if(clear_player_data) then
		data = {}
	end
	
	--YOOTIL.Utils.dump(data)

	Storage.SetPlayerData(player, data)
end

function set_networked_data(player, logic_saving)
	if(logic_saving) then
		if(player.serverUserData.logic_node_data == nil) then
			player.serverUserData.logic_node_data = {}
		end
	else
		if(player.serverUserData.math_node_data == nil) then
			player.serverUserData.math_node_data = {}
		end
	end

	local player_data = Storage.GetPlayerData(player)
	local data = nil
	
	if(logic_saving) then
		data = player_data.lnd
	else
		data = player_data.mnd
	end

	if(clear_player_data or (data == nil or string.len(data) < 3)) then
		data = "--"
	else
		local puzzle_id, node_data = CoreString.Split(data, "@")

		if(logic_saving) then
			if(tonumber(puzzle_id) ~= tonumber(player_data.clp)) then
				data = "--"
			else
				local parts = {CoreString.Split(node_data, ":")}

				for i, p in ipairs(parts) do
					player.serverUserData.logic_node_data[i] = p
				end
			end
		else
			if(tonumber(puzzle_id) ~= tonumber(player_data.cmp)) then
				data = "--"
			else
				local parts = {CoreString.Split(node_data, ":")}

				for i, p in ipairs(parts) do
					player.serverUserData.math_node_data[i] = p
				end
			end
		end
	end

	if(logic_saving) then
		puzzle_data:SetNetworkedCustomProperty("logic_node_data", data)
	else
		puzzle_data:SetNetworkedCustomProperty("math_node_data", data)
	end
end

Events.ConnectForPlayer("save_logic_node", function(player, index, id, uid, pos, condition, limit, connections, order)
	player.serverUserData.logic_node_data[index] = tostring(id) .. "|" .. tostring(uid) .. "|" .. pos .. "|" .. (condition or "") .. "|" .. (limit or "") .. "|" .. (connections or "") .. "|" .. (order or "")
end)

Events.ConnectForPlayer("save_math_node", function(player, index, id, uid, pos, condition, limit, connections, order)
	player.serverUserData.math_node_data[index] = tostring(id) .. "|" .. tostring(uid) .. "|" .. pos .. "|" .. (condition or "") .. "|" .. (limit or "") .. "|" .. (connections or "") .. "|" .. (order or "")
end)

Events.ConnectForPlayer("save_puzzle_progress", function(player, id, logic_saving)
	if(logic_saving) then
		player:SetResource("current_logic_puzzle", id)
		player.serverUserData.logic_node_data = {}
	else
		player:SetResource("current_math_puzzle", id)
		player.serverUserData.math_node_data = {}
	end
	
	save_data(player, logic_saving)
end)

Events.ConnectForPlayer("has_saved", function(p, had_data, logic_saving)
	if(not had_data) then
		if(logic_saving) then
			player.serverUserData.logic_node_data = {}
		else
			player.serverUserData.math_node_data = {}
		end
	end

	save_data(p, logic_saving)
	set_networked_data(p, logic_saving)

	YOOTIL.Events.broadcast_to_player(p, "save_complete")
end)

Events.ConnectForPlayer("save_init", function(player, logic_saving)
	if(logic_saving) then
		player.serverUserData.logic_node_data = {}
	else
		player.serverUserData.math_node_data = {}
	end
end)

Events.Connect("save_data", save_data)
Events.Connect("set_networked_data", set_networked_data)