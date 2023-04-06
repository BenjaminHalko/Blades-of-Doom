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
	if (gamepad_button_check_pressed(i,gp_select) or gamepad_button_check_pressed(i,gp_start)) {
		_gamepadEsc = true;
		break;
	}
}

if title and oSpikeManager.doneCreating {
	var _gamepadPressed = false;
	var _gamepadDir = 0;
	var _gamepadAudioDir = 0;
	
	for(var i = 0; i < gamepad_get_device_count(); i++) {
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
	
	if keyboard_check_pressed(vk_escape) and DESKTOP game_end();
	
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
			ini_open(SAVEFILE);
			ini_write_real("audio","audio",audioVol);
			ini_close();
		}
	} else if(keyboard_check_pressed(vk_enter) or keyboard_check_pressed(vk_space) or keyboard_check_pressed(vk_shift) or keyboard_check_pressed(vk_control) or (mouse_check_button_pressed(mb_left) and mouse_y > INFO_HEIGHT and MOBILE) or _gamepadPressed) GameStart(choice);
	
	if titlePercent != 1 {
		titlePercent = Approach(titlePercent,1,0.1);
		if titlePercent == 1 ScreenShake(10,20);
	}
}

if keyboard_check_pressed(vk_tab) or device_mouse_check_button_pressed(3,mb_left) {
	oRender.disable = !oRender.disable;
	application_surface_draw_enable(oRender.disable);
	ini_open(SAVEFILE);
	ini_write_real("graphics","bloomDisabled",oRender.disable);
	ini_close();
}

// Text Flash
if oGameManager.time % 10 < 9 or oGameManager.gameOver {
	timeColPercent = ApproachFade(timeColPercent,0,0.1,0.5);
	if timeColPercent == 0 timeCol = 0;
} else {
	timeColPercent = 1;
	timeCol++;
}

//MOBILE Controls
if MOBILE {
	if global.usingGamepad or (keyboard_check_pressed(vk_anykey) and !keyboard_check_pressed(vk_backspace)) usingOnScreenButtons = false;
	onScreenAlpha = Approach(onScreenAlpha,usingOnScreenButtons,0.1);
	var _jumpHeld = jumpScreen;
	var _top = screenButtonY-24;
	var _bottom = screenButtonY+24;
	leftScreen = false;
	rightScreen = false;
	jumpScreen = false;
	jumpIsPressed = false;
	
	for(var i = 0; i < 5; i++) {
		if(!device_mouse_check_button(i, mb_left) and !device_mouse_check_button(i, mb_right)) continue;
		usingOnScreenButtons = true;
		
		var _px = device_mouse_x(i);
		var _py = device_mouse_y(i);
		
		if(point_in_rectangle(_px,_py,leftScreenX-48,_top,leftScreenX+24,_bottom)) leftScreen = true;
		else if(point_in_rectangle(_px,_py,rightScreenX-24,_top,rightScreenX+48,_bottom)) rightScreen = true;
		else if(point_in_circle(_px,_py,jumpScreenX,screenButtonY,48)) {
			jumpScreen = true;
			if(!_jumpHeld) jumpIsPressed = true;
		}
	}
	
	if(keyboard_check_pressed(vk_backspace) and !BROWSER and title) game_end(); 
	
	
	if oSpikeManager.doneCreating and mouse_check_button_pressed(mb_left) {
			if point_in_rectangle(mouse_x,mouse_y,0,0,room_width/4,INFO_HEIGHT) {
				if title
					GooglePlayServices_Leaderboard_Show(GOOGLEPLAYLEADERBOARDID);
				else
					BackToMenu();
			}
			if point_in_rectangle(mouse_x,mouse_y,480-room_width/4,0,room_width,INFO_HEIGHT) {
				if title
					GooglePlayServices_Achievements_Show();
				else {
					GameStart(false);
				}
			}
	}
}

if !title and (keyboard_check_pressed(vk_backspace) or _gamepadEsc) and oLeaderboardAPI.replacingScore == -1 {
	BackToMenu();
}

if keyboard_check_pressed(vk_escape) and DESKTOP game_end();

// Lag Detector
if oRender.autoDetect {
	if fps < 45 {
		if ++autoDetectCounter >= 60 * 2 {
			oRender.autoDetect = false;
			oRender.disable = true;
			application_surface_draw_enable(true);
			ini_open(SAVEFILE);
			ini_write_real("graphics","bloomDisabled",true);
			ini_close();
		}
	} else autoDetectCounter = 0;
}