/// @desc Initialize Game

platformSpd = 1;

for (var j = 0; j < 5; j++) {
	for (var i = INFO_HEIGHT/2; i < room_height+PLATFORM_DIST; i += PLATFORM_DIST) {
		with(instance_create_layer(room_width/6*(j+1),i,"Platforms",oPlatform)) dir = 1-(j%2)*2;
	}
}