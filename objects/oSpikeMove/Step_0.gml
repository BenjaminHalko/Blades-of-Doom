/// @desc

image_angle -= 6*image_xscale*GLOBALSPIN;
image_blend = merge_color(oGameManager.reverseSpikeColor,c_white,flash);
flash = ApproachFade(flash,0,0.1,0.8);

if point_in_rectangle(x,y,-20,INFO_HEIGHT-20,room_width+20,room_height+20) onScreen = true;
else if onScreen instance_destroy();

speed = ApproachFade(speed,spd*GLOBALSPD,0.5,0.8);