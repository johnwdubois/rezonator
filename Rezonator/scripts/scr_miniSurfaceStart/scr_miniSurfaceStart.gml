// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_miniSurfaceStart(){
	clipX = textBoxX;
	clipY = textBoxY;
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