clipX = x;
clipY = y;

// create a surface if it doesn't exist:
if (!surface_exists(clipSurface)) {
    clipSurface = surface_create(windowWidth, windowHeight);
}
// clear and start drawing to surface:
surface_set_target(clipSurface);
draw_clear_alpha(c_black, 0);