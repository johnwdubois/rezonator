/*
	Purpose: return the previous word within the word sequence
*/
function scr_prevWordInSequence(currentWordID) {
	

	var previousWordID = undefined;
	if (currentWordID <= 0) {
		return -1;
	}

	// find currentWordID in unit's wordIDList
	var displayRow = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayRow, currentWordID - 1);
	var lineWordIDList = ds_grid_get(obj_control.currentActiveLineGrid, obj_control.lineGrid_colWordIDList, displayRow);
	var currentWordIDIndex = ds_list_find_index(lineWordIDList, currentWordID);

	// if this word cannot be found in this line, or if this is the first word in the line, return -1
	if (currentWordIDIndex <= 0) {
		return -1;
	}
	else {
		// if this is NOT the first word in the line, just look at the current line's wordIDList
		previousWordID = lineWordIDList[| currentWordIDIndex - 1];
		return previousWordID;
	}

}
