local API, YOOTIL = require(script:GetCustomProperty("API"))

local red_count = script:GetCustomProperty("red_count"):WaitForObject()
local green_count = script:GetCustomProperty("green_count"):WaitForObject()
local white_count = script:GetCustomProperty("white_count"):WaitForObject()
local yellow_count = script:GetCustomProperty("yellow_count"):WaitForObject()
local blue_count = script:GetCustomProperty("blue_count"):WaitForObject()
local dark_green_count = script:GetCustomProperty("dark_green_count"):WaitForObject()

local red_apple = script:GetCustomProperty("red_apple")
local green_apple = script:GetCustomProperty("green_apple")
local white_apple = script:GetCustomProperty("white_apple")
local yellow_apple = script:GetCustomProperty("yellow_apple")
local blue_apple = script:GetCustomProperty("blue_apple")
local dark_green_apple = script:GetCustomProperty("dark_green_apple")

local container = script:GetCustomProperty("container"):WaitForObject()

local data = {
	
	{ color = "red", count = 10, ui = red_count, asset = red_apple },
	{ color = "green", count = 10, ui = green_count, asset = green_apple },
	{ color = "white", count = 10, ui = white_count, asset = white_apple },
	{ color = "yellow", count = 10, ui = yellow_count, asset = yellow_apple },
	{ color = "blue", count = 10, ui = blue_count, asset = blue_apple },
	{ color = "dark green", count = 10, ui = dark_green_count, asset = dark_green_apple}

}

for _, d in pairs(data) do
	d.ui.text = "25"
	d.count = 25
end

local items = {}
local task = nil
local index = 1
local count = 0
local total = 25 * 6

API.register_node(API.Node:new(script.parent.parent, {

	repeat_count = -1,
	repeat_interval = .4,
	tick = function(node)
		if(node:has_connection()) then
			if(count == total) then
				node:stop_tick()

				return
			end
			
			if(index == 7) then
				index = 1
			end

			if(not Object.IsValid(data[index].ui)) then
				return
			end

			local item = data[index]

			item.count = item.count - 1
			item.ui.text = tostring(item.count)

			local obj = World.SpawnAsset(item.asset, {parent = container})
			local line = node:get_top_connector_line()
			
			obj.x = line.x
			obj.y = line.y
			
			local tween = YOOTIL.Tween:new(1.8, {a = 0}, {a = line.width})

			tween:on_complete(function()
				node:send_data({
					
					asset = item.asset,
					color = item.color,
					count = 1
				})

				obj:Destroy()
				tween = nil
			end)

			tween:on_change(function(changed)
				local x, y = API.get_path(obj, line, changed)
		
				obj.x = x
				obj.y = y
			end)

			table.insert(items, #items + 1, {
				
				obj = obj,
				tween = tween
			
			})

			index = index + 1
			count = count + 1
		end
	end

}))

function Tick(dt)
	for _, i in ipairs(items) do
		if(i.tween ~= nil) then
			i.tween:tween(dt)
		end
	end
end