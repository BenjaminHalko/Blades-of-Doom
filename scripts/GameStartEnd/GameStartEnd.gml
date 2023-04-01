function GameStart(_2players) {
	oGlobalController.title = false;
	instance_destroy(oHeartPickup);
	instance_destroy(oSparklePickup);
	instance_destroy(oSlowPickup);
	instance_destroy(oSpikeWarning);
	audio_stop_sound(snSparkle);
	with(oGameManager) {
		notHit = true;
		heartCount = 0;
		powerUpCount = 0;
		jumpCount = 0;
		time = 0;
		gameStarted = false;
		gameOver = false;
		slowTimer = 0;
		ds_list_clear(sawList);

		if !instance_exists(oPlatform) {
			for (var j = 0; j < 5; j++) {
				for (var i = abs(j-2)*10-8; i < room_height; i += PLATFORM_DIST) {
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
		
		ds_list_clear(oSpikeManager.spikesMove);
		instance_destroy(oSpikeChase);
		
		for(var i = 0; i <= _2players; i++) {
			var _spike = oSpikeManager.spikes[| irandom(ds_list_size(oSpikeManager.spikes)-1)];
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
		invicibility = 0;
	}
	
	with(oSpikeManager) {
		for(var i = 0; i < ds_list_size(spikes); i++) {
			spikes[| i].chargePercent = 0;
			spikes[| i].charging = -1;
			spikes[| i].timer = -1;
		}
	}
}

function BackToMenu() {
	instance_destroy(oPlayer);
	instance_destroy(oPlatform);
	instance_destroy(oSpikeChase);
	instance_destroy(oSpikeWarning);
	instance_destroy(oHeartPickup);
	instance_destroy(oSparklePickup);
	instance_destroy(oSlowPickup);
	ds_list_clear(oSpikeManager.spikesMove);
	oLeaderboardAPI.displayPercent = 0;
	oLeaderboardAPI.replacingScore = -1;
	with(oGameManager) {
		time = 0;
		gameStarted = false;
		gameOver = false;
		players = [noone,noone];
		ds_list_clear(sawList);
	}
	with(oSpikeManager) {
		for(var i = 0; i < ds_list_size(spikes); i++) {
			spikes[| i].chargePercent = 0;
			spikes[| i].charging = -1;
			spikes[| i].timer = -1;
		}
	}
	oGlobalController.title = true;
	oGlobalController.titlePercent = 0;
}

function GameOver() {
	oGameManager.gameOver = true;
	keyboard_string = "";
	keyboard_lastkey = vk_nokey;
	
	with(oLeaderboardAPI) {
		waiting = 40;
		if oGameManager.time > personalBest {
			newRecord = true;
			personalBest = oGameManager.time;
			ini_open(SAVEFILE);
			ini_write_real("score","score",personalBest);
			ini_close();
		} else newRecord = false;
		if global.online {
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
					replacingScore = i;
					break;
				}
			}
			
			if (OUTSIDELEADERBOARD) {
				if (replacingScore != -1) {
					if is_string(username) and username != "" scores[replacingScore].name = username;
					else scores[replacingScore].name = "PLAYER";
					
					// Ranking
					if (GOOGLEPLAY and scores[replacingScore].score >= personalBest) {
						currentRank = string(replacingScore+1);
						if currentRank == 1 currentRank += "st";
						else if currentRank == 2 currentRank += "nd";
						else if currentRank == 3 currentRank += "rd";
						else currentRank += "th";
						currentRank += " Place";
					}
					
					// Remove duplicate names
					for(var i = 0; i < min(array_length(scores),maxScores); i++) {
						if i == replacingScore continue;
						if scores[i].name == scores[replacingScore].name {
							if i < replacingScore array_delete(scores,replacingScore,1);
							else array_delete(scores,i,1);
							break;
						}
					}
					
					replacingScore = -1;
				}
				
				if (OPERA) {
					try {
						try {
							gxc_challenge_submit_score(oGameManager.time*1000,undefined,{challengeId: CHALLENGEID});
						} catch(_error) {
							show_debug_message(_error);
						}
					}
				} else {
					GooglePlayServices_Leaderboard_SubmitScore(GOOGLEPLAYLEADERBOARDID,oGameManager.time*1000,"");	
				}
			} else if MOBILE and replacingScore != -1 keyboard_virtual_show(kbv_type_ascii,kbv_returnkey_done,kbv_autocapitalize_words,true);
			
			if array_length(scores) > maxScores array_resize(scores,maxScores);
		}
	}
}