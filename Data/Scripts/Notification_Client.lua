local YOOTIL = require(script:GetCustomProperty("YOOTIL"))

local notification = script:GetCustomProperty("notification"):WaitForObject()
local notify_text = script:GetCustomProperty("notify_text"):WaitForObject()

local trophy_notification = script:GetCustomProperty("trophy_notification"):WaitForObject()
local trophy_text = script:GetCustomProperty("trophy_text"):WaitForObject()

local in_time = .5
local stay_time = 4
local out_time = .5
local delay_time = .5

local queue = YOOTIL.Utils.Queue:new()
local current_item = nil
local in_tween = nil
local out_tween = nil

local active_panel = nil

function on_change(c)
	if(active_panel ~= nil) then
		active_panel.x = c.x
	end
end

function Tick(dt)
	if(queue:length() > 0 and current_item == nil) then
		current_item = queue:pop()

		in_tween = YOOTIL.Tween:new(current_item.in_time or in_time, { x = -415 }, { x = 75 })

		in_tween:on_start(function()
			if(current_item.type == "message") then
				notify_text.text = current_item.message
				active_panel = notification
			elseif(current_item.type == "trophy") then
				trophy_text.text = current_item.message
				active_panel = trophy_notification
			end
		end)

		in_tween:on_complete(function()
			in_tween = nil
		end)

		in_tween:on_change(on_change)
		in_tween:set_easing("outBack")
		
		in_tween:set_delay(current_item.delay_time or delay_time)

		out_tween = YOOTIL.Tween:new(current_item.out_time or out_time, { x = 75 }, { x = -415 })

		out_tween:on_complete(function()
			current_item = nil
			out_tween = nil
		end)
		
		out_tween:on_change(on_change)
		out_tween:set_delay(current_item.stay_time or stay_time)
		out_tween:set_easing("inBack")
	end

	if(current_item ~= nil) then
		if(in_tween ~= nil) then
			in_tween:tween(dt)
		elseif(out_tween ~= nil) then
			out_tween:tween(dt)
		end
	end
end

function get_trophy_data(id)
	return {
		
		type = "trophy",
		message = "Hello"

	}
end

Events.Connect("add_notification", function(msg)
	queue:push({
		
		type = "message",
		message = msg

	})
end)

Events.Connect("add_trophy", function(id)
	queue:push(get_trophy_data(id))
end)