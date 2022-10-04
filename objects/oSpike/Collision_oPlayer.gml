/// @desc
if !other.visible exit;
if spikeIndex == 2 {
	other.vsp = -12;
	if object_index == oSpikeMove other.vsp = -9;
	other.knockback = 0;
} else if spikeIndex == 0 {
	other.knockback = 0;
	other.vsp = max(other.vsp,0.1);
	other.noPlatform = 8;
	other.noSpikeHit = 5;
} else if spikeIndex == 1 {
	if !other.noSpikeHit other.knockback = -1;
	other.vsp = -7;
} else if spikeIndex == 3 {
	other.knockback = 1;
	if !other.noSpikeHit other.vsp = -7;
} else {
	other.knockback = sign(other.x-x);
	if !other.noSpikeHit other.vsp = -7;
	else other.noPlatform = 3;
}
if other.invicibility == 0 and other.hp > 0 {
	other.invicibility = 60*2;
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
	ScreenShake(6,10);
	audio_play_sound(snHurt,1,false);
} else {
	ScreenShake(3,5);
	if (!audio_is_playing(snHurt)) audio_play_sound(snHurt,1,false);
}
flash = 1;