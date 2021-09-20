local API, YOOTIL = require(script:GetCustomProperty("API"))
local Localization = require(script:GetCustomProperty("Localization"))

local container = script:GetCustomProperty("container"):WaitForObject()
local title = script:GetCustomProperty("title"):WaitForObject()
local info_text_1 = script:GetCustomProperty("info_text_1"):WaitForObject()

local close_button = script:GetCustomProperty("close_button"):WaitForObject()

local queue = YOOTIL.Utils.Queue:new()
local current_item = nil
local last_title = nil

local is_open = false
local is_tweening = false

local height_lookup = {

	["Data"] = 530,
	["Output"] = 370,
	["If_Else"] = 320,
	["Alternate"] = 560,
	["Limit"] = 460,
	["Halt"] = 745,
	["Ordered_Output"] = 540,
	["View"] = 290,
	["Absolute"] = 465,
	["Add"] = 295,
	["Multiply"] = 355,
	["Subtract"] = 340,
	["Greater_Than"] = 585

}

close_button.clickedEvent:Connect(function()
	if(is_open and not is_tweening) then
		hide()
		API.play_click_sound()
	end
end)

function show(node_name)
	local title_txt = node_name

	if(is_tweening or (is_open and last_title == title_txt)) then
		return
	elseif(is_open and not is_tweening and last_title ~= title_txt) then
		hide()
	end

	local t = YOOTIL.Tween:new(.7, {x = -475 }, {x = 20 })

	t:on_start(function()
		is_tweening = true

		local key = title_txt:gsub("%s", "_")
		local txt_1 = Localization.get_text("Info_" .. key)

		title.text = Localization.get_text("Node_" .. key)
		last_title = title.text

		if(string.len(txt_1) > 0) then
			info_text_1.text = txt_1
		end

		container.height = height_lookup[key]
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
	local t = YOOTIL.Tween:new(.7, {x = 20 }, {x = -475 })

	t:on_start(function()
		is_closing = true
		is_tweening = true
	end)

	t:on_complete(function()
		current_item = nil
		container.visibility = Visibility.FORCE_OFF

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
end

Events.Connect("show_node_information", show)
Events.Connect("hide_node_information", hide)
Events.Connect("force_hide_node_information", function()
	hide()
end)