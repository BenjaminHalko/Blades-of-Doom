function ActivateBlades(_bladeType,_waitTime,_chargeTime,_spikeLength,_shotType=SHOT.NORMAL) {
	var _x, _y, _dir;
	var _width = 80;
	if _bladeType >= 13 {
		_dir = 0;
		_x = 0;
		_y = room_height - (room_height-INFO_HEIGHT)/3 * (_bladeType-13) - (room_height-INFO_HEIGHT)/6;
	} else if _bladeType >= 8 {
		_dir = 90;
		_x = room_width - (room_width/2-(room_width/2-room_width/6*(_bladeType+1-8))*PLATFORM_SPACING);
		_y = room_height;
	} else if _bladeType >= 5 {
		_dir = 180;
		_x = room_width;
		_y = INFO_HEIGHT + (room_height-INFO_HEIGHT)/3 * (_bladeType-5) + (room_height-INFO_HEIGHT)/6;
	} else {
		_dir = -90;
		_x = room_width/2-(room_width/2-room_width/6*(_bladeType+1))*PLATFORM_SPACING;
		_y = INFO_HEIGHT;
	}
		
	if _bladeType == 0 or _bladeType == 12 {
		_x -= 10;
		_width += 20;
	} else if _bladeType == 4 or _bladeType == 8 {
		_x += 10;
		_width += 20;
	} else if (_bladeType >= 5 and _bladeType <= 7) or _bladeType >= 13 _width -= 2;
	
	if DELUXE {
		with(instance_create_layer(_x,_y,"Bars",oSpikeWarning)) {
			barDir = _dir;
			wait = _waitTime*60+20;
			timeLeft = _chargeTime*60;
			maxTime = timeLeft-10;
			barWidth = _width;
		}
		
		ds_list_add(oGameManager.sawList,{
			time: _waitTime*60,
			charge: _chargeTime*60,
			spikeNum: _bladeType,
			x: _x,
			y: _y
		});
		
		if _shotType == SHOT.WAVE {
			var _random = random(1);
			var _random2 = random_range(1.35,1.65);
			for(var j = 0; j < _spikeLength; j += 0.2) {
				var _len = sin((j/_random2+_random)*pi)*_width/2;
				ds_list_add(oGameManager.sawList,{
					dir: _dir,
					x: _x - lengthdir_x(j*30,_dir) + lengthdir_x(_len,_dir+90),
					y: _y - lengthdir_y(j*30,_dir) + lengthdir_y(_len,_dir+90),
					time: _waitTime*60+_chargeTime*60,
					sawstart: _chargeTime*60
				});
			}
		} else if _shotType == SHOT.TRIANGLE {
			for(var i = -_width/2; i < _width/2; i += SPIKE_DIST) {
				for(var j = 0; j <= _spikeLength-1; j += 0.8) {
					var _dist = -j*30-abs(round(i/SPIKE_DIST)*SPIKE_DIST);
					ds_list_add(oGameManager.sawList,{
						dir: _dir,
						x: _x + lengthdir_x(_dist,_dir) + lengthdir_x(i+4,_dir+90),
						y: _y + lengthdir_y(_dist,_dir) + lengthdir_y(i,_dir+90),
						time: _waitTime*60+_chargeTime*60,
						sawstart: _chargeTime*60
					});
				}
			}
		} else {
			for(var i = -_width/2; i < _width/2; i += SPIKE_DIST) {
				var _newWaitTime = (_waitTime+random_range(0,0.1))*60;
				for(var j = 0; j < _spikeLength; j ++) {
					var _dist = -j*30-random_range(25,35);
					ds_list_add(oGameManager.sawList,{
						dir: _dir,
						x: _x + lengthdir_x(_dist,_dir) + lengthdir_x(i+4,_dir+90),
						y: _y + lengthdir_y(_dist,_dir) + lengthdir_y(i,_dir+90),
						time: _newWaitTime+_chargeTime*60,
						sawstart: _chargeTime*60
					});
				}
			}
		}
	} else {
		with(oSpikeManager) {
			for(var i = 0; i < ds_list_size(spikes); i++) {
				if spikes[| i].spikeNum != _bladeType continue;
		
				spikes[| i].maxCharge = _chargeTime*60;
				spikes[| i].spikeLength = _spikeLength;
				spikes[| i].timer = (_waitTime+random_range(0,0.1))*60+1;
			}
		}
	}
}

function BladeAttackVertical() {
	if irandom(1) == 0 {
		ActivateBlades(4,0,2,4);
		ActivateBlades(9,1,2,4);
		ActivateBlades(2,2,2,4);
		ActivateBlades(11,3,2,4);
	} else {
		ActivateBlades(12,0,2,4);	
		ActivateBlades(1,1,2,4);
		ActivateBlades(10,2,2,4);
		ActivateBlades(3,3,2,4);
	}
}

function BladeAttackVerticalFast() {
	if irandom(1) == 0 {
		ActivateBlades(4,0,3,1,SHOT.TRIANGLE);
		ActivateBlades(9,0.5,3,1,SHOT.TRIANGLE);
		ActivateBlades(2,1,3,1,SHOT.TRIANGLE);
		ActivateBlades(11,1.5,3,1,SHOT.TRIANGLE);
		ActivateBlades(0,2,3,1,SHOT.TRIANGLE);
	} else {
		ActivateBlades(12,0,3,1,SHOT.TRIANGLE);	
		ActivateBlades(1,0.5,3,1,SHOT.TRIANGLE);
		ActivateBlades(10,1,3,1,SHOT.TRIANGLE);
		ActivateBlades(3,1.5,3,1,SHOT.TRIANGLE);
		ActivateBlades(8,2,3,1,SHOT.TRIANGLE);
	}
}

function BladeAttackVerticalSuperFast() {
	if irandom(1) == 0 {
		ActivateBlades(0,0,3,5);
		ActivateBlades(1,0.25,3,5);
		ActivateBlades(2,0.5,3,5);
		ActivateBlades(3,0.75,3,5);
		ActivateBlades(8,3,3,5);
		ActivateBlades(9,3.25,3,5);
		ActivateBlades(10,3.5,3,5);
		ActivateBlades(11,3.75,3,5);
	} else {
		ActivateBlades(4,0,2,8);
		ActivateBlades(3,0.5,2,8);
		ActivateBlades(2,1,2,8);
		ActivateBlades(1,1.5,2,5);
		ActivateBlades(12,3,2,8);
		ActivateBlades(11,3.5,2,8);
		ActivateBlades(10,4,2,8);
		ActivateBlades(9,4.5,2,5);
	}
}

function BladeAttackVerticalSuperFastHalf() {
	ActivateBlades(0,0,2,5);
	ActivateBlades(1,0.25,2,5);
	ActivateBlades(2,0.5,2,5);
	ActivateBlades(8,2.5,2,5);
	ActivateBlades(9,2.75,2,5);
	ActivateBlades(10,3,2,5);
	ActivateBlades(0,5.25,1,5);
	ActivateBlades(1,5.5,1,5);
	ActivateBlades(8,6.25,1,5);
	ActivateBlades(9,6.5,1,5);
	ActivateBlades(2,7.5,1,1,SHOT.TRIANGLE);
	ActivateBlades(10,7.5,1,1,SHOT.TRIANGLE);
}

function BladeAttackHorizontal() {
	if irandom(1) == 0 {
		ActivateBlades(5,0,2,25,SHOT.WAVE);
		ActivateBlades(13,4,2,25,SHOT.WAVE);
	} else {
		ActivateBlades(13,0,2,25,SHOT.WAVE);
		ActivateBlades(5,4,2,25,SHOT.WAVE);
	}
}

function BladeAttackAllOld() {
	if irandom(1) == 0 {
		for(var i = 0; i < 8; i++) {
			ActivateBlades(i,i,2,2);	
		}
	} else {
		for(var i = 8; i < 16; i++) {
			ActivateBlades(i,i-8,2,2);	
		}	
	}
}

function BladeAttackAll() {
	if irandom(1) == 0 {
		for(var i = 0; i < 8; i++) {
			ActivateBlades(i,i,2,1,SHOT.TRIANGLE);	
		}
	} else {
		for(var i = 8; i < 16; i++) {
			ActivateBlades(i,i-8,2,1,SHOT.TRIANGLE);	
		}	
	}
}

function BladeAttackRandom2Old() {
	ActivateBlades(choose(0,1,2,3,4,8,9,10,11,12),0,4,10,SHOT.WAVE);
	ActivateBlades(choose(5,7,13,15),0,4,10,SHOT.WAVE);
	ActivateBlades(irandom_range(0,15),4,2,2,SHOT.TRIANGLE);
	ActivateBlades(irandom_range(0,15),6,2,2,SHOT.TRIANGLE);
}

function BladeAttackRandom2() {
	ActivateBlades(choose(0,1,2,3,4,8,9,10,11,12),0,3,10,SHOT.WAVE);
	ActivateBlades(choose(5,7,13,15),0,3,10,SHOT.WAVE);
	ActivateBlades(irandom_range(0,15),3,1.5,1,SHOT.TRIANGLE);
	ActivateBlades(irandom_range(0,15),5,1.5,1,SHOT.TRIANGLE);
	ActivateBlades(irandom_range(0,15),7,1.5,1,SHOT.TRIANGLE);
}

function BladeAttackCorners() {
	
	ActivateBlades(12,0,1,1,SHOT.TRIANGLE);
	ActivateBlades(4,0,1,1,SHOT.TRIANGLE);
	ActivateBlades(15,1,1,1,SHOT.TRIANGLE);
	ActivateBlades(0,1,1,1,SHOT.TRIANGLE);
	ActivateBlades(7,2,1,1,SHOT.TRIANGLE);
	ActivateBlades(8,2,1,1,SHOT.TRIANGLE);
	ActivateBlades(5,3,1,1,SHOT.TRIANGLE);
	ActivateBlades(4,3,1,1,SHOT.TRIANGLE);
	ActivateBlades(12,4,1,1,SHOT.TRIANGLE);
	ActivateBlades(13,4,1,1,SHOT.TRIANGLE);
	
	ActivateBlades(2,5,1,1,SHOT.TRIANGLE);
	ActivateBlades(10,5,1,1,SHOT.TRIANGLE);
}

function BladeAttackVerticalDoubleSides() {
	ActivateBlades(0,0,2,1,SHOT.TRIANGLE);
	ActivateBlades(2,0,2,1,SHOT.TRIANGLE);
	ActivateBlades(4,0,2,1,SHOT.TRIANGLE);
	ActivateBlades(9,1.5,2,1,SHOT.TRIANGLE);
	ActivateBlades(11,1.5,2,1,SHOT.TRIANGLE);
	ActivateBlades(8,3,2,1,SHOT.TRIANGLE);
	ActivateBlades(10,3,2,1,SHOT.TRIANGLE);
	ActivateBlades(12,3,2,1,SHOT.TRIANGLE);
	ActivateBlades(1,4.5,2,1,SHOT.TRIANGLE);
	ActivateBlades(3,4.5,2,1,SHOT.TRIANGLE);
}

function BladeAttackVerticalRandom() {
	ActivateBlades(choose(0,1,2,3,4,8,9,10,11,12),0,1,1,SHOT.TRIANGLE);
	ActivateBlades(choose(0,1,2,3,4,8,9,10,11,12),1,1,1,SHOT.TRIANGLE);
	ActivateBlades(choose(0,1,2,3,4,8,9,10,11,12),2,1,1,SHOT.TRIANGLE);
	ActivateBlades(choose(0,1,2,3,4,8,9,10,11,12),3,1,1,SHOT.TRIANGLE);
	ActivateBlades(choose(0,1,2,3,4,8,9,10,11,12),4,1,1,SHOT.TRIANGLE);
	ActivateBlades(choose(0,1,2,3,4,8,9,10,11,12),5,1,1,SHOT.TRIANGLE);
	ActivateBlades(choose(0,1,2,3,4,8,9,10,11,12),6,1,1,SHOT.TRIANGLE);
	ActivateBlades(choose(0,1,2,3,4,8,9,10,11,12),7,1,1,SHOT.TRIANGLE);
}

function BladeAttackSideWalls() {
	if irandom(1) == 0 {
		ActivateBlades(0,0,2,70,SHOT.WAVE);
		ActivateBlades(4,0,2,70,SHOT.WAVE);
		var _spot = -1;
		var _lastSpot = _spot;
		for(var i = 3; i <= 7; i++) {
			while(_spot == _lastSpot) _spot = choose(9,10,11);
			_lastSpot = _spot;
			ActivateBlades(_spot,i,1,1,SHOT.TRIANGLE);
		}
	} else {
		ActivateBlades(12,0,2,70,SHOT.WAVE);
		ActivateBlades(8,0,2,70,SHOT.WAVE);
	
		var _spot = -1;
		var _lastSpot = _spot;
		for(var i = 3; i <= 7; i++) {
			while(_spot == _lastSpot) _spot = choose(1,2,3);
			_lastSpot = _spot;
			ActivateBlades(_spot,i,1,1,SHOT.TRIANGLE);
		}
	}
}

function BladeAttackSides() {
	ActivateBlades(13,0,2,1,SHOT.TRIANGLE);
	ActivateBlades(15,0,2,1,SHOT.TRIANGLE);
	ActivateBlades(7,0,2,1,SHOT.TRIANGLE);
	ActivateBlades(5,0,2,1,SHOT.TRIANGLE);
	ActivateBlades(4,0.5,2,1,SHOT.TRIANGLE);
	ActivateBlades(8,0.5,2,1,SHOT.TRIANGLE);
	ActivateBlades(12,0.5,2,1,SHOT.TRIANGLE);
	ActivateBlades(0,0.5,2,1,SHOT.TRIANGLE);
}