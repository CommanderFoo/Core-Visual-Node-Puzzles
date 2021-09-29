local time_played_lb = script:GetCustomProperty("time_played_lb")
local entries = script:GetCustomProperty("entries"):WaitForObject()

local function long_time_string(the_time)
	if(not the_time) then
		return "--"
	end

	local days = math.floor(the_time / 86400)
	local hours = math.floor((the_time % 86400) / 3600)
	local minutes = math.floor((the_time % 3600) / 60)
	local seconds = math.floor(the_time % 60)

	local str = ""

	if(days > 0) then
		str = tostring(days) .. " Day"

		if(days > 1) then
			str = str .. "s"	
		end
	end

	if(hours > 0) then
		if(string.len(str) > 0) then
			str = str .. ", "
		end

		str = str .. tostring(hours) .. " Min"

		if(hours > 1) then
			str = str .. "s"	
		end
	end

	if(minutes > 0) then
		if(string.len(str) > 0) then
			str = str .. ", "
		end

		str = str .. tostring(minutes) .. " Min"

		if(minutes > 1) then
			str = str .. "s"	
		end
	end

	if(string.len(str) == 0) then
		str = seconds .. " Sec"

		if(seconds > 1) then
			str = str .. "s"	
		end
	end

	return str
end

local updater = Task.Spawn(function()
	if(Leaderboards.HasLeaderboards()) then
		local time_played_results = Leaderboards.GetLeaderboard(time_played_lb, LeaderboardType.GLOBAL)

		if(time_played_results ~= nil) then
			local counter = 1

			for k, v in pairs(time_played_results) do
				if(counter == 11) then
					break
				end

				local entry = entries:GetChildren()[counter]

				if(entry ~= nil) then
					entry:FindDescendantByName("Name").text = v.name
					entry:FindDescendantByName("Time Played").text = long_time_string(v.score)
				end
			
				counter = counter + 1
			end
		end
	end
end)

updater.repeatInterval = 60
updater.repeatCount = -1