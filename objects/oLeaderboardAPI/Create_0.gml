/// @desc
httpID = undefined;
callback = undefined;

maxScores = 5;
scores = [];
username = "";

googlePlayQueuedFunction = undefined;

if global.online {
	if OPERA {
		try {
			gxc_challenge_get_global_scores(function(_status, _result) {
				try {
					if (_status == 200 and array_length(_result.data.scores) > 0) {
						var _array = _result.data.scores;
						for(var i = 0; i < array_length(_array); i++) {
							array_insert(scores,i,{
								name: _array[i].player.username,
								"score": _array[i].score/1000
							})	
						}
					}
				} catch(_error) {
					show_debug_message(_error);
				}
			},{challengeId: CHALLENGEID, page: 0, pageSize: 5});
		} catch(_error) {
			show_debug_message(_error);
		}
	
		try {
			username = gxc_get_query_param("username");
		} catch(_error) {
			show_debug_message(_error);
		}
	} else if (GOOGLEPLAY) {
		GooglePlayServices_IsAuthenticated();
		GooglePlayServices_Leaderboard_LoadTopScores(GOOGLEPLAYLEADERBOARDID,Leaderboard_TIME_SPAN_ALL_TIME, Leaderboard_COLLECTION_PUBLIC, 5, true);
	} else LeaderboardGet(maxScores,false,LEADERBOARDID);
}

waiting = 0;
displayPercent = 0;
replacingScore = -1;
newRecord = false;

flash = 0;

scores = [];
personalBest = 0;
currentRank = "";
askForSignIn = true;
if !file_exists(SAVEFILE) {
	ini_open(SAVEFILE);
	ini_write_real("score","score",0);
	ini_write_real("settings","askForSignIn",true);
	ini_close();
} else {
	ini_open(SAVEFILE);
	personalBest = ini_read_real("score","score",0);
	askForSignIn = ini_read_real("settings","askForSignIn",true);
	ini_close();
}

disableSendingScores = false;