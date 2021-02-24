local API, YOOTIL = require(script:GetCustomProperty("API"))

local node = script:GetCustomProperty("node")
local container = script:GetCustomProperty("container"):WaitForObject()
local button = script.parent.parent:FindDescendantByName("Node Handle")
local total = script:GetCustomProperty("total")
local total_count = script:GetCustomProperty("total_count"):WaitForObject()

local total_spawned = 0
local template_id = nil

total_count.text = tostring(total)

API.Node_Events.on("node_destroyed", function(node_id, tpl_id)
	if(tpl_id == template_id) then
		total_spawned = total_spawned - 1
		total_count.text = tostring(total - total_spawned)

		if(total_spawned < total) then
			button.isInteractable = true
		end

		API.Puzzle_Events.trigger("node_total_change")
	end
end)

button.hoveredEvent:Connect(API.play_hover_sound)

button.clickedEvent:Connect(function()
	if(total_spawned < total) then		
		local n = World.SpawnAsset(node, { parent = container })
		
		template_id = n.sourceTemplateId
		total_spawned = total_spawned + 1
		total_count.text = tostring(total - total_spawned)

		if(total_spawned == total) then
			button.isInteractable = false
		end

		API.Puzzle_Events.trigger("node_total_change")
		API.play_click_sound()
	end
end)

Events.Connect("disable_available_nodes", function()
	button.isInteractable = false
end)

Events.Connect("enable_available_nodes", function()
	if(total_spawned < total) then
		button.isInteractable = true
	end
end)