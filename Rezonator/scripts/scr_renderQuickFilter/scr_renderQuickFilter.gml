function scr_renderQuickFilter() {
	/*
		Purpose: clear and then populate quickFilterGrid with necessary units
	*/
	
	if (instance_exists(obj_dialogueBox)) {
		exit;
	}
	
	// get submap of focused chain
	var chainSubMap = ds_map_find_value(global.nodeMap, obj_control.quickPickedChainID);
	if (is_numeric(chainSubMap)){
		if (ds_exists(chainSubMap, ds_type_map)){
			var chainType = ds_map_find_value(chainSubMap, "type");
	
			// reset quick filter grid
			ds_grid_destroy(quickFilterGrid);
			quickFilterGrid = ds_grid_create(lineGridWidth, 0);


			var setIDList = ds_map_find_value(chainSubMap, "vizSetIDList");
			var setIDListSize = ds_list_size(setIDList);
	
			scr_updateDisplayRow();
	
	
	
			if (chainType == "stackChain") {
		
				// get unitIDs for this stack and put them in a temporary list
				var unitIDList = ds_list_create();
				for (var i = 0; i < setIDListSize; i++) {
					var currentEntry = ds_list_find_value(setIDList, i);
					var currentEntrySubMap = ds_map_find_value(global.nodeMap, currentEntry);
					var currentUnitID = ds_map_find_value(currentEntrySubMap, "unit");
					if (ds_list_find_index(unitIDList, currentUnitID) == -1) {
						ds_list_add(unitIDList, currentUnitID);
					}
				}
		
				// go through line grid and see if units have a match in unitIDList
				var lineGridHeight = ds_grid_height(obj_control.lineGrid);
				for (var i = 0; i < lineGridHeight; i++) {
					var currentUnitID = ds_grid_get(obj_control.lineGrid,obj_control.lineGrid_colUnitID, i);
					if (ds_list_find_index(unitIDList, currentUnitID) >= 0) {
				
						var currentWordIDList = ds_grid_get(lineGrid, lineGrid_colWordIDList, i);
						var currentDiscoID = ds_grid_get(lineGrid, lineGrid_colDiscoID, i);
						var currentUtteranceID = ds_grid_get(lineGrid, lineGrid_colUnitID, i);
				
						// grow the quickFilter grid
						ds_grid_resize(quickFilterGrid, lineGridWidth, ds_grid_height(quickFilterGrid) + 1);
						var currentRowquickFilterGrid = ds_grid_height(quickFilterGrid) - 1;
				
						// set new values in quickFilter
						ds_grid_set(quickFilterGrid, lineGrid_colDisplayRow, currentRowquickFilterGrid, currentRowquickFilterGrid);
						ds_grid_set(quickFilterGrid, lineGrid_colLineState, currentRowquickFilterGrid, 0);
						ds_grid_set(quickFilterGrid, lineGrid_colUnitID, currentRowquickFilterGrid, currentUtteranceID);
						ds_grid_set(quickFilterGrid, lineGrid_colPixelY, currentRowquickFilterGrid, (currentRowquickFilterGrid * obj_control.gridSpaceVertical));
						ds_grid_set(quickFilterGrid, lineGrid_colPixelYOriginal, currentRowquickFilterGrid, (currentRowquickFilterGrid * obj_control.gridSpaceVertical));
						ds_grid_set(quickFilterGrid, lineGrid_colDiscoID, currentRowquickFilterGrid, currentDiscoID);
						ds_grid_set(quickFilterGrid, lineGrid_colLineNumberLabel, currentRowquickFilterGrid, currentUtteranceID);
						ds_grid_set(quickFilterGrid, lineGrid_colWordIDList, currentRowquickFilterGrid, currentWordIDList);
				
					}
				}
				ds_list_destroy(unitIDList);
			}
			else if (chainType == "rezChain" || chainType == "trackChain") {
		
				// set information in quickFilterGrid for words in this chain
				for (var i = 0; i < setIDListSize; i++) {
			
					// get submap for currentEntry
					var currentEntry = ds_list_find_value(setIDList, i);
					var currentEntrySubMap = ds_map_find_value(global.nodeMap, currentEntry);
					if (!is_numeric(currentEntrySubMap)) continue;
					if (!ds_exists(currentEntrySubMap, ds_type_map)) continue;
			
					var currentWordID = ds_map_find_value(currentEntrySubMap, "token");
					if (scr_isChunk(currentWordID)) currentWordID = scr_getFirstWordOfChunk(currentWordID);
					var currentUnitID = ds_grid_get(wordGrid, wordGrid_colUnitID, currentWordID - 1);
					var currentDisplayRow = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayRow, currentWordID - 1);
			
					if (ds_grid_value_exists(quickFilterGrid, lineGrid_colUnitID, 0, lineGrid_colUnitID, ds_grid_height(quickFilterGrid), currentUnitID)) {
						continue;
					}
			
					var rowInLineGrid = ds_grid_value_y(lineGrid, lineGrid_colDisplayRow,0,lineGrid_colDisplayRow,ds_grid_height(lineGrid), currentDisplayRow )
					var currentWordIDList = ds_grid_get(lineGrid, lineGrid_colWordIDList, rowInLineGrid);
					var currentDiscoID = ds_grid_get(lineGrid, lineGrid_colDiscoID, rowInLineGrid);
					var currentUtteranceID = ds_grid_get(lineGrid, lineGrid_colUnitID, rowInLineGrid);
		
					show_debug_message("scr_renderQuickFilter() ... WID:  " + string(currentWordID) + ", currentDisplayRow:  " + string(currentDisplayRow) + ", rowInLineGrid:  " + string(rowInLineGrid) + ", currentWordIDListUnitGrid:  " + scr_getStringOfList(currentWordIDList));
			
					ds_grid_resize(quickFilterGrid, lineGridWidth, ds_grid_height(quickFilterGrid) + 1);
					var currentRowquickFilterGrid = ds_grid_height(quickFilterGrid) - 1;
			
					ds_grid_set(quickFilterGrid, lineGrid_colDisplayRow, currentRowquickFilterGrid, currentRowquickFilterGrid);
					ds_grid_set(quickFilterGrid, lineGrid_colLineState, currentRowquickFilterGrid, 0);
					ds_grid_set(quickFilterGrid, lineGrid_colUnitID, currentRowquickFilterGrid, currentUnitID);
					ds_grid_set(quickFilterGrid, lineGrid_colPixelY, currentRowquickFilterGrid, (currentRowquickFilterGrid * obj_control.gridSpaceVertical));
					ds_grid_set(quickFilterGrid, lineGrid_colPixelYOriginal, currentRowquickFilterGrid, (currentRowquickFilterGrid * obj_control.gridSpaceVertical));
					ds_grid_set(quickFilterGrid, lineGrid_colDiscoID, currentRowquickFilterGrid, currentDiscoID);
					ds_grid_set(quickFilterGrid, lineGrid_colLineNumberLabel, currentRowquickFilterGrid, currentUnitID);
					ds_grid_set(quickFilterGrid, lineGrid_colWordIDList, currentRowquickFilterGrid, currentWordIDList);
				}
		
			}
	
	
		}
	}
	
	// sort filterGrid
	ds_grid_sort(quickFilterGrid, lineGrid_colUnitID, true);
	var filterGridHeight = ds_grid_height(quickFilterGrid);
	for (var i = 0; i < filterGridHeight; i++) {
		ds_grid_set(quickFilterGrid, lineGrid_colDisplayRow, i, i);
	}

	var firstUnit = ds_grid_get(quickFilterGrid, lineGrid_colUnitID, 0);
	var lastUnit = ds_grid_get(quickFilterGrid, lineGrid_colUnitID, ds_grid_height(quickFilterGrid) - 1);
	show_debug_message("FIRST UNIT: " + string(firstUnit));
	show_debug_message("LAST UNIT: " + string(lastUnit));

	if (firstUnit == undefined or lastUnit == undefined) { // If there's no units to be filtered, hop back to the main screen

		// If filter is active, deactivate it
		if (obj_control.quickFilterGridActive) {
			if(obj_control.currentCenterDisplayRow >= 0) { // Make sure the current center display row is within bounds
				// Keep the focus on previous currentCenterDisplayRow
				with (obj_control) {
					alarm[5] = 3;
				}
			}
		}
		// Switch to active grid
		obj_control.quickFilterGridActive = false;
		obj_control.currentActiveLineGrid = obj_control.lineGrid;
		exit;
	}
	
	// Set filter to Prior Context (Before)
	if (obj_panelPane.functionFilter_peek[0] == 1) {
	
		for (var i = 0; i < firstUnit - 1; i++) {
			if (i < 0 or i > ds_grid_height(unitGrid)) {
				continue;
			}
		
			var currentUnitID = ds_grid_get(unitGrid, unitGrid_colUnitID, i);
		
			if (ds_grid_value_exists(quickFilterGrid, lineGrid_colUnitID, 0, lineGrid_colUnitID, ds_grid_height(quickFilterGrid), currentUnitID)) {
				continue;
			}
			
			if (currentUnitID == undefined or !is_numeric(currentUnitID)) { // If there's no units to be filtered, hop back to the main screen

				// If filter is active, deactivate it
				if (obj_control.quickFilterGridActive) {
					if(obj_control.currentCenterDisplayRow >= 0) { // Make sure the current center display row is within bounds
						// Keep the focus on previous currentCenterDisplayRow
						with (obj_control) {
							alarm[5] = 3;
						}
					}
				}
				// Switch to active grid
				obj_control.quickFilterGridActive = false;
				obj_control.currentActiveLineGrid = obj_control.lineGrid;
				exit;
			}
			
			var currentDiscoID = ds_grid_get(unitGrid, unitGrid_colDiscoID, currentUnitID - 1);
			var currentUtteranceID = ds_grid_get(unitGrid, unitGrid_colUtteranceID, currentUnitID - 1);
			var currentWordIDList = ds_grid_get(unitGrid, unitGrid_colWordIDList, currentUnitID - 1);
		
			ds_grid_resize(quickFilterGrid, lineGridWidth, ds_grid_height(quickFilterGrid) + 1); 
			var currentRowFilterGrid = ds_grid_height(quickFilterGrid) - 1;
		
			ds_grid_set(quickFilterGrid, lineGrid_colDisplayRow, currentRowFilterGrid, currentRowFilterGrid);
			ds_grid_set(quickFilterGrid, lineGrid_colLineState, currentRowFilterGrid, 0);
			ds_grid_set(quickFilterGrid, lineGrid_colUnitID, currentRowFilterGrid, currentUnitID);
			ds_grid_set(quickFilterGrid, lineGrid_colPixelY, currentRowFilterGrid, currentRowFilterGrid * obj_control.gridSpaceVertical);
			ds_grid_set(quickFilterGrid, lineGrid_colPixelYOriginal, currentRowFilterGrid, currentRowFilterGrid * obj_control.gridSpaceVertical);
			ds_grid_set(quickFilterGrid, lineGrid_colDiscoID, currentRowFilterGrid, currentDiscoID);
			ds_grid_set(quickFilterGrid, lineGrid_colLineNumberLabel, currentRowFilterGrid, currentUtteranceID);
			ds_grid_set(quickFilterGrid, lineGrid_colWordIDList, currentRowFilterGrid, currentWordIDList);
		}
	
	}


	// Set filter to Tween Context
	if (obj_panelPane.functionFilter_peek[1] == 1) {	
		for (var i = firstUnit; i < lastUnit; i++) {
			var currentUnitID = ds_grid_get(unitGrid, unitGrid_colUnitID, i);
		
			if (ds_grid_value_exists(quickFilterGrid, lineGrid_colUnitID, 0, lineGrid_colUnitID, ds_grid_height(quickFilterGrid), currentUnitID)) {
				continue;
			}
		
			var currentDiscoID = ds_grid_get(unitGrid, unitGrid_colDiscoID, currentUnitID - 1);
			var currentUtteranceID = ds_grid_get(unitGrid, unitGrid_colUtteranceID, currentUnitID - 1);
			var currentWordIDList = ds_grid_get(unitGrid, unitGrid_colWordIDList, currentUnitID - 1);
		
			ds_grid_resize(quickFilterGrid, lineGridWidth, ds_grid_height(quickFilterGrid) + 1);
			var currentRowFilterGrid = ds_grid_height(quickFilterGrid) - 1;
		
			ds_grid_set(quickFilterGrid, lineGrid_colDisplayRow, currentRowFilterGrid, currentRowFilterGrid);
			ds_grid_set(quickFilterGrid, lineGrid_colLineState, currentRowFilterGrid, 0);
			ds_grid_set(quickFilterGrid, lineGrid_colUnitID, currentRowFilterGrid, currentUnitID);
			ds_grid_set(quickFilterGrid, lineGrid_colPixelY, currentRowFilterGrid, currentRowFilterGrid * obj_control.gridSpaceVertical);
			ds_grid_set(quickFilterGrid, lineGrid_colPixelYOriginal, currentRowFilterGrid, currentRowFilterGrid * obj_control.gridSpaceVertical);
			ds_grid_set(quickFilterGrid, lineGrid_colDiscoID, currentRowFilterGrid, currentDiscoID);
			ds_grid_set(quickFilterGrid, lineGrid_colLineNumberLabel, currentRowFilterGrid, currentUtteranceID);
			ds_grid_set(quickFilterGrid, lineGrid_colWordIDList, currentRowFilterGrid, currentWordIDList);
		}
		
	}

	// Set filter to Next Context
	if (obj_panelPane.functionFilter_peek[2] == 1) {
		var unitGridHeight = ds_grid_height(unitGrid);
		for (var i = lastUnit; i < unitGridHeight; i++) {
			var currentUnitID = ds_grid_get(unitGrid, unitGrid_colUnitID, i);
		
			if (ds_grid_value_exists(quickFilterGrid, lineGrid_colUnitID, 0, lineGrid_colUnitID, ds_grid_height(quickFilterGrid), currentUnitID)) {
				continue;
			}
		
			var currentDiscoID = ds_grid_get(unitGrid, unitGrid_colDiscoID, currentUnitID - 1);
			var currentUtteranceID = ds_grid_get(unitGrid, unitGrid_colUtteranceID, currentUnitID - 1);
			var currentWordIDList = ds_grid_get(unitGrid, unitGrid_colWordIDList, currentUnitID - 1);
		
			ds_grid_resize(quickFilterGrid, lineGridWidth, ds_grid_height(quickFilterGrid) + 1);
			var currentRowFilterGrid = ds_grid_height(quickFilterGrid) - 1;
		
			ds_grid_set(quickFilterGrid, lineGrid_colDisplayRow, currentRowFilterGrid, currentRowFilterGrid);
			ds_grid_set(quickFilterGrid, lineGrid_colLineState, currentRowFilterGrid, 0);
			ds_grid_set(quickFilterGrid, lineGrid_colUnitID, currentRowFilterGrid, currentUnitID);
			ds_grid_set(quickFilterGrid, lineGrid_colPixelY, currentRowFilterGrid, currentRowFilterGrid * obj_control.gridSpaceVertical);
			ds_grid_set(quickFilterGrid, lineGrid_colPixelYOriginal, currentRowFilterGrid, currentRowFilterGrid * obj_control.gridSpaceVertical);
			ds_grid_set(quickFilterGrid, lineGrid_colDiscoID, currentRowFilterGrid, currentDiscoID);
			ds_grid_set(quickFilterGrid, lineGrid_colLineNumberLabel, currentRowFilterGrid, currentUtteranceID);
			ds_grid_set(quickFilterGrid, lineGrid_colWordIDList, currentRowFilterGrid, currentWordIDList);
		}
	}

	// Sort filterGrid again
	ds_grid_sort(quickFilterGrid, lineGrid_colUnitID, true);
	var filterGridHeight = ds_grid_height(quickFilterGrid);
	for (var i = 0; i < filterGridHeight; i++) {
		ds_grid_set(quickFilterGrid, lineGrid_colDisplayRow, i, i);
		ds_grid_set(quickFilterGrid, lineGrid_colPixelY, i, i * obj_control.gridSpaceVertical);
		ds_grid_set(quickFilterGrid, lineGrid_colPixelYOriginal, i, i * obj_control.gridSpaceVertical);
	}
	
	


	quickFilterGridActive = true;
	currentActiveLineGrid = quickFilterGrid;
	wordLeftMarginDest = 170; // Make sure the margin is placed correctly

}

