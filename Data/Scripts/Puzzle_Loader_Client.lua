local nodes_container = script:GetCustomProperty("nodes_container"):WaitForObject()
local puzzle_name = script:GetCustomProperty("puzzle_name"):WaitForObject()
local data = script:GetCustomProperty("data"):WaitForObject()
local tutorial_container = script:GetCustomProperty("tutorial_container"):WaitForObject()
local loading = script:GetCustomProperty("loading"):WaitForObject()

local local_player = Game.GetLocalPlayer()

local puzzles = {}

local sfx_slider_updated = false
local music_slider_updated = false

for p, v in pairs(script:GetCustomProperties()) do
	if(p ~= "nodes_container") then
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

		Events.Broadcast("time_conditions", {

			gold = current_puzzle:GetCustomProperty("gold_time"),
			silver = current_puzzle:GetCustomProperty("silver_time"),
			bronze = current_puzzle:GetCustomProperty("bronze_time")

		})

		Events.Broadcast("enable_header_ui")
	else
		Events.Broadcast("disable_header_ui", true)
	end
end

Events.Connect("load_puzzle", load_puzzle)