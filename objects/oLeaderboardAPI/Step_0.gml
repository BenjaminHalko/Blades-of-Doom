/// @desc

if oGlobalController.title exit;

if waiting == 0 and oGameManager.gameOver {
	var _gamepadEnter = false;
	for(var i = 0; i < gamepad_get_device_count(); i++) {
		for(var j = gp_face1; j <= gp_face4; j++) if(gamepad_button_check_pressed(i,j)) _gamepadEnter = true;
	}
	if replacingScore != -1 {
		if MOBILE keyboard_virtual_show(kbv_type_default,kbv_returnkey_done,kbv_autocapitalize_words,true);
		if keyboard_check_pressed(vk_enter) or _gamepadEnter {
			if string_replace_all(scores[replacingScore].name," ","") != "" {
				LeaderboardPost(variable_struct_get(scores[replacingScore],"score"),scores[replacingScore].name,LEADERBOARDID);
				replacingScore = -1;
				GameStart(oGameManager.players[1] != noone);
				waiting = 30;
			} else {
				flash = 1;
				ScreenShake(5,5);
			}
			keyboard_virtual_hide();
		} else if keyboard_lastchar != "" {
			if string_length(keyboard_string) <= 10 and (keyboard_lastchar != " " or string_length(scores[replacingScore].name) > 0) scores[replacingScore].name = keyboard_string;
			keyboard_string = scores[replacingScore].name;
			keyboard_lastchar = "";
		}
	} else if keyboard_check_pressed(vk_enter) or _gamepadEnter GameStart(oGameManager.players[1] != noone);
}

if waiting == 0 displayPercent = ApproachFade(displayPercent,oGameManager.gameOver,0.1,0.8);
else {
	waiting--;
	keyboard_string = "";
}

flash = ApproachFade(flash,0,0.1,0.8);