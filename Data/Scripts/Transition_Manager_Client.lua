local YOOTIL = require(script:GetCustomProperty("YOOTIL"))

local container = script:GetCustomProperty("container"):WaitForObject()
local transition = script:GetCustomProperty("transition"):WaitForObject()
local in_time = script:GetCustomProperty("in_time")
local out_time = script:GetCustomProperty("out_time")
local color = script:GetCustomProperty("color")

local loading = script:GetCustomProperty("loading"):WaitForObject()

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

local tween = nil
local shape_tween = nil

transition:SetColor(color)

function play_loading_animations()
	shape_tween = YOOTIL.Tween:new(.5, {x = -180, a = 0}, {x = 180, a = .8})

	local current_shape_index = math.random(1, #shapes)
	local current_shape = shapes[current_shape_index]
	
	for i, s in pairs(shapes) do
		s.color.a = 0

		s.image:SetColor(s.color)
	end
	
	loading.visibility = Visibility.FORCE_ON

	shape_tween:on_complete(function()
		current_shape_index = math.random(1, #shapes)
		current_shape = shapes[current_shape_index]
	
		shape_tween:reset()
	end)
	
	shape_tween:on_change(function(v)
		current_shape.image.x = v.x
		
		if(v.a >= .4) then
			v.a = .8 - v.a
		end
	
		current_shape.color.a = v.a
		current_shape.image:SetColor(current_shape.color)
	end)
	
	shape_tween:on_start(function()
		current_shape.color.a = 0
		current_shape.image:SetColor(current_shape.color)
	end)
end

function change(c)
	color.a = c.a
	transition:SetColor(color)
end

function Tick(dt)
	if(tween ~= nil) then
		tween:tween(dt)
	end

	if(shape_tween ~= nil) then
		shape_tween:tween(dt)
	end
end

function in_tween(fn, delay)
	tween = YOOTIL.Tween:new(in_time, {a = 0}, {a = 1})

	tween:on_start(function()
		color.a = 0

		transition:SetColor(color)
		container.visibility = Visibility.FORCE_ON
		Events.Broadcast("transition_start")

		play_loading_animations()
	end)

	tween:on_change(change)
	tween:on_complete(function()
		tween = nil
		Events.Broadcast("transition_complete")

		if(fn ~= nil) then
			fn()
		end
	end)

	tween:set_delay(delay or 0)
end

function out_tween(fn, delay)
	tween = YOOTIL.Tween:new(out_time, {a = 1}, {a = 0})

	tween:on_start(function()
		color.a = 1

		transition:SetColor(color)
		container.visibility = Visibility.FORCE_ON
		Events.Broadcast("transition_start")
	end)

	tween:on_change(change)
	tween:on_complete(function()
		tween = nil
		Events.Broadcast("transition_complete")
		loading.visibility = Visibility.FORCE_OFF
		shape_tween = nil

		if(fn ~= nil) then
			fn()
		end
	end)

	tween:set_delay(delay or 0)
end

Events.Connect("transition_out", out_tween)
Events.Connect("transition_in", in_tween)

play_loading_animations()