local API = require(script:GetCustomProperty("API"))

local root = script.parent.parent
local evts = {}

local node = script:GetCustomProperty("node")
local container = script:GetCustomProperty("container"):WaitForObject()
local button = root:FindDescendantByName("Node Handle")
local total = root:GetCustomProperty("total")

local circle_data_amount = root:GetCustomProperty("circle_data_amount")
local square_data_amount = root:GetCustomProperty("square_data_amount")
local triangle_data_amount = root:GetCustomProperty("triangle_data_amount")
local plus_data_amount = root:GetCustomProperty("plus_data_amount")

local first_number = root:GetCustomProperty("first_number")
local first_count = root:GetCustomProperty("first_count")
local first_required = root:GetCustomProperty("first_required")

local second_number = root:GetCustomProperty("second_number")
local second_count = root:GetCustomProperty("second_count")
local second_required = root:GetCustomProperty("second_required")

local third_number = root:GetCustomProperty("third_number")
local third_count = root:GetCustomProperty("third_count")
local third_required = root:GetCustomProperty("third_required")

local fourth_number = root:GetCustomProperty("fourth_number")
local fourth_count = root:GetCustomProperty("fourth_count")
local fourth_required = root:GetCustomProperty("fourth_required")

local total_spawned = 0
local index = 1
local node_destroy_evt = nil

for i, c in ipairs(root.parent:GetChildren()) do
	if(c == root) then
		index = i
	end
end

function find_node_script(n)
	local scripts = n:FindDescendantsByType("Script")

	for i, s in ipairs(scripts) do
		if(string.find(s.name, "_Node")) then
			return s.context
		end
	end

	return nil
end

node_destroy_evt = API.Node_Events.on("node_destroyed", function(node_id, tpl_id, internal_id)
	if(index == internal_id) then
		if(total ~= -1) then
			total_spawned = total_spawned - 1

			if(total_spawned < total and Object.IsValid(button)) then
				button.isInteractable = true
			end
		end

		API.Puzzle_Events.trigger("node_total_change")
	end
end)

function spawn_node(x, y, uid, condition, limit, order)
	local n = World.SpawnAsset(node, { parent = container:FindChildByName("Graph") })
		
	n.x = x
	n.y = y

	local s = find_node_script(n)
	
	if(s ~= nil) then			
		if(s.init ~= nil) then
			local data = {}

			if(circle_data_amount ~= nil) then
				data.circle_data_amount = circle_data_amount
			end

			if(square_data_amount ~= nil) then
				data.square_data_amount = square_data_amount
			end

			if(triangle_data_amount ~= nil) then
				data.triangle_data_amount = triangle_data_amount
			end

			if(plus_data_amount ~= nil) then
				data.plus_data_amount = plus_data_amount
			end

			-- 1

			if(first_number ~= nil) then
				data.first_number = first_number
			end

			if(first_count ~= nil) then
				data.first_count = first_count
			end

			if(first_required ~= nil) then
				data.first_required = first_required
			end

			-- 2

			if(second_number ~= nil) then
				data.second_number = second_number
			end

			if(second_count ~= nil) then
				data.second_count = second_count
			end

			if(second_required ~= nil) then
				data.second_required = second_required
			end

			-- 3
			
			if(third_number ~= nil) then
				data.third_number = third_number
			end

			if(third_count ~= nil) then
				data.third_count = third_count
			end

			if(third_required ~= nil) then
				data.third_required = third_required
			end

			-- 4
			
			if(fourth_number ~= nil) then
				data.fourth_number = fourth_number
			end

			if(fourth_count ~= nil) then
				data.fourth_count = fourth_count
			end

			if(fourth_required ~= nil) then
				data.fourth_required = fourth_required
			end

			data.id = index
			data.condition = condition
			data.limit = limit
			data.amount = limit
			data.uid = uid
			data.order = order
			
			s.init(data)
		end
	end

	total_spawned = total_spawned + 1

	if(total_spawned == total) then
		button.isInteractable = false
	end

	API.Puzzle_Events.trigger("node_total_change")
end

function create_node(x_offset, y_offset)
	if(total_spawned < total or total == -1) then
		local graph = container:FindChildByName("Graph")
		local x = 0
		local y = 0

		x_offset = x_offset or 0
		y_offset = y_offset or 0

		if(graph.x ~= 0) then
			x = -graph.x
		end

		if(graph.y ~= 0) then
			y = -graph.y
		end

		x = x + x_offset
		y = y + y_offset

		spawn_node(x, y, nil)

		if(x_offset == 0 and y_offset == 0) then
			API.play_click_sound()
		end
	end
end

evts[#evts + 1] = button.hoveredEvent:Connect(API.play_hover_sound)
evts[#evts + 1] = button.clickedEvent:Connect(function()
	create_node(0, 0)
end)

evts[#evts + 1] = Events.Connect("disable_available_nodes", function()
	if(Object.IsValid(button)) then
		button.isInteractable = false
	end
end)

evts[#evts + 1] = Events.Connect("enable_available_nodes", function()
	if(not Object.IsValid(button)) then
		return
	end
	
	if(total_spawned < total or total == -1) then
		button.isInteractable = true
	end
end)

evts[#evts + 1] = Events.Connect("spawn_node", function(i, uid, x, y, condition, limit, order)
	if(index == i) then
		spawn_node(x, y, uid, condition, limit, order)
	end
end)

local d_evt = nil

d_evt = script.destroyEvent:Connect(function()
	for k, e in ipairs(evts) do
		if(e.isConnected) then
			e:Disconnect()
		end
	end

	evts = nil

	if(node_destroy_evt ~= nil) then
		API.Node_Events.off(node_destroy_evt)
	end

	if(d_evt.isConnected) then
		d_evt:Disconnect()
	end
end)