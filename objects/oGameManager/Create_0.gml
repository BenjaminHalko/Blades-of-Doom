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

//Google Play
achievementIDs = [
"CgkIlMeFs6UJEAIQAQ",
"CgkIlMeFs6UJEAIQAg",
"CgkIlMeFs6UJEAIQAw",
"CgkIlMeFs6UJEAIQBA",
"CgkIlMeFs6UJEAIQBQ"];

notHit = true;
noHitAchievementID = "CgkIlMeFs6UJEAIQCg";

heartCount = 0;
heartAchievementID = "CgkIlMeFs6UJEAIQBw";

powerUpCount = 0;
powerUpAchievementID = "CgkIlMeFs6UJEAIQCA";

jumpCount = 0;
jumpAchievementID = "CgkIlMeFs6UJEAIQBg";

bladeAttackAchievementID = "CgkIlMeFs6UJEAIQCQ";