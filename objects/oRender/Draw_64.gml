/// @desc Render Bloom

if disable exit;

//Create Non-Existant Surfaces
if !surface_exists(surfacePing) surfacePing = surface_create(global.resW,global.resH);
if !surface_exists(surfacePong) surfacePong = surface_create(global.resW,global.resH);

//Bloom
surface_set_target(surfacePing);
draw_surface(application_surface,0,0);
surface_reset_target();

surface_set_target(surfacePong);
shader_set(shBlur);
shader_set_uniform_f(uTexelSize,1/global.resW,1/global.resH);
shader_set_uniform_f(uBlurVector,0,1);
draw_surface(surfacePing,0,0);
surface_reset_target();

var _size = BROWSER ? window_get_width()/480 : 1;
shader_set_uniform_f(uBlurVector,1,0);
draw_surface_ext(surfacePong,0,0,_size,_size,0,make_color_hsv(0,0,255*0.7),1);
shader_reset();

gpu_set_blendmode(bm_add);
draw_surface_ext(application_surface,0,0,_size,_size,0,make_color_hsv(0,0,255*0.8),1);
gpu_set_blendmode(bm_normal);