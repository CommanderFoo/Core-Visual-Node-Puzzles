local API, YOOTIL = require(script:GetCustomProperty("API"))

local output_red_complete = false
local output_green_complete = false

local showing_result_ui = false

local gold_time = 11
local silver_time = 14

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
		Events.Broadcast("show_result", errors)
	end
end

Events.Connect("puzzle_edit", function()
	output_red_complete = false
	output_green_complete = false
	showing_result_ui = false
end)