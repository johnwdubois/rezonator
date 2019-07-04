/*
	scr_drawLineWordIDListLoop(wordIDList, previousWordDisplayCol, currentLineY, drawLineLoop, unitID);
	
	Last Updated: 2019-02-11
	
	Called from: obj_control
	
	Purpose: draws words to main screen, using wordIDs from the given wordIDList
	
	Mechanism: loop through wordIDList to get wordIDs, look up their display info in wordGrid & dynaWordGrid
	
	Author: Terry DuBois
*/

var currentWordIDList = argument0;
var previousWordDisplayCol = argument1;
var currentLineY = argument2;
var drawLineLoop = argument3;
var unitID = argument4;

var shapeTextX = wordLeftMargin;
var shapeTextSpace = 12;

var voidMax = 0;
var voidSum = 0;

// get each wordID from wordIDList and draw it
for (var drawWordLoop = 0; drawWordLoop < ds_list_size(currentWordIDList); drawWordLoop++) {
	var shake = false;
	var currentWordID = ds_list_find_value(currentWordIDList, drawWordLoop);
	var currentWordGridRow = currentWordID - 1;
	var currentWordState = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colWordState, currentWordGridRow);
	
	// Check if the word is a ChunkWord
	if(currentWordState == obj_control.wordStateChunk) {
		
		
		// Here will be functionality to focus on a Chunk and add it to a Chain
		// This includes: Hovering over Chunk will visually effect the outline
		// The big step is adding it to a chain, which will involve a major rework of most of this existing code
		
		draw_set_font(fnt_main);

		
		
		// Aquire the Chunk's row in the Chunk grid (this is currently too expensive)
		var inChunkList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInBoxList, currentWordGridRow);
		if(ds_list_size(inChunkList) < 1) {
			continue;
		}
		
		var currentChunkID = (ds_list_find_value(inChunkList, 0)); //ds_grid_value_y(obj_chain.chunkGrid, obj_chain.chainGrid_colName, 0, obj_chain.chainGrid_colName, ds_grid_height(obj_chain.chunkGrid), currentWordID);
		if(currentChunkID == undefined) {
			continue;
		}
		var currentChunkRow = ds_grid_value_y(obj_chain.chunkGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.chunkGrid), currentChunkID);
		if(currentChunkRow < 0) {
			continue;	
		}

		// Grab the Chunk's list of contained words
		var currentWordList = ds_grid_get(obj_chain.chunkGrid, obj_chain.chunkGrid_colBoxWordIDList, currentChunkRow);
		
		// Safety Check
		if(currentWordList == undefined || ds_list_size(currentWordList) < 1) {
				continue;
		}
		
		// Set all variables needed to draw a Chunk
		var topLeftX = undefined;
		var topLeftY = undefined;
		
		var bottomRightX = undefined;
		var bottomRightY = undefined;

		var firstWordID = -1;
		var lastWordID = -1;
		
		// Get the first and last word within the Chunk
		firstWordID = ds_list_find_value(currentWordList, 0);
		lastWordID = ds_list_find_value(currentWordList, ds_list_size(currentWordList)-1);
		
		// Set the Buffer to be initially large, so as to allow for nesting
		var wordRectBuffer = 6;
		if(ds_grid_get(obj_chain.chunkGrid, obj_chain.chunkGrid_colNest, currentChunkRow) == true) {
			wordRectBuffer = 4;
		}
		
		// Set up the measurements for the drawn box
		//displayLineY = ds_grid_get(obj_control.currentActiveLineGrid, obj_control.lineGrid_colPixelY, currentDisplayRow);
		var leftPixelX = min(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, firstWordID - 1), ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, currentWordID - 1));
		//var rightPixelX = max(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, lastWordID - 1), ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, currentWordID - 1));
		var rightPixelX = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, lastWordID - 1);
		ds_grid_set(dynamicWordGrid, dynamicWordGrid_colPixelX, currentWordGridRow, leftPixelX);
		
		
		// Get the string of the first word
		var firstWordString = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, firstWordID - 1);
		// Get the string of the last word
		var lastWordString = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, lastWordID - 1);
		
		topLeftX = leftPixelX - wordRectBuffer;
		topLeftY = currentLineY - (string_height(firstWordString) / 2) - wordRectBuffer;
		
		bottomRightX = rightPixelX + string_width(lastWordString) + (wordRectBuffer * 2);
		bottomRightY = topLeftY + string_height(firstWordString) + (wordRectBuffer * 2);
		
		var effectColor = ds_grid_get(wordDrawGrid, wordDrawGrid_colEffectColor, currentWordID - 1);//global.colorThemeSelected1
		var drawFocused = ds_grid_get(wordDrawGrid, wordDrawGrid_colFocused, currentWordID - 1);
		var borderRounded = ds_grid_get(wordDrawGrid, wordDrawGrid_colBorderRounded, currentWordID - 1);
		
		// Draw the Chunks visual representation
		if(ds_list_size(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInChainList, currentWordGridRow)) > 0) {
			draw_set_color(effectColor);
		} else {
			draw_set_color(global.colorThemeSelected1);	
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
		
		// Check for mouseover of the Chunk (clicks coming soon)
		var mouseover = false;
		if (point_in_rectangle(mouse_x, mouse_y, topLeftX, topLeftY, bottomRightX, bottomRightY) and not (obj_toolPane.currentTool == obj_toolPane.toolNewWord) and not obj_chain.inRezPlay
		and not mouseoverPanelPane and (hoverChunkID == currentWordID || hoverChunkID == -1) and hoverWordID == -1) {
			mouseover = true;
			
			// May need to make a hoverChunkID
			hoverChunkID = currentWordID;
		
			// Draw the hover highlight
			draw_set_color(global.colorThemeSelected1);
			draw_set_alpha(0.5);
			draw_rectangle(topLeftX, topLeftY, bottomRightX, bottomRightY, false);
			
			if (mouse_check_button_pressed(mb_left)) {
				obj_control.clickedChunkID = currentChunkID; // Debug variable
				// Add this Chunk to a chain
				with (obj_chain) {
					scr_wordClicked(currentWordID, unitID);
				}
			}
		}
		
		continue;	
	}
	
	// Draw a word normally
	
	var currentWordDisplayCol = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayCol, currentWordGridRow);
	
	// using the previous word's display column, set the current word's void
	var currentWordVoid = 0;
	if (drawWordLoop > 0) {
		currentWordVoid = abs(currentWordDisplayCol - (previousWordDisplayCol + 1));
		ds_grid_set(dynamicWordGrid, dynamicWordGrid_colVoid, currentWordGridRow, currentWordVoid);
		
		 
		if (currentWordDisplayCol - previousWordDisplayCol > 1) {
			//show_message("IN HERE currentWordDisplayCol: " + string(currentWordDisplayCol) + " - " + string(previousWordDisplayCol) + " = " + string(currentWordDisplayCol - previousWordDisplayCol));
			if (not ds_grid_get(wordDrawGrid, wordDrawGrid_colBorder, currentWordGridRow)
			and not ds_grid_get(wordDrawGrid, wordDrawGrid_colBorderRounded, currentWordGridRow)) {
				ds_grid_set(dynamicWordGrid, dynamicWordGrid_colDisplayCol, currentWordGridRow, currentWordDisplayCol - 1);
			}
			
		}
		
		currentWordDisplayCol = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayCol, currentWordGridRow);
		

		// keep track of the most recently linked word to make sure that it doesn't move more than once (to solve race-to-infinity)
		if (previousWordDisplayCol >= currentWordDisplayCol) {
			if (currentWordID == obj_control.mostRecentlyAddedWord and not obj_control.mostRecentlyAddedWordMoved) {
				obj_control.mostRecentlyAddedWordMoved = true;
				if (not obj_control.alarmRecentlyAddedWordMovedTriggered) {
					obj_control.alarmRecentlyAddedWordMovedTriggered = true;
					with (obj_control) {
						alarm[2] = 5;
					}
				}
			}
			
			if (currentWordID == obj_control.mostRecentlyAddedWord and obj_control.mostRecentlyAddedWordMoved) {
				ds_grid_set(dynamicWordGrid, dynamicWordGrid_colAligned, currentWordGridRow, false);
				ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colStretch, currentWordID - 1, true);
			}
			
			currentWordDisplayCol++;
			ds_grid_set(dynamicWordGrid, dynamicWordGrid_colDisplayCol, currentWordGridRow, currentWordDisplayCol);
		}
		
	}
	else {
		// if the current word is the first word of the line, and it is floating out in space for no reason, bring it back to the left
		ds_grid_set(dynamicWordGrid, dynamicWordGrid_colVoid, currentWordGridRow, abs(currentWordDisplayCol));
		
		if (not ds_grid_get(wordDrawGrid, wordDrawGrid_colBorder, currentWordGridRow)
		and not ds_grid_get(wordDrawGrid, wordDrawGrid_colBorderRounded, currentWordGridRow)
		and abs(currentWordDisplayCol) > 0) {
			ds_grid_set(dynamicWordGrid, dynamicWordGrid_colDisplayCol, currentWordGridRow, currentWordDisplayCol - 1);
		}
	}
	currentWordVoid = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colVoid, currentWordGridRow);
	voidSum += currentWordVoid;
	voidMax = max(voidMax, currentWordVoid);
	
	// if showing developer variables, draw rectangle to visualize voids
	if ((obj_control.showDevVars and currentWordVoid > 0) or currentWordVoid > 17) {
		if (drawWordLoop > 0) {
			var voidRectX1 = ((previousWordDisplayCol + 1) * obj_control.gridSpaceHorizontal) + wordLeftMargin;
		}
		else {
			var voidRectX1 = 0;
		}
		var voidRectY1 = currentLineY - 10;
		var voidRectX2 = (currentWordDisplayCol * obj_control.gridSpaceHorizontal) + wordLeftMargin;
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
	
	// if the previous word is on top of the current word, push the current word out by one column
	currentWordDisplayCol = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayCol, currentWordGridRow);
	if (previousWordDisplayCol >= currentWordDisplayCol) {
		//show_message("in here!");
		//show_message("currentWordID: " + string(currentWordID) + "... pWDC: " + string(previousWordDisplayCol) + " >= cWDC: " + string(currentWordDisplayCol));
		currentWordDisplayCol++;
		ds_grid_set(dynamicWordGrid, dynamicWordGrid_colDisplayCol, currentWordGridRow, currentWordDisplayCol);
		//show_message("now cWDC: " + string(currentWordDisplayCol));
	}
	
	// horizontally move this word to its desired x-pixel value
	var currentWordDestX = currentWordDisplayCol * gridSpaceHorizontal + wordLeftMargin;
	if (shape == shapeText) {
		currentWordDestX = shapeTextX;
	}
	
	var currentWordX = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colPixelX, currentWordGridRow);
	obj_control.leftScreenBound = min(currentWordX, obj_control.leftScreenBound);
		
	if (currentWordX < currentWordDestX) {
		currentWordX += abs(currentWordX - currentWordDestX) / 4;
	}
	else if (currentWordX > currentWordDestX) {
		currentWordX -= abs(currentWordX - currentWordDestX) / 4;
	}
		
	ds_grid_set(dynamicWordGrid, dynamicWordGrid_colPixelX, currentWordGridRow, currentWordX);
	ds_grid_set(dynamicWordGrid, dynamicWordGrid_colDisplayWordSeq, currentWordGridRow, drawWordLoop);
		
	// get the string of this word to draw to the main screen
	var currentWordString = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayString, currentWordGridRow);
		
	var wordRectBuffer = 2;
	var wordRectX1 = currentWordX - wordRectBuffer;
	var wordRectY1 = currentLineY - (string_height(currentWordString) / 2) - wordRectBuffer;
	var wordRectX2 = wordRectX1 + string_width(currentWordString) + (wordRectBuffer * 2);
	var wordRectY2 = wordRectY1 + string_height(currentWordString) + (wordRectBuffer * 2);
	
	
	var inMouseHoldRect = 0;
	if (mouse_check_button(mb_left) and obj_toolPane.currentTool == obj_toolPane.toolRezBrush) {
		inMouseHoldRect = rectangle_in_rectangle(wordRectX1, wordRectY1, wordRectX1 + obj_control.gridSpaceHorizontal, wordRectY2, min(mouseHoldRectX1, mouseHoldRectX2), min(mouseHoldRectY1, mouseHoldRectY2), max(mouseHoldRectX1, mouseHoldRectX2), max(mouseHoldRectY1, mouseHoldRectY2));
		if (inMouseHoldRect > 0) {
			if (not ds_grid_get(wordDrawGrid, wordDrawGrid_colBorder, currentWordID - 1)) {
				ds_grid_set(wordDrawGrid, wordDrawGrid_colBorder, currentWordID - 1, 2);
				
			}
		}
		else {
			if (ds_grid_get(wordDrawGrid, wordDrawGrid_colBorder, currentWordID - 1) == 2) {
				ds_grid_set(wordDrawGrid, wordDrawGrid_colBorder, currentWordID - 1, false);
			}
		}
	}
	else {
		if (ds_grid_get(wordDrawGrid, wordDrawGrid_colBorder, currentWordID - 1) == 2) {
			ds_grid_set(wordDrawGrid, wordDrawGrid_colBorder, currentWordID - 1, false);
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
			else {
				draw_rectangle(wordRectX1 - drawBorderLoop, wordRectY1 - drawBorderLoop, wordRectX2 + drawBorderLoop, wordRectY2 + drawBorderLoop, true);
			}
		}
	}
	
	if (drawFocused) {
		draw_sprite_ext(spr_focusPoint, 0, wordRectX1 - wordDrawGridFocusedAnimation, wordRectY1 - wordDrawGridFocusedAnimation, 1, 1, 0, effectColor, 1);
		draw_sprite_ext(spr_focusPoint, 0, wordRectX2 + wordDrawGridFocusedAnimation, wordRectY1 - wordDrawGridFocusedAnimation, 1, 1, 0, effectColor, 1);
		draw_sprite_ext(spr_focusPoint, 0, wordRectX1 - wordDrawGridFocusedAnimation, wordRectY2 + wordDrawGridFocusedAnimation, 1, 1, 0, effectColor, 1);
		draw_sprite_ext(spr_focusPoint, 0, wordRectX2 + wordDrawGridFocusedAnimation, wordRectY2 + wordDrawGridFocusedAnimation, 1, 1, 0, effectColor, 1);
	}
	
	if (!obj_chain.inRezPlay) {
	
		// figure out if the user has their mouse hovering over this word, and if so, are they clicking?
		var mouseover = false;
		if (point_in_rectangle(mouse_x, mouse_y, wordRectX1, wordRectY1, wordRectX2, wordRectY2) and not (obj_toolPane.currentTool == obj_toolPane.toolNewWord) and not obj_chain.inRezPlay
		and not mouseoverPanelPane and (hoverWordID == currentWordID || hoverWordID == -1)) {
			mouseover = true;
			hoverWordID = currentWordID;
		
			draw_set_color(global.colorThemeBorders);
			draw_set_alpha(1);
			draw_rectangle(wordRectX1, wordRectY1, wordRectX2, wordRectY2, true);
			
			if (mouse_check_button_pressed(mb_left)) {
				with (obj_chain) {
					scr_wordClicked(currentWordID, unitID);
				}
			}
		}
		/*else if for Chunks???{
			
		}
		*/
		// Allows for adding to a stack anywhere in a line
		else if(point_in_rectangle(mouse_x, mouse_y, 0, wordRectY1, room_width, wordRectY2) and (obj_toolPane.currentTool == obj_toolPane.toolStackBrush)) {
			if (mouse_check_button_pressed(mb_left) and !obj_chain.inRezPlay) {
				with (obj_chain) {
					scr_wordClicked(currentWordID, unitID);
				}
			}
		}
	
		// If the mouse is dragged, record all the words that fit into the rectangle in order to quickStack them.
	
		if ((obj_toolPane.currentTool == obj_toolPane.toolRezBrush) and mouseRectMade) {
			inMouseHoldRect = rectangle_in_rectangle(wordRectX1, wordRectY1, wordRectX1 + obj_control.gridSpaceHorizontal, wordRectY2, min(mouseHoldRectX1, mouseHoldRectX2), min(mouseHoldRectY1, mouseHoldRectY2), max(mouseHoldRectX1, mouseHoldRectX2), max(mouseHoldRectY1, mouseHoldRectY2));
			if (inMouseHoldRect) {
				with (obj_control) {
					if (ds_list_find_index(inRectWordIDList, currentWordID) < 0) {
						//show_message("ghost?");
						ds_list_add(inRectWordIDList, currentWordID);
					}
				}
			}
		}
		else if ((obj_toolPane.currentTool == obj_toolPane.toolStackBrush) and mouseRectMade) {
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
	
	
		// Check to see if this word is within the Box brush rectangle
		with (obj_control) {
		var inBoxHoldRect = rectangle_in_rectangle(wordRectX1, wordRectY1, wordRectX1 + gridSpaceHorizontal, wordRectY1 + gridSpaceVertical, min(boxHoldRectX1, boxHoldRectX2), min(boxHoldRectY1, boxHoldRectY2), max(boxHoldRectX1, boxHoldRectX2), max(boxHoldRectY1, boxHoldRectY2));
		}
		// Make sure the user has the box brush selected
		if(obj_toolPane.currentTool == obj_toolPane.toolBoxBrush) {
			// Highlight the words if the box is still being made
			if(not obj_control.boxRectReleased and inBoxHoldRect > 0) {
				// Draw the highlights within the display columns
				draw_set_color(global.colorThemeSelected1);
				draw_set_alpha(0.5);
				draw_rectangle(wordRectX1, wordRectY1, wordRectX1 + obj_control.gridSpaceHorizontal, wordRectY2, false);
			} 
			// If the box has been made, capture the info of the contained words
			else if(obj_control.boxRectMade and inBoxHoldRect > 0) {
				// Make sure this word has not already been captured
				with (obj_control) {
					if (ds_list_find_index(inRectWordIDList, currentWordID) == -1) {
						// Add the word info to the rectangle lists
						ds_list_add(inRectUnitIDList, unitID);
						ds_list_add(inRectWordIDList, currentWordID);
					}
				}
			}
		}
	
		// If the user has the New-Word tool selected, create a new word right next to this word
		if (obj_toolPane.currentTool == obj_toolPane.toolNewWord) {
			if (newWordHoverUnitID == unitID and newWordHoverWordSeq == ds_grid_get(wordGrid, wordGrid_colWordSeq, currentWordID - 1) and newWordHoverWordID == currentWordID) {
				draw_set_color(c_ltblue);
				draw_line_width(wordRectX2, wordRectY1, wordRectX2, wordRectY2, 2);
			}
		
			if (point_in_rectangle(mouse_x, mouse_y, wordRectX2, wordRectY1, wordRectX2 + gridSpaceHorizontal, wordRectY2)) {
				newWordHoverUnitID = unitID;
				newWordHoverWordSeq = ds_grid_get(wordGrid, wordGrid_colWordSeq, currentWordID - 1);
				newWordHoverWordID = currentWordID;
			
				if (mouse_check_button_pressed(mb_left)) {
					scr_newWord(newWordHoverUnitID, newWordHoverWordSeq);
				}
			}

		}
	}
	
	ds_grid_set(wordDrawGrid, wordDrawGrid_colVisible, currentWordID - 1, true);
	
	//var textColor = ds_grid_get(wordDrawGrid, wordDrawGrid_colTextColor, currentWordID - 1);
	var textColor = global.colorThemeText;
		
	// finally, draw the word to the main view
	draw_set_alpha(1);
	draw_set_font(global.fontMain);
	draw_set_color(textColor);
	var rowInHitGrid = ds_grid_value_y(obj_control.hitGrid, obj_control.hitGrid_colWordID, 0, obj_control.hitGrid_colWordID, ds_grid_height(obj_control.hitGrid), currentWordID );
	if ( rowInHitGrid >= 0 ) {
		if (ds_grid_get(obj_control.hitGrid, obj_control.hitGrid_colHitBool, rowInHitGrid)) {
			draw_set_font(global.fontMainBold);
			draw_set_color(make_color_rgb(19,69,150));		
		}
	}
	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	draw_text(currentWordX, currentLineY, currentWordString);
	
	previousWordDisplayCol = currentWordDisplayCol;
	
	shapeTextX += string_width(currentWordString) + shapeTextSpace;
}

// set total void values for this line, now that we have gone through every word in the line
ds_grid_set(currentActiveLineGrid, obj_control.lineGrid_colVoidMax, drawLineLoop, voidMax);
ds_grid_set(currentActiveLineGrid, obj_control.lineGrid_colVoidSum, drawLineLoop, voidSum);