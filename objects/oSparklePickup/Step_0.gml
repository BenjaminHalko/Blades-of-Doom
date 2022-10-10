/// @desc

create = !create;
if !create exit;

var _dir = random(360);
var _len = random(8);

with(instance_create_depth(x+lengthdir_x(_len,_dir),y+lengthdir_y(_len,_dir)-6,depth-1,oSparkle)) {
	creator = other.id;
	xoffset = x-other.x;
	yoffset = y-other.y;
}