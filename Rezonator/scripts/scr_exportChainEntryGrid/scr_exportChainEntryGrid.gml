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
	
	// get sorted list of chains
	var chainSeqList = ds_list_create();
	var tempGridHeight = ds_grid_height(tempGrid);
	for (var i = 0; i < tempGridHeight; i++) {
		var currentChain = ds_grid_get(tempGrid, tempGrid_colChainID, i);
		ds_list_add(chainSeqList, currentChain);
	}
	show_debug_message("scr_exportChainEntryGrid() ... chainSeqList: " + scr_getStringOfList(chainSeqList));
	
	
	
	
	
	
	
	
	
	
	
	// loop through the sorted list of chains and fill up trackGrid
	var chainSeqListSize = ds_list_size(chainSeqList);
	for (var i = 0; i < chainSeqListSize; i++) {
		
		// get current chain and its name
		var currentChain = ds_list_find_value(chainSeqList, i);
		var currentChainSubMap = ds_map_find_value(global.nodeMap, currentChain);
		
		if (!is_numeric(currentChainSubMap)) continue;
		if (!ds_exists(currentChainSubMap, ds_type_map)) continue;
		var currentChainName = ds_map_find_value(currentChainSubMap, "chainName");
		
		// get the setList for current chain
		var currentVizSetIDList = ds_map_find_value(currentChainSubMap, "vizSetIDList");
		if (!is_numeric(currentVizSetIDList)) continue;
		if (!ds_exists(currentVizSetIDList, ds_type_list)) continue;
		
		// loop through setList and get the word values we will want for the trackGrid
		var currentVizSetIDListSize = ds_list_size(currentVizSetIDList);
		for (var j = 0; j < currentVizSetIDListSize; j++) {
		
			// get current entry and its corresponding word and fill up trackGrid
			var currentEntry = ds_list_find_value(currentVizSetIDList, j);
			var currentEntrySubMap = ds_map_find_value(global.nodeMap, currentEntry);
			
			// get currentEntry's word and check if its a chunk
			var currentWord = -1;
			var rowInChunkGrid = -1;
			var isChunk = false;
			var isInChunk = false;
			if (is_numeric(currentEntrySubMap)) {
				if (ds_exists(currentEntrySubMap, ds_type_map)) {
					currentWord = ds_map_find_value(currentEntrySubMap, "word");
					var currentWordInBoxList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInBoxList, currentWord - 1);
					var currentWordInBoxListSize = ds_list_size(currentWordInBoxList);
					if (currentWordInBoxListSize > 0) {
						rowInChunkGrid = ds_grid_value_y(obj_chain.chunkGrid, obj_chain.chainGrid_colName, 0, obj_chain.chainGrid_colName, ds_grid_height(obj_chain.chunkGrid), currentWord);
						if (rowInChunkGrid >= 0) isChunk = true;
						else isInChunk = true;
					}
				}
			}
			
			// make a new row for this entry
			scr_exportChainEntryGridNewRow(grid, currentChain, currentChainName, currentEntry, currentWord, i + 1, j + 1, isChunk, isInChunk);
			
			// if this word is a chunk, then we will loop through all of the words in it and give them a new row too!
			if (isChunk) {
				var chunkWordList = ds_grid_get(obj_chain.chunkGrid, obj_chain.chunkGrid_colBoxWordIDList, rowInChunkGrid);
				var chunkWordListSize = ds_list_size(chunkWordList);
				for (var k = 0; k < chunkWordListSize - 1; k++) {
					var currentChunkWord = ds_list_find_value(chunkWordList, k);
					scr_exportChainEntryGridNewRow(grid, currentChain, currentChainName, currentEntry, currentChunkWord, i + 1, j + 1, false, true);
				}
			}
		}
	}
	
	ds_list_destroy(chainSeqList);
}