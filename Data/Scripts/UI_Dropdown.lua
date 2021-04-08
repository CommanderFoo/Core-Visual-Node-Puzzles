﻿local root = script.parent.parent
local node_root = root.parent.parent

local options_panel = root:FindDescendantByName("Options Panel")
local options_container = root:FindDescendantByName("Options")
local selected = root:FindDescendantByName("Selected")
local arrow = root:FindDescendantByName("Arrow")
local selected_border = root:FindDescendantByName("Selected Border")
local options_border = root:FindDescendantByName("Options Border")
local options_background = root:FindDescendantByName("Options Background")

local event = node_root.id or ""
local hovered_color = root:GetCustomProperty("hovered_color")
local unhovered_color = root:GetCustomProperty("unhovered_color")
local disabled_color = root:GetCustomProperty("disabled_color")
local border_color = root:GetCustomProperty("border_color")
local arrow_color = root:GetCustomProperty("arrow_color")
local text_hovered_color = root:GetCustomProperty("text_hovered_color")
local text_unhovered_color = root:GetCustomProperty("text_unhovered_color")

local local_player = Game.GetLocalPlayer()

local options = options_container:GetChildren()

local total_options = #options
local offset = 0
local selected_option = selected
local disabled = root:GetCustomProperty("disabled")

local selected_shape = selected:FindChildByName("Shape")
local selected_text = selected:FindChildByName("Text")

arrow:SetColor(arrow_color)

selected_border:SetColor(border_color)

selected:SetButtonColor(unhovered_color)
selected:SetFontColor(text_unhovered_color)

options_border:SetColor(border_color)
options_background:SetColor(unhovered_color)

options_container.parent = options_panel
options_container.x = 0
options_container.y = 0
options_panel.y = root.height
options_container.visibility = Visibility.INHERIT

if(event and #event > 0) then
	event = event .. "_"
else
	event = "dropdown_"
end

if(disabled) then
	selected:SetButtonColor(disabled_color)
end

selected.hoveredEvent:Connect(function()
	if(disabled) then
		return
	end

	selected:SetButtonColor(hovered_color)
	--selected:SetFontColor(text_hovered_color)
end)

selected.unhoveredEvent:Connect(function()
	if(disabled) then
		return
	end

	selected:SetButtonColor(unhovered_color)
	selected:SetFontColor(text_unhovered_color)
end)

for i = 1, total_options do
	options[i].y = offset
	offset = offset + options[i].height
	options[i]:SetButtonColor(unhovered_color)
	--options[i]:SetFontColor(text_unhovered_color)

	options[i].hoveredEvent:Connect(function()
		options[i]:SetButtonColor(hovered_color)
		--options[i]:SetFontColor(text_hovered_color)
	end)

	options[i].unhoveredEvent:Connect(function()
		options[i]:SetButtonColor(unhovered_color)
		--options[i]:SetFontColor(text_unhovered_color)
	end)

	options[i].clickedEvent:Connect(function()
		selected_option = options[i]
		selected_text.text = options[i]:FindChildByName("Text").text

		selected_shape:SetImage(options[i]:FindChildByName("Shape"):GetImage())
		selected_shape.visibility = Visibility.FORCE_ON
		selected_shape:SetColor(options[i]:FindChildByName("Shape"):GetColor())

		close_select()

		Events.Broadcast("on_" .. event .. "selected", i, options[i], options[i]:GetCustomProperty("value"))
	end)
end

function close_select()
	if(Object.IsValid(options_panel)) then
		options_panel.visibility = Visibility.FORCE_OFF
		arrow.rotationAngle = 180
	end
end

selected.clickedEvent:Connect(function()
	options_panel.height = (50 * total_options) + 4

	if(options_panel.visibility == Visibility.FORCE_ON) then
		close_select()
	elseif(not disabled) then
		options_panel.visibility = Visibility.FORCE_ON
		arrow.rotationAngle = 0
	end

	Events.Broadcast("on_" .. event .. "focused")
end)

function disable_select(clear_selected)
	disabled = true

	if(Object.IsValid(selected)) then
		selected:SetButtonColor(disabled_color)

		if(clear_selected) then
			selected_option = selected
			selected_option.text = ""
		end

		close_select()
	end
end

function enable_select()
	disabled = false

	if(Object.IsValid(selected)) then
		selected:SetButtonColor(unhovered_color)
	end
end

local_player.bindingPressedEvent:Connect(close_select)

Events.Connect("on_set_" .. event .. "selected", function(s)
	for i = 1, total_options do
		if(string.lower(options[i]:FindChildByName("Text").text):sub(1, 1) == s) then
			selected_option = options[i]
			selected_text.text = options[i]:FindChildByName("Text").text

			selected_shape:SetImage(options[i]:FindChildByName("Shape"):GetImage())
			selected_shape.visibility = Visibility.FORCE_ON
			selected_shape:SetColor(options[i]:FindChildByName("Shape"):GetColor())
		end
	end
end)

Events.Connect("on_" .. event .. "disable", disable_select)
Events.Connect("on_" .. event .. "enable", enable_select)

Events.Connect("on_disable_all_dropdowns", disable_select)
Events.Connect("on_enable_all_dropdowns", enable_select)