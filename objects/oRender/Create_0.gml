/// @desc Initialize Bloom

//Create Surfaces
surfacePing = -1;
surfacePong = -1;

uBlurVector = shader_get_uniform(shBlur,"blur_vector");

ini_open(SAVEFILE);
disable = ini_read_real("graphics","bloomDisabled",MOBILE);
ini_close();
application_surface_draw_enable(disable);