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
	var drawBorder = ds_grid_get(wordDrawGrid, wordDrawGrid_colBorder, currentWordGridRow);
	var borderRounded = ds_grid_get(wordDrawGrid, wordDrawGrid_colBorderRounded, currentWordGridRow);
	
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
		
		if (not drawBorder and not borderRounded and abs(currentWordDisplayCol) > 0) {
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
			if (not drawBorder) {
				ds_grid_set(wordDrawGrid, wordDrawGrid_colBorder, currentWordID - 1, 2);
				
			}
		}
		else {
			if (drawBorder == 2) {
				ds_grid_set(wordDrawGrid, wordDrawGrid_colBorder, currentWordID - 1, false);
			}
		}
	}
	else {
		if (drawBorder == 2) {
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
		scr_drawPlaceChains(wordRectX1, wordRectY1, wordRectX2, wordRectY2, drawWordLoop, currentWordIDListSize, currentWordGridRow,currentWordDisplayCol);
	}
	
	
	// figure out whether or not to draw fill/border for this word
	var drawFillRect = ds_grid_get(wordDrawGrid, wordDrawGrid_colFillRect, currentWordGridRow);
	//var drawBorder = ds_grid_get(wordDrawGrid, wordDrawGrid_colBorder, currentWordGridRow);
	var drawFocused = ds_grid_get(wordDrawGrid, wordDrawGrid_colFocused, currentWordGridRow);
	var effectColor = ds_grid_get(wordDrawGrid, wordDrawGrid_colEffectColor, currentWordGridRow);
	if(obj_control.stackShowActive) {
		var drawGoldStandard = (ds_grid_get(dynamicWordGrid, dynamicWordGrid_colWordState, currentWordGridRow) == obj_control.wordStateGold);
		var drawIncorrect = (ds_grid_get(dynamicWordGrid, dynamicWordGrid_colWordState, currentWordGridRow) == obj_control.wordStateRed);
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
	}
	
	scr_drawWordBorder(drawBorder, drawFillRect, drawFocused, effectColor, wordRectX1, wordRectY1, wordRectX2, wordRectY2, borderRounded, fontScale);
	
	var panelPaneResizeHeld = false;

	with(obj_panelPane) {
		if(windowResizeYHolding) {
			panelPaneResizeHeld = true;
		}
	}
	
	
	
	
	if (!obj_chain.inRezPlay and (mouse_y > wordRectY1 and mouse_y < wordRectY2)) {
		scr_mouseTime(currentWordID, wordRectX1, wordRectY1, wordRectX2, wordRectY2, unitID, drawWordLoop, currentWordIDListSize, panelPaneResizeHeld);
	}
	
	scr_drawWord(currentWordGridRow, currentWordID, currentWordX, currentLineY, currentWordString);

	previousWordDisplayCol = currentWordDisplayCol;
	previousWordDisplayString = currentWordString;
	
	shapeTextX += currentWordStringWidth + shapeTextSpace;
}



// set total void values for this line, now that we have gone through every word in the line
ds_grid_set(currentActiveLineGrid, obj_control.lineGrid_colVoidMax, drawLineLoop, voidMax);
ds_grid_set(currentActiveLineGrid, obj_control.lineGrid_colVoidSum, drawLineLoop, voidSum);