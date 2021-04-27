local Puzzle_Events = {}

Puzzle_Events.id = 1

function Puzzle_Events.on(evt, fn)
	table.insert(Puzzle_Events, #Puzzle_Events + 1, {
		
		event = evt,
		func = fn,
		id = Puzzle_Events.id
	
	})

	Puzzle_Events.id = Puzzle_Events.id + 1

	return Puzzle_Events.id - 1	
end

function Puzzle_Events.off(event_id)
	for i, e in ipairs(Puzzle_Events) do
		if(event_id == e.id) then
			Puzzle_Events[i] = nil
		end
	end
end

function Puzzle_Events.trigger(...)
	local args = {...}

	for i, e in ipairs(Puzzle_Events) do
		if(e.event == args[1]) then
			e.func(args[2], args[3], args[4], args[5])
		end
	end
end

return Puzzle_Events