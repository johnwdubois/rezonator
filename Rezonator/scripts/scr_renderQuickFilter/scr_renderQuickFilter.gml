function scr_renderQuickFilter() {
	/*
		scr_renderFilter();
	
		Last Updated: 2018-09-11
	
		Called from: obj_control
	
		Purpose: clear and then populate quickFilterGrid with necessary units
	
		Mechanism: check all chains to see if they are flagged with the filter option, and if they are
					then add a row to the quickFilterGrid
	
		Author: Terry DuBois, Georgio Klironomos
	*/
	
	if (obj_chain.currentFocusedChainID == "" || !is_string(obj_chain.currentFocusedChainID) || instance_exists(obj_dialogueBox)) {
		exit;
	}
	
	// get submap of focused chain
	var chainSubMap = ds_map_find_value(global.nodeMap, obj_chain.currentFocusedChainID);
	if (!is_numeric(chainSubMap)) exit;
	if (!ds_exists(chainSubMap, ds_type_map)) exit;
	var chainType = ds_map_find_value(chainSubMap, "type");
	
	// reset quick filter grid
	ds_grid_destroy(quickFilterGrid);
	quickFilterGrid = ds_grid_create(lineGridWidth, 0);

	var rowInChainGrid = 0;	
	var setIDList = ds_map_find_value(chainSubMap, "setIDList");
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
			
			currentWordID = ds_map_find_value(currentEntrySubMap, "word");
			currentUnitID = ds_grid_get(wordGrid, wordGrid_colUnitID, currentWordID - 1);
			currentDisplayRow = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayRow, currentWordID - 1);
			
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
	
	
	
	
	
	
	
	

	


	/*		
	ds_list_sort(currentIDList, true);
	
	
		
	var currentUnitID = 0;	
	var currentWordID = 0;
	var currentDisplayRow = 0;

	if (grid == obj_chain.stackChainGrid or grid == obj_chain.cliqueDisplayGrid) {
		
		//currentUnitID = ds_list_find_value(currentIDList, k);
		// set information in quickFilterGrid for units in the stack chain
		var currentLineGridSize = ds_grid_height(obj_control.lineGrid);
		for (var i = 0; i < currentLineGridSize; i++) {
			
			var valueToCheck = ds_grid_get(obj_control.lineGrid,obj_control.lineGrid_colUnitID, i);
			
			if(ds_list_find_index(currentIDList,valueToCheck) != -1){

				var rowInLineGrid = i;
				var currentWordIDListUnitGrid = ds_grid_get(lineGrid, lineGrid_colWordIDList, rowInLineGrid);
				var currentDiscoID = ds_grid_get(lineGrid, lineGrid_colDiscoID, rowInLineGrid);
				var currentUtteranceID = ds_grid_get(lineGrid, lineGrid_colUnitID, rowInLineGrid);
		
				show_debug_message("UID:  " + string(currentUtteranceID) +"  ,rowInLineGrid:  " + string(rowInLineGrid) + "  ,currentWordIDListUnitGrid:  " + scr_getStringOfList(currentWordIDListUnitGrid) )
			
				ds_grid_resize(quickFilterGrid, lineGridWidth, ds_grid_height(quickFilterGrid) + 1);
				var currentRowquickFilterGrid = ds_grid_height(quickFilterGrid) - 1;
			
				ds_grid_set(quickFilterGrid, lineGrid_colDisplayRow, currentRowquickFilterGrid, currentRowquickFilterGrid);
				ds_grid_set(quickFilterGrid, lineGrid_colLineState, currentRowquickFilterGrid, 0);
				ds_grid_set(quickFilterGrid, lineGrid_colUnitID, currentRowquickFilterGrid, currentUtteranceID);
				ds_grid_set(quickFilterGrid, lineGrid_colPixelY, currentRowquickFilterGrid, (currentRowquickFilterGrid * obj_control.gridSpaceVertical));
				ds_grid_set(quickFilterGrid, lineGrid_colPixelYOriginal, currentRowquickFilterGrid, (currentRowquickFilterGrid * obj_control.gridSpaceVertical));
				ds_grid_set(quickFilterGrid, lineGrid_colDiscoID, currentRowquickFilterGrid, currentDiscoID);
				ds_grid_set(quickFilterGrid, lineGrid_colLineNumberLabel, currentRowquickFilterGrid, currentUtteranceID);
				ds_grid_set(quickFilterGrid, lineGrid_colWordIDList, currentRowquickFilterGrid, currentWordIDListUnitGrid);
				
			}
		}
	
	}
	else {

		// set information in quickFilterGrid for words in this chain
		var currentIDListSize = ds_list_size(currentIDList);
		for (var k = 0; k < currentIDListSize; k++) {
			
			currentWordID = ds_list_find_value(currentIDList, k);
			currentUnitID = ds_grid_get(wordGrid, wordGrid_colUnitID, currentWordID - 1);
			currentDisplayRow = ds_grid_get(dynamicWordGrid, dynamicWordGrid_colDisplayRow, currentWordID - 1);
			
			if (ds_grid_value_exists(quickFilterGrid, lineGrid_colUnitID, 0, lineGrid_colUnitID, ds_grid_height(quickFilterGrid), currentUnitID)) {
				continue;
			}

			
			var rowInLineGrid = ds_grid_value_y(lineGrid, lineGrid_colDisplayRow,0,lineGrid_colDisplayRow,ds_grid_height(lineGrid), currentDisplayRow )
			var currentWordIDListUnitGrid = ds_grid_get(lineGrid, lineGrid_colWordIDList, rowInLineGrid);
			var currentDiscoID = ds_grid_get(lineGrid, lineGrid_colDiscoID, rowInLineGrid);
			var currentUtteranceID = ds_grid_get(lineGrid, lineGrid_colUnitID, rowInLineGrid);
		
			show_debug_message("WID:  " + string(currentWordID) + "   ,currentDisplayRow:  " + string(currentDisplayRow) + "  ,rowInLineGrid:  " + string(rowInLineGrid) + "  ,currentWordIDListUnitGrid:  " + scr_getStringOfList(currentWordIDListUnitGrid) )
			
			ds_grid_resize(quickFilterGrid, lineGridWidth, ds_grid_height(quickFilterGrid) + 1);
			var currentRowquickFilterGrid = ds_grid_height(quickFilterGrid) - 1;
			
			ds_grid_set(quickFilterGrid, lineGrid_colDisplayRow, currentRowquickFilterGrid, currentRowquickFilterGrid);
			ds_grid_set(quickFilterGrid, lineGrid_colLineState, currentRowquickFilterGrid, 0);
			ds_grid_set(quickFilterGrid, lineGrid_colUnitID, currentRowquickFilterGrid, currentUnitID);
			ds_grid_set(quickFilterGrid, lineGrid_colPixelY, currentRowquickFilterGrid, (currentRowquickFilterGrid * obj_control.gridSpaceVertical));
			ds_grid_set(quickFilterGrid, lineGrid_colPixelYOriginal, currentRowquickFilterGrid, (currentRowquickFilterGrid * obj_control.gridSpaceVertical));
			ds_grid_set(quickFilterGrid, lineGrid_colDiscoID, currentRowquickFilterGrid, currentDiscoID);
			ds_grid_set(quickFilterGrid, lineGrid_colLineNumberLabel, currentRowquickFilterGrid, currentUnitID);
			ds_grid_set(quickFilterGrid, lineGrid_colWordIDList, currentRowquickFilterGrid, currentWordIDListUnitGrid);
		}
	}
	*/
	
	
	obj_control.quickPickedChainID = obj_chain.currentFocusedChainID;

	quickFilterGridActive = true;
	currentActiveLineGrid = quickFilterGrid;
	wordLeftMarginDest = 170; // Make sure the margin is placed correctly

	with (obj_alarm) {
		alarm[1] = 5;
	}

}

