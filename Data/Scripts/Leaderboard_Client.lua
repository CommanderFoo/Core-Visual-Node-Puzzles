local LEADERBOARD_ROW = script:GetCustomProperty("LeaderboardRow")

local time_played_lb = script:GetCustomProperty("time_played_lb")
local entries = script:GetCustomProperty("entries"):WaitForObject()

local english = script:GetCustomProperty("english"):WaitForObject()
local french = script:GetCustomProperty("french"):WaitForObject()
local german = script:GetCustomProperty("german"):WaitForObject()
local spanish = script:GetCustomProperty("spanish"):WaitForObject()
local chinese = script:GetCustomProperty("chinese"):WaitForObject()
local language_stats = script:GetCustomProperty("language_stats"):WaitForObject()

local languages = { 0, 0, 0, 0, 0 }
local showing_stats = false

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

		str = str .. tostring(hours) .. " Hour"

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
	english.text = "0"
	french.text = "0"
	german.text = "0"
	spanish.text = "0"
	chinese.text = "0"

	languages = { 0, 0, 0, 0, 0 }
	
	local offset = 0

	if(Leaderboards.HasLeaderboards()) then
		local time_played_results = Leaderboards.GetLeaderboard(time_played_lb, LeaderboardType.GLOBAL)

		if(time_played_results ~= nil) then
			local counter = 1
			
			for k, v in pairs(time_played_results) do
				local lang = tonumber(v.additionalData)

				if(lang ~= nil and lang > 0) then
					languages[lang] = languages[lang] + 1
				end

				if(counter <= 100) then
					local entry = World.SpawnAsset(LEADERBOARD_ROW, { parent = entries })

					entry:FindDescendantByName("Position").text = tostring(counter)
					entry:FindDescendantByName("Name").text = v.name
					entry:FindDescendantByName("Time Played").text = long_time_string(v.score)

					entry.y = offset
					offset = offset + entry.height + 2
				end

				counter = counter + 1
			end
		end
	end
end)

updater.repeatInterval = 60
updater.repeatCount = -1

Input.actionPressedEvent:Connect(function(player, action)
	if(player.name ~= "CommanderFoo") then
		return
	end

	if(action == "Language Stats") then
		if(showing_stats) then
			language_stats.visibility = Visibility.FORCE_OFF
			showing_stats = false
		else
			english.text = tostring(languages[1])
			french.text = tostring(languages[2])
			german.text = tostring(languages[3])
			spanish.text = tostring(languages[4])
			chinese.text = tostring(languages[5])

			language_stats.visibility = Visibility.FORCE_ON
			showing_stats = true
		end
	end
end)