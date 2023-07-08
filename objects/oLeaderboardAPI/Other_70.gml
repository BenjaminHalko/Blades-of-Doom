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
			if (_data[0].rank % 10 == 1 and _data[0].rank != 11) currentRank += "st";
			else if (_data[0].rank % 10 == 2 and _data[0].rank != 11) currentRank += "nd";
			else if (_data[0].rank % 10 == 3 and _data[0].rank != 11) currentRank += "rd";
			else currentRank += "th";
			currentRank += " Place";
		}
	}
}

if(async_load[? "type"] == "GooglePlayServices_IsAuthenticated") {
	if(async_load[?"success"]) {
		if(async_load[?"isAuthenticated"]) {
			global.hasGooglePlayAccount = true;
			GooglePlayServices_Player_Current();
		} else if askForSignIn {
			ini_open(SAVEFILE);
			ini_write_real("settings","askForSignIn",false);
			ini_close();
			GooglePlayServices_SignIn();
		}
	}
}

if(async_load[?"type"] == "GooglePlayServices_SignIn") {
	if(async_load[?"success"]) {
		if(async_load[?"isAuthenticated"]) {
			global.hasGooglePlayAccount = true;
			GooglePlayServices_Player_Current();
			if googlePlayQueuedFunction == "Leaderboard"
				GooglePlayServices_Leaderboard_Show(GOOGLEPLAYLEADERBOARDID);
			else if googlePlayQueuedFunction == "Achievements"
				GooglePlayServices_Achievements_Show();
			googlePlayQueuedFunction = undefined;
		}
	}
}