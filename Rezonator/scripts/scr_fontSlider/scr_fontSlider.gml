// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_fontSlider(){
	
	var sliderX2 = saveIconX1 - (sizeOfSave / 2);
	var sliderX1 = sliderX2 - (camWidth * 0.07);
	var sliderY = fpsTextY;
	var sliderWidth = sliderX2 - sliderX1;
	var sliderHeight = sizeOfSave;
	var mouseoverSlider = point_in_rectangle(mouse_x, mouse_y, sliderX1, sliderY - (sliderHeight / 2), sliderX2, sliderY + (sliderHeight / 2));
	draw_set_alpha(mouseoverSlider ? 1 : 0.85);
	draw_set_color(c_white);
	draw_line(sliderX1, fpsTextY, sliderX2, sliderY);
	var fontSizes = 6;
	var sliderPointRadSmall = 2;
	var sliderPointRadBig = 4;
	var sliderPointMinDistToMouse = 99999999999;
	var sliderPointSelected = -1;
	for (var i = 0; i < fontSizes; i++) {
		var sliderPointX = sliderX1 + ((sliderWidth / (fontSizes - 1)) * i);
		var sliderPointRad = (i == global.fontSize) ? sliderPointRadBig : sliderPointRadSmall;
		draw_circle(sliderPointX, sliderY, sliderPointRad, false);
	
		if (mouseoverSlider && mouse_check_button(mb_left)) {
			if (point_distance(mouse_x, mouse_y, sliderPointX, sliderY) < sliderPointMinDistToMouse) {
				sliderPointMinDistToMouse = point_distance(mouse_x, mouse_y, sliderPointX, sliderY);
				sliderPointSelected = i;
			}
		}
	}
	if (sliderPointSelected >= 0) global.fontSize = sliderPointSelected;
	draw_set_alpha(1);

}