local API, YOOTIL = require(script:GetCustomProperty("API"))

local red_count = script:GetCustomProperty("red_count"):WaitForObject()
local green_count = script:GetCustomProperty("green_count"):WaitForObject()

local red_apple = script:GetCustomProperty("red_apple")
local green_apple = script:GetCustomProperty("green_apple")

local container = script:GetCustomProperty("container"):WaitForObject()

local node = API.Node:new(script.parent.parent)

local red_data = {	

	color = "red",
	count = 10

}

local green_data = {

	color = "green",
	count = 10

}

local sending = red_data
local items = {}
local asset = red_apple
local task = nil

API.Node_Events.on("node_connected", function(node_connected)
	if(task == nil and node_connected:get_id() == node:get_id()) then		
		task = Task.Spawn(function()
			if(not Object.IsValid(green_count) or not Object.IsValid(red_count)) then
				task:Cancel()
				task = nil
				return
			end

			if(node:has_connection()) then
				if(red_data.count == 0 and green_data.count == 0) then
					return
				end
		
				sending.count = sending.count - 1
		
				if(sending.color == "red") then
					sending = green_data
					red_count.text = tostring(red_data.count)
					asset = green_apple
				else
					sending = red_data
					green_count.text = tostring(green_data.count)
					asset = red_apple
				end
		
				node:set_output_data({
		
					asset = asset,
					color = sending.color,
					count = 1
		
				})
		
				local obj = World.SpawnAsset(asset, {parent = container})
				local line = node:get_top_connector_line()
				
				obj.x = line.x
				obj.y = line.y
				
				local tween = YOOTIL.Tween:new(.8, {a = 0}, {a = line.width})

				tween:on_complete(function()
					node:send_data()
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
	
			end
		end)
		
		task.repeatCount = 20
		task.repeatInterval = .8
	end
end)

API.register_node(node)

function Tick(dt)
	for _, i in ipairs(items) do
		if(i.tween ~= nil) then
			i.tween:tween(dt)
		end
	end
end