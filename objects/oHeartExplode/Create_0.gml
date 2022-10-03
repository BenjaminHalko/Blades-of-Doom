/// @desc Initialize Explosion

color = c_red;

p = [];

for(var i = 0; i < 12; i++) for(var j = 0; j < 12; j++) array_push(p,{
	x: x+(i-6),
	y: y+(j-12),
	vsp: random_range(0.5,-3),
	hsp: random((i-6)/6),
	grv: random_range(0.1,0.2)
});
