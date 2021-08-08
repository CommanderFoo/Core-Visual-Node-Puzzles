local YOOTIL = require(script:GetCustomProperty("YOOTIL"))

local menu_container = script:GetCustomProperty("menu_container"):WaitForObject()
local bg_effect = script:GetCustomProperty("bg_effect"):WaitForObject()

local click_sound = script:GetCustomProperty("click_sound"):WaitForObject()
local hover_sound = script:GetCustomProperty("hover_sound"):WaitForObject()

local math_play = script:GetCustomProperty("math_play"):WaitForObject()
local logic_play = script:GetCustomProperty("logic_play"):WaitForObject()

local overrun_button = script:GetCustomProperty("overrun_button"):WaitForObject()
local stonehenge_button = script:GetCustomProperty("stonehenge_button"):WaitForObject()
local kooky_button = script:GetCustomProperty("kooky_button"):WaitForObject()

local logic_list = script:GetCustomProperty("logic_list"):WaitForObject()
local math_list = script:GetCustomProperty("math_list"):WaitForObject()

local logic_list_button = script:GetCustomProperty("logic_list_button"):WaitForObject()
local math_list_button = script:GetCustomProperty("math_list_button"):WaitForObject()

local puzzle_list_entry = script:GetCustomProperty("puzzle_list_entry")
local logic_list_scroll = script:GetCustomProperty("logic_list_scroll"):WaitForObject()
local math_list_scroll = script:GetCustomProperty("math_list_scroll"):WaitForObject()

local tutorial_button = script:GetCustomProperty("tutorial_button"):WaitForObject()

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
		
		button = script:GetCustomProperty("logic_button"):WaitForObject(),
		panel = script:GetCustomProperty("logic_panel"):WaitForObject(),
		just_show = true

	},

	{
		
		button = script:GetCustomProperty("math_button"):WaitForObject(),
		panel = script:GetCustomProperty("math_panel"):WaitForObject(),
		just_show = true

	},

	{
		
		button = script:GetCustomProperty("logic_list_button"):WaitForObject(),
		panel = script:GetCustomProperty("logic_list"):WaitForObject()

	},

	{
		
		button = script:GetCustomProperty("math_list_button"):WaitForObject(),
		panel = script:GetCustomProperty("math_list"):WaitForObject()

	},

	{
		
		button = script:GetCustomProperty("node_glossary_button"):WaitForObject(),
		panel = script:GetCustomProperty("node_glossary_panel"):WaitForObject()

	}

}

local tutorial_tpl = script:GetCustomProperty("tutorial_tpl")
local tutorial_ui = script:GetCustomProperty("tutorial_ui"):WaitForObject()

local last_active = nil
local tween = nil
local local_player = Game.GetLocalPlayer()

function play_hover()
	hover_sound:Play()
end

-- Tutorial

tutorial_button.clickedEvent:Connect(function()
	click_sound:Play()

	Events.Broadcast("transition_in", function()
		menu_container.visibility = Visibility.FORCE_OFF
		
		clean_up()

		Events.Broadcast("show_base_ui")

		World.SpawnAsset(tutorial_tpl, { parent = tutorial_ui })

		Events.Broadcast("transition_out", function()
			Events.Broadcast("start_tutorial")
		end)
	end)
end)

-- Logic

logic_play.clickedEvent:Connect(function()
	click_sound:Play()

	Events.Broadcast("transition_in", function()
		menu_container.visibility = Visibility.FORCE_OFF
		
		clean_up()
		hide_last()
		last_active = nil

		YOOTIL.Events.broadcast_to_server("load_game", false)
	end)
end)

logic_play.hoveredEvent:Connect(play_hover)

-- Math

math_play.clickedEvent:Connect(function()
	click_sound:Play()

	Events.Broadcast("transition_in", function()
		menu_container.visibility = Visibility.FORCE_OFF

		clean_up()
		hide_last()
		last_active = nil

		YOOTIL.Events.broadcast_to_server("load_game", true)
	end)

end)

math_play.hoveredEvent:Connect(play_hover)

function hide_last()
	if(last_active == nil) then
		return
	end

	last_active.button:SetButtonColor(last_active.button:GetDisabledColor())

	if(last_active.just_show) then
		last_active.panel.visibility = Visibility.FORCE_OFF
	else
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
end

function display(o)
	if(o.just_show) then
		last_active = o
		o.panel.visibility = Visibility.FORCE_ON
	else
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
end

function show_panel(o)
	if(last_active ~= nil) then
		if(last_active ~= o) then
			hide_last()

			if(not last_active.just_show) then
				Task.Wait(.35)
			end

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

	o.button.hoveredEvent:Connect(play_hover)
end

function reset_lists()

end

function Tick(dt)
	if(tween ~= nil) then
		tween:tween(dt)
	end
end

function clean_up()
	math_list.visibility = Visibility.FORCE_OFF
	math_list_button:SetButtonColor(logic_list_button:GetDisabledColor())

	logic_list.visibility = Visibility.FORCE_OFF
	logic_list_button:SetButtonColor(logic_list_button:GetDisabledColor())
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

function open_up_logic_puzzle(id)
	local entry = logic_list_scroll:FindChildByName("Puzzle " .. tostring(id))

	entry.isInteractable = true
	entry:GetCustomProperty("lock"):GetObject().visibility = Visibility.FORCE_OFF
	entry:GetCustomProperty("name_txt"):GetObject().x = 15
end

function open_up_math_puzzle(id)
	local entry = math_list_scroll:FindChildByName("Puzzle " .. tostring(id))

	entry.isInteractable = true
	entry:GetCustomProperty("lock"):GetObject().visibility = Visibility.FORCE_OFF
	entry:GetCustomProperty("name_txt"):GetObject().x = 15
end

Events.Connect("update_logic_list", function(data)
	if(data ~= nil) then
		local last_id = 0

		for i, p in pairs(data) do
			local entry = logic_list_scroll:FindChildByName("Puzzle " .. tostring(p[1]))

			if(entry ~= nil) then
				if(p[2] > 0) then
					if(p[1] > last_id) then
						last_id = p[1]
					end

					entry.isInteractable = true
					entry:GetCustomProperty("lock"):GetObject().visibility = Visibility.FORCE_OFF
					entry:GetCustomProperty("name_txt"):GetObject().x = 15

					local gold = entry:GetCustomProperty("gold"):GetObject()
					local gold_col = gold:GetColor()

					local silver = entry:GetCustomProperty("silver"):GetObject()
					local silver_col = silver:GetColor()

					local bronze = entry:GetCustomProperty("bronze"):GetObject()
					local bronze_col = bronze:GetColor()

					if(p[2] == 3) then
						gold_col.a = 1
						silver_col.a = .2
						bronze_col.a = .2
					elseif(p[2] == 2) then
						silver_col.a = 1
						gold_col.a = .2
						bronze_col.a = .2
					elseif(p[2] == 1) then
						bronze_col.a = 1
						silver_col.a = .2
						gold_col.a = .2
					end

					gold:SetColor(gold_col)
					silver:SetColor(silver_col)
					bronze:SetColor(bronze_col)
				end

				if(p[3] > 0) then
					entry:GetCustomProperty("score_txt"):GetObject().text = "Score: " .. tostring(YOOTIL.Utils.number_format(p[3]))
					entry:GetCustomProperty("score_txt"):GetObject().visibility = Visibility.FORCE_ON
				end
			end
		end

		if(last_id < 25) then
			open_up_logic_puzzle(last_id + 1)
		end
	end
end)

Events.Connect("update_math_list", function(data)
	if(data ~= nil) then
		local last_id = 0

		for i, p in pairs(data) do
			local entry = math_list_scroll:FindChildByName("Puzzle " .. tostring(p[1]))

			if(entry ~= nil) then
				if(p[2] > 0) then
					if(p[1] > last_id) then
						last_id = p[1]
					end

					entry.isInteractable = true
					entry:GetCustomProperty("lock"):GetObject().visibility = Visibility.FORCE_OFF
					entry:GetCustomProperty("name_txt"):GetObject().x = 15

					local gold = entry:GetCustomProperty("gold"):GetObject()
					local gold_col = gold:GetColor()

					local silver = entry:GetCustomProperty("silver"):GetObject()
					local silver_col = silver:GetColor()

					local bronze = entry:GetCustomProperty("bronze"):GetObject()
					local bronze_col = bronze:GetColor()

					if(p[2] == 3) then
						gold_col.a = 1
						silver_col.a = .2
						bronze_col.a = .2
					elseif(p[2] == 2) then
						silver_col.a = 1
						gold_col.a = .2
						bronze_col.a = .2
					elseif(p[2] == 1) then
						bronze_col.a = 1
						silver_col.a = .2
						gold_col.a = .2
					end

					gold:SetColor(gold_col)
					silver:SetColor(silver_col)
					bronze:SetColor(bronze_col)
				end

				if(p[3] > 0) then
					entry:GetCustomProperty("score_txt"):GetObject().text = "Score: " .. tostring(YOOTIL.Utils.number_format(p[3]))
					entry:GetCustomProperty("score_txt"):GetObject().visibility = Visibility.FORCE_ON
				end
			end
		end

		if(last_id < 25) then
			open_up_math_puzzle(last_id + 1)
		end
	end
end)

local logic_offset = 0
local math_offset = 0
local clicked = false

for i = 1, 25 do
	
	-- Logic

	local entry = World.SpawnAsset(puzzle_list_entry, { parent = logic_list_scroll })

	entry:GetCustomProperty("name_txt"):GetObject().text = "PUZZLE #" .. tostring(i)

	if(i == 1) then
		entry.isInteractable = true
		entry:GetCustomProperty("lock"):GetObject().visibility = Visibility.FORCE_OFF
		entry:GetCustomProperty("name_txt"):GetObject().x = 15
	end

	entry.clickedEvent:Connect(function()
		if(clicked) then
			return
		end

		clicked = true

		if(entry:GetCustomProperty("lock"):GetObject().visibility == Visibility.FORCE_OFF) then
			Events.Broadcast("transition_in", function()
				menu_container.visibility = Visibility.FORCE_OFF
				logic_list.visibility = Visibility.FORCE_OFF
				logic_list_button:SetButtonColor(logic_list_button:GetDisabledColor())
				
				last_active = nil
		
				YOOTIL.Events.broadcast_to_server("load_puzzle_id", i, false)
				clicked = false
			end)
		end
	end)

	entry.name = "Puzzle " .. tostring(i)
	entry.y = logic_offset
	logic_offset = logic_offset + 60

	-- Math

	local entry = World.SpawnAsset(puzzle_list_entry, { parent = math_list_scroll })

	entry:GetCustomProperty("name_txt"):GetObject().text = "PUZZLE #" .. tostring(i)

	if(i == 1) then
		entry.isInteractable = true
		entry:GetCustomProperty("lock"):GetObject().visibility = Visibility.FORCE_OFF
		entry:GetCustomProperty("name_txt"):GetObject().x = 15
	end

	entry.clickedEvent:Connect(function()
		if(clicked) then
			return
		end

		clicked = true

		if(entry:GetCustomProperty("lock"):GetObject().visibility == Visibility.FORCE_OFF) then
			Events.Broadcast("transition_in", function()
				menu_container.visibility = Visibility.FORCE_OFF
				math_list.visibility = Visibility.FORCE_OFF
				math_list_button:SetButtonColor(logic_list_button:GetDisabledColor())
				
				last_active = nil
		
				YOOTIL.Events.broadcast_to_server("load_puzzle_id", i, true)
				clicked = false
			end)
		end
	end)

	entry.name = "Puzzle " .. tostring(i)
	entry.y = math_offset
	math_offset = math_offset + 60
end