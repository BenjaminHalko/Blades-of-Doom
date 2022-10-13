/// @desc

other.sparkleTimer = 10*60;
oGameManager.specialItemWaitTime = other.sparkleTimer + 10*60;
var _id = other.id;
ScreenShake(6,5);
audio_play_sound(snHeart,1,false);
audio_play_sound(snSparkle,2,false);
with(instance_create_layer(x,y,"Global",oSparkleExplode)) target = _id;
instance_destroy();