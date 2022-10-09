/// @desc
var _x = x+lerp(-2,2,sin(waveSpdX)/pi*2)*chargePercent;
var _y = y+lerp(-2,2,sin(waveSpdY)/pi*2)*chargePercent;
_x -= lengthdir_x(2*chargePercent,90-spikeIndex*90);
_y -= lengthdir_y(2*chargePercent,90-spikeIndex*90);
draw_sprite_ext(sprite_index,0,_x,_y,image_xscale,image_yscale,image_angle,image_blend,1-chargePercent);
if chargePercent != 0 draw_sprite_ext(sprite_index,0,_x,_y,image_xscale,image_yscale,image_angle,oGameManager.reverseSpikeColor,chargePercent);