/// @desc Initialize Player

// Movement
hsp = 0;
vsp = 0;
hsp_f = 0;
vsp_f = 0;
hsp_final = 0;
vsp_final = 0;

grv = 0.6;
walkspd = 0.5+0.1*DELUXE;
maxwalk = 2.3;
jumpspd = -7-0.2*DELUXE;

canJump = 0;
jumpTimer = 0;

platform = noone;

scale = 1;
walkWave = 0;
forwardDir = 0;

invicibility = 0;
knockback = 0;

hp = MAXHEALTH;
noSpikeHit = false;
noPlatform = 0;

image_blend = c_lime;
if player == 2 image_blend = #FF8800;

sparkleTimer = 0;