/// @desc

if oGlobalController.title exit;

if waiting == 0 and oGameManager.gameOver {
	var _gamepadEnter = false;
	for(var i = 0; i < gamepad_get_device_count(); i++) {
		for(var j = gp_face1; j <= gp_face4; j++) if(gamepad_button_check_pressed(i,j)) _gamepadEnter = true;
	}
	if replacingScore != -1 and disableSendingScores {
		scores[replacingScore].name = "PLAYER";
		replacingScore = -1;
	}
	if replacingScore != -1 {
		if MOBILE and mouse_check_button_pressed(mb_left) and !oGlobalController.leftScreen keyboard_virtual_show(kbv_type_ascii,kbv_returnkey_done,kbv_autocapitalize_words,true);
		if keyboard_check_pressed(vk_enter) or _gamepadEnter or oGlobalController.jumpIsPressed {
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
		} else if keyboard_lastkey != vk_nokey {
			if (keyboard_lastkey == vk_backspace or (ord(keyboard_lastchar) >= 32 and ord(keyboard_lastchar) <= 255)) and string_length(keyboard_string) <= 10 and (keyboard_lastkey != vk_space or string_length(scores[replacingScore].name) > 0) scores[replacingScore].name = keyboard_string;
			else keyboard_string = scores[replacingScore].name;
			keyboard_lastkey = vk_nokey;
		}
		if (keyboard_check(vk_control) and keyboard_check_pressed(ord("Z"))) or (MOBILE and device_mouse_check_button_pressed(2,mb_left) and oGlobalController.leftScreen) {
			scores[replacingScore].name = "PLAYER";
			replacingScore = -1;
			GameStart(oGameManager.players[1] != noone);
			keyboard_virtual_hide();
			disableSendingScores = true;
		}
	} else if keyboard_check_pressed(vk_enter) or _gamepadEnter or oGlobalController.jumpIsPressed GameStart(oGameManager.players[1] != noone);
}

if waiting == 0 displayPercent = ApproachFade(displayPercent,oGameManager.gameOver,0.1,0.8);
else {
	waiting--;
	keyboard_string = "";
	keyboard_lastkey = vk_nokey;
}

flash = ApproachFade(flash,0,0.1,0.8);