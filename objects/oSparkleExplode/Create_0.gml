/// @desc Initialize Explosion

p = [];
targetX = x;
targetY = y-4;
target = oPlayer;

for(var i = 0; i < 16; i++) for(var j = 0; j < 16; j++) array_push(p,{
	x: x+(i-8)+irandom_range(-2,2),
	y: y+(j-12)+irandom_range(-2,2),
	spd: random(9),
	spdPercent: 1,
	spdDecay: random_range(0.12,0.2),
	dir: point_direction(7,7,i,j)+random_range(-7,7),
	percent: 0,
	len: 0,
	homing: false,
	color: choose(#FFFF99,#EBFFFF)
});
