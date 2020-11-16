function scr_wordVoid(currentWordDisplayCol, previousWordDisplayCol, currentWordGridRow, currentWordID) {
	// Check and set the void of the current word

	var currentWordVoid = abs(currentWordDisplayCol - (previousWordDisplayCol + 1));
	ds_grid_set(dynamicWordGrid, dynamicWordGrid_colVoid, currentWordGridRow, currentWordVoid);
		
		 
	if (currentWordDisplayCol - previousWordDisplayCol > 1) {
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
	
		return currentWordDisplayCol;
	}


}
