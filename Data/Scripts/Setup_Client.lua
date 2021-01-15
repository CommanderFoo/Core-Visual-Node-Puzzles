local reset = script:GetCustomProperty("reset"):WaitForObject()
local local_player = Game.GetLocalPlayer()

local propContainer = script:GetCustomProperty("container"):WaitForObject()
local propApples2DataNode = script:GetCustomProperty("Apples2DataNode")
local propIfElseAppleNode = script:GetCustomProperty("IfElseAppleNode")
local propRedAppleOutputNode = script:GetCustomProperty("RedAppleOutputNode")
local propGreenAppleOuputNode = script:GetCustomProperty("GreenAppleOuputNode")

local a, b, c, d = nil

Game.playerJoinedEvent:Connect(function()
	UI.SetCursorVisible(true)
	UI.SetCanCursorInteractWithUI(true)
end)

reset.pressedEvent:Connect(function()
	a:Destroy()
	b:Destroy()
	c:Destroy()
	d:Destroy()

	spawn_nodes()
end)

function spawn_nodes()
	a = World.SpawnAsset(propApples2DataNode, {parent = propContainer})
	b = World.SpawnAsset(propIfElseAppleNode, {parent = propContainer})
	c = World.SpawnAsset(propRedAppleOutputNode, {parent = propContainer})
	d = World.SpawnAsset(propGreenAppleOuputNode, {parent = propContainer})
end

spawn_nodes()