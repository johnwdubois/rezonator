function scr_renderFilter() {
	/*
		scr_renderFilter();
	
		Last Updated: 2018-09-11
	
		Called from: obj_control
	
		Purpose: clear and then populate filterGrid with necessary units
	
		Mechanism: check all chains to see if they are flagged with the filter option, and if they are
					then add a row to the filterGrid
	
		Author: Terry DuBois, Georgio Klironomos
	*/
	
	show_debug_message("scr_renderFilter()");

	ds_grid_destroy(filterGrid);
	filterGrid = ds_grid_create(lineGridWidth, 0);

	// get lists of all types of chains
	var rezChainList = ds_map_find_value(global.nodeMap, "rezChainList");
	var trackChainList = ds_map_find_value(global.nodeMap, "trackChainList");
	var stackChainList = ds_map_find_value(global.nodeMap, "stackChainList");
	var listOfChains = -1;
	
	// find all the chains that are filtered
	for (var i = 0; i < 3; i++) {
	
		switch (i) {
			case 0:
				listOfChains = rezChainList;
				break;
			case 1:
				listOfChains = trackChainList;
				break;
			case 2:
				listOfChains = stackChainList;
				break;
			default:
				break;
		}
		
		// loop through current chainList to include chains marked with filter
		var listOfChainsSize = ds_list_size(listOfChains);
		if (listOfChainsSize < 1) {
			continue;	
		}
		
		for (var j = 0; j < listOfChainsSize; j++) {
			
			// get submap for current chain and make sure it exists
			var currentChain = ds_list_find_value(listOfChains, j);
			var currentChainSubMap = ds_map_find_value(global.nodeMap, currentChain);
			if (!is_numeric(currentChainSubMap)) continue;
			if (!ds_exists(currentChainSubMap, ds_type_map)) continue;
			var currentChainType = ds_map_find_value(currentChainSubMap, "type");
			
			// check if this chain is filtered
			var isFiltered = ds_map_find_value(currentChainSubMap, "filter");
			
			show_debug_message("scr_renderFilter() ... currentChain: " + string(currentChain) + ", isFiltered: " + string(isFiltered));
			
			// if this chain is focused but not filtered, and newWordInFilter is false, then unfocus it
			if (!isFiltered) {
				if (obj_chain.currentFocusedChainID == currentChain) {
					// Unfocus chains only if we aren't adding a chunk to a chain within the FilterView
					if (obj_toolPane.newWordInFilter) {
						obj_toolPane.newWordInFilter = false;	
					}
					else {
						obj_chain.currentFocusedChainID = "";
					}
				}
				continue;
			}
			
			// get set list for this chain
			var currentSetIDList = ds_map_find_value(currentChainSubMap, "setIDList");
			var currentSetIDListSize = ds_list_size(currentSetIDList);
		
			// set information in filterGrid for words in this chain
			for (var k = 0; k < currentSetIDListSize; k++) {
				
				// get currentEntry and make sure it exists
				var currentEntry = ds_list_find_value(currentSetIDList, k);
				var currentEntrySubMap = ds_map_find_value(global.nodeMap, currentEntry);
				if (!is_numeric(currentEntrySubMap)) continue;
				if (!ds_exists(currentEntrySubMap, ds_type_map)) continue;
				
				// get word/unit ID for this entry
				var currentWordID = -1;
				var currentUnitID = -1;
				if (currentChainType == "stackChain") {
					currentUnitID = ds_map_find_value(currentEntrySubMap, "unit");
				}
				else {
					currentWordID = ds_map_find_value(currentEntrySubMap, "word");
					currentUnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWordID - 1);
				}
				
				show_debug_message("scr_renderFilter() ... currentEntry: " + string(currentEntry) + ", currentUnitID: " + string(currentUnitID) + ", currentWordID: " + string(currentWordID));
				
				// determine if this unit is already in the filter grid (in which case we aren't going to add it again)
				var unitInFilterGrid = ds_grid_value_exists(filterGrid, lineGrid_colUnitID, 0, lineGrid_colUnitID, ds_grid_height(filterGrid), currentUnitID);
				if (unitInFilterGrid) {
					continue;
				}
			
				var currentWordIDListUnitGrid = ds_grid_get(unitGrid, unitGrid_colWordIDList, currentUnitID - 1);
				var currentDiscoID = ds_grid_get(unitGrid, unitGrid_colDiscoID, currentUnitID - 1);
				var currentUtteranceID = ds_grid_get(unitGrid, unitGrid_colUtteranceID, currentUnitID - 1);
			
				ds_grid_resize(filterGrid, lineGridWidth, ds_grid_height(filterGrid) + 1);
				var currentRowFilterGrid = ds_grid_height(filterGrid) - 1;
			
				ds_grid_set(filterGrid, lineGrid_colDisplayRow, currentRowFilterGrid, currentRowFilterGrid);
				ds_grid_set(filterGrid, lineGrid_colLineState, currentRowFilterGrid, 0);
				ds_grid_set(filterGrid, lineGrid_colUnitID, currentRowFilterGrid, currentUnitID);
				ds_grid_set(filterGrid, lineGrid_colPixelY, currentRowFilterGrid, (currentRowFilterGrid * obj_control.gridSpaceVertical));
				ds_grid_set(filterGrid, lineGrid_colPixelYOriginal, currentRowFilterGrid, (currentRowFilterGrid * obj_control.gridSpaceVertical));
				ds_grid_set(filterGrid, lineGrid_colDiscoID, currentRowFilterGrid, currentDiscoID);
				ds_grid_set(filterGrid, lineGrid_colLineNumberLabel, currentRowFilterGrid, currentUtteranceID);
				ds_grid_set(filterGrid, lineGrid_colWordIDList, currentRowFilterGrid, currentWordIDListUnitGrid);
			}
		}
	}




	// sort filterGrid
	ds_grid_sort(filterGrid, lineGrid_colUnitID, true);
	var filterGridHeight = ds_grid_height(filterGrid);
	for (var i = 0; i < filterGridHeight; i++) {
		ds_grid_set(filterGrid, lineGrid_colDisplayRow, i, i);
	}

	var firstUnit = ds_grid_get(filterGrid, lineGrid_colUnitID, 0);
	var lastUnit = ds_grid_get(filterGrid, lineGrid_colUnitID, ds_grid_height(filterGrid) - 1);

	if (firstUnit == undefined or lastUnit == undefined) { // If there's no units to be filtered, hop back to the main screen

		// If filter is active, deactivate it
		if (obj_control.filterGridActive) {
			if(obj_control.currentCenterDisplayRow >= 0) { // Make sure the current center display row is within bounds
				// Keep the focus on previous currentCenterDisplayRow
				with (obj_control) {
					alarm[5] = 3;
				}
			}
		}
		// Switch to active grid
		obj_control.filterGridActive = false;
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
		
			if (ds_grid_value_exists(filterGrid, lineGrid_colUnitID, 0, lineGrid_colUnitID, ds_grid_height(filterGrid), currentUnitID)) {
				continue;
			}
			
			if (currentUnitID == undefined or !is_numeric(currentUnitID)) { // If there's no units to be filtered, hop back to the main screen

				// If filter is active, deactivate it
				if (obj_control.filterGridActive) {
					if(obj_control.currentCenterDisplayRow >= 0) { // Make sure the current center display row is within bounds
						// Keep the focus on previous currentCenterDisplayRow
						with (obj_control) {
							alarm[5] = 3;
						}
					}
				}
				// Switch to active grid
				obj_control.filterGridActive = false;
				obj_control.currentActiveLineGrid = obj_control.lineGrid;
				exit;
			}
			
			var currentDiscoID = ds_grid_get(unitGrid, unitGrid_colDiscoID, currentUnitID - 1);
			var currentUtteranceID = ds_grid_get(unitGrid, unitGrid_colUtteranceID, currentUnitID - 1);
			var currentWordIDList = ds_grid_get(unitGrid, unitGrid_colWordIDList, currentUnitID - 1);
		
			ds_grid_resize(filterGrid, lineGridWidth, ds_grid_height(filterGrid) + 1); 
			var currentRowFilterGrid = ds_grid_height(filterGrid) - 1;
		
			ds_grid_set(filterGrid, lineGrid_colDisplayRow, currentRowFilterGrid, currentRowFilterGrid);
			ds_grid_set(filterGrid, lineGrid_colLineState, currentRowFilterGrid, 0);
			ds_grid_set(filterGrid, lineGrid_colUnitID, currentRowFilterGrid, currentUnitID);
			ds_grid_set(filterGrid, lineGrid_colPixelY, currentRowFilterGrid, currentRowFilterGrid * obj_control.gridSpaceVertical);
			ds_grid_set(filterGrid, lineGrid_colPixelYOriginal, currentRowFilterGrid, currentRowFilterGrid * obj_control.gridSpaceVertical);
			ds_grid_set(filterGrid, lineGrid_colDiscoID, currentRowFilterGrid, currentDiscoID);
			ds_grid_set(filterGrid, lineGrid_colLineNumberLabel, currentRowFilterGrid, currentUtteranceID);
			ds_grid_set(filterGrid, lineGrid_colWordIDList, currentRowFilterGrid, currentWordIDList);
		}
	
	}


	// Set filter to Tween Context
	if (obj_panelPane.functionFilter_peek[1] == 1) {	
		for (var i = firstUnit; i < lastUnit; i++) {
			var currentUnitID = ds_grid_get(unitGrid, unitGrid_colUnitID, i);
		
			if (ds_grid_value_exists(filterGrid, lineGrid_colUnitID, 0, lineGrid_colUnitID, ds_grid_height(filterGrid), currentUnitID)) {
				continue;
			}
		
			var currentDiscoID = ds_grid_get(unitGrid, unitGrid_colDiscoID, currentUnitID - 1);
			var currentUtteranceID = ds_grid_get(unitGrid, unitGrid_colUtteranceID, currentUnitID - 1);
			var currentWordIDList = ds_grid_get(unitGrid, unitGrid_colWordIDList, currentUnitID - 1);
		
			ds_grid_resize(filterGrid, lineGridWidth, ds_grid_height(filterGrid) + 1);
			var currentRowFilterGrid = ds_grid_height(filterGrid) - 1;
		
			ds_grid_set(filterGrid, lineGrid_colDisplayRow, currentRowFilterGrid, currentRowFilterGrid);
			ds_grid_set(filterGrid, lineGrid_colLineState, currentRowFilterGrid, 0);
			ds_grid_set(filterGrid, lineGrid_colUnitID, currentRowFilterGrid, currentUnitID);
			ds_grid_set(filterGrid, lineGrid_colPixelY, currentRowFilterGrid, currentRowFilterGrid * obj_control.gridSpaceVertical);
			ds_grid_set(filterGrid, lineGrid_colPixelYOriginal, currentRowFilterGrid, currentRowFilterGrid * obj_control.gridSpaceVertical);
			ds_grid_set(filterGrid, lineGrid_colDiscoID, currentRowFilterGrid, currentDiscoID);
			ds_grid_set(filterGrid, lineGrid_colLineNumberLabel, currentRowFilterGrid, currentUtteranceID);
			ds_grid_set(filterGrid, lineGrid_colWordIDList, currentRowFilterGrid, currentWordIDList);
		}
		
	}

	// Set filter to Next Context
	if (obj_panelPane.functionFilter_peek[2] == 1) {
		var unitGridHeight = ds_grid_height(unitGrid);
		for (var i = lastUnit; i < unitGridHeight; i++) {
			var currentUnitID = ds_grid_get(unitGrid, unitGrid_colUnitID, i);
		
			if (ds_grid_value_exists(filterGrid, lineGrid_colUnitID, 0, lineGrid_colUnitID, ds_grid_height(filterGrid), currentUnitID)) {
				continue;
			}
		
			var currentDiscoID = ds_grid_get(unitGrid, unitGrid_colDiscoID, currentUnitID - 1);
			var currentUtteranceID = ds_grid_get(unitGrid, unitGrid_colUtteranceID, currentUnitID - 1);
			var currentWordIDList = ds_grid_get(unitGrid, unitGrid_colWordIDList, currentUnitID - 1);
		
			ds_grid_resize(filterGrid, lineGridWidth, ds_grid_height(filterGrid) + 1);
			var currentRowFilterGrid = ds_grid_height(filterGrid) - 1;
		
			ds_grid_set(filterGrid, lineGrid_colDisplayRow, currentRowFilterGrid, currentRowFilterGrid);
			ds_grid_set(filterGrid, lineGrid_colLineState, currentRowFilterGrid, 0);
			ds_grid_set(filterGrid, lineGrid_colUnitID, currentRowFilterGrid, currentUnitID);
			ds_grid_set(filterGrid, lineGrid_colPixelY, currentRowFilterGrid, currentRowFilterGrid * obj_control.gridSpaceVertical);
			ds_grid_set(filterGrid, lineGrid_colPixelYOriginal, currentRowFilterGrid, currentRowFilterGrid * obj_control.gridSpaceVertical);
			ds_grid_set(filterGrid, lineGrid_colDiscoID, currentRowFilterGrid, currentDiscoID);
			ds_grid_set(filterGrid, lineGrid_colLineNumberLabel, currentRowFilterGrid, currentUtteranceID);
			ds_grid_set(filterGrid, lineGrid_colWordIDList, currentRowFilterGrid, currentWordIDList);
		}
	}

	// Sort filterGrid again
	ds_grid_sort(filterGrid, lineGrid_colUnitID, true);
	var filterGridHeight = ds_grid_height(filterGrid);
	for (var i = 0; i < filterGridHeight; i++) {
		ds_grid_set(filterGrid, lineGrid_colDisplayRow, i, i);
		ds_grid_set(filterGrid, lineGrid_colPixelY, i, i * obj_control.gridSpaceVertical);
		ds_grid_set(filterGrid, lineGrid_colPixelYOriginal, i, i * obj_control.gridSpaceVertical);
	}



	if (searchGridActive) {
		searchGridActive = false;
		obj_toolPane.currentMode = obj_toolPane.setModeMain;	
	}
	filterGridActive = true;
	currentActiveLineGrid = filterGrid;
	wordLeftMarginDest = 170; // Make sure the margin is placed correctly
	with (obj_alarm) {
		alarm[1] = 5;
	}


}
