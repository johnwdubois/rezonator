///@description Remove Link or Chunk
function scr_deleteFromChain() {
	
	// get the focused chain's submap
	var chainSubMap = ds_map_find_value(global.nodeMap, obj_chain.currentFocusedChainID);
	if (!is_numeric(chainSubMap)) {
		show_debug_message("scr_deleteFromChain() ... chainSubMap is non-numeric");
		exit;
	}
	if (!ds_exists(chainSubMap, ds_type_map)) {
		show_debug_message("scr_deleteFromChain() ... chainSubMap does not exist");
		exit;
	}
	
	// get the focused entry's submap
	var focusedEntry = ds_map_find_value(chainSubMap, "focused");
	var focusedEntrySubMap = ds_map_find_value(global.nodeMap, focusedEntry);
	if (!is_numeric(focusedEntrySubMap)) {
		show_debug_message("scr_deleteFromChain() ... focusedEntrySubMap is non-numeric");
		exit;
	}
	if (!ds_exists(focusedEntrySubMap, ds_type_map)) {
		show_debug_message("scr_deleteFromChain() ... focusedEntrySubMap does not exist");
		exit;
	}
	
	// get the focused entry's sourceLink's submap
	var sourceLink = ds_map_find_value(focusedEntrySubMap, "sourceLink");
	var sourceLinkSubMap = ds_map_find_value(global.nodeMap, sourceLink);
	if (!is_numeric(sourceLinkSubMap)) {
		show_debug_message("scr_deleteFromChain() ... sourceLinkSubMap is non-numeric");
		exit;
	}
	if (!ds_exists(sourceLinkSubMap, ds_type_map)) {
		show_debug_message("scr_deleteFromChain() ... sourceLinkSubMap does not exist");
		exit;
	}
	
	// get the sourceLink's source (sourceEntry) submap
	var sourceEntry = ds_map_find_value(sourceLinkSubMap, "source");
	var sourceEntrySubMap = ds_map_find_value(global.nodeMap, sourceEntry);
	if (!is_numeric(sourceEntrySubMap)) {
		show_debug_message("scr_deleteFromChain() ... sourceEntrySubMap is non-numeric");
		exit;
	}
	if (!ds_exists(sourceEntrySubMap, ds_type_map)) {
		show_debug_message("scr_deleteFromChain() ... sourceEntrySubMap does not exist");
		exit;
	}
	
	
	
	// remove the sourceLink from sourceEntry's goalLinkList
	var sourceEntryGoalLinkList = ds_map_find_value(sourceEntrySubMap, "goalLinkList");
	var goalLinkListIndex = ds_list_find_index(sourceEntryGoalLinkList, sourceLink);
	show_debug_message("scr_deleteFromChain() ... goalLinkListIndex: " + string(goalLinkListIndex));
	ds_list_delete(sourceEntryGoalLinkList, goalLinkListIndex);
	
	// remove the sourceLink from chain's linkList
	var chainLinkList = ds_map_find_value(chainSubMap, "linkIDList");
	var chainLinkListIndex = ds_list_find_index(chainLinkList, sourceLink);
	show_debug_message("scr_deleteFromChain() ... chainLinkListIndex: " + string(chainLinkListIndex));
	ds_list_delete(chainLinkList, chainLinkListIndex);
	
	// remove sourceLink from nodeMap and destroy sourceLink
	ds_map_delete(global.nodeMap, sourceLink);
	ds_map_destroy(sourceLinkSubMap);
	
	// loop through the goals for the current entry and reset their sources to be sourceEntry
	var focusedEntryGoalLinkList = ds_map_find_value(focusedEntrySubMap, "goalLinkList");
	var focusedEntryGoalLinkListSize = ds_list_size(focusedEntryGoalLinkList);
	for (var i = 0; i < focusedEntryGoalLinkListSize; i++) {
		
		var currentGoalLink = ds_list_find_value(focusedEntryGoalLinkList, i);
		var currentGoalLinkSubMap = ds_map_find_value(global.nodeMap, currentGoalLink);
		ds_map_replace(currentGoalLinkSubMap, "source", sourceEntry);
		
		// add the currentGoalLink to its new source's goalLinkList
		ds_list_add(sourceEntryGoalLinkList, currentGoalLink);
		
	}
	
	// remove the focusedEntry from its chain's setList
	var chainSetList = ds_map_find_value(chainSubMap, "setIDList");
	var chainSetListIndex = ds_list_find_index(chainSetList, focusedEntry);
	show_debug_message("scr_deleteFromChain() ... chainSetListIndex: " + string(chainSetListIndex));
	ds_list_delete(chainSetList, chainSetListIndex);
	
	// unfocus focusedEntry
	var newFocusedEntry = (ds_exists(sourceEntrySubMap, ds_type_map)) ? sourceEntry : "";
	show_debug_message("chainSubMap: " + string(chainSubMap) + ", newFocusedEntry: " + string(newFocusedEntry));
	ds_map_replace(chainSubMap, "focused", newFocusedEntry);
	
	// removed chain from focusedEntry's word's inChainsList
	var focusedEntryWord = ds_map_find_value(focusedEntrySubMap, "word");
	var focusedEntryWordInChainsList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInChainList, focusedEntryWord - 1);
	var focusedEntryWordInChainsListIndex = ds_list_find_index(focusedEntryWordInChainsList, obj_chain.currentFocusedChainID);
	ds_list_delete(focusedEntryWordInChainsList, focusedEntryWordInChainsListIndex);
	
	// remove focusedEntry from nodeMap and destroy focusedEntry
	ds_map_delete(global.nodeMap, focusedEntry);
	ds_map_destroy(focusedEntrySubMap);
	
	
	
	scr_refreshChainGrid();
	scr_killEmptyChains(obj_chain.currentChainGrid);
	
	
	
	

	/*
	obj_control.linkDeleted = true;
	// Set variables to be used by Chunk/newWord deletion
	obj_control.currentChainGridRowInDelete = undefined;
	obj_control.gridInDelete = undefined;
	var oldHeight = -1;

	// Expirementing with deleting Chunks
	if(obj_toolPane.currentTool == obj_toolPane.toolBoxBrush || obj_toolPane.currentTool == obj_toolPane.toolNewWord || obj_control.newWordDeleted || obj_control.deleteNewWord || obj_control.deleteChunkWord) {
		//show_message("scr del");
		scr_deleteChunk();
	
	}

	// Make sure there is a focused link to be deleted
	if (ds_grid_value_exists(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, 0, obj_chain.linkGrid_colFocus, ds_grid_height(obj_chain.linkGrid), true)) {	
		show_debug_message("scr_deleteFromChain value exists");
		scr_deleteLink();

	}
	else {
		show_debug_message("scr_deleteFromChain value does not exist");
	}

	// If this Chunk has already been deleted, refresh the chain grids
	if(obj_toolPane.currentTool == obj_toolPane.toolBoxBrush || obj_toolPane.currentTool == obj_toolPane.toolNewWord || obj_control.deleteNewWord || obj_control.deleteChunkWord) {
		//show_message(obj_control.gridInDelete);	
		if(obj_control.gridInDelete != undefined) {
			ds_grid_set(obj_control.gridInDelete, obj_chain.chainGrid_colChainState, obj_control.currentChainGridRowInDelete, obj_chain.chainStateFocus);
			scr_refreshChainGrid(obj_control.gridInDelete);
			scr_killEmptyChains(obj_control.gridInDelete);
			scr_refreshVizLinkGrid();
			ds_grid_set(obj_control.gridInDelete, obj_chain.chainGrid_colChainState, obj_control.currentChainGridRowInDelete, obj_chain.chainStateNormal);
			//show_message(obj_control.gridInDelete);	
		}
		ds_grid_set_region(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, 0, obj_chain.linkGrid_colFocus, ds_grid_height(obj_chain.linkGrid), false);
		ds_grid_set_region(obj_chain.chunkGrid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(obj_chain.chunkGrid), obj_chain.chainStateNormal);
		obj_control.linkDeleted = false;
		obj_control.deleteNewWord = false;
		obj_control.deleteChunkWord = false;
		exit;	
	}
	// Most cases uses this boy
	else {
		// Refresh and clean
		scr_refreshChainGrid();
		oldHeight = ds_grid_height(obj_chain.currentChainGrid);
		scr_killEmptyChains(obj_chain.currentChainGrid);

		scr_refreshVizLinkGrid();
		obj_control.linkDeleted = false;
	}

	// If we're deleting within the search screen, make sure we don't focus on words outside of the hitGrid
	if(obj_control.currentActiveLineGrid == obj_control.searchGrid) {
		var rowInLinkGridSource = scr_findInGridTwoParameters(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, true, obj_chain.linkGrid_colDead, false);
		//show_message(string(rowInLinkGridSource));
		if(rowInLinkGridSource > -1) {
			var currentSourceID = ds_grid_get(obj_chain.linkGrid, obj_chain.linkGrid_colSource, rowInLinkGridSource);
			if(ds_grid_value_y(obj_control.hitGrid, obj_control.hitGrid_colWordID, 0, obj_control.hitGrid_colWordID, ds_grid_height(obj_control.hitGrid), currentSourceID) < 0)	{
				//show_message(string(currentSourceID));
				ds_grid_set(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, rowInLinkGridSource, false);
			}
		}
	}

	// Check if the newly dead link is focused
	if (ds_grid_value_exists(obj_chain.linkGrid, obj_chain.linkGrid_colFocus, 0, obj_chain.linkGrid_colFocus, ds_grid_height(obj_chain.linkGrid), true)) {
	
		scr_deadLinkFocusCheck();
	
	}

	obj_control.deleteNewWord = false;
	obj_control.deleteChunkWord = false;
	*/

}
