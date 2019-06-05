if (mouse_check_button_released(mb_left)) {
	windowResizeXHolding = false;
	windowResizeYHolding = false;
}
if (mouse_check_button_pressed(mb_left)) {
	/*
	if (abs(mouse_x - (x + windowWidth)) < 5
	and mouse_y > y and mouse_y < y + windowHeight) {
		windowResizeXHolding = true;
	}
	*/
	if (abs(mouse_y - (y + windowHeight)) < 5
	and mouse_x > x and mouse_x < x + windowWidth) {
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
	
	if (windowResizeXHolding or windowResizeYHolding) {
		if (surface_exists(clipSurface)) {
			surface_resize(clipSurface, clipWidth, clipHeight);
		}
	}
}


windowWidth = max(10, windowWidth);
windowHeight = max(40, windowHeight);
clipWidth = windowWidth;
clipHeight = windowHeight;
	
windowX = x;
windowY = y;
clipX = x;
clipY = y;

if (!surface_exists(clipSurface)) {
    clipSurface = surface_create(clipWidth, clipHeight);
}

surface_set_target(clipSurface);
draw_clear_alpha(c_black, 0);