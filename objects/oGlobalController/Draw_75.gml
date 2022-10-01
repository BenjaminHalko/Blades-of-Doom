/// @desc
draw_set_color(c_black);
draw_rectangle(0,0,room_width,INFO_HEIGHT,false);	

draw_set_font(GuiFont);
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_top);

draw_text(room_width/4,6,"PLAYER 1");
draw_text(room_width/4*3,6,"PLAYER 2");
draw_text(room_width/2,6,"TIME\nTESTING");