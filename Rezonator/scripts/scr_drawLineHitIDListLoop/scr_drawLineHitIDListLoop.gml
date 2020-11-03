function scr_drawLineHitIDListLoop(argument0, argument1, argument2, argument3, argument4) {
	/*
		scr_drawLineHitIDListLoop(hitIDList, previousWordDisplayCol, currentLineY, drawLineLoop, unitID);
	
		Last Updated: 2019-12-27
	
		Called from: obj_control
	
		Purpose: draws searched words to main screen, using hitIDs from the given hitIDList
	
		Mechanism: loop through hitIDList to get hitIDs, look up their display info in hitGrid & dynaWordGrid
	
		Author: Terry DuBois
	*/

	var currentHitIDList = argument0;
	var previousWordDisplayCol = argument1;
	var currentLineY = argument2;
	var drawLineLoop = argument3;
	var unitID = argument4;

	draw_set_alpha(1);
	var currentHitIDListSize = ds_list_size(currentHitIDList);

	for (var drawWordLoop = 0; drawWordLoop < currentHitIDListSize; drawWordLoop++)
	{
		var currentHitID = ds_list_find_value(currentHitIDList, drawWordLoop);
	
		var currentWordID = ds_grid_get(hitGrid, hitGrid_colWordID, currentHitID - 1);
	
		// Prevent dead words from being drawn
		var currentWordGridRow = currentWordID - 1;
		var currentWordState = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentWordGridRow);
		if(currentWordState == obj_control.wordStateDead) {
		
			continue;
		}
	
		// Check if the word is a ChunkWord
		if(currentWordState == obj_control.wordStateChunk) {
		
			// Here will be functionality to focus on a Chunk and add it to a Chain
			// This includes: Hovering over Chunk will visually effect the outline
			draw_set_font(global.fontMain);

			// Aquire the Chunk's row in the Chunk grid (this is currently too expensive)
			var inChunkList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInBoxList, currentWordGridRow);
			if(ds_list_size(inChunkList) < 1) {
				continue;
			}
		
			// A chunkWord always has its own Chunk as firstin its list
			var currentChunkID = (ds_list_find_value(inChunkList, 0)); //ds_grid_value_y(obj_chain.chunkGrid, obj_chain.chainGrid_colName, 0, obj_chain.chainGrid_colName, ds_grid_height(obj_chain.chunkGrid), currentWordID);
			if(currentChunkID == undefined) {
				continue;
			}
			// Aquire the relevant row in the chunkGrid
			var currentChunkRow = currentChunkID - 1;
			if(currentChunkRow < 0) {
				continue;	
			}

			// Grab the Chunk's list of contained words
			var currentWordList = ds_grid_get(obj_chain.chunkGrid, obj_chain.chunkGrid_colBoxWordIDList, currentChunkRow);
		
			// Safety Check
			if (currentWordList == undefined || ds_list_size(currentWordList) < 1) {
				continue;
			}
		
			// Set all variables needed to draw a Chunk
			var firstWordID = -1;
			var lastWordID = -1;
			var currentUnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWordID - 1);
			var currentLineWordIDList = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, currentUnitID - 1);
			var currentLineWordIDListSize = ds_list_size(currentLineWordIDList);
		
			// Get the first and last word within the Chunk
			firstWordID = ds_list_find_value(currentWordList, 0);
		
			// The true last word within this list is the chunkWordID
			var nonChunkWordPos = ds_list_size(currentWordList)-2;
			lastWordID = ds_list_find_value(currentWordList, nonChunkWordPos);
		
			// Aquire the ID of the last nonChunkWord in this list
			var lastWordState = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colWordState, lastWordID - 1);
			while(lastWordState == wordStateChunk || lastWordState == wordStateDead) {
				lastWordID = ds_list_find_value(currentWordList, --nonChunkWordPos);
				lastWordState = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colWordState, lastWordID - 1);
			}
		
			// Set the Buffer to be initially large, so as to allow for nesting
			var wordRectBuffer = 15;
			if (ds_grid_get(obj_chain.chunkGrid, obj_chain.chunkGrid_colNest, currentChunkRow) == true) {
				wordRectBuffer = 9;
			}
		
			//Modify the chunk for drawing within the searchScreen
			var firstWordHitID = ds_grid_value_y(hitGrid, hitGrid_colWordID, currentHitID - currentLineWordIDListSize - 1, hitGrid_colWordID, currentHitID - 1, firstWordID);
			var lastWordHitID = firstWordHitID + (lastWordID - firstWordID);
		
			// Set up the measurements for the drawn box
			var leftPixelX = ds_grid_get(hitGrid, hitGrid_colPixelX, firstWordHitID);
			//var firstDisplayCol = ds_grid_get(hitGrid, hitGrid_colDisplayCol, firstWordHitID);
			var rightPixelX = ds_grid_get(hitGrid, hitGrid_colPixelX, lastWordHitID);
			ds_grid_set(hitGrid, hitGrid_colPixelX, currentWordGridRow, leftPixelX);
		
			// Get the string of the first word
			var firstWordString = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayString, firstWordID - 1);
			// Get the string of the last word
			var lastWordString = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayString, lastWordID - 1);
		
			// Set the special wordRect
			var topLeftX = leftPixelX - wordRectBuffer;
			var topLeftY = currentLineY - (string_height(firstWordString) / 2) - wordRectBuffer;
			var bottomRightX = rightPixelX + string_width(lastWordString) + (wordRectBuffer); //*2
			var bottomRightY = topLeftY + string_height(firstWordString) + (wordRectBuffer * 2);
		
			// Aquire wordDraw specifics
			var effectColor = ds_grid_get(wordDrawGrid, wordDrawGrid_colEffectColor, currentWordID - 1);//global.colorThemeSelected1
			var drawFocused = ds_grid_get(wordDrawGrid, wordDrawGrid_colFocused, currentWordID - 1);
			var borderRounded = ds_grid_get(wordDrawGrid, wordDrawGrid_colBorderRounded, currentWordID - 1);
		
			// Draw the Chunks visual representation
			if(ds_list_size(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInChainList, currentWordGridRow)) > 0) {
				draw_set_color(effectColor);
			} else {
				draw_set_color(global.colorThemeText);	
			}
			for (var drawBorderLoop = 0; drawBorderLoop < 2; drawBorderLoop++) {
				if (borderRounded) {
					draw_roundrect(topLeftX - drawBorderLoop, topLeftY - drawBorderLoop, bottomRightX + drawBorderLoop, bottomRightY + drawBorderLoop, true);
				}
				else {
					draw_rectangle(topLeftX - drawBorderLoop, topLeftY - drawBorderLoop, bottomRightX + drawBorderLoop, bottomRightY + drawBorderLoop, true);
				}
			}
			if (drawFocused) {
				draw_sprite_ext(spr_focusPoint, 0, topLeftX - wordDrawGridFocusedAnimation, topLeftY - wordDrawGridFocusedAnimation, 1, 1, 0, effectColor, 1);
				draw_sprite_ext(spr_focusPoint, 0, bottomRightX + wordDrawGridFocusedAnimation, topLeftY - wordDrawGridFocusedAnimation, 1, 1, 0, effectColor, 1);
				draw_sprite_ext(spr_focusPoint, 0, topLeftX - wordDrawGridFocusedAnimation, bottomRightY + wordDrawGridFocusedAnimation, 1, 1, 0, effectColor, 1);
				draw_sprite_ext(spr_focusPoint, 0, bottomRightX + wordDrawGridFocusedAnimation, bottomRightY + wordDrawGridFocusedAnimation, 1, 1, 0, effectColor, 1);
			}
		
			// Check for mouseover of the Chunk 
			var mouseover = false;
			if (point_in_rectangle(mouse_x, mouse_y, topLeftX, topLeftY, bottomRightX, bottomRightY) and not (obj_toolPane.currentTool == obj_toolPane.toolNewWord) and not obj_chain.inRezPlay
			and not mouseoverPanelPane and (hoverChunkID == currentWordID || hoverChunkID == -1) and hoverWordID == -1) {
				mouseover = true;
				obj_control.mouseoverNeutralSpace = false;	
			
				// May need to make a hoverChunkID
				hoverChunkID = currentWordID;
				hoverChunkIDRow = currentChunkID - 1;
			
				// Draw the hover highlight
				draw_set_color(global.colorThemeSelected1);
				draw_set_alpha(0.5);
				draw_rectangle(topLeftX, topLeftY, bottomRightX, bottomRightY, false);
			
				if (device_mouse_check_button_released(0, mb_left)) {
					obj_control.clickedChunkID = currentChunkID; // Debug variable
					// Add this Chunk to a chain
					with (obj_chain) {
						scr_wordClicked(currentWordID, unitID);
					}
				}
			}
		
			continue;	
		}
	
		var currentWordDisplayCol = ds_grid_get(hitGrid, hitGrid_colDisplayCol, currentHitID - 1);
		
		var currentWordDestX = currentWordDisplayCol * gridSpaceHorizontal + wordLeftMargin;
		var currentWordX = ds_grid_get(hitGrid, hitGrid_colPixelX, currentHitID - 1);
		obj_control.leftScreenBound = min(currentWordX, obj_control.leftScreenBound);
		
		if (currentWordX < currentWordDestX)
		{
			currentWordX += abs(currentWordX - currentWordDestX) / 6;
		}
		else if (currentWordX > currentWordDestX)
		{
			currentWordX -= abs(currentWordX - currentWordDestX) / 6;
		}
		
		ds_grid_set(hitGrid, hitGrid_colPixelX, currentHitID - 1, currentWordX);
		
		var currentWordString = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayString, currentWordID - 1);
		
		var wordRectX1 = currentWordX;
		var wordRectY1 = currentLineY - (string_height(currentWordString) / 2);
		var wordRectX2 = wordRectX1 + string_width(currentWordString);
		var wordRectY2 = wordRectY1 + string_height(currentWordString);
	
	
		
		if (point_in_rectangle(mouse_x, mouse_y, wordRectX1, wordRectY1, wordRectX2, wordRectY2)) {
			draw_set_alpha(1);
			draw_set_color(global.colorThemeBorders);
			draw_rectangle(wordRectX1, wordRectY1, wordRectX2, wordRectY2, true);
			
			// Record user's click in the Search screen to highlight.
			if (device_mouse_check_button_released(0, mb_left)) {
				var newSwitch = ds_grid_get(hitGrid, hitGrid_colUnitID, currentHitID - 1) - 1;
				with (obj_control) {
					//preSwitchDisplayRow = newSwitch;
					highlightedSearchRow = newSwitch ;
					show_debug_message(newSwitch);
				
				}
			}
		}
	
		var panelPaneResizeHeld = false;

		with(obj_panelPane) {
			if(windowResizeYHolding) {
				panelPaneResizeHeld = true;
			}
		}
	
		//Prevent the mouse from clicking on words/lines while releasing from a drag
		var mouseRectExists = ((abs(obj_control.mouseHoldRectY1 - obj_control.mouseHoldRectY2) > 5) or (abs(obj_control.mouseHoldRectX1 - obj_control.mouseHoldRectX2) > 5));
		if(mouseRectExists) {
			obj_control.mouseoverNeutralSpace = false;		
		}
	
		// figure out if the user has their mouse hovering over this word, and if so, are they clicking?
		var mouseover = false;
		if (point_in_rectangle(mouse_x, mouse_y, wordRectX1, wordRectY1, wordRectX2, wordRectY2) and not (obj_toolPane.currentTool == obj_toolPane.toolNewWord) and not (obj_toolPane.currentTool == obj_toolPane.toolRezBrush) and not obj_chain.inRezPlay
		and not obj_control.mouseOverUI and (hoverWordID == currentWordID || hoverWordID == -1)) {
			obj_control.mouseoverNeutralSpace = false;	
			mouseover = true;
			hoverWordID = currentWordID;
		
			draw_set_color(global.colorThemeBorders);
			draw_set_alpha(1);
			draw_rectangle(wordRectX1, wordRectY1, wordRectX2, wordRectY2, true);
			
			if ((device_mouse_check_button_released(0, mb_left) and not mouseRectExists) and touchReleaseCheck) {
				with (obj_chain) {
					scr_wordClicked(currentWordID, unitID);
				}
			}
		
			if (device_mouse_check_button_released(0, mb_right) and !instance_exists(obj_dialogueBox)and !instance_exists(obj_stackShow)) {

				if(!instance_exists(obj_dialogueBox)){
				obj_control.rightClickWordID = obj_control.newWordHoverWordID;
				obj_control.rightClickUnitID = obj_control.newWordHoverUnitID;
				obj_control.rightClickWordSeq = obj_control.newWordHoverWordSeq;
				}

				obj_control.rightClickonWord = true;
				obj_control.wideDropDown = true;
				var dropDownOptionList = ds_list_create();
				if (obj_toolPane.currentMode == obj_toolPane.modeRead) {
					obj_control.ableToCreateDropDown = false;
				}
				else if(scr_findInGridTwoParameters(obj_chain.linkGrid, obj_chain.linkGrid_colSource , obj_control.rightClickWordID, obj_chain.linkGrid_colDead, obj_chain.chainStateNormal) != -1){
					if(obj_control.searchGridActive){
						ds_list_add(dropDownOptionList,"Delete Link");
					}
					else{
						ds_list_add(dropDownOptionList,"Split Word", "New Word", "Delete New Word", "Delete Link");
					}
				}
				else{
					if(obj_control.searchGridActive){
						obj_control.ableToCreateDropDown = false;
					}
					else{
						ds_list_add(dropDownOptionList,"Split Word", "New Word", "Delete New Word");
					}
				}
				if (ds_list_size(dropDownOptionList) > 0 and obj_control.ableToCreateDropDown) {
					/*var dropDownInst = instance_create_depth(mouse_x, mouse_y, -999, obj_dropDown);
					dropDownInst.optionList = dropDownOptionList;
					dropDownInst.optionListType = dropDownInst.optionListTypeRightClickWord;
					
					obj_control.ableToCreateDropDown = false;
					obj_control.alarm[0] = 2;*/
					scr_createDropDown(mouse_x, mouse_y, dropDownOptionList, obj_control.optionListTypeRightClickWord);
				}

			}
		}
		
		// Allows for adding to a stack w/in the speaker labels
		if(obj_control.mouseoverSpeakerLabel and (obj_toolPane.currentTool == obj_toolPane.toolStackBrush) and not mouseoverPanelPane and rectangle_in_rectangle(0, wordRectY1, room_width - global.scrollBarWidth, wordRectY1 + gridSpaceVertical, min(mouseHoldRectX1, mouseHoldRectX2), min(mouseHoldRectY1, mouseHoldRectY2), max(mouseHoldRectX1, mouseHoldRectX2), max(mouseHoldRectY1, mouseHoldRectY2))) {
			if ((device_mouse_check_button_released(0, mb_left) and !obj_chain.inRezPlay) and (not mouseRectExists and touchReleaseCheck) and !instance_exists(obj_stackShow)) {
				with (obj_chain) {
					scr_wordClicked(currentWordID, unitID);
				}
			}
		}
		else if((drawWordLoop + 1 == ds_list_size(currentHitIDList)) and not obj_control.rectNotInPanelPane and not obj_panelPane.scrollBarClickLock and not panelPaneResizeHeld and not obj_control.mouseoverPanelPane
		and point_in_rectangle(mouse_x, mouse_y, wordRectX2 + 100, wordRectY1, room_width - global.scrollBarWidth, wordRectY1 + gridSpaceVertical)) {
			if(global.canScroll) {
				obj_control.mouseoverNeutralSpace = true;
			}
			if (device_mouse_check_button_released(0, mb_left)) {
				with(obj_chain) {
					scr_chainDeselect();
					scr_refreshVizLinkGrid();	
				}
			}
		}
	
		if (point_in_rectangle(mouse_x, mouse_y, wordRectX1, wordRectY1, wordRectX2, wordRectY2) and !instance_exists(obj_dialogueBox)) {
				
			// Set this to be the hovered wordID
			newWordHoverUnitID = currentHitID;
			newWordHoverWordSeq = ds_grid_get(wordGrid, wordGrid_colWordSeq, currentWordID - 1);
			newWordHoverWordID = currentWordID;
				
		}
	
		// quicklinks in search screen	
		if ((obj_toolPane.currentTool == obj_toolPane.toolTrackBrush) and mouseRectMade and obj_control.mouseRectWithinColumn) {
			inMouseHoldRect = rectangle_in_rectangle(wordRectX1, wordRectY1, wordRectX1 + obj_control.gridSpaceHorizontal, wordRectY2, min(mouseHoldRectX1, mouseHoldRectX2), min(mouseHoldRectY1, mouseHoldRectY2), max(mouseHoldRectX1, mouseHoldRectX2), max(mouseHoldRectY1, mouseHoldRectY2));
			if (inMouseHoldRect) {
				with (obj_control) {
					if (ds_grid_get(obj_control.hitGrid, obj_control.hitGrid_colHitBool, currentHitID -1)) {	
						if (ds_list_find_index(inRectWordIDList, currentWordID) < 0) {
							ds_list_add(inRectWordIDList, currentWordID);
							ds_list_add(inRectHitIDList, currentHitID);
						}
					}
				}
			}
		}
	
	
		// allow quick stacks on the search screen
		if ((obj_toolPane.currentTool == obj_toolPane.toolStackBrush) and mouseRectMade) {
			inMouseHoldRect = rectangle_in_rectangle(0, wordRectY1, room_width, wordRectY2, min(mouseHoldRectX1, mouseHoldRectX2), min(mouseHoldRectY1, mouseHoldRectY2), max(mouseHoldRectX1, mouseHoldRectX2), max(mouseHoldRectY1, mouseHoldRectY2));
			if (inMouseHoldRect) {
				with (obj_control) {
					if (ds_list_find_index(inRectUnitIDList, unitID) == -1) {
						ds_list_add(inRectUnitIDList, unitID);
						ds_list_add(inRectWordIDList, currentWordID);
					}
				}
			}
		}
	
		var inMouseHoldRect = 0;
		if (mouse_check_button(mb_left) and obj_toolPane.currentTool == obj_toolPane.toolTrackBrush) {
			if (not obj_control.mouseRectWithinLine and obj_control.mouseRectWithinColumn) {
				inMouseHoldRect = rectangle_in_rectangle(wordRectX1, wordRectY1, wordRectX1 + obj_control.gridSpaceHorizontal - 20, wordRectY2, min(mouseHoldRectX1, mouseHoldRectX2), min(mouseHoldRectY1, mouseHoldRectY2), max(mouseHoldRectX1, mouseHoldRectX2), max(mouseHoldRectY1, mouseHoldRectY2));
			}
			else {
				inMouseHoldRect = 0;
			}
		 
			if (inMouseHoldRect > 0) {
				if (not ds_grid_get(wordDrawGrid, wordDrawGrid_colBorder, currentWordID - 1)) {
					ds_grid_set(wordDrawGrid, wordDrawGrid_colBorder, currentWordID - 1, 2);
					ds_grid_set(wordDrawGrid, wordDrawGrid_colBorderRounded, currentWordID - 1, 2);
				
				}
			}
			else {
				if (ds_grid_get(wordDrawGrid, wordDrawGrid_colBorder, currentWordID - 1) == 2) {
					ds_grid_set(wordDrawGrid, wordDrawGrid_colBorder, currentWordID - 1, false);
					ds_grid_set(wordDrawGrid, wordDrawGrid_colBorderRounded, currentWordID - 1, false);
				}
			}
		}
		else {
			if (ds_grid_get(wordDrawGrid, wordDrawGrid_colBorder, currentWordID - 1) == 2) {
				ds_grid_set(wordDrawGrid, wordDrawGrid_colBorder, currentWordID - 1, false);
				ds_grid_set(wordDrawGrid, wordDrawGrid_colBorderRounded, currentWordID - 1, false);
			}
		}
	
		draw_set_alpha(1);
		draw_set_color(global.colorThemeBG);
		draw_rectangle(wordRectX1, wordRectY1, wordRectX2, wordRectY2, false);
	
		// figure out whether or not to draw fill/border for this word
		var drawFillRect = ds_grid_get(wordDrawGrid, wordDrawGrid_colFillRect, currentWordID - 1);
		var drawBorder = ds_grid_get(wordDrawGrid, wordDrawGrid_colBorder, currentWordID - 1);
		var drawFocused = ds_grid_get(wordDrawGrid, wordDrawGrid_colFocused, currentWordID - 1);
		var effectColor = ds_grid_get(wordDrawGrid, wordDrawGrid_colEffectColor, currentWordID - 1);
	
	
		// draw fill rectangle if needed
		if (drawFillRect) {
			draw_set_color(effectColor);
			draw_set_alpha(0.25);
			draw_rectangle(wordRectX1, wordRectY1, wordRectX2, wordRectY2, false);
			draw_set_alpha(1);
		}
	
		// draw border if needed
		if (drawBorder) {
			var borderRounded = ds_grid_get(wordDrawGrid, wordDrawGrid_colBorderRounded, currentWordID - 1);
			draw_set_color(effectColor);
		
			for (var drawBorderLoop = 0; drawBorderLoop < 2; drawBorderLoop++) {
				if (borderRounded) {
					draw_roundrect(wordRectX1 - drawBorderLoop, wordRectY1 - drawBorderLoop, wordRectX2 + drawBorderLoop, wordRectY2 + drawBorderLoop, true);
				}
			
				/*else {
					draw_rectangle(wordRectX1 - drawBorderLoop, wordRectY1 - drawBorderLoop, wordRectX2 + drawBorderLoop, wordRectY2 + drawBorderLoop, true);
				}*/
			
			}
		}

		if (drawFocused) {
			draw_sprite_ext(spr_focusPoint, 0, wordRectX1 - wordDrawGridFocusedAnimation, wordRectY1 - wordDrawGridFocusedAnimation, 1, 1, 0, effectColor, 1);
			draw_sprite_ext(spr_focusPoint, 0, wordRectX2 + wordDrawGridFocusedAnimation, wordRectY1 - wordDrawGridFocusedAnimation, 1, 1, 0, effectColor, 1);
			draw_sprite_ext(spr_focusPoint, 0, wordRectX1 - wordDrawGridFocusedAnimation, wordRectY2 + wordDrawGridFocusedAnimation, 1, 1, 0, effectColor, 1);
			draw_sprite_ext(spr_focusPoint, 0, wordRectX2 + wordDrawGridFocusedAnimation, wordRectY2 + wordDrawGridFocusedAnimation, 1, 1, 0, effectColor, 1);
		}
	
	
		ds_grid_set(wordDrawGrid, wordDrawGrid_colVisible, currentWordID - 1, true);
	
		draw_set_alpha(1);
		draw_set_font(global.fontMain);
		draw_set_color(global.colorThemeText);
		if (ds_grid_get(obj_control.hitGrid, obj_control.hitGrid_colHitBool, currentHitID - 1)) {
			draw_set_font(global.fontMainBold);
			draw_set_color(make_color_rgb(19,69,150));
		}
		draw_set_halign(fa_left);
		draw_set_valign(fa_middle);
		draw_text(floor(currentWordX), floor(currentLineY), currentWordString);
		
		previousWordDisplayCol = currentWordDisplayCol;
	}


}
