x = camera_get_view_width(camera_get_active()) / 2;
y = camera_get_view_height(camera_get_active()) / 2;

camWidth = camera_get_view_width(camera_get_active());
camHeight = camera_get_view_height(camera_get_active());
draw_sprite_ext(spr_pixel, 0, 0, 0, camWidth, camHeight, 0, c_white, (loadSprite == spr_saving) ? 0 : myAlpha);
draw_sprite_ext(loadSprite, 0, x, y, 1, 1, 0, c_white, myAlpha * 0.75);

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