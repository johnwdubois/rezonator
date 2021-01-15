// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_trackSeqGrid(){
	
	if (!instance_exists(obj_chain) || !instance_exists(obj_control)) {
		exit;
	}
	
	var trackChainGridHeight = ds_grid_height(obj_chain.trackChainGrid);
	
	// reset trackSeqGrid
	var trackSeqGrid = obj_chain.trackSeqGrid;
	ds_grid_clear(trackSeqGrid, 0);
	ds_grid_resize(trackSeqGrid, obj_chain.trackSeqGridWidth, 0);
	
	// make temp grid to sort trackChains based on their first word's unitSeq and wordOrder
	var tempGrid_colChainID = 0;
	var tempGrid_colUnitSeq = 1;
	var tempGrid_colWordOrder = 2;
	var tempGrid_colRowInChainGrid = 3;
	var tempGrid = ds_grid_create(4, trackChainGridHeight);
	
	// set the chainSeq values for each track
	for (var i = 0; i < trackChainGridHeight; i++) {
		
		var currentChainID = ds_grid_get(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainID, i);
		
		// go through the current track's wordIDList and determine which word is earliest in the timeline
		var currentWordIDList = ds_grid_get(obj_chain.trackChainGrid, obj_chain.chainGrid_colWordIDList, i);
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
		ds_grid_set(tempGrid, tempGrid_colChainID, i, currentChainID);
		ds_grid_set(tempGrid, tempGrid_colUnitSeq, i, earliestUnitSeq);
		ds_grid_set(tempGrid, tempGrid_colWordOrder, i, earliestWordOrder);
	}
	
	// sort the tempGrid based on 1) unitSeq and then 2) wordOrder
	scr_gridMultiColSort(tempGrid, tempGrid_colUnitSeq, true, tempGrid_colWordOrder, true);
	
	
	// set the row in chainGrid for the sorted tempGrid
	for (var i = 0; i < trackChainGridHeight; i++) {
		var currentChainID = ds_grid_get(tempGrid, tempGrid_colChainID, i);
		var rowInChainGrid = ds_grid_value_y(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.trackChainGrid), currentChainID);
		ds_grid_set(tempGrid, tempGrid_colRowInChainGrid, i, rowInChainGrid);
		
		
		var currentUnitSeq = ds_grid_get(tempGrid, tempGrid_colUnitSeq, i);
		var currentWordOrder = ds_grid_get(tempGrid, tempGrid_colWordOrder, i);
		show_debug_message("currentChainID: " + string(currentChainID) + ", currentUnitSeq: " + string(currentUnitSeq) + ", currentWordOrder: " + string(currentWordOrder) + ", rowInChainGrid: " + string(rowInChainGrid));
	}

	
	
	// loop through trackChainGrid and fill up trackSeqGrid
	for (var i = 0; i < trackChainGridHeight; i++) {
		
		var rowInChainGrid = ds_grid_get(tempGrid, tempGrid_colRowInChainGrid, i);
		
		// get wordIDList for current chain
		var currentWordIDList = ds_grid_get(obj_chain.trackChainGrid, obj_chain.chainGrid_colWordIDList, rowInChainGrid);
		if (!ds_exists(currentWordIDList, ds_type_list)) {
			continue;
		}
		
		// create a list that is a duplicate of the currentWordIDList, but then sort it
		// so that the trackSeqGrid is in default sorted order
		var currentWordIDListSorted = ds_list_create();
		ds_list_copy(currentWordIDListSorted, currentWordIDList);
		ds_list_sort(currentWordIDListSorted, true);
		
		// get the chain values that we will want for the trackSeqGrid
		var currentChainID = ds_grid_get(obj_chain.trackChainGrid, obj_chain.chainGrid_colChainID, rowInChainGrid);
		var currentChainName = ds_grid_get(obj_chain.trackChainGrid, obj_chain.chainGrid_colName, rowInChainGrid);
		
		// loop through currentWordIDListSorted and get the word values we will want for the trackSeqGrid
		var currentWordIDListSortedSize = ds_list_size(currentWordIDListSorted);
		for (var j = 0; j < currentWordIDListSortedSize; j++) {
			
			var currentWordID = ds_list_find_value(currentWordIDListSorted, j);
			var currentUnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWordID - 1);
			var currentText = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordToken, currentWordID - 1);
			var currentTranscript = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, currentWordID - 1);
			if (currentTranscript == 0 || currentTranscript == "0") currentTranscript = "";
			var currentUnitText = "\"";
			var currentUnitWordIDList = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, currentUnitID - 1);
			var currentUnitWordIDListSize = ds_list_size(currentUnitWordIDList);
			for (var k = 0; k < currentUnitWordIDListSize; k++) {
				
				// add to the unit's string (unless this is a chunk)
				var currentWordInUnit = ds_list_find_value(currentUnitWordIDList, k);
				var currentWordInUnitIsChunk = (ds_grid_value_exists(obj_chain.chunkGrid, obj_chain.chainGrid_colName, 0, obj_chain.chainGrid_colName, ds_grid_height(obj_chain.chunkGrid), currentWordInUnit));
				if (!currentWordInUnitIsChunk) {
					var displayStr = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordInUnit - 1);
					currentUnitText += string(displayStr) + " ";
				}
			}
			currentUnitText += "\"";
			
			
			// add new row to trackSeqGrid
			ds_grid_resize(trackSeqGrid, obj_chain.trackSeqGridWidth, ds_grid_height(trackSeqGrid) + 1);
			ds_grid_set(trackSeqGrid, obj_chain.trackSeqGrid_colChainID, ds_grid_height(trackSeqGrid) - 1, currentChainID);
			ds_grid_set(trackSeqGrid, obj_chain.trackSeqGrid_colChainName, ds_grid_height(trackSeqGrid) - 1, currentChainName);
			ds_grid_set(trackSeqGrid, obj_chain.trackSeqGrid_colChainSeq, ds_grid_height(trackSeqGrid) - 1, i + 1);
			ds_grid_set(trackSeqGrid, obj_chain.trackSeqGrid_colTrackSeq, ds_grid_height(trackSeqGrid) - 1, j + 1);
			ds_grid_set(trackSeqGrid, obj_chain.trackSeqGrid_colWordID, ds_grid_height(trackSeqGrid) - 1, currentWordID);
			ds_grid_set(trackSeqGrid, obj_chain.trackSeqGrid_colText, ds_grid_height(trackSeqGrid) - 1, currentText);
			ds_grid_set(trackSeqGrid, obj_chain.trackSeqGrid_colTranscript, ds_grid_height(trackSeqGrid) - 1, currentTranscript);
			ds_grid_set(trackSeqGrid, obj_chain.trackSeqGrid_colUnitText, ds_grid_height(trackSeqGrid) - 1, currentUnitText);
			
		}
		
	}
	
	ds_grid_destroy(tempGrid);
	
}