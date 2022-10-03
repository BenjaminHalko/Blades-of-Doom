function ActivateBlades(_bladeType,_waitTime,_chargeTime,_spikeLength) {
	with(oSpike) {
		if object_index != oSpike or spikeNum != _bladeType continue;
		maxCharge = _chargeTime*60;
		spikeLength = _spikeLength;
		var _handle = call_later(_waitTime+random_range(0,0.1),time_source_units_seconds,function() {
			charging = maxCharge;
		});
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
		ActivateBlades(5,0,2,25);
		ActivateBlades(13,4,2,25);
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
	ActivateBlades(choose(5,6,7,13,14,15),0,4,10);
	ActivateBlades(irandom_range(0,15),4,2,2);
	ActivateBlades(irandom_range(0,15),6,2,2);
}