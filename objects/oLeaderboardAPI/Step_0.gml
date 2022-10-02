/// @desc

enableLive;

if waiting == 0 and oGameManager.gameOver {
	if replacingScore != -1 {
		if keyboard_check_pressed(vk_enter) {
			if string_replace_all(scores[replacingScore].name," ","") != "" {
				LeaderboardPost(variable_struct_get(scores[replacingScore],"score"),scores[replacingScore].name,LEADERBOARDID);
				replacingScore = -1;
				GameStart(oGameManager.players[1] != noone);
				waiting = 30;
			} else {
				flash = 1;
				ScreenShake(5,5);
			}
		} else if keyboard_lastchar != "" {
			if string_length(keyboard_string) <= 10 scores[replacingScore].name = keyboard_string;
			keyboard_string = scores[replacingScore].name;
			keyboard_lastchar = "";
		}
	} else if keyboard_check_pressed(vk_enter) GameStart(oGameManager.players[1] != noone);
}

if waiting == 0 displayPercent = ApproachFade(displayPercent,oGameManager.gameOver,0.1,0.8);
else {
	waiting--;
	keyboard_string = "";
}

flash = ApproachFade(flash,0,0.1,0.8);