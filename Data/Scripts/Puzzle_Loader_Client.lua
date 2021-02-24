local nodes_container = script:GetCustomProperty("nodes_container"):WaitForObject()
local puzzle_name = script:GetCustomProperty("puzzle_name"):WaitForObject()
local data = script:GetCustomProperty("data"):WaitForObject()
local tutorial_container = script:GetCustomProperty("tutorial_container"):WaitForObject()

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

	if(puzzles["puzzle_" .. id]) then
		
		current_puzzle = World.SpawnAsset(puzzles["puzzle_" .. id], { parent = nodes_container })

		puzzle_name.text = current_puzzle:GetCustomProperty("name")

		Events.Broadcast("time_conditions", {

			gold = current_puzzle:GetCustomProperty("gold_time"),
			silver = current_puzzle:GetCustomProperty("silver_time"),
			bronze = current_puzzle:GetCustomProperty("bronze_time")

		})

		local tutorial = current_puzzle:GetCustomProperty("tutorial")
		local seen_tutorial = local_player:GetResource("p" .. id .. "t")

		if(tutorial ~= nil and seen_tutorial == 0) then
			World.SpawnAsset(tutorial, { parent = tutorial_container })
		end

		Events.Broadcast("enable_header_ui")
	else
		Events.Broadcast("disable_header_ui", true)
		Events.Broadcast("show_welcome")
	end
end

local_player.resourceChangedEvent:Connect(function(obj, prop)
	if(prop == "puzzle_id") then
		load_puzzle(local_player:GetResource("puzzle_id"))
	elseif(prop == "show_nodes") then
		if(local_player:GetResource("show_nodes") == 1) then
			Events.Broadcast("show_nodes")
		end
	elseif(prop == "speed") then
		Events.Broadcast("set_speed", local_player:GetResource("speed"))
	elseif(prop == "sfx_volume") then
		if(not sfx_slider_updated) then
			Events.Broadcast("set_sfx_slider_amount", local_player:GetResource("sfx_volume"))
			sfx_slider_updated = true
		end

		Events.Broadcast("on_update_sfx_volume", local_player:GetResource("sfx_volume"))
	elseif(prop == "music_volume") then
		if(not music_slider_updated) then
			Events.Broadcast("set_music_slider_amount", local_player:GetResource("music_volume"))
			music_slider_updated = true

			--Events.Broadcast("play_music")
		end

		Events.Broadcast("on_update_music_volume", local_player:GetResource("music_volume"))
	elseif(prop == "show_notifications") then
		if(local_player:GetResource("show_notifications") == 1) then
			Events.Broadcast("show_notifications_toggle_on")
		else
			Events.Broadcast("show_notifications_toggle_off")
		end
	end
end)

Task.Spawn(function()
	Events.BroadcastToServer("game_ready")
end)