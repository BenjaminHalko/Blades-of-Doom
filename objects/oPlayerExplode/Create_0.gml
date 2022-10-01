/// @desc Initialize Explosion

color = c_white;

p = [];

for(var i = 0; i < 16; i++) for(var j = 0; j < 16; j++) array_push(p,{
	x: x+(i-8),
	y: y+(j-16),
	vsp: random_range(0.5,-3),
	hsp: random((i-8)/8),
	grv: random_range(0.1,0.2)
});
