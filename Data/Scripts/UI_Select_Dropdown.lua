local root = script.parent.parent

local options_panel = root:FindDescendantByName("Options Panel")
local options_container = root:FindDescendantByName("Options")
local selected = root:FindDescendantByName("Selected")
local arrow = root:FindDescendantByName("Arrow")

local local_player = Game.GetLocalPlayer()

local options = options_container:GetChildren()

local total_options = #options
local offset = 0
local selected_option = selected
local disabled = root:GetCustomProperty("disabled")

local event = root:GetCustomProperty("event") or ""
local hovered_color = root:GetCustomProperty("hovered_color")
local unhovered_color = root:GetCustomProperty("unhovered_color")
local disabled_color = root:GetCustomProperty("disabled_color")

options_container.parent = options_panel
options_container.x = 0
options_container.y = 0
options_container.visibility = Visibility.INHERIT

if(event and #event > 0) then
	event = event .. "_"
end

if(disabled) then
	selected:SetButtonColor(disabled_color)
end

selected.hoveredEvent:Connect(function()
	if(disabled) then
		return
	end

	selected:SetButtonColor(hovered_color)
end)

selected.unhoveredEvent:Connect(function()
	if(disabled) then
		return
	end

	selected:SetButtonColor(unhovered_color)
end)

for i = 1, total_options do
	options[i].y = offset
	offset = offset + options[i].height
	options[i]:SetButtonColor(unhovered_color)

	options[i].hoveredEvent:Connect(function()
		options[i]:SetButtonColor(hovered_color)
	end)

	options[i].unhoveredEvent:Connect(function()
		options[i]:SetButtonColor(unhovered_color)
	end)

	options[i].clickedEvent:Connect(function()
		selected_option = options[i]
		selected.text = options[i].text
		close_select()

		Events.Broadcast("on_" .. event .. "option_selected", i, options[i], options[i]:GetCustomProperty("value"))
	end)
end

function close_select()
	options_panel.visibility = Visibility.FORCE_OFF
	arrow.rotationAngle = 180
end

selected.clickedEvent:Connect(function()
	options_panel.height = (50 * total_options) + 4

	if(options_panel.visibility == Visibility.FORCE_ON) then
		close_select()
	elseif(not disabled) then
		options_panel.visibility = Visibility.FORCE_ON
		arrow.rotationAngle = 0
	end
end)

function disable_select(clear_selected)
	disabled = true
	selected:SetButtonColor(disabled_color)

	if(clear_selected) then
		selected_option = selected
		selected_option.text = ""
	end
end

function enable_select()
	disabled = false
	selected:SetButtonColor(unhovered_color)
end

local_player.bindingPressedEvent:Connect(close_select)

Events.Connect("on_" .. event .. "select_disable", disable_select)
Events.Connect("on_" .. event .. "select_enable", enable_select)