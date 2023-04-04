/// @desc Initialize Bloom

//Create Surfaces
surfacePing = -1;
surfacePong = -1;

uBlurVector = shader_get_uniform(shBlur,"blur_vector");

ini_open(SAVEFILE);
autoDetect = !ini_key_exists("graphics","bloomDisabled");
disable = ini_read_real("graphics","bloomDisabled",false);
ini_close();
application_surface_draw_enable(disable);