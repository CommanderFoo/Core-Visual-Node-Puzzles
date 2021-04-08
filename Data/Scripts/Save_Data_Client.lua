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

			YOOTIL.Events.broadcast_to_server("save_node", i, n:get_internal_id(), n:get_position_as_string(), n:get_condition())
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

-- 1|-474.93,-2.08:2|385.36,-97.90

Events.Connect("load_saved_nodes", function()
	if(loaded_node_data ~= nil and loaded_node_data ~= "--") then
		local node_strs = {}
		local split_nodes = {CoreString.Split(loaded_node_data, ":")}

		for i, s in ipairs(split_nodes) do
			local index, pos_str, condition = CoreString.Split(s, "|")
			local x, y = CoreString.Split(pos_str, ",")

			Events.Broadcast("spawn_node", tonumber(index), tonumber(x), tonumber(y), condition)
		end
	end
end)