/// @desc Create Spikes

repeat(4) {
	var _spike = instance_create_layer(spikePos[0],spikePos[1],"Spikes",oSpike);
	if introSide == 2 _spike.spikeIndex = 1;
	if introSide == 0 _spike.spikeIndex = 2;
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