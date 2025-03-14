local API, YOOTIL = require(script:GetCustomProperty("API"))

local save_task = nil
local local_player = Game.GetLocalPlayer()
local saving = false

local loaded_logic_node_data = ""
local loaded_math_node_data = ""

function save()
	--print("Is Saving: ", saving)

	if(saving) then
		return
	end

	local logic_saving = local_player.clientUserData.logic

	saving = true
	
	local had_data = false

	YOOTIL.Events.broadcast_to_server("save_init", logic_saving)

	for i, n in pairs(API.nodes) do
		if(n ~= nil and n:get_internal_id() > 0) then
			had_data = true

			if(logic_saving) then
				YOOTIL.Events.broadcast_to_server("save_logic_node", i, n:get_internal_id(), n:get_unique_id(), n:get_position_as_string(), n:get_condition(), n:get_limit(), n:get_output_connections_as_string(), n:get_order())
			else
				YOOTIL.Events.broadcast_to_server("save_math_node", i, n:get_internal_id(), n:get_unique_id(), n:get_position_as_string(), n:get_condition(), n:get_amount(), n:get_output_connections_as_string(), n:get_order())
			end

			Task.Wait(.1)
		end
	end

	Events.Broadcast("saving")
	YOOTIL.Events.broadcast_to_server("has_saved", had_data, logic_saving)
end

function create_nodes(node_data)
	local split_nodes = {CoreString.Split(node_data, ":")}
	local output_connections = {}
	local has_connections = false
	local last_uid = 0

	for i, s in ipairs(split_nodes) do
		if(string.len(s) > 0) then
			local index, uid, pos_str, condition, limit, connections, order = CoreString.Split(s, "|")
			local x, y = CoreString.Split(pos_str, ",")

			x = tonumber(x)
			y = tonumber(y)

			if(connections ~= nil and string.len(connections) > 0) then
				output_connections[uid] = {CoreString.Split(connections, ",")}
				has_connections = true
			end

			last_uid = tonumber(uid)

			Events.Broadcast("spawn_node", tonumber(index), tonumber(uid), x, y, condition, tonumber(limit), tonumber(order))
		end
	end
	
	API.unique_id = last_uid

	if(has_connections) then
		set_connections(output_connections)
	end
end

function set_connections(output_connections)
	API.auto_set_order = false

	for i, c in pairs(output_connections) do
		local the_node = API.get_node_by_unique_id(i)

		for hi, h in ipairs(c) do
			local handle_index, connected_to = CoreString.Split(h, ";")

			if(handle_index and connected_to) then
				local node_id, to_index = CoreString.Split(connected_to, "~")
				local connecting_to_node = API.get_node_by_unique_id(node_id)

				if(connecting_to_node) then
					local the_node_connection = the_node:get_top_connector(true)

					if(tonumber(handle_index) == 2) then
						the_node_connection = the_node:get_bottom_connector(true)
					end

					local input_connector = nil
					
					if(tonumber(to_index) == 1) then
						input_connector = connecting_to_node:get_top_input_connector()	
					elseif(tonumber(to_index) == 2) then
						input_connector = connecting_to_node:get_bottom_input_connector()	
					end
					
					the_node:do_output_connect(connecting_to_node, input_connector, the_node_connection)
					connecting_to_node:do_input_connect(the_node, the_node_connection, input_connector)

					the_node:move_connections()
				end
			end
		end
	end

	API.auto_set_order = true
end

Events.Connect("load_saved_logic_nodes", function(logic_id)
	local has_data = true

	if(loaded_logic_node_data ~= nil and loaded_logic_node_data ~= "--") then
		local puzzle_id, node_data = CoreString.Split(loaded_logic_node_data, "@")

		if(tonumber(puzzle_id) ~= logic_id or string.len(node_data) < 3) then
			has_data = false
		else
			create_nodes(node_data)
		end
	else
		has_data = false
	end

	if(not has_data) then
		Events.Broadcast("create_default_nodes")
	end
end)

Events.Connect("load_saved_math_nodes", function(math_id)
	local has_data = true

	if(loaded_math_node_data ~= nil and loaded_math_node_data ~= "--") then
		local puzzle_id, node_data = CoreString.Split(loaded_math_node_data, "@")

		if(tonumber(puzzle_id) ~= math_id or string.len(node_data) < 3) then
			has_data = false
		else
			create_nodes(node_data)
		end
	else
		has_data = false
	end

	if(not has_data) then
		Events.Broadcast("create_default_nodes")
	end
end)

Events.Connect("save_complete", function()
	--print("Save Complete")
	
	saving = false
	Events.Broadcast("saved")
end)

Events.Connect("save", save)

Events.Connect("start_auto_save", function()
	if(save_task == nil) then
		save_task = Task.Spawn(save, 30)
		save_task.repeatInterval = 30
		save_task.repeatCount = -1
	end
end)

Events.Connect("stop_auto_save", function()
	if(save_task ~= nil) then
		save_task:Cancel()
		save_task = nil
	end
end)

function set_data(player, key)
	local data = local_player:GetPrivateNetworkedData(key)

	if(key == "logic_node_data") then
		loaded_logic_node_data = data
	elseif(key == "math_node_data") then
		loaded_math_node_data = data
	elseif(key == "logic_progress") then
		Events.Broadcast("update_logic_list", data)
	elseif(key == "math_progress") then
		Events.Broadcast("update_math_list", data)
	end
end

local_player.privateNetworkedDataChangedEvent:Connect(set_data)

for i, key in ipairs(local_player:GetPrivateNetworkedDataKeys()) do
    set_data(local_player, key)
end