/// @desc
if spikeIndex == 1 {
	other.vsp = -12;
	if other.hp > 0 other.knockback = 0;
} else if spikeIndex == 0 {
	other.knockback = sign(other.x-x);
	other.vsp = -4;
} else {
	if other.hp > 0 other.knockback = 0;
	other.vsp = 0;
	other.platform = noone;
}
if other.invicibility == 0 and other.hp > 0 {
	other.invicibility = 60;
	other.hp--;
	if other.hp <= 0 {
		other.invicibility = 0;
		other.deathTimer = 30;
		other.knockback = sign(other.x-x);
		if other.knockback == 0 other.knockback = 1;
		oGameManager.scores[max(0,other.player-1)] = oGameManager.time;
		if oGameManager.players[0].hp == 0 and (oGameManager.players[1] == noone or oGameManager.players[1].hp == 0) GameOver();
	}
	oGlobalController.heartPulse[max(0,other.player-1)] = 1;
	ScreenShake(3,10);
} else ScreenShake(1,5);
flash = 1;