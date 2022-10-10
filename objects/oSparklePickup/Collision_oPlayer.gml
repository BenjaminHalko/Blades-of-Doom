/// @desc

oGameManager.specialItemWaitTime = 15*60;
other.sparkleTimer = 5*60;
ScreenShake(6,5);
audio_play_sound(snHeart,1,false);
instance_create_layer(x,y,"Global",oSparkleExplode);
instance_destroy();