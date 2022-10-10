/// @desc Initialize Explosion

color = c_purple;

p = [];

for(var i = 0; i < 16; i++) for(var j = 0; j < 16; j++) array_push(p,{
	dir: point_direction(7,7,i,j)+random_range(-5,5),
	spd: random(3),
	spdPercent: 1,
	spdDecay: random_range(0.015,0.1),
	len: point_distance(7,7,i,j)
});
