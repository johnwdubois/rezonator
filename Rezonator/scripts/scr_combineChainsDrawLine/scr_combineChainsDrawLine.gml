// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_combineChainsDrawLine(inChainsList){
	
	/*
	// find next selected chain, ie the chain that will be deleted and merged into the other chain
	// if this is a rezChain or trackChain, we'll get the chainID from the inChainsList from the dynamicWordGrid
	// if this is a stackChain, we'll get the chainID from the unitInStackGrid
	var currentFocusedChainSubMap = ds_map_find_value(global.nodeMap, obj_chain.currentFocusedChainID);
	var currentFocusedChainType = ds_map_find_value(global.nodeMap, "type");
	var selectedChainfocusedChainRow = -1;
	var currentChainID = "";
	if (currentFocusedChainType == "rezChain" || currentFocusedChainType == "trackChain") {
		var inChainsList = ds_grid_get(obj_control.dynamicWordGrid, obj_control.dynamicWordGrid_colInChainList, currentWordID - 1);
		var inChainsListSize = ds_list_size(inChainsList);
		for (var i = 0; i < inChainsListSize; i++) {
			currentChainID = ds_list_find_value(inChainsList, i);
			var currentChainIDSubMap = ds_map_find_value(global.nodeMap, currentChainID);
			var currentChainType = ds_map_find_value(currentChainIDSubMap, "type");
								
			if (currentFocusedChainType == currentChainType) {
				break;
			}
		}
	}
	else if (currentFocusedChainType == "stackChain") {
		var unitID = ds_grid_get(obj_control.wordGrid, obj_control.wordGrid_colUnitID, currentWordID);
		currentChainID = ds_grid_get(obj_chain.unitInStackGrid, obj_chain.unitInStackGrid_colStack, unitID - 1);
	}
						
	if (chainIDRow != -1){
		selectedChainfocusedChainRow = chainIDRow;
	}
	
	
	if (selectedChainfocusedChainRow == -1 or currentChainfocusedChainRow == -1
	or selectedChainfocusedChainRow == currentChainfocusedChainRow) {
		show_debug_message("scr_combineChains()... selectedChainfocusedChainRow == -1 or currentChainfocusedChainRow == -1, or they are equal,  exiting...");
		exit;
	}
						
	

	
	
	
	
	
		
	// store WID list for future
	var selectedIDList = ds_grid_get(grid, obj_chain.chainGrid_colWordIDList, selectedChainfocusedChainRow);
	var selectedIDListSize = ds_list_size(selectedIDList);

						
	if ( selectedIDListSize == 1 ){
		obj_control.clickedWordID = currentWordID;
		scr_combineChains(currentWordID);
	}
	else{
		obj_control.clickedWordID = currentWordID;
		obj_control.stackMerged = true;
		with(obj_alarm){
			alarm[9] = 3;
		}
	}
	*/
	
	// make sure that the focused chain is not in the inChainsList
	if (ds_list_find_index(inChainsList, obj_chain.currentFocusedChainID) >= 0) {
		show_debug_message("scr_combineChainsDrawLine() ... hoverWord is in focused chain. Exiting...");
		exit;
	}
	
	// get inChainsListSize and submap of focusedChain
	var inChainsListSize = ds_list_size(inChainsList);
	var focusedChainSubMap = ds_map_find_value(global.nodeMap, obj_chain.currentFocusedChainID);
	
	// make sure focusedChain exists
	if (!is_numeric(focusedChainSubMap)) exit;
	if (!ds_exists(focusedChainSubMap, ds_type_map)) exit;
	
	// next, we need to see if the hoverWord has a chain of the same type as the currently focused chain
	var focusedChainType = ds_map_find_value(focusedChainSubMap, "type");
	var chainToCombine = "";
	var selectedChainEntryListSize = 0;
	for (var i = 0; i < inChainsListSize; i++) {
		var currentChain = ds_list_find_value(inChainsList, i);
		var currentChainSubMap = ds_map_find_value(global.nodeMap, currentChain);
		var currentChainType = ds_map_find_value(currentChainSubMap, "type");
		if (currentChainType == focusedChainType) {
			chainToCombine = currentChain;
			var entryList = ds_map_find_value(currentChainSubMap, "setIDList");
			selectedChainEntryListSize = ds_list_size(entryList);
			break;
		}
	}
	
	if (chainToCombine == "" || !ds_map_exists(global.nodeMap, chainToCombine)) {
		show_debug_message("scr_combineChainsDrawLine() ... chainToCombine was not found or does not exist. Exiting...");
		exit;
	}
	
	// if the selected chain just has 1 entry, we will combine it with no questions asked...
	// but if the selected chain is longer than 1 entry, we will ask before combining
	if (selectedChainEntryListSize == 1) {
		scr_combineChains(obj_chain.currentFocusedChainID, chainToCombine);
	}
	else if (selectedChainEntryListSize > 1) {
		// set variables in obj_control so that we can keep the information while the question box is showing
		with (obj_control) {
			combineChainsFocused = obj_chain.currentFocusedChainID;
			combineChainsSelected = chainToCombine;
		}
		
		// call alarm to show question box
		with(obj_alarm){
			alarm[9] = 3;
		}
	}
	
	
}