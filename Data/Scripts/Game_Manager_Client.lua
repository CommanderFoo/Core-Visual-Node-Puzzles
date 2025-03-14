local YOOTIL = require(script:GetCustomProperty("YOOTIL"))

local base_ui = script:GetCustomProperty("base_ui"):WaitForObject()
local node_ui = script:GetCustomProperty("node_ui"):WaitForObject()
local top_ui = script:GetCustomProperty("top_ui"):WaitForObject()

local local_player = Game.GetLocalPlayer()

Events.Connect("load_game", function(math, logic_id, math_id)
	if(math) then
		local_player.clientUserData.logic = false
	else
		local_player.clientUserData.logic = true
	end

	base_ui.visibility = Visibility.FORCE_ON
	node_ui.visibility = Visibility.FORCE_ON
	top_ui.visibility = Visibility.FORCE_ON

	Events.Broadcast("stop_menu_music")
	
	if(math) then
		Events.Broadcast("load_math_puzzle", math_id)
	else
		Events.Broadcast("load_logic_puzzle", logic_id)
	end

	if(math) then
		Events.Broadcast("load_saved_math_nodes", math_id)
	else
		Events.Broadcast("load_saved_logic_nodes", logic_id)
	end
	
	Events.Broadcast("transition_out", function()
		Events.Broadcast("start_auto_save")
	end)
end)

Events.Connect("show_base_ui", function()
	base_ui.visibility = Visibility.FORCE_ON
end)

Events.Connect("show_ui", function()
	base_ui.visibility = Visibility.FORCE_ON
	node_ui.visibility = Visibility.FORCE_ON
	top_ui.visibility = Visibility.FORCE_ON
end)

Events.Connect("hide_ui", function()
	base_ui.visibility = Visibility.FORCE_OFF
	node_ui.visibility = Visibility.FORCE_OFF
	top_ui.visibility = Visibility.FORCE_OFF
end)

Task.Wait()
YOOTIL.Events.broadcast_to_server("init")