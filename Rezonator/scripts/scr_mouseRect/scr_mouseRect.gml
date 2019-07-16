// Draw the mouse drag rectangle, and the record when the mouse is released
draw_set_color(global.colorThemeSelected1);
draw_set_alpha(0.5);

if (mouse_check_button_pressed(mb_left) && not obj_control.mouseoverPanelPane) {
	obj_control.rectNotInPanelPane = true;
	mouseHoldRectX1 = mouse_x;
	mouseHoldRectY1 = mouse_y;
	mouseHoldRectX2 = mouse_x;
	mouseHoldRectY2 = mouse_y;
	
	with (obj_toolPane) {
		alarm[2] = 1;// Is super finnicky, but kinda works??
	}
	
}
if (mouse_check_button(mb_left) && obj_control.rectNotInPanelPane) {
	mouseHoldRectX2 = mouse_x;
	mouseHoldRectY2 = mouse_y;
	
	if (!(obj_toolPane.currentTool == obj_toolPane.toolStackBrush)) {
		draw_rectangle(mouseHoldRectX1, mouseHoldRectY1, mouseHoldRectX2, mouseHoldRectY2, false);
		draw_set_alpha(1);
		draw_rectangle(mouseHoldRectX1, mouseHoldRectY1, mouseHoldRectX2, mouseHoldRectY2, true);
	}
}
if (mouse_check_button_released(mb_left)) {
	obj_control.rectNotInPanelPane = false;
	
	with (obj_toolPane) {
		alarm[1] = 10;//Maybe this could be the tool switch zone
	}
	
	if (abs(mouseHoldRectY1 - mouseHoldRectY2) > 5) {
		mouseRectMade = true;
	}
}

if (obj_toolPane.currentTool == obj_toolPane.toolRezBrush) {
	for (var i = 0; i < ds_grid_height(obj_chain.cliqueGrid); i++) {
		scr_cliqueGridRefreshUnitIDList(i);
	}
}