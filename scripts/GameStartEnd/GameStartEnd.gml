function GameStart(_2players) {
	oGlobalController.title = false;
	var _platformTogetherness = 1.05;
	instance_destroy(oHeartPickup);
	with(oGameManager) {
		time = 0;
		gameStarted = false;
		gameOver = false;

		if !instance_exists(oPlatform) {
			for (var j = 0; j < 5; j++) {
				for (var i = abs(j-2)*10-8; i < room_height+PLATFORM_DIST; i += PLATFORM_DIST) {
					with(instance_create_layer(room_width/2-(room_width/2-room_width/6*(j+1))*_platformTogetherness,i-40*(j%2),"Platforms",oPlatform)) dir = (j%2)*2-1;
				}
			}
		}
		
		
	
		if _2players == 0 {
			if instance_exists(oPlayer) {
				oPlayer.x = room_width/2;
			} else players = [instance_create_layer(room_width/2,room_height/2,"Players",oPlayer),noone];
		} else {
			if instance_exists(oPlayer) {
				players[0].x = room_width/2-(room_width/2-room_width/6*2)*_platformTogetherness;
				players[1].x = room_width/2-(room_width/2-room_width/6*4)*_platformTogetherness;
			} else {
				players = [
					instance_create_layer(room_width/2-(room_width/2-room_width/6*2)*_platformTogetherness,room_height/2,"Players",oPlayer,{player: 1}),
					instance_create_layer(room_width/2-(room_width/2-room_width/6*4)*_platformTogetherness,room_height/2,"Players",oPlayer,{player: 2})];
			}
		}
		
		instance_destroy(oSpikeMove);
		instance_destroy(oSpikeChase);
		
		for(var i = 0; i <= _2players; i++) {
			var _spike = instance_find(oSpike,irandom(instance_number(oSpike)-1));
			var _dir = point_direction(room_width/2,(room_height-INFO_HEIGHT)/2+INFO_HEIGHT,_spike.x,_spike.y);
			with(instance_create_layer(_spike.x+lengthdir_x(20,_dir),_spike.y+lengthdir_y(20,_dir),layer,oSpikeChase)) target = other.players[i];
		}
	}
	
	with(oPlayer) {
		y = room_height/3;
		hp = MAXHEALTH;
		hsp = 0;
		vsp = 0;
		hsp_f = 0;
		vsp_f = 0;
		hsp_final = 0;
		vsp_final = 0;
		knockback = 0;
		platform = noone;
		canJump = 0;
		jumpTimer = 0;
	}
	
	with(oSpike) {
		if object_index != oSpike continue;
		chargePercent = 0;
		charging = -1;
	}
}

function BackToMenu() {
	instance_destroy(oPlayer);
	instance_destroy(oPlatform);
	instance_destroy(oSpikeChase);
	instance_destroy(oSpikeMove);
	instance_destroy(oHeartPickup);
	oLeaderboardAPI.displayPercent = 0;
	oLeaderboardAPI.replacingScore = -1;
	with(oGameManager) {
		time = 0;
		gameStarted = false;
		gameOver = false;
		players = [noone,noone];
	}
	oGlobalController.title = true;
	oGlobalController.titlePercent = 0;
}

function GameOver() {
	oGameManager.gameOver = true;
	keyboard_string = "";
	
	with(oLeaderboardAPI) {
		waiting = 40;
		if oGameManager.time > personalBest {
			newRecord = true;
			personalBest = oGameManager.time;
			ini_open(SAVEFILE);
			ini_write_real("score","score",personalBest);
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