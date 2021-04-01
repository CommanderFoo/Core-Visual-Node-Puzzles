local YOOTIL = require(script:GetCustomProperty("YOOTIL"))
local container = script:GetCustomProperty("container"):WaitForObject()

local queue = YOOTIL.Utils.Queue:new()
local current_item = nil

function show(info_children)
	local t = YOOTIL.Tween:new(.7, {x = -400 }, {x = 20 })

	t:on_start(function()
		if(info_children) then
			
		end

		container.visibility = Visibility.FORCE_ON
	end)

	t:on_complete(function()
		current_item = nil
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
	local t = YOOTIL.Tween:new(.7, {x = 20 }, {x = -400 })

	t:on_complete(function()
		current_item = nil
		container.visibility = Visibility.FORCE_OFF
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