local API, YOOTIL = require(script:GetCustomProperty("API"))

local root = script:FindTemplateRoot()

local red_apple = root:GetCustomProperty("red_apple")
local green_apple = root:GetCustomProperty("green_apple")
local container = root:GetCustomProperty("container"):WaitForObject()

local node = API.Node:new(script)

node:stop_data_flow()

local if_condition = nil
local top_items = {}
local bottom_items = {}

node:data_received(function(data)
	print(if_condition)
	if(data.color == if_condition) then
		if(node:has_top_connection()) then
			local obj = World.SpawnAsset(red_apple, {parent = container})
			local line = node:get_top_connector_line()
			local tween = YOOTIL.Tween:new(.8, {a = 0}, {a = line.width})

			tween:on_complete(function()
				node:send_data_top_connection(data)
				obj:Destroy()
				tween = nil
			end)

			tween:on_change(function(changed)
				local angle = line.rotationAngle
				local rad = angle * (math.pi / 180)

				obj.x = (changed.a * math.cos(rad))
				obj.y = (changed.a * math.sin(rad)) - 30
			end)

			table.insert(top_items, #top_items + 1, {
				
				obj = obj,
				tween = tween
			
			})
		end	
	elseif(if_condition) then
		if(node:has_bottom_connection()) then
			local obj = World.SpawnAsset(green_apple, {parent = container})
			local line = node:get_bottom_connector_line()
			local tween = YOOTIL.Tween:new(.8, {a = 0}, {a = line.width})

			tween:on_complete(function()
				node:send_data_bottom_connection(data)
				obj:Destroy()
				tween = nil
			end)

			tween:on_change(function(changed)
				local angle = line.rotationAngle
				local rad = angle * (math.pi / 180)

				obj.x = (changed.a * math.cos(rad))
				obj.y = (changed.a * math.sin(rad)) + 60
			end)

			table.insert(top_items, #top_items + 1, {
				
				obj = obj,
				tween = tween
			
			})
		end
	end
end)

API.register_node(node)

function Tick(dt)
	for _, i in ipairs(top_items) do
		if(i.tween ~= nil) then
			i.tween:tween(dt)
		end
	end

	for _, i in ipairs(bottom_items) do
		if(i.tween ~= nil) then
			i.tween:tween(dt)
		end
	end
end

Events.Connect("on_apples_color_option_selected", function(index, option, value)
	if_condition = option.text
end)