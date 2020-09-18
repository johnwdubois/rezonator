x = camera_get_view_width(view_camera[0]) / 2;
y = camera_get_view_height(view_camera[0]) / 2;

camWidth = camera_get_view_width(view_camera[0]);
camHeight = camera_get_view_height(view_camera[0]);
draw_sprite_ext(spr_pixel, 0, 0, 0, camWidth, camHeight, 0, c_white, myAlpha);
draw_sprite_ext(loadSprite, 0, x, y, 1, 1, 0, c_white, myAlpha);

if (alphaDrop) {
	myAlpha -= 0.05;
	
	if (myAlpha <= 0) {
		if (room == rm_mainScreen && instance_exists(obj_alarm)) {
			with (obj_alarm) {
				alarm[1] = 2;
			}
		}
		instance_destroy();
	}
}