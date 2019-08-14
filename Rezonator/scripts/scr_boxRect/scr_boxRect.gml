/*
	scr_boxRect();
	
	Last Updated: 2019-08-13
	
	Called from: obj_control
	
	Purpose: draw a the specialized mouseRect for creating Boxes/Chunks
	
	Mechanism: Create and draw a rectangle based on the positions of a mouse drag
				
	Author: Georgio Klironomos
*/

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
}

// On release, signify that a boxRect has been made
if (mouse_check_button_released(mb_left)) {
	boxRectReleased = true;
	if (abs(boxHoldRectY1 - boxHoldRectY2) > 5 or abs(boxHoldRectX1 - boxHoldRectX2) > 5) {
		boxRectMade = true;
	}
}