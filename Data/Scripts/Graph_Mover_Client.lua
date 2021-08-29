local YOOTIL = require(script:GetCustomProperty("YOOTIL"))
local graph = script:GetCustomProperty("graph"):WaitForObject()
local local_player = Game.GetLocalPlayer()

local can_move = false
local is_moving = false
local offset = Vector2.ZERO
local tween

local_player.bindingPressedEvent:Connect(function(_, binding)
	if(binding == "ability_secondary") then
		local pos = UI.GetCursorPosition()

		offset.x = pos.x - graph.x
		offset.y = pos.y - graph.y

		is_moving = true
	elseif(binding == "ability_extra_33" and can_move and (graph.x ~= 0 or graph.y ~= 0)) then
		tween = YOOTIL.Tween:new(.3, { x = graph.x, y = graph.y }, { x = 0, y = 0 })
		
		tween:on_change(function(c)
			graph.x = c.x
			graph.y = c.y
		end)

		tween:on_complete(function()
			tween = nil
		end)

		tween:set_easing("outCirc")
	end
end)

local_player.bindingReleasedEvent:Connect(function(_, binding)
	if(binding == "ability_secondary") then
		is_moving = false
	end
end)

function Tick(dt)
	if(can_move and is_moving and tween == nil) then
		local pos = UI.GetCursorPosition()
		local screen = UI.GetScreenSize()

		graph.x = pos.x - offset.x
		graph.y = pos.y - offset.y

		if(graph.x < -1500) then
			graph.x = -1500
		end
			
		if(graph.x > 1500) then
			graph.x = 1500
		end

		if(graph.y < -1500) then
			graph.y = -1500
		end
			
		if(graph.y > 1500) then
			graph.y = 1500
		end
	elseif(tween ~= nil) then
		tween:tween(dt)
	end
end

Events.Connect("enable_graph_mover", function()
	can_move = true
end)

Events.Connect("disable_graph_mover", function()
	can_move = false
end)

Events.Connect("reset_graph", function()
	graph.x = 0
	graph.y = 0
end)