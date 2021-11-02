local YOOTIL = require(script:GetCustomProperty("YOOTIL"))
local graph = script:GetCustomProperty("graph"):WaitForObject()
local local_player = Game.GetLocalPlayer()

local can_move = false
local is_moving = false
local offset = Vector2.ZERO
local tween = nil

local function tween_graph()
	if(can_move and (graph.x ~= 0 or graph.y ~= 0)) then
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
end

Input.actionPressedEvent:Connect(function(player, action)
	if(action == "Pan Graph") then
		local pos = UI.GetCursorPosition()

		offset.x = pos.x - graph.x
		offset.y = pos.y - graph.y

		is_moving = true
	elseif(action == "Center Graph") then
		tween_graph()
	end
end)

Input.actionReleasedEvent:Connect(function(player, action)
	if(action == "Pan Graph") then
		is_moving = false
	end
end)

function Tick(dt)
	if(can_move and is_moving and tween == nil) then
		local pos = UI.GetCursorPosition()

		graph.x = pos.x - offset.x
		graph.y = pos.y - offset.y

		if(graph.x < -3000) then
			graph.x = -3000
		end
			
		if(graph.x > 3000) then
			graph.x = 3000
		end

		if(graph.y < -3000) then
			graph.y = -3000
		end
			
		if(graph.y > 3000) then
			graph.y = 3000
		end
	elseif(tween ~= nil) then
		tween:tween(dt)
	elseif(can_move) then
		local speed = 1

		-- if(Input.IsActionHeld(local_player, "Pan Graph Faster")) then
		-- 	speed = 4
		-- end

		-- if(Input.IsActionHeld(local_player, "Pan Up") and graph.y < 3000) then
		-- 	graph.y = graph.y + 4 * speed
		-- elseif(Input.IsActionHeld(local_player, "Pan Down") and graph.y > -3000) then
		-- 	graph.y = graph.y - 4 * speed
		-- end

		-- if(Input.IsActionHeld(local_player, "Pan Left") and graph.x < 3000) then
		-- 	graph.x = graph.x + 4 * speed
		-- elseif(Input.IsActionHeld(local_player, "Pan Right") and graph.x > -3000) then
		-- 	graph.x = graph.x - 4 * speed
		-- end
	end
end

Events.Connect("enable_graph_panning", function()
	can_move = true
end)

Events.Connect("disable_graph_panning", function()
	can_move = false
end)

Events.Connect("reset_graph", function(do_tween)
	if(do_tween) then
		tween_graph()
	else
		graph.x = 0
		graph.y = 0
	end
end)