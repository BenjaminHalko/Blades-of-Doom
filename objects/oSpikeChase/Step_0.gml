/// @desc

image_angle -= 6*image_xscale*GLOBALSPIN;
image_blend = merge_color(oGameManager.reverseSpikeColor,c_white,flash);
flash = ApproachFade(flash,0,0.1,0.8);

if !oGameManager.gameStarted exit;

if !target.visible {
	image_xscale = ApproachFade(image_xscale,0,0.05,0.8);
	image_yscale = image_yscale;
} else if knockback > 0 {
	x += lengthdir_x(knockback,knockbackDir);
	y += lengthdir_y(knockback,knockbackDir);
	knockback = Approach(knockback,0,0.3);
} else {
	dir = ApproachCircleEase(dir,point_direction(x,y,target.x,target.y),3,0.8);
	x += lengthdir_x(spd,dir);
	y += lengthdir_y(spd,dir);
	var _sp
	spd = ApproachFade(spd,(0.5-0.1*DELUXE+floor(oGameManager.time/10)*0.02)*GLOBALSPD,0.01,0.8);
}