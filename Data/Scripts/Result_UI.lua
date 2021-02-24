local API, YOOTIL = require(script:GetCustomProperty("API"))

local title = script:GetCustomProperty("title"):WaitForObject()
local edit_button = script:GetCustomProperty("edit_button"):WaitForObject()
local next_button = script:GetCustomProperty("next_button"):WaitForObject()

local gold_award = script:GetCustomProperty("gold_award"):WaitForObject()
local silver_award = script:GetCustomProperty("silver_award"):WaitForObject()
local bronze_award = script:GetCustomProperty("bronze_award"):WaitForObject()

local gold_color = gold_award:GetColor()
local silver_color = silver_award:GetColor()
local bronze_color = bronze_award:GetColor()

local floor = math.floor

Events.Connect("show_result", function(puzzle_time, gold_time, silver_time, bronze_time)
	next_button.isInteractable = true

	if(floor(puzzle_time) <= gold_time) then
		API.set_award(gold_award, 1)
		API.set_award(silver_award, .2)
		API.set_award(bronze_award, .2)
	elseif(floor(puzzle_time) <= silver_time) then
		API.set_award(gold_award, .2)
		API.set_award(silver_award, 1)
		API.set_award(bronze_award, .2)
	else
		API.set_award(gold_award, .2)
		API.set_award(silver_award, .2)
		API.set_award(bronze_award, 1)
	end

	script.parent.parent.visibility = Visibility.FORCE_ON
end)

Events.Connect("hide_result", function()
	script.parent.parent.visibility = Visibility.FORCE_OFF
end)

edit_button.hoveredEvent:Connect(API.play_hover_sound)

edit_button.clickedEvent:Connect(function()
	Events.Broadcast("puzzle_edit")
	script.parent.parent.visibility = Visibility.FORCE_OFF

	API.play_click_sound()
end)

next_button.hoveredEvent:Connect(API.play_hover_sound)

next_button.clickedEvent:Connect(function()
	API.clear_graph()

	Events.Broadcast("puzzle_edit")
	API.play_click_sound()
	
	script.parent.parent.visibility = Visibility.FORCE_OFF
	next_button.isInteractable = false
end)