local API, YOOTIL = require(script:GetCustomProperty("API"))

local root = script.parent.parent

local node = script:GetCustomProperty("node")
local container = script:GetCustomProperty("container"):WaitForObject()
local button = root:FindDescendantByName("Node Handle")
local total = root:GetCustomProperty("total")
local total_count = root:FindDescendantByName("Total")

local circle_data_amount = root:GetCustomProperty("circle_data_amount")
local square_data_amount = root:GetCustomProperty("square_data_amount")
local triangle_data_amount = root:GetCustomProperty("triangle_data_amount")
local plus_data_amount = root:GetCustomProperty("plus_data_amount")

local required_amount = root:GetCustomProperty("required_amount")

local total_spawned = 0
local template_id = nil

if(total == -1) then
	total_count.text = "∞"
else
	total_count.text = tostring(total)
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
			total_count.text = tostring(total - total_spawned)

			if(total_spawned < total) then
				button.isInteractable = true
			end
		end

		API.Puzzle_Events.trigger("node_total_change")
	end
end)

button.hoveredEvent:Connect(API.play_hover_sound)

button.clickedEvent:Connect(function()
	if(total_spawned < total or total == -1) then		
		local n = World.SpawnAsset(node, { parent = container })
		
		n.x = 0
		n.y = 0

		local s = find_node_script(n)
		
		if(s ~= nil and s.init ~= nil) then
			local data_amounts = {}

			if(circle_data_amount ~= nil) then
				data_amounts.circle_data_amount = circle_data_amount
			end

			if(square_data_amount ~= nil) then
				data_amounts.square_data_amount = square_data_amount
			end

			if(triangle_data_amount ~= nil) then
				data_amounts.triangle_data_amount = triangle_data_amount
			end

			if(plus_data_amount ~= nil) then
				data_amounts.plus_data_amount = plus_data_amount
			end

			s.init(data_amounts)
		end

		template_id = n.sourceTemplateId
		total_spawned = total_spawned + 1

		if(total ~= -1) then
			total_count.text = tostring(total - total_spawned)
		end

		if(total_spawned == total) then
			button.isInteractable = false
		end

		API.Puzzle_Events.trigger("node_total_change")
		API.play_click_sound()
	end
end)

Events.Connect("disable_available_nodes", function()
	if(Object.IsValid(button)) then
		button.isInteractable = false
	end
end)

Events.Connect("enable_available_nodes", function()
	if(total_spawned < total and Object.IsValid(button) or total == -1) then
		button.isInteractable = true
	end
end)