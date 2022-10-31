function Spike(_x,_y) constructor {
	spikeIndex = 0;
	image_blend = c_fuchsia;
	flash = 0;
	spikeNum = 0;
	charging = -1;
	chargePercent = 0;
	maxCharge = 120;
	spikeLength = 10;

	waveSpdX = 0;
	waveSpdY = 0;
	waveXOffset = random_range(0.8,1.2);
	waveYOffset = random_range(0.8,1.2);
	image_angle = 0;
	x = _x;
	y = _y;
	timer = -1;
	image_xscale = 1;
	
	static step = function() {
		if timer != -1 {
			if timer <= 0 charging = maxCharge;
			timer = max(timer - 1, -1);
		}
		
		image_angle -= (6+chargePercent*4)*GLOBALSPIN;
		flash = ApproachFade(flash,0,0.1,0.8);
		if (charging != -1) chargePercent = (maxCharge-charging)/maxCharge;
		else chargePercent = ApproachFade(chargePercent,0,0.02,0.8);
		if flash == 0 image_blend = oGameManager.spikeColor;
		else image_blend = merge_color(oGameManager.spikeColor,c_white,flash);

		if (charging > 0) charging--;
		else if charging == 0 {
			charging = -1;
	
			if !DELUXE {
				for(var i = 0; i < spikeLength; i++) {
					var _dist = random_range(25,35);
					var _x = lengthdir_x(30*i+_dist,(1-spikeIndex)*90);
					var _y = lengthdir_y(30*i+_dist,(1-spikeIndex)*90);
		
					var _spike = new SpikeMove(x+_x,y+_y,(3-spikeIndex)*90);
					if (spikeNum == 7 or spikeNum == 13) and spikeLength >= 10 {
						_spike.spikeIndex = 2;
					}
					ds_list_add(oSpikeManager.spikesMove,_spike);
				}
			}
		}

		waveSpdX += chargePercent*waveXOffset*0.7;
		waveSpdY += chargePercent*waveYOffset*0.7;

		image_xscale = 1+chargePercent*0.5;
		
		with(oPlayer) {
			if rectangle_in_circle(bbox_left,bbox_top,bbox_right,bbox_bottom,other.x,other.y,6) {
				with(other) SpikeDamage(other.id);
			}
		}
	}
	
	static draw = function() {
		var _x = x;
		var _y = y;
		if chargePercent != 0 {
			_x = x+lerp(-2,2,sin(waveSpdX)/pi*2)*chargePercent;
			_y = y+lerp(-2,2,sin(waveSpdY)/pi*2)*chargePercent;
			_x -= lengthdir_x(2*chargePercent,90-spikeIndex*90);
			_y -= lengthdir_y(2*chargePercent,90-spikeIndex*90);
		}
		draw_sprite_ext(sSpike,0,_x,_y,image_xscale,image_xscale,image_angle,image_blend,1-chargePercent);
		if chargePercent != 0 draw_sprite_ext(sSpike,0,_x,_y,image_xscale,image_xscale,image_angle,oGameManager.reverseSpikeColor,chargePercent);
	}
}

function SpikeMove(_x,_y,_dir) constructor {
	flash = 0;
	spikeIndex = -1;
	onScreen = false;
	spd = ((oGameManager.time/10)*(0.25-0.1*DELUXE)+6);
	minSpd = 4;
	speed = max(minSpd,spd*GLOBALSPD);
	direction = _dir;
	image_angle = 0;
	image_blend = c_white;
	x = _x;
	y = _y;
	
	static step = function() {
		if point_in_rectangle(x,y,-20,INFO_HEIGHT-20,room_width+20,room_height+20) onScreen = true;
		else if onScreen return 1;
		
		if onScreen {
			image_angle -= 6*GLOBALSPIN;
			image_blend = merge_color(oGameManager.reverseSpikeColor,c_white,flash);
			flash = ApproachFade(flash,0,0.1,0.8);
			
			var _angle = image_angle;
			with(oPlayer) {
				if !visible continue;
				if sparkleTimer > 0 and point_in_circle(other.x,other.y,x,y,18) {
					with(instance_create_depth(other.x,other.y,layer_get_depth(layer_get_id("Spikes"))-1,oSpikeDestroy)) image_angle = _angle;
					return 1;
				} else if rectangle_in_circle(bbox_left,bbox_top,bbox_right,bbox_bottom,other.x,other.y,6) {
					with(other) {
						if SpikeDamage(other.id,true) return 1;
					}
				}
			}
		}

		speed = ApproachFade(speed,max(minSpd,spd*GLOBALSPD),0.5,0.8);
		x += lengthdir_x(speed,direction);
		y += lengthdir_y(speed,direction);
		return 0;
	}
	
	static draw = function() {
		if onScreen draw_sprite_ext(sSpike,0,x,y,1,1,image_angle,image_blend,1);
	}
}

function SpikeDamage(_player,_moving=false,_chasing=false) {
	if !_player.visible return 0;

	if _player.sparkleTimer > 0 and _moving {
		with(instance_create_depth(x,y,layer_get_depth(layer_get_id("Spikes"))-1,oSpikeDestroy)) image_angle = other.image_angle;
		return 1;
	}
	
	if spikeIndex == 2 {
		_player.vsp = -12;
		if _moving _player.vsp = -9;
		_player.knockback = 0;
	} else if spikeIndex == 0 {
		_player.knockback = 0;
		_player.vsp = max(_player.vsp,0.1);
		_player.noPlatform = 8;
		_player.noSpikeHit = 5;
	} else if spikeIndex == 1 {
		if !_player.noSpikeHit _player.knockback = -1;
		_player.vsp = -7;
	} else if spikeIndex == 3 {
		_player.knockback = 1;
		if !_player.noSpikeHit _player.vsp = -7;
	} else if _player.sparkleTimer == 0 {
		_player.knockback = sign(_player.x-x);
		if !_player.noSpikeHit _player.vsp = -7;
		else _player.noPlatform = 3;
	}

	if _player.invicibility == 0 and _player.hp > 0 and _player.sparkleTimer == 0 {
		_player.invicibility = 60*2;
		_player.hp--;
		if _player.hp <= 0 {
			_player.invicibility = 0;
			_player.deathTimer = 30;
			_player.knockback = sign(_player.x-x);
			if _player.knockback == 0 _player.knockback = 1;
			oGameManager.scores[max(0,_player.player-1)] = oGameManager.time;
			if oGameManager.players[0].hp == 0 and (oGameManager.players[1] == noone or oGameManager.players[1].hp == 0) GameOver();
		}
		oGlobalController.heartPulse[max(0,_player.player-1)] = 1;
		ScreenShake(6,10);
		audio_play_sound(snHurt,1,false);
	
	} else {
		ScreenShake(3,5);
		if _player.sparkleTimer > 0 and _chasing {
			audio_stop_sound(snSawDestroy);
			audio_play_sound(snSawDestroy,0.3,false,1,0,1.2);	
		}
		if (!audio_is_playing(snHurt)) {
			if DELUXE audio_play_sound(snHurt,1,false,0.55,0,0.95);
			else audio_play_sound(snHurt,1,false);
		}
	}
	flash = 1;
	return 0;
}