/// @desc
httpID = undefined;
callback = undefined;

maxScores = 5;
scores = [];
LeaderboardGet(maxScores,false,LEADERBOARDID);

waiting = 0;
displayPercent = 0;
replacingScore = -1;
newRecord = false;

flash = 0;

scores = [];
ini_open("SAVEFILE.ini");
personalBest = ini_read_real("score","score",0);
ini_close();