// detect mouse inside the button
if (point_in_rectangle(mouse_x, mouse_y, x-8, y-8, x+8, y+8)) {
	window_set_cursor(cr_handpoint)	;
	
	if (mouse_check_button_pressed(mb_left)) { // go to the next room, or wrap around to the first
		if (room == room_last) {
			room_goto(room_first);	
		}
		else {
			room_goto_next();
		}
	}
}