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
	
	// loop through trackChainGrid and fill up trackSeqGrid
	var trackChainGridHeight = ds_grid_height(obj_chain.trackChainGrid);
	for (var i = 0; i < trackChainGridHeight; i++) {
		
		// get wordIDList for current chain
		var currentWordIDList = ds_grid_get(obj_chain.trackChainGrid, obj_chain.chainGrid_colWordIDList, i);
		if (!ds_exists(currentWordIDList, ds_type_list)) {
			continue;
		}
		
		// create a list that is a duplicate of the currentWordIDList, but then sort it
		// so that the trackSeqGrid is in default sorted order
		var currentWordIDListSorted = ds_list_create();
		ds_list_copy(currentWordIDListSorted, currentWordIDList);
		ds_list_sort(currentWordIDListSorted, true);
		
		// get the chain values that we will want for the trackSeqGrid
		var currentChainID = ds_grid_get(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainID, i);
		var currentChainName = ds_grid_get(obj_chain.trackChainGrid, obj_chain.chainGrid_colName, i);
		
		// loop through currentWordIDListSorted and get the word values we will want for the trackSeqGrid
		var currentWordIDListSortedSize = ds_list_size(currentWordIDListSorted);
		for (var j = 0; j < currentWordIDListSortedSize; j++) {
			
			var currentWordID = ds_list_find_value(currentWordIDListSorted, j);
			var currentText = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordToken, currentWordID - 1);
			var currentTranscript = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, currentWordID - 1);
			if (currentTranscript == 0 || currentTranscript == "0") currentTranscript = "";
			
			// add new row to trackSeqGrid
			ds_grid_resize(trackSeqGrid, obj_chain.trackSeqGridWidth, ds_grid_height(trackSeqGrid) + 1);
			ds_grid_set(trackSeqGrid, obj_chain.trackSeqGrid_colChainID, ds_grid_height(trackSeqGrid) - 1, currentChainID);
			ds_grid_set(trackSeqGrid, obj_chain.trackSeqGrid_colChainName, ds_grid_height(trackSeqGrid) - 1, currentChainName);
			ds_grid_set(trackSeqGrid, obj_chain.trackSeqGrid_colTrackSeq, ds_grid_height(trackSeqGrid) - 1, j + 1);
			ds_grid_set(trackSeqGrid, obj_chain.trackSeqGrid_colWordID, ds_grid_height(trackSeqGrid) - 1, currentWordID);
			ds_grid_set(trackSeqGrid, obj_chain.trackSeqGrid_colText, ds_grid_height(trackSeqGrid) - 1, currentText);
			ds_grid_set(trackSeqGrid, obj_chain.trackSeqGrid_colTranscript, ds_grid_height(trackSeqGrid) - 1, currentTranscript);
			
		}
		
	}
	
	
}