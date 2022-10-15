/// @desc

flash = 0;
spikeIndex = -1;
onScreen = false;
spd = ((oGameManager.time/10)*0.25+6);
minSpd = 4;
speed = max(minSpd,spd*GLOBALSPD);