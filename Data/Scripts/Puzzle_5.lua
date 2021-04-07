local API = require(script:GetCustomProperty("API"))

local root = script.parent.parent
local is_destroyed = false

local gold_score = root:GetCustomProperty("gold_score")
local silver_score = root:GetCustomProperty("silver_score")
local bronze_score = root:GetCustomProperty("bronze_score")

local output_circle_complete = 0

local showing_result_ui = false
local total_puzzle_score = 0

API.Puzzle_Events.on("output_circle_complete", function(errors)
	output_circle_complete = output_circle_complete + 1
end)

function Tick()
	if(output_circle_complete == 2) then
		show_result()
	end
end

function show_result()
	if(not showing_result_ui) then
		showing_result_ui = true

		Events.Broadcast("disable_header_ui", true)
		Events.Broadcast("puzzle_complete")
		Events.Broadcast("show_result", total_puzzle_score, gold_score, silver_score, bronze_score)
	end
end

Events.Connect("puzzle_edit", function()
	if(is_destroyed) then
		return
	end

	output_circle_complete = 0
	showing_result_ui = false
	total_puzzle_score = 0
end)

Events.Connect("score", function(t)
	if(is_destroyed) then
		return
	end

	total_puzzle_score = total_puzzle_score + (t * 100)
end)

script.destroyEvent:Connect(function()
	is_destroyed = true
end)