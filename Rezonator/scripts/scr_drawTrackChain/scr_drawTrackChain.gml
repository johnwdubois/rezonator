/*
	scr_drawTrackChain();
	
	Last Updated: 2018-07-12
	
	Called from: obj_chain
	
	Purpose: draw trackChains with information from trackChainGrid
	
	Mechanism: loop through each row in trackChainGrid, get the wordIDList from each chain, and call scr_drawCurvedLine
				with x and y values for words in wordIDList
				
	Author: Terry DuBois
*/

draw_set_font(fnt_main);

var lineX1 = undefined;
var lineY1 = undefined;
var lineX2 = undefined;
var lineY2 = undefined;
var mouseLineX = undefined;
var mouseLineY = undefined;

var furthestWordID = -1;
var furthestDisplayCol = -1;

// loop through rezChainGrid to get chain info
for (var i = 0; i < ds_grid_height(trackChainGrid); i++) {
	var currentWordIDList = ds_grid_get(trackChainGrid, chainGrid_colWordIDList, i);
	var currentChainColor = ds_grid_get(trackChainGrid, chainGrid_colColor, i);
	
	
	var wordsInSameUnit = false;
	var firstWordInUnit = -1;
	
	// loop through wordIDList in current track chain to draw lines
	for (var j = 0; j < ds_list_size(currentWordIDList) - 1; j++) {
		var currentWordID1 = ds_list_find_value(currentWordIDList, j);
		var currentUnitID1 = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWordID1 - 1);
		var currentLineGridIndex1 = ds_grid_value_y(obj_control.currentActiveLineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(obj_control.currentActiveLineGrid), currentUnitID1);
		var chunkWord1 = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentWordID1 - 1);
		
		var currentWordStringWidth1 = string_width(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordID1 -1));
		var currentWordStringHeight1 = string_height(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordID1 - 1));
		
		lineX1 = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, currentWordID1 - 1);
		lineY1 = ds_grid_get(obj_control.currentActiveLineGrid, obj_control.lineGrid_colPixelY, currentLineGridIndex1);
		
		var currentWordID2 = ds_list_find_value(currentWordIDList, j + 1);
		var currentUnitID2 = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWordID2 - 1);
		var currentLineGridIndex2 = ds_grid_value_y(obj_control.currentActiveLineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(obj_control.currentActiveLineGrid), currentUnitID2);
		var chunkWord2 = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentWordID2 - 1);
		
		if (currentUnitID1 == currentUnitID2)
		{
			wordsInSameUnit = true;
			if (firstWordInUnit < 0)
			{
				firstWordInUnit = currentWordID1;
			}
		}
		else
		{
			if (wordsInSameUnit and firstWordInUnit >= 0 and firstWordInUnit < ds_grid_height(obj_control.wordGrid))
			{
				currentWordID1 = firstWordInUnit;
				currentUnitID1 = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWordID1 - 1);
				currentLineGridIndex1 = ds_grid_value_y(obj_control.currentActiveLineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(obj_control.currentActiveLineGrid), currentUnitID1);
		
				currentWordStringWidth1 = string_width(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordID1 - 1));
				currentWordStringHeight1 = string_height(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordID1 - 1));
		
				lineX1 = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, currentWordID1 - 1);
				lineY1 = ds_grid_get(obj_control.currentActiveLineGrid, obj_control.lineGrid_colPixelY, currentLineGridIndex1);
			}
			
			firstWordInUnit = -1;
		}
		
		var currentWordStringWidth2 = string_width(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordID2 - 1));
		var currentWordStringHeight2 = string_height(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordID2 - 1));
		
		lineX2 = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, currentWordID2 - 1);
		lineY2 = ds_grid_get(obj_control.currentActiveLineGrid, obj_control.lineGrid_colPixelY, currentLineGridIndex2);
		
		var currentLineGridIndex1InDrawRange = true;
		var currentLineGridIndex2InDrawRange = true;
		
		if (currentLineGridIndex1 < obj_control.drawRangeStart or currentLineGridIndex1 > obj_control.drawRangeEnd) {
			currentLineGridIndex1InDrawRange = false;
		}
		
		if (currentLineGridIndex2 < obj_control.drawRangeStart or currentLineGridIndex2 > obj_control.drawRangeEnd) {
			currentLineGridIndex2InDrawRange = false;
		}
		
		if(chunkWord1) {
			var wordRectBuffer = 6;
			if(ds_grid_get(obj_chain.chunkGrid, obj_chain.chunkGrid_colNest, (ds_list_find_value(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInBoxList, currentWordID1 - 1), 0) - 1)) == true) {
				wordRectBuffer = 4;
			}
			lineY1 += (wordRectBuffer * 2) + 4;
			chunkWord1 = 0;
		}
		if(chunkWord2) {
			var wordRectBuffer = 6;
			if(ds_grid_get(obj_chain.chunkGrid, obj_chain.chunkGrid_colNest, (ds_list_find_value(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInBoxList, currentWordID2 - 1), 0) - 1)) == true) {
				wordRectBuffer = 4;
			}
			lineY2 -= (wordRectBuffer * 3);
			chunkWord2 = 0;
		}
		
		if not (lineX1 == undefined or lineY1 == undefined or lineX2 == undefined or lineY2 == undefined)
		and (currentLineGridIndex1InDrawRange or currentLineGridIndex2InDrawRange)
		and not (obj_control.searchGridActive) {
			draw_set_color(currentChainColor);
			draw_set_alpha(1);
			
			if (lineY1 == lineY2) {
				draw_line_width(lineX1, lineY1, lineX2, lineY2, 2);
			}
			else {
				scr_drawCurvedLine(lineX1 + (currentWordStringWidth1 / 2), lineY1, lineX2 + (currentWordStringWidth2 / 2), lineY2, currentChainColor);
			}
		}
	}
	
	
	// get X,Y position of where pickwhip to mouse should start
	if (ds_grid_get(trackChainGrid, chainGrid_colChainState, i) == chainStateFocus) {	
		if (mouseLineWordID >= 0 && (mouseLineWordID - 1) < ds_grid_height(obj_control.wordGrid)) {
			var mouseLineWordUnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, mouseLineWordID - 1);
			var mouseLineWordGridIndex = ds_grid_value_y(obj_control.currentActiveLineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(obj_control.currentActiveLineGrid), mouseLineWordUnitID);
			
			var mouseLineWordStringWidth = string_width(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, mouseLineWordID - 1));
			var mouseLineWordStringHeight = string_height(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, mouseLineWordID - 1));
			
			mouseLineX = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, mouseLineWordID - 1) + (mouseLineWordStringWidth / 2);
			mouseLineY = ds_grid_get(obj_control.currentActiveLineGrid, obj_control.lineGrid_colPixelY, mouseLineWordGridIndex) + (mouseLineWordStringHeight / 2);
		}
	}
	
	
	
	var isAligned = ds_grid_get(trackChainGrid, chainGrid_colAlign, i);
	scr_alignChain(currentWordIDList, isAligned);
	
}

// draw pickwhip line to mouse
if (not (mouseLineX == undefined or mouseLineY == undefined)) {
	if (ds_grid_value_exists(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.trackChainGrid), obj_chain.chainStateFocus)) {
		var rowInChainGrid = ds_grid_value_y(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.trackChainGrid), obj_chain.chainStateFocus);
		currentChainColor = ds_grid_get(obj_chain.trackChainGrid, obj_chain.chainGrid_colColor, rowInChainGrid);
		draw_set_color(currentChainColor);
		
		if (not mouseLineHide) {
			draw_line_width(mouseLineX, mouseLineY, mouse_x, mouse_y, 2);
		}
	}
}



scr_unfocusOtherChains(obj_toolPane.toolTrackBrush);