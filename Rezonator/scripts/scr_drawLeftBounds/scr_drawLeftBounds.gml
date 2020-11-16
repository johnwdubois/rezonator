function scr_drawLeftBounds(camViewHeight) {
	// draw out of bounds rectangle on left


	draw_set_color(global.colorThemeOutOfBounds);
	var leftOutOfBoundsRectX1 = obj_control.speakerLabelMargin;
	var leftOutOfBoundsRectY1 = 0;
	var leftOutOfBoundsRectX2 = obj_control.wordLeftMargin - 20;
	var leftOutOfBoundsRectY2 = camViewHeight;


	if (currentActiveLineGrid == searchGrid) {
		leftOutOfBoundsRectX2 = leftScreenBound;
	}
	
	if (abs(leftOutOfBoundsRectX1 - leftOutOfBoundsRectX2) > 2) {
		draw_rectangle(leftOutOfBoundsRectX1, leftOutOfBoundsRectY1, leftOutOfBoundsRectX2, leftOutOfBoundsRectY2, false);
	}


}
