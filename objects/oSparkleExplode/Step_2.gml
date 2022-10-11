/// @desc Move To Explosion Target

if instance_exists(target) and target.visible {
	targetX = target.x-1;
	targetY = target.y-4;
}