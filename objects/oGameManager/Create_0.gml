/// @desc Initialize Game

gameOver = false;
time = 0;
gameStarted = false;
players = [noone,noone];
scores = [0,0];

lastSpikeColor = c_white;
newSpikeColor = #4100FF;
spikeColor = newSpikeColor;
reverseSpikeColor = c_white;
spikeColorChange = 1;

lastTime = 9;
platformSpd = 0;

attackFunctions = [
BladeAttackVertical,
BladeAttackVerticalFast,
BladeAttackHorizontal,
BladeAttackAll,
BladeAttackRandom2];

attackNum = 0;
specialItemWaitTime = 0;

slowTimer = 0;
pitch = 1;