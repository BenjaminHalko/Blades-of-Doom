/// @desc

if --wait <= 0 {
	if --timeLeft <= 0 instance_destroy();
	barAmount += 20*GLOBALSPD;
} else {
	maxTime = timeLeft - 10;	
}