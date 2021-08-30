local nodes = script:GetCustomProperty("nodes"):WaitForObject()

local offset = 25
local children = nodes:GetChildren()

for i, c in ipairs(children) do
	if(c.name == "Reroute Dummy Node") then
		c.x = 0
		c.y = -20
	else
		c.y = offset
		c.x = 0
		offset = offset + 65
	end
end