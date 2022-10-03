/// @desc Init Platform

dir = 1;
dist = ceil((room_height-INFO_HEIGHT) / PLATFORM_DIST)*PLATFORM_DIST;

activePercent = 0;
active = false;
colPercent = 0;

colOffset = random(1);
pulse = 0;

yPos = y;

heart = noone;