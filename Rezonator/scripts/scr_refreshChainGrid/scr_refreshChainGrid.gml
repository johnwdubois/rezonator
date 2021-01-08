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
	var oldIDListSize = ds_list_size(oldIDList);
	for (var i = 0; i < oldIDListSize; i++) {
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
				var currentChunkWordIDListSize = ds_list_size(currentChunkWordIDList);
				for (var chunkWordsLoop = 0; chunkWordsLoop < currentChunkWordIDListSize; chunkWordsLoop++) {
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


	var tempGrid = ds_grid_create(ds_grid_width(obj_chain.linkGrid), ds_grid_height(obj_chain.linkGrid));
	ds_grid_copy(tempGrid, obj_chain.linkGrid);


	var idList = ds_list_create();

	// check all links in linkGrid from this chainID, and add the living (non-dead) links to idList
	var rowInTempGrid = ds_grid_value_y(tempGrid, obj_chain.linkGrid_colChainID, 0, obj_chain.linkGrid_colChainID, ds_grid_height(tempGrid), chainID);
	while (rowInTempGrid > -1) {
		
		var source = ds_grid_get(tempGrid, obj_chain.linkGrid_colSource, rowInTempGrid);
		var goal = ds_grid_get(tempGrid, obj_chain.linkGrid_colGoal, rowInTempGrid);
		var dead = ds_grid_get(tempGrid, obj_chain.linkGrid_colDead, rowInTempGrid);
		
		// set the found cell to be -1 so it isn't found again in the next while loop
		ds_grid_set(tempGrid, obj_chain.linkGrid_colChainID, rowInTempGrid, -1);
		
		// do not add wordID to idList if the word is dead or the source is -1
		if (dead) {
			rowInTempGrid = ds_grid_value_y(tempGrid, obj_chain.linkGrid_colChainID, 0, obj_chain.linkGrid_colChainID, ds_grid_height(tempGrid), chainID);
			continue;
		}
		if (source == -1) {
			rowInTempGrid = ds_grid_value_y(tempGrid, obj_chain.linkGrid_colChainID, 0, obj_chain.linkGrid_colChainID, ds_grid_height(tempGrid), chainID);
			continue;
		}
		
		// make sure wordID is not already in idList before adding it
		if (ds_list_find_index(idList, source) == -1) {
			ds_list_add(idList, source);
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
	
	show_debug_message("scr_refreshChainGrid() ... idList: " + scr_getStringOfList(idList));
	
	// if this is a trackChain, get the trackIDList
	var trackIDList = -1;
	if (grid == obj_chain.trackChainGrid) {
		var trackChainMap = ds_map_find_value(global.nodeMap, chainID);
		if (ds_exists(trackChainMap, ds_type_map)) {
			trackIDList = ds_map_find_value(trackChainMap, "trackIDList");
		}
	}
	

	if (grid == obj_chain.rezChainGrid || grid == obj_chain.trackChainGrid) {

		// Create a temp grid 3 col's wide and the list size high
		var tempListGrid = ds_grid_create(3, ds_list_size(idList));
		var tempListGrid_colWordID = 0;
		var tempListGrid_colUnitID = 1;
		var tempListGrid_colWordSeq = 2;
		
		

		// Populate Grid with wordID's from list
		var idListSize = ds_list_size(idList);
		for (var idListLoop = 0; idListLoop < idListSize; idListLoop++) {
			var currentWordID = ds_list_find_value(idList, idListLoop);
	
			// Pull UnitID and wordSeq info from wordGrid
			var currentUnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWordID - 1);
			var currentWordSeq = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colWordSeq, currentWordID - 1);
			
			ds_grid_set(tempListGrid, tempListGrid_colWordID, idListLoop, currentWordID);
			ds_grid_set(tempListGrid, tempListGrid_colUnitID, idListLoop, currentUnitID);
			ds_grid_set(tempListGrid, tempListGrid_colWordSeq, idListLoop, currentWordSeq);
			
		}

		// Multicolumn sort the grid based on UnitID and WordSeq
		scr_gridMultiColSort(tempListGrid, tempListGrid_colUnitID, true, tempListGrid_colWordSeq, true);
		ds_list_clear(idList);

		// Copy first column into idList
		var tempListGridHeight = ds_grid_height(tempListGrid);
		for (var idListLoop = 0; idListLoop < tempListGridHeight; idListLoop++) {
			var currentWordID = ds_grid_get(tempListGrid, tempListGrid_colWordID, idListLoop);
			ds_list_add(idList, currentWordID);
		}
		
		// destroy previous idList
		ds_list_destroy(oldIDList);

		// put new idList back into rezChainGrid/trackChainGrid
		ds_grid_set(grid, obj_chain.chainGrid_colWordIDList, rowInChainGrid, idList);

		// draw rectangle borders around these proper wordIDs
		var idListSize = ds_list_size(idList);
		for (var i = 0; i < idListSize; i++) {
			if (grid == obj_chain.rezChainGrid or grid == obj_chain.trackChainGrid) {
				var currentID = ds_list_find_value(idList, i);
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

		ds_grid_destroy(tempGrid);
		ds_grid_destroy(tempListGrid);
	}
	else if (grid == obj_chain.stackChainGrid) {
		
		// destroy previous idList
		ds_list_destroy(oldIDList);
		
		// put new idList back into stackChainGrid
		ds_grid_set(grid, obj_chain.chainGrid_colWordIDList, rowInChainGrid, idList);
	}
	
	
	// go into nodeMap and update idList for this chain
	var subMap = ds_map_find_value(global.nodeMap, chainID);
	if (ds_exists(subMap, ds_type_map) && ds_exists(idList, ds_type_list)) {
		if (ds_map_exists(subMap, "wordIDList")) {
			ds_map_replace_list(subMap, "wordIDList", idList);
		}
	}


}
