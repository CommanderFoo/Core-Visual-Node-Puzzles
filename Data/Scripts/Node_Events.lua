local Node_Events = {}

function Node_Events.on(event, fn)
	if(Node_Events[event] == nil) then
		Node_Events[event] = {}
	end

	table.insert(Node_Events[event], #Node_Events[event] + 1, fn)
end

function Node_Events.trigger(...)
	local args = {...}

	if(Node_Events[args[1]] ~= nil) then
		for _, f in ipairs(Node_Events[args[1]]) do
			f(args[2], args[3], args[4], args[5])
		end
	end
end

return Node_Events