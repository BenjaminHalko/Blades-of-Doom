function GameStart(_2players) {
	with(oGameManager) {
		platformSpd = 0;
		time = 0;
		gameStarted = false;
		gameOver = false;

		instance_destroy(oPlatform);
		for (var j = 0; j < 5; j++) {
			for (var i = 0; i < room_height+PLATFORM_DIST; i += PLATFORM_DIST) {
				with(instance_create_layer(room_width/2-(room_width/2-room_width/6*(j+1))*1.1,i-40*(j%2),"Platforms",oPlatform)) dir = (j%2)*2-1;
			}
		}
	
		if _2players == 0 {
			if instance_exists(oPlayer) {
				oPlayer.x = room_width/2;
			} else players = [instance_create_layer(room_width/2,room_height/2,"Players",oPlayer),noone];
		} else {
			if instance_exists(oPlayer) {
				players[0].x = room_width/2-(room_width/2-room_width/6*2)*1.1;
				players[1].x = room_width/2-(room_width/2-room_width/6*4)*1.1;
			} else {
				players = [
					instance_create_layer(room_width/2-(room_width/2-room_width/6*2)*1.1,room_height/2,"Players",oPlayer,{player: 1}),
					instance_create_layer(room_width/2-(room_width/2-room_width/6*4)*1.1,room_height/2,"Players",oPlayer,{player: 2})];
			}
		}
	}
	
	with(oPlayer) {
		y = room_height/3;
		hp = 3;
		hsp = 0;
		vsp = 0;
		hsp_f = 0;
		vsp_f = 0;
		hsp_final = 0;
		vsp_final = 0;
		knockback = 0;
		platform = noone;
	}
}

function BackToMenu() {
	instance_destroy(oPlayer);
	instance_destroy(oPlatform);
	time = 0;
	gameStarted = false;
}

function GameOver() {
	oGameManager.gameOver = true;
	keyboard_string = "";
	
	with(oLeaderboardAPI) {
		waiting = 40;
		if oGameManager.time > personalBest {
			newRecord = true;
			personalBest = oGameManager.time;
			ini_open("SAVEFILE.ini");
			ini_write_string("score","score",personalBest);
			ini_close();
		} else newRecord = false;
		for(var i = 0; i < min(array_length(scores)+1,maxScores); i++) {
			if i == array_length(scores) {
				array_insert(scores,i,{
					name: "",
					"score": oGameManager.time
				});
				replacingScore = i;
				break;
			} else if oGameManager.time > variable_struct_get(scores[i],"score") {
				array_insert(scores,i,{
					name: "",
					"score": oGameManager.time
				});
				if array_length(scores) > maxScores array_resize(scores,maxScores);
				replacingScore = i;
				break;
			}
		}
	}
}