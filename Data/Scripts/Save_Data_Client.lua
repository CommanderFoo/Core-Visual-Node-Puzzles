local API, YOOTIL = require(script:GetCustomProperty("API"))

local puzzle_data = script:GetCustomProperty("puzzle_data"):WaitForObject()

local save_task = nil
local local_player = Game.GetLocalPlayer()
local saving = false
local loaded_node_data = ""

function save()
	if(saving) then
		return
	end

	saving = true
	
	local had_data = false

	YOOTIL.Events.broadcast_to_server("save_init")

	for i, n in ipairs(API.nodes) do
		if(n:get_internal_id() > 0) then
			had_data = true

			--@TODO Look at get_output_connections_as_string
			YOOTIL.Events.broadcast_to_server("save_node", i, n:get_internal_id(), n:get_unique_id(), n:get_position_as_string(), n:get_condition(), n:get_limit(), n:get_output_connections_as_string())
		end
	end

	Events.Broadcast("saving")
	YOOTIL.Events.broadcast_to_server("has_saved", had_data)
end

Events.Connect("save_complete", function()
	saving = false
	Events.Broadcast("saved")
end)

Events.Connect("save", save)

Events.Connect("start_auto_save", function()
	if(save_task == nil) then
		save_task = Task.Spawn(save, 45)
		save_task.repeatInterval = 45
		save_task.repeatCount = -1
	end
end)

Events.Connect("stop_auto_save", function()
	if(save_task ~= nil) then
		save_task:Cancel()
		save_task = nil
	end
end)

puzzle_data.networkedPropertyChangedEvent:Connect(function(obj, prop)
	if(prop == "node_data") then
		loaded_node_data = puzzle_data:GetCustomProperty("node_data")
	end
end)

Events.Connect("load_saved_nodes", function()
	if(loaded_node_data ~= nil and loaded_node_data ~= "--") then
		local split_nodes = {CoreString.Split(loaded_node_data, ":")}
		local output_connections = {}
		local has_connections = false
		local last_uid = 0

		for i, s in ipairs(split_nodes) do
			local index, uid, pos_str, condition, limit, connections = CoreString.Split(s, "|")
			local x, y = CoreString.Split(pos_str, ",")

			if(connections ~= nil and string.len(connections) > 0) then
				output_connections[uid] = {CoreString.Split(connections, ",")}
				has_connections = true
			end

			last_uid = tonumber(uid)

			Events.Broadcast("spawn_node", tonumber(index), tonumber(uid), tonumber(x), tonumber(y), condition, tonumber(limit))
		end
		
		API.unique_id = last_uid

		if(has_connections) then
			for i, c in pairs(output_connections) do
				local the_node = API.get_node_by_unique_id(i)

				for hi, h in ipairs(c) do
					local handle_index, node_id = CoreString.Split(h, ";")

					if(handle_index and node_id) then
						local connecting_to_node = API.get_node_by_unique_id(node_id)

						if(connecting_to_node) then
							local the_node_connection = the_node:get_top_connector(true)

							if(handle_index == 2) then
								the_node_connection = the_node:get_bottom_connector(true)
							end

							the_node:do_output_connect(connecting_to_node, connecting_to_node:get_input_connector(), the_node_connection)

							the_node:move_connections()
						end
					end
				end
			end
		end
	end
end)