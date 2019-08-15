if (instance_exists(control)) { // if the audio exists at all
	
	if (point_in_rectangle(mouse_x, mouse_y, x-300, y-15, x+300, y+15)) {
		window_set_cursor(cr_handpoint)	;
	
		if (mouse_check_button(mb_left)) {
			var offset = (x-300);
			with (control) {
				seek_to = samples * (mouse_x-offset)/600;
				event_user(EVENT_SEEK);
			}
		}
	}
}