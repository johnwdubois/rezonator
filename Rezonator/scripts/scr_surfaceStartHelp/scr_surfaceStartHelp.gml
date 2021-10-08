function scr_surfaceStartHelp(relativeX, relativeY, helpWindowWidth, helpWindowHeight) {

	clipWidth = helpWindowWidth;
	clipHeight = helpWindowHeight;
	
	clipX = relativeX;
	clipY = relativeY;

	if (!surface_exists(clipSurface)) {
	    clipSurface = surface_create(clipWidth, clipHeight);
	}

	scr_fullScreenCam();

	surface_set_target(clipSurface);
	draw_clear_alpha(c_black, 0);


}
