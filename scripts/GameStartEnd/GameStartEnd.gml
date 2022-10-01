function GameStart(_2players) {
	platformSpd = 0;
	time = 0;
	gameStarted = false;
	gameOver = false;

	if !instance_exists(oPlatform) {
		for (var j = 0; j < 5; j++) {
			for (var i = 0; i < room_height+PLATFORM_DIST; i += PLATFORM_DIST) {
				with(instance_create_layer(room_width/2-(room_width/2-room_width/6*(j+1))*1.1,i-40*(j%2),"Platforms",oPlatform)) dir = (j%2)*2-1;
			}
		}
	}
	
	if _2players == 0 {
		if instance_exists(oPlayer) {
			oPlayer.x = room_width/2;
		} else players = [instance_create_layer(room_width/2,room_height/2,"Players",oPlayer),noone];
	} else {
		if instance_exists(oPlayer) {
			players[0].x = room_width/2-(room_width/2-room_width/6*2)*1.1;
			players[1].y = room_width/2-(room_width/2-room_width/6*4)*1.1;
		} else {
			players = [
				instance_create_layer(room_width/2-(room_width/2-room_width/6*2)*1.1,room_height/2,"Players",oPlayer,{player: 1}),
				instance_create_layer(room_width/2-(room_width/2-room_width/6*4)*1.1,room_height/2,"Players",oPlayer,{player: 2})];
		}
	}
	
	with(oPlayer) {
		y = room_height/2;
		visible = true;
		hp = 3;
		hsp = 0;
		vsp = 0;
		hsp_f = 0;
		vsp_f = 0;
		hsp_final = 0;
		vsp_final = 0;
	}
}

function BackToMenu() {
	instance_destroy(oPlayer);
	instance_destroy(oPlatform);
	time = 0;
	gameStarted = false;
}