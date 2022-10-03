/// @desc
var _x = x+lerp(-2,2,sin(waveSpdX)/pi*2)*chargePercent;
var _y = y+lerp(-2,2,sin(waveSpdY)/pi*2)*chargePercent;
draw_sprite_ext(sprite_index,0,_x,_y,image_xscale,image_yscale,image_angle,image_blend,1-chargePercent);
if chargePercent != 0 draw_sprite_ext(sprite_index,0,_x,_y,image_xscale,image_yscale,image_angle,oGameManager.reverseSpikeColor,chargePercent);