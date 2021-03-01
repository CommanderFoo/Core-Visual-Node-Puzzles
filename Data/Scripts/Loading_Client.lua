local YOOTIL = require(script:GetCustomProperty("YOOTIL"))

local square = script:GetCustomProperty("square"):WaitForObject()
local circle = script:GetCustomProperty("circle"):WaitForObject()
local triangle = script:GetCustomProperty("triangle"):WaitForObject()

local shapes = {

	[1] = {
		
		image = square,
		color = square:GetColor()

	},

	[2] = {

		image = circle,
		color = circle:GetColor()

	},

	[3] = {

		image = triangle,
		color = triangle:GetColor()
		
	}

}

local tween = YOOTIL.Tween:new(.5, {x = -180, a = 0}, {x = 180, a = .8})

local current_shape_index = math.random(1, #shapes)
local current_shape = shapes[current_shape_index]

tween:on_complete(function()
	current_shape_index = math.random(1, #shapes)
	current_shape = shapes[current_shape_index]

	tween:reset()
end)

tween:on_change(function(v)
	current_shape.image.x = v.x
	
	if(v.a >= .4) then
		v.a = .8 - v.a
	end

	current_shape.color.a = v.a
	current_shape.image:SetColor(current_shape.color)
end)

tween:on_start(function()
	current_shape.color.a = 0
	current_shape.image:SetColor(current_shape.color)
end)


function Tick(dt)
	tween:tween(dt)
end