/*	
	Purpose: draw a rectangle for creating quickLinks/quickStacks
*/
function scr_mouseRect() {
	
	// is user releases mouse, do something!
	if (mouse_check_button_released(mb_left)) {

		if (ds_list_size(inRectTokenIDList) > 0) {
			// create chunk
			if (ds_list_size(inRectUnitIDList) == 1) {
				scr_createChunk();
			}
			// quicklinks
			else if (ds_list_size(inRectUnitIDList) > 1 && obj_toolPane.currentMode == obj_toolPane.modeRez) {
				scr_quickLinkCreation();
			}
		}
		
		// reset mouserect variables
		mouseHoldRectX1 = -1;
		mouseHoldRectY1 = -1;
	}
	
	// if user clicks, save the position of their mouse
	var canMakeMouseRect = !mouseoverPanelPane && mouseoverNeutralSpace && mouse_check_button_pressed(mb_left);
	if (canMakeMouseRect) {
		mouseHoldRectX1 = mouse_x;
		mouseHoldRectY1 = mouse_y;
	}
	
	// if user is making a mouse rect, let's draw it
	if (mouseHoldRectX1 >= 0 && mouseHoldRectY1 >= 0) {
		
		// if the mouseRect contains multiple units, let's fill it in
		if (ds_list_size(inRectUnitIDList) > 1) {
			draw_set_color(global.colorThemeSelected1);
			draw_set_alpha(0.3);
			draw_rectangle(mouseHoldRectX1, mouseHoldRectY1, mouse_x, mouse_y, false);
		}
		
		// draw mouse rect border
		draw_set_color(global.colorThemeSelected1);
		draw_set_alpha(0.7);
		scr_drawRectWidth(mouseHoldRectX1, mouseHoldRectY1, mouse_x, mouse_y, 2, false);
		draw_set_alpha(1);
	}
	
	

	
	
	
	
	/*
	// Initialize the rectangle's top left position based on mouse position
	if (mouse_check_button_pressed(mb_left) 
	and not obj_control.mouseoverPanelPane 
	and not obj_control.dialogueBoxActive 
	and not obj_control.mouseRectMade) {
		
		obj_control.rectNotInPanelPane = true;
		mouseHoldRectX1 = mouse_x;
		mouseHoldRectY1 = mouse_y;
		mouseHoldRectX2 = mouse_x;
		mouseHoldRectY2 = mouse_y;
	
		// Set the gesture's starting pos
		if(obj_control.hoverTokenID != -1) {
			obj_control.mouseRectBeginInWord = obj_control.hoverTokenID;	
		}
	
		if(obj_control.mouseoverSpeakerLabel) {
			obj_control.mouseRectBeginInSpeakerLabel = true;
		}
	}

	// Dynamically set the bottom right corner of the rect
	if (mouse_check_button(mb_left) and obj_control.rectNotInPanelPane) {
		mouseHoldRectX2 = mouse_x;
		mouseHoldRectY2 = mouse_y;
	
		// Set the gesture's current pos
		var rectBottomY = max(mouseHoldRectY1, mouseHoldRectY2);
		var rectTopY = min(mouseHoldRectY1, mouseHoldRectY2);
		
		//Check if the mouseRect is within a discourse line
		if (rectTopY > obj_control.lineContainsMouseYPos 
		and rectBottomY < (obj_control.lineContainsMouseYPos + obj_control.gridSpaceVertical)) {
			obj_control.mouseRectWithinLine = true;
		
			// Check if the current gesture is a rezChunk
			if(obj_toolPane.tempReturnTool == obj_toolPane.toolRezBrush and obj_control.mouseRectBeginInWord == -1) {
				obj_toolPane.currentTool = obj_toolPane.toolRezBrush;	
			}
		}
		else {
			obj_control.mouseRectWithinLine = false;
			// Check if the current gesture is a quickStack
			if(obj_control.mouseoverSpeakerLabel and obj_control.mouseRectBeginInSpeakerLabel) {
				
				obj_toolPane.currentTool = obj_toolPane.toolStackBrush;	
				
				show_debug_message(string(obj_toolPane.currentTool))
			}
		}
		

		// Check if the mouseRect is contained within a single column of words
		if (abs(mouseHoldRectX1 - mouseHoldRectX2) < obj_control.gridSpaceVertical) {
			obj_control.mouseRectWithinColumn = true;
		}
		else {
			obj_control.mouseRectWithinColumn = false;
		}
	
		// Draw the rect if not making a quickStack
		if (obj_toolPane.currentTool != obj_toolPane.toolStackBrush) {
			if (obj_control.mouseRectWithinLine) {

				draw_set_color(global.colorThemeSelected1);	
				draw_set_alpha(1);
				draw_rectangle(mouseHoldRectX1, mouseHoldRectY1, mouseHoldRectX2, mouseHoldRectY2, true);
				
				// Draw the mouseRect as a possible Chunk
				for (var drawBorderLoop = 0; drawBorderLoop < 2; drawBorderLoop++) {
					if (obj_toolPane.currentTool == obj_toolPane.toolTrackBrush) {
						draw_roundrect(mouseHoldRectX1 - drawBorderLoop, mouseHoldRectY1 - drawBorderLoop, mouseHoldRectX2 + drawBorderLoop, mouseHoldRectY2 + drawBorderLoop, true);
					}
					else {
						draw_rectangle(mouseHoldRectX1 - drawBorderLoop, mouseHoldRectY1 - drawBorderLoop, mouseHoldRectX2 + drawBorderLoop, mouseHoldRectY2 + drawBorderLoop, true);
					}
				}
			}
			else {
				draw_set_color(global.colorThemeSelected1);	
				draw_set_alpha(0.5);
				draw_rectangle(mouseHoldRectX1, mouseHoldRectY1, mouseHoldRectX2, mouseHoldRectY2, false);
				draw_set_alpha(1);
				draw_rectangle(mouseHoldRectX1, mouseHoldRectY1, mouseHoldRectX2, mouseHoldRectY2, true);
			}
		}
	}

	// On release, signify that a mouseRect has been made
	if (mouse_check_button_released(mb_left)) {
	
		// Switch back to the previous tool
		with (obj_toolPane) {
			alarm[1] = 10;
		}
	
		// Set the word rectangle to capture word info
		if (abs(mouseHoldRectY1 - mouseHoldRectY2) > 5 or (obj_control.mouseRectWithinLine and abs(mouseHoldRectX1 - mouseHoldRectX2) > 5)) { //abs(boxHoldRectX1 - boxHoldRectX2) > 5 for trackChunks?
			mouseRectMade = true;
		}
		else {
			obj_control.mouseRectBeginInWord = -1;
			obj_control.mouseRectBeginBetweenWords = -1;
		}
	
		// Reset initialization variables
		obj_control.rectNotInPanelPane = false;
		obj_control.mouseRectBeginInSpeakerLabel = false;

	}
	*/
}
