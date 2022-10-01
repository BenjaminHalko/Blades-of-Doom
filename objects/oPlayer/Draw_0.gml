/// @desc Draw Player

if invicibility % 6 >= 3 draw_set_alpha(0.3);
	
draw_set_color(image_blend);
draw_primitive_begin(pr_trianglestrip);
draw_vertex(x-4*scale,y);
draw_vertex(x+4*scale,y);
draw_vertex(x-4*scale+forwardDir,y-8*(2-scale));
draw_vertex(x+4*scale+forwardDir,y-8*(2-scale));
draw_primitive_end();

draw_set_alpha(1);