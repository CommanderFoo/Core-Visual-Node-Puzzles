local YOOTIL = require(script:GetCustomProperty("YOOTIL"))

local menu = script:GetCustomProperty("menu"):WaitForObject()
local menu_container = script:GetCustomProperty("menu_container"):WaitForObject()
local play_button = script:GetCustomProperty("play_button"):WaitForObject()
local bg_effect = script:GetCustomProperty("bg_effect"):WaitForObject()

local trophies_button = script:GetCustomProperty("trophies_button"):WaitForObject()
local trophies_panel = script:GetCustomProperty("trophies_panel"):WaitForObject()

local leaderboards_button = script:GetCustomProperty("leaderboards_button"):WaitForObject()
local leaderboards_panel = script:GetCustomProperty("leaderboards_panel"):WaitForObject()

local credits_button = script:GetCustomProperty("credits_button"):WaitForObject()
local credits_panel = script:GetCustomProperty("credits_panel"):WaitForObject()

local click_sound = script:GetCustomProperty("click_sound"):WaitForObject()
local hover_sound = script:GetCustomProperty("hover_sound"):WaitForObject()

local active_panel = nil
local active_button = nil
local tween = nil

function start()
	active_panel.visibility = Visibility.FORCE_ON
end

function change(c)
	active_panel.y = c.y
end

function complete()
	tween = nil
end

function hide_active(fn)
	if(active_panel == nil) then
		fn()
		return
	end

	tween = YOOTIL.Tween:new(.5, { y = active_panel.y }, { y = 900 })

	tween:on_complete(fn)
	tween:on_change(change)
	tween:set_easing("outBack")

	if(active_button ~= nil) then
		active_button:SetButtonColor(active_button:GetPressedColor())
	end
end

-- Play

play_button.clickedEvent:Connect(function()
	click_sound:Play()

	Events.Broadcast("transition_in", function()
		menu_container.visibility = Visibility.FORCE_OFF
		YOOTIL.Events.broadcast_to_server("load_game")
	end)

end)

play_button.hoveredEvent:Connect(function()
	hover_sound:Play()
end)

-- Trophies

trophies_button.clickedEvent:Connect(function()
	click_sound:Play()

	if(tween ~= nil or active_panel == trophies_panel) then
		return
	end

	hide_active(function()
		tween = nil

		if(active_panel ~= nil) then
			active_panel.visibility = Visibility.FORCE_OFF
		end

		active_panel = trophies_panel
		active_button = trophies_button

		tween = YOOTIL.Tween:new(.5, { y = 900 }, { y = 0 })

		tween:on_change(change)
		tween:on_start(start)
		tween:set_easing("outBack")
		tween:on_complete(complete)
	end)

	trophies_button:SetButtonColor(trophies_button:GetHoveredColor())
end)

trophies_button.hoveredEvent:Connect(function()
	hover_sound:Play()
end)

-- Leaderboards

leaderboards_button.clickedEvent:Connect(function()
	click_sound:Play()

	if(tween ~= nil or active_panel == leaderboards_panel) then
		return
	end

	hide_active(function()
		tween = nil

		if(active_panel ~= nil) then
			active_panel.visibility = Visibility.FORCE_OFF
		end

		active_panel = leaderboards_panel
		active_button = leaderboards_button

		tween = YOOTIL.Tween:new(.3, { y = 850 }, { y = 0 })

		tween:on_change(change)
		tween:on_start(start)
		tween:set_easing("outBack")
		tween:on_complete(complete)
	end)

	leaderboards_button:SetButtonColor(leaderboards_button:GetHoveredColor())
end)

leaderboards_button.hoveredEvent:Connect(function()
	hover_sound:Play()
end)

-- Credits

credits_button.clickedEvent:Connect(function()
	click_sound:Play()

	if(tween ~= nil or active_panel == credits_panel) then
		return
	end

	hide_active(function()
		if(active_panel ~= nil) then
			active_panel.visibility = Visibility.FORCE_OFF
		end

		active_panel = credits_panel
		active_button = credits_button

		tween = YOOTIL.Tween:new(.3, { y = 850 }, { y = 0 })

		tween:on_change(change)
		tween:on_start(start)
		tween:set_easing("outBack")
		tween:on_complete(complete)
	end)

	credits_button:SetButtonColor(credits_button:GetHoveredColor())
end)

credits_button.hoveredEvent:Connect(function()
	hover_sound:Play()
end)

function Tick(dt)
	if(tween ~= nil) then
		tween:tween(dt)
	end
end

Events.Connect("show_main_menu", function()
	Events.Broadcast("hide_ui")
	Events.Broadcast("close_settings")
	Events.Broadcast("play_menu_music")
	
	menu.x = -350
	menu_container.visibility = Visibility.FORCE_ON
	bg_effect.visibility = Visibility.FORCE_ON

	Events.Broadcast("transition_out")

	tween = YOOTIL.Tween:new(.8, { x = -350 }, { x = 250 })

	tween:set_easing("outBack")
	tween:on_change(function(c)
		menu.x = c.x
	end)
	
	tween:on_complete(function()
		tween = nil
	end)

	tween:set_delay(1)
end)