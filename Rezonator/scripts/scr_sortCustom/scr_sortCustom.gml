// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_sortCustom(chainID){
	
	var chainSubMap = global.nodeMap[? chainID];
	var setIDList = chainSubMap[? "setIDList"];
	var customSetIDList = chainSubMap[? "customSetIDList"];
	
	var setIDListSize = ds_list_size(setIDList);
	var tempStrGrid = ds_grid_create(2, 0);
	var tempDigitGrid = ds_grid_create(2, 0);
	var tempGrid_colID = 0;
	var tempGrid_colVal = 1;
	
	var fieldIndex = obj_control.chain1toManyCustomSortColIndexTrack;
	

	
	// fill up temp grid with the entry IDs and the values you want to sort
	for (var i = 0; i < setIDListSize; i++) {
		
		var currentEntry = setIDList[| i];
		var currentEntrySubMap = global.nodeMap[? currentEntry];
		var currentEntryTagMap = currentEntrySubMap[? "tagMap"];
		var currentEntryToken = currentEntrySubMap[? "token"];
		var currentChunk = (scr_isChunk(currentEntryToken)) ? currentEntryToken : "";
		if (currentChunk != "") {currentEntryToken = scr_getFirstWordOfChunk(currentEntryToken)}

		
		var currentEntryTokenSubMap = global.nodeMap[? currentEntryToken];
		var currentEntryTokenSeq = currentEntryTokenSubMap[? "tokenSeq"];
		
		var currentEntryUnit = currentEntryTokenSubMap[? "unit"];
		var currentEntryUnitSubMap = global.nodeMap[? currentEntryUnit];
		var currentEntryUnitSeq = currentEntryUnitSubMap[? "unitSeq"];
		
		var currentEntryTokenTagMap = currentEntryTokenSubMap[? "tagMap"];
		

		var currentVal = -1;
		
		// get value to sort
		if (fieldIndex == 0) {
			currentVal = currentEntryUnitSeq;
		}
		else if (fieldIndex == 1) {
			currentVal = currentEntryTokenSeq;
		}
		else if (fieldIndex == 2) {
			if (currentChunk != "") currentVal = scr_getChunkText(currentChunk);
			else currentVal = currentEntryTokenTagMap[? global.displayTokenField];
		}
		else {
			var field = obj_control.chain1toManyColFieldListTrack[| fieldIndex - 3];

			if (ds_map_exists(currentEntryTagMap, field)) {
				currentVal = currentEntryTagMap[? field];
				
				if (field == "gapUnits" || field == "gapWords") {
					if (!is_numeric(currentVal)) currentVal = "";
				}
				else if (is_string(currentVal)) {
					
					// if this string is actually just a number, let's treat it as a number in the sort
					var strLen = string_length(currentVal);
					if (strLen >= 1) {
						
						var strDigits = string_digits(currentVal);
						var strLenDigits = string_length(strDigits);
						if (strLenDigits >= 1) {
							if (strLen == strLenDigits) {
								currentVal = real(currentVal);
							}
							else if (strLen == strLenDigits + 1) {
								if (string_char_at(currentVal, 1) == "-") {
									currentVal = -real(strDigits);
								}
							}
						}
					}
				}
			}
			else {
				currentVal = "";
			}			
		}
		
		
		
		if (!is_string(currentVal) && !is_numeric(currentVal)) currentVal = "";
		
		// put the currentVal into either the tempStrGrid or tempDigitGrid
		var grid = (is_string(currentVal)) ? tempStrGrid : tempDigitGrid;
		ds_grid_resize(grid, 2, ds_grid_height(grid) + 1);
		grid[# tempGrid_colID, ds_grid_height(grid) - 1] = currentEntry;
		grid[# tempGrid_colVal, ds_grid_height(grid) - 1] = currentVal;

	}
	
	// sort the tempgrid
	ds_grid_sort(tempStrGrid, tempGrid_colVal, obj_control.chain1toManyCustomSortAscTrack);
	ds_grid_sort(tempDigitGrid, tempGrid_colVal, obj_control.chain1toManyCustomSortAscTrack);
	
	
	// sorted list of values FOR DEBUGGING ONLY
	var sortedValList = ds_list_create();
	
	
	
	// refill the customSetIDList
	if (scr_isNumericAndExists(customSetIDList, ds_type_list)) {
		ds_list_clear(customSetIDList);
		
		var tempStrGridHeight = ds_grid_height(tempStrGrid);
		var tempDigitGridHeight = ds_grid_height(tempDigitGrid);
		
		for (var i = 0; i < tempStrGridHeight; i++) {
			ds_list_add(customSetIDList, tempStrGrid[# tempGrid_colID, i]);
			ds_list_add(sortedValList, tempStrGrid[# tempGrid_colID, i]);
		}
		for (var i = 0; i < tempDigitGridHeight; i++) {
			ds_list_add(customSetIDList, tempDigitGrid[# tempGrid_colID, i]);
			ds_list_add(sortedValList, tempDigitGrid[# tempGrid_colID, i]);
		}
	}
	

	
	// we don't need the tempGrid anymore
	ds_grid_destroy(tempStrGrid);
	ds_grid_destroy(tempDigitGrid);
	ds_list_destroy(sortedValList);
	
	
}