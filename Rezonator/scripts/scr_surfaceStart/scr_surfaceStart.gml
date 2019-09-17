if (object_index == obj_panelPane) {
	if (currentFunction == functionChainContents) {
		var sortPaneWidth = 0;
		with (obj_panelPane) {
			if (currentFunction == functionSort) {
				sortPaneWidth = windowWidth;
			}
		}
		windowWidth = camera_get_view_width(view_camera[0]) - x - global.toolPaneWidth - sortPaneWidth;
	}
}


if (mouse_check_button_released(mb_left)) {
	windowResizeXHolding = false;
	windowResizeYHolding = false;
	obj_control.mouseoverPanelPane = false;
}


	
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
	if (object_index != obj_stackShow) {
		obj_control.mouseoverPanelPane = true;
		window_set_cursor(cr_size_ns);
		if (mouse_check_button_pressed(mb_left)) {
			windowResizeYHolding = true;
		}
	}
}


if (object_index == obj_panelPane) {
	if (currentFunction == functionChainContents) {	
		if (surface_exists(clipSurface)) {
			surface_resize(clipSurface, clipWidth, clipHeight);
		}
	}
}

if (mouse_check_button(mb_left)) {
	if (windowResizeXHolding) {
		windowWidth = mouse_x - x;
		window_set_cursor(cr_size_we);
	}
	else if (windowResizeYHolding) {
		windowHeight = clamp(mouse_y - y, 150, camera_get_view_height(view_camera[0]) * 0.5);
		window_set_cursor(cr_size_ns);
		
		if (object_index == obj_panelPane) {
			var helpPaneY = 0;
			with (obj_panelPane) {
				if (currentFunction == functionChainList or currentFunction == functionChainContents
				or currentFunction == functionSort or currentFunction == functionFilter) {
					windowHeight = other.windowHeight;
					if (surface_exists(clipSurface)) {
						surface_resize(clipSurface, clipWidth, clipHeight);
					}
				}
				
				if (currentFunction == functionHelp) {
					y = other.y + other.windowHeight - windowHeight;//obj_control.wordTopMargin - windowHeight;
					helpPaneY = y;
				}
			}
			with (obj_toolPane) {
				windowHeight = helpPaneY - y;
			}
		}
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