var selfID = self;
with (obj_tooltip) {
	if (self != selfID) {
		instance_destroy();
	}
}

alpha = 0;
text = "";
arrowFacing = 0;
global.arrowFaceUp = 0;
global.arrowFaceRight = 1;
global.arrowFaceDown = 2;
global.arrowFaceLeft = 3;

show = false;
showCount = 0;

showDelayFull = 1;
showDelay = showDelayFull;