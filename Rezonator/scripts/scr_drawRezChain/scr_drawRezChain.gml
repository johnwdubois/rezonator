function scr_drawRezChain() {
	/*
		scr_drawRezChain();
	
		Last Updated: 2018-07-12
	
		Called from: obj_chain
	
		Purpose: draw rezChains and move words on screen according to the rezChains
	
		Mechanism: loop through each row in rezChainGrid, get the wordIDList from each chain, and draw lines
					from word information
				
		Author: Terry DuBois
	*/

	if (not obj_chain.toggleDrawRez) {
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

	var minWordWidth = 9999999;
	var linePlusX = 0;

	var currentWordStringHeight1 = string_height("0");
	var currentWordStringHeight2 = currentWordStringHeight1;

	var wordTopMargin = obj_control.wordTopMargin;
	var rezChainGridHeight = ds_grid_height(rezChainGrid);
	var activeLineGridHeight = ds_grid_height(obj_control.currentActiveLineGrid);
	var linkGridHeight = ds_grid_height(linkGrid);
	var arrowSize = 0.3 + (0.1 * global.fontSize/5);

	// loop through rezChainGrid to get chain info
	var chainShowListSize = ds_list_size(chainShowList);
	for (var i = 0; i < chainShowListSize; i++) {
		minWordWidth = 9999999;
	
		var currentChainID = ds_list_find_value(chainShowList, i);

		var rowInChainGrid = ds_grid_value_y(rezChainGrid, chainGrid_colChainID, 0, chainGrid_colChainID, rezChainGridHeight, currentChainID);
		if (rowInChainGrid < 0 or rowInChainGrid >= rezChainGridHeight) {
			continue;
		}
	
		var currentWordIDList = ds_grid_get(rezChainGrid, chainGrid_colWordIDList, rowInChainGrid);
		var currentChainColor = ds_grid_get(rezChainGrid, chainGrid_colColor, rowInChainGrid);
		var currentChainShow = true;
		
		if (!is_numeric(currentWordIDList)) {
			continue;
		}
		if (!ds_exists(currentWordIDList, ds_type_list)) {
			continue;
		}
	
		// find minimum word width so we know the X position of the chain
		var currentWordIDListSize = ds_list_size(currentWordIDList);
		for (var j = 0; j < currentWordIDListSize; j++) {
			var currentWordID = ds_list_find_value(currentWordIDList, j);
			var currentWordWidth = string_width(string(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordID - 1))) / 2;
			currentWordWidth = max(currentWordWidth, 0);
		
			if (currentWordWidth < minWordWidth)
			{
				minWordWidth = currentWordWidth;
				linePlusX = minWordWidth;
			}
		}
	
		var wordsInSameLine = false;
		var firstWordInLine = -1;
	
		// loop through current chain's wordIDList to draw the lines of the chain
		for (var j = 0; j < currentWordIDListSize - 1; j++) {
			var currentWordID1 = ds_list_find_value(currentWordIDList, j);
			var currentWordID2 = ds_list_find_value(currentWordIDList, j + 1);
		
			var currentLineID1 = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayRow, currentWordID1 - 1);
			//var currentLineGridIndex1 = ds_grid_value_y(obj_control.currentActiveLineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, activeLineGridHeight, currentUnitID1);
			var chunkWord1 = (ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentWordID1 - 1) == obj_control.wordStateChunk);
			//Add a nesting check
		
			var currentWordStringWidth1 = string_width(string(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordID1 - 1)));
		
			lineX1 = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, currentWordID1 - 1);
			lineY1 = ds_grid_get(obj_control.currentActiveLineGrid, obj_control.lineGrid_colPixelY, currentLineID1);
		
		
			var currentLineID2 = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayRow, currentWordID2 - 1);
			//var currentLineGridIndex2 = ds_grid_value_y(obj_control.currentActiveLineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, activeLineGridHeight, currentUnitID2);
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
		
			//var currentWordStringWidth2 = string_width(string(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordID2 - 1)));
		
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
				if(chunkWord2) {
					var wordRectBuffer = 15;
					lineY2 -= (wordRectBuffer);
				}
			
				if (currentChainShow) {
					draw_set_color(currentChainColor);
					draw_set_alpha(1);
					if(chunkWord2) {
						draw_line_width(lineX1 + linePlusX, lineY1 + (currentWordStringHeight1 / 2), lineX2 + linePlusX, lineY2 - (currentWordStringHeight2 / 2), 2);
						if(obj_control.shape == obj_control.shapeBlock) {
							var lineDist = point_distance(lineX1 + linePlusX, lineY1 + (currentWordStringHeight1 / 2), lineX2 + linePlusX, lineY2 - (currentWordStringHeight2 / 2));
							var arrowAngle = point_direction(lineX1 + linePlusX, lineY1 + (currentWordStringHeight1 / 2), lineX2 + linePlusX, lineY2 - (currentWordStringHeight2 / 2));
							if(lineDist > 30 and obj_chain.showChainArrows) {
								//calculate the direciton of the arrow
								var linkGridY = ds_grid_value_y(linkGrid, linkGrid_colGoal, 0, linkGrid_colGoal, linkGridHeight, currentWordID1);
								var reverseLink = currentWordID2 == ds_grid_get(linkGrid, linkGrid_colSource, linkGridY);
								var arrowX = lineX2 + linePlusX;
								var arrowY = lineY2 - (currentWordStringHeight2 / 2) - 8;
								if(reverseLink) {
									arrowAngle += 180;	
									arrowX = lineX1 + linePlusX;
									arrowY = lineY1 + (currentWordStringHeight1/2) + 10;
									if(sideLink) {
										//arrowAngle += 270;	
										arrowX = lineX1 +10+ string_width(string(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordID1 - 1)));
										arrowY = lineY1 + (currentWordStringHeight2 / 2);
									}
								}
								else if(sideLink) {
									//arrowAngle += 180;	
									arrowX = lineX2 - 10;
									arrowY = lineY2 + (currentWordStringHeight2 / 2);	
								}
								draw_sprite_ext(spr_linkArrow, 1, arrowX, arrowY, arrowSize, arrowSize, arrowAngle, currentChainColor, 1);
							}
						}
					}
					else {
						// Draw the link line
						draw_line_width(lineX1 + linePlusX, lineY1 + (currentWordStringHeight1 / 2), lineX2 + linePlusX, lineY2 + (currentWordStringHeight2 / 2), 2);
						// Calculate and draw the link arrows
						if(obj_control.shape == obj_control.shapeBlock) {
							var lineDist = point_distance(lineX1 + linePlusX, lineY1 + (currentWordStringHeight1 / 2), lineX2 + linePlusX, lineY2 + (currentWordStringHeight2 / 2));
							var arrowAngle = point_direction(lineX1 + linePlusX, lineY1 + (currentWordStringHeight1 / 2), lineX2 + linePlusX, lineY2 + (currentWordStringHeight2 / 2));
							if(lineDist > 30 and obj_chain.showChainArrows) {
								//calculate the direciton of the arrow
								var linkGridY = ds_grid_value_y(linkGrid, linkGrid_colGoal, 0, linkGrid_colGoal, linkGridHeight, currentWordID1);
								var reverseLink = currentWordID2 == ds_grid_get(linkGrid, linkGrid_colSource, linkGridY);
								var arrowX = lineX2 + linePlusX;
								var arrowY = lineY2 - (currentWordStringHeight2 / 2) - 8;
								if(reverseLink) {
									arrowAngle += 180;	
									arrowX = lineX1 + linePlusX;
									arrowY = lineY1 + (currentWordStringHeight1/2) + 10;
									if(sideLink) {
										//arrowAngle += 270;	
										arrowX = lineX1 +10+ string_width(string(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordID1 - 1)));
										arrowY = lineY1 + (currentWordStringHeight2 / 2);
									}
								}
								else if(sideLink) {
									//arrowAngle += 180;	
									arrowX = lineX2 - 10;
									arrowY = lineY2 + (currentWordStringHeight2 / 2);	
								}
								draw_sprite_ext(spr_linkArrow, 1, arrowX, arrowY, arrowSize, arrowSize, arrowAngle, currentChainColor, 1);
							}
					
					
						}
					}
				}
				// I need to modify this with the Chunk's wordRectBuffer
				chunkWord2 = 0;
			}
		}
	
	
	
		if (ds_grid_get(rezChainGrid, chainGrid_colChainState, rowInChainGrid) == chainStateFocus) {	
			if (mouseLineWordID >= 0 && (mouseLineWordID - 1) < ds_grid_height(obj_control.wordGrid)) {
				var mouseLineWordDisplayRow = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayRow, mouseLineWordID - 1);
				//var mouseLineWordGridIndex = ds_grid_value_y(obj_control.currentActiveLineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, activeLineGridHeight, mouseLineWordUnitID);
			
				//if (mouseLineWordGridIndex > -1 and mouseLineWordGridIndex < ds_grid_height(obj_control.currentActiveLineGrid
				//and mouseLineWordID > -1 and mouseLineWordID < ds_grid_height(obj_control.wordGrid))) {
			
					var mouseLineWordStringWidth = string_width(string(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, mouseLineWordID - 1)));
					var mouseLineWordStringHeight = string_height(string(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, mouseLineWordID - 1)));
					var wordPixelX = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colPixelX, mouseLineWordID - 1);
					var wordPixelY =ds_grid_get(obj_control.currentActiveLineGrid, obj_control.lineGrid_colPixelY, mouseLineWordDisplayRow);
					
					if(wordPixelX != undefined and wordPixelY !=undefined){
						mouseLineX =  wordPixelX + (mouseLineWordStringWidth / 2);
						mouseLineY =  wordPixelY + (mouseLineWordStringHeight / 2);
					}
				//}
			
			}
		}
	
	
		var isAligned = ds_grid_get(rezChainGrid, chainGrid_colAlign, rowInChainGrid);
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
			
				if (currentChainShow) {
					if (not mouseLineHide) {
						draw_line_width(mouseLineX, mouseLineY, mouse_x, mouse_y, 2);
						if(obj_chain.showChainArrows) {
							var arrowAngle = point_direction(mouseLineX, mouseLineY, mouse_x, mouse_y);
							draw_sprite_ext(spr_linkArrow, 1, mouse_x, mouse_y, arrowSize, arrowSize, arrowAngle, currentChainColor, 1);
						}
					}
				}
			}
		}
	}

	scr_unfocusOtherChains(obj_toolPane.toolRezBrush);


}
