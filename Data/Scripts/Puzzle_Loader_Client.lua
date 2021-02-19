local nodes_container = script:GetCustomProperty("nodes_container"):WaitForObject()
local puzzle_name = script:GetCustomProperty("puzzle_name"):WaitForObject()
local data = script:GetCustomProperty("data"):WaitForObject()

local local_player = Game.GetLocalPlayer()

local puzzles = {}

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

	if(puzzles["puzzle_" .. id]) then
		current_puzzle = World.SpawnAsset(puzzles["puzzle_" .. id], { parent = nodes_container })

		puzzle_name.text = current_puzzle:GetCustomProperty("name")

		Events.Broadcast("time_conditions", {

			gold = current_puzzle:GetCustomProperty("gold_time"),
			silver = current_puzzle:GetCustomProperty("silver_time"),
			bronze = current_puzzle:GetCustomProperty("bronze_time")

		})
	else
		Events.Broadcast("disable_header_ui", true)
		Events.Broadcast("show_welcome")
	end
end

data.networkedPropertyChangedEvent:Connect(function(obj, prop)
	if(prop == "puzzle_id") then
		load_puzzle(data:GetCustomProperty(prop))
	elseif(prop == "show_nodes" and data:GetCustomProperty(prop)) then
		Events.Broadcast("show_nodes")
	elseif(prop == "speed") then
		Events.Broadcast("set_speed", data:GetCustomProperty("speed"))
	end
end)