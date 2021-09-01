// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_discourseSort(tokenList){
	var dummyList = ds_list_create();
	// get set list from chain
	var tokenListSize = ds_list_size(tokenList);

	
	// make a temp grid that we can sort
	var tempGrid_colTokenID = 0;
	var tempGrid_colUnitSeq = 1;
	var tempGrid_colWordOrder = 2;
	var tempGrid = ds_grid_create(3, tokenListSize);
	
	// loop down set list and put them entries in the tempGrid
	for (var i = 0; i < tokenListSize; i++) {
		// get word info from this entry
		var currentToken = tokenList[| i];
		var currentTokenSubMap = global.nodeMap[? currentToken];
		if (!scr_isNumericAndExists(currentTokenSubMap, ds_type_map)) continue;
		
		var currentWordID = -1;
		var currentUnitSeq = -1;
		var currentWordOrder = -1;
			
			
		var currentUnitSubMap = currentTokenSubMap[? "unit"];   
		if(scr_isNumericAndExists(currentUnitSubMap, ds_type_map)){
			currentUnitSeq = currentUnitSubMap[?"unitSeq"];//= ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWordID - 1);
		}

		currentWordOrder = currentTokenSubMap[? "docTokenSeq"];//= ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentWordID - 1);

	
		
		// set values in tempGrid
		ds_grid_set(tempGrid, tempGrid_colTokenID, i, currentToken);
		ds_grid_set(tempGrid, tempGrid_colUnitSeq, i, currentUnitSeq);
		ds_grid_set(tempGrid, tempGrid_colWordOrder, i, currentWordOrder);
	}
	
	// sort the tempGrid!!!
	scr_gridMultiColSort(tempGrid, tempGrid_colUnitSeq, true, tempGrid_colWordOrder, true);

	var gridHeight = ds_grid_height(tempGrid);

	for (var i = 0; i < gridHeight; i++) {
		ds_list_add(dummyList, tempGrid[# tempGrid_colTokenID, i]);
	}

	ds_list_clear(tokenList);
	ds_list_copy(tokenList, dummyList);

	// we dont need tempGrid anymore
	ds_grid_destroy(tempGrid);
	ds_list_destroy(dummyList);

	return tokenList;
}