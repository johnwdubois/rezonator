/*
	scr_mouseRect();
	
	Last Updated: 2019-08-13
	
	Called from: obj_control
	
	Purpose: draw a rectangle for creating quickLinks/quickStacks
	
	Mechanism: Create and draw a rectangle based on the positions of a mouse drag
				
	Author: Georgio Klironomos
*/

// Draw the mouse drag rectangle, and the record when the mouse is released
draw_set_color(global.colorThemeSelected1);
draw_set_alpha(0.5);

// Initialize the rectangles top left position
if (mouse_check_button_pressed(mb_left) && not obj_control.mouseoverPanelPane && not obj_control.dialogueBoxActive) {
	obj_control.rectNotInPanelPane = true;
	mouseHoldRectX1 = mouse_x;
	mouseHoldRectY1 = mouse_y;
	mouseHoldRectX2 = mouse_x;
	mouseHoldRectY2 = mouse_y;
	
	// Set the gesture's starting pos
	if(obj_control.hoverWordID != -1) {
		obj_control.mouseRectBeginInWord = true;	
	}
	
	// Set the active tool based on the gesture
	with (obj_toolPane) {
		alarm[2] = 1;// Is super finnicky, but kinda works??
	}
	
}

// Dynamically set the bottom right corner of the rect
if (mouse_check_button(mb_left) && obj_control.rectNotInPanelPane) {
	mouseHoldRectX2 = mouse_x;
	mouseHoldRectY2 = mouse_y;
	
	// Set the gesture's current pos
	if(abs(mouseHoldRectY1 - mouseHoldRectY2) < obj_control.gridSpaceVertical) {
		obj_control.mouseRectWithinLine = true;
		
		// Check if the current gesture is a rezChunk
		if(obj_toolPane.tempReturnTool == obj_toolPane.toolRezBrush and not obj_control.mouseRectBeginInWord) {
			obj_toolPane.currentTool = obj_toolPane.toolRezBrush;	
		}
	}
	else {
		obj_control.mouseRectWithinLine = false;
		// Check if the current gesture is a quickStack
		if(obj_toolPane.tempReturnTool == obj_toolPane.toolRezBrush and not obj_control.mouseRectBeginInWord) {
			obj_toolPane.currentTool = obj_toolPane.toolStackBrush;	
		}
	}
	
	// Draw the rect if not making a quickStack
	if (!(obj_toolPane.currentTool == obj_toolPane.toolStackBrush)) {
		draw_rectangle(mouseHoldRectX1, mouseHoldRectY1, mouseHoldRectX2, mouseHoldRectY2, false);
		draw_set_alpha(1);
		draw_rectangle(mouseHoldRectX1, mouseHoldRectY1, mouseHoldRectX2, mouseHoldRectY2, true);
	}
}

// On release, signify that a mouseRect has been made
if (mouse_check_button_released(mb_left)) {
	
	
	// Switch back to the previous tool
	with (obj_toolPane) {
		alarm[1] = 10;
	}
	
	// Reset the gesture variables
	if (abs(mouseHoldRectY1 - mouseHoldRectY2) > 5) { //abs(boxHoldRectX1 - boxHoldRectX2) > 5 for trackChunks?
		mouseRectMade = true;
	}
	else {
		obj_control.mouseRectBeginInWord = false;
		obj_control.mouseRectBeginBetweenWords = false;
	}
	obj_control.mouseRectWithinLine = false;
	obj_control.rectNotInPanelPane = false;

}

// Refresh the cliques if we've made Rez chains
if (obj_toolPane.currentTool == obj_toolPane.toolRezBrush) {
	for (var i = 0; i < ds_grid_height(obj_chain.cliqueGrid); i++) {
		scr_cliqueGridRefreshUnitIDList(i);
	}
}