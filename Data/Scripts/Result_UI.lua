local API, YOOTIL = require(script:GetCustomProperty("API"))

local title = script:GetCustomProperty("title"):WaitForObject()
local edit_button = script:GetCustomProperty("edit_button"):WaitForObject()
local next_button = script:GetCustomProperty("next_button"):WaitForObject()
local program_time = script:GetCustomProperty("program_time"):WaitForObject()

local gold_award = script:GetCustomProperty("gold_award"):WaitForObject()
local silver_award = script:GetCustomProperty("silver_award"):WaitForObject()
local bronze_award = script:GetCustomProperty("bronze_award"):WaitForObject()

local gold_color = gold_award:GetColor()
local silver_color = silver_award:GetColor()
local bronze_color = bronze_award:GetColor()

local floor = math.floor

Events.Connect("show_result", function(puzzle_time, gold_time, silver_time, bronze_time)
	next_button.isInteractable = true

	program_time.text = string.format("Program Time: %.2f Seconds", puzzle_time)

	gold_award:GetChildren()[1].text = string.format("%.2f", gold_time)
	silver_award:GetChildren()[1].text = string.format("%.2f", silver_color)
	bronze_award:GetChildren()[1].text = string.format("%.2f", bronze_color)

	if(floor(puzzle_time) <= gold_time) then
		API.set_award(gold_award, 1)
		API.set_award(silver_award, .1)
		API.set_award(bronze_award, .1)
	elseif(floor(puzzle_time) <= silver_time) then
		API.set_award(gold_award, .1)
		API.set_award(silver_award, 1)
		API.set_award(bronze_award, .1)
	else
		API.set_award(gold_award, .1)
		API.set_award(silver_award, .1)
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

-- @TODO: Clear currently loaded puzzle in available nodes panel
-- Call load_puzzle broadcast with the next puzzle id

next_button.clickedEvent:Connect(function()
	API.clear_graph()

	Events.Broadcast("puzzle_edit")
	API.play_click_sound()
	
	script.parent.parent.visibility = Visibility.FORCE_OFF
	next_button.isInteractable = false
end)