function GameStart(_2players) {
	oGlobalController.title = false;
	instance_destroy(oHeartPickup);
	instance_destroy(oSparklePickup);
	instance_destroy(oSpikeWarning);
	with(oGameManager) {
		time = 0;
		gameStarted = false;
		gameOver = false;
		slowTimer = 0;

		if !instance_exists(oPlatform) {
			for (var j = 0; j < 5; j++) {
				for (var i = abs(j-2)*10-8; i < room_height+PLATFORM_DIST; i += PLATFORM_DIST) {
					with(instance_create_layer(room_width/2-(room_width/2-room_width/6*(j+1))*PLATFORM_SPACING,i-40*(j%2),"Platforms",oPlatform)) dir = (j%2)*2-1;
				}
			}
		}
		
		if _2players == 0 {
			if instance_exists(oPlayer) {
				oPlayer.x = room_width/2;
			} else players = [instance_create_layer(room_width/2,room_height/2,"Players",oPlayer),noone];
		} else {
			if instance_exists(oPlayer) {
				players[0].x = room_width/2-(room_width/2-room_width/6*2)*PLATFORM_SPACING;
				players[1].x = room_width/2-(room_width/2-room_width/6*4)*PLATFORM_SPACING;
			} else {
				players = [
					instance_create_layer(room_width/2-(room_width/2-room_width/6*2)*PLATFORM_SPACING,room_height/2,"Players",oPlayer,{player: 1}),
					instance_create_layer(room_width/2-(room_width/2-room_width/6*4)*PLATFORM_SPACING,room_height/2,"Players",oPlayer,{player: 2})];
			}
		}
		
		instance_destroy(oSpikeMove);
		instance_destroy(oSpikeChase);
		
		for(var i = 0; i <= _2players; i++) {
			var _spike = instance_find(oSpike,irandom(instance_number(oSpike)-1));
			var _dir = point_direction(room_width/2,(room_height-INFO_HEIGHT)/2+INFO_HEIGHT,_spike.x,_spike.y);
			with(instance_create_layer(_spike.x+lengthdir_x(20,_dir),_spike.y+lengthdir_y(20,_dir),layer,oSpikeChase)) target = other.players[i];
		}
		
		specialItemWaitTime = 15*60;
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
		noSpikeHit = false;
		noPlatform = 0;
		sparkleTimer = 0;
	}
	
	with(oSpike) {
		if object_index != oSpike continue;
		chargePercent = 0;
		charging = -1;
		alarm[0] = -1;
	}
}

function BackToMenu() {
	instance_destroy(oPlayer);
	instance_destroy(oPlatform);
	instance_destroy(oSpikeChase);
	instance_destroy(oSpikeMove);
	instance_destroy(oSpikeWarning);
	instance_destroy(oHeartPickup);
	instance_destroy(oSparklePickup);
	oLeaderboardAPI.displayPercent = 0;
	oLeaderboardAPI.replacingScore = -1;
	with(oGameManager) {
		time = 0;
		gameStarted = false;
		gameOver = false;
		players = [noone,noone];
	}
	with(oSpike) {
		if object_index != oSpike continue;
		chargePercent = 0;
		charging = -1;
		alarm[0] = -1;
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
					name: ""
				});
				variable_struct_set(scores[i],"score",oGameManager.time);
				replacingScore = i;
				break;
			} else if oGameManager.time > scores[i].score {
				array_insert(scores,i,{
					name: ""
				});
				variable_struct_set(scores[i],"score",oGameManager.time);
				if array_length(scores) > maxScores array_resize(scores,maxScores);
				replacingScore = i;
				break;
			}
		}
		if (OPERA) {
			if (replacingScore != -1) {
				if is_string(username) scores[replacingScore].name = username;
				else scores[replacingScore].name = "PLAYER";
				replacingScore = -1;
			}
			try {
				try gxc_challenge_submit_score(oGameManager.time*1000,undefined,{challengeId: CHALLENGEID});
				catch(_error) show_debug_message(_error);
			}
		}
	}
}