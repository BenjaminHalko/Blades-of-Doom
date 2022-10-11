/// @desc

oGameManager.slowTimer = 5*60;
oGameManager.specialItemWaitTime = oGameManager.slowTimer + 10*60;
ScreenShake(6,5);
audio_play_sound(snHeart,1,false);
instance_create_layer(x,y,"Global",oSlowExplode);
instance_destroy();