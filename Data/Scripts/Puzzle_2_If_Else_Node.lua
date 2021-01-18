local API, YOOTIL = require(script:GetCustomProperty("API"))

local container = script:GetCustomProperty("container"):WaitForObject()
local dropdown_event = script:GetCustomProperty("dropdown_event")

local if_condition = nil
local items = {}

function insert(obj)
	table.insert(items, #items + 1, obj)
end

API.register_node(API.Node:new(script.parent.parent, {

	on_data_received = function(data, node)
		if(node:has_top_connection() or node:has_bottom_connection()) then
			local condition = (data.color == if_condition)
			local obj = nil
			local line = API.get_connector_line(node, condition)
			local tween = API.create_tween(line)
			local connection_method = nil
			local offset = 0

			if(condition and node:has_top_connection()) then
				obj = World.SpawnAsset(data.asset, {parent = container})
				connection_method = "send_data_top"
				insert({
					
					obj = obj,
					tween = tween
				
				})
			elseif(node:has_bottom_connection()) then
				offset = API.get_bottom_offset(node)
				obj = World.SpawnAsset(data.asset, {parent = container})
				connection_method = "send_data_bottom"
				insert({
					
					obj = obj,
					tween = tween
				
				})
			else
				node:has_errors(true)
			end

			if(tween ~= nil and connection_method ~= nil) then
				tween:on_complete(function()
					node[connection_method](node, data)
					obj:Destroy()
					tween = nil
				end)
	
				tween:on_change(function(changed)
					local x, y = API.get_path(obj, line, changed, offset)
					
					obj.x = x
					obj.y = y
				end)
			end
		else
			node:has_errors(true)
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

Events.Connect("on_" .. dropdown_event .. "_selected", function(index, option, value)
	if_condition = string.lower(option.text)
end)

--[[

node:data_received(function(data)
	if(dropdown_event == "color_2") then
		print("data recevied", data.color)
	end

	if(data == nil) then
		return
	end

	if(data and data.asset and (node:has_top_connection() or node:has_bottom_connection())) then
		local condition = (data.color == if_condition)
		local obj = nil
		local line = get_connector_line(data, condition)
		local tween = create_tween(line)
		local connection_method = nil
		local offset = 0

		if(condition and node:has_top_connection()) then
			obj = World.SpawnAsset(data.asset, {parent = container})
			connection_method = "send_data_top_connection"
			insert({
				
				obj = obj,
				tween = tween
			
			})

			data.top = true
		elseif(node:has_bottom_connection()) then
			obj = World.SpawnAsset(data.asset, {parent = container})
			offset = node:get_bottom_connector().y / 2
			connection_method = "send_data_bottom_connection"
			insert({
				
				obj = obj,
				tween = tween
			
			})

			data.bottom = true
		else
			node:has_errors(true)
		end

		if(tween ~= nil and connection_method ~= nil) then
			tween:on_complete(function()
				node:set_output_data(data)
				node:send_data()
				--node[connection_method](node, data)
				obj:Destroy()
				tween = nil
			end)

			tween:on_change(function(changed)
				local x, y = API.get_path(obj, line, changed, offset)
				
				obj.x = x
				obj.y = y
			end)
		end
	else
		node:has_errors(true)
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

Events.Connect("on_" .. dropdown_event .. "_selected", function(index, option, value)
	if_condition = string.lower(option.text)
end)--]]