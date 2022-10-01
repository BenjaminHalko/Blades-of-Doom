/// @desc Color Changing

var _active = false;
with(oPlayer) {
	if y <= other.bbox_top and vsp >= 0 and place_meeting(x,y+1,other.id) {
		_active = true;
		break;
	}
}

activePercent = ApproachFade(activePercent,_active,0.2,0.7);
image_blend = make_color_hsv(Wave(170,185,5,colOffset),activePercent*150,lerp(120,255,activePercent));