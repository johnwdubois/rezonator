function scr_drawChains() {
	/*
		scr_drawChains();
	
		Last Updated: 2018-07-12
	
		Called from: obj_chain
	
		Purpose: draw rezChains and move words on screen according to the rezChains
	
		Mechanism: loop through chain show list and get the wordIDList from each chain, and draw lines
					from word information
				
		Author: Terry DuBois
	*/


	var lineX1 = undefined;
	var lineY1 = undefined;
	var lineX2 = undefined;
	var lineY2 = undefined;
	var mouseLineX = undefined;
	var mouseLineY = undefined;

	//var furthestWordID = -1;
	//var furthestDisplayCol = -1;

	var minWordWidth = 9999999;
	var linePlusX = 0;

	var currentWordStringHeight1 = string_height("0");
	var currentWordStringHeight2 = currentWordStringHeight1;

	var wordTopMargin = obj_control.wordTopMargin;
	var rezChainList = ds_map_find_value(global.nodeMap, "rezChainList");
	var rezChainListSize = ds_list_size(rezChainList);
	var activeLineGridHeight = ds_grid_height(obj_control.currentActiveLineGrid);
	var arrowSize = 0.3 + (0.1 * global.fontSize/5);

	// loop through rezChainList to get chain info
	var chainShowListSize = ds_list_size(chainShowList);
	for (var i = 0; i < chainShowListSize; i++) {
		minWordWidth = 9999999;
		
		var currentChainID = ds_list_find_value(chainShowList, i);
		
		// skip this chain if we can't find it in the nodeMap
		if (!ds_map_exists(global.nodeMap, currentChainID)) continue;
		
		// make sure this chain's subMap exists and that it is actually a map
		var currentChainSubMap = ds_map_find_value(global.nodeMap, currentChainID);
		if (!is_numeric(currentChainSubMap)) continue;
		if (!ds_exists(currentChainSubMap, ds_type_map)) continue;
		
		// get chain's setIDList and make sure it exists
		var chainType = ds_map_find_value(currentChainSubMap, "type");
		var currentSetIDList = ds_map_find_value(currentChainSubMap, "vizSetIDList");
		if (!is_numeric(currentSetIDList)) continue;
		if (!ds_exists(currentSetIDList, ds_type_list)) continue;
		var currentSetIDListSize = ds_list_size(currentSetIDList);
		var currentChainColor = ds_map_find_value(currentChainSubMap, "chainColor");
		var currentChainShow = true;
		
		// make sure this is a rezChain or trackChain and that we should be drawing it
		if (chainType != "rezChain" && chainType != "trackChain") continue;
		if (chainType == "rezChain" && !obj_chain.toggleDrawRez) continue;
		if (chainType == "trackChain" && !obj_chain.toggleDrawTrack) continue;
	
		// find minimum word width so we know the X position of the chain
		for (var j = 0; j < currentSetIDListSize; j++) {
			var currentEntry = ds_list_find_value(currentSetIDList, j);
			var currentEntrySubMap = ds_map_find_value(global.nodeMap, currentEntry);
			var currentWordID = ds_map_find_value(currentEntrySubMap, "word");
			var currentWordWidth = 0;
			if (is_numeric(currentWordID)){
				currentWordWidth = string_width(string(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordID - 1))) / 2;
			}
			currentWordWidth = max(currentWordWidth, 0);
		
			if (currentWordWidth < minWordWidth) {
				minWordWidth = currentWordWidth;
				linePlusX = minWordWidth;
			}
		}
	
		var wordsInSameLine = false;
		var firstWordInLine = -1;
	
		// loop through current chain's wordIDList to draw the lines of the chain
		for (var j = 0; j < currentSetIDListSize - 1; j++) {
			
			// get the wordIDs for the 2 words we want to draw a line between
			var currentEntry1 = ds_list_find_value(currentSetIDList, j);
			var currentEntry1SubMap = ds_map_find_value(global.nodeMap, currentEntry1);
			var currentEntry2 = ds_list_find_value(currentSetIDList, j + 1);
			var currentEntry2SubMap = ds_map_find_value(global.nodeMap, currentEntry2);
			var currentWordID1 = ds_map_find_value(currentEntry1SubMap, "word");
			var currentWordID2 = ds_map_find_value(currentEntry2SubMap, "word");
		
			var currentLineID1 = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayRow, currentWordID1 - 1);
			var chunkWord1 = (ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentWordID1 - 1) == obj_control.wordStateChunk);
			//Add a nesting check
		
			var currentWordStringWidth1 = string_width(string(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordID1 - 1)));
		
			lineX1 = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, currentWordID1 - 1);
			lineY1 = ds_grid_get(obj_control.currentActiveLineGrid, obj_control.lineGrid_colPixelY, currentLineID1);
		
		
			var currentLineID2 = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayRow, currentWordID2 - 1);
			var chunkWord2 = (ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentWordID2 - 1) == obj_control.wordStateChunk);
			//Add a nesting check
			var sideLink = false;
			
			// check if this is a side link
			if (currentLineID1 == currentLineID2) {
				wordsInSameLine = true;
				// if we have not set the first word in the line yet, set it to be this one
				if (firstWordInLine < 0) {
					firstWordInLine = currentWordID1;
				}
				sideLink = true;
			}
			else {
				if (wordsInSameLine and firstWordInLine >= 0 and (firstWordInLine - 1) < ds_grid_height(obj_control.wordGrid)) {
					currentWordID1 = firstWordInLine;
					currentLineID1 = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayRow, currentWordID1 - 1);
					//currentLineGridIndex1 = ds_grid_value_y(obj_control.currentActiveLineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, activeLineGridHeight, currentUnitID1);
		
					currentWordStringWidth1 = string_width(string(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordID1 - 1)));
		
					lineX1 = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, currentWordID1 - 1);
					lineY1 = ds_grid_get(obj_control.currentActiveLineGrid, obj_control.lineGrid_colPixelY, currentLineID1);
				}
			
				firstWordInLine = -1;
			}
		
			var currentWordStringWidth2 = string_width(string(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordID2 - 1)));
		
			lineX2 = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, currentWordID2 - 1);
			lineY2 = ds_grid_get(obj_control.currentActiveLineGrid, obj_control.lineGrid_colPixelY, currentLineID2);
		
			var currentLineGridIndex1InDrawRange = true;
			var currentLineGridIndex2InDrawRange = true;
		
			if (currentLineID1 < obj_control.drawRangeStart or currentLineID1 > obj_control.drawRangeEnd) {
				currentLineGridIndex1InDrawRange = false;
			}
		
			if (currentLineID2 < obj_control.drawRangeStart or currentLineID2 > obj_control.drawRangeEnd) {
				currentLineGridIndex2InDrawRange = false;
			}
		
		
		
			//wordTopMargin + 
			// only draw line if every value is real and we are in the draw range
			if not (lineX1 == undefined or lineY1 == undefined or lineX2 == undefined or lineY2 == undefined)
			and not (lineY1 < wordTopMargin + (-obj_control.gridSpaceVertical * 2) and lineY2 < wordTopMargin + (-obj_control.gridSpaceVertical * 2))
			and not (lineY1 > camera_get_view_height(camera_get_active()) + (obj_control.gridSpaceVertical * 2) and lineY2 > camera_get_view_height(camera_get_active()) + (obj_control.gridSpaceVertical * 2))
			and not (obj_control.searchGridActive) {
				if (chunkWord1) {
					var wordRectBuffer = 15;
					lineY1 += wordRectBuffer;
					chunkWord1 = 0;
				}
				if (chunkWord2) {
					var wordRectBuffer = 15;
					lineY2 -= (wordRectBuffer);
				}
			
				if (currentChainShow) {
					draw_set_color(currentChainColor);
					draw_set_alpha(1);
					if (chunkWord2) {
						if (chainType == "rezChain") {
							draw_line_width(lineX1 + linePlusX, lineY1 + (currentWordStringHeight1 / 2), lineX2 + linePlusX, lineY2 - (currentWordStringHeight2 / 2), 2);
						}
						else if (chainType == "trackChain") {
							scr_drawCurvedLine(lineX1 + (currentWordStringWidth1 / 2), lineY1, lineX2 + (currentWordStringWidth2 / 2), lineY2, currentChainColor);
						}
					}
					else {
						if (chainType == "rezChain") {
							draw_line_width(lineX1 + linePlusX, lineY1 + (currentWordStringHeight1 / 2), lineX2 + linePlusX, lineY2 + (currentWordStringHeight2 / 2), 2);
						}
						else if (chainType == "trackChain") {
							scr_drawCurvedLine(lineX1 + (currentWordStringWidth1 / 2), lineY1, lineX2 + (currentWordStringWidth2 / 2), lineY2, currentChainColor);
						}
					}
				}
				// I need to modify this with the Chunk's wordRectBuffer
				chunkWord2 = 0;
			}
		}
	
	
	
		if (obj_chain.currentFocusedChainID == currentChainID) {	
			if (mouseLineWordID >= 0 && (mouseLineWordID - 1) < ds_grid_height(obj_control.wordGrid)) {
				
				var mouseLineWordDisplayRow = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayRow, mouseLineWordID - 1);
				var mouseLineWordStringWidth = string_width(string(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, mouseLineWordID - 1)));
				var mouseLineWordStringHeight = string_height(string(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, mouseLineWordID - 1)));
				var wordPixelX = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, mouseLineWordID - 1);
				var wordPixelY = ds_grid_get(obj_control.currentActiveLineGrid, obj_control.lineGrid_colPixelY, mouseLineWordDisplayRow);
					
				if(wordPixelX != undefined and wordPixelY != undefined){
					mouseLineX = wordPixelX + (mouseLineWordStringWidth / 2);
					mouseLineY = wordPixelY + (mouseLineWordStringHeight / 2);
				}
			}
		}
	
		var isAligned = ds_map_find_value(currentChainSubMap, "align");
		scr_alignChain(currentSetIDList, isAligned);
	}


	// draw pickwhip line to mouse from chain
	if (not (mouseLineX == undefined or mouseLineY == undefined)) {
		if (ds_map_exists(global.nodeMap, obj_chain.currentFocusedChainID)) {
			var chainSubMap = ds_map_find_value(global.nodeMap, obj_chain.currentFocusedChainID);
			if (is_numeric(chainSubMap)) {
				if (ds_exists(chainSubMap, ds_type_map)) {
					var chainType = ds_map_find_value(chainSubMap, "type");
					currentChainColor = ds_map_find_value(chainSubMap, "chainColor");
					draw_set_color(currentChainColor);
			
					if (currentChainShow) {
						if (not mouseLineHide) {
							if (chainType == "rezChain") {
								draw_line_width(mouseLineX, mouseLineY, mouse_x, mouse_y, 2);
							}
							else if (chainType == "trackChain") {
								scr_drawCurvedLine(mouseLineX, mouseLineY, mouse_x, mouse_y, currentChainColor);
							}
							if (obj_chain.showChainArrows) {
								var arrowAngle = point_direction(mouseLineX, mouseLineY, mouse_x, mouse_y);
								draw_sprite_ext(spr_linkArrow, 1, mouse_x, mouse_y, arrowSize, arrowSize, arrowAngle, currentChainColor, 1);
							}
						}
					}
				}
			}
		}
	}



}
