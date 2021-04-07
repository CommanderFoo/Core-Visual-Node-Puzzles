local nodes = script:GetCustomProperty("nodes"):WaitForObject()

local offset = 25
local children = nodes:GetChildren()

for i, c in ipairs(children) do
	c.y = offset
	c.x = 0
	offset = offset + 65
end