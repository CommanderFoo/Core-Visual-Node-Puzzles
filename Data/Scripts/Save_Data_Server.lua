local YOOTIL = require(script:GetCustomProperty("YOOTIL"))
local Logic_Solutions = require(script:GetCustomProperty("logic_puzzle_solutions"))
local Math_Solutions = require(script:GetCustomProperty("math_puzzle_solutions"))

local clear_player_data = false

-- Internal ID | Unique ID | Position | Condition | Limit | Output Connections | Order

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
	
	data.lp_p = player.serverUserData.logic_progress or {}
	data.mp_p = player.serverUserData.math_progress or {}

	--data = {}
	Storage.SetPlayerData(player, data)
end

function set_networked_data(player, logic_saving, load_solutions)
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
	local data = ""
	
	player.serverUserData.logic_progress = player_data.lp_p or {}
	player.serverUserData.math_progress = player_data.mp_p or {}

	if(load_solutions) then
		local player_data = Storage.GetPlayerData(player)
		local clp = 1
		local cmp = 1

		if(player_data.clp ~= nil and player_data.clp > 0) then
			clp = player_data.clp
		end
	
		if(player_data.cmp ~= nil and player_data.cmp > 0) then
			cmp = player_data.cmp
		end

		if(logic_saving) then
			data = Logic_Solutions[clp] or ""
		else
			data = Math_Solutions[cmp] or ""
		end
	else
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
	end

	if(logic_saving) then
		player:SetPrivateNetworkedData("logic_node_data", data)
		player:SetPrivateNetworkedData("logic_progress", player.serverUserData.logic_progress)
	else
		player:SetPrivateNetworkedData("math_node_data", data)
		player:SetPrivateNetworkedData("math_progress", player.serverUserData.math_progress)
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

Events.ConnectForPlayer("has_saved", function(player, had_data, logic_saving)
	if(not had_data) then
		if(logic_saving) then
			player.serverUserData.logic_node_data = {}
		else
			player.serverUserData.math_node_data = {}
		end
	end

	save_data(player, logic_saving)
	set_networked_data(player, logic_saving)

	YOOTIL.Events.broadcast_to_player(player, "save_complete")
end)

Events.ConnectForPlayer("save_init", function(player, logic_saving)
	if(logic_saving) then
		player.serverUserData.logic_node_data = {}
	else
		player.serverUserData.math_node_data = {}
	end
end)

function has_logic_progress_entry(player, id)
	for i, d in ipairs(player.serverUserData.logic_progress) do
		if(d[1] == id) then
			return d
		end
	end

	return nil
end

function has_math_progress_entry(player, id)
	for i, d in ipairs(player.serverUserData.math_progress) do
		if(d[1] == id) then
			return d
		end
	end

	return nil
end

Events.Connect("save_data", save_data)
Events.Connect("set_networked_data", set_networked_data)
Events.ConnectForPlayer("save_puzzle_completed", function(player, award, score, is_logic, puzzle_id)
	if(is_logic) then
		local entry = has_logic_progress_entry(player, puzzle_id)

		if(entry ~= nil) then
			if(award > entry[2]) then
				entry[2] = award
			end

			if(score > entry[3]) then
				entry[3] = score
			end
		else
			player.serverUserData.logic_progress[#player.serverUserData.logic_progress + 1] = {

				puzzle_id, award, score

			}
		end

		player:SetPrivateNetworkedData("logic_progress", player.serverUserData.logic_progress)
	else
		local entry = has_math_progress_entry(player, puzzle_id)

		if(entry ~= nil) then
			if(award > entry[2]) then
				entry[2] = award
			end

			if(score > entry[3]) then
				entry[3] = score
			end
		else
			player.serverUserData.math_progress[#player.serverUserData.math_progress + 1] = {

				puzzle_id, award, score

			}
		end

		player:SetPrivateNetworkedData("math_progress", player.serverUserData.math_progress)
	end
end)