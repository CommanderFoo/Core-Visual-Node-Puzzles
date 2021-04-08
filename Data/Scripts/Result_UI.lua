local API, YOOTIL = require(script:GetCustomProperty("API"))

local title = script:GetCustomProperty("title"):WaitForObject()
local edit_button = script:GetCustomProperty("edit_button"):WaitForObject()
local next_button = script:GetCustomProperty("next_button"):WaitForObject()
local program_score = script:GetCustomProperty("program_score"):WaitForObject()
local available_nodes = script:GetCustomProperty("available_nodes"):WaitForObject()

local gold_award = script:GetCustomProperty("gold_award"):WaitForObject()
local silver_award = script:GetCustomProperty("silver_award"):WaitForObject()
local bronze_award = script:GetCustomProperty("bronze_award"):WaitForObject()

local gold_color = gold_award:GetColor()
local silver_color = silver_award:GetColor()
local bronze_color = bronze_award:GetColor()

local floor = math.floor

Events.Connect("show_result", function(puzzle_score, gold_score, silver_score, bronze_score)
	Events.Broadcast("stop_auto_save")

	next_button.isInteractable = true
	title.text = "Well Done!"
	
	local score = math.max(0, 10000 - math.floor(((puzzle_score / 4) + ((API.get_total_nodes() - 2) * 25))))

	program_score.text = string.format("Program Score: %.0f", score)

	gold_award:GetChildren()[1].text = string.format("%.0f", gold_score)

	if(silver_score == -1) then
		silver_award:GetChildren()[1].text = "---"
	else
		silver_award:GetChildren()[1].text = string.format("%.0f", silver_score)
	end

	if(bronze_score == -1) then
		bronze_award:GetChildren()[1].text = "---"
	else
		bronze_award:GetChildren()[1].text = string.format("%.0f", bronze_score)
	end

	if(score >= gold_score) then
		API.set_award(gold_award, 1)
		API.set_award(silver_award, .1)
		API.set_award(bronze_award, .1)
	elseif(score >= silver_score) then
		API.set_award(gold_award, .1)
		API.set_award(silver_award, 1)
		API.set_award(bronze_award, .1)
	elseif(score >= bronze_score) then
		API.set_award(gold_award, .1)
		API.set_award(silver_award, .1)
		API.set_award(bronze_award, 1)
	else
		API.set_award(gold_award, .1)
		API.set_award(silver_award, .1)
		API.set_award(bronze_award, .1)

		--next_button.isInteractable = false
		title.text = "Try Again"
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

function find_active_puzzle()
	local children = available_nodes:GetChildren()

	for k, v in pairs(children) do
		local id = string.match(v.name, "Puzzle (%d+)")
	
		if(id) then
			return v, id
		end
	end

	return nil
end

next_button.hoveredEvent:Connect(API.play_hover_sound)

next_button.clickedEvent:Connect(function()
	API.clear_graph()

	local active_puzzle, id = find_active_puzzle()

	API.play_click_sound()

	script.parent.parent.visibility = Visibility.FORCE_OFF
	next_button.isInteractable = false

	if(active_puzzle and id) then
		active_puzzle:Destroy()

		YOOTIL.Events.broadcast_to_server("save_puzzle_progress", tonumber(id) + 1)
		
		Events.Broadcast("start_auto_save")
		Events.Broadcast("load_puzzle", tonumber(id) + 1)
	end

	Events.Broadcast("puzzle_edit")
end)