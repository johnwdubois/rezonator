// Draw the mouse drag rectangle, and the record when the mouse is released
draw_set_color(global.colorThemeSelected1);
draw_set_alpha(0.5);

if (mouse_check_button_pressed(mb_left)) {
	mouseHoldRectX1 = mouse_x;
	mouseHoldRectY1 = mouse_y;
	mouseHoldRectX2 = mouse_x;
	mouseHoldRectY2 = mouse_y;
	
	/*
	if (mouse_y > obj_toolPane.y + obj_toolPane.windowHeight) {
		if (abs(mouseHoldRectY1 - mouseHoldRectY2) > 5) {
			if (obj_toolPane.currentTool != obj_toolPane.toolTrackBrush) {
				if (hoverWordID < 0) {
					obj_toolPane.tempReturnTool = obj_toolPane.currentTool;
					obj_toolPane.currentTool = obj_toolPane.toolStackBrush;
				}
				else {
					obj_toolPane.tempReturnTool = obj_toolPane.currentTool;
					obj_toolPane.currentTool = obj_toolPane.toolRezBrush;
				}
			}
		}
	}
	*/
}
if (mouse_check_button(mb_left)) {
	mouseHoldRectX2 = mouse_x;
	mouseHoldRectY2 = mouse_y;
	if (!(obj_toolPane.currentTool == obj_toolPane.toolStackBrush)) {
		draw_rectangle(mouseHoldRectX1, mouseHoldRectY1, mouseHoldRectX2, mouseHoldRectY2, false);
		draw_set_alpha(1);
		draw_rectangle(mouseHoldRectX1, mouseHoldRectY1, mouseHoldRectX2, mouseHoldRectY2, true);
	}
}
if (mouse_check_button_released(mb_left)) {
	with (obj_toolPane) {
		alarm[1] = 10;
	}
	
	if (abs(mouseHoldRectY1 - mouseHoldRectY2) > 5) {
		mouseRectMade = true;
	}
}