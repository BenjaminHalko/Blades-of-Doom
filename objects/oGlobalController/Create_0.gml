/// @desc Initialize Game
randomize();

// Constants
#macro DELUXE 0
#macro Deluxe:DELUXE 1

#macro PLATFORM_DIST 80
#macro SPIKE_DIST 12
#macro INFO_HEIGHT 26
#macro LEADERBOARDID "1gsGigOfdp5eCKiv8xB1"
#macro Deluxe:LEADERBOARDID "1gsGigOfdp5eCKiv8xB12"
#macro CHALLENGEID "c159bba5-6093-46e2-a63c-e989b825dbd5"
#macro SAVEFILE "save.ini"
#macro MAXHEALTH 5
#macro PLATFORM_SPACING 1.05
#macro GLOBALSPD (1-(oGameManager.slowTimer > 0)*0.5)
#macro GLOBALSPIN (1-(oGameManager.slowTimer > 0)*0.75)
#macro GLOBALSAWSPD (1-(oGameManager.slowTimer > 0)*0.35)


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

global.mobileOperaGX = false;

#macro BROWSER (global.ostype == OS.OSBROWSER)
#macro OPERA (global.ostype == OS.OSOPERA)
#macro DESKTOP (global.ostype == OS.OSDESKTOP)
#macro MOBILE ((global.ostype == OS.OSMOBILE) or (os_type == os_android) or (global.mobileOperaGX))

if OPERA {
	var _info = os_get_info();
	global.mobileOperaGX = _info[? "mobile"];
	ds_map_destroy(_info);
}

global.online = false//os_is_network_connected();

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
ini_open(SAVEFILE)
audioVol = ini_read_real("audio","audio",0.7);
ini_close();
audio_master_gain(audioVol);

//Screen Shake
cam = view_get_camera(0);
shakeRemain = 0;
shakeLength = 0;
shakeMagnitude = 0;

//GUI Controls
leftScreen = false;
rightScreen = false;
jumpScreen = false;
jumpIsPressed = false;
	
screenButtonY = room_height-40;
leftScreenX = 40;
rightScreenX = leftScreenX+48;
jumpScreenX = room_width-leftScreenX;

//Music
music = audio_play_sound(mMusic,2,true);

//Shot Type
enum SHOT {
	NORMAL,
	WAVE,
	REVERSEWAVE,
	DUALWAVE,
	TRIANGLE
}