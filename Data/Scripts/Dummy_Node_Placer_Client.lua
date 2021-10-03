local Localization = require(script:GetCustomProperty("Localization"))
local nodes = script:GetCustomProperty("nodes"):WaitForObject()

local offset = 25
local children = nodes:GetChildren()

for i, c in ipairs(children) do
	c.x = 0
		
	if(c.name == "Reroute") then
		c.y = -75
	elseif(c.name == "View") then
		c.y = -20
	else
		c.y = offset
		offset = offset + 55
	end
end

local function translate()
	for i, child in ipairs(children) do
		local handle = child:FindDescendantByName("Node Handle")
		local a, b, c = CoreString.Split(child.name, " ")
		local key = a
		local str_num = ""

		if(b ~= nil and string.len(tostring(b)) > 1) then
			key = key .. "_" .. b
		elseif(b ~= nil and string.len(tostring(b)) == 1) then
			str_num = " " .. tostring(b)
		end

		if(c ~= nil and string.len(tostring(c)) == 1) then
			str_num = " " .. tostring(c)
		end

		handle.text = Localization.get_text("Node_" .. key) .. str_num
	end
end

translate()

local connect_evt = Events.Connect("translate", translate)
local destroy_evt = nil
local create_evt = Events.Connect("create_default_nodes", function()
	local output_nodes = {}

	for i, c in ipairs(children) do
		local s = c:FindDescendantByName("Spawn_Node")

		if(c.name == "Data") then
			s.context.create_node(-650)
		elseif(c.name:find("Output")) then
			table.insert(output_nodes, s)
		end
	end

	if(#output_nodes == 1) then
		output_nodes[1].context.create_node(600, 0)
	else
		local offset = 0

		if(#output_nodes == 2) then
			offset = 100
		elseif(#output_nodes == 3) then
			offset = 200
		elseif(#output_nodes == 4) then
			offset = 300
		elseif(#output_nodes == 5) then
			offset = 400
		end

		for i, s in ipairs(output_nodes) do
			s.context.create_node(440, -offset)

			offset = offset - 200
		end
	end
end)

destroy_evt = script.destroyEvent:Connect(function()
	if(connect_evt.isConnected) then
		connect_evt:Disconnect()
	end

	if(destroy_evt.isConnected) then
		destroy_evt:Disconnect()
	end

	if(create_evt.isConnected) then
		create_evt:Disconnect()
	end
end)