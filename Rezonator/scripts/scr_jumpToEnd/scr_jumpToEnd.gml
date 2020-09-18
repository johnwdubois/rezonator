function scr_jumpToEnd(argument0) {
	/*
		scr_jumpToEnd(jumpToStart);
	
		Last Updated: 2019-12-27
	
		Called from: obj_control
	
		Purpose: Send the user to the last or first word of the currentCenterDisplayRow line (obsolete?)
	
		Mechanism: gather the wordIDList of the center line, and jump to the display column of the first/last word
	
		Author: ?
	*/

	var jumpToStart = argument0;

	// Find the currentCenterDisplayRow
	var rowInLineGrid = ds_grid_value_y(currentActiveLineGrid, obj_control.lineGrid_colDisplayRow, 0, obj_control.lineGrid_colDisplayRow, ds_grid_height(currentActiveLineGrid), obj_control.currentCenterDisplayRow);

	if (rowInLineGrid < 0 or rowInLineGrid >= ds_grid_height(currentActiveLineGrid)) {
		exit;
	}

	var furthestDisplayCol = 0;
	
	for (var currentRow = obj_control.drawRangeStart; currentRow < obj_control.drawRangeEnd; currentRow++) {
		if (currentRow < 0 or currentRow >= ds_grid_height(obj_control.currentActiveLineGrid)) {
			exit;
		}
	
		var wordIDList = ds_grid_get(obj_control.currentActiveLineGrid, obj_control.lineGrid_colWordIDList, currentRow);
		if (ds_list_size(wordIDList) < 1) {
			continue;
		}
		
		if (jumpToStart) {
			var firstWordInList = ds_list_find_value(wordIDList, 0);
			
			if (firstWordInList >= 0 and firstWordInList < ds_grid_height(obj_control.dynamicWordGrid)) {
				var firstWordDisplayCol = ds_grid_get(obj_control.hitGrid, obj_control.hitGrid_colDisplayCol, firstWordInList - 1);
			
				if (firstWordDisplayCol < furthestDisplayCol) {
					furthestDisplayCol = firstWordDisplayCol;
				}
			}
		}
		else {
			var lastWordInList = ds_list_find_value(wordIDList, ds_list_size(wordIDList) - 1);
			var grid = obj_control.dynamicWordGrid;
			var gridCol = obj_control.dynamicWordGrid_colDisplayCol;
			if (obj_control.searchGridActive) {
				grid = obj_control.hitGrid;
				gridCol = obj_control.hitGrid_colDisplayCol;
			}
			
			var lastWordDisplayCol = ds_grid_get(grid, gridCol, lastWordInList - 1);
		
			if (typeof(lastWordDisplayCol) == "number" and typeof(furthestDisplayCol) == "number") {
				if (lastWordDisplayCol > furthestDisplayCol) {
					furthestDisplayCol = lastWordDisplayCol;
				}	
			}
		}
	}



	if (jumpToStart) {
		if (obj_control.searchGridActive) {
			//obj_control.wordLeftMarginDest = -(furthestDisplayCol * obj_control.gridSpaceHorizontal) + (obj_control.gridSpaceHorizontal * 2);
			obj_control.wordLeftMarginDest = -(furthestDisplayCol * obj_control.gridSpaceHorizontal) + ds_list_find_value(obj_control.speakerLabelColXList, ds_list_size(obj_control.speakerLabelColXList) - 1);
		}
		else {
			with (obj_alarm) {
				alarm[0] = 5;
			}
		}
	}
	else {
		if ((furthestDisplayCol) * obj_control.gridSpaceHorizontal + obj_control.wordLeftMarginDest > window_get_width()) {
			obj_control.wordLeftMarginDest -= obj_control.gridSpaceHorizontal;
			alarm[6] = 1;
		}
	}


}
