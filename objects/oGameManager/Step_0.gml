/// @desc Game Logic

if gameStarted platformSpd = ApproachFade(platformSpd,(1+floor(time/10)*0.2)*(1-(time%20 >= 10)*2)*GLOBALSPD,0.7,0.8);	
else platformSpd = ApproachFade(platformSpd,0,0.7,0.8);
slowTimer = max(0,slowTimer-1);

if (gameStarted and !gameOver) {
	specialItemWaitTime = max(0,specialItemWaitTime-1);
	time += 1/60;
	if oGameManager.time % 10 < lastTime {
		oGlobalController.timePulse = 1;
		lastSpikeColor = spikeColor;
		newSpikeColor = make_color_hsv(Wrap(color_get_hue(newSpikeColor)+random_range(20,70),0,255),255,255);
		spikeColorChange = 0;
		if firstRound {
			BladeAttackVertical();
			firstRound = false;
		} else if DELUXE {
			var _max = easyWaves;
			if time >= 60 _max = array_length(attackFunctions)-1;
			else if time >= 30 _max = normalWaves;
			attackFunctions[irandom(_max)]();
		}
		else attackFunctionsOriginal[irandom(array_length(attackFunctionsOriginal)-1)]();
	}
	lastTime = oGameManager.time % 10;
}

if spikeColorChange == 1 and spikeColor != newSpikeColor {
	spikeColor = newSpikeColor;
	reverseSpikeColor = make_color_hsv((color_get_hue(spikeColor)+128)%255,255,255);
} else {
	spikeColorChange = ApproachFade(spikeColorChange,1,0.1,0.8);
	spikeColor = merge_color(lastSpikeColor,newSpikeColor,spikeColorChange);
	reverseSpikeColor = make_color_hsv((color_get_hue(spikeColor)+128)%255,255,255);
}

var _lastPitch = pitch;
pitch = ApproachFade(pitch,1-0.2*(slowTimer > 30),0.02,0.8);
if _lastPitch != pitch audio_sound_pitch(oGlobalController.music,pitch);

if !ds_list_empty(sawList) {
	for(var i = 0; i < ds_list_size(sawList); i++) {
		if --sawList[| i].time <= 0 {
			with(instance_create_layer(sawList[| i].x,sawList[| i].y,"Spikes",oSpikeMove)) {
				direction = other.sawList[| i].dir;
				if variable_struct_exists(other.sawList[| i],"bounce") spikeIndex = 2;
			}
			ds_list_delete(sawList,i);
			i--;
		}
	}
}