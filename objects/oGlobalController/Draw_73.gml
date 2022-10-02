/// @desc

enableLive;

draw_set_color(c_black);
draw_rectangle(-10,-10,room_width+10,INFO_HEIGHT,false);

draw_set_font(GuiFont);
draw_set_halign(fa_center);
draw_set_valign(fa_top);

draw_set_color(c_lime);
draw_text(room_width/4,5,"PLAYER 1");
draw_set_color(#FF8800);
draw_text(room_width/4*3,5,"PLAYER 2");
draw_set_color(c_white);
draw_text(room_width/2,5,"TIME");
draw_set_valign(fa_middle);
if timePulse == 0 draw_text(room_width/2,19,string(floor(oGameManager.time div 60))+":"+string_replace(string_format(oGameManager.time % 60,2,2)," ","0"));
else draw_text_transformed(room_width/2,19,string(floor(oGameManager.time div 60))+":"+string_replace(string_format(oGameManager.time % 60,2,2)," ","0"),timePulse*0.5+1,timePulse*0.5+1,0);

var _health;

for(var j = 0; j < 2; j++) {
	var _x = room_width/4*(1+j*2);
	_health = oGameManager.players[j] == noone ? 3 : oGameManager.players[j].hp;
	if _health <= 0 and oGameManager.players[1] != noone draw_text(_x,19,string(floor(oGameManager.scores[j] div 60))+":"+string_replace(string_format(oGameManager.scores[j] % 60,2,2)," ","0"));
	else {
		for(var i = 0; i < 3; i++) {
			var _pulse = 1;
			var _col = c_white;
			if  i == _health and heartPulse[j] != 0 {
				_pulse = 1+heartPulse[j]*0.5;
				_col = merge_color(c_white,c_red,heartPulse[j]);
				draw_sprite_ext(sHeart,1,_x+(i-1)*14,19,_pulse,_pulse,0,_col,heartPulse[j]);
			}
			draw_sprite_ext(sHeart,(i+1 <= _health),_x+(i-1)*14,19,_pulse,_pulse,0,_col,1);
		}
	}
	heartPulse[j] = ApproachFade(heartPulse[j],0,0.1,0.8);
}