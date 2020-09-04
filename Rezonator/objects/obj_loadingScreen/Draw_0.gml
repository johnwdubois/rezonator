x = camera_get_view_width(view_camera[0]) / 2;
y = camera_get_view_height(view_camera[0]) / 2;
draw_sprite_ext(sPixel, 0, 0, 0, room_width, room_height, 0, c_white, myAlpha);
draw_sprite_ext(spr_loading, 0, x, y, 1, 1, 0, c_white, myAlpha);

myAlpha -= 0.05;
if (myAlpha <= 0) {
	instance_destroy();
}