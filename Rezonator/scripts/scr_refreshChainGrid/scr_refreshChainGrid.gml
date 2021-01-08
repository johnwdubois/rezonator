function scr_refreshChainGrid() {
	/*
		scr_refreshChainGrid();
	
		Last Updated: 2018-09-11
	
		Called from: any object
	
		Purpose: update the chainGrid of the current selected tool, so that the chains have all the link
				information they need
	
		Mechanism: search the idLists in the chainGrid and refresh them, adding or removing ID values
					based on the information from the linkGrid
	
		Author: Terry DuBois
	*/

	
	show_debug_message("scr_refreshChainGrid()");

	var grid = obj_chain.rezChainGrid;

	// find which grid we are dealing with (depending on current tool)
	switch (obj_toolPane.currentTool) {
		case obj_toolPane.toolRezBrush:
			grid = obj_chain.rezChainGrid;
			break;
		case obj_toolPane.toolTrackBrush:
			grid = obj_chain.trackChainGrid;
			break;
		case obj_toolPane.toolStackBrush:
			grid = obj_chain.stackChainGrid;
			break;
		case obj_toolPane.toolBoxBrush:
			grid = argument[0];
			break;
		case obj_toolPane.toolNewWord:
			grid = argument[0];
			break;
		default:
			break;
	}

	// find the focused chain in this grid. if there are no focused chains in this grid, exit the script
	var rowInChainGrid = ds_grid_value_y(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(grid), obj_chain.chainStateFocus);
	if (rowInChainGrid >= 0) {
		var chainID = ds_grid_get(grid, obj_chain.chainGrid_colChainID, rowInChainGrid);
	}
	else {
		exit;
	}

	// stop drawing the rectangle around the words in this chain
	var oldIDList = ds_grid_get(grid, obj_chain.chainGrid_colWordIDList, rowInChainGrid);
	var oldsetIDListSize = ds_list_size(oldIDList);
	for (var i = 0; i < oldsetIDListSize; i++) {
		var currentID = ds_list_find_value(oldIDList, i);
		var currentInChainList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInChainList, currentID - 1);
		if (grid == obj_chain.rezChainGrid || grid == obj_chain.trackChainGrid) {
			ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colBorder, currentID - 1, false);
			ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colEffectColor, currentID - 1, -1);
			if (ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentID - 1) == obj_control.wordStateRed) {
				ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentID - 1, obj_control.wordStateNormal);
			}
		
			// Will need to check for red Chunks as well
			if (ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentID - 1) == obj_control.wordStateChunk) {
				var currentChunkGridRow = ds_grid_value_y(obj_chain.chunkGrid, obj_chain.chainGrid_colName, 0, obj_chain.chainGrid_colName, ds_grid_height(obj_chain.chunkGrid), currentID);
				var currentChunkWordIDList = ds_grid_get(obj_chain.chunkGrid, obj_chain.chunkGrid_colBoxWordIDList, currentChunkGridRow);
				// Loop through the Chunk's wordID list and make sure none are red
				var currentChunkWordsetIDListSize = ds_list_size(currentChunkWordIDList);
				for (var chunkWordsLoop = 0; chunkWordsLoop < currentChunkWordsetIDListSize; chunkWordsLoop++) {
					var currentChunkWord = ds_list_find_value(currentChunkWordIDList, chunkWordsLoop);
					if (ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentChunkWord - 1) == obj_control.wordStateRed) {
						ds_grid_set(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colWordState, currentChunkWord - 1, obj_control.wordStateNormal);
					}
				}
			}
		
			// Prevent this word from losing its border if it belongs to another chain
			var alternateChainGrid = (grid == obj_chain.rezChainGrid) ? obj_chain.trackChainGrid : obj_chain.rezChainGrid
			if (ds_list_size(currentInChainList) > 0) {
				var currentInChainListSize = ds_list_size(currentInChainList);
				for (var inChainListLoop = 0; inChainListLoop < currentInChainListSize; inChainListLoop++) {
					var inListChainID = ds_list_find_value(currentInChainList, inChainListLoop);
					var currentLinkGridPos = scr_findInGridTwoParameters(obj_chain.linkGrid, obj_chain.linkGrid_colChainID, inListChainID, obj_chain.linkGrid_colTier, obj_chain.trackTier);
					if (currentLinkGridPos != -1) {
						ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colBorderRounded, currentID - 1, true);
						ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colBorder, currentID - 1, true);
						var currentRowInChainGrid = ds_grid_value_y(alternateChainGrid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(alternateChainGrid), inListChainID);
						var effectColor = ds_grid_get(alternateChainGrid, obj_chain.chainGrid_colColor, currentRowInChainGrid);
						ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colEffectColor, currentID - 1, effectColor);
					}
				}
			}
		}
	}


	/*

	var tempGrid = ds_grid_create(ds_grid_width(obj_chain.linkGrid), ds_grid_height(obj_chain.linkGrid));
	ds_grid_copy(tempGrid, obj_chain.linkGrid);


	var setIDList = ds_list_create();

	// check all links in linkGrid from this chainID, and add the living (non-dead) links to setIDList
	var rowInTempGrid = ds_grid_value_y(tempGrid, obj_chain.linkGrid_colChainID, 0, obj_chain.linkGrid_colChainID, ds_grid_height(tempGrid), chainID);
	while (rowInTempGrid > -1) {
		
		var source = ds_grid_get(tempGrid, obj_chain.linkGrid_colSource, rowInTempGrid);
		var goal = ds_grid_get(tempGrid, obj_chain.linkGrid_colGoal, rowInTempGrid);
		var dead = ds_grid_get(tempGrid, obj_chain.linkGrid_colDead, rowInTempGrid);
		
		// set the found cell to be -1 so it isn't found again in the next while loop
		ds_grid_set(tempGrid, obj_chain.linkGrid_colChainID, rowInTempGrid, -1);
		
		// do not add wordID to setIDList if the word is dead or the source is -1
		if (dead) {
			rowInTempGrid = ds_grid_value_y(tempGrid, obj_chain.linkGrid_colChainID, 0, obj_chain.linkGrid_colChainID, ds_grid_height(tempGrid), chainID);
			continue;
		}
		if (source == -1) {
			rowInTempGrid = ds_grid_value_y(tempGrid, obj_chain.linkGrid_colChainID, 0, obj_chain.linkGrid_colChainID, ds_grid_height(tempGrid), chainID);
			continue;
		}
		
		// make sure wordID is not already in setIDList before adding it
		if (ds_list_find_index(setIDList, source) == -1) {
			ds_list_add(setIDList, source);
		}
	
		if (obj_toolPane.currentTool == obj_toolPane.toolStackBrush) {
			if (!is_undefined(chainID)) {
				ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStack, source - 1, chainID);
				ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStackType, source - 1, obj_control.activeStackType);
				if (goal != -1) {
					ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStack, goal - 1, chainID);
					ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStackType, goal - 1, obj_control.activeStackType);
				}
			}
		}
		
		// search again in tempGrid to continue the while loop
		rowInTempGrid = ds_grid_value_y(tempGrid, obj_chain.linkGrid_colChainID, 0, obj_chain.linkGrid_colChainID, ds_grid_height(tempGrid), chainID);
	}
	
	show_debug_message("scr_refreshChainGrid() ... setIDList: " + scr_getStringOfList(setIDList));
	
	// if this is a trackChain, get the trackIDList
	var trackIDList = -1;
	if (grid == obj_chain.trackChainGrid) {
		var trackChainMap = ds_map_find_value(global.nodeMap, chainID);
		if (ds_exists(trackChainMap, ds_type_map)) {
			trackIDList = ds_map_find_value(trackChainMap, "trackIDList");
		}
	}
	
	*/
	
	
	
	
	// get setIDList for this chain
	var chainSubMap = ds_map_find_value(global.nodeMap, chainID);
	if (!is_numeric(chainSubMap)) {
		show_debug_message("scr_refreshChainGrid() ... ERROR: chainSubMap is non-numeric");
		exit;
	}
	if (!ds_exists(chainSubMap, ds_type_map)) {
		show_debug_message("scr_refreshChainGrid() ... ERROR: no map for chainSubMap");
		exit;
	}
	var setIDList = ds_map_find_value(chainSubMap, "setIDList");
	if (!is_numeric(setIDList)) {
		show_debug_message("scr_refreshChainGrid() ... ERROR: setIDList is non-numeric");
		exit;
	}
	if (!ds_exists(setIDList, ds_type_list)) {
		show_debug_message("scr_refreshChainGrid() ... ERROR: no list for setIDList");
		exit;
	}
	
	
	
	var newIDList = ds_list_create();
	

	if (grid == obj_chain.rezChainGrid || grid == obj_chain.trackChainGrid) {

		// Create a temp grid 3 col's wide and the list size high
		var tempListGrid = ds_grid_create(4, ds_list_size(setIDList));
		var tempListGrid_colWordID = 0;
		var tempListGrid_colSetID = 1;
		var tempListGrid_colUnitID = 2;
		var tempListGrid_colWordSeq = 3;

		// Populate Grid with wordID's from list
		var setIDListSize = ds_list_size(setIDList);
		for (var i = 0; i < setIDListSize; i++) {
			
			// get currentSet from chain's setIDList
			var currentSetID = ds_list_find_value(setIDList, i);
			var currentSetSubMap = ds_map_find_value(global.nodeMap, currentSetID);
			if (is_numeric(currentSetSubMap)) {
				if (ds_exists(currentSetSubMap, ds_type_map)) {
					
					// get wordID from currentSet
					var currentWordID = ds_map_find_value(currentSetSubMap, "word");
	
					// Pull UnitID and wordSeq info from wordGrid
					var currentUnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWordID - 1);
					var currentWordSeq = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentWordID - 1);
			
					ds_grid_set(tempListGrid, tempListGrid_colWordID, i, currentWordID);
					ds_grid_set(tempListGrid, tempListGrid_colSetID, i, currentSetID);
					ds_grid_set(tempListGrid, tempListGrid_colUnitID, i, currentUnitID);
					ds_grid_set(tempListGrid, tempListGrid_colWordSeq, i, currentWordSeq);
				}
			}
		}

		// Multicolumn sort the grid based on UnitID and WordSeq
		scr_gridMultiColSort(tempListGrid, tempListGrid_colUnitID, true, tempListGrid_colWordSeq, true);
		ds_list_clear(setIDList);

		// Copy sorted wordIDs into wordIDList and sorted setIDs into setIDList
		var tempListGridHeight = ds_grid_height(tempListGrid);
		for (var i = 0; i < tempListGridHeight; i++) {
			var currentWordID = ds_grid_get(tempListGrid, tempListGrid_colWordID, i);
			var currentSetID = ds_grid_get(tempListGrid, tempListGrid_colSetID, i);
			ds_list_add(newIDList, currentWordID);
			ds_list_add(setIDList, currentSetID);
		}
		
		// destroy previous wordIDList
		ds_list_destroy(oldIDList);

		// put new setIDList back into rezChainGrid/trackChainGrid
		ds_grid_set(grid, obj_chain.chainGrid_colWordIDList, rowInChainGrid, newIDList);

		// draw rectangle borders around these proper wordIDs
		var wordIDListSize = ds_list_size(newIDList);
		for (var i = 0; i < wordIDListSize; i++) {
			if (grid == obj_chain.rezChainGrid or grid == obj_chain.trackChainGrid) {
				var currentID = ds_list_find_value(newIDList, i);
				var chainColor = ds_grid_get(grid, obj_chain.chainGrid_colColor, rowInChainGrid);
				ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colBorder, currentID - 1, true);
				ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colEffectColor, currentID - 1, chainColor);
		
				if (grid == obj_chain.rezChainGrid) {
					ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colBorderRounded, currentID - 1, false);
				}
				else if (grid == obj_chain.trackChainGrid) {
					ds_grid_set(obj_control.wordDrawGrid, obj_control.wordDrawGrid_colBorderRounded, currentID - 1, true);
				}
			}
		}

		//ds_grid_destroy(tempGrid);
		ds_grid_destroy(tempListGrid);
	}
	else if (grid == obj_chain.stackChainGrid) {
		
		// Create a temp grid 3 col's wide and the list size high
		var tempListGrid = ds_grid_create(2, ds_list_size(setIDList));
		var tempListGrid_colSetID = 0;
		var tempListGrid_colUnitID = 1;
		
		// Populate Grid with wordID's from list
		var setIDListSize = ds_list_size(setIDList);
		for (var i = 0; i < setIDListSize; i++) {
			
			// get currentSet from chain's setIDList
			var currentSetID = ds_list_find_value(setIDList, i);
			var currentSetSubMap = ds_map_find_value(global.nodeMap, currentSetID);
			if (is_numeric(currentSetSubMap)) {
				if (ds_exists(currentSetSubMap, ds_type_map)) {
					
					// get unitID from currentSet
					var currentUnitID = ds_map_find_value(currentSetSubMap, "unit");
			
					ds_grid_set(tempListGrid, tempListGrid_colUnitID, i, currentUnitID);
					ds_grid_set(tempListGrid, tempListGrid_colSetID, i, currentSetID);
				}
			}
		}
		
		// sort the grid based on UnitID
		ds_grid_sort(tempListGrid, tempListGrid_colUnitID, true);
		ds_list_clear(setIDList);

		// Copy sorted unitIDs into unitIDList and sorted setIDs into setIDList
		var tempListGridHeight = ds_grid_height(tempListGrid);
		for (var i = 0; i < tempListGridHeight; i++) {
			var currentUnitID = ds_grid_get(tempListGrid, tempListGrid_colUnitID, i);
			var currentSetID = ds_grid_get(tempListGrid, tempListGrid_colSetID, i);
			ds_list_add(newIDList, currentUnitID);
			ds_list_add(setIDList, currentSetID);
			
			// set unitInStackGrid
			ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStack, currentUnitID - 1, chainID);
			ds_grid_set(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStackType, currentUnitID - 1, obj_control.activeStackType);
		}
		
		// destroy previous wordIDList
		ds_list_destroy(oldIDList);

		// put new setIDList back into rezChainGrid/trackChainGrid
		ds_grid_set(grid, obj_chain.chainGrid_colWordIDList, rowInChainGrid, newIDList);
	}


}
