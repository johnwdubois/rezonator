// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_combineChains(mouseoverWordID){
	
	var grid = obj_chain.rezChainGrid;
	with(obj_panelPane){
		if (currentFunction == functionChainList) {
			// Based on user selection, get the grid of the current tab
			switch (functionChainList_currentTab) {
				case functionChainList_tabRezBrush:
					grid = obj_chain.rezChainGrid;
					break;
				case functionChainList_tabTrackBrush:
					grid = obj_chain.trackChainGrid;
					break;
				case functionChainList_tabStackBrush:
					grid = obj_chain.stackChainGrid;
					break;
				case functionChainList_tabClique:
					grid = obj_chain.cliqueDisplayGrid;
					break;
				default:
					grid = obj_chain.rezChainGrid;
					break;
			}
		}
	}
	
	//find current selected chain, ie starting chain that will be added to				
	var currentChainfocusedChainRow = ds_grid_value_y(grid, obj_chain.chainGrid_colChainState, 0, obj_chain.chainGrid_colChainState, ds_grid_height(grid), obj_chain.chainStateFocus);
	
	//find next selected chain, ie the chain that will be delted and merged into the other chain
	var selectedChainfocusedChainRow = -1;
	var inChainsList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInChainList, mouseoverWordID - 1);
	var inChainsListSize = ds_list_size(inChainsList);
	for (var i = 0; i < inChainsListSize; i++) {
		var currentChainID = ds_list_find_value(inChainsList, i);
		var chainIDRow = ds_grid_value_y(grid, obj_chain.chainGrid_colChainID, 0, obj_chain.chainGrid_colChainID, ds_grid_height(grid) , currentChainID);
		if(chainIDRow != -1){
			selectedChainfocusedChainRow = chainIDRow;
			break;
		}
	}
	
	//show_message("row of current chain: " + string(currentChainfocusedChainRow) + "row of next chain: " + string(selectedChainfocusedChainRow));
		
	if (selectedChainfocusedChainRow == -1 or currentChainfocusedChainRow == -1){
		//show_message("selected chain row is -1 exiting merge")
		obj_control.combineChains = false;
		exit;
	}
	

		
	var selectedChainID = ds_grid_get(grid, obj_chain.chainGrid_colChainID, selectedChainfocusedChainRow);
	var currentChainID = ds_grid_get(grid, obj_chain.chainGrid_colChainID, currentChainfocusedChainRow);
	
	
		
	////store WID list for future
	var selectedIDList = ds_grid_get(grid, obj_chain.chainGrid_colWordIDList, selectedChainfocusedChainRow);
	var currentIDList = ds_grid_get(grid, obj_chain.chainGrid_colWordIDList, currentChainfocusedChainRow);
	var selectedIDListSize = ds_list_size(selectedIDList);
	var sizeOfCurrentIDList = ds_list_size(currentIDList);
	
	// combine the two ID lists!
	/*
	var combinedIDList = ds_list_create();
	ds_list_copy(combinedIDList, selectedIDList);
	for (var i = 0; i < sizeOfCurrentIDList; i++) {
		var currentID = ds_list_find_value(currentIDList, i);
		if (ds_list_find_index(combinedIDList, currentID) == -1) {
			ds_list_add(combinedIDList, currentID);
		}
	}
	*/
	
	//show_message("selectedIDList: " + scr_getStringOfList(selectedIDList) + " ... " + "currentIDList: " + scr_getStringOfList(currentIDList));
		
	////show_message(scr_getStringOfList(wIDList) + "      also here is the selected chain ID:   " + string(selectedChainID))
	scr_unFocusAllChains();
	
	
	scr_deleteChainExperimental(selectedChainID);
	

	
	
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

}