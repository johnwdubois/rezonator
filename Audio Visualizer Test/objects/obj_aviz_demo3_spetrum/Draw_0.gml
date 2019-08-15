// draw our FFT using healthbars!
var xx = room_width/2 - 300;
var yy = room_height/2 + 64;
var width = 25;
var gap = 5;
xx += gap/2;
draw_set_color(c_white);
for (var i=0; i<bars; i++) { 
	var len = bargraph[i];
	draw_healthbar(xx, yy-128, xx+width, yy, len*100, c_black, c_green, c_red, 3, false, false);
	xx += width + gap;
}