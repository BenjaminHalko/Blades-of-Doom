/// @desc Create Spikes

if --wait > 0 exit;
repeat(4) {
	var _spike = instance_create_layer(spikePos[0],spikePos[1],"Spikes",oSpike);
	_spike.spikeIndex = introSide;
	
	if introSide == 1 _spike.spikeNum = 5+floor((spikePos[1]-INFO_HEIGHT) / ((room_height-INFO_HEIGHT)/3));
	else if introSide == 3 _spike.spikeNum = 13+floor((room_height-spikePos[1]) / ((room_height-INFO_HEIGHT)/3));
	if DELUXE {
		if introSide == 0 _spike.spikeNum = median(0,4,2+round((spikePos[0]-room_width/2)*1.1 / (room_width/5)));
		else if introSide == 2 _spike.spikeNum = 12-median(0,4,2+round((spikePos[0]-room_width/2)*1.1 / (room_width/5)));
	} else {
		if introSide == 0 _spike.spikeNum = floor(spikePos[0] / (room_width/5));
		else if introSide == 2 _spike.spikeNum = 8+floor((room_width-spikePos[0]) / (room_width/5));
	}
	
	spikePos[introSide%2] += SPIKE_DIST * (1 - (introSide > 1)*2);
	spikePos[introSide%2] = median(changeArray[introSide%2],changeArray[introSide%2+2],spikePos[introSide%2]);
	if spikePos[introSide%2] == changeArray[introSide] {
		introSide++;
		if introSide == 4 {
			instance_destroy();
			break;
		}
	}
}