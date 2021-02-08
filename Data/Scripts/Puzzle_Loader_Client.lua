local nodes_container = script:GetCustomProperty("nodes_container"):WaitForObject()
local puzzle_name = script:GetCustomProperty("puzzle_name"):WaitForObject()
local data = script:GetCustomProperty("data"):WaitForObject()

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
	else
		print("No puzzle")
	end
end

data.networkedPropertyChangedEvent:Connect(function(obj, prop)
	if(prop == "puzzle_id") then
		load_puzzle(data:GetCustomProperty(prop))
	end
end)