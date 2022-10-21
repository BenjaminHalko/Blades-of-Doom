/// @desc

if displayPercent == 0 exit;

var _extraSize = 0;
if(OPERA and global.online) _extraSize = 20;

var _y = 50+40*(!global.online);
var _x = lerp(-220-_extraSize,20,displayPercent);

draw_set_color(c_black);
draw_set_alpha(0.8);
draw_roundrect(_x,_y,_x+162+_extraSize,_y+190-80*(!global.online),false);
draw_set_alpha(1);

draw_set_font(GuiFont);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

draw_roundrect(_x,_y,_x+162+_extraSize,_y+190-80*(!global.online),true);
if global.online {
	draw_text(_x+10,_y+20,"LEADERBOARD:");

	for(var i = 0; i < array_length(scores); i++) {
		draw_set_color(c_white);
		if i == replacingScore {
			if !MOBILE {
				var _name = scores[i].name;
				if _name == "" {
					draw_set_color(c_dkgray);
					draw_text(_x+10,_y+40+16*i,"Enter Name");
				}
				draw_set_color(merge_color(c_yellow,c_red,flash));
				if current_time % 1000 > 500 and string_length(scores[i].name) != 10 _name += "_";
				draw_text(_x+10,_y+40+16*i,_name);
			} else {
				draw_set_color(c_dkgray);
				draw_text(_x+10,_y+40+16*i,"Enter Name");
				draw_set_color(merge_color(c_yellow,c_red,flash));
			}
			
			draw_text(_x+100,_y+40+16*i,string(floor(oGameManager.time div 60))+":"+string_replace(string_format(oGameManager.time % 60,2,2)," ","0"));
		} else {
			if (OPERA) {
				var _scale = min(1,string_width("AAAAAAAAAAAAA")/string_width(scores[i].name));
				draw_text_transformed(_x+10,_y+40+16*i,scores[i].name,_scale,1,0);
			} else {
				draw_text(_x+10,_y+40+16*i,scores[i].name);
			}
			var _score = variable_struct_get(scores[i],"score");
			draw_text(_x+100+_extraSize,_y+40+16*i,string(floor(_score div 60))+":"+string_replace(string_format(_score % 60,2,2)," ","0"));
		}
	}
} else {
	
	draw_set_color(c_red);
	draw_text(_x+10,_y+20,"CURRENTLY OFFLINE");
	_y -= 80;
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

if replacingScore != -1 and MOBILE {
	var _extraHeight = 46;
	draw_set_alpha(0.8);
	draw_set_color(c_black);
	draw_rectangle(0,0,room_width,room_height,false);
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_roundrect(room_width/2-54,room_height/2-14-_extraHeight,room_width/2+54,room_height/2+14-_extraHeight,true);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
				
	var _name = scores[replacingScore].name;
	if _name == "" {
		draw_set_color(c_dkgray);
		draw_text(room_width/2,room_height/2-_extraHeight,"Enter Name");
	} else {
		draw_set_color(merge_color(c_yellow,c_red,flash));
		draw_text(room_width/2,room_height/2-_extraHeight,_name);
	}	
}
