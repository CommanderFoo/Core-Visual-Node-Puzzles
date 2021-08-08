local Puzzle_Events = {

	events = {},
	id = 1

}

function Puzzle_Events.on(evt, fn)
	Puzzle_Events.id = Puzzle_Events.id + 1

	Puzzle_Events.events[tostring(Puzzle_Events.id)] = {
		
		event = evt,
		func = fn,
		id = Puzzle_Events.id
	
	}

	return Puzzle_Events.id
end

function Puzzle_Events.off(event_id)
	for k, e in pairs(Puzzle_Events.events) do
		if(event_id == e.id) then
			Puzzle_Events.events[k] = nil
		end
	end
end

function Puzzle_Events.trigger(...)
	local args = {...}

	for i, e in pairs(Puzzle_Events.events) do
		if(e.event == args[1]) then
			e.func(args[2], args[3], args[4], args[5])
		end
	end
end

return Puzzle_Events