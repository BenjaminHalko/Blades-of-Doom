/// @desc Initialize Player

// Player
if(!variable_instance_exists(id,"player")) player = 0;

// Movement
hsp = 0;
vsp = 0;
hsp_f = 0;
vsp_f = 0;
hsp_final = 0;
vsp_final = 0;

grv = 0.6;
walkspd = 0.5;
maxwalk = 2;
jumpspd = -7;

canJump = 0;
jumpTimer = 0;

platform = noone;

image_blend = c_lime;