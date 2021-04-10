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

	for i, n in pairs(API.nodes) do
		if(n:get_internal_id() > 0) then
			had_data = true

			YOOTIL.Events.broadcast_to_server("save_node", i, n:get_internal_id(), n:get_unique_id(), n:get_position_as_string(), n:get_condition(), n:get_limit(), n:get_output_connections_as_string(), n:get_order())
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

puzzle_data.networkedPropertyChangedEvent:Connect(function(obj, prop)
	if(prop == "node_data") then
		loaded_node_data = puzzle_data:GetCustomProperty("node_data")
	end
end)

Events.Connect("load_saved_nodes", function()
	local loaded_data = loaded_node_data

	if(loaded_node_data == nil or loaded_node_data == "--") then
		local already_loaded_data = puzzle_data:GetCustomProperty("node_data")

		if(already_loaded_data ~= nil and already_loaded_data ~= "--") then
			loaded_data = already_loaded_data
		end
	end

	if(loaded_data ~= nil and loaded_data ~= "--") then
		local puzzle_id, node_data = CoreString.Split(loaded_data, "@")

		if(tonumber(puzzle_id) ~= local_player:GetResource("current_puzzle") or string.len(node_data) < 3) then
			return
		end

		local split_nodes = {CoreString.Split(node_data, ":")}
		local output_connections = {}
		local has_connections = false
		local last_uid = 0
		local screen = UI.GetScreenSize()

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

				if(x < -(screen.x / 2)) then
					x = 250	
				elseif(x > screen.x) then
					x = (screen.x / 2) - 300
				end

				if(y < -(screen.y / 2)) then
					y = 150	
				elseif(y > screen.y) then
					y = (screen.y / 2) - 150
				end

				Events.Broadcast("spawn_node", tonumber(index), tonumber(uid), x, y, condition, tonumber(limit), tonumber(order))
			end
		end
		
		API.unique_id = last_uid

		if(has_connections) then
			API.auto_set_order = false

			for i, c in pairs(output_connections) do
				local the_node = API.get_node_by_unique_id(i)

				for hi, h in ipairs(c) do
					local handle_index, node_id = CoreString.Split(h, ";")

					if(handle_index and node_id) then
						local connecting_to_node = API.get_node_by_unique_id(node_id)

						if(connecting_to_node) then
							local the_node_connection = the_node:get_top_connector(true)

							if(tonumber(handle_index) == 2) then
								the_node_connection = the_node:get_bottom_connector(true)
							end

							the_node:do_output_connect(connecting_to_node, connecting_to_node:get_input_connector(), the_node_connection)
							connecting_to_node:do_input_connect(the_node, the_node_connection, connecting_to_node:get_input_connector())

							the_node:move_connections()
						end
					end
				end
			end

			API.auto_set_order = true
		end
	end
end)