if (instance_exists(control)) { // if the audio exists at all
	
	if (point_in_rectangle(mouse_x, mouse_y, x-32, y-32, x+32, y+32)) {
		window_set_cursor(cr_handpoint)	;
	
		if (mouse_check_button_pressed(mb_left)) { // resume, pause, or play depending on state of audio
			with (control) {
				if (is_paused) {
					event_user(EVENT_RESUME);
				}
				else if (is_playing) {
					event_user(EVENT_PAUSE);
				}
				else {
					event_user(EVENT_PLAY);	
				}
			}
		}
	}
}