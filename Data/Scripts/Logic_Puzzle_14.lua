local API = require(script:GetCustomProperty("API"))

local root = script.parent.parent

local gold_score = root:GetCustomProperty("gold_score")
local silver_score = root:GetCustomProperty("silver_score")
local bronze_score = root:GetCustomProperty("bronze_score")

local output_ordered_circle_plus_triangle_complete = false
local output_ordered_plus_square_complete = false

local showing_result_ui = false
local total_puzzle_score = 0

local is_destroyed = false

API.Puzzle_Events.on("output_ordered_circle_plus_triangle_complete", function(errors)
	output_ordered_circle_plus_triangle_complete = true
end)

API.Puzzle_Events.on("output_ordered_plus_square_complete", function(errors)
	output_ordered_plus_square_complete = true
end)

function Tick()
	if(output_ordered_circle_plus_triangle_complete and output_ordered_plus_square_complete) then
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

	output_ordered_circle_plus_triangle_complete = false
	output_ordered_plus_square_complete = false

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