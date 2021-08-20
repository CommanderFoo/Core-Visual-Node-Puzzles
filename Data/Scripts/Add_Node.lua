local API = require(script:GetCustomProperty("API"))

local evts = {}
local node = nil

function init(node_data)
	node = API.Node_Type.Add:new(script.parent.parent, {

		node_time = 0.30

	})

	node:set_puzzle_type(API.Puzzle_Type.MATH)
	node:set_from_saved_data(node_data)

	API.register_node(node)
end

function Tick(dt)
	if(node ~= nil) then
		for _, i in ipairs(node:get_tweens()) do
			if(i.tween ~= nil) then
				i.tween:tween(dt)
			end
		end
	end
end

evts[#evts + 1] = Events.Connect("puzzle_edit", function()
	if(node == nil) then
		return
	end

	node:reset()
end)

script.destroyEvent:Connect(function()
	for k, e in ipairs(evts) do
		if(e.isConnected) then
			e:Disconnect()
		end
	end

	evts = nil
end)