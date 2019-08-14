if (instance_exists(control)) {
	if (control.is_playing) {
		draw_set_color(c_white);
	}
	else {
		draw_set_color(c_gray);
	}	

	draw_rectangle(x-32, y-32, x+32, y+32, false);
}