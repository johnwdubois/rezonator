function scr_surfaceStartGridViewer(argument0) {
	clipWidth[argument0] = windowWidth[argument0];
	clipHeight[argument0] = windowHeight[argument0];
	
	clipX[argument0] = windowX[argument0];
	clipY[argument0] = windowY[argument0];

	if (!surface_exists(clipSurface[argument0])) {
	    clipSurface[argument0] = surface_create(clipWidth[argument0], clipHeight[argument0]);
	}

	surface_set_target(clipSurface[argument0]);
	draw_clear_alpha(c_black, 0);


}
