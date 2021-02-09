local API, YOOTIL = require(script:GetCustomProperty("API"))

local output_red_complete = false
local output_green_complete = false

local showing_result_ui = false

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

		Events.Broadcast("show_result", errors)
		Events.Broadcast("disable_ui")
	end
end

function hide_result()
	showing_result_ui = false
	output_red_complete = false
	output_green_complete = false
	
	Events.Broadcast("hide_result")
	Events.Broadcast("enable_ui")
end

Events.Connect("puzzle_edit", function()
	hide_result()
end)