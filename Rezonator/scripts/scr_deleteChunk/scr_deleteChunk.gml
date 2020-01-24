// Set variable to be used in both cases
var currentWordID = -1;

// Deletion of Chunks
if(obj_toolPane.currentTool == obj_toolPane.toolBoxBrush || obj_control.deleteChunkWord) {
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
	// access the currentChainGridRow using the chainID
	if(tier == 1 and (obj_toolPane.currentMode == obj_toolPane.modeTrack or obj_toolPane.currentMode == obj_toolPane.modeRead)) {
		obj_control.linkDeleted = false
		obj_control.deleteNewWord = false;
		obj_control.deleteChunkWord = false;
		ds_grid_set_region(obj_chain.chunkGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.chunkGrid), obj_chain.chainStateNormal);
		exit;
	}
	else if(tier == 2 and (obj_toolPane.currentMode == obj_toolPane.modeRez or obj_toolPane.currentMode == obj_toolPane.modeRead)) { 
		obj_control.linkDeleted = false;
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
		for(var wordIDListLoop = 0; wordIDListLoop < ds_list_size(idList); wordIDListLoop++) {
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
// Deletion of newWords
else if(obj_toolPane.currentTool == obj_toolPane.toolNewWord or obj_control.deleteNewWord ==true) {
	currentWordID = obj_control.newWordHoverWordID;
		
	// (Maybe) within this space, check if this word is a Hit in the search screen.
	// If so, set the search to be redrawn after the deletion is done
		
	/*if(scr_findInGridTwoParameters(hitGrid, hitGrid_colWordID, currentWordID, hitGrid_colHitBool, true)) {
		newWordDeleted = true;
		scr_searchForWord(ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayString, currentWordID - 1));
		newWordDeleted = false;
	}*/
}
	
// Safety check, we only want to delete Chunks or newWords
var currentWordState = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentWordID - 1);
if(currentWordState != obj_control.wordStateChunk && currentWordState != obj_control.wordStateNew) 
{
	obj_control.linkDeleted = false;
	obj_control.deleteNewWord = false;
	obj_control.deleteChunkWord = false;
	exit;
}
	
// Set the word state to dead
ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentWordID - 1, obj_control.wordStateDead);
	
if(obj_toolPane.currentTool == obj_toolPane.toolNewWord or obj_control.deleteNewWord == true) {
if(scr_findInGridTwoParameters(obj_control.hitGrid, obj_control.hitGrid_colWordID, currentWordID, obj_control.hitGrid_colHitBool, true)) {
		obj_control.newWordDeleted = true;
		scr_searchForWord(ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayString, currentWordID - 1));
		obj_control.newWordDeleted = false;
	}
}
	
// Mechanism for removing this Chunk from any chains
// CUrrently experiencing bugs with deleting a nested Chunk plus it's nest within the same chain
//while(ds_grid_value_exists(obj_chain.linkGrid, obj_chain.linkGrid_colSource, 0, obj_chain.linkGrid_colSource, ds_grid_height(obj_chain.linkGrid), currentWordID)) {
//var currentLinkGridRow = ds_grid_value_y(obj_chain.linkGrid, obj_chain.linkGrid_colSource, 0, obj_chain.linkGrid_colSource, ds_grid_height(obj_chain.linkGrid), currentWordID);
var currentLinkGridRow = scr_findInGridTwoParameters(obj_chain.linkGrid, obj_chain.linkGrid_colSource, currentWordID, obj_chain.linkGrid_colDead, false);
//show_message(string(currentLinkGridRow));
ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, currentLinkGridRow, true);
		

var tier = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colTier, currentLinkGridRow);
// Retrieve the chainID from the linkGrid
var currentChainID = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colChainID, currentLinkGridRow);
// Make sure this chain gets focused to perform the deletion
obj_chain.currentFocusedChainID = currentChainID;
		
// access the currentChainGridRow using the chainID
if(tier == 1) {
	obj_control.gridInDelete = obj_chain.rezChainGrid;
}
else if(tier == 2) {
	obj_control.gridInDelete = obj_chain.trackChainGrid;
}
else if(tier == 3) {
	obj_control.gridInDelete = obj_chain.stackChainGrid;
}
		
if(obj_control.gridInDelete != undefined) {
	obj_control.currentChainGridRowInDelete = ds_grid_value_y(obj_control.gridInDelete, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(obj_control.gridInDelete), currentChainID);
}
// Locate the current chain within the chain grid