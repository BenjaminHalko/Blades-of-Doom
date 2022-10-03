/// @desc Attack

if !target.visible exit;

// Inherit the parent event
event_inherited();

knockback = 6;
knockbackDir = point_direction(other.x,other.y,x,y);