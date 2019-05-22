/// @description Box Creation
// Place all captured unit and word info into the box grid

if (ds_list_size(inRectUnitIDList) > 0) {
	
	// Expand the box grid to fit the new info
	ds_grid_resize(obj_chain.boxChainGrid, obj_chain.chainGridWidth + 1, ds_grid_height(obj_chain.boxChainGrid) + 1);
	ds_grid_set(obj_chain.boxChainGrid, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.boxChainGrid) - 1, ++boxChainID);
	ds_grid_set(obj_chain.boxChainGrid, obj_chain.chainGrid_colWordIDList, ds_grid_height(obj_chain.boxChainGrid) - 1, ds_list_create());
	ds_grid_set(obj_chain.boxChainGrid, obj_chain.boxChainGrid_colBoxWordIDList, ds_grid_height(obj_chain.boxChainGrid) - 1, ds_list_create());
	
	// Retrieve references of the lists being added to
	var currentUnitList = ds_grid_get(obj_chain.boxChainGrid, obj_chain.chainGrid_colWordIDList,ds_grid_height(obj_chain.boxChainGrid) - 1 );
	var currentWordList = ds_grid_get(obj_chain.boxChainGrid, obj_chain.boxChainGrid_colBoxWordIDList,ds_grid_height(obj_chain.boxChainGrid) - 1);
	var innerLoop = 0;
	
	// Loop through words found in rectangle at time of mouse release
	for(var quickLoop = 0; quickLoop < ds_list_size(inRectUnitIDList); quickLoop++) {
		
		// Extract the unit and word ID's that were captured
		var currentWordID = ds_list_find_value(inRectWordIDList, innerLoop);
		var currentUnitID = ds_list_find_value(inRectUnitIDList, quickLoop);
		
		// Place unitID into box grid
		if(ds_list_find_index(currentUnitList, currentUnitID) == -1) {
			ds_list_add(currentUnitList, currentUnitID);
		}
		
		// Really need a better mechanism than this
		while(currentUnitID == ds_grid_get(wordGrid, wordGrid_colUnitID, currentWordID + 1)) {
			if(ds_list_find_index(currentWordList, currentWordID) == -1) {
				// Place wordID into box grid
				ds_list_add(currentWordList, currentWordID);
				//ds_list_add(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInBoxList, currentWordID-1), boxChainID);
			} 
			// Safety check to not go over the list size
			if(innerLoop == ds_list_size(inRectWordIDList) - 1) {
			break;	
			}
			// increment the current word
			currentWordID = ds_list_find_value(inRectWordIDList, ++innerLoop);
		}
	}
	scr_unFocusAllChains();
	if(ds_list_size(ds_grid_get(obj_chain.boxChainGrid, obj_chain.chainGrid_colWordIDList,ds_grid_height(obj_chain.boxChainGrid) - 1 )) == 1) {
	var transcript = "";
	newWordHoverUnitID = ds_list_find_value(ds_grid_get(obj_chain.boxChainGrid, obj_chain.chainGrid_colWordIDList, ds_grid_height(obj_chain.boxChainGrid) - 1), 0);
	newWordHoverWordSeq = ds_grid_get(wordGrid, wordGrid_colWordSeq, ds_list_find_value(inRectWordIDList, ds_list_size(inRectWordIDList) - 1) - 1);
	for(var transcriptSize = 0; transcriptSize < ds_list_size(ds_grid_get(obj_chain.boxChainGrid, obj_chain.boxChainGrid_colBoxWordIDList,ds_grid_height(obj_chain.boxChainGrid) - 1)); transcriptSize++) {
		transcript += ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, ds_list_find_value(ds_grid_get(obj_chain.boxChainGrid, obj_chain.boxChainGrid_colBoxWordIDList,ds_grid_height(obj_chain.boxChainGrid) - 1), transcriptSize) - 1) + " ";
	}
	scr_newWord(newWordHoverUnitID, newWordHoverWordSeq, transcript);
}
}
/*
if(ds_list_size(ds_grid_get(obj_chain.boxChainGrid, obj_chain.chainGrid_colWordIDList,ds_grid_height(obj_chain.boxChainGrid) - 1 )) == 1) {
	var transcript = "";
	newWordHoverUnitID = ds_list_find_value(ds_grid_get(obj_chain.boxChainGrid, obj_chain.boxChainGrid_colBoxWordIDList,ds_grid_height(obj_chain.boxChainGrid) - 1), 0);
	newWordHoverWordSeq = ds_grid_get(wordGrid, wordGrid_colWordSeq, currentWordID - 1);
	for(var transcriptSize = 0; transcriptSize < ds_list_size(ds_grid_get(obj_chain.boxChainGrid, obj_chain.boxChainGrid_colBoxWordIDList,ds_grid_height(obj_chain.boxChainGrid) - 1)); transcriptSize++) {
		transcript += ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordTranscript, ds_list_find_value(ds_grid_get(obj_chain.boxChainGrid, obj_chain.boxChainGrid_colBoxWordIDList,ds_grid_height(obj_chain.boxChainGrid) - 1), transcriptSize) - 1) + " ";
	}
	scr_newWord(newWordHoverUnitID, newWordHoverWordSeq, transcript);
}*/

// Clear the rect word list for next use
if (ds_list_size(inRectUnitIDList) > 0) {
	ds_list_clear(inRectUnitIDList);
	ds_list_clear(inRectWordIDList);
}

// Reset all box grid variables
boxHoldRectX1 = 0; 
boxHoldRectX2 = 0; 
boxHoldRectY1 = 0; 
boxHoldRectX2 = 0; 
boxRectMade = false;
boxRectReleased = true;
boxRectAbleToInitiate = true;