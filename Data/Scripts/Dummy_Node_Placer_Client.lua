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

destroy_evt = script.destroyEvent:Connect(function()
	if(connect_evt.isConnected) then
		connect_evt:Disconnect()
	end

	if(destroy_evt.isConnected) then
		destroy_evt:Disconnect()
	end
end)