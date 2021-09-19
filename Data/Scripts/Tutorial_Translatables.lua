local Localization = require(script:GetCustomProperty("Localization"))

local function translate(keys, objs)
	for k, v in pairs(script:GetCustomProperties()) do
		if(k ~= "Localization") then
			local key = k

			if(k:find("_Exit")) then
				key = "Tutorial_Exit"
			elseif(k:find("_Next")) then
				key = "Tutorial_Next"
			end

			v:WaitForObject().text = Localization.get_text(key)
		end
	end
end

local connect_evt = Events.Connect("translate_tutorial", translate)
local destroy_evt = nil

destroy_evt = script.destroyEvent:Connect(function()
	if(connect_evt.isConnected) then
		connect_evt:Disconnect()
	end

	if(destroy_evt.isConnected) then
		destroy_evt:Disconnect()
	end
end)
