// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_combineChains(focusedChain, clickedChain){
	
	show_debug_message("scr_combineChains: " + string(focusedChain) + ", " + string(clickedChain));
	
	// get the submaps for our chains and make sure they exist
	var focusedChainSubMap = ds_map_find_value(global.nodeMap, focusedChain);
	var clickedChainSubMap = ds_map_find_value(global.nodeMap, clickedChain);
	if (!is_numeric(focusedChainSubMap)) exit;
	if (!ds_exists(focusedChainSubMap, ds_type_map)) exit;
	if (!is_numeric(clickedChainSubMap)) exit;
	if (!ds_exists(clickedChainSubMap, ds_type_map)) exit;
	
	// make sure the chains are the same type
	var focusedChainType = ds_map_find_value(focusedChainSubMap, "type");
	var clickedChainType = ds_map_find_value(clickedChainSubMap, "type");
	if (focusedChainType != clickedChainType) {
		show_debug_message("scr_combineChains() ... chains are not the same type!");
		exit;
	}
	
	// make a temporary list of the words/units in the clicked chain
	var tempList = ds_list_create();
	var clickedChainSetIDList = ds_map_find_value(clickedChainSubMap, "setIDList");
	var clickedChainSetIDListSize = ds_list_size(clickedChainSetIDList);
	for (var i = 0; i < clickedChainSetIDListSize; i++) {
		var currentEntry = ds_list_find_value(clickedChainSetIDList, i);
		var currentEntrySubMap = ds_map_find_value(global.nodeMap, currentEntry);
		var currentWordOrUnit = ds_map_find_value(currentEntrySubMap, (focusedChainType == "stackChain") ? "unit" : "word");
		if (ds_list_find_index(tempList, currentWordOrUnit) == -1) {
			ds_list_add(tempList, currentWordOrUnit);
		}
	}
	
	// delete the clicked chain
	scr_deleteChain(clickedChain);
	
	// add the words that were in the clicked chain to the focused chain
	show_debug_message("scr_combineChains() ... tempList: " + scr_getStringOfList(tempList));
	var tempListSize = ds_list_size(tempList);
	for (var i = 0; i < tempListSize; i++) {
		var currentWordOrUnit = ds_list_find_value(tempList, i);
		with (obj_chain) {
			currentFocusedChainID = focusedChain;
			
			// if this is a stack, let's get it's first wordID
			if (focusedChainType == "stackChain") {
				var wordIDList = ds_grid_get(obj_control.unitGrid, obj_control.unitGrid_colWordIDList, currentWordOrUnit - 1);
				if (ds_list_size(wordIDList) > 0) {
					currentWordOrUnit = ds_list_find_value(wordIDList, 0);
				}
				else {
					continue;
				}
			}
			
			scr_newLink(currentWordOrUnit);
		}
	}
	
	
	
	ds_list_destroy(tempList);
	

	/*
	var grid = obj_chain.rezChainGrid;
	with(obj_panelPane){
		if (currentFunction == functionChainList) {
			// Based on user selection, get the grid of the current tab
			switch (functionChainList_currentTab) {
				case functionChainList_tabRezBrush:
					grid = obj_chain.rezChainGrid;
					show_debug_message("scr_combineChains()... grid: rezChainGrid");
					break;
				case functionChainList_tabTrackBrush:
					grid = obj_chain.trackChainGrid;
					show_debug_message("scr_combineChains()... grid: trackChainGrid");
					break;
				case functionChainList_tabStackBrush:
					grid = obj_chain.stackChainGrid;
					show_debug_message("scr_combineChains()... grid: stackChainGrid");
					break;
				case functionChainList_tabClique:
					grid = obj_chain.cliqueDisplayGrid;
					show_debug_message("scr_combineChains()... grid: cliqueDisplayGrid");
					break;
				default:
					grid = obj_chain.rezChainGrid;
					show_debug_message("scr_combineChains()... could not find grid, defaulting to rezChainGrid");
					break;
			}
		}
	}
	
	//find current selected chain, ie starting chain that will be added to				
	var currentChainfocusedChainRow = ds_grid_value_y(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(grid), obj_chain.chainStateFocus);
	
	
	// find next selected chain, ie the chain that will be deleted and merged into the other chain
	// if this is a rezChain or trackChain, we'll get the chainID from the inChainsList from the dynamicWordGrid
	// if this is a stackChain, we'll get the chainID from the unitInStackGrid
	var selectedChainfocusedChainRow = -1;
	var chainIDRow = -1;
	if (grid == obj_chain.rezChainGrid || grid == obj_chain.trackChainGrid) {
		var inChainsList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInChainList, mouseoverWordID - 1);
		var inChainsListSize = ds_list_size(inChainsList);
		for (var i = 0; i < inChainsListSize; i++) {
			var currentChainID = ds_list_find_value(inChainsList, i);
			chainIDRow = ds_grid_value_y(grid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(grid) , currentChainID);
			if (chainIDRow != -1) {
				break;
			}
		}
	}
	else if (grid == obj_chain.stackChainGrid) {
		var unitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, mouseoverWordID);
		var currentChainID = ds_grid_get(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStack, unitID - 1);
		chainIDRow = ds_grid_value_y(grid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(grid) , currentChainID);
	}
	if (chainIDRow != -1){
		selectedChainfocusedChainRow = chainIDRow;
	}
	
	
	if (selectedChainfocusedChainRow == -1 or currentChainfocusedChainRow == -1
	or selectedChainfocusedChainRow == currentChainfocusedChainRow) {
		show_debug_message("scr_combineChains()... selectedChainfocusedChainRow == -1 or currentChainfocusedChainRow == -1, or they are equal,  exiting...");
		exit;
	}
	

		
	var selectedChainID = ds_grid_get(grid, obj_chain.chainGrid_colChainID, selectedChainfocusedChainRow);
	var currentChainID = ds_grid_get(grid, obj_chain.chainGrid_colChainID, currentChainfocusedChainRow);
	
	
		
	// store WID list for future
	var selectedIDList = ds_grid_get(grid, obj_chain.chainGrid_colWordIDList, selectedChainfocusedChainRow);
	var currentIDList = ds_grid_get(grid, obj_chain.chainGrid_colWordIDList, currentChainfocusedChainRow);
	var selectedIDListSize = ds_list_size(selectedIDList);
	var sizeOfCurrentIDList = ds_list_size(currentIDList);
		

	scr_unFocusAllChains();
	
	scr_deleteChain(selectedChainID);
	

	
	
	//refocus the orginal chain
	var currentChainfocusedChainRow = ds_grid_value_y(grid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(grid), currentChainID);
	ds_grid_set(grid, obj_chain.chainGrid_colChainState, currentChainfocusedChainRow, obj_chain.chainStateFocus);
	
	
	for (var i = 0; i < selectedIDListSize; i++) {
		
		if (obj_toolPane.currentTool == obj_toolPane.toolStackBrush) {
			var currentUnitID = ds_list_find_value(selectedIDList, i);
			var currentWordIDList = ds_grid_get(obj_control.unitGrid,obj_control.unitGrid_colWordIDList, currentUnitID - 1);
			var currentWordID = ds_list_find_value(currentWordIDList, 0);
		}
		else {
			var currentWordID = ds_list_find_value(selectedIDList, i);
			var currentUnitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWordID - 1);
		}
		with (obj_chain) {
			scr_wordClicked(currentWordID, currentUnitID);
		}
	}
	*/
	
	
	
	

}