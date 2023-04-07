var selfID = self;
with (obj_tooltip) {
	if (self != selfID) {
		instance_destroy();
	}
}

alpha = 0;
text = "";
arrowFacing = 0;

show = false;
showCount = 0;

showDelayFull = 1;
showDelay = showDelayFull;