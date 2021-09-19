local Localization = require(script:GetCustomProperty("Localization"))

local function translate()
	for k, v in pairs(script:GetCustomProperties()) do
		if(k ~= "Localization") then
			v:WaitForObject().text = Localization.get_text(k)
		end
	end
end

Events.Connect("translate", translate)