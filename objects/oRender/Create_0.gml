/// @desc Initialize Bloom

//Create Surfaces
surfacePing = -1;
surfacePong = -1;

uBlurVector = shader_get_uniform(shBlur,"blur_vector");

disable = MOBILE;
application_surface_draw_enable(disable);