local API, YOOTIL = require(script:GetCustomProperty("API"))

local red_count = script:GetCustomProperty("red_count"):WaitForObject()
local green_count = script:GetCustomProperty("green_count"):WaitForObject()
local white_count = script:GetCustomProperty("white_count"):WaitForObject()
local yellow_count = script:GetCustomProperty("yellow_count"):WaitForObject()
local blue_count = script:GetCustomProperty("blue_count"):WaitForObject()
local dark_green_count = script:GetCustomProperty("dark_green_count"):WaitForObject()

local red_apple = script:GetCustomProperty("red_apple")
local green_apple = script:GetCustomProperty("green_apple")
local white_apple = script:GetCustomProperty("white_apple")
local yellow_apple = script:GetCustomProperty("yellow_apple")
local blue_apple = script:GetCustomProperty("blue_apple")
local dark_green_apple = script:GetCustomProperty("dark_green_apple")

local container = script:GetCustomProperty("container"):WaitForObject()

local data = {
	
	{ condition = "red", count = 10, ui = red_count, asset = red_apple },
	{ condition = "green", count = 10, ui = green_count, asset = green_apple },
	{ condition = "white", count = 10, ui = white_count, asset = white_apple },
	{ condition = "yellow", count = 10, ui = yellow_count, asset = yellow_apple },
	{ condition = "blue", count = 10, ui = blue_count, asset = blue_apple },
	{ condition = "dark green", count = 10, ui = dark_green_count, asset = dark_green_apple}

}

for _, d in pairs(data) do
	d.ui.text = "25"
	d.count = 25
end

local tween_items = {}

API.register_node(API.Node_Type.Data:new(script.parent.parent, {

	tween_items = tween_items,
	container = container,
	data_items = data,
	YOOTIL = YOOTIL,
	repeat_interval = 0.1,
	tween_duration = .8

}))

function Tick(dt)
	for _, i in ipairs(tween_items) do
		if(i.tween ~= nil) then
			i.tween:tween(dt)
		end
	end
end