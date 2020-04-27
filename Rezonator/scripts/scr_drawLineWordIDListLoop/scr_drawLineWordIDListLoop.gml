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
//var currentPlaceChainColor = global.colorThemeText;

var panelPaneResizeHeld = false;

with(obj_panelPane) {
	if(windowResizeYHolding) {
		panelPaneResizeHeld = true;
	}
}

var chainShowList = obj_chain.chainShowList;
var wordStateDead = obj_control.wordStateDead;
var wordStateChunk = obj_control.wordStateChunk;
var wordStateNormal = obj_control.wordStateNormal;
var gridSpaceHorizontal = obj_control.gridSpaceHorizontal;
var showPlaceChains = obj_chain.showPlaceChains;
var stackShowActive = obj_control.stackShowActive;
var showDevVars = obj_control.showDevVars;
var leftScreenBound = obj_control.leftScreenBound;
var currentTool = obj_toolPane.currentTool;
var toolRezBrush = obj_toolPane.toolRezBrush;
var toolTrackBrush = obj_toolPane.toolTrackBrush;
var mouseRectWithinLine = obj_control.mouseRectWithinLine;
var mouseRectBeginBetweenWords = obj_control.mouseRectBeginBetweenWords;
var colorThemeBG = global.colorThemeBG;
var inRezPlay = obj_chain.inRezPlay;
var hitGridHeight = ds_grid_height(obj_control.hitGrid);

// get each wordID from wordIDList and draw it
var drawWordLoop = 0;
repeat (currentWordIDListSize) {
//for (var drawWordLoop = 0; drawWordLoop < currentWordIDListSize; drawWordLoop++) {
	//var shake = false;
	var currentWordID = ds_list_find_value(currentWordIDList, drawWordLoop);
	var currentWordGridRow = currentWordID - 1;

	var currentWordState = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colWordState, currentWordGridRow);
	var currentWordInChainsList = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colInChainList, currentWordGridRow);
	var drawBorder = ds_grid_get(wordDrawGrid, wordDrawGrid_colBorder, currentWordGridRow);
	var borderRounded = ds_grid_get(wordDrawGrid, wordDrawGrid_colBorderRounded, currentWordGridRow);
	
	var currentWordInChainsListSize = ds_list_size(currentWordInChainsList);
	for (var i = 0; i < currentWordInChainsListSize; i++) {
		if (ds_list_find_index(chainShowList, ds_list_find_value(currentWordInChainsList, i)) == -1) {
			ds_list_add(chainShowList, ds_list_find_value(currentWordInChainsList, i));
		}
	}
	
	
	if(currentWordState != wordStateNormal) {
		if(currentWordState == wordStateDead) {
			
			drawWordLoop++;
			continue;
		}
	
		// Check if the word is a ChunkWord
		if(currentWordState == wordStateChunk) {
		
			scr_drawChunk(currentWordID, currentLineY, fontScale, unitID);
			
			drawWordLoop++;
			continue;
		}
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
	if ((showDevVars and currentWordVoid > 0)) {// or currentWordVoid > 17) { // Do we want to always be showing this?
		scr_drawVoids(drawWordLoop, previousWordDisplayCol, gridSpaceHorizontal, wordLeftMargin, currentLineY, currentWordVoid, currentWordDisplayCol);
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
	if (is_string(currentWordX)) {
		currentWordX = 0;
	}
	leftScreenBound = min(currentWordX, leftScreenBound);
		
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
	//var currentWordStringHeight = string_height(currentWordStringType);
	
		
	var wordRectBuffer = 3;
	var wordRectX1 = currentWordX - wordRectBuffer;
	var wordRectY1 = currentLineY - (strHeightScaled / 2) - wordRectBuffer;
	var wordRectX2 = wordRectX1 + currentWordStringWidth + (wordRectBuffer * 2);
	var wordRectY2 = wordRectY1 + strHeightScaled + (wordRectBuffer * 2);
	
	
	var inMouseHoldRect = 0;
	if (mouse_check_button(mb_left) and (currentTool == toolRezBrush or currentTool == toolTrackBrush)) {
		if(mouseRectWithinLine) {
			inMouseHoldRect = rectangle_in_rectangle(wordRectX1, wordRectY1, wordRectX2, wordRectY2, min(mouseHoldRectX1, mouseHoldRectX2), min(mouseHoldRectY1, mouseHoldRectY2), max(mouseHoldRectX1, mouseHoldRectX2), max(mouseHoldRectY1, mouseHoldRectY2));
		}
		else if (mouseRectBeginBetweenWords == -1 and not mouseRectWithinLine and not (currentTool == toolTrackBrush and not searchGridActive)) {
			inMouseHoldRect = rectangle_in_rectangle(wordRectX1, wordRectY1, wordRectX1 + gridSpaceHorizontal - 20, wordRectY2, min(mouseHoldRectX1, mouseHoldRectX2), min(mouseHoldRectY1, mouseHoldRectY2), max(mouseHoldRectX1, mouseHoldRectX2), max(mouseHoldRectY1, mouseHoldRectY2));
		}
		else {
			inMouseHoldRect = 0;
		}
		 
		if (inMouseHoldRect) {
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
	draw_set_color(colorThemeBG);
	draw_rectangle(wordRectX1, wordRectY1, wordRectX2, wordRectY2, false);
	
	
	// Draw Place chains when needed
	if(showPlaceChains) {
		// Place Chains Prototype
		var wordHasLetters = string_length(string_letters(currentWordStringType)) > 0;
		if(drawWordLoop != currentWordIDListSize - 1 && wordHasLetters) {
			scr_drawPlaceChains(wordRectX1, wordRectY1, wordRectX2, wordRectY2, drawWordLoop, currentWordIDListSize, currentWordGridRow,currentWordDisplayCol);
		}
	}
	
	
	// figure out whether or not to draw fill/border for this word
	/*var drawFillRect = ds_grid_get(wordDrawGrid, wordDrawGrid_colFillRect, currentWordGridRow);
	//var drawBorder = ds_grid_get(wordDrawGrid, wordDrawGrid_colBorder, currentWordGridRow);
	var drawFocused = ds_grid_get(wordDrawGrid, wordDrawGrid_colFocused, currentWordGridRow);
	var effectColor = ds_grid_get(wordDrawGrid, wordDrawGrid_colEffectColor, currentWordGridRow);*/
	if(stackShowActive) {
		var drawGoldStandard = (currentWordState == obj_control.wordStateGold);
		var drawIncorrect = (currentWordState == obj_control.wordStateRed);
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
	
	//scr_drawWordBorder(drawBorder, drawFillRect, drawFocused, effectColor, wordRectX1, wordRectY1, wordRectX2, wordRectY2, borderRounded, fontScale);
	scr_drawWordBorder(drawBorder, currentWordGridRow, wordRectX1, wordRectY1, wordRectX2, wordRectY2, borderRounded, fontScale);
	
	// Until I can get a check that sees if the mouseRect is in the line, this can't happen
	if (((mouse_y > wordRectY1 && mouse_y < wordRectY2) || (mouseRectMade || obj_control.boxRectMade)) && !inRezPlay) {
		scr_mouseOnWord(currentWordID, wordRectX1, wordRectY1, wordRectX2, wordRectY2, unitID, drawWordLoop, currentWordIDListSize, panelPaneResizeHeld, currentWordState, drawLineLoop);
	}
	
	scr_drawWord(currentWordGridRow, currentWordID, currentWordX, currentLineY, currentWordString, hitGridHeight);

	previousWordDisplayCol = currentWordDisplayCol;
	previousWordDisplayString = currentWordString;
	
	shapeTextX += currentWordStringWidth + shapeTextSpace;
	drawWordLoop++;
}



// set total void values for this line, now that we have gone through every word in the line
ds_grid_set(currentActiveLineGrid, obj_control.lineGrid_colVoidMax, drawLineLoop, voidMax);
ds_grid_set(currentActiveLineGrid, obj_control.lineGrid_colVoidSum, drawLineLoop, voidSum);