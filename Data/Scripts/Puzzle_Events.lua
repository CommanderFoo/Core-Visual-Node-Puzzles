local Puzzle_Events = {}

function Puzzle_Events.on(event, fn)
	if(Puzzle_Events[event] == nil) then
		Puzzle_Events[event] = {}
	end

	table.insert(Puzzle_Events[event], #Puzzle_Events[event] + 1, fn)
end

function Puzzle_Events.trigger(...)
	local args = {...}

	if(Puzzle_Events[args[1]] ~= nil) then
		for _, f in ipairs(Puzzle_Events[args[1]]) do
			f(args[2], args[3], args[4], args[5])
		end
	end
end

return Puzzle_Events