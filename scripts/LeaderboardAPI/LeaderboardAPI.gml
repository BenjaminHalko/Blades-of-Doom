/// @desc Get the current leaderboards
function LeaderboardGet() {
	FirebaseRealTime("https://"+LEADERBOARDURL+"/").Path(LEADERBOARDID).Read();
}

/// @desc Post a score to the leaderboards
/// @param score
function LeaderboardPost(_score) {
	var _timestamp = string(floor(date_second_span(date_create_datetime(1970, 1, 1, 0, 0, 0),date_current_datetime())));
	FirebaseRealTime("https://"+LEADERBOARDURL+"/").Path(LEADERBOARDID+"/"+_timestamp+"/name").Set(_score.name);
	FirebaseRealTime("https://"+LEADERBOARDURL+"/").Path(LEADERBOARDID+"/"+_timestamp+"/score").Set(_score.score);
}