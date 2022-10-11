/// @desc Draw Explosion


for(var i = 0; i < array_length(p); i++) {
	draw_set_alpha(p[i].alpha);
	draw_point_color(x+lengthdir_x(p[i].len,p[i].dir),y+lengthdir_y(p[i].len,p[i].dir)-4,color);
	p[i].len += p[i].spd * max(0,p[i].spdPercent);
	p[i].dir += p[i].spd * max(0,p[i].spdPercent);
	p[i].spdPercent = ApproachFade(p[i].spdPercent,0,p[i].spdDecay,0.9);
	if(p[i].spdPercent <= 0.01) {
		p[i].alpha = ApproachFade(p[i].alpha,0,0.1,0.8);
		if p[i].alpha == 0 {
			array_delete(p,i,1);
			i--;
		}
	}
}
draw_set_alpha(1);

if(array_length(p) == 0) instance_destroy();
