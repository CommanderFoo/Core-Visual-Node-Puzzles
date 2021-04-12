local API, YOOTIL = require(script:GetCustomProperty("API"))

local nodes_container = script:GetCustomProperty("nodes_container"):WaitForObject()
local puzzle_name = script:GetCustomProperty("puzzle_name"):WaitForObject()
local data = script:GetCustomProperty("data"):WaitForObject()
local loading = script:GetCustomProperty("loading"):WaitForObject()

local logic_puzzles_data = script:GetCustomProperty("logic_puzzles_data"):WaitForObject()
local math_puzzles_data = script:GetCustomProperty("math_puzzles_data"):WaitForObject()

local local_player = Game.GetLocalPlayer()

local logic_puzzles = {}
local math_puzzles = {}

local sfx_slider_updated = false
local music_slider_updated = false

for i, p in pairs(logic_puzzles_data:GetCustomProperties()) do
	local name, id = CoreString.Split(i, "LogicPuzzle")

	logic_puzzles[math.floor(tonumber(id))] = p
end

for i, p in pairs(math_puzzles_data:GetCustomProperties()) do
	local name, id = CoreString.Split(i, "MathPuzzle")

	math_puzzles[math.floor(tonumber(id))] = p
end

local current_puzzle = nil

function load_puzzle(id, logic)
	local the_puzzles = logic_puzzles

	if(not logic) then
		the_puzzles = math_puzzles
	end

	if(current_puzzle ~= nil and Object.IsValid(current_puzzle)) then
		current_puzzle:Destroy()
	end

	if(the_puzzles[id]) then
		current_puzzle = World.SpawnAsset(the_puzzles[id], { parent = nodes_container })

		puzzle_name.text = current_puzzle:GetCustomProperty("name")

		Events.Broadcast("score_conditions", {

			gold = current_puzzle:GetCustomProperty("gold_score"),
			silver = current_puzzle:GetCustomProperty("silver_score"),
			bronze = current_puzzle:GetCustomProperty("bronze_score")

		})

		Events.Broadcast("enable_header_ui")
	else
		Events.Broadcast("disable_header_ui", true)
	end
end

function load_logic_puzzle(id)
	load_puzzle(id, true)
end

function load_math_puzzle(id)
	load_puzzle(id, false)
end

function clear_puzzle()
	if(current_puzzle ~= nil) then
		API.clear_graph()
		current_puzzle:Destroy()
		current_puzzle = nil
	end
end

Events.Connect("load_logic_puzzle", load_logic_puzzle)
Events.Connect("load_math_puzzle", load_math_puzzle)
Events.Connect("clear_puzzle", clear_puzzle)