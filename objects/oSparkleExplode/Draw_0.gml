/// @desc Draw Explosion

for(var i = 0; i < array_length(p); i++) {
	draw_set_alpha(max(!p[i].homing,min(0.1,1-p[i].spd)*10));
	draw_point_color(p[i].x,p[i].y,p[i].color);
	if p[i].homing {
		p[i].x = lerp(x,targetX,p[i].spdPercent) + lengthdir_x(lerp(p[i].len,6,p[i].spd),p[i].dir);
		p[i].y = lerp(y,targetY,p[i].spdPercent) + lengthdir_y(lerp(p[i].len,6,p[i].spd),p[i].dir);
		p[i].spdPercent = ApproachFade(p[i].spdPercent,1,0.1,0.8);
		p[i].spd = ApproachFade(p[i].spd,1,0.08,0.8);
		p[i].dir -= 5*p[i].spd;
		if(p[i].spd == 1) {
			array_delete(p,i,1);
			i--;
			continue;
		}
	} else {
		p[i].x += lengthdir_x(p[i].spd*p[i].spdPercent,p[i].dir);
		p[i].y += lengthdir_y(p[i].spd*p[i].spdPercent,p[i].dir);
		p[i].spdPercent = ApproachFade(p[i].spdPercent,0,p[i].spdDecay,0.8);
		if p[i].spdPercent <= 0.05 {
			p[i].spdPercent = 0;
			p[i].spd = 0;
			p[i].homing = true;
			p[i].dir = point_direction(x,y,p[i].x,p[i].y);
			p[i].len = point_distance(x,y,p[i].x,p[i].y);
		}
	}
	
}
draw_set_alpha(1);

if(array_length(p) == 0) instance_destroy();
