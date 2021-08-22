local root = script.parent

local progress = script:GetCustomProperty("progress"):WaitForObject()
local fill = script:GetCustomProperty("fill"):WaitForObject()
local handle = script:GetCustomProperty("handle"):WaitForObject()

local display = script:GetCustomProperty("display"):WaitForObject()
local display_text = script:GetCustomProperty("display_text"):WaitForObject()
local display_handle = script:GetCustomProperty("display_handle"):WaitForObject()
local display_arrow = script:GetCustomProperty("display_arrow"):WaitForObject()
local display_background = script:GetCustomProperty("display_background"):WaitForObject()

local event = root:GetCustomProperty("event")
local width = root:GetCustomProperty("width")
local height = root:GetCustomProperty("height")
local default_fill_percent = root:GetCustomProperty("default_fill_percent")
local fill_color = root:GetCustomProperty("fill_color")
local background_color = root:GetCustomProperty("background_color")
local text_color = root:GetCustomProperty("text_color")

display_text:SetColor(text_color)
display_arrow:SetColor(fill_color)
display_background:SetColor(fill_color)

fill:SetColor(fill_color)
progress:SetColor(background_color)

root.width = width
root.height = height

if(event and #event > 0) then
	event = event .. "_"
else
	event = "slider_"
end

local moving_handle = false
local slider_amount = width * default_fill_percent

local local_player = Game.GetLocalPlayer()

function Tick()
	local mouse_pos = UI.GetCursorPosition()

	if(moving_handle) then
		local screen = UI.GetScreenSize()
		local x = mouse_pos.x + (width / 2) - root.x

		if(root.dock == UIPivot.TOP_CENTER or root.dock == UIPivot.MIDDLE_CENTER or root.dock == UIPivot.BOTTOM_CENTER) then
			x = x - (screen.x / 2)
		elseif(root.dock == UIPivot.TOP_RIGHT or root.dock == UIPivot.MIDDLE_RIGHT or root.dock == UIPivot.BOTTOM_RIGHT) then
			x = x - screen.x
		end
	
		if(x < 0) then
			slider_amount = 0
		elseif(x > width) then
			slider_amount = width
		end

		if(x >= 0 and x <= width) then
			slider_amount = x
		end

		update()
	end
end

function update(block_event)
	fill.width = math.floor(slider_amount)
	display.x = slider_amount

	local percent = (slider_amount / width) * 100

	display_text.text = string.format("%0.0f", percent)

	if(not block_event) then
		Events.Broadcast("on_" .. event .. "update", root, slider_amount, percent)
	end
end

function set_handle_state()
	if(moving_handle) then
		moving_handle = false

		Events.Broadcast("on_" .. event .. "unclicked", root)
	else
		moving_handle = true

		Events.Broadcast("on_" .. event .. "clicked", root)
		Events.Broadcast("slider_release_handle", root.id)
	end
end

handle.pressedEvent:Connect(set_handle_state)
handle.releasedEvent:Connect(set_handle_state)

display_handle.pressedEvent:Connect(set_handle_state)
display_handle.releasedEvent:Connect(set_handle_state)

local_player.bindingPressedEvent:Connect(function(player, binding)
	if(binding == "ability_primary") then
		if(moving_handle) then
			moving_handle = false

			Events.Broadcast("on_" .. event .. "unclicked", root)
		end
	end
end)

Events.Connect("slider_release_handle", function(ignore_slider)
	if(not ignore_slider or root.id ~= ignore_slider) then
		moving_handle = false
	end
end)

Events.Connect("set_" .. event .. "amount", function(amount)
	slider_amount = width * (amount / 100)
	update(true)
end)

update(true)