/// @desc

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
if timePulse == 0 draw_text(room_width/2,16,string(floor(oGameManager.time div 60))+":"+string_replace(string_format(oGameManager.time % 60,2,2)," ","0"));
else draw_text_transformed(room_width/2,16,string(floor(oGameManager.time div 60))+":"+string_replace(string_format(oGameManager.time % 60,2,2)," ","0"),timePulse*0.5+1,timePulse*0.5+1,0);

var _health;

for(var j = 0; j < 2; j++) {
	var _x = room_width/4*(1+j*2);
	_health = oGameManager.players[j] == noone ? MAXHEALTH : oGameManager.players[j].hp;
	if _health <= 0 and oGameManager.players[1] != noone {
		if oGameManager.gameOver and oGameManager.scores[j] > oGameManager.scores[(j+1)%2] draw_set_color(c_yellow);
		draw_text(_x,16,string(floor(oGameManager.scores[j] div 60))+":"+string_replace(string_format(oGameManager.scores[j] % 60,2,2)," ","0"));
		draw_set_color(c_white);
	}
	else {
		for(var i = 0; i < MAXHEALTH; i++) {
			var _pulse = 1;
			var _col = c_white;
			if  i == _health and heartPulse[j] != 0 {
				_pulse = 1+heartPulse[j]*0.5;
				_col = merge_color(c_white,c_red,heartPulse[j]);
				draw_sprite_ext(sHeart,1,_x+(i-(MAXHEALTH-1)/2)*14,19,_pulse,_pulse,0,_col,heartPulse[j]);
			}
			draw_sprite_ext(sHeart,(i+1 <= _health),_x+(i-(MAXHEALTH-1)/2)*14,19,_pulse,_pulse,0,_col,1);
		}
	}
	heartPulse[j] = ApproachFade(heartPulse[j],0,0.1,0.8);
}

if title and !instance_exists(oSpikeCreator) {
	draw_set_color(c_white);
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	draw_sprite(sLogo,0,room_width/2,room_height/2-22-200*(1-titlePercent));
	draw_text(room_width/2,room_height-14,"© 2022 BENJAMIN HALKO\nMADE FOR LUDUM DARE 51");
	
	if(!MOBILE) {
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_text(room_width/2-30,room_height-71,"1 PLAYER");
		draw_text(room_width/2-30,room_height-57,"2 PLAYER");
		draw_line(room_width/2-31,room_height-41-BROWSER,room_width/2+23,room_height-41-BROWSER);
		draw_line(room_width/2-31+round(54*audioVol),room_height-45+OPERA,room_width/2-31+round(54*audioVol),room_height-39+OPERA);
		draw_text(room_width/2-42,room_height-71+14*choice-(choice == 2)*(1+BROWSER),">");
		draw_sprite(sAudio,0,room_width/2+33,room_height-41-BROWSER);
		draw_set_halign(fa_center);
	} else {
		draw_set_valign(fa_middle);
		draw_text(room_width/2,room_height-58,"TAP ANYWHERE TO START");
	}
}

if(MOBILE and !instance_exists(oSpikeCreator)) {
	draw_sprite_ext(sScreenButtons,0,leftScreenX+1,screenButtonY+1,1,1,0,c_black,0.4);
	draw_sprite_ext(sScreenButtons,0,rightScreenX+1,screenButtonY+1,-1,1,0,c_black,0.4);
	draw_sprite_ext(sScreenButtons,2,jumpScreenX+1,screenButtonY+1,1,1,0,c_black,0.4);
	
	draw_sprite(sScreenButtons,leftScreen,leftScreenX,screenButtonY);
	draw_sprite_ext(sScreenButtons,rightScreen,rightScreenX,screenButtonY,-1,1,0,c_white,1);
	draw_sprite(sScreenButtons,2+jumpScreen,jumpScreenX,screenButtonY);
}