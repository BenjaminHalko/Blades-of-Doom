/// @desc Game Logic

if (gameStarted and !gameOver) {
	time += 1/60;
	platformSpd = ApproachFade(platformSpd,1+floor(time/10)*0.2,0.02,0.8);
} else if (gameOver) {
	platformSpd = ApproachFade(platformSpd,0,0.01,0.8);
}