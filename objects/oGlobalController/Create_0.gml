/// @desc Initialize Game

// Constants
#macro PLATFORM_DIST 80
#macro SPIKE_DIST 12
#macro INFO_HEIGHT 26
#macro LEADERBOARDID "testingtest2"

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

// GUI
timePulse = 0;
lastTime = 0;
heartPulse = [1,1];

//Screen Shake
cam = view_get_camera(0);
shakeRemain = 0;
shakeLength = 0;
shakeMagnitude = 0;