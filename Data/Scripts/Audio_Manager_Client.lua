local main_menu = script:GetCustomProperty("main_menu"):WaitForObject()
local sfx = script:GetCustomProperty("sfx"):WaitForObject()
local music_folder = script:GetCustomProperty("music"):WaitForObject()

local songs = music_folder:GetChildren()
local current = nil
local can_change_song = true
local total_play_time = 0
local allowed_play_time = 60

local function get_song_name(song_name)
	return song_name:match("\"(.+)\"")
end

local function get_random_song()
	local song = nil

	if(current == nil) then
		song = songs[math.random(1, #songs)]
	else
		repeat
			song = songs[math.random(1, #songs)]
		 until(song ~= current)
	end

	return song
end

local function play_song()
	if(can_change_song) then
		local old_name = nil

		if(current ~= nil) then
			old_name = current.name
			current:Stop()
		end

		total_play_time = 0
		current = get_random_song()
		current:Play()

		local new_name = get_song_name(current.name)

		Events.Broadcast("set_song_name", new_name)

		local log_str = "Changed song "

		if(old_name ~= nil) then
			log_str = log_str .. "from \"" .. get_song_name(old_name) .. "\""
		end

		log_str = log_str .. " to \"" .. new_name .. "\"."

		Events.Broadcast("add_log_message", log_str, "Info", false)
	end
end

function Tick(dt)
	if(current ~= nil) then
		print(total_play_time, current)

		if(total_play_time > allowed_play_time) then
			can_change_song = true
			play_song()
		else
			if(not current.isPlaying) then
				total_play_time = 0
				can_change_song = true
			else
				total_play_time = total_play_time + dt
			end
		end
	end
end

Events.Connect("set_sfx_volume", function(v)
	local fx_sounds = sfx:GetChildren()

	for _, s in ipairs(fx_sounds) do
		s.volume = v / 100
	end
end)

Events.Connect("stop_menu_music", function()
	main_menu:Stop()

	play_song()
end)

Events.Connect("play_menu_music", function()
	if(current ~= nil) then
		current:Stop()
	end
	
	main_menu:Play()
end)

Events.Connect("set_music_volume", function(v)
	main_menu.volume = v / 100

	for i, s in ipairs(songs) do
		s.volume = v / 100
	end
end)

Events.Connect("skip_song", function()
	can_change_song = true
	play_song()
end)