local YOOTIL = require(script:GetCustomProperty("YOOTIL"))

local menu_container = script:GetCustomProperty("menu_container"):WaitForObject()
local bg_effect = script:GetCustomProperty("bg_effect"):WaitForObject()

local click_sound = script:GetCustomProperty("click_sound"):WaitForObject()
local hover_sound = script:GetCustomProperty("hover_sound"):WaitForObject()

local math_button = script:GetCustomProperty("math_button"):WaitForObject()
local logic_button = script:GetCustomProperty("logic_button"):WaitForObject()

local overrun_button = script:GetCustomProperty("overrun_button"):WaitForObject()
local stonehenge_button = script:GetCustomProperty("stonehenge_button"):WaitForObject()
local kooky_button = script:GetCustomProperty("kooky_button"):WaitForObject()

local buttons_panels = {

	{ 

		button = script:GetCustomProperty("my_games_button"):WaitForObject(),
		panel = script:GetCustomProperty("my_games_panel"):WaitForObject(),

	},

	{

		button = script:GetCustomProperty("donate_button"):WaitForObject(),
		panel = script:GetCustomProperty("donate_panel"):WaitForObject(),

	},

	{
		
		button = script:GetCustomProperty("tutorial_button"):WaitForObject(),
		panel = script:GetCustomProperty("tutorial_panel"):WaitForObject(),

	}

}

local last_active = nil
local tween = nil
local local_player = Game.GetLocalPlayer()

-- Logic

logic_button.clickedEvent:Connect(function()
	click_sound:Play()

	Events.Broadcast("transition_in", function()
		menu_container.visibility = Visibility.FORCE_OFF
		
		hide_last()

		YOOTIL.Events.broadcast_to_server("load_game", true)
	end)

end)

logic_button.hoveredEvent:Connect(function()
	hover_sound:Play()
end)

-- Math

math_button.clickedEvent:Connect(function()
	click_sound:Play()

	Events.Broadcast("transition_in", function()
		menu_container.visibility = Visibility.FORCE_OFF

		hide_last()

		YOOTIL.Events.broadcast_to_server("load_game", true)
	end)

end)

math_button.hoveredEvent:Connect(function()
	hover_sound:Play()
end)

function hide_last()
	if(last_active == nil) then
		return
	end

	last_active.button:SetButtonColor(last_active.button:GetDisabledColor())

	tween = YOOTIL.Tween:new(.3, { y = 0 }, { y = -900 })
	tween:set_easing("outBack")
	tween:on_change(function(c)
		last_active.panel.y = c.y
	end)

	tween:on_complete(function()
		tween = nil
		last_active.panel.visibility = Visibility.FORCE_OFF
	end)
end

function display(o)
	tween = YOOTIL.Tween:new(.3, { y = -900 }, { y = 0 })
	tween:set_easing("outBack")

	tween:on_start(function()
		last_active = o
		o.panel.visibility = Visibility.FORCE_ON
	end)

	tween:on_change(function(c)
		o.panel.y = c.y
	end)

	tween:on_complete(function()
		tween = nil
	end)
end

function show_panel(o)
	if(last_active ~= nil) then
		if(last_active ~= o) then
			hide_last()
			Task.Wait(.35)
			display(o)
		end
	else
		display(o)
	end
end

for _, o in pairs(buttons_panels) do
	o.button.clickedEvent:Connect(function()
		click_sound:Play()
		o.button:SetButtonColor(o.button:GetPressedColor())
		show_panel(o)
	end)

	o.button.hoveredEvent:Connect(function()
		hover_sound:Play()
	end)
end

function Tick(dt)
	if(tween ~= nil) then
		tween:tween(dt)
	end
end

Events.Connect("show_main_menu", function()
	Events.Broadcast("hide_ui")
	Events.Broadcast("close_settings")
	Events.Broadcast("play_menu_music")

	menu_container.visibility = Visibility.FORCE_ON
	bg_effect.visibility = Visibility.FORCE_ON

	Events.Broadcast("transition_out")
end)

overrun_button.clickedEvent:Connect(function()
	local_player:TransferToGame("bf87a8/overrun")
end)

stonehenge_button.clickedEvent:Connect(function()
	local_player:TransferToGame("923e7b/stonehenge")
end)

kooky_button.clickedEvent:Connect(function()
	local_player:TransferToGame("3be43c/kooky-racer")
end)