// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_exportChainEntryGrid(grid){
	
	if (!instance_exists(obj_chain) || !instance_exists(obj_control)) {
		exit;
	}
	
	// reset trackGrid
	var gridWidth = obj_chain.trackGridWidth + (ds_grid_width(global.tokenImportGrid) - 4);
	ds_grid_clear(grid, 0);
	ds_grid_resize(grid, gridWidth, 0);
	
	// get chainList
	var chainList = ds_map_find_value(global.nodeMap, (grid == obj_chain.trackGrid) ? "trackChainList" : "rezChainList");
	var chainListSize = ds_list_size(chainList);
	
	// make temp grid to sort trackChains based on their first word's unitSeq and wordOrder
	var tempGrid_colChainID = 0;
	var tempGrid_colUnitSeq = 1;
	var tempGrid_colWordOrder = 2;
	var tempGrid = ds_grid_create(3, chainListSize);
	
	// set the chainSeq values for each track
	for (var i = 0; i < chainListSize; i++) {
		
		var currentChain = ds_list_find_value(chainList, i);
		var currentChainSubMap = ds_map_find_value(global.nodeMap, currentChain);
		
		// go through the current track's wordIDList and determine which word is earliest in the timeline
		var currentWordIDList = scr_getChainTempList(currentChain, true);
		var earliestWordID = -1;
		
		// the earliest word should be the first word in the currentWordIDList (because it came from the vizSetIDList)
		if (ds_list_size(currentWordIDList) > 0) {
			earliestWordID = ds_list_find_value(currentWordIDList, 0);
		}
		
		// by now, we should know what this chain's earliest word in the timeline is
		// so we can put that data into our tempGrid so that we can sort on it after
		var earliestUnitSeq = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, earliestWordID - 1);
		var earliestWordOrder = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, earliestWordID - 1);
		ds_grid_set(tempGrid, tempGrid_colChainID, i, currentChain);
		ds_grid_set(tempGrid, tempGrid_colUnitSeq, i, earliestUnitSeq);
		ds_grid_set(tempGrid, tempGrid_colWordOrder, i, earliestWordOrder);
		
		ds_list_destroy(currentWordIDList);
	}
	
	
	// at this point, the tempGrid will be in the same order as the chainList
	// but we want it to be sorted by discourse time, so....
	// we sort the tempGrid based on 1) unitSeq and then 2) wordOrder
	scr_gridMultiColSort(tempGrid, tempGrid_colUnitSeq, true, tempGrid_colWordOrder, true);
	
	
	
	// loop through the sorted tempGrid and fill up trackGrid
	var tempGridHeight = ds_grid_height(tempGrid);
	for (var i = 0; i < tempGridHeight; i++) {
		
		// get current chain and its name
		var currentChain = ds_grid_get(tempGrid, tempGrid_colChainID, i);
		var currentChainSubMap = ds_map_find_value(global.nodeMap, currentChain);
		if (!is_numeric(currentChainSubMap)) continue;
		if (!ds_exists(currentChainSubMap, ds_type_map)) continue;
		var currentChainName = ds_map_find_value(currentChainSubMap, "chainName");
		
		// get the setList for current chain
		var currentVizSetIDList = ds_map_find_value(currentChainSubMap, "vizSetIDList");
		if (!is_numeric(currentVizSetIDList)) {
			continue;
		}
		if (!ds_exists(currentVizSetIDList, ds_type_list)) {
			continue;
		}
		
		// loop through currentVizSetIDList and get the word values we will want for the trackGrid
		var currentVizSetIDListSize = ds_list_size(currentVizSetIDList);
		for (var j = 0; j < currentVizSetIDListSize; j++) {
			
			// get current entry and its corresponding word and fill up trackGrid
			var currentEntry = ds_list_find_value(currentVizSetIDList, j);
			var currentEntrySubMap = ds_map_find_value(global.nodeMap, currentEntry);
			
			if (is_numeric(currentEntrySubMap)) {
				if (is_numeric(currentEntrySubMap)) {
					
					// get currentEntry's tagmap
					var currentTagMap = ds_map_find_value(currentEntrySubMap, "tagMap");
					var currentGapUnits = ds_map_find_value(currentTagMap, "gapUnits");
			
					// get word info
					var currentWordID = ds_map_find_value(currentEntrySubMap, "word");
					var currentText = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordToken, currentWordID - 1);
					var currentTranscript = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, currentWordID - 1);
					if (currentTranscript == 0 || currentTranscript == "0") currentTranscript = "";
			
					// add new row to trackGrid
					ds_grid_resize(grid, gridWidth, ds_grid_height(grid) + 1);
					var newGridRow = ds_grid_height(grid) - 1;
					ds_grid_set(grid, obj_chain.trackGrid_colChainID, newGridRow, currentChain);
					ds_grid_set(grid, obj_chain.trackGrid_colChainName, newGridRow, currentChainName);
					ds_grid_set(grid, obj_chain.trackGrid_colTrackSeq, newGridRow, j + 1);
					ds_grid_set(grid, obj_chain.trackGrid_colWordID, newGridRow, currentWordID);
					ds_grid_set(grid, obj_chain.trackGrid_colText, newGridRow, currentText);
					ds_grid_set(grid, obj_chain.trackGrid_colGapUnits, newGridRow, currentGapUnits);
					
					// add tokenImport data to trackGrid
					var tokenImportGridWidth = ds_grid_width(global.tokenImportGrid);
					for (var k = 4; k < tokenImportGridWidth; k++) {
						var currentTokenImportValue = ds_grid_get(global.tokenImportGrid, k, currentWordID - 1);
						ds_grid_set(grid, obj_chain.trackGridWidth - 4 + k, ds_grid_height(grid) - 1, currentTokenImportValue);
					}					
				}
			}
		}
	}
}