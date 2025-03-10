local API, YOOTIL = require(script:GetCustomProperty("API"))
local Localization = require(script:GetCustomProperty("Localization"))

local title = script:GetCustomProperty("title"):WaitForObject()
local edit_button = script:GetCustomProperty("edit_button"):WaitForObject()
local next_button = script:GetCustomProperty("next_button"):WaitForObject()
local program_score = script:GetCustomProperty("program_score"):WaitForObject()

local gold_award = script:GetCustomProperty("gold_award"):WaitForObject()
local silver_award = script:GetCustomProperty("silver_award"):WaitForObject()
local bronze_award = script:GetCustomProperty("bronze_award"):WaitForObject()

local puzzle_name = script:GetCustomProperty("puzzle_name"):WaitForObject()

local cheer = script:GetCustomProperty("cheer"):WaitForObject()

local local_player = Game.GetLocalPlayer()

Events.Connect("show_result", function(puzzle_score, gold_score, silver_score, bronze_score, finished)
	Events.Broadcast("disable_graph_panning")
	Events.Broadcast("pause")
	Events.Broadcast("stop_auto_save")

	title.text = Localization.get_text("Well_Done")

	if(not finished) then
		next_button.isInteractable = true
	else
		next_button.isInteractable = false
		title.text = Localization.get_text("Well_Done_Complete")	
	end

	local score = 20000 - math.floor(((puzzle_score / 4) + ((API.get_total_nodes(true) - 2) * 25)))

	program_score.text = string.format("%s: %.0f", Localization.get_text("Puzzle_Score"), score)

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

	Events.Broadcast("add_log_message", puzzle_name.text .. " " .. Localization.get_text("Score") .. ": " .. YOOTIL.Utils.number_format(score), "Puzzle Info", false)

	local award = 0

	if(score >= gold_score) then
		API.set_award(gold_award, 1)
		API.set_award(silver_award, .1)
		API.set_award(bronze_award, .1)

		award = 3
	elseif(score >= silver_score) then
		API.set_award(gold_award, .1)
		API.set_award(silver_award, 1)
		API.set_award(bronze_award, .1)
		
		award = 2
	elseif(score >= bronze_score) then
		API.set_award(gold_award, .1)
		API.set_award(silver_award, .1)
		API.set_award(bronze_award, 1)

		award = 1
	else
		API.set_award(gold_award, .1)
		API.set_award(silver_award, .1)
		API.set_award(bronze_award, .1)

		next_button.isInteractable = false
		title.text = Localization.get_text("Try_Again")
	end

	if(award > 0) then
		cheer:Play()
	
		local current_puzzle = 1
		local is_logic = local_player.clientUserData.logic

		if(is_logic) then
			current_puzzle = local_player:GetResource("current_logic_puzzle")
		else
			current_puzzle = local_player:GetResource("current_math_puzzle")
		end

		Events.Broadcast("save")
		YOOTIL.Events.broadcast_to_server("save_puzzle_completed", award, score, is_logic, current_puzzle)
	end

	script.parent.parent.visibility = Visibility.FORCE_ON
end)

Events.Connect("hide_result", function()
	script.parent.parent.visibility = Visibility.FORCE_OFF
end)

edit_button.hoveredEvent:Connect(API.play_hover_sound)

edit_button.clickedEvent:Connect(function()
	Events.Broadcast("unpause")
	Events.Broadcast("puzzle_edit")
	Events.Broadcast("enable_graph_panning")
	script.parent.parent.visibility = Visibility.FORCE_OFF

	API.play_click_sound()
end)

next_button.hoveredEvent:Connect(API.play_hover_sound)

next_button.clickedEvent:Connect(function()
	API.clear_graph()
	API.play_click_sound()

	script.parent.parent.visibility = Visibility.FORCE_OFF
	next_button.isInteractable = false

	Events.Broadcast("clear_puzzle")
	
	local current_puzzle = 1
	local is_logic = local_player.clientUserData.logic

	if(is_logic) then
		current_puzzle = local_player:GetResource("current_logic_puzzle")
	else
		current_puzzle = local_player:GetResource("current_math_puzzle")
	end
	
	YOOTIL.Events.broadcast_to_server("save_puzzle_progress", current_puzzle + 1, is_logic)
		
	Events.Broadcast("start_auto_save")

	if(is_logic) then
		Events.Broadcast("load_logic_puzzle", current_puzzle + 1, true)
	else
		Events.Broadcast("load_math_puzzle", current_puzzle + 1, true)
	end

	Events.Broadcast("puzzle_edit")
	Events.Broadcast("show_nodes")
end)