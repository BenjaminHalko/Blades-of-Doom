/// @desc Game Step

// Fullscreen
if (DESKTOP and (keyboard_check_pressed(vk_f4) or keyboard_check_pressed(vk_f11))) window_set_fullscreen(!window_get_fullscreen());

// Browser Resizing
ScaleCanvas();

// GUI
timePulse = ApproachFade(timePulse,0,0.1,0.6);
if oGameManager.time % 10 < lastTime timePulse = 1;
lastTime = oGameManager.time % 10;

//Screen Shake
shakeRemain = max(0, shakeRemain - ((1/shakeLength) * shakeMagnitude));

//Update Position
camera_set_view_pos(cam,random_range(-shakeRemain,shakeRemain),random_range(-shakeRemain,shakeRemain));