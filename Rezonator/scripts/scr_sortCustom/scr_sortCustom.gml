// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_sortCustom(chainID){
	
	var chainSubMap = global.nodeMap[? chainID];
	var setIDList = chainSubMap[? "setIDList"];
	var customSetIDList = chainSubMap[? "customSetIDList"];
	
	var setIDListSize = ds_list_size(setIDList);
	var tempGrid = ds_grid_create(2, setIDListSize);
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
		show_debug_message("currentEntryToken: " + string(currentEntryToken) + ", fieldIndex: " + string(fieldIndex));
		
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
			currentVal = currentEntryTagMap[? field];
		}
		
		show_debug_message("currentVal: " + string(currentVal));
		if (!is_string(currentVal) && !is_numeric(currentVal)) currentVal = "";

		tempGrid[# tempGrid_colID, i] = currentEntry;
		tempGrid[# tempGrid_colVal, i] = currentVal;
	}
	
	// sort the tempgrid
	ds_grid_sort(tempGrid, tempGrid_colVal, obj_control.chain1toManyCustomSortAscTrack);
	
	// refill the customSetIDList
	if (scr_isNumericAndExists(customSetIDList, ds_type_list)) {
		ds_list_clear(customSetIDList);
		for (var i = 0; i < setIDListSize; i++) {
			ds_list_add(customSetIDList, tempGrid[# tempGrid_colID, i]);
		}
	}
	
	// we don't need the tempGrid anymore
	ds_grid_destroy(tempGrid);
	
	
}