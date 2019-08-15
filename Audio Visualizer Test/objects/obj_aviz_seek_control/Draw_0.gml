/// @description
if (instance_exists(control)) {
	draw_set_color(c_white);
	
	draw_line(x-300, y, x+300, y);
	
	var xx = 600*control.last_sample/control.samples;
	draw_circle(x-300+xx, y, 10, false);
	
}