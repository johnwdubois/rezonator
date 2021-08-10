// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_sortCustom(chainID){
	
	var chainSubMap = global.nodeMap[? chainID];
	if (!scr_isNumericAndExists(chainSubMap, ds_type_map)) exit;
	
	var asc = obj_control.chain1toManyCustomSortAsc;
	
	var chainType = chainSubMap[? "type"];
	var setIDList = chainSubMap[? "setIDList"];
	var customSetIDList = chainSubMap[? "customSetIDList"];
	
	var setIDListSize = ds_list_size(setIDList);
	var tempStrGrid = ds_grid_create(2, 0);
	var tempDigitGrid = ds_grid_create(2, 0);
	var tempGrid_colID = 0;
	var tempGrid_colVal = 1;
	
	var fieldIndex = obj_control.chain1toManyCustomSortColIndex;
	var fieldList = -1;
	with (obj_panelPane) {
		if (currentFunction == functionChainList) {
			if (functionChainList_currentTab == functionChainList_tabRezBrush) {
				fieldList = obj_control.chain1toManyColFieldListRez;
			}
			else if (functionChainList_currentTab == functionChainList_tabTrackBrush) {
				fieldList = obj_control.chain1toManyColFieldListTrack;
			}
			else if (functionChainList_currentTab == functionChainList_tabStackBrush) {
				fieldList = obj_control.chain1toManyColFieldListStack;
			}
		}
	}
	if (!scr_isNumericAndExists(fieldList, ds_type_list)) exit;

	

	
	// fill up temp grid with the entry IDs and the values you want to sort
	for (var i = 0; i < setIDListSize; i++) {
		
		// get all the nodes/maps/stuff that we will need to gather the values we want to sort
		var currentEntry = setIDList[| i];
		var currentEntrySubMap = global.nodeMap[? currentEntry];
		var currentEntryTagMap = currentEntrySubMap[? "tagMap"];
		var currentEntryToken = (chainType == "stackChain") ? currentEntrySubMap[? "unit"] : currentEntrySubMap[? "token"];
		var currentChunk = false;
		if (chainType != "stackChain") {
			currentChunk = (scr_isChunk(currentEntryToken)) ? currentEntryToken : "";
			if (currentChunk != "") {currentEntryToken = scr_getFirstWordOfChunk(currentEntryToken)}
		}
		var currentEntryTokenSubMap = global.nodeMap[? currentEntryToken];
		var currentEntryTokenSeq = currentEntryTokenSubMap[? "tokenSeq"];
		var currentEntryUnit = (chainType == "stackChain") ? currentEntryToken : currentEntryTokenSubMap[? "unit"];
		var currentEntryUnitSubMap = global.nodeMap[? currentEntryUnit];
		var currentEntryUnitTagMap = currentEntryUnitSubMap[? "tagMap"];
		var currentEntryUnitSeq = currentEntryUnitSubMap[? "unitSeq"];
		var currentEntryTokenTagMap = currentEntryTokenSubMap[? "tagMap"];

		var currentVal = -1;
		
		// get value to sort
		if (fieldIndex == 0) {
			currentVal = currentEntryUnitSeq;
		}
		else if (fieldIndex == 1) {
			currentVal = (chainType == "stackChain") ? currentEntryUnitTagMap[? global.speakerField] : currentEntryTokenSeq;
		}
		else if (fieldIndex == 2) {
			if (chainType == "stackChain") {
				currentVal = scr_getUnitText(currentEntryUnitSubMap);
			}
			else {
				if (currentChunk != "") currentVal = scr_getChunkText(currentChunk);
				else currentVal = currentEntryTokenTagMap[? global.displayTokenField];
			}
		}
		else {
			var field = fieldList[| fieldIndex - 3];

			if (ds_map_exists(currentEntryTagMap, field)) {
				currentVal = currentEntryTagMap[? field];
				show_debug_message("currentVal found in tagmap, currentVal: " + string(currentVal));
				
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
	
	// sort the tempGrids based on their value columns
	ds_grid_sort(tempStrGrid, tempGrid_colVal, asc);
	ds_grid_sort(tempDigitGrid, tempGrid_colVal, asc);
	
	
	
	// refill the customSetIDList
	if (scr_isNumericAndExists(customSetIDList, ds_type_list)) {
		ds_list_clear(customSetIDList);
		
		var tempStrGridHeight = ds_grid_height(tempStrGrid);
		var tempDigitGridHeight = ds_grid_height(tempDigitGrid);
		
		// if sort is ascending, sort the strings first, otherwise sort the digits first
		if (asc) {
			for (var i = 0; i < tempStrGridHeight; i++) {
				ds_list_add(customSetIDList, tempStrGrid[# tempGrid_colID, i]);
			}
			for (var i = 0; i < tempDigitGridHeight; i++) {
				ds_list_add(customSetIDList, tempDigitGrid[# tempGrid_colID, i]);
			}
		}
		else {
			for (var i = 0; i < tempDigitGridHeight; i++) {
				ds_list_add(customSetIDList, tempDigitGrid[# tempGrid_colID, i]);
			}
			for (var i = 0; i < tempStrGridHeight; i++) {
				ds_list_add(customSetIDList, tempStrGrid[# tempGrid_colID, i]);
			}
		}
	}

	
	// we don't need the tempGrids anymore
	ds_grid_destroy(tempStrGrid);
	ds_grid_destroy(tempDigitGrid);
	
	
}