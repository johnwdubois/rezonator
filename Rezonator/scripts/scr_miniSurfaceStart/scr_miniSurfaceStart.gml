function scr_miniSurfaceStart(cX, cY) {
	clipX = cX;
	clipY = cY;
	clipWidth = windowWidth;
	clipHeight = windowHeight;
	// create a surface if it doesn't exist:
	if (!surface_exists(clipSurface)) {
	    clipSurface = surface_create(clipWidth, clipHeight);
	}
	if (surface_exists(clipSurface)) {
		surface_resize(clipSurface, clipWidth, clipHeight);
	}
	// clear and start drawing to surface:
	surface_set_target(clipSurface);
	draw_clear_alpha(c_black, 0);
}