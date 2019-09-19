var relativeX = argument0;
var relativeY = argument1;
var helpWindowWidth = argument2;
var helpWindowHeight = argument3;

clipWidth = helpWindowWidth;
clipHeight = helpWindowHeight;
	
clipX = relativeX;
clipY = relativeY;

if (!surface_exists(clipSurface)) {
    clipSurface = surface_create(clipWidth, clipHeight);
}

scr_windowCameraAdjust();

surface_set_target(clipSurface);
draw_clear_alpha(c_black, 0);