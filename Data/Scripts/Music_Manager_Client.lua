local music_folder = script:GetCustomProperty("music_folder"):WaitForObject()

local songs = music_folder:GetChildren()

local local_player = Game.GetLocalPlayer()
local current = nil
local can_change_song = true

function get_random_song()
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

function Tick()
	if(current ~= nil and not current.isPlaying) then
		can_change_song = true
	end
end

function play_music()
	if(local_player:GetResource("sfx_volume") > 0 and can_change_song) then
		current = get_random_song()
		
		print(current.name)

		current.volume = local_player:GetResource("sfx_volume") / 10
		current:Play()
	end
end

--Events.Connect("play_music", play_music)