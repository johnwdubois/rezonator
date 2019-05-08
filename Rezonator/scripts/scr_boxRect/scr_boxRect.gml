// Draw the mouse drag rectangle, and the record when the mouse is released
draw_set_color(global.colorThemeSelected1);
draw_set_alpha(0.5);

if (mouse_check_button_pressed(mb_left)) {
	boxHoldRectX1 = mouse_x;
	boxHoldRectY1 = mouse_y;
	boxHoldRectX2 = mouse_x;
	boxHoldRectY2 = mouse_y;
	boxRectReleased = false;
	//show_message("hold");
	/*with (obj_toolPane) {
		alarm[2] = 1;// Is super finnicky, but kinda works??
	}*/
	
	/*if (mouse_y > obj_toolPane.y + obj_toolPane.windowHeight) {
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
	}*/
	
}
if (mouse_check_button(mb_left)) {
	boxHoldRectX2 = mouse_x;
	boxHoldRectY2 = mouse_y;
	draw_rectangle(boxHoldRectX1, boxHoldRectY1, boxHoldRectX2, boxHoldRectY2, false);
	draw_set_alpha(1);
	draw_rectangle(boxHoldRectX1, boxHoldRectY1, boxHoldRectX2, boxHoldRectY2, true);
	//show_message(string(mouseHoldRectX1) + " " + string(mouseHoldRectX2) + " " + string(mouseHoldRectY1) + " " + string(mouseHoldRectY2));
	/*if (mouse_y > obj_toolPane.y + obj_toolPane.windowHeight) {
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
	}*/
}
if (mouse_check_button_released(mb_left)) {
	/*if (mouse_y > obj_toolPane.y + obj_toolPane.windowHeight) {
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
	}*/
	/*with (obj_toolPane) {
		alarm[1] = 10;//Maybe this could be the tool switch zone
	}*/
	//show_message("release");
	boxRectReleased = true;
	if (abs(boxHoldRectY1 - boxHoldRectY2) > 5) {
		boxRectMade = true;
	}
}