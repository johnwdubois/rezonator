var xx = room_width/2 - 300;
var yy = room_height/2;

buffer_seek(waveform_data, buffer_seek_start, 0);
var position = 600*last_sample/samples; // position of the played up-to line

// this is not an efficient way of producing this visualisation, but it should be easier to understand
// the buffer is 600 wide which is the same width as the visualization, so 1 pixel per line.
// for each of the 600 lines, read the height from the waveform data buffer, and calculate a color for it
for (var p=0; p<600; p++) { 
	 // height of each line
	var height = 200*buffer_read(waveform_data, buffer_f32);
	
	// calculate the color of the line
	if (p < position) {
		var val = 127+128*(sin(p/50+get_timer()/100000)/2 + 0.5); // just some fun effects
		var hue = (get_timer()/10000-p) % 255
		draw_set_color(make_color_hsv(hue, 255, val));
	}
	else {
		draw_set_color(c_dkgray);	
	}
	
	// draw the actual line
	draw_line(xx+p, yy-height, xx+p, yy+height); 
}