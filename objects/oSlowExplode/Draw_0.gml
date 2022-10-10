/// @desc Draw Explosion


for(var i = 0; i < array_length(p); i++) {
	draw_set_alpha(max(0,min(0.1,p[i].spdPercent+0.05)*10));
	draw_point_color(x+lengthdir_x(p[i].len,p[i].dir),y+lengthdir_y(p[i].len,p[i].dir),color);
	p[i].len += p[i].spd * max(0,p[i].spdPercent);
	p[i].dir += p[i].spd * max(0,p[i].spdPercent);
	p[i].spdPercent = ApproachFade(p[i].spdPercent,-0.05,p[i].spdDecay,0.8);
	if(p[i].spdPercent <= -0.04) {
		array_delete(p,i,1);
		i--;
	}
}
draw_set_alpha(1);

if(array_length(p) == 0) instance_destroy();
