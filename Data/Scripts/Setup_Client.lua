local reset = script:GetCustomProperty("reset"):WaitForObject()
local local_player = Game.GetLocalPlayer()

local propContainer = script:GetCustomProperty("container"):WaitForObject()
local puzzle = script:GetCustomProperty("puzzle")

local a = nil

Game.playerJoinedEvent:Connect(function()
	UI.SetCursorVisible(true)
	UI.SetCanCursorInteractWithUI(true)
end)

reset.pressedEvent:Connect(function()
	a:Destroy()
	
	spawn_nodes()
end)

function spawn_nodes()
	a = World.SpawnAsset(puzzle, {parent = propContainer})
	
end

spawn_nodes()