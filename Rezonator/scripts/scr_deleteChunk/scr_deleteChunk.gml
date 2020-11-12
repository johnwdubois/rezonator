/*
	scr_deleteChunk();
	
	Last Updated: 2020-10-28
	
	Called from: scr_deleteFromChain()
	
	Purpose: Remove the Chunk from it's chain, and delete the Chunk word
	
	Mechanism: Remove the chunk from its words inBoxList, delete the newWord associated with the Chunk, and set it up to be removed from the chain
	
	Author: Georgio Klironomos
*/
function scr_deleteChunk() {
	// Set variable to be used in both cases
	var currentWordID = -1;
	//show_message("Delete Chunk");
	// Deletion of Chunks
	if(obj_toolPane.currentTool == obj_toolPane.toolBoxBrush or obj_control.deleteChunkWord) {
		//obj_control.deleteChunkWord = false;	
		// Access the relevent row in the Chunk grid
		var currentChunkRow = ds_grid_value_y(obj_chain.chunkGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.chunkGrid), obj_chain.chainStateFocus);
	    //show_message(currentChunkRow);
		if(currentChunkRow < 0) {
			obj_control.linkDeleted = false;
			obj_control.deleteNewWord = false;
			obj_control.deleteChunkWord = false;
			ds_grid_set_region(obj_chain.chunkGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.chunkGrid), obj_chain.chainStateNormal);
			exit;	
		}

		// Access the Chunk's wordID
		currentWordID = ds_grid_get(obj_chain.chunkGrid, obj_chain.chainGrid_colName, currentChunkRow);
	
		var currentLinkGridRow = scr_findInGridTwoParameters(obj_chain.linkGrid, obj_chain.linkGrid_colSource, currentWordID, obj_chain.linkGrid_colDead, false);
		var tier = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colTier, currentLinkGridRow);
		
		// Check if we're using the right mode to delete this Chunk. If we're not, exit the program
		if((tier == 1 and (obj_toolPane.currentMode == obj_toolPane.modeTrack or obj_toolPane.currentMode == obj_toolPane.modeRead)) 
		or (tier == 2 and (obj_toolPane.currentMode == obj_toolPane.modeRez or obj_toolPane.currentMode == obj_toolPane.modeRead))) {
			obj_control.linkDeleted = false
			obj_control.deleteNewWord = false;
			obj_control.deleteChunkWord = false;
			ds_grid_set_region(obj_chain.chunkGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.chunkGrid), obj_chain.chainStateNormal);
			exit;
		}
	
		// Get the list of words within this Chunk
		var idList = ds_grid_get(obj_chain.chunkGrid, obj_chain.chunkGrid_colBoxWordIDList, currentChunkRow);
		var chainState = ds_grid_get(obj_chain.chunkGrid, obj_chain.chainGrid_colChainState, currentChunkRow);
	
		// Holdover from code's source, may be useful for dynamic editing later on
		if (ds_list_size(idList) == 0) {
			chainState = obj_chain.chainStateDead;
			ds_grid_set(obj_chain.chunkGrid, obj_chain.chainGrid_colChainState, currentChunkRow, chainState);
		}
	
		// Start the lengthy process of removing all mention of this Chunk
		else if (not (chainState == obj_chain.chainStateDead)) {
			chainState = obj_chain.chainStateDead;
			ds_grid_set(obj_chain.chunkGrid, obj_chain.chainGrid_colChainState, currentChunkRow, chainState);
		
			// Get the Chunk's chainID to be searched
			var chainID = ds_grid_get(obj_chain.chunkGrid, obj_chain.chainGrid_colChainID, currentChunkRow);
			//var lastItemId = ds_list_find_value(idList, 0);
			
			// Remove this Chunk from each of its word's inBoxLists
			var idListSize = ds_list_size(idList);
			for(var wordIDListLoop = 0; wordIDListLoop < idListSize; wordIDListLoop++) {
				var itemId = ds_list_find_value(idList, wordIDListLoop);
				var itemInChainsList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInBoxList, itemId - 1);
				var indexInitemInChainsList = ds_list_find_index(itemInChainsList, chainID);
				if (indexInitemInChainsList >= 0) {
					ds_list_delete(itemInChainsList, indexInitemInChainsList);
				}
			}
		
			// Disconnect the Chunk from its Chunkword
			var chunkWordInChainsList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInBoxList, currentWordID - 1);
			ds_list_delete(chunkWordInChainsList, 0);
		}

	
	}
	
	// Safety check, we only want to delete Chunks or newWords
	if(currentWordID == -1) {
		//show_message(obj_control.newWordHoverWordID);
		if(obj_control.newWordHoverWordID > -1 and obj_control.newWordHoverWordID <=(ds_grid_height(obj_control.dynamicWordGrid))) {
			currentWordID = obj_control.newWordHoverWordID;
		}
	}
	
	var currentWordState = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentWordID - 1);
	
	if(currentWordState != obj_control.wordStateChunk and currentWordState != obj_control.wordStateNew) 
	{
		obj_control.linkDeleted = false;
		obj_control.deleteNewWord = false;
		obj_control.deleteChunkWord = false;//show_message("exit");
		exit;
	}
	
	// Set the word state to dead
	ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentWordID - 1, obj_control.wordStateDead);
	
	// Mechanism for removing this Chunk from any chains
	// CUrrently experiencing bugs with deleting a nested Chunk plus it's nest within the same chain
	
	var currentLinkGridRow = scr_findInGridTwoParameters(obj_chain.linkGrid, obj_chain.linkGrid_colSource, currentWordID, obj_chain.linkGrid_colDead, false);
	//show_message(string(currentLinkGridRow));
	ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, currentLinkGridRow, true);
		

	var tier = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colTier, currentLinkGridRow);
	// Retrieve the chainID from the linkGrid
	var currentChainID = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colChainID, currentLinkGridRow);
	// Make sure this chain gets focused to perform the deletion
	obj_chain.currentFocusedChainID = currentChainID;
		
	// access the currentChainGridRow using the chainID
	if(tier == obj_chain.rezTier) {
		obj_control.gridInDelete = obj_chain.rezChainGrid;
	}
	else if(tier == obj_chain.trackTier) {
		obj_control.gridInDelete = obj_chain.trackChainGrid;
	}
	else if(tier == obj_chain.stackTier) {
		obj_control.gridInDelete = obj_chain.stackChainGrid;
	}
		
	if(obj_control.gridInDelete != undefined) {
		obj_control.currentChainGridRowInDelete = ds_grid_value_y(obj_control.gridInDelete, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_control.gridInDelete), currentChainID);
	}
	// Locate the current chain within the chain grid


}
