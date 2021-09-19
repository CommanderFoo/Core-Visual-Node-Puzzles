local YOOTIL = require(script:GetCustomProperty("YOOTIL"))
local Localization = require(script:GetCustomProperty("Localization"))

local nodes_panel = script:GetCustomProperty("nodes_panel"):WaitForObject()
local show_hide_nodes_button = script:GetCustomProperty("show_hide_nodes_button"):WaitForObject()
local dummy_data_node = script:GetCustomProperty("dummy_data_node"):WaitForObject()
local dummy_output_node = script:GetCustomProperty("dummy_output_node"):WaitForObject()
local line = script:GetCustomProperty("line"):WaitForObject()

local tips = {

	script:GetCustomProperty("welcome"):WaitForObject(),
	script:GetCustomProperty("main_menu"):WaitForObject(),
	script:GetCustomProperty("awards"):WaitForObject(),
	script:GetCustomProperty("speed"):WaitForObject(),
	script:GetCustomProperty("run"):WaitForObject(),
	script:GetCustomProperty("show_nodes"):WaitForObject(),
	script:GetCustomProperty("save"):WaitForObject(),
	script:GetCustomProperty("center_graph"):WaitForObject(),
	script:GetCustomProperty("clear"):WaitForObject(),
	script:GetCustomProperty("nodes"):WaitForObject(),
	script:GetCustomProperty("data_node"):WaitForObject(),
	script:GetCustomProperty("data_node_2"):WaitForObject(),
	script:GetCustomProperty("output_node"):WaitForObject()

}

local panel_tween = nil
local node_tween = nil
local node_tween_2 = nil

local in_duration = .5
local out_duration = .4

local current_index = 0

function reset()
	if(tips[current_index] ~= nil) then
		tips[current_index].visibility = Visibility.FORCE_ON
		tips[current_index].opacity = 0

		if(tips[current_index]:FindChildByName("Next") ~= nil) then
			tips[current_index]:FindChildByName("Next").isInteractable = false
		end
	end
end

function change(v)
	if(tips[current_index] ~= nil) then
		tips[current_index].opacity = v.a
	end
end

function in_complete()
	panel_tween = nil
	
	if(tips[current_index] ~= nil and tips[current_index]:FindChildByName("Next") ~= nil) then
		tips[current_index]:FindChildByName("Next").isInteractable = true
	end
end

function out_complete()
	if(tips[current_index] ~= nil) then
		tips[current_index].visibility = Visibility.FORCE_OFF
	end

	panel_tween = nil
end

function bind_next(next_panel)
	if(tips[current_index] ~= nil) then
		if(tips[current_index]:FindChildByName("Next") ~= nil) then
			tips[current_index]:FindChildByName("Next").clickedEvent:Connect(function()
				tips[current_index]:FindChildByName("Next").isInteractable = false
				fade_in()
			end)
		end

		tips[current_index]:FindChildByName("Exit").clickedEvent:Connect(function()	
			Events.Broadcast("transition_in", function()
				script.parent:Destroy()
				Events.Broadcast("show_main_menu")
			end)
		end)
	end
end

function fade_out()
	if(current_index > 0) then
		panel_tween = YOOTIL.Tween:new(out_duration, { a = 1 }, { a = 0 })

		panel_tween:on_change(change)
		panel_tween:on_complete(out_complete)

		Task.Wait(.5)
	end
end

function fade_in()
	fade_out()

	current_index = current_index + 1
	
	if(current_index == 10) then
		show_nodes()
	elseif(current_index == 11) then
		show_data_node()
	elseif(current_index == 13) then
		show_output_node()
		show_line()
	end

	panel_tween = YOOTIL.Tween:new(in_duration, { a = 0 }, { a = 1 })

	bind_next()

	panel_tween:on_start(reset)
	panel_tween:on_change(change)
	panel_tween:on_complete(in_complete)
end

function init()
	fade_in()
end

function show_nodes()
	show_hide_nodes_button.text = Localization.get_text("Tutorial_Hide_Nodes_Button")
	node_tween = YOOTIL.Tween:new(.3, {v = nodes_panel.x}, {v = -20})

	node_tween:on_complete(function()
		node_tween = nil
	end)

	node_tween:set_easing("inOutBack")

	node_tween:on_change(function(changed)
		nodes_panel.x = changed.v
	end)
end

function show_data_node()
	node_tween = YOOTIL.Tween:new(.4, { v = 0 }, { v = 1 })

	node_tween:on_complete(function()
		node_tween = nil
	end)

	node_tween:on_start(function()
		dummy_data_node.visibility = Visibility.FORCE_ON
	end)

	node_tween:on_change(function(c)
		dummy_data_node.opacity = c.v
	end)
end

function show_line()
	node_tween_2 = YOOTIL.Tween:new(.4, { v = 0 }, { v = 1 })

	node_tween_2:on_complete(function()
		node_tween_2 = nil
	end)

	node_tween_2:on_change(function(c)
		local col = line:GetColor()

		col.a = c.v

		line:SetColor(col)
	end)
end

function show_output_node()
	node_tween = YOOTIL.Tween:new(.4, { v = 0 }, { v = 1 })

	node_tween:on_complete(function()
		node_tween = nil
	end)

	node_tween:on_start(function()
		dummy_output_node.visibility = Visibility.FORCE_ON
	end)

	node_tween:on_change(function(c)
		dummy_output_node.opacity = c.v
	end)
end

function Tick(dt)
	if(panel_tween ~= nil) then
		panel_tween:tween(dt)
	end

	if(node_tween ~= nil) then
		node_tween:tween(dt)
	end

	if(node_tween_2 ~= nil) then
		node_tween_2:tween(dt)
	end
end

Events.Broadcast("translate_tutorial")

local start_evt = Events.Connect("start_tutorial", init)
local d_evt = nil

d_evt = script.destroyEvent:Connect(function()
	if(start_evt.isConnected) then
		start_evt:Disconnect()
	end

	if(d_evt.isConnected) then
		d_evt:Disconnect()
	end
end)