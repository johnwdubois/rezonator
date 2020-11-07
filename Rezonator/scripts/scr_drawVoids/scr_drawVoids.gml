function scr_drawVoids(drawWordLoop, previousWordDisplayCol, gridSpaceHorizontal, wordLeftMargin, currentLineY, currentWordVoid, currentWordDisplayCol) {
	currentWordDisplayCol = (currentWordDisplayCol==undefined) ? 1 : currentWordDisplayCol;

	if (drawWordLoop > 0) {
		var voidRectX1 = ((previousWordDisplayCol + 1) * gridSpaceHorizontal) + wordLeftMargin;
	}
	else {
		var voidRectX1 = 0;
	}
	var voidRectY1 = currentLineY - 10;
	var voidRectX2 = (currentWordDisplayCol * gridSpaceHorizontal) + wordLeftMargin;
	var voidRectY2 = currentLineY + 15;
			
	draw_set_alpha(0.5);
	draw_set_color(c_green);
	if (currentWordVoid > 6) {
		draw_set_color(c_yellow);
		if (currentWordVoid > 10) {
			draw_set_color(c_orange);
			if (currentWordVoid > 17) {
				draw_set_color(c_red);
			}
		}
	}
		
	draw_rectangle(voidRectX1, voidRectY1, voidRectX2, voidRectY2, false);


}
