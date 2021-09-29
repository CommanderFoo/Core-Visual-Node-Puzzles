local time_played_lb = script:GetCustomProperty("time_played_lb")

Events.Connect("update_time_played", function(player, total_time, language_id)
	if(Leaderboards.HasLeaderboards()) then
		Leaderboards.SubmitPlayerScore(time_played_lb, player, total_time, language_id)
	end
end)