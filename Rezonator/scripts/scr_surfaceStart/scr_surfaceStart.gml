function scr_surfaceStart() {
	
	
	var panelPaneMinHeight = camera_get_view_height(camera_get_active()) * 0.138;
	var widthOfTool = sprite_get_height(spr_toolsNew);
	var panelPaneMaxHeight = 0;
	if (instance_exists(obj_toolPane)) {
		panelPaneMaxHeight = camera_get_view_height(camera_get_active()) - (obj_toolPane.toolSpriteScale * widthOfTool) * 10;
	}
	
	if (object_index == obj_panelPane) {
	
		var chainContentsX = 0;
		with (obj_panelPane) {
			if (currentFunction == functionChainList) {
				chainContentsX = x + windowWidth;
			}
		}
	
		if (currentFunction == functionChainContents) {
			x = chainContentsX;
			windowWidth = camera_get_view_width(camera_get_active()) - x;
		}
	}
	
	

	if (mouse_check_button_released(mb_left)) {
		with (obj_panelPaneL) windowResizeXHolding = false;
		with (obj_panelPaneL) windowResizeYHolding = false;
		with (obj_panelPaneR) windowResizeXHolding = false;
		with (obj_panelPaneR) windowResizeYHolding = false;
		
		with (obj_control) {
			mouseoverPanelPane = false;
		}
	}

	
	if (abs(mouse_y - (y + windowHeight)) < 5
	and mouse_x > x and mouse_x < x + windowWidth) {
		if (object_index != obj_gridViewer) {
			with (obj_control){
				mouseoverPanelPane = true;
			}
			if (room != rm_importScreen) {
				window_set_cursor(cr_size_ns);
			}
			if (mouse_check_button_pressed(mb_left)) {
				with (obj_panelPaneL) windowResizeYHolding = true;
				with (obj_panelPaneR) windowResizeYHolding = true;
			}
		}
	}



	if (object_index == obj_panelPane) {
		if (currentFunction == functionChainContents) {	
			if (surface_exists(clipSurface)) {
				surface_resize(clipSurface, clipWidth, clipHeight);
			}
		}


		var helpPaneY = 0;
		with (obj_panelPane) {
			if (currentFunction == functionChainList or currentFunction == functionChainContents) {
				windowHeight = clamp(windowHeight, panelPaneMinHeight, panelPaneMaxHeight);
				if (surface_exists(clipSurface)) {
					surface_resize(clipSurface, clipWidth, clipHeight);
				}
			}
				
			if (currentFunction == functionHelp) {
				y = other.y + other.windowHeight - windowHeight;
				helpPaneY = y;
			}
		}
		with (obj_toolPane) {
			windowHeight = helpPaneY - y;
		}

	}



	if (object_index != obj_gridViewer && room != rm_importScreen) {
		if (mouse_check_button(mb_left)) {
			if (windowResizeXHolding) {
				windowWidth = mouse_x - x;
				window_set_cursor(cr_size_we);
			}
			else if (windowResizeYHolding) {
				window_set_cursor(cr_size_ns);
		
				if (object_index == obj_panelPane) {
					windowHeight = clamp(mouse_y - y, panelPaneMinHeight, panelPaneMaxHeight);
					var helpPaneY = 0;
					with (obj_panelPane) {
						if (currentFunction == functionChainList or currentFunction == functionChainContents) {
							windowHeight = other.windowHeight;
							if (surface_exists(clipSurface)) {
								surface_resize(clipSurface, clipWidth, clipHeight);
							}
						}
				
						if (currentFunction == functionHelp) {
							y = other.y + other.windowHeight - windowHeight;
							helpPaneY = y;
						}
					}
					with (obj_toolPane) {
						windowHeight = helpPaneY - y;
					}
				}
				else {
					windowHeight = clamp(mouse_y - y, panelPaneMinHeight, camera_get_view_height(camera_get_active()) * 0.75);
				}
			}
	
			if (windowResizeXHolding or windowResizeYHolding) {
				if (surface_exists(clipSurface)) {
					surface_resize(clipSurface, clipWidth, clipHeight);
				}
			}
		}
	}

	if (windowResizeXHolding or windowResizeYHolding) {
		with (obj_control) {
			mouseoverPanelPane = true;
		}
	}
	


	windowWidth = clamp(windowWidth, 48, camera_get_view_width(camera_get_active()) - 48);
	windowHeight = clamp(windowHeight, 48, camera_get_view_height(camera_get_active()) - 48);
	clipWidth = windowWidth;
	clipHeight = windowHeight;
	
	windowX = x;
	windowY = y;
	clipX = x;
	clipY = y;

	if (!surface_exists(clipSurface)) {
	    clipSurface = surface_create(clipWidth, clipHeight);
	}
	if (surface_exists(clipSurface)) {
		surface_resize(clipSurface, clipWidth, clipHeight);
	}
	
	scr_fullScreenCam();

	surface_set_target(clipSurface);
	draw_clear_alpha(c_black, 0);


}
