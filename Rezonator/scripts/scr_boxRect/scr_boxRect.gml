function scr_boxRect() {
	/*
		Purpose: draw a the specialized mouseRect for creating Boxes/Chunks
	*/
	
	show_debug_message("scr_boxRect()");

	// Draw the mouse drag rectangle, and the record when the mouse is released
	draw_set_color(global.colorThemeSelected1);
	draw_set_alpha(0.5);

	// Initialize the rectangles top left position
	if (mouse_check_button_pressed(mb_left)) {
		boxHoldRectX1 = mouse_x;
		boxHoldRectY1 = mouse_y;
		boxHoldRectX2 = mouse_x;
		boxHoldRectY2 = mouse_y;
		boxRectReleased = false;
	}

	// Dynamically set the bottom right corner of the rect
	if (mouse_check_button(mb_left)) {
		boxHoldRectX2 = mouse_x;
		boxHoldRectY2 = mouse_y;
	
		var rectBottomY = max(boxHoldRectY1, boxHoldRectY2);
		var rectTopY = min(boxHoldRectY1, boxHoldRectY2);
		if(rectTopY > obj_control.lineContainsMouseYPos and rectBottomY < (obj_control.lineContainsMouseYPos + obj_control.gridSpaceVertical)) {
			obj_control.boxRectWithinLine = true;
		}
		else {
			obj_control.boxRectWithinLine = false;
		}
	
		if(obj_control.boxRectWithinLine) {
		
			draw_set_color(global.colorThemeText);	
		
			draw_set_alpha(1);
			draw_rectangle(boxHoldRectX1, boxHoldRectY1, boxHoldRectX2, boxHoldRectY2, true);
			for (var drawBorderLoop = 0; drawBorderLoop < 2; drawBorderLoop++) {
				draw_rectangle(boxHoldRectX1 - drawBorderLoop, boxHoldRectY1 - drawBorderLoop, boxHoldRectX2 + drawBorderLoop, boxHoldRectY2 + drawBorderLoop, true);
			}
		}
	}

	// On release, signify that a boxRect has been made
	if (mouse_check_button_released(mb_left)) {
		boxRectReleased = true;
		if (abs(boxHoldRectY1 - boxHoldRectY2) > 5 or abs(boxHoldRectX1 - boxHoldRectX2) > 5) {
			boxRectMade = true;
		}
	
	}


}
