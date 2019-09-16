/*
	scr_drawRezChain();
	
	Last Updated: 2018-07-12
	
	Called from: obj_chain
	
	Purpose: draw rezChains and move words on screen according to the rezChains
	
	Mechanism: loop through each row in rezChainGrid, get the wordIDList from each chain, and draw lines
				from word information
				
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

var minWordWidth = 9999999;
var linePlusX = 0;

// loop through rezChainGrid to get chain info
for (var i = 0; i < ds_grid_height(rezChainGrid); i++) {
	minWordWidth = 9999999;
	
	var currentWordIDList = ds_grid_get(rezChainGrid, chainGrid_colWordIDList, i);
	var currentChainColor = ds_grid_get(rezChainGrid, chainGrid_colColor, i);
	
	// find minimum word width so we know the X position of the chain
	for (var j = 0; j < ds_list_size(currentWordIDList); j++) {
		var currentWordID = ds_list_find_value(currentWordIDList, j);
		var currentWordWidth = string_width(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordID - 1)) / 2;
		currentWordWidth = max(currentWordWidth, 0);
		
		if (currentWordWidth < minWordWidth)
		{
			minWordWidth = currentWordWidth;
			linePlusX = minWordWidth;
		}
	}
	
	var wordsInSameUnit = false;
	var firstWordInUnit = -1;
	
	// loop through current chain's wordIDList to draw the lines of the chain
	for (var j = 0; j < ds_list_size(currentWordIDList) - 1; j++) {
		var currentWordID1 = ds_list_find_value(currentWordIDList, j);
		var currentUnitID1 = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWordID1 - 1);
		var currentLineGridIndex1 = ds_grid_value_y(obj_control.currentActiveLineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(obj_control.currentActiveLineGrid), currentUnitID1);
		var chunkWord1 = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentWordID1 - 1) == obj_control.wordStateChunk ? true : false;
		
		var currentWordStringWidth1 = string_width(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordID1 - 1));
		var currentWordStringHeight1 = string_height(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordID1 - 1));
		
		lineX1 = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, currentWordID1 - 1);
		lineY1 = ds_grid_get(obj_control.currentActiveLineGrid, obj_control.lineGrid_colPixelY, currentLineGridIndex1);
		
		var currentWordID2 = ds_list_find_value(currentWordIDList, j + 1);
		var currentUnitID2 = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWordID2 - 1);
		var currentLineGridIndex2 = ds_grid_value_y(obj_control.currentActiveLineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(obj_control.currentActiveLineGrid), currentUnitID2);
		var chunkWord2 = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentWordID2 - 1) == obj_control.wordStateChunk ? true : false;
		
		if (currentUnitID1 == currentUnitID2) {
			wordsInSameUnit = true;
			if (firstWordInUnit < 0) {
				firstWordInUnit = currentWordID1;
			}
		}
		else {
			if (wordsInSameUnit and firstWordInUnit >= 0 and (firstWordInUnit - 1) < ds_grid_height(obj_control.wordGrid)) {
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
		
		
		
		
		// only draw line if every value is real and we are in the draw range
		if not (lineX1 == undefined or lineY1 == undefined or lineX2 == undefined or lineY2 == undefined)
		and not (lineY1 < (-obj_control.gridSpaceVertical * 2) and lineY2 < (-obj_control.gridSpaceVertical * 2))
		and not (lineY1 > camera_get_view_height(view_camera[0]) + (obj_control.gridSpaceVertical * 2) and lineY2 > camera_get_view_height(view_camera[0]) + (obj_control.gridSpaceVertical * 2))
		and not (obj_control.searchGridActive) {
			if (chunkWord1) {
			var wordRectBuffer = 6;
			lineY1 += wordRectBuffer;
			chunkWord1 = 0;
			}
			if(chunkWord2) {
				var wordRectBuffer = 6;
				lineY2 -= (wordRectBuffer * 4) + 4;
				chunkWord2 = 0;
			}
			
			draw_set_color(currentChainColor);
			draw_set_alpha(1);
			draw_line_width(lineX1 + linePlusX, lineY1 + (currentWordStringHeight1 / 2), lineX2 + linePlusX, lineY2 + (currentWordStringHeight2 / 2), 2);
			// I need to modify this with the Chunk's wordRectBuffer
			
		}
	}
	
	
	
	if (ds_grid_get(rezChainGrid, chainGrid_colChainState, i) == chainStateFocus) {	
		if (mouseLineWordID >= 0 && (mouseLineWordID - 1) < ds_grid_height(obj_control.wordGrid)) {
			var mouseLineWordUnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, mouseLineWordID - 1);
			var mouseLineWordGridIndex = ds_grid_value_y(obj_control.currentActiveLineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(obj_control.currentActiveLineGrid), mouseLineWordUnitID);
			
			//if (mouseLineWordGridIndex > -1 and mouseLineWordGridIndex < ds_grid_height(obj_control.currentActiveLineGrid
			//and mouseLineWordID > -1 and mouseLineWordID < ds_grid_height(obj_control.wordGrid))) {
			
				var mouseLineWordStringWidth = string_width(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, mouseLineWordID - 1));
				var mouseLineWordStringHeight = string_height(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, mouseLineWordID - 1));
			
				mouseLineX = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, mouseLineWordID - 1) + (mouseLineWordStringWidth / 2);
				mouseLineY = ds_grid_get(obj_control.currentActiveLineGrid, obj_control.lineGrid_colPixelY, mouseLineWordGridIndex) + (mouseLineWordStringHeight / 2);
			//}
			
		}
	}
	
	
	var isAligned = ds_grid_get(rezChainGrid, chainGrid_colAlign, i);
	scr_alignChain(currentWordIDList, isAligned);
}


// draw pickwhip line to mouse from chain
if (not (mouseLineX == undefined or mouseLineY == undefined)) {
	//obj_control.showMouseLine = true;	
	if (ds_grid_value_exists(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.rezChainGrid), obj_chain.chainStateFocus)) {
		var rowInChainGrid = ds_grid_value_y(obj_chain.rezChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.rezChainGrid), obj_chain.chainStateFocus);
		if (rowInChainGrid >= 0) {
			currentChainColor = ds_grid_get(obj_chain.rezChainGrid, obj_chain.chainGrid_colColor, rowInChainGrid);
			draw_set_color(currentChainColor);
		
			if (not mouseLineHide) {
				draw_line_width(mouseLineX, mouseLineY, mouse_x, mouse_y, 2);
			}
		}
	}
}

scr_unfocusOtherChains(obj_toolPane.toolRezBrush);