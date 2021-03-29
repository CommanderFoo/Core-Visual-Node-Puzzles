local API, YOOTIL = require(script:GetCustomProperty("API"))

local root = script.parent.parent

local node = script:GetCustomProperty("node")
local container = script:GetCustomProperty("container"):WaitForObject()
local button = root:FindDescendantByName("Node Handle")
local total = root:GetCustomProperty("total")
local total_count = root:FindDescendantByName("Total")

local total_spawned = 0
local template_id = nil

if(total ~= -1) then
	total_count.text = tostring(total)
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