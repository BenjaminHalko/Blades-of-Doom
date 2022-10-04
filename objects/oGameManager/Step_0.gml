/// @desc Game Logic

if (gameStarted and !gameOver) {
	time += 1/60;
	platformSpd = ApproachFade(platformSpd,(1+floor(time/10)*0.2)*(1-(time%20 >= 10)*2),0.7,0.8);
	if oGameManager.time % 10 < lastTime {
		oGlobalController.timePulse = 1;
		lastSpikeColor = spikeColor;
		newSpikeColor = make_color_hsv(random(255),255,255);
		spikeColorChange = 0;
		if time == 1/60 attackFunctions[0]();
		else attackFunctions[irandom(array_length(attackFunctions)-1)]();
	}
	lastTime = oGameManager.time % 10;
} else if !gameOver platformSpd = ApproachFade(platformSpd,0,0.7,0.8);

if spikeColorChange == 1 and spikeColor != newSpikeColor {
	spikeColor = newSpikeColor;
	reverseSpikeColor = make_color_hsv((color_get_hue(spikeColor)+128)%255,255,255);
} else {
	spikeColorChange = ApproachFade(spikeColorChange,1,0.1,0.8);
	spikeColor = merge_color(lastSpikeColor,newSpikeColor,spikeColorChange);
	reverseSpikeColor = make_color_hsv((color_get_hue(spikeColor)+128)%255,255,255);
}