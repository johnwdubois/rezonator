// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_miniSurfaceStart(){
	clipX = x;
	clipY = y;
	clipWidth = windowWidth;
	clipHeight = windowHeight;
	// create a surface if it doesn't exist:
	if (!surface_exists(clipSurface)) {
	    clipSurface = surface_create(clipWidth, clipHeight);
	}
	// clear and start drawing to surface:
	surface_set_target(clipSurface);
	draw_clear_alpha(c_black, 0);
}