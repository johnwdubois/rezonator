// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_handleVoid(setList) {
	
	if (!scr_isNumericAndExists(setList, ds_type_list)) exit;
	
	var setListSize = ds_list_size(setList);
	var smallVoidExists = false;
	var displayRowList = ds_list_create();
	var sideLinkList = ds_list_create();
						
	// check to see if the chain has any voids < 1
	for (var j = 0; j < setListSize; j++) {
		var currentEntry = setList[| j];
		var currentEntrySubMap = global.nodeMap[? currentEntry];
		if (!scr_isNumericAndExists(currentEntrySubMap, ds_type_map)) continue;
		var currentStretch = currentEntrySubMap[? "stretch"];
		if (currentStretch) continue;
		var currentWordID = currentEntrySubMap[? "word"];
		if (scr_isChunk(currentWordID)) currentWordID = scr_getFirstWordOfChunk(currentWordID);
		
		var currentDisplayRow = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayRow, currentWordID - 1);
		if (ds_list_find_index(displayRowList, currentDisplayRow) == -1) {
			ds_list_add(displayRowList, currentDisplayRow);
			var currentVoid = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colVoid, currentWordID - 1);
			if (currentVoid <= 1) smallVoidExists = true;
		}
		else {
			ds_list_add(sideLinkList, currentWordID);
		}
	}
	
						
	if (!smallVoidExists) {
		for (var j = 0; j < setListSize; j++) {
			var currentEntry = setList[| j];
			var currentEntrySubMap = global.nodeMap[? currentEntry];
			if (!scr_isNumericAndExists(currentEntrySubMap, ds_type_map)) continue;
			
			var currentWordID = currentEntrySubMap[? "word"];
			if (scr_isChunk(currentWordID)) currentWordID = scr_getFirstWordOfChunk(currentWordID);
			
			var currentDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1);
			currentDisplayCol--;
			ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1, currentDisplayCol);
		}
	}
	else {
		// if there are any side links still hanging out in space, bring them back
		var sideLinkListSize = ds_list_size(sideLinkList);
		for (var j = 0; j < sideLinkListSize; j++) {
			var currentWordID = sideLinkList[| j];
			var currentVoid = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colVoid, currentWordID - 1);
			if (currentVoid > 1) {
				var currentDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1);
				currentDisplayCol--;
				ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, currentWordID - 1, currentDisplayCol);
			}							
		}
	}
						
	ds_list_destroy(displayRowList);
	ds_list_destroy(sideLinkList);

}