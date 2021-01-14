/*
	scr_mouseRect();
	
	Last Updated: 2020-10-28
	
	Called from: obj_control
	
	Purpose: draw a rectangle for creating quickLinks/quickStacks
	
	Mechanism: Create and draw a rectangle based on the positions of a mouse drag
				
	Author: Georgio Klironomos
*/

function scr_mouseRect() {

	//Set the color and alpha of the rectangle
	draw_set_color(global.colorThemeSelected1);
	draw_set_alpha(0.5);

	// Initialize the rectangle's top left position based on mouse position
	if (mouse_check_button_pressed(mb_left) 
	and not obj_control.mouseoverPanelPane 
	and not obj_control.dialogueBoxActive 
	and not obj_control.mouseRectMade 
	and not obj_toolPane.currentMode == obj_toolPane.modeRead) {
		
		obj_control.rectNotInPanelPane = true;
		mouseHoldRectX1 = mouse_x;
		mouseHoldRectY1 = mouse_y;
		mouseHoldRectX2 = mouse_x;
		mouseHoldRectY2 = mouse_y;
	
		// Set the gesture's starting pos
		if(obj_control.hoverWordID != -1) {
			obj_control.mouseRectBeginInWord = obj_control.hoverWordID;	
		}
	
		if(obj_control.mouseoverSpeakerLabel) {
			obj_control.mouseRectBeginInSpeakerLabel = true;
		}
	
		// Set the active tool based on the gesture
		with (obj_toolPane) {
			alarm[2] = 1;// Is super finnicky, but kinda works??
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
		if(rectTopY > obj_control.lineContainsMouseYPos 
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
			}
		}
		
		// Check if the mouseRect is contained within a single column of words
		if(abs(mouseHoldRectX1 - mouseHoldRectX2) < obj_control.gridSpaceVertical) {
			obj_control.mouseRectWithinColumn = true;
		}
		else {
			obj_control.mouseRectWithinColumn = false;
		}
	
		// Draw the rect if not making a quickStack
		if (!obj_toolPane.currentTool == obj_toolPane.toolStackBrush) {
			if (obj_control.mouseRectWithinLine) {
				if (ds_map_exists(global.nodeMap, obj_chain.currentFocusedChainID)) {
					
					var chainSubMap = ds_map_find_value(global.nodeMap, obj_chain.currentFocusedChainID);
					var chainColor = ds_map_find_value(chainSubMap, "chainColor");
					draw_set_color(chainColor);
					
					/*
					var currentChainGrid = -1;
					if (obj_toolPane.currentTool == obj_toolPane.toolTrackBrush) {
						currentChainGrid = obj_chain.trackChainGrid;
					}
					else {
						currentChainGrid = obj_chain.rezChainGrid;
					}
					var currentChainGridRow = ds_grid_value_y(currentChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(currentChainGrid), obj_chain.currentFocusedChainID);
					
					// Set the highlight to be the focused chains's color
					if(currentChainGridRow > -1) {
						var currentChainColor = ds_grid_get(currentChainGrid, obj_chain.chainGrid_colColor, currentChainGridRow);
						draw_set_color(currentChainColor);
					}
					else {
						draw_set_color(global.colorThemeSelected1);	
					}
					*/
				
				} else {
					draw_set_color(global.colorThemeSelected1);	
				}
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

	// Refresh the cliques if we've made Rez chains
	// CHAIN REHAUL: let's ditch cliques
	/*
	if (obj_toolPane.currentTool == obj_toolPane.toolRezBrush) {
		var cliqueGridHeight = ds_grid_height(obj_chain.cliqueGrid);
		for (var i = 0; i < cliqueGridHeight; i++) {
			scr_cliqueGridRefreshUnitIDList(i);
		}
	}
	*/
}
