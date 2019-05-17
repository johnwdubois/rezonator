if (!mouse_check_button(mb_left)) {
	windowResizeXHolding = false;
	windowResizeYHolding = false;
}
if (mouse_check_button_pressed(mb_left)) {
	if (abs(mouse_x - (x + windowWidth)) < 5) {
		windowResizeXHolding = true;
	}
	else if (abs(mouse_y - (y + windowHeight)) < 5) {
		windowResizeYHolding = true;
	}
}
if (mouse_check_button(mb_left)) {
	if (windowResizeXHolding) {
		windowWidth = mouse_x - x;
	}
	else if (windowResizeYHolding) {
		windowHeight = mouse_y - y;
	}
	
	windowWidth = max(windowWidth, 10);
	windowHeight = max(windowHeight, 10);
	
	if (windowResizeXHolding or windowResizeYHolding) {
		if (surface_exists(clipSurface)) {
			surface_resize(clipSurface, windowWidth, windowHeight);
		}
	}
}