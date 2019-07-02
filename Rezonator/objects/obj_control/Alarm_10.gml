/// @description Box Creation
// Place all captured unit and word info into the box grid

if (ds_list_size(inRectUnitIDList) > 0 && ds_list_size(inRectWordIDList) > 0) { // Make sure the box captured something
	//show_message(scr_getStringOfList(inRectWordIDList));
	// Expand the box grid to fit the new info
	ds_grid_resize(obj_chain.chunkGrid, obj_chain.chainGridWidth + 2, ds_grid_height(obj_chain.chunkGrid) + 1);
	ds_grid_set(obj_chain.chunkGrid, obj_chain.chainGrid_colChainID, ds_grid_height(obj_chain.chunkGrid) - 1, ++obj_control.chunkID);
	ds_grid_set(obj_chain.chunkGrid, obj_chain.chainGrid_colWordIDList, ds_grid_height(obj_chain.chunkGrid) - 1, ds_list_create());
	ds_grid_set(obj_chain.chunkGrid, obj_chain.chunkGrid_colBoxWordIDList, ds_grid_height(obj_chain.chunkGrid) - 1, ds_list_create());
	ds_grid_set(obj_chain.chunkGrid, obj_chain.chunkGrid_colNest, ds_grid_height(obj_chain.chunkGrid) - 1, false);

	// Retrieve references of the lists being added to
	var currentUnitList = ds_grid_get(obj_chain.chunkGrid, obj_chain.chainGrid_colWordIDList,ds_grid_height(obj_chain.chunkGrid) - 1 );
	var currentWordList = ds_grid_get(obj_chain.chunkGrid, obj_chain.chunkGrid_colBoxWordIDList,ds_grid_height(obj_chain.chunkGrid) - 1);
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
		while(currentUnitID == ds_grid_get(wordGrid, wordGrid_colUnitID, currentWordID - 1)) {
			
			var currentInBoxList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInBoxList, currentWordID-1);
			if(ds_list_find_index(currentWordList, currentWordID) == -1) {
				// Place wordID into box grid
				ds_list_add(currentWordList, currentWordID);
				//show_message(string(obj_control.chunkID));
				
				ds_list_add(currentInBoxList, obj_control.chunkID);
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
	// If this box counts as a chunk, mark it as such and nest it if possible
	if(ds_list_size(currentUnitList) == 1 && ds_list_size(currentWordList) > 1) {
		
		// Mark this box as a chunk
		//ds_grid_set(obj_chain.chunkGrid, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.chunkGrid) - 1, 1);
		
		// Create an invisible new word to act as this Chunk's data type
		var currentWordID = ds_list_find_value(currentWordList, ds_list_size(currentWordList) - 1); // Use the last word so the contained words are drawn first
		var currentUnitID = ds_list_find_value(currentUnitList, 0);
		scr_newWord(currentUnitID, ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentWordID - 1), obj_control.chunkID);
		// Store the new word's ID
		ds_grid_set(obj_chain.chunkGrid, obj_chain.chainGrid_colName, ds_grid_height(obj_chain.chunkGrid) - 1, ds_grid_height(obj_control.wordGrid));
		ds_list_add(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInBoxList, ds_grid_height(obj_control.dynamicWordGrid) - 1), ds_grid_height(obj_chain.chunkGrid));
			
		// Access the first word's in Chunk list
		var currentInChunkList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInBoxList, ds_list_find_value(currentWordList, 0));
			
		// Loop through the in Chunk list, check if any elements are not the current chunk
		for(var chunkListLoop = 0; chunkListLoop < ds_list_size(currentInChunkList); chunkListLoop++) {
				
			var currentChunkID = ds_grid_height(obj_chain.chunkGrid);
			var otherChunkID = ds_list_find_value(currentInChunkList, chunkListLoop);
				
			// Check if this word lies within another chunk
			if(currentChunkID != otherChunkID) {
					
				// Retrieve the ord list of the Chunk to be compared	
				var otherChunkWordList = ds_grid_get(obj_chain.chunkGrid, obj_chain.chunkGrid_colBoxWordIDList, otherChunkID - 1);
					
				// Check if this chunk contains the other chunk
				if(scr_listContainsSublist(otherChunkWordList, currentWordList) != -1) {
						
					//wordRectBuffer = 4;
					ds_grid_set(obj_chain.chunkGrid, obj_chain.chunkGrid_colNest, ds_grid_height(obj_chain.chunkGrid) - 1, true);
					continue;
				}
			}
		}
	}
}

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