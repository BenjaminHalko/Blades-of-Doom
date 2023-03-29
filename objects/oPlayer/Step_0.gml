/// @desc Movement

if !visible {
	if !oGameManager.gameStarted and oLeaderboardAPI.displayPercent < 0.05 visible = true;
	exit;
}

//Input
var _gpLeft = false;
var _gpRight = false;
var _gpJump = false;
var _keyLeft = false;
var _keyRight = false;
var _keyJump = false;
if hp != 0 {
	for(var i = 0; i < gamepad_get_device_count(); i++) {
		if(gamepad_button_check(i,gp_padl) or gamepad_axis_value(i,gp_axislh) <= -0.05) _gpLeft = true;
		if(gamepad_button_check(i,gp_padr) or gamepad_axis_value(i,gp_axislh) >= 0.05) _gpRight = true;
		for(var j = gp_face1; j <= gp_face4; j++) if(gamepad_button_check_pressed(i,j)) _gpJump = true;
	}

	if(_gpLeft or _gpRight or _gpJump) global.usingGamepad = true;

	if(player == 0) or (player == 2 and global.usingGamepad) {
		_keyLeft = keyboard_check(vk_left) or keyboard_check(ord("A")) or oGlobalController.leftScreen or (_gpLeft and player == 0);
		_keyRight = keyboard_check(vk_right) or keyboard_check(ord("D")) or oGlobalController.rightScreen or (_gpRight and player == 0);
		_keyJump = keyboard_check_pressed(vk_space) or keyboard_check_pressed(vk_shift) or keyboard_check_pressed(vk_control) or keyboard_check_pressed(vk_up) or keyboard_check_pressed(ord("W")) or oGlobalController.jumpIsPressed or (_gpJump and player == 0);	
	} else if(global.usingGamepad) { 
		_keyLeft = _gpLeft;
		_keyRight = _gpRight;
		_keyJump = _gpJump;
	} else if(player == 1) {
		_keyLeft = keyboard_check(ord("A"));
		_keyRight = keyboard_check(ord("D"));
		_keyJump = keyboard_check_pressed(vk_space) or keyboard_check_pressed(ord("W"));
	} else {
		_keyLeft = keyboard_check(vk_left);	
		_keyRight = keyboard_check(vk_right);
		_keyJump = keyboard_check_pressed(vk_shift) or keyboard_check_pressed(vk_control) or keyboard_check_pressed(vk_up);
	}
} else {
	with(instance_create_layer(x,y,layer,oPlayerExplode)) color = other.image_blend;
	visible = false;
	x = -100;
	exit;
}

if(_keyLeft or _keyRight) and !oGameManager.gameStarted {
	oGameManager.gameStarted = true;
}

// Movement
hsp = Approach(hsp,0,0.3);
if knockback != 0 {
	hsp = median(-maxwalk,maxwalk,hsp+sign(knockback)*8);
	_keyLeft = 0;
	_keyRight = 0;
} else hsp = median(-maxwalk,maxwalk,hsp+(_keyRight - _keyLeft)*walkspd);
vsp += grv;

if(_keyJump) jumpTimer = 10;

if((canJump-- > 0) && jumpTimer > 0) {
	vsp = jumpspd;
	canJump = 0;
	jumpTimer = 0;
	audio_play_sound(snJump,1,false);
}

jumpTimer--;

// Moving Platform
if platform != noone and platform.bbox_bottom < room_height and platform.bbox_top > INFO_HEIGHT {
	y = platform.bbox_top;
}

if _keyLeft or _keyRight walkWave += 1/10;	
else walkWave = pi*1.5;

hsp_final = hsp + hsp_f;
hsp_f = hsp_final - floor(abs(hsp_final))*sign(hsp_final);
hsp_final -= hsp_f;
 
vsp_final = vsp + vsp_f;
vsp_f = vsp_final - floor(abs(vsp_final))*sign(vsp_final);
vsp_final -= vsp_f;

// Collision
var _landed = platform == noone;
platform = collision_line(bbox_left,y+sign(vsp_final),bbox_left+hsp_final,y+vsp_final,oPlatform,false,false);
if platform == noone platform = collision_line(bbox_right,y+sign(vsp_final),bbox_right+hsp_final,y+vsp_final,oPlatform,false,false);
if noPlatform > 0 {
	platform = noone;
	noPlatform--;
}

x += hsp_final;

if platform != noone and (y <= platform.bbox_top or (vsp > 0 and noPlatform <= 0)) {
	y = platform.bbox_top;
	vsp_final = 0;
	vsp = 0;
	knockback = 0;
	canJump = 10;
	noSpikeHit = false;
	if (_landed) audio_play_sound(snLand,1,false);
} else platform = noone;

y += vsp_final;

x = clamp(x,4,room_width-4);
y = clamp(y,INFO_HEIGHT+8,room_height);

if y == room_height vsp = jumpspd;

forwardDir = Approach(forwardDir,3*(_keyRight-_keyLeft)*(platform != noone),0.4);
scale = ApproachFade(scale,median(1.5,0.5,platform != noone ? lerp(0.05,0.4,0.5+sin(walkWave*pi)/2)*(_keyLeft or _keyRight)+1 : vsp / -4),0.6+0.3*(vsp_final <= 0),0.7);

invicibility = max(0,invicibility-1);
sparkleTimer = max(0,sparkleTimer-1);

if sparkleTimer > 0 {
	var _dir = random(360);
	with(instance_create_depth(x+lengthdir_x(8,_dir),y+lengthdir_y(8,_dir)-4,depth+1,oSparkle)) {
		if irandom(1) != 0 creator = other.id;
		xoffset = x-other.x;
		yoffset = y-other.y;
		sparkler = other.id;
	}
}