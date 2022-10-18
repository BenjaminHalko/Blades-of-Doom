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

attackFunctionsOriginal = [
BladeAttackVertical,
BladeAttackVerticalFast,
BladeAttackHorizontal,
BladeAttackAllOld,
BladeAttackRandom2Old];

attackFunctions = [
BladeAttackVertical,
BladeAttackVerticalFast,
BladeAttackVerticalRandom,

BladeAttackHorizontal,
BladeAttackSideWalls,
BladeAttackVerticalSuperFastHalf,

BladeAttackVerticalSuperFast,
BladeAttackCorners,
BladeAttackRandom2,

BladeAttackSides,
BladeAttackAll,
BladeAttackVerticalDoubleSides
];
easyWaves = 2;
normalWaves = 5;
hardWaves = 8;

attackNum = 0;
specialItemWaitTime = 0;
firstRound = true;

slowTimer = 0;
pitch = 1;

sawList = ds_list_create();