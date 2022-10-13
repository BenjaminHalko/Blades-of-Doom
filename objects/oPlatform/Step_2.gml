/// @desc Color Changing

var _lastActive = active;
active = false;
with(oPlayer) {
	if y <= other.bbox_top and vsp >= 0 and place_meeting(x,y+1,other.id) {
		other.active = true;
		break;
	}
}

pulse = Approach(pulse,0,0.08);
if active and !_lastActive {
	pulse = 1;
	colPercent = 1;
}

var _normalCol = color_get_hue(oGameManager.reverseSpikeColor);

activePercent = ApproachFade(activePercent,active,0.2,0.7);
colPercent = ApproachFade(colPercent,active+0.001,0.015,0.8);
var _col = make_color_hsv((Wave(55,70,2,colOffset)+_normalCol)%255,colPercent*150,lerp(120,255,colPercent));

if heartPercent != 0 _col = merge_color(_col,heartCol,heartPercent);
if pulse != 0 _col = merge_color(_col,make_color_hsv(color_get_hue(_col),255,255),pulse);

image_blend = _col;