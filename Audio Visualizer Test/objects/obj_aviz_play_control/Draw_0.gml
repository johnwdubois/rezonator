if (not instance_exists(control)) { // if no audio, grey out
	draw_set_color(c_gray);
	draw_triangle(x-32, y-32, x-32, y+32, x+32, y, false);
}
else if (control.is_playing and not control.is_paused) { // if playing and not paused, show pause icon
	draw_set_color(c_white);
	draw_rectangle(x-32, y-32, x-8, y+32, false);
	draw_rectangle(x+8, y-32, x+32, y+32, false);
}
else { // otherwise we assume it's stopped or pause,d so show play triangle
	draw_set_color(c_white);
	draw_triangle(x-32, y-32, x-32, y+32, x+32, y, false);
}