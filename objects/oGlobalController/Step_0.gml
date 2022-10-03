/// @desc Game Step

// Fullscreen
if (DESKTOP and (keyboard_check_pressed(vk_f4) or keyboard_check_pressed(vk_f11))) window_set_fullscreen(!window_get_fullscreen());

// Browser Resizing
ScaleCanvas();

// GUI
timePulse = ApproachFade(timePulse,0,0.1,0.6);

//Screen Shake
shakeRemain = max(0, shakeRemain - ((1/shakeLength) * shakeMagnitude));

//Update Position
camera_set_view_pos(cam,random_range(-shakeRemain,shakeRemain),random_range(-shakeRemain,shakeRemain));

var _gamepadEsc = false;
for(var i = 0; i < gamepad_get_device_count(); i++) {
	if (gamepad_button_check_pressed(i,gp_select)) {
		_gamepadEsc = true;
		break;
	}
}

if title and !instance_exists(oSpikeCreator) {
	var _gamepadPressed = false;
	var _gamepadDir = 0;
	var _gamepadAudioDir = 0;
	
	for(var i = 0; i < gamepad_get_device_count(); i++) {
		if DESKTOP and gamepad_button_check_pressed(i,gp_start) window_set_fullscreen(!window_get_fullscreen());
		for(var j = gp_face1; j <= gp_face4; j++) if(gamepad_button_check_pressed(i,j)) _gamepadPressed = true;
		_gamepadDir = (gamepad_button_check(i,gp_padd) or gamepad_axis_value(i,gp_axislv) >= 0.5) - (gamepad_button_check(i,gp_padu) or gamepad_axis_value(i,gp_axislv) <= -0.5);
		_gamepadAudioDir = (gamepad_button_check(i,gp_padr) or gamepad_axis_value(i,gp_axislh) >= 0.5) - (gamepad_button_check(i,gp_padl) or gamepad_axis_value(i,gp_axislh) <= -0.5);
		if !MOBILE and (_gamepadDir != 0 or _gamepadAudioDir != 0) and alarm[0] <= 0 {
			alarm[0] = 20;
			break;
		} else {
			_gamepadDir = 0;
			_gamepadAudioDir = 0;
		}
	}
	if(_gamepadPressed) global.usingGamepad = true;
	
	if (keyboard_check_pressed(vk_escape) or _gamepadEsc) and DESKTOP game_end();
	
	var _dir = median(-1,1,((keyboard_check_pressed(vk_down) or keyboard_check_pressed(ord("S"))) - (keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("W"))))+_gamepadDir);
	if !MOBILE and _dir != 0 {
		choice += _dir;
		if choice < 0 choice = 2;
		else if choice > 2 choice = 0;
		audio_play_sound(snSelect,1,false);
	}
	
	if choice == 2 {
		_dir = median(-1,1,((keyboard_check_pressed(vk_right) or keyboard_check_pressed(ord("D"))) - (keyboard_check_pressed(vk_left) or keyboard_check_pressed(ord("A"))))+_gamepadAudioDir);
		if _dir != 0 {
			audioVol = median(audioVol+0.1*_dir,0,1);
			audio_master_gain(audioVol);
			audio_play_sound(snSelect,1,false);
		}
	} else if(keyboard_check_pressed(vk_enter) or keyboard_check_pressed(vk_space) or keyboard_check_pressed(vk_shift) or keyboard_check_pressed(vk_control) or (mouse_check_button_pressed(mb_left) and MOBILE) or _gamepadPressed) GameStart(choice);
	
	if titlePercent != 1 {
		titlePercent = Approach(titlePercent,1,0.1);
		if titlePercent == 1 ScreenShake(10,20);
	}
}

if !title and (keyboard_check_pressed(vk_escape) or _gamepadEsc) {
	BackToMenu();
}