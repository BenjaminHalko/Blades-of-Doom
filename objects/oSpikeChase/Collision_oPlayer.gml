/// @desc Attack

if !target.visible exit;

// Inherit the parent event
event_inherited();

knockback = other.sparkleTimer == 0 ? 6 : 8;
knockbackDir = point_direction(other.x,other.y,x,y);