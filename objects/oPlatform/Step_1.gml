/// @desc Move Platform

yPos += oGameManager.platformSpd*dir;

if (yPos < INFO_HEIGHT/2) yPos += dist;
if (yPos > room_height+INFO_HEIGHT/2) yPos -= dist;

y = yPos+activePercent*5;