/// @desc Initialize Game
randomize();

// Constants
#macro DELUXE 0
#macro Deluxe:DELUXE 1

#macro PLATFORM_DIST 80
#macro SPIKE_DIST 12
#macro INFO_HEIGHT 26
#macro LEADERBOARDID "1gsGigOfdp5eCKiv8xB1"
#macro Deluxe:LEADERBOARDID "QTRoPI4wjb8kmlgoYEqU"
#macro CHALLENGEID "c159bba5-6093-46e2-a63c-e989b825dbd5"
#macro SAVEFILE "save.ini"
#macro GOOGLEPLAYLEADERBOARDID "CgkIydiz_a0TEAIQAA"
#macro MAXHEALTH 5
#macro PLATFORM_SPACING 1.05
#macro GLOBALSPD (1-(oGameManager.slowTimer > 0)*0.5)
#macro GLOBALSPIN (1-(oGameManager.slowTimer > 0)*0.75)


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
global.googlePlayIsAvailable = GooglePlayServices_IsAvailable();

#macro BROWSER (global.ostype == OS.OSBROWSER)
#macro OPERA (global.ostype == OS.OSOPERA)
#macro DESKTOP (global.ostype == OS.OSDESKTOP)
#macro MOBILE ((global.ostype == OS.OSMOBILE) or (os_type == os_android) or (global.mobileOperaGX))
#macro GOOGLEPLAY (os_type == os_android and global.googlePlayIsAvailable)
#macro OUTSIDELEADERBOARD (OPERA or GOOGLEPLAY)

if OPERA {
	var _info = os_get_info();
	global.mobileOperaGX = _info[? "mobile"];
	ds_map_destroy(_info);
}

global.online = (OUTSIDELEADERBOARD or network_resolve("lb.userdefined.io") != "");

// Rendering
global.resW = 480;
global.resH = 270;

instance_create_layer(0,0,"Render",oRender);

//More Globals
global.usingGamepad = false;

// Desktop Size
if (DESKTOP) {
	window_set_size(960,540);
	window_center();
}

//Create Game Manager
instance_create_layer(0,0,layer,oGameManager);
instance_create_layer(0,0,"Spikes",oSpikeManager);
title = true;
titlePercent = 0;

// GUI
timeCol = 0;
timeColPercent = 0;
timePulse = 0;
heartPulse = [1,1];
choice = 0;
if !MOBILE {
	ini_open(SAVEFILE)
	audioVol = ini_read_real("audio","audio",0.7);
	ini_close();
} else audioVol = 0.7;
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

usingOnScreenButtons = 1;
onScreenAlpha = 1;

// Auto Detect Bloom Too Much
autoDetectCounter = 0;

//Music
music = audio_play_sound(mMusic,2,true);

//Shot Type
enum SHOT {
	NORMAL,
	WAVE,
	TRIANGLE
}