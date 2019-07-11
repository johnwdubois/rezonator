if (mouse_check_button_released(mb_left)) {
	windowResizeXHolding = false;
	windowResizeYHolding = false;
	obj_control.mouseoverPanelPane = false;
}
//if (mouse_check_button_pressed(mb_left)) {
	
	if (object_index == obj_gridViewer) {
		if (abs(mouse_x - (x + windowWidth)) < 5
		and mouse_y > y and mouse_y < y + windowHeight) {
			obj_control.mouseoverPanelPane = true;
			window_set_cursor(cr_size_we);
			if (mouse_check_button_pressed(mb_left)) {
				windowResizeXHolding = true;
			}
		}
	}
	
	if (abs(mouse_y - (y + windowHeight)) < 5
	and mouse_x > x and mouse_x < x + windowWidth) {
		obj_control.mouseoverPanelPane = true;
		window_set_cursor(cr_size_ns);
		if (mouse_check_button_pressed(mb_left)) {
			windowResizeYHolding = true;
		}
	}
//}

if (mouse_check_button(mb_left)) {
	if (windowResizeXHolding) {
		windowWidth = mouse_x - x;
		window_set_cursor(cr_size_we);
	}
	else if (windowResizeYHolding) {
		windowHeight = mouse_y - y;
		window_set_cursor(cr_size_ns);
	}
	
	if (windowResizeXHolding or windowResizeYHolding) {
		if (surface_exists(clipSurface)) {
			surface_resize(clipSurface, clipWidth, clipHeight);
		}
	}
}

if (windowResizeXHolding or windowResizeYHolding) {
	obj_control.mouseoverPanelPane = true;
}


windowWidth = clamp(windowWidth, 48, 2000);
windowHeight = clamp(windowHeight, 48, 1500);
clipWidth = windowWidth;
clipHeight = windowHeight;
	
windowX = x;
windowY = y;
clipX = x;
clipY = y;

if (!surface_exists(clipSurface)) {
    clipSurface = surface_create(clipWidth, clipHeight);
}

scr_windowCameraAdjust();

surface_set_target(clipSurface);
draw_clear_alpha(c_black, 0);