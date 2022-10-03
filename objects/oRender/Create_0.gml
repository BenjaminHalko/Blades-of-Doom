/// @desc Initialize Bloom

//Create Surfaces
surfacePing = -1;
surfacePong = -1;

uTexelSize = shader_get_uniform(shBlur,"texel_size");
uBlurVector = shader_get_uniform(shBlur,"blur_vector");

disable = false;
application_surface_draw_enable(false);