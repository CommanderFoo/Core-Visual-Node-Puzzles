local API, YOOTIL = require(script:GetCustomProperty("API"))

local root = script:FindTemplateRoot()
local red_count = root:GetCustomProperty("red_count"):WaitForObject()
local green_count = root:GetCustomProperty("green_count"):WaitForObject()

local red_apple = root:GetCustomProperty("red_apple")
local green_apple = root:GetCustomProperty("green_apple")

local container = root:GetCustomProperty("container"):WaitForObject()

local node = API.Node:new(script)

local red_data = {	

	color = "Red",
	count = 10

}

local green_data = {

	color = "Green",
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
		
				if(sending.color == "Red") then
					sending = green_data
					red_count.text = tostring(red_data.count)
					asset = green_apple
				else
					sending = red_data
					green_count.text = tostring(green_data.count)
					asset = red_apple
				end
		
				node:set_output_data({
		
					type = "Apple",
					color = sending.color,
					count = 1
		
				})
		
				local obj = World.SpawnAsset(asset, {parent = container})
				local line = node:get_top_connector_line()
				
				
				local tween = YOOTIL.Tween:new(.8, {a = 0}, {a = line.width})

				tween:on_complete(function()
					node:send_data()
					obj:Destroy()
					tween = nil
				end)

				tween:on_change(function(changed)
					local angle = line.rotationAngle
					local rad = angle * (math.pi / 180)

					obj.x = (changed.a * math.cos(rad))
					obj.y = (changed.a * math.sin(rad)) - 30
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