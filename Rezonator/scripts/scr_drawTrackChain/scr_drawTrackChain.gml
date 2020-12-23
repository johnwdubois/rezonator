function scr_drawTrackChain() {
	/*
		scr_drawTrackChain();
	
		Last Updated: 2018-07-12
	
		Called from: obj_chain
	
		Purpose: draw trackChains with information from trackChainGrid
	
		Mechanism: loop through each row in trackChainGrid, get the wordIDList from each chain, and call scr_drawCurvedLine
					with x and y values for words in wordIDList
				
		Author: Terry DuBois
	*/
	//if(live_call()) return live_result;
	if (not obj_chain.toggleDrawTrack) {
		exit;
	}


	var lineX1 = undefined;
	var lineY1 = undefined;
	var lineX2 = undefined;
	var lineY2 = undefined;
	var mouseLineX = undefined;
	var mouseLineY = undefined;

	//var furthestWordID = -1;
	//var furthestDisplayCol = -1;

	var trackChainGridHeight = ds_grid_height(trackChainGrid);
	var activeLineGridHeight = ds_grid_height(obj_control.currentActiveLineGrid);
	var linkGridHeight = ds_grid_height(linkGrid);
	var arrowSize = 0.3 + (0.1 * global.fontSize/5);

	// loop through trackChainGrid to get chain info
	var chainShowListSize = ds_list_size(chainShowList);
	for (var i = 0; i < chainShowListSize; i++) {
	
		var currentChainID = ds_list_find_value(chainShowList, i);
		if (ds_list_find_value(chainShowList, currentChainID) == -1) {
			continue;
		}
		var rowInChainGrid = ds_grid_value_y(trackChainGrid, chainGrid_colChainID, 0, chainGrid_colChainID, trackChainGridHeight, currentChainID);
		if (rowInChainGrid < 0 or rowInChainGrid >= trackChainGridHeight) {
			continue;
		}
	
		var currentWordIDList = ds_grid_get(trackChainGrid, chainGrid_colWordIDList, rowInChainGrid);
		var currentChainColor = ds_grid_get(trackChainGrid, chainGrid_colColor, rowInChainGrid);
		var currentChainShow = true;//ds_grid_get(trackChainGrid, chainGrid_colShow, rowInChainGrid);
	
	
		var wordsInSameLine = false;
		var firstWordInLine = -1;
	
		// loop through wordIDList in current track chain to draw lines
		var currentWordIDListSize = ds_list_size(currentWordIDList);
		for (var j = 0; j < currentWordIDListSize - 1; j++) {
			var currentWordID1 = ds_list_find_value(currentWordIDList, j);
			var currentLineID1 = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayRow, currentWordID1 - 1);
			//var currentLineGridIndex1 = ds_grid_value_y(obj_control.currentActiveLineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, activeLineGridHeight, currentUnitID1);
			var chunkWord1 = (ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentWordID1 - 1) == obj_control.wordStateChunk);
			//Add a nesting check
		
			var currentWordStringWidth1 = string_width(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordID1 -1));
			var currentWordStringHeight1 = string_height(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordID1 - 1));
			var currentHitGridIndex1 = ds_grid_value_y(obj_control.hitGrid, obj_control.hitGrid_colWordID, 0, obj_control.hitGrid_colWordID, ds_grid_height(obj_control.hitGrid)-1, currentWordID1);

			if (obj_control.searchGridActive) {
				lineX1 = ds_grid_get(obj_control.hitGrid, obj_control.hitGrid_colPixelX, currentHitGridIndex1);
			}
			else {
				lineX1 = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, currentWordID1 - 1);
			}
		
			lineY1 = ds_grid_get(obj_control.currentActiveLineGrid, obj_control.lineGrid_colPixelY, currentLineID1);
		
			var currentWordID2 = ds_list_find_value(currentWordIDList, j + 1);
			var currentLineID2 = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayRow, currentWordID2 - 1);
			//var currentLineGridIndex2 = ds_grid_value_y(obj_control.currentActiveLineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, activeLineGridHeight, currentUnitID2);
			var chunkWord2 = (ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentWordID2 - 1) == obj_control.wordStateChunk);
			var currentHitGridIndex2 = ds_grid_value_y(obj_control.hitGrid, obj_control.hitGrid_colWordID, 0, obj_control.hitGrid_colWordID, ds_grid_height(obj_control.hitGrid)-1, currentWordID2);
			//Add a nesting check
		
			if (currentLineID1 == currentLineID2) {
				wordsInSameLine = true;
				if (firstWordInLine < 0) {
					firstWordInLine = currentWordID1;
				}
			}
			else {
				if (wordsInSameLine and firstWordInLine >= 0 and (firstWordInLine - 1) < ds_grid_height(obj_control.wordGrid)) {
					currentWordID1 = firstWordInLine;
					currentLineID1 = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayRow, currentWordID1 - 1);
					//currentLineGridIndex1 = ds_grid_value_y(obj_control.currentActiveLineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, activeLineGridHeight, currentUnitID1);
		
					currentWordStringWidth1 = string_width(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordID1 - 1));
					currentWordStringHeight1 = string_height(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordID1 - 1));
		
					if (obj_control.searchGridActive) {
						lineX1 = ds_grid_get(obj_control.hitGrid, obj_control.hitGrid_colPixelX, currentHitGridIndex1);
					}
					else {
						lineX1 = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, currentWordID1 - 1);
					}
					lineY1 = ds_grid_get(obj_control.currentActiveLineGrid, obj_control.lineGrid_colPixelY, currentLineID1);
				}
			
				firstWordInLine = -1;
			}
		
			var currentWordStringWidth2 = string_width(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordID2 - 1));
			var currentWordStringHeight2 = string_height(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordID2 - 1));
		
			if (obj_control.searchGridActive) {
				lineX2 = ds_grid_get(obj_control.hitGrid, obj_control.hitGrid_colPixelX, currentHitGridIndex2);
			}
			else {
				lineX2 = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, currentWordID2 - 1);
			}
			lineY2 = ds_grid_get(obj_control.currentActiveLineGrid, obj_control.lineGrid_colPixelY, currentLineID2);
		
			var currentLineGridIndex1InDrawRange = true;
			var currentLineGridIndex2InDrawRange = true;
		
			if (currentLineID1 < obj_control.drawRangeStart or currentLineID1 > obj_control.drawRangeEnd) {
				currentLineGridIndex1InDrawRange = false;
			}
		
			if (currentLineID2 < obj_control.drawRangeStart or currentLineID2 > obj_control.drawRangeEnd) {
				currentLineGridIndex2InDrawRange = false;
			}
		
		
		
			if not (lineX1 == undefined or lineY1 == undefined or lineX2 == undefined or lineY2 == undefined)
			and not (lineY1 < (-obj_control.gridSpaceVertical * 2) and lineY2 < (-obj_control.gridSpaceVertical * 2))
			and not (lineY1 > camera_get_view_height(camera_get_active()) + (obj_control.gridSpaceVertical * 2) and lineY2 > camera_get_view_height(camera_get_active()) + (obj_control.gridSpaceVertical * 2))
			{
				if(chunkWord1) {
					var wordRectBuffer = 15;
					lineY1 += (wordRectBuffer + (currentWordStringHeight1 / 2));
					chunkWord1 = 0;
				}
				if(chunkWord2) {
					var wordRectBuffer = 15;
					lineY2 -= (wordRectBuffer + (currentWordStringHeight2 / 2));
					chunkWord2 = 0;
				}
			
				draw_set_color(currentChainColor);
				draw_set_alpha(1);
			
				if (currentChainShow) {
					if (lineY1 == lineY2) {
						draw_line_width(lineX1, lineY1, lineX2, lineY2, 2);
						var lineDist = point_distance(lineX1, lineY1, lineX2, lineY2);
						var arrowAngle = point_direction(lineX1, lineY1, lineX2, lineY2);
						if(lineDist > 30 and obj_chain.showChainArrows) {
							//calculate the direciton of the arrow
							var linkGridY = ds_grid_value_y(linkGrid, linkGrid_colGoal, 0, linkGrid_colGoal, linkGridHeight, currentWordID1);
							var reverseLink = currentWordID2 == ds_grid_get(linkGrid, linkGrid_colSource, linkGridY);
							var arrowX = lineX2 - (currentWordStringWidth2/5);
							var arrowY = lineY2;
							if(reverseLink) {
								arrowAngle += 180;	
								arrowX = lineX1 + currentWordStringWidth1 + 10;
								arrowY = lineY1;
							}
							draw_sprite_ext(spr_linkArrow, 1, arrowX, arrowY, arrowSize, arrowSize, arrowAngle, currentChainColor, 1);
						}
					}
					else {
						scr_drawCurvedLine(lineX1 + (currentWordStringWidth1 / 2), lineY1, lineX2 + (currentWordStringWidth2 / 2), lineY2, currentChainColor);
						var lineDist = point_distance(lineX1 + (currentWordStringWidth1 / 2), lineY1, lineX2 + (currentWordStringWidth2 / 2), lineY2);
						var arrowAngle = 270;
						if(lineDist > 30 and obj_chain.showChainArrows) {
							//calculate the direciton of the arrow
							var linkGridY = ds_grid_value_y(linkGrid, linkGrid_colGoal, 0, linkGrid_colGoal, linkGridHeight, currentWordID1);
							var reverseLink = currentWordID2 == ds_grid_get(linkGrid, linkGrid_colSource, linkGridY);
							var arrowX = lineX2 + (currentWordStringWidth2 / 2);
							var arrowY = lineY2 - (currentWordStringHeight1/2) - 10;
							if(reverseLink) {
								arrowAngle += 180;	
								arrowX = lineX1 + (currentWordStringWidth1 / 2);
								arrowY = lineY1 + (currentWordStringHeight1/2) + 10;
							}
							draw_sprite_ext(spr_linkArrow, 1, arrowX, arrowY, arrowSize, arrowSize, arrowAngle, currentChainColor, 1);
						}
					
					}
				}
			}
		}
	
	
		// get X,Y position of where pickwhip to mouse should start
		if (ds_grid_get(trackChainGrid, chainGrid_colChainState, rowInChainGrid) == chainStateFocus and not obj_control.gridView) {	
			if (mouseLineWordID >= 0 && (mouseLineWordID - 1) < ds_grid_height(obj_control.wordGrid)) {
				var mouseLineWordLineID = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayRow, mouseLineWordID - 1);
				//var mouseLineWordGridIndex = ds_grid_value_y(obj_control.currentActiveLineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, activeLineGridHeight, mouseLineWordUnitID);
			
				var mouseLineWordStringWidth = string_width(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, mouseLineWordID - 1));
				var mouseLineWordStringHeight = string_height(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, mouseLineWordID - 1));
				var currentHitGridIndexPickWhip = ds_grid_value_y(obj_control.hitGrid, obj_control.hitGrid_colWordID, 0, obj_control.hitGrid_colWordID, ds_grid_height(obj_control.hitGrid)-1, mouseLineWordID);
			
				if (mouseLineWordLineID > -1 and mouseLineWordLineID < activeLineGridHeight) {
						if (obj_control.searchGridActive) {
							mouseLineX = ds_grid_get(obj_control.hitGrid, obj_control.hitGrid_colPixelX, currentHitGridIndexPickWhip) + (mouseLineWordStringWidth / 2);
						}
						else {
							mouseLineX = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, mouseLineWordID - 1) + (mouseLineWordStringWidth / 2);
						}			
					mouseLineY = ds_grid_get(obj_control.currentActiveLineGrid, obj_control.lineGrid_colPixelY, mouseLineWordLineID) + (mouseLineWordStringHeight / 2);
				}
			}
		}
	
	
	
		var isAligned = ds_grid_get(trackChainGrid, chainGrid_colAlign, rowInChainGrid);
		scr_alignChain(currentWordIDList, isAligned);
	
	}

	// draw pickwhip line to mouse
	if (not (mouseLineX == undefined or mouseLineY == undefined)) {
		if (ds_grid_value_exists(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.trackChainGrid), obj_chain.chainStateFocus)) {
			var rowInChainGrid = ds_grid_value_y(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.trackChainGrid), obj_chain.chainStateFocus);
			currentChainColor = ds_grid_get(obj_chain.trackChainGrid, obj_chain.chainGrid_colColor, rowInChainGrid);
			draw_set_color(currentChainColor);
		
			if (not mouseLineHide) {
				scr_drawCurvedLine(mouseLineX, mouseLineY, mouse_x, mouse_y, currentChainColor);
				if(obj_chain.showChainArrows) {
					var arrowAngle = point_direction(mouseLineX, mouseLineY, mouse_x, mouse_y);
					draw_sprite_ext(spr_linkArrow, 1, mouse_x, mouse_y, arrowSize, arrowSize, arrowAngle, currentChainColor, 1);
				}
			}
		}
	}



	scr_unfocusOtherChains(obj_toolPane.toolTrackBrush);


}
