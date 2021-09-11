local nodes = script:GetCustomProperty("nodes"):WaitForObject()

local offset = 25
local children = nodes:GetChildren()

for i, c in ipairs(children) do
	c.x = 0
		
	if(c.name == "Reroute Dummy Node") then
		c.y = -75
	elseif(c.name == "Viewer Dummy Node") then
		c.y = -20
	else
		c.y = offset
		offset = offset + 55
	end
end