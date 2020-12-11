/*
	scr_prevWordInSequence();
	
	Last Updated: 2019-07-05
	
	Called from: obj_chain
	
	Purpose: return the previous word within the word sequence
	
	Mechanism: Step backwards through the current unit's wordIDList. If the current word is first in that list, 
	loop through previous units to get the end of their wordIDList.
				
	Author: Georgio Klironomos
*/
function scr_prevWordInSequence(currentWordID) {
	

	var previousWordID = undefined;
	if (currentWordID - 2 < 0) {
		return -1;
	}

	// find currentWordID in unit's wordIDList
	var displayRow = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayRow, currentWordID - 1);
	var lineWordIDList = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colWordIDList, displayRow);
	var currentWordIDIndex = ds_list_find_index(lineWordIDList, currentWordID);
	

	// if this word cannot be found in this line, return -1
	if (currentWordIDIndex < 0) {
		
		return -1;
	}
	else if (currentWordIDIndex == 0) {	
		// if this is the first word in the line, and the first line in the discourse, return -1
		if (displayRow == 0) {
			return -1;
		}
		
		// if this is the first word in the line, but not the first line in the discourse, we will loop
		// backwards until we find the previous line's last word
		var loopDisplayRow = displayRow - 1;
		while (previousWordID == undefined) {
			var loopLineWordIDList = ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colWordIDList, displayRow);
			// if this line has a wordIDList that is not empty, we will return the last wordID in it. otherwise keep looping backwards
			if (ds_list_size(loopLineWordIDList) > 0) {
				previousWordID = ds_list_find_value(loopLineWordIDList, ds_list_size(loopLineWordIDList) - 1);
				return previousWordID;
			}
			else {
				displayRow--;	
			}
		}
	}
	else {
		// if this is NOT the first word in the line, just look at the current line's wordIDList
		previousWordID = ds_list_find_value(lineWordIDList, currentWordIDIndex - 1);
		return previousWordID;
	}


}
