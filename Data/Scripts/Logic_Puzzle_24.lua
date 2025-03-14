local API = require(script:GetCustomProperty("API"))

local root = script.parent.parent
local evts = {}
local p_evts = {}

local gold_score = root:GetCustomProperty("gold_score")
local silver_score = root:GetCustomProperty("silver_score")
local bronze_score = root:GetCustomProperty("bronze_score")

local output_ordered_circle_square_complete = false
local output_circle_complete = false
local output_circle_square_complete = 0

local showing_result_ui = false
local total_puzzle_score = 0

p_evts[#p_evts + 1] = API.Puzzle_Events.on("output_circle_complete", function(errors)
	output_circle_complete = true
end)

p_evts[#p_evts + 1] = API.Puzzle_Events.on("output_circle_square_complete", function(errors)
	output_circle_square_complete = output_circle_square_complete + 1
end)

p_evts[#p_evts + 1] = API.Puzzle_Events.on("output_ordered_circle_square_complete", function(errors)
	output_ordered_circle_square_complete =  true
end)

function Tick()
	if(output_circle_square_complete == 2 and output_circle_complete and output_ordered_circle_square_complete) then
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

evts[#evts + 1] = Events.Connect("puzzle_edit", function()
	output_circle_square_complete = 0
	output_circle_complete = false
	output_ordered_circle_square_complete = false
	
	showing_result_ui = false
	total_puzzle_score = 0
end)

evts[#evts + 1] = Events.Connect("score", function(t)
	total_puzzle_score = total_puzzle_score + (t * 100)
end)

local d_evt = nil

d_evt = script.destroyEvent:Connect(function()
	for k, e in ipairs(evts) do
		if(e.isConnected) then
			e:Disconnect()
		end
	end

	evts = nil

	for k, e in ipairs(p_evts) do
		API.Puzzle_Events.off(e)
	end

	if(d_evt.isConnected) then
		d_evt:Disconnect()
	end
end)