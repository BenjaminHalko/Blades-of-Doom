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
colPercent = ApproachFade(colPercent,active+0.001,0.015,0.8);
var _pulse = (0.5+sin((oGlobalController.timeCol-6)/12*pi)/2)*oGlobalController.timeColPercent;
var _col = make_color_hsv((Wave(55,70,2,colOffset)+color_get_hue(oGameManager.reverseSpikeColor))%255,colPercent*150,lerp(120+_pulse*85,255,colPercent));

if heartPercent != 0 and DELUXE _col = merge_color(_col,make_color_hsv((255+Wave(-10,3,2,colOffset)+heartCol)%255,180,255),heartPercent);
if pulse != 0 _col = merge_color(_col,make_color_hsv((color_get_hue(_col)+10)%255,255,255),pulse);

image_blend = _col;