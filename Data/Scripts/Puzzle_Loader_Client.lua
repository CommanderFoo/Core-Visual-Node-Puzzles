local API, YOOTIL = require(script:GetCustomProperty("API"))

local nodes_container = script:GetCustomProperty("nodes_container"):WaitForObject()
local puzzle_name = script:GetCustomProperty("puzzle_name"):WaitForObject()
local data = script:GetCustomProperty("data"):WaitForObject()
local loading = script:GetCustomProperty("loading"):WaitForObject()

local local_player = Game.GetLocalPlayer()

local puzzles = {}

local sfx_slider_updated = false
local music_slider_updated = false

for p, v in pairs(script:GetCustomProperties()) do
	if(string.find(p, "puzzle_")) then
		puzzles[p] = v
	end
end

local current_puzzle = nil

function load_puzzle(id)
	if(current_puzzle ~= nil and Object.IsValid(current_puzzle)) then
		current_puzzle:Destroy()
	end

	if(puzzles["puzzle_" .. tostring(id)]) then
		current_puzzle = World.SpawnAsset(puzzles["puzzle_" .. tostring(id)], { parent = nodes_container })

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

function clear_puzzle()
	if(current_puzzle ~= nil) then
		API.clear_graph()
		current_puzzle:Destroy()
	end
end

Events.Connect("load_puzzle", load_puzzle)
Events.Connect("clear_puzzle", clear_puzzle)