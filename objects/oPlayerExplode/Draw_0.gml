/// @desc Draw Explosion

draw_set_alpha(0.8);
for(var i = 0; i < array_length(p); i++) {
	draw_point_color(p[i].x,p[i].y,color);
	p[i].x += p[i].hsp;
	p[i].vsp += p[i].grv;
	p[i].y += p[i].vsp;
	if(p[i].y > room_height) {
		array_delete(p,i,1);
		i--;
	}
}
draw_set_alpha(1);

if(array_length(p) == 0) instance_destroy();
