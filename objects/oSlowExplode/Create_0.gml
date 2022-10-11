/// @desc Initialize Explosion

color = #8000FF;

p = [];

for(var i = 0; i < 16; i++) for(var j = 0; j < 16; j++) array_push(p,{
	dir: point_direction(7,7,i,j)+random_range(-5,5),
	spd: random(5),
	spdPercent: 1,
	spdDecay: random_range(0.02,0.07),
	len: point_distance(7,7,i,j),
	alpha: 1
});
