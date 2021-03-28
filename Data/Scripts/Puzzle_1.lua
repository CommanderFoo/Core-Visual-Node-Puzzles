local API, YOOTIL = require(script:GetCustomProperty("API"))

local root = script.parent.parent

local gold_time = root:GetCustomProperty("gold_time")
local silver_time = root:GetCustomProperty("silver_time")
local bronze_time = root:GetCustomProperty("bronze_time")

local output_circle_complete = false

local showing_result_ui = false
local total_puzzle_score = 0

local is_destroyed = false

API.Puzzle_Events.on("output_circle_complete", function(errors)
	output_circle_complete = true
end)

function Tick()
	if(output_circle_complete) then
		show_result()
	end
end

function show_result()
	if(not showing_result_ui) then
		showing_result_ui = true

		Events.Broadcast("disable_header_ui", true)
		Events.Broadcast("puzzle_complete")
		Events.Broadcast("show_result", total_puzzle_score, gold_time, silver_time, bronze_time)
	end
end

Events.Connect("puzzle_edit", function()
	if(is_destroyed) then
		return
	end

	output_circle_complete = false
	showing_result_ui = false
	total_puzzle_time = 0
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