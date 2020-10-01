var selfID = self;
with (obj_tooltip) {
	if (self != selfID) {
		instance_destroy();
	}
}

alpha = 0;
text = "";
arrowFacing = 0;
arrowFaceUp = 0;
arrowFaceRight = 1;
arrowFaceDown = 2;
arrowFaceLeft = 3;

show = false;

showDelayFull = 40;
showDelay = showDelayFull;