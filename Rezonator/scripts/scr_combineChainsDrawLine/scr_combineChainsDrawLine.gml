// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_combineChainsDrawLine(){
	
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

}