/// @desc

if GOOGLEPLAY {
	with(oGameManager) {
		heartCount++;
		if heartCount == 20 GooglePlayServices_Achievements_Unlock(heartAchievementID);
	}
}

ScreenShake(6,5);
audio_play_sound(snHeart,1,false);
other.hp = min(other.hp+1,MAXHEALTH);
instance_create_layer(x,y,"Global",oHeartExplode);
instance_destroy();