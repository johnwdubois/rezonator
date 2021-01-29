// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_trackSeqGrid(){
	
	if (!instance_exists(obj_chain) || !instance_exists(obj_control)) {
		exit;
	}
	
	// reset trackSeqGrid
	var trackSeqGrid = obj_chain.trackSeqGrid;
	ds_grid_clear(trackSeqGrid, 0);
	ds_grid_resize(trackSeqGrid, obj_chain.trackSeqGridWidth, 0);
	
	// get trackChainList
	var trackChainList = ds_map_find_value(global.nodeMap, "trackChainList");
	var trackChainListSize = ds_list_size(trackChainList);
	
	

	
	// make temp grid to sort trackChains based on their first word's unitSeq and wordOrder
	var tempGrid_colChainID = 0;
	var tempGrid_colUnitSeq = 1;
	var tempGrid_colWordOrder = 2;
	var tempGrid = ds_grid_create(3, trackChainListSize);
	
	// set the chainSeq values for each track
	for (var i = 0; i < trackChainListSize; i++) {
		
		var currentChain = ds_list_find_value(trackChainList, i);
		var currentChainSubMap = ds_map_find_value(global.nodeMap, currentChain);
		
		// go through the current track's wordIDList and determine which word is earliest in the timeline
		var currentWordIDList = scr_getChainTempList(currentChain);
		var currentWordIDListSize = ds_list_size(currentWordIDList);
		var earliestWordID = -1;
		for (var j = 0; j < currentWordIDListSize; j++) {
			var currentWordID = ds_list_find_value(currentWordIDList, j);
			if (earliestWordID == -1) {
				// if the earliest word has not been set yet, let's make this word the earliest word
				earliestWordID = currentWordID;
			}
			else {
				// let's see if the current word has an earlier unitSeq than the earliest word
				var currentUnitSeq = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWordID - 1);
				var earliestUnitSeq = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, earliestWordID - 1);
				if (currentUnitSeq < earliestUnitSeq) {
					earliestWordID = currentWordID;
				}
				else if (currentUnitSeq == earliestUnitSeq) {
					// if the current word and the earliest word have the same unitSeq, then we will compare their wordOrders
					var currentWordOrder = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentWordID - 1);
					var earliestWordOrder = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, earliestWordID - 1);
					if (currentWordOrder < earliestWordOrder) {
						earliestWordID = currentWordID;
					}
				}
			}
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
	
	
	
	// loop through the sorted tempGrid and fill up trackSeqGrid
	var tempGridHeight = ds_grid_height(tempGrid);
	for (var i = 0; i < tempGridHeight; i++) {
		
		// get current chain and its name
		var currentChain = ds_grid_get(tempGrid, tempGrid_colChainID, i);
		var currentChainSubMap = ds_map_find_value(global.nodeMap, currentChain);
		if (!is_numeric(currentChainSubMap)) continue;
		if (!ds_exists(currentChainSubMap, ds_type_map)) continue;
		var currentChainName = ds_map_find_value(currentChainSubMap, "chainName");
		
		// get a temporary wordIDList for current chain
		var currentWordIDList = scr_getChainTempList(currentChain);
		if (!ds_exists(currentWordIDList, ds_type_list)) {
			continue;
		}
		
		// create a list that is a duplicate of the currentWordIDList, but then sort it
		// so that the trackSeqGrid is in default sorted order
		var currentWordIDListSorted = ds_list_create();
		ds_list_copy(currentWordIDListSorted, currentWordIDList);
		ds_list_sort(currentWordIDListSorted, true);		
		
		// loop through currentWordIDListSorted and get the word values we will want for the trackSeqGrid
		var currentWordIDListSortedSize = ds_list_size(currentWordIDListSorted);
		for (var j = 0; j < currentWordIDListSortedSize; j++) {
			
			var currentWordID = ds_list_find_value(currentWordIDListSorted, j);
			var currentText = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordToken, currentWordID - 1);
			var currentTranscript = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, currentWordID - 1);
			if (currentTranscript == 0 || currentTranscript == "0") currentTranscript = "";
			
			// add new row to trackSeqGrid
			ds_grid_resize(trackSeqGrid, obj_chain.trackSeqGridWidth, ds_grid_height(trackSeqGrid) + 1);
			ds_grid_set(trackSeqGrid, obj_chain.trackSeqGrid_colChainID, ds_grid_height(trackSeqGrid) - 1, currentChain);
			ds_grid_set(trackSeqGrid, obj_chain.trackSeqGrid_colChainName, ds_grid_height(trackSeqGrid) - 1, currentChainName);
			ds_grid_set(trackSeqGrid, obj_chain.trackSeqGrid_colTrackSeq, ds_grid_height(trackSeqGrid) - 1, j + 1);
			ds_grid_set(trackSeqGrid, obj_chain.trackSeqGrid_colWordID, ds_grid_height(trackSeqGrid) - 1, currentWordID);
			ds_grid_set(trackSeqGrid, obj_chain.trackSeqGrid_colText, ds_grid_height(trackSeqGrid) - 1, currentText);
			ds_grid_set(trackSeqGrid, obj_chain.trackSeqGrid_colTranscript, ds_grid_height(trackSeqGrid) - 1, currentTranscript);
			
		}
		
		// destroy the temporary wordIDList
		ds_list_destroy(currentWordIDList);
		
	}
	
	
}