/// @desc Move Platform

yPos += oGameManager.platformSpd*dir;

if (yPos < INFO_HEIGHT/2) or (yPos > room_height+INFO_HEIGHT/2) {
	var _notAtFullHealth = false;
	with(oPlayer) {
		if (hp != MAXHEALTH) _notAtFullHealth = true;	
	}
	if _notAtFullHealth and irandom(5) == 0 and !instance_exists(oHeartPickup) and !oGameManager.gameOver {
		heart = instance_create_layer(x,0,layer,oHeartPickup);
	} else instance_destroy(heart);
}
if (yPos < INFO_HEIGHT/2) yPos += dist;
if (yPos > room_height+INFO_HEIGHT/2) yPos -= dist;

y = yPos+activePercent*5;

if instance_exists(heart) {
	heart.y = y - Wave(6,10,1,0);
}