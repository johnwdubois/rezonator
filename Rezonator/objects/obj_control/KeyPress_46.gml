///@description Remove Link
if (instance_exists(obj_input_text)) {
	exit;
}

// Make sure there is a focused link to be deleted
if (ds_grid_value_exists(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, 0, obj_chain.linkGrid_colFocus, ds_grid_height(obj_chain.linkGrid), true)) {	
	// Find the link that is in focus
	var rowInLinkGridSource = scr_findInGridTwoParameters(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, true, obj_chain.linkGrid_colDead, false);
	
	if (rowInLinkGridSource == -1) {
		exit;
	}
	
	// Access information on focused link
	var chainID = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colChainID, rowInLinkGridSource);
	var tier = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colTier, rowInLinkGridSource);
	var dead = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colDead, rowInLinkGridSource);
	
	if (dead) {
		exit;
	}
	
	// This kills the link
	ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colDead, rowInLinkGridSource, true);
	
	// Aquire info on the link's source
	var source = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colSource, rowInLinkGridSource);
	var sourceInChainsList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInChainList, source - 1);
	var indexOfChainIDInChainsList = ds_list_find_index(sourceInChainsList, chainID);
	if (indexOfChainIDInChainsList > -1) {
		// Delete this chain from the source's inChainList
		ds_list_delete(sourceInChainsList, indexOfChainIDInChainsList);
		
		moveCounter ++;
	}
	
	// Reset the alignment of the unchained word
	if (source >= 0 and source < ds_grid_height(obj_control.dynamicWordGrid) and tier == 1) {
		if (ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colStretch, source - 1)) {
			ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colStretch, source - 1, false);
		}
		
		ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colAligned, source - 1, true);
	}
	
	var rowInLinkGridGoal = -1;
	var newSource = -1;
	var newGoal = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colGoal, rowInLinkGridSource);
	
	// If possible, create a new link between the source's source and goal
	if (scr_findInGridTwoParameters(obj_chain.linkGrid, obj_chain.linkGrid_colGoal, source, obj_chain.linkGrid_colChainID, chainID) > -1) {
		rowInLinkGridGoal = scr_findInGridThreeParameters(obj_chain.linkGrid, obj_chain.linkGrid_colGoal, source, obj_chain.linkGrid_colChainID, chainID, obj_chain.linkGrid_colDead, false);
		newSource = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colSource, rowInLinkGridGoal);
		ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colDead, rowInLinkGridGoal, true);
		
	}
	
	//show_message(string(newSource) + "," + string(newGoal))
	
	//Repeat the above process, but for Stacks
	if (tier == 3) {
		var rowInUnitInStackGrid = ds_grid_value_y(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colUnitID, 0, obj_chain.unitInStackGrid_colUnitID, ds_grid_height(obj_chain.unitInStackGrid), source);
		
		if (rowInUnitInStackGrid < 0 or rowInUnitInStackGrid >= ds_grid_height(obj_chain.unitInStackGrid)) {
			exit;
		}
		
		
		ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStack, rowInUnitInStackGrid, -1);


		// If there is a new source, find its UnitID
		if (newSource > 0) {
			var idListNewSource = ds_grid_get(unitGrid, unitGrid_colWordIDList, newSource - 1);
			
			if not (idListNewSource == undefined) {
				if (ds_list_size(idListNewSource) > 0) {
					newSource = ds_list_find_value(idListNewSource, 0);
				}
			}
		}
		// If there is a new goal, find its UnitID
		if (newGoal > 0) {
			var idListNewGoal = ds_grid_get(unitGrid, unitGrid_colWordIDList, newGoal - 1);
			
			if not (idListNewGoal == undefined) {
				if (ds_list_size(idListNewGoal) > 0) {
					newGoal = ds_list_find_value(idListNewGoal, 0);
				}
			}
		}
	}
	
	// If there is a new source and goal, create the new link
	if not (newSource == -1 or newSource == undefined or newGoal == undefined) {
		with (obj_chain) {
			scr_newLink(newSource, newGoal);
		}
	}
	
	// Take away the unchained word's fillRect
	if not (source == undefined) {
		ds_grid_set(wordDrawGrid, wordDrawGrid_colFillRect, source - 1, false);
	}
}

// Expirementing with deleting Chunks
if(obj_toolPane.currentTool == obj_toolPane.toolBoxBrush) {
	// Access the relevent row in the Chunk grid
	var currentChunkRow = ds_grid_value_y(obj_chain.chunkGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.chunkGrid), obj_chain.chainStateFocus);
	
	// If this Chunk has already been deleted, refresh the chain grids
	if(currentChunkRow == -1) {
		scr_refreshChainGrid();
		scr_killEmptyChains(obj_chain.rezChainGrid);
		scr_killEmptyChains(obj_chain.trackChainGrid);
		scr_killEmptyChains(obj_chain.stackChainGrid);
		obj_chain.mouseLineWordID = -1;

		scr_refreshVizLinkGrid();
		exit;	
	}
	
	// Access the Chunk's wordID
	var chunkWordID = ds_grid_get(obj_chain.chunkGrid, obj_chain.chainGrid_colName, currentChunkRow);
	
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
		var chunkWordInChainsList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInBoxList, chunkWordID - 1);
		ds_list_delete(chunkWordInChainsList, 0);
	}
	
	// Remove this Chunk from the Chunk grid
	scr_gridDeleteRow(obj_chain.chunkGrid, currentChunkRow);
	
	// Print the word list of the remaining Chunks
	/*for(var listLoop = 0; listLoop < ds_grid_height(obj_chain.chunkGrid); listLoop++) {
		show_message(scr_getStringOfList(ds_grid_get(obj_chain.chunkGrid, obj_chain.chunkGrid_colBoxWordIDList, listLoop)));
	}*/
	
	// Mechnism for removing this Chunk from ay chains
	/*while(ds_grid_value_exists(obj_chain.linkGrid, obj_chain.linkGrid_colSource, 0, obj_chain.linkGrid_colSource, ds_grid_height(obj_chain.linkGrid), chunkWordID)) {
		var currentLinkGridRow =  ds_grid_value_y(obj_chain.linkGrid, obj_chain.linkGrid_colSource, 0, obj_chain.linkGrid_colSource, ds_grid_height(obj_chain.linkGrid), chunkWordID);
		ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, currentLinkGridRow, true);
		keyboard_key_press(vk_delete);
		keyboard_key_release(vk_delete);
	}*/
}
else {
// Refresh and clean
scr_refreshChainGrid();
scr_killEmptyChains(obj_chain.currentChainGrid);
obj_chain.mouseLineWordID = -1;

scr_refreshVizLinkGrid();
}