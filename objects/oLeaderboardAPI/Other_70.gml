/// @desc Google Play

if(async_load[? "type"] == "GooglePlayServices_Leaderboard_LoadTopScores") {
	if is_string(async_load[? "data"]) {
		var _array = json_parse(async_load[? "data"]);
		for(var i = 0; i < array_length(_array); i++) {
			array_push(scores,{
				name: _array[i].scoreHolderDisplayName,
				"score": _array[i].rawScore/1000
			});	
		}
	}
}

if(async_load[? "type"] == "GooglePlayServices_Player_Current") {
    if(async_load[?"success"]) {
		var _data = json_parse(async_load[? "player"]);
		username = _data.displayName;
		GooglePlayServices_Leaderboard_LoadPlayerCenteredScores(GOOGLEPLAYLEADERBOARDID,Leaderboard_TIME_SPAN_ALL_TIME, Leaderboard_COLLECTION_PUBLIC, 1, true);
	}
}

if(async_load[?"type"] == "GooglePlayServices_Leaderboard_LoadPlayerCenteredScores") {
	if is_string(async_load[? "data"]) {
		var _data = json_parse(async_load[? "data"]);
		if array_length(_data) != 0 {
			var _score = _data[0].rawScore/1000;
			if _score > personalBest {
				personalBest = _score;
				ini_open(SAVEFILE);
				ini_write_real("score","score",personalBest);
				ini_close();
			}
			currentRank = string(_data[0].rank);
			if (currentRank % 10 == 1 and currentRank != 11) currentRank += "st";
			else if (currentRank % 10 == 2 and currentRank != 11) currentRank += "nd";
			else if (currentRank % 10 == 3 and currentRank != 11) currentRank += "rd";
			else currentRank += "th";
			currentRank += " Place";
		}
	}
}