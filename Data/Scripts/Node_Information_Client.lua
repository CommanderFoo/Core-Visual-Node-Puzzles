local API, YOOTIL = require(script:GetCustomProperty("API"))

local container = script:GetCustomProperty("container"):WaitForObject()
local title = script:GetCustomProperty("title"):WaitForObject()
local info_text_1 = script:GetCustomProperty("info_text_1"):WaitForObject()
local info_text_2 = script:GetCustomProperty("info_text_2"):WaitForObject()
local view_code_button = script:GetCustomProperty("view_code_button"):WaitForObject()
local close_button = script:GetCustomProperty("close_button"):WaitForObject()

local code_panel = script:GetCustomProperty("code_panel"):WaitForObject()
local code_border = script:GetCustomProperty("code_border"):WaitForObject()
local code_background = script:GetCustomProperty("code_background"):WaitForObject()
local code_close = script:GetCustomProperty("code_close"):WaitForObject()
local code_title = script:GetCustomProperty("code_title"):WaitForObject()

local bg_col = code_background:GetColor()
local brd_col = code_border:GetColor()
local title_col = code_title:GetColor()
local close_col = code_close:GetButtonColor()

local queue = YOOTIL.Utils.Queue:new()
local current_item = nil
local last_title = nil

local is_open = false
local is_tweening = false
local showing_code = false
local code_tween = nil
local example_code = nil
local listener = nil

close_button.clickedEvent:Connect(function()
	if(is_open and not is_tweening) then
		fade_code_out()
		hide()
		API.play_click_sound()
	end
end)

function fade_code_out()
	code_tween = YOOTIL.Tween:new(.5, { a = 1 }, { a = 0 })

	code_tween:on_change(function(c)
		bg_col.a = c.a
		brd_col.a = c.a
		title_col.a = c.a
		close_col.a = c.a

		code_background:SetColor(bg_col)
		code_border:SetColor(brd_col)
		code_title:SetColor(title_col)
		code_close:SetButtonColor(close_col)

		if(Object.IsValid(example_code)) then
			for i, t in ipairs(example_code:GetChildren()) do
				local col = t:GetColor()

				col.a = c.a

				t:SetColor(col)
			end
		end
	end)

	code_tween:on_complete(function()
		code_tween = nil
		showing_code = false
		code_panel.visibility = Visibility.FORCE_OFF

		if(Object.IsValid(example_code)) then
			example_code:Destroy()
			example_code = nil
		end
	end)
end

code_close.clickedEvent:Connect(fade_code_out)

function show(info_data)
	local title_txt = info_data:GetCustomProperty("title")

	if(is_tweening or (is_open and last_title == title_txt)) then
		return
	elseif(is_open and not is_tweening and last_title ~= title_txt) then
		fade_code_out()
		hide()
	end

	local t = YOOTIL.Tween:new(.7, {x = -415 }, {x = 20 })

	t:on_start(function()
		is_tweening = true

		local txt_1 = info_data:GetCustomProperty("info_1_text")
		local txt_2 = info_data:GetCustomProperty("info_2_text")

		title.text = title_txt .. " Node"
		last_title = title.text

		if(string.len(txt_1) > 0) then
			info_text_1.text = txt_1
		end

		if(string.len(txt_2) > 0) then
			info_text_2.text = txt_2
			info_text_2.y = info_data:GetCustomProperty("info_2_offset")
		else
			info_text_2.text = ""
		end

		container.height = info_data:GetCustomProperty("info_height")

		if(info_data:GetCustomProperty("show_code")) then
			view_code_button.visibility = Visibility.FORCE_ON
			view_code_button.y = info_data:GetCustomProperty("button_offset")

			if(listener and listener.isConnected) then
				listener:Disconnect()
			end

			listener = view_code_button.clickedEvent:Connect(function()
				if(showing_code) then
					return
				end

				showing_code = true

				code_tween = YOOTIL.Tween:new(.5, { a = 0 }, { a = 1 })

				code_tween:on_start(function()
					code_title.text = title_txt .. " Example Code"

					example_code = World.SpawnAsset(info_data:GetCustomProperty("example_code"), { parent = code_panel })

					code_panel.height = info_data:GetCustomProperty("example_height")
					code_panel.width = info_data:GetCustomProperty("example_width")
					code_panel.visibility = Visibility.FORCE_ON
				end)

				code_tween:on_change(function(c)
					bg_col.a = c.a
					brd_col.a = c.a
					title_col.a = c.a
					close_col.a = c.a

					code_background:SetColor(bg_col)
					code_border:SetColor(brd_col)
					code_title:SetColor(title_col)
					code_close:SetButtonColor(close_col)

					if(Object.IsValid(example_code)) then
						for i, t in ipairs(example_code:GetChildren()) do
							local col = t:GetColor()

							col.a = c.a

							t:SetColor(col)
						end
					end
				end)

				code_tween:on_complete(function()
					code_tween = nil
				end)
			end)
		end

		container.visibility = Visibility.FORCE_ON
	end)

	t:on_complete(function()
		current_item = nil
		is_open = true
		is_tweening = false
	end)

	t:on_change(function(c)
		container.x = c.x
	end)

	t:set_easing("inOutBack")

	queue:push({
		
		tween = t

	})

end

function hide()
	local t = YOOTIL.Tween:new(.7, {x = 20 }, {x = -415 })

	t:on_start(function()
		is_closing = true
		is_tweening = true
	end)

	t:on_complete(function()
		current_item = nil
		container.visibility = Visibility.FORCE_OFF
		view_code_button.visibility = Visibility.FORCE_OFF

		is_open = false
		is_tweening = false
	end)

	t:on_change(function(c)
		container.x = c.x
	end)

	t:set_easing("inOutBack")
	
	queue:push({
		
		tween = t

	})
end

function Tick(dt)
	if(queue:length() > 0 and current_item == nil) then
		current_item = queue:pop()
	end

	if(current_item ~= nil) then
		current_item.tween:tween(dt)
	end

	if(code_tween ~= nil) then
		code_tween:tween(dt)
	end
end

Events.Connect("show_node_information", show)
Events.Connect("hide_node_information", hide)
Events.Connect("force_hide_node_information", function()
	fade_code_out()
	hide()
end)