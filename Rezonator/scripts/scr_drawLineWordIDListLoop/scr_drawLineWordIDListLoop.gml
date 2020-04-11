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

var currentWordIDListSize = ds_list_size(currentWordIDList);
var shapeTextX = wordLeftMargin;
var shapeTextSpace = 12;

var voidMax = 0;
var voidSum = 0;

var previousWordDisplayString = "0";



draw_set_font(fnt_main);
var strHeightRegular = string_height("A");
draw_set_font(global.fontMain);
var strHeightScaled = string_height("A");
var fontScale = strHeightScaled / strHeightRegular;
var currentPlaceChainColor = global.colorThemeText;

// get each wordID from wordIDList and draw it
for (var drawWordLoop = 0; drawWordLoop < currentWordIDListSize; drawWordLoop++) {
	var shake = false;
	var currentWordID = ds_list_find_value(currentWordIDList, drawWordLoop);
	var currentWordGridRow = currentWordID - 1;
	var currentWordState = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colWordState, currentWordGridRow);
	var currentWordInChainsList = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colInChainList, currentWordGridRow);
	
	for (var i = 0; i < ds_list_size(currentWordInChainsList); i++) {
		if (ds_list_find_index(obj_chain.chainShowList, ds_list_find_value(currentWordInChainsList, i)) == -1) {
			ds_list_add(obj_chain.chainShowList, ds_list_find_value(currentWordInChainsList, i));
		}
	}
	
	if(currentWordState == obj_control.wordStateDead) {
		
		continue;
	}
	
	// Check if the word is a ChunkWord
	if(currentWordState == obj_control.wordStateChunk) {
		
		scr_drawChunk(currentWordID);
		
		continue;	
	}
	
	// Draw a word normally
	var currentWordDisplayCol = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayCol, currentWordGridRow);
	//var currentWordDisplayString = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayString, currentWordGridRow);
	
	// using the previous word's display column, set the current word's void
	var currentWordVoid = 0;
	if (drawWordLoop > 0) {
		currentWordDisplayCol = scr_wordVoid(currentWordDisplayCol, previousWordDisplayCol, currentWordGridRow, currentWordID);
		
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
	if ((obj_control.showDevVars and currentWordVoid > 0)) {// or currentWordVoid > 17) { // Do we want to always be showing this?
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
		currentWordDisplayCol++;
		ds_grid_set(dynamicWordGrid, dynamicWordGrid_colDisplayCol, currentWordGridRow, currentWordDisplayCol);
	}
	
	// horizontally move this word to its desired x-pixel value
	var currentWordDestX = currentWordDisplayCol * gridSpaceHorizontal + wordLeftMargin;
	if (shape == shapeText) {
		currentWordDestX = shapeTextX;
	}
	
	var currentWordX = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colPixelX, currentWordGridRow);
	if (typeof(currentWordX) == "string") {
		currentWordX = 0;
	}
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
	var currentWordStringType = string(currentWordString);
	var currentWordStringWidth = string_width(currentWordStringType);
	var currentWordStringHeight = string_height(currentWordStringType);
	
		
	var wordRectBuffer = 3;
	var wordRectX1 = currentWordX - wordRectBuffer;
	var wordRectY1 = currentLineY - (currentWordStringHeight / 2) - wordRectBuffer;
	var wordRectX2 = wordRectX1 + currentWordStringWidth + (wordRectBuffer * 2);
	var wordRectY2 = wordRectY1 + currentWordStringHeight + (wordRectBuffer * 2);
	
	
	var inMouseHoldRect = 0;
	if (mouse_check_button(mb_left) and (obj_toolPane.currentTool == obj_toolPane.toolRezBrush or obj_toolPane.currentTool == obj_toolPane.toolTrackBrush)) {
		if(obj_control.mouseRectWithinLine) {
			inMouseHoldRect = rectangle_in_rectangle(wordRectX1, wordRectY1, wordRectX2, wordRectY2, min(mouseHoldRectX1, mouseHoldRectX2), min(mouseHoldRectY1, mouseHoldRectY2), max(mouseHoldRectX1, mouseHoldRectX2), max(mouseHoldRectY1, mouseHoldRectY2));
		}
		else if (obj_control.mouseRectBeginBetweenWords == -1 and not obj_control.mouseRectWithinLine and not (obj_toolPane.currentTool == obj_toolPane.toolTrackBrush and not searchGridActive)) {
			inMouseHoldRect = rectangle_in_rectangle(wordRectX1, wordRectY1, wordRectX1 + obj_control.gridSpaceHorizontal - 20, wordRectY2, min(mouseHoldRectX1, mouseHoldRectX2), min(mouseHoldRectY1, mouseHoldRectY2), max(mouseHoldRectX1, mouseHoldRectX2), max(mouseHoldRectY1, mouseHoldRectY2));
		}
		else {
			inMouseHoldRect = 0;
		}
		 
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
	
	// Place Chains Prototype
	var wordHasLetters = string_length(string_letters(currentWordStringType)) > 0;
	// Draw Place chains when needed
	if(obj_chain.showPlaceChains && drawWordLoop != currentWordIDListSize - 1 && wordHasLetters) {
		// Draw the Place chain box
		draw_set_alpha(1);
		draw_set_color(c_ltgray);
		//draw_rectangle(wordRectX1 - 1, wordRectY1 - 1, wordRectX2 + 1, wordRectY2 + 1, true);
		var wordMidY = (wordRectY2 - wordRectY1)/2 + wordRectY1;
		var placeChainYSpacing = 2;
		
		// Go through the rest of the line to find a word this one can link to
		for(var loopRow = drawWordLoop + 1; loopRow < currentWordIDListSize - 1; loopRow++) {
		
			// Draw the double bond if the next token is a word
			var nextWordString = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayString, currentWordGridRow + (loopRow - drawWordLoop));
			//draw_rectangle(wordRectX1 - 1, wordRectY1 - 1, wordRectX2 + 1, wordRectY2 + 1, true);
	
			if(string_length(string_letters(nextWordString)) > 0 or undefined) {
				// Based off of the prev word's x-pos, draw 2 lines
				if (shape != shapeText) {
					// Allow the PlaceChain lines to adapt to shifting display columns
					var nextWordDisplayCol = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayCol, currentWordGridRow + (loopRow - drawWordLoop));
					var variance = (abs(nextWordDisplayCol - currentWordDisplayCol) * gridSpaceHorizontal);
					draw_line_width(wordRectX2, wordMidY + placeChainYSpacing, wordRectX1 + variance, wordMidY + placeChainYSpacing, 2);
					draw_line_width(wordRectX2, wordMidY - placeChainYSpacing, wordRectX1 + variance, wordMidY - placeChainYSpacing, 2); 
				}										   
				else {									   
					draw_line_width(wordRectX2, wordMidY + placeChainYSpacing, wordRectX2 + 8, wordMidY + placeChainYSpacing, 2);
					draw_line_width(wordRectX2, wordMidY - placeChainYSpacing, wordRectX2 + 8, wordMidY - placeChainYSpacing, 2); 
				}
				break;
			}
		}
	}
	
	// figure out whether or not to draw fill/border for this word
	var drawFillRect = ds_grid_get(wordDrawGrid, wordDrawGrid_colFillRect, currentWordID - 1);
	var drawBorder = ds_grid_get(wordDrawGrid, wordDrawGrid_colBorder, currentWordID - 1);
	var drawFocused = ds_grid_get(wordDrawGrid, wordDrawGrid_colFocused, currentWordID - 1);
	var effectColor = ds_grid_get(wordDrawGrid, wordDrawGrid_colEffectColor, currentWordID - 1);
	var drawGoldStandard = (ds_grid_get(dynamicWordGrid, dynamicWordGrid_colWordState, currentWordID - 1) == obj_control.wordStateGold);
	var drawIncorrect = (ds_grid_get(dynamicWordGrid, dynamicWordGrid_colWordState, currentWordID - 1) == obj_control.wordStateRed);
	
	// draw fill rectangle if needed
	if (drawFillRect) {
		draw_set_color(effectColor);
		draw_set_alpha(0.25);
		draw_rectangle(wordRectX1, wordRectY1, wordRectX2, wordRectY2, false);
		draw_set_alpha(1);
	}
	
	if (drawGoldStandard) {
		draw_set_color(c_green);
		draw_set_alpha(0.4);
		draw_rectangle(wordRectX1, wordRectY1, wordRectX2, wordRectY2, false);
		draw_set_alpha(1);
	}
	
	if (drawIncorrect) {
		draw_set_color(c_red);
		draw_set_alpha(0.4);
		draw_rectangle(wordRectX1, wordRectY1, wordRectX2, wordRectY2, false);
		draw_set_alpha(1);
	}
	
	
	// draw border if needed
	var borderRounded = false;
	if (drawBorder) {
		borderRounded = ds_grid_get(wordDrawGrid, wordDrawGrid_colBorderRounded, currentWordID - 1);
		if (effectColor == undefined){
		effectColor = 16758711;
		}
		draw_set_color(effectColor);
		
		for (var drawBorderLoop = 0; drawBorderLoop < 2; drawBorderLoop++) {
			if (borderRounded) {
				if (obj_chain.toggleDrawTrack) {
					draw_roundrect(wordRectX1 - drawBorderLoop, wordRectY1 - drawBorderLoop, wordRectX2 + drawBorderLoop, wordRectY2 + drawBorderLoop, true);
				}
			}
			else {
				if (obj_chain.toggleDrawRez) {
					draw_rectangle(wordRectX1 - drawBorderLoop, wordRectY1 - drawBorderLoop, wordRectX2 + drawBorderLoop, wordRectY2 + drawBorderLoop, true);
				}
			}
		}
	}
	
	if (drawFocused) {
		if ((not borderRounded and obj_chain.toggleDrawRez) or (borderRounded and obj_chain.toggleDrawTrack)) {
			draw_set_font(global.fontMain);
			draw_sprite_ext(spr_focusPoint, 0, wordRectX1 - wordDrawGridFocusedAnimation, wordRectY1 - wordDrawGridFocusedAnimation, fontScale, fontScale, 0, effectColor, 1);
			draw_sprite_ext(spr_focusPoint, 0, wordRectX2 + wordDrawGridFocusedAnimation, wordRectY1 - wordDrawGridFocusedAnimation, fontScale, fontScale, 0, effectColor, 1);
			draw_sprite_ext(spr_focusPoint, 0, wordRectX1 - wordDrawGridFocusedAnimation, wordRectY2 + wordDrawGridFocusedAnimation, fontScale, fontScale, 0, effectColor, 1);
			draw_sprite_ext(spr_focusPoint, 0, wordRectX2 + wordDrawGridFocusedAnimation, wordRectY2 + wordDrawGridFocusedAnimation, fontScale, fontScale, 0, effectColor, 1);
		}
	}
	var panelPaneResizeHeld = false;

	with(obj_panelPane) {
		if(windowResizeYHolding) {
			panelPaneResizeHeld = true;
		}
	}
	
	
	
	
	if (!obj_chain.inRezPlay) {
		scr_mouseTime(currentWordID, wordRectX1, wordRectY1, wordRectX2, wordRectY2, unitID, drawWordLoop, currentWordIDListSize, panelPaneResizeHeld);
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
	draw_text(floor(currentWordX), floor(currentLineY), currentWordString);
	
	previousWordDisplayCol = currentWordDisplayCol;
	previousWordDisplayString = currentWordString;
	
	shapeTextX += currentWordStringWidth + shapeTextSpace;
}



// set total void values for this line, now that we have gone through every word in the line
ds_grid_set(currentActiveLineGrid, obj_control.lineGrid_colVoidMax, drawLineLoop, voidMax);
ds_grid_set(currentActiveLineGrid, obj_control.lineGrid_colVoidSum, drawLineLoop, voidSum);