function ActivateBlades(_bladeType,_waitTime,_chargeTime,_spikeLength) {
	with(oSpike) {
		if object_index != oSpike or spikeNum != _bladeType continue;
		maxCharge = _chargeTime*60;
		spikeLength = _spikeLength;
		alarm[0] = (_waitTime+random_range(0,0.1))*60+1;
	}
	
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
		
		for(var i = -_width/2; i < _width/2; i += SPIKE_DIST) {
			var _newWaitTime = (_waitTime+random_range(0,0.1))*60;
			for(var j = 0; j < _spikeLength; j++) {
				var _dist = -30*j-random_range(25,35);
				ds_list_add(oGameManager.sawList,{
					dir: _dir,
					x: _x + lengthdir_x(_dist,_dir) + lengthdir_x(i+4,_dir+90),
					y: _y + lengthdir_y(_dist,_dir) + lengthdir_y(i,_dir+90),
					time: _newWaitTime+_chargeTime*60
				});
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
		ActivateBlades(4,0,3,1);
		ActivateBlades(9,0.5,3,1);
		ActivateBlades(2,1,3,1);
		ActivateBlades(11,1.5,3,1);
		ActivateBlades(0,2,3,1);
	} else {
		ActivateBlades(12,0,3,1);	
		ActivateBlades(1,0.5,3,1);
		ActivateBlades(10,1,3,1);
		ActivateBlades(3,1.5,3,1);
		ActivateBlades(8,2,3,1);
	}
}

function BladeAttackHorizontal() {
	if irandom(1) == 0 {
		ActivateBlades(5,0,2,25);
		ActivateBlades(13,4,2,25);
	} else {
		ActivateBlades(13,0,2,25);
		ActivateBlades(5,4,2,25);
	}
}

function BladeAttackAll() {
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

function BladeAttackRandom2() {
	ActivateBlades(choose(0,1,2,3,4,8,9,10,11,12),0,4,10);
	ActivateBlades(choose(5,7,13,15),0,4,10);
	ActivateBlades(irandom_range(0,15),4,2,2);
	ActivateBlades(irandom_range(0,15),6,2,2);
}