/// @desc Initialize Game
randomize();

// Constants
#macro PLATFORM_DIST 80
#macro SPIKE_DIST 12
#macro INFO_HEIGHT 26
#macro LEADERBOARDID "1gsGigOfdp5eCKiv8xB1"
#macro SAVEFILE "save.ini"
#macro MAXHEALTH 5

// Game Version
enum OS {
	OSBROWSER,
	OSOPERA,
	OSMOBILE,
	OSDESKTOP
}

if(os_type == os_operagx) global.ostype = OS.OSOPERA;
else if(os_browser != browser_not_a_browser) global.ostype = OS.OSBROWSER;
else if(os_type == os_android) global.ostype = OS.OSMOBILE;
else global.ostype = OS.OSDESKTOP;

#macro BROWSER (global.ostype == OS.OSBROWSER)
#macro OPERA (global.ostype == OS.OSOPERA)
#macro DESKTOP (global.ostype == OS.OSDESKTOP)
#macro MOBILE ((global.ostype == OS.OSMOBILE) or (os_type == os_android))

// Rendering
global.resW = 480;
global.resH = 270;

instance_create_layer(0,0,"Render",oRender);

//More Globals
global.usingGamepad = false;

// Desktop Size
if (DESKTOP) window_set_size(960,540);

//Create Game Manager
instance_create_layer(0,0,layer,oGameManager);
instance_create_layer(0,0,"Spikes",oSpikeCreator);
title = true;
titlePercent = 0;


// GUI
timePulse = 0;
heartPulse = [1,1];
choice = 0;
audioVol = 0.7;
audio_master_gain(audioVol);

//Screen Shake
cam = view_get_camera(0);
shakeRemain = 0;
shakeLength = 0;
shakeMagnitude = 0;

//Music
audio_play_sound(mMusic,2,true);