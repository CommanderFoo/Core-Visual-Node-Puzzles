local ui_container = script:GetCustomProperty("ui_container"):WaitForObject()

local puzzles = {}

for p, v in pairs(script:GetCustomProperties()) do
	if(p ~= "ui_container") then
		puzzles[p] = v
	end
end

local current_puzzle = nil

function load_puzzle(id)
	if(current_puzzle ~= nil and Object.IsValid(current_puzzle)) then
		current_puzzle:Destroy()
	end

	if(puzzles["puzzle_" .. id]) then
		current_puzzle = World.SpawnAsset(puzzles["puzzle_" .. id], { parent = ui_container })
	else
		print("No puzzle")
	end
end

--Events.Connect("puzzle_load", load_puzzle)