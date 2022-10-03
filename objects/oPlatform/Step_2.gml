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

activePercent = ApproachFade(activePercent,active,0.2,0.7);
colPercent = ApproachFade(colPercent,active,0.015,0.8);
var _col = make_color_hsv((Wave(185,200,2,colOffset)+color_get_hue(oGameManager.spikeColor))%255,colPercent*150,(lerp(120,255,colPercent)));

if pulse != 0 {
	_col = merge_color(_col,make_color_hsv((Wave(175,190,2,colOffset)+color_get_hue(oGameManager.spikeColor))%255,255,255),pulse);	
}

image_blend = _col;