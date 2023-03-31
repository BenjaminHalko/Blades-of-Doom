/// @desc Attack

if !target.visible exit;

// Inherit the parent event
SpikeDamage(other.id);

knockback = other.sparkleTimer == 0 ? 6 : 8;
knockbackDir = point_direction(other.x,other.y,x,y);

attacked = other.sparkleTimer != 0;