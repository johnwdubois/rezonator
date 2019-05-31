if (mouse_x > x && mouse_x < x + windowWidth
&& mouse_y > y && mouse_y < y + windowHeight) {
	x = mouse_x - (windowWidth / 2);
	y = mouse_y - (windowHeight / 2);
}