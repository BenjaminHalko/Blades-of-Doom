/// @desc

if instance_exists(creator) {
	x = xoffset+creator.x;
	y = yoffset+creator.y;
}

if instance_exists(sparkler) {
	if sparkler.sparkleTimer < 60 image_blend = c_red;
}