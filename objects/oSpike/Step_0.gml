/// @desc

image_angle -= (6+chargePercent*4)*image_xscale;
flash = ApproachFade(flash,0,0.1,0.8);
if (charging != -1) chargePercent = (maxCharge-charging)/maxCharge;
else chargePercent = ApproachFade(chargePercent,0,0.02,0.8);
image_blend = merge_color(oGameManager.spikeColor,c_white,flash);

if (charging > 0) charging--;
else if charging == 0 {
	charging = -1;
	
	for(var i = 0; i < spikeLength; i++) {
		var _dist = random_range(25,35);
		var _x = lengthdir_x(30*i+_dist,(1-spikeIndex)*90);
		var _y = lengthdir_y(30*i+_dist,(1-spikeIndex)*90);
		
		with(instance_create_layer(x+_x,y+_y,layer,oSpikeMove)) {
			direction = (3-other.spikeIndex)*90;
			if (other.spikeNum == 7 or other.spikeNum == 13) and other.spikeLength >= 10 {
				spikeIndex = 2;
			}
		}
	}
}

waveSpdX += chargePercent*waveXOffset*0.7;
waveSpdY += chargePercent*waveYOffset*0.7;

image_xscale = 1+chargePercent*0.5;
image_yscale = image_xscale;