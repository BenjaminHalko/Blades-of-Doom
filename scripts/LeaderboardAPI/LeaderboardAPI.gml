/// @desc Get the current leaderboards
/// @param {real} numberOfScores
/// @param {bool} ascending
/// @param {string} challengeID
/// @param {function} callback
function LeaderboardGet(_scores,_ascend,_challengeID,_callback) {
	if !instance_exists(oLeaderboardAPI) instance_create_depth(0,0,0,oLeaderboardAPI);
	var _url = "https://lb.userdefined.io/games/"+_challengeID+"?page=1&pagesize="+string(_scores);
	if (_ascend) _url += "&asc=true";
	oLeaderboardAPI.httpID = http_get(_url);
	oLeaderboardAPI.callbackFunction = _callback;
}

/// @desc Post a score to the leaderboards
/// @param {real} score
/// @param {string} name
/// @param {string} challengeID
function LeaderboardPost(_score,_name,_challengeID) {
	if !instance_exists(oLeaderboardAPI) instance_create_depth(0,0,0,oLeaderboardAPI);
	var _data = {
		name: _name,
		score: _score,
		game: _challengeID
	};
	var _header = ds_map_create();
	_header[? "Content-Type"] = "application/json";
	http_request("https://lb.userdefined.io/games/submit","POST",_header,json_stringify(_data));
	ds_map_destroy(_header);
}