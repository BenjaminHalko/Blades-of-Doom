/// @desc Move Platform

yPos += oGameManager.platformSpd*dir;

if (yPos < INFO_HEIGHT/2) or (yPos > room_height+INFO_HEIGHT/2) {
	var _notAtFullHealth = false;
	var _notInvincible = true;
	with(oPlayer) {
		if (hp != MAXHEALTH) _notAtFullHealth = true;	
	}
	
	with(oPlayer) {
		if sparkleTimer > 0 _notInvincible = false;	
	}
	
	heartPercent = 0;
	instance_destroy(heart);
	if _notAtFullHealth and irandom(5) == 0 and !instance_exists(oHeartPickup) and !oGameManager.gameOver {
		heart = instance_create_layer(x,0,layer,oHeartPickup);
		heartCol = 0;
	} else if DELUXE and _notInvincible and irandom(5) == 0 and oGameManager.specialItemWaitTime == 0 and !instance_exists(oSparklePickup) and !instance_exists(oSlowPickup) and !oGameManager.gameOver{
		heart = instance_create_layer(x,0,layer,choose(oSparklePickup,oSlowPickup));
		if heart.object_index == oSparklePickup heartCol = 35;
		else heartCol = 165;
	}
}
if (yPos < INFO_HEIGHT/2) yPos += dist;
if (yPos > room_height+INFO_HEIGHT/2) yPos -= dist;

y = yPos+activePercent*5;

if instance_exists(heart) {
	heart.y = y - ((heart.object_index != oSlowPickup) ? Wave(6,10,1,0) : Wave(7,9,2,0));
	heartPercent = 1;
} else heartPercent = ApproachFade(heartPercent,0,0.05,0.8);