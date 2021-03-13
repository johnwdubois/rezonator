/*
	Purpose: perform alignment process on chain
*/
function scr_alignChain(setIDList, pushOut) {
	
	var furthestDisplayCol = 0;

	var displayRowList = ds_list_create();
	var nonVoidWordExists = false;
	var setIDListSize = ds_list_size(setIDList);

	if (setIDListSize > 0) {
	
		// find which word in this chain is the furthest to the right (largest display column)
		var firstEntry = ds_list_find_value(setIDList, 0);
		var firstEntrySubMap = ds_map_find_value(global.nodeMap, firstEntry);
		var furthestWordID = ds_map_find_value(firstEntrySubMap, "word");
		
		for (var displayColLoop = 0; displayColLoop < setIDListSize; displayColLoop++) {
			
			var currentEntry = ds_list_find_value(setIDList, displayColLoop);
			var currentEntrySubMap = ds_map_find_value(global.nodeMap, currentEntry);
			var currentWordID = ds_map_find_value(currentEntrySubMap, "word");
		
			// Prevent dead or chunk words to mess with alignment
			var wordState = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentWordID - 1);
			if (wordState == obj_control.wordStateDead or wordState == obj_control.wordStateChunk) {
				continue;
			}
		
			var currentWordAligned = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colAligned, currentWordID - 1);
			var currentDisplayRow = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayRow, currentWordID - 1);
		
			// Access the previous word in sequence
			var previousWordID = scr_prevWordInSequence(currentWordID);
		
			// if we only care about the first word for each unitID (to take care of side links)
			if (ds_list_find_index(displayRowList, currentDisplayRow) > -1) {
				if (ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colVoid, currentWordID - 1) > 0) {
					var currentWordDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1);
				
					var previousDisplayRow = ds_grid_get(obj_control.wordGrid, obj_control.dynamicWordGrid_colDisplayRow, previousWordID - 1);
					if (currentDisplayRow == previousDisplayRow) {
						var previousDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, previousWordID - 1);
						if ((currentWordDisplayCol - previousDisplayCol) > 1) {
							ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1, currentWordDisplayCol - 1);
						}
					}
				}
				continue;
			}
			ds_list_add(displayRowList, currentDisplayRow);
		
			// Set the word's void according to the previous word's void
			var currentVoid = 0;
			var currentDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1);
			var currentWordSeq = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentWordID - 1);
			var previousDisplayCol = -1;

			if (currentWordSeq == 0 or previousWordID - 1 < 0) {
				currentVoid = currentDisplayCol;
			}
			else {
				previousDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, previousWordID - 1);
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
		var displayRowList2 = ds_list_create();
		for (var setDisplayColLoop = 0; setDisplayColLoop < setIDListSize; setDisplayColLoop++) {
			
			var currentEntry = ds_list_find_value(setIDList, setDisplayColLoop);
			var currentEntrySubMap = ds_map_find_value(global.nodeMap, currentEntry);
			var currentWordID = ds_map_find_value(currentEntrySubMap, "word");
			var currentDisplayRow = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayRow, currentWordID - 1);
		
			if (not ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colAligned, currentWordID - 1)) {
				continue;
			}
		
			// Prevent dead or chunk words to mess with alignment
			var wordState = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentWordID - 1);
			if (wordState == obj_control.wordStateDead or wordState == obj_control.wordStateChunk) {
				continue;
			}
			

			var currentRowInLineGrid = currentDisplayRow;
		
		
			// catch the race-to-infinity: mark as stretch if we are moving the most recently moved word more than once in a row
			if (ds_list_find_index(displayRowList2, currentDisplayRow) == -1) {
				ds_list_add(displayRowList2, currentDisplayRow);
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
								//show_message("triggering alarm: alignChain");
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
		ds_list_destroy(displayRowList2);
	}

	// if every word in this chain has a void, we need to bring every word in the chain back
	if (not nonVoidWordExists) {
		for (var i = 0; i < setIDListSize; i++) {
			
			var currentEntry = ds_list_find_value(setIDList, i);
			var currentEntrySubMap = ds_map_find_value(global.nodeMap, currentEntry);
			var currentWordID = ds_map_find_value(currentEntrySubMap, "word");
			var currentVoid = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colVoid, currentWordID - 1);
			if (currentVoid <= 0) {
				continue;
			}
		
			var currentDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1);

			ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1, currentDisplayCol - 1);
		}
	}

	ds_list_destroy(displayRowList);


}
