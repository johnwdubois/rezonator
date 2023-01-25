

function scr_sortChainList(chainType, list) {
	
	// sort a list of chains based on their order in the full chain list
	
	var fullList = -1;
	if (chainType == "stack") fullList = global.nodeMap[? "stackList"];
	else if (chainType == "resonance") fullList = global.nodeMap[? "resonanceList"];
	else if (chainType == "trail") fullList = global.nodeMap[? "trailList"];
	
	if (scr_isNumericAndExists(fullList, ds_type_list) && scr_isNumericAndExists(list, ds_type_list)) {
		
		// create temp grid with every chain and its index in the full list
		var listSize = ds_list_size(list);
		var tempGrid = ds_grid_create(2, listSize);
		var tempGrid_colID = 0;
		var tempGrid_colIndex = 1;
		for (var i = 0; i < listSize; i++) {
			var currentID = list[| i];
			tempGrid[# tempGrid_colID, i] = currentID;
			tempGrid[# tempGrid_colIndex, i] = ds_list_find_index(fullList, currentID);
		}
		
		// sort temp grid based on index
		ds_grid_sort(tempGrid, tempGrid_colIndex, true);
	
		// reset list to be in new order
		ds_list_clear(list);
		for (var i = 0; i < listSize; i++) {
			var currentID = tempGrid[# tempGrid_colID, i];
			ds_list_add(list, currentID);
		}
	}

}