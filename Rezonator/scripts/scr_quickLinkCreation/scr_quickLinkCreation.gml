// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_quickLinkCreation(){
	if (current_time - sessionStartTime < 2000 or not quickLinkAllowed) {
		exit;
	}

	var gridOfFutureChainsWidth = 3;
	var gridOfFutureChains_colDisplayCol = 0;
	var gridOfFutureChains_colWordIDList = 1;
	var gridOfFutureChains_colFocused = 2;
	var gridOfFutureChains = ds_grid_create(gridOfFutureChainsWidth, 0);
	if (ds_list_size(inRectWordIDList) > 0) {
		moveCounter++;
	}

	// Use the wordList or hitList depending on the context
	var inRectList = ds_list_create();
	if(obj_toolPane.currentTool == obj_toolPane.toolTrackBrush){
		// Ensure the gesture is correct for a trackChunk
		if(not searchGridActive and obj_control.mouseRectWithinLine) {
			alarm[10] = 1;
			exit;
		}
		ds_list_copy(inRectList, inRectHitIDList);
	} 
	else {
		// Ensure the gesture is correct for a rezChunk
		if(not searchGridActive and obj_control.mouseRectWithinLine) {
			alarm[10] = 1;
			exit;
		}
		ds_list_copy(inRectList, inRectWordIDList);
	}


	for (var i = 0; i < ds_list_size(inRectList); i++) {
		var currentWordID = ds_list_find_value(inRectList, i);
		// Access the display column of the relevent grid
		if(obj_toolPane.currentTool == obj_toolPane.toolTrackBrush){
			// Instead hitID
			var currentDisplayCol = ds_grid_get(hitGrid, hitGrid_colDisplayCol, currentWordID - 1);
		}
		else {
			// Instead hitID
			var currentDisplayCol = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayCol, currentWordID - 1);
		}

		// Mechanism for splitting wordLists into their respective dislayColumns
		var rowInFutureChainGrid = ds_grid_value_y(gridOfFutureChains, gridOfFutureChains_colDisplayCol, 0, gridOfFutureChains_colDisplayCol, ds_grid_height(gridOfFutureChains), currentDisplayCol);
		if (rowInFutureChainGrid < 0 or ds_grid_height(gridOfFutureChains) < 1) {
			ds_grid_resize(gridOfFutureChains, gridOfFutureChainsWidth, ds_grid_height(gridOfFutureChains) + 1);
		
			var newWordIDList = ds_list_create();
			ds_list_add(newWordIDList, ds_list_find_value(inRectWordIDList, i));
		
			ds_grid_set(gridOfFutureChains, gridOfFutureChains_colDisplayCol, ds_grid_height(gridOfFutureChains) - 1, currentDisplayCol);
			ds_grid_set(gridOfFutureChains, gridOfFutureChains_colWordIDList, ds_grid_height(gridOfFutureChains) - 1, newWordIDList);
			ds_grid_set(gridOfFutureChains, gridOfFutureChains_colFocused, ds_grid_height(gridOfFutureChains) - 1, false);
		
		}
		else {
			var displayColList = ds_grid_get(gridOfFutureChains, gridOfFutureChains_colWordIDList, rowInFutureChainGrid);
			ds_list_add(displayColList, ds_list_find_value(inRectWordIDList, i));
		}
	}

	// Keep the focus of chains during the process
	if (obj_chain.currentFocusedChainID != "") {
	
		// Keep the focus of track chains
		if(obj_toolPane.currentTool == obj_toolPane.toolTrackBrush){

			var focusedChainSubMap = ds_map_find_value(global.nodeMap, obj_chain.currentFocusedChainID);
			if (is_numeric(focusedChainSubMap)) {
				if (ds_exists(focusedChainSubMap, ds_type_map)) {
				
					var setIDList = ds_map_find_value(focusedChainSubMap, "setIDList");
					var setIDListSize = ds_list_size(setIDList);
					
					if (setIDListSize > 0) {
						
						var focusedChainFirstEntry = ds_list_find_value(setIDList, 0);
						var focusedChainFirstEntrySubMap = ds_map_find_value(global.nodeMap, focusedChainFirstEntry);
						var focusedChainFirstWordID = ds_map_find_value(focusedChainFirstEntrySubMap, "word");
					
						if(obj_toolPane.currentTool == obj_toolPane.toolTrackBrush) {
							var focusedChainFirstHitGridRow = ds_grid_value_y(obj_control.hitGrid, obj_control.hitGrid_colWordID, 0, obj_control.hitGrid_colWordID, ds_grid_height(obj_control.hitGrid), focusedChainFirstWordID);
							var firstItemDisplayCol = ds_grid_get(obj_control.hitGrid, obj_control.hitGrid_colDisplayCol, focusedChainFirstHitGridRow);
						}
						else {
							var firstItemDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, focusedChainFirstWordID - 1);
						}
						// Change this to hitGrid
				
						var gridOfFutureChainsHeight = ds_grid_height(gridOfFutureChains);
						for (var i = 0; i < ds_grid_height(gridOfFutureChains); i++) {
							var currentRowDisplayCol = ds_grid_get(gridOfFutureChains, gridOfFutureChains_colDisplayCol, i);
							if (currentRowDisplayCol == firstItemDisplayCol) {
								ds_grid_set(gridOfFutureChains, gridOfFutureChains_colFocused, i, true);
							}
						}
						ds_grid_sort(gridOfFutureChains, gridOfFutureChains_colFocused, false);
					}
				}
			}
		
		}
		// Keep the focus of Rez chains
		else {
		
			var focusedChainSubMap = ds_map_find_value(global.nodeMap, obj_chain.currentFocusedChainID);
			if (is_numeric(focusedChainSubMap)) {
				if (ds_exists(focusedChainSubMap, ds_type_map)) {
				
					var focusedChainType = ds_map_find_value(focusedChainSubMap, "type");
					if (focusedChainType == "rezChain") {
						var setIDList = ds_map_find_value(focusedChainSubMap, "setIDList");
						var setIDListSize = ds_list_size(setIDList);
					
						if (setIDListSize > 0) {
						
							var focusedChainFirstEntry = ds_list_find_value(setIDList, 0);
							var focusedChainFirstEntrySubMap = ds_map_find_value(global.nodeMap, focusedChainFirstEntry);
							var focusedChainFirstWordID = ds_map_find_value(focusedChainFirstEntrySubMap, "word");
							var firstItemDisplayCol = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colDisplayCol, focusedChainFirstWordID - 1);
						
							var gridOfFutureChainsHeight = ds_grid_height(gridOfFutureChains);
							for (var i = 0; i < gridOfFutureChainsHeight; i++) {
								var currentRowDisplayCol = ds_grid_get(gridOfFutureChains, gridOfFutureChains_colDisplayCol, i);
								if (currentRowDisplayCol == firstItemDisplayCol) {
									ds_grid_set(gridOfFutureChains, gridOfFutureChains_colFocused, i, true);
								}
							}
							ds_grid_sort(gridOfFutureChains, gridOfFutureChains_colFocused, false);
						}
					}
				}
			}
		}
	
	}

	// Using the organized grid, simulate clicks to create the chains
	if (ds_grid_height(gridOfFutureChains) > 0) {

		var gridOfFutureChainsHeight = ds_grid_height(gridOfFutureChains);
		for (var i = 0; i < ds_grid_height(gridOfFutureChains); i++) {
			var currentList = ds_grid_get(gridOfFutureChains, gridOfFutureChains_colWordIDList, i);

			if (ds_list_size(currentList) > 1) {
			
				for (var j = 0; j < ds_list_size(currentList); j++) {
					var currentWordID = ds_list_find_value(currentList, j);
					if (currentWordID >= 1 and currentWordID <= ds_grid_height(obj_control.wordGrid)) {
						var currentUnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWordID - 1);
						with (obj_chain) {
							scr_wordClicked(currentWordID, currentUnitID);
						}
					}
				}
			}
			scr_unFocusAllChains();
	
			ds_list_destroy(currentList);
		}
	
		scr_setAllValuesInCol(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colFillRect, false);
	}

	// Clear the data structures
	ds_grid_destroy(gridOfFutureChains);
	obj_control.mouseRectBeginInWord = -1;
	obj_control.mouseRectBeginBetweenWords = -1;

	ds_list_clear(inRectWordIDList);
	ds_list_clear(inRectHitIDList);
}