/// @desc

if wait > 0 exit;

draw_set_alpha((0.03+0.02*max(0,1-((timeLeft-10)/maxTime)))*(min(10,timeLeft)/10));
draw_set_color(make_color_hsv(color_get_hue(oGameManager.reverseSpikeColor),max(0,1-((timeLeft-10)/maxTime))*200,255));
draw_rectangle(x+lengthdir_x(barWidth/2,barDir+90),y+lengthdir_y(barWidth/2,barDir+90),x+lengthdir_x(barWidth/2,barDir-90)+lengthdir_x(barAmount,barDir),y+lengthdir_y(barWidth/2,barDir-90)+lengthdir_y(barAmount,barDir),false);
draw_set_alpha((0.18+0.02*max(0,1-((timeLeft-10)/maxTime)))*(min(10,timeLeft)/10));
draw_set_color(make_color_hsv(color_get_hue(oGameManager.reverseSpikeColor),max(0,1-((timeLeft-10)/maxTime))*255,255));
draw_line(x+lengthdir_x(barWidth/2,barDir-90),y+lengthdir_y(barWidth/2,barDir-90),x+lengthdir_x(barWidth/2,barDir-90)+lengthdir_x(barAmount,barDir),y+lengthdir_y(barWidth/2,barDir-90)+lengthdir_y(barAmount,barDir));
draw_line(x+lengthdir_x(barWidth/2,barDir+90),y+lengthdir_y(barWidth/2,barDir+90),x+lengthdir_x(barWidth/2,barDir+90)+lengthdir_x(barAmount,barDir),y+lengthdir_y(barWidth/2,barDir+90)+lengthdir_y(barAmount,barDir));
draw_set_alpha(1);
