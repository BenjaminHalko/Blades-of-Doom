/// @desc Initialize Game

gameOver = false;
time = 0;
gameStarted = false;
players = [noone,noone];
scores = [0,0];

lastSpikeColor = c_white;
newSpikeColor = #ff340c;
spikeColor = c_fuchsia;
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