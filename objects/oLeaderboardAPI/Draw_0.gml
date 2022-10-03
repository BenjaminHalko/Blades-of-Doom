/// @desc

if displayPercent == 0 exit;

var _extraSize = 0;
if(OPERA) _extraSize = 20;

var _y = 50;
var _x = lerp(-220-_extraSize,20,displayPercent);

draw_set_color(c_black);
draw_set_alpha(0.8);
draw_roundrect(_x,_y,_x+162+_extraSize,_y+190,false);
draw_set_alpha(1);

draw_set_font(GuiFont);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

draw_roundrect(_x,_y,_x+162+_extraSize,_y+190,true);

draw_text(_x+10,_y+20,"LEADERBOARD:");

for(var i = 0; i < array_length(scores); i++) {
	draw_set_color(c_white);
	if i == replacingScore {
		var _name = scores[i].name;
		if _name == "" {
			draw_set_color(c_dkgray);
			draw_text(_x+10,_y+40+16*i,"Enter Name");
		}
		draw_set_color(merge_color(c_yellow,c_red,flash));
		if current_time % 1000 > 500 and string_length(scores[i].name) != 10 _name += "_";
		draw_text(_x+10,_y+40+16*i,_name);
		draw_text(_x+100,_y+40+16*i,string(floor(oGameManager.time div 60))+":"+string_replace(string_format(oGameManager.time % 60,2,2)," ","0"));
	} else if (OPERA) {
		var _scale = min(1,string_width("AAAAAAAAAAAAA")/string_width(scores[i].name));
		draw_text_transformed(_x+10,_y+40+16*i,scores[i].name,_scale,1,0);
	} else {
		draw_text(_x+10,_y+40+16*i,scores[i].name);
	}
	var _score = variable_struct_get(scores[i],"score");
	draw_text(_x+100+_extraSize,_y+40+16*i,string(floor(_score div 60))+":"+string_replace(string_format(_score % 60,2,2)," ","0"));
}

draw_set_color(c_white);
draw_text(_x+10,_y+130,"PERSONAL BEST:");
draw_text(_x+100+_extraSize,_y+144,string(floor(personalBest div 60))+":"+string_replace(string_format(personalBest % 60,2,2)," ","0"));

if newRecord {
	draw_set_color(c_lime);
	draw_text(_x+10,_y+144,"NEW PB!");
}

draw_set_color(c_gray);
draw_text(_x+40+_extraSize/2,_y+174,"PRESS ENTER");
