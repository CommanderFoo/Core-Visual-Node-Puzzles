local API = require(script:GetCustomProperty("API"))

local root = script.parent.parent

local node = script:GetCustomProperty("node")
local container = script:GetCustomProperty("container"):WaitForObject()
local button = root:FindDescendantByName("Node Handle")
local total = root:GetCustomProperty("total")

local circle_data_amount = root:GetCustomProperty("circle_data_amount")
local square_data_amount = root:GetCustomProperty("square_data_amount")
local triangle_data_amount = root:GetCustomProperty("triangle_data_amount")
local plus_data_amount = root:GetCustomProperty("plus_data_amount")

local first = root:GetCustomProperty("first")
local first_data_amount = root:GetCustomProperty("first_data_amount")
local first_final_total = root:GetCustomProperty("first_final_total")

local required_amount = root:GetCustomProperty("required_amount")

local total_spawned = 0
local template_id = nil
local index = 1

local is_destroyed = false

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

API.Node_Events.on("node_destroyed", function(node_id, tpl_id)
	if(tpl_id == template_id) then
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
	local n = World.SpawnAsset(node, { parent = container })
		
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

			if(first ~= nil) then
				data.first = first
			end

			if(first_data_amount ~= nil) then
				data.first_data_amount =  first_data_amount
			end

			if(first_final_total ~= nil) then
				data.first_final_total =  first_final_total
			end

			data.id = index
			data.condition = condition
			data.limit = limit
			data.uid = uid
			data.order = order
			
			s.init(data)
		end
	end

	template_id = n.sourceTemplateId
	total_spawned = total_spawned + 1

	if(total_spawned == total) then
		button.isInteractable = false
	end

	API.Puzzle_Events.trigger("node_total_change")
end

button.hoveredEvent:Connect(API.play_hover_sound)

button.clickedEvent:Connect(function()
	if(is_destroyed) then
		return
	end
	
	if(total_spawned < total or total == -1) then		
		spawn_node(0, 0, nil)

		API.play_click_sound()
	end
end)

Events.Connect("disable_available_nodes", function()
	if(is_destroyed) then
		return
	end

	if(Object.IsValid(button)) then
		button.isInteractable = false
	end
end)

Events.Connect("enable_available_nodes", function()
	if(is_destroyed) then
		return
	end

	if(not Object.IsValid(button)) then
		return
	end
	
	if(total_spawned < total or total == -1) then
		button.isInteractable = true
	end
end)

Events.Connect("spawn_node", function(i, uid, x, y, condition, limit, order)
	if(is_destroyed) then
		return
	end

	if(index == i) then
		spawn_node(x, y, uid, condition, limit, order)
	end
end)

script.destroyEvent:Connect(function()
	is_destroyed = true
end)