/*
	scr_alignChain(wordIDList, pushOut);
	
	Last Updated: 2019-01-29
	
	Called from: obj_chain
	
	Purpose: perform alignment process on chain
	
	Mechanism: get display column of aligned words and set all words to the maximum display column
	
	Author: Terry DuBois
*/


var wordIDList = argument0;
var pushOut = argument1;

var furthestDisplayCol = 0;

var unitIDList = ds_list_create();
var nonVoidWordExists = false;

if (ds_list_size(wordIDList) > 0) {
	
	// find which word in this chain is the furthest to the right (largest display column)
	var furthestWordID = ds_list_find_value(wordIDList, 0);
	for (var displayColLoop = 0; displayColLoop < ds_list_size(wordIDList); displayColLoop++) {
		var currentWordID = ds_list_find_value(wordIDList, displayColLoop);
		
		var currentWordAligned = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colAligned, currentWordID - 1);
		var currentUnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWordID - 1);
		
		// if we only care about the first word for each unitID (to take care of side links)
		if (ds_list_find_index(unitIDList, currentUnitID) > -1) {
			if (ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colVoid, currentWordID - 1) > 0) {
				var currentWordDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1);
				var previousWordID = currentWordID - 1;
				var previousUnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, previousWordID - 1);
				if (currentUnitID == previousUnitID) {
					var previousDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, previousWordID - 1);
					if ((currentWordDisplayCol - previousDisplayCol) > 1) {
						ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1, currentWordDisplayCol - 1);
					}
				}
			}
			continue;
		}
		ds_list_add(unitIDList, currentUnitID);
		
		var currentVoid = 0;
		var currentDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1);
		var currentWordSeq = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentWordID - 1);
		var previousDisplayCol = -1;
		if (currentWordSeq == 0 or currentWordID - 2 < 0) {
			currentVoid = currentDisplayCol;
		}
		else {
			previousDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 2);
			currentVoid = abs(currentDisplayCol - (previousDisplayCol + 1));
		}
		ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colVoid, currentWordID - 1, currentVoid);
		
		// check if this is the new furthest word
		if (currentDisplayCol > furthestDisplayCol and currentWordAligned) {
			furthestWordID = currentWordID;
			furthestDisplayCol = currentDisplayCol;
		}
		
		// if this word is floating out in space with no reason, we bring it left
		if ((not pushOut and currentVoid > 0) or (not currentWordAligned and currentVoid > 0)) {
			ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1, currentDisplayCol - 1);
			currentVoid = abs(currentDisplayCol - (previousDisplayCol + 1));
			ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colVoid, currentWordID - 1, currentVoid);
		}
		
		
		if (not currentWordAligned or (not pushOut and currentVoid > 0)) {
			continue;
		}
		
		if (currentVoid < 1) {
			nonVoidWordExists = true;
		}

	}
		
	//furthestDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, furthestWordID - 1);
	var unitIDList2 = ds_list_create();
	for (var setDisplayColLoop = 0; setDisplayColLoop < ds_list_size(wordIDList); setDisplayColLoop++) {
		var currentWordID = ds_list_find_value(wordIDList, setDisplayColLoop);
		var currentUnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWordID - 1);
		
		if (not ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colAligned, currentWordID - 1)) {
			
			continue;
		}
		
		var currentRowInLineGrid = ds_grid_value_y(obj_control.lineGrid, obj_control.lineGrid_colUnitID, 0, obj_control.lineGrid_colUnitID, ds_grid_height(obj_control.lineGrid), currentUnitID);
		if (currentRowInLineGrid >= 0 and currentRowInLineGrid < ds_grid_height(obj_control.lineGrid)) {
			if (ds_grid_get(obj_control.lineGrid, obj_control.lineGrid_colVoidMax, currentRowInLineGrid) >= obj_control.voidLimit) {
				continue;
			}
		}
		
		
		// catch the race-to-infinity: mark as stretch if we are moving the most recently moved word more than once in a row
		if (ds_list_find_index(unitIDList2, currentUnitID) == -1) {
			ds_list_add(unitIDList2, currentUnitID);
			if (pushOut) {
				var currentDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1);
				if (currentWordID == obj_control.mostRecentlyAddedWord and furthestDisplayCol > currentDisplayCol) {
					if (obj_control.mostRecentlyAddedWordMoved) {
						ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colAligned, currentWordID - 1, false);
						ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colStretch, currentWordID - 1, true);
						
					}
					else {
						obj_control.mostRecentlyAddedWordMoved = true;
						if (not obj_control.alarmRecentlyAddedWordMovedTriggered) {
							obj_control.alarmRecentlyAddedWordMovedTriggered = true;
							with (obj_control) {
								alarm[2] = 5;
							}
						}
						ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1, furthestDisplayCol);
					}
				}
				else {
					ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1, furthestDisplayCol);
				}
			}
		}
		
	}
	ds_list_destroy(unitIDList2);
}

// if every word in this chain has a void, we need to bring every word in the chain back
if (not nonVoidWordExists) {
	for (var i = 0; i < ds_list_size(wordIDList); i++) {
		var currentWordID = ds_list_find_value(wordIDList, i);
		var currentVoid = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colVoid, currentWordID - 1);
		if (currentVoid <= 0) {
			continue;
		}
		
		var currentDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1);
		var currentUnitID = ds_grid_get(obj_control.dynamicWordGrid, obj_control.wordGrid_colUnitID, currentWordID - 1);

		ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1, currentDisplayCol - 1);
	}
}

ds_list_destroy(unitIDList);