local API, YOOTIL = require(script:GetCustomProperty("API"))

local root = script.parent.parent

local gold_time = root:GetCustomProperty("gold_time")
local silver_time = root:GetCustomProperty("silver_time")
local bronze_time = root:GetCustomProperty("bronze_time")

local output_red_complete = false
local output_green_complete = false

local showing_result_ui = false
local total_puzzle_time = 0

API.Puzzle_Events.on("output_red_complete", function(errors)
	output_red_complete = true
end)

API.Puzzle_Events.on("output_green_complete", function(errors)
	output_green_complete = true
end)

function Tick()
	if(output_red_complete and output_green_complete) then
		show_result()
	end
end

function show_result()
	if(not showing_result_ui) then
		showing_result_ui = true

		Events.Broadcast("disable_header_ui", true)
		Events.Broadcast("puzzle_complete")
		Events.Broadcast("show_result", total_puzzle_time, gold_time, silver_time, bronze_time)
	end
end

Events.Connect("puzzle_edit", function()
	output_red_complete = false
	output_green_complete = false
	showing_result_ui = false
	total_puzzle_time = 0
end)

Events.Connect("timer", function(t)
	total_puzzle_time = total_puzzle_time + t
end)